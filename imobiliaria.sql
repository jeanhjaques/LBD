CREATE DATABASE imobiliaria;

CREATE SCHEMA imobiliaria;

SET search_path TO imobiliaria;


CREATE TABLE pessoa(
    nome VARCHAR(45) NOT NULL, 
    telefone VARCHAR(45) NOT NULL,
    endereco VARCHAR(45) NOT NULL,
    cpf VARCHAR(45) UNIQUE NOT NULL ,
    idpessoa SERIAL PRIMARY KEY
);

CREATE TABLE cliente(
    email VARCHAR(45) NOT NULL,
    sexo VARCHAR(45) NOT NULL, 
    estadocivil VARCHAR(45), 
    profissao VARCHAR(45), 
    idpessoa INT NOT NULL, 
    idcliente SERIAL PRIMARY KEY,
    CONSTRAINT fk_cliente_pessoa
        FOREIGN KEY (idpessoa)
        REFERENCES pessoa(idpessoa)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE usuario(
    idusuario SERIAL PRIMARY KEY,
    idcliente INT NOT NULL,
    CONSTRAINT fk_usuario_cliente
        FOREIGN KEY (idusuario)
        REFERENCES cliente(idcliente)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE indicado(
    idindicado SERIAL PRIMARY KEY,
    idusuarioindicante INT NOT NULL,
    idpessoa INT NOT NULL,
    CONSTRAINT fk_indicado_pessoa
        FOREIGN KEY (idpessoa)
        REFERENCES pessoa(idpessoa)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_indicado_usuario
        FOREIGN KEY (idusuarioindicante)
        REFERENCES usuario(idusuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE fiador(
    idfiador SERIAL PRIMARY KEY,
    idusuariofiante INT NOT NULL,
    idpessoa INT NOT NULL,
        CONSTRAINT fk_fiador_pessoa
        FOREIGN KEY (idpessoa)
        REFERENCES pessoa(idpessoa)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_fiador_usuario
        FOREIGN KEY (idusuariofiante)
        REFERENCES usuario(idusuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE proprietario(
    idproprietario SERIAL PRIMARY KEY,
    idcliente INT NOT NULL,
    CONSTRAINT fk_proprietario_cliente
        FOREIGN KEY (idcliente)
        REFERENCES cliente(idcliente)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE cargo(
    salariobase MONEY NOT NULL,
    idcargo SERIAL PRIMARY KEY
);

CREATE TABLE funcionario(
    telcelular VARCHAR(45) NOT NULL,
    dataingimobiliaria DATE NOT NULL,
    usuario VARCHAR(45) NOT NULL,
    senha VARCHAR(128) NOT NULL,
    idpessoa INT NOT NULL,
    idcargo INT NOT NULL,
    idfuncionario SERIAL PRIMARY KEY,
    CONSTRAINT fk_funcionario_pessoa
        FOREIGN KEY (idpessoa)
        REFERENCES pessoa(idpessoa)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_funcionario_cargo
        FOREIGN KEY (idcargo)
        REFERENCES cargo(idcargo)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE imovel(
	idimovel SERIAL PRIMARY KEY,
	area INT NOT NULL,
	rua VARCHAR(45) NOT NULL,
	bairro VARCHAR(45) NOT NULL,
	estadolocacao BOOLEAN,
	estadovenda BOOLEAN,
	valorrealvenda INT NOT NULL,
	valorsugeridovenda INT NOT NULL,
	valorsugeridoaluguel INT NOT NULL,
	dataconstrucao INT NOT NULL,
	idproprietario INT NOT NULL,
	CONSTRAINT fk_imovel_proprietario
		FOREIGN KEY (idproprietario)
		REFERENCES proprietario(idproprietario)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE seguro(
	idseguro SERIAL PRIMARY KEY,
	nomedaseguradora VARCHAR(45) NOT NULL,
	cnpj VARCHAR(45) NOT NULL,
	tipodoseguro VARCHAR(45) NOT NULL,
	valor MONEY NOT NULL,
	idimovel INT NOT NULL,
    CONSTRAINT fk_seguro_idimovel
        FOREIGN KEY (idimovel)
        REFERENCES imovel(idimovel)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE foto(
	nomefoto VARCHAR(45) NOT NULL,
	idfoto SERIAL PRIMARY KEY,
	idimovel INT NOT NULL,
    CONSTRAINT fk_foto_idimovel
        FOREIGN KEY (idimovel)
        REFERENCES imovel(idimovel)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);


CREATE TABLE terreno(
	idterreno SERIAL PRIMARY KEY,
	largura INT NOT NULL,
	comprimento INT NOT NULL,
	aclivedeclive INT NOT NULL,
	idimovel INT NOT NULL,
	CONSTRAINT fk_terreno_imovel
		FOREIGN KEY (idimovel)
		REFERENCES imovel(idimovel)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);


CREATE TABLE salacomercial(
	idsalacomercial SERIAL PRIMARY KEY,
	qtdbanheiros INT NOT NULL,
	qtdcomodos INT NOT NULL,
	idimovel INT NOT NULL,
	CONSTRAINT fk_salacomercial_imovel
		FOREIGN KEY (idimovel)
		REFERENCES imovel(idimovel)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);


CREATE TABLE imovelresidencial(
	idimovelresidencial SERIAL PRIMARY KEY,
	qtdquartos INT NOT NULL,
	qtdsuites INT NOT NULL,
	qtdsalaestar INT NOT NULL,
	qtdsalasjantar INT NOT NULL,
	armarioembutido BOOLEAN,
	descricao VARCHAR (45) NOT NULL,
	idimovel INT NOT NULL,
	CONSTRAINT fk_imovelresidencial_imovel
		FOREIGN KEY (idimovel)
		REFERENCES imovel(idimovel)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);


CREATE TABLE casa(
	idcasa SERIAL PRIMARY KEY,
	idimovelresidencial INT NOT NULL,
	CONSTRAINT fk_casa_imovelresidencial
		FOREIGN KEY (idimovelresidencial)
		REFERENCES imovelresidencial(idimovelresidencial)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);


	CREATE TABLE apartamento(
	idapartamento SERIAL PRIMARY KEY,
	andar INT NOT NULL,
	valorcondominio  INT NOT NULL,
	portaria24h  INT NOT NULL,
	idimovelresidencial INT NOT NULL,
	CONSTRAINT fk_apartamento_imovelresidencial
		FOREIGN KEY (idimovelresidencial)
		REFERENCES imovelresidencial(idimovelresidencial)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE formapagamento(
    idformapagamento SERIAL PRIMARY KEY,
    nomeformapagamento VARCHAR(45) NOT NULL
);

CREATE TABLE transacao(
    datatransacao DATE NOT NULL,
    comissaofuncionario MONEY NOT NULL,
    nrocontrato SERIAL,
    idtransacao SERIAL PRIMARY KEY,
    idusuario INT NOT NULL,
    idfuncionario INT NOT NULL,
    idformapagamento INT NOT NULL,
    idimovel INT NOT NULL,
    aluguelouvenda BOOLEAN NOT NULL,
    CONSTRAINT fk_transacao_usuario
        FOREIGN KEY (idusuario)
        REFERENCES usuario(idusuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_transacao_funcionario
        FOREIGN KEY (idfuncionario)
        REFERENCES funcionario(idfuncionario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_transacao_formapagamento
        FOREIGN KEY (idformapagamento)
        REFERENCES formapagamento(idformapagamento)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_transacao_idimovel
        FOREIGN KEY (idimovel)
        REFERENCES imovel(idimovel)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);


--inserts

insert into pessoa(nome, telefone, endereco, cpf, idpessoa) values('Guilherme', '1111111111', 'Rua das Palmeiras', '11100077771', 1);
insert into pessoa(nome, telefone, endereco, cpf, idpessoa) values('Jean', '2222222222', 'Rua das Pinhais', '11100077772', 2);

insert into cliente(email, sexo, estadocivil, profissao, idpessoa, idcliente) values('guilherme@email.com', 'masculino', 'casado', 'vigia', 1, 1);
insert into cliente(email, sexo, estadocivil, profissao, idpessoa, idcliente) values('jean@email.com', 'masculino', 'solteiro', 'vendedor', 2, 2);

insert into usuario(idusuario, idcliente) values(1, 1);
insert into usuario(idusuario, idcliente) values(2, 2);

insert into indicado(idindicado, idusuarioindicante, idpessoa) values(1, 1, 1);
insert into indicado(idindicado, idusuarioindicante, idpessoa) values(2, 2, 2);

insert into fiador(idfiador, idusuariofiante,idpessoa) values(1, 1, 1);
insert into fiador(idfiador, idusuariofiante,idpessoa) values(2, 2, 2);

insert into proprietario(idproprietario, idcliente) values(1, 1);
insert into proprietario(idproprietario, idcliente) values(2, 2);

insert into cargo(salariobase, idcargo) values(2500.00, 1);
insert into cargo(salariobase, idcargo) values(3500.00, 2);

insert into funcionario(telcelular, dataingimobiliaria, usuario, senha, idpessoa, idcargo, idfuncionario) values('3333333333', '2020-05-06', 'jean', 'jean123', 1, 1, 1);
insert into funcionario(telcelular, dataingimobiliaria, usuario, senha, idpessoa, idcargo, idfuncionario) values('3333333334', '2020-06-06', 'guilherme', 'guilherme123', 2, 2, 2);

insert into imovel(idimovel, area, rua, bairro, estadolocacao, estadovenda, valorrealvenda, valorsugeridovenda, valorsugeridoaluguel, dataconstrucao, idproprietario) values(1, 500,'Rua da arvore', 'Bairro da mesa', TRUE, TRUE, 20000.00, 10000.00, 1000.00, '2020-10-06', 1);
insert into imovel(idimovel, area, rua, bairro, estadolocacao, estadovenda, valorrealvenda, valorsugeridovenda, valorsugeridoaluguel, dataconstrucao, idproprietario) values(2, 500,'Rua da roda', 'Bairro da cerca', FALSE, FALSE, 30000.00, 20000.00, 2000.00, '2020-10-06', 1);

insert into seguro(idseguro, nomedaseguradora, cnpj, tipodoseguro, valor, idimovel) values(1, 'Segura Tudo', '12345678987654', 'roubo', 200.00, 1);
insert into seguro(idseguro, nomedaseguradora, cnpj, tipodoseguro, valor, idimovel) values(2, 'Grande Seguro', '12345678986655', 'incendio', 600.00, 2);

insert into foto(nomefoto, idfoto, idimovel) values('Casa preta', 1, 1);
insert into foto(nomefoto, idfoto, idimovel) values('Casa branca', 2, 2);

insert into terreno(idterreno, largura, comprimento, aclivedeclive, idimovel) values(1, 500, 600, 1);
insert into terreno(idterreno, largura, comprimento, aclivedeclive, idimovel) values(2, 700, 800, 2);

insert into salacomercial(idsalacomercial, qtdbanheiros, qtdcomodos, idimovel) values(1, 1, 5, 1);
insert into salacomercial(idsalacomercial, qtdbanheiros, qtdcomodos, idimovel) values(2, 2, 6, 2);

insert into imovelresidencial(idimovelresidencial, qtdquartos, qtdsuites, qtdsalasestar, qtdsalasjantar, armarioembutido, descricao, idimovel) values(1, 2, 1, 1, 1, FALSE, 'Imovel confortavel', 1);
insert into imovelresidencial(idimovelresidencial, qtdquartos, qtdsuites, qtdsalasestar, qtdsalasjantar, armarioembutido, descricao, idimovel) values(2, 3, 2, 2, 2, TRUE, 'Imovel de luxo', 2);

insert into casa(idcasa, idimovelresidencial) values(1, 1);
insert into casa(idcasa, idimovelresidencial) values(2, 2);

insert into apartamento(idapartamento, andar, valorcondominio, portaria24h, idimovelresidencial) values(1, 2, 100000.00, TRUE, 1);
insert into apartamento(idapartamento, andar, valorcondominio, portaria24h, idimovelresidencial) values(2, 1, 50000.00, FALSE, 2);

insert into formapagamento(idformapagamento, nomeformapagamento) values(1, 'credito');
insert into formapagamento(idformapagamento, nomeformapagamento) values(2, 'dinheiro');

insert into transacao(datatransacao, comissaofuncionario, nrocontrato, idtransacao, idusuario, idfuncionario, idformapagamento, idimovel, aluguelouvenda) values('2020-10-06', 150.00,1, 1, 1, 1, 1, TRUE);
insert into transacao(datatransacao, comissaofuncionario, nrocontrato, idtransacao, idusuario, idfuncionario, idformapagamento, idimovel, aluguelouvenda) values('2019-10-06', 160.00,2, 2, 2, 2, 2, FALSE);

--selects

--busca dados dos clientes usuario
SELECT * FROM usuario as u JOIN cliente as c ON u.idcliente = c.idcliente JOIN pessoa as p ON c.idpessoa = p.idpessoa;

--busca dados dos clientes proprietarios
SELECT * FROM proprietario as prop JOIN cliente as c ON prop.idcliente = c.idcliente JOIN pessoa as p ON c.idpessoa = p.idpessoa;

--seleciona todos os imoveis
SELECT * FROM imovel;

--seleciona todos as imagens dos imoveis
SELECT * FROM foto as f JOIN imovel as i ON f.idimovel = i.idimovel;

--seleciona todos os apartamentos
SELECT * FROM apartamento as a JOIN imovelresidencial as ir ON a.idimovelresidencial = ir.idimovelresidencial
  JOIN imovel as i ON ir.idimovel = i.idimovel;
  
--seleciona todos os funcionarios
SELECT * FROM funcionario as f JOIN pessoa as p ON f.idpessoa = p.idpessoa;

--seleciona todos os funcionarios e seus salarios base
SELECT p.nome, c.salariobase FROM funcionario as f JOIN pessoa as p ON f.idpessoa = p.idpessoa JOIN cargo as c ON f.idcargo = c.idcargo;

--seleciona todas as transações do tipo aluguel
SELECT * FROM transacao WHERE aluguelouvenda = 'aluguel';

--seleciona todas as transações ocorridas em 2020
SELECT * FROM transacao WHERE datatransacao > '31/12/2019';

--seleciona todas as transacoes onde a forma de pagamento foi credito
SELECT * FROM transacao as t JOIN formapagamento as f ON t.idformapagamento = f.idformapagamento WHERE f.nomeformapagamento = 'crédito';
