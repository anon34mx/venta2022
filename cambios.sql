CREATE TABLE `corridas_versiones` (
  `nNumero` BIGINT UNSIGNED NOT NULL,
  `nItinerario` int(10) UNSIGNED NOT NULL,
  `nTipoServicio` int(10) UNSIGNED NOT NULL,
  `hSalida` time NOT NULL,
  `lLunes` tinyint(1) NOT NULL,
  `lMartes` tinyint(1) NOT NULL,
  `lMiercoles` tinyint(1) NOT NULL,
  `lJueves` tinyint(1) NOT NULL,
  `lViernes` tinyint(1) NOT NULL,
  `lSabado` tinyint(1) NOT NULL,
  `lDomingo` tinyint(1) NOT NULL,
  `fInicio` date NOT NULL,
  `fFin` date NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` datetime DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `corridas_versiones`
  ADD PRIMARY KEY (`nNumero`),
  ADD UNIQUE KEY `nNumero` (`nNumero`),
  ADD KEY `nTipoServicio` (`nTipoServicio`),
  ADD KEY `corridas_versiones_IN` (`nNumero`,`nItinerario`),
  -- ADD KEY `corridas_versiones_user_id` (`user_id`)
  ;
ALTER TABLE `corridas_versiones`
  ADD CONSTRAINT `corridas_versiones_ibfk_1` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`),
  -- ADD CONSTRAINT `corridas_versiones_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
  ;
COMMIT;

CREATE or replace TABLE corridas_disponibles_historial(
    id bigint unsigned not null auto_increment,
    corrida_disponible BIGINT unsigned not null,
    aEstadoAnterior varchar(1) not null,
    aEstadoNuevo varchar(1) not null,
    nConductor int unsigned,
    user 	bigint(20) unsigned not null,

    created_at datetime default current_timestamp,
    updated_at datetime,
    deleted_at datetime,

    PRIMARY KEY (id),

    FOREIGN KEY(corrida_disponible)
    REFERENCES corridasdisponibles(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY(aEstadoAnterior)
    REFERENCES corridas_estados(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(aEstadoNuevo)
    REFERENCES corridas_estados(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,

    

    FOREIGN KEY(nConductor)
    REFERENCES conductores(nNumeroConductor)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
ALTER TABLE corridas_disponibles_historial
  ADD FOREIGN KEY(user)
  REFERENCES users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT



CREATE TABLE boletos_vendidos_estados(
  id varchar(2) not null,
  descripcion varchar(30),

  PRIMARY KEY (id)

);


-- ALTER TABLE boletosvendidos
--   ADD FOREIGN KEY (aEstado)
--     REFERENCES boletos_vendidos_estados(id)
--     ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE `boletosvendidos`
  -- MODIFY aEstado varchar(2) not null,
  ADD CONSTRAINT `FK_boletoEstado` FOREIGN KEY (`aEstado`) REFERENCES `boletos_vendidos_estados` (`id`);

  -- APLICADOS ⏫

drop table failed_jobs;
drop table migrations;
drop table model_has_permissions;
drop table model_has_roles;
drop table password_resets;
drop table personal_access_tokens;
drop table role_has_permissions;
drop table roles;
drop table permissions;


drop table users;

SELECT 
  TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'venta2022d' AND
  REFERENCED_TABLE_NAME = 'users';

-- borrar
ALTER TABLE corridas_versiones
  DROP CONSTRAINT corridas_corridas_disponibles_historial_ibfk_1versiones_user_id;

ALTER TABLE corridas_disponibles_historial
  DROP CONSTRAINT corridas_disponibles_historial_ibfk_1;



ALTER TABLE `corridas_versiones`
ADD FOREIGN KEY (user_id)
REFERENCES users(id)
ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE corridas_disponibles_historial
  DROP CONSTRAINT corridas_disponibles_historial_ibfk_1;
ALTER TABLE corridas_disponibles_historial
ADD FOREIGN KEY(corrida_disponible)
REFERENCES corridasdisponibles(nNumero)
ON UPDATE CASCADE ON DELETE RESTRICT;

{{ date('Y-m-d', strtotime($corridaProgramada->fInicio. ' + 1 days')) }}


CREATE TABLE personas_estados(
    aClave varchar(2) not null,
    descripcion varchar(16), 

    PRIMARY KEY(aClave)
);

INSERT INTO personas_estados VALUES
("AC", "Activo"),
("BA", "Proceso de Baja"),
("PE", "Permiso"),
("AU", "Ausente"),
("CA", "Castigo");

-- ALTER TABLE `conductores` CHANGE `aEstado` `aEstado` VARCHAR(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;
ALTER TABLE conductores
  ADD CONSTRAINT `conductores_estados`
    FOREIGN KEY (`aEstado`) REFERENCES `personas_estados`(`aClave`);


ALTER TABLE personas
ADD COLUMN created_at datetime default current_timestamp,
-- ADD COLUMN updated_at datetime,
ADD COLUMN deleted_at datetime;

DROP TABLE IF EXISTS `registropasopuntos`;
CREATE TABLE `registropasopuntos` (
  `nCorrida` BIGINT unsigned NOT NULL,
  `nConsecutivo` smallint unsigned NOT NULL,
  `fLlegada` datetime,
  `fSalida` datetime,

  PRIMARY KEY (`nCorrida`,`nConsecutivo`),
  -- KEY `nItinerario` (`nItinerario`),
  FOREIGN KEY (nCorrida)
    REFERENCES corridasdisponibles(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE `registropasopuntos`
  ADD `despachado` DATETIME NOT NULL AFTER `nConsecutivo`;


CREATE OR REPLACE TABLE origenesdestinos(
  nOrigen int(10) unsigned not null,
  nDestino int(10) unsigned not null,

  FOREIGN KEY (nOrigen)
  REFERENCES oficinas(nNumero)
  ON UPDATE CASCADE ON DELETE RESTRICT,

  FOREIGN KEY (nDestino)
  REFERENCES oficinas(nNumero)
  ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE UNIQUE INDEX origen_destino ON origenesdestinos (nOrigen,nDestino);



SELECT od.nOrigen, od.nDestino, ori.aNombre, ori.lDisponible, des.aNombre, des.lDisponible
FROM origenesdestinos od
  INNER JOIN oficinas as ori ON ori.nNumero=od.nOrigen
  INNER JOIN oficinas as des ON des.nNumero=od.nDestino
WHERE od.nOrigen=8 AND
ori.lDisponible=1 AND des.lDisponible=1
ORDER BY ori.aNombre, des.aNombre


-- 2022-11-24
ALTER TABLE corridas_disponibles_historial
  ADD COLUMN nConsecutivo smallint unsigned


-- CREAR procedimiento que crea la vista de itinerario-tramos que sirve de ayuda al 
CREATE OR REPLACE PROCEDURE view_iti_tra_update()
BEGIN 
    CREATE OR REPLACE VIEW `vw_iti_tra` AS
    SELECT iti.nItinerario AS itinerario, iti.nConsecutivo AS iti_consecutivo, cadatramo.nConsecutivo AS tra_consecutivo, tra.nNumero AS tramo, tra.nOrigen AS tra_origen, cadatramo.nDestino AS tra_destino
    FROM itinerario iti join tramos tra on(tra.nNumero = iti.nTramo)
    join (
        select itisub.nItinerario AS nItinerario,itisub.nConsecutivo AS nConsecutivo,tramsub.nOrigen AS nOrigen,tramsub.nDestino AS nDestino
        from itinerario itisub join tramos tramsub on tramsub.nNumero = itisub.nTramo
    ) as cadatramo 
        on cadatramo.nItinerario = iti.nItinerario and cadatramo.nConsecutivo >= iti.nConsecutivo
    WHERE tra.nOrigen <> cadatramo.nDestino
    ORDER BY iti.nItinerario ASC, iti.nConsecutivo ASC;
END//

-- ACTUALIZAR vista cuando se inserte o actualice en itinerario o tramos
CREATE TRIGGER tgr_insrt_iti
AFTER INSERT ON itinerario
FOR EACH ROW
BEGIN
  CALL view_iti_tra_update();
END//
CREATE TRIGGER tgr_upt_iti
AFTER UPDATE ON itinerario
FOR EACH ROW
BEGIN
  CALL view_iti_tra_update();
END//

CREATE TRIGGER tgr_insrt_tra
AFTER INSERT ON tramos
FOR EACH ROW
BEGIN
  CALL view_iti_tra_update();
END//
CREATE TRIGGER tgr_upt_tra
AFTER UPDATE ON tramos
FOR EACH ROW
BEGIN
  CALL view_iti_tra_update();
END//

-- cuando se cancele un asiento
SELECT * FROM `disponibilidad` disp
INNER JOIN disponibilidadasientos as disa on disa.nDisponibilidad=disp.nNumero
where nCorridaDisponible=70 and disa.nAsiento=1;

CREATE TABLE `corridas_versiones` (
  `nNumero` int(10) UNSIGNED NOT NULL,
  `nItinerario` int(10) UNSIGNED NOT NULL,
  `nTipoServicio` int(10) UNSIGNED NOT NULL,
  `hSalida` time NOT NULL,
  `lLunes` tinyint(1) NOT NULL,
  `lMartes` tinyint(1) NOT NULL,
  `lMiercoles` tinyint(1) NOT NULL,
  `lJueves` tinyint(1) NOT NULL,
  `lViernes` tinyint(1) NOT NULL,
  `lSabado` tinyint(1) NOT NULL,
  `lDomingo` tinyint(1) NOT NULL,
  `fInicio` date NOT NULL,
  `fFin` date NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `corridas_versiones`
  ADD PRIMARY KEY (`nNumero`),
  ADD UNIQUE KEY `nNumero` (`nNumero`),
  ADD KEY `nTipoServicio` (`nTipoServicio`),
  ADD KEY `corridas_versiones_IN` (`nNumero`,`nItinerario`);
  
ALTER TABLE `corridas_versiones`
  ADD CONSTRAINT `corridas_versiones_ibfk_1` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`);

ALTER TABLE `corridas_versiones`
    ADD COLUMN user_id bigint(20) unsigned NOT NULL,
    ADD CONSTRAINT `corridas_versiones_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

    ALTER TABLE disponibilidadasientos
ADD COLUMN user_id bigint(20) unsigned NOT NULL,
ADD FOREIGN KEY (user_id) 
REFERENCES users(id)
ON UPDATE CASCADE ON DELETE RESTRICT

-- CORRIDA DE IDA Y REGRESO EN LA VENTA
ALTER TABLE `venta`
ADD `nCorridaIda` BIGINT(20) UNSIGNED NULL DEFAULT NULL AFTER `nSesion`,
ADD `nCorridaRegreso` BIGINT(20) UNSIGNED NULL DEFAULT NULL AFTER `nCorridaIda`;



ALTER TABLE venta
ADD FOREIGN KEY (nCorridaIda)
REFERENCES corridasdisponibles(nNumero)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE venta
ADD FOREIGN KEY (nCorridaRegreso)
REFERENCES corridasdisponibles(nNumero)
ON UPDATE CASCADE ON DELETE RESTRICT;

CREATE TABLE cliente_windows(
  id int unsigned not null auto_increment,
  version decimal(5,2) unsigned,
  liberado datetime,

  created_at datetime DEFAULT current_timestamp,

  PRIMARY KEY (id)
);

ALTER TABLE `terminales` ADD `hwid` TEXT NOT NULL AFTER `aDescripcion`;

-- Mejoró la carga de 3s a 1s

CREATE INDEX corridasdisponibles_index on corridasdisponibles
(nNumero, fSalida, aEstado, nItinerario, nTipoServicio,nNumeroAutobus);

CREATE INDEX autobuses_index on autobuses
(nNumeroAutobus, nTipoServicio, nDistribucionAsientos);

CREATE INDEX distribucionasientos_index on distribucionasientos
(nNumero, nAsientos);

CREATE INDEX tiposervicio_index on tiposervicio
(nNumero, aClave);

CREATE INDEX disponibilidadasientos_index on disponibilidadasientos
(nDisponibilidad, nAsiento, aEstadoAsiento);

CREATE INDEX disponibilidad_index on disponibilidad
(nNumero, nOrigen, nDestino, fSalida, hSalida);

CREATE INDEX itinerario_index on itinerario
(nItinerario, nTramo);

CREATE INDEX registropasopuntos_index on registropasopuntos
(nCorrida, nConsecutivo);

CREATE INDEX tarifastramos_index on tarifastramos
(nOrigen, nDestino, nTipoServicio, fAplicacion);


CREATE TABLE boletosTransferidos(
  id int unsigned not null auto_increment,
  corrida_anterior bigint(20) unsigned,
  boleto bigint(20) unsigned,

  PRIMARY KEY(id),

  FOREIGN KEY (corrida_anterior)
  REFERENCES corridasdisponibles(nNumero)
  ON UPDATE CASCADE ON DELETE RESTRICT,

  FOREIGN KEY (boleto)
  REFERENCES corridasdisponibles(nNumero)
  ON UPDATE CASCADE ON DELETE RESTRICT
  
);


CREATE TABLE serviciosABordo(
    id smallint unsigned not null auto_increment,
    descripcion varchar(30) not null,
    imagen text,

    PRIMARY KEY(id)
);

CREATE TABLE tiposervicioAbordo(
    tiposervicio_id int(10) unsigned not null,
    servicioabordo_id smallint unsigned not null,

    FOREIGN KEY (tiposervicio_id)
    REFERENCES tiposervicio(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (servicioabordo_id)
    REFERENCES serviciosABordo(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO `serviciosabordo`(`descripcion`, `imagen`) VALUES
('Aire acondicinado',''),
('Audio',''),
('Baños separados','Banos Separados.png'),
('Cafetera',''),
('Pantallas',''),
('Ubicación',''),
('Venta a bordo',''),
('Wifi',''),
('Baño hombres','Bano_h.png'),
('Baño mujeres','Bano_m.png');


INSERT INTO `tiposervicioAbordo`(`tiposervicio_id`, `servicioabordo_id`)
VALUES
-- Platinum
(1, 2),
(1, 4),
(1, 6),
(1, 8),
(1, 10),
(1, 11),
-- Ultra
(2, 2),
(2, 4),
(2, 6),
-- Express 
(3, 2),
(3, 4),
(3, 6),
-- Premium class
(4, 2),
(4, 4),
(4, 6),
-- Business class
(5, 2),
(5, 4),
(5, 6);


-- https://www.digitalocean.com/community/tutorials/how-to-improve-database-searches-with-full-text-search-in-mysql-5-6-on-ubuntu-16-04
CREATE TABLE remitentes(
    id bigint unsigned not null auto_increment,
    RFC varchar(13),
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
    CP varchar(6),
    municipio varchar(60),
    ciudad varchar(50),
    estado varchar(34),
    pais varchar(34),

    PRIMARY KEY(id)
);
ALTER TABLE remitentes ADD FULLTEXT (nombres, apellidos, correo);
ALTER TABLE remitentes ADD FULLTEXT (CURP);

INSERT INTO `remitentes` (`id`, `RFC`, `CURP`, `telefono1`, `telefono2`, `nombres`, `apellidos`, `correo`, `calle`, `numExt`, `numInt`, `colonia`, `municipio`, `ciudad`, `estado`, `pais`, CP)
VALUES
(NULL, 'AUCJ941217S61', 'AUCJ941217HMNGSH06', '4432443657', '4432443656', 'JAHAZIEL AARON', 'AGUILERA CASTILLO', 'a.non34@hotmail.com', 'calle', '200', NULL, 'colonia ', 'MORELIA', 'MORELIA', 'MICHOACAN', 'MEXICO', "5XXXX"),
(NULL, 'AUCJ941217S61', 'AUCJ941217HMNGSH06', '4432443657', '', 'JAHAZIEL AARON', 'AGUILERA CASTILLO', 'aaron.aguilera@parhikuni.mx', 'MARTIN MONGE', '113', NULL, 'Nva Valladolid', 'MORELIA', 'MORELIA', 'MICHOACAN', 'MEXICO', "58190"),
(NULL, 'ABCD700101S61', 'ABCD700101HMNGSH06', '4433025068', '', 'JUAN', 'LOPEZ PEREZ', 'JLP@OUTLOOK.COM', 'JOAQUIN RIVADENEIRA', '503', NULL, 'JUSTO MENDOZA', 'MORELIA', 'MORELIA', 'MICHOACAN', 'MEXICO', "581XX"),

SELECT * FROM remitentes WHERE
CURP='AUCJ941217HMNGSH06' OR 
RFC='AUCJ941217S61' OR
correo='aaron.aguilera@parhikuni.mx' OR
telefono1='4432443657' OR
telefono2='4432443656' OR
MATCH (nombres, apellidos, correo)
AGAINST ('auCJ' IN NATURAL LANGUAGE MODE);


ALTER TABLE asentamientos ADD FULLTEXT (d_asenta);
ALTER TABLE ciudades ADD FULLTEXT (nombre);
ALTER TABLE estado ADD FULLTEXT (nombre);
ALTER TABLE municipios ADD FULLTEXT (nombre);

--    ####################################
--    ####################################
--    ####################################
-- CREATE TABLE tamañoPaquetes