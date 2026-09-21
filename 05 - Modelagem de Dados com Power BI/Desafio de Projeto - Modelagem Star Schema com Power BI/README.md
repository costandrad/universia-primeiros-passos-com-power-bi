# Desafio de Projeto

## Dashboard de Vendas com Power BI utilizando Star Schema

De acordo com as diretrizes de modelagem do Power BI, tabelas de dimensão descrevem as entidades de negócio que são modeladas, como pessoas, produtos e locais, sendo constituídas por uma chave identificadora e por atributos que dão suporte à filtragem e ao agrupamento dos dados. Já as tabelas de fatos armazenam observações ou eventos e são compostas por chaves de dimensão, que determinam sua dimensionalidade, e por valores numéricos de medida, cuja combinação define a granularidade dos registros. Sob essa perspectiva, a tabela Professor não é a escolha mais adequada para atuar como tabela fato, pois representa uma entidade de negócio — a pessoa do professor — e, portanto, possui características próprias de uma tabela de dimensão, destinadas principalmente à descrição, filtragem e agrupamento. A Fato_Ensino, por sua vez, representa uma ocorrência ou relacionamento de ensino, estabelecendo como granularidade a associação entre professor, disciplina e curso. Assim, suas chaves de dimensão permitem relacioná-la às dimensões correspondentes e sua estrutura possibilita a criação de medidas e agregações analíticas, tornando-a mais adequada para ocupar a posição central do esquema estrela.


```
                         Dim_Professor
                              │ 1
                              │
                1     *       │ *   *      1
Dim_Disciplina ──────── Fato_Ensino ──────── Dim_Curso
                              │ *
                              │
                              │ 1
                        Dim_Departamento
```


```
                       ┌──────────────────┐
                       │  Dim_Professor   │
                       ├──────────────────┤
                       │ idProfessor      │
                       │ NomeProfessor    │
                       │ Departamento     │
                       │ Campus           │
                       └────────┬─────────┘
                                │
                                │ 1
                                ▼
                     ┌─────────────────────┐
                     │     Fato_Ensino     │
                     ├─────────────────────┤
                     │ idProfessor         │
                     │ idDisciplina        │
                     │ idCurso             │
                     │ Quantidade          │
                     └───────┬───────┬─────┘
                             │       │
                         *   │       │   *
                             ▼       ▼
                    ┌────────────┐ ┌────────────┐
                    │Dim_Disciplina│ │ Dim_Curso │
                    └────────────┘ └────────────┘
```