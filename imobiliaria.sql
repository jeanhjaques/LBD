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

CREATE TABLE usuario(
    idusuario SERIAL PRIMARY KEY,
    idcliente INT NOT NULL,
    CONSTRAINT fk_usuario_cliente
        FOREIGN KEY (idusuariofiante)
        REFERENCES usuario(idusuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
);

CREATE TABLE indicado(
    idindicado SERIAL PRIMARY KEY,
    idusuarioindicante INT NOT NULL,
    idpessoa INT NOT NULL,
    CONSTRAINT fk_indicado_pessoa
        FOREIGN KEY (idpessoa)
        REFERENCES pessoa(idpessoa)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION),
    CONSTRAINT fk_indicado_usuario
        FOREIGN KEY (idusuarioindicante)
        REFERENCES usuario(idusuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
);

CREATE TABLE fiador(
    idfiador SERIAL PRIMARY KEY,
    idusuariofiante INT NOT NULL,
    idpessoa INT NOT NULL,
        CONSTRAINT fk_fiador_pessoa
        FOREIGN KEY (idpessoa)
        REFERENCES pessoa(idpessoa)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION),
    CONSTRAINT fk_fiador_usuario
        FOREIGN KEY (idusuariofiante)
        REFERENCES usuario(idusuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
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
        ON UPDATE NO ACTION)
);

CREATE TABLE proprietario(
    idproprietario SERIAL PRIMARY KEY,
    idcliente INT PRIMARY KEY,
    CONSTRAINT fk_proprietario_cliente
        FOREIGN KEY (idcliente)
        REFERENCES cliente(idcliente)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
);

CREATE TABLE cargo(
    salariobase MONEY NOT NULL,
    idcargo SERIAL PRIMARY KEY,
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
        ON UPDATE NO ACTION),
    CONSTRAINT fk_funcionario_cargo
        FOREIGN KEY (idcargo)
        REFERENCES cargo(idcargo)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
);

CREATE TABLE imovel(
	idimovel SERIAL INT PRIMARY KEY,
	area INT NOT NULL,
	rua VARCHAR(45) NOT NULL,
	bairro VARCHAR(45) NOT NULL,
	estadolocacao BOOLEAN,
	estadovenda BOOLEAN,
	valorrealvenda INT NOT NULL,
	valorsugeridovenda INT NOT NULL,
	valorsugeridoaluguel INT NOT NULL,
	dataconstrucao INT NOT NULL
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
        ON UPDATE NO ACTION)
);

CREATE TABLE foto(
	nomefoto VARCHAR(45) NOT NULL,
	idfoto SERIAL PRIMARY KEY,
	idimovel INT NOT NULL,
    CONSTRAINT fk_foto_idimovel
        FOREIGN KEY (idimovel)
        REFERENCES imovel(idimovel)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
);


CREATE TABLE terreno(
	idterreno SERIAL INT PRIMARY KEY,
	largura INT NOT NULL,
	comprimento INT NOT NULL,
	aclivedeclive INT NOT NULL,
	CONSTRAINT fk_terreno_imovel
		FOREIGN KEY (idimovel)
		REFERENCES imovel(idimovel)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
);


CREATE TABLE salacomercial(
	idsalacomercial SERIAL INT PRIMARY KEY,
	qtdbanheiros INT NOT NULL,
	qtdcomodos INT NOT NULL,
	CONSTRAINT fk_salacomercial_imovel
		FOREIGN KEY (idimovel)
		REFERENCES imovel(idimovel)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
);


CREATE TABLE imovelresidencial(
	idimovelresidencial SERIAL INT PRIMARY KEY,
	qtdquartos INT NOT NULL,
	qtdsuites INT NOT NULL,
	qtdsalaestar INT NOT NULL,
	qtdsalasjantar INT NOT NULL,
	armarioembutido BOOLEAN,
	descricao VARCHAR (45) NOT NULL,
	CONSTRAINT fk_imovelresidencial_imovel
		FOREIGN KEY (idimovel)
		REFERENCES imovelresidencial(idimovelresidencial)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
);




CREATE TABLE casa(
	idcasa SERIAL INT PRIMARY KEY,
	CONSTRAINT fk_casa_imovelresidencial
		FOREIGN KEY (imovelresidencial)
		REFERENCES imovelresidencial(idimovelresidencial)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
);


	CREATE TABLE apartamento(
	idapartamento SERIAL INT PRIMARY KEY,
	andar INT NOT NULL,
	valorcondominio  INT NOT NULL,
	portaria24h  INT NOT NULL,
	CONSTRAINT fk_apartamento_imovelresidencial
		FOREIGN KEY (imovelresidencial)
		REFERENCES imovel(imovelresidencial)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
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
        ON UPDATE NO ACTION),
    CONSTRAINT fk_transacao_funcionario
        FOREIGN KEY (idfuncionario)
        REFERENCES funcionario(idfuncionario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION),
    CONSTRAINT fk_transacao_formapagamento
        FOREIGN KEY (idformapagamento)
        REFERENCES formapagamento(idformapagamento)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION),
    CONSTRAINT fk_transacao_idimovel
        FOREIGN KEY (idimovel)
        REFERENCES imovel(idimovel)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
);

