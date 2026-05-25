
INSERT INTO tipo_reserva (origem) VALUES
    ('Site oficial'),
    ('Telefone'),
    ('Agencia de viagem'),
    ('Balcao'),
    ('Aplicativo movel');

INSERT INTO tipo_quarto (tipo, nivel) VALUES
    ('Solteiro',    'Standard'),
    ('Casal',       'Standard'),
    ('Duplo',       'Standard'),
    ('Suite',       'Superior'),
    ('Suite Master','Luxo');


INSERT INTO quarto (status, numero, id_tipoquarto) VALUES
    ('Disponivel',  101, 1),
    ('Ocupado',     102, 2),
    ('Disponivel',  103, 2),
    ('Manutencao',  104, 3),
    ('Disponivel',  201, 4),
    ('Ocupado',     202, 4),
    ('Disponivel',  301, 5),
    ('Disponivel',  302, 3);


INSERT INTO departamento_cargo (nome) VALUES
    ('Recepcao'),
    ('Governanca'),
    ('Alimentos e Bebidas'),
    ('Administracao'),
    ('Manutencao');



INSERT INTO cargo_funcionario (nome, id_departamento) VALUES
    ('Recepcionista',       1),
    ('Supervisor Recepcao', 1),
    ('Camareira',           2),
    ('Governanta',          2),
    ('Garcom',              3),
    ('Gerente Geral',       4),
    ('Tecnico Manutencao',  5);



INSERT INTO funcionario (nome, cpf, email, data_contratacao, ativo_sn, id_cargo) VALUES
    ('Ana Paula Souza',  '11122233344', 'ana.souza@hotel.com',      '2021-03-15', 'S', 1),
    ('Carlos Mendes',    '22233344455', 'carlos.mendes@hotel.com',  '2019-07-01', 'S', 2),
    ('Fernanda Lima',    '33344455566', 'fernanda.lima@hotel.com',  '2022-01-10', 'S', 3),
    ('Roberto Alves',    '44455566677', 'roberto.alves@hotel.com',  '2018-05-20', 'S', 6),
    ('Juliana Costa',    '55566677788', 'juliana.costa@hotel.com',  '2023-02-28', 'S', 1),
    ('Marcos Pereira',   '66677788899', 'marcos.pereira@hotel.com', '2020-11-03', 'S', 7);


INSERT INTO tel_funcionario (tipo, numero, id_funcionario) VALUES
    ('Celular',    '21991110001', 1),
    ('Celular',    '21991110002', 2),
    ('Residencial','2133330003',  3),
    ('Celular',    '21991110004', 4),
    ('Celular',    '21991110005', 5),
    ('Celular',    '21991110006', 6);



INSERT INTO endereco_funcionario (id_funcionario, logradouro, numero, bairro, cidade, complemento, estado) VALUES
    (1, 'Rua das Flores',       '45',   'Tijuca',    'Rio de Janeiro', NULL,       'RJ'),
    (2, 'Av. Brasil',           '1200', 'Centro',    'Rio de Janeiro', 'Apto 301', 'RJ'),
    (3, 'Rua Marechal Hermes',  '88',   'Madureira', 'Rio de Janeiro', NULL,       'RJ'),
    (4, 'Estrada do Pedregulho','5',    'Guaratiba', 'Rio de Janeiro', 'Casa',     'RJ'),
    (5, 'Rua Sen. Vergueiro',   '210',  'Flamengo',  'Rio de Janeiro', 'Apto 12',  'RJ'),
    (6, 'Travessa Sao Jose',    '33',   'Meier',     'Rio de Janeiro', NULL,       'RJ');



INSERT INTO cliente (nome, cpf, email, data_cadastro, status_cred) VALUES
    ('Beatriz Ferreira',    '77788899900', 'beatriz.f@email.com',  '2023-01-05', 'Aprovado'),
    ('Ricardo Nunes',       '88899900011', 'ricardo.n@email.com',  '2022-08-14', 'Aprovado'),
    ('Construtora Sol LTDA','99900011122', 'contato@solconst.com', '2021-06-30', 'Aprovado'),
    ('Patricia Andrade',    '00011122233', 'patricia.a@email.com', '2023-05-22', 'Pendente'),
    ('Thiago Ramos',        '11223344556', 'thiago.r@email.com',   '2024-02-10', 'Aprovado');



INSERT INTO cliente_pessoa (tipo_pessoa, id_cliente_pessoa) VALUES
    ('PF', 1),
    ('PF', 2),
    ('PJ', 3),
    ('PF', 4),
    ('PF', 5);


INSERT INTO pessoa_fisica (id_cliente_pessoa, nome, cpf, email) VALUES
    (1, 'Beatriz Ferreira', '77788899900', 'beatriz.f@email.com'),
    (2, 'Ricardo Nunes',    '88899900011', 'ricardo.n@email.com'),
    (4, 'Patricia Andrade', '00011122233', 'patricia.a@email.com'),
    (5, 'Thiago Ramos',     '11223344556', 'thiago.r@email.com');



INSERT INTO pessoa_juridica (id_cliente_pessoa, razao_social, cnpj, email) VALUES
    (3, 'Construtora Sol LTDA', '12.345.678/0001-90', 'contato@solconst.com');


INSERT INTO tel_cliente (tipo, numero, id_cliente) VALUES
    ('Celular',   '21998880001', 1),
    ('Celular',   '21998880002', 2),
    ('Comercial', '2133334444',  3),
    ('Celular',   '21998880004', 4),
    ('Celular',   '21998880005', 5);


INSERT INTO endereco_cliente (id_cliente, logradouro, numero, bairro, cidade, complemento, estado) VALUES
    (1, 'Rua Voluntarios da Patria', '320', 'Botafogo',   'Rio de Janeiro', 'Apto 502', 'RJ'),
    (2, 'Av. Atlantica',             '800', 'Copacabana', 'Rio de Janeiro', NULL,       'RJ'),
    (3, 'Rua da Quitanda',           '10',  'Centro',     'Rio de Janeiro', 'Sala 1401','RJ'),
    (4, 'Rua Conde de Bonfim',       '145', 'Tijuca',     'Rio de Janeiro', NULL,       'RJ'),
    (5, 'Estrada da Gavea',          '900', 'Sao Conrado','Rio de Janeiro', 'Casa 3',   'RJ');


INSERT INTO reserva (data_criacao, id_tiporeserva, id_tipoquarto, id_cliente, id_funcionario) VALUES
    ('2024-06-01', 1, 2, 1, 1),
    ('2024-06-05', 2, 4, 2, 2),
    ('2024-06-10', 3, 5, 3, 1),
    ('2024-06-12', 1, 1, 4, 5),
    ('2024-06-18', 5, 3, 5, 5);


INSERT INTO checkin (datahora, status, id_quarto, id_reserva, id_funcionario) VALUES
    ('2024-06-03 14:00:00', 'Ativo',     2, 1, 1),
    ('2024-06-07 15:30:00', 'Ativo',     6, 2, 2),
    ('2024-06-11 13:00:00', 'Encerrado', 7, 3, 1),
    ('2024-06-13 16:00:00', 'Ativo',     1, 4, 5),
    ('2024-06-19 14:45:00', 'Ativo',     3, 5, 5);



INSERT INTO checkout (valor_total, metodo_pag, id_checkin, id_funcionario) VALUES
    (850.00,  'Cartao de Credito', 1, 1),
    (2400.00, 'PIX',               2, 2),
    (5200.00, 'Transferencia',     3, 1);



INSERT INTO consumo (quantidade, valor, id_checkin) VALUES
    (2,  80.00, 1),
    (1,  35.50, 1),
    (3, 120.00, 2),
    (1,  55.00, 3),
    (2,  90.00, 4);



INSERT INTO hospedes (nome, cpf, data_nasc, sexo, preferencias, id_checkin) VALUES
    ('Beatriz Ferreira', '77788899900', '1990-04-12', 'F', 'Travesseiro extra, andar alto', 1),
    ('Lucas Ferreira',   '12312312399', '1992-09-25', 'M', NULL,                            1),
    ('Ricardo Nunes',    '88899900011', '1985-11-03', 'M', 'Cafe da manha no quarto',       2),
    ('Mariana Nunes',    '98798798711', '1988-07-17', 'F', 'Berco para bebe',               2),
    ('Repr. Sol LTDA',   NULL,          NULL,         'M', NULL,                            3),
    ('Patricia Andrade', '00011122233', '1995-02-28', 'F', 'Quarto silencioso',             4),
    ('Thiago Ramos',     '11223344556', '1993-06-15', 'M', 'Vista para o mar',              5);



INSERT INTO tel_hospede (tipo, numero, id_hospede) VALUES
    ('Celular', '21998880001', 1),
    ('Celular', '21999991111', 2),
    ('Celular', '21998880002', 3),
    ('Celular', '21977772222', 4),
    ('Celular', '21998880004', 6),
    ('Celular', '21998880005', 7);
