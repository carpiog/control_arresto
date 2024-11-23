import { Toast } from "../funciones";
import Swal from "sweetalert2";
import DataTable from "datatables.net-bs5";
import { lenguaje } from "../lenguaje";

// Elementos del DOM
const formulario = document.getElementById('formSancion');
const btnGuardar = document.getElementById('btnGuardar');
const btnModificar = document.getElementById('btnModificar');
const btnCancelar = document.getElementById('btnCancelar');
const selectFalta = document.getElementById('san_falta_id');

// Configuración inicial de botones
btnModificar.parentElement.style.display = 'none';
btnModificar.disabled = true;
btnCancelar.parentElement.style.display = 'none';
btnCancelar.disabled = true;

// Configurar fecha actual como máxima
const fechaSancion = document.getElementById('san_fecha_sancion');
fechaSancion.max = new Date().toISOString().split('T')[0];

// Inicialización del DataTable
const datatable = new DataTable('#tablaSancion', {
    language: lenguaje,
    pageLength: 15,
    order: [[3, 'desc']], // Ordenar por fecha de sanción descendente
    columns: [
        { 
            title: 'No.', 
            data: null, 
            width: '2%', 
            render: (data, type, row, meta) => meta.row + 1 
        },
        { title: 'Catálogo', data: 'san_catalogo' },
        { title: 'Alumno', data: 'alumno_nombre' },
        { 
            title: 'Fecha Sanción', 
            data: 'san_fecha_sancion', 
            render: (data) => new Date(data).toLocaleDateString('es-GT') 
        },
        { title: 'Falta', data: 'fal_descripcion' },
        { title: 'Horas Arresto', data: 'san_horas_arresto', render: (data) => data ? data : '-' },
        { title: 'Deméritos', data: 'san_demeritos', render: (data) => data ? data : '-' },
        { title: 'Instructor', data: 'instructor_nombre' },
        { 
            title: 'Acciones', 
            data: null, 
            orderable: false, 
            searchable: false, 
            render: (data, type, row) => `
                <button class='btn btn-warning btn-sm modificar' data-san_id="${row.san_id}" data-san_catalogo="${row.san_catalogo}" 
                        data-san_fecha_sancion="${row.san_fecha_sancion}" data-san_falta_id="${row.san_falta_id}" 
                        data-san_instructor_ordena="${row.san_instructor_ordena}" data-san_horas_arresto="${row.san_horas_arresto || ''}" 
                        data-san_demeritos="${row.san_demeritos || ''}" data-san_observaciones="${row.san_observaciones || ''}">
                    <i class='bi bi-pencil-square'></i> Modificar
                </button>
                <button class='btn btn-danger btn-sm eliminar' data-san_id="${row.san_id}">
                    <i class='bi bi-trash'></i> Eliminar
                </button>
            `
        }
    ]
});

// Función para buscar sanciones
const buscar = async () => {
    try {
        const response = await fetch("/control_arresto/API/sancion/buscar");
        const data = await response.json();
        datatable.clear();
        if (data.datos && Array.isArray(data.datos)) {
            datatable.rows.add(data.datos).draw();
        }
    } catch (error) {
        console.error('Error:', error);
        Toast.fire({
            icon: 'error',
            title: 'Error al cargar los datos'
        });
    }
};

// Función para guardar sanción
const guardar = async (e) => {
    e.preventDefault();
    try {
        const formData = new FormData(formulario);
        const response = await fetch("/control_arresto/API/sancion/guardar", {
            method: 'POST',
            body: formData
        });
        const data = await response.json();

        if (data.codigo === 1) {
            Toast.fire({ icon: 'success', title: 'Sanción guardada exitosamente' });
            formulario.reset();
            buscar();
        } else {
            Toast.fire({ icon: 'error', title: data.mensaje });
        }
    } catch (error) {
        console.error('Error:', error);
        Toast.fire({
            icon: 'error',
            title: 'Error al guardar la sanción'
        });
    }
};

// Función para modificar sanción
const modificar = async (e) => {
    e.preventDefault();
    try {
        const formData = new FormData(formulario);
        const response = await fetch("/control_arresto/API/sancion/modificar", {
            method: 'POST',
            body: formData
        });
        const data = await response.json();

        if (data.codigo === 1) {
            Toast.fire({ icon: 'success', title: 'Sanción modificada exitosamente' });
            formulario.reset();
            buscar();
        } else {
            Toast.fire({ icon: 'error', title: data.mensaje });
        }
    } catch (error) {
        console.error('Error:', error);
        Toast.fire({
            icon: 'error',
            title: 'Error al modificar la sanción'
        });
    }
};

// Función para eliminar sanción
const eliminar = async (e) => {
    const id = e.target.closest('.eliminar').dataset.san_id;
    if (!id) return;

    const result = await Swal.fire({
        title: '¿Está seguro?',
        text: "Esta acción no se puede revertir",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    });

    if (result.isConfirmed) {
        const body = new FormData();
        body.append('san_id', id);

        const url = "/control_arresto/API/sancion/eliminar";
        const response = await fetch(url, { method: 'POST', body });

        const data = await response.json();

        Toast.fire({
            icon: data.codigo === 1 ? 'success' : 'error',
            title: data.mensaje
        });

        if (data.codigo === 1) {
            await buscar();
        }
    }
};

// Event Listeners
formulario.addEventListener('submit', guardar);
btnModificar.addEventListener('click', modificar);
btnCancelar.addEventListener('click', () => formulario.reset());
document.querySelector('#tablaSancion').addEventListener('click', (e) => {
    if (e.target.closest('.modificar')) {
        const dataset = e.target.closest('.modificar').dataset;
        formulario.san_id.value = dataset.san_id;
        formulario.san_catalogo.value = dataset.san_catalogo;
        formulario.san_fecha_sancion.value = dataset.san_fecha_sancion;
        formulario.san_falta_id.value = dataset.san_falta_id;
        formulario.san_instructor_ordena.value = dataset.san_instructor_ordena;
        formulario.san_horas_arresto.value = dataset.san_horas_arresto;
        formulario.san_demeritos.value = dataset.san_demeritos;
        formulario.san_observaciones.value = dataset.san_observaciones;
        btnGuardar.style.display = 'none';
        btnModificar.style.display = 'inline';
        btnCancelar.style.display = 'inline';
    } else if (e.target.closest('.eliminar')) {
        eliminar(e);
    }
});

// Cargar datos iniciales
buscar();
