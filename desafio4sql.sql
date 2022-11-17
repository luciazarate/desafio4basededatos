-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio` DEFAULT CHARACTER SET utf8 ;
USE `portfolio` ;

-- -----------------------------------------------------
-- Table `portfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona` (
  `idpersona` INT NOT NULL,
  `dni` INT(8) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `domicilio` VARCHAR(45) NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `edad` TINYINT(3) NULL,
  `telefono1` VARCHAR(15) NOT NULL,
  `telefono2` VARCHAR(15) NULL,
  `img_foto` VARCHAR(200) NULL,
  `sobre_mi` VARCHAR(200) NULL,
  PRIMARY KEY (`idpersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`domicilio` (
  `iddomicilio` INT NOT NULL,
  `pais` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  `departamento` VARCHAR(45) NULL,
  `calle` VARCHAR(45) NULL,
  `altura` SMALLINT(5) NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`iddomicilio`, `persona_idpersona`),
  INDEX `fk_domicilio_persona_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_domicilio_persona`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`educacion` (
  `ideducacion` INT NOT NULL,
  `establecimiento` VARCHAR(45) NULL,
  `nivel_educ` VARCHAR(45) NULL,
  `fecha_ing` DATE NULL,
  `fecha_egr` DATE NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`ideducacion`, `persona_idpersona`),
  INDEX `fk_educacion_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`experiencia_laboral` (
  `idlaboral` INT NOT NULL,
  `empresa` VARCHAR(45) NOT NULL,
  `fecha_ing` DATE NOT NULL,
  `fecha_egr` DATE NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idlaboral`, `persona_idpersona`),
  INDEX `fk_experiencias_laboral_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_experiencias_laboral_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`usuario` (
  `idusuarios` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idusuarios`, `persona_idpersona`),
  INDEX `fk_usuarios_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`Hard&SoftSkills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`Hard&SoftSkills` (
  `idhard&softskills` INT NOT NULL,
  `tecnologia` VARCHAR(45) NOT NULL,
  `Nivel` VARCHAR(45) NOT NULL,
  `img_logo` VARCHAR(200) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idhard&softskills`, `persona_idpersona`),
  INDEX `fk_Hard&SoftSkills_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_Hard&SoftSkills_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto` (
  `idproyecto` INT NOT NULL,
  `nombre_proyecto` VARCHAR(45) NOT NULL,
  `version` VARCHAR(45) NOT NULL,
  `descripcion` LONGTEXT NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idproyecto`, `persona_idpersona`),
  INDEX `fk_proyecto_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`rol` (
  `idrol` INT NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`rol_has_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`rol_has_usuario` (
  `rol_idrol` INT NOT NULL,
  `usuario_idusuarios` INT NOT NULL,
  `usuario_persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`rol_idrol`, `usuario_idusuarios`, `usuario_persona_idpersona`),
  INDEX `fk_rol_has_usuario_usuario1_idx` (`usuario_idusuarios` ASC, `usuario_persona_idpersona` ASC) VISIBLE,
  INDEX `fk_rol_has_usuario_rol1_idx` (`rol_idrol` ASC) VISIBLE,
  CONSTRAINT `fk_rol_has_usuario_rol1`
    FOREIGN KEY (`rol_idrol`)
    REFERENCES `portfolio`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_has_usuario_usuario1`
    FOREIGN KEY (`usuario_idusuarios` , `usuario_persona_idpersona`)
    REFERENCES `portfolio`.`usuario` (`idusuarios` , `persona_idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
