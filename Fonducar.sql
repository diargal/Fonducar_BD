-- MySQL Script generated by MySQL Workbench
-- Sat May  5 17:45:53 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Fonducar
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Fonducar` ;

-- -----------------------------------------------------
-- Schema Fonducar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Fonducar` DEFAULT CHARACTER SET utf8 ;
USE `Fonducar` ;

-- -----------------------------------------------------
-- Table `Fonducar`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fonducar`.`Persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Cedula` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idPersona`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idPersona_UNIQUE` ON `Fonducar`.`Persona` (`idPersona` ASC);

CREATE UNIQUE INDEX `Cedula_UNIQUE` ON `Fonducar`.`Persona` (`Cedula` ASC);


-- -----------------------------------------------------
-- Table `Fonducar`.`Administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fonducar`.`Administrador` (
  `idAdministrador` INT NOT NULL AUTO_INCREMENT,
  `Usuario` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(50) NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idAdministrador`),
  CONSTRAINT `fk_Administrador_Persona`
    FOREIGN KEY (`idPersona`)
    REFERENCES `Fonducar`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idAdministrador_UNIQUE` ON `Fonducar`.`Administrador` (`idAdministrador` ASC);

CREATE UNIQUE INDEX `Usuario_UNIQUE` ON `Fonducar`.`Administrador` (`Usuario` ASC);

CREATE INDEX `fk_Administrador_Persona_idx` ON `Fonducar`.`Administrador` (`idPersona` ASC);

CREATE UNIQUE INDEX `Persona_idPersona_UNIQUE` ON `Fonducar`.`Administrador` (`idPersona` ASC);


-- -----------------------------------------------------
-- Table `Fonducar`.`Asociado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fonducar`.`Asociado` (
  `idAsociado` INT NOT NULL AUTO_INCREMENT,
  `Estado` INT NOT NULL DEFAULT 0,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idAsociado`),
  CONSTRAINT `fk_Asociado_Persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `Fonducar`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idAsociado_UNIQUE` ON `Fonducar`.`Asociado` (`idAsociado` ASC);

CREATE INDEX `fk_Asociado_Persona1_idx` ON `Fonducar`.`Asociado` (`idPersona` ASC);

CREATE UNIQUE INDEX `Persona_idPersona_UNIQUE` ON `Fonducar`.`Asociado` (`idPersona` ASC);


-- -----------------------------------------------------
-- Table `Fonducar`.`Numero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fonducar`.`Numero` (
  `idNumero` INT NOT NULL DEFAULT 1,
  `Estado` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idNumero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fonducar`.`NumeroAsociado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fonducar`.`NumeroAsociado` (
  `idNumeroAsociado` INT NOT NULL AUTO_INCREMENT,
  `Fecha` VARCHAR(50) NOT NULL,
  `idAsociado` INT NOT NULL,
  `idNumero` INT NOT NULL,
  PRIMARY KEY (`idNumeroAsociado`, `idAsociado`, `idNumero`),
  CONSTRAINT `fk_NumeroAsociado_Asociado1`
    FOREIGN KEY (`idAsociado`)
    REFERENCES `Fonducar`.`Asociado` (`idAsociado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NumeroAsociado_Numero1`
    FOREIGN KEY (`idNumero`)
    REFERENCES `Fonducar`.`Numero` (`idNumero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idNumeroAsociado_UNIQUE` ON `Fonducar`.`NumeroAsociado` (`idNumeroAsociado` ASC);

CREATE INDEX `fk_NumeroAsociado_Asociado1_idx` ON `Fonducar`.`NumeroAsociado` (`idAsociado` ASC);

CREATE INDEX `fk_NumeroAsociado_Numero1_idx` ON `Fonducar`.`NumeroAsociado` (`idNumero` ASC);


-- -----------------------------------------------------
-- Table `Fonducar`.`Sorteo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fonducar`.`Sorteo` (
  `idSorteo` INT NOT NULL AUTO_INCREMENT,
  `Fecha` VARCHAR(50) NOT NULL,
  `idNumeroAsociado` INT NOT NULL,
  PRIMARY KEY (`idSorteo`),
  CONSTRAINT `fk_Sorteo_NumeroAsociado1`
    FOREIGN KEY (`idNumeroAsociado`)
    REFERENCES `Fonducar`.`NumeroAsociado` (`idNumeroAsociado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idSorteo_UNIQUE` ON `Fonducar`.`Sorteo` (`idSorteo` ASC);

CREATE INDEX `fk_Sorteo_NumeroAsociado1_idx` ON `Fonducar`.`Sorteo` (`idNumeroAsociado` ASC);


-- -----------------------------------------------------
-- Table `Fonducar`.`PremioMayor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fonducar`.`PremioMayor` (
  `idPremioMayor` INT NOT NULL AUTO_INCREMENT,
  `idSorteo` INT NOT NULL,
  `ValorPremio` DOUBLE NOT NULL,
  PRIMARY KEY (`idPremioMayor`, `idSorteo`),
  CONSTRAINT `fk_PremioMayor_Sorteo1`
    FOREIGN KEY (`idSorteo`)
    REFERENCES `Fonducar`.`Sorteo` (`idSorteo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idPremioMayor_UNIQUE` ON `Fonducar`.`PremioMayor` (`idPremioMayor` ASC);

CREATE INDEX `fk_PremioMayor_Sorteo1_idx` ON `Fonducar`.`PremioMayor` (`idSorteo` ASC);


-- -----------------------------------------------------
-- Table `Fonducar`.`PremioMenor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fonducar`.`PremioMenor` (
  `idPremioMenor` INT NOT NULL AUTO_INCREMENT,
  `idSorteo` INT NOT NULL,
  `ValorPremio` DOUBLE NOT NULL,
  PRIMARY KEY (`idPremioMenor`, `idSorteo`),
  CONSTRAINT `fk_PremioMenor_Sorteo1`
    FOREIGN KEY (`idSorteo`)
    REFERENCES `Fonducar`.`Sorteo` (`idSorteo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idPremioMenor_UNIQUE` ON `Fonducar`.`PremioMenor` (`idPremioMenor` ASC);

CREATE INDEX `fk_PremioMenor_Sorteo1_idx` ON `Fonducar`.`PremioMenor` (`idSorteo` ASC);


-- -----------------------------------------------------
-- Table `Fonducar`.`Movimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fonducar`.`Movimiento` (
  `idMovimiento` INT NOT NULL AUTO_INCREMENT,
  `Fecha` VARCHAR(50) NOT NULL,
  `Detalle` VARCHAR(100) NOT NULL,
  `idAdministrador` INT NOT NULL,
  PRIMARY KEY (`idMovimiento`, `idAdministrador`),
  CONSTRAINT `fk_Movimiento_Administrador1`
    FOREIGN KEY (`idAdministrador`)
    REFERENCES `Fonducar`.`Administrador` (`idAdministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idMovimiento_UNIQUE` ON `Fonducar`.`Movimiento` (`idMovimiento` ASC);

CREATE INDEX `fk_Movimiento_Administrador1_idx` ON `Fonducar`.`Movimiento` (`idAdministrador` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
