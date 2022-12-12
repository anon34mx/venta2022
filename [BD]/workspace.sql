-- FINAL
SELECT * FROM (
	SELECT
    cordis.nNumero as corrida, cordis.nItinerario, "____" as "___",
    ittr.itinerario as niti, ittr.iti_consecutivo, ittr.tra_consecutivo, ittr.tra_origen, ittr.tra_destino,"____" as "___2",
    bole.nNumero as boleto, bole.nAsiento, bole.aEstado, "____" as "___3"
    ,count(bole.nNumero) as ocupados, disa.nAsientos as  totalAsientos
    FROM corridasdisponibles as cordis
    INNER JOIN vw_iti_tra as ittr
        on ittr.itinerario=cordis.nItinerario
    LEFT JOIN boletosvendidos bole
        on (
            ittr.iti_consecutivo <= ( SELECT iti_consecutivo from vw_iti_tra as vw WHERE vw.iti_consecutivo=cordis.nItinerario and nOrigen=bole.nOrigen ORDER BY iti_consecutivo ASC LIMIT 1) 
            AND ittr.iti_consecutivo <= ( SELECT iti_consecutivo from vw_iti_tra as vw WHERE vw.iti_consecutivo=cordis.nItinerario and nDestino=bole.nDestino ORDER BY iti_consecutivo DESC LIMIT 1)
            )
    	AND ittr.tra_consecutivo>= ( SELECT tra_consecutivo FROM `vw_iti_tra` WHERE tra_origen=bole.nOrigen ORDER BY tra_consecutivo ASC LIMIT 1)
    	AND ittr.tra_consecutivo<= ( SELECT tra_consecutivo FROM `vw_iti_tra` WHERE tra_destino=bole.nDestino ORDER BY tra_consecutivo DESC LIMIT 1)
        AND bole.aEstado IN ("VE", "AP", "LI")
        AND bole.nCorrida=cordis.nNumero
    INNER JOIN autobuses as aut on aut.nNumeroAutobus=cordis.nNumeroAutobus
    INNER JOIN distribucionasientos as disa ON disa.nNumero=aut.nDistribucionAsientos
    WHERE cordis.nNumero=70
    GROUP BY cordis.nNumero, ittr.iti_consecutivo, ittr.tra_origen, ittr.tra_destino
    HAVING count(bole.nNumero) <= disa.nAsientos
    ORDER BY cordis.nNumero, bole.nAsiento, ittr.iti_consecutivo, bole.nNumero
    ) as ddp
where 1
-- and iti_consecutivo>=1
-- and ddp.tra_origen=8 -- and ddp.tra_destinoo=10
ORDER BY ddp.iti_consecutivo, ddp.tra_consecutivo

SELECT -- EDITAR AQUI 1
vis.iti_consecutivo, vis.tra_consecutivo, vis.tramo, vis.tra_origen, vis.tra_destino
FROM vw_iti_tra vis
where
vis.itinerario=6
AND (
    vis.tra_origen=10
    -- OR
    -- (
    --     vis.iti_consecutivo<=(
    --         SELECT (svw.iti_consecutivo) FROM vw_iti_tra svw WHERE svw.itinerario=vis.itinerario and svw.tra_destino=5 LIMIT 1
    --     )
    --     AND
    --     vis.tra_consecutivo > ( -- las que tienen como destino mi origen
    --         SELECT (svw.tra_consecutivo) FROM vw_iti_tra svw WHERE svw.itinerario=vis.itinerario and svw.tra_destino=10 LIMIT 1
    --     )
    -- )
    OR
    (
        vis.iti_consecutivo IN (
            SELECT DISTINCT(vw.iti_consecutivo) FROM `vw_iti_tra` vw
            WHERE vw.itinerario=6 AND (vw.tra_destino=5) ORDER BY vw.iti_consecutivo, vw.tra_consecutivo
        )
        AND
        vis.iti_consecutivo > ( -- las que tienen como destino mi origen
            SELECT (svw.tra_consecutivo) FROM vw_iti_tra svw WHERE svw.itinerario=vis.itinerario and svw.tra_destino=5 LIMIT 1
        )
    )
)
ORDER BY vis.itinerario ASC, vis.iti_consecutivo ASC, vis.tra_consecutivo ASC;


SELECT -- EDITAR AQUI 2 recuperando todos los puntos que se tocan en el recorrido
vis.iti_consecutivo, vis.tra_consecutivo, vis.tramo, vis.tra_origen, vis.tra_destino
FROM vw_iti_tra vis
where
vis.itinerario=6
AND (
        (tra_origen or tra_destino) IN (
            SELECT 
            tr.nOrigen
            FROM itinerario as iti
            INNER JOIN tramos as tr ON tr.nNumero=iti.nTramo
            WHERE iti.nItinerario=vis.itinerario
            AND iti.nConsecutivo >= (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vis.itinerario and trSub.nOrigen=8 -- mi origen
            )
            AND iti.nConsecutivo <= (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vis.itinerario and trSub.nDestino=1 -- mi destino
            )+1
        )
        AND vis.tra_consecutivo > IFNULL(
            (
                SELECT IF(svw.tra_consecutivo IS NULL, 0, svw.tra_consecutivo) FROM `vw_iti_tra` as svw
                WHERE svw.itinerario=vis.itinerario and svw.tra_destino=8 LIMIT 1 -- su destino igual a mi origen, porque aun no le toca subir
            ), 0)
        AND vis.iti_consecutivo < IFNULL(
    		(
                SELECT svw.iti_consecutivo FROM `vw_iti_tra` as svw
                WHERE svw.itinerario=vis.itinerario and svw.tra_origen=1 LIMIT 1 -- su origen igual a mi destino, porque ahí se libera
            ), 9999)
)
ORDER BY vis.itinerario ASC, vis.iti_consecutivo ASC, vis.tra_consecutivo ASC;
-- ########################################################################################
-- otro intento diferente
-- 10 al 1
-- 5 al 1

SELECT * from
vw_iti_tra as vw where vw.itinerario=6
AND 
(
    vw.tra_origen=5 OR
    (
        vw.tra_origen IN (
            SELECT tr.nOrigen FROM itinerario as iti
            INNER JOIN tramos as tr ON tr.nNumero=iti.nTramo
            WHERE iti.nItinerario=vw.itinerario
            AND iti.nConsecutivo >= (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vw.itinerario and trSub.nOrigen=5 -- mi origen
            )
            AND iti.nConsecutivo <= (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=1 -- mi destino
            )+1
        )
        AND vw.iti_consecutivo < ( -- dónde acaba -- #revisar si es <= o =
            SELECT iti.nConsecutivo FROM itinerario as iti
            INNER JOIN tramos as tr ON tr.nNumero=iti.nTramo 
            WHERE iti.nItinerario=vw.itinerario AND tr.nOrigen=1 -- mi destino
        )
    )
    OR 
    (
        vw.tra_destino IN (
            SELECT tr.nOrigen FROM itinerario as iti
            INNER JOIN tramos as tr ON tr.nNumero=iti.nTramo
            WHERE iti.nItinerario=vw.itinerario
            AND iti.nConsecutivo >= (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vw.itinerario and trSub.nOrigen=5 -- mi origen
            )
            AND vw.iti_consecutivo < (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=1 -- mi destino
            )+1
        )
    )
)
ORDER BY vw.itinerario, vw.iti_consecutivo ASC, vw.tra_consecutivo ASC
-- 
SELECT * from
vw_iti_tra as vw where vw.itinerario=6 AND 
(
        vw.tra_destino IN (
            SELECT tr.nOrigen FROM itinerario as iti
            INNER JOIN tramos as tr ON tr.nNumero=iti.nTramo
            WHERE iti.nItinerario=6
            AND iti.nConsecutivo >= (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vw.itinerario and trSub.nOrigen=5 -- mi origen
            )
            -- AND vw.iti_consecutivo <=4
            AND vw.iti_consecutivo < (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=1 -- mi destino
            )+1
        )
) ORDER BY vw.itinerario, vw.iti_consecutivo ASC, vw.tra_consecutivo ASC
-- =============================================
-- va ganando
SELECT * from
vw_iti_tra as vw where vw.itinerario=6 AND 
(
    (
        vw.tra_consecutivo>=IFNULL((
            SELECT itiSub.nConsecutivo FROM itinerario as itiSub
            INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
            WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=10 -- mi origen
            ),
            0
        )
        AND vw.tra_consecutivo>IFNULL(
            (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=10 -- mi origen
            ),
            0
        )
    )
    AND
    (
        vw.iti_consecutivo < IFNULL(
            (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=5 -- mi destino
            )+1,
            9999
        )
        
    )
) ORDER BY vw.itinerario, vw.iti_consecutivo ASC, vw.tra_consecutivo ASC