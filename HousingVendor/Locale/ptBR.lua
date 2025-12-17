-- Localization for HousingVendor addon - Portuguese (Brazil)
local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "Locais das Decorações de Habitação"
L["HOUSING_VENDOR_SUBTITLE"] = "Navegue por todas as decorações de habitação dos vendedores em toda a Azeroth"

-- Filter Labels
L["FILTER_SEARCH"] = "Pesquisar:"
L["FILTER_EXPANSION"] = "Expansão:"
L["FILTER_VENDOR"] = "Vendedor:"
L["FILTER_ZONE"] = "Zona:"
L["FILTER_TYPE"] = "Tipo:"
L["FILTER_CATEGORY"] = "Categoria:"
L["FILTER_FACTION"] = "Facção:"
L["FILTER_SOURCE"] = "Fonte:"
L["FILTER_PROFESSION"] = "Profissão:"
L["FILTER_CLEAR"] = "Limpar Filtros"
L["FILTER_ALL_EXPANSIONS"] = "Todas as Expansões"
L["FILTER_ALL_VENDORS"] = "Todos os Vendedores"
L["FILTER_ALL_ZONES"] = "Todas as Zonas"
L["FILTER_ALL_TYPES"] = "Todos os Tipos"
L["FILTER_ALL_CATEGORIES"] = "Todas as Categorias"
L["FILTER_ALL_SOURCES"] = "Todas as Fontes"
L["FILTER_ALL_FACTIONS"] = "Todas as Facções"

-- Column Headers
L["COLUMN_ITEM"] = "Item"
L["COLUMN_ITEM_NAME"] = "Nome do Item"
L["COLUMN_SOURCE"] = "Fonte"
L["COLUMN_LOCATION"] = "Localização"
L["COLUMN_PRICE"] = "Preço"
L["COLUMN_COST"] = "Custo"
L["COLUMN_VENDOR"] = "Vendedor"
L["COLUMN_TYPE"] = "Tipo"

-- Buttons
L["BUTTON_SETTINGS"] = "Configurações"
L["BUTTON_STATISTICS"] = "Estatísticas"
L["BUTTON_BACK"] = "← Voltar"
L["BUTTON_CLOSE"] = "Fechar"
L["BUTTON_WAYPOINT"] = "Definir Ponto de Referência"
L["BUTTON_SAVE"] = "Salvar"
L["BUTTON_RESET"] = "Redefinir"

-- Settings Panel
L["SETTINGS_TITLE"] = "Configurações do Addon de Habitação"
L["SETTINGS_GENERAL_TAB"] = "Geral"
L["SETTINGS_COMMUNITY_TAB"] = "Comunidade"
L["SETTINGS_MINIMAP_SECTION"] = "Botão do Minimapa"
L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "Mostrar Botão do Minimapa"
L["SETTINGS_UI_SCALE_SECTION"] = "Escala da Interface"
L["SETTINGS_UI_SCALE"] = "Escala da Interface"
L["SETTINGS_FONT_SIZE"] = "Tamanho da Fonte"
L["SETTINGS_RESET"] = "Redefinir"
L["SETTINGS_RESET_DEFAULTS"] = "Redefinir para Padrões"
L["SETTINGS_PROGRESS_TRACKING"] = "Acompanhamento de Progresso"
L["SETTINGS_SHOW_COLLECTED"] = "Mostrar Itens Coletados"
L["SETTINGS_WAYPOINT_NAVIGATION"] = "Navegação por Pontos de Referência"
L["SETTINGS_USE_PORTAL_NAVIGATION"] = "Usar Navegação Inteligente por Portal"

-- Tooltips
L["TOOLTIP_SETTINGS"] = "Configurações"
L["TOOLTIP_SETTINGS_DESC"] = "Configurar opções do addon"
L["TOOLTIP_WAYPOINT"] = "Definir Ponto de Referência"
L["TOOLTIP_WAYPOINT_DESC"] = "Navegar até este vendedor"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "Navegação Inteligente por Portal Ativada"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "Usará automaticamente o portal mais próximo ao atravessar zonas"
L["TOOLTIP_DIRECT_NAVIGATION"] = "Navegação direta ativada"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "Os pontos de referência apontarão diretamente para os locais dos vendedores (não recomendado para viagens entre zonas)"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "Navegação inteligente por portal ativada. Os pontos de referência usarão automaticamente o portal mais próximo ao atravessar zonas."
L["MESSAGE_DIRECT_NAV_ENABLED"] = "Navegação direta ativada. Os pontos de referência apontarão diretamente para os locais dos vendedores (não recomendado para viagens entre zonas)."

-- Community Section
L["COMMUNITY_TITLE"] = "Comunidade e Suporte"
L["COMMUNITY_INFO"] = "Junte-se à nossa comunidade para compartilhar dicas, relatar erros e sugerir novos recursos!"
L["COMMUNITY_DISCORD"] = "Servidor do Discord"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "Relatar Erro"
L["COMMUNITY_SUGGEST_FEATURE"] = "Sugerir Recurso"

-- Preview Panel
L["PREVIEW_TITLE"] = "Pré-visualização do Item"
L["PREVIEW_NO_SELECTION"] = "Selecione um item para ver detalhes"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "%d itens exibidos (%d no total)"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "Addon de habitação não inicializado"
L["ERROR_UI_NOT_AVAILABLE"] = "Interface do HousingVendor não disponível"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "Painel de configuração não disponível"

-- Statistics UI
L["STATS_TITLE"] = "Painel de Estatísticas"
L["STATS_COLLECTION_PROGRESS"] = "Progresso da Coleção"
L["STATS_ITEMS_BY_SOURCE"] = "Itens por Fonte"
L["STATS_ITEMS_BY_FACTION"] = "Itens por Facção"
L["STATS_COLLECTION_BY_EXPANSION"] = "Coleção por Expansão"
L["STATS_COLLECTION_BY_CATEGORY"] = "Coleção por Categoria"
L["STATS_COMPLETE"] = "%d%% Completo - %d / %d itens coletados"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "Guia de Cores:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "Clique em um item com %s para definir um ponto de referência"

-- Main UI
L["MAIN_SUBTITLE"] = "Catálogo de Habitação"

-- Common Strings
L["COMMON_FREE"] = "Grátis"
L["COMMON_UNKNOWN"] = "Desconhecido"
L["COMMON_NA"] = "N/D"
L["COMMON_GOLD"] = "ouro"
L["COMMON_ITEM_ID"] = "ID do Item:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "Navegador de Vendedores de Habitação"
L["MINIMAP_TOOLTIP_DESC"] = "Clique com o botão esquerdo para alternar o navegador de vendedores de habitação"

-- Make the locale table globally available
_G["HousingVendorLocale"] = L