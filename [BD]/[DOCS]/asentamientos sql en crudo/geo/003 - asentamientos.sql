
-- SELECT
-- d_codigo, d_asenta, SUBSTR(`d_zona`, 1, 1) as d_zona,
-- `c_tipo_asenta` as tipo_asentamiento_id, `c_estado` as estado_id, `c_mnpio` as municipio_id, 
-- IF(`c_cve_ciudad`="", NULL, `c_cve_ciudad`) as ciudad_id
-- FROM `asentamientos_temp` asen
-- ORDER BY
-- c_estado, c_mnpio, d_codigo
-- DESC;

CREATE OR REPLACE TABLE asentamientos(
    d_codigo varchar(6) not null,
    d_asenta varchar(70) not null,
    d_zona varchar(1) COMMENT "U=urbano, R=rural",

    tipo_asentamiento_id smallint(5) unsigned not null,
    estado_id int(11) not null,
    municipio_clave varchar(3) not null,
    ciudad_id int(11),

    -- PRIMARY KEY (d_codigo, estado_id, municipio_id)
    FOREIGN KEY(tipo_asentamiento_id)
    REFERENCES cat_tipo_asentamiento(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY(estado_id)
    REFERENCES estados(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY(municipio_clave)
    REFERENCES municipios(clave)
    ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY(ciudad_id)
    REFERENCES ciudades(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE=MyIsam ;



ALTER TABLE cat_tipo_asentamiento ENGINE = MyIsam;
ALTER TABLE asentamientos ENGINE = MyIsam;
ALTER TABLE municipios ENGINE = MyIsam;
ALTER TABLE ciudades ENGINE = MyIsam;
ALTER TABLE estados ENGINE = MyIsam;
ALTER TABLE localidades ENGINE = MyIsam;




CREATE INDEX index_tipo_asent
ON cat_tipo_asentamiento (id);

CREATE OR REPLACE INDEX index_ciudades
ON ciudades (id, estado_id,municipio_id);

CREATE OR REPLACE INDEX index_asentamientos
ON asentamientos (d_codigo, estado_id,d_asenta,  municipio_clave);

CREATE OR REPLACE INDEX index_municipios
ON municipios (id, estado_id, clave);

CREATE OR REPLACE INDEX index_estados
ON estados (id, clave);