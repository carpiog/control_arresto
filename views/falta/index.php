<h1 class="text-center">Mantenimiento de Faltas</h1>

<div class="row mb-3">
    <div class="col-md-4">
        <select id="filtroTipo" class="form-select">
            <option value="">Todos los tipos</option>
            <option value="LEVE">Faltas Leves</option>
            <option value="GRAVE">Faltas Graves</option>
            <option value="GRAVISIMA">Faltas Gravísimas</option>
        </select>
    </div>
</div>

<div class="row mb-4">
    <div class="col table-responsive">
        <table class="table table-bordered table-hover w-100" id="tablaFalta">
            <thead class="bg-dark text-white">
                <tr>
                    <th>No.</th>
                    <th>Tipo</th>
                    <th>Categoría</th>
                    <th>Descripción</th>
                    <th>Sanción</th>
                    <th>Acciones</th>
                </tr>
            </thead>
        </table>
    </div>
</div>

<script src="<?= asset('./build/js/falta/index.js') ?>"></script>