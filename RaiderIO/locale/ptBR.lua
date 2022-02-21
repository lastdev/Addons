local ns = select(2, ...) ---@type ns @The addon namespace.

if ns:IsSameLocale("ptBR") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "ptBR"

L["ALLOW_IN_LFD"] = "Permitir no localizador de masmorras."
L["ALLOW_IN_LFD_DESC"] = "Clique-direito em grupos ou candidatos no localizador de masmorras para copiar o URL do perfil Raider.IO."
L["ALLOW_ON_PLAYER_UNITS"] = "Permitir em retratos de jogador"
L["ALLOW_ON_PLAYER_UNITS_DESC"] = "Clique-direito no retrato do jogador para copiar a URL do perfil Raider.IO."
L["ALWAYS_SHOW_EXTENDED_INFO"] = "Sempre mostrar a Pontuação de Função"
L["ALWAYS_SHOW_EXTENDED_INFO_DESC"] = "Mantenha pressionado um modificador (shift/ctrl/alt) para mostrar as Pontuações de Funções do jogador na dica de ferramenta. Se você habilitar essa opção, as dicas de ferramentas sempre incluirão as pontuações de função."
L["API_DEPRECATED"] = "|cffFF0000Warning!|r O Addon |cffFFFFFF%s|r está chamando uma função descontinuada do RaiderIO.%s. Esta função será removida em versões futuras. Por favor, incentive o autor de %s a atualizar seu complemento. Pilha de chamadas: %s"
L["API_DEPRECATED_UNKNOWN_ADDON"] = "<AddOn Desconhecido>"
L["API_DEPRECATED_UNKNOWN_FILE"] = "<Arquivo de AddOn Desconhecido>"
L["API_DEPRECATED_WITH"] = "|cffFF0000Warning!|r O Addon |cffFFFFFF%s|r está chamando uma função descontinuada do RaiderIO.%s. Esta função será removida em versões futuras. Incentive o autor de %s a atualizar para a nova API do RaiderIO.%s. Pilha de chamadas:%s"
L["API_INVALID_DATABASE"] = "|cffFF0000Warning!|r Detectou um banco de dados Raider.IO inválido em |cffffffff%s|r. Atualize todas as regiões e facções no cliente Raider.IO ou reinstale o complemento manualmente."
L["AUTO_COMBATLOG"] = "Habilita Automaticamente o Log de Combate em Raides e Masmorras"
L["AUTO_COMBATLOG_DESC"] = "Habilitar e desabilitar o Registro de Combate quando entrar ou sair de masmorras e raides suportadas."
L["BEST_FOR_DUNGEON"] = "Melhor por Masmorra."
L["BEST_RUN"] = "Melhor M+"
L["BEST_SCORE"] = "Melhor Pontuação M+ (%s)"
L["CANCEL"] = "Cancela"
L["CHANGES_REQUIRES_UI_RELOAD"] = "Suas mudanças foram salvas, mas você precisa recarregar sua interface para que elas funcionem. Você deseja fazer isso agora?"
L["CHECKBOX_DISPLAY_WEEKLY"] = "Mostrar Semanalmente"
L["CHOOSE_HEADLINE_HEADER"] = "Mítica+ Informação em destaque."
L["CONFIG_SHOW_TOOLTIPS_HEADER"] = "Mítica+ e Raides"
L["CONFIG_WHERE_TO_SHOW_TOOLTIPS"] = "Onde Mostrar o Progresso em Mítica+ e Raide"
L["CONFIRM"] = "Confirmar"
L["COPY_RAIDERIO_PROFILE_URL"] = "Copiar URL do Raider.IO"
L["COPY_RAIDERIO_URL"] = "Copiar URL do Raider.IO"
L["CURRENT_MAINS_SCORE"] = "Pontuação Principal Vigente em M+"
L["CURRENT_SCORE"] = "Pontuação Vigente em M+"
L["DISABLE_DEBUG_MODE_RELOAD"] = "Você está desabilitando o Modo de Depuração. Clicar em Confirmar irá Recarregar sua Interface."
L["DPS"] = "DPS"
L["DPS_SCORE"] = "Pontos DPS"
L["DUNGEON_SHORT_NAME_AD"] = "AD"
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_ARC"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_BRH"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_COEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_COS"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_DHT"] = ""--]] 
L["DUNGEON_SHORT_NAME_DOS"] = "Outro Lado"
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_EOA"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_FH"] = ""--]] 
L["DUNGEON_SHORT_NAME_HOA"] = [=[Salões
]=]
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_HOV"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_KR"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_LOWR"] = ""--]] 
L["DUNGEON_SHORT_NAME_MISTS"] = "Brumas"
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_ML"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_MOS"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_NL"] = ""--]] 
L["DUNGEON_SHORT_NAME_NW"] = "Chaga"
L["DUNGEON_SHORT_NAME_PF"] = "Empéstia"
L["DUNGEON_SHORT_NAME_SD"] = "Profundezas"
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_SEAT"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_SIEGE"] = ""--]] 
L["DUNGEON_SHORT_NAME_SOA"] = "Torres"
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_SOTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_TD"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_TM"] = ""--]] 
L["DUNGEON_SHORT_NAME_TOP"] = "Teatro"
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_TOS"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_UNDR"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_UPPR"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_VOTW"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_WM"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_WORK"] = ""--]] 
--[[Translation missing --]]
--[[ L["DUNGEON_SHORT_NAME_YARD"] = ""--]] 
L["ENABLE_AUTO_FRAME_POSITION"] = "Posicionar o Quadro de Perfil do Raider.IO Automaticamente"
L["ENABLE_AUTO_FRAME_POSITION_DESC"] = "Ativar isso manterá o Quadro de perfil de M+ ao lado do \"Localizador de grupos\" ."
L["ENABLE_DEBUG_MODE_RELOAD"] = "Você está ativando o modo de depuração. Destina-se apenas a fins de teste e desenvolvimento e incorrerá em uso adicional de memória. Clicar em Confirmar recarregará sua interface."
L["ENABLE_LOCK_PROFILE_FRAME"] = "Bloquear quadro de perfil do Raider.IO"
L["ENABLE_LOCK_PROFILE_FRAME_DESC"] = "Impede que o quadro de perfil M+ seja arrastado. Isso não tem efeito se o quadro de perfil M+ estiver definido para ser posicionado automaticamente."
L["ENABLE_NO_SCORE_COLORS"] = "Desativar todas as cores de pontuação de Míticas+"
L["ENABLE_NO_SCORE_COLORS_DESC"] = "Coloração de pontuação desativada. Todas as pontuações serão mostradas em branco."
L["ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS"] = "Permitir aprimoramentos do cliente Raider.IO"
L["ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS_DESC"] = "A ativação dessa opção permitirá que você visualize dados detalhados do perfil Raider.IO baixados do Cliente Raider.IO para os personagens selecionados.."
L["ENABLE_SIMPLE_SCORE_COLORS"] = "Usar cores Simples para Pontuação de míticas+"
L["ENABLE_SIMPLE_SCORE_COLORS_DESC"] = "Mostra pontuações apenas com cores de qualidade de item padrão. Isso pode tornar mais fácil para as pessoas com deficiências de visão colorida, distinguir níveis de pontuação."
L["EXPORTJSON_COPY_TEXT"] = "Copie o seguinte e cole-o em qualquer lugar em |cff00C8FFhttps://raider.io|r para procurar todos os players."
L["GENERAL_TOOLTIP_OPTIONS"] = "Opções gerais da ferramenta."
L["GUILD_BEST_SEASON"] = "Guilda: Melhor Temporada."
L["GUILD_BEST_TITLE"] = "Raider.IO Recordes."
L["GUILD_BEST_WEEKLY"] = "Guilda: Melhor Semanal."
L["HEALER"] = "Curador"
L["HEALER_SCORE"] = "Pontuação de Curador"
L["HIDE_OWN_PROFILE"] = "Ocultar perfil pessoal no Raider.IO"
L["HIDE_OWN_PROFILE_DESC"] = "Quando definido, isso não mostrará seu próprio perfil Raider.IO, mas poderá mostrar outros jogadores, se eles tiverem um."
L["INVERSE_PROFILE_MODIFIER"] = "Inverter o Modificador de Perfil do Raider.IO"
L["INVERSE_PROFILE_MODIFIER_DESC"] = "Ativar isso inverte o comportamento do modificador do Raider.IO (shift/ctrl/alt): mantenha pressionado para alternar a exibição entre o perfil Pessoal/Líder ou perfil Líder/Pessoal."
--[[Translation missing --]]
--[[ L["KEYSTONE_COMPLETED_10"] = ""--]] 
--[[Translation missing --]]
--[[ L["KEYSTONE_COMPLETED_15"] = ""--]] 
--[[Translation missing --]]
--[[ L["KEYSTONE_COMPLETED_5"] = ""--]] 
L["LEGION_MAIN_SCORE"] = "Pontuação Principal no Legion"
L["LEGION_SCORE"] = "Pontuação Legion"
L["LOCKING_PROFILE_FRAME"] = "Raider.IO: Bloqueando o quadro de perfil M+."
L["MAINS_BEST_SCORE_BEST_SEASON"] = "Melhor pontuação M+ do principal (%s)"
L["MAINS_RAID_PROGRESS"] = "Progresso no Principal"
L["MAINS_SCORE"] = "Pontuação M+ do Principal"
L["MAINS_SCORE_COLON"] = "Pontuação do Principal:"
L["MODULE_AMERICAS"] = "Américas"
L["MODULE_EUROPE"] = "Europa"
L["MODULE_KOREA"] = "Coreia"
L["MODULE_TAIWAN"] = "Taiwan"
L["MY_PROFILE_TITLE"] = "Perfil Raider.IO"
L["MYTHIC_PLUS_DB_MODULES"] = "Mítica+ Módulos de Banco de Dados"
L["MYTHIC_PLUS_SCORES"] = "Mítica+ ferramenta de pontuação"
L["NO_GUILD_RECORD"] = "Sem registros da guilda"
L["OPEN_CONFIG"] = "Abrir Configuração"
L["OUT_OF_SYNC_DATABASE_S"] = "|cffFFFFFF%s|r possui dados de facção da Horda/Aliança que não estão sincronizados. Atualize as configurações do cliente Raider.IO para sincronizar as duas facções."
L["OUTDATED_DATABASE"] = "As pontuações têm %d dias"
L["OUTDATED_DATABASE_HOURS"] = "As pontuações têm %d horas"
L["OUTDATED_DATABASE_S"] = "|cffFFFFFF%s|r está usando dados com |cffFF6666%d|r dias. Atualize o Addon para obter pontuações mais precisas do Míticas+ ."
L["OUTDATED_DOWNLOAD_LINK"] = "Download: |cffffbd0a%s|r"
L["OUTDATED_EXPIRED_ALERT"] = "|cffFFFFFF%s|r está usando dados expirados. Atualize agora para ver os dados mais precisos:  |cffFFFFFF%s|r"
L["OUTDATED_EXPIRED_TITLE"] = "Os dados do Raider.IO expiraram"
L["OUTDATED_EXPIRES_IN_DAYS"] = "Dados do Raider.IO expiram em %d dias"
L["OUTDATED_EXPIRES_IN_HOURS"] = "Dados do Raider.IO expiram em %d horas"
L["OUTDATED_EXPIRES_IN_MINUTES"] = "Dados do Raider.IO expiram em %d Minutos"
L["OUTDATED_PROFILE_TOOLTIP_MESSAGE"] = [=[Atualize seu Addon agora para ver os dados mais precisos. Os jogadores trabalham duro para melhorar seu progresso, e exibir dados muito antigos é um desserviço para eles. Você pode usar o Raider.IO Client para manter seus dados sincronizados automaticamente
]=]
L["PLAYER_PROFILE_TITLE"] = "Perfil do jogador M+"
L["PREV_SEASON_SUFFIX"] = "(*)"
L["PREVIOUS_SCORE"] = "Pontuação anterior da M+ (%s)"
L["PROFILE_BEST_RUNS"] = "Melhores Runs por  Masmorra"
L["PROVIDER_NOT_LOADED"] = "|cffFF0000Warning:|r |cffFFFFFF%s|r não pode encontrar dados para sua facção atual. Verifique suas configurações |cffFFFFFF/raiderio|r e ative os dados da ferramenta para |cffFFFFFF%s|r."
--[[Translation missing --]]
--[[ L["RAID_ABBREVIATION_ULD"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_1"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_10"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_11"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_2"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_3"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_4"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_5"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_6"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_7"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_8"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_ABT_9"] = ""--]] 
L["RAID_BOSS_BOD_1"] = "Campeã da Luz"
L["RAID_BOSS_BOD_2"] = "Grong, a Aparição"
L["RAID_BOSS_BOD_3"] = "Mestres Flamejade"
L["RAID_BOSS_BOD_4"] = "Opulência"
L["RAID_BOSS_BOD_5"] = "Conclave dos Escolhidos"
L["RAID_BOSS_BOD_6"] = "Rei Rastakhan"
L["RAID_BOSS_BOD_7"] = "Grão-faz-tudo Mekkatorque"
L["RAID_BOSS_BOD_8"] = "Bloqueio da Muralha de Tempestade"
L["RAID_BOSS_BOD_9"] = "Grã-senhora Jaina Proudmore"
L["RAID_BOSS_CN_1"] = "Guinchasa"
L["RAID_BOSS_CN_10"] = "Sir Denathrius"
L["RAID_BOSS_CN_2"] = "Guarda-caça Altimor"
L["RAID_BOSS_CN_3"] = "Destruidor Faminto"
L["RAID_BOSS_CN_4"] = "Artífice Xy'Mox"
L["RAID_BOSS_CN_5"] = "Salvação do Rei Sol"
L["RAID_BOSS_CN_6"] = "Lady Verva Venumbra"
L["RAID_BOSS_CN_7"] = "O Conselho de Sangue"
L["RAID_BOSS_CN_8"] = "Punholodo"
L["RAID_BOSS_CN_9"] = "Generais da Legião de Pedra"
L["RAID_BOSS_EP_1"] = "Comandante Abissal Sivara"
L["RAID_BOSS_EP_2"] = "Beemote de Aguanegra"
L["RAID_BOSS_EP_3"] = "Luz de Azshara"
L["RAID_BOSS_EP_4"] = "Lady Grimpagris"
L["RAID_BOSS_EP_5"] = "Orgozoa"
L["RAID_BOSS_EP_6"] = "Corte da Rainha"
L["RAID_BOSS_EP_7"] = "Za'qui"
L["RAID_BOSS_EP_8"] = "Rainha Azshara"
L["RAID_BOSS_NYA_1"] = "Wrathion"
L["RAID_BOSS_NYA_10"] = "Ra-den"
L["RAID_BOSS_NYA_11"] = "Carapaça"
L["RAID_BOSS_NYA_12"] = "N'Zoth"
L["RAID_BOSS_NYA_2"] = "Maut"
L["RAID_BOSS_NYA_3"] = "Skitra"
L["RAID_BOSS_NYA_4"] = "Zanesh"
L["RAID_BOSS_NYA_5"] = "A Mente Coletiva"
L["RAID_BOSS_NYA_6"] = "Shad'har"
L["RAID_BOSS_NYA_7"] = "Drest'agath"
L["RAID_BOSS_NYA_8"] = "Il'gynoth"
L["RAID_BOSS_NYA_9"] = "Vexiona"
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_1"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_10"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_2"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_3"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_4"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_5"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_6"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_7"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_8"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAID_BOSS_SOD_9"] = ""--]] 
L["RAID_BOSS_ULD_1"] = "Taloc"
L["RAID_BOSS_ULD_2"] = "M.A.D.R.E"
L["RAID_BOSS_ULD_3"] = "Devoradora Fétida"
L["RAID_BOSS_ULD_4"] = "Zek'voz"
L["RAID_BOSS_ULD_5"] = "Vectis"
L["RAID_BOSS_ULD_6"] = "Zul, Renascido"
L["RAID_BOSS_ULD_7"] = "Mythrax"
L["RAID_BOSS_ULD_8"] = "G'huun"
L["RAID_DIFFICULTY_NAME_HEROIC"] = "Heróica"
L["RAID_DIFFICULTY_NAME_MYTHIC"] = "Mítica"
L["RAID_DIFFICULTY_NAME_NORMAL"] = "Normal"
L["RAID_DIFFICULTY_SUFFIX_HEROIC"] = "H"
L["RAID_DIFFICULTY_SUFFIX_MYTHIC"] = "M"
L["RAID_DIFFICULTY_SUFFIX_NORMAL"] = "N"
L["RAID_ENCOUNTERS_DEFEATED_TITLE"] = "Encontros de Raide Derrotados"
L["RAID_PROGRESS_TITLE"] = "Progresso de Raide"
L["RAIDERIO_AVERAGE_PLAYER_SCORE"] = "Pontuções Médias Cronometradas +%s"
--[[Translation missing --]]
--[[ L["RAIDERIO_BEST_RUN"] = ""--]] 
L["RAIDERIO_CLIENT_CUSTOMIZATION"] = "Personalização do cliente Raider.IO"
--[[Translation missing --]]
--[[ L["RAIDERIO_LIVE_TRACKING"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAIDERIO_MP_BASE_SCORE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAIDERIO_MP_BEST_SCORE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAIDERIO_MP_SCORE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAIDERIO_MP_SCORE_COLON"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAIDERIO_MYTHIC_OPTIONS"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAIDING_DATA_HEADER"] = ""--]] 
--[[Translation missing --]]
--[[ L["RAIDING_DB_MODULES"] = ""--]] 
L["RELOAD_LATER"] = "Recarregarei depois"
L["RELOAD_NOW"] = "Recarregar agora"
--[[Translation missing --]]
--[[ L["SEASON_LABEL_1"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEASON_LABEL_2"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEASON_LABEL_3"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEASON_LABEL_4"] = ""--]] 
L["SHOW_AVERAGE_PLAYER_SCORE_INFO"] = "Mostrar Média de Pontuação das feitas no tempo:"
--[[Translation missing --]]
--[[ L["SHOW_AVERAGE_PLAYER_SCORE_INFO_DESC"] = ""--]] 
L["SHOW_BEST_MAINS_SCORE"] = "Mostrar a Pontuação Mítica+ da Melhor Temporada do Principal"
L["SHOW_BEST_MAINS_SCORE_DESC"] = "Mostra a melhor pontuação Mítica+ da melhor temporada do jogador e seu progresso em raide no quadro de dica. Os jogadores devem estar registrados no Raider.IO e devem declarar um de seus personagens como o principal."
--[[Translation missing --]]
--[[ L["SHOW_BEST_RUN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_BEST_RUN_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_BEST_SEASON"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_BEST_SEASON_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_CLIENT_GUILD_BEST"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_CLIENT_GUILD_BEST_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_CURRENT_SEASON"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_CURRENT_SEASON_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_IN_FRIENDS"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_IN_FRIENDS_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_IN_LFD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_IN_LFD_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_IN_SLASH_WHO_RESULTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_IN_SLASH_WHO_RESULTS_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_IN_WHO_UI"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_IN_WHO_UI_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_KEYSTONE_INFO"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_KEYSTONE_INFO_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_LEADER_PROFILE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_LEADER_PROFILE_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_MAINS_SCORE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_MAINS_SCORE_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_ON_GUILD_ROSTER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_ON_GUILD_ROSTER_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_ON_PLAYER_UNITS"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_ON_PLAYER_UNITS_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_RAID_ENCOUNTERS_IN_PROFILE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_RAID_ENCOUNTERS_IN_PROFILE_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_RAIDERIO_BESTRUN_FIRST"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_RAIDERIO_BESTRUN_FIRST_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_RAIDERIO_PROFILE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_RAIDERIO_PROFILE_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_ROLE_ICONS"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_ROLE_ICONS_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_SCORE_IN_COMBAT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_SCORE_IN_COMBAT_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_SCORE_WITH_MODIFIER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_SCORE_WITH_MODIFIER_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["TANK"] = ""--]] 
--[[Translation missing --]]
--[[ L["TANK_SCORE"] = ""--]] 
--[[Translation missing --]]
--[[ L["TIMED_10_RUNS"] = ""--]] 
--[[Translation missing --]]
--[[ L["TIMED_15_RUNS"] = ""--]] 
--[[Translation missing --]]
--[[ L["TIMED_20_RUNS"] = ""--]] 
--[[Translation missing --]]
--[[ L["TIMED_5_RUNS"] = ""--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_CUSTOMIZATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_PROFILE"] = ""--]] 
--[[Translation missing --]]
--[[ L["TOTAL_MP_SCORE"] = ""--]] 
--[[Translation missing --]]
--[[ L["TOTAL_RUNS"] = ""--]] 
--[[Translation missing --]]
--[[ L["UNKNOWN_SCORE"] = ""--]] 
--[[Translation missing --]]
--[[ L["UNKNOWN_SERVER_FOUND"] = ""--]] 
--[[Translation missing --]]
--[[ L["UNLOCKING_PROFILE_FRAME"] = ""--]] 
L["USE_ENGLISH_ABBREVIATION"] = "Forçar Abreviações em Inglês para Masmorras"
L["USE_ENGLISH_ABBREVIATION_DESC"] = "Quando ativo, substitui as abreviações das masmorras para as de língua inglesa, ao invés de usar as da sua língua atual."
L["USE_RAIDERIO_CLIENT_LIVE_TRACKING_SETTINGS"] = "Permite que o cliente Raider.IO controle o Registro de Combate"
L["USE_RAIDERIO_CLIENT_LIVE_TRACKING_SETTINGS_DESC"] = "Permite que o cliente Raider.IO (quando possível) controle as configurações de seu Registro de Combate automaticamente."
L["WARNING_DEBUG_MODE_ENABLE"] = "|cffFFFFFF%s|r Modo de Depuração está habilitado. Você pode desabilitá-lo ao digitar |cffFFFFFF/raiderio debug|r."
L["WARNING_LOCK_POSITION_FRAME_AUTO"] = "Raider.IO: Você deve primeiro desabilitar o Posicionamento Automático para o Perfil do Raider.IO."


	ns.L = L
end
