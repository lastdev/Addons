local L = LibStub("AceLocale-3.0"):NewLocale("WorldQuestGroupFinder", "ptBR") 
if not L then return end 
L = L or {}
L["WQGF_ADDON_DESCRIPTION"] = "Torna fácil achar grupos para Missões Mundiais usando a ferramenta de Busca de Grupo."
L["WQGF_ALREADY_IS_GROUP_FOR_WQ"] = "Você ja esta em um grupo para esta Missão."
L["WQGF_ALREADY_QUEUED_BG"] = "Você esta em fila para Campos de batalha. Por favor saia e tente novamente"
L["WQGF_ALREADY_QUEUED_DF"] = "Você esta em fila para Masmorras. Por favor saia e tente novamente"
L["WQGF_ALREADY_QUEUED_RF"] = "Você esta em fila para Raides. Por favor saia e tente novamente"
L["WQGF_APPLIED_TO_GROUPS"] = "Você foi convidado para o grupo |c00bfffff%d|c00ffffff para a Missão Mundial |c00bfffff%s|c00ffffff."
L["WQGF_APPLIED_TO_GROUPS_QUEST"] = "Você foi convidado para o grupo |c00bfffff%d|c00ffffff para a missão |c00bfffff%s|c00ffffff ."
L["WQGF_AUTO_LEAVING_DIALOG"] = [=[Você completou a Missão Mundial e ira sair do grupo em %d segundos.

 Diga tchau!]=]
L["WQGF_AUTO_LEAVING_DIALOG_QUEST"] = [=[Você completou a missão e ira sair do grupo em %d segundos.

 Diga tchau!!]=]
L["WQGF_CANCEL"] = "Cancelar"
L["WQGF_CANNOT_DO_WQ_IN_GROUP"] = "Essa Missão Mundial não pode ser feita em grupo."
L["WQGF_CANNOT_DO_WQ_TYPE_IN_GROUP"] = "Esse tipo de Missão Mundial não pode ser completada em grupo."
L["WQGF_CONFIG_AUTO_ACCEPT_INVITES_ENABLE"] = "Aceita automaticamente convite de grupo para grupos do WQGF quando não esta em combate"
L["WQGF_CONFIG_AUTO_ACCEPT_INVITES_HOVER"] = "Ira aceitar automaticamente convites de grupo quando não estiver em combate"
L["WQGF_CONFIG_AUTO_ACCEPT_INVITES_TITLE"] = "Aceitar automaticamente convites de grupo"
L["WQGF_CONFIG_AUTOINVITE"] = "Convite automatico"
L["WQGF_CONFIG_AUTOINVITE_EVERYONE"] = "Convide automaticamente todo mundo"
L["WQGF_CONFIG_AUTOINVITE_EVERYONE_HOVER"] = "Toda candidato sera convidado para o grupo até o limite de 5 jogadores "
L["WQGF_CONFIG_AUTOINVITE_WQGF_USERS"] = "Convite automatico de usuarios do WQGF"
L["WQGF_CONFIG_AUTOINVITE_WQGF_USERS_HOVER"] = "Usuarios WQGF irão ser convidados automaticamente para o grupo"
L["WQGF_CONFIG_LANGUAGE_FILTER_ENABLE"] = "Procurar por grupos de qualquer linguagem (ignora a seleção de linguagem da Busca de Grupo)"
L["WQGF_CONFIG_LANGUAGE_FILTER_HOVER"] = "Ira sempre procurar todos os grupos existentes independente da linguagem"
L["WQGF_CONFIG_LANGUAGE_FILTER_TITLE"] = "Filtro de linguagem da Busca de Grupo"
L["WQGF_CONFIG_LOGIN_MESSAGE_TITLE"] = "Mensagem de login do WQGF"
L["WQGF_CONFIG_LOGIN_MESSAGE_TITLE_ENABLE"] = "Esconda a mensagem inicial do WQGF ao logar"
L["WQGF_CONFIG_LOGIN_MESSAGE_TITLE_HOVER"] = "Não mostre mais a mensagem de login do WQGF"
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_AUTO_ENABLE"] = "Automaticamente começar a buscar se não estiver em grupo"
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_AUTO_HOVER"] = "Um grupo ira automaticamente ser buscado quando entrar em uma nova zona de Missão Mundial"
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_ENABLE"] = "Ativar detecção de nova zona de Missão Mundial"
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_HOVER"] = "Sera perguntado se quer porcurar um grupo quando entrar emuma nova zona de Missão Mundial"
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_SWITCH_ENABLE"] = "Não proponha se ja estiver em grupo para outra Missão Mundial"
L["WQGF_CONFIG_NEW_WQ_AREA_DETECTION_TITLE"] = "Proponha procurar por um grupo quando entrar em uma area de Missão Mundial pela primeira vez"
L["WQGF_CONFIG_PAGE_CREDITS"] = "Trazido para você por Robou, EU-Hyjal"
L["WQGF_CONFIG_PARTY_NOTIFICATION_ENABLE"] = "Ativar notificação de grupo"
L["WQGF_CONFIG_PARTY_NOTIFICATION_HOVER"] = "Uma mensagem sera enviada para o grupo quando a Missão Mundial for completada"
L["WQGF_CONFIG_PARTY_NOTIFICATION_TITLE"] = "Notifique o grupo quando a Missão Mundial for completada"
L["WQGF_CONFIG_PVP_REALMS_ENABLE"] = "Evite juntar-se a grupos em Reinos PvP"
L["WQGF_CONFIG_PVP_REALMS_HOVER"] = "Ira evitar juntar-se a grupos em Reinos PvP (esse parâmetro é ignorado para personagens em Reinos PvP)"
L["WQGF_CONFIG_PVP_REALMS_TITLE"] = "Reinos PvP"
L["WQGF_CONFIG_QUEST_SUPPORT_ENABLE"] = "Habilitar suporte para missões normais"
L["WQGF_CONFIG_QUEST_SUPPORT_HOVER"] = "Habilitando isso, ira mostrar um botão para achar grupos para as missões normais suportadas."
L["WQGF_CONFIG_QUEST_SUPPORT_TITLE"] = "Suporte a missões normais"
L["WQGF_CONFIG_SILENT_MODE_ENABLE"] = "Habilitar modo silencioso"
L["WQGF_CONFIG_SILENT_MODE_HOVER"] = "Quando o modo silencioso esta habilitado, somente as mensagens mais importantes do WQGF aparecerão"
L["WQGF_CONFIG_SILENT_MODE_TITLE"] = "Modo silencioso"
L["WQGF_CONFIG_WQ_END_DIALOG_AUTO_LEAVE_ENABLE"] = "Sair automaticamente do grupo após 10 segundos"
L["WQGF_CONFIG_WQ_END_DIALOG_AUTO_LEAVE_HOVER"] = "Ira sair do grupo 10 segundos após a Missão Mundial ser completada"
L["WQGF_CONFIG_WQ_END_DIALOG_ENABLE"] = "Ativar dialogo final para Missão Mundial"
L["WQGF_CONFIG_WQ_END_DIALOG_HOVER"] = "Ira ser proposto a você para sair do grupo ou retira-lo da lista quando a Missão Mundial for completada "
L["WQGF_CONFIG_WQ_END_DIALOG_TITLE"] = "Mostra um dialogo para sair do grupo quando a Missão Mundial for completada"
L["WQGF_DEBUG_CONFIGURATION_DUMP"] = "Configuração de personagem:"
L["WQGF_DEBUG_CURRENT_WQ_ID"] = "ID da Missão Mundial atual é |c00bfffff%s"
L["WQGF_DEBUG_MODE_DISABLED"] = "Modo Debug esta desligado."
L["WQGF_DEBUG_MODE_ENABLED"] = "Modo Debug esta ligado."
L["WQGF_DEBUG_NO_CURRENT_WQ_ID"] = "Sem Missão Mundial autal."
L["WQGF_DEBUG_WQ_ZONES_ENTERED"] = "Zonas de Missão Mundial entradas nessa seção:"
L["WQGF_DELIST"] = "Retirar"
L["WQGF_FIND_GROUP_TOOLTIP"] = "Procurar grupo com WQGF"
L["WQGF_FIND_GROUP_TOOLTIP_2"] = "Clique com botão direito para navegar pelos grupos."
L["WQGF_GLOBAL_CONFIGURATION"] = "Configuração global:"
L["WQGF_GROUP_CREATION_ERROR"] = "Um erro ocorreu enquanto tentava criar uma nova entrada de Grupo. Por favor tente de novo"
L["WQGF_GROUP_NO_LONGER_DOING_QUEST"] = "O seu grupo não esta mais fazendo a missão |c00bfffff%s|c00ffffff."
L["WQGF_GROUP_NO_LONGER_DOING_WQ"] = "O seu grupo não esta mais fazendo a Missão Mundial |c00bfffff%s|c00ffffff."
L["WQGF_GROUP_NOW_DOING_QUEST"] = "O seu grupo esta fazendo agora a missão |c00bfffff%s|c00ffffff."
L["WQGF_GROUP_NOW_DOING_QUEST_ALREADY_COMPLETE"] = "O seu grupo esta fazendo agora a missão |c00bfffff%s|c00ffffff. Você ja completou esta Missão."
L["WQGF_GROUP_NOW_DOING_QUEST_NOT_ELIGIBLE"] = "O seu grupo esta fazendo agora a missão |c00bfffff%s|c00ffffff. Você não é elegível para esta Missão."
L["WQGF_GROUP_NOW_DOING_WQ"] = "O seu grupo esta fazendo agora a Missão Mundial |c00bfffff%s|c00ffffff."
L["WQGF_GROUP_NOW_DOING_WQ_ALREADY_COMPLETE"] = "O seu grupo esta fazendo agora a Missão Mundial |c00bfffff%s|c00ffffff. Você ja completou esta Missão."
L["WQGF_GROUP_NOW_DOING_WQ_NOT_ELIGIBLE"] = "O seu grupo esta fazendo agora a Missão Mundial |c00bfffff%s|c00ffffff. Você não é elegível para esta Missão."
L["WQGF_INIT_MSG"] = "Clique com o botão do meio do mouse na Missão Mundial na janela de rastreamento de objetivo para procurar um grupo."
L["WQGF_JOINED_WQ_GROUP"] = "Você entrou no grupo |c00bfffff%s|c00ffffff's para |c00bfffff%s|c00ffffff. Se divirta !"
L["WQGF_LEADERS_BL_CLEARED"] = "A lista negra de lideres foi limpa."
L["WQGF_LEAVE"] = "Sair"
L["WQGF_NEW_ENTRY_CREATED"] = "Um novo grupo foi criada para |c00bfffff%s|c00ffffff."
L["WQGF_NO"] = "Não"
L["WQGF_NO_APPLICATIONS_ANSWERED"] = "Nenhum de seus convites para |c00bfffff%s|c00ffffff respondeu a tempo. Tentando achar um novo grupo..."
L["WQGF_NO_APPLY_BLACKLIST"] = "Você não foi convidade para o grupo %d pois o lider esta na Lista Negra  |c00bfffff/wqgf unbl |c00ffffffpara limpar a Lista."
L["WQGF_PLAYER_IS_NOT_LEADER"] = "Você não é o lider do grupo."
L["WQGF_QUEST_COMPLETE_LEAVE_DIALOG"] = [=[Você completou a missão.

Gostaria de sair do grupo?]=]
L["WQGF_QUEST_COMPLETE_LEAVE_OR_DELIST_DIALOG"] = [=[Você completou a missão.

Gostaria de sair do grupo ou retira-lo da Busca ?]=]
L["WQGF_RAID_MODE_WARNING"] = "|c0000ffffATTENTION:|c00ffffff Esta grupo esta convertido para Raide, isso significa que você não pode completar a Missão Mundial. Você pode pedir para o lider converter novamente para grupo se possivel. Esse grupo sera convertido automaticamente se você se tornar o Lider."
L["WQGF_REFRESH_TOOLTIP"] = "Procurar outro grupo"
L["WQGF_SEARCH_OR_CREATE_GROUP"] = "Procurar ou Criar Grupo"
L["WQGF_SEARCHING_FOR_GROUP"] = "Procurando um grupo para a Missão Mundial |c00bfffff%s|c00ffffff..."
L["WQGF_SEARCHING_FOR_GROUP_QUEST"] = "Procurando um grupo para a missão |c00bfffff%s|c00ffffff..."
L["WQGF_SLASH_COMMANDS_1"] = "|c00bfffffComandos de barra (/wqgf):"
L["WQGF_SLASH_COMMANDS_2"] = "|c00bfffff /wqgf config : Abre a configuração do ADDON"
L["WQGF_SLASH_COMMANDS_3"] = "|c00bfffff /wqgf unbl : Limpa a lista negra de lideres"
L["WQGF_SLASH_COMMANDS_4"] = "|c00bfffff /wqgf unbl : Alterna nova detecção de zona de Missão Mundial"
L["WQGF_START_ANOTHER_QUEST_DIALOG"] = [=[Você esta no momento em grupo para outra missão.

Você tem certeza que gostaria de começar outra?]=]
L["WQGF_START_ANOTHER_WQ_DIALOG"] = [=[Você esta no momento em grupo para outra Missão Mundial.

Você tem certeza que gostaria de começar outra?]=]
L["WQGF_STAY"] = "Ficar"
L["WQGF_STOP_TOOLTIP"] = "Pare de fazer a Missão Mundial"
L["WQGF_TRANSLATION_INFO"] = "Versão em portugues por Lobeom"
L["WQGF_USER_JOINED"] = "Um usuário do World Guest Group Finder enrou no grupo!"
L["WQGF_USERS_JOINED"] = "Usuarios do World Quest Group Finder entraram no grupo!"
L["WQGF_WQ_AREA_ENTERED_ALREADY_GROUPED_DIALOG"] = [=[Você entrou na area de uma nova Missão Mundial, mas ja esta em grupo para outra Missão.

Gostaria de sai do grupo atual e procurar um novo para "%s" ?]=]
L["WQGF_WQ_AREA_ENTERED_DIALOG"] = [=[Você entrou na area de uma nova Missão Mundial.

Gostaria de procurar um novo grupo para "%s" ?]=]
L["WQGF_WQ_COMPLETE_LEAVE_DIALOG"] = [=[Você completou esta Missão Mundial.

Você gostaria de sair do grupo ?]=]
L["WQGF_WQ_COMPLETE_LEAVE_OR_DELIST_DIALOG"] = [=[Você completou essa Missão Mundial.

Gostaria de sair do grupo ou retira-lo da Busca ?]=]
L["WQGF_WQ_GROUP_APPLY_CANCELLED"] = "Você cancelou seu convite para o grupo |c00bfffff%s|c00ffffff' para |c00bfffff%s|c00ffffff. WQGF não ira tentar se juntar a este grupo novamente a´te você relogar ou limpar a Lista Negra."
L["WQGF_WQ_GROUP_DESCRIPTION"] = "Criado automaticamente por World Quest Group Finder %s."
L["WQGF_WRONG_LOCATION_FOR_WQ"] = "Você não esta no loca certo para esta Missão Mundial."
L["WQGF_YES"] = "Sim"
L["WQGF_ZONE_DETECTION_DISABLED"] = "Nova detecção de zona de Missão Mundial agora está desativada."
L["WQGF_ZONE_DETECTION_ENABLED"] = "Nova detecção de zona de Missão Mundial agora está habilitada."
