INSERT INTO personas_estados VALUES
("AC", "Activo"),
("BA", "Proceso de Baja"),
("PE", "Permiso"),
("AU", "Ausente"),
("CA", "Castigo");
INSERT INTO boletos_vendidos_estados
VALUES
("PP", "Pago pendiente"),
("VE", "Vendido"),
("CA", "Cancelado"),
("AP", "Abordo pasajero"),
("PC", "Paquete en Corrida"),
("PD", "Paquete en Destino"),
("PE", "Paquete Entregado"),
("LM", "Limbo"),
("IN", "Intercambiado"),
("LI", "Liquidado");
INSERT INTO `corridas_estados` (`id`, `aEstado`, `orden`, `elegible`) VALUES
('B', 'Bloqueada', 99, 1),
('C', 'Cancelada', 99, 1),

('D', 'Disponible', 1, 0),
('A', 'Asignada', 2, 0),
('S', 'Lista para salir', 3, 1),
('R', 'En ruta', 4, 0),
('T', 'Terminada', 5, 0),
('L', 'Liquidada', 6, 0)
;
INSERT INTO `distribucionasientos`(`nNumero`,`nAsientos`, `aDistribucion`)
VALUES
(1,'32',"01T,02T,00,03T,04T|05T,06T,00,07T,08T|09T,10T,00,11T,12T|13T,14T,00,15T,16T|17T,18T,00,19T,20T|21T,22T,00,23T,24T|25T,26T,00,27T,28T|29T,30T,00,31T,32T|BM,00,CA,00,BH"),
(2,'24',"01T,02T,00,03T|04T,05T,00,06T|07T,08T,00,09T|10T,11T,00,12T|13T,14T,00,15T|16T,17T,00,18T|19T,20T,00,21T|22T,23T,00,24T|BM,00,CA,00,BH"),
(3,'40',"01T,02,00,03,04T|05,06,00,07,08|09,10,00,11,12|13T,14,00,15,16T|17,18,00,19,20|21,22,00,23,24|25T,26,00,27,28T|29,30,00,31,32|33,34,00,35,36|37,38,00,39,40|BM,00,CA,00,BH"),
(4,'40',"01,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16T|17,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,00,00|39,40,00,00,00|CA,00,00,00,BU"),
(5,'40',"01T,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16|17T,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,39,40|CA,00,00,00,BU"),
(6,'42',"05,06,00,07,08|09,10,00,11,12T|13,14,00,15,16|17,18,00,19,20|21T,22,00,00,PU|23,24,00,25,26|27,28,00,29,30T|31,32,00,33,34|35,36,00,37,38|39,40,00,00,00|41,42,00,00,00|00,00,00,0C,BU");

-- latitud, longitud, 
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
(12,'PEMO','Pensión morelia', 'int',0),
(13,'INTE','INTERNET', 'int',0);

INSERT into `origenesdestinos`(nOrigen, nDestino) VALUES
(1, 3), (1, 4), (1, 5), (1, 8), (1, 9), (1, 10),
(2, 5),(2, 8),(2, 10),
(3, 1),(3, 4),(3, 5),(3, 8),(3, 9),(3, 10),
(4, 1), (4, 3), (4, 5), (4, 8), (4, 9), (4, 10),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 6), (5, 7), (5, 8), (5, 9), (5, 10), (5, 11),
(6, 5), (6, 8), (6, 10), (6, 11),
(7, 1), (7, 5), (7, 8), (7, 10),
(8, 1), (8, 2), (8, 3), (8, 4), (8, 5), (8, 6), (8, 7), (8, 9), (8, 10), (8, 11),
(9, 1), (9, 3), (9, 4), (9, 5), (9, 8), (9, 10),
(10, 1), (10, 2), (10, 3), (10, 5), (10, 4), (10, 6), (10, 7), (10, 8), (10, 9), (10, 11),
(11, 5), (11, 6), (11, 8), (11, 10);

INSERT INTO `tiposervicio`(`nNumero`, `aClave`, `aDescripcion`, `nDistribucionAsientos`, ocupacionMinima, descuentosMax) VALUES
(1,"PL",'Platinum',2, 8, 8),
(2,"UL",'Ultra',3, 7, 0),
(3,"EX",'Express',4, 6, 0),
(4,"PC",'Premium Class',5, 6, 0),
(5, "CP", 'Business Class',5, 7, 0);

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
--
('0007', 4, 1),
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

INSERT INTO `tipospersona`(`aTipo`, `aNombre`)
VALUES
("EI", "Empleado interno"),
("PE", "Personal Externo"),
("FA", "Familiar"),
("PA", "Personal Agencias de Vaje"),
("SO", "Socio"),
("PG", "Público general");

INSERT INTO `personas`(`nNumeroPersona`,`aNombres`, `aApellidos`, `nOficina`, `aTipo`) VALUES
(1,'Jahaziel Aarón','Aguilera Castillo',12,'EI'),
(2,'ANGEL','ZAMORA DE JESUS',12,'EI'),
(3,'FRANCISCO JAVIER','ALVARADO LEMUS',12,'EI'),
(4,'PASCUAL','ESTEBAN GABRIEL',12,'EI'),
(5,'JESUS','CORNEJO MAULE',12,null),
(6, 'sergio', 'medrano', '8', 'EI');

INSERT INTO `conductores`(`nNumeroConductor`, `nNumeroPersona`, `aLicencia`, `fVigenciaLicencia`, `aEstado`, `nNumeroAutobus`)
VALUES
(1,2,'LIC007','2025-10-11','AC',
    (select nNumeroAutobus from autobuses where nNumeroEconomico="5005")),
(2,3,'LIC084','2028-03-08','AC',
    (select nNumeroAutobus from autobuses where nNumeroEconomico="9001")),
(3,4,'LIC026','2025-07-26','BA',
    (select nNumeroAutobus from autobuses where nNumeroEconomico="7002"));

/*
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

-- regreso
INSERT INTO `tramos`(`nNumero`, `nOrigen`, `nDestino`, `nKilometros`, `nTiempo`, `nEstancia`)
VALUES
(11, 11, 6, 9, 20, 15),
(12, 6, 5, 200, 140, 15),
(13,5,10,58,70,10),
(14,10,8,112,90,0)
;

INSERT INTO `itinerario`(`nItinerario`, `nConsecutivo`, `nTramo`) VALUES
(1,1,1), -- urua

(2,1,1), -- ccam
(2,2,2),

(3,1,1), -- apat
(3,2,2),
(3,3,3),

(4,1,1),
(4,2,2),

(5, 1, 11),
(5, 2, 12),
(5, 3, 13),
(5, 4, 14),

(6, 1, 1),
(6, 2, 2),
(6, 3, 3),
(6, 4, 4),
(6, 5, 5),
(6, 6, 6)
;

INSERT INTO `corridasprogramadas`(`nItinerario`, `nTipoServicio`, `hSalida`,
`lLunes`, `lMartes`, `lMiercoles`, `lJueves`, `lViernes`, `lSabado`, `lDomingo`, `fInicio`, `fFin`, `deleted_at`)
VALUES
(1,1,'10:00:00',
true,true,true,true,true,false,false,'2022-01-01','2023-06-30',null),
(1,1,'10:01:00',
true,true,true,true,true,false,false,'2022-03-01','2023-06-30', "2022-10-10 12:00:00"),
(1,1,'10:30:00',
false,false,false,false,false,true,true,'2022-01-01','2022-06-30',null),
(3,3,'12:00:00',
true,true,true,true,true,true,true,'2022-03-01','2022-12-31',null),
(3,3,'23:30:00',
true,false,false,true,true,true,true,'2022-03-01','2022-12-31',null);
*/
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
("PQ", "Paquetería", 0.10),
("SE", "SEDENA", 0.10);

INSERT INTO terminales (nNumero, aTerminal, nOficina, aDescripcion, hwid) VALUES
(3, "DTI", 12, "para pruebas",34),
(2, "Venta sitio web", 13, "parhikuni.com",null),
(1, "desconocida", 13, "El usuario ingresó desde un dispositivo no registrado",null);

/*
INSERT INTO sesiones (nNumero,nNumeroPersona, nOficina, fContable) VALUES (1,1,8,"2022-08-31");
INSERT INTO venta (nNumero,nSesion) VALUES(1,1);
*/

-- insertar forma de pago y subtipos de formas de pago
INSERT INTO formaspago VALUES ("EF","Efectivo");
INSERT INTO formaspago VALUES ("TB","Tarjeta bancaria");
INSERT INTO formaspago VALUES ("DO","Documento");
INSERT INTO formaspago VALUES ("CC","Cuenta por cobrar");

INSERT INTO formapagosubtipo (nNumero, aClave, aDescripcion, lPedirFolio) VALUES
(1, "TB", "Tarjeta de credito", 0),
(2, "TB", "Tarjeta de débito", 0),
(3, "DO", "Vales IMSSS", 0),
(4, "DO", "Vales ISSSTE", 0),
(5, "DO", "Vales SEDENA", 0);

INSERT INTO promociones (nNumero,aTipo, aDescripcion, nDescuento, fInicio, fFin) VALUES
(1,"ES", "Desc INSEN", 12, "2022-09-01", "2022-12-31");


INSERT INTO `factorpaqueteria` (`nNumero`, `aTipo`, `nValorMaximo`, `nFactor`, `fAplicacion`, `fCreacion`)
VALUES
(1, 'Kg', '5', '1.10', '2023-10-31', '2023-10-31'),
(2, 'Kg', '10', '1.11', '2023-10-31', '2023-10-31'),
(3, 'Kg', '20', '1.12', '2023-10-31', '2023-10-31'),
(4, 'Kg', '35', '1.12', '2023-10-31', '2023-10-31'),
(5, 'Kg', '60', '1.12', '2023-10-31', '2023-10-31'),
(6, 'Kg', '85', '1.12', '2023-10-31', '2023-10-31'),
(7, 'Kg', '100', '1.12', '2023-10-31', '2023-10-31'),
(8, 'Kg', '120', '1.12', '2023-10-31', '2023-10-31'),
(9, 'Kg', '140', '1.12', '2023-10-31', '2023-10-31'),
(10, 'Kg', '150', '1.12', '2023-10-31', '2023-10-31'),
(11, 'Sbr', '1', '1.08', '2023-10-31', '2023-10-31'),
(12, 'Sbr', '2', '1.09', '2023-10-31', '2023-10-31'),