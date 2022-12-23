-- [INSERTAR PASAJERO]
-- *aumentar id de corrida a big int
-- 4,294,967,295
-- 18,446,744,073,709,551,615
-- CREATE OR REPLACE PROCEDURE apartar_asiento(
--     IN IN_nCorrida INT,
--     IN IN_nOrigen INT,
--     IN IN_nDestino INT,
--     IN IN_nAsiento VARCHAR(2),
--     IN IN_user INT
--     )
-- BEGIN
--     DECLARE specialty CONDITION FOR SQLSTATE '45000'; -- es como declarar una excepcion
--     DECLARE retorno TEXT DEFAULT ""; -- mi respuesta
--     DECLARE var_estaOcupado SMALLINT UNSIGNED;
    
--     DECLARE done_restriccion INT DEFAULT FALSE;
--     DECLARE var_disp SMALLINT;
--     DECLARE crsr_restriccion CURSOR FOR SELECT disp.nNumero from
--         corridasdisponibles as cordis
--         INNER JOIN  vw_iti_tra as vw
--             ON cordis.nItinerario=cordis.nItinerario
--         INNER JOIN disponibilidad as disp
--             ON disp.nCorridaDisponible=cordis.nNumero AND disp.nOrigen=vw.tra_origen AND disp.nDestino=vw.tra_destino
--         where 
--         cordis.nNumero=IN_nCorrida
--         AND vw.itinerario=cordis.nItinerario
--         AND 
--         (
--             (
--                 vw.tra_consecutivo>=IFNULL((
--                     SELECT itiSub.nConsecutivo FROM itinerario as itiSub
--                     INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
--                     WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen -- mi origen
--                     ),
--                     0
--                 )
--                 AND vw.tra_consecutivo>IFNULL(
--                     (
--                         SELECT itiSub.nConsecutivo FROM itinerario as itiSub
--                         INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
--                         WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen -- mi origen
--                     ),
--                     0
--                 )
--             )
--             AND
--             (
--                 vw.iti_consecutivo < IFNULL(
--                     (
--                         SELECT itiSub.nConsecutivo FROM itinerario as itiSub
--                         INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
--                         WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nDestino -- mi destino
--                     )+1,
--                     9999
--                 )
                
--             )
--         ) ORDER BY vw.itinerario, vw.iti_consecutivo ASC, vw.tra_consecutivo ASC;

--     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_restriccion = TRUE;
--     -- Para errores
--     declare exit handler for sqlexception
--     BEGIN
--          -- 1062 = clave repetida
--         ROLLBACK;
--         -- SELECT -1 as completado;
--         SIGNAL SQLSTATE '45000' -- Lanza un error, indicando qué tipo es ej. 45000=Error no manejado
-- 			SET MESSAGE_TEXT = "Error al insertar pasajero"; -- declarar mensaje de error
-- 				-- MYSQL_ERRNO  = 1000; -- número que identifica el error (opcional), ej. Problema de claves
--     END;

-- START TRANSACTION; -- Nos permite echar atrás las transacciones (más adelante)
--     -- VALIDACION
-- 	IF IN_nAsiento=0 OR IN_user=0 THEN
--         -- SELECT -1 as completado;
--         SIGNAL SQLSTATE '45000' -- Lanza un error, indicando qué tipo es ej. 45000=Error no manejado
--         SET MESSAGE_TEXT = 'ESCRIBA TODOS LOS DATOS DEL PASAJERO'; -- declarar mensaje de error
--             -- , MYSQL_ERRNO  = 1000; -- número que identifica el error (opcional), ej. Problema de claves
-- 	END IF;

--     -- LIMITAR OCUPACION
--     OPEN crsr_restriccion;
--         read_loop: LOOP
--             FETCH crsr_restriccion INTO var_disp;
--             IF done_restriccion THEN
--                 LEAVE read_loop;
--             END IF;


--             IF (SELECT nAsiento FROM `disponibilidad` as disp INNER JOIN disponibilidadasientos as disa
--                 ON disa.nDisponibilidad=disp.nNumero WHERE disa.nAsiento=IN_nAsiento and disp.nNumero=var_disp) IS NULL THEN
--                 -- INSERT INTO `disponibilidadasientos` (nDisponibilidad, nAsiento, aEstadoAsiento, nBoleto, user_id)
--                 --     VALUES(var_disp, IN_nAsiento, 'A', null, IN_user);
--             ELSE
--                 SIGNAL SQLSTATE '45000' -- Lanza un error, indicando qué tipo es ej. 45000=Error no manejado
--                         SET MESSAGE_TEXT = 'ESCRIBA TODOS LOS DATOS DEL PASAJERO';
--             END IF;


--         END LOOP;
--     CLOSE crsr_restriccion;
--     SELECT 1 as completado; -- Para retornar 1 si se ejecutó correctamente
--     COMMIT;
-- END;
/*
    SELECT insert_pasajero(
        1,      -- IN_nVenta
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

    CALL insert_pasajero(
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
    CALL insert_pasajero(
        1,      -- IN_nVenta
        2,     -- IN_nCorrida
        "2022-11-01",      -- IN_fSalida
        "12:00:00",      -- IN_hSalida
        8,      -- IN_nOrigen
        10,     -- IN_nDestino
        "AD",      -- IN_aTipoPasajero
        "JUAN LOPEZ",      -- IN_aPasajero
        4,      -- IN_nAsiento
        "CO",      -- IN_aTipoVenta
        99.9,      -- IN_nMontoBase
        0.1,      -- IN_nMontoDescuento
        16,      -- IN_nIva
        "VE",      -- IN_aEstado
        1,      -- IN_nTerminal		--DEBE SER FOREIGN
        0,      -- IN_nPromocion
        0       -- IN_nDescuento
    )


CALL insert_pasajero(
    1,      -- IN_nVenta
    111,     -- IN_nCorrida
    "2022-11-01",      -- IN_fSalida
    "12:00:00",      -- IN_hSalida
    8,      -- IN_nOrigen
    1,     -- IN_nDestino
    "AD",      -- IN_aTipoPasajero
    "JUAN LOPEZ",      -- IN_aPasajero
    1,      -- IN_nAsiento
    "CO",      -- IN_aTipoVenta
    99.9,      -- IN_nMontoBase
    0.1,      -- IN_nMontoDescuento
    16,      -- IN_nIva
    "VE",      -- IN_aEstado
    1,      -- IN_nTerminal		--DEBE SER FOREIGN
    0,      -- IN_nPromocion
    0,       -- IN_nDescuento,
    1
)

*/
-- 727 455 864
CREATE OR REPLACE PROCEDURE insert_pasajero(
    IN IN_nVenta INT,
    IN IN_nCorrida INT,
    IN IN_fSalida DATE,
    IN IN_hSalida TIME,
    IN IN_nOrigen INT,
    IN IN_nDestino INT,
    IN IN_aTipoPasajero VARCHAR(2),
    IN IN_aPasajero TEXT,
    IN IN_nAsiento VARCHAR(2),
    IN IN_aTipoVenta VARCHAR(4),
    IN IN_nMontoBase DECIMAL(6,2),
    IN IN_nMontoDescuento DECIMAL(6,2),
    IN IN_nIva DECIMAL(6,2),
    IN IN_aEstado CHAR(20), -- porque este tipo de dato?
    IN IN_nTerminal INT,
    IN IN_nPromocion INT,
    IN IN_nDescuento INT,
    IN IN_user INT
    )
    -- COMMENT 'Usar este procedimiento para la venta, guarda el boleto y restringe la disponibilidad de asientos'
    BEGIN
        DECLARE specialty CONDITION FOR SQLSTATE '45000'; -- es como declarar una excepcion
        DECLARE retorno TEXT DEFAULT ""; -- mi respuesta
        DECLARE var_idBoletoVendido INT DEFAULT 0;
        
        DECLARE done_restriccion INT DEFAULT FALSE;
        
        DECLARE var_disp SMALLINT;
        DECLARE crsr_restriccion CURSOR FOR SELECT disp.nNumero from
            corridasdisponibles as cordis
            INNER JOIN  vw_iti_tra as vw
                ON cordis.nItinerario=cordis.nItinerario
            INNER JOIN disponibilidad as disp
                ON disp.nCorridaDisponible=cordis.nNumero AND disp.nOrigen=vw.tra_origen AND disp.nDestino=vw.tra_destino
            where 
            cordis.nNumero=IN_nCorrida
            AND vw.itinerario=cordis.nItinerario
            AND 
            (
                (
                    vw.tra_consecutivo>=IFNULL((
                        SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                        INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                        WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen -- mi origen
                        ),
                        0
                    )
                    AND vw.tra_consecutivo>IFNULL(
                        (
                            SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                            INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                            WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen -- mi origen
                        ),
                        0
                    )
                )
                AND
                (
                    vw.iti_consecutivo < IFNULL(
                        (
                            SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                            INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                            WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nDestino -- mi destino
                        )+1,
                        9999
                    )
                    
                )
            ) ORDER BY vw.itinerario, vw.iti_consecutivo ASC, vw.tra_consecutivo ASC;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_restriccion = TRUE;
        -- Para errores
        declare exit handler for sqlexception
        BEGIN
            -- 1062 = clave repetida
            ROLLBACK;
            -- SELECT -1 as completado;
            SIGNAL SQLSTATE '45000' -- Lanza un error, indicando qué tipo es ej. 45000=Error no manejado
                SET MESSAGE_TEXT = "Error al insertar pasajero"; -- declarar mensaje de error
                    -- MYSQL_ERRNO  = 1000; -- número que identifica el error (opcional), ej. Problema de claves
        END;

    START TRANSACTION; -- Nos permite echar atrás las transacciones (más adelante)
    -- VALIDACION
	IF IN_nVenta=0 OR IN_fSalida="" OR IN_hSalida="" OR IN_aTipoPasajero="" OR IN_aPasajero=""
		OR IN_nAsiento=0 OR IN_aTipoVenta="" OR IN_nMontoBase=0 OR IN_nIva=0 or IN_aEstado="" 
		OR IN_nTerminal=0
		THEN
            -- SELECT -1 as completado;
			SIGNAL SQLSTATE '45000' -- Lanza un error, indicando qué tipo es ej. 45000=Error no manejado
			SET MESSAGE_TEXT = 'ESCRIBA TODOS LOS DATOS DEL PASAJERO'; -- declarar mensaje de error
				-- , MYSQL_ERRNO  = 1000; -- número que identifica el error (opcional), ej. Problema de claves
	END IF;

    -- INSERTAR BOLETO
    INSERT INTO boletosvendidos
        (nVenta, nCorrida, fSalida, hSalida, nOrigen, nDestino, aTipoPasajero, aPasajero, nAsiento,
            aTipoVenta, nMontoBase, nMontoDescuento, nIva, aEstado, nTerminal)
        VALUES
            (IN_nVenta,IN_nCorrida, IN_fSalida, IN_hSalida, IN_nOrigen, IN_nDestino, IN_aTipoPasajero, IN_aPasajero, IN_nAsiento,
                IN_aTipoVenta, IN_nMontoBase, IN_nMontoDescuento, IN_nIva, IN_aEstado, IN_nTerminal);
    SET var_idBoletoVendido=LAST_INSERT_ID();

    -- LIMITAR OCUPACION
    OPEN crsr_restriccion;
        read_loop: LOOP
            FETCH crsr_restriccion INTO var_disp;
            IF done_restriccion THEN
                LEAVE read_loop;
            END IF;
            INSERT INTO `disponibilidadasientos` (nDisponibilidad, nAsiento, aEstadoAsiento, nBoleto, user_id)
                VALUES(var_disp, IN_nAsiento, 'O', var_idBoletoVendido, IN_user);
        END LOOP;
    CLOSE crsr_restriccion;

    -- REGISTAR SI SE LE APLICÓ PROMOCION
    IF IN_nPromocion!=0 OR IN_nPromocion!=NULL THEN
        INSERT INTO boletosvendidos_promociones (nBoletoVendido, nPromocion)
            VALUES (var_idBoletoVendido,IN_nPromocion);
    END IF;

    IF var_idBoletoVendido!=0 THEN
        SET retorno=var_idBoletoVendido;
    END IF;
    SELECT 1 as completado; -- Para retornar 1 si se ejecutó correctamente
    COMMIT;
END;

/*
SELECT apartar_asiento(
    121,     -- IN_nCorrida
    8,      -- IN_nOrigen
    1,     -- IN_nDestino
    "21,22",      -- IN_nAsiento
    1   -- IN_user
)
SELECT apartar_asiento(
    121,     -- IN_nCorrida
    5,      -- IN_nOrigen
    1,     -- IN_nDestino
    21,      -- IN_nAsiento
    1   -- IN_user
)
*/
-- FUNCIONA
-- CREATE OR REPLACE PROCEDURE apartar_asiento(
--     IN IN_nCorrida INT,
--     IN IN_nOrigen INT,
--     IN IN_nDestino INT,
--     IN IN_nAsiento VARCHAR(2),
--     IN IN_user INT
--     )
-- BEGIN
--     DECLARE specialty CONDITION FOR SQLSTATE '45000'; -- es como declarar una excepcion
--     DECLARE retorno TEXT DEFAULT ""; -- mi respuesta
    
--     DECLARE done_restriccion INT DEFAULT FALSE;
--     DECLARE var_disp SMALLINT;
--     DECLARE crsr_restriccion CURSOR FOR SELECT disp.nNumero from
--         corridasdisponibles as cordis
--         INNER JOIN  vw_iti_tra as vw
--             ON cordis.nItinerario=cordis.nItinerario
--         INNER JOIN disponibilidad as disp
--             ON disp.nCorridaDisponible=cordis.nNumero AND disp.nOrigen=vw.tra_origen AND disp.nDestino=vw.tra_destino
--         where 
--         cordis.nNumero=IN_nCorrida
--         AND vw.itinerario=cordis.nItinerario
--         AND 
--         (
--             (
--                 vw.tra_consecutivo>=IFNULL((
--                     SELECT itiSub.nConsecutivo FROM itinerario as itiSub
--                     INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
--                     WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen -- mi origen
--                     ),
--                     0
--                 )
--                 AND vw.tra_consecutivo>IFNULL(
--                     (
--                         SELECT itiSub.nConsecutivo FROM itinerario as itiSub
--                         INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
--                         WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen -- mi origen
--                     ),
--                     0
--                 )
--             )
--             AND
--             (
--                 vw.iti_consecutivo < IFNULL(
--                     (
--                         SELECT itiSub.nConsecutivo FROM itinerario as itiSub
--                         INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
--                         WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nDestino -- mi destino
--                     )+1,
--                     9999
--                 )
                
--             )
--         ) ORDER BY vw.itinerario, vw.iti_consecutivo ASC, vw.tra_consecutivo ASC;

--     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_restriccion = TRUE;
--     -- Para errores
--     declare exit handler for sqlexception
--     BEGIN
--          -- 1062 = clave repetida
--         ROLLBACK;
--         -- SELECT -1 as completado;
--         SIGNAL SQLSTATE '45000' -- Lanza un error, indicando qué tipo es ej. 45000=Error no manejado
-- 			SET MESSAGE_TEXT = "Error al insertar pasajero"; -- declarar mensaje de error
-- 				-- MYSQL_ERRNO  = 1000; -- número que identifica el error (opcional), ej. Problema de claves
--     END;

-- START TRANSACTION; -- Nos permite echar atrás las transacciones (más adelante)
--     -- VALIDACION
-- 	IF IN_nAsiento=0 OR IN_user=0 THEN
--         -- SELECT -1 as completado;
--         SIGNAL SQLSTATE '45000' -- Lanza un error, indicando qué tipo es ej. 45000=Error no manejado
--         SET MESSAGE_TEXT = 'ESCRIBA TODOS LOS DATOS DEL PASAJERO'; -- declarar mensaje de error
--             -- , MYSQL_ERRNO  = 1000; -- número que identifica el error (opcional), ej. Problema de claves
-- 	END IF;

--     -- LIMITAR OCUPACION
--     OPEN crsr_restriccion;
--         read_loop: LOOP
--             FETCH crsr_restriccion INTO var_disp;
--             IF done_restriccion THEN
--                 LEAVE read_loop;
--             END IF;
--             INSERT INTO `disponibilidadasientos` (nDisponibilidad, nAsiento, aEstadoAsiento, nBoleto, user_id)
--                 VALUES(var_disp, IN_nAsiento, 'A', null, IN_user);
--         END LOOP;
--     CLOSE crsr_restriccion;
--     SELECT LAST_INSERT_ID() as completado; -- Para retornar 1 si se ejecutó correctamente
-- COMMIT;
-- END;