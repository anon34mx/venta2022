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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autobuses`
--

LOCK TABLES `autobuses` WRITE;
/*!40000 ALTER TABLE `autobuses` DISABLE KEYS */;
INSERT INTO `autobuses` VALUES (1,'5005',5,6),(2,'5006',5,6),(3,'5401',5,3),(4,'5402',5,3),(5,'5403',5,3),(6,'5404',5,3),(7,'5405',5,3),(8,'5406',5,3),(9,'5407',5,3),(10,'5408',5,3),(11,'5409',5,3),(12,'5410',5,3),(13,'5411',5,3),(14,'5425',5,3),(15,'5426',5,3),(16,'5427',5,3),(17,'5428',5,3),(18,'5429',5,3),(19,'5430',5,3),(20,'5431',5,3),(21,'5432',5,3),(22,'5433',5,3),(23,'5434',5,3),(24,'5435',5,3),(25,'5436',5,3),(26,'5437',5,3),(27,'5438',5,3),(28,'8014',5,1),(29,'9001',2,2),(30,'9002',2,2),(31,'9003',2,2),(32,'9004',2,2),(33,'9005',2,2),(34,'9007',2,2),(35,'9008',2,2),(36,'9009',2,2),(37,'9010',2,2),(38,'7001',2,2),(39,'7002',2,2),(40,'7003',2,2),(41,'7004',2,2),(42,'7005',2,2),(43,'7008',2,2),(44,'7009',2,2),(45,'7010',2,2),(46,'7011',2,2),(47,'7012',2,2),(48,'5412',3,3),(49,'5413',1,1),(50,'5414',1,1),(51,'5415',1,1),(52,'5416',1,1),(53,'5417',1,1),(54,'5418',1,1),(55,'5419',1,1),(56,'5420',1,1),(57,'5421',1,1),(58,'5422',1,1),(59,'5423',1,1),(60,'5424',1,1),(61,'8001',1,1),(62,'8002',1,1),(63,'8003',1,1),(64,'8004',1,1),(65,'8005',1,1),(66,'8006',1,1),(67,'8007',1,1),(68,'8008',1,1),(69,'8009',1,1),(70,'8010',1,1),(71,'8011',1,1),(72,'8012',1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletoscancelados`
--

LOCK TABLES `boletoscancelados` WRITE;
/*!40000 ALTER TABLE `boletoscancelados` DISABLE KEYS */;
INSERT INTO `boletoscancelados` VALUES (1,1,14),(2,2,15),(3,1,20),(4,2,21),(5,16,22),(6,17,23);
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletosvendidos`
--

LOCK TABLES `boletosvendidos` WRITE;
/*!40000 ALTER TABLE `boletosvendidos` DISABLE KEYS */;
INSERT INTO `boletosvendidos` VALUES (14,1,11,0,'2023-05-13','12:00:00',8,7,'AD','EDUARDO ESPINOSA','2','CO',0.00,0.00,0.00,'VE','2023-05-11 19:09:32','2023-05-11 19:09:32',1),(15,1,11,0,'2023-05-13','12:00:00',8,7,'NI','JOSE ANTONIO BADIA','3','CO',0.00,0.00,0.00,'VE','2023-05-11 19:09:32','2023-05-11 19:09:32',1),(20,1,11,0,'2023-05-13','12:00:00',8,5,'AD','EDUARDO ESPINOSA','1','CO',0.00,0.00,0.00,'VE','2023-05-11 21:23:53','2023-05-11 21:23:53',1),(21,1,11,0,'2023-05-13','12:00:00',8,5,'NI','JOSE ANTONIO BADIA','4','CO',0.00,0.00,0.00,'VE','2023-05-11 21:23:53','2023-05-11 21:23:53',1),(22,2,12,0,'2023-05-14','12:00:00',8,10,'AD','ROBERTO ANDRADE','1','CO',0.00,0.00,0.00,'VE','2023-05-11 21:23:53','2023-05-11 21:23:53',1),(23,2,12,0,'2023-05-14','12:00:00',8,7,'AD','HUGO PEREZ','2','CO',0.00,0.00,0.00,'VE','2023-05-11 21:23:53','2023-05-11 21:23:53',1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
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
INSERT INTO `conductores` VALUES (1,2,'LIC007','2025-10-11','AC',1,'2023-05-02 15:58:14',NULL,NULL),(2,3,'LIC084','2028-03-08','AC',29,'2023-05-02 15:58:14',NULL,NULL),(3,4,'LIC026','2025-07-26','BA',39,'2023-05-02 15:58:14',NULL,NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridas_disponibles_historial`
--

LOCK TABLES `corridas_disponibles_historial` WRITE;
/*!40000 ALTER TABLE `corridas_disponibles_historial` DISABLE KEYS */;
INSERT INTO `corridas_disponibles_historial` VALUES (1,10,12,'D','B',1,'2023-05-11 18:57:11','2023-05-11 18:57:11',NULL),(2,10,12,'B','B',1,'2023-05-11 18:57:49','2023-05-11 18:57:49',NULL),(3,10,12,'B','B',1,'2023-05-11 19:01:08','2023-05-11 19:01:08',NULL),(4,10,12,'B','B',1,'2023-05-11 19:01:15','2023-05-11 19:01:15',NULL),(5,10,12,'B','B',1,'2023-05-11 19:01:24','2023-05-11 19:01:24',NULL),(6,10,12,'B','B',1,'2023-05-11 19:06:23','2023-05-11 19:06:23',NULL),(7,10,12,'B','B',1,'2023-05-11 19:08:30','2023-05-11 19:08:30',NULL),(8,10,12,'B','B',1,'2023-05-11 19:08:34','2023-05-11 19:08:34',NULL),(9,10,12,'B','B',1,'2023-05-11 19:08:46','2023-05-11 19:08:46',NULL),(10,10,12,'B','B',1,'2023-05-11 19:08:56','2023-05-11 19:08:56',NULL),(11,10,12,'B','B',1,'2023-05-11 19:09:15','2023-05-11 19:09:15',NULL),(12,10,12,'B','B',1,'2023-05-11 19:09:20','2023-05-11 19:09:20',NULL),(13,10,12,'B','B',1,'2023-05-11 19:09:32','2023-05-11 19:09:32',NULL),(14,10,12,'B','B',1,'2023-05-11 19:43:50','2023-05-11 19:43:50',NULL),(15,10,12,'B','B',1,'2023-05-11 21:23:13','2023-05-11 21:23:13',NULL),(16,10,12,'B','B',1,'2023-05-11 21:23:53','2023-05-11 21:23:53',NULL),(17,10,12,'B','B',1,'2023-05-11 21:27:03','2023-05-11 21:27:03',NULL),(18,10,12,'B','B',1,'2023-05-11 21:31:29','2023-05-11 21:31:29',NULL),(19,10,12,'B','B',1,'2023-05-11 21:32:09','2023-05-11 21:32:09',NULL),(20,10,12,'B','B',1,'2023-05-11 21:32:24','2023-05-11 21:32:24',NULL),(21,10,12,'B','B',1,'2023-05-11 21:32:39','2023-05-11 21:32:39',NULL),(22,10,12,'B','B',1,'2023-05-11 21:37:02','2023-05-11 21:37:02',NULL),(23,10,12,'B','B',1,'2023-05-11 21:38:34','2023-05-11 21:38:34',NULL),(24,10,12,'B','B',1,'2023-05-11 21:38:57','2023-05-11 21:38:57',NULL),(25,10,12,'B','B',1,'2023-05-11 21:39:13','2023-05-11 21:39:13',NULL),(26,10,12,'B','B',1,'2023-05-11 21:39:36','2023-05-11 21:39:36',NULL),(27,10,12,'B','B',1,'2023-05-11 21:39:59','2023-05-11 21:39:59',NULL),(28,10,12,'B','B',1,'2023-05-11 21:40:03','2023-05-11 21:40:03',NULL),(29,10,12,'B','B',1,'2023-05-11 21:40:21','2023-05-11 21:40:21',NULL),(30,10,12,'B','B',1,'2023-05-11 21:40:33','2023-05-11 21:40:33',NULL),(31,10,12,'B','B',1,'2023-05-11 21:40:50','2023-05-11 21:40:50',NULL),(32,10,12,'B','B',1,'2023-05-11 21:41:15','2023-05-11 21:41:15',NULL),(33,10,12,'B','B',1,'2023-05-11 21:42:20','2023-05-11 21:42:20',NULL),(34,10,12,'B','B',1,'2023-05-11 21:42:23','2023-05-11 21:42:23',NULL),(35,10,12,'B','B',1,'2023-05-11 21:42:27','2023-05-11 21:42:27',NULL),(36,10,12,'B','B',1,'2023-05-11 21:42:35','2023-05-11 21:42:35',NULL),(37,10,12,'B','B',1,'2023-05-11 21:42:45','2023-05-11 21:42:45',NULL),(38,10,12,'B','B',1,'2023-05-11 21:48:12','2023-05-11 21:48:12',NULL),(39,10,12,'B','B',1,'2023-05-11 21:48:30','2023-05-11 21:48:30',NULL),(40,10,12,'B','B',1,'2023-05-11 21:48:43','2023-05-11 21:48:43',NULL),(41,10,12,'B','B',1,'2023-05-11 21:49:05','2023-05-11 21:49:05',NULL),(42,10,12,'B','B',1,'2023-05-11 21:49:11','2023-05-11 21:49:11',NULL),(43,10,12,'B','B',1,'2023-05-11 21:49:31','2023-05-11 21:49:31',NULL),(44,10,12,'B','B',1,'2023-05-11 21:49:49','2023-05-11 21:49:49',NULL),(45,10,12,'B','B',1,'2023-05-11 21:50:10','2023-05-11 21:50:10',NULL),(46,10,12,'B','B',1,'2023-05-11 21:55:47','2023-05-11 21:55:47',NULL),(47,10,12,'B','B',1,'2023-05-11 21:59:34','2023-05-11 21:59:34',NULL),(48,10,12,'B','B',1,'2023-05-11 22:00:51','2023-05-11 22:00:51',NULL),(49,10,12,'B','B',1,'2023-05-11 22:06:12','2023-05-11 22:06:12',NULL),(50,10,12,'B','B',1,'2023-05-11 22:06:23','2023-05-11 22:06:23',NULL),(51,10,12,'B','B',1,'2023-05-11 22:06:57','2023-05-11 22:06:57',NULL),(52,10,12,'B','B',1,'2023-05-11 22:07:09','2023-05-11 22:07:09',NULL),(53,10,12,'B','B',1,'2023-05-11 22:07:26','2023-05-11 22:07:26',NULL),(54,10,12,'B','B',1,'2023-05-11 22:07:35','2023-05-11 22:07:35',NULL),(55,10,12,'B','B',1,'2023-05-11 22:07:44','2023-05-11 22:07:44',NULL),(56,10,12,'B','B',1,'2023-05-11 22:07:50','2023-05-11 22:07:50',NULL),(57,10,12,'B','B',1,'2023-05-11 22:08:02','2023-05-11 22:08:02',NULL),(58,10,12,'B','B',1,'2023-05-11 22:16:40','2023-05-11 22:16:40',NULL),(59,10,12,'B','B',1,'2023-05-11 22:20:44','2023-05-11 22:20:44',NULL),(60,10,12,'B','B',1,'2023-05-11 22:20:56','2023-05-11 22:20:56',NULL),(61,10,12,'B','B',1,'2023-05-11 22:21:08','2023-05-11 22:21:08',NULL),(62,10,12,'B','B',1,'2023-05-11 22:21:21','2023-05-11 22:21:21',NULL),(63,10,12,'B','B',1,'2023-05-11 22:21:31','2023-05-11 22:21:31',NULL),(64,10,12,'B','B',1,'2023-05-11 22:21:37','2023-05-11 22:21:37',NULL),(65,10,12,'B','B',1,'2023-05-11 22:28:25','2023-05-11 22:28:25',NULL),(66,10,12,'B','B',1,'2023-05-11 22:34:35','2023-05-11 22:34:35',NULL),(67,10,12,'B','B',1,'2023-05-11 22:47:41','2023-05-11 22:47:41',NULL),(68,10,12,'B','C',1,'2023-05-11 22:47:42','2023-05-11 22:47:42',NULL),(69,10,12,'C','C',1,'2023-05-11 22:55:47','2023-05-11 22:55:47',NULL),(70,10,12,'C','C',1,'2023-05-11 22:57:32','2023-05-11 22:57:32',NULL),(71,10,12,'C','C',1,'2023-05-11 22:57:38','2023-05-11 22:57:38',NULL),(72,10,12,'C','C',1,'2023-05-11 22:57:38','2023-05-11 22:57:38',NULL),(73,10,12,'C','B',1,'2023-05-11 23:00:33','2023-05-11 23:00:33',NULL),(74,10,12,'B','C',1,'2023-05-11 23:00:34','2023-05-11 23:00:34',NULL),(75,11,12,'D','C',1,'2023-05-11 23:01:12','2023-05-11 23:01:12',NULL),(76,11,12,'C','C',1,'2023-05-11 23:01:20','2023-05-11 23:01:20',NULL),(77,11,12,'C','C',1,'2023-05-11 23:01:35','2023-05-11 23:01:35',NULL),(78,11,12,'C','B',1,'2023-05-11 23:02:25','2023-05-11 23:02:25',NULL),(79,11,12,'B','C',1,'2023-05-11 23:02:25','2023-05-11 23:02:25',NULL),(80,11,12,'C','B',1,'2023-05-11 23:09:30','2023-05-11 23:09:30',NULL),(81,11,12,'B','C',1,'2023-05-11 23:09:30','2023-05-11 23:09:30',NULL),(82,11,12,'C','B',1,'2023-05-11 23:10:41','2023-05-11 23:10:41',NULL),(83,11,12,'B','C',1,'2023-05-11 23:10:41','2023-05-11 23:10:41',NULL),(84,11,12,'C','B',1,'2023-05-11 23:11:24','2023-05-11 23:11:24',NULL),(85,11,12,'B','B',1,'2023-05-11 23:11:33','2023-05-11 23:11:33',NULL),(86,11,12,'B','B',1,'2023-05-11 23:24:06','2023-05-11 23:24:06',NULL),(87,11,12,'B','B',1,'2023-05-11 23:24:24','2023-05-11 23:24:24',NULL),(88,11,12,'B','B',1,'2023-05-11 23:24:40','2023-05-11 23:24:40',NULL),(89,11,12,'B','B',1,'2023-05-11 23:24:52','2023-05-11 23:24:52',NULL),(90,11,12,'B','B',1,'2023-05-11 23:25:06','2023-05-11 23:25:06',NULL),(91,11,12,'B','B',1,'2023-05-11 23:25:21','2023-05-11 23:25:21',NULL),(92,11,12,'B','B',1,'2023-05-11 23:25:44','2023-05-11 23:25:44',NULL),(93,11,12,'B','B',1,'2023-05-11 23:25:56','2023-05-11 23:25:56',NULL),(94,11,12,'B','B',1,'2023-05-11 23:29:20','2023-05-11 23:29:20',NULL),(95,11,12,'B','C',1,'2023-05-11 23:29:21','2023-05-11 23:29:21',NULL),(96,11,12,'D','B',1,'2023-05-11 23:30:01','2023-05-11 23:30:01',NULL),(97,11,12,'B','B',1,'2023-05-12 16:07:38','2023-05-12 16:07:38',NULL),(98,11,12,'B','B',1,'2023-05-12 16:10:18','2023-05-12 16:10:18',NULL),(99,11,12,'B','B',1,'2023-05-17 23:46:12','2023-05-17 23:46:12',NULL),(100,11,12,'B','B',1,'2023-05-17 23:46:40','2023-05-17 23:46:40',NULL);
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
  CONSTRAINT `corridas_versiones_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `corridas_versiones_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasdisponibles`
--

LOCK TABLES `corridasdisponibles` WRITE;
/*!40000 ALTER TABLE `corridasdisponibles` DISABLE KEYS */;
INSERT INTO `corridasdisponibles` VALUES (1,1,1,1,'2023-05-03','12:00:00','D',49,NULL,NULL,NULL,NULL),(2,1,1,1,'2023-05-04','12:00:00','D',49,NULL,NULL,NULL,'2023-05-03 17:17:18'),(3,1,1,1,'2023-05-05','12:00:00','D',49,NULL,NULL,NULL,NULL),(4,1,1,1,'2023-05-06','12:00:00','D',49,NULL,NULL,NULL,NULL),(5,1,1,1,'2023-05-07','12:00:00','D',49,NULL,NULL,NULL,NULL),(6,1,1,1,'2023-05-08','12:00:00','D',49,NULL,NULL,NULL,NULL),(7,1,1,1,'2023-05-09','12:00:00','D',49,NULL,NULL,NULL,NULL),(8,1,1,1,'2023-05-10','12:00:00','D',49,NULL,NULL,NULL,NULL),(9,1,1,1,'2023-05-11','12:00:00','D',49,NULL,NULL,NULL,'2023-05-10 19:22:14'),(10,1,1,1,'2023-05-12','12:00:00','C',49,NULL,NULL,NULL,'2023-05-11 23:00:34'),(11,1,1,1,'2023-05-13','12:00:00','B',49,NULL,NULL,NULL,'2023-05-11 23:30:01'),(12,1,1,1,'2023-05-14','12:00:00','D',49,NULL,NULL,NULL,NULL),(13,1,1,1,'2023-05-15','12:00:00','D',49,NULL,NULL,NULL,NULL),(14,1,1,1,'2023-05-16','12:00:00','D',49,NULL,NULL,NULL,NULL),(15,1,1,1,'2023-05-17','12:00:00','D',49,NULL,NULL,NULL,NULL),(16,1,1,1,'2023-05-18','12:00:00','D',49,NULL,NULL,NULL,NULL),(17,1,1,1,'2023-05-19','12:00:00','D',49,NULL,NULL,NULL,NULL),(18,1,1,1,'2023-05-20','12:00:00','D',49,NULL,NULL,NULL,NULL),(19,1,1,1,'2023-05-21','12:00:00','D',49,NULL,NULL,NULL,NULL),(20,1,1,1,'2023-05-22','12:00:00','D',49,NULL,NULL,NULL,NULL),(21,1,1,1,'2023-05-23','12:00:00','D',49,NULL,NULL,NULL,NULL),(22,1,1,1,'2023-05-24','12:00:00','D',49,NULL,NULL,NULL,NULL),(23,1,1,1,'2023-05-25','12:00:00','D',49,NULL,NULL,NULL,NULL),(24,1,1,1,'2023-05-26','12:00:00','D',49,NULL,NULL,NULL,NULL),(25,1,1,1,'2023-05-27','12:00:00','D',49,NULL,NULL,NULL,NULL),(26,1,1,1,'2023-05-28','12:00:00','D',49,NULL,NULL,NULL,NULL),(27,1,1,1,'2023-05-29','12:00:00','D',49,NULL,NULL,NULL,NULL),(28,1,1,1,'2023-05-30','12:00:00','D',49,NULL,NULL,NULL,NULL),(29,1,1,1,'2023-05-31','12:00:00','D',49,NULL,NULL,NULL,NULL),(30,1,1,1,'2023-06-01','12:00:00','D',49,NULL,NULL,NULL,NULL),(31,1,1,1,'2023-06-02','12:00:00','D',49,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasprogramadas`
--

LOCK TABLES `corridasprogramadas` WRITE;
/*!40000 ALTER TABLE `corridasprogramadas` DISABLE KEYS */;
INSERT INTO `corridasprogramadas` VALUES (1,1,1,'12:00:00',1,1,1,1,1,1,1,'2023-05-03','2027-05-03',1,NULL,'2023-05-03 21:51:44','2023-05-03 15:51:44');
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
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidad`
--

LOCK TABLES `disponibilidad` WRITE;
/*!40000 ALTER TABLE `disponibilidad` DISABLE KEYS */;
INSERT INTO `disponibilidad` VALUES (1,1,8,5,'2023-05-03','12:01:00','2023-05-03','12:00:00'),(2,1,8,7,'2023-05-03','12:02:00','2023-05-03','12:00:00'),(3,1,5,7,'2023-05-03','12:02:00','2023-05-03','12:02:00'),(4,2,8,5,'2023-05-04','12:01:00','2023-05-04','12:00:00'),(5,2,8,7,'2023-05-04','12:02:00','2023-05-04','12:00:00'),(6,2,5,7,'2023-05-04','12:02:00','2023-05-04','12:02:00'),(7,3,8,5,'2023-05-05','12:01:00','2023-05-05','12:00:00'),(8,3,8,7,'2023-05-05','12:02:00','2023-05-05','12:00:00'),(9,3,5,7,'2023-05-05','12:02:00','2023-05-05','12:02:00'),(10,4,8,5,'2023-05-06','12:01:00','2023-05-06','12:00:00'),(11,4,8,7,'2023-05-06','12:02:00','2023-05-06','12:00:00'),(12,4,5,7,'2023-05-06','12:02:00','2023-05-06','12:02:00'),(13,5,8,5,'2023-05-07','12:01:00','2023-05-07','12:00:00'),(14,5,8,7,'2023-05-07','12:02:00','2023-05-07','12:00:00'),(15,5,5,7,'2023-05-07','12:02:00','2023-05-07','12:02:00'),(16,6,8,5,'2023-05-08','12:01:00','2023-05-08','12:00:00'),(17,6,8,7,'2023-05-08','12:02:00','2023-05-08','12:00:00'),(18,6,5,7,'2023-05-08','12:02:00','2023-05-08','12:02:00'),(19,7,8,5,'2023-05-09','12:01:00','2023-05-09','12:00:00'),(20,7,8,7,'2023-05-09','12:02:00','2023-05-09','12:00:00'),(21,7,5,7,'2023-05-09','12:02:00','2023-05-09','12:02:00'),(22,8,8,5,'2023-05-10','12:01:00','2023-05-10','12:00:00'),(23,8,8,7,'2023-05-10','12:02:00','2023-05-10','12:00:00'),(24,8,5,7,'2023-05-10','12:02:00','2023-05-10','12:02:00'),(25,9,8,5,'2023-05-11','12:01:00','2023-05-11','12:00:00'),(26,9,8,7,'2023-05-11','12:02:00','2023-05-11','12:00:00'),(27,9,5,7,'2023-05-11','12:02:00','2023-05-11','12:02:00'),(28,10,8,5,'2023-05-12','12:01:00','2023-05-12','12:00:00'),(29,10,8,7,'2023-05-12','12:02:00','2023-05-12','12:00:00'),(30,10,5,7,'2023-05-12','12:02:00','2023-05-12','12:02:00'),(31,11,8,5,'2023-05-13','12:01:00','2023-05-13','12:00:00'),(32,11,8,7,'2023-05-13','12:02:00','2023-05-13','12:00:00'),(33,11,5,7,'2023-05-13','12:02:00','2023-05-13','12:02:00'),(34,12,8,5,'2023-05-14','12:01:00','2023-05-14','12:00:00'),(35,12,8,7,'2023-05-14','12:02:00','2023-05-14','12:00:00'),(36,12,5,7,'2023-05-14','12:02:00','2023-05-14','12:02:00'),(37,13,8,5,'2023-05-15','12:01:00','2023-05-15','12:00:00'),(38,13,8,7,'2023-05-15','12:02:00','2023-05-15','12:00:00'),(39,13,5,7,'2023-05-15','12:02:00','2023-05-15','12:02:00'),(40,14,8,5,'2023-05-16','12:01:00','2023-05-16','12:00:00'),(41,14,8,7,'2023-05-16','12:02:00','2023-05-16','12:00:00'),(42,14,5,7,'2023-05-16','12:02:00','2023-05-16','12:02:00'),(43,15,8,5,'2023-05-17','12:01:00','2023-05-17','12:00:00'),(44,15,8,7,'2023-05-17','12:02:00','2023-05-17','12:00:00'),(45,15,5,7,'2023-05-17','12:02:00','2023-05-17','12:02:00'),(46,16,8,5,'2023-05-18','12:01:00','2023-05-18','12:00:00'),(47,16,8,7,'2023-05-18','12:02:00','2023-05-18','12:00:00'),(48,16,5,7,'2023-05-18','12:02:00','2023-05-18','12:02:00'),(49,17,8,5,'2023-05-19','12:01:00','2023-05-19','12:00:00'),(50,17,8,7,'2023-05-19','12:02:00','2023-05-19','12:00:00'),(51,17,5,7,'2023-05-19','12:02:00','2023-05-19','12:02:00'),(52,18,8,5,'2023-05-20','12:01:00','2023-05-20','12:00:00'),(53,18,8,7,'2023-05-20','12:02:00','2023-05-20','12:00:00'),(54,18,5,7,'2023-05-20','12:02:00','2023-05-20','12:02:00'),(55,19,8,5,'2023-05-21','12:01:00','2023-05-21','12:00:00'),(56,19,8,7,'2023-05-21','12:02:00','2023-05-21','12:00:00'),(57,19,5,7,'2023-05-21','12:02:00','2023-05-21','12:02:00'),(58,20,8,5,'2023-05-22','12:01:00','2023-05-22','12:00:00'),(59,20,8,7,'2023-05-22','12:02:00','2023-05-22','12:00:00'),(60,20,5,7,'2023-05-22','12:02:00','2023-05-22','12:02:00'),(61,21,8,5,'2023-05-23','12:01:00','2023-05-23','12:00:00'),(62,21,8,7,'2023-05-23','12:02:00','2023-05-23','12:00:00'),(63,21,5,7,'2023-05-23','12:02:00','2023-05-23','12:02:00'),(64,22,8,5,'2023-05-24','12:01:00','2023-05-24','12:00:00'),(65,22,8,7,'2023-05-24','12:02:00','2023-05-24','12:00:00'),(66,22,5,7,'2023-05-24','12:02:00','2023-05-24','12:02:00'),(67,23,8,5,'2023-05-25','12:01:00','2023-05-25','12:00:00'),(68,23,8,7,'2023-05-25','12:02:00','2023-05-25','12:00:00'),(69,23,5,7,'2023-05-25','12:02:00','2023-05-25','12:02:00'),(70,24,8,5,'2023-05-26','12:01:00','2023-05-26','12:00:00'),(71,24,8,7,'2023-05-26','12:02:00','2023-05-26','12:00:00'),(72,24,5,7,'2023-05-26','12:02:00','2023-05-26','12:02:00'),(73,25,8,5,'2023-05-27','12:01:00','2023-05-27','12:00:00'),(74,25,8,7,'2023-05-27','12:02:00','2023-05-27','12:00:00'),(75,25,5,7,'2023-05-27','12:02:00','2023-05-27','12:02:00'),(76,26,8,5,'2023-05-28','12:01:00','2023-05-28','12:00:00'),(77,26,8,7,'2023-05-28','12:02:00','2023-05-28','12:00:00'),(78,26,5,7,'2023-05-28','12:02:00','2023-05-28','12:02:00'),(79,27,8,5,'2023-05-29','12:01:00','2023-05-29','12:00:00'),(80,27,8,7,'2023-05-29','12:02:00','2023-05-29','12:00:00'),(81,27,5,7,'2023-05-29','12:02:00','2023-05-29','12:02:00'),(82,28,8,5,'2023-05-30','12:01:00','2023-05-30','12:00:00'),(83,28,8,7,'2023-05-30','12:02:00','2023-05-30','12:00:00'),(84,28,5,7,'2023-05-30','12:02:00','2023-05-30','12:02:00'),(85,29,8,5,'2023-05-31','12:01:00','2023-05-31','12:00:00'),(86,29,8,7,'2023-05-31','12:02:00','2023-05-31','12:00:00'),(87,29,5,7,'2023-05-31','12:02:00','2023-05-31','12:02:00'),(88,30,8,5,'2023-06-01','12:01:00','2023-06-01','12:00:00'),(89,30,8,7,'2023-06-01','12:02:00','2023-06-01','12:00:00'),(90,30,5,7,'2023-06-01','12:02:00','2023-06-01','12:02:00'),(91,31,8,5,'2023-06-02','12:01:00','2023-06-02','12:00:00'),(92,31,8,7,'2023-06-02','12:02:00','2023-06-02','12:00:00'),(93,31,5,7,'2023-06-02','12:02:00','2023-06-02','12:02:00');
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
  CONSTRAINT `dispAsientos_user_id_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `disponibilidadasientos_ibfk_1` FOREIGN KEY (`nDisponibilidad`) REFERENCES `disponibilidad` (`nNumero`),
  CONSTRAINT `disponibilidadasientos_ibfk_2` FOREIGN KEY (`nBoleto`) REFERENCES `boletosvendidos` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidadasientos`
--

LOCK TABLES `disponibilidadasientos` WRITE;
/*!40000 ALTER TABLE `disponibilidadasientos` DISABLE KEYS */;
INSERT INTO `disponibilidadasientos` VALUES (1,28,1,'VE','2023-05-12 12:00:00',1,1),(2,29,1,'VE','2023-05-12 12:00:00',1,1),(3,30,1,'VE','2023-05-12 12:00:00',1,1),(4,28,2,'VE','2023-05-12 12:00:00',2,1),(5,29,2,'VE','2023-05-12 12:00:00',2,1),(6,30,2,'VE','2023-05-12 12:00:00',2,1),(10,31,2,'VE','2023-05-11 13:09:32',14,1),(11,32,2,'VE','2023-05-11 13:09:32',14,1),(12,33,2,'VE','2023-05-11 13:09:32',14,1),(13,31,3,'VE','2023-05-11 13:09:32',15,1),(14,32,3,'VE','2023-05-11 13:09:32',15,1),(16,28,3,'VE','2023-05-12 12:00:00',16,1),(17,29,3,'VE','2023-05-12 12:00:00',16,1),(18,30,3,'VE','2023-05-12 12:00:00',16,1),(19,28,4,'VE','2023-05-12 12:00:00',17,1),(20,29,4,'VE','2023-05-12 12:00:00',17,1),(21,30,4,'VE','2023-05-12 12:00:00',17,1),(22,31,1,'VE','2023-05-11 15:23:53',20,1),(23,32,1,'VE','2023-05-11 15:23:53',20,1),(24,33,1,'VE','2023-05-11 15:23:53',20,1),(25,31,4,'VE','2023-05-11 15:23:53',21,1),(26,32,4,'VE','2023-05-11 15:23:53',21,1),(27,33,4,'VE','2023-05-11 15:23:53',21,1),(28,34,1,'VE','2023-05-11 15:23:53',22,1),(29,35,1,'VE','2023-05-11 15:23:53',22,1),(30,36,1,'VE','2023-05-11 15:23:53',22,1),(31,34,2,'VE','2023-05-11 15:23:53',23,1),(32,35,2,'VE','2023-05-11 15:23:53',23,1),(33,36,2,'VE','2023-05-11 15:23:53',23,1);
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
INSERT INTO `distribucionasientos` VALUES (1,4,'01T,02T,00,03T,04T|05T,06T,00,07T,08T|09T,10T,00,11T,12T|13T,14T,00,15T,16T|17T,18T,00,19T,20T|21T,22T,00,23T,24T|25T,26T,00,27T,28T|29T,30T,00,31T,32T|BM,00,CA,00,BH'),(2,24,'01T,02T,00,00,03T|04T,05T,00,00,06T|07T,08T,00,00,09T|10T,11T,00,00,12T|13T,14T,00,00,15T|16T,17T,00,00,18T|19T,20T,00,00,21T|22T,23T,00,00,24T|BM,00,CA,00,BH'),(3,40,'01T,02,03,04T|05,06,07,08|09,10,11,12|13T,14,15,16T|17,18,19,20|21,22,23,24|25T,26,27,28T|29,30,31,32|33,34,35,36|37,38,39,40|BM,00,CA,00,BH'),(4,40,'01,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16T|17,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,00,00|39,40,00,00,00|CA,00,00,00,BU'),(5,40,'01T,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16|17T,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,39,40|CA,00,00,00,BU'),(6,42,'05,06,00,07,08|09,10,00,11,12T|13,14,00,15,16|17,18,00,19,20|21T,22,00,00,PU|23,24,00,25,26|27,28,00,29,30T|31,32,00,33,34|35,36,00,37,38|39,40,00,00,00|41,42,00,00,00|00,00,00,0C,BU');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itinerario`
--

LOCK TABLES `itinerario` WRITE;
/*!40000 ALTER TABLE `itinerario` DISABLE KEYS */;
INSERT INTO `itinerario` VALUES (1,1,1),(1,2,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2022_09_23_183212_create_permission_tables',1),(6,'2023_05_02_214854_add_session_id_to_users_table',1),(7,'2023_05_02_215712_add_session_id_to_users_table',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'users.index','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(2,'users.store','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(3,'users.edit','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(4,'users.update','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(5,'users.destroy','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(6,'users.addrol','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(7,'users.removerol','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(8,'users.editPermissions','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(9,'personas.update','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(10,'corridas.programadas.index','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(11,'corridas.programadas.store','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(12,'corridas.programadas.show','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(13,'corridas.programadas.destroy','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(14,'corridas.programadas.transfer','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(15,'corridas.programadas.storeTransfer','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(16,'corridas.disponibles.index','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(17,'corridas.disponibles.edit','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(18,'corridas.disponibles.update','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(19,'corridas.disponibles.puntosDeControl','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(20,'corridas.disponibles.despachar','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(21,'corridas.disponibles.guiaPasajeros','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(22,'corridas.vacaciones','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(23,'boletos.limbo.show','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(24,'personal.conductores.index','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(25,'personal.conductores.edit','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(26,'personal.conductores.update','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(27,'sesionesVenta.create','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(28,'sesionesVenta.update','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(29,'sesionesVenta.show','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(30,'tarifas.index','web','2023-05-03 03:58:03','2023-05-03 03:58:03'),(31,'tarifas.show','web','2023-05-03 03:58:04','2023-05-03 03:58:04'),(32,'tarifas.create','web','2023-05-03 03:58:04','2023-05-03 03:58:04'),(33,'tarifas.store','web','2023-05-03 03:58:04','2023-05-03 03:58:04'),(34,'tarifas.edit','web','2023-05-03 03:58:04','2023-05-03 03:58:04'),(35,'tarifas.update','web','2023-05-03 03:58:04','2023-05-03 03:58:04'),(36,'boletos.limbo.reasignar','web','2023-05-08 22:35:05','2023-05-08 22:35:05');
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
INSERT INTO `personas` VALUES (1,'Jahaziel Aarón','Aguilera Castillo',12,'EI','2023-05-02','2023-05-02 15:58:14',NULL),(2,'ANGEL','ZAMORA DE JESUS',12,'EI','2023-05-02','2023-05-02 15:58:14',NULL),(3,'FRANCISCO JAVIER','ALVARADO LEMUS',12,'EI','2023-05-02','2023-05-02 15:58:14',NULL),(4,'PASCUAL','ESTEBAN GABRIEL',12,'EI','2023-05-02','2023-05-02 15:58:14',NULL),(5,'JESUS','CORNEJO MAULE',12,NULL,'2023-05-02','2023-05-02 15:58:14',NULL),(6,'sergio','medrano',8,'EI','2023-05-02','2023-05-02 15:58:14',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` VALUES (1,'ES','Desc INSEN',12,NULL,NULL,NULL,NULL,NULL,'2022-09-01','2022-12-31','2023-05-02',NULL);
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
INSERT INTO `role_has_permissions` VALUES (1,1),(2,1),(3,1),(3,2),(3,3),(4,1),(4,2),(4,3),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(10,3),(11,1),(11,3),(12,1),(12,3),(13,1),(13,3),(14,1),(14,3),(15,1),(15,3),(16,1),(16,3),(17,1),(17,3),(18,1),(18,3),(19,1),(20,1),(20,3),(21,1),(21,3),(22,1),(23,1),(24,1),(24,3),(25,1),(25,3),(26,1),(26,3),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1);
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
INSERT INTO `roles` VALUES (1,'Admin','web','2023-05-03 03:58:04','2023-05-03 03:58:04'),(2,'publicoGeneral','web','2023-05-03 03:58:04','2023-05-03 03:58:04'),(3,'servicios','web','2023-05-03 03:58:04','2023-05-03 03:58:04'),(4,'conductor','web','2023-05-03 03:58:04','2023-05-03 03:58:04');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
INSERT INTO `sesiones` VALUES (1,1,12,0.00,'2023-05-02',NULL,'2023-05-02 22:26:05','2023-05-02 22:26:05');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifastramos`
--

LOCK TABLES `tarifastramos` WRITE;
/*!40000 ALTER TABLE `tarifastramos` DISABLE KEYS */;
INSERT INTO `tarifastramos` VALUES (1,1,8,10,150.00,130.00,'2021-01-01','2023-05-02 21:58:14','2023-05-02 21:58:14','0000-00-00 00:00:00'),(2,2,8,10,150.00,130.00,'2021-01-01','2023-05-02 21:58:14','2023-05-02 21:58:14','0000-00-00 00:00:00'),(3,1,8,5,190.00,140.00,'2021-01-01','2023-05-03 16:58:32','2023-05-03 16:58:32','0000-00-00 00:00:00'),(4,1,5,7,190.00,140.00,'2021-01-01','2023-05-03 16:58:32','2023-05-03 16:58:32','0000-00-00 00:00:00'),(5,1,8,7,220.00,200.00,'2023-05-11','2023-05-12 00:14:41','2023-05-12 00:14:41','0000-00-00 00:00:00');
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
  `hwid` text NOT NULL,
  PRIMARY KEY (`nNumero`),
  UNIQUE KEY `nNumero` (`nNumero`),
  KEY `nOficina` (`nOficina`),
  CONSTRAINT `terminales_ibfk_1` FOREIGN KEY (`nOficina`) REFERENCES `oficinas` (`nNumero`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminales`
--

LOCK TABLES `terminales` WRITE;
/*!40000 ALTER TABLE `terminales` DISABLE KEYS */;
INSERT INTO `terminales` VALUES (1,'desconocida',13,'El usuario ingr',''),(2,'Venta sitio web',13,'parhikuni.com',''),(3,'DTI',12,'para pruebas','8349673926E66FD569014C670FB21050');
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
INSERT INTO `tiposervicio` VALUES (1,'PL','Platinum',2,8,8),(2,'UL','Ultra',3,7,0),(3,'EX','Express',4,6,0),(4,'PC','Premium Class',5,6,0),(5,'CP','Business Class',5,7,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramos`
--

LOCK TABLES `tramos` WRITE;
/*!40000 ALTER TABLE `tramos` DISABLE KEYS */;
INSERT INTO `tramos` VALUES (1,8,5,1,1,1,'2023-03-10 11:25:57','2023-03-10 11:25:57','0000-00-00 00:00:00'),(2,5,7,1,1,1,'2023-03-10 11:25:57','2023-03-10 11:25:57','0000-00-00 00:00:00');
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
  `session_id` text DEFAULT NULL COMMENT 'Stores the id of the user session',
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
INSERT INTO `users` VALUES (1,'DTI sistemas','dti_parhikuni@parhikuni.com.mx',NULL,'$2y$10$1.VHBGBnKvmNztSJ5vSdRej0RDxRWEWI2jDoIviQotnuYiDNJAgl6',NULL,'esql7B0X15M9hRPFed3pFhxmHgTAEzXkqCtQhPSG','2023-05-03 03:58:04','2023-05-19 21:11:22',NULL,1),(2,'Sergio Medrano','servicios@parhikuni.com.mx',NULL,'$2y$10$FoUMST6/Tk7MPA/pjY4hOOnWi6cIybbprqSWpxor4cipH73MVAY..',NULL,'NQRcLcG878UKL85ttjmt1a784yBAhWctcAkpk8s9','2023-05-03 03:58:05','2023-05-19 01:20:47',NULL,2),(3,'Prof. German Bode','schumm.edwin@example.com','2023-05-03 03:58:06','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','kq5sAcWtlA',NULL,'2023-05-03 03:58:06','2023-05-03 03:58:06',NULL,NULL),(4,'Rozella Dibbert Sr.','cory95@example.com','2023-05-03 03:58:06','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','QmtYQ9Upo4',NULL,'2023-05-03 03:58:06','2023-05-03 03:58:06',NULL,NULL),(5,'Dr. Nathen Stoltenberg','glenda.grady@example.com','2023-05-03 03:58:06','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','xoXw5RxUu1',NULL,'2023-05-03 03:58:06','2023-05-03 03:58:06',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (1,1,10,NULL,'2023-05-11 13:45:41','2023-05-11 13:45:41'),(2,1,10,NULL,'2023-05-11 14:43:05','2023-05-11 14:43:05');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventapago`
--

LOCK TABLES `ventapago` WRITE;
/*!40000 ALTER TABLE `ventapago` DISABLE KEYS */;
INSERT INTO `ventapago` VALUES (1,1,'EF',NULL,520.00,'2023-05-11 13:45:51',NULL,NULL,'2023-05-11 13:45:51'),(2,2,'EF',NULL,600.00,'2023-05-11 14:43:13',NULL,NULL,'2023-05-11 14:43:13');
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

-- Dump completed on 2023-05-22 10:20:22
