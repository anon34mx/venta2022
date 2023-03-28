CREATE TABLE corridas_conductores(
    nNumeroCorrida BIGINT(20) UNSIGNED NOT NULL,
    nNumeroConductor int(10) UNSIGNED NOT NULL,
    nNumeroUsuario BIGINT(20) UNSIGNED NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at DATETIME,

    FOREIGN KEY(nNumeroCorrida)
    REFERENCES corridasdisponibles(nNumero)
    ON UPDATE RESTRICT ON DELETE RESTRICT,

    FOREIGN KEY(nNumeroConductor)
    REFERENCES conductores(nNumeroConductor)
    ON UPDATE RESTRICT ON DELETE RESTRICT,

    FOREIGN KEY(nNumeroUsuario)
    REFERENCES users(id)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);