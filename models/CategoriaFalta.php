<?php
namespace Model;

class CategoriaFalta extends ActiveRecord {
    protected static $tabla = 'car_categoria_falta';
    protected static $idTabla = 'cat_id';
    protected static $columnasDB = ['cat_id', 'cat_tipo_id', 'cat_nombre', 'cat_descripcion', 'cat_situacion'];

    public $cat_id;
    public $cat_tipo_id;
    public $cat_nombre;
    public $cat_descripcion;
    public $cat_situacion;

    public function __construct($args = []) {
        $this->cat_id = $args['cat_id'] ?? null;
        $this->cat_tipo_id = $args['cat_tipo_id'] ?? '';
        $this->cat_nombre = $args['cat_nombre'] ?? '';
        $this->cat_descripcion = $args['cat_descripcion'] ?? '';
        $this->cat_situacion = $args['cat_situacion'] ?? 1;
    }

    public static function buscarTodos() {
        $query = "SELECT cf.*, tf.tip_nombre as tipo_nombre 
                 FROM " . static::$tabla . " cf 
                 JOIN car_tipo_falta tf ON cf.cat_tipo_id = tf.tip_id 
                 WHERE cf.cat_situacion = 1 
                 ORDER BY cf.cat_id";
        return static::consultarSQL($query);
    }
}