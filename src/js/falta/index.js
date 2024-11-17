import { Toast } from "../funciones";
import DataTable from "datatables.net-bs5";
import { lenguaje } from "../lenguaje";

// Elementos del DOM
const tabla = document.getElementById('tablaFalta');
const filtroTipo = document.getElementById('filtroTipo');

// Inicializar DataTable
const datatable = new DataTable('#tablaFalta', {
    language: lenguaje,
    data: null,
    columns: [
        {
            title: 'No.',
            render: (data, type, row, meta) => meta.row + 1
        },
        {
            title: 'Tipo',
            data: 'tipo_nombre',
            render: (data) => {
                const clases = {
                    'LEVE': 'badge bg-info',
                    'GRAVE': 'badge bg-warning',
                    'GRAVISIMA': 'badge bg-danger'
                };
                return `<span class="${clases[data]}">${data}</span>`;
            }
        },
        {
            title: 'Categoría',
            data: 'categoria_nombre'
        },
        {
            title: 'Descripción',
            data: 'fal_descripcion'
        },
        {
            title: 'Sanción',
            render: (data, type, row) => {
                if (row.fal_horas_arresto) {
                    return `${row.fal_horas_arresto} horas de arresto`;
                } else if (row.fal_demeritos) {
                    return `${row.fal_demeritos} deméritos`;
                } else {
                    return 'BAJA';
                }
            }
        },
        {
            title: 'Acciones',
            data: 'fal_id',
            render: (data, type, row) => {
                return `
                    <button class='btn btn-danger btn-sm eliminar' data-id="${data}">
                        <i class='bi bi-trash'></i> Dar de Baja
                    </button>
                `;
            }
        }
    ],
    order: [[1, 'asc'], [2, 'asc']],  // Ordenar por tipo y categoría
    rowGroup: {
        dataSrc: ['tipo_nombre', 'categoria_nombre']
    }
});

// Función para buscar
const buscar = async () => {
    try {
        const url = "/control_arresto/API/falta/buscar";
        const config = {
            method: 'GET'
        };

        const respuesta = await fetch(url, config);
        const data = await respuesta.json();

        datatable.clear();
        
        if (data.datos) {
            datatable.rows.add(data.datos).draw();
        }

    } catch (error) {
        console.log(error);
    }
};

// Función para eliminar
const eliminar = async (e) => {
    const button = e.target.closest('button');
    const id = button.dataset.id;

    const result = await Swal.fire({
        title: '¿Está seguro?',
        text: "¿Desea dar de baja esta falta?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, dar de baja',
        cancelButtonText: 'Cancelar'
    });

    if (result.isConfirmed) {
        try {
            const body = new FormData();
            body.append('fal_id', id);
            const url = "/control_arresto/API/falta/eliminar";
            const config = {
                method: 'POST',
                body
            };

            const respuesta = await fetch(url, config);
            const data = await respuesta.json();

            const { codigo, mensaje } = data;
            let icon = codigo === 1 ? 'success' : 'error';

            Toast.fire({
                icon,
                title: mensaje
            });

            if (codigo === 1) {
                buscar();
            }

        } catch (error) {
            console.log(error);
        }
    }
};

// Filtro por tipo
filtroTipo.addEventListener('change', function() {
    const tipo = this.value;
    datatable.column(1).search(tipo).draw();
});

// Event Listeners
datatable.on('click', '.eliminar', eliminar);

// Cargar datos iniciales
buscar();