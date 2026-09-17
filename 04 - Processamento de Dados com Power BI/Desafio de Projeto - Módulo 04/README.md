# Desafio de Projeto - Módulo 04

## Processando e Transformando Dados com Power BI

Este repositório contém a resolução do desafio de transformação de dados de um banco relacional MySQL utilizando o Power Query (Power BI).

---


### Diretrizes para transformação dos dados

1.	Verifique os cabeçalhos e tipos de dados
    * **Ação**: Verificar se a primeira linha de todas as tabelas foi promovida a cabeçalho
2.	Modifique os valores monetários para o tipo double preciso
    * **Ação**: Na tabela `employee`, a coluna `Salary` teve seu tipo alterado para **Número Decimal Fixo** (Monetário).
3.	Verifique a existência dos nulos e analise a remoção
    * Foi observado apenas um único valor nulo na tabela `empoyee`,  coluna `Super_ssn`, referente ao registro do colaboradoe _James E. Borg_. A análise do caso é feita no próximo item.
4.	Os employees com nulos em Super_ssn podem ser os gerentes. Verifique se há algum colaborador sem gerente
    * O colaborador James Borg possui `Super_ssn` nulo pois ele é o CEO/Gerente Geral (não possui supervisor acima dele). Mantém-se o registro.
5.	Verifique se há algum departamento sem gerente
    * Todos os departamentos possuem gerentes
6.	Se houver departamento sem gerente, suponha que você possui os dados e preencha as lacunas
7.	Verifique o número de horas dos projetos
8.	Separar colunas complexas
    * **Ação**: Tratamento da Coluna de Endereço (`Adress`):

        Para extrair e organizar os componentes do endereço individualmente, utilizei a funcionalidade Dividir Coluna por Delimitador (-), aplicando a extração de forma sequencial em 3 etapas:

        1ª Iteração (`House Number`): Dividi a coluna utilizando o delimitador mais à esquerda. Isso isolou o número do imóvel (ex: 3321 ou 731) na primeira coluna, a qual renomeei para `House Number`.

        2ª Iteração (`State`): Na coluna restante, apliquei a divisão pelo delimitador mais à direita. Isso extraiu a sigla do estado (ex: TX) na última coluna, que renomeei para `State`.

        3ª Iteração (`City`): Novamente na coluna central/restante, utilizei a divisão pelo delimitador mais à direita. Com isso, isolei o nome da cidade (ex: Spring ou Houston) na coluna da direita, renomeando-a para `City`.

        Resultado Final: Após as três extrações sequenciais, o texto remanescente na coluna principal passou a conter exclusivamente o nome da rua, permitindo renomeá-la para `Street Name`. O endereço original ficou perfeitamente estruturado nos campos: `House Number`, `Street Name`, `City` e `State`.

9.	Mesclar consultas employee e departament para criar uma tabela employee com o nome dos departamentos associados aos colaboradores. A mescla terá como base a tabela employee. Fique atento, essa informação influencia no tipo de junção
    * **Ação**: COm a tabela `employee` seleconada, foi utilizada a função *Mesclar Consuntas* para mesclagem com a tabela `department`. O tipo de junção aplicado foi _Externa esquerda_ (`employee.Dno` = `department.Dnumber`).
10.	Neste processo elimine as colunas desnecessárias. 
11.	Realize a junção dos colaboradores e respectivos nomes dos gerente . Isso pode ser feito com consulta SQL ou pela mescla de tabelas com Power BI. Caso utilize SQL, especifique no README a query utilizada no processo.
12.	Mescle as colunas de Nome e Sobrenome para ter apenas uma coluna definindo os nomes dos colaboradores
13.	Mescle os nomes de departamentos e localização. Isso fará que cada combinação departamento-local seja único. Isso irá auxiliar na criação do modelo estrela em um módulo futuro.
14.	Explique por que, neste caso supracitado, podemos apenas utilizar o mesclar e não o atribuir. 
  
15.	Agrupe os dados a fim de saber quantos colaboradores existem por gerente
16.	Elimine as colunas desnecessárias, que não serão usadas no relatório, de cada tabela
