-- Portuguese (Brazil) Localization
if not HousingVendorLocales then
    HousingVendorLocales = {}
end

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
L["BUTTON_BACK"] = "Voltar"
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

-- Info Panel Tooltips
L["TOOLTIP_INFO_EXPANSION"] = "A expansão do World of Warcraft de onde vem este item"
L["TOOLTIP_INFO_FACTION"] = "Qual facção pode comprar este item do vendedor"
L["TOOLTIP_INFO_VENDOR"] = "Vendedor NPC que vende este item"
L["TOOLTIP_INFO_VENDOR_WITH_COORDS"] = "Vendedor NPC que vende este item\n\nLocalização: %s\nCoordenadas: %s"
L["TOOLTIP_INFO_ZONE"] = "Zona onde este vendedor está localizado"
L["TOOLTIP_INFO_ZONE_WITH_COORDS"] = "Zona onde este vendedor está localizado\n\nCoordenadas: %s"
L["TOOLTIP_INFO_REPUTATION"] = "Requisito de reputação para comprar este item do vendedor"
L["TOOLTIP_INFO_RENOWN"] = "Nível de renome necessário com uma facção principal para desbloquear este item"
L["TOOLTIP_INFO_PROFESSION"] = "A profissão necessária para criar este item"
L["TOOLTIP_INFO_PROFESSION_SKILL"] = "Nível de habilidade necessário nesta profissão para criar o item"
L["TOOLTIP_INFO_PROFESSION_RECIPE"] = "O nome da receita ou padrão para criar este item"
L["TOOLTIP_INFO_EVENT"] = "Evento especial ou feriado quando este item está disponível"
L["TOOLTIP_INFO_CLASS"] = "Este item só pode ser usado por esta classe"
L["TOOLTIP_INFO_RACE"] = "Este item só pode ser usado por esta raça"

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

-- Expansion Names
L["EXPANSION_CLASSIC"] = "Clássico"
L["EXPANSION_THEBURNINGCRUSADE"] = "The Burning Crusade"
L["EXPANSION_WRATHOFTHELLICHKING"] = "Wrath of the Lich King"
L["EXPANSION_CATACLYSM"] = "Cataclysm"
L["EXPANSION_MISTSOFPANDARIA"] = "Mists of Pandaria"
L["EXPANSION_WARLORDSOF DRAENOR"] = "Warlords of Draenor"
L["EXPANSION_LEGION"] = "Legion"
L["EXPANSION_BATTLEFORAZEROTH"] = "Battle for Azeroth"
L["EXPANSION_SHADOWLANDS"] = "Shadowlands"
L["EXPANSION_DRAGONFLIGHT"] = "Dragonflight"
L["EXPANSION_THEWARWITHIN"] = "The War Within"
L["EXPANSION_MIDNIGHT"] = "Meia-noite"

-- Faction Names
L["FACTION_ALLIANCE"] = "Aliança"
L["FACTION_HORDE"] = "Horda"
L["FACTION_NEUTRAL"] = "Neutro"

-- Source Types
L["SOURCE_VENDOR"] = "Vendedor"
L["SOURCE_ACHIEVEMENT"] = "Conquista"
L["SOURCE_QUEST"] = "Missão"
L["SOURCE_DROP"] = "Saque"
L["SOURCE_PROFESSION"] = "Profissão"
L["SOURCE_REPUTATION"] = "Reputação"

-- Quality Names
L["QUALITY_POOR"] = "Pobre"
L["QUALITY_COMMON"] = "Comum"
L["QUALITY_UNCOMMON"] = "Incomum"
L["QUALITY_RARE"] = "Raro"
L["QUALITY_EPIC"] = "Épico"
L["QUALITY_LEGENDARY"] = "Lendário"

-- Collection Status
L["COLLECTION_COLLECTED"] = "Coletado"
L["COLLECTION_UNCOLLECTED"] = "Não coletado"

-- Requirement Types
L["REQUIREMENT_NONE"] = "Nenhum"
L["REQUIREMENT_ACHIEVEMENT"] = "Conquista"
L["REQUIREMENT_QUEST"] = "Missão"
L["REQUIREMENT_REPUTATION"] = "Reputação"
L["REQUIREMENT_RENOWN"] = "Renome"
L["REQUIREMENT_PROFESSION"] = "Profissão"

-- Common Category/Type Names
L["CATEGORY_FURNITURE"] = "Móveis"
L["CATEGORY_DECORATIONS"] = "Decorações"
L["CATEGORY_LIGHTING"] = "Iluminação"
L["CATEGORY_PLACEABLES"] = "Posicionáveis"
L["CATEGORY_ACCESSORIES"] = "Acessórios"
L["CATEGORY_RUGS"] = "Tapetes"
L["CATEGORY_PLANTS"] = "Plantas"
L["CATEGORY_PAINTINGS"] = "Pinturas"
L["CATEGORY_BANNERS"] = "Bandeiras"
L["CATEGORY_BOOKS"] = "Livros"
L["CATEGORY_FOOD"] = "Comida"
L["CATEGORY_TOYS"] = "Brinquedos"

-- Type Names
L["TYPE_CHAIR"] = "Cadeira"
L["TYPE_TABLE"] = "Mesa"
L["TYPE_BED"] = "Cama"
L["TYPE_LAMP"] = "Lâmpada"
L["TYPE_CANDLE"] = "Vela"
L["TYPE_RUG"] = "Tapete"
L["TYPE_PAINTING"] = "Pintura"
L["TYPE_BANNER"] = "Bandeira"
L["TYPE_PLANT"] = "Planta"
L["TYPE_BOOKSHELF"] = "Estante"
L["TYPE_CHEST"] = "Baú"
L["TYPE_WEAPON_RACK"] = "Suporte de armas"

-- Filter Options
L["FILTER_HIDE_VISITED"] = "Ocultar visitados"
L["FILTER_ALL_QUALITIES"] = "Todas as qualidades"
L["FILTER_ALL_REQUIREMENTS"] = "Todos os requisitos"

-- UI Theme Names
L["THEME_MIDNIGHT"] = "Meia-noite"
L["THEME_ALLIANCE"] = "Aliança"
L["THEME_HORDE"] = "Horda"
L["THEME_SLEEK_BLACK"] = "Preto elegante"
L["SETTINGS_UI_THEME"] = "Tema da interface"

-- Make the locale table globally available
HousingVendorLocales["ptBR"] = L