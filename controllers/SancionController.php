<?php

namespace Controllers;

use Exception;
use Model\Sancion;
use Model\Alumno;
use Model\Falta;
use Model\Instructor;
use MVC\Router;

class SancionController {
    public static function index(Router $router) {
        try {
            $alumnos = Alumno::where('alu_situacion', 1);
            $faltas = Falta::where('fal_situacion', 1);
            $instructores = Instructor::where('ins_situacion', 1);

            $router->render('sancion/index', [
                'alumnos' => $alumnos ?? [],
                'faltas' => $faltas ?? [],
                'instructores' => $instructores ?? []
            ]);
        } catch (Exception $e) {
            echo json_encode([
                'codigo' => 0,
                'mensaje' => 'Error al cargar datos iniciales'
            ]);
        }
    }

    public static function guardarAPI() {
        header('Content-Type: application/json');
        try {
            $_POST['san_catalogo'] = filter_var($_POST['san_catalogo'], FILTER_SANITIZE_NUMBER_INT);
            
            if (Sancion::existeSancion($_POST['san_catalogo'], $_POST['san_fecha_sancion'], $_POST['san_falta_id'])) {
                throw new Exception("Ya existe una sanción registrada para este alumno en la misma fecha con la misma falta.");
            }

            $sancion = new Sancion($_POST);
            $resultado = $sancion->crear();

            if ($resultado['resultado']) {
                echo json_encode([
                    'codigo' => 1,
                    'mensaje' => 'Sanción guardada exitosamente',
                    'id' => $resultado['id']
                ]);
            } else {
                throw new Exception("No se pudo guardar la sanción");
            }
        } catch (Exception $e) {
            echo json_encode([
                'codigo' => 0,
                'mensaje' => $e->getMessage()
            ]);
        }
    }

    public static function buscarAPI() {
        header('Content-Type: application/json');
        try {
            $sanciones = Sancion::obtenerSanciones();
            
            echo json_encode([
                'codigo' => 1,
                'mensaje' => $sanciones ? 'Datos encontrados' : 'No hay sanciones registradas',
                'datos' => $sanciones ?? []
            ]);
        } catch (Exception $e) {
            echo json_encode([
                'codigo' => 0,
                'mensaje' => 'Error al buscar sanciones: ' . $e->getMessage()
            ]);
        }
    }

    public static function modificarAPI() {
        header('Content-Type: application/json');
        try {
            if (!isset($_POST['san_id'])) {
                throw new Exception("ID de sanción no proporcionado");
            }

            $_POST['san_id'] = filter_var($_POST['san_id'], FILTER_SANITIZE_NUMBER_INT);
            $_POST['san_catalogo'] = filter_var($_POST['san_catalogo'], FILTER_SANITIZE_NUMBER_INT);

            $sancion = Sancion::find($_POST['san_id']);
            if (!$sancion) {
                throw new Exception("Sanción no encontrada");
            }

            if (Sancion::existeSancion($_POST['san_catalogo'], $_POST['san_fecha_sancion'], $_POST['san_falta_id'], $_POST['san_id'])) {
                throw new Exception("Ya existe una sanción registrada para este alumno en la misma fecha con la misma falta.");
            }

            $sancion->sincronizar($_POST);
            $resultado = $sancion->actualizar();

            if ($resultado['resultado']) {
                echo json_encode([
                    'codigo' => 1,
                    'mensaje' => 'Sanción modificada exitosamente'
                ]);
            } else {
                throw new Exception("No se pudo modificar la sanción");
            }
        } catch (Exception $e) {
            echo json_encode([
                'codigo' => 0,
                'mensaje' => $e->getMessage()
            ]);
        }
    }

    public static function eliminarAPI() {
        header('Content-Type: application/json');
        try {
            if (!isset($_POST['san_id'])) {
                throw new Exception("ID de sanción no proporcionado");
            }

            $sancion = Sancion::find($_POST['san_id']);
            if (!$sancion) {
                throw new Exception("Sanción no encontrada");
            }

            $resultado = $sancion->eliminar();

            if ($resultado['resultado']) {
                echo json_encode([
                    'codigo' => 1,
                    'mensaje' => 'Sanción eliminada exitosamente'
                ]);
            } else {
                throw new Exception("No se pudo eliminar la sanción");
            }
        } catch (Exception $e) {
            echo json_encode([
                'codigo' => 0,
                'mensaje' => 'Error al eliminar la sanción: ' . $e->getMessage()
            ]);
        }
    }
}
