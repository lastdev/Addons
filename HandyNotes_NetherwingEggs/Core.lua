--[[
                                ----o----(||)----oo----(||)----o----

                                           Netherwing Eggs

                                      v1.14 - 18th January 2023
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local myName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
-- Purple theme
ns.colour = {}
ns.colour.prefix	= "\124cFF8258FA"
ns.colour.highlight = "\124cFFB19EFF"
ns.colour.plaintext = "\124cFF819FF7"

local defaults = { profile = { icon_scale = 1.4, icon_alpha = 0.8, icon_choice = 1, showCoords = true } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetSubZoneText = _G.GetSubZoneText
local IsControlKeyDown = _G.IsControlKeyDown
local IsIndoors = _G.IsIndoors
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local next = _G.next

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

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
	L["Netherwing Egg"] = "Ei der Netherschwingen"
	L["Netherwing Eggs"] = "Eier der Netherschwingen"
	L["The Not-So-Friendly Skies..."] = "Ein Schatten am Horizont"
	L["Please stand here, facing north"] = "Bitte hier stehen, nach Norden"
	L["Netherwing Egg"] = "Ei der Netherschwingen"
	L["Netherwing Mines"] = "Netherschwingenminen"
	L["AddOn Description"] = "Hilft dir, die " ..ns.colour.highlight
		.."Eier der Netherschwingen\124r zu finden"
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
	L["Show Coordinates"] = "Koordinaten anzeigen"
	L["Show Coordinates Description"] = "Zeigen sie die " ..ns.colour.highlight 
		.."koordinaten\124r in QuickInfos auf der Weltkarte und auf der Minikarte an"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["Netherwing Egg"] = "Huevo de Ala Abisal"
	L["Netherwing Eggs"] = "Huevos de Ala Abisal"
	L["The Not-So-Friendly Skies..."] = "Los cielos no tan amistosos..."
	L["Please stand here, facing north"] = "Por favor, quédate aquí, mirando hacia el norte"
	L["Netherwing Egg"] = "Huevo de Ala Abisal"
	L["Netherwing Mines"] = "Minas del Ala Abisal"
	L["AddOn Description"] = "Ayuda a encontrar los " ..ns.colour.highlight .."Huevos de Ala Abisal"
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
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Mostrar " ..ns.colour.highlight
		.."coordenadas\124r en información sobre herramientas en el mapa del mundo y en el minimapa"

elseif ns.locale == "frFR" then
	L["Netherwing Egg"] = "Œuf de l'Aile-du-Néant"
	L["Netherwing Eggs"] = "Œufs de l'Aile-du-Néant"
	L["The Not-So-Friendly Skies..."] = "Les cieux pas si cléments…"
	L["Please stand here, facing north"] = "S'il vous plaît, restez ici, face au nord"
	L["Netherwing Egg"] = "Œuf de l'Aile-du-Néant"
	L["Netherwing Mines"] = "Mines de l'Aile-du-Néant"
	L["AddOn Description"] = "Aide à trouver les " ..ns.colour.highlight .."Œufs de l'Aile-du-Néant"
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
	L["Show Coordinates"] = "Afficher les coordonnées"
	L["Show Coordinates Description"] = "Afficher " ..ns.colour.highlight
		.."les coordonnées\124r dans les info-bulles sur la carte du monde et la mini-carte"

elseif ns.locale == "itIT" then
	L["Netherwing Egg"] = "Uovo di Alafatua"
	L["Netherwing Eggs"] = "Uova di Alafatua"
	L["The Not-So-Friendly Skies..."] = "Cieli non molto amici..."
	L["Please stand here, facing north"] = "Si prega di stare qui, verso nord."
	L["Netherwing Egg"] = "Uovo di Alafatua"
	L["Netherwing Mines"] = "Miniere degli Alafatua"
	L["AddOn Description"] = "Aiuta a trovare le " ..ns.colour.highlight .."Uova di Alafatua"
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
	L["Show Coordinates"] = "Mostra coordinate"
	L["Show Coordinates Description"] = "Visualizza " ..ns.colour.highlight
		.."le coordinate\124r nelle descrizioni comandi sulla mappa del mondo e sulla minimappa"

elseif ns.locale == "koKR" then
	L["Netherwing Egg"] = "황천날개 알"
	L["Netherwing Eggs"] = "황천날개 알"
	L["The Not-So-Friendly Skies..."] = "하늘과 땅의 대립"
	L["Please stand here, facing north"] = "여기 북쪽을 향하여 서십시오."
	L["Netherwing Egg"] = "황천날개 알"
	L["Netherwing Mines"] = "황천날개 광산"
	L["AddOn Description"] = ns.colour.highlight .."황천날개 알\124r 를 찾을 수 있도록 도와줍니다"
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
	L["Show Coordinates"] = "좌표 표시"
	L["Show Coordinates Description"] = "세계지도 및 미니지도의 도구 설명에 좌표를 표시합니다."

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Netherwing Egg"] = "Ovo da Asa Etérea"
	L["Netherwing Eggs"] = "Ovos da Asa Etérea"
	L["The Not-So-Friendly Skies..."] = "Viaje não-tão-bem-assim..."
	L["Please stand here, facing north"] = "Por favor fique aqui, virado para o norte."
	L["Netherwing Egg"] = "Ovo da Asa Etérea"
	L["Netherwing Mines"] = "Minas da Asa Etérea"
	L["AddOn Description"] = "Ajuda você a localizar " ..ns.colour.highlight .."Ovos da Asa Etérea"
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
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Exibir " ..ns.colour.highlight
		.."coordenadas\124r em dicas de ferramentas no mapa mundial e no minimapa"

elseif ns.locale == "ruRU" then
	L["Netherwing Egg"] = "Яйцо дракона из стаи Крыльев Пустоты"
	L["Netherwing Eggs"] = "Яйца дракона из стаи Крыльев Пустоты"
	L["The Not-So-Friendly Skies..."] = "Недружелюбные небеса"
	L["Please stand here, facing north"] = "Пожалуйста, встаньте здесь, лицом на север."
	L["Netherwing Egg"] = "Яйцо дракона из стаи Крыльев Пустоты"
	L["Netherwing Mines"] = "Крыльев Пустоты"
	L["AddOn Description"] = "Помогает найти " ..ns.colour.highlight
		.."Яйца дракона из стаи Крыльев Пустоты"
	L["Icon settings"] = "Настройки Значков"
	L["Icon Scale"] = "Масштаб Значок"
	L["The scale of the icons"] = "Масштаб для Значков"
	L["Icon Alpha"] = "Альфа Значок"
	L["The alpha transparency of the icons"] = "Альфа-прозрачность для Значков"
	L["Icon"] = "Значок"
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
	L["Show Coordinates"] = "Показать Координаты"
	L["Show Coordinates Description"] = "Отображает " ..ns.colour.highlight
		.."координаты\124r во всплывающих подсказках на карте мира и мини-карте"

elseif ns.locale == "zhCN" then
	L["Netherwing Egg"] = "灵翼龙卵"
	L["Netherwing Eggs"] = "灵翼龙卵"
	L["The Not-So-Friendly Skies..."] = "危险的天空"
	L["Please stand here, facing north"] = "请站在这里，面朝北方。"
	L["Netherwing Egg"] = "灵翼龙卵"
	L["Netherwing Mines"] = "灵翼矿洞"
	L["AddOn Description"] = "帮助你找寻" ..ns.colour.highlight .."灵翼龙卵"
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
	L["Show Coordinates"] = "显示坐标"
	L["Show Coordinates Description"] = "在世界地图和迷你地图上的工具提示中" ..ns.colour.highlight .."显示坐标"

elseif ns.locale == "zhTW" then
	L["Netherwing Egg"] = "靈翼龍卵"
	L["Netherwing Eggs"] = "靈翼龍卵"
	L["The Not-So-Friendly Skies..."] = "危險的天空"
	L["Please stand here, facing north"] = "請站在這裡，面朝北方。"
	L["Netherwing Egg"] = "靈翼龍卵"
	L["Netherwing Mines"] = "靈翼礦洞"
	L["AddOn Description"] = "幫助你找尋" ..ns.colour.highlight .."靈翼龍卵"
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
	L["Show Coordinates"] = "顯示坐標"
	L["Show Coordinates Description"] = "在世界地圖和迷你地圖上的工具提示中" ..ns.colour.highlight .."顯示坐標"
	
else
	if ns.locale == "enUS" then
		L["Grey"] = "Gray"
	end
	L["AddOn Description"] = "Helps you locate " ..ns.colour.highlight .."Netherwing Eggs"
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
end

-- I use this for debugging
local function printPC( message )
	if message then
		DEFAULT_CHAT_FRAME:AddMessage( ns.colour.prefix ..L["Netherwing Eggs"] ..": " ..ns.colour.plaintext 
			..message .."\124r" )
	end
end

-- Plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	local point = ns.points[mapFile] and ns.points[mapFile][coord]
	return point[1], point[2], point[3]
end

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local mvq, note, author = infoFromCoord(mapFile, coord)

	if mvq == "Q" then
		GameTooltip:SetText( ns.colour.prefix ..L["The Not-So-Friendly Skies..."] )
		GameTooltip:AddLine( L["Please stand here, facing north"] )	
	else
		GameTooltip:SetText( ns.colour.prefix ..L["Netherwing Egg"] )
		GameTooltip:AddLine( L[note] )
	end
	
	if ns.db.showCoords == true then
		local mX, mY = HandyNotes:getXY(coord)
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( ns.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end

	if TomTom then
		GameTooltip:AddLine("Right-click to set a waypoint", 1, 1, 1)
		GameTooltip:AddLine("Control-Right-click to set waypoints to every |cFF0070DENetherwing Egg|r", 1, 1, 1)
	end

	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

local function createWaypoint(mapID, coord)
	local x, y = HandyNotes:getXY(coord)
	TomTom:AddWaypoint(mapID, x, y, { title = L["Netherwing Egg"], persistent = nil, minimap = true, world = true })
end

local function createAllWaypoints()
	for mapFile, coords in next, ns.points do
		if not continents[mapFile] then
			for coord in next, coords do
				if coord then
					createWaypoint(mapFile, coord)
				end
			end
		end
	end
	TomTom:SetClosestWaypoint()
end

function pluginHandler:OnClick(button, down, mapFile, coord)
	if TomTom and button == "RightButton" and not down then
		if IsControlKeyDown() then
			createAllWaypoints()
		else
			createWaypoint(mapFile, coord)
		end
	end
end

do
	local _, _, _, version = GetBuildInfo()
	ns.outland = (version < 40000) and 1945 or 101
	ns.valley = (version < 40000) and 1948 or 104
	continents[ns.outland] = true

    local bucket = CreateFrame("Frame")
    bucket.elapsed = 0
    bucket:SetScript("OnUpdate", function(self, elapsed)
        self.elapsed = self.elapsed + elapsed
        if self.elapsed > 1.5 then
            self.elapsed = 0
			local insideMine = ( GetSubZoneText() == L["Netherwing Mines"] and IsIndoors() ) and true or false
			if ns.insideMine == nil then
				ns.insideMine = insideMine
			elseif ns.insideMine ~= insideMine then
				ns.insideMine = insideMine
				pluginHandler:Refresh()
			end
        end
    end)

	if ns.insideMine == nil then
		ns.insideMine = ( GetSubZoneText() == L["Netherwing Mines"] and IsIndoors() ) and true or false
	end

	local function iterator(t, prev)
		if not t or ns.CurrentMap == ns.outland then return end
		local coord, v = next(t, prev)
		while coord do
			if v then
				if v[1] == "M" then
					if ns.insideMine == true then
						return coord, nil, ns.textures[ns.db.icon_choice], 
								ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
					end
				else
					if ns.insideMine == false then
						return coord, nil, ns.textures[ns.db.icon_choice],
								ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
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

-- Interface -> Addons -> Handy Notes -> Plugins -> Netherwing Eggs options
ns.options = {
	type = "group",
	name = L["Netherwing Eggs"],
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
					min = 0.5, max = 3, step = 0.1,
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
			},
		},
		icon = {
			type = "group",
			name = L["Icon Selection"],
			inline = true,
			args = {
				icon_choice = {
					type = "range",
					name = L["Icon"],
					desc = "1 = " ..L["Phasing"] .."\n2 = " ..L["Raptor egg"] .."\n3 = " ..L["Stars"] .."\n4 = " ..L["Purple"] 
							.."\n5 = " ..L["White"] .."\n6 = " ..L["Mana Orb"] .."\n7 = " ..L["Cogwheel"] .."\n8 = " ..L["Frost"] 
							.."\n9 = " ..L["Diamond"] .."\n10 = " ..L["Red"] .."\n11 = " ..L["Yellow"] .."\n12 = " ..L["Green"] 
							.."\n13 = " ..L["Screw"] .."\n14 = " ..L["Grey"] .."\n15 = " ..L["Netherwing Egg"],
					min = 1, max = 15, step = 1,
					arg = "icon_choice",
					order = 5,
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
	HandyNotes:RegisterPluginDB("NetherwingEggs", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_NetherwingEggsDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "NetherwingEggs")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_NetherwingEggsDB", "AceEvent-3.0")