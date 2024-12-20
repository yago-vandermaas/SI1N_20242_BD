#CRIANDO BANCO DE DADOS
CREATE SCHEMA ESTUDO_CASO_3;

#SELECIONANDO O BANCO DE DADOS
USE ESTUDO_CASO_3;


#CRIANDO TABELAS
    
#CRAINDO TABELA TIPO DE TELEFONE
CREATE TABLE IF NOT EXISTS TIPO_TELEFONE (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(50) NOT NULL
);

#CRAINDO TABELA TELEFONES
CREATE TABLE IF NOT EXISTS TELEFONES (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NUMERO VARCHAR(20) NOT NULL,
    TIPO_TELEFONE_ID INT,
    TIPO_ENTIDADE ENUM('CLIENTE', 'EMPREGADO', 'EMPRESA', 'FORNECEDOR') NOT NULL,
    ENTIDADE_ID INT NOT NULL,
    FOREIGN KEY (TIPO_TELEFONE_ID) REFERENCES TIPO_TELEFONE(ID)
);

#CRAINDO TABELA CLIENTES
CREATE TABLE IF NOT EXISTS CLIENTES (
    CODIGO INT PRIMARY KEY,
    CNPJ VARCHAR(18) UNIQUE NOT NULL,
    RAZAO_SOCIAL VARCHAR(255) NOT NULL,
    RAMO_ATIVIDADE VARCHAR(255),
    DATA_CADASTRAMENTO DATE,
    PESSOA_CONTATO VARCHAR(255)
);

#CRIANDO TABELA EMPREGADOS
CREATE TABLE IF NOT EXISTS EMPREGADOS (
    MATRICULA INT PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    CARGO VARCHAR(100),
    SALARIO DECIMAL(10, 2),
    DATA_ADMISSAO DATE,
    ENDERECO_ID INT,
    FOREIGN KEY (ENDERECO_ID) REFERENCES ENDERECOS(ID)
);

#CRIANDO TABELA EMPRESAS
CREATE TABLE IF NOT EXISTS EMPRESAS (
    CNPJ VARCHAR(18) PRIMARY KEY,
    RAZAO_SOCIAL VARCHAR(255) NOT NULL,
    PESSOA_CONTATO VARCHAR(255),
    ENDERECO_ID INT,
    FOREIGN KEY (ENDERECO_ID) REFERENCES ENDERECOS(ID)
);

#CRIANDO TABELA FORNECEDORES
CREATE TABLE IF NOT EXISTS FORNECEDORES (
    CNPJ VARCHAR(18) PRIMARY KEY,
    RAZAO_SOCIAL VARCHAR(255) NOT NULL,
    PESSOA_CONTATO VARCHAR(255),
    ENDERECO_ID INT,
    FOREIGN KEY (ENDERECO_ID) REFERENCES ENDERECOS(ID)
);

#CRAINDO TABELA TIPO DE ENDEREÇO
CREATE TABLE IF NOT EXISTS TIPO_ENDERECO (
    CODIGO INT PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL
);

#CRAINDO TABELA ENDEREÇOS
CREATE TABLE IF NOT EXISTS ENDERECOS (
    ID INT PRIMARY KEY,
    NUMERO VARCHAR(10),
    LOGRADOURO VARCHAR(255),
    COMPLEMENTO VARCHAR(100),
    CEP VARCHAR(10),
    BAIRRO VARCHAR(100),
    CIDADE VARCHAR(100),
    ESTADO VARCHAR(2),
    TIPO_ENDERECO_CODIGO INT,
    FOREIGN KEY (TIPO_ENDERECO_CODIGO) REFERENCES TIPO_ENDERECO(CODIGO)
);

#CRIANDO TABELA ENCOMENDAS
CREATE TABLE IF NOT EXISTS ENCOMENDAS (
    NUMERO INT PRIMARY KEY,
    DATA_INCLUSAO DATE,
    VALOR_TOTAL DECIMAL(10, 2),
    VALOR_DESCONTO DECIMAL(10, 2),
    VALOR_LIQUIDO DECIMAL(10, 2),
    FORMA_PAGAMENTO_ID INT,
    QUANTIDADE_PARCELAS INT,
    CODIGO_CLIENTE INT,
    FOREIGN KEY (CODIGO_CLIENTE) REFERENCES CLIENTES(CODIGO)
);

#CRAINDO TABELA PRODUTOS
CREATE TABLE IF NOT EXISTS PRODUTOS (
    CODIGO INT PRIMARY KEY,
    NOME VARCHAR(255),
    COR VARCHAR(50),
    DIMENSOES VARCHAR(100),
    PESO DECIMAL(10, 2),
    PRECO DECIMAL(10, 2),
    TEMPO_FABRICACAO TIME,
    DESENHO_PRODUTO BLOB,
    HORAS_MAO_OBRA DECIMAL(5, 2)
);

#CRIANDO TABELA TIPOS DE COMPONENTE
CREATE TABLE IF NOT EXISTS TIPOS_COMPONENTE (
    CODIGO INT PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL
);

#CRIANDO TABELA COMPONENTES
CREATE TABLE IF NOT EXISTS COMPONENTES (
    CODIGO INT PRIMARY KEY,
    NOME VARCHAR(255),
    QUANTIDADE_ESTOQUE INT,
    PRECO_UNITARIO DECIMAL(10, 2),
    UNIDADE VARCHAR(20),
    TIPO_COMPONENTE_CODIGO INT,
    FOREIGN KEY (TIPO_COMPONENTE_CODIGO) REFERENCES TIPOS_COMPONENTE(CODIGO)
);

#CRIANDO TABELA FORNECEDORES DE COMPONENTES
CREATE TABLE IF NOT EXISTS FORNECEDORES_COMPONENTES (
    CODIGO_FORNECEDOR VARCHAR(18),
    CODIGO_COMPONENTE INT,
    PRIMARY KEY (CODIGO_FORNECEDOR, CODIGO_COMPONENTE),
    FOREIGN KEY (CODIGO_FORNECEDOR) REFERENCES FORNECEDORES(CNPJ),
    FOREIGN KEY (CODIGO_COMPONENTE) REFERENCES COMPONENTES(CODIGO)
);

#CRIANDO TABELA MAQUINAS
CREATE TABLE IF NOT EXISTS MAQUINAS (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    TEMPO_VIDA INT,
    DATA_COMPRA DATE,
    DATA_FIM_GARANTIA DATE
);

#CRIANDO TABELA RECURSOS ESPECÍFICOS
CREATE TABLE IF NOT EXISTS RECURSOS_ESPECIFICOS (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    QUANTIDADE_NECESSARIA DECIMAL(10, 2),
    UNIDADE VARCHAR(20),
    TEMPO_USO TIME,
    HORAS_MAO_OBRA DECIMAL(5, 2)
);

#CRIANDO REGISTRO DE MANUTENÇÃO
CREATE TABLE IF NOT EXISTS REGISTRO_MANUTENCAO (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    DATA DATE,
    DESCRICAO TEXT,
    MAQUINA_ID INT,
    FOREIGN KEY (MAQUINA_ID) REFERENCES MAQUINAS(ID)
);

#CRIANDO TABELA REGISTRO DE SUPRIMENTOS
CREATE TABLE IF NOT EXISTS REGISTRO_SUPRIMENTOS (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    QUANTIDADE DECIMAL(10, 2),
    DATA_NECESSIDADE DATE,
    COMPONENTE_ID INT,
    FOREIGN KEY (COMPONENTE_ID) REFERENCES COMPONENTES(CODIGO)
);

#COMANDOS 
#ALTER TABLE EXAMPLES
#Exemplo: Adicionando uma coluna de email na tabela CLIENTES
ALTER TABLE CLIENTES ADD COLUMN EMAIL VARCHAR(255);

#Exemplo: Modificando o tipo de dados de SALARIO em EMPREGADOS
ALTER TABLE EMPREGADOS MODIFY SALARIO DECIMAL(12, 2);

#Exemplo: Adicionando uma restrição UNIQUE em NUMERO na tabela TELEFONES
ALTER TABLE TELEFONES ADD CONSTRAINT UNIQUE (NUMERO);

#DROP TABLE EXAMPLES
#Exemplo: Removendo a tabela RECURSOS_ESPECIFICOS
DROP TABLE IF EXISTS RECURSOS_ESPECIFICOS;

#Exemplo: Removendo a coluna PESSOA_CONTATO na tabela EMPRESAS
ALTER TABLE EMPRESAS DROP COLUMN PESSOA_CONTATO;
