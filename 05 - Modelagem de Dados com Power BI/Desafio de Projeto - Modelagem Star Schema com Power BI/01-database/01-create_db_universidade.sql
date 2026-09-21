-- -----------------------------------------------------
-- Criação do Banco de Dados
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `universidade` DEFAULT CHARACTER SET utf8mb4 ;
USE `universidade` ;

-- -----------------------------------------------------
-- Tabela `Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aluno` (
  `idAluno` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idAluno`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `Pré-requisitos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pré-requisitos` (
  `idPré-requisitos` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idPré-requisitos`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `Departamento` (Criação inicial sem a FK do coordenador para evitar dependência circular)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Campus` VARCHAR(45) NULL,
  `idProfessor_coordenador` INT NULL,
  PRIMARY KEY (`idDepartamento`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Professor` (
  `idProfessor` INT NOT NULL AUTO_INCREMENT,
  `Departamento_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idProfessor`),
  CONSTRAINT `fk_Professor_Departamento`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Adiciona a restrição da FK `idProfessor_coordenador` na tabela `Departamento`
-- -----------------------------------------------------
ALTER TABLE `Departamento`
  ADD CONSTRAINT `fk_Departamento_Professor_Coordenador`
    FOREIGN KEY (`idProfessor_coordenador`)
    REFERENCES `Professor` (`idProfessor`)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Tabela `Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Curso` (
  `idCurso` INT NOT NULL AUTO_INCREMENT,
  `Departamento_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idCurso`),
  CONSTRAINT `fk_Curso_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Disciplina` (
  `idDisciplina` INT NOT NULL AUTO_INCREMENT,
  `Professor_idProfessor` INT NOT NULL,
  PRIMARY KEY (`idDisciplina`),
  CONSTRAINT `fk_Disciplina_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `Matriculado` (Tabela associativa Aluno <-> Disciplina)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matriculado` (
  `Aluno_idAluno` INT NOT NULL,
  `Disciplina_idDisciplina` INT NOT NULL,
  PRIMARY KEY (`Aluno_idAluno`, `Disciplina_idDisciplina`),
  CONSTRAINT `fk_Aluno_has_Disciplina_Aluno1`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `Disciplina & Curso` (Tabela associativa Disciplina <-> Curso)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Disciplina & Curso` (
  `Disciplina_idDisciplina` INT NOT NULL,
  `Curso_idCurso` INT NOT NULL,
  PRIMARY KEY (`Disciplina_idDisciplina`, `Curso_idCurso`),
  CONSTRAINT `fk_Disciplina_has_Curso_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disciplina_has_Curso_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `Pré-requisitos das disciplinas` (Tabela associativa Disciplina <-> Pré-requisitos)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pré-requisitos das disciplinas` (
  `Disciplina_idDisciplina` INT NOT NULL,
  `Pré-requisitos_idPré-requisitos` INT NOT NULL,
  PRIMARY KEY (`Disciplina_idDisciplina`, `Pré-requisitos_idPré-requisitos`),
  CONSTRAINT `fk_Disciplina_has_Pré-requisitos_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disciplina_has_Pré-requisitos_Pré-requisitos1`
    FOREIGN KEY (`Pré-requisitos_idPré-requisitos`)
    REFERENCES `Pré-requisitos` (`idPré-requisitos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;