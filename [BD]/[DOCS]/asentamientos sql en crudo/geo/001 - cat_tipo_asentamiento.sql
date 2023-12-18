CREATE OR REPLACE TABLE cat_tipo_asentamiento(
    id smallint unsigned not null auto_increment,
    nombre varchar(40),

    PRIMARY KEY(id)
) ENGINE = MYISAM;



-- INSERT
INSERT INTO `cat_tipo_asentamiento` (`id`, `nombre`) VALUES
('01', 'Aeropuerto'),
('02', 'Barrio'),
('04', 'Campamento'),
('09', 'Colonia'),
('10', 'Condominio'),
('11', 'Congregación'),
('12', 'Conjunto habitacional'),
('15', 'Ejido'),
('16', 'Estación'),
('17', 'Equipamiento'),
('18', 'Exhacienda'),
('20', 'Finca'),
('21', 'Fraccionamiento'),
('23', 'Granja'),
('24', 'Hacienda'),
('26', 'Parque industrial'),
('27', 'Poblado comunal'),
('28', 'Pueblo'),
('29', 'Ranchería'),
('30', 'Residencial'),
('31', 'Unidad habitacional'),
('32', 'Villa'),
('33', 'Zona comercial'),
('34', 'Zona federal'),
('37', 'Zona industrial'),
('40', 'Puerto'),
('45', 'Paraje'),
('46', 'Zona naval'),
('47', 'Zona militar'),
('48', 'Rancho');