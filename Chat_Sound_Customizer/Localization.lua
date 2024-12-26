local _, L = ...

setmetatable(L, {
	__index = function(t, k) return k end,
	__newindex = function(t, k, v) rawset(t, k, v == true and k or v) end,
	__call = function(self, locale, tab)
		return (self[locale]:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
	end
})

L["CHAT_MSG_OFFICER"] = "Guild Officer"
L["CHAT_MSG_GUILD"] = "Guild"
L["CHAT_MSG_WHISPER"] = "Whisper"
L["CHAT_MSG_BN_WHISPER"] = "BN Whisper"
L["CHAT_MSG_PARTY"] = "Party"
L["CHAT_MSG_PARTY_LEADER"] = "Party Leader"
L["CHAT_MSG_COMMUNITIES_CHANNEL"] = "Communities"
L["CHAT_MSG_RAID"] = "Raid"
L["CHAT_MSG_RAID_LEADER"] = "Raid Leader"
L["CHAT_MSG_INSTANCE_CHAT"] = "Instance"
L["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "Instance Leader"
L["CHAT_MSG_SAY"] = "Say"
L["CHAT_MSG_YELL"] = "Yell"
L["CHAT_MSG_EMOTE"] = "Emote"

L["Config UI"] = true
L["Open config UI"] = true
L["Chat"] = true
L["Chats"] = true
L["Channel"] = true
L["Multi Selection"] = true
L["Select a sound"] = true
L["Ignore List"] = true
L["Add to ignore list"] = true
L["Remove from ignore list"] = true
L["${button} to show the Config UI"] = true
L["Left-click"] = true
L["${button} to unmute CSC"] = true
L["${button} to temporarily mute CSC"] = true
L["Right-click"] = true
L["Temporarily Mute"] = true
L["Temporarily mute the addon, it will go back to normal after reload"] = true
L["Show minimap button"] = true
L["Newcomer"] = true
L["Guide"] = true
L["This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"] = true
L["This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"] = true
L["Zone Channels"] = true
L["General"] = true
L["Trade"] = true
L["Local Defense"] = true
L["Sound for receiving messages"] = true
L["Sound for sending messages"] = true
L["Notification interval (ms)"] = true
L["This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."] = true

if GetLocale() == "enUS" or GetLocale() == "enGB" then
	return
end

if GetLocale() == "ptBR" then
	L["${button} to show the Config UI"] = "${button} para mostrar a interface de configuração"
L["${button} to temporarily mute CSC"] = "${button} para mutar o CSC temporariamente"
L["${button} to unmute CSC"] = "${button} para desmutar o CSC"
L["Add channel"] = "Adicionar canal"
L["Add player"] = "Adicionar jogador"
L["Add to ignore list"] = "Adicionar a lista de ignorados"
L["Channel"] = "Canal"
L["Chat"] = "Chat"
L["CHAT_MSG_BN_WHISPER"] = "Sussurro BN"
L["CHAT_MSG_COMMUNITIES_CHANNEL"] = "Comunidades"
L["CHAT_MSG_EMOTE"] = "Expressão"
L["CHAT_MSG_GUILD"] = "Guilda"
L["CHAT_MSG_INSTANCE_CHAT"] = "Instância"
L["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "Líder da Instância"
L["CHAT_MSG_OFFICER"] = "Oficial da Guilda"
L["CHAT_MSG_PARTY"] = "Grupo"
L["CHAT_MSG_PARTY_LEADER"] = "Líder do Grupo"
L["CHAT_MSG_RAID"] = "Raid"
L["CHAT_MSG_RAID_LEADER"] = "Líder da Raid"
L["CHAT_MSG_SAY"] = "Dizer"
L["CHAT_MSG_WHISPER"] = "Sussurro"
L["CHAT_MSG_YELL"] = "Gritar"
L["Chats"] = "Chats"
L["Config UI"] = "Interface de Configuração"
L["Create group"] = "Criar grupo"
L["Custom Channel"] = "Canal Personalizado"
L["Customized"] = "Personalizado"
L["General"] = "Geral"
L["Group"] = "Grupo"
L["Guide"] = "Guia"
L["Ignore List"] = "Lista de ignorados"
L["Left-click"] = "Clique-esquerdo"
L["Local Defense"] = "Defesa Local"
L["Multi Selection"] = "Seleção Múltipla"
L["Newcomer"] = "Novato"
L["Notification interval (ms)"] = "Intervalo de notificação (ms)"
L["Open config UI"] = "Abrir configuração"
L["Remove channel"] = "Remover canal"
L["Remove from ignore list"] = "Remover da lista de ignorados"
L["Remove group"] = "Remover grupo"
L["Remove player"] = "Remover jogador"
L["Right-click"] = "Clique-direito"
L["Select a sound"] = "Selecione um som"
L["Show minimap button"] = "Exibir botão do minimapa"
L["Sound for receiving messages"] = "Som para mensagens recebidas"
L["Sound for sending messages"] = "Som para mensagens enviadas"
L["Temporarily Mute"] = "Mutar temporariamente"
L["Temporarily mute the addon, it will go back to normal after reload"] = "Muta temporariamente o addon, irá resetar ao recarregar o jogo"
L["This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."] = "O intervalo mínimo em milissegundos para que um som toque novamente. Cada chat é individual."
L["This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"] = "Este som irá tocar quando você é um Guia e um Novato diz algo no chat de novatos"
L["This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"] = "Este som irá tocar quando você é um Novato e um Guia diz algo no chat de novatos"
L["Trade"] = "Comércio"
L["Zone Channels"] = "Canais de Área"

	--[==[@debug@
	L["CHAT_MSG_OFFICER"] = "Oficial da Guilda"
	L["CHAT_MSG_GUILD"] = "Guilda"
	L["CHAT_MSG_WHISPER"] = "Sussurro"
	L["CHAT_MSG_BN_WHISPER"] = "Sussurro BN"
	L["CHAT_MSG_PARTY"] = "Grupo"
	L["CHAT_MSG_PARTY_LEADER"] = "Líder do Grupo"
	L["CHAT_MSG_COMMUNITIES_CHANNEL"] = "Comunidades"
	L["CHAT_MSG_RAID"] = "Raid"
	L["CHAT_MSG_RAID_LEADER"] = "Líder da Raid"
	L["CHAT_MSG_INSTANCE_CHAT"] = "Instância"
	L["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "Líder da Instância"
	L["CHAT_MSG_SAY"] = "Dizer"
	L["CHAT_MSG_YELL"] = "Gritar"
	L["CHAT_MSG_EMOTE"] = "Expressão"

	L["Config UI"] = "Interface de Configuração"
	L["Open config UI"] = "Abrir configuração"
	L["Chat"] = "Chat"
	L["Chats"] = "Chats"
	L["Channel"] = "Canal"
	L["Multi Selection"] = "Seleção Múltipla"
	L["Select a sound"] = "Selecione um som"
	L["Ignore List"] = "Lista de ignorados"
	L["Add to ignore list"] = "Adicionar a lista de ignorados"
	L["Remove from ignore list"] = "Remover da lista de ignorados"
	L["${button} to show the Config UI"] = "${button} para mostrar a interface de configuração"
	L["Left-click"] = "Clique-esquerdo"
	L["${button} to unmute CSC"] = "${button} para desmutar o CSC"
	L["${button} to temporarily mute CSC"] = "${button} para mutar o CSC temporariamente"
	L["Right-click"] = "Clique-direito"
	L["Temporarily Mute"] = "Mutar temporariamente"
	L["Temporarily mute the addon, it will go back to normal after reload"] = "Muta temporariamente o addon, irá resetar ao recarregar o jogo"
	L["Show minimap button"] = "Exibir botão do minimapa"
	L["Newcomer"] = "Novato"
	L["Guide"] = "Guia"
	L["This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"]
	= "Este som irá tocar quando você é um Guia e um Novato diz algo no chat de novatos"
	L["This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"]
	= "Este som irá tocar quando você é um Novato e um Guia diz algo no chat de novatos"
	L["Zone Channels"] = "Canais de Área"
	L["General"] = "Geral"
	L["Trade"] = "Comércio"
	L["Local Defense"] = "Defesa Local"
	L["Sound for receiving messages"] = "Som para mensagens recebidas"
	L["Sound for sending messages"] = "Som para mensagens enviadas"
	L["Notification interval (ms)"] = "Intervalo de notificação (ms)"
	L["This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."]
	= "O intervalo mínimo em milissegundos para que um som toque novamente. Cada chat é individual."

	L["Customized"] = "Personalizado"
	L["Add player"] = "Adicionar jogador"
	L["Remove player"] = "Remover jogador"
	L["Create group"] = "Criar grupo"
	L["Remove group"] = "Remover grupo"
	L["Group"] = "Grupo"

	L["Custom Channel"] = "Canal Personalizado"
	L["Add channel"] = "Adicionar canal"
	L["Remove channel"] = "Remover canal"

	--@end-debug@]==]

	return
end

if GetLocale() == "frFR" then
	--[[Translation missing --]]
L["${button} to show the Config UI"] = "${button} to show the Config UI"
--[[Translation missing --]]
L["${button} to temporarily mute CSC"] = "${button} to temporarily mute CSC"
--[[Translation missing --]]
L["${button} to unmute CSC"] = "${button} to unmute CSC"
--[[Translation missing --]]
L["Add channel"] = "Add channel"
--[[Translation missing --]]
L["Add player"] = ""
--[[Translation missing --]]
L["Add to ignore list"] = "Add to ignore list"
--[[Translation missing --]]
L["Channel"] = "Channel"
--[[Translation missing --]]
L["Chat"] = "Chat"
--[[Translation missing --]]
L["CHAT_MSG_BN_WHISPER"] = "BN Whisper"
--[[Translation missing --]]
L["CHAT_MSG_COMMUNITIES_CHANNEL"] = "Communities"
--[[Translation missing --]]
L["CHAT_MSG_EMOTE"] = "Emote"
--[[Translation missing --]]
L["CHAT_MSG_GUILD"] = "Guild"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT"] = "Instance"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "Instance Leader"
--[[Translation missing --]]
L["CHAT_MSG_OFFICER"] = "Guild Officer"
--[[Translation missing --]]
L["CHAT_MSG_PARTY"] = "Party"
--[[Translation missing --]]
L["CHAT_MSG_PARTY_LEADER"] = "Party Leader"
--[[Translation missing --]]
L["CHAT_MSG_RAID"] = "Raid"
--[[Translation missing --]]
L["CHAT_MSG_RAID_LEADER"] = "Raid Leader"
--[[Translation missing --]]
L["CHAT_MSG_SAY"] = "Say"
--[[Translation missing --]]
L["CHAT_MSG_WHISPER"] = "Whisper"
--[[Translation missing --]]
L["CHAT_MSG_YELL"] = "Yell"
--[[Translation missing --]]
L["Chats"] = "Chats"
--[[Translation missing --]]
L["Config UI"] = "Config UI"
--[[Translation missing --]]
L["Create group"] = ""
--[[Translation missing --]]
L["Custom Channel"] = "Custom Channel"
--[[Translation missing --]]
L["Customized"] = ""
--[[Translation missing --]]
L["General"] = "General"
--[[Translation missing --]]
L["Group"] = ""
--[[Translation missing --]]
L["Guide"] = "Guide"
--[[Translation missing --]]
L["Ignore List"] = "Ignore List"
--[[Translation missing --]]
L["Left-click"] = "Left-click"
--[[Translation missing --]]
L["Local Defense"] = "Local Defense"
--[[Translation missing --]]
L["Multi Selection"] = "Multi Selection"
--[[Translation missing --]]
L["Newcomer"] = "Newcomer"
--[[Translation missing --]]
L["Notification interval (ms)"] = "Notification interval (ms)"
--[[Translation missing --]]
L["Open config UI"] = "Open config UI"
--[[Translation missing --]]
L["Remove channel"] = "Remove channel"
--[[Translation missing --]]
L["Remove from ignore list"] = "Remove from ignore list"
--[[Translation missing --]]
L["Remove group"] = ""
--[[Translation missing --]]
L["Remove player"] = ""
--[[Translation missing --]]
L["Right-click"] = "Right-click"
--[[Translation missing --]]
L["Select a sound"] = "Select a sound"
--[[Translation missing --]]
L["Show minimap button"] = "Show minimap button"
--[[Translation missing --]]
L["Sound for receiving messages"] = "Sound for receiving messages"
--[[Translation missing --]]
L["Sound for sending messages"] = "Sound for sending messages"
--[[Translation missing --]]
L["Temporarily Mute"] = "Temporarily Mute"
--[[Translation missing --]]
L["Temporarily mute the addon, it will go back to normal after reload"] = "Temporarily mute the addon, it will go back to normal after reload"
--[[Translation missing --]]
L["This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."] = "This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."
--[[Translation missing --]]
L["This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"] = "This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"
--[[Translation missing --]]
L["This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"] = "This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"
--[[Translation missing --]]
L["Trade"] = "Trade"
--[[Translation missing --]]
L["Zone Channels"] = "Zone Channels"

	return
end

if GetLocale() == "deDE" then
	--[[Translation missing --]]
L["${button} to show the Config UI"] = "${button} to show the Config UI"
--[[Translation missing --]]
L["${button} to temporarily mute CSC"] = "${button} to temporarily mute CSC"
--[[Translation missing --]]
L["${button} to unmute CSC"] = "${button} to unmute CSC"
--[[Translation missing --]]
L["Add channel"] = "Add channel"
--[[Translation missing --]]
L["Add player"] = ""
--[[Translation missing --]]
L["Add to ignore list"] = "Add to ignore list"
--[[Translation missing --]]
L["Channel"] = "Channel"
--[[Translation missing --]]
L["Chat"] = "Chat"
--[[Translation missing --]]
L["CHAT_MSG_BN_WHISPER"] = "BN Whisper"
--[[Translation missing --]]
L["CHAT_MSG_COMMUNITIES_CHANNEL"] = "Communities"
--[[Translation missing --]]
L["CHAT_MSG_EMOTE"] = "Emote"
--[[Translation missing --]]
L["CHAT_MSG_GUILD"] = "Guild"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT"] = "Instance"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "Instance Leader"
--[[Translation missing --]]
L["CHAT_MSG_OFFICER"] = "Guild Officer"
--[[Translation missing --]]
L["CHAT_MSG_PARTY"] = "Party"
--[[Translation missing --]]
L["CHAT_MSG_PARTY_LEADER"] = "Party Leader"
--[[Translation missing --]]
L["CHAT_MSG_RAID"] = "Raid"
--[[Translation missing --]]
L["CHAT_MSG_RAID_LEADER"] = "Raid Leader"
--[[Translation missing --]]
L["CHAT_MSG_SAY"] = "Say"
--[[Translation missing --]]
L["CHAT_MSG_WHISPER"] = "Whisper"
--[[Translation missing --]]
L["CHAT_MSG_YELL"] = "Yell"
--[[Translation missing --]]
L["Chats"] = "Chats"
--[[Translation missing --]]
L["Config UI"] = "Config UI"
--[[Translation missing --]]
L["Create group"] = ""
--[[Translation missing --]]
L["Custom Channel"] = "Custom Channel"
--[[Translation missing --]]
L["Customized"] = ""
--[[Translation missing --]]
L["General"] = "General"
--[[Translation missing --]]
L["Group"] = ""
--[[Translation missing --]]
L["Guide"] = "Guide"
--[[Translation missing --]]
L["Ignore List"] = "Ignore List"
--[[Translation missing --]]
L["Left-click"] = "Left-click"
--[[Translation missing --]]
L["Local Defense"] = "Local Defense"
--[[Translation missing --]]
L["Multi Selection"] = "Multi Selection"
--[[Translation missing --]]
L["Newcomer"] = "Newcomer"
--[[Translation missing --]]
L["Notification interval (ms)"] = "Notification interval (ms)"
--[[Translation missing --]]
L["Open config UI"] = "Open config UI"
--[[Translation missing --]]
L["Remove channel"] = "Remove channel"
--[[Translation missing --]]
L["Remove from ignore list"] = "Remove from ignore list"
--[[Translation missing --]]
L["Remove group"] = ""
--[[Translation missing --]]
L["Remove player"] = ""
--[[Translation missing --]]
L["Right-click"] = "Right-click"
--[[Translation missing --]]
L["Select a sound"] = "Select a sound"
--[[Translation missing --]]
L["Show minimap button"] = "Show minimap button"
--[[Translation missing --]]
L["Sound for receiving messages"] = "Sound for receiving messages"
--[[Translation missing --]]
L["Sound for sending messages"] = "Sound for sending messages"
--[[Translation missing --]]
L["Temporarily Mute"] = "Temporarily Mute"
--[[Translation missing --]]
L["Temporarily mute the addon, it will go back to normal after reload"] = "Temporarily mute the addon, it will go back to normal after reload"
--[[Translation missing --]]
L["This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."] = "This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."
--[[Translation missing --]]
L["This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"] = "This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"
--[[Translation missing --]]
L["This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"] = "This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"
--[[Translation missing --]]
L["Trade"] = "Trade"
--[[Translation missing --]]
L["Zone Channels"] = "Zone Channels"

	return
end

if GetLocale() == "itIT" then
	--[[Translation missing --]]
L["${button} to show the Config UI"] = "${button} to show the Config UI"
--[[Translation missing --]]
L["${button} to temporarily mute CSC"] = "${button} to temporarily mute CSC"
--[[Translation missing --]]
L["${button} to unmute CSC"] = "${button} to unmute CSC"
--[[Translation missing --]]
L["Add channel"] = "Add channel"
--[[Translation missing --]]
L["Add player"] = ""
--[[Translation missing --]]
L["Add to ignore list"] = "Add to ignore list"
--[[Translation missing --]]
L["Channel"] = "Channel"
--[[Translation missing --]]
L["Chat"] = "Chat"
--[[Translation missing --]]
L["CHAT_MSG_BN_WHISPER"] = "BN Whisper"
--[[Translation missing --]]
L["CHAT_MSG_COMMUNITIES_CHANNEL"] = "Communities"
--[[Translation missing --]]
L["CHAT_MSG_EMOTE"] = "Emote"
--[[Translation missing --]]
L["CHAT_MSG_GUILD"] = "Guild"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT"] = "Instance"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "Instance Leader"
--[[Translation missing --]]
L["CHAT_MSG_OFFICER"] = "Guild Officer"
--[[Translation missing --]]
L["CHAT_MSG_PARTY"] = "Party"
--[[Translation missing --]]
L["CHAT_MSG_PARTY_LEADER"] = "Party Leader"
--[[Translation missing --]]
L["CHAT_MSG_RAID"] = "Raid"
--[[Translation missing --]]
L["CHAT_MSG_RAID_LEADER"] = "Raid Leader"
--[[Translation missing --]]
L["CHAT_MSG_SAY"] = "Say"
--[[Translation missing --]]
L["CHAT_MSG_WHISPER"] = "Whisper"
--[[Translation missing --]]
L["CHAT_MSG_YELL"] = "Yell"
--[[Translation missing --]]
L["Chats"] = "Chats"
--[[Translation missing --]]
L["Config UI"] = "Config UI"
--[[Translation missing --]]
L["Create group"] = ""
--[[Translation missing --]]
L["Custom Channel"] = "Custom Channel"
--[[Translation missing --]]
L["Customized"] = ""
--[[Translation missing --]]
L["General"] = "General"
--[[Translation missing --]]
L["Group"] = ""
--[[Translation missing --]]
L["Guide"] = "Guide"
--[[Translation missing --]]
L["Ignore List"] = "Ignore List"
--[[Translation missing --]]
L["Left-click"] = "Left-click"
--[[Translation missing --]]
L["Local Defense"] = "Local Defense"
--[[Translation missing --]]
L["Multi Selection"] = "Multi Selection"
--[[Translation missing --]]
L["Newcomer"] = "Newcomer"
--[[Translation missing --]]
L["Notification interval (ms)"] = "Notification interval (ms)"
--[[Translation missing --]]
L["Open config UI"] = "Open config UI"
--[[Translation missing --]]
L["Remove channel"] = "Remove channel"
--[[Translation missing --]]
L["Remove from ignore list"] = "Remove from ignore list"
--[[Translation missing --]]
L["Remove group"] = ""
--[[Translation missing --]]
L["Remove player"] = ""
--[[Translation missing --]]
L["Right-click"] = "Right-click"
--[[Translation missing --]]
L["Select a sound"] = "Select a sound"
--[[Translation missing --]]
L["Show minimap button"] = "Show minimap button"
--[[Translation missing --]]
L["Sound for receiving messages"] = "Sound for receiving messages"
--[[Translation missing --]]
L["Sound for sending messages"] = "Sound for sending messages"
--[[Translation missing --]]
L["Temporarily Mute"] = "Temporarily Mute"
--[[Translation missing --]]
L["Temporarily mute the addon, it will go back to normal after reload"] = "Temporarily mute the addon, it will go back to normal after reload"
--[[Translation missing --]]
L["This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."] = "This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."
--[[Translation missing --]]
L["This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"] = "This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"
--[[Translation missing --]]
L["This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"] = "This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"
--[[Translation missing --]]
L["Trade"] = "Trade"
--[[Translation missing --]]
L["Zone Channels"] = "Zone Channels"

	return
end

if GetLocale() == "esES" then
	--[[Translation missing --]]
L["${button} to show the Config UI"] = "${button} to show the Config UI"
--[[Translation missing --]]
L["${button} to temporarily mute CSC"] = "${button} to temporarily mute CSC"
--[[Translation missing --]]
L["${button} to unmute CSC"] = "${button} to unmute CSC"
--[[Translation missing --]]
L["Add channel"] = "Add channel"
--[[Translation missing --]]
L["Add player"] = ""
--[[Translation missing --]]
L["Add to ignore list"] = "Add to ignore list"
--[[Translation missing --]]
L["Channel"] = "Channel"
--[[Translation missing --]]
L["Chat"] = "Chat"
--[[Translation missing --]]
L["CHAT_MSG_BN_WHISPER"] = "BN Whisper"
--[[Translation missing --]]
L["CHAT_MSG_COMMUNITIES_CHANNEL"] = "Communities"
--[[Translation missing --]]
L["CHAT_MSG_EMOTE"] = "Emote"
--[[Translation missing --]]
L["CHAT_MSG_GUILD"] = "Guild"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT"] = "Instance"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "Instance Leader"
--[[Translation missing --]]
L["CHAT_MSG_OFFICER"] = "Guild Officer"
--[[Translation missing --]]
L["CHAT_MSG_PARTY"] = "Party"
--[[Translation missing --]]
L["CHAT_MSG_PARTY_LEADER"] = "Party Leader"
--[[Translation missing --]]
L["CHAT_MSG_RAID"] = "Raid"
--[[Translation missing --]]
L["CHAT_MSG_RAID_LEADER"] = "Raid Leader"
--[[Translation missing --]]
L["CHAT_MSG_SAY"] = "Say"
--[[Translation missing --]]
L["CHAT_MSG_WHISPER"] = "Whisper"
--[[Translation missing --]]
L["CHAT_MSG_YELL"] = "Yell"
--[[Translation missing --]]
L["Chats"] = "Chats"
--[[Translation missing --]]
L["Config UI"] = "Config UI"
--[[Translation missing --]]
L["Create group"] = ""
--[[Translation missing --]]
L["Custom Channel"] = "Custom Channel"
--[[Translation missing --]]
L["Customized"] = ""
--[[Translation missing --]]
L["General"] = "General"
--[[Translation missing --]]
L["Group"] = ""
--[[Translation missing --]]
L["Guide"] = "Guide"
--[[Translation missing --]]
L["Ignore List"] = "Ignore List"
--[[Translation missing --]]
L["Left-click"] = "Left-click"
--[[Translation missing --]]
L["Local Defense"] = "Local Defense"
--[[Translation missing --]]
L["Multi Selection"] = "Multi Selection"
--[[Translation missing --]]
L["Newcomer"] = "Newcomer"
--[[Translation missing --]]
L["Notification interval (ms)"] = "Notification interval (ms)"
--[[Translation missing --]]
L["Open config UI"] = "Open config UI"
--[[Translation missing --]]
L["Remove channel"] = "Remove channel"
--[[Translation missing --]]
L["Remove from ignore list"] = "Remove from ignore list"
--[[Translation missing --]]
L["Remove group"] = ""
--[[Translation missing --]]
L["Remove player"] = ""
--[[Translation missing --]]
L["Right-click"] = "Right-click"
--[[Translation missing --]]
L["Select a sound"] = "Select a sound"
--[[Translation missing --]]
L["Show minimap button"] = "Show minimap button"
--[[Translation missing --]]
L["Sound for receiving messages"] = "Sound for receiving messages"
--[[Translation missing --]]
L["Sound for sending messages"] = "Sound for sending messages"
--[[Translation missing --]]
L["Temporarily Mute"] = "Temporarily Mute"
--[[Translation missing --]]
L["Temporarily mute the addon, it will go back to normal after reload"] = "Temporarily mute the addon, it will go back to normal after reload"
--[[Translation missing --]]
L["This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."] = "This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."
--[[Translation missing --]]
L["This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"] = "This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"
--[[Translation missing --]]
L["This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"] = "This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"
--[[Translation missing --]]
L["Trade"] = "Trade"
--[[Translation missing --]]
L["Zone Channels"] = "Zone Channels"

	return
end

if GetLocale() == "esMX" then
	--[[Translation missing --]]
L["${button} to show the Config UI"] = "${button} to show the Config UI"
--[[Translation missing --]]
L["${button} to temporarily mute CSC"] = "${button} to temporarily mute CSC"
--[[Translation missing --]]
L["${button} to unmute CSC"] = "${button} to unmute CSC"
--[[Translation missing --]]
L["Add channel"] = "Add channel"
--[[Translation missing --]]
L["Add player"] = ""
--[[Translation missing --]]
L["Add to ignore list"] = "Add to ignore list"
--[[Translation missing --]]
L["Channel"] = "Channel"
--[[Translation missing --]]
L["Chat"] = "Chat"
--[[Translation missing --]]
L["CHAT_MSG_BN_WHISPER"] = "BN Whisper"
--[[Translation missing --]]
L["CHAT_MSG_COMMUNITIES_CHANNEL"] = "Communities"
--[[Translation missing --]]
L["CHAT_MSG_EMOTE"] = "Emote"
--[[Translation missing --]]
L["CHAT_MSG_GUILD"] = "Guild"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT"] = "Instance"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "Instance Leader"
--[[Translation missing --]]
L["CHAT_MSG_OFFICER"] = "Guild Officer"
--[[Translation missing --]]
L["CHAT_MSG_PARTY"] = "Party"
--[[Translation missing --]]
L["CHAT_MSG_PARTY_LEADER"] = "Party Leader"
--[[Translation missing --]]
L["CHAT_MSG_RAID"] = "Raid"
--[[Translation missing --]]
L["CHAT_MSG_RAID_LEADER"] = "Raid Leader"
--[[Translation missing --]]
L["CHAT_MSG_SAY"] = "Say"
--[[Translation missing --]]
L["CHAT_MSG_WHISPER"] = "Whisper"
--[[Translation missing --]]
L["CHAT_MSG_YELL"] = "Yell"
--[[Translation missing --]]
L["Chats"] = "Chats"
--[[Translation missing --]]
L["Config UI"] = "Config UI"
--[[Translation missing --]]
L["Create group"] = ""
--[[Translation missing --]]
L["Custom Channel"] = "Custom Channel"
--[[Translation missing --]]
L["Customized"] = ""
--[[Translation missing --]]
L["General"] = "General"
--[[Translation missing --]]
L["Group"] = ""
--[[Translation missing --]]
L["Guide"] = "Guide"
--[[Translation missing --]]
L["Ignore List"] = "Ignore List"
--[[Translation missing --]]
L["Left-click"] = "Left-click"
--[[Translation missing --]]
L["Local Defense"] = "Local Defense"
--[[Translation missing --]]
L["Multi Selection"] = "Multi Selection"
--[[Translation missing --]]
L["Newcomer"] = "Newcomer"
--[[Translation missing --]]
L["Notification interval (ms)"] = "Notification interval (ms)"
--[[Translation missing --]]
L["Open config UI"] = "Open config UI"
--[[Translation missing --]]
L["Remove channel"] = "Remove channel"
--[[Translation missing --]]
L["Remove from ignore list"] = "Remove from ignore list"
--[[Translation missing --]]
L["Remove group"] = ""
--[[Translation missing --]]
L["Remove player"] = ""
--[[Translation missing --]]
L["Right-click"] = "Right-click"
--[[Translation missing --]]
L["Select a sound"] = "Select a sound"
--[[Translation missing --]]
L["Show minimap button"] = "Show minimap button"
--[[Translation missing --]]
L["Sound for receiving messages"] = "Sound for receiving messages"
--[[Translation missing --]]
L["Sound for sending messages"] = "Sound for sending messages"
--[[Translation missing --]]
L["Temporarily Mute"] = "Temporarily Mute"
--[[Translation missing --]]
L["Temporarily mute the addon, it will go back to normal after reload"] = "Temporarily mute the addon, it will go back to normal after reload"
--[[Translation missing --]]
L["This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."] = "This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."
--[[Translation missing --]]
L["This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"] = "This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"
--[[Translation missing --]]
L["This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"] = "This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"
--[[Translation missing --]]
L["Trade"] = "Trade"
--[[Translation missing --]]
L["Zone Channels"] = "Zone Channels"

	return
end

if GetLocale() == "ruRU" then
	--[[Translation missing --]]
L["${button} to show the Config UI"] = "${button} to show the Config UI"
--[[Translation missing --]]
L["${button} to temporarily mute CSC"] = "${button} to temporarily mute CSC"
--[[Translation missing --]]
L["${button} to unmute CSC"] = "${button} to unmute CSC"
--[[Translation missing --]]
L["Add channel"] = "Add channel"
--[[Translation missing --]]
L["Add player"] = ""
--[[Translation missing --]]
L["Add to ignore list"] = "Add to ignore list"
--[[Translation missing --]]
L["Channel"] = "Channel"
--[[Translation missing --]]
L["Chat"] = "Chat"
--[[Translation missing --]]
L["CHAT_MSG_BN_WHISPER"] = "BN Whisper"
--[[Translation missing --]]
L["CHAT_MSG_COMMUNITIES_CHANNEL"] = "Communities"
--[[Translation missing --]]
L["CHAT_MSG_EMOTE"] = "Emote"
--[[Translation missing --]]
L["CHAT_MSG_GUILD"] = "Guild"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT"] = "Instance"
--[[Translation missing --]]
L["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "Instance Leader"
--[[Translation missing --]]
L["CHAT_MSG_OFFICER"] = "Guild Officer"
--[[Translation missing --]]
L["CHAT_MSG_PARTY"] = "Party"
--[[Translation missing --]]
L["CHAT_MSG_PARTY_LEADER"] = "Party Leader"
--[[Translation missing --]]
L["CHAT_MSG_RAID"] = "Raid"
--[[Translation missing --]]
L["CHAT_MSG_RAID_LEADER"] = "Raid Leader"
--[[Translation missing --]]
L["CHAT_MSG_SAY"] = "Say"
--[[Translation missing --]]
L["CHAT_MSG_WHISPER"] = "Whisper"
--[[Translation missing --]]
L["CHAT_MSG_YELL"] = "Yell"
--[[Translation missing --]]
L["Chats"] = "Chats"
--[[Translation missing --]]
L["Config UI"] = "Config UI"
--[[Translation missing --]]
L["Create group"] = ""
--[[Translation missing --]]
L["Custom Channel"] = "Custom Channel"
--[[Translation missing --]]
L["Customized"] = ""
--[[Translation missing --]]
L["General"] = "General"
--[[Translation missing --]]
L["Group"] = ""
--[[Translation missing --]]
L["Guide"] = "Guide"
--[[Translation missing --]]
L["Ignore List"] = "Ignore List"
--[[Translation missing --]]
L["Left-click"] = "Left-click"
--[[Translation missing --]]
L["Local Defense"] = "Local Defense"
--[[Translation missing --]]
L["Multi Selection"] = "Multi Selection"
--[[Translation missing --]]
L["Newcomer"] = "Newcomer"
--[[Translation missing --]]
L["Notification interval (ms)"] = "Notification interval (ms)"
--[[Translation missing --]]
L["Open config UI"] = "Open config UI"
--[[Translation missing --]]
L["Remove channel"] = "Remove channel"
--[[Translation missing --]]
L["Remove from ignore list"] = "Remove from ignore list"
--[[Translation missing --]]
L["Remove group"] = ""
--[[Translation missing --]]
L["Remove player"] = ""
--[[Translation missing --]]
L["Right-click"] = "Right-click"
--[[Translation missing --]]
L["Select a sound"] = "Select a sound"
--[[Translation missing --]]
L["Show minimap button"] = "Show minimap button"
--[[Translation missing --]]
L["Sound for receiving messages"] = "Sound for receiving messages"
--[[Translation missing --]]
L["Sound for sending messages"] = "Sound for sending messages"
--[[Translation missing --]]
L["Temporarily Mute"] = "Temporarily Mute"
--[[Translation missing --]]
L["Temporarily mute the addon, it will go back to normal after reload"] = "Temporarily mute the addon, it will go back to normal after reload"
--[[Translation missing --]]
L["This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."] = "This is the minimum interval in milliseconds for a sound to be played again. Each chat is individual."
--[[Translation missing --]]
L["This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"] = "This sound will play when you are a GUIDE and a NEWCOMER says something in the Newcomer Chat"
--[[Translation missing --]]
L["This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"] = "This sound will play when you are a NEWCOMER and a GUIDE says something in the Newcomer Chat"
--[[Translation missing --]]
L["Trade"] = "Trade"
--[[Translation missing --]]
L["Zone Channels"] = "Zone Channels"

	return
end






