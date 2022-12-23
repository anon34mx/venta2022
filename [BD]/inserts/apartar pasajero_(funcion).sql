/*
SELECT apartar_asiento(
    125,
    8,
    1,
    "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20",
    1
)
*/
-- USAR ESTA FUNCION
CREATE OR REPLACE FUNCTION apartar_asiento(
    IN_nCorrida INT,
    IN_nOrigen INT,
    IN_nDestino INT,
    IN_nAsientos TEXT,
    IN_user INT
    )
RETURNS TEXT
BEGIN
    DECLARE specialty CONDITION FOR SQLSTATE '45000'; -- es como declarar una excepcion
    DECLARE retorno TEXT DEFAULT ""; -- mi respuesta
    
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
    declare exit handler for sqlexception BEGIN
        -- ROLLBACK;
        -- RETURN CONCAT("ERROR KK",retorno);
        SIGNAL SQLSTATE '45000' -- Lanza un error, indicando qué tipo es ej. 45000=Error no manejado
			SET MESSAGE_TEXT = "Error al insertar pasajero"; -- declarar mensaje de error
				-- MYSQL_ERRNO  = 1000; -- número que identifica el error (opcional), ej. Problema de claves
    END;

-- START TRANSACTION; -- Nos permite echar atrás las transacciones (más adelante)
    -- VALIDACION
	IF IN_nAsientos="" OR IN_user=0 THEN
        SIGNAL SQLSTATE '45000' -- Lanza un error, indicando qué tipo es ej. 45000=Error no manejado
        SET MESSAGE_TEXT = 'ESCRIBA TODOS LOS DATOS DEL PASAJERO'; -- declarar mensaje de error
	END IF;

    -- LIMITAR OCUPACION
    OPEN crsr_restriccion;
        read_loop: LOOP
            FETCH crsr_restriccion INTO var_disp;
            IF done_restriccion THEN
                LEAVE read_loop;
            END IF;
            
            -- insertar cada uno
            SET @aux=CONCAT(IN_nAsientos,",");
            WHILE (LOCATE(',', @aux)>0) DO
                set @var_asiento=SUBSTRING(@aux, 1,2);
                SET @aux=SUBSTRING(@aux, LOCATE(',',@aux) + 1);

                INSERT INTO `disponibilidadasientos` (nDisponibilidad, nAsiento, aEstadoAsiento, nBoleto, user_id)
                    VALUES(var_disp, @var_asiento, 'A', null, IN_user);
                set retorno=CONCAT(retorno,LAST_INSERT_ID(),",");
            END WHILE;
            
        END LOOP;
    CLOSE crsr_restriccion;
    RETURN CASE 
        WHEN retorno='' THEN "NO INSERTADO"
        ELSE SUBSTRING(retorno, 1, CHAR_LENGTH(retorno)-1)
    END;
-- COMMIT;
END;