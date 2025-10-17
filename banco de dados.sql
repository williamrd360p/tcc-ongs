-- DROP TABLE IF EXISTS tb_calendario_projeto_has_tb_evento;
-- DROP TABLE IF EXISTS tb_perfil;
-- DROP TABLE IF EXISTS tb_aula_has_tb_aluno;
-- DROP TABLE IF EXISTS tb_aula;
-- DROP TABLE IF EXISTS tb_calendario_projeto;
-- DROP TABLE IF EXISTS tb_evento;
-- DROP TABLE IF EXISTS tb_usuario;
-- DROP TABLE IF EXISTS tb_ong;

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;

-- Tabela ONG
CREATE TABLE IF NOT EXISTS `tb_ong` (
  `cd_ong` INT NOT NULL AUTO_INCREMENT,
  `nm_ong` VARCHAR(45) NOT NULL,
  `cnpj_ong` VARCHAR(14) NOT NULL,
  `nm_email` VARCHAR(45) NOT NULL,
  `nr_telefone` VARCHAR(11) NOT NULL,
  `nm_endereco` VARCHAR(45) NOT NULL,
  `nr_endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cd_ong`)
) ENGINE=InnoDB;

-- Tabela Usuário (unificada para administrador, voluntário e aluno)
CREATE TABLE IF NOT EXISTS `tb_usuario` (
  `cd_usuario` INT NOT NULL AUTO_INCREMENT,
  `nm_usuario` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) DEFAULT NULL,
  `cnpj` VARCHAR(14) DEFAULT NULL,
  `rg` VARCHAR(20) DEFAULT NULL,
  `dt_nascimento` DATE DEFAULT NULL,
  `nm_responsavel` VARCHAR(100) DEFAULT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `senha` VARCHAR(255) DEFAULT NULL,
  `tipo_usuario` ENUM('administrador','voluntario','aluno') NOT NULL,
  `fk_cd_ong` INT NOT NULL,
  PRIMARY KEY (`cd_usuario`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  CONSTRAINT `fk_usuario_ong` FOREIGN KEY (`fk_cd_ong`) REFERENCES `tb_ong`(`cd_ong`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Tabela Calendário de Projeto
CREATE TABLE IF NOT EXISTS `tb_calendario_projeto` (
  `cd_projeto` INT NOT NULL AUTO_INCREMENT,
  `nm_titulo_projeto` VARCHAR(45) NOT NULL,
  `ds_projeto` VARCHAR(255) NOT NULL,
  `dt_inicio` DATE NOT NULL,
  `dt_termino` DATE NOT NULL,
  `st_projeto` VARCHAR(45) NOT NULL,
  `fk_cd_ong` INT NOT NULL,
  `fk_cd_administrador` INT NOT NULL,
  PRIMARY KEY (`cd_projeto`),
  INDEX `idx_fk_cd_ong` (`fk_cd_ong`),
  INDEX `idx_fk_cd_administrador` (`fk_cd_administrador`),
  CONSTRAINT `fk_calendario_projeto_ong` FOREIGN KEY (`fk_cd_ong`) REFERENCES `tb_ong` (`cd_ong`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_calendario_projeto_administrador` FOREIGN KEY (`fk_cd_administrador`) REFERENCES `tb_usuario` (`cd_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Tabela Aula
CREATE TABLE IF NOT EXISTS `tb_aula` (
  `cd_aula` INT NOT NULL AUTO_INCREMENT,
  `nm_aula` VARCHAR(45) NOT NULL,
  `dt_aula` DATE NOT NULL,
  `nm_local` VARCHAR(45) NOT NULL,
  `dt_inicio` DATE NOT NULL,
  `dt_termino` DATE NOT NULL,
  `fk_cd_ong` INT NOT NULL,
  `fk_cd_projeto` INT NOT NULL,
  PRIMARY KEY (`cd_aula`),
  INDEX `idx_fk_cd_ong` (`fk_cd_ong`),
  INDEX `idx_fk_cd_projeto` (`fk_cd_projeto`),
  CONSTRAINT `fk_aula_ong` FOREIGN KEY (`fk_cd_ong`) REFERENCES `tb_ong` (`cd_ong`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_aula_projeto` FOREIGN KEY (`fk_cd_projeto`) REFERENCES `tb_calendario_projeto` (`cd_projeto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Tabela Relação Aula x Aluno
CREATE TABLE IF NOT EXISTS `tb_aula_has_tb_usuario` (
  `fk_cd_aula` INT NOT NULL,
  `fk_cd_usuario` INT NOT NULL,
  PRIMARY KEY (`fk_cd_aula`, `fk_cd_usuario`),
  INDEX `idx_fk_cd_aula` (`fk_cd_aula`),
  INDEX `idx_fk_cd_usuario` (`fk_cd_usuario`),
  CONSTRAINT `fk_aula_has_aula` FOREIGN KEY (`fk_cd_aula`) REFERENCES `tb_aula` (`cd_aula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_aula_has_usuario` FOREIGN KEY (`fk_cd_usuario`) REFERENCES `tb_usuario` (`cd_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Tabela Evento
CREATE TABLE IF NOT EXISTS `tb_evento` (
  `cd_evento` INT NOT NULL AUTO_INCREMENT,
  `nm_evento` VARCHAR(45) NOT NULL,
  `nm_local_evento` VARCHAR(45) NOT NULL,
  `dt_horario` DATETIME NOT NULL,
  `dt_dia` DATE NOT NULL,
  `img_evento` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cd_evento`)
) ENGINE=InnoDB;

-- Tabela Perfil (associada ao administrador)
CREATE TABLE IF NOT EXISTS `tb_perfil` (
  `cd_perfil` INT NOT NULL AUTO_INCREMENT,
  `img_perfil` VARCHAR(255) NOT NULL,
  `nm_usuario` VARCHAR(45) NOT NULL,
  `fk_cd_usuario` INT NOT NULL,
  PRIMARY KEY (`cd_perfil`),
  INDEX `idx_fk_cd_usuario` (`fk_cd_usuario`),
  CONSTRAINT `fk_perfil_usuario` FOREIGN KEY (`fk_cd_usuario`) REFERENCES `tb_usuario` (`cd_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Tabela relacionamento projeto e evento
CREATE TABLE IF NOT EXISTS `tb_calendario_projeto_has_tb_evento` (
  `fk_cd_projeto` INT NOT NULL,
  `fk_cd_evento` INT NOT NULL,
  PRIMARY KEY (`fk_cd_projeto`, `fk_cd_evento`),
  INDEX `idx_fk_evento` (`fk_cd_evento`),
  INDEX `idx_fk_projeto` (`fk_cd_projeto`),
  CONSTRAINT `fk_projeto_evento_projeto` FOREIGN KEY (`fk_cd_projeto`) REFERENCES `tb_calendario_projeto` (`cd_projeto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_projeto_evento_evento` FOREIGN KEY (`fk_cd_evento`) REFERENCES `tb_evento` (`cd_evento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;
