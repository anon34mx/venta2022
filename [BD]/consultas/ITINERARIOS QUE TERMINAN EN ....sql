-- ITINERARIOS QUE TERMINAN EN MORELIA

SELECT
*
FROM itinerario iti
INNER JOIN tramos tr on tr.nNumero=iti.nTramo
WHERE nConsecutivo=(
    SELECT
    MAX(itiSub.nConsecutivo)
    FROM itinerario itiSub
    WHERE itiSub.nItinerario=iti.nItinerario
)
and tr.nDestino=8