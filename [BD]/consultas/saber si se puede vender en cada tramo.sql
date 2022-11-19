-- CONSULTA PARA DISPONIBLES EN VENTA



-- SABER SI SE PUEDE VENDER 
-- ESTA MAL
SELECT
cordis.nNumero, cordis.nItinerario, cordis.fSalida, cordis.hSalida, cordis.aEstado
, iti.nTramo, tr.nOrigen, tr.nDestino
, "__" as "__", disp.nNumero, disp.fSalida, disp.hSalida
, "__" as "__", reg.nCorrida, reg.despachado, reg.fSalida, reg.fLlegada
FROM `corridasdisponibles` as cordis
INNER JOIN itinerario as iti on iti.nItinerario=cordis.nItinerario
INNER JOIN tramos as tr ON tr.nNumero=iti.nTramo
INNER JOIN disponibilidad as disp ON disp.nCorridaDisponible=cordis.nNumero

LEFT JOIN registropasopuntos reg on reg.nCorrida=cordis.nNumero AND reg.nConsecutivo=iti.nConsecutivo
WHERE cordis.nNumero=34

-- #    #   #   #   #   #   #   #   #   #   #   #
SELECT
cordis.*, "____" as "____",
iti.*, "____" as "____",
disp.*, "____" as "____",
reg.*, "____" as "____"
FROM corridasdisponibles as cordis
INNER JOIN itinerario as iti ON iti.nItinerario=cordis.nItinerario
INNER JOIN disponibilidad as disp ON disp.nCorridaDisponible=cordis.nNumero
	LEFT JOIN registropasopuntos as reg ON reg.nCorrida=cordis.nNumero AND reg.nConsecutivo=iti.nConsecutivo
WHERE cordis.nNumero=38
AND cordis.aEstado!="C" AND cordis.aEstado!="B"
-- AND disp.nOrigen=10
-- cordis.fSalida>=CURRENT_DATE AND cordis.fSalida < DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY);
ORDER BY cordis.nNumero ASC, iti.nConsecutivo ASC, disp.fSalida ASC, disp.hSalida ASC

-- #    #   #   #   #   #   #   #   #   #   #   #

