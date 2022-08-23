-- REVISAR
SELECT
-- it.*, "_", tr.*, "____",
SUM(
    tr.nTiempo+
        IF(
        it.nConsecutivo<(
            SELECT it.nConsecutivo -- it.*, "___", tr.* 
            FROM `itinerario` it
            INNER JOIN tramos tr on tr.nNumero=it.nTramo
            WHERE nItinerario=3 AND tr.nDestino=1 -- APAT
        ),
        tr.nEstancia,
        0.1
    )
)as tiempoLlegada
FROM `itinerario` it
INNER JOIN tramos tr on tr.nNumero=it.nTramo
WHERE it.nItinerario=3 
AND it.nConsecutivo>=(
    SELECT it.nConsecutivo -- it.*, "___", tr.* 
    FROM `itinerario` it INNER JOIN tramos tr on tr.nNumero=it.nTramo
    WHERE nItinerario=3 AND tr.nOrigen=8 -- URUA
)
AND it.nConsecutivo<=(
    SELECT it.nConsecutivo -- it.*, "___", tr.* 
    FROM `itinerario` it INNER JOIN tramos tr on tr.nNumero=it.nTramo
    WHERE nItinerario=3 AND tr.nDestino=1 -- APAT
)
-- [segundo intento]
-- REFORMULAR PARA USAR JOINS EN LUGAR DE SUBSONSULTAS

SELECT *
FROM itinerario it
INNER JOIN tramos tro on tro.nNumero=it.nTramo -- and tro.nOrigen=8
RIGHT JOIN tramos ini on tro.nOrigen
where it.nItinerario=3

-- -------------------------------------[TERCER INTENTO]
SELECT * from 
(    
    SELECT it.nItinerario,it. FROM `itinerario` it
    INNER JOIN tramos tr on tr.nNumero=it.nTramo
) as tbl
WHERE tbl.nItinerario=3
and tbl.nConsecutivo>=2 and nConsecutivo<=3