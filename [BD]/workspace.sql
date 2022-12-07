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

-- TRAMOS DONDE SE DEBE RESTRINGIR LA VENTA
-- CUANDO SE COMPRA UN BOLETO DESDE tra_origen HASTA tra_destino
-- de URUA a CCAM 10->5
SELECT
vis.iti_consecutivo, vis.tra_consecutivo, vis.tramo, vis.tra_origen, vis.tra_destino
FROM vw_iti_tra vis
where
vis.itinerario=3 AND 
(
    -- cuando el origen es el mismo
    vis.iti_consecutivo = (
        SELECT svw.iti_consecutivo
            from vw_iti_tra svw
            where svw.itinerario=vis.itinerario and svw.tra_origen=8 -- parametro
            ORDER BY svw.iti_consecutivo, svw.tra_consecutivo LIMIT 1)
    OR 
    (
        vis.tra_consecutivo >= (SELECT svw.tra_consecutivo
            from vw_iti_tra svw
            where svw.itinerario=vis.itinerario and svw.tra_destino=1 -- parametro
            ORDER BY svw.iti_consecutivo, svw.tra_consecutivo LIMIT 1)
    )
)
ORDER BY vis.itinerario ASC, vis.iti_consecutivo ASC, vis.tra_consecutivo ASC



/*
 OR vis.iti_consecutivo <= (
            SELECT svw.iti_consecutivo
            from vw_iti_tra svw
            where svw.itinerario=vis.itinerario and svw.tra_destino=1 -- parametro
            ORDER BY svw.iti_consecutivo DESC, svw.tra_consecutivo LIMIT 1
*/
-- AQUI     #############################################################################   AQUi
-- ################################################################################################
SELECT
vis.iti_consecutivo, vis.tra_consecutivo, vis.tramo, vis.tra_origen, vis.tra_destino
FROM vw_iti_tra vis
where
vis.itinerario=3 AND 
(
    -- cuando el origen es el mismo
    vis.iti_consecutivo = (
        SELECT svw.iti_consecutivo
            from vw_iti_tra svw
            where svw.itinerario=vis.itinerario and svw.tra_origen=8 -- parametro
            ORDER BY svw.iti_consecutivo, svw.tra_consecutivo LIMIT 1)
    OR 
    (
        vis.tra_consecutivo >= (SELECT svw.tra_consecutivo
            from vw_iti_tra svw
            where svw.itinerario=3 AND svw.tra_origen=8
            AND svw.tra_destino=1 -- parametro
            ORDER BY svw.iti_consecutivo, svw.tra_consecutivo)
    )
)
ORDER BY vis.itinerario ASC, vis.iti_consecutivo ASC, vis.tra_consecutivo ASC










(
    vis.iti_consecutivo IN (
        SELECT DISTINCT(vw.iti_consecutivo) FROM `vw_iti_tra` vw
        WHERE vw.itinerario=vis.itinerario AND (vw.tra_origen=10)
        ORDER BY vw.iti_consecutivo, vw.tra_consecutivo
    )
    OR
    (
        vis.tra_consecutivo >= (
            SELECT min(svw.tra_consecutivo)
            FROM `vw_iti_tra` svw
            WHERE svw.itinerario=vis.itinerario AND (svw.tra_origen=10)
            ORDER BY svw.iti_consecutivo, svw.tra_consecutivo
        )
        AND
        vis.tra_consecutivo < (
            SELECT max(svw.tra_consecutivo)
            FROM `vw_iti_tra` svw
            WHERE svw.itinerario=vis.itinerario AND (svw.tra_destino=1)
            ORDER BY svw.iti_consecutivo, svw.tra_consecutivo
        )
    )
)

-- esta NO es la buena
-- hacer join con la tabla que nos dice los asientos ocupados para no repetirlos
SELECT
vis.iti_consecutivo, vis.tra_consecutivo, vis.tramo, vis.tra_origen, vis.tra_destino
FROM vw_iti_tra vis
where
vis.itinerario=6 AND 
(
    -- cuando el origen es el mismo
    vis.iti_consecutivo = (
        SELECT svw.iti_consecutivo
            from vw_iti_tra svw
            where svw.itinerario=vis.itinerario and svw.tra_origen=10 -- parametro
            ORDER BY svw.iti_consecutivo, svw.tra_consecutivo LIMIT 1)
    OR 
    (
        tra_consecutivo<=(
            SELECT svw.tra_consecutivo
            from vw_iti_tra svw
            where svw.itinerario=vis.itinerario
            AND svw.tra_destino=1 -- parametro
            ORDER BY svw.iti_consecutivo, svw.tra_consecutivo DESC
            LIMIT 1
        )
        AND
        tra_consecutivo>=(
            SELECT svw.tra_consecutivo
                from vw_iti_tra svw
                where svw.itinerario=vis.itinerario
                AND svw.tra_origen=10
                ORDER BY svw.iti_consecutivo, svw.tra_consecutivo ASC
			    LIMIT 1
        )
    )
)
ORDER BY vis.itinerario ASC, vis.iti_consecutivo ASC, vis.tra_consecutivo ASC


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
                WHERE itiSub.nItinerario=vis.itinerario and trSub.nOrigen=5 -- mi origen
            )
            AND iti.nConsecutivo <= (
                SELECT itiSub.nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=vis.itinerario and trSub.nDestino=9 -- mi destino
            )+1
        )
        AND vis.tra_consecutivo>(
            SELECT svw.tra_consecutivo FROM `vw_iti_tra` as svw
            WHERE svw.itinerario=vis.itinerario and svw.tra_destino=5 LIMIT 1 -- su destino igual a mi origen, porque aun no le toca subir
        )
        AND vis.iti_consecutivo < (
            SELECT svw.iti_consecutivo FROM `vw_iti_tra` as svw
            WHERE svw.itinerario=vis.itinerario and svw.tra_origen=9 LIMIT 1 -- su destino igual a mi destino, porque ahí se libera
        )
)
ORDER BY vis.itinerario ASC, vis.iti_consecutivo ASC, vis.tra_consecutivo ASC;