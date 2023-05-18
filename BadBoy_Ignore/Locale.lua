
local _, L = ...

L.addPlayer = "Add Player"
L.removePlayer = "Remove Player"

local loc = GetLocale()
if loc == "frFR" then
	L.addPlayer = "Ajouter un joueur"
	L.removePlayer = "Supprimer un joueur"
elseif loc == "deDE" then
	--L.addPlayer = "Add Player"
	--L.removePlayer = "Remove Player"
elseif loc == "zhTW" then
	--L.addPlayer = "Add Player"
	--L.removePlayer = "Remove Player"
elseif loc == "zhCN" then
	--L.addPlayer = "Add Player"
	--L.removePlayer = "Remove Player"
elseif loc == "esES" or loc == "esMX" then
	--L.addPlayer = "Add Player"
	--L.removePlayer = "Remove Player"
elseif loc == "ruRU" then
	L.addPlayer = "Добавить игрока"
	L.removePlayer = "Удалить игрока"
elseif loc == "koKR" then
	--L.addPlayer = "Add Player"
	--L.removePlayer = "Remove Player"
elseif loc == "ptBR" then
	--L.addPlayer = "Add Player"
	--L.removePlayer = "Remove Player"
elseif loc == "itIT" then
	--L.addPlayer = "Add Player"
	--L.removePlayer = "Remove Player"
end
