<?php
namespace Model;

class Falta extends ActiveRecord {
    protected static $tabla = 'car_falta';
    protected static $idTabla = 'fal_id';
    protected static $columnasDB = ['fal_id', 'fal_categoria_id', 'fal_descripcion', 'fal_horas_arresto', 'fal_demeritos', 'fal_situacion'];

    public $fal_id;
    public $fal_categoria_id;
    public $fal_descripcion;
    public $fal_horas_arresto;
    public $fal_demeritos;
    public $fal_situacion;

    public function __construct($args = []) {
        $this->fal_id = $args['fal_id'] ?? null;
        $this->fal_categoria_id = $args['fal_categoria_id'] ?? '';
        $this->fal_descripcion = $args['fal_descripcion'] ?? '';
        $this->fal_horas_arresto = $args['fal_horas_arresto'] ?? null;
        $this->fal_demeritos = $args['fal_demeritos'] ?? null;
        $this->fal_situacion = $args['fal_situacion'] ?? 1;
    }

    public static function buscarTodos() {
        $query = "SELECT f.*, 
                        cf.cat_nombre as categoria_nombre,
                        tf.tip_nombre as tipo_nombre,
                        tf.tip_id as tipo_id
                 FROM " . static::$tabla . " f 
                 JOIN car_categoria_falta cf ON f.fal_categoria_id = cf.cat_id 
                 JOIN car_tipo_falta tf ON cf.cat_tipo_id = tf.tip_id 
                 WHERE f.fal_situacion = 1 
                 ORDER BY tf.tip_id, cf.cat_nombre, f.fal_descripcion";
        
        return static::consultarSQL($query);
    }
}