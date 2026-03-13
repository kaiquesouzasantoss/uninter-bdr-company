<h1 align="center">BANCO DE DADOS RELACIONAL</h1>

<p align="center">
  <img src="https://raw.githubusercontent.com/kaiquesouzasantoss/uninter-poo-piggybank/refs/heads/main/uninter-logo.png" width="500" alt="UNINTER" />
</p>

#
## Sobre 

Repositório do trabalho semestral da disciplina <strong>Banco de Dados Relacional (BDR)</strong> — UNINTER, 2026. Projeto com foco em <strong>Modelagem (MER)</strong> e <strong>Implementação SQL</strong> em <strong>MySQL</strong>, dividido em:

- Modelagem conceitual (**MER**) com base em regras de negócio
- Implementação de um banco de dados (**MySQL**) a partir de um modelo relacional (lógico)
- Consultas SQL solicitadas e validações com dados fictícios
- Relatório final com códigos e evidências (prints)

---

## Requisitos de avaliação

Os critérios de avaliação incluem:

- Raciocínio aplicado na solução
- Clareza e objetividade nas implementações
- Originalidade
- Coerência com a notação/sintaxe vista em aula
- Uso correto de **SQL**
- Implementação manual (sem geração automática de código)
- Testes executados antes do envio (validar funcionamento)

---

## Etapas do trabalho

### Etapa de modelagem (MER)

Construção do **Modelo Entidade-Relacionamento (MER)** para um sistema corporativo de uma indústria, contemplando:

- Entidades e atributos
- Relacionamentos e cardinalidades
- Chaves primárias e estrangeiras
- Entidades associativas conforme o padrão definido no material da disciplina

**Caso de Uso:**

Uma indústria deseja implementar um Sistema de Informação Corporativo para gerenciar seus projetos, funcionários, departamentos, peças, depósitos das peças e fornecedores. Cada funcionário está vinculado a um único departamento e pode participar de vários projetos, registrando-se a data de início e as horas trabalhadas. Os projetos utilizam diferentes peças, de diferentes fornecedores, sendo necessário controlar quais materiais são utilizados, em que quantidade e qual fornecedor os forneceu. Para isso, a indústria contratou um profissional de Banco de Dados, a fim de modelar o Banco de Dados que armazenará todos os dados.

**Regras de Negócio:**

-	Projeto – Deverão ser armazenados os seguintes dados: identificação do projeto, nome, descrição, data de início, data de fim prevista, status (em andamento, concluído ou cancelado) e orçamento;
-	Funcionário – Deverão ser armazenados os seguintes dados: CPF, nome, telefone, e-mail, endereço – composto por rua, número, complemento, bairro, CEP, cidade e estado –, data de admissão, cargo e salário;
-	Departamento – Deverão ser armazenados os seguintes dados: identificação do departamento, nome, telefone, e-mail, gerente e orçamento;
-	Peça – Deverão ser armazenados os seguintes dados: identificação da peça, tipo de peça, descrição, data de cadastro, custo unitário e status (ativa ou inativa);
-	Depósito – Deverão ser armazenados os seguintes dados: identificação do deposito, nome, telefone, e-mail, endereço – composto por rua, número, complemento, bairro, CEP, cidade e estado –, capacidade máxima e responsável;
-	Fornecedor – Deverão ser armazenados os seguintes dados: CNPJ, razão social, telefone, e-mail, endereço – composto por rua, número, complemento, bairro, CEP, cidade e estado – e nome do contato;
-	Da relação entre funcionário e projeto deverão ser armazenados os seguintes dados: data de início no projeto, horas trabalhadas e função no projeto;
-	Da relação entre projeto e peça deverão ser armazenados os seguintes dados: quantidade e data de utilização;
-	Da relação entre fornecedor e peça deverá ser armazenado o seguinte dado: prazo de entrega;
-	Um ou vários funcionários pertencem a um departamento;
-	Um ou vários funcionários trabalham em um ou vários projetos;
-	Um ou vários projetos utilizam uma ou várias peças;
-	Um ou vários fornecedores fornecem uma ou várias peças;
-	Um depósito contém uma ou várias peças.

**Entregável desta etapa:**

```mermaid
flowchart LR
    %% Configuração de estilos
    classDef entity fill:#f0f0f0,stroke:#333,stroke-width:1px;
    classDef relation fill:#fff,stroke:#333,stroke-width:1px,shape:diamond;
    classDef attr fill:none,stroke:none,text-align:left;

    %% Entidades
    DEP[Departamento]:::entity
    FUNC[Funcionario]:::entity
    PROJ[Projeto]:::entity
    PECA[Peca]:::entity
    FORN[Fornecedor]:::entity
    DEPO[Deposito]:::entity

    %% Relacionamentos (Losangos)
    Rel_Pertence{pertence_a}:::relation
    Rel_Trabalha{trabalha_em}:::relation
    Rel_Utiliza{utiliza}:::relation
    Rel_Fornece{fornece}:::relation
    Rel_Armazena{armazena}:::relation

    %% Conexões com Cardinalidades
    DEP ---|"(1,1)"| Rel_Pertence ---|"(1,n)"| FUNC
    FUNC ---|"(1,n)"| Rel_Trabalha ---|"(1,n)"| PROJ
    PROJ ---|"(1,n)"| Rel_Utiliza ---|"(1,n)"| PECA
    FORN ---|"(1,n)"| Rel_Fornece ---|"(1,n)"| PECA
    DEPO ---|"(1,1)"| Rel_Armazena ---|"(1,n)"| PECA

    %% Atributos: Departamento
    Attr_DEP["⚫ idDepartamento (PK)<br>⚪ nome<br>⚪ telefone<br>⚪ email<br>⚪ gerente<br>⚪ orcamento"]:::attr
    DEP --- Attr_DEP

    %% Atributos: Funcionario
    Attr_FUNC["⚫ CPF (PK)<br>⚪ nome<br>⚪ telefone<br>⚪ email<br>⚪ endereco (rua, num, compl, bairro, CEP, cid, est)<br>⚪ dataAdmissao<br>⚪ cargo<br>⚪ salario<br>⚪ idDepartamento (FK)"]:::attr
    FUNC --- Attr_FUNC

    %% Atributos: Projeto
    Attr_PROJ["⚫ idProjeto (PK)<br>⚪ nome<br>⚪ descricao<br>⚪ dataInicio<br>⚪ dataFimPrevista<br>⚪ status<br>⚪ orcamento"]:::attr
    PROJ --- Attr_PROJ

    %% Atributos: Peca
    Attr_PECA["⚫ idPeca (PK)<br>⚪ tipo<br>⚪ descricao<br>⚪ dataCadastro<br>⚪ custoUnitario<br>⚪ status<br>⚪ idDeposito (FK)"]:::attr
    PECA --- Attr_PECA

    %% Atributos: Deposito
    Attr_DEPO["⚫ idDeposito (PK)<br>⚪ nome<br>⚪ telefone<br>⚪ email<br>⚪ endereco (rua, num, compl, bairro, CEP, cid, est)<br>⚪ capacidadeMaxima<br>⚪ responsavel"]:::attr
    DEPO --- Attr_DEPO

    %% Atributos: Fornecedor
    Attr_FORN["⚫ CNPJ (PK)<br>⚪ razaoSocial<br>⚪ telefone<br>⚪ email<br>⚪ endereco (rua, num, compl, bairro, CEP, cid, est)<br>⚪ nomeContato"]:::attr
    FORN --- Attr_FORN

    %% Atributos dos Relacionamentos M:N (Entidades Associativas)
    Attr_Trabalha["⚪ dataInicioProjeto<br>⚪ horasTrabalhadas<br>⚪ funcaoProjeto"]:::attr
    Rel_Trabalha --- Attr_Trabalha

    Attr_Utiliza["⚪ quantidade<br>⚪ dataUtilizacao"]:::attr
    Rel_Utiliza --- Attr_Utiliza

    Attr_Fornece["⚪ prazoEntrega"]:::attr
    Rel_Fornece --- Attr_Fornece
```


---

### Etapa de implementação (MySQL)

Implementação do banco **Empresa** no **MySQL Workbench**, com:

- Criação das tabelas conforme o modelo relacional fornecido
- Restrição **NOT NULL** em todos os campos, exceto `idFinalizacao` em `OrdemServico`
- Execução de consultas SQL obrigatórias
- Testes utilizando o script de popularização fornecido pela disciplina

**Caso de Uso:**

Uma empresa deseja informatizar o controle de suas ordens de serviço, registrando os atendimentos realizados a seus clientes. Cada ordem de serviço é aberta para um cliente específico, sendo executada por um técnico e pode envolver um ou mais serviços. Para cada ordem, são armazenadas informações como data, equipamento e problema identificado. Ao final do atendimento, a ordem de serviço possui um registro de finalização, contendo a data de conclusão, a data de entrega ao cliente e o valor total. O sistema deve permitir o gerenciamento integrado de clientes, técnicos, serviços prestados e ordens de serviço.

**MER:**

<p align="center">
  <img src="https://raw.githubusercontent.com/kaiquesouzasantoss/uninter-bdr-company/refs/heads/main/MER-Company.png" width="500" />
</p>

**Entregáveis desta etapa:**

- [Script de criação do banco e tabelas]()
- [Script de população de dados]()
- [Script consultas]()

---

## Tecnologia

![MySQL](https://img.shields.io/badge/mysql-0D1117?style=for-the-badge&logo=mysql&labelColor=0D1117)&nbsp;

---

## Contribuição

```bash
git clone https://github.com/kaiquesouzasantoss/uninter-bdr-company.git
```
