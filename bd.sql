CREATE TABLE car_instructor (
    ins_id SERIAL PRIMARY KEY,
    ins_catalogo INTEGER,
    ins_situacion SMALLINT DEFAULT 1,
    FOREIGN KEY (ins_catalogo) REFERENCES mper(per_catalogo)
);

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
VALUES ('GRAVISIMAS', 'Quebrantamiento que amerita baja definitiva');

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
    fal_dem_retiro VARCHAR(20),  -- Para casos que pueden ser "Demeritos" o "RETIRO"
    fal_situacion SMALLINT DEFAULT 1
);
-- Higiene Personal
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No bañarse', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No peinarse', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Uñas sucias', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No recortarse las uñas', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No lavarse las manos', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Dientes sucios', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No afeitarse', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No cortarse el cabello reglamentariamente', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Cabello corto, mal recortado o peinado (señoritas)', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Medias rotas (señoritas)', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Medias sucias (señoritas)', 4 FROM car_categoria_falta WHERE cat_nombre = 'HIGIENE PERSONAL';

-- Presentación y Revistas
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Hebilla sucia', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Birrete sucio', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Zapatos sucios', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No lustrarse', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Uniforme sucio', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Desabotonado', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Mal uniformado', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Uniforme sin cuello', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No usar pañuelos', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Cinturón sucio', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Prendas personales sucias', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Uñas pintadas (señoritas)', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Aretes no reglamentarios (señoritas)', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Maquillaje no reglamentario (señoritas)', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No usar falda del uniforme de conformidad al Reglamento de Uniformes del Ejército de Guatemala', 4 
FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Faltas a la revista', 4 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Por cada falta previa a una presentación en público', 2 FROM car_categoria_falta WHERE cat_nombre = 'PRESENTACION Y REVISTAS';

-- Mobiliario
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Cama mal hecha o sucia', 4 FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Papelera sucia o desordenada', 4 FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Cama sucia', 4 FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Dejar prendas fuera de su lugar', 4 FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Papelera sin candado', 4 FROM car_categoria_falta WHERE cat_nombre = 'MOBILIARIO';

-- Armamento
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Dejar caer su fusil', 2 FROM car_categoria_falta WHERE cat_nombre = 'ARMAMENTO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Fusil sucio', 2 FROM car_categoria_falta WHERE cat_nombre = 'ARMAMENTO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Maltratar su armamento', 3 FROM car_categoria_falta WHERE cat_nombre = 'ARMAMENTO';

-- Formación
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No pasar a formación', 8 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Mal alineado', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No bracear correctamente', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No llevar la vista al frente', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Hacer mal un movimiento en instrucción', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Perder el paso', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No ponerse firmes correctamente', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Moverse en formación', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Faltas en instrucción', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Salirse de formación sin permiso', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Comer o masticar chicle en formación', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Hablar en formación', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Reirse en formación', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Llegar tarde a formación', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No respetar una formación', 4 FROM car_categoria_falta WHERE cat_nombre = 'FORMACION';

-- Comedor
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Mal sentado', 4 FROM car_categoria_falta WHERE cat_nombre = 'COMEDOR';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Jugar en el comedor', 4 FROM car_categoria_falta WHERE cat_nombre = 'COMEDOR';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Tomar alimentos que no le corresponden', 4 FROM car_categoria_falta WHERE cat_nombre = 'COMEDOR';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Modales incorrectos en la mesa (colocar los codos sobre la mesa, entrecruzar los brazos para alcanzar objetos, sentarse en jorobado, hablar con la boca llena, hablar o reírse fuerte en la mesa, intercambiar comida)', 4 
FROM car_categoria_falta WHERE cat_nombre = 'COMEDOR';

-- Estudio y Clase
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Mal sentado', 4 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Hablar sin autorización', 2 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Falto de atención', 2 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Llegar tarde sin autorización', 2 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Ausentarse sin autorización', 4 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Jugar', 3 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Dormirse', 3 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Uso de celular y dispositivos electrónicos sin autorización', 4 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Comer en clase o en estudio', 2 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Levantarse sin autorización', 2 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Salir del aula sin autorización', 4 FROM car_categoria_falta WHERE cat_nombre = 'ESTUDIO Y CLASE';

-- Educación y Cortesía
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Llamar a sus compañeros con sobrenombres', 4 FROM car_categoria_falta WHERE cat_nombre = 'EDUCACION Y CORTESIA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Proferir vocablos soeces', 2 FROM car_categoria_falta WHERE cat_nombre = 'EDUCACION Y CORTESIA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No ceder asiento a una dama, adulto mayor o persona con discapacidad', 2 FROM car_categoria_falta WHERE cat_nombre = 'EDUCACION Y CORTESIA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No saberse dirigir a un catedrático', 4 FROM car_categoria_falta WHERE cat_nombre = 'EDUCACION Y CORTESIA';

-- Conducta Militar y Moral
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No mandar firmes ante un Oficial', 2 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA MILITAR Y MORAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Saludar estando descubierto', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA MILITAR Y MORAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Tener las manos en los bolsillos', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA MILITAR Y MORAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Saludar incorrectamente', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA MILITAR Y MORAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No saludar', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA MILITAR Y MORAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Perezoso para acudir a un llamado', 2 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA MILITAR Y MORAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Masticar chicle estando uniformado', 2 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA MILITAR Y MORAL';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No ponerse firmes ante un Oficial', 2 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA MILITAR Y MORAL';

-- En el Servicio
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Operar incorrectamente los libros', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Dar parte de novedades incorrectas', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No rendir parte de novedades', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Olvidar sus obligaciones reglamentarias', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No cumplir una orden', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Permitir desorden', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No entregar bien el servicio', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Relevar tarde el servicio', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No operar personalmente los libros', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Contestar incorrectamente el teléfono', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No cumplir una consigna', 4 FROM car_categoria_falta WHERE cat_nombre = 'SERVICIO';
-- En el Cumplimiento de Sanciones Disciplinarias
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Realizar incorrectamente el acondicionamiento físico', 4 FROM car_categoria_falta WHERE cat_nombre = 'CUMPLIMIENTO SANCIONES DISCIPLINARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Hablar durante el cumplimiento de la sanción', 2 FROM car_categoria_falta WHERE cat_nombre = 'CUMPLIMIENTO SANCIONES DISCIPLINARIAS';

-- Del Estado de Fuerza
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Retardar un estado de fuerza', 4 FROM car_categoria_falta WHERE cat_nombre = 'ESTADO DE FUERZA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Entorpecer un estado de fuerza', 2 FROM car_categoria_falta WHERE cat_nombre = 'ESTADO DE FUERZA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Dar un estado de fuerza equivocado', 4 FROM car_categoria_falta WHERE cat_nombre = 'ESTADO DE FUERZA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Estado de fuerza sucio (hoja)', 2 FROM car_categoria_falta WHERE cat_nombre = 'ESTADO DE FUERZA';

-- En Ejercicios de Orden Cerrado Frente al Público
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No bracear correctamente', 4 FROM car_categoria_falta WHERE cat_nombre = 'EJERCICIOS ORDEN CERRADO ANTE EL PUBLICO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No llevar la vista al frente', 4 FROM car_categoria_falta WHERE cat_nombre = 'EJERCICIOS ORDEN CERRADO ANTE EL PUBLICO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Hablar en formación', 4 FROM car_categoria_falta WHERE cat_nombre = 'EJERCICIOS ORDEN CERRADO ANTE EL PUBLICO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Mal alineado', 4 FROM car_categoria_falta WHERE cat_nombre = 'EJERCICIOS ORDEN CERRADO ANTE EL PUBLICO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Botar cualquier prenda de su uniforme', 4 FROM car_categoria_falta WHERE cat_nombre = 'EJERCICIOS ORDEN CERRADO ANTE EL PUBLICO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Equivocarse en un movimiento', 4 FROM car_categoria_falta WHERE cat_nombre = 'EJERCICIOS ORDEN CERRADO ANTE EL PUBLICO';

-- Conducta en la Vía Pública Estando Uniformado
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Comer golosinas y refrescos', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Llevar paquetes uniformado de gala', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Desabrocharse el cuello uniformado de gala', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Caminar sin marcialidad o perezosamente', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Recostarse en paredes o postes', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Tener las manos en los bolsillos', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Omitir el saludo en una inhumación fúnebre', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No descubrirse en actos religiosos', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Saludar incorrectamente', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Falto de porte militar', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Masticar chicle estando uniformado', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Lustrarse en la vía pública', 4 FROM car_categoria_falta WHERE cat_nombre = 'CONDUCTA VIA PUBLICA';

-- Faltas Varias
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Aula sucia (se sancionará al cuartelero)', 4 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'No depositar la basura en los recipientes', 2 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Retardarse en levantarse al toque de diana', 2 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Frecuentar la tienda en horario no autorizado', 4 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Mentir', 2 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Llegar tarde al establecimiento sin justificación', 4 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Perezoso', 2 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Desconsiderado con sus compañeros', 2 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Tomarse atribuciones que no le corresponden', 4 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_horas_arresto) 
SELECT cat_id, 'Demostrar o expresar inconformidad con su estancia en el establecimiento', 2 FROM car_categoria_falta WHERE cat_nombre = 'FALTAS VARIAS';

-- Comportamiento y Orden
-- GRAVES
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Mal uniformado en la calle', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Usar prendas ajenas al uniforme en la calle', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Ausentarse de clase sin permiso', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Fingir enfermedades', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Desatento con un superior o personas civiles', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Visitar dependencias del establecimiento sin autorización', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'No entregar el reporte de una sanción', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Desordenar en clase', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Conducir vehículo sin licencia', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Disparar su fusil u otra arma sin autorización', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Murmurar las acciones de un Galonista, catedrático u Oficial', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Murmurar las disposiciones de sus superiores', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Tratar de engañar a un Galonista, Catedrático u Oficial', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Evadirse de una formación', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Falto de carácter', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Satisfacer necesidades fisiológicas en lugares no apropiados', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Desordenar en formación', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Evitar sus responsabilidades', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Comportarse mal en servicio de centinela', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Fumar en el establecimiento', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'No presentarse a cumplir con su servicio', 15 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Visitar prostíbulos, cantinas o casas de juego clandestinas', 20 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Provocar escándalo en la calle', 20 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Hacer colectas, rifas o ventas sin autorización de la Dirección', 20 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Dar un testimonio falso', 20 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Evadirse de un castigo', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'No solventar sus deudas', 20 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Llegar tarde al internado después de un franco', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Reñir en clase o en estudio', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Abandonar su armamento, siempre y cuando no incurra en pérdida', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'No asistir al establecimiento sin justificación', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Abandonar su puesto de servicio', 10 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'No presentarse a hacer servicio', 15 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Cambiar servicio sin autorización', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Manifestación de noviazgo dentro del establecimiento educativo', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Dar demostraciones deshonestas con el fin de conseguir un beneficio', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Demostrar conducta impropia de una señorita o caballero en actividades deportivas, sociales y culturales', 8 
FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Presentar tatuajes o perforaciones en su cuerpo', 5 FROM car_categoria_falta WHERE cat_nombre = 'COMPORTAMIENTO Y ORDEN';
-- Salvar Conducto
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Con un Oficial', 5 FROM car_categoria_falta WHERE cat_nombre = 'SALVAR CONDUCTO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Con el Subdirector', 10 FROM car_categoria_falta WHERE cat_nombre = 'SALVAR CONDUCTO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Con el Director', 15 FROM car_categoria_falta WHERE cat_nombre = 'SALVAR CONDUCTO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Con el alto Mando del Ejército', 30 FROM car_categoria_falta WHERE cat_nombre = 'SALVAR CONDUCTO';
-- Desfiles
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'No asistir a un desfile estando organizado', 30 FROM car_categoria_falta WHERE cat_nombre = 'DESFILES';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Reincidencia en no asistir a un desfile estando organizado', 50 FROM car_categoria_falta WHERE cat_nombre = 'DESFILES';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Segunda reincidencia en no asistir a un desfile estando organizado', 75 FROM car_categoria_falta WHERE cat_nombre = 'DESFILES';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Botar su fusil', 10 FROM car_categoria_falta WHERE cat_nombre = 'DESFILES';
-- Arresto
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'No presentarse a cumplir arresto o restricción', 30 FROM car_categoria_falta WHERE cat_nombre = 'ARRESTO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Reincidente en no presentarse a cumplir arresto o restricción', 50 FROM car_categoria_falta WHERE cat_nombre = 'ARRESTO';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Segunda reincidencia en no presentarse a cumplir arresto o restricción', 100 FROM car_categoria_falta WHERE cat_nombre = 'ARRESTO';

-- Exámenes
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Copiar durante un examen', 30 FROM car_categoria_falta WHERE cat_nombre = 'EXAMENES';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Reincidente en copiar durante un examen', 50 FROM car_categoria_falta WHERE cat_nombre = 'EXAMENES';
INSERT INTO car_falta (fal_categoria_id, fal_descripcion, fal_demeritos) 
SELECT cat_id, 'Segunda reincidencia en copiar durante un examen', 100 FROM car_categoria_falta WHERE cat_nombre = 'EXAMENES';

--GRAVISIMAS
-- Faltas gravísimas con sanciones variables (30 deméritos, 50 deméritos o RETIRO)
-- Negarse a cumplir una orden de Galonista, Catedrático u Oficial
