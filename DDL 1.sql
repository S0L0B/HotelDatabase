DROP TABLE IF EXISTS tel_hospede;
DROP TABLE IF EXISTS hospedes;
DROP TABLE IF EXISTS consumo;
DROP TABLE IF EXISTS checkout;
DROP TABLE IF EXISTS checkin;
DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS endereco_cliente;
DROP TABLE IF EXISTS tel_cliente;
DROP TABLE IF EXISTS pessoa_fisica;
DROP TABLE IF EXISTS pessoa_juridica;
DROP TABLE IF EXISTS cliente_pessoa;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS endereco_funcionario;
DROP TABLE IF EXISTS tel_funcionario;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS cargo_funcionario;
DROP TABLE IF EXISTS departamento;
DROP TABLE IF EXISTS quarto;
DROP TABLE IF EXISTS tipo_quarto;
DROP TABLE IF EXISTS tipo_reserva;

CREATE TABLE tipo_reserva (
    id_tiporeserva INT,
    origem ENUM('site', 'presencial', 'tel')
);

CREATE TABLE tipo_quarto (
    id_tipoquarto INT,
    tipo ENUM('single', 'double', 'twin'),
    nivel ENUM('standard', 'deluxe', 'suite')
);

CREATE TABLE quarto (
    id_quarto INT,
    status ENUM('disponivel', 'ocupado', 'limpeza'),
    numero INT NOT NULL,
    id_tipoquarto INT
);

CREATE TABLE departamento (
    id_departamento INT,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE cargo_funcionario (
    id_cargo INT,
    nome VARCHAR(50) NOT NULL,
    id_departamento INT
);

CREATE TABLE funcionario (
    id_funcionario INT,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    email VARCHAR(50),
    data_contratacao DATE NOT NULL,
    ativo_sn CHAR(1) NOT NULL DEFAULT 'S',
    id_cargo INT
);

CREATE TABLE tel_funcionario (
    id_telfuncionario INT,
    tipo ENUM('cel', 'com', 'res'),
    numero VARCHAR(20),
    id_funcionario INT
);

CREATE TABLE endereco_funcionario (
    id_endereco INT,
    id_funcionario INT,
    logradouro VARCHAR(50) NOT NULL,
    numero VARCHAR(5),
    bairro VARCHAR(20),
    cidade VARCHAR(15),
    complemento VARCHAR(20),
    estado CHAR(2)
);

CREATE TABLE cliente (
    id_cliente INT,
    data_cadastro DATE,
    status_cred ENUM('ativo', 'bloqueado')
);

CREATE TABLE cliente_pessoa (
    id_cliente_pessoa INT,
    tipo_pessoa VARCHAR(2) NOT NULL,
    id_cliente INT
);

CREATE TABLE pessoa_juridica (
    id_pessoa_juridica INT,
    id_cliente_pessoa INT,
    razao_social VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) NOT NULL,
    email VARCHAR(50)
);

CREATE TABLE pessoa_fisica (
    id_pessoa_fisica INT,
    id_cliente_pessoa INT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    email VARCHAR(50)
);

CREATE TABLE tel_cliente (
    id_telcliente INT,
    tipo ENUM('cel', 'com', 'res'),
    numero VARCHAR(20),
    id_cliente INT
);

CREATE TABLE endereco_cliente (
    id_endereco INT,
    id_cliente INT,
    logradouro VARCHAR(50) NOT NULL,
    numero VARCHAR(5),
    bairro VARCHAR(20),
    cidade VARCHAR(15),
    complemento VARCHAR(20),
    estado CHAR(2)
);

CREATE TABLE reserva (
    id_reserva INT,
    data_criacao DATE DEFAULT (CURRENT_DATE),
    id_tiporeserva INT,
    id_tipoquarto INT,
    id_cliente INT,
    id_funcionario INT
);

CREATE TABLE checkin (
    id_checkin INT,
    datahora DATE,
    status ENUM('pendente', 'ativo', 'finalizado', 'cancelado'),
    id_quarto INT,
    id_reserva INT,
    id_funcionario INT
);

CREATE TABLE checkout (
    id_checkout INT,
    valor_total DECIMAL(10,2),
    metodo_pag ENUM('cartao', 'transferencia', 'cedula'),
    id_checkin INT,
    id_funcionario INT
);

CREATE TABLE consumo (
    id_item INT,
    quantidade INT,
    valor DECIMAL(10,2),
    id_checkin INT
);

CREATE TABLE hospedes (
    id_hospede INT,
    nome VARCHAR(50),
    cpf VARCHAR(14),
    data_nasc DATE,
    sexo CHAR(1),
    preferencias TEXT,
    id_checkin INT
);

CREATE TABLE tel_hospede (
    id_telhospede INT,
    tipo ENUM('cel', 'com', 'res'),
    numero VARCHAR(20),
    id_hospede INT
);

ALTER TABLE tipo_reserva
ADD CONSTRAINT PK_TIPO_RESERVA
PRIMARY KEY (id_tiporeserva);

ALTER TABLE tipo_reserva
MODIFY id_tiporeserva INT AUTO_INCREMENT;

ALTER TABLE tipo_quarto
ADD CONSTRAINT PK_TIPO_QUARTO
PRIMARY KEY (id_tipoquarto);

ALTER TABLE tipo_quarto
MODIFY id_tipoquarto INT AUTO_INCREMENT;

ALTER TABLE quarto
ADD CONSTRAINT PK_QUARTO
PRIMARY KEY (id_quarto);

ALTER TABLE quarto
MODIFY id_quarto INT AUTO_INCREMENT;

ALTER TABLE departamento
ADD CONSTRAINT PK_DEPARTAMENTO
PRIMARY KEY (id_departamento);

ALTER TABLE departamento
MODIFY id_departamento INT AUTO_INCREMENT;

ALTER TABLE cargo_funcionario
ADD CONSTRAINT PK_CARGO
PRIMARY KEY (id_cargo);

ALTER TABLE cargo_funcionario
MODIFY id_cargo INT AUTO_INCREMENT;

ALTER TABLE funcionario
ADD CONSTRAINT PK_FUNCIONARIO
PRIMARY KEY (id_funcionario);

ALTER TABLE funcionario
MODIFY id_funcionario INT AUTO_INCREMENT;

ALTER TABLE tel_funcionario
ADD CONSTRAINT PK_TEL_FUNCIONARIO
PRIMARY KEY (id_telfuncionario);

ALTER TABLE tel_funcionario
MODIFY id_telfuncionario INT AUTO_INCREMENT;

ALTER TABLE endereco_funcionario
ADD CONSTRAINT PK_ENDERECO_FUNCIONARIO
PRIMARY KEY (id_endereco);

ALTER TABLE endereco_funcionario
MODIFY id_endereco INT AUTO_INCREMENT;

ALTER TABLE cliente
ADD CONSTRAINT PK_CLIENTE
PRIMARY KEY (id_cliente);

ALTER TABLE cliente
MODIFY id_cliente INT AUTO_INCREMENT;

ALTER TABLE cliente_pessoa
ADD CONSTRAINT PK_CLIENTE_PESSOA
PRIMARY KEY (id_cliente_pessoa);

ALTER TABLE cliente_pessoa
MODIFY id_cliente_pessoa INT AUTO_INCREMENT;

ALTER TABLE pessoa_juridica
ADD CONSTRAINT PK_PESSOA_JURIDICA
PRIMARY KEY (id_pessoa_juridica);

ALTER TABLE pessoa_juridica
MODIFY id_pessoa_juridica INT AUTO_INCREMENT;

ALTER TABLE pessoa_fisica
ADD CONSTRAINT PK_PESSOA_FISICA
PRIMARY KEY (id_pessoa_fisica);

ALTER TABLE pessoa_fisica
MODIFY id_pessoa_fisica INT AUTO_INCREMENT;

ALTER TABLE tel_cliente
ADD CONSTRAINT PK_TEL_CLIENTE
PRIMARY KEY (id_telcliente);

ALTER TABLE tel_cliente
MODIFY id_telcliente INT AUTO_INCREMENT;

ALTER TABLE endereco_cliente
ADD CONSTRAINT PK_ENDERECO_CLIENTE
PRIMARY KEY (id_endereco);

ALTER TABLE endereco_cliente
MODIFY id_endereco INT AUTO_INCREMENT;

ALTER TABLE reserva
ADD CONSTRAINT PK_RESERVA
PRIMARY KEY (id_reserva);

ALTER TABLE reserva
MODIFY id_reserva INT AUTO_INCREMENT;

ALTER TABLE checkin
ADD CONSTRAINT PK_CHECKIN
PRIMARY KEY (id_checkin);

ALTER TABLE checkin
MODIFY id_checkin INT AUTO_INCREMENT;

ALTER TABLE checkout
ADD CONSTRAINT PK_CHECKOUT
PRIMARY KEY (id_checkout);

ALTER TABLE checkout
MODIFY id_checkout INT AUTO_INCREMENT;

ALTER TABLE consumo
ADD CONSTRAINT PK_CONSUMO
PRIMARY KEY (id_item);

ALTER TABLE consumo
MODIFY id_item INT AUTO_INCREMENT;

ALTER TABLE hospedes
ADD CONSTRAINT PK_HOSPEDES
PRIMARY KEY (id_hospede);

ALTER TABLE hospedes
MODIFY id_hospede INT AUTO_INCREMENT;

ALTER TABLE tel_hospede
ADD CONSTRAINT PK_TEL_HOSPEDE
PRIMARY KEY (id_telhospede);

ALTER TABLE tel_hospede
MODIFY id_telhospede INT AUTO_INCREMENT;

ALTER TABLE funcionario
ADD CONSTRAINT UQ_CPF_FUNCIONARIO
UNIQUE (cpf);

ALTER TABLE pessoa_juridica
ADD CONSTRAINT UQ_CNPJ
UNIQUE (cnpj);

ALTER TABLE pessoa_fisica
ADD CONSTRAINT UQ_CPF_PESSOA_FISICA
UNIQUE (cpf);

ALTER TABLE checkout
ADD CONSTRAINT UQ_CHECKOUT_CHECKIN
UNIQUE (id_checkin);

ALTER TABLE funcionario
ADD CONSTRAINT CHK_ATIVO_SN
CHECK (ativo_sn IN ('S', 'N'));

ALTER TABLE cliente_pessoa
ADD CONSTRAINT CHK_TIPO_PESSOA
CHECK (tipo_pessoa IN ('PF', 'PJ'));

ALTER TABLE hospedes
ADD CONSTRAINT CHK_SEXO
CHECK (sexo IN ('M', 'F', 'O'));

ALTER TABLE consumo
ADD CONSTRAINT CHK_QUANTIDADE
CHECK (quantidade > 0);

ALTER TABLE consumo
ADD CONSTRAINT CHK_VALOR
CHECK (valor >= 0);

ALTER TABLE quarto
MODIFY id_tipoquarto INT NOT NULL;

ALTER TABLE cargo_funcionario
MODIFY id_departamento INT NOT NULL;

ALTER TABLE funcionario
MODIFY id_cargo INT NOT NULL;

ALTER TABLE tel_funcionario
MODIFY id_funcionario INT NOT NULL;

ALTER TABLE endereco_funcionario
MODIFY id_funcionario INT NOT NULL;

ALTER TABLE cliente_pessoa
MODIFY id_cliente INT NOT NULL;

ALTER TABLE pessoa_juridica
MODIFY id_cliente_pessoa INT NOT NULL;

ALTER TABLE pessoa_fisica
MODIFY id_cliente_pessoa INT NOT NULL;

ALTER TABLE tel_cliente
MODIFY id_cliente INT NOT NULL;

ALTER TABLE endereco_cliente
MODIFY id_cliente INT NOT NULL;

ALTER TABLE reserva
MODIFY id_tiporeserva INT NOT NULL,
MODIFY id_tipoquarto INT NOT NULL,
MODIFY id_cliente INT NOT NULL,
MODIFY id_funcionario INT NOT NULL;

ALTER TABLE checkin
MODIFY id_quarto INT NOT NULL,
MODIFY id_reserva INT NOT NULL,
MODIFY id_funcionario INT NOT NULL;

ALTER TABLE checkout
MODIFY id_checkin INT NOT NULL,
MODIFY id_funcionario INT NOT NULL;

ALTER TABLE consumo
MODIFY id_checkin INT NOT NULL;

ALTER TABLE hospedes
MODIFY id_checkin INT NOT NULL;

ALTER TABLE tel_hospede
MODIFY id_hospede INT NOT NULL;

ALTER TABLE quarto
ADD CONSTRAINT FK_QUARTO_TIPOQUARTO
FOREIGN KEY (id_tipoquarto)
REFERENCES tipo_quarto(id_tipoquarto);

ALTER TABLE cargo_funcionario
ADD CONSTRAINT FK_CARGO_DEPARTAMENTO
FOREIGN KEY (id_departamento)
REFERENCES departamento(id_departamento);

ALTER TABLE funcionario
ADD CONSTRAINT FK_FUNCIONARIO_CARGO
FOREIGN KEY (id_cargo)
REFERENCES cargo_funcionario(id_cargo);

ALTER TABLE tel_funcionario
ADD CONSTRAINT FK_TEL_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario(id_funcionario);

ALTER TABLE endereco_funcionario
ADD CONSTRAINT FK_ENDERECO_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario(id_funcionario);

ALTER TABLE cliente_pessoa
ADD CONSTRAINT FK_CLIENTE_PESSOA
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

ALTER TABLE pessoa_juridica
ADD CONSTRAINT FK_PESSOA_JURIDICA
FOREIGN KEY (id_cliente_pessoa)
REFERENCES cliente_pessoa(id_cliente_pessoa);

ALTER TABLE pessoa_fisica
ADD CONSTRAINT FK_PESSOA_FISICA
FOREIGN KEY (id_cliente_pessoa)
REFERENCES cliente_pessoa(id_cliente_pessoa);

ALTER TABLE tel_cliente
ADD CONSTRAINT FK_TEL_CLIENTE
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

ALTER TABLE endereco_cliente
ADD CONSTRAINT FK_ENDERECO_CLIENTE
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

ALTER TABLE reserva
ADD CONSTRAINT FK_RESERVA_TIPORESERVA
FOREIGN KEY (id_tiporeserva)
REFERENCES tipo_reserva(id_tiporeserva);

ALTER TABLE reserva
ADD CONSTRAINT FK_RESERVA_TIPOQUARTO
FOREIGN KEY (id_tipoquarto)
REFERENCES tipo_quarto(id_tipoquarto);

ALTER TABLE reserva
ADD CONSTRAINT FK_RESERVA_CLIENTE
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

ALTER TABLE reserva
ADD CONSTRAINT FK_RESERVA_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario(id_funcionario);

ALTER TABLE checkin
ADD CONSTRAINT FK_CHECKIN_QUARTO
FOREIGN KEY (id_quarto)
REFERENCES quarto(id_quarto);

ALTER TABLE checkin
ADD CONSTRAINT FK_CHECKIN_RESERVA
FOREIGN KEY (id_reserva)
REFERENCES reserva(id_reserva);

ALTER TABLE checkin
ADD CONSTRAINT FK_CHECKIN_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario(id_funcionario);

ALTER TABLE checkout
ADD CONSTRAINT FK_CHECKOUT_CHECKIN
FOREIGN KEY (id_checkin)
REFERENCES checkin(id_checkin);

ALTER TABLE checkout
ADD CONSTRAINT FK_CHECKOUT_FUNCIONARIO
FOREIGN KEY (id_funcionario)
REFERENCES funcionario(id_funcionario);

ALTER TABLE consumo
ADD CONSTRAINT FK_CONSUMO_CHECKIN
FOREIGN KEY (id_checkin)
REFERENCES checkin(id_checkin);

ALTER TABLE hospedes
ADD CONSTRAINT FK_HOSPEDES_CHECKIN
FOREIGN KEY (id_checkin)
REFERENCES checkin(id_checkin);

ALTER TABLE tel_hospede
ADD CONSTRAINT FK_TEL_HOSPEDE
FOREIGN KEY (id_hospede)
REFERENCES hospedes(id_hospede);
