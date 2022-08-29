-- un itinerario y sus tramos
SELECT * FROM  itinerario iti
INNER JOIN tramos tr on tr.nNumero=iti.nTramo
WHERE iti.nItinerario=3
-- un itinerario y sus tramos por origen
SELECT * FROM  itinerario iti
INNER JOIN tramos tr on tr.nNumero=iti.nTramo
WHERE iti.nItinerario=3
    and nConsecutivo>=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=3 and tr.nOrigen=8 -- parametroo
    )
-- un itinerario y sus tramos por origen y destino
SELECT * FROM  itinerario iti
INNER JOIN tramos tr on tr.nNumero=iti.nTramo
WHERE iti.nItinerario=3
    and nConsecutivo>=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=8 -- parametroo
    )
    and nConsecutivo<=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=iti.nItinerario and tr.nDestino=5 -- parametroo
    )
-- un itinerario y sus tramos por origen y destino
-- y ver los tramos siguientes de un origen
SELECT * FROM  itinerario iti
INNER JOIN tramos tr on tr.nNumero=iti.nTramo
WHERE iti.nItinerario=3
    and nConsecutivo>=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=8 -- parametroo
    )
/*********************/
SELECT
iti.nItinerario "iti", iti.nConsecutivo "consec",tr.nOrigen "origen", tr.nDestino "_des"
FROM  itinerario iti
INNER JOIN tramos tr on tr.nNumero=iti.nTramo
-- /////////////////////
INNER JOIN (
    SELECT itiSub.nItinerario, itiSub.nConsecutivo, itiSub.nTramo, trSub.nOrigen, trSub.nDestino
    FROM  itinerario itiSub
    INNER JOIN tramos trSub on trSub.nNumero=itiSub.nTramo
    -- WHERE iti.nItinerario=3 AND iti.nConsecutivo>=1 AND iti.nConsecutivo<=2
) as trms on trms.nItinerario=iti.nItinerario and trms.nConsecutivo>=iti.nConsecutivo and trms.nConsecutivo<=iti.nConsecutivo
/////////////////////
WHERE iti.nItinerario=3
    and nConsecutivo>=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=8 -- parametroo
    )
    and nConsecutivo<=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=iti.nItinerario and tr.nDestino=5 -- parametroo
    )

    -- ///*****//

SELECT
iti.nItinerario "iti", iti.nConsecutivo "consec",tr.nOrigen "origen", tr.nDestino "_des"
FROM  itinerario iti
INNER JOIN tramos tr on tr.nNumero=iti.nTramo
WHERE iti.nItinerario=3
and nConsecutivo>=(
    SELECT nConsecutivo FROM  itinerario itiSub
    INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
    WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=8 -- parametroo
)
and nConsecutivo<=(
    SELECT nConsecutivo FROM  itinerario itiSub
    INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
    WHERE itiSub.nItinerario=iti.nItinerario and tr.nDestino=5 -- parametroo
)
-- **********
-- obtener el recorrido que se debe apartar
-- parece qie esta es la buena
-- consulta 1/2
-- !!!! FALTA OBTENER EL ITINERARIO
SELECT origenes.nConsecutivo as "consOri", origenes.origen, "_", destinos.nConsecutivo as "consDes", destinos.destino
FROM (
    SELECT
    iti.nItinerario, iti.nConsecutivo, tr.nOrigen "origen" 
    FROM  `itinerario` iti
    INNER JOIN `tramos` tr on tr.nNumero=iti.nTramo
    WHERE iti.nItinerario=(SELECT nItinerario from corridasdisponibles where corridasdisponibles.nNumero=25) -- parametro 1 (CORRIDA)
    and nConsecutivo>=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=8 -- parametro 2 (ORIGEN)
    )
    and nConsecutivo<=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=iti.nItinerario and tr.nDestino=5 -- parametro 3 (destino)
    )
) as origenes
JOIN (
    SELECT
    iti.nItinerario, iti.nConsecutivo, tr.nDestino "destino"
    FROM  `itinerario` iti
    INNER JOIN `tramos` tr on tr.nNumero=iti.nTramo
    WHERE iti.nItinerario=(SELECT nItinerario from corridasdisponibles where corridasdisponibles.nNumero=25) -- parametro 1 (CORRIDA)
    and nConsecutivo>=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=8 -- parametro 2 (ORIGEN)
    )
    and nConsecutivo<=(
        SELECT nConsecutivo FROM  itinerario itiSub
        INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=iti.nItinerario and tr.nDestino=5 -- parametro 3 (destino)
    )
) as destinos on origenes.nItinerario=destinos.nItinerario
    and origenes.origen!=destinos.destino
    and destinos.nConsecutivo>=origenes.nConsecutivo

-- obtener que ocupaciones se necesitan
SELECT nNumero FROM `disponibilidad`
WHERE `nCorridaDisponible`=25
AND `nOrigen`= 8 AND nDestino=10