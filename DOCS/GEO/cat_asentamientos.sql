-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-06-2023 a las 00:48:56
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `test`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ase`
--

CREATE TABLE `ase` (
  `d_codigo` text DEFAULT NULL,
  `d_asenta` text DEFAULT NULL,
  `d_tipo_asenta` text DEFAULT NULL,
  `D_mnpio` text DEFAULT NULL,
  `d_estado` text DEFAULT NULL,
  `d_ciudad` text DEFAULT NULL,
  `d_CP` text DEFAULT NULL,
  `c_estado` text DEFAULT NULL,
  `c_oficina` text DEFAULT NULL,
  `c_CP` text DEFAULT NULL,
  `c_tipo_asenta` text DEFAULT NULL,
  `c_mnpio` text DEFAULT NULL,
  `id_asenta_cpcons` text DEFAULT NULL,
  `d_zona` text DEFAULT NULL,
  `c_cve_ciudad` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ase`
--

INSERT INTO `ase` (`c_tipo_asenta`, `d_tipo_asenta`) VALUES
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
