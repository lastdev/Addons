--[[
                                ----o----(||)----oo----(||)----o----

                                             EA Pandaria

                                      v1.30 - 10th October 2023
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
-- Pastel Orange Theme
ns.colour = {}
ns.colour.prefix	= "\124cFFFF7F50" -- Coral
ns.colour.highlight = "\124cFFE78A61" -- Tangerine
ns.colour.plaintext = "\124cFFFFCBA4" -- Deep Peach

--ns.author = true

local defaults = { profile = { icon_scale = 1.7, icon_alpha = 1, showCoords = true,
							removeChar = true, removeEver = false, showWeekly = false,
							icon_EAPandaria = 11, icon_EATreasure = 12, icon_EARiches = 13,
							icon_EAGlorious = 14, icon_EALove = 15, icon_champion = 9,
							icon_eyesGround = 10, icon_pilgrimage = 8, icon_killingTime = 6, } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetItemNameByID = C_Item.GetItemNameByID
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local UnitName = UnitName
--local GetMapInfo = C_Map.GetMapInfo -- phase checking during testing
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local gsub = string.gsub
local next = _G.next

local HandyNotes = _G.HandyNotes

ns.name = UnitName( "player" ) or "Character"
ns.faction = UnitFactionGroup( "player" )

continents[ 424 ] = true -- Pandaria
continents[ 947 ] = true -- Azeroth

ns.achievements = { --Lore Objects
					6716, 6754, 6846, 6847, 6850, 6855, 6856, 6857, 6858,
					-- NPCs
					6350, 7439,				
					-- Treasures
					7284, 7997,
					-- Miscellaneous Discovery
					7230, 7329, 7381, 7518, 7932, 8078,
					-- Thunder Isle
					8049, 8050, 8051, 8103, 
					-- Timeless Isle
					8535, 8712, 8714, 8724, 8725, 8726, 8727, 8729, 8730, 8743, 8784 }

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
	L["Achievement"] = "Erfolg"
	L["Pink"] = "Rosa"
	L["AddOn Description"] = "Alle Fundorte der Erkundungserfolge von Pandaria"
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
	L["Green"] = "Grün"
	L["Cross"] = "Kreuz"
	L["Diamond"] = "Diamant"
	L["Frost"] = "Frost"
	L["Cogwheel"] = "Zahnrad"
	L["White"] = "Weiß"
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
	L["Achievement"] = "Logro"
	L["Gold"] = "Oro"
	L["Pink"] = "Rosa"
	L["AddOn Description"] = "Todas las ubicaciones de logros de exploración de Pandaria"
	L["Character"] = "Personaje"
	L["Account"] = "la Cuenta"
	L["Completed"] = "Completado"
	L["Not Completed"] = ns.locale == "esES" and "Sin Completar" or "Incompleto"
	L["Icon Selection"] = "Selección de iconos"
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
	L["Purple"] = "Púrpura"
	L["Yellow"] = "Amarillo"
	L["Grey"] = "Gris"
	L["Mana Orb"] = "Orbe de maná"
	L["Phasing"] = "Sincronización"	
	L["Raptor egg"] = "Huevo de raptor"	
	L["Stars"] = "Estrellas"
	L["NPC"] = "PNJ"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Mostrar " ..ns.colour.highlight
		.."coordenadas\124r en información sobre herramientas en el mapa del mundo y en el minimapa"

elseif ns.locale == "frFR" then
	L["Pandaria"] = "Pandarie"
	L["Achievement"] = "Haut fait"
	L["Gold"] = "Or"
	L["Pink"] = "Rose"
	L["AddOn Description"] = "Tous les emplacements des réalisations d'exploration de Pandarie"
	L["Character"] = "Personnage"
	L["Account"] = "le Compte"
	L["Completed"] = "Achevé"
	L["Not Completed"] = "Non achevé"
	L["Icon Selection"] = "Sélection d'icônes"
	L["Icon Scale"] = "Echelle de l’icône"
	L["The scale of the icons"] = "L'échelle des icônes"
	L["Icon Alpha"] = "Transparence de l'icône"
	L["The alpha transparency of the icons"] = "La transparence des icônes"
	L["Icon"] = "L'icône"
	L["Options"] = "Options"
	L["Gold"] = "Or"
	L["Red"] = "Rouge"
	L["Blue"] = "Bleue"
	L["Green"] = "Vert"
	L["Ring"] = "Bague"
	L["Cross"] = "Traverser"
	L["Diamond"] = "Diamant"
	L["Frost"] = "Givre"
	L["Cogwheel"] = "Roue dentée"
	L["White"] = "Blanc"
	L["Purple"] = "Violet"
	L["Yellow"] = "Jaune"
	L["Grey"] = "Gris"
	L["Mana Orb"] = "Orbe de mana"
	L["Phasing"] = "Synchronisation"
	L["Raptor egg"] = "Œuf de Rapace"
	L["Stars"] = "Étoiles"
	L["NPC"] = "PNJ"
	L["Show Coordinates"] = "Afficher les coordonnées"
	L["Show Coordinates Description"] = "Afficher " ..ns.colour.highlight
		.."les coordonnées\124r dans les info-bulles sur la carte du monde et la mini-carte"

elseif ns.locale == "itIT" then
	L["Achievement"] = "Impresa"
	L["Gold"] = "Oro"
	L["Pink"] = "Rosa"
	L["AddOn Description"] = "Tutte le posizioni degli obiettivi di esplorazione di Pandaria"
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
	L["Pandaria"] = "판다리아"
	L["Achievement"] = "업적"
	L["Gold"] = "금"
	L["Pink"] = "분홍색"
	L["AddOn Description"] = "모든 판다리아 탐험 업적 위치"
	L["Character"] = "캐릭터"
	L["Account"] = "계정"
	L["Completed"] = "완료"
	L["Not Completed"] = "미완료"
	L["Icon Selection"] = "아이콘 선택"
	L["Icon Scale"] = "아이콘 크기 비율"
	L["The scale of the icons"] = "아이콘의 크기 비율입니다"
	L["Icon Alpha"] = "아이콘 투명도"
	L["The alpha transparency of the icons"] = "아이콘의 투명도입니다"
	L["Icon"] = "아이콘"
	L["Options"] = "설정"
	L["Gold"] = "금"
	L["Red"] = "빨간"
	L["Blue"] = "푸른"
	L["Green"] = "녹색"
	L["Ring"] = "반지"
	L["Cross"] = "십자가"
	L["Diamond"] = "다이아몬드"
	L["Frost"] = "냉기"
	L["Cogwheel"] = "톱니 바퀴"
	L["White"] = "화이트"
	L["Purple"] = "보라색"
	L["Yellow"] = "노랑"
	L["Grey"] = "회색"
	L["Mana Orb"] = "마나 보주"
	L["Phasing"] = "동기화 중"
	L["Raptor egg"] = "랩터의 알"
	L["Stars"] = "별"
	L["Show Coordinates"] = "좌표 표시"
	L["Show Coordinates Description"] = "세계지도 및 미니지도의 도구 설명에 좌표를 표시합니다."
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Pandaria"] = "Pandária"
	L["Achievement"] = "Conquista"
	L["Gold"] = "Ouro"
	L["Pink"] = "Rosa"
	L["AddOn Description"] = "Todos os locais de conquistas da exploração de Pandária"
	L["Character"] = "Personagem"
	L["Account"] = "à Conta"
	L["Completed"] = "Concluído"
	L["Not Completed"] = "Não Concluído"
	L["Icon Selection"] = "Seleção de ícones"
	L["Icon Scale"] = "Escala de Ícone"
	L["The scale of the icons"] = "A escala dos ícones"
	L["Icon Alpha"] = "Ícone Alpha"
	L["The alpha transparency of the icons"] = "A transparência alfa dos ícones"
	L["Icon"] = "Ícone"
	L["Options"] = "Opções"
	L["Gold"] = "Ouro"
	L["Red"] = "Vermelho"
	L["Blue"] = "Azul"
	L["Green"] = "Verde"
	L["Ring"] = "Anel"
	L["Cross"] = "Cruz"
	L["Diamond"] = "Diamante"
	L["Frost"] = "Gélido"
	L["Cogwheel"] = "Roda dentada"
	L["White"] = "Branco"
	L["Purple"] = "Roxa"
	L["Yellow"] = "Amarelo"
	L["Grey"] = "Cinzento"
	L["Mana Orb"] = "Orbe de Mana"
	L["Phasing"] = "Sincronização"
	L["Raptor egg"] = "Ovo de raptor"
	L["Stars"] = "Estrelas"
	L["NPC"] = "PNJ"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Exibir " ..ns.colour.highlight
		.."coordenadas\124r em dicas de ferramentas no mapa mundial e no minimapa"

elseif ns.locale == "ruRU" then
	L["Pandaria"] = "Пандарии"
	L["Achievement"] = "Достижение"
	L["Gold"] = "Золото"
	L["Pink"] = "Розовый"
	L["AddOn Description"] = "Все локации достижений исследования Пандарии"
	L["Character"] = "Персонажа"
	L["Account"] = "Счет"
	L["Completed"] = "Выполнено"
	L["Not Completed"] = "Не Выполнено"
	L["Icon Selection"] = "Выбор Значка"
	L["Icon Scale"] = "Масштаб Значка"
	L["The scale of the icons"] = "Масштаб для Значков"
	L["Icon Alpha"] = "Альфа Значок"
	L["The alpha transparency of the icons"] = "Альфа-прозрачность Значков"
	L["Icon"] = "Альфа Значок"
	L["Options"] = "Параметры"
	L["Gold"] = "Золото"
	L["Red"] = "Красный"
	L["Blue"] = "Синий"
	L["Green"] = "Зеленый"
	L["Ring"] = "Звенеть"
	L["Cross"] = "Крест"
	L["Diamond"] = "Ромб"
	L["Frost"] = "Лед"
	L["Cogwheel"] = "Зубчатое колесо"
	L["White"] = "белый"
	L["Purple"] = "Пурпурный"
	L["Yellow"] = "Желтый"
	L["Grey"] = "Серый"
	L["Mana Orb"] = "Cфера маны"
	L["Phasing"] = "Синхронизация"
	L["Raptor egg"] = "Яйцо ящера"
	L["Stars"] = "Звезды"
	L["Show Coordinates"] = "Показать Координаты"
	L["Show Coordinates Description"] = "Отображает " ..ns.colour.highlight
		.."координаты\124r во всплывающих подсказках на карте мира и мини-карте"

elseif ns.locale == "zhCN" then
	L["Pandaria"] = "潘达利"
	L["Achievement"] = "成就"
	L["Gold"] = "金子"
	L["Pink"] = "粉色的"
	L["AddOn Description"] = "潘达利亚所有探索成就地点"
	L["Character"] = "角色"
	L["Account"] = "账号"
	L["Completed"] = "已完成"
	L["Not Completed"] = "未完成"
	L["Icon Selection"] = "图标选择"
	L["Icon Scale"] = "图示大小"
	L["The scale of the icons"] = "图示的大小"
	L["Icon Alpha"] = "图示透明度"
	L["The alpha transparency of the icons"] = "图示的透明度"
	L["Icon"] = "图示"
	L["Options"] = "选项"
	L["Gold"] = "金子"
	L["Red"] = "红"
	L["Blue"] = "蓝"
	L["Green"] = "绿色"
	L["Ring"] = "戒指"
	L["Cross"] = "叉"
	L["Diamond"] = "钻石"
	L["Frost"] = "冰霜"
	L["Cogwheel"] = "齿轮"
	L["White"] = "白色"
	L["Purple"] = "紫色"
	L["Yellow"] = "黄色"
	L["Grey"] = "灰色"
	L["Mana Orb"] = "法力球"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龙蛋"
	L["Stars"] = "星星"
	L["Show Coordinates"] = "显示坐标"
	L["Show Coordinates Description"] = "在世界地图和迷你地图上的工具提示中" ..ns.colour.highlight .."显示坐标"

elseif ns.locale == "zhTW" then
	L["Pandaria"] = "潘達利"
	L["Achievement"] = "成就"
	L["Gold"] = "金子"
	L["Pink"] = "粉色的"
	L["AddOn Description"] = "潘達利亞所有探索成就地點"
	L["Character"] = "角色"
	L["Account"] = "賬號"
	L["Completed"] = "完成"
	L["Not Completed"] = "未完成"
	L["Icon Selection"] = "圖標選擇"
	L["Icon Scale"] = "圖示大小"
	L["The scale of the icons"] = "圖示的大小"
	L["Icon Alpha"] = "圖示透明度"
	L["The alpha transparency of the icons"] = "圖示的透明度"
	L["Icon"] = "圖示"
	L["Options"] = "選項"
	L["Gold"] = "金子"
	L["Red"] = "紅"
	L["Blue"] = "藍"
	L["Green"] = "綠色"
	L["Ring"] = "戒指"
	L["Cross"] = "叉"
	L["Diamond"] = "钻石"
	L["Frost"] = "霜"
	L["Cogwheel"] = "齒輪"
	L["White"] = "白色"
	L["Purple"] = "紫色"
	L["Yellow"] = "黃色"
	L["Grey"] = "灰色"
	L["Mana Orb"] = "法力球"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龍蛋"
	L["Show Coordinates"] = "顯示坐標"
	L["Show Coordinates Description"] = "在世界地圖和迷你地圖上的工具提示中" ..ns.colour.highlight .."顯示坐標"
	
else
	if ns.locale == "enUS" then
		L["Grey"] = "Gray"
	end
	L["Treasure"] = "Is another Man's Treasure"
	L["Riches"] = "Riches of Pandaria"
	L["AddOn Description"] = "All Pandaria exploration achievement locations"
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[mapFile] and ns.points[mapFile][coord]

	local pName = UnitName( "player" ) or L["Character"]
	local completed, aName, completedMe, quantity, reqQuantity;
	local bypassCoords = false
	local showTip = true
	local compA, compC, notYet = "\n", "\n", "\n"
	
	if pin.aList then
		for _,aID in ipairs( ns.achievements ) do
			_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( aID )
			if ( completedMe == true ) then
				compC = compC ..aName .."\n"
			elseif ( completed == true ) then
				compA = compA ..aName .."\n"
			else
				notYet = notYet ..aName .."\n"
			end
		end
		GameTooltip:AddLine( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..pName ..")"
						..ns.colour.plaintext ..compC .."\n")
		GameTooltip:AddLine( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..L[ "Account" ] ..")"
						..ns.colour.plaintext ..compA .."\n")
		GameTooltip:AddLine( "\124cFFFF0000" ..L[ "Not Completed" ]
						..ns.colour.plaintext ..notYet )
		bypassCoords = true
		showTip = false
		
	elseif not pin.aID then
		bypassCoords = true		
	else
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( pin.aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight,
			( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..L[ "Account" ] ..")" ) 
								or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..L[ "Account" ] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
			( completedMe == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..pName ..")" ) 
								or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..pName ..")" ) )
		if ( pin.aID == 8078 ) then -- Zul Again
			for i = 1, 2 do
				aName, _, completed, quantity, reqQuantity = GetAchievementCriteriaInfo( pin.aID, i )
				GameTooltip:AddDoubleLine( ns.colour.highlight ..quantity .."/" ..reqQuantity .." " ..aName,
					( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..pName ..")" ) )
			end
		elseif ( pin.aID == 8784 ) or ( pin.aID == 8724 ) then -- Timeless Legends & Pilgrimage
			for i = 1, 4 do
				aName, _, completed = GetAchievementCriteriaInfo( pin.aID, i )
				GameTooltip:AddDoubleLine( ns.colour.highlight ..aName,
					( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..pName ..")" ) )
			end
		end
		if pin.aIndex then
			aName, _, completed = GetAchievementCriteriaInfo( pin.aID, pin.aIndex )
			GameTooltip:AddDoubleLine( ns.colour.highlight ..aName,
				( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..pName ..")" ) 
									or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..pName ..")" ) )
			if ( pin.aID == 7932 ) then -- I'm In Your Base Killing Your Dudes
				completed = IsQuestFlaggedCompleted( ( ns.faction == "Alliance" ) and 32246 or 32249 )
				if ( completed == false ) then
					GameTooltip:AddLine( "\n\124cFFFF0000" .."Prerequisite: " ..ns.colour.highlight 
						.."Go to your base in the Vale of Eternal Blossoms and\nspeak to "
						..( ( ns.faction == "Alliance" ) and "Lyalia" or "Sunwalker Dezco" )
						.." who will give you the quest \"Meet the Scout\"" )
				else
					completed = IsQuestFlaggedCompleted( ( ns.faction == "Alliance" ) and 32247 or 32250 )
					if ( completed == false ) then
						GameTooltip:AddLine( "\n\124cFFFF0000" .."Prerequisite: " ..ns.colour.highlight 
							.."Go to Krasarang Wilds and speak to "
							..( ( ns.faction == "Alliance" ) and "King Varian Wrynn" 
															or "Garrosh Hellscream" )
							.."\nwho will give you the quest \""
							..( ( ns.faction == "Alliance" ) and "A King Among Men" 
															or "The Might of the Warchief" ) .."\"")
					else
						completed = IsQuestFlaggedCompleted( ( ns.faction == "Alliance" ) and 32109 or 32108 )
						if ( completed == false ) then
							GameTooltip:AddLine( "\n\124cFFFF0000" .."Prerequisite: " ..ns.colour.highlight 
								.."Go to Krasarang Wilds and speak to "
								..( ( ns.faction == "Alliance" ) and "King Varian Wrynn" 
																or "Garrosh Hellscream" )
								.."\nwho will give you the quest \""
								..( ( ns.faction == "Alliance" ) and "Lion's Landing" 
																or "Domination Point" ) .."\"")
						end
					end
				end
			end
		end
		if pin.aQuest then
			completed = IsQuestFlaggedCompleted( pin.aQuest )
			local itemName = pin.item and ( GetItemNameByID( pin.item ) or pin.item ) or ( pin.qName or " " )
			GameTooltip:AddDoubleLine( ns.colour.highlight ..itemName,
				( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
									or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
		end
	end
	
	if ns.author and pin.author then
		GameTooltip:AddLine( ns.colour.highlight ..L[ pin.author ] )
	end
	
	if ( showTip == true ) and pin.tip then
		GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
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

local function ShowConditionallyE( aID )
	local completed;
	if ( ns.db.removeEver == true ) then
		_, _, _, completed = GetAchievementInfo( aID )
		if ( completed == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyC( aID, aIndex )
	local completed;
	if ( ns.db.removeChar == true ) then
		if aIndex then
			_, _, completed = GetAchievementCriteriaInfo( aID, aIndex )
		else
			_, _, _, _, _, _, _, _, _, _, _, _, completed = GetAchievementInfo( aID )
		end
		if ( completed == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyQ( aQuest )
	local completed;
	if ( ns.db.removeChar == true ) then
		if aQuest then
			completed = IsQuestFlaggedCompleted( aQuest )
			if ( completed == true ) then
				return false
			end
		end
	end
	return true
end

do	
	local function iterator(t, prev)
		if not t then return end
		local coord, pin = next(t, prev)
		while coord do
			if pin then
				if ns.author and pin.author then
					return coord, nil, ns.textures[ 4 ],
						ns.db.icon_scale * ns.scaling[ 4 ], ns.db.icon_alpha
				elseif pin.aList then
					return coord, nil, ns.textures[ ns.db.icon_EAPandaria ],
						ns.db.icon_scale * ns.scaling[ns.db.icon_EAPandaria ] * 2, ns.db.icon_alpha
				elseif not pin.aID then
					return coord, nil, ns.textures[ ns.db.icon_EAPandaria ],
						ns.db.icon_scale * ns.scaling[ ns.db.icon_EAPandaria ] *2, ns.db.icon_alpha
				elseif ( ShowConditionallyE( pin.aID ) == true ) then
					if ( pin.aID == 6350 ) then -- To All the Squirrels I Once Caressed?
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_EALove ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_EALove ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 7284 ) or ( pin.aID == 8729 ) then
						-- Is Another Man's Treasure and Treasure, Treasure Everywhere
						if ( ShowConditionallyQ( pin.aQuest ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_EATreasure ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_EATreasure ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 7439 ) then -- Glorious
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_EAGlorious ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_EAGlorious ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 7932 ) then -- I'm In Your Base Killing Your Dudes
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) 
								and ( ns.faction == pin.faction ) then
							if pin.aQuest then
								if ( ShowConditionallyQ( pin.aQuest ) == true ) then
									return coord, nil, ns.textures[ ns.db.icon_killingTime ],
										ns.db.icon_scale * ns.scaling[ ns.db.icon_killingTime ], ns.db.icon_alpha
								end
							else
								return coord, nil, ns.textures[ ns.db.icon_killingTime ],
									ns.db.icon_scale * ns.scaling[ ns.db.icon_killingTime ], ns.db.icon_alpha
							end
						end
					elseif ( pin.aID == 7997 ) then --  Riches of Pandaria
						if ( ShowConditionallyQ( pin.aQuest ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_EARiches ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_EARiches ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 8712 ) then -- KillingTime
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_killingTime ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_killingTime ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 8714 ) then -- Timeless Champion
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_champion ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_champion ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 8724 ) then -- Pilgrimage / Time-Lost Shrines
						if ( ShowConditionallyC( pin.aID ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_pilgrimage ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_pilgrimage ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 8725 ) then -- Eyes on the Ground
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_eyesGround ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_eyesGround ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 8726 ) or ( pin.aID == 8727 ) or ( pin.aID == 8743 ) then
						-- Extreme Treasure Hunter, Where There's Pirates, There's Booty, Zarhym Altogether
						if ( ns.db.showWeekly == true ) then
							if ( ShowConditionallyQ( pin.aQuest ) == true ) then
								return coord, nil, ns.textures[ ns.db.icon_EAGlorious ],
									ns.db.icon_scale * ns.scaling[ ns.db.icon_EAGlorious ], ns.db.icon_alpha
							end
						elseif ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_EAGlorious ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_EAGlorious ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 8730 ) then -- Rolo's Riddle
						if ( ShowConditionallyQ( pin.aQuest ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_EAPandaria ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_EAPandaria ], ns.db.icon_alpha
						end
					elseif ( pin.aID == 8535 ) then -- Celestial Challenge
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_EAGlorious ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_EAGlorious ], ns.db.icon_alpha
						elseif ( ns.db.showWeekly == true ) then
							if ( ShowConditionallyQ( pin.aQuest ) == true ) then
								return coord, nil, ns.textures[ ns.db.icon_EAGlorious ],
									ns.db.icon_scale * ns.scaling[ ns.db.icon_EAGlorious ], ns.db.icon_alpha
							end
						end
					elseif ( pin.aID == 8784 ) then -- Timeless Legends
						if ( ShowConditionallyC( pin.aID ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_EARiches ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_EARiches ], ns.db.icon_alpha
						end
					elseif ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
						-- 8078 Zul Again, 7329 Pandaren Cuisine, etc
						if pin.faction then
							if ( ns.faction == pin.faction ) then
								return coord, nil, ns.textures[ ns.db.icon_EAPandaria ],
									ns.db.icon_scale * ns.scaling[ ns.db.icon_EAPandaria ], ns.db.icon_alpha
							end
						else
							return coord, nil, ns.textures[ ns.db.icon_EAPandaria ],
								ns.db.icon_scale * ns.scaling[ ns.db.icon_EAPandaria ], ns.db.icon_alpha
						end
					end
				end
			end
			coord, pin = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> EA: Pandaria options
ns.options = {
	type = "group",
	name = L["EA Pandaria"],
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
				removeChar = {
					name = "Remove the pin if the criteria has been completed by " ..ns.name,
					desc = "\nThis is for each criteria as you progress.\n\n"
							.."Note that for \"Is Another Man's Treasure\" you only need 20 items.\n"
							.."The excess items will still appear on the map. Similarly, all the\n"
							.."Moss-Covered Chests on the Timeless Isle will still be shown",
					type = "toggle",
					width = "full",
					arg = "removeChar",
					order = 5,
				},
				showWeekly = {
					name = "But allow the pin to reappear if it is a repeatable quest objective",
					desc = "\nSome of the Timeless Isle achievements require you to complete a \n"
						.."few weekly/daily quests. Check this option to show a pin if the\n"
						.."quest is available again",
					type = "toggle",
					width = "full",
					arg = "showWeekly",
					order = 6,
				},
				removeEver = {
					name = "Remove the pin if ever fully completed on this account",
					desc = "\nIf any of your characters has completed the achievement\n"
							.."then all markers for the achievement will be removed.\n\n"
							.."The two above settings will also be ignored",
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
				icon_EAPandaria = {
					type = "range",
					name = L["Zul Again, Summary, Etc"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"], 
					min = 1, max = 14, step = 1,
					arg = "icon_EAPandaria",
					order = 8,
				},
				icon_EATreasure = {
					type = "range",
					name = L["Treasure"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"] .."\n\n"
							..ns.colour.highlight .."\"Is Another Man's Treasure\"" ..ns.colour.plaintext
							.." and\n" ..ns.colour.highlight .."\"Treasure, Treasure Everywhere\"", 
					min = 1, max = 14, step = 1,
					arg = "icon_EATreasure",
					order = 9,
				},
				icon_EARiches = {
					type = "range",
					name = L["Riches & Legends"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"] .."\n\n"
							..ns.colour.highlight .."\"Riches of Pandaria\"" ..ns.colour.plaintext
							.." and\n" ..ns.colour.highlight .."\"Timeless Legends\"", 
					min = 1, max = 14, step = 1,
					arg = "icon_EARiches",
					order = 10,
				},
				icon_EAGlorious = {
					type = "range",
					name = L["Glorious & TI Repeatables"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"] .."\n\n"
							..ns.colour.highlight .."\"Glorious\"" ..ns.colour.plaintext ..", "
							..ns.colour.highlight .."\"Where There's\nPirates, There's Booty\""
							..ns.colour.plaintext ..",\n" ..ns.colour.highlight .."\"Extreme Treasure Hunter\""
							..ns.colour.plaintext ..",\n" ..ns.colour.highlight
							.."\"Zarhym Altogether\"" ..ns.colour.plaintext .." and\n"
							..ns.colour.highlight .."\"Celestial Challenge\"", 
					min = 1, max = 14, step = 1,
					arg = "icon_EAGlorious",
					order = 11,
				},
				icon_EALove = {
					type = "range",
					name = L["Squirrel /Love"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"]
							.."\n15 = " ..L["Love"], 
					min = 1, max = 15, step = 1,
					arg = "icon_EALove",
					order = 12,
				},
				icon_champion = {
					type = "range",
					name = L["Timeless Champion"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"], 
					min = 1, max = 14, step = 1,
					arg = "icon_champion",
					order = 13,
				},
				icon_eyesGround = {
					type = "range",
					name = L["Eyes on the Ground"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"], 
					min = 1, max = 14, step = 1,
					arg = "icon_eyesGround",
					order = 14,
				},
				icon_pilgrimage = {
					type = "range",
					name = L["Pilgrimage / Shrines"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"], 
					min = 1, max = 14, step = 1,
					arg = "icon_pilgrimage",
					order = 15,
				},
				icon_killingTime = {
					type = "range",
					name = L["Killing Time & Base"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"] .."\n\n"
							..ns.colour.highlight .."\"Killing Time\"" ..ns.colour.plaintext
							.." and\n" ..ns.colour.highlight .."\"I'm In Your Base Killing...\"",  
					min = 1, max = 14, step = 1,
					arg = "icon_killingTime",
					order = 16,
				},
			},
		},
	},
}

function HandyNotes_EAPandaria_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "EAPandaria" )
 end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			-- Maps here will not propagate upwards
			if ( map.mapID == 372 ) or -- Greenstone Quarry in The Jade Forest
				( map.mapID == 373 ) or -- Greenstone Quarry in The Jade Forest
				( map.mapID == 380 ) or -- Kun-Lai Summit - Howlingwind Cavern
				( map.mapID == 381 ) or -- Kun-Lai Summit - Pranksters' Hollow
				( map.mapID == 382 ) or -- Kun-Lai Summit - Knucklethump Hole
				( map.mapID == 383 ) or -- Kun-Lai Summit - The Deeper - Upper Deep
				( map.mapID == 384 ) or -- Kun-Lai Summit - The Deeper - Lower Deep
				( map.mapID == 385 ) or -- Kun-Lai Summit - Tomb of Conquerors
				( map.mapID == 389 ) or -- Townlong Steppes - Niuzao Catacombs
				( map.mapID == 391 ) or -- Shrine of Two Moons in Vale of Eternal Blossoms
				( map.mapID == 393 ) or -- Shrine of Seven Stars in Vale of Eternal Blossoms
				( map.mapID == 504 ) or -- Isle of Thunder
				( map.mapID == 505 ) or -- Lightning Vein Mine on the Isle of Thunder
				( map.mapID == 554 ) or -- Timeless Isle
				( map.mapID == 555 ) or -- Cavern of Lost Spirit on the Timeless Isle
				( map.mapID == 424 ) then -- Pandaria
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
					AddToContinent()
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("EAPandaria", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_EAPandariaDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "EAPandaria")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_EAPandariaDB", "AceEvent-3.0")