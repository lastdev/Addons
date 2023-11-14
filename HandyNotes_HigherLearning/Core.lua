--[[
                                ----o----(||)----oo----(||)----o----

                                           Higher Learning

                                      v1.28 - 8th November 2023
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...
ns.db = {}
-- From Data.lua
ns.points, ns.textures, ns.scaling = {}, {}, {}, {}
-- Purple theme
ns.colour = {}
ns.colour.prefix	= "\124cFF8258FA"
ns.colour.highlight = "\124cFFB19EFF"
ns.colour.plaintext = "\124cFF819FF7"

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								iconChoice = 11 } }
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local UnitName = UnitName
local format, next, select = format, next, select

local HandyNotes = _G.HandyNotes

ns.classic = (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE)

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
	L["AddOn Description"] = "Helfen Sie, die Bücher zu finden"
	L["Dalaran Map"] = "Zeigt die Karte von Dalaran"
	L["Higher Learning"] = "Höheres Studium"
	L["Divination"] = "Weissagung"
	L["divTip"] = "Nach oben schauen Sie nach links.\nDas Buch liegt auf dem Boden zwischen\n"
		.."den beiden Bücherregalen"
	L["Conjuration"] = "Beschwörung"
	L["conjTip"] = 
		"Beim Betreten auf der rechten Seite des Raumes.\nStellen Sie sich vor die Bücherregale. "..
		"Das Buch\nbefindet sich im leeren Regal des linken Bücherregals"
	L["Enchantment"] = "Verzauberung"
	L["enchTip"] = "Auf dem Balkon. Auf einer Kiste\nmit nichts drauf. Neben einer\ngrößeren Kiste"
	L["Necromancy"] = "Nekromantie"
	L["necroTip"] = "Oben im Zimmer mit vier\nkleinen Betten. Auf dem\nleeren Bücherregal"
	L["Transmutation"] = "Transmutation"
	L["transTip"] =
		"Unten. Schauen Sie sich das\nBücherregal an. Das Buch befindet\nsich im leeren Bücherregal"
	L["Abjuration"] = "Bannung"
	L["abjTip"] =
		"Unten. Auf der rechten Seite.\nAuf dem Boden neben einem\nHocker mit Büchern"
	L["Introduction"] = "Einleitung"
	L["intTip"] = "Auf dem Boden an der Unterseite\ndes Bücherregals auf der rechten\nSeite des Zimmers"
	L["Illusion"] = "Illusion"
	L["illTip"] = "Auf einer Kiste mit\nnichts drauf. In der Ecke"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["AddOn Description"] = "Ayudarle a encontrar los libros"
	L["Dalaran Map"] = "Mostrar el mapa de Dalaran"
	L["Higher Learning"] = "Conocimiento Superior"
	L["Divination"] = "Adivinación"
	L["divTip"] = "En la parte superior de las escaleras,\nmira a la izquierda. El libro está en\n"
		.."el suelo entre las dos estanterías"
	L["Conjuration"] = "Conjuración"
	L["conjTip"] = 
		"En el lado derecho de la habitación al entrar.\nPárese frente a las estanterías. "..
		"El libro está en\nel espacio vacío en el estante inferior de\nla estantería de mano izquierda"
	L["Enchantment"] = "Encantamiento"
	L["enchTip"] = "En el balcón. En una caja\ncon nada sobre ella. Junto\na un cajón más grande"
	L["Necromancy"] = "Nigromancia"
	L["necroTip"] = "Arriba, en la habitación\ncon cuatro camas pequeñas.\nEn la estanteria vacia"
	L["Transmutation"] = "Transmutación"
	L["transTip"] = "Abajo. Mira el par de estanterías.\nEl libro estará en la estantería vacía"
	L["Abjuration"] = "Abjuración"
	L["abjTip"] = "Abajo. En el lado derecho.\nEn el suelo, junto a un taburete\ncon libros encima"
	L["Introduction"] = "Introducción"
	L["intTip"] = "En el piso en la base\nde la estantería en el lado\nderecho de la habitación"
	L["Illusion"] = "Ilusión"
	L["illTip"] = "En una caja con nada\nsobre ella. En la esquina"

elseif ns.locale == "frFR" then
	L["AddOn Description"] = "Vous aider à trouver les livres"
	L["Dalaran Map"] = "Afficher la carte de Dalaran"
	L["Higher Learning"] = "Lectures Studieuses"
	L["Divination"] = "Divination"
	L["divTip"] = "En haut des escaliers, regardez à gauche.\n"
		.."Le livre est par terre entre les deux étagères"
	L["Conjuration"] = "Invocation"
	L["conjTip"] = 
		"À droite de la pièce lorsque vous entrez.\nTenez-vous devant les étagères. Le livre\n"
		.."se trouve dans l'espace vide sur la tablette\ninférieure de la bibliothèque de gauche"
	L["Enchantment"] = "Enchantement"
	L["enchTip"] = "Sur le balcon. Sur une caisse\nsans rien dessus. À côté\nd'une caisse plus grande"
	L["Necromancy"] = "Nécromancie"
	L["necroTip"] = "A l'étage, dans la chambre\navec quatre petits lits.\nSur l'étagère vide"
	L["Transmutation"] = "Transmutation"
	L["transTip"] = "En bas. Regardez la paire\nd'étagères. Le livre sera\ndans l'étagère vide"
	L["Abjuration"] = "Abjuration"
	L["abjTip"] = "En bas. Sur le côté droit.\nSur le sol à côté d'un tabouret\navec des livres dessus"
	L["Introduction"] = "Introduction"
	L["intTip"] = "Sur le sol à la base\nde la bibliothèque à\ndroite de la pièce"
	L["Illusion"] = "Illusion"
	L["illTip"] = "Sur une caisse sans\nrien dessus. Au coin"

elseif ns.locale == "itIT" then
	L["AddOn Description"] = "Aiutarti a trovare i libri"
	L["Dalaran Map"] = "Mostra la mappa di Dalaran"
	L["Higher Learning"] = "Conoscenza Superiore"
	L["Divination"] = "Divinazione"
	L["divTip"] = "In cima alle scale, guarda a sinistra.\nIl libro è sul pavimento tra i due scaffali"
	L["Conjuration"] = "Evocazione"
	L["conjTip"] = 
		"Sul lato destro della stanza mentre entri.\nStare di fronte agli scaffali. "
		.."Il libro\nènello spazio vuoto sul ripiano inferiore\ndella libreria a sinistra"
	L["Enchantment"] = "Incantamento"
	L["enchTip"] = "Sul balcone. Su una cassa\nsenza niente sopra. Accanto\na una cassa più grande"
	L["Necromancy"] = "Negromanzia"
	L["necroTip"] = "Al piano superiore, nella stanza\ncon quattro piccoli letti.\nSullo scaffale vuoto"
	L["Transmutation"] = "Trasmutazione"
	L["transTip"] = "Piano di sotto. Guarda\nla coppia di scaffali.\nIl libro sarà nella libreria vuota"
	L["Abjuration"] = "Abiurazione"
	L["abjTip"] = "Piano di sotto. Dal lato giusto.\nSul pavimento accanto a uno\nsgabello con sopra dei libri"
	L["Introduction"] = "Introduzione"
	L["intTip"] = "Sul pavimento alla base\ndella libreria sul lato\ndestro della stanza"
	L["Illusion"] = "Illusione"
	L["illTip"] = "Su una cassa senza\nniente sopra. All'angolo"

elseif ns.locale == "koKR" then
	L["AddOn Description"] = "책 찾기"
	L["Dalaran Map"] = "달라란 지도를 보여주세요"
	L["Higher Learning"] = "고등 학습"
	L["Divination"] = "예지"
	L["divTip"] = "계단 꼭대기에서 왼쪽을보세요.\n이 책은 두 책꽂이 사이의 바닥에 있습니다."
	L["Conjuration"] = "창조술"
	L["conjTip"] = "들어갈 때 방의 오른쪽에. 책꽂이 앞에 서십시오.\n책은 왼쪽 책장의 맨 아래 선반에있는 빈 공간에 있습니다."
	L["Enchantment"] = "마력"
	L["enchTip"] = "발코니에서. 그 위에 아무 것도없는 상자에.\n큰 상자 옆"
	L["Necromancy"] = "강령술"
	L["necroTip"] = "위층에 네 개의 작은 침대가있는 방.\n빈 책장에"
	L["Transmutation"] = "변환"
	L["transTip"] = "아래층. 책꽂이 한 쌍을보세요.\n책은 빈 책장에있을거야."
	L["Abjuration"] = "회피술"
	L["abjTip"] = "아래층. 오른쪽에.\n책이있는 의자 옆의 바닥에"
	L["Introduction"] = "소개편"
	L["intTip"] = "방의 오른쪽에있는 책꽂이 바닥에있는 바닥에"
	L["Illusion"] = "환상"
	L["illTip"] = "그 위에 아무 것도없는 상자에.\n구석에"

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["AddOn Description"] = "Te ajudar a encontrar os livros"
	L["Dalaran Map"] = "Mostrar o mapa de Dalaran"
	L["Higher Learning"] = "Letrado nas artes arcanas"
	L["Divination"] = "Divinação"
	L["divTip"] = "No topo da escada, olhe para a esquerda.\n"
		.."O livro está no chão entre as duas estantes"
	L["Conjuration"] = "Conjuração"
	L["conjTip"] = 
		"No lado direito da sala quando você entra.\nFique na frente das estantes de livros.\n"
		.."O livro está no espaço vazio na prateleira\nde baixo da estante da mão esquerda"
	L["Enchantment"] = "Encantamento"
	L["enchTip"] = "Na sacada. Em uma caixa sem nada.\nAo lado de uma caixa maior"
	L["Necromancy"] = "Necromancia"
	L["necroTip"] = "No andar de cima, no quarto\ncom quatro camas pequenas.\nNa estante vazia"
	L["Transmutation"] = "Transmutação"
	L["transTip"] = "Andar de baixo. Olhe para\no par de estantes de livros.\nO livro estará na estante vazia"
	L["Abjuration"] = "Abjuração"
	L["abjTip"] = "Andar de baixo. Do lado direito.\nNo chão ao lado de um banquinho\ncom livros sobre ele"
	L["Introduction"] = "Introdução"
	L["intTip"] = "No chão, na base da estante\ndo lado direito da sala"
	L["Illusion"] = "Ilusão"
	L["illTip"] = "Em uma caixa sem\nnada. Na esquina"

elseif ns.locale == "ruRU" then
	L["AddOn Description"] = "Помогите найти книги"
	L["Dalaran Map"] = "Покажите карту Даларана"
	L["Higher Learning"] = "Ученье – свет!"
	L["Divination"] = "Предсказание"
	L["divTip"] = "Наверху лестницы посмотрите налево.\n"
		.."Книга находится на полу между двумя\nкнижными полками"
	L["Conjuration"] = "Сотворение"
	L["conjTip"] = 
		"На правой стороне комнаты, как вы входите.\nВстаньте перед книжными полками.\n"
		.."Книга находится в пустом месте на нижней\nполке левой книжной полки"
	L["Enchantment"] = "Чаротворство"
	L["enchTip"] = "На балконе. На ящике, на котором\nничего нет. Рядом с большим ящиком"
	L["Necromancy"] = "Некромантия"
	L["necroTip"] = "На втором этаже в комнате\nчетыре маленькие кровати.\nНа пустой книжной полке"
	L["Transmutation"] = "Трансмутация"
	L["transTip"] = "Внизу. Посмотрите на пару\nкнижных полок. Книга будет\nна пустой книжной полке"
	L["Abjuration"] = "Отречение"
	L["abjTip"] = "Внизу. На правой стороне.\nНа полу возле табуретки с книгами"
	L["Introduction"] = "Введение"
	L["intTip"] = "На полу у основания книжной\nполки с правой стороны комнаты"
	L["Illusion"] = "Иллюзия"
	L["illTip"] = "На ящике, на котором\nничего нет. В углу"

elseif ns.locale == "zhCN" then
	L["AddOn Description"] = "帮你找书"
	L["Dalaran Map"] = "显示达拉然的地图"
	L["Higher Learning"] = "进修"
	L["Divination"] = "占卜"
	L["divTip"] = "在楼梯的顶部，向左看。\n这本书位于两个书架之间"
	L["Conjuration"] = "召唤"
	L["conjTip"] = "当你进入房间的右侧。\n站在书架前。\n这本书位于左手书架底架的空白处"
	L["Enchantment"] = "增强"
	L["enchTip"] = "在阳台上。\n在没有任何东西的箱子上。\n旁边一个较大的箱子"
	L["Necromancy"] = "通灵"
	L["necroTip"] = "樓上，在房間裡有四張小床。\n在空的書架上"
	L["Transmutation"] = "转化"
	L["transTip"] = "楼下。看看这对书架。\n这本书将在空书架上"
	L["Abjuration"] = "防护"
	L["abjTip"] = "楼下。在右侧。\n在凳子旁边的地板上有书籍"
	L["Introduction"] = "介绍"
	L["intTip"] = "在房间右侧书架底部的地板上"
	L["Illusion"] = "幻象"
	L["illTip"] = "在没有任何东西的箱子上。\n在角落"

elseif ns.locale == "zhTW" then
	L["AddOn Description"] = "幫你找書"
	L["Dalaran Map"] = "顯示達拉然的地圖"
	L["Higher Learning"] = "進修"
	L["Divination"] = "占卜"
	L["divTip"] = "在樓梯的頂部，向左看。\n這本書位於兩個書架之間"
	L["Conjuration"] = "召喚"
	L["conjTip"] = "當你進入房間的右側。\n站在書架前。\n這本書位於左手書架底架的空白處"
	L["Enchantment"] = "增強"
	L["enchTip"] = "在陽台上。\n在沒有任何東西的箱子上。\n旁邊一個較大的箱子"
	L["Necromancy"] = "通靈"
	L["necroTip"] = "樓上，在房間裡有四張小床。\n在空的書架上"
	L["Transmutation"] = "轉化"
	L["transTip"] = "樓下。看看這對書架。\n這本書將在空書架上"
	L["Abjuration"] = "防護"
	L["abjTip"] = "樓下。在右側。\n在凳子旁邊的地板上有書籍"
	L["Introduction"] = "介紹"
	L["intTip"] = "在房間右側書架底部的地板上"
	L["Illusion"] = "幻象"
	L["illTip"] = "在沒有任何東西的箱子上。\n在角落"
	
else
	L["AddOn Description"] = "Helps you find the books"
	L["Dalaran Map"] = "Show me the map of Dalaran"
	L["divTip"] = "At the top of the stairs, look\nleft. The book is on the floor\nbetween the two bookshelves"
	L["conjTip"] = "On the right side of the room as you\nenter. Stand in front of the bookshelves.\n"..
		"The book is in the empty space on the\nbottom shelf of the left hand bookshelf"
	L["enchTip"] = "On the balcony. On a\ncrate with nothing upon it.\nNext to a larger crate"
	L["necroTip"] = "Upstairs, in the room with four\nsmall beds. On the empty bookshelf"
	L["transTip"] = "Downstairs. Look at the pair\nof bookshelves. The book will\nbe in the empty bookshelf"
	L["abjTip"] = "Downstairs. On the right side. On the\nfloor next to a stool with books upon it"
	L["intTip"] = "On the floor at the base of the bookshelf\non the right side of the room"
	L["illTip"] = "On a crate with nothing\nupon it. In the corner"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]
	local aName, completed, completedMe = "", false, false
	
	_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( 1956 )
	GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight,
			( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
								or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
	GameTooltip:AddDoubleLine( " ",
			( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
								or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )

	_, _, completed = GetAchievementCriteriaInfo( 1956, ( ( ns.classic == true ) and pin.aIndexC or pin.aIndexR ) )
	GameTooltip:AddDoubleLine( ns.colour.highlight.. L[ pin.shortTitle ],
			( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
								or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
	GameTooltip:AddLine( ns.colour.plaintext ..L[ pin.tip] )

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
	local function iterator(t, prev)
		if not t then return end
		local coord, v = next(t, prev)
		local completed, iconIndex
		while coord do
			if v then
				if ns.db.iconChoice == 11 then
					completed = select( 3, GetAchievementCriteriaInfo( 1956, ( ( ns.classic == true ) and v.aIndexC or v.aIndexR ) ) )
					iconIndex = (completed == true) and 5 or 3
				else
					iconIndex = ns.db.iconChoice
				end
				return coord, nil, ns.textures[iconIndex], ns.db.iconScale * ns.scaling[iconIndex], ns.db.iconAlpha
			end
			coord, v = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> Higher Learning options
ns.options = {
	type = "group",
	name = L["Higher Learning"],
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
			},
		},
		icon = {
			type = "group",
			name = L["Map Pin Selections"],
			inline = true,
			args = {
				iconChoice = {
					type = "range",
					name = L["Higher Learning"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"]
							.."\n11 = " ..L["Red"] .."/" ..L["Green"],
					min = 1, max = 11, step = 1,
					arg = "iconChoice",
					order = 4,
				},
			},
		},
	},
}

function HandyNotes_HigherLearning_OnAddonCompartmentClick( addonName, buttonName )
	if buttonName and buttonName == "RightButton" then
		OpenWorldMap( 125 )
		if WorldMapFrame:IsVisible() ~= true then
			print( ns.colour.prefix	..L["Higher Learning"] ..": " ..ns.colour.plaintext
					.."Not possible at this time. Try later" )
		end
	else
		Settings.OpenToCategory( "HandyNotes" )
		LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "HigherLearning" )
	end
end
 
function HandyNotes_HigherLearning_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( DropDownList1, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..L["Higher Learning"] )
	GameTooltip:AddLine( ns.colour.highlight .." " )
	GameTooltip:AddDoubleLine( ns.colour.highlight .."Left", ns.colour.plaintext ..L["Options"] )
	GameTooltip:AddDoubleLine( ns.colour.highlight .."Right", ns.colour.plaintext ..L["Dalaran Map"] )
	GameTooltip:Show()
end

function HandyNotes_HigherLearning_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	HandyNotes:RegisterPluginDB("HigherLearning", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_HigherLearningDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "HigherLearning")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_HigherLearningDB", "AceEvent-3.0")