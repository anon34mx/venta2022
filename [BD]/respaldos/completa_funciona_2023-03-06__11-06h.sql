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
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletosvendidos`
--

LOCK TABLES `boletosvendidos` WRITE;
/*!40000 ALTER TABLE `boletosvendidos` DISABLE KEYS */;
INSERT INTO `boletosvendidos` VALUES (171,91,319,'2023-02-09','13:00:00',8,7,'AD','EDUARDO ESPINOSA','01','CO',596.90,0.00,95.50,'VE','2023-02-09 12:15:24','2023-02-09 12:15:24',3),(172,91,319,'2023-02-09','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','02','CO',596.90,0.00,95.50,'VE','2023-02-09 12:15:24','2023-02-09 12:15:24',3),(173,92,320,'2023-02-10','13:00:00',8,7,'AD','EDUARDO ESPINOSA','01','CO',596.90,0.00,95.50,'VE','2023-02-09 13:35:48','2023-02-09 13:35:48',3),(174,92,320,'2023-02-10','13:00:00',8,7,'IN','EDUARDO ESPINOSA','02','CO',596.90,0.00,95.50,'VE','2023-02-09 13:35:48','2023-02-09 13:35:48',3),(175,92,320,'2023-02-10','13:00:00',8,7,'NI','MARIO LOPEZ','03','CO',596.90,0.00,95.50,'VE','2023-02-09 13:35:48','2023-02-09 13:35:48',3),(177,94,320,'2023-02-10','13:00:00',5,7,'AD','MARIO LOPEZ','32','CO',500.00,0.00,80.00,'VE','2023-02-09 17:16:50','2023-02-09 17:16:50',3),(178,95,321,'2023-02-11','13:00:00',8,5,'AD','EDUARDO ESPINOSA','01','CO',501.00,0.00,80.16,'VE','2023-02-10 17:27:42','2023-02-10 17:27:42',3),(179,95,321,'2023-02-11','13:00:00',8,5,'NI','JOSE ANTONIO BADIA','02','CO',501.00,0.00,80.16,'VE','2023-02-10 17:27:42','2023-02-10 17:27:42',3),(184,97,323,'2023-02-13','13:00:00',8,7,'AD','EDUARDO ESPINOSA','01','CO',596.90,0.00,95.50,'VE','2023-02-13 11:28:53','2023-02-13 11:28:53',3),(185,97,323,'2023-02-13','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','02','CO',596.90,0.00,95.50,'VE','2023-02-13 11:28:53','2023-02-13 11:28:53',3),(186,98,323,'2023-02-13','13:00:00',8,5,'AD','MARIO LOPEZ','03','CO',501.00,0.00,80.16,'VE','2023-02-13 11:29:42','2023-02-13 11:29:42',3),(192,103,325,'2023-02-15','13:00:00',8,5,'AD','EDUARDO ESPINOSA','01','CO',501.00,0.00,80.16,'VE','2023-02-13 15:49:51','2023-02-13 15:49:51',3),(193,104,325,'2023-02-15','13:00:00',8,5,'AD','JOSE ANTONIO BADIA','02','CO',501.00,0.00,80.16,'VE','2023-02-13 15:50:23','2023-02-13 15:50:23',3),(194,104,325,'2023-02-15','13:00:00',8,5,'AD','MARIO LOPEZ','03','CO',501.00,0.00,80.16,'VE','2023-02-13 15:50:23','2023-02-13 15:50:23',3),(195,105,324,'2023-02-14','13:00:00',8,5,'AD','EDUARDO ESPINOSA','01','CO',501.00,0.00,80.16,'VE','2023-02-13 15:54:18','2023-02-13 15:54:18',3),(196,106,324,'2023-02-14','13:00:00',8,7,'AD','EDUARDO ESPINOSA','03','CO',596.90,0.00,95.50,'VE','2023-02-13 16:01:29','2023-02-13 16:01:29',3),(197,106,324,'2023-02-14','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','04','CO',596.90,0.00,95.50,'VE','2023-02-13 16:01:29','2023-02-13 16:01:29',3),(198,107,324,'2023-02-14','13:00:00',5,7,'AD','MARIO LOPEZ','01','CO',500.00,0.00,80.00,'VE','2023-02-13 16:13:00','2023-02-13 16:13:00',3),(199,108,324,'2023-02-14','13:00:00',8,7,'AD','EDUARDO ESPINOSA','02','CO',596.90,0.00,95.50,'VE','2023-02-13 16:21:07','2023-02-13 16:21:07',3),(200,108,324,'2023-02-14','13:00:00',8,7,'AD','JOSE ANTONIO BADIA','05','CO',596.90,0.00,95.50,'VE','2023-02-13 16:21:07','2023-02-13 16:21:07',3),(201,109,324,'2023-02-14','13:00:00',8,5,'AD','MARIO LOPEZ','32','CO',501.00,0.00,80.16,'VE','2023-02-14 10:17:24','2023-02-14 10:17:24',3),(202,110,324,'2023-02-14','13:00:00',5,7,'AD','EDUARDO ESPINOSA','32','CO',500.00,0.00,80.00,'VE','2023-02-14 10:46:02','2023-02-14 10:46:02',3),(203,111,326,'2023-02-16','13:00:00',5,7,'AD','EDUARDO ESPINOSA','25','CO',500.00,0.00,80.00,'VE','2023-02-15 16:49:16','2023-02-15 16:49:16',3),(204,111,326,'2023-02-16','13:00:00',5,7,'NI','JOSE ANTONIO BADIA','27','CO',500.00,0.00,80.00,'VE','2023-02-15 16:49:16','2023-02-15 16:49:16',3),(205,112,327,'2023-02-17','13:00:00',8,7,'AD','EDUARDO ESPINOSA','25','CO',525.27,71.63,84.04,'VE','2023-02-16 11:01:51','2023-02-16 11:01:51',3),(206,112,327,'2023-02-17','13:00:00',8,7,'NI','MARIO LOPEZ','26','CO',537.21,59.69,85.95,'VE','2023-02-16 11:01:51','2023-02-16 11:01:51',3),(207,113,331,'2023-02-21','13:00:00',8,7,'AD','EDUARDO ESPINOSA','30','CO',596.90,0.00,95.50,'VE','2023-02-21 11:38:46','2023-02-21 11:38:46',3),(208,114,332,'2023-02-22','13:00:00',8,7,'AD','JOSE ANTONIO BADIA','30','CO',525.27,71.63,84.04,'VE','2023-02-21 13:29:13','2023-02-21 13:29:13',3),(209,116,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','29','CO',549.15,47.75,87.86,'VE','2023-02-28 09:32:47','2023-02-28 09:32:47',3),(210,116,339,'2023-03-01','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','30','CO',537.21,59.69,85.95,'VE','2023-02-28 09:32:47','2023-02-28 09:32:47',3),(211,116,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','30','CO',549.15,47.75,87.86,'VE','2023-02-28 13:18:06','2023-02-28 13:18:06',3),(212,116,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','30','CO',549.15,47.75,87.86,'VE','2023-02-28 13:36:35','2023-02-28 13:36:35',3),(213,116,339,'2023-03-01','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','29','CO',537.21,59.69,85.95,'VE','2023-02-28 13:36:35','2023-02-28 13:36:35',3),(214,117,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','29','CO',596.90,0.00,95.50,'VE','2023-02-28 13:40:04','2023-02-28 13:40:04',3),(215,117,339,'2023-03-01','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','30','CO',537.21,59.69,85.95,'VE','2023-02-28 13:40:04','2023-02-28 13:40:04',3),(216,118,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','25','CO',549.15,47.75,87.86,'VE','2023-02-28 15:12:18','2023-02-28 15:12:18',3),(217,118,339,'2023-03-01','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','26','CO',537.21,59.69,85.95,'VE','2023-02-28 15:12:18','2023-02-28 15:12:18',3),(218,118,364,'2023-03-02','16:10:00',7,8,'AD','EDUARDO ESPINOSA','29','CO',495.00,5.00,79.20,'VE','2023-02-28 15:30:57','2023-02-28 15:30:57',3),(219,118,364,'2023-03-02','16:10:00',7,8,'NI','JOSE ANTONIO BADIA','30','CO',450.00,50.00,72.00,'VE','2023-02-28 15:30:57','2023-02-28 15:30:57',3),(220,119,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','25','CO',549.15,47.75,87.86,'VE','2023-02-28 15:33:24','2023-02-28 15:33:24',3),(221,119,339,'2023-03-01','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','26','CO',537.21,59.69,85.95,'VE','2023-02-28 15:33:24','2023-02-28 15:33:24',3),(222,119,364,'2023-03-02','16:10:00',7,8,'AD','EDUARDO ESPINOSA','29','CO',495.00,5.00,79.20,'VE','2023-02-28 15:33:24','2023-02-28 15:33:24',3),(223,119,364,'2023-03-02','16:10:00',7,8,'NI','JOSE ANTONIO BADIA','30','CO',450.00,50.00,72.00,'VE','2023-02-28 15:33:24','2023-02-28 15:33:24',3),(224,120,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','22','CO',590.93,5.97,94.55,'VE','2023-02-28 15:43:48','2023-02-28 15:43:48',3),(225,120,363,'2023-03-01','16:10:00',7,8,'AD','EDUARDO ESPINOSA','30','CO',495.00,5.00,79.20,'VE','2023-02-28 15:43:48','2023-02-28 15:43:48',3),(226,121,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','21','CO',590.93,5.97,94.55,'VE','2023-02-28 16:03:22','2023-02-28 16:03:22',3),(227,121,363,'2023-03-01','16:10:00',7,8,'AD','EDUARDO ESPINOSA','29','CO',495.00,5.00,79.20,'VE','2023-02-28 16:03:22','2023-02-28 16:03:22',3),(228,122,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','01','CO',549.15,47.75,87.86,'VE','2023-03-01 09:57:36','2023-03-01 09:57:36',3),(229,122,339,'2023-03-01','13:00:00',8,7,'NI','MARIO LOPEZ','02','CO',537.21,59.69,85.95,'VE','2023-03-01 09:57:36','2023-03-01 09:57:36',3),(230,122,363,'2023-03-01','16:10:00',7,8,'AD','EDUARDO ESPINOSA','01','CO',495.00,5.00,79.20,'VE','2023-03-01 09:57:36','2023-03-01 09:57:36',3),(231,122,363,'2023-03-01','16:10:00',7,8,'NI','MARIO LOPEZ','02','CO',450.00,50.00,72.00,'VE','2023-03-01 09:57:36','2023-03-01 09:57:36',3),(232,123,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','17','CO',549.15,47.75,87.86,'VE','2023-03-01 09:58:42','2023-03-01 09:58:42',3),(233,123,339,'2023-03-01','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','18','CO',537.21,59.69,85.95,'VE','2023-03-01 09:58:42','2023-03-01 09:58:42',3),(234,124,339,'2023-03-01','13:00:00',8,5,'AD','EDUARDO ESPINOSA','03','CO',501.00,0.00,80.16,'VE','2023-03-01 10:57:46','2023-03-01 10:57:46',3),(235,124,339,'2023-03-01','13:00:00',8,5,'NI','JOSE ANTONIO BADIA','04','CO',501.00,0.00,80.16,'VE','2023-03-01 10:57:46','2023-03-01 10:57:46',3),(236,125,339,'2023-03-01','13:00:00',8,7,'AD','EDUARDO ESPINOSA','13','CO',596.90,0.00,95.50,'VE','2023-03-01 11:00:32','2023-03-01 11:00:32',3),(237,126,339,'2023-03-01','13:00:00',8,7,'AD','MARIO LOPEZ','05','CO',596.90,0.00,95.50,'VE','2023-03-01 11:07:21','2023-03-01 11:07:21',3),(238,126,364,'2023-03-02','16:10:00',7,8,'AD','MARIO LOPEZ','32','CO',500.00,0.00,80.00,'VE','2023-03-01 11:07:21','2023-03-01 11:07:21',3),(239,127,339,'2023-03-01','13:00:00',8,7,'AD','MARIO LOPEZ','03','CO',596.90,0.00,95.50,'VE','2023-03-01 11:21:09','2023-03-01 11:21:09',3),(240,127,364,'2023-03-02','16:10:00',7,8,'AD','MARIO LOPEZ','03','CO',500.00,0.00,80.00,'VE','2023-03-01 11:21:09','2023-03-01 11:21:09',3),(241,128,339,'2023-03-01','13:00:00',8,5,'AD','EDUARDO ESPINOSA','22','CO',501.00,0.00,80.16,'VE','2023-03-01 12:47:08','2023-03-01 12:47:08',3),(242,129,340,'2023-03-02','13:00:00',8,7,'AD','EDUARDO ESPINOSA','30','CO',596.90,0.00,95.50,'VE','2023-03-01 16:05:39','2023-03-01 16:05:39',3),(243,129,340,'2023-03-02','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','26','CO',596.90,0.00,95.50,'VE','2023-03-01 16:05:39','2023-03-01 16:05:39',3),(244,130,340,'2023-03-02','13:00:00',8,7,'AD','JOSE ANTONIO BADIA','29','CO',596.90,0.00,95.50,'VE','2023-03-01 17:40:38','2023-03-01 17:40:38',3),(245,130,340,'2023-03-02','13:00:00',8,7,'NI','EDUARDO ESPINOSA','30','CO',596.90,0.00,95.50,'VE','2023-03-01 17:40:38','2023-03-01 17:40:38',3),(246,130,365,'2023-03-03','16:10:00',7,8,'AD','JOSE ANTONIO BADIA','29','CO',500.00,0.00,80.00,'VE','2023-03-01 17:40:38','2023-03-01 17:40:38',3),(247,130,365,'2023-03-03','16:10:00',7,8,'NI','EDUARDO ESPINOSA','30','CO',500.00,0.00,80.00,'VE','2023-03-01 17:40:38','2023-03-01 17:40:38',3),(248,131,340,'2023-03-02','13:00:00',8,7,'AD','EDUARDO ESPINOSA','29','CO',549.15,47.75,87.86,'VE','2023-03-02 09:36:41','2023-03-02 09:36:41',3),(249,131,340,'2023-03-02','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','30','CO',537.21,59.69,85.95,'VE','2023-03-02 09:36:41','2023-03-02 09:36:41',3),(250,132,341,'2023-03-03','13:00:00',8,7,'AD','EDUARDO ESPINOSA','01','CO',596.90,0.00,95.50,'VE','2023-03-02 11:24:01','2023-03-02 11:24:01',3),(251,132,341,'2023-03-03','13:00:00',8,7,'NI','JOSE ANTONIO BADIA','02','CO',596.90,0.00,95.50,'VE','2023-03-02 11:24:01','2023-03-02 11:24:01',3),(252,133,341,'2023-03-03','13:00:00',5,7,'NI','ROBERTO ANDRADE','04','CO',500.00,0.00,80.00,'VE','2023-03-02 11:27:20','2023-03-02 11:27:20',3),(253,133,341,'2023-03-03','13:00:00',5,7,'AD','HUGO PEREZ','03','CO',500.00,0.00,80.00,'VE','2023-03-02 11:27:20','2023-03-02 11:27:20',3),(254,134,341,'2023-03-03','13:00:00',8,5,'AD','MARIO LOPEZ','03','CO',501.00,0.00,80.16,'VE','2023-03-02 11:29:45','2023-03-02 11:29:45',3),(255,135,341,'2023-03-03','13:00:00',8,7,'AD','RICARDO PEREZ','05','CO',549.15,47.75,87.86,'VE','2023-03-02 11:35:53','2023-03-02 11:35:53',3),(256,136,340,'2023-03-02','13:00:00',5,7,'AD','JOSE ANTONIO BADIA','25','CO',500.00,0.00,80.00,'VE','2023-03-02 11:49:01','2023-03-02 11:49:01',3),(257,137,340,'2023-03-02','13:00:00',5,7,'AD','HUGO PEREZ','26','CO',500.00,0.00,80.00,'VE','2023-03-02 11:50:25','2023-03-02 11:50:25',3);
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
INSERT INTO `conductores` VALUES (1,2,'LIC007','2025-10-11','AC',74,'2023-02-09 11:51:07',NULL,NULL),(2,3,'LIC084','2028-03-08','AC',102,'2023-02-09 11:51:07',NULL,NULL),(3,4,'LIC026','2025-07-26','BA',112,'2023-02-09 11:51:07',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridas_disponibles_historial`
--

LOCK TABLES `corridas_disponibles_historial` WRITE;
/*!40000 ALTER TABLE `corridas_disponibles_historial` DISABLE KEYS */;
INSERT INTO `corridas_disponibles_historial` VALUES (28,332,8,'D','S',NULL,1,'2023-02-22 23:17:23','2023-02-22 23:17:23',NULL),(31,332,8,'S','R',NULL,1,'2023-02-22 23:36:32','2023-02-22 23:36:32',NULL),(33,332,8,'S','R',NULL,1,'2023-02-22 23:47:40','2023-02-22 23:47:40',NULL),(34,332,8,'S','R',NULL,1,'2023-02-22 23:51:06','2023-02-22 23:51:06',NULL),(35,332,8,'S','R',NULL,1,'2023-02-22 23:57:26','2023-02-22 23:57:26',NULL),(37,332,12,'D','R',NULL,2,'2023-02-23 16:20:10','2023-02-23 16:20:10',NULL),(38,332,12,'R','R',NULL,2,'2023-02-23 16:20:51','2023-02-23 16:20:51',NULL),(39,332,12,'R','R',NULL,2,'2023-02-23 16:20:56','2023-02-23 16:20:56',NULL),(40,332,12,'R','R',NULL,2,'2023-02-23 16:31:21','2023-02-23 16:31:21',NULL),(41,332,12,'R','R',NULL,2,'2023-02-23 16:31:33','2023-02-23 16:31:33',NULL),(46,334,8,'D','A',NULL,1,'2023-02-24 19:02:04','2023-02-24 19:02:04',NULL),(47,334,8,'A','R',NULL,1,'2023-02-24 19:02:36','2023-02-24 19:02:36',NULL),(48,334,8,'D','S',NULL,1,'2023-02-24 21:13:30','2023-02-24 21:13:30',NULL),(49,334,8,'A','R',NULL,1,'2023-02-24 21:17:54','2023-02-24 21:17:54',NULL),(50,340,8,'D','A',NULL,1,'2023-03-02 17:06:01','2023-03-02 17:06:01',NULL),(51,340,8,'A','S',NULL,1,'2023-03-02 17:06:17','2023-03-02 17:06:17',NULL),(52,340,8,'A','R',NULL,1,'2023-03-02 17:10:59','2023-03-02 17:10:59',NULL),(53,341,8,'D','A',NULL,1,'2023-03-02 18:16:39','2023-03-02 18:16:39',NULL),(54,341,8,'A','S',NULL,1,'2023-03-02 18:17:20','2023-03-02 18:17:20',NULL),(55,344,8,'D','A',NULL,1,'2023-03-06 15:52:19','2023-03-06 15:52:19',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasdisponibles`
--

LOCK TABLES `corridasdisponibles` WRITE;
/*!40000 ALTER TABLE `corridasdisponibles` DISABLE KEYS */;
INSERT INTO `corridasdisponibles` VALUES (319,11,1,1,'2023-02-09','13:00:00','D',121,1,NULL,NULL,'2023-02-09 23:31:36'),(320,11,1,1,'2023-02-10','13:00:00','D',122,NULL,NULL,NULL,NULL),(321,11,1,1,'2023-02-11','13:00:00','D',122,NULL,NULL,NULL,NULL),(322,11,1,1,'2023-02-12','13:00:00','D',122,NULL,NULL,NULL,NULL),(323,11,1,1,'2023-02-13','13:00:00','D',122,NULL,NULL,NULL,NULL),(324,11,1,1,'2023-02-14','13:00:00','D',122,NULL,NULL,NULL,NULL),(325,11,1,1,'2023-02-15','13:00:00','D',122,NULL,NULL,NULL,NULL),(326,11,1,1,'2023-02-16','13:00:00','D',122,NULL,NULL,NULL,NULL),(327,11,1,1,'2023-02-17','13:00:00','D',122,NULL,NULL,NULL,NULL),(328,11,1,1,'2023-02-18','13:00:00','D',122,NULL,NULL,NULL,NULL),(329,11,1,1,'2023-02-19','13:00:00','D',122,NULL,NULL,NULL,NULL),(330,11,1,1,'2023-02-20','13:00:00','D',122,NULL,NULL,NULL,NULL),(331,11,1,1,'2023-02-21','13:00:00','D',122,NULL,NULL,NULL,NULL),(332,11,1,1,'2023-02-22','13:00:00','D',123,2,NULL,NULL,'2023-02-22 23:36:32'),(333,11,1,1,'2023-02-23','13:00:00','D',122,3,NULL,NULL,'2023-02-24 17:35:06'),(334,11,1,1,'2023-02-24','13:00:00','T',122,1,NULL,NULL,'2023-02-24 22:27:50'),(335,11,1,1,'2023-02-25','13:00:00','D',122,NULL,NULL,NULL,NULL),(336,11,1,1,'2023-02-26','13:00:00','D',122,NULL,NULL,NULL,NULL),(337,11,1,1,'2023-02-27','13:00:00','D',122,NULL,NULL,NULL,NULL),(338,11,1,1,'2023-02-28','13:00:00','D',122,NULL,NULL,NULL,NULL),(339,11,1,1,'2023-03-01','13:00:00','D',122,NULL,NULL,NULL,NULL),(340,11,1,1,'2023-03-02','13:00:00','R',122,1,NULL,NULL,'2023-03-02 17:10:59'),(341,11,1,1,'2023-03-03','13:00:00','S',122,2,NULL,NULL,'2023-03-02 18:17:20'),(342,11,1,1,'2023-03-04','13:00:00','D',122,NULL,NULL,NULL,NULL),(343,11,1,1,'2023-03-05','13:00:00','D',122,NULL,NULL,NULL,NULL),(344,11,1,1,'2023-03-06','13:00:00','D',122,3,NULL,NULL,'2023-03-06 15:52:28'),(345,11,1,1,'2023-03-07','13:00:00','D',122,NULL,NULL,NULL,NULL),(346,11,1,1,'2023-03-08','13:00:00','D',122,NULL,NULL,NULL,NULL),(347,11,1,1,'2023-03-09','13:00:00','D',122,NULL,NULL,NULL,NULL),(348,11,1,1,'2023-03-10','13:00:00','D',122,NULL,NULL,NULL,NULL),(349,11,1,1,'2023-03-11','13:00:00','D',122,NULL,NULL,NULL,NULL),(350,12,2,1,'2023-02-16','16:10:00','D',122,NULL,NULL,NULL,NULL),(351,12,2,1,'2023-02-17','16:10:00','D',122,NULL,NULL,NULL,NULL),(352,12,2,1,'2023-02-18','16:10:00','D',122,NULL,NULL,NULL,NULL),(353,12,2,1,'2023-02-19','16:10:00','D',122,NULL,NULL,NULL,NULL),(354,12,2,1,'2023-02-20','16:10:00','D',122,NULL,NULL,NULL,NULL),(355,12,2,1,'2023-02-21','16:10:00','D',122,NULL,NULL,NULL,NULL),(356,12,2,1,'2023-02-22','16:10:00','D',122,NULL,NULL,NULL,NULL),(357,12,2,1,'2023-02-23','16:10:00','D',122,NULL,NULL,NULL,NULL),(358,12,2,1,'2023-02-24','16:10:00','D',122,NULL,NULL,NULL,NULL),(359,12,2,1,'2023-02-25','16:10:00','D',122,NULL,NULL,NULL,NULL),(360,12,2,1,'2023-02-26','16:10:00','D',122,NULL,NULL,NULL,NULL),(361,12,2,1,'2023-02-27','16:10:00','D',122,NULL,NULL,NULL,NULL),(362,12,2,1,'2023-02-28','16:10:00','D',122,NULL,NULL,NULL,NULL),(363,12,2,1,'2023-03-01','16:10:00','D',122,NULL,NULL,NULL,NULL),(364,12,2,1,'2023-03-02','16:10:00','D',122,NULL,NULL,NULL,NULL),(365,12,2,1,'2023-03-03','16:10:00','D',122,NULL,NULL,NULL,NULL),(366,12,2,1,'2023-03-04','16:10:00','D',122,NULL,NULL,NULL,NULL),(367,12,2,1,'2023-03-05','16:10:00','D',122,NULL,NULL,NULL,NULL),(368,12,2,1,'2023-03-06','16:10:00','D',122,NULL,NULL,NULL,NULL),(369,12,2,1,'2023-03-07','16:10:00','D',122,NULL,NULL,NULL,NULL),(370,12,2,1,'2023-03-08','16:10:00','D',122,NULL,NULL,NULL,NULL),(371,12,2,1,'2023-03-09','16:10:00','D',122,NULL,NULL,NULL,NULL),(372,12,2,1,'2023-03-10','16:10:00','D',122,NULL,NULL,NULL,NULL),(373,12,2,1,'2023-03-11','16:10:00','D',122,NULL,NULL,NULL,NULL),(374,11,1,1,'2023-03-12','13:00:00','D',122,NULL,NULL,NULL,NULL),(375,12,2,1,'2023-03-12','16:10:00','D',122,NULL,NULL,NULL,NULL),(376,11,1,1,'2023-03-13','13:00:00','D',122,NULL,NULL,NULL,NULL),(377,12,2,1,'2023-03-13','16:10:00','D',122,NULL,NULL,NULL,NULL),(378,11,1,1,'2023-03-14','13:00:00','D',122,NULL,NULL,NULL,NULL),(379,12,2,1,'2023-03-14','16:10:00','D',122,NULL,NULL,NULL,NULL),(380,11,1,1,'2023-03-15','13:00:00','D',122,NULL,NULL,NULL,NULL),(381,12,2,1,'2023-03-15','16:10:00','D',122,NULL,NULL,NULL,NULL),(382,11,1,1,'2023-03-16','13:00:00','D',122,NULL,NULL,NULL,NULL),(383,12,2,1,'2023-03-16','16:10:00','D',122,NULL,NULL,NULL,NULL),(384,11,1,1,'2023-03-17','13:00:00','D',122,NULL,NULL,NULL,NULL),(385,12,2,1,'2023-03-17','16:10:00','D',122,NULL,NULL,NULL,NULL),(386,11,1,1,'2023-03-18','13:00:00','D',122,NULL,NULL,NULL,NULL),(387,12,2,1,'2023-03-18','16:10:00','D',122,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corridasprogramadas`
--

LOCK TABLES `corridasprogramadas` WRITE;
/*!40000 ALTER TABLE `corridasprogramadas` DISABLE KEYS */;
INSERT INTO `corridasprogramadas` VALUES (11,1,1,'13:00:00',1,1,1,1,1,1,1,'2023-02-09','2099-02-09',1,NULL,'2023-02-10 00:04:21','2023-02-09 18:04:21'),(12,2,1,'16:10:00',1,1,1,1,1,1,1,'2023-02-16','2099-02-16',1,NULL,'2023-02-17 00:11:19','2023-02-16 18:11:19');
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
) ENGINE=InnoDB AUTO_INCREMENT=2163 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidad`
--

LOCK TABLES `disponibilidad` WRITE;
/*!40000 ALTER TABLE `disponibilidad` DISABLE KEYS */;
INSERT INTO `disponibilidad` VALUES (2018,319,8,5,'2023-02-09','15:15:00','2023-02-09','13:00:00'),(2019,319,8,7,'2023-02-09','17:35:00','2023-02-09','13:00:00'),(2020,319,5,7,'2023-02-09','17:35:00','2023-02-09','15:15:00'),(2021,320,8,5,'2023-02-10','15:15:00','2023-02-10','13:00:00'),(2022,320,8,7,'2023-02-10','17:35:00','2023-02-10','13:00:00'),(2023,320,5,7,'2023-02-10','17:35:00','2023-02-10','15:15:00'),(2024,321,8,5,'2023-02-11','15:15:00','2023-02-11','13:00:00'),(2025,321,8,7,'2023-02-11','17:35:00','2023-02-11','13:00:00'),(2026,321,5,7,'2023-02-11','17:35:00','2023-02-11','15:15:00'),(2027,322,8,5,'2023-02-12','15:15:00','2023-02-12','13:00:00'),(2028,322,8,7,'2023-02-12','17:35:00','2023-02-12','13:00:00'),(2029,322,5,7,'2023-02-12','17:35:00','2023-02-12','15:15:00'),(2030,323,8,5,'2023-02-13','15:15:00','2023-02-13','13:00:00'),(2031,323,8,7,'2023-02-13','17:35:00','2023-02-13','13:00:00'),(2032,323,5,7,'2023-02-13','17:35:00','2023-02-13','15:15:00'),(2033,324,8,5,'2023-02-14','15:15:00','2023-02-14','13:00:00'),(2034,324,8,7,'2023-02-14','17:35:00','2023-02-14','13:00:00'),(2035,324,5,7,'2023-02-14','17:35:00','2023-02-14','15:15:00'),(2036,325,8,5,'2023-02-15','15:15:00','2023-02-15','13:00:00'),(2037,325,8,7,'2023-02-15','17:35:00','2023-02-15','13:00:00'),(2038,325,5,7,'2023-02-15','17:35:00','2023-02-15','15:15:00'),(2039,326,8,5,'2023-02-16','15:15:00','2023-02-16','13:00:00'),(2040,326,8,7,'2023-02-16','17:35:00','2023-02-16','13:00:00'),(2041,326,5,7,'2023-02-16','17:35:00','2023-02-16','15:15:00'),(2042,327,8,5,'2023-02-17','15:15:00','2023-02-17','13:00:00'),(2043,327,8,7,'2023-02-17','17:35:00','2023-02-17','13:00:00'),(2044,327,5,7,'2023-02-17','17:35:00','2023-02-17','15:15:00'),(2045,328,8,5,'2023-02-18','15:15:00','2023-02-18','13:00:00'),(2046,328,8,7,'2023-02-18','17:35:00','2023-02-18','13:00:00'),(2047,328,5,7,'2023-02-18','17:35:00','2023-02-18','15:15:00'),(2048,329,8,5,'2023-02-19','15:15:00','2023-02-19','13:00:00'),(2049,329,8,7,'2023-02-19','17:35:00','2023-02-19','13:00:00'),(2050,329,5,7,'2023-02-19','17:35:00','2023-02-19','15:15:00'),(2051,330,8,5,'2023-02-20','15:15:00','2023-02-20','13:00:00'),(2052,330,8,7,'2023-02-20','17:35:00','2023-02-20','13:00:00'),(2053,330,5,7,'2023-02-20','17:35:00','2023-02-20','15:15:00'),(2054,331,8,5,'2023-02-21','15:15:00','2023-02-21','13:00:00'),(2055,331,8,7,'2023-02-21','17:35:00','2023-02-21','13:00:00'),(2056,331,5,7,'2023-02-21','17:35:00','2023-02-21','15:15:00'),(2057,332,8,5,'2023-02-22','15:15:00','2023-02-22','13:00:00'),(2058,332,8,7,'2023-02-22','17:35:00','2023-02-22','13:00:00'),(2059,332,5,7,'2023-02-22','17:35:00','2023-02-22','15:15:00'),(2060,333,8,5,'2023-02-23','15:15:00','2023-02-23','13:00:00'),(2061,333,8,7,'2023-02-23','17:35:00','2023-02-23','13:00:00'),(2062,333,5,7,'2023-02-23','17:35:00','2023-02-23','15:15:00'),(2063,334,8,5,'2023-02-24','15:15:00','2023-02-24','13:00:00'),(2064,334,8,7,'2023-02-24','17:35:00','2023-02-24','13:00:00'),(2065,334,5,7,'2023-02-24','17:35:00','2023-02-24','15:15:00'),(2066,335,8,5,'2023-02-25','15:15:00','2023-02-25','13:00:00'),(2067,335,8,7,'2023-02-25','17:35:00','2023-02-25','13:00:00'),(2068,335,5,7,'2023-02-25','17:35:00','2023-02-25','15:15:00'),(2069,336,8,5,'2023-02-26','15:15:00','2023-02-26','13:00:00'),(2070,336,8,7,'2023-02-26','17:35:00','2023-02-26','13:00:00'),(2071,336,5,7,'2023-02-26','17:35:00','2023-02-26','15:15:00'),(2072,337,8,5,'2023-02-27','15:15:00','2023-02-27','13:00:00'),(2073,337,8,7,'2023-02-27','17:35:00','2023-02-27','13:00:00'),(2074,337,5,7,'2023-02-27','17:35:00','2023-02-27','15:15:00'),(2075,338,8,5,'2023-02-28','15:15:00','2023-02-28','13:00:00'),(2076,338,8,7,'2023-02-28','17:35:00','2023-02-28','13:00:00'),(2077,338,5,7,'2023-02-28','17:35:00','2023-02-28','15:15:00'),(2078,339,8,5,'2023-03-01','15:15:00','2023-03-01','13:00:00'),(2079,339,8,7,'2023-03-01','17:35:00','2023-03-01','13:00:00'),(2080,339,5,7,'2023-03-01','17:35:00','2023-03-01','15:15:00'),(2081,340,8,5,'2023-03-02','15:15:00','2023-03-02','13:00:00'),(2082,340,8,7,'2023-03-02','17:35:00','2023-03-02','13:00:00'),(2083,340,5,7,'2023-03-02','17:35:00','2023-03-02','15:15:00'),(2084,341,8,5,'2023-03-03','15:15:00','2023-03-03','13:00:00'),(2085,341,8,7,'2023-03-03','17:35:00','2023-03-03','13:00:00'),(2086,341,5,7,'2023-03-03','17:35:00','2023-03-03','15:15:00'),(2087,342,8,5,'2023-03-04','15:15:00','2023-03-04','13:00:00'),(2088,342,8,7,'2023-03-04','17:35:00','2023-03-04','13:00:00'),(2089,342,5,7,'2023-03-04','17:35:00','2023-03-04','15:15:00'),(2090,343,8,5,'2023-03-05','15:15:00','2023-03-05','13:00:00'),(2091,343,8,7,'2023-03-05','17:35:00','2023-03-05','13:00:00'),(2092,343,5,7,'2023-03-05','17:35:00','2023-03-05','15:15:00'),(2093,344,8,5,'2023-03-06','15:15:00','2023-03-06','13:00:00'),(2094,344,8,7,'2023-03-06','17:35:00','2023-03-06','13:00:00'),(2095,344,5,7,'2023-03-06','17:35:00','2023-03-06','15:15:00'),(2096,345,8,5,'2023-03-07','15:15:00','2023-03-07','13:00:00'),(2097,345,8,7,'2023-03-07','17:35:00','2023-03-07','13:00:00'),(2098,345,5,7,'2023-03-07','17:35:00','2023-03-07','15:15:00'),(2099,346,8,5,'2023-03-08','15:15:00','2023-03-08','13:00:00'),(2100,346,8,7,'2023-03-08','17:35:00','2023-03-08','13:00:00'),(2101,346,5,7,'2023-03-08','17:35:00','2023-03-08','15:15:00'),(2102,347,8,5,'2023-03-09','15:15:00','2023-03-09','13:00:00'),(2103,347,8,7,'2023-03-09','17:35:00','2023-03-09','13:00:00'),(2104,347,5,7,'2023-03-09','17:35:00','2023-03-09','15:15:00'),(2105,348,8,5,'2023-03-10','15:15:00','2023-03-10','13:00:00'),(2106,348,8,7,'2023-03-10','17:35:00','2023-03-10','13:00:00'),(2107,348,5,7,'2023-03-10','17:35:00','2023-03-10','15:15:00'),(2108,349,8,5,'2023-03-11','15:15:00','2023-03-11','13:00:00'),(2109,349,8,7,'2023-03-11','17:35:00','2023-03-11','13:00:00'),(2110,349,5,7,'2023-03-11','17:35:00','2023-03-11','15:15:00'),(2111,350,7,8,'2023-02-16','16:11:00','2023-02-16','16:10:00'),(2112,351,7,8,'2023-02-17','16:11:00','2023-02-17','16:10:00'),(2113,352,7,8,'2023-02-18','12:11:00','2023-02-18','12:10:00'),(2114,353,7,8,'2023-02-19','16:11:00','2023-02-19','16:10:00'),(2115,354,7,8,'2023-02-20','16:11:00','2023-02-20','16:10:00'),(2116,355,7,8,'2023-02-21','16:11:00','2023-02-21','16:10:00'),(2117,356,7,8,'2023-02-22','16:11:00','2023-02-22','16:10:00'),(2118,357,7,8,'2023-02-23','16:11:00','2023-02-23','16:10:00'),(2119,358,7,8,'2023-02-24','16:11:00','2023-02-24','16:10:00'),(2120,359,7,8,'2023-02-25','16:11:00','2023-02-25','16:10:00'),(2121,360,7,8,'2023-02-26','16:11:00','2023-02-26','16:10:00'),(2122,361,7,8,'2023-02-27','16:11:00','2023-02-27','16:10:00'),(2123,362,7,8,'2023-02-28','16:11:00','2023-02-28','16:10:00'),(2124,363,7,8,'2023-03-01','16:11:00','2023-03-01','16:10:00'),(2125,364,7,8,'2023-03-02','16:11:00','2023-03-02','16:10:00'),(2126,365,7,8,'2023-03-03','16:11:00','2023-03-03','16:10:00'),(2127,366,7,8,'2023-03-04','16:11:00','2023-03-04','16:10:00'),(2128,367,7,8,'2023-03-05','16:11:00','2023-03-05','16:10:00'),(2129,368,7,8,'2023-03-06','16:11:00','2023-03-06','16:10:00'),(2130,369,7,8,'2023-03-07','16:11:00','2023-03-07','16:10:00'),(2131,370,7,8,'2023-03-08','16:11:00','2023-03-08','16:10:00'),(2132,371,7,8,'2023-03-09','16:11:00','2023-03-09','16:10:00'),(2133,372,7,8,'2023-03-10','16:11:00','2023-03-10','16:10:00'),(2134,373,7,8,'2023-03-11','16:11:00','2023-03-11','16:10:00'),(2135,374,8,5,'2023-03-12','15:15:00','2023-03-12','13:00:00'),(2136,374,8,7,'2023-03-12','17:35:00','2023-03-12','13:00:00'),(2137,374,5,7,'2023-03-12','17:35:00','2023-03-12','15:15:00'),(2138,375,7,8,'2023-03-12','16:11:00','2023-03-12','16:10:00'),(2139,376,8,5,'2023-03-13','15:15:00','2023-03-13','13:00:00'),(2140,376,8,7,'2023-03-13','17:35:00','2023-03-13','13:00:00'),(2141,376,5,7,'2023-03-13','17:35:00','2023-03-13','15:15:00'),(2142,377,7,8,'2023-03-13','16:11:00','2023-03-13','16:10:00'),(2143,378,8,5,'2023-03-14','15:15:00','2023-03-14','13:00:00'),(2144,378,8,7,'2023-03-14','17:35:00','2023-03-14','13:00:00'),(2145,378,5,7,'2023-03-14','17:35:00','2023-03-14','15:15:00'),(2146,379,7,8,'2023-03-14','16:11:00','2023-03-14','16:10:00'),(2147,380,8,5,'2023-03-15','15:15:00','2023-03-15','13:00:00'),(2148,380,8,7,'2023-03-15','17:35:00','2023-03-15','13:00:00'),(2149,380,5,7,'2023-03-15','17:35:00','2023-03-15','15:15:00'),(2150,381,7,8,'2023-03-15','16:11:00','2023-03-15','16:10:00'),(2151,382,8,5,'2023-03-16','15:15:00','2023-03-16','13:00:00'),(2152,382,8,7,'2023-03-16','17:35:00','2023-03-16','13:00:00'),(2153,382,5,7,'2023-03-16','17:35:00','2023-03-16','15:15:00'),(2154,383,7,8,'2023-03-16','16:11:00','2023-03-16','16:10:00'),(2155,384,8,5,'2023-03-17','15:15:00','2023-03-17','13:00:00'),(2156,384,8,7,'2023-03-17','17:35:00','2023-03-17','13:00:00'),(2157,384,5,7,'2023-03-17','17:35:00','2023-03-17','15:15:00'),(2158,385,7,8,'2023-03-17','16:11:00','2023-03-17','16:10:00'),(2159,386,8,5,'2023-03-18','15:15:00','2023-03-18','13:00:00'),(2160,386,8,7,'2023-03-18','17:35:00','2023-03-18','13:00:00'),(2161,386,5,7,'2023-03-18','17:35:00','2023-03-18','15:15:00'),(2162,387,7,8,'2023-03-18','16:11:00','2023-03-18','16:10:00');
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
  CONSTRAINT `dispAsientos_user_id_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `disponibilidadasientos_ibfk_1` FOREIGN KEY (`nDisponibilidad`) REFERENCES `disponibilidad` (`nNumero`),
  CONSTRAINT `disponibilidadasientos_ibfk_2` FOREIGN KEY (`nBoleto`) REFERENCES `boletosvendidos` (`nNumero`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=725 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidadasientos`
--

LOCK TABLES `disponibilidadasientos` WRITE;
/*!40000 ALTER TABLE `disponibilidadasientos` DISABLE KEYS */;
INSERT INTO `disponibilidadasientos` VALUES (1,2030,1,'V','2023-02-13 13:00:00',184,1),(2,2031,1,'V','2023-02-13 13:00:00',184,1),(3,2032,1,'V','2023-02-13 13:00:00',184,1),(4,2030,2,'V','2023-02-13 13:00:00',185,1),(5,2031,2,'V','2023-02-13 13:00:00',185,1),(6,2032,2,'V','2023-02-13 13:00:00',185,1),(7,2030,3,'V','2023-02-13 13:00:00',186,1),(8,2031,3,'V','2023-02-13 13:00:00',186,1),(38,2036,1,'V','2023-02-15 13:00:00',192,1),(39,2037,1,'V','2023-02-15 13:00:00',192,1),(40,2036,2,'V','2023-02-15 13:00:00',193,1),(41,2037,2,'V','2023-02-15 13:00:00',193,1),(42,2036,3,'V','2023-02-15 13:00:00',194,1),(43,2037,3,'V','2023-02-15 13:00:00',194,1),(44,2033,1,'V','2023-02-14 13:00:00',195,1),(45,2034,1,'V','2023-02-14 13:00:00',195,1),(46,2033,3,'V','2023-02-14 13:00:00',196,1),(47,2034,3,'V','2023-02-14 13:00:00',196,1),(48,2035,3,'V','2023-02-14 13:00:00',196,1),(49,2033,4,'V','2023-02-14 13:00:00',197,1),(50,2034,4,'V','2023-02-14 13:00:00',197,1),(51,2035,4,'V','2023-02-14 13:00:00',197,1),(52,2034,1,'V','2023-02-14 13:00:00',198,1),(53,2035,1,'V','2023-02-14 13:00:00',198,1),(54,2033,2,'V','2023-02-14 13:00:00',199,1),(55,2034,2,'V','2023-02-14 13:00:00',199,1),(56,2035,2,'V','2023-02-14 13:00:00',199,1),(57,2033,5,'V','2023-02-14 13:00:00',200,1),(58,2034,5,'V','2023-02-14 13:00:00',200,1),(59,2035,5,'V','2023-02-14 13:00:00',200,1),(60,2033,32,'V','2023-02-14 13:00:00',201,1),(61,2034,32,'V','2023-02-14 13:00:00',201,1),(62,2034,32,'V','2023-02-14 13:00:00',202,1),(63,2035,32,'V','2023-02-14 13:00:00',202,1),(64,2040,25,'V','2023-02-16 13:00:00',203,1),(65,2041,25,'V','2023-02-16 13:00:00',203,1),(66,2040,27,'V','2023-02-16 13:00:00',204,1),(67,2041,27,'V','2023-02-16 13:00:00',204,1),(68,2042,25,'V','2023-02-17 13:00:00',205,1),(69,2043,25,'V','2023-02-17 13:00:00',205,1),(70,2044,25,'V','2023-02-17 13:00:00',205,1),(71,2042,26,'V','2023-02-17 13:00:00',206,1),(72,2043,26,'V','2023-02-17 13:00:00',206,1),(73,2044,26,'V','2023-02-17 13:00:00',206,1),(309,2054,30,'V','2023-02-21 13:00:00',207,1),(310,2055,30,'V','2023-02-21 13:00:00',207,1),(311,2056,30,'V','2023-02-21 13:00:00',207,1),(322,2057,30,'V','2023-02-22 13:00:00',208,1),(323,2058,30,'V','2023-02-22 13:00:00',208,1),(324,2059,30,'V','2023-02-22 13:00:00',208,1),(577,2078,29,'V','2023-03-01 13:00:00',214,1),(578,2079,29,'V','2023-03-01 13:00:00',214,1),(579,2080,29,'V','2023-03-01 13:00:00',214,1),(580,2078,30,'V','2023-03-01 13:00:00',215,1),(581,2079,30,'V','2023-03-01 13:00:00',215,1),(582,2080,30,'V','2023-03-01 13:00:00',215,1),(591,2078,25,'V','2023-03-01 13:00:00',220,1),(592,2079,25,'V','2023-03-01 13:00:00',220,1),(593,2080,25,'V','2023-03-01 13:00:00',220,1),(594,2078,26,'V','2023-03-01 13:00:00',221,1),(595,2079,26,'V','2023-03-01 13:00:00',221,1),(596,2080,26,'V','2023-03-01 13:00:00',221,1),(597,2125,29,'V','2023-03-02 16:10:00',222,1),(598,2125,30,'V','2023-03-02 16:10:00',223,1),(602,2124,30,'V','2023-03-01 16:10:00',225,1),(603,2078,21,'V','2023-03-01 13:00:00',226,1),(604,2079,21,'V','2023-03-01 13:00:00',226,1),(605,2080,21,'V','2023-03-01 13:00:00',226,1),(606,2124,29,'V','2023-03-01 16:10:00',227,1),(637,2078,17,'V','2023-03-01 13:00:00',232,1),(638,2079,17,'V','2023-03-01 13:00:00',232,1),(639,2080,17,'V','2023-03-01 13:00:00',232,1),(640,2078,18,'V','2023-03-01 13:00:00',233,1),(641,2079,18,'V','2023-03-01 13:00:00',233,1),(642,2080,18,'V','2023-03-01 13:00:00',233,1),(643,2078,1,'V','2023-03-01 13:00:00',228,1),(644,2079,1,'V','2023-03-01 13:00:00',228,1),(645,2080,1,'V','2023-03-01 13:00:00',228,1),(646,2078,2,'V','2023-03-01 13:00:00',229,1),(647,2079,2,'V','2023-03-01 13:00:00',229,1),(648,2080,2,'V','2023-03-01 13:00:00',229,1),(649,2124,1,'V','2023-03-01 16:10:00',230,1),(650,2124,2,'V','2023-03-01 16:10:00',231,1),(655,2078,13,'V','2023-03-01 13:00:00',236,1),(656,2079,13,'V','2023-03-01 13:00:00',236,1),(657,2080,13,'V','2023-03-01 13:00:00',236,1),(661,2125,32,'V','2023-03-02 16:10:00',238,1),(665,2125,3,'V','2023-03-02 16:10:00',240,1),(666,2078,22,'V','2023-03-01 13:00:00',241,1),(667,2079,22,'V','2023-03-01 13:00:00',241,1),(686,2126,29,'V','2023-03-03 16:10:00',246,1),(687,2126,30,'V','2023-03-03 16:10:00',247,1),(688,2081,29,'V','2023-03-02 13:00:00',248,1),(689,2082,29,'V','2023-03-02 13:00:00',248,1),(690,2083,29,'V','2023-03-02 13:00:00',248,1),(691,2081,30,'V','2023-03-02 13:00:00',249,1),(692,2082,30,'V','2023-03-02 13:00:00',249,1),(693,2083,30,'V','2023-03-02 13:00:00',249,1),(700,2084,1,'V','2023-03-03 13:00:00',250,1),(701,2085,1,'V','2023-03-03 13:00:00',250,1),(702,2086,1,'V','2023-03-03 13:00:00',250,1),(703,2084,2,'V','2023-03-03 13:00:00',251,1),(704,2085,2,'V','2023-03-03 13:00:00',251,1),(705,2086,2,'V','2023-03-03 13:00:00',251,1),(706,2085,4,'V','2023-03-03 13:00:00',252,1),(707,2086,4,'V','2023-03-03 13:00:00',252,1),(708,2085,3,'V','2023-03-03 13:00:00',253,1),(709,2086,3,'V','2023-03-03 13:00:00',253,1),(710,2084,3,'V','2023-03-03 13:00:00',254,1),(711,2085,3,'V','2023-03-03 13:00:00',254,1);
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
INSERT INTO `itinerario` VALUES (1,1,1),(1,2,2),(2,1,8);
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
INSERT INTO `model_has_permissions` VALUES (1,'App\\Models\\User',2),(21,'App\\Models\\User',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'users.index','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(2,'users.store','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(3,'users.edit','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(4,'users.update','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(5,'users.destroy','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(6,'users.addrol','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(7,'users.removerol','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(8,'users.editPermissions','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(9,'personas.update','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(10,'corridas.programadas.index','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(11,'corridas.programadas.store','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(12,'corridas.programadas.show','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(13,'corridas.programadas.destroy','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(14,'corridas.programadas.transfer','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(15,'corridas.programadas.storeTransfer','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(16,'corridas.disponibles.index','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(17,'corridas.disponibles.edit','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(18,'corridas.disponibles.update','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(19,'corridas.disponibles.puntosDeControl','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(20,'corridas.disponibles.despachar','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(21,'corridas.disponibles.guiaPasajeros','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(22,'boletos.limbo.show','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(23,'personal.conductores.index','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(24,'personal.conductores.edit','web','2023-02-09 23:51:04','2023-02-09 23:51:04'),(25,'personal.conductores.update','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(26,'sesionesVenta.create','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(27,'sesionesVenta.update','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(28,'sesionesVenta.show','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(29,'tarifas.index','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(30,'tarifas.show','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(31,'tarifas.create','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(32,'tarifas.store','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(33,'tarifas.edit','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(34,'tarifas.update','web','2023-02-09 23:51:05','2023-02-09 23:51:05');
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
INSERT INTO `personas` VALUES (1,'Jahaziel Aarón','Aguilera Castillo',12,'EI','2023-02-09','2023-02-09 11:51:07',NULL),(2,'ANGEL','ZAMORA DE JESUS',12,'EI','2023-02-09','2023-02-09 11:51:07',NULL),(3,'FRANCISCO JAVIER','ALVARADO LEMUS',12,'EI','2023-02-09','2023-02-09 11:51:07',NULL),(4,'PASCUAL','ESTEBAN GABRIEL',12,'EI','2023-02-09','2023-02-09 11:51:07',NULL),(5,'JESUS','CORNEJO MAULE',12,NULL,'2023-02-09','2023-02-09 11:51:07',NULL),(6,'sergio','medrano',8,'EI','2023-02-09','2023-02-09 11:51:07',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` VALUES (1,'AD','temporada',12,NULL,NULL,NULL,NULL,NULL,'2021-09-01','2029-12-31','2023-02-13',NULL),(18,'NI','test',10,NULL,NULL,NULL,NULL,NULL,'2023-02-01','2099-02-21','2023-02-10',NULL),(19,'AD','especial',8,NULL,NULL,8,7,NULL,'2023-02-20','2024-02-02','2023-02-27',NULL),(20,'AD','1%',1,NULL,NULL,NULL,NULL,'','2023-02-01','2023-04-01','2023-02-27',NULL);
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
INSERT INTO `registropasopuntos` VALUES (334,1,NULL,'2023-02-24 22:07:54','2023-02-24 22:07:51','2023-02-24 22:07:51','2023-02-24 22:07:54'),(334,2,NULL,'2023-02-24 22:27:50','2023-02-24 22:12:55','2023-02-24 22:12:55','2023-02-24 22:27:50'),(340,1,NULL,NULL,NULL,'2023-03-02 17:10:59','2023-03-02 17:10:59');
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
INSERT INTO `role_has_permissions` VALUES (1,1),(2,1),(3,1),(3,2),(3,3),(4,1),(4,2),(4,3),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(10,3),(11,1),(11,3),(12,1),(12,3),(13,1),(13,3),(14,1),(14,3),(15,1),(15,3),(16,1),(16,3),(17,1),(17,3),(18,1),(18,3),(19,1),(20,1),(20,3),(21,1),(22,1),(23,1),(23,3),(24,1),(24,3),(25,1),(25,3),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1);
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
INSERT INTO `roles` VALUES (1,'Admin','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(2,'publicoGeneral','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(3,'servicios','web','2023-02-09 23:51:05','2023-02-09 23:51:05'),(4,'conductor','web','2023-02-09 23:51:05','2023-02-09 23:51:05');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
INSERT INTO `sesiones` VALUES (10,1,12,1000.00,'2023-02-09','2023-02-22 18:18:34','2023-02-09 18:07:18','2023-02-22 18:18:34'),(11,2,12,0.00,'2023-02-13',NULL,'2023-02-13 22:10:13','2023-02-13 22:10:13'),(12,1,12,0.00,'2023-02-22',NULL,'2023-02-22 19:16:26','2023-02-22 19:16:26');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifastramos`
--

LOCK TABLES `tarifastramos` WRITE;
/*!40000 ALTER TABLE `tarifastramos` DISABLE KEYS */;
INSERT INTO `tarifastramos` VALUES (17,1,8,7,596.90,500.00,'2023-02-09','2023-02-10 00:13:00','2023-02-10 00:13:00','0000-00-00 00:00:00'),(18,1,5,7,500.00,499.00,'2023-02-09','2023-02-10 05:16:23','2023-02-10 05:16:23','0000-00-00 00:00:00'),(19,1,8,5,501.00,501.00,'2023-02-09','2023-02-10 05:32:30','2023-02-10 05:32:30','0000-00-00 00:00:00'),(20,1,7,8,500.00,501.00,'2023-02-16','2023-02-17 00:49:42','2023-02-17 00:49:42','0000-00-00 00:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminales`
--

LOCK TABLES `terminales` WRITE;
/*!40000 ALTER TABLE `terminales` DISABLE KEYS */;
INSERT INTO `terminales` VALUES (2,'Venta sitio web',13,'parhikuni.com'),(3,'DTI',12,'para pruebas');
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
INSERT INTO `tiposervicio` VALUES (1,'PL','Platinum',2,8,4),(2,'UL','Ultra',3,7,0),(3,'EX','Express',4,6,0),(4,'PC','Premium Class',5,6,0),(5,'CP','Business Class',5,7,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramos`
--

LOCK TABLES `tramos` WRITE;
/*!40000 ALTER TABLE `tramos` DISABLE KEYS */;
INSERT INTO `tramos` VALUES (1,8,5,158,135,0,'2023-02-10 00:03:15','2023-02-10 00:03:15','0000-00-00 00:00:00'),(2,5,7,160,140,0,'2023-02-10 00:03:15','2023-02-10 00:03:15','0000-00-00 00:00:00'),(3,8,10,1,1,1,'2023-02-10 01:16:53','2023-02-10 01:16:53','0000-00-00 00:00:00'),(4,10,5,1,1,1,'2023-02-10 01:16:53','2023-02-10 01:16:53','0000-00-00 00:00:00'),(5,5,6,1,1,1,'2023-02-10 01:16:53','2023-02-10 01:16:53','0000-00-00 00:00:00'),(6,10,6,1,1,1,'2023-02-10 01:17:37','2023-02-10 01:17:37','0000-00-00 00:00:00'),(7,6,7,1,1,1,'2023-02-10 01:18:02','2023-02-10 01:18:02','0000-00-00 00:00:00'),(8,7,8,1,1,1,'2023-02-17 00:10:27','2023-02-17 00:10:27','0000-00-00 00:00:00');
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
INSERT INTO `users` VALUES (1,'DTI sistemas','dti_parhikuni@parhikuni.com.mx',NULL,'$2y$10$AltE.qD7uLxEb8Z9bIa3J.6CKB6AgI0HGeXtrC3PFBmeKkPg2oR32','2PKPDOWou0haX2GfRJW2gqkixOByiJCbifP2NofYsd4RxPN61Xtvn952PyM8','2023-02-09 23:51:05','2023-02-09 23:51:05',NULL,1),(2,'Sergio Medrano','sergio.medrano@parhikuni.com.mx',NULL,'$2y$10$j6At3zIqE82fPYpl9KG1S.SSaisgC0dh2ql30MtS1uaTDxmvz01RO','HEoQPtKNTXCg51uTdhYXtXgUXqCqrOXZjz1oCw9st7ldlvfdabOtK5t1JM9G','2023-02-09 23:51:05','2023-02-09 23:51:05',NULL,6),(3,'Miss Lucienne Schumm Sr.','homenick.ali@example.com','2023-02-09 23:51:06','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','vtxCQduGIJ','2023-02-09 23:51:06','2023-02-09 23:51:06',NULL,NULL),(4,'Dr. Amber Farrell V','haleigh.balistreri@example.com','2023-02-09 23:51:06','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','VSNt6kK5L3','2023-02-09 23:51:06','2023-02-09 23:51:06',NULL,NULL),(5,'Emilio Kreiger','thompson.cecelia@example.net','2023-02-09 23:51:06','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','w1Or8yHdzW','2023-02-09 23:51:06','2023-02-09 23:51:06',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (91,10,'2023-02-09 12:15:24','2023-02-09 12:15:24'),(92,10,'2023-02-09 13:35:48','2023-02-09 13:35:48'),(93,10,'2023-02-09 14:00:17','2023-02-09 14:00:17'),(94,10,'2023-02-09 17:16:50','2023-02-09 17:16:50'),(95,10,'2023-02-10 17:27:42','2023-02-10 17:27:42'),(96,10,'2023-02-13 10:09:20','2023-02-13 10:09:20'),(97,10,'2023-02-13 11:20:03','2023-02-13 11:20:03'),(98,10,'2023-02-13 11:29:42','2023-02-13 11:29:42'),(99,10,'2023-02-13 15:37:13','2023-02-13 15:37:13'),(100,10,'2023-02-13 15:39:50','2023-02-13 15:39:50'),(101,10,'2023-02-13 15:41:38','2023-02-13 15:41:38'),(102,10,'2023-02-13 15:43:33','2023-02-13 15:43:33'),(103,10,'2023-02-13 15:49:51','2023-02-13 15:49:51'),(104,10,'2023-02-13 15:50:23','2023-02-13 15:50:23'),(105,10,'2023-02-13 15:54:18','2023-02-13 15:54:18'),(106,10,'2023-02-13 16:01:29','2023-02-13 16:01:29'),(107,10,'2023-02-13 16:13:00','2023-02-13 16:13:00'),(108,10,'2023-02-13 16:21:07','2023-02-13 16:21:07'),(109,10,'2023-02-14 10:17:24','2023-02-14 10:17:24'),(110,10,'2023-02-14 10:46:02','2023-02-14 10:46:02'),(111,10,'2023-02-15 16:49:15','2023-02-15 16:49:15'),(112,10,'2023-02-16 11:01:51','2023-02-16 11:01:51'),(113,10,'2023-02-21 11:38:46','2023-02-21 11:38:46'),(114,10,'2023-02-21 13:29:13','2023-02-21 13:29:13'),(115,12,'2023-02-27 17:28:24','2023-02-27 17:28:24'),(116,12,'2023-02-28 09:32:47','2023-02-28 09:32:47'),(117,12,'2023-02-28 13:40:04','2023-02-28 13:40:04'),(118,12,'2023-02-28 15:12:18','2023-02-28 15:12:18'),(119,12,'2023-02-28 15:33:24','2023-02-28 15:33:24'),(120,12,'2023-02-28 15:43:48','2023-02-28 15:43:48'),(121,12,'2023-02-28 16:03:22','2023-02-28 16:03:22'),(122,12,'2023-03-01 09:57:36','2023-03-01 09:57:36'),(123,12,'2023-03-01 09:58:42','2023-03-01 09:58:42'),(124,12,'2023-03-01 10:04:46','2023-03-01 10:04:46'),(125,12,'2023-03-01 11:00:32','2023-03-01 11:00:32'),(126,12,'2023-03-01 11:07:21','2023-03-01 11:07:21'),(127,12,'2023-03-01 11:21:09','2023-03-01 11:21:09'),(128,12,'2023-03-01 12:47:08','2023-03-01 12:47:08'),(129,12,'2023-03-01 16:05:39','2023-03-01 16:05:39'),(130,12,'2023-03-01 17:40:38','2023-03-01 17:40:38'),(131,12,'2023-03-02 09:36:41','2023-03-02 09:36:41'),(132,12,'2023-03-02 11:24:01','2023-03-02 11:24:01'),(133,12,'2023-03-02 11:27:20','2023-03-02 11:27:20'),(134,12,'2023-03-02 11:29:45','2023-03-02 11:29:45'),(135,12,'2023-03-02 11:35:53','2023-03-02 11:35:53'),(136,12,'2023-03-02 11:49:01','2023-03-02 11:49:01'),(137,12,'2023-03-02 11:50:25','2023-03-02 11:50:25');
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventapago`
--

LOCK TABLES `ventapago` WRITE;
/*!40000 ALTER TABLE `ventapago` DISABLE KEYS */;
INSERT INTO `ventapago` VALUES (1,103,'EF',NULL,600.00,'2023-02-13 15:49:54',NULL,NULL,'2023-02-13 15:49:54'),(2,104,'EF',NULL,1200.00,'2023-02-13 15:50:27',NULL,NULL,'2023-02-13 15:50:27'),(3,105,'EF',NULL,600.00,'2023-02-13 15:54:22',NULL,NULL,'2023-02-13 15:54:22'),(4,106,'EF',NULL,1400.00,'2023-02-13 16:01:32',NULL,NULL,'2023-02-13 16:01:32'),(5,107,'EF',NULL,600.00,'2023-02-13 16:13:07',NULL,NULL,'2023-02-13 16:13:07'),(6,108,'EF',NULL,1400.00,'2023-02-13 16:21:11',NULL,NULL,'2023-02-13 16:21:11'),(7,109,'EF',NULL,600.00,'2023-02-14 10:17:28',NULL,NULL,'2023-02-14 10:17:28'),(8,110,'EF',NULL,600.00,'2023-02-14 10:46:06',NULL,NULL,'2023-02-14 10:46:06'),(9,111,'EF',NULL,1200.00,'2023-02-15 16:49:19',NULL,NULL,'2023-02-15 16:49:19'),(10,112,'EF',NULL,1300.00,'2023-02-16 11:01:54',NULL,NULL,'2023-02-16 11:01:54'),(11,113,'EF',NULL,700.00,'2023-02-21 11:44:30',NULL,NULL,'2023-02-21 11:44:30'),(12,114,'EF',NULL,610.00,'2023-02-21 13:29:20',NULL,NULL,'2023-02-21 13:29:20'),(13,117,'EF',NULL,1400.00,'2023-02-28 13:41:38',NULL,NULL,'2023-02-28 13:41:38'),(14,119,'EF',NULL,2400.00,'2023-02-28 15:36:58',NULL,NULL,'2023-02-28 15:36:58'),(15,121,'EF',NULL,1300.00,'2023-02-28 16:03:39',NULL,NULL,'2023-02-28 16:03:39'),(16,123,'EF',NULL,1300.00,'2023-03-01 09:58:50',NULL,NULL,'2023-03-01 09:58:50'),(17,122,'EF',NULL,2400.00,'2023-03-01 09:59:17',NULL,NULL,'2023-03-01 09:59:17'),(18,125,'EF',NULL,700.00,'2023-03-01 11:02:49',NULL,NULL,'2023-03-01 11:02:49'),(19,127,'EF',NULL,1000.50,'2023-03-01 11:27:42',NULL,NULL,'2023-03-01 11:27:42'),(20,128,'EF',NULL,12.34,'2023-03-01 12:52:44',NULL,NULL,'2023-03-01 12:52:44'),(21,128,'EF',NULL,99999.99,'2023-03-01 12:59:38',NULL,NULL,'2023-03-01 12:59:38'),(22,131,'EF',NULL,99999.99,'2023-03-02 09:41:28',NULL,NULL,'2023-03-02 09:41:28'),(23,132,'EF',NULL,0.00,'2023-03-02 11:24:11',NULL,NULL,'2023-03-02 11:24:11'),(24,132,'EF',NULL,1400.00,'2023-03-02 11:24:17',NULL,NULL,'2023-03-02 11:24:17'),(25,133,'EF',NULL,1200.00,'2023-03-02 11:27:25',NULL,NULL,'2023-03-02 11:27:25'),(26,134,'EF',NULL,600.00,'2023-03-02 11:29:56',NULL,NULL,'2023-03-02 11:29:56'),(27,137,'EF',NULL,1.00,'2023-03-02 11:50:56',NULL,NULL,'2023-03-02 11:50:56'),(28,137,'EF',NULL,1.00,'2023-03-02 11:50:59',NULL,NULL,'2023-03-02 11:50:59');
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

-- Dump completed on 2023-03-06 11:07:37
