-- ################################
SELECT * FROM `corridasdisponibles` as corridas
JOIN (
    -- PONER CONSULTA
) as test on test.nNumero=corridas.nNumero

-- [INTENTO 01]
SELECT
-- "corrida__>",
cordis.nNumero, cordis.nProgramada,cordis.nItinerario,cordis.nTipoServicio, cordis.fSalida, cordis.hSalida,
    cordis.aEstado,cordis.nNumeroAutobus,cordis.nNumeroConductor,
"itiIda__>",
itiIda.nConsecutivo as consIda, itiIda.nTramo as tramIda, 
"itiReg__>",
itiReg.nConsecutivo as consReg, itiReg.nTramo as tramReg


from `corridasdisponibles` as cordis
inner join itinerario itiIda on itiIda.nItinerario=cordis.nItinerario
inner join itinerario itiReg on itiReg.nItinerario=cordis.nItinerario

where cordis.nNumero=2 -- [PARAMETRO] [POR CORRIDA]


order by cordis.nNumero, itiIda.nConsecutivo asc, itiReg.nConsecutivo desc
limit 1 -- TEST


-- -------------------------------------------------------------[INTENTO 02]
-- Funciona mejor
SELECT 
"corr_____", corr.nNumero, corr.fSalida, corr.hSalida,
"itIni_____", itIni.nItinerario, itIni.nConsecutivo, itIni.nTramo,
"itFin_____", itFin.nItinerario, itFin.nConsecutivo, itFin.nTramo,
"tramoINI_____", trIni.nNumero, trIni.nOrigen, ofiIni.aNombre 'origen',
"tramosFIN_____", trFin.nNumero, trFin.nDestino, ofiFin.aNombre 'destino'
-- "calcTiempos_____", trTi.nTiempo,

FROM `corridasdisponibles` corr
inner join `itinerario` itIni on corr.nItinerario=itIni.nItinerario and itIni.nConsecutivo=(
    -- Aquí se selecciona el origen
    -- desde el inicio de la corrida
        -- select MIN(nConsecutivo) from itinerario itTemp where itTemp.nItinerario=itIni.nItinerario
    -- INICIAR EN URUA
        SELECT it.nConsecutivo FROM `itinerario` it INNER JOIN tramos tr on tr.nNumero=it.nTramo
        WHERE nItinerario=itIni.nItinerario AND tr.nOrigen=10
)
inner join `tramos` trIni on trIni.nNumero=itIni.nTramo
INNER JOIN `oficinas` ofiIni on ofiIni.nNumero=trIni.nOrigen

-- --------------------------- FIN DE LA CORRIDA
inner join `itinerario` itFin on corr.nItinerario=itFin.nItinerario and itFin.nConsecutivo=(
    -- Aquí se selecciona el destino
    -- hasta el final de la corrida
        -- select max(nConsecutivo) from itinerario itTemp where itTemp.nItinerario=itFin.nItinerario
    -- ACABA EN APAT
        SELECT it.nConsecutivo FROM `itinerario` it INNER JOIN tramos tr on tr.nNumero=it.nTramo
        WHERE nItinerario=itFin.nItinerario AND tr.nDestino=1
)
inner join `tramos` trFin on trFin.nNumero=itFin.nTramo
INNER JOIN `oficinas` ofiFin on ofiFin.nNumero=trFin.nDestino -- [REVISAR]

-- -------------------------- CALCULAR TIEMPOS
order by corr.nNumero ASC