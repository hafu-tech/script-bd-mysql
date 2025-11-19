CREATE DATABASE IF NOT EXISTS hafutech;

USE hafutech;

CREATE TABLE Empresa(
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	codigoEmpresa VARCHAR(45) NOT NULL,
	email VARCHAR(65) NOT NULL,
	senha VARCHAR(45) NOT NULL
);

CREATE TABLE Notificacao(
	id_notificacao INT  AUTO_INCREMENT,
	fk_empresa INT,
    mensagem TEXT,
    status VARCHAR(45),
    data_envio DATETIME,
    CONSTRAINT fk_notificacao_empresa
    FOREIGN KEY (fk_empresa)
    REFERENCES Empresa(id_empresa),
    CONSTRAINT pkComposta PRIMARY KEY (id_notificacao,fk_empresa)
    );

CREATE TABLE Log_empresa(
	id_log_empresa INT AUTO_INCREMENT,
    titulo VARCHAR(45),
	data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
	descricao TEXT,
    fk_empresa INT,
    CONSTRAINT fk_empresa_log
    FOREIGN KEY (fk_empresa)
    REFERENCES Empresa(id_empresa),
    CONSTRAINT pk_composta PRIMARY KEY (id_log_empresa, fk_empresa)
);


CREATE TABLE Funcionario(
	id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(45) NOT NULL,
	senha VARCHAR(45) NOT NULL,
	nome_completo VARCHAR(45) NOT NULL,
	tipo_usuario VARCHAR(45) ,
	fk_empresa INT,
	CONSTRAINT fk_empresa_funcionario
	FOREIGN KEY (fk_empresa)
	REFERENCES Empresa(id_empresa)
);

CREATE TABLE Comentario(
	id_comentario INT AUTO_INCREMENT,
	titulo VARCHAR(45),
	descricao VARCHAR(250),
	fk_empresa INT NOT NULL,
	CONSTRAINT fk_empresa_comentario
	FOREIGN KEY (fk_empresa)
	REFERENCES Empresa(id_empresa),
	CONSTRAINT pkComposta PRIMARY KEY(id_comentario,fk_empresa)
);

CREATE TABLE Log_sistema(
	id_log_historico INT PRIMARY KEY AUTO_INCREMENT,
	data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
	descricao TEXT
);

CREATE TABLE Escola(
    id INT PRIMARY KEY AUTO_INCREMENT,
    ano INT NOT NULL,
    id_municipio INT NOT NULL,
    id_escola INT NOT NULL,
    area VARCHAR(100),
    localizacao VARCHAR(100),
    rede VARCHAR(100),
    inse_qtd_alunos INT,
    valor_inse DOUBLE,
    inse_classificacao2014 VARCHAR(50),
	inse_classificacao2015 VARCHAR(50)
);
