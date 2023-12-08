--[[
                                ----o----(||)----oo----(||)----o----

                                             EA Pandaria

                                     v1.35 - 30th November 2023								  
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

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
							removeChar = true, removeEver = false, showWeekly = false,
							iconEAPandaria = 11, iconEATreasure = 12, iconEARiches = 13,
							iconEAGlorious = 14, iconEALove = 15, iconChampion = 9,
							icon_EyesGround = 10, iconPilgrimage = 8, iconKillingTime = 6, } }
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

else
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
	if ns.locale == "enUS" then
		L["Grey"] = "Gray"
	end
end

ns.name = UnitName( "player" ) or "Character"

if ns.locale == "deDE" then
	L["Achievement"] = "Erfolg"
	L["AddOn Description"] = "Alle Fundorte der Erkundungserfolge von Pandaria"
	L["Celestial Challenge"] = "Erhabene Herausforderung"
	L["Extreme Treasure Hunter"] = "Extremjäger verlorener Schätze"
	L["Glorious!"] = "Prächtig!"
	L["Legends"] = "Zeitlose Legenden"
	L["Love Heart"] = "Liebesherz"
	L["Pink"] = "Rosa"
	L["Pirates Booty"] = "Wo Piraten sind,\ngibt es reichlich Beute"
	L["Riches"] = "Reichtümer von Pandaria"
	L["Riches / Legends"] = "Reichtümer / Legenden"
	L["Squirrel"] = "Eichhörnchen"
	L["Timeless Champion"] = "Zeitloser Champion"
	L["Treasure"] = "...ist des anderen Brot"
	L["Treasure Everywhere"] = "Meine Schätze!"
	L["Treasure Title"] = "Schatz"
	L["Zarhym Altogether"] = "Bis auf die Knochen"
	L["Zul' Again"] = "Zul'Nochmal"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["Achievement"] = "Logro"
	L["AddOn Description"] = "Todas las ubicaciones de logros de exploración de Pandaria"
	L["Celestial Challenge"] = "Desafío Celestial"
	L["Extreme Treasure Hunter"] = "El cazatesoros definitivo"
	L["Glorious!"] = "¡Glorioso!"
	L["Gold"] = "Oro"
	L["Legends"] = "Leyendas intemporales"
	L["Love Heart"] = "Amor corazon"
	L["Pink"] = "Rosa"
	L["Pirates Booty"] = "Cuando el río\nsuena, tesoros piratas lleva"
	L["Riches"] = "Riquezas de Pandaria"
	L["Riches / Legends"] = "Riquezas / Leyendas"
	L["Squirrel"] = "Ardilla"
	L["Timeless Champion"] = "Campeón intemporal"
	L["Treasure"] = "Más vale tesoro en mano que enterrado"
	L["Treasure Everywhere"] = "¡Tesoros! ¡Tesoros por todas partes!"
	L["Treasure Title"] = "Tesoro"
	L["Zarhym Altogether"] = "Zarhym entero"

elseif ns.locale == "frFR" then
	L["Achievement"] = "Haut fait"
	L["AddOn Description"] = "Tous les emplacements des réalisations d'exploration de Pandarie"
	L["Celestial Challenge"] = "Un défi céleste"
	L["Extreme Treasure Hunter"] = "Chasseur de trésors de l’extrême"
	L["Glorious!"] = "Victoire!"
	L["Gold"] = "Or"
	L["Legends"] = "Les légendes du Temps figé"
	L["Love Heart"] = "Coeur d'amour"
	L["Pink"] = "Rose"
	L["Pirates Booty"] = "Là où y a\ndes pirates, y a des trésors"
	L["Riches"] = "Les richesses de la Pandarie"
	L["Riches / Legends"] = "Les richesses / légendes"
	L["Squirrel"] = "Ecureuil"
	L["Timeless Champion"] = "Champion du Temps figé"
	L["Treasure"] = "…Est un trésor pour d’autres"
	L["Treasure Everywhere"] = "Des trésors, encore des trésors"
	L["Treasure Title"] = "Trésor"
	L["Zarhym Altogether"] = "Z’avez pas vu Zarhym ?"

elseif ns.locale == "itIT" then
	L["Achievement"] = "Impresa"
	L["AddOn Description"] = "Tutte le posizioni degli obiettivi di esplorazione di Pandaria"
	L["Celestial Challenge"] = "Sfida dei Celestiali"
	L["Extreme Treasure Hunter"] = "L'archeologo"
	L["Glorious!"] = "Glorioso!"
	L["Gold"] = "Oro"
	L["Pink"] = "Rosa"
	L["Legends"] = "Leggende senza tempo"
	L["Love Heart"] = "Amore Cuore"
	L["Pirates Booty"] = "Dove ci sono\npirati, ci sono bottini"
	L["Riches"] = "Le ricchezze di Pandaria"
	L["Riches / Legends"] = "Le ricchezze / Leggende"
	L["Squirrel"] = "Scoiattolo"
	L["Timeless Champion"] = "Campione Senza Tempo"
	L["Treasure"] = "...è il tesoro di un altro"
	L["Treasure Everywhere"] = "Tesori, tesori ovunque"
	L["Treasure Title"] = "Tesoro"
	L["Zarhym Altogether"] = "Zarhymstein"
	L["Zul' Again"] = "Troll"

elseif ns.locale == "koKR" then
	L["Achievement"] = "업적"
	L["AddOn Description"] = "모든 판다리아 탐험 업적 위치"
	L["Celestial Challenge"] = "천신의 시험"
	L["Extreme Treasure Hunter"] = "보물찾기 하기 딱 좋은 날씨네"
	L["Glorious!"] = "영광스럽군요!"
	L["Gold"] = "금"
	L["Pink"] = "분홍색"
	L["Legends"] = "영원한 전설"
	L["Love Heart"] = "사랑의 마음"
	L["Pirates Booty"] = "즐거운 심해 여행\n되라고!"
	L["Riches"] = "흔한 판다리아의 금은보화"
	L["Riches / Legends"] = "보화 / 전설"
	L["Squirrel"] = "다람쥐"
	L["Timeless Champion"] = "영원의 용사"
	L["Treasure"] = "나에겐 보물"
	L["Treasure Everywhere"] = "보물이 차올라서 가방을 들어"
	L["Treasure Title"] = "보물"
	L["Zarhym Altogether"] = "자림 올투게더"
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Achievement"] = "Conquista"
	L["AddOn Description"] = "Todos os locais de conquistas da exploração de Pandária"
	L["Celestial Challenge"] = "Desafio Celestial"
	L["Extreme Treasure Hunter"] = "Caçador de Tesouro Radical"
	L["Glorious!"] = "Magnífico!"
	L["Gold"] = "Ouro"
	L["Legends"] = "Lendas Perenes"
	L["Love Heart"] = "Coração de amor"
	L["Pink"] = "Rosa"
	L["Pirates Booty"] = "Onde Há\nPirata, Há Saque"
	L["Riches"] = "Riqueza de Pandária"
	L["Riches / Legends"] = "Riqueza / Lendas"
	L["Squirrel"] = "Esquilo"
	L["Timeless Champion"] = "Campeão Perene"
	L["Treasure"] = "... tesouro pra outro"
	L["Treasure Everywhere"] = "Tesouro, tesouro em toda a parte"
	L["Treasure Title"] = "Tesouro"
	L["Zarhym Altogether"] = "Zarhym Tudojunto"
	L["Zul' Again"] = "Zul'Dinovo"

elseif ns.locale == "ruRU" then
	L["Achievement"] = "Достижение"
	L["AddOn Description"] = "Все локации достижений исследования Пандарии"
	L["Celestial Challenge"] = "Небесное испытание"
	L["Extreme Treasure Hunter"] = "Исключительный искатель сокровищ"
	L["Glorious!"] = "Славная победа"
	L["Gold"] = "Золото"
	L["Legends"] = "Легенды вне времени"
	L["Love Heart"] = "Люблю сердце"
	L["Pink"] = "Розовый"
	L["Pirates Booty"] = "Где пираты,\nтам трофеи"
	L["Riches"] = "Богатства Пандарии"
	L["Riches / Legends"] = "Богатства / Легенды"
	L["Squirrel"] = "Белка"
	L["Timeless Champion"] = "Вневременный герой"
	L["Treasure"] = "...то другому прибыль"
	L["Treasure Everywhere"] = "Сокровища, везде сокровища!"
	L["Treasure Title"] = "Сокровище"
	L["Zarhym Altogether"] = "Целый Зарим"
	L["Zul' Again"] = "Зул'опять"

elseif ns.locale == "zhCN" then
	L["Achievement"] = "成就"
	L["AddOn Description"] = "潘达利亚所有探索成就地点"
	L["Celestial Challenge"] = "天神挑战者"
	L["Extreme Treasure Hunter"] = "超级宝藏猎人"
	L["Glorious!"] = "战绩彪炳！"
	L["Gold"] = "金子"
	L["Legends"] = "永恒的传奇"
	L["Love Heart"] = "爱心"
	L["Pink"] = "粉色的"
	L["Pirates Booty"] = "哪里有海盗\n哪里就有宝藏"
	L["Riches"] = "潘达利亚的财富"
	L["Riches / Legends"] = "财富 / 传奇"
	L["Squirrel"] = "松鼠"
	L["Timeless Champion"] = "不朽的勇士"
	L["Treasure"] = "我之蜜糖"
	L["Treasure Everywhere"] = "宝藏，到处都是宝藏"
	L["Treasure Title"] = "宝藏"
	L["Zarhym Altogether"] = "完整的扎西姆"
	L["Zul' Again"] = "又见祖尔"

elseif ns.locale == "zhTW" then
	L["Achievement"] = "成就"
	L["AddOn Description"] = "潘達利亞所有探索成就地點"
	L["Celestial Challenge"] = "天神挑戰者"
	L["Extreme Treasure Hunter"] = "超級寶藏獵人"
	L["Glorious!"] = "戰績彪炳！"
	L["Gold"] = "金子"
	L["Legends"] = "永恆的傳奇"
	L["Love Heart"] = "愛心"
	L["Pink"] = "粉色的"
	L["Pirates Booty"] = "哪裡有海盜\n哪裡就有寶藏"
	L["Riches"] = "潘達利亞的財富"
	L["Riches / Legends"] = "財富 / 傳奇"
	L["Squirrel"] = "松鼠"
	L["Timeless Champion"] = "不朽的勇士"
	L["Treasure"] = "我之蜜糖"
	L["Treasure Everywhere"] = "寶藏，到處都是寶藏"
	L["Treasure Title"] = "寶藏"
	L["Zarhym Altogether"] = "完整的紮西姆"
	L["Zul' Again"] = "又見祖爾"
	
else
	L["AddOn Description"] = "All Pandaria exploration achievement locations"
	L["Legends"] = "Timeless Legends"
	L["Pirates Booty"] = "Where There's\nPirates, There's Booty"
	L["Riches"] = "Riches of Pandaria"
	L["Riches / Legends"] = "Riches / Legends"
	L["Treasure"] = "Is another Man's Treasure"
	L["Treasure Everywhere"] = "Treasure, Treasure Everywhere"
	L["Treasure Title"] = "Treasure"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[mapFile] and ns.points[mapFile][coord]

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
		GameTooltip:AddLine( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..ns.name ..")"
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
			( completedMe == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..ns.name ..")" ) 
								or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..ns.name ..")" ) )
		if ( pin.aID == 8078 ) then -- Zul Again
			for i = 1, 2 do
				aName, _, completed, quantity, reqQuantity = GetAchievementCriteriaInfo( pin.aID, i )
				GameTooltip:AddDoubleLine( ns.colour.highlight ..quantity .."/" ..reqQuantity .." " ..aName,
					( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..ns.name ..")" ) 
										or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..ns.name ..")" ) )
			end
		elseif ( pin.aID == 8784 ) or ( pin.aID == 8724 ) then -- Timeless Legends & Pilgrimage
			for i = 1, 4 do
				aName, _, completed = GetAchievementCriteriaInfo( pin.aID, i )
				GameTooltip:AddDoubleLine( ns.colour.highlight ..aName,
					( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..ns.name ..")" ) 
										or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..ns.name ..")" ) )
			end
		end
		if pin.aIndex then
			aName, _, completed = GetAchievementCriteriaInfo( pin.aID, pin.aIndex )
			GameTooltip:AddDoubleLine( ns.colour.highlight ..aName,
				( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..ns.name ..")" ) 
									or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..ns.name ..")" ) )
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
				( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
									or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
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
						ns.db.iconScale * ns.scaling[ 4 ], ns.db.iconAlpha
				elseif pin.aList then
					return coord, nil, ns.textures[ ns.db.iconEAPandaria ],
						ns.db.iconScale * ns.scaling[ns.db.iconEAPandaria ] * 2, ns.db.iconAlpha
				elseif not pin.aID then
					return coord, nil, ns.textures[ ns.db.iconEAPandaria ],
						ns.db.iconScale * ns.scaling[ ns.db.iconEAPandaria ] *2, ns.db.iconAlpha
				elseif ( ShowConditionallyE( pin.aID ) == true ) then
					if ( pin.aID == 6350 ) then -- To All the Squirrels I Once Caressed?
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconEALove ],
								ns.db.iconScale * ns.scaling[ ns.db.iconEALove ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 7284 ) or ( pin.aID == 8729 ) then
						-- Is Another Man's Treasure and Treasure, Treasure Everywhere
						if ( ShowConditionallyQ( pin.aQuest ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconEATreasure ],
								ns.db.iconScale * ns.scaling[ ns.db.iconEATreasure ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 7439 ) then -- Glorious
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconEAGlorious ],
								ns.db.iconScale * ns.scaling[ ns.db.iconEAGlorious ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 7932 ) then -- I'm In Your Base Killing Your Dudes
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) 
								and ( ns.faction == pin.faction ) then
							if pin.aQuest then
								if ( ShowConditionallyQ( pin.aQuest ) == true ) then
									return coord, nil, ns.textures[ ns.db.iconKillingTime ],
										ns.db.iconScale * ns.scaling[ ns.db.iconKillingTime ], ns.db.iconAlpha
								end
							else
								return coord, nil, ns.textures[ ns.db.iconKillingTime ],
									ns.db.iconScale * ns.scaling[ ns.db.iconKillingTime ], ns.db.iconAlpha
							end
						end
					elseif ( pin.aID == 7997 ) then --  Riches of Pandaria
						if ( ShowConditionallyQ( pin.aQuest ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconEARiches ],
								ns.db.iconScale * ns.scaling[ ns.db.iconEARiches ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 8712 ) then -- KillingTime
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconKillingTime ],
								ns.db.iconScale * ns.scaling[ ns.db.iconKillingTime ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 8714 ) then -- Timeless Champion
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconChampion ],
								ns.db.iconScale * ns.scaling[ ns.db.iconChampion ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 8724 ) then -- Pilgrimage / Time-Lost Shrines
						if ( ShowConditionallyC( pin.aID ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconPilgrimage ],
								ns.db.iconScale * ns.scaling[ ns.db.iconPilgrimage ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 8725 ) then -- Eyes on the Ground
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_EyesGround ],
								ns.db.iconScale * ns.scaling[ ns.db.icon_EyesGround ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 8726 ) or ( pin.aID == 8727 ) or ( pin.aID == 8743 ) then
						-- Extreme Treasure Hunter, Where There's Pirates, There's Booty, Zarhym Altogether
						if ( ns.db.showWeekly == true ) then
							if ( ShowConditionallyQ( pin.aQuest ) == true ) then
								return coord, nil, ns.textures[ ns.db.iconEAGlorious ],
									ns.db.iconScale * ns.scaling[ ns.db.iconEAGlorious ], ns.db.iconAlpha
							end
						elseif ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconEAGlorious ],
								ns.db.iconScale * ns.scaling[ ns.db.iconEAGlorious ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 8730 ) then -- Rolo's Riddle
						if ( ShowConditionallyQ( pin.aQuest ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconEAPandaria ],
								ns.db.iconScale * ns.scaling[ ns.db.iconEAPandaria ], ns.db.iconAlpha
						end
					elseif ( pin.aID == 8535 ) then -- Celestial Challenge
						if ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconEAGlorious ],
								ns.db.iconScale * ns.scaling[ ns.db.iconEAGlorious ], ns.db.iconAlpha
						elseif ( ns.db.showWeekly == true ) then
							if ( ShowConditionallyQ( pin.aQuest ) == true ) then
								return coord, nil, ns.textures[ ns.db.iconEAGlorious ],
									ns.db.iconScale * ns.scaling[ ns.db.iconEAGlorious ], ns.db.iconAlpha
							end
						end
					elseif ( pin.aID == 8784 ) then -- Timeless Legends
						if ( ShowConditionallyC( pin.aID ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconEARiches ],
								ns.db.iconScale * ns.scaling[ ns.db.iconEARiches ], ns.db.iconAlpha
						end
					elseif ( ShowConditionallyC( pin.aID, pin.aIndex ) == true ) then
						-- 8078 Zul Again, 7329 Pandaren Cuisine, etc
						if pin.faction then
							if ( ns.faction == pin.faction ) then
								return coord, nil, ns.textures[ ns.db.iconEAPandaria ],
									ns.db.iconScale * ns.scaling[ ns.db.iconEAPandaria ], ns.db.iconAlpha
							end
						else
							return coord, nil, ns.textures[ ns.db.iconEAPandaria ],
								ns.db.iconScale * ns.scaling[ ns.db.iconEAPandaria ], ns.db.iconAlpha
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
				removeChar = {
					name = "Remove the pin if the criteria has been completed by " ..ns.name,
					desc = "\nThis is for each criteria as you progress.\n\n"
							.."Note that for \"Is Another Man's Treasure\" you only need 20 items.\n"
							.."The excess items will still appear on the map. Similarly, all the\n"
							.."Moss-Covered Chests on the Timeless Isle will still be shown",
					type = "toggle",
					width = "full",
					arg = "removeChar",
					order = 4,
				},
				showWeekly = {
					name = "But allow the pin to reappear if it is a repeatable quest objective",
					desc = "\nSome of the Timeless Isle achievements require you to complete a \n"
						.."few weekly/daily quests. Check this option to show a pin if the\n"
						.."quest is available again",
					type = "toggle",
					width = "full",
					arg = "showWeekly",
					order = 5,
				},
				removeEver = {
					name = "Remove the pin if ever fully completed on this account",
					desc = "\nIf any of your characters has completed the achievement\n"
							.."then all markers for the achievement will be removed.\n\n"
							.."The two above settings will also be ignored",
					type = "toggle",
					width = "full",
					arg = "removeEver",
					order = 6,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Icon Selection"],
			inline = true,
			args = {
				iconEAPandaria = {
					type = "range",
					name = L["Zul' Again"] ..", Summary, Etc",
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"], 
					min = 1, max = 14, step = 1,
					arg = "iconEAPandaria",
					order = 7,
				},
				iconEATreasure = {
					type = "range",
					name = L["Treasure Title"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"] .."\n\n"
							..ns.colour.highlight .."\"" ..L["Treasure"] .."\"" ..ns.colour.plaintext
							.." &\n" ..ns.colour.highlight .."\"" ..L["Treasure Everywhere"] .."\"", 
					min = 1, max = 14, step = 1,
					arg = "iconEATreasure",
					order = 8,
				},
				iconEARiches = {
					type = "range",
					name = L["Riches / Legends"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"] .."\n\n"
							..ns.colour.highlight .."\"" ..L["Riches"] .."\"" ..ns.colour.plaintext
							.." &\n" ..ns.colour.highlight .."\"" ..L["Legends"] .."\"", 
					min = 1, max = 14, step = 1,
					arg = "iconEARiches",
					order = 9,
				},
				iconEAGlorious = {
					type = "range",
					name = L["Glorious!"] .." / TI Repeatables",
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"] .."\n\n"
							..ns.colour.highlight .."\"" ..L["Glorious!"] .."\"" ..ns.colour.plaintext ..", "
							..ns.colour.highlight .."\"" ..L["Pirates Booty"] .."\"" ..ns.colour.plaintext 
							..",\n" ..ns.colour.highlight .."\"" ..L["Extreme Treasure Hunter"] .."\""
							..ns.colour.plaintext ..",\n" ..ns.colour.highlight
							.."\"" ..L["Zarhym Altogether"] .."\"" ..ns.colour.plaintext .." &\n"
							..ns.colour.highlight .."\"" ..L["Celestial Challenge"] .."\"", 
					min = 1, max = 14, step = 1,
					arg = "iconEAGlorious",
					order = 10,
				},
				iconEALove = {
					type = "range",
					name = L["Squirrel"] .." /Love",
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"]
							.."\n15 = " ..L["Love Heart"], 
					min = 1, max = 15, step = 1,
					arg = "iconEALove",
					order = 11,
				},
				iconChampion = {
					type = "range",
					name = L["Timeless Champion"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"], 
					min = 1, max = 14, step = 1,
					arg = "iconChampion",
					order = 12,
				},
				icon_EyesGround = {
					type = "range",
					name = L["Eyes on the Ground"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"], 
					min = 1, max = 14, step = 1,
					arg = "icon_EyesGround",
					order = 13,
				},
				iconPilgrimage = {
					type = "range",
					name = L["Pilgrimage / Shrines"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"], 
					min = 1, max = 14, step = 1,
					arg = "iconPilgrimage",
					order = 14,
				},
				iconKillingTime = {
					type = "range",
					name = L["Killing Time & Base"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							..L["Mana Orb"] .."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] 
							.."\n10 = " ..L["Stars"] .."\n11 = " ..L["Achievement"] .." - " ..L["Gold"]
							.."\n12 = " ..L["Achievement"] .." - " ..L["Blue"] .."\n13 = "
							..L["Achievement"] .." - " ..L["Pink"] .."\n14 = " ..L["Achievement"] .."\n\n"
							..ns.colour.highlight .."\"Killing Time\"" ..ns.colour.plaintext
							.." &\n" ..ns.colour.highlight .."\"I'm In Your Base Killing...\"",  
					min = 1, max = 14, step = 1,
					arg = "iconKillingTime",
					order = 15,
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