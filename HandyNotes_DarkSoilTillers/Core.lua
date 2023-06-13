--[[
                                ----o----(||)----oo----(||)----o----

                                          Dark Soil Tillers

                                       v3.12 - 11th June 2023
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

local defaults = { profile = { icon_scale = 1.4, icon_alpha = 0.8, icon_choice = 3, icon_tillersNPCs = 1, 
								icon_choiceBonus = 4, showCoords = true, icon_darkSoil = true,
								icon_tillersQuests = 1 } }
local continents = {}
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

ns.faction = UnitFactionGroup( "player" )
ns.aWitnessToHistory = ( ns.faction == "Alliance" ) and 31512 or ( ( ns.faction == "Horde" ) and 31511 or 0 )

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
	L["Dark Soil"] = "Dunkle Erde"
	L["Dark Soil Tillers"] = "Dunkle Erde Die Ackerbauern"
	L["The Tillers"] = "Die Ackerbauern"
	L["Under the foliage"] = "Unter dem Laub"
	L["Under the hut"] = "Unter der Hütte"
	L["Under the hut's\nnorthern side ramp"] = "Unter der Nordseite der Hütte"
	L["Under the trees.\nVery difficult to see"] = "Unter den Bäumen.\nSehr schwer zu sehen"
	L["Under the tree, at\nthe edge of the lake"] = "Unter dem Baum,\nam Rande des Sees"
	L["Under the water tower"] = "Unter dem Wasserturm"
	L["Under the tree.\nIn front of Thunder"] = "Unter dem Baum.\nVor Thunnnder"
	L["Under the bridge"] = "Unter der Brücke"
	L["Inside the building"] = "Im Gebäude"
	L["Descend into the Springtail Crag"] = "Steigen Sie in den Sprungschweifhöhlen geht"
	L["Descend into the Springtail Warren"] = "Steigen Sie in den Sprungschweifebau hinab"
	L["Standing under a tree"] = "Unter einem Baum stehen"
	L["Same colour as the ground"] = "Gleiche farbe wie der schmutz"
	L["At the entrance"] = "Am Eingang"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Der alte Hügelpranke"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Chi-Chi"
	L["Fish Fellreed"] = "Fischi Rohrroder"
	L["Haohan Mudclaw"] = "Haohan Lehmkrall"
	L["Tina Mudclaw"] = "Tina Lehmkrall"
	L["Farmer Fung"] = "Bauer Fung"
	L["Jogu the Drunk"] = "Jogu der Betrunkene"
	L["Gina Mudclaw"] = "Gina Lehmkrall"
	L["Crystal of Insanity"] = "Kristall des Wahnsinns"
	L["Blackhoof"] = "Schwarzhuf"
	L["Battle Horn"] = "Schlachthorn"
	L["Ghostly Pandaren Craftsman"] = "Geisterhafter Pandarenhandwerker"
	L["Cache of Pilfered Goods"] = "Truhe mit geklauten Waren"
	L["Forgotten Lockbox"] = "Vergessene Schließkassette"
	L["Show the Dark Soil"] = "Zeige den Dunklen Erde"
	L["AddOn Description"] = ns.colour.plaintext .."Hilft dir bei " ..ns.colour.highlight
		.."Dunkle Erde" ..ns.colour.plaintext .." und " ..ns.colour.highlight .."Die Ackerbauern"
		..ns.colour.plaintext .." im Tal der Vier Winde"
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
	L["Dark Soil"] = "Tierra Oscura"
	L["Dark Soil Tillers"] = "Los Labradores Tierra Oscura"
	L["The Tillers"] = "Los Labradores"
	L["Under the foliage"] = "Bajo el follaje"
	L["Under the hut"] = "Bajo la choza"
	L["Under the hut's\nnorthern side ramp"] = "Bajo la rampa del lado\nnorte de la choza"
	L["Under the trees.\nVery difficult to see"] = "Bajo los árboles.\nMuy difícil de ver"
	L["Under the tree, at\nthe edge of the lake"] = "Bajo el árbol,\nen el borde del lago"
	L["Under the water tower"] = "Bajo la torre de agua"
	L["Under the tree.\nIn front of Thunder"] = "Debajo del árbol. Delante de Trueno"
	L["Under the bridge"] = "Bajo el puente"
	L["Inside the building"] = "Dentro del edificio"
	L["Descend into the Springtail Crag"] = "Desciende a la madriguera de los Risco Cola Saltarina"
	L["Descend into the Springtail Warren"] = "Desciende a la madriguera de los Cola Saltarina"
	L["Standing under a tree"] = "De pie debajo de un árbol"
	L["Same colour as the ground"] = "Del mismo color que el suelo"
	L["At the entrance"] = "En la entrada"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Viejo Zarpa Collado"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Chee Chee"
	L["Fish Fellreed"] = "Pez Junco Talado"
	L["Haohan Mudclaw"] = "Haohan Zarpa Fangosa"
	L["Tina Mudclaw"] = "Tina Zarpa Fangosa"
	L["Farmer Fung"] = "Granjero Fung"
	L["Jogu the Drunk"] = "Jogu el Ebrio"
	L["Gina Mudclaw"] = "Gina Zarpa Fangosa"
	L["Crystal of Insanity"] = "Cristal de locura"
	L["Blackhoof"] = "Pezuña Negra"
	L["Battle Horn"] = "Cuerno de batalla"
	L["Ghostly Pandaren Craftsman"] = "Artesano pandaren fantasmal"
	L["Cache of Pilfered Goods"] = "Alijo de bienes trincados"
	L["Forgotten Lockbox"] = "Arcón Olvidado"
	L["Show the Dark Soil"] = "Mostrar la Tierra Oscura"
	L["AddOn Description"] = ns.colour.plaintext .."Te ayuda co " ..ns.colour.highlight
		.."Tierra Oscura" ..ns.colour.plaintext .." y " ..ns.colour.highlight .."Los Labradores"
		..ns.colour.plaintext .." en el Valle de los Cuatro Vientos"
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
	L["Dark Soil"] = "Terre Sombre"
	L["Dark Soil Tillers"] = "Laboureurs Terre Sombre"
	L["The Tillers"] = "Laboureurs"
	L["Under the foliage"] = "Sous le feuillage"
	L["Under the hut"] = "Sous la cabane"
	L["Under the hut's\nnorthern side ramp"] = "Sous la rampe côté\nnord de la cabane"
	L["Under the trees.\nVery difficult to see"] = "Sous les arbres.\nTrès difficile à voir"
	L["Under the tree, at\nthe edge of the lake"] = "Sous l'arbre,\nau bord du lac"
	L["Under the water tower"] = "Sous la tour d'eau"
	L["Under the tree.\nIn front of Thunder"] = "Sous l'arbre. Devant Tonnerre"
	L["Under the bridge"] = "Sous le pont"
	L["Inside the building"] = "À l'intérieur du bâtiment"
	L["Descend into the Springtail Crag"] = "Descendez dans la combe des Queubrioles"
	L["Descend into the Springtail Warren"] = "Descendez dans la garenne des queubriole"
	L["Standing under a tree"] = "Debout sous un arbre"
	L["Same colour as the ground"] = "De la même couleur que le sol"
	L["At the entrance"] = "À l'entrée"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Vieux Patte des Hauts"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Chii Chii"
	L["Fish Fellreed"] = "Marée Pelage de Roseau"
	L["Haohan Mudclaw"] = "Haohan Griffe de Tourbe"
	L["Tina Mudclaw"] = "Tina Griffe de Tourbe"
	L["Farmer Fung"] = "Fermier Fung"
	L["Jogu the Drunk"] = "Jogu l’Ivrogne"
	L["Gina Mudclaw"] = "Gina Griffe de Tourbe"
	L["Crystal of Insanity"] = "Cristal de démence"
	L["Blackhoof"] = "Sabot d’Encre"
	L["Battle Horn"] = "Cor de bataille"
	L["Ghostly Pandaren Craftsman"] = "Artisan pandaren fantomatique"
	L["Cache of Pilfered Goods"] = "Cache de fournitures chapardées"
	L["Forgotten Lockbox"] = "Coffret Oublié"
	L["Show the Dark Soil"] = "Montre la Terre Sombre"
	L["AddOn Description"] = ns.colour.plaintext .."Vous aide avec " ..ns.colour.highlight
		.."Terre Sombre" ..ns.colour.plaintext .." et " ..ns.colour.highlight .."Laboureurs"
		..ns.colour.plaintext .." dans la Vallée des Quatre vents"
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
	L["Dark Soil"] = "Terreno Smosso"
	L["Dark Soil Tillers"] = "Coltivatori Terreno Smosso"
	L["The Tillers"] = "Coltivatori"
	L["Under the foliage"] = "Sotto il fogliame"
	L["Under the hut"] = "Sotto la capanna"
	L["Under the hut's\nnorthern side ramp"] = "Sotto la rampa laterale nord della capanna"
	L["Under the trees.\nVery difficult to see"] = "Sotto gli alberi.\nMolto difficile da vedere"
	L["Under the tree, at\nthe edge of the lake"] = "Sotto l'albero,\nai margini del lago"
	L["Under the water tower"] = "Sotto la torre dell'acqua"
	L["Under the tree.\nIn front of Thunder"] = "Sotto l'albero.\nDi fronte a Tuono"
	L["Under the bridge"] = "Sotto il ponte"
	L["Inside the building"] = "All'interno dell'edificio"
	L["Inside the building"] = "À l'intérieur du bâtiment"
	L["Descend into the Springtail Crag"] = "Scendi nella Rupe dei Codalesta"
	L["Descend into the Springtail Warren"] = "Scendi nella Tana del Codalesta"
	L["Standing under a tree"] = "In piedi sotto un albero"
	L["Same colour as the ground"] = "Lo stesso colore del terreno"
	L["At the entrance"] = "All'entrata"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Vecchio Zampa Brulla"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Ghi Ghi"
	L["Fish Fellreed"] = "Trota Mezza Canna"
	L["Haohan Mudclaw"] = "Haohan Palmo Florido"
	L["Tina Mudclaw"] = "Tina Palmo Florido"
	L["Farmer Fung"] = "Contadino Fung"
	L["Jogu the Drunk"] = "Jogu l'Ubriaco"
	L["Gina Mudclaw"] = "Gina Palmo Florido"
	L["Crystal of Insanity"] = "Cristallo della Pazzia"
	L["Blackhoof"] = "Zoccolo Nero"
	L["Battle Horn"] = "Corno da Battaglia"
	L["Ghostly Pandaren Craftsman"] = "Artigiano Spettrale Pandaren"
	L["Cache of Pilfered Goods"] = "Cassa di Beni Rubati"
	L["Forgotten Lockbox"] = "Scrigno Dimenticato"
	L["Show the Dark Soil"] = "Mostra la Terreno Smosso"
	L["AddOn Description"] = ns.colour.plaintext .."Ti aiuta con " ..ns.colour.highlight .."Terra Oscura"
			..ns.colour.plaintext .." e " ..ns.colour.highlight .."Coltivatori" ..ns.colour.plaintext
			.." in the Valle dei Quattro Venti"
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
	L["Dark Soil"] = "검은 토양"
	L["Dark Soil Tillers"] = "농사꾼 연합 검은 토양"
	L["The Tillers"] = "농사꾼 연합"
	L["Under the foliage"] = "단풍 아래서"
	L["Under the hut"] = "오두막 아래서"
	L["Under the hut's\nnorthern side ramp"] = "오두막의 북쪽 경사로 아래"
	L["Under the trees.\nVery difficult to see"] = "나무 밑. 보기가 매우 어렵다."
	L["Under the tree, at\nthe edge of the lake"] = "나무 밑. 호수 가장자리."
	L["Under the water tower"] = "수상 탑 아래"
	L["Under the tree.\nIn front of Thunder"] = "나무 아래. 우레 앞에서."
	L["Under the bridge"] = "다리 아래"
	L["Inside the building"] = "건물 내부"
	L["Descend into the Springtail Crag"] = "있는 껑충꼬리 바위굴 처로 내려가세요"
	L["Descend into the Springtail Warren"] = "껑충꼬리 은신처로 내려가세요"
	L["Standing under a tree"] = "나무 아래 서"
	L["Same colour as the ground"] = "땅과 같은 색"
	L["At the entrance"] = "입구에서"
	L["Sho"] = "쇼"
	L["Old Hillpaw"] = "늙은 힐포우"
	L["Ella"] = "엘라"
	L["Chee Chee"] = "치 치"
	L["Fish Fellreed"] = "피시 펠리드"
	L["Haohan Mudclaw"] = "하오한 머드클로"
	L["Tina Mudclaw"] = "티나 머드클로"
	L["Farmer Fung"] = "농부 펑"
	L["Jogu the Drunk"] = "주정뱅이 조구"
	L["Gina Mudclaw"] = "지나 머드클로"
	L["Sulik'shor"] = "술리크쇼르"
	L["Crystal of Insanity"] = "광기의 수정"
	L["Blackhoof"] = "블랙후프"
	L["Battle Horn"] = "전투 뿔피리"
	L["Ghostly Pandaren Craftsman"] = "유령 판다렌 장인"
	L["Cache of Pilfered Goods"] = "도둑맞은 물품이 든 상자"
	L["Forgotten Lockbox"] = "잊혀진 금고"
	L["Show the Dark Soil"] = "검은 토양 보여줘"
	L["AddOn Description"] = ns.colour.plaintext .."네 바람의 계곡에서 " ..ns.colour.highlight .."농사꾼 연합"
		..ns.colour.plaintext .." 및 " ..ns.colour.highlight .."검은 토양" ..ns.colour.plaintext
		.." 에 대한 도움말"
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
	L["Dark Soil"] = "Solo Negro"
	L["Dark Soil Tillers"] = "Os Lavradores Solo Negro"
	L["The Tillers"] = "Os Lavradores"
	L["Under the foliage"] = "Sob a folhagem"
	L["Under the hut"] = "Debaixo da cabana"
	L["Under the hut's\nnorthern side ramp"] = "Sob a rampa do lado norte da cabana"
	L["Under the trees.\nVery difficult to see"] = "Sob as árvores.\nMuito difícil de ver"
	L["Under the tree, at\nthe edge of the lake"] = "Debaixo da árvore,\nà beira do lago"
	L["Under the water tower"] = "Sob a torre de água"
	L["Under the tree.\nIn front of Thunder"] = "Debaixo da árvore. Na frente de Trovão"
	L["Under the bridge"] = "Debaixo da ponte"
	L["Inside the building"] = "Dentro do prédio"
	L["Descend into the Springtail Crag"] = "Desça para o Rochedo Cauda-de-mola"
	L["Descend into the Springtail Warren"] = "Desça para o Labirinto Cauda-de-mola"
	L["Standing under a tree"] = "De pé debaixo de uma árvore"
	L["Same colour as the ground"] = "Da mesma cor do chão"
	L["At the entrance"] = "Na entrada"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Velho Pata do Monte"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Tchi Tchi"
	L["Fish Fellreed"] = "Peixe Cana Alta"
	L["Haohan Mudclaw"] = "Haohan Garra de Barro"
	L["Tina Mudclaw"] = "Tina Garra de Barro"
	L["Farmer Fung"] = "Fazendeiro Fung"
	L["Jogu the Drunk"] = "Be Bum, o Ébrio"
	L["Gina Mudclaw"] = "Gina Garra de Barro"
	L["Crystal of Insanity"] = "Cristal da Insanidades"
	L["Blackhoof"] = "Casco Negro"
	L["Battle Horn"] = "Trombeta de Batalha"
	L["Ghostly Pandaren Craftsman"] = "Artesão Pandaren Fantasmagórico"
	L["Cache of Pilfered Goods"] = "Baú de Mercadorias Pilhadas"
	L["Forgotten Lockbox"] = "Cofre Esquecido"
	L["Show the Dark Soil"] = "Mostrar o Solo Negro"
	L["AddOn Description"] = ns.colour.plaintext .."Ajuda você com " ..ns.colour.highlight
		.."Solo Escuro" ..ns.colour.plaintext .." e " ..ns.colour.highlight .."Os Lavradores"
		..ns.colour.plaintext .." no Vale dos Quatro Ventos"
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
	L["Dark Soil"] = "Темная Земля"
	L["Dark Soil Tillers"] = "Земледельцами Темная Земля"
	L["The Tillers"] = "Земледельцами"
	L["Under the foliage"] = "Под листвой"
	L["Under the hut"] = "Под хижиной"
	L["Under the hut's\nnorthern side ramp"] = "Под пандусом северной стороны хижины"
	L["Under the trees.\nVery difficult to see"] = "Под деревьями.\nОчень сложно увидеть"
	L["Under the tree, at\nthe edge of the lake"] = "Под деревом,\nна краю озера"
	L["Under the water tower"] = "Под водонапорной башней"
	L["Under the tree.\nIn front of Thunder"] = "Под деревом.\nПеред Гром"
	L["Under the bridge"] = "Под мостом"
	L["Inside the building"] = "Внутри здания"
	L["Descend into the Springtail Crag"] = "Спускайтесь в Утес Прыгохвостов"
	L["Descend into the Springtail Warren"] = "Спускайтесь в лабиринт Прыгохвост"
	L["Standing under a tree"] = "Стоя под деревом"
	L["Same colour as the ground"] = "Тот же цвет, что и земля"
	L["At the entrance"] = "На входе"
	L["Sho"] = "Шо"
	L["Old Hillpaw"] = "Старик Горная Лапа"
	L["Ella"] = "Элла"
	L["Chee Chee"] = "Чи-Чи"
	L["Fish Fellreed"] = "Рыба Тростниковая Шкура"
	L["Haohan Mudclaw"] = "Хаохань Грязный Коготь"
	L["Tina Mudclaw"] = "Тина Грязный Коготь"
	L["Farmer Fung"] = "Фермер Фун"
	L["Jogu the Drunk"] = "Йогу Пьяный"
	L["Gina Mudclaw"] = "Джина Грязный Коготь"
	L["Sulik'shor"] = "Сулик'шор"
	L["Crystal of Insanity"] = "Кристалл безумия"
	L["Blackhoof"] = "Черное Копыто"
	L["Battle Horn"] = "Боевой рог"
	L["Ghostly Pandaren Craftsman"] = "Призрачный пандарен-ремесленник"
	L["Cache of Pilfered Goods"] = "Груда украденных товаров"
	L["Forgotten Lockbox"] = "Позабытый ларец"
	L["Show the Dark Soil"] = "Показать Темная Земля"
	L["AddOn Description"] = ns.colour.plaintext .."Помогает вам с " ..ns.colour.highlight
		.."Темная Земля" ..ns.colour.plaintext .." и " ..ns.colour.highlight .."Земледельцами"
		..ns.colour.plaintext .." в Долине Четырех Ветров"
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
	L["Dark Soil"] = "黑色泥土"
	L["Dark Soil Tillers"] = "阡陌客 黑色泥土"
	L["The Tillers"] = "阡陌客"
	L["Under the foliage"] = "在树叶下"
	L["Under the hut"] = "在小屋下面"
	L["Under the hut's\nnorthern side ramp"] = "在小屋的北侧坡道下"
	L["Under the trees.\nVery difficult to see"] = "在树下。很难看"
	L["Under the tree, at\nthe edge of the lake"] = "在树下，在湖边"
	L["Under the water tower"] = "在水塔下"
	L["Under the tree.\nIn front of Thunder"] = "在树下。在雷霆前面"
	L["Under the bridge"] = "在桥下"
	L["Inside the building"] = "建筑物内"
	L["Descend into the Springtail Crag"] = "下降到的弹尾峭壁巢穴" -- 弹尾峭壁
	L["Descend into the Springtail Warren"] = "下降到弹尾者巢穴"
	L["Standing under a tree"] = "站在树下"
	L["Same colour as the ground"] = "与地面颜色相同"
	L["At the entrance"] = "在入口"
	L["Sho"] = "阿烁"
	L["Old Hillpaw"] = "老农山掌"
	L["Ella"] = "艾拉"
	L["Chee Chee"] = "吱吱"
	L["Fish Fellreed"] = "玉儿·采苇"
	L["Haohan Mudclaw"] = "郝瀚·泥爪"
	L["Tina Mudclaw"] = "迪娜·泥爪"
	L["Farmer Fung"] = "农夫老方"
	L["Jogu the Drunk"] = "醉鬼贾古"
	L["Gina Mudclaw"] = "吉娜·泥爪"
	L["Sulik'shor"] = "苏里克夏"
	L["Crystal of Insanity"] = "狂乱水晶"
	L["Blackhoof"] = "黑蹄"
	L["Battle Horn"] = "战斗号角"
	L["Ghostly Pandaren Craftsman"] = "幽灵熊猫人工匠"
	L["Cache of Pilfered Goods"] = "箱被偷的货物"
	L["Forgotten Lockbox"] = "被遗忘的锁箱"
	L["Show the Dark Soil"] = "显示黑色泥土"
	L["AddOn Description"] = ns.colour.plaintext .."四风谷的" ..ns.colour.highlight .."分蘖"
		..ns.colour.plaintext .."和" ..ns.colour.highlight .."黑土"
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
	L["Dark Soil"] = "黑色泥土"
	L["Dark Soil Tillers"] = "阡陌客 黑色泥土"
	L["The Tillers"] = "阡陌客"
	L["Under the foliage"] = "在樹葉下"
	L["Under the hut"] = "在小屋下面"
	L["Under the hut's\nnorthern side ramp"] = "在小屋的北側坡道下"
	L["Under the trees.\nVery difficult to see"] = "在樹下。很難看"
	L["Under the tree, at\nthe edge of the lake"] = "在樹下。在湖邊"
	L["Under the water tower"] = "在水塔下"
	L["Under the tree.\nIn front of Thunder"] = "在樹下。在雷霆前面"
	L["Under the bridge"] = "在橋下"
	L["Inside the building"] = "建築物內"
	L["Descend into the Springtail Crag"] = "下降到的彈尾峭壁巢穴"
	L["Descend into the Springtail Warren"] = "下降到彈尾者巢穴"
	L["Standing under a tree"] = "站在樹下"
	L["Same colour as the ground"] = "與地面顏色相同"
	L["At the entrance"] = "在入口"
	L["Sho"] = "阿爍"
	L["Old Hillpaw"] = "老農山掌"
	L["Ella"] = "艾拉"
	L["Chee Chee"] = "吱吱"
	L["Fish Fellreed"] = "玉儿·採葦"
	L["Haohan Mudclaw"] = "郝瀚·泥爪"
	L["Tina Mudclaw"] = "迪娜·泥爪"
	L["Farmer Fung"] = "農夫老方"
	L["Jogu the Drunk"] = "醉鬼賈古"
	L["Gina Mudclaw"] = "吉娜·泥爪"
	L["Sulik'shor"] = "蘇里克夏"
	L["Crystal of Insanity"] = "狂亂水晶"
	L["Blackhoof"] = "黑蹄"
	L["Battle Horn"] = "戰鬥號角"
	L["Ghostly Pandaren Craftsman"] = "幽靈熊貓人工匠"
	L["Cache of Pilfered Goods"] = "箱被偷的貨物"
	L["Forgotten Lockbox"] = "被遺忘的鎖箱"
	L["Show the Dark Soil"] = "顯示黑色泥土"
	L["AddOn Description"] = ns.colour.plaintext .."幫助四風谷的" ..ns.colour.highlight .."分蘗"
		..ns.colour.plaintext .."和" ..ns.colour.highlight .."黑土"
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
	L["AddOn Description"] = ns.colour.plaintext .."Helps you with the " ..ns.colour.highlight 
			.."Dark Soil" ..ns.colour.plaintext .." and " ..ns.colour.highlight .."The Tillers"
			..ns.colour.plaintext .." in the Valley of the Four Winds"
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
	elseif ( pin.pinType == "B" ) then
		if pin.title then
			GameTooltip:SetText( ns.colour.prefix ..L[ pin.title ] )
			if pin.item then
				GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.item ] )
			end
		else
			local itemName = GetItemNameByID( pin.item ) or "Staff of the Hidden Master"
			GameTooltip:SetText( ns.colour.prefix ..L[ itemName ] )
		end
		if pin.quest then
			completed = IsQuestFlaggedCompleted( pin.quest )
			if ( completed == true ) then
				GameTooltip:AddLine( ns.colour.highlight
						.."\nYou won't see this as you've already\n"
						.."clicked on it. It is a one-time reward." )
			else
				GameTooltip:AddLine( ns.colour.highlight
						.."\nYou may click on this one time only.\n"
						.."You have not yet collected this reward." )
				if ( pin.quest==31406 ) or ( pin.quest==31867 ) then
				elseif ( pin.quest==31407 ) then -- "Staff of the Hidden Master"
					GameTooltip:AddLine( ns.colour.highlight
						.."It will spawn from time to time." )
				else
					GameTooltip:AddLine( ns.colour.highlight
						.."The NPC spawns from time to time." )
				end
			end
			if pin.tip then
				GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
			end
		end
	elseif ( pin.pinType == "P" ) then
		if pin.title then
			GameTooltip:SetText( ns.colour.prefix ..L[ pin.title ] )
		end
		if pin.tip then
			GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
		end
		showCoordinates = false
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
	else
		GameTooltip:SetText( ns.colour.prefix ..L[ "Dark Soil" ] )
		if pin.tip then
			GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip ] )
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
	continents[ns.pandaria] = true
	local function iterator(t, prev)
		if not t or ns.CurrentMap == ns.pandaria then return end
		local coord, pin = next(t, prev)
		local aId, completed, iconIndex, quest, found;
		while coord do
			if pin then
				if ( pin.pinType == "N" ) then
					return coord, nil, ns.texturesSpecial[ns.db.icon_tillersNPCs],
							ns.db.icon_scale * ns.scalingSpecial[ns.db.icon_tillersNPCs], ns.db.icon_alpha
				elseif ( pin.pinType == "O" ) then
					local completed = IsQuestFlaggedCompleted( 30252 )
					if ( completed == true ) then
						completed = IsQuestFlaggedCompleted( 30257 )
						if ( completed == true ) then
							if ( pin.quest == 31945 ) then
								completed = IsQuestFlaggedCompleted( 31945 )
								if ( pin.title == "Gina's Vote Quest" ) then
									if ( completed == false ) then
										return coord, nil, ns.textures[ns.db.icon_tillersQuests],
											ns.db.icon_scale * ns.scaling[ns.db.icon_tillersQuests], ns.db.icon_alpha
									end
								else
									return coord, nil, ns.textures[ns.db.icon_tillersQuests],
										ns.db.icon_scale * ns.scaling[ns.db.icon_tillersQuests], ns.db.icon_alpha
								end
							elseif ( pin.quest == 30526 ) then
								completed = IsQuestFlaggedCompleted( 30526 )
								if ( completed == false ) then
									if coord == 42395000 then
										return coord, nil, ns.textures[ns.db.icon_tillersQuests],
											ns.db.icon_scale * ns.scaling[ns.db.icon_tillersQuests], ns.db.icon_alpha
									end
								elseif coord == 52254894 then
									return coord, nil, ns.textures[ns.db.icon_tillersQuests],
										ns.db.icon_scale * ns.scaling[ns.db.icon_tillersQuests], ns.db.icon_alpha
								end
							end	
						elseif ( pin.quest == 30257 ) then
							return coord, nil, ns.textures[ns.db.icon_tillersQuests],
								ns.db.icon_scale * ns.scaling[ns.db.icon_tillersQuests], ns.db.icon_alpha
						end					
					elseif ( pin.quest == 30252 ) then
						return coord, nil, ns.textures[ns.db.icon_tillersQuests],
							ns.db.icon_scale * ns.scaling[ns.db.icon_tillersQuests], ns.db.icon_alpha
					end
				elseif ( pin.pinType == "B" ) then
					if pin.quest then
						if IsQuestFlaggedCompleted( pin.quest ) == true then
							-- don't bother showing
						elseif ( pin.quest == 31867 ) or ( pin.quest == 31869 ) then
							if not _G["HandyNotes_APathLessTravelledDB"] then
								return coord, nil, ns.texturesSpecial[ns.db.icon_choiceBonus],
									ns.db.icon_scale * ns.scaling[ns.db.icon_choiceBonus], ns.db.icon_alpha
							end
						elseif ( pin.quest == 31292 ) or ( pin.quest == 31406 ) or ( pin.quest == 31407 )
									or ( pin.quest == 31284) then
							if not _G["HandyNotes_EAPandariaDB"] then
								return coord, nil, ns.texturesSpecial[ns.db.icon_choiceBonus],
									ns.db.icon_scale * ns.scaling[ns.db.icon_choiceBonus], ns.db.icon_alpha
							end
						end
					elseif not _G["HandyNotes_EAPandariaDB"] then
						return coord, nil, ns.texturesSpecial[ns.db.icon_choiceBonus],
							ns.db.icon_scale * ns.scaling[ns.db.icon_choiceBonus], ns.db.icon_alpha
					end
				elseif ( pin.pinType == "P" ) then
					if pin.quest then
						if IsQuestFlaggedCompleted( pin.quest ) == false then
							-- Pre-requisite satisfied so don't show the warning message
						else
							return coord, nil, ns.textures[ns.db.icon_choice],
									ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
						end
					end
				elseif ( ( pin.pinType == "KS" ) or ( pin.pinType == "KW" ) or ( pin.pinType == "TJF" )
							or ( pin.pinType == "TS" ) or ( pin.pinType == "VEB" ) or ( pin.pinType == "VFW" ) ) 
						and ( ns.db.icon_darkSoil == true ) then
					if pin.authorOnly then
						if ns.author then
							return coord, nil, ns.textures[10],
								ns.db.icon_scale * ns.scaling[10], ns.db.icon_alpha
						end
					elseif pin.author and ns.author then
						return coord, nil, ns.textures[10],
								ns.db.icon_scale * ns.scaling[10], ns.db.icon_alpha
					else
						return coord, nil, ns.textures[ns.db.icon_choice],
								ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
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
				icon_darkSoil = {
					name = L["Dark Soil"],
					desc = L["Show the Dark Soil"],
					type = "toggle",
					width = "full",
					arg = "icon_darkSoil",
					order = 5,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Icon Selection"],
			inline = true,
			args = {
				icon_choice = {				-- D/V/K
					type = "range",
					name = L["Dark Soil"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"],
					min = 1, max = 10, step = 1,
					arg = "icon_choice",
					order = 6,
				},
				icon_tillersQuests = {		-- O
					type = "range",
					name = L["NPC"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"],
					min = 1, max = 10, step = 1,
					arg = "icon_tillersQuests",
					order = 7,
				},
				icon_tillersNPCs = {		-- N
					type = "range",
					name = L["The Tillers"],
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = " 
							..L["Cogwheel"],
					min = 1, max = 8, step = 1,
					arg = "icon_tillersNPCs",
					order = 8,
				},
				icon_choiceBonus = {		-- B
					type = "range",
					name = L["Blackhoof"] .."++",
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = " 
							..L["Cogwheel"],
					min = 1, max = 8, step = 1,
					arg = "icon_choiceBonus",
					order = 9,
				},
			},
		},
	},
}

function HandyNotes_DarkSoilTillers_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "DarkSoilTillers" )
 end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return 
	end
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
	HandyNotes:RegisterPluginDB("DarkSoilTillers", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_DarkSoilDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "DarkSoilTillers")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_DarkSoilDB", "AceEvent-3.0")