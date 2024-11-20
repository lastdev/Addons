local _, Engine = ...

-- Lua functions
local rawget = rawget

-- WoW API / Variables

local locale = GetLocale()
local L = {}

Engine.L = setmetatable(L, {
    __index = function(t, s) return rawget(t, s) or s end,
})

if locale == 'zhCN' then
L["Avoidable Abilities Taken"] = "可避免的技能"
L["Avoidable Damage Taken"] = "可避免的伤害"
L["Show how many avoidable abilities hit players."] = "显示被击中了多少可避免的技能。"
L["Show how much avoidable damage was taken."] = "显示承受了多少可避免的伤害。"

elseif locale == 'zhTW' then
L["Avoidable Abilities Taken"] = "可避免的法術"
L["Avoidable Damage Taken"] = "可避免的傷害"
L["Show how many avoidable abilities hit players."] = "顯示被擊中了多少可避免的法術。"
L["Show how much avoidable damage was taken."] = "顯示承受了多少可避免的傷害。"

elseif locale == 'deDE' then
L["Avoidable Abilities Taken"] = "Vermeidbare Fähigkeiten"
L["Avoidable Damage Taken"] = "Vermeidbarer Schaden"
L["Show how many avoidable abilities hit players."] = "Zeigt wie viele vermeidbare Fähigkeiten die Spieler getroffen haben."
L["Show how much avoidable damage was taken."] = "Zeigt wie viel vermeidbarer Schaden die Spieler getroffen hat."

elseif locale == 'esES' then
--[[Translation missing --]]
--[[ L["Avoidable Abilities Taken"] = "Avoidable Abilities Taken"--]] 
--[[Translation missing --]]
--[[ L["Avoidable Damage Taken"] = "Avoidable Damage Taken"--]] 
--[[Translation missing --]]
--[[ L["Show how many avoidable abilities hit players."] = "Show how many avoidable abilities hit players."--]] 
--[[Translation missing --]]
--[[ L["Show how much avoidable damage was taken."] = "Show how much avoidable damage was taken."--]] 

elseif locale == 'esMX' then
--[[Translation missing --]]
--[[ L["Avoidable Abilities Taken"] = "Avoidable Abilities Taken"--]] 
--[[Translation missing --]]
--[[ L["Avoidable Damage Taken"] = "Avoidable Damage Taken"--]] 
--[[Translation missing --]]
--[[ L["Show how many avoidable abilities hit players."] = "Show how many avoidable abilities hit players."--]] 
--[[Translation missing --]]
--[[ L["Show how much avoidable damage was taken."] = "Show how much avoidable damage was taken."--]] 

elseif locale == 'frFR' then
--[[Translation missing --]]
--[[ L["Avoidable Abilities Taken"] = "Avoidable Abilities Taken"--]] 
--[[Translation missing --]]
--[[ L["Avoidable Damage Taken"] = "Avoidable Damage Taken"--]] 
--[[Translation missing --]]
--[[ L["Show how many avoidable abilities hit players."] = "Show how many avoidable abilities hit players."--]] 
--[[Translation missing --]]
--[[ L["Show how much avoidable damage was taken."] = "Show how much avoidable damage was taken."--]] 

elseif locale == 'itIT' then
--[[Translation missing --]]
--[[ L["Avoidable Abilities Taken"] = "Avoidable Abilities Taken"--]] 
--[[Translation missing --]]
--[[ L["Avoidable Damage Taken"] = "Avoidable Damage Taken"--]] 
--[[Translation missing --]]
--[[ L["Show how many avoidable abilities hit players."] = "Show how many avoidable abilities hit players."--]] 
--[[Translation missing --]]
--[[ L["Show how much avoidable damage was taken."] = "Show how much avoidable damage was taken."--]] 

elseif locale == 'koKR' then
--[[Translation missing --]]
--[[ L["Avoidable Abilities Taken"] = "Avoidable Abilities Taken"--]] 
--[[Translation missing --]]
--[[ L["Avoidable Damage Taken"] = "Avoidable Damage Taken"--]] 
--[[Translation missing --]]
--[[ L["Show how many avoidable abilities hit players."] = "Show how many avoidable abilities hit players."--]] 
--[[Translation missing --]]
--[[ L["Show how much avoidable damage was taken."] = "Show how much avoidable damage was taken."--]] 

elseif locale == 'ptBR' then
L["Avoidable Abilities Taken"] = "Habilidades Evitáveis Tomadas"
L["Avoidable Damage Taken"] = "Dano Evitável Tomado"
L["Show how many avoidable abilities hit players."] = "Mostra quantas habilidades evitáveis acertaram jogadores."
L["Show how much avoidable damage was taken."] = "Mostra quanto dano evitável foi tomado."

elseif locale == 'ruRU' then
L["Avoidable Abilities Taken"] = "Используемые способности, которых можно избежать"
L["Avoidable Damage Taken"] = "Полученный урон, которого можно избежать"
L["Show how many avoidable abilities hit players."] = "Показать, сколько способностей, которых можно избежать, поражает игроков."
L["Show how much avoidable damage was taken."] = "Показать, сколько предотвратимого урона было получено."

end
