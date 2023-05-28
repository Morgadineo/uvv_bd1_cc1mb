-- Apaga o banco de dados "uvv" caso já exista
DROP DATABASE 	IF EXISTS uvv;

-- Apaga o usuário "arthur" caso já exista
DROP USER 	IF EXISTS arthur;

-- Cria usuário
CREATE USER arthur WITH password 'arthur7751' CREATEDB;

-- Cria o banco de dados da UVV
CREATE DATABASE uvv
	OWNER arthur
	TEMPLATE template0
	ENCODING 'UTF8'
	LC_COLLATE 'pt_BR.UTF-8'
	LC_CTYPE 'pt_BR.UTF-8'
	ALLOW_CONNECTIONS true;

\c 'dbname=uvv user=arthur password=arthur7751';


CREATE SCHEMA lojas AUTHORIZATION arthur;

ALTER USER arthur SET SEARCH_PATH TO lojas, "$user", public;

SET search_path TO lojas, '$user', public;

-- Cria a tabela "produtos" e adiciona os comentários
CREATE TABLE produtos (
                produto_id 		  			NUMERIC(38) 	NOT NULL,
                nome 			  			VARCHAR(255) 	NOT NULL,
                preco_unitario 		 		NUMERIC(10,2),
                detalhes 		  			BYTEA,
                imagem 			  			BYTEA,
                imagem_mime_type 	  		VARCHAR(512),
                imagem_arquivo 		  		VARCHAR(512),
                imagem_charset 		  		VARCHAR(512),
                imagem_ultima_atualizacao 	DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);

COMMENT ON TABLE produtos 								IS 'Tabela de produtos.';
COMMENT ON COLUMN produtos.produto_id 					IS 'Id do produto. (PK da tabela produtos).';
COMMENT ON COLUMN produtos.nome 						IS 'Nome do produto.';
COMMENT ON COLUMN produtos.preco_unitario 				IS 'Preço unitário do produto.';
COMMENT ON COLUMN produtos.detalhes 					IS 'Detalhes do produto.';
COMMENT ON COLUMN produtos.imagem 						IS 'Imagem do produto.';
COMMENT ON COLUMN produtos.imagem_mime_type 			IS 'Tipo do mime da imagem do produto.';
COMMENT ON COLUMN produtos.imagem_arquivo 				IS 'Arquivo da imagem do produto.';
COMMENT ON COLUMN produtos.imagem_charset 				IS 'Charset da imagme do produto.';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao 	IS 'Data da ultima atualização da imagem do produto.';

-- Constraints da tabela produtos
ALTER TABLE produtos ADD CONSTRAINT chk_produto_id CHECK (produto_id >= 0);
ALTER TABLE produtos ADD CONSTRAINT chk_nome CHECK (nome <> ' ');
ALTER TABLE produtos ADD CONSTRAINT chk_preco_unitario CHECK (preco_unitario >= 0);

-- Cria a tabela "lojas" e adiciona os comentários
CREATE TABLE lojas (
                loja_id 					NUMERIC(38)  NOT NULL,
                nome 						VARCHAR(255) NOT NULL,
                endereco_web 				VARCHAR(100),
                endereco_fisico 			VARCHAR(512),
                latitude 					NUMERIC,
                longitude 					NUMERIC,
                logo 						BYTEA,
                logo_mime_type 				VARCHAR(512),
                logo_arquivo 				VARCHAR(512),
                logo_charset 				VARCHAR(512),
                logo_ultima_atualizacao 	DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);

COMMENT ON TABLE lojas 								IS 'Tabela de lojas.';
COMMENT ON COLUMN lojas.loja_id 					IS 'Id da loja. (PK da tabela lojas)';
COMMENT ON COLUMN lojas.nome 						IS 'Nome da loja.';
COMMENT ON COLUMN lojas.endereco_web 				IS 'Endereço web da loja.';
COMMENT ON COLUMN lojas.endereco_fisico 			IS 'Endereço físico da loja.';
COMMENT ON COLUMN lojas.latitude 					IS 'Latitude da loja.';
COMMENT ON COLUMN lojas.longitude 					IS 'Longitude da loja.';
COMMENT ON COLUMN lojas.logo 						IS 'Logo da loja.';
COMMENT ON COLUMN lojas.logo_mime_type 				IS 'Tipo da logo mime da loja.';
COMMENT ON COLUMN lojas.logo_arquivo 				IS 'Arquivo da logo da loja.';
COMMENT ON COLUMN lojas.logo_charset 				IS 'Logo charset da loja.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao 	IS 'Data de ultima atualização da logo da loja.';

-- Constraints da tabela lojas
ALTER TABLE lojas ADD CONSTRAINT chk_loja_id 	CHECK (loja_id >= 0);
ALTER TABLE lojas ADD CONSTRAINT chk_nome 		CHECK (nome <> ' ');
ALTER TABLE lojas ADD CONSTRAINT chk_enderecos 	CHECK(endereco_web IS not null OR endereco_fisico IS not null);

-- Cria a tabela "estoques" e adiciona os comentários
CREATE TABLE estoques (
                estoque_id 				NUMERIC(38) NOT NULL,
                loja_id 				NUMERIC(38) NOT NULL,
                produto_id 				NUMERIC(38) NOT NULL,
                quantidade 				NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);

COMMENT ON TABLE estoques 		IS 'Tabela de estoques.';
COMMENT ON COLUMN estoques.estoque_id IS 'Id do estoque. (PK da tabela estoques).';
COMMENT ON COLUMN estoques.loja_id 	IS 'Id da loja que realizou o estoque. (FK da tabela lojas)';
COMMENT ON COLUMN estoques.produto_id IS 'Id do produto em estoque. (FK da tabela produtos).';
COMMENT ON COLUMN estoques.quantidade IS 'Quantidade do produto estocado.';

-- Constraints da tabela estoques
ALTER TABLE estoques ADD CONSTRAINT chk_estoque_id CHECK (estoque_id >= 0);
ALTER TABLE estoques ADD CONSTRAINT chk_quantidade CHECK (quantidade >= 0);


-- Cria a tabela "clientes" e adiciona os comentários
CREATE TABLE clientes (
                client_id 		NUMERIC(38)  NOT NULL,
                email     		VARCHAR(255) NOT NULL,
                nome 	  		VARCHAR(255) NOT NULL,
                telefone1 		VARCHAR(20),
                telefone2 		VARCHAR(20),
                telefone3 		VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (client_id)
);

COMMENT ON TABLE clientes 	       		IS 'Tabela com as nformações dos clientes.';
COMMENT ON COLUMN clientes.client_id 	IS 'Id dos clientes. (PK da tabela clientes)';
COMMENT ON COLUMN clientes.email     	IS 'Email do cliente.';
COMMENT ON COLUMN clientes.nome      	IS 'Nome do cliente.';
COMMENT ON COLUMN clientes.telefone1 	IS 'Número de telefone do cliente.';
COMMENT ON COLUMN clientes.telefone2 	IS 'Segundo número telefone do cliente.';
COMMENT ON COLUMN clientes.telefone3 	IS 'Terceiro número de telefone do cliente.';

-- Constraints da tabela clientes
ALTER TABLE clientes ADD CONSTRAINT chk_client_id CHECK (client_id >= 0);
ALTER TABLE clientes ADD CONSTRAINT chk_nome CHECK (nome <> ' ');

-- Cria a tabela "envios" e adiciona os comentários
CREATE TABLE envios (
                envio_id 	 		NUMERIC(38)  NOT NULL,
                loja_id 	 		NUMERIC(38)  NOT NULL,
                client_id 	 		NUMERIC(38)  NOT NULL,
                endereco_entrega 	VARCHAR(512) NOT NULL,
                status 		 		VARCHAR(15)  NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);

COMMENT ON TABLE envios 	  	    IS 'Tabela de envios.';
COMMENT ON COLUMN envios.envio_id 	    IS 'Id do envio. (PK da tabela envios)';
COMMENT ON COLUMN envios.loja_id 	    IS 'Id da loja que realizou o envio. (FK da tabela lojas)';
COMMENT ON COLUMN envios.client_id 	    IS 'Id do cliente que realizou o envio. (FK da tabela clientes)';
COMMENT ON COLUMN envios.endereco_entrega IS 'Endereço de entrega do envio.';
COMMENT ON COLUMN envios.status 	    IS 'Status do envio.';

-- Constraints da tabela envios
ALTER TABLE envios ADD CONSTRAINT chk_status CHECK (status IN ('Criado', 'Enviado', 'Transito', 'Entregue'));

-- Cria a tabela "pedidos" e adiciona os comentários
CREATE TABLE pedidos (
                pedido_id 		NUMERIC(38) NOT NULL,
                data_hora 		TIMESTAMP   NOT NULL,
                client_id 		NUMERIC(38) NOT NULL,
                status    		VARCHAR(15) NOT NULL,
                loja_id   		NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);

COMMENT ON TABLE pedidos 				IS 'Tabela de pedidos.';
COMMENT ON COLUMN pedidos.pedido_id   	IS 'Id do pedido. (PK da tabela pedidos)';
COMMENT ON COLUMN pedidos.data_hora   	IS 'Data e hora e do pedido.';
COMMENT ON COLUMN pedidos.client_id   	IS 'Id do cliente que realizou o pedido. (FK da tabela clientes)';
COMMENT ON COLUMN pedidos.status      	IS 'Status do pedido.';
COMMENT ON COLUMN pedidos.loja_id     	IS 'Id da loja que realizou o pedido. (FK da tabela lojas)';

-- Constraints da tabela pedidos
ALTER TABLE pedidos ADD CONSTRAINT chk_status CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Cria a tabela "itens" e adiciona os comentários
CREATE TABLE pedidos_itens (
                pedido_id 			NUMERIC(38)   NOT NULL,
                produto_id 			NUMERIC(38)   NOT NULL,
                numero_da_linha 	NUMERIC(38)   NOT NULL,
                preco_unitario  	NUMERIC(10,2) NOT NULL,
                quantidade  		NUMERIC(38)   NOT NULL,
                envio_id 			NUMERIC(38)   NOT NULL,
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);

COMMENT ON TABLE pedidos_itens 				  	IS 'Tabela de itens pedidos.';
COMMENT ON COLUMN pedidos_itens.pedido_id 	  	IS 'Id do item pedido. (PK da tabela pedidos)';
COMMENT ON COLUMN pedidos_itens.produto_id      IS 'Id do produto pedido. (PK da tabela produtos).';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Numero da linha do item pedido.';
COMMENT ON COLUMN pedidos_itens.preco_unitario  IS 'Preco unitário do produto pedido.';
COMMENT ON COLUMN pedidos_itens.quantidade 	  	IS 'Quantidade do item pedido,';
COMMENT ON COLUMN pedidos_itens.envio_id        IS 'Id do envio. (PK da tabela envios)';

-- Constraints da tabela pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT chk_numero_da_linha CHECK (numero_da_linha >= 0);
ALTER TABLE pedidos_itens ADD CONSTRAINT chk_quantidade CHECK (envio_id >= 0);

-- Adiciona a FK "produto_id" na tabela "estoques"
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adiciona a FK "produto_id" na tabela "pedidos_itens"
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adiciona a FK "loja_id" na tabela "pedidos"
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adiciona a FK "loja_id" na tabela "envios"
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adiciona a FK "loja_id" na tabela "estoques"
ALTER TABLE estoques 
ADD CONSTRAINT lojas_estoques_fk FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adiciona a FK "client_id" na tabela "pedidos"
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (client_id)
REFERENCES clientes (client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adiciona a FK "client_id" na tabela "envios"
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (client_id)
REFERENCES clientes (client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adiciona a FK "envio_id" na tabela "pedidos_itens"
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adiciona a FK "pedido_id" na tabela "pedidos_itens"
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
