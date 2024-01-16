--[[
                                ----o----(||)----oo----(||)----o----

                                            Hallow's End

                                      v2.28 - 12th January 2024
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...
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

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								removeDailies = true, removeSeasonal = true, removeEver = false,
								iconTricksTreat = 11, iconDailies = 10, iconSpecial = 15 } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetMapArtID = C_Map.GetMapArtID
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
--local GetMapInfo = C_Map.GetMapInfo -- phase checking during testing
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local next = _G.next
local HandyNotes = _G.HandyNotes

local _, _, _, version = GetBuildInfo()
if version < 40000 then
	continents[ 1414 ] = true -- Kalimdor
	continents[ 1415 ] = true -- Eastern Kingdoms
	continents[ 1945 ] = true -- Outland
	continents[ 113 ] = true -- Northrend
	continents[ 947 ] = true -- Azeroth
else
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
end

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

ns.name = UnitName( "player" ) or "Character"
ns.faction = UnitFactionGroup( "player" )

if ns.locale == "deDE" then
	L["AddOn Description"] = "Hilfe für Erfolge und Quests in Schlotternächte"
	L["Bat"] = "Schläger"
	L["Candy Swirl"] = "Süßigkeitenwirbel"
	L["Cat"] = "Katze"
	L["Evil Pumpkin"] = "Böser Kürbis"
	L["Ghost"] = "Geist"
	L["Hallow's End"] = "Schlotternächte"
	L["Other Candy Buckets"] = "Andere Süßigkeiteneimer"
	L["Pumpkin"] = "Kürbis"
	L["Rotten Hallow Dailies"] = "Tägliche Quests für Fauliges Schlottern"
	L["Tricks and Treats"] = "Süßes oder Saures"
	L["Witch"] = "Hexe"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["AddOn Description"] = "Ayuda para logros y misiones en Halloween"
	L["Bat"] = "Murciélago"
	L["Candy Swirl"] = "Remolino de caramelo"
	L["Cat"] = "Gata"
	L["Evil Pumpkin"] = "Calabaza diabolica"
	L["Ghost"] = "Fantasma"
	L["Hallow's End"] = "Halloween"
	L["Other Candy Buckets"] = "Otros cubos de caramelos"
	L["Pumpkin"] = "Calabaza"
	L["Rotten Hallow Dailies"] = "Misiones diarias de Santificación Podrida"
	L["Tricks and Treats"] = "Truco o trato"
	L["Witch"] = "Bruja"

elseif ns.locale == "frFR" then
	L["AddOn Description"] = "Aide pour les réalisations et les quêtes dans Sanssaint"
	L["Bat"] = "Chauve souris"
	L["Candy Swirl"] = "Tourbillon de bonbons"
	L["Cat"] = "Chatte"
	L["Evil Pumpkin"] = "Citrouille maléfique"
	L["Ghost"] = "Fantôme"
	L["Hallow's End"] = "Sanssaint"
	L["Other Candy Buckets"] = "Autres seaux à bonbons"
	L["Pumpkin"] = "Citrouille"
	L["Rotten Hallow Dailies"] = "Quêtes quotidiennes de Sanssaint Ruinée"
	L["Tricks and Treats"] = "Bonbons et blagues"
	L["Witch"] = "Sorcière"

elseif ns.locale == "itIT" then
	L["AddOn Description"] = "Aiuto per obiettivi e missioni in Veglia delle Ombre"
	L["Bat"] = "Pipistrello"
	L["Candy Swirl"] = "Vortice di caramelle"
	L["Cat"] = "Gatta"
	L["Evil Pumpkin"] = "Zucca cattiva"
	L["Hallow's End"] = "Veglia delle Ombre"
	L["Tricks and Treats"] = "Dolcetti o scherzetti"
	L["Rotten Hallow Dailies"] = "Missioni giornaliere di Il guastafeste"
	L["Other Candy Buckets"] = "Altri secchielli per caramelle Secchi delle Caramelle"
	L["Pumpkin"] = "Zucca"
	L["Ghost"] = "Fantasma"
	L["Witch"] = "Strega"

elseif ns.locale == "koKR" then
	L["AddOn Description"] = "할로윈 축제의 업적 및 퀘스트에 대한 도움말"	
	L["Bat"] = "박쥐"
	L["Candy Swirl"] = "캔디 소용돌이"
	L["Cat"] = "고양이"
	L["Evil Pumpkin"] = "사악한 호박"
	L["Ghost"] = "귀신"
	L["Hallow's End"] = "할로윈 축제"
	L["Other Candy Buckets"] = "기타 사탕 바구니"
	L["Pumpkin"] = "호박"
	L["Rotten Hallow Dailies"] = "부패한 할로윈 일일 퀘스트"
	L["Tricks and Treats"] = "할로윈"
	L["Witch"] = "마녀"
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["AddOn Description"] = "Ajuda para conquistas e missões em Noturnália"
	L["Bat"] = "Bastão"
	L["Candy Swirl"] = "redemoinho de doces"
	L["Cat"] = "Gata"
	L["Evil Pumpkin"] = "Abóbora Malvada"
	L["Ghost"] = "Fantasma"
	L["Hallow's End"] = "Noturnália"
	L["Other Candy Buckets"] = "Outras cestas de doces"
	L["Pumpkin"] = "Abóbora"
	L["Rotten Hallow Dailies"] = "Missões diárias do Arruinando Noturnália"
	L["Tricks and Treats"] = "Gostosuras e Travessuras"
	L["Witch"] = "Bruxa"

elseif ns.locale == "ruRU" then
	L["AddOn Description"] = "Справка по достижениям и квестам в Тыквовине"
	L["Bat"] = "Летучая мышь"
	L["Candy Swirl"] = "Конфетный вихрь"
	L["Cat"] = "Кот"
	L["Evil Pumpkin"] = "Злая тыква"
	L["Ghost"] = "Призрак"
	L["Hallow's End"] = "Тыквовин"
	L["Tricks and Treats"] = "Конфета или жизнь"
	L["Rotten Hallow Dailies"] = "Ежедневные задания Подпорченный Праздник"
	L["Other Candy Buckets"] = "Другие корзины конфет"
	L["Pumpkin"] = "Тыква"
	L["Witch"] = "Ведьма"

elseif ns.locale == "zhCN" then
	L["AddOn Description"] = "帮助万圣节的成就和任务"
	L["Bat"] = "蝙蝠"
	L["Candy Swirl"] = "糖果漩涡"
	L["Cat"] = "猫"
	L["Evil Pumpkin"] = "邪恶的南瓜"
	L["Ghost"] = "鬼"
	L["Hallow's End"] = "万圣节"
	L["Other Candy Buckets"] = "其他糖果篮"
	L["Pumpkin"] = "南瓜"
	L["Rotten Hallow Dailies"] = "糟糕的万圣节每日任务"
	L["Tricks and Treats"] = "的糖果"
	L["Witch"] = "巫婆"

elseif ns.locale == "zhTW" then
	L["AddOn Description"] = "幫助萬聖節的成就和任務"
	L["Bat"] = "蝙蝠"
	L["Candy Swirl"] = "糖果漩渦"
	L["Cat"] = "貓"
	L["Evil Pumpkin"] = "邪惡的南瓜"
	L["Ghost"] = "鬼"
	L["Hallow's End"] = "萬聖節"
	L["Other Candy Buckets"] = "其他糖果籃"
	L["Pumpkin"] = "南瓜"
	L["Rotten Hallow Dailies"] = "糟糕的萬聖節每日任務"
	L["Tricks and Treats"] = "的糖果"
	L["Witch"] = "巫婆"
	
else
	L["AddOn Description"] = "Help for Hallow's End achievements and quests"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]
	local completed, aName, completedMe;
	local bypassCoords, theramoreCheck = false, false

	if ( pin.achievement or pin.aIDA or pin.aIDH ) and not pin.iabc then
		if pin.aIDA or pin.aIDH then
			if pin.aIDA then
				if ns.faction == "Alliance" then
					_, aName, _, completed = GetAchievementInfo( pin.aIDA )
				end
			end
			if pin.aIDH then
				if ns.faction == "Horde" then
					_, aName, _, completed = GetAchievementInfo( pin.aIDH )
				end
			end		
		elseif pin.achievement then
			_, aName, _, completed = GetAchievementInfo( pin.achievement )
		end
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		if pin.index or pin.indexA or pin.indexH then
			if pin.indexA or pin.indexH then
				if pin.indexA then
					if ns.faction == "Alliance" then
						aName, _, completed = GetAchievementCriteriaInfo( pin.aIDA, pin.indexA )
					end
				end
				if pin.indexH then
					if ns.faction == "Horde" then
						aName, _, completed = GetAchievementCriteriaInfo( pin.aIDH, pin.indexH )
					end
				end		
			elseif pin.index then
				aName, _, completed = GetAchievementCriteriaInfo( pin.achievement, pin.index )
			end
			GameTooltip:AddDoubleLine( ns.colour.highlight.. aName,
						( completed == true ) and ( "\124cFF00FF00" ..L["Ever Completed"] .." (" ..ns.name ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Ever Completed"] .." (" ..ns.name ..")" ) )
		end
		if pin.quest then
			completed = IsQuestFlaggedCompleted( pin.quest )
			if pin.daily then
				GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "Daily Quest",
							( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
												or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
			else
				GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "This Season",
							( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
												or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
			end
		end
	else
		if pin.title then
			GameTooltip:SetText( ns.colour.prefix ..pin.title )
		elseif pin.location and pin.iabc then
			GameTooltip:SetText( ns.colour.prefix ..pin.location )
		end
		if pin.quest then
			completed = IsQuestFlaggedCompleted( pin.quest )
			if pin.daily then
				GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "Daily Quest",
							( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
												or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
			else
				GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "This Season",
							( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
												or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
												
				if mapFile == 70 and ns.faction == "Alliance" and not completed then
					theramoreCheck = true
				end
			end
		else
			bypassCoords = true
		end	
	end

 	if ( ( mapFile == 17 ) and ( GetMapArtID( mapFile ) ~= 18 ) ) or -- Blasted Lands Testing was 18 or 628 
		( ( mapFile == 18 ) and ( GetMapArtID( mapFile ) ~= 19 ) ) or -- Tirisfal Glades Testing was 19 or 628 
		( ( mapFile == 81 ) and ( GetMapArtID( mapFile ) ~= 86 ) ) or -- Silithus Testing was 86 or 962 
		( ( mapFile == 62 ) and ( GetMapArtID( mapFile ) ~= 67 ) ) then -- Darkshore Testing was 67 or 1176
		-- Theramore gave the same mapArtID but a Time Travelling debuff 123979 when correct
		-- Darkshore, when correct, gave a Time Travelling buff (not debuff) 290246
		-- Tirisfal, when correct, gave a Time Travelling buff (not debuff) 276827
		-- Blasted Lands, when correct, gave a Time Travelling buff (not debuff) 176111
		if not pin.neighbour then
			GameTooltip:AddLine( "\124cFFFF0000Wrong map/quest phase. Speak to Zidormi" )
		end
	elseif theramoreCheck then
		_, _, _, _, _, _, _, _, _, _, _, _, _, completed = GetAchievementInfo( 7523 )
		if not completed then _, _, _, _, _, _, _, _, _, _, _, _, _, completed = GetAchievementInfo( 7467 ) end
		if completed == true then
			local found = false
			for i=1,40 do
				local n,_,_,_,_,_,_,_,_,id=UnitDebuff("player",i)
				if not id then break end
				if id == 123979 then found = true break end
			end
			if found == false then
				GameTooltip:AddLine( "\124cFFFF0000Wrong map/quest phase. Speak to Zidormi" )
			end
		end
	end
	if pin.tip then
		GameTooltip:AddLine( ns.colour.plaintext ..pin.tip )
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
		if aIndex then
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

local function ShowConditionallyD( quest )
	local completed;
	if ( ns.db.removeDailies == true ) then
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
		local coord, v = next(t, prev)
		while coord do
			if v then
				if ( v.aIDA or v.aIDH ) then
					if v.aIDA then
						if ns.faction == "Alliance" then
							if v.daily then
								if ShowConditionallyE( v.aIDA ) == true then
									if ShowConditionallyD( v.quest ) == true then
										return coord, nil, ns.texturesS[ns.db.iconDailies],
											ns.db.iconScale * ns.scalingS[ns.db.iconDailies], ns.db.iconAlpha
									end
								end
							else
								if ( ( version < 40000 ) and v.iabc ) or ( ShowConditionallyE( v.aIDA ) == true ) then
									if ( ( version < 40000 ) and not v.ibc ) or ( version >= 40000 ) then
										if ShowConditionallyS( v.quest ) == true then
											return coord, nil, ns.texturesL[ns.db.iconTricksTreat], 
												ns.db.iconScale * ns.scalingL[ns.db.iconTricksTreat], ns.db.iconAlpha
										end
									end
								end
							end
						end
					end
					if v.aIDH then
						if ns.faction == "Horde" then
							if v.daily then
								if ShowConditionallyE( v.aIDH ) == true then
									if ShowConditionallyD( v.quest ) == true then
										return coord, nil, ns.texturesS[ns.db.iconDailies],
											ns.db.iconScale * ns.scalingS[ns.db.iconDailies], ns.db.iconAlpha
									end
								end
							else
								if ( ( version < 40000 ) and v.iabc ) or ( ShowConditionallyE( v.aIDH ) == true ) then
									if ( ( version < 40000 ) and not v.ibc ) or ( version >= 40000 ) then
										if ShowConditionallyS( v.quest ) == true then
											return coord, nil, ns.texturesL[ns.db.iconTricksTreat], 
												ns.db.iconScale * ns.scalingL[ns.db.iconTricksTreat], ns.db.iconAlpha
										end
									end
								end
							end
						end
					end
					
				elseif v.achievement then
					if v.achievement == 18360 then -- Non-faction Dragon Isles buckets
						if ShowConditionallyE( v.achievement, v.index ) == true then
							if ShowConditionallyS( v.quest ) == true then
								return coord, nil, ns.texturesL[ns.db.iconTricksTreat], 
									ns.db.iconScale * ns.scalingL[ns.db.iconTricksTreat], ns.db.iconAlpha
							end
						end
					else -- Some other Achievement - Check Your Head etc				
						if ShowConditionallyE( v.achievement, v.index ) == true then
							return coord, nil, ns.texturesS[ns.db.iconSpecial],
								ns.db.iconScale * ns.scalingS[ns.db.iconSpecial], ns.db.iconAlpha
						end
					end

				elseif v.faction and v.quest then
					-- Actually, so far all quests have a faction field
					if ( ( ns.faction == "Horde" ) and ( ( v.faction == "Neutral" ) or ( v.faction == "Horde" ) ) ) or
					   ( ( ns.faction == "Alliance" ) and ( ( v.faction == "Neutral" ) or ( v.faction == "Alliance" ) ) ) then
						-- That logic excludes new Pandas but shouldn't be a problem
						if v.daily then -- Mainly Garrison
							if ShowConditionallyD( v.quest ) == true then
								return coord, nil, ns.texturesS[ns.db.iconDailies],
									ns.db.iconScale * ns.scalingS[ns.db.iconDailies], ns.db.iconAlpha
							end
						elseif ShowConditionallyS( v.quest ) == true then -- Mainly extra candy buckets plus extra help pins
							return coord, nil, ns.texturesS[ns.db.iconSpecial],
								ns.db.iconScale * ns.scalingS[ns.db.iconSpecial], ns.db.iconAlpha
						end
					end
				elseif v.quest then
					if v.daily then -- Mainly Garrison
						if ShowConditionallyD( v.quest ) == true then
							return coord, nil, ns.texturesS[ns.db.iconDailies],
								ns.db.iconScale * ns.scalingS[ns.db.iconDailies], ns.db.iconAlpha
						end
					elseif ShowConditionallyS( v.quest ) == true then -- Mainly extra candy buckets plus extra help pins
						return coord, nil, ns.texturesS[ns.db.iconSpecial],
							ns.db.iconScale * ns.scalingS[ns.db.iconSpecial], ns.db.iconAlpha
					end
				else -- Permanent map markers with no associated Achievement or Quest
					return coord, nil, ns.texturesS[ns.db.iconSpecial],
						ns.db.iconScale * 2.5 * ns.scalingS[ns.db.iconSpecial], ns.db.iconAlpha
				end
			end
			coord, v = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> Hallow's End options
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
				removeDailies = {
					name = "Remove dailies if completed today by " ..ns.name,
					desc = "The map marker will not appear if you\nhave completed the daily quest today",
					type = "toggle",
					width = "full",
					arg = "removeDailies",
					order = 4,
				},
				removeSeasonal = {
					name = "Remove marker if completed this season by " ..ns.name,
					desc = "Candy Buckets, for example, are repeatable each season",
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					order = 5,
				},
				removeEver = {
					name = "Remove marker if ever completed on this account",
					desc = "This if for all Achievement based pins",
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
				iconTricksTreat = {
					type = "range",
					name = L["Tricks and Treats"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Candy Swirl"] .."\n12 = " ..L["Pumpkin"] .."\n13 = " ..L["Evil Pumpkin"] 
							.."\n14 = " ..L["Bat"] .."\n15 = " ..L["Cat"] .."\n16 = " ..L["Ghost"] 
							.."\n17 = " ..L["Witch"], 
					min = 1, max = 17, step = 1,
					arg = "iconTricksTreat",
					order = 7,
				},
				iconDailies = {
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
					arg = "iconDailies",
					order = 8,
				},
				iconSpecial = {
					type = "range",
					name = L["Other Candy Buckets"],
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = " ..L["Cogwheel"]
							.."\n9 = " ..L["Candy Swirl"] .."\n10 = " ..L["Pumpkin"] .."\n11 = " ..L["Evil Pumpkin"] 
							.."\n12 = " ..L["Bat"] .."\n13 = " ..L["Cat"] .."\n14 = " ..L["Ghost"] 
							.."\n15 = " ..L["Witch"], 
					min = 1, max = 15, step = 1,
					arg = "iconSpecial",
					order = 9,
				},
			},
		},
	},
}

function HandyNotes_HallowsEnd_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "HallowsEnd" )
 end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			-- Maps here will not propagate upwards. Mostly for cities as I used lots of
			-- extra helpful markers which would unnecessarily clutter a continent map
			if ( map.mapID == 57 ) or -- Teldrassil
				( map.mapID == 84 ) or -- Stormwind City
				( map.mapID == 85 ) or -- Orgrimmar
				( map.mapID == 87 ) or -- Ironforge
				( map.mapID == 89 ) or -- Darnassus
				( map.mapID == 90 ) or -- Undercity
				( map.mapID == 97 ) or -- Azuremyst Isle
				( map.mapID == 110 ) or -- Silvermoon City
				-- I wanted a set of Dalaran pins to appear in Crystalsong thus I need to
				-- avoid duplication on the Northrend map
				( map.mapID == 127 ) or -- Crystalsong Forest
				( map.mapID == 1453 ) or -- Stormwind City
				( map.mapID == 1455 ) or -- Ironforge
				( map.mapID == 1457 ) or -- Darnassus
				( map.mapID == 1947 ) or -- The Exodar
				( map.mapID == 2112 ) then -- Valdrakken
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

					if ( v.aIDA or v.aIDH ) and not v.iabc then
						if v.aIDA then
							if ns.faction == "Alliance" then
								if v.daily then
									if ShowConditionallyE( v.aIDA ) == true then
										if ShowConditionallyD( v.quest ) == true then
											AddToContinent()
										end
									end
								else
									if ( ( version < 40000 ) and v.iabc ) or ( ShowConditionallyE( v.aIDA ) == true ) then
										if ( ( version < 40000 ) and not v.ibc ) or ( version >= 40000 ) then
											if ShowConditionallyS( v.quest ) == true then
												AddToContinent()
											end
										end
									end
								end
							end
						end
						if v.aIDH then
							if ns.faction == "Horde" then
								if v.daily then
									if ShowConditionallyE( v.aIDH ) == true then
										if ShowConditionallyD( v.quest ) == true then
											AddToContinent()
										end
									end
								else
									if ( ( version < 40000 ) and v.iabc ) or ( ShowConditionallyE( v.aIDH ) == true ) then
										if ( ( version < 40000 ) and not v.ibc ) or ( version >= 40000 ) then
											if ShowConditionallyS( v.quest ) == true then
												AddToContinent()
											end
										end
									end
								end
							end
						end
						
					elseif v.achievement then
						if v.achievement == 18360 then -- Non-faction Dragon Isles buckets
							if ShowConditionallyE( v.achievement, v.index ) == true then
								if ShowConditionallyS( v.quest ) == true then
									AddToContinent()
								end
							end
						else -- Some other Achievement - Check Your Head etc				
							if ShowConditionallyE( v.achievement, v.index ) == true then
								AddToContinent()
							end
						end
						
					elseif v.faction and v.quest then
						-- Actually, so far all quests have a faction field
						if ( ( ns.faction == "Horde" ) and ( ( v.faction == "Neutral" ) or ( v.faction == "Horde" ) ) ) or
						   ( ( ns.faction == "Alliance" ) and ( ( v.faction == "Neutral" ) or ( v.faction == "Alliance" ) ) ) then
							-- That logic excludes new Pandas but shouldn't be a problem
							if v.daily then -- Mainly Garrison
								if ShowConditionallyD( v.quest ) == true then
									AddToContinent()
								end
							elseif ShowConditionallyS( v.quest ) == true then -- Mainly extra candy buckets plus extra help pins
								AddToContinent()
							end
						end
					elseif v.quest then
						if v.daily then -- Mainly Garrison
							if ShowConditionallyD( v.quest ) == true then
								AddToContinent()
							end
						elseif ShowConditionallyS( v.quest ) == true then -- Mainly extra candy buckets plus extra help pins
							AddToContinent()
						end
					else -- Permanent map markers with no associated Achievement or Quest
						AddToContinent()
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