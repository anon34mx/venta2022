SELECT
iti.*, tr.*, ori.aNombre, dest.aNombre
FROM itinerario as iti
INNER JOIN tramos as tr 
    ON tr.nNumero=iti.nTramo
INNER JOIN oficinas as ori
    ON ori.nNumero=tr.nOrigen
INNER JOIN oficinas as dest
    ON dest.nNumero=tr.nDestino
WHERE iti.nItinerario=3