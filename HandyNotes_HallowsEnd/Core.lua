--[[
                                ----o----(||)----oo----(||)----o----

                                            Hallow's End

                                      v2.01 - 31st October 2022
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local myName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.texturesL = {}
ns.scalingL = {}
ns.texturesS = {}
ns.scalingS = {}
-- Orange theme
ns.colour = {}
ns.colour.prefix	= "\124cFFF87217" -- Pumpkin Orange
ns.colour.highlight = "\124cFFFFA500" -- Orange W3C
ns.colour.plaintext = "\124cFFFDD017" -- Bright Gold

local defaults = { profile = { icon_scale = 1.7, icon_alpha = 1, showCoords = true,
								removeDailies = true, removeSeasonal = true, removeEver = false,
								icon_tricksTreat = 11, icon_dailies = 10, icon_special = 15 } }
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
local next = _G.next

local HandyNotes = _G.HandyNotes

local _, _, _, version = GetBuildInfo()
ns.faction = UnitFactionGroup( "player" )
ns.name = UnitName( "player" ) or "Character"

continents[ 12 ] = true -- Kalimdor
continents[ 13 ] = true -- Eastern Kingdoms
continents[ 101 ] = true -- Outland
continents[ 113 ] = true -- Northrend
continents[ 203 ] = true -- Vashj'ir
continents[ 424 ] = true -- Pandaria
continents[ 572 ] = true -- Draenor
continents[ 619 ] = true -- Broken Isles
continents[ 875 ] = true -- Zandalar
continents[ 876 ] = true -- Kul Tiras
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
	L["Hallow's End"] = "Schlotternächte"
	L["AddOn Description"] = "Hilft bei der Schlotternächte-Weltereignis"	
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
	L["Hallow's End"] = "Halloween"
	L["AddOn Description"] = "Ayuda para los logros del Halloween"
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
	L["Hallow's End"] = "Sanssaint"
	L["AddOn Description"] = "Aide à l'événement mondial Sanssaint"
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
	L["Hallow's End"] = "Veglia delle Ombre"
	L["AddOn Description"] = "Assiste con l'evento mondiale Veglia delle Ombre"
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
	L["Hallow's End"] = "할로윈 축제"
	L["AddOn Description"] = "할로윈 축제 대규모 이벤트 지원"	
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
	L["Hallow's End"] = "Noturnália"
	L["AddOn Description"] = "Auxilia no evento mundial Noturnália"
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
	L["Hallow's End"] = "Тыквовин"
	L["AddOn Description"] = "Помогает с игровое событие Тыквовин"
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
	L["Hallow's End"] = "万圣节"
	L["AddOn Description"] = "协助万圣节活动"
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
	L["Hallow's End"] = "萬聖節"
	L["AddOn Description"] = "協助萬聖節活動"
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
	L["AddOn Description"] = "Help for the Noble Garden achievements"
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
end

local function printPC( message )
	if message then
		DEFAULT_CHAT_FRAME:AddMessage( ns.colour.prefix .."Hallow'sEnd" ..": " ..ns.colour.plaintext
			..message.. "\124r" )
	end
end

-- Plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	local point = ns.points[mapFile] and ns.points[mapFile][coord]
	return point[1], point[2], point[3], point[4]
end

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local aID, aIndex, aQuest, tip = infoFromCoord(mapFile, coord)
	local completed, aName, completedMe;
	local pName = UnitName( "player" ) or "Character"
	local bypassCoords = false
	
	if ( aID == "A" ) or ( aID == "N" ) or ( aID == "H" ) then
		GameTooltip:SetText( ns.colour.prefix ..aIndex )
		if ( aQuest == 0 ) then
			bypassCoords = true
		else
			completed = C_QuestLog.IsQuestFlaggedCompleted( math.abs( aQuest ) )
			if ( aQuest < 0 ) then
				GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "Daily Quest",
							( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
												or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
			else
				GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "This Season",
							( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
												or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
			end
		end	
	elseif ( aQuest == 0 ) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )										
	else
		_, aName, _, completed = GetAchievementInfo( aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		aName, _, completed = GetAchievementCriteriaInfo( aID, aIndex )
		GameTooltip:AddDoubleLine( ns.colour.highlight.. aName,
					( completed == true ) and ( "\124cFF00FF00" ..L["Ever Completed"] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Ever Completed"] .." (" ..pName ..")" ) )
		completed = C_QuestLog.IsQuestFlaggedCompleted( math.abs( aQuest ) )
		if ( aQuest < 0 ) then
			GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "Daily Quest",
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
		else
			GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "This Season",
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
		end
	end

 	if ( ( mapFile == 17 ) and ( C_Map.GetMapArtID( mapFile ) ~= 18 ) ) or -- Blasted Lands Testing was 18 or 628 
		( ( mapFile == 18 ) and ( C_Map.GetMapArtID( mapFile ) ~= 19 ) ) or -- Tirisfal Glades Testing was 19 or 628 
		( ( mapFile == 81 ) and ( C_Map.GetMapArtID( mapFile ) ~= 86 ) ) or -- Silithus Testing was 86 or 962 
		( ( mapFile == 62 ) and ( C_Map.GetMapArtID( mapFile ) ~= 67 ) ) then -- Darkshore Testing was 67 or 1176
		-- Theramore gave the same mapArtID
		GameTooltip:AddLine( "\124cFFFF0000Wrong map/quest phase. Speak to Zidormi" )
	end
	if ( tip ~= "" ) then
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

local function ShowConditionallyC( v1, v2, v3 )
	local completed;
	if ( ns.db.removeSeasonal == true ) then
		completed = C_QuestLog.IsQuestFlaggedCompleted( v3 )
		if ( completed == true ) then
			return false
		end
	elseif ( ns.db.removeEver == true ) then
		_, _, completed = GetAchievementCriteriaInfo( v1, v2 )
		if ( completed == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyA( v1 )
	local completedMe;
	if ( ns.db.removeSeasonal == true ) then
		_, _, _, _, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( v1 )
		if ( completedMe == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyS( v2 )
	local completed;
	if ( ns.db.removeSeasonal == true ) then
		completed = C_QuestLog.IsQuestFlaggedCompleted( v2 )
		if ( completed == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyD( v3 )
	local completed;
	if ( ns.db.removeDailies == true ) then
		completed = C_QuestLog.IsQuestFlaggedCompleted( v3 )
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
				if ( v[1] == "A" ) or ( v[1] == "N" ) or ( v[1] == "H" ) then
					if ( ( ns.faction == "Horde" ) and ( ( v[1] == "N" ) or ( v[1] == "H" ) ) ) or
					   ( ( ns.faction == "Alliance" ) and ( ( v[1] == "N" ) or ( v[1] == "A" ) ) ) then
						if ( v[3] == 0 ) then
							-- Permanent map marker with no related quest or achievement
							return coord, nil, ns.texturesS[ns.db.icon_special],
								ns.db.icon_scale * ns.scalingS[ns.db.icon_special], ns.db.icon_alpha
						elseif ( v[3] > 0 ) then
							if ShowConditionallyS( v[3] ) == true then
								return coord, nil, ns.texturesS[ns.db.icon_special],
									ns.db.icon_scale * ns.scalingS[ns.db.icon_special], ns.db.icon_alpha
							end
						else
							if ShowConditionallyD( -1*v[3] ) == true then
								return coord, nil, ns.texturesS[ns.db.icon_dailies],
									ns.db.icon_scale * ns.scalingS[ns.db.icon_dailies], ns.db.icon_alpha
							end
						end
					end
				elseif ( v[3] == 0 ) then -- Achievement with no relevant criteria to be bothered with
					if ShowConditionallyA( v[1] ) == true then
						return coord, nil, ns.texturesS[ns.db.icon_special],
							ns.db.icon_scale * ns.scalingS[ns.db.icon_special], ns.db.icon_alpha
					end
				elseif ( v[3] > 0 ) then -- Achievement with seasonal criteria
					if ( v[1] == 963 ) or ( v[1] == 966 ) or ( v[1] == 969 ) or
						( v[1] == 5836 ) or ( v[1] == 5837 ) or ( v[1] == 7601 ) then -- Tricks & Treats Alliance
						if ns.faction == "Alliance" then
							if ShowConditionallyC( v[1], v[2], v[3] ) == true then
								return coord, nil, ns.texturesL[ns.db.icon_tricksTreat], 
									ns.db.icon_scale * ns.scalingL[ns.db.icon_tricksTreat], ns.db.icon_alpha
							end
						end
					elseif ( v[1] == 965 ) or ( v[1] == 967 ) or ( v[1] == 968 ) or
							( v[1] == 5835 ) or ( v[1] == 5838 ) or ( v[1] == 7602 ) then -- Tricks & Treats Horde
						if ns.faction == "Horde" then
							if ShowConditionallyC( v[1], v[2], v[3] ) == true then
								return coord, nil, ns.texturesL[ns.db.icon_tricksTreat], 
									ns.db.icon_scale * ns.scalingL[ns.db.icon_tricksTreat], ns.db.icon_alpha
							end
						end
					end
				elseif ( ( v[1] == 1040 ) and ( ns.faction == "Alliance" ) ) or
						( ( v[1] == 1041 ) and ( ns.faction == "Horde" ) ) then
					if ShowConditionallyD( -1*v[3] ) == true then
						return coord, nil, ns.texturesS[ns.db.icon_dailies],
								ns.db.icon_scale * ns.scalingS[ns.db.icon_dailies], ns.db.icon_alpha
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

-- Interface -> Addons -> Handy Notes -> Plugins -> Noble Garden options
ns.options = {
	type = "group",
	name = L["Hallow's End"],
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
					desc = "The map marker will not appear if you\nhave completed the daily quest today",
					type = "toggle",
					width = "full",
					arg = "removeDailies",
					order = 5,
				},
				removeSeasonal = {
					name = "Remove T&T marker if completed this season by " ..ns.name,
					desc = "Achievement Candy Buckets are repeatable each season.\n"
							.."Note that there are miscellaneous buckets and quests\n"
							.."which are also seasonal and they are included here.",
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					order = 6,
				},
				removeEver = {
					name = "Remove T&T marker if ever completed on this account",
					desc = "Achievement Candy Buckets are repeatable each season.\n"
							.."Note that there are miscellaneous buckets and quests\n"
							.."which are also seasonal and they are included here.",
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
				icon_tricksTreat = {
					type = "range",
					name = L["Tricks and Treats"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Candy Swirl"] .."\n12 = " ..L["Pumpkin"] .."\n13 = " ..L["Evil Pumpkin"] 
							.."\n14 = " ..L["Bat"] .."\n15 = " ..L["Cat"] .."\n16 = " ..L["Ghost"] 
							.."\n17 = " ..L["Witch"], 
					min = 1, max = 17, step = 1,
					arg = "icon_tricksTreat",
					order = 8,
				},
				icon_dailies = {
					type = "range",
					name = L["Rotten Hallow Dailies"],
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = " ..L["Cogwheel"]
							.."\n9 = " ..L["Candy Swirl"] .."\n10 = " ..L["Pumpkin"] .."\n11 = " ..L["Evil Pumpkin"] 
							.."\n12 = " ..L["Bat"] .."\n13 = " ..L["Cat"] .."\n14 = " ..L["Ghost"] 
							.."\n15 = " ..L["Witch"], 
					min = 1, max = 15, step = 1,
					arg = "icon_dailies",
					order = 9,
				},
				icon_special = {
					type = "range",
					name = L["Extra Candy Buckets"],
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = " ..L["Cogwheel"]
							.."\n9 = " ..L["Candy Swirl"] .."\n10 = " ..L["Pumpkin"] .."\n11 = " ..L["Evil Pumpkin"] 
							.."\n12 = " ..L["Bat"] .."\n13 = " ..L["Cat"] .."\n14 = " ..L["Ghost"] 
							.."\n15 = " ..L["Witch"], 
					min = 1, max = 15, step = 1,
					arg = "icon_special",
					order = 10,
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
			-- Maps here will not propagate upwards. Mostly for cities as I used lots of
			-- extra helpful markers which would unnecessarily clutter a continent map
			if ( map.mapID == 84 ) or -- Stormwind City
				( map.mapID == 85 ) or -- Orgrimmar
				( map.mapID == 87 ) or -- Ironforge
				( map.mapID == 89 ) or -- Darnassus
				( map.mapID == 90 ) or -- Undercity
				( map.mapID == 110 ) or -- Silvermoon City
				-- I wanted a set of Dalaran pins to appear in Crystalsong thus I need to
				-- avoid duplication on the Northrend map
				( map.mapID == 127 ) or -- Crystalsong Forest
				-- Necessary as they seem to be special cases
				( map.mapID == 97 ) or -- Azuremyst Isle
				( map.mapID == 57 ) then -- Teldrassil
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
					if ( v[1] == "A" ) or ( v[1] == "N" ) or ( v[1] == "H" ) then
						if ( ( ns.faction == "Horde" ) and ( ( v[1] == "N" ) or ( v[1] == "H" ) ) ) or
						   ( ( ns.faction == "Alliance" ) and ( ( v[1] == "N" ) or ( v[1] == "A" ) ) ) then
							if ( v[3] == 0 ) then
								AddToContinent()
							elseif ( v[3] > 0 ) then
								if ShowConditionallyS( v[3] ) == true then
									AddToContinent()
								end
							else
								if ShowConditionallyD( -1*v[3] ) == true then
									AddToContinent()
								end
							end
						end
					elseif ( v[3] == 0 ) then -- Achievement with no relevant criteria to be bothered with
						if ShowConditionallyA( v[1] ) == true then
							AddToContinent()
						end
					elseif ( v[3] > 0 ) then -- Achievement with seasonal criteria
						if ( v[1] == 963 ) or ( v[1] == 966 ) or ( v[1] == 969 ) or
							( v[1] == 5836 ) or ( v[1] == 5837 ) or ( v[1] == 7601 ) then -- Tricks & Treats Alliance
							if ns.faction == "Alliance" then
								if ShowConditionallyC( v[1], v[2], v[3] ) == true then
									AddToContinent()
								end
							end
						elseif ( v[1] == 965 ) or ( v[1] == 967 ) or ( v[1] == 968 ) or
								( v[1] == 5835 ) or ( v[1] == 5838 ) or ( v[1] == 7602 ) then -- Tricks & Treats Horde
							if ns.faction == "Horde" then
								if ShowConditionallyC( v[1], v[2], v[3] ) == true then
									AddToContinent()
								end
							end
						end
					elseif ( ( v[1] == 1040 ) and ( ns.faction == "Alliance" ) ) or
							( ( v[1] == 1041 ) and ( ns.faction == "Horde" ) ) then
						if ShowConditionallyD( -1*v[3] ) == true then
							AddToContinent()
						end
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("HallowsEnd", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_HallowsEndDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "HallowsEnd")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_HallowsEndDB", "AceEvent-3.0")