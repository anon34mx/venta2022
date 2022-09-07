DROP DATABASE venta2022b;
CREATE DATABASE venta2022b;
USE venta2022b;

itinerario
    cambiar llave primaria para que tenga ambas columnas
    quitar las otras llaves
corridasprogramadas
    conductor puede ser nulo
    autobus puede ser nulo
disponibilidad
    ncorridaprogramada quitar llave unica
    + añadir ??
disponibilidadasientos
    quitar llave primaria
    crear llave unica 
        ALTER TABLE disponibilidadasientos ADD UNIQUE KEY (nDisponibilidad, nAsiento);
venta
    fCreacion debe tener por DEFAULT el valor
        ALTER TABLE `venta` CHANGE `fCreacion` `fCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ventapago
    fCreacion debe tener el valor por defecto
        ALTER TABLE `ventapago` CHANGE `fCreacion` `fCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
Boletosvendidos
    ALTER TABLE `boletosvendidos` CHANGE `fCreacion` `fCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
-- CREAR INDICES PARA QUE SEA MÁS RÁPIDO
    -- ejemplo
    -- ALTER TABLE pases ADD INDEX pases_IN (id,id_venta)
ALTER TABLE `itinerario` ADD INDEX itinerario_IN (nItinerario, nTramo);
ALTER TABLE `tramos` ADD INDEX tramos_IN (nNumero, nOrigen, nDestino);
ALTER TABLE `corridasdisponibles` ADD INDEX corridasdisponibles_IN
    (nNumero, nProgramada, nItinerario, nNumeroAutobus);
ALTER TABLE `oficinas` ADD INDEX oficinas_IN (nNumero, aClave, lDestino);
ALTER TABLE `disponibilidad` ADD INDEX disponibilidad_IN (nNumero, nCorridaDisponible,nOrigen, nDestino);
ALTER TABLE `disponibilidadasientos` ADD INDEX disponibilidadasientos_IN (nDisponibilidad, nAsiento);
ALTER TABLE `corridasprogramadas` ADD INDEX corridasprogramadas_IN (nNumero, nItinerario);

/***/
INSERT INTO `distribucionasientos`(`nNumero`,`nAsientos`, `aDistribucion`)
VALUES
(1,'32',"01T,02T,00,03T,04T|05T,06T,00,07T,08T|09T,10T,00,11T,12T|13T,14T,00,15T,16T|17T,18T,00,19T,20T|21T,22T,00,23T,24T|25T,26T,00,27T,28T|29T,30T,00,31T,32T|BM,00,CA,00,BH"),
(2,'24',"01T,02T,00,03T|04T,05T,00,06T|07T,08T,00,09T|10T,11T,00,12T|13T,14T,00,15T|16T,17T,00,18T|19T,20T,00,21T|22T,23T,00,24T|BM,00,CA,00,BH"),
(3,'40',"01T,02,03,04T|05,06,07,08|09,10,11,12|13T,14,15,16T|17,18,19,20|21,22,23,24|25T,26,27,28T|29,30,31,32|33,34,35,36|37,38,39,40|BM,00,CA,00,BH"),
(4,'40',"01,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16T|17,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,00,00|39,40,00,00,00|CA,00,00,00,BU"),
(5,'40',"01T,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16|17T,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,39,40|CA,00,00,00,BU"),
(6,'42',"05,06,00,07,08|09,10,00,11,12T|13,14,00,15,16|17,18,00,19,20|21T,22,00,00,PU|23,24,00,25,26|27,28,00,29,30T|31,32,00,33,34|35,36,00,37,38|39,40,00,00,00|41,42,00,00,00|00,00,00,0C,BU");

INSERT INTO `oficinas` (`nNumero`,`aClave`, `aNombre`, `aTipo`, `lDestino`) VALUES
(1,'APAT','Apatzingán', 'int', 1),
(2,'ARTE','Arteaga', 'int', 1),
(3,'BUEN','Buenavista', 'int', 1),
(4,'COAL','Coalcomán', 'int', 1),
(5,'CCAM','Cuatro Caminos', 'int', 1),
(6,'IXTA','Ixtapa', 'int', 1),
(7,'LCAR','Lázaro Cárdenas', 'int', 1),
(8,'MORE','Morelia', 'int', 1),
(9,'TEPA','Tepalcatepec', 'int', 1),
(10,'URUA','Uruapan', 'int', 1),
(11,'ZIHUA','Zihuatanejo', 'int', 1),
(12,'PEMO','Pensión morelia', 'int',0);

INSERT INTO `tiposervicio`(`nNumero`, `aClave`, `aDescripcion`, `nDistribucionAsientos`) VALUES
(1,"PL",'Platinum',2),
(2,"UL",'Ultra',3),
(3,"EX",'Express',4),
(4,"PC",'Premium Class',5),
(5, "CP", 'Business Class',5);

INSERT INTO `autobuses`(`nNumeroEconomico`, nTipoServicio, nDistribucionAsientos) VALUES
-- business
('5005', 5, 6),
('5006', 5, 6),
('5401', 5, 3),
('5402', 5, 3),
('5403', 5, 3),
('5404', 5, 3),
('5405', 5, 3),
('5406', 5, 3),
('5407', 5, 3),
('5408', 5, 3),
('5409', 5, 3),
('5410', 5, 3),
('5411', 5, 3),
('5425', 5, 3),
('5426', 5, 3),
('5427', 5, 3),
('5428', 5, 3),
('5429', 5, 3),
('5430', 5, 3),
('5431', 5, 3),
('5432', 5, 3),
('5433', 5, 3),
('5434', 5, 3),
('5435', 5, 3),
('5436', 5, 3),
('5437', 5, 3),
('5438', 5, 3),
('8014', 5, 1),
-- platinum
('9001', 2, 2),
('9002', 2, 2),
('9003', 2, 2),
('9004', 2, 2),
('9005', 2, 2),
('9007', 2, 2),
('9008', 2, 2),
('9009', 2, 2),
('9010', 2, 2),
-- premium
("7001", 2, 2),
("7002", 2, 2),
("7003", 2, 2),
("7004", 2, 2),
("7005", 2, 2),
("7008", 2, 2),
("7009", 2, 2),
("7010", 2, 2),
("7011", 2, 2),
("7012", 2, 2),
-- ultra
("5412", 3, 3),
("5413", 1, 1),
("5414", 1, 1),
("5415", 1, 1),
("5416", 1, 1),
("5417", 1, 1),
("5418", 1, 1),
("5419", 1, 1),
("5420", 1, 1),
("5421", 1, 1),
("5422", 1, 1),
("5423", 1, 1),
("5424", 1, 1),
("8001", 1, 1),
("8002", 1, 1),
("8003", 1, 1),
("8004", 1, 1),
("8005", 1, 1),
("8006", 1, 1),
("8007", 1, 1),
("8008", 1, 1),
("8009", 1, 1),
("8010", 1, 1),
("8011", 1, 1),
("8012", 1, 1);

INSERT INTO `personas`(`aNombres`, `aApellidos`, `nOficina`, `aTipo`) VALUES
('Jahaziel Aarón','Aguilera Castillo',12,'EI'),
('ANGEL','ZAMORA DE JESUS',12,'EI'),
('FRANCISCO JAVIER','ALVARADO LEMUS',12,'EI'),
('PASCUAL','ESTEBAN GABRIEL',12,'EI'),
('JESUS','CORNEJO MAULE',12,'EI');

INSERT INTO `conductores`(`nNumeroConductor`, `nNumeroPersona`, `aLicencia`, `fVigenciaLicencia`, `aEstado`, `nNumeroAutobus`)
VALUES
(1,2,'LIC007','2025-10-11','A',2),
(2,3,'LIC084','2028-03-08','A',3),
(3,4,'LIC026','2025-07-26','B',4);

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
(10,6,11,9,20,0); -- ixta-zihu

INSERT INTO `itinerario`(`nItinerario`, `nConsecutivo`, `nTramo`) VALUES
(1,1,1), -- urua
(2,1,1), -- ccam
(2,2,2),
(3,1,1), -- apat
(3,2,2),
(3,3,3);

INSERT INTO `corridasprogramadas`(`nItinerario`, `nTipoServicio`, `hSalida`,
`lLunes`, `lMartes`, `lMiercoles`, `lJueves`, `lViernes`, `lSabado`, `lDomingo`, `fInicio`, `fFin`, `lBaja`)
VALUES
(1,1,'10:00:00',
true,true,true,true,true,false,false,'2022-01-01','2023-06-30',false),
(1,1,'10:01:00',
true,true,true,true,true,false,false,'2022-03-01','2023-06-30',true),
(1,1,'10:30:00',
false,false,false,false,false,true,true,'2022-01-01','2022-06-30',false),
(3,3,'12:00:00',
true,true,true,true,true,true,true,'2022-03-01','2022-12-31',false),
(3,3,'23:30:00',
true,false,false,true,true,true,true,'2022-03-01','2022-12-31',false);

INSERT INTO tiposboletos (nNumero, aTipo, aDescripcion, nCantidad)
VALUES
(1, "V", "Venta", 1000), -- 5,000 5,999
(2, "P", "Paqueteria", 150),
(3, "E", "Exceso equipaje", 0),
(4, "G", "Guarda equipaje", 0),
(5, "M", "Manual", 100);
INSERT INTO tipoventa (aClave, aDescripcion, ntipoboleto) VALUES
("CO","Boleto confirmado", 1),
("AB","Boleto abierto", 1), -- sin fecha ni hora
("MA","Boleto manual", 5), -- 
("PC","Paquetería comercial", 2),
("PI","Paquetería interna", 2),
("EE","Exceso de Equipaje", 3),
("GE","Guarda Equipaje", 4),
("BI","Boleto de internet", 1),
("BA","Boleto de agencia", 1),
("BW","Boleto webservice", 1),
("AP","Abono paquetería", 2);

INSERT INTO tipopasajero VALUES
("AD", "Adulto", 0),
("IN", "Insen", 0.10),
("NI", "Niño", 0.10),
("ES", "Estudiante", 0.10),
("MA", "Maestro", 0.10),
("SE", "SEDENA", 0.10);
-- HASTA AQUI VA BIEN


-- INSERT INTO promociones (nNumero, aTipo, aDescripcion, nMaximos, nDescuento, fInicio, fFin)



-- insertar forma de pago y subtipos de formas de pago
INSERT INTO formaspago VALUES ("EF","Efectivo");
INSERT INTO formaspago VALUES ("TB","Tarjeta bancaria");
INSERT INTO formaspago VALUES ("DO","Documento");
INSERT INTO formaspago VALUES ("CC","Cuenta por cobrar");

INSERT INTO formapagosubtipo (nNumero, aClave, aDescripcion, lPedirFolio) VALUES
(1, "TB", "Tarjeta de credito", 0),
(2, "TB", "Tarjeta de débito", 0),
(3, "AS", "Tarjeta de débito", 0);

/******/
-- CREAR TERMINAL DE VENTA
INSERT INTO terminales (aTerminal, nOficina, aDescripcion) VALUES
("DTI", 12, "para pruebas");

-- INSERT que tipo de venta fue
