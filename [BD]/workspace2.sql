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
-- ##############################################################################################################################