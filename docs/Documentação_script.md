## Documentaçao técnica --Banco de Dados TecNews 
  ## Projeto de Banco de Dados MySQL

## 1. Apresentação do projeto
O projeto consiste no desenvolvimento de um banco de dados relacional para a empresa TecNews, voltada a prestação de serviços de tecnologia da informação.
O banco foi desenvolvido com o objetivo de organizar e controlar informações relacionadas aos colaboradores, departamentos, equipamentos, fornecedores, softwares, serviços, chamados técnicos e movimentações de equipamentos.   
A solução permite centralizar informações, facilitar consultas, controlar registros e garantir maior integridade e consistência dos dados armazenados.

## 2.Identificaçao do banco
Informação Descrição
Banco de dados
bd_cna_tecnews_apresentacao
SGBD MySQL
Mecanismo de armazenamento InnoDB
Modelo Relacional
Quantidade de tabelas 20
Chaves primariasPK
Chaves estrangeirasFK
Restrições UNIQUE 6
Restrições CHECK 10 

## 3. Objetivos do banco de dados
- Centralizar os dados administrativos e operacionais da TecNews.
- Controlar os equipamentos e seus respectivos patrimônios.
- Registrar fornecedores e informações de aquisição.
- Organizar os dados dos colaboradores e departamentos.
- Acompanhar chamados e serviços de suporte técnico.
- Registrar movimentações e destinações de equipamentos.
- Garantir a integridade dos dados por meio de restrições.
- Facilitar consultas e relatórios para acompanhamento das atividades.

## 4.Validaçao e testes realizados 
Durante a implementação, foram executados testes para verificar se o banco funciona corretamente e protege as informações cadastradas.
Teste  Resultado
Consulta de colaboradores por departamento Aprovado 
Consulta JOIN Aprovado
Contagem de equipamentos 3 registros 
Contagem de fornecedores 2 registros
Contagem de chamados 1 registro
Contagem de serviços 1 registro 
Verificação das restrições CHECK 10 encontradas
Teste de e-mail duplicado (UNIQUE) Aprovado
Teste de departamento inexistente (FK) Aprovado

Documentação técnica — Banco de Dados TecNews
Projeto de Banco de Dados | MySQL
1. Apresentação do projeto
O projeto consiste no desenvolvimento de um banco de dados relacional para a empresa fictícia TecNews, voltada à prestação de serviços de tecnologia da informação.

O banco foi desenvolvido com o objetivo de organizar e controlar informações relacionadas aos colaboradores, departamentos, equipamentos, fornecedores, softwares, serviços, chamados técnicos e movimentações de equipamentos.

A solução permite centralizar informações, facilitar consultas, controlar registros e garantir maior integridade e consistência dos dados armazenados.
2. Identificação do banco
Informação Descrição
Banco de dados bd_cna_tecnews_apresentacao
SGBD MySQL
Mecanismo de armazenamento InnoDB
Modelo Relacional
Quantidade de tabelas 20
Chaves primárias PK
Chaves estrangeiras FK
Restrições UNIQUE 6
Restrições CHECK 10

3. Objetivos do banco de dados
- Centralizar os dados administrativos e operacionais da TecNews.
- Controlar os equipamentos e seus respectivos patrimônios.
- Registrar fornecedores e informações de aquisição.
- Organizar os dados dos colaboradores e departamentos.
- Acompanhar chamados e serviços de suporte técnico.
- Registrar movimentações e destinações de equipamentos.
- Garantir a integridade dos dados por meio de restrições.
- Facilitar consultas e relatórios para acompanhamento das atividades.

4. Validação e testes realizados
Durante a implementação, foram executados testes para verificar se o banco funciona corretamente e protege as informações cadastradas.
Teste Resultado
Consulta de colaboradores por departamento Aprovado
Consulta JOIN Aprovado
Contagem de equipamentos 3 registros
Contagem de fornecedores 2 registros
Contagem de chamados 1 registro
Contagem de serviços 1 registro
Verificação das restrições CHECK 10 encontradas
Teste de e-mail duplicado (UNIQUE) Aprovado
Teste de departamento inexistente (FK) Aprovado

Importante: encontramos as 10 restrições CHECK cadastradas, mas ainda não comprovamos por um teste de inserção que elas rejeitam valores inválidos.
5. Testes de integridade
Foram realizados dois testes importantes:

Teste 1 — UNIQUE

Foi realizada uma tentativa de inserir um colaborador utilizando um e-mail que já estava cadastrado (ana@cna.com.br). O MySQL rejeitou a operação, demonstrando que a restrição impede duplicidades.

Teste 2 — FOREIGN KEY

Foi realizada uma tentativa de cadastrar um colaborador associado ao departamento de ID 999. Como esse departamento não existe, o MySQL rejeitou a inserção.

Esses testes demonstram a aplicação das regras de integridade referencial e de unicidade.
## 6. Considerações finais
O desenvolvimento do banco de dados TecNews permitiu aplicar conceitos fundamentais de banco de dados relacionais, incluindo criação de tabelas, relacionamentos, chaves primárias e estrangeiras, restrições de integridade e consultas SQL.

Os testes realizados demonstraram o funcionamento dos relacionamentos e a capacidade do MySQL de impedir determinadas operações incompatíveis com as regras estabelecidas.

Próxima etapa
Agora precisamos completar a documentação com as consultas SQL utilizadas no projeto e seus respectivos resultados.

Minha sugestão é organizar os comandos em quatro grupos:
1. Consultas de seleção (SELECT).
2. Consultas com relacionamentos (JOIN).
3. Consultas gerenciais.
4. Consultas de auditoria.
Vamos começar pelas consultas SQL e registrar cada uma com sua finalidade e explicação, para que você também consiga explicar ao professor durante a apresentação.
7. Consultas SQL utilizadas no projeto
7.1. Consultas de seleção (SELECT)
As consultas SELECT permitem recuperar informações armazenadas nas tabelas, sem modificar os registros.

Consulta 1 — Listagem dos colaboradores
SELECT *
FROM Colaborador;


Finalidade: apresentar todos os colaboradores cadastrados no sistema.

Importância: permite consultar informações como nome, sobrenome, e-mail corporativo, data de admissão, situação e departamento de cada colaborador.


Consulta 2 — Listagem dos equipamentos
SELECT *
FROM Equipamento;


Finalidade: visualizar os equipamentos registrados no banco de dados.

Importância: facilita o controle patrimonial e a consulta de informações técnicas, como fabricante, modelo, processador, memória RAM e número de série.
7.2. Consultas com relacionamentos (JOIN)
As consultas JOIN permitem reunir informações de diferentes tabelas relacionadas.

Consulta 3 — Colaboradores e seus departamentos
SELECT
c.nome,
c.sobrenome,
d.nome AS departamento
FROM Colaborador c
INNER JOIN Departamento d
ON c.id_departamento = d.id_departamento;


Finalidade: relacionar cada colaborador ao departamento ao qual pertence.

Resultado verificado: três colaboradores distribuídos entre RH e TI.

Importância: facilita a identificação dos colaboradores por setor.
7.3. Consultas gerenciais
Consulta 4 — Total de colaboradores por departamento
SELECT
d.nome AS departamento,
COUNT(c.id_colaborador) AS total_colaboradores
FROM Departamento d
LEFT JOIN Colaborador c
ON d.id_departamento = c.id_departamento
GROUP BY d.id_departamento, d.nome
ORDER BY d.nome;


Resultado verificado:
Departamento Colaboradores
RH 1
TI 2

Importância: permite acompanhar a distribuição dos colaboradores entre os departamentos.

Consulta 5 — Total de equipamentos cadastrados
SELECT COUNT(*) AS total_equipamentos
FROM Equipamento;


Resultado verificado: 3 equipamentos.

Importância: permite acompanhar a quantidade de equipamentos registrados no patrimônio da empresa.
7.4. Consultas de auditoria
As consultas de auditoria permitem verificar a estrutura do banco, suas restrições e a integridade dos relacionamentos.

Consulta 6 — Verificação das restrições CHECK
SELECT
TABLE_NAME,
CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'bd_cna_tecnews_apresentacao'
AND CONSTRAINT_TYPE = 'CHECK';


Resultado verificado: 10 restrições CHECK cadastradas.

Importância: permite identificar as regras de validação definidas nas tabelas.

Consulta 7 — Verificação das chaves e restrições
SELECT
TABLE_NAME,
CONSTRAINT_NAME,
CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'bd_cna_tecnews_apresentacao'
ORDER BY TABLE_NAME;


Finalidade: identificar as restrições existentes nas tabelas.

Importância: facilita a conferência das chaves primárias, estrangeiras e demais regras de integridade.

8. Organização dos testes realizados
Também vamos registrar os testes de integridade:
Teste Objetivo Resultado
UNIQUE Impedir e-mails duplicados Aprovado
FOREIGN KEY Impedir departamento inexistente Aprovado
CHECK Validar valores conforme regras definidas 10 restrições identificadas; teste funcional pendente


Documentação em andamento
Uma observação importante: essas consultas são exemplos documentados com base nas verificações que fizemos. Para a versão definitiva do relatório, devemos conferir o histórico dos comandos executados, principalmente as consultas de auditoria e gerenciais, para não atribuir ao projeto comandos que talvez não tenham sido utilizados.9. Estrutura das tabelas e seus relacionamentos
O banco de dados TecNews possui 20 tabelas organizadas para representar os processos administrativos e operacionais da empresa.

As tabelas permitem armazenar informações de maneira estruturada, evitando a duplicidade desnecessária de dados e facilitando a comunicação entre diferentes áreas.
9.1. Principais tabelas identificadas
Tabela Finalidade
Departamento Cadastro dos departamentos da empresa.
Colaborador Registro dos funcionários e seus dados corporativos.
Equipamento Controle dos equipamentos e informações patrimoniais.
Fornecedor Cadastro dos fornecedores.
Software Registro dos softwares utilizados.
Chamado Controle das solicitações de suporte técnico.
Serviço Registro dos serviços prestados.
Movimentacao_destinacao Controle da movimentação e destinação dos equipamentos.

Estas são as tabelas cujos nomes e finalidades conseguimos identificar com segurança até agora. As demais serão documentadas após conferirmos seus nomes.
9.2. Relacionamentos entre as tabelas
Um exemplo já validado é o relacionamento entre Departamento e Colaborador.
- Um departamento pode possuir vários colaboradores.
- Cada colaborador pode estar associado a um departamento.
- A ligação é realizada pelo campo id_departamento.
- A chave estrangeira garante que o departamento informado exista.
Outro exemplo é o relacionamento entre Colaborador e Chamado, utilizado para associar solicitações aos colaboradores envolvidos.
9.3. Importância dos relacionamentos
A utilização de chaves primárias e estrangeiras permite:
- Identificar cada registro individualmente.
- Estabelecer conexões entre tabelas.
- Evitar referências a registros inexistentes.
- Facilitar consultas com JOIN.
- Preservar a integridade referencial.10. Resultados alcançados
O desenvolvimento do banco de dados TecNews possibilitou estruturar e organizar informações relacionadas às atividades administrativas e operacionais da empresa.

Durante a implementação, foram alcançados os seguintes resultados:
1. Criação de uma estrutura relacional composta por 20 tabelas.
2. Implementação de chaves primárias e estrangeiras para estabelecer os relacionamentos.
3. Cadastro de informações de colaboradores, departamentos, equipamentos, fornecedores e demais áreas.
4. Aplicação de 6 restrições UNIQUE para evitar valores duplicados em campos definidos.
5. Implementação de 10 restrições CHECK para estabelecer regras de validação.
6. Desenvolvimento de consultas SQL para recuperar e relacionar informações.
7. Realização de testes de integridade para verificar o comportamento do banco.
8. Utilização de consultas gerenciais para facilitar a visualização das informações.
Os testes realizados demonstraram o funcionamento dos relacionamentos entre as tabelas, incluindo a validação de e-mails corporativos únicos e a rejeição de referências a departamentos inexistentes.

11. Considerações finais
O projeto permitiu colocar em prática os conhecimentos adquiridos durante os estudos de banco de dados, especialmente na modelagem relacional, criação de tabelas, definição de relacionamentos, aplicação de restrições e elaboração de consultas SQL.

A construção do banco de dados TecNews demonstrou a importância de organizar as informações de uma empresa de maneira estruturada, garantindo maior controle sobre os registros e facilitando o acesso aos dados.

Além da implementação técnica, o desenvolvimento também proporcionou experiência na identificação de necessidades de uma empresa, na organização dos requisitos e na transformação dessas necessidades em uma solução informatizada.
