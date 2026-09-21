-- =============================================================================
-- Arquivo: 02_seed_universidade.sql
-- Descrição: Povoamento expandido do banco de dados 'universidade' com limpeza prévia.
-- =============================================================================

USE `universidade`;

-- Desativa temporariamente a verificação de chaves estrangeiras para permitir o TRUNCATE
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------------------------------
-- LIMPEZA DAS TABELAS (Esvazia todos os dados mantendo a estrutura)
-- -----------------------------------------------------------------------------
TRUNCATE TABLE `Matriculado`;
TRUNCATE TABLE `Disciplina & Curso`;
TRUNCATE TABLE `Pré-requisitos das disciplinas`;
TRUNCATE TABLE `Pré-requisitos`;
TRUNCATE TABLE `Disciplina`;
TRUNCATE TABLE `Curso`;
TRUNCATE TABLE `Professor`;
TRUNCATE TABLE `Departamento`;
TRUNCATE TABLE `Aluno`;

-- -----------------------------------------------------------------------------
-- POVOAMENTO DOS DADOS
-- -----------------------------------------------------------------------------

-- 1. Povoando a tabela `Aluno` (50 Alunos)
INSERT INTO `Aluno` (`idAluno`) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35), (36), (37), (38), (39), (40),
(41), (42), (43), (44), (45), (46), (47), (48), (49), (50);

-- 2. Povoando a tabela `Pré-requisitos` (15 Registros)
INSERT INTO `Pré-requisitos` (`idPré-requisitos`) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15);

-- 3. Povoando a tabela `Departamento` (8 Departamentos)
INSERT INTO `Departamento` (`idDepartamento`, `Nome`, `Campus`, `idProfessor_coordenador`) VALUES
(1, 'Ciência da Computação', 'Campus Central', NULL),
(2, 'Engenharia Elétrica', 'Campus Norte', NULL),
(3, 'Matemática e Estatística', 'Campus Central', NULL),
(4, 'Física', 'Campus Sul', NULL),
(5, 'Engenharia Civil', 'Campus Norte', NULL),
(6, 'Administração', 'Campus Central', NULL),
(7, 'Química', 'Campus Sul', NULL),
(8, 'Biologia', 'Campus Sul', NULL);

-- 4. Povoando a tabela `Professor` (20 Professores)
INSERT INTO `Professor` (`idProfessor`, `Departamento_idDepartamento`) VALUES
-- Computação (Depto 1)
(1, 1), (2, 1), (3, 1), (4, 1),
-- Eng. Elétrica (Depto 2)
(5, 2), (6, 2),
-- Matemática (Depto 3)
(7, 3), (8, 3), (9, 3),
-- Física (Depto 4)
(10, 4), (11, 4),
-- Eng. Civil (Depto 5)
(12, 5), (13, 5),
-- Administração (Depto 6)
(14, 6), (15, 6), (16, 6),
-- Química (Depto 7)
(17, 7), (18, 7),
-- Biologia (Depto 8)
(19, 8), (20, 8);

-- 5. Atualizando Coordenadores de Departamento (1 por Depto)
UPDATE `Departamento` SET `idProfessor_coordenador` = 1 WHERE `idDepartamento` = 1;
UPDATE `Departamento` SET `idProfessor_coordenador` = 5 WHERE `idDepartamento` = 2;
UPDATE `Departamento` SET `idProfessor_coordenador` = 7 WHERE `idDepartamento` = 3;
UPDATE `Departamento` SET `idProfessor_coordenador` = 10 WHERE `idDepartamento` = 4;
UPDATE `Departamento` SET `idProfessor_coordenador` = 12 WHERE `idDepartamento` = 5;
UPDATE `Departamento` SET `idProfessor_coordenador` = 14 WHERE `idDepartamento` = 6;
UPDATE `Departamento` SET `idProfessor_coordenador` = 17 WHERE `idDepartamento` = 7;
UPDATE `Departamento` SET `idProfessor_coordenador` = 19 WHERE `idDepartamento` = 8;

-- 6. Povoando a tabela `Curso` (12 Cursos)
INSERT INTO `Curso` (`idCurso`, `Departamento_idDepartamento`) VALUES
(1, 1), -- Ciência da Computação
(2, 1), -- Engenharia de Software
(3, 1), -- Sistemas de Informação
(4, 2), -- Engenharia Elétrica
(5, 2), -- Engenharia de Automação
(6, 3), -- Licenciatura em Matemática
(7, 3), -- Estatística e Ciência de Dados
(8, 4), -- Bacharelado em Física
(9, 5), -- Engenharia Civil
(10, 6),-- Administração de Empresas
(11, 7),-- Química Industrial
(12, 8);-- Ciências Biológicas

-- 7. Povoando a tabela `Disciplina` (25 Disciplinas)
INSERT INTO `Disciplina` (`idDisciplina`, `Professor_idProfessor`) VALUES
(1, 1),  -- Algoritmos e Programação I
(2, 1),  -- Estruturas de Dados
(3, 2),  -- Banco de Dados I
(4, 2),  -- Banco de Dados II
(5, 3),  -- Engenharia de Software I
(6, 4),  -- Inteligência Artificial
(7, 5),  -- Circuitos Elétricos I
(8, 6),  -- Sistemas Embarcados
(9, 7),  -- Cálculo I
(10, 7), -- Cálculo II
(11, 8), -- Álgebra Linear
(12, 9), -- Estatística Aplicada
(13, 10),-- Física Geral I
(14, 11),-- Física Geral II
(15, 12),-- Resistência dos Materiais
(16, 13),-- Mecânica dos Solos
(17, 14),-- Introdução à Administração
(18, 15),-- Gestão Financeira
(19, 16),-- Marketing Digital
(20, 17),-- Química Geral
(21, 18),-- Química Orgânica
(22, 19),-- Biologia Celular
(23, 20),-- Genética
(24, 3), -- Redes de Computadores
(25, 4); -- Arquitetura de Computadores

-- 8. Povoando a tabela `Matriculado` (Aluno <-> Disciplina)
INSERT INTO `Matriculado` (`Aluno_idAluno`, `Disciplina_idDisciplina`) VALUES
-- Alunos 1 a 10 (Foco em Computação / Exatas)
(1, 1), (1, 9), (1, 11), (1, 13),
(2, 1), (2, 9), (2, 12),
(3, 2), (3, 3), (3, 10),
(4, 3), (4, 4), (4, 5), (4, 24),
(5, 5), (5, 6), (5, 25),
(6, 1), (6, 9),
(7, 2), (7, 11),
(8, 3), (8, 24),
(9, 6), (9, 25),
(10, 4), (10, 5),

-- Alunos 11 a 20 (Foco em Engenharias e Física)
(11, 7), (11, 9), (11, 13),
(12, 7), (12, 8), (12, 10), (12, 14),
(13, 9), (13, 13), (13, 15),
(14, 10), (14, 15), (14, 16),
(15, 13), (15, 14),
(16, 7), (16, 11),
(17, 8), (17, 25),
(18, 15), (18, 16),
(19, 9), (19, 10), (19, 11),
(20, 12), (20, 17),

-- Alunos 21 a 30 (Foco em Administração e Humanas/Exatas)
(21, 17), (21, 18),
(22, 17), (22, 19), (22, 12),
(23, 18), (23, 19),
(24, 12), (24, 17),
(25, 1), (25, 17),
(26, 18), (26, 12),
(27, 19),
(28, 17), (28, 18), (28, 19),
(29, 12), (29, 18),
(30, 1), (30, 3), (30, 17),

-- Alunos 31 a 40 (Foco em Química e Biologia)
(31, 20), (31, 22), (31, 13),
(32, 20), (32, 21),
(33, 21), (33, 23),
(34, 22), (34, 23),
(35, 20), (35, 9),
(36, 21), (36, 22),
(37, 23), (37, 12),
(38, 20), (38, 21), (38, 23),
(39, 22), (39, 9),
(40, 13), (40, 20),

-- Alunos 41 a 50 (Iniciantes e Mistas)
(41, 1), (41, 9),
(42, 1), (42, 13), (42, 17),
(43, 9), (43, 20),
(44, 7), (44, 9),
(45, 17), (45, 20),
(46, 2), (46, 11),
(47, 3), (47, 12),
(48, 15), (48, 9),
(49, 18), (49, 12),
(50, 6), (50, 24);

-- 9. Povoando a tabela `Disciplina & Curso` (Múltiplos Cursos por Disciplina)
INSERT INTO `Disciplina & Curso` (`Disciplina_idDisciplina`, `Curso_idCurso`) VALUES
-- Algoritmos e Programação I
(1, 1), (1, 2), (1, 3), (1, 4), (1, 7),
-- Estruturas de Dados
(2, 1), (2, 2), (2, 3),
-- Banco de Dados I
(3, 1), (3, 2), (3, 3), (3, 10),
-- Banco de Dados II
(4, 1), (4, 2), (4, 3),
-- Engenharia de Software I
(5, 1), (5, 2), (5, 3),
-- Inteligência Artificial
(6, 1), (6, 2), (6, 7),
-- Circuitos Elétricos I
(7, 4), (7, 5),
-- Sistemas Embarcados
(8, 4), (8, 5), (8, 1),
-- Cálculo I
(9, 1), (9, 2), (9, 4), (9, 5), (9, 6), (9, 7), (9, 8), (9, 9),
-- Cálculo II
(10, 4), (10, 5), (10, 6), (10, 7), (10, 8), (10, 9),
-- Álgebra Linear
(11, 1), (11, 4), (11, 5), (11, 6), (11, 7),
-- Estatística Aplicada
(12, 1), (12, 3), (12, 6), (12, 7), (12, 10), (12, 12),
-- Física Geral I
(13, 4), (13, 5), (13, 8), (13, 9), (13, 11),
-- Física Geral II
(14, 4), (14, 5), (14, 8), (14, 9),
-- Resistência dos Materiais
(15, 5), (15, 9),
-- Mecânica dos Solos
(16, 9),
-- Introdução à Administração
(17, 10), (17, 3),
-- Gestão Financeira
(18, 10),
-- Marketing Digital
(19, 10), (19, 3),
-- Química Geral
(20, 11), (20, 12), (20, 8), (20, 9),
-- Química Orgânica
(21, 11), (21, 12),
-- Biologia Celular
(22, 12), (22, 11),
-- Genética
(23, 12),
-- Redes de Computadores
(24, 1), (24, 2), (24, 3),
-- Arquitetura de Computadores
(25, 1), (25, 2), (25, 4);

-- 10. Povoando a tabela `Pré-requisitos das disciplinas`
INSERT INTO `Pré-requisitos das disciplinas` (`Disciplina_idDisciplina`, `Pré-requisitos_idPré-requisitos`) VALUES
-- Estruturas de Dados precisa do Pré-requisito 1
(2, 1),
-- Banco de Dados II precisa do Pré-requisito 2
(4, 2),
-- Engenharia de Software precisa do Pré-requisito 1
(5, 1),
-- Inteligência Artificial precisa dos Pré-requisitos 1 e 3
(6, 1),
(6, 3),
-- Sistemas Embarcados precisa do Pré-requisito 4
(8, 4),
-- Cálculo II precisa do Pré-requisito 5
(10, 5),
-- Física Geral II precisa do Pré-requisito 6 e 5
(14, 6),
(14, 5),
-- Mecânica dos Solos precisa do Pré-requisito 7
(16, 7),
-- Química Orgânica precisa do Pré-requisito 8
(21, 8),
-- Genética precisa do Pré-requisito 9
(23, 9);

-- Reativa a verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;