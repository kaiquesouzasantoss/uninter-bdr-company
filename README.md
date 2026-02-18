<h1 align="center">BANCO DE DADOS RELACIONAL</h1>

<p align="center">
  <img src="uninter-logo.png" width="500" alt="UNINTER" />
</p>

---

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

Entregáveis desta etapa:

MER>>>>


---

### Etapa de implementação (MySQL)

Implementação do banco **Empresa** no **MySQL Workbench**, com:

- Criação das tabelas conforme o modelo relacional fornecido
- Restrição **NOT NULL** em todos os campos, exceto `idFinalizacao` em `OrdemServico`
- Execução de consultas SQL obrigatórias
- Testes utilizando o script de popularização fornecido pela disciplina

Entregáveis desta etapa:

- [Script de criação do banco e tabelas (DDL)]()
- [Scripts/consultas (SELECTs solicitados)]()
- [Prints dos resultados das consultas no relatório]()

---
## Regras de Negócio

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

---

## Como executar (MySQL Workbench)

Fluxo recomendado:

- Executar o script de criação do banco e tabelas (`sql/company-ddl.sql`)
- Popular as tabelas executando o arquivo (`sql/company-populate.sql`)
- Executar as consultas (`sql/company-query.sql`)

---

## Tecnologia

![MySQL](https://img.shields.io/badge/mysql-0D1117?style=for-the-badge&logo=mysql&labelColor=0D1117)&nbsp;

---

## Contribuição

```bash
git clone https://github.com/kaiquesouzasantoss/uninter-bdr-company.git
```
