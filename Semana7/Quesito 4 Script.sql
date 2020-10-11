-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`VOO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VOO` (
  `Numero_voo` INT NOT NULL,
  `Compainha_aerea` VARCHAR(45) NOT NULL,
  `Dias_da_semana` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Numero_voo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TARIFA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TARIFA` (
  `Numero_voo` INT NOT NULL,
  `Codigo_tafira` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  `Restricoes` VARCHAR(45) NULL,
  PRIMARY KEY (`Codigo_tafira`, `Numero_voo`),
  INDEX `Numero_voo_idx` (`Numero_voo` ASC),
  CONSTRAINT `Numero_voo`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `mydb`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AEROPORTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AEROPORTO` (
  `Codigo_aeroporto` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Cidade` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codigo_aeroporto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TRECHO_VOO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TRECHO_VOO` (
  `Numero_trecho` INT NOT NULL AUTO_INCREMENT,
  `Numero_voo` INT NOT NULL,
  `Codigo_aeroporto_partida` INT NOT NULL,
  `Codigo_aeroporo_chegada` INT NOT NULL,
  `Horario_partida_previsto` TIME NULL,
  `Horario_chegada_previsto` TIME NULL,
  PRIMARY KEY (`Numero_trecho`, `Numero_voo`),
  INDEX `Numero_voo_idx` (`Numero_voo` ASC),
  INDEX `codigo aeroporto_idx` (`Codigo_aeroporto_partida` ASC, `Codigo_aeroporo_chegada` ASC),
  CONSTRAINT `Numero_voo`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `mydb`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `codigo aeroporto`
    FOREIGN KEY (`Codigo_aeroporto_partida` , `Codigo_aeroporo_chegada`)
    REFERENCES `mydb`.`AEROPORTO` (`Codigo_aeroporto` , `Codigo_aeroporto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPO_AERONAVE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPO_AERONAVE` (
  `Nome_tipo_aeronave` VARCHAR(45) NOT NULL,
  `Qtd_max_assentos` INT NOT NULL,
  `Compainha` VARCHAR(45) NULL,
  PRIMARY KEY (`Nome_tipo_aeronave`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AERONAVE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AERONAVE` (
  `Codigo_aeronave` INT NOT NULL,
  `Numero_total_assentos` INT NOT NULL,
  `Tipo_aeronave` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codigo_aeronave`),
  INDEX `tipo aeronave_idx` (`Tipo_aeronave` ASC),
  CONSTRAINT `tipo aeronave`
    FOREIGN KEY (`Tipo_aeronave`)
    REFERENCES `mydb`.`TIPO_AERONAVE` (`Nome_tipo_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`INSTANCIA_TRECHO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`INSTANCIA_TRECHO` (
  `Numero_voo` INT NOT NULL,
  `Numero_trecho` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Numero_assentos_disponiveis` INT NOT NULL,
  `Codigo_aeronave` INT NOT NULL,
  `Codigo_aeroporto_partida` INT NOT NULL,
  `Horario_partida` TIME NOT NULL,
  `Codigo_aeroporto_chegada` INT NOT NULL,
  `Horario_chegada` TIME NOT NULL,
  PRIMARY KEY (`Numero_voo`, `Numero_trecho`, `Data`),
  INDEX `Codigo_aeronave_idx` (`Codigo_aeronave` ASC),
  INDEX `numero trecho_idx` (`Numero_trecho` ASC),
  INDEX `Codigo_aeroporto_idx` (`Codigo_aeroporto_partida` ASC, `Codigo_aeroporto_chegada` ASC),
  CONSTRAINT `Numero_voo`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `mydb`.`TRECHO_VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codigo_aeroporto`
    FOREIGN KEY (`Codigo_aeroporto_partida` , `Codigo_aeroporto_chegada`)
    REFERENCES `mydb`.`TRECHO_VOO` (`Codigo_aeroporto_partida` , `Codigo_aeroporo_chegada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codigo_aeronave`
    FOREIGN KEY (`Codigo_aeronave`)
    REFERENCES `mydb`.`AERONAVE` (`Codigo_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `numero trecho`
    FOREIGN KEY (`Numero_trecho`)
    REFERENCES `mydb`.`TRECHO_VOO` (`Numero_trecho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RESERVA_ASSENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RESERVA_ASSENTO` (
  `Numero_voo` INT NOT NULL,
  `Numero_trecho` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Numero_assento` INT NOT NULL,
  `Nome_cliente` VARCHAR(45) NOT NULL,
  `Telefone_cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Numero_voo`, `Numero_trecho`, `Data`, `Numero_assento`),
  INDEX `data_idx` (`Data` ASC),
  INDEX `num trecho_idx` (`Numero_trecho` ASC),
  CONSTRAINT `numero voo`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `mydb`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `data`
    FOREIGN KEY (`Data`)
    REFERENCES `mydb`.`INSTANCIA_TRECHO` (`Data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `num trecho`
    FOREIGN KEY (`Numero_trecho`)
    REFERENCES `mydb`.`INSTANCIA_TRECHO` (`Numero_trecho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PODE_POUSAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PODE_POUSAR` (
  `Nome_tipo_aeronave` VARCHAR(45) NOT NULL,
  `Codigo_aeroporto` INT NOT NULL,
  PRIMARY KEY (`Nome_tipo_aeronave`, `Codigo_aeroporto`),
  INDEX `codigo aeroporto_idx` (`Codigo_aeroporto` ASC),
  CONSTRAINT `codigo aeroporto`
    FOREIGN KEY (`Codigo_aeroporto`)
    REFERENCES `mydb`.`AEROPORTO` (`Codigo_aeroporto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo aeronave`
    FOREIGN KEY (`Nome_tipo_aeronave`)
    REFERENCES `mydb`.`TIPO_AERONAVE` (`Nome_tipo_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
