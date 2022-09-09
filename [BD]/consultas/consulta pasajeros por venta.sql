SELECT
ven.nNumero as 'NIT',
tv.aClave, tv.aDescripcion,
bv.nNumero as 'NUMOP', bv.nCorrida, bv.fSalida, bv.hSalida, bv.nOrigen, bv.nDestino, bv.aTipoPasajero, bv.nAsiento, bv.aPasajero,
    bv.nMontoBase, bv.nMontoDescuento, nIva, aEstado
FROM venta ven
INNER JOIN boletosvendidos bv
    on bv.nVenta=ven.nNumero
INNER JOIN tipoventa tv
    ON tv.aClave=bv.aTipoVenta

WHERE ven.nNumero=1
ORDER BY ven.nNumero asc, bv.nNumero asc