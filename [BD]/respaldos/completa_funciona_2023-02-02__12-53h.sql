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
-- Dumping data for table `autobusconductor`
--

LOCK TABLES `autobusconductor` WRITE;
/*!40000 ALTER TABLE `autobusconductor` DISABLE KEYS */;
/*!40000 ALTER TABLE `autobusconductor` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autobuses`
--

LOCK TABLES `autobuses` WRITE;
/*!40000 ALTER TABLE `autobuses` DISABLE KEYS */;
INSERT INTO `autobuses` VALUES (74,'5005',5,6),(75,'5006',5,6),(76,'5401',5,3),(77,'5402',5,3),(78,'5403',5,3),(79,'5404',5,3),(80,'5405',5,3),(81,'5406',5,3),(82,'5407',5,3),(83,'5408',5,3),(84,'5409',5,3),(85,'5410',5,3),(86,'5411',5,3),(87,'5425',5,3),(88,'5426',5,3),(89,'5427',5,3),(90,'5428',5,3),(91,'5429',5,3),(92,'5430',5,3),(93,'5431',5,3),(94,'5432',5,3),(95,'5433',5,3),(96,'5434',5,3),(97,'5435',5,3),(98,'5436',5,3),(99,'5437',5,3),(100,'5438',5,3),(101,'8014',5,1),(102,'9001',2,2),(103,'9002',2,2),(104,'9003',2,2),(105,'9004',2,2),(106,'9005',2,2),(107,'9007',2,2),(108,'9008',2,2),(109,'9009',2,2),(110,'9010',2,2),(111,'7001',2,2),(112,'7002',2,2),(113,'7003',2,2),(114,'7004',2,2),(115,'7005',2,2),(116,'7008',2,2),(117,'7009',2,2),(118,'7010',2,2),(119,'7011',2,2),(120,'7012',2,2),(121,'5412',3,3),(122,'5413',1,1),(123,'5414',1,1),(124,'5415',1,1),(125,'5416',1,1),(126,'5417',1,1),(127,'5418',1,1),(128,'5419',1,1),(129,'5420',1,1),(130,'5421',1,1),(131,'5422',1,1),(132,'5423',1,1),(133,'5424',1,1),(134,'8001',1,1),(135,'8002',1,1),(136,'8003',1,1),(137,'8004',1,1),(138,'8005',1,1),(139,'8006',1,1),(140,'8007',1,1),(141,'8008',1,1),(142,'8009',1,1),(143,'8010',1,1),(144,'8011',1,1),(145,'8012',1,1);
/*!40000 ALTER TABLE `autobuses` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `boletos_vendidos_estados`
--

LOCK TABLES `boletos_vendidos_estados` WRITE;
/*!40000 ALTER TABLE `boletos_vendidos_estados` DISABLE KEYS */;
INSERT INTO `boletos_vendidos_estados` VALUES ('AP','Abordo pasajero'),('CA','Cancelado'),('IN','Intercambiado'),('LI','Liquidado'),('LM','Limbo'),('PC','Paquete en Corrida'),('PD','Paquete en Destino'),('PE','Paquete Entregado'),('VE','Vendido');
/*!40000 ALTER TABLE `boletos_vendidos_estados` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `boletoscancelados`
--

LOCK TABLES `boletoscancelados` WRITE;
/*!40000 ALTER TABLE `boletoscancelados` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletoscancelados` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `boletosdisponibles`
--

LOCK TABLES `boletosdisponibles` WRITE;
/*!40000 ALTER TABLE `boletosdisponibles` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletosdisponibles` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletosvendidos`
--

LOCK TABLES `boletosvendidos` WRITE;
/*!40000 ALTER TABLE `boletosvendidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletosvendidos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `boletosvendidos_descuentos`
--

LOCK TABLES `boletosvendidos_descuentos` WRITE;
/*!40000 ALTER TABLE `boletosvendidos_descuentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletosvendidos_descuentos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `boletosvendidos_factorpaqueteria`
--

LOCK TABLES `boletosvendidos_factorpaqueteria` WRITE;
/*!40000 ALTER TABLE `boletosvendidos_factorpaqueteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletosvendidos_factorpaqueteria` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `boletosvendidos_promociones`
--

LOCK TABLES `boletosvendidos_promociones` WRITE;
/*!40000 ALTER TABLE `boletosvendidos_promociones` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletosvendidos_promociones` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `boletosvendidos_tipopaquetes`
--

LOCK TABLES `boletosvendidos_tipopaquetes` WRITE;
/*!40000 ALTER TABLE `boletosvendidos_tipopaquetes` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletosvendidos_tipopaquetes` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `conductores`
--

LOCK TABLES `conductores` WRITE;
/*!40000 ALTER TABLE `conductores` DISABLE KEYS */;
INSERT INTO `conductores` VALUES (1,2,'LIC007','2025-10-11','AC',74,'2023-01-31 10:50:50',NULL,NULL),(2,3,'LIC084','2028-03-08','AC',102,'2023-01-31 10:50:50',NULL,NULL),(3,4,'LIC026','2025-07-26','BA',112,'2023-01-31 10:50:50',NULL,NULL);
/*!40000 ALTER TABLE `conductores` ENABLE KEYS */;
UNLOCK TABLES;

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
  `nConductor` int(10) unsigned DEFAULT NULL,
  `user` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `nConsecutivo` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `corrida_disponible` (`corrida_disponible`),
  KEY `aEstadoAnterior` (`aEstadoAnterior`),
  KEY `aEstadoNuevo` (`aEstadoNuevo`),
  KEY `nConductor` (`nConductor`),
  KEY `user` (`user`),
  KEY `nNumeroOficina` (`nNumeroOficina`),
  CONSTRAINT `corridas_disponibles_historial_ibfk_1` FOREIGN KEY (`corrida_disponible`) REFERENCES `corridasdisponibles` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_2` FOREIGN KEY (`aEstadoAnterior`) REFERENCES `corridas_estados` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_3` FOREIGN KEY (`aEstadoNuevo`) REFERENCES `corridas_estados` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_5` FOREIGN KEY (`nConductor`) REFERENCES `conductores` (`nNumeroConductor`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_6` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_7` FOREIGN KEY (`nNumeroOficina`) REFERENCES `oficinas` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridas_disponibles_historial`
--

LOCK TABLES `corridas_disponibles_historial` WRITE;
/*!40000 ALTER TABLE `corridas_disponibles_historial` DISABLE KEYS */;
/*!40000 ALTER TABLE `corridas_disponibles_historial` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `corridas_estados`
--

LOCK TABLES `corridas_estados` WRITE;
/*!40000 ALTER TABLE `corridas_estados` DISABLE KEYS */;
INSERT INTO `corridas_estados` VALUES ('A','Asignada',2,0),('B','Bloqueada',99,1),('C','Cancelada',99,1),('D','Disponible',1,0),('L','Liquidada',6,0),('R','En ruta',4,0),('S','Lista para salir',3,1),('T','Terminada',5,0);
/*!40000 ALTER TABLE `corridas_estados` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `corridas_versiones_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridas_versiones`
--

LOCK TABLES `corridas_versiones` WRITE;
/*!40000 ALTER TABLE `corridas_versiones` DISABLE KEYS */;
/*!40000 ALTER TABLE `corridas_versiones` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=578 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasdisponibles`
--

LOCK TABLES `corridasdisponibles` WRITE;
/*!40000 ALTER TABLE `corridasdisponibles` DISABLE KEYS */;
INSERT INTO `corridasdisponibles` VALUES (319,16,7,1,'2023-01-31','13:00:00','D',122,NULL,NULL,NULL,NULL),(320,16,7,1,'2023-02-01','13:00:00','D',122,NULL,NULL,NULL,NULL),(321,16,7,1,'2023-02-03','13:00:00','D',122,NULL,NULL,NULL,NULL),(322,16,7,1,'2023-02-04','13:00:00','D',122,NULL,NULL,NULL,NULL),(323,16,7,1,'2023-02-05','13:00:00','D',122,NULL,NULL,NULL,NULL),(324,16,7,1,'2023-02-06','13:00:00','D',122,NULL,NULL,NULL,NULL),(325,16,7,1,'2023-02-07','13:00:00','D',122,NULL,NULL,NULL,NULL),(326,16,7,1,'2023-02-08','13:00:00','D',122,NULL,NULL,NULL,NULL),(327,16,7,1,'2023-02-10','13:00:00','D',122,NULL,NULL,NULL,NULL),(328,16,7,1,'2023-02-11','13:00:00','D',122,NULL,NULL,NULL,NULL),(329,16,7,1,'2023-02-12','13:00:00','D',122,NULL,NULL,NULL,NULL),(330,16,7,1,'2023-02-13','13:00:00','D',122,NULL,NULL,NULL,NULL),(331,16,7,1,'2023-02-14','13:00:00','D',122,NULL,NULL,NULL,NULL),(332,16,7,1,'2023-02-15','13:00:00','D',122,NULL,NULL,NULL,NULL),(333,16,7,1,'2023-02-17','13:00:00','D',122,NULL,NULL,NULL,NULL),(334,16,7,1,'2023-02-18','13:00:00','D',122,NULL,NULL,NULL,NULL),(335,16,7,1,'2023-02-19','13:00:00','D',122,NULL,NULL,NULL,NULL),(336,16,7,1,'2023-02-20','13:00:00','D',122,NULL,NULL,NULL,NULL),(337,16,7,1,'2023-02-21','13:00:00','D',122,NULL,NULL,NULL,NULL),(338,16,7,1,'2023-02-22','13:00:00','D',122,NULL,NULL,NULL,NULL),(339,16,7,1,'2023-02-24','13:00:00','D',122,NULL,NULL,NULL,NULL),(340,16,7,1,'2023-02-25','13:00:00','D',122,NULL,NULL,NULL,NULL),(341,16,7,1,'2023-02-26','13:00:00','D',122,NULL,NULL,NULL,NULL),(342,16,7,1,'2023-02-27','13:00:00','D',122,NULL,NULL,NULL,NULL),(343,16,7,1,'2023-02-28','13:00:00','D',122,NULL,NULL,NULL,NULL),(344,16,7,1,'2023-03-01','13:00:00','D',122,NULL,NULL,NULL,NULL),(345,17,8,1,'2023-02-01','07:07:00','D',122,NULL,NULL,NULL,NULL),(346,17,8,1,'2023-02-03','07:07:00','D',122,NULL,NULL,NULL,NULL),(347,17,8,1,'2023-02-04','07:07:00','D',122,NULL,NULL,NULL,NULL),(348,17,8,1,'2023-02-05','07:07:00','D',122,NULL,NULL,NULL,NULL),(349,17,8,1,'2023-02-06','07:07:00','D',122,NULL,NULL,NULL,NULL),(350,17,8,1,'2023-02-07','07:07:00','D',122,NULL,NULL,NULL,NULL),(351,17,8,1,'2023-02-08','07:07:00','D',122,NULL,NULL,NULL,NULL),(352,17,8,1,'2023-02-10','07:07:00','D',122,NULL,NULL,NULL,NULL),(353,17,8,1,'2023-02-11','07:07:00','D',122,NULL,NULL,NULL,NULL),(354,17,8,1,'2023-02-12','07:07:00','D',122,NULL,NULL,NULL,NULL),(355,17,8,1,'2023-02-13','07:07:00','D',122,NULL,NULL,NULL,NULL),(356,17,8,1,'2023-02-14','07:07:00','D',122,NULL,NULL,NULL,NULL),(357,17,8,1,'2023-02-15','07:07:00','D',122,NULL,NULL,NULL,NULL),(358,17,8,1,'2023-02-17','07:07:00','D',122,NULL,NULL,NULL,NULL),(359,17,8,1,'2023-02-18','07:07:00','D',122,NULL,NULL,NULL,NULL),(360,17,8,1,'2023-02-19','07:07:00','D',122,NULL,NULL,NULL,NULL),(361,17,8,1,'2023-02-20','07:07:00','D',122,NULL,NULL,NULL,NULL),(362,17,8,1,'2023-02-21','07:07:00','D',122,NULL,NULL,NULL,NULL),(363,17,8,1,'2023-02-22','07:07:00','D',122,NULL,NULL,NULL,NULL),(364,17,8,1,'2023-02-24','07:07:00','D',122,NULL,NULL,NULL,NULL),(365,17,8,1,'2023-02-25','07:07:00','D',122,NULL,NULL,NULL,NULL),(366,17,8,1,'2023-02-26','07:07:00','D',122,NULL,NULL,NULL,NULL),(367,17,8,1,'2023-02-27','07:07:00','D',122,NULL,NULL,NULL,NULL),(368,17,8,1,'2023-02-28','07:07:00','D',122,NULL,NULL,NULL,NULL),(369,17,8,1,'2023-03-01','07:07:00','D',122,NULL,NULL,NULL,NULL),(370,18,7,1,'2023-01-31','15:00:00','D',122,NULL,NULL,NULL,NULL),(371,18,7,1,'2023-02-01','15:00:00','D',122,NULL,NULL,NULL,NULL),(372,18,7,1,'2023-02-03','15:00:00','D',122,NULL,NULL,NULL,NULL),(373,18,7,1,'2023-02-04','15:00:00','D',122,NULL,NULL,NULL,NULL),(374,18,7,1,'2023-02-05','15:00:00','D',122,NULL,NULL,NULL,NULL),(375,18,7,1,'2023-02-06','15:00:00','D',122,NULL,NULL,NULL,NULL),(376,18,7,1,'2023-02-07','15:00:00','D',122,NULL,NULL,NULL,NULL),(377,18,7,1,'2023-02-08','15:00:00','D',122,NULL,NULL,NULL,NULL),(378,18,7,1,'2023-02-10','15:00:00','D',122,NULL,NULL,NULL,NULL),(379,18,7,1,'2023-02-11','15:00:00','D',122,NULL,NULL,NULL,NULL),(380,18,7,1,'2023-02-12','15:00:00','D',122,NULL,NULL,NULL,NULL),(381,18,7,1,'2023-02-13','15:00:00','D',122,NULL,NULL,NULL,NULL),(382,18,7,1,'2023-02-14','15:00:00','D',122,NULL,NULL,NULL,NULL),(383,18,7,1,'2023-02-15','15:00:00','D',122,NULL,NULL,NULL,NULL),(384,18,7,1,'2023-02-17','15:00:00','D',122,NULL,NULL,NULL,NULL),(385,18,7,1,'2023-02-18','15:00:00','D',122,NULL,NULL,NULL,NULL),(386,18,7,1,'2023-02-19','15:00:00','D',122,NULL,NULL,NULL,NULL),(387,18,7,1,'2023-02-20','15:00:00','D',122,NULL,NULL,NULL,NULL),(388,18,7,1,'2023-02-21','15:00:00','D',122,NULL,NULL,NULL,NULL),(389,18,7,1,'2023-02-22','15:00:00','D',122,NULL,NULL,NULL,NULL),(390,18,7,1,'2023-02-24','15:00:00','D',122,NULL,NULL,NULL,NULL),(391,18,7,1,'2023-02-25','15:00:00','D',122,NULL,NULL,NULL,NULL),(392,18,7,1,'2023-02-26','15:00:00','D',122,NULL,NULL,NULL,NULL),(393,18,7,1,'2023-02-27','15:00:00','D',122,NULL,NULL,NULL,NULL),(394,18,7,1,'2023-02-28','15:00:00','D',122,NULL,NULL,NULL,NULL),(395,18,7,1,'2023-03-01','15:00:00','D',122,NULL,NULL,NULL,NULL),(396,19,8,1,'2023-01-31','02:00:00','D',122,NULL,NULL,NULL,NULL),(397,19,8,1,'2023-02-01','02:00:00','D',122,NULL,NULL,NULL,NULL),(398,19,8,1,'2023-02-03','02:00:00','D',122,NULL,NULL,NULL,NULL),(399,19,8,1,'2023-02-04','02:00:00','D',122,NULL,NULL,NULL,NULL),(400,19,8,1,'2023-02-05','02:00:00','D',122,NULL,NULL,NULL,NULL),(401,19,8,1,'2023-02-06','02:00:00','D',122,NULL,NULL,NULL,NULL),(402,19,8,1,'2023-02-07','02:00:00','D',122,NULL,NULL,NULL,NULL),(403,19,8,1,'2023-02-08','02:00:00','D',122,NULL,NULL,NULL,NULL),(404,19,8,1,'2023-02-10','02:00:00','D',122,NULL,NULL,NULL,NULL),(405,19,8,1,'2023-02-11','02:00:00','D',122,NULL,NULL,NULL,NULL),(406,19,8,1,'2023-02-12','02:00:00','D',122,NULL,NULL,NULL,NULL),(407,19,8,1,'2023-02-13','02:00:00','D',122,NULL,NULL,NULL,NULL),(408,19,8,1,'2023-02-14','02:00:00','D',122,NULL,NULL,NULL,NULL),(409,19,8,1,'2023-02-15','02:00:00','D',122,NULL,NULL,NULL,NULL),(410,19,8,1,'2023-02-17','02:00:00','D',122,NULL,NULL,NULL,NULL),(411,19,8,1,'2023-02-18','02:00:00','D',122,NULL,NULL,NULL,NULL),(412,19,8,1,'2023-02-19','02:00:00','D',122,NULL,NULL,NULL,NULL),(413,19,8,1,'2023-02-20','02:00:00','D',122,NULL,NULL,NULL,NULL),(414,19,8,1,'2023-02-21','02:00:00','D',122,NULL,NULL,NULL,NULL),(415,19,8,1,'2023-02-22','02:00:00','D',122,NULL,NULL,NULL,NULL),(416,19,8,1,'2023-02-24','02:00:00','D',122,NULL,NULL,NULL,NULL),(417,19,8,1,'2023-02-25','02:00:00','D',122,NULL,NULL,NULL,NULL),(418,19,8,1,'2023-02-26','02:00:00','D',122,NULL,NULL,NULL,NULL),(419,19,8,1,'2023-02-27','02:00:00','D',122,NULL,NULL,NULL,NULL),(420,19,8,1,'2023-02-28','02:00:00','D',122,NULL,NULL,NULL,NULL),(421,19,8,1,'2023-03-01','02:00:00','D',122,NULL,NULL,NULL,NULL),(422,20,9,1,'2023-01-31','11:00:00','C',122,NULL,NULL,NULL,NULL),(423,20,9,1,'2023-02-01','11:00:00','C',122,NULL,NULL,NULL,NULL),(424,20,9,1,'2023-02-03','11:00:00','C',122,NULL,NULL,NULL,NULL),(425,20,9,1,'2023-02-04','11:00:00','C',122,NULL,NULL,NULL,NULL),(426,20,9,1,'2023-02-05','11:00:00','C',122,NULL,NULL,NULL,NULL),(427,20,9,1,'2023-02-06','11:00:00','C',122,NULL,NULL,NULL,NULL),(428,20,9,1,'2023-02-07','11:00:00','C',122,NULL,NULL,NULL,NULL),(429,20,9,1,'2023-02-08','11:00:00','C',122,NULL,NULL,NULL,NULL),(430,20,9,1,'2023-02-10','11:00:00','C',122,NULL,NULL,NULL,NULL),(431,20,9,1,'2023-02-11','11:00:00','C',122,NULL,NULL,NULL,NULL),(432,20,9,1,'2023-02-12','11:00:00','C',122,NULL,NULL,NULL,NULL),(433,20,9,1,'2023-02-13','11:00:00','C',122,NULL,NULL,NULL,NULL),(434,20,9,1,'2023-02-14','11:00:00','C',122,NULL,NULL,NULL,NULL),(435,20,9,1,'2023-02-15','11:00:00','C',122,NULL,NULL,NULL,NULL),(436,20,9,1,'2023-02-17','11:00:00','C',122,NULL,NULL,NULL,NULL),(437,20,9,1,'2023-02-18','11:00:00','C',122,NULL,NULL,NULL,NULL),(438,20,9,1,'2023-02-19','11:00:00','C',122,NULL,NULL,NULL,NULL),(439,20,9,1,'2023-02-20','11:00:00','C',122,NULL,NULL,NULL,NULL),(440,20,9,1,'2023-02-21','11:00:00','C',122,NULL,NULL,NULL,NULL),(441,20,9,1,'2023-02-22','11:00:00','C',122,NULL,NULL,NULL,NULL),(442,20,9,1,'2023-02-24','11:00:00','C',122,NULL,NULL,NULL,NULL),(443,20,9,1,'2023-02-25','11:00:00','C',122,NULL,NULL,NULL,NULL),(444,20,9,1,'2023-02-26','11:00:00','C',122,NULL,NULL,NULL,NULL),(445,20,9,1,'2023-02-27','11:00:00','C',122,NULL,NULL,NULL,NULL),(446,20,9,1,'2023-02-28','11:00:00','C',122,NULL,NULL,NULL,NULL),(447,20,9,1,'2023-03-01','11:00:00','C',122,NULL,NULL,NULL,NULL),(448,21,9,1,'2023-01-31','11:00:00','C',122,NULL,NULL,NULL,NULL),(449,21,9,1,'2023-02-01','11:00:00','C',122,NULL,NULL,NULL,NULL),(450,21,9,1,'2023-02-03','11:00:00','C',122,NULL,NULL,NULL,NULL),(451,21,9,1,'2023-02-04','11:00:00','C',122,NULL,NULL,NULL,NULL),(452,21,9,1,'2023-02-05','11:00:00','C',122,NULL,NULL,NULL,NULL),(453,21,9,1,'2023-02-06','11:00:00','C',122,NULL,NULL,NULL,NULL),(454,21,9,1,'2023-02-07','11:00:00','C',122,NULL,NULL,NULL,NULL),(455,21,9,1,'2023-02-08','11:00:00','C',122,NULL,NULL,NULL,NULL),(456,21,9,1,'2023-02-10','11:00:00','C',122,NULL,NULL,NULL,NULL),(457,21,9,1,'2023-02-11','11:00:00','C',122,NULL,NULL,NULL,NULL),(458,21,9,1,'2023-02-12','11:00:00','C',122,NULL,NULL,NULL,NULL),(459,21,9,1,'2023-02-13','11:00:00','C',122,NULL,NULL,NULL,NULL),(460,21,9,1,'2023-02-14','11:00:00','C',122,NULL,NULL,NULL,NULL),(461,21,9,1,'2023-02-15','11:00:00','C',122,NULL,NULL,NULL,NULL),(462,21,9,1,'2023-02-17','11:00:00','C',122,NULL,NULL,NULL,NULL),(463,21,9,1,'2023-02-18','11:00:00','C',122,NULL,NULL,NULL,NULL),(464,21,9,1,'2023-02-19','11:00:00','C',122,NULL,NULL,NULL,NULL),(465,21,9,1,'2023-02-20','11:00:00','C',122,NULL,NULL,NULL,NULL),(466,21,9,1,'2023-02-21','11:00:00','C',122,NULL,NULL,NULL,NULL),(467,21,9,1,'2023-02-22','11:00:00','C',122,NULL,NULL,NULL,NULL),(468,21,9,1,'2023-02-24','11:00:00','C',122,NULL,NULL,NULL,NULL),(469,21,9,1,'2023-02-25','11:00:00','C',122,NULL,NULL,NULL,NULL),(470,21,9,1,'2023-02-26','11:00:00','C',122,NULL,NULL,NULL,NULL),(471,21,9,1,'2023-02-27','11:00:00','C',122,NULL,NULL,NULL,NULL),(472,21,9,1,'2023-02-28','11:00:00','C',122,NULL,NULL,NULL,NULL),(473,21,9,1,'2023-03-01','11:00:00','C',122,NULL,NULL,NULL,NULL),(474,22,9,1,'2023-01-31','11:00:00','D',122,NULL,NULL,NULL,NULL),(475,22,9,1,'2023-02-01','11:00:00','D',122,NULL,NULL,NULL,NULL),(476,22,9,1,'2023-02-03','11:00:00','D',122,NULL,NULL,NULL,NULL),(477,22,9,1,'2023-02-04','11:00:00','D',122,NULL,NULL,NULL,NULL),(478,22,9,1,'2023-02-05','11:00:00','D',122,NULL,NULL,NULL,NULL),(479,22,9,1,'2023-02-06','11:00:00','D',122,NULL,NULL,NULL,NULL),(480,22,9,1,'2023-02-07','11:00:00','D',122,NULL,NULL,NULL,NULL),(481,22,9,1,'2023-02-08','11:00:00','D',122,NULL,NULL,NULL,NULL),(482,22,9,1,'2023-02-10','11:00:00','D',122,NULL,NULL,NULL,NULL),(483,22,9,1,'2023-02-11','11:00:00','D',122,NULL,NULL,NULL,NULL),(484,22,9,1,'2023-02-12','11:00:00','D',122,NULL,NULL,NULL,NULL),(485,22,9,1,'2023-02-13','11:00:00','D',122,NULL,NULL,NULL,NULL),(486,22,9,1,'2023-02-14','11:00:00','D',122,NULL,NULL,NULL,NULL),(487,22,9,1,'2023-02-15','11:00:00','D',122,NULL,NULL,NULL,NULL),(488,22,9,1,'2023-02-17','11:00:00','D',122,NULL,NULL,NULL,NULL),(489,22,9,1,'2023-02-18','11:00:00','D',122,NULL,NULL,NULL,NULL),(490,22,9,1,'2023-02-19','11:00:00','D',122,NULL,NULL,NULL,NULL),(491,22,9,1,'2023-02-20','11:00:00','D',122,NULL,NULL,NULL,NULL),(492,22,9,1,'2023-02-21','11:00:00','D',122,NULL,NULL,NULL,NULL),(493,22,9,1,'2023-02-22','11:00:00','D',122,NULL,NULL,NULL,NULL),(494,22,9,1,'2023-02-24','11:00:00','D',122,NULL,NULL,NULL,NULL),(495,22,9,1,'2023-02-25','11:00:00','D',122,NULL,NULL,NULL,NULL),(496,22,9,1,'2023-02-26','11:00:00','D',122,NULL,NULL,NULL,NULL),(497,22,9,1,'2023-02-27','11:00:00','D',122,NULL,NULL,NULL,NULL),(498,22,9,1,'2023-02-28','11:00:00','D',122,NULL,NULL,NULL,NULL),(499,22,9,1,'2023-03-01','11:00:00','D',122,NULL,NULL,NULL,NULL),(500,23,10,1,'2023-01-31','17:00:00','D',122,NULL,NULL,NULL,NULL),(501,23,10,1,'2023-02-01','17:00:00','D',122,NULL,NULL,NULL,NULL),(502,23,10,1,'2023-02-03','17:00:00','D',122,NULL,NULL,NULL,NULL),(503,23,10,1,'2023-02-04','17:00:00','D',122,NULL,NULL,NULL,NULL),(504,23,10,1,'2023-02-05','17:00:00','D',122,NULL,NULL,NULL,NULL),(505,23,10,1,'2023-02-06','17:00:00','D',122,NULL,NULL,NULL,NULL),(506,23,10,1,'2023-02-07','17:00:00','D',122,NULL,NULL,NULL,NULL),(507,23,10,1,'2023-02-08','17:00:00','D',122,NULL,NULL,NULL,NULL),(508,23,10,1,'2023-02-10','17:00:00','D',122,NULL,NULL,NULL,NULL),(509,23,10,1,'2023-02-11','17:00:00','D',122,NULL,NULL,NULL,NULL),(510,23,10,1,'2023-02-12','17:00:00','D',122,NULL,NULL,NULL,NULL),(511,23,10,1,'2023-02-13','17:00:00','D',122,NULL,NULL,NULL,NULL),(512,23,10,1,'2023-02-14','17:00:00','D',122,NULL,NULL,NULL,NULL),(513,23,10,1,'2023-02-15','17:00:00','D',122,NULL,NULL,NULL,NULL),(514,23,10,1,'2023-02-17','17:00:00','D',122,NULL,NULL,NULL,NULL),(515,23,10,1,'2023-02-18','17:00:00','D',122,NULL,NULL,NULL,NULL),(516,23,10,1,'2023-02-19','17:00:00','D',122,NULL,NULL,NULL,NULL),(517,23,10,1,'2023-02-20','17:00:00','D',122,NULL,NULL,NULL,NULL),(518,23,10,1,'2023-02-21','17:00:00','D',122,NULL,NULL,NULL,NULL),(519,23,10,1,'2023-02-22','17:00:00','D',122,NULL,NULL,NULL,NULL),(520,23,10,1,'2023-02-24','17:00:00','D',122,NULL,NULL,NULL,NULL),(521,23,10,1,'2023-02-25','17:00:00','D',122,NULL,NULL,NULL,NULL),(522,23,10,1,'2023-02-26','17:00:00','D',122,NULL,NULL,NULL,NULL),(523,23,10,1,'2023-02-27','17:00:00','D',122,NULL,NULL,NULL,NULL),(524,23,10,1,'2023-02-28','17:00:00','D',122,NULL,NULL,NULL,NULL),(525,23,10,1,'2023-03-01','17:00:00','D',122,NULL,NULL,NULL,NULL),(526,24,11,1,'2023-01-31','10:00:00','C',122,NULL,NULL,NULL,NULL),(527,24,11,1,'2023-02-01','10:00:00','C',122,NULL,NULL,NULL,NULL),(528,24,11,1,'2023-02-03','10:00:00','C',122,NULL,NULL,NULL,NULL),(529,24,11,1,'2023-02-04','10:00:00','C',122,NULL,NULL,NULL,NULL),(530,24,11,1,'2023-02-05','10:00:00','C',122,NULL,NULL,NULL,NULL),(531,24,11,1,'2023-02-06','10:00:00','C',122,NULL,NULL,NULL,NULL),(532,24,11,1,'2023-02-07','10:00:00','C',122,NULL,NULL,NULL,NULL),(533,24,11,1,'2023-02-08','10:00:00','C',122,NULL,NULL,NULL,NULL),(534,24,11,1,'2023-02-10','10:00:00','C',122,NULL,NULL,NULL,NULL),(535,24,11,1,'2023-02-11','10:00:00','C',122,NULL,NULL,NULL,NULL),(536,24,11,1,'2023-02-12','10:00:00','C',122,NULL,NULL,NULL,NULL),(537,24,11,1,'2023-02-13','10:00:00','C',122,NULL,NULL,NULL,NULL),(538,24,11,1,'2023-02-14','10:00:00','C',122,NULL,NULL,NULL,NULL),(539,24,11,1,'2023-02-15','10:00:00','C',122,NULL,NULL,NULL,NULL),(540,24,11,1,'2023-02-17','10:00:00','C',122,NULL,NULL,NULL,NULL),(541,24,11,1,'2023-02-18','10:00:00','C',122,NULL,NULL,NULL,NULL),(542,24,11,1,'2023-02-19','10:00:00','C',122,NULL,NULL,NULL,NULL),(543,24,11,1,'2023-02-20','10:00:00','C',122,NULL,NULL,NULL,NULL),(544,24,11,1,'2023-02-21','10:00:00','C',122,NULL,NULL,NULL,NULL),(545,24,11,1,'2023-02-22','10:00:00','C',122,NULL,NULL,NULL,NULL),(546,24,11,1,'2023-02-24','10:00:00','C',122,NULL,NULL,NULL,NULL),(547,24,11,1,'2023-02-25','10:00:00','C',122,NULL,NULL,NULL,NULL),(548,24,11,1,'2023-02-26','10:00:00','C',122,NULL,NULL,NULL,NULL),(549,24,11,1,'2023-02-27','10:00:00','C',122,NULL,NULL,NULL,NULL),(550,24,11,1,'2023-02-28','10:00:00','C',122,NULL,NULL,NULL,NULL),(551,24,11,1,'2023-03-01','10:00:00','C',122,NULL,NULL,NULL,NULL),(552,25,11,1,'2023-01-31','10:00:00','D',122,NULL,NULL,NULL,NULL),(553,25,11,1,'2023-02-01','10:00:00','D',122,NULL,NULL,NULL,NULL),(554,25,11,1,'2023-02-03','10:00:00','D',122,NULL,NULL,NULL,NULL),(555,25,11,1,'2023-02-04','10:00:00','D',122,NULL,NULL,NULL,NULL),(556,25,11,1,'2023-02-05','10:00:00','D',122,NULL,NULL,NULL,NULL),(557,25,11,1,'2023-02-06','10:00:00','D',122,NULL,NULL,NULL,NULL),(558,25,11,1,'2023-02-07','10:00:00','D',122,NULL,NULL,NULL,NULL),(559,25,11,1,'2023-02-08','10:00:00','D',122,NULL,NULL,NULL,NULL),(560,25,11,1,'2023-02-10','10:00:00','D',122,NULL,NULL,NULL,NULL),(561,25,11,1,'2023-02-11','10:00:00','D',122,NULL,NULL,NULL,NULL),(562,25,11,1,'2023-02-12','10:00:00','D',122,NULL,NULL,NULL,NULL),(563,25,11,1,'2023-02-13','10:00:00','D',122,NULL,NULL,NULL,NULL),(564,25,11,1,'2023-02-14','10:00:00','D',122,NULL,NULL,NULL,NULL),(565,25,11,1,'2023-02-15','10:00:00','D',122,NULL,NULL,NULL,NULL),(566,25,11,1,'2023-02-17','10:00:00','D',122,NULL,NULL,NULL,NULL),(567,25,11,1,'2023-02-18','10:00:00','D',122,NULL,NULL,NULL,NULL),(568,25,11,1,'2023-02-19','10:00:00','D',122,NULL,NULL,NULL,NULL),(569,25,11,1,'2023-02-20','10:00:00','D',122,NULL,NULL,NULL,NULL),(570,25,11,1,'2023-02-21','10:00:00','D',122,NULL,NULL,NULL,NULL),(571,25,11,1,'2023-02-22','10:00:00','D',122,NULL,NULL,NULL,NULL),(572,25,11,1,'2023-02-24','10:00:00','D',122,NULL,NULL,NULL,NULL),(573,25,11,1,'2023-02-25','10:00:00','D',122,NULL,NULL,NULL,NULL),(574,25,11,1,'2023-02-26','10:00:00','D',122,NULL,NULL,NULL,NULL),(575,25,11,1,'2023-02-27','10:00:00','D',122,NULL,NULL,NULL,NULL),(576,25,11,1,'2023-02-28','10:00:00','D',122,NULL,NULL,NULL,NULL),(577,25,11,1,'2023-03-01','10:00:00','D',122,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `corridasdisponibles` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasprogramadas`
--

LOCK TABLES `corridasprogramadas` WRITE;
/*!40000 ALTER TABLE `corridasprogramadas` DISABLE KEYS */;
INSERT INTO `corridasprogramadas` VALUES (11,1,1,'10:00:00',1,1,1,1,1,0,0,'2022-01-01','2023-06-30',1,'2023-01-31 16:54:59','2023-01-31 22:54:59',NULL),(12,1,1,'10:01:00',1,1,1,1,1,0,0,'2022-03-01','2023-06-30',1,'2022-10-10 12:00:00','2023-01-31 16:50:50',NULL),(13,1,1,'10:30:00',0,0,0,0,0,1,1,'2022-01-01','2022-06-30',1,'2023-01-31 16:55:03','2023-01-31 22:55:03',NULL),(14,3,3,'12:00:00',1,1,1,1,1,1,1,'2022-03-01','2022-12-31',1,'2023-01-31 16:55:06','2023-01-31 22:55:06',NULL),(15,3,3,'23:30:00',1,0,0,1,1,1,1,'2022-03-01','2022-12-31',1,'2023-01-31 16:55:09','2023-01-31 22:55:09',NULL),(16,7,1,'13:00:00',1,1,1,0,1,1,1,'2023-01-31','2099-01-31',1,NULL,'2023-01-31 23:06:57','2023-01-31 17:06:57'),(17,8,1,'07:07:00',1,1,1,0,1,1,1,'2023-02-01','2099-01-31',1,NULL,'2023-01-31 23:15:43','2023-01-31 17:15:43'),(18,7,1,'15:00:00',1,1,1,0,1,1,1,'2023-01-31','2099-01-31',1,NULL,'2023-01-31 23:17:29','2023-01-31 17:17:29'),(19,8,1,'02:00:00',1,1,1,0,1,1,1,'2023-01-31','2099-01-31',1,NULL,'2023-01-31 23:18:22','2023-01-31 17:18:22'),(20,9,1,'11:00:00',1,1,1,0,1,1,1,'2023-01-31','2099-01-31',1,'2023-01-31 17:28:11','2023-01-31 23:28:11','2023-01-31 17:19:35'),(21,9,1,'11:00:00',1,1,1,0,1,1,1,'2023-01-31','2099-01-31',1,'2023-01-31 17:34:25','2023-01-31 23:34:25','2023-01-31 17:29:32'),(22,9,1,'11:00:00',1,1,1,0,1,1,1,'2023-01-31','2099-01-31',1,NULL,'2023-01-31 23:35:08','2023-01-31 17:35:08'),(23,10,1,'17:00:00',1,1,1,0,1,1,1,'2023-01-31','2099-01-31',1,NULL,'2023-01-31 23:42:30','2023-01-31 17:42:30'),(24,11,1,'10:00:00',1,1,1,0,1,1,1,'2023-01-31','2099-01-31',1,'2023-01-31 17:53:27','2023-01-31 23:53:27','2023-01-31 17:52:50'),(25,11,1,'10:00:00',1,1,1,0,1,1,1,'2023-01-31','2099-01-31',1,NULL,'2023-02-01 00:10:05','2023-01-31 18:10:05');
/*!40000 ALTER TABLE `corridasprogramadas` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `descuentos`
--

LOCK TABLES `descuentos` WRITE;
/*!40000 ALTER TABLE `descuentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `descuentos` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2537 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidad`
--

LOCK TABLES `disponibilidad` WRITE;
/*!40000 ALTER TABLE `disponibilidad` DISABLE KEYS */;
INSERT INTO `disponibilidad` VALUES (2018,319,8,7,'2023-01-31','17:15:00','2023-01-31','13:00:00'),(2019,320,8,7,'2023-02-01','17:15:00','2023-02-01','13:00:00'),(2020,321,8,7,'2023-02-03','17:15:00','2023-02-03','13:00:00'),(2021,322,8,7,'2023-02-04','17:15:00','2023-02-04','13:00:00'),(2022,323,8,7,'2023-02-05','17:15:00','2023-02-05','13:00:00'),(2023,324,8,7,'2023-02-06','17:15:00','2023-02-06','13:00:00'),(2024,325,8,7,'2023-02-07','17:15:00','2023-02-07','13:00:00'),(2025,326,8,7,'2023-02-08','17:15:00','2023-02-08','13:00:00'),(2026,327,8,7,'2023-02-10','17:15:00','2023-02-10','13:00:00'),(2027,328,8,7,'2023-02-11','17:15:00','2023-02-11','13:00:00'),(2028,329,8,7,'2023-02-12','17:15:00','2023-02-12','13:00:00'),(2029,330,8,7,'2023-02-13','17:15:00','2023-02-13','13:00:00'),(2030,331,8,7,'2023-02-14','17:15:00','2023-02-14','13:00:00'),(2031,332,8,7,'2023-02-15','17:15:00','2023-02-15','13:00:00'),(2032,333,8,7,'2023-02-17','17:15:00','2023-02-17','13:00:00'),(2033,334,8,7,'2023-02-18','17:15:00','2023-02-18','13:00:00'),(2034,335,8,7,'2023-02-19','17:15:00','2023-02-19','13:00:00'),(2035,336,8,7,'2023-02-20','17:15:00','2023-02-20','13:00:00'),(2036,337,8,7,'2023-02-21','17:15:00','2023-02-21','13:00:00'),(2037,338,8,7,'2023-02-22','17:15:00','2023-02-22','13:00:00'),(2038,339,8,7,'2023-02-24','17:15:00','2023-02-24','13:00:00'),(2039,340,8,7,'2023-02-25','17:15:00','2023-02-25','13:00:00'),(2040,341,8,7,'2023-02-26','17:15:00','2023-02-26','13:00:00'),(2041,342,8,7,'2023-02-27','17:15:00','2023-02-27','13:00:00'),(2042,343,8,7,'2023-02-28','17:15:00','2023-02-28','13:00:00'),(2043,344,8,7,'2023-03-01','17:15:00','2023-03-01','13:00:00'),(2044,345,7,8,'2023-02-01','11:22:00','2023-02-01','07:07:00'),(2045,346,7,8,'2023-02-03','11:22:00','2023-02-03','07:07:00'),(2046,347,7,8,'2023-02-04','11:22:00','2023-02-04','07:07:00'),(2047,348,7,8,'2023-02-05','11:22:00','2023-02-05','07:07:00'),(2048,349,7,8,'2023-02-06','11:22:00','2023-02-06','07:07:00'),(2049,350,7,8,'2023-02-07','11:22:00','2023-02-07','07:07:00'),(2050,351,7,8,'2023-02-08','11:22:00','2023-02-08','07:07:00'),(2051,352,7,8,'2023-02-10','11:22:00','2023-02-10','07:07:00'),(2052,353,7,8,'2023-02-11','11:22:00','2023-02-11','07:07:00'),(2053,354,7,8,'2023-02-12','11:22:00','2023-02-12','07:07:00'),(2054,355,7,8,'2023-02-13','11:22:00','2023-02-13','07:07:00'),(2055,356,7,8,'2023-02-14','11:22:00','2023-02-14','07:07:00'),(2056,357,7,8,'2023-02-15','11:22:00','2023-02-15','07:07:00'),(2057,358,7,8,'2023-02-17','11:22:00','2023-02-17','07:07:00'),(2058,359,7,8,'2023-02-18','11:22:00','2023-02-18','07:07:00'),(2059,360,7,8,'2023-02-19','11:22:00','2023-02-19','07:07:00'),(2060,361,7,8,'2023-02-20','11:22:00','2023-02-20','07:07:00'),(2061,362,7,8,'2023-02-21','11:22:00','2023-02-21','07:07:00'),(2062,363,7,8,'2023-02-22','11:22:00','2023-02-22','07:07:00'),(2063,364,7,8,'2023-02-24','11:22:00','2023-02-24','07:07:00'),(2064,365,7,8,'2023-02-25','11:22:00','2023-02-25','07:07:00'),(2065,366,7,8,'2023-02-26','11:22:00','2023-02-26','07:07:00'),(2066,367,7,8,'2023-02-27','11:22:00','2023-02-27','07:07:00'),(2067,368,7,8,'2023-02-28','11:22:00','2023-02-28','07:07:00'),(2068,369,7,8,'2023-03-01','11:22:00','2023-03-01','07:07:00'),(2069,370,8,7,'2023-01-31','19:15:00','2023-01-31','15:00:00'),(2070,371,8,7,'2023-02-01','19:15:00','2023-02-01','15:00:00'),(2071,372,8,7,'2023-02-03','19:15:00','2023-02-03','15:00:00'),(2072,373,8,7,'2023-02-04','19:15:00','2023-02-04','15:00:00'),(2073,374,8,7,'2023-02-05','19:15:00','2023-02-05','15:00:00'),(2074,375,8,7,'2023-02-06','19:15:00','2023-02-06','15:00:00'),(2075,376,8,7,'2023-02-07','19:15:00','2023-02-07','15:00:00'),(2076,377,8,7,'2023-02-08','19:15:00','2023-02-08','15:00:00'),(2077,378,8,7,'2023-02-10','19:15:00','2023-02-10','15:00:00'),(2078,379,8,7,'2023-02-11','19:15:00','2023-02-11','15:00:00'),(2079,380,8,7,'2023-02-12','19:15:00','2023-02-12','15:00:00'),(2080,381,8,7,'2023-02-13','19:15:00','2023-02-13','15:00:00'),(2081,382,8,7,'2023-02-14','19:15:00','2023-02-14','15:00:00'),(2082,383,8,7,'2023-02-15','19:15:00','2023-02-15','15:00:00'),(2083,384,8,7,'2023-02-17','19:15:00','2023-02-17','15:00:00'),(2084,385,8,7,'2023-02-18','19:15:00','2023-02-18','15:00:00'),(2085,386,8,7,'2023-02-19','19:15:00','2023-02-19','15:00:00'),(2086,387,8,7,'2023-02-20','19:15:00','2023-02-20','15:00:00'),(2087,388,8,7,'2023-02-21','19:15:00','2023-02-21','15:00:00'),(2088,389,8,7,'2023-02-22','19:15:00','2023-02-22','15:00:00'),(2089,390,8,7,'2023-02-24','19:15:00','2023-02-24','15:00:00'),(2090,391,8,7,'2023-02-25','19:15:00','2023-02-25','15:00:00'),(2091,392,8,7,'2023-02-26','19:15:00','2023-02-26','15:00:00'),(2092,393,8,7,'2023-02-27','19:15:00','2023-02-27','15:00:00'),(2093,394,8,7,'2023-02-28','19:15:00','2023-02-28','15:00:00'),(2094,395,8,7,'2023-03-01','19:15:00','2023-03-01','15:00:00'),(2095,396,7,8,'2023-01-31','06:15:00','2023-01-31','02:00:00'),(2096,397,7,8,'2023-02-01','06:15:00','2023-02-01','02:00:00'),(2097,398,7,8,'2023-02-03','06:15:00','2023-02-03','02:00:00'),(2098,399,7,8,'2023-02-04','06:15:00','2023-02-04','02:00:00'),(2099,400,7,8,'2023-02-05','06:15:00','2023-02-05','02:00:00'),(2100,401,7,8,'2023-02-06','06:15:00','2023-02-06','02:00:00'),(2101,402,7,8,'2023-02-07','06:15:00','2023-02-07','02:00:00'),(2102,403,7,8,'2023-02-08','06:15:00','2023-02-08','02:00:00'),(2103,404,7,8,'2023-02-10','06:15:00','2023-02-10','02:00:00'),(2104,405,7,8,'2023-02-11','06:15:00','2023-02-11','02:00:00'),(2105,406,7,8,'2023-02-12','06:15:00','2023-02-12','02:00:00'),(2106,407,7,8,'2023-02-13','06:15:00','2023-02-13','02:00:00'),(2107,408,7,8,'2023-02-14','06:15:00','2023-02-14','02:00:00'),(2108,409,7,8,'2023-02-15','06:15:00','2023-02-15','02:00:00'),(2109,410,7,8,'2023-02-17','06:15:00','2023-02-17','02:00:00'),(2110,411,7,8,'2023-02-18','06:15:00','2023-02-18','02:00:00'),(2111,412,7,8,'2023-02-19','06:15:00','2023-02-19','02:00:00'),(2112,413,7,8,'2023-02-20','06:15:00','2023-02-20','02:00:00'),(2113,414,7,8,'2023-02-21','06:15:00','2023-02-21','02:00:00'),(2114,415,7,8,'2023-02-22','06:15:00','2023-02-22','02:00:00'),(2115,416,7,8,'2023-02-24','06:15:00','2023-02-24','02:00:00'),(2116,417,7,8,'2023-02-25','06:15:00','2023-02-25','02:00:00'),(2117,418,7,8,'2023-02-26','06:15:00','2023-02-26','02:00:00'),(2118,419,7,8,'2023-02-27','06:15:00','2023-02-27','02:00:00'),(2119,420,7,8,'2023-02-28','06:15:00','2023-02-28','02:00:00'),(2120,421,7,8,'2023-03-01','06:15:00','2023-03-01','02:00:00'),(2121,422,8,6,'2023-01-31','18:20:00','2023-01-31','11:00:00'),(2122,422,8,11,'2023-01-31','18:50:00','2023-01-31','11:00:00'),(2123,422,6,11,'2023-01-31','18:50:00','2023-01-31','18:20:00'),(2124,423,8,6,'2023-02-01','18:20:00','2023-02-01','11:00:00'),(2125,423,8,11,'2023-02-01','18:50:00','2023-02-01','11:00:00'),(2126,423,6,11,'2023-02-01','18:50:00','2023-02-01','18:20:00'),(2127,424,8,6,'2023-02-03','18:20:00','2023-02-03','11:00:00'),(2128,424,8,11,'2023-02-03','18:50:00','2023-02-03','11:00:00'),(2129,424,6,11,'2023-02-03','18:50:00','2023-02-03','18:20:00'),(2130,425,8,6,'2023-02-04','18:20:00','2023-02-04','11:00:00'),(2131,425,8,11,'2023-02-04','18:50:00','2023-02-04','11:00:00'),(2132,425,6,11,'2023-02-04','18:50:00','2023-02-04','18:20:00'),(2133,426,8,6,'2023-02-05','18:20:00','2023-02-05','11:00:00'),(2134,426,8,11,'2023-02-05','18:50:00','2023-02-05','11:00:00'),(2135,426,6,11,'2023-02-05','18:50:00','2023-02-05','18:20:00'),(2136,427,8,6,'2023-02-06','18:20:00','2023-02-06','11:00:00'),(2137,427,8,11,'2023-02-06','18:50:00','2023-02-06','11:00:00'),(2138,427,6,11,'2023-02-06','18:50:00','2023-02-06','18:20:00'),(2139,428,8,6,'2023-02-07','18:20:00','2023-02-07','11:00:00'),(2140,428,8,11,'2023-02-07','18:50:00','2023-02-07','11:00:00'),(2141,428,6,11,'2023-02-07','18:50:00','2023-02-07','18:20:00'),(2142,429,8,6,'2023-02-08','18:20:00','2023-02-08','11:00:00'),(2143,429,8,11,'2023-02-08','18:50:00','2023-02-08','11:00:00'),(2144,429,6,11,'2023-02-08','18:50:00','2023-02-08','18:20:00'),(2145,430,8,6,'2023-02-10','18:20:00','2023-02-10','11:00:00'),(2146,430,8,11,'2023-02-10','18:50:00','2023-02-10','11:00:00'),(2147,430,6,11,'2023-02-10','18:50:00','2023-02-10','18:20:00'),(2148,431,8,6,'2023-02-11','18:20:00','2023-02-11','11:00:00'),(2149,431,8,11,'2023-02-11','18:50:00','2023-02-11','11:00:00'),(2150,431,6,11,'2023-02-11','18:50:00','2023-02-11','18:20:00'),(2151,432,8,6,'2023-02-12','18:20:00','2023-02-12','11:00:00'),(2152,432,8,11,'2023-02-12','18:50:00','2023-02-12','11:00:00'),(2153,432,6,11,'2023-02-12','18:50:00','2023-02-12','18:20:00'),(2154,433,8,6,'2023-02-13','18:20:00','2023-02-13','11:00:00'),(2155,433,8,11,'2023-02-13','18:50:00','2023-02-13','11:00:00'),(2156,433,6,11,'2023-02-13','18:50:00','2023-02-13','18:20:00'),(2157,434,8,6,'2023-02-14','18:20:00','2023-02-14','11:00:00'),(2158,434,8,11,'2023-02-14','18:50:00','2023-02-14','11:00:00'),(2159,434,6,11,'2023-02-14','18:50:00','2023-02-14','18:20:00'),(2160,435,8,6,'2023-02-15','18:20:00','2023-02-15','11:00:00'),(2161,435,8,11,'2023-02-15','18:50:00','2023-02-15','11:00:00'),(2162,435,6,11,'2023-02-15','18:50:00','2023-02-15','18:20:00'),(2163,436,8,6,'2023-02-17','18:20:00','2023-02-17','11:00:00'),(2164,436,8,11,'2023-02-17','18:50:00','2023-02-17','11:00:00'),(2165,436,6,11,'2023-02-17','18:50:00','2023-02-17','18:20:00'),(2166,437,8,6,'2023-02-18','18:20:00','2023-02-18','11:00:00'),(2167,437,8,11,'2023-02-18','18:50:00','2023-02-18','11:00:00'),(2168,437,6,11,'2023-02-18','18:50:00','2023-02-18','18:20:00'),(2169,438,8,6,'2023-02-19','18:20:00','2023-02-19','11:00:00'),(2170,438,8,11,'2023-02-19','18:50:00','2023-02-19','11:00:00'),(2171,438,6,11,'2023-02-19','18:50:00','2023-02-19','18:20:00'),(2172,439,8,6,'2023-02-20','18:20:00','2023-02-20','11:00:00'),(2173,439,8,11,'2023-02-20','18:50:00','2023-02-20','11:00:00'),(2174,439,6,11,'2023-02-20','18:50:00','2023-02-20','18:20:00'),(2175,440,8,6,'2023-02-21','18:20:00','2023-02-21','11:00:00'),(2176,440,8,11,'2023-02-21','18:50:00','2023-02-21','11:00:00'),(2177,440,6,11,'2023-02-21','18:50:00','2023-02-21','18:20:00'),(2178,441,8,6,'2023-02-22','18:20:00','2023-02-22','11:00:00'),(2179,441,8,11,'2023-02-22','18:50:00','2023-02-22','11:00:00'),(2180,441,6,11,'2023-02-22','18:50:00','2023-02-22','18:20:00'),(2181,442,8,6,'2023-02-24','18:20:00','2023-02-24','11:00:00'),(2182,442,8,11,'2023-02-24','18:50:00','2023-02-24','11:00:00'),(2183,442,6,11,'2023-02-24','18:50:00','2023-02-24','18:20:00'),(2184,443,8,6,'2023-02-25','18:20:00','2023-02-25','11:00:00'),(2185,443,8,11,'2023-02-25','18:50:00','2023-02-25','11:00:00'),(2186,443,6,11,'2023-02-25','18:50:00','2023-02-25','18:20:00'),(2187,444,8,6,'2023-02-26','18:20:00','2023-02-26','11:00:00'),(2188,444,8,11,'2023-02-26','18:50:00','2023-02-26','11:00:00'),(2189,444,6,11,'2023-02-26','18:50:00','2023-02-26','18:20:00'),(2190,445,8,6,'2023-02-27','18:20:00','2023-02-27','11:00:00'),(2191,445,8,11,'2023-02-27','18:50:00','2023-02-27','11:00:00'),(2192,445,6,11,'2023-02-27','18:50:00','2023-02-27','18:20:00'),(2193,446,8,6,'2023-02-28','18:20:00','2023-02-28','11:00:00'),(2194,446,8,11,'2023-02-28','18:50:00','2023-02-28','11:00:00'),(2195,446,6,11,'2023-02-28','18:50:00','2023-02-28','18:20:00'),(2196,447,8,6,'2023-03-01','18:20:00','2023-03-01','11:00:00'),(2197,447,8,11,'2023-03-01','18:50:00','2023-03-01','11:00:00'),(2198,447,6,11,'2023-03-01','18:50:00','2023-03-01','18:20:00'),(2199,448,8,6,'2023-01-31','15:00:00','2023-01-31','11:00:00'),(2200,448,8,11,'2023-01-31','15:30:00','2023-01-31','11:00:00'),(2201,448,6,11,'2023-01-31','15:30:00','2023-01-31','15:00:00'),(2202,449,8,6,'2023-02-01','15:00:00','2023-02-01','11:00:00'),(2203,449,8,11,'2023-02-01','15:30:00','2023-02-01','11:00:00'),(2204,449,6,11,'2023-02-01','15:30:00','2023-02-01','15:00:00'),(2205,450,8,6,'2023-02-03','15:00:00','2023-02-03','11:00:00'),(2206,450,8,11,'2023-02-03','15:30:00','2023-02-03','11:00:00'),(2207,450,6,11,'2023-02-03','15:30:00','2023-02-03','15:00:00'),(2208,451,8,6,'2023-02-04','15:00:00','2023-02-04','11:00:00'),(2209,451,8,11,'2023-02-04','15:30:00','2023-02-04','11:00:00'),(2210,451,6,11,'2023-02-04','15:30:00','2023-02-04','15:00:00'),(2211,452,8,6,'2023-02-05','15:00:00','2023-02-05','11:00:00'),(2212,452,8,11,'2023-02-05','15:30:00','2023-02-05','11:00:00'),(2213,452,6,11,'2023-02-05','15:30:00','2023-02-05','15:00:00'),(2214,453,8,6,'2023-02-06','15:00:00','2023-02-06','11:00:00'),(2215,453,8,11,'2023-02-06','15:30:00','2023-02-06','11:00:00'),(2216,453,6,11,'2023-02-06','15:30:00','2023-02-06','15:00:00'),(2217,454,8,6,'2023-02-07','15:00:00','2023-02-07','11:00:00'),(2218,454,8,11,'2023-02-07','15:30:00','2023-02-07','11:00:00'),(2219,454,6,11,'2023-02-07','15:30:00','2023-02-07','15:00:00'),(2220,455,8,6,'2023-02-08','15:00:00','2023-02-08','11:00:00'),(2221,455,8,11,'2023-02-08','15:30:00','2023-02-08','11:00:00'),(2222,455,6,11,'2023-02-08','15:30:00','2023-02-08','15:00:00'),(2223,456,8,6,'2023-02-10','15:00:00','2023-02-10','11:00:00'),(2224,456,8,11,'2023-02-10','15:30:00','2023-02-10','11:00:00'),(2225,456,6,11,'2023-02-10','15:30:00','2023-02-10','15:00:00'),(2226,457,8,6,'2023-02-11','15:00:00','2023-02-11','11:00:00'),(2227,457,8,11,'2023-02-11','15:30:00','2023-02-11','11:00:00'),(2228,457,6,11,'2023-02-11','15:30:00','2023-02-11','15:00:00'),(2229,458,8,6,'2023-02-12','15:00:00','2023-02-12','11:00:00'),(2230,458,8,11,'2023-02-12','15:30:00','2023-02-12','11:00:00'),(2231,458,6,11,'2023-02-12','15:30:00','2023-02-12','15:00:00'),(2232,459,8,6,'2023-02-13','15:00:00','2023-02-13','11:00:00'),(2233,459,8,11,'2023-02-13','15:30:00','2023-02-13','11:00:00'),(2234,459,6,11,'2023-02-13','15:30:00','2023-02-13','15:00:00'),(2235,460,8,6,'2023-02-14','15:00:00','2023-02-14','11:00:00'),(2236,460,8,11,'2023-02-14','15:30:00','2023-02-14','11:00:00'),(2237,460,6,11,'2023-02-14','15:30:00','2023-02-14','15:00:00'),(2238,461,8,6,'2023-02-15','15:00:00','2023-02-15','11:00:00'),(2239,461,8,11,'2023-02-15','15:30:00','2023-02-15','11:00:00'),(2240,461,6,11,'2023-02-15','15:30:00','2023-02-15','15:00:00'),(2241,462,8,6,'2023-02-17','15:00:00','2023-02-17','11:00:00'),(2242,462,8,11,'2023-02-17','15:30:00','2023-02-17','11:00:00'),(2243,462,6,11,'2023-02-17','15:30:00','2023-02-17','15:00:00'),(2244,463,8,6,'2023-02-18','15:00:00','2023-02-18','11:00:00'),(2245,463,8,11,'2023-02-18','15:30:00','2023-02-18','11:00:00'),(2246,463,6,11,'2023-02-18','15:30:00','2023-02-18','15:00:00'),(2247,464,8,6,'2023-02-19','15:00:00','2023-02-19','11:00:00'),(2248,464,8,11,'2023-02-19','15:30:00','2023-02-19','11:00:00'),(2249,464,6,11,'2023-02-19','15:30:00','2023-02-19','15:00:00'),(2250,465,8,6,'2023-02-20','15:00:00','2023-02-20','11:00:00'),(2251,465,8,11,'2023-02-20','15:30:00','2023-02-20','11:00:00'),(2252,465,6,11,'2023-02-20','15:30:00','2023-02-20','15:00:00'),(2253,466,8,6,'2023-02-21','15:00:00','2023-02-21','11:00:00'),(2254,466,8,11,'2023-02-21','15:30:00','2023-02-21','11:00:00'),(2255,466,6,11,'2023-02-21','15:30:00','2023-02-21','15:00:00'),(2256,467,8,6,'2023-02-22','15:00:00','2023-02-22','11:00:00'),(2257,467,8,11,'2023-02-22','15:30:00','2023-02-22','11:00:00'),(2258,467,6,11,'2023-02-22','15:30:00','2023-02-22','15:00:00'),(2259,468,8,6,'2023-02-24','15:00:00','2023-02-24','11:00:00'),(2260,468,8,11,'2023-02-24','15:30:00','2023-02-24','11:00:00'),(2261,468,6,11,'2023-02-24','15:30:00','2023-02-24','15:00:00'),(2262,469,8,6,'2023-02-25','15:00:00','2023-02-25','11:00:00'),(2263,469,8,11,'2023-02-25','15:30:00','2023-02-25','11:00:00'),(2264,469,6,11,'2023-02-25','15:30:00','2023-02-25','15:00:00'),(2265,470,8,6,'2023-02-26','15:00:00','2023-02-26','11:00:00'),(2266,470,8,11,'2023-02-26','15:30:00','2023-02-26','11:00:00'),(2267,470,6,11,'2023-02-26','15:30:00','2023-02-26','15:00:00'),(2268,471,8,6,'2023-02-27','15:00:00','2023-02-27','11:00:00'),(2269,471,8,11,'2023-02-27','15:30:00','2023-02-27','11:00:00'),(2270,471,6,11,'2023-02-27','15:30:00','2023-02-27','15:00:00'),(2271,472,8,6,'2023-02-28','15:00:00','2023-02-28','11:00:00'),(2272,472,8,11,'2023-02-28','15:30:00','2023-02-28','11:00:00'),(2273,472,6,11,'2023-02-28','15:30:00','2023-02-28','15:00:00'),(2274,473,8,6,'2023-03-01','15:00:00','2023-03-01','11:00:00'),(2275,473,8,11,'2023-03-01','15:30:00','2023-03-01','11:00:00'),(2276,473,6,11,'2023-03-01','15:30:00','2023-03-01','15:00:00'),(2277,474,8,6,'2023-01-31','15:40:00','2023-01-31','11:00:00'),(2278,474,8,11,'2023-01-31','16:10:00','2023-01-31','11:00:00'),(2279,474,6,11,'2023-01-31','16:10:00','2023-01-31','15:40:00'),(2280,475,8,6,'2023-02-01','15:40:00','2023-02-01','11:00:00'),(2281,475,8,11,'2023-02-01','16:10:00','2023-02-01','11:00:00'),(2282,475,6,11,'2023-02-01','16:10:00','2023-02-01','15:40:00'),(2283,476,8,6,'2023-02-03','15:40:00','2023-02-03','11:00:00'),(2284,476,8,11,'2023-02-03','16:10:00','2023-02-03','11:00:00'),(2285,476,6,11,'2023-02-03','16:10:00','2023-02-03','15:40:00'),(2286,477,8,6,'2023-02-04','15:40:00','2023-02-04','11:00:00'),(2287,477,8,11,'2023-02-04','16:10:00','2023-02-04','11:00:00'),(2288,477,6,11,'2023-02-04','16:10:00','2023-02-04','15:40:00'),(2289,478,8,6,'2023-02-05','15:40:00','2023-02-05','11:00:00'),(2290,478,8,11,'2023-02-05','16:10:00','2023-02-05','11:00:00'),(2291,478,6,11,'2023-02-05','16:10:00','2023-02-05','15:40:00'),(2292,479,8,6,'2023-02-06','15:40:00','2023-02-06','11:00:00'),(2293,479,8,11,'2023-02-06','16:10:00','2023-02-06','11:00:00'),(2294,479,6,11,'2023-02-06','16:10:00','2023-02-06','15:40:00'),(2295,480,8,6,'2023-02-07','15:40:00','2023-02-07','11:00:00'),(2296,480,8,11,'2023-02-07','16:10:00','2023-02-07','11:00:00'),(2297,480,6,11,'2023-02-07','16:10:00','2023-02-07','15:40:00'),(2298,481,8,6,'2023-02-08','15:40:00','2023-02-08','11:00:00'),(2299,481,8,11,'2023-02-08','16:10:00','2023-02-08','11:00:00'),(2300,481,6,11,'2023-02-08','16:10:00','2023-02-08','15:40:00'),(2301,482,8,6,'2023-02-10','15:40:00','2023-02-10','11:00:00'),(2302,482,8,11,'2023-02-10','16:10:00','2023-02-10','11:00:00'),(2303,482,6,11,'2023-02-10','16:10:00','2023-02-10','15:40:00'),(2304,483,8,6,'2023-02-11','15:40:00','2023-02-11','11:00:00'),(2305,483,8,11,'2023-02-11','16:10:00','2023-02-11','11:00:00'),(2306,483,6,11,'2023-02-11','16:10:00','2023-02-11','15:40:00'),(2307,484,8,6,'2023-02-12','15:40:00','2023-02-12','11:00:00'),(2308,484,8,11,'2023-02-12','16:10:00','2023-02-12','11:00:00'),(2309,484,6,11,'2023-02-12','16:10:00','2023-02-12','15:40:00'),(2310,485,8,6,'2023-02-13','15:40:00','2023-02-13','11:00:00'),(2311,485,8,11,'2023-02-13','16:10:00','2023-02-13','11:00:00'),(2312,485,6,11,'2023-02-13','16:10:00','2023-02-13','15:40:00'),(2313,486,8,6,'2023-02-14','15:40:00','2023-02-14','11:00:00'),(2314,486,8,11,'2023-02-14','16:10:00','2023-02-14','11:00:00'),(2315,486,6,11,'2023-02-14','16:10:00','2023-02-14','15:40:00'),(2316,487,8,6,'2023-02-15','15:40:00','2023-02-15','11:00:00'),(2317,487,8,11,'2023-02-15','16:10:00','2023-02-15','11:00:00'),(2318,487,6,11,'2023-02-15','16:10:00','2023-02-15','15:40:00'),(2319,488,8,6,'2023-02-17','15:40:00','2023-02-17','11:00:00'),(2320,488,8,11,'2023-02-17','16:10:00','2023-02-17','11:00:00'),(2321,488,6,11,'2023-02-17','16:10:00','2023-02-17','15:40:00'),(2322,489,8,6,'2023-02-18','15:40:00','2023-02-18','11:00:00'),(2323,489,8,11,'2023-02-18','16:10:00','2023-02-18','11:00:00'),(2324,489,6,11,'2023-02-18','16:10:00','2023-02-18','15:40:00'),(2325,490,8,6,'2023-02-19','15:40:00','2023-02-19','11:00:00'),(2326,490,8,11,'2023-02-19','16:10:00','2023-02-19','11:00:00'),(2327,490,6,11,'2023-02-19','16:10:00','2023-02-19','15:40:00'),(2328,491,8,6,'2023-02-20','15:40:00','2023-02-20','11:00:00'),(2329,491,8,11,'2023-02-20','16:10:00','2023-02-20','11:00:00'),(2330,491,6,11,'2023-02-20','16:10:00','2023-02-20','15:40:00'),(2331,492,8,6,'2023-02-21','15:40:00','2023-02-21','11:00:00'),(2332,492,8,11,'2023-02-21','16:10:00','2023-02-21','11:00:00'),(2333,492,6,11,'2023-02-21','16:10:00','2023-02-21','15:40:00'),(2334,493,8,6,'2023-02-22','15:40:00','2023-02-22','11:00:00'),(2335,493,8,11,'2023-02-22','16:10:00','2023-02-22','11:00:00'),(2336,493,6,11,'2023-02-22','16:10:00','2023-02-22','15:40:00'),(2337,494,8,6,'2023-02-24','15:40:00','2023-02-24','11:00:00'),(2338,494,8,11,'2023-02-24','16:10:00','2023-02-24','11:00:00'),(2339,494,6,11,'2023-02-24','16:10:00','2023-02-24','15:40:00'),(2340,495,8,6,'2023-02-25','15:40:00','2023-02-25','11:00:00'),(2341,495,8,11,'2023-02-25','16:10:00','2023-02-25','11:00:00'),(2342,495,6,11,'2023-02-25','16:10:00','2023-02-25','15:40:00'),(2343,496,8,6,'2023-02-26','15:40:00','2023-02-26','11:00:00'),(2344,496,8,11,'2023-02-26','16:10:00','2023-02-26','11:00:00'),(2345,496,6,11,'2023-02-26','16:10:00','2023-02-26','15:40:00'),(2346,497,8,6,'2023-02-27','15:40:00','2023-02-27','11:00:00'),(2347,497,8,11,'2023-02-27','16:10:00','2023-02-27','11:00:00'),(2348,497,6,11,'2023-02-27','16:10:00','2023-02-27','15:40:00'),(2349,498,8,6,'2023-02-28','15:40:00','2023-02-28','11:00:00'),(2350,498,8,11,'2023-02-28','16:10:00','2023-02-28','11:00:00'),(2351,498,6,11,'2023-02-28','16:10:00','2023-02-28','15:40:00'),(2352,499,8,6,'2023-03-01','15:40:00','2023-03-01','11:00:00'),(2353,499,8,11,'2023-03-01','16:10:00','2023-03-01','11:00:00'),(2354,499,6,11,'2023-03-01','16:10:00','2023-03-01','15:40:00'),(2355,500,11,6,'2023-01-31','17:20:00','2023-01-31','17:00:00'),(2356,500,11,8,'2023-01-31','22:10:00','2023-01-31','17:00:00'),(2357,500,6,8,'2023-01-31','22:10:00','2023-01-31','17:20:00'),(2358,501,11,6,'2023-02-01','17:20:00','2023-02-01','17:00:00'),(2359,501,11,8,'2023-02-01','22:10:00','2023-02-01','17:00:00'),(2360,501,6,8,'2023-02-01','22:10:00','2023-02-01','17:20:00'),(2361,502,11,6,'2023-02-03','17:20:00','2023-02-03','17:00:00'),(2362,502,11,8,'2023-02-03','22:10:00','2023-02-03','17:00:00'),(2363,502,6,8,'2023-02-03','22:10:00','2023-02-03','17:20:00'),(2364,503,11,6,'2023-02-04','17:20:00','2023-02-04','17:00:00'),(2365,503,11,8,'2023-02-04','22:10:00','2023-02-04','17:00:00'),(2366,503,6,8,'2023-02-04','22:10:00','2023-02-04','17:20:00'),(2367,504,11,6,'2023-02-05','17:20:00','2023-02-05','17:00:00'),(2368,504,11,8,'2023-02-05','22:10:00','2023-02-05','17:00:00'),(2369,504,6,8,'2023-02-05','22:10:00','2023-02-05','17:20:00'),(2370,505,11,6,'2023-02-06','17:20:00','2023-02-06','17:00:00'),(2371,505,11,8,'2023-02-06','22:10:00','2023-02-06','17:00:00'),(2372,505,6,8,'2023-02-06','22:10:00','2023-02-06','17:20:00'),(2373,506,11,6,'2023-02-07','17:20:00','2023-02-07','17:00:00'),(2374,506,11,8,'2023-02-07','22:10:00','2023-02-07','17:00:00'),(2375,506,6,8,'2023-02-07','22:10:00','2023-02-07','17:20:00'),(2376,507,11,6,'2023-02-08','17:20:00','2023-02-08','17:00:00'),(2377,507,11,8,'2023-02-08','22:10:00','2023-02-08','17:00:00'),(2378,507,6,8,'2023-02-08','22:10:00','2023-02-08','17:20:00'),(2379,508,11,6,'2023-02-10','17:20:00','2023-02-10','17:00:00'),(2380,508,11,8,'2023-02-10','22:10:00','2023-02-10','17:00:00'),(2381,508,6,8,'2023-02-10','22:10:00','2023-02-10','17:20:00'),(2382,509,11,6,'2023-02-11','17:20:00','2023-02-11','17:00:00'),(2383,509,11,8,'2023-02-11','22:10:00','2023-02-11','17:00:00'),(2384,509,6,8,'2023-02-11','22:10:00','2023-02-11','17:20:00'),(2385,510,11,6,'2023-02-12','17:20:00','2023-02-12','17:00:00'),(2386,510,11,8,'2023-02-12','22:10:00','2023-02-12','17:00:00'),(2387,510,6,8,'2023-02-12','22:10:00','2023-02-12','17:20:00'),(2388,511,11,6,'2023-02-13','17:20:00','2023-02-13','17:00:00'),(2389,511,11,8,'2023-02-13','22:10:00','2023-02-13','17:00:00'),(2390,511,6,8,'2023-02-13','22:10:00','2023-02-13','17:20:00'),(2391,512,11,6,'2023-02-14','17:20:00','2023-02-14','17:00:00'),(2392,512,11,8,'2023-02-14','22:10:00','2023-02-14','17:00:00'),(2393,512,6,8,'2023-02-14','22:10:00','2023-02-14','17:20:00'),(2394,513,11,6,'2023-02-15','17:20:00','2023-02-15','17:00:00'),(2395,513,11,8,'2023-02-15','22:10:00','2023-02-15','17:00:00'),(2396,513,6,8,'2023-02-15','22:10:00','2023-02-15','17:20:00'),(2397,514,11,6,'2023-02-17','17:20:00','2023-02-17','17:00:00'),(2398,514,11,8,'2023-02-17','22:10:00','2023-02-17','17:00:00'),(2399,514,6,8,'2023-02-17','22:10:00','2023-02-17','17:20:00'),(2400,515,11,6,'2023-02-18','17:20:00','2023-02-18','17:00:00'),(2401,515,11,8,'2023-02-18','22:10:00','2023-02-18','17:00:00'),(2402,515,6,8,'2023-02-18','22:10:00','2023-02-18','17:20:00'),(2403,516,11,6,'2023-02-19','17:20:00','2023-02-19','17:00:00'),(2404,516,11,8,'2023-02-19','22:10:00','2023-02-19','17:00:00'),(2405,516,6,8,'2023-02-19','22:10:00','2023-02-19','17:20:00'),(2406,517,11,6,'2023-02-20','17:20:00','2023-02-20','17:00:00'),(2407,517,11,8,'2023-02-20','22:10:00','2023-02-20','17:00:00'),(2408,517,6,8,'2023-02-20','22:10:00','2023-02-20','17:20:00'),(2409,518,11,6,'2023-02-21','17:20:00','2023-02-21','17:00:00'),(2410,518,11,8,'2023-02-21','22:10:00','2023-02-21','17:00:00'),(2411,518,6,8,'2023-02-21','22:10:00','2023-02-21','17:20:00'),(2412,519,11,6,'2023-02-22','17:20:00','2023-02-22','17:00:00'),(2413,519,11,8,'2023-02-22','22:10:00','2023-02-22','17:00:00'),(2414,519,6,8,'2023-02-22','22:10:00','2023-02-22','17:20:00'),(2415,520,11,6,'2023-02-24','17:20:00','2023-02-24','17:00:00'),(2416,520,11,8,'2023-02-24','22:10:00','2023-02-24','17:00:00'),(2417,520,6,8,'2023-02-24','22:10:00','2023-02-24','17:20:00'),(2418,521,11,6,'2023-02-25','17:20:00','2023-02-25','17:00:00'),(2419,521,11,8,'2023-02-25','22:10:00','2023-02-25','17:00:00'),(2420,521,6,8,'2023-02-25','22:10:00','2023-02-25','17:20:00'),(2421,522,11,6,'2023-02-26','17:20:00','2023-02-26','17:00:00'),(2422,522,11,8,'2023-02-26','22:10:00','2023-02-26','17:00:00'),(2423,522,6,8,'2023-02-26','22:10:00','2023-02-26','17:20:00'),(2424,523,11,6,'2023-02-27','17:20:00','2023-02-27','17:00:00'),(2425,523,11,8,'2023-02-27','22:10:00','2023-02-27','17:00:00'),(2426,523,6,8,'2023-02-27','22:10:00','2023-02-27','17:20:00'),(2427,524,11,6,'2023-02-28','17:20:00','2023-02-28','17:00:00'),(2428,524,11,8,'2023-02-28','22:10:00','2023-02-28','17:00:00'),(2429,524,6,8,'2023-02-28','22:10:00','2023-02-28','17:20:00'),(2430,525,11,6,'2023-03-01','17:20:00','2023-03-01','17:00:00'),(2431,525,11,8,'2023-03-01','22:10:00','2023-03-01','17:00:00'),(2432,525,6,8,'2023-03-01','22:10:00','2023-03-01','17:20:00'),(2433,526,8,1,'2023-01-31','12:45:00','2023-01-31','10:00:00'),(2434,527,8,1,'2023-02-01','12:45:00','2023-02-01','10:00:00'),(2435,528,8,1,'2023-02-03','12:45:00','2023-02-03','10:00:00'),(2436,529,8,1,'2023-02-04','12:45:00','2023-02-04','10:00:00'),(2437,530,8,1,'2023-02-05','12:45:00','2023-02-05','10:00:00'),(2438,531,8,1,'2023-02-06','12:45:00','2023-02-06','10:00:00'),(2439,532,8,1,'2023-02-07','12:45:00','2023-02-07','10:00:00'),(2440,533,8,1,'2023-02-08','12:45:00','2023-02-08','10:00:00'),(2441,534,8,1,'2023-02-10','12:45:00','2023-02-10','10:00:00'),(2442,535,8,1,'2023-02-11','12:45:00','2023-02-11','10:00:00'),(2443,536,8,1,'2023-02-12','12:45:00','2023-02-12','10:00:00'),(2444,537,8,1,'2023-02-13','12:45:00','2023-02-13','10:00:00'),(2445,538,8,1,'2023-02-14','12:45:00','2023-02-14','10:00:00'),(2446,539,8,1,'2023-02-15','12:45:00','2023-02-15','10:00:00'),(2447,540,8,1,'2023-02-17','12:45:00','2023-02-17','10:00:00'),(2448,541,8,1,'2023-02-18','12:45:00','2023-02-18','10:00:00'),(2449,542,8,1,'2023-02-19','12:45:00','2023-02-19','10:00:00'),(2450,543,8,1,'2023-02-20','12:45:00','2023-02-20','10:00:00'),(2451,544,8,1,'2023-02-21','12:45:00','2023-02-21','10:00:00'),(2452,545,8,1,'2023-02-22','12:45:00','2023-02-22','10:00:00'),(2453,546,8,1,'2023-02-24','12:45:00','2023-02-24','10:00:00'),(2454,547,8,1,'2023-02-25','12:45:00','2023-02-25','10:00:00'),(2455,548,8,1,'2023-02-26','12:45:00','2023-02-26','10:00:00'),(2456,549,8,1,'2023-02-27','12:45:00','2023-02-27','10:00:00'),(2457,550,8,1,'2023-02-28','12:45:00','2023-02-28','10:00:00'),(2458,551,8,1,'2023-03-01','12:45:00','2023-03-01','10:00:00'),(2459,552,8,1,'2023-01-31','11:55:00','2023-01-31','10:00:00'),(2460,552,8,5,'2023-01-31','11:15:00','2023-01-31','10:00:00'),(2461,552,5,1,'2023-01-31','11:55:00','2023-01-31','11:15:00'),(2462,553,8,1,'2023-02-01','11:55:00','2023-02-01','10:00:00'),(2463,553,8,5,'2023-02-01','11:15:00','2023-02-01','10:00:00'),(2464,553,5,1,'2023-02-01','11:55:00','2023-02-01','11:15:00'),(2465,554,8,1,'2023-02-03','11:55:00','2023-02-03','10:00:00'),(2466,554,8,5,'2023-02-03','11:15:00','2023-02-03','10:00:00'),(2467,554,5,1,'2023-02-03','11:55:00','2023-02-03','11:15:00'),(2468,555,8,1,'2023-02-04','11:55:00','2023-02-04','10:00:00'),(2469,555,8,5,'2023-02-04','11:15:00','2023-02-04','10:00:00'),(2470,555,5,1,'2023-02-04','11:55:00','2023-02-04','11:15:00'),(2471,556,8,1,'2023-02-05','11:55:00','2023-02-05','10:00:00'),(2472,556,8,5,'2023-02-05','11:15:00','2023-02-05','10:00:00'),(2473,556,5,1,'2023-02-05','11:55:00','2023-02-05','11:15:00'),(2474,557,8,1,'2023-02-06','11:55:00','2023-02-06','10:00:00'),(2475,557,8,5,'2023-02-06','11:15:00','2023-02-06','10:00:00'),(2476,557,5,1,'2023-02-06','11:55:00','2023-02-06','11:15:00'),(2477,558,8,1,'2023-02-07','11:55:00','2023-02-07','10:00:00'),(2478,558,8,5,'2023-02-07','11:15:00','2023-02-07','10:00:00'),(2479,558,5,1,'2023-02-07','11:55:00','2023-02-07','11:15:00'),(2480,559,8,1,'2023-02-08','11:55:00','2023-02-08','10:00:00'),(2481,559,8,5,'2023-02-08','11:15:00','2023-02-08','10:00:00'),(2482,559,5,1,'2023-02-08','11:55:00','2023-02-08','11:15:00'),(2483,560,8,1,'2023-02-10','11:55:00','2023-02-10','10:00:00'),(2484,560,8,5,'2023-02-10','11:15:00','2023-02-10','10:00:00'),(2485,560,5,1,'2023-02-10','11:55:00','2023-02-10','11:15:00'),(2486,561,8,1,'2023-02-11','11:55:00','2023-02-11','10:00:00'),(2487,561,8,5,'2023-02-11','11:15:00','2023-02-11','10:00:00'),(2488,561,5,1,'2023-02-11','11:55:00','2023-02-11','11:15:00'),(2489,562,8,1,'2023-02-12','11:55:00','2023-02-12','10:00:00'),(2490,562,8,5,'2023-02-12','11:15:00','2023-02-12','10:00:00'),(2491,562,5,1,'2023-02-12','11:55:00','2023-02-12','11:15:00'),(2492,563,8,1,'2023-02-13','11:55:00','2023-02-13','10:00:00'),(2493,563,8,5,'2023-02-13','11:15:00','2023-02-13','10:00:00'),(2494,563,5,1,'2023-02-13','11:55:00','2023-02-13','11:15:00'),(2495,564,8,1,'2023-02-14','11:55:00','2023-02-14','10:00:00'),(2496,564,8,5,'2023-02-14','11:15:00','2023-02-14','10:00:00'),(2497,564,5,1,'2023-02-14','11:55:00','2023-02-14','11:15:00'),(2498,565,8,1,'2023-02-15','11:55:00','2023-02-15','10:00:00'),(2499,565,8,5,'2023-02-15','11:15:00','2023-02-15','10:00:00'),(2500,565,5,1,'2023-02-15','11:55:00','2023-02-15','11:15:00'),(2501,566,8,1,'2023-02-17','11:55:00','2023-02-17','10:00:00'),(2502,566,8,5,'2023-02-17','11:15:00','2023-02-17','10:00:00'),(2503,566,5,1,'2023-02-17','11:55:00','2023-02-17','11:15:00'),(2504,567,8,1,'2023-02-18','11:55:00','2023-02-18','10:00:00'),(2505,567,8,5,'2023-02-18','11:15:00','2023-02-18','10:00:00'),(2506,567,5,1,'2023-02-18','11:55:00','2023-02-18','11:15:00'),(2507,568,8,1,'2023-02-19','11:55:00','2023-02-19','10:00:00'),(2508,568,8,5,'2023-02-19','11:15:00','2023-02-19','10:00:00'),(2509,568,5,1,'2023-02-19','11:55:00','2023-02-19','11:15:00'),(2510,569,8,1,'2023-02-20','11:55:00','2023-02-20','10:00:00'),(2511,569,8,5,'2023-02-20','11:15:00','2023-02-20','10:00:00'),(2512,569,5,1,'2023-02-20','11:55:00','2023-02-20','11:15:00'),(2513,570,8,1,'2023-02-21','11:55:00','2023-02-21','10:00:00'),(2514,570,8,5,'2023-02-21','11:15:00','2023-02-21','10:00:00'),(2515,570,5,1,'2023-02-21','11:55:00','2023-02-21','11:15:00'),(2516,571,8,1,'2023-02-22','11:55:00','2023-02-22','10:00:00'),(2517,571,8,5,'2023-02-22','11:15:00','2023-02-22','10:00:00'),(2518,571,5,1,'2023-02-22','11:55:00','2023-02-22','11:15:00'),(2519,572,8,1,'2023-02-24','11:55:00','2023-02-24','10:00:00'),(2520,572,8,5,'2023-02-24','11:15:00','2023-02-24','10:00:00'),(2521,572,5,1,'2023-02-24','11:55:00','2023-02-24','11:15:00'),(2522,573,8,1,'2023-02-25','11:55:00','2023-02-25','10:00:00'),(2523,573,8,5,'2023-02-25','11:15:00','2023-02-25','10:00:00'),(2524,573,5,1,'2023-02-25','11:55:00','2023-02-25','11:15:00'),(2525,574,8,1,'2023-02-26','11:55:00','2023-02-26','10:00:00'),(2526,574,8,5,'2023-02-26','11:15:00','2023-02-26','10:00:00'),(2527,574,5,1,'2023-02-26','11:55:00','2023-02-26','11:15:00'),(2528,575,8,1,'2023-02-27','11:55:00','2023-02-27','10:00:00'),(2529,575,8,5,'2023-02-27','11:15:00','2023-02-27','10:00:00'),(2530,575,5,1,'2023-02-27','11:55:00','2023-02-27','11:15:00'),(2531,576,8,1,'2023-02-28','11:55:00','2023-02-28','10:00:00'),(2532,576,8,5,'2023-02-28','11:15:00','2023-02-28','10:00:00'),(2533,576,5,1,'2023-02-28','11:55:00','2023-02-28','11:15:00'),(2534,577,8,1,'2023-03-01','11:55:00','2023-03-01','10:00:00'),(2535,577,8,5,'2023-03-01','11:15:00','2023-03-01','10:00:00'),(2536,577,5,1,'2023-03-01','11:55:00','2023-03-01','11:15:00');
/*!40000 ALTER TABLE `disponibilidad` ENABLE KEYS */;
UNLOCK TABLES;

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
  UNIQUE KEY `nDisponibilidad` (`nDisponibilidad`,`nAsiento`),
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `disponibilidadasientos_IN` (`nDisponibilidad`,`nAsiento`),
  KEY `nBoleto` (`nBoleto`),
  KEY `dispAsientos_user_id_FK` (`user_id`),
  CONSTRAINT `dispAsientos_user_id_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `disponibilidadasientos_ibfk_1` FOREIGN KEY (`nDisponibilidad`) REFERENCES `disponibilidad` (`nNumero`),
  CONSTRAINT `disponibilidadasientos_ibfk_2` FOREIGN KEY (`nBoleto`) REFERENCES `boletosvendidos` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidadasientos`
--

LOCK TABLES `disponibilidadasientos` WRITE;
/*!40000 ALTER TABLE `disponibilidadasientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `disponibilidadasientos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `distribucionasientos`
--

LOCK TABLES `distribucionasientos` WRITE;
/*!40000 ALTER TABLE `distribucionasientos` DISABLE KEYS */;
INSERT INTO `distribucionasientos` VALUES (1,32,'01T,02T,00,03T,04T|05T,06T,00,07T,08T|09T,10T,00,11T,12T|13T,14T,00,15T,16T|17T,18T,00,19T,20T|21T,22T,00,23T,24T|25T,26T,00,27T,28T|29T,30T,00,31T,32T|BM,00,CA,00,BH'),(2,24,'01T,02T,00,03T|04T,05T,00,06T|07T,08T,00,09T|10T,11T,00,12T|13T,14T,00,15T|16T,17T,00,18T|19T,20T,00,21T|22T,23T,00,24T|BM,00,CA,00,BH'),(3,40,'01T,02,03,04T|05,06,07,08|09,10,11,12|13T,14,15,16T|17,18,19,20|21,22,23,24|25T,26,27,28T|29,30,31,32|33,34,35,36|37,38,39,40|BM,00,CA,00,BH'),(4,40,'01,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16T|17,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,00,00|39,40,00,00,00|CA,00,00,00,BU'),(5,40,'01T,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16|17T,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,39,40|CA,00,00,00,BU'),(6,42,'05,06,00,07,08|09,10,00,11,12T|13,14,00,15,16|17,18,00,19,20|21T,22,00,00,PU|23,24,00,25,26|27,28,00,29,30T|31,32,00,33,34|35,36,00,37,38|39,40,00,00,00|41,42,00,00,00|00,00,00,0C,BU');
/*!40000 ALTER TABLE `distribucionasientos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `factorpaqueteria`
--

LOCK TABLES `factorpaqueteria` WRITE;
/*!40000 ALTER TABLE `factorpaqueteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `factorpaqueteria` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `familiares`
--

LOCK TABLES `familiares` WRITE;
/*!40000 ALTER TABLE `familiares` DISABLE KEYS */;
/*!40000 ALTER TABLE `familiares` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `formapagosubtipo`
--

LOCK TABLES `formapagosubtipo` WRITE;
/*!40000 ALTER TABLE `formapagosubtipo` DISABLE KEYS */;
/*!40000 ALTER TABLE `formapagosubtipo` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `formaspago`
--

LOCK TABLES `formaspago` WRITE;
/*!40000 ALTER TABLE `formaspago` DISABLE KEYS */;
/*!40000 ALTER TABLE `formaspago` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itinerario`
--

LOCK TABLES `itinerario` WRITE;
/*!40000 ALTER TABLE `itinerario` DISABLE KEYS */;
INSERT INTO `itinerario` VALUES (1,1,1),(2,1,1),(3,1,1),(4,1,1),(6,1,1),(2,2,2),(3,2,2),(4,2,2),(6,2,2),(3,3,3),(6,3,3),(11,2,3),(6,4,4),(6,5,5),(6,6,6),(4,3,9),(4,4,10),(5,1,11),(10,1,11),(5,2,12),(5,3,13),(5,4,14),(7,1,16),(8,1,17),(9,1,18),(9,2,19),(10,2,20),(11,1,21),(12,1,27),(12,2,28);
/*!40000 ALTER TABLE `itinerario` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2022_09_23_183212_create_permission_tables',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
INSERT INTO `model_has_permissions` VALUES (1,'App\\Models\\User',2);
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(3,'App\\Models\\User',2);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `oficinas`
--

LOCK TABLES `oficinas` WRITE;
/*!40000 ALTER TABLE `oficinas` DISABLE KEYS */;
INSERT INTO `oficinas` VALUES (1,'APAT','Apatzingán','','int',1,1),(2,'ARTE','Arteaga','','int',1,1),(3,'BUEN','Buenavista','','int',1,1),(4,'COAL','Coalcomán','','int',1,1),(5,'CCAM','Cuatro Caminos','','int',1,1),(6,'IXTA','Ixtapa','','int',1,1),(7,'LCAR','Lázaro Cárdenas','','int',1,1),(8,'MORE','Morelia','','int',1,1),(9,'TEPA','Tepalcatepec','','int',1,1),(10,'URUA','Uruapan','','int',1,1),(11,'ZIHUA','Zihuatanejo','','int',1,1),(12,'PEMO','Pensión morelia','','int',0,1),(13,'INTE','INTERNET','','int',0,1);
/*!40000 ALTER TABLE `oficinas` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `origenesdestinos`
--

LOCK TABLES `origenesdestinos` WRITE;
/*!40000 ALTER TABLE `origenesdestinos` DISABLE KEYS */;
INSERT INTO `origenesdestinos` VALUES (1,3,NULL),(1,4,NULL),(1,5,NULL),(1,8,NULL),(1,9,NULL),(1,10,NULL),(2,5,NULL),(2,8,NULL),(2,10,NULL),(3,1,NULL),(3,4,NULL),(3,5,NULL),(3,8,NULL),(3,9,NULL),(3,10,NULL),(4,1,NULL),(4,3,NULL),(4,5,NULL),(4,8,NULL),(4,9,NULL),(4,10,NULL),(5,1,NULL),(5,2,NULL),(5,3,NULL),(5,4,NULL),(5,6,NULL),(5,7,NULL),(5,8,NULL),(5,9,NULL),(5,10,NULL),(5,11,NULL),(6,5,NULL),(6,8,NULL),(6,10,NULL),(6,11,NULL),(7,1,NULL),(7,5,NULL),(7,8,NULL),(7,10,NULL),(8,1,NULL),(8,2,NULL),(8,3,NULL),(8,4,NULL),(8,5,NULL),(8,6,NULL),(8,7,NULL),(8,9,NULL),(8,10,NULL),(8,11,NULL),(9,1,NULL),(9,3,NULL),(9,4,NULL),(9,5,NULL),(9,8,NULL),(9,10,NULL),(10,1,NULL),(10,2,NULL),(10,3,NULL),(10,5,NULL),(10,4,NULL),(10,6,NULL),(10,7,NULL),(10,8,NULL),(10,9,NULL),(10,11,NULL),(11,5,NULL),(11,6,NULL),(11,8,NULL),(11,10,NULL);
/*!40000 ALTER TABLE `origenesdestinos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'users.index','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(2,'users.store','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(3,'users.edit','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(4,'users.update','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(5,'users.destroy','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(6,'users.addrol','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(7,'users.removerol','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(8,'users.editPermissions','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(9,'personas.update','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(10,'corridas.programadas.index','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(11,'corridas.programadas.store','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(12,'corridas.programadas.show','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(13,'corridas.programadas.destroy','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(14,'corridas.programadas.transfer','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(15,'corridas.programadas.storeTransfer','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(16,'corridas.disponibles.index','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(17,'corridas.disponibles.edit','web','2023-02-01 04:45:20','2023-02-01 04:45:20'),(18,'corridas.disponibles.update','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(19,'corridas.disponibles.puntosDeControl','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(20,'corridas.disponibles.despachar','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(21,'corridas.disponibles.guiaPasajeros','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(22,'boletos.limbo.show','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(23,'personal.conductores.index','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(24,'personal.conductores.edit','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(25,'personal.conductores.update','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(26,'sesionesVenta.create','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(27,'sesionesVenta.update','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(28,'sesionesVenta.show','web','2023-02-01 04:45:21','2023-02-01 04:45:21');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,'Jahaziel Aarón','Aguilera Castillo',12,'EI','2023-01-31','2023-01-31 10:50:50',NULL),(2,'ANGEL','ZAMORA DE JESUS',12,'EI','2023-01-31','2023-01-31 10:50:50',NULL),(3,'FRANCISCO JAVIER','ALVARADO LEMUS',12,'EI','2023-01-31','2023-01-31 10:50:50',NULL),(4,'PASCUAL','ESTEBAN GABRIEL',12,'EI','2023-01-31','2023-01-31 10:50:50',NULL),(5,'JESUS','CORNEJO MAULE',12,NULL,'2023-01-31','2023-01-31 10:50:50',NULL),(6,'sergio','medrano',8,'EI','2023-01-31','2023-01-31 10:50:50',NULL);
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `personas_estados`
--

LOCK TABLES `personas_estados` WRITE;
/*!40000 ALTER TABLE `personas_estados` DISABLE KEYS */;
INSERT INTO `personas_estados` VALUES ('AC','Activo'),('AU','Ausente'),('BA','Proceso de Baja'),('CA','Castigo'),('PE','Permiso');
/*!40000 ALTER TABLE `personas_estados` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
/*!40000 ALTER TABLE `promociones` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `registropasopuntos`
--

LOCK TABLES `registropasopuntos` WRITE;
/*!40000 ALTER TABLE `registropasopuntos` DISABLE KEYS */;
/*!40000 ALTER TABLE `registropasopuntos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (1,1),(2,1),(3,1),(3,2),(3,3),(4,1),(4,2),(4,3),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(10,3),(11,1),(11,3),(12,1),(12,3),(13,1),(13,3),(14,1),(14,3),(15,1),(15,3),(16,1),(16,3),(17,1),(17,3),(18,1),(18,3),(19,1),(20,1),(21,1),(22,1),(23,1),(23,3),(24,1),(24,3),(25,1),(25,3),(26,1),(27,1),(28,1);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(2,'publicoGeneral','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(3,'servicios','web','2023-02-01 04:45:21','2023-02-01 04:45:21'),(4,'conductor','web','2023-02-01 04:45:21','2023-02-01 04:45:21');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
INSERT INTO `sesiones` VALUES (11,1,8,0.00,'0000-00-00',NULL,'2023-01-31 00:00:00','2023-01-31 00:00:00');
/*!40000 ALTER TABLE `sesiones` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  KEY `nTipoServicio` (`nTipoServicio`),
  CONSTRAINT `tarifastramos_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `tarifastramos_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `tarifastramos_ibfk_3` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifastramos`
--

LOCK TABLES `tarifastramos` WRITE;
/*!40000 ALTER TABLE `tarifastramos` DISABLE KEYS */;
INSERT INTO `tarifastramos` VALUES (17,1,8,10,333.00,320.00,'2023-02-01'),(18,2,8,10,333.00,320.00,'2023-02-01');
/*!40000 ALTER TABLE `tarifastramos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tarjetasboletinadas`
--

LOCK TABLES `tarjetasboletinadas` WRITE;
/*!40000 ALTER TABLE `tarjetasboletinadas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarjetasboletinadas` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminales`
--

LOCK TABLES `terminales` WRITE;
/*!40000 ALTER TABLE `terminales` DISABLE KEYS */;
INSERT INTO `terminales` VALUES (3,'DTI',12,'para pruebas'),(4,'Venta sitio web',13,'parhikuni.com');
/*!40000 ALTER TABLE `terminales` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tipopaquetes`
--

LOCK TABLES `tipopaquetes` WRITE;
/*!40000 ALTER TABLE `tipopaquetes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipopaquetes` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tipopasajero`
--

LOCK TABLES `tipopasajero` WRITE;
/*!40000 ALTER TABLE `tipopasajero` DISABLE KEYS */;
INSERT INTO `tipopasajero` VALUES ('AD','Adulto',0),('ES','Estudiante',0),('IN','Insen',0),('MA','Maestro',0),('NI','Niño',0),('PQ','Paquetería',0),('SE','SEDENA',0);
/*!40000 ALTER TABLE `tipopasajero` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tiposboletos`
--

LOCK TABLES `tiposboletos` WRITE;
/*!40000 ALTER TABLE `tiposboletos` DISABLE KEYS */;
INSERT INTO `tiposboletos` VALUES (1,'V','Venta',1000),(2,'P','Paqueteria',150),(3,'E','Exceso equipaje',0),(4,'G','Guarda equipaje',0),(5,'M','Manual',100);
/*!40000 ALTER TABLE `tiposboletos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tiposervicio`
--

LOCK TABLES `tiposervicio` WRITE;
/*!40000 ALTER TABLE `tiposervicio` DISABLE KEYS */;
INSERT INTO `tiposervicio` VALUES (1,'PL','Platinum',2,8,0),(2,'UL','Ultra',3,7,0),(3,'EX','Express',4,6,0),(4,'PC','Premium Class',5,6,0),(5,'CP','Business Class',5,7,0);
/*!40000 ALTER TABLE `tiposervicio` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tipospersona`
--

LOCK TABLES `tipospersona` WRITE;
/*!40000 ALTER TABLE `tipospersona` DISABLE KEYS */;
INSERT INTO `tipospersona` VALUES ('EI','Empleado interno'),('FA','Familiar'),('PA','Personal Agencias de Vaje'),('PE','Personal Externo'),('PG','Público general'),('SO','Socio');
/*!40000 ALTER TABLE `tipospersona` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tipoventa`
--

LOCK TABLES `tipoventa` WRITE;
/*!40000 ALTER TABLE `tipoventa` DISABLE KEYS */;
INSERT INTO `tipoventa` VALUES ('AB','Boleto abierto',1),('AP','Abono paquetería',2),('BA','Boleto de agencia',1),('BI','Boleto de internet',1),('BW','Boleto webservice',1),('CO','Boleto confirmado',1),('EE','Exceso de Equipaje',3),('GE','Guarda Equipaje',4),('MA','Boleto manual',5),('PC','Paquetería comercial',2),('PI','Paquetería interna',2);
/*!40000 ALTER TABLE `tipoventa` ENABLE KEYS */;
UNLOCK TABLES;

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
  `deleted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  KEY `tramos_IN` (`nNumero`,`nOrigen`,`nDestino`),
  CONSTRAINT `tramos_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `tramos_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramos`
--

LOCK TABLES `tramos` WRITE;
/*!40000 ALTER TABLE `tramos` DISABLE KEYS */;
INSERT INTO `tramos` VALUES (1,8,10,112,90,10,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(2,10,5,0,0,0,'2023-01-31 22:19:14','2023-02-02 22:54:34','2023-01-31 22:19:14'),(3,5,1,30,30,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(4,1,3,0,0,0,'2023-01-31 22:19:14','2023-02-02 04:09:39','2023-01-31 22:19:14'),(5,3,9,34,40,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(6,9,4,73,80,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(7,5,2,130,130,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(8,5,7,166,120,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(9,5,6,200,140,15,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(10,6,11,9,20,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(11,11,6,9,20,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(12,6,5,200,140,15,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(13,5,10,58,70,10,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(14,10,8,112,90,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(16,8,7,316,255,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(17,7,8,316,255,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(18,8,6,346,280,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(19,6,11,5,20,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(20,6,8,346,280,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(21,8,5,158,75,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(22,1,8,188,165,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14'),(27,1,5,30,30,0,'2023-01-31 22:19:14','2023-02-01 04:24:36','2023-01-31 22:19:14'),(28,5,8,158,75,0,'2023-01-31 22:19:14','2023-01-31 22:19:14','2023-01-31 22:19:14');
/*!40000 ALTER TABLE `tramos` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `FK_p` FOREIGN KEY (`persona_nNumero`) REFERENCES `personas` (`nNumeroPersona`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'DTI sistemas','dti_parhikuni@parhikuni.com.mx',NULL,'$2y$10$FTh.EgSEpZewH0CIYA7KbeBlAj3y1souZ9q2GogI04jZXD5cm.I7q',NULL,'2023-02-01 04:45:21','2023-02-01 04:45:21',NULL,1),(2,'Sergio Medrano','sergio.medrano@parhikuni.com.mx',NULL,'$2y$10$qo.O/l.j8lbthN.4fMQereqvPHE//eAIFRQUtS4VlB1JM.FwKme/e',NULL,'2023-02-01 04:45:21','2023-02-01 04:45:21',NULL,2),(3,'Dino McCullough','plangworth@example.org','2023-02-01 04:45:21','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','aY6G4tjopW','2023-02-01 04:45:21','2023-02-01 04:45:21',NULL,NULL),(4,'Mrs. Ramona O\'Conner','qhaley@example.net','2023-02-01 04:45:21','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','3fgXDDozmX','2023-02-01 04:45:21','2023-02-01 04:45:21',NULL,NULL),(5,'Maud Bogisich Jr.','oberbrunner.neil@example.net','2023-02-01 04:45:21','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','PnaYkW1asa','2023-02-01 04:45:21','2023-02-01 04:45:21',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventapago`
--

LOCK TABLES `ventapago` WRITE;
/*!40000 ALTER TABLE `ventapago` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventapago` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `ventascliente`
--

LOCK TABLES `ventascliente` WRITE;
/*!40000 ALTER TABLE `ventascliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventascliente` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2023-02-02 12:53:48
