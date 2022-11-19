# falta filtrar los boletos cancelados en la tabla de boletos 
# hice esto en dos dias uwu
select
cordis.nNumero as "corrida", cordis.aEstado as "estado",
autobus.nNumeroEconomico as autobus, dist.nAsientos as totalAsientos,
(select count(nAsiento) from disponibilidadasientos disa where disa.nDisponibilidad=disp.nNumero) as ocupados,
disp.nOrigen, disp.nDestino, disp.fSalida ,disp.hSalida,
iti.nItinerario as itinerario, iti.nConsecutivo,
reg.despachado ,reg.fSalida ,reg.fLlegada  
FROM `corridasdisponibles` as cordis
left join autobuses as autobus on
	autobus.nNumeroAutobus = cordis.nNumeroAutobus 
	inner join distribucionasientos dist on dist.nNumero = autobus.nDistribucionAsientos 
left join itinerario as iti 
	on iti.nItinerario = cordis.nItinerario 
inner join tramos tr on tr.nNumero = iti.nTramo
inner join disponibilidad as disp
	on disp.nCorridaDisponible = cordis.nNumero and disp.nOrigen = tr.nOrigen 
left join registropasopuntos reg
	on reg.nCorrida = cordis.nNumero and iti.nConsecutivo = reg.nConsecutivo 
left  join boletosvendidos boletos
	on boletos.nCorrida = cordis.nNumero and boletos.nOrigen = disp.nOrigen
		and boletos.nDestino = disp.nDestino -- and boletos.aEstado in ("AP", "VE")
where -- and cordis.aEstado not in ("T","C","L","B")
cordis.nNumero=38 -- and disp.nOrigen = 5 and disp.nDestino = 1
-- cordis.fSalida >= current_date()  and cordis.fSalida <= date_add(current_date(), interval 1 DAY) disp.nOrigen = 8 and disp.nDestino = 5
group by cordis.nNumero, disp.nOrigen , disp.nDestino -- , disp.fSalida, disp.hSalida 
order by cordis.nNumero, iti.nConsecutivo, disp.fSalida, disp.hSalida 