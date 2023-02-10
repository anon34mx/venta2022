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
INSERT INTO `conductores` VALUES (1,2,'LIC007','2025-10-11','AC',74,'2023-02-07 16:48:30',NULL,NULL),(2,3,'LIC084','2028-03-08','AC',102,'2023-02-07 16:48:30',NULL,NULL),(3,4,'LIC026','2025-07-26','BA',112,'2023-02-07 16:48:30',NULL,NULL);
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
  CONSTRAINT `corridas_disponibles_historial_ibfk_7` FOREIGN KEY (`nNumeroOficina`) REFERENCES `oficinas` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_disponibles_historial_ibfk_8` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON UPDATE CASCADE
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
  CONSTRAINT `corridas_versiones_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_versiones_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=443 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasdisponibles`
--

LOCK TABLES `corridasdisponibles` WRITE;
/*!40000 ALTER TABLE `corridasdisponibles` DISABLE KEYS */;
INSERT INTO `corridasdisponibles` VALUES (319,11,1,1,'2023-02-08','11:00:00','C',122,NULL,NULL,NULL,NULL),(320,11,1,1,'2023-02-09','11:00:00','C',122,NULL,NULL,NULL,NULL),(321,11,1,1,'2023-02-10','11:00:00','C',122,NULL,NULL,NULL,NULL),(322,11,1,1,'2023-02-11','11:00:00','C',122,NULL,NULL,NULL,NULL),(323,11,1,1,'2023-02-12','11:00:00','C',122,NULL,NULL,NULL,NULL),(324,11,1,1,'2023-02-13','11:00:00','C',122,NULL,NULL,NULL,NULL),(325,11,1,1,'2023-02-14','11:00:00','C',122,NULL,NULL,NULL,NULL),(326,11,1,1,'2023-02-15','11:00:00','C',122,NULL,NULL,NULL,NULL),(327,11,1,1,'2023-02-16','11:00:00','C',122,NULL,NULL,NULL,NULL),(328,11,1,1,'2023-02-17','11:00:00','C',122,NULL,NULL,NULL,NULL),(329,11,1,1,'2023-02-18','11:00:00','C',122,NULL,NULL,NULL,NULL),(330,11,1,1,'2023-02-19','11:00:00','C',122,NULL,NULL,NULL,NULL),(331,11,1,1,'2023-02-20','11:00:00','C',122,NULL,NULL,NULL,NULL),(332,11,1,1,'2023-02-21','11:00:00','C',122,NULL,NULL,NULL,NULL),(333,11,1,1,'2023-02-22','11:00:00','C',122,NULL,NULL,NULL,NULL),(334,11,1,1,'2023-02-23','11:00:00','C',122,NULL,NULL,NULL,NULL),(335,11,1,1,'2023-02-24','11:00:00','C',122,NULL,NULL,NULL,NULL),(336,11,1,1,'2023-02-25','11:00:00','C',122,NULL,NULL,NULL,NULL),(337,11,1,1,'2023-02-26','11:00:00','C',122,NULL,NULL,NULL,NULL),(338,11,1,1,'2023-02-27','11:00:00','C',122,NULL,NULL,NULL,NULL),(339,11,1,1,'2023-02-28','11:00:00','C',122,NULL,NULL,NULL,NULL),(340,11,1,1,'2023-03-01','11:00:00','C',122,NULL,NULL,NULL,NULL),(341,11,1,1,'2023-03-02','11:00:00','C',122,NULL,NULL,NULL,NULL),(342,11,1,1,'2023-03-03','11:00:00','C',122,NULL,NULL,NULL,NULL),(343,11,1,1,'2023-03-04','11:00:00','C',122,NULL,NULL,NULL,NULL),(344,11,1,1,'2023-03-05','11:00:00','C',122,NULL,NULL,NULL,NULL),(345,11,1,1,'2023-03-06','11:00:00','C',122,NULL,NULL,NULL,NULL),(346,11,1,1,'2023-03-07','11:00:00','C',122,NULL,NULL,NULL,NULL),(347,11,1,1,'2023-03-08','11:00:00','C',122,NULL,NULL,NULL,NULL),(348,11,1,1,'2023-03-09','11:00:00','C',122,NULL,NULL,NULL,NULL),(349,11,1,1,'2023-03-10','11:00:00','C',122,NULL,NULL,NULL,NULL),(350,12,1,1,'2023-02-08','11:00:00','C',122,NULL,NULL,NULL,NULL),(351,12,1,1,'2023-02-09','11:00:00','C',122,NULL,NULL,NULL,NULL),(352,12,1,1,'2023-02-10','11:00:00','C',122,NULL,NULL,NULL,NULL),(353,12,1,1,'2023-02-11','11:00:00','C',122,NULL,NULL,NULL,NULL),(354,12,1,1,'2023-02-12','11:00:00','C',122,NULL,NULL,NULL,NULL),(355,12,1,1,'2023-02-13','11:00:00','C',122,NULL,NULL,NULL,NULL),(356,12,1,1,'2023-02-14','11:00:00','C',122,NULL,NULL,NULL,NULL),(357,12,1,1,'2023-02-15','11:00:00','C',122,NULL,NULL,NULL,NULL),(358,12,1,1,'2023-02-16','11:00:00','C',122,NULL,NULL,NULL,NULL),(359,12,1,1,'2023-02-17','11:00:00','C',122,NULL,NULL,NULL,NULL),(360,12,1,1,'2023-02-18','11:00:00','C',122,NULL,NULL,NULL,NULL),(361,12,1,1,'2023-02-19','11:00:00','C',122,NULL,NULL,NULL,NULL),(362,12,1,1,'2023-02-20','11:00:00','C',122,NULL,NULL,NULL,NULL),(363,12,1,1,'2023-02-21','11:00:00','C',122,NULL,NULL,NULL,NULL),(364,12,1,1,'2023-02-22','11:00:00','C',122,NULL,NULL,NULL,NULL),(365,12,1,1,'2023-02-23','11:00:00','C',122,NULL,NULL,NULL,NULL),(366,12,1,1,'2023-02-24','11:00:00','C',122,NULL,NULL,NULL,NULL),(367,12,1,1,'2023-02-25','11:00:00','C',122,NULL,NULL,NULL,NULL),(368,12,1,1,'2023-02-26','11:00:00','C',122,NULL,NULL,NULL,NULL),(369,12,1,1,'2023-02-27','11:00:00','C',122,NULL,NULL,NULL,NULL),(370,12,1,1,'2023-02-28','11:00:00','C',122,NULL,NULL,NULL,NULL),(371,12,1,1,'2023-03-01','11:00:00','C',122,NULL,NULL,NULL,NULL),(372,12,1,1,'2023-03-02','11:00:00','C',122,NULL,NULL,NULL,NULL),(373,12,1,1,'2023-03-03','11:00:00','C',122,NULL,NULL,NULL,NULL),(374,12,1,1,'2023-03-04','11:00:00','C',122,NULL,NULL,NULL,NULL),(375,12,1,1,'2023-03-05','11:00:00','C',122,NULL,NULL,NULL,NULL),(376,12,1,1,'2023-03-06','11:00:00','C',122,NULL,NULL,NULL,NULL),(377,12,1,1,'2023-03-07','11:00:00','C',122,NULL,NULL,NULL,NULL),(378,12,1,1,'2023-03-08','11:00:00','C',122,NULL,NULL,NULL,NULL),(379,12,1,1,'2023-03-09','11:00:00','C',122,NULL,NULL,NULL,NULL),(380,12,1,1,'2023-03-10','11:00:00','C',122,NULL,NULL,NULL,NULL),(381,13,1,1,'2023-02-08','11:00:00','C',122,NULL,NULL,NULL,NULL),(382,13,1,1,'2023-02-09','11:00:00','C',122,NULL,NULL,NULL,NULL),(383,13,1,1,'2023-02-10','11:00:00','C',122,NULL,NULL,NULL,NULL),(384,13,1,1,'2023-02-11','11:00:00','C',122,NULL,NULL,NULL,NULL),(385,13,1,1,'2023-02-12','11:00:00','C',122,NULL,NULL,NULL,NULL),(386,13,1,1,'2023-02-13','11:00:00','C',122,NULL,NULL,NULL,NULL),(387,13,1,1,'2023-02-14','11:00:00','C',122,NULL,NULL,NULL,NULL),(388,13,1,1,'2023-02-15','11:00:00','C',122,NULL,NULL,NULL,NULL),(389,13,1,1,'2023-02-16','11:00:00','C',122,NULL,NULL,NULL,NULL),(390,13,1,1,'2023-02-17','11:00:00','C',122,NULL,NULL,NULL,NULL),(391,13,1,1,'2023-02-18','11:00:00','C',122,NULL,NULL,NULL,NULL),(392,13,1,1,'2023-02-19','11:00:00','C',122,NULL,NULL,NULL,NULL),(393,13,1,1,'2023-02-20','11:00:00','C',122,NULL,NULL,NULL,NULL),(394,13,1,1,'2023-02-21','11:00:00','C',122,NULL,NULL,NULL,NULL),(395,13,1,1,'2023-02-22','11:00:00','C',122,NULL,NULL,NULL,NULL),(396,13,1,1,'2023-02-23','11:00:00','C',122,NULL,NULL,NULL,NULL),(397,13,1,1,'2023-02-24','11:00:00','C',122,NULL,NULL,NULL,NULL),(398,13,1,1,'2023-02-25','11:00:00','C',122,NULL,NULL,NULL,NULL),(399,13,1,1,'2023-02-26','11:00:00','C',122,NULL,NULL,NULL,NULL),(400,13,1,1,'2023-02-27','11:00:00','C',122,NULL,NULL,NULL,NULL),(401,13,1,1,'2023-02-28','11:00:00','C',122,NULL,NULL,NULL,NULL),(402,13,1,1,'2023-03-01','11:00:00','C',122,NULL,NULL,NULL,NULL),(403,13,1,1,'2023-03-02','11:00:00','C',122,NULL,NULL,NULL,NULL),(404,13,1,1,'2023-03-03','11:00:00','C',122,NULL,NULL,NULL,NULL),(405,13,1,1,'2023-03-04','11:00:00','C',122,NULL,NULL,NULL,NULL),(406,13,1,1,'2023-03-05','11:00:00','C',122,NULL,NULL,NULL,NULL),(407,13,1,1,'2023-03-06','11:00:00','C',122,NULL,NULL,NULL,NULL),(408,13,1,1,'2023-03-07','11:00:00','C',122,NULL,NULL,NULL,NULL),(409,13,1,1,'2023-03-08','11:00:00','C',122,NULL,NULL,NULL,NULL),(410,13,1,1,'2023-03-09','11:00:00','C',122,NULL,NULL,NULL,NULL),(411,13,1,1,'2023-03-10','11:00:00','C',122,NULL,NULL,NULL,NULL),(412,14,1,1,'2023-02-08','11:00:00','D',122,NULL,NULL,NULL,NULL),(413,14,1,1,'2023-02-09','11:00:00','D',122,NULL,NULL,NULL,NULL),(414,14,1,1,'2023-02-10','11:00:00','D',122,NULL,NULL,NULL,NULL),(415,14,1,1,'2023-02-11','11:00:00','D',122,NULL,NULL,NULL,NULL),(416,14,1,1,'2023-02-12','11:00:00','D',122,NULL,NULL,NULL,NULL),(417,14,1,1,'2023-02-13','11:00:00','D',122,NULL,NULL,NULL,NULL),(418,14,1,1,'2023-02-14','11:00:00','D',122,NULL,NULL,NULL,NULL),(419,14,1,1,'2023-02-15','11:00:00','D',122,NULL,NULL,NULL,NULL),(420,14,1,1,'2023-02-16','11:00:00','D',122,NULL,NULL,NULL,NULL),(421,14,1,1,'2023-02-17','11:00:00','D',122,NULL,NULL,NULL,NULL),(422,14,1,1,'2023-02-18','11:00:00','D',122,NULL,NULL,NULL,NULL),(423,14,1,1,'2023-02-19','11:00:00','D',122,NULL,NULL,NULL,NULL),(424,14,1,1,'2023-02-20','11:00:00','D',122,NULL,NULL,NULL,NULL),(425,14,1,1,'2023-02-21','11:00:00','D',122,NULL,NULL,NULL,NULL),(426,14,1,1,'2023-02-22','11:00:00','D',122,NULL,NULL,NULL,NULL),(427,14,1,1,'2023-02-23','11:00:00','D',122,NULL,NULL,NULL,NULL),(428,14,1,1,'2023-02-24','11:00:00','D',122,NULL,NULL,NULL,NULL),(429,14,1,1,'2023-02-25','11:00:00','D',122,NULL,NULL,NULL,NULL),(430,14,1,1,'2023-02-26','11:00:00','D',122,NULL,NULL,NULL,NULL),(431,14,1,1,'2023-02-27','11:00:00','D',122,NULL,NULL,NULL,NULL),(432,14,1,1,'2023-02-28','11:00:00','D',122,NULL,NULL,NULL,NULL),(433,14,1,1,'2023-03-01','11:00:00','D',122,NULL,NULL,NULL,NULL),(434,14,1,1,'2023-03-02','11:00:00','D',122,NULL,NULL,NULL,NULL),(435,14,1,1,'2023-03-03','11:00:00','D',122,NULL,NULL,NULL,NULL),(436,14,1,1,'2023-03-04','11:00:00','D',122,NULL,NULL,NULL,NULL),(437,14,1,1,'2023-03-05','11:00:00','D',122,NULL,NULL,NULL,NULL),(438,14,1,1,'2023-03-06','11:00:00','D',122,NULL,NULL,NULL,NULL),(439,14,1,1,'2023-03-07','11:00:00','D',122,NULL,NULL,NULL,NULL),(440,14,1,1,'2023-03-08','11:00:00','D',122,NULL,NULL,NULL,NULL),(441,14,1,1,'2023-03-09','11:00:00','D',122,NULL,NULL,NULL,NULL),(442,14,1,1,'2023-03-10','11:00:00','D',122,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasprogramadas`
--

LOCK TABLES `corridasprogramadas` WRITE;
/*!40000 ALTER TABLE `corridasprogramadas` DISABLE KEYS */;
INSERT INTO `corridasprogramadas` VALUES (11,1,1,'11:00:00',1,1,1,1,1,1,1,'2023-02-08','9999-02-08',1,'2023-02-08 16:18:11','2023-02-08 22:18:11','2023-02-08 15:44:04'),(12,1,1,'11:00:00',1,1,1,1,1,1,1,'2023-02-08','9999-02-08',1,'2023-02-08 16:18:14','2023-02-08 22:18:14','2023-02-08 15:51:50'),(13,1,1,'11:00:00',1,1,1,1,1,1,1,'2023-02-08','9999-02-08',1,'2023-02-08 16:18:16','2023-02-08 22:18:16','2023-02-08 15:52:42'),(14,1,1,'11:00:00',1,1,1,1,1,1,1,'2023-02-08','2099-02-08',1,NULL,'2023-02-08 22:18:43','2023-02-08 16:18:43');
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
) ENGINE=InnoDB AUTO_INCREMENT=2390 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidad`
--

LOCK TABLES `disponibilidad` WRITE;
/*!40000 ALTER TABLE `disponibilidad` DISABLE KEYS */;
INSERT INTO `disponibilidad` VALUES (2018,319,8,6,'2023-02-08','15:40:00','2023-02-08','11:00:00'),(2019,319,8,11,'2023-02-08','16:00:00','2023-02-08','11:00:00'),(2020,319,6,11,'2023-02-08','16:00:00','2023-02-08','15:40:00'),(2021,320,8,6,'2023-02-09','15:40:00','2023-02-09','11:00:00'),(2022,320,8,11,'2023-02-09','16:00:00','2023-02-09','11:00:00'),(2023,320,6,11,'2023-02-09','16:00:00','2023-02-09','15:40:00'),(2024,321,8,6,'2023-02-10','15:40:00','2023-02-10','11:00:00'),(2025,321,8,11,'2023-02-10','16:00:00','2023-02-10','11:00:00'),(2026,321,6,11,'2023-02-10','16:00:00','2023-02-10','15:40:00'),(2027,322,8,6,'2023-02-11','15:40:00','2023-02-11','11:00:00'),(2028,322,8,11,'2023-02-11','16:00:00','2023-02-11','11:00:00'),(2029,322,6,11,'2023-02-11','16:00:00','2023-02-11','15:40:00'),(2030,323,8,6,'2023-02-12','15:40:00','2023-02-12','11:00:00'),(2031,323,8,11,'2023-02-12','16:00:00','2023-02-12','11:00:00'),(2032,323,6,11,'2023-02-12','16:00:00','2023-02-12','15:40:00'),(2033,324,8,6,'2023-02-13','15:40:00','2023-02-13','11:00:00'),(2034,324,8,11,'2023-02-13','16:00:00','2023-02-13','11:00:00'),(2035,324,6,11,'2023-02-13','16:00:00','2023-02-13','15:40:00'),(2036,325,8,6,'2023-02-14','15:40:00','2023-02-14','11:00:00'),(2037,325,8,11,'2023-02-14','16:00:00','2023-02-14','11:00:00'),(2038,325,6,11,'2023-02-14','16:00:00','2023-02-14','15:40:00'),(2039,326,8,6,'2023-02-15','15:40:00','2023-02-15','11:00:00'),(2040,326,8,11,'2023-02-15','16:00:00','2023-02-15','11:00:00'),(2041,326,6,11,'2023-02-15','16:00:00','2023-02-15','15:40:00'),(2042,327,8,6,'2023-02-16','15:40:00','2023-02-16','11:00:00'),(2043,327,8,11,'2023-02-16','16:00:00','2023-02-16','11:00:00'),(2044,327,6,11,'2023-02-16','16:00:00','2023-02-16','15:40:00'),(2045,328,8,6,'2023-02-17','15:40:00','2023-02-17','11:00:00'),(2046,328,8,11,'2023-02-17','16:00:00','2023-02-17','11:00:00'),(2047,328,6,11,'2023-02-17','16:00:00','2023-02-17','15:40:00'),(2048,329,8,6,'2023-02-18','15:40:00','2023-02-18','11:00:00'),(2049,329,8,11,'2023-02-18','16:00:00','2023-02-18','11:00:00'),(2050,329,6,11,'2023-02-18','16:00:00','2023-02-18','15:40:00'),(2051,330,8,6,'2023-02-19','15:40:00','2023-02-19','11:00:00'),(2052,330,8,11,'2023-02-19','16:00:00','2023-02-19','11:00:00'),(2053,330,6,11,'2023-02-19','16:00:00','2023-02-19','15:40:00'),(2054,331,8,6,'2023-02-20','15:40:00','2023-02-20','11:00:00'),(2055,331,8,11,'2023-02-20','16:00:00','2023-02-20','11:00:00'),(2056,331,6,11,'2023-02-20','16:00:00','2023-02-20','15:40:00'),(2057,332,8,6,'2023-02-21','15:40:00','2023-02-21','11:00:00'),(2058,332,8,11,'2023-02-21','16:00:00','2023-02-21','11:00:00'),(2059,332,6,11,'2023-02-21','16:00:00','2023-02-21','15:40:00'),(2060,333,8,6,'2023-02-22','15:40:00','2023-02-22','11:00:00'),(2061,333,8,11,'2023-02-22','16:00:00','2023-02-22','11:00:00'),(2062,333,6,11,'2023-02-22','16:00:00','2023-02-22','15:40:00'),(2063,334,8,6,'2023-02-23','15:40:00','2023-02-23','11:00:00'),(2064,334,8,11,'2023-02-23','16:00:00','2023-02-23','11:00:00'),(2065,334,6,11,'2023-02-23','16:00:00','2023-02-23','15:40:00'),(2066,335,8,6,'2023-02-24','15:40:00','2023-02-24','11:00:00'),(2067,335,8,11,'2023-02-24','16:00:00','2023-02-24','11:00:00'),(2068,335,6,11,'2023-02-24','16:00:00','2023-02-24','15:40:00'),(2069,336,8,6,'2023-02-25','15:40:00','2023-02-25','11:00:00'),(2070,336,8,11,'2023-02-25','16:00:00','2023-02-25','11:00:00'),(2071,336,6,11,'2023-02-25','16:00:00','2023-02-25','15:40:00'),(2072,337,8,6,'2023-02-26','15:40:00','2023-02-26','11:00:00'),(2073,337,8,11,'2023-02-26','16:00:00','2023-02-26','11:00:00'),(2074,337,6,11,'2023-02-26','16:00:00','2023-02-26','15:40:00'),(2075,338,8,6,'2023-02-27','15:40:00','2023-02-27','11:00:00'),(2076,338,8,11,'2023-02-27','16:00:00','2023-02-27','11:00:00'),(2077,338,6,11,'2023-02-27','16:00:00','2023-02-27','15:40:00'),(2078,339,8,6,'2023-02-28','15:40:00','2023-02-28','11:00:00'),(2079,339,8,11,'2023-02-28','16:00:00','2023-02-28','11:00:00'),(2080,339,6,11,'2023-02-28','16:00:00','2023-02-28','15:40:00'),(2081,340,8,6,'2023-03-01','15:40:00','2023-03-01','11:00:00'),(2082,340,8,11,'2023-03-01','16:00:00','2023-03-01','11:00:00'),(2083,340,6,11,'2023-03-01','16:00:00','2023-03-01','15:40:00'),(2084,341,8,6,'2023-03-02','15:40:00','2023-03-02','11:00:00'),(2085,341,8,11,'2023-03-02','16:00:00','2023-03-02','11:00:00'),(2086,341,6,11,'2023-03-02','16:00:00','2023-03-02','15:40:00'),(2087,342,8,6,'2023-03-03','15:40:00','2023-03-03','11:00:00'),(2088,342,8,11,'2023-03-03','16:00:00','2023-03-03','11:00:00'),(2089,342,6,11,'2023-03-03','16:00:00','2023-03-03','15:40:00'),(2090,343,8,6,'2023-03-04','15:40:00','2023-03-04','11:00:00'),(2091,343,8,11,'2023-03-04','16:00:00','2023-03-04','11:00:00'),(2092,343,6,11,'2023-03-04','16:00:00','2023-03-04','15:40:00'),(2093,344,8,6,'2023-03-05','15:40:00','2023-03-05','11:00:00'),(2094,344,8,11,'2023-03-05','16:00:00','2023-03-05','11:00:00'),(2095,344,6,11,'2023-03-05','16:00:00','2023-03-05','15:40:00'),(2096,345,8,6,'2023-03-06','15:40:00','2023-03-06','11:00:00'),(2097,345,8,11,'2023-03-06','16:00:00','2023-03-06','11:00:00'),(2098,345,6,11,'2023-03-06','16:00:00','2023-03-06','15:40:00'),(2099,346,8,6,'2023-03-07','15:40:00','2023-03-07','11:00:00'),(2100,346,8,11,'2023-03-07','16:00:00','2023-03-07','11:00:00'),(2101,346,6,11,'2023-03-07','16:00:00','2023-03-07','15:40:00'),(2102,347,8,6,'2023-03-08','15:40:00','2023-03-08','11:00:00'),(2103,347,8,11,'2023-03-08','16:00:00','2023-03-08','11:00:00'),(2104,347,6,11,'2023-03-08','16:00:00','2023-03-08','15:40:00'),(2105,348,8,6,'2023-03-09','15:40:00','2023-03-09','11:00:00'),(2106,348,8,11,'2023-03-09','16:00:00','2023-03-09','11:00:00'),(2107,348,6,11,'2023-03-09','16:00:00','2023-03-09','15:40:00'),(2108,349,8,6,'2023-03-10','15:40:00','2023-03-10','11:00:00'),(2109,349,8,11,'2023-03-10','16:00:00','2023-03-10','11:00:00'),(2110,349,6,11,'2023-03-10','16:00:00','2023-03-10','15:40:00'),(2111,350,8,6,'2023-02-08','15:40:00','2023-02-08','11:00:00'),(2112,350,8,11,'2023-02-08','16:00:00','2023-02-08','11:00:00'),(2113,350,6,11,'2023-02-08','16:00:00','2023-02-08','15:55:00'),(2114,351,8,6,'2023-02-09','15:40:00','2023-02-09','11:00:00'),(2115,351,8,11,'2023-02-09','16:00:00','2023-02-09','11:00:00'),(2116,351,6,11,'2023-02-09','16:00:00','2023-02-09','15:55:00'),(2117,352,8,6,'2023-02-10','15:40:00','2023-02-10','11:00:00'),(2118,352,8,11,'2023-02-10','16:00:00','2023-02-10','11:00:00'),(2119,352,6,11,'2023-02-10','16:00:00','2023-02-10','15:55:00'),(2120,353,8,6,'2023-02-11','15:40:00','2023-02-11','11:00:00'),(2121,353,8,11,'2023-02-11','16:00:00','2023-02-11','11:00:00'),(2122,353,6,11,'2023-02-11','16:00:00','2023-02-11','15:55:00'),(2123,354,8,6,'2023-02-12','15:40:00','2023-02-12','11:00:00'),(2124,354,8,11,'2023-02-12','16:00:00','2023-02-12','11:00:00'),(2125,354,6,11,'2023-02-12','16:00:00','2023-02-12','15:55:00'),(2126,355,8,6,'2023-02-13','15:40:00','2023-02-13','11:00:00'),(2127,355,8,11,'2023-02-13','16:00:00','2023-02-13','11:00:00'),(2128,355,6,11,'2023-02-13','16:00:00','2023-02-13','15:55:00'),(2129,356,8,6,'2023-02-14','15:40:00','2023-02-14','11:00:00'),(2130,356,8,11,'2023-02-14','16:00:00','2023-02-14','11:00:00'),(2131,356,6,11,'2023-02-14','16:00:00','2023-02-14','15:55:00'),(2132,357,8,6,'2023-02-15','15:40:00','2023-02-15','11:00:00'),(2133,357,8,11,'2023-02-15','16:00:00','2023-02-15','11:00:00'),(2134,357,6,11,'2023-02-15','16:00:00','2023-02-15','15:55:00'),(2135,358,8,6,'2023-02-16','15:40:00','2023-02-16','11:00:00'),(2136,358,8,11,'2023-02-16','16:00:00','2023-02-16','11:00:00'),(2137,358,6,11,'2023-02-16','16:00:00','2023-02-16','15:55:00'),(2138,359,8,6,'2023-02-17','15:40:00','2023-02-17','11:00:00'),(2139,359,8,11,'2023-02-17','16:00:00','2023-02-17','11:00:00'),(2140,359,6,11,'2023-02-17','16:00:00','2023-02-17','15:55:00'),(2141,360,8,6,'2023-02-18','15:40:00','2023-02-18','11:00:00'),(2142,360,8,11,'2023-02-18','16:00:00','2023-02-18','11:00:00'),(2143,360,6,11,'2023-02-18','16:00:00','2023-02-18','15:55:00'),(2144,361,8,6,'2023-02-19','15:40:00','2023-02-19','11:00:00'),(2145,361,8,11,'2023-02-19','16:00:00','2023-02-19','11:00:00'),(2146,361,6,11,'2023-02-19','16:00:00','2023-02-19','15:55:00'),(2147,362,8,6,'2023-02-20','15:40:00','2023-02-20','11:00:00'),(2148,362,8,11,'2023-02-20','16:00:00','2023-02-20','11:00:00'),(2149,362,6,11,'2023-02-20','16:00:00','2023-02-20','15:55:00'),(2150,363,8,6,'2023-02-21','15:40:00','2023-02-21','11:00:00'),(2151,363,8,11,'2023-02-21','16:00:00','2023-02-21','11:00:00'),(2152,363,6,11,'2023-02-21','16:00:00','2023-02-21','15:55:00'),(2153,364,8,6,'2023-02-22','15:40:00','2023-02-22','11:00:00'),(2154,364,8,11,'2023-02-22','16:00:00','2023-02-22','11:00:00'),(2155,364,6,11,'2023-02-22','16:00:00','2023-02-22','15:55:00'),(2156,365,8,6,'2023-02-23','15:40:00','2023-02-23','11:00:00'),(2157,365,8,11,'2023-02-23','16:00:00','2023-02-23','11:00:00'),(2158,365,6,11,'2023-02-23','16:00:00','2023-02-23','15:55:00'),(2159,366,8,6,'2023-02-24','15:40:00','2023-02-24','11:00:00'),(2160,366,8,11,'2023-02-24','16:00:00','2023-02-24','11:00:00'),(2161,366,6,11,'2023-02-24','16:00:00','2023-02-24','15:55:00'),(2162,367,8,6,'2023-02-25','15:40:00','2023-02-25','11:00:00'),(2163,367,8,11,'2023-02-25','16:00:00','2023-02-25','11:00:00'),(2164,367,6,11,'2023-02-25','16:00:00','2023-02-25','15:55:00'),(2165,368,8,6,'2023-02-26','15:40:00','2023-02-26','11:00:00'),(2166,368,8,11,'2023-02-26','16:00:00','2023-02-26','11:00:00'),(2167,368,6,11,'2023-02-26','16:00:00','2023-02-26','15:55:00'),(2168,369,8,6,'2023-02-27','15:40:00','2023-02-27','11:00:00'),(2169,369,8,11,'2023-02-27','16:00:00','2023-02-27','11:00:00'),(2170,369,6,11,'2023-02-27','16:00:00','2023-02-27','15:55:00'),(2171,370,8,6,'2023-02-28','15:40:00','2023-02-28','11:00:00'),(2172,370,8,11,'2023-02-28','16:00:00','2023-02-28','11:00:00'),(2173,370,6,11,'2023-02-28','16:00:00','2023-02-28','15:55:00'),(2174,371,8,6,'2023-03-01','15:40:00','2023-03-01','11:00:00'),(2175,371,8,11,'2023-03-01','16:00:00','2023-03-01','11:00:00'),(2176,371,6,11,'2023-03-01','16:00:00','2023-03-01','15:55:00'),(2177,372,8,6,'2023-03-02','15:40:00','2023-03-02','11:00:00'),(2178,372,8,11,'2023-03-02','16:00:00','2023-03-02','11:00:00'),(2179,372,6,11,'2023-03-02','16:00:00','2023-03-02','15:55:00'),(2180,373,8,6,'2023-03-03','15:40:00','2023-03-03','11:00:00'),(2181,373,8,11,'2023-03-03','16:00:00','2023-03-03','11:00:00'),(2182,373,6,11,'2023-03-03','16:00:00','2023-03-03','15:55:00'),(2183,374,8,6,'2023-03-04','15:40:00','2023-03-04','11:00:00'),(2184,374,8,11,'2023-03-04','16:00:00','2023-03-04','11:00:00'),(2185,374,6,11,'2023-03-04','16:00:00','2023-03-04','15:55:00'),(2186,375,8,6,'2023-03-05','15:40:00','2023-03-05','11:00:00'),(2187,375,8,11,'2023-03-05','16:00:00','2023-03-05','11:00:00'),(2188,375,6,11,'2023-03-05','16:00:00','2023-03-05','15:55:00'),(2189,376,8,6,'2023-03-06','15:40:00','2023-03-06','11:00:00'),(2190,376,8,11,'2023-03-06','16:00:00','2023-03-06','11:00:00'),(2191,376,6,11,'2023-03-06','16:00:00','2023-03-06','15:55:00'),(2192,377,8,6,'2023-03-07','15:40:00','2023-03-07','11:00:00'),(2193,377,8,11,'2023-03-07','16:00:00','2023-03-07','11:00:00'),(2194,377,6,11,'2023-03-07','16:00:00','2023-03-07','15:55:00'),(2195,378,8,6,'2023-03-08','15:40:00','2023-03-08','11:00:00'),(2196,378,8,11,'2023-03-08','16:00:00','2023-03-08','11:00:00'),(2197,378,6,11,'2023-03-08','16:00:00','2023-03-08','15:55:00'),(2198,379,8,6,'2023-03-09','15:40:00','2023-03-09','11:00:00'),(2199,379,8,11,'2023-03-09','16:00:00','2023-03-09','11:00:00'),(2200,379,6,11,'2023-03-09','16:00:00','2023-03-09','15:55:00'),(2201,380,8,6,'2023-03-10','15:40:00','2023-03-10','11:00:00'),(2202,380,8,11,'2023-03-10','16:00:00','2023-03-10','11:00:00'),(2203,380,6,11,'2023-03-10','16:00:00','2023-03-10','15:55:00'),(2204,381,8,6,'2023-02-08','15:40:00','2023-02-08','11:00:00'),(2205,381,8,11,'2023-02-08','16:00:00','2023-02-08','11:00:00'),(2206,381,6,11,'2023-02-08','16:00:00','2023-02-08','16:10:00'),(2207,382,8,6,'2023-02-09','15:40:00','2023-02-09','11:00:00'),(2208,382,8,11,'2023-02-09','16:00:00','2023-02-09','11:00:00'),(2209,382,6,11,'2023-02-09','16:00:00','2023-02-09','16:10:00'),(2210,383,8,6,'2023-02-10','15:40:00','2023-02-10','11:00:00'),(2211,383,8,11,'2023-02-10','16:00:00','2023-02-10','11:00:00'),(2212,383,6,11,'2023-02-10','16:00:00','2023-02-10','16:10:00'),(2213,384,8,6,'2023-02-11','15:40:00','2023-02-11','11:00:00'),(2214,384,8,11,'2023-02-11','16:00:00','2023-02-11','11:00:00'),(2215,384,6,11,'2023-02-11','16:00:00','2023-02-11','16:10:00'),(2216,385,8,6,'2023-02-12','15:40:00','2023-02-12','11:00:00'),(2217,385,8,11,'2023-02-12','16:00:00','2023-02-12','11:00:00'),(2218,385,6,11,'2023-02-12','16:00:00','2023-02-12','16:10:00'),(2219,386,8,6,'2023-02-13','15:40:00','2023-02-13','11:00:00'),(2220,386,8,11,'2023-02-13','16:00:00','2023-02-13','11:00:00'),(2221,386,6,11,'2023-02-13','16:00:00','2023-02-13','16:10:00'),(2222,387,8,6,'2023-02-14','15:40:00','2023-02-14','11:00:00'),(2223,387,8,11,'2023-02-14','16:00:00','2023-02-14','11:00:00'),(2224,387,6,11,'2023-02-14','16:00:00','2023-02-14','16:10:00'),(2225,388,8,6,'2023-02-15','15:40:00','2023-02-15','11:00:00'),(2226,388,8,11,'2023-02-15','16:00:00','2023-02-15','11:00:00'),(2227,388,6,11,'2023-02-15','16:00:00','2023-02-15','16:10:00'),(2228,389,8,6,'2023-02-16','15:40:00','2023-02-16','11:00:00'),(2229,389,8,11,'2023-02-16','16:00:00','2023-02-16','11:00:00'),(2230,389,6,11,'2023-02-16','16:00:00','2023-02-16','16:10:00'),(2231,390,8,6,'2023-02-17','15:40:00','2023-02-17','11:00:00'),(2232,390,8,11,'2023-02-17','16:00:00','2023-02-17','11:00:00'),(2233,390,6,11,'2023-02-17','16:00:00','2023-02-17','16:10:00'),(2234,391,8,6,'2023-02-18','15:40:00','2023-02-18','11:00:00'),(2235,391,8,11,'2023-02-18','16:00:00','2023-02-18','11:00:00'),(2236,391,6,11,'2023-02-18','16:00:00','2023-02-18','16:10:00'),(2237,392,8,6,'2023-02-19','15:40:00','2023-02-19','11:00:00'),(2238,392,8,11,'2023-02-19','16:00:00','2023-02-19','11:00:00'),(2239,392,6,11,'2023-02-19','16:00:00','2023-02-19','16:10:00'),(2240,393,8,6,'2023-02-20','15:40:00','2023-02-20','11:00:00'),(2241,393,8,11,'2023-02-20','16:00:00','2023-02-20','11:00:00'),(2242,393,6,11,'2023-02-20','16:00:00','2023-02-20','16:10:00'),(2243,394,8,6,'2023-02-21','15:40:00','2023-02-21','11:00:00'),(2244,394,8,11,'2023-02-21','16:00:00','2023-02-21','11:00:00'),(2245,394,6,11,'2023-02-21','16:00:00','2023-02-21','16:10:00'),(2246,395,8,6,'2023-02-22','15:40:00','2023-02-22','11:00:00'),(2247,395,8,11,'2023-02-22','16:00:00','2023-02-22','11:00:00'),(2248,395,6,11,'2023-02-22','16:00:00','2023-02-22','16:10:00'),(2249,396,8,6,'2023-02-23','15:40:00','2023-02-23','11:00:00'),(2250,396,8,11,'2023-02-23','16:00:00','2023-02-23','11:00:00'),(2251,396,6,11,'2023-02-23','16:00:00','2023-02-23','16:10:00'),(2252,397,8,6,'2023-02-24','15:40:00','2023-02-24','11:00:00'),(2253,397,8,11,'2023-02-24','16:00:00','2023-02-24','11:00:00'),(2254,397,6,11,'2023-02-24','16:00:00','2023-02-24','16:10:00'),(2255,398,8,6,'2023-02-25','15:40:00','2023-02-25','11:00:00'),(2256,398,8,11,'2023-02-25','16:00:00','2023-02-25','11:00:00'),(2257,398,6,11,'2023-02-25','16:00:00','2023-02-25','16:10:00'),(2258,399,8,6,'2023-02-26','15:40:00','2023-02-26','11:00:00'),(2259,399,8,11,'2023-02-26','16:00:00','2023-02-26','11:00:00'),(2260,399,6,11,'2023-02-26','16:00:00','2023-02-26','16:10:00'),(2261,400,8,6,'2023-02-27','15:40:00','2023-02-27','11:00:00'),(2262,400,8,11,'2023-02-27','16:00:00','2023-02-27','11:00:00'),(2263,400,6,11,'2023-02-27','16:00:00','2023-02-27','16:10:00'),(2264,401,8,6,'2023-02-28','15:40:00','2023-02-28','11:00:00'),(2265,401,8,11,'2023-02-28','16:00:00','2023-02-28','11:00:00'),(2266,401,6,11,'2023-02-28','16:00:00','2023-02-28','16:10:00'),(2267,402,8,6,'2023-03-01','15:40:00','2023-03-01','11:00:00'),(2268,402,8,11,'2023-03-01','16:00:00','2023-03-01','11:00:00'),(2269,402,6,11,'2023-03-01','16:00:00','2023-03-01','16:10:00'),(2270,403,8,6,'2023-03-02','15:40:00','2023-03-02','11:00:00'),(2271,403,8,11,'2023-03-02','16:00:00','2023-03-02','11:00:00'),(2272,403,6,11,'2023-03-02','16:00:00','2023-03-02','16:10:00'),(2273,404,8,6,'2023-03-03','15:40:00','2023-03-03','11:00:00'),(2274,404,8,11,'2023-03-03','16:00:00','2023-03-03','11:00:00'),(2275,404,6,11,'2023-03-03','16:00:00','2023-03-03','16:10:00'),(2276,405,8,6,'2023-03-04','15:40:00','2023-03-04','11:00:00'),(2277,405,8,11,'2023-03-04','16:00:00','2023-03-04','11:00:00'),(2278,405,6,11,'2023-03-04','16:00:00','2023-03-04','16:10:00'),(2279,406,8,6,'2023-03-05','15:40:00','2023-03-05','11:00:00'),(2280,406,8,11,'2023-03-05','16:00:00','2023-03-05','11:00:00'),(2281,406,6,11,'2023-03-05','16:00:00','2023-03-05','16:10:00'),(2282,407,8,6,'2023-03-06','15:40:00','2023-03-06','11:00:00'),(2283,407,8,11,'2023-03-06','16:00:00','2023-03-06','11:00:00'),(2284,407,6,11,'2023-03-06','16:00:00','2023-03-06','16:10:00'),(2285,408,8,6,'2023-03-07','15:40:00','2023-03-07','11:00:00'),(2286,408,8,11,'2023-03-07','16:00:00','2023-03-07','11:00:00'),(2287,408,6,11,'2023-03-07','16:00:00','2023-03-07','16:10:00'),(2288,409,8,6,'2023-03-08','15:40:00','2023-03-08','11:00:00'),(2289,409,8,11,'2023-03-08','16:00:00','2023-03-08','11:00:00'),(2290,409,6,11,'2023-03-08','16:00:00','2023-03-08','16:10:00'),(2291,410,8,6,'2023-03-09','15:40:00','2023-03-09','11:00:00'),(2292,410,8,11,'2023-03-09','16:00:00','2023-03-09','11:00:00'),(2293,410,6,11,'2023-03-09','16:00:00','2023-03-09','16:10:00'),(2294,411,8,6,'2023-03-10','15:40:00','2023-03-10','11:00:00'),(2295,411,8,11,'2023-03-10','16:00:00','2023-03-10','11:00:00'),(2296,411,6,11,'2023-03-10','16:00:00','2023-03-10','16:10:00'),(2297,412,8,6,'2023-02-08','15:40:00','2023-02-08','11:00:00'),(2298,412,8,11,'2023-02-08','16:30:00','2023-02-08','11:00:00'),(2299,412,6,11,'2023-02-08','16:30:00','2023-02-08','16:10:00'),(2300,413,8,6,'2023-02-09','15:40:00','2023-02-09','11:00:00'),(2301,413,8,11,'2023-02-09','16:30:00','2023-02-09','11:00:00'),(2302,413,6,11,'2023-02-09','16:30:00','2023-02-09','16:10:00'),(2303,414,8,6,'2023-02-10','15:40:00','2023-02-10','11:00:00'),(2304,414,8,11,'2023-02-10','16:30:00','2023-02-10','11:00:00'),(2305,414,6,11,'2023-02-10','16:30:00','2023-02-10','16:10:00'),(2306,415,8,6,'2023-02-11','15:40:00','2023-02-11','11:00:00'),(2307,415,8,11,'2023-02-11','16:30:00','2023-02-11','11:00:00'),(2308,415,6,11,'2023-02-11','16:30:00','2023-02-11','16:10:00'),(2309,416,8,6,'2023-02-12','15:40:00','2023-02-12','11:00:00'),(2310,416,8,11,'2023-02-12','16:30:00','2023-02-12','11:00:00'),(2311,416,6,11,'2023-02-12','16:30:00','2023-02-12','16:10:00'),(2312,417,8,6,'2023-02-13','15:40:00','2023-02-13','11:00:00'),(2313,417,8,11,'2023-02-13','16:30:00','2023-02-13','11:00:00'),(2314,417,6,11,'2023-02-13','16:30:00','2023-02-13','16:10:00'),(2315,418,8,6,'2023-02-14','15:40:00','2023-02-14','11:00:00'),(2316,418,8,11,'2023-02-14','16:30:00','2023-02-14','11:00:00'),(2317,418,6,11,'2023-02-14','16:30:00','2023-02-14','16:10:00'),(2318,419,8,6,'2023-02-15','15:40:00','2023-02-15','11:00:00'),(2319,419,8,11,'2023-02-15','16:30:00','2023-02-15','11:00:00'),(2320,419,6,11,'2023-02-15','16:30:00','2023-02-15','16:10:00'),(2321,420,8,6,'2023-02-16','15:40:00','2023-02-16','11:00:00'),(2322,420,8,11,'2023-02-16','16:30:00','2023-02-16','11:00:00'),(2323,420,6,11,'2023-02-16','16:30:00','2023-02-16','16:10:00'),(2324,421,8,6,'2023-02-17','15:40:00','2023-02-17','11:00:00'),(2325,421,8,11,'2023-02-17','16:30:00','2023-02-17','11:00:00'),(2326,421,6,11,'2023-02-17','16:30:00','2023-02-17','16:10:00'),(2327,422,8,6,'2023-02-18','15:40:00','2023-02-18','11:00:00'),(2328,422,8,11,'2023-02-18','16:30:00','2023-02-18','11:00:00'),(2329,422,6,11,'2023-02-18','16:30:00','2023-02-18','16:10:00'),(2330,423,8,6,'2023-02-19','15:40:00','2023-02-19','11:00:00'),(2331,423,8,11,'2023-02-19','16:30:00','2023-02-19','11:00:00'),(2332,423,6,11,'2023-02-19','16:30:00','2023-02-19','16:10:00'),(2333,424,8,6,'2023-02-20','15:40:00','2023-02-20','11:00:00'),(2334,424,8,11,'2023-02-20','16:30:00','2023-02-20','11:00:00'),(2335,424,6,11,'2023-02-20','16:30:00','2023-02-20','16:10:00'),(2336,425,8,6,'2023-02-21','15:40:00','2023-02-21','11:00:00'),(2337,425,8,11,'2023-02-21','16:30:00','2023-02-21','11:00:00'),(2338,425,6,11,'2023-02-21','16:30:00','2023-02-21','16:10:00'),(2339,426,8,6,'2023-02-22','15:40:00','2023-02-22','11:00:00'),(2340,426,8,11,'2023-02-22','16:30:00','2023-02-22','11:00:00'),(2341,426,6,11,'2023-02-22','16:30:00','2023-02-22','16:10:00'),(2342,427,8,6,'2023-02-23','15:40:00','2023-02-23','11:00:00'),(2343,427,8,11,'2023-02-23','16:30:00','2023-02-23','11:00:00'),(2344,427,6,11,'2023-02-23','16:30:00','2023-02-23','16:10:00'),(2345,428,8,6,'2023-02-24','15:40:00','2023-02-24','11:00:00'),(2346,428,8,11,'2023-02-24','16:30:00','2023-02-24','11:00:00'),(2347,428,6,11,'2023-02-24','16:30:00','2023-02-24','16:10:00'),(2348,429,8,6,'2023-02-25','15:40:00','2023-02-25','11:00:00'),(2349,429,8,11,'2023-02-25','16:30:00','2023-02-25','11:00:00'),(2350,429,6,11,'2023-02-25','16:30:00','2023-02-25','16:10:00'),(2351,430,8,6,'2023-02-26','15:40:00','2023-02-26','11:00:00'),(2352,430,8,11,'2023-02-26','16:30:00','2023-02-26','11:00:00'),(2353,430,6,11,'2023-02-26','16:30:00','2023-02-26','16:10:00'),(2354,431,8,6,'2023-02-27','15:40:00','2023-02-27','11:00:00'),(2355,431,8,11,'2023-02-27','16:30:00','2023-02-27','11:00:00'),(2356,431,6,11,'2023-02-27','16:30:00','2023-02-27','16:10:00'),(2357,432,8,6,'2023-02-28','15:40:00','2023-02-28','11:00:00'),(2358,432,8,11,'2023-02-28','16:30:00','2023-02-28','11:00:00'),(2359,432,6,11,'2023-02-28','16:30:00','2023-02-28','16:10:00'),(2360,433,8,6,'2023-03-01','15:40:00','2023-03-01','11:00:00'),(2361,433,8,11,'2023-03-01','16:30:00','2023-03-01','11:00:00'),(2362,433,6,11,'2023-03-01','16:30:00','2023-03-01','16:10:00'),(2363,434,8,6,'2023-03-02','15:40:00','2023-03-02','11:00:00'),(2364,434,8,11,'2023-03-02','16:30:00','2023-03-02','11:00:00'),(2365,434,6,11,'2023-03-02','16:30:00','2023-03-02','16:10:00'),(2366,435,8,6,'2023-03-03','15:40:00','2023-03-03','11:00:00'),(2367,435,8,11,'2023-03-03','16:30:00','2023-03-03','11:00:00'),(2368,435,6,11,'2023-03-03','16:30:00','2023-03-03','16:10:00'),(2369,436,8,6,'2023-03-04','15:40:00','2023-03-04','11:00:00'),(2370,436,8,11,'2023-03-04','16:30:00','2023-03-04','11:00:00'),(2371,436,6,11,'2023-03-04','16:30:00','2023-03-04','16:10:00'),(2372,437,8,6,'2023-03-05','15:40:00','2023-03-05','11:00:00'),(2373,437,8,11,'2023-03-05','16:30:00','2023-03-05','11:00:00'),(2374,437,6,11,'2023-03-05','16:30:00','2023-03-05','16:10:00'),(2375,438,8,6,'2023-03-06','15:40:00','2023-03-06','11:00:00'),(2376,438,8,11,'2023-03-06','16:30:00','2023-03-06','11:00:00'),(2377,438,6,11,'2023-03-06','16:30:00','2023-03-06','16:10:00'),(2378,439,8,6,'2023-03-07','15:40:00','2023-03-07','11:00:00'),(2379,439,8,11,'2023-03-07','16:30:00','2023-03-07','11:00:00'),(2380,439,6,11,'2023-03-07','16:30:00','2023-03-07','16:10:00'),(2381,440,8,6,'2023-03-08','15:40:00','2023-03-08','11:00:00'),(2382,440,8,11,'2023-03-08','16:30:00','2023-03-08','11:00:00'),(2383,440,6,11,'2023-03-08','16:30:00','2023-03-08','16:10:00'),(2384,441,8,6,'2023-03-09','15:40:00','2023-03-09','11:00:00'),(2385,441,8,11,'2023-03-09','16:30:00','2023-03-09','11:00:00'),(2386,441,6,11,'2023-03-09','16:30:00','2023-03-09','16:10:00'),(2387,442,8,6,'2023-03-10','15:40:00','2023-03-10','11:00:00'),(2388,442,8,11,'2023-03-10','16:30:00','2023-03-10','11:00:00'),(2389,442,6,11,'2023-03-10','16:30:00','2023-03-10','16:10:00');
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
INSERT INTO `formapagosubtipo` VALUES (1,'TB','Tarjeta de credito',0),(2,'TB','Tarjeta de débito',0),(3,'DO','Vales IMSSS',0),(4,'DO','Vales ISSSTE',0),(5,'DO','Vales SEDENA',0);
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
INSERT INTO `formaspago` VALUES ('CC','Cuenta por cobrar'),('DO','Documento'),('EF','Efectivo'),('TB','Tarjeta bancaria');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itinerario`
--

LOCK TABLES `itinerario` WRITE;
/*!40000 ALTER TABLE `itinerario` DISABLE KEYS */;
INSERT INTO `itinerario` VALUES (1,1,1),(1,2,2),(2,1,9);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'users.index','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(2,'users.store','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(3,'users.edit','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(4,'users.update','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(5,'users.destroy','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(6,'users.addrol','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(7,'users.removerol','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(8,'users.editPermissions','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(9,'personas.update','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(10,'corridas.programadas.index','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(11,'corridas.programadas.store','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(12,'corridas.programadas.show','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(13,'corridas.programadas.destroy','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(14,'corridas.programadas.transfer','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(15,'corridas.programadas.storeTransfer','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(16,'corridas.disponibles.index','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(17,'corridas.disponibles.edit','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(18,'corridas.disponibles.update','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(19,'corridas.disponibles.puntosDeControl','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(20,'corridas.disponibles.despachar','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(21,'corridas.disponibles.guiaPasajeros','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(22,'boletos.limbo.show','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(23,'personal.conductores.index','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(24,'personal.conductores.edit','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(25,'personal.conductores.update','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(26,'sesionesVenta.create','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(27,'sesionesVenta.update','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(28,'sesionesVenta.show','web','2023-02-08 04:48:28','2023-02-08 04:48:28');
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
INSERT INTO `personas` VALUES (1,'Jahaziel Aarón','Aguilera Castillo',12,'EI','2023-02-07','2023-02-07 16:48:30',NULL),(2,'ANGEL','ZAMORA DE JESUS',12,'EI','2023-02-07','2023-02-07 16:48:30',NULL),(3,'FRANCISCO JAVIER','ALVARADO LEMUS',12,'EI','2023-02-07','2023-02-07 16:48:30',NULL),(4,'PASCUAL','ESTEBAN GABRIEL',12,'EI','2023-02-07','2023-02-07 16:48:30',NULL),(5,'JESUS','CORNEJO MAULE',12,NULL,'2023-02-07','2023-02-07 16:48:30',NULL),(6,'sergio','medrano',8,'EI','2023-02-07','2023-02-07 16:48:30',NULL);
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
INSERT INTO `roles` VALUES (1,'Admin','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(2,'publicoGeneral','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(3,'servicios','web','2023-02-08 04:48:28','2023-02-08 04:48:28'),(4,'conductor','web','2023-02-08 04:48:28','2023-02-08 04:48:28');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
INSERT INTO `sesiones` VALUES (10,1,12,0.00,'2023-02-08',NULL,'2023-02-08 15:44:14','2023-02-08 15:44:14');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifastramos`
--

LOCK TABLES `tarifastramos` WRITE;
/*!40000 ALTER TABLE `tarifastramos` DISABLE KEYS */;
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
  `deleted_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  KEY `tramos_IN` (`nNumero`,`nOrigen`,`nDestino`),
  CONSTRAINT `tramos_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `tramos_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramos`
--

LOCK TABLES `tramos` WRITE;
/*!40000 ALTER TABLE `tramos` DISABLE KEYS */;
INSERT INTO `tramos` VALUES (1,8,6,1,280,30,'2023-02-08 04:56:03','2023-02-08 21:52:30','0000-00-00 00:00:00'),(2,6,11,3,20,10,'2023-02-08 04:56:03','2023-02-08 04:56:34','0000-00-00 00:00:00'),(3,8,5,158,135,0,'2023-02-08 05:37:12','2023-02-08 05:37:12','0000-00-00 00:00:00'),(4,5,1,30,30,0,'2023-02-08 05:37:12','2023-02-08 05:37:12','0000-00-00 00:00:00'),(5,1,5,30,30,0,'2023-02-08 05:41:05','2023-02-08 05:41:05','0000-00-00 00:00:00'),(6,5,8,158,135,0,'2023-02-08 05:41:05','2023-02-08 05:41:05','0000-00-00 00:00:00'),(7,11,6,3,20,0,'2023-02-08 05:41:05','2023-02-08 05:41:05','0000-00-00 00:00:00'),(8,6,8,1,280,0,'2023-02-08 05:41:05','2023-02-08 05:41:05','0000-00-00 00:00:00'),(9,8,4,1,1,0,'2023-02-08 05:41:26','2023-02-08 05:41:26','0000-00-00 00:00:00');
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
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`persona_nNumero`) REFERENCES `personas` (`nNumeroPersona`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'DTI sistemas','dti_parhikuni@parhikuni.com.mx',NULL,'$2y$10$eqQ3pcjEqrGPNhxJKRUCmuBH4lPRgjUXJXiiltwSUZF97HXrPUW22',NULL,'2023-02-08 04:48:28','2023-02-08 04:48:28',NULL,1),(2,'Sergio Medrano','sergio.medrano@parhikuni.com.mx',NULL,'$2y$10$Fy.wd7dO3nigleo04RuZzuGXeXivWFoMStpQqDZJU55t4sx2gj3HG',NULL,'2023-02-08 04:48:28','2023-02-08 04:48:28',NULL,2),(3,'Grady Padberg','ethel52@example.net','2023-02-08 04:48:28','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','bC1ZPsyjgH','2023-02-08 04:48:28','2023-02-08 04:48:28',NULL,NULL),(4,'Floy Little DDS','lawson05@example.com','2023-02-08 04:48:28','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','ltHmqiuR39','2023-02-08 04:48:28','2023-02-08 04:48:28',NULL,NULL),(5,'Kadin Lehner','scrist@example.com','2023-02-08 04:48:28','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','LaE6HKWji7','2023-02-08 04:48:28','2023-02-08 04:48:28',NULL,NULL);
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

-- Dump completed on 2023-02-08 10:22:27
