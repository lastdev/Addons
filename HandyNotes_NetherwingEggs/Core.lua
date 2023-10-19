--[[
                                ----o----(||)----oo----(||)----o----

                                           Netherwing Eggs

                                      v2.01 - 16th October 2023
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...
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
ns.colour.quest 	= "\124cFFFFFF00"
ns.colour.daily 	= "\124cFF00CCFF"

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showQuestHelp=true, showCoords = true, 
								iconEgg = 7, iconQuests = 12 } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetSubZoneText = _G.GetSubZoneText
local IsControlKeyDown = _G.IsControlKeyDown
local IsIndoors = _G.IsIndoors
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format, ipairs, next = format, ipairs, next

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
	L["Netherwing Egg"] = "Ei der Netherschwingen"
	L["Netherwing Eggs"] = "Eier der Netherschwingen"
	L["Netherwing Mines"] = "Netherschwingenminen"
	L["AddOn Description"] = "Hilft dir, die " ..ns.colour.highlight
	L["10804"] = "Freundlichkeit"
	L["10811"] = "Sucht Neltharaku auf"
	L["10814"] = "Neltharakus Geschichte"
	L["10836"] = "Unterwanderung der Festung des Drachenmals"
	L["10837"] = "Zur Netherschwingenscherbe!"
	L["10854"] = "Die Macht Neltharakus"
	L["10858"] = "Karynaku"
	L["10866"] = "Zuluhed der Geschlagene"
	L["10870"] = "Verbündeter der Netherschwingen"
	L["11012"] = "Der Blutschwur der Netherschwingen"
	L["11013"] = "Im Dienste der Illidari"
	L["11014"] = "In der Höhle des Löwen"
	L["11015"] = "Kristalle der Netherschwingen"
	L["11016"] = "Balg eines Netherminenschinders"
	L["11017"] = "Netherstaubpollen"
	L["11018"] = "Netheriterz"
	L["11019"] = "Freund unter Feinden"
	L["11020"] = "Ein langsamer Tod"
	L["11035"] = "Ein Schatten am Horizont"
	L["11041"] = "Eine unerledigte Aufgabe..."
	L["11049"] = "Die große Eierjagd"
	L["11050"] = "Immer her mit den Eiern"
	L["11053"] = "Erhebt Euch, Aufseher!"
	L["11054"] = "Aufsehen und Ihr: Die richtige Wahl treffen"
	L["11055"] = "Der Schuhmerang: Das Mittel gegen den wertlosen Peon"
	L["11063"] = "Sich Flügel verdienen..."
	L["11075"] = "Die Netherschwingenminen"
	L["11076"] = "Die Dinge in den Griff bekommen..."
	L["11077"] = "Drachen sind unsere geringste Sorge"
	L["11081"] = "Der große Aufstand der Finsterblut"
	L["11082"] = "Suche nach der Wahrheit"
	L["11083"] = "Verrückt und verwirrt"
	L["11084"] = "Seid gegrüßt, Hauptmann!"
	L["11086"] = "Schwächt das Portal des Zwielichts"
	L["11089"] = "Die Seelenkanone Reth'hedrons"
	L["11090"] = "Unterdrückt den Unterdrücker"
	L["stand here north"] = "Bitte hier stehen, nach Norden"
	L["Show Quest Help"] = ""
	L["Show pins that help with finding quests"] = ""

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["Quests"] = "Misiones"
	L["Netherwing Egg"] = "Huevo de Ala Abisal"
	L["Netherwing Eggs"] = "Huevos de Ala Abisal"
	L["Netherwing Mines"] = "Minas del Ala Abisal"
	L["AddOn Description"] = "Ayuda a encontrar los " ..ns.colour.highlight .."Huevos de Ala Abisal"
	L["10804"] = "Bondad"
	L["10811"] = "Buscar a Neltharaku"
	L["10814"] = "La historia de Neltharaku"
	L["10836"] = "Infiltrarse en la Fortaleza Faucedraco"
	L["10837"] = "¡Al Arrecife del Ala Abisal!"
	L["10854"] = "La fuerza de Neltharaku"
	L["10858"] = "Karynaku"
	L["10866"] = "Zuluhed el Demente"
	L["10870"] = "Aliado del Ala Abisal"
	L["11012"] = "Juramento de sangre de los Ala Abisal"
	L["11013"] = "Al servicio de los Illidari"
	L["11014"] = "Presentación ante el capataz"
	L["11015"] = "Cristales de Ala Abisal"
	L["11016"] = "Pellejo de despellejador mina abisal"
	L["11017"] = "Polen de polvo abisal"
	L["11018"] = "Mineral de abisalita"
	L["11019"] = "Tu amigo en el interior"
	L["11020"] = "Una muerte lenta"
	L["11035"] = "Los cielos no tan amistosos..."
	L["11041"] = "Un trabajo sin terminar..."
	L["11049"] = "La gran búsqueda de huevos de Ala Abisal"
	L["11050"] = "Aceptar todos los huevos"
	L["11053"] = "¡Levanta, sobrestante!"
	L["11054"] = "La supervisión y tú: cómo tomar las decisiones adecuadas"
	L["11055"] = "El botarang: una cura para el insignificante trabajador común"
	L["11063"] = "Ganándote las alas..."
	L["11075"] = "Las Minas del Ala Abisal"
	L["11076"] = "Recogiendo los pedazos..."
	L["11077"] = "Los dragones son el menor de nuestros problemas"
	L["11081"] = "La gran revuelta Sangreoscura"
	L["11082"] = "En busca de la verdad"
	L["11083"] = "Locura y confusión"
	L["11084"] = "¡La cabeza bien alta, Capitán!"
	L["11086"] = "Perturbar el Portal Crepuscular"
	L["11089"] = "El cañón de almas de Reth'hedron"
	L["11090"] = "Avasallar al Avasallador"
	L["stand here north"] = "Por favor, quédate aquí, mirando hacia el norte"
	L["Show Quest Help"] = ""
	L["Show pins that help with finding quests"] = ""

elseif ns.locale == "frFR" then
	L["Quests"] = "Quêtes"
	L["Netherwing Egg"] = "Œuf de l'Aile-du-Néant"
	L["Netherwing Eggs"] = "Œufs de l'Aile-du-Néant"
	L["Netherwing Mines"] = "Mines de l'Aile-du-Néant"
	L["AddOn Description"] = "Aide à trouver les " ..ns.colour.highlight .."Œufs de l'Aile-du-Néant"
	L["10804"] = "Un peu de gentillesse"
	L["10811"] = "Trouvez Neltharaku"
	L["10814"] = "L'histoire de Neltharaku"
	L["10836"] = "Infiltrer la forteresse Gueule-de-dragon"
	L["10837"] = "Vers l'escarpement de l'Aile-du-Néant !"
	L["10854"] = "La force de Neltharaku"
	L["10858"] = "Karynaku"
	L["10866"] = "Zuluhed le Fourbu"
	L["10870"] = "Allié du vol du Néant"
	L["11012"] = "Serment de sang de l'Aile-du-Néant"
	L["11013"] = "Au service des Illidari"
	L["11014"] = "Le sous-chef entre en scène"
	L["11015"] = "Les cristaux de l'Aile-du-Néant"
	L["11016"] = "Des peaux d'écorcheurs mine-néant"
	L["11017"] = "Du pollen de pruinéante"
	L["11018"] = "Du minerai de néanticite"
	L["11019"] = "Un ami à l'intérieur"
	L["11020"] = "Une mort lente"
	L["11035"] = "Les cieux pas si cléments…"
	L["11041"] = "Un travail à terminer…"
	L["11049"] = "La ruée vers les œufs de l'Aile-du-Néant"
	L["11050"] = "Tous les œufs sont bons à prendre"
	L["11053"] = "Debout, surveillant !"
	L["11054"] = "Être surveillant : savoir faire les bons choix"
	L["11055"] = "Le botterang : un traitement pour les péons bons à rien"
	L["11063"] = "Mériter ses ailes…"
	L["11075"] = "Les mines de l'Aile-du-Néant"
	L["11076"] = "Ramasser les morceaux…"
	L["11077"] = "Les dragons sont les derniers de nos soucis"
	L["11081"] = "La grande révolte des Bourbesang"
	L["11082"] = "À la recherche de la vérité"
	L["11083"] = "Affolés et perturbés"
	L["11084"] = "Haut les cœurs, capitaine !"
	L["11086"] = "Perturber la porte du Crépuscule"
	L["11089"] = "Le canon à âmes de Reth'hedron"
	L["11090"] = "Dominer le Dominateur"
	L["stand here north"] = "S'il vous plaît, restez ici, face au nord"
	L["Show Quest Help"] = ""
	L["Show pins that help with finding quests"] = ""

elseif ns.locale == "itIT" then
	L["Quests"] = "Missioni"
	L["Netherwing Egg"] = "Uovo di Alafatua"
	L["Netherwing Eggs"] = "Uova di Alafatua"
	L["Netherwing Mines"] = "Miniere degli Alafatua"
	L["AddOn Description"] = "Aiuta a trovare le " ..ns.colour.highlight .."Uova di Alafatua"
	L["10804"] = "Kindness"
	L["10811"] = "Seek Out Neltharaku"
	L["10814"] = "Neltharaku's Tale"
	L["10836"] = "Infiltrating Dragonmaw Fortress"
	L["10837"] = "To Netherwing Ledge!"
	L["10854"] = "The Force of Neltharaku"
	L["10858"] = "Karynaku"
	L["10866"] = "Zuluhed the Whacked"
	L["10870"] = "Ally of the Netherwing"
	L["11012"] = "Blood Oath of the Netherwing"
	L["11013"] = "In Service of the Illidari"
	L["11014"] = "Enter the Taskmaster"
	L["11015"] = "I Cristalli degli Alafatua"
	L["11016"] = "Pelli di Scorticatore Cavafatua"
	L["11017"] = "Polline di Nubefatua"
	L["11018"] = "Faturcite"
	L["11019"] = "Il tuo amico nel sistema"
	L["11020"] = "Una morte lenta"
	L["11035"] = "Cieli non molto amici..."
	L["11041"] = "Un lavoro lasciato a metà..."
	L["11049"] = "La grande caccia alle Uova di Alafatua"
	L["11050"] = "Si accettano tutte le uova"
	L["11053"] = "Alzati, Sovrintendente!"
	L["11054"] = "Sovrintendere: fare le scelte giuste"
	L["11055"] = "Lo Stivale Rotante: la cura definitiva per il Peone qualunque"
	L["11063"] = "Guadagnarsi le ali..."
	L["11075"] = "Le Miniere degli Alafatua"
	L["11076"] = "Raccogliere i pezzi..."
	L["11077"] = "I draghi sono l'ultimo dei nostri problemi"
	L["11081"] = "La grande rivolta dei Sanguebuio"
	L["11082"] = "Alla ricerca della verità"
	L["11083"] = "Confusi e feroci"
	L["11084"] = "In piedi, Capitano!"
	L["11086"] = "La distruzione del Portale del Crepuscolo"
	L["11089"] = "Il Cannone dell'Anima di Reth'hedron"
	L["11090"] = "Soggioga il soggiogatore"
	L["stand here north"] = "Si prega di stare qui, verso nord."
	L["Show Quest Help"] = ""
	L["Show pins that help with finding quests"] = ""

elseif ns.locale == "koKR" then
	L["Quests"] = "퀘스트"
	L["Netherwing Egg"] = "황천날개 알"
	L["Netherwing Eggs"] = "황천날개 알"
	L["Netherwing Mines"] = "황천날개 광산"
	L["AddOn Description"] = ns.colour.highlight .."황천날개 알\124r 를 찾을 수 있도록 도와줍니다"
	L["10804"] = "친절"
	L["10811"] = "넬타라쿠 찾기"
	L["10814"] = "넬타라쿠의 이야기"
	L["10836"] = "용아귀 요새 침입"
	L["10837"] = "황천날개 마루를 향해!"
	L["10854"] = "넬타라쿠의 힘"
	L["10858"] = "카리나쿠"
	L["10866"] = "늙은 줄루헤드"
	L["10870"] = "황천날개 용군단의 동맹"
	L["11012"] = "황천날개의 피의 맹세"
	L["11013"] = "일리다리에 봉사"
	L["11014"] = "작업반장에게로"
	L["11015"] = "황천날개 수정"
	L["11016"] = "황천수정 바위갈퀴 가죽"
	L["11017"] = "황천티끌 꽃가루"
	L["11018"] = "황천연 광석"
	L["11019"] = "내부의 동료"
	L["11020"] = "서서히 죽음에 이르는 길"
	L["11035"] = "하늘과 땅의 대립"
	L["11041"] = "끝나지 않은 임무..."
	L["11049"] = "좋은 황천날개 알 수집"
	L["11050"] = "황천날개 알 추가 수집"
	L["11053"] = "일어나라, 감독관이여!"
	L["11054"] = "사랑의 매와 감독관의 임무"
	L["11055"] = "부메랑 - 쓸모없는 일꾼들에 대한 방책"
	L["11063"] = "하늘파괴단의 일원"
	L["11075"] = "황천날개 광산"
	L["11076"] = "화물 회수"
	L["11077"] = "하찮은 골칫거리"
	L["11081"] = "수렁피 일족 폭동"
	L["11082"] = "진실의 추종자"
	L["11083"] = "정신나간 수렁피 일족"
	L["11084"] = "준비됐습니다, 대장님!"
	L["11086"] = "황혼의 차원문 방해하기"
	L["11089"] = "레스히드론의 영혼 대포"
	L["11090"] = "정복자 제압"
	L["stand here north"] = "여기 북쪽을 향하여 서십시오."
	L["Show Quest Help"] = ""
	L["Show pins that help with finding quests"] = ""

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Quests"] = "Missões"
	L["Netherwing Egg"] = "Ovo da Asa Etérea"
	L["Netherwing Eggs"] = "Ovos da Asa Etérea"
	L["Netherwing Mines"] = "Minas da Asa Etérea"
	L["AddOn Description"] = "Ajuda você a localizar " ..ns.colour.highlight .."Ovos da Asa Etérea"
	L["10804"] = "Bondade"
	L["10811"] = "Procure Neltarako"
	L["10814"] = "A história de Neltarako"
	L["10836"] = "Infiltrando-se na Fortaleza Presa do Dragão"
	L["10837"] = "Para a Plataforma da Asa Etérea!"
	L["10854"] = "A força de Neltarako"
	L["10858"] = "Karynakhan"
	L["10866"] = "Zuluhed, o Insano"
	L["10870"] = "Aliados dos Asa Etérea"
	L["11012"] = "Juramento de sangue dos Asa Etérea"
	L["11013"] = "A serviço dos Illidari"
	L["11014"] = "Eis que surge o capataz"
	L["11015"] = "Cristais da Asa Etérea"
	L["11016"] = "Pelego de Esfola-pedra da Mina Etérea"
	L["11017"] = "Pólen de poeira etérea"
	L["11018"] = "Minério de etercita"
	L["11019"] = "Seu amigo nas internas"
	L["11020"] = "Morte lenta"
	L["11035"] = "Viaje não-tão-bem-assim..."
	L["11041"] = "Serviço deixado pela metade..."
	L["11049"] = "A grande caçada de ovos da Asa Etérea"
	L["11050"] = "Aceitamos todos os ovos"
	L["11053"] = "Erga-se, feitor!"
	L["11054"] = "A Feitoria e Você: Fazendo as Escolhas Certas"
	L["11055"] = "O Botarangue: a cura para o inútil peão comum"
	L["11063"] = "Ganhando asas..."
	L["11075"] = "As minas da Asa Etérea"
	L["11076"] = "Catando cavaco"
	L["11077"] = "Os dragões são o nosso menor problema"
	L["11081"] = "A grande revolta dos Sangue-de-lodo"
	L["11082"] = "Em busca da verdade"
	L["11083"] = "Ah, eu tô maluco"
	L["11084"] = "Cabeça erguida, Capitão!"
	L["11086"] = "Atrapalhando o Portal do Crepúsculo"
	L["11089"] = "O Canhão das almas de Reth'hedron"
	L["11090"] = "Domine o Dominador"
	L["stand here north"] = "Por favor fique aqui, virado para o norte."
	L["Show Quest Help"] = ""
	L["Show pins that help with finding quests"] = ""

elseif ns.locale == "ruRU" then
	L["Quests"] = "Задания"
	L["Netherwing Egg"] = "Яйцо дракона из стаи Крыльев Пустоты"
	L["Netherwing Eggs"] = "Яйца дракона из стаи Крыльев Пустоты"
	L["Netherwing Mines"] = "Крыльев Пустоты"
	L["AddOn Description"] = "Помогает найти " ..ns.colour.highlight
		.."Яйца дракона из стаи Крыльев Пустоты"
	L["10804"] = "Доброта"
	L["10811"] = "Поиски Нельтараку"
	L["10814"] = "История Нельтараку"
	L["10836"] = "Переполох в крепости Драконьей Пасти"
	L["10837"] = "На кряж Крыльев Пустоты!"
	L["10854"] = "Силы Нельтараку"
	L["10858"] = "Каринаку"
	L["10866"] = "Зулухед Измученный"
	L["10870"] = "Союзник Крыльев Пустоты"
	L["11012"] = "Клятва в верности Крыльям Пустоты"
	L["11013"] = "В услужении у Иллидари"
	L["11014"] = "Задание десятника"
	L["11015"] = "Кристаллы Крыльев Пустоты"
	L["11016"] = "Шкуры живодеров-пустокопов"
	L["11017"] = "Пыльца пустопраха"
	L["11018"] = "Хаотитовая руда"
	L["11019"] = "Друг в тылу врага"
	L["11020"] = "Медленная смерть"
	L["11035"] = "Недружелюбные небеса"
	L["11041"] = "Неоконченное дело"
	L["11049"] = "Большая Охота"
	L["11050"] = "Собрать их все!"
	L["11053"] = "Новое назначение"
	L["11054"] = "Ты – инспектор: как делать все правильно"
	L["11055"] = "Ботиранг: лекарство для нерадивых батраков"
	L["11063"] = "Заработай крылья"
	L["11075"] = "Копи Крыльев Пустоты"
	L["11076"] = "Собрать по кусочкам..."
	L["11077"] = "Драконы – это не самое страшное"
	L["11081"] = "Восстание в племени Темной Крови"
	L["11082"] = "В поисках правды"
	L["11083"] = "Спятившие и очень опасные..."
	L["11084"] = "Стой прямо, капитан!"
	L["11086"] = "Разрушение сумеречного портала"
	L["11089"] = "Пушка души Рет'хедрона"
	L["11090"] = "Покорить Покорителя"
	L["stand here north"] = "Пожалуйста, встаньте здесь, лицом на север."
	L["Show Quest Help"] = ""
	L["Show pins that help with finding quests"] = ""

elseif ns.locale == "zhCN" then
	L["Quests"] = "任务"
	L["Netherwing Egg"] = "灵翼龙卵"
	L["Netherwing Eggs"] = "灵翼龙卵"
	L["Netherwing Mines"] = "灵翼矿洞"
	L["AddOn Description"] = "帮助你找寻" ..ns.colour.highlight .."灵翼龙卵"
	L["10804"] = "友善"
	L["10811"] = "寻找奈尔萨拉库"
	L["10814"] = "奈尔萨拉库的故事"
	L["10836"] = "攻击龙喉要塞"
	L["10837"] = "前往灵翼浮岛！"
	L["10854"] = "奈尔萨拉库之力"
	L["10858"] = "卡瑞纳库"
	L["10866"] = "疲惫的祖鲁希德"
	L["10870"] = "灵翼之盟"
	L["11012"] = "灵翼血誓"
	L["11013"] = "为伊利达雷效力"
	L["11014"] = "会见工头"
	L["11015"] = "灵翼水晶"
	L["11016"] = "虚空矿洞剥石者的外皮"
	L["11017"] = "灵尘花粉"
	L["11018"] = "虚空矿石"
	L["11019"] = "你的伙伴"
	L["11020"] = "缓慢的死亡"
	L["11035"] = "危险的天空"
	L["11041"] = "未完的工作……"
	L["11049"] = "寻找灵翼龙卵"
	L["11050"] = "所有的龙卵"
	L["11053"] = "起立，督工！"
	L["11054"] = "新的监工：正确的选择"
	L["11055"] = "训诫靴：懒惰苦工的惩戒"
	L["11063"] = "你的双翼"
	L["11075"] = "灵翼矿洞"
	L["11076"] = "回收货物"
	L["11077"] = "龙？不是问题"
	L["11081"] = "暗血大逃亡"
	L["11082"] = "寻找真相"
	L["11083"] = "疯狂与困惑"
	L["11084"] = "立正，队长！"
	L["11086"] = "暮光岭的传送门"
	L["11089"] = "雷萨赫尔的灵魂火炮"
	L["11090"] = "征服者雷萨赫尔顿"
	L["stand here north"] = "请站在这里，面朝北方。"
	L["Show Quest Help"] = ""
	L["Show pins that help with finding quests"] = ""

elseif ns.locale == "zhTW" then
	L["Quests"] = "任務"
	L["Netherwing Egg"] = "靈翼龍卵"
	L["Netherwing Eggs"] = "靈翼龍卵"
	L["Netherwing Mines"] = "靈翼礦洞"
	L["AddOn Description"] = "幫助你找尋" ..ns.colour.highlight .."靈翼龍卵"
	L["10804"] = "友善"
	L["10811"] = "尋找奈爾薩拉庫"
	L["10814"] = "奈爾薩拉庫的故事"
	L["10836"] = "攻擊龍喉要塞"
	L["10837"] = "前往靈翼浮島！"
	L["10854"] = "奈爾薩拉庫之力"
	L["10858"] = "卡瑞納庫"
	L["10866"] = "疲憊的祖魯希德"
	L["10870"] = "靈翼之盟"
	L["11012"] = "靈翼血誓"
	L["11013"] = "為伊利達雷效力"
	L["11014"] = "會見工頭"
	L["11015"] = "靈翼水晶"
	L["11016"] = "虛空礦洞剝石者的外皮"
	L["11017"] = "靈塵花粉"
	L["11018"] = "虛空礦石"
	L["11019"] = "你的夥伴"
	L["11020"] = "緩慢的死亡"
	L["11035"] = "危險的天空"
	L["11041"] = "未完的工作……"
	L["11049"] = "尋找靈翼龍卵"
	L["11050"] = "所有的龍卵"
	L["11053"] = "起立，督工！"
	L["11054"] = "新的監工：正確的選擇"
	L["11055"] = "訓誡靴：懶散苦工的懲戒"
	L["11063"] = "你的雙翼"
	L["11075"] = "靈翼礦洞"
	L["11076"] = "回收貨物"
	L["11077"] = "龍？不是問題"
	L["11081"] = "暗血大逃亡"
	L["11082"] = "尋找真相"
	L["11083"] = "瘋狂與困惑"
	L["11084"] = "立正，隊長！"
	L["11086"] = "暮光嶺的傳送門"
	L["11089"] = "雷薩赫爾的靈魂火砲"
	L["11090"] = "征服者雷薩赫爾頓"
	L["stand here north"] = "請站在這裡，面朝北方。"
	L["Show Quest Help"] = ""
	L["Show pins that help with finding quests"] = ""
	
else
	L["AddOn Description"] = "Helps you locate " ..ns.colour.highlight .."Netherwing Eggs"
	L["10804"] = "Kindness"
	L["10811"] = "Seek Out Neltharaku"
	L["10814"] = "Neltharaku's Tale"
	L["10836"] = "Infiltrating Dragonmaw Fortress"
	L["10837"] = "To Netherwing Ledge!"
	L["10854"] = "The Force of Neltharaku"
	L["10858"] = "Karynaku"
	L["10866"] = "Zuluhed the Whacked"
	L["10870"] = "Ally of the Netherwing"
	L["11012"] = "Blood Oath of the Netherwing"
	L["11013"] = "In Service of the Illidari"
	L["11014"] = "Enter the Taskmaster"
	L["11015"] = "Netherwing Crystals"
	L["11016"] = "Nethermine Flayer Hide"
	L["11017"] = "Netherdust Pollen"
	L["11018"] = "Nethercite Ore"
	L["11019"] = "Your Friend On The Inside"
	L["11020"] = "A Slow Death"
	L["11035"] = "The Not-So-Friendly Skies..."
	L["11041"] = "A Job Unfinished..."
	L["11049"] = "The Great Netherwing Egg Hunt"
	L["11050"] = "Accepting All Eggs"
	L["11053"] = "Rise, Overseer!"
	L["11054"] = "Overseeing and You: Making the Right Choices"
	L["11055"] = "The Booterang: A Cure For The Common Worthless Peon"
	L["11063"] = "Earning Your Wings..."
	L["11075"] = "The Netherwing Mines"
	L["11076"] = "Picking Up The Pieces..."
	L["11077"] = "Dragons are the Least of Our Problems"
	L["11081"] = "The Great Murkblood Revolt"
	L["11082"] = "Seeker of Truth"
	L["11083"] = "Crazed and Confused"
	L["11084"] = "Stand Tall, Captain!"
	L["11086"] = "Disrupting the Twilight Portal"
	L["11089"] = "The Soul Cannon of Reth'hedron"
	L["11090"] = "Subdue the Subduer"
	L["stand here north"] = "Please stand here, facing north"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter( mapFile, coord )
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
	else
		GameTooltip:SetOwner( self, "ANCHOR_RIGHT" )
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]
	local setTextDone = false

	if pin.displayQuests then
		for i,v in ipairs( pin.displayQuests ) do
			if setTextDone == false then
				GameTooltip:SetText( ns.colour.prefix ..L["Quests"] )
				setTextDone = true
			else
				GameTooltip:AddLine( " " )
			end
			GameTooltip:AddLine( ( v.daily and ns.colour.daily or ns.colour.quest ) ..L[ tostring( v.quest ) ] )
			if v.tip then GameTooltip:AddLine( ns.colour.plaintext .."\n" ..L[ v.tip ] ) end
		end
	else
		GameTooltip:SetText( ns.colour.prefix ..L["Netherwing Egg"] )
		setTextDone = true
		if pin.tip then GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] ) end
	end
	
	if ( ns.db.showCoords == true ) and ( setTextDone == true ) then
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

local function OnEventHandler( self, event, questID )
	if ( event == "QUEST_TURNED_IN" ) and ( ns.db.showQuestHelp == true ) then
		-- Testing: I capture quest completion here. No problem
		-- The two calls below should be enough to force a pin refresh
		-- Problem is that when I call IsQuestFlaggedCompleted the result is FALSE
		-- Possibly called too soon for the server OR I suspect the server was never
		-- actually called and I'm seeing a snapshot/cache. If that's the case then I
		-- think a Refresh will only "toggle" already filled pins and a GetNodes2
		-- will just used the old cached data
		-- Solution: A hack of course. Save the quest ID. Beware that a couple of
		-- dailies are grouped
		ns.questCompleted = true

--		pluginHandler:GetNodes2( ns.CurrentMap )
--		pluginHandler:Refresh()
--		MinimapMixin:OnEvent( "PLAYER_ENTERING_WORLD" )
	end
end
local eventFrame = CreateFrame( "Frame" )
eventFrame:RegisterEvent( "QUEST_TURNED_IN" )
eventFrame:SetScript( "OnEvent", OnEventHandler )

do
	local _, _, _, version = GetBuildInfo()
	ns.outland = (version < 40000) and 1945 or 101
	ns.valley = (version < 40000) and 1948 or 104
	ns.nagrand = (version < 40000) and 1951 or 107
	ns.netherstorm = (version < 40000) and 1953 or 109
	ns.terokkar = (version < 40000) and 1952 or 108
	continents[ns.outland] = true

    local bucket = CreateFrame("Frame")
    bucket.elapsed = 0
    bucket:SetScript("OnUpdate", function(self, elapsed)
		if ns.questCompleted then
			ns.questCompleted = nil
			self.elapsed = 0
			-- All of this code has no effect whatsoever. Still searching for a solution
			for i = 1, 500 do
				if _G["HandyNotesPin"..tostring(i)] and _G["HandyNotesPin"..tostring(i)].pluginName == "NetherwingEggs" then
					_G["HandyNotesPin"..tostring(i)]:Hide()
					_G["HandyNotesPin"..tostring(i)] = nil
					print("Hide/nill for pin #"..i)
				end
			end
			pluginHandler:GetNodes2( ns.CurrentMap )
			pluginHandler:Refresh()
--			Minimap:UpdateBlips()
		else
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
        end
    end)

	if ns.insideMine == nil then
		ns.insideMine = ( GetSubZoneText() == L["Netherwing Mines"] and IsIndoors() ) and true or false
	end

	local function iterator(t, prev)
		if not t then return end
		local coord, v = next(t, prev)
		local showPin = false
		
		local function ProcessQuestTable( questTable )
			local questCompleted = false
			for i,w in ipairs( questTable ) do
				if ns.completedQuest then
					if ( w.quest == 11016 or w.quest == 11017 or w.quest == 11018 ) and 
						( ns.completedQuest == 11016 or ns.completedQuest == 11017 or ns.completedQuest == 11018 ) then
						questCompleted = true
					elseif w.quest == ns.completedQuest then
						questCompleted = true
					end
				else
					questCompleted = IsQuestFlaggedCompleted( w.quest )
				end
				if questCompleted == false then
					if w.showAfter and ( IsQuestFlaggedCompleted( w.showAfter )	== false ) then
					elseif ( ns.insideMine == false ) and w.insideMine then
					elseif ( ns.insideMine == true ) and not w.insideMine then
					else
						table.insert( v.displayQuests, { quest=w.quest, daily=w.daily, tip=w.tip } )
						showPin = true
					end
				end
			end
		end
		
		while coord do
			if v then
				if v.quests then 
					if ns.db.showQuestHelp == true then
						showPin, v.displayQuests = false, {}
						ProcessQuestTable( v.quests )
						if showPin == true then
							return coord, nil, ns.textures[ns.db.iconQuests],
									ns.db.iconScale * ns.scaling[ns.db.iconQuests], ns.db.iconAlpha
						end			
					end						
				else
					if ns.insideMine == true then
						if v.insideMine then
							return coord, nil, ns.textures[ns.db.iconEgg], 
									ns.db.iconScale * ns.scaling[ns.db.iconEgg], ns.db.iconAlpha
						end
					elseif not v.insideMine then
						return coord, nil, ns.textures[ns.db.iconEgg], 
								ns.db.iconScale * ns.scaling[ns.db.iconEgg], ns.db.iconAlpha
					end
				end				
			end
			coord, v = next(t, coord)
		end
		ns.completedQuest = nil
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
				showQuestHelp = {
					name = L["Show Quest Help"],
					desc = L["Show pins that help with finding quests"],
					type = "toggle",
					width = "full",
					arg = "showQuestHelp",
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
			name = L["Map Pin Selections"],
			inline = true,
			args = {
				iconEgg = {
					type = "range",
					name = L["Netherwing Egg"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Ring"] .." - " ..L["Gold"] .."\n12 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n13 = " ..L["Ring"] .." - " ..L["Blue"] .."\n14 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n15 = " ..L["Cross"] .." - " ..L["Red"] .."\n16 = " ..L["Diamond"]
							.." - " ..L["White"] .."\n17 = " ..L["Frost"] .."\n18 = " ..L["Cogwheel"]
							.."\n19 = " ..L["Screw"] .."\n20 = " ..L["Netherwing Egg"],
					min = 1, max = 20, step = 1,
					arg = "iconEgg",
					order = 5,
				},
				iconQuests = {
					type = "range",
					name = L["Quests"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Ring"] .." - " ..L["Gold"] .."\n12 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n13 = " ..L["Ring"] .." - " ..L["Blue"] .."\n14 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n15 = " ..L["Cross"] .." - " ..L["Red"] .."\n16 = " ..L["Diamond"]
							.." - " ..L["White"] .."\n17 = " ..L["Frost"] .."\n18 = " ..L["Cogwheel"]
							.."\n19 = " ..L["Screw"] .."\n20 = " ..L["Netherwing Egg"],
					min = 1, max = 20, step = 1,
					arg = "iconQuests",
					order = 6,
				},
			},
		},
	},
}

function HandyNotes_NetherwingEggs_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "NetherwingEggs" )
 end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	HandyNotes:RegisterPluginDB("NetherwingEggs", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_NetherwingEggsDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "NetherwingEggs")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_NetherwingEggsDB", "AceEvent-3.0")