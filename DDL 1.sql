CREATE DATABASE hotel;
USE hotel;
CREATE TABLE tipo_reserva (
    id_tiporeserva  INT,
    origem          VARCHAR(100) NOT NULL
);

CREATE TABLE tipo_quarto (
    id_tipoquarto   INT,
    tipo            VARCHAR(50) NOT NULL,
    nivel           VARCHAR(50)
);

CREATE TABLE quarto (
    id_quarto   INT,
    status      VARCHAR(50),
    numero      INT NOT NULL,
    id_tipoquarto INT
);

CREATE TABLE departamento_cargo (
    id_departamento INT,
    nome            VARCHAR(100) NOT NULL
);

CREATE TABLE cargo_funcionario (
    id_cargo        INT,
    nome            VARCHAR(100) NOT NULL,
    id_departamento INT
);

CREATE TABLE funcionario (
    id_funcionario   INT,
    nome             VARCHAR(100) NOT NULL,
    cpf              VARCHAR(11)  NOT NULL,
    email            VARCHAR(100),
    data_contratacao DATE         NOT NULL,
    ativo_sn         CHAR(1)      NOT NULL DEFAULT 'S',
    id_cargo         INT
);

CREATE TABLE tel_funcionario (
    id_telfuncionario INT,
    tipo              VARCHAR(30),
    numero            VARCHAR(20),
    id_funcionario    INT
);

CREATE TABLE endereco_funcionario (
    id_endereco    INT,
    id_funcionario INT,
    logradouro     VARCHAR(150) NOT NULL,
    numero         VARCHAR(10),
    bairro         VARCHAR(100),
    cidade         VARCHAR(100),
    complemento    VARCHAR(100),
    estado         CHAR(2)
);

CREATE TABLE cliente (
    id_cliente    INT,
    nome          VARCHAR(100) NOT NULL,
    cpf           VARCHAR(11)  NOT NULL,
    email         VARCHAR(100),
    data_cadastro DATE,
    status_cred   VARCHAR(50)
);

CREATE TABLE cliente_pessoa (
    id_cliente_pessoa INT,
    tipo_pessoa       VARCHAR(20) NOT NULL,
    id_cliente        INT
);

CREATE TABLE pessoa_juridica (
    id_pessoa_juridica INT,
    id_cliente_pessoa  INT,
    razao_social       VARCHAR(150) NOT NULL,
    cnpj               VARCHAR(18)  NOT NULL,
    email              VARCHAR(100)
);

CREATE TABLE pessoa_fisica (
    id_pessoa_fisica  INT,
    id_cliente_pessoa INT,
    nome              VARCHAR(100) NOT NULL,
    cpf               VARCHAR(11)  NOT NULL,
    email             VARCHAR(100)
);

CREATE TABLE tel_cliente (
    id_telcliente INT,
    tipo          VARCHAR(30),
    numero        VARCHAR(20),
    id_cliente    INT
);

CREATE TABLE endereco_cliente (
    id_endereco INT,
    id_cliente  INT,
    logradouro  VARCHAR(150) NOT NULL,
    numero      VARCHAR(10),
    bairro      VARCHAR(100),
    cidade      VARCHAR(100),
    complemento VARCHAR(100),
    estado      CHAR(2)
);

CREATE TABLE reserva (
    id_reserva      INT,
    data_criacao    DATE,
    id_tiporeserva  INT,
    id_tipoquarto   INT,
    id_cliente      INT,
    id_funcionario  INT
);

CREATE TABLE checkin (
    id_checkin     INT,
    datahora       DATETIME,
    status         VARCHAR(50),
    id_quarto      INT,
    id_reserva     INT,
    id_funcionario INT
);

CREATE TABLE checkout (
    id_checkout    INT,
    valor_total    DECIMAL(10,2),
    metodo_pag     VARCHAR(50),
    id_checkin     INT,
    id_funcionario INT
);

CREATE TABLE consumo (
    id_item    INT,
    quantidade INT,
    valor      DECIMAL(10,2),
    id_checkin INT
);

CREATE TABLE hospedes (
    id_hospede   INT,
    nome         VARCHAR(100),
    cpf          VARCHAR(11),
    data_nasc    DATE,
    sexo         CHAR(1),
    preferencias TEXT,
    id_checkin   INT
);

CREATE TABLE tel_hospede (
    id_telhospede INT,
    tipo          VARCHAR(30),
    numero        VARCHAR(20),
    id_hospede    INT
);

ALTER TABLE tipo_reserva
ADD CONSTRAINT PK_TIPO_RESERVA
PRIMARY KEY (id_tiporeserva),
MODIFY id_tiporeserva INT AUTO_INCREMENT;

ALTER TABLE tipo_quarto
ADD CONSTRAINT PK_TIPO_QUARTO
PRIMARY KEY (id_tipoquarto),
MODIFY id_tipoquarto INT AUTO_INCREMENT;

ALTER TABLE quarto
ADD CONSTRAINT PK_QUARTO
PRIMARY KEY (id_quarto),
MODIFY id_quarto INT AUTO_INCREMENT;

ALTER TABLE departamento_cargo
ADD CONSTRAINT PK_DEPARTAMENTO
PRIMARY KEY (id_departamento),
MODIFY id_departamento INT AUTO_INCREMENT;

ALTER TABLE cargo_funcionario
ADD CONSTRAINT PK_CARGO
PRIMARY KEY (id_cargo),
MODIFY id_cargo INT AUTO_INCREMENT;

ALTER TABLE funcionario
ADD CONSTRAINT PK_FUNCIONARIO
PRIMARY KEY (id_funcionario),
MODIFY id_funcionario INT AUTO_INCREMENT;

ALTER TABLE tel_funcionario
ADD CONSTRAINT PK_TEL_FUNCIONARIO
PRIMARY KEY (id_telfuncionario),
MODIFY id_telfuncionario INT AUTO_INCREMENT;

ALTER TABLE endereco_funcionario
ADD CONSTRAINT PK_ENDERECO_FUNCIONARIO
PRIMARY KEY (id_endereco),
MODIFY id_endereco INT AUTO_INCREMENT;

ALTER TABLE cliente
ADD CONSTRAINT PK_CLIENTE
PRIMARY KEY (id_cliente),
MODIFY id_cliente INT AUTO_INCREMENT;

ALTER TABLE cliente_pessoa
ADD CONSTRAINT PK_CLIENTE_PESSOA
PRIMARY KEY (id_cliente_pessoa),
MODIFY id_cliente_pessoa INT AUTO_INCREMENT;

ALTER TABLE pessoa_juridica
ADD CONSTRAINT PK_PESSOA_JURIDICA
PRIMARY KEY (id_pessoa_juridica),
MODIFY id_pessoa_juridica INT AUTO_INCREMENT;

ALTER TABLE pessoa_fisica
ADD CONSTRAINT PK_PESSOA_FISICA
PRIMARY KEY (id_pessoa_fisica),
MODIFY id_pessoa_fisica INT AUTO_INCREMENT;

ALTER TABLE tel_cliente
ADD CONSTRAINT PK_TEL_CLIENTE
PRIMARY KEY (id_telcliente),
MODIFY id_telcliente INT AUTO_INCREMENT;

ALTER TABLE endereco_cliente
ADD CONSTRAINT PK_ENDERECO_CLIENTE
PRIMARY KEY (id_endereco),
MODIFY id_endereco INT AUTO_INCREMENT;

ALTER TABLE reserva
ADD CONSTRAINT PK_RESERVA
PRIMARY KEY (id_reserva),
MODIFY id_reserva INT AUTO_INCREMENT;

ALTER TABLE checkin
ADD CONSTRAINT PK_CHECKIN
PRIMARY KEY (id_checkin),
MODIFY id_checkin INT AUTO_INCREMENT;

ALTER TABLE checkout
ADD CONSTRAINT PK_CHECKOUT
PRIMARY KEY (id_checkout),
MODIFY id_checkout INT AUTO_INCREMENT;

ALTER TABLE consumo
ADD CONSTRAINT PK_CONSUMO
PRIMARY KEY (id_item),
MODIFY id_item INT AUTO_INCREMENT;

ALTER TABLE hospedes
ADD CONSTRAINT PK_HOSPEDES
PRIMARY KEY (id_hospede),
MODIFY id_hospede INT AUTO_INCREMENT;

ALTER TABLE tel_hospede
ADD CONSTRAINT PK_TEL_HOSPEDE
PRIMARY KEY (id_telhospede),
MODIFY id_telhospede INT AUTO_INCREMENT;

ALTER TABLE funcionario
ADD CONSTRAINT UQ_CPF_FUNCIONARIO
UNIQUE (cpf);

ALTER TABLE cliente
ADD CONSTRAINT UQ_CPF_CLIENTE
UNIQUE (cpf);

ALTER TABLE pessoa_juridica
ADD CONSTRAINT UQ_CNPJ
UNIQUE (cnpj);

ALTER TABLE pessoa_fisica
ADD CONSTRAINT UQ_CPF_PESSOA_FISICA
UNIQUE (cpf);


ALTER TABLE quarto
ADD CONSTRAINT FK_QUARTO_TIPOQUARTO
FOREIGN KEY (id_tipoquarto)
REFERENCES tipo_quarto (id_tipoquarto);

ALTER TABLE cargo_funcionario
ADD CONSTRAINT FK_CARGO_DEPARTAMENTO
FOREIGN KEY (id_departamento)
REFERENCES departamento_cargo (id_departamento);

ALTER TABLE funcionario
ADD CONSTRAINT FK_FUNCIONARIO_CARGO
FOREIGN KEY (id_cargo)
REFERENCES cargo_funcionario (id_cargo);

ALTER TABLE tel_funcionario
ADD CONSTRAINT FK_TEL_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario);

ALTER TABLE endereco_funcionario
ADD CONSTRAINT FK_ENDERECO_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario);

ALTER TABLE cliente_pessoa
ADD CONSTRAINT FK_CLIENTE_PESSOA
FOREIGN KEY (id_cliente)
REFERENCES cliente (id_cliente);

ALTER TABLE pessoa_juridica
ADD CONSTRAINT FK_PESSOA_JURIDICA
FOREIGN KEY (id_cliente_pessoa)
REFERENCES cliente_pessoa (id_cliente_pessoa);

ALTER TABLE pessoa_fisica
ADD CONSTRAINT FK_PESSOA_FISICA
FOREIGN KEY (id_cliente_pessoa)
REFERENCES cliente_pessoa (id_cliente_pessoa);

ALTER TABLE tel_cliente
ADD CONSTRAINT FK_TEL_CLIENTE
FOREIGN KEY (id_cliente)
REFERENCES cliente (id_cliente);

ALTER TABLE endereco_cliente
ADD CONSTRAINT FK_ENDERECO_CLIENTE
FOREIGN KEY (id_cliente)
REFERENCES cliente (id_cliente);

ALTER TABLE reserva
ADD CONSTRAINT FK_RESERVA_TIPORESERVA
FOREIGN KEY (id_tiporeserva)
REFERENCES tipo_reserva (id_tiporeserva);

ALTER TABLE reserva
ADD CONSTRAINT FK_RESERVA_TIPOQUARTO
FOREIGN KEY (id_tipoquarto)
REFERENCES tipo_quarto (id_tipoquarto);

ALTER TABLE reserva
ADD CONSTRAINT FK_RESERVA_CLIENTE
FOREIGN KEY (id_cliente)
REFERENCES cliente (id_cliente);

ALTER TABLE reserva
ADD CONSTRAINT FK_RESERVA_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario);

ALTER TABLE checkin
ADD CONSTRAINT FK_CHECKIN_QUARTO
FOREIGN KEY (id_quarto)
REFERENCES quarto (id_quarto);

ALTER TABLE checkin
ADD CONSTRAINT FK_CHECKIN_RESERVA
FOREIGN KEY (id_reserva)
REFERENCES reserva (id_reserva);

ALTER TABLE checkin
ADD CONSTRAINT FK_CHECKIN_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario);

ALTER TABLE checkout
ADD CONSTRAINT FK_CHECKOUT_CHECKIN
FOREIGN KEY (id_checkin)
REFERENCES checkin (id_checkin);

ALTER TABLE checkout
ADD CONSTRAINT FK_CHECKOUT_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario);

ALTER TABLE consumo
ADD CONSTRAINT FK_CONSUMO_CHECKIN
FOREIGN KEY (id_checkin)
REFERENCES checkin (id_checkin);

ALTER TABLE hospedes
ADD CONSTRAINT FK_HOSPEDES_CHECKIN
FOREIGN KEY (id_checkin)
REFERENCES checkin (id_checkin);

ALTER TABLE tel_hospede
ADD CONSTRAINT FK_TEL_HOSPEDE
FOREIGN KEY (id_hospede)
REFERENCES hospedes (id_hospede);