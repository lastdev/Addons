--[[
                                ----o----(||)----oo----(||)----o----

                                           Lunar Festival

                                     v3.02 - 10th December 2024
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
-- Red/Gold theme
ns.colour = {}
ns.colour.prefix	= "\124cFFC11B17" -- Chilli Pepper
ns.colour.highlight = "\124cFFFDBD01" -- Neon Gold
ns.colour.plaintext = "\124cFF990000" -- Crimson Red

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								removeOneOff = true, removeSeasonal = true, removeEver = false,
								iconZoneElders = 16, iconDungeonElders = 14, iconCrown = 13,
								iconFactionElders = 11, iconPreservation = 10,
								lpBuffCount = {} } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetQuestObjectives = C_QuestLog.GetQuestObjectives
local IsComplete = C_QuestLog.IsComplete
local IsOnQuest = C_QuestLog.IsOnQuest
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local UnitAura = UnitAura
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

ns.faction = UnitFactionGroup( "player" )
ns.name = UnitName( "player" ) or "Character"

continents[ 12 ] = true -- Kalimdor
continents[ 13 ] = true -- Eastern Kingdoms
continents[ 113 ] = true -- Northrend
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
	L["AddOn Description"] = "Hilfe für Erfolge und Quests in Mondfest"
	L["Blue Coin"] = "Blaue Münze"
	L["Deep Green Coin"] = "Tiefgrüne Münze"
	L["Deep Pink Coin"] = "Tiefrosa Münze"
	L["Deep Red Coin"] = "Tiefrote Münze"
	L["Dungeons"] = "Kerker"
	L["Factions"] = "Fraktionen"
	L["Flower of Compassion"] = "Blume des Mitgefühls"
	L["Flower of Felicity"] = "Blume der Glückseligkeit"
	L["Flower of Fortitude"] = "Blume der Standhaftigkeit"
	L["Flower of Generosity"] = "Blume des Großmuts"
	L["Flower of Luck"] = "Blume des Glücks"
	L["Flower of Peace"] = "Blume des Friedens"
	L["Flower of Reflection"] = "Blume der Besinnung"
	L["Flower of Sincerity"] = "Blume der Aufrichtigkeit"
	L["Flower of Solemnity"] = "Blume der Feierlichkeit"
	L["Flower of Thoughtfulness"] = "Blume der Besonnenheit"
	L["Flower of Vigor"] = "Blume der Vitalität"
	L["Flower of Wealth"] = "Blume des Wohlstands"
	L["Green Coin"] = "Grüne Münze"
	L["Light Blue Coin"] = "Hellblaue Münze"
	L["Lunar Festival"] = "Mondfest"
	L["Lunar Preservation"] = "Mondschutz"
	L["Original Coin"] = "Ursprüngliche Münze"
	L["Pink Coin"] = "Rosa Münze"
	L["Purple Coin"] = "Lila Münze"
	L["Teal Coin"] = "Blaugrüne Münze"
	L["Zones"] = "Gebiete"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["AddOn Description"] = "Ayuda para los logros del Festival Lunar"
	L["Blue Coin"] = "Moneda Azul"
	L["Deep Green Coin"] = "Moneda Verde Oscuro"
	L["Deep Pink Coin"] = "Moneda Rosa Oscuro"
	L["Deep Red Coin"] = "Moneda de color Rojo Oscuro"
	L["Dungeons"] = "Mazmorras"
	L["Factions"] = "Facciones"
	L["Flower of Compassion"] = "Flor de compasión"
	L["Flower of Felicity"] = "Flor de felicidad"
	L["Flower of Fortitude"] = "Flor de entereza"
	L["Flower of Generosity"] = "Flor de generosidad"
	L["Flower of Luck"] = "Flor de suerte"
	L["Flower of Peace"] = "Flor de paz"
	L["Flower of Reflection"] = "Flor de reflejo"
	L["Flower of Sincerity"] = "Flor de sinceridad"
	L["Flower of Solemnity"] = "Flor de solemnidad"
	L["Flower of Thoughtfulness"] = "Flor de consideración"
	L["Flower of Vigor"] = "Flor de vigor"
	L["Flower of Wealth"] = "Flor de riqueza"
	L["Green Coin"] = "Moneda Verde"
	L["Light Blue Coin"] = "Moneda Azul Claro"
	L["Lunar Festival"] = "El festín del Festival Lunar"
	L["Lunar Preservation"] = "Preservación Lunar"
	L["Original Coin"] = "Moneda Original"
	L["Pink Coin"] = "Moneda Rosa"
	L["Purple Coin"] = "Moneda Morada"
	L["Teal Coin"] = "Moneda Verde Azulado"
	L["Zones"] = "Zonas"

elseif ns.locale == "frFR" then
	L["AddOn Description"] = "Aide à l'événement mondial Fête lunaire"
	L["Blue Coin"] = "Pièce bleue"
	L["Deep Green Coin"] = "Pièce vert foncé"
	L["Deep Pink Coin"] = "Pièce rose foncé"
	L["Deep Red Coin"] = "Pièce rouge foncé"
	L["Dungeons"] = "Donjons"
	L["Factions"] = "Factions"
	L["Flower of Compassion"] = "Fleur de compassion"
	L["Flower of Felicity"] = "Fleur de félicité"
	L["Flower of Fortitude"] = "Fleur de robustesse"
	L["Flower of Generosity"] = "Fleur de générosité"
	L["Flower of Luck"] = "Fleur de chance"
	L["Flower of Peace"] = "Fleur de paix"
	L["Flower of Reflection"] = "Fleur de réflexion"
	L["Flower of Sincerity"] = "Fleur de sincérité"
	L["Flower of Solemnity"] = "Fleur de solennité"
	L["Flower of Thoughtfulness"] = "Fleur de prévenance"
	L["Flower of Vigor"] = "Fleur de vigueur"
	L["Flower of Wealth"] = "Fleur de richesse"
	L["Green Coin"] = "Pièce verte"
	L["Light Blue Coin"] = "Pièce bleu clair"
	L["Lunar Festival"] = "Fête lunaire"
	L["Lunar Preservation"] = "Préservation Lunaire"
	L["Original Coin"] = "Pièce originale"
	L["Pink Coin"] = "Pièce rose"
	L["Purple Coin"] = "Pièce violette"
	L["Teal Coin"] = "Pièce sarcelle"
	L["Zones"] = "Zones"

elseif ns.locale == "itIT" then
	L["AddOn Description"] = "Assiste con l'evento mondiale Celebrazione della Luna"
	L["Blue Coin"] = "Moneta blu"
	L["Deep Green Coin"] = "Moneta verde intenso"
	L["Deep Pink Coin"] = "Moneta rosa intenso"
	L["Deep Red Coin"] = "Moneta rosso scuro"
	L["Dungeons"] = "Sotterranee"
	L["Factions"] = "Fazioni"
	L["Flower of Compassion"] = "Fiore della Compassione"
	L["Flower of Felicity"] = "Fiore della Letizia"
	L["Flower of Fortitude"] = "Fiore della Fermezza"
	L["Flower of Generosity"] = "Fiore della Generosità"
	L["Flower of Luck"] = "Fiore della Fortuna"
	L["Flower of Peace"] = "Fiore della Pace"
	L["Flower of Reflection"] = "Fiore della Riflessione"
	L["Flower of Sincerity"] = "Fiore della Sincerità"
	L["Flower of Solemnity"] = "Fiore della Solennità"
	L["Flower of Thoughtfulness"] = "Fiore del Raccoglimento"
	L["Flower of Vigor"] = "Fiore del Vigore"
	L["Flower of Wealth"] = "Fiore della Prosperità"
	L["Green Coin"] = "Moneta verde"
	L["Light Blue Coin"] = "Moneta azzurra"
	L["Lunar Festival"] = "Celebrazione della Luna"
	L["Lunar Preservation"] = "Preservazione Lunare"
	L["Original Coin"] = "Moneta originale"
	L["Pink Coin"] = "Moneta rosa"
	L["Purple Coin"] = "Moneta viola"
	L["Teal Coin"] = "Moneta verde acqua"
	L["Zones"] = "Zone"

elseif ns.locale == "koKR" then
	L["AddOn Description"] = "달의 축제 대규모 이벤트 지원"	
	L["Blue Coin"] = "블루 코인"
	L["Deep Green Coin"] = "딥그린 코인"
	L["Deep Pink Coin"] = "딥 핑크 코인"
	L["Deep Red Coin"] = "딥 레드 코인"
	L["Dungeons"] = "던전"
	L["Factions"] = "진영"
	L["Flower of Compassion"] = "연민의 꽃"
	L["Flower of Felicity"] = "희락의 꽃"
	L["Flower of Fortitude"] = "인내의 꽃"
	L["Flower of Generosity"] = "아량의 꽃"
	L["Flower of Luck"] = "행운의 꽃"
	L["Flower of Peace"] = "평화의 꽃"
	L["Flower of Reflection"] = "비춤의 꽃"
	L["Flower of Sincerity"] = "신실의 꽃"
	L["Flower of Solemnity"] = "장엄의 꽃"
	L["Flower of Thoughtfulness"] = "사색의 꽃"
	L["Flower of Vigor"] = "활력의 꽃"
	L["Flower of Wealth"] = "부귀의 꽃"
	L["Green Coin"] = "그린 코인"
	L["Light Blue Coin"] = "하늘색 동전"
	L["Lunar Festival"] = "달의 축제"
	L["Lunar Preservation"] = "달빛지기"
	L["Original Coin"] = "원래 동전"
	L["Pink Coin"] = "핑크 코인"
	L["Purple Coin"] = "퍼플 코인"
	L["Teal Coin"] = "틸 코인"
	L["Zones"] = "지역"
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["AddOn Description"] = "Auxilia no evento mundial Festival da Lua"
	L["Blue Coin"] = "Moeda azul"
	L["Deep Green Coin"] = "moeda verde escuro"
	L["Deep Pink Coin"] = "Moeda rosa escuro"
	L["Deep Red Coin"] = "moeda vermelha escura"
	L["Dungeons"] = "Masmorras"
	L["Factions"] = "Facções"
	L["Flower of Compassion"] = "Flor da Compaixão"
	L["Flower of Felicity"] = "Flor da Felicidade"
	L["Flower of Fortitude"] = "Flor da Fortitude"
	L["Flower of Generosity"] = "Flor da Generosidade"
	L["Flower of Luck"] = "Flor da Sorte"
	L["Flower of Peace"] = "Flor da Paz"
	L["Flower of Reflection"] = "Flor da Reflexão"
	L["Flower of Sincerity"] = "Flor da Sinceridade"
	L["Flower of Solemnity"] = "Flor da Dignidade"
	L["Flower of Thoughtfulness"] = "Flor da Meditação"
	L["Flower of Vigor"] = "Flor do Vigor"
	L["Flower of Wealth"] = "Flor da Riqueza"
	L["Green Coin"] = "moeda verde"
	L["Light Blue Coin"] = "Moeda azul claro"
	L["Lunar Festival"] = "Festival da Lua"
	L["Lunar Preservation"] = "Preservação lunar"
	L["Original Coin"] = "moeda original"
	L["Pink Coin"] = "moeda rosa"
	L["Purple Coin"] = "moeda roxa"
	L["Teal Coin"] = "moeda azul-petróleo"
	L["Zones"] = "Zonas"

elseif ns.locale == "ruRU" then
	L["AddOn Description"] = "Помогает с игровое событие Лунный фестиваль"
	L["Blue Coin"] = "Синяя Монета"
	L["Deep Green Coin"] = "Темно-зеленая Монета"
	L["Deep Pink Coin"] = "Темно-розовая Монета"
	L["Deep Red Coin"] = "Темно-красная Монета"
	L["Dungeons"] = "Подземелья"
	L["Factions"] = "ФракцииФракции"
	L["Flower of Compassion"] = "Цветок сострадания"
	L["Flower of Felicity"] = "Цветок счастья"
	L["Flower of Fortitude"] = "Цветок стойкости"
	L["Flower of Generosity"] = "Цветок щедрости"
	L["Flower of Luck"] = "Цветок удачи"
	L["Flower of Peace"] = "Цветок мира"
	L["Flower of Reflection"] = "Цветок размышлений"
	L["Flower of Sincerity"] = "Цветок искренности"
	L["Flower of Solemnity"] = "Цветок печали"
	L["Flower of Thoughtfulness"] = "Цветок проницательности"
	L["Flower of Vigor"] = "Цветок жизненной силы"
	L["Flower of Wealth"] = "Цветок богатства"
	L["Green Coin"] = "Зеленая Монета"
	L["Light Blue Coin"] = "Голубая Монета"
	L["Lunar Festival"] = "Лунный фестиваль"
	L["Lunar Preservation"] = "Лунная Консервация"
	L["Original Coin"] = "Оригинальная Монета"
	L["Pink Coin"] = "Розовая Монета"
	L["Purple Coin"] = "Фиолетовая Монета"
	L["Teal Coin"] = "Бирюзовая Монета"
	L["Zones"] = "Территории"

elseif ns.locale == "zhCN" then
	L["AddOn Description"] = "协助春节活动"
	L["Blue Coin"] = "蓝币"
	L["Deep Green Coin"] = "深绿币"
	L["Deep Pink Coin"] = "深粉色硬币"
	L["Deep Red Coin"] = "深红硬币"
	L["Dungeons"] = "地下城"
	L["Factions"] = "阵营"
	L["Flower of Compassion"] = "恻隐之花"
	L["Flower of Felicity"] = "幸福之花"
	L["Flower of Fortitude"] = "坚韧之花"
	L["Flower of Generosity"] = "慷慨之花"
	L["Flower of Luck"] = "幸运之花"
	L["Flower of Peace"] = "平和之花"
	L["Flower of Reflection"] = "反思之花"
	L["Flower of Sincerity"] = "诚挚之花"
	L["Flower of Solemnity"] = "庄严之花"
	L["Flower of Thoughtfulness"] = "思绪之花"
	L["Flower of Vigor"] = "活力之花"
	L["Flower of Wealth"] = "财富之花"
	L["Green Coin"] = "绿币"
	L["Light Blue Coin"] = "淡蓝色硬币"
	L["Lunar Festival"] = "春节"
	L["Lunar Preservation"] = "月光守护"
	L["Original Coin"] = "原币"
	L["Pink Coin"] = "粉币"
	L["Purple Coin"] = "紫币"
	L["Teal Coin"] = "蓝绿色硬币"
	L["Zones"] = "地区"

elseif ns.locale == "zhTW" then
	L["AddOn Description"] = "協助春節活動"
	L["Blue Coin"] = "藍幣"
	L["Deep Green Coin"] = "深綠幣"
	L["Deep Pink Coin"] = "深粉色硬幣"
	L["Deep Red Coin"] = "深紅硬幣"
	L["Dungeons"] = "地下城"
	L["Factions"] = "陣營"
	L["Flower of Compassion"] = "惻隱之花"
	L["Flower of Felicity"] = "幸福之花"
	L["Flower of Fortitude"] = "堅韌之花"
	L["Flower of Generosity"] = "慷慨之花"
	L["Flower of Luck"] = "幸運之花"
	L["Flower of Peace"] = "平和之花"
	L["Flower of Reflection"] = "反思之花"
	L["Flower of Sincerity"] = "誠摯之花"
	L["Flower of Solemnity"] = "莊嚴之花"
	L["Flower of Thoughtfulness"] = "思緒之花"
	L["Flower of Vigor"] = "活力之花"
	L["Flower of Wealth"] = "財富之花"
	L["Green Coin"] = "綠幣"
	L["Light Blue Coin"] = "淡藍色硬幣"
	L["Lunar Festival"] = "春節"
	L["Lunar Preservation"] = "月光守護"
	L["Original Coin"] = "原幣"
	L["Pink Coin"] = "粉幣"
	L["Purple Coin"] = "紫幣"
	L["Teal Coin"] = "藍綠色硬幣"
	L["Zones"] = "地區"
	
else
	L["AddOn Description"] = "Help for the Lunar Festival achievements"
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
	
	if ( pin.aID ) and ( pin.index ) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( pin.aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
		if ( pin.quest ) then
			completed = IsQuestFlaggedCompleted( pin.quest )
			aName = GetAchievementCriteriaInfo( pin.aID, pin.index )
		else
			aName, _, completed = GetAchievementCriteriaInfo( pin.aID, pin.index )
		end
		GameTooltip:AddDoubleLine( ns.colour.highlight.. aName,
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
	elseif ( pin.aID ) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( pin.aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
	elseif ( pin.quest ) then
		if ( pin.quest == 63213 ) then
			completed = IsQuestFlaggedCompleted( pin.quest )
			GameTooltip:AddDoubleLine( ns.colour.prefix .."Naladu the Elder",
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
		elseif ( pin.quest == 56842 ) then
			completed = IsQuestFlaggedCompleted( 56842 )
			GameTooltip:AddDoubleLine( ns.colour.prefix ..L["Lunar Preservation"],
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
			if ( completed == false ) then
				if ( IsOnQuest( 56842 ) == true ) then
					completed = IsComplete( 56842 )
					GameTooltip:AddDoubleLine( ns.colour.highlight .."All eight locations...",
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
					if ( completed == true ) then
						GameTooltip:AddLine( ns.colour.plaintext .."Ready to turn in" )
					else
						GameTooltip:AddLine( ns.colour.plaintext .."Wells so far: "
							..ns.db.lpBuffCount[ns.name] )
					end
				else
					GameTooltip:AddLine( ns.colour.plaintext .."Not yet begun" )
				end
			end
			showTip = false
		elseif ( pin.quest == 56903 ) or ( pin.quest == 56904 ) or ( pin.quest == 56905 ) or ( pin.quest == 56906 ) then
			completed = IsQuestFlaggedCompleted( pin.quest )
			GameTooltip:AddDoubleLine( ns.colour.prefix ..( ( pin.quest == 56906) and L["Crown of Good Fortune"]
										or ( ( pin.quest == 56905) and L["Crown of Dark Blossoms"] 
										or ( ( pin.quest == 56904) and L["Crown of Prosperity"] 
										or L["Crown of Courage"] ) ) ),
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
			local questObjectives = GetQuestObjectives( pin.quest )
			if questObjectives then
				for k,v in pairs( questObjectives ) do
					if ( pin.index == k ) then
						for i,j in pairs( v ) do
							if ( i == "finished" ) then
								GameTooltip:AddDoubleLine( ns.colour.prefix ..L[ pin.obj ],
											( j == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
																or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
							end
						end
					end
				end
			end
			showTip = false
		end
	else
		bypassCoords = true
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
		if ( index > 0 ) then
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

local function ShowConditionallyO( quest )
	local completed;
	if ( ns.db.removeOneOff == true ) and ( quest ) then
		completed = IsQuestFlaggedCompleted( quest )
		if ( completed == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyOI( index, quest )
	local completed;
	if ( ns.db.removeOneOff == true ) and ( quest > 0 ) then
		completed = IsQuestFlaggedCompleted( quest )
		if ( completed == true ) then
			return false
		end
		local questObjectives = GetQuestObjectives( quest )
		if questObjectives then
			for k,v in pairs( questObjectives ) do
				if ( index == k ) then
					for i,j in pairs( v ) do
						if ( i == "finished" ) then
							if ( j == true ) then
								return false
							end
							break
						end
					end
				end
			end
		end
	end
	return true
end

local function ShowConditionallyS( quest )
	local completed;
	if ( ns.db.removeSeasonal == true ) and ( quest > 0 ) then
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
				if pin.aID then
					if ( pin.aID == 910 ) then
						if ( ShowConditionallyE( pin.aID, pin.index ) == true ) then
							if ( ShowConditionallyS( pin.quest ) == true ) then
								return coord, nil, ns.textures[ns.db.iconDungeonElders],
									ns.db.iconScale * ns.scaling[ns.db.iconDungeonElders], ns.db.iconAlpha
							end
						end
					elseif ( pin.aID == 911 ) or ( pin.aID == 912 ) or ( pin.aID == 1396 ) or
							( pin.aID == 6006 ) or ( pin.aID == 17321 ) then
						if ( ShowConditionallyE( pin.aID, pin.index ) == true ) then
							if ( ShowConditionallyS( pin.quest ) == true ) then
								return coord, nil, ns.textures[ns.db.iconZoneElders],
									ns.db.iconScale * ns.scaling[ns.db.iconZoneElders], ns.db.iconAlpha
							end
						end
					elseif ( pin.aID == 914 ) or ( pin.aID == 915 ) then
						if ( ShowConditionallyE( pin.aID, pin.index ) == true ) then
							if ( ShowConditionallyS( pin.quest ) == true ) then
								return coord, nil, ns.textures[ns.db.iconFactionElders],
									ns.db.iconScale * ns.scaling[ns.db.iconFactionElders], ns.db.iconAlpha
							end
						end
					end
				elseif pin.quest then
					if ( pin.quest == 63213 ) or ( pin.quest == 63213 ) then
						if ( ShowConditionallyS( pin.quest ) == true ) then
							return coord, nil, ns.textures[ns.db.iconFactionElders],
								ns.db.iconScale * ns.scaling[ns.db.iconFactionElders], ns.db.iconAlpha
						end
					elseif ( pin.quest == 56842 ) or ( pin.quest == 56842 ) then
						if ( ShowConditionallyO( pin.quest ) == true ) then
							return coord, nil, ns.textures[ns.db.iconPreservation],
								ns.db.iconScale * ns.scaling[ns.db.iconPreservation], ns.db.iconAlpha
						end
					elseif ( pin.quest == 56903 ) or ( pin.quest == 56904 ) or ( pin.quest == 56905 )
												or ( pin.quest == 56906 ) then
						if IsQuestFlaggedCompleted( 56842 ) == true then
							if ( ShowConditionallyOI( pin.index, pin.quest ) == true ) then
								return coord, nil, ns.textures[ns.db.iconCrown],
									ns.db.iconScale * ns.scaling[ns.db.iconCrown] * 0.5, ns.db.iconAlpha
							end
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

-- ---------------------------------------------------------------------------------------------------------------------------------

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
				removeOneOff = {
					name = "Remove \"one time only\" and seasonal quests if completed by " ..ns.name,
					desc = "Primarily the Lunar Preservation quest for visiting moonwells\n"
							.."and the four \"Crown of...\" quests which follow on from that",
					type = "toggle",
					width = "full",
					arg = "removeOneOff",
					order = 4,
				},
				removeSeasonal = {
					name = "Remove Elder marker if completed this season by " ..ns.name,
					desc = "Achievement Elders are repeatable each season",
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					order = 5,
				},
				removeEver = {
					name = "Remove marker if ever completed on this account",
					desc = "If any of your characters has completed the achievement",
					type = "toggle",
					width = "full",
					arg = "removeEver",
					order = 6,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Map Pin Selections"],
			inline = true,
			args = {
				iconZoneElders = {
					type = "range",
					name = L["Zones"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Coin"] .."\n8 = " ..L["Deep Green Coin"] .."\n9 = "
							..L["Deep Pink Coin"] .."\n10 = " ..L["Deep Red Coin"] .."\n11 = "
							..L["Green Coin"] .."\n12 = " ..L["Light Blue Coin"] .."\n13 = "
							..L["Pink Coin"] .."\n14 = " ..L["Purple Coin"] .."\n15 = " ..L["Teal Coin"]
							.."\n16 = " ..L["Original Coin"], 
					min = 1, max = 16, step = 1,
					arg = "iconZoneElders",
					order = 10,
				},
				iconDungeonElders = {
					type = "range",
					name = L["Dungeons"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Coin"] .."\n8 = " ..L["Deep Green Coin"] .."\n9 = "
							..L["Deep Pink Coin"] .."\n10 = " ..L["Deep Red Coin"] .."\n11 = "
							..L["Green Coin"] .."\n12 = " ..L["Light Blue Coin"] .."\n13 = "
							..L["Pink Coin"] .."\n14 = " ..L["Purple Coin"] .."\n15 = " ..L["Teal Coin"]
							.."\n16 = " ..L["Original Coin"], 
					min = 1, max = 16, step = 1,
					arg = "iconDungeonElders",
					order = 11,
				},
				iconFactionElders = {
					type = "range",
					name = L["Factions"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Coin"] .."\n8 = " ..L["Deep Green Coin"] .."\n9 = "
							..L["Deep Pink Coin"] .."\n10 = " ..L["Deep Red Coin"] .."\n11 = "
							..L["Green Coin"] .."\n12 = " ..L["Light Blue Coin"] .."\n13 = "
							..L["Pink Coin"] .."\n14 = " ..L["Purple Coin"] .."\n15 = " ..L["Teal Coin"]
							.."\n16 = " ..L["Original Coin"], 
					min = 1, max = 16, step = 1,
					arg = "iconFactionElders",
					order = 12,
				},
				iconPreservation = {
					type = "range",
					name = L["Lunar Preservation"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Coin"] .."\n8 = " ..L["Deep Green Coin"] .."\n9 = "
							..L["Deep Pink Coin"] .."\n10 = " ..L["Deep Red Coin"] .."\n11 = "
							..L["Green Coin"] .."\n12 = " ..L["Light Blue Coin"] .."\n13 = "
							..L["Pink Coin"] .."\n14 = " ..L["Purple Coin"] .."\n15 = " ..L["Teal Coin"]
							.."\n16 = " ..L["Original Coin"], 
					min = 1, max = 16, step = 1,
					arg = "iconPreservation",
					order = 13,
				},
				iconCrown = {
					type = "range",
					name = L["Crown of... Quests"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Coin"] .."\n8 = " ..L["Deep Green Coin"] .."\n9 = "
							..L["Deep Pink Coin"] .."\n10 = " ..L["Deep Red Coin"] .."\n11 = "
							..L["Green Coin"] .."\n12 = " ..L["Light Blue Coin"] .."\n13 = "
							..L["Pink Coin"] .."\n14 = " ..L["Purple Coin"] .."\n15 = " ..L["Teal Coin"]
							.."\n16 = " ..L["Original Coin"], 
					min = 1, max = 16, step = 1,
					arg = "iconCrown",
					order = 14,
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
					..NORMAL_FONT_COLOR_CODE .."/lf" ..HIGHLIGHT_FONT_COLOR_CODE .." - Show this panel\n",
					order = 22, },
			},
		},
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_LunarFestival_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "LunarFestival" )
 end

-- ---------------------------------------------------------------------------------------------------------------------------------

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			-- Maps here will not propagate upwards
			if ( map.mapID == 33 ) or -- Blackrock Mountain - Blackrock Spire
				( map.mapID == 34 ) or -- Blackrock Mountain - Blackrock Caverns
				( map.mapID == 35 ) or -- Blackrock Mountain - Blackrock Depths
				( map.mapID == 84 ) or -- Stormwind
				( map.mapID == 85 ) or -- Orgrimmar
				( map.mapID == 87 ) or -- Ironforge
				( map.mapID == 88 ) or -- Thunder Bluff
				( map.mapID == 89 ) or -- Darnassus
				( map.mapID == 90 ) or -- Undercity
				( map.mapID == 203 ) or -- Vashj'ir
				( map.mapID == 224 ) then -- Stranglethorn Vale
			elseif coords then
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
						if ( pin.aID ) then
							AddToContinent()
						elseif ( pin.quest ) then
							AddToContinent()
						elseif ( pin.index ) then
							print("Something went wrong")
							AddToContinent()
						end
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

-- ---------------------------------------------------------------------------------------------------------------------------------

ns.timeElapsed, ns.timeElapsed2, ns.oldCount, ns.countUA, ns.spellUA = 0, 0;
local frameOnUpdate = CreateFrame( "Frame", "LunarFestivalOnUpdate", UIParent )
frameOnUpdate:HookScript("OnUpdate", function(self, elapsed)
	ns.timeElapsed = ns.timeElapsed + elapsed
	if ns.timeElapsed > 1 then 
		ns.timeElapsed = 0
		if ( IsOnQuest( 56842 ) == true ) then -- Lunar Preservation
			if ( ns.db.lpBuffCount[ns.name] == nil ) then ns.db.lpBuffCount[ns.name] = 0 end
			for i = 1, 40 do
				_, _, ns.countUA, _, _, _, _, _, _, ns.spellUA = UnitAura( "player", i, "HELPFUL" )
				if ns.spellUA == 303601 then
					if ( ns.oldCount == nil ) then ns.oldCount = ns.countUA end
					if ns.countUA > ns.oldCount then
						ns.db.lpBuffCount[ns.name] = ns.db.lpBuffCount[ns.name] + 1
						ns.oldCount = ns.countUA
					end
					break
				end
			end
		else
			ns.db.lpBuffCount[ns.name] = nil
		end
	end
	ns.timeElapsed2 = ns.timeElapsed2 + elapsed
	if ns.timeElapsed2 > 3 then
		ns.timeElapsed2 = 0
		pluginHandler:Refresh()
	end
end)

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_LunarFestival1, SLASH_LunarFestival2 = "/lf", "/lunar"

local function Slash( options )

	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "LunarFestival" )
	if ( ns.version >= 100000 ) then
		print( ns.colour.prefix ..L["Lunar Festival"] ..": " ..ns.colour.highlight 
			.."Try the Minimap AddOn Menu (below the Calendar)" )
	end
end

SlashCmdList[ "LunarFestival" ] = function( options ) Slash( options ) end