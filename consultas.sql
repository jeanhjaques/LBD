--selects

SET search_path TO imobiliaria;

--busca dados dos clientes usuario
SELECT * FROM usuario as u JOIN cliente as c ON u.idcliente = c.idcliente JOIN pessoa as p ON c.idpessoa = p.idpessoa;

--busca dados dos clientes proprietarios
SELECT * FROM proprietario as prop JOIN cliente as c ON prop.idcliente = c.idcliente JOIN pessoa as p ON c.idpessoa = p.idpessoa;

--seleciona todos as imagens dos imoveis
SELECT * FROM foto as f JOIN imovel as i ON f.idimovel = i.idimovel;

--seleciona todos os apartamentos
SELECT * FROM apartamento as a JOIN imovelresidencial as ir ON a.idimovelresidencial = ir.idimovelresidencial
  JOIN imovel as i ON ir.idimovel = i.idimovel;

--seleciona todos os funcionarios e seus salarios base
SELECT p.nome, c.salariobase FROM funcionario as f JOIN pessoa as p ON f.idpessoa = p.idpessoa JOIN cargo as c ON f.idcargo = c.idcargo;

--seleciona todas as transações do tipo aluguel
SELECT * FROM transacao WHERE aluguelouvenda = 'aluguel';

--seleciona todas as transações ocorridas em 2020
SELECT * FROM transacao WHERE datatransacao > '31/12/2019';

--seleciona todas as transacoes onde a forma de pagamento foi credito
SELECT * FROM transacao as t JOIN formapagamento as f ON t.idformapagamento = f.idformapagamento WHERE f.nomeformapagamento = 'crédito';

--busca todas as transações feitas em 2020 e com comissão do funcionário maior que R$ 120
SELECT * FROM transacao WHERE datatransacao > '2019/12/31' AND 
     (SELECT '120.00'::money) > comissaofuncionario;
	 
--cria view para mostrar funcionarios maior que 120
CREATE OR REPLACE VIEW dinheiro AS
SELECT * FROM transacao WHERE datatransacao > '2019/12/31' AND 
     (SELECT '120.00'::money) > comissaofuncionario;
