-- # falta filtrar los boletos cancelados en la tabla de boletos 
-- # hice esto en dos dias u,w,u
-- # FIRMAS y DESPACHOS
-- # USAR LA SEGUNDA

-- se cuentan bien los pasajeros que suben en cada tramo
-- pero no se restringen apropiadamente
SELECT cordis.nNumero as 'corrida', cordis.aEstado as 'estado',
autobus.nNumeroEconomico as autobus, dist.nAsientos as totalAsientos, autobus.nTipoServicio as claveServicio, tser.aDescripcion as claseServicio,
(select count(nAsiento) from disponibilidadasientos disa where disa.nDisponibilidad=disp.nNumero) as ocupados,
disp.nOrigen, disp.nDestino, disp.fSalida ,disp.hSalida,
disp.fLlegada, disp.hLlegada,
iti.nItinerario as itinerario, iti.nConsecutivo,
reg.despachado, reg.fLlegada as checkin, reg.fSalida as checkout,
tatr.nMontoBaseRuta as tarifaBase, tatr.nIVA as iva
FROM `corridasdisponibles` as cordis
left join autobuses as autobus on autobus.nNumeroAutobus = cordis.nNumeroAutobus 
inner join distribucionasientos dist on dist.nNumero = autobus.nDistribucionAsientos 
INNER JOIN tiposervicio as tser on tser.nNumero=autobus.nTipoServicio
left join itinerario as iti on iti.nItinerario = cordis.nItinerario 
inner join tramos tr on tr.nNumero = iti.nTramo
inner join disponibilidad as disp on disp.nCorridaDisponible = cordis.nNumero and disp.nOrigen = tr.nOrigen 
left join registropasopuntos reg on reg.nCorrida = cordis.nNumero and iti.nConsecutivo = reg.nConsecutivo 
left  join boletosvendidos boletos on boletos.nCorrida = cordis.nNumero and boletos.nOrigen = disp.nOrigen and boletos.nDestino = disp.nDestino
		#and boletos.aEstado in ('AP', 'VE')
left join tarifastramos as tatr on tatr.nOrigen=disp.nOrigen and tatr.nDestino=disp.nDestino and tatr.nTipoServicio=cordis.nTipoServicio -- #and tatr.fAplicacion='2022-11-20'
where
cordis.nNumero=70
-- #cordis.aEstado not in ('T','C','L','B')
-- cordis.fSalida >= current_date() and cordis.fSalida <= date_add(current_date(), interval 1 DAY)
-- #AND cordis.hSalida>=(SELECT CURRENT_TIME)
-- #disp.nOrigen = 8 and disp.nDestino = 5
group by cordis.nNumero, disp.nOrigen , disp.nDestino -- #, disp.fSalida, disp.hSalida 
order by cordis.nNumero, iti.nConsecutivo, disp.fSalida, disp.hSalida, tatr.fAplicacion DESC