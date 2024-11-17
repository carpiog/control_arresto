<?php
namespace Controllers;

use Exception;
use Model\Falta;
use Model\CategoriaFalta;
use MVC\Router;

class FaltaController {
    public static function index(Router $router) {
        $categorias = CategoriaFalta::buscarTodos();
        
        $router->render('falta/index', [
            'titulo' => 'Gestión de Faltas',
            'categorias' => $categorias
        ]);
    }

    public static function guardarAPI() {
        try {
            $_POST['fal_categoria_id'] = filter_var($_POST['fal_categoria_id'], FILTER_SANITIZE_NUMBER_INT);
            
            if(!isset($_POST['fal_categoria_id'])) {
                throw new Exception("La categoría es requerida");
            }

            $falta = new Falta($_POST);
            $resultado = $falta->crear();

            if($resultado) {
                echo json_encode([
                    'codigo' => 1,
                    'mensaje' => 'Falta guardada exitosamente'
                ]);
            } else {
                throw new Exception("No se pudo guardar la falta");
            }

        } catch (Exception $e) {
            echo json_encode([
                'codigo' => 0,
                'mensaje' => 'Error al guardar la falta',
                'detalle' => $e->getMessage()
            ]);
        }
    }

    public static function buscarAPI() {
        try {
            $faltas = Falta::buscarTodos();

            echo json_encode([
                'codigo' => 1,
                'mensaje' => 'Datos encontrados',
                'datos' => $faltas
            ]);
        } catch (Exception $e) {
            echo json_encode([
                'codigo' => 0,
                'mensaje' => 'Error al buscar faltas',
                'detalle' => $e->getMessage()
            ]);
        }
    }

    public static function eliminarAPI() {
        try {
            if(!isset($_POST['fal_id'])) {
                throw new Exception("ID no proporcionado");
            }

            $falta = Falta::find($_POST['fal_id']);
            
            if(!$falta) {
                throw new Exception("Falta no encontrada");
            }

            // $falta->fal_situacion = 0;
            $resultado = $falta->actualizar();

            if($resultado) {
                echo json_encode([
                    'codigo' => 1,
                    'mensaje' => 'Falta eliminada exitosamente'
                ]);
            } else {
                throw new Exception("No se pudo eliminar la falta");
            }

        } catch (Exception $e) {
            echo json_encode([
                'codigo' => 0,
                'mensaje' => 'Error al eliminar la falta',
                'detalle' => $e->getMessage()
            ]);
        }
    }
}