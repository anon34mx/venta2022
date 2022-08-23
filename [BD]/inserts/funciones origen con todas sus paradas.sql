SELECT
iti.nItinerario, iti.nConsecutivo, iti.nTramo,
"__",
tr.nOrigen, tr.nDestino, test.nDestino
FROM
itinerario iti
INNER JOIN tramos tr on tr.nNumero=iti.nTramo

JOIN(
    SELECT
    iti.nItinerario, iti.nConsecutivo, iti.nTramo,
    "__",
    tr.nOrigen, tr.nDestino
    FROM
    itinerario iti
    INNER JOIN tramos tr on tr.nNumero=iti.nTramo


    where iti.nItinerario=3 AND iti.nConsecutivo>iti.nConsecutivo
    ) as test on test.nItinerario=iti.nItinerario

where iti.nItinerario=3

order by tr.nOrigen

-- #################
SELECT
iti.nItinerario, iti.nConsecutivo, iti.nTramo,
"__",
tr.nOrigen, tr.nDestino, test.nDestino
FROM
itinerario iti
INNER JOIN tramos tr on tr.nNumero=iti.nTramo

JOIN(
    SELECT
    iti.nItinerario, iti.nConsecutivo, iti.nTramo,
    "__",
    tr.nOrigen, tr.nDestino
    FROM
    itinerario iti
    INNER JOIN tramos tr on tr.nNumero=iti.nTramo


    where iti.nItinerario=3 AND iti.nConsecutivo>=iti.nConsecutivo
    ) as test on test.nItinerario=iti.nItinerario

where iti.nItinerario=3

order by iti.nConsecutivo




-- ##########################################################
-- ##########################################################
-- ##########################################################


SELECT
cordis.nNumero as cordis, cordis.nProgramada, cordis.nItinerario, cordis.fSalida, cordis.hSalida,
"___",
iti.*,
"___",
tra.*,
"___",
test.nDestino
FROM corridasdisponibles cordis
JOIN itinerario iti on iti.nItinerario=cordis.nItinerario
join tramos tra on tra.nNumero=iti.nTramo
JOIN (
	SELECT * from itinerario as itiSub
    	INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo
) as test on test.nItinerario=iti.nItinerario

where cordis.nNumero=4

-- ----------------------------------------------------------------
SELECT
TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
    SELECT
    IF( SUM(trSub.nTiempo) is NULL, 0, SUM(trSub.nTiempo))
    as tiempoTrans
    FROM `itinerario` itiSubLl
    INNER JOIN tramos trSub on itiSubLl.nTramo=trSub.nNumero
    WHERE itiSubLl.`nItinerario`=cordis.nItinerario and itiSubLl.nConsecutivo<cadaTramo.nConsecutivo
) MINUTE as hLlegadaCalc,
TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
    SELECT
    IF( SUM(trSub.nTiempo)+trSub.nEstancia is NULL, 0, SUM(trSub.nTiempo)+trSub.nEstancia)
    as tiempoTrans
    FROM `itinerario` itiSub
    INNER JOIN tramos trSub on itiSub.nTramo=trSub.nNumero
    WHERE itiSub.`nItinerario`=cordis.nItinerario and itiSub.nConsecutivo<cadaTramo.nConsecutivo
) MINUTE as hSalidaCorrida,
tra.nNumero, tra.nOrigen, cadaTramo.nDestino
-- cordis.nNumero as cordis, cordis.nProgramada, cordis.nItinerario, cordis.fSalida, cordis.hSalida,
-- , ofiOri.aNombre, , ofiDes.aNombre,
-- dis.nNumero
FROM corridasdisponibles cordis
JOIN itinerario iti on iti.nItinerario=cordis.nItinerario
join tramos tra on tra.nNumero=iti.nTramo
JOIN (
	SELECT * from itinerario as itiSub
    	INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo
) as cadaTramo on cadaTramo.nItinerario=iti.nItinerario
INNER JOIN oficinas as ofiOri on ofiOri.nNumero=tra.nOrigen
INNER JOIN oficinas as ofiDes on ofiDes.nNumero=cadaTramo.nDestino
LEFT JOIN disponibilidad as dis on dis.nCorridaDisponible=cordis.nNumero
    and dis.nOrigen=tra.nOrigen and dis.nDestino=cadaTramo.nDestino

where cordis.nNumero=4 and dis.nNumero IS NULL AND tra.nOrigen!=cadaTramo.nDestino
order by iti.nConsecutivo