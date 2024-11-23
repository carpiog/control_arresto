<?php

namespace Model;

class Sancion extends ActiveRecord {
    protected static $tabla = 'car_sancion';
    protected static $idTabla = 'san_id';
    protected static $columnasDB = [
        'san_id',
        'san_catalogo',
        'san_fecha_registro',
        'san_fecha_sancion',
        'san_falta_id',
        'san_instructor_ordena',
        'san_horas_arresto',
        'san_demeritos',
        'san_observaciones',
        'san_situacion'
    ];

    public $san_id;
    public $san_catalogo;
    public $san_fecha_registro;
    public $san_fecha_sancion;
    public $san_falta_id;
    public $san_instructor_ordena;
    public $san_horas_arresto;
    public $san_demeritos;
    public $san_observaciones;
    public $san_situacion;

    public function __construct($args = []) {
        $this->san_id = $args['san_id'] ?? null;
        $this->san_catalogo = $args['san_catalogo'] ?? '';
        $this->san_fecha_registro = date('Y-m-d H:i:s');
        $this->san_fecha_sancion = $args['san_fecha_sancion'] ?? '';
        $this->san_falta_id = $args['san_falta_id'] ?? '';
        $this->san_instructor_ordena = $args['san_instructor_ordena'] ?? '';
        $this->san_horas_arresto = $args['san_horas_arresto'] ?? null;
        $this->san_demeritos = $args['san_demeritos'] ?? null;
        $this->san_observaciones = $args['san_observaciones'] ?? '';
        $this->san_situacion = $args['san_situacion'] ?? 1;
    }

    // Validar los campos requeridos
    public function validar() {
        static::$alertas = [];

        if (!$this->san_catalogo) {
            static::$alertas['error'][] = 'El catálogo del alumno es obligatorio';
        }
        if (!$this->san_fecha_sancion) {
            static::$alertas['error'][] = 'La fecha de sanción es obligatoria';
        }
        if (!$this->san_falta_id) {
            static::$alertas['error'][] = 'La falta es obligatoria';
        }
        if (!$this->san_instructor_ordena) {
            static::$alertas['error'][] = 'El instructor que ordena es obligatorio';
        }

        return static::$alertas;
    }

    // Obtener todas las sanciones con información relacionada
    public static function obtenerSanciones() {
        $query = "SELECT 
                    s.*,
                    TRIM(a.alu_primer_nombre || ' ' || COALESCE(a.alu_segundo_nombre, '') || ' ' ||
                    a.alu_primer_apellido || ' ' || COALESCE(a.alu_segundo_apellido, '')) as alumno_nombre,
                    f.fal_descripcion,
                    cf.cat_nombre as categoria_falta,
                    tf.tip_nombre as tipo_falta,
                    i.ins_catalogo,
                    TRIM(m.per_nom1 || ' ' || 
                         CASE WHEN m.per_nom2 IS NOT NULL THEN m.per_nom2 || ' ' ELSE '' END ||
                         m.per_ape1 || ' ' ||
                         CASE WHEN m.per_ape2 IS NOT NULL THEN m.per_ape2 || ' ' ELSE '' END
                    ) AS instructor_nombre
                FROM car_sancion s
                JOIN car_alumno a ON s.san_catalogo = a.alu_catalogo
                JOIN car_falta f ON s.san_falta_id = f.fal_id
                JOIN car_categoria_falta cf ON f.fal_categoria_id = cf.cat_id
                JOIN car_tipo_falta tf ON cf.cat_tipo_id = tf.tip_id
                JOIN car_instructor i ON s.san_instructor_ordena = i.ins_id
                JOIN mper m ON i.ins_catalogo = m.per_catalogo
                WHERE s.san_situacion = 1
                ORDER BY s.san_fecha_sancion DESC";

        return self::fetchArray($query);
    }

    // Obtener sanciones por alumno
    public static function obtenerSancionesPorAlumno($catalogo) {
        $query = "SELECT 
                    s.*,
                    f.fal_descripcion,
                    cf.cat_nombre as categoria_falta,
                    tf.tip_nombre as tipo_falta,
                    TRIM(m.per_nom1 || ' ' || m.per_nom2 || ' ' || m.per_ape1 || ' ' || m.per_ape2) AS instructor_nombre
                FROM car_sancion s
                JOIN car_falta f ON s.san_falta_id = f.fal_id
                JOIN car_categoria_falta cf ON f.fal_categoria_id = cf.cat_id
                JOIN car_tipo_falta tf ON cf.cat_tipo_id = tf.tip_id
                JOIN car_instructor i ON s.san_instructor_ordena = i.ins_id
                JOIN mper m ON i.ins_catalogo = m.per_catalogo
                WHERE s.san_catalogo = " . self::$db->quote($catalogo) . "
                AND s.san_situacion = 1
                ORDER BY s.san_fecha_sancion DESC";

        return self::fetchArray($query);
    }

    // Verificar si ya existe una sanción similar
    public static function existeSancion($catalogo, $fecha, $falta_id, $id = null) {
        $query = "SELECT COUNT(*) as cuenta 
                 FROM car_sancion 
                 WHERE san_catalogo = " . self::$db->quote($catalogo) . "
                 AND san_fecha_sancion = " . self::$db->quote($fecha) . "
                 AND san_falta_id = " . self::$db->quote($falta_id) . "
                 AND san_situacion = 1";

        if ($id) {
            $query .= " AND san_id != " . self::$db->quote($id);
        }

        $resultado = self::fetchFirst($query);
        return (int)$resultado['cuenta'] > 0;
    }

    // Obtener estadísticas de sanciones
    public static function obtenerEstadisticas($fecha_inicio, $fecha_fin) {
        $query = "SELECT 
                    COUNT(*) as total_sanciones,
                    SUM(CASE WHEN san_horas_arresto IS NOT NULL THEN 1 ELSE 0 END) as total_arrestos,
                    SUM(CASE WHEN san_demeritos IS NOT NULL THEN 1 ELSE 0 END) as total_demeritos,
                    SUM(san_horas_arresto) as total_horas_arresto,
                    SUM(san_demeritos) as total_puntos_demeritos
                FROM car_sancion
                WHERE san_situacion = 1
                AND san_fecha_sancion BETWEEN " . self::$db->quote($fecha_inicio) . " 
                AND " . self::$db->quote($fecha_fin);

        return self::fetchFirst($query);
    }

    // En lugar de eliminar físicamente, actualizamos la situación a 0
    public function eliminar() {
        $this->san_situacion = 0;
        return $this->actualizar();
    }
}