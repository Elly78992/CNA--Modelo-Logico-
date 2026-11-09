
-- Banco: bd_cna_tecnews_apresentacao
-- Total previsto: 65 registros em 20 tabelas
-- Dados fictícios para fins acadêmicos


USE bd_cna_tecnews_apresentacao;

-- 1. DEPARTAMENTO (3 REGISTROS)

INSERT INTO Departamento (id_departamento, nome) VALUES
(1, 'Tecnologia da Informação'),
(2, 'Recursos Humanos'),
(3, 'Financeiro');

-- 2. FORNECEDOR (3 REGISTROS)

INSERT INTO Fornecedor (id_fornecedor, nome, tipo_fornecedor, telefone, email) VALUES
(1, 'Tech Solutions', 'Equipamentos de informática', '1133334444', 'contato@techsolutions.com.br'),
(2, 'Digital Software', 'Software e licenciamento', '1144445555', 'vendas@digitalsoftware.com.br'),
(3, 'Info Service', 'Manutenção e suporte técnico', '1155556666', 'suporte@infoservice.com.br');


-- 3. SOFTWARE (3 REGISTROS)
INSERT INTO Software (id_software, nome, versao) VALUES
(1, 'Microsoft 365', '2025'),
(2, 'Windows 11 Pro', '23H2'),
(3, 'Antivirus Corporativo', '5.0');


-- 4. COLABORADOR (4 REGISTROS)
INSERT INTO Colaborador
(id_colaborador, nome, sobrenome, email_corporativo, data_admissao, data_desligamento, status, id_departamento)
VALUES
(1, 'Ana', 'Silva', 'ana.silva@tecnews.com.br', '2023-02-10', NULL, 'Ativo', 1),
(2, 'Carlos', 'Souza', 'carlos.souza@tecnews.com.br', '2022-06-15', NULL, 'Ativo', 1),
(3, 'Mariana', 'Oliveira', 'mariana.oliveira@tecnews.com.br', '2024-01-08', NULL, 'Ativo', 2),
(4, 'Pedro', 'Santos', 'pedro.santos@tecnews.com.br', '2021-09-20', NULL, 'Ativo', 3);


-- 5. EQUIPAMENTO (5 REGISTROS)
INSERT INTO Equipamento
(id_equipamento, patrimonio, numero_serie, situacao, data_aquisicao, data_fabricacao, data_inicio_garantia, data_limite_garantia, modelo, fabricante, observacao, processador, memoria_ram, capacidade_disco, hostname, endereco_ip)
VALUES
(1, 'PAT-001', 'SN-NB-001', 'Em uso', '2024-01-15', '2023-12-10', '2024-01-15', '2027-01-15', 'ThinkPad E14', 'Lenovo', 'Notebook utilizado pela equipe de TI', 'Intel Core i5', '16 GB', '512 GB SSD', 'TEC-NB-001', '192.168.1.101'),
(2, 'PAT-002', 'SN-NB-002', 'Em uso', '2024-03-10', '2024-02-01', '2024-03-10', '2027-03-10', 'Latitude 5440', 'Dell', 'Notebook para atividades administrativas', 'Intel Core i7', '16 GB', '512 GB SSD', 'TEC-NB-002', '192.168.1.102'),
(3, 'PAT-003', 'SN-MON-003', 'Descartado', '2020-05-20', '2020-03-15', '2020-05-20', '2021-05-20', 'Monitor LED 21', 'Samsung', 'Monitor antigo sem condições de uso', NULL, NULL, NULL, NULL, NULL),
(4, 'PAT-004', 'SN-CEL-004', 'Em uso', '2025-01-10', '2024-12-01', '2025-01-10', '2027-01-10', 'Galaxy A55', 'Samsung', 'Celular corporativo da equipe de TI', 'Exynos 1480', '8 GB', '256 GB', NULL, NULL),
(5, 'PAT-005', 'SN-CEL-005', 'Em estoque', '2025-02-05', '2025-01-10', '2025-02-05', '2027-02-05', 'Moto G85', 'Motorola', 'Celular disponível para alocação', 'Snapdragon 6s Gen 3', '8 GB', '256 GB', NULL, NULL);


-- 6. CELULAR (2 REGISTROS)
INSERT INTO Celular
(id_equipamento, modelo, linha_telefonica, imei_1, imei_2)
VALUES
(4, 'Galaxy A55', '11999990000', '356789123456789', '356789123456797'),
(5, 'Moto G85', '11987650001', 'IMEI-MASSA-003-A', 'IMEI-MASSA-003-B');


-- 7. ALOCACAO (4 REGISTROS)
INSERT INTO Alocacao
(id_alocacao, data_entrega, data_devolucao, situacao, observacao, condicao_devolucao, id_colaborador, id_equipamento)
VALUES
(1, '2024-02-01', NULL, 'Ativa', 'Notebook entregue para atividades de TI', NULL, 1, 1),
(2, '2024-03-15', NULL, 'Ativa', 'Notebook utilizado no suporte técnico', NULL, 2, 2),
(3, '2025-01-15', NULL, 'Ativa', 'Celular corporativo entregue', NULL, 1, 4),
(4, '2024-05-10', '2024-12-20', 'Encerrada', 'Equipamento devolvido ao setor de TI', 'Bom estado', 3, 5);


-- 8. MOVIMENTACAO_DESTINACAO (3 REGISTROS)
INSERT INTO Movimentacao_destinacao
(id_movimentacao_destinacao, data_movimentacao, tipo_destinacao, descricao, destino, id_equipamento)
VALUES
(1, '2024-02-01', 'Entrega', 'Entrega de notebook ao colaborador', 'Ana Silva', 1),
(2, '2024-03-15', 'Entrega', 'Entrega de notebook para suporte técnico', 'Carlos Souza', 2),
(3, '2025-03-01', 'Descarte', 'Encaminhamento de monitor sem condições de uso', 'Descarte eletrônico especializado', 3);


-- 9. VALIDACAO (3 REGISTROS)
INSERT INTO Validacao
(id_validacao, data_hora_validacao, responsavel, resultado, observacao, tipo_alteracao, sanitizacao_realizada, id_equipamento, id_movimentacao_destinacao)
VALUES
(1, '2025-01-10 09:30:00', 'Ana Silva', 'Aprovado', 'Equipamento conferido e funcionando', 'Conferência de inventário', 0, 1, 1),
(2, '2025-01-12 14:00:00', 'Carlos Souza', 'Aprovado', 'Número de patrimônio e série conferidos', 'Atualização cadastral', 0, 2, 2),
(3, '2025-03-01 16:00:00', 'Ana Silva', 'Aprovado', 'Descarte registrado e validado', 'Descarte', 1, 3, 3);


-- 10. DESCARTE (1 REGISTRO)
INSERT INTO Descarte
(id_descarte, data_descarte, motivo, observacao, id_equipamento, id_movimentacao_destinacao)
VALUES
(1, '2025-03-01', 'Equipamento obsoleto e sem condições de reparo', 'Encaminhado para descarte eletrônico adequado', 3, 3);


-- 11. LICENCA_SOFTWARE (3 REGISTROS)
INSERT INTO Licenca_software
(id_licenca_software, quantidade, data_inicio, tipo_licenca, data_validade, status, id_software)
VALUES
(1, 20, '2025-01-01', 'Corporativa', '2026-12-31', 'Ativa', 1),
(2, 15, '2025-01-01', 'Corporativa', '2026-12-31', 'Ativa', 2),
(3, 10, '2025-02-01', 'Corporativa', '2027-02-01', 'Ativa', 3);


-- 12. LICENCA_ATRIBUICAO (4 REGISTROS)
INSERT INTO Licenca_atribuicao
(id_licenca_atribuicao, data_inicio, data_fim, status, id_colaborador, id_equipamento, id_licenca_software)
VALUES
(1, '2025-01-10', NULL, 'Ativa', 1, 1, 1),
(2, '2025-01-10', NULL, 'Ativa', 2, 2, 1),
(3, '2025-01-15', NULL, 'Ativa', 1, 1, 2),
(4, '2025-02-10', NULL, 'Ativa', 3, 2, 3);


-- 13. SOLICITACAO_COMPRA (3 REGISTROS)
INSERT INTO Solicitacao_compra
(id_solicitacao_compra, motivo, status, id_colaborador)
VALUES
(1, 'Aquisição de notebooks para renovação do parque tecnológico', 'Aprovada', 1),
(2, 'Compra de licenças de software para novos colaboradores', 'Aprovada', 2),
(3, 'Aquisição de equipamentos para reposição de estoque', 'Em análise', 4);

-- =====================================================
-- 14. APROVACAO_COMPRA (3 REGISTROS)
-- =====================================================

INSERT INTO Aprovacao_compra
(id_aprovacao, status, observacao, id_solicitacao_compra)
VALUES
(1, 'Aprovada', 'Compra autorizada pela gestão', 1),
(2, 'Aprovada', 'Licenças necessárias para as atividades da empresa', 2),
(3, 'Pendente', 'Aguardando avaliação do orçamento', 3);


-- 15. COTACAO (4 REGISTROS)
INSERT INTO Cotacao
(id_cotacao, data_cotacao, valor, condicoes, status, id_solicitacao_compra, id_fornecedor)
VALUES
(1, '2025-02-01', 6000.00, 'Pagamento em 30 dias e entrega em 10 dias', 'Aprovada', 1, 1),
(2, '2025-02-02', 6500.00, 'Pagamento em 30 dias e entrega em 15 dias', 'Não selecionada', 1, 3),
(3, '2025-02-10', 2400.00, 'Licenciamento anual corporativo', 'Aprovada', 2, 2),
(4, '2025-02-15', 3500.00, 'Pagamento mediante aprovação da gestão', 'Pendente', 3, 1);


-- 16. COMPRA (3 REGISTROS)
INSERT INTO Compra
(id_compra, numero_nota_fiscal, data_compra, valor_total, status, id_cotacao)
VALUES
(1, 'NF-2025-001', '2025-02-10', 6000.00, 'Concluída', 1),
(2, 'NF-2025-002', '2025-02-20', 2400.00, 'Concluída', 3),
(3, 'NF-2025-003', '2025-03-01', 3500.00, 'Pendente', 4);


-- 17. ITEM_COMPRA (4 REGISTROS)
INSERT INTO Item_compra
(id_item_compra, descricao, quantidade, valor_unitario, id_compra)
VALUES
(1, 'Notebook corporativo', 2, 2500.00, 1),
(2, 'Monitor para estação de trabalho', 1, 1000.00, 1),
(3, 'Licença de software corporativo', 10, 240.00, 2),
(4, 'Equipamento de informática para estoque', 1, 3500.00, 3);


-- 18. ACIONAMENTO_GARANTIA (2 REGISTROS)
INSERT INTO Acionamento_garantia
(id_acionamento_garantia, data_acionamento, protocolo, status, resultado, id_equipamento, id_fornecedor)
VALUES
(1, '2025-04-10', 'GAR-2025-001', 'Concluído', 'Equipamento reparado e devolvido em funcionamento', 1, 1),
(2, '2025-05-15', 'GAR-2025-002', 'Em andamento', 'Aguardando análise técnica do fornecedor', 2, 3);


-- 19. CHAMADO (4 REGISTROS)
INSERT INTO Chamado
(id_chamado, data_abertura, data_fechamento, categoria, descricao, prioridade, status, id_colaborador, id_atendente)
VALUES
(1, '2025-04-01 08:30:00', '2025-04-01 10:00:00', 'Hardware', 'Notebook apresentando lentidão', 'Média', 'Fechado', 1, 2),
(2, '2025-04-02 09:15:00', NULL, 'Software', 'Solicitação de instalação de software corporativo', 'Baixa', 'Em andamento', 3, 1),
(3, '2025-04-03 11:00:00', '2025-04-03 12:30:00', 'Rede', 'Falha de conexão com a rede interna', 'Alta', 'Fechado', 2, 1),
(4, '2025-04-04 14:20:00', NULL, 'Telefonia', 'Problema de configuração no celular corporativo', 'Média', 'Aberto', 1, 2);


-- 20. SERVICO (4 REGISTROS)
INSERT INTO Servico
(id_servico, tipo_servico, data_inicio, data_fim, descricao, status, resultado, id_chamado, id_fornecedor, id_equipamento)
VALUES
(1, 'Manutenção preventiva', '2025-04-01 09:00:00', '2025-04-01 10:00:00', 'Verificação e otimização do notebook', 'Concluído', 'Equipamento funcionando normalmente', 1, 3, 1),
(2, 'Instalação de software', '2025-04-02 10:00:00', NULL, 'Instalação de ferramentas corporativas', 'Em andamento', 'Aguardando conclusão da instalação', 2, 2, 2),
(3, 'Suporte de rede', '2025-04-03 11:15:00', '2025-04-03 12:00:00', 'Análise da conexão de rede', 'Concluído', 'Conexão restabelecida', 3, 3, 1),
(4, 'Configuração de telefonia', '2025-04-04 15:00:00', NULL, 'Análise de configuração do celular corporativo', 'Aberto', 'Aguardando atendimento técnico', 4, 3, 4);