-- Redefine often used functions locally.
local GetLocale = GetLocale

-- ####################################################################
-- ##                          Static Data                           ##
-- ####################################################################

-- The zones in which the addon is active.
RTV.target_zones = {
    [1530] = true,
    [1579] = true,
}
RTV.parent_zone = 1530

-- NPCs that are banned during shard detection.
-- Player followers sometimes spawn with the wrong zone id.
RTV.banned_NPC_ids = {
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
RTV.rare_ids = {
    160825, -- "Amber-Shaper Esh'ri"
    157466, -- "Anh-De the Loyal"
    154447, -- "Brother Meller"
    160878, -- "Buh'gzaki the Blasphemous"
    160893, -- "Captain Vor'lek"
    154467, -- "Chief Mek-mek"
    157183, -- "Coagulated Anima"
    159087, -- "Corrupted Bonestripper"
    154559, -- "Deeplord Zrihj"
    160872, -- "Destroyer Krox'tazar"
    157287, -- "Dokani Obliterator"
    160874, -- "Drone Keeper Ak'thet"
    160876, -- "Enraged Amber Elemental"
    157267, -- "Escaped Mutation"
    157153, -- "Ha-Li"
    160810, -- "Harbinger Il'koxik"
    160868, -- "Harrier Nir'verash"
    157171, -- "Heixi the Stonelord"
    160826, -- "Hive-Guard Naz'ruzek"
    157160, -- "Houndlord Ren"
    160930, -- "Infused Amber Ooze"
    160968, -- "Jade Colossus"
    157290, -- "Jade Watcher"
    160920, -- "Kal'tik the Blight"
    157266, -- "Kilxl the Gaping Maw"
    160867, -- "Kzit'kovok"
    160922, -- "Needler Zhesalla"
    154106, -- "Quid"
    157162, -- "Rei Lun"
    154490, -- "Rijz'x the Devourer"
    156083, -- "Sanguifang"
    160906, -- "Skiver"
    157291, -- "Spymaster Hul'ach"
    157279, -- "Stormhowl"
    155958, -- "Tashara"
    154600, -- "Teng the Awakened"
    157176, -- "The Forgotten"
    157468, -- "Tisiphon"
    154394, -- "Veskan the Fallen"
    154332, -- "Voidtender Malketh"
    154495, -- "Will of N'Zoth"
    157443, -- "Xiln the Mountain"
    154087, -- "Zror'um the Infinite"
}

-- Create a table, such that we can look up a rare in constant time.
RTV.rare_ids_set = Set(RTV.rare_ids)

-- Group rares by the assaults they are active in.
-- Notes: used the values found in the HandyNotes_VisionsOfNZoth addon.
RTV.assault_rare_ids = {
    [3155826] = Set({ -- West (MAN)
        160825,
        160878,
        160893,
        160872,
        160874,
        160876,
        160810,
        160868,
        160826,
        160930,
        160920,
        160867,
        160922,
        157468,
        160906, -- "Skiver"
    }),
    [3155832] = Set({ -- Mid (MOG)
        157466,
        157183,
        157287,
        157153,
        157171,
        157160,
        160968,
        157290,
        157162,
        156083,
        157291,
        157279,
        155958,
        154600,
        157468,
        157443,
        160906, -- "Skiver"
    }),
    [3155841] = Set({ -- East (EMP)
        154447,
        154467,
        154559,
        157267,
        157266,
        154106,
        154490,
        157176,
        157468,
        154394,
        154332,
        154495,
        154087,
        159087, -- "Corrupted Bonestripper"
        160906, -- "Skiver"
    })
}

-- Get the rare names in the correct localization.
RTV.localization = GetLocale()
RTV.rare_names = {}

if RTV.localization == "frFR" then
    -- The names to be displayed in the frames and general chat messages for the French localization.
    RTV.rare_names = {
        [160825] = "Sculpte-ambre Esh'ri",
        [157466] = "Anh De le Loyal",
        [154447] = "Frère Meller",
        [160878] = "Buh'gzaki le Blasphémateur",
        [160893] = "Capitaine Vor'lek",
        [154467] = "Chef Mek-mek",
        [157183] = "Anima coagulée",
        [159087] = "Gratte-les-os corrompu",
        [154559] = "Seigneur des profondeurs Zrihj",
        [160872] = "Destructeur Krox'tazar",
        [157287] = "Oblitérateur dokani",
        [160874] = "Garde-bourdons Ak'thet",
        [160876] = "Elémentaire d'ambre enragé",
        [157267] = "Mutant évadé",
        [157153] = "Ha Li",
        [160810] = "Messager Il'koxik",
        [160868] = "Traqueur Nir'verash",
        [157171] = "Heixi le Seigneur de pierre",
        [160826] = "Garde-ruche Naz'ruzek",
        [157160] = "Grand-veneur Ren",
        [160930] = "Limon d'ambre imprégné",
        [160968] = "Colosse de jade",
        [157290] = "Guetteur de jade",
        [160920] = "Kal'tik le Chancre",
        [157266] = "Kilxl la Gueule béante",
        [160867] = "Kzit'kovok",
        [160922] = "Piqueur Zhesalla",
        [154106] = "Quid",
        [157162] = "Rei Lun",
        [154490] = "Rijz'x le Dévoreur",
        [156083] = "Croc-Sanglant",
        [160906] = "Cossard",
        [157291] = "Maître-espion Hul'ach",
        [157279] = "Tempête-hurlante",
        [155958] = "Tashara",
        [154600] = "Teng l'Eveillé",
        [157176] = "L'Oubliée",
        [157468] = "Tisiphon",
        [154394] = "Veskan le Déchu",
        [154332] = "Porteur du Vide Malketh",
        [154495] = "Volonté de N'Zoth",
        [157443] = "Xiln la Montagne",
        [154087] = "Zror'um l'Infini",
    }
elseif RTV.localization == "deDE" then
    -- The names to be displayed in the frames and general chat messages for the German localization.
    RTV.rare_names = {
        [160825] = "Bernformer Esh'ri",
        [157466] = "Anh-De der Loyale",
        [154447] = "Bruder Meller",
        [160878] = "Buh'gzaki der Blasphemiker",
        [160893] = "Hauptmann Vor'lek",
        [154467] = "Häuptling Mek-mek",
        [157183] = "Geronnene Anima",
        [159087] = "Verderbter Knochenhäuter",
        [154559] = "Tiefenfürst Zrihj",
        [160872] = "Zerstörer Krox'tazar",
        [157287] = "Auslöscher der Dokani",
        [160874] = "Drohnenhüter Ak'thet",
        [160876] = "Wütender Bernelementar",
        [157267] = "Entflohene Mutation",
        [157153] = "Ha-Li",
        [160810] = "Herold Il'koxik",
        [160868] = "Hetzer Nir'verash",
        [157171] = "Heixi der Steinfürst",
        [160826] = "Stockwache Naz'ruzek",
        [157160] = "Hundmeister Ren",
        [160930] = "Durchströmter Bernschlamm",
        [160968] = "Jadekoloss",
        [157290] = "Jadebeobachter",
        [160920] = "Kal'tik der Veröder",
        [157266] = "Kilxl das Klaffende Maul",
        [160867] = "Kzit'kovok",
        [160922] = "Nadler Zhesalla",
        [154106] = "Kwall",
        [157162] = "Rei Lun",
        [154490] = "Rijz'x der Verschlinger",
        [156083] = "Sanguifang",
        [160906] = "Schlitzer",
        [157291] = "Meisterspion Hul'ach",
        [157279] = "Sturmgeheul",
        [155958] = "Tashara",
        [154600] = "Teng der Erweckte",
        [157176] = "Die Vergessenen",
        [157468] = "Tisiphon",
        [154394] = "Veskan der Gefallene",
        [154332] = "Leerenhüter Malketh",
        [154495] = "Wille von N'Zoth",
        [157443] = "Xiln der Berg",
        [154087] = "Zror'um der Unendliche",
    }
elseif RTV.localization == "esES" or RTV.localization == "esMX" then
    -- The names to be displayed in the frames and general chat messages for the Spanish localizations.
    RTV.rare_names = {
        [160825] = "Formador de ámbar Esh'ri",
        [157466] = "Anh-De el Leal",
        [154447] = "Hermano Meller",
        [160878] = "Buh'gzaki el Blasfemo",
        [160893] = "Capitán Vor'lek",
        [154467] = "Jefe Mek-mek",
        [157183] = "Ánima coagulada",
        [159087] = "Limpiahuesos corrupto",
        [154559] = "Señor de las profundidades Zrihj",
        [160872] = "Destructor Krox'tazar",
        [157287] = "Obliterador dokani",
        [160874] = "Vigilante de zánganos Ak'thet",
        [160876] = "Elemental de ámbar iracundo",
        [157267] = "Mutación huida",
        [157153] = "Ha-Li",
        [160810] = "Presagista Il'koxik",
        [160868] = "Hostigador Nir'verash",
        [157171] = "Heixi el Señor Pétreo",
        [160826] = "Guardia de la colmena Naz'ruzek",
        [157160] = "Señor de los canes Ren",
        [160930] = "Moco de ámbar imbuido",
        [160968] = "Coloso de jade",
        [157290] = "Vigía de jade",
        [160920] = "Kal'tik la Plaga",
        [157266] = "Kilxl el Buche Enorme",
        [160867] = "Kzit'kovok",
        [160922] = "Aguijoneador Zhesalla",
        [154106] = "Cadozo",
        [157162] = "Rei Lun",
        [154490] = "Rijz'x el Devorador",
        [156083] = "Colmisangre",
        [160906] = "Picador",
        [157291] = "Maestro de espías Hul'ach",
        [157279] = "Tormenta Aullante",
        [155958] = "Tashara",
        [154600] = "Teng el Despierto",
        [157176] = "Los olvidados",
        [157468] = "Tisiphon",
        [154394] = "Veskan el Caído",
        [154332] = "Cuidavacío Malketh",
        [154495] = "Voluntad de N'Zoth",
        [157443] = "Xiln la Montaña",
        [154087] = "Zror'um el Infinito",
    }
elseif RTV.localization == "itIT" then
    -- The names to be displayed in the frames and general chat messages for the Italian localization.
    RTV.rare_names = {
        [160825] = "Plasmatore d'Ambra Esh'ri",
        [157466] = "Anh-De il Leale",
        [154447] = "Fratello Meller",
        [160878] = "Buh'gzaki il Blasfemo",
        [160893] = "Capitano Vor'lek",
        [154467] = "Capo Mek-Mek",
        [157183] = "Anima Coagulata",
        [159087] = "Strappaossa Corrotto",
        [154559] = "Signore delle Profondità Zrihj",
        [160872] = "Distruttore Krox'tazar",
        [157287] = "Disintegratore Dokani",
        [160874] = "Custode dei Fuchi Ak'thet",
        [160876] = "Elementale dell'Ambra Infuriato",
        [157267] = "Mutazione Fuggita",
        [157153] = "Ha-Li",
        [160810] = "Araldo Il'koxik",
        [160868] = "Proselito Nir'verash",
        [157171] = "Heixi il Signore della Pietra",
        [160826] = "Guardia dell'Alveare Naz'ruzek",
        [157160] = "Signore dei Segugi Ren",
        [160930] = "Melma d'Ambra Infusa",
        [160968] = "Colosso di Giada",
        [157290] = "Guardiano di Giada",
        [160920] = "Kal'tik la Piaga",
        [157266] = "Kilxl Fauci Spalancate",
        [160867] = "Kzit'kovok",
        [160922] = "Pungitore Zhesalla",
        [154106] = "Quid",
        [157162] = "Rei Lun",
        [154490] = "Rijz'x il Divoratore",
        [156083] = "Zannasanguigna",
        [160906] = "Tagliapelli",
        [157291] = "Maestro delle Spie Hul'ach",
        [157279] = "Urlatempesta",
        [155958] = "Tashara",
        [154600] = "Teng il Risvegliato",
        [157176] = "La Dimenticata",
        [157468] = "Tisifon",
        [154394] = "Veskan il Caduto",
        [154332] = "Curatore del Vuoto Malketh",
        [154495] = "Volontà di N'zoth",
        [157443] = "Xiln la Montagna",
        [154087] = "Zror'um l'Infinito",
    }
elseif RTV.localization == "ptPT" or RTV.localization == "ptBR" then
    -- The names to be displayed in the frames and general chat messages for the Portuguese localization.
    RTV.rare_names = {
        [160825] = "Molda-âmbar Esh'ri",
        [157466] = "Anh-De, o Leal",
        [154447] = "Irmão Mello",
        [160878] = "Buh'gzaki, o Blásfemo",
        [160893] = "Capitão Vor'lek",
        [154467] = "Chefe Mek-mek",
        [157183] = "Ânima Coagulada",
        [159087] = "Limpa-osso Corrompido",
        [154559] = "Lorde Profundo Zrihj",
        [160872] = "Destruidor Krox'tazar",
        [157287] = "Obliterador Dokani",
        [160874] = "Guardião de Zangões Ak'thet",
        [160876] = "Elemental de âmbar Enfurecido",
        [157267] = "Mutação Fugida",
        [157153] = "Ha-Li",
        [160810] = "Emissário Il'koxik",
        [160868] = "Tartaranhão Nir'verash",
        [157171] = "Heixi, Senhor da Rocha",
        [160826] = "Guarda-colmeia Naz'ruzek",
        [157160] = "Senhor dos Cães Ren",
        [160930] = "Gosma de Âmbar Infusa",
        [160968] = "Colosso de Jade",
        [157290] = "Vigia de Jade",
        [160920] = "Kal'tik, a Praga",
        [157266] = "Kilxl, a Bocarra",
        [160867] = "Kzit'kovok",
        [160922] = "Agulheira Zhesalla",
        [154106] = "Quid",
        [157162] = "Rei Lun",
        [154490] = "Rijz'x, o Devorador",
        [156083] = "Sanguipresa",
        [160906] = "Skivero",
        [157291] = "Mestre Espião Hul'ach",
        [157279] = "Uivo Tempestuoso",
        [155958] = "Tashara",
        [154600] = "Teng, o Desperto",
        [157176] = "Os Esquecidos",
        [157468] = "Tisiphon",
        [154394] = "Veskan, o Decaído",
        [154332] = "Tratador do Caos Malketh",
        [154495] = "Vontade de N'Zoth",
        [157443] = "Xiln, a Montanha",
        [154087] = "Zror'um, o Infinito",
    }
elseif RTV.localization == "ruRU" then
    -- The names to be displayed in the frames and general chat messages for the Russian localization.
    RTV.rare_names = {
        [160825] = "Ваятель янтаря Эш'ри",
        [157466] = "Анх-Де Верный",
        [154447] = "Брат Меллер",
        [160878] = "Ба'гзаки Кощунствующий",
        [160893] = "Капитан Вор'лек",
        [154467] = "Вождь Мек-Мек",
        [157183] = "Сгустившаяся анима",
        [159087] = "Зараженный костеклюй",
        [154559] = "Повелитель глубин Зридж",
        [160872] = "Разрушитель Крокс'тазар",
        [157287] = "Уничтожитель из клана Докани",
        [160874] = "Хранитель трутней Ак'тет",
        [160876] = "Разъяренный янтарный элементаль",
        [157267] = "Сбежавший мутант",
        [157153] = "Ха-Ли",
        [160810] = "Предвестник Ил'коксик",
        [160868] = "Налетчик Нир'вераш",
        [157171] = "Хэйси Повелитель Камня",
        [160826] = "Страж улья Наз'рузек",
        [157160] = "Мастер-псарь Жэнь",
        [160930] = "Насыщенная янтарная слизь",
        [160968] = "Нефритовый колосс",
        [157290] = "Нефритовый дозорный",
        [160920] = "Кал'тик Болезнетворный",
        [157266] = "Килкзл Зияющая Пасть",
        [160867] = "Кзит'ковок",
        [160922] = "Игольщик Жезалла",
        [154106] = "Склизень",
        [157162] = "Жэй Лунь",
        [154490] = "Риджъз Пожиратель",
        [156083] = "Кровоклык",
        [160906] = "Срезатель",
        [157291] = "Мастер шпионажа Хул'ах",
        [157279] = "Рев Бури",
        [155958] = "Ташара",
        [154600] = "Тэн Пробудившийся",
        [157176] = "Забытая",
        [157468] = "Тисифон",
        [154394] = "Вескан Падший",
        [154332] = "Хранитель Бездны Малькет",
        [154495] = "Воля Н'Зота",
        [157443] = "Зилн Гора",
        [154087] = "Зрор'ум Бесконечный",
    }
elseif RTV.localization == "koKR" then
    -- The names to be displayed in the frames and general chat messages for the Korean localization.
    RTV.rare_names = {
        [160825] = "호박석구체자 에쉬리",
        [157466] = "충성스러운 안디",
        [154447] = "수사 멜러",
        [160878] = "불경한 자 부그자키",
        [160893] = "대장 보를레크",
        [154467] = "족장 멕멕",
        [157183] = "응고된 령",
        [159087] = "타락한 뼈갈이",
        [154559] = "심연군주 지리즈",
        [160872] = "파괴자 크록스타자르",
        [157287] = "도카니 절멸자",
        [160874] = "일꾼지기 아크세트",
        [160876] = "격노한 호박석 정령",
        [157267] = "탈출한 돌연변이",
        [157153] = "하리",
        [160810] = "선구자 일코시크",
        [160868] = "유린날개 니르베라쉬",
        [157171] = "돌군주 헤이시",
        [160826] = "둥지경비병 나즈루제크",
        [157160] = "사냥개군주 렌",
        [160930] = "주입된 호박석 수액",
        [160968] = "비취 거대괴수",
        [157290] = "비취 감시자",
        [160920] = "역병의 칼티크",
        [157266] = "집어삼키는 아귀 카이슬",
        [160867] = "크지트코보크",
        [160922] = "쐐기병 저살라",
        [154106] = "퀴드",
        [157162] = "레이 룬",
        [154490] = "포식자 라이즈스",
        [156083] = "핏빛 송곳니",
        [160906] = "스카이버",
        [157291] = "첩보단장 훌라크",
        [157279] = "폭풍포효",
        [155958] = "타샤라",
        [154600] = "깨어난 자 텐그",
        [157176] = "망각한 자",
        [157468] = "티시폰",
        [154394] = "타락자 베스칸",
        [154332] = "공허지기 말케스",
        [154495] = "느조스의 의지",
        [157443] = "태산 실린",
        [154087] = "무한의 즈로룸",
    }
elseif RTV.localization == "zhCN" then
    -- The names to be displayed in the frames and general chat messages for the Simplified Chinese localization.
    RTV.rare_names = {
        [160825] = "琥珀塑形者艾什利",
        [157466] = "丹心魁麟昂德",
        [154447] = "梅勒修士",
        [160878] = "亵渎者巴格扎基",
        [160893] = "沃雷克队长",
        [154467] = "酋长梅克梅克",
        [157183] = "凝结心能",
        [159087] = "腐化的剔骨者",
        [154559] = "深渊领主兹利基",
        [160872] = "毁灭者寇克斯塔扎",
        [157287] = "多卡尼歼灭者",
        [160874] = "工虫守护者阿克赛特",
        [160876] = "被激怒的琥珀元素",
        [157267] = "逃脱的变异体",
        [157153] = "亥离",
        [160810] = "使徒伊科克西克",
        [160868] = "劫猎者尼尔维拉什",
        [157171] = "岩石领主赫曦",
        [160826] = "虫巢卫士纳兹鲁泽克",
        [157160] = "犬师任衙",
        [160930] = "注能的琥珀软泥怪",
        [160968] = "青玉巨神像",
        [157290] = "玉石护卫",
        [160920] = "凋零的卡尔提克",
        [157266] = "巨喉吉尔希尔",
        [160867] = "克兹特科沃克",
        [160922] = "刺针者泽沙拉",
        [154106] = "浗",
        [157162] = "瑞龙",
        [154490] = "吞噬者里吉兹克斯",
        [156083] = "绯牙",
        [160906] = "切割者",
        [157291] = "间谍大师胡尔阿奇",
        [157279] = "风暴之啸",
        [155958] = "塔沙拉",
        [154600] = "苏醒者滕顾",
        [157176] = "忘却者",
        [157468] = "提希冯",
        [154394] = "堕落者维斯坎",
        [154332] = "愈虚者玛柯斯",
        [154495] = "恩佐斯的意志",
        [157443] = "气壮河山夏凛",
        [154087] = "无穷者兹洛昂",
    }
else
    -- The names to be displayed in the frames and general chat messages for the English localizations.
    RTV.rare_names = {
        [160825] = "Amber-Shaper Esh'ri",
        [157466] = "Anh-De the Loyal",
        [154447] = "Brother Meller",
        [160878] = "Buh'gzaki the Blasphemous",
        [160893] = "Captain Vor'lek",
        [154467] = "Chief Mek-mek",
        [157183] = "Coagulated Anima",
        [159087] = "Corrupted Bonestripper",
        [154559] = "Deeplord Zrihj",
        [160872] = "Destroyer Krox'tazar",
        [157287] = "Dokani Obliterator",
        [160874] = "Drone Keeper Ak'thet",
        [160876] = "Enraged Amber Elemental",
        [157267] = "Escaped Mutation",
        [157153] = "Ha-Li",
        [160810] = "Harbinger Il'koxik",
        [160868] = "Harrier Nir'verash",
        [157171] = "Heixi the Stonelord",
        [160826] = "Hive-Guard Naz'ruzek",
        [157160] = "Houndlord Ren",
        [160930] = "Infused Amber Ooze",
        [160968] = "Jade Colossus",
        [157290] = "Jade Watcher",
        [160920] = "Kal'tik the Blight",
        [157266] = "Kilxl the Gaping Maw",
        [160867] = "Kzit'kovok",
        [160922] = "Needler Zhesalla",
        [154106] = "Quid",
        [157162] = "Rei Lun",
        [154490] = "Rijz'x the Devourer",
        [156083] = "Sanguifang",
        [160906] = "Skiver",
        [157291] = "Spymaster Hul'ach",
        [157279] = "Stormhowl",
        [155958] = "Tashara",
        [154600] = "Teng the Awakened",
        [157176] = "The Forgotten",
        [157468] = "Tisiphon",
        [154394] = "Veskan the Fallen",
        [154332] = "Voidtender Malketh",
        [154495] = "Will of N'Zoth",
        [157443] = "Xiln the Mountain",
        [154087] = "Zror'um the Infinite",
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
rare_display_name_overwrites["deDE"] = {}
rare_display_name_overwrites["esES"] = {}
rare_display_name_overwrites["esMX"] = rare_display_name_overwrites["esES"]
rare_display_name_overwrites["ptPT"] = {}
rare_display_name_overwrites["ptBR"] = rare_display_name_overwrites["ptPT"]
rare_display_name_overwrites["ruRU"] = {}

RTV.rare_display_names = {}
for key, value in pairs(RTV.rare_names) do
    if rare_display_name_overwrites[RTV.localization][key] then
        RTV.rare_display_names[key] = rare_display_name_overwrites[RTV.localization][key]
    else
        RTV.rare_display_names[key] = value
    end
end

-- The quest ids that indicate that the rare has been killed already.
RTV.completion_quest_ids = {
    [160825] = 58300, -- "Amber-Shaper Esh'ri"
    [157466] = 57363, -- "Anh-De the Loyal"
    [154447] = 56237, -- "Brother Meller"
    [160878] = 58307, -- "Buh'gzaki the Blasphemous"
    [160893] = 58308, -- "Captain Vor'lek"
    [154467] = 56255, -- "Chief Mek-mek"
    [157183] = 58296, -- "Coagulated Anima"
    [159087] = 57834, -- "Corrupted Bonestripper"
    [154559] = 56323, -- "Deeplord Zrihj"
    [160872] = 58304, -- "Destroyer Krox'tazar"
    [157287] = 57349, -- "Dokani Obliterator"
    [160874] = 58305, -- "Drone Keeper Ak'thet"
    [160876] = 58306, -- "Enraged Amber Elemental"
    [157267] = 57343, -- "Escaped Mutation"
    [157153] = 57344, -- "Ha-Li"
    [160810] = 58299, -- "Harbinger Il'koxik"
    [160868] = 58303, -- "Harrier Nir'verash"
    [157171] = 57347, -- "Heixi the Stonelord"
    [160826] = 58301, -- "Hive-Guard Naz'ruzek"
    [157160] = 57345, -- "Houndlord Ren"
    [160930] = 58312, -- "Infused Amber Ooze"
    [160968] = 58295, -- "Jade Colossus"
    [157290] = 57350, -- "Jade Watcher"
    [160920] = 58310, -- "Kal'tik the Blight"
    [157266] = 57341, -- "Kilxl the Gaping Maw"
    [160867] = 58302, -- "Kzit'kovok"
    [160922] = 58311, -- "Needler Zhesalla"
    [154106] = 56094, -- "Quid"
    [157162] = 57346, -- "Rei Lun"
    [154490] = 56302, -- "Rijz'x the Devourer"
    [156083] = 56954, -- "Sanguifang"
    [160906] = 58309, -- "Skiver"
    [157291] = 57351, -- "Spymaster Hul'ach"
    [157279] = 57348, -- "Stormhowl"
    [155958] = 58507, -- "Tashara"
    [154600] = 56332, -- "Teng the Awakened"
    [157176] = 57342, -- "The Forgotten"
    [157468] = 57364, -- "Tisiphon"
    [154394] = 56213, -- "Veskan the Fallen"
    [154332] = 56183, -- "Voidtender Malketh"
    [154495] = 56303, -- "Will of N'Zoth"
    [157443] = 57358, -- "Xiln the Mountain"
    [154087] = 56084, -- "Zror'um the Infinite"
}

RTV.completion_quest_inverse = {
    [58300] = {160825}, -- "Amber-Shaper Esh'ri"
    [57363] = {157466}, -- "Anh-De the Loyal"
    [56237] = {154447}, -- "Brother Meller"
    [58307] = {160878}, -- "Buh'gzaki the Blasphemous"
    [58308] = {160893}, -- "Captain Vor'lek"
    [56255] = {154467}, -- "Chief Mek-mek"
    [58296] = {157183}, -- "Coagulated Anima"
    [57834] = {159087}, -- "Corrupted Bonestripper"
    [56323] = {154559}, -- "Deeplord Zrihj"
    [58304] = {160872}, -- "Destroyer Krox'tazar"
    [57349] = {157287}, -- "Dokani Obliterator"
    [58305] = {160874}, -- "Drone Keeper Ak'thet"
    [58306] = {160876}, -- "Enraged Amber Elemental"
    [57343] = {157267}, -- "Escaped Mutation"
    [57344] = {157153}, -- "Ha-Li"
    [58299] = {160810}, -- "Harbinger Il'koxik"
    [58303] = {160868}, -- "Harrier Nir'verash"
    [57347] = {157171}, -- "Heixi the Stonelord"
    [58301] = {160826}, -- "Hive-Guard Naz'ruzek"
    [57345] = {157160}, -- "Houndlord Ren"
    [58312] = {160930}, -- "Infused Amber Ooze"
    [58295] = {160968}, -- "Jade Colossus"
    [57350] = {157290}, -- "Jade Watcher"
    [58310] = {160920}, -- "Kal'tik the Blight"
    [57341] = {157266}, -- "Kilxl the Gaping Maw"
    [58302] = {160867}, -- "Kzit'kovok"
    [58311] = {160922}, -- "Needler Zhesalla"
    [56094] = {154106}, -- "Quid"
    [57346] = {157162}, -- "Rei Lun"
    [56302] = {154490}, -- "Rijz'x the Devourer"
    [56954] = {156083}, -- "Sanguifang"
    [58309] = {160906}, -- "Skiver"
    [57351] = {157291}, -- "Spymaster Hul'ach"
    [57348] = {157279}, -- "Stormhowl"
    [58507] = {155958}, -- "Tashara"
    [56332] = {154600}, -- "Teng the Awakened"
    [57342] = {157176}, -- "The Forgotten"
    [57364] = {157468}, -- "Tisiphon"
    [56213] = {154394}, -- "Veskan the Fallen"
    [56183] = {154332}, -- "Voidtender Malketh"
    [56303] = {154495}, -- "Will of N'Zoth"
    [57358] = {157443}, -- "Xiln the Mountain"
    [56084] = {154087}, -- "Zror'um the Infinite"
}

-- A set of placeholder icons, which will be used if the rare location is not yet known.
RTV.rare_coordinates = {
    [160825] = {["x"] = 20, ["y"] = 75}, -- "Amber-Shaper Esh'ri"
    [157466] = {["x"] = 34, ["y"] = 68}, -- "Anh-De the Loyal"
    [154447] = {["x"] = 57, ["y"] = 41}, -- "Brother Meller"
    [160878] = {["x"] = 6, ["y"] = 70}, -- "Buh'gzaki the Blasphemous"
    [160893] = {["x"] = 6, ["y"] = 64}, -- "Captain Vor'lek"
    [154467] = {["x"] = 81, ["y"] = 65}, -- "Chief Mek-mek"
    [157183] = {["x"] = 19, ["y"] = 68}, -- "Coagulated Anima"
    -- [159087], -- Corrupted Bonestripper
    [154559] = {["x"] = 67, ["y"] = 68}, -- "Deeplord Zrihj"
    [160872] = {["x"] = 27, ["y"] = 67}, -- "Destroyer Krox'tazar"
    [157287] = {["x"] = 42, ["y"] = 57}, -- "Dokani Obliterator"
    [160874] = {["x"] = 12, ["y"] = 41}, -- "Drone Keeper Ak'thet"
    [160876] = {["x"] = 10, ["y"] = 41}, -- "Enraged Amber Elemental"
    [157267] = {["x"] = 45, ["y"] = 45}, -- "Escaped Mutation"
    [157153] = {["x"] = 30, ["y"] = 38}, -- "Ha-Li"
    [160810] = {["x"] = 29, ["y"] = 53}, -- "Harbinger Il'koxik"
    [160868] = {["x"] = 13, ["y"] = 51}, -- "Harrier Nir'verash"
    [157171] = {["x"] = 28, ["y"] = 40}, -- "Heixi the Stonelord"
    [160826] = {["x"] = 20, ["y"] = 61}, -- "Hive-Guard Naz'ruzek"
    [157160] = {["x"] = 12, ["y"] = 31}, -- "Houndlord Ren"
    [160930] = {["x"] = 18, ["y"] = 66}, -- "Infused Amber Ooze"
    [160968] = {["x"] = 17, ["y"] = 12}, -- "Jade Colossus"
    [157290] = {["x"] = 27, ["y"] = 11}, -- "Jade Watcher"
    [160920] = {["x"] = 18, ["y"] = 9}, -- "Kal'tik the Blight"
    [157266] = {["x"] = 46, ["y"] = 59}, -- "Kilxl the Gaping Maw"
    [160867] = {["x"] = 26, ["y"] = 38}, -- "Kzit'kovok"
    [160922] = {["x"] = 15, ["y"] = 37}, -- "Needler Zhesalla"
    [154106] = {["x"] = 90, ["y"] = 46}, -- "Quid"
    [157162] = {["x"] = 22, ["y"] = 12}, -- "Rei Lun"
    [154490] = {["x"] = 64, ["y"] = 52}, -- "Rijz'x the Devourer"
    [156083] = {["x"] = 46, ["y"] = 57}, -- "Sanguifang"
    [160906] = {["x"] = 27, ["y"] = 43}, -- "Skiver"
    [157291] = {["x"] = 18, ["y"] = 38}, -- "Spymaster Hul'ach"
    [157279] = {["x"] = 26, ["y"] = 75}, -- "Stormhowl"
    [155958] = {["x"] = 29, ["y"] = 22}, -- "Tashara"
    [154600] = {["x"] = 47, ["y"] = 64}, -- "Teng the Awakened"
    [157176] = {["x"] = 52, ["y"] = 42}, -- "The Forgotten"
    [157468] = {["x"] = 10, ["y"] = 67}, -- "Tisiphon"
    [154394] = {["x"] = 87, ["y"] = 42}, -- "Veskan the Fallen"
    [154332] = {["x"] = 67, ["y"] = 28}, -- "Voidtender Malketh"
    [154495] = {["x"] = 53, ["y"] = 62}, -- "Will of N'Zoth"
    [157443] = {["x"] = 54, ["y"] = 49}, -- "Xiln the Mountain"
    [154087] = {["x"] = 71, ["y"] = 41}, -- "Zror'um the Infinite"
}