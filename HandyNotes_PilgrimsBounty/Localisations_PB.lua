local _, ns = ...

-- Translations specific to the Pilgrim's Bounty AddOn
if ns.locale == "deDE" then
	ns.L["AddOn Description"] = "%eHilfe für Erfolge und Quests in %sPilgerfreudenfest"
	ns.L["Pilgrim's Bounty"] = "Pilgerfreudenfest"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	ns.L["AddOn Description"] = "%eAyuda para logros y misiones en %sGenerosidad del Peregrino"
	ns.L["Pilgrim's Bounty"] = "Generosidad del Peregrino"

elseif ns.locale == "frFR" then
	ns.L["AddOn Description"] = "%eAide pour les réalisations et les quêtes dans %sLes Bienfaits du pèlerin"
	ns.L["Pilgrim's Bounty"] = "Les Bienfaits du pèlerin"

elseif ns.locale == "itIT" then
	ns.L["AddOn Description"] = "%eAiuto per obiettivi e missioni in %sRingraziamento del Pellegrino"
	ns.L["Pilgrim's Bounty"] = "Ringraziamento del Pellegrino"

elseif ns.locale == "koKR" then
	ns.L["AddOn Description"] = "%s순례자의 감사절%e의 업적 및 퀘스트에 대한 도움말"	
	ns.L["Pilgrim's Bounty"] = "순례자의 감사절"
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	ns.L["AddOn Description"] = "%eAjuda para conquistas e missões em %sFesta da Fartura"
	ns.L["Pilgrim's Bounty"] = "Festa da Fartura"

elseif ns.locale == "ruRU" then
	ns.L["AddOn Description"] = "%eСправка по достижениям и квестам в %sПиршество странников"
	ns.L["Pilgrim's Bounty"] = "Пиршество странников"

elseif ns.locale == "zhCN" then
	ns.L["AddOn Description"] = "%e帮助%s感恩节%e的成就和任务"
	ns.L["Pilgrim's Bounty"] = "感恩节"

elseif ns.locale == "zhTW" then
	ns.L["AddOn Description"] = "%e幫助%s感恩節%e的成就和任務"
	ns.L["Pilgrim's Bounty"] = "感恩節"
	
else
	ns.L["AddOn Description"] = "%eHelp for the %sPilgrim's Bounty %eachievements and quests"
end