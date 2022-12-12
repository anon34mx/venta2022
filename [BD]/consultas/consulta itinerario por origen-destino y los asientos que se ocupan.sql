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