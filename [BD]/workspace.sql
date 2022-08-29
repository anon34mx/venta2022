-- sirve para poner un asiento como
-- ocupado, vendido, bloqueado
-- por secciones de la corrida
-- select estadoAsientos(26, 8,1,1,'a')
CREATE OR REPLACE
    FUNCTION estadoAsientos(IN_cordis BIGINT UNSIGNED, IN_origen INT UNSIGNED, IN_destino INT UNSIGNED, IN_nAsiento SMALLINT UNSIGNED, IN_estado VARCHAR(2))
RETURNS TEXT
BEGIN
    -- DECLARE retorno TEXT DEFAULT "" ;

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

    -- SET retorno=0;
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
        END LOOP;
        -- SET retorno = 'insertado';
    CLOSE v_recorrido;
    RETURN "ok";
END;