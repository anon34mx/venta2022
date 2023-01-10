/*
[/] mover columna maximo de descuentos aplicables a tabla de servicio
[/] RELACION POR CORRIDA PROGRAMADA
[/] internet 10%
[/] origen-destino
[/] tipo pasajero
[/] viaje redondo 15%
[?] Por tipo de servicio??

[?] promocion automatica oficina
*/
/************************************/
/************************************/
/************************************/
    SELECT
    tipa.aClave as tipoPasajero, tipa.aDescripcion, tipa.nDescuento descuentoPasajero,
    prom.nNumero clavePromo, prom.aDescripcion as descripPromo, prom.nDescuento porcentProm, prom.fInicio, prom.fFin
    FROM tipopasajero tipa
    LEFT JOIN `promociones` as prom
        ON prom.aTipo=tipa.aClave and prom.fInicio<=CURRENT_DATE and prom.fFin>=CURRENT_DATE -- vigentes
            OR (prom.aTipo IS NULL AND nCorridaProgramada=165) -- por corrida
            OR (prom.aTipo IS NULL AND prom.nOficina=13) -- por oficina de venta
            OR (prom.aTipo IS NULL AND nOrigen=8 and nDestino=10) -- Para origen->destino
            OR (prom.aTipo IS NULL AND viajeRedondo=true) -- Para origen->destino
            OR (prom.aTipo IS NULL AND nTipoServicio=1) -- por servicio
    WHERE
    -- tipa.aClave IS NOT NULL AND
    tipa.aClave="AD"
    ORDER BY tipa.aClave, prom.nDescuento asc
---------
(
    SELECT
    tipa.aClave as tipoPasajero, tipa.aDescripcion,
    prom.nNumero clavePromo, prom.aDescripcion as descripPromo, prom.nDescuento porcentProm, prom.fInicio, prom.fFin
    FROM tipopasajero tipa
    LEFT JOIN `promociones` as prom
        ON prom.aTipo=tipa.aClave and prom.fInicio<=CURRENT_DATE and prom.fFin>=CURRENT_DATE -- vigentes
        AND (
            nCorridaProgramada=6
            OR prom.nOficina=13
            OR (nOrigen=8 and nDestino=10)
            OR viajeRedondo=true
            OR nTipoServicio=1
        )
    WHERE tipa.aClave="AD"
    AND prom.nNumero IS NOT NULL
    ORDER BY prom.nNumero, tipa.aClave, prom.nDescuento asc
)
UNION
(
    SELECT
    tipa.aClave as tipoPasajero, tipa.aDescripcion,
    prom.nNumero clavePromo, prom.aDescripcion as descripPromo, prom.nDescuento porcentProm, prom.fInicio, prom.fFin
    FROM tipopasajero tipa
    LEFT JOIN `promociones` as prom
        ON prom.aTipo=tipa.aClave and prom.fInicio<=CURRENT_DATE and prom.fFin>=CURRENT_DATE -- vigentes
    WHERE
    tipa.aClave!="AD" AND aTipo IS NOT NULL
    GROUP BY prom.aTipo
    ORDER BY tipa.aClave, prom.nDescuento asc
)