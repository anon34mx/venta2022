-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: laravel
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  KEY `autobuses_index` (`nNumeroAutobus`,`nTipoServicio`,`nDistribucionAsientos`),
  CONSTRAINT `autobuses_ibfk_1` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`),
  CONSTRAINT `autobuses_ibfk_2` FOREIGN KEY (`nDistribucionAsientos`) REFERENCES `distribucionasientos` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autobuses`
--

LOCK TABLES `autobuses` WRITE;
/*!40000 ALTER TABLE `autobuses` DISABLE KEYS */;
INSERT INTO `autobuses` VALUES (1,'5005',5,6),(2,'5006',5,6),(3,'5401',5,3),(4,'5402',5,3),(5,'5403',5,3),(6,'5404',5,3),(7,'5405',5,3),(8,'5406',5,3),(9,'5407',5,3),(10,'5408',5,3),(11,'5409',5,3),(12,'5410',5,3),(13,'5411',5,3),(14,'5425',5,3),(15,'5426',5,3),(16,'5427',5,3),(17,'5428',5,3),(18,'5429',5,3),(19,'5430',5,3),(20,'5431',5,3),(21,'5432',5,3),(22,'5433',5,3),(23,'5434',5,3),(24,'5435',5,3),(25,'5436',5,3),(26,'5437',5,3),(27,'5438',5,3),(28,'8014',5,1),(29,'0007',4,1),(30,'9001',2,2),(31,'9002',2,2),(32,'9003',2,2),(33,'9004',2,2),(34,'9005',2,2),(35,'9007',2,2),(36,'9008',2,2),(37,'9009',2,2),(38,'9010',2,2),(39,'7001',2,2),(40,'7002',2,2),(41,'7003',2,2),(42,'7004',2,2),(43,'7005',2,2),(44,'7008',2,2),(45,'7009',2,2),(46,'7010',2,2),(47,'7011',2,2),(48,'7012',2,2),(49,'5412',3,3),(50,'5413',1,1),(51,'5414',1,1),(52,'5415',1,1),(53,'5416',1,1),(54,'5417',1,1),(55,'5418',1,1),(56,'5419',1,1),(57,'5420',1,1),(58,'5421',1,1),(59,'5422',1,1),(60,'5423',1,1),(61,'5424',1,1),(62,'8001',1,1),(63,'8002',1,1),(64,'8003',1,1),(65,'8004',1,1),(66,'8005',1,1),(67,'8006',1,1),(68,'8007',1,1),(69,'8008',1,1),(70,'8009',1,1),(71,'8010',1,1),(72,'8011',1,1),(73,'8012',1,1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletos_vendidos_estados`
--

LOCK TABLES `boletos_vendidos_estados` WRITE;
/*!40000 ALTER TABLE `boletos_vendidos_estados` DISABLE KEYS */;
INSERT INTO `boletos_vendidos_estados` VALUES ('AP','Abordo pasajero'),('CA','Cancelado'),('IN','Intercambiado'),('LI','Liquidado'),('LM','Limbo'),('PC','Paquete en Corrida'),('PD','Paquete en Destino'),('PE','Paquete Entregado'),('PP','Pago pendiente'),('VE','Vendido');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletosdisponibles`
--

LOCK TABLES `boletosdisponibles` WRITE;
/*!40000 ALTER TABLE `boletosdisponibles` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletosdisponibles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boletostransferidos`
--

DROP TABLE IF EXISTS `boletostransferidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletostransferidos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `corrida_anterior` bigint(20) unsigned DEFAULT NULL,
  `boleto` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `corrida_anterior` (`corrida_anterior`),
  KEY `boleto` (`boleto`),
  CONSTRAINT `boletostransferidos_ibfk_1` FOREIGN KEY (`corrida_anterior`) REFERENCES `corridasdisponibles` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `boletostransferidos_ibfk_2` FOREIGN KEY (`boleto`) REFERENCES `corridasdisponibles` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletostransferidos`
--

LOCK TABLES `boletostransferidos` WRITE;
/*!40000 ALTER TABLE `boletostransferidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletostransferidos` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletosvendidos_tipopaquetes`
--

LOCK TABLES `boletosvendidos_tipopaquetes` WRITE;
/*!40000 ALTER TABLE `boletosvendidos_tipopaquetes` DISABLE KEYS */;
/*!40000 ALTER TABLE `boletosvendidos_tipopaquetes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_windows`
--

DROP TABLE IF EXISTS `cliente_windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente_windows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version` decimal(5,2) unsigned DEFAULT NULL,
  `liberado` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_windows`
--

LOCK TABLES `cliente_windows` WRITE;
/*!40000 ALTER TABLE `cliente_windows` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente_windows` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conductores`
--

LOCK TABLES `conductores` WRITE;
/*!40000 ALTER TABLE `conductores` DISABLE KEYS */;
INSERT INTO `conductores` VALUES (1,2,'LIC007','2025-10-11','AC',1,'2023-10-12 12:03:17',NULL,NULL),(2,3,'LIC084','2028-03-08','AC',30,'2023-10-12 12:03:17',NULL,NULL),(3,4,'LIC026','2025-07-26','BA',40,'2023-10-12 12:03:17',NULL,NULL);
/*!40000 ALTER TABLE `conductores` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridas_conductores`
--

LOCK TABLES `corridas_conductores` WRITE;
/*!40000 ALTER TABLE `corridas_conductores` DISABLE KEYS */;
/*!40000 ALTER TABLE `corridas_conductores` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  CONSTRAINT `corridas_versiones_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_versiones_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  KEY `corridasdisponibles_index` (`nNumero`,`fSalida`,`aEstado`,`nItinerario`,`nTipoServicio`,`nNumeroAutobus`),
  CONSTRAINT `FK_corridaestado` FOREIGN KEY (`aEstado`) REFERENCES `corridas_estados` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridasdisponibles_ibfk_1` FOREIGN KEY (`nNumeroConductor`) REFERENCES `conductores` (`nNumeroConductor`),
  CONSTRAINT `corridasdisponibles_ibfk_2` FOREIGN KEY (`nNumeroAutobus`) REFERENCES `autobuses` (`nNumeroAutobus`),
  CONSTRAINT `corridasdisponibles_ibfk_3` FOREIGN KEY (`nProgramada`) REFERENCES `corridasprogramadas` (`nNumero`),
  CONSTRAINT `corridasdisponibles_ibfk_4` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`),
  CONSTRAINT `corridasdisponibles_ibfk_5` FOREIGN KEY (`nItinerario`) REFERENCES `itinerario` (`nItinerario`)
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasdisponibles`
--

LOCK TABLES `corridasdisponibles` WRITE;
/*!40000 ALTER TABLE `corridasdisponibles` DISABLE KEYS */;
INSERT INTO `corridasdisponibles` VALUES (1,1,8,5,'2023-10-12','04:27:31','D',1,NULL,NULL,NULL,NULL),(2,2,10,2,'2023-10-12','11:55:00','D',30,NULL,NULL,NULL,NULL),(3,3,6,1,'2023-10-12','03:58:38','D',50,NULL,NULL,NULL,NULL),(4,4,3,3,'2023-10-12','07:49:58','D',49,NULL,NULL,NULL,NULL),(5,5,14,5,'2023-10-12','04:53:42','D',1,NULL,NULL,NULL,NULL),(6,1,8,5,'2023-10-13','04:27:31','D',1,NULL,NULL,NULL,NULL),(7,2,10,2,'2023-10-13','11:55:00','D',30,NULL,NULL,NULL,NULL),(8,3,6,1,'2023-10-13','03:58:38','D',50,NULL,NULL,NULL,NULL),(9,4,3,3,'2023-10-13','07:49:58','D',49,NULL,NULL,NULL,NULL),(10,5,14,5,'2023-10-13','04:53:42','D',1,NULL,NULL,NULL,NULL),(11,1,8,5,'2023-10-14','04:27:31','D',1,NULL,NULL,NULL,NULL),(12,2,10,2,'2023-10-14','11:55:00','D',30,NULL,NULL,NULL,NULL),(13,3,6,1,'2023-10-14','03:58:38','D',50,NULL,NULL,NULL,NULL),(14,4,3,3,'2023-10-14','07:49:58','D',49,NULL,NULL,NULL,NULL),(15,5,14,5,'2023-10-14','04:53:42','D',1,NULL,NULL,NULL,NULL),(16,1,8,5,'2023-10-15','04:27:31','D',1,NULL,NULL,NULL,NULL),(17,2,10,2,'2023-10-15','11:55:00','D',30,NULL,NULL,NULL,NULL),(18,3,6,1,'2023-10-15','03:58:38','D',50,NULL,NULL,NULL,NULL),(19,4,3,3,'2023-10-15','07:49:58','D',49,NULL,NULL,NULL,NULL),(20,5,14,5,'2023-10-15','04:53:42','D',1,NULL,NULL,NULL,NULL),(21,1,8,5,'2023-10-16','04:27:31','D',1,NULL,NULL,NULL,NULL),(22,2,10,2,'2023-10-16','11:55:00','D',30,NULL,NULL,NULL,NULL),(23,3,6,1,'2023-10-16','03:58:38','D',50,NULL,NULL,NULL,NULL),(24,4,3,3,'2023-10-16','07:49:58','D',49,NULL,NULL,NULL,NULL),(25,5,14,5,'2023-10-16','04:53:42','D',1,NULL,NULL,NULL,NULL),(26,1,8,5,'2023-10-17','04:27:31','D',1,NULL,NULL,NULL,NULL),(27,2,10,2,'2023-10-17','11:55:00','D',30,NULL,NULL,NULL,NULL),(28,3,6,1,'2023-10-17','03:58:38','D',50,NULL,NULL,NULL,NULL),(29,4,3,3,'2023-10-17','07:49:58','D',49,NULL,NULL,NULL,NULL),(30,5,14,5,'2023-10-17','04:53:42','D',1,NULL,NULL,NULL,NULL),(31,1,8,5,'2023-10-18','04:27:31','D',1,NULL,NULL,NULL,NULL),(32,2,10,2,'2023-10-18','11:55:00','D',30,NULL,NULL,NULL,NULL),(33,3,6,1,'2023-10-18','03:58:38','D',50,NULL,NULL,NULL,NULL),(34,4,3,3,'2023-10-18','07:49:58','D',49,NULL,NULL,NULL,NULL),(35,5,14,5,'2023-10-18','04:53:42','D',1,NULL,NULL,NULL,NULL),(36,1,8,5,'2023-10-19','04:27:31','D',1,NULL,NULL,NULL,NULL),(37,2,10,2,'2023-10-19','11:55:00','D',30,NULL,NULL,NULL,NULL),(38,3,6,1,'2023-10-19','03:58:38','D',50,NULL,NULL,NULL,NULL),(39,4,3,3,'2023-10-19','07:49:58','D',49,NULL,NULL,NULL,NULL),(40,5,14,5,'2023-10-19','04:53:42','D',1,NULL,NULL,NULL,NULL),(41,1,8,5,'2023-10-20','04:27:31','D',1,NULL,NULL,NULL,NULL),(42,2,10,2,'2023-10-20','11:55:00','D',30,NULL,NULL,NULL,NULL),(43,3,6,1,'2023-10-20','03:58:38','D',50,NULL,NULL,NULL,NULL),(44,4,3,3,'2023-10-20','07:49:58','D',49,NULL,NULL,NULL,NULL),(45,5,14,5,'2023-10-20','04:53:42','D',1,NULL,NULL,NULL,NULL),(46,1,8,5,'2023-10-21','04:27:31','D',1,NULL,NULL,NULL,NULL),(47,2,10,2,'2023-10-21','11:55:00','D',30,NULL,NULL,NULL,NULL),(48,3,6,1,'2023-10-21','03:58:38','D',50,NULL,NULL,NULL,NULL),(49,4,3,3,'2023-10-21','07:49:58','D',49,NULL,NULL,NULL,NULL),(50,5,14,5,'2023-10-21','04:53:42','D',1,NULL,NULL,NULL,NULL),(51,1,8,5,'2023-10-22','04:27:31','D',1,NULL,NULL,NULL,NULL),(52,2,10,2,'2023-10-22','11:55:00','D',30,NULL,NULL,NULL,NULL),(53,3,6,1,'2023-10-22','03:58:38','D',50,NULL,NULL,NULL,NULL),(54,4,3,3,'2023-10-22','07:49:58','D',49,NULL,NULL,NULL,NULL),(55,5,14,5,'2023-10-22','04:53:42','D',1,NULL,NULL,NULL,NULL),(56,1,8,5,'2023-10-23','04:27:31','D',1,NULL,NULL,NULL,NULL),(57,2,10,2,'2023-10-23','11:55:00','D',30,NULL,NULL,NULL,NULL),(58,3,6,1,'2023-10-23','03:58:38','D',50,NULL,NULL,NULL,NULL),(59,4,3,3,'2023-10-23','07:49:58','D',49,NULL,NULL,NULL,NULL),(60,5,14,5,'2023-10-23','04:53:42','D',1,NULL,NULL,NULL,NULL),(61,1,8,5,'2023-10-24','04:27:31','D',1,NULL,NULL,NULL,NULL),(62,2,10,2,'2023-10-24','11:55:00','D',30,NULL,NULL,NULL,NULL),(63,3,6,1,'2023-10-24','03:58:38','D',50,NULL,NULL,NULL,NULL),(64,4,3,3,'2023-10-24','07:49:58','D',49,NULL,NULL,NULL,NULL),(65,5,14,5,'2023-10-24','04:53:42','D',1,NULL,NULL,NULL,NULL),(66,1,8,5,'2023-10-25','04:27:31','D',1,NULL,NULL,NULL,NULL),(67,2,10,2,'2023-10-25','11:55:00','D',30,NULL,NULL,NULL,NULL),(68,3,6,1,'2023-10-25','03:58:38','D',50,NULL,NULL,NULL,NULL),(69,4,3,3,'2023-10-25','07:49:58','D',49,NULL,NULL,NULL,NULL),(70,5,14,5,'2023-10-25','04:53:42','D',1,NULL,NULL,NULL,NULL),(71,1,8,5,'2023-10-26','04:27:31','D',1,NULL,NULL,NULL,NULL),(72,2,10,2,'2023-10-26','11:55:00','D',30,NULL,NULL,NULL,NULL),(73,3,6,1,'2023-10-26','03:58:38','D',50,NULL,NULL,NULL,NULL),(74,4,3,3,'2023-10-26','07:49:58','D',49,NULL,NULL,NULL,NULL),(75,5,14,5,'2023-10-26','04:53:42','D',1,NULL,NULL,NULL,NULL),(76,1,8,5,'2023-10-27','04:27:31','D',1,NULL,NULL,NULL,NULL),(77,2,10,2,'2023-10-27','11:55:00','D',30,NULL,NULL,NULL,NULL),(78,3,6,1,'2023-10-27','03:58:38','D',50,NULL,NULL,NULL,NULL),(79,4,3,3,'2023-10-27','07:49:58','D',49,NULL,NULL,NULL,NULL),(80,5,14,5,'2023-10-27','04:53:42','D',1,NULL,NULL,NULL,NULL),(81,1,8,5,'2023-10-28','04:27:31','D',1,NULL,NULL,NULL,NULL),(82,2,10,2,'2023-10-28','11:55:00','D',30,NULL,NULL,NULL,NULL),(83,3,6,1,'2023-10-28','03:58:38','D',50,NULL,NULL,NULL,NULL),(84,4,3,3,'2023-10-28','07:49:58','D',49,NULL,NULL,NULL,NULL),(85,5,14,5,'2023-10-28','04:53:42','D',1,NULL,NULL,NULL,NULL),(86,1,8,5,'2023-10-29','04:27:31','D',1,NULL,NULL,NULL,NULL),(87,2,10,2,'2023-10-29','11:55:00','D',30,NULL,NULL,NULL,NULL),(88,3,6,1,'2023-10-29','03:58:38','D',50,NULL,NULL,NULL,NULL),(89,4,3,3,'2023-10-29','07:49:58','D',49,NULL,NULL,NULL,NULL),(90,5,14,5,'2023-10-29','04:53:42','D',1,NULL,NULL,NULL,NULL),(91,1,8,5,'2023-10-30','04:27:31','D',1,NULL,NULL,NULL,NULL),(92,2,10,2,'2023-10-30','11:55:00','D',30,NULL,NULL,NULL,NULL),(93,3,6,1,'2023-10-30','03:58:38','D',50,NULL,NULL,NULL,NULL),(94,4,3,3,'2023-10-30','07:49:58','D',49,NULL,NULL,NULL,NULL),(95,5,14,5,'2023-10-30','04:53:42','D',1,NULL,NULL,NULL,NULL),(96,1,8,5,'2023-10-31','04:27:31','D',1,NULL,NULL,NULL,NULL),(97,2,10,2,'2023-10-31','11:55:00','D',30,NULL,NULL,NULL,NULL),(98,3,6,1,'2023-10-31','03:58:38','D',50,NULL,NULL,NULL,NULL),(99,4,3,3,'2023-10-31','07:49:58','D',49,NULL,NULL,NULL,NULL),(100,5,14,5,'2023-10-31','04:53:42','D',1,NULL,NULL,NULL,NULL),(101,1,8,5,'2023-11-01','04:27:31','D',1,NULL,NULL,NULL,NULL),(102,2,10,2,'2023-11-01','11:55:00','D',30,NULL,NULL,NULL,NULL),(103,3,6,1,'2023-11-01','03:58:38','D',50,NULL,NULL,NULL,NULL),(104,4,3,3,'2023-11-01','07:49:58','D',49,NULL,NULL,NULL,NULL),(105,5,14,5,'2023-11-01','04:53:42','D',1,NULL,NULL,NULL,NULL),(106,1,8,5,'2023-11-02','04:27:31','D',1,NULL,NULL,NULL,NULL),(107,2,10,2,'2023-11-02','11:55:00','D',30,NULL,NULL,NULL,NULL),(108,3,6,1,'2023-11-02','03:58:38','D',50,NULL,NULL,NULL,NULL),(109,4,3,3,'2023-11-02','07:49:58','D',49,NULL,NULL,NULL,NULL),(110,5,14,5,'2023-11-02','04:53:42','D',1,NULL,NULL,NULL,NULL),(111,1,8,5,'2023-11-03','04:27:31','D',1,NULL,NULL,NULL,NULL),(112,2,10,2,'2023-11-03','11:55:00','D',30,NULL,NULL,NULL,NULL),(113,3,6,1,'2023-11-03','03:58:38','D',50,NULL,NULL,NULL,NULL),(114,4,3,3,'2023-11-03','07:49:58','D',49,NULL,NULL,NULL,NULL),(115,5,14,5,'2023-11-03','04:53:42','D',1,NULL,NULL,NULL,NULL),(116,1,8,5,'2023-11-04','04:27:31','D',1,NULL,NULL,NULL,NULL),(117,2,10,2,'2023-11-04','11:55:00','D',30,NULL,NULL,NULL,NULL),(118,3,6,1,'2023-11-04','03:58:38','D',50,NULL,NULL,NULL,NULL),(119,4,3,3,'2023-11-04','07:49:58','D',49,NULL,NULL,NULL,NULL),(120,5,14,5,'2023-11-04','04:53:42','D',1,NULL,NULL,NULL,NULL),(121,1,8,5,'2023-11-05','04:27:31','D',1,NULL,NULL,NULL,NULL),(122,2,10,2,'2023-11-05','11:55:00','D',30,NULL,NULL,NULL,NULL),(123,3,6,1,'2023-11-05','03:58:38','D',50,NULL,NULL,NULL,NULL),(124,4,3,3,'2023-11-05','07:49:58','D',49,NULL,NULL,NULL,NULL),(125,5,14,5,'2023-11-05','04:53:42','D',1,NULL,NULL,NULL,NULL),(126,1,8,5,'2023-11-06','04:27:31','D',1,NULL,NULL,NULL,NULL),(127,2,10,2,'2023-11-06','11:55:00','D',30,NULL,NULL,NULL,NULL),(128,3,6,1,'2023-11-06','03:58:38','D',50,NULL,NULL,NULL,NULL),(129,4,3,3,'2023-11-06','07:49:58','D',49,NULL,NULL,NULL,NULL),(130,5,14,5,'2023-11-06','04:53:42','D',1,NULL,NULL,NULL,NULL),(131,1,8,5,'2023-11-07','04:27:31','D',1,NULL,NULL,NULL,NULL),(132,2,10,2,'2023-11-07','11:55:00','D',30,NULL,NULL,NULL,NULL),(133,3,6,1,'2023-11-07','03:58:38','D',50,NULL,NULL,NULL,NULL),(134,4,3,3,'2023-11-07','07:49:58','D',49,NULL,NULL,NULL,NULL),(135,5,14,5,'2023-11-07','04:53:42','D',1,NULL,NULL,NULL,NULL),(136,1,8,5,'2023-11-08','04:27:31','D',1,NULL,NULL,NULL,NULL),(137,2,10,2,'2023-11-08','11:55:00','D',30,NULL,NULL,NULL,NULL),(138,3,6,1,'2023-11-08','03:58:38','D',50,NULL,NULL,NULL,NULL),(139,4,3,3,'2023-11-08','07:49:58','D',49,NULL,NULL,NULL,NULL),(140,5,14,5,'2023-11-08','04:53:42','D',1,NULL,NULL,NULL,NULL),(141,1,8,5,'2023-11-09','04:27:31','D',1,NULL,NULL,NULL,NULL),(142,2,10,2,'2023-11-09','11:55:00','D',30,NULL,NULL,NULL,NULL),(143,3,6,1,'2023-11-09','03:58:38','D',50,NULL,NULL,NULL,NULL),(144,4,3,3,'2023-11-09','07:49:58','D',49,NULL,NULL,NULL,NULL),(145,5,14,5,'2023-11-09','04:53:42','D',1,NULL,NULL,NULL,NULL),(146,1,8,5,'2023-11-10','04:27:31','D',1,NULL,NULL,NULL,NULL),(147,2,10,2,'2023-11-10','11:55:00','D',30,NULL,NULL,NULL,NULL),(148,3,6,1,'2023-11-10','03:58:38','D',50,NULL,NULL,NULL,NULL),(149,4,3,3,'2023-11-10','07:49:58','D',49,NULL,NULL,NULL,NULL),(150,5,14,5,'2023-11-10','04:53:42','D',1,NULL,NULL,NULL,NULL),(151,1,8,5,'2023-11-11','04:27:31','D',1,NULL,NULL,NULL,NULL),(152,2,10,2,'2023-11-11','11:55:00','D',30,NULL,NULL,NULL,NULL),(153,3,6,1,'2023-11-11','03:58:38','D',50,NULL,NULL,NULL,NULL),(154,4,3,3,'2023-11-11','07:49:58','D',49,NULL,NULL,NULL,NULL),(155,5,14,5,'2023-11-11','04:53:42','D',1,NULL,NULL,NULL,NULL),(156,1,8,5,'2023-11-12','04:27:31','D',1,NULL,NULL,NULL,NULL),(157,2,10,2,'2023-11-12','11:55:00','D',30,NULL,NULL,NULL,NULL),(158,3,6,1,'2023-11-12','03:58:38','D',50,NULL,NULL,NULL,NULL),(159,4,3,3,'2023-11-12','07:49:58','D',49,NULL,NULL,NULL,NULL),(160,5,14,5,'2023-11-12','04:53:42','D',1,NULL,NULL,NULL,NULL),(161,1,8,5,'2023-11-13','04:27:31','D',1,NULL,NULL,NULL,NULL),(162,2,10,2,'2023-11-13','11:55:00','D',30,NULL,NULL,NULL,NULL),(163,3,6,1,'2023-11-13','03:58:38','D',50,NULL,NULL,NULL,NULL),(164,4,3,3,'2023-11-13','07:49:58','D',49,NULL,NULL,NULL,NULL),(165,5,14,5,'2023-11-13','04:53:42','D',1,NULL,NULL,NULL,NULL),(166,1,8,5,'2023-11-14','04:27:31','D',1,NULL,NULL,NULL,NULL),(167,2,10,2,'2023-11-14','11:55:00','D',30,NULL,NULL,NULL,NULL),(168,3,6,1,'2023-11-14','03:58:38','D',50,NULL,NULL,NULL,NULL),(169,4,3,3,'2023-11-14','07:49:58','D',49,NULL,NULL,NULL,NULL),(170,5,14,5,'2023-11-14','04:53:42','D',1,NULL,NULL,NULL,NULL),(171,1,8,5,'2023-11-15','04:27:31','D',1,NULL,NULL,NULL,NULL),(172,2,10,2,'2023-11-15','11:55:00','D',30,NULL,NULL,NULL,NULL),(173,3,6,1,'2023-11-15','03:58:38','D',50,NULL,NULL,NULL,NULL),(174,4,3,3,'2023-11-15','07:49:58','D',49,NULL,NULL,NULL,NULL),(175,5,14,5,'2023-11-15','04:53:42','D',1,NULL,NULL,NULL,NULL),(176,1,8,5,'2023-11-16','04:27:31','D',1,NULL,NULL,NULL,NULL),(177,2,10,2,'2023-11-16','11:55:00','D',30,NULL,NULL,NULL,NULL),(178,3,6,1,'2023-11-16','03:58:38','D',50,NULL,NULL,NULL,NULL),(179,4,3,3,'2023-11-16','07:49:58','D',49,NULL,NULL,NULL,NULL),(180,5,14,5,'2023-11-16','04:53:42','D',1,NULL,NULL,NULL,NULL),(181,1,8,5,'2023-11-17','04:27:31','D',1,NULL,NULL,NULL,NULL),(182,2,10,2,'2023-11-17','11:55:00','D',30,NULL,NULL,NULL,NULL),(183,3,6,1,'2023-11-17','03:58:38','D',50,NULL,NULL,NULL,NULL),(184,4,3,3,'2023-11-17','07:49:58','D',49,NULL,NULL,NULL,NULL),(185,5,14,5,'2023-11-17','04:53:42','D',1,NULL,NULL,NULL,NULL),(186,1,8,5,'2023-11-18','04:27:31','D',1,NULL,NULL,NULL,NULL),(187,2,10,2,'2023-11-18','11:55:00','D',30,NULL,NULL,NULL,NULL),(188,3,6,1,'2023-11-18','03:58:38','D',50,NULL,NULL,NULL,NULL),(189,4,3,3,'2023-11-18','07:49:58','D',49,NULL,NULL,NULL,NULL),(190,5,14,5,'2023-11-18','04:53:42','D',1,NULL,NULL,NULL,NULL),(191,1,8,5,'2023-11-19','04:27:31','D',1,NULL,NULL,NULL,NULL),(192,2,10,2,'2023-11-19','11:55:00','D',30,NULL,NULL,NULL,NULL),(193,3,6,1,'2023-11-19','03:58:38','D',50,NULL,NULL,NULL,NULL),(194,4,3,3,'2023-11-19','07:49:58','D',49,NULL,NULL,NULL,NULL),(195,5,14,5,'2023-11-19','04:53:42','D',1,NULL,NULL,NULL,NULL),(196,1,8,5,'2023-11-20','04:27:31','D',1,NULL,NULL,NULL,NULL),(197,2,10,2,'2023-11-20','11:55:00','D',30,NULL,NULL,NULL,NULL),(198,3,6,1,'2023-11-20','03:58:38','D',50,NULL,NULL,NULL,NULL),(199,4,3,3,'2023-11-20','07:49:58','D',49,NULL,NULL,NULL,NULL),(200,5,14,5,'2023-11-20','04:53:42','D',1,NULL,NULL,NULL,NULL),(201,1,8,5,'2023-11-21','04:27:31','D',1,NULL,NULL,NULL,NULL),(202,2,10,2,'2023-11-21','11:55:00','D',30,NULL,NULL,NULL,NULL),(203,3,6,1,'2023-11-21','03:58:38','D',50,NULL,NULL,NULL,NULL),(204,4,3,3,'2023-11-21','07:49:58','D',49,NULL,NULL,NULL,NULL),(205,5,14,5,'2023-11-21','04:53:42','D',1,NULL,NULL,NULL,NULL),(206,1,8,5,'2023-11-22','04:27:31','D',1,NULL,NULL,NULL,NULL),(207,2,10,2,'2023-11-22','11:55:00','D',30,NULL,NULL,NULL,NULL),(208,3,6,1,'2023-11-22','03:58:38','D',50,NULL,NULL,NULL,NULL),(209,4,3,3,'2023-11-22','07:49:58','D',49,NULL,NULL,NULL,NULL),(210,5,14,5,'2023-11-22','04:53:42','D',1,NULL,NULL,NULL,NULL),(211,1,8,5,'2023-11-23','04:27:31','D',1,NULL,NULL,NULL,NULL),(212,2,10,2,'2023-11-23','11:55:00','D',30,NULL,NULL,NULL,NULL),(213,3,6,1,'2023-11-23','03:58:38','D',50,NULL,NULL,NULL,NULL),(214,4,3,3,'2023-11-23','07:49:58','D',49,NULL,NULL,NULL,NULL),(215,5,14,5,'2023-11-23','04:53:42','D',1,NULL,NULL,NULL,NULL),(216,1,8,5,'2023-11-24','04:27:31','D',1,NULL,NULL,NULL,NULL),(217,2,10,2,'2023-11-24','11:55:00','D',30,NULL,NULL,NULL,NULL),(218,3,6,1,'2023-11-24','03:58:38','D',50,NULL,NULL,NULL,NULL),(219,4,3,3,'2023-11-24','07:49:58','D',49,NULL,NULL,NULL,NULL),(220,5,14,5,'2023-11-24','04:53:42','D',1,NULL,NULL,NULL,NULL),(221,1,8,5,'2023-11-25','04:27:31','D',1,NULL,NULL,NULL,NULL),(222,2,10,2,'2023-11-25','11:55:00','D',30,NULL,NULL,NULL,NULL),(223,3,6,1,'2023-11-25','03:58:38','D',50,NULL,NULL,NULL,NULL),(224,4,3,3,'2023-11-25','07:49:58','D',49,NULL,NULL,NULL,NULL),(225,5,14,5,'2023-11-25','04:53:42','D',1,NULL,NULL,NULL,NULL),(226,1,8,5,'2023-11-26','04:27:31','D',1,NULL,NULL,NULL,NULL),(227,2,10,2,'2023-11-26','11:55:00','D',30,NULL,NULL,NULL,NULL),(228,3,6,1,'2023-11-26','03:58:38','D',50,NULL,NULL,NULL,NULL),(229,4,3,3,'2023-11-26','07:49:58','D',49,NULL,NULL,NULL,NULL),(230,5,14,5,'2023-11-26','04:53:42','D',1,NULL,NULL,NULL,NULL),(231,1,8,5,'2023-11-27','04:27:31','D',1,NULL,NULL,NULL,NULL),(232,2,10,2,'2023-11-27','11:55:00','D',30,NULL,NULL,NULL,NULL),(233,3,6,1,'2023-11-27','03:58:38','D',50,NULL,NULL,NULL,NULL),(234,4,3,3,'2023-11-27','07:49:58','D',49,NULL,NULL,NULL,NULL),(235,5,14,5,'2023-11-27','04:53:42','D',1,NULL,NULL,NULL,NULL),(236,1,8,5,'2023-11-28','04:27:31','D',1,NULL,NULL,NULL,NULL),(237,2,10,2,'2023-11-28','11:55:00','D',30,NULL,NULL,NULL,NULL),(238,3,6,1,'2023-11-28','03:58:38','D',50,NULL,NULL,NULL,NULL),(239,4,3,3,'2023-11-28','07:49:58','D',49,NULL,NULL,NULL,NULL),(240,5,14,5,'2023-11-28','04:53:42','D',1,NULL,NULL,NULL,NULL),(241,1,8,5,'2023-11-29','04:27:31','D',1,NULL,NULL,NULL,NULL),(242,2,10,2,'2023-11-29','11:55:00','D',30,NULL,NULL,NULL,NULL),(243,3,6,1,'2023-11-29','03:58:38','D',50,NULL,NULL,NULL,NULL),(244,4,3,3,'2023-11-29','07:49:58','D',49,NULL,NULL,NULL,NULL),(245,5,14,5,'2023-11-29','04:53:42','D',1,NULL,NULL,NULL,NULL),(246,1,8,5,'2023-11-30','04:27:31','D',1,NULL,NULL,NULL,NULL),(247,2,10,2,'2023-11-30','11:55:00','D',30,NULL,NULL,NULL,NULL),(248,3,6,1,'2023-11-30','03:58:38','D',50,NULL,NULL,NULL,NULL),(249,4,3,3,'2023-11-30','07:49:58','D',49,NULL,NULL,NULL,NULL),(250,5,14,5,'2023-11-30','04:53:42','D',1,NULL,NULL,NULL,NULL),(251,1,8,5,'2023-12-01','04:27:31','D',1,NULL,NULL,NULL,NULL),(252,2,10,2,'2023-12-01','11:55:00','D',30,NULL,NULL,NULL,NULL),(253,3,6,1,'2023-12-01','03:58:38','D',50,NULL,NULL,NULL,NULL),(254,4,3,3,'2023-12-01','07:49:58','D',49,NULL,NULL,NULL,NULL),(255,5,14,5,'2023-12-01','04:53:42','D',1,NULL,NULL,NULL,NULL),(256,1,8,5,'2023-12-02','04:27:31','D',1,NULL,NULL,NULL,NULL),(257,2,10,2,'2023-12-02','11:55:00','D',30,NULL,NULL,NULL,NULL),(258,3,6,1,'2023-12-02','03:58:38','D',50,NULL,NULL,NULL,NULL),(259,4,3,3,'2023-12-02','07:49:58','D',49,NULL,NULL,NULL,NULL),(260,5,14,5,'2023-12-02','04:53:42','D',1,NULL,NULL,NULL,NULL),(261,1,8,5,'2023-12-03','04:27:31','D',1,NULL,NULL,NULL,NULL),(262,2,10,2,'2023-12-03','11:55:00','D',30,NULL,NULL,NULL,NULL),(263,3,6,1,'2023-12-03','03:58:38','D',50,NULL,NULL,NULL,NULL),(264,4,3,3,'2023-12-03','07:49:58','D',49,NULL,NULL,NULL,NULL),(265,5,14,5,'2023-12-03','04:53:42','D',1,NULL,NULL,NULL,NULL),(266,1,8,5,'2023-12-04','04:27:31','D',1,NULL,NULL,NULL,NULL),(267,2,10,2,'2023-12-04','11:55:00','D',30,NULL,NULL,NULL,NULL),(268,3,6,1,'2023-12-04','03:58:38','D',50,NULL,NULL,NULL,NULL),(269,4,3,3,'2023-12-04','07:49:58','D',49,NULL,NULL,NULL,NULL),(270,5,14,5,'2023-12-04','04:53:42','D',1,NULL,NULL,NULL,NULL),(271,1,8,5,'2023-12-05','04:27:31','D',1,NULL,NULL,NULL,NULL),(272,2,10,2,'2023-12-05','11:55:00','D',30,NULL,NULL,NULL,NULL),(273,3,6,1,'2023-12-05','03:58:38','D',50,NULL,NULL,NULL,NULL),(274,4,3,3,'2023-12-05','07:49:58','D',49,NULL,NULL,NULL,NULL),(275,5,14,5,'2023-12-05','04:53:42','D',1,NULL,NULL,NULL,NULL),(276,1,8,5,'2023-12-06','04:27:31','D',1,NULL,NULL,NULL,NULL),(277,2,10,2,'2023-12-06','11:55:00','D',30,NULL,NULL,NULL,NULL),(278,3,6,1,'2023-12-06','03:58:38','D',50,NULL,NULL,NULL,NULL),(279,4,3,3,'2023-12-06','07:49:58','D',49,NULL,NULL,NULL,NULL),(280,5,14,5,'2023-12-06','04:53:42','D',1,NULL,NULL,NULL,NULL),(281,1,8,5,'2023-12-07','04:27:31','D',1,NULL,NULL,NULL,NULL),(282,2,10,2,'2023-12-07','11:55:00','D',30,NULL,NULL,NULL,NULL),(283,3,6,1,'2023-12-07','03:58:38','D',50,NULL,NULL,NULL,NULL),(284,4,3,3,'2023-12-07','07:49:58','D',49,NULL,NULL,NULL,NULL),(285,5,14,5,'2023-12-07','04:53:42','D',1,NULL,NULL,NULL,NULL),(286,1,8,5,'2023-12-08','04:27:31','D',1,NULL,NULL,NULL,NULL),(287,2,10,2,'2023-12-08','11:55:00','D',30,NULL,NULL,NULL,NULL),(288,3,6,1,'2023-12-08','03:58:38','D',50,NULL,NULL,NULL,NULL),(289,4,3,3,'2023-12-08','07:49:58','D',49,NULL,NULL,NULL,NULL),(290,5,14,5,'2023-12-08','04:53:42','D',1,NULL,NULL,NULL,NULL),(291,1,8,5,'2023-12-09','04:27:31','D',1,NULL,NULL,NULL,NULL),(292,2,10,2,'2023-12-09','11:55:00','D',30,NULL,NULL,NULL,NULL),(293,3,6,1,'2023-12-09','03:58:38','D',50,NULL,NULL,NULL,NULL),(294,4,3,3,'2023-12-09','07:49:58','D',49,NULL,NULL,NULL,NULL),(295,5,14,5,'2023-12-09','04:53:42','D',1,NULL,NULL,NULL,NULL),(296,1,8,5,'2023-12-10','04:27:31','D',1,NULL,NULL,NULL,NULL),(297,2,10,2,'2023-12-10','11:55:00','D',30,NULL,NULL,NULL,NULL),(298,3,6,1,'2023-12-10','03:58:38','D',50,NULL,NULL,NULL,NULL),(299,4,3,3,'2023-12-10','07:49:58','D',49,NULL,NULL,NULL,NULL),(300,5,14,5,'2023-12-10','04:53:42','D',1,NULL,NULL,NULL,NULL),(301,1,8,5,'2023-12-11','04:27:31','D',1,NULL,NULL,NULL,NULL),(302,2,10,2,'2023-12-11','11:55:00','D',30,NULL,NULL,NULL,NULL),(303,3,6,1,'2023-12-11','03:58:38','D',50,NULL,NULL,NULL,NULL),(304,4,3,3,'2023-12-11','07:49:58','D',49,NULL,NULL,NULL,NULL),(305,5,14,5,'2023-12-11','04:53:42','D',1,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasprogramadas`
--

LOCK TABLES `corridasprogramadas` WRITE;
/*!40000 ALTER TABLE `corridasprogramadas` DISABLE KEYS */;
INSERT INTO `corridasprogramadas` VALUES (1,8,5,'04:27:31',1,1,1,1,1,1,1,'2023-10-12','2099-12-31',1,NULL,'2023-10-13 00:03:17','2023-10-12 18:03:17'),(2,10,2,'11:55:00',1,1,1,1,1,1,1,'2023-10-12','2099-12-31',1,NULL,'2023-10-13 00:03:17','2023-10-12 18:03:17'),(3,6,1,'03:58:38',1,1,1,1,1,1,1,'2023-10-12','2099-12-31',1,NULL,'2023-10-13 00:03:17','2023-10-12 18:03:17'),(4,3,3,'07:49:58',1,1,1,1,1,1,1,'2023-10-12','2099-12-31',1,NULL,'2023-10-13 00:03:17','2023-10-12 18:03:17'),(5,14,5,'04:53:42',1,1,1,1,1,1,1,'2023-10-12','2099-12-31',1,NULL,'2023-10-13 00:03:17','2023-10-12 18:03:17');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  KEY `disponibilidad_index` (`nNumero`,`nOrigen`,`nDestino`,`fSalida`,`hSalida`),
  CONSTRAINT `disponibilidad_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `disponibilidad_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `disponibilidad_ibfk_3` FOREIGN KEY (`nCorridaDisponible`) REFERENCES `corridasdisponibles` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=3234 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidad`
--

LOCK TABLES `disponibilidad` WRITE;
/*!40000 ALTER TABLE `disponibilidad` DISABLE KEYS */;
INSERT INTO `disponibilidad` VALUES (1,1,8,10,'2023-10-12','04:37:31','2023-10-12','04:27:31'),(2,1,8,5,'2023-10-12','04:48:31','2023-10-12','04:27:31'),(3,1,8,6,'2023-10-12','04:59:31','2023-10-12','04:27:31'),(4,1,8,11,'2023-10-12','05:10:31','2023-10-12','04:27:31'),(5,1,10,5,'2023-10-12','04:48:31','2023-10-12','04:38:31'),(6,1,10,6,'2023-10-12','04:59:31','2023-10-12','04:38:31'),(7,1,10,11,'2023-10-12','05:10:31','2023-10-12','04:38:31'),(8,1,5,6,'2023-10-12','04:59:31','2023-10-12','04:48:31'),(9,1,5,11,'2023-10-12','05:10:31','2023-10-12','04:48:31'),(10,1,6,11,'2023-10-12','05:10:31','2023-10-12','04:58:31'),(11,2,2,5,'2023-10-12','12:05:00','2023-10-12','11:55:00'),(12,2,2,10,'2023-10-12','12:16:00','2023-10-12','11:55:00'),(13,2,2,8,'2023-10-12','12:27:00','2023-10-12','11:55:00'),(14,2,5,10,'2023-10-12','12:16:00','2023-10-12','12:06:00'),(15,2,5,8,'2023-10-12','12:27:00','2023-10-12','12:06:00'),(16,2,10,8,'2023-10-12','12:27:00','2023-10-12','12:16:00'),(17,3,8,10,'2023-10-12','04:08:38','2023-10-12','03:58:38'),(18,3,8,5,'2023-10-12','04:19:38','2023-10-12','03:58:38'),(19,3,8,1,'2023-10-12','04:30:38','2023-10-12','03:58:38'),(20,3,8,3,'2023-10-12','04:41:38','2023-10-12','03:58:38'),(21,3,8,9,'2023-10-12','04:51:38','2023-10-12','03:58:38'),(22,3,8,4,'2023-10-12','05:01:38','2023-10-12','03:58:38'),(23,3,10,5,'2023-10-12','04:19:38','2023-10-12','04:09:38'),(24,3,10,1,'2023-10-12','04:30:38','2023-10-12','04:09:38'),(25,3,10,3,'2023-10-12','04:41:38','2023-10-12','04:09:38'),(26,3,10,9,'2023-10-12','04:51:38','2023-10-12','04:09:38'),(27,3,10,4,'2023-10-12','05:01:38','2023-10-12','04:09:38'),(28,3,5,1,'2023-10-12','04:30:38','2023-10-12','04:19:38'),(29,3,5,3,'2023-10-12','04:41:38','2023-10-12','04:19:38'),(30,3,5,9,'2023-10-12','04:51:38','2023-10-12','04:19:38'),(31,3,5,4,'2023-10-12','05:01:38','2023-10-12','04:19:38'),(32,3,1,3,'2023-10-12','04:41:38','2023-10-12','04:29:38'),(33,3,1,9,'2023-10-12','04:51:38','2023-10-12','04:29:38'),(34,3,1,4,'2023-10-12','05:01:38','2023-10-12','04:29:38'),(35,3,3,9,'2023-10-12','04:51:38','2023-10-12','04:39:38'),(36,3,3,4,'2023-10-12','05:01:38','2023-10-12','04:39:38'),(37,3,9,4,'2023-10-12','05:01:38','2023-10-12','04:49:38'),(38,4,8,10,'2023-10-12','07:59:58','2023-10-12','07:49:58'),(39,4,8,5,'2023-10-12','08:10:58','2023-10-12','07:49:58'),(40,4,8,1,'2023-10-12','08:21:58','2023-10-12','07:49:58'),(41,4,10,5,'2023-10-12','08:10:58','2023-10-12','08:00:58'),(42,4,10,1,'2023-10-12','08:21:58','2023-10-12','08:00:58'),(43,4,5,1,'2023-10-12','08:21:58','2023-10-12','08:10:58'),(44,5,3,1,'2023-10-12','05:03:42','2023-10-12','04:53:42'),(45,5,3,5,'2023-10-12','05:14:42','2023-10-12','04:53:42'),(46,5,3,10,'2023-10-12','05:25:42','2023-10-12','04:53:42'),(47,5,3,8,'2023-10-12','05:36:42','2023-10-12','04:53:42'),(48,5,1,5,'2023-10-12','05:14:42','2023-10-12','05:04:42'),(49,5,1,10,'2023-10-12','05:25:42','2023-10-12','05:04:42'),(50,5,1,8,'2023-10-12','05:36:42','2023-10-12','05:04:42'),(51,5,5,10,'2023-10-12','05:25:42','2023-10-12','05:14:42'),(52,5,5,8,'2023-10-12','05:36:42','2023-10-12','05:14:42'),(53,5,10,8,'2023-10-12','05:36:42','2023-10-12','05:24:42'),(54,6,8,10,'2023-10-13','04:37:31','2023-10-13','04:27:31'),(55,6,8,5,'2023-10-13','04:48:31','2023-10-13','04:27:31'),(56,6,8,6,'2023-10-13','04:59:31','2023-10-13','04:27:31'),(57,6,8,11,'2023-10-13','05:10:31','2023-10-13','04:27:31'),(58,6,10,5,'2023-10-13','04:48:31','2023-10-13','04:38:31'),(59,6,10,6,'2023-10-13','04:59:31','2023-10-13','04:38:31'),(60,6,10,11,'2023-10-13','05:10:31','2023-10-13','04:38:31'),(61,6,5,6,'2023-10-13','04:59:31','2023-10-13','04:48:31'),(62,6,5,11,'2023-10-13','05:10:31','2023-10-13','04:48:31'),(63,6,6,11,'2023-10-13','05:10:31','2023-10-13','04:58:31'),(64,7,2,5,'2023-10-13','12:05:00','2023-10-13','11:55:00'),(65,7,2,10,'2023-10-13','12:16:00','2023-10-13','11:55:00'),(66,7,2,8,'2023-10-13','12:27:00','2023-10-13','11:55:00'),(67,7,5,10,'2023-10-13','12:16:00','2023-10-13','12:06:00'),(68,7,5,8,'2023-10-13','12:27:00','2023-10-13','12:06:00'),(69,7,10,8,'2023-10-13','12:27:00','2023-10-13','12:16:00'),(70,8,8,10,'2023-10-13','04:08:38','2023-10-13','03:58:38'),(71,8,8,5,'2023-10-13','04:19:38','2023-10-13','03:58:38'),(72,8,8,1,'2023-10-13','04:30:38','2023-10-13','03:58:38'),(73,8,8,3,'2023-10-13','04:41:38','2023-10-13','03:58:38'),(74,8,8,9,'2023-10-13','04:51:38','2023-10-13','03:58:38'),(75,8,8,4,'2023-10-13','05:01:38','2023-10-13','03:58:38'),(76,8,10,5,'2023-10-13','04:19:38','2023-10-13','04:09:38'),(77,8,10,1,'2023-10-13','04:30:38','2023-10-13','04:09:38'),(78,8,10,3,'2023-10-13','04:41:38','2023-10-13','04:09:38'),(79,8,10,9,'2023-10-13','04:51:38','2023-10-13','04:09:38'),(80,8,10,4,'2023-10-13','05:01:38','2023-10-13','04:09:38'),(81,8,5,1,'2023-10-13','04:30:38','2023-10-13','04:19:38'),(82,8,5,3,'2023-10-13','04:41:38','2023-10-13','04:19:38'),(83,8,5,9,'2023-10-13','04:51:38','2023-10-13','04:19:38'),(84,8,5,4,'2023-10-13','05:01:38','2023-10-13','04:19:38'),(85,8,1,3,'2023-10-13','04:41:38','2023-10-13','04:29:38'),(86,8,1,9,'2023-10-13','04:51:38','2023-10-13','04:29:38'),(87,8,1,4,'2023-10-13','05:01:38','2023-10-13','04:29:38'),(88,8,3,9,'2023-10-13','04:51:38','2023-10-13','04:39:38'),(89,8,3,4,'2023-10-13','05:01:38','2023-10-13','04:39:38'),(90,8,9,4,'2023-10-13','05:01:38','2023-10-13','04:49:38'),(91,9,8,10,'2023-10-13','07:59:58','2023-10-13','07:49:58'),(92,9,8,5,'2023-10-13','08:10:58','2023-10-13','07:49:58'),(93,9,8,1,'2023-10-13','08:21:58','2023-10-13','07:49:58'),(94,9,10,5,'2023-10-13','08:10:58','2023-10-13','08:00:58'),(95,9,10,1,'2023-10-13','08:21:58','2023-10-13','08:00:58'),(96,9,5,1,'2023-10-13','08:21:58','2023-10-13','08:10:58'),(97,10,3,1,'2023-10-13','05:03:42','2023-10-13','04:53:42'),(98,10,3,5,'2023-10-13','05:14:42','2023-10-13','04:53:42'),(99,10,3,10,'2023-10-13','05:25:42','2023-10-13','04:53:42'),(100,10,3,8,'2023-10-13','05:36:42','2023-10-13','04:53:42'),(101,10,1,5,'2023-10-13','05:14:42','2023-10-13','05:04:42'),(102,10,1,10,'2023-10-13','05:25:42','2023-10-13','05:04:42'),(103,10,1,8,'2023-10-13','05:36:42','2023-10-13','05:04:42'),(104,10,5,10,'2023-10-13','05:25:42','2023-10-13','05:14:42'),(105,10,5,8,'2023-10-13','05:36:42','2023-10-13','05:14:42'),(106,10,10,8,'2023-10-13','05:36:42','2023-10-13','05:24:42'),(107,11,8,10,'2023-10-14','04:37:31','2023-10-14','04:27:31'),(108,11,8,5,'2023-10-14','04:48:31','2023-10-14','04:27:31'),(109,11,8,6,'2023-10-14','04:59:31','2023-10-14','04:27:31'),(110,11,8,11,'2023-10-14','05:10:31','2023-10-14','04:27:31'),(111,11,10,5,'2023-10-14','04:48:31','2023-10-14','04:38:31'),(112,11,10,6,'2023-10-14','04:59:31','2023-10-14','04:38:31'),(113,11,10,11,'2023-10-14','05:10:31','2023-10-14','04:38:31'),(114,11,5,6,'2023-10-14','04:59:31','2023-10-14','04:48:31'),(115,11,5,11,'2023-10-14','05:10:31','2023-10-14','04:48:31'),(116,11,6,11,'2023-10-14','05:10:31','2023-10-14','04:58:31'),(117,12,2,5,'2023-10-14','12:05:00','2023-10-14','11:55:00'),(118,12,2,10,'2023-10-14','12:16:00','2023-10-14','11:55:00'),(119,12,2,8,'2023-10-14','12:27:00','2023-10-14','11:55:00'),(120,12,5,10,'2023-10-14','12:16:00','2023-10-14','12:06:00'),(121,12,5,8,'2023-10-14','12:27:00','2023-10-14','12:06:00'),(122,12,10,8,'2023-10-14','12:27:00','2023-10-14','12:16:00'),(123,13,8,10,'2023-10-14','04:08:38','2023-10-14','03:58:38'),(124,13,8,5,'2023-10-14','04:19:38','2023-10-14','03:58:38'),(125,13,8,1,'2023-10-14','04:30:38','2023-10-14','03:58:38'),(126,13,8,3,'2023-10-14','04:41:38','2023-10-14','03:58:38'),(127,13,8,9,'2023-10-14','04:51:38','2023-10-14','03:58:38'),(128,13,8,4,'2023-10-14','05:01:38','2023-10-14','03:58:38'),(129,13,10,5,'2023-10-14','04:19:38','2023-10-14','04:09:38'),(130,13,10,1,'2023-10-14','04:30:38','2023-10-14','04:09:38'),(131,13,10,3,'2023-10-14','04:41:38','2023-10-14','04:09:38'),(132,13,10,9,'2023-10-14','04:51:38','2023-10-14','04:09:38'),(133,13,10,4,'2023-10-14','05:01:38','2023-10-14','04:09:38'),(134,13,5,1,'2023-10-14','04:30:38','2023-10-14','04:19:38'),(135,13,5,3,'2023-10-14','04:41:38','2023-10-14','04:19:38'),(136,13,5,9,'2023-10-14','04:51:38','2023-10-14','04:19:38'),(137,13,5,4,'2023-10-14','05:01:38','2023-10-14','04:19:38'),(138,13,1,3,'2023-10-14','04:41:38','2023-10-14','04:29:38'),(139,13,1,9,'2023-10-14','04:51:38','2023-10-14','04:29:38'),(140,13,1,4,'2023-10-14','05:01:38','2023-10-14','04:29:38'),(141,13,3,9,'2023-10-14','04:51:38','2023-10-14','04:39:38'),(142,13,3,4,'2023-10-14','05:01:38','2023-10-14','04:39:38'),(143,13,9,4,'2023-10-14','05:01:38','2023-10-14','04:49:38'),(144,14,8,10,'2023-10-14','07:59:58','2023-10-14','07:49:58'),(145,14,8,5,'2023-10-14','08:10:58','2023-10-14','07:49:58'),(146,14,8,1,'2023-10-14','08:21:58','2023-10-14','07:49:58'),(147,14,10,5,'2023-10-14','08:10:58','2023-10-14','08:00:58'),(148,14,10,1,'2023-10-14','08:21:58','2023-10-14','08:00:58'),(149,14,5,1,'2023-10-14','08:21:58','2023-10-14','08:10:58'),(150,15,3,1,'2023-10-14','05:03:42','2023-10-14','04:53:42'),(151,15,3,5,'2023-10-14','05:14:42','2023-10-14','04:53:42'),(152,15,3,10,'2023-10-14','05:25:42','2023-10-14','04:53:42'),(153,15,3,8,'2023-10-14','05:36:42','2023-10-14','04:53:42'),(154,15,1,5,'2023-10-14','05:14:42','2023-10-14','05:04:42'),(155,15,1,10,'2023-10-14','05:25:42','2023-10-14','05:04:42'),(156,15,1,8,'2023-10-14','05:36:42','2023-10-14','05:04:42'),(157,15,5,10,'2023-10-14','05:25:42','2023-10-14','05:14:42'),(158,15,5,8,'2023-10-14','05:36:42','2023-10-14','05:14:42'),(159,15,10,8,'2023-10-14','05:36:42','2023-10-14','05:24:42'),(160,16,8,10,'2023-10-15','04:37:31','2023-10-15','04:27:31'),(161,16,8,5,'2023-10-15','04:48:31','2023-10-15','04:27:31'),(162,16,8,6,'2023-10-15','04:59:31','2023-10-15','04:27:31'),(163,16,8,11,'2023-10-15','05:10:31','2023-10-15','04:27:31'),(164,16,10,5,'2023-10-15','04:48:31','2023-10-15','04:38:31'),(165,16,10,6,'2023-10-15','04:59:31','2023-10-15','04:38:31'),(166,16,10,11,'2023-10-15','05:10:31','2023-10-15','04:38:31'),(167,16,5,6,'2023-10-15','04:59:31','2023-10-15','04:48:31'),(168,16,5,11,'2023-10-15','05:10:31','2023-10-15','04:48:31'),(169,16,6,11,'2023-10-15','05:10:31','2023-10-15','04:58:31'),(170,17,2,5,'2023-10-15','12:05:00','2023-10-15','11:55:00'),(171,17,2,10,'2023-10-15','12:16:00','2023-10-15','11:55:00'),(172,17,2,8,'2023-10-15','12:27:00','2023-10-15','11:55:00'),(173,17,5,10,'2023-10-15','12:16:00','2023-10-15','12:06:00'),(174,17,5,8,'2023-10-15','12:27:00','2023-10-15','12:06:00'),(175,17,10,8,'2023-10-15','12:27:00','2023-10-15','12:16:00'),(176,18,8,10,'2023-10-15','04:08:38','2023-10-15','03:58:38'),(177,18,8,5,'2023-10-15','04:19:38','2023-10-15','03:58:38'),(178,18,8,1,'2023-10-15','04:30:38','2023-10-15','03:58:38'),(179,18,8,3,'2023-10-15','04:41:38','2023-10-15','03:58:38'),(180,18,8,9,'2023-10-15','04:51:38','2023-10-15','03:58:38'),(181,18,8,4,'2023-10-15','05:01:38','2023-10-15','03:58:38'),(182,18,10,5,'2023-10-15','04:19:38','2023-10-15','04:09:38'),(183,18,10,1,'2023-10-15','04:30:38','2023-10-15','04:09:38'),(184,18,10,3,'2023-10-15','04:41:38','2023-10-15','04:09:38'),(185,18,10,9,'2023-10-15','04:51:38','2023-10-15','04:09:38'),(186,18,10,4,'2023-10-15','05:01:38','2023-10-15','04:09:38'),(187,18,5,1,'2023-10-15','04:30:38','2023-10-15','04:19:38'),(188,18,5,3,'2023-10-15','04:41:38','2023-10-15','04:19:38'),(189,18,5,9,'2023-10-15','04:51:38','2023-10-15','04:19:38'),(190,18,5,4,'2023-10-15','05:01:38','2023-10-15','04:19:38'),(191,18,1,3,'2023-10-15','04:41:38','2023-10-15','04:29:38'),(192,18,1,9,'2023-10-15','04:51:38','2023-10-15','04:29:38'),(193,18,1,4,'2023-10-15','05:01:38','2023-10-15','04:29:38'),(194,18,3,9,'2023-10-15','04:51:38','2023-10-15','04:39:38'),(195,18,3,4,'2023-10-15','05:01:38','2023-10-15','04:39:38'),(196,18,9,4,'2023-10-15','05:01:38','2023-10-15','04:49:38'),(197,19,8,10,'2023-10-15','07:59:58','2023-10-15','07:49:58'),(198,19,8,5,'2023-10-15','08:10:58','2023-10-15','07:49:58'),(199,19,8,1,'2023-10-15','08:21:58','2023-10-15','07:49:58'),(200,19,10,5,'2023-10-15','08:10:58','2023-10-15','08:00:58'),(201,19,10,1,'2023-10-15','08:21:58','2023-10-15','08:00:58'),(202,19,5,1,'2023-10-15','08:21:58','2023-10-15','08:10:58'),(203,20,3,1,'2023-10-15','05:03:42','2023-10-15','04:53:42'),(204,20,3,5,'2023-10-15','05:14:42','2023-10-15','04:53:42'),(205,20,3,10,'2023-10-15','05:25:42','2023-10-15','04:53:42'),(206,20,3,8,'2023-10-15','05:36:42','2023-10-15','04:53:42'),(207,20,1,5,'2023-10-15','05:14:42','2023-10-15','05:04:42'),(208,20,1,10,'2023-10-15','05:25:42','2023-10-15','05:04:42'),(209,20,1,8,'2023-10-15','05:36:42','2023-10-15','05:04:42'),(210,20,5,10,'2023-10-15','05:25:42','2023-10-15','05:14:42'),(211,20,5,8,'2023-10-15','05:36:42','2023-10-15','05:14:42'),(212,20,10,8,'2023-10-15','05:36:42','2023-10-15','05:24:42'),(213,21,8,10,'2023-10-16','04:37:31','2023-10-16','04:27:31'),(214,21,8,5,'2023-10-16','04:48:31','2023-10-16','04:27:31'),(215,21,8,6,'2023-10-16','04:59:31','2023-10-16','04:27:31'),(216,21,8,11,'2023-10-16','05:10:31','2023-10-16','04:27:31'),(217,21,10,5,'2023-10-16','04:48:31','2023-10-16','04:38:31'),(218,21,10,6,'2023-10-16','04:59:31','2023-10-16','04:38:31'),(219,21,10,11,'2023-10-16','05:10:31','2023-10-16','04:38:31'),(220,21,5,6,'2023-10-16','04:59:31','2023-10-16','04:48:31'),(221,21,5,11,'2023-10-16','05:10:31','2023-10-16','04:48:31'),(222,21,6,11,'2023-10-16','05:10:31','2023-10-16','04:58:31'),(223,22,2,5,'2023-10-16','12:05:00','2023-10-16','11:55:00'),(224,22,2,10,'2023-10-16','12:16:00','2023-10-16','11:55:00'),(225,22,2,8,'2023-10-16','12:27:00','2023-10-16','11:55:00'),(226,22,5,10,'2023-10-16','12:16:00','2023-10-16','12:06:00'),(227,22,5,8,'2023-10-16','12:27:00','2023-10-16','12:06:00'),(228,22,10,8,'2023-10-16','12:27:00','2023-10-16','12:16:00'),(229,23,8,10,'2023-10-16','04:08:38','2023-10-16','03:58:38'),(230,23,8,5,'2023-10-16','04:19:38','2023-10-16','03:58:38'),(231,23,8,1,'2023-10-16','04:30:38','2023-10-16','03:58:38'),(232,23,8,3,'2023-10-16','04:41:38','2023-10-16','03:58:38'),(233,23,8,9,'2023-10-16','04:51:38','2023-10-16','03:58:38'),(234,23,8,4,'2023-10-16','05:01:38','2023-10-16','03:58:38'),(235,23,10,5,'2023-10-16','04:19:38','2023-10-16','04:09:38'),(236,23,10,1,'2023-10-16','04:30:38','2023-10-16','04:09:38'),(237,23,10,3,'2023-10-16','04:41:38','2023-10-16','04:09:38'),(238,23,10,9,'2023-10-16','04:51:38','2023-10-16','04:09:38'),(239,23,10,4,'2023-10-16','05:01:38','2023-10-16','04:09:38'),(240,23,5,1,'2023-10-16','04:30:38','2023-10-16','04:19:38'),(241,23,5,3,'2023-10-16','04:41:38','2023-10-16','04:19:38'),(242,23,5,9,'2023-10-16','04:51:38','2023-10-16','04:19:38'),(243,23,5,4,'2023-10-16','05:01:38','2023-10-16','04:19:38'),(244,23,1,3,'2023-10-16','04:41:38','2023-10-16','04:29:38'),(245,23,1,9,'2023-10-16','04:51:38','2023-10-16','04:29:38'),(246,23,1,4,'2023-10-16','05:01:38','2023-10-16','04:29:38'),(247,23,3,9,'2023-10-16','04:51:38','2023-10-16','04:39:38'),(248,23,3,4,'2023-10-16','05:01:38','2023-10-16','04:39:38'),(249,23,9,4,'2023-10-16','05:01:38','2023-10-16','04:49:38'),(250,24,8,10,'2023-10-16','07:59:58','2023-10-16','07:49:58'),(251,24,8,5,'2023-10-16','08:10:58','2023-10-16','07:49:58'),(252,24,8,1,'2023-10-16','08:21:58','2023-10-16','07:49:58'),(253,24,10,5,'2023-10-16','08:10:58','2023-10-16','08:00:58'),(254,24,10,1,'2023-10-16','08:21:58','2023-10-16','08:00:58'),(255,24,5,1,'2023-10-16','08:21:58','2023-10-16','08:10:58'),(256,25,3,1,'2023-10-16','05:03:42','2023-10-16','04:53:42'),(257,25,3,5,'2023-10-16','05:14:42','2023-10-16','04:53:42'),(258,25,3,10,'2023-10-16','05:25:42','2023-10-16','04:53:42'),(259,25,3,8,'2023-10-16','05:36:42','2023-10-16','04:53:42'),(260,25,1,5,'2023-10-16','05:14:42','2023-10-16','05:04:42'),(261,25,1,10,'2023-10-16','05:25:42','2023-10-16','05:04:42'),(262,25,1,8,'2023-10-16','05:36:42','2023-10-16','05:04:42'),(263,25,5,10,'2023-10-16','05:25:42','2023-10-16','05:14:42'),(264,25,5,8,'2023-10-16','05:36:42','2023-10-16','05:14:42'),(265,25,10,8,'2023-10-16','05:36:42','2023-10-16','05:24:42'),(266,26,8,10,'2023-10-17','04:37:31','2023-10-17','04:27:31'),(267,26,8,5,'2023-10-17','04:48:31','2023-10-17','04:27:31'),(268,26,8,6,'2023-10-17','04:59:31','2023-10-17','04:27:31'),(269,26,8,11,'2023-10-17','05:10:31','2023-10-17','04:27:31'),(270,26,10,5,'2023-10-17','04:48:31','2023-10-17','04:38:31'),(271,26,10,6,'2023-10-17','04:59:31','2023-10-17','04:38:31'),(272,26,10,11,'2023-10-17','05:10:31','2023-10-17','04:38:31'),(273,26,5,6,'2023-10-17','04:59:31','2023-10-17','04:48:31'),(274,26,5,11,'2023-10-17','05:10:31','2023-10-17','04:48:31'),(275,26,6,11,'2023-10-17','05:10:31','2023-10-17','04:58:31'),(276,27,2,5,'2023-10-17','12:05:00','2023-10-17','11:55:00'),(277,27,2,10,'2023-10-17','12:16:00','2023-10-17','11:55:00'),(278,27,2,8,'2023-10-17','12:27:00','2023-10-17','11:55:00'),(279,27,5,10,'2023-10-17','12:16:00','2023-10-17','12:06:00'),(280,27,5,8,'2023-10-17','12:27:00','2023-10-17','12:06:00'),(281,27,10,8,'2023-10-17','12:27:00','2023-10-17','12:16:00'),(282,28,8,10,'2023-10-17','04:08:38','2023-10-17','03:58:38'),(283,28,8,5,'2023-10-17','04:19:38','2023-10-17','03:58:38'),(284,28,8,1,'2023-10-17','04:30:38','2023-10-17','03:58:38'),(285,28,8,3,'2023-10-17','04:41:38','2023-10-17','03:58:38'),(286,28,8,9,'2023-10-17','04:51:38','2023-10-17','03:58:38'),(287,28,8,4,'2023-10-17','05:01:38','2023-10-17','03:58:38'),(288,28,10,5,'2023-10-17','04:19:38','2023-10-17','04:09:38'),(289,28,10,1,'2023-10-17','04:30:38','2023-10-17','04:09:38'),(290,28,10,3,'2023-10-17','04:41:38','2023-10-17','04:09:38'),(291,28,10,9,'2023-10-17','04:51:38','2023-10-17','04:09:38'),(292,28,10,4,'2023-10-17','05:01:38','2023-10-17','04:09:38'),(293,28,5,1,'2023-10-17','04:30:38','2023-10-17','04:19:38'),(294,28,5,3,'2023-10-17','04:41:38','2023-10-17','04:19:38'),(295,28,5,9,'2023-10-17','04:51:38','2023-10-17','04:19:38'),(296,28,5,4,'2023-10-17','05:01:38','2023-10-17','04:19:38'),(297,28,1,3,'2023-10-17','04:41:38','2023-10-17','04:29:38'),(298,28,1,9,'2023-10-17','04:51:38','2023-10-17','04:29:38'),(299,28,1,4,'2023-10-17','05:01:38','2023-10-17','04:29:38'),(300,28,3,9,'2023-10-17','04:51:38','2023-10-17','04:39:38'),(301,28,3,4,'2023-10-17','05:01:38','2023-10-17','04:39:38'),(302,28,9,4,'2023-10-17','05:01:38','2023-10-17','04:49:38'),(303,29,8,10,'2023-10-17','07:59:58','2023-10-17','07:49:58'),(304,29,8,5,'2023-10-17','08:10:58','2023-10-17','07:49:58'),(305,29,8,1,'2023-10-17','08:21:58','2023-10-17','07:49:58'),(306,29,10,5,'2023-10-17','08:10:58','2023-10-17','08:00:58'),(307,29,10,1,'2023-10-17','08:21:58','2023-10-17','08:00:58'),(308,29,5,1,'2023-10-17','08:21:58','2023-10-17','08:10:58'),(309,30,3,1,'2023-10-17','05:03:42','2023-10-17','04:53:42'),(310,30,3,5,'2023-10-17','05:14:42','2023-10-17','04:53:42'),(311,30,3,10,'2023-10-17','05:25:42','2023-10-17','04:53:42'),(312,30,3,8,'2023-10-17','05:36:42','2023-10-17','04:53:42'),(313,30,1,5,'2023-10-17','05:14:42','2023-10-17','05:04:42'),(314,30,1,10,'2023-10-17','05:25:42','2023-10-17','05:04:42'),(315,30,1,8,'2023-10-17','05:36:42','2023-10-17','05:04:42'),(316,30,5,10,'2023-10-17','05:25:42','2023-10-17','05:14:42'),(317,30,5,8,'2023-10-17','05:36:42','2023-10-17','05:14:42'),(318,30,10,8,'2023-10-17','05:36:42','2023-10-17','05:24:42'),(319,31,8,10,'2023-10-18','04:37:31','2023-10-18','04:27:31'),(320,31,8,5,'2023-10-18','04:48:31','2023-10-18','04:27:31'),(321,31,8,6,'2023-10-18','04:59:31','2023-10-18','04:27:31'),(322,31,8,11,'2023-10-18','05:10:31','2023-10-18','04:27:31'),(323,31,10,5,'2023-10-18','04:48:31','2023-10-18','04:38:31'),(324,31,10,6,'2023-10-18','04:59:31','2023-10-18','04:38:31'),(325,31,10,11,'2023-10-18','05:10:31','2023-10-18','04:38:31'),(326,31,5,6,'2023-10-18','04:59:31','2023-10-18','04:48:31'),(327,31,5,11,'2023-10-18','05:10:31','2023-10-18','04:48:31'),(328,31,6,11,'2023-10-18','05:10:31','2023-10-18','04:58:31'),(329,32,2,5,'2023-10-18','12:05:00','2023-10-18','11:55:00'),(330,32,2,10,'2023-10-18','12:16:00','2023-10-18','11:55:00'),(331,32,2,8,'2023-10-18','12:27:00','2023-10-18','11:55:00'),(332,32,5,10,'2023-10-18','12:16:00','2023-10-18','12:06:00'),(333,32,5,8,'2023-10-18','12:27:00','2023-10-18','12:06:00'),(334,32,10,8,'2023-10-18','12:27:00','2023-10-18','12:16:00'),(335,33,8,10,'2023-10-18','04:08:38','2023-10-18','03:58:38'),(336,33,8,5,'2023-10-18','04:19:38','2023-10-18','03:58:38'),(337,33,8,1,'2023-10-18','04:30:38','2023-10-18','03:58:38'),(338,33,8,3,'2023-10-18','04:41:38','2023-10-18','03:58:38'),(339,33,8,9,'2023-10-18','04:51:38','2023-10-18','03:58:38'),(340,33,8,4,'2023-10-18','05:01:38','2023-10-18','03:58:38'),(341,33,10,5,'2023-10-18','04:19:38','2023-10-18','04:09:38'),(342,33,10,1,'2023-10-18','04:30:38','2023-10-18','04:09:38'),(343,33,10,3,'2023-10-18','04:41:38','2023-10-18','04:09:38'),(344,33,10,9,'2023-10-18','04:51:38','2023-10-18','04:09:38'),(345,33,10,4,'2023-10-18','05:01:38','2023-10-18','04:09:38'),(346,33,5,1,'2023-10-18','04:30:38','2023-10-18','04:19:38'),(347,33,5,3,'2023-10-18','04:41:38','2023-10-18','04:19:38'),(348,33,5,9,'2023-10-18','04:51:38','2023-10-18','04:19:38'),(349,33,5,4,'2023-10-18','05:01:38','2023-10-18','04:19:38'),(350,33,1,3,'2023-10-18','04:41:38','2023-10-18','04:29:38'),(351,33,1,9,'2023-10-18','04:51:38','2023-10-18','04:29:38'),(352,33,1,4,'2023-10-18','05:01:38','2023-10-18','04:29:38'),(353,33,3,9,'2023-10-18','04:51:38','2023-10-18','04:39:38'),(354,33,3,4,'2023-10-18','05:01:38','2023-10-18','04:39:38'),(355,33,9,4,'2023-10-18','05:01:38','2023-10-18','04:49:38'),(356,34,8,10,'2023-10-18','07:59:58','2023-10-18','07:49:58'),(357,34,8,5,'2023-10-18','08:10:58','2023-10-18','07:49:58'),(358,34,8,1,'2023-10-18','08:21:58','2023-10-18','07:49:58'),(359,34,10,5,'2023-10-18','08:10:58','2023-10-18','08:00:58'),(360,34,10,1,'2023-10-18','08:21:58','2023-10-18','08:00:58'),(361,34,5,1,'2023-10-18','08:21:58','2023-10-18','08:10:58'),(362,35,3,1,'2023-10-18','05:03:42','2023-10-18','04:53:42'),(363,35,3,5,'2023-10-18','05:14:42','2023-10-18','04:53:42'),(364,35,3,10,'2023-10-18','05:25:42','2023-10-18','04:53:42'),(365,35,3,8,'2023-10-18','05:36:42','2023-10-18','04:53:42'),(366,35,1,5,'2023-10-18','05:14:42','2023-10-18','05:04:42'),(367,35,1,10,'2023-10-18','05:25:42','2023-10-18','05:04:42'),(368,35,1,8,'2023-10-18','05:36:42','2023-10-18','05:04:42'),(369,35,5,10,'2023-10-18','05:25:42','2023-10-18','05:14:42'),(370,35,5,8,'2023-10-18','05:36:42','2023-10-18','05:14:42'),(371,35,10,8,'2023-10-18','05:36:42','2023-10-18','05:24:42'),(372,36,8,10,'2023-10-19','04:37:31','2023-10-19','04:27:31'),(373,36,8,5,'2023-10-19','04:48:31','2023-10-19','04:27:31'),(374,36,8,6,'2023-10-19','04:59:31','2023-10-19','04:27:31'),(375,36,8,11,'2023-10-19','05:10:31','2023-10-19','04:27:31'),(376,36,10,5,'2023-10-19','04:48:31','2023-10-19','04:38:31'),(377,36,10,6,'2023-10-19','04:59:31','2023-10-19','04:38:31'),(378,36,10,11,'2023-10-19','05:10:31','2023-10-19','04:38:31'),(379,36,5,6,'2023-10-19','04:59:31','2023-10-19','04:48:31'),(380,36,5,11,'2023-10-19','05:10:31','2023-10-19','04:48:31'),(381,36,6,11,'2023-10-19','05:10:31','2023-10-19','04:58:31'),(382,37,2,5,'2023-10-19','12:05:00','2023-10-19','11:55:00'),(383,37,2,10,'2023-10-19','12:16:00','2023-10-19','11:55:00'),(384,37,2,8,'2023-10-19','12:27:00','2023-10-19','11:55:00'),(385,37,5,10,'2023-10-19','12:16:00','2023-10-19','12:06:00'),(386,37,5,8,'2023-10-19','12:27:00','2023-10-19','12:06:00'),(387,37,10,8,'2023-10-19','12:27:00','2023-10-19','12:16:00'),(388,38,8,10,'2023-10-19','04:08:38','2023-10-19','03:58:38'),(389,38,8,5,'2023-10-19','04:19:38','2023-10-19','03:58:38'),(390,38,8,1,'2023-10-19','04:30:38','2023-10-19','03:58:38'),(391,38,8,3,'2023-10-19','04:41:38','2023-10-19','03:58:38'),(392,38,8,9,'2023-10-19','04:51:38','2023-10-19','03:58:38'),(393,38,8,4,'2023-10-19','05:01:38','2023-10-19','03:58:38'),(394,38,10,5,'2023-10-19','04:19:38','2023-10-19','04:09:38'),(395,38,10,1,'2023-10-19','04:30:38','2023-10-19','04:09:38'),(396,38,10,3,'2023-10-19','04:41:38','2023-10-19','04:09:38'),(397,38,10,9,'2023-10-19','04:51:38','2023-10-19','04:09:38'),(398,38,10,4,'2023-10-19','05:01:38','2023-10-19','04:09:38'),(399,38,5,1,'2023-10-19','04:30:38','2023-10-19','04:19:38'),(400,38,5,3,'2023-10-19','04:41:38','2023-10-19','04:19:38'),(401,38,5,9,'2023-10-19','04:51:38','2023-10-19','04:19:38'),(402,38,5,4,'2023-10-19','05:01:38','2023-10-19','04:19:38'),(403,38,1,3,'2023-10-19','04:41:38','2023-10-19','04:29:38'),(404,38,1,9,'2023-10-19','04:51:38','2023-10-19','04:29:38'),(405,38,1,4,'2023-10-19','05:01:38','2023-10-19','04:29:38'),(406,38,3,9,'2023-10-19','04:51:38','2023-10-19','04:39:38'),(407,38,3,4,'2023-10-19','05:01:38','2023-10-19','04:39:38'),(408,38,9,4,'2023-10-19','05:01:38','2023-10-19','04:49:38'),(409,39,8,10,'2023-10-19','07:59:58','2023-10-19','07:49:58'),(410,39,8,5,'2023-10-19','08:10:58','2023-10-19','07:49:58'),(411,39,8,1,'2023-10-19','08:21:58','2023-10-19','07:49:58'),(412,39,10,5,'2023-10-19','08:10:58','2023-10-19','08:00:58'),(413,39,10,1,'2023-10-19','08:21:58','2023-10-19','08:00:58'),(414,39,5,1,'2023-10-19','08:21:58','2023-10-19','08:10:58'),(415,40,3,1,'2023-10-19','05:03:42','2023-10-19','04:53:42'),(416,40,3,5,'2023-10-19','05:14:42','2023-10-19','04:53:42'),(417,40,3,10,'2023-10-19','05:25:42','2023-10-19','04:53:42'),(418,40,3,8,'2023-10-19','05:36:42','2023-10-19','04:53:42'),(419,40,1,5,'2023-10-19','05:14:42','2023-10-19','05:04:42'),(420,40,1,10,'2023-10-19','05:25:42','2023-10-19','05:04:42'),(421,40,1,8,'2023-10-19','05:36:42','2023-10-19','05:04:42'),(422,40,5,10,'2023-10-19','05:25:42','2023-10-19','05:14:42'),(423,40,5,8,'2023-10-19','05:36:42','2023-10-19','05:14:42'),(424,40,10,8,'2023-10-19','05:36:42','2023-10-19','05:24:42'),(425,41,8,10,'2023-10-20','04:37:31','2023-10-20','04:27:31'),(426,41,8,5,'2023-10-20','04:48:31','2023-10-20','04:27:31'),(427,41,8,6,'2023-10-20','04:59:31','2023-10-20','04:27:31'),(428,41,8,11,'2023-10-20','05:10:31','2023-10-20','04:27:31'),(429,41,10,5,'2023-10-20','04:48:31','2023-10-20','04:38:31'),(430,41,10,6,'2023-10-20','04:59:31','2023-10-20','04:38:31'),(431,41,10,11,'2023-10-20','05:10:31','2023-10-20','04:38:31'),(432,41,5,6,'2023-10-20','04:59:31','2023-10-20','04:48:31'),(433,41,5,11,'2023-10-20','05:10:31','2023-10-20','04:48:31'),(434,41,6,11,'2023-10-20','05:10:31','2023-10-20','04:58:31'),(435,42,2,5,'2023-10-20','12:05:00','2023-10-20','11:55:00'),(436,42,2,10,'2023-10-20','12:16:00','2023-10-20','11:55:00'),(437,42,2,8,'2023-10-20','12:27:00','2023-10-20','11:55:00'),(438,42,5,10,'2023-10-20','12:16:00','2023-10-20','12:06:00'),(439,42,5,8,'2023-10-20','12:27:00','2023-10-20','12:06:00'),(440,42,10,8,'2023-10-20','12:27:00','2023-10-20','12:16:00'),(441,43,8,10,'2023-10-20','04:08:38','2023-10-20','03:58:38'),(442,43,8,5,'2023-10-20','04:19:38','2023-10-20','03:58:38'),(443,43,8,1,'2023-10-20','04:30:38','2023-10-20','03:58:38'),(444,43,8,3,'2023-10-20','04:41:38','2023-10-20','03:58:38'),(445,43,8,9,'2023-10-20','04:51:38','2023-10-20','03:58:38'),(446,43,8,4,'2023-10-20','05:01:38','2023-10-20','03:58:38'),(447,43,10,5,'2023-10-20','04:19:38','2023-10-20','04:09:38'),(448,43,10,1,'2023-10-20','04:30:38','2023-10-20','04:09:38'),(449,43,10,3,'2023-10-20','04:41:38','2023-10-20','04:09:38'),(450,43,10,9,'2023-10-20','04:51:38','2023-10-20','04:09:38'),(451,43,10,4,'2023-10-20','05:01:38','2023-10-20','04:09:38'),(452,43,5,1,'2023-10-20','04:30:38','2023-10-20','04:19:38'),(453,43,5,3,'2023-10-20','04:41:38','2023-10-20','04:19:38'),(454,43,5,9,'2023-10-20','04:51:38','2023-10-20','04:19:38'),(455,43,5,4,'2023-10-20','05:01:38','2023-10-20','04:19:38'),(456,43,1,3,'2023-10-20','04:41:38','2023-10-20','04:29:38'),(457,43,1,9,'2023-10-20','04:51:38','2023-10-20','04:29:38'),(458,43,1,4,'2023-10-20','05:01:38','2023-10-20','04:29:38'),(459,43,3,9,'2023-10-20','04:51:38','2023-10-20','04:39:38'),(460,43,3,4,'2023-10-20','05:01:38','2023-10-20','04:39:38'),(461,43,9,4,'2023-10-20','05:01:38','2023-10-20','04:49:38'),(462,44,8,10,'2023-10-20','07:59:58','2023-10-20','07:49:58'),(463,44,8,5,'2023-10-20','08:10:58','2023-10-20','07:49:58'),(464,44,8,1,'2023-10-20','08:21:58','2023-10-20','07:49:58'),(465,44,10,5,'2023-10-20','08:10:58','2023-10-20','08:00:58'),(466,44,10,1,'2023-10-20','08:21:58','2023-10-20','08:00:58'),(467,44,5,1,'2023-10-20','08:21:58','2023-10-20','08:10:58'),(468,45,3,1,'2023-10-20','05:03:42','2023-10-20','04:53:42'),(469,45,3,5,'2023-10-20','05:14:42','2023-10-20','04:53:42'),(470,45,3,10,'2023-10-20','05:25:42','2023-10-20','04:53:42'),(471,45,3,8,'2023-10-20','05:36:42','2023-10-20','04:53:42'),(472,45,1,5,'2023-10-20','05:14:42','2023-10-20','05:04:42'),(473,45,1,10,'2023-10-20','05:25:42','2023-10-20','05:04:42'),(474,45,1,8,'2023-10-20','05:36:42','2023-10-20','05:04:42'),(475,45,5,10,'2023-10-20','05:25:42','2023-10-20','05:14:42'),(476,45,5,8,'2023-10-20','05:36:42','2023-10-20','05:14:42'),(477,45,10,8,'2023-10-20','05:36:42','2023-10-20','05:24:42'),(478,46,8,10,'2023-10-21','04:37:31','2023-10-21','04:27:31'),(479,46,8,5,'2023-10-21','04:48:31','2023-10-21','04:27:31'),(480,46,8,6,'2023-10-21','04:59:31','2023-10-21','04:27:31'),(481,46,8,11,'2023-10-21','05:10:31','2023-10-21','04:27:31'),(482,46,10,5,'2023-10-21','04:48:31','2023-10-21','04:38:31'),(483,46,10,6,'2023-10-21','04:59:31','2023-10-21','04:38:31'),(484,46,10,11,'2023-10-21','05:10:31','2023-10-21','04:38:31'),(485,46,5,6,'2023-10-21','04:59:31','2023-10-21','04:48:31'),(486,46,5,11,'2023-10-21','05:10:31','2023-10-21','04:48:31'),(487,46,6,11,'2023-10-21','05:10:31','2023-10-21','04:58:31'),(488,47,2,5,'2023-10-21','12:05:00','2023-10-21','11:55:00'),(489,47,2,10,'2023-10-21','12:16:00','2023-10-21','11:55:00'),(490,47,2,8,'2023-10-21','12:27:00','2023-10-21','11:55:00'),(491,47,5,10,'2023-10-21','12:16:00','2023-10-21','12:06:00'),(492,47,5,8,'2023-10-21','12:27:00','2023-10-21','12:06:00'),(493,47,10,8,'2023-10-21','12:27:00','2023-10-21','12:16:00'),(494,48,8,10,'2023-10-21','04:08:38','2023-10-21','03:58:38'),(495,48,8,5,'2023-10-21','04:19:38','2023-10-21','03:58:38'),(496,48,8,1,'2023-10-21','04:30:38','2023-10-21','03:58:38'),(497,48,8,3,'2023-10-21','04:41:38','2023-10-21','03:58:38'),(498,48,8,9,'2023-10-21','04:51:38','2023-10-21','03:58:38'),(499,48,8,4,'2023-10-21','05:01:38','2023-10-21','03:58:38'),(500,48,10,5,'2023-10-21','04:19:38','2023-10-21','04:09:38'),(501,48,10,1,'2023-10-21','04:30:38','2023-10-21','04:09:38'),(502,48,10,3,'2023-10-21','04:41:38','2023-10-21','04:09:38'),(503,48,10,9,'2023-10-21','04:51:38','2023-10-21','04:09:38'),(504,48,10,4,'2023-10-21','05:01:38','2023-10-21','04:09:38'),(505,48,5,1,'2023-10-21','04:30:38','2023-10-21','04:19:38'),(506,48,5,3,'2023-10-21','04:41:38','2023-10-21','04:19:38'),(507,48,5,9,'2023-10-21','04:51:38','2023-10-21','04:19:38'),(508,48,5,4,'2023-10-21','05:01:38','2023-10-21','04:19:38'),(509,48,1,3,'2023-10-21','04:41:38','2023-10-21','04:29:38'),(510,48,1,9,'2023-10-21','04:51:38','2023-10-21','04:29:38'),(511,48,1,4,'2023-10-21','05:01:38','2023-10-21','04:29:38'),(512,48,3,9,'2023-10-21','04:51:38','2023-10-21','04:39:38'),(513,48,3,4,'2023-10-21','05:01:38','2023-10-21','04:39:38'),(514,48,9,4,'2023-10-21','05:01:38','2023-10-21','04:49:38'),(515,49,8,10,'2023-10-21','07:59:58','2023-10-21','07:49:58'),(516,49,8,5,'2023-10-21','08:10:58','2023-10-21','07:49:58'),(517,49,8,1,'2023-10-21','08:21:58','2023-10-21','07:49:58'),(518,49,10,5,'2023-10-21','08:10:58','2023-10-21','08:00:58'),(519,49,10,1,'2023-10-21','08:21:58','2023-10-21','08:00:58'),(520,49,5,1,'2023-10-21','08:21:58','2023-10-21','08:10:58'),(521,50,3,1,'2023-10-21','05:03:42','2023-10-21','04:53:42'),(522,50,3,5,'2023-10-21','05:14:42','2023-10-21','04:53:42'),(523,50,3,10,'2023-10-21','05:25:42','2023-10-21','04:53:42'),(524,50,3,8,'2023-10-21','05:36:42','2023-10-21','04:53:42'),(525,50,1,5,'2023-10-21','05:14:42','2023-10-21','05:04:42'),(526,50,1,10,'2023-10-21','05:25:42','2023-10-21','05:04:42'),(527,50,1,8,'2023-10-21','05:36:42','2023-10-21','05:04:42'),(528,50,5,10,'2023-10-21','05:25:42','2023-10-21','05:14:42'),(529,50,5,8,'2023-10-21','05:36:42','2023-10-21','05:14:42'),(530,50,10,8,'2023-10-21','05:36:42','2023-10-21','05:24:42'),(531,51,8,10,'2023-10-22','04:37:31','2023-10-22','04:27:31'),(532,51,8,5,'2023-10-22','04:48:31','2023-10-22','04:27:31'),(533,51,8,6,'2023-10-22','04:59:31','2023-10-22','04:27:31'),(534,51,8,11,'2023-10-22','05:10:31','2023-10-22','04:27:31'),(535,51,10,5,'2023-10-22','04:48:31','2023-10-22','04:38:31'),(536,51,10,6,'2023-10-22','04:59:31','2023-10-22','04:38:31'),(537,51,10,11,'2023-10-22','05:10:31','2023-10-22','04:38:31'),(538,51,5,6,'2023-10-22','04:59:31','2023-10-22','04:48:31'),(539,51,5,11,'2023-10-22','05:10:31','2023-10-22','04:48:31'),(540,51,6,11,'2023-10-22','05:10:31','2023-10-22','04:58:31'),(541,52,2,5,'2023-10-22','12:05:00','2023-10-22','11:55:00'),(542,52,2,10,'2023-10-22','12:16:00','2023-10-22','11:55:00'),(543,52,2,8,'2023-10-22','12:27:00','2023-10-22','11:55:00'),(544,52,5,10,'2023-10-22','12:16:00','2023-10-22','12:06:00'),(545,52,5,8,'2023-10-22','12:27:00','2023-10-22','12:06:00'),(546,52,10,8,'2023-10-22','12:27:00','2023-10-22','12:16:00'),(547,53,8,10,'2023-10-22','04:08:38','2023-10-22','03:58:38'),(548,53,8,5,'2023-10-22','04:19:38','2023-10-22','03:58:38'),(549,53,8,1,'2023-10-22','04:30:38','2023-10-22','03:58:38'),(550,53,8,3,'2023-10-22','04:41:38','2023-10-22','03:58:38'),(551,53,8,9,'2023-10-22','04:51:38','2023-10-22','03:58:38'),(552,53,8,4,'2023-10-22','05:01:38','2023-10-22','03:58:38'),(553,53,10,5,'2023-10-22','04:19:38','2023-10-22','04:09:38'),(554,53,10,1,'2023-10-22','04:30:38','2023-10-22','04:09:38'),(555,53,10,3,'2023-10-22','04:41:38','2023-10-22','04:09:38'),(556,53,10,9,'2023-10-22','04:51:38','2023-10-22','04:09:38'),(557,53,10,4,'2023-10-22','05:01:38','2023-10-22','04:09:38'),(558,53,5,1,'2023-10-22','04:30:38','2023-10-22','04:19:38'),(559,53,5,3,'2023-10-22','04:41:38','2023-10-22','04:19:38'),(560,53,5,9,'2023-10-22','04:51:38','2023-10-22','04:19:38'),(561,53,5,4,'2023-10-22','05:01:38','2023-10-22','04:19:38'),(562,53,1,3,'2023-10-22','04:41:38','2023-10-22','04:29:38'),(563,53,1,9,'2023-10-22','04:51:38','2023-10-22','04:29:38'),(564,53,1,4,'2023-10-22','05:01:38','2023-10-22','04:29:38'),(565,53,3,9,'2023-10-22','04:51:38','2023-10-22','04:39:38'),(566,53,3,4,'2023-10-22','05:01:38','2023-10-22','04:39:38'),(567,53,9,4,'2023-10-22','05:01:38','2023-10-22','04:49:38'),(568,54,8,10,'2023-10-22','07:59:58','2023-10-22','07:49:58'),(569,54,8,5,'2023-10-22','08:10:58','2023-10-22','07:49:58'),(570,54,8,1,'2023-10-22','08:21:58','2023-10-22','07:49:58'),(571,54,10,5,'2023-10-22','08:10:58','2023-10-22','08:00:58'),(572,54,10,1,'2023-10-22','08:21:58','2023-10-22','08:00:58'),(573,54,5,1,'2023-10-22','08:21:58','2023-10-22','08:10:58'),(574,55,3,1,'2023-10-22','05:03:42','2023-10-22','04:53:42'),(575,55,3,5,'2023-10-22','05:14:42','2023-10-22','04:53:42'),(576,55,3,10,'2023-10-22','05:25:42','2023-10-22','04:53:42'),(577,55,3,8,'2023-10-22','05:36:42','2023-10-22','04:53:42'),(578,55,1,5,'2023-10-22','05:14:42','2023-10-22','05:04:42'),(579,55,1,10,'2023-10-22','05:25:42','2023-10-22','05:04:42'),(580,55,1,8,'2023-10-22','05:36:42','2023-10-22','05:04:42'),(581,55,5,10,'2023-10-22','05:25:42','2023-10-22','05:14:42'),(582,55,5,8,'2023-10-22','05:36:42','2023-10-22','05:14:42'),(583,55,10,8,'2023-10-22','05:36:42','2023-10-22','05:24:42'),(584,56,8,10,'2023-10-23','04:37:31','2023-10-23','04:27:31'),(585,56,8,5,'2023-10-23','04:48:31','2023-10-23','04:27:31'),(586,56,8,6,'2023-10-23','04:59:31','2023-10-23','04:27:31'),(587,56,8,11,'2023-10-23','05:10:31','2023-10-23','04:27:31'),(588,56,10,5,'2023-10-23','04:48:31','2023-10-23','04:38:31'),(589,56,10,6,'2023-10-23','04:59:31','2023-10-23','04:38:31'),(590,56,10,11,'2023-10-23','05:10:31','2023-10-23','04:38:31'),(591,56,5,6,'2023-10-23','04:59:31','2023-10-23','04:48:31'),(592,56,5,11,'2023-10-23','05:10:31','2023-10-23','04:48:31'),(593,56,6,11,'2023-10-23','05:10:31','2023-10-23','04:58:31'),(594,57,2,5,'2023-10-23','12:05:00','2023-10-23','11:55:00'),(595,57,2,10,'2023-10-23','12:16:00','2023-10-23','11:55:00'),(596,57,2,8,'2023-10-23','12:27:00','2023-10-23','11:55:00'),(597,57,5,10,'2023-10-23','12:16:00','2023-10-23','12:06:00'),(598,57,5,8,'2023-10-23','12:27:00','2023-10-23','12:06:00'),(599,57,10,8,'2023-10-23','12:27:00','2023-10-23','12:16:00'),(600,58,8,10,'2023-10-23','04:08:38','2023-10-23','03:58:38'),(601,58,8,5,'2023-10-23','04:19:38','2023-10-23','03:58:38'),(602,58,8,1,'2023-10-23','04:30:38','2023-10-23','03:58:38'),(603,58,8,3,'2023-10-23','04:41:38','2023-10-23','03:58:38'),(604,58,8,9,'2023-10-23','04:51:38','2023-10-23','03:58:38'),(605,58,8,4,'2023-10-23','05:01:38','2023-10-23','03:58:38'),(606,58,10,5,'2023-10-23','04:19:38','2023-10-23','04:09:38'),(607,58,10,1,'2023-10-23','04:30:38','2023-10-23','04:09:38'),(608,58,10,3,'2023-10-23','04:41:38','2023-10-23','04:09:38'),(609,58,10,9,'2023-10-23','04:51:38','2023-10-23','04:09:38'),(610,58,10,4,'2023-10-23','05:01:38','2023-10-23','04:09:38'),(611,58,5,1,'2023-10-23','04:30:38','2023-10-23','04:19:38'),(612,58,5,3,'2023-10-23','04:41:38','2023-10-23','04:19:38'),(613,58,5,9,'2023-10-23','04:51:38','2023-10-23','04:19:38'),(614,58,5,4,'2023-10-23','05:01:38','2023-10-23','04:19:38'),(615,58,1,3,'2023-10-23','04:41:38','2023-10-23','04:29:38'),(616,58,1,9,'2023-10-23','04:51:38','2023-10-23','04:29:38'),(617,58,1,4,'2023-10-23','05:01:38','2023-10-23','04:29:38'),(618,58,3,9,'2023-10-23','04:51:38','2023-10-23','04:39:38'),(619,58,3,4,'2023-10-23','05:01:38','2023-10-23','04:39:38'),(620,58,9,4,'2023-10-23','05:01:38','2023-10-23','04:49:38'),(621,59,8,10,'2023-10-23','07:59:58','2023-10-23','07:49:58'),(622,59,8,5,'2023-10-23','08:10:58','2023-10-23','07:49:58'),(623,59,8,1,'2023-10-23','08:21:58','2023-10-23','07:49:58'),(624,59,10,5,'2023-10-23','08:10:58','2023-10-23','08:00:58'),(625,59,10,1,'2023-10-23','08:21:58','2023-10-23','08:00:58'),(626,59,5,1,'2023-10-23','08:21:58','2023-10-23','08:10:58'),(627,60,3,1,'2023-10-23','05:03:42','2023-10-23','04:53:42'),(628,60,3,5,'2023-10-23','05:14:42','2023-10-23','04:53:42'),(629,60,3,10,'2023-10-23','05:25:42','2023-10-23','04:53:42'),(630,60,3,8,'2023-10-23','05:36:42','2023-10-23','04:53:42'),(631,60,1,5,'2023-10-23','05:14:42','2023-10-23','05:04:42'),(632,60,1,10,'2023-10-23','05:25:42','2023-10-23','05:04:42'),(633,60,1,8,'2023-10-23','05:36:42','2023-10-23','05:04:42'),(634,60,5,10,'2023-10-23','05:25:42','2023-10-23','05:14:42'),(635,60,5,8,'2023-10-23','05:36:42','2023-10-23','05:14:42'),(636,60,10,8,'2023-10-23','05:36:42','2023-10-23','05:24:42'),(637,61,8,10,'2023-10-24','04:37:31','2023-10-24','04:27:31'),(638,61,8,5,'2023-10-24','04:48:31','2023-10-24','04:27:31'),(639,61,8,6,'2023-10-24','04:59:31','2023-10-24','04:27:31'),(640,61,8,11,'2023-10-24','05:10:31','2023-10-24','04:27:31'),(641,61,10,5,'2023-10-24','04:48:31','2023-10-24','04:38:31'),(642,61,10,6,'2023-10-24','04:59:31','2023-10-24','04:38:31'),(643,61,10,11,'2023-10-24','05:10:31','2023-10-24','04:38:31'),(644,61,5,6,'2023-10-24','04:59:31','2023-10-24','04:48:31'),(645,61,5,11,'2023-10-24','05:10:31','2023-10-24','04:48:31'),(646,61,6,11,'2023-10-24','05:10:31','2023-10-24','04:58:31'),(647,62,2,5,'2023-10-24','12:05:00','2023-10-24','11:55:00'),(648,62,2,10,'2023-10-24','12:16:00','2023-10-24','11:55:00'),(649,62,2,8,'2023-10-24','12:27:00','2023-10-24','11:55:00'),(650,62,5,10,'2023-10-24','12:16:00','2023-10-24','12:06:00'),(651,62,5,8,'2023-10-24','12:27:00','2023-10-24','12:06:00'),(652,62,10,8,'2023-10-24','12:27:00','2023-10-24','12:16:00'),(653,63,8,10,'2023-10-24','04:08:38','2023-10-24','03:58:38'),(654,63,8,5,'2023-10-24','04:19:38','2023-10-24','03:58:38'),(655,63,8,1,'2023-10-24','04:30:38','2023-10-24','03:58:38'),(656,63,8,3,'2023-10-24','04:41:38','2023-10-24','03:58:38'),(657,63,8,9,'2023-10-24','04:51:38','2023-10-24','03:58:38'),(658,63,8,4,'2023-10-24','05:01:38','2023-10-24','03:58:38'),(659,63,10,5,'2023-10-24','04:19:38','2023-10-24','04:09:38'),(660,63,10,1,'2023-10-24','04:30:38','2023-10-24','04:09:38'),(661,63,10,3,'2023-10-24','04:41:38','2023-10-24','04:09:38'),(662,63,10,9,'2023-10-24','04:51:38','2023-10-24','04:09:38'),(663,63,10,4,'2023-10-24','05:01:38','2023-10-24','04:09:38'),(664,63,5,1,'2023-10-24','04:30:38','2023-10-24','04:19:38'),(665,63,5,3,'2023-10-24','04:41:38','2023-10-24','04:19:38'),(666,63,5,9,'2023-10-24','04:51:38','2023-10-24','04:19:38'),(667,63,5,4,'2023-10-24','05:01:38','2023-10-24','04:19:38'),(668,63,1,3,'2023-10-24','04:41:38','2023-10-24','04:29:38'),(669,63,1,9,'2023-10-24','04:51:38','2023-10-24','04:29:38'),(670,63,1,4,'2023-10-24','05:01:38','2023-10-24','04:29:38'),(671,63,3,9,'2023-10-24','04:51:38','2023-10-24','04:39:38'),(672,63,3,4,'2023-10-24','05:01:38','2023-10-24','04:39:38'),(673,63,9,4,'2023-10-24','05:01:38','2023-10-24','04:49:38'),(674,64,8,10,'2023-10-24','07:59:58','2023-10-24','07:49:58'),(675,64,8,5,'2023-10-24','08:10:58','2023-10-24','07:49:58'),(676,64,8,1,'2023-10-24','08:21:58','2023-10-24','07:49:58'),(677,64,10,5,'2023-10-24','08:10:58','2023-10-24','08:00:58'),(678,64,10,1,'2023-10-24','08:21:58','2023-10-24','08:00:58'),(679,64,5,1,'2023-10-24','08:21:58','2023-10-24','08:10:58'),(680,65,3,1,'2023-10-24','05:03:42','2023-10-24','04:53:42'),(681,65,3,5,'2023-10-24','05:14:42','2023-10-24','04:53:42'),(682,65,3,10,'2023-10-24','05:25:42','2023-10-24','04:53:42'),(683,65,3,8,'2023-10-24','05:36:42','2023-10-24','04:53:42'),(684,65,1,5,'2023-10-24','05:14:42','2023-10-24','05:04:42'),(685,65,1,10,'2023-10-24','05:25:42','2023-10-24','05:04:42'),(686,65,1,8,'2023-10-24','05:36:42','2023-10-24','05:04:42'),(687,65,5,10,'2023-10-24','05:25:42','2023-10-24','05:14:42'),(688,65,5,8,'2023-10-24','05:36:42','2023-10-24','05:14:42'),(689,65,10,8,'2023-10-24','05:36:42','2023-10-24','05:24:42'),(690,66,8,10,'2023-10-25','04:37:31','2023-10-25','04:27:31'),(691,66,8,5,'2023-10-25','04:48:31','2023-10-25','04:27:31'),(692,66,8,6,'2023-10-25','04:59:31','2023-10-25','04:27:31'),(693,66,8,11,'2023-10-25','05:10:31','2023-10-25','04:27:31'),(694,66,10,5,'2023-10-25','04:48:31','2023-10-25','04:38:31'),(695,66,10,6,'2023-10-25','04:59:31','2023-10-25','04:38:31'),(696,66,10,11,'2023-10-25','05:10:31','2023-10-25','04:38:31'),(697,66,5,6,'2023-10-25','04:59:31','2023-10-25','04:48:31'),(698,66,5,11,'2023-10-25','05:10:31','2023-10-25','04:48:31'),(699,66,6,11,'2023-10-25','05:10:31','2023-10-25','04:58:31'),(700,67,2,5,'2023-10-25','12:05:00','2023-10-25','11:55:00'),(701,67,2,10,'2023-10-25','12:16:00','2023-10-25','11:55:00'),(702,67,2,8,'2023-10-25','12:27:00','2023-10-25','11:55:00'),(703,67,5,10,'2023-10-25','12:16:00','2023-10-25','12:06:00'),(704,67,5,8,'2023-10-25','12:27:00','2023-10-25','12:06:00'),(705,67,10,8,'2023-10-25','12:27:00','2023-10-25','12:16:00'),(706,68,8,10,'2023-10-25','04:08:38','2023-10-25','03:58:38'),(707,68,8,5,'2023-10-25','04:19:38','2023-10-25','03:58:38'),(708,68,8,1,'2023-10-25','04:30:38','2023-10-25','03:58:38'),(709,68,8,3,'2023-10-25','04:41:38','2023-10-25','03:58:38'),(710,68,8,9,'2023-10-25','04:51:38','2023-10-25','03:58:38'),(711,68,8,4,'2023-10-25','05:01:38','2023-10-25','03:58:38'),(712,68,10,5,'2023-10-25','04:19:38','2023-10-25','04:09:38'),(713,68,10,1,'2023-10-25','04:30:38','2023-10-25','04:09:38'),(714,68,10,3,'2023-10-25','04:41:38','2023-10-25','04:09:38'),(715,68,10,9,'2023-10-25','04:51:38','2023-10-25','04:09:38'),(716,68,10,4,'2023-10-25','05:01:38','2023-10-25','04:09:38'),(717,68,5,1,'2023-10-25','04:30:38','2023-10-25','04:19:38'),(718,68,5,3,'2023-10-25','04:41:38','2023-10-25','04:19:38'),(719,68,5,9,'2023-10-25','04:51:38','2023-10-25','04:19:38'),(720,68,5,4,'2023-10-25','05:01:38','2023-10-25','04:19:38'),(721,68,1,3,'2023-10-25','04:41:38','2023-10-25','04:29:38'),(722,68,1,9,'2023-10-25','04:51:38','2023-10-25','04:29:38'),(723,68,1,4,'2023-10-25','05:01:38','2023-10-25','04:29:38'),(724,68,3,9,'2023-10-25','04:51:38','2023-10-25','04:39:38'),(725,68,3,4,'2023-10-25','05:01:38','2023-10-25','04:39:38'),(726,68,9,4,'2023-10-25','05:01:38','2023-10-25','04:49:38'),(727,69,8,10,'2023-10-25','07:59:58','2023-10-25','07:49:58'),(728,69,8,5,'2023-10-25','08:10:58','2023-10-25','07:49:58'),(729,69,8,1,'2023-10-25','08:21:58','2023-10-25','07:49:58'),(730,69,10,5,'2023-10-25','08:10:58','2023-10-25','08:00:58'),(731,69,10,1,'2023-10-25','08:21:58','2023-10-25','08:00:58'),(732,69,5,1,'2023-10-25','08:21:58','2023-10-25','08:10:58'),(733,70,3,1,'2023-10-25','05:03:42','2023-10-25','04:53:42'),(734,70,3,5,'2023-10-25','05:14:42','2023-10-25','04:53:42'),(735,70,3,10,'2023-10-25','05:25:42','2023-10-25','04:53:42'),(736,70,3,8,'2023-10-25','05:36:42','2023-10-25','04:53:42'),(737,70,1,5,'2023-10-25','05:14:42','2023-10-25','05:04:42'),(738,70,1,10,'2023-10-25','05:25:42','2023-10-25','05:04:42'),(739,70,1,8,'2023-10-25','05:36:42','2023-10-25','05:04:42'),(740,70,5,10,'2023-10-25','05:25:42','2023-10-25','05:14:42'),(741,70,5,8,'2023-10-25','05:36:42','2023-10-25','05:14:42'),(742,70,10,8,'2023-10-25','05:36:42','2023-10-25','05:24:42'),(743,71,8,10,'2023-10-26','04:37:31','2023-10-26','04:27:31'),(744,71,8,5,'2023-10-26','04:48:31','2023-10-26','04:27:31'),(745,71,8,6,'2023-10-26','04:59:31','2023-10-26','04:27:31'),(746,71,8,11,'2023-10-26','05:10:31','2023-10-26','04:27:31'),(747,71,10,5,'2023-10-26','04:48:31','2023-10-26','04:38:31'),(748,71,10,6,'2023-10-26','04:59:31','2023-10-26','04:38:31'),(749,71,10,11,'2023-10-26','05:10:31','2023-10-26','04:38:31'),(750,71,5,6,'2023-10-26','04:59:31','2023-10-26','04:48:31'),(751,71,5,11,'2023-10-26','05:10:31','2023-10-26','04:48:31'),(752,71,6,11,'2023-10-26','05:10:31','2023-10-26','04:58:31'),(753,72,2,5,'2023-10-26','12:05:00','2023-10-26','11:55:00'),(754,72,2,10,'2023-10-26','12:16:00','2023-10-26','11:55:00'),(755,72,2,8,'2023-10-26','12:27:00','2023-10-26','11:55:00'),(756,72,5,10,'2023-10-26','12:16:00','2023-10-26','12:06:00'),(757,72,5,8,'2023-10-26','12:27:00','2023-10-26','12:06:00'),(758,72,10,8,'2023-10-26','12:27:00','2023-10-26','12:16:00'),(759,73,8,10,'2023-10-26','04:08:38','2023-10-26','03:58:38'),(760,73,8,5,'2023-10-26','04:19:38','2023-10-26','03:58:38'),(761,73,8,1,'2023-10-26','04:30:38','2023-10-26','03:58:38'),(762,73,8,3,'2023-10-26','04:41:38','2023-10-26','03:58:38'),(763,73,8,9,'2023-10-26','04:51:38','2023-10-26','03:58:38'),(764,73,8,4,'2023-10-26','05:01:38','2023-10-26','03:58:38'),(765,73,10,5,'2023-10-26','04:19:38','2023-10-26','04:09:38'),(766,73,10,1,'2023-10-26','04:30:38','2023-10-26','04:09:38'),(767,73,10,3,'2023-10-26','04:41:38','2023-10-26','04:09:38'),(768,73,10,9,'2023-10-26','04:51:38','2023-10-26','04:09:38'),(769,73,10,4,'2023-10-26','05:01:38','2023-10-26','04:09:38'),(770,73,5,1,'2023-10-26','04:30:38','2023-10-26','04:19:38'),(771,73,5,3,'2023-10-26','04:41:38','2023-10-26','04:19:38'),(772,73,5,9,'2023-10-26','04:51:38','2023-10-26','04:19:38'),(773,73,5,4,'2023-10-26','05:01:38','2023-10-26','04:19:38'),(774,73,1,3,'2023-10-26','04:41:38','2023-10-26','04:29:38'),(775,73,1,9,'2023-10-26','04:51:38','2023-10-26','04:29:38'),(776,73,1,4,'2023-10-26','05:01:38','2023-10-26','04:29:38'),(777,73,3,9,'2023-10-26','04:51:38','2023-10-26','04:39:38'),(778,73,3,4,'2023-10-26','05:01:38','2023-10-26','04:39:38'),(779,73,9,4,'2023-10-26','05:01:38','2023-10-26','04:49:38'),(780,74,8,10,'2023-10-26','07:59:58','2023-10-26','07:49:58'),(781,74,8,5,'2023-10-26','08:10:58','2023-10-26','07:49:58'),(782,74,8,1,'2023-10-26','08:21:58','2023-10-26','07:49:58'),(783,74,10,5,'2023-10-26','08:10:58','2023-10-26','08:00:58'),(784,74,10,1,'2023-10-26','08:21:58','2023-10-26','08:00:58'),(785,74,5,1,'2023-10-26','08:21:58','2023-10-26','08:10:58'),(786,75,3,1,'2023-10-26','05:03:42','2023-10-26','04:53:42'),(787,75,3,5,'2023-10-26','05:14:42','2023-10-26','04:53:42'),(788,75,3,10,'2023-10-26','05:25:42','2023-10-26','04:53:42'),(789,75,3,8,'2023-10-26','05:36:42','2023-10-26','04:53:42'),(790,75,1,5,'2023-10-26','05:14:42','2023-10-26','05:04:42'),(791,75,1,10,'2023-10-26','05:25:42','2023-10-26','05:04:42'),(792,75,1,8,'2023-10-26','05:36:42','2023-10-26','05:04:42'),(793,75,5,10,'2023-10-26','05:25:42','2023-10-26','05:14:42'),(794,75,5,8,'2023-10-26','05:36:42','2023-10-26','05:14:42'),(795,75,10,8,'2023-10-26','05:36:42','2023-10-26','05:24:42'),(796,76,8,10,'2023-10-27','04:37:31','2023-10-27','04:27:31'),(797,76,8,5,'2023-10-27','04:48:31','2023-10-27','04:27:31'),(798,76,8,6,'2023-10-27','04:59:31','2023-10-27','04:27:31'),(799,76,8,11,'2023-10-27','05:10:31','2023-10-27','04:27:31'),(800,76,10,5,'2023-10-27','04:48:31','2023-10-27','04:38:31'),(801,76,10,6,'2023-10-27','04:59:31','2023-10-27','04:38:31'),(802,76,10,11,'2023-10-27','05:10:31','2023-10-27','04:38:31'),(803,76,5,6,'2023-10-27','04:59:31','2023-10-27','04:48:31'),(804,76,5,11,'2023-10-27','05:10:31','2023-10-27','04:48:31'),(805,76,6,11,'2023-10-27','05:10:31','2023-10-27','04:58:31'),(806,77,2,5,'2023-10-27','12:05:00','2023-10-27','11:55:00'),(807,77,2,10,'2023-10-27','12:16:00','2023-10-27','11:55:00'),(808,77,2,8,'2023-10-27','12:27:00','2023-10-27','11:55:00'),(809,77,5,10,'2023-10-27','12:16:00','2023-10-27','12:06:00'),(810,77,5,8,'2023-10-27','12:27:00','2023-10-27','12:06:00'),(811,77,10,8,'2023-10-27','12:27:00','2023-10-27','12:16:00'),(812,78,8,10,'2023-10-27','04:08:38','2023-10-27','03:58:38'),(813,78,8,5,'2023-10-27','04:19:38','2023-10-27','03:58:38'),(814,78,8,1,'2023-10-27','04:30:38','2023-10-27','03:58:38'),(815,78,8,3,'2023-10-27','04:41:38','2023-10-27','03:58:38'),(816,78,8,9,'2023-10-27','04:51:38','2023-10-27','03:58:38'),(817,78,8,4,'2023-10-27','05:01:38','2023-10-27','03:58:38'),(818,78,10,5,'2023-10-27','04:19:38','2023-10-27','04:09:38'),(819,78,10,1,'2023-10-27','04:30:38','2023-10-27','04:09:38'),(820,78,10,3,'2023-10-27','04:41:38','2023-10-27','04:09:38'),(821,78,10,9,'2023-10-27','04:51:38','2023-10-27','04:09:38'),(822,78,10,4,'2023-10-27','05:01:38','2023-10-27','04:09:38'),(823,78,5,1,'2023-10-27','04:30:38','2023-10-27','04:19:38'),(824,78,5,3,'2023-10-27','04:41:38','2023-10-27','04:19:38'),(825,78,5,9,'2023-10-27','04:51:38','2023-10-27','04:19:38'),(826,78,5,4,'2023-10-27','05:01:38','2023-10-27','04:19:38'),(827,78,1,3,'2023-10-27','04:41:38','2023-10-27','04:29:38'),(828,78,1,9,'2023-10-27','04:51:38','2023-10-27','04:29:38'),(829,78,1,4,'2023-10-27','05:01:38','2023-10-27','04:29:38'),(830,78,3,9,'2023-10-27','04:51:38','2023-10-27','04:39:38'),(831,78,3,4,'2023-10-27','05:01:38','2023-10-27','04:39:38'),(832,78,9,4,'2023-10-27','05:01:38','2023-10-27','04:49:38'),(833,79,8,10,'2023-10-27','07:59:58','2023-10-27','07:49:58'),(834,79,8,5,'2023-10-27','08:10:58','2023-10-27','07:49:58'),(835,79,8,1,'2023-10-27','08:21:58','2023-10-27','07:49:58'),(836,79,10,5,'2023-10-27','08:10:58','2023-10-27','08:00:58'),(837,79,10,1,'2023-10-27','08:21:58','2023-10-27','08:00:58'),(838,79,5,1,'2023-10-27','08:21:58','2023-10-27','08:10:58'),(839,80,3,1,'2023-10-27','05:03:42','2023-10-27','04:53:42'),(840,80,3,5,'2023-10-27','05:14:42','2023-10-27','04:53:42'),(841,80,3,10,'2023-10-27','05:25:42','2023-10-27','04:53:42'),(842,80,3,8,'2023-10-27','05:36:42','2023-10-27','04:53:42'),(843,80,1,5,'2023-10-27','05:14:42','2023-10-27','05:04:42'),(844,80,1,10,'2023-10-27','05:25:42','2023-10-27','05:04:42'),(845,80,1,8,'2023-10-27','05:36:42','2023-10-27','05:04:42'),(846,80,5,10,'2023-10-27','05:25:42','2023-10-27','05:14:42'),(847,80,5,8,'2023-10-27','05:36:42','2023-10-27','05:14:42'),(848,80,10,8,'2023-10-27','05:36:42','2023-10-27','05:24:42'),(849,81,8,10,'2023-10-28','04:37:31','2023-10-28','04:27:31'),(850,81,8,5,'2023-10-28','04:48:31','2023-10-28','04:27:31'),(851,81,8,6,'2023-10-28','04:59:31','2023-10-28','04:27:31'),(852,81,8,11,'2023-10-28','05:10:31','2023-10-28','04:27:31'),(853,81,10,5,'2023-10-28','04:48:31','2023-10-28','04:38:31'),(854,81,10,6,'2023-10-28','04:59:31','2023-10-28','04:38:31'),(855,81,10,11,'2023-10-28','05:10:31','2023-10-28','04:38:31'),(856,81,5,6,'2023-10-28','04:59:31','2023-10-28','04:48:31'),(857,81,5,11,'2023-10-28','05:10:31','2023-10-28','04:48:31'),(858,81,6,11,'2023-10-28','05:10:31','2023-10-28','04:58:31'),(859,82,2,5,'2023-10-28','12:05:00','2023-10-28','11:55:00'),(860,82,2,10,'2023-10-28','12:16:00','2023-10-28','11:55:00'),(861,82,2,8,'2023-10-28','12:27:00','2023-10-28','11:55:00'),(862,82,5,10,'2023-10-28','12:16:00','2023-10-28','12:06:00'),(863,82,5,8,'2023-10-28','12:27:00','2023-10-28','12:06:00'),(864,82,10,8,'2023-10-28','12:27:00','2023-10-28','12:16:00'),(865,83,8,10,'2023-10-28','04:08:38','2023-10-28','03:58:38'),(866,83,8,5,'2023-10-28','04:19:38','2023-10-28','03:58:38'),(867,83,8,1,'2023-10-28','04:30:38','2023-10-28','03:58:38'),(868,83,8,3,'2023-10-28','04:41:38','2023-10-28','03:58:38'),(869,83,8,9,'2023-10-28','04:51:38','2023-10-28','03:58:38'),(870,83,8,4,'2023-10-28','05:01:38','2023-10-28','03:58:38'),(871,83,10,5,'2023-10-28','04:19:38','2023-10-28','04:09:38'),(872,83,10,1,'2023-10-28','04:30:38','2023-10-28','04:09:38'),(873,83,10,3,'2023-10-28','04:41:38','2023-10-28','04:09:38'),(874,83,10,9,'2023-10-28','04:51:38','2023-10-28','04:09:38'),(875,83,10,4,'2023-10-28','05:01:38','2023-10-28','04:09:38'),(876,83,5,1,'2023-10-28','04:30:38','2023-10-28','04:19:38'),(877,83,5,3,'2023-10-28','04:41:38','2023-10-28','04:19:38'),(878,83,5,9,'2023-10-28','04:51:38','2023-10-28','04:19:38'),(879,83,5,4,'2023-10-28','05:01:38','2023-10-28','04:19:38'),(880,83,1,3,'2023-10-28','04:41:38','2023-10-28','04:29:38'),(881,83,1,9,'2023-10-28','04:51:38','2023-10-28','04:29:38'),(882,83,1,4,'2023-10-28','05:01:38','2023-10-28','04:29:38'),(883,83,3,9,'2023-10-28','04:51:38','2023-10-28','04:39:38'),(884,83,3,4,'2023-10-28','05:01:38','2023-10-28','04:39:38'),(885,83,9,4,'2023-10-28','05:01:38','2023-10-28','04:49:38'),(886,84,8,10,'2023-10-28','07:59:58','2023-10-28','07:49:58'),(887,84,8,5,'2023-10-28','08:10:58','2023-10-28','07:49:58'),(888,84,8,1,'2023-10-28','08:21:58','2023-10-28','07:49:58'),(889,84,10,5,'2023-10-28','08:10:58','2023-10-28','08:00:58'),(890,84,10,1,'2023-10-28','08:21:58','2023-10-28','08:00:58'),(891,84,5,1,'2023-10-28','08:21:58','2023-10-28','08:10:58'),(892,85,3,1,'2023-10-28','05:03:42','2023-10-28','04:53:42'),(893,85,3,5,'2023-10-28','05:14:42','2023-10-28','04:53:42'),(894,85,3,10,'2023-10-28','05:25:42','2023-10-28','04:53:42'),(895,85,3,8,'2023-10-28','05:36:42','2023-10-28','04:53:42'),(896,85,1,5,'2023-10-28','05:14:42','2023-10-28','05:04:42'),(897,85,1,10,'2023-10-28','05:25:42','2023-10-28','05:04:42'),(898,85,1,8,'2023-10-28','05:36:42','2023-10-28','05:04:42'),(899,85,5,10,'2023-10-28','05:25:42','2023-10-28','05:14:42'),(900,85,5,8,'2023-10-28','05:36:42','2023-10-28','05:14:42'),(901,85,10,8,'2023-10-28','05:36:42','2023-10-28','05:24:42'),(902,86,8,10,'2023-10-29','04:37:31','2023-10-29','04:27:31'),(903,86,8,5,'2023-10-29','04:48:31','2023-10-29','04:27:31'),(904,86,8,6,'2023-10-29','04:59:31','2023-10-29','04:27:31'),(905,86,8,11,'2023-10-29','05:10:31','2023-10-29','04:27:31'),(906,86,10,5,'2023-10-29','04:48:31','2023-10-29','04:38:31'),(907,86,10,6,'2023-10-29','04:59:31','2023-10-29','04:38:31'),(908,86,10,11,'2023-10-29','05:10:31','2023-10-29','04:38:31'),(909,86,5,6,'2023-10-29','04:59:31','2023-10-29','04:48:31'),(910,86,5,11,'2023-10-29','05:10:31','2023-10-29','04:48:31'),(911,86,6,11,'2023-10-29','05:10:31','2023-10-29','04:58:31'),(912,87,2,5,'2023-10-29','12:05:00','2023-10-29','11:55:00'),(913,87,2,10,'2023-10-29','12:16:00','2023-10-29','11:55:00'),(914,87,2,8,'2023-10-29','12:27:00','2023-10-29','11:55:00'),(915,87,5,10,'2023-10-29','12:16:00','2023-10-29','12:06:00'),(916,87,5,8,'2023-10-29','12:27:00','2023-10-29','12:06:00'),(917,87,10,8,'2023-10-29','12:27:00','2023-10-29','12:16:00'),(918,88,8,10,'2023-10-29','04:08:38','2023-10-29','03:58:38'),(919,88,8,5,'2023-10-29','04:19:38','2023-10-29','03:58:38'),(920,88,8,1,'2023-10-29','04:30:38','2023-10-29','03:58:38'),(921,88,8,3,'2023-10-29','04:41:38','2023-10-29','03:58:38'),(922,88,8,9,'2023-10-29','04:51:38','2023-10-29','03:58:38'),(923,88,8,4,'2023-10-29','05:01:38','2023-10-29','03:58:38'),(924,88,10,5,'2023-10-29','04:19:38','2023-10-29','04:09:38'),(925,88,10,1,'2023-10-29','04:30:38','2023-10-29','04:09:38'),(926,88,10,3,'2023-10-29','04:41:38','2023-10-29','04:09:38'),(927,88,10,9,'2023-10-29','04:51:38','2023-10-29','04:09:38'),(928,88,10,4,'2023-10-29','05:01:38','2023-10-29','04:09:38'),(929,88,5,1,'2023-10-29','04:30:38','2023-10-29','04:19:38'),(930,88,5,3,'2023-10-29','04:41:38','2023-10-29','04:19:38'),(931,88,5,9,'2023-10-29','04:51:38','2023-10-29','04:19:38'),(932,88,5,4,'2023-10-29','05:01:38','2023-10-29','04:19:38'),(933,88,1,3,'2023-10-29','04:41:38','2023-10-29','04:29:38'),(934,88,1,9,'2023-10-29','04:51:38','2023-10-29','04:29:38'),(935,88,1,4,'2023-10-29','05:01:38','2023-10-29','04:29:38'),(936,88,3,9,'2023-10-29','04:51:38','2023-10-29','04:39:38'),(937,88,3,4,'2023-10-29','05:01:38','2023-10-29','04:39:38'),(938,88,9,4,'2023-10-29','05:01:38','2023-10-29','04:49:38'),(939,89,8,10,'2023-10-29','07:59:58','2023-10-29','07:49:58'),(940,89,8,5,'2023-10-29','08:10:58','2023-10-29','07:49:58'),(941,89,8,1,'2023-10-29','08:21:58','2023-10-29','07:49:58'),(942,89,10,5,'2023-10-29','08:10:58','2023-10-29','08:00:58'),(943,89,10,1,'2023-10-29','08:21:58','2023-10-29','08:00:58'),(944,89,5,1,'2023-10-29','08:21:58','2023-10-29','08:10:58'),(945,90,3,1,'2023-10-29','05:03:42','2023-10-29','04:53:42'),(946,90,3,5,'2023-10-29','05:14:42','2023-10-29','04:53:42'),(947,90,3,10,'2023-10-29','05:25:42','2023-10-29','04:53:42'),(948,90,3,8,'2023-10-29','05:36:42','2023-10-29','04:53:42'),(949,90,1,5,'2023-10-29','05:14:42','2023-10-29','05:04:42'),(950,90,1,10,'2023-10-29','05:25:42','2023-10-29','05:04:42'),(951,90,1,8,'2023-10-29','05:36:42','2023-10-29','05:04:42'),(952,90,5,10,'2023-10-29','05:25:42','2023-10-29','05:14:42'),(953,90,5,8,'2023-10-29','05:36:42','2023-10-29','05:14:42'),(954,90,10,8,'2023-10-29','05:36:42','2023-10-29','05:24:42'),(955,91,8,10,'2023-10-30','04:37:31','2023-10-30','04:27:31'),(956,91,8,5,'2023-10-30','04:48:31','2023-10-30','04:27:31'),(957,91,8,6,'2023-10-30','04:59:31','2023-10-30','04:27:31'),(958,91,8,11,'2023-10-30','05:10:31','2023-10-30','04:27:31'),(959,91,10,5,'2023-10-30','04:48:31','2023-10-30','04:38:31'),(960,91,10,6,'2023-10-30','04:59:31','2023-10-30','04:38:31'),(961,91,10,11,'2023-10-30','05:10:31','2023-10-30','04:38:31'),(962,91,5,6,'2023-10-30','04:59:31','2023-10-30','04:48:31'),(963,91,5,11,'2023-10-30','05:10:31','2023-10-30','04:48:31'),(964,91,6,11,'2023-10-30','05:10:31','2023-10-30','04:58:31'),(965,92,2,5,'2023-10-30','12:05:00','2023-10-30','11:55:00'),(966,92,2,10,'2023-10-30','12:16:00','2023-10-30','11:55:00'),(967,92,2,8,'2023-10-30','12:27:00','2023-10-30','11:55:00'),(968,92,5,10,'2023-10-30','12:16:00','2023-10-30','12:06:00'),(969,92,5,8,'2023-10-30','12:27:00','2023-10-30','12:06:00'),(970,92,10,8,'2023-10-30','12:27:00','2023-10-30','12:16:00'),(971,93,8,10,'2023-10-30','04:08:38','2023-10-30','03:58:38'),(972,93,8,5,'2023-10-30','04:19:38','2023-10-30','03:58:38'),(973,93,8,1,'2023-10-30','04:30:38','2023-10-30','03:58:38'),(974,93,8,3,'2023-10-30','04:41:38','2023-10-30','03:58:38'),(975,93,8,9,'2023-10-30','04:51:38','2023-10-30','03:58:38'),(976,93,8,4,'2023-10-30','05:01:38','2023-10-30','03:58:38'),(977,93,10,5,'2023-10-30','04:19:38','2023-10-30','04:09:38'),(978,93,10,1,'2023-10-30','04:30:38','2023-10-30','04:09:38'),(979,93,10,3,'2023-10-30','04:41:38','2023-10-30','04:09:38'),(980,93,10,9,'2023-10-30','04:51:38','2023-10-30','04:09:38'),(981,93,10,4,'2023-10-30','05:01:38','2023-10-30','04:09:38'),(982,93,5,1,'2023-10-30','04:30:38','2023-10-30','04:19:38'),(983,93,5,3,'2023-10-30','04:41:38','2023-10-30','04:19:38'),(984,93,5,9,'2023-10-30','04:51:38','2023-10-30','04:19:38'),(985,93,5,4,'2023-10-30','05:01:38','2023-10-30','04:19:38'),(986,93,1,3,'2023-10-30','04:41:38','2023-10-30','04:29:38'),(987,93,1,9,'2023-10-30','04:51:38','2023-10-30','04:29:38'),(988,93,1,4,'2023-10-30','05:01:38','2023-10-30','04:29:38'),(989,93,3,9,'2023-10-30','04:51:38','2023-10-30','04:39:38'),(990,93,3,4,'2023-10-30','05:01:38','2023-10-30','04:39:38'),(991,93,9,4,'2023-10-30','05:01:38','2023-10-30','04:49:38'),(992,94,8,10,'2023-10-30','07:59:58','2023-10-30','07:49:58'),(993,94,8,5,'2023-10-30','08:10:58','2023-10-30','07:49:58'),(994,94,8,1,'2023-10-30','08:21:58','2023-10-30','07:49:58'),(995,94,10,5,'2023-10-30','08:10:58','2023-10-30','08:00:58'),(996,94,10,1,'2023-10-30','08:21:58','2023-10-30','08:00:58'),(997,94,5,1,'2023-10-30','08:21:58','2023-10-30','08:10:58'),(998,95,3,1,'2023-10-30','05:03:42','2023-10-30','04:53:42'),(999,95,3,5,'2023-10-30','05:14:42','2023-10-30','04:53:42'),(1000,95,3,10,'2023-10-30','05:25:42','2023-10-30','04:53:42'),(1001,95,3,8,'2023-10-30','05:36:42','2023-10-30','04:53:42'),(1002,95,1,5,'2023-10-30','05:14:42','2023-10-30','05:04:42'),(1003,95,1,10,'2023-10-30','05:25:42','2023-10-30','05:04:42'),(1004,95,1,8,'2023-10-30','05:36:42','2023-10-30','05:04:42'),(1005,95,5,10,'2023-10-30','05:25:42','2023-10-30','05:14:42'),(1006,95,5,8,'2023-10-30','05:36:42','2023-10-30','05:14:42'),(1007,95,10,8,'2023-10-30','05:36:42','2023-10-30','05:24:42'),(1008,96,8,10,'2023-10-31','04:37:31','2023-10-31','04:27:31'),(1009,96,8,5,'2023-10-31','04:48:31','2023-10-31','04:27:31'),(1010,96,8,6,'2023-10-31','04:59:31','2023-10-31','04:27:31'),(1011,96,8,11,'2023-10-31','05:10:31','2023-10-31','04:27:31'),(1012,96,10,5,'2023-10-31','04:48:31','2023-10-31','04:38:31'),(1013,96,10,6,'2023-10-31','04:59:31','2023-10-31','04:38:31'),(1014,96,10,11,'2023-10-31','05:10:31','2023-10-31','04:38:31'),(1015,96,5,6,'2023-10-31','04:59:31','2023-10-31','04:48:31'),(1016,96,5,11,'2023-10-31','05:10:31','2023-10-31','04:48:31'),(1017,96,6,11,'2023-10-31','05:10:31','2023-10-31','04:58:31'),(1018,97,2,5,'2023-10-31','12:05:00','2023-10-31','11:55:00'),(1019,97,2,10,'2023-10-31','12:16:00','2023-10-31','11:55:00'),(1020,97,2,8,'2023-10-31','12:27:00','2023-10-31','11:55:00'),(1021,97,5,10,'2023-10-31','12:16:00','2023-10-31','12:06:00'),(1022,97,5,8,'2023-10-31','12:27:00','2023-10-31','12:06:00'),(1023,97,10,8,'2023-10-31','12:27:00','2023-10-31','12:16:00'),(1024,98,8,10,'2023-10-31','04:08:38','2023-10-31','03:58:38'),(1025,98,8,5,'2023-10-31','04:19:38','2023-10-31','03:58:38'),(1026,98,8,1,'2023-10-31','04:30:38','2023-10-31','03:58:38'),(1027,98,8,3,'2023-10-31','04:41:38','2023-10-31','03:58:38'),(1028,98,8,9,'2023-10-31','04:51:38','2023-10-31','03:58:38'),(1029,98,8,4,'2023-10-31','05:01:38','2023-10-31','03:58:38'),(1030,98,10,5,'2023-10-31','04:19:38','2023-10-31','04:09:38'),(1031,98,10,1,'2023-10-31','04:30:38','2023-10-31','04:09:38'),(1032,98,10,3,'2023-10-31','04:41:38','2023-10-31','04:09:38'),(1033,98,10,9,'2023-10-31','04:51:38','2023-10-31','04:09:38'),(1034,98,10,4,'2023-10-31','05:01:38','2023-10-31','04:09:38'),(1035,98,5,1,'2023-10-31','04:30:38','2023-10-31','04:19:38'),(1036,98,5,3,'2023-10-31','04:41:38','2023-10-31','04:19:38'),(1037,98,5,9,'2023-10-31','04:51:38','2023-10-31','04:19:38'),(1038,98,5,4,'2023-10-31','05:01:38','2023-10-31','04:19:38'),(1039,98,1,3,'2023-10-31','04:41:38','2023-10-31','04:29:38'),(1040,98,1,9,'2023-10-31','04:51:38','2023-10-31','04:29:38'),(1041,98,1,4,'2023-10-31','05:01:38','2023-10-31','04:29:38'),(1042,98,3,9,'2023-10-31','04:51:38','2023-10-31','04:39:38'),(1043,98,3,4,'2023-10-31','05:01:38','2023-10-31','04:39:38'),(1044,98,9,4,'2023-10-31','05:01:38','2023-10-31','04:49:38'),(1045,99,8,10,'2023-10-31','07:59:58','2023-10-31','07:49:58'),(1046,99,8,5,'2023-10-31','08:10:58','2023-10-31','07:49:58'),(1047,99,8,1,'2023-10-31','08:21:58','2023-10-31','07:49:58'),(1048,99,10,5,'2023-10-31','08:10:58','2023-10-31','08:00:58'),(1049,99,10,1,'2023-10-31','08:21:58','2023-10-31','08:00:58'),(1050,99,5,1,'2023-10-31','08:21:58','2023-10-31','08:10:58'),(1051,100,3,1,'2023-10-31','05:03:42','2023-10-31','04:53:42'),(1052,100,3,5,'2023-10-31','05:14:42','2023-10-31','04:53:42'),(1053,100,3,10,'2023-10-31','05:25:42','2023-10-31','04:53:42'),(1054,100,3,8,'2023-10-31','05:36:42','2023-10-31','04:53:42'),(1055,100,1,5,'2023-10-31','05:14:42','2023-10-31','05:04:42'),(1056,100,1,10,'2023-10-31','05:25:42','2023-10-31','05:04:42'),(1057,100,1,8,'2023-10-31','05:36:42','2023-10-31','05:04:42'),(1058,100,5,10,'2023-10-31','05:25:42','2023-10-31','05:14:42'),(1059,100,5,8,'2023-10-31','05:36:42','2023-10-31','05:14:42'),(1060,100,10,8,'2023-10-31','05:36:42','2023-10-31','05:24:42'),(1061,101,8,10,'2023-11-01','04:37:31','2023-11-01','04:27:31'),(1062,101,8,5,'2023-11-01','04:48:31','2023-11-01','04:27:31'),(1063,101,8,6,'2023-11-01','04:59:31','2023-11-01','04:27:31'),(1064,101,8,11,'2023-11-01','05:10:31','2023-11-01','04:27:31'),(1065,101,10,5,'2023-11-01','04:48:31','2023-11-01','04:38:31'),(1066,101,10,6,'2023-11-01','04:59:31','2023-11-01','04:38:31'),(1067,101,10,11,'2023-11-01','05:10:31','2023-11-01','04:38:31'),(1068,101,5,6,'2023-11-01','04:59:31','2023-11-01','04:48:31'),(1069,101,5,11,'2023-11-01','05:10:31','2023-11-01','04:48:31'),(1070,101,6,11,'2023-11-01','05:10:31','2023-11-01','04:58:31'),(1071,102,2,5,'2023-11-01','12:05:00','2023-11-01','11:55:00'),(1072,102,2,10,'2023-11-01','12:16:00','2023-11-01','11:55:00'),(1073,102,2,8,'2023-11-01','12:27:00','2023-11-01','11:55:00'),(1074,102,5,10,'2023-11-01','12:16:00','2023-11-01','12:06:00'),(1075,102,5,8,'2023-11-01','12:27:00','2023-11-01','12:06:00'),(1076,102,10,8,'2023-11-01','12:27:00','2023-11-01','12:16:00'),(1077,103,8,10,'2023-11-01','04:08:38','2023-11-01','03:58:38'),(1078,103,8,5,'2023-11-01','04:19:38','2023-11-01','03:58:38'),(1079,103,8,1,'2023-11-01','04:30:38','2023-11-01','03:58:38'),(1080,103,8,3,'2023-11-01','04:41:38','2023-11-01','03:58:38'),(1081,103,8,9,'2023-11-01','04:51:38','2023-11-01','03:58:38'),(1082,103,8,4,'2023-11-01','05:01:38','2023-11-01','03:58:38'),(1083,103,10,5,'2023-11-01','04:19:38','2023-11-01','04:09:38'),(1084,103,10,1,'2023-11-01','04:30:38','2023-11-01','04:09:38'),(1085,103,10,3,'2023-11-01','04:41:38','2023-11-01','04:09:38'),(1086,103,10,9,'2023-11-01','04:51:38','2023-11-01','04:09:38'),(1087,103,10,4,'2023-11-01','05:01:38','2023-11-01','04:09:38'),(1088,103,5,1,'2023-11-01','04:30:38','2023-11-01','04:19:38'),(1089,103,5,3,'2023-11-01','04:41:38','2023-11-01','04:19:38'),(1090,103,5,9,'2023-11-01','04:51:38','2023-11-01','04:19:38'),(1091,103,5,4,'2023-11-01','05:01:38','2023-11-01','04:19:38'),(1092,103,1,3,'2023-11-01','04:41:38','2023-11-01','04:29:38'),(1093,103,1,9,'2023-11-01','04:51:38','2023-11-01','04:29:38'),(1094,103,1,4,'2023-11-01','05:01:38','2023-11-01','04:29:38'),(1095,103,3,9,'2023-11-01','04:51:38','2023-11-01','04:39:38'),(1096,103,3,4,'2023-11-01','05:01:38','2023-11-01','04:39:38'),(1097,103,9,4,'2023-11-01','05:01:38','2023-11-01','04:49:38'),(1098,104,8,10,'2023-11-01','07:59:58','2023-11-01','07:49:58'),(1099,104,8,5,'2023-11-01','08:10:58','2023-11-01','07:49:58'),(1100,104,8,1,'2023-11-01','08:21:58','2023-11-01','07:49:58'),(1101,104,10,5,'2023-11-01','08:10:58','2023-11-01','08:00:58'),(1102,104,10,1,'2023-11-01','08:21:58','2023-11-01','08:00:58'),(1103,104,5,1,'2023-11-01','08:21:58','2023-11-01','08:10:58'),(1104,105,3,1,'2023-11-01','05:03:42','2023-11-01','04:53:42'),(1105,105,3,5,'2023-11-01','05:14:42','2023-11-01','04:53:42'),(1106,105,3,10,'2023-11-01','05:25:42','2023-11-01','04:53:42'),(1107,105,3,8,'2023-11-01','05:36:42','2023-11-01','04:53:42'),(1108,105,1,5,'2023-11-01','05:14:42','2023-11-01','05:04:42'),(1109,105,1,10,'2023-11-01','05:25:42','2023-11-01','05:04:42'),(1110,105,1,8,'2023-11-01','05:36:42','2023-11-01','05:04:42'),(1111,105,5,10,'2023-11-01','05:25:42','2023-11-01','05:14:42'),(1112,105,5,8,'2023-11-01','05:36:42','2023-11-01','05:14:42'),(1113,105,10,8,'2023-11-01','05:36:42','2023-11-01','05:24:42'),(1114,106,8,10,'2023-11-02','04:37:31','2023-11-02','04:27:31'),(1115,106,8,5,'2023-11-02','04:48:31','2023-11-02','04:27:31'),(1116,106,8,6,'2023-11-02','04:59:31','2023-11-02','04:27:31'),(1117,106,8,11,'2023-11-02','05:10:31','2023-11-02','04:27:31'),(1118,106,10,5,'2023-11-02','04:48:31','2023-11-02','04:38:31'),(1119,106,10,6,'2023-11-02','04:59:31','2023-11-02','04:38:31'),(1120,106,10,11,'2023-11-02','05:10:31','2023-11-02','04:38:31'),(1121,106,5,6,'2023-11-02','04:59:31','2023-11-02','04:48:31'),(1122,106,5,11,'2023-11-02','05:10:31','2023-11-02','04:48:31'),(1123,106,6,11,'2023-11-02','05:10:31','2023-11-02','04:58:31'),(1124,107,2,5,'2023-11-02','12:05:00','2023-11-02','11:55:00'),(1125,107,2,10,'2023-11-02','12:16:00','2023-11-02','11:55:00'),(1126,107,2,8,'2023-11-02','12:27:00','2023-11-02','11:55:00'),(1127,107,5,10,'2023-11-02','12:16:00','2023-11-02','12:06:00'),(1128,107,5,8,'2023-11-02','12:27:00','2023-11-02','12:06:00'),(1129,107,10,8,'2023-11-02','12:27:00','2023-11-02','12:16:00'),(1130,108,8,10,'2023-11-02','04:08:38','2023-11-02','03:58:38'),(1131,108,8,5,'2023-11-02','04:19:38','2023-11-02','03:58:38'),(1132,108,8,1,'2023-11-02','04:30:38','2023-11-02','03:58:38'),(1133,108,8,3,'2023-11-02','04:41:38','2023-11-02','03:58:38'),(1134,108,8,9,'2023-11-02','04:51:38','2023-11-02','03:58:38'),(1135,108,8,4,'2023-11-02','05:01:38','2023-11-02','03:58:38'),(1136,108,10,5,'2023-11-02','04:19:38','2023-11-02','04:09:38'),(1137,108,10,1,'2023-11-02','04:30:38','2023-11-02','04:09:38'),(1138,108,10,3,'2023-11-02','04:41:38','2023-11-02','04:09:38'),(1139,108,10,9,'2023-11-02','04:51:38','2023-11-02','04:09:38'),(1140,108,10,4,'2023-11-02','05:01:38','2023-11-02','04:09:38'),(1141,108,5,1,'2023-11-02','04:30:38','2023-11-02','04:19:38'),(1142,108,5,3,'2023-11-02','04:41:38','2023-11-02','04:19:38'),(1143,108,5,9,'2023-11-02','04:51:38','2023-11-02','04:19:38'),(1144,108,5,4,'2023-11-02','05:01:38','2023-11-02','04:19:38'),(1145,108,1,3,'2023-11-02','04:41:38','2023-11-02','04:29:38'),(1146,108,1,9,'2023-11-02','04:51:38','2023-11-02','04:29:38'),(1147,108,1,4,'2023-11-02','05:01:38','2023-11-02','04:29:38'),(1148,108,3,9,'2023-11-02','04:51:38','2023-11-02','04:39:38'),(1149,108,3,4,'2023-11-02','05:01:38','2023-11-02','04:39:38'),(1150,108,9,4,'2023-11-02','05:01:38','2023-11-02','04:49:38'),(1151,109,8,10,'2023-11-02','07:59:58','2023-11-02','07:49:58'),(1152,109,8,5,'2023-11-02','08:10:58','2023-11-02','07:49:58'),(1153,109,8,1,'2023-11-02','08:21:58','2023-11-02','07:49:58'),(1154,109,10,5,'2023-11-02','08:10:58','2023-11-02','08:00:58'),(1155,109,10,1,'2023-11-02','08:21:58','2023-11-02','08:00:58'),(1156,109,5,1,'2023-11-02','08:21:58','2023-11-02','08:10:58'),(1157,110,3,1,'2023-11-02','05:03:42','2023-11-02','04:53:42'),(1158,110,3,5,'2023-11-02','05:14:42','2023-11-02','04:53:42'),(1159,110,3,10,'2023-11-02','05:25:42','2023-11-02','04:53:42'),(1160,110,3,8,'2023-11-02','05:36:42','2023-11-02','04:53:42'),(1161,110,1,5,'2023-11-02','05:14:42','2023-11-02','05:04:42'),(1162,110,1,10,'2023-11-02','05:25:42','2023-11-02','05:04:42'),(1163,110,1,8,'2023-11-02','05:36:42','2023-11-02','05:04:42'),(1164,110,5,10,'2023-11-02','05:25:42','2023-11-02','05:14:42'),(1165,110,5,8,'2023-11-02','05:36:42','2023-11-02','05:14:42'),(1166,110,10,8,'2023-11-02','05:36:42','2023-11-02','05:24:42'),(1167,111,8,10,'2023-11-03','04:37:31','2023-11-03','04:27:31'),(1168,111,8,5,'2023-11-03','04:48:31','2023-11-03','04:27:31'),(1169,111,8,6,'2023-11-03','04:59:31','2023-11-03','04:27:31'),(1170,111,8,11,'2023-11-03','05:10:31','2023-11-03','04:27:31'),(1171,111,10,5,'2023-11-03','04:48:31','2023-11-03','04:38:31'),(1172,111,10,6,'2023-11-03','04:59:31','2023-11-03','04:38:31'),(1173,111,10,11,'2023-11-03','05:10:31','2023-11-03','04:38:31'),(1174,111,5,6,'2023-11-03','04:59:31','2023-11-03','04:48:31'),(1175,111,5,11,'2023-11-03','05:10:31','2023-11-03','04:48:31'),(1176,111,6,11,'2023-11-03','05:10:31','2023-11-03','04:58:31'),(1177,112,2,5,'2023-11-03','12:05:00','2023-11-03','11:55:00'),(1178,112,2,10,'2023-11-03','12:16:00','2023-11-03','11:55:00'),(1179,112,2,8,'2023-11-03','12:27:00','2023-11-03','11:55:00'),(1180,112,5,10,'2023-11-03','12:16:00','2023-11-03','12:06:00'),(1181,112,5,8,'2023-11-03','12:27:00','2023-11-03','12:06:00'),(1182,112,10,8,'2023-11-03','12:27:00','2023-11-03','12:16:00'),(1183,113,8,10,'2023-11-03','04:08:38','2023-11-03','03:58:38'),(1184,113,8,5,'2023-11-03','04:19:38','2023-11-03','03:58:38'),(1185,113,8,1,'2023-11-03','04:30:38','2023-11-03','03:58:38'),(1186,113,8,3,'2023-11-03','04:41:38','2023-11-03','03:58:38'),(1187,113,8,9,'2023-11-03','04:51:38','2023-11-03','03:58:38'),(1188,113,8,4,'2023-11-03','05:01:38','2023-11-03','03:58:38'),(1189,113,10,5,'2023-11-03','04:19:38','2023-11-03','04:09:38'),(1190,113,10,1,'2023-11-03','04:30:38','2023-11-03','04:09:38'),(1191,113,10,3,'2023-11-03','04:41:38','2023-11-03','04:09:38'),(1192,113,10,9,'2023-11-03','04:51:38','2023-11-03','04:09:38'),(1193,113,10,4,'2023-11-03','05:01:38','2023-11-03','04:09:38'),(1194,113,5,1,'2023-11-03','04:30:38','2023-11-03','04:19:38'),(1195,113,5,3,'2023-11-03','04:41:38','2023-11-03','04:19:38'),(1196,113,5,9,'2023-11-03','04:51:38','2023-11-03','04:19:38'),(1197,113,5,4,'2023-11-03','05:01:38','2023-11-03','04:19:38'),(1198,113,1,3,'2023-11-03','04:41:38','2023-11-03','04:29:38'),(1199,113,1,9,'2023-11-03','04:51:38','2023-11-03','04:29:38'),(1200,113,1,4,'2023-11-03','05:01:38','2023-11-03','04:29:38'),(1201,113,3,9,'2023-11-03','04:51:38','2023-11-03','04:39:38'),(1202,113,3,4,'2023-11-03','05:01:38','2023-11-03','04:39:38'),(1203,113,9,4,'2023-11-03','05:01:38','2023-11-03','04:49:38'),(1204,114,8,10,'2023-11-03','07:59:58','2023-11-03','07:49:58'),(1205,114,8,5,'2023-11-03','08:10:58','2023-11-03','07:49:58'),(1206,114,8,1,'2023-11-03','08:21:58','2023-11-03','07:49:58'),(1207,114,10,5,'2023-11-03','08:10:58','2023-11-03','08:00:58'),(1208,114,10,1,'2023-11-03','08:21:58','2023-11-03','08:00:58'),(1209,114,5,1,'2023-11-03','08:21:58','2023-11-03','08:10:58'),(1210,115,3,1,'2023-11-03','05:03:42','2023-11-03','04:53:42'),(1211,115,3,5,'2023-11-03','05:14:42','2023-11-03','04:53:42'),(1212,115,3,10,'2023-11-03','05:25:42','2023-11-03','04:53:42'),(1213,115,3,8,'2023-11-03','05:36:42','2023-11-03','04:53:42'),(1214,115,1,5,'2023-11-03','05:14:42','2023-11-03','05:04:42'),(1215,115,1,10,'2023-11-03','05:25:42','2023-11-03','05:04:42'),(1216,115,1,8,'2023-11-03','05:36:42','2023-11-03','05:04:42'),(1217,115,5,10,'2023-11-03','05:25:42','2023-11-03','05:14:42'),(1218,115,5,8,'2023-11-03','05:36:42','2023-11-03','05:14:42'),(1219,115,10,8,'2023-11-03','05:36:42','2023-11-03','05:24:42'),(1220,116,8,10,'2023-11-04','04:37:31','2023-11-04','04:27:31'),(1221,116,8,5,'2023-11-04','04:48:31','2023-11-04','04:27:31'),(1222,116,8,6,'2023-11-04','04:59:31','2023-11-04','04:27:31'),(1223,116,8,11,'2023-11-04','05:10:31','2023-11-04','04:27:31'),(1224,116,10,5,'2023-11-04','04:48:31','2023-11-04','04:38:31'),(1225,116,10,6,'2023-11-04','04:59:31','2023-11-04','04:38:31'),(1226,116,10,11,'2023-11-04','05:10:31','2023-11-04','04:38:31'),(1227,116,5,6,'2023-11-04','04:59:31','2023-11-04','04:48:31'),(1228,116,5,11,'2023-11-04','05:10:31','2023-11-04','04:48:31'),(1229,116,6,11,'2023-11-04','05:10:31','2023-11-04','04:58:31'),(1230,117,2,5,'2023-11-04','12:05:00','2023-11-04','11:55:00'),(1231,117,2,10,'2023-11-04','12:16:00','2023-11-04','11:55:00'),(1232,117,2,8,'2023-11-04','12:27:00','2023-11-04','11:55:00'),(1233,117,5,10,'2023-11-04','12:16:00','2023-11-04','12:06:00'),(1234,117,5,8,'2023-11-04','12:27:00','2023-11-04','12:06:00'),(1235,117,10,8,'2023-11-04','12:27:00','2023-11-04','12:16:00'),(1236,118,8,10,'2023-11-04','04:08:38','2023-11-04','03:58:38'),(1237,118,8,5,'2023-11-04','04:19:38','2023-11-04','03:58:38'),(1238,118,8,1,'2023-11-04','04:30:38','2023-11-04','03:58:38'),(1239,118,8,3,'2023-11-04','04:41:38','2023-11-04','03:58:38'),(1240,118,8,9,'2023-11-04','04:51:38','2023-11-04','03:58:38'),(1241,118,8,4,'2023-11-04','05:01:38','2023-11-04','03:58:38'),(1242,118,10,5,'2023-11-04','04:19:38','2023-11-04','04:09:38'),(1243,118,10,1,'2023-11-04','04:30:38','2023-11-04','04:09:38'),(1244,118,10,3,'2023-11-04','04:41:38','2023-11-04','04:09:38'),(1245,118,10,9,'2023-11-04','04:51:38','2023-11-04','04:09:38'),(1246,118,10,4,'2023-11-04','05:01:38','2023-11-04','04:09:38'),(1247,118,5,1,'2023-11-04','04:30:38','2023-11-04','04:19:38'),(1248,118,5,3,'2023-11-04','04:41:38','2023-11-04','04:19:38'),(1249,118,5,9,'2023-11-04','04:51:38','2023-11-04','04:19:38'),(1250,118,5,4,'2023-11-04','05:01:38','2023-11-04','04:19:38'),(1251,118,1,3,'2023-11-04','04:41:38','2023-11-04','04:29:38'),(1252,118,1,9,'2023-11-04','04:51:38','2023-11-04','04:29:38'),(1253,118,1,4,'2023-11-04','05:01:38','2023-11-04','04:29:38'),(1254,118,3,9,'2023-11-04','04:51:38','2023-11-04','04:39:38'),(1255,118,3,4,'2023-11-04','05:01:38','2023-11-04','04:39:38'),(1256,118,9,4,'2023-11-04','05:01:38','2023-11-04','04:49:38'),(1257,119,8,10,'2023-11-04','07:59:58','2023-11-04','07:49:58'),(1258,119,8,5,'2023-11-04','08:10:58','2023-11-04','07:49:58'),(1259,119,8,1,'2023-11-04','08:21:58','2023-11-04','07:49:58'),(1260,119,10,5,'2023-11-04','08:10:58','2023-11-04','08:00:58'),(1261,119,10,1,'2023-11-04','08:21:58','2023-11-04','08:00:58'),(1262,119,5,1,'2023-11-04','08:21:58','2023-11-04','08:10:58'),(1263,120,3,1,'2023-11-04','05:03:42','2023-11-04','04:53:42'),(1264,120,3,5,'2023-11-04','05:14:42','2023-11-04','04:53:42'),(1265,120,3,10,'2023-11-04','05:25:42','2023-11-04','04:53:42'),(1266,120,3,8,'2023-11-04','05:36:42','2023-11-04','04:53:42'),(1267,120,1,5,'2023-11-04','05:14:42','2023-11-04','05:04:42'),(1268,120,1,10,'2023-11-04','05:25:42','2023-11-04','05:04:42'),(1269,120,1,8,'2023-11-04','05:36:42','2023-11-04','05:04:42'),(1270,120,5,10,'2023-11-04','05:25:42','2023-11-04','05:14:42'),(1271,120,5,8,'2023-11-04','05:36:42','2023-11-04','05:14:42'),(1272,120,10,8,'2023-11-04','05:36:42','2023-11-04','05:24:42'),(1273,121,8,10,'2023-11-05','04:37:31','2023-11-05','04:27:31'),(1274,121,8,5,'2023-11-05','04:48:31','2023-11-05','04:27:31'),(1275,121,8,6,'2023-11-05','04:59:31','2023-11-05','04:27:31'),(1276,121,8,11,'2023-11-05','05:10:31','2023-11-05','04:27:31'),(1277,121,10,5,'2023-11-05','04:48:31','2023-11-05','04:38:31'),(1278,121,10,6,'2023-11-05','04:59:31','2023-11-05','04:38:31'),(1279,121,10,11,'2023-11-05','05:10:31','2023-11-05','04:38:31'),(1280,121,5,6,'2023-11-05','04:59:31','2023-11-05','04:48:31'),(1281,121,5,11,'2023-11-05','05:10:31','2023-11-05','04:48:31'),(1282,121,6,11,'2023-11-05','05:10:31','2023-11-05','04:58:31'),(1283,122,2,5,'2023-11-05','12:05:00','2023-11-05','11:55:00'),(1284,122,2,10,'2023-11-05','12:16:00','2023-11-05','11:55:00'),(1285,122,2,8,'2023-11-05','12:27:00','2023-11-05','11:55:00'),(1286,122,5,10,'2023-11-05','12:16:00','2023-11-05','12:06:00'),(1287,122,5,8,'2023-11-05','12:27:00','2023-11-05','12:06:00'),(1288,122,10,8,'2023-11-05','12:27:00','2023-11-05','12:16:00'),(1289,123,8,10,'2023-11-05','04:08:38','2023-11-05','03:58:38'),(1290,123,8,5,'2023-11-05','04:19:38','2023-11-05','03:58:38'),(1291,123,8,1,'2023-11-05','04:30:38','2023-11-05','03:58:38'),(1292,123,8,3,'2023-11-05','04:41:38','2023-11-05','03:58:38'),(1293,123,8,9,'2023-11-05','04:51:38','2023-11-05','03:58:38'),(1294,123,8,4,'2023-11-05','05:01:38','2023-11-05','03:58:38'),(1295,123,10,5,'2023-11-05','04:19:38','2023-11-05','04:09:38'),(1296,123,10,1,'2023-11-05','04:30:38','2023-11-05','04:09:38'),(1297,123,10,3,'2023-11-05','04:41:38','2023-11-05','04:09:38'),(1298,123,10,9,'2023-11-05','04:51:38','2023-11-05','04:09:38'),(1299,123,10,4,'2023-11-05','05:01:38','2023-11-05','04:09:38'),(1300,123,5,1,'2023-11-05','04:30:38','2023-11-05','04:19:38'),(1301,123,5,3,'2023-11-05','04:41:38','2023-11-05','04:19:38'),(1302,123,5,9,'2023-11-05','04:51:38','2023-11-05','04:19:38'),(1303,123,5,4,'2023-11-05','05:01:38','2023-11-05','04:19:38'),(1304,123,1,3,'2023-11-05','04:41:38','2023-11-05','04:29:38'),(1305,123,1,9,'2023-11-05','04:51:38','2023-11-05','04:29:38'),(1306,123,1,4,'2023-11-05','05:01:38','2023-11-05','04:29:38'),(1307,123,3,9,'2023-11-05','04:51:38','2023-11-05','04:39:38'),(1308,123,3,4,'2023-11-05','05:01:38','2023-11-05','04:39:38'),(1309,123,9,4,'2023-11-05','05:01:38','2023-11-05','04:49:38'),(1310,124,8,10,'2023-11-05','07:59:58','2023-11-05','07:49:58'),(1311,124,8,5,'2023-11-05','08:10:58','2023-11-05','07:49:58'),(1312,124,8,1,'2023-11-05','08:21:58','2023-11-05','07:49:58'),(1313,124,10,5,'2023-11-05','08:10:58','2023-11-05','08:00:58'),(1314,124,10,1,'2023-11-05','08:21:58','2023-11-05','08:00:58'),(1315,124,5,1,'2023-11-05','08:21:58','2023-11-05','08:10:58'),(1316,125,3,1,'2023-11-05','05:03:42','2023-11-05','04:53:42'),(1317,125,3,5,'2023-11-05','05:14:42','2023-11-05','04:53:42'),(1318,125,3,10,'2023-11-05','05:25:42','2023-11-05','04:53:42'),(1319,125,3,8,'2023-11-05','05:36:42','2023-11-05','04:53:42'),(1320,125,1,5,'2023-11-05','05:14:42','2023-11-05','05:04:42'),(1321,125,1,10,'2023-11-05','05:25:42','2023-11-05','05:04:42'),(1322,125,1,8,'2023-11-05','05:36:42','2023-11-05','05:04:42'),(1323,125,5,10,'2023-11-05','05:25:42','2023-11-05','05:14:42'),(1324,125,5,8,'2023-11-05','05:36:42','2023-11-05','05:14:42'),(1325,125,10,8,'2023-11-05','05:36:42','2023-11-05','05:24:42'),(1326,126,8,10,'2023-11-06','04:37:31','2023-11-06','04:27:31'),(1327,126,8,5,'2023-11-06','04:48:31','2023-11-06','04:27:31'),(1328,126,8,6,'2023-11-06','04:59:31','2023-11-06','04:27:31'),(1329,126,8,11,'2023-11-06','05:10:31','2023-11-06','04:27:31'),(1330,126,10,5,'2023-11-06','04:48:31','2023-11-06','04:38:31'),(1331,126,10,6,'2023-11-06','04:59:31','2023-11-06','04:38:31'),(1332,126,10,11,'2023-11-06','05:10:31','2023-11-06','04:38:31'),(1333,126,5,6,'2023-11-06','04:59:31','2023-11-06','04:48:31'),(1334,126,5,11,'2023-11-06','05:10:31','2023-11-06','04:48:31'),(1335,126,6,11,'2023-11-06','05:10:31','2023-11-06','04:58:31'),(1336,127,2,5,'2023-11-06','12:05:00','2023-11-06','11:55:00'),(1337,127,2,10,'2023-11-06','12:16:00','2023-11-06','11:55:00'),(1338,127,2,8,'2023-11-06','12:27:00','2023-11-06','11:55:00'),(1339,127,5,10,'2023-11-06','12:16:00','2023-11-06','12:06:00'),(1340,127,5,8,'2023-11-06','12:27:00','2023-11-06','12:06:00'),(1341,127,10,8,'2023-11-06','12:27:00','2023-11-06','12:16:00'),(1342,128,8,10,'2023-11-06','04:08:38','2023-11-06','03:58:38'),(1343,128,8,5,'2023-11-06','04:19:38','2023-11-06','03:58:38'),(1344,128,8,1,'2023-11-06','04:30:38','2023-11-06','03:58:38'),(1345,128,8,3,'2023-11-06','04:41:38','2023-11-06','03:58:38'),(1346,128,8,9,'2023-11-06','04:51:38','2023-11-06','03:58:38'),(1347,128,8,4,'2023-11-06','05:01:38','2023-11-06','03:58:38'),(1348,128,10,5,'2023-11-06','04:19:38','2023-11-06','04:09:38'),(1349,128,10,1,'2023-11-06','04:30:38','2023-11-06','04:09:38'),(1350,128,10,3,'2023-11-06','04:41:38','2023-11-06','04:09:38'),(1351,128,10,9,'2023-11-06','04:51:38','2023-11-06','04:09:38'),(1352,128,10,4,'2023-11-06','05:01:38','2023-11-06','04:09:38'),(1353,128,5,1,'2023-11-06','04:30:38','2023-11-06','04:19:38'),(1354,128,5,3,'2023-11-06','04:41:38','2023-11-06','04:19:38'),(1355,128,5,9,'2023-11-06','04:51:38','2023-11-06','04:19:38'),(1356,128,5,4,'2023-11-06','05:01:38','2023-11-06','04:19:38'),(1357,128,1,3,'2023-11-06','04:41:38','2023-11-06','04:29:38'),(1358,128,1,9,'2023-11-06','04:51:38','2023-11-06','04:29:38'),(1359,128,1,4,'2023-11-06','05:01:38','2023-11-06','04:29:38'),(1360,128,3,9,'2023-11-06','04:51:38','2023-11-06','04:39:38'),(1361,128,3,4,'2023-11-06','05:01:38','2023-11-06','04:39:38'),(1362,128,9,4,'2023-11-06','05:01:38','2023-11-06','04:49:38'),(1363,129,8,10,'2023-11-06','07:59:58','2023-11-06','07:49:58'),(1364,129,8,5,'2023-11-06','08:10:58','2023-11-06','07:49:58'),(1365,129,8,1,'2023-11-06','08:21:58','2023-11-06','07:49:58'),(1366,129,10,5,'2023-11-06','08:10:58','2023-11-06','08:00:58'),(1367,129,10,1,'2023-11-06','08:21:58','2023-11-06','08:00:58'),(1368,129,5,1,'2023-11-06','08:21:58','2023-11-06','08:10:58'),(1369,130,3,1,'2023-11-06','05:03:42','2023-11-06','04:53:42'),(1370,130,3,5,'2023-11-06','05:14:42','2023-11-06','04:53:42'),(1371,130,3,10,'2023-11-06','05:25:42','2023-11-06','04:53:42'),(1372,130,3,8,'2023-11-06','05:36:42','2023-11-06','04:53:42'),(1373,130,1,5,'2023-11-06','05:14:42','2023-11-06','05:04:42'),(1374,130,1,10,'2023-11-06','05:25:42','2023-11-06','05:04:42'),(1375,130,1,8,'2023-11-06','05:36:42','2023-11-06','05:04:42'),(1376,130,5,10,'2023-11-06','05:25:42','2023-11-06','05:14:42'),(1377,130,5,8,'2023-11-06','05:36:42','2023-11-06','05:14:42'),(1378,130,10,8,'2023-11-06','05:36:42','2023-11-06','05:24:42'),(1379,131,8,10,'2023-11-07','04:37:31','2023-11-07','04:27:31'),(1380,131,8,5,'2023-11-07','04:48:31','2023-11-07','04:27:31'),(1381,131,8,6,'2023-11-07','04:59:31','2023-11-07','04:27:31'),(1382,131,8,11,'2023-11-07','05:10:31','2023-11-07','04:27:31'),(1383,131,10,5,'2023-11-07','04:48:31','2023-11-07','04:38:31'),(1384,131,10,6,'2023-11-07','04:59:31','2023-11-07','04:38:31'),(1385,131,10,11,'2023-11-07','05:10:31','2023-11-07','04:38:31'),(1386,131,5,6,'2023-11-07','04:59:31','2023-11-07','04:48:31'),(1387,131,5,11,'2023-11-07','05:10:31','2023-11-07','04:48:31'),(1388,131,6,11,'2023-11-07','05:10:31','2023-11-07','04:58:31'),(1389,132,2,5,'2023-11-07','12:05:00','2023-11-07','11:55:00'),(1390,132,2,10,'2023-11-07','12:16:00','2023-11-07','11:55:00'),(1391,132,2,8,'2023-11-07','12:27:00','2023-11-07','11:55:00'),(1392,132,5,10,'2023-11-07','12:16:00','2023-11-07','12:06:00'),(1393,132,5,8,'2023-11-07','12:27:00','2023-11-07','12:06:00'),(1394,132,10,8,'2023-11-07','12:27:00','2023-11-07','12:16:00'),(1395,133,8,10,'2023-11-07','04:08:38','2023-11-07','03:58:38'),(1396,133,8,5,'2023-11-07','04:19:38','2023-11-07','03:58:38'),(1397,133,8,1,'2023-11-07','04:30:38','2023-11-07','03:58:38'),(1398,133,8,3,'2023-11-07','04:41:38','2023-11-07','03:58:38'),(1399,133,8,9,'2023-11-07','04:51:38','2023-11-07','03:58:38'),(1400,133,8,4,'2023-11-07','05:01:38','2023-11-07','03:58:38'),(1401,133,10,5,'2023-11-07','04:19:38','2023-11-07','04:09:38'),(1402,133,10,1,'2023-11-07','04:30:38','2023-11-07','04:09:38'),(1403,133,10,3,'2023-11-07','04:41:38','2023-11-07','04:09:38'),(1404,133,10,9,'2023-11-07','04:51:38','2023-11-07','04:09:38'),(1405,133,10,4,'2023-11-07','05:01:38','2023-11-07','04:09:38'),(1406,133,5,1,'2023-11-07','04:30:38','2023-11-07','04:19:38'),(1407,133,5,3,'2023-11-07','04:41:38','2023-11-07','04:19:38'),(1408,133,5,9,'2023-11-07','04:51:38','2023-11-07','04:19:38'),(1409,133,5,4,'2023-11-07','05:01:38','2023-11-07','04:19:38'),(1410,133,1,3,'2023-11-07','04:41:38','2023-11-07','04:29:38'),(1411,133,1,9,'2023-11-07','04:51:38','2023-11-07','04:29:38'),(1412,133,1,4,'2023-11-07','05:01:38','2023-11-07','04:29:38'),(1413,133,3,9,'2023-11-07','04:51:38','2023-11-07','04:39:38'),(1414,133,3,4,'2023-11-07','05:01:38','2023-11-07','04:39:38'),(1415,133,9,4,'2023-11-07','05:01:38','2023-11-07','04:49:38'),(1416,134,8,10,'2023-11-07','07:59:58','2023-11-07','07:49:58'),(1417,134,8,5,'2023-11-07','08:10:58','2023-11-07','07:49:58'),(1418,134,8,1,'2023-11-07','08:21:58','2023-11-07','07:49:58'),(1419,134,10,5,'2023-11-07','08:10:58','2023-11-07','08:00:58'),(1420,134,10,1,'2023-11-07','08:21:58','2023-11-07','08:00:58'),(1421,134,5,1,'2023-11-07','08:21:58','2023-11-07','08:10:58'),(1422,135,3,1,'2023-11-07','05:03:42','2023-11-07','04:53:42'),(1423,135,3,5,'2023-11-07','05:14:42','2023-11-07','04:53:42'),(1424,135,3,10,'2023-11-07','05:25:42','2023-11-07','04:53:42'),(1425,135,3,8,'2023-11-07','05:36:42','2023-11-07','04:53:42'),(1426,135,1,5,'2023-11-07','05:14:42','2023-11-07','05:04:42'),(1427,135,1,10,'2023-11-07','05:25:42','2023-11-07','05:04:42'),(1428,135,1,8,'2023-11-07','05:36:42','2023-11-07','05:04:42'),(1429,135,5,10,'2023-11-07','05:25:42','2023-11-07','05:14:42'),(1430,135,5,8,'2023-11-07','05:36:42','2023-11-07','05:14:42'),(1431,135,10,8,'2023-11-07','05:36:42','2023-11-07','05:24:42'),(1432,136,8,10,'2023-11-08','04:37:31','2023-11-08','04:27:31'),(1433,136,8,5,'2023-11-08','04:48:31','2023-11-08','04:27:31'),(1434,136,8,6,'2023-11-08','04:59:31','2023-11-08','04:27:31'),(1435,136,8,11,'2023-11-08','05:10:31','2023-11-08','04:27:31'),(1436,136,10,5,'2023-11-08','04:48:31','2023-11-08','04:38:31'),(1437,136,10,6,'2023-11-08','04:59:31','2023-11-08','04:38:31'),(1438,136,10,11,'2023-11-08','05:10:31','2023-11-08','04:38:31'),(1439,136,5,6,'2023-11-08','04:59:31','2023-11-08','04:48:31'),(1440,136,5,11,'2023-11-08','05:10:31','2023-11-08','04:48:31'),(1441,136,6,11,'2023-11-08','05:10:31','2023-11-08','04:58:31'),(1442,137,2,5,'2023-11-08','12:05:00','2023-11-08','11:55:00'),(1443,137,2,10,'2023-11-08','12:16:00','2023-11-08','11:55:00'),(1444,137,2,8,'2023-11-08','12:27:00','2023-11-08','11:55:00'),(1445,137,5,10,'2023-11-08','12:16:00','2023-11-08','12:06:00'),(1446,137,5,8,'2023-11-08','12:27:00','2023-11-08','12:06:00'),(1447,137,10,8,'2023-11-08','12:27:00','2023-11-08','12:16:00'),(1448,138,8,10,'2023-11-08','04:08:38','2023-11-08','03:58:38'),(1449,138,8,5,'2023-11-08','04:19:38','2023-11-08','03:58:38'),(1450,138,8,1,'2023-11-08','04:30:38','2023-11-08','03:58:38'),(1451,138,8,3,'2023-11-08','04:41:38','2023-11-08','03:58:38'),(1452,138,8,9,'2023-11-08','04:51:38','2023-11-08','03:58:38'),(1453,138,8,4,'2023-11-08','05:01:38','2023-11-08','03:58:38'),(1454,138,10,5,'2023-11-08','04:19:38','2023-11-08','04:09:38'),(1455,138,10,1,'2023-11-08','04:30:38','2023-11-08','04:09:38'),(1456,138,10,3,'2023-11-08','04:41:38','2023-11-08','04:09:38'),(1457,138,10,9,'2023-11-08','04:51:38','2023-11-08','04:09:38'),(1458,138,10,4,'2023-11-08','05:01:38','2023-11-08','04:09:38'),(1459,138,5,1,'2023-11-08','04:30:38','2023-11-08','04:19:38'),(1460,138,5,3,'2023-11-08','04:41:38','2023-11-08','04:19:38'),(1461,138,5,9,'2023-11-08','04:51:38','2023-11-08','04:19:38'),(1462,138,5,4,'2023-11-08','05:01:38','2023-11-08','04:19:38'),(1463,138,1,3,'2023-11-08','04:41:38','2023-11-08','04:29:38'),(1464,138,1,9,'2023-11-08','04:51:38','2023-11-08','04:29:38'),(1465,138,1,4,'2023-11-08','05:01:38','2023-11-08','04:29:38'),(1466,138,3,9,'2023-11-08','04:51:38','2023-11-08','04:39:38'),(1467,138,3,4,'2023-11-08','05:01:38','2023-11-08','04:39:38'),(1468,138,9,4,'2023-11-08','05:01:38','2023-11-08','04:49:38'),(1469,139,8,10,'2023-11-08','07:59:58','2023-11-08','07:49:58'),(1470,139,8,5,'2023-11-08','08:10:58','2023-11-08','07:49:58'),(1471,139,8,1,'2023-11-08','08:21:58','2023-11-08','07:49:58'),(1472,139,10,5,'2023-11-08','08:10:58','2023-11-08','08:00:58'),(1473,139,10,1,'2023-11-08','08:21:58','2023-11-08','08:00:58'),(1474,139,5,1,'2023-11-08','08:21:58','2023-11-08','08:10:58'),(1475,140,3,1,'2023-11-08','05:03:42','2023-11-08','04:53:42'),(1476,140,3,5,'2023-11-08','05:14:42','2023-11-08','04:53:42'),(1477,140,3,10,'2023-11-08','05:25:42','2023-11-08','04:53:42'),(1478,140,3,8,'2023-11-08','05:36:42','2023-11-08','04:53:42'),(1479,140,1,5,'2023-11-08','05:14:42','2023-11-08','05:04:42'),(1480,140,1,10,'2023-11-08','05:25:42','2023-11-08','05:04:42'),(1481,140,1,8,'2023-11-08','05:36:42','2023-11-08','05:04:42'),(1482,140,5,10,'2023-11-08','05:25:42','2023-11-08','05:14:42'),(1483,140,5,8,'2023-11-08','05:36:42','2023-11-08','05:14:42'),(1484,140,10,8,'2023-11-08','05:36:42','2023-11-08','05:24:42'),(1485,141,8,10,'2023-11-09','04:37:31','2023-11-09','04:27:31'),(1486,141,8,5,'2023-11-09','04:48:31','2023-11-09','04:27:31'),(1487,141,8,6,'2023-11-09','04:59:31','2023-11-09','04:27:31'),(1488,141,8,11,'2023-11-09','05:10:31','2023-11-09','04:27:31'),(1489,141,10,5,'2023-11-09','04:48:31','2023-11-09','04:38:31'),(1490,141,10,6,'2023-11-09','04:59:31','2023-11-09','04:38:31'),(1491,141,10,11,'2023-11-09','05:10:31','2023-11-09','04:38:31'),(1492,141,5,6,'2023-11-09','04:59:31','2023-11-09','04:48:31'),(1493,141,5,11,'2023-11-09','05:10:31','2023-11-09','04:48:31'),(1494,141,6,11,'2023-11-09','05:10:31','2023-11-09','04:58:31'),(1495,142,2,5,'2023-11-09','12:05:00','2023-11-09','11:55:00'),(1496,142,2,10,'2023-11-09','12:16:00','2023-11-09','11:55:00'),(1497,142,2,8,'2023-11-09','12:27:00','2023-11-09','11:55:00'),(1498,142,5,10,'2023-11-09','12:16:00','2023-11-09','12:06:00'),(1499,142,5,8,'2023-11-09','12:27:00','2023-11-09','12:06:00'),(1500,142,10,8,'2023-11-09','12:27:00','2023-11-09','12:16:00'),(1501,143,8,10,'2023-11-09','04:08:38','2023-11-09','03:58:38'),(1502,143,8,5,'2023-11-09','04:19:38','2023-11-09','03:58:38'),(1503,143,8,1,'2023-11-09','04:30:38','2023-11-09','03:58:38'),(1504,143,8,3,'2023-11-09','04:41:38','2023-11-09','03:58:38'),(1505,143,8,9,'2023-11-09','04:51:38','2023-11-09','03:58:38'),(1506,143,8,4,'2023-11-09','05:01:38','2023-11-09','03:58:38'),(1507,143,10,5,'2023-11-09','04:19:38','2023-11-09','04:09:38'),(1508,143,10,1,'2023-11-09','04:30:38','2023-11-09','04:09:38'),(1509,143,10,3,'2023-11-09','04:41:38','2023-11-09','04:09:38'),(1510,143,10,9,'2023-11-09','04:51:38','2023-11-09','04:09:38'),(1511,143,10,4,'2023-11-09','05:01:38','2023-11-09','04:09:38'),(1512,143,5,1,'2023-11-09','04:30:38','2023-11-09','04:19:38'),(1513,143,5,3,'2023-11-09','04:41:38','2023-11-09','04:19:38'),(1514,143,5,9,'2023-11-09','04:51:38','2023-11-09','04:19:38'),(1515,143,5,4,'2023-11-09','05:01:38','2023-11-09','04:19:38'),(1516,143,1,3,'2023-11-09','04:41:38','2023-11-09','04:29:38'),(1517,143,1,9,'2023-11-09','04:51:38','2023-11-09','04:29:38'),(1518,143,1,4,'2023-11-09','05:01:38','2023-11-09','04:29:38'),(1519,143,3,9,'2023-11-09','04:51:38','2023-11-09','04:39:38'),(1520,143,3,4,'2023-11-09','05:01:38','2023-11-09','04:39:38'),(1521,143,9,4,'2023-11-09','05:01:38','2023-11-09','04:49:38'),(1522,144,8,10,'2023-11-09','07:59:58','2023-11-09','07:49:58'),(1523,144,8,5,'2023-11-09','08:10:58','2023-11-09','07:49:58'),(1524,144,8,1,'2023-11-09','08:21:58','2023-11-09','07:49:58'),(1525,144,10,5,'2023-11-09','08:10:58','2023-11-09','08:00:58'),(1526,144,10,1,'2023-11-09','08:21:58','2023-11-09','08:00:58'),(1527,144,5,1,'2023-11-09','08:21:58','2023-11-09','08:10:58'),(1528,145,3,1,'2023-11-09','05:03:42','2023-11-09','04:53:42'),(1529,145,3,5,'2023-11-09','05:14:42','2023-11-09','04:53:42'),(1530,145,3,10,'2023-11-09','05:25:42','2023-11-09','04:53:42'),(1531,145,3,8,'2023-11-09','05:36:42','2023-11-09','04:53:42'),(1532,145,1,5,'2023-11-09','05:14:42','2023-11-09','05:04:42'),(1533,145,1,10,'2023-11-09','05:25:42','2023-11-09','05:04:42'),(1534,145,1,8,'2023-11-09','05:36:42','2023-11-09','05:04:42'),(1535,145,5,10,'2023-11-09','05:25:42','2023-11-09','05:14:42'),(1536,145,5,8,'2023-11-09','05:36:42','2023-11-09','05:14:42'),(1537,145,10,8,'2023-11-09','05:36:42','2023-11-09','05:24:42'),(1538,146,8,10,'2023-11-10','04:37:31','2023-11-10','04:27:31'),(1539,146,8,5,'2023-11-10','04:48:31','2023-11-10','04:27:31'),(1540,146,8,6,'2023-11-10','04:59:31','2023-11-10','04:27:31'),(1541,146,8,11,'2023-11-10','05:10:31','2023-11-10','04:27:31'),(1542,146,10,5,'2023-11-10','04:48:31','2023-11-10','04:38:31'),(1543,146,10,6,'2023-11-10','04:59:31','2023-11-10','04:38:31'),(1544,146,10,11,'2023-11-10','05:10:31','2023-11-10','04:38:31'),(1545,146,5,6,'2023-11-10','04:59:31','2023-11-10','04:48:31'),(1546,146,5,11,'2023-11-10','05:10:31','2023-11-10','04:48:31'),(1547,146,6,11,'2023-11-10','05:10:31','2023-11-10','04:58:31'),(1548,147,2,5,'2023-11-10','12:05:00','2023-11-10','11:55:00'),(1549,147,2,10,'2023-11-10','12:16:00','2023-11-10','11:55:00'),(1550,147,2,8,'2023-11-10','12:27:00','2023-11-10','11:55:00'),(1551,147,5,10,'2023-11-10','12:16:00','2023-11-10','12:06:00'),(1552,147,5,8,'2023-11-10','12:27:00','2023-11-10','12:06:00'),(1553,147,10,8,'2023-11-10','12:27:00','2023-11-10','12:16:00'),(1554,148,8,10,'2023-11-10','04:08:38','2023-11-10','03:58:38'),(1555,148,8,5,'2023-11-10','04:19:38','2023-11-10','03:58:38'),(1556,148,8,1,'2023-11-10','04:30:38','2023-11-10','03:58:38'),(1557,148,8,3,'2023-11-10','04:41:38','2023-11-10','03:58:38'),(1558,148,8,9,'2023-11-10','04:51:38','2023-11-10','03:58:38'),(1559,148,8,4,'2023-11-10','05:01:38','2023-11-10','03:58:38'),(1560,148,10,5,'2023-11-10','04:19:38','2023-11-10','04:09:38'),(1561,148,10,1,'2023-11-10','04:30:38','2023-11-10','04:09:38'),(1562,148,10,3,'2023-11-10','04:41:38','2023-11-10','04:09:38'),(1563,148,10,9,'2023-11-10','04:51:38','2023-11-10','04:09:38'),(1564,148,10,4,'2023-11-10','05:01:38','2023-11-10','04:09:38'),(1565,148,5,1,'2023-11-10','04:30:38','2023-11-10','04:19:38'),(1566,148,5,3,'2023-11-10','04:41:38','2023-11-10','04:19:38'),(1567,148,5,9,'2023-11-10','04:51:38','2023-11-10','04:19:38'),(1568,148,5,4,'2023-11-10','05:01:38','2023-11-10','04:19:38'),(1569,148,1,3,'2023-11-10','04:41:38','2023-11-10','04:29:38'),(1570,148,1,9,'2023-11-10','04:51:38','2023-11-10','04:29:38'),(1571,148,1,4,'2023-11-10','05:01:38','2023-11-10','04:29:38'),(1572,148,3,9,'2023-11-10','04:51:38','2023-11-10','04:39:38'),(1573,148,3,4,'2023-11-10','05:01:38','2023-11-10','04:39:38'),(1574,148,9,4,'2023-11-10','05:01:38','2023-11-10','04:49:38'),(1575,149,8,10,'2023-11-10','07:59:58','2023-11-10','07:49:58'),(1576,149,8,5,'2023-11-10','08:10:58','2023-11-10','07:49:58'),(1577,149,8,1,'2023-11-10','08:21:58','2023-11-10','07:49:58'),(1578,149,10,5,'2023-11-10','08:10:58','2023-11-10','08:00:58'),(1579,149,10,1,'2023-11-10','08:21:58','2023-11-10','08:00:58'),(1580,149,5,1,'2023-11-10','08:21:58','2023-11-10','08:10:58'),(1581,150,3,1,'2023-11-10','05:03:42','2023-11-10','04:53:42'),(1582,150,3,5,'2023-11-10','05:14:42','2023-11-10','04:53:42'),(1583,150,3,10,'2023-11-10','05:25:42','2023-11-10','04:53:42'),(1584,150,3,8,'2023-11-10','05:36:42','2023-11-10','04:53:42'),(1585,150,1,5,'2023-11-10','05:14:42','2023-11-10','05:04:42'),(1586,150,1,10,'2023-11-10','05:25:42','2023-11-10','05:04:42'),(1587,150,1,8,'2023-11-10','05:36:42','2023-11-10','05:04:42'),(1588,150,5,10,'2023-11-10','05:25:42','2023-11-10','05:14:42'),(1589,150,5,8,'2023-11-10','05:36:42','2023-11-10','05:14:42'),(1590,150,10,8,'2023-11-10','05:36:42','2023-11-10','05:24:42'),(1591,151,8,10,'2023-11-11','04:37:31','2023-11-11','04:27:31'),(1592,151,8,5,'2023-11-11','04:48:31','2023-11-11','04:27:31'),(1593,151,8,6,'2023-11-11','04:59:31','2023-11-11','04:27:31'),(1594,151,8,11,'2023-11-11','05:10:31','2023-11-11','04:27:31'),(1595,151,10,5,'2023-11-11','04:48:31','2023-11-11','04:38:31'),(1596,151,10,6,'2023-11-11','04:59:31','2023-11-11','04:38:31'),(1597,151,10,11,'2023-11-11','05:10:31','2023-11-11','04:38:31'),(1598,151,5,6,'2023-11-11','04:59:31','2023-11-11','04:48:31'),(1599,151,5,11,'2023-11-11','05:10:31','2023-11-11','04:48:31'),(1600,151,6,11,'2023-11-11','05:10:31','2023-11-11','04:58:31'),(1601,152,2,5,'2023-11-11','12:05:00','2023-11-11','11:55:00'),(1602,152,2,10,'2023-11-11','12:16:00','2023-11-11','11:55:00'),(1603,152,2,8,'2023-11-11','12:27:00','2023-11-11','11:55:00'),(1604,152,5,10,'2023-11-11','12:16:00','2023-11-11','12:06:00'),(1605,152,5,8,'2023-11-11','12:27:00','2023-11-11','12:06:00'),(1606,152,10,8,'2023-11-11','12:27:00','2023-11-11','12:16:00'),(1607,153,8,10,'2023-11-11','04:08:38','2023-11-11','03:58:38'),(1608,153,8,5,'2023-11-11','04:19:38','2023-11-11','03:58:38'),(1609,153,8,1,'2023-11-11','04:30:38','2023-11-11','03:58:38'),(1610,153,8,3,'2023-11-11','04:41:38','2023-11-11','03:58:38'),(1611,153,8,9,'2023-11-11','04:51:38','2023-11-11','03:58:38'),(1612,153,8,4,'2023-11-11','05:01:38','2023-11-11','03:58:38'),(1613,153,10,5,'2023-11-11','04:19:38','2023-11-11','04:09:38'),(1614,153,10,1,'2023-11-11','04:30:38','2023-11-11','04:09:38'),(1615,153,10,3,'2023-11-11','04:41:38','2023-11-11','04:09:38'),(1616,153,10,9,'2023-11-11','04:51:38','2023-11-11','04:09:38'),(1617,153,10,4,'2023-11-11','05:01:38','2023-11-11','04:09:38'),(1618,153,5,1,'2023-11-11','04:30:38','2023-11-11','04:19:38'),(1619,153,5,3,'2023-11-11','04:41:38','2023-11-11','04:19:38'),(1620,153,5,9,'2023-11-11','04:51:38','2023-11-11','04:19:38'),(1621,153,5,4,'2023-11-11','05:01:38','2023-11-11','04:19:38'),(1622,153,1,3,'2023-11-11','04:41:38','2023-11-11','04:29:38'),(1623,153,1,9,'2023-11-11','04:51:38','2023-11-11','04:29:38'),(1624,153,1,4,'2023-11-11','05:01:38','2023-11-11','04:29:38'),(1625,153,3,9,'2023-11-11','04:51:38','2023-11-11','04:39:38'),(1626,153,3,4,'2023-11-11','05:01:38','2023-11-11','04:39:38'),(1627,153,9,4,'2023-11-11','05:01:38','2023-11-11','04:49:38'),(1628,154,8,10,'2023-11-11','07:59:58','2023-11-11','07:49:58'),(1629,154,8,5,'2023-11-11','08:10:58','2023-11-11','07:49:58'),(1630,154,8,1,'2023-11-11','08:21:58','2023-11-11','07:49:58'),(1631,154,10,5,'2023-11-11','08:10:58','2023-11-11','08:00:58'),(1632,154,10,1,'2023-11-11','08:21:58','2023-11-11','08:00:58'),(1633,154,5,1,'2023-11-11','08:21:58','2023-11-11','08:10:58'),(1634,155,3,1,'2023-11-11','05:03:42','2023-11-11','04:53:42'),(1635,155,3,5,'2023-11-11','05:14:42','2023-11-11','04:53:42'),(1636,155,3,10,'2023-11-11','05:25:42','2023-11-11','04:53:42'),(1637,155,3,8,'2023-11-11','05:36:42','2023-11-11','04:53:42'),(1638,155,1,5,'2023-11-11','05:14:42','2023-11-11','05:04:42'),(1639,155,1,10,'2023-11-11','05:25:42','2023-11-11','05:04:42'),(1640,155,1,8,'2023-11-11','05:36:42','2023-11-11','05:04:42'),(1641,155,5,10,'2023-11-11','05:25:42','2023-11-11','05:14:42'),(1642,155,5,8,'2023-11-11','05:36:42','2023-11-11','05:14:42'),(1643,155,10,8,'2023-11-11','05:36:42','2023-11-11','05:24:42'),(1644,156,8,10,'2023-11-12','04:37:31','2023-11-12','04:27:31'),(1645,156,8,5,'2023-11-12','04:48:31','2023-11-12','04:27:31'),(1646,156,8,6,'2023-11-12','04:59:31','2023-11-12','04:27:31'),(1647,156,8,11,'2023-11-12','05:10:31','2023-11-12','04:27:31'),(1648,156,10,5,'2023-11-12','04:48:31','2023-11-12','04:38:31'),(1649,156,10,6,'2023-11-12','04:59:31','2023-11-12','04:38:31'),(1650,156,10,11,'2023-11-12','05:10:31','2023-11-12','04:38:31'),(1651,156,5,6,'2023-11-12','04:59:31','2023-11-12','04:48:31'),(1652,156,5,11,'2023-11-12','05:10:31','2023-11-12','04:48:31'),(1653,156,6,11,'2023-11-12','05:10:31','2023-11-12','04:58:31'),(1654,157,2,5,'2023-11-12','12:05:00','2023-11-12','11:55:00'),(1655,157,2,10,'2023-11-12','12:16:00','2023-11-12','11:55:00'),(1656,157,2,8,'2023-11-12','12:27:00','2023-11-12','11:55:00'),(1657,157,5,10,'2023-11-12','12:16:00','2023-11-12','12:06:00'),(1658,157,5,8,'2023-11-12','12:27:00','2023-11-12','12:06:00'),(1659,157,10,8,'2023-11-12','12:27:00','2023-11-12','12:16:00'),(1660,158,8,10,'2023-11-12','04:08:38','2023-11-12','03:58:38'),(1661,158,8,5,'2023-11-12','04:19:38','2023-11-12','03:58:38'),(1662,158,8,1,'2023-11-12','04:30:38','2023-11-12','03:58:38'),(1663,158,8,3,'2023-11-12','04:41:38','2023-11-12','03:58:38'),(1664,158,8,9,'2023-11-12','04:51:38','2023-11-12','03:58:38'),(1665,158,8,4,'2023-11-12','05:01:38','2023-11-12','03:58:38'),(1666,158,10,5,'2023-11-12','04:19:38','2023-11-12','04:09:38'),(1667,158,10,1,'2023-11-12','04:30:38','2023-11-12','04:09:38'),(1668,158,10,3,'2023-11-12','04:41:38','2023-11-12','04:09:38'),(1669,158,10,9,'2023-11-12','04:51:38','2023-11-12','04:09:38'),(1670,158,10,4,'2023-11-12','05:01:38','2023-11-12','04:09:38'),(1671,158,5,1,'2023-11-12','04:30:38','2023-11-12','04:19:38'),(1672,158,5,3,'2023-11-12','04:41:38','2023-11-12','04:19:38'),(1673,158,5,9,'2023-11-12','04:51:38','2023-11-12','04:19:38'),(1674,158,5,4,'2023-11-12','05:01:38','2023-11-12','04:19:38'),(1675,158,1,3,'2023-11-12','04:41:38','2023-11-12','04:29:38'),(1676,158,1,9,'2023-11-12','04:51:38','2023-11-12','04:29:38'),(1677,158,1,4,'2023-11-12','05:01:38','2023-11-12','04:29:38'),(1678,158,3,9,'2023-11-12','04:51:38','2023-11-12','04:39:38'),(1679,158,3,4,'2023-11-12','05:01:38','2023-11-12','04:39:38'),(1680,158,9,4,'2023-11-12','05:01:38','2023-11-12','04:49:38'),(1681,159,8,10,'2023-11-12','07:59:58','2023-11-12','07:49:58'),(1682,159,8,5,'2023-11-12','08:10:58','2023-11-12','07:49:58'),(1683,159,8,1,'2023-11-12','08:21:58','2023-11-12','07:49:58'),(1684,159,10,5,'2023-11-12','08:10:58','2023-11-12','08:00:58'),(1685,159,10,1,'2023-11-12','08:21:58','2023-11-12','08:00:58'),(1686,159,5,1,'2023-11-12','08:21:58','2023-11-12','08:10:58'),(1687,160,3,1,'2023-11-12','05:03:42','2023-11-12','04:53:42'),(1688,160,3,5,'2023-11-12','05:14:42','2023-11-12','04:53:42'),(1689,160,3,10,'2023-11-12','05:25:42','2023-11-12','04:53:42'),(1690,160,3,8,'2023-11-12','05:36:42','2023-11-12','04:53:42'),(1691,160,1,5,'2023-11-12','05:14:42','2023-11-12','05:04:42'),(1692,160,1,10,'2023-11-12','05:25:42','2023-11-12','05:04:42'),(1693,160,1,8,'2023-11-12','05:36:42','2023-11-12','05:04:42'),(1694,160,5,10,'2023-11-12','05:25:42','2023-11-12','05:14:42'),(1695,160,5,8,'2023-11-12','05:36:42','2023-11-12','05:14:42'),(1696,160,10,8,'2023-11-12','05:36:42','2023-11-12','05:24:42'),(1697,161,8,10,'2023-11-13','04:37:31','2023-11-13','04:27:31'),(1698,161,8,5,'2023-11-13','04:48:31','2023-11-13','04:27:31'),(1699,161,8,6,'2023-11-13','04:59:31','2023-11-13','04:27:31'),(1700,161,8,11,'2023-11-13','05:10:31','2023-11-13','04:27:31'),(1701,161,10,5,'2023-11-13','04:48:31','2023-11-13','04:38:31'),(1702,161,10,6,'2023-11-13','04:59:31','2023-11-13','04:38:31'),(1703,161,10,11,'2023-11-13','05:10:31','2023-11-13','04:38:31'),(1704,161,5,6,'2023-11-13','04:59:31','2023-11-13','04:48:31'),(1705,161,5,11,'2023-11-13','05:10:31','2023-11-13','04:48:31'),(1706,161,6,11,'2023-11-13','05:10:31','2023-11-13','04:58:31'),(1707,162,2,5,'2023-11-13','12:05:00','2023-11-13','11:55:00'),(1708,162,2,10,'2023-11-13','12:16:00','2023-11-13','11:55:00'),(1709,162,2,8,'2023-11-13','12:27:00','2023-11-13','11:55:00'),(1710,162,5,10,'2023-11-13','12:16:00','2023-11-13','12:06:00'),(1711,162,5,8,'2023-11-13','12:27:00','2023-11-13','12:06:00'),(1712,162,10,8,'2023-11-13','12:27:00','2023-11-13','12:16:00'),(1713,163,8,10,'2023-11-13','04:08:38','2023-11-13','03:58:38'),(1714,163,8,5,'2023-11-13','04:19:38','2023-11-13','03:58:38'),(1715,163,8,1,'2023-11-13','04:30:38','2023-11-13','03:58:38'),(1716,163,8,3,'2023-11-13','04:41:38','2023-11-13','03:58:38'),(1717,163,8,9,'2023-11-13','04:51:38','2023-11-13','03:58:38'),(1718,163,8,4,'2023-11-13','05:01:38','2023-11-13','03:58:38'),(1719,163,10,5,'2023-11-13','04:19:38','2023-11-13','04:09:38'),(1720,163,10,1,'2023-11-13','04:30:38','2023-11-13','04:09:38'),(1721,163,10,3,'2023-11-13','04:41:38','2023-11-13','04:09:38'),(1722,163,10,9,'2023-11-13','04:51:38','2023-11-13','04:09:38'),(1723,163,10,4,'2023-11-13','05:01:38','2023-11-13','04:09:38'),(1724,163,5,1,'2023-11-13','04:30:38','2023-11-13','04:19:38'),(1725,163,5,3,'2023-11-13','04:41:38','2023-11-13','04:19:38'),(1726,163,5,9,'2023-11-13','04:51:38','2023-11-13','04:19:38'),(1727,163,5,4,'2023-11-13','05:01:38','2023-11-13','04:19:38'),(1728,163,1,3,'2023-11-13','04:41:38','2023-11-13','04:29:38'),(1729,163,1,9,'2023-11-13','04:51:38','2023-11-13','04:29:38'),(1730,163,1,4,'2023-11-13','05:01:38','2023-11-13','04:29:38'),(1731,163,3,9,'2023-11-13','04:51:38','2023-11-13','04:39:38'),(1732,163,3,4,'2023-11-13','05:01:38','2023-11-13','04:39:38'),(1733,163,9,4,'2023-11-13','05:01:38','2023-11-13','04:49:38'),(1734,164,8,10,'2023-11-13','07:59:58','2023-11-13','07:49:58'),(1735,164,8,5,'2023-11-13','08:10:58','2023-11-13','07:49:58'),(1736,164,8,1,'2023-11-13','08:21:58','2023-11-13','07:49:58'),(1737,164,10,5,'2023-11-13','08:10:58','2023-11-13','08:00:58'),(1738,164,10,1,'2023-11-13','08:21:58','2023-11-13','08:00:58'),(1739,164,5,1,'2023-11-13','08:21:58','2023-11-13','08:10:58'),(1740,165,3,1,'2023-11-13','05:03:42','2023-11-13','04:53:42'),(1741,165,3,5,'2023-11-13','05:14:42','2023-11-13','04:53:42'),(1742,165,3,10,'2023-11-13','05:25:42','2023-11-13','04:53:42'),(1743,165,3,8,'2023-11-13','05:36:42','2023-11-13','04:53:42'),(1744,165,1,5,'2023-11-13','05:14:42','2023-11-13','05:04:42'),(1745,165,1,10,'2023-11-13','05:25:42','2023-11-13','05:04:42'),(1746,165,1,8,'2023-11-13','05:36:42','2023-11-13','05:04:42'),(1747,165,5,10,'2023-11-13','05:25:42','2023-11-13','05:14:42'),(1748,165,5,8,'2023-11-13','05:36:42','2023-11-13','05:14:42'),(1749,165,10,8,'2023-11-13','05:36:42','2023-11-13','05:24:42'),(1750,166,8,10,'2023-11-14','04:37:31','2023-11-14','04:27:31'),(1751,166,8,5,'2023-11-14','04:48:31','2023-11-14','04:27:31'),(1752,166,8,6,'2023-11-14','04:59:31','2023-11-14','04:27:31'),(1753,166,8,11,'2023-11-14','05:10:31','2023-11-14','04:27:31'),(1754,166,10,5,'2023-11-14','04:48:31','2023-11-14','04:38:31'),(1755,166,10,6,'2023-11-14','04:59:31','2023-11-14','04:38:31'),(1756,166,10,11,'2023-11-14','05:10:31','2023-11-14','04:38:31'),(1757,166,5,6,'2023-11-14','04:59:31','2023-11-14','04:48:31'),(1758,166,5,11,'2023-11-14','05:10:31','2023-11-14','04:48:31'),(1759,166,6,11,'2023-11-14','05:10:31','2023-11-14','04:58:31'),(1760,167,2,5,'2023-11-14','12:05:00','2023-11-14','11:55:00'),(1761,167,2,10,'2023-11-14','12:16:00','2023-11-14','11:55:00'),(1762,167,2,8,'2023-11-14','12:27:00','2023-11-14','11:55:00'),(1763,167,5,10,'2023-11-14','12:16:00','2023-11-14','12:06:00'),(1764,167,5,8,'2023-11-14','12:27:00','2023-11-14','12:06:00'),(1765,167,10,8,'2023-11-14','12:27:00','2023-11-14','12:16:00'),(1766,168,8,10,'2023-11-14','04:08:38','2023-11-14','03:58:38'),(1767,168,8,5,'2023-11-14','04:19:38','2023-11-14','03:58:38'),(1768,168,8,1,'2023-11-14','04:30:38','2023-11-14','03:58:38'),(1769,168,8,3,'2023-11-14','04:41:38','2023-11-14','03:58:38'),(1770,168,8,9,'2023-11-14','04:51:38','2023-11-14','03:58:38'),(1771,168,8,4,'2023-11-14','05:01:38','2023-11-14','03:58:38'),(1772,168,10,5,'2023-11-14','04:19:38','2023-11-14','04:09:38'),(1773,168,10,1,'2023-11-14','04:30:38','2023-11-14','04:09:38'),(1774,168,10,3,'2023-11-14','04:41:38','2023-11-14','04:09:38'),(1775,168,10,9,'2023-11-14','04:51:38','2023-11-14','04:09:38'),(1776,168,10,4,'2023-11-14','05:01:38','2023-11-14','04:09:38'),(1777,168,5,1,'2023-11-14','04:30:38','2023-11-14','04:19:38'),(1778,168,5,3,'2023-11-14','04:41:38','2023-11-14','04:19:38'),(1779,168,5,9,'2023-11-14','04:51:38','2023-11-14','04:19:38'),(1780,168,5,4,'2023-11-14','05:01:38','2023-11-14','04:19:38'),(1781,168,1,3,'2023-11-14','04:41:38','2023-11-14','04:29:38'),(1782,168,1,9,'2023-11-14','04:51:38','2023-11-14','04:29:38'),(1783,168,1,4,'2023-11-14','05:01:38','2023-11-14','04:29:38'),(1784,168,3,9,'2023-11-14','04:51:38','2023-11-14','04:39:38'),(1785,168,3,4,'2023-11-14','05:01:38','2023-11-14','04:39:38'),(1786,168,9,4,'2023-11-14','05:01:38','2023-11-14','04:49:38'),(1787,169,8,10,'2023-11-14','07:59:58','2023-11-14','07:49:58'),(1788,169,8,5,'2023-11-14','08:10:58','2023-11-14','07:49:58'),(1789,169,8,1,'2023-11-14','08:21:58','2023-11-14','07:49:58'),(1790,169,10,5,'2023-11-14','08:10:58','2023-11-14','08:00:58'),(1791,169,10,1,'2023-11-14','08:21:58','2023-11-14','08:00:58'),(1792,169,5,1,'2023-11-14','08:21:58','2023-11-14','08:10:58'),(1793,170,3,1,'2023-11-14','05:03:42','2023-11-14','04:53:42'),(1794,170,3,5,'2023-11-14','05:14:42','2023-11-14','04:53:42'),(1795,170,3,10,'2023-11-14','05:25:42','2023-11-14','04:53:42'),(1796,170,3,8,'2023-11-14','05:36:42','2023-11-14','04:53:42'),(1797,170,1,5,'2023-11-14','05:14:42','2023-11-14','05:04:42'),(1798,170,1,10,'2023-11-14','05:25:42','2023-11-14','05:04:42'),(1799,170,1,8,'2023-11-14','05:36:42','2023-11-14','05:04:42'),(1800,170,5,10,'2023-11-14','05:25:42','2023-11-14','05:14:42'),(1801,170,5,8,'2023-11-14','05:36:42','2023-11-14','05:14:42'),(1802,170,10,8,'2023-11-14','05:36:42','2023-11-14','05:24:42'),(1803,171,8,10,'2023-11-15','04:37:31','2023-11-15','04:27:31'),(1804,171,8,5,'2023-11-15','04:48:31','2023-11-15','04:27:31'),(1805,171,8,6,'2023-11-15','04:59:31','2023-11-15','04:27:31'),(1806,171,8,11,'2023-11-15','05:10:31','2023-11-15','04:27:31'),(1807,171,10,5,'2023-11-15','04:48:31','2023-11-15','04:38:31'),(1808,171,10,6,'2023-11-15','04:59:31','2023-11-15','04:38:31'),(1809,171,10,11,'2023-11-15','05:10:31','2023-11-15','04:38:31'),(1810,171,5,6,'2023-11-15','04:59:31','2023-11-15','04:48:31'),(1811,171,5,11,'2023-11-15','05:10:31','2023-11-15','04:48:31'),(1812,171,6,11,'2023-11-15','05:10:31','2023-11-15','04:58:31'),(1813,172,2,5,'2023-11-15','12:05:00','2023-11-15','11:55:00'),(1814,172,2,10,'2023-11-15','12:16:00','2023-11-15','11:55:00'),(1815,172,2,8,'2023-11-15','12:27:00','2023-11-15','11:55:00'),(1816,172,5,10,'2023-11-15','12:16:00','2023-11-15','12:06:00'),(1817,172,5,8,'2023-11-15','12:27:00','2023-11-15','12:06:00'),(1818,172,10,8,'2023-11-15','12:27:00','2023-11-15','12:16:00'),(1819,173,8,10,'2023-11-15','04:08:38','2023-11-15','03:58:38'),(1820,173,8,5,'2023-11-15','04:19:38','2023-11-15','03:58:38'),(1821,173,8,1,'2023-11-15','04:30:38','2023-11-15','03:58:38'),(1822,173,8,3,'2023-11-15','04:41:38','2023-11-15','03:58:38'),(1823,173,8,9,'2023-11-15','04:51:38','2023-11-15','03:58:38'),(1824,173,8,4,'2023-11-15','05:01:38','2023-11-15','03:58:38'),(1825,173,10,5,'2023-11-15','04:19:38','2023-11-15','04:09:38'),(1826,173,10,1,'2023-11-15','04:30:38','2023-11-15','04:09:38'),(1827,173,10,3,'2023-11-15','04:41:38','2023-11-15','04:09:38'),(1828,173,10,9,'2023-11-15','04:51:38','2023-11-15','04:09:38'),(1829,173,10,4,'2023-11-15','05:01:38','2023-11-15','04:09:38'),(1830,173,5,1,'2023-11-15','04:30:38','2023-11-15','04:19:38'),(1831,173,5,3,'2023-11-15','04:41:38','2023-11-15','04:19:38'),(1832,173,5,9,'2023-11-15','04:51:38','2023-11-15','04:19:38'),(1833,173,5,4,'2023-11-15','05:01:38','2023-11-15','04:19:38'),(1834,173,1,3,'2023-11-15','04:41:38','2023-11-15','04:29:38'),(1835,173,1,9,'2023-11-15','04:51:38','2023-11-15','04:29:38'),(1836,173,1,4,'2023-11-15','05:01:38','2023-11-15','04:29:38'),(1837,173,3,9,'2023-11-15','04:51:38','2023-11-15','04:39:38'),(1838,173,3,4,'2023-11-15','05:01:38','2023-11-15','04:39:38'),(1839,173,9,4,'2023-11-15','05:01:38','2023-11-15','04:49:38'),(1840,174,8,10,'2023-11-15','07:59:58','2023-11-15','07:49:58'),(1841,174,8,5,'2023-11-15','08:10:58','2023-11-15','07:49:58'),(1842,174,8,1,'2023-11-15','08:21:58','2023-11-15','07:49:58'),(1843,174,10,5,'2023-11-15','08:10:58','2023-11-15','08:00:58'),(1844,174,10,1,'2023-11-15','08:21:58','2023-11-15','08:00:58'),(1845,174,5,1,'2023-11-15','08:21:58','2023-11-15','08:10:58'),(1846,175,3,1,'2023-11-15','05:03:42','2023-11-15','04:53:42'),(1847,175,3,5,'2023-11-15','05:14:42','2023-11-15','04:53:42'),(1848,175,3,10,'2023-11-15','05:25:42','2023-11-15','04:53:42'),(1849,175,3,8,'2023-11-15','05:36:42','2023-11-15','04:53:42'),(1850,175,1,5,'2023-11-15','05:14:42','2023-11-15','05:04:42'),(1851,175,1,10,'2023-11-15','05:25:42','2023-11-15','05:04:42'),(1852,175,1,8,'2023-11-15','05:36:42','2023-11-15','05:04:42'),(1853,175,5,10,'2023-11-15','05:25:42','2023-11-15','05:14:42'),(1854,175,5,8,'2023-11-15','05:36:42','2023-11-15','05:14:42'),(1855,175,10,8,'2023-11-15','05:36:42','2023-11-15','05:24:42'),(1856,176,8,10,'2023-11-16','04:37:31','2023-11-16','04:27:31'),(1857,176,8,5,'2023-11-16','04:48:31','2023-11-16','04:27:31'),(1858,176,8,6,'2023-11-16','04:59:31','2023-11-16','04:27:31'),(1859,176,8,11,'2023-11-16','05:10:31','2023-11-16','04:27:31'),(1860,176,10,5,'2023-11-16','04:48:31','2023-11-16','04:38:31'),(1861,176,10,6,'2023-11-16','04:59:31','2023-11-16','04:38:31'),(1862,176,10,11,'2023-11-16','05:10:31','2023-11-16','04:38:31'),(1863,176,5,6,'2023-11-16','04:59:31','2023-11-16','04:48:31'),(1864,176,5,11,'2023-11-16','05:10:31','2023-11-16','04:48:31'),(1865,176,6,11,'2023-11-16','05:10:31','2023-11-16','04:58:31'),(1866,177,2,5,'2023-11-16','12:05:00','2023-11-16','11:55:00'),(1867,177,2,10,'2023-11-16','12:16:00','2023-11-16','11:55:00'),(1868,177,2,8,'2023-11-16','12:27:00','2023-11-16','11:55:00'),(1869,177,5,10,'2023-11-16','12:16:00','2023-11-16','12:06:00'),(1870,177,5,8,'2023-11-16','12:27:00','2023-11-16','12:06:00'),(1871,177,10,8,'2023-11-16','12:27:00','2023-11-16','12:16:00'),(1872,178,8,10,'2023-11-16','04:08:38','2023-11-16','03:58:38'),(1873,178,8,5,'2023-11-16','04:19:38','2023-11-16','03:58:38'),(1874,178,8,1,'2023-11-16','04:30:38','2023-11-16','03:58:38'),(1875,178,8,3,'2023-11-16','04:41:38','2023-11-16','03:58:38'),(1876,178,8,9,'2023-11-16','04:51:38','2023-11-16','03:58:38'),(1877,178,8,4,'2023-11-16','05:01:38','2023-11-16','03:58:38'),(1878,178,10,5,'2023-11-16','04:19:38','2023-11-16','04:09:38'),(1879,178,10,1,'2023-11-16','04:30:38','2023-11-16','04:09:38'),(1880,178,10,3,'2023-11-16','04:41:38','2023-11-16','04:09:38'),(1881,178,10,9,'2023-11-16','04:51:38','2023-11-16','04:09:38'),(1882,178,10,4,'2023-11-16','05:01:38','2023-11-16','04:09:38'),(1883,178,5,1,'2023-11-16','04:30:38','2023-11-16','04:19:38'),(1884,178,5,3,'2023-11-16','04:41:38','2023-11-16','04:19:38'),(1885,178,5,9,'2023-11-16','04:51:38','2023-11-16','04:19:38'),(1886,178,5,4,'2023-11-16','05:01:38','2023-11-16','04:19:38'),(1887,178,1,3,'2023-11-16','04:41:38','2023-11-16','04:29:38'),(1888,178,1,9,'2023-11-16','04:51:38','2023-11-16','04:29:38'),(1889,178,1,4,'2023-11-16','05:01:38','2023-11-16','04:29:38'),(1890,178,3,9,'2023-11-16','04:51:38','2023-11-16','04:39:38'),(1891,178,3,4,'2023-11-16','05:01:38','2023-11-16','04:39:38'),(1892,178,9,4,'2023-11-16','05:01:38','2023-11-16','04:49:38'),(1893,179,8,10,'2023-11-16','07:59:58','2023-11-16','07:49:58'),(1894,179,8,5,'2023-11-16','08:10:58','2023-11-16','07:49:58'),(1895,179,8,1,'2023-11-16','08:21:58','2023-11-16','07:49:58'),(1896,179,10,5,'2023-11-16','08:10:58','2023-11-16','08:00:58'),(1897,179,10,1,'2023-11-16','08:21:58','2023-11-16','08:00:58'),(1898,179,5,1,'2023-11-16','08:21:58','2023-11-16','08:10:58'),(1899,180,3,1,'2023-11-16','05:03:42','2023-11-16','04:53:42'),(1900,180,3,5,'2023-11-16','05:14:42','2023-11-16','04:53:42'),(1901,180,3,10,'2023-11-16','05:25:42','2023-11-16','04:53:42'),(1902,180,3,8,'2023-11-16','05:36:42','2023-11-16','04:53:42'),(1903,180,1,5,'2023-11-16','05:14:42','2023-11-16','05:04:42'),(1904,180,1,10,'2023-11-16','05:25:42','2023-11-16','05:04:42'),(1905,180,1,8,'2023-11-16','05:36:42','2023-11-16','05:04:42'),(1906,180,5,10,'2023-11-16','05:25:42','2023-11-16','05:14:42'),(1907,180,5,8,'2023-11-16','05:36:42','2023-11-16','05:14:42'),(1908,180,10,8,'2023-11-16','05:36:42','2023-11-16','05:24:42'),(1909,181,8,10,'2023-11-17','04:37:31','2023-11-17','04:27:31'),(1910,181,8,5,'2023-11-17','04:48:31','2023-11-17','04:27:31'),(1911,181,8,6,'2023-11-17','04:59:31','2023-11-17','04:27:31'),(1912,181,8,11,'2023-11-17','05:10:31','2023-11-17','04:27:31'),(1913,181,10,5,'2023-11-17','04:48:31','2023-11-17','04:38:31'),(1914,181,10,6,'2023-11-17','04:59:31','2023-11-17','04:38:31'),(1915,181,10,11,'2023-11-17','05:10:31','2023-11-17','04:38:31'),(1916,181,5,6,'2023-11-17','04:59:31','2023-11-17','04:48:31'),(1917,181,5,11,'2023-11-17','05:10:31','2023-11-17','04:48:31'),(1918,181,6,11,'2023-11-17','05:10:31','2023-11-17','04:58:31'),(1919,182,2,5,'2023-11-17','12:05:00','2023-11-17','11:55:00'),(1920,182,2,10,'2023-11-17','12:16:00','2023-11-17','11:55:00'),(1921,182,2,8,'2023-11-17','12:27:00','2023-11-17','11:55:00'),(1922,182,5,10,'2023-11-17','12:16:00','2023-11-17','12:06:00'),(1923,182,5,8,'2023-11-17','12:27:00','2023-11-17','12:06:00'),(1924,182,10,8,'2023-11-17','12:27:00','2023-11-17','12:16:00'),(1925,183,8,10,'2023-11-17','04:08:38','2023-11-17','03:58:38'),(1926,183,8,5,'2023-11-17','04:19:38','2023-11-17','03:58:38'),(1927,183,8,1,'2023-11-17','04:30:38','2023-11-17','03:58:38'),(1928,183,8,3,'2023-11-17','04:41:38','2023-11-17','03:58:38'),(1929,183,8,9,'2023-11-17','04:51:38','2023-11-17','03:58:38'),(1930,183,8,4,'2023-11-17','05:01:38','2023-11-17','03:58:38'),(1931,183,10,5,'2023-11-17','04:19:38','2023-11-17','04:09:38'),(1932,183,10,1,'2023-11-17','04:30:38','2023-11-17','04:09:38'),(1933,183,10,3,'2023-11-17','04:41:38','2023-11-17','04:09:38'),(1934,183,10,9,'2023-11-17','04:51:38','2023-11-17','04:09:38'),(1935,183,10,4,'2023-11-17','05:01:38','2023-11-17','04:09:38'),(1936,183,5,1,'2023-11-17','04:30:38','2023-11-17','04:19:38'),(1937,183,5,3,'2023-11-17','04:41:38','2023-11-17','04:19:38'),(1938,183,5,9,'2023-11-17','04:51:38','2023-11-17','04:19:38'),(1939,183,5,4,'2023-11-17','05:01:38','2023-11-17','04:19:38'),(1940,183,1,3,'2023-11-17','04:41:38','2023-11-17','04:29:38'),(1941,183,1,9,'2023-11-17','04:51:38','2023-11-17','04:29:38'),(1942,183,1,4,'2023-11-17','05:01:38','2023-11-17','04:29:38'),(1943,183,3,9,'2023-11-17','04:51:38','2023-11-17','04:39:38'),(1944,183,3,4,'2023-11-17','05:01:38','2023-11-17','04:39:38'),(1945,183,9,4,'2023-11-17','05:01:38','2023-11-17','04:49:38'),(1946,184,8,10,'2023-11-17','07:59:58','2023-11-17','07:49:58'),(1947,184,8,5,'2023-11-17','08:10:58','2023-11-17','07:49:58'),(1948,184,8,1,'2023-11-17','08:21:58','2023-11-17','07:49:58'),(1949,184,10,5,'2023-11-17','08:10:58','2023-11-17','08:00:58'),(1950,184,10,1,'2023-11-17','08:21:58','2023-11-17','08:00:58'),(1951,184,5,1,'2023-11-17','08:21:58','2023-11-17','08:10:58'),(1952,185,3,1,'2023-11-17','05:03:42','2023-11-17','04:53:42'),(1953,185,3,5,'2023-11-17','05:14:42','2023-11-17','04:53:42'),(1954,185,3,10,'2023-11-17','05:25:42','2023-11-17','04:53:42'),(1955,185,3,8,'2023-11-17','05:36:42','2023-11-17','04:53:42'),(1956,185,1,5,'2023-11-17','05:14:42','2023-11-17','05:04:42'),(1957,185,1,10,'2023-11-17','05:25:42','2023-11-17','05:04:42'),(1958,185,1,8,'2023-11-17','05:36:42','2023-11-17','05:04:42'),(1959,185,5,10,'2023-11-17','05:25:42','2023-11-17','05:14:42'),(1960,185,5,8,'2023-11-17','05:36:42','2023-11-17','05:14:42'),(1961,185,10,8,'2023-11-17','05:36:42','2023-11-17','05:24:42'),(1962,186,8,10,'2023-11-18','04:37:31','2023-11-18','04:27:31'),(1963,186,8,5,'2023-11-18','04:48:31','2023-11-18','04:27:31'),(1964,186,8,6,'2023-11-18','04:59:31','2023-11-18','04:27:31'),(1965,186,8,11,'2023-11-18','05:10:31','2023-11-18','04:27:31'),(1966,186,10,5,'2023-11-18','04:48:31','2023-11-18','04:38:31'),(1967,186,10,6,'2023-11-18','04:59:31','2023-11-18','04:38:31'),(1968,186,10,11,'2023-11-18','05:10:31','2023-11-18','04:38:31'),(1969,186,5,6,'2023-11-18','04:59:31','2023-11-18','04:48:31'),(1970,186,5,11,'2023-11-18','05:10:31','2023-11-18','04:48:31'),(1971,186,6,11,'2023-11-18','05:10:31','2023-11-18','04:58:31'),(1972,187,2,5,'2023-11-18','12:05:00','2023-11-18','11:55:00'),(1973,187,2,10,'2023-11-18','12:16:00','2023-11-18','11:55:00'),(1974,187,2,8,'2023-11-18','12:27:00','2023-11-18','11:55:00'),(1975,187,5,10,'2023-11-18','12:16:00','2023-11-18','12:06:00'),(1976,187,5,8,'2023-11-18','12:27:00','2023-11-18','12:06:00'),(1977,187,10,8,'2023-11-18','12:27:00','2023-11-18','12:16:00'),(1978,188,8,10,'2023-11-18','04:08:38','2023-11-18','03:58:38'),(1979,188,8,5,'2023-11-18','04:19:38','2023-11-18','03:58:38'),(1980,188,8,1,'2023-11-18','04:30:38','2023-11-18','03:58:38'),(1981,188,8,3,'2023-11-18','04:41:38','2023-11-18','03:58:38'),(1982,188,8,9,'2023-11-18','04:51:38','2023-11-18','03:58:38'),(1983,188,8,4,'2023-11-18','05:01:38','2023-11-18','03:58:38'),(1984,188,10,5,'2023-11-18','04:19:38','2023-11-18','04:09:38'),(1985,188,10,1,'2023-11-18','04:30:38','2023-11-18','04:09:38'),(1986,188,10,3,'2023-11-18','04:41:38','2023-11-18','04:09:38'),(1987,188,10,9,'2023-11-18','04:51:38','2023-11-18','04:09:38'),(1988,188,10,4,'2023-11-18','05:01:38','2023-11-18','04:09:38'),(1989,188,5,1,'2023-11-18','04:30:38','2023-11-18','04:19:38'),(1990,188,5,3,'2023-11-18','04:41:38','2023-11-18','04:19:38'),(1991,188,5,9,'2023-11-18','04:51:38','2023-11-18','04:19:38'),(1992,188,5,4,'2023-11-18','05:01:38','2023-11-18','04:19:38'),(1993,188,1,3,'2023-11-18','04:41:38','2023-11-18','04:29:38'),(1994,188,1,9,'2023-11-18','04:51:38','2023-11-18','04:29:38'),(1995,188,1,4,'2023-11-18','05:01:38','2023-11-18','04:29:38'),(1996,188,3,9,'2023-11-18','04:51:38','2023-11-18','04:39:38'),(1997,188,3,4,'2023-11-18','05:01:38','2023-11-18','04:39:38'),(1998,188,9,4,'2023-11-18','05:01:38','2023-11-18','04:49:38'),(1999,189,8,10,'2023-11-18','07:59:58','2023-11-18','07:49:58'),(2000,189,8,5,'2023-11-18','08:10:58','2023-11-18','07:49:58'),(2001,189,8,1,'2023-11-18','08:21:58','2023-11-18','07:49:58'),(2002,189,10,5,'2023-11-18','08:10:58','2023-11-18','08:00:58'),(2003,189,10,1,'2023-11-18','08:21:58','2023-11-18','08:00:58'),(2004,189,5,1,'2023-11-18','08:21:58','2023-11-18','08:10:58'),(2005,190,3,1,'2023-11-18','05:03:42','2023-11-18','04:53:42'),(2006,190,3,5,'2023-11-18','05:14:42','2023-11-18','04:53:42'),(2007,190,3,10,'2023-11-18','05:25:42','2023-11-18','04:53:42'),(2008,190,3,8,'2023-11-18','05:36:42','2023-11-18','04:53:42'),(2009,190,1,5,'2023-11-18','05:14:42','2023-11-18','05:04:42'),(2010,190,1,10,'2023-11-18','05:25:42','2023-11-18','05:04:42'),(2011,190,1,8,'2023-11-18','05:36:42','2023-11-18','05:04:42'),(2012,190,5,10,'2023-11-18','05:25:42','2023-11-18','05:14:42'),(2013,190,5,8,'2023-11-18','05:36:42','2023-11-18','05:14:42'),(2014,190,10,8,'2023-11-18','05:36:42','2023-11-18','05:24:42'),(2015,191,8,10,'2023-11-19','04:37:31','2023-11-19','04:27:31'),(2016,191,8,5,'2023-11-19','04:48:31','2023-11-19','04:27:31'),(2017,191,8,6,'2023-11-19','04:59:31','2023-11-19','04:27:31'),(2018,191,8,11,'2023-11-19','05:10:31','2023-11-19','04:27:31'),(2019,191,10,5,'2023-11-19','04:48:31','2023-11-19','04:38:31'),(2020,191,10,6,'2023-11-19','04:59:31','2023-11-19','04:38:31'),(2021,191,10,11,'2023-11-19','05:10:31','2023-11-19','04:38:31'),(2022,191,5,6,'2023-11-19','04:59:31','2023-11-19','04:48:31'),(2023,191,5,11,'2023-11-19','05:10:31','2023-11-19','04:48:31'),(2024,191,6,11,'2023-11-19','05:10:31','2023-11-19','04:58:31'),(2025,192,2,5,'2023-11-19','12:05:00','2023-11-19','11:55:00'),(2026,192,2,10,'2023-11-19','12:16:00','2023-11-19','11:55:00'),(2027,192,2,8,'2023-11-19','12:27:00','2023-11-19','11:55:00'),(2028,192,5,10,'2023-11-19','12:16:00','2023-11-19','12:06:00'),(2029,192,5,8,'2023-11-19','12:27:00','2023-11-19','12:06:00'),(2030,192,10,8,'2023-11-19','12:27:00','2023-11-19','12:16:00'),(2031,193,8,10,'2023-11-19','04:08:38','2023-11-19','03:58:38'),(2032,193,8,5,'2023-11-19','04:19:38','2023-11-19','03:58:38'),(2033,193,8,1,'2023-11-19','04:30:38','2023-11-19','03:58:38'),(2034,193,8,3,'2023-11-19','04:41:38','2023-11-19','03:58:38'),(2035,193,8,9,'2023-11-19','04:51:38','2023-11-19','03:58:38'),(2036,193,8,4,'2023-11-19','05:01:38','2023-11-19','03:58:38'),(2037,193,10,5,'2023-11-19','04:19:38','2023-11-19','04:09:38'),(2038,193,10,1,'2023-11-19','04:30:38','2023-11-19','04:09:38'),(2039,193,10,3,'2023-11-19','04:41:38','2023-11-19','04:09:38'),(2040,193,10,9,'2023-11-19','04:51:38','2023-11-19','04:09:38'),(2041,193,10,4,'2023-11-19','05:01:38','2023-11-19','04:09:38'),(2042,193,5,1,'2023-11-19','04:30:38','2023-11-19','04:19:38'),(2043,193,5,3,'2023-11-19','04:41:38','2023-11-19','04:19:38'),(2044,193,5,9,'2023-11-19','04:51:38','2023-11-19','04:19:38'),(2045,193,5,4,'2023-11-19','05:01:38','2023-11-19','04:19:38'),(2046,193,1,3,'2023-11-19','04:41:38','2023-11-19','04:29:38'),(2047,193,1,9,'2023-11-19','04:51:38','2023-11-19','04:29:38'),(2048,193,1,4,'2023-11-19','05:01:38','2023-11-19','04:29:38'),(2049,193,3,9,'2023-11-19','04:51:38','2023-11-19','04:39:38'),(2050,193,3,4,'2023-11-19','05:01:38','2023-11-19','04:39:38'),(2051,193,9,4,'2023-11-19','05:01:38','2023-11-19','04:49:38'),(2052,194,8,10,'2023-11-19','07:59:58','2023-11-19','07:49:58'),(2053,194,8,5,'2023-11-19','08:10:58','2023-11-19','07:49:58'),(2054,194,8,1,'2023-11-19','08:21:58','2023-11-19','07:49:58'),(2055,194,10,5,'2023-11-19','08:10:58','2023-11-19','08:00:58'),(2056,194,10,1,'2023-11-19','08:21:58','2023-11-19','08:00:58'),(2057,194,5,1,'2023-11-19','08:21:58','2023-11-19','08:10:58'),(2058,195,3,1,'2023-11-19','05:03:42','2023-11-19','04:53:42'),(2059,195,3,5,'2023-11-19','05:14:42','2023-11-19','04:53:42'),(2060,195,3,10,'2023-11-19','05:25:42','2023-11-19','04:53:42'),(2061,195,3,8,'2023-11-19','05:36:42','2023-11-19','04:53:42'),(2062,195,1,5,'2023-11-19','05:14:42','2023-11-19','05:04:42'),(2063,195,1,10,'2023-11-19','05:25:42','2023-11-19','05:04:42'),(2064,195,1,8,'2023-11-19','05:36:42','2023-11-19','05:04:42'),(2065,195,5,10,'2023-11-19','05:25:42','2023-11-19','05:14:42'),(2066,195,5,8,'2023-11-19','05:36:42','2023-11-19','05:14:42'),(2067,195,10,8,'2023-11-19','05:36:42','2023-11-19','05:24:42'),(2068,196,8,10,'2023-11-20','04:37:31','2023-11-20','04:27:31'),(2069,196,8,5,'2023-11-20','04:48:31','2023-11-20','04:27:31'),(2070,196,8,6,'2023-11-20','04:59:31','2023-11-20','04:27:31'),(2071,196,8,11,'2023-11-20','05:10:31','2023-11-20','04:27:31'),(2072,196,10,5,'2023-11-20','04:48:31','2023-11-20','04:38:31'),(2073,196,10,6,'2023-11-20','04:59:31','2023-11-20','04:38:31'),(2074,196,10,11,'2023-11-20','05:10:31','2023-11-20','04:38:31'),(2075,196,5,6,'2023-11-20','04:59:31','2023-11-20','04:48:31'),(2076,196,5,11,'2023-11-20','05:10:31','2023-11-20','04:48:31'),(2077,196,6,11,'2023-11-20','05:10:31','2023-11-20','04:58:31'),(2078,197,2,5,'2023-11-20','12:05:00','2023-11-20','11:55:00'),(2079,197,2,10,'2023-11-20','12:16:00','2023-11-20','11:55:00'),(2080,197,2,8,'2023-11-20','12:27:00','2023-11-20','11:55:00'),(2081,197,5,10,'2023-11-20','12:16:00','2023-11-20','12:06:00'),(2082,197,5,8,'2023-11-20','12:27:00','2023-11-20','12:06:00'),(2083,197,10,8,'2023-11-20','12:27:00','2023-11-20','12:16:00'),(2084,198,8,10,'2023-11-20','04:08:38','2023-11-20','03:58:38'),(2085,198,8,5,'2023-11-20','04:19:38','2023-11-20','03:58:38'),(2086,198,8,1,'2023-11-20','04:30:38','2023-11-20','03:58:38'),(2087,198,8,3,'2023-11-20','04:41:38','2023-11-20','03:58:38'),(2088,198,8,9,'2023-11-20','04:51:38','2023-11-20','03:58:38'),(2089,198,8,4,'2023-11-20','05:01:38','2023-11-20','03:58:38'),(2090,198,10,5,'2023-11-20','04:19:38','2023-11-20','04:09:38'),(2091,198,10,1,'2023-11-20','04:30:38','2023-11-20','04:09:38'),(2092,198,10,3,'2023-11-20','04:41:38','2023-11-20','04:09:38'),(2093,198,10,9,'2023-11-20','04:51:38','2023-11-20','04:09:38'),(2094,198,10,4,'2023-11-20','05:01:38','2023-11-20','04:09:38'),(2095,198,5,1,'2023-11-20','04:30:38','2023-11-20','04:19:38'),(2096,198,5,3,'2023-11-20','04:41:38','2023-11-20','04:19:38'),(2097,198,5,9,'2023-11-20','04:51:38','2023-11-20','04:19:38'),(2098,198,5,4,'2023-11-20','05:01:38','2023-11-20','04:19:38'),(2099,198,1,3,'2023-11-20','04:41:38','2023-11-20','04:29:38'),(2100,198,1,9,'2023-11-20','04:51:38','2023-11-20','04:29:38'),(2101,198,1,4,'2023-11-20','05:01:38','2023-11-20','04:29:38'),(2102,198,3,9,'2023-11-20','04:51:38','2023-11-20','04:39:38'),(2103,198,3,4,'2023-11-20','05:01:38','2023-11-20','04:39:38'),(2104,198,9,4,'2023-11-20','05:01:38','2023-11-20','04:49:38'),(2105,199,8,10,'2023-11-20','07:59:58','2023-11-20','07:49:58'),(2106,199,8,5,'2023-11-20','08:10:58','2023-11-20','07:49:58'),(2107,199,8,1,'2023-11-20','08:21:58','2023-11-20','07:49:58'),(2108,199,10,5,'2023-11-20','08:10:58','2023-11-20','08:00:58'),(2109,199,10,1,'2023-11-20','08:21:58','2023-11-20','08:00:58'),(2110,199,5,1,'2023-11-20','08:21:58','2023-11-20','08:10:58'),(2111,200,3,1,'2023-11-20','05:03:42','2023-11-20','04:53:42'),(2112,200,3,5,'2023-11-20','05:14:42','2023-11-20','04:53:42'),(2113,200,3,10,'2023-11-20','05:25:42','2023-11-20','04:53:42'),(2114,200,3,8,'2023-11-20','05:36:42','2023-11-20','04:53:42'),(2115,200,1,5,'2023-11-20','05:14:42','2023-11-20','05:04:42'),(2116,200,1,10,'2023-11-20','05:25:42','2023-11-20','05:04:42'),(2117,200,1,8,'2023-11-20','05:36:42','2023-11-20','05:04:42'),(2118,200,5,10,'2023-11-20','05:25:42','2023-11-20','05:14:42'),(2119,200,5,8,'2023-11-20','05:36:42','2023-11-20','05:14:42'),(2120,200,10,8,'2023-11-20','05:36:42','2023-11-20','05:24:42'),(2121,201,8,10,'2023-11-21','04:37:31','2023-11-21','04:27:31'),(2122,201,8,5,'2023-11-21','04:48:31','2023-11-21','04:27:31'),(2123,201,8,6,'2023-11-21','04:59:31','2023-11-21','04:27:31'),(2124,201,8,11,'2023-11-21','05:10:31','2023-11-21','04:27:31'),(2125,201,10,5,'2023-11-21','04:48:31','2023-11-21','04:38:31'),(2126,201,10,6,'2023-11-21','04:59:31','2023-11-21','04:38:31'),(2127,201,10,11,'2023-11-21','05:10:31','2023-11-21','04:38:31'),(2128,201,5,6,'2023-11-21','04:59:31','2023-11-21','04:48:31'),(2129,201,5,11,'2023-11-21','05:10:31','2023-11-21','04:48:31'),(2130,201,6,11,'2023-11-21','05:10:31','2023-11-21','04:58:31'),(2131,202,2,5,'2023-11-21','12:05:00','2023-11-21','11:55:00'),(2132,202,2,10,'2023-11-21','12:16:00','2023-11-21','11:55:00'),(2133,202,2,8,'2023-11-21','12:27:00','2023-11-21','11:55:00'),(2134,202,5,10,'2023-11-21','12:16:00','2023-11-21','12:06:00'),(2135,202,5,8,'2023-11-21','12:27:00','2023-11-21','12:06:00'),(2136,202,10,8,'2023-11-21','12:27:00','2023-11-21','12:16:00'),(2137,203,8,10,'2023-11-21','04:08:38','2023-11-21','03:58:38'),(2138,203,8,5,'2023-11-21','04:19:38','2023-11-21','03:58:38'),(2139,203,8,1,'2023-11-21','04:30:38','2023-11-21','03:58:38'),(2140,203,8,3,'2023-11-21','04:41:38','2023-11-21','03:58:38'),(2141,203,8,9,'2023-11-21','04:51:38','2023-11-21','03:58:38'),(2142,203,8,4,'2023-11-21','05:01:38','2023-11-21','03:58:38'),(2143,203,10,5,'2023-11-21','04:19:38','2023-11-21','04:09:38'),(2144,203,10,1,'2023-11-21','04:30:38','2023-11-21','04:09:38'),(2145,203,10,3,'2023-11-21','04:41:38','2023-11-21','04:09:38'),(2146,203,10,9,'2023-11-21','04:51:38','2023-11-21','04:09:38'),(2147,203,10,4,'2023-11-21','05:01:38','2023-11-21','04:09:38'),(2148,203,5,1,'2023-11-21','04:30:38','2023-11-21','04:19:38'),(2149,203,5,3,'2023-11-21','04:41:38','2023-11-21','04:19:38'),(2150,203,5,9,'2023-11-21','04:51:38','2023-11-21','04:19:38'),(2151,203,5,4,'2023-11-21','05:01:38','2023-11-21','04:19:38'),(2152,203,1,3,'2023-11-21','04:41:38','2023-11-21','04:29:38'),(2153,203,1,9,'2023-11-21','04:51:38','2023-11-21','04:29:38'),(2154,203,1,4,'2023-11-21','05:01:38','2023-11-21','04:29:38'),(2155,203,3,9,'2023-11-21','04:51:38','2023-11-21','04:39:38'),(2156,203,3,4,'2023-11-21','05:01:38','2023-11-21','04:39:38'),(2157,203,9,4,'2023-11-21','05:01:38','2023-11-21','04:49:38'),(2158,204,8,10,'2023-11-21','07:59:58','2023-11-21','07:49:58'),(2159,204,8,5,'2023-11-21','08:10:58','2023-11-21','07:49:58'),(2160,204,8,1,'2023-11-21','08:21:58','2023-11-21','07:49:58'),(2161,204,10,5,'2023-11-21','08:10:58','2023-11-21','08:00:58'),(2162,204,10,1,'2023-11-21','08:21:58','2023-11-21','08:00:58'),(2163,204,5,1,'2023-11-21','08:21:58','2023-11-21','08:10:58'),(2164,205,3,1,'2023-11-21','05:03:42','2023-11-21','04:53:42'),(2165,205,3,5,'2023-11-21','05:14:42','2023-11-21','04:53:42'),(2166,205,3,10,'2023-11-21','05:25:42','2023-11-21','04:53:42'),(2167,205,3,8,'2023-11-21','05:36:42','2023-11-21','04:53:42'),(2168,205,1,5,'2023-11-21','05:14:42','2023-11-21','05:04:42'),(2169,205,1,10,'2023-11-21','05:25:42','2023-11-21','05:04:42'),(2170,205,1,8,'2023-11-21','05:36:42','2023-11-21','05:04:42'),(2171,205,5,10,'2023-11-21','05:25:42','2023-11-21','05:14:42'),(2172,205,5,8,'2023-11-21','05:36:42','2023-11-21','05:14:42'),(2173,205,10,8,'2023-11-21','05:36:42','2023-11-21','05:24:42'),(2174,206,8,10,'2023-11-22','04:37:31','2023-11-22','04:27:31'),(2175,206,8,5,'2023-11-22','04:48:31','2023-11-22','04:27:31'),(2176,206,8,6,'2023-11-22','04:59:31','2023-11-22','04:27:31'),(2177,206,8,11,'2023-11-22','05:10:31','2023-11-22','04:27:31'),(2178,206,10,5,'2023-11-22','04:48:31','2023-11-22','04:38:31'),(2179,206,10,6,'2023-11-22','04:59:31','2023-11-22','04:38:31'),(2180,206,10,11,'2023-11-22','05:10:31','2023-11-22','04:38:31'),(2181,206,5,6,'2023-11-22','04:59:31','2023-11-22','04:48:31'),(2182,206,5,11,'2023-11-22','05:10:31','2023-11-22','04:48:31'),(2183,206,6,11,'2023-11-22','05:10:31','2023-11-22','04:58:31'),(2184,207,2,5,'2023-11-22','12:05:00','2023-11-22','11:55:00'),(2185,207,2,10,'2023-11-22','12:16:00','2023-11-22','11:55:00'),(2186,207,2,8,'2023-11-22','12:27:00','2023-11-22','11:55:00'),(2187,207,5,10,'2023-11-22','12:16:00','2023-11-22','12:06:00'),(2188,207,5,8,'2023-11-22','12:27:00','2023-11-22','12:06:00'),(2189,207,10,8,'2023-11-22','12:27:00','2023-11-22','12:16:00'),(2190,208,8,10,'2023-11-22','04:08:38','2023-11-22','03:58:38'),(2191,208,8,5,'2023-11-22','04:19:38','2023-11-22','03:58:38'),(2192,208,8,1,'2023-11-22','04:30:38','2023-11-22','03:58:38'),(2193,208,8,3,'2023-11-22','04:41:38','2023-11-22','03:58:38'),(2194,208,8,9,'2023-11-22','04:51:38','2023-11-22','03:58:38'),(2195,208,8,4,'2023-11-22','05:01:38','2023-11-22','03:58:38'),(2196,208,10,5,'2023-11-22','04:19:38','2023-11-22','04:09:38'),(2197,208,10,1,'2023-11-22','04:30:38','2023-11-22','04:09:38'),(2198,208,10,3,'2023-11-22','04:41:38','2023-11-22','04:09:38'),(2199,208,10,9,'2023-11-22','04:51:38','2023-11-22','04:09:38'),(2200,208,10,4,'2023-11-22','05:01:38','2023-11-22','04:09:38'),(2201,208,5,1,'2023-11-22','04:30:38','2023-11-22','04:19:38'),(2202,208,5,3,'2023-11-22','04:41:38','2023-11-22','04:19:38'),(2203,208,5,9,'2023-11-22','04:51:38','2023-11-22','04:19:38'),(2204,208,5,4,'2023-11-22','05:01:38','2023-11-22','04:19:38'),(2205,208,1,3,'2023-11-22','04:41:38','2023-11-22','04:29:38'),(2206,208,1,9,'2023-11-22','04:51:38','2023-11-22','04:29:38'),(2207,208,1,4,'2023-11-22','05:01:38','2023-11-22','04:29:38'),(2208,208,3,9,'2023-11-22','04:51:38','2023-11-22','04:39:38'),(2209,208,3,4,'2023-11-22','05:01:38','2023-11-22','04:39:38'),(2210,208,9,4,'2023-11-22','05:01:38','2023-11-22','04:49:38'),(2211,209,8,10,'2023-11-22','07:59:58','2023-11-22','07:49:58'),(2212,209,8,5,'2023-11-22','08:10:58','2023-11-22','07:49:58'),(2213,209,8,1,'2023-11-22','08:21:58','2023-11-22','07:49:58'),(2214,209,10,5,'2023-11-22','08:10:58','2023-11-22','08:00:58'),(2215,209,10,1,'2023-11-22','08:21:58','2023-11-22','08:00:58'),(2216,209,5,1,'2023-11-22','08:21:58','2023-11-22','08:10:58'),(2217,210,3,1,'2023-11-22','05:03:42','2023-11-22','04:53:42'),(2218,210,3,5,'2023-11-22','05:14:42','2023-11-22','04:53:42'),(2219,210,3,10,'2023-11-22','05:25:42','2023-11-22','04:53:42'),(2220,210,3,8,'2023-11-22','05:36:42','2023-11-22','04:53:42'),(2221,210,1,5,'2023-11-22','05:14:42','2023-11-22','05:04:42'),(2222,210,1,10,'2023-11-22','05:25:42','2023-11-22','05:04:42'),(2223,210,1,8,'2023-11-22','05:36:42','2023-11-22','05:04:42'),(2224,210,5,10,'2023-11-22','05:25:42','2023-11-22','05:14:42'),(2225,210,5,8,'2023-11-22','05:36:42','2023-11-22','05:14:42'),(2226,210,10,8,'2023-11-22','05:36:42','2023-11-22','05:24:42'),(2227,211,8,10,'2023-11-23','04:37:31','2023-11-23','04:27:31'),(2228,211,8,5,'2023-11-23','04:48:31','2023-11-23','04:27:31'),(2229,211,8,6,'2023-11-23','04:59:31','2023-11-23','04:27:31'),(2230,211,8,11,'2023-11-23','05:10:31','2023-11-23','04:27:31'),(2231,211,10,5,'2023-11-23','04:48:31','2023-11-23','04:38:31'),(2232,211,10,6,'2023-11-23','04:59:31','2023-11-23','04:38:31'),(2233,211,10,11,'2023-11-23','05:10:31','2023-11-23','04:38:31'),(2234,211,5,6,'2023-11-23','04:59:31','2023-11-23','04:48:31'),(2235,211,5,11,'2023-11-23','05:10:31','2023-11-23','04:48:31'),(2236,211,6,11,'2023-11-23','05:10:31','2023-11-23','04:58:31'),(2237,212,2,5,'2023-11-23','12:05:00','2023-11-23','11:55:00'),(2238,212,2,10,'2023-11-23','12:16:00','2023-11-23','11:55:00'),(2239,212,2,8,'2023-11-23','12:27:00','2023-11-23','11:55:00'),(2240,212,5,10,'2023-11-23','12:16:00','2023-11-23','12:06:00'),(2241,212,5,8,'2023-11-23','12:27:00','2023-11-23','12:06:00'),(2242,212,10,8,'2023-11-23','12:27:00','2023-11-23','12:16:00'),(2243,213,8,10,'2023-11-23','04:08:38','2023-11-23','03:58:38'),(2244,213,8,5,'2023-11-23','04:19:38','2023-11-23','03:58:38'),(2245,213,8,1,'2023-11-23','04:30:38','2023-11-23','03:58:38'),(2246,213,8,3,'2023-11-23','04:41:38','2023-11-23','03:58:38'),(2247,213,8,9,'2023-11-23','04:51:38','2023-11-23','03:58:38'),(2248,213,8,4,'2023-11-23','05:01:38','2023-11-23','03:58:38'),(2249,213,10,5,'2023-11-23','04:19:38','2023-11-23','04:09:38'),(2250,213,10,1,'2023-11-23','04:30:38','2023-11-23','04:09:38'),(2251,213,10,3,'2023-11-23','04:41:38','2023-11-23','04:09:38'),(2252,213,10,9,'2023-11-23','04:51:38','2023-11-23','04:09:38'),(2253,213,10,4,'2023-11-23','05:01:38','2023-11-23','04:09:38'),(2254,213,5,1,'2023-11-23','04:30:38','2023-11-23','04:19:38'),(2255,213,5,3,'2023-11-23','04:41:38','2023-11-23','04:19:38'),(2256,213,5,9,'2023-11-23','04:51:38','2023-11-23','04:19:38'),(2257,213,5,4,'2023-11-23','05:01:38','2023-11-23','04:19:38'),(2258,213,1,3,'2023-11-23','04:41:38','2023-11-23','04:29:38'),(2259,213,1,9,'2023-11-23','04:51:38','2023-11-23','04:29:38'),(2260,213,1,4,'2023-11-23','05:01:38','2023-11-23','04:29:38'),(2261,213,3,9,'2023-11-23','04:51:38','2023-11-23','04:39:38'),(2262,213,3,4,'2023-11-23','05:01:38','2023-11-23','04:39:38'),(2263,213,9,4,'2023-11-23','05:01:38','2023-11-23','04:49:38'),(2264,214,8,10,'2023-11-23','07:59:58','2023-11-23','07:49:58'),(2265,214,8,5,'2023-11-23','08:10:58','2023-11-23','07:49:58'),(2266,214,8,1,'2023-11-23','08:21:58','2023-11-23','07:49:58'),(2267,214,10,5,'2023-11-23','08:10:58','2023-11-23','08:00:58'),(2268,214,10,1,'2023-11-23','08:21:58','2023-11-23','08:00:58'),(2269,214,5,1,'2023-11-23','08:21:58','2023-11-23','08:10:58'),(2270,215,3,1,'2023-11-23','05:03:42','2023-11-23','04:53:42'),(2271,215,3,5,'2023-11-23','05:14:42','2023-11-23','04:53:42'),(2272,215,3,10,'2023-11-23','05:25:42','2023-11-23','04:53:42'),(2273,215,3,8,'2023-11-23','05:36:42','2023-11-23','04:53:42'),(2274,215,1,5,'2023-11-23','05:14:42','2023-11-23','05:04:42'),(2275,215,1,10,'2023-11-23','05:25:42','2023-11-23','05:04:42'),(2276,215,1,8,'2023-11-23','05:36:42','2023-11-23','05:04:42'),(2277,215,5,10,'2023-11-23','05:25:42','2023-11-23','05:14:42'),(2278,215,5,8,'2023-11-23','05:36:42','2023-11-23','05:14:42'),(2279,215,10,8,'2023-11-23','05:36:42','2023-11-23','05:24:42'),(2280,216,8,10,'2023-11-24','04:37:31','2023-11-24','04:27:31'),(2281,216,8,5,'2023-11-24','04:48:31','2023-11-24','04:27:31'),(2282,216,8,6,'2023-11-24','04:59:31','2023-11-24','04:27:31'),(2283,216,8,11,'2023-11-24','05:10:31','2023-11-24','04:27:31'),(2284,216,10,5,'2023-11-24','04:48:31','2023-11-24','04:38:31'),(2285,216,10,6,'2023-11-24','04:59:31','2023-11-24','04:38:31'),(2286,216,10,11,'2023-11-24','05:10:31','2023-11-24','04:38:31'),(2287,216,5,6,'2023-11-24','04:59:31','2023-11-24','04:48:31'),(2288,216,5,11,'2023-11-24','05:10:31','2023-11-24','04:48:31'),(2289,216,6,11,'2023-11-24','05:10:31','2023-11-24','04:58:31'),(2290,217,2,5,'2023-11-24','12:05:00','2023-11-24','11:55:00'),(2291,217,2,10,'2023-11-24','12:16:00','2023-11-24','11:55:00'),(2292,217,2,8,'2023-11-24','12:27:00','2023-11-24','11:55:00'),(2293,217,5,10,'2023-11-24','12:16:00','2023-11-24','12:06:00'),(2294,217,5,8,'2023-11-24','12:27:00','2023-11-24','12:06:00'),(2295,217,10,8,'2023-11-24','12:27:00','2023-11-24','12:16:00'),(2296,218,8,10,'2023-11-24','04:08:38','2023-11-24','03:58:38'),(2297,218,8,5,'2023-11-24','04:19:38','2023-11-24','03:58:38'),(2298,218,8,1,'2023-11-24','04:30:38','2023-11-24','03:58:38'),(2299,218,8,3,'2023-11-24','04:41:38','2023-11-24','03:58:38'),(2300,218,8,9,'2023-11-24','04:51:38','2023-11-24','03:58:38'),(2301,218,8,4,'2023-11-24','05:01:38','2023-11-24','03:58:38'),(2302,218,10,5,'2023-11-24','04:19:38','2023-11-24','04:09:38'),(2303,218,10,1,'2023-11-24','04:30:38','2023-11-24','04:09:38'),(2304,218,10,3,'2023-11-24','04:41:38','2023-11-24','04:09:38'),(2305,218,10,9,'2023-11-24','04:51:38','2023-11-24','04:09:38'),(2306,218,10,4,'2023-11-24','05:01:38','2023-11-24','04:09:38'),(2307,218,5,1,'2023-11-24','04:30:38','2023-11-24','04:19:38'),(2308,218,5,3,'2023-11-24','04:41:38','2023-11-24','04:19:38'),(2309,218,5,9,'2023-11-24','04:51:38','2023-11-24','04:19:38'),(2310,218,5,4,'2023-11-24','05:01:38','2023-11-24','04:19:38'),(2311,218,1,3,'2023-11-24','04:41:38','2023-11-24','04:29:38'),(2312,218,1,9,'2023-11-24','04:51:38','2023-11-24','04:29:38'),(2313,218,1,4,'2023-11-24','05:01:38','2023-11-24','04:29:38'),(2314,218,3,9,'2023-11-24','04:51:38','2023-11-24','04:39:38'),(2315,218,3,4,'2023-11-24','05:01:38','2023-11-24','04:39:38'),(2316,218,9,4,'2023-11-24','05:01:38','2023-11-24','04:49:38'),(2317,219,8,10,'2023-11-24','07:59:58','2023-11-24','07:49:58'),(2318,219,8,5,'2023-11-24','08:10:58','2023-11-24','07:49:58'),(2319,219,8,1,'2023-11-24','08:21:58','2023-11-24','07:49:58'),(2320,219,10,5,'2023-11-24','08:10:58','2023-11-24','08:00:58'),(2321,219,10,1,'2023-11-24','08:21:58','2023-11-24','08:00:58'),(2322,219,5,1,'2023-11-24','08:21:58','2023-11-24','08:10:58'),(2323,220,3,1,'2023-11-24','05:03:42','2023-11-24','04:53:42'),(2324,220,3,5,'2023-11-24','05:14:42','2023-11-24','04:53:42'),(2325,220,3,10,'2023-11-24','05:25:42','2023-11-24','04:53:42'),(2326,220,3,8,'2023-11-24','05:36:42','2023-11-24','04:53:42'),(2327,220,1,5,'2023-11-24','05:14:42','2023-11-24','05:04:42'),(2328,220,1,10,'2023-11-24','05:25:42','2023-11-24','05:04:42'),(2329,220,1,8,'2023-11-24','05:36:42','2023-11-24','05:04:42'),(2330,220,5,10,'2023-11-24','05:25:42','2023-11-24','05:14:42'),(2331,220,5,8,'2023-11-24','05:36:42','2023-11-24','05:14:42'),(2332,220,10,8,'2023-11-24','05:36:42','2023-11-24','05:24:42'),(2333,221,8,10,'2023-11-25','04:37:31','2023-11-25','04:27:31'),(2334,221,8,5,'2023-11-25','04:48:31','2023-11-25','04:27:31'),(2335,221,8,6,'2023-11-25','04:59:31','2023-11-25','04:27:31'),(2336,221,8,11,'2023-11-25','05:10:31','2023-11-25','04:27:31'),(2337,221,10,5,'2023-11-25','04:48:31','2023-11-25','04:38:31'),(2338,221,10,6,'2023-11-25','04:59:31','2023-11-25','04:38:31'),(2339,221,10,11,'2023-11-25','05:10:31','2023-11-25','04:38:31'),(2340,221,5,6,'2023-11-25','04:59:31','2023-11-25','04:48:31'),(2341,221,5,11,'2023-11-25','05:10:31','2023-11-25','04:48:31'),(2342,221,6,11,'2023-11-25','05:10:31','2023-11-25','04:58:31'),(2343,222,2,5,'2023-11-25','12:05:00','2023-11-25','11:55:00'),(2344,222,2,10,'2023-11-25','12:16:00','2023-11-25','11:55:00'),(2345,222,2,8,'2023-11-25','12:27:00','2023-11-25','11:55:00'),(2346,222,5,10,'2023-11-25','12:16:00','2023-11-25','12:06:00'),(2347,222,5,8,'2023-11-25','12:27:00','2023-11-25','12:06:00'),(2348,222,10,8,'2023-11-25','12:27:00','2023-11-25','12:16:00'),(2349,223,8,10,'2023-11-25','04:08:38','2023-11-25','03:58:38'),(2350,223,8,5,'2023-11-25','04:19:38','2023-11-25','03:58:38'),(2351,223,8,1,'2023-11-25','04:30:38','2023-11-25','03:58:38'),(2352,223,8,3,'2023-11-25','04:41:38','2023-11-25','03:58:38'),(2353,223,8,9,'2023-11-25','04:51:38','2023-11-25','03:58:38'),(2354,223,8,4,'2023-11-25','05:01:38','2023-11-25','03:58:38'),(2355,223,10,5,'2023-11-25','04:19:38','2023-11-25','04:09:38'),(2356,223,10,1,'2023-11-25','04:30:38','2023-11-25','04:09:38'),(2357,223,10,3,'2023-11-25','04:41:38','2023-11-25','04:09:38'),(2358,223,10,9,'2023-11-25','04:51:38','2023-11-25','04:09:38'),(2359,223,10,4,'2023-11-25','05:01:38','2023-11-25','04:09:38'),(2360,223,5,1,'2023-11-25','04:30:38','2023-11-25','04:19:38'),(2361,223,5,3,'2023-11-25','04:41:38','2023-11-25','04:19:38'),(2362,223,5,9,'2023-11-25','04:51:38','2023-11-25','04:19:38'),(2363,223,5,4,'2023-11-25','05:01:38','2023-11-25','04:19:38'),(2364,223,1,3,'2023-11-25','04:41:38','2023-11-25','04:29:38'),(2365,223,1,9,'2023-11-25','04:51:38','2023-11-25','04:29:38'),(2366,223,1,4,'2023-11-25','05:01:38','2023-11-25','04:29:38'),(2367,223,3,9,'2023-11-25','04:51:38','2023-11-25','04:39:38'),(2368,223,3,4,'2023-11-25','05:01:38','2023-11-25','04:39:38'),(2369,223,9,4,'2023-11-25','05:01:38','2023-11-25','04:49:38'),(2370,224,8,10,'2023-11-25','07:59:58','2023-11-25','07:49:58'),(2371,224,8,5,'2023-11-25','08:10:58','2023-11-25','07:49:58'),(2372,224,8,1,'2023-11-25','08:21:58','2023-11-25','07:49:58'),(2373,224,10,5,'2023-11-25','08:10:58','2023-11-25','08:00:58'),(2374,224,10,1,'2023-11-25','08:21:58','2023-11-25','08:00:58'),(2375,224,5,1,'2023-11-25','08:21:58','2023-11-25','08:10:58'),(2376,225,3,1,'2023-11-25','05:03:42','2023-11-25','04:53:42'),(2377,225,3,5,'2023-11-25','05:14:42','2023-11-25','04:53:42'),(2378,225,3,10,'2023-11-25','05:25:42','2023-11-25','04:53:42'),(2379,225,3,8,'2023-11-25','05:36:42','2023-11-25','04:53:42'),(2380,225,1,5,'2023-11-25','05:14:42','2023-11-25','05:04:42'),(2381,225,1,10,'2023-11-25','05:25:42','2023-11-25','05:04:42'),(2382,225,1,8,'2023-11-25','05:36:42','2023-11-25','05:04:42'),(2383,225,5,10,'2023-11-25','05:25:42','2023-11-25','05:14:42'),(2384,225,5,8,'2023-11-25','05:36:42','2023-11-25','05:14:42'),(2385,225,10,8,'2023-11-25','05:36:42','2023-11-25','05:24:42'),(2386,226,8,10,'2023-11-26','04:37:31','2023-11-26','04:27:31'),(2387,226,8,5,'2023-11-26','04:48:31','2023-11-26','04:27:31'),(2388,226,8,6,'2023-11-26','04:59:31','2023-11-26','04:27:31'),(2389,226,8,11,'2023-11-26','05:10:31','2023-11-26','04:27:31'),(2390,226,10,5,'2023-11-26','04:48:31','2023-11-26','04:38:31'),(2391,226,10,6,'2023-11-26','04:59:31','2023-11-26','04:38:31'),(2392,226,10,11,'2023-11-26','05:10:31','2023-11-26','04:38:31'),(2393,226,5,6,'2023-11-26','04:59:31','2023-11-26','04:48:31'),(2394,226,5,11,'2023-11-26','05:10:31','2023-11-26','04:48:31'),(2395,226,6,11,'2023-11-26','05:10:31','2023-11-26','04:58:31'),(2396,227,2,5,'2023-11-26','12:05:00','2023-11-26','11:55:00'),(2397,227,2,10,'2023-11-26','12:16:00','2023-11-26','11:55:00'),(2398,227,2,8,'2023-11-26','12:27:00','2023-11-26','11:55:00'),(2399,227,5,10,'2023-11-26','12:16:00','2023-11-26','12:06:00'),(2400,227,5,8,'2023-11-26','12:27:00','2023-11-26','12:06:00'),(2401,227,10,8,'2023-11-26','12:27:00','2023-11-26','12:16:00'),(2402,228,8,10,'2023-11-26','04:08:38','2023-11-26','03:58:38'),(2403,228,8,5,'2023-11-26','04:19:38','2023-11-26','03:58:38'),(2404,228,8,1,'2023-11-26','04:30:38','2023-11-26','03:58:38'),(2405,228,8,3,'2023-11-26','04:41:38','2023-11-26','03:58:38'),(2406,228,8,9,'2023-11-26','04:51:38','2023-11-26','03:58:38'),(2407,228,8,4,'2023-11-26','05:01:38','2023-11-26','03:58:38'),(2408,228,10,5,'2023-11-26','04:19:38','2023-11-26','04:09:38'),(2409,228,10,1,'2023-11-26','04:30:38','2023-11-26','04:09:38'),(2410,228,10,3,'2023-11-26','04:41:38','2023-11-26','04:09:38'),(2411,228,10,9,'2023-11-26','04:51:38','2023-11-26','04:09:38'),(2412,228,10,4,'2023-11-26','05:01:38','2023-11-26','04:09:38'),(2413,228,5,1,'2023-11-26','04:30:38','2023-11-26','04:19:38'),(2414,228,5,3,'2023-11-26','04:41:38','2023-11-26','04:19:38'),(2415,228,5,9,'2023-11-26','04:51:38','2023-11-26','04:19:38'),(2416,228,5,4,'2023-11-26','05:01:38','2023-11-26','04:19:38'),(2417,228,1,3,'2023-11-26','04:41:38','2023-11-26','04:29:38'),(2418,228,1,9,'2023-11-26','04:51:38','2023-11-26','04:29:38'),(2419,228,1,4,'2023-11-26','05:01:38','2023-11-26','04:29:38'),(2420,228,3,9,'2023-11-26','04:51:38','2023-11-26','04:39:38'),(2421,228,3,4,'2023-11-26','05:01:38','2023-11-26','04:39:38'),(2422,228,9,4,'2023-11-26','05:01:38','2023-11-26','04:49:38'),(2423,229,8,10,'2023-11-26','07:59:58','2023-11-26','07:49:58'),(2424,229,8,5,'2023-11-26','08:10:58','2023-11-26','07:49:58'),(2425,229,8,1,'2023-11-26','08:21:58','2023-11-26','07:49:58'),(2426,229,10,5,'2023-11-26','08:10:58','2023-11-26','08:00:58'),(2427,229,10,1,'2023-11-26','08:21:58','2023-11-26','08:00:58'),(2428,229,5,1,'2023-11-26','08:21:58','2023-11-26','08:10:58'),(2429,230,3,1,'2023-11-26','05:03:42','2023-11-26','04:53:42'),(2430,230,3,5,'2023-11-26','05:14:42','2023-11-26','04:53:42'),(2431,230,3,10,'2023-11-26','05:25:42','2023-11-26','04:53:42'),(2432,230,3,8,'2023-11-26','05:36:42','2023-11-26','04:53:42'),(2433,230,1,5,'2023-11-26','05:14:42','2023-11-26','05:04:42'),(2434,230,1,10,'2023-11-26','05:25:42','2023-11-26','05:04:42'),(2435,230,1,8,'2023-11-26','05:36:42','2023-11-26','05:04:42'),(2436,230,5,10,'2023-11-26','05:25:42','2023-11-26','05:14:42'),(2437,230,5,8,'2023-11-26','05:36:42','2023-11-26','05:14:42'),(2438,230,10,8,'2023-11-26','05:36:42','2023-11-26','05:24:42'),(2439,231,8,10,'2023-11-27','04:37:31','2023-11-27','04:27:31'),(2440,231,8,5,'2023-11-27','04:48:31','2023-11-27','04:27:31'),(2441,231,8,6,'2023-11-27','04:59:31','2023-11-27','04:27:31'),(2442,231,8,11,'2023-11-27','05:10:31','2023-11-27','04:27:31'),(2443,231,10,5,'2023-11-27','04:48:31','2023-11-27','04:38:31'),(2444,231,10,6,'2023-11-27','04:59:31','2023-11-27','04:38:31'),(2445,231,10,11,'2023-11-27','05:10:31','2023-11-27','04:38:31'),(2446,231,5,6,'2023-11-27','04:59:31','2023-11-27','04:48:31'),(2447,231,5,11,'2023-11-27','05:10:31','2023-11-27','04:48:31'),(2448,231,6,11,'2023-11-27','05:10:31','2023-11-27','04:58:31'),(2449,232,2,5,'2023-11-27','12:05:00','2023-11-27','11:55:00'),(2450,232,2,10,'2023-11-27','12:16:00','2023-11-27','11:55:00'),(2451,232,2,8,'2023-11-27','12:27:00','2023-11-27','11:55:00'),(2452,232,5,10,'2023-11-27','12:16:00','2023-11-27','12:06:00'),(2453,232,5,8,'2023-11-27','12:27:00','2023-11-27','12:06:00'),(2454,232,10,8,'2023-11-27','12:27:00','2023-11-27','12:16:00'),(2455,233,8,10,'2023-11-27','04:08:38','2023-11-27','03:58:38'),(2456,233,8,5,'2023-11-27','04:19:38','2023-11-27','03:58:38'),(2457,233,8,1,'2023-11-27','04:30:38','2023-11-27','03:58:38'),(2458,233,8,3,'2023-11-27','04:41:38','2023-11-27','03:58:38'),(2459,233,8,9,'2023-11-27','04:51:38','2023-11-27','03:58:38'),(2460,233,8,4,'2023-11-27','05:01:38','2023-11-27','03:58:38'),(2461,233,10,5,'2023-11-27','04:19:38','2023-11-27','04:09:38'),(2462,233,10,1,'2023-11-27','04:30:38','2023-11-27','04:09:38'),(2463,233,10,3,'2023-11-27','04:41:38','2023-11-27','04:09:38'),(2464,233,10,9,'2023-11-27','04:51:38','2023-11-27','04:09:38'),(2465,233,10,4,'2023-11-27','05:01:38','2023-11-27','04:09:38'),(2466,233,5,1,'2023-11-27','04:30:38','2023-11-27','04:19:38'),(2467,233,5,3,'2023-11-27','04:41:38','2023-11-27','04:19:38'),(2468,233,5,9,'2023-11-27','04:51:38','2023-11-27','04:19:38'),(2469,233,5,4,'2023-11-27','05:01:38','2023-11-27','04:19:38'),(2470,233,1,3,'2023-11-27','04:41:38','2023-11-27','04:29:38'),(2471,233,1,9,'2023-11-27','04:51:38','2023-11-27','04:29:38'),(2472,233,1,4,'2023-11-27','05:01:38','2023-11-27','04:29:38'),(2473,233,3,9,'2023-11-27','04:51:38','2023-11-27','04:39:38'),(2474,233,3,4,'2023-11-27','05:01:38','2023-11-27','04:39:38'),(2475,233,9,4,'2023-11-27','05:01:38','2023-11-27','04:49:38'),(2476,234,8,10,'2023-11-27','07:59:58','2023-11-27','07:49:58'),(2477,234,8,5,'2023-11-27','08:10:58','2023-11-27','07:49:58'),(2478,234,8,1,'2023-11-27','08:21:58','2023-11-27','07:49:58'),(2479,234,10,5,'2023-11-27','08:10:58','2023-11-27','08:00:58'),(2480,234,10,1,'2023-11-27','08:21:58','2023-11-27','08:00:58'),(2481,234,5,1,'2023-11-27','08:21:58','2023-11-27','08:10:58'),(2482,235,3,1,'2023-11-27','05:03:42','2023-11-27','04:53:42'),(2483,235,3,5,'2023-11-27','05:14:42','2023-11-27','04:53:42'),(2484,235,3,10,'2023-11-27','05:25:42','2023-11-27','04:53:42'),(2485,235,3,8,'2023-11-27','05:36:42','2023-11-27','04:53:42'),(2486,235,1,5,'2023-11-27','05:14:42','2023-11-27','05:04:42'),(2487,235,1,10,'2023-11-27','05:25:42','2023-11-27','05:04:42'),(2488,235,1,8,'2023-11-27','05:36:42','2023-11-27','05:04:42'),(2489,235,5,10,'2023-11-27','05:25:42','2023-11-27','05:14:42'),(2490,235,5,8,'2023-11-27','05:36:42','2023-11-27','05:14:42'),(2491,235,10,8,'2023-11-27','05:36:42','2023-11-27','05:24:42'),(2492,236,8,10,'2023-11-28','04:37:31','2023-11-28','04:27:31'),(2493,236,8,5,'2023-11-28','04:48:31','2023-11-28','04:27:31'),(2494,236,8,6,'2023-11-28','04:59:31','2023-11-28','04:27:31'),(2495,236,8,11,'2023-11-28','05:10:31','2023-11-28','04:27:31'),(2496,236,10,5,'2023-11-28','04:48:31','2023-11-28','04:38:31'),(2497,236,10,6,'2023-11-28','04:59:31','2023-11-28','04:38:31'),(2498,236,10,11,'2023-11-28','05:10:31','2023-11-28','04:38:31'),(2499,236,5,6,'2023-11-28','04:59:31','2023-11-28','04:48:31'),(2500,236,5,11,'2023-11-28','05:10:31','2023-11-28','04:48:31'),(2501,236,6,11,'2023-11-28','05:10:31','2023-11-28','04:58:31'),(2502,237,2,5,'2023-11-28','12:05:00','2023-11-28','11:55:00'),(2503,237,2,10,'2023-11-28','12:16:00','2023-11-28','11:55:00'),(2504,237,2,8,'2023-11-28','12:27:00','2023-11-28','11:55:00'),(2505,237,5,10,'2023-11-28','12:16:00','2023-11-28','12:06:00'),(2506,237,5,8,'2023-11-28','12:27:00','2023-11-28','12:06:00'),(2507,237,10,8,'2023-11-28','12:27:00','2023-11-28','12:16:00'),(2508,238,8,10,'2023-11-28','04:08:38','2023-11-28','03:58:38'),(2509,238,8,5,'2023-11-28','04:19:38','2023-11-28','03:58:38'),(2510,238,8,1,'2023-11-28','04:30:38','2023-11-28','03:58:38'),(2511,238,8,3,'2023-11-28','04:41:38','2023-11-28','03:58:38'),(2512,238,8,9,'2023-11-28','04:51:38','2023-11-28','03:58:38'),(2513,238,8,4,'2023-11-28','05:01:38','2023-11-28','03:58:38'),(2514,238,10,5,'2023-11-28','04:19:38','2023-11-28','04:09:38'),(2515,238,10,1,'2023-11-28','04:30:38','2023-11-28','04:09:38'),(2516,238,10,3,'2023-11-28','04:41:38','2023-11-28','04:09:38'),(2517,238,10,9,'2023-11-28','04:51:38','2023-11-28','04:09:38'),(2518,238,10,4,'2023-11-28','05:01:38','2023-11-28','04:09:38'),(2519,238,5,1,'2023-11-28','04:30:38','2023-11-28','04:19:38'),(2520,238,5,3,'2023-11-28','04:41:38','2023-11-28','04:19:38'),(2521,238,5,9,'2023-11-28','04:51:38','2023-11-28','04:19:38'),(2522,238,5,4,'2023-11-28','05:01:38','2023-11-28','04:19:38'),(2523,238,1,3,'2023-11-28','04:41:38','2023-11-28','04:29:38'),(2524,238,1,9,'2023-11-28','04:51:38','2023-11-28','04:29:38'),(2525,238,1,4,'2023-11-28','05:01:38','2023-11-28','04:29:38'),(2526,238,3,9,'2023-11-28','04:51:38','2023-11-28','04:39:38'),(2527,238,3,4,'2023-11-28','05:01:38','2023-11-28','04:39:38'),(2528,238,9,4,'2023-11-28','05:01:38','2023-11-28','04:49:38'),(2529,239,8,10,'2023-11-28','07:59:58','2023-11-28','07:49:58'),(2530,239,8,5,'2023-11-28','08:10:58','2023-11-28','07:49:58'),(2531,239,8,1,'2023-11-28','08:21:58','2023-11-28','07:49:58'),(2532,239,10,5,'2023-11-28','08:10:58','2023-11-28','08:00:58'),(2533,239,10,1,'2023-11-28','08:21:58','2023-11-28','08:00:58'),(2534,239,5,1,'2023-11-28','08:21:58','2023-11-28','08:10:58'),(2535,240,3,1,'2023-11-28','05:03:42','2023-11-28','04:53:42'),(2536,240,3,5,'2023-11-28','05:14:42','2023-11-28','04:53:42'),(2537,240,3,10,'2023-11-28','05:25:42','2023-11-28','04:53:42'),(2538,240,3,8,'2023-11-28','05:36:42','2023-11-28','04:53:42'),(2539,240,1,5,'2023-11-28','05:14:42','2023-11-28','05:04:42'),(2540,240,1,10,'2023-11-28','05:25:42','2023-11-28','05:04:42'),(2541,240,1,8,'2023-11-28','05:36:42','2023-11-28','05:04:42'),(2542,240,5,10,'2023-11-28','05:25:42','2023-11-28','05:14:42'),(2543,240,5,8,'2023-11-28','05:36:42','2023-11-28','05:14:42'),(2544,240,10,8,'2023-11-28','05:36:42','2023-11-28','05:24:42'),(2545,241,8,10,'2023-11-29','04:37:31','2023-11-29','04:27:31'),(2546,241,8,5,'2023-11-29','04:48:31','2023-11-29','04:27:31'),(2547,241,8,6,'2023-11-29','04:59:31','2023-11-29','04:27:31'),(2548,241,8,11,'2023-11-29','05:10:31','2023-11-29','04:27:31'),(2549,241,10,5,'2023-11-29','04:48:31','2023-11-29','04:38:31'),(2550,241,10,6,'2023-11-29','04:59:31','2023-11-29','04:38:31'),(2551,241,10,11,'2023-11-29','05:10:31','2023-11-29','04:38:31'),(2552,241,5,6,'2023-11-29','04:59:31','2023-11-29','04:48:31'),(2553,241,5,11,'2023-11-29','05:10:31','2023-11-29','04:48:31'),(2554,241,6,11,'2023-11-29','05:10:31','2023-11-29','04:58:31'),(2555,242,2,5,'2023-11-29','12:05:00','2023-11-29','11:55:00'),(2556,242,2,10,'2023-11-29','12:16:00','2023-11-29','11:55:00'),(2557,242,2,8,'2023-11-29','12:27:00','2023-11-29','11:55:00'),(2558,242,5,10,'2023-11-29','12:16:00','2023-11-29','12:06:00'),(2559,242,5,8,'2023-11-29','12:27:00','2023-11-29','12:06:00'),(2560,242,10,8,'2023-11-29','12:27:00','2023-11-29','12:16:00'),(2561,243,8,10,'2023-11-29','04:08:38','2023-11-29','03:58:38'),(2562,243,8,5,'2023-11-29','04:19:38','2023-11-29','03:58:38'),(2563,243,8,1,'2023-11-29','04:30:38','2023-11-29','03:58:38'),(2564,243,8,3,'2023-11-29','04:41:38','2023-11-29','03:58:38'),(2565,243,8,9,'2023-11-29','04:51:38','2023-11-29','03:58:38'),(2566,243,8,4,'2023-11-29','05:01:38','2023-11-29','03:58:38'),(2567,243,10,5,'2023-11-29','04:19:38','2023-11-29','04:09:38'),(2568,243,10,1,'2023-11-29','04:30:38','2023-11-29','04:09:38'),(2569,243,10,3,'2023-11-29','04:41:38','2023-11-29','04:09:38'),(2570,243,10,9,'2023-11-29','04:51:38','2023-11-29','04:09:38'),(2571,243,10,4,'2023-11-29','05:01:38','2023-11-29','04:09:38'),(2572,243,5,1,'2023-11-29','04:30:38','2023-11-29','04:19:38'),(2573,243,5,3,'2023-11-29','04:41:38','2023-11-29','04:19:38'),(2574,243,5,9,'2023-11-29','04:51:38','2023-11-29','04:19:38'),(2575,243,5,4,'2023-11-29','05:01:38','2023-11-29','04:19:38'),(2576,243,1,3,'2023-11-29','04:41:38','2023-11-29','04:29:38'),(2577,243,1,9,'2023-11-29','04:51:38','2023-11-29','04:29:38'),(2578,243,1,4,'2023-11-29','05:01:38','2023-11-29','04:29:38'),(2579,243,3,9,'2023-11-29','04:51:38','2023-11-29','04:39:38'),(2580,243,3,4,'2023-11-29','05:01:38','2023-11-29','04:39:38'),(2581,243,9,4,'2023-11-29','05:01:38','2023-11-29','04:49:38'),(2582,244,8,10,'2023-11-29','07:59:58','2023-11-29','07:49:58'),(2583,244,8,5,'2023-11-29','08:10:58','2023-11-29','07:49:58'),(2584,244,8,1,'2023-11-29','08:21:58','2023-11-29','07:49:58'),(2585,244,10,5,'2023-11-29','08:10:58','2023-11-29','08:00:58'),(2586,244,10,1,'2023-11-29','08:21:58','2023-11-29','08:00:58'),(2587,244,5,1,'2023-11-29','08:21:58','2023-11-29','08:10:58'),(2588,245,3,1,'2023-11-29','05:03:42','2023-11-29','04:53:42'),(2589,245,3,5,'2023-11-29','05:14:42','2023-11-29','04:53:42'),(2590,245,3,10,'2023-11-29','05:25:42','2023-11-29','04:53:42'),(2591,245,3,8,'2023-11-29','05:36:42','2023-11-29','04:53:42'),(2592,245,1,5,'2023-11-29','05:14:42','2023-11-29','05:04:42'),(2593,245,1,10,'2023-11-29','05:25:42','2023-11-29','05:04:42'),(2594,245,1,8,'2023-11-29','05:36:42','2023-11-29','05:04:42'),(2595,245,5,10,'2023-11-29','05:25:42','2023-11-29','05:14:42'),(2596,245,5,8,'2023-11-29','05:36:42','2023-11-29','05:14:42'),(2597,245,10,8,'2023-11-29','05:36:42','2023-11-29','05:24:42'),(2598,246,8,10,'2023-11-30','04:37:31','2023-11-30','04:27:31'),(2599,246,8,5,'2023-11-30','04:48:31','2023-11-30','04:27:31'),(2600,246,8,6,'2023-11-30','04:59:31','2023-11-30','04:27:31'),(2601,246,8,11,'2023-11-30','05:10:31','2023-11-30','04:27:31'),(2602,246,10,5,'2023-11-30','04:48:31','2023-11-30','04:38:31'),(2603,246,10,6,'2023-11-30','04:59:31','2023-11-30','04:38:31'),(2604,246,10,11,'2023-11-30','05:10:31','2023-11-30','04:38:31'),(2605,246,5,6,'2023-11-30','04:59:31','2023-11-30','04:48:31'),(2606,246,5,11,'2023-11-30','05:10:31','2023-11-30','04:48:31'),(2607,246,6,11,'2023-11-30','05:10:31','2023-11-30','04:58:31'),(2608,247,2,5,'2023-11-30','12:05:00','2023-11-30','11:55:00'),(2609,247,2,10,'2023-11-30','12:16:00','2023-11-30','11:55:00'),(2610,247,2,8,'2023-11-30','12:27:00','2023-11-30','11:55:00'),(2611,247,5,10,'2023-11-30','12:16:00','2023-11-30','12:06:00'),(2612,247,5,8,'2023-11-30','12:27:00','2023-11-30','12:06:00'),(2613,247,10,8,'2023-11-30','12:27:00','2023-11-30','12:16:00'),(2614,248,8,10,'2023-11-30','04:08:38','2023-11-30','03:58:38'),(2615,248,8,5,'2023-11-30','04:19:38','2023-11-30','03:58:38'),(2616,248,8,1,'2023-11-30','04:30:38','2023-11-30','03:58:38'),(2617,248,8,3,'2023-11-30','04:41:38','2023-11-30','03:58:38'),(2618,248,8,9,'2023-11-30','04:51:38','2023-11-30','03:58:38'),(2619,248,8,4,'2023-11-30','05:01:38','2023-11-30','03:58:38'),(2620,248,10,5,'2023-11-30','04:19:38','2023-11-30','04:09:38'),(2621,248,10,1,'2023-11-30','04:30:38','2023-11-30','04:09:38'),(2622,248,10,3,'2023-11-30','04:41:38','2023-11-30','04:09:38'),(2623,248,10,9,'2023-11-30','04:51:38','2023-11-30','04:09:38'),(2624,248,10,4,'2023-11-30','05:01:38','2023-11-30','04:09:38'),(2625,248,5,1,'2023-11-30','04:30:38','2023-11-30','04:19:38'),(2626,248,5,3,'2023-11-30','04:41:38','2023-11-30','04:19:38'),(2627,248,5,9,'2023-11-30','04:51:38','2023-11-30','04:19:38'),(2628,248,5,4,'2023-11-30','05:01:38','2023-11-30','04:19:38'),(2629,248,1,3,'2023-11-30','04:41:38','2023-11-30','04:29:38'),(2630,248,1,9,'2023-11-30','04:51:38','2023-11-30','04:29:38'),(2631,248,1,4,'2023-11-30','05:01:38','2023-11-30','04:29:38'),(2632,248,3,9,'2023-11-30','04:51:38','2023-11-30','04:39:38'),(2633,248,3,4,'2023-11-30','05:01:38','2023-11-30','04:39:38'),(2634,248,9,4,'2023-11-30','05:01:38','2023-11-30','04:49:38'),(2635,249,8,10,'2023-11-30','07:59:58','2023-11-30','07:49:58'),(2636,249,8,5,'2023-11-30','08:10:58','2023-11-30','07:49:58'),(2637,249,8,1,'2023-11-30','08:21:58','2023-11-30','07:49:58'),(2638,249,10,5,'2023-11-30','08:10:58','2023-11-30','08:00:58'),(2639,249,10,1,'2023-11-30','08:21:58','2023-11-30','08:00:58'),(2640,249,5,1,'2023-11-30','08:21:58','2023-11-30','08:10:58'),(2641,250,3,1,'2023-11-30','05:03:42','2023-11-30','04:53:42'),(2642,250,3,5,'2023-11-30','05:14:42','2023-11-30','04:53:42'),(2643,250,3,10,'2023-11-30','05:25:42','2023-11-30','04:53:42'),(2644,250,3,8,'2023-11-30','05:36:42','2023-11-30','04:53:42'),(2645,250,1,5,'2023-11-30','05:14:42','2023-11-30','05:04:42'),(2646,250,1,10,'2023-11-30','05:25:42','2023-11-30','05:04:42'),(2647,250,1,8,'2023-11-30','05:36:42','2023-11-30','05:04:42'),(2648,250,5,10,'2023-11-30','05:25:42','2023-11-30','05:14:42'),(2649,250,5,8,'2023-11-30','05:36:42','2023-11-30','05:14:42'),(2650,250,10,8,'2023-11-30','05:36:42','2023-11-30','05:24:42'),(2651,251,8,10,'2023-12-01','04:37:31','2023-12-01','04:27:31'),(2652,251,8,5,'2023-12-01','04:48:31','2023-12-01','04:27:31'),(2653,251,8,6,'2023-12-01','04:59:31','2023-12-01','04:27:31'),(2654,251,8,11,'2023-12-01','05:10:31','2023-12-01','04:27:31'),(2655,251,10,5,'2023-12-01','04:48:31','2023-12-01','04:38:31'),(2656,251,10,6,'2023-12-01','04:59:31','2023-12-01','04:38:31'),(2657,251,10,11,'2023-12-01','05:10:31','2023-12-01','04:38:31'),(2658,251,5,6,'2023-12-01','04:59:31','2023-12-01','04:48:31'),(2659,251,5,11,'2023-12-01','05:10:31','2023-12-01','04:48:31'),(2660,251,6,11,'2023-12-01','05:10:31','2023-12-01','04:58:31'),(2661,252,2,5,'2023-12-01','12:05:00','2023-12-01','11:55:00'),(2662,252,2,10,'2023-12-01','12:16:00','2023-12-01','11:55:00'),(2663,252,2,8,'2023-12-01','12:27:00','2023-12-01','11:55:00'),(2664,252,5,10,'2023-12-01','12:16:00','2023-12-01','12:06:00'),(2665,252,5,8,'2023-12-01','12:27:00','2023-12-01','12:06:00'),(2666,252,10,8,'2023-12-01','12:27:00','2023-12-01','12:16:00'),(2667,253,8,10,'2023-12-01','04:08:38','2023-12-01','03:58:38'),(2668,253,8,5,'2023-12-01','04:19:38','2023-12-01','03:58:38'),(2669,253,8,1,'2023-12-01','04:30:38','2023-12-01','03:58:38'),(2670,253,8,3,'2023-12-01','04:41:38','2023-12-01','03:58:38'),(2671,253,8,9,'2023-12-01','04:51:38','2023-12-01','03:58:38'),(2672,253,8,4,'2023-12-01','05:01:38','2023-12-01','03:58:38'),(2673,253,10,5,'2023-12-01','04:19:38','2023-12-01','04:09:38'),(2674,253,10,1,'2023-12-01','04:30:38','2023-12-01','04:09:38'),(2675,253,10,3,'2023-12-01','04:41:38','2023-12-01','04:09:38'),(2676,253,10,9,'2023-12-01','04:51:38','2023-12-01','04:09:38'),(2677,253,10,4,'2023-12-01','05:01:38','2023-12-01','04:09:38'),(2678,253,5,1,'2023-12-01','04:30:38','2023-12-01','04:19:38'),(2679,253,5,3,'2023-12-01','04:41:38','2023-12-01','04:19:38'),(2680,253,5,9,'2023-12-01','04:51:38','2023-12-01','04:19:38'),(2681,253,5,4,'2023-12-01','05:01:38','2023-12-01','04:19:38'),(2682,253,1,3,'2023-12-01','04:41:38','2023-12-01','04:29:38'),(2683,253,1,9,'2023-12-01','04:51:38','2023-12-01','04:29:38'),(2684,253,1,4,'2023-12-01','05:01:38','2023-12-01','04:29:38'),(2685,253,3,9,'2023-12-01','04:51:38','2023-12-01','04:39:38'),(2686,253,3,4,'2023-12-01','05:01:38','2023-12-01','04:39:38'),(2687,253,9,4,'2023-12-01','05:01:38','2023-12-01','04:49:38'),(2688,254,8,10,'2023-12-01','07:59:58','2023-12-01','07:49:58'),(2689,254,8,5,'2023-12-01','08:10:58','2023-12-01','07:49:58'),(2690,254,8,1,'2023-12-01','08:21:58','2023-12-01','07:49:58'),(2691,254,10,5,'2023-12-01','08:10:58','2023-12-01','08:00:58'),(2692,254,10,1,'2023-12-01','08:21:58','2023-12-01','08:00:58'),(2693,254,5,1,'2023-12-01','08:21:58','2023-12-01','08:10:58'),(2694,255,3,1,'2023-12-01','05:03:42','2023-12-01','04:53:42'),(2695,255,3,5,'2023-12-01','05:14:42','2023-12-01','04:53:42'),(2696,255,3,10,'2023-12-01','05:25:42','2023-12-01','04:53:42'),(2697,255,3,8,'2023-12-01','05:36:42','2023-12-01','04:53:42'),(2698,255,1,5,'2023-12-01','05:14:42','2023-12-01','05:04:42'),(2699,255,1,10,'2023-12-01','05:25:42','2023-12-01','05:04:42'),(2700,255,1,8,'2023-12-01','05:36:42','2023-12-01','05:04:42'),(2701,255,5,10,'2023-12-01','05:25:42','2023-12-01','05:14:42'),(2702,255,5,8,'2023-12-01','05:36:42','2023-12-01','05:14:42'),(2703,255,10,8,'2023-12-01','05:36:42','2023-12-01','05:24:42'),(2704,256,8,10,'2023-12-02','04:37:31','2023-12-02','04:27:31'),(2705,256,8,5,'2023-12-02','04:48:31','2023-12-02','04:27:31'),(2706,256,8,6,'2023-12-02','04:59:31','2023-12-02','04:27:31'),(2707,256,8,11,'2023-12-02','05:10:31','2023-12-02','04:27:31'),(2708,256,10,5,'2023-12-02','04:48:31','2023-12-02','04:38:31'),(2709,256,10,6,'2023-12-02','04:59:31','2023-12-02','04:38:31'),(2710,256,10,11,'2023-12-02','05:10:31','2023-12-02','04:38:31'),(2711,256,5,6,'2023-12-02','04:59:31','2023-12-02','04:48:31'),(2712,256,5,11,'2023-12-02','05:10:31','2023-12-02','04:48:31'),(2713,256,6,11,'2023-12-02','05:10:31','2023-12-02','04:58:31'),(2714,257,2,5,'2023-12-02','12:05:00','2023-12-02','11:55:00'),(2715,257,2,10,'2023-12-02','12:16:00','2023-12-02','11:55:00'),(2716,257,2,8,'2023-12-02','12:27:00','2023-12-02','11:55:00'),(2717,257,5,10,'2023-12-02','12:16:00','2023-12-02','12:06:00'),(2718,257,5,8,'2023-12-02','12:27:00','2023-12-02','12:06:00'),(2719,257,10,8,'2023-12-02','12:27:00','2023-12-02','12:16:00'),(2720,258,8,10,'2023-12-02','04:08:38','2023-12-02','03:58:38'),(2721,258,8,5,'2023-12-02','04:19:38','2023-12-02','03:58:38'),(2722,258,8,1,'2023-12-02','04:30:38','2023-12-02','03:58:38'),(2723,258,8,3,'2023-12-02','04:41:38','2023-12-02','03:58:38'),(2724,258,8,9,'2023-12-02','04:51:38','2023-12-02','03:58:38'),(2725,258,8,4,'2023-12-02','05:01:38','2023-12-02','03:58:38'),(2726,258,10,5,'2023-12-02','04:19:38','2023-12-02','04:09:38'),(2727,258,10,1,'2023-12-02','04:30:38','2023-12-02','04:09:38'),(2728,258,10,3,'2023-12-02','04:41:38','2023-12-02','04:09:38'),(2729,258,10,9,'2023-12-02','04:51:38','2023-12-02','04:09:38'),(2730,258,10,4,'2023-12-02','05:01:38','2023-12-02','04:09:38'),(2731,258,5,1,'2023-12-02','04:30:38','2023-12-02','04:19:38'),(2732,258,5,3,'2023-12-02','04:41:38','2023-12-02','04:19:38'),(2733,258,5,9,'2023-12-02','04:51:38','2023-12-02','04:19:38'),(2734,258,5,4,'2023-12-02','05:01:38','2023-12-02','04:19:38'),(2735,258,1,3,'2023-12-02','04:41:38','2023-12-02','04:29:38'),(2736,258,1,9,'2023-12-02','04:51:38','2023-12-02','04:29:38'),(2737,258,1,4,'2023-12-02','05:01:38','2023-12-02','04:29:38'),(2738,258,3,9,'2023-12-02','04:51:38','2023-12-02','04:39:38'),(2739,258,3,4,'2023-12-02','05:01:38','2023-12-02','04:39:38'),(2740,258,9,4,'2023-12-02','05:01:38','2023-12-02','04:49:38'),(2741,259,8,10,'2023-12-02','07:59:58','2023-12-02','07:49:58'),(2742,259,8,5,'2023-12-02','08:10:58','2023-12-02','07:49:58'),(2743,259,8,1,'2023-12-02','08:21:58','2023-12-02','07:49:58'),(2744,259,10,5,'2023-12-02','08:10:58','2023-12-02','08:00:58'),(2745,259,10,1,'2023-12-02','08:21:58','2023-12-02','08:00:58'),(2746,259,5,1,'2023-12-02','08:21:58','2023-12-02','08:10:58'),(2747,260,3,1,'2023-12-02','05:03:42','2023-12-02','04:53:42'),(2748,260,3,5,'2023-12-02','05:14:42','2023-12-02','04:53:42'),(2749,260,3,10,'2023-12-02','05:25:42','2023-12-02','04:53:42'),(2750,260,3,8,'2023-12-02','05:36:42','2023-12-02','04:53:42'),(2751,260,1,5,'2023-12-02','05:14:42','2023-12-02','05:04:42'),(2752,260,1,10,'2023-12-02','05:25:42','2023-12-02','05:04:42'),(2753,260,1,8,'2023-12-02','05:36:42','2023-12-02','05:04:42'),(2754,260,5,10,'2023-12-02','05:25:42','2023-12-02','05:14:42'),(2755,260,5,8,'2023-12-02','05:36:42','2023-12-02','05:14:42'),(2756,260,10,8,'2023-12-02','05:36:42','2023-12-02','05:24:42'),(2757,261,8,10,'2023-12-03','04:37:31','2023-12-03','04:27:31'),(2758,261,8,5,'2023-12-03','04:48:31','2023-12-03','04:27:31'),(2759,261,8,6,'2023-12-03','04:59:31','2023-12-03','04:27:31'),(2760,261,8,11,'2023-12-03','05:10:31','2023-12-03','04:27:31'),(2761,261,10,5,'2023-12-03','04:48:31','2023-12-03','04:38:31'),(2762,261,10,6,'2023-12-03','04:59:31','2023-12-03','04:38:31'),(2763,261,10,11,'2023-12-03','05:10:31','2023-12-03','04:38:31'),(2764,261,5,6,'2023-12-03','04:59:31','2023-12-03','04:48:31'),(2765,261,5,11,'2023-12-03','05:10:31','2023-12-03','04:48:31'),(2766,261,6,11,'2023-12-03','05:10:31','2023-12-03','04:58:31'),(2767,262,2,5,'2023-12-03','12:05:00','2023-12-03','11:55:00'),(2768,262,2,10,'2023-12-03','12:16:00','2023-12-03','11:55:00'),(2769,262,2,8,'2023-12-03','12:27:00','2023-12-03','11:55:00'),(2770,262,5,10,'2023-12-03','12:16:00','2023-12-03','12:06:00'),(2771,262,5,8,'2023-12-03','12:27:00','2023-12-03','12:06:00'),(2772,262,10,8,'2023-12-03','12:27:00','2023-12-03','12:16:00'),(2773,263,8,10,'2023-12-03','04:08:38','2023-12-03','03:58:38'),(2774,263,8,5,'2023-12-03','04:19:38','2023-12-03','03:58:38'),(2775,263,8,1,'2023-12-03','04:30:38','2023-12-03','03:58:38'),(2776,263,8,3,'2023-12-03','04:41:38','2023-12-03','03:58:38'),(2777,263,8,9,'2023-12-03','04:51:38','2023-12-03','03:58:38'),(2778,263,8,4,'2023-12-03','05:01:38','2023-12-03','03:58:38'),(2779,263,10,5,'2023-12-03','04:19:38','2023-12-03','04:09:38'),(2780,263,10,1,'2023-12-03','04:30:38','2023-12-03','04:09:38'),(2781,263,10,3,'2023-12-03','04:41:38','2023-12-03','04:09:38'),(2782,263,10,9,'2023-12-03','04:51:38','2023-12-03','04:09:38'),(2783,263,10,4,'2023-12-03','05:01:38','2023-12-03','04:09:38'),(2784,263,5,1,'2023-12-03','04:30:38','2023-12-03','04:19:38'),(2785,263,5,3,'2023-12-03','04:41:38','2023-12-03','04:19:38'),(2786,263,5,9,'2023-12-03','04:51:38','2023-12-03','04:19:38'),(2787,263,5,4,'2023-12-03','05:01:38','2023-12-03','04:19:38'),(2788,263,1,3,'2023-12-03','04:41:38','2023-12-03','04:29:38'),(2789,263,1,9,'2023-12-03','04:51:38','2023-12-03','04:29:38'),(2790,263,1,4,'2023-12-03','05:01:38','2023-12-03','04:29:38'),(2791,263,3,9,'2023-12-03','04:51:38','2023-12-03','04:39:38'),(2792,263,3,4,'2023-12-03','05:01:38','2023-12-03','04:39:38'),(2793,263,9,4,'2023-12-03','05:01:38','2023-12-03','04:49:38'),(2794,264,8,10,'2023-12-03','07:59:58','2023-12-03','07:49:58'),(2795,264,8,5,'2023-12-03','08:10:58','2023-12-03','07:49:58'),(2796,264,8,1,'2023-12-03','08:21:58','2023-12-03','07:49:58'),(2797,264,10,5,'2023-12-03','08:10:58','2023-12-03','08:00:58'),(2798,264,10,1,'2023-12-03','08:21:58','2023-12-03','08:00:58'),(2799,264,5,1,'2023-12-03','08:21:58','2023-12-03','08:10:58'),(2800,265,3,1,'2023-12-03','05:03:42','2023-12-03','04:53:42'),(2801,265,3,5,'2023-12-03','05:14:42','2023-12-03','04:53:42'),(2802,265,3,10,'2023-12-03','05:25:42','2023-12-03','04:53:42'),(2803,265,3,8,'2023-12-03','05:36:42','2023-12-03','04:53:42'),(2804,265,1,5,'2023-12-03','05:14:42','2023-12-03','05:04:42'),(2805,265,1,10,'2023-12-03','05:25:42','2023-12-03','05:04:42'),(2806,265,1,8,'2023-12-03','05:36:42','2023-12-03','05:04:42'),(2807,265,5,10,'2023-12-03','05:25:42','2023-12-03','05:14:42'),(2808,265,5,8,'2023-12-03','05:36:42','2023-12-03','05:14:42'),(2809,265,10,8,'2023-12-03','05:36:42','2023-12-03','05:24:42'),(2810,266,8,10,'2023-12-04','04:37:31','2023-12-04','04:27:31'),(2811,266,8,5,'2023-12-04','04:48:31','2023-12-04','04:27:31'),(2812,266,8,6,'2023-12-04','04:59:31','2023-12-04','04:27:31'),(2813,266,8,11,'2023-12-04','05:10:31','2023-12-04','04:27:31'),(2814,266,10,5,'2023-12-04','04:48:31','2023-12-04','04:38:31'),(2815,266,10,6,'2023-12-04','04:59:31','2023-12-04','04:38:31'),(2816,266,10,11,'2023-12-04','05:10:31','2023-12-04','04:38:31'),(2817,266,5,6,'2023-12-04','04:59:31','2023-12-04','04:48:31'),(2818,266,5,11,'2023-12-04','05:10:31','2023-12-04','04:48:31'),(2819,266,6,11,'2023-12-04','05:10:31','2023-12-04','04:58:31'),(2820,267,2,5,'2023-12-04','12:05:00','2023-12-04','11:55:00'),(2821,267,2,10,'2023-12-04','12:16:00','2023-12-04','11:55:00'),(2822,267,2,8,'2023-12-04','12:27:00','2023-12-04','11:55:00'),(2823,267,5,10,'2023-12-04','12:16:00','2023-12-04','12:06:00'),(2824,267,5,8,'2023-12-04','12:27:00','2023-12-04','12:06:00'),(2825,267,10,8,'2023-12-04','12:27:00','2023-12-04','12:16:00'),(2826,268,8,10,'2023-12-04','04:08:38','2023-12-04','03:58:38'),(2827,268,8,5,'2023-12-04','04:19:38','2023-12-04','03:58:38'),(2828,268,8,1,'2023-12-04','04:30:38','2023-12-04','03:58:38'),(2829,268,8,3,'2023-12-04','04:41:38','2023-12-04','03:58:38'),(2830,268,8,9,'2023-12-04','04:51:38','2023-12-04','03:58:38'),(2831,268,8,4,'2023-12-04','05:01:38','2023-12-04','03:58:38'),(2832,268,10,5,'2023-12-04','04:19:38','2023-12-04','04:09:38'),(2833,268,10,1,'2023-12-04','04:30:38','2023-12-04','04:09:38'),(2834,268,10,3,'2023-12-04','04:41:38','2023-12-04','04:09:38'),(2835,268,10,9,'2023-12-04','04:51:38','2023-12-04','04:09:38'),(2836,268,10,4,'2023-12-04','05:01:38','2023-12-04','04:09:38'),(2837,268,5,1,'2023-12-04','04:30:38','2023-12-04','04:19:38'),(2838,268,5,3,'2023-12-04','04:41:38','2023-12-04','04:19:38'),(2839,268,5,9,'2023-12-04','04:51:38','2023-12-04','04:19:38'),(2840,268,5,4,'2023-12-04','05:01:38','2023-12-04','04:19:38'),(2841,268,1,3,'2023-12-04','04:41:38','2023-12-04','04:29:38'),(2842,268,1,9,'2023-12-04','04:51:38','2023-12-04','04:29:38'),(2843,268,1,4,'2023-12-04','05:01:38','2023-12-04','04:29:38'),(2844,268,3,9,'2023-12-04','04:51:38','2023-12-04','04:39:38'),(2845,268,3,4,'2023-12-04','05:01:38','2023-12-04','04:39:38'),(2846,268,9,4,'2023-12-04','05:01:38','2023-12-04','04:49:38'),(2847,269,8,10,'2023-12-04','07:59:58','2023-12-04','07:49:58'),(2848,269,8,5,'2023-12-04','08:10:58','2023-12-04','07:49:58'),(2849,269,8,1,'2023-12-04','08:21:58','2023-12-04','07:49:58'),(2850,269,10,5,'2023-12-04','08:10:58','2023-12-04','08:00:58'),(2851,269,10,1,'2023-12-04','08:21:58','2023-12-04','08:00:58'),(2852,269,5,1,'2023-12-04','08:21:58','2023-12-04','08:10:58'),(2853,270,3,1,'2023-12-04','05:03:42','2023-12-04','04:53:42'),(2854,270,3,5,'2023-12-04','05:14:42','2023-12-04','04:53:42'),(2855,270,3,10,'2023-12-04','05:25:42','2023-12-04','04:53:42'),(2856,270,3,8,'2023-12-04','05:36:42','2023-12-04','04:53:42'),(2857,270,1,5,'2023-12-04','05:14:42','2023-12-04','05:04:42'),(2858,270,1,10,'2023-12-04','05:25:42','2023-12-04','05:04:42'),(2859,270,1,8,'2023-12-04','05:36:42','2023-12-04','05:04:42'),(2860,270,5,10,'2023-12-04','05:25:42','2023-12-04','05:14:42'),(2861,270,5,8,'2023-12-04','05:36:42','2023-12-04','05:14:42'),(2862,270,10,8,'2023-12-04','05:36:42','2023-12-04','05:24:42'),(2863,271,8,10,'2023-12-05','04:37:31','2023-12-05','04:27:31'),(2864,271,8,5,'2023-12-05','04:48:31','2023-12-05','04:27:31'),(2865,271,8,6,'2023-12-05','04:59:31','2023-12-05','04:27:31'),(2866,271,8,11,'2023-12-05','05:10:31','2023-12-05','04:27:31'),(2867,271,10,5,'2023-12-05','04:48:31','2023-12-05','04:38:31'),(2868,271,10,6,'2023-12-05','04:59:31','2023-12-05','04:38:31'),(2869,271,10,11,'2023-12-05','05:10:31','2023-12-05','04:38:31'),(2870,271,5,6,'2023-12-05','04:59:31','2023-12-05','04:48:31'),(2871,271,5,11,'2023-12-05','05:10:31','2023-12-05','04:48:31'),(2872,271,6,11,'2023-12-05','05:10:31','2023-12-05','04:58:31'),(2873,272,2,5,'2023-12-05','12:05:00','2023-12-05','11:55:00'),(2874,272,2,10,'2023-12-05','12:16:00','2023-12-05','11:55:00'),(2875,272,2,8,'2023-12-05','12:27:00','2023-12-05','11:55:00'),(2876,272,5,10,'2023-12-05','12:16:00','2023-12-05','12:06:00'),(2877,272,5,8,'2023-12-05','12:27:00','2023-12-05','12:06:00'),(2878,272,10,8,'2023-12-05','12:27:00','2023-12-05','12:16:00'),(2879,273,8,10,'2023-12-05','04:08:38','2023-12-05','03:58:38'),(2880,273,8,5,'2023-12-05','04:19:38','2023-12-05','03:58:38'),(2881,273,8,1,'2023-12-05','04:30:38','2023-12-05','03:58:38'),(2882,273,8,3,'2023-12-05','04:41:38','2023-12-05','03:58:38'),(2883,273,8,9,'2023-12-05','04:51:38','2023-12-05','03:58:38'),(2884,273,8,4,'2023-12-05','05:01:38','2023-12-05','03:58:38'),(2885,273,10,5,'2023-12-05','04:19:38','2023-12-05','04:09:38'),(2886,273,10,1,'2023-12-05','04:30:38','2023-12-05','04:09:38'),(2887,273,10,3,'2023-12-05','04:41:38','2023-12-05','04:09:38'),(2888,273,10,9,'2023-12-05','04:51:38','2023-12-05','04:09:38'),(2889,273,10,4,'2023-12-05','05:01:38','2023-12-05','04:09:38'),(2890,273,5,1,'2023-12-05','04:30:38','2023-12-05','04:19:38'),(2891,273,5,3,'2023-12-05','04:41:38','2023-12-05','04:19:38'),(2892,273,5,9,'2023-12-05','04:51:38','2023-12-05','04:19:38'),(2893,273,5,4,'2023-12-05','05:01:38','2023-12-05','04:19:38'),(2894,273,1,3,'2023-12-05','04:41:38','2023-12-05','04:29:38'),(2895,273,1,9,'2023-12-05','04:51:38','2023-12-05','04:29:38'),(2896,273,1,4,'2023-12-05','05:01:38','2023-12-05','04:29:38'),(2897,273,3,9,'2023-12-05','04:51:38','2023-12-05','04:39:38'),(2898,273,3,4,'2023-12-05','05:01:38','2023-12-05','04:39:38'),(2899,273,9,4,'2023-12-05','05:01:38','2023-12-05','04:49:38'),(2900,274,8,10,'2023-12-05','07:59:58','2023-12-05','07:49:58'),(2901,274,8,5,'2023-12-05','08:10:58','2023-12-05','07:49:58'),(2902,274,8,1,'2023-12-05','08:21:58','2023-12-05','07:49:58'),(2903,274,10,5,'2023-12-05','08:10:58','2023-12-05','08:00:58'),(2904,274,10,1,'2023-12-05','08:21:58','2023-12-05','08:00:58'),(2905,274,5,1,'2023-12-05','08:21:58','2023-12-05','08:10:58'),(2906,275,3,1,'2023-12-05','05:03:42','2023-12-05','04:53:42'),(2907,275,3,5,'2023-12-05','05:14:42','2023-12-05','04:53:42'),(2908,275,3,10,'2023-12-05','05:25:42','2023-12-05','04:53:42'),(2909,275,3,8,'2023-12-05','05:36:42','2023-12-05','04:53:42'),(2910,275,1,5,'2023-12-05','05:14:42','2023-12-05','05:04:42'),(2911,275,1,10,'2023-12-05','05:25:42','2023-12-05','05:04:42'),(2912,275,1,8,'2023-12-05','05:36:42','2023-12-05','05:04:42'),(2913,275,5,10,'2023-12-05','05:25:42','2023-12-05','05:14:42'),(2914,275,5,8,'2023-12-05','05:36:42','2023-12-05','05:14:42'),(2915,275,10,8,'2023-12-05','05:36:42','2023-12-05','05:24:42'),(2916,276,8,10,'2023-12-06','04:37:31','2023-12-06','04:27:31'),(2917,276,8,5,'2023-12-06','04:48:31','2023-12-06','04:27:31'),(2918,276,8,6,'2023-12-06','04:59:31','2023-12-06','04:27:31'),(2919,276,8,11,'2023-12-06','05:10:31','2023-12-06','04:27:31'),(2920,276,10,5,'2023-12-06','04:48:31','2023-12-06','04:38:31'),(2921,276,10,6,'2023-12-06','04:59:31','2023-12-06','04:38:31'),(2922,276,10,11,'2023-12-06','05:10:31','2023-12-06','04:38:31'),(2923,276,5,6,'2023-12-06','04:59:31','2023-12-06','04:48:31'),(2924,276,5,11,'2023-12-06','05:10:31','2023-12-06','04:48:31'),(2925,276,6,11,'2023-12-06','05:10:31','2023-12-06','04:58:31'),(2926,277,2,5,'2023-12-06','12:05:00','2023-12-06','11:55:00'),(2927,277,2,10,'2023-12-06','12:16:00','2023-12-06','11:55:00'),(2928,277,2,8,'2023-12-06','12:27:00','2023-12-06','11:55:00'),(2929,277,5,10,'2023-12-06','12:16:00','2023-12-06','12:06:00'),(2930,277,5,8,'2023-12-06','12:27:00','2023-12-06','12:06:00'),(2931,277,10,8,'2023-12-06','12:27:00','2023-12-06','12:16:00'),(2932,278,8,10,'2023-12-06','04:08:38','2023-12-06','03:58:38'),(2933,278,8,5,'2023-12-06','04:19:38','2023-12-06','03:58:38'),(2934,278,8,1,'2023-12-06','04:30:38','2023-12-06','03:58:38'),(2935,278,8,3,'2023-12-06','04:41:38','2023-12-06','03:58:38'),(2936,278,8,9,'2023-12-06','04:51:38','2023-12-06','03:58:38'),(2937,278,8,4,'2023-12-06','05:01:38','2023-12-06','03:58:38'),(2938,278,10,5,'2023-12-06','04:19:38','2023-12-06','04:09:38'),(2939,278,10,1,'2023-12-06','04:30:38','2023-12-06','04:09:38'),(2940,278,10,3,'2023-12-06','04:41:38','2023-12-06','04:09:38'),(2941,278,10,9,'2023-12-06','04:51:38','2023-12-06','04:09:38'),(2942,278,10,4,'2023-12-06','05:01:38','2023-12-06','04:09:38'),(2943,278,5,1,'2023-12-06','04:30:38','2023-12-06','04:19:38'),(2944,278,5,3,'2023-12-06','04:41:38','2023-12-06','04:19:38'),(2945,278,5,9,'2023-12-06','04:51:38','2023-12-06','04:19:38'),(2946,278,5,4,'2023-12-06','05:01:38','2023-12-06','04:19:38'),(2947,278,1,3,'2023-12-06','04:41:38','2023-12-06','04:29:38'),(2948,278,1,9,'2023-12-06','04:51:38','2023-12-06','04:29:38'),(2949,278,1,4,'2023-12-06','05:01:38','2023-12-06','04:29:38'),(2950,278,3,9,'2023-12-06','04:51:38','2023-12-06','04:39:38'),(2951,278,3,4,'2023-12-06','05:01:38','2023-12-06','04:39:38'),(2952,278,9,4,'2023-12-06','05:01:38','2023-12-06','04:49:38'),(2953,279,8,10,'2023-12-06','07:59:58','2023-12-06','07:49:58'),(2954,279,8,5,'2023-12-06','08:10:58','2023-12-06','07:49:58'),(2955,279,8,1,'2023-12-06','08:21:58','2023-12-06','07:49:58'),(2956,279,10,5,'2023-12-06','08:10:58','2023-12-06','08:00:58'),(2957,279,10,1,'2023-12-06','08:21:58','2023-12-06','08:00:58'),(2958,279,5,1,'2023-12-06','08:21:58','2023-12-06','08:10:58'),(2959,280,3,1,'2023-12-06','05:03:42','2023-12-06','04:53:42'),(2960,280,3,5,'2023-12-06','05:14:42','2023-12-06','04:53:42'),(2961,280,3,10,'2023-12-06','05:25:42','2023-12-06','04:53:42'),(2962,280,3,8,'2023-12-06','05:36:42','2023-12-06','04:53:42'),(2963,280,1,5,'2023-12-06','05:14:42','2023-12-06','05:04:42'),(2964,280,1,10,'2023-12-06','05:25:42','2023-12-06','05:04:42'),(2965,280,1,8,'2023-12-06','05:36:42','2023-12-06','05:04:42'),(2966,280,5,10,'2023-12-06','05:25:42','2023-12-06','05:14:42'),(2967,280,5,8,'2023-12-06','05:36:42','2023-12-06','05:14:42'),(2968,280,10,8,'2023-12-06','05:36:42','2023-12-06','05:24:42'),(2969,281,8,10,'2023-12-07','04:37:31','2023-12-07','04:27:31'),(2970,281,8,5,'2023-12-07','04:48:31','2023-12-07','04:27:31'),(2971,281,8,6,'2023-12-07','04:59:31','2023-12-07','04:27:31'),(2972,281,8,11,'2023-12-07','05:10:31','2023-12-07','04:27:31'),(2973,281,10,5,'2023-12-07','04:48:31','2023-12-07','04:38:31'),(2974,281,10,6,'2023-12-07','04:59:31','2023-12-07','04:38:31'),(2975,281,10,11,'2023-12-07','05:10:31','2023-12-07','04:38:31'),(2976,281,5,6,'2023-12-07','04:59:31','2023-12-07','04:48:31'),(2977,281,5,11,'2023-12-07','05:10:31','2023-12-07','04:48:31'),(2978,281,6,11,'2023-12-07','05:10:31','2023-12-07','04:58:31'),(2979,282,2,5,'2023-12-07','12:05:00','2023-12-07','11:55:00'),(2980,282,2,10,'2023-12-07','12:16:00','2023-12-07','11:55:00'),(2981,282,2,8,'2023-12-07','12:27:00','2023-12-07','11:55:00'),(2982,282,5,10,'2023-12-07','12:16:00','2023-12-07','12:06:00'),(2983,282,5,8,'2023-12-07','12:27:00','2023-12-07','12:06:00'),(2984,282,10,8,'2023-12-07','12:27:00','2023-12-07','12:16:00'),(2985,283,8,10,'2023-12-07','04:08:38','2023-12-07','03:58:38'),(2986,283,8,5,'2023-12-07','04:19:38','2023-12-07','03:58:38'),(2987,283,8,1,'2023-12-07','04:30:38','2023-12-07','03:58:38'),(2988,283,8,3,'2023-12-07','04:41:38','2023-12-07','03:58:38'),(2989,283,8,9,'2023-12-07','04:51:38','2023-12-07','03:58:38'),(2990,283,8,4,'2023-12-07','05:01:38','2023-12-07','03:58:38'),(2991,283,10,5,'2023-12-07','04:19:38','2023-12-07','04:09:38'),(2992,283,10,1,'2023-12-07','04:30:38','2023-12-07','04:09:38'),(2993,283,10,3,'2023-12-07','04:41:38','2023-12-07','04:09:38'),(2994,283,10,9,'2023-12-07','04:51:38','2023-12-07','04:09:38'),(2995,283,10,4,'2023-12-07','05:01:38','2023-12-07','04:09:38'),(2996,283,5,1,'2023-12-07','04:30:38','2023-12-07','04:19:38'),(2997,283,5,3,'2023-12-07','04:41:38','2023-12-07','04:19:38'),(2998,283,5,9,'2023-12-07','04:51:38','2023-12-07','04:19:38'),(2999,283,5,4,'2023-12-07','05:01:38','2023-12-07','04:19:38'),(3000,283,1,3,'2023-12-07','04:41:38','2023-12-07','04:29:38'),(3001,283,1,9,'2023-12-07','04:51:38','2023-12-07','04:29:38'),(3002,283,1,4,'2023-12-07','05:01:38','2023-12-07','04:29:38'),(3003,283,3,9,'2023-12-07','04:51:38','2023-12-07','04:39:38'),(3004,283,3,4,'2023-12-07','05:01:38','2023-12-07','04:39:38'),(3005,283,9,4,'2023-12-07','05:01:38','2023-12-07','04:49:38'),(3006,284,8,10,'2023-12-07','07:59:58','2023-12-07','07:49:58'),(3007,284,8,5,'2023-12-07','08:10:58','2023-12-07','07:49:58'),(3008,284,8,1,'2023-12-07','08:21:58','2023-12-07','07:49:58'),(3009,284,10,5,'2023-12-07','08:10:58','2023-12-07','08:00:58'),(3010,284,10,1,'2023-12-07','08:21:58','2023-12-07','08:00:58'),(3011,284,5,1,'2023-12-07','08:21:58','2023-12-07','08:10:58'),(3012,285,3,1,'2023-12-07','05:03:42','2023-12-07','04:53:42'),(3013,285,3,5,'2023-12-07','05:14:42','2023-12-07','04:53:42'),(3014,285,3,10,'2023-12-07','05:25:42','2023-12-07','04:53:42'),(3015,285,3,8,'2023-12-07','05:36:42','2023-12-07','04:53:42'),(3016,285,1,5,'2023-12-07','05:14:42','2023-12-07','05:04:42'),(3017,285,1,10,'2023-12-07','05:25:42','2023-12-07','05:04:42'),(3018,285,1,8,'2023-12-07','05:36:42','2023-12-07','05:04:42'),(3019,285,5,10,'2023-12-07','05:25:42','2023-12-07','05:14:42'),(3020,285,5,8,'2023-12-07','05:36:42','2023-12-07','05:14:42'),(3021,285,10,8,'2023-12-07','05:36:42','2023-12-07','05:24:42'),(3022,286,8,10,'2023-12-08','04:37:31','2023-12-08','04:27:31'),(3023,286,8,5,'2023-12-08','04:48:31','2023-12-08','04:27:31'),(3024,286,8,6,'2023-12-08','04:59:31','2023-12-08','04:27:31'),(3025,286,8,11,'2023-12-08','05:10:31','2023-12-08','04:27:31'),(3026,286,10,5,'2023-12-08','04:48:31','2023-12-08','04:38:31'),(3027,286,10,6,'2023-12-08','04:59:31','2023-12-08','04:38:31'),(3028,286,10,11,'2023-12-08','05:10:31','2023-12-08','04:38:31'),(3029,286,5,6,'2023-12-08','04:59:31','2023-12-08','04:48:31'),(3030,286,5,11,'2023-12-08','05:10:31','2023-12-08','04:48:31'),(3031,286,6,11,'2023-12-08','05:10:31','2023-12-08','04:58:31'),(3032,287,2,5,'2023-12-08','12:05:00','2023-12-08','11:55:00'),(3033,287,2,10,'2023-12-08','12:16:00','2023-12-08','11:55:00'),(3034,287,2,8,'2023-12-08','12:27:00','2023-12-08','11:55:00'),(3035,287,5,10,'2023-12-08','12:16:00','2023-12-08','12:06:00'),(3036,287,5,8,'2023-12-08','12:27:00','2023-12-08','12:06:00'),(3037,287,10,8,'2023-12-08','12:27:00','2023-12-08','12:16:00'),(3038,288,8,10,'2023-12-08','04:08:38','2023-12-08','03:58:38'),(3039,288,8,5,'2023-12-08','04:19:38','2023-12-08','03:58:38'),(3040,288,8,1,'2023-12-08','04:30:38','2023-12-08','03:58:38'),(3041,288,8,3,'2023-12-08','04:41:38','2023-12-08','03:58:38'),(3042,288,8,9,'2023-12-08','04:51:38','2023-12-08','03:58:38'),(3043,288,8,4,'2023-12-08','05:01:38','2023-12-08','03:58:38'),(3044,288,10,5,'2023-12-08','04:19:38','2023-12-08','04:09:38'),(3045,288,10,1,'2023-12-08','04:30:38','2023-12-08','04:09:38'),(3046,288,10,3,'2023-12-08','04:41:38','2023-12-08','04:09:38'),(3047,288,10,9,'2023-12-08','04:51:38','2023-12-08','04:09:38'),(3048,288,10,4,'2023-12-08','05:01:38','2023-12-08','04:09:38'),(3049,288,5,1,'2023-12-08','04:30:38','2023-12-08','04:19:38'),(3050,288,5,3,'2023-12-08','04:41:38','2023-12-08','04:19:38'),(3051,288,5,9,'2023-12-08','04:51:38','2023-12-08','04:19:38'),(3052,288,5,4,'2023-12-08','05:01:38','2023-12-08','04:19:38'),(3053,288,1,3,'2023-12-08','04:41:38','2023-12-08','04:29:38'),(3054,288,1,9,'2023-12-08','04:51:38','2023-12-08','04:29:38'),(3055,288,1,4,'2023-12-08','05:01:38','2023-12-08','04:29:38'),(3056,288,3,9,'2023-12-08','04:51:38','2023-12-08','04:39:38'),(3057,288,3,4,'2023-12-08','05:01:38','2023-12-08','04:39:38'),(3058,288,9,4,'2023-12-08','05:01:38','2023-12-08','04:49:38'),(3059,289,8,10,'2023-12-08','07:59:58','2023-12-08','07:49:58'),(3060,289,8,5,'2023-12-08','08:10:58','2023-12-08','07:49:58'),(3061,289,8,1,'2023-12-08','08:21:58','2023-12-08','07:49:58'),(3062,289,10,5,'2023-12-08','08:10:58','2023-12-08','08:00:58'),(3063,289,10,1,'2023-12-08','08:21:58','2023-12-08','08:00:58'),(3064,289,5,1,'2023-12-08','08:21:58','2023-12-08','08:10:58'),(3065,290,3,1,'2023-12-08','05:03:42','2023-12-08','04:53:42'),(3066,290,3,5,'2023-12-08','05:14:42','2023-12-08','04:53:42'),(3067,290,3,10,'2023-12-08','05:25:42','2023-12-08','04:53:42'),(3068,290,3,8,'2023-12-08','05:36:42','2023-12-08','04:53:42'),(3069,290,1,5,'2023-12-08','05:14:42','2023-12-08','05:04:42'),(3070,290,1,10,'2023-12-08','05:25:42','2023-12-08','05:04:42'),(3071,290,1,8,'2023-12-08','05:36:42','2023-12-08','05:04:42'),(3072,290,5,10,'2023-12-08','05:25:42','2023-12-08','05:14:42'),(3073,290,5,8,'2023-12-08','05:36:42','2023-12-08','05:14:42'),(3074,290,10,8,'2023-12-08','05:36:42','2023-12-08','05:24:42'),(3075,291,8,10,'2023-12-09','04:37:31','2023-12-09','04:27:31'),(3076,291,8,5,'2023-12-09','04:48:31','2023-12-09','04:27:31'),(3077,291,8,6,'2023-12-09','04:59:31','2023-12-09','04:27:31'),(3078,291,8,11,'2023-12-09','05:10:31','2023-12-09','04:27:31'),(3079,291,10,5,'2023-12-09','04:48:31','2023-12-09','04:38:31'),(3080,291,10,6,'2023-12-09','04:59:31','2023-12-09','04:38:31'),(3081,291,10,11,'2023-12-09','05:10:31','2023-12-09','04:38:31'),(3082,291,5,6,'2023-12-09','04:59:31','2023-12-09','04:48:31'),(3083,291,5,11,'2023-12-09','05:10:31','2023-12-09','04:48:31'),(3084,291,6,11,'2023-12-09','05:10:31','2023-12-09','04:58:31'),(3085,292,2,5,'2023-12-09','12:05:00','2023-12-09','11:55:00'),(3086,292,2,10,'2023-12-09','12:16:00','2023-12-09','11:55:00'),(3087,292,2,8,'2023-12-09','12:27:00','2023-12-09','11:55:00'),(3088,292,5,10,'2023-12-09','12:16:00','2023-12-09','12:06:00'),(3089,292,5,8,'2023-12-09','12:27:00','2023-12-09','12:06:00'),(3090,292,10,8,'2023-12-09','12:27:00','2023-12-09','12:16:00'),(3091,293,8,10,'2023-12-09','04:08:38','2023-12-09','03:58:38'),(3092,293,8,5,'2023-12-09','04:19:38','2023-12-09','03:58:38'),(3093,293,8,1,'2023-12-09','04:30:38','2023-12-09','03:58:38'),(3094,293,8,3,'2023-12-09','04:41:38','2023-12-09','03:58:38'),(3095,293,8,9,'2023-12-09','04:51:38','2023-12-09','03:58:38'),(3096,293,8,4,'2023-12-09','05:01:38','2023-12-09','03:58:38'),(3097,293,10,5,'2023-12-09','04:19:38','2023-12-09','04:09:38'),(3098,293,10,1,'2023-12-09','04:30:38','2023-12-09','04:09:38'),(3099,293,10,3,'2023-12-09','04:41:38','2023-12-09','04:09:38'),(3100,293,10,9,'2023-12-09','04:51:38','2023-12-09','04:09:38'),(3101,293,10,4,'2023-12-09','05:01:38','2023-12-09','04:09:38'),(3102,293,5,1,'2023-12-09','04:30:38','2023-12-09','04:19:38'),(3103,293,5,3,'2023-12-09','04:41:38','2023-12-09','04:19:38'),(3104,293,5,9,'2023-12-09','04:51:38','2023-12-09','04:19:38'),(3105,293,5,4,'2023-12-09','05:01:38','2023-12-09','04:19:38'),(3106,293,1,3,'2023-12-09','04:41:38','2023-12-09','04:29:38'),(3107,293,1,9,'2023-12-09','04:51:38','2023-12-09','04:29:38'),(3108,293,1,4,'2023-12-09','05:01:38','2023-12-09','04:29:38'),(3109,293,3,9,'2023-12-09','04:51:38','2023-12-09','04:39:38'),(3110,293,3,4,'2023-12-09','05:01:38','2023-12-09','04:39:38'),(3111,293,9,4,'2023-12-09','05:01:38','2023-12-09','04:49:38'),(3112,294,8,10,'2023-12-09','07:59:58','2023-12-09','07:49:58'),(3113,294,8,5,'2023-12-09','08:10:58','2023-12-09','07:49:58'),(3114,294,8,1,'2023-12-09','08:21:58','2023-12-09','07:49:58'),(3115,294,10,5,'2023-12-09','08:10:58','2023-12-09','08:00:58'),(3116,294,10,1,'2023-12-09','08:21:58','2023-12-09','08:00:58'),(3117,294,5,1,'2023-12-09','08:21:58','2023-12-09','08:10:58'),(3118,295,3,1,'2023-12-09','05:03:42','2023-12-09','04:53:42'),(3119,295,3,5,'2023-12-09','05:14:42','2023-12-09','04:53:42'),(3120,295,3,10,'2023-12-09','05:25:42','2023-12-09','04:53:42'),(3121,295,3,8,'2023-12-09','05:36:42','2023-12-09','04:53:42'),(3122,295,1,5,'2023-12-09','05:14:42','2023-12-09','05:04:42'),(3123,295,1,10,'2023-12-09','05:25:42','2023-12-09','05:04:42'),(3124,295,1,8,'2023-12-09','05:36:42','2023-12-09','05:04:42'),(3125,295,5,10,'2023-12-09','05:25:42','2023-12-09','05:14:42'),(3126,295,5,8,'2023-12-09','05:36:42','2023-12-09','05:14:42'),(3127,295,10,8,'2023-12-09','05:36:42','2023-12-09','05:24:42'),(3128,296,8,10,'2023-12-10','04:37:31','2023-12-10','04:27:31'),(3129,296,8,5,'2023-12-10','04:48:31','2023-12-10','04:27:31'),(3130,296,8,6,'2023-12-10','04:59:31','2023-12-10','04:27:31'),(3131,296,8,11,'2023-12-10','05:10:31','2023-12-10','04:27:31'),(3132,296,10,5,'2023-12-10','04:48:31','2023-12-10','04:38:31'),(3133,296,10,6,'2023-12-10','04:59:31','2023-12-10','04:38:31'),(3134,296,10,11,'2023-12-10','05:10:31','2023-12-10','04:38:31'),(3135,296,5,6,'2023-12-10','04:59:31','2023-12-10','04:48:31'),(3136,296,5,11,'2023-12-10','05:10:31','2023-12-10','04:48:31'),(3137,296,6,11,'2023-12-10','05:10:31','2023-12-10','04:58:31'),(3138,297,2,5,'2023-12-10','12:05:00','2023-12-10','11:55:00'),(3139,297,2,10,'2023-12-10','12:16:00','2023-12-10','11:55:00'),(3140,297,2,8,'2023-12-10','12:27:00','2023-12-10','11:55:00'),(3141,297,5,10,'2023-12-10','12:16:00','2023-12-10','12:06:00'),(3142,297,5,8,'2023-12-10','12:27:00','2023-12-10','12:06:00'),(3143,297,10,8,'2023-12-10','12:27:00','2023-12-10','12:16:00'),(3144,298,8,10,'2023-12-10','04:08:38','2023-12-10','03:58:38'),(3145,298,8,5,'2023-12-10','04:19:38','2023-12-10','03:58:38'),(3146,298,8,1,'2023-12-10','04:30:38','2023-12-10','03:58:38'),(3147,298,8,3,'2023-12-10','04:41:38','2023-12-10','03:58:38'),(3148,298,8,9,'2023-12-10','04:51:38','2023-12-10','03:58:38'),(3149,298,8,4,'2023-12-10','05:01:38','2023-12-10','03:58:38'),(3150,298,10,5,'2023-12-10','04:19:38','2023-12-10','04:09:38'),(3151,298,10,1,'2023-12-10','04:30:38','2023-12-10','04:09:38'),(3152,298,10,3,'2023-12-10','04:41:38','2023-12-10','04:09:38'),(3153,298,10,9,'2023-12-10','04:51:38','2023-12-10','04:09:38'),(3154,298,10,4,'2023-12-10','05:01:38','2023-12-10','04:09:38'),(3155,298,5,1,'2023-12-10','04:30:38','2023-12-10','04:19:38'),(3156,298,5,3,'2023-12-10','04:41:38','2023-12-10','04:19:38'),(3157,298,5,9,'2023-12-10','04:51:38','2023-12-10','04:19:38'),(3158,298,5,4,'2023-12-10','05:01:38','2023-12-10','04:19:38'),(3159,298,1,3,'2023-12-10','04:41:38','2023-12-10','04:29:38'),(3160,298,1,9,'2023-12-10','04:51:38','2023-12-10','04:29:38'),(3161,298,1,4,'2023-12-10','05:01:38','2023-12-10','04:29:38'),(3162,298,3,9,'2023-12-10','04:51:38','2023-12-10','04:39:38'),(3163,298,3,4,'2023-12-10','05:01:38','2023-12-10','04:39:38'),(3164,298,9,4,'2023-12-10','05:01:38','2023-12-10','04:49:38'),(3165,299,8,10,'2023-12-10','07:59:58','2023-12-10','07:49:58'),(3166,299,8,5,'2023-12-10','08:10:58','2023-12-10','07:49:58'),(3167,299,8,1,'2023-12-10','08:21:58','2023-12-10','07:49:58'),(3168,299,10,5,'2023-12-10','08:10:58','2023-12-10','08:00:58'),(3169,299,10,1,'2023-12-10','08:21:58','2023-12-10','08:00:58'),(3170,299,5,1,'2023-12-10','08:21:58','2023-12-10','08:10:58'),(3171,300,3,1,'2023-12-10','05:03:42','2023-12-10','04:53:42'),(3172,300,3,5,'2023-12-10','05:14:42','2023-12-10','04:53:42'),(3173,300,3,10,'2023-12-10','05:25:42','2023-12-10','04:53:42'),(3174,300,3,8,'2023-12-10','05:36:42','2023-12-10','04:53:42'),(3175,300,1,5,'2023-12-10','05:14:42','2023-12-10','05:04:42'),(3176,300,1,10,'2023-12-10','05:25:42','2023-12-10','05:04:42'),(3177,300,1,8,'2023-12-10','05:36:42','2023-12-10','05:04:42'),(3178,300,5,10,'2023-12-10','05:25:42','2023-12-10','05:14:42'),(3179,300,5,8,'2023-12-10','05:36:42','2023-12-10','05:14:42'),(3180,300,10,8,'2023-12-10','05:36:42','2023-12-10','05:24:42'),(3181,301,8,10,'2023-12-11','04:37:31','2023-12-11','04:27:31'),(3182,301,8,5,'2023-12-11','04:48:31','2023-12-11','04:27:31'),(3183,301,8,6,'2023-12-11','04:59:31','2023-12-11','04:27:31'),(3184,301,8,11,'2023-12-11','05:10:31','2023-12-11','04:27:31'),(3185,301,10,5,'2023-12-11','04:48:31','2023-12-11','04:38:31'),(3186,301,10,6,'2023-12-11','04:59:31','2023-12-11','04:38:31'),(3187,301,10,11,'2023-12-11','05:10:31','2023-12-11','04:38:31'),(3188,301,5,6,'2023-12-11','04:59:31','2023-12-11','04:48:31'),(3189,301,5,11,'2023-12-11','05:10:31','2023-12-11','04:48:31'),(3190,301,6,11,'2023-12-11','05:10:31','2023-12-11','04:58:31'),(3191,302,2,5,'2023-12-11','12:05:00','2023-12-11','11:55:00'),(3192,302,2,10,'2023-12-11','12:16:00','2023-12-11','11:55:00'),(3193,302,2,8,'2023-12-11','12:27:00','2023-12-11','11:55:00'),(3194,302,5,10,'2023-12-11','12:16:00','2023-12-11','12:06:00'),(3195,302,5,8,'2023-12-11','12:27:00','2023-12-11','12:06:00'),(3196,302,10,8,'2023-12-11','12:27:00','2023-12-11','12:16:00'),(3197,303,8,10,'2023-12-11','04:08:38','2023-12-11','03:58:38'),(3198,303,8,5,'2023-12-11','04:19:38','2023-12-11','03:58:38'),(3199,303,8,1,'2023-12-11','04:30:38','2023-12-11','03:58:38'),(3200,303,8,3,'2023-12-11','04:41:38','2023-12-11','03:58:38'),(3201,303,8,9,'2023-12-11','04:51:38','2023-12-11','03:58:38'),(3202,303,8,4,'2023-12-11','05:01:38','2023-12-11','03:58:38'),(3203,303,10,5,'2023-12-11','04:19:38','2023-12-11','04:09:38'),(3204,303,10,1,'2023-12-11','04:30:38','2023-12-11','04:09:38'),(3205,303,10,3,'2023-12-11','04:41:38','2023-12-11','04:09:38'),(3206,303,10,9,'2023-12-11','04:51:38','2023-12-11','04:09:38'),(3207,303,10,4,'2023-12-11','05:01:38','2023-12-11','04:09:38'),(3208,303,5,1,'2023-12-11','04:30:38','2023-12-11','04:19:38'),(3209,303,5,3,'2023-12-11','04:41:38','2023-12-11','04:19:38'),(3210,303,5,9,'2023-12-11','04:51:38','2023-12-11','04:19:38'),(3211,303,5,4,'2023-12-11','05:01:38','2023-12-11','04:19:38'),(3212,303,1,3,'2023-12-11','04:41:38','2023-12-11','04:29:38'),(3213,303,1,9,'2023-12-11','04:51:38','2023-12-11','04:29:38'),(3214,303,1,4,'2023-12-11','05:01:38','2023-12-11','04:29:38'),(3215,303,3,9,'2023-12-11','04:51:38','2023-12-11','04:39:38'),(3216,303,3,4,'2023-12-11','05:01:38','2023-12-11','04:39:38'),(3217,303,9,4,'2023-12-11','05:01:38','2023-12-11','04:49:38'),(3218,304,8,10,'2023-12-11','07:59:58','2023-12-11','07:49:58'),(3219,304,8,5,'2023-12-11','08:10:58','2023-12-11','07:49:58'),(3220,304,8,1,'2023-12-11','08:21:58','2023-12-11','07:49:58'),(3221,304,10,5,'2023-12-11','08:10:58','2023-12-11','08:00:58'),(3222,304,10,1,'2023-12-11','08:21:58','2023-12-11','08:00:58'),(3223,304,5,1,'2023-12-11','08:21:58','2023-12-11','08:10:58'),(3224,305,3,1,'2023-12-11','05:03:42','2023-12-11','04:53:42'),(3225,305,3,5,'2023-12-11','05:14:42','2023-12-11','04:53:42'),(3226,305,3,10,'2023-12-11','05:25:42','2023-12-11','04:53:42'),(3227,305,3,8,'2023-12-11','05:36:42','2023-12-11','04:53:42'),(3228,305,1,5,'2023-12-11','05:14:42','2023-12-11','05:04:42'),(3229,305,1,10,'2023-12-11','05:25:42','2023-12-11','05:04:42'),(3230,305,1,8,'2023-12-11','05:36:42','2023-12-11','05:04:42'),(3231,305,5,10,'2023-12-11','05:25:42','2023-12-11','05:14:42'),(3232,305,5,8,'2023-12-11','05:36:42','2023-12-11','05:14:42'),(3233,305,10,8,'2023-12-11','05:36:42','2023-12-11','05:24:42');
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
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `nBoleto` (`nBoleto`),
  KEY `dispAsientos_user_id_FK` (`user_id`),
  KEY `disponibilidadasientos_ibfk_1` (`nDisponibilidad`),
  KEY `disponibilidadasientos_index` (`nDisponibilidad`,`nAsiento`,`aEstadoAsiento`),
  CONSTRAINT `dispAsientos_user_id_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `disponibilidadasientos_ibfk_1` FOREIGN KEY (`nDisponibilidad`) REFERENCES `disponibilidad` (`nNumero`),
  CONSTRAINT `disponibilidadasientos_ibfk_2` FOREIGN KEY (`nBoleto`) REFERENCES `boletosvendidos` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `distribucionasientos_index` (`nNumero`,`nAsientos`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribucionasientos`
--

LOCK TABLES `distribucionasientos` WRITE;
/*!40000 ALTER TABLE `distribucionasientos` DISABLE KEYS */;
INSERT INTO `distribucionasientos` VALUES (1,32,'01T,02T,00,03T,04T|05T,06T,00,07T,08T|09T,10T,00,11T,12T|13T,14T,00,15T,16T|17T,18T,00,19T,20T|21T,22T,00,23T,24T|25T,26T,00,27T,28T|29T,30T,00,31T,32T|BM,00,CA,00,BH'),(2,24,'01T,02T,00,03T|04T,05T,00,06T|07T,08T,00,09T|10T,11T,00,12T|13T,14T,00,15T|16T,17T,00,18T|19T,20T,00,21T|22T,23T,00,24T|BM,00,CA,00,BH'),(3,40,'01T,02,00,03,04T|05,06,00,07,08|09,10,00,11,12|13T,14,00,15,16T|17,18,00,19,20|21,22,00,23,24|25T,26,00,27,28T|29,30,00,31,32|33,34,00,35,36|37,38,00,39,40|BM,00,CA,00,BH'),(4,40,'01,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16T|17,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,00,00|39,40,00,00,00|CA,00,00,00,BU'),(5,40,'01T,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16|17T,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,39,40|CA,00,00,00,BU'),(6,42,'05,06,00,07,08|09,10,00,11,12T|13,14,00,15,16|17,18,00,19,20|21T,22,00,00,PU|23,24,00,25,26|27,28,00,29,30T|31,32,00,33,34|35,36,00,37,38|39,40,00,00,00|41,42,00,00,00|00,00,00,0C,BU');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factorpaqueteria`
--

LOCK TABLES `factorpaqueteria` WRITE;
/*!40000 ALTER TABLE `factorpaqueteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `factorpaqueteria` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  KEY `itinerario_index` (`nItinerario`,`nTramo`),
  CONSTRAINT `itinerario_ibfk_1` FOREIGN KEY (`nTramo`) REFERENCES `tramos` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itinerario`
--

LOCK TABLES `itinerario` WRITE;
/*!40000 ALTER TABLE `itinerario` DISABLE KEYS */;
INSERT INTO `itinerario` VALUES (1,1,1),(2,1,1),(3,1,1),(4,1,1),(5,1,1),(6,1,1),(7,1,1),(8,1,1),(2,2,2),(3,2,2),(4,2,2),(5,2,2),(6,2,2),(7,2,2),(8,2,2),(3,3,3),(4,3,3),(5,3,3),(6,3,3),(7,3,4),(8,3,6),(8,4,7),(4,4,8),(5,4,8),(6,4,8),(5,5,9),(6,5,9),(6,6,10),(12,1,11),(12,2,12),(13,1,12),(12,3,13),(13,2,13),(14,1,13),(12,4,14),(13,3,14),(14,2,14),(15,1,14),(10,1,15),(11,1,16),(9,2,17),(9,1,18),(9,3,19),(10,2,19),(11,2,19),(12,5,19),(13,4,19),(14,3,19),(15,2,19),(16,1,19),(9,4,20),(10,3,20),(11,3,20),(12,6,20),(13,5,20),(14,4,20),(15,3,20),(16,2,20),(17,1,20);
/*!40000 ALTER TABLE `itinerario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
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
  `model_type` varchar(255) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `deleted_at` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodos_vacacionales`
--

LOCK TABLES `periodos_vacacionales` WRITE;
/*!40000 ALTER TABLE `periodos_vacacionales` DISABLE KEYS */;
/*!40000 ALTER TABLE `periodos_vacacionales` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'users.index','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(2,'users.store','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(3,'users.edit','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(4,'users.update','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(5,'users.destroy','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(6,'users.addrol','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(7,'users.removerol','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(8,'users.editPermissions','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(9,'personas.update','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(10,'corridas.programadas.index','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(11,'corridas.programadas.store','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(12,'corridas.programadas.show','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(13,'corridas.programadas.destroy','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(14,'corridas.programadas.transfer','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(15,'corridas.programadas.storeTransfer','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(16,'corridas.disponibles.index','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(17,'corridas.disponibles.edit','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(18,'corridas.disponibles.update','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(19,'corridas.disponibles.puntosDeControl','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(20,'corridas.disponibles.despachar','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(21,'corridas.disponibles.guiaPasajeros','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(22,'corridas.vacaciones','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(23,'boletos.limbo.show','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(24,'boletos.limbo.reasignar','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(25,'personal.conductores.index','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(26,'personal.conductores.edit','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(27,'personal.conductores.update','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(28,'sesionesVenta.create','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(29,'sesionesVenta.update','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(30,'sesionesVenta.show','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(31,'tarifas.index','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(32,'tarifas.show','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(33,'tarifas.create','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(34,'tarifas.store','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(35,'tarifas.edit','web','2023-10-13 00:03:13','2023-10-13 00:03:13'),(36,'tarifas.update','web','2023-10-13 00:03:14','2023-10-13 00:03:14');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,'Jahaziel Aarón','Aguilera Castillo',12,'EI','2023-10-12','2023-10-12 12:03:17',NULL),(2,'ANGEL','ZAMORA DE JESUS',12,'EI','2023-10-12','2023-10-12 12:03:17',NULL),(3,'FRANCISCO JAVIER','ALVARADO LEMUS',12,'EI','2023-10-12','2023-10-12 12:03:17',NULL),(4,'PASCUAL','ESTEBAN GABRIEL',12,'EI','2023-10-12','2023-10-12 12:03:17',NULL),(5,'JESUS','CORNEJO MAULE',12,NULL,'2023-10-12','2023-10-12 12:03:17',NULL),(6,'sergio','medrano',8,'EI','2023-10-12','2023-10-12 12:03:17',NULL);
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas_estados`
--

DROP TABLE IF EXISTS `personas_estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personas_estados` (
  `aClave` varchar(2) NOT NULL,
  `descripcion` varchar(16) DEFAULT NULL,
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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` VALUES (1,'ES','Desc INSEN',12,NULL,NULL,NULL,NULL,NULL,'2022-09-01','2022-12-31','2023-10-12',NULL,'2023-10-12 18:03:17','2023-10-12 18:03:17',NULL);
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
  KEY `registropasopuntos_index` (`nCorrida`,`nConsecutivo`),
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
-- Table structure for table `remitentes`
--

DROP TABLE IF EXISTS `remitentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remitentes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `RFC` varchar(13) DEFAULT NULL,
  `CURP` varchar(18) DEFAULT NULL,
  `telefono1` varchar(12) DEFAULT NULL,
  `telefono2` varchar(12) DEFAULT NULL,
  `nombres` varchar(30) DEFAULT NULL,
  `apellidos` varchar(30) DEFAULT NULL,
  `correo` varchar(40) DEFAULT NULL,
  `calle` varchar(60) DEFAULT NULL,
  `numExt` varchar(6) DEFAULT NULL,
  `numInt` varchar(6) DEFAULT NULL,
  `colonia` varchar(60) DEFAULT NULL,
  `CP` varchar(6) DEFAULT NULL,
  `municipio` varchar(60) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `estado` varchar(34) DEFAULT NULL,
  `pais` varchar(34) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `nombres` (`nombres`,`apellidos`,`correo`),
  FULLTEXT KEY `CURP` (`CURP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remitentes`
--

LOCK TABLES `remitentes` WRITE;
/*!40000 ALTER TABLE `remitentes` DISABLE KEYS */;
/*!40000 ALTER TABLE `remitentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
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
INSERT INTO `roles` VALUES (1,'Admin','web','2023-10-13 00:03:14','2023-10-13 00:03:14'),(2,'publicoGeneral','web','2023-10-13 00:03:14','2023-10-13 00:03:14'),(3,'servicios','web','2023-10-13 00:03:14','2023-10-13 00:03:14'),(4,'conductor','web','2023-10-13 00:03:14','2023-10-13 00:03:14');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serviciosabordo`
--

DROP TABLE IF EXISTS `serviciosabordo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviciosabordo` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(30) NOT NULL,
  `imagen` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serviciosabordo`
--

LOCK TABLES `serviciosabordo` WRITE;
/*!40000 ALTER TABLE `serviciosabordo` DISABLE KEYS */;
INSERT INTO `serviciosabordo` VALUES (1,'Aire acondicinado',''),(2,'Audio',''),(3,'Baños separados','Banos Separados.png'),(4,'Cafetera',''),(5,'Pantallas',''),(6,'Ubicación',''),(7,'Venta a bordo',''),(8,'Wifi',''),(9,'Baño hombres','Bano_h.png'),(10,'Baño mujeres','Bano_m.png'),(11,'Aire acondicinado',''),(12,'Audio',''),(13,'Baños separados','Banos Separados.png'),(14,'Cafetera',''),(15,'Pantallas',''),(16,'Ubicación',''),(17,'Venta a bordo',''),(18,'Wifi',''),(19,'Baño hombres','Bano_h.png'),(20,'Baño mujeres','Bano_m.png');
/*!40000 ALTER TABLE `serviciosabordo` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOrigen` (`nOrigen`),
  KEY `nDestino` (`nDestino`),
  KEY `nTipoServicio` (`nTipoServicio`),
  KEY `tarifastramos_index` (`nOrigen`,`nDestino`,`nTipoServicio`,`fAplicacion`),
  CONSTRAINT `tarifastramos_ibfk_1` FOREIGN KEY (`nOrigen`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `tarifastramos_ibfk_2` FOREIGN KEY (`nDestino`) REFERENCES `oficinas` (`nNumero`),
  CONSTRAINT `tarifastramos_ibfk_3` FOREIGN KEY (`nTipoServicio`) REFERENCES `tiposervicio` (`nNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `hwid` text NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOficina` (`nOficina`),
  CONSTRAINT `terminales_ibfk_1` FOREIGN KEY (`nOficina`) REFERENCES `oficinas` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminales`
--

LOCK TABLES `terminales` WRITE;
/*!40000 ALTER TABLE `terminales` DISABLE KEYS */;
INSERT INTO `terminales` VALUES (1,'desconocida',13,'El usuario ingr',''),(2,'Venta sitio web',13,'parhikuni.com',''),(3,'DTI',12,'para pruebas','34');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  KEY `tiposervicio_index` (`nNumero`,`aClave`),
  CONSTRAINT `tiposervicio_ibfk_1` FOREIGN KEY (`nDistribucionAsientos`) REFERENCES `distribucionasientos` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposervicio`
--

LOCK TABLES `tiposervicio` WRITE;
/*!40000 ALTER TABLE `tiposervicio` DISABLE KEYS */;
INSERT INTO `tiposervicio` VALUES (1,'PL','Platinum',2,8,8),(2,'UL','Ultra',3,7,0),(3,'EX','Express',4,6,0),(4,'PC','Premium Class',5,6,0),(5,'CP','Business Class',5,7,0);
/*!40000 ALTER TABLE `tiposervicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposervicioabordo`
--

DROP TABLE IF EXISTS `tiposervicioabordo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tiposervicioabordo` (
  `tiposervicio_id` int(10) unsigned NOT NULL,
  `servicioabordo_id` smallint(5) unsigned NOT NULL,
  KEY `tiposervicio_id` (`tiposervicio_id`),
  KEY `servicioabordo_id` (`servicioabordo_id`),
  CONSTRAINT `tiposervicioabordo_ibfk_1` FOREIGN KEY (`tiposervicio_id`) REFERENCES `tiposervicio` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `tiposervicioabordo_ibfk_2` FOREIGN KEY (`servicioabordo_id`) REFERENCES `serviciosabordo` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposervicioabordo`
--

LOCK TABLES `tiposervicioabordo` WRITE;
/*!40000 ALTER TABLE `tiposervicioabordo` DISABLE KEYS */;
INSERT INTO `tiposervicioabordo` VALUES (1,2),(1,4),(1,6),(1,8),(1,10),(1,11),(2,2),(2,4),(2,6),(3,2),(3,4),(3,6),(4,2),(4,4),(4,6),(5,2),(5,4),(5,6);
/*!40000 ALTER TABLE `tiposervicioabordo` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='CO = Boleto Confirmado\r\nAB = Boleto Abierto\r\nMA = Boleto Manual\r\nPC = Paqueteria Comercial\r\nPI = Paqueteria Interna\r\nEE = Exceso equipaje\r\nGE = Guarda equipaje\r\nBI = Boleto Internet\r\nBA = Boleto Agencia\r\nBW = Boleto WebServices\r\nAP = Abono Paqueteria';
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramos`
--

LOCK TABLES `tramos` WRITE;
/*!40000 ALTER TABLE `tramos` DISABLE KEYS */;
INSERT INTO `tramos` VALUES (1,8,10,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(2,10,5,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(3,5,1,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(4,5,2,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(5,5,7,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(6,5,6,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(7,6,11,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(8,1,3,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(9,3,9,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(10,9,4,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(11,4,9,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(12,9,3,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(13,3,1,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(14,1,5,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(15,2,5,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(16,7,5,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(17,6,5,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(18,11,6,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(19,5,10,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(20,10,8,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(21,8,5,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(22,8,1,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(23,8,3,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(24,10,5,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(25,10,1,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(26,10,3,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(27,5,3,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(28,2,5,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(29,2,10,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(30,2,8,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00'),(31,5,8,10,10,1,'2023-10-13 00:03:17','2023-10-13 00:03:17','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `tramos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venta` (
  `nNumero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nSesion` int(10) unsigned NOT NULL,
  `nCorridaIda` bigint(20) unsigned DEFAULT NULL,
  `nCorridaRegreso` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nSesion` (`nSesion`),
  KEY `nCorridaIda` (`nCorridaIda`),
  KEY `nCorridaRegreso` (`nCorridaRegreso`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`nSesion`) REFERENCES `sesiones` (`nNumero`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`nCorridaIda`) REFERENCES `corridasdisponibles` (`nNumero`) ON UPDATE CASCADE,
  CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`nCorridaRegreso`) REFERENCES `corridasdisponibles` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!50001 CREATE VIEW `vw_iti_tra` AS SELECT
 1 AS `itinerario`,
  1 AS `iti_consecutivo`,
  1 AS `tra_consecutivo`,
  1 AS `tramo`,
  1 AS `tra_origen`,
  1 AS `tra_destino` */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_iti_tra`
--

/*!50001 DROP VIEW IF EXISTS `vw_iti_tra`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_iti_tra` AS select `iti`.`nItinerario` AS `itinerario`,`iti`.`nConsecutivo` AS `iti_consecutivo`,`cadatramo`.`nConsecutivo` AS `tra_consecutivo`,`tra`.`nNumero` AS `tramo`,`tra`.`nOrigen` AS `tra_origen`,`cadatramo`.`nDestino` AS `tra_destino` from ((`itinerario` `iti` join `tramos` `tra` on(`tra`.`nNumero` = `iti`.`nTramo`)) join (select `itisub`.`nItinerario` AS `nItinerario`,`itisub`.`nConsecutivo` AS `nConsecutivo`,`tramsub`.`nOrigen` AS `nOrigen`,`tramsub`.`nDestino` AS `nDestino` from (`itinerario` `itisub` join `tramos` `tramsub` on(`tramsub`.`nNumero` = `itisub`.`nTramo`))) `cadatramo` on(`cadatramo`.`nItinerario` = `iti`.`nItinerario` and `cadatramo`.`nConsecutivo` >= `iti`.`nConsecutivo`)) where `tra`.`nOrigen` <> `cadatramo`.`nDestino` order by `iti`.`nItinerario`,`iti`.`nConsecutivo` */;
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

-- Dump completed on 2023-10-12 12:19:16
