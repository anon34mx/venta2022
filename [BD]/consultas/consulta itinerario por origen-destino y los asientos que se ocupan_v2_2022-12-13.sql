SELECT disp.nNumero from
corridasdisponibles as cordis
INNER JOIN  vw_iti_tra as vw
	ON cordis.nItinerario=cordis.nItinerario
INNER JOIN disponibilidad as disp
    ON disp.nCorridaDisponible=cordis.nNumero AND disp.nOrigen=vw.tra_origen AND disp.nDestino=vw.tra_destino
where 
cordis.nNumero=2
AND vw.itinerario=cordis.nItinerario
AND 
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
                WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=8 -- mi destino
            )+1,
            9999
        )
        
    )
) ORDER BY vw.itinerario, vw.iti_consecutivo ASC, vw.tra_consecutivo ASC