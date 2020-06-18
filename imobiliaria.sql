
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
	REFERENCES imovel(idimovel)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
);




CREATE TABLE casa(
idcasa SERIAL INT PRIMARY KEY,
CONSTRAINT fk_casa_imovelresidencial
	FOREIGN KEY (imovelresidencial)
	REFERENCES imovel(imovelresidencial)
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

