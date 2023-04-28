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


-- #################################

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

-- ##################################################################

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
----------------
----------------
----------------
CREATE TABLE cliente_windows(
  id int unsigned not null auto_increment,
  version decimal(5,2) unsigned,
  liberado datetime,

  created_at datetime DEFAULT current_timestamp,

  PRIMARY KEY (id)
);

ALTER TABLE `terminales` ADD `hwid` TEXT NOT NULL AFTER `aDescripcion`;