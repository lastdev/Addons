--[[
                                ----o----(||)----oo----(||)----o----

                                             Winter Veil

                                      v2.06 - 12th January 2024
									 
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
-- Xmas theme
ns.colour = {}
ns.colour.prefix	= "\124cFF5FFB17" -- Emerald Green
ns.colour.highlight = "\124cFF52D017" -- Pea Green
ns.colour.plaintext = "\124cFF008000" -- Green W3C

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								removeDailies = true, removeSeasonal = true, removeEverC = true,
								removeEverA = false,
								icon_LittleHelper = 16, icon_frostyShake = 13, icon_caroling = 17,
								icon_vendor = 15, icon_ogrila = 12, icon_letItSnow = 9, 
								icon_onMetzen = 20, icon_holidayBromance = 8, icon_tisSeason = 10,
								icon_dailies = 11, icon_gourmet = 19, icon_bbKing = 7,
								icon_ironArmada = 9} }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetMapChildrenInfo = C_Map.GetMapChildrenInfo
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
--local GetMapInfo = C_Map.GetMapInfo -- phase checking during testing
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local gsub = string.gsub
local next = _G.next

local HandyNotes = _G.HandyNotes

continents[ 12 ] = true -- Kalimdor
continents[ 13 ] = true -- Eastern Kingdoms
continents[ 101 ] = true -- Outland
continents[ 113 ] = true -- Northrend
continents[ 572 ] = true -- Draenor
continents[ 947 ] = true -- Azeroth

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
	L["AddOn Description"] = "Hilfe für Erfolge und Quests in Winterhauchfest"
	L["BB King"] = "Boss auf der Erbse"
	L["Caroling"] = "Weihnachtslieder"
	L["Daily"] = "Täglich"
	L["Frosty Shake"] = "Frostiger Tanz"
	L["Holiday Bromance"] = "Brüderliche"
	L["Iron Armada"] = "Armada"
	L["Let It Snow"] = "Schnee"
	L["Little Helper"] = "Kleiner Helfer"
	L["On Metzen!"] = "Auf Metzen!"
	L["RemoveDailies"] = "Entferne tägliche Quests, wenn " ..ns.name 
		.." sie heute abgeschlossen hat"
	L["RemoveDailiesMore"] = "Wenn Sie die tägliche Quest heute abschließen, wird die "
		.."Kartenmarkierung entfernt"
	L["RemoveEver"] = "Entfernen Sie den Stift, wenn der Erfolg abgeschlossen ist: "
	L["'Tis the Season"] = "Alle Jahre"
	L["Vendors"] = "Anbieter"
	L["Winter Veil"] = "Winterhauchfest"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["AddOn Description"] = "Ayuda para los logros del Festival de Invierno"
	L["BB King"] = "Rey del Rifle"
	L["Caroling"] = "Villancicos"
	L["Daily"] = "Diaria"
	L["Frosty Shake"] = "Meneíto helado"
	L["Gourmet"] = "El gourmet"
	L["Holiday Bromance"] = "¿Y mi beso?"
	L["Iron Armada"] = "Armada"
	L["Let It Snow"] = "¡Que nieve!"
	L["Little Helper"] = "Poco de ayudas"
	L["On Metzen!"] = "¡Vamos, Metzen!"
	L["RemoveDailies"] = "Elimina las misiones diarias si " ..ns.name .." las completó hoy"
	L["RemoveDailiesMore"] = "Si completas la misión diaria hoy, se eliminará el marcador del mapa."
	L["RemoveEver"] = "Retire el pin si se completa el logro: "
	L["'Tis the Season"] = "Es la temporada"
	L["Vendors"] = "Vendedores"
	L["Winter Veil"] = "El festín del Festival de Invierno"

elseif ns.locale == "frFR" then
	L["AddOn Description"] = "Aide à l'événement mondial Voile d'hiver"
	L["BB King"] = "La Foire des trônes"
	L["Caroling"] = "Vive le Voile d'Hiver"
	L["Daily"] = "Journalière"
	L["Frosty Shake"] = "Briser la glace"
	L["Holiday Bromance"] = "Entre amis"
	L["Iron Armada"] = "Armada"
	L["Let It Snow"] = "Il neige!"
	L["Little Helper"] = "Petits assistants"
	L["On Metzen!"] = "Allez Metzen!"
	L["RemoveDailies"] = "Supprimez les quêtes quotidiennes si " ..ns.name
		.." les a terminées aujourd'hui"
	L["RemoveDailiesMore"] = "Si vous terminez la quête quotidienne aujourd'hui, "
		.."le marqueur de carte sera supprimé"
	L["RemoveEver"] = "Retirez l'épingle si le succès est terminé: "
	L["'Tis the Season"] = "Le vent d'hiver"
	L["Vendors"] = "Vendeurs"
	L["Winter Veil"] = "Voile d'hiver"

elseif ns.locale == "itIT" then
	L["AddOn Description"] = "Assiste con l'evento mondiale Vigilia di Grande Inverno"
	L["BB King"] = "Re del softair"
	L["Caroling"] = "Cantate"
	L["Daily"] = "Giornaliera"
	L["Frosty Shake"] = "Ballando la neve"
	L["Gourmet"] = "Abbuffata"
	L["Holiday Bromance"] = "Fraterne"
	L["Iron Armada"] = "Armata"
	L["Let It Snow"] = "Nevicata"
	L["Little Helper"] = "Piccola peste"
	L["Ogri'la"] = "Tu incendi..."
	L["On Metzen!"] = "Metzen!"
	L["RemoveDailies"] = "Rimuovi le missioni giornaliere se " ..ns.name .." le ha completate oggi"
	L["RemoveDailiesMore"] = "Se completi la missione giornaliera oggi, l'indicatore "
		.."sulla mappa verrà rimosso"
	L["RemoveEver"] = "Rimuovi la spilla se l'obiettivo è stato completato: "
	L["'Tis the Season"] = "Per le feste"
	L["Vendors"] = "Venditori"
	L["Winter Veil"] = "Vigilia di Grande Inverno"

elseif ns.locale == "koKR" then
	L["AddOn Description"] = "겨울맞이 축제 대규모 이벤트 지원"	
	L["BB King"] = "목숨을 건 장난"
	L["Caroling"] = "기쁜 노래 부르면서"
	L["Daily"] = "일일"
	L["Frosty Shake"] = "눈사람 춤을"
	L["Gourmet"] = "미식가"
	L["Holiday Bromance"] = "우정"
	L["Iron Armada"] = "강철 함대"
	L["Let It Snow"] = "강설"
	L["Little Helper"] = "꼬마 도우미"
	L["Ogri'la"] = "오그릴라"
	L["On Metzen!"] = "멧젠!"
	L["RemoveDailies"] = ns.name .."이 오늘 완료한 경우 일일 퀘스트를 제거하세요."
	L["RemoveDailiesMore"] = "오늘 일일 퀘스트를 완료하시면 지도 표시가 제거됩니다."
	L["RemoveEver"] = "업적이 완료되면 핀을 제거하세요: "
	L["'Tis the Season"] = "즐거운 연말연시"
	L["Vendors"] = "공급업체"
	L["Winter Veil"] = "겨울맞이 축제"

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["AddOn Description"] = "Auxilia no evento mundial Festa do Véu de Inverno"
	L["BB King"] = "Cegando Alguém"
	L["Caroling"] = "Todos a Cantar"
	L["Daily"] = "Diário(a)"
	L["Frosty Shake"] = "Dança no gelo"
	L["Holiday Bromance"] = "Broderagem"
	L["Iron Armada"] = "Armada"
	L["Let It Snow"] = "Branquinha"
	L["Little Helper"] = "Ajudante"
	L["On Metzen!"] = "Metzen"
	L["RemoveDailies"] = "Remova as missões diárias se " ..ns.name .." as completou hoje"
	L["RemoveDailiesMore"] = "Se você completar a missão diária hoje, o marcador "
		.."do mapa será removido"
	L["RemoveEver"] = "Remova o alfinete se a conquista for concluída: "
	L["'Tis the Season"] = "Emoção de Véu"
	L["Vendors"] = "Fornecedores"
	L["Winter Veil"] = "Festa do Véu de Inverno"

elseif ns.locale == "ruRU" then
	L["AddOn Description"] = "Помогает с игровое событие Зимний Покров"
	L["BB King"] = "Стрельба"
	L["Caroling"] = "Бесстрашный Певчий"
	L["Daily"] = "Ежедневно"
	L["Frosty Shake"] = "Танцы"
	L["Gourmet"] = "Зимние угощения"
	L["Holiday Bromance"] = "Братское"
	L["Iron Armada"] = "Армада"
	L["Let It Snow"] = "Вьюга!"
	L["Little Helper"] = "Моих друзей..."
	L["Ogri'la"] = "Огри'ла"
	L["On Metzen!"] = "К Метцену!"
	L["RemoveDailies"] = "Удалить ежедневные квесты, если " ..ns.name .." выполнила их сегодня."
	L["RemoveDailiesMore"] = "Если вы выполните ежедневное задание сегодня, маркер на "	
		.."карте будет удален."
	L["RemoveEver"] = "Удалите булавку, если достижение выполнено: "
	L["'Tis the Season"] = "Зимние деньки"
	L["Vendors"] = "Продавцы"
	L["Winter Veil"] = "Зимний Покров"

elseif ns.locale == "zhCN" then
	L["AddOn Description"] = "协助冬幕节活动"
	L["BB King"] = "枪神"
	L["Caroling"] = "想唱就唱"
	L["Daily"] = "日常"
	L["Frosty Shake"] = "冰冷的握手"
	L["Gourmet"] = "食家"
	L["Holiday Bromance"] = "节日情谊"
	L["Iron Armada"] = "钢铁大军"
	L["Let It Snow"] = "雪花纷飞"
	L["Little Helper"] = "我的小帮手"
	L["Ogri'la"] = "奥格瑞拉"
	L["On Metzen!"] = "拯救梅森！"
	L["RemoveDailies"] = "如果 " ..ns.name .." 今天完成了每日任务，则删除它们"
	L["RemoveDailiesMore"] = "如果您今天完成每日任务，地图标记将被删除"
	L["RemoveEver"] = "如果成就完成，请移除图钉： "
	L["'Tis the Season"] = "冬天来了"
	L["Vendors"] = "小贩"
	L["Winter Veil"] = "冬幕节"

elseif ns.locale == "zhTW" then
	L["AddOn Description"] = "協助冬幕節活動"
	L["BB King"] = "槍神"
	L["Caroling"] = "想唱就唱"
	L["Daily"] = "日常"
	L["Frosty Shake"] = "冰冷的握手"
	L["Gourmet"] = "食家"
	L["Holiday Bromance"] = "節日情誼"
	L["Iron Armada"] = "鋼鐵大軍"
	L["Let It Snow"] = "雪花紛飛"
	L["Little Helper"] = "我的小幫手"
	L["Ogri'la"] = "奧格瑞拉"
	L["On Metzen!"] = "拯救梅森！"
	L["RemoveDailies"] = "如果 " ..ns.name .." 今天完成了每日任務，則刪除它們"
	L["RemoveDailiesMore"] = "如果您今天完成每日任務，地圖標記將被刪除"
	L["RemoveEver"] = "如果成就完成，請移除圖釘： "
	L["'Tis the Season"] = "冬天來了"
	L["Vendors"] = "小販"
	L["Winter Veil"] = "冬幕節"

else
	L["AddOn Description"] = "Help for the Winter Veil achievements"
	L["RemoveDailies"] = "Remove daily quests if " ..ns.name .." completed them today"
	L["RemoveDailiesMore"] = "If you complete the daily quest today, the map marker will be removed"
	L["RemoveEver"] = "Remove the pin if the Achievement is completed: "
	if ns.locale == "enUS" then
		L["Grey"] = "Gray"
	end
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]

	local completed, aName, completedMe, aID, aIndex;
	local bypassCoords = false
	
	if pin.aID or ( pin.aIDA and ( ns.faction == "Alliance" ) ) or ( pin.aIDH and ( ns.faction == "Horde" ) ) then
		aID = pin.aID or pin.aIDA or pin.aIDH
		aIndex = pin.index or pin.indexA or pin.indexH
		
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( aID )
		GameTooltip:AddDoubleLine( ns.colour.prefix ..aName ..ns.colour.highlight .." (" ..ns.faction ..")",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..L["Account"] ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..L["Account"] ..")" ) )
		GameTooltip:AddDoubleLine( " ",
					( completedMe == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )										

		if aIndex then
			aName, _, completed = GetAchievementCriteriaInfo( aID, aIndex )
			GameTooltip:AddDoubleLine( ns.colour.highlight.. aName,
						( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
											or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
		end
		if ( aID == 5853 ) or ( aID == 5854 ) or ( aID == 277 ) or ( aID == 1685 ) or ( aID == 1686 ) or
			( aID == 1687 ) or ( aID == 1690 ) or ( aID == 1688 ) then
			bypassCoords = true
		elseif ( aID == 10353 ) and ( aIndex == 0 ) then
			bypassCoords = true
		end

	elseif pin.quest or ( pin.questA and ( ns.faction == "Alliance" ) ) or ( pin.questH and ( ns.faction == "Horde" ) ) then
		local quest = pin.quest or pin.questA or pin.questH	
		completed = IsQuestFlaggedCompleted( quest )
		GameTooltip:AddDoubleLine( "\124cFF1F45FC".. "Daily Quest",
					( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
										or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )								
	end
	
	if pin.tip then
		if ( aID == 10353 and aIndex == 0 ) then
			local completion, notYet = "", ""
			for i = 1, 5 do
				_, _, completed = GetAchievementCriteriaInfo( aID, i )
				completion = ( completed == true ) 
					and ( ( completion == "" ) and ( "(" ..i ..")" ) or ( completion ..", (" ..i ..")" ) )
					or completion
				notYet = ( completed == false ) 
					and ( ( notYet == "" ) and ( "(" ..i ..")" ) or ( notYet ..", (" ..i ..")" ) )
					or notYet
			end	
			GameTooltip:AddLine( ns.colour.plaintext ..pin.tip .."\n\n" .."\124cFF00FF00" ..L["Completed"]
				..": " ..ns.colour.plaintext ..completion .."\n" .."\124cFFFF0000" 
				..L["Not Completed"] ..": " ..ns.colour.plaintext ..notYet )
		else
			GameTooltip:AddLine( ns.colour.plaintext ..pin.tip )
		end
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
	-- As few API calls as possible. Always
	-- Allow player to repeat an achievement, even if already completed on the account
	-- removeEverC toggles this double dipping on/off. removeEverA is account wide
	-- GetAchievementInfo account/character but GetAchievementCriteriaInfo is character
	-- Player has two interface options. If "checked" then player want to suppress on
	--     Acc completion and or Char completion. Char is subordinate to Acc
	-- returning FALSE means to abort displaying the pin. TRUE means yes I must display
	-- Following are the logic possibilities from the API calls:
	-- Use these API possibilities against the four possible setting combinations.
	--	Overall 	Index
	--	Acc Char
	--	T	T		T
	--	T	F		T
	--	T	F		F
	--	F	F		T
	--	F	F		F
	local completed, completedMe;
	if ( ns.db.removeEverA == true ) or ( ns.db.removeEverC == true ) then
		-- Player wants suppression of completion
		_, aName, _, completed, _, _, _, _, _, _, _, _, completedMe = GetAchievementInfo( aID )
		-- dominant test
		if ( ns.db.removeEverA == true ) and ( completed == true ) then
			-- So completed on the Acct. Abort
			return false
		end
		-- subordinate test. Note that removeEverA/completed setting/state doesn't matter here
		if ns.db.removeEverC == true then
			-- I.e. just drop to the end if the player had not selected per char suppression
			-- From here on we are only interested in per Character data
			if completedMe == true then
				-- Note that the state of completed is irrelevant as that's account data
				return false
			end
			-- Okay. We might need to test for criteria if such exist. Other wise drop to the end
			if aIndex and ( aIndex > 0 ) then -- Yup I recall some dodgy 0 data - hack for unique cases
				_, _, completed = GetAchievementCriteriaInfo( aID, aIndex ) -- Character. Not Account
				return not completed
			end
		end
	end
	-- fell through catch all
	return true
end

local function ShowConditionallyD( v5or6 )
	local completed;
	if ( ns.db.removeDailies == true ) then
		completed = C_QuestLog.IsQuestFlaggedCompleted( v5or6 )
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
					if pin.aID == 252 then
						if ( ShowConditionallyE( 252 ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_LittleHelper],
								ns.db.iconScale * ns.scaling[ns.db.icon_LittleHelper], ns.db.iconAlpha							
						end
					elseif pin.aID == 273 then
						if ( ShowConditionallyE( 273 ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_onMetzen],
								ns.db.iconScale * ns.scaling[ns.db.icon_onMetzen], ns.db.iconAlpha
						end
					elseif pin.aID == 277 then
						if ( ShowConditionallyE( 277 ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_tisSeason],
								ns.db.iconScale * ns.scaling[ns.db.icon_tisSeason], ns.db.iconAlpha
						end
					elseif pin.aID == 1282 then
						if ( ShowConditionallyE( 1282 ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_ogrila],
								ns.db.iconScale * ns.scaling[ns.db.icon_ogrila], ns.db.iconAlpha
						end
					elseif pin.aID == 1687 then
						if ( ShowConditionallyE( 1687 ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_letItSnow],
								ns.db.iconScale * ns.scaling[ns.db.icon_letItSnow], ns.db.iconAlpha
						end
					elseif pin.aID == 1690 then
						if ( ShowConditionallyE( 1690 ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_frostyShake],
								ns.db.iconScale * ns.scaling[ns.db.icon_frostyShake], ns.db.iconAlpha
						end
					elseif pin.aID == 10353 then
						if ( ShowConditionallyE( 10353, pin.index ) == true ) then
							return coord, nil, ns.textures[ns.db.icon_ironArmada],
								ns.db.iconScale * ns.scaling[ns.db.icon_ironArmada], ns.db.iconAlpha
						end
					end
				elseif pin.aIDA then
					if ns.faction == "Alliance" then
						if pin.aIDA == 277 then
							if ( ShowConditionallyE( 277 ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_tisSeason],
									ns.db.iconScale * ns.scaling[ns.db.icon_tisSeason], ns.db.iconAlpha
							end
						elseif pin.aIDA == 1686 then
							if ( ShowConditionallyE( 1686, pin.indexA ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_holidayBromance],
									ns.db.iconScale * ns.scaling[ns.db.icon_holidayBromance], ns.db.iconAlpha
							end
						elseif pin.aIDA == 1688 then
							if ( ShowConditionallyE( 1688 ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_gourmet],
									ns.db.iconScale * ns.scaling[ns.db.icon_gourmet], ns.db.iconAlpha
							end
						elseif pin.aIDA == 4436 then
							if ( ShowConditionallyE( 4436, pin.indexA ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_bbKing],
									ns.db.iconScale * ns.scaling[ns.db.icon_bbKing], ns.db.iconAlpha
							end
						elseif pin.aIDA == 5853 then
							if ( ShowConditionallyE( 5853, pin.indexA ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_caroling],
									ns.db.iconScale * ns.scaling[ns.db.icon_caroling], ns.db.iconAlpha
							end
						elseif pin.aIDA == 10353 then
							if ( ShowConditionallyE( 10353 ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_ironArmada],
									ns.db.iconScale * ns.scaling[ns.db.icon_ironArmada], ns.db.iconAlpha
							end
						end
					end					
				elseif pin.aIDH then
					if ns.faction == "Horde" then
						if pin.aIDH == 277 then
							if ( ShowConditionallyE( 277 ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_tisSeason],
									ns.db.iconScale * ns.scaling[ns.db.icon_tisSeason], ns.db.iconAlpha
							end
						elseif pin.aIDH == 1685 then
							if ( ShowConditionallyE( 1685, pin.indexH ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_holidayBromance],
									ns.db.iconScale * ns.scaling[ns.db.icon_holidayBromance], ns.db.iconAlpha
							end
						elseif pin.aIDH == 1688 then
							if ( ShowConditionallyE( 1688 ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_gourmet],
									ns.db.iconScale * ns.scaling[ns.db.icon_gourmet], ns.db.iconAlpha
							end
						elseif pin.aIDH == 4437 then
							if ( ShowConditionallyE( 4437, pin.indexH ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_bbKing],
									ns.db.iconScale * ns.scaling[ns.db.icon_bbKing], ns.db.iconAlpha
							end
						elseif pin.aIDH == 5854 then
							if ( ShowConditionallyE( 5854, pin.indexH ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_caroling],
									ns.db.iconScale * ns.scaling[ns.db.icon_caroling], ns.db.iconAlpha
							end
						elseif pin.aIDH == 10353 then
							if ( ShowConditionallyE( 10353 ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_ironArmada],
									ns.db.iconScale * ns.scaling[ns.db.icon_ironArmada], ns.db.iconAlpha
							end
						elseif pin.aIDH == 10353 then
							if ( ShowConditionallyE( 10353 ) == true ) then
								return coord, nil, ns.textures[ns.db.icon_ironArmada],
									ns.db.iconScale * ns.scaling[ns.db.icon_ironArmada], ns.db.iconAlpha
							end
						end
					end
				elseif pin.questA then -- 7043, 39651
					if ns.faction == "Alliance" then
						if ShowConditionallyD( pin.questA ) == true then
							return coord, nil, ns.textures[ns.db.icon_dailies],
								ns.db.iconScale * ns.scaling[ns.db.icon_dailies], ns.db.iconAlpha									
						end
					end
				elseif pin.questH then -- 6983, 39651
					if ns.faction == "Horde" then
						if ShowConditionallyD( pin.questH ) == true then
							return coord, nil, ns.textures[ns.db.icon_dailies],
								ns.db.iconScale * ns.scaling[ns.db.icon_dailies], ns.db.iconAlpha									
						end
					end
				elseif pin.vendor then
					return coord, nil, ns.textures[ns.db.icon_vendor],
						ns.db.iconScale * ns.scaling[ns.db.icon_vendor], ns.db.iconAlpha
				elseif pin.vendorA then
					if ns.faction == "Alliance" then
						return coord, nil, ns.textures[ns.db.icon_vendor],
							ns.db.iconScale * ns.scaling[ns.db.icon_vendor], ns.db.iconAlpha
					end
				elseif pin.vendorH then
					if ns.faction == "Horde" then
						return coord, nil, ns.textures[ns.db.icon_vendor],
							ns.db.iconScale * ns.scaling[ns.db.icon_vendor], ns.db.iconAlpha
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

-- Interface -> Addons -> Handy Notes -> Plugins -> Winter Veil options
ns.options = {
	type = "group",
	name = L["Winter Veil"],
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
					name = L["RemoveDailies"],
					desc = L["RemoveDailiesMore"],
					type = "toggle",
					width = "full",
					arg = "removeDailies",
					order = 4,
				},
				removeEverC = {
					name =  L["RemoveEver"] ..ns.colour.highlight ..ns.name,
					desc = " ",
					type = "toggle",
					width = "full",
					arg = "removeEverC",
					order = 5,
				},
				removeEverA = {
					name = L["RemoveEver"] ..ns.colour.highlight ..L["Account"],
					desc = " ",
					type = "toggle",
					width = "full",
					arg = "removeEverA",
					order = 6,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Icon Selection"],
			inline = true,
			args = {
				icon_bbKing = {
					type = "range",
					name = L["BB King"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_bbKing",
					order = 8,
				},
				icon_caroling = {
					type = "range",
					name = L["Caroling"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_caroling",
					order = 9,
				},
				icon_dailies = {
					type = "range",
					name = L["Daily"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_dailies",
					order = 10,
				},
				icon_frostyShake = {
					type = "range",
					name = L["Frosty Shake"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_frostyShake",
					order = 11,
				},
				icon_gourmet = {
					type = "range",
					name = L["Gourmet"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_gourmet",
					order = 12,
				},
				icon_holidayBromance = {
					type = "range",
					name = L["Holiday Bromance"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_holidayBromance",
					order = 13,
				},
				icon_ironArmada = {
					type = "range",
					name = L["Iron Armada"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_ironArmada",
					order = 14,
				},
				icon_letItSnow = {
					type = "range",
					name = L["Let It Snow"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_letItSnow",
					order = 15,
				},
				icon_LittleHelper = {
					type = "range",
					name = L["Little Helper"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_LittleHelper",
					order = 16,
				},
				icon_ogrila = {
					type = "range",
					name = L["Ogri'la"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_ogrila",
					order = 17,
				},
				icon_onMetzen = {
					type = "range",
					name = L["On Metzen!"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_onMetzen",
					order = 18,
				},
				icon_tisSeason = {
					type = "range",
					name = L["'Tis the Season"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_tisSeason",
					order = 19,
				},
				icon_vendor = {
					type = "range",
					name = L["Vendors"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = "
							.. L["Blue Ribbon Box"] .."\n8 = " ..L["Green Ribbon Box"] .."\n9 = "
							..L["Pink Ribbon Box"] .."\n10 = " ..L["Purple Ribbon Box"] .."\n11 = "
							..L["Red Ribbon Box"] .."\n12 = " ..L["Teal Ribbon Box"] .."\n13 = "
							..L["Blue Santa Hat"] .."\n14 = " ..L["Green Santa Hat"] .."\n15 = "
							..L["Pink Santa Hat"] .."\n16 = " ..L["Red Santa Hat"] .."\n17 = "
							..L["Yellow Santa Hat"] .."\n18 = " ..L["Candy Cane"] .."\n19 = "
							..L["Ginger Bread"] .."\n20 = " ..L["Holly"], 
					min = 1, max = 20, step = 1,
					arg = "icon_vendor",
					order = 20,
				},
			},
		},
	},
}

function HandyNotes_WinterVeil_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "WinterVeil" )
end
 
function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
	for continentMapID in next, continents do
		local children = GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			-- Maps here will not propagate upwards
			if ( map.mapID == 7 ) or -- Mulgore
				( map.mapID == 84 ) or -- Stormwind
				( map.mapID == 85 ) or -- Orgrimmar
				( map.mapID == 87 ) or -- Ironforge
				( map.mapID == 90 ) or -- Undercity
				( map.mapID == 103 ) or -- The Exodar
				( map.mapID == 110 ) or -- Silvermoon City
				( map.mapID == 127 ) or -- Crystalsong Forest
				( map.mapID == 224 ) or -- Stranglethorn Vale
				( map.mapID == 582 ) or -- Lunarfall Alliance Garrison
				( map.mapID == 590 ) then -- Frostwall Horde Garrison
			elseif coords then
				for coord, pin in next, coords do
					local function AddToContinent()
						local mx, my = HandyNotes:getXY(coord)
						local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
						if cx and cy then
							ns.points[continentMapID] = ns.points[continentMapID] or {}
							ns.points[continentMapID][HandyNotes:getCoord(cx, cy)] = pin
						end
					end				
					if pin.aID then
						AddToContinent()
					elseif pin.aIDA then
						if ns.faction == "Alliance" then
							AddToContinent()
						end
					elseif pin.aIDH then
						if ns.faction == "Horde" then
							AddToContinent()
						end
					elseif pin.questA then -- 7043, 39651
						if ns.faction == "Alliance" then
							AddToContinent()
						end
					elseif pin.questH then -- 6983, 39651
						if ns.faction == "Horde" then
							AddToContinent()
						end
					elseif pin.vendor then
						AddToContinent()
					elseif pin.vendorA then
						if ns.faction == "Alliance" then
							AddToContinent()
						end
					elseif pin.vendorH then
						if ns.faction == "Horde" then
							AddToContinent()
						end
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("WinterVeil", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_WinterVeilDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "WinterVeil")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_WinterVeilDB", "AceEvent-3.0")