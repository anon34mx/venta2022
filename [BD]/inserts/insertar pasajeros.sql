-- [INSERTAR PASAJERO]
-- *aumentar id de corrida a big int
-- 4,294,967,295
-- 18,446,744,073,709,551,615

/*
    SELECT insert_pasajero(
        0,      -- IN_nVenta
        37,     -- IN_nCorrida
        0,      -- IN_fSalida
        0,      -- IN_hSalida
        8,      -- IN_nOrigen
        10,     -- IN_nDestino
        0,      -- IN_aTipoPasajero
        0,      -- IN_aPasajero
        0,      -- IN_nAsiento
        0,      -- IN_aTipoVenta
        0,      -- IN_nMontoBase
        0,      -- IN_nMontoDescuento
        0,      -- IN_nIva
        0,      -- IN_aEstado
        0,      -- IN_nTerminal		--DEBE SER FOREIGN
        0,      -- IN_nPromocion
        0       -- IN_nDescuento
    )

    SELECT insert_pasajero(
        1,      -- IN_nVenta
        37,     -- IN_nCorrida
        "2022-08-31",      -- IN_fSalida
        "12:00:00",      -- IN_hSalida
        8,      -- IN_nOrigen
        10,     -- IN_nDestino
        "AD",      -- IN_aTipoPasajero
        "TEST",      -- IN_aPasajero
        4,      -- IN_nAsiento
        "CO",      -- IN_aTipoVenta
        1,      -- IN_nMontoBase
        0,      -- IN_nMontoDescuento
        1,      -- IN_nIva
        "VE",      -- IN_aEstado
        1,      -- IN_nTerminal		--DEBE SER FOREIGN
        0,      -- IN_nPromocion
        0       -- IN_nDescuento
    )

*/
CREATE OR REPLACE FUNCTION insert_pasajero(
    IN_nVenta INT,
    IN_nCorrida INT,
    IN_fSalida DATE,
    IN_hSalida TIME,
    IN_nOrigen INT,
    IN_nDestino INT,
    IN_aTipoPasajero VARCHAR(2),
    IN_aPasajero TEXT,
    IN_nAsiento VARCHAR(2),
    IN_aTipoVenta VARCHAR(4),
    IN_nMontoBase DECIMAL(6,2),
    IN_nMontoDescuento DECIMAL(6,2),
    IN_nIva DECIMAL(6,2),
    IN_aEstado CHAR(20), -- porque este tipo de dato?
    IN_nTerminal INT,
    IN_nPromocion INT,
    IN_nDescuento INT
    )
RETURNS TEXT
BEGIN
    DECLARE specialty CONDITION FOR SQLSTATE '45000'; -- es como declarar una excepcion
    DECLARE retorno TEXT DEFAULT ""; -- mi respuesta
    DECLARE var_idBoletoVendido INT DEFAULT 0;

    -- VALIDACION
	IF IN_nVenta=0 OR IN_fSalida="" OR IN_hSalida="" OR IN_aTipoPasajero="" OR IN_aPasajero=""
		OR IN_nAsiento=0 OR IN_aTipoVenta="" OR IN_nMontoBase=0 OR IN_nIva=0 or IN_aEstado="" 
		OR IN_nTerminal=0
		THEN
			SIGNAL SQLSTATE '45000' -- declarar el codigo de error
			SET MESSAGE_TEXT = 'ESCRIBA TODOS LOS DATOS DEL PASAJERO', -- declarar mensaje de error
				MYSQL_ERRNO  = 1000;
	END IF;

    -- LIMITAR OCUPACION
    
    -- INSERTAR BOLETO
    INSERT INTO boletosvendidos
        (nVenta, nCorrida, fSalida, hSalida, nOrigen, nDestino, aTipoPasajero, aPasajero, nAsiento,
            aTipoVenta, nMontoBase, nMontoDescuento, nIva, aEstado, nTerminal)
        VALUES
            (IN_nVenta,IN_nCorrida, IN_fSalida, IN_hSalida, IN_nOrigen, IN_nDestino, IN_aTipoPasajero, IN_aPasajero, IN_nAsiento,
                IN_aTipoVenta, IN_nMontoBase, IN_nMontoDescuento, IN_nIva, IN_aEstado, IN_nTerminal);
    SET var_idBoletoVendido=LAST_INSERT_ID(); 

    -- REGISTAR SI SE LE APLICÖ PROMOCION
    IF IN_nPromocion!=0 OR IN_nPromocion!=NULL THEN
        INSERT INTO boletosvendidos_promociones (nBoletoVendido, nPromocion)
            VALUES (var_idBoletoVendido,IN_nPromocion);
    END IF;



    IF var_idBoletoVendido!=0 THEN
        SET retorno=var_idBoletoVendido;
    END IF;
    RETURN retorno;
END;