-- Criar o banco de dados
CREATE DATABASE Empresa;

-- Usar o banco de dados
USE Empresa;

-- Tabela Tecnico (Entidade forte)
CREATE TABLE Tecnico (
    idTecnico INT NOT NULL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50) NOT NULL,
    dataAdmissao DATE NOT NULL
);

-- Tabela Cliente (Entidade forte)
CREATE TABLE Cliente (
    idCliente INT NOT NULL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    dataCadastro DATE NOT NULL
);

-- Tabela Servico (Entidade forte)
CREATE TABLE Servico (
    idServico INT NOT NULL PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    valorPadrao DECIMAL(7,2) NOT NULL,
    tempoEstimado TIME NOT NULL
);

-- Tabela Finalizacao (Entidade forte)
CREATE TABLE Finalizacao (
    idFinalizacao INT NOT NULL PRIMARY KEY,
    dataFinalizacao DATETIME NOT NULL,
    dataEntrega DATE NOT NULL,
    valorTotal DECIMAL(7,2) NOT NULL,
    formaPagamento ENUM('Dinheiro', 'Pix', 'Cartão') NOT NULL,
    garantiaDias INT NOT NULL,
    observacao VARCHAR(200) NOT NULL
);

-- Tabela OrdemServico (Entidade fraca)
CREATE TABLE OrdemServico (
    idOrdem INT NOT NULL PRIMARY KEY,
    dataAbertura DATETIME NOT NULL,
    equipamento VARCHAR(50) NOT NULL,
    problema VARCHAR(100) NOT NULL,
    observacao VARCHAR(200) NOT NULL,
    prioridade ENUM('Baixa', 'Média', 'Alta') NOT NULL,
    estado ENUM('Aberta', 'Em execução', 'Concluída') NOT NULL,
    idCliente INT NOT NULL,
    idTecnico INT NOT NULL,
    idFinalizacao INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idTecnico) REFERENCES Tecnico(idTecnico),
    FOREIGN KEY (idFinalizacao) REFERENCES Finalizacao(idFinalizacao)
);

-- Tabela associativa OrdemServico_Servico (Entidade fraca)
CREATE TABLE OrdemServico_Servico (
    idOrdem INT NOT NULL,
    idServico INT NOT NULL,
    quantidade INT NOT NULL,
    valorUnitario DECIMAL(7,2) NOT NULL,
    PRIMARY KEY (idOrdem, idServico),
    FOREIGN KEY (idOrdem) REFERENCES OrdemServico(idOrdem),
    FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);
