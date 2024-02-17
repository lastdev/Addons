--[[
                                ----o----(||)----oo----(||)----o----

                                             Noblegarden

                                      v2.17 - 9th February 2024
									 
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
-- Pink-Purple theme
ns.colour = {}
ns.colour.prefix	= "\124cFFE641EF"
ns.colour.highlight = "\124cFFCA64EF"
ns.colour.plaintext = "\124cFFA165F0"

--ns.author = true

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								removeDailies = false, removeSeasonal = true, removeEverC = false,
								removeEverA = false, showBCE = true,
								iconHardBoiled = 16, iconNobleGarden = 12, iconSpringFling = 13,
								iconDesertRose = 11, iconNGDailies = 15, iconNGBCE = 14 } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetMapInfo = C_Map.GetMapInfo
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local UnitName = UnitName
local format = _G.format
local next = _G.next
local HandyNotes = _G.HandyNotes

ns.version = select( 4, GetBuildInfo() )
if ns.version < 40000 then
	ns.preCata = true
	ns.preAchievements = ( ns.version < 30000 )
	continents[ 1414 ] = true -- Kalimdor
	continents[ 1415 ] = true -- Eastern Kingdoms
	continents[ 947 ] = true -- Azeroth
	ns.azeroth = 947
	ns.azuremystIsle = 1943
	ns.durotar = 1411
	ns.elwynnForest = 1429
	ns.eversongWoods = 1941
	ns.silvermoonCity = 1954
	ns.stormwindCity = 1453
	ns.teldrassil = 1438
else
	ns.preCata = false
	ns.preAchievements = false
	continents[ 12 ] = true -- Kalimdor
	continents[ 13 ] = true -- Eastern Kingdoms
	continents[ 947 ] = true -- Azeroth
	ns.azeroth = 947
	ns.azuremystIsle = 97
	ns.durotar = 1
	ns.elwynnForest = 37
	ns.eversongWoods = 94
	ns.silvermoonCity = 110
	ns.stormwindCity = 84
	ns.teldrassil = 57
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
	L["AddOn Description"] = ns.colour.plaintext .."Hilfe für die " ..ns.colour.prefix .."Noblegarten"
					..ns.colour.plaintext .."-Feiertage"
	L["AnywhereC"] = "Überall im Lager"
	L["AnywhereE"] = "Überall im Lage"
	L["AnywhereS"] = "Überall auf dem Platz"
	L["AnywhereT"] = "Überall im Dorf"
	L["AnywhereZR"] = "Überall in der Zone.\nVerwende das Spielzeug \"Frühlingsfloristen\".\n"
					.."(Nobelgartenverkäufer/Nobelgartenhändler - 50x Nobelgartenschokolade)"
	L["AnywhereZW"] = "Überall in der Zone.\nVerwende die \"Frühlingsrobe\".\n"
					.."(Nobelgartenverkäufer/Nobelgartenhändler - 50x Nobelgartenschokolade)"
	L["Cenarion Hold"] = "Burg Cenarius"
	L["Golakka Hot Springs"] = "Die Heißen Quellen von Golakka"
	L["hb1"] = "(1) Ändern Sie Ihr \"Zuhause\" in Marschalls Wehr\n(2) Holen Sie sich den "..
				"Nobelgartenhäschen-stärkungszauber\n(3) Herd ---> Marschalls Wehr"
	L["hb2"] = "(4) Lauf hierher\n(5) Hier stehen und warten\n(6) Nicht reiten\n(7) Nehmen sie keinen schaden"
	L["hb3"] = "(1) Ändern Sie Ihr \"Zuhause\" in Burg Cenarius\n(2) Holen Sie sich den "..
				"Nobelgartenhäschen-stärkungszauber\n(3) Herd ---> Burg Cenarius"
	L["hide"] = "(1) Kaufen Sie ein Nobelgartenei\n(2) Platziere es irgendwo in der Stadt"
	L["Marshall's Stand"] = "Marschalls Wehr"
	L["Noblegarden"] = "Nobelgarten Erfolge"
	L["RemoveEver"] = "Entfernen Sie den Stift, wenn der Erfolg abgeschlossen ist: "

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["AddOn Description"] = ns.colour.plaintext .."Ayuda para las vacaciones de " ..ns.colour.prefix .."Jardín Noble"
	L["AnywhereC"] = "En cualquier lugar del campamento"
	L["AnywhereE"] = "En cualquier lugar del campamento"
	L["AnywhereS"] = "En cualquier lugar de la plaza"
	L["AnywhereT"] = "En cualquier lugar del pueblo"
	L["AnywhereZR"] = "En cualquier lugar de la zona.\nUsa el juguete \"Faltriquera de florista primaveral\".\n"
					.."(Vendedor/Mercader del Jardín Noble - 50x Chocolate del Jardín Noble)"
	L["AnywhereZW"] = "En cualquier lugar de la zona.\nUsa la \"Togas primaverales\".\n"
					.."(Vendedor/Mercader del Jardín Noble - 50x Chocolate del Jardín Noble)"
	L["Cenarion Hold"] = "Fuerte Cenarion"
	L["Golakka Hot Springs"] = "Baños de Golakka"
	L["hb1"] = "(1) Cambia tu \"hogar\" a Alto de Marshal\n(2) Consigue el mejora Conejito del Jardín "..
				"Noble\n(3) Hogar ---> Alto de Marshal"
	L["hb2"] = "(4) Corre hasta aqui\n(5) Quédate aquí y espera\n(6) No montar\n(7) No te dañes"
	L["hb3"] = "(1) Cambia tu \"hogar\" a Fuerte Cenarion\n(2) Consigue el mejora Conejito del Jardín "..
				"Noble\n(3) Hogar ---> Fuerte Cenarion"
	L["hide"] = "(1) Compra un Huevo del Jardín Noble\n(2) Colócalo en cualquier lugar de la ciudad"
	L["Marshall's Stand"] = "Alto de Marshal"
	L["Noblegarden"] = "Jardín Noble"
	L["RemoveEver"] = "Retire el pin si se completa el logro: "

elseif ns.locale == "frFR" then
	L["AddOn Description"] = ns.colour.plaintext .."Aide pour les vacances de " ..ns.colour.prefix .."Jardin des nobles"
	L["AnywhereC"] = "Partout dans le camp"
	L["AnywhereE"] = "Partout dans le campement"
	L["AnywhereS"] = "Partout dans la Place"
	L["AnywhereT"] = "Partout dans la ville"
	L["AnywhereZR"] = "Partout dans la zone.\nUtilisez le jouet Bourse printanière de fleuriste.\n"
					.."(Vendeur/Marchand du Jardin des nobles - 50x Chocolat du Jardin des nobles)"
	L["AnywhereZW"] = "Partout dans la zone.\nUtilisez la \"Robe de printemps\".\n"
					.."(Vendeur/Marchand du Jardin des nobles - 50x Chocolat du Jardin des nobles)"
	L["Cenarion Hold"] = "Fort Cénarien"
	L["Golakka Hot Springs"] = "Sources de Golakka"
	L["hb1"] = "(1) Changez votre \"maison\" en Camp retranché des Marshal\n(2) Obtenez le buff "..
				"Lapin du Jardin des nobles\n(3) Foyer ---> Camp retranché des Marshal"
	L["hb2"] = "(4) Courez jusqu'ici\n(5) Tenez-vous ici et attendez\n(6) Ne roule "..
				"pas\n(7) Ne pas prendre de dégâts"
	L["hb3"] = "(1) Changez votre \"maison\" en Fort Cénarien\n(2) Obtenez le buff "..
				"Lapin du Jardin des nobles\n(3) Foyer ---> Fort Cénarien"
	L["hide"] = "(1) Acheter un Oeuf du Jardin des nobles\n(2) Placez-le n'importe où dans la ville"
	L["Marshall's Stand"] = "Camp retranché des Marshal"
	L["Noblegarden"] = "Jardin des nobles"
	L["RemoveEver"] = "Retirez l'épingle si le succès est terminé: "

elseif ns.locale == "itIT" then
	L["AddOn Description"] = ns.colour.plaintext .."Aiuto per le vacanze di " ..ns.colour.prefix .."Festa di Nobiluova"
	L["AnywhereC"] = "Ovunque nel campo"
	L["AnywhereE"] = "Ovunque nell'accampamento"
	L["AnywhereS"] = "Ovunque in piazza"
	L["AnywhereT"] = "Ovunque nel villaggio"
	L["AnywhereZW"] = "Ovunque nella zona.\nUsa le \"vesti primaverili\".\n"
					.."(Mercante di Nobiluova - 50x Cioccolatino di Nobiluova)"
	L["AnywhereZR"] = "Ovunque nella zona.\nUsa il giocattolo \"Borsa del Fiorista Primaverile\".\n"
					.."(Mercante di Nobiluova - 50x Cioccolatino di Nobiluova)"
	L["Cenarion Hold"] = "Fortezza Cenariana"
	L["Golakka Hot Springs"] = "Sorgenti Calde di Golakka"
	L["hb1"] = "(1) Cambia la tua \"casa\" in Accampamento dei Grant\n(2) Ottieni il beneficio "..
				"Noblegarden Bunny\n(3) Cuore ---> Accampamento dei Grant"
	L["hb2"] = "(4) Corri qui\n(5) Stai qui e aspetta\n(6) Non guidare\n(7) Non subire danni"
	L["hb3"] = "(1) Cambia la tua \"casa\" in Cenarion Hold\n(2) Ottieni il beneficio "..
				"Noblegarden Bunny\n(3) Cuore ---> Cenarion Hold"
	L["hide"] = "(1) Acquista un Noblegarden Egg\n(2) Posizionalo ovunque in città"
	L["Marshall's Stand"] = "Accampamento dei Grant"
	L["Noblegarden"] = "Festa di Nobiluova"
	L["RemoveEver"] = "Rimuovi la spilla se l'obiettivo è stato completato: "

elseif ns.locale == "koKR" then
	L["AddOn Description"] = ns.colour.prefix .."귀족의 정원" ..ns.colour.plaintext .."휴가를 도와주세요"
	L["AnywhereC"] = "캠프 어디에서나"
	L["AnywhereE"] = "야영지 어디든"
	L["AnywhereS"] = "광장 어디에서나"
	L["AnywhereT"] = "마을 어디든"
	L["AnywhereZR"] = "영역의 아무 곳이나.\n\"봄꽃 상인의 주머니\" 장난감을 사용하세요.\n"
					.."(귀족의 정원 상인/판매원 - 50x 귀족의 정원 초콜릿)"
	L["AnywhereZW"] = "영역의 아무 곳이나.\n\"새봄맞이 로브\"를 사용하세요.\n"
					.."(귀족의 정원 상인/판매원 - 50x 귀족의 정원 초콜릿)"
	L["Cenarion Hold"] = "세나리온 요새"
	L["Golakka Hot Springs"] = "골락카 간헐천"
	L["hb1"] = "(1) \"집\"을 마샬의 격전지로 변경\n(2) 귀족의 정원 토끼 버프 받기\n(3) 화덕 ---> 마샬의 격전지"
	L["hb2"] = "(4) 여기까지 달려\n(5) 여기 서서 기다려\n(6) 타지마\n(7) 피해를 입지 않는다"
	L["hb3"] = "(1) \"집\"을 세나리온 요새로 변경\n(2) 귀족의 정원 토끼 버프 받기\n(3) 화덕 ---> 세나리온 요새"
	L["hide"] = "(1) 귀족의 정원 알 구매\n(2) 도시 어디에서나 배치"
	L["Marshall's Stand"] = "마샬의 격전지"
	L["Noblegarden"] = "귀족의 정원"
	L["RemoveEver"] = "업적이 완료되면 핀을 제거하세요: "
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["AddOn Description"] = ns.colour.plaintext .."Ajuda para o feriado de " ..ns.colour.prefix .."Jardinova"
	L["AnywhereC"] = "Em qualquer lugar do acampamento"
	L["AnywhereE"] = "Em qualquer lugar do acampamento"
	L["AnywhereS"] = "Em qualquer lugar da praça"
	L["AnywhereT"] = "Em qualquer lugar da vila"
	L["AnywhereZR"] = "Em qualquer lugar da zona.\nUse o brinquedo \"Bolsa de Florista da Primavera\".\n"
					.."(Comerciante/Mercador de Jardinova - 50x Chocolate de Jardinova)"
	L["AnywhereZW"] = "Em qualquer lugar da zona.\nUse os \"Vestes Primaveris\".\n"
					.."(Comerciante/Mercador de Jardinova - 50x Chocolate de Jardinova)"
	L["Cenarion Hold"] = "Forte Cenariano"
	L["Golakka Hot Springs"] = "Fontes Termais Golakka"
	L["hb1"] = "(1) Altere sua \"casa\" para Posto Avançado do Marshal\n(2) Obtenha o bônus "..
				"Coelhinho de Jardinova\n(3) Lar ---> Posto Avançado do Marshal"
	L["hb2"] = "(4) Corre pra cá\n(5) Fique aqui e espere\n(6) Não monte\n(7) Não tome nenhum dano"
	L["hb3"] = "(1) Altere sua \"casa\" para Forte Cenariano\n(2) Obtenha o bônus "..
				"Coelhinho de Jardinova\n(3) Lar ---> Forte Cenariano"
	L["hide"] = "(1) Compre um Ovo de Jardinova\n(2) Coloque-o em qualquer lugar da cidade"
	L["Marshall's Stand"] = "Posto Avançado do Marshal"
	L["Noblegarden"] = "Jardinova"
	L["RemoveEver"] = "Remova o alfinete se a conquista for concluída: "

elseif ns.locale == "ruRU" then
	L["AddOn Description"] = ns.colour.plaintext .."Помощь на празднике " ..ns.colour.prefix .."Сада Чудес"
	L["AnywhereC"] = "Где угодно в лагере"
	L["AnywhereE"] = "Где угодно в лагере"
	L["AnywhereS"] = "Где угодно на площади"
	L["AnywhereT"] = "Где угодно в деревне"
	L["AnywhereZR"] = "Где угодно в зоне.\nИспользуйте игрушку \"Весенний мешочек садовода\".\n"
					.."(Продавец/Торговец Сада чудес - 50x Праздничное шоколадное яйцо)"
	L["AnywhereZW"] = "Где угодно в зоне.\nИспользуйте \"Весеннее убранство\".\n"
					.."(Продавец/Торговец Сада чудес - 50x Праздничное шоколадное яйцо)"
	L["Cenarion Hold"] = "Крепости Кенария"
	L["Golakka Hot Springs"] = "Горячие источники Голакка"
	L["hb1"] = "(1) Измените свой «дом» на Застава Маршалла\n(2) Получите aура Зайчик "..
				"Сада чудес\n(3) Очаг ---> Застава Маршалла"
	L["hb2"] = "(4) Беги сюда\n(5) Стой здесь и жди\n(6) Не ездить\n(7) Не получить урона"
	L["hb3"] = "(1) Измените свой «дом» на Крепости Кенария\n(2) Получите aура Зайчик "..
				"Сада чудес\n(3) Очаг ---> Крепости Кенария"
	L["hide"] = "(1) Купить Праздничное яйцо\n(2) Разместите в любом месте города"
	L["Marshall's Stand"] = "Застава Маршалла"
	L["Noblegarden"] = "Сад Чудес"
	L["RemoveEver"] = "Удалите булавку, если достижение выполнено: "

elseif ns.locale == "zhCN" then
	L["AddOn Description"] = ns.colour.prefix .."复活节" ..ns.colour.plaintext .."假期的帮助"
	L["AnywhereC"] = "在营地的任何地方"
	L["AnywhereE"] = "在营地的任何地方"
	L["AnywhereS"] = "广场上的任何地方"
	L["AnywhereT"] = "村子里的任何地方"
	L["AnywhereZR"] = "区域内的任何地方.\n使用 \"春日花袋\" 玩具.\n"
					.."(复活节小贩/复活节商人 - 50x 复活节巧克力)"
	L["AnywhereZW"] = "区域内的任何地方.\n使用 \"春季长袍\".\n"
					.."(复活节小贩/复活节商人 - 50x 复活节巧克力)"
	L["Cenarion Hold"] = "塞纳里奥要塞"
	L["Golakka Hot Springs"] = "葛拉卡温泉"
	L["hb1"] = "(1) 将您的“家”更改为 马绍尔哨站\n(2) 获得 复活节小兔 增益\n(3) 炉石 ---> 马绍尔哨站"
	L["hb2"] = "(4) 跑到这里\n(5) 站在这里等待\n(6) 不要骑\n(7) 不受伤害"
	L["hb3"] = "(1) 将您的“家”更改为 塞纳里奥要塞\n(2) 获得 复活节小兔 增益\n(3) 炉石 ---> 塞纳里奥要塞"
	L["hide"] = "(1) 购买 复活节彩蛋\n(2) 把它放在城市的任何地方"
	L["Marshall's Stand"] = "马绍尔哨站"
	L["Noblegarden"] = "贵族的花园"
	L["RemoveEver"] = "如果成就完成，请移除图钉： "

elseif ns.locale == "zhTW" then
	L["AddOn Description"] = ns.colour.prefix .."復活節" ..ns.colour.plaintext .."假期的幫助"
	L["AnywhereC"] = "在營地的任何地方"
	L["AnywhereE"] = "在營地的任何地方"
	L["AnywhereS"] = "廣場上的任何地方"
	L["AnywhereT"] = "村子裡的任何地方"
	L["AnywhereZR"] = "區域內的任何地方.\n使用 \"春日花袋\" 玩具.\n"
					.."(復活節小販/復活節商人 - 50x 復活節巧克力)"
	L["AnywhereZW"] = "區域內的任何地方.\n使用 \"春季長袍\".\n"
					.."(復活節小販/復活節商人 - 50x 復活節巧克力)"
	L["Cenarion Hold"] = "塞纳里奥要塞"
	L["Golakka Hot Springs"] = "葛拉卡溫泉"
	L["hb1"] = "(1) 將您的“家”更改為 馬紹爾哨站\n(2) 獲得 復活節小兔 增益\n(3) 爐石 ---> 馬紹爾哨站"
	L["hb2"] = "(4) 跑到這裡\n(5) 站在這裡等待\n(6) 不要騎\n(7) 不受傷害"
	L["hb3"] = "(1) 將您的“家”更改為 塞納里奧要塞\n(2) 獲得 復活節小兔 增益\n(3) 爐石 ---> 塞納里奧要塞"
	L["hide"] = "(1) 購買 復活節彩蛋\n(2) 把它放在城市的任何地方"
	L["Marshall's Stand"] = "馬紹爾哨站"
	L["Noblegarden"] = "貴族的花園"
	L["RemoveEver"] = "如果成就完成，請移除圖釘： "
	
else
	L["AddOn Description"] = ns.colour.plaintext .."Help for the " ..ns.colour.prefix .."Noblegarden"
					..ns.colour.plaintext .." holiday"
	L["AnywhereC"] = "Anywhere in the camp"
	L["AnywhereE"] = "Anywhere in the encampment"
	L["AnywhereS"] = "Anywhere in the square"
	L["AnywhereT"] = "Anywhere in the village"
	L["AnywhereZR"] = "Anywhere in the zone.\nUse the \"Spring Florist's Pouch\" toy.\n"
					.."(Noblegarden Vendor/Merchant - 50x Noblegarden Chocolate)"
	L["AnywhereZW"] = "Anywhere in the zone.\nUse the \"Spring Robes\".\n"
					.."(Noblegarden Vendor/Merchant - 50x Noblegarden Chocolate)"
	L["hb1"] = "(1) Change your \"home\" to Marshall's Stand\n(2) Get the Noblegarden Bunny "
				.."buff\n(3) Hearth ---> Marshall's Stand"
	L["hb2"] = "(4) Run to here\n(5) Stand here and wait\n(6) Do not ride\n(7) Take no damage"
	L["hb3"] = "(1) Change your \"home\" to Cenarion Hold\n(2) Get the Noblegarden Bunny "
				.."buff\n(3) Hearth ---> Cenarion Hold"
	L["hide"] = "(1) Purchase a Noblegarden egg\n(2) Place it anywhere in the city"
	L["RemoveEver"] = "Remove the pin if the Achievement is completed: "
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
	
	if pin.aID and ( ns.preAchievements == false ) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( pin.aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight,
			( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..L[ "Account" ] ..")" ) 
								or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..L[ "Account" ] ..")" ) )
		if ( pin.aID == 2416 ) or ( pin.aID == 2420 ) or ( pin.aID == 2421 ) then
			if not ns.preCata then
				completedMe = select( 3, GetAchievementCriteriaInfo( pin.aID, 1, true ) )
			end
		end
		GameTooltip:AddDoubleLine( " ",
			( completedMe == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..ns.name ..")" ) 
								or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..ns.name ..")" ) )
		if pin.aIndex then
			aName, _, completed = GetAchievementCriteriaInfo( pin.aID, pin.aIndex )
			GameTooltip:AddDoubleLine( ns.colour.highlight ..aName,
				( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..ns.name ..")" ) 
									or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..ns.name ..")" ) )
		end
		if ( pin.aID == 2416 ) then
			GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.name ] )
		end
	elseif pin.obj then -- Brightly Colored Eggs
		GameTooltip:SetText( ns.colour.prefix ..L[ pin.name ] )		
	else -- Dailies with quests
		GameTooltip:SetText( ns.colour.prefix ..L["Noblegarden"] )
		completed = IsQuestFlaggedCompleted( pin.quest )
		GameTooltip:AddDoubleLine( ns.colour.highlight ..pin.qName,
			( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..ns.name ..")" ) 
								or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..ns.name ..")" ) )
	end
	if pin.tip then
		GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
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

local function ShowConditionallyS( aID, aIndex )
	if ( ns.db.removeSeasonal == true ) then
		if aIndex then
			local _, _, completed = GetAchievementCriteriaInfo( aID, aIndex )
		else
			local completed = select( 13, GetAchievementInfo( aID ) )
		end
		if ( completed == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyE( aID  )
	local completed, completedMe;
	if ( ns.db.removeEverA == true ) or ( ns.db.removeEverC == true ) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( aID )
		if ( ns.db.removeEverA == true ) and ( completed == true ) then
			return false
		end
		if ns.db.removeEverC == true then
			if completedMe == true then
				return false
			end
		end
	end
	return true
end

local function ShowConditionallyQ( quest )
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
		local coord, pin = next(t, prev)
		while coord do
			if pin then
				if pin.aID then
					if ns.preAchievements == false then
						if ( pin.aID == 2436 ) then -- Desert Rose
							if ( ShowConditionallyE( pin.aID ) == true ) then
								if ( ShowConditionallyS( pin.aID, pin.aIndex ) == true ) then
									return coord, nil, ns.textures[ ns.db.iconDesertRose ],
											ns.db.iconScale * ns.scaling[ ns.db.iconDesertRose ], ns.db.iconAlpha
								end
							end
						elseif ( pin.aID == 2419 ) then -- Spring Fling Alliance
							if ( ns.faction == "Alliance" ) then
								if ( ShowConditionallyE( pin.aID ) == true ) then
									if ( ShowConditionallyS( pin.aID, ( ns.preCata and pin.aIndexC or pin.aIndexR ) ) == true ) then
										return coord, nil, ns.textures[ ns.db.iconSpringFling ],
												ns.db.iconScale * ns.scaling[ ns.db.iconSpringFling ], ns.db.iconAlpha
									end
								end
							end
						elseif ( pin.aID == 2497 ) then -- Spring Fling Horde
							if ( ns.faction == "Horde" ) then
								if ( ShowConditionallyE( pin.aID ) == true ) then
									if ( ShowConditionallyS( pin.aID, ( ns.preCata and pin.aIndexC or pin.aIndexR ) ) == true ) then
										return coord, nil, ns.textures[ ns.db.iconSpringFling ],
												ns.db.iconScale * ns.scaling[ ns.db.iconSpringFling ], ns.db.iconAlpha
									end
								end
							end
						elseif ( pin.aID == 2420 ) or ( pin.aID == 2421 ) then -- Noblegarden
							if ( ns.faction == pin.faction ) then
								if ( ShowConditionallyE( pin.aID ) == true ) then
									if ( ShowConditionallyS( pin.aID ) == true ) then
										return coord, nil, ns.textures[ ns.db.iconNobleGarden ],
												ns.db.iconScale * ns.scaling[ ns.db.iconNobleGarden ], ns.db.iconAlpha
									end
								end
							end
						elseif ( pin.aID == 2416 ) then -- Hard Boiled
							if ( ShowConditionallyE( pin.aID ) == true ) then
								if ( ShowConditionallyS( pin.aID ) == true ) then
									return coord, nil, ns.textures[ ns.db.iconHardBoiled ],
											ns.db.iconScale * ns.scaling[ ns.db.iconHardBoiled ], ns.db.iconAlpha
								end
							end
						end
					end
				elseif pin.obj then -- Brightly Colored Eggs
					if ns.db.showBCE == true then
						if pin.author then
							if ns.author then
								return coord, nil, ns.textures[ ns.db.iconNGBCE ],
										ns.db.iconScale * ns.scaling[ ns.db.iconNGBCE ] * 0.5, ns.db.iconAlpha
							end
						elseif pin.preCata then
							if ( ns.preCata == pin.preCata ) then
								return coord, nil, ns.textures[ ns.db.iconNGBCE ],
										ns.db.iconScale * ns.scaling[ ns.db.iconNGBCE ] * 0.5, ns.db.iconAlpha
							end
						else
							return coord, nil, ns.textures[ ns.db.iconNGBCE ],
									ns.db.iconScale * ns.scaling[ ns.db.iconNGBCE ] * 0.5, ns.db.iconAlpha
						end
					end
				elseif pin.quest and ( ns.faction == pin.faction ) then -- Dailies with quests
					if ( pin.preCata ~= nil ) then
						if ns.preCata == pin.preCata then
							if ( ShowConditionallyQ( pin.quest ) == true ) then
								return coord, nil, ns.textures[ ns.db.iconNGDailies ],
										ns.db.iconScale * ns.scaling[ ns.db.iconNGDailies ], ns.db.iconAlpha
							end
						end
					else
						if ( ShowConditionallyQ( pin.quest ) == true ) then
							return coord, nil, ns.textures[ ns.db.iconNGDailies ],
									ns.db.iconScale * ns.scaling[ ns.db.iconNGDailies ], ns.db.iconAlpha
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

-- Interface -> Addons -> Handy Notes -> Plugins -> Noblegarden options
ns.options = {
	type = "group",
	name = L["Noblegarden"],
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
					desc = "Achievements are usually repeatable each season.\n"
							.."This also applies to components within an achievement",
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					order = 5,
				},
				removeEverC = {
					name =  L["RemoveEver"] ..ns.colour.highlight ..ns.name,
					desc = " ",
					type = "toggle",
					width = "full",
					arg = "removeEverC",
					disabled = ns.preAchievements,
					order = 6,
				},
				removeEverA = {
					name = L["RemoveEver"] ..ns.colour.highlight ..L["Account"],
					desc = " ",
					type = "toggle",
					width = "full",
					arg = "removeEverA",
					disabled = ns.preAchievements,
					order = 7,
				},
				showBCE = {
					name = "Show Brightly Colored Eggs",
					desc = "Show a (much smaller) pin in Razor Hill / Dolanaar etc",
					type = "toggle",
					width = "full",
					arg = "showBCE",
					order = 8,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Map Pin Selections"],
			inline = true,
			args = {
				iconHardBoiled = {
					type = "range",
					name = L["Hard Boiled"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Noblegarden"] .." - " ..L["Blue"] .."\n12 = " ..L["Noblegarden"] 
							.." - " ..L["Green"] .."\n13 = " ..L["Noblegarden"] .." - " ..L["Pink"]
							.."\n14 = " ..L["Noblegarden"] .." - " ..L["Red"] .."\n15 = " ..L["Noblegarden"] 
							.." - " ..L["Orange"] .."\n16 = " ..L["Noblegarden"] .." - " ..L["Yellow"],
					min = 1, max = 16, step = 1,
					arg = "iconHardBoiled",
					disabled = ns.preAchievements,
					order = 9,
				},
				iconNobleGarden = {
					type = "range",
					name = L["Noblegarden"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Noblegarden"] .." - " ..L["Blue"] .."\n12 = " ..L["Noblegarden"] 
							.." - " ..L["Green"] .."\n13 = " ..L["Noblegarden"] .." - " ..L["Pink"]
							.."\n14 = " ..L["Noblegarden"] .." - " ..L["Red"] .."\n15 = " ..L["Noblegarden"] 
							.." - " ..L["Orange"] .."\n16 = " ..L["Noblegarden"] .." - " ..L["Yellow"],
					min = 1, max = 16, step = 1,
					arg = "iconNobleGarden",
					disabled = ns.preAchievements,
					order = 10,
				},
				iconSpringFling = {
					type = "range",
					name = L["Spring Fling"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Noblegarden"] .." - " ..L["Blue"] .."\n12 = " ..L["Noblegarden"] 
							.." - " ..L["Green"] .."\n13 = " ..L["Noblegarden"] .." - " ..L["Pink"]
							.."\n14 = " ..L["Noblegarden"] .." - " ..L["Red"] .."\n15 = " ..L["Noblegarden"] 
							.." - " ..L["Orange"] .."\n16 = " ..L["Noblegarden"] .." - " ..L["Yellow"],
					min = 1, max = 16, step = 1,
					arg = "iconSpringFling",
					disabled = ns.preAchievements,
					order = 11,
				},
				iconDesertRose = {
					type = "range",
					name = L["Desert Rose"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Noblegarden"] .." - " ..L["Blue"] .."\n12 = " ..L["Noblegarden"] 
							.." - " ..L["Green"] .."\n13 = " ..L["Noblegarden"] .." - " ..L["Pink"]
							.."\n14 = " ..L["Noblegarden"] .." - " ..L["Red"] .."\n15 = " ..L["Noblegarden"] 
							.." - " ..L["Orange"] .."\n16 = " ..L["Noblegarden"] .." - " ..L["Yellow"],
					min = 1, max = 16, step = 1,
					arg = "iconDesertRose",
					disabled = ns.preAchievements,
					order = 12,
				},
				iconNGDailies = {
					type = "range",
					name = L["Dailies"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Noblegarden"] .." - " ..L["Blue"] .."\n12 = " ..L["Noblegarden"] 
							.." - " ..L["Green"] .."\n13 = " ..L["Noblegarden"] .." - " ..L["Pink"]
							.."\n14 = " ..L["Noblegarden"] .." - " ..L["Red"] .."\n15 = " ..L["Noblegarden"] 
							.." - " ..L["Orange"] .."\n16 = " ..L["Noblegarden"] .." - " ..L["Yellow"],
					min = 1, max = 16, step = 1,
					arg = "iconNGDailies",
					order = 13,
				},
				iconNGBCE = {
					type = "range",
					name = L["Brightly Colored Eggs"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Noblegarden"] .." - " ..L["Blue"] .."\n12 = " ..L["Noblegarden"] 
							.." - " ..L["Green"] .."\n13 = " ..L["Noblegarden"] .." - " ..L["Pink"]
							.."\n14 = " ..L["Noblegarden"] .." - " ..L["Red"] .."\n15 = " ..L["Noblegarden"] 
							.." - " ..L["Orange"] .."\n16 = " ..L["Noblegarden"] .." - " ..L["Yellow"],
					min = 1, max = 16, step = 1,
					arg = "iconNGBCE",
					order = 14,
				},
			},
		},
	},
}

function HandyNotes_NobleGarden_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "NobleGarden" )
 end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			if map.mapID == ns.silvermoonCity or map.mapID == ns.stormwindCity or map.mapID == ns.teldrassil then
				-- Don't use. I have to use TWO pins for both of the cities so here I supress an extra continent pin
				-- Teldrassil seems more complex but this hack works
			elseif ns.preCata and ( map.mapID < ns.azeroth ) then
			elseif ( not ns.preCata ) and ( map.mapID > ns.azeroth ) then
			elseif coords then
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
	HandyNotes:RegisterPluginDB("NobleGarden", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_NobleGardenDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "NobleGarden")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_NobleGardenDB", "AceEvent-3.0")