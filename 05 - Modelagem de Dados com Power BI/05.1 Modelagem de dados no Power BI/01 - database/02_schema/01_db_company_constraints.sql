-- =============================================================================
-- CONFIGURAÇÃO INICIAL DO BANCO DE DADOS
-- =============================================================================
CREATE SCHEMA IF NOT EXISTS company_constraints;
USE company_constraints;

-- =============================================================================
-- 1. CRIAÇÃO DAS TABELAS (Estrutura Principal)
-- =============================================================================

-- Tabela: EMPLOYEE
CREATE TABLE employee (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL, 
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT NOT NULL DEFAULT 1,
    CONSTRAINT pk_employee PRIMARY KEY (Ssn),
    CONSTRAINT chk_salary_employee CHECK (Salary > 2000.0)
);

-- Tabela: DEPARTAMENT
CREATE TABLE departament (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE, 
    Dept_create_date DATE,
    CONSTRAINT pk_dept PRIMARY KEY (Dnumber),
    CONSTRAINT unique_name_dept UNIQUE (Dname),
    CONSTRAINT chk_date_dept CHECK (Dept_create_date < Mgr_start_date)
);

-- Tabela: DEPT_LOCATIONS
CREATE TABLE dept_locations (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dept_locations PRIMARY KEY (Dnumber, Dlocation)
);

-- Tabela: PROJECT
CREATE TABLE project (
    Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    CONSTRAINT pk_project PRIMARY KEY (Pnumber),
    CONSTRAINT unique_project UNIQUE (Pname)
);

-- Tabela: WORKS_ON
CREATE TABLE works_on (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    CONSTRAINT pk_works_on PRIMARY KEY (Essn, Pno)
);

-- Tabela: DEPENDENT
CREATE TABLE dependent (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(8),
    CONSTRAINT pk_dependent PRIMARY KEY (Essn, Dependent_name)
);


-- =============================================================================
-- 2. ADIÇÃO DAS CHAVES ESTRANGEIRAS (Relacionamentos)
-- =============================================================================

-- Relacionamento auto-referencial em EMPLOYEE
ALTER TABLE employee 
    ADD CONSTRAINT fk_employee_supervisor 
    FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- Relacionamentos em DEPARTAMENT
ALTER TABLE departament 
    ADD CONSTRAINT fk_dept_manager 
    FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
    ON UPDATE CASCADE;

-- Relacionamentos em DEPT_LOCATIONS
ALTER TABLE dept_locations 
    ADD CONSTRAINT fk_dept_locations 
    FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Relacionamentos em PROJECT
ALTER TABLE project 
    ADD CONSTRAINT fk_project_dept 
    FOREIGN KEY (Dnum) REFERENCES departament(Dnumber)
    ON UPDATE CASCADE;

-- Relacionamentos em WORKS_ON
ALTER TABLE works_on 
    ADD CONSTRAINT fk_works_on_employee 
    FOREIGN KEY (Essn) REFERENCES employee(Ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    ADD CONSTRAINT fk_works_on_project 
    FOREIGN KEY (Pno) REFERENCES project(Pnumber)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Relacionamentos em DEPENDENT
ALTER TABLE dependent 
    ADD CONSTRAINT fk_dependent_employee 
    FOREIGN KEY (Essn) REFERENCES employee(Ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


-- =============================================================================
-- 3. VERIFICAÇÃO E CONSULTAS DE INSPEÇÃO
-- =============================================================================
SHOW TABLES;

DESCRIBE employee;
DESCRIBE departament;
DESCRIBE dept_locations;
DESCRIBE project;
DESCRIBE works_on;
DESCRIBE dependent;

-- Consulta das constraints criadas no Schema
SELECT 
    CONSTRAINT_NAME, 
    TABLE_NAME, 
    CONSTRAINT_TYPE 
FROM information_schema.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'company_constraints';