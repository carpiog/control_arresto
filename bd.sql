CREATE TABLE car_instructor (
    ins_id SERIAL PRIMARY KEY,
    ins_catalogo INTEGER,
    ins_situacion SMALLINT DEFAULT 1,
    FOREIGN KEY (ins_catalogo) REFERENCES mper(per_catalogo)
);

-- Tabla de tipos
CREATE TABLE car_tipo_falta (
    tip_id SERIAL PRIMARY KEY, 
    tip_nombre CHAR(20) NOT NULL,
    tip_descripcion VARCHAR(255) NOT NULL,
    tip_situacion SMALLINT DEFAULT 1
);
INSERT INTO car_tipo_falta (tip_nombre, tip_descripcion) 
VALUES ('LEVE', 'Quebrantamiento de una norma que lesiona la disciplina');
INSERT INTO car_tipo_falta (tip_nombre, tip_descripcion) 
VALUES ('GRAVE', 'Quebrantamiento que lesiona el orden y disciplina');
INSERT INTO car_tipo_falta (tip_nombre, tip_descripcion) 
VALUES ('GRAVISIMA', 'Quebrantamiento que amerita baja definitiva');

CREATE TABLE car_categoria_falta (
    cat_id SERIAL PRIMARY KEY,
    cat_tipo_id INTEGER NOT NULL REFERENCES car_tipo_falta(tip_id),
    cat_nombre CHAR(50) NOT NULL,
    cat_descripcion VARCHAR(255),
    cat_situacion SMALLINT DEFAULT 1
);

-- Inserciones para faltas LEVES
INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'HIGIENE PERSONAL', 'Faltas relacionadas con aseo y presentación personal'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'PRESENTACION Y REVISTAS', 'Faltas relacionadas con uniforme y revistas'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'MOBILIARIO', 'Faltas relacionadas con cuidado del mobiliario'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'ARMAMENTO', 'Faltas relacionadas con manejo del armamento'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'FORMACION', 'Faltas relacionadas con formación y orden cerrado'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'COMEDOR', 'Faltas de conducta en el comedor'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'ESTUDIO Y CLASE', 'Faltas de comportamiento en clase'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'EDUCACION Y CORTESIA', 'Faltas de comportamiento y modales'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'CONDUCTA MILITAR', 'Faltas de disciplina militar'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'SERVICIO', 'Faltas relacionadas con el servicio'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'CUMPLIMIENTO SANCIONES', 'Faltas en cumplimiento de sanciones'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'ESTADO DE FUERZA', 'Faltas relacionadas con estado de fuerza'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'EJERCICIOS ORDEN CERRADO', 'Faltas en ejercicios ante público'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'CONDUCTA VIA PUBLICA', 'Faltas de conducta uniformado en vía pública'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'FALTAS VARIAS', 'Otras faltas leves'
FROM car_tipo_falta WHERE tip_nombre = 'LEVE';

-- Inserciones para faltas GRAVES
INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'COMPORTAMIENTO Y ORDEN', 'Faltas graves de comportamiento'
FROM car_tipo_falta WHERE tip_nombre = 'GRAVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'SALVAR CONDUCTO', 'Faltas graves por salvar conducto'
FROM car_tipo_falta WHERE tip_nombre = 'GRAVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'DESFILES', 'Faltas graves en desfiles'
FROM car_tipo_falta WHERE tip_nombre = 'GRAVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'ARRESTO', 'Faltas graves relacionadas con arrestos'
FROM car_tipo_falta WHERE tip_nombre = 'GRAVE';

INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'EXAMENES', 'Faltas graves en exámenes'
FROM car_tipo_falta WHERE tip_nombre = 'GRAVE';

-- Inserción para faltas GRAVISIMAS
INSERT INTO car_categoria_falta (cat_tipo_id, cat_nombre, cat_descripcion) 
SELECT tip_id, 'FALTAS GRAVISIMAS', 'Faltas que ameritan baja definitiva'
FROM car_tipo_falta WHERE tip_nombre = 'GRAVISIMA';

CREATE TABLE car_falta (
    fal_id SERIAL PRIMARY KEY,
    fal_categoria_id INTEGER NOT NULL REFERENCES car_categoria_falta(cat_id),
    fal_descripcion VARCHAR(255) NOT NULL,
    fal_horas_arresto SMALLINT,  -- Para faltas leves
    fal_demeritos SMALLINT,      -- Para faltas graves
    fal_situacion SMALLINT DEFAULT 1
);

select * from car_falta

-- FALTAS LEVES - HIGIENE PERSONAL
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No bañarse', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No peinarse', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Uñas sucias', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No recortarse las uñas', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No lavarse las manos', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Dientes sucios', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No afeitarse', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No cortarse el cabello reglamentariamente', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Cabello corto mal recortado o peinado (señoritas)', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Medias rotas (señoritas)', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Medias sucias (señoritas)', 4
FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

-- FALTAS LEVES - PRESENTACION Y REVISTAS
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Hebilla sucia', 4
FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Birrete sucio', 4
FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Zapatos sucios', 4
FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No lustrarse', 4
FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Uniforme sucio', 4
FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Desabotonado', 4
FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Mal uniformado', 4
FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Uniforme sin cuello', 4
FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';

-- FALTAS LEVES - MOBILIARIO
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Cama mal hecha o sucia', 4
FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Papelera sucia o desordenada', 4
FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Cama sucia', 4
FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Dejar prendas fuera de su lugar', 4
FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Papelera sin candado', 4
FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';

-- FALTAS LEVES - ARMAMENTO
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Dejar caer su fusil', 2
FROM car_categoria_falta WHERE cat_nombre = 'ARMAMENTO';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Fusil sucio', 2
FROM car_categoria_falta WHERE cat_nombre = 'ARMAMENTO';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Maltratar su armamento', 3
FROM car_categoria_falta WHERE cat_nombre = 'ARMAMENTO';

-- FALTAS GRAVES
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Con un Oficial', 5
FROM car_categoria_falta WHERE cat_nombre = 'SALVAR CONDUCTO';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Con el Subdirector', 10
FROM car_categoria_falta WHERE cat_nombre = 'SALVAR CONDUCTO';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Con el Director', 15
FROM car_categoria_falta WHERE cat_nombre = 'SALVAR CONDUCTO';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Con el alto Mando del Ejército', 30
FROM car_categoria_falta WHERE cat_nombre = 'SALVAR CONDUCTO';

-- FALTAS GRAVES - DESFILES
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'No asistir a un desfile estando organizado', 30
FROM car_categoria_falta WHERE cat_nombre = 'DESFILES';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Reincidencia en no asistir a un desfile', 50
FROM car_categoria_falta WHERE cat_nombre = 'DESFILES';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Segunda reincidencia en no asistir a un desfile', 75
FROM car_categoria_falta WHERE cat_nombre = 'DESFILES';

-- FALTAS GRAVISIMAS
INSERT INTO car_falta (fal_categoria_id, fal_descripcion) 
SELECT cat_id, 'Negarse a cumplir una orden de superior'
FROM car_categoria_falta WHERE cat_nombre = 'FALTAS GRAVISIMAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion) 
SELECT cat_id, 'Insubordinarse a un superior'
FROM car_categoria_falta WHERE cat_nombre = 'FALTAS GRAVISIMAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion) 
SELECT cat_id, 'Ingerir bebidas alcohólicas'
FROM car_categoria_falta WHERE cat_nombre = 'FALTAS GRAVISIMAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion) 
SELECT cat_id, 'Evadirse del establecimiento'
FROM car_categoria_falta WHERE cat_nombre = 'FALTAS GRAVISIMAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion) 
SELECT cat_id, 'Lesionar la dignidad de un alumno'
FROM car_categoria_falta WHERE cat_nombre = 'FALTAS GRAVISIMAS';

INSERT INTO car_falta (fal_categoria_id, fal_descripcion) 
SELECT cat_id, 'Hacer peticiones en conjunto'
FROM car_categoria_falta WHERE cat_nombre = 'FALTAS GRAVISIMAS';