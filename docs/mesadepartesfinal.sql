-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para mesadepartes
CREATE DATABASE IF NOT EXISTS `mesadepartes` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mesadepartes`;

-- Volcando estructura para procedimiento mesadepartes.sp_i_area_01
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_i_area_01`(
	IN `xusu_id` INT
)
BEGIN
	DECLARE areaCount INT;
	
	SELECT COUNT(*) INTO areaCount FROM td_area_detalle WHERE usu_id = xusu_id;
	
	IF areaCount = 0 THEN
		INSERT INTO td_area_detalle(usu_id, area_id)
		SELECT xusu_id, area_id FROM tm_area WHERE est = 1;
	ELSE
		INSERT INTO td_area_detalle(usu_id, area_id)
		SELECT xusu_id, area_id FROM tm_area WHERE est = 1	AND area_id NOT IN (SELECT area_id FROM td_area_detalle WHERE usu_id = xusu_id);
	END IF;
	SELECT
	td_area_detalle.aread_id,
	td_area_detalle.area_id,
	td_area_detalle.aread_permi,
	tm_area.area_nom,
	tm_area.area_correo 
	FROM td_area_detalle
	INNER JOIN tm_area ON td_area_detalle.area_id = tm_area.area_id
	WHERE td_area_detalle.usu_id = xusu_id
	AND tm_area.est = 1;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mesadepartes.sp_i_rol_01
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_i_rol_01`(
	IN `xrol_id` INT
)
BEGIN
	DECLARE rolCount INT;
	
	SELECT COUNT(*) INTO rolCount FROM td_menu_detalle WHERE rol_id = xrol_id;
	
	IF rolCount = 0 THEN
		INSERT INTO td_menu_detalle(rol_id, men_id)
		SELECT xrol_id, men_id FROM tm_menu WHERE est = 1;
	ELSE
		INSERT INTO td_menu_detalle(rol_id, men_id)
		SELECT xrol_id, men_id FROM tm_menu WHERE est = 1	AND men_id NOT IN (SELECT men_id FROM td_menu_detalle WHERE rol_id = xrol_id);
	END IF;
	SELECT
	td_menu_detalle.mend_id,
	td_menu_detalle.rol_id,
	td_menu_detalle.mend_permi,
	tm_menu.men_id,
	tm_menu.men_nom,
	tm_menu.men_nom_vista,
	tm_menu.men_icon,
	tm_menu.men_ruta
	FROM td_menu_detalle
	INNER JOIN tm_menu ON tm_menu.men_id = td_menu_detalle.men_id
	WHERE td_menu_detalle.rol_id = xrol_id
	AND tm_menu.est = 1;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mesadepartes.sp_l_documento_01
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_documento_01`(
	IN `xdoc_id` INT
)
BEGIN
	SELECT
	tm_documento.doc_id,
	tm_documento.area_id,
	tm_area.area_nom,
	tm_area.area_correo,
	tm_documento.doc_externo,
	tm_documento.doc_folios,
	tm_documento.doc_dni,
	tm_documento.doc_nom,
	tm_documento.doc_descrip,
	tm_documento.tra_id,
	tm_tramite.tra_nom,
	tm_documento.tip_id,
	tm_tipo.tip_nom,
	tm_documento.usu_id,
	tm_usuario.usu_nomape,
	tm_usuario.usu_correo,
	tm_documento.doc_estado,
	tm_documento.doc_respuesta,
	tm_documento.fech_crea,
	tm_documento.fech_terminado,
	COALESCE(contador.cant,0) AS cant,
	CONCAT(DATE_FORMAT(tm_documento.fech_crea,'%m'), '-',DATE_FORMAT(tm_documento.fech_crea,'%Y'), '-', tm_documento.doc_id) AS nrotramite
	FROM tm_documento
	INNER JOIN tm_area ON tm_documento.area_id = tm_area.area_id
	INNER JOIN tm_tramite ON tm_documento.tra_id = tm_tramite.tra_id
	INNER JOIN tm_tipo ON tm_documento.tip_id = tm_tipo.tip_id
	INNER JOIN tm_usuario ON tm_documento.usu_id = tm_usuario.usu_id
	LEFT JOIN (
		SELECT doc_id, COUNT(*) AS cant
		FROM td_documento_detalle
		WHERE doc_id = xdoc_id
		GROUP BY doc_id
	) contador ON tm_documento.doc_id = contador.doc_id
	WHERE tm_documento.doc_id = xdoc_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mesadepartes.sp_l_documento_02
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_documento_02`(
	IN `xusu_id` INT
)
BEGIN
	SELECT
	tm_documento.doc_id,
	tm_documento.area_id,
	tm_area.area_nom,
	tm_area.area_correo,
	tm_documento.doc_externo,
	tm_documento.doc_folios,
	tm_documento.doc_dni,
	tm_documento.doc_nom,
	tm_documento.doc_descrip,
	tm_documento.tra_id,
	tm_tramite.tra_nom,
	tm_documento.tip_id,
	tm_tipo.tip_nom,
	tm_documento.usu_id,
	tm_usuario.usu_nomape,
	tm_usuario.usu_correo,
	tm_documento.doc_estado,
	CONCAT(DATE_FORMAT(tm_documento.fech_crea,'%m'), '-',DATE_FORMAT(tm_documento.fech_crea,'%Y'), '-', tm_documento.doc_id) AS nrotramite
	FROM tm_documento
	INNER JOIN tm_area ON tm_documento.area_id = tm_area.area_id
	INNER JOIN tm_tramite ON tm_documento.tra_id = tm_tramite.tra_id
	INNER JOIN tm_tipo ON tm_documento.tip_id = tm_tipo.tip_id
	INNER JOIN tm_usuario ON tm_documento.usu_id = tm_usuario.usu_id
	WHERE tm_documento.usu_id = xusu_id;
END//
DELIMITER ;

-- Volcando estructura para tabla mesadepartes.td_area_detalle
CREATE TABLE IF NOT EXISTS `td_area_detalle` (
  `aread_id` int NOT NULL AUTO_INCREMENT,
  `usu_id` int DEFAULT NULL,
  `area_id` int DEFAULT NULL,
  `aread_permi` varchar(2) COLLATE utf8mb3_spanish_ci DEFAULT 'No',
  `fech_crea` datetime DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int DEFAULT '1',
  PRIMARY KEY (`aread_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla mesadepartes.td_area_detalle: ~28 rows (aproximadamente)
INSERT INTO `td_area_detalle` (`aread_id`, `usu_id`, `area_id`, `aread_permi`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
	(8, 46, 1, 'Si', '2024-09-24 13:50:10', '2024-09-25 15:29:01', NULL, 1),
	(9, 46, 2, 'No', '2024-09-24 13:50:10', '2024-09-28 16:30:28', NULL, 1),
	(10, 46, 3, 'Si', '2024-09-24 13:50:10', '2024-09-27 12:54:52', NULL, 1),
	(11, 46, 4, 'Si', '2024-09-24 13:50:10', '2024-09-25 15:29:06', NULL, 1),
	(12, 46, 5, 'Si', '2024-09-24 13:50:10', '2024-09-25 16:03:33', NULL, 1),
	(13, 46, 6, 'No', '2024-09-24 13:50:10', '2024-09-25 15:29:07', NULL, 1),
	(15, 46, 9, 'No', '2024-09-24 13:54:51', '2024-09-24 15:11:01', NULL, 1),
	(16, 37, 1, 'No', '2024-09-24 15:05:33', '2024-10-16 09:35:24', NULL, 1),
	(17, 37, 2, 'No', '2024-09-24 15:05:33', '2024-10-16 09:35:26', NULL, 1),
	(18, 37, 3, 'No', '2024-09-24 15:05:33', '2024-10-16 09:35:29', NULL, 1),
	(19, 37, 4, 'No', '2024-09-24 15:05:33', '2024-10-16 09:35:28', NULL, 1),
	(20, 37, 5, 'No', '2024-09-24 15:05:33', '2024-10-16 09:35:25', NULL, 1),
	(21, 37, 6, 'No', '2024-09-24 15:05:33', '2024-10-16 09:35:25', NULL, 1),
	(22, 37, 9, 'Si', '2024-09-24 15:05:33', '2024-09-25 15:29:19', NULL, 1),
	(23, 47, 1, 'Si', '2024-10-04 10:21:34', '2024-10-04 10:21:37', NULL, 1),
	(24, 47, 2, 'No', '2024-10-04 10:21:34', NULL, NULL, 1),
	(25, 47, 3, 'No', '2024-10-04 10:21:34', NULL, NULL, 1),
	(26, 47, 4, 'No', '2024-10-04 10:21:34', NULL, NULL, 1),
	(27, 47, 5, 'No', '2024-10-04 10:21:34', NULL, NULL, 1),
	(28, 47, 6, 'No', '2024-10-04 10:21:34', NULL, NULL, 1),
	(29, 47, 9, 'No', '2024-10-04 10:21:34', NULL, NULL, 1),
	(30, 48, 1, 'No', '2024-10-10 11:57:45', NULL, NULL, 1),
	(31, 48, 2, 'Si', '2024-10-10 11:57:45', '2024-10-10 11:57:48', NULL, 1),
	(32, 48, 3, 'No', '2024-10-10 11:57:45', NULL, NULL, 1),
	(33, 48, 4, 'No', '2024-10-10 11:57:45', NULL, NULL, 1),
	(34, 48, 5, 'Si', '2024-10-10 11:57:45', '2024-10-10 11:57:55', NULL, 1),
	(35, 48, 6, 'No', '2024-10-10 11:57:45', NULL, NULL, 1),
	(36, 48, 9, 'No', '2024-10-10 11:57:45', NULL, NULL, 1);

-- Volcando estructura para tabla mesadepartes.td_documento_detalle
CREATE TABLE IF NOT EXISTS `td_documento_detalle` (
  `det_id` int NOT NULL AUTO_INCREMENT,
  `doc_id` int DEFAULT NULL,
  `det_nom` varchar(250) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `usu_id` int DEFAULT NULL,
  `det_tipo` varchar(50) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `fech_crea` datetime DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int DEFAULT '1',
  PRIMARY KEY (`det_id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla mesadepartes.td_documento_detalle: ~95 rows (aproximadamente)
INSERT INTO `td_documento_detalle` (`det_id`, `doc_id`, `det_nom`, `usu_id`, `det_tipo`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
	(1, 1, 'test.pdf', 1, 'Pendiente', NULL, NULL, NULL, 1),
	(2, 9, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(3, 11, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(4, 12, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(5, 12, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(6, 12, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(7, 13, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(8, 13, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(9, 13, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(10, 13, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(11, 14, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(12, 14, 'test.pdf', 37, 'Pendiente', NULL, NULL, NULL, 1),
	(13, 15, 'test.pdf', 37, 'Pendiente', '2024-09-16 12:13:00', NULL, NULL, 1),
	(14, 15, 'test.pdf', 37, 'Pendiente', '2024-09-16 12:13:00', NULL, NULL, 1),
	(15, 16, 'test.pdf', 37, 'Pendiente', '2024-09-16 12:20:20', NULL, NULL, 1),
	(16, 16, 'test.pdf', 37, 'Pendiente', '2024-09-16 12:20:20', NULL, NULL, 1),
	(17, 16, 'test.pdf', 37, 'Pendiente', '2024-09-16 12:20:20', NULL, NULL, 1),
	(18, 16, 'test.pdf', 37, 'Pendiente', '2024-09-16 12:20:20', NULL, NULL, 1),
	(19, 18, 'test.pdf', 37, 'Pendiente', '2024-09-17 10:20:05', NULL, NULL, 1),
	(20, 19, 'test.pdf', 37, 'Pendiente', '2024-09-17 10:29:39', NULL, NULL, 1),
	(21, 20, 'test.pdf', 37, 'Pendiente', '2024-09-17 10:36:39', NULL, NULL, 1),
	(22, 20, 'test.pdf', 37, 'Pendiente', '2024-09-17 10:36:39', NULL, NULL, 1),
	(23, 21, 'test.pdf', 37, 'Pendiente', '2024-09-17 10:54:47', NULL, NULL, 1),
	(24, 21, 'test.pdf', 37, 'Pendiente', '2024-09-17 10:54:47', NULL, NULL, 1),
	(25, 22, 'test.pdf', 37, 'Pendiente', '2024-09-17 11:20:21', NULL, NULL, 1),
	(26, 22, 'test.pdf', 37, 'Pendiente', '2024-09-17 11:20:21', NULL, NULL, 1),
	(27, 22, 'test.pdf', 37, 'Pendiente', '2024-09-17 11:20:21', NULL, NULL, 1),
	(28, 22, 'test.pdf', 37, 'Pendiente', '2024-09-17 11:20:21', NULL, NULL, 1),
	(29, 23, 'test.pdf', 37, 'Pendiente', '2024-09-17 11:30:35', NULL, NULL, 1),
	(30, 25, 'test.pdf', 37, 'Pendiente', '2024-09-17 12:23:38', NULL, NULL, 1),
	(31, 26, 'test.pdf', 37, 'Pendiente', '2024-09-18 20:04:54', NULL, NULL, 1),
	(32, 26, 'test.pdf', 37, 'Pendiente', '2024-09-18 20:04:54', NULL, NULL, 1),
	(33, 28, 'test.pdf', 37, 'Pendiente', '2024-09-20 10:58:26', NULL, NULL, 1),
	(34, 30, 'test.pdf', 40, 'Pendiente', '2024-09-20 16:17:10', NULL, NULL, 1),
	(35, 31, 'Gestionar Trámite - Colaborador  Soluzioni Capital - Mesa de Partes.pdf', 40, 'Pendiente', '2024-09-27 09:38:02', NULL, NULL, 1),
	(36, 31, 'Consultar Trámite  Soluzioni Capital - Mesa de Partes.pdf', 40, 'Pendiente', '2024-09-27 09:38:02', NULL, NULL, 1),
	(37, 31, '1.2.11 Informe Final PLATAFORMA DE AUTOMATIZACIÓN Y ORQUESTACIÓN DE SEGURIDAD XSOAR.pdf', 40, 'Pendiente', '2024-09-27 09:38:02', NULL, NULL, 1),
	(38, 31, 'Top_Exploits.pdf', 40, 'Pendiente', '2024-09-27 09:38:02', NULL, NULL, 1),
	(39, 31, 'Top_amenazas_en_48_horas.pdf', 40, 'Pendiente', '2024-09-27 09:38:02', NULL, NULL, 1),
	(40, 31, '5. ADC Outbound Link Load Balancing.pdf', 46, 'Terminado', '2024-09-27 12:33:49', NULL, NULL, 1),
	(41, 31, '1. ADC Introduction.pdf', 46, 'Terminado', '2024-09-27 12:33:49', NULL, NULL, 1),
	(42, 31, '2. ADC Load Balancing Algorithm.pdf', 46, 'Terminado', '2024-09-27 12:33:49', NULL, NULL, 1),
	(43, 31, '3. ADC Server Load Balancing.pdf', 46, 'Terminado', '2024-09-27 12:33:49', NULL, NULL, 1),
	(44, 31, '4. ADC Deployment Mode.pdf', 46, 'Terminado', '2024-09-27 12:33:49', NULL, NULL, 1),
	(45, 32, 'CertiAdulto - Dario Ayarza Medina.pdf', 40, 'Pendiente', '2024-09-27 12:52:20', NULL, NULL, 1),
	(46, 32, 'PALOALTO FW - INFORME MENSUAL JULIO 2024 INSN.pdf', 40, 'Pendiente', '2024-09-27 12:52:20', NULL, NULL, 1),
	(47, 32, 'top_spammed.pdf', 40, 'Pendiente', '2024-09-27 12:52:20', NULL, NULL, 1),
	(48, 32, 'vRx Summary Report.pdf', 40, 'Pendiente', '2024-09-27 12:52:20', NULL, NULL, 1),
	(49, 32, 'Gestionar Trámite - Colaborador  Soluzioni Capital - Mesa de Partes.pdf', 40, 'Pendiente', '2024-09-27 12:52:20', NULL, NULL, 1),
	(50, 34, 'Top_Exploits.pdf', 40, 'Pendiente', '2024-09-27 13:07:25', NULL, NULL, 1),
	(51, 32, 'Consultar Trámite  Soluzioni Capital - Mesa de Partes.pdf', 46, 'Terminado', '2024-09-27 13:09:56', NULL, NULL, 1),
	(52, 33, 'Gestionar Trámite - Colaborador  Soluzioni Capital - Mesa de Partes.pdf', 46, 'Terminado', '2024-09-27 16:15:46', NULL, NULL, 1),
	(53, 30, 'Consultar Trámite  Soluzioni Capital - Mesa de Partes.pdf', 46, 'Terminado', '2024-09-27 16:19:50', NULL, NULL, 1),
	(54, 30, '1.2.11 Informe Final PLATAFORMA DE AUTOMATIZACIÓN Y ORQUESTACIÓN DE SEGURIDAD XSOAR.pdf', 46, 'Terminado', '2024-09-27 16:19:50', NULL, NULL, 1),
	(55, 29, 'Gestionar Trámite - Colaborador  Soluzioni Capital - Mesa de Partes.pdf', 46, 'Terminado', '2024-09-27 16:20:46', NULL, NULL, 1),
	(56, 29, 'Consultar Trámite  Soluzioni Capital - Mesa de Partes.pdf', 46, 'Terminado', '2024-09-27 16:20:46', NULL, NULL, 1),
	(57, 29, '1.2.11 Informe Final PLATAFORMA DE AUTOMATIZACIÓN Y ORQUESTACIÓN DE SEGURIDAD XSOAR.pdf', 46, 'Terminado', '2024-09-27 16:20:46', NULL, NULL, 1),
	(58, 29, '1.2.14 Informe Final Herramienta de Gestión de Identidades.pdf', 46, 'Terminado', '2024-09-27 16:20:46', NULL, NULL, 1),
	(59, 29, 'Top_Exploits.pdf', 46, 'Terminado', '2024-09-27 16:20:46', NULL, NULL, 1),
	(60, 36, 'Top_Exploits (1).pdf', 40, 'Pendiente', '2024-09-27 17:42:38', NULL, NULL, 1),
	(61, 36, 'top_spammed (1).pdf', 46, 'Terminado', '2024-09-27 17:45:45', NULL, NULL, 1),
	(62, 37, 'Top_Exploits (2).pdf', 40, 'Pendiente', '2024-09-27 18:09:49', NULL, NULL, 1),
	(63, 38, 'Top_Exploits (2).pdf', 40, 'Pendiente', '2024-09-28 16:17:22', NULL, NULL, 1),
	(64, 38, 'Top_Exploits (2) (1).pdf', 46, 'Terminado', '2024-09-28 16:25:19', NULL, NULL, 1),
	(65, 48, 'Mnt. Rol  Soluzioni Capital - Mesa de Partes.pdf', 40, 'Pendiente', '2024-09-30 15:22:51', NULL, NULL, 1),
	(66, 52, 'Consultar Trámite  Soluzioni Capital - Mesa de Partes (2).pdf', 46, 'Terminado', '2024-09-30 15:51:28', NULL, NULL, 1),
	(67, 53, 'FACTURAE001-269320604371881.XML', 40, 'Pendiente', '2024-09-30 17:00:00', NULL, NULL, 1),
	(68, 53, 'Top_Exploits (2) (1) (1).pdf', 40, 'Pendiente', '2024-09-30 17:00:00', NULL, NULL, 1),
	(69, 53, 'Top_Exploits (2).pdf', 40, 'Pendiente', '2024-09-30 17:00:00', NULL, NULL, 1),
	(70, 53, 'FACTURAE001-269320604371881 (1).XML', 46, 'Terminado', '2024-09-30 17:01:37', NULL, NULL, 1),
	(71, 53, 'CertiAdulto - Dario Ayarza Medina (1).pdf', 46, 'Terminado', '2024-09-30 17:01:37', NULL, NULL, 1),
	(72, 53, 'Gestionar Trámite - Colaborador  Soluzioni Capital - Mesa de Partes.xlsx', 46, 'Terminado', '2024-09-30 17:01:37', NULL, NULL, 1),
	(73, 54, 'Listado de Documentos - Administracion (1).pdf', 40, 'Pendiente', '2024-10-01 15:28:05', NULL, NULL, 1),
	(74, 55, 'Listado de Trámites Realizados.pdf', 47, 'Terminado', '2024-10-04 11:50:17', NULL, NULL, 1),
	(75, 55, 'Mnt. Rol  Soluzioni Capital - Mesa de Partes.pdf', 47, 'Terminado', '2024-10-04 11:50:17', NULL, NULL, 1),
	(76, 54, 'Listado de Trámites Realizados.pdf', 47, 'Terminado', '2024-10-04 12:01:43', NULL, NULL, 1),
	(77, 49, 'bodycam sedes y seriales.xlsx', 47, 'Terminado', '2024-10-04 13:40:23', NULL, NULL, 1),
	(78, 56, 'Modelo de datos.xlsx', 40, 'Pendiente', '2024-10-15 10:51:29', NULL, NULL, 1),
	(79, 57, 'LOA Completion Tips.pdf', 40, 'Pendiente', '2024-10-15 10:54:08', NULL, NULL, 1),
	(80, 58, 'Listado de Documentos - Ventas.pdf', 40, 'Pendiente', '2024-10-15 10:56:55', NULL, NULL, 1),
	(81, 58, 'Listado de Documentos (1).pdf', 40, 'Pendiente', '2024-10-15 10:56:55', NULL, NULL, 1),
	(82, 58, 'Listado de Documentos.pdf', 40, 'Pendiente', '2024-10-15 10:56:55', NULL, NULL, 1),
	(83, 59, 'Fortinet_Certified_Fundamentals_in_Cybersecurity.pdf', 40, 'Pendiente', '2024-10-15 11:04:22', NULL, NULL, 1),
	(84, 60, 'Fortinet_Certified_Fundamentals_in_Cybersecurity.pdf', 40, 'Pendiente', '2024-10-15 15:06:07', NULL, NULL, 1),
	(85, 60, 'Fortinet_Certified_Fundamentals_in_Cybersecurity.pdf', 47, 'Terminado', '2024-10-15 15:12:39', NULL, NULL, 1),
	(86, 61, 'Fortinet_Certified_Fundamentals_in_Cybersecurity (1).pdf', 37, 'Pendiente', '2024-10-16 09:31:58', NULL, NULL, 1),
	(87, 62, 'CIS_Controls_v8___Spanish_ESP___ONLINE_2022_0411.pdf', 47, 'Pendiente', '2024-10-16 09:40:29', NULL, NULL, 1),
	(88, 62, 'Listado de Documentos.pdf', 37, 'Terminado', '2024-10-16 10:23:36', NULL, NULL, 1),
	(89, 63, 'Fortinet_Certified_Fundamentals_in_Cybersecurity (1).pdf', 37, 'Pendiente', '2024-10-16 11:50:58', NULL, NULL, 1),
	(90, 63, 'Gestionar Trámite - Colaborador  Soluzioni Capital - Mesa de Partes (1).pdf', 47, 'Terminado', '2024-10-16 13:14:24', NULL, NULL, 1),
	(91, 64, '1.2.14 Informe Final Herramienta de Gestión de Identidades.pdf', 37, 'Pendiente', '2024-10-16 14:35:30', NULL, NULL, 1),
	(92, 65, 'Plan_de_Trabajo_Actualización_Cortex_XSOAR.docx', 37, 'Pendiente', '2024-10-16 16:02:50', NULL, NULL, 1),
	(93, 66, 'Fortinet_Certified_Fundamentals_in_Cybersecurity.pdf', 37, 'Pendiente', '2024-10-16 16:29:55', NULL, NULL, 1),
	(94, 67, 'LOA_Instructions.docx', 37, 'Pendiente', '2024-10-16 16:31:57', NULL, NULL, 1),
	(95, 67, 'Modelo de datos.xlsx', 47, 'Terminado', '2024-10-16 16:38:02', NULL, NULL, 1),
	(96, 68, 'Fortinet_Certified_Fundamentals_in_Cybersecurity (1).pdf', 40, 'Pendiente', '2024-10-17 12:03:03', NULL, NULL, 1),
	(97, 69, 'Fortinet_Certified_Fundamentals_in_Cybersecurity.pdf', 40, 'Pendiente', '2024-10-17 12:04:06', NULL, NULL, 1);

-- Volcando estructura para tabla mesadepartes.td_menu_detalle
CREATE TABLE IF NOT EXISTS `td_menu_detalle` (
  `mend_id` int NOT NULL AUTO_INCREMENT,
  `rol_id` int DEFAULT NULL,
  `men_id` int DEFAULT NULL,
  `mend_permi` varchar(2) COLLATE utf8mb3_spanish_ci DEFAULT 'No',
  `fech_crea` datetime DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int DEFAULT '1',
  PRIMARY KEY (`mend_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla mesadepartes.td_menu_detalle: ~33 rows (aproximadamente)
INSERT INTO `td_menu_detalle` (`mend_id`, `rol_id`, `men_id`, `mend_permi`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
	(1, 3, 1, 'No', '2024-09-25 13:56:44', '2024-09-25 14:20:59', NULL, 1),
	(2, 3, 2, 'Si', '2024-09-25 13:56:44', '2024-10-16 09:30:54', NULL, 1),
	(3, 3, 3, 'Si', '2024-09-25 13:56:44', '2024-10-16 09:30:52', NULL, 1),
	(4, 3, 4, 'Si', '2024-09-25 13:56:44', '2024-10-15 10:40:04', NULL, 1),
	(5, 3, 5, 'Si', '2024-09-25 13:56:44', '2024-10-16 09:30:53', NULL, 1),
	(6, 3, 6, 'Si', '2024-09-25 13:56:44', '2024-10-16 09:30:51', NULL, 1),
	(7, 3, 7, 'Si', '2024-09-25 13:56:44', '2024-09-25 14:00:17', NULL, 1),
	(8, 3, 8, 'Si', '2024-09-25 13:56:44', '2024-09-25 14:00:16', NULL, 1),
	(9, 3, 9, 'Si', '2024-09-25 13:56:44', '2024-09-25 14:00:18', NULL, 1),
	(10, 3, 10, 'Si', '2024-09-25 13:56:44', '2024-09-25 14:00:18', NULL, 1),
	(11, 3, 11, 'Si', '2024-09-25 13:56:44', '2024-09-25 14:00:17', NULL, 1),
	(16, 2, 1, 'No', '2024-09-25 13:59:52', '2024-09-25 14:22:25', NULL, 1),
	(17, 2, 2, 'Si', '2024-09-25 13:59:52', '2024-10-16 09:39:20', NULL, 1),
	(18, 2, 3, 'Si', '2024-09-25 13:59:52', '2024-10-16 09:39:15', NULL, 1),
	(19, 2, 4, 'Si', '2024-09-25 13:59:52', '2024-09-25 14:00:39', NULL, 1),
	(20, 2, 5, 'Si', '2024-09-25 13:59:52', '2024-09-25 14:00:39', NULL, 1),
	(21, 2, 6, 'Si', '2024-09-25 13:59:52', '2024-09-25 14:00:38', NULL, 1),
	(22, 2, 7, 'No', '2024-09-25 13:59:52', '2024-09-25 14:01:22', NULL, 1),
	(23, 2, 8, 'No', '2024-09-25 13:59:52', '2024-09-25 14:01:24', NULL, 1),
	(24, 2, 9, 'No', '2024-09-25 13:59:52', '2024-09-25 14:01:21', NULL, 1),
	(25, 2, 10, 'No', '2024-09-25 13:59:52', '2024-09-25 14:01:21', NULL, 1),
	(26, 2, 11, 'No', '2024-09-25 13:59:52', '2024-09-25 14:01:22', NULL, 1),
	(31, 1, 1, 'Si', '2024-09-25 14:22:05', '2024-09-25 14:22:10', NULL, 1),
	(32, 1, 2, 'Si', '2024-09-25 14:22:05', '2024-09-25 14:22:13', NULL, 1),
	(33, 1, 3, 'Si', '2024-09-25 14:22:05', '2024-09-25 17:02:49', NULL, 1),
	(34, 1, 4, 'No', '2024-09-25 14:22:05', NULL, NULL, 1),
	(35, 1, 5, 'No', '2024-09-25 14:22:05', NULL, NULL, 1),
	(36, 1, 6, 'No', '2024-09-25 14:22:05', NULL, NULL, 1),
	(37, 1, 7, 'No', '2024-09-25 14:22:05', NULL, NULL, 1),
	(38, 1, 8, 'No', '2024-09-25 14:22:05', NULL, NULL, 1),
	(39, 1, 9, 'No', '2024-09-25 14:22:05', NULL, NULL, 1),
	(40, 1, 10, 'No', '2024-09-25 14:22:05', NULL, NULL, 1),
	(41, 1, 11, 'No', '2024-09-25 14:22:05', NULL, NULL, 1);

-- Volcando estructura para tabla mesadepartes.tm_area
CREATE TABLE IF NOT EXISTS `tm_area` (
  `area_id` int NOT NULL AUTO_INCREMENT,
  `area_nom` varchar(50) NOT NULL,
  `area_correo` varchar(50) NOT NULL,
  `fech_crea` datetime DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla mesadepartes.tm_area: ~7 rows (aproximadamente)
INSERT INTO `tm_area` (`area_id`, `area_nom`, `area_correo`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
	(1, 'Administracion', 'dayarza@soluzioni.pe', '2024-09-17 10:25:59', NULL, NULL, 1),
	(2, 'Operaciones', 'dayarza@soluzioni.pe', '2024-09-17 10:25:59', NULL, NULL, 1),
	(3, 'Ventas', 'dayarza@soluzioni.pe', '2024-09-17 10:25:59', '2024-09-23 11:20:24', NULL, 1),
	(4, 'Servicio al Cliente', 'dayarza@soluzioni.pe', '2024-09-17 10:25:59', NULL, NULL, 1),
	(5, 'Innovacion', 'dayarza@soluzioni.pe', '2024-09-17 10:25:59', NULL, NULL, 1),
	(6, 'Legal y Cumplimiento', 'dayarza@soluzioni.pe', '2024-09-17 10:25:59', NULL, NULL, 1),
	(8, 'Test2', 'test2@test2.com', '2024-09-23 10:32:56', '2024-09-23 10:33:06', '2024-09-23 10:33:21', 0),
	(9, 'Soporte Tecnico', 'dayarza@soluzioni.pe', '2024-09-24 13:54:24', NULL, NULL, 1);

-- Volcando estructura para tabla mesadepartes.tm_documento
CREATE TABLE IF NOT EXISTS `tm_documento` (
  `doc_id` int NOT NULL AUTO_INCREMENT,
  `area_id` int DEFAULT NULL,
  `tra_id` int DEFAULT NULL,
  `doc_externo` varchar(50) DEFAULT NULL,
  `doc_folios` varchar(50) DEFAULT NULL,
  `tip_id` int DEFAULT NULL,
  `doc_dni` varchar(50) DEFAULT NULL,
  `doc_nom` varchar(250) DEFAULT NULL,
  `doc_descrip` varchar(500) DEFAULT NULL,
  `usu_id` int DEFAULT NULL,
  `doc_estado` varchar(50) DEFAULT 'Pendiente',
  `doc_respuesta` varchar(500) DEFAULT NULL,
  `doc_usu_terminado` int DEFAULT NULL,
  `fech_crea` datetime DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `fech_terminado` datetime DEFAULT NULL,
  `est` int DEFAULT '1',
  PRIMARY KEY (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla mesadepartes.tm_documento: ~59 rows (aproximadamente)
INSERT INTO `tm_documento` (`doc_id`, `area_id`, `tra_id`, `doc_externo`, `doc_folios`, `tip_id`, `doc_dni`, `doc_nom`, `doc_descrip`, `usu_id`, `doc_estado`, `doc_respuesta`, `doc_usu_terminado`, `fech_crea`, `fech_modi`, `fech_elim`, `fech_terminado`, `est`) VALUES
	(1, 1, 1, 'TEST', '0', 1, '71407053', 'TEST NOMBRE', 'DESCRIPCION PRUEBA', 1, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(8, 1, 18, '-', '0', 1, '71407053', 'Dario Ayarza', 'Solicito vacaciones', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(9, 5, 14, '123123', '0', 1, '123123213', 'sadasdsadasd2213', 'dasfdfsadsdfsf', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(10, 2, 6, '123123', '0', 1, '123123123', '1231211x12xz1z112', '12x12x1211x12z1x13', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(11, 1, 15, 'asdfsdfasdf', '0', 2, '123123213', '123123asdasdasd', '123sadasd', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(12, 3, 4, '1234', '0', 2, '123123123', '123123ssdasdasda', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(13, 5, 10, '123', '0', 2, '123123123', 'asdasdasdasdasd', '123123123123123123', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(14, 1, 12, '', '0', 1, '123123123', 'Dario Ayarza Medina', 'Permiso por salud', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(15, 6, 1, 'asd123', '0', 2, '123123123', 'asasdasdqweqwewqezxczxczxc', '12123weqsdfgtrewsd', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(16, 4, 6, '123', '0', 1, '123123123', '213123adaasassdasda', 'asdasdasdasd12313213', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(17, 5, 3, '', '0', 2, '123123', '123123123', '123123qwdasdasd', 37, 'Pendiente', NULL, NULL, '2024-09-17 09:37:21', NULL, NULL, NULL, 1),
	(18, 1, 6, '', '0', 2, '1231231123', '123123213', '123123asdadasd123123', 37, 'Pendiente', NULL, NULL, '2024-09-17 10:19:57', NULL, NULL, NULL, 1),
	(19, 4, 8, '123456789999999', '0', 2, '1112233123', '213sdsd12313', '123x121x312x', 37, 'Pendiente', NULL, NULL, '2024-09-17 10:29:32', NULL, NULL, NULL, 1),
	(20, 1, 18, '-', '0', 1, '123123123', '12313aqdewdqwdq', '12321 12c21x131c 21 x  x 1x cx c12x3c', 37, 'Pendiente', NULL, NULL, '2024-09-17 10:36:39', NULL, NULL, NULL, 1),
	(21, 3, 7, '-', '0', 2, '123123123123213', '123123123c12x1x1', '1zs1x2321c312c1x13123', 37, 'Pendiente', NULL, NULL, '2024-09-17 10:54:47', NULL, NULL, NULL, 1),
	(22, 2, 16, '1234567890', '0', 1, '71407053', 'aaaaaaaaaaaaaaaaaaaaasssssssssssssssss', 'asdqwezxcrtyfghvbn', 37, 'Pendiente', NULL, NULL, '2024-09-17 11:20:21', NULL, NULL, NULL, 1),
	(23, 6, 4, '-', '0', 2, '123123123123', 'aaaaaaaaaasqweeeeeeeeeeeeeeeeeee', 'asdasd12c2131x23 12 31x123 21x12321c', 37, 'Pendiente', NULL, NULL, '2024-09-17 11:30:35', NULL, NULL, NULL, 1),
	(24, 5, 4, '--', '0', 2, '12121212', '|12|12|12|12|12|12', '|12|1x|1x|11| xxxx', 37, 'Pendiente', NULL, NULL, '2024-09-17 11:53:26', NULL, NULL, NULL, 1),
	(25, 1, 3, '12312313', '0', 2, '1231221312313', '123123123123213', '123123123123', 37, 'Pendiente', NULL, NULL, '2024-09-17 12:23:38', NULL, NULL, NULL, 1),
	(26, 1, 18, '', '0', 2, '123123213213', 'asdasdasdasdasd', 'asdasdadsasd', 37, 'Pendiente', NULL, NULL, '2024-09-18 20:04:54', NULL, NULL, NULL, 1),
	(27, 5, 4, '123123123123', '0', 2, '123123123', '123123123123', '123123123123123', 37, 'Pendiente', NULL, NULL, '2024-09-20 09:47:27', NULL, NULL, NULL, 1),
	(28, 5, 3, '', '0', 2, '123123123', '123123123', '12313123123', 37, 'Pendiente', NULL, NULL, '2024-09-20 10:58:26', NULL, NULL, NULL, 1),
	(29, 1, 2, '123123123', '0', 1, '123123123', '123123123', '1231231231', 37, 'Terminado', 'asdasdasdasd', 46, '2024-09-20 10:59:36', NULL, NULL, '2024-09-27 16:20:46', 1),
	(30, 1, 3, '123', '0', 1, '123123', '1231231', '23123123123', 40, 'Terminado', 'Respuesta genérica', 46, '2024-09-20 16:17:10', NULL, NULL, '2024-09-27 16:19:50', 1),
	(31, 1, 12, '123456789', '0', 1, '71407053', 'Dario Alberto Ayarza Medina', 'Permiso por Salud', 40, 'Terminado', 'Aprobado', 46, '2024-09-27 09:38:02', NULL, NULL, '2024-09-27 12:33:49', 1),
	(32, 3, 11, '1234567890', '0', 1, '06239164', 'Maria Ysabel Medina Castro', 'Solicitamos hojas bond y lapiceros de tinta negra', 40, 'Terminado', 'Se procedió con la compra de equipamiento solicitado.\r\nSaludos.', 46, '2024-09-27 12:52:20', NULL, NULL, '2024-09-27 13:09:56', 1),
	(33, 3, 13, '123', '0', 1, '06239164', 'Maria Medina Castro', 'Exceso en monto en la compra de impresora HP', 40, 'Terminado', 'Se revisó la compra realizada.', 46, '2024-09-27 12:59:41', NULL, NULL, '2024-09-27 16:15:46', 1),
	(34, 3, 6, '1234567', '0', 1, '0744521', 'Luis Alberto Ayarza Uyaco', 'Solicitamos agregar los datos de un nuevo proveedor', 40, 'Pendiente', NULL, NULL, '2024-09-27 13:07:25', NULL, NULL, NULL, 1),
	(35, 3, 15, '1234567890', '0', 1, '06744521', 'Luis Alberto Ayarza Uyaco', 'Se solicita mantenimiento de las computadoras del área de Ventas', 40, 'Pendiente', NULL, NULL, '2024-09-27 13:08:25', NULL, NULL, NULL, 1),
	(36, 3, 8, '', '0', 1, '06239164', 'Maria Medina', 'Solicito registro de visita del viernes 14', 40, 'Terminado', 'Se envia registro del dia solicitado', 46, '2024-09-27 17:42:38', NULL, NULL, '2024-09-27 17:45:45', 1),
	(37, 1, 2, '12344444444', '0', 2, '123331231234412', 'Aaaaaaa SAC', 'Muchas Quejas', 40, 'Pendiente', NULL, NULL, '2024-09-27 18:09:49', NULL, NULL, NULL, 1),
	(38, 1, 9, '4321', '0', 3, '-46579249', '2060809011', 'Ingreso de Factura  E001-2024 ', 40, 'Terminado', 'recibido.', 46, '2024-09-28 16:17:22', NULL, NULL, '2024-09-28 16:25:19', 1),
	(39, 1, 1, '', '0', 2, '123456543212345', 'sdafghjklñkjhgfdsfghjklñ', 'Prueba 30-09', 40, 'Pendiente', NULL, NULL, '2024-09-30 09:25:35', NULL, NULL, NULL, 1),
	(40, 1, 1, '', '0', 2, '123456789', '1234567890\'\'09876543', '123456765432qsdvbnmkjuyfd', 40, 'Pendiente', NULL, NULL, '2024-09-30 12:31:59', NULL, NULL, NULL, 1),
	(41, 1, 1, '123123', '0', 2, '123123123', '123123123123', 'aaaaaaaaaaaaaaaaaaaaaaaaaaa', 40, 'Pendiente', NULL, NULL, '2024-09-30 14:24:02', NULL, NULL, NULL, 1),
	(42, 1, 2, '123123asdasd', '0', 2, '123123123', '12312313123', 'AAAAAAAAAAAAAABBBBBBBBBBBBBBB', 40, 'Pendiente', NULL, NULL, '2024-09-30 14:34:51', NULL, NULL, NULL, 1),
	(43, 1, 1, '123123', '0', 2, '123123123123', '123123123123', '123123123123', 40, 'Pendiente', NULL, NULL, '2024-09-30 14:46:46', NULL, NULL, NULL, 1),
	(44, 1, 2, '123123123123', '0', 2, '12312313123123', '123123213123', 'GAAAAAAAAAAAAAAAAAAAAAAAAAA', 40, 'Pendiente', NULL, NULL, '2024-09-30 14:55:41', NULL, NULL, NULL, 1),
	(45, 1, 2, '2345678', '0', 1, '12345678', '23456789olkjhgf', 'jxertyuil.-{´\'0876tr', 40, 'Pendiente', NULL, NULL, '2024-09-30 15:04:55', NULL, NULL, NULL, 1),
	(46, 1, 3, '123123123123', '0', 1, '1231231231', '123123123123', 'dffdfdfsdfgfdsfgfddfgfdghgfhfgdhghf', 40, 'Pendiente', NULL, NULL, '2024-09-30 15:08:43', NULL, NULL, NULL, 1),
	(47, 3, 3, '123123123213', '0', 2, '123123123', '123123123123', '123123123213', 40, 'Pendiente', NULL, NULL, '2024-09-30 15:20:43', NULL, NULL, NULL, 1),
	(48, 1, 1, '123123123', '0', 2, '123123123123', '123123123123', 'bfdfbnbdfgbn', 40, 'Pendiente', NULL, NULL, '2024-09-30 15:22:51', NULL, NULL, NULL, 1),
	(49, 1, 2, '123123123123', '0', 2, '12312312313', '123123123213', '123123123123', 40, 'Terminado', 'Recibido', 47, '2024-09-30 15:26:24', NULL, NULL, '2024-10-04 13:40:23', 1),
	(50, 1, 2, '123123123', '0', 2, '12312312313123', '12312312312321', '3123123123123123213', 40, 'Terminado', 'recibido', 46, '2024-09-30 15:42:08', NULL, NULL, '2024-09-30 15:43:36', 1),
	(51, 1, 12, '123123123123123123', '0', 2, '123123123123123123', '123123123123asdasdasdzxczxczxczxc', 'AAAAAAAAAAAAAQQQQQQQQQQQQQQQQWWWWWWWWWWWWWWWWWEEEEEEEEEEEEEEE', 40, 'Terminado', 'Recibido', 46, '2024-09-30 15:46:11', NULL, NULL, '2024-09-30 15:48:38', 1),
	(52, 1, 3, '11111', '0', 2, '111', '111', '1111', 40, 'Terminado', 'Recibido', 46, '2024-09-30 15:50:33', NULL, NULL, '2024-09-30 15:51:28', 1),
	(53, 3, 12, 'asd123asd', '0', 1, '123123123', 'asdasdasdasd', '123123123asdasd', 40, 'Terminado', 'aea', 46, '2024-09-30 17:00:00', NULL, NULL, '2024-09-30 17:01:37', 1),
	(54, 1, 2, '123123', '0', 2, '123123123123', '12312312sadadasdasd', '12312c3adafafafsafadfadf', 40, 'Terminado', 'Lista enviada', 47, '2024-10-01 15:28:05', NULL, NULL, '2024-10-04 12:01:43', 1),
	(55, 1, 15, '', '0', 3, '1234565432345', 'INSN', 'Mantenimiento de Firewalls', 40, 'Terminado', 'Se aprueba la visita para el mantenimiento de firewalls. Se adjunta SCTR y lista del personal que irá a la sede. Saludos.', 47, '2024-10-04 11:45:06', NULL, NULL, '2024-10-04 11:50:17', 1),
	(56, 1, 8, '123456', '0', 1, '06239164', 'Maria Ysabel Medina Castro', 'Prueba', 40, 'Pendiente', NULL, NULL, '2024-10-15 10:51:29', NULL, NULL, NULL, 1),
	(57, 1, 13, '123444444', '0', 1, '123', 'Maria Ysabel Medina Castro', 'Test', 40, 'Pendiente', NULL, NULL, '2024-10-15 10:54:08', NULL, NULL, NULL, 1),
	(58, 1, 12, '111111', '0', 1, '11', 'Maria Ysabel Medina Castro', 'Test2', 40, 'Pendiente', NULL, NULL, '2024-10-15 10:56:55', NULL, NULL, NULL, 1),
	(59, 1, 18, '', '0', 1, '06239164', 'Maria Ysabel Medina Castro', 'Test4', 40, 'Pendiente', NULL, NULL, '2024-10-15 11:04:22', NULL, NULL, NULL, 1),
	(60, 1, 8, '123', '0', 1, '06239164', 'Maria Ysabel Medina Castro', 'Prueba', 40, 'Terminado', 'Documento firmado', 47, '2024-10-15 15:06:07', NULL, NULL, '2024-10-15 15:12:39', 1),
	(61, 1, 8, '123123123123123123', '0', 1, '06239164', 'Maria Ysabel Medina Castro', 'AAAAAAAAAA', 37, 'Pendiente', NULL, NULL, '2024-10-16 09:31:58', NULL, NULL, NULL, 1),
	(62, 9, 5, '12311221', '0', 3, '123123123123123', '123123123123', '123123123123', 47, 'Terminado', 'Ok', 37, '2024-10-16 09:40:29', NULL, NULL, '2024-10-16 10:23:36', 1),
	(63, 1, 2, '123', '100', 2, '123123123123123', '1231231231231aaaaaaaaaaaaaaaaaaa', '123123123213213123213', 37, 'Terminado', 'Ok', 47, '2024-10-16 11:50:58', NULL, NULL, '2024-10-16 13:14:24', 1),
	(64, 9, 8, '12312312333333333', '12', 1, '06239164', 'Maria Ysabel Medina Castro', '11111111111111111111111111111111111111111111111111111111', 37, 'Pendiente', NULL, NULL, '2024-10-16 14:35:30', NULL, NULL, NULL, 1),
	(65, 9, 3, 'ASD1231', '123', 3, '12322222', '123SAD21SDAASD', '123123ASDASD', 37, 'Pendiente', NULL, NULL, '2024-10-16 16:02:50', NULL, NULL, NULL, 1),
	(66, 1, 8, '123', '15', 1, '06239164', 'Maria Ysabel Medina Castro', 'ASDQWESADQRF A AS AF F AS FAS FA FAF AF AF ', 37, 'Pendiente', NULL, NULL, '2024-10-16 16:29:55', NULL, NULL, NULL, 1),
	(67, 1, 10, '12312312333333333', '450', 1, '06239164', 'Maria Ysabel Medina Castro', 'AS ASFAS GFDFSHD HDGH SDG SD S ASDG', 37, 'Terminado', 'OKA', 47, '2024-10-16 16:31:57', NULL, NULL, '2024-10-16 16:38:02', 1),
	(68, 9, 16, '11111111', '12', 1, '71407053', 'DARIO ALBERTO AYARZA MEDINA', 'Pruebatest2', 40, 'Pendiente', NULL, NULL, '2024-10-17 12:03:03', NULL, NULL, NULL, 1),
	(69, 9, 3, '123123', '1222', 2, '20538995364', ' D & L TECNOLOGIA Y AUDIO S.R.L.', '111111111111111111', 40, 'Pendiente', NULL, NULL, '2024-10-17 12:04:06', NULL, NULL, NULL, 1);

-- Volcando estructura para tabla mesadepartes.tm_menu
CREATE TABLE IF NOT EXISTS `tm_menu` (
  `men_id` int NOT NULL AUTO_INCREMENT,
  `men_nom` varchar(200) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `men_nom_vista` varchar(200) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `men_icon` varchar(200) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `men_ruta` varchar(200) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `fech_crea` datetime DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int DEFAULT '1',
  PRIMARY KEY (`men_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla mesadepartes.tm_menu: ~11 rows (aproximadamente)
INSERT INTO `tm_menu` (`men_id`, `men_nom`, `men_nom_vista`, `men_icon`, `men_ruta`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
	(1, 'home', 'Inicio', 'home', '../home/', '2024-09-25 08:11:21', NULL, NULL, 1),
	(2, 'nuevotramite', 'Nuevo Tramite', 'file-plus', '../NuevoTramite/', '2024-09-25 08:12:48', NULL, NULL, 1),
	(3, 'consultartramite', 'Consultar Tramite', 'users', '../ConsultarTramite/', '2024-09-25 08:34:18', NULL, NULL, 1),
	(4, 'homecolaborador', 'Inicio Colaborador', 'home', '../homecolaborador/', '2024-09-25 08:35:47', NULL, NULL, 1),
	(5, 'gestionartramite', 'Gestionar Tramite', 'briefcase', '../gestionartramite/', '2024-09-25 08:36:53', NULL, NULL, 1),
	(6, 'buscartramite', 'Buscar Tramite', 'search', '../buscartramite/', '2024-09-25 08:37:22', NULL, NULL, 1),
	(7, 'mntcolaborador', 'Mnt. Colaborador', 'briefcase', '../mntusuario/', '2024-09-25 08:38:29', NULL, NULL, 1),
	(8, 'mntarea', 'Mnt. Area', 'briefcase', '../mntarea/', '2024-09-25 08:41:04', NULL, NULL, 1),
	(9, 'mnttramite', 'Mnt. Tramite', 'briefcase', '../mnttramite/', '2024-09-25 08:41:54', NULL, NULL, 1),
	(10, 'mnttipo', 'Mnt. Tipo', 'briefcase', '../mnttipo/', '2024-09-25 08:42:51', NULL, NULL, 1),
	(11, 'mntrol', 'Mnt. Rol', 'briefcase', '../mntrol/', '2024-09-25 08:43:21', NULL, NULL, 1);

-- Volcando estructura para tabla mesadepartes.tm_rol
CREATE TABLE IF NOT EXISTS `tm_rol` (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `rol_nom` varchar(50) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `fech_crea` datetime DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int DEFAULT '1',
  PRIMARY KEY (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla mesadepartes.tm_rol: ~2 rows (aproximadamente)
INSERT INTO `tm_rol` (`rol_id`, `rol_nom`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
	(1, 'Persona', '2024-09-25 10:53:17', NULL, NULL, 1),
	(2, 'Colaborador', '2024-09-25 10:53:27', NULL, NULL, 1),
	(3, 'Administrador', '2024-09-25 10:53:38', NULL, NULL, 1);

-- Volcando estructura para tabla mesadepartes.tm_tipo
CREATE TABLE IF NOT EXISTS `tm_tipo` (
  `tip_id` int NOT NULL AUTO_INCREMENT,
  `tip_nom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fech_crea` datetime DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int DEFAULT '1',
  PRIMARY KEY (`tip_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla mesadepartes.tm_tipo: ~5 rows (aproximadamente)
INSERT INTO `tm_tipo` (`tip_id`, `tip_nom`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
	(1, 'Natural', '2024-09-20 16:40:47', NULL, NULL, 1),
	(2, 'Juridico', '2024-09-20 16:40:47', '2024-09-22 22:58:12', NULL, 1),
	(3, 'Entidad Publica', '2024-09-20 16:40:47', '2024-09-22 23:09:50', NULL, 1),
	(16, 'Otro 5', '2024-09-22 23:24:55', '2024-09-22 23:43:52', '2024-09-22 23:24:59', 0),
	(17, 'Otro 2', '2024-09-22 23:25:49', '2024-09-22 23:44:53', '2024-09-22 23:25:57', 0),
	(19, 'Otro 8', '2024-09-23 15:37:11', '2024-09-23 15:37:17', '2024-09-23 15:37:19', 0);

-- Volcando estructura para tabla mesadepartes.tm_tramite
CREATE TABLE IF NOT EXISTS `tm_tramite` (
  `tra_id` int NOT NULL AUTO_INCREMENT,
  `tra_nom` varchar(150) NOT NULL,
  `tra_descrip` varchar(300) NOT NULL,
  `fech_crea` datetime DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int DEFAULT '1',
  PRIMARY KEY (`tra_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla mesadepartes.tm_tramite: ~18 rows (aproximadamente)
INSERT INTO `tm_tramite` (`tra_id`, `tra_nom`, `tra_descrip`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
	(1, 'Recepción de Correspondencia Externa', 'Registro y distribución de la correspondencia enviada por clientes, proveedores u otras entidades externas. ', '2024-09-23 10:39:25', NULL, NULL, 1),
	(2, 'Registro de Quejas o Reclamos de Clientes', 'Proceso para gestionar y dar respuesta a las quejas o reclamos de los clientes.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(3, 'Solicitud de Información Pública', 'Gestión de solicitudes de información pública por parte de entidades gubernamentales u otros solicitantes externos.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(4, 'Registro de Contratos y Acuerdos', 'Archivo y seguimiento de los contratos y acuerdos firmados con clientes, proveedores u otras partes externas.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(5, 'Solicitud de Autorización para Eventos', 'Trámite para obtener permisos y autorizaciones necesarias para la realización de eventos.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(6, 'Solicitud de Registro de Proveedores', 'Proceso para incorporar nuevos proveedores al sistema de la empresa.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(7, 'Solicitud de Certificaciones o Documentos Oficiales', 'Obtención de certificaciones y documentos oficiales emitidos por la empresa.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(8, 'Registro de Visitantes', 'Proceso para registrar la entrada y salida de visitantes a las instalaciones de la empresa.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(9, 'Solicitud de Facturas o Documentación Financiera', 'Petición de facturas, recibos u otra documentación financiera por parte de clientes u otras entidades.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(10, 'Solicitud de Autorización para Viajes de Negocio', 'Trámite para obtener autorización y coordinar detalles relacionados con los viajes de negocios de los empleados.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(11, 'Solicitud de Material de Oficina', 'Pedido de suministros y material necesario para el funcionamiento de las disintas áreas.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(12, 'Solicitud de Permiso o Licencia', 'Gestión de permisos y licencias para ausencias programadas de los empleados.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(13, 'Reclamo de Gastos', 'Presentación y revisión de gastos realizados por empleados en nombre de la empresa.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(14, 'Solicitud de Equipamiento o Tecnología', 'Pedido de nuevas herramientas, equipos o tecnologías para mejorar las operaciones internas.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(15, 'Solicitud de Mantenimiento', 'Reporte y seguimiento de solicitudes de mantenimiento para equipos o instalaciones.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(16, 'Solicitud de Capacitación', 'Registro de participación en programas de formación y capacitación.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(17, 'Solicitud de Cambio de Turno u Horario', 'Gestión de cambios en los horarios laborales de los empleados.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(18, 'Solicitud de Vacaciones', 'Proceso para solicitar y coordinar periodos de vacaciones.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(19, 'Reclamo de Incidentes Laborales', 'Informe y seguimiento de incidentes laborales, como accidentes o problemas de seguridad.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(20, 'Solicitud de Compra de Insumos', 'Registro de solicitudes para adquirir insumos necesarios para las operaciones.', '2024-09-23 10:39:25', NULL, NULL, 1),
	(21, 'Otro', 'Otro', '2024-09-23 10:39:25', '2024-09-23 11:39:02', NULL, 1),
	(22, 'Otro24', 'Otro2444', '2024-09-23 11:32:10', '2024-09-23 11:32:21', '2024-09-23 11:33:13', 0);

-- Volcando estructura para tabla mesadepartes.tm_usuario
CREATE TABLE IF NOT EXISTS `tm_usuario` (
  `usu_id` int NOT NULL AUTO_INCREMENT,
  `usu_nomape` varchar(90) NOT NULL,
  `usu_correo` varchar(50) NOT NULL,
  `usu_pass` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `usu_img` varchar(500) DEFAULT NULL,
  `rol_id` int DEFAULT NULL,
  `fech_crea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `fech_acti` datetime DEFAULT NULL,
  `est` int NOT NULL DEFAULT '2',
  PRIMARY KEY (`usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla mesadepartes.tm_usuario: ~2 rows (aproximadamente)
INSERT INTO `tm_usuario` (`usu_id`, `usu_nomape`, `usu_correo`, `usu_pass`, `usu_img`, `rol_id`, `fech_crea`, `fech_modi`, `fech_elim`, `fech_acti`, `est`) VALUES
	(37, 'Dario Alberto Ayarza Medina', 'darioayarza1992@gmail.com', 'wnjbtrNY+N9Wum6PW5uU8ZXsBPmt05RYGgLrUHVbVlc=', 'https://lh3.googleusercontent.com/a/ACg8ocJSo9jr5nEwMeCwPs8mp7RgWTCpA0CLnKxL_QKDp_JW54ZiB2bR=s96-c', 3, '2024-09-13 17:52:40', '2024-10-17 14:01:47', NULL, NULL, 1),
	(40, 'Luis Alberto Ayarza Uyaco', 'aayarza03@gmail.com', 'qsguxjVb7DUxmYoUVPWxCmvnmgRIYB9ZhnMP+qheuGA=', 'https://lh3.googleusercontent.com/a/ACg8ocL3b79EkPjAF76zDy-gWBRBYNSFZIg5umm5jKvPqd48ceWp1w=s96-c', 1, '2024-09-20 12:32:52', '2024-10-10 11:52:33', NULL, NULL, 1),
	(46, 'Dario Colaborador', 'dayarza@soluzioni.pe', 'OPBnTU+xQvJ+0FCspPGl1Ew3xxQXPOdEn9Ys9Qzo964=', '../../assets/picture/avatar.png', 2, '2024-09-24 10:33:24', '2024-09-25 15:25:53', NULL, NULL, 1),
	(47, 'Fatima Salas Espinoza', 'fsalas@soluzioni.pe', 'sRc5WYDqlP9A+Y5ryT/CIYgWBwprmfbc2R/0ya+LbOk=', '../../assets/picture/avatar.png', 2, '2024-10-04 10:19:54', NULL, NULL, NULL, 1),
	(48, 'Fabrizio Olivares', 'folivares@soluzioni.pe', '+mZ8LwlFDq2bPvmqlnqMinl4vrfAyKLYDFwBLOx8FNQ=', '../../assets/picture/avatar.png', 2, '2024-10-10 11:55:42', '2024-10-10 11:58:32', NULL, NULL, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
