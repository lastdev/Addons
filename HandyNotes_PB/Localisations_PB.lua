local _, ns = ...

-- Translations specific to the Pilgrim's Bounty AddOn
if ns.locale == "deDE" then
	ns.L["AddOn Description"] = "%chHilfe für Erfolge und Quests in %crPilgerfreudenfest"
	ns.L["Pilgrim's Bounty"] = "Pilgerfreudenfest"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	ns.L["AddOn Description"] = "%chAyuda para logros y misiones en %crGenerosidad del Peregrino"
	ns.L["Pilgrim's Bounty"] = "Generosidad del Peregrino"

elseif ns.locale == "frFR" then
	ns.L["AddOn Description"] = "%chAide pour les réalisations et les quêtes dans %crLes Bienfaits du pèlerin"
	ns.L["Pilgrim's Bounty"] = "Les Bienfaits du pèlerin"

elseif ns.locale == "itIT" then
	ns.L["AddOn Description"] = "%chAiuto per obiettivi e missioni in %crRingraziamento del Pellegrino"
	ns.L["Pilgrim's Bounty"] = "Ringraziamento del Pellegrino"

elseif ns.locale == "koKR" then
	ns.L["AddOn Description"] = "%cr순례자의 감사절%ch의 업적 및 퀘스트에 대한 도움말"	
	ns.L["Pilgrim's Bounty"] = "순례자의 감사절"
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	ns.L["AddOn Description"] = "%chAjuda para conquistas e missões em %crFesta da Fartura"
	ns.L["Pilgrim's Bounty"] = "Festa da Fartura"

elseif ns.locale == "ruRU" then
	ns.L["AddOn Description"] = "%chСправка по достижениям и квестам в %crПиршество странников"
	ns.L["Pilgrim's Bounty"] = "Пиршество странников"

elseif ns.locale == "zhCN" then
	ns.L["AddOn Description"] = "%ch帮助%cr感恩节%ch的成就和任务"
	ns.L["Pilgrim's Bounty"] = "感恩节"

elseif ns.locale == "zhTW" then
	ns.L["AddOn Description"] = "%ch幫助%cr感恩節%ch的成就和任務"
	ns.L["Pilgrim's Bounty"] = "感恩節"
	
else
	ns.L["AddOn Description"] = "%chHelp for the %crPilgrim's Bounty %chachievements and quests"
end