/*
cd \xampp\mysql\bin\
mysqldump -u root -p venta2022 > res_venta2022_08-15.sql

*/
-- [CREAR DISPONIBILIDAD]
CREATE OR REPLACE FUNCTION crear_disponibilidad(IN_corrida_dis INT)
RETURNS SMALLINT
BEGIN
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
            (
                SELECT
                IF( SUM(trSub.nTiempo) is NULL, 0, SUM(trSub.nTiempo))
                as tiempoTrans
                FROM `itinerario` itiSub
                INNER JOIN tramos trSub on itiSub.nTramo=trSub.nNumero
                WHERE itiSub.`nItinerario`=cordis.nItinerario and itiSub.nConsecutivo<=cadaTramo.nConsecutivo
                ORDER BY itiSub.nConsecutivo ASC -- si sale mal, quitar esto (no deberia :c )
            )
            +
            (
                SELECT
                IF( SUM(tr.nEstancia) IS NULL, 0, SUM(tr.nEstancia))
                FROM  itinerario as itiSub
                INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=cordis.nItinerario -- parametro -- lo cambié, estaba en 3
                AND itiSub.nConsecutivo<(
                    SELECT itiSub2.nConsecutivo FROM itinerario as itiSub2
                    INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo
                    WHERE trSub.nDestino=cadaTramo.nDestino AND  itiSub2.nItinerario=iti.nItinerario -- parametros
                    ORDER BY itiSub2.nConsecutivo ASC -- si sale mal, quitar esto (no deberia :c )
                )
            )
        ) MINUTE as hLlegadaCalc,
        tra.nOrigen, cadaTramo.nDestino
        FROM corridasdisponibles cordis
        JOIN itinerario iti on iti.nItinerario=cordis.nItinerario
        join tramos tra on tra.nNumero=iti.nTramo
        JOIN (
            SELECT itiSub.nItinerario, itiSub.nConsecutivo, tramSub.nOrigen, tramSub.nDestino  from itinerario as itiSub
                INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo -- and itiSub.nConsecutivo>iti.nConsecutivo
        ) as cadaTramo on cadaTramo.nItinerario=iti.nItinerario and cadaTramo.nConsecutivo>=iti.nConsecutivo
        INNER JOIN oficinas as ofiOri on ofiOri.nNumero=tra.nOrigen AND ofiOri.lDestino=1
        INNER JOIN oficinas as ofiDes on ofiDes.nNumero=cadaTramo.nDestino AND ofiDes.lDestino=1
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

-- [CREAR CORRIDAS DISPONIBLES SEGUN LAS PROGRAMADAS]
-- Para una fecha (hoy?)
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
        WHERE IN_fecha>=cop.fInicio and IN_fecha<=cop.fFin and cop.deleted_at IS NULL
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
            -- falta crear el rol maestro para poner el numero de autobus
            INSERT INTO `corridasdisponibles`(`nProgramada`, `nItinerario`, `nTipoServicio`, `fSalida`, `hSalida`,
                    `aEstado`, `nNumeroAutobus`) VALUES
                    (curProg_ID,curProg_nIti,curProg_nTipSer,IN_fecha,curProg_hSal,'D', 
                        (SELECT nNumeroAutobus from autobuses where `nTipoServicio`=curProg_nTipSer limit 1)
                        );
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
el rol maestro se hace para tener una idea de que autobus tendrán
*/
CREATE OR REPLACE FUNCTION corridasPorDia(IN_fIni DATE, IN_dias SMALLINT)
RETURNS INT
BEGIN
    DECLARE fFin DATE;
    DECLARE fMax DATE;
    DECLARE ins INT;
    
    SET fFin=IN_fIni + INTERVAL IN_dias DAY;
    SET ins=0;
    SET fMax=(SELECT max(`fFin`) FROM `corridasprogramadas`);

    WHILE IN_fIni<=fFin AND IN_fIni<=fMax DO
        SET ins=ins+crear_corridas_disponibles(IN_fIni);
        SET IN_fIni = IN_fIni + INTERVAL 1 DAY;
    END WHILE;
    
    RETURN ins;
END; //

-- evento crear corridas automaticamente cada dia
CREATE OR REPLACE EVENT crear_corridasDia
ON SCHEDULE
EVERY 1 DAY
STARTS "2022-08-12 09:31:00" DO
BEGIN
    SELECT corridasPorDia(current_date,10);
END;

-- [APARTAR ASIENTOS]
/*
SET autocommit = OFF;
start transaction;
select estadoAsientos(36, 8, 10, 1, 'a');
UNION
select estadoAsientos(36, 8, 10, 2, 'a');
UNION
select estadoAsientos(36, 8, 10, 3, 'a');
COMMIT;
ROLLBACK;
SET autocommit = 1;
*/
CREATE OR REPLACE
    FUNCTION estadoAsientos(IN_cordis BIGINT UNSIGNED, IN_origen INT UNSIGNED, IN_destino INT UNSIGNED,
        IN_nAsiento SMALLINT UNSIGNED, IN_estado VARCHAR(2))
RETURNS TEXT
BEGIN
    -- variables para manejo de errores
    -- Declare variables to hold diagnostics area information
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT DEFAULT "";
    DECLARE nrows INT UNSIGNED DEFAULT 0;
    DECLARE result TEXT DEFAULT "Corrida no encontrada";

    DECLARE v_done INT DEFAULT FALSE; -- continuar o terminar ciclo siguiente
    DECLARE v_nDispo BIGINT UNSIGNED;
    DECLARE v_disp INT UNSIGNED;
    DECLARE v_origen INT UNSIGNED;
    DECLARE v_destino INT UNSIGNED;
    -- primero seleccionamos los tramos donde se va a apartar
    DECLARE v_recorrido CURSOR FOR
        SELECT origenes.origen, destinos.destino
        FROM (
            SELECT
            iti.nItinerario, iti.nConsecutivo, tr.nOrigen "origen" 
            FROM  `itinerario` iti
            INNER JOIN `tramos` tr on tr.nNumero=iti.nTramo
            WHERE iti.nItinerario=(SELECT nItinerario from corridasdisponibles where corridasdisponibles.nNumero=IN_cordis) -- parametro 1 (CORRIDA)
            and nConsecutivo>=(
                SELECT nConsecutivo FROM  itinerario itiSub
                INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=IN_origen -- parametro 2 (ORIGEN)
            )
            and nConsecutivo<=(
                SELECT nConsecutivo FROM  itinerario itiSub
                INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=iti.nItinerario and tr.nDestino=IN_destino -- parametro 3 (destino)
            )
        ) as origenes
        JOIN (
            SELECT
            iti.nItinerario, iti.nConsecutivo, tr.nDestino "destino"
            FROM  `itinerario` iti
            INNER JOIN `tramos` tr on tr.nNumero=iti.nTramo
            WHERE iti.nItinerario=(SELECT nItinerario from corridasdisponibles where corridasdisponibles.nNumero=IN_cordis) -- parametro 1 (CORRIDA)
            and nConsecutivo>=(
                SELECT nConsecutivo FROM  itinerario itiSub
                INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=IN_origen -- parametro 2 (ORIGEN)
            )
            and nConsecutivo<=(
                SELECT nConsecutivo FROM  itinerario itiSub
                INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=iti.nItinerario and tr.nDestino=IN_destino -- parametro 3 (destino)
            )
        ) as destinos on origenes.nItinerario=destinos.nItinerario
            and origenes.origen!=destinos.destino
            and destinos.nConsecutivo>=origenes.nConsecutivo;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
      GET DIAGNOSTICS CONDITION 1
        code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
    END;
    OPEN v_recorrido;
        read_loop: LOOP
            FETCH v_recorrido INTO v_origen, v_destino;
            IF v_done THEN
                LEAVE read_loop;
            END IF;

            SELECT nNumero INTO v_nDispo FROM `disponibilidad`
            WHERE `nCorridaDisponible`=IN_cordis
            AND `nOrigen`= v_origen AND nDestino=v_destino;

            INSERT INTO disponibilidadasientos (nDisponibilidad,nAsiento,aEstadoAsiento)
            VALUES (v_nDispo, IN_nAsiento, IN_estado);

            -- saber si hubo errores
            IF code = '00000' THEN
                GET DIAGNOSTICS @nrows = ROW_COUNT;
                SET nrows=nrows+1;
                SET result = CONCAT('insert succeeded, row count = ',nrows);
            ELSE
                SET result = CONCAT('insert failed, error = ',code,', message = ',msg);
                LEAVE read_loop;
            END IF;
        END LOOP;
    CLOSE v_recorrido;
    RETURN result;
END;

-- LIBERAR ASIENTOS DESPUES DE 15 minutos
-- las reservaciones duran 15 minutos
-- [0] Añadir columna last_update
ALTER TABLE disponibilidadasientos ADD COLUMN last_update DATETIME NOT NULL DEFAULT NOW();
-- [1] Hacer un trigger que indique cuando se insertó/modificó el registro
CREATE OR REPLACE TRIGGER asiento_ultima_actualizacion
BEFORE UPDATE ON disponibilidadasientos
FOR EACH ROW
BEGIN
    SET NEW.last_update=CURRENT_TIMESTAMP;
END;
-- [2] Hacer una consulta que saque los apartados(a) que tengan más de 15 minutos
SELECT *, MINUTE(TIMEDIFF(CURRENT_TIMESTAMP,last_update)) haceXminutos
FROM disponibilidadasientos
WHERE last_update
AND aEstadoAsiento='a' -- v esta es la parte que sirve
AND MINUTE(TIMEDIFF(CURRENT_TIMESTAMP,last_update))>15 
-- [3] Eliminar los apartados del punto [2]
CREATE OR REPLACE EVENT liberar_apartados
ON SCHEDULE
EVERY 2 MINUTE
STARTS CURRENT_TIMESTAMP DO
BEGIN
    DELETE FROM disponibilidadasientos
    WHERE
    aEstadoAsiento='a'
    AND MINUTE(TIMEDIFF(CURRENT_TIMESTAMP,last_update))>15;
END;

