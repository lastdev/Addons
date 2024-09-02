--[[
                                ----o----(||)----oo----(||)----o----

                                     Adorable Raptor Hatchlings

                                      v1.33 - 21st August 2024
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved
								
                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...
ns.db = {}
-- From Data.lua
ns.points, ns.textures, ns.scaling = {}, {}, {}
-- Purple theme
ns.colour = {}
ns.colour.prefix	= "\124cFF8258FA"
ns.colour.highlight = "\124cFFB19EFF"
ns.colour.plaintext = "\124cFF819FF7"

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								iconChoice = 9 } }
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

local _, _, _, version = GetBuildInfo()

-- Map IDs. The nests were added in WotLK, even though the locations are original zones
-- The Barrens (W) coordinates are different to Northern Barrens (R)
-- The Wetlands implementation between (W) and (R) is also different
-- With Classic Cata Pre-Launch 4.4.0 the maps IDs are the 14xx series but locations match Retail
-- 		thus elsewhere in the code I test for < 50000 rather than 40000
--		The Azeroth map did not populate correctly when testing 4.4.0
ns.kalimdor = (version < 50000) and 1414 or 12
ns.easternKingdom = (version < 50000) and 1415 or 13
ns.dalaran = (version < 50000) and 125 or 125
ns.dustwallowMarsh = (version < 50000) and 1445 or 70
ns.barrens = (version < 50000) and 1413 or 10
ns.unGoroCrater = (version < 50000) and 1449 or 78
ns.wetlands = (version < 50000) and 1437 or 56
continents[ns.kalimdor] = true
continents[ns.easternKingdom] = true
-- continents[ 947 ] = true -- Azeroth

-- Localisation
ns.locale = GetLocale()
local L = {}
setmetatable( L, { __index = function( L, key ) return key end } )
local realm = GetNormalizedRealmName() -- On a fresh login this will return null
ns.oceania = { AmanThul = true, Barthilas = true, Caelestrasz = true, DathRemar = true,
			Dreadmaul = true, Frostmourne = true, Gundrak = true, JubeiThos = true, 
			Khazgoroth = true, Nagrand = true, Saurfang = true, Thaurissan = true,
			Yojamba = true, Remulos = true, Arugal = true, Felstriker = true,
			Penance = true, Shadowstrike = true }			
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

if ns.locale == "deDE" then
	L["AddOn Description"] = ns.colour.highlight .."Hilft Ihnen, die Nester der "
		..ns.colour.prefix .."Entzückenden Velociraptor-Jungtiere" ..ns.colour.highlight .."zu finden"
	L["Adorable Raptor Hatchling"] = "Entzückendes Velociraptor-Jungtier"
	L["Adorable Raptor Hatchlings"] = "Entzückende Velociraptor-Jungtiere"
	L["Cave Entrance"] = "Höhle Eingang"
	L["Dart's Nest"] = "Pfeils Nest"
	L["Darting Hatchling"] = "Pfeilschnelles Jungtier"
	L["Deviate Hatchling"] = "Deviatjungtier"
	L["Hatchling"] = "Jungtier"
	L["Leaping Hatchling"] = "Springendes Jungtier"
	L["Obsidian Hatchling"] = "Obsidianjungtier"
	L["Raptor Ridge"] = "Raptorgrat"
	L["Ravasaur Hatchling"] = "Ravasaurusjungtier"
	L["Ravasaur Matriarch's Nest"] = "Nest der Ravasaurusmatriarchin"
	L["Razormaw Hatchling"] = "Scharfzähniges Jungtier"
	L["Razormaw Matriarch's Nest"] = "Nest der Scharfzahnmatriarchin"
	L["Takk's Nest"] = "Takks Nest"
	L["Under the foliage"] = "Unter dem Laub"
	L["Veer to the right"] = "Biegen Sie nach rechts ab, wenn Sie die Höhle betreten.\nGreifen Sie von rechts auf das Nest zu"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["AddOn Description"] = ns.colour.highlight .."Te ayuda a encontrar los nidos de las "
		..ns.colour.prefix .."Adorables crías de Velociraptor"
	L["Adorable Raptor Hatchling"] = "Adorable cría de Velociraptor"
	L["Adorable Raptor Hatchlings"] = "Adorables crías de Velociraptor"
	L["Cave Entrance"] = "Entrada de la cueva"
	L["Dart's Nest"] = "Nido de Dardo"
	L["Darting Hatchling"] = "Prole flechada"
	L["Deviate Hatchling"] = "Prole descarriada"
	L["Hatchling"] = "Prole"
	L["Leaping Hatchling"] = "Prole saltarina"
	L["Obsidian Hatchling"] = "Prole obsidiana"
	L["Raptor Ridge"] = "Colina del Raptor"
	L["Ravasaur Hatchling"] = "Prole de ravasaurio"
	L["Ravasaur Matriarch's Nest"] = "Nido de matriarca ravasaurio"
	L["Razormaw Hatchling"] = "Prole Tajobuche"
	L["Razormaw Matriarch's Nest"] = "Nido de matriarca Tajobuche"
	L["Takk's Nest"] = "Nido de Takk"
	L["Under the foliage"] = "Bajo el follaje"
	L["Veer to the right"] = "Ve a la derecha al entrar en la cueva.\nAccede al nido desde el lado derecho."

elseif ns.locale == "frFR" then
	L["AddOn Description"] = ns.colour.highlight .."Vous aide à trouver les nids des "
		..ns.colour.prefix .."adorables Vélociraptors petits"
	L["Adorable Raptor Hatchling"] = "Adorable vélociraptor petit"
	L["Adorable Raptor Hatchlings"] = "Adorables vélociraptors petits"
	L["Cave Entrance"] = "Entrée Cave"
	L["Dart's Nest"] = "Nid de Flèche"
	L["Darting Hatchling"] = "Jeune raptor véloce"
	L["Deviate Hatchling"] = "Jeune raptor déviant"
	L["Hatchling"] = "Jeune"
	L["Leaping Hatchling"] = "Jeune raptor sauteur"
	L["Obsidian Hatchling"] = "Jeune raptor d'obsidienne"
	L["Raptor Ridge"] = "Crête des Raptors"
	L["Ravasaur Hatchling"] = "Jeune ravasaure"
	L["Ravasaur Matriarch's Nest"] = "Nid de matriarche ravasaure"
	L["Razormaw Hatchling"] = "Jeune raptor tranchegueule"
	L["Razormaw Matriarch's Nest"] = "Nest der Scharfzahnmatriarchin"
	L["Takk's Nest"] = "Nid de Takk"
	L["Under the foliage"] = "Sous le feuillage"
	L["Veer to the right"] = "Tournez à droite en entrant dans la grotte.\nAccéder au nid du côté droit"

elseif ns.locale == "itIT" then
	L["AddOn Description"] = ns.colour.highlight .."Ti aiuta a trovare i nidi degli "
		..ns.colour.prefix .."Adorabili cuccioli di velociraptor"
	L["Adorable Raptor Hatchling"] = "Adorabile cucciolo di velociraptor"
	L["Adorable Raptor Hatchlings"] = "Adorabili cuccioli di velociraptor"
	L["Cave Entrance"] = "Entrata della grotta"
	L["Dart's Nest"] = "Nido di Dart"
	L["Darting Hatchling"] = "Miniraptor"
	L["Deviate Hatchling"] = "Prole Degenere"
	L["Hatchling"] = "Cucciolo"
	L["Leaping Hatchling"] = "Cucciolo Saltante"
	L["Obsidian Hatchling"] = "Prole d'Ossidiana"
	L["Raptor Ridge"] = "Dorsale dei Raptor"
	L["Ravasaur Hatchling"] = "Cucciolo di Devasauro"
	L["Ravasaur Matriarch's Nest"] = "Nido della Matriarca Devasauro"
	L["Razormaw Hatchling"] = "Cucciolo di Boccaguzza"
	L["Razormaw Matriarch's Nest"] = "Nido della Matriarca Boccaguzza"
	L["Takk's Nest"] = "Nido di Takk"
	L["Under the foliage"] = "Sotto il fogliame"
	L["Veer to the right"] = "Vira a destra mentre entri nella caverna.\nAccedi al nido dal lato destro"

elseif ns.locale == "koKR" then
	L["AddOn Description"] = ns.colour.prefix .."사랑스러운 새끼 랩터의" ..ns.colour.highlight .." 둥지를 찾는 데 도움이 됩니다."
	L["Adorable Raptor Hatchling"] = "사랑스러운 작은 랩터"
	L["Adorable Raptor Hatchlings"] = "사랑스러운 작은 랩터"
	L["Cave Entrance"] = "동굴 입구"
	L["Dart's Nest"] = "바람뿔의 둥지"
	L["Darting Hatchling"] = "새끼 화살랩터"
	L["Deviate Hatchling"] = "새끼 돌연변이 랩터"
	L["Hatchling"] = "새끼"
	L["Leaping Hatchling"] = "새끼 도약랩터"
	L["Obsidian Hatchling"] = "새끼 흑요석 랩터"
	L["Raptor Ridge"] = "랩터 마루"
	L["Ravasaur Hatchling"] = "새끼 라바사우루스"
	L["Ravasaur Matriarch's Nest"] = "우두머리 라바사우루스 둥지"
	L["Razormaw Hatchling"] = "새끼 고원랩터"
	L["Razormaw Matriarch's Nest"] = "무쇠턱 우두머리랩터의 둥지"
	L["Takk's Nest"] = "타크의 둥지"
	L["Under the foliage"] = "언더 리프"
	L["Veer to the right"] = "동굴에 들어서 자 오른쪽으로 향하십시오.\n오른쪽에서 둥지에 액세스하십시오."
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["AddOn Description"] = ns.colour.highlight .."Ajuda você a encontrar os ninhos dos "
		..ns.colour.prefix .."adoráveis filhotes de velociraptores"
	L["Adorable Raptor Hatchling"] = "Adorável filhote velociraptore"
	L["Adorable Raptor Hatchlings"] = "adoráveis filhotes velociraptores"
	L["Cave Entrance"] = "Entrada da caverna"
	L["Dart's Nest"] = "Ninho da Saltadora"
	L["Darting Hatchling"] = "Dartinho"
	L["Deviate Hatchling"] = "Raptinho Anormal"
	L["Hatchling"] = "Filhote"
	L["Leaping Hatchling"] = "Raptinho Saltitante"
	L["Obsidian Hatchling"] = "Raptinho Obsidiano"
	L["Raptor Ridge"] = "Serra dos Raptores"
	L["Ravasaur Hatchling"] = "Ravassaurinho"
	L["Ravasaur Matriarch's Nest"] = "Ninho da Matriarca Ravassauro"
	L["Razormaw Hatchling"] = "Raptinho Rasgaqueixo"
	L["Razormaw Matriarch's Nest"] = "Ninho da Matriarca Rasgaqueixo"
	L["Takk's Nest"] = "Ninho de Takk"
	L["Under the foliage"] = "Sob as folhas"
	L["Veer to the right"] = "Vire para a direita ao entrar na caverna.\nAcesse o ninho pelo lado direito"

elseif ns.locale == "ruRU" then
	L["AddOn Description"] = ns.colour.highlight .."Помогает найти гнезда "
		..ns.colour.prefix .."Очаровательных Детенышей Хищника"
	L["Adorable Raptor Hatchling"] = "Очаровательный Mаленький Велоцираптор"
	L["Adorable Raptor Hatchlings"] = "Очаровательные Mаленькие Велоцирапторы"
	L["Cave Entrance"] = "Вход в пещеру"
	L["Dart's Nest"] = "Гнездо Дарта"
	L["Darting Hatchling"] = "Стремительный детеныш"
	L["Deviate Hatchling"] = "Загадочный детеныш"
	L["Hatchling"] = "Детеныш"
	L["Leaping Hatchling"] = "Прыгающий детеныш"
	L["Obsidian Hatchling"] = "Обсидиановый детеныш"
	L["Raptor Ridge"] = "Гряда Ящеров"
	L["Ravasaur Hatchling"] = "Детеныш равазавра"
	L["Ravasaur Matriarch's Nest"] = "Гнездо равазавра-матриарха"
	L["Razormaw Hatchling"] = "Детеныш острозуба"
	L["Razormaw Matriarch's Nest"] = "Гнездо острозуба-матриарха"
	L["Takk's Nest"] = "Гнездо Такка"
	L["Under the foliage"] = "Под листьями"
	L["Veer to the right"] = "Поверните направо, когда вы входите в пещеру.\nДоступ к гнезду с правой стороны"

elseif ns.locale == "zhCN" then
	L["AddOn Description"] = ns.colour.highlight .."帮助您找到" ..ns.colour.prefix .."可爱的迅猛龙宝"
		..ns.colour.highlight .."巢穴."
	L["Adorable Raptor Hatchling"] = "可爱的迅猛龙宝"
	L["Adorable Raptor Hatchlings"] = "可爱的迅猛龙宝"
	L["Cave Entrance"] = "洞入口"
	L["Dart's Nest"] = "达尔特的巢"
	L["Darting Hatchling"] = "小达尔特"
	L["Deviate Hatchling"] = "变异幼龙"
	L["Hatchling"] = "幼体"
	L["Leaping Hatchling"] = "小塔克"
	L["Obsidian Hatchling"] = "黑曜石幼龙"
	L["Raptor Ridge"] = "恐龙岭"
	L["Ravasaur Hatchling"] = "暴掠幼龙"
	L["Ravasaur Matriarch's Nest"] = "暴掠龙女王的巢"
	L["Razormaw Hatchling"] = "刺喉幼龙"
	L["Razormaw Matriarch's Nest"] = "刺喉雌龙的巢"
	L["Takk's Nest"] = "塔克的巢"
	L["Under the foliage"] = "在树叶下"
	L["Veer to the right"] = "当你进入洞穴时向右转。\n从右侧进入巢穴"
	
elseif ns.locale == "zhTW" then
	L["AddOn Description"] = ns.colour.highlight .."幫助您找到" ..ns.colour.prefix .."可愛的迅猛龍寶"
		..ns.colour.highlight .."巢穴."
	L["Adorable Raptor Hatchling"] = "可愛的迅猛龍寶"
	L["Adorable Raptor Hatchlings"] = "可愛的迅猛龍寶"
	L["Cave Entrance"] = "洞入口"
	L["Dart's Nest"] = "達爾特的巢"
	L["Darting Hatchling"] = "小達爾特"
	L["Deviate Hatchling"] = "變異幼龍"
	L["Hatchling"] = "幼體"
	L["Leaping Hatchling"] = "小塔克"
	L["Obsidian Hatchling"] = "黑曜石幼龍"
	L["Raptor Ridge"] = "恐龍嶺"
	L["Ravasaur Hatchling"] = "暴掠幼龍"
	L["Ravasaur Matriarch's Nest"] = "暴掠龍女王的巢"
	L["Razormaw Hatchling"] = "刺喉幼龍"
	L["Razormaw Matriarch's Nest"] = "刺喉雌龍的巢"
	L["Takk's Nest"] = "塔克的巢"
	L["Under the foliage"] = "在樹葉下"
	L["Veer to the right"] = "當你進入洞穴時向右轉。\n從右側進入巢穴"
	
else
	L["AddOn Description"] = ns.colour.highlight .."Helps you find the nests of the "
		..ns.colour.prefix .."adorable raptor hatchlings"	
	L["Veer to the right"] = "Veer to the right as you enter the cave.\nAccess the nest from the right side"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]

	GameTooltip:SetText( ns.colour.prefix ..L[ pin.title ] )
	GameTooltip:AddLine( ns.colour.highlight ..L[ pin.pet ] )
	if pin.tip then GameTooltip:AddLine( L[ pin.tip ] ) end
	
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
    local bucket = CreateFrame("Frame")
    bucket.elapsed = 0
    bucket:SetScript("OnUpdate", function(self, elapsed)
        self.elapsed = self.elapsed + elapsed
        if self.elapsed > 1.5 then
            self.elapsed = 0
			local insideCave = ( GetSubZoneText() == L[ "Raptor Ridge" ] and IsIndoors() ) and true or false
			if ns.insideCave == nil then
				ns.insideCave = insideCave
			elseif ns.insideCave ~= insideCave then
				ns.insideCave = insideCave
				pluginHandler:Refresh()
			end
        end
    end)

	if ns.insideCave == nil then
		ns.insideCave = ( GetSubZoneText() == L["Raptor Ridge"] and IsIndoors() ) and true or false
	end
	
	local function iterator(t, prev)
		if not t then return end
		local coord, v = next(t, prev)
		while coord do
			if v then
				-- Wetlands special: Show the cave entrance if outside the cave, otherwise show the actual location once inside the cave
				if v.title == "Razormaw Matriarch's Nest" then
					if ns.insideCave == true then
						if (version < 40000) then
							if (v.version == "W") then
								return coord, nil, ns.textures[ns.db.iconChoice], ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
							end
						elseif (v.version == "R") then
							return coord, nil, ns.textures[ns.db.iconChoice], ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
						end
					end
				elseif v.title == "Cave Entrance" then
					if ns.insideCave == false then
						return coord, nil, ns.textures[ns.db.iconChoice], ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
					end
				elseif ( (v.version == "R") or (v.version == "W") ) then
					if (version < 40000) then
						if (v.version == "W") then
							return coord, nil, ns.textures[ns.db.iconChoice], ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
						end
					elseif (v.version == "R") then
						return coord, nil, ns.textures[ns.db.iconChoice], ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
					end
				else
					return coord, nil, ns.textures[ns.db.iconChoice], ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
				end
			end
			coord, v = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		ns.mapID = mapID
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> Adorable Raptor Hatchlings options
ns.options = {
	type = "group",
	name = L["Adorable Raptor Hatchlings"],
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
			},
		},
		icon = {
			type = "group",
			name = L["Map Pin Selections"],
			inline = true,
			args = {
				iconChoice = {
					type = "range",
					name = L["Hatchling"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"],
					min = 1, max = 10, step = 1,
					arg = "iconChoice",
					order = 4,
				},
			},
		},
	},
}

function HandyNotes_AdorableRaptorHatchlings_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "AdorableRaptorHatchlings" )
 end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
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
	HandyNotes:RegisterPluginDB("AdorableRaptorHatchlings", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_AdorableRaptorHatchlingsDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "AdorableRaptorHatchlings")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_AdorableRaptorHatchlingsDB", "AceEvent-3.0")

--=======================================================================================================
--
--		SLASH CHAT COMMANDS  -- All game versions
--		===================
--
--=======================================================================================================

SLASH_AdorableRaptorHatchlings1 = "/arh"

local function Slash( options )

	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "AdorableRaptorHatchlings" )
	if ( version >= 100000 ) then
		print( ns.colour.prefix .."ARH: " ..ns.colour.highlight .."Try the Minimap AddOn Menu (below the Calendar)" )
	end
end

SlashCmdList[ "AdorableRaptorHatchlings" ] = function( options ) Slash( options ) end