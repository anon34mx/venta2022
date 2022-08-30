-- sirve para poner un asiento como
-- ocupado, vendido, bloqueado
-- por secciones de la corrida
-- select estadoAsientos(25, 10,5,2,'v')

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