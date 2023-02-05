--[[
                                ----o----(||)----oo----(||)----o----

                                           Lunar Festival

                                      v1.08 - 3rd February 2023
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local myName, ns = ...
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

local defaults = { profile = { icon_scale = 1.7, icon_alpha = 1, showCoords = true,
								removeOneOff = true, removeSeasonal = true, removeEver = false,
								icon_zoneElders = 16, icon_dungeonElders = 14, icon_crown = 1,
								icon_factionElders = 11, icon_preservation = 10 } }
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
local gsub = string.gsub
local next = _G.next

local HandyNotes = _G.HandyNotes

local _, _, _, version = GetBuildInfo()
ns.faction = UnitFactionGroup( "player" )
ns.name = UnitName( "player" ) or "Character"

continents[ 12 ] = true -- Kalimdor
continents[ 13 ] = true -- Eastern Kingdoms
continents[ 113 ] = true -- Northrend
continents[ 947 ] = true -- Azeroth
continents[ 1978 ] = true -- Dragon Isles

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
	L["Lunar Festival"] = "Mondfest"
	L["Dungeons"] = "Kerker"
	L["Factions"] = "Fraktionen"
	L["Zones"] = "Gebiete"
	L["Lunar Preservation"] = "Mondschutz"
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
	L["Blue Coin"] = "Blaue Münze"
	L["Deep Green Coin"] = "Tiefgrüne Münze"
	L["Deep Pink Coin"] = "Tiefrosa Münze"
	L["Deep Red Coin"] = "Tiefrote Münze"
	L["Green Coin"] = "Grüne Münze"
	L["Light Blue Coin"] = "Hellblaue Münze"
	L["Pink Coin"] = "Rosa Münze"
	L["Purple Coin"] = "Lila Münze"
	L["Teal Coin"] = "Blaugrüne Münze"
	L["Original Coin"] = "Ursprüngliche Münze"
	L["AddOn Description"] = "Hilfe für Erfolge und Quests in Mondfest"
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
	L["Lunar Festival"] = "El festín del Festival Lunar"
	L["Dungeons"] = "Mazmorras"
	L["Factions"] = "Facciones"
	L["Zones"] = "Zonas"
	L["Lunar Preservation"] = "Preservación Lunar"
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
	L["Blue Coin"] = "Moneda Azul"
	L["Deep Green Coin"] = "Moneda Verde Oscuro"
	L["Deep Pink Coin"] = "Moneda Rosa Oscuro"
	L["Deep Red Coin"] = "Moneda de color Rojo Oscuro"
	L["Green Coin"] = "Moneda Verde"
	L["Light Blue Coin"] = "Moneda Azul Claro"
	L["Pink Coin"] = "Moneda Rosa"
	L["Purple Coin"] = "Moneda Morada"
	L["Teal Coin"] = "Moneda Verde Azulado"
	L["Original Coin"] = "Moneda Original"
	L["AddOn Description"] = "Ayuda para los logros del Festival Lunar"
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
	L["Lunar Festival"] = "Fête lunaire"
	L["Dungeons"] = "Donjons"
	L["Factions"] = "Factions"
	L["Zones"] = "Zones"
	L["Lunar Preservation"] = "Préservation Lunaire"
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
	L["Blue Coin"] = "Pièce bleue"
	L["Deep Green Coin"] = "Pièce vert foncé"
	L["Deep Pink Coin"] = "Pièce rose foncé"
	L["Deep Red Coin"] = "Pièce rouge foncé"
	L["Green Coin"] = "Pièce verte"
	L["Light Blue Coin"] = "Pièce bleu clair"
	L["Pink Coin"] = "Pièce rose"
	L["Purple Coin"] = "Pièce violette"
	L["Teal Coin"] = "Pièce sarcelle"
	L["Original Coin"] = "Pièce originale"
	L["AddOn Description"] = "Aide à l'événement mondial Fête lunaire"
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
	L["Lunar Festival"] = "Celebrazione della Luna"
	L["Dungeons"] = "Sotterranee"
	L["Factions"] = "Fazioni"
	L["Zones"] = "Zone"
	L["Lunar Preservation"] = "Preservazione Lunare"
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
	L["Blue Coin"] = "Moneta blu"
	L["Deep Green Coin"] = "Moneta verde intenso"
	L["Deep Pink Coin"] = "Moneta rosa intenso"
	L["Deep Red Coin"] = "Moneta rosso scuro"
	L["Green Coin"] = "Moneta verde"
	L["Light Blue Coin"] = "Moneta azzurra"
	L["Pink Coin"] = "Moneta rosa"
	L["Purple Coin"] = "Moneta viola"
	L["Teal Coin"] = "Moneta verde acqua"
	L["Original Coin"] = "Moneta originale"
	L["AddOn Description"] = "Assiste con l'evento mondiale Celebrazione della Luna"
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
	L["Lunar Festival"] = "달의 축제"
	L["Dungeons"] = "던전"
	L["Factions"] = "진영"
	L["Zones"] = "지역"
	L["Lunar Preservation"] = "달빛지기"
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
	L["Blue Coin"] = "블루 코인"
	L["Deep Green Coin"] = "딥그린 코인"
	L["Deep Pink Coin"] = "딥 핑크 코인"
	L["Deep Red Coin"] = "딥 레드 코인"
	L["Green Coin"] = "그린 코인"
	L["Light Blue Coin"] = "하늘색 동전"
	L["Pink Coin"] = "핑크 코인"
	L["Purple Coin"] = "퍼플 코인"
	L["Teal Coin"] = "틸 코인"
	L["Original Coin"] = "원래 동전"
	L["AddOn Description"] = "달의 축제 대규모 이벤트 지원"	
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
	L["Lunar Festival"] = "Festival da Lua"
	L["Dungeons"] = "Masmorras"
	L["Factions"] = "Facções"
	L["Zones"] = "Zonas"
	L["Lunar Preservation"] = "Preservação lunar"
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
	L["Blue Coin"] = "Moeda azul"
	L["Deep Green Coin"] = "moeda verde escuro"
	L["Deep Pink Coin"] = "Moeda rosa escuro"
	L["Deep Red Coin"] = "moeda vermelha escura"
	L["Green Coin"] = "moeda verde"
	L["Light Blue Coin"] = "Moeda azul claro"
	L["Pink Coin"] = "moeda rosa"
	L["Purple Coin"] = "moeda roxa"
	L["Teal Coin"] = "moeda azul-petróleo"
	L["Original Coin"] = "moeda original"
	L["AddOn Description"] = "Auxilia no evento mundial Festival da Lua"
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
	L["Lunar Festival"] = "Лунный фестиваль"
	L["Dungeons"] = "Подземелья"
	L["Factions"] = "ФракцииФракции"
	L["Zones"] = "Территории"
	L["Lunar Preservation"] = "Лунная Консервация"
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
	L["Blue Coin"] = "Синяя Монета"
	L["Deep Green Coin"] = "Темно-зеленая Монета"
	L["Deep Pink Coin"] = "Темно-розовая Монета"
	L["Deep Red Coin"] = "Темно-красная Монета"
	L["Green Coin"] = "Зеленая Монета"
	L["Light Blue Coin"] = "Голубая Монета"
	L["Pink Coin"] = "Розовая Монета"
	L["Purple Coin"] = "Фиолетовая Монета"
	L["Teal Coin"] = "Бирюзовая Монета"
	L["Original Coin"] = "Оригинальная Монета"
	L["AddOn Description"] = "Помогает с игровое событие Лунный фестиваль"
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
	L["Lunar Festival"] = "春节"
	L["Dungeons"] = "地下城"
	L["Factions"] = "阵营"
	L["Zones"] = "地区"
	L["Lunar Preservation"] = "月光守护"
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
	L["Blue Coin"] = "蓝币"
	L["Deep Green Coin"] = "深绿币"
	L["Deep Pink Coin"] = "深粉色硬币"
	L["Deep Red Coin"] = "深红硬币"
	L["Green Coin"] = "绿币"
	L["Light Blue Coin"] = "淡蓝色硬币"
	L["Pink Coin"] = "粉币"
	L["Purple Coin"] = "紫币"
	L["Teal Coin"] = "蓝绿色硬币"
	L["Original Coin"] = "原币"
	L["AddOn Description"] = "协助春节活动"
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
	L["Lunar Festival"] = "春節"
	L["Dungeons"] = "地下城"
	L["Factions"] = "陣營"
	L["Zones"] = "地區"
	L["Lunar Preservation"] = "月光守護"
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
	L["Blue Coin"] = "藍幣"
	L["Deep Green Coin"] = "深綠幣"
	L["Deep Pink Coin"] = "深粉色硬幣"
	L["Deep Red Coin"] = "深紅硬幣"
	L["Green Coin"] = "綠幣"
	L["Light Blue Coin"] = "淡藍色硬幣"
	L["Pink Coin"] = "粉幣"
	L["Purple Coin"] = "紫幣"
	L["Teal Coin"] = "藍綠色硬幣"
	L["Original Coin"] = "原幣"
	L["AddOn Description"] = "協助春節活動"
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
	L["AddOn Description"] = "Help for the Lunar Festival achievements"
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
end

local function printPC( message )
	if message then
		DEFAULT_CHAT_FRAME:AddMessage( ns.colour.prefix .."LunarFestival" ..": " ..ns.colour.plaintext
			..message.. "\124r" )
	end
end

-- Plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	local point = ns.points[mapFile] and ns.points[mapFile][coord]
	return point[1], point[2], point[3], point[4], point[5], point[6], point[7]
end

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local aIDA, aIDH, aIndexA, aIndexH, aQuestA, aQuestH, tip = infoFromCoord(mapFile, coord)

	local aID = ((  aIDA > 0 ) and aIDA ) or aIDH
	local aIndex = ((  aIndexA > 0 ) and aIndexA ) or aIndexH
	local aQuest = ((  aQuestA > 0 ) and aQuestA ) or aQuestH
	local pName = UnitName( "player" ) or "Character"
	local completed, aName, completedMe;
	local bypassCoords = false
	local showTip = true
	
	if (aID > 0) and (aIndex > 0) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
		if ( aQuest > 0 ) then
			completed = C_QuestLog.IsQuestFlaggedCompleted( aQuest )
			aName = GetAchievementCriteriaInfo( aID, aIndex )
		else
			aName, _, completed = GetAchievementCriteriaInfo( aID, aIndex )
		end
		GameTooltip:AddDoubleLine( ns.colour.highlight.. aName,
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
	elseif (aID > 0) then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
	elseif ( aQuest > 0 ) then
		if ( aQuest == 63213 ) then
			completed = C_QuestLog.IsQuestFlaggedCompleted( aQuest )
			GameTooltip:AddDoubleLine( ns.colour.prefix .."Naladu the Elder",
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
		elseif ( aQuest == 56842 ) then
			GameTooltip:SetText( ns.colour.prefix ..L["Lunar Preservation"] )
			completed = C_QuestLog.IsQuestFlaggedCompleted( 56842 )
			GameTooltip:AddDoubleLine( ns.colour.highlight .."All nine locations...",
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
			showTip = false
		elseif ( aQuest == 56903 ) or ( aQuest == 56904 ) or ( aQuest == 56905 ) or ( aQuest == 56906 ) then
			completed = C_QuestLog.IsQuestFlaggedCompleted( aQuest )
			GameTooltip:AddDoubleLine( ns.colour.prefix ..( ( aQuest == 56906) and L["Crown of Good Fortune"]
										or ( ( aQuest == 56905) and L["Crown of Dark Blossoms"] 
										or ( ( aQuest == 56904) and L["Crown of Prosperity"] 
										or L["Crown of Courage"] ) ) ),
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
			questObjectives = C_QuestLog.GetQuestObjectives( aQuest )
			for k,v in pairs( questObjectives ) do
				if ( aIndex == k ) then
					for i,j in pairs( v ) do
						if ( i == "finished" ) then
							GameTooltip:AddDoubleLine( ns.colour.prefix ..L[tip],
										( j == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..pName ..")" ) 
															or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..pName ..")" ) )
						end
					end
				end
			end
			showTip = false
		end
	else
		bypassCoords = true
	end
	if ( showTip == true ) and not ( tip == nil ) then
		GameTooltip:AddLine( ns.colour.plaintext ..L[tip] )
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
		if ( aIndex > 0 ) then
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

local function ShowConditionallyO( aQuestA, aQuestH )
	local completed;
	if ( ns.db.removeOneOff == true ) and ( ( aQuestA > 0 ) or ( aQuestH > 0 ) ) then
		completed = C_QuestLog.IsQuestFlaggedCompleted( ( aQuestA > 0 ) and aQuestA or aQuestH )
		if ( completed == true ) then
			return false
		end
	end
	return true
end

local function ShowConditionallyS( aQuestA, aQuestH )
	local completed;
	if ( ns.db.removeSeasonal == true ) and ( ( aQuestA > 0 ) or ( aQuestH > 0 ) ) then
		completed = C_QuestLog.IsQuestFlaggedCompleted( ( aQuestA > 0 ) and aQuestA or aQuestH )
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
				if ( v[1] == 910 ) and ( ns.faction == "Alliance" ) then
					if ( ShowConditionallyE( v[1], v[3] ) == true ) then
						if ( ShowConditionallyS( v[5], v[6] ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_dungeonElders],
								ns.db.icon_scale * ns.scaling[ns.db.icon_dungeonElders], ns.db.icon_alpha
						end
					end
				elseif ( v[2] == 910 ) and ( ns.faction == "Horde" ) then
					if ( ShowConditionallyE( v[2], v[4] ) == true ) then
						if ( ShowConditionallyS( v[5], v[6] ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_dungeonElders],
								ns.db.icon_scale * ns.scaling[ns.db.icon_dungeonElders], ns.db.icon_alpha
						end
					end
				elseif ( ( v[1] == 911 ) or ( v[1] == 912 ) or ( v[1] == 1396 ) or ( v[1] == 6006 ) or ( v[1] == 17321 ) ) 
						and ( ns.faction == "Alliance" ) then
					if ( ShowConditionallyE( v[1], v[3] ) == true ) then
						if ( ShowConditionallyS( v[5], v[6] ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_zoneElders],
								ns.db.icon_scale * ns.scaling[ns.db.icon_zoneElders], ns.db.icon_alpha
						end
					end
				elseif ( ( v[2] == 911 ) or ( v[2] == 912 ) or ( v[2] == 1396 ) or ( v[2] == 6006 ) or ( v[1] == 17321 ) )
						and ( ns.faction == "Horde" ) then
					if ( ShowConditionallyE( v[2], v[4] ) == true ) then
						if ( ShowConditionallyS( v[5], v[6] ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_zoneElders],
								ns.db.icon_scale * ns.scaling[ns.db.icon_zoneElders], ns.db.icon_alpha
						end
					end
				elseif ( ( v[1] == 914 ) or ( v[1] == 915 ) ) and ( ns.faction == "Alliance" ) then
					if ( ShowConditionallyE( v[1], v[3] ) == true ) then
						if ( ShowConditionallyS( v[5], v[6] ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_factionElders],
								ns.db.icon_scale * ns.scaling[ns.db.icon_factionElders], ns.db.icon_alpha
						end
					end
				elseif ( ( v[2] == 914 ) or ( v[2] == 915 ) ) and ( ns.faction == "Horde" ) then
					if ( ShowConditionallyE( v[2], v[4] ) == true ) then
						if ( ShowConditionallyS( v[5], v[6] ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_factionElders],
								ns.db.icon_scale * ns.scaling[ns.db.icon_factionElders], ns.db.icon_alpha
						end
					end
				elseif ( v[5] == 63213 ) or ( v[6] == 63213 ) then
					if ( ShowConditionallyS( v[5], v[6] ) == true ) then
						return coord, nil, ns.textures[ns.db.icon_factionElders],
							ns.db.icon_scale * ns.scaling[ns.db.icon_factionElders], ns.db.icon_alpha
					end
				elseif ( v[5] == 56842 ) or ( v[6] == 56842 ) then
					if ( ShowConditionallyO( v[5], v[6] ) == true ) then
						return coord, nil, ns.textures[ns.db.icon_preservation],
							ns.db.icon_scale * ns.scaling[ns.db.icon_preservation], ns.db.icon_alpha
					end
				elseif ( v[5] == 56903 ) or ( v[6] == 56903 ) or ( v[5] == 56904 ) or ( v[6] == 56904 )
					or ( v[5] == 56905 ) or ( v[6] == 56905 ) or ( v[5] == 56906 ) or ( v[6] == 56906 ) then
					if C_QuestLog.IsQuestFlaggedCompleted( 56842 ) == true then
						if ( ShowConditionallyO( v[5], v[6] ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_crown],
								ns.db.icon_scale * ns.scaling[ns.db.icon_crown] * 0.75, ns.db.icon_alpha
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
				removeOneOff = {
					name = "Remove \"one time only\" and seasonal quests if completed by " ..ns.name,
					desc = "Primarily the Lunar Preservation quest for visiting moonwells\n"
							.."and the four \"Crown of...\" quests which follow on from that",
					type = "toggle",
					width = "full",
					arg = "removeOneOff",
					order = 5,
				},
				removeSeasonal = {
					name = "Remove Elder marker if completed this season by " ..ns.name,
					desc = "Achievement Elders are repeatable each season",
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					order = 6,
				},
				removeEver = {
					name = "Remove marker if ever completed on this account",
					desc = "If any of your characters has completed the achievement",
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
				icon_zoneElders = {
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
					arg = "icon_zoneElders",
					order = 8,
				},
				icon_dungeonElders = {
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
					arg = "icon_dungeonElders",
					order = 9,
				},
				icon_factionElders = {
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
					arg = "icon_factionElders",
					order = 9,
				},
				icon_preservation = {
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
					arg = "icon_preservation",
					order = 10,
				},
				icon_crown = {
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
					arg = "icon_crown",
					order = 11,
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
			elseif (version < 40000) and ( map.mapID < 1400 ) then
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
					
					if ( v[1] > 0 ) and ( v[2] > 0 ) then
						AddToContinent()
					elseif ( v[1] > 0 ) or ( v[5] > 0 ) then
						if ( ns.faction == "Alliance" ) then
							AddToContinent()
						end
					elseif ( v[2] > 0 ) or ( v[6] > 0 ) then
						if ( ns.faction == "Horde" ) then
							AddToContinent()
						end
					elseif ( v[3] > 0 ) or ( v[4] > 0 ) then
						AddToContinent()
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