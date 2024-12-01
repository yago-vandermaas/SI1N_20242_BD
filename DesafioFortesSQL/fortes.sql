CREATE TABLE login_colaborador (
    senha_login_colaborador INT PRIMARY KEY,
    nome_usuário_login_colaborador VARCHAR(100) NOT NULL
);

CREATE TABLE login_donatário (
    senha_login_donatário INT PRIMARY KEY,
    nome_usuário_login_donatário VARCHAR(100) NOT NULL
);

CREATE TABLE colaborador (
    id_colaborador INT AUTO_INCREMENT PRIMARY KEY,
    nome_colaborador VARCHAR(100) NOT NULL,
    email_colaborador VARCHAR(100) UNIQUE,
    telefone_colaborador VARCHAR(15),
    CONSTRAINT chk_telefone_colaborador CHECK (LENGTH(telefone_colaborador) >= 10)
);

CREATE TABLE donatário (
    id_donatário INT AUTO_INCREMENT PRIMARY KEY,
    nome_donatário VARCHAR(100) NOT NULL,
    email_donatário VARCHAR(100) UNIQUE,
    telefone_donatário VARCHAR(15),
    necessidade_donatário VARCHAR(300)
);

CREATE TABLE cadastro_donatário (
    id_cadastro_donatário INT PRIMARY KEY,
    nome_responsável_geral_cadastro_donatário VARCHAR(100) NOT NULL,
    nome_instituição_cadastro_donatário VARCHAR(100),
    setor_cadastro_donatário ENUM('RH', 'financeiro', 'TI', 'outro'),
    email_cadastro_donatário VARCHAR(100) UNIQUE,
    senha_cadastro_donatário VARCHAR(30) NOT NULL,
    id_donatário INT,
    CONSTRAINT fk_cadastro_donatario FOREIGN KEY (id_donatário) 
        REFERENCES donatário(id_donatário) 
);

CREATE TABLE minha_conta (
    cod_minha_conta VARCHAR(50) PRIMARY KEY,
    nome_usuário VARCHAR(100) NOT NULL,
    email_cadastrado VARCHAR(100) UNIQUE,
    telefone VARCHAR(15),
    papel_na_plataforma ENUM('colaborador', 'donatário', 'outro'),
    id_colaborador INT,
    id_donatário INT,
    CONSTRAINT fk_minha_conta_colaborador FOREIGN KEY (id_colaborador) 
        REFERENCES colaborador(id_colaborador),
    CONSTRAINT fk_minha_conta_donatario FOREIGN KEY (id_donatário) 
        REFERENCES donatário(id_donatário)
);

CREATE TABLE editais (
    setor_edital INT PRIMARY KEY,
    titulo_edital VARCHAR(255) NOT NULL,
    descrição_edital TEXT,
    data_publicação_edital DATE NOT NULL,
    data_encerramento_edital DATE,
    tipo_edital ENUM('Licitação', 'Concurso', 'Outros'),
    status_edital ENUM('Aberto', 'Encerrado', 'Cancelado')
);

CREATE TABLE equipes_fortificar (
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,
    nome_equipe VARCHAR(100) NOT NULL,
    descrição_equipe TEXT,
    data_criação_equipe DATE NOT NULL,
    status_equipe ENUM('Ativa', 'Inativa'),
    lider_equipe VARCHAR(100),
    número_membros INT DEFAULT 0,
    id_colaborador INT,
    CONSTRAINT fk_equipe_colaborador FOREIGN KEY (id_colaborador) 
        REFERENCES colaborador(id_colaborador),
    CONSTRAINT chk_numero_membros CHECK (número_membros >= 0)
);

CREATE TABLE projetos (
    id_projetos INT PRIMARY KEY,
    setor_projetos VARCHAR(300),
    nome_projeto VARCHAR(100) NOT NULL,
    data_inicio_projeto DATE NOT NULL,
    data_fim_projeto DATE,
    responsavel_projeto VARCHAR(200),
    descrição_projeto TEXT,
    orçamento_projeto DECIMAL(15,2),
    tipo_projeto ENUM('financeiro', 'TI', 'outro')
);

CREATE TABLE meus_projetos (
    id_meus_projetos INT AUTO_INCREMENT PRIMARY KEY,
    titulo_meus_projetos VARCHAR(200) NOT NULL,
    descrição_meus_projetos TEXT,
    data_inicio_meus_projetos DATE NOT NULL,
    data_fim_meus_projetos DATE,
    status_meus_projetos ENUM('Planejado', 'Em andamento', 'Concluído', 'Cancelado'),
    categoria_meus_projetos VARCHAR(100),
    id_projetos INT,
    CONSTRAINT fk_meus_projetos_projetos FOREIGN KEY (id_projetos) 
        REFERENCES projetos(id_projetos) 
);

CREATE TABLE contato_fortes (
    id_contato INT PRIMARY KEY,
    nome_contato VARCHAR(100),
    telefone_contato VARCHAR(15),
    email_contato VARCHAR(100),
    mensagem_contato VARCHAR(500),
    id_donatário INT,
    CONSTRAINT fk_contato_donatario FOREIGN KEY (id_donatário) 
        REFERENCES donatário(id_donatário) 
);

