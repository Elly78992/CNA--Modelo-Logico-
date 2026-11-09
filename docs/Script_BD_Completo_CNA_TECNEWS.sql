
-- 1. CRIACAO E SELECAO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS bd_cna_tecnews_entrega;

USE bd_cna_tecnews_entrega;


-- 2. CRIACAO DAS 20 TABELAS E SUAS RESTRICOES

-- 2.1 Departamento
CREATE TABLE Departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- 2.2 Fornecedor
CREATE TABLE Fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    tipo_fornecedor VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(150),
    CONSTRAINT uk_fornecedor_nome UNIQUE (nome)
) ENGINE=InnoDB;

-- 2.3 Software
CREATE TABLE Software (
    id_software INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    versao VARCHAR(50),
    CONSTRAINT uk_software_nome UNIQUE (nome)
) ENGINE=InnoDB;

-- 2.4 Colaborador
CREATE TABLE Colaborador (
    id_colaborador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100),
    email_corporativo VARCHAR(150),
    data_admissao DATE,
    data_desligamento DATE,
    status VARCHAR(30),
    id_departamento INT,
    CONSTRAINT uk_colaborador_email UNIQUE (email_corporativo),
    CONSTRAINT fk_colaborador_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento(id_departamento)
) ENGINE=InnoDB;

-- 2.5 Equipamento
CREATE TABLE Equipamento (
    id_equipamento INT AUTO_INCREMENT PRIMARY KEY,
    patrimonio VARCHAR(50),
    numero_serie VARCHAR(100),
    situacao VARCHAR(50),
    data_aquisicao DATE,
    data_fabricacao DATE,
    data_inicio_garantia DATE,
    data_limite_garantia DATE,
    modelo VARCHAR(100),
    fabricante VARCHAR(100),
    observacao TEXT,
    processador VARCHAR(100),
    memoria_ram VARCHAR(50),
    capacidade_disco VARCHAR(50),
    hostname VARCHAR(100),
    endereco_ip VARCHAR(45),
    CONSTRAINT uk_equipamento_patrimonio UNIQUE (patrimonio),
    CONSTRAINT uk_equipamento_numero_serie UNIQUE (numero_serie),
    CONSTRAINT chk_data_fabricacao CHECK (
        data_fabricacao IS NULL OR data_aquisicao IS NULL
        OR data_fabricacao <= data_aquisicao
    )
) ENGINE=InnoDB;

-- 2.6 Alocacao
CREATE TABLE Alocacao (
    id_alocacao INT AUTO_INCREMENT PRIMARY KEY,
    data_entrega DATE,
    data_devolucao DATE,
    situacao VARCHAR(50),
    observacao TEXT,
    condicao_devolucao VARCHAR(100),
    id_colaborador INT NOT NULL,
    id_equipamento INT NOT NULL,
    CONSTRAINT fk_alocacao_colaborador
        FOREIGN KEY (id_colaborador)
        REFERENCES Colaborador(id_colaborador),
    CONSTRAINT fk_alocacao_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES Equipamento(id_equipamento),
    CONSTRAINT chk_data_devolucao CHECK (
        data_devolucao IS NULL OR data_devolucao >= data_entrega
    )
) ENGINE=InnoDB;

-- 2.7 Movimentacao_destinacao
CREATE TABLE Movimentacao_destinacao (
    id_movimentacao_destinacao INT AUTO_INCREMENT PRIMARY KEY,
    data_movimentacao DATE,
    tipo_destinacao VARCHAR(100),
    descricao TEXT,
    destino VARCHAR(150),
    id_equipamento INT NOT NULL,
    CONSTRAINT fk_movimentacao_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES Equipamento(id_equipamento)
) ENGINE=InnoDB;

-- 2.8 Validacao
CREATE TABLE Validacao (
    id_validacao INT AUTO_INCREMENT PRIMARY KEY,
    data_hora_validacao DATETIME,
    responsavel VARCHAR(150),
    resultado VARCHAR(100),
    observacao TEXT,
    tipo_alteracao VARCHAR(100),
    sanitizacao_realizada BOOLEAN,
    id_equipamento INT NOT NULL,
    id_movimentacao_destinacao INT,
    CONSTRAINT fk_validacao_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES Equipamento(id_equipamento),
    CONSTRAINT fk_validacao_movimentacao
        FOREIGN KEY (id_movimentacao_destinacao)
        REFERENCES Movimentacao_destinacao(id_movimentacao_destinacao)
) ENGINE=InnoDB;

-- 2.9 Descarte
CREATE TABLE Descarte (
    id_descarte INT AUTO_INCREMENT PRIMARY KEY,
    data_descarte DATE,
    motivo TEXT,
    observacao TEXT,
    id_equipamento INT NOT NULL,
    id_movimentacao_destinacao INT,
    CONSTRAINT fk_descarte_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES Equipamento(id_equipamento),
    CONSTRAINT fk_descarte_movimentacao
        FOREIGN KEY (id_movimentacao_destinacao)
        REFERENCES Movimentacao_destinacao(id_movimentacao_destinacao)
) ENGINE=InnoDB;

-- 2.10 Licenca_software
CREATE TABLE Licenca_software (
    id_licenca_software INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT,
    data_inicio DATE,
    tipo_licenca VARCHAR(100),
    data_validade DATE,
    status VARCHAR(50),
    id_software INT NOT NULL,
    CONSTRAINT fk_licenca_software
        FOREIGN KEY (id_software)
        REFERENCES Software(id_software),
    CONSTRAINT chk_quantidade_licenca CHECK (quantidade > 0)
) ENGINE=InnoDB;

-- 2.11 Licenca_atribuicao
CREATE TABLE Licenca_atribuicao (
    id_licenca_atribuicao INT AUTO_INCREMENT PRIMARY KEY,
    data_inicio DATE,
    data_fim DATE,
    status VARCHAR(50),
    id_colaborador INT NOT NULL,
    id_equipamento INT NOT NULL,
    id_licenca_software INT NOT NULL,
    CONSTRAINT fk_atribuicao_colaborador
        FOREIGN KEY (id_colaborador)
        REFERENCES Colaborador(id_colaborador),
    CONSTRAINT fk_atribuicao_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES Equipamento(id_equipamento),
    CONSTRAINT fk_atribuicao_licenca
        FOREIGN KEY (id_licenca_software)
        REFERENCES Licenca_software(id_licenca_software),
    CONSTRAINT chk_data_licenca CHECK (
        data_fim IS NULL OR data_fim >= data_inicio
    )
) ENGINE=InnoDB;

-- 2.12 Solicitacao_compra
CREATE TABLE Solicitacao_compra (
    id_solicitacao_compra INT AUTO_INCREMENT PRIMARY KEY,
    motivo TEXT,
    status VARCHAR(50),
    id_colaborador INT NOT NULL,
    CONSTRAINT fk_solicitacao_colaborador
        FOREIGN KEY (id_colaborador)
        REFERENCES Colaborador(id_colaborador)
) ENGINE=InnoDB;

-- 2.13 Aprovacao_compra
CREATE TABLE Aprovacao_compra (
    id_aprovacao INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50),
    observacao TEXT,
    id_solicitacao_compra INT NOT NULL,
    CONSTRAINT fk_aprovacao_solicitacao
        FOREIGN KEY (id_solicitacao_compra)
        REFERENCES Solicitacao_compra(id_solicitacao_compra)
) ENGINE=InnoDB;

-- 2.14 Cotacao
CREATE TABLE Cotacao (
    id_cotacao INT AUTO_INCREMENT PRIMARY KEY,
    data_cotacao DATE,
    valor DECIMAL(12,2),
    condicoes TEXT,
    status VARCHAR(50),
    id_solicitacao_compra INT NOT NULL,
    id_fornecedor INT NOT NULL,
    CONSTRAINT fk_cotacao_solicitacao
        FOREIGN KEY (id_solicitacao_compra)
        REFERENCES Solicitacao_compra(id_solicitacao_compra),
    CONSTRAINT fk_cotacao_fornecedor
        FOREIGN KEY (id_fornecedor)
        REFERENCES Fornecedor(id_fornecedor),
    CONSTRAINT chk_valor_cotacao CHECK (valor > 0)
) ENGINE=InnoDB;

-- 2.15 Compra
CREATE TABLE Compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    numero_nota_fiscal VARCHAR(50),
    data_compra DATE,
    valor_total DECIMAL(12,2),
    status VARCHAR(50),
    id_cotacao INT NOT NULL,
    CONSTRAINT fk_compra_cotacao
        FOREIGN KEY (id_cotacao)
        REFERENCES Cotacao(id_cotacao),
    CONSTRAINT chk_valor_compra CHECK (valor_total > 0)
) ENGINE=InnoDB;

-- 2.16 Item_compra
CREATE TABLE Item_compra (
    id_item_compra INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255),
    quantidade INT,
    valor_unitario DECIMAL(12,2),
    id_compra INT NOT NULL,
    CONSTRAINT fk_item_compra
        FOREIGN KEY (id_compra)
        REFERENCES Compra(id_compra),
    CONSTRAINT chk_quantidade_item CHECK (quantidade > 0),
    CONSTRAINT chk_valor_unitario CHECK (valor_unitario > 0)
) ENGINE=InnoDB;

-- 2.17 Acionamento_garantia
CREATE TABLE Acionamento_garantia (
    id_acionamento_garantia INT AUTO_INCREMENT PRIMARY KEY,
    data_acionamento DATE,
    protocolo VARCHAR(100),
    status VARCHAR(50),
    resultado TEXT,
    id_equipamento INT NOT NULL,
    id_fornecedor INT NOT NULL,
    CONSTRAINT fk_garantia_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES Equipamento(id_equipamento),
    CONSTRAINT fk_garantia_fornecedor
        FOREIGN KEY (id_fornecedor)
        REFERENCES Fornecedor(id_fornecedor)
) ENGINE=InnoDB;

-- 2.18 Chamado
CREATE TABLE Chamado (
    id_chamado INT AUTO_INCREMENT PRIMARY KEY,
    data_abertura DATETIME,
    data_fechamento DATETIME,
    categoria VARCHAR(100),
    descricao TEXT,
    prioridade VARCHAR(30),
    status VARCHAR(50),
    id_colaborador INT NOT NULL,
    id_atendente INT,
    CONSTRAINT fk_chamado_colaborador
        FOREIGN KEY (id_colaborador)
        REFERENCES Colaborador(id_colaborador),
    CONSTRAINT fk_chamado_atendente
        FOREIGN KEY (id_atendente)
        REFERENCES Colaborador(id_colaborador),
    CONSTRAINT chk_data_fechamento CHECK (
        data_fechamento IS NULL OR data_fechamento >= data_abertura
    )
) ENGINE=InnoDB;

-- 2.19 Servico
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    tipo_servico VARCHAR(100),
    data_inicio DATETIME,
    data_fim DATETIME,
    descricao TEXT,
    status VARCHAR(50),
    resultado TEXT,
    id_chamado INT NOT NULL,
    id_fornecedor INT,
    id_equipamento INT NOT NULL,
    CONSTRAINT fk_servico_chamado
        FOREIGN KEY (id_chamado)
        REFERENCES Chamado(id_chamado),
    CONSTRAINT fk_servico_fornecedor
        FOREIGN KEY (id_fornecedor)
        REFERENCES Fornecedor(id_fornecedor),
    CONSTRAINT fk_servico_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES Equipamento(id_equipamento),
    CONSTRAINT chk_data_servico CHECK (
        data_fim IS NULL OR data_fim >= data_inicio
    )
) ENGINE=InnoDB;

-- 2.20 Celular
CREATE TABLE Celular (
    id_equipamento INT PRIMARY KEY,
    modelo VARCHAR(100),
    linha_telefonica VARCHAR(30),
    imei_1 VARCHAR(30),
    imei_2 VARCHAR(30),
    CONSTRAINT fk_celular_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES Equipamento(id_equipamento)
) ENGINE=InnoDB;

-- 3. INSERCAO DA MASSA DE DADOS (65 REGISTROS)

-- 3.1 Departamento (3 registros)
INSERT INTO Departamento (id_departamento, nome) VALUES
(1, 'Tecnologia da Informação'),
(2, 'Recursos Humanos'),
(3, 'Financeiro');

-- 3.2 Fornecedor (3 registros)
INSERT INTO Fornecedor (id_fornecedor, nome, tipo_fornecedor, telefone, email) VALUES
(1, 'Tech Solutions', 'Equipamentos de informática', '1133334444', 'contato@techsolutions.com.br'),
(2, 'Digital Software', 'Software e licenciamento', '1144445555', 'vendas@digitalsoftware.com.br'),
(3, 'Info Service', 'Manutenção e suporte técnico', '1155556666', 'suporte@infoservice.com.br');

-- 3.3 Software (3 registros)
INSERT INTO Software (id_software, nome, versao) VALUES
(1, 'Microsoft 365', '2025'),
(2, 'Windows 11 Pro', '23H2'),
(3, 'Antivirus Corporativo', '5.0');

-- 3.4 Colaborador (4 registros)
INSERT INTO Colaborador
(id_colaborador, nome, sobrenome, email_corporativo, data_admissao, data_desligamento, status, id_departamento)
VALUES
(1, 'Ana', 'Silva', 'ana.silva@tecnews.com.br', '2023-02-10', NULL, 'Ativo', 1),
(2, 'Carlos', 'Souza', 'carlos.souza@tecnews.com.br', '2022-06-15', NULL, 'Ativo', 1),
(3, 'Mariana', 'Oliveira', 'mariana.oliveira@tecnews.com.br', '2024-01-08', NULL, 'Ativo', 2),
(4, 'Pedro', 'Santos', 'pedro.santos@tecnews.com.br', '2021-09-20', NULL, 'Ativo', 3);

-- 3.5 Equipamento (5 registros)
INSERT INTO Equipamento
(id_equipamento, patrimonio, numero_serie, situacao, data_aquisicao, data_fabricacao, data_inicio_garantia, data_limite_garantia, modelo, fabricante, observacao, processador, memoria_ram, capacidade_disco, hostname, endereco_ip)
VALUES
(1, 'PAT-001', 'SN-NB-001', 'Em uso', '2024-01-15', '2023-12-10', '2024-01-15', '2027-01-15', 'ThinkPad E14', 'Lenovo', 'Notebook utilizado pela equipe de TI', 'Intel Core i5', '16 GB', '512 GB SSD', 'TEC-NB-001', '192.168.1.101'),
(2, 'PAT-002', 'SN-NB-002', 'Em uso', '2024-03-10', '2024-02-01', '2024-03-10', '2027-03-10', 'Latitude 5440', 'Dell', 'Notebook para atividades administrativas', 'Intel Core i7', '16 GB', '512 GB SSD', 'TEC-NB-002', '192.168.1.102'),
(3, 'PAT-003', 'SN-MON-003', 'Descartado', '2020-05-20', '2020-03-15', '2020-05-20', '2021-05-20', 'Monitor LED 21', 'Samsung', 'Monitor antigo sem condições de uso', NULL, NULL, NULL, NULL, NULL),
(4, 'PAT-004', 'SN-CEL-004', 'Em uso', '2025-01-10', '2024-12-01', '2025-01-10', '2027-01-10', 'Galaxy A55', 'Samsung', 'Celular corporativo da equipe de TI', 'Exynos 1480', '8 GB', '256 GB', NULL, NULL),
(5, 'PAT-005', 'SN-CEL-005', 'Em estoque', '2025-02-05', '2025-01-10', '2025-02-05', '2027-02-05', 'Moto G85', 'Motorola', 'Celular disponível para alocação', 'Snapdragon 6s Gen 3', '8 GB', '256 GB', NULL, NULL);

-- 3.6 Celular (2 registros)
INSERT INTO Celular (id_equipamento, modelo, linha_telefonica, imei_1, imei_2) VALUES
(4, 'Galaxy A55', '11999990000', '356789123456789', '356789123456797'),
(5, 'Moto G85', '11987650001', 'IMEI-MASSA-003-A', 'IMEI-MASSA-003-B');

-- 3.7 Alocacao (4 registros)
INSERT INTO Alocacao
(id_alocacao, data_entrega, data_devolucao, situacao, observacao, condicao_devolucao, id_colaborador, id_equipamento)
VALUES
(1, '2024-02-01', NULL, 'Ativa', 'Notebook entregue para atividades de TI', NULL, 1, 1),
(2, '2024-03-15', NULL, 'Ativa', 'Notebook utilizado no suporte técnico', NULL, 2, 2),
(3, '2025-01-15', NULL, 'Ativa', 'Celular corporativo entregue', NULL, 1, 4),
(4, '2024-05-10', '2024-12-20', 'Encerrada', 'Equipamento devolvido ao setor de TI', 'Bom estado', 3, 5);

-- 3.8 Movimentacao_destinacao (3 registros)
INSERT INTO Movimentacao_destinacao
(id_movimentacao_destinacao, data_movimentacao, tipo_destinacao, descricao, destino, id_equipamento)
VALUES
(1, '2024-02-01', 'Entrega', 'Entrega de notebook ao colaborador', 'Ana Silva', 1),
(2, '2024-03-15', 'Entrega', 'Entrega de notebook para suporte técnico', 'Carlos Souza', 2),
(3, '2025-03-01', 'Descarte', 'Encaminhamento de monitor sem condições de uso', 'Descarte eletrônico especializado', 3);

-- 3.9 Validacao (3 registros)
INSERT INTO Validacao
(id_validacao, data_hora_validacao, responsavel, resultado, observacao, tipo_alteracao, sanitizacao_realizada, id_equipamento, id_movimentacao_destinacao)
VALUES
(1, '2025-01-10 09:30:00', 'Ana Silva', 'Aprovado', 'Equipamento conferido e funcionando', 'Conferência de inventário', 0, 1, 1),
(2, '2025-01-12 14:00:00', 'Carlos Souza', 'Aprovado', 'Número de patrimônio e série conferidos', 'Atualização cadastral', 0, 2, 2),
(3, '2025-03-01 16:00:00', 'Ana Silva', 'Aprovado', 'Descarte registrado e validado', 'Descarte', 1, 3, 3);

-- 3.10 Descarte (1 registro)
INSERT INTO Descarte
(id_descarte, data_descarte, motivo, observacao, id_equipamento, id_movimentacao_destinacao)
VALUES
(1, '2025-03-01', 'Equipamento obsoleto e sem condições de reparo', 'Encaminhado para descarte eletrônico adequado', 3, 3);

-- 3.11 Licenca_software (3 registros)
INSERT INTO Licenca_software
(id_licenca_software, quantidade, data_inicio, tipo_licenca, data_validade, status, id_software)
VALUES
(1, 20, '2025-01-01', 'Corporativa', '2026-12-31', 'Ativa', 1),
(2, 15, '2025-01-01', 'Corporativa', '2026-12-31', 'Ativa', 2),
(3, 10, '2025-02-01', 'Corporativa', '2027-02-01', 'Ativa', 3);

-- 3.12 Licenca_atribuicao (4 registros)
INSERT INTO Licenca_atribuicao
(id_licenca_atribuicao, data_inicio, data_fim, status, id_colaborador, id_equipamento, id_licenca_software)
VALUES
(1, '2025-01-10', NULL, 'Ativa', 1, 1, 1),
(2, '2025-01-10', NULL, 'Ativa', 2, 2, 1),
(3, '2025-01-15', NULL, 'Ativa', 1, 1, 2),
(4, '2025-02-10', NULL, 'Ativa', 3, 2, 3);

-- 3.13 Solicitacao_compra (3 registros)
INSERT INTO Solicitacao_compra
(id_solicitacao_compra, motivo, status, id_colaborador)
VALUES
(1, 'Aquisição de notebooks para renovação do parque tecnológico', 'Aprovada', 1),
(2, 'Compra de licenças de software para novos colaboradores', 'Aprovada', 2),
(3, 'Aquisição de equipamentos para reposição de estoque', 'Em análise', 4);

-- 3.14 Aprovacao_compra (3 registros)
INSERT INTO Aprovacao_compra
(id_aprovacao, status, observacao, id_solicitacao_compra)
VALUES
(1, 'Aprovada', 'Compra autorizada pela gestão', 1),
(2, 'Aprovada', 'Licenças necessárias para as atividades da empresa', 2),
(3, 'Pendente', 'Aguardando avaliação do orçamento', 3);

-- 3.15 Cotacao (4 registros)
INSERT INTO Cotacao
(id_cotacao, data_cotacao, valor, condicoes, status, id_solicitacao_compra, id_fornecedor)
VALUES
(1, '2025-02-01', 6000.00, 'Pagamento em 30 dias e entrega em 10 dias', 'Aprovada', 1, 1),
(2, '2025-02-02', 6500.00, 'Pagamento em 30 dias e entrega em 15 dias', 'Não selecionada', 1, 3),
(3, '2025-02-10', 2400.00, 'Licenciamento anual corporativo', 'Aprovada', 2, 2),
(4, '2025-02-15', 3500.00, 'Pagamento mediante aprovação da gestão', 'Pendente', 3, 1);

-- 3.16 Compra (3 registros)
INSERT INTO Compra
(id_compra, numero_nota_fiscal, data_compra, valor_total, status, id_cotacao)
VALUES
(1, 'NF-2025-001', '2025-02-10', 6000.00, 'Concluída', 1),
(2, 'NF-2025-002', '2025-02-20', 2400.00, 'Concluída', 3),
(3, 'NF-2025-003', '2025-03-01', 3500.00, 'Pendente', 4);

-- 3.17 Item_compra (4 registros)
INSERT INTO Item_compra
(id_item_compra, descricao, quantidade, valor_unitario, id_compra)
VALUES
(1, 'Notebook corporativo', 2, 2500.00, 1),
(2, 'Monitor para estação de trabalho', 1, 1000.00, 1),
(3, 'Licença de software corporativo', 10, 240.00, 2),
(4, 'Equipamento de informática para estoque', 1, 3500.00, 3);

-- 3.18 Acionamento_garantia (2 registros)
INSERT INTO Acionamento_garantia
(id_acionamento_garantia, data_acionamento, protocolo, status, resultado, id_equipamento, id_fornecedor)
VALUES
(1, '2025-04-10', 'GAR-2025-001', 'Concluído', 'Equipamento reparado e devolvido em funcionamento', 1, 1),
(2, '2025-05-15', 'GAR-2025-002', 'Em andamento', 'Aguardando análise técnica do fornecedor', 2, 3);

-- 3.19 Chamado (4 registros)
INSERT INTO Chamado
(id_chamado, data_abertura, data_fechamento, categoria, descricao, prioridade, status, id_colaborador, id_atendente)
VALUES
(1, '2025-04-01 08:30:00', '2025-04-01 10:00:00', 'Hardware', 'Notebook apresentando lentidão', 'Média', 'Fechado', 1, 2),
(2, '2025-04-02 09:15:00', NULL, 'Software', 'Solicitação de instalação de software corporativo', 'Baixa', 'Em andamento', 3, 1),
(3, '2025-04-03 11:00:00', '2025-04-03 12:30:00', 'Rede', 'Falha de conexão com a rede interna', 'Alta', 'Fechado', 2, 1),
(4, '2025-04-04 14:20:00', NULL, 'Telefonia', 'Problema de configuração no celular corporativo', 'Média', 'Aberto', 1, 2);

-- 3.20 Servico (4 registros)
INSERT INTO Servico
(id_servico, tipo_servico, data_inicio, data_fim, descricao, status, resultado, id_chamado, id_fornecedor, id_equipamento)
VALUES
(1, 'Manutenção preventiva', '2025-04-01 09:00:00', '2025-04-01 10:00:00', 'Verificação e otimização do notebook', 'Concluído', 'Equipamento funcionando normalmente', 1, 3, 1),
(2, 'Instalação de software', '2025-04-02 10:00:00', NULL, 'Instalação de ferramentas corporativas', 'Em andamento', 'Aguardando conclusão da instalação', 2, 2, 2),
(3, 'Suporte de rede', '2025-04-03 11:15:00', '2025-04-03 12:00:00', 'Análise da conexão de rede', 'Concluído', 'Conexão restabelecida', 3, 3, 1),
(4, 'Configuração de telefonia', '2025-04-04 15:00:00', NULL, 'Análise de configuração do celular corporativo', 'Aberto', 'Aguardando atendimento técnico', 4, 3, 4);


-- 4. CONFERENCIA DAS TABELAS E DA MASSA DE DADOS

SHOW TABLES;

-- Quantidade de registros em cada uma das 20 tabelas.
SELECT 'Departamento' AS tabela, COUNT(*) AS registros FROM Departamento
UNION ALL SELECT 'Fornecedor', COUNT(*) FROM Fornecedor
UNION ALL SELECT 'Software', COUNT(*) FROM Software
UNION ALL SELECT 'Colaborador', COUNT(*) FROM Colaborador
UNION ALL SELECT 'Equipamento', COUNT(*) FROM Equipamento
UNION ALL SELECT 'Alocacao', COUNT(*) FROM Alocacao
UNION ALL SELECT 'Movimentacao_destinacao', COUNT(*) FROM Movimentacao_destinacao
UNION ALL SELECT 'Validacao', COUNT(*) FROM Validacao
UNION ALL SELECT 'Descarte', COUNT(*) FROM Descarte
UNION ALL SELECT 'Licenca_software', COUNT(*) FROM Licenca_software
UNION ALL SELECT 'Licenca_atribuicao', COUNT(*) FROM Licenca_atribuicao
UNION ALL SELECT 'Solicitacao_compra', COUNT(*) FROM Solicitacao_compra
UNION ALL SELECT 'Aprovacao_compra', COUNT(*) FROM Aprovacao_compra
UNION ALL SELECT 'Cotacao', COUNT(*) FROM Cotacao
UNION ALL SELECT 'Compra', COUNT(*) FROM Compra
UNION ALL SELECT 'Item_compra', COUNT(*) FROM Item_compra
UNION ALL SELECT 'Acionamento_garantia', COUNT(*) FROM Acionamento_garantia
UNION ALL SELECT 'Chamado', COUNT(*) FROM Chamado
UNION ALL SELECT 'Servico', COUNT(*) FROM Servico
UNION ALL SELECT 'Celular', COUNT(*) FROM Celular;

-- Total geral esperado: 65 registros.
SELECT
    (SELECT COUNT(*) FROM Departamento) +
    (SELECT COUNT(*) FROM Fornecedor) +
    (SELECT COUNT(*) FROM Software) +
    (SELECT COUNT(*) FROM Colaborador) +
    (SELECT COUNT(*) FROM Equipamento) +
    (SELECT COUNT(*) FROM Alocacao) +
    (SELECT COUNT(*) FROM Movimentacao_destinacao) +
    (SELECT COUNT(*) FROM Validacao) +
    (SELECT COUNT(*) FROM Descarte) +
    (SELECT COUNT(*) FROM Licenca_software) +
    (SELECT COUNT(*) FROM Licenca_atribuicao) +
    (SELECT COUNT(*) FROM Solicitacao_compra) +
    (SELECT COUNT(*) FROM Aprovacao_compra) +
    (SELECT COUNT(*) FROM Cotacao) +
    (SELECT COUNT(*) FROM Compra) +
    (SELECT COUNT(*) FROM Item_compra) +
    (SELECT COUNT(*) FROM Acionamento_garantia) +
    (SELECT COUNT(*) FROM Chamado) +
    (SELECT COUNT(*) FROM Servico) +
    (SELECT COUNT(*) FROM Celular) AS total_geral_registros;

-- 5. CONSULTAS SELECT E JOIN

-- 5.1 Colaboradores e seus departamentos.
SELECT
    c.id_colaborador,
    c.nome,
    c.sobrenome,
    c.email_corporativo,
    d.nome AS departamento
FROM Colaborador c
INNER JOIN Departamento d
    ON c.id_departamento = d.id_departamento
ORDER BY c.id_colaborador;

-- 5.2 Equipamentos alocados aos colaboradores.
SELECT
    a.id_alocacao,
    c.nome AS colaborador,
    c.sobrenome,
    e.modelo,
    e.fabricante,
    e.patrimonio,
    a.data_entrega,
    a.data_devolucao,
    a.situacao AS situacao_alocacao
FROM Alocacao a
INNER JOIN Colaborador c
    ON a.id_colaborador = c.id_colaborador
INNER JOIN Equipamento e
    ON a.id_equipamento = e.id_equipamento
ORDER BY a.id_alocacao;

-- 5.3 Compras, cotacoes, fornecedores e itens adquiridos.
SELECT
    co.id_compra,
    co.numero_nota_fiscal,
    co.data_compra,
    f.nome AS fornecedor,
    co.valor_total,
    co.status AS status_compra,
    i.descricao AS item_comprado,
    i.quantidade,
    i.valor_unitario
FROM Compra co
INNER JOIN Cotacao ct
    ON co.id_cotacao = ct.id_cotacao
INNER JOIN Fornecedor f
    ON ct.id_fornecedor = f.id_fornecedor
LEFT JOIN Item_compra i
    ON co.id_compra = i.id_compra
ORDER BY co.id_compra;

-- 5.4 Chamados, solicitantes e atendentes.
SELECT
    ch.id_chamado,
    ch.data_abertura,
    ch.categoria,
    ch.descricao,
    ch.prioridade,
    ch.status,
    solicitante.nome AS nome_solicitante,
    atendente.nome AS nome_atendente
FROM Chamado ch
INNER JOIN Colaborador solicitante
    ON ch.id_colaborador = solicitante.id_colaborador
LEFT JOIN Colaborador atendente
    ON ch.id_atendente = atendente.id_colaborador
ORDER BY ch.id_chamado;

-- 5.5 Celulares corporativos e seus equipamentos.
SELECT
    c.id_equipamento,
    e.patrimonio,
    c.modelo,
    c.linha_telefonica,
    c.imei_1,
    c.imei_2,
    e.situacao
FROM Celular c
INNER JOIN Equipamento e
    ON c.id_equipamento = e.id_equipamento
ORDER BY c.id_equipamento;

-- 6. DEMONSTRACAO DE UPDATE E DELETE COM TRANSACAO

-- 6.1 UPDATE demonstrativo na observacao do equipamento 1.
START TRANSACTION;
UPDATE Equipamento
SET observacao = 'Atualizacao demonstrativa para apresentacao'
WHERE id_equipamento = 1;
SELECT id_equipamento, modelo, observacao
FROM Equipamento
WHERE id_equipamento = 1;
ROLLBACK;

-- 6.2 DELETE demonstrativo da validacao 3.
START TRANSACTION;
DELETE FROM Validacao
WHERE id_validacao = 3;
SELECT * FROM Validacao;
ROLLBACK;

-- 7. CONSULTAS GERENCIAIS

-- 7.1 Quantidade de equipamentos por situacao.
SELECT
    situacao,
    COUNT(*) AS quantidade_equipamentos
FROM Equipamento
GROUP BY situacao
ORDER BY situacao;

-- 7.2 Quantidade de compras e total comprado por fornecedor.
SELECT
    f.nome AS fornecedor,
    COUNT(co.id_compra) AS quantidade_compras,
    SUM(co.valor_total) AS total_gasto
FROM Compra co
INNER JOIN Cotacao ct
    ON co.id_cotacao = ct.id_cotacao
INNER JOIN Fornecedor f
    ON ct.id_fornecedor = f.id_fornecedor
GROUP BY f.id_fornecedor, f.nome
ORDER BY total_gasto DESC;

-- 7.3 Controle de licencas de software e respectivas validades.
SELECT
    s.nome AS software,
    s.versao,
    l.quantidade,
    l.tipo_licenca,
    l.data_inicio,
    l.data_validade,
    l.status
FROM Licenca_software l
INNER JOIN Software s
    ON l.id_software = s.id_software
ORDER BY l.data_validade;

-- 8. CONSULTAS DE AUDITORIA

-- 8.1 Historico de movimentacao e validacao dos equipamentos.
SELECT
    e.id_equipamento,
    e.modelo,
    e.patrimonio,
    m.data_movimentacao,
    m.tipo_destinacao,
    m.destino,
    v.responsavel,
    v.resultado,
    v.sanitizacao_realizada
FROM Equipamento e
INNER JOIN Movimentacao_destinacao m
    ON e.id_equipamento = m.id_equipamento
LEFT JOIN Validacao v
    ON m.id_equipamento = v.id_equipamento
   AND m.id_movimentacao_destinacao = v.id_movimentacao_destinacao
ORDER BY m.data_movimentacao;

-- 8.2 Historico dos equipamentos descartados e sua destinacao.
SELECT
    d.id_descarte,
    e.modelo,
    e.fabricante,
    e.patrimonio,
    d.data_descarte,
    d.motivo,
    m.tipo_destinacao,
    m.destino
FROM Descarte d
INNER JOIN Equipamento e
    ON d.id_equipamento = e.id_equipamento
LEFT JOIN Movimentacao_destinacao m
    ON d.id_movimentacao_destinacao = m.id_movimentacao_destinacao
ORDER BY d.data_descarte;

-- 8.3 Acionamentos de garantia por equipamento e fornecedor.
SELECT
    ag.id_acionamento_garantia,
    e.modelo,
    e.fabricante,
    e.patrimonio,
    f.nome AS fornecedor,
    ag.data_acionamento,
    ag.protocolo,
    ag.status,
    ag.resultado
FROM Acionamento_garantia ag
INNER JOIN Equipamento e
    ON ag.id_equipamento = e.id_equipamento
INNER JOIN Fornecedor f
    ON ag.id_fornecedor = f.id_fornecedor
ORDER BY ag.data_acionamento;

-- 8.4 Historico de chamados, servicos e fornecedores responsaveis.
SELECT
    ch.id_chamado,
    ch.categoria,
    ch.status AS status_chamado,
    c.nome AS solicitante,
    s.tipo_servico,
    s.data_inicio,
    s.data_fim,
    s.status AS status_servico,
    f.nome AS fornecedor
FROM Chamado ch
INNER JOIN Colaborador c
    ON ch.id_colaborador = c.id_colaborador
LEFT JOIN Servico s
    ON ch.id_chamado = s.id_chamado
LEFT JOIN Fornecedor f
    ON s.id_fornecedor = f.id_fornecedor
ORDER BY ch.id_chamado;

