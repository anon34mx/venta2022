-- no recuerdo que queria hacer aqui
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
-- ################################################### separador uwu