# Dicionário de Dados — Base `company_constraints`

### 1. Tabela: `employee`
Armazena as informações cadastrais e hierárquicas de todos os colaboradores[cite: 1].

| Coluna | Tipo SQL | Tipo Power Query | Chave | Permite Nulo? | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Fname** | `VARCHAR(15)` | Texto | - | Não | Primeiro nome do colaborador. |
| **Minit** | `CHAR(1)` | Texto | - | Sim | Inicial do nome do meio. |
| **Lname** | `VARCHAR(15)` | Texto | - | Não | Sobrenome do colaborador. |
| **Ssn** | `CHAR(9)` | Texto | **PK** | Não | Número de Identificação Social (CPF/SSN). |
| **Bdate** | `DATE` | Data | - | Sim | Data de nascimento. |
| **Address** | `VARCHAR(30)`| Texto | - | Sim | Endereço residencial completo. |
| **Sex** | `CHAR(1)` | Texto | - | Sim | Gênero (`M`/`F`). |
| **Salary** | `DECIMAL(10,2)`| Número Decimal Fixo | - | Sim | Salário do colaborador[cite: 1]. |
| **Super_ssn** | `CHAR(9)` | Texto | **FK** | Sim | SSN do supervisor imediato (referencia `employee.Ssn`)[cite: 1]. |
| **Dno** | `INT` | Número Inteiro | **FK** | Não | Número do departamento ao qual pertence (referencia `departament.Dnumber`). |

---

### 2. Tabela: `departament`
Armazena os departamentos da empresa e o responsável por cada um[cite: 1].

| Coluna | Tipo SQL | Tipo Power Query | Chave | Permite Nulo? | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Dname** | `VARCHAR(15)` | Texto | **UK** | Não | Nome único do departamento[cite: 1]. |
| **Dnumber** | `INT` | Número Inteiro | **PK** | Não | Código identificador do departamento[cite: 1]. |
| **Mgr_ssn** | `CHAR(9)` | Texto | **FK** | Não | SSN do gerente responsável pelo departamento (referencia `employee.Ssn`)[cite: 1]. |
| **Mgr_start_date** | `DATE` | Data | - | Sim | Data de início da gestão do gerente atual. |
| **Dept_create_date**| `DATE` | Data | - | Sim | Data de criação do departamento. |

---

### 3. Tabela: `dept_locations`
Mapeia as localizações físicas de cada departamento[cite: 1].

| Coluna | Tipo SQL | Tipo Power Query | Chave | Permite Nulo? | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Dnumber** | `INT` | Número Inteiro | **PK / FK** | Não | Código do departamento (referencia `departament.Dnumber`)[cite: 1]. |
| **Dlocation** | `VARCHAR(15)` | Texto | **PK** | Não | Nome da cidade/localização física. |

---

### 4. Tabela: `project`
Contém os projetos desenvolvidos pela empresa[cite: 1].

| Coluna | Tipo SQL | Tipo Power Query | Chave | Permite Nulo? | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Pname** | `VARCHAR(15)` | Texto | **UK** | Não | Nome do projeto. |
| **Pnumber** | `INT` | Número Inteiro | **PK** | Não | Código identificador do projeto. |
| **Plocation** | `VARCHAR(15)` | Texto | - | Sim | Cidade de execução do projeto. |
| **Dnum** | `INT` | Número Inteiro | **FK** | Não | Código do departamento responsável pelo projeto (referencia `departament.Dnumber`). |

---

### 5. Tabela: `works_on`
Tabela Fato/Relacional que registra a quantidade de horas dedicadas por cada colaborador a cada projeto[cite: 1].

| Coluna | Tipo SQL | Tipo Power Query | Chave | Permite Nulo? | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Essn** | `CHAR(9)` | Texto | **PK / FK** | Não | SSN do colaborador (referencia `employee.Ssn`)[cite: 1]. |
| **Pno** | `INT` | Número Inteiro | **PK / FK** | Não | Código do projeto (referencia `project.Pnumber`). |
| **Hours** | `DECIMAL(3,1)`| Número Decimal | - | Não | Horas semanais/alocadas trabalhadas no projeto[cite: 1]. |

---

### 6. Tabela: `dependent`
Cadastra os dependentes familiares associados a cada colaborador[cite: 1].

| Coluna | Tipo SQL | Tipo Power Query | Chave | Permite Nulo? | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Essn** | `CHAR(9)` | Texto | **PK / FK** | Não | SSN do colaborador responsável (referencia `employee.Ssn`)[cite: 1]. |
| **Dependent_name**| `VARCHAR(15)` | Texto | **PK** | Não | Nome do dependente. |
| **Sex** | `CHAR(1)` | Texto | - | Sim | Gênero (`M`/`F`). |
| **Bdate** | `DATE` | Data | - | Sim | Data de nascimento do dependente. |
| **Relationship** | `VARCHAR(8)` | Texto | - | Sim | Grau de parentesco (`Son`, `Daughter`, `Spouse`, etc.). |

---

### Legenda de Chaves
* **PK:** *Primary Key* (Chave Primária).
* **FK:** *Foreign Key* (Chave Estrangeira).
* **UK:** *Unique Key* (Chave Única / Sem duplicadas).