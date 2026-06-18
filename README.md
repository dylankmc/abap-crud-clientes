# SAP ABAP CRUD – Gestão de Clientes com ALV e Dynpro

Projeto de portfólio desenvolvido em **ABAP clássico** para demonstrar a criação de uma aplicação de cadastro e manutenção de clientes utilizando **ALV Grid**, **Module Pool**, **Dynpro**, transações customizadas e persistência em tabela transparente SAP.

A solução permite consultar clientes por diferentes critérios e executar operações de **criação, edição e exclusão** diretamente a partir do relatório ALV.

---

## Visão Geral do Projeto

Este projeto simula uma aplicação corporativa SAP para gerenciamento de clientes.

O fluxo começa em um relatório ABAP com tela de seleção. Após a consulta, os registros são apresentados em um ALV, no qual o usuário pode selecionar um cliente e acionar as operações disponíveis no menu da aplicação.

As operações de manutenção são executadas por transações customizadas que utilizam telas Dynpro e um programa do tipo Module Pool.

O projeto demonstra o fluxo completo de uma aplicação ABAP clássica:

- Criação de relatório executável;
- Utilização de tela de seleção;
- Consulta de dados em tabela transparente;
- Exibição de registros em ALV Grid;
- Criação de catálogo de campos;
- Configuração de PF-STATUS;
- Tratamento de comandos do usuário;
- Navegação entre relatório e transações;
- Desenvolvimento de telas Dynpro;
- Processamento PBO e PAI;
- Operações de inclusão, consulta, alteração e exclusão;
- Exibição de mensagens de sucesso e erro.

---

## Objetivo Profissional

Este repositório foi criado como projeto de portfólio para demonstrar conhecimentos práticos em desenvolvimento SAP ABAP, principalmente nas áreas de:

- Programação ABAP;
- Open SQL;
- Relatórios executáveis;
- ALV Grid;
- Module Pool;
- Dynpro;
- PBO e PAI;
- PF-STATUS e GUI Status;
- Transações customizadas;
- Modularização com includes e sub-rotinas;
- Manipulação de tabelas transparentes;
- Organização e documentação de código no GitHub.

---

## Funcionalidades

- Listagem de clientes em ALV;
- Limitação da quantidade de registros retornados;
- Filtro por código do cliente;
- Filtro por data de criação;
- Filtro por hora de criação;
- Filtro por nome;
- Filtro por e-mail;
- Filtro por limite de crédito;
- Filtro por status;
- Cadastro de novos clientes;
- Edição de clientes existentes;
- Exclusão de clientes;
- Atualização automática do ALV após uma operação;
- Navegação para transações a partir do registro selecionado;
- Bloqueio do código do cliente durante a edição;
- Preenchimento automático de data e hora no cadastro;
- Status ativo atribuído por padrão ao carregar o programa;
- Mensagens de confirmação e tratamento de falhas.

---

## Tecnologias e Recursos Utilizados

### Desenvolvimento SAP

- ABAP;
- ABAP Open SQL;
- SAP GUI;
- ABAP Workbench;
- Data Dictionary;
- Relatórios executáveis;
- Module Pool;
- Dynpro;
- PBO — Process Before Output;
- PAI — Process After Input;
- Includes;
- Sub-rotinas com `FORM`;
- Parâmetros de memória SAP;
- Mensagens customizadas.

### Interface e Relatórios

- ALV Grid clássico;
- Função `REUSE_ALV_GRID_DISPLAY`;
- Field Catalog;
- PF-STATUS;
- GUI Status;
- Titlebar;
- Tela de seleção;
- `SELECT-OPTIONS`;
- Comandos de usuário no ALV.

### Persistência

- Tabela transparente `ZCLIENTES`;
- Operações `SELECT`;
- Operação `SELECT SINGLE`;
- Operação `INSERT`;
- Operação `MODIFY`;
- Operação `DELETE`.

### Versionamento

- Git;
- GitHub.

---

## Arquitetura da Solução

```text
Usuário
   |
   v
Relatório ZCRUD_CLIENTE
   |
   |-- Tela de seleção e filtros
   |
   v
Tabela ZCLIENTES
   |
   v
ALV Grid de Clientes
   |
   |-- CRIAR  --> Transação Z001
   |-- EDITAR --> Transação Z002
   |-- EXCLUIR -> Transação Z003
   |
   v
Module Pool SAPMZ_CLIENTE
   |
   |-- Dynpro 1000
   |-- Dynpro 1001
   |-- Processamento PBO/PAI
   |
   v
INSERT / SELECT / MODIFY / DELETE
   |
   v
Tabela ZCLIENTES
```

---

## Estrutura do Repositório

```text
abap-crud-clientes/
│
├── src/
│   ├── zcrud_alv.abap.txt
│   └── zcrud_functions.abap.txt
│
└── README.md
```

### `zcrud_alv.abap.txt`

Contém o código relacionado ao relatório de consulta e ao ALV:

- Programa `ZCRUD_CLIENTE`;
- Includes lógicos `ZCRUD_CLIENTE_TOP`, `ZCRUD_CLIENTE_FRM` e `ZCRUD_CLIENTE_SOS`;
- Declaração da tabela interna de clientes;
- Parâmetro para limite de registros;
- Campos de seleção;
- Consulta à tabela `ZCLIENTES`;
- Construção do catálogo de campos;
- Chamada do ALV;
- Tratamento dos comandos `CRIAR`, `EDIT` e `DELETE`;
- Atualização do relatório após a execução das operações.

### `zcrud_functions.abap.txt`

Contém o código relacionado à manutenção dos clientes:

- Programa Module Pool `SAPMZ_CLIENTE`;
- Includes lógicos de dados, formulários, PBO, PAI e carregamento;
- Cadastro de clientes;
- Consulta individual;
- Alteração de clientes;
- Exclusão de clientes;
- Controle das telas Dynpro;
- Tratamento dos comandos dos botões;
- Definição de títulos conforme a transação;
- Recebimento do cliente selecionado pelo parâmetro de memória `ZCLIENT`.

> Os arquivos possuem a extensão `.abap.txt` para facilitar a visualização, o armazenamento e o versionamento do código-fonte fora do ambiente SAP.

---

## Relatório ALV

O relatório principal consulta os dados da tabela `ZCLIENTES` e apresenta os resultados em um ALV Grid.

### Campos exibidos

| Campo | Descrição |
|---|---|
| `ZCLIENT` | Código do cliente |
| `DATA` | Data de criação |
| `HORA` | Hora de criação |
| `ZNOME` | Nome do cliente |
| `ZEMAIL` | E-mail |
| `ZCREDITO` | Limite de crédito |
| `ZSTATUS` | Status |

### Filtros disponíveis

O usuário pode restringir a pesquisa por:

- Código do cliente;
- Data;
- Hora;
- Nome;
- E-mail;
- Limite de crédito;
- Status;
- Quantidade máxima de registros.

A exibição é realizada por meio da função:

```abap
REUSE_ALV_GRID_DISPLAY
```

O catálogo de campos é montado manualmente, permitindo definir os títulos apresentados no relatório.

---

## Operações de CRUD

### Criação

A opção de criação chama a transação `Z001`.

Durante o cadastro:

- A data é preenchida com `SY-DATUM`;
- A hora é preenchida com `SY-UZEIT`;
- O registro é incluído na tabela `ZCLIENTES`;
- O sistema informa se o cliente foi cadastrado ou se já existe.

```abap
INSERT zclientes FROM gs_cliente.
```

### Consulta

A consulta principal utiliza os filtros da tela de seleção para recuperar os clientes.

```abap
SELECT *
  INTO TABLE gt_client
  FROM zclientes
  UP TO p_row ROWS.
```

Para edição e exclusão, o sistema também executa uma consulta individual pelo código do cliente.

```abap
SELECT SINGLE *
  INTO gs_cliente
  FROM zclientes
  WHERE zclient = gd_zclient.
```

### Atualização

A opção de edição chama a transação `Z002`.

O cliente selecionado é carregado no Dynpro, e o campo de código permanece bloqueado para evitar a alteração da chave.

```abap
MODIFY zclientes FROM gs_cliente.
```

### Exclusão

A opção de exclusão chama a transação `Z003`.

O registro é localizado pelo código do cliente e removido da tabela.

```abap
DELETE FROM zclientes
 WHERE zclient = gd_zclient.
```

---

## Integração entre ALV e Dynpro

Ao selecionar um registro no ALV, o código do cliente é armazenado em um parâmetro de memória SAP:

```abap
SET PARAMETER ID 'ZCLIENT' FIELD ld_field.
```

O Module Pool recupera esse valor durante o carregamento do programa:

```abap
GET PARAMETER ID 'ZCLIENT' FIELD gd_field.
```

Essa abordagem permite transportar o identificador do cliente selecionado entre o relatório e as transações de manutenção.

---

## Transações Utilizadas

| Transação | Finalidade |
|---|---|
| `Z001` | Cadastrar cliente |
| `Z002` | Editar cliente |
| `Z003` | Excluir cliente |

As transações de edição e exclusão podem ser chamadas com a primeira tela ignorada, pois o cliente selecionado já é enviado pelo relatório ALV.

---

## Telas Dynpro

O Module Pool utiliza duas telas principais:

### Tela 1000

Responsável pelo formulário de cadastro e edição.

Principais comportamentos:

- Define o GUI Status `S1000`;
- Altera o título conforme a transação;
- Bloqueia o código do cliente durante a edição;
- Processa os comandos de salvar e voltar.

### Tela 1001

Responsável pela seleção e confirmação das operações de edição e exclusão.

Principais comportamentos:

- Define o GUI Status `S1001`;
- Apresenta títulos específicos para alteração ou exclusão;
- Carrega o cliente informado;
- Executa a operação conforme a transação ativa.

---

## Objetos SAP Necessários

Para reproduzir o projeto em um ambiente SAP, devem ser criados ou adaptados os seguintes objetos:

- Tabela transparente `ZCLIENTES`;
- Elemento de dados utilizado pelo código do cliente;
- Programa executável `ZCRUD_CLIENTE`;
- Includes do relatório;
- Programa Module Pool `SAPMZ_CLIENTE`;
- Includes do Module Pool;
- Telas Dynpro 1000 e 1001;
- PF-STATUS `STANDARD`;
- GUI Status `S1000`;
- GUI Status `S1001`;
- Titlebars `NEW`, `EDIT`, `MOD` e `DEL`;
- Transações `Z001`, `Z002` e `Z003`;
- Parâmetro de memória `ZCLIENT`;
- Classe de mensagens `ZABAP`;
- Mensagens utilizadas pelo programa.

> Os layouts das telas, definições do Data Dictionary, GUI Status, Titlebars, transações e classe de mensagens precisam ser configurados no ambiente SAP, pois não são transportados apenas pelos arquivos-fonte presentes neste repositório.

---

## Como Implementar no Ambiente SAP

### 1. Criar a estrutura de dados

Crie a tabela transparente `ZCLIENTES` no Data Dictionary com os campos utilizados pelo programa:

- Código do cliente;
- Data;
- Hora;
- Nome;
- E-mail;
- Limite de crédito;
- Status.

Defina o código do cliente como chave primária e ajuste os tipos de dados de acordo com o padrão do ambiente.

### 2. Criar o relatório

Crie o programa executável `ZCRUD_CLIENTE` e os includes correspondentes.

Transfira para os objetos SAP o conteúdo disponível em:

```text
src/zcrud_alv.abap.txt
```

### 3. Criar o Module Pool

Crie o programa Module Pool `SAPMZ_CLIENTE`, seus includes e as telas Dynpro.

Transfira o conteúdo disponível em:

```text
src/zcrud_functions.abap.txt
```

### 4. Configurar as telas

Crie as telas 1000 e 1001, incluindo:

- Campos da estrutura `GS_CLIENTE`;
- Campo utilizado para informar o código do cliente;
- Botões e comandos;
- Fluxos de lógica PBO e PAI.

### 5. Criar os elementos de interface

Configure:

- PF-STATUS;
- GUI Status;
- Títulos das telas;
- Códigos de função dos botões;
- Classe e textos de mensagens.

### 6. Criar as transações

Associe as transações customizadas ao Module Pool:

```text
Z001 → Cadastro
Z002 → Edição
Z003 → Exclusão
```

### 7. Ativar e testar

Ative todos os objetos e valide o seguinte fluxo:

1. Execute o relatório;
2. Consulte os clientes;
3. Selecione um registro;
4. Execute uma operação;
5. Retorne ao relatório;
6. Confirme a atualização dos dados no ALV.

---

## Observação sobre Execução

Este projeto depende de um ambiente SAP ABAP para sua execução completa.

São necessários:

- Acesso ao SAP GUI;
- Permissão para criar objetos no namespace `Z`;
- Acesso ao Data Dictionary;
- Acesso ao Screen Painter;
- Permissão para criar transações;
- Autorização para ativar programas e objetos;
- Configuração dos objetos auxiliares utilizados pelo código.

Os arquivos deste repositório representam o código-fonte e a lógica da solução. Eles não substituem os objetos técnicos e visuais que precisam ser criados dentro do sistema SAP.

---

## O que este projeto demonstra

Este projeto demonstra conhecimento prático em:

- Desenvolvimento ABAP clássico;
- Construção de relatórios com tela de seleção;
- Exibição de dados em ALV;
- Criação manual de Field Catalog;
- Tratamento de eventos do ALV;
- Navegação entre programas e transações;
- Desenvolvimento de aplicações Module Pool;
- Programação de telas Dynpro;
- Processamento PBO e PAI;
- Controle dinâmico de campos da tela;
- Uso de parâmetros de memória SAP;
- Operações CRUD com Open SQL;
- Modularização de programas ABAP;
- Tratamento de mensagens;
- Organização de código SAP no GitHub;
- Documentação técnica para portfólio.

---

## Segurança e Privacidade

Este repositório foi preparado para fins de estudo e portfólio.

Não foram incluídos:

- Senhas;
- Usuários SAP reais;
- Endereços de servidores;
- IPs internos;
- Mandantes reais;
- Informações confidenciais de empresas;
- Dados reais de clientes;
- Credenciais de acesso.

Os nomes e registros utilizados durante os testes devem ser fictícios.

---

## Melhorias Futuras

- Adicionar validação obrigatória dos campos;
- Validar o formato do e-mail;
- Validar valores de limite de crédito;
- Adicionar confirmação antes da exclusão;
- Implementar bloqueio de objetos com `ENQUEUE` e `DEQUEUE`;
- Utilizar `COMMIT WORK` e tratamento transacional explícito;
- Migrar o ALV clássico para `CL_SALV_TABLE` ou ALV OO;
- Substituir sub-rotinas por classes e métodos;
- Adicionar tratamento estruturado de exceções;
- Separar os objetos ABAP em arquivos individuais;
- Incluir definições da tabela e dos elementos de dados;
- Documentar os layouts das telas Dynpro;
- Adicionar capturas de tela da aplicação;
- Criar vídeo demonstrativo;
- Implementar testes automatizados com ABAP Unit;
- Adicionar verificações com ATC e Code Inspector.

---

## Autor

Desenvolvido por **Dylan K. Mcnamara**.

Projeto criado para fins de estudo, prática e portfólio profissional na área de desenvolvimento SAP ABAP.

[GitHub — dylankmc](https://github.com/dylankmc)

---

## Palavras-chave

SAP, ABAP, ABAP clássico, CRUD, ALV, ALV Grid, Dynpro, Module Pool, Open SQL, SAP GUI, Data Dictionary, PBO, PAI, PF-STATUS, GUI Status, transações customizadas, tabela transparente, GitHub e portfólio SAP.
