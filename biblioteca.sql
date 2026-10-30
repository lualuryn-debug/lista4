-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`amigaveis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`amigaveis` (
  `id_amigavel` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `localizacao` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_amigavel`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`amuleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`amuleto` (
  `id_amuleto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `tipo` VARCHAR(50) NULL DEFAULT NULL,
  `efeito` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_amuleto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`chefes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`chefes` (
  `id_chefe` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `nivel` INT NULL DEFAULT NULL,
  `localizacao` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_chefe`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`habilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`habilidade` (
  `id_habilidade` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `tipo` VARCHAR(50) NULL DEFAULT NULL,
  `custo` INT NULL DEFAULT NULL,
  `icone` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_habilidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`protagonista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`protagonista` (
  `id_protagonista` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `data_criacao` DATE NULL DEFAULT NULL,
  `amuleto_id_amuleto` INT NOT NULL,
  PRIMARY KEY (`id_protagonista`, `amuleto_id_amuleto`),
  INDEX `fk_protagonista_amuleto1_idx` (`amuleto_id_amuleto` ASC) VISIBLE,
  CONSTRAINT `fk_protagonista_amuleto1`
    FOREIGN KEY (`amuleto_id_amuleto`)
    REFERENCES `biblioteca`.`amuleto` (`id_amuleto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`interage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`interage` (
  `id_interacao` INT NOT NULL AUTO_INCREMENT,
  `id_amigavel` INT NULL DEFAULT NULL,
  `id_protagonista` INT NULL DEFAULT NULL,
  `tipo_interacao` VARCHAR(50) NULL DEFAULT NULL,
  `data_interacao` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_interacao`),
  INDEX `id_amigavel` (`id_amigavel` ASC) VISIBLE,
  INDEX `id_protagonista` (`id_protagonista` ASC) VISIBLE,
  CONSTRAINT `interage_ibfk_1`
    FOREIGN KEY (`id_amigavel`)
    REFERENCES `biblioteca`.`amigaveis` (`id_amigavel`),
  CONSTRAINT `interage_ibfk_2`
    FOREIGN KEY (`id_protagonista`)
    REFERENCES `biblioteca`.`protagonista` (`id_protagonista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`mapa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`mapa` (
  `id_mapa` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `tipo` VARCHAR(50) NULL DEFAULT NULL,
  `area` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_mapa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`protagonista_habilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`protagonista_habilidade` (
  `id_protagonista` INT NOT NULL,
  `id_habilidade` INT NOT NULL,
  PRIMARY KEY (`id_protagonista`, `id_habilidade`),
  INDEX `id_habilidade` (`id_habilidade` ASC) VISIBLE,
  CONSTRAINT `protagonista_habilidade_ibfk_1`
    FOREIGN KEY (`id_protagonista`)
    REFERENCES `biblioteca`.`protagonista` (`id_protagonista`),
  CONSTRAINT `protagonista_habilidade_ibfk_2`
    FOREIGN KEY (`id_habilidade`)
    REFERENCES `biblioteca`.`habilidade` (`id_habilidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`mapa_has_amigaveis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`mapa_has_amigaveis` (
  `mapa_id_mapa` INT NOT NULL,
  `amigaveis_id_amigavel` INT NOT NULL,
  PRIMARY KEY (`mapa_id_mapa`, `amigaveis_id_amigavel`),
  INDEX `fk_mapa_has_amigaveis_amigaveis1_idx` (`amigaveis_id_amigavel` ASC) VISIBLE,
  INDEX `fk_mapa_has_amigaveis_mapa1_idx` (`mapa_id_mapa` ASC) VISIBLE,
  CONSTRAINT `fk_mapa_has_amigaveis_mapa1`
    FOREIGN KEY (`mapa_id_mapa`)
    REFERENCES `biblioteca`.`mapa` (`id_mapa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mapa_has_amigaveis_amigaveis1`
    FOREIGN KEY (`amigaveis_id_amigavel`)
    REFERENCES `biblioteca`.`amigaveis` (`id_amigavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`habilidade_has_mapa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`habilidade_has_mapa` (
  `habilidade_id_habilidade` INT NOT NULL,
  `mapa_id_mapa` INT NOT NULL,
  PRIMARY KEY (`habilidade_id_habilidade`, `mapa_id_mapa`),
  INDEX `fk_habilidade_has_mapa_mapa1_idx` (`mapa_id_mapa` ASC) VISIBLE,
  INDEX `fk_habilidade_has_mapa_habilidade1_idx` (`habilidade_id_habilidade` ASC) VISIBLE,
  CONSTRAINT `fk_habilidade_has_mapa_habilidade1`
    FOREIGN KEY (`habilidade_id_habilidade`)
    REFERENCES `biblioteca`.`habilidade` (`id_habilidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_habilidade_has_mapa_mapa1`
    FOREIGN KEY (`mapa_id_mapa`)
    REFERENCES `biblioteca`.`mapa` (`id_mapa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `biblioteca`.`amuleto_has_mapa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`amuleto_has_mapa` (
  `amuleto_id_amuleto` INT NOT NULL,
  `mapa_id_mapa` INT NOT NULL,
  PRIMARY KEY (`amuleto_id_amuleto`, `mapa_id_mapa`),
  INDEX `fk_amuleto_has_mapa_mapa1_idx` (`mapa_id_mapa` ASC) VISIBLE,
  INDEX `fk_amuleto_has_mapa_amuleto1_idx` (`amuleto_id_amuleto` ASC) VISIBLE,
  CONSTRAINT `fk_amuleto_has_mapa_amuleto1`
    FOREIGN KEY (`amuleto_id_amuleto`)
    REFERENCES `biblioteca`.`amuleto` (`id_amuleto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_amuleto_has_mapa_mapa1`
    FOREIGN KEY (`mapa_id_mapa`)
    REFERENCES `biblioteca`.`mapa` (`id_mapa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
