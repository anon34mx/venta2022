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