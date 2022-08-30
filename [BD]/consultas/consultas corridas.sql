--                  [OBTENER CORRIDAS DE-HASTA]
SELECT
cordis.nNumero as cordis, cordis.hSalida as hInicia, cordis.nItinerario,
dis.nNumero dis,dis.nOrigen, ofiOri.aNombre as origen, dis.nDestino, ofiDes.aNombre as destino, dis.fSalida, dis.hSalida, dis.fLlegada, dis.hLlegada
FROM disponibilidad as dis
INNER JOIN oficinas as ofiOri on ofiOri.nNumero=dis.nOrigen and ofiOri.lDestino=true
INNER JOIN oficinas as ofiDes on ofiDes.nNumero=dis.nDestino and ofiDes.lDestino=true
INNER JOIN corridasdisponibles as cordis on cordis.nNumero=dis.nCorridaDisponible AND cordis.aEstado='A'

where dis.fSalida="2022-08-13" and dis.nOrigen=10
order by dis.nCorridaDisponible, cordis.hSalida

--                  [consultar itinerario]
SELECT
cordis.nNumero as cordis, cordis.nProgramada, cordis.nItinerario, cordis.fSalida as fInicio, cordis.hSalida as hInicio,
iti.nConsecutivo, dis.nOrigen, dis.nDestino, dis.fSalida, dis.hSalida, dis.fLlegada, dis.hLlegada
FROM corridasdisponibles cordis
INNER JOIN corridasprogramadas as corpro on corpro.nNumero=cordis.nProgramada
INNER JOIN itinerario as iti on iti.nItinerario=corpro.nItinerario
INNER JOIN tramos as tr on tr.nNumero=iti.nTramo
INNER JOIN disponibilidad as dis on dis.nCorridaDisponible=cordis.nNumero and dis.nOrigen=tr.nOrigen and dis.nDestino=tr.nDestino
where cordis.nNumero=2 -- parametro
AND iti.nConsecutivo>=(
    SELECT it.nConsecutivo FROM  itinerario it 
    INNER JOIN tramos trm on it.nTramo=trm.nNumero
    where it.nItinerario=3 AND trm.nOrigen=10 -- parametro
)
order by iti.nConsecutivo ASC

--                  [OBTENER CORRIDAS DE-HASTA CON OCUPACION]
SELECT
cordis.nProgramada as corridaProgramada, cordis.nNumero as corridaDisponible,
cordis.nItinerario as itinerario, corpro.nItinerario as itiProg,
cordis.nNumeroAutobus as autobus, dis.nNumero as disp,
"__",
dis.nOrigen, dis.nDestino,dis.fSalida, dis.hSalida, dis.fLlegada, dis.hLlegada
"__",
dist.nAsientos,COUNT(disa.nAsiento) as ocupados
FROM corridasdisponibles cordis
INNER JOIN disponibilidad dis ON dis.nCorridaDisponible=cordis.nNumero
INNER JOIN corridasprogramadas as corpro on corpro.nNumero=cordis.nProgramada
-- LEFT JOIN itinerario iti on iti.nItinerario=corpro.nItinerario
LEFT JOIN disponibilidadasientos disa on disa.nDisponibilidad=dis.nNumero
LEFT JOIN autobuses as aut on aut.nNumeroAutobus=cordis.nNumeroAutobus
INNER JOIN distribucionasientos as dist on aut.nDistribucionAsientos=dist.nNumero
WHERE
dis.fSalida="2022-08-26" -- parametro
AND dis.hSalida="12:00:00"
AND dis.nOrigen=8

GROUP BY nCorridaDisponible, dis.nOrigen, dis.nDestino
HAVING COUNT(disa.nAsiento)<dist.nAsientos -- que haya asientos disponibles
ORDER BY dis.fSalida, dis.hSalida

-- [Asientos reservados que deben liberarse]
-- las reservaciones duran 15 minutos
-- [0] Añadir columna last_update
ALTER TABLE disponibilidadasientos ADD COLUMN last_update DATETIME NOT NULL DEFAULT NOW();
-- [1] Hacer un trigger que indique cuando se insertó/modificó el registro
CREATE OR REPLACE TRIGGER asiento_ultima_actualizacion
BEFORE UPDATE ON disponibilidadasientos
FOR EACH ROW
BEGIN
    SET NEW.last_update=CURRENT_TIMESTAMP;
END;
-- [2] Hacer una consulta que saque los apartados(a) que tengan más de 15 minutos
SELECT *, MINUTE(TIMEDIFF(CURRENT_TIMESTAMP,last_update)) haceXminutos
FROM disponibilidadasientos
WHERE last_update
AND aEstadoAsiento='a' -- v esta es la parte que sirve
AND MINUTE(TIMEDIFF(CURRENT_TIMESTAMP,last_update))>15 
-- [3] Eliminar los apartados del punto [2]
CREATE OR REPLACE EVENT liberar_apartados
ON SCHEDULE
EVERY 2 MINUTE
STARTS CURRENT_TIMESTAMP
DO
    DELETE FROM disponibilidadasientos
    WHERE
    AND aEstadoAsiento='a'
    AND MINUTE(TIMEDIFF(CURRENT_TIMESTAMP,last_update))>15;