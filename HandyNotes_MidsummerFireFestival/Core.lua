--[[
                                ----o----(||)----oo----(||)----o----

                                       Midsummer Fire Festival

                                       v2.07 - 20th April 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
-- Orange/Yellow theme
ns.colour = {}
ns.colour.prefix	= "\124cFFFFA500" -- Orange
ns.colour.highlight = "\124cFFF6BE00" -- Deep Yellow
ns.colour.plaintext = "\124cFFFFF380" -- Corn Yellow

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								removeSeasonal = true, removeEver = false,
								iconHonor = 7, iconDesecrate = 10, iconThief = 11 } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetQuestObjectives = C_QuestLog.GetQuestObjectives
local GetTime = GetTime
local GetTitleForQuestID = C_QuestLog.GetTitleForQuestID
local IsOnQuest = C_QuestLog.IsOnQuest
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local UnitName = UnitName
--local GetMapInfo = C_Map.GetMapInfo -- phase checking during testing
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local gsub = string.gsub
local next = _G.next
local pairs = _G.pairs
local HandyNotes = _G.HandyNotes

_, _, _, ns.version = GetBuildInfo()

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
continents[ 1978 ] = true -- Dragon Isles

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Localisation
ns.locale = GetLocale()
local L = {}
setmetatable( L, { __index = function( L, key ) return key end } )
local realm = GetNormalizedRealmName() -- On a fresh login this will return null
ns.oceania = { AmanThul = true, Barthilas = true, Caelestrasz = true, DathRemar = true,
			Dreadmaul = true, Frostmourne = true, Gundrak = true, JubeiThos = true, 
			Khazgoroth = true, Nagrand = true, Saurfang = true, Thaurissan = true,
			Yojamba = true, Remulos = true, Arugal = true, Felstriker = true,
			Penance = true, Shadowstrike = true, Maladath = true, }			
if ns.oceania[realm] then
	ns.locale = "enGB"
end

if ns.locale == "deDE" then
	L["Character"] = "Charakter"
	L["Account"] = "Accountweiter"
	L["Completed"] = "Abgeschlossen"
	L["Not Completed"] = "Nicht Abgeschlossen"
	L["Options"] = "Optionen"
	L["Map Pin Size"] = "Pin-Größe"
	L["The Map Pin Size"] = "Die Größe der Karten-Pins"
	L["Map Pin Alpha"] = "Kartenpin Alpha"
	L["The alpha transparency of the map pins"] = "Die Alpha-Transparenz der Karten-Pins"
	L["Show Coordinates"] = "Koordinaten anzeigen"
	L["Show Coordinates Description"] = "Zeigen sie die " ..ns.colour.highlight 
		.."koordinaten\124r in QuickInfos auf der Weltkarte und auf der Minikarte an"
	L["Map Pin Selections"] = "Karten-Pin-Auswahl"
	L["Gold"] = "Gold"
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
	L["Screw"] = "Schraube"
	L["Notes"] = "Notizen"
	L["Left"] = "Links"
	L["Right"] = "Rechts"
	L["Try later"] = "Derzeit nicht möglich. Versuche es späte"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["Character"] = "Personaje"
	L["Account"] = "la Cuenta"
	L["Completed"] = "Completado"
	L["Not Completed"] = ( ns.locale == "esES" ) and "Sin Completar" or "Incompleto"
	L["Options"] = "Opciones"
	L["Map Pin Size"] = "Tamaño de alfiler"
	L["The Map Pin Size"] = "Tamaño de los pines del mapa"
	L["Map Pin Alpha"] = "Alfa de los pines del mapa"
	L["The alpha transparency of the map pins"] = "La transparencia alfa de los pines del mapa"
	L["Icon Alpha"] = "Transparencia del icono"
	L["The alpha transparency of the icons"] = "La transparencia alfa de los iconos"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Mostrar " ..ns.colour.highlight
		.."coordenadas\124r en información sobre herramientas en el mapa del mundo y en el minimapa"
	L["Map Pin Selections"] = "Selecciones de pines de mapa"
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
	L["Screw"] = "Tornillo"
	L["Notes"] = "Notas"
	L["Left"] = "Izquierda"
	L["Right"] = "Derecha"
	L["Try later"] = "No es posible en este momento. Intenta más tarde"

elseif ns.locale == "frFR" then
	L["Character"] = "Personnage"
	L["Account"] = "le Compte"
	L["Completed"] = "Achevé"
	L["Not Completed"] = "Non achevé"
	L["Options"] = "Options"
	L["Map Pin Size"] = "Taille des épingles"
	L["The Map Pin Size"] = "La taille des épingles de carte"
	L["Map Pin Alpha"] = "Alpha des épingles de carte"
	L["The alpha transparency of the map pins"] = "La transparence alpha des épingles de la carte"
	L["Show Coordinates"] = "Afficher les coordonnées"
	L["Show Coordinates Description"] = "Afficher " ..ns.colour.highlight
		.."les coordonnées\124r dans les info-bulles sur la carte du monde et la mini-carte"
	L["Map Pin Selections"] = "Sélections de broches de carte"
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
	L["Screw"] = "Vis"
	L["Notes"] = "Remarques"
	L["Left"] = "Gauche"
	L["Right"] = "Droite"
	L["Try later"] = "Pas possible pour le moment. Essayer plus tard"

elseif ns.locale == "itIT" then
	L["Character"] = "Personaggio"
	L["Completed"] = "Completo"
	L["Not Completed"] = "Non Compiuto"
	L["Options"] = "Opzioni"
	L["Map Pin Size"] = "Dimensione del pin"
	L["The Map Pin Size"] = "La dimensione dei Pin della mappa"
	L["Map Pin Alpha"] = "Mappa pin alfa"
	L["The alpha transparency of the map pins"] = "La trasparenza alfa dei pin della mappa"
	L["Show Coordinates"] = "Mostra coordinate"
	L["Show Coordinates Description"] = "Visualizza " ..ns.colour.highlight
		.."le coordinate\124r nelle descrizioni comandi sulla mappa del mondo e sulla minimappa"
	L["Map Pin Selections"] = "Selezioni pin mappa"
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
	L["Screw"] = "Vite"
	L["Notes"] = "Note"
	L["Left"] = "Sinistra"
	L["Right"] = "Destra"
	L["Try later"] = "Non è possibile in questo momento. Prova più tardi"

elseif ns.locale == "koKR" then
	L["Character"] = "캐릭터"
	L["Account"] = "계정"
	L["Completed"] = "완료"
	L["Not Completed"] = "미완료"
	L["Map Pin Size"] = "지도 핀의 크기"
	L["Options"] = "설정"
	L["The Map Pin Size"] = "지도 핀의 크기"
	L["Map Pin Alpha"] = "지도 핀의 알파"
	L["The alpha transparency of the map pins"] = "지도 핀의 알파 투명도"
	L["Show Coordinates"] = "좌표 표시"
	L["Show Coordinates Description"] = "세계지도 및 미니지도의 도구 설명에 좌표를 표시합니다."
	L["Map Pin Selections"] = "지도 핀 선택"
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
	L["Screw"] = "나사"
	L["Notes"] = "메모"
	L["Left"] = "왼쪽"
	L["Right"] = "오른쪽"
	L["Try later"] = "지금은 불가능합니다. 나중에 시도하세요"

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Character"] = "Personagem"
	L["Account"] = "à Conta"
	L["Completed"] = "Concluído"
	L["Not Completed"] = "Não Concluído"
	L["Options"] = "Opções"
	L["Map Pin Size"] = "Tamanho do pino"
	L["The Map Pin Size"] = "O tamanho dos pinos do mapa"
	L["Map Pin Alpha"] = "Alfa dos pinos do mapa"
	L["The alpha transparency of the map pins"] = "A transparência alfa dos pinos do mapa"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Exibir " ..ns.colour.highlight
		.."coordenadas\124r em dicas de ferramentas no mapa mundial e no minimapa"
	L["Map Pin Selections"] = "Seleções de pinos de mapa"
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
	L["Screw"] = "Parafuso"
	L["Notes"] = "Notas"
	L["Left"] = "Esquerda"
	L["Right"] = "Direita"
	L["Try later"] = "Não é possível neste momento. Tente depois"

elseif ns.locale == "ruRU" then
	L["Character"] = "Персонажа"
	L["Account"] = "Счет"
	L["Completed"] = "Выполнено"
	L["Not Completed"] = "Не Выполнено"
	L["Options"] = "Параметры"
	L["Map Pin Size"] = "Размер булавки"
	L["The Map Pin Size"] = "Размер булавок на карте"
	L["Map Pin Alpha"] = "Альфа булавок карты"
	L["The alpha transparency of the map pins"] = "Альфа-прозрачность булавок карты"
	L["Show Coordinates"] = "Показать Координаты"
	L["Show Coordinates Description"] = "Отображает " ..ns.colour.highlight
		.."координаты\124r во всплывающих подсказках на карте мира и мини-карте"
	L["Map Pin Selections"] = "Выбор булавки карты"
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
	L["Screw"] = "Винт"
	L["Notes"] = "Примечания"
	L["Left"] = "Налево"
	L["Right"] = "Направо"
	L["Try later"] = "В настоящее время это невозможно. Попробуй позже"

elseif ns.locale == "zhCN" then
	L["Character"] = "角色"
	L["Account"] = "账号"
	L["Completed"] = "已完成"
	L["Not Completed"] = "未完成"
	L["Options"] = "选项"
	L["Map Pin Size"] = "地图图钉的大小"
	L["The Map Pin Size"] = "地图图钉的大小"
	L["Map Pin Alpha"] = "地图图钉的透明度"
	L["The alpha transparency of the map pins"] = "地图图钉的透明度"
	L["Show Coordinates"] = "显示坐标"
	L["Show Coordinates Description"] = "在世界地图和迷你地图上的工具提示中" ..ns.colour.highlight .."显示坐标"
	L["Map Pin Selections"] = "地图图钉选择"
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
	L["Screw"] = "拧"
	L["Notes"] = "笔记"
	L["Left"] = "左"
	L["Right"] = "右"
	L["Try later"] = "目前不可能。稍后再试"

elseif ns.locale == "zhTW" then
	L["Character"] = "角色"
	L["Account"] = "賬號"
	L["Completed"] = "完成"
	L["Not Completed"] = "未完成"
	L["Options"] = "選項"
	L["Map Pin Size"] = "地圖圖釘的大小"
	L["The Map Pin Size"] = "地圖圖釘的大小"
	L["Map Pin Alpha"] = "地圖圖釘的透明度"
	L["The alpha transparency of the map pins"] = "地圖圖釘的透明度"
	L["Show Coordinates"] = "顯示坐標"
	L["Show Coordinates Description"] = "在世界地圖和迷你地圖上的工具提示中" ..ns.colour.highlight .."顯示坐標"
	L["Map Pin Selections"] = "地圖圖釘選擇"
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
	L["Stars"] = "星星"
	L["Screw"] = "擰"
	L["Notes"] = "筆記"
	L["Left"] = "左"
	L["Right"] = "右"
	L["Try later"] = "目前不可能。稍後再試"

else
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
	L["Try later"] = "Not possible at this time. Try later"
	if ns.locale == "enUS" then
		L["Grey"] = "Gray"
	end
end

ns.name = UnitName( "player" ) or "Character"
ns.faction = UnitFactionGroup( "player" )

if ns.locale == "deDE" then
	L["AddOn Description"] = ns.colour.highlight .."Hilfe für Erfolge und Quests in " ..ns.colour.prefix .."Sonnenwendfest"
	L["Midsummer Fire Festival"] = "Sonnenwendfest"
	L["Thief's Reward"] = "Der Lohn des Diebes"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["AddOn Description"] = ns.colour.highlight .."Ayuda con el suceso mundial" ..ns.colour.prefix
		.."Festival del Fuego del Solsticio de Verano"
	L["Midsummer Fire Festival"] = "Festival del Fuego del Solsticio de Verano"
	L["Thief's Reward"] = "Una recompensa de ladrón"

elseif ns.locale == "frFR" then
	L["AddOn Description"] = ns.colour.highlight .."Aide à l'événement mondial " ..ns.colour.prefix
		.."Fête du Feu du solstice d'été"
	L["Midsummer Fire Festival"] = "Fête du Feu du solstice d'été"
	L["Thief's Reward"] = "La récompense d'un voleur"

elseif ns.locale == "itIT" then
	L["AddOn Description"] = ns.colour.highlight .."Assiste con l'evento mondiale " ..ns.colour.prefix
		.."Fuochi di Mezza Estate"
	L["Midsummer Fire Festival"] = "Fuochi di Mezza Estate"
	L["Thief's Reward"] = "La Ricompensa del Ladro"

elseif ns.locale == "koKR" then
	L["AddOn Description"] = ns.colour.prefix .."한여름 불꽃축제 " ..ns.colour.highlight .."대규모 이벤트 지원"	
	L["Midsummer Fire Festival"] = "한여름 불꽃축제"
	L["Thief's Reward"] = "도적의 보상"
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["AddOn Description"] = ns.colour.highlight .."Auxilia no evento mundial " ..ns.colour.prefix
		.."Festival do Fogo do Solstício"
	L["Midsummer Fire Festival"] = "Festival do Fogo do Solstício"
	L["Thief's Reward"] = "A recompensa de um ladrão"

elseif ns.locale == "ruRU" then
	L["AddOn Description"] = ns.colour.highlight .."Помогает с игровое событие " ..ns.colour.prefix
		.."Огненный Солнцеворот"
	L["Midsummer Fire Festival"] = "Огненный Солнцеворот"
	L["Thief's Reward"] = "Награда вора"

elseif ns.locale == "zhCN" then
	L["AddOn Description"] = ns.colour.highlight .."协助 " ..ns.colour.prefix .."仲夏火焰节 " ..ns.colour.highlight .."活动"
	L["Midsummer Fire Festival"] = "仲夏火焰节"
	L["Thief's Reward"] = "盗贼的奖励"

elseif ns.locale == "zhTW" then
	L["AddOn Description"] = ns.colour.highlight .."協助 " ..ns.colour.prefix .."仲夏火焰節 " ..ns.colour.highlight .."活動"
	L["Midsummer Fire Festival"] = "仲夏火焰節"
	L["Thief's Reward"] = "盜賊的獎勵"

else
	L["AddOn Description"] = ns.colour.highlight .."Help for the " ..ns.colour.prefix .."Midsummer Fire Festival"
		..ns.colour.highlight .." achievements"
end

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]

	local completed, aName, completedMe;
	local bypassCoords = false
	local showTip = true
	
	if ( pin.group == "H" ) or ( pin.group == "D" ) or ( pin.group == "T" ) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe =
				GetAchievementInfo( (pin.aID or pin.aIDA or pin.aIDH) )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
		completedMe = IsQuestFlaggedCompleted( pin.quest )
		if (pin.index or pin.indexA or pin.indexH) then
			aName = GetAchievementCriteriaInfo( (pin.aID or pin.aIDA or pin.aIDH), (pin.index or pin.indexA or pin.indexH) )
		end
		if ( pin.group == "T" ) then
			local status = ( IsOnQuest( pin.quest ) == true ) and ( "\124cFFFF0000" .."Ready to Hand In" )
							or ( (completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] )
														or ( "\124cFFFF0000" ..L["Not Completed"] ) )
			aName = GetTitleForQuestID( pin.quest ) or pin.label		
			GameTooltip:AddDoubleLine( ns.colour.highlight.. aName, ( status .." (" ..ns.name ..")" ) )
		else
			GameTooltip:AddDoubleLine( ns.colour.highlight.. aName,
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
		end
	elseif ( pin.group == "I" ) then
		GameTooltip:SetText( ns.colour.prefix ..pin.title )
	end
	if ( showTip == true ) and not ( pin.tip == nil ) then
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

-- ---------------------------------------------------------------------------------------------------------------------------------

local function ShowConditionallyE( aID, index )
	local completed;
	if ( ns.db.removeEver == true ) then
		if index then
			_, _, completed = GetAchievementCriteriaInfo( aID, index )
		else
			_, _, _, completed = GetAchievementInfo( aID )
		end
		if ( completed == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyS( quest )
	local completed;
	if ( ns.db.removeSeasonal == true ) then
		completed = IsQuestFlaggedCompleted( quest )
		if ( completed == true ) then
			return false
		end
	end
	return true
end

do	
	local function iterator(t, prev)
		if not t then return end
		local coord, pin = next(t, prev)
		while coord do
			if pin and ( ( pin.faction == nil ) or ( pin.faction == ns.faction ) ) then
				if ( pin.group == "H" ) then
					if ( ShowConditionallyE( (pin.aID or pin.aIDA or pin.aIDH), 
											(pin.index or pin.indexA or pin.indexH) ) == true ) then
						if ( ShowConditionallyS( pin.quest ) == true ) then
							return coord, nil, ns.textures[ns.db.iconHonor],
								ns.db.iconScale * ns.scaling[ns.db.iconHonor], ns.db.iconAlpha
						end
					end
				elseif ( pin.group == "D" ) then
					if ( ShowConditionallyE( (pin.aID or pin.aIDA or pin.aIDH), 
											(pin.index or pin.indexA or pin.indexH) ) == true ) then
						if ( ShowConditionallyS( pin.quest ) == true ) then
							return coord, nil, ns.textures[ns.db.iconDesecrate],
								ns.db.iconScale * ns.scaling[ns.db.iconDesecrate], ns.db.iconAlpha
						end
					end
				elseif ( pin.group == "T" ) then
					if ( ShowConditionallyE( (pin.aID or pin.aIDA or pin.aIDH), 
											(pin.index or pin.indexA or pin.indexH) ) == true ) then
						if ( ShowConditionallyS( pin.quest ) == true ) then
							return coord, nil, ns.textures[ns.db.iconThief],
								ns.db.iconScale * ns.scaling[ns.db.iconThief], ns.db.iconAlpha
						end
					end
				else
					return coord, nil, ns.textures[ns.db.iconThief],
						ns.db.iconScale * ns.scaling[ns.db.iconThief], ns.db.iconAlpha
				end
			end
			coord, pin = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		return iterator, ns.points[mapID]
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Interface -> Addons -> Handy Notes -> Plugins -> Midsummer Fire Festival options
ns.options = {
	type = "group",
	name = L["Midsummer Fire Festival"],
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
				iconScale = {
					type = "range",
					name = L["Map Pin Size"],
					desc = L["The Map Pin Size"],
					min = 1, max = 4, step = 0.1,
					arg = "iconScale",
					order = 1,
				},
				iconAlpha = {
					type = "range",
					name = L["Map Pin Alpha"],
					desc = L["The alpha transparency of the map pins"],
					min = 0, max = 1, step = 0.01,
					arg = "iconAlpha",
					order = 2,
				},
				showCoords = {
					name = L["Show Coordinates"],
					desc = L["Show Coordinates Description"] 
							..ns.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 3,
				},
				removeSeasonal = {
					name = "Remove Bonfire / Flame Keeper markers if completed this season by " ..ns.name,
					desc = "These are the various \"Honor\" and \"Desecrate\" quests",
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					order = 4,
				},
				removeEver = {
					name = "Remove marker if ever completed on this account",
					desc = "If any of your characters has completed the achievement",
					type = "toggle",
					width = "full",
					arg = "removeEver",
					order = 5,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Map Pin Selections"],
			inline = true,
			args = {
				iconHonor = {
					type = "range",
					name = L["Honor the Flames"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"]
							.."\n4 = " ..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = "
							..L["Grey"] .."\n7 = " .. L["Fire Spirit"] .."\n8 = "
							..L["Fire Flower"] .."\n9 = " ..L["Fire Potion"] .."\n10 = "
							..L["MFF Symbol Blue"] .."\n11 = " ..L["MFF Symbol Brown"], 
					min = 1, max = 11, step = 1,
					arg = "iconHonor",
					order = 10,
				},
				iconDesecrate = {
					type = "range",
					name = L["Desecrate/Extinguish"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"]
							.."\n4 = " ..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = "
							..L["Grey"] .."\n7 = " .. L["Fire Spirit"] .."\n8 = "
							..L["Fire Flower"] .."\n9 = " ..L["Fire Potion"] .."\n10 = "
							..L["MFF Symbol Blue"] .."\n11 = " ..L["MFF Symbol Brown"], 
					min = 1, max = 11, step = 1,
					arg = "iconDesecrate",
					order = 11,
				},
				iconThief = {
					type = "range",
					name = L["Thief's Reward"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"]
							.."\n4 = " ..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = "
							..L["Grey"] .."\n7 = " .. L["Fire Spirit"] .."\n8 = "
							..L["Fire Flower"] .."\n9 = " ..L["Fire Potion"] .."\n10 = "
							..L["MFF Symbol Blue"] .."\n11 = " ..L["MFF Symbol Brown"], 
					min = 1, max = 11, step = 1,
					arg = "iconThief",
					order = 12,
				},
			},
		},
		notes = {
			type = "group",
			name = L["Notes"],
			inline = true,
			args = {
				noteMenu = { type = "description", name = "A shortcut to open this panel is via the Minimap AddOn"
					.." menu, which is immediately below the Calendar icon. Just click your mouse\n\n", order = 20, },
				separator1 = { type = "header", name = "", order = 21, },
				noteChat = { type = "description", name = "Chat command shortcuts are also supported.\n\n"
					..NORMAL_FONT_COLOR_CODE .."/mff" ..HIGHLIGHT_FONT_COLOR_CODE .." - Show this panel\n",
					order = 22, },
			},
		},
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_MidsummerFireFestival_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "MidsummerFireFestival" )
 end

-- ---------------------------------------------------------------------------------------------------------------------------------

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub( "HereBeDragons-2.0", true )
	if not HereBeDragons then return end
	
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			-- Maps here will not propagate upwards
			if coords then
				for coord, pin in next, coords do
					local function AddToContinent()
						local mx, my = HandyNotes:getXY(coord)
						local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
						if cx and cy then
							ns.points[continentMapID] = ns.points[continentMapID] or {}
							ns.points[continentMapID][HandyNotes:getCoord(cx, cy)] = pin
						end
					end				
					if ( pin.faction == nil ) or ( pin.faction == ns.faction ) then
						AddToContinent()
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB( "MidsummerFireFestival", pluginHandler, ns.options )
	ns.db = LibStub( "AceDB-3.0" ):New("HandyNotes_MidsummerFireFestivalDB", defaults, "Default" ).profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	if GetTime() > ( ns.delay or 0 ) then
		ns.delay = nil
		self:SendMessage( "HandyNotes_NotifyUpdate", "MidsummerFireFestival" )
	end
end

LibStub( "AceAddon-3.0" ):NewAddon( pluginHandler, "HandyNotes_MidsummerFireFestivalDB", "AceEvent-3.0" )

-- ---------------------------------------------------------------------------------------------------------------------------------

ns.eventFrame = CreateFrame( "Frame" )
ns.timeSinceLastRefresh, ns.curTime = 0, 0

local function OnUpdate()
	if GetTime() > ( ns.saveTime or 0 ) then
		ns.saveTime = GetTime() + 5
		pluginHandler:Refresh()
	end
end

ns.eventFrame:SetScript( "OnUpdate", OnUpdate )

local function OnEventHandler( self, event, ... )
	if ( event == "PLAYER_ENTERING_WORLD" ) or ( event == "PLAYER_LEAVING_WORLD" ) then
		ns.delay = GetTime() + 60 -- Some arbitrary large amount
	elseif ( event == "SPELLS_CHANGED" ) then
		ns.delay = GetTime() + 5 -- Allow a 5 second safety buffer before we resume refreshes
	end
end

ns.eventFrame:RegisterEvent( "PLAYER_ENTERING_WORLD" )
ns.eventFrame:RegisterEvent( "PLAYER_LEAVING_WORLD" )
ns.eventFrame:RegisterEvent( "SPELLS_CHANGED" )
ns.eventFrame:SetScript( "OnEvent", OnEventHandler )

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_Midsummer1, SLASH_Midsummer2 = "/mff", "/midsummer"

local function Slash( options )

	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "Midsummer" )
	if ( ns.version >= 100000 ) then
		print( ns.colour.prefix .."MFF: " ..ns.colour.highlight .."Try the Minimap AddOn Menu (below the Calendar)" )
	end
end

SlashCmdList[ "Midsummer" ] = function( options ) Slash( options ) end