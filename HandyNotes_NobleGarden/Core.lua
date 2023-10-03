--[[
                                ----o----(||)----oo----(||)----o----

                                             Noblegarden

                                     v2.08 - 18th September 2023
                                Copyright (C) Taraezor / Chris Birch

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

local defaults = { profile = { icon_scale = 1.7, icon_alpha = 1, showCoords = true,
								removeDailies = false, removeSeasonal = true, removeEver = false,
								showBCE = true,
								icon_hardBoiled = 16, icon_nobleGarden = 12, icon_springFling = 13,
								icon_desertRose = 11, icon_ngDailies = 15, icon_ngBCE = 14 } }
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

local _, _, _, version = GetBuildInfo()
ns.faction = UnitFactionGroup( "player" )
ns.classic = (version < 40000) and true or false
ns.azeroth = 947
ns.kalimdor = (version < 40000) and 1414 or 12
ns.easternKingdom = (version < 40000) and 1415 or 13
ns.unGoroCrater = (version < 40000) and 1449 or 78
ns.silithus = (version < 40000) and 1451 or 81
ns.tanaris = (version < 40000) and 1446 or 71
ns.badlands = (version < 40000) and 1418 or 15
ns.thousandNeedles = (version < 40000) and 1441 or 64
ns.desolace = (version < 40000) and 1443 or 66
ns.azuremystIsle = (version < 40000) and 1943 or 97
ns.elwynnForest = (version < 40000) and 1429 or 37
ns.teldrassil = (version < 40000) and 1438 or 57
ns.teldrassilOther = 1308
ns.dunMorogh = (version < 40000) and 1426 or 27
ns.mulgore = (version < 40000) and 1412 or 7
ns.eversongWoods = (version < 40000) and 1941 or 94
ns.tirisfalGlades = (version < 40000) and 1420 or 18
ns.durotar = (version < 40000) and 1411 or 1
ns.stormwindCity = (version < 40000) and 1453 or 84
ns.silvermoonCity = (version < 40000) and 1954 or 110
continents[ns.azeroth] = true
continents[ns.kalimdor] = true
continents[ns.easternKingdom] = true

ns.faction = UnitFactionGroup( "player" )
ns.name = UnitName( "player" ) or "Character"

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
	L["Noblegarden"] = "Nobelgarten Erfolge"
	L["hb1"] = "(1) Ändern Sie Ihr \"Zuhause\" in Marschalls Wehr\n(2) Holen Sie sich den "..
				"Nobelgartenhäschen-stärkungszauber\n(3) Herd ---> Marschalls Wehr"
	L["hb2"] = "(4) Lauf hierher\n(5) Hier stehen und warten\n(6) Nicht reiten\n(7) Nehmen sie keinen schaden"
	L["hb3"] = "(1) Ändern Sie Ihr \"Zuhause\" in Burg Cenarius\n(2) Holen Sie sich den "..
				"Nobelgartenhäschen-stärkungszauber\n(3) Herd ---> Burg Cenarius"
	L["Cenarion Hold"] = "Burg Cenarius"
	L["Marshall's Stand"] = "Marschalls Wehr"
	L["Golakka Hot Springs"] = "Die Heißen Quellen von Golakka"
	L["AnywhereZW"] = "Überall in der Zone.\nVerwende die \"Frühlingsrobe\".\n"
					.."(Nobelgartenverkäufer/Nobelgartenhändler - 50x Nobelgartenschokolade)"
	L["AnywhereZR"] = "Überall in der Zone.\nVerwende das Spielzeug \"Frühlingsfloristen\".\n"
					.."(Nobelgartenverkäufer/Nobelgartenhändler - 50x Nobelgartenschokolade)"
	L["AnywhereC"] = "Überall im Lager"
	L["AnywhereT"] = "Überall im Dorf"
	L["AnywhereS"] = "Überall auf dem Platz"
	L["AnywhereE"] = "Überall im Lage"
	L["hide"] = "(1) Kaufen Sie ein Nobelgartenei\n(2) Platziere es irgendwo in der Stadt"
	L["AddOn Description"] = "Hilfe für die Nobelgarten Erfolge"	
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
	L["Noblegarden"] = "Jardín Noble"
	L["hb1"] = "(1) Cambia tu \"hogar\" a Alto de Marshal\n(2) Consigue el mejora Conejito del Jardín "..
				"Noble\n(3) Hogar ---> Alto de Marshal"
	L["hb2"] = "(4) Corre hasta aqui\n(5) Quédate aquí y espera\n(6) No montar\n(7) No te dañes"
	L["hb3"] = "(1) Cambia tu \"hogar\" a Fuerte Cenarion\n(2) Consigue el mejora Conejito del Jardín "..
				"Noble\n(3) Hogar ---> Fuerte Cenarion"
	L["Cenarion Hold"] = "Fuerte Cenarion"
	L["Marshall's Stand"] = "Alto de Marshal"
	L["Golakka Hot Springs"] = "Baños de Golakka"
	L["AnywhereZW"] = "En cualquier lugar de la zona.\nUsa la \"Togas primaverales\".\n"
					.."(Vendedor/Mercader del Jardín Noble - 50x Chocolate del Jardín Noble)"
	L["AnywhereZR"] = "En cualquier lugar de la zona.\nUsa el juguete \"Faltriquera de florista primaveral\".\n"
					.."(Vendedor/Mercader del Jardín Noble - 50x Chocolate del Jardín Noble)"
	L["AnywhereC"] = "En cualquier lugar del campamento"
	L["AnywhereT"] = "En cualquier lugar del pueblo"
	L["AnywhereS"] = "En cualquier lugar de la plaza"
	L["AnywhereE"] = "En cualquier lugar del campamento"
	L["hide"] = "(1) Compra un Huevo del Jardín Noble\n(2) Colócalo en cualquier lugar de la ciudad"
	L["AddOn Description"] = "Ayuda para los logros del Jardín Noble"
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
	L["Noblegarden"] = "Jardin des nobles"
	L["hb1"] = "(1) Changez votre \"maison\" en Camp retranché des Marshal\n(2) Obtenez le buff "..
				"Lapin du Jardin des nobles\n(3) Foyer ---> Camp retranché des Marshal"
	L["hb2"] = "(4) Courez jusqu'ici\n(5) Tenez-vous ici et attendez\n(6) Ne roule "..
				"pas\n(7) Ne pas prendre de dégâts"
	L["hb3"] = "(1) Changez votre \"maison\" en Fort Cénarien\n(2) Obtenez le buff "..
				"Lapin du Jardin des nobles\n(3) Foyer ---> Fort Cénarien"
	L["Cenarion Hold"] = "Fort Cénarien"
	L["Marshall's Stand"] = "Camp retranché des Marshal"
	L["Golakka Hot Springs"] = "Sources de Golakka"
	L["AnywhereZW"] = "Partout dans la zone.\nUtilisez la \"Robe de printemps\".\n"
					.."(Vendeur/Marchand du Jardin des nobles - 50x Chocolat du Jardin des nobles)"
	L["AnywhereZR"] = "Partout dans la zone.\nUtilisez le jouet Bourse printanière de fleuriste.\n"
					.."(Vendeur/Marchand du Jardin des nobles - 50x Chocolat du Jardin des nobles)"
	L["AnywhereC"] = "Partout dans le camp"
	L["AnywhereT"] = "Partout dans la ville"
	L["AnywhereS"] = "Partout dans la Place"
	L["AnywhereE"] = "Partout dans le campement"
	L["hide"] = "(1) Acheter un Oeuf du Jardin des nobles\n(2) Placez-le n'importe où dans la ville"
	L["AddOn Description"] = "Aide pour les hauts faits du Jardin des nobles"
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
	L["Noblegarden"] = "Festa di Nobiluova"
	L["hb1"] = "(1) Cambia la tua \"casa\" in Accampamento dei Grant\n(2) Ottieni il beneficio "..
				"Noblegarden Bunny\n(3) Cuore ---> Accampamento dei Grant"
	L["hb2"] = "(4) Corri qui\n(5) Stai qui e aspetta\n(6) Non guidare\n(7) Non subire danni"
	L["hb3"] = "(1) Cambia la tua \"casa\" in Cenarion Hold\n(2) Ottieni il beneficio "..
				"Noblegarden Bunny\n(3) Cuore ---> Cenarion Hold"
	L["Cenarion Hold"] = "Fortezza Cenariana"
	L["Marshall's Stand"] = "Accampamento dei Grant"
	L["Golakka Hot Springs"] = "Sorgenti Calde di Golakka"
	L["AnywhereZW"] = "Ovunque nella zona.\nUsa le \"vesti primaverili\".\n"
					.."(Mercante di Nobiluova - 50x Cioccolatino di Nobiluova)"
	L["AnywhereZR"] = "Ovunque nella zona.\nUsa il giocattolo \"Borsa del Fiorista Primaverile\".\n"
					.."(Mercante di Nobiluova - 50x Cioccolatino di Nobiluova)"
	L["AnywhereC"] = "Ovunque nel campo"
	L["AnywhereT"] = "Ovunque nel villaggio"
	L["AnywhereS"] = "Ovunque in piazza"
	L["AnywhereE"] = "Ovunque nell'accampamento"
	L["hide"] = "(1) Acquista un Noblegarden Egg\n(2) Posizionalo ovunque in città"
	L["AddOn Description"] = "Aiuta con i risultati del Festa di Nobiluova"
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
	L["Noblegarden"] = "귀족의 정원"
	L["hb1"] = "(1) \"집\"을 마샬의 격전지로 변경\n(2) 귀족의 정원 토끼 버프 받기\n(3) 화덕 ---> 마샬의 격전지"
	L["hb2"] = "(4) 여기까지 달려\n(5) 여기 서서 기다려\n(6) 타지마\n(7) 피해를 입지 않는다"
	L["hb3"] = "(1) \"집\"을 세나리온 요새로 변경\n(2) 귀족의 정원 토끼 버프 받기\n(3) 화덕 ---> 세나리온 요새"
	L["Cenarion Hold"] = "세나리온 요새"
	L["Marshall's Stand"] = "마샬의 격전지"
	L["Golakka Hot Springs"] = "골락카 간헐천"
	L["AnywhereZW"] = "영역의 아무 곳이나.\n\"새봄맞이 로브\"를 사용하세요.\n"
					.."(귀족의 정원 상인/판매원 - 50x 귀족의 정원 초콜릿)"
	L["AnywhereZR"] = "영역의 아무 곳이나.\n\"봄꽃 상인의 주머니\" 장난감을 사용하세요.\n"
					.."(귀족의 정원 상인/판매원 - 50x 귀족의 정원 초콜릿)"
	L["AnywhereC"] = "캠프 어디에서나"
	L["AnywhereT"] = "마을 어디든"
	L["AnywhereS"] = "광장 어디에서나"
	L["AnywhereE"] = "야영지 어디든"
	L["hide"] = "(1) 귀족의 정원 알 구매\n(2) 도시 어디에서나 배치"
	L["AddOn Description"] = "귀족의 정원 업적들에 대한 도움말"	
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
	L["Noblegarden"] = "Jardinova"
	L["hb1"] = "(1) Altere sua \"casa\" para Posto Avançado do Marshal\n(2) Obtenha o bônus "..
				"Coelhinho de Jardinova\n(3) Lar ---> Posto Avançado do Marshal"
	L["hb2"] = "(4) Corre pra cá\n(5) Fique aqui e espere\n(6) Não monte\n(7) Não tome nenhum dano"
	L["hb3"] = "(1) Altere sua \"casa\" para Forte Cenariano\n(2) Obtenha o bônus "..
				"Coelhinho de Jardinova\n(3) Lar ---> Forte Cenariano"
	L["Cenarion Hold"] = "Forte Cenariano"
	L["Marshall's Stand"] = "Posto Avançado do Marshal"
	L["Golakka Hot Springs"] = "Fontes Termais Golakka"
	L["AnywhereZW"] = "Em qualquer lugar da zona.\nUse os \"Vestes Primaveris\".\n"
					.."(Comerciante/Mercador de Jardinova - 50x Chocolate de Jardinova)"
	L["AnywhereZR"] = "Em qualquer lugar da zona.\nUse o brinquedo \"Bolsa de Florista da Primavera\".\n"
					.."(Comerciante/Mercador de Jardinova - 50x Chocolate de Jardinova)"
	L["AnywhereC"] = "Em qualquer lugar do acampamento"
	L["AnywhereT"] = "Em qualquer lugar da vila"
	L["AnywhereS"] = "Em qualquer lugar da praça"
	L["AnywhereE"] = "Em qualquer lugar do acampamento"
	L["hide"] = "(1) Compre um Ovo de Jardinova\n(2) Coloque-o em qualquer lugar da cidade"
	L["AddOn Description"] = "Ajuda para as conquistas do Jardinova"
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
	L["Noblegarden"] = "Сад Чудес"
	L["hb1"] = "(1) Измените свой «дом» на Застава Маршалла\n(2) Получите aура Зайчик "..
				"Сада чудес\n(3) Очаг ---> Застава Маршалла"
	L["hb2"] = "(4) Беги сюда\n(5) Стой здесь и жди\n(6) Не ездить\n(7) Не получить урона"
	L["hb3"] = "(1) Измените свой «дом» на Крепости Кенария\n(2) Получите aура Зайчик "..
				"Сада чудес\n(3) Очаг ---> Крепости Кенария"
	L["Cenarion Hold"] = "Крепости Кенария"
	L["Marshall's Stand"] = "Застава Маршалла"
	L["Golakka Hot Springs"] = "Горячие источники Голакка"
	L["AnywhereZW"] = "Где угодно в зоне.\nИспользуйте \"Весеннее убранство\".\n"
					.."(Продавец/Торговец Сада чудес - 50x Праздничное шоколадное яйцо)"
	L["AnywhereZR"] = "Где угодно в зоне.\nИспользуйте игрушку \"Весенний мешочек садовода\".\n"
					.."(Продавец/Торговец Сада чудес - 50x Праздничное шоколадное яйцо)"
	L["AnywhereC"] = "Где угодно в лагере"
	L["AnywhereT"] = "Где угодно в деревне"
	L["AnywhereS"] = "Где угодно на площади"
	L["AnywhereE"] = "Где угодно в лагере"
	L["hide"] = "(1) Купить Праздничное яйцо\n(2) Разместите в любом месте города"
	L["AddOn Description"] = "Достижение Помощь для Сада Чудес"
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
	L["Noblegarden"] = "贵族的花园"
	L["hb1"] = "(1) 将您的“家”更改为 马绍尔哨站\n(2) 获得 复活节小兔 增益\n(3) 炉石 ---> 马绍尔哨站"
	L["hb2"] = "(4) 跑到这里\n(5) 站在这里等待\n(6) 不要骑\n(7) 不受伤害"
	L["hb3"] = "(1) 将您的“家”更改为 塞纳里奥要塞\n(2) 获得 复活节小兔 增益\n(3) 炉石 ---> 塞纳里奥要塞"
	L["Cenarion Hold"] = "塞纳里奥要塞"
	L["Marshall's Stand"] = "马绍尔哨站"
	L["Golakka Hot Springs"] = "葛拉卡温泉"
	L["AnywhereZW"] = "区域内的任何地方.\n使用 \"春季长袍\".\n"
					.."(复活节小贩/复活节商人 - 50x 复活节巧克力)"
	L["AnywhereZR"] = "区域内的任何地方.\n使用 \"春日花袋\" 玩具.\n"
					.."(复活节小贩/复活节商人 - 50x 复活节巧克力)"
	L["AnywhereC"] = "在营地的任何地方"
	L["AnywhereT"] = "村子里的任何地方"
	L["AnywhereS"] = "广场上的任何地方"
	L["AnywhereE"] = "在营地的任何地方"
	L["hide"] = "(1) 购买 复活节彩蛋\n(2) 把它放在城市的任何地方"
	L["AddOn Description"] = "贵族的花园成就帮助"
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
	L["Noblegarden"] = "貴族的花園"
	L["hb1"] = "(1) 將您的“家”更改為 馬紹爾哨站\n(2) 獲得 復活節小兔 增益\n(3) 爐石 ---> 馬紹爾哨站"
	L["hb2"] = "(4) 跑到這裡\n(5) 站在這裡等待\n(6) 不要騎\n(7) 不受傷害"
	L["hb3"] = "(1) 將您的“家”更改為 塞納里奧要塞\n(2) 獲得 復活節小兔 增益\n(3) 爐石 ---> 塞納里奧要塞"
	L["Cenarion Hold"] = "塞纳里奥要塞"
	L["Marshall's Stand"] = "馬紹爾哨站"
	L["Golakka Hot Springs"] = "葛拉卡溫泉"
	L["AnywhereZW"] = "區域內的任何地方.\n使用 \"春季長袍\".\n"
					.."(復活節小販/復活節商人 - 50x 復活節巧克力)"
	L["AnywhereZR"] = "區域內的任何地方.\n使用 \"春日花袋\" 玩具.\n"
					.."(復活節小販/復活節商人 - 50x 復活節巧克力)"
	L["AnywhereC"] = "在營地的任何地方"
	L["AnywhereT"] = "村子裡的任何地方"
	L["AnywhereS"] = "廣場上的任何地方"
	L["AnywhereE"] = "在營地的任何地方"
	L["hide"] = "(1) 購買 復活節彩蛋\n(2) 把它放在城市的任何地方"
	L["AddOn Description"] = "貴族的花園成就幫助"
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
	L["hb1"] = "(1) Change your \"home\" to Marshall's Stand\n(2) Get the Noblegarden Bunny "
				.."buff\n(3) Hearth ---> Marshall's Stand"
	L["hb2"] = "(4) Run to here\n(5) Stand here and wait\n(6) Do not ride\n(7) Take no damage"
	L["hb3"] = "(1) Change your \"home\" to Cenarion Hold\n(2) Get the Noblegarden Bunny "
				.."buff\n(3) Hearth ---> Cenarion Hold"
	L["AnywhereZW"] = "Anywhere in the zone.\nUse the \"Spring Robes\".\n"
					.."(Noblegarden Vendor/Merchant - 50x Noblegarden Chocolate)"
	L["AnywhereZR"] = "Anywhere in the zone.\nUse the \"Spring Florist's Pouch\" toy.\n"
					.."(Noblegarden Vendor/Merchant - 50x Noblegarden Chocolate)"
	L["AnywhereC"] = "Anywhere in the camp"
	L["AnywhereT"] = "Anywhere in the village"
	L["AnywhereS"] = "Anywhere in the square"
	L["AnywhereE"] = "Anywhere in the encampment"
	L["hide"] = "(1) Purchase a Noblegarden egg\n(2) Place it anywhere in the city"
	L["AddOn Description"] = "Help for the Noblegarden achievements"
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
	
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
	local pName = UnitName( "player" ) or L[ "Character" ]
	
	if pin.aID then
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( pin.aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight,
			( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..L[ "Account" ] ..")" ) 
								or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..L[ "Account" ] ..")" ) )
		if ( pin.aID == 2416 ) or ( pin.aID == 2420 ) or ( pin.aID == 2421 ) then
			if (version >= 40000) then
				completedMe = select( 3, GetAchievementCriteriaInfo( pin.aID, 1, true ) )
			end
		end
		GameTooltip:AddDoubleLine( " ",
			( completedMe == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..pName ..")" ) 
								or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..pName ..")" ) )
		if pin.aIndex then
			aName, _, completed = GetAchievementCriteriaInfo( pin.aID, pin.aIndex )
			GameTooltip:AddDoubleLine( ns.colour.highlight ..aName,
				( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..pName ..")" ) 
									or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..pName ..")" ) )
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
			( completed == true ) and ( "\124cFF00FF00" ..L[ "Completed" ] .." (" ..pName ..")" ) 
								or ( "\124cFFFF0000" ..L[ "Not Completed" ] .." (" ..pName ..")" ) )
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

local function ShowConditionallyE( aID )
	if ( ns.db.removeEver == true ) then
		local _, _, _, completed = GetAchievementInfo( aID )
		if ( completed == true ) then
			return false
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
				if ( pin.aID == 2436 ) then -- Desert Rose
					if ( ShowConditionallyE( pin.aID ) == true ) then
						if ( ShowConditionallyS( pin.aID, pin.aIndex ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_desertRose ],
									ns.db.icon_scale * ns.scaling[ ns.db.icon_desertRose ], ns.db.icon_alpha
						end
					end
				elseif ( pin.aID == 2419 ) then -- Spring Fling Alliance
					if ( ns.faction == "Alliance" ) then
						if ( ShowConditionallyE( pin.aID ) == true ) then
							if ( ShowConditionallyS( pin.aID, ( (ns.classic == true) and pin.aIndexC or pin.aIndexR ) ) == true ) then
								return coord, nil, ns.textures[ ns.db.icon_springFling ],
										ns.db.icon_scale * ns.scaling[ ns.db.icon_springFling ], ns.db.icon_alpha
							end
						end
					end
				elseif ( pin.aID == 2497 ) then -- Spring Fling Horde
					if ( ns.faction == "Horde" ) then
						if ( ShowConditionallyE( pin.aID ) == true ) then
							if ( ShowConditionallyS( pin.aID, ( (ns.classic == true) and pin.aIndexC or pin.aIndexR ) ) == true ) then
								return coord, nil, ns.textures[ ns.db.icon_springFling ],
										ns.db.icon_scale * ns.scaling[ ns.db.icon_springFling ], ns.db.icon_alpha
							end
						end
					end
				elseif ( pin.aID == 2420 ) or ( pin.aID == 2421 ) then -- Noblegarden
					if ( ns.faction == pin.faction ) then
						if ( ShowConditionallyE( pin.aID ) == true ) then
							if ( ShowConditionallyS( pin.aID ) == true ) then
								return coord, nil, ns.textures[ ns.db.icon_nobleGarden ],
										ns.db.icon_scale * ns.scaling[ ns.db.icon_nobleGarden ], ns.db.icon_alpha
							end
						end
					end
				elseif ( pin.aID == 2416 ) then -- Hard Boiled
					if ( ShowConditionallyE( pin.aID ) == true ) then
						if ( ShowConditionallyS( pin.aID ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_hardBoiled ],
									ns.db.icon_scale * ns.scaling[ ns.db.icon_hardBoiled ], ns.db.icon_alpha
						end
					end
				elseif pin.obj then -- Brightly Colored Eggs
					if ns.db.showBCE == true then
						if pin.author then
							if ns.author then
								return coord, nil, ns.textures[ ns.db.icon_ngBCE ],
										ns.db.icon_scale * ns.scaling[ ns.db.icon_ngBCE ] * 0.5, ns.db.icon_alpha
							end
						elseif pin.classic then
							if ( ns.classic == pin.classic ) then
								return coord, nil, ns.textures[ ns.db.icon_ngBCE ],
										ns.db.icon_scale * ns.scaling[ ns.db.icon_ngBCE ] * 0.5, ns.db.icon_alpha
							end
						else
							return coord, nil, ns.textures[ ns.db.icon_ngBCE ],
									ns.db.icon_scale * ns.scaling[ ns.db.icon_ngBCE ] * 0.5, ns.db.icon_alpha
						end
					end
				elseif pin.quest then -- Dailies with quests
					if ( pin.classic ~= nil ) then
						if ( ns.classic == pin.classic ) and ( ns.faction == pin.faction ) then
							if ( ShowConditionallyQ( pin.quest ) == true ) then
								return coord, nil, ns.textures[ ns.db.icon_ngDailies ],
										ns.db.icon_scale * ns.scaling[ ns.db.icon_ngDailies ], ns.db.icon_alpha
							end
						end
					elseif ( ns.faction == pin.faction ) then
						if ( ShowConditionallyQ( pin.quest ) == true ) then
							return coord, nil, ns.textures[ ns.db.icon_ngDailies ],
									ns.db.icon_scale * ns.scaling[ ns.db.icon_ngDailies ], ns.db.icon_alpha
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
				removeDailies = {
					name = "Remove the pin if already completed today by " ..ns.name,
					desc = "But this pin might be a useful reminder of the hub location",
					type = "toggle",
					width = "full",
					arg = "removeDailies",
					order = 5,
				},
				removeSeasonal = {
					name = "Remove the pin if completed this season by " ..ns.name,
					desc = "Achievements are usually repeatable each season.\n"
							.."This also applies to components within an achievement",
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					order = 6,
				},
				removeEver = {
					name = "Remove the pin if ever fully completed on this account",
					desc = "If any of your characters has completed the achievement",
					type = "toggle",
					width = "full",
					arg = "removeEver",
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
			name = L["Icon Selection"],
			inline = true,
			args = {
				icon_hardBoiled = {
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
					arg = "icon_hardBoiled",
					order = 9,
				},
				icon_nobleGarden = {
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
					arg = "icon_nobleGarden",
					order = 10,
				},
				icon_springFling = {
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
					arg = "icon_springFling",
					order = 11,
				},
				icon_desertRose = {
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
					arg = "icon_desertRose",
					order = 12,
				},
				icon_ngDailies = {
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
					arg = "icon_ngDailies",
					order = 13,
				},
				icon_ngBCE = {
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
					arg = "icon_ngBCE",
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
			elseif (version < 40000) and ( map.mapID < 1400 ) then
			elseif (version >= 40000) and ( map.mapID >= 1400 ) then
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