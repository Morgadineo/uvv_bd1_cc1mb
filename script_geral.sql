
DROP DATABASE IF exist pset;
CREATE DATABASE pset;

USE pset;

CREATE TABLE public.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);
COMMENT ON TABLE public.produtos IS 'Tabela de produtos.';
COMMENT ON COLUMN public.produtos.produto_id IS 'Id do produto. (PK da tabela produtos).';
COMMENT ON COLUMN public.produtos.nome IS 'Nome do produto.';
COMMENT ON COLUMN public.produtos.preco_unitario IS 'Preço unitário do produto.';
COMMENT ON COLUMN public.produtos.detalhes IS 'Detalhes do produto.';
COMMENT ON COLUMN public.produtos.imagem IS 'Imagem do produto.';
COMMENT ON COLUMN public.produtos.imagem_mime_type IS 'Tipo do mime da imagem do produto.';
COMMENT ON COLUMN public.produtos.imagem_arquivo IS 'Arquivo da imagem do produto.';
COMMENT ON COLUMN public.produtos.imagem_charset IS 'Charset da imagme do produto.';
COMMENT ON COLUMN public.produtos.imagem_ultima_atualizacao IS 'Data da ultima atualização da imagem do produto.';


CREATE TABLE public.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
COMMENT ON TABLE public.lojas IS 'Tabela de lojas.';
COMMENT ON COLUMN public.lojas.loja_id IS 'Id da loja. (PK da tabela lojas)';
COMMENT ON COLUMN public.lojas.nome IS 'Nome da loja.';
COMMENT ON COLUMN public.lojas.endereco_web IS 'Endereço web da loja.';
COMMENT ON COLUMN public.lojas.endereco_fisico IS 'Endereço físico da loja.';
COMMENT ON COLUMN public.lojas.latitude IS 'Latitude da loja.';
COMMENT ON COLUMN public.lojas.longitude IS 'Longitude da loja.';
COMMENT ON COLUMN public.lojas.logo IS 'Logo da loja.';
COMMENT ON COLUMN public.lojas.logo_mime_type IS 'Tipo da logo mime da loja.';
COMMENT ON COLUMN public.lojas.logo_arquivo IS 'Arquivo da logo da loja.';
COMMENT ON COLUMN public.lojas.logo_charset IS 'Logo charset da loja.';
COMMENT ON COLUMN public.lojas.logo_ultima_atualizacao IS 'Data de ultima atualização da logo da loja.';


CREATE TABLE public.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE public.estoques IS 'Tabela de estoques.';
COMMENT ON COLUMN public.estoques.estoque_id IS 'Id do estoque. (PK da tabela estoques).';
COMMENT ON COLUMN public.estoques.loja_id IS 'Id da loja que realizou o estoque. (FK da tabela lojas)';
COMMENT ON COLUMN public.estoques.produto_id IS 'Id do produto em estoque. (FK da tabela produtos).';
COMMENT ON COLUMN public.estoques.quantidade IS 'Quantidade do produto estocado.';


CREATE TABLE public.clientes (
                client_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (client_id)
);
COMMENT ON TABLE public.clientes IS 'Tabela com as nformações dos clientes.';
COMMENT ON COLUMN public.clientes.client_id IS 'Id dos clientes. (PK da tabela clientes)';
COMMENT ON COLUMN public.clientes.email IS 'Email do cliente.';
COMMENT ON COLUMN public.clientes.nome IS 'Nome do cliente.';
COMMENT ON COLUMN public.clientes.telefone1 IS 'Número de telefone do cliente.';
COMMENT ON COLUMN public.clientes.telefone2 IS 'Segundo número telefone do cliente.';
COMMENT ON COLUMN public.clientes.telefone3 IS 'Terceiro número de telefone do cliente.';


CREATE TABLE public.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                client_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);
COMMENT ON TABLE public.envios IS 'Tabela de envios.';
COMMENT ON COLUMN public.envios.envio_id IS 'Id do envio. (PK da tabela envios)';
COMMENT ON COLUMN public.envios.loja_id IS 'Id da loja que realizou o envio. (FK da tabela lojas)';
COMMENT ON COLUMN public.envios.client_id IS 'Id do cliente que realizou o envio. (FK da tabela clientes)';
COMMENT ON COLUMN public.envios.endereco_entrega IS 'Endereço de entrega do envio.';
COMMENT ON COLUMN public.envios.status IS 'Status do envio.';


CREATE TABLE public.Pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                client_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE public.Pedidos IS 'Tabela de pedidos.';
COMMENT ON COLUMN public.Pedidos.pedido_id IS 'Id do pedido. (PK da tabela pedidos)';
COMMENT ON COLUMN public.Pedidos.data_hora IS 'Data e hora e do pedido.';
COMMENT ON COLUMN public.Pedidos.client_id IS 'Id do cliente que realizou o pedido. (FK da tabela clientes)';
COMMENT ON COLUMN public.Pedidos.status IS 'Status do pedido.';
COMMENT ON COLUMN public.Pedidos.loja_id IS 'Id da loja que realizou o pedido. (FK da tabela lojas)';


CREATE TABLE public.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE public.pedidos_itens IS 'Tabela de itens pedidos.';
COMMENT ON COLUMN public.pedidos_itens.pedido_id IS 'Id do item pedido. (PK da tabela pedidos)';
COMMENT ON COLUMN public.pedidos_itens.produto_id IS 'Id do produto pedido. (PK da tabela produtos).';
COMMENT ON COLUMN public.pedidos_itens.numero_da_linha IS 'Numero da linha do item pedido.';
COMMENT ON COLUMN public.pedidos_itens.preco_unitario IS 'Preco unitário do produto pedido.';
COMMENT ON COLUMN public.pedidos_itens.quantidade IS 'Quantidade do item pedido,';
COMMENT ON COLUMN public.pedidos_itens.envio_id IS 'Id do envio. (PK da tabela envios)';


ALTER TABLE public.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (client_id)
REFERENCES public.clientes (client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (client_id)
REFERENCES public.clientes (client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES public.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES public.Pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
