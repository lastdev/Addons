--[[
                                ----o----(||)----oo----(||)----o----

                                          Springfur Alpaca

                                     v1.05 - 15th September 2022
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local myName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
ns.texturesSpecial = {}
ns.scalingSpecial = {}
-- Brown theme
ns.colour = {}
ns.colour.prefix	= "\124cFFD2691E"	-- X11Chocolate
ns.colour.highlight = "\124cFFF4A460"	-- X11SandyBrown
ns.colour.plaintext = "\124cFFDEB887"	-- X11BurlyWood
-- Map IDs
ns.kalimdor = 12
--ns.kalimdor = 986
--ns.kalimdor = 1209
--ns.uldum = 249 -- That's the old Uldum
ns.uldum = 1527 -- From about Patch 8.3
--ns.uldum = 1330

--ns.author = true

local defaults = { profile = { icon_scale = 1.4, icon_alpha = 0.8, icon_choice = 7, icon_choiceSpecial = 8, showCoords = true } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local IsControlKeyDown = _G.IsControlKeyDown
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local next = _G.next
local select = _G.select

local HandyNotes = _G.HandyNotes

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
	L["Springfur Alpaca"] = "Frühlingsfellalpaka"
	L["AddOn Description"] = "Hilft dir, die " ..ns.colour.highlight .."Dunkle Erde" .."\124r zu finden"
	L["Icon settings"] = "Symboleinstellungen"
	L["Icon Scale"] = "Symbolskalierung"
	L["The scale of the icons"] = "Die Skalierung der Symbole"
	L["Icon Alpha"] = "Symboltransparenz"
	L["The alpha transparency of the icons"] = "Die Transparenz der Symbole"
	L["Icon"] = "Symbol"
	L["Phasing"] = "Synchronisieren"
	L["Raptor egg"] = "Raptor-Ei"
	L["Stars"] = "Sternen"
	L["Purple"] = "Lila"
	L["White"] = "Weiß"
	L["Mana Orb"] = "Manakugel"
	L["Cogwheel"] = "Zahnrad"
	L["Frost"] = "Frost"
	L["Diamond"] = "Diamant"
	L["Red"] = "Rot"
	L["Yellow"] = "Gelb"
	L["Green"] = "Grün"
	L["Screw"] = "Schraube"
	L["Grey"] = "Grau"
	L["Options"] = "Optionen"
	L["Gersahl Greens"] = "Gersahlblätter"
	L["Gold Ring"] = "Goldener Ring"
	L["Red Cross"] = "Rotes Kreuz"
	L["Undo"] = "Rückgängig machen"
	L["White Diamond"] = "Weißer Diamant"
	L["Copper Diamond"] = "Kupfer Diamant"
	L["Red Ring"] = "Roter Ring"
	L["Blue Ring"] = "Blauer Ring"
	L["Green Ring"] = "Grüner Ring"
	L["Show Coordinates"] = "Koordinaten anzeigen"
	L["Show Coordinates Description"] = "Zeigen sie die " ..ns.colour.highlight 
		.."koordinaten\124r in QuickInfos auf der Weltkarte und auf der Minikarte an"
	
elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["Springfur Alpaca"] = "Alpaca de pelaje primaveral"
	L["AddOn Description"] = "Ayuda a encontrar los " ..ns.colour.highlight .."Tierra Oscura"
	L["Icon settings"] = "Configuración de iconos"
	L["Icon Scale"] = "Escala de icono"
	L["The scale of the icons"] = "La escala de los iconos"
	L["Icon Alpha"] = "Transparencia del icono"
	L["The alpha transparency of the icons"] = "La transparencia alfa de los iconos"
	L["Icon"] = "El icono"
	L["Phasing"] = "Sincronización"	
	L["Raptor egg"] = "Huevo de raptor"	
	L["Stars"] = "Estrellas"
	L["Purple"] = "Púrpura"
	L["White"] = "Blanco"
	L["Mana Orb"] = "Orbe de maná"
	L["Cogwheel"] = "Rueda dentada"
	L["Frost"] = "Escarcha"
	L["Diamond"] = "Diamante"
	L["Red"] = "Rojo"
	L["Yellow"] = "Amarillo"
	L["Green"] = "Verde"
	L["Screw"] = "Tornillo"
	L["Grey"] = "Gris"
	L["Options"] = "Opciones"
	L["Gersahl Greens"] = "Verduras Gersahl"
	L["Gold Ring"] = "Anillo de oro"
	L["Red Cross"] = "Rotes kreuz"
	L["Undo"] = "Deshacer"
	L["White Diamond"] = "Diamante blanco"
	L["Copper Diamond"] = "Diamante de cobre"
	L["Red Ring"] = "Rojo Anillo"
	L["Blue Ring"] = "Azul Anillo"
	L["Green Ring"] = "Verde Anillo"	
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Mostrar " ..ns.colour.highlight
		.."coordenadas\124r en información sobre herramientas en el mapa del mundo y en el minimapa"

elseif ns.locale == "frFR" then
	L["Springfur Alpaca"] = "Alpaga toison-vernale"
	L["AddOn Description"] = "Aide à trouver les " ..ns.colour.highlight .."Terre Sombre"
	L["Icon settings"] = "Paramètres des icônes"
	L["Icon Scale"] = "Echelle de l’icône"
	L["The scale of the icons"] = "L'échelle des icônes"
	L["Icon Alpha"] = "Transparence de l'icône"
	L["The alpha transparency of the icons"] = "La transparence des icônes"
	L["Icon"] = "L'icône"
	L["Phasing"] = "Synchronisation"
	L["Raptor egg"] = "Œuf de Rapace"
	L["Stars"] = "Étoiles"
	L["Purple"] = "Violet"
	L["White"] = "Blanc"
	L["Mana Orb"] = "Orbe de mana"
	L["Cogwheel"] = "Roue dentée"
	L["Frost"] = "Givre"
	L["Diamond"] = "Diamant"
	L["Red"] = "Rouge"
	L["Yellow"] = "Jaune"
	L["Green"] = "Vert"
	L["Screw"] = "Vis"
	L["Grey"] = "Gris"
	L["Options"] = "Options"
	L["Gersahl Greens"] = "Légume de Gersahl"
	L["Gold Ring"] = "Bague en or"
	L["Red Cross"] = "Croix rouge"
	L["Undo"] = "Annuler"
	L["White Diamond"] = "Diamant blanc"
	L["Copper Diamond"] = "Diamant de cuivre"
	L["Red Ring"] = "Anneau rouge"
	L["Blue Ring"] = "Anneau bleue"
	L["Green Ring"] = "Anneau vert"	
	L["Show Coordinates"] = "Afficher les coordonnées"
	L["Show Coordinates Description"] = "Afficher " ..ns.colour.highlight
		.."les coordonnées\124r dans les info-bulles sur la carte du monde et la mini-carte"

elseif ns.locale == "itIT" then
	L["Springfur Alpaca"] = "Alpaca Primopelo"
	L["AddOn Description"] = "Aiuta a trovare le " ..ns.colour.highlight .."Terreno Smosso"
	L["Icon settings"] = "Impostazioni icona"
	L["Icon Scale"] = "Scala delle icone"
	L["The scale of the icons"] = "La scala delle icone"
	L["Icon Alpha"] = "Icona alfa"
	L["The alpha transparency of the icons"] = "La trasparenza alfa delle icone"
	L["Icon"] = "Icona"
	L["Phasing"] = "Sincronizzazione"
	L["Raptor egg"] = "Raptor Uovo"
	L["Stars"] = "Stelle"
	L["Purple"] = "Viola"
	L["White"] = "Bianca"
	L["Mana Orb"] = "Globo di Mana"
	L["Cogwheel"] = "Ruota dentata"
	L["Frost"] = "Gelo"
	L["Diamond"] = "Diamante"
	L["Red"] = "Rosso"
	L["Yellow"] = "Giallo"
	L["Green"] = "Verde"
	L["Screw"] = "Vite"
	L["Grey"] = "Grigio"
	L["Options"] = "Opzioni"
	L["Gersahl Greens"] = "Insalata di Gersahl"
	L["Gold Ring"] = "Anello d'oro"
	L["Red Cross"] = "Croce rossa"
	L["Undo"] = "Disfare"
	L["White Diamond"] = "Diamante bianco"
	L["Copper Diamond"] = "Diamante di rame"
	L["Red Ring"] = "Anello rosso"
	L["Blue Ring"] = "Anello blu"
	L["Green Ring"] = "Anello verde"
	L["Show Coordinates"] = "Mostra coordinate"
	L["Show Coordinates Description"] = "Visualizza " ..ns.colour.highlight
		.."le coordinate\124r nelle descrizioni comandi sulla mappa del mondo e sulla minimappa"

elseif ns.locale == "koKR" then
	L["Springfur Alpaca"] = "봄털 알파카"
	L["AddOn Description"] = ns.colour.highlight .."검은 토양\124r 를 찾을 수 있도록 도와줍니다"
	L["Icon settings"] = "아이콘 설정"
	L["Icon Scale"] = "아이콘 크기 비율"
	L["The scale of the icons"] = "아이콘의 크기 비율입니다"
	L["Icon Alpha"] = "아이콘 투명도"
	L["The alpha transparency of the icons"] = "아이콘의 투명도입니다"
	L["Icon"] = "아이콘"
	L["Phasing"] = "동기화 중"
	L["Raptor egg"] = "랩터의 알"
	L["Stars"] = "별"
	L["Purple"] = "보라색"
	L["White"] = "화이트"
	L["Mana Orb"] = "마나 보주"
	L["Cogwheel"] = "톱니 바퀴"
	L["Frost"] = "냉기"
	L["Diamond"] = "다이아몬드"
	L["Red"] = "빨간"
	L["Yellow"] = "노랑"
	L["Green"] = "녹색"
	L["Screw"] = "나사"
	L["Grey"] = "회색"
	L["Options"] = "설정"
	L["Gersahl Greens"] = "게샬 채소"
	L["Gold Ring"] = "금반지"
	L["Red Cross"] = "국제 적십자사"
	L["Undo"] = "끄르다"
	L["White Diamond"] = "화이트 다이아몬드"
	L["Copper Diamond"] = "구리 다이아몬드"
	L["Red Ring"] = "빨간 반지"
	L["Blue Ring"] = "파란색 반지"
	L["Green Ring"] = "녹색 반지"
	L["Show Coordinates"] = "좌표 표시"
	L["Show Coordinates Description"] = "세계지도 및 미니지도의 도구 설명에 좌표를 표시합니다."

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Springfur Alpaca"] = "Alpaca Lã de Primavera"
	L["AddOn Description"] = "Ajuda você a localizar " ..ns.colour.highlight .."Solo Negro"
	L["Icon settings"] = "Configurações de ícone"
	L["Icon Scale"] = "Escala de Ícone"
	L["The scale of the icons"] = "A escala dos ícones"
	L["Icon Alpha"] = "Ícone Alpha"
	L["The alpha transparency of the icons"] = "A transparência alfa dos ícones"
	L["Icon"] = "Ícone"
	L["Phasing"] = "Sincronização"
	L["Raptor egg"] = "Ovo de raptor"
	L["Stars"] = "Estrelas"
	L["Purple"] = "Roxa"
	L["White"] = "Branco"
	L["Mana Orb"] = "Orbe de Mana"
	L["Cogwheel"] = "Roda dentada"
	L["Frost"] = "Gélido"
	L["Diamond"] = "Diamante"
	L["Red"] = "Vermelho"
	L["Yellow"] = "Amarelo"
	L["Green"] = "Verde"
	L["Screw"] = "Parafuso"
	L["Grey"] = "Cinzento"
	L["Options"] = "Opções"
	L["Gersahl Greens"] = "Folhas de Gersahl"
	L["Gold Ring"] = "Anel de ouro"
	L["Red Cross"] = "Cruz vermelha"
	L["Undo"] = "Desfazer"
	L["White Diamond"] = "Diamante branco"
	L["Copper Diamond"] = "Diamante de cobre"
	L["Red Ring"] = "Anel vermelho"
	L["Blue Ring"] = "Anel azul"
	L["Green Ring"] = "Anel verde"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Exibir " ..ns.colour.highlight
		.."coordenadas\124r em dicas de ferramentas no mapa mundial e no minimapa"

elseif ns.locale == "ruRU" then
	L["Springfur Alpaca"] = "Курчавая альпака"
	L["AddOn Description"] = "Помогает найти " ..ns.colour.highlight .."Темная Земля"
	L["Icon settings"] = "Настройки Значков"
	L["Icon Scale"] = "Масштаб Значок"
	L["The scale of the icons"] = "Масштаб для Значков"
	L["Icon Alpha"] = "Альфа Значок"
	L["Phasing"] = "Синхронизация"
	L["Raptor egg"] = "Яйцо ящера"
	L["Stars"] = "Звезды"
	L["Purple"] = "Пурпурный"
	L["White"] = "белый"
	L["Mana Orb"] = "Cфера маны"
	L["Cogwheel"] = "Зубчатое колесо"
	L["Frost"] = "Лед"
	L["Diamond"] = "Ромб"
	L["Red"] = "Красный"
	L["Yellow"] = "Желтый"
	L["Green"] = "Зеленый"
	L["Screw"] = "Винт"
	L["Grey"] = "Серый"
	L["Options"] = "Параметры"
	L["Gersahl Greens"] = "Побеги герсали"
	L["Gold Ring"] = "Золотое кольцо"
	L["Red Cross"] = "Красный Крест"
	L["Undo"] = "Расстегивать"
	L["White Diamond"] = "Белый бриллиант"
	L["Copper Diamond"] = "Медный бриллиант"
	L["Red Ring"] = "Красное кольцо"
	L["Blue Ring"] = "Синее кольцо"
	L["Green Ring"] = "Зеленое кольцо"
	L["Show Coordinates"] = "Показать Координаты"
	L["Show Coordinates Description"] = "Отображает " ..ns.colour.highlight
		.."координаты\124r во всплывающих подсказках на карте мира и мини-карте"

elseif ns.locale == "zhCN" then
	L["Springfur Alpaca"] = "春裘羊驼"
	L["AddOn Description"] = "帮助你找寻" ..ns.colour.highlight .."黑色泥土"
	L["Icon settings"] = "图标设置"
	L["Icon Scale"] = "图示大小"
	L["The scale of the icons"] = "图示的大小"
	L["Icon Alpha"] = "图示透明度"
	L["The alpha transparency of the icons"] = "图示的透明度"
	L["Icon"] = "图示"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龙蛋"
	L["Stars"] = "星星"
	L["Purple"] = "紫色"
	L["White"] = "白色"
	L["Mana Orb"] = "法力球"
	L["Cogwheel"] = "齿轮"
	L["Frost"] = "冰霜"
	L["Diamond"] = "钻石"
	L["Red"] = "红"
	L["Yellow"] = "黄色"
	L["Green"] = "绿色"
	L["Screw"] = "拧"
	L["Grey"] = "灰色"
	L["Options"] = "选项"
	L["Gersahl Greens"] = "基萨尔野菜"
	L["Gold Ring"] = "金戒指"
	L["Red Cross"] = "红十字"
	L["Undo"] = "解开"
	L["White Diamond"] = "白钻石"
	L["Copper Diamond"] = "铜钻石"
	L["Red Ring"] = "红环"
	L["Blue Ring"] = "蓝环"
	L["Green Ring"] = "绿色戒指"
	L["Show Coordinates"] = "显示坐标"
	L["Show Coordinates Description"] = "在世界地图和迷你地图上的工具提示中" ..ns.colour.highlight .."显示坐标"

elseif ns.locale == "zhTW" then
	L["Springfur Alpaca"] = "春裘羊駝"
	L["AddOn Description"] = "幫助你找尋" ..ns.colour.highlight .."黑色泥土"
	L["Icon settings"] = "圖標設置"
	L["Icon Scale"] = "圖示大小"
	L["The scale of the icons"] = "圖示的大小"
	L["Icon Alpha"] = "圖示透明度"
	L["The alpha transparency of the icons"] = "圖示的透明度"
	L["Icon"] = "圖示"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龍蛋"
	L["Stars"] = "星星"
	L["Purple"] = "紫色"
	L["White"] = "白色"
	L["Mana Orb"] = "法力球"
	L["Cogwheel"] = "齒輪"
	L["Frost"] = "霜"
	L["Diamond"] = "钻石"
	L["Red"] = "紅"
	L["Yellow"] = "黃色"
	L["Green"] = "綠色"
	L["Screw"] = "擰"
	L["Grey"] = "灰色"
	L["Options"] = "選項"
	L["Gersahl Greens"] = "基薩爾野菜"
	L["Gold Ring"] = "金戒指"
	L["Red Cross"] = "紅十字"
	L["Undo"] = "解開"
	L["White Diamond"] = "白鑽石"
	L["Copper Diamond"] = "銅鑽石"
	L["Red Ring"] = "紅環"
	L["Blue Ring"] = "藍環"
	L["Green Ring"] = "綠色戒指"
	L["Show Coordinates"] = "顯示坐標"
	L["Show Coordinates Description"] = "在世界地圖和迷你地圖上的工具提示中" ..ns.colour.highlight .."顯示坐標"
	
else
	if ns.locale == "enUS" then
		L["Grey"] = "Gray"
	end
	L["AddOn Description"] = "Helps you find the Dark Soil"
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
end

-- I use this for debugging
local function printPC( message )
	if message then
		DEFAULT_CHAT_FRAME:AddMessage( ns.colour.prefix ..L["Springfur Alpaca"] ..": " ..ns.colour.plaintext
			..message .."\124r" )
	end
end

-- Plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	local point = ns.points[mapFile] and ns.points[mapFile][coord]
	return point[1], point[2]
end

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local dataType = infoFromCoord(mapFile, coord)
	
	if dataType == "A" then
		GameTooltip:SetText(ns.colour.prefix ..L["Springfur Alpaca"])
	else
		GameTooltip:SetText( ns.colour.prefix ..L["Gersahl Greens"] )
	end

	if ns.db.showCoords == true then
		local mX, mY = HandyNotes:getXY(coord)
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( ns.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end

	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

do
	continents[ns.kalimdor] = true
	local function iterator(t, prev)
		if not t or ns.CurrentMap == ns.kalimdor then return end
		local coord, v = next(t, prev)
		local aId, completed, iconIndex
		while coord do
			if v then
				if v[2] and ns.author then
					return coord, nil, ns.textures[10],
							ns.db.icon_scale * ns.scaling[10], ns.db.icon_alpha
				elseif v[1] == "A" then
					return coord, nil, ns.textures[ns.db.icon_choice],
							ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
				else
					return coord, nil, ns.texturesSpecial[ns.db.icon_choiceSpecial],
							ns.db.icon_scale * ns.scalingSpecial[ns.db.icon_choiceSpecial], ns.db.icon_alpha
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

-- Interface -> Addons -> Handy Notes -> Plugins -> Springfur Alpaca options
ns.options = {
	type = "group",
	name = L["Springfur Alpaca"],
	desc = L["AddOn Description"],
	get = function(info) return ns.db[info[#info]] end,
	set = function(info, v)
		ns.db[info[#info]] = v
		pluginHandler:Refresh()
	end,
	args = {
		icon = {
			type = "group",
			-- Add a " " to force this to be before the first group. HN arranges alphabetically on local language
			name = " " ..L["Icon settings"],
			inline = true,
			args = {
				icon_scale = {
					type = "range",
					name = L["Icon Scale"],
					desc = L["The scale of the icons"],
					min = 0.25, max = 2, step = 0.01,
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
				icon_choice = {
					type = "range",
					name = L["Icon"],
					desc = "1 = " ..L["Phasing"] .."\n2 = " ..L["Raptor egg"] .."\n3 = " ..L["Stars"] .."\n4 = " ..L["Purple"] 
							.."\n5 = " ..L["White"] .."\n6 = " ..L["Mana Orb"] .."\n7 = " ..L["Cogwheel"] .."\n8 = " ..L["Frost"] 
							.."\n9 = " ..L["Diamond"] .."\n10 = " ..L["Red"] .."\n11 = " ..L["Yellow"] .."\n12 = " ..L["Green"] 
							.."\n13 = " ..L["Screw"] .."\n14 = " ..L["Grey"],
					min = 1, max = 14, step = 1,
					arg = "icon_choice",
					order = 4,
				},
			},
		},
		options = {
			type = "group",
			name = L["Options"],
			inline = true,
			args = {
				icon_choiceSpecial = {
					type = "range",
					name = L["Icon"] .." (" ..L["Gersahl Greens"] ..")",
					desc = "1 = " ..L["Gold Ring"] .."\n2 = " ..L["Red Cross"] .."\n3 = " ..L["Undo"] .."\n4 = " 
							..L["White Diamond"] .."\n5 = " ..L["Copper Diamond"] .."\n6 = " ..L["Red Ring"] 
							.."\n7 = " ..L["Blue Ring"] .."\n8 = " ..L["Green Ring"], 
					min = 1, max = 8, step = 1,
					arg = "icon_choiceSpecial",
					order = 5,
				},
				showCoords = {
					name = L["Show Coordinates"],
					desc = L["Show Coordinates Description"] 
							..ns.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 6,
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
			if coords then
				for coord, criteria in next, coords do			
					local mx, my = HandyNotes:getXY(coord)
					local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
					if cx and cy then
						ns.points[continentMapID] = ns.points[continentMapID] or {}
						ns.points[continentMapID][HandyNotes:getCoord(cx, cy)] = criteria
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("SpringfurAlpaca", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_AlpacaDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "SpringfurAlpaca")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_AlpacaDB", "AceEvent-3.0")