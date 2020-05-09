-- ####################################################################
-- ##                          Static Data                           ##
-- ####################################################################

-- The zones in which the addon is active.
RTN.target_zones = {
    [1355] = true,
}

-- NPCs that are banned during shard detection.
-- Player followers sometimes spawn with the wrong zone id.
RTN.banned_NPC_ids = {
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
RTN.rare_ids = {
	152415, -- "Alga the Eyeless"
	152416, -- "Allseer Oma'kil"
	152794, -- "Amethyst Spireshell"
	152566, -- "Anemonar"
	150191, -- "Avarius"
	152361, -- "Banescale the Packfather"
	152712, -- "Blindlight"
	149653, -- "Carnivorous Lasher"
	152464, -- "Caverndark Terror"
	152556, -- "Chasm-Haunter"
	152756, -- "Daggertooth Terror"
	152291, -- "Deepglider"
	152414, -- "Elder Unu"
	152555, -- "Elderspawn Nalaada"
	65090, -- "Fabious"
	152553, -- "Garnetscale"
	152448, -- "Iridescent Glimmershell"
	152567, -- "Kelpwillow"
	152323, -- "King Gakula"
	144644, -- "Mirecrawler"
	152465, -- "Needlespine"
	152397, -- "Oronu"
	152681, -- "Prince Typhonus"
	152682, -- "Prince Vortran"
	150583, -- "Rockweed Shambler"
	151870, -- "Sandcastle"
	152795, -- "Sandclaw Stoneshell"
	152548, -- "Scale Matriarch Gratinax"
	152545, -- "Scale Matriarch Vynara"
	152542, -- "Scale Matriarch Zodia"
	152552, -- "Shassera"
	153658, -- "Shiz'narasz the Consumer"
	152359, -- "Siltstalker the Packmother"
	152290, -- "Soundless"
	153898, -- "Tidelord Aquatus"
	153928, -- "Tidelord Dispersius"
	154148, -- "Tidemistress Leth'sindra"
	152360, -- "Toxigore the Alpha"
	152568, -- "Urduu"
	151719, -- "Voice in the Deeps"
	150468, -- "Vor'koth"
}

RTN.rare_ids_set = Set(RTN.rare_ids)

-- Get the rare names in the correct localization.
RTN.localization = GetLocale()
RTN.rare_names = {}

if RTN.localization == "deDE" then
    -- The names to be displayed in the frames and general chat messages for German localization.
    RTN.rare_names = {
        [152415] = "Alga der Augenlose",
        [152416] = "Allseher Oma'kil",
        [152794] = "Amethystspindelschnecke",
        [152566] = "Anemonar",
        [150191] = "Avarius",
        [152361] = "Fluchschuppe der Rudelvater",
        [152712] = "Blindlicht",
        [149653] = "Fleischfressender Peitscher",
        [152464] = "Höhlendunkelschrecken",
        [152556] = "Schluchtschatten",
        [152756] = "Dolchzahnschrecken",
        [152291] = "Tiefengleiter",
        [152414] = "Ältester Unu",
        [152555] = "Brutälteste von Nalaada",
        [65090] = "Fabius",
        [152553] = "Granatschuppe",
        [152448] = "Schillernde Schimmerschale",
        [152567] = "Tangwurz",
        [152323] = "König Gakula",
        [144644] = "Schlammkriecher",
        [152465] = "Nadelstachel",
        [152397] = "Oronu",
        [152681] = "Prinz Typhonus",
        [152682] = "Prinz Vortran",
        [150583] = "Felskrautschlurfer",
        [151870] = "Sandburg",
        [152795] = "Sandscherensteinpanzer",
        [152548] = "Schuppenmatriarchin Gratinax",
        [152545] = "Schuppenmatriarchin Vynara",
        [152542] = "Schuppenmatriarchin Zodia",
        [152552] = "Shassera",
        [153658] = "Shiz'narasz der Verschlinger",
        [152359] = "Schlickpirsch die Rudelmutter",
        [152290] = "Lautlos",
        [153898] = "Gezeitenlord Aquatus",
        [153928] = "Gezeitenlord Dispersius",
        [154148] = "Gezeitenherrin Leth'sindra",
        [152360] = "Toxigore der Alpha",
        [152568] = "Urduu",
        [151719] = "Stimme in den Tiefen",
        [150468] = "Vor'koth",
    }
elseif RTN.localization == "frFR" then
    RTN.rare_names = {
        [152415] = "Alga l’Aveugle",
        [152794] = "Escargot spiralé améthyste",
        [152361] = "Pestécaille le Père de la meute",
        [152464] = "Terreur de la grotte sombre",
        [152756] = "Terreur daguedent",
        [152414] = "Ancien Unu",
        [152553] = "Ecaille-Grenat",
        [152567] = "Saulicorne",
        [144644] = "Rampebourbe",
        [152397] = "Oronu",
        [152682] = "Prince Vortran",
        [151870] = "Sablon",
        [152548] = "Matriarche des écailles Gratinax",
        [152542] = "Matriarche des écailles Zodia",
        [153658] = "Shiz’narasz le Dévoreur",
        [152290] = "Le grand Silence",
        [153928] = "Seigneur-marées Dispersius",
        [152360] = "Toxisang l’alpha",
        [151719] = "Voix des Profondeurs",
        [152416] = "Omnivoyant Oma’kil",
        [152566] = "Anémonar",
        [152712] = "Lumenoir",
        [152556] = "Hante-Gouffre",
        [152291] = "Ondule-Abysse",
        [152555] = "Engeancien Nalaada",
        [152448] = "Carapace-luisante iridescent",
        [152323] = "Roi Gakula",
        [152465] = "Pointépine",
        [152681] = "Prince Typhonus",
        [150583] = "Traînard algueroche",
        [152795] = "Carapierre pince-sable",
        [152545] = "Matriarche des écailles Vynara",
        [152552] = "Shassera",
        [152359] = "Traquevase la Mère de la meute",
        [153898] = "Seigneur-marées Aquatus",
        [154148] = "Maîtresse des marées Leth’sindra",
        [152568] = "Urduu",
        [150191] = "Avarius",
        [65090] = "Fabulicieux",
        [149653] = "Flagellant carnivore",
        [150468] = "Vor'koth",
    }
elseif RTN.localization == "esES" or RTN.localization == "esMX" then
    RTN.rare_names = {
        [152415] = "Alga Sinojo",
        [152794] = "Valvabucle amatista",
        [152361] = "Escamazote, Padre de la Manada",
        [152464] = "Terror de cuevaoscura",
        [152756] = "Terror Faucedaga",
        [152414] = "Ancestro Unu",
        [152553] = "Escamagrana",
        [152567] = "Coralalga",
        [144644] = "Reptalodazal",
        [152397] = "Oronu",
        [152682] = "Príncipe Vortran",
        [151870] = "Castillo de arena",
        [152548] = "Matriarca de escamas Gratinax",
        [152542] = "Matriarca de escamas Zodia",
        [153658] = "Shiz'narasz el Insaciable",
        [152290] = "Silente",
        [153928] = "Señor de las mareas Dispersius",
        [152360] = "Toxígoro el Alfa",
        [151719] = "Voz de las profundidades",
        [152416] = "Omnividente Oma'kil",
        [152566] = "Anémonar",
        [152712] = "Ciegaluz",
        [152556] = "Vagante de la sima",
        [152291] = "Deslizadora de las profundidades",
        [152555] = "Engendro anciano Nalaada",
        [152448] = "Brillavalva iridiscente",
        [152323] = "Rey Gakula",
        [152465] = "Espina afilada",
        [152681] = "Príncipe Typhonus",
        [150583] = "Arrastrapiés algarroca",
        [152795] = "Petravalva garrarena",
        [152545] = "Matriarca de escamas Vynara",
        [152552] = "Shassera",
        [152359] = "Acechalodo, Madre de la Manada",
        [153898] = "Señor de las mareas Aquatus",
        [154148] = "Maestra de las mareas Leth'sindra",
        [152568] = "Urduu",
        [150191] = "Avarius",
        [65090] = "Fabius",
        [149653] = "Azotador carnívoro",
        [150468] = "Vor'koth",
    }
elseif RTN.localization == "itIT" then
    RTN.rare_names = {
        [152415] = "Algar il Senzocchi",
        [152794] = "Gusciospira d'Ametista",
        [152361] = "Tormentasquame il Padre del Branco",
        [152464] = "Terrore di Cavatetra",
        [152756] = "Terrore Zannaguzza",
        [152414] = "Anziano Unu",
        [152553] = "Scagliavermiglia",
        [152567] = "Corallice Piangente",
        [144644] = "Solcapantano",
        [152397] = "Oronu",
        [152682] = "Principe Vortran",
        [151870] = "Castello di Sabbia",
        [152548] = "Matriarca delle Scaglie Gratinax",
        [152542] = "Matriarca delle Scaglie Zodia",
        [153658] = "Shiz'narasz il Consumatore",
        [152290] = "Silente",
        [153928] = "Signore delle Maree Dispersius",
        [152360] = "Sanguetossico l'Alfa",
        [151719] = "Voce degli Abissi",
        [152416] = "Onniveggente Oma'kil",
        [152566] = "Anemonar",
        [152712] = "Torvaluce",
        [152556] = "Infestatore del Baratro",
        [152291] = "Planafondali",
        [152555] = "Nalaada la Vetusta",
        [152448] = "Brillaguscio Iridescente",
        [152323] = "Re Gakula",
        [152465] = "Spinago",
        [152681] = "Principe Tifonus",
        [150583] = "Errante delle Alghe Rocciose",
        [152795] = "Scorzasalda Sferzasabbia",
        [152545] = "Matriarca delle Scaglie Vynara",
        [152552] = "Shassera",
        [152359] = "Cercalimo la Madre del Branco",
        [153898] = "Signore delle Maree Acquatus",
        [154148] = "Signora delle Maree Leth'sindra",
        [152568] = "Urduu",
        [150191] = "Avarius",
        [65090] = "Favolus",
        [149653] = "Pianta Sferzante Carnivora",
        [150468] = "Vor'koth",
    }
elseif RTN.localization == "ptPT" or RTN.localization == "ptBR" then
    RTN.rare_names = {
        [152415] = "Alga, o Caolho",
        [152794] = "Concha-espiral de Ametista",
        [152361] = "Escamaligna, o Pai do Bando",
        [152464] = "Horror da Caverna Escura",
        [152756] = "Horror Dente-de-adaga",
        [152414] = "Ancião Unu",
        [152553] = "Escama-granada",
        [152567] = "Salgueiralga",
        [144644] = "Rastalama",
        [152397] = "Oronu",
        [152682] = "Príncipe Vortran",
        [151870] = "Castelo de Areia",
        [152548] = "Matriarca Escamosa Gratinax",
        [152542] = "Matriarca Escamosa Zodia",
        [153658] = "Shiz'narasz, o Consumidor",
        [152290] = "Silente",
        [153928] = "Senhor da Maré Dispersius",
        [152360] = "Brutóxico, o Alfa",
        [151719] = "Voz das Profundezas",
        [152416] = "Onividente Oma'kil",
        [152566] = "Anemonar",
        [152712] = "Cegalume",
        [152556] = "Assombração do Abismo",
        [152291] = "Deslizáguas",
        [152555] = "Nalaada, a Cria dos Antigos",
        [152448] = "Coruscasca Iridescente",
        [152323] = "Rei Gakula",
        [152465] = "Espinagulha",
        [152681] = "Príncipe Typhonus",
        [150583] = "Trôpego Rochierva",
        [152795] = "Litocasco Garrareia",
        [152545] = "Matriarca Escamosa Vynara",
        [152552] = "Shassera",
        [152359] = "Espreitalimo, a Mãe do Bando",
        [153898] = "Senhor da Maré Aquatus",
        [154148] = "Senhora das Marés Leth'sindra",
        [152568] = "Urduu",
        [150191] = "Avarius",
        [65090] = "Fábulus, o Cavalo-magia",
        [149653] = "Açoitadeira Carnívora",
        [150468] = "Vor'koth",
    }
elseif RTN.localization == "ruRU" then
    RTN.rare_names = {
        [152415] = "Алга Безглазая",
        [152794] = "Аметистовая спиральная улитка",
        [152361] = "Гиблочешуй Отец Стаи",
        [152464] = "Ужас из пещерной тьмы",
        [152756] = "Иглозубый ужас",
        [152414] = "Старейшина Уну",
        [152553] = "Гранатопанцирная черепаха",
        [152567] = "Глубинная ива",
        [144644] = "Ильный ползун",
        [152397] = "Орону",
        [152682] = "Принц Торнадий",
        [151870] = "Песочнище",
        [152548] = "Матриарх Гратина",
        [152542] = "Матриарх Зодия",
        [153658] = "Шиз'нараж Поглотитель",
        [152290] = "Неслышимка",
        [153928] = "Повелитель приливов Испарий",
        [152360] = "Вожак стаи Ядоклык",
        [151719] = "Голос-в-Глубинах",
        [152416] = "Всевидящий Ома'кил",
        [152566] = "Анемонар",
        [152712] = "Темносвет",
        [152556] = "Ужас морских расселин",
        [152291] = "Крыло Глубин",
        [152555] = "Налаада Древняя",
        [152448] = "Переливчатый тусклопанцирный рак",
        [152323] = "Король Гакула",
        [152465] = "Острошипчик",
        [152681] = "Принц Тайфуний",
        [150583] = "Поросший водорослями бродяга",
        [152795] = "Песчаный панцирный краб",
        [152545] = "Матриарх Винара",
        [152552] = "Шассира",
        [152359] = "Донная Охотница",
        [153898] = "Повелитель приливов Акварий",
        [154148] = "Владычица Приливов Лет'синдра",
        [152568] = "Урдуу",
        [150191] = "Аварий",
        [65090] = "Чудний",
        [149653] = "Плотоядный плеточник",
        [150468] = "Вор'кот",
    }
elseif RTN.localization == "zhCN" then
    -- The names to be displayed in the frames and general chat messages for Simplified Chinese localization.
    RTN.rare_names = {
        [152415] = "无目的阿尔加",
        [152416] = "全视者奥玛基尔",
        [152794] = "紫晶尖壳蜗牛",
        [152566] = "阿尼莫纳",
        [150191] = "阿法留斯",
        [152361] = "巢父灾鳞",
        [152712] = "盲光",
        [149653] = "食肉鞭笞者",
        [152464] = "窟晦恐蟹",
        [152556] = "裂谷萦绕者",
        [152756] = "刀齿恐鱼",
        [152291] = "深渊滑行者",
        [152414] = "长者乌努",
        [152555] = "古裔纳拉达",
        [65090] = "法比乌斯",
        [152553] = "榴鳞",
        [152448] = "虹光烁壳蟹",
        [152567] = "柳藻",
        [152323] = "加库拉大王",
        [144644] = "深泽爬行者",
        [152465] = "针脊",
        [152397] = "奥洛努",
        [152681] = "泰丰努斯亲王",
        [152682] = "沃特兰亲王",
        [150583] = "岩草蹒跚者",
        [151870] = "沙堡",
        [152795] = "沙爪岩壳蟹",
        [152548] = "鳞母格拉提纳克丝",
        [152545] = "鳞母薇娜拉",
        [152542] = "鳞母佐迪亚",
        [152552] = "夏瑟拉",
        [153658] = "吞噬者席兹纳拉斯",
        [152359] = "巢母逐沙者",
        [152290] = "无声者",
        [153898] = "海潮领主阿库图斯",
        [153928] = "海潮领主迪斯派修斯",
        [154148] = "潮汐主母莱丝辛德拉",
        [152360] = "“头领”毒血",
        [152568] = "乌尔杜",
        [151719] = "深渊之声",
        [150468] = "沃科斯",
    }
elseif RTN.localization == "koKR" then
    RTN.rare_names = {
        [152415] = "눈이 먼 알가",
        [152794] = "자수정 돌돌껍질",
        [152361] = "떼아비 악독비늘",
        [152464] = "어둠동굴 공포",
        [152756] = "단도이빨 공포광치",
        [152414] = "장로 우누",
        [152553] = "심홍비늘",
        [152567] = "물풀버들",
        [144644] = "수렁 바다달팽이",
        [152397] = "오로누",
        [152682] = "왕자 보르트란",
        [151870] = "모래성",
        [152548] = "비늘 여군주 그라티낙스",
        [152542] = "비늘 여군주 조디아",
        [153658] = "소멸자 쉬즈나라스",
        [152290] = "한깊가오리",
        [153928] = "바다군주 디스퍼시우스",
        [152360] = "우두머리 맹독이빨",
        [151719] = "심연의 목소리",
        [152416] = "선지자 오마킬",
        [152566] = "아네모나르",
        [152712] = "유리비늘",
        [152556] = "수렁 귀신뱀",
        [152291] = "심해가오리",
        [152555] = "원로생명체 날라아다",
        [152448] = "오색 반짝껍질",
        [152323] = "왕 가쿨라",
        [152465] = "바늘가시",
        [152681] = "왕자 타이포너스",
        [150583] = "바위물풀 비틀괴물",
        [152795] = "모래집게 돌딱지",
        [152545] = "비늘 여군주 바이나라",
        [152552] = "샤시라",
        [152359] = "떼어미 진흙추적꾼",
        [153898] = "바다군주 아쿠아투스",
        [154148] = "해일여제 레스신드라",
        [152568] = "우르두우",
        [150191] = "아바리우스",
        [65090] = "재사용",
        [149653] = "육식 덩굴손",
        [150468] = "보르코스",
    }
else
    RTN.rare_names = {
        [152415] = "Alga the Eyeless",
        [152416] = "Allseer Oma'kil",
        [152794] = "Amethyst Spireshell",
        [152566] = "Anemonar",
        [150191] = "Avarius",
        [152361] = "Banescale the Packfather",
        [152712] = "Blindlight",
        [149653] = "Carnivorous Lasher",
        [152464] = "Caverndark Terror",
        [152556] = "Chasm-Haunter",
        [152756] = "Daggertooth Terror",
        [152291] = "Deepglider",
        [152414] = "Elder Unu",
        [152555] = "Elderspawn Nalaada",
        [65090] = "Fabious",
        [152553] = "Garnetscale",
        [152448] = "Iridescent Glimmershell",
        [152567] = "Kelpwillow",
        [152323] = "King Gakula",
        [144644] = "Mirecrawler",
        [152465] = "Needlespine",
        [152397] = "Oronu",
        [152681] = "Prince Typhonus",
        [152682] = "Prince Vortran",
        [150583] = "Rockweed Shambler",
        [151870] = "Sandcastle",
        [152795] = "Sandclaw Stoneshell",
        [152548] = "Scale Matriarch Gratinax",
        [152545] = "Scale Matriarch Vynara",
        [152542] = "Scale Matriarch Zodia",
        [152552] = "Shassera",
        [153658] = "Shiz'narasz the Consumer",
        [152359] = "Siltstalker the Packmother",
        [152290] = "Soundless",
        [153898] = "Tidelord Aquatus",
        [153928] = "Tidelord Dispersius",
        [154148] = "Tidemistress Leth'sindra",
        [152360] = "Toxigore the Alpha",
        [152568] = "Urduu",
        [151719] = "Voice in the Deeps",
        [150468] = "Vor'koth",
    }
end

-- Overrides for display names of rares that are too long.
local rare_display_name_overwrites = {}

rare_display_name_overwrites["enUS"] = {}
rare_display_name_overwrites["enGB"] = {}
rare_display_name_overwrites["itIT"] = {
    [152361] = "Tormentasquame il Padre",
}

rare_display_name_overwrites["frFR"] = {}
rare_display_name_overwrites["zhCN"] = {}
rare_display_name_overwrites["zhTW"] = {}
rare_display_name_overwrites["koKR"] = {}
rare_display_name_overwrites["deDE"] = {}
rare_display_name_overwrites["esES"] = {}
rare_display_name_overwrites["esMX"] = rare_display_name_overwrites["esES"]
rare_display_name_overwrites["ptPT"] = {}
rare_display_name_overwrites["ptBR"] = rare_display_name_overwrites["ptPT"]
rare_display_name_overwrites["ruRU"] = {
    [152448] = "Переливчатый тусклопанцирный",    
}

RTN.rare_display_names = {}
for key, value in pairs(RTN.rare_names) do
    if rare_display_name_overwrites[RTN.localization][key] then
        RTN.rare_display_names[key] = rare_display_name_overwrites[RTN.localization][key]
    else
        RTN.rare_display_names[key] = value
    end
end

-- The quest ids that indicate that the rare has been killed already.
RTN.completion_quest_ids = {
    [152415] = 56279, -- "Alga the Eyeless"
    [152416] = 56280, -- "Allseer Oma'kil"
    [152794] = 56268, -- "Amethyst Spireshell"
    [152566] = 56281, -- "Anemonar"
    [150191] = 55584, -- "Avarius"
    [152361] = 56282, -- "Banescale the Packfather"
    [152712] = 56269, -- "Blindlight"
    [149653] = 55366, -- "Carnivorous Lasher"
    [152464] = 56283, -- "Caverndark Terror"
    [152556] = 56270, -- "Chasm-Haunter"
    [152756] = 56271, -- "Daggertooth Terror"
    [152291] = 56272, -- "Deepglider"
    [152414] = 56284, -- "Elder Unu"
    [152555] = 56285, -- "Elderspawn Nalaada"
    [152553] = 56273, -- "Garnetscale"
    [152448] = 56286, -- "Iridescent Glimmershell"
    [152567] = 56287, -- "Kelpwillow"
    [152323] = 55671, -- "King Gakula"
    [144644] = 56274, -- "Mirecrawler"
    [152465] = 56275, -- "Needlespine"
    [152397] = 56288, -- "Oronu"
    [152681] = 56289, -- "Prince Typhonus"
    [152682] = 56290, -- "Prince Vortran"
    [150583] = 56291, -- "Rockweed Shambler"
    [151870] = 56276, -- "Sandcastle"
    [152795] = 56277, -- "Sandclaw Stoneshell"
    [152548] = 56292, -- "Scale Matriarch Gratinax"
    [152545] = 56293, -- "Scale Matriarch Vynara"
    [152542] = 56294, -- "Scale Matriarch Zodia"
    [152552] = 56295, -- "Shassera"
    [153658] = 56296, -- "Shiz'narasz the Consumer"
    [152359] = 56297, -- "Siltstalker the Packmother"
    [152290] = 56298, -- "Soundless"
    [153898] = 56122, -- "Tidelord Aquatus"
    [153928] = 56123, -- "Tidelord Dispersius"
    [154148] = 56106, -- "Tidemistress Leth'sindra"
    [152360] = 56278, -- "Toxigore the Alpha"
    [152568] = 56299, -- "Urduu"
    [151719] = 56300, -- "Voice in the Deeps"
    [150468] = 55603, -- "Vor'koth"
}

RTN.completion_quest_inverse = {
    [56279] = {152415},
    [56280] = {152416},
    [56268] = {152794},
    [56281] = {152566},
    [55584] = {150191},
    [56282] = {152361},
    [56269] = {152712},
    [55366] = {149653},
    [56283] = {152464},
    [56270] = {152556},
    [56271] = {152756},
    [56272] = {152291},
    [56284] = {152414},
    [56285] = {152555},
    [56273] = {152553},
    [56286] = {152448},
    [56287] = {152567},
    [55671] = {152323},
    [56274] = {144644},
    [56275] = {152465},
    [56288] = {152397},
    [56289] = {152681},
    [56290] = {152682},
    [56291] = {150583},
    [56276] = {151870},
    [56277] = {152795},
    [56292] = {152548},
    [56293] = {152545},
    [56294] = {152542},
    [56295] = {152552},
    [56296] = {153658},
    [56297] = {152359},
    [56298] = {152290},
    [56122] = {153898},
    [56123] = {153928},
    [56106] = {154148},
    [56278] = {152360},
    [56299] = {152568},
    [56300] = {151719},
    [55603] = {150468},
}

-- A set of placeholder icons, which will be used if the rare location is not yet known.
RTN.rare_coordinates = {}