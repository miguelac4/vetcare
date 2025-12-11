-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: vetcare
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agendamento`
--

DROP TABLE IF EXISTS `agendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamento` (
  `idAgendamento` int NOT NULL AUTO_INCREMENT,
  `dataHora` datetime NOT NULL,
  `estado` enum('marcado','reagendado','cancelado','rejeitado','concluido') NOT NULL,
  `criadoPor` enum('cliente','rececionista') NOT NULL,
  `localidade` varchar(30) NOT NULL,
  `idServico` int NOT NULL,
  `idAnimal` int NOT NULL,
  PRIMARY KEY (`idAgendamento`),
  KEY `FK_agendamento_clinica` (`localidade`),
  KEY `FK_agendamento_servico` (`idServico`),
  KEY `FK_agendamento_animal` (`idAnimal`),
  CONSTRAINT `FK_agendamento_animal` FOREIGN KEY (`idAnimal`) REFERENCES `animal` (`idAnimal`),
  CONSTRAINT `FK_agendamento_clinica` FOREIGN KEY (`localidade`) REFERENCES `clinica` (`localidade`),
  CONSTRAINT `FK_agendamento_servico` FOREIGN KEY (`idServico`) REFERENCES `servico` (`idServico`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamento`
--

LOCK TABLES `agendamento` WRITE;
/*!40000 ALTER TABLE `agendamento` DISABLE KEYS */;
INSERT INTO `agendamento` VALUES (1,'2025-11-28 12:00:00','marcado','cliente','Pragal',1,1),(2,'2025-12-03 12:30:00','reagendado','rececionista','Pragal',2,2),(3,'2025-12-03 12:30:00','marcado','rececionista','Pragal',3,3);
/*!40000 ALTER TABLE `agendamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animal`
--

DROP TABLE IF EXISTS `animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animal` (
  `idAnimal` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `raca` varchar(20) DEFAULT NULL,
  `sexo` enum('M','F') NOT NULL,
  `dataNascimento` date DEFAULT NULL,
  `filiacao` varchar(10) NOT NULL,
  `estadoReprodutivo` varchar(12) NOT NULL,
  `alergia` varchar(20) DEFAULT NULL,
  `cor` varchar(15) NOT NULL,
  `fotografia` varchar(150) DEFAULT NULL,
  `peso` decimal(5,2) NOT NULL,
  `distintivas` varchar(30) DEFAULT NULL,
  `numChip` char(15) DEFAULT NULL,
  `nif` char(9) NOT NULL,
  PRIMARY KEY (`idAnimal`),
  UNIQUE KEY `numChip` (`numChip`),
  KEY `FK_animal_cliente` (`nif`),
  CONSTRAINT `FK_animal_cliente` FOREIGN KEY (`nif`) REFERENCES `cliente` (`nif`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES (1,'Bobby','Labrador','M','2020-03-12','N/A','inteiro',NULL,'Bege','https://imgur.com/bobby.jpg',32.50,'mancha branca na pata','123456789012345','123456789'),(2,'Mimi',NULL,'F','2019-07-04','N/A','esterilizada','pólen','Cinza','https://imgur.com/mimi.jpg',4.20,NULL,NULL,'987654321'),(3,'Fifi','Doberman','F',NULL,'N/A','castrada',NULL,'Castanho',NULL,23.30,'cicatriz debaixo do olho','222223333344444','122134435');
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacao`
--

DROP TABLE IF EXISTS `avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacao` (
  `idAvaliacao` int NOT NULL AUTO_INCREMENT,
  `nif` char(9) NOT NULL,
  `avaliacao` enum('adorei','gostei','não vou voltar') NOT NULL,
  `opiniao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idAvaliacao`),
  KEY `FK_avaliacao_cliente` (`nif`),
  CONSTRAINT `FK_avaliacao_cliente` FOREIGN KEY (`nif`) REFERENCES `cliente` (`nif`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacao`
--

LOCK TABLES `avaliacao` WRITE;
/*!40000 ALTER TABLE `avaliacao` DISABLE KEYS */;
INSERT INTO `avaliacao` VALUES (1,'123456789','adorei','Excelente atendimento!'),(2,'987654321','não vou voltar','Péssimo atendimento.'),(3,'122134435','gostei',NULL);
/*!40000 ALTER TABLE `avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `nif` char(9) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `sexo` enum('M','F') DEFAULT NULL,
  `telefone` varchar(20) NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `morada` varchar(80) NOT NULL,
  `freguesia` varchar(30) DEFAULT NULL,
  `concelho` varchar(30) DEFAULT NULL,
  `capitalSocial` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`nif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('122134435','Josefina Gertrudes','F','213454321','josefina@gmail.com','Praceta Sem Fim 985','Tondela','Viseu',NULL),('123456789','Ricardo Santos','M','912345678','ricardo@gmail.com','Rua do Carmo 21','Braço de Prata','Lisboa',NULL),('987654321','Empresa Pet&Co',NULL,'215432123',NULL,'Av. da Liberdade 221',NULL,NULL,50000.00);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_agendamento`
--

DROP TABLE IF EXISTS `cliente_agendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_agendamento` (
  `idAgendamento` int NOT NULL,
  `nif` char(9) NOT NULL,
  PRIMARY KEY (`idAgendamento`,`nif`),
  KEY `FK_clienteAgendamento_cliente` (`nif`),
  CONSTRAINT `FK_clienteAgendamento_agendamento` FOREIGN KEY (`idAgendamento`) REFERENCES `agendamento` (`idAgendamento`),
  CONSTRAINT `FK_clienteAgendamento_cliente` FOREIGN KEY (`nif`) REFERENCES `cliente` (`nif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_agendamento`
--

LOCK TABLES `cliente_agendamento` WRITE;
/*!40000 ALTER TABLE `cliente_agendamento` DISABLE KEYS */;
INSERT INTO `cliente_agendamento` VALUES (1,'122134435'),(2,'123456789'),(3,'987654321');
/*!40000 ALTER TABLE `cliente_agendamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinica`
--

DROP TABLE IF EXISTS `clinica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinica` (
  `localidade` varchar(30) NOT NULL,
  `morada` varchar(80) NOT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  PRIMARY KEY (`localidade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinica`
--

LOCK TABLES `clinica` WRITE;
/*!40000 ALTER TABLE `clinica` DISABLE KEYS */;
INSERT INTO `clinica` VALUES ('Almada','Praceta 456',34.570000,43.240000),('Corroios','Avenida 789',34.570000,43.240000),('Pragal','Rua 123',34.570000,43.240000);
/*!40000 ALTER TABLE `clinica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horario` (
  `idHorario` int NOT NULL AUTO_INCREMENT,
  `diaSemana` enum('Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo') NOT NULL,
  `hInicio` time NOT NULL,
  `hFim` time NOT NULL,
  `localidade` varchar(30) NOT NULL,
  `idServico` int NOT NULL,
  `numLicenca` char(5) NOT NULL,
  PRIMARY KEY (`idHorario`),
  KEY `FK_horario_clinica` (`localidade`),
  KEY `FK_horario_servico` (`idServico`),
  KEY `FK_horario_veterinario` (`numLicenca`),
  CONSTRAINT `FK_horario_clinica` FOREIGN KEY (`localidade`) REFERENCES `clinica` (`localidade`),
  CONSTRAINT `FK_horario_servico` FOREIGN KEY (`idServico`) REFERENCES `servico` (`idServico`),
  CONSTRAINT `FK_horario_veterinario` FOREIGN KEY (`numLicenca`) REFERENCES `veterinario` (`numLicenca`),
  CONSTRAINT `horario_chk_1` CHECK ((`hFim` > `hInicio`))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
INSERT INTO `horario` VALUES (1,'Segunda','09:15:00','12:30:00','Pragal',1,'V1001'),(2,'Terça','10:30:00','14:00:00','Pragal',2,'V1001'),(3,'Sexta','17:45:00','19:00:00','Pragal',3,'V1003');
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rececionista`
--

DROP TABLE IF EXISTS `rececionista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rececionista` (
  `idRececionista` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `localidade` varchar(30) NOT NULL,
  PRIMARY KEY (`idRececionista`),
  KEY `FK_rececionista_clinica` (`localidade`),
  CONSTRAINT `FK_rececionista_clinica` FOREIGN KEY (`localidade`) REFERENCES `clinica` (`localidade`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rececionista`
--

LOCK TABLES `rececionista` WRITE;
/*!40000 ALTER TABLE `rececionista` DISABLE KEYS */;
INSERT INTO `rececionista` VALUES (1,'Ana Maria','Pragal'),(2,'Laura Dias','Pragal'),(3,'Vitor Almeida','Pragal');
/*!40000 ALTER TABLE `rececionista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rececionista_agendamento`
--

DROP TABLE IF EXISTS `rececionista_agendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rececionista_agendamento` (
  `idAgendamento` int NOT NULL,
  `idRececionista` int NOT NULL,
  PRIMARY KEY (`idAgendamento`,`idRececionista`),
  KEY `FK_rececionistaAgendamento_rececionista` (`idRececionista`),
  CONSTRAINT `FK_rececionistaAgendamento_agendamento` FOREIGN KEY (`idAgendamento`) REFERENCES `agendamento` (`idAgendamento`),
  CONSTRAINT `FK_rececionistaAgendamento_rececionista` FOREIGN KEY (`idRececionista`) REFERENCES `rececionista` (`idRececionista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rececionista_agendamento`
--

LOCK TABLES `rececionista_agendamento` WRITE;
/*!40000 ALTER TABLE `rececionista_agendamento` DISABLE KEYS */;
INSERT INTO `rececionista_agendamento` VALUES (1,1),(2,2),(3,3);
/*!40000 ALTER TABLE `rececionista_agendamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servico`
--

DROP TABLE IF EXISTS `servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servico` (
  `idServico` int NOT NULL AUTO_INCREMENT,
  `tipo` enum('Consultas médicas','Exames complementares de diagnóstico','Intervenções cirúrgicas','Medicina preventiva','Tratamentos terapêuticos') NOT NULL,
  `descricao` varchar(80) NOT NULL,
  PRIMARY KEY (`idServico`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico`
--

LOCK TABLES `servico` WRITE;
/*!40000 ALTER TABLE `servico` DISABLE KEYS */;
INSERT INTO `servico` VALUES (1,'Consultas médicas','Consulta geral de rotina'),(2,'Medicina preventiva','Tratamento de sintomas'),(3,'Exames complementares de diagnóstico','Radiografia de rotina');
/*!40000 ALTER TABLE `servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t1`
--

DROP TABLE IF EXISTS `t1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t1` (
  `id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t1`
--

LOCK TABLES `t1` WRITE;
/*!40000 ALTER TABLE `t1` DISABLE KEYS */;
INSERT INTO `t1` VALUES (1,'John'),(2,'Anna'),(1,'John'),(2,'Anna');
/*!40000 ALTER TABLE `t1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomia`
--

DROP TABLE IF EXISTS `taxonomia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxonomia` (
  `idTaxonomia` int NOT NULL AUTO_INCREMENT,
  `especie` varchar(50) NOT NULL,
  `regimeAlimentar` varchar(9) NOT NULL,
  `padraoAtividade` varchar(11) NOT NULL,
  `vocalizacao` varchar(15) NOT NULL,
  `raca` varchar(20) DEFAULT NULL,
  `expetativaVida` tinyint unsigned NOT NULL,
  `peso` decimal(5,2) NOT NULL,
  `comprimento` decimal(5,2) NOT NULL,
  `porte` varchar(7) NOT NULL,
  `predisposicaoGenetica` varchar(40) DEFAULT NULL,
  `cuidadosEsp` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`idTaxonomia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomia`
--

LOCK TABLES `taxonomia` WRITE;
/*!40000 ALTER TABLE `taxonomia` DISABLE KEYS */;
/*!40000 ALTER TABLE `taxonomia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinario`
--

DROP TABLE IF EXISTS `veterinario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinario` (
  `numLicenca` char(5) NOT NULL,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`numLicenca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinario`
--

LOCK TABLES `veterinario` WRITE;
/*!40000 ALTER TABLE `veterinario` DISABLE KEYS */;
INSERT INTO `veterinario` VALUES ('V1001','Dr. João Almeida'),('V1002','Dr. José Alberto'),('V1003','Dr. Fernando Pessoa');
/*!40000 ALTER TABLE `veterinario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-11 16:49:26
