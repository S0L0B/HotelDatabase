INSERT INTO tipo_reserva (origem) VALUES
    ('site'),
    ('tel'),
    ('presencial');


INSERT INTO tipo_quarto (tipo, nivel) VALUES
    ('single', 'standard'),
    ('double', 'standard'),
    ('twin', 'deluxe'),
    ('double', 'suite'),
    ('single', 'suite');


INSERT INTO quarto (status, numero, id_tipoquarto) VALUES
    ('disponivel', 101, 1),
    ('ocupado',    102, 2),
    ('disponivel', 103, 2),
    ('limpeza',    104, 3),
    ('disponivel', 201, 4),
    ('ocupado',    202, 4),
    ('disponivel', 301, 5),
    ('disponivel', 302, 3);


INSERT INTO departamento (nome) VALUES
    ('Recepcao'),
    ('Governanca'),
    ('Administracao'),
    ('Manutencao');


INSERT INTO cargo_funcionario (nome, id_departamento) VALUES
    ('Recepcionista', 1),
    ('Supervisor',    1),
    ('Camareira',     2),
    ('Gerente',       3),
    ('Tecnico',       4);


INSERT INTO funcionario (nome, cpf, email, data_contratacao, ativo_sn, id_cargo) VALUES
    ('Ana Paula Souza', '11122233344', 'ana@hotel.com',      '2021-03-15', 'S', 1),
    ('Carlos Mendes',   '22233344455', 'carlos@hotel.com',   '2020-07-01', 'S', 2),
    ('Fernanda Lima',   '33344455566', 'fernanda@hotel.com', '2022-01-10', 'S', 3),
    ('Roberto Alves',   '44455566677', 'roberto@hotel.com',  '2019-05-20', 'S', 4),
    ('Juliana Costa',   '55566677788', 'juliana@hotel.com',  '2023-02-28', 'S', 1);


INSERT INTO tel_funcionario (tipo, numero, id_funcionario) VALUES
    ('cel', '21991110001', 1),
    ('cel', '21991110002', 2),
    ('res', '2133330003',  3),
    ('cel', '21991110004', 4),
    ('cel', '21991110005', 5);


INSERT INTO endereco_funcionario
(id_funcionario, logradouro, numero, bairro, cidade, complemento, estado)
VALUES
    (1, 'Rua das Flores', '45', 'Tijuca', 'Rio de Janeiro', NULL, 'RJ'),
    (2, 'Av Brasil', '1200', 'Centro', 'Rio de Janeiro', 'Apto 301', 'RJ'),
    (3, 'Rua Marechal Hermes', '88', 'Madureira', 'Rio de Janeiro', NULL, 'RJ'),
    (4, 'Estrada do Pedregulho', '5', 'Guaratiba', 'Rio de Janeiro', 'Casa', 'RJ'),
    (5, 'Rua Senador Vergueiro', '210', 'Flamengo', 'Rio de Janeiro', 'Apto 12', 'RJ');


INSERT INTO cliente (data_cadastro, status_cred) VALUES
    ('2023-01-05', 'ativo'),
    ('2022-08-14', 'ativo'),
    ('2021-06-30', 'ativo'),
    ('2023-05-22', 'bloqueado'),
    ('2024-02-10', 'ativo');


INSERT INTO cliente_pessoa (tipo_pessoa, id_cliente) VALUES
    ('PF', 1),
    ('PF', 2),
    ('PJ', 3),
    ('PF', 4),
    ('PF', 5);


INSERT INTO pessoa_fisica (id_cliente_pessoa, nome, cpf, email) VALUES
    (1, 'Beatriz Ferreira', '77788899900', 'beatriz@email.com'),
    (2, 'Ricardo Nunes', '88899900011', 'ricardo@email.com'),
    (4, 'Patricia Andrade', '00011122233', 'patricia@email.com'),
    (5, 'Thiago Ramos', '11223344556', 'thiago@email.com');


INSERT INTO pessoa_juridica (id_cliente_pessoa, razao_social, cnpj, email) VALUES
    (3, 'Construtora Sol LTDA', '12.345.678/0001-90', 'contato@sol.com');


INSERT INTO tel_cliente (tipo, numero, id_cliente) VALUES
    ('cel', '21998880001', 1),
    ('cel', '21998880002', 2),
    ('com', '2133334444',  3),
    ('cel', '21998880004', 4),
    ('cel', '21998880005', 5);


INSERT INTO endereco_cliente
(id_cliente, logradouro, numero, bairro, cidade, complemento, estado)
VALUES
    (1, 'Rua Voluntarios da Patria', '320', 'Botafogo', 'Rio de Janeiro', 'Apto 502', 'RJ'),
    (2, 'Av Atlantica', '800', 'Copacabana', 'Rio de Janeiro', NULL, 'RJ'),
    (3, 'Rua da Quitanda', '10', 'Centro', 'Rio de Janeiro', 'Sala 1401', 'RJ'),
    (4, 'Rua Conde de Bonfim', '145', 'Tijuca', 'Rio de Janeiro', NULL, 'RJ'),
    (5, 'Estrada da Gavea', '900', 'Sao Conrado', 'Rio de Janeiro', 'Casa 3', 'RJ');


INSERT INTO reserva
(data_criacao, id_tiporeserva, id_tipoquarto, id_cliente, id_funcionario)
VALUES
    ('2024-06-01', 1, 2, 1, 1),
    ('2024-06-05', 2, 4, 2, 2),
    ('2024-06-10', 3, 5, 3, 1),
    ('2024-06-12', 1, 1, 4, 5),
    ('2024-06-18', 2, 3, 5, 1);


INSERT INTO checkin
(datahora, status, id_quarto, id_reserva, id_funcionario)
VALUES
    ('2024-06-03', 'ativo',      2, 1, 1),
    ('2024-06-07', 'ativo',      6, 2, 2),
    ('2024-06-11', 'finalizado', 7, 3, 1),
    ('2024-06-13', 'ativo',      1, 4, 5),
    ('2024-06-19', 'pendente',   3, 5, 1);


INSERT INTO checkout
(valor_total, metodo_pag, id_checkin, id_funcionario)
VALUES
    (850.00,  'cartao',        1, 1),
    (2400.00, 'transferencia', 2, 2),
    (5200.00, 'cedula',        3, 1);


INSERT INTO consumo (quantidade, valor, id_checkin) VALUES
    (2, 80.00, 1),
    (1, 35.50, 1),
    (3, 120.00, 2),
    (1, 55.00, 3),
    (2, 90.00, 4);


INSERT INTO hospedes
(nome, cpf, data_nasc, sexo, preferencias, id_checkin)
VALUES
    ('Beatriz Ferreira', '77788899900', '1990-04-12', 'F', 'Travesseiro extra', 1),
    ('Lucas Ferreira', '12312312399', '1992-09-25', 'M', NULL, 1),
    ('Ricardo Nunes', '88899900011', '1985-11-03', 'M', 'Cafe no quarto', 2),
    ('Mariana Nunes', '98798798711', '1988-07-17', 'F', 'Berco', 2),
    ('Patricia Andrade', '00011122233', '1995-02-28', 'F', 'Quarto silencioso', 4),
    ('Thiago Ramos', '11223344556', '1993-06-15', 'M', 'Vista para o mar', 5);


INSERT INTO tel_hospede (tipo, numero, id_hospede) VALUES
    ('cel', '21998880001', 1),
    ('cel', '21999991111', 2),
    ('cel', '21998880002', 3),
    ('cel', '21977772222', 4),
    ('cel', '21998880004', 5),
    ('cel', '21998880005', 6);
