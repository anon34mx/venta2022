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
cordis.nProgramada as corridaProgramada, cordis.aEstado, cordis.nNumero as corridaDisponible,
cordis.nItinerario as itinerario, corpro.nItinerario as itiProg,
cordis.nNumeroAutobus as autobus, dis.nNumero as disp,
"__",
dis.nOrigen, dis.nDestino,dis.fSalida, dis.hSalida, dis.fLlegada, dis.hLlegada,
"__",
dist.nAsientos,COUNT(disa.nAsiento) as ocupados,  dist.nAsientos-COUNT(disa.nAsiento) as libres
FROM corridasdisponibles cordis
INNER JOIN disponibilidad dis ON dis.nCorridaDisponible=cordis.nNumero
INNER JOIN corridasprogramadas as corpro on corpro.nNumero=cordis.nProgramada
-- LEFT JOIN itinerario iti on iti.nItinerario=corpro.nItinerario
LEFT JOIN disponibilidadasientos disa on disa.nDisponibilidad=dis.nNumero
LEFT JOIN autobuses as aut on aut.nNumeroAutobus=cordis.nNumeroAutobus
INNER JOIN distribucionasientos as dist on aut.nDistribucionAsientos=dist.nNumero
WHERE
-- dis.fSalida=CURRENT_DATE
-- AND dis.nOrigen=8
-- cordis.aEstado!='C' and
cordis.nNumero=49 
-- dis.fSalida="2022-08-26" -- parametro
-- AND dis.hSalida="12:00:00"

GROUP BY nCorridaDisponible, dis.nOrigen, dis.nDestino
HAVING COUNT(disa.nAsiento)<dist.nAsientos -- que haya asientos disponibles
AND (dist.nAsientos-COUNT(disa.nAsiento))>=1 -- asientos requeridos
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

-- [CANCELAR CORRIDA (y sus disponibilidades)]
-- PENDIENTE (usar la funcion estadoAsientos() )
/*
CREATE OR REPLACE estado_corrida_disponible(IN_cordis INT UNSIGNED, IN_estado VARCHAR(2))
RETURNS TEXT
BEGIN
    -- variables para manejo de errores
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT DEFAULT "";
    DECLARE nrows INT UNSIGNED DEFAULT 0;
    DECLARE result TEXT DEFAULT "Corrida no encontrada";
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
      GET DIAGNOSTICS CONDITION 1
        code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
    END;
    -- DECLARE v_CUR_dis CURSOR FOR SELECT * FROM `disponibilidad` where nCorridaDisponible=25
    UPDATE `disponibilidad` where nCorridaDisponible=IN_cordis;
    UPDATE `corridasdisponibles` SET aEstado=IN_estado WHERE nNumero=IN_cordis;
END;
*/