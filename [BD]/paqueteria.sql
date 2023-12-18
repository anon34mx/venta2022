SELECT
tipAs.nombre as tipoAsentamiento,
asen.d_codigo as CP, asen.d_asenta as asentamiento, CASE
    WHEN d_zona = "U" THEN "Urbano"
    WHEN d_zona = "R" THEN "Rural"
END as zona,
edo.id estado_id, edo.nombre estado,
mun.id municipio_id, mun.nombre municipio,
cds.id ciudad_id, cds.nombre ciudad
From asentamientos asen
INNER JOIN cat_tipo_asentamiento as tipAs
	ON tipAs.id=asen.tipo_asentamiento_id
INNER JOIN estados edo
	ON edo.id=asen.estado_id
INNER JOIN municipios mun
	ON mun.id=asen.municipio_id
LEFT JOIN ciudades cds
	ON cds.id=asen.ciudad_id AND cds.estado_id=edo.id AND mun.id=asen.municipio_id
WHERE asen.d_asenta like "%agua clara%"
ORDER BY edo.id, mun.id, asen.d_asenta
-- https://www.digitalocean.com/community/tutorials/how-to-improve-database-searches-with-full-text-search-in-mysql-5-6-on-ubuntu-16-04
CREATE TABLE remitentes(
    id bigint unsigned not null auto_increment,
    RFC varchar(12),
    CURP varchar(18),
    telefono1 varchar(12),
    telefono2 varchar(12),

    nombres varchar(30),
    apellidos varchar(30),
    correo varchar(40),

    calle varchar(60),
    numExt varchar(6),
    numInt varchar(6),
    colonia varchar(60),
    municipio varchar(60),
    ciudad varchar(50),
    estado varchar(34),
    pais varchar(34),

    PRIMARY KEY(id)
);

CREATE TABLE tiposPaquetes(
    id smallint unsigned not null auto_increment,
    descripcion varchar(30),

    PRIMARY KEY(id)
);

CREATE TABLE envioPaquetes(
    peso
    
    FK_boleto

);

CREATE TABLE ventaPaqueteria(

);