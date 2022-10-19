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
  ADD KEY `corridas_versiones_user_id` (`user_id`);
ALTER TABLE `corridas_versiones`
  ADD CONSTRAINT `corridas_versiones_ibfk_1` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`),
  ADD CONSTRAINT `corridas_versiones_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;
-- ---
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

    FOREIGN KEY(user)
    REFERENCES users(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY(nConductor)
    REFERENCES conductores(nNumeroConductor)
    ON UPDATE CASCADE ON DELETE RESTRICT
);