
-- CREATE TABLE grado_academico (
--     grado_academico_id SERIAL PRIMARY KEY,
--     grado_academico_nombre VARCHAR(50) NOT NULL,
--     grado_academico_obs VARCHAR(200),
--     grado_academico_situacion SMALLINT DEFAULT 1
-- );


CREATE TABLE car_instructor (
    ins_id SERIAL PRIMARY KEY,
    ins_catalogo INTEGER,
    ins_catedratico INTEGER, 
    ins_situacion SMALLINT DEFAULT 1,
    FOREIGN KEY (ins_catalogo) REFERENCES mper(per_catalogo), 
    FOREIGN KEY (ins_catedratico) REFERENCES catedratico (cat_catedratico)
);


CREATE TABLE sanciones (
    sancion_id SERIAL PRIMARY KEY,
    sancion_descripcion VARCHAR(100) NOT NULL, 
    horas_arresto INT, 


);



CREATE TABLE arresto_boleta (
    arresto_id SERIAL PRIMARY KEY,
    arresto_alumno INT NOT NULL,
    arresto_oficial_instructor INT NOT NULL,
    arresto_reporto VARCHAR(100) NOT NULL, 
    arresto_motivo INT,             
    arresto_explicacion VARCHAR (200),
    arresto_fecha DATE,
    arresto_cumplio CHAR(1), ---C, P, NC, 
    arresto_descripcion_excusa VARCHAR,  
    arresto_tiene_notiene CHAR(1), ---S--N----------------- 
    arresto_situacion SMALLINT DEFAULT 1, ------ pendiente 
    arresto_observaciones VARCHAR(255), 
    FOREIGN KEY (arresto_alumno) REFERENCES alumnos(alum_catalogo),
    FOREIGN KEY (arresto_oficial_instructor) REFERENCES instructor(instructor_catalogo),
    FOREIGN KEY (arresto_demerito) REFERENCES demeritos(demerito_id), 
    FOREIGN KEY (arresto_sancion) REFERENCES sanciones(sancion_id)        
);



CREATE TABLE registro_sanciones (
    registro_id SERIAL PRIMARY KEY,
    alumno_catalogo INT NOT NULL,
    instructor_catalogo INT NOT NULL, 
    arresto_id INT NOT NULL,           
    sancion_id INT,    
    HORAS CUMPLIDAS -----  
    HORAS PENDIENTES ------ SEA IGUAL A VACIO 

    demerito_id INT,     ----     SITUACION SE CAMBIE A 2 DE CUMPLIDO        
    fecha DATE NOT NULL,
    FOREIGN KEY (alumno_catalogo) REFERENCES alumnos(alum_catalogo),
    FOREIGN KEY (instructor_catalogo) REFERENCES instructor(instructor_catalogo),
    FOREIGN KEY (arresto_id) REFERENCES arresto_boleta(arresto_id),
    FOREIGN KEY (sancion_id) REFERENCES sanciones(sancion_id),
    FOREIGN KEY (demerito_id) REFERENCES demeritos(demerito_id) 
);
