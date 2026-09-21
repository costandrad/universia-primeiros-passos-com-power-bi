# Desafio de Projeto

## Dashboard de Vendas/Modelagem Acadêmica com Power BI utilizando Star Schema


O banco de dados relacional `universidade` foi criado a partir do [script SQL de criação](/05%20-%20Modelagem%20de%20Dados%20com%20Power%20BI/Desafio%20de%20Projeto%20-%20Modelagem%20Star%20Schema%20com%20Power%20BI/01-database/01-create_db_universidade.sql), seguindo as [instruções do desafio](/05%20-%20Modelagem%20de%20Dados%20com%20Power%20BI/Desafio%20de%20Projeto%20-%20Modelagem%20Star%20Schema%20com%20Power%20BI/00-docs/Descrição%20do%20Desafio.docx). Sua estrutura é composta pelas seguintes tabelas originais: `aluno`, `curso`, `departamento`, `disciplina`, `disciplina & curso`, `matriculado`, `professor`, `pré-requisitos` e `pré-requisitos das disciplinas`. O Diagrama Entidade-Relacionamento (DER) resultante é apresentado abaixo:

![Diagrama Entidade-Relacionamento do DB Universidade](/05%20-%20Modelagem%20de%20Dados%20com%20Power%20BI/Desafio%20de%20Projeto%20-%20Modelagem%20Star%20Schema%20com%20Power%20BI/02-assets/images/eer-diagram-universidade.png)

Originalmente, a proposta do desafio sugeria utilizar a tabela **Professor** como base para a Tabela Fato. No entanto, essa escolha diverge das boas práticas de modelagem multidimensional da Microsoft. Segundo essas [diretrizes](https://learn.microsoft.com/pt-br/power-bi/guidance/star-schema), as **tabelas de dimensão** descrevem entidades de negócio (como pessoas, produtos e locais), sendo formadas por chaves identificadoras e atributos voltados para filtragem e agrupamento. Já as **tabelas de fato** registram eventos ou observações, armazenando chaves estrangeiras e métricas numéricas que definem a granularidade dos dados.

Sob essa perspectiva, a tabela **Professor** atua como uma entidade de negócio típica — a pessoa do docente —, devendo ser modelada como dimensão. Por outro lado, a tabela **Fato_Turma** representa o evento de oferta e alocação de turmas, estabelecendo a granularidade adequada ao associar professor, disciplina e curso. Dessa forma, suas chaves conectam-se às dimensões correspondentes, permitindo a criação de agregados e medidas analíticas no centro do esquema estrela (*Star Schema*).

---

## 1. Estrutura do Esquema Estrela (Star Schema)

Para reestruturar o modelo relacional em um modelo dimensional no formato *Star Schema*, a tabela fato central **Fato_Turma** é alimentada pelas tabelas de dimensão circundantes:

### Tabela Fato: `Fato_Turma`
* **Descrição**: Armazena as ocorrências de turmas/ofertas acadêmicas, conectando os envolvidos (docente, disciplina e curso).
* **Chaves de Dimensão / Relacionamentos**:
  * `idProfessor` (FK relacionando com `Dim_Professor`)
  * `idDisciplina` (FK relacionando com `Dim_Disciplina`)
  * `idCurso` (FK relacionando com `Dim_Curso`)
* **Métricas e Atributos de Fato**: Carga horária, identificação da turma, período/semestre e relacionamentos operacionais.

### Tabelas de Dimensão:

1. **`Dim_Professor`**:
   * **Objetivo**: Conter as informações e atributos cadastrais dos docentes.
   * **Atributos principais**: `idProfessor`, `Nome`, `CPF`, `Email`, entre outros.

2. **`Dim_Disciplina`**:
   * **Objetivo**: Armazenar os detalhes sobre as disciplinas ministradas.
   * **Atributos principais**: `idDisciplina`, `Nome_Disciplina`, `Carga_Horaria`, etc.

3. **`Dim_Curso`**:
   * **Objetivo**: Catalogar os cursos ofertados na instituição aos quais as disciplinas e turmas estão vinculadas.
   * **Atributos principais**: `idCurso`, `Nome_Curso`, `Modalidade`, etc.

---

## 2. Integração da View `vw_alunos_por_disciplina`

Para obter o quantitativo de alunos matriculados por disciplina sem comprometer a performance do modelo nem gerar ambiguidades na tabela fato principal, foi criada uma **View no banco de dados SQL**:

```sql
create view vw_alunos_por_disciplina as
	select d.idDisciplina, COUNT(distinct m.Aluno_idAluno) as qdt_alunos 
    from `disciplina` d
	inner join `matriculado` m
		on d.idDisciplina = m.Disciplina_idDisciplina
	group by d.idDisciplina;
```
### Papel no Power BI:

* Conexão: A view `vw_alunos_por_disciplina` foi importada diretamente no Power BI e vinculada à tabela `Dim_Disciplina` através da chave de relacionamento idDisciplina.

* Vantagem: Fornece uma métrica pré-agregada do volume de alunos matriculados por disciplina, permitindo análises combinadas com a Fato_Turma (como taxa de ocupação por turma e carga horária alocada por docente) mantendo uma estrutura limpa e otimizada para DAX.

### 3. Resultado

Com base na reestruturação realizada, o modelo *Star Schema* final no Power BI consolida a arquitetura dimensional com a tabela central **Fato_Turma** interligada às dimensões **Dim_Professor**, **Dim_Disciplina** e **Dim_Curso**, conforme mostrado abaixo:

![Modelo Star Schema](/05%20-%20Modelagem%20de%20Dados%20com%20Power%20BI/Desafio%20de%20Projeto%20-%20Modelagem%20Star%20Schema%20com%20Power%20BI/02-assets/images/star-schema-universidade.png)

Essa disposição estabelece um relacionamento claro de um-para-muitos ($1 : N$) a partir de cada dimensão para a tabela fato, garantindo a propagação eficiente de filtros e evitando ambiguidades no modelo. Adicionalmente, a inclusão da tabela agregada **vw_alunos_por_disciplina** conectada diretamente à **Dim_Disciplina** complementa a capacidade analítica da solução, permitindo cruzar o volume de matrículas com os dados de alocação de docentes e cursos sem sobrecarregar a granularidade da fato. O resultado é um modelo relacional otimizado para alta performance em consultas DAX, navegação intuitiva de filtros e construção de relatórios analíticos no Power BI.