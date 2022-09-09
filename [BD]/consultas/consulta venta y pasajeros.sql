SELECT
ven.nNumero as 'NIT', ven.fCreacion as 'fechaVenta', 
vp.nMonto, vp.aFolioDocumento, vp.aAutorizacionBanco,
fp.aClave, fp.aDescripcion,
fps.nNumero, fps.aDescripcion,
"_Pasajeros_", -- info de pasajeros/cada boleto
tv.aClave, tv.aDescripcion,
bv.nNumero as 'NUMOP', bv.nCorrida, bv.fSalida, bv.hSalida, bv.nOrigen, bv.nDestino, bv.aTipoPasajero, bv.nAsiento, bv.aPasajero,
"__", -- descuentos
dsc.nNumero as 'descuentoEmpleados',
"__", -- promociones
pro.nNumero as 'promocion', pro.aDescripcion as 'promoción', pro.nDescuento as "promoDescuento"

FROM venta ven
INNER JOIN ventapago vp
    ON vp.nVenta=ven.nNumero
INNER JOIN formaspago fp
    ON fp.aClave=vp.aFormaPago
INNER JOIN formapagosubtipo fps
    ON fps.nNumero=vp.nFormaPagoSubtipo
INNER JOIN boletosvendidos bv
    on bv.nVenta=ven.nNumero
INNER JOIN tipoventa tv
    ON tv.aClave=bv.aTipoVenta

LEFT JOIN boletosvendidos_descuentos bode
    ON bode.nBoletoVendido=bv.nNumero
LEFT JOIN descuentos dsc
    ON dsc.nNumero=bode.nDescuento

LEFT JOIN boletosvendidos_promociones bopr
    ON bopr.nBoletoVendido=bv.nNumero
LEFT JOIN promociones pro
    on pro.nNumero=bopr.nPromocion

WHERE ven.nNumero=1
ORDER BY ven.nNumero asc, bv.nNumero asc