<h1 class="text-center">Registro de Sanciones</h1>
<div class="row justify-content-center mb-4">
    <div class="col-lg-8">
        <form id="formSancion" class="border shadow p-4">
            <input type="hidden" name="san_id" id="san_id">

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="san_catalogo" class="form-label">Alumno</label>
                    <select class="form-select" name="san_catalogo" id="san_catalogo" required>
                        <option value="">Seleccione un alumno</option>
                        <?php foreach ($alumnos as $alumno): ?>
                            <option value="<?= $alumno->alu_catalogo ?>">
                                <?= $alumno->nombres_completos . ' - ' . $alumno->alu_catalogo ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="san_fecha_sancion" class="form-label">Fecha de Sanción</label>
                    <input type="date" class="form-control" name="san_fecha_sancion" id="san_fecha_sancion" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="san_falta_id" class="form-label">Tipo de Falta</label>
                    <select class="form-select" name="san_falta_id" id="san_falta_id" required>
                        <option value="">Seleccione una falta</option>
                        <?php foreach ($faltas as $falta): ?>
                            <option value="<?= $falta->fal_id ?>"><?= $falta->fal_descripcion ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="san_instructor_ordena" class="form-label">Instructor que Ordena</label>
                    <select class="form-select" name="san_instructor_ordena" id="san_instructor_ordena" required>
                        <option value="">Seleccione un instructor</option>
                        <?php foreach ($instructores as $instructor): ?>
                            <option value="<?= $instructor->ins_id ?>">
                                <?= $instructor->instructor_nombre . ' - ' . $instructor->ins_catalogo ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="san_horas_arresto" class="form-label">Horas de Arresto</label>
                    <input type="number" class="form-control" name="san_horas_arresto" id="san_horas_arresto" readonly>
                </div>
                <div class="col-md-6">
                    <label for="san_demeritos" class="form-label">Cantidad de Deméritos</label>
                    <input type="number" class="form-control" name="san_demeritos" id="san_demeritos" readonly>
                </div>
            </div>

            <div class="mb-3">
                <label for="san_observaciones" class="form-label">Observaciones</label>
                <textarea class="form-control" name="san_observaciones" id="san_observaciones" rows="3"></textarea>
            </div>

            <div class="row text-center">
                <div class="col">
                    <button type="submit" form="formSancion" id="btnGuardar" class="btn btn-primary w-100">Guardar</button>
                </div>
                <div class="col">
                    <button type="button" id="btnModificar" class="btn btn-warning w-100">Modificar</button>
                </div>
                <div class="col">
                    <button type="button" id="btnCancelar" class="btn btn-danger w-100">Cancelar</button>
                </div>
            </div>
        </form>
    </div>
</div>

<h2 class="text-center">Listado de Sanciones</h2>
<div class="row mb-4">
    <div class="col table-responsive">
        <table class="table table-bordered table-hover w-100" id="tablaSancion">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Catálogo</th>
                    <th>Alumno</th>
                    <th>Fecha Sanción</th>
                    <th>Falta</th>
                    <th>Horas Arresto</th>
                    <th>Deméritos</th>
                    <th>Instructor</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <!-- Aquí se cargarán las sanciones mediante JavaScript -->
            </tbody>
        </table>
    </div>
</div>

<script src="<?= asset('build/js/sancion/index.js') ?>"></script>
