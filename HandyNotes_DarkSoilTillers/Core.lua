--[[
                                ----o----(||)----oo----(||)----o----

                                          Dark Soil Tillers
										  
                                      v3.49 - 12th January 2024
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...
ns.db = {}
-- From Data.lua
ns.points, ns.textures, ns.scaling, ns.texturesSpecial, ns.scalingSpecial = {}, {}, {}, {}, {}
-- Brown theme
ns.colour = {}
ns.colour.prefix	= "\124cFFD2691E"	-- X11Chocolate
ns.colour.highlight = "\124cFFF4A460"	-- X11SandyBrown
ns.colour.plaintext = "\124cFFDEB887"	-- X11BurlyWood
-- Map IDs
ns.pandaria = 424

--ns.author = true

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true, showDarkSoil = true,
							iconDarkSoil = 3, iconTillersQuests = 1, iconTillersNPCs = 1 } }
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetFriendshipReputation = C_GossipInfo.GetFriendshipReputation
local GetItemNameByID = C_Item.GetItemNameByID
local IsControlKeyDown = _G.IsControlKeyDown
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local next = _G.next
local select = _G.select
local match = string.match

local HandyNotes = _G.HandyNotes

ns.aWitnessToHistory = ( ns.faction == "Alliance" ) and 31512 or ( ( ns.faction == "Horde" ) and 31511 or 0 )

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
	L["AddOn Description"] = ns.colour.plaintext .."Hilft dir bei " ..ns.colour.highlight
		.."Dunkle Erde" ..ns.colour.plaintext .." und " ..ns.colour.highlight .."Die Ackerbauern"
		..ns.colour.plaintext .." im Tal der Vier Winde"
	L["At the entrance"] = "Am Eingang"
	L["Dark Soil"] = "Dunkle Erde"
	L["Dark Soil Tillers"] = "Dunkle Erde Die Ackerbauern"
	L["Descend into the Springtail Crag"] = "Steigen Sie in den Sprungschweifhöhlen geht"
	L["Descend into the Springtail Warren"] = "Steigen Sie in den Sprungschweifebau hinab"
	L["Inside the building"] = "Im Gebäude"
	L["NPC"] = "NSC"
	L["Same colour as the ground"] = "Gleiche farbe wie der schmutz"
	L["Show the Dark Soil"] = "Zeige den Dunklen Erde"
	L["Standing under a tree"] = "Unter einem Baum stehen"
	L["The Tillers"] = "Die Ackerbauern"
	L["Under the bridge"] = "Unter der Brücke"
	L["Under the foliage"] = "Unter dem Laub"
	L["Under the hut"] = "Unter der Hütte"
	L["Under the hut's\nnorthern side ramp"] = "Unter der Nordseite der Hütte"
	L["Under the tree, at\nthe edge of the lake"] = "Unter dem Baum,\nam Rande des Sees"
	L["Under the tree.\nIn front of Thunder"] = "Unter dem Baum.\nVor Thunnnder"
	L["Under the trees.\nVery difficult to see"] = "Unter den Bäumen.\nSehr schwer zu sehen"
	L["Under the water tower"] = "Unter dem Wasserturm"
	L["VotFW Map"] = "Karte „Tal der Vier Winde“"

	L["Chee Chee"] = "Chi-Chi"
	L["Ella"] = "Ella"
	L["Farmer Fung"] = "Bauer Fung"
	L["Fish Fellreed"] = "Fischi Rohrroder"
	L["Gina Mudclaw"] = "Gina Lehmkrall"
	L["Haohan Mudclaw"] = "Haohan Lehmkrall"
	L["Jogu the Drunk"] = "Jogu der Betrunkene"
	L["Old Hillpaw"] = "Der alte Hügelpranke"
	L["Sho"] = "Sho"
	L["Tina Mudclaw"] = "Tina Lehmkrall"
	
elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["AddOn Description"] = ns.colour.plaintext .."Te ayuda co " ..ns.colour.highlight
		.."Tierra Oscura" ..ns.colour.plaintext .." y " ..ns.colour.highlight .."Los Labradores"
		..ns.colour.plaintext .." en el Valle de los Cuatro Vientos"
	L["At the entrance"] = "En la entrada"
	L["Dark Soil"] = "Tierra Oscura"
	L["Dark Soil Tillers"] = "Los Labradores Tierra Oscura"
	L["Descend into the Springtail Crag"] = "Desciende a la madriguera de los Risco Cola Saltarina"
	L["Descend into the Springtail Warren"] = "Desciende a la madriguera de los Cola Saltarina"
	L["Inside the building"] = "Dentro del edificio"
	L["NPC"] = "PNJ"
	L["Same colour as the ground"] = "Del mismo color que el suelo"
	L["Show the Dark Soil"] = "Mostrar la Tierra Oscura"
	L["Standing under a tree"] = "De pie debajo de un árbol"
	L["The Tillers"] = "Los Labradores"
	L["Under the bridge"] = "Bajo el puente"
	L["Under the foliage"] = "Bajo el follaje"
	L["Under the hut"] = "Bajo la choza"
	L["Under the hut's\nnorthern side ramp"] = "Bajo la rampa del lado\nnorte de la choza"
	L["Under the tree, at\nthe edge of the lake"] = "Bajo el árbol,\nen el borde del lago"
	L["Under the tree.\nIn front of Thunder"] = "Debajo del árbol. Delante de Trueno"
	L["Under the trees.\nVery difficult to see"] = "Bajo los árboles.\nMuy difícil de ver"
	L["Under the water tower"] = "Bajo la torre de agua"
	L["VotFW Map"] = "Mapa del Valle de los Cuatro Vientos"

	L["Chee Chee"] = "Chee Chee"
	L["Ella"] = "Ella"
	L["Farmer Fung"] = "Granjero Fung"
	L["Fish Fellreed"] = "Pez Junco Talado"
	L["Gina Mudclaw"] = "Gina Zarpa Fangosa"
	L["Haohan Mudclaw"] = "Haohan Zarpa Fangosa"
	L["Jogu the Drunk"] = "Jogu el Ebrio"
	L["Old Hillpaw"] = "Viejo Zarpa Collado"
	L["Sho"] = "Sho"
	L["Tina Mudclaw"] = "Tina Zarpa Fangosa"

elseif ns.locale == "frFR" then
	L["AddOn Description"] = ns.colour.plaintext .."Vous aide avec " ..ns.colour.highlight
		.."Terre Sombre" ..ns.colour.plaintext .." et " ..ns.colour.highlight .."Laboureurs"
		..ns.colour.plaintext .." dans la Vallée des Quatre vents"
	L["At the entrance"] = "À l'entrée"
	L["Dark Soil"] = "Terre Sombre"
	L["Dark Soil Tillers"] = "Laboureurs Terre Sombre"
	L["Descend into the Springtail Crag"] = "Descendez dans la combe des Queubrioles"
	L["Descend into the Springtail Warren"] = "Descendez dans la garenne des queubriole"
	L["Inside the building"] = "À l'intérieur du bâtiment"
	L["NPC"] = "PNJ"
	L["Same colour as the ground"] = "De la même couleur que le sol"
	L["Show the Dark Soil"] = "Montre la Terre Sombre"
	L["Standing under a tree"] = "Debout sous un arbre"
	L["The Tillers"] = "Laboureurs"
	L["Under the bridge"] = "Sous le pont"
	L["Under the foliage"] = "Sous le feuillage"
	L["Under the hut"] = "Sous la cabane"
	L["Under the hut's\nnorthern side ramp"] = "Sous la rampe côté\nnord de la cabane"
	L["Under the tree, at\nthe edge of the lake"] = "Sous l'arbre,\nau bord du lac"
	L["Under the tree.\nIn front of Thunder"] = "Sous l'arbre. Devant Tonnerre"
	L["Under the trees.\nVery difficult to see"] = "Sous les arbres.\nTrès difficile à voir"
	L["Under the water tower"] = "Sous la tour d'eau"
	L["VotFW Map"] = "Carte de la Vallée des Quatre Vents"

	L["Chee Chee"] = "Chii Chii"
	L["Ella"] = "Ella"
	L["Farmer Fung"] = "Fermier Fung"
	L["Fish Fellreed"] = "Marée Pelage de Roseau"
	L["Gina Mudclaw"] = "Gina Griffe de Tourbe"
	L["Haohan Mudclaw"] = "Haohan Griffe de Tourbe"
	L["Jogu the Drunk"] = "Jogu l’Ivrogne"
	L["Old Hillpaw"] = "Vieux Patte des Hauts"
	L["Sho"] = "Sho"
	L["Tina Mudclaw"] = "Tina Griffe de Tourbe"

elseif ns.locale == "itIT" then
	L["AddOn Description"] = ns.colour.plaintext .."Ti aiuta con " ..ns.colour.highlight .."Terra Oscura"
			..ns.colour.plaintext .." e " ..ns.colour.highlight .."Coltivatori" ..ns.colour.plaintext
			.." in the Valle dei Quattro Venti"
	L["At the entrance"] = "All'entrata"
	L["Dark Soil"] = "Terreno Smosso"
	L["Dark Soil Tillers"] = "Coltivatori Terreno Smosso"
	L["Descend into the Springtail Crag"] = "Scendi nella Rupe dei Codalesta"
	L["Descend into the Springtail Warren"] = "Scendi nella Tana del Codalesta"
	L["Inside the building"] = "All'interno dell'edificio"
	L["NPC"] = "PNG"
	L["Same colour as the ground"] = "Lo stesso colore del terreno"
	L["Show the Dark Soil"] = "Mostra la Terreno Smosso"
	L["Standing under a tree"] = "In piedi sotto un albero"
	L["The Tillers"] = "Coltivatori"
	L["Under the bridge"] = "Sotto il ponte"
	L["Under the foliage"] = "Sotto il fogliame"
	L["Under the hut"] = "Sotto la capanna"
	L["Under the hut's\nnorthern side ramp"] = "Sotto la rampa laterale nord della capanna"
	L["Under the tree, at\nthe edge of the lake"] = "Sotto l'albero,\nai margini del lago"
	L["Under the tree.\nIn front of Thunder"] = "Sotto l'albero.\nDi fronte a Tuono"
	L["Under the trees.\nVery difficult to see"] = "Sotto gli alberi.\nMolto difficile da vedere"
	L["Under the water tower"] = "Sotto la torre dell'acqua"
	L["VotFW Map"] = "Mappa della Valle dei Quattro Venti"

	L["Chee Chee"] = "Ghi Ghi"
	L["Ella"] = "Ella"
	L["Farmer Fung"] = "Contadino Fung"
	L["Fish Fellreed"] = "Trota Mezza Canna"
	L["Gina Mudclaw"] = "Gina Palmo Florido"
	L["Haohan Mudclaw"] = "Haohan Palmo Florido"
	L["Jogu the Drunk"] = "Jogu l'Ubriaco"
	L["Old Hillpaw"] = "Vecchio Zampa Brulla"
	L["Sho"] = "Sho"
	L["Tina Mudclaw"] = "Tina Palmo Florido"

elseif ns.locale == "koKR" then
	L["AddOn Description"] = ns.colour.plaintext .."네 바람의 계곡에서 " ..ns.colour.highlight .."농사꾼 연합"
		..ns.colour.plaintext .." 및 " ..ns.colour.highlight .."검은 토양" ..ns.colour.plaintext
		.." 에 대한 도움말"
	L["At the entrance"] = "입구에서"
	L["Dark Soil"] = "검은 토양"
	L["Dark Soil Tillers"] = "농사꾼 연합 검은 토양"
	L["Descend into the Springtail Crag"] = "있는 껑충꼬리 바위굴 처로 내려가세요"
	L["Descend into the Springtail Warren"] = "껑충꼬리 은신처로 내려가세요"
	L["Inside the building"] = "건물 내부"
	L["Same colour as the ground"] = "땅과 같은 색"
	L["Show the Dark Soil"] = "검은 토양 보여줘"
	L["Standing under a tree"] = "나무 아래 서"
	L["The Tillers"] = "농사꾼 연합"
	L["Under the bridge"] = "다리 아래"
	L["Under the foliage"] = "단풍 아래서"
	L["Under the hut"] = "오두막 아래서"
	L["Under the hut's\nnorthern side ramp"] = "오두막의 북쪽 경사로 아래"
	L["Under the tree, at\nthe edge of the lake"] = "나무 밑. 호수 가장자리."
	L["Under the tree.\nIn front of Thunder"] = "나무 아래. 우레 앞에서."
	L["Under the trees.\nVery difficult to see"] = "나무 밑. 보기가 매우 어렵다."
	L["Under the water tower"] = "수상 탑 아래"
	L["VotFW Map"] = "네 바람의 계곡 지도"

	L["Chee Chee"] = "치 치"
	L["Ella"] = "엘라"
	L["Farmer Fung"] = "농부 펑"
	L["Fish Fellreed"] = "피시 펠리드"
	L["Gina Mudclaw"] = "지나 머드클로"
	L["Haohan Mudclaw"] = "하오한 머드클로"
	L["Jogu the Drunk"] = "주정뱅이 조구"
	L["Old Hillpaw"] = "늙은 힐포우"
	L["Sho"] = "쇼"
	L["Tina Mudclaw"] = "티나 머드클로"

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["AddOn Description"] = ns.colour.plaintext .."Ajuda você com " ..ns.colour.highlight
		.."Solo Escuro" ..ns.colour.plaintext .." e " ..ns.colour.highlight .."Os Lavradores"
		..ns.colour.plaintext .." no Vale dos Quatro Ventos"
	L["At the entrance"] = "Na entrada"
	L["Dark Soil"] = "Solo Negro"
	L["Dark Soil Tillers"] = "Os Lavradores Solo Negro"
	L["Descend into the Springtail Crag"] = "Desça para o Rochedo Cauda-de-mola"
	L["Descend into the Springtail Warren"] = "Desça para o Labirinto Cauda-de-mola"
	L["Inside the building"] = "Dentro do prédio"
	L["NPC"] = "PNJ"
	L["Same colour as the ground"] = "Da mesma cor do chão"
	L["Show the Dark Soil"] = "Mostrar o Solo Negro"
	L["Standing under a tree"] = "De pé debaixo de uma árvore"
	L["The Tillers"] = "Os Lavradores"
	L["Under the bridge"] = "Debaixo da ponte"
	L["Under the foliage"] = "Sob a folhagem"
	L["Under the hut"] = "Debaixo da cabana"
	L["Under the hut's\nnorthern side ramp"] = "Sob a rampa do lado norte da cabana"
	L["Under the tree, at\nthe edge of the lake"] = "Debaixo da árvore,\nà beira do lago"
	L["Under the tree.\nIn front of Thunder"] = "Debaixo da árvore. Na frente de Trovão"
	L["Under the trees.\nVery difficult to see"] = "Sob as árvores.\nMuito difícil de ver"
	L["Under the water tower"] = "Sob a torre de água"
	L["VotFW Map"] = "Mapa do Vale dos Quatro Ventos"

	L["Chee Chee"] = "Tchi Tchi"
	L["Ella"] = "Ella"
	L["Farmer Fung"] = "Fazendeiro Fung"
	L["Fish Fellreed"] = "Peixe Cana Alta"
	L["Gina Mudclaw"] = "Gina Garra de Barro"
	L["Haohan Mudclaw"] = "Haohan Garra de Barro"
	L["Jogu the Drunk"] = "Be Bum, o Ébrio"
	L["Old Hillpaw"] = "Velho Pata do Monte"
	L["Sho"] = "Sho"
	L["Tina Mudclaw"] = "Tina Garra de Barro"

elseif ns.locale == "ruRU" then
	L["AddOn Description"] = ns.colour.plaintext .."Помогает вам с " ..ns.colour.highlight
		.."Темная Земля" ..ns.colour.plaintext .." и " ..ns.colour.highlight .."Земледельцами"
		..ns.colour.plaintext .." в Долине Четырех Ветров"
	L["At the entrance"] = "На входе"
	L["Dark Soil"] = "Темная Земля"
	L["Dark Soil Tillers"] = "Земледельцами Темная Земля"
	L["Descend into the Springtail Crag"] = "Спускайтесь в Утес Прыгохвостов"
	L["Descend into the Springtail Warren"] = "Спускайтесь в лабиринт Прыгохвост"
	L["Inside the building"] = "Внутри здания"
	L["Show the Dark Soil"] = "Показать Темная Земля"
	L["Same colour as the ground"] = "Тот же цвет, что и земля"
	L["Standing under a tree"] = "Стоя под деревом"
	L["The Tillers"] = "Земледельцами"
	L["Under the bridge"] = "Под мостом"
	L["Under the foliage"] = "Под листвой"
	L["Under the hut"] = "Под хижиной"
	L["Under the hut's\nnorthern side ramp"] = "Под пандусом северной стороны хижины"
	L["Under the tree, at\nthe edge of the lake"] = "Под деревом,\nна краю озера"
	L["Under the tree.\nIn front of Thunder"] = "Под деревом.\nПеред Гром"
	L["Under the trees.\nVery difficult to see"] = "Под деревьями.\nОчень сложно увидеть"
	L["Under the water tower"] = "Под водонапорной башней"
	L["VotFW Map"] = "Карта Долины Четырех Ветров"

	L["Chee Chee"] = "Чи-Чи"
	L["Ella"] = "Элла"
	L["Farmer Fung"] = "Фермер Фун"
	L["Fish Fellreed"] = "Рыба Тростниковая Шкура"
	L["Gina Mudclaw"] = "Джина Грязный Коготь"
	L["Haohan Mudclaw"] = "Хаохань Грязный Коготь"
	L["Jogu the Drunk"] = "Йогу Пьяный"
	L["Old Hillpaw"] = "Старик Горная Лапа"
	L["Sho"] = "Шо"
	L["Tina Mudclaw"] = "Тина Грязный Коготь"

elseif ns.locale == "zhCN" then
	L["AddOn Description"] = ns.colour.plaintext .."四风谷的" ..ns.colour.highlight .."分蘖"
		..ns.colour.plaintext .."和" ..ns.colour.highlight .."黑土"
	L["At the entrance"] = "在入口"
	L["Dark Soil"] = "黑色泥土"
	L["Dark Soil Tillers"] = "阡陌客 黑色泥土"
	L["Descend into the Springtail Crag"] = "下降到的弹尾峭壁巢穴" -- 弹尾峭壁
	L["Descend into the Springtail Warren"] = "下降到弹尾者巢穴"
	L["Inside the building"] = "建筑物内"
	L["Same colour as the ground"] = "与地面颜色相同"
	L["Show the Dark Soil"] = "显示黑色泥土"
	L["Standing under a tree"] = "站在树下"
	L["The Tillers"] = "阡陌客"
	L["Under the bridge"] = "在桥下"
	L["Under the foliage"] = "在树叶下"
	L["Under the hut"] = "在小屋下面"
	L["Under the hut's\nnorthern side ramp"] = "在小屋的北侧坡道下"
	L["Under the tree, at\nthe edge of the lake"] = "在树下，在湖边"
	L["Under the tree.\nIn front of Thunder"] = "在树下。在雷霆前面"
	L["Under the trees.\nVery difficult to see"] = "在树下。很难看"
	L["Under the water tower"] = "在水塔下"
	L["VotFW Map"] = "四风谷地图"

	L["Chee Chee"] = "吱吱"
	L["Ella"] = "艾拉"
	L["Farmer Fung"] = "农夫老方"
	L["Fish Fellreed"] = "玉儿·采苇"
	L["Gina Mudclaw"] = "吉娜·泥爪"
	L["Haohan Mudclaw"] = "郝瀚·泥爪"
	L["Jogu the Drunk"] = "醉鬼贾古"
	L["Old Hillpaw"] = "老农山掌"
	L["Sho"] = "阿烁"
	L["Tina Mudclaw"] = "迪娜·泥爪"

elseif ns.locale == "zhTW" then
	L["AddOn Description"] = ns.colour.plaintext .."幫助四風谷的" ..ns.colour.highlight .."分蘗"
		..ns.colour.plaintext .."和" ..ns.colour.highlight .."黑土"
	L["At the entrance"] = "在入口"
	L["Dark Soil"] = "黑色泥土"
	L["Dark Soil Tillers"] = "阡陌客 黑色泥土"
	L["Descend into the Springtail Crag"] = "下降到的彈尾峭壁巢穴"
	L["Descend into the Springtail Warren"] = "下降到彈尾者巢穴"
	L["Inside the building"] = "建築物內"
	L["Same colour as the ground"] = "與地面顏色相同"
	L["Show the Dark Soil"] = "顯示黑色泥土"
	L["Standing under a tree"] = "站在樹下"
	L["The Tillers"] = "阡陌客"
	L["Under the bridge"] = "在橋下"
	L["Under the foliage"] = "在樹葉下"
	L["Under the hut"] = "在小屋下面"
	L["Under the hut's\nnorthern side ramp"] = "在小屋的北側坡道下"
	L["Under the tree, at\nthe edge of the lake"] = "在樹下。在湖邊"
	L["Under the tree.\nIn front of Thunder"] = "在樹下。在雷霆前面"
	L["Under the trees.\nVery difficult to see"] = "在樹下。很難看"
	L["Under the water tower"] = "在水塔下"
	L["VotFW Map"] = "四風谷地圖"

	L["Chee Chee"] = "吱吱"
	L["Ella"] = "艾拉"
	L["Farmer Fung"] = "農夫老方"
	L["Fish Fellreed"] = "玉儿·採葦"
	L["Gina Mudclaw"] = "吉娜·泥爪"
	L["Haohan Mudclaw"] = "郝瀚·泥爪"
	L["Jogu the Drunk"] = "醉鬼賈古"
	L["Old Hillpaw"] = "老農山掌"
	L["Sho"] = "阿爍"
	L["Tina Mudclaw"] = "迪娜·泥爪"
	
else
	L["AddOn Description"] = ns.colour.plaintext .."Helps you with the " ..ns.colour.highlight 
			.."Dark Soil" ..ns.colour.plaintext .." and " ..ns.colour.highlight .."The Tillers"
			..ns.colour.plaintext .." in the Valley of the Four Winds"
	L["VotFW Map"] = "Valley of the Four Winds Map"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]
	local showCoordinates = true
	
	if ( pin.pinType == "N" ) then
		GameTooltip:SetText(ns.colour.prefix ..L[ pin.name ])
		local fri = GetFriendshipReputation( pin.friendID ) -- Friendship Reputation Info table
		local reaction, likes = match( fri.text, "([^%.]*)%.%s(.*)" )
		if fri.nextThreshold then
			GameTooltip:AddLine( ns.colour.highlight ..reaction .." ("
						..( fri.standing - fri.reactionThreshold ) .." / " 
						..( fri.nextThreshold - fri.reactionThreshold ) ..").\n"
						..ns.colour.plaintext ..likes )						
		else
			GameTooltip:AddLine(ns.colour.highlight ..reaction ..".\n" ..likes)
		end
		if pin.tip then
			GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
		end
	elseif ( pin.pinType == "O" ) then
		-- Dynamically show the next NPC to visit to continue the chain?
		-- This will show Farmer Yoon only
		local complete;
		if ( pin.quest == 30252 ) then			
			GameTooltip:SetText( ns.colour.prefix ..L[ pin.title ] )
			completed = IsQuestFlaggedCompleted( 30252 )
			if ( completed == true ) then
				GameTooltip:AddLine( ns.colour.plaintext .."Continue with Farmer Yoon" )
			else
				GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
			end
		elseif ( pin.quest == 30257 ) then			
			GameTooltip:SetText( ns.colour.prefix ..L[ pin.title ] )
			completed = IsQuestFlaggedCompleted( 30257 )
			if ( completed == true ) then
				GameTooltip:AddLine( ns.colour.plaintext .."Continue with Farmer Yoon" )
			else
				GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
			end
		elseif ( pin.quest == 30526 ) then
			completed = IsQuestFlaggedCompleted( 30526 )
			GameTooltip:AddDoubleLine( ns.colour.prefix ..L[ pin.title ],
				( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] ) 
									or ( "\124cFFFF0000" ..L["Not Completed"] ) )
			GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
		else
			GameTooltip:SetText( ns.colour.prefix ..L[ pin.title ] )
			GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
		end
		showCoordinates = false
	else -- Dark Soil
		GameTooltip:SetText( ns.colour.prefix ..L[ "Dark Soil" ] )
		if pin.questA or pin.questH then
			completed = IsQuestFlaggedCompleted( pin.questA or pin.questH )
			GameTooltip:AddDoubleLine( " ",
				( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] ) 
									or ( "\124cFFFF0000" ..L["Not Completed"] ) )
		end
		if pin.tip then
			if type( pin.tip ) == "table" then
				for i,v in ipairs( pin.tip ) do
					GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip[i] ] )
					if i < #pin.tip then
						GameTooltip:AddLine( "\n" )
					end
				end
			else
				GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
			end
		end
	end

	if ( ns.db.showCoords == true ) and ( showCoordinates == true ) then
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
	local function iterator(t, prev)
		if not t then return end
		local coord, pin = next(t, prev)
		local aId, completed, iconIndex, quest, found;
		while coord do
			if pin then
				if ( pin.pinType == "N" ) then
					return coord, nil, ns.texturesSpecial[ns.db.iconTillersNPCs],
							ns.db.iconScale * ns.scalingSpecial[ns.db.iconTillersNPCs], ns.db.iconAlpha
				elseif ( pin.pinType == "O" ) then
					local completed = IsQuestFlaggedCompleted( 30252 )
					if ( completed == true ) then
						completed = IsQuestFlaggedCompleted( 30257 )
						if ( completed == true ) then
							if ( pin.quest == 31945 ) then
								completed = IsQuestFlaggedCompleted( 31945 )
								if ( pin.title == "Gina's Vote Quest" ) then
									if ( completed == false ) then
										return coord, nil, ns.textures[ns.db.iconTillersQuests],
											ns.db.iconScale * ns.scaling[ns.db.iconTillersQuests], ns.db.iconAlpha
									end
								else
									return coord, nil, ns.textures[ns.db.iconTillersQuests],
										ns.db.iconScale * ns.scaling[ns.db.iconTillersQuests], ns.db.iconAlpha
								end
							elseif ( pin.quest == 30526 ) then
								completed = IsQuestFlaggedCompleted( 30526 )
								if ( completed == false ) then
									if coord == 42395000 then
										return coord, nil, ns.textures[ns.db.iconTillersQuests],
											ns.db.iconScale * ns.scaling[ns.db.iconTillersQuests], ns.db.iconAlpha
									end
								elseif coord == 52254894 then
									return coord, nil, ns.textures[ns.db.iconTillersQuests],
										ns.db.iconScale * ns.scaling[ns.db.iconTillersQuests], ns.db.iconAlpha
								end
							end	
						elseif ( pin.quest == 30257 ) then
							return coord, nil, ns.textures[ns.db.iconTillersQuests],
								ns.db.iconScale * ns.scaling[ns.db.iconTillersQuests], ns.db.iconAlpha
						end					
					elseif ( pin.quest == 30252 ) then
						return coord, nil, ns.textures[ns.db.iconTillersQuests],
							ns.db.iconScale * ns.scaling[ns.db.iconTillersQuests], ns.db.iconAlpha
					end
				elseif ( pin.pinType == "P" ) then
					if pin.quest then
						if IsQuestFlaggedCompleted( pin.quest ) == false then
							-- Pre-requisite satisfied so don't show the warning message
						else
							return coord, nil, ns.textures[ns.db.iconDarkSoil],
									ns.db.iconScale * ns.scaling[ns.db.iconDarkSoil], ns.db.iconAlpha
						end
					end
				elseif ( ( pin.pinType == "KS" ) or ( pin.pinType == "KW" ) or ( pin.pinType == "TJF" )
							or ( pin.pinType == "TS" ) or ( pin.pinType == "VEB" ) or ( pin.pinType == "VFW" ) ) 
						and ( ns.db.showDarkSoil == true ) then
					if pin.authorOnly then
						if ns.author then
							return coord, nil, ns.textures[10],
								ns.db.iconScale * ns.scaling[10], ns.db.iconAlpha
						end
					elseif pin.author and ns.author then
						return coord, nil, ns.textures[10],
								ns.db.iconScale * ns.scaling[10], ns.db.iconAlpha
					else
						return coord, nil, ns.textures[ns.db.iconDarkSoil],
								ns.db.iconScale * ns.scaling[ns.db.iconDarkSoil], ns.db.iconAlpha
					end
				end
			end
			coord, pin = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		ns.CurrentMap = mapID
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> Dark Soil Tillers options
ns.options = {
	type = "group",
	name = L["Dark Soil Tillers"],
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
				showDarkSoil = {
					name = L["Dark Soil"],
					desc = L["Show the Dark Soil"],
					type = "toggle",
					width = "full",
					arg = "showDarkSoil",
					order = 4,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Icon Selection"],
			inline = true,
			args = {
				iconDarkSoil = {				-- D/V/K
					type = "range",
					name = L["Dark Soil"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"],
					min = 1, max = 10, step = 1,
					arg = "iconDarkSoil",
					order = 5,
				},
				iconTillersQuests = {		-- O
					type = "range",
					name = L["NPC"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"],
					min = 1, max = 10, step = 1,
					arg = "iconTillersQuests",
					order = 6,
				},
				iconTillersNPCs = {		-- N
					type = "range",
					name = L["The Tillers"],
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = "
							..L["Cogwheel"] .."\n9 = " ..L["Screw"],
					min = 1, max = 9, step = 1,
					arg = "iconTillersNPCs",
					order = 7,
				},
			},
		},
	},
}

function HandyNotes_DarkSoilTillers_OnAddonCompartmentClick( addonName, buttonName )
	if buttonName and buttonName == "RightButton" then
		OpenWorldMap( 376 )
		if WorldMapFrame:IsVisible() ~= true then
			print( ns.colour.prefix	..L["Dark Soil Tillers"] ..": " ..ns.colour.plaintext ..L["Try later"] )
		end
	else
		Settings.OpenToCategory( "HandyNotes" )
		LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "DarkSoilTillers" )
	end
end
 
function HandyNotes_DarkSoilTillers_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( DropDownList1, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..L["Dark Soil Tillers"] )
	GameTooltip:AddLine( ns.colour.highlight .." " )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..L["Left"], ns.colour.plaintext ..L["Options"] )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..L["Right"], ns.colour.plaintext ..L["VotFW Map"] )
	GameTooltip:Show()
end

function HandyNotes_DarkSoilTillers_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	HandyNotes:RegisterPluginDB("DarkSoilTillers", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_DarkSoilDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "DarkSoilTillers")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_DarkSoilDB", "AceEvent-3.0")