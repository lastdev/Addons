--[[
                                ----o----(||)----oo----(||)----o----

                                           Lunar Festival

                                     v1.00 - 25th December 2023
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local myName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
-- Xmas theme
ns.colour = {}
ns.colour.prefix	= "\124cFF5FFB17" -- Emerald Green
ns.colour.highlight = "\124cFF52D017" -- Pea Green
ns.colour.plaintext = "\124cFF008000" -- Green W3C

local defaults = { profile = { icon_scale = 1.7, icon_alpha = 1, showCoords = true,
								removeDailies = true, removeSeasonal = true, removeEver = false,
								icon_zoneElders = 8, icon_dungeonElders = 7, 
								icon_factionElders = 15, } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
--local GetMapInfo = C_Map.GetMapInfo -- phase checking during testing
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local gsub = string.gsub
local next = _G.next

local HandyNotes = _G.HandyNotes

local _, _, _, version = GetBuildInfo()
ns.faction = UnitFactionGroup( "player" )
ns.name = UnitName( "player" ) or "Character"

continents[ 12 ] = true -- Kalimdor
continents[ 13 ] = true -- Eastern Kingdoms
continents[ 101 ] = true -- Outland
continents[ 113 ] = true -- Northrend
continents[ 572 ] = true -- Draenor
continents[ 947 ] = true -- Azeroth

-- Localisation
ns.locale = GetLocale()
local L = {}
setmetatable( L, { __index = function( L, key ) return key end } )
local realm = GetNormalizedRealmName() -- On a fresh login this will return null
ns.oceania = { AmanThul = true, Barthilas = true, Caelestrasz = true, DathRemar = true,
			Dreadmaul = true, Frostmourne = true, Gundrak = true, JubeiThos = true, 
			Khazgoroth = true, Nagrand = true, Saurfang = true, Thaurissan = true,
			Yojamba = true, Remulos = true, Arugal = true,}			
if ns.oceania[realm] then
	ns.locale = "enGB"
end

if ns.locale == "deDE" then
	L["Lunar Festival"] = "Mondfest"
	L["AddOn Description"] = "Hilfe f??r Erfolge und Quests in Mondfest"
	L["Character"] = "Charakter"
	L["Account"] = "Accountweiter"
	L["Completed"] = "Abgeschlossen"
	L["Not Completed"] = "Nicht Abgeschlossen"
	L["Icon Selection"] = "Symbolauswahl"
	L["Icon Scale"] = "Symbolskalierung"
	L["The scale of the icons"] = "Die Skalierung der Symbole"
	L["Icon Alpha"] = "Symboltransparenz"
	L["The alpha transparency of the icons"] = "Die Transparenz der Symbole"
	L["Icon"] = "Symbol"
	L["Options"] = "Optionen"
	L["Red"] = "Rot"
	L["Blue"] = "Blau"
	L["Green"] = "Gr??n"
	L["Cross"] = "Kreuz"
	L["Diamond"] = "Diamant"
	L["Frost"] = "Frost"
	L["Cogwheel"] = "Zahnrad"
	L["White"] = "Wei??"
	L["Purple"] = "Lila"
	L["Yellow"] = "Gelb"
	L["Grey"] = "Grau"
	L["Mana Orb"] = "Manakugel"
	L["Phasing"] = "Synchronisieren"
	L["Raptor egg"] = "Raptor-Ei"
	L["Stars"] = "Sternen"
	L["NPC"] = "NSC"
	L["Show Coordinates"] = "Koordinaten anzeigen"
	L["Show Coordinates Description"] = "Zeigen sie die " ..ns.colour.highlight 
		.."koordinaten\124r in QuickInfos auf der Weltkarte und auf der Minikarte an"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["Lunar Festival"] = "El fest??n del Festival Lunar"
	L["AddOn Description"] = "Ayuda para los logros del Festival Lunar"
	L["Character"] = "Personaje"
	L["Account"] = "la Cuenta"
	L["Completed"] = "Completado"
	L["Not Completed"] = ns.locale == "esES" and "Sin Completar" or "Incompleto"
	L["Icon Selection"] = "Selecci??n de iconos"
	L["Icon Scale"] = "Escala de icono"
	L["The scale of the icons"] = "La escala de los iconos"
	L["Icon Alpha"] = "Transparencia del icono"
	L["The alpha transparency of the icons"] = "La transparencia alfa de los iconos"
	L["Icon"] = "El icono"
	L["Options"] = "Opciones"
	L["Gold"] = "Oro"
	L["Red"] = "Rojo"
	L["Blue"] = "Azul"
	L["Green"] = "Verde"
	L["Ring"] = "Anillo"
	L["Cross"] = "Cruz"
	L["Diamond"] = "Diamante"
	L["Frost"] = "Escarcha"
	L["Cogwheel"] = "Rueda dentada"
	L["White"] = "Blanco"
	L["Purple"] = "P??rpura"
	L["Yellow"] = "Amarillo"
	L["Grey"] = "Gris"
	L["Mana Orb"] = "Orbe de man??"
	L["Phasing"] = "Sincronizaci??n"	
	L["Raptor egg"] = "Huevo de raptor"	
	L["Stars"] = "Estrellas"
	L["NPC"] = "PNJ"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Mostrar " ..ns.colour.highlight
		.."coordenadas\124r en informaci??n sobre herramientas en el mapa del mundo y en el minimapa"

elseif ns.locale == "frFR" then
	L["Lunar Festival"] = "F??te lunaire"
	L["AddOn Description"] = "Aide ?? l'??v??nement mondial F??te lunaire"
	L["Character"] = "Personnage"
	L["Account"] = "le Compte"
	L["Completed"] = "Achev??"
	L["Not Completed"] = "Non achev??"
	L["Icon Selection"] = "S??lection d'ic??nes"
	L["Icon Scale"] = "Echelle de l???ic??ne"
	L["The scale of the icons"] = "L'??chelle des ic??nes"
	L["Icon Alpha"] = "Transparence de l'ic??ne"
	L["The alpha transparency of the icons"] = "La transparence des ic??nes"
	L["Icon"] = "L'ic??ne"
	L["Options"] = "Options"
	L["Gold"] = "Or"
	L["Red"] = "Rouge"
	L["Blue"] = "Bleue"
	L["Green"] = "Vert"
	L["Ring"] = "Bague"
	L["Cross"] = "Traverser"
	L["Diamond"] = "Diamant"
	L["Frost"] = "Givre"
	L["Cogwheel"] = "Roue dent??e"
	L["White"] = "Blanc"
	L["Purple"] = "Violet"
	L["Yellow"] = "Jaune"
	L["Grey"] = "Gris"
	L["Mana Orb"] = "Orbe de mana"
	L["Phasing"] = "Synchronisation"
	L["Raptor egg"] = "??uf de Rapace"
	L["Stars"] = "??toiles"
	L["NPC"] = "PNJ"
	L["Show Coordinates"] = "Afficher les coordonn??es"
	L["Show Coordinates Description"] = "Afficher " ..ns.colour.highlight
		.."les coordonn??es\124r dans les info-bulles sur la carte du monde et la mini-carte"

elseif ns.locale == "itIT" then
	L["Lunar Festival"] = "Celebrazione della Luna"
	L["AddOn Description"] = "Assiste con l'evento mondiale Celebrazione della Luna"
	L["Character"] = "Personaggio"
	L["Completed"] = "Completo"
	L["Not Completed"] = "Non Compiuto"
	L["Icon Selection"] = "Selezione dell'icona"
	L["Icon Scale"] = "Scala delle icone"
	L["The scale of the icons"] = "La scala delle icone"
	L["Icon Alpha"] = "Icona alfa"
	L["The alpha transparency of the icons"] = "La trasparenza alfa delle icone"
	L["Icon"] = "Icona"
	L["Options"] = "Opzioni"
	L["Gold"] = "Oro"
	L["Red"] = "Rosso"
	L["Blue"] = "Blu"
	L["Green"] = "Verde"
	L["Ring"] = "Squillo"
	L["Cross"] = "Attraverso"
	L["Diamond"] = "Diamante"
	L["Frost"] = "Gelo"
	L["Cogwheel"] = "Ruota dentata"
	L["White"] = "Bianca"
	L["Purple"] = "Viola"
	L["Yellow"] = "Giallo"
	L["Grey"] = "Grigio"
	L["Mana Orb"] = "Globo di Mana"
	L["Phasing"] = "Sincronizzazione"
	L["Raptor egg"] = "Raptor Uovo"
	L["Stars"] = "Stelle"
	L["NPC"] = "PNG"
	L["Show Coordinates"] = "Mostra coordinate"
	L["Show Coordinates Description"] = "Visualizza " ..ns.colour.highlight
		.."le coordinate\124r nelle descrizioni comandi sulla mappa del mondo e sulla minimappa"

elseif ns.locale == "koKR" then
	L["Lunar Festival"] = "?????? ??????"
	L["AddOn Description"] = "?????? ?????? ????????? ????????? ??????"	
	L["Character"] = "?????????"
	L["Account"] = "??????"
	L["Completed"] = "??????"
	L["Not Completed"] = "?????????"
	L["Icon Selection"] = "????????? ??????"
	L["Icon Scale"] = "????????? ?????? ??????"
	L["The scale of the icons"] = "???????????? ?????? ???????????????"
	L["Icon Alpha"] = "????????? ?????????"
	L["The alpha transparency of the icons"] = "???????????? ??????????????????"
	L["Icon"] = "?????????"
	L["Options"] = "??????"
	L["Gold"] = "???"
	L["Red"] = "??????"
	L["Blue"] = "??????"
	L["Green"] = "??????"
	L["Ring"] = "??????"
	L["Cross"] = "?????????"
	L["Diamond"] = "???????????????"
	L["Frost"] = "??????"
	L["Cogwheel"] = "?????? ??????"
	L["White"] = "?????????"
	L["Purple"] = "?????????"
	L["Yellow"] = "??????"
	L["Grey"] = "??????"
	L["Mana Orb"] = "?????? ??????"
	L["Phasing"] = "????????? ???"
	L["Raptor egg"] = "????????? ???"
	L["Stars"] = "???"
	L["Show Coordinates"] = "?????? ??????"
	L["Show Coordinates Description"] = "???????????? ??? ??????????????? ?????? ????????? ????????? ???????????????."
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Lunar Festival"] = "Festival da Lua"
	L["AddOn Description"] = "Auxilia no evento mundial Festival da Lua"
	L["Character"] = "Personagem"
	L["Account"] = "?? Conta"
	L["Completed"] = "Conclu??do"
	L["Not Completed"] = "N??o Conclu??do"
	L["Icon Selection"] = "Sele????o de ??cones"
	L["Icon Scale"] = "Escala de ??cone"
	L["The scale of the icons"] = "A escala dos ??cones"
	L["Icon Alpha"] = "??cone Alpha"
	L["The alpha transparency of the icons"] = "A transpar??ncia alfa dos ??cones"
	L["Icon"] = "??cone"
	L["Options"] = "Op????es"
	L["Gold"] = "Ouro"
	L["Red"] = "Vermelho"
	L["Blue"] = "Azul"
	L["Green"] = "Verde"
	L["Ring"] = "Anel"
	L["Cross"] = "Cruz"
	L["Diamond"] = "Diamante"
	L["Frost"] = "G??lido"
	L["Cogwheel"] = "Roda dentada"
	L["White"] = "Branco"
	L["Purple"] = "Roxa"
	L["Yellow"] = "Amarelo"
	L["Grey"] = "Cinzento"
	L["Mana Orb"] = "Orbe de Mana"
	L["Phasing"] = "Sincroniza????o"
	L["Raptor egg"] = "Ovo de raptor"
	L["Stars"] = "Estrelas"
	L["NPC"] = "PNJ"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Exibir " ..ns.colour.highlight
		.."coordenadas\124r em dicas de ferramentas no mapa mundial e no minimapa"

elseif ns.locale == "ruRU" then
	L["Lunar Festival"] = "???????????? ??????????????????"
	L["AddOn Description"] = "???????????????? ?? ?????????????? ?????????????? ???????????? ??????????????????"
	L["Character"] = "??????????????????"
	L["Account"] = "????????"
	L["Completed"] = "??????????????????"
	L["Not Completed"] = "???? ??????????????????"
	L["Icon Selection"] = "?????????? ????????????"
	L["Icon Scale"] = "?????????????? ????????????"
	L["The scale of the icons"] = "?????????????? ?????? ??????????????"
	L["Icon Alpha"] = "?????????? ????????????"
	L["The alpha transparency of the icons"] = "??????????-???????????????????????? ??????????????"
	L["Icon"] = "?????????? ????????????"
	L["Options"] = "??????????????????"
	L["Gold"] = "????????????"
	L["Red"] = "??????????????"
	L["Blue"] = "??????????"
	L["Green"] = "??????????????"
	L["Ring"] = "??????????????"
	L["Cross"] = "??????????"
	L["Diamond"] = "????????"
	L["Frost"] = "??????"
	L["Cogwheel"] = "???????????????? ????????????"
	L["White"] = "??????????"
	L["Purple"] = "??????????????????"
	L["Yellow"] = "????????????"
	L["Grey"] = "??????????"
	L["Mana Orb"] = "C???????? ????????"
	L["Phasing"] = "??????????????????????????"
	L["Raptor egg"] = "???????? ??????????"
	L["Stars"] = "????????????"
	L["Show Coordinates"] = "???????????????? ????????????????????"
	L["Show Coordinates Description"] = "???????????????????? " ..ns.colour.highlight
		.."????????????????????\124r ???? ?????????????????????? ???????????????????? ???? ?????????? ???????? ?? ????????-??????????"

elseif ns.locale == "zhCN" then
	L["Lunar Festival"] = "??????"
	L["AddOn Description"] = "??????????????????"
	L["Character"] = "??????"
	L["Account"] = "??????"
	L["Completed"] = "?????????"
	L["Not Completed"] = "?????????"
	L["Icon Selection"] = "????????????"
	L["Icon Scale"] = "????????????"
	L["The scale of the icons"] = "???????????????"
	L["Icon Alpha"] = "???????????????"
	L["The alpha transparency of the icons"] = "??????????????????"
	L["Icon"] = "??????"
	L["Options"] = "??????"
	L["Gold"] = "??????"
	L["Red"] = "???"
	L["Blue"] = "???"
	L["Green"] = "??????"
	L["Ring"] = "??????"
	L["Cross"] = "???"
	L["Diamond"] = "??????"
	L["Frost"] = "??????"
	L["Cogwheel"] = "??????"
	L["White"] = "??????"
	L["Purple"] = "??????"
	L["Yellow"] = "??????"
	L["Grey"] = "??????"
	L["Mana Orb"] = "?????????"
	L["Phasing"] = "??????"
	L["Raptor egg"] = "????????????"
	L["Stars"] = "??????"
	L["Show Coordinates"] = "????????????"
	L["Show Coordinates Description"] = "???????????????????????????????????????????????????" ..ns.colour.highlight .."????????????"

elseif ns.locale == "zhTW" then
	L["Lunar Festival"] = "??????"
	L["AddOn Description"] = "??????????????????"
	L["Character"] = "??????"
	L["Account"] = "??????"
	L["Completed"] = "??????"
	L["Not Completed"] = "?????????"
	L["Icon Selection"] = "????????????"
	L["Icon Scale"] = "????????????"
	L["The scale of the icons"] = "???????????????"
	L["Icon Alpha"] = "???????????????"
	L["The alpha transparency of the icons"] = "??????????????????"
	L["Icon"] = "??????"
	L["Options"] = "??????"
	L["Gold"] = "??????"
	L["Red"] = "???"
	L["Blue"] = "???"
	L["Green"] = "??????"
	L["Ring"] = "??????"
	L["Cross"] = "???"
	L["Diamond"] = "??????"
	L["Frost"] = "???"
	L["Cogwheel"] = "??????"
	L["White"] = "??????"
	L["Purple"] = "??????"
	L["Yellow"] = "??????"
	L["Grey"] = "??????"
	L["Mana Orb"] = "?????????"
	L["Phasing"] = "??????"
	L["Raptor egg"] = "????????????"
	L["Show Coordinates"] = "????????????"
	L["Show Coordinates Description"] = "???????????????????????????????????????????????????" ..ns.colour.highlight .."????????????"
	
else
	if ns.locale == "enUS" then
		L["Grey"] = "Gray"
	end
	L["AddOn Description"] = "Help for the Lunar Festival achievements"
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
end

local function printPC( message )
	if message then
		DEFAULT_CHAT_FRAME:AddMessage( ns.colour.prefix .."LunarFestival" ..": " ..ns.colour.plaintext
			..message.. "\124r" )
	end
end

-- Plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	local point = ns.points[mapFile] and ns.points[mapFile][coord]
	return point[1], point[2], point[3], point[4], point[5], point[6], point[7]
end

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local aIDA, aIDH, aIndexA, aIndexH, aQuestA, aQuestH, tip = infoFromCoord(mapFile, coord)

	local aID = ((  aIDA > 0 ) and aIDA ) or aIDH
	local aIndex = ((  aIndexA > 0 ) and aIndexA ) or aIndexH
	local aQuest = ((  aQuestA > 0 ) and aQuestA ) or aQuestH
	local pName = UnitName( "player" ) or "Character"
	local completed, aName, completedMe;
	local bypassCoords = false
	
	if (aID > 0) and (aIndex > 0) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )										
		aName, _, completed = GetAchievementCriteriaInfo( aID, aIndex )
		GameTooltip:AddDoubleLine( ns.colour.highlight.. aName,
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
	elseif (aID > 0) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
	elseif ( aQuest > 0 ) then
		completed = C_QuestLog.IsQuestFlaggedCompleted( aQuest )
		GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "Daily Quest",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
	elseif (aIndex > 0) then
	else
		bypassCoords = true
	end
	if  not ( tip == nil ) then
		GameTooltip:AddLine( ns.colour.plaintext ..tip )
	end	
	if ( ns.db.showCoords == true ) and ( bypassCoords == false ) then
		local mX, mY = HandyNotes:getXY(coord)
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( ns.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end

	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

local function ShowConditionallyE( aID, aIndex )
	local completed;
	if ( ns.db.removeEver == true ) then
		if ( aIndex > 0 ) then
			_, _, completed = GetAchievementCriteriaInfo( aID, aIndex )
		else
			_, _, _, completed = GetAchievementInfo( aID )
		end
		if ( completed == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyD( v5or6 )
	local completed;
	if ( ns.db.removeDailies == true ) then
		completed = C_QuestLog.IsQuestFlaggedCompleted( v5or6 )
		if ( completed == true ) then
			return false
		end
	end
	return true
end

do	
	local function iterator(t, prev)
		if not t then return end
		local coord, v = next(t, prev)
		while coord do
			if v then
				if ( v[1] == 910 ) and ( ns.faction == "Alliance" ) then
					if ( ShowConditionallyE( v[1], v[3] ) == true ) then
						return coord, nil, ns.textures[ns.db.icon_dungeonElders],
							ns.db.icon_scale * ns.scaling[ns.db.icon_dungeonElders], ns.db.icon_alpha
					end
				elseif ( v[2] == 910 ) and ( ns.faction == "Horde" ) then
					if ( ShowConditionallyE( v[2], v[4] ) == true ) then
						return coord, nil, ns.textures[ns.db.icon_dungeonElders],
							ns.db.icon_scale * ns.scaling[ns.db.icon_dungeonElders], ns.db.icon_alpha
					end
				elseif ( ( v[1] == 911 ) or ( v[1] == 912 ) or ( v[1] == 1396 ) or ( v[1] == 6006 ) ) and ( ns.faction == "Alliance" ) then
					if ( ShowConditionallyE( v[1], v[3] ) == true ) then
						return coord, nil, ns.textures[ns.db.icon_zoneElders],
							ns.db.icon_scale * ns.scaling[ns.db.icon_zoneElders], ns.db.icon_alpha
					end
				elseif ( ( v[2] == 911 ) or ( v[2] == 912 ) or ( v[2] == 1396 ) or ( v[2] == 6006 ) ) and ( ns.faction == "Horde" ) then
					if ( ShowConditionallyE( v[2], v[4] ) == true ) then
						return coord, nil, ns.textures[ns.db.icon_zoneElders],
							ns.db.icon_scale * ns.scaling[ns.db.icon_zoneElders], ns.db.icon_alpha
					end
				elseif ( ( v[1] == 914 ) or ( v[1] == 915 ) ) and ( ns.faction == "Alliance" ) then
					if ( ShowConditionallyE( v[1], v[3] ) == true ) then
						return coord, nil, ns.textures[ns.db.icon_factionElders],
							ns.db.icon_scale * ns.scaling[ns.db.icon_factionElders], ns.db.icon_alpha
					end
				elseif ( ( v[2] == 914 ) or ( v[2] == 915 ) ) and ( ns.faction == "Horde" ) then
					if ( ShowConditionallyE( v[2], v[4] ) == true ) then
						return coord, nil, ns.textures[ns.db.icon_factionElders],
							ns.db.icon_scale * ns.scaling[ns.db.icon_factionElders], ns.db.icon_alpha
					end
				end
			end
			coord, v = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		ns.CurrentMap = mapID
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> Lunar Festival options
ns.options = {
	type = "group",
	name = L["Lunar Festival"],
	desc = L["AddOn Description"],
	get = function(info) return ns.db[info[#info]] end,
	set = function(info, v)
		ns.db[info[#info]] = v
		pluginHandler:Refresh()
	end,
	args = {
		options = {
			type = "group",
			-- Add a " " to force this to be before the first group. HN arranges alphabetically on local language
			name = " " ..L["Options"],
			inline = true,
			args = {
				icon_scale = {
					type = "range",
					name = L["Icon Scale"],
					desc = L["The scale of the icons"],
					min = 1, max = 3, step = 0.1,
					arg = "icon_scale",
					order = 2,
				},
				icon_alpha = {
					type = "range",
					name = L["Icon Alpha"],
					desc = L["The alpha transparency of the icons"],
					min = 0, max = 1, step = 0.01,
					arg = "icon_alpha",
					order = 3,
				},
				showCoords = {
					name = L["Show Coordinates"],
					desc = L["Show Coordinates Description"] 
							..ns.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 4,
				},
				removeDailies = {
					name = "Remove dailies if completed today by " ..ns.name,
					desc = "If you have completed the daily quest\n"
							.."today then the map marker is removed\n"
							.."or replaced as appropriate",
					type = "toggle",
					width = "full",
					arg = "removeDailies",
					order = 5,
				},
				removeSeasonal = {
					name = "Remove Elder marker if completed this season by " ..ns.name,
					desc = "Achievement Elders are repeatable each season",
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					order = 6,
				},
				removeEver = {
					name = "Remove marker if ever completed on this account",
					desc = "If any of your characters has completed the achievement",
					type = "toggle",
					width = "full",
					arg = "removeEver",
					order = 7,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Icon Selection"],
			inline = true,
			args = {
				icon_zoneElders = {
					type = "range",
					name = L["BB King"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Coin"] .."\n8 = " ..L["Deep Green Coin"] .."\n9 = "
							..L["Deep Pink Coin"] .."\n10 = " ..L["Deep Red Coin"] .."\n11 = "
							..L["Green Coin"] .."\n12 = " ..L["Light Blue Coin"] .."\n13 = "
							..L["Pink Coin"] .."\n14 = " ..L["Purple Coin"] .."\n15 = " ..L["Teal Coin"]
							.."\n16 = " ..L["Original Coin"], 
					min = 1, max = 16, step = 1,
					arg = "icon_zoneElders",
					order = 8,
				},
				icon_dungeonElders = {
					type = "range",
					name = L["Caroling"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Coin"] .."\n8 = " ..L["Deep Green Coin"] .."\n9 = "
							..L["Deep Pink Coin"] .."\n10 = " ..L["Deep Red Coin"] .."\n11 = "
							..L["Green Coin"] .."\n12 = " ..L["Light Blue Coin"] .."\n13 = "
							..L["Pink Coin"] .."\n14 = " ..L["Purple Coin"] .."\n15 = " ..L["Teal Coin"]
							.."\n16 = " ..L["Original Coin"], 
					min = 1, max = 16, step = 1,
					arg = "icon_dungeonElders",
					order = 9,
				},
				icon_factionElders = {
					type = "range",
					name = L["Caroling"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Coin"] .."\n8 = " ..L["Deep Green Coin"] .."\n9 = "
							..L["Deep Pink Coin"] .."\n10 = " ..L["Deep Red Coin"] .."\n11 = "
							..L["Green Coin"] .."\n12 = " ..L["Light Blue Coin"] .."\n13 = "
							..L["Pink Coin"] .."\n14 = " ..L["Purple Coin"] .."\n15 = " ..L["Teal Coin"]
							.."\n16 = " ..L["Original Coin"], 
					min = 1, max = 16, step = 1,
					arg = "icon_factionElders",
					order = 9,
				},
			},
		},
	},
}

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then
		printPC("HandyNotes is out of date")
		return
	end
	
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			-- Maps here will not propagate upwards
			if ( map.mapID == 7 ) or -- Mulgore
				( map.mapID == 84 ) or -- Stormwind
				( map.mapID == 85 ) or -- Orgrimmar
				( map.mapID == 87 ) or -- Ironforge
				( map.mapID == 90 ) or -- Undercity
				( map.mapID == 103 ) or -- The Exodar
				( map.mapID == 110 ) or -- Silvermoon City
				( map.mapID == 127 ) or -- Crystalsong Forest
				( map.mapID == 224 ) or -- Stranglethorn Vale
				( map.mapID == 582 ) or -- Lunarfall Alliance Garrison
				( map.mapID == 590 ) then -- Frostwall Horde Garrison
			elseif (version < 40000) and ( map.mapID < 1400 ) then
			elseif (version >= 40000) and ( map.mapID >= 1400 ) then
			elseif coords then
				for coord, v in next, coords do
					local function AddToContinent()
						local mx, my = HandyNotes:getXY(coord)
						local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
						if cx and cy then
							ns.points[continentMapID] = ns.points[continentMapID] or {}
							ns.points[continentMapID][HandyNotes:getCoord(cx, cy)] = v
						end
					end
					if ( v[1] > 0 ) and ( v[2] > 0 ) then
						AddToContinent()
					elseif ( v[1] > 0 ) or ( v[5] > 0 ) then
						if ( ns.faction == "Alliance" ) then
							AddToContinent()
						end
					elseif ( v[2] > 0 ) or ( v[6] > 0 ) then
						if ( ns.faction == "Horde" ) then
							AddToContinent()
						end
					elseif ( v[3] > 0 ) or ( v[4] > 0 ) then
						AddToContinent()
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("LunarFestival", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_LunarFestivalDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "LunarFestival")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_LunarFestivalDB", "AceEvent-3.0")