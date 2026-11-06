# CNA--Modelo Lógico

## **Integrantes:**

|Nome completo do aluno|RGM|Usuário do Github|
|----------------------|---|------------------|
| Caroline Barroso de Oliveria| 4806351-7|
| Danielly Mariano da Costa| 4781783-6|
| Maria Eduarda Kostkievicz Ferreira| 4790715-1|

## 1- **Relatório técnico** 
## **1.1- Revisao do Modelo Conceitual**
## **Caracterização da Organização:**  

- **Nome e natureza da organização:**
A organização selecionada para o desenvolvimento do projeto é a CNA, que utiliza recursos tecnológicos para apoiar suas atividades. A organização conta com o suporte da empresa TecNews, responsável pela prestação de serviços relacionados à tecnologia da informação.

- **Contexto e porte:**
O levantamento realizado identificou que o controle dos equipamentos tecnológicos da CNA é feito por meio de uma planilha oficial de inventário, que reúne informações dos colaboradores e dos equipamentos utilizados, incluindo notebooks e celulares.
A planilha analisada possui aproximadamente 997 linhas e 26 colunas, considerando a estrutura total da planilha, incluindo cabeçalhos e campos. Os registros abrangem informações cadastrais dos colaboradores, características técnicas dos equipamentos, números de patrimônio, números de série, situação dos dispositivos e dados relacionados à conferência do inventário.
As atualizações são realizadas manualmente, e o volume de consultas e alterações é relativamente baixo. Essas características indicam a necessidade de uma solução capaz de organizar os registros, facilitar as consultas e padronizar o armazenamento das informações.
A CNA também conta com o suporte tecnológico da empresa TecNews, que oferece serviços de TI. Entretanto, as solicitações de atendimento e os registros de manutenção são controlados por outro sistema, ao qual o grupo não possui acesso. Por esse motivo, essas informações não fazem parte do escopo do banco de dados desenvolvido neste projeto.
- **Problemas e necessidades identificados:**
Com base no levantamento realizado, foram identificadas as seguintes necessidades:

- *P1 – Organização dos registros:* necessidade de centralizar as informações dos colaboradores e dos equipamentos em uma estrutura padronizada.
- *P2 – Localização das informações:* necessidade de facilitar a consulta dos dados cadastrais e técnicos dos equipamentos.
- *P3 – Padronização dos dados:* necessidade de reduzir inconsistências decorrentes do preenchimento e da atualização manual da planilha.
- *P4 – Acompanhamento do inventário:* necessidade de organizar as informações referentes à situação dos equipamentos e à conferência dos registros.
- **Escopo do sistema:**

- **Justificativa da escolha:**
A CNA foi escolhida por ser uma organização à qual o grupo teve acesso para realizar o levantamento de informações. A pesquisa de campo foi realizada por meio de entrevista com um representante da empresa TecNews, possibilitando compreender o contexto tecnológico e o processo de controle do inventário.

- **Evidência da organização:**

- **Responsável pela organização:**

## **Relato da entrevista**

- **Quem:**
  
- **Quando e onde:**

- **Comprovação:**

- **O que foi levantado:**
  [Levantamento das informações](levantamento/levantamento.md)

## **Processos de Negócios:** 
O principal processo identificado na CNA consiste no levantamento, registro e atualização das informações referentes aos equipamentos tecnológicos utilizados pelos colaboradores, abrangendo notebooks e celulares.
Atualmente, o controle do inventário é realizado por meio de uma planilha oficial, que reúne informações dos colaboradores, características dos equipamentos, identificação patrimonial, situação de uso e dados referentes à conferência do inventário.
O processo contempla a identificação dos equipamentos vinculados aos colaboradores, o preenchimento e a atualização de seus dados cadastrais e técnicos, além do registro das informações de conferência disponíveis na planilha.

A CNA também conta com o suporte tecnológico da empresa TecNews. Entretanto, as solicitações de atendimento e os registros de manutenção são controlados por outro sistema, ao qual o grupo não possui acesso. Por esse motivo, tais informações não integram o escopo da modelagem proposta.
Dessa forma, o banco de dados desenvolvido pelo grupo tem como objetivo organizar e centralizar as informações do inventário, contribuindo para a padronização dos registros, a consulta dos equipamentos e o acompanhamento de suas situações.

 ## **Requisitos**

 - **Requisitos Funcionais:**
 
 **RF01- Cadastro de equipamentos:** O sistema deve permitir o cadastro de notebooks e celulares, registrando, conforme o tipo, modelo, fabricante, endereço IP quando aplicável, número de serie, patrimônio e data de aquisição.
 
 **RF02 - Registro de garantia:** O sistema deve permitir registrar as informações de garantia de cada equipamento, incluindo período de cobertura, datas de início e término e data de fabricação, quando disponível. 

 **RF03 - Observações de uso:** O sistema deve permitir registrar e consultar observações relacionadas ao uso dos equipamentos e ao colaborador responsável por sua utilização.

 **RF04 - Situação dos equipamentos:** O sistema deve permitir registrar e consultar a situação de cada equipamento, incluindo, no mínimo, disponível em estoque, em uso, em manutenção, com defeito e destinado ao descarte.

  **RF05 - Histórico de alterações:** O sistema deve manter histórico detalhado dos cadastros e das alterações realizadas nos equipamentos, identificando data, horário e responsável por cada operação.

  **RF06 - Consulta e atualização de equipamentos:** O sistema deve permitir pesquisar e visualizar os equipamentos cadastrados, atualizar seus dados conforme as permissões do usuário e consultar a disponibilidade do estoque.

  **RF07 - Registro de solicitações de suporte:** O sistema deve registrar solicitações de suporte relacionadas aos equipamentos, identificando o nível de atendimento (N1, N2 ou Help Desk), a descrição da solicitação, o status e os responsáveis pelo atendimento.

  **RF08 - Devolução de equipamentos:** O sistema deve permitir registrar a devolução de equipamentos vinculados aos colaboradores, mantendo a data de devolução, a condição do ativo e a atualização de sua situação no inventário. 

  **RF09 - Manutenção e fornecedores:** O sistema deve permitir registrar manutenções e serviços realizados em cada equipamento, associando o serviço ao fornecedor responsável e as informações de garantia ou contrato aplicáveis.    

  **RF10 - Descarte de equipamentos:** O sistema deve permitir registrar a destinação de equipamentos descartados, incluindo a confirmação de sanitização dos dados e as informações necessárias para rastrear o descarte. 

  **RF11 - Controle de licenças de software:** O sistema deve permitir registrar os softwares instalados em cada equipamento e os dados de suas respectivas licenças, incluindo identificação, validade e situação.   
  
 - **Requisitos Não Funcionais:**

   **RNF01 - Controle de acesso:** O sistema deve restringir o acesso aos dados e as operações de inclusão, consulta, alteração e exclusão logica aos operadores e administradores autorizados pela empresa, conforme seus perfis de permissão.

     **RNF02 - Integridade do histórico:** O sistema deve garantir que os registros de histórico e validação sejam permanentes e não possam ser alterados ou excluídos por usuários comuns ou administradores da aplicação.

   **RN03 - Desempenho:** O sistema deve responder as consultas de inventario em ate 2 segundos, considerando condições normais de operação e carga de uso prevista.      

 - **Levantamento dos requisitos típicos do tipo de organização.**
 
 - **Justificação dos requisitos prováveis não incluídos:**

## **Regras de negócio:**

- **Levante as regras típicas do tipo de organização.**

  **RN01 - Alocação exclusiva:** Um equipamento pode estar vinculado, no máximo, a um colaborador por vez. A alocação deve ser registrada e, antes de uma nova alocação, a alocação anterior deve ser encerrada.

  **RN02 - Histórico de validação:** Toda inclusão ou alteração de dados de um equipamento, incluindo mudança de situação, alocação, manutenção e atualização cadastral, deve gerar um registro permanente e imutável no histórico, contendo data, hora e identificação do responsável.

  **RN03 - Devolução no desligamento:** Quando ocorrer o desligamento de um colaborador, todos os equipamentos sob sua responsabilidade devem ser devolvidos e sua alocação encerrada no inventário.

  **RN04 - Garantia e manutenção:** Toda manutenção deve ser registrada e associada ao equipamento atendido e ao fornecedor responsável. Quando houver garantia ou contrato ativo aplicável, o atendimento deve ser vinculado a esse registro e respeitar suas condições.

  **RN05 - Descarte e proteção de dados:** Todo equipamento destinado ao descarte deve passar por sanitização dos dados antes de sua destinação final. O descarte deve seguir a politica interna de resíduos eletrônicos e os requisitos aplicáveis de proteção de dados e LGPD.

  **RN06 - Controle de licenciamento:** Todo software instalado em um equipamento deve possuir uma licença válida e registrada no inventário, compatível com o uso realizado e com a quantidade de instalações autorizadas.     

- **Justifique as regras prováveis não incluídas:**

## **Notação do DER conceitual**

**Software Utilizado:** BrModelo

|Apontamento da correção da E1|O que mudou no trabalho|Por quê|
|----------------------|---|------------------|
|                      |   |                  |
|                      |    |                |
|                      |   |                 |

## **1.2 Conversão do Modelo Conceitual para o Modelo Lógico**

- **Entidades → Tabelas:**

- **Atributos → Colunas:**

- **Relacionamentos → Chaves:**

- **Cardinalidades:**

- **Generalização/especialização:**


## **1.3 Definição de Chaves Primárias e Estrangeiras**

## **1.4 Processo de Normalização (1FN, 2FN e 3FN)**

- **1FN:**

- **2FN:**

- **3FN:**

- **Justificativa do processo:**

## **1.5 Justificativas Técnicas das Decisões**

- **Justificar as chaves primárias escolhidas.**

-  **Justificar as chaves estrangeiras e os relacionamentos que elas implementam.**

-  **Justificar as restrições aplicadas (unicidade, obrigatoriedade, valores permitidos etc.), citando o código da regra de negócio (RNxx) que cada restrição implementa, quando houver.**

-  **Justificar decisões arquiteturais gerais do modelo.**

## **1.6 Proposta de Arquitetura Analítica para BI e IA**

- **Informações estratégicas**

- **Indicadores e métricas gerenciais propostos (KPIs).**

- **Potencial dos dados para BI: como a estrutura apoia dashboards/relatórios.**

- **Aplicações analíticas e de IA: como o modelo pode alimentar análises preditivas, recomendações etc.**

|Problema ou KPI|Tabelas envolvidas|Consulta no script|
|----------------------|---|------------------|


## **2-Modelo Lógico Relacional**

## **3-Script SQL Completo**

## **4-Massa de Dados**

## **5-Uso de Inteligência Artificial**
|Item|O que registrar|
|----------------------|------------------|
|Ferramenta e etapa|
|Motivação|
|Prompt(s) utilizados|
|Resposta recebida|
|Fontes consultadas e verificadas|
|Trechos rejeitados ou corrigidos|
|Justificativa da escolha final|
|Reflexão crítica|
