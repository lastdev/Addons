--[[
                                ----o----(||)----oo----(||)----o----

                                      Long-Forgotten Hippogryph

                                      v1.19 - 14th October 2023
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
ns.texturesSpecial = {}
ns.scalingSpecial = {}
ns.oceania = {}
-- Pink-Purple theme
ns.colour = {}
ns.colour.prefix	= "\124cFFE641EF"
ns.colour.highlight = "\124cFFCA64EF"
ns.colour.plaintext = "\124cFFA165F0"
-- Map IDs
ns.azsuna = 630			-- Azsuna
ns.oceanusCove = 632	-- Oceanus Cove sub-zone within Azsuna

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true, showOutlyingCaves = false,
								iconCrystal = 2, iconCaveEntrance = 4, iconCaveEntranceU = 2 } }
local pluginHandler = {}
--ns.author = true

-- upvalues
local GameTooltip = _G.GameTooltip
local GetBestMapForUnit = C_Map.GetBestMapForUnit
local GetSubZoneText = _G.GetSubZoneText
local IsIndoors = _G.IsIndoors
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local next = _G.next

local HandyNotes = _G.HandyNotes

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
	L["Long-Forgotten Hippogryph"] = "Lang vergessener Hippogryph"
	L["Grey Shoals"] = "Die Grauen Untiefen"
	L["Cave Entrance"] = "Höhle Eingang"
	L["Nor'Danil Wellspring burrow"] = "Der Quelle von Nor'danil-Bau"
	L["* Concealed entrance *"] = "* Verdeckter eingang *"
	L["Prison of the Demon Huntress"] = "Gefängnis der Dämonenjägerin"
	L["Llothien Grizzly cave"] = "Die Höhle der Llothiengrizzly"
	L["Runas' Hovel"] = "Hövel von Runas"
	L["Fiend Lair"] = "Scheusal Höhle"
	L["Oceanus Cove"] = "Ozeanus' Bucht"
	L["Leyhollow"] = "Leygrotten"
	L["Ooker Dooker cave"] = "Der Knatzelfiddler Höhle"
	L["West Entrance"] = "Eingang West"
	L["North Entrance"] = "Eingang Nord"
	L["South Entrance"] = "Eingang Süd"
	L["Azurewing Repose"] = "Azurschwingenrast"
	L["Salteye murloc cave"] = "Die Höhle der Salzaugen-Murloc"
	L["Malignant stalker cave"] = "Die Höhle der Heimtückischer Pirscher"
	L["Shipwreck Arena cave"] = "Höhle an der Schiffbrucharena"
	L["Lair of the Deposed"] = "Versteck der Entthronte"
	L["Jilted Former Lover"] = "Höhle des Verschmähter Liebhaber"
	L["South-East Entrance"] = "Eingang Süd-Ost"
	L["Cliffdweller Fox lair"] = "Felsläuferfuchs Höhle"
	L["Cove Gull cave"] = "Bucht Möwenhöhle"
	L["El'dranil Peak"] = "El'dranil-Gipfel"
	L["Gangamesh's Den"] = "Höhle von Gangamesh"
	L["Withered J'im's cave"] = "Höhle von Verdorrter J'im"
	L["Llothien cave"] = "Höhle von Llothien"
	L["Resting Dauorbjorn"] = "Schlummernder Dauorbjorn"
	L["Ley-Ruins of Zarkhenar"] = "Leyruinen von Zarkhenar"
	L["The Old Coast Path"] = "Der alte Küstenpfad"
	L["Three-way tunnel"] = "Drei-Wege-Tunnel"
	L["Llothien river burrow"] = "Llothien fluss-bau"
	L["Temple of a Thousand Lights"] = "Tempel der Tausend Lichter"
	L["Hatecoil Slave Pen"] = "Sklavenpferch der Hassnattern"
	L["Dead Man's Bay 1"] = "Toten Manns Bucht 1"
	L["Dead Man's Bay 2"] = "Toten Manns Bucht 2"
	L["Dead Man's Bay 3"] = "Toten Manns Bucht 3"
	L["Mak'rana Elder"] = "Ältester der Mak'rana"
	L["Mak'rana"] = "Mak'rana Höhle"
	L["Eksis' Lair"] = "Eksis Höhle"
	L["Olivian Veil"] = "Olivanhöhen"
	L["Kira Iresoul's cave"] = "Höhle von Kira Zornseele"
	L["Cave of Queen Kraklaa"] = "Die Höhle von Königin Kraklaa"
	L["Submerged"] = "Untergetaucht"
	L["Gloombound Barrow"] = "Finsterbundgrabhügel"
	L["Felblaze Ingress"] = "Der Teufelsfeuervorstoß"
	L["Ephemeral Crystal"] = "Flüchtiger Kristall"
	L["Unknown"] = "Unbekannt"
	L["AddOn Description"] = "Hilft Ihnen, den " ..ns.colour.highlight
		.."Lang vergessener Hippogryph\124r zu erhalten"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["Long-Forgotten Hippogryph"] = "Hipogrifo olvidado hace tiempo"
	L["Grey Shoals"] = "Marisma Gris"
	L["Cave Entrance"] = "Entrada de la cueva"
	L["Nor'Danil Wellspring burrow"] = "Madriguera del Manantial de Nor'danil"
	L["* Concealed entrance *"] = "* Entrada oculta *"
	L["Prison of the Demon Huntress"] = "Prisión de la Cazadora de demonios"
	L["Llothien Grizzly cave"] = "Cueva del Oso pardo de Llothien"
	L["Tunnel"] = "Túnel"
	L["Runas' Hovel"] = "La Cuchitril de Runas"
	L["Fiend Lair"] = "Guarida del Maligno"
	L["Oceanus Cove"] = "Cala de Oceanus"
	L["Leyhollow"] = "Cuenca Ley"
	L["Ooker Dooker cave"] = "Guarida del Okey Makey"
	L["West Entrance"] = "Entrada Oeste"
	L["North Entrance"] = "Entrada Norte"
	L["South Entrance"] = "Entrada Sur"
	L["Azurewing Repose"] = "Reposo Alazur"
	L["Salteye murloc cave"] = "La cueva del múrloc de ojosal"
	L["Malignant stalker cave"] = "La cueva del acechador maligno"
	L["Shipwreck Arena cave"] = "La cueva del Arena del Naufragio"
	L["Lair of the Deposed"] = "Guarida de los Derrocado"
	L["Jilted Former Lover"] = "Cueva del Antiguo Amante Rechazado"
	L["South-East Entrance"] = "Entrada Sureste"	
	L["Cliffdweller Fox lair"] = "Guarida del Zorro habitarrisco"
	L["Cove Gull cave"] = "Cueva de la Gaviota de Cala"
	L["El'dranil Peak"] = "Pico del El'dranil"
	L["Gangamesh's Den"] = "Guarida de Gangamesh"
	L["Withered J'im's cave"] = "Cueva de J'im Marchito"
	L["Llothien cave"] = "Cueva de Llothien"
	L["Resting Dauorbjorn"] = "Dauorbjorn Descansando"
	L["Ley-Ruins of Zarkhenar"] = "Ruinas Ley de Zarkhenar"
	L["The Old Coast Path"] = "La Vieja Senda de la Costa."
	L["Three-way tunnel"] = "Túnel de tres vías"
	L["Llothien river burrow"] = "Madriguera del río Llothien"
	L["Temple of a Thousand Lights"] = "Templo de las Mil Luces"
	L["Hatecoil Slave Pen"] = "Cárcel de Esclavos Espiral de Odio"
	L["Dead Man's Bay 1"] = "Bahía del Hombre Muerto 1"
	L["Dead Man's Bay 2"] = "Bahía del Hombre Muerto 2"
	L["Dead Man's Bay 3"] = "Bahía del Hombre Muerto 3"
	L["Mak'rana Elder"] = "Anciano de Mak'rana"
	L["Mak'rana"] = "Cueva de Mak'rana"
	L["Eksis' Lair"] = "Guarida del Eksis"
	L["Olivian Veil"] = "Velo Oliváceo"
	L["Kira Iresoul's cave"] = "Cueva de Kira Almaíra"
	L["Cave of Queen Kraklaa"] = "La cueva de la Reina Kraklaa"
	L["Submerged"] = "Sumergida"
	L["Gloombound Barrow"] = "Túmulo de la Penumbra"
	L["Felblaze Ingress"] = "Acceso Llamarada Vil"
	L["Ephemeral Crystal"] = "Cristal efímero"
	L["Unknown"] = "Desconocido"
	L["AddOn Description"] = "Te ayuda a obtener el " ..ns.colour.highlight
		.."Hipogrifo olvidado hace tiempo"

elseif ns.locale == "frFR" then
	L["Long-Forgotten Hippogryph"] = "Hippogriffe oublié depuis longtemps"
	L["Grey Shoals"] = "Gris-Fonds"
	L["Cave Entrance"] = "Entrée de la grotte"
	L["Nor'Danil Wellspring burrow"] = "Terrier de Source de Nor'danil"
	L["* Concealed entrance *"] = "* Entrée cachée *"
	L["Prison of the Demon Huntress"] = "Prison de la Chasseuse de Démons"
	L["Llothien Grizzly cave"] = "Grotte de Grizzly de Llothien"
	L["Runas' Hovel"] = "La Masure de Runas"
	L["Fiend Lair"] = "Repaire de Fiel"
	L["Oceanus Cove"] = "Grotte d’Océanus"
	L["Leyhollow"] = "Creux Tellurique"
	L["Ooker Dooker cave"] = "Grotte de Ouko Doukacque"
	L["West Entrance"] = "Entrée Ouest"
	L["North Entrance"] = "Entrée Nord"
	L["South Entrance"] = "Entrée Sud"
	L["Azurewing Repose"] = "Repos Aile-d’Azur"
	L["Salteye murloc cave"] = "La grotte de sel-œil Murloc"
	L["Malignant stalker cave"] = "La grotte de  traqueur malveillant"
	L["Shipwreck Arena cave"] = "La grotte du l'arène de l'Épave"
	L["Lair of the Deposed"] = "Repaire des Détrôné"
	L["Jilted Former Lover"] = "Grotte de l'Ancien Amoureux Éconduit"
	L["South-East Entrance"] = "Entrée Sud-Est"	
	L["Cliffdweller Fox lair"] = "Repaire de Renard hante-falaise"
	L["Cove Gull cave"] = "Grotte de la Goéland de la Crique"
	L["El'dranil Peak"] = "Pic du El'dranil"
	L["Gangamesh's Den"] = "Repaire de Gangamesh"
	L["Withered J'im's cave"] = "Grotte de J'im le Flétri"
	L["Llothien cave"] = "Grotte de Llothien"
	L["Resting Dauorbjorn"] = "Dauorbjörn au Repos"
	L["Ley-Ruins of Zarkhenar"] = "les Ruines Telluriques de Zarkhenar"
	L["The Old Coast Path"] = "L’Ancienne voie Côtière"
	L["Three-way tunnel"] = "Tunnel à trois voies"
	L["Llothien river burrow"] = "Terrier de la rivière Llothien"
	L["Temple of a Thousand Lights"] = "Temple des Mille lumières"
	L["Hatecoil Slave Pen"] = "Enclos aux esclaves des Glissefiel"
	L["Dead Man's Bay 1"] = "La Baie du Mort 1"
	L["Dead Man's Bay 2"] = "La Baie du Mort 2"
	L["Dead Man's Bay 3"] = "La Baie du Mort 3"
	L["Mak'rana Elder"] = "Ancien de Mak’rana"
	L["Mak'rana"] = "Grotte de Mak'rana"
	L["Eksis' Lair"] = "Repaire de Eksis"
	L["Olivian Veil"] = "Voile Olivine"
	L["Kira Iresoul's cave"] = "Grotte de Kira Irâme"
	L["Cave of Queen Kraklaa"] = "La grotte de la Reine Kraklaa"
	L["Submerged"] = "Submergé"
	L["Gloombound Barrow"] = "Le Tertre Sombrelié"
	L["Felblaze Ingress"] = "La Gueule du Brasier infernal"
	L["Ephemeral Crystal"] = "Cristal éphémère"
	L["Unknown"] = "Inconnu"
	L["AddOn Description"] = "Vous aide à obtenir " ..ns.colour.highlight
		.."l'hippogriffe oublié depuis longtemps"

elseif ns.locale == "itIT" then
	L["Long-Forgotten Hippogryph"] = "Ippogrifo del Passato"
	L["Grey Shoals"] = "Scogli Grigi"
	L["Cave Entrance"] = "Entrata della grotta"
	L["Nor'Danil Wellspring burrow"] = "Fonte di Nor'danil tana"
	L["* Concealed entrance *"] = "* Ingresso nascosto *"
	L["Prison of the Demon Huntress"] = "Prigione della Cacciatrice di Demoni"
	L["Llothien Grizzly cave"] = "Grotta dell'Grizzly di Llothien"
	L["Tunnel"] = "Fagliavuota"
	L["Runas' Hovel"] = "Il Tugurio di Runas"
	L["Fiend Lair"] = "L'antro della Demonio"
	L["Oceanus Cove"] = "Baia di Oceanus"
	L["Leyhollow"] = "Grotta di Fagliavuota"
	L["Ooker Dooker cave"] = "Grotta del Uggo Dugga"
	L["West Entrance"] = "Ingresso Ovest"
	L["North Entrance"] = "Ingresso Nord"
	L["South Entrance"] = "Ingresso Sud"
	L["Azurewing Repose"] = "Riposo degli Alazzurra"
	L["Salteye murloc cave"] = "Grotta di murloc occhio-salino"
	L["Malignant stalker cave"] = "Grotta di Inseguitore Maligno"
	L["Shipwreck Arena cave"] = "La grotta dell'Arena del naufragio"
	L["Lair of the Deposed"] = "Tana dei Deposto"
	L["Jilted Former Lover"] = "Grotta dell'Ex Amante Respinto"
	L["South-East Entrance"] = "Ingresso Sud-Est"	
	L["Cliffdweller Fox lair"] = "L'antro della Volpe che Abita-scogliere"
	L["Cove Gull cave"] = "Grotta del Gabbiano della Cala"
	L["El'dranil Peak"] = "Cima del El'dranil"
	L["Gangamesh's Den"] = "La tana di Gangamesh"
	L["Withered J'im's cave"] = "Grotta del J'im l'Avvizzito"
	L["Llothien cave"] = "Grotta del Llothien"
	L["Resting Dauorbjorn"] = "Dauorbjorn a Riposo"
	L["Ley-Ruins of Zarkhenar"] = "Faglia delle Rovine di Zarkhenar"
	L["The Old Coast Path"] = "La Vecchia Via Costiera"
	L["Three-way tunnel"] = "Tunnel a tre vie"
	L["Llothien river burrow"] = "La tana del fiume Llothien"
	L["Temple of a Thousand Lights"] = "Tempio delle Mille Luci"
	L["Hatecoil Slave Pen"] = "Recinto degli Spiraostile"
	L["Dead Man's Bay 1"] = "Baia del Morto 1"
	L["Dead Man's Bay 2"] = "Baia del Morto 2"
	L["Dead Man's Bay 3"] = "Baia del Morto 3"
	L["Mak'rana Elder"] = "Anziano Mak'rana"
	L["Mak'rana"] = "Grotta del Mak'rana"
	L["Eksis' Lair"] = "L'antro di Eksis"
	L["Olivian Veil"] = "Velo Olivastro"
	L["Kira Iresoul's cave"] = "Grotta del Kira Iranima"
	L["Cave of Queen Kraklaa"] = "La grotta della Regina Kraklaa"
	L["Submerged"] = "Sommersa"
	L["Gloombound Barrow"] = "Riparo Buiopesto"
	L["Felblaze Ingress"] = "Soglia della Vilfiamma"
	L["Ephemeral Crystal"] = "Cristallo Effimero"
	L["Unknown"] = "Sconosciuto"
	L["AddOn Description"] = "Ti aiuta a ottenere " ..ns.colour.highlight
		.."l'ippogrifo del Passato"

elseif ns.locale == "koKR" then
	L["Long-Forgotten Hippogryph"] = "기억 저편의 히포그리프"
	L["Grey Shoals"] = "잿빛 모래톱"
	L["Cave Entrance"] = "동굴 입구"
	L["Nor'Danil Wellspring burrow"] = "노르다닐 수원지에지의 굴"
	L["* Concealed entrance *"] = "* 숨겨진 입구 *"
	L["Prison of the Demon Huntress"] = "악마 사냥꾼의 감옥"
	L["Llothien Grizzly cave"] = "로시엔 곰 동굴"
	L["Tunnel"] = "터널"
	L["Runas' Hovel"] = "루나스의 동굴"
	L["Fiend Lair"] = "악령 동굴"
	L["Oceanus Cove"] = "오세아누스 만"
	L["Leyhollow"] = "지맥분지"
	L["Ooker Dooker cave"] = "우끼끼 두까까 동굴"
	L["West Entrance"] = "서쪽 입구"
	L["North Entrance"] = "북쪽 입구"
	L["South Entrance"] = "남쪽 입구"
	L["Azurewing Repose"] = "하늘빛나래 휴식"
	L["Salteye murloc cave"] = "소금눈 멀록 동굴"
	L["Malignant stalker cave"] = "악성 추적자 동굴"
	L["Shipwreck Arena cave"] = "난파선 투기장 동굴"
	L["Lair of the Deposed"] = "퇴위된 소굴"
	L["Jilted Former Lover"] = "버림받은 옛 연인 동굴"
	L["South-East Entrance"] = "남동쪽 입구"	
	L["Cliffdweller Fox lair"] = "절벽살이 여우 소굴"
	L["Cove Gull cave"] = "해안 갈매기 동굴"
	L["El'dranil Peak"] = "엘드라닐 산봉우리"
	L["Gangamesh's Den"] = "강가메시의 소굴"
	L["Withered J'im's cave"] = "메마른 짐 동굴"
	L["Llothien cave"] = "로시엔 배회자 동굴"
	L["Resting Dauorbjorn"] = "휴식 중인 다우오르비욘"
	L["Ley-Ruins of Zarkhenar"] = "자르케나르의 지맥 폐허"
	L["The Old Coast Path"] = "옛 해안 길"
	L["Three-way tunnel"] = "삼 방향 터널"
	L["Llothien river burrow"] = "로시안 강 굴"
	L["Temple of a Thousand Lights"] = "천 갈래 빛의 사원"
	L["Hatecoil Slave Pen"] = "증오갈퀴 노예 우리"
	L["Dead Man's Bay 1"] = "죽은 자의 만에 1"
	L["Dead Man's Bay 2"] = "죽은 자의 만에 2"
	L["Dead Man's Bay 3"] = "죽은 자의 만에 3"
	L["Mak'rana Elder"] = "마크라나 장로"
	L["Mak'rana"] = "마크라나 동굴"
	L["Eksis' Lair"] = "에크시스 소굴"
	L["Olivian Veil"] = "올리비안 장막"
	L["Kira Iresoul's cave"] = "키라 아이어소울 동굴"
	L["Cave of Queen Kraklaa"] = "여왕 크라클라 여왕의 동굴"
	L["Submerged"] = "잠수함"
	L["Gloombound Barrow"] = "어스름살이 지하굴"
	L["Felblaze Ingress"] = "지옥화염 침투지"
	L["Ephemeral Crystal"] = "찰나의 수정"
	L["Unknown"] = "알 수 없음"
	L["AddOn Description"] = ns.colour.highlight .."오랫동안 잊혀진 히포그리프\124r 를 얻는 데 도움이됩니다."

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Long-Forgotten Hippogryph"] = "Hipogrifo Esquecido"
	L["Grey Shoals"] = "Baixios Cinzentos"
	L["Cave Entrance"] = "Entrada da caverna"
	L["Nor'Danil Wellspring burrow"] = "Toca de Nascente Lor'Danel"
	L["* Concealed entrance *"] = "* Entrada Oculta *"
	L["Prison of the Demon Huntress"] = "Prisão da Caçadora de Demônios"
	L["Llothien Grizzly cave"] = "Caverna do Urso de Llothien"
	L["Tunnel"] = "Túnel"
	L["Runas' Hovel"] = "a Grota de Runas"
	L["Fiend Lair"] = "Covil de Demônio"
	L["Oceanus Cove"] = "Enseada de Oceanus"
	L["Leyhollow"] = "Grota do Meridiano"
	L["Ooker Dooker cave"] = "Caverna de Fedentino Fedorento"
	L["West Entrance"] = "Entrada Oeste"
	L["North Entrance"] = "Entrada Norte"
	L["South Entrance"] = "Entrada sul"
	L["Azurewing Repose"] = "Repouso Lazulasa"
	L["Salteye murloc cave"] = "Caverna Olho-de-Sal murloc"
	L["Malignant stalker cave"] = "Caverna Espreitador Maligno"
	L["Shipwreck Arena cave"] = "A caverna na Arena Naufragada"
	L["Lair of the Deposed"] = "Covil dos Deposto"
	L["Jilted Former Lover"] = "Caverna do Antigo Amante Abandonado"
	L["South-East Entrance"] = "Entrada Sudeste"	
	L["Cliffdweller Fox lair"] = "Covil de Raposa do Penhasco"
	L["Cove Gull cave"] = "Caverna do Gaivota-da-angra"
	L["El'dranil Peak"] = "Pico do El'dranil"
	L["Gangamesh's Den"] = "Covil de Gangamesh"
	L["Withered J'im's cave"] = "Caverna de J'im Fenecido"
	L["Llothien cave"] = "Caverna de Llothien"
	L["Resting Dauorbjorn"] = "Dauorbjorn Descansando"
	L["Ley-Ruins of Zarkhenar"] = "Ruínas Meridionais de Zarkhenar"
	L["The Old Coast Path"] = "O Velho Caminho Costeiro"
	L["Three-way tunnel"] = "Túnel de três vias"
	L["Llothien river burrow"] = "Toca do rio Llothien"
	L["Temple of a Thousand Lights"] = "Templo de Mil Luzes"
	L["Hatecoil Slave Pen"] = "Cercado de Escravos dos Espiródios"
	L["Dead Man's Bay 1"] = "Baía do Morto 1"
	L["Dead Man's Bay 2"] = "Baía do Morto 2"
	L["Dead Man's Bay 3"] = "Baía do Morto 3"
	L["Mak'rana Elder"] = "Ancião Mak'rana"
	L["Mak'rana"] = "Caverna de Mak'rana"
	L["Eksis' Lair"] = "Covil de Eksis"
	L["Olivian Veil"] = "Véu Oliviano"
	L["Kira Iresoul's cave"] = "Caverna de Kira Iralma"
	L["Cave of Queen Kraklaa"] = "A caverna da Rainha Kraklaa"
	L["Submerged"] = "Submersa"
	L["Gloombound Barrow"] = "Entrada da Trevosa"
	L["Felblaze Ingress"] = "Passagem Brasavil"
	L["Ephemeral Crystal"] = "Cristal Efêmero"
	L["Unknown"] = "Desconhecido"
	L["AddOn Description"] = "Ajuda você a obter o " ..ns.colour.highlight
		.."Hipogrifo Esquecido"

elseif ns.locale == "ruRU" then
	L["Long-Forgotten Hippogryph"] = "Давно брошенный гиппогриф"
	L["Grey Shoals"] = "Серые Мели"
	L["Cave Entrance"] = "Вход в пещеру"
	L["Nor'Danil Wellspring burrow"] = "Нора у Pодника Нор'Данил"
	L["* Concealed entrance *"] = "* Скрытый вход *"
	L["Prison of the Demon Huntress"] = "Тюрьма Охотницы на Демонов"
	L["Llothien Grizzly cave"] = "Ллотиенский Гризли Пещера"
	L["Tunnel"] = "Туннель"
	L["Runas' Hovel"] = "Ниша Рунас"
	L["Fiend Lair"] = "Логово Исчадие"
	L["Oceanus Cove"] = "бухту Океания"
	L["Leyhollow"] = "Пещеры Силы"
	L["Ooker Dooker cave"] = "Пещера Укер-дукер"
	L["West Entrance"] = "Западный Вход"
	L["North Entrance"] = "Северный Вход"
	L["South Entrance"] = "Южный Вход"
	L["Azurewing Repose"] = "Покоя Лазурного Крыла"
	L["Salteye murloc cave"] = "Пещера мурлок соленого глаза"
	L["Malignant stalker cave"] = "Пещера Злонравный преследователь"
	L["Shipwreck Arena cave"] = "Пещера в арена кораблекрушеня"
	L["Lair of the Deposed"] = "Логово Низложенный"
	L["Jilted Former Lover"] = "Пещера Брошенная бывшая Возлюбленная"
	L["South-East Entrance"] = "Юго-восточный Вход"	
	L["Cliffdweller Fox lair"] = "Логово Скальная лиса"
	L["Cove Gull cave"] = "Чайка бухты Пещера"
	L["El'dranil Peak"] = "Эль'дранилский Вершина"
	L["Gangamesh's Den"] = "Логово Гангамеш"
	L["Withered J'im's cave"] = "Пещера Иссохший Дж'им"
	L["Llothien cave"] = "Пещера Ллотиенский"
	L["Resting Dauorbjorn"] = "Отдыхающий Даурбьорн"
	L["Ley-Ruins of Zarkhenar"] = "Силовые Руины Заркенара"
	L["The Old Coast Path"] = "Старом береговом Пути"
	L["Three-way tunnel"] = "Трехходовой туннель"
	L["Llothien river burrow"] = "Нора реки Ллотиенский"
	L["Temple of a Thousand Lights"] = "Храме Тысячи Огней"
	L["Hatecoil Slave Pen"] = "Узилище Клана Колец Ненависти"
	L["Dead Man's Bay 1"] = "Заливе Мертвеца 1"
	L["Dead Man's Bay 2"] = "Заливе Мертвеца 2"
	L["Dead Man's Bay 3"] = "Заливе Мертвеца 3"
	L["Mak'rana Elder"] = "Старейшина Мак'раны"
	L["Mak'rana"] = "Пещера Мак'рана"
	L["Eksis' Lair"] = "Логово Эксис"
	L["Olivian Veil"] = "Оливковом Покрове"
	L["Kira Iresoul's cave"] = "Пещера Кира Злобная Душа"
	L["Cave of Queen Kraklaa"] = "Пещера Королева Краклаа"
	L["Submerged"] = "Погруженный"
	L["Gloombound Barrow"] = "Пещере Темного Ритуала"
	L["Felblaze Ingress"] = "Врата Пламени Скверны"
	L["Ephemeral Crystal"] = "Эфемерный Кристалл"
	L["Unknown"] = "Неизвестно"
	L["AddOn Description"] = "Помогает получить " ..ns.colour.highlight
		.."Давно брошенный Гиппогрифф"

elseif ns.locale == "zhCN" then
	L["Long-Forgotten Hippogryph"] = "失落已久的角鹰兽"
	L["Grey Shoals"] = "灰色浅滩"
	L["Cave Entrance"] = "洞入口"
	L["Nor'Danil Wellspring burrow"] = "诺达尼尔圣泉洞穴"
	L["* Concealed entrance *"] = "* 隐藏入口 *"
	L["Prison of the Demon Huntress"] = "恶魔猎手的监狱"
	L["Llothien Grizzly cave"] = "洛希恩灰熊洞穴"
	L["Tunnel"] = "隧道"
	L["Runas' Hovel"] = "鲁纳斯洞穴"
	L["Fiend Lair"] = "魔巢穴"
	L["Oceanus Cove"] = "欧逊努斯海窟"
	L["Leyhollow"] = "魔能洞窟"
	L["Ooker Dooker cave"] = "乌克都克洞穴"
	L["West Entrance"] = "西入口"
	L["North Entrance"] = "北入口"
	L["South Entrance"] = "南入口"
	L["Azurewing Repose"] = "蓝翼栖地"
	L["Salteye murloc cave"] = "盐眼鱼人洞穴"
	L["Malignant stalker cave"] = "恶毒漫步者洞穴"
	L["Shipwreck Arena cave"] = "沉船竞技场中的洞穴。"
	L["Lair of the Deposed"] = "被废翻者的巢穴。"
	L["Jilted Former Lover"] = "被抛弃的前情人的洞穴"
	L["South-East Entrance"] = "东南入口"	
	L["Cliffdweller Fox lair"] = "峭壁狐的巢穴"
	L["Cove Gull cave"] = "海湾鸥洞穴"
	L["El'dranil Peak"] = "艾达尼尔的巅峰"
	L["Gangamesh's Den"] = "贡戈麦什的巢穴"
	L["Withered J'im's cave"] = "凋零者吉姆洞穴"
	L["Llothien cave"] = "洛希恩洞穴"
	L["Resting Dauorbjorn"] = "休眠的守卫之熊"
	L["Ley-Ruins of Zarkhenar"] = "扎赫纳尔魔网废墟"
	L["The Old Coast Path"] = "旧海滩小径"
	L["Three-way tunnel"] = "三通隧道"
	L["Llothien river burrow"] = "洛锡恩河洞穴"
	L["Temple of a Thousand Lights"] = "千光神殿"
	L["Hatecoil Slave Pen"] = "积怨奴隶围栏"
	L["Dead Man's Bay 1"] = "亡者海湾 1"
	L["Dead Man's Bay 2"] = "亡者海湾 2"
	L["Dead Man's Bay 3"] = "亡者海湾 3"
	L["Mak'rana Elder"] = "玛拉纳长者"
	L["Mak'rana"] = "玛拉纳洞穴"
	L["Eksis' Lair"] = "克西斯巢穴"
	L["Olivian Veil"] = "奥利维安影障"
	L["Kira Iresoul's cave"] = "奇拉·艾索尔洞穴"
	L["Cave of Queen Kraklaa"] = "克拉克拉女王的洞穴"
	L["Submerged"] = "湮"
	L["Gloombound Barrow"] = "暗缚兽穴"
	L["Felblaze Ingress"] = "邪焰隘口"
	L["Ephemeral Crystal"] = "短命的水晶"
	L["Unknown"] = "未知"
	L["AddOn Description"] = "帮助您获得" ..ns.colour.highlight .."失落已久的角鹰兽"

elseif ns.locale == "zhTW" then
	L["Long-Forgotten Hippogryph"] = "失落已久的角鷹獸"
	L["Grey Shoals"] = "灰色淺灘"
	L["Cave Entrance"] = "洞入口"
	L["Nor'Danil Wellspring burrow"] = "諾達尼爾聖泉洞穴"
	L["* Concealed entrance *"] = "* 隱藏入口 *"
	L["Prison of the Demon Huntress"] = "惡魔獵手的監獄"
	L["Llothien Grizzly cave"] = "洛希恩灰熊洞穴"
	L["Tunnel"] = "隧道"
	L["Runas' Hovel"] = "魯納斯洞穴"
	L["Fiend Lair"] = "魔巢穴"
	L["Oceanus Cove"] = "歐遜努斯海窟"
	L["Leyhollow"] = "魔能洞窟"
	L["Ooker Dooker cave"] = "烏克都克洞穴"
	L["West Entrance"] = "西入口"
	L["North Entrance"] = "北入口"
	L["South Entrance"] = "南入口"
	L["Azurewing Repose"] = "藍翼棲地"
	L["Salteye murloc cave"] = "鹽眼魚人洞穴"
	L["Malignant stalker cave"] = "惡毒漫步者洞穴"
	L["Shipwreck Arena cave"] = "沉船競技場中的洞穴。"
	L["Lair of the Deposed"] = "被廢翻者的巢穴。"
	L["Jilted Former Lover"] = "被拋棄的前情人的洞穴"
	L["South-East Entrance"] = "東南入口"	
	L["Cliffdweller Fox lair"] = "峭壁狐的巢穴"
	L["Cove Gull cave"] = "海灣鷗洞穴"
	L["El'dranil Peak"] = "艾達尼爾的巔峰"
	L["Gangamesh's Den"] = "貢戈麥什的巢穴"
	L["Withered J'im's cave"] = "凋零者吉姆洞穴"
	L["Llothien cave"] = "洛希恩洞穴"
	L["Resting Dauorbjorn"] = "休眠的守衛之熊"
	L["Ley-Ruins of Zarkhenar"] = "扎赫納爾魔網廢墟"
	L["The Old Coast Path"] = "舊海灘小徑"
	L["Three-way tunnel"] = "三通隧道"
	L["Llothien river burrow"] = "洛錫恩河洞穴"
	L["Temple of a Thousand Lights"] = "千光神殿"
	L["Hatecoil Slave Pen"] = "積怨奴隸圍欄"
	L["Dead Man's Bay 1"] = "亡者海灣 1"
	L["Dead Man's Bay 2"] = "亡者海灣 2"
	L["Dead Man's Bay 3"] = "亡者海灣 3"
	L["Mak'rana Elder"] = "瑪拉納長者"
	L["Mak'rana"] = "瑪拉納洞穴"
	L["Eksis' Lair"] = "克西斯巢穴"
	L["Olivian Veil"] = "奧利維安影障"
	L["Kira Iresoul's cave"] = "奇拉·艾索爾洞穴"
	L["Cave of Queen Kraklaa"] = "克拉克拉女王的洞穴"
	L["Submerged"] = "湮"
	L["Gloombound Barrow"] = "暗縛獸穴"
	L["Felblaze Ingress"] = "邪焰隘口"
	L["Ephemeral Crystal"] = "短命的水晶"
	L["Unknown"] = "未知"
	L["AddOn Description"] = "幫助您獲得" ..ns.colour.highlight .."失落已久的角鷹獸"
	
else
	L["Shipwreck Arena cave"] = "Cave at the Shipwreck Arena"
	if ns.locale == "enUS" then
		L["Grey Shoals"] = "Gray Shoals"
	end
	L["AddOn Description"] = "Helps you to obtain the " ..ns.colour.highlight .."Long-Forgotten Hippogryph"
end

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]

	if pin.dt == "CE" then
		if pin.name then
			GameTooltip:SetText( ns.colour.prefix ..L[ pin.name ] )
			if not pin.tip then
				GameTooltip:AddLine( ns.colour.highlight ..L["Cave Entrance"] )
			end
		else
			GameTooltip:SetText( ns.colour.prefix ..L["Cave Entrance"] )
		end
	else
		GameTooltip:SetText( ns.colour.prefix ..L["Ephemeral Crystal"] )
	end
	if pin.tip then
		GameTooltip:AddLine( L[ pin.tip ] )
	end
	if ns.author and pin.author then
		GameTooltip:AddLine( "\124cFFFF0000Author" )
	end
	
	if pin.ecCount then
		if pin.ecCount == "?" then
			GameTooltip:AddLine( L["Ephemeral Crystal"] ..": " ..L["Unknown"] )
		else
			GameTooltip:AddLine( L["Ephemeral Crystal"] ..": " ..pin.ecCount )
		end
	end
	
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
			local mapAreaInID = GetBestMapForUnit( "player" ) or 0
			local indoors = ((mapAreaInID == ns.azsuna or mapAreaInID == ns.oceanusCove) and IsIndoors()) and true or false
			if ns.indoors == nil then
				ns.indoors = indoors
			elseif ns.indoors ~= indoors then
				ns.indoors = indoors
				pluginHandler:Refresh()
			end
        end
    end)

	if ns.indoors == nil then
		ns.indoors = IsIndoors() and true or false
	end

	local function iterator(t, prev)
		if not t then return end
		local coord, v = next(t, prev)
		while coord do
			if v then
				if ns.CurrentMap == ns.oceanusCove then
					if v.dt == "O" then
						return coord, nil, ns.textures[ns.db.iconCrystal], 
								ns.db.iconScale * ns.scaling[ns.db.iconCrystal], ns.db.iconAlpha
					end
				elseif v.dt ~= "O" then
					if ns.indoors == true then
						if v.dt == "C" then						
							return coord, nil, ns.textures[ns.db.iconCrystal], 
									ns.db.iconScale * ns.scaling[ns.db.iconCrystal], ns.db.iconAlpha
						end
					elseif v.dt ~= "C" then
						if v.dt == "CE" then
							if v.ecCount == "?" or v.ecCount == "0" then
								if ns.db.showOutlyingCaves == true or not v.outlying then
									return coord, nil, ns.texturesSpecial[ns.db.iconCaveEntranceU], 
											ns.db.iconScale * ns.scalingSpecial[ns.db.iconCaveEntranceU], ns.db.iconAlpha
									end
							else
								if ns.author then
									if v.author then
										return coord, nil, ns.texturesSpecial[ns.db.iconCaveEntrance], 
												ns.db.iconScale * ns.scalingSpecial[ns.db.iconCaveEntrance], ns.db.iconAlpha
									end
								else
									return coord, nil, ns.texturesSpecial[ns.db.iconCaveEntrance], 
											ns.db.iconScale * ns.scalingSpecial[ns.db.iconCaveEntrance], ns.db.iconAlpha
								end
							end
						else
							if ns.author then
								if v.author then
									return coord, nil, ns.textures[ns.db.iconCrystal], 
											ns.db.iconScale * ns.scaling[ns.db.iconCrystal], ns.db.iconAlpha
								end
							else
								return coord, nil, ns.textures[ns.db.iconCrystal], 
										ns.db.iconScale * ns.scaling[ns.db.iconCrystal], ns.db.iconAlpha
							end
						end
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

-- Interface -> Addons -> Handy Notes -> Plugins -> Long-Forgotten Hippogryph options
ns.options = {
	type = "group",
	name = L["Long-Forgotten Hippogryph"],
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
				showOutlyingCaves = {
					name = L["Show Outlying Caves"],
					desc = L["Show the Caves at Faronaar and Isle of the Watchers"], 
					type = "toggle",
					width = "full",
					arg = "showOutlyingCaves",
					order = 4,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Icon Selection"],
			inline = true,
			args = {
				iconCrystal = {
					type = "range",
					name = L["Ephemeral Crystal"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"],
					min = 1, max = 10, step = 1,
					arg = "iconCrystal",
					order = 5,
				},
				iconCaveEntrance = {
					type = "range",
					name = L["Cave Entrance"],
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = " 
							..L["Cogwheel"] .."\n9 = " ..L["Screw"],
					min = 1, max = 9, step = 1,
					arg = "iconCaveEntrance",
					order = 6,
				},
				iconCaveEntranceU = {
					type = "range",
					name = L["Cave Entrance"] .." (" ..L["Unknown"] ..")",
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = " 
							..L["Cogwheel"] .."\n9 = " ..L["Screw"],
					min = 1, max = 9, step = 1,
					arg = "iconCaveEntranceU",
					order = 7,
				},
			},
		},
	},
}

function HandyNotes_LongForgottenHippogryph_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "LongForgottenHippogryph" )
 end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	HandyNotes:RegisterPluginDB("LongForgottenHippogryph", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_LongForgottenHippogryphDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "LongForgottenHippogryph")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_LongForgottenHippogryphDB", "AceEvent-3.0")