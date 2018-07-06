-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2018 a las 05:38:34
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `fonducar`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE IF NOT EXISTS `administrador` (
  `idAdministrador` int(11) NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `idPersona` int(11) NOT NULL,
  `tipo` int(1) NOT NULL DEFAULT '0',
  `estado` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idAdministrador`),
  UNIQUE KEY `idAdministrador_UNIQUE` (`idAdministrador`),
  UNIQUE KEY `Usuario_UNIQUE` (`Usuario`),
  UNIQUE KEY `Persona_idPersona_UNIQUE` (`idPersona`),
  KEY `fk_Administrador_Persona_idx` (`idPersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`idAdministrador`, `Usuario`, `Password`, `idPersona`, `tipo`, `estado`) VALUES
(2, 'sofimanotas', '02f24bc7844aca593ce2cc8bd7322ee1', 44, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asociado`
--

CREATE TABLE IF NOT EXISTS `asociado` (
  `idAsociado` int(11) NOT NULL AUTO_INCREMENT,
  `Estado` int(11) NOT NULL DEFAULT '0',
  `idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idAsociado`),
  UNIQUE KEY `idAsociado_UNIQUE` (`idAsociado`),
  UNIQUE KEY `Persona_idPersona_UNIQUE` (`idPersona`),
  KEY `fk_Asociado_Persona1_idx` (`idPersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=265 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inhabilitacion`
--

CREATE TABLE IF NOT EXISTS `inhabilitacion` (
  `idInhabilitacion` int(11) NOT NULL AUTO_INCREMENT,
  `Razon` varchar(100) NOT NULL,
  `Fecha` varchar(45) NOT NULL,
  `Estado` int(11) NOT NULL DEFAULT '0',
  `idAsociado` int(11) NOT NULL,
  PRIMARY KEY (`idInhabilitacion`),
  UNIQUE KEY `idInhabilitacion_UNIQUE` (`idInhabilitacion`),
  KEY `fk_Inhabilitacion_Asociado1_idx` (`idAsociado`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimiento`
--

CREATE TABLE IF NOT EXISTS `movimiento` (
  `idMovimiento` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha` varchar(50) NOT NULL,
  `Detalle` varchar(100) NOT NULL,
  `idAdministrador` int(11) NOT NULL,
  PRIMARY KEY (`idMovimiento`,`idAdministrador`),
  UNIQUE KEY `idMovimiento_UNIQUE` (`idMovimiento`),
  KEY `fk_Movimiento_Administrador1_idx` (`idAdministrador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `numero`
--

CREATE TABLE IF NOT EXISTS `numero` (
  `idNumero` int(11) NOT NULL DEFAULT '1',
  `Estado` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idNumero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `numeroasociado`
--

CREATE TABLE IF NOT EXISTS `numeroasociado` (
  `idNumeroAsociado` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha` varchar(50) NOT NULL,
  `idAsociado` int(11) NOT NULL,
  `idNumero` int(11) NOT NULL,
  PRIMARY KEY (`idNumeroAsociado`,`idAsociado`,`idNumero`),
  UNIQUE KEY `idNumeroAsociado_UNIQUE` (`idNumeroAsociado`),
  KEY `fk_NumeroAsociado_Asociado1_idx` (`idAsociado`),
  KEY `fk_NumeroAsociado_Numero1_idx` (`idNumero`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2444 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `idPersona` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Cedula` varchar(50) NOT NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE KEY `idPersona_UNIQUE` (`idPersona`),
  UNIQUE KEY `Cedula_UNIQUE` (`Cedula`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=283 ;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `Nombre`, `Apellido`, `Cedula`) VALUES
(44, 'Sofia ', 'Manotas', '232221');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sorteo`
--

CREATE TABLE IF NOT EXISTS `sorteo` (
  `idSorteo` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha` varchar(50) NOT NULL,
  `idNumeroAsociado` int(11) NOT NULL,
  `Premio` double NOT NULL,
  `TipoSorteo` int(11) NOT NULL,
  PRIMARY KEY (`idSorteo`),
  UNIQUE KEY `idSorteo_UNIQUE` (`idSorteo`),
  KEY `fk_Sorteo_NumeroAsociado1_idx` (`idNumeroAsociado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `fk_Administrador_Persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `asociado`
--
ALTER TABLE `asociado`
  ADD CONSTRAINT `fk_Asociado_Persona1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `inhabilitacion`
--
ALTER TABLE `inhabilitacion`
  ADD CONSTRAINT `fk_Inhabilitacion_Asociado1` FOREIGN KEY (`idAsociado`) REFERENCES `asociado` (`idAsociado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `movimiento`
--
ALTER TABLE `movimiento`
  ADD CONSTRAINT `fk_Movimiento_Administrador1` FOREIGN KEY (`idAdministrador`) REFERENCES `administrador` (`idAdministrador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `numeroasociado`
--
ALTER TABLE `numeroasociado`
  ADD CONSTRAINT `fk_NumeroAsociado_Asociado1` FOREIGN KEY (`idAsociado`) REFERENCES `asociado` (`idAsociado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_NumeroAsociado_Numero1` FOREIGN KEY (`idNumero`) REFERENCES `numero` (`idNumero`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sorteo`
--
ALTER TABLE `sorteo`
  ADD CONSTRAINT `fk_Sorteo_NumeroAsociado1` FOREIGN KEY (`idNumeroAsociado`) REFERENCES `numeroasociado` (`idNumeroAsociado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
