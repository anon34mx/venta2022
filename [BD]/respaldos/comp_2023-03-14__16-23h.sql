-- MariaDB dump 10.19  Distrib 10.4.21-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: laravel
-- ------------------------------------------------------
-- Server version	10.4.21-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autobusconductor`
--

DROP TABLE IF EXISTS `autobusconductor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autobusconductor` (
  `nNumeroConductor` int(10) unsigned NOT NULL,
  `nNumeroAutobus` int(11) NOT NULL,
  PRIMARY KEY (`nNumeroConductor`,`nNumeroAutobus`),
  KEY `nNumeroAutobus` (`nNumeroAutobus`),
  CONSTRAINT `autobusconductor_ibfk_1` FOREIGN KEY (`nNumeroConductor`) REFERENCES `conductores` (`nNumeroConductor`),
  CONSTRAINT `autobusconductor_ibfk_2` FOREIGN KEY (`nNumeroAutobus`) REFERENCES `autobuses` (`nNumeroAutobus`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autobuses`
--

DROP TABLE IF EXISTS `autobuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autobuses` (
  `nNumeroAutobus` int(11) NOT NULL AUTO_INCREMENT,
  `nNumeroEconomico` varchar(6) NOT NULL,
  `nTipoServicio` int(10) unsigned NOT NULL,
  `nDistribucionAsientos` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nNumeroAutobus`),
  UNIQUE KEY `nNumeroAutobus` (`nNumeroAutobus`),
  UNIQUE KEY `nNumeroEconomico` (`nNumeroEconomico`),
  UNIQUE KEY `xNumeroEconomico` (`nNumeroEconomico`,`nNumeroAutobus`),
  KEY `nTipoServicio` (`nTipoServicio`),
  KEY `nDistribucionAsientos` (`nDistribucionAsientos`),
  CONSTRAINT `autobuses_ibfk_1` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`),
  CONSTRAINT `autobuses_ibfk_2` FOREIGN KEY (`nDistribucionAsientos`) REFERENCES `distribucionasientos` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boletos_vendidos_estados`
--

DROP TABLE IF EXISTS `boletos_vendidos_estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletos_vendidos_estados` (
  `id` varchar(2) NOT NULL,
  `descripcion` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boletoscancelados`
--

DROP TABLE IF EXISTS `boletoscancelados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletoscancelados` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nBoletoVendido` bigint(20) unsigned NOT NULL,
  `nBoletoNuevo` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nBoletoVendido` (`nBoletoVendido`),
  KEY `nBoletoNuevo` (`nBoletoNuevo`),
  CONSTRAINT `boletoscancelados_ibfk_1` FOREIGN KEY (`nBoletoVendido`) REFERENCES `boletosvendidos` (`nNumero`),
  CONSTRAINT `boletoscancelados_ibfk_2` FOREIGN KEY (`nBoletoNuevo`) REFERENCES `boletosvendidos` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boletosdisponibles`
--

DROP TABLE IF EXISTS `boletosdisponibles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletosdisponibles` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nTipoBoleto` int(10) unsigned NOT NULL,
  `aSerie` varchar(5) NOT NULL,
  `nFolioInicial` int(11) NOT NULL,
  `nFolioFinal` int(11) NOT NULL,
  `nOficina` int(10) unsigned NOT NULL,
  `nNumeroPersona` int(10) unsigned NOT NULL,
  `lActivo` tinyint(1) NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nNumeroPersona` (`nNumeroPersona`),
  KEY `nOficina` (`nOficina`),
  KEY `nTipoBoleto` (`nTipoBoleto`),
  CONSTRAINT `boletosdisponibles_ibfk_1` FOREIGN KEY (`nNumeroPersona`) REFERENCES `personas` (`nNumeroPersona`),
  CONSTRAINT `boletosdisponibles_ibfk_2` FOREIGN KEY (`nOficina`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `boletosdisponibles_ibfk_3` FOREIGN KEY (`nTipoBoleto`) REFERENCES `tiposboletos` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boletosvendidos`
--

DROP TABLE IF EXISTS `boletosvendidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletosvendidos` (
  `nNumero` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nVenta` int(10) unsigned NOT NULL,
  `nCorrida` bigint(20) unsigned NOT NULL,
  `lRegreso` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'si es false es boleto de ida, true es boleto de regreso',
  `fSalida` date NOT NULL,
  `hSalida` time NOT NULL,
  `nOrigen` int(10) unsigned NOT NULL,
  `nDestino` int(10) unsigned NOT NULL,
  `aTipoPasajero` varchar(2) NOT NULL,
  `aPasajero` text NOT NULL,
  `nAsiento` char(20) NOT NULL,
  `aTipoVenta` varchar(4) NOT NULL,
  `nMontoBase` decimal(6,2) NOT NULL,
  `nMontoDescuento` decimal(6,2) NOT NULL,
  `nIVA` decimal(6,2) NOT NULL,
  `aEstado` varchar(2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `nTerminal` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  KEY `nCorrida` (`nCorrida`),
  KEY `aTipoVenta` (`aTipoVenta`),
  KEY `aTipoPasajero` (`aTipoPasajero`),
  KEY `boletosvendidos_ibfk_4` (`nVenta`),
  KEY `boletosvendidos_ibfk_9` (`nTerminal`),
  KEY `FK_boletoEstado` (`aEstado`),
  CONSTRAINT `FK_boletoEstado` FOREIGN KEY (`aEstado`) REFERENCES `boletos_vendidos_estados` (`id`),
  CONSTRAINT `boletosvendidos_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `boletosvendidos_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `boletosvendidos_ibfk_3` FOREIGN KEY (`nCorrida`) REFERENCES `corridasdisponibles` (`nNumero`),
  CONSTRAINT `boletosvendidos_ibfk_4` FOREIGN KEY (`nVenta`) REFERENCES `venta` (`nNumero`),
  CONSTRAINT `boletosvendidos_ibfk_5` FOREIGN KEY (`aTipoVenta`) REFERENCES `tipoventa` (`aClave`),
  CONSTRAINT `boletosvendidos_ibfk_6` FOREIGN KEY (`aTipoPasajero`) REFERENCES `tipopasajero` (`aClave`),
  CONSTRAINT `boletosvendidos_ibfk_9` FOREIGN KEY (`nTerminal`) REFERENCES `terminales` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boletosvendidos_descuentos`
--

DROP TABLE IF EXISTS `boletosvendidos_descuentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletosvendidos_descuentos` (
  `nBoletoVendido` bigint(20) unsigned NOT NULL,
  `nDescuento` int(10) unsigned NOT NULL,
  KEY `nBoletoVendido` (`nBoletoVendido`),
  KEY `nDescuento` (`nDescuento`),
  CONSTRAINT `boletosvendidos_descuentos_ibfk_1` FOREIGN KEY (`nBoletoVendido`) REFERENCES `boletosvendidos` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `boletosvendidos_descuentos_ibfk_2` FOREIGN KEY (`nDescuento`) REFERENCES `descuentos` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boletosvendidos_factorpaqueteria`
--

DROP TABLE IF EXISTS `boletosvendidos_factorpaqueteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletosvendidos_factorpaqueteria` (
  `nBoletoVendido` bigint(20) unsigned NOT NULL,
  `nFactorPaqueteria` int(10) unsigned NOT NULL,
  KEY `nBoletoVendido` (`nBoletoVendido`),
  KEY `nFactorPaqueteria` (`nFactorPaqueteria`),
  CONSTRAINT `boletosvendidos_factorpaqueteria_ibfk_1` FOREIGN KEY (`nBoletoVendido`) REFERENCES `boletosvendidos` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `boletosvendidos_factorpaqueteria_ibfk_2` FOREIGN KEY (`nFactorPaqueteria`) REFERENCES `factorpaqueteria` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boletosvendidos_promociones`
--

DROP TABLE IF EXISTS `boletosvendidos_promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletosvendidos_promociones` (
  `nBoletoVendido` bigint(20) unsigned NOT NULL,
  `nPromocion` int(10) unsigned NOT NULL,
  KEY `nBoletoVendido` (`nBoletoVendido`),
  KEY `nPromocion` (`nPromocion`),
  CONSTRAINT `boletosvendidos_promociones_ibfk_1` FOREIGN KEY (`nBoletoVendido`) REFERENCES `boletosvendidos` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `boletosvendidos_promociones_ibfk_2` FOREIGN KEY (`nPromocion`) REFERENCES `promociones` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boletosvendidos_tipopaquetes`
--

DROP TABLE IF EXISTS `boletosvendidos_tipopaquetes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletosvendidos_tipopaquetes` (
  `nBoletoVendido` bigint(20) unsigned NOT NULL,
  `nTipoPaquete` int(10) unsigned NOT NULL,
  KEY `nBoletoVendido` (`nBoletoVendido`),
  KEY `nTipoPaquete` (`nTipoPaquete`),
  CONSTRAINT `boletosvendidos_tipopaquetes_ibfk_1` FOREIGN KEY (`nBoletoVendido`) REFERENCES `boletosvendidos` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `boletosvendidos_tipopaquetes_ibfk_2` FOREIGN KEY (`nTipoPaquete`) REFERENCES `tipopaquetes` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aNombre` text NOT NULL,
  `aTelefono` varchar(20) NOT NULL,
  `aCorreo` varbinary(100) NOT NULL,
  `aRFC` varchar(20) NOT NULL,
  `nDescuento` decimal(4,2) NOT NULL,
  `aRazonSocial` varchar(100) NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conductores`
--

DROP TABLE IF EXISTS `conductores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conductores` (
  `nNumeroConductor` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nNumeroPersona` int(10) unsigned NOT NULL,
  `aLicencia` varbinary(20) NOT NULL,
  `fVigenciaLicencia` date NOT NULL,
  `aEstado` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nNumeroAutobus` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`nNumeroConductor`),
  UNIQUE KEY `nNumeroConductor` (`nNumeroConductor`),
  KEY `nNumeroPersona` (`nNumeroPersona`),
  KEY `nNumeroAutobus` (`nNumeroAutobus`),
  KEY `conductores_estados` (`aEstado`),
  CONSTRAINT `conductores_estados` FOREIGN KEY (`aEstado`) REFERENCES `personas_estados` (`aClave`),
  CONSTRAINT `conductores_ibfk_1` FOREIGN KEY (`nNumeroPersona`) REFERENCES `personas` (`nNumeroPersona`),
  CONSTRAINT `conductores_ibfk_2` FOREIGN KEY (`nNumeroAutobus`) REFERENCES `autobuses` (`nNumeroAutobus`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corridas_conductores`
--

DROP TABLE IF EXISTS `corridas_conductores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corridas_conductores` (
  `nNumeroCorrida` bigint(20) unsigned NOT NULL,
  `nNumeroConductor` int(10) unsigned NOT NULL,
  `nNumeroUsuario` bigint(20) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  KEY `nNumeroCorrida` (`nNumeroCorrida`),
  KEY `nNumeroConductor` (`nNumeroConductor`),
  KEY `nNumeroUsuario` (`nNumeroUsuario`),
  CONSTRAINT `corridas_conductores_ibfk_1` FOREIGN KEY (`nNumeroCorrida`) REFERENCES `corridasdisponibles` (`nNumero`),
  CONSTRAINT `corridas_conductores_ibfk_2` FOREIGN KEY (`nNumeroConductor`) REFERENCES `conductores` (`nNumeroConductor`),
  CONSTRAINT `corridas_conductores_ibfk_3` FOREIGN KEY (`nNumeroUsuario`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corridas_disponibles_historial`
--

DROP TABLE IF EXISTS `corridas_disponibles_historial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corridas_disponibles_historial` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `corrida_disponible` bigint(20) unsigned NOT NULL,
  `nNumeroOficina` int(10) unsigned NOT NULL,
  `aEstadoAnterior` varchar(1) NOT NULL,
  `aEstadoNuevo` varchar(1) NOT NULL,
  `user` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `corrida_disponible` (`corrida_disponible`),
  KEY `aEstadoAnterior` (`aEstadoAnterior`),
  KEY `aEstadoNuevo` (`aEstadoNuevo`),
  KEY `user` (`user`),
  KEY `nNumeroOficina` (`nNumeroOficina`),
  CONSTRAINT `corridas_disponibles_historial_ibfk_1` FOREIGN KEY (`corrida_disponible`) REFERENCES `corridasdisponibles` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_2` FOREIGN KEY (`aEstadoAnterior`) REFERENCES `corridas_estados` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_3` FOREIGN KEY (`aEstadoNuevo`) REFERENCES `corridas_estados` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_6` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_7` FOREIGN KEY (`nNumeroOficina`) REFERENCES `oficinas` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_8` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_9` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corridas_estados`
--

DROP TABLE IF EXISTS `corridas_estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corridas_estados` (
  `id` varchar(1) NOT NULL,
  `aEstado` varchar(17) DEFAULT NULL,
  `orden` tinyint(4) NOT NULL,
  `elegible` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corridas_versiones`
--

DROP TABLE IF EXISTS `corridas_versiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corridas_versiones` (
  `nNumero` bigint(20) unsigned NOT NULL,
  `nItinerario` int(10) unsigned NOT NULL,
  `nTipoServicio` int(10) unsigned NOT NULL,
  `hSalida` time NOT NULL,
  `lLunes` tinyint(1) NOT NULL,
  `lMartes` tinyint(1) NOT NULL,
  `lMiercoles` tinyint(1) NOT NULL,
  `lJueves` tinyint(1) NOT NULL,
  `lViernes` tinyint(1) NOT NULL,
  `lSabado` tinyint(1) NOT NULL,
  `lDomingo` tinyint(1) NOT NULL,
  `fInicio` date NOT NULL,
  `fFin` date NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` datetime DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nTipoServicio` (`nTipoServicio`),
  KEY `corridas_versiones_IN` (`nNumero`,`nItinerario`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `corridas_versiones_ibfk_1` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`),
  CONSTRAINT `corridas_versiones_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_versiones_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_versiones_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corridasdisponibles`
--

DROP TABLE IF EXISTS `corridasdisponibles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corridasdisponibles` (
  `nNumero` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nProgramada` bigint(20) unsigned NOT NULL,
  `nItinerario` int(10) unsigned NOT NULL,
  `nTipoServicio` int(10) unsigned NOT NULL,
  `fSalida` date NOT NULL,
  `hSalida` time NOT NULL,
  `aEstado` varchar(1) NOT NULL,
  `nNumeroAutobus` int(11) NOT NULL,
  `nNumeroConductor` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nNumeroAutobus` (`nNumeroAutobus`),
  KEY `nTipoServicio` (`nTipoServicio`),
  KEY `corridasdisponibles_IN` (`nNumero`,`nProgramada`,`nItinerario`,`nNumeroAutobus`),
  KEY `corridasdisponibles_ibfk_1` (`nNumeroConductor`),
  KEY `corridasdisponibles_ibfk_3` (`nProgramada`),
  KEY `corridasdisponibles_ibfk_5` (`nItinerario`),
  KEY `FK_corridaestado` (`aEstado`),
  CONSTRAINT `FK_corridaestado` FOREIGN KEY (`aEstado`) REFERENCES `corridas_estados` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridasdisponibles_ibfk_1` FOREIGN KEY (`nNumeroConductor`) REFERENCES `conductores` (`nNumeroConductor`),
  CONSTRAINT `corridasdisponibles_ibfk_2` FOREIGN KEY (`nNumeroAutobus`) REFERENCES `autobuses` (`nNumeroAutobus`),
  CONSTRAINT `corridasdisponibles_ibfk_3` FOREIGN KEY (`nProgramada`) REFERENCES `corridasprogramadas` (`nNumero`),
  CONSTRAINT `corridasdisponibles_ibfk_4` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`),
  CONSTRAINT `corridasdisponibles_ibfk_5` FOREIGN KEY (`nItinerario`) REFERENCES `itinerario` (`nItinerario`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corridasprogramadas`
--

DROP TABLE IF EXISTS `corridasprogramadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corridasprogramadas` (
  `nNumero` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nItinerario` int(10) unsigned NOT NULL,
  `nTipoServicio` int(10) unsigned NOT NULL,
  `hSalida` time NOT NULL,
  `lLunes` tinyint(1) NOT NULL,
  `lMartes` tinyint(1) NOT NULL,
  `lMiercoles` tinyint(1) NOT NULL,
  `lJueves` tinyint(1) NOT NULL,
  `lViernes` tinyint(1) NOT NULL,
  `lSabado` tinyint(1) NOT NULL,
  `lDomingo` tinyint(1) NOT NULL,
  `fInicio` date NOT NULL,
  `fFin` date NOT NULL,
  `version` smallint(5) unsigned NOT NULL DEFAULT 1,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nTipoServicio` (`nTipoServicio`),
  KEY `corridasprogramadas_IN` (`nNumero`,`nItinerario`),
  CONSTRAINT `corridasprogramadas_ibfk_1` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `descuentos`
--

DROP TABLE IF EXISTS `descuentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `descuentos` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aClaveConfirmacion` varchar(4) NOT NULL,
  `fInicio` date NOT NULL,
  `fFin` date NOT NULL,
  `nOrigen` int(10) unsigned NOT NULL,
  `nDestino` int(10) unsigned NOT NULL,
  `fCreacion` date NOT NULL DEFAULT current_timestamp(),
  `dDescuento` smallint(6) NOT NULL,
  `nPasajero` int(10) unsigned NOT NULL,
  `nSolicita` int(10) unsigned NOT NULL,
  `nOtorga` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nSolicita` (`nSolicita`),
  KEY `nOtorga` (`nOtorga`),
  KEY `nPasajero` (`nPasajero`),
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  CONSTRAINT `descuentos_ibfk_1` FOREIGN KEY (`nSolicita`) REFERENCES `personas` (`nNumeroPersona`),
  CONSTRAINT `descuentos_ibfk_2` FOREIGN KEY (`nOtorga`) REFERENCES `personas` (`nNumeroPersona`),
  CONSTRAINT `descuentos_ibfk_3` FOREIGN KEY (`nPasajero`) REFERENCES `personas` (`nNumeroPersona`),
  CONSTRAINT `descuentos_ibfk_4` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `descuentos_ibfk_5` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disponibilidad`
--

DROP TABLE IF EXISTS `disponibilidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disponibilidad` (
  `nNumero` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nCorridaDisponible` bigint(20) unsigned NOT NULL,
  `nOrigen` int(10) unsigned NOT NULL,
  `nDestino` int(10) unsigned NOT NULL,
  `fLlegada` date NOT NULL,
  `hLlegada` time NOT NULL,
  `fSalida` date NOT NULL,
  `hSalida` time NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  KEY `disponibilidad_IN` (`nNumero`,`nCorridaDisponible`,`nOrigen`,`nDestino`),
  KEY `disponibilidad_ibfk_3` (`nCorridaDisponible`),
  CONSTRAINT `disponibilidad_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `disponibilidad_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `disponibilidad_ibfk_3` FOREIGN KEY (`nCorridaDisponible`) REFERENCES `corridasdisponibles` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disponibilidadasientos`
--

DROP TABLE IF EXISTS `disponibilidadasientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disponibilidadasientos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nDisponibilidad` bigint(20) unsigned NOT NULL,
  `nAsiento` smallint(6) NOT NULL,
  `aEstadoAsiento` char(20) NOT NULL COMMENT 'D = Disponible\r\nA = Apartado\r\nV = Vendido\r\nB = Bloqueado',
  `last_update` datetime NOT NULL DEFAULT current_timestamp(),
  `nBoleto` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `nBoleto` (`nBoleto`),
  KEY `dispAsientos_user_id_FK` (`user_id`),
  KEY `disponibilidadasientos_ibfk_1` (`nDisponibilidad`),
  CONSTRAINT `dispAsientos_user_id_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `disponibilidadasientos_ibfk_1` FOREIGN KEY (`nDisponibilidad`) REFERENCES `disponibilidad` (`nNumero`),
  CONSTRAINT `disponibilidadasientos_ibfk_2` FOREIGN KEY (`nBoleto`) REFERENCES `boletosvendidos` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `distribucionasientos`
--

DROP TABLE IF EXISTS `distribucionasientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribucionasientos` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nAsientos` smallint(6) NOT NULL,
  `aDistribucion` text NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factorpaqueteria`
--

DROP TABLE IF EXISTS `factorpaqueteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factorpaqueteria` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aTipo` varchar(1) NOT NULL,
  `nValorMaximo` decimal(6,2) NOT NULL,
  `nFactor` decimal(3,2) NOT NULL,
  `fAplicacion` date NOT NULL,
  `fCreacion` datetime NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `familiares`
--

DROP TABLE IF EXISTS `familiares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `familiares` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nEmpleado` int(10) unsigned NOT NULL,
  `nFamiliar` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nFamiliar` (`nFamiliar`),
  KEY `nEmpleado` (`nEmpleado`),
  CONSTRAINT `familiares_ibfk_1` FOREIGN KEY (`nFamiliar`) REFERENCES `personas` (`nNumeroPersona`),
  CONSTRAINT `familiares_ibfk_2` FOREIGN KEY (`nEmpleado`) REFERENCES `personas` (`nNumeroPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formapagosubtipo`
--

DROP TABLE IF EXISTS `formapagosubtipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formapagosubtipo` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aClave` varchar(2) NOT NULL,
  `aDescripcion` varbinary(20) NOT NULL,
  `lPedirFolio` tinyint(1) NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `aClave` (`aClave`),
  CONSTRAINT `formapagosubtipo_ibfk_1` FOREIGN KEY (`aClave`) REFERENCES `formaspago` (`aClave`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formaspago`
--

DROP TABLE IF EXISTS `formaspago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formaspago` (
  `aClave` varchar(2) NOT NULL,
  `aDescripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`aClave`),
  UNIQUE KEY `aClave` (`aClave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itinerario`
--

DROP TABLE IF EXISTS `itinerario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itinerario` (
  `nItinerario` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nConsecutivo` int(11) NOT NULL,
  `nTramo` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nItinerario`,`nConsecutivo`) USING BTREE,
  KEY `itinerario_IN` (`nItinerario`,`nTramo`),
  KEY `itinerario_ibfk_1` (`nTramo`),
  CONSTRAINT `itinerario_ibfk_1` FOREIGN KEY (`nTramo`) REFERENCES `tramos` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oficinas`
--

DROP TABLE IF EXISTS `oficinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oficinas` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aClave` varchar(5) NOT NULL,
  `aNombre` varchar(15) NOT NULL,
  `aEntidad` varchar(25) NOT NULL,
  `aTipo` varchar(3) NOT NULL,
  `lDestino` tinyint(1) NOT NULL,
  `lDisponible` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  UNIQUE KEY `aClave` (`aClave`),
  UNIQUE KEY `PK_oficinas` (`nNumero`),
  KEY `oficinas_IN` (`nNumero`,`aClave`,`lDestino`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `origenesdestinos`
--

DROP TABLE IF EXISTS `origenesdestinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `origenesdestinos` (
  `nOrigen` int(10) unsigned NOT NULL,
  `nDestino` int(10) unsigned NOT NULL,
  `disponible` tinyint(1) DEFAULT NULL,
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  CONSTRAINT `origenesdestinos_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `origenesdestinos_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `periodos_vacacionales`
--

DROP TABLE IF EXISTS `periodos_vacacionales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodos_vacacionales` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `inicio` date NOT NULL,
  `fin` date NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp(),
  `updated_at` date NOT NULL,
  `deleted_at` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personas` (
  `nNumeroPersona` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aNombres` varchar(30) NOT NULL,
  `aApellidos` varchar(30) NOT NULL,
  `nOficina` int(10) unsigned DEFAULT NULL,
  `aTipo` varchar(2) DEFAULT NULL,
  `updated_at` date NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`nNumeroPersona`),
  UNIQUE KEY `nNumeroPersona` (`nNumeroPersona`),
  KEY `nOficina` (`nOficina`),
  KEY `FK_tipopersona` (`aTipo`),
  CONSTRAINT `FK_tipopersona` FOREIGN KEY (`aTipo`) REFERENCES `tipospersona` (`aTipo`) ON UPDATE CASCADE,
  CONSTRAINT `personas_ibfk_1` FOREIGN KEY (`nOficina`) REFERENCES `oficinas` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personas_estados`
--

DROP TABLE IF EXISTS `personas_estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personas_estados` (
  `aClave` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`aClave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `promociones`
--

DROP TABLE IF EXISTS `promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promociones` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aTipo` char(2) DEFAULT NULL COMMENT 'Tipo de pasajero',
  `aDescripcion` varchar(20) NOT NULL COMMENT 'Se detalla la aplicación de la promoción',
  `nDescuento` smallint(6) NOT NULL COMMENT 'Descuento aplicable en formato 00.00',
  `nCorridaProgramada` bigint(20) unsigned DEFAULT NULL,
  `nOficina` int(10) unsigned DEFAULT NULL,
  `nOrigen` int(10) unsigned DEFAULT NULL,
  `nDestino` int(10) unsigned DEFAULT NULL,
  `viajeRedondo` bit(1) DEFAULT NULL,
  `fInicio` date NOT NULL,
  `fFin` date NOT NULL,
  `fCreacion` date NOT NULL DEFAULT current_timestamp(),
  `nTipoServicio` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `FK_promo_corprog` (`nCorridaProgramada`),
  KEY `FK_promo_origen` (`nOrigen`),
  KEY `FK_promo_destino` (`nDestino`),
  KEY `FK_promo_pasaj` (`aTipo`),
  KEY `FK_promo_oficina` (`nOficina`),
  KEY `nTipoServicio` (`nTipoServicio`),
  CONSTRAINT `FK_promo_corprog` FOREIGN KEY (`nCorridaProgramada`) REFERENCES `corridasprogramadas` (`nNumero`),
  CONSTRAINT `FK_promo_destino` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `FK_promo_oficina` FOREIGN KEY (`nOficina`) REFERENCES `oficinas` (`nNumero`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_promo_origen` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `FK_promo_pasaj` FOREIGN KEY (`aTipo`) REFERENCES `tipopasajero` (`aClave`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `promociones_ibfk_2` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registropasopuntos`
--

DROP TABLE IF EXISTS `registropasopuntos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registropasopuntos` (
  `nCorrida` bigint(20) unsigned NOT NULL,
  `nConsecutivo` smallint(5) unsigned NOT NULL,
  `despachado` datetime DEFAULT NULL,
  `fLlegada` datetime DEFAULT NULL,
  `fSalida` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`nCorrida`,`nConsecutivo`),
  CONSTRAINT `registropasopuntos_ibfk_1` FOREIGN KEY (`nCorrida`) REFERENCES `corridasdisponibles` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sesiones`
--

DROP TABLE IF EXISTS `sesiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sesiones` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `nOficina` int(10) unsigned NOT NULL,
  `nMontoRecibido` float(10,2) unsigned NOT NULL,
  `fContable` date NOT NULL COMMENT 'Es la fecha contable a la que pertenece la sesion',
  `fCerrada` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOficina` (`nOficina`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `sesiones_ibfk_2` FOREIGN KEY (`nOficina`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `sesiones_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tarifastramos`
--

DROP TABLE IF EXISTS `tarifastramos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarifastramos` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nTipoServicio` int(10) unsigned NOT NULL,
  `nOrigen` int(10) unsigned NOT NULL,
  `nDestino` int(10) unsigned NOT NULL,
  `nMontoBaseRuta` decimal(6,2) NOT NULL,
  `nMontoBasePaqueteria` decimal(6,2) NOT NULL,
  `fAplicacion` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  KEY `nTipoServicio` (`nTipoServicio`),
  CONSTRAINT `tarifastramos_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `tarifastramos_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `tarifastramos_ibfk_3` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tarjetasboletinadas`
--

DROP TABLE IF EXISTS `tarjetasboletinadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarjetasboletinadas` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aNumeroTarjeta` varchar(16) NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `terminales`
--

DROP TABLE IF EXISTS `terminales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminales` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aTerminal` varchar(20) NOT NULL,
  `nOficina` int(10) unsigned NOT NULL,
  `aDescripcion` varchar(15) NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOficina` (`nOficina`),
  CONSTRAINT `terminales_ibfk_1` FOREIGN KEY (`nOficina`) REFERENCES `oficinas` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipopaquetes`
--

DROP TABLE IF EXISTS `tipopaquetes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipopaquetes` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aTipo` varchar(2) NOT NULL,
  `aDescripcioin` varchar(15) NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipopasajero`
--

DROP TABLE IF EXISTS `tipopasajero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipopasajero` (
  `aClave` varchar(2) NOT NULL,
  `aDescripcion` varchar(15) NOT NULL,
  `descuento` tinyint(1) NOT NULL,
  PRIMARY KEY (`aClave`),
  UNIQUE KEY `aClave` (`aClave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tiposboletos`
--

DROP TABLE IF EXISTS `tiposboletos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tiposboletos` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aTipo` varbinary(1) NOT NULL,
  `aDescripcion` varchar(20) NOT NULL,
  `nCantidad` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tiposervicio`
--

DROP TABLE IF EXISTS `tiposervicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tiposervicio` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aClave` char(2) NOT NULL,
  `aDescripcion` varchar(20) NOT NULL,
  `nDistribucionAsientos` int(10) unsigned NOT NULL,
  `ocupacionMinima` smallint(5) unsigned NOT NULL,
  `descuentosMax` smallint(2) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  UNIQUE KEY `aClave` (`aClave`),
  KEY `nDistribucionAsientos` (`nDistribucionAsientos`),
  CONSTRAINT `tiposervicio_ibfk_1` FOREIGN KEY (`nDistribucionAsientos`) REFERENCES `distribucionasientos` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipospersona`
--

DROP TABLE IF EXISTS `tipospersona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipospersona` (
  `aTipo` varchar(2) NOT NULL,
  `aNombre` varchar(40) NOT NULL,
  PRIMARY KEY (`aTipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipoventa`
--

DROP TABLE IF EXISTS `tipoventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoventa` (
  `aClave` varchar(4) NOT NULL,
  `aDescripcion` text NOT NULL,
  `ntipoboleto` int(10) unsigned NOT NULL,
  PRIMARY KEY (`aClave`),
  UNIQUE KEY `aClave` (`aClave`),
  KEY `ntipoboleto` (`ntipoboleto`),
  CONSTRAINT `tipoventa_ibfk_1` FOREIGN KEY (`ntipoboleto`) REFERENCES `tiposboletos` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='CO = Boleto Confirmado\r\nAB = Boleto Abierto\r\nMA = Boleto Manual\r\nPC = Paqueteria Comercial\r\nPI = Paqueteria Interna\r\nEE = Exceso equipaje\r\nGE = Guarda equipaje\r\nBI = Boleto Internet\r\nBA = Boleto Agencia\r\nBW = Boleto WebServices\r\nAP = Abono Paqueteria';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tramos`
--

DROP TABLE IF EXISTS `tramos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tramos` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nOrigen` int(10) unsigned NOT NULL,
  `nDestino` int(10) unsigned NOT NULL,
  `nKilometros` int(11) NOT NULL,
  `nTiempo` int(11) NOT NULL,
  `nEstancia` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  KEY `tramos_IN` (`nNumero`,`nOrigen`,`nDestino`),
  CONSTRAINT `tramos_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `tramos_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `persona_nNumero` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `persona_nNumero` (`persona_nNumero`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`persona_nNumero`) REFERENCES `personas` (`nNumeroPersona`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venta` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nSesion` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nSesion` (`nSesion`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`nSesion`) REFERENCES `sesiones` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ventapago`
--

DROP TABLE IF EXISTS `ventapago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventapago` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nVenta` int(10) unsigned NOT NULL,
  `aFormaPago` varchar(2) NOT NULL,
  `nFormaPagoSubtipo` int(10) unsigned DEFAULT NULL,
  `nMonto` decimal(7,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `aFolioDocumento` varchar(20) DEFAULT NULL,
  `aAutorizacionBanco` varchar(10) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nVenta` (`nVenta`),
  KEY `aFormaPago` (`aFormaPago`),
  KEY `nFormaPagoSubtipo` (`nFormaPagoSubtipo`),
  CONSTRAINT `ventapago_ibfk_1` FOREIGN KEY (`nVenta`) REFERENCES `venta` (`nNumero`),
  CONSTRAINT `ventapago_ibfk_2` FOREIGN KEY (`aFormaPago`) REFERENCES `formaspago` (`aClave`),
  CONSTRAINT `ventapago_ibfk_3` FOREIGN KEY (`nFormaPagoSubtipo`) REFERENCES `formapagosubtipo` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ventascliente`
--

DROP TABLE IF EXISTS `ventascliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventascliente` (
  `nVenta` int(10) unsigned NOT NULL,
  `nCliente` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nVenta`,`nCliente`),
  KEY `nCliente` (`nCliente`),
  CONSTRAINT `ventascliente_ibfk_1` FOREIGN KEY (`nVenta`) REFERENCES `venta` (`nNumero`),
  CONSTRAINT `ventascliente_ibfk_2` FOREIGN KEY (`nCliente`) REFERENCES `clientes` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `vw_iti_tra`
--

DROP TABLE IF EXISTS `vw_iti_tra`;
/*!50001 DROP VIEW IF EXISTS `vw_iti_tra`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_iti_tra` (
  `itinerario` tinyint NOT NULL,
  `iti_consecutivo` tinyint NOT NULL,
  `tra_consecutivo` tinyint NOT NULL,
  `tramo` tinyint NOT NULL,
  `tra_origen` tinyint NOT NULL,
  `tra_destino` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'laravel'
--
/*!50003 DROP FUNCTION IF EXISTS `apartar_asiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `apartar_asiento`(IN_nCorrida INT,

    IN_nOrigen INT,

    IN_nDestino INT,

    IN_nAsientos TEXT,

    IN_user INT

    ) RETURNS text CHARSET utf8mb4
BEGIN

    DECLARE specialty CONDITION FOR SQLSTATE '45000'; 

    DECLARE retorno TEXT DEFAULT ""; 

    

    DECLARE done_restriccion INT DEFAULT FALSE;

    DECLARE var_disp SMALLINT;

    DECLARE crsr_restriccion CURSOR FOR SELECT disp.nNumero from

        corridasdisponibles as cordis

        INNER JOIN  vw_iti_tra as vw

            ON cordis.nItinerario=cordis.nItinerario

        INNER JOIN disponibilidad as disp

            ON disp.nCorridaDisponible=cordis.nNumero AND disp.nOrigen=vw.tra_origen AND disp.nDestino=vw.tra_destino

        where 

        cordis.nNumero=IN_nCorrida

        AND vw.itinerario=cordis.nItinerario

        AND 

        (

            (

                vw.tra_consecutivo>=IFNULL((

                    SELECT itiSub.nConsecutivo FROM itinerario as itiSub

                    INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo

                    WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen 

                    ),

                    0

                )

                AND vw.tra_consecutivo>IFNULL(

                    (

                        SELECT itiSub.nConsecutivo FROM itinerario as itiSub

                        INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo

                        WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen 

                    ),

                    0

                )

            )

            AND

            (

                vw.iti_consecutivo < IFNULL(

                    (

                        SELECT itiSub.nConsecutivo FROM itinerario as itiSub

                        INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo

                        WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nDestino 

                    )+1,

                    9999

                )

                

            )

        ) ORDER BY vw.itinerario, vw.iti_consecutivo ASC, vw.tra_consecutivo ASC;



    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_restriccion = TRUE;

    

    declare exit handler for sqlexception BEGIN

        

        

        SIGNAL SQLSTATE '45000' 

			SET MESSAGE_TEXT = "Error al insertar pasajero"; 

				

    END;





    

	IF IN_nAsientos="" OR IN_user=0 THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'ESCRIBA TODOS LOS DATOS DEL PASAJERO'; 

	END IF;



    

    OPEN crsr_restriccion;

        read_loop: LOOP

            FETCH crsr_restriccion INTO var_disp;

            IF done_restriccion THEN

                LEAVE read_loop;

            END IF;

            

            

            SET @aux=CONCAT(IN_nAsientos,",");

            WHILE (LOCATE(',', @aux)>0) DO

                set @var_asiento=SUBSTRING(@aux, 1,2);

                SET @aux=SUBSTRING(@aux, LOCATE(',',@aux) + 1);



                INSERT INTO `disponibilidadasientos` (nDisponibilidad, nAsiento, aEstadoAsiento, nBoleto, user_id)

                    VALUES(var_disp, @var_asiento, 'A', null, IN_user);

                set retorno=CONCAT(retorno,LAST_INSERT_ID(),",");

            END WHILE;

            

        END LOOP;

    CLOSE crsr_restriccion;

    RETURN CASE 

        WHEN retorno='' THEN "NO INSERTADO"

        ELSE SUBSTRING(retorno, 1, CHAR_LENGTH(retorno)-1)

    END;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `corridasPorDia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `corridasPorDia`(IN_fIni DATE, IN_dias SMALLINT) RETURNS int(11)
BEGIN







    DECLARE fFin DATE;







    DECLARE fMax DATE;







    DECLARE ins INT;







    







    SET fFin=IN_fIni + INTERVAL IN_dias DAY;







    SET ins=0;







    SET fMax=(SELECT max(`fFin`) FROM `corridasprogramadas`);















    WHILE IN_fIni<=fFin AND IN_fIni<=fMax DO







        SET ins=ins+crear_corridas_disponibles(IN_fIni);







        SET IN_fIni = IN_fIni + INTERVAL 1 DAY;







    END WHILE;







    







    RETURN ins;







END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `crear_corridas_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `crear_corridas_disponibles`(IN_fecha DATE) RETURNS int(11)
BEGIN



    



    DECLARE corridas_insertadas INT;



    DECLARE disponibilidad_insertadas SMALLINT;



        



    DECLARE totalInserted SMALLINT;



    DECLARE curProg_ID INT;



    DECLARE curProg_nIti INT;



    DECLARE curProg_nTipSer INT;



    DECLARE curProg_hSal TIME;



    DECLARE done INT DEFAULT FALSE; 



    DECLARE cursor_Prog CURSOR FOR SELECT 



        cop.nNumero, cop.nItinerario, cop.nTipoServicio, cop.hSalida



        FROM corridasprogramadas cop



        LEFT JOIN corridasdisponibles cod on cop.nNumero=cod.nProgramada and cod.fSalida=IN_fecha



        WHERE IN_fecha>=cop.fInicio and IN_fecha<=cop.fFin and cop.deleted_at IS NULL



        and cod.nNumero IS NULL



        AND (CASE 



            WHEN (cop.lDomingo  AND (SELECT DAYOFWEEK(IN_fecha)=1)) THEN true



            WHEN (cop.lLunes    AND (SELECT DAYOFWEEK(IN_fecha)=2)) THEN true



            WHEN (cop.lMartes   AND (SELECT DAYOFWEEK(IN_fecha)=3)) THEN true



            WHEN (cop.lMiercoles AND (SELECT DAYOFWEEK(IN_fecha)=4)) THEN true



            WHEN (cop.lJueves   AND (SELECT DAYOFWEEK(IN_fecha)=5)) THEN true



            WHEN (cop.lViernes  AND (SELECT DAYOFWEEK(IN_fecha)=6)) THEN true



            WHEN (cop.lSabado   AND (SELECT DAYOFWEEK(IN_fecha)=7)) THEN true



            ELSE false



        end);



    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE; 







    SET corridas_insertadas=0; 



    SET disponibilidad_insertadas=0; 







    OPEN cursor_Prog; 



        read_loop: LOOP 



            



            FETCH cursor_Prog INTO curProg_ID, curProg_nIti, curProg_nTipSer, curProg_hSal;



            IF done THEN 



            LEAVE read_loop;



            END IF;



            



            



            INSERT INTO `corridasdisponibles`(`nProgramada`, `nItinerario`, `nTipoServicio`, `fSalida`, `hSalida`,



                    `aEstado`, `nNumeroAutobus`) VALUES



                    (curProg_ID,curProg_nIti,curProg_nTipSer,IN_fecha,curProg_hSal,'D', 



                        (SELECT nNumeroAutobus from autobuses where `nTipoServicio`=curProg_nTipSer limit 1)



                        );



            



                



            SET corridas_insertadas=corridas_insertadas+1;



            SET disponibilidad_insertadas = crear_disponibilidad(LAST_INSERT_ID());



        



        END LOOP;



    CLOSE cursor_Prog;



    RETURN corridas_insertadas;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `crear_disponibilidad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `crear_disponibilidad`(IN_corrida_dis INT) RETURNS smallint(6)
BEGIN







    DECLARE curDisp_nOrigen INT UNSIGNED;







    DECLARE curDisp_nDestino INT UNSIGNED;







    DECLARE curDisp_hLlega DATETIME;







    DECLARE curDisp_hSale DATETIME;







    DECLARE curDisp_inserted BOOLEAN;







    







    DECLARE done INT DEFAULT FALSE; 



    DECLARE cursor_Disp CURSOR FOR SELECT







        TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (







            SELECT







            IF(SUM(tr.nTiempo)+tr.nEstancia IS NULL, 0, SUM(tr.nTiempo)+tr.nEstancia)







            FROM `itinerario` itiSub







            INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo







            WHERE itiSub.nItinerario=iti.nItinerario







            and itiSub.nConsecutivo<(







                SELECT itiSub2.nConsecutivo FROM `itinerario` itiSub2







                INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo







                WHERE itiSub2.nItinerario=iti.nItinerario and trSub.nOrigen=tra.nOrigen







            )







        ) MINUTE as hSalidaCorrida,







        TIMESTAMP(cordis.fSalida, cordis.hSalida) + INTERVAL (







            (







                SELECT







                IF( SUM(trSub.nTiempo) is NULL, 0, SUM(trSub.nTiempo))







                as tiempoTrans







                FROM `itinerario` itiSub







                INNER JOIN tramos trSub on itiSub.nTramo=trSub.nNumero







                WHERE itiSub.`nItinerario`=cordis.nItinerario and itiSub.nConsecutivo<=cadaTramo.nConsecutivo







                ORDER BY itiSub.nConsecutivo ASC 



            )







            +







            (







                SELECT







                IF( SUM(tr.nEstancia) IS NULL, 0, SUM(tr.nEstancia))







                FROM  itinerario as itiSub







                INNER JOIN tramos tr on tr.nNumero=itiSub.nTramo







                WHERE itiSub.nItinerario=3 



                AND itiSub.nConsecutivo<(







                    SELECT itiSub2.nConsecutivo FROM itinerario as itiSub2







                    INNER JOIN tramos trSub on trSub.nNumero=itiSub2.nTramo







                    WHERE trSub.nDestino=cadaTramo.nDestino AND  itiSub2.nItinerario=iti.nItinerario 



                    ORDER BY itiSub2.nConsecutivo ASC 



                )







            )







        ) MINUTE as hLlegadaCalc,







        tra.nOrigen, cadaTramo.nDestino







        FROM corridasdisponibles cordis







        JOIN itinerario iti on iti.nItinerario=cordis.nItinerario







        join tramos tra on tra.nNumero=iti.nTramo







        JOIN (







            SELECT itiSub.nItinerario, itiSub.nConsecutivo, tramSub.nOrigen, tramSub.nDestino  from itinerario as itiSub







                INNER JOIN tramos as tramSub on tramSub.nNumero=itiSub.nTramo 



        ) as cadaTramo on cadaTramo.nItinerario=iti.nItinerario and cadaTramo.nConsecutivo>=iti.nConsecutivo







        INNER JOIN oficinas as ofiOri on ofiOri.nNumero=tra.nOrigen







        INNER JOIN oficinas as ofiDes on ofiDes.nNumero=cadaTramo.nDestino







        LEFT JOIN disponibilidad as dis on dis.nCorridaDisponible=cordis.nNumero







            and dis.nOrigen=tra.nOrigen and dis.nDestino=cadaTramo.nDestino







        where cordis.nNumero=IN_corrida_dis and dis.nNumero IS NULL AND tra.nOrigen!=cadaTramo.nDestino







        order by iti.nConsecutivo;







    







    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;















    SET curDisp_inserted=0;















    OPEN cursor_Disp;







        read_loop: LOOP







            FETCH cursor_Disp INTO curDisp_hSale, curDisp_hLlega, curDisp_nOrigen, curDisp_nDestino; 



            IF done THEN







                LEAVE read_loop;







            END IF;















            INSERT INTO disponibilidad







                (`nCorridaDisponible`, `nOrigen`, `nDestino`, `fLlegada`, `hLlegada`, `fSalida`, `hSalida`)







                VALUES (IN_corrida_dis, curDisp_nOrigen, curDisp_nDestino, DATE(curDisp_hLlega), TIME(curDisp_hLlega), DATE(curDisp_hSale), TIME(curDisp_hSale));







        SET curDisp_inserted=curDisp_inserted+1;







        END LOOP;







    CLOSE cursor_Disp;







    RETURN curDisp_inserted;







END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `estadoAsientos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `estadoAsientos`(IN_cordis BIGINT UNSIGNED, IN_origen INT UNSIGNED, IN_destino INT UNSIGNED,







        IN_nAsiento SMALLINT UNSIGNED, IN_estado VARCHAR(2)) RETURNS text CHARSET utf8mb4
BEGIN







    



    



    DECLARE code CHAR(5) DEFAULT '00000';







    DECLARE msg TEXT DEFAULT "";







    DECLARE nrows INT UNSIGNED DEFAULT 0;







    DECLARE result TEXT DEFAULT "Corrida no encontrada";















    DECLARE v_done INT DEFAULT FALSE; 



    DECLARE v_nDispo BIGINT UNSIGNED;







    DECLARE v_disp INT UNSIGNED;







    DECLARE v_origen INT UNSIGNED;







    DECLARE v_destino INT UNSIGNED;







    



    DECLARE v_recorrido CURSOR FOR







        SELECT origenes.origen, destinos.destino







        FROM (







            SELECT







            iti.nItinerario, iti.nConsecutivo, tr.nOrigen "origen" 







            FROM  `itinerario` iti







            INNER JOIN `tramos` tr on tr.nNumero=iti.nTramo







            WHERE iti.nItinerario=(SELECT nItinerario from corridasdisponibles where corridasdisponibles.nNumero=IN_cordis) 



            and nConsecutivo>=(







                SELECT nConsecutivo FROM  itinerario itiSub







                INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo







                WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=IN_origen 



            )







            and nConsecutivo<=(







                SELECT nConsecutivo FROM  itinerario itiSub







                INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo







                WHERE itiSub.nItinerario=iti.nItinerario and tr.nDestino=IN_destino 



            )







        ) as origenes







        JOIN (







            SELECT







            iti.nItinerario, iti.nConsecutivo, tr.nDestino "destino"







            FROM  `itinerario` iti







            INNER JOIN `tramos` tr on tr.nNumero=iti.nTramo







            WHERE iti.nItinerario=(SELECT nItinerario from corridasdisponibles where corridasdisponibles.nNumero=IN_cordis) 



            and nConsecutivo>=(







                SELECT nConsecutivo FROM  itinerario itiSub







                INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo







                WHERE itiSub.nItinerario=iti.nItinerario and tr.nOrigen=IN_origen 



            )







            and nConsecutivo<=(







                SELECT nConsecutivo FROM  itinerario itiSub







                INNER JOIN `tramos` tr on tr.nNumero=itiSub.nTramo







                WHERE itiSub.nItinerario=iti.nItinerario and tr.nDestino=IN_destino 



            )







        ) as destinos on origenes.nItinerario=destinos.nItinerario







            and origenes.origen!=destinos.destino







            and destinos.nConsecutivo>=origenes.nConsecutivo;







    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;







    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION







    BEGIN







      GET DIAGNOSTICS CONDITION 1







        code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;







    END;







    OPEN v_recorrido;







        read_loop: LOOP







            FETCH v_recorrido INTO v_origen, v_destino;







            IF v_done THEN







                LEAVE read_loop;







            END IF;















            SELECT nNumero INTO v_nDispo FROM `disponibilidad`







            WHERE `nCorridaDisponible`=IN_cordis







            AND `nOrigen`= v_origen AND nDestino=v_destino;















            INSERT INTO disponibilidadasientos (nDisponibilidad,nAsiento,aEstadoAsiento)







            VALUES (v_nDispo, IN_nAsiento, IN_estado);















            



            IF code = '00000' THEN







                GET DIAGNOSTICS @nrows = ROW_COUNT;







                SET nrows=nrows+1;







                SET result = CONCAT('insert succeeded, row count = ',nrows);







            ELSE







                SET result = CONCAT('insert failed, error = ',code,', message = ',msg);







                LEAVE read_loop;







            END IF;







        END LOOP;







    CLOSE v_recorrido;







    RETURN result;







END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `exceptionTest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `exceptionTest`(IN_val BOOLEAN) RETURNS text CHARSET utf8mb4
BEGIN







    DECLARE specialty CONDITION FOR SQLSTATE '45000'; 











    IF IN_val = 1 THEN







        SIGNAL SQLSTATE '45000' 



        SET MESSAGE_TEXT = 'this is fucked up', 



            MYSQL_ERRNO  = 1000;







    END IF;







    RETURN "success";







END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insert_pasajero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insert_pasajero`(IN_nVenta INT,







    IN_nCorrida INT,







    IN_fSalida DATE,







    IN_hSalida TIME,







    IN_nOrigen INT,







    IN_nDestino INT,







    IN_aTipoPasajero VARCHAR(2),







    IN_aPasajero TEXT,







    IN_nAsiento VARCHAR(2),







    IN_aTipoVenta VARCHAR(4),







    IN_nMontoBase DECIMAL(6,2),







    IN_nMontoDescuento DECIMAL(6,2),







    IN_nIva DECIMAL(6,2),







    IN_aEstado CHAR(20), 



    IN_nTerminal INT,







    IN_nPromocion INT,







    IN_nDescuento INT







    ) RETURNS text CHARSET utf8mb4
BEGIN







    DECLARE specialty CONDITION FOR SQLSTATE '45000'; 



    DECLARE retorno TEXT DEFAULT ""; 



    DECLARE var_idBoletoVendido INT DEFAULT 0;























    INSERT INTO Boletosvendidos







        (nVenta, nCorrida, fSalida, hSalida, nOrigen, nDestino, aTipoPasajero, aPasajero, nAsiento,







            aTipoVenta, nMontoBase, nMontoDescuento, nIva, aEstado, nTerminal)







        VALUES







            (IN_nVenta,IN_nCorrida, IN_fSalida, IN_hSalida, IN_nOrigen, IN_nDestino, IN_aTipoPasajero, IN_aPasajero, IN_nAsiento,







                IN_aTipoVenta, IN_nMontoBase, IN_nMontoDescuento, IN_nIva, IN_aEstado, IN_nTerminal);







    SET var_idBoletoVendido=LAST_INSERT_ID(); 















    IF IN_nPromocion!=0 OR IN_nPromocion!=NULL THEN







        INSERT INTO boletosvendidos_promociones (nBoletoVendido, nPromocion)







            VALUES (var_idBoletoVendido,IN_nPromocion);







    END IF;















	IF IN_nVenta=0 OR IN_fSalida="" OR IN_hSalida="" OR IN_aTipoPasajero="" OR IN_aPasajero=""







		OR IN_nAsiento=0 OR IN_aTipoVenta="" OR IN_nMontoBase=0 OR IN_nIva=0 or IN_aEstado="" 







		OR IN_nTerminal=0







		THEN







			SIGNAL SQLSTATE '45000' 



			SET MESSAGE_TEXT = 'ESCRIBA TODOS LOS DATOS DEL PASAJERO', 



				MYSQL_ERRNO  = 1000;







	END IF;















    IF var_idBoletoVendido!=0 THEN







        SET retorno=var_idBoletoVendido;







    END IF;







    RETURN retorno;







END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `refrescar_asientos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `refrescar_asientos`(IN_asientos text, IN_vigencia datetime) RETURNS text CHARSET utf8mb4
BEGIN

    DECLARE retorno INT DEFAULT 0;

    DECLARE vr_encontrados INT UNSIGNED;



    DECLARE vr_idAsiento INT;

    

    SET IN_asientos=CONCAT(IN_asientos, ",");

    

    WHILE (LOCATE(',',IN_asientos))DO

        SET vr_idAsiento = SUBSTRING(IN_asientos, 1, LOCATE(',',IN_asientos)); 

        SET IN_asientos=SUBSTRING(IN_asientos, LOCATE(',',IN_asientos)+1);

        

        SELECT nAsiento into vr_encontrados

        FROM `disponibilidadasientos` as disa where disa.id=vr_idAsiento;

        IF vr_encontrados IS NOT NULL THEN

            IF IN_vigencia IS NULL THEN

                UPDATE `disponibilidadasientos` SET last_update=now() WHERE id=vr_idAsiento;

            ELSE

                UPDATE `disponibilidadasientos` SET last_update=IN_vigencia WHERE id=vr_idAsiento;

            END IF;

            SET retorno=retorno+1;

        END IF;

    END WHILE;

RETURN retorno;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `apartar_asientos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `apartar_asientos`(

    IN IN_nCorrida INT,

    IN IN_nOrigen INT,

    IN IN_nDestino INT,

    IN IN_nAsientos TEXT,

    IN IN_user INT

)
BEGIN

    

    declare exit handler for sqlexception

       BEGIN

        ROLLBACK;

        RESIGNAL SET MYSQL_ERRNO = 5;

    END;



    START TRANSACTION;

    SELECT apartar_asiento(

        IN_nCorrida,

        IN_nOrigen,

        IN_nDestino,

        CONCAT(IN_nAsientos,","),

        IN_user

    );

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_pasajero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pasajero`(

    IN IN_nVenta INT,

    IN IN_nCorrida INT,

    IN IN_fSalida DATE,

    IN IN_hSalida TIME,

    IN IN_nOrigen INT,

    IN IN_nDestino INT,

    IN IN_aTipoPasajero VARCHAR(2),

    IN IN_aPasajero TEXT,

    IN IN_nAsiento VARCHAR(2),

    IN IN_aTipoVenta VARCHAR(4),

    IN IN_nMontoBase DECIMAL(6,2),

    IN IN_nMontoDescuento DECIMAL(6,2),

    IN IN_nIva DECIMAL(6,2),

    IN IN_aEstado CHAR(20), 

    IN IN_nTerminal INT,

    IN IN_nPromocion INT,

    IN IN_nDescuento INT,

    IN IN_user INT

    )
BEGIN

        DECLARE specialty CONDITION FOR SQLSTATE '45000'; 

        DECLARE retorno TEXT DEFAULT ""; 

        DECLARE var_idBoletoVendido INT DEFAULT 0;

        

        DECLARE done_restriccion INT DEFAULT FALSE;

        

        DECLARE var_disp SMALLINT;

        DECLARE crsr_restriccion CURSOR FOR SELECT disp.nNumero from

            corridasdisponibles as cordis

            INNER JOIN  vw_iti_tra as vw

                ON cordis.nItinerario=cordis.nItinerario

            INNER JOIN disponibilidad as disp

                ON disp.nCorridaDisponible=cordis.nNumero AND disp.nOrigen=vw.tra_origen AND disp.nDestino=vw.tra_destino

            where 

            cordis.nNumero=IN_nCorrida

            AND vw.itinerario=cordis.nItinerario

            AND 

            (

                (

                    vw.tra_consecutivo>=IFNULL((

                        SELECT itiSub.nConsecutivo FROM itinerario as itiSub

                        INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo

                        WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen 

                        ),

                        0

                    )

                    AND vw.tra_consecutivo>IFNULL(

                        (

                            SELECT itiSub.nConsecutivo FROM itinerario as itiSub

                            INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo

                            WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nOrigen 

                        ),

                        0

                    )

                )

                AND

                (

                    vw.iti_consecutivo < IFNULL(

                        (

                            SELECT itiSub.nConsecutivo FROM itinerario as itiSub

                            INNER JOIN tramos as trSub ON trSub.nNumero=itiSub.nTramo

                            WHERE itiSub.nItinerario=vw.itinerario and trSub.nDestino=IN_nDestino 

                        )+1,

                        9999

                    )

                    

                )

            ) ORDER BY vw.itinerario, vw.iti_consecutivo ASC, vw.tra_consecutivo ASC;



        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_restriccion = TRUE;

        

        declare exit handler for sqlexception

        BEGIN

            

            ROLLBACK;

            

            SIGNAL SQLSTATE '45000' 

                SET MESSAGE_TEXT = "Error al insertar pasajero"; 

                    

        END;



    START TRANSACTION; 

    

	IF IN_nVenta=0 OR IN_fSalida="" OR IN_hSalida="" OR IN_aTipoPasajero="" OR IN_aPasajero=""

		OR IN_nAsiento=0 OR IN_aTipoVenta="" OR IN_nMontoBase=0 OR IN_nIva=0 or IN_aEstado="" 

		OR IN_nTerminal=0

		THEN

            

			SIGNAL SQLSTATE '45000' 

			SET MESSAGE_TEXT = 'ESCRIBA TODOS LOS DATOS DEL PASAJERO'; 

				

	END IF;



    

    INSERT INTO boletosvendidos

        (nVenta, nCorrida, fSalida, hSalida, nOrigen, nDestino, aTipoPasajero, aPasajero, nAsiento,

            aTipoVenta, nMontoBase, nMontoDescuento, nIva, aEstado, nTerminal)

        VALUES

            (IN_nVenta,IN_nCorrida, IN_fSalida, IN_hSalida, IN_nOrigen, IN_nDestino, IN_aTipoPasajero, IN_aPasajero, IN_nAsiento,

                IN_aTipoVenta, IN_nMontoBase, IN_nMontoDescuento, IN_nIva, IN_aEstado, IN_nTerminal);

    SET var_idBoletoVendido=LAST_INSERT_ID();



    

    OPEN crsr_restriccion;

        read_loop: LOOP

            FETCH crsr_restriccion INTO var_disp;

            IF done_restriccion THEN

                LEAVE read_loop;

            END IF;

            INSERT INTO `disponibilidadasientos` (nDisponibilidad, nAsiento, aEstadoAsiento, nBoleto, user_id)

                VALUES(var_disp, IN_nAsiento, 'O', var_idBoletoVendido, IN_user);

        END LOOP;

    CLOSE crsr_restriccion;



    

    IF IN_nPromocion!=0 OR IN_nPromocion!=NULL THEN

        INSERT INTO boletosvendidos_promociones (nBoletoVendido, nPromocion)

            VALUES (var_idBoletoVendido,IN_nPromocion);

    END IF;



    IF var_idBoletoVendido!=0 THEN

        SET retorno=var_idBoletoVendido;

    END IF;

    SELECT 1 as completado; 

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `test`(

    IN IN_nCorrida INT,

    IN IN_nOrigen INT,

    IN IN_nDestino INT,

    IN IN_nAsientos TEXT,

    IN IN_user INT

)
BEGIN

    

    

    declare exit handler for sqlexception

    BEGIN

        

        SIGNAL SQLSTATE '45000' 

            SET MESSAGE_TEXT = "Error al insertar pasajero"; 

                

    END;

    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_iti_tra_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_iti_tra_update`()
    COMMENT 'Ayuda para consultar dónde se debe restringir la venta'
BEGIN 

    CREATE OR REPLACE VIEW `vw_iti_tra` AS

    SELECT iti.nItinerario AS itinerario, iti.nConsecutivo AS iti_consecutivo, cadatramo.nConsecutivo AS tra_consecutivo, tra.nNumero AS tramo, tra.nOrigen AS tra_origen, cadatramo.nDestino AS tra_destino



    FROM itinerario iti join tramos tra on(tra.nNumero = iti.nTramo)

    join (

        select itisub.nItinerario AS nItinerario,itisub.nConsecutivo AS nConsecutivo,tramsub.nOrigen AS nOrigen,tramsub.nDestino AS nDestino

        from itinerario itisub join tramos tramsub on tramsub.nNumero = itisub.nTramo

    ) as cadatramo 

        on cadatramo.nItinerario = iti.nItinerario and cadatramo.nConsecutivo >= iti.nConsecutivo

    WHERE tra.nOrigen <> cadatramo.nDestino

    ORDER BY iti.nItinerario ASC, iti.nConsecutivo ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_iti_tra`
--

/*!50001 DROP TABLE IF EXISTS `vw_iti_tra`*/;
/*!50001 DROP VIEW IF EXISTS `vw_iti_tra`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_iti_tra` AS select `iti`.`nItinerario` AS `itinerario`,`iti`.`nConsecutivo` AS `iti_consecutivo`,`cadatramo`.`nConsecutivo` AS `tra_consecutivo`,`tra`.`nNumero` AS `tramo`,`tra`.`nOrigen` AS `tra_origen`,`cadatramo`.`nDestino` AS `tra_destino` from ((`laravel`.`itinerario` `iti` join `laravel`.`tramos` `tra` on(`tra`.`nNumero` = `iti`.`nTramo`)) join (select `itisub`.`nItinerario` AS `nItinerario`,`itisub`.`nConsecutivo` AS `nConsecutivo`,`tramsub`.`nOrigen` AS `nOrigen`,`tramsub`.`nDestino` AS `nDestino` from (`laravel`.`itinerario` `itisub` join `laravel`.`tramos` `tramsub` on(`tramsub`.`nNumero` = `itisub`.`nTramo`))) `cadatramo` on(`cadatramo`.`nItinerario` = `iti`.`nItinerario` and `cadatramo`.`nConsecutivo` >= `iti`.`nConsecutivo`)) where `tra`.`nOrigen` <> `cadatramo`.`nDestino` order by `iti`.`nItinerario`,`iti`.`nConsecutivo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-14 16:25:45
