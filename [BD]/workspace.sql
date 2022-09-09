-- Alter table boletosvendidos add Foreign Key (nCorrida) references corridasdisponibles (nNumero) on delete  restrict on update  restrict;
-- Alter table boletosvendidos add Foreign Key (nVenta) references venta (nNumero) on delete  restrict on update  restrict;
-- Alter table boletosvendidos add Foreign Key (nOrigen) references oficinas (nNumero) on delete  restrict on update  restrict;
-- Alter table boletosvendidos add Foreign Key (nDestino) references oficinas (nNumero) on delete  restrict on update  restrict;
-- Alter table boletosvendidos add Foreign Key (aTipoVenta) references tipoventa (aClave) on delete  restrict on update  restrict;
-- Alter table boletosvendidos add Foreign Key (aTipoPasajero) references tipopasajero (aClave) on delete  restrict on update  restrict;
-- Alter table boletosvendidos add Foreign Key (nTerminal) references terminales (nNumero) on delete  restrict on update  restrict;
-- Alter table boletosvendidos  ADD COLUMN nFactorPaqueteria int(10) DEFAULT NULL 


-- la tabla descuentos tiene una relacion a la tabla personas (son descuentos para el personal y familiares)
-- ELIMINADAS
-- Alter table boletosvendidos add Foreign Key (nFactorPaqueteria) references factorpaqueteria (nNumero) on delete  restrict on update  CASCADE;
-- Alter table boletosvendidos add Foreign Key (nDescuento) references descuentos (nNumero) on delete  restrict on update  restrict;
-- Alter table boletosvendidos add Foreign Key (nPromocion) references promociones (nNumero) on delete  restrict on update  cascade;
-- Alter table boletosvendidos add Foreign Key (nTipoPaquete) references tipopaquetes (nNumero) on delete  restrict on update  restrict;

CREATE TABLE boletosvendidos_descuentos (
    nBoletoVendido BIGINT UNSIGNED NOT NULL,
    nDescuento INT UNSIGNED NOT NULL,
    
    FOREIGN KEY (nBoletoVendido)
    REFERENCES boletosvendidos(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    
    FOREIGN KEY (nDescuento)
    REFERENCES descuentos(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE boletosvendidos_promociones (
    nBoletoVendido BIGINT UNSIGNED NOT NULL,
    nPromocion INT UNSIGNED NOT NULL,
    
    FOREIGN KEY (nBoletoVendido)
    REFERENCES boletosvendidos(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    
    FOREIGN KEY (nPromocion)
    REFERENCES promociones(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- (PAQUETERIA)
CREATE TABLE boletosvendidos_tipopaquetes (
    nBoletoVendido BIGINT UNSIGNED NOT NULL,
    nTipoPaquete INT UNSIGNED NOT NULL,
    
    FOREIGN KEY (nBoletoVendido)
    REFERENCES boletosvendidos(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    
    FOREIGN KEY (nTipoPaquete)
    REFERENCES tipopaquetes(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE boletosvendidos_factorpaqueteria (
    nBoletoVendido BIGINT UNSIGNED NOT NULL,
    nFactorPaqueteria INT UNSIGNED NOT NULL,
    
    FOREIGN KEY (nBoletoVendido)
    REFERENCES boletosvendidos(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    
    FOREIGN KEY (nFactorPaqueteria)
    REFERENCES factorpaqueteria(nNumero)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

