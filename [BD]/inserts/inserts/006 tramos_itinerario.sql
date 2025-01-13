-- REVISAR UNIQUE
INSERT INTO `tramos`(`nNumero`, `nOrigen`, `nDestino`, `nKilometros`, `nTiempo`, `nEstancia`)
VALUES
(1,8,10,112,90,10), -- more-urua
(2,10,5,58,70,0), -- urua-ccam
(3,5,1,34,30,30), -- ccam-apat
(4,1,3,34,30,30), -- apat-buen
(5,3,9,34,40,0), -- buen-tepa
(6,9,4,73,80,0), -- tepa-coal

(7,5,2,130,130,0), -- ccam-arteaga

(8,5,7,166,120,0), -- ccam-lazaro
(9,5,6,200,140,15), -- ccam-ixta
(10,6,11,9,20,0) -- ixta-zihu

INSERT INTO `itinerario`(`nItinerario`, `nConsecutivo`, `nTramo`) VALUES
(1,1,1), -- urua
(2,1,1), -- ccam
(2,2,2),
(3,1,1), -- apat
(3,2,2),
(3,3,3),
-- REFERENCIAS
-- https://es.stackoverflow.com/questions/354775/mysql-bucle-sobre-un-select-para-hacer-calculos-y-mostrar-datos-con-condicione

-- ######################
-- consultar 

SELECT *
FROM itinerario iti

inner join tramos tramOri on iti.nTramo=tramOri.nNumero

where iti.nItinerario=3


-- SELECT iti.nItinerario, iti.nConsecutivo, tram.nNumero, tram.nOrigen, origen.aNombre as origen, tram.nDestino, destino.aNombre as destino
-- FROM itinerario iti
-- inner JOIN tramos tram on iti.nTramo=tram.nNumero
-- inner join oficinas as origen on origen.nNumero=tram.nOrigen
-- inner join oficinas as destino on destino.nNumero=tram.nDestino
-- where iti.nItinerario=3


-- SELECT iti.nItinerario,min(nConsecutivo),max(nConsecutivo), nTramo
-- FROM itinerario iti

-- inner join tramos tramOri on tramOri.nNumero=1

-- where iti.nItinerario=3