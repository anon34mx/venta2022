-- sirve para poner un asiento como
-- ocupado, vendido, bloqueado
-- por secciones de la corrida
CREATE OR REPLACE
    FUNCTION estadoAsientos(IN_cordis BIGINT UNSIGNED, IN_origen INT UNSIGNED, IN_nAsiento SMALLINT UNSIGNED, IN_estado VARCHAR(2))
RETURNS TEXT
BEGIN
    DECLARE retorno;

    DECLARE cur_recorrido CURSOR FOR SELECT
        cordis.nNumero as cordis, cordis.nProgramada, cordis.nItinerario,
        iti.*,tr.nOrigen,tr.nDestino
        FROM
        corridasdisponibles as cordis
        INNER  JOIN itinerario as iti on iti.nItinerario=cordis.nItinerario
        INNER JOIN tramos tr on tr.nNumero=iti.nTramo
        where cordis.nNumero=25 -- parametro
        AND iti.nConsecutivo>=(
            SELECT itiSub.nConsecutivo FROM itinerario as itiSub
            INNER JOIN tramos trSub on trSub.nNumero=itiSub.nTramo
            where itiSub.nItinerario=iti.nItinerario
            and trSub.nOrigen=8 -- parametros
        )
        AND iti.nConsecutivo<=(
            SELECT itiSub.nConsecutivo FROM itinerario as itiSub
            INNER JOIN tramos trSub on trSub.nNumero=itiSub.nTramo
            where itiSub.nItinerario=iti.nItinerario
            and trSub.nDestino=10 -- parametros
        );
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET retorno=0;

    OPEN cur_recorrido;
    read_loop: LOOP
/*******/
