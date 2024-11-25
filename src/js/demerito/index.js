import { Dropdown } from "bootstrap";
import { Toast } from "../funciones";
import DataTable from "datatables.net-bs5";
import { lenguaje } from "../lenguaje";

document.addEventListener('DOMContentLoaded', function () {
    let dataTable = new DataTable('#tablaDemerito', {
        language: lenguaje,
        pageLength: 25,
        order: [],
        columns: [
            { data: null, render: (data, type, row, meta) => meta.row + 1 },
            { data: 'alu_catalogo' },
            { data: 'gra_nombre' },
            { data: 'ran_nombre' },
            { data: 'alumno_nombre' },
            { data: 'total_sanciones' },
            { data: 'demeritos_acumulados' },
            {
                data: 'conducta',
                render: function (data, type, row) {
                    if (type === 'display') {
                        let badgeClass = '';
                        switch (data) {
                            case 'EXCELENTE': badgeClass = 'bg-success'; break;
                            case 'MUY BUENA': badgeClass = 'bg-info'; break;
                            case 'BUENA': badgeClass = 'bg-primary'; break;
                            case 'REGULAR': badgeClass = 'bg-warning'; break;
                            case 'DEFICIENTE':
                            case 'MALA': badgeClass = 'bg-danger'; break;

                        }
                        return `<span class="badge rounded-pill ${badgeClass}">${data}</span>`;
                    }
                    return data;
                }
            }
        ],
        rowCallback: function (row, data) {
            if (data.conducta === 'MALA' || data.conducta === 'DEFICIENTE') {
                $(row).addClass('table-danger');
            }
        }
    });

    const aplicarFiltros = () => {
        const filtroGrado = document.getElementById('filtroGrado').value;
        const filtroConducta = document.getElementById('filtroConducta').value;

        dataTable.column(2).search(filtroGrado);

        if (filtroConducta === 'RIESGO') {
            dataTable.column(6).search('DEFICIENTE|MALA', true, false);
        } else {
            dataTable.column(6).search(filtroConducta);
        }

        dataTable.draw();
    };

    const buscar = async () => {
        try {
            const respuesta = await fetch("/control_arresto/API/demerito/buscar");
            const data = await respuesta.json();

            if (data.codigo === 1 && data.datos) {
                dataTable.clear().rows.add(data.datos).draw();
            }
        } catch (error) {
            console.error('Error:', error);
            Toast.fire({
                icon: 'error',
                title: 'Error al cargar los datos'
            });
        }
    };

    // Event Listeners
    document.getElementById('filtroGrado').addEventListener('change', aplicarFiltros);
    document.getElementById('filtroConducta').addEventListener('change', aplicarFiltros);

    buscar();
});