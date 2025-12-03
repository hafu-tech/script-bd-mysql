CREATE DATABASE IF NOT EXISTS hafutech;
	
USE hafutech;

CREATE TABLE IF NOT EXISTS Escola(
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
    inse_classificacao2015 VARCHAR(50),
    regiao VARCHAR(45)
);



CREATE TABLE IF NOT EXISTS Status_log_sistema(
id INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR(45),
descricao_status TEXT
);

CREATE TABLE IF NOT EXISTS Log_sistema(
id INT PRIMARY KEY AUTO_INCREMENT,
data_hora DATETIME,
descricao_log TEXT,
qtd_registro INT,
fk_status INT,
CONSTRAINT fk_status_log
FOREIGN KEY (fk_status)
REFERENCES Status_log_sistema(id)
);

-- CREATE TABLE Parametrizacao_notificacao_usuario_copy1(
-- id INT PRIMARY KEY AUTO_INCREMENT,
-- ano INT,
-- id_municipio INT,
-- area VARCHAR(45),
-- localizacao VARCHAR(100),
-- rede VARCHAR(100),
-- valor_inse DOUBLE
-- );

CREATE TABLE IF NOT EXISTS Empresa(
id INT PRIMARY KEY AUTO_INCREMENT,
nome_fantasia VARCHAR(45),
codigo_empresa VARCHAR(45),
email VARCHAR(100),
senha VARCHAR(45),
cnpj CHAR(14)
);

CREATE TABLE IF NOT EXISTS Canal_slack(
id INT PRIMARY KEY AUTO_INCREMENT,
webhook TEXT NOT NULL,
fk_empresa INT,
CONSTRAINT canal_empresa_slack
FOREIGN KEY (fk_empresa)
REFERENCES Empresa(id)
);

CREATE TABLE IF NOT EXISTS Status_log_empresa(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
descricao TEXT
);

CREATE TABLE IF NOT EXISTS Log_historico_empresa(
id INT AUTO_INCREMENT,
data_hora DATETIME,
descricao TEXT,
fk_empresa INT,
status_log_empresa_id INT,
CONSTRAINT pkComposta PRIMARY KEY(id, fk_empresa, status_log_empresa_id),
CONSTRAINT log_empresa
FOREIGN KEY (fk_empresa)
REFERENCES Empresa(id),
CONSTRAINT status_log
FOREIGN KEY (status_log_empresa_id)
REFERENCES Status_log_empresa(id)
);

CREATE TABLE IF NOT EXISTS Parametrizacao_notificacao_usuario(
id INT PRIMARY KEY AUTO_INCREMENT,
nome_parametro VARCHAR(50),
parametro VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Status_notificacao_slack(
id INT PRIMARY KEY AUTO_INCREMENT,
codigo_status_http CHAR(3),
classificacao_status CHAR(3),
descricao TEXT
);

CREATE TABLE IF NOT EXISTS Tipo_funcionario(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
descricao TEXT
);

CREATE TABLE IF NOT EXISTS Funcionario(
id INT PRIMARY KEY AUTO_INCREMENT,
email VARCHAR(45),
senha VARCHAR(45),
nome_funcionario VARCHAR(45),
fk_empresa INT,
tipo_funcionario INT,
CONSTRAINT fk_funcionario_empresa FOREIGN KEY (fk_empresa) REFERENCES Empresa(id),
CONSTRAINT fk_funcionario_tipo FOREIGN KEY (tipo_funcionario) REFERENCES Tipo_funcionario(id)
);



CREATE TABLE IF NOT EXISTS Analise (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45),
    descricao VARCHAR(250),
    fk_empresa INT,
    funcionario_id INT,
    funcionario_tipo_funcionario INT,
    CONSTRAINT fk_analise_empresa FOREIGN KEY (fk_empresa) REFERENCES Empresa(id),
    CONSTRAINT fk_analise_func FOREIGN KEY (funcionario_id) REFERENCES Funcionario(id),
    CONSTRAINT fk_analise_tipo_func FOREIGN KEY (funcionario_tipo_funcionario) REFERENCES Tipo_funcionario(id)
);


CREATE TABLE IF NOT EXISTS Status_slack_atividade (
    id INT PRIMARY KEY AUTO_INCREMENT,
    estado ENUM('ATIVO','INATIVO','AGENDADO'),
    data_agendamento DATE,
    empresa_id INT,
    CONSTRAINT fk_status_atividade_empresa FOREIGN KEY (empresa_id) REFERENCES Empresa(id)
);
    
   
CREATE TABLE IF NOT EXISTS Notificacao_slack (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fk_empresa INT,
    mensagem TEXT,
    data_envio DATETIME,
    parametrizacao_notificacao_usuario_id INT,
    status_slack_atividade_id INT,
    status_notificacao_slack_id INT,
    CONSTRAINT fk_notif_empresa FOREIGN KEY (fk_empresa) REFERENCES Empresa(id),
    CONSTRAINT fk_notif_param FOREIGN KEY (parametrizacao_notificacao_usuario_id) REFERENCES Parametrizacao_notificacao_usuario(id),
    CONSTRAINT fk_notif_status_atividade FOREIGN KEY (status_slack_atividade_id) REFERENCES Status_slack_atividade(id),
    CONSTRAINT fk_notif_status_slack FOREIGN KEY (status_notificacao_slack_id) REFERENCES Status_notificacao_slack(id)
);
    
		