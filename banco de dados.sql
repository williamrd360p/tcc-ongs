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
-- Table `mydb`.`tb_ong`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_ong` (
  `cd_ong` INT NOT NULL,
  `nm_ong` VARCHAR(45) NOT NULL,
  `cnpj_ong` VARCHAR(14) NOT NULL,
  `nm_email` VARCHAR(45) NOT NULL,
  `nr_telefone` VARCHAR(11) NOT NULL,
  `nm_endereco` VARCHAR(45) NOT NULL,
  `nr_endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cd_ong`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_aluno` (
  `cd_aluno` INT NOT NULL,
  `nm_aluno` VARCHAR(45) NOT NULL,
  `cpf_aluno` VARCHAR(45) NOT NULL,
  `dt_nascimento_aluno` DATE NOT NULL,
  `nm_responsavel` VARCHAR(45) NOT NULL,
  `fk_cd_ong` INT NOT NULL,
  PRIMARY KEY (`cd_aluno`, `fk_cd_ong`),
  INDEX `fk_tb_aluno_tb_ong1_idx` (`fk_cd_ong` ASC) VISIBLE,
  CONSTRAINT `fk_tb_aluno_tb_ong1`
    FOREIGN KEY (`fk_cd_ong`)
    REFERENCES `mydb`.`tb_ong` (`cd_ong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_administradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_administradores` (
  `cd_administradores` INT NOT NULL,
  `nm_administrador` VARCHAR(45) NOT NULL,
  `nm_senha` VARCHAR(45) NOT NULL,
  `nr_senha` INT NOT NULL,
  `ds_anotacoes` VARCHAR(45) NOT NULL,
  `tb_ong_fk_cd_usuario` INT NOT NULL,
  `tb_ong_cd_ong` INT NOT NULL,
  PRIMARY KEY (`cd_administradores`, `tb_ong_fk_cd_usuario`, `tb_ong_cd_ong`),
  INDEX `fk_tb_administradores_tb_ong1_idx` (`tb_ong_cd_ong` ASC) VISIBLE,
  CONSTRAINT `fk_tb_administradores_tb_ong1`
    FOREIGN KEY (`tb_ong_cd_ong`)
    REFERENCES `mydb`.`tb_ong` (`cd_ong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_calendario_projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_calendario_projeto` (
  `cd_projeto` INT NOT NULL,
  `nm_titulo_projeto` VARCHAR(45) NOT NULL,
  `ds_projeto` VARCHAR(45) NOT NULL,
  `dt_inicio` DATE NOT NULL,
  `dt_termino` DATE NOT NULL,
  `st_projeto` VARCHAR(45) NOT NULL,
  `fk_cd_ong` INT NOT NULL,
  `fk_cd_administradores` INT NOT NULL,
  PRIMARY KEY (`cd_projeto`, `fk_cd_ong`, `fk_cd_administradores`),
  INDEX `fk_tb_projeto_tb_ong1_idx` (`fk_cd_ong` ASC) VISIBLE,
  INDEX `fk_tb_calendario_projeto_tb_administradores1_idx` (`fk_cd_administradores` ASC) VISIBLE,
  CONSTRAINT `fk_tb_projeto_tb_ong1`
    FOREIGN KEY (`fk_cd_ong`)
    REFERENCES `mydb`.`tb_ong` (`cd_ong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_calendario_projeto_tb_administradores1`
    FOREIGN KEY (`fk_cd_administradores`)
    REFERENCES `mydb`.`tb_administradores` (`cd_administradores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_aula` (
  `cd_aula` INT NOT NULL,
  `nm_aula` VARCHAR(45) NOT NULL,
  `dt_aula` DATE NOT NULL,
  `nm_local` VARCHAR(45) NOT NULL,
  `dt_inicio` DATE NOT NULL,
  `dt_termino` DATE NOT NULL,
  `fk_cd_ong` INT NOT NULL,
  `tb_calendario_projeto_cd_projeto` INT NOT NULL,
  PRIMARY KEY (`cd_aula`, `fk_cd_ong`, `tb_calendario_projeto_cd_projeto`),
  INDEX `fk_tb_aula_tb_ong1_idx` (`fk_cd_ong` ASC) VISIBLE,
  INDEX `fk_tb_aula_tb_calendario_projeto1_idx` (`tb_calendario_projeto_cd_projeto` ASC) VISIBLE,
  CONSTRAINT `fk_tb_aula_tb_ong1`
    FOREIGN KEY (`fk_cd_ong`)
    REFERENCES `mydb`.`tb_ong` (`cd_ong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_aula_tb_calendario_projeto1`
    FOREIGN KEY (`tb_calendario_projeto_cd_projeto`)
    REFERENCES `mydb`.`tb_calendario_projeto` (`cd_projeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_voluntario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_voluntario` (
  `cd_voluntario` INT NOT NULL,
  `cpf_voluntario` CHAR(11) NOT NULL,
  `cnpj_voluntario` CHAR(14) NOT NULL,
  `dt_nascimento_voluntario` DATE NOT NULL,
  `rg_voluntario` CHAR(11) NOT NULL,
  `fk_cd_ong` INT NOT NULL,
  PRIMARY KEY (`cd_voluntario`, `fk_cd_ong`),
  INDEX `fk_tb_voluntario_tb_ong1_idx` (`fk_cd_ong` ASC) VISIBLE,
  CONSTRAINT `fk_tb_voluntario_tb_ong1`
    FOREIGN KEY (`fk_cd_ong`)
    REFERENCES `mydb`.`tb_ong` (`cd_ong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_aula_has_tb_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_aula_has_tb_aluno` (
  `fk_cd_aula` INT NOT NULL,
  `fk_cd_aluno` INT NOT NULL,
  PRIMARY KEY (`fk_cd_aula`, `fk_cd_aluno`),
  INDEX `fk_tb_aula_has_tb_aluno_tb_aluno1_idx` (`fk_cd_aluno` ASC) VISIBLE,
  INDEX `fk_tb_aula_has_tb_aluno_tb_aula1_idx` (`fk_cd_aula` ASC) VISIBLE,
  CONSTRAINT `fk_tb_aula_has_tb_aluno_tb_aula1`
    FOREIGN KEY (`fk_cd_aula`)
    REFERENCES `mydb`.`tb_aula` (`cd_aula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_aula_has_tb_aluno_tb_aluno1`
    FOREIGN KEY (`fk_cd_aluno`)
    REFERENCES `mydb`.`tb_aluno` (`cd_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_evento` (
  `cd_evento` INT NOT NULL,
  `nm_evento` VARCHAR(45) NOT NULL,
  `nm_local_evento` VARCHAR(45) NOT NULL,
  `dt_horario` DATETIME NOT NULL,
  `dt_dia` DATE NOT NULL,
  `img_evento` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cd_evento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_perfil` (
  `cd_perfil` INT NOT NULL,
  `img_perfil` VARCHAR(255) NOT NULL,
  `nm_usuario` VARCHAR(45) NOT NULL,
  `fk_cd_administradores` INT NOT NULL,
  PRIMARY KEY (`cd_perfil`, `fk_cd_administradores`),
  INDEX `fk_tb_perfil_tb_administradores1_idx` (`fk_cd_administradores` ASC) VISIBLE,
  CONSTRAINT `fk_tb_perfil_tb_administradores1`
    FOREIGN KEY (`fk_cd_administradores`)
    REFERENCES `mydb`.`tb_administradores` (`cd_administradores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_calendario_projeto_has_tb_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_calendario_projeto_has_tb_evento` (
  `fk_cd_projeto` INT NOT NULL,
  `fk_cd_evento` INT NOT NULL,
  PRIMARY KEY (`fk_cd_projeto`, `fk_cd_evento`),
  INDEX `fk_tb_calendario_projeto_has_tb_evento_tb_evento1_idx` (`fk_cd_evento` ASC) VISIBLE,
  INDEX `fk_tb_calendario_projeto_has_tb_evento_tb_calendario_projet_idx` (`fk_cd_projeto` ASC) VISIBLE,
  CONSTRAINT `fk_tb_calendario_projeto_has_tb_evento_tb_calendario_projeto1`
    FOREIGN KEY (`fk_cd_projeto`)
    REFERENCES `mydb`.`tb_calendario_projeto` (`cd_projeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_calendario_projeto_has_tb_evento_tb_evento1`
    FOREIGN KEY (`fk_cd_evento`)
    REFERENCES `mydb`.`tb_evento` (`cd_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
