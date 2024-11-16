<?php 
require_once __DIR__ . '/../includes/app.php';


use MVC\Router;
use Controllers\AppController;
use Controllers\InstructorController;

$router = new Router();
$router->setBaseURL('/' . $_ENV['APP_NAME']);

$router->get('/', [AppController::class, 'index']);
$router->get('/instructor', [InstructorController::class, 'index']);
$router->post('/API/instructor/guardar', [InstructorController::class, 'guardarAPI']);
$router->get('/API/instructor/buscar', [InstructorController::class, 'buscarAPI']);
$router->post('/API/instructor/modificar', [InstructorController::class, 'modificarAPI']);
$router->post('/API/instructor/eliminar', [InstructorController::class, 'eliminarAPI']);

// Comprueba y valida las rutas, que existan y les asigna las funciones del Controlador
$router->comprobarRutas();
