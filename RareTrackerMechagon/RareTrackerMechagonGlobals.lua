-- Redefine often used functions locally.
local GetLocale = GetLocale

-- ####################################################################
-- ##                          Static Data                           ##
-- ####################################################################

-- The zones in which the addon is active.
RTM.target_zones = {
    [1462] = true,
    [1522] = true,
}

-- NPCs that are banned during shard detection.
-- Player followers sometimes spawn with the wrong zone id.
RTM.banned_NPC_ids = {
    [154297] = true,
    [150202] = true,
    [154304] = true,
    [152108] = true,
    [151300] = true,
    [151310] = true,
    [69792] = true,
    [62821] = true,
    [62822] = true,
    [32639] = true,
    [32638] = true,
    [89715] = true,
}

-- Simulate a set data structure for efficient existence lookups.
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

-- The ids of the rares the addon monitors.
RTM.rare_ids = {
	151934, -- "Arachnoid Harvester"
	154342, -- "Arachnoid Harvester (F)"
	--150394, -- "Armored Vaultbot"
	151308, -- "Boggac Skullbash"
	153200, -- "Boilburn"
	152001, -- "Bonepicker"
	154739, -- "Caustic Mechaslime"
	152570, -- "Crazed Trogg (Blue)"
	152569, -- "Crazed Trogg (Green)"
	149847, -- "Crazed Trogg (Orange)"
	151569, -- "Deepwater Maw"
	--155060, -- "Doppel Ganger"
	150342, -- "Earthbreaker Gulroc"
	154153, -- "Enforcer KX-T57"
	151202, -- "Foul Manifestation"
	135497, -- "Fungarian Furor"
	153228, -- "Gear Checker Cogstar"
	153205, -- "Gemicide"
	154701, -- "Gorged Gear-Cruncher"
	151684, -- "Jawbreaker"
	152007, -- "Killsaw"
	151933, -- "Malfunctioning Beastbot"
	151124, -- "Mechagonian Nullifier"
	151672, -- "Mecharantula"
	8821909, -- "Mecharantula (F)"
	151627, -- "Mr. Fixthis"
	153206, -- "Ol' Big Tusk"
	151296, -- "OOX-Avenger/MG"
	152764, -- "Oxidized Leachbeast"
	151702, -- "Paol Pondwader"
	150575, -- "Rumblerocks"
	152182, -- "Rustfeather"
	155583, -- "Scrapclaw"
	150937, -- "Seaspit"
	153000, -- "Sparkqueen P'Emp"
	153226, -- "Steel Singer Freza"
	152113, -- "The Kleptoboss"
	154225, -- "The Rusty Prince (F)"
	151623, -- "The Scrap King (M)"
	151625, -- "The Scrap King"
	151940, -- "Uncle T'Rogg"
}

-- Create a table, such that we can look up a rare in constant time.
RTM.rare_ids_set = Set(RTM.rare_ids)

-- Get the rare names in the correct localization.
RTM.localization = GetLocale()
RTM.rare_names = {}

if RTM.localization == "enUS" or RTM.localization == "enGB" then
    -- The names to be displayed in the frames and general chat messages for the English localizations.
    RTM.rare_names = {
        [151934] = "Arachnoid Harvester",
        [154342] = "Arachnoid Harvester (F)",
        [155060] = "Doppel Ganger",
        [152113] = "The Kleptoboss (CC88)",
        [154225] = "The Rusty Prince (F)",
        [151623] = "The Scrap King (M)",
        [151625] = "The Scrap King",
        [151940] = "Uncle T'Rogg",
        [150394] = "Armored Vaultbot",
        [153200] = "Boilburn (JD41)",
        [151308] = "Boggac Skullbash",
        [152001] = "Bonepicker",
        [154739] = "Caustic Mechaslime (CC73)",
        [149847] = "Crazed Trogg (Orange)",
        [152569] = "Crazed Trogg (Green)",
        [152570] = "Crazed Trogg (Blue)",
        [151569] = "Deepwater Maw",
        [150342] = "Earthbreaker Gulroc (TR35)",
        [154153] = "Enforcer KX-T57",
        [151202] = "Foul Manifestation",
        [135497] = "Fungarian Furor",
        [153228] = "Gear Checker Cogstar",
        [153205] = "Gemicide (JD99)",
        [154701] = "Gorged Gear-Cruncher (CC61)",
        [151684] = "Jawbreaker",
        [152007] = "Killsaw",
        [151933] = "Malfunctioning Beastbot",
        [151124] = "Mechagonian Nullifier",
        [151672] = "Mecharantula",
        [8821909] = "Mecharantula (F)",
        [151627] = "Mr. Fixthis",
        [151296] = "OOX-Avenger/MG",
        [153206] = "Ol' Big Tusk (TR28)",
        [152764] = "Oxidized Leachbeast",
        [151702] = "Paol Pondwader",
        [150575] = "Rumblerocks",
        [152182] = "Rustfeather",
        [155583] = "Scrapclaw",
        [150937] = "Seaspit",
        [153000] = "Sparkqueen P'Emp",
        [153226] = "Steel Singer Freza",
        [152932] = "Razak Ironsides",
    }
elseif RTM.localization == "deDE" then
    -- The names to be displayed in the frames and general chat messages for the German localization.
    RTM.rare_names = {
        [151934] = "Arachnoider Ernter",
        [154342] = "Arachnoider Ernter (F)",
        [155060] = "Doppelgänger",
        [152113] = "Der Kleptoboss (CC88)",
        [154225] = "Der rostige Prinz (F)",
        [151623] = "Der Schrottkönig (M)",
        [151625] = "Der Schrottkönig",
        [151940] = "Onkel T'Rogg",
        [150394] = "Panzertresorbot",
        [153200] = "Siedebrand (JD41)",
        [151308] = "Boggac Schädelrums",
        [152001] = "Knochenpicker",
        [154739] = "Ätzender Mechaschleim (CC73)",
        [149847] = "Wahnsinniger Trogg (Orange)",
        [152569] = "Wahnsinniger Trogg (Grün)",
        [152570] = "Wahnsinniger Trogg (Blau)",
        [151569] = "Tiefseeschlund",
        [150342] = "Erdbrecher Gulroc (TR35)",
        [154153] = "Vollstrecker KX-T57",
        [151202] = "Üble Manifestation",
        [135497] = "Fungianischer Furor",
        [153228] = "Getriebeprüfer Radstern",
        [153205] = "Splitterzid (JD99)",
        [154701] = "Vollgefressener Ritzelknabberer (CC61)",
        [151684] = "Kieferbrecher",
        [152007] = "Todessäge",
        [151933] = "Defekter Gorillabot",
        [151124] = "Mechagonischer Nullifizierer",
        [151672] = "Mecharantel",
        [8821909] = "Mecharantel (F)",
        [151627] = "Herr Richter",
        [151296] = "OOX-Rächer/MG",
        [153206] = "Alter Großhauer (TR28)",
        [152764] = "Oxidierte Egelbestie",
        [151702] = "Paol Teichwandler",
        [150575] = "Rumpelfels",
        [152182] = "Rostfeder",
        [155583] = "Schrottklaue",
        [150937] = "Seespuck",
        [153000] = "Funkenkönigin P'Emp",
        [153226] = "Stahlsängerin Freza",
        [152932] = "Razak Eisenflanke",
    }
elseif RTM.localization == "frFR" then
    -- The names to be displayed in the frames and general chat messages for the French localization.
    RTM.rare_names = {
        [151934] = "Arachnoïde moissonneur",
        [154342] = "Arachnoïde moissonneur (F)",
        [155060] = "Sosie",
        [152113] = "Le Cleptoboss (CC88)",
        [154225] = "Le Prince de la rouille (F)",
        [151623] = "Le roi-boulon (M)",
        [151625] = "Le roi-boulon",
        [151940] = "Oncle T'Rogg",
        [150394] = "Robot-coffre blindé",
        [153200] = "Brûlebouille (JD41)",
        [151308] = "Boggac Cogne-Crâne",
        [152001] = "Croc'os",
        [154739] = "Mécagelée caustique (CC73)",
        [149847] = "Trogg affolé (Orange)",
        [152569] = "Trogg affolé (Vert)",
        [152570] = "Trogg affolé (Bleu)",
        [151569] = "Gueule des eaux profondes",
        [150342] = "Brise-terre Gulroc (TR35)",
        [154153] = "Massacreur KX-T57",
        [151202] = "Manifestation infâme",
        [135497] = "Fongicien furieux",
        [153228] = "Pignonologue Clétoile",
        [153205] = "Gemmicide (JD99)",
        [154701] = "Croque-écrou gavé (CC61)",
        [151684] = "Mâchebrise",
        [152007] = "Autopscie",
        [151933] = "Robot-bête défectueux",
        [151124] = "Annulateur mécagonien",
        [151672] = "Mécatarentule",
        [8821909] = "Mécatarentule (F)",
        [151627] = "M. Réparetout",
        [151296] = "Vengeur-OOX/MG",
        [153206] = "Vieux Grande-Défense (TR28)",
        [152764] = "Lixiviaure oxydé",
        [151702] = "Paol Pêchemare",
        [150575] = "Gronderoche",
        [152182] = "Rouille-Plume",
        [155583] = "Récupince",
        [150937] = "Bruinemer",
        [153000] = "Électreine P’omp",
        [153226] = "Chante-acier Freza",
        [152932] = "Razak Côtefer",
    }
elseif RTM.localization == "esES" or RTM.localization == "esMX" then
    -- The names to be displayed in the frames and general chat messages for the Spanish localizations.
    RTM.rare_names = {
        [151934] = "Cosechadora arácnida",
        [154342] = "Cosechadora arácnida (F)",
        [155060] = "Doble",
        [152113] = "El Cleptojefe (CC88)",
        [154225] = "El príncipe oxidado (F)",
        [151623] = "El rey de la chatarra (M)",
        [151625] = "El rey de la chatarra",
        [151940] = "Tío T'Rogg",
        [150394] = "Roboarcón acorazado",
        [153200] = "Ardequema (JD41)",
        [151308] = "Boggac Hundecráneos",
        [152001] = "Limpiahuesos",
        [154739] = "Mecababosa cáustica (CC73)",
        [149847] = "Trogg enloquecido (Naranja)",
        [152569] = "Trogg enloquecido (Verde)",
        [152570] = "Trogg enloquecido (Azul)",
        [151569] = "Fauce Aguahonda",
        [150342] = "Rompesuelos Gulroc (TR35)",
        [154153] = "Déspota KX-T57",
        [151202] = "Manifestación nauseabunda",
        [135497] = "Furor fúngico",
        [153228] = "Pruebachismes Dientestrella",
        [153205] = "Gemicida (JD99)",
        [154701] = "Mascaengranajes atiborrado (CC61)",
        [151684] = "Desgarracaras",
        [152007] = "Sierrasesina",
        [151933] = "Bestia robot estropeada",
        [151124] = "Nulificador de Mecandria",
        [151672] = "Mecatarántula",
        [8821909] = "Mecatarántula (F)",
        [151627] = "Sr. Apaño",
        [151296] = "OOX-Vengador/MG",
        [153206] = "Viejo Colmillón (TR28)",
        [152764] = "Bestia lixiviadora oxidada",
        [151702] = "Paol Vadeaestanques",
        [150575] = "Embrollarrocas",
        [152182] = "Alarroña",
        [155583] = "Garrachatarra",
        [150937] = "Escupemar",
        [153000] = "Chisparreina P'Emp",
        [153226] = "Cantoacero Freza",
        [152932] = "Michael Razak",
    }
elseif RTM.localization == "itIT" then
    -- The names to be displayed in the frames and general chat messages for the Italian localization.
    RTM.rare_names = {
        [151934] = "Raccoglitore Aracnoide",
        [154342] = "Raccoglitore Aracnoide (F)",
        [155060] = "Clone",
        [152113] = "Il Cleptoboss (CC88)",
        [154225] = "Il Principe Arrugginito (F)",
        [151623] = "Re degli Scarti (M)",
        [151625] = "Re degli Scarti",
        [151940] = "Zio T'rogg",
        [150394] = "Robobanca Corazzata",
        [153200] = "Bruciatura Ribollente (JD41)",
        [151308] = "Boggac Spaccacrani",
        [152001] = "Stuzzicaossa",
        [154739] = "Meccamelma Caustica (CC73)",
        [149847] = "Trogg Frenetico (Acancio)",
        [152569] = "Trogg Frenetico (Verde)",
        [152570] = "Trogg Frenetico (Blu)",
        [151569] = "Fauce Acquafonda",
        [150342] = "Spaccaterra Gulroc (TR35)",
        [154153] = "Agente KX-T57",
        [151202] = "Manifestazione Vile",
        [135497] = "Fungariano Furioso",
        [153228] = "Controllore Sgranastelle",
        [153205] = "Gemmicida (JD99)",
        [154701] = "Tritaviti Rimpinzato (CC61)",
        [151684] = "Rompifauci",
        [152007] = "Squarciamorte",
        [151933] = "Robobestia Malfunzionante",
        [151124] = "Abolitore Meccagoniano",
        [151672] = "Meccanantola",
        [151627] = "Ser Aggiustatutto",
        [8821909] = "Ser Aggiustatutto (F)",
        [151296] = "OOX-Vendicatore/MG",
        [153206] = "Vecchio Zannone (TR28)",
        [152764] = "Percolabestia Ossidata",
        [151702] = "Paol Acquastagna",
        [150575] = "Tuonarocce",
        [152182] = "Piumaruggine",
        [155583] = "Scartachela",
        [150937] = "Sputaspuma",
        [153000] = "Regina delle Scintille M'IEM",
        [153226] = "Cantacciaio Freza",
        [152932] = "Razak Rico",
    }
elseif RTM.localization == "ptPT" or RTM.localization == "ptBR" then
    -- The names to be displayed in the frames and general chat messages for the Portuguese localizations.
    RTM.rare_names = {
        [151934] = "Ceifador Aracnídeo",
        [154342] = "Ceifador Aracnídeo (F)",
        [155060] = "Doppel Gângster",
        [152113] = "O Cleptochefe (CC88)",
        [154225] = "O Príncipe Ferrugem (F)",
        [151623] = "O Rei da Sucata (M)",
        [151625] = "O Rei da Sucata",
        [151940] = "Tio T'rogg",
        [150394] = "Cofremático Blindado",
        [153200] = "Queimadura de Óleo (JD41)",
        [151308] = "Brejac Broca-crânio",
        [152001] = "Limpa-osso",
        [154739] = "Mecavisgo Cáustico (CC73)",
        [149847] = "Trogg Enlouquecido (Laranja)",
        [152569] = "Trogg Enlouquecido (Verde)",
        [152570] = "Trogg Enlouquecido (Azul)",
        [151569] = "Bocarra de Águas Profundas",
        [150342] = "Rompe-terra Gulroc (TR35)",
        [154153] = "Impositor KX-T57",
        [151202] = "Manifestação Atroz",
        [135497] = "Furor Fungoriano",
        [153228] = "Inspetor de Engrenagens Multifresa",
        [153205] = "Gemocida (JD99)",
        [154701] = "Esmaga-engrenagens Empanturrado (CC61)",
        [151684] = "Quebra-queixo",
        [152007] = "Serra Mortífera",
        [151933] = "Bichômato Defeituoso",
        [151124] = "Nulificador Gnomecânico",
        [151672] = "Mecarântula",
        [8821909] = "Mecarântula (F)",
        [151627] = "Sr. Quebragalho",
        [151296] = "OOX-Vingadora/MG",
        [153206] = "Colmilhão Velho (TR28)",
        [152764] = "Monstro-peneira Oxidado",
        [151702] = "Paol Chafurdágua",
        [150575] = "Troapedras",
        [152182] = "Ferrujão",
        [155583] = "Pinçucata",
        [150937] = "Gota-do-mar",
        [153000] = "Rainha Fagulhosa Pem'P",
        [153226] = "Freza Canora de Aço",
        [152932] = "Razak Ladoférreo",
    }
elseif RTM.localization == "ruRU" then
    -- The names to be displayed in the frames and general chat messages for the Russian localization.
    RTM.rare_names = {
        [151934] = "Арахноид-пожинатель",
        [154342] = "Арахноид-пожинатель (F)",
        [155060] = "Двойник",
        [152113] = "Клептобосс (CC88)",
        [154225] = "Ржавый принц (F)",
        [151623] = "Король-над-свалкой (M)",
        [151625] = "Король-над-свалкой",
        [151940] = "Дядюшка Т'Рогг",
        [150394] = "Бронированный сейфобот",
        [153200] = "Ошпар (JD41)",
        [151308] = "Боггак Черепокол",
        [152001] = "Костегрыз",
        [154739] = "Едкий механослизень (CC73)",
        [149847] = "Обезумевший трогг (оранжевый)",
        [152569] = "Обезумевший трогг (зеленый)",
        [152570] = "Обезумевший трогг (синий)",
        [151569] = "Глубоководный пожиратель",
        [150342] = "Землекрушитель Гулрок (TR35)",
        [154153] = "Каратель KX-T57",
        [151202] = "Гнусноструй",
        [135497] = "Грозный грибостраж",
        [153228] = "Инспектор экипировки Искраддон",
        [153205] = "Драгоцид (JD99)",
        [154701] = "Прожорливый пожиратель шестеренок (CC61)",
        [151684] = "Зубодробитель",
        [152007] = "Циркулятор",
        [151933] = "Неисправный гориллобот",
        [151124] = "Мехагонский нейтрализатор",
        [151672] = "Мехарантул",
        [8821909] = "Мехарантул (F)",
        [151627] = "Господин Починятор",
        [151296] = "КПХ-Мститель/МГ",
        [153206] = "Старина Бивень (TR28)",
        [152764] = "Порождение сточной жижи",
        [151702] = "Паол Пруд-по-колено",
        [150575] = "Маховище",
        [152182] = "Ржавое Перо",
        [155583] = "Хламокоготь",
        [150937] = "Солеплюй",
        [153000] = "Паучиха на прокачку",
        [153226] = "Певица стали Фреза",
        [152932] = "Разак Сковородкер",
    }
elseif RTM.localization == "zhCN" then
    -- The names to be displayed in the frames and general chat messages for the Chinese (zhCN) localization.
    RTM.rare_names = {
        [151934] = "蜘蛛收割者",
        [154342] = "蜘蛛收割者 (平行)",
        [155060] = "同行者",
        [152113] = "防窃者首领 (CC88)",
        [154225] = "锈痕王子 (平行)",
        [151623] = "废铁之王 (一阶段)",
        [151625] = "废铁之王",
        [151940] = "阿叔提罗格",
        [150394] = "重装保险柜机",
        [153200] = "燃沸 (JD41)",
        [151308] = "波加克·砸颅",
        [152001] = "剔骨者",
        [154739] = "腐蚀性的机甲软泥 (CC73)",
        [149847] = "疯狂的穴居人 (橙色)",
        [152569] = "疯狂的穴居人 (绿色)",
        [152570] = "疯狂的穴居人 (蓝色)",
        [151569] = "深水之喉",
        [150342] = "碎地者高洛克 (TR35)",
        [154153] = "执行者KX-T57",
        [151202] = "污秽具象",
        [135497] = "真菌人狂热者",
        [153228] = "齿轮检查者齿星",
        [153205] = "宝石粉碎者 (JD99)",
        [154701] = "饱食的齿轮啮咬者 (CC61)",
        [151684] = "断腭者",
        [152007] = "夺命锯士",
        [151933] = "失控的机械兽",
        [151124] = "麦卡贡中和者",
        [151672] = "机甲狼蛛",
        [151627] = "阿修先生",
        [8821909] = "阿修先生 (平行)",
        [151296] = "OOX-复仇者/MG",
        [153206] = "老獠 (TR28)",
        [152764] = "氧化沥兽",
        [151702] = "鲍尔·涉塘者",
        [150575] = "震岩",
        [152182] = "锈羽",
        [155583] = "废爪",
        [150937] = "唾海",
        [153000] = "火花女王皮恩普",
        [153226] = "钢铁歌手弗莉萨",
        [152932] = "拉沙克·铁墙",
    }
elseif RTM.localization == "zhTW" then
    -- The names to be displayed in the frames and general chat messages for the Taiwanese localization.
    RTM.rare_names = {
        [151934] = "Arachnoid Harvester",
        [154342] = "Arachnoid Harvester (F)",
        [155060] = "Doppel Ganger",
        [152113] = "The Kleptoboss (CC88)",
        [154225] = "The Rusty Prince (F)",
        [151623] = "The Scrap King (M)",
        [151625] = "The Scrap King",
        [151940] = "Uncle T'Rogg",
        [150394] = "Armored Vaultbot",
        [153200] = "Boilburn (JD41)",
        [151308] = "Boggac Skullbash",
        [152001] = "Bonepicker",
        [154739] = "Caustic Mechaslime (CC73)",
        [149847] = "Crazed Trogg (Orange)",
        [152569] = "Crazed Trogg (Green)",
        [152570] = "Crazed Trogg (Blue)",
        [151569] = "Deepwater Maw",
        [150342] = "Earthbreaker Gulroc (TR35)",
        [154153] = "Enforcer KX-T57",
        [151202] = "Foul Manifestation",
        [135497] = "Fungarian Furor",
        [153228] = "Gear Checker Cogstar",
        [153205] = "Gemicide (JD99)",
        [154701] = "Gorged Gear-Cruncher (CC61)",
        [151684] = "Jawbreaker",
        [152007] = "Killsaw",
        [151933] = "Malfunctioning Beastbot",
        [151124] = "Mechagonian Nullifier",
        [151672] = "Mecharantula",
        [8821909] = "Mecharantula (F)",
        [151627] = "Mr. Fixthis",
        [151296] = "OOX-Avenger/MG",
        [153206] = "Ol' Big Tusk (TR28)",
        [152764] = "Oxidized Leachbeast",
        [151702] = "Paol Pondwader",
        [150575] = "Rumblerocks",
        [152182] = "Rustfeather",
        [155583] = "Scrapclaw",
        [150937] = "Seaspit",
        [153000] = "Sparkqueen P'Emp",
        [153226] = "Steel Singer Freza",
        [152932] = "Razak Ironsides",
    }
elseif RTM.localization == "koKR" then
    -- The names to be displayed in the frames and general chat messages for the Korean localization.
    RTM.rare_names = {
        [151934] = "포획꾼 기계거미",
        [154342] = "포획꾼 기계거미 (F)",
        [155060] = "분신 로봇",
        [152113] = "고철모이왕 (CC88)",
        [154225] = "녹슨 왕자 (F)",
        [151623] = "고철왕 (M)",
        [151625] = "고철왕",
        [151940] = "트로그 삼촌",
        [150394] = "무장한 금고봇",
        [153200] = "부글앗뜨 (JD41)",
        [151308] = "뽀각 스컬배쉬",
        [152001] = "뼈다귀청소부",
        [154739] = "부식성 기계수액 (CC73)",
        [149847] = "광기 어린 트로그 (주황색)",
        [152569] = "광기 어린 트로그 (채색)",
        [152570] = "광기 어린 트로그 (푸른)",
        [151569] = "깊은물 아귀괴수",
        [150342] = "대지파괴자 걸록 (TR35)",
        [154153] = "집행자 KX-T57",
        [151202] = "부정한 현신",
        [135497] = "광란의 버섯",
        [153228] = "장비 검수자 코그스타",
        [153205] = "보석사 거미 (JD99)",
        [154701] = "게걸스러운 기계포식자 (CC61)",
        [151684] = "턱파괴자",
        [152007] = "살해톱",
        [151933] = "고장난 야수로봇",
        [151124] = "메카곤식 종결자",
        [151672] = "메카란툴라",
        [8821909] = "메카란툴라 (F)",
        [151627] = "고쳐줘 씨",
        [151296] = "OOX-복수자/MG",
        [153206] = "늙은 왕엄니 (TR28)",
        [152764] = "산화된 갈취짐승",
        [151702] = "파올 폰드웨이더",
        [150575] = "우레바위",
        [152182] = "녹슨깃털",
        [155583] = "고철집게발",
        [150937] = "바다모래톱",
        [153000] = "불꽃여왕 전파거미",
        [153226] = "강철 노래꾼 프레자",
        [152932] = "라자크 아이언사이즈",
    }
end

-- Overrides for display names of rares that are too long.
local rare_display_name_overwrites = {}

rare_display_name_overwrites["enUS"] = {}
rare_display_name_overwrites["enGB"] = {}
rare_display_name_overwrites["itIT"] = {}
rare_display_name_overwrites["frFR"] = {}
rare_display_name_overwrites["zhCN"] = {}
rare_display_name_overwrites["zhTW"] = {}
rare_display_name_overwrites["koKR"] = {}

rare_display_name_overwrites["deDE"] = {
    [154701] = "Ritzelknabberer (CC61)",
}

rare_display_name_overwrites["esES"] = {
    [154701] = "Mascaengranajes (CC61)",
}
rare_display_name_overwrites["esMX"] = rare_display_name_overwrites["esES"]

rare_display_name_overwrites["ptPT"] = {
    [153228] = "Inspetor de Engrenagens",
    [154701] = "Esmaga Empanturrado (CC61)",
}
rare_display_name_overwrites["ptBR"] = rare_display_name_overwrites["ptPT"]

rare_display_name_overwrites["ruRU"] = {
    [154701] = "шестеренок (CC61)",
    [153228] = "Инспектор Искраддон",
}

RTM.rare_display_names = {}
for key, value in pairs(RTM.rare_names) do
    if rare_display_name_overwrites[RTM.localization][key] then
        RTM.rare_display_names[key] = rare_display_name_overwrites[RTM.localization][key]
    else
        RTM.rare_display_names[key] = value
    end
end

-- The quest ids that indicate that the rare has been killed already.
RTM.completion_quest_ids = {
    [151934] = 55512, -- "Arachnoid Harvester"
    [154342] = 55512, -- "Arachnoid Harvester (F)"
    [155060] = 56419, -- "Doppel Ganger"
    [152113] = 55858, -- "The Kleptoboss"
    [154225] = 56182, -- "The Rusty Prince (F)"
    [151623] = 55364, -- "The Scrap King (M)"
    [151625] = 55364, -- "The Scrap King"
    [151940] = 55538, -- "Uncle T'Rogg"
    [150394] = 55546, -- "Armored Vaultbot"
    [153200] = 55857, -- "Boilburn"
    [151308] = 55539, -- "Boggac Skullbash"
    [152001] = 55537, -- "Bonepicker"
    [154739] = 56368, -- "Caustic Mechaslime"
    [149847] = 55812, -- "Crazed Trogg (Orange)"
    [152569] = 55812, -- "Crazed Trogg (Green)"
    [152570] = 55812, -- "Crazed Trogg (Blue)"
    [151569] = 55514, -- "Deepwater Maw"
    [150342] = 55814, -- "Earthbreaker Gulroc"
    [154153] = 56207, -- "Enforcer KX-T57"
    [151202] = 55513, -- "Foul Manifestation"
    [135497] = 55367, -- "Fungarian Furor"
    [153228] = 55852, -- "Gear Checker Cogstar"
    [153205] = 55855, -- "Gemicide"
    [154701] = 56367, -- "Gorged Gear-Cruncher"
    [151684] = 55399, -- "Jawbreaker"
    [152007] = 55369, -- "Killsaw"
    [151933] = 55544, -- "Malfunctioning Beastbot"
    [151124] = 55207, -- "Mechagonian Nullifier"
    [151672] = 55386, -- "Mecharantula"
    [8821909] = 55386, -- "Mecharantula"
    [151627] = 55859, -- "Mr. Fixthis"
    [151296] = 55515, -- "OOX-Avenger/MG"
    [153206] = 55853, -- "Ol' Big Tusk"
    [152764] = 55856, -- "Oxidized Leachbeast"
    [151702] = 55405, -- "Paol Pondwader"
    [150575] = 55368, -- "Rumblerocks"
    [152182] = 55811, -- "Rustfeather"
    [155583] = 56737, -- "Scrapclaw"
    [150937] = 55545, -- "Seaspit"
    [153000] = 55810, -- "Sparkqueen P'Emp"
    [153226] = 55854, -- "Steel Singer Freza"
}

RTM.completion_quest_inverse = {
    [55512] = {151934, 154342},
    [56419] = {155060},
    [55858] = {152113},
    [56182] = {154225},
    [55364] = {151623, 151625},
    [55538] = {151940},
    [55546] = {150394},
    [55857] = {153200},
    [55539] = {151308},
    [55537] = {152001},
    [56368] = {154739},
    [55812] = {149847, 152569, 152570},
    [55514] = {151569},
    [55814] = {150342},
    [56207] = {154153},
    [55513] = {151202},
    [55367] = {135497},
    [55852] = {153228},
    [55855] = {153205},
    [56367] = {154701},
    [55399] = {151684},
    [55369] = {152007},
    [55544] = {151933},
    [55207] = {151124},
    [55386] = {151672, 8821909},
    [55859] = {151627},
    [55515] = {151296},
    [55853] = {153206},
    [55856] = {152764},
    [55405] = {151702},
    [55368] = {150575},
    [55811] = {152182},
    [56737] = {155583},
    [55545] = {150937},
    [55810] = {153000},
    [55854] = {153226},
}

-- Certain npcs have yell emotes to announce their arrival.
local yell_announcing_rares = {
    [151934] = 151934, -- "Arachnoid Harvester"
    [151625] = 151623, -- "The Scrap King"
    [151940] = 151940, -- "Uncle T'Rogg",
    [151308] = 151308, -- "Boggac Skullbash"
    [153228] = 153228, -- "Gear Checker Cogstar"
    [151124] = 151124, -- "Mechagonian Nullifier"
    [151296] = 151296, -- "OOX-Avenger/MG"
    [150937] = 150937, -- "Seaspit"
    [152932] = 153000, -- "Sparkqueen P'Emp, announced by Razak Ironsides"
}

-- Concert the ids above to the names.
RTM.yell_announcing_rares = {}
for key, value in pairs(yell_announcing_rares) do
    RTM.yell_announcing_rares[RTM.rare_names[key]] = value
end

-- Link drill codes to their respective entities.
RTM.drill_announcing_rares = {
    ["CC88"] = 152113,
    ["JD41"] = 153200,
    ["CC73"] = 154739,
    ["TR35"] = 150342,
    ["JD99"] = 153205,
    ["CC61"] = 154701,
    ["TR28"] = 153206,
}

-- A set of placeholder icons, which will be used if the rare location is not yet known.
RTM.rare_coordinates = {
    [151934]  = {["x"] = 52.86, ["y"] = 40.94}, -- "Arachnoid Harvester"
    [154342]  = {["x"] = 52.86, ["y"] = 40.94}, -- "Arachnoid Harvester (F)"
    [155060]  = {["x"] = 80.96, ["y"] = 20.19}, -- "Doppel Ganger"
    [152113]  = {["x"] = 68.40, ["y"] = 48.14}, -- "The Kleptoboss (CC88)"
    [154225]  = {["x"] = 57.34, ["y"] = 58.30}, -- "The Rusty Prince (F)"
    [151623]  = {["x"] = 72.13, ["y"] = 50.00}, -- "The Scrap King (M)"
    [151625]  = {["x"] = 72.13, ["y"] = 50.00}, -- "The Scrap King"
    [151940]  = {["x"] = 58.13, ["y"] = 22.16}, -- "Uncle T'Rogg"
    [150394]  = {["x"] = 53.26, ["y"] = 50.08}, -- "Armored Vaultbot"
    [153200]  = {["x"] = 51.24, ["y"] = 50.21}, -- "Boilburn (JD41)"
    [151308]  = {["x"] = 55.52, ["y"] = 25.37}, -- "Boggac Skullbash"
    [152001]  = {["x"] = 65.57, ["y"] = 24.18}, -- "Bonepicker"
    [154739]  = {["x"] = 31.27, ["y"] = 86.14}, -- "Caustic Mechaslime (CC73)"
    [149847]  = {["x"] = 82.53, ["y"] = 20.78}, -- "Crazed Trogg (Orange)"
    [152569]  = {["x"] = 82.53, ["y"] = 20.78}, -- "Crazed Trogg (Green)"
    [152570]  = {["x"] = 82.53, ["y"] = 20.78}, -- "Crazed Trogg (Blue)"
    [151569]  = {["x"] = 35.03, ["y"] = 42.53}, -- "Deepwater Maw"
    [150342]  = {["x"] = 63.24, ["y"] = 25.43}, -- "Earthbreaker Gulroc (TR35)"
    [154153]  = {["x"] = 55.34, ["y"] = 55.16}, -- "Enforcer KX-T57"
    [151202]  = {["x"] = 65.69, ["y"] = 51.85}, -- "Foul Manifestation"
    -- [135497] -- "Fungarian Furor"
    -- [153228] -- "Gear Checker Cogstar"
    [153205]  = {["x"] = 59.58, ["y"] = 67.34}, -- "Gemicide (JD99)"
    [154701]  = {["x"] = 77.97, ["y"] = 50.28}, -- "Gorged Gear-Cruncher (CC61)"
    [151684]  = {["x"] = 77.23, ["y"] = 44.74}, -- "Jawbreaker"
    -- [152007] -- "Killsaw"
    [151933]  = {["x"] = 60.68, ["y"] = 42.11}, -- "Malfunctioning Beastbot"
    [151124]  = {["x"] = 57.16, ["y"] = 52.57}, -- "Mechagonian Nullifier"
    [151672]  = {["x"] = 87.98, ["y"] = 20.81}, -- "Mecharantula"
    [8821909] = {["x"] = 87.98, ["y"] = 20.81}, -- "Mecharantula (F)"
    [151627]  = {["x"] = 61.03, ["y"] = 60.97}, -- "Mr. Fixthis"
    [151296]  = {["x"] = 57.16, ["y"] = 39.46}, -- "OOX-Avenger/MG"
    [153206]  = {["x"] = 56.21, ["y"] = 36.25}, -- "Ol' Big Tusk (TR28)"
    [152764]  = {["x"] = 55.77, ["y"] = 60.05}, -- "Oxidized Leachbeast"
    [151702]  = {["x"] = 22.67, ["y"] = 68.75}, -- "Paol Pondwader"
    [150575]  = {["x"] = 39.49, ["y"] = 53.46}, -- "Rumblerocks"
    [152182]  = {["x"] = 66.04, ["y"] = 79.20}, -- "Rustfeather"
    [155583]  = {["x"] = 82.46, ["y"] = 77.55}, -- "Scrapclaw"
    [150937]  = {["x"] = 19.39, ["y"] = 80.33}, -- "Seaspit"
    [153000]  = {["x"] = 81.64, ["y"] = 22.13}, -- "Sparkqueen P'Emp"
    [153226]  = {["x"] = 25.61, ["y"] = 77.30}, -- "Steel Singer Freza"
}