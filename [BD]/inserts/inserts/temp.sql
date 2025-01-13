SELECT
TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
    SELECT
    IF(SUM(tr.nTiempo)+tr.nEstancia IS NULL, 0, SUM(tr.nTiempo)+tr.nEstancia)
    FROM `itinerario` itiSub
    INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
    WHERE itiSub.nItinerario=iti.nItinerario
    and itiSub.nConsecutivo<(
        SELECT itiSub2.nConsecutivo FROM `itinerario` itiSub2
        INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo
        WHERE itiSub2.nItinerario=iti.nItinerario and trSub.nOrigen=tra.nOrigen
    )
) MINUTE as hSalidaCorrida,
-- ANTERIOR
TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
    SELECT
    IF( SUM(trSub.nTiempo) is NULL, 0, SUM(trSub.nTiempo))
    as tiempoTrans
    FROM `itinerario` itiSub
    INNER JOIN tramos trSub on itiSub.nTramo=trSub.nNumero
    WHERE itiSub.`nItinerario`=cordis.nItinerario and itiSub.nConsecutivo<=cadaTramo.nConsecutivo
) MINUTE as hLlegadaCalc,
tra.nNumero, tra.nOrigen, cadaTramo.nDestino
FROM corridasdisponibles cordis
JOIN itinerario iti on iti.nItinerario=cordis.nItinerario
join tramos tra on tra.nNumero=iti.nTramo
JOIN (
    SELECT * from itinerario as itiSub
        INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo -- and itiSub.nConsecutivo>iti.nConsecutivo
) as cadaTramo on cadaTramo.nItinerario=iti.nItinerario and cadaTramo.nConsecutivo>=iti.nConsecutivo
INNER JOIN oficinas as ofiOri on ofiOri.nNumero=tra.nOrigen
INNER JOIN oficinas as ofiDes on ofiDes.nNumero=cadaTramo.nDestino
LEFT JOIN disponibilidad as dis on dis.nCorridaDisponible=cordis.nNumero
    and dis.nOrigen=tra.nOrigen and dis.nDestino=cadaTramo.nDestino
where cordis.nNumero=IN_corrida_dis and dis.nNumero IS NULL AND tra.nOrigen!=cadaTramo.nDestino
order by iti.nConsecutivo;



-- ##################################################
-- ##################################################
-- ##################################################
-- NO NO NO
/*
SELECT
TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
    SELECT
    IF(SUM(tr.nTiempo)+tr.nEstancia IS NULL, 0, SUM(tr.nTiempo)+tr.nEstancia)
    FROM `itinerario` itiSub
    INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
    WHERE itiSub.nItinerario=iti.nItinerario
    and itiSub.nConsecutivo<(
        SELECT itiSub2.nConsecutivo FROM `itinerario` itiSub2
        INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo
        WHERE itiSub2.nItinerario=iti.nItinerario and trSub.nOrigen=tra.nOrigen
    )
) MINUTE as hSalidaCorrida,
TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
    (SELECT
    IF(SUM(tr.nTiempo)+tr.nEstancia IS NULL, 0, SUM(tr.nTiempo)+tr.nEstancia)
    FROM `itinerario` itiSub
    INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
    WHERE itiSub.nItinerario=iti.nItinerario
    and itiSub.nConsecutivo<(
        SELECT itiSub2.nConsecutivo FROM `itinerario` itiSub2
        INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo
        WHERE itiSub2.nItinerario=iti.nItinerario and trSub.nOrigen=tra.nOrigen))
     +
     (SELECT IF( SUM(tr.nEstancia) IS NULL, 0, SUM(tr.nEstancia))
    FROM  itinerario as itiSub
    INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
    WHERE itiSub.nItinerario=iti.nItinerario -- parametro
    AND itiSub.nConsecutivo<(
        SELECT itiSub2.nConsecutivo FROM itinerario as itiSub2
        INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo
        WHERE trSub.nDestino=tra.nDestino AND  itiSub2.nItinerario=iti.nItinerario -- parametros
    ))
) MINUTE as hLlegadaCalc,
tra.nNumero, tra.nOrigen, cadaTramo.nDestino
FROM corridasdisponibles cordis
JOIN itinerario iti on iti.nItinerario=cordis.nItinerario
join tramos tra on tra.nNumero=iti.nTramo
JOIN (
    SELECT * from itinerario as itiSub
        INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo -- and itiSub.nConsecutivo>iti.nConsecutivo
) as cadaTramo on cadaTramo.nItinerario=iti.nItinerario and cadaTramo.nConsecutivo>=iti.nConsecutivo
INNER JOIN oficinas as ofiOri on ofiOri.nNumero=tra.nOrigen
INNER JOIN oficinas as ofiDes on ofiDes.nNumero=cadaTramo.nDestino
LEFT JOIN disponibilidad as dis on dis.nCorridaDisponible=cordis.nNumero
    and dis.nOrigen=tra.nOrigen and dis.nDestino=cadaTramo.nDestino
where cordis.nNumero=2 and dis.nNumero IS NOT NULL AND tra.nOrigen!=cadaTramo.nDestino
order by iti.nConsecutivo;
*/

SELECT
TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
    SELECT
    IF(SUM(tr.nTiempo)+tr.nEstancia IS NULL, 0, SUM(tr.nTiempo)+tr.nEstancia)
    FROM `itinerario` itiSub
    INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
    WHERE itiSub.nItinerario=iti.nItinerario
    and itiSub.nConsecutivo<(
        SELECT itiSub2.nConsecutivo FROM `itinerario` itiSub2
        INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo
        WHERE itiSub2.nItinerario=iti.nItinerario and trSub.nOrigen=tra.nOrigen
    )
) MINUTE as hSalidaCorrida,
-- ANTERIOR
TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (
    (SELECT
    IF( SUM(trSub.nTiempo) is NULL, 0, SUM(trSub.nTiempo))
    as tiempoTrans
    FROM `itinerario` itiSub
    INNER JOIN tramos trSub on itiSub.nTramo=trSub.nNumero
    WHERE itiSub.`nItinerario`=cordis.nItinerario and itiSub.nConsecutivo<=cadaTramo.nConsecutivo)
    +
    (
        SELECT
        IF( SUM(tr.nEstancia) IS NULL, 0, SUM(tr.nEstancia))
        FROM  itinerario as itiSub
        INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo
        WHERE itiSub.nItinerario=3 -- parametro
        AND itiSub.nConsecutivo<(
            SELECT itiSub2.nConsecutivo FROM itinerario as itiSub2
            INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo
            WHERE trSub.nDestino=cadaTramo.nDestino AND  itiSub2.nItinerario=iti.nItinerario -- parametros
        )
    )
) MINUTE as hLlegadaCalc,
tra.nNumero, tra.nOrigen, cadaTramo.nDestino
FROM corridasdisponibles cordis
JOIN itinerario iti on iti.nItinerario=cordis.nItinerario
join tramos tra on tra.nNumero=iti.nTramo
JOIN (
    SELECT * from itinerario as itiSub
        INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo -- and itiSub.nConsecutivo>iti.nConsecutivo
) as cadaTramo on cadaTramo.nItinerario=iti.nItinerario and cadaTramo.nConsecutivo>=iti.nConsecutivo
INNER JOIN oficinas as ofiOri on ofiOri.nNumero=tra.nOrigen
INNER JOIN oficinas as ofiDes on ofiDes.nNumero=cadaTramo.nDestino
LEFT JOIN disponibilidad as dis on dis.nCorridaDisponible=cordis.nNumero
    and dis.nOrigen=tra.nOrigen and dis.nDestino=cadaTramo.nDestino
where cordis.nNumero=IN_corrida_dis and dis.nNumero IS NULL AND tra.nOrigen!=cadaTramo.nDestino
order by iti.nConsecutivo;