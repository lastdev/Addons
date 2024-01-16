--[[
                                ----o----(||)----oo----(||)----o----

                                          Springfur Alpaca

                                       v1.26 - 12th January 2024
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
-- Brown theme
ns.colour = {}
ns.colour.prefix	= "\124cFFD2691E"	-- X11Chocolate
ns.colour.highlight = "\124cFFF4A460"	-- X11SandyBrown
ns.colour.plaintext = "\124cFFDEB887"	-- X11BurlyWood

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true, 
								iconChoice = 7, iconChoiceSpecial = 4 } }
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format, next, select = format, next, select
local gsub = string.gsub
local UnitAura = UnitAura

local HandyNotes = _G.HandyNotes

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

if ns.locale == "deDE" then
	L["AddOn Description"] = "Hilft Ihnen, das " ..ns.colour.highlight .."Frühlingsfell-Alpaka"
		..ns.colour.plaintext .." in Uldum zu erhalten"
	L["Alpaca It In"] = "Wir alpaken's dann mal"
	L["Alpaca It Up"] = "Rackern fürs Alpaka"
	L["Daily Quest"] = "Tägliche Aufgabe"
	L["Gersahl Greens"] = "Gersahlblätter"
	L["of"] = "@ von #"
	L["Speak to Zidormi"] = "Sprich mit Zidormi"
	L["Springfur Alpaca"] = "Frühlingsfellalpaka"
	L["Uldum Map"] = "Uldum-Karte"
	L["Wrong version of Uldum"] = "Falsche Version von Uldum"
	
elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["AddOn Description"] = "Te ayuda a obtener " ..ns.colour.highlight
		.."el Alpaca de pelaje primaveral" ..ns.colour.plaintext .." en Uldum"
	L["Alpaca It In"] = "Hay una alpaca en ti"
	L["Alpaca It Up"] = "Una alpaca de traca"
	L["Daily Quest"] = "Búsqueda Diaria"
	L["Gersahl Greens"] = "Verduras Gersahl"
	L["of"] = "@ de #"
	L["Speak to Zidormi"] = "Hablar con Zidormi"
	L["Springfur Alpaca"] = "Alpaca de pelaje primaveral"
	L["Uldum Map"] = "Mapa de Uldum"
	L["Wrong version of Uldum"] = "Versión incorrecta de Uldum"

elseif ns.locale == "frFR" then
	L["AddOn Description"] = "Vous aide à obtenir " ..ns.colour.highlight .."l'alpaga toison-vernale" 
		..ns.colour.plaintext .." à Uldum"
	L["Alpaca It In"] = "Alpaga alpagué"
	L["Alpaca It Up"] = "Alpaga gavé"
	L["Daily Quest"] = "Quêtes Journalières"
	L["Gersahl Greens"] = "Légume de Gersahl"
	L["of"] = "@ sur #"
	L["Speak to Zidormi"] = "Parlez à Zidormi"
	L["Springfur Alpaca"] = "Alpaga toison-vernale"
	L["Uldum Map"] = "Carte de Uldum"
	L["Wrong version of Uldum"] = "Mauvaise version de Uldum"

elseif ns.locale == "itIT" then
	L["AddOn Description"] = "Ti aiuta a ottenere " ..ns.colour.highlight .."Alpaca Primopelo"
		..ns.colour.plaintext .." a Uldum"
	L["Alpaca It In"] = "Alpaca 1, Alpaca 2"
	L["Alpaca It Up"] = "Io sono Alpaca"
	L["Daily Quest"] = "Missione Giornaliera"
	L["Gersahl Greens"] = "Insalata di Gersahl"
	L["of"] = "@ di #"
	L["Speak to Zidormi"] = "Parla con Zidormi"
	L["Springfur Alpaca"] = "Alpaca Primopelo"
	L["Uldum Map"] = "Mappa di Uldum"
	L["Wrong version of Uldum"] = "Versione errata di Uldum"

elseif ns.locale == "koKR" then
	L["AddOn Description"] = "울둠에서 " ..ns.colour.highlight .."봄털 알파카" ..ns.colour.plaintext
		.."를 얻는 데 도움이 됩니다."
	L["Alpaca It In"] = "알파카 출동!"
	L["Alpaca It Up"] = "알파카만 믿으라고"
	L["Daily Quest"] = "일일 퀘스트"
	L["Gersahl Greens"] = "게샬 채소"
	L["of"] = "#개 중 @개"
	L["Speak to Zidormi"] = "지도르미님과 대화"
	L["Springfur Alpaca"] = "봄털 알파카"
	L["Uldum Map"] = "울둠 지도"
	L["Wrong version of Uldum"] = "잘못된 버전의 울둠"

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["AddOn Description"] = "Ajuda você a obter o " ..ns.colour.highlight .."Alpaca Lã de Primavera"
		..ns.colour.plaintext .." em Uldum"
	L["Alpaca It In"] = "Alpaca pacas"
	L["Alpaca It Up"] = "Alpaca papa"
	L["Daily Quest"] = "Missão Diária"
	L["Gersahl Greens"] = "Folhas de Gersahl"
	L["of"] = "@ de #"
	L["Speak to Zidormi"] = "Fale com Zidormi"
	L["Springfur Alpaca"] = "Alpaca Lã de Primavera"
	L["Uldum Map"] = "Mapa de Uldum"
	L["Wrong version of Uldum"] = "Versão incorreta de Uldum"

elseif ns.locale == "ruRU" then
	L["AddOn Description"] = "Помогает вам получить " ..ns.colour.highlight .."Курчавая альпака"
		..ns.colour.plaintext .." в Ульдум"
	L["Alpaca It In"] = "Альпачиный взгляд"
	L["Alpaca It Up"] = "Добряк среди альпак"
	L["Daily Quest"] = "Ежедневный Квест"
	L["Gersahl Greens"] = "Побеги герсали"
	L["of"] = "@ из #"
	L["Speak to Zidormi"] = "Поговори с Зидорми"
	L["Springfur Alpaca"] = "Курчавая альпака"
	L["Uldum Map"] = "Карта Ульдума"
	L["Wrong version of Uldum"] = "Неправильная версия Ульдум"

elseif ns.locale == "zhCN" then
	L["AddOn Description"] = "帮助您获取奥丹姆中的" ..ns.colour.highlight .."春裘羊驼"
	L["Alpaca It In"] = "Alpaca It In" -- No Translation available at Wowhead
	L["Alpaca It Up"] = "羊驼要吃饱"
	L["Daily Quest"] = "日常"
	L["Gersahl Greens"] = "基萨尔野菜"
	L["of"] = "@ 共 # 个"
	L["Speak to Zidormi"] = "与 希多尔米 通话"
	L["Springfur Alpaca"] = "春裘羊驼"
	L["Uldum Map"] = "奥丹姆地图"
	L["Wrong version of Uldum"] = "奥丹姆 版本错误"

elseif ns.locale == "zhTW" then
	L["AddOn Description"] = "幫助您獲取奧丹姆中的" ..ns.colour.highlight .."春裘羊駝"
	L["Alpaca It In"] = "Alpaca It In" -- See for simplified. Traditional is a direct translation of that
	L["Alpaca It Up"] = "羊駝要吃飽"
	L["Daily Quest"] = "每日"
	L["Gersahl Greens"] = "肉荳蔻蔬菜"
	L["of"] = "@ 共 # 個"
	L["Speak to Zidormi"] = "與 希多爾米 通話"
	L["Springfur Alpaca"] = "春裘羊駝"
	L["Uldum Map"] = "奧丹姆地圖"
	L["Wrong version of Uldum"] = "奧丹姆 版本錯誤"
	
else
	L["AddOn Description"] = "Helps you to obtain the " ..ns.colour.highlight .."Springfur Alpaca"
		..ns.colour.plaintext .." in Uldum"
	L["of"] = "@ of #"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter( mapFile, coord )
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
	else
		GameTooltip:SetOwner( self, "ANCHOR_RIGHT" )
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]
	
	if pin.alpaca then
		GameTooltip:SetText( ns.colour.prefix ..L["Springfur Alpaca"] )

		local completed = C_QuestLog.IsQuestFlaggedCompleted( 58887 )
		GameTooltip:AddDoubleLine( ns.colour.highlight ..L["Alpaca It In"],
			( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
								or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
		
		if ( completed == false ) then
			GameTooltip:AddLine( " " )
			completed = C_QuestLog.IsQuestFlaggedCompleted( 58879 )
			GameTooltip:AddLine( "\124cFF1F45FC".. L["Daily Quest"] )
			GameTooltip:AddDoubleLine( ns.colour.highlight ..L["Alpaca It Up"],
				( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..ns.name ..")" ) 
									or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..ns.name ..")" ) )
			if ( completed == false ) then
				local questText = GetQuestObjectiveInfo( 58879, 1, false )
				if questText then
					GameTooltip:AddDoubleLine( " ", ns.colour.plaintext ..questText )
				else
					-- Yeah I got a nil result while thrash testing
					GameTooltip:AddLine( "\124cFFFF0000" ..PERKS_PROGRAM_SERVER_ERROR )
				end
			end
			
			local _, _, _, fulfilled, required = GetQuestObjectiveInfo( 58881, 0, false )
			local progress = L["of"]
			progress = string.gsub( progress, "@", fulfilled )
			progress = string.gsub( progress, "#", required )
			GameTooltip:AddLine( ns.colour.highlight .."(" ..progress ..")" )
		end
		
	elseif pin.gersahlGreens then
		GameTooltip:SetText( ns.colour.prefix ..L["Gersahl Greens"] )
		
	else
		GameTooltip:SetText( ns.colour.prefix ..L["Springfur Alpaca"] )
		GameTooltip:AddLine( ns.colour.highlight ..L["Speak to Zidormi"] .." (56.02,35.14)" )
		GameTooltip:AddLine( ns.colour.highlight ..L["Wrong version of Uldum"] )
	end

	if ns.db.showCoords == true then
		GameTooltip:AddLine( " " )
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
		while coord do
			if pin then
				if pin.alpaca then
					return coord, nil, ns.textures[ns.db.iconChoice],
							ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
				elseif pin.gersahlGreens then
					return coord, nil, ns.texturesSpecial[ns.db.iconChoiceSpecial],
							ns.db.iconScale * ns.scalingSpecial[ns.db.iconChoiceSpecial], ns.db.iconAlpha
				else
					local found = false
					-- C_Map.GetBestMapForUnit( "player" ) == 1527 would also work I'd think?
					-- Memory says that patches ago when doing this I got abends when jumping
					-- in and out of instances and trying to show a map using that code
					for i = 1, 40 do
						local spellID = select( 10, UnitAura( "player", i, "HELPFUL" ) )
						if not spellID then break end
						if ( spellID == 317785 ) then -- Zidormi buff to see the Cataclysm / Old Uldum
							found = true
							break
						end
					end
					if ( found == true ) then
						return coord, nil, ns.texturesSpecial[ 5 ], -- Red Cross and * 3 to make it big!
								ns.db.iconScale * ns.scalingSpecial[ 5 ] * 3, ns.db.iconAlpha
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

-- Interface -> Addons -> Handy Notes -> Plugins -> Springfur Alpaca options
ns.options = {
	type = "group",
	name = L["Springfur Alpaca"],
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
					name = L["Springfur Alpaca"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"],
					min = 1, max = 10, step = 1,
					arg = "iconChoice",
					order = 4,
				},
				iconChoiceSpecial = {
					type = "range",
					name = L["Gersahl Greens"],
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = " 
							..L["Cogwheel"] .."\n9 = " ..L["Screw"],
					min = 1, max = 9, step = 1,
					arg = "iconChoiceSpecial",
					order = 5,
				},
			},
		},
	},
}

function HandyNotes_SpringfurAlpaca_OnAddonCompartmentClick( addonName, buttonName )
	if buttonName and buttonName == "RightButton" then
		OpenWorldMap( 1527 )
		if WorldMapFrame:IsVisible() ~= true then
			print( ns.colour.prefix	..L["Springfur Alpaca"] ..": " ..ns.colour.plaintext ..L["Try later"] )
		end
	else
		Settings.OpenToCategory( "HandyNotes" )
		LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "SpringfurAlpaca" )
	end
end
 
function HandyNotes_SpringfurAlpaca_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( DropDownList1, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..L["Springfur Alpaca"] )
	GameTooltip:AddLine( ns.colour.highlight .." " )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..L["Left"], ns.colour.plaintext ..L["Options"] )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..L["Right"], ns.colour.plaintext ..L["Uldum Map"] )
	GameTooltip:Show()
end

function HandyNotes_SpringfurAlpaca_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	HandyNotes:RegisterPluginDB("SpringfurAlpaca", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_SpringfurAlpacaDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "SpringfurAlpaca")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_SpringfurAlpacaDB", "AceEvent-3.0")