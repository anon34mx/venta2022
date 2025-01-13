/*
cd \xampp\mysql\bin\
mysqldump -u root -p venta2022 > res_venta2022_08-15.sql

*/
-- [CREAR DISPONIBILIDAD]
-- SELECT crear_disponibilidad(22);
-- CREATE OR REPLACE FUNCTION crear_disponibilidad(IN_corrida_dis INT)
-- RETURNS SMALLINT
-- BEGIN
--     DECLARE curDisp_nTramo INT UNSIGNED;
--     DECLARE curDisp_nOrigen INT UNSIGNED;
--     DECLARE curDisp_nDestino INT UNSIGNED;
--     DECLARE curDisp_hLlega DATETIME;
--     DECLARE curDisp_hSale DATETIME;
--     DECLARE curDisp_inserted BOOLEAN;
    
--     DECLARE done INT DEFAULT FALSE; -- continuar o terminar ciclo
--     DECLARE cursor_Disp CURSOR FOR SELECT
--         TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
--             SELECT
--             IF( SUM(trSub.nTiempo) is NULL, 0, SUM(trSub.nTiempo))
--             as tiempoTrans
--             FROM `itinerario` itiSubLl
--             INNER JOIN tramos trSub on itiSubLl.nTramo=trSub.nNumero
--             WHERE itiSubLl.`nItinerario`=cordis.nItinerario and itiSubLl.nConsecutivo<cadaTramo.nConsecutivo
--         ) MINUTE as hLlegadaCalc,
--         TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
--             SELECT
--             IF( SUM(trSub.nTiempo)+trSub.nEstancia is NULL, 0, SUM(trSub.nTiempo)+trSub.nEstancia)
--             as tiempoTrans
--             FROM `itinerario` itiSub
--             INNER JOIN tramos trSub on itiSub.nTramo=trSub.nNumero
--             WHERE itiSub.`nItinerario`=cordis.nItinerario and itiSub.nConsecutivo<cadaTramo.nConsecutivo
--         ) MINUTE as hSalidaCorrida,
--         tra.nNumero, tra.nOrigen, cadaTramo.nDestino
--         -- cordis.nNumero as cordis, cordis.nProgramada, cordis.nItinerario, cordis.fSalida, cordis.hSalida,
--         -- , ofiOri.aNombre, , ofiDes.aNombre,
--         -- dis.nNumero
--         FROM corridasdisponibles cordis
--         JOIN itinerario iti on iti.nItinerario=cordis.nItinerario
--         join tramos tra on tra.nNumero=iti.nTramo
--         JOIN (
--             SELECT * from itinerario as itiSub
--                 INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo
--         ) as cadaTramo on cadaTramo.nItinerario=iti.nItinerario
--         INNER JOIN oficinas as ofiOri on ofiOri.nNumero=tra.nOrigen
--         INNER JOIN oficinas as ofiDes on ofiDes.nNumero=cadaTramo.nDestino
--         LEFT JOIN disponibilidad as dis on dis.nCorridaDisponible=cordis.nNumero
--             and dis.nOrigen=tra.nOrigen and dis.nDestino=cadaTramo.nDestino

--         where cordis.nNumero=IN_corrida_dis and dis.nNumero IS NULL AND tra.nOrigen!=cadaTramo.nDestino
--         order by iti.nConsecutivo;
    
--     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

--     SET curDisp_inserted=0;

--     OPEN cursor_Disp;
--         read_loop: LOOP
--             FETCH cursor_Disp INTO curDisp_hLlega, curDisp_hSale, curDisp_nTramo, curDisp_nOrigen, curDisp_nDestino;-- INTO ,  curDisp_fLlega, , curDisp_fSale, 
--             IF done THEN
--                 LEAVE read_loop;
--             END IF;

--             INSERT INTO disponibilidad
--                 (`nCorridaDisponible`, `nTramo`, `nOrigen`, `nDestino`, `fLlegada`, `hLlegada`, `fSalida`, `hSalida`)
--                 VALUES (IN_corrida_dis, curDisp_nTramo, curDisp_nOrigen, curDisp_nDestino, DATE(curDisp_hLlega), TIME(curDisp_hLlega), DATE(curDisp_hSale), TIME(curDisp_hSale));
--         SET curDisp_inserted=curDisp_inserted+1;
--         END LOOP;
--     CLOSE cursor_Disp;
--     RETURN curDisp_inserted;
-- END;
-- CREATE OR REPLACE FUNCTION crear_disponibilidad(IN_corrida_dis INT)
-- RETURNS SMALLINT
-- BEGIN
--     DECLARE curDisp_nTramo INT UNSIGNED;
--     DECLARE curDisp_nOrigen INT UNSIGNED;
--     DECLARE curDisp_nDestino INT UNSIGNED;
--     DECLARE curDisp_hLlega DATETIME;
--     DECLARE curDisp_hSale DATETIME;
--     DECLARE curDisp_inserted BOOLEAN;
    
--     DECLARE done INT DEFAULT FALSE; -- continuar o terminar ciclo
--     DECLARE cursor_Disp CURSOR FOR SELECT
--     TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
--         SELECT
--         IF( SUM(trSub.nTiempo)+trSub.nEstancia is NULL, 0, SUM(trSub.nTiempo)+trSub.nEstancia)
--         as tiempoTrans
--         FROM `itinerario` itiSubLl
--         INNER JOIN tramos trSub on itiSubLl.nTramo=trSub.nNumero
--         WHERE itiSubLl.`nItinerario`=cordis.nItinerario and itiSubLl.nConsecutivo<cadaTramo.nConsecutivo
--     ) MINUTE as hSalidaCorrida,
--     TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
--         SELECT
--         IF( SUM(trSub.nTiempo) is NULL, 0, SUM(trSub.nTiempo))
--         as tiempoTrans
--         FROM `itinerario` itiSub
--         INNER JOIN tramos trSub on itiSub.nTramo=trSub.nNumero
--         WHERE itiSub.`nItinerario`=cordis.nItinerario and itiSub.nConsecutivo<=cadaTramo.nConsecutivo
--     ) MINUTE as hLlegadaCalc,
--     tra.nNumero, tra.nOrigen, cadaTramo.nDestino
--     FROM corridasdisponibles cordis
--     JOIN itinerario iti on iti.nItinerario=cordis.nItinerario
--     join tramos tra on tra.nNumero=iti.nTramo
--     JOIN (
--         SELECT * from itinerario as itiSub
--             INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo
--     ) as cadaTramo on cadaTramo.nItinerario=iti.nItinerario
--     INNER JOIN oficinas as ofiOri on ofiOri.nNumero=tra.nOrigen
--     INNER JOIN oficinas as ofiDes on ofiDes.nNumero=cadaTramo.nDestino
--     LEFT JOIN disponibilidad as dis on dis.nCorridaDisponible=cordis.nNumero
--         and dis.nOrigen=tra.nOrigen and dis.nDestino=cadaTramo.nDestino
--     where cordis.nNumero=IN_corrida_dis and dis.nNumero IS NULL AND tra.nOrigen!=cadaTramo.nDestino
--     order by iti.nConsecutivo;
    
--     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

--     SET curDisp_inserted=0;

--     OPEN cursor_Disp;
--         read_loop: LOOP
--             FETCH cursor_Disp INTO curDisp_hSale, curDisp_hLlega, curDisp_nTramo, curDisp_nOrigen, curDisp_nDestino;-- INTO ,  curDisp_fLlega, , curDisp_fSale, 
--             IF done THEN
--                 LEAVE read_loop;
--             END IF;

--             INSERT INTO disponibilidad
--                 (`nCorridaDisponible`, `nTramo`, `nOrigen`, `nDestino`, `fLlegada`, `hLlegada`, `fSalida`, `hSalida`)
--                 VALUES (IN_corrida_dis, curDisp_nTramo, curDisp_nOrigen, curDisp_nDestino, DATE(curDisp_hLlega), TIME(curDisp_hLlega), DATE(curDisp_hSale), TIME(curDisp_hSale));
--         SET curDisp_inserted=curDisp_inserted+1;
--         END LOOP;
--     CLOSE cursor_Disp;
--     RETURN curDisp_inserted;
-- END;
/*
drop database venta2022b;
create database venta2022b;
use venta2022b;
*/


CREATE OR REPLACE FUNCTION crear_disponibilidad(IN_corrida_dis INT)
RETURNS SMALLINT
BEGIN
    -- DECLARE curDisp_nTramo INT UNSIGNED;
    DECLARE curDisp_nOrigen INT UNSIGNED;
    DECLARE curDisp_nDestino INT UNSIGNED;
    DECLARE curDisp_hLlega DATETIME;
    DECLARE curDisp_hSale DATETIME;
    DECLARE curDisp_inserted BOOLEAN;
    
    DECLARE done INT DEFAULT FALSE; -- continuar o terminar ciclo
    DECLARE cursor_Disp CURSOR FOR SELECT
        TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
            SELECT
            IF(SUM(tr.nTiempo)+tr.nEstancia IS NULL, 0, SUM(tr.nTiempo)+tr.nEstancia)
            FROM `itinerario` itiSub
            INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
            WHERE itiSub.nItinerario=iti.nItinerario
            and itiSub.nConsecutivo<(
                SELECT itiSub2.nConsecutivo FROM `itinerario` itiSub2
                INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo
                WHERE itiSub2.nItinerario=iti.nItinerario and trSub.nOrigen=tra.nOrigen
            )
        ) MINUTE as hSalidaCorrida,
        TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
            (SELECT
            IF( SUM(trSub.nTiempo) is NULL, 0, SUM(trSub.nTiempo))
            as tiempoTrans
            FROM `itinerario` itiSub
            INNER JOIN tramos trSub on itiSub.nTramo=trSub.nNumero
            WHERE itiSub.`nItinerario`=cordis.nItinerario and itiSub.nConsecutivo<=cadaTramo.nConsecutivo)
            +
            (
                SELECT
                IF( SUM(tr.nEstancia) IS NULL, 0, SUM(tr.nEstancia))
                FROM  itinerario as itiSub
                INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=3 -- parametro
                AND itiSub.nConsecutivo<(
                    SELECT itiSub2.nConsecutivo FROM itinerario as itiSub2
                    INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo
                    WHERE trSub.nDestino=cadaTramo.nDestino AND  itiSub2.nItinerario=iti.nItinerario -- parametros
                )
            )
        ) MINUTE as hLlegadaCalc,
        tra.nOrigen, cadaTramo.nDestino
        FROM corridasdisponibles cordis
        JOIN itinerario iti on iti.nItinerario=cordis.nItinerario
        join tramos tra on tra.nNumero=iti.nTramo
        JOIN (
            SELECT * from itinerario as itiSub
                INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo -- and itiSub.nConsecutivo>iti.nConsecutivo
        ) as cadaTramo on cadaTramo.nItinerario=iti.nItinerario and cadaTramo.nConsecutivo>=iti.nConsecutivo
        INNER JOIN oficinas as ofiOri on ofiOri.nNumero=tra.nOrigen
        INNER JOIN oficinas as ofiDes on ofiDes.nNumero=cadaTramo.nDestino
        LEFT JOIN disponibilidad as dis on dis.nCorridaDisponible=cordis.nNumero
            and dis.nOrigen=tra.nOrigen and dis.nDestino=cadaTramo.nDestino
        where cordis.nNumero=IN_corrida_dis and dis.nNumero IS NULL AND tra.nOrigen!=cadaTramo.nDestino
        order by iti.nConsecutivo;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET curDisp_inserted=0;

    OPEN cursor_Disp;
        read_loop: LOOP
            FETCH cursor_Disp INTO curDisp_hSale, curDisp_hLlega, curDisp_nOrigen, curDisp_nDestino; -- curDisp_nTramo, 
            IF done THEN
                LEAVE read_loop;
            END IF;

            INSERT INTO disponibilidad
                (`nCorridaDisponible`, `nOrigen`, `nDestino`, `fLlegada`, `hLlegada`, `fSalida`, `hSalida`)
                VALUES (IN_corrida_dis, curDisp_nOrigen, curDisp_nDestino, DATE(curDisp_hLlega), TIME(curDisp_hLlega), DATE(curDisp_hSale), TIME(curDisp_hSale));
        SET curDisp_inserted=curDisp_inserted+1;
        END LOOP;
    CLOSE cursor_Disp;
    RETURN curDisp_inserted;
END; //

-- [CREAR DISPONIBLES SEGUN LAS PROGRAMADAS]
-- Para una fecha (hoy)
-- SELECT crear_corridas_disponibles(current_date)
CREATE OR REPLACE FUNCTION crear_corridas_disponibles(IN_fecha DATE)
RETURNS INT
BEGIN
    -- variables
    DECLARE corridas_insertadas INT;
    DECLARE disponibilidad_insertadas SMALLINT;
        -- corrida programada
    DECLARE totalInserted SMALLINT;
    DECLARE curProg_ID INT;
    DECLARE curProg_nIti INT;
    DECLARE curProg_nTipSer INT;
    DECLARE curProg_hSal TIME;
    DECLARE done INT DEFAULT FALSE; -- continuar o terminar ciclo
    DECLARE cursor_Prog CURSOR FOR SELECT -- Seleccionar corridas programadas que no tengan corrida disponible
        cop.nNumero, cop.nItinerario, cop.nTipoServicio, cop.hSalida
        FROM corridasprogramadas cop
        LEFT JOIN corridasdisponibles cod on cop.nNumero=cod.nProgramada and cod.fSalida=IN_fecha
        WHERE IN_fecha>=cop.fInicio and IN_fecha<=cop.fFin and cop.lBaja=0
        and cod.nNumero IS NULL
        AND (CASE -- ver si se inserta este dia de la semana
            WHEN (cop.lDomingo  AND (SELECT DAYOFWEEK(IN_fecha)=1)) THEN true
            WHEN (cop.lLunes    AND (SELECT DAYOFWEEK(IN_fecha)=2)) THEN true
            WHEN (cop.lMartes   AND (SELECT DAYOFWEEK(IN_fecha)=3)) THEN true
            WHEN (cop.lMiercoles AND (SELECT DAYOFWEEK(IN_fecha)=4)) THEN true
            WHEN (cop.lJueves   AND (SELECT DAYOFWEEK(IN_fecha)=5)) THEN true
            WHEN (cop.lViernes  AND (SELECT DAYOFWEEK(IN_fecha)=6)) THEN true
            WHEN (cop.lSabado   AND (SELECT DAYOFWEEK(IN_fecha)=7)) THEN true
            ELSE false
        end);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE; -- HANDLER es manejo de errores

    SET corridas_insertadas=0; -- 
    SET disponibilidad_insertadas=0; -- 

    OPEN cursor_Prog; -- iniciar ciclo
        read_loop: LOOP -- leer fila
            -- poner las columnas en variables para poder usarlas
            FETCH cursor_Prog INTO curProg_ID, curProg_nIti, curProg_nTipSer, curProg_hSal;
            IF done THEN -- si se encontró otra fila
            LEAVE read_loop;
            END IF;
            -- insertar corrida disponible
            INSERT INTO `corridasdisponibles`(`nProgramada`, `nItinerario`, `nTipoServicio`, `fSalida`, `hSalida`,
                    `aEstado`) VALUES
                    (curProg_ID,curProg_nIti,curProg_nTipSer,IN_fecha,curProg_hSal,'A');
            -- [INICIO] insertar tabla disponibilidad
                -- SET curCorrAct_nNum=LAST_INSERT_ID(); -- Corrida recien insertada
            SET corridas_insertadas=corridas_insertadas+1;
            SET disponibilidad_insertadas = crear_disponibilidad(LAST_INSERT_ID());
        -- termina ciclo
        END LOOP;
    CLOSE cursor_Prog;
    RETURN corridas_insertadas;
END; //




-- [CREAR CORRIDAS PROGRAMADAS PARA X DIAS]
/*
TRUNCATE corridasdisponibles;
TRUNCATE disponibilidad;
SELECT corridasPorDia(CURRENT_DATE, 30);
el rol maestro se hace para 
*/
CREATE OR REPLACE FUNCTION corridasPorDia(IN_fIni DATE, IN_dias SMALLINT)
RETURNS INT
BEGIN
    DECLARE fFin DATE;
    DECLARE ins INT;
    
    SET fFin=IN_fIni + INTERVAL IN_dias DAY;
    SET ins=0;

    WHILE IN_fIni<=fFin DO
        SET ins=ins+crear_corridas_disponibles(IN_fIni);
        SET IN_fIni = IN_fIni + INTERVAL 1 DAY;
    END WHILE;
    
    RETURN ins;
END; //