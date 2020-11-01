local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local TS = addon.TradeSkills.Names

if GetLocale() ~= "ruRU" then return end

local continents = { 		-- this gets localized names, also avoids hardcoding them.
	[1] = 12,
	[2] = C_Map.GetMapInfo(12).name,
	[3] = 13,
	[4] = C_Map.GetMapInfo(13).name,
	[5] = 101,
	[6] = C_Map.GetMapInfo(101).name,
	[7] = 113,
	[8] = C_Map.GetMapInfo(113).name,
	[9] = 424,
	[10] = C_Map.GetMapInfo(424).name,
	[11] = 572,
	[12] = C_Map.GetMapInfo(572).name,
	[13] = 619,
	[14] = C_Map.GetMapInfo(619).name,
	[15] = 875,
	[16] = C_Map.GetMapInfo(875).name,
	[17] = 876,
	[18] = C_Map.GetMapInfo(876).name,
};

-- This table contains a list of suggestions to get to the next level of reputation, craft or skill
addon.Suggestions = {

	-- source : http://forums.worldofwarcraft.com/thread.html?topicId=102789457&sid=1
	-- ** Primary professions **
	[TS.TAILORING] = {
		{ 50, "До 50: Рулон льняной ткани" },
		{ 70, "До 70: Льняная сумка" },
		{ 75, "До 75: Усиленная льняная накидка" },
		{ 105, "До 105: Рулон шерсти" },
		{ 110, "До 110: Серая шерстяная рубашка"},
		{ 125, "До 125: Шерстяные наплечники с двойным швом" },
		{ 145, "До 145: Рулон шелка" },
		{ 160, "До 160: Лазурный шелковый капюшон" },
		{ 170, "До 170: Шелковая головная повязка" },
		{ 175, "До 175: Церемониальная белая рубашка" },
		{ 185, "До 185: Рулон магической ткани" },
		{ 205, "До 205: Багровый шелковый жилет" },
		{ 215, "До 215: Багровые шелковые кюлоты" },
		{ 220, "До 220: Черные поножи из магической ткани\nили Черный жилет из магической ткани" },
		{ 230, "До 230: Черные перчатки из магической ткани" },
		{ 250, "До 250: Черная повязка из магической ткани\nили Черные наплечники из магической ткани" },
		{ 260, "До 260: Рулон рунической ткани" },
		{ 275, "До 275: Пояс из рунической ткани" },
		{ 280, "До 280: Сумка из рунической ткани" },
		{ 300, "До 300: Перчатки из рунической ткани" },
		{ 325, "До 325: Рулоны ткани Пустоты\n|cFFFFD700Не продовайте их, пожже они вам понадобятся|r" },
		{ 340, "До 340: Рулоны прочной ткани Пустоты\n|cFFFFD700Не продовайте их, пожже они вам понадобятся|r" },
		{ 350, "До 350: Сапоги из ткани Пустоты\n|cFFFFD700Распылите их на Чародейскую пыль|r" },
		{ 375, "До 375: Рулоны ледяной ткани" },
		{ 380, "До 380: Ледотканые сапоги" },
		{ 395, "До 395: Ледотканый шлем" },
		{ 405, "До 405: Клобук из сумеречной ткани" },
		{ 410, "До 410: Напульсники из сумеречной ткани" },
		{ 415, "До 415: Перчатки из сумеречной ткани" },
		{ 425, "До 425: Иссиня-черная ткань, Лунный тюль, или Чароткань\nСумка из ледяной ткани" },
		{ 450, "До 450: Изготовьте любую вещь для получения очка,\nв зависимости от ваших потребностей" }
	},
	[TS.LEATHERWORKING] = {
		{ 35, "До 35: Накладки из тонкой кожи" },
		{ 55, "До 55: Обработанная легкая шкура" },
		{ 85, "До 85: Тисненые кожаные перчатки" },
		{ 100, "До 100: Тонкий кожаный пояс" },
		{ 120, "До 120: Обработанная средняя шкура" },
		{ 125, "До 125: Тонкий кожаный пояс" },
		{ 150, "До 150: Темный кожаный пояс" },
		{ 160, "До 160: Обработанная тяжелая шкура" },
		{ 170, "До 170: Накладки из толстой кожи" },
		{ 180, "До 180: Мглистые кожаные поножи\nили Штаны стража" },
		{ 195, "До 195: Варварские наплечники" },
		{ 205, "До 205: Мглистые наручи" },
		{ 220, "До 220: Накладки из плотной кожи" },
		{ 225, "До 225: Ночная головная повязка" },
		{ 250, "До 250: Зависит от вашей специализации\nНочная головная повязка/мундир/штаны (сила стихий)\nЖесткая кираса из чешуи скорпида/перчатки (чешуя дракона)\nКомплект из Черепашьего панциря (традиции предков)" },
		{ 260, "До 260: Ночные сапоги" },
		{ 270, "До 270: Гибельные кожаные рукавицы" },
		{ 285, "До 285: Гибельные кожаные наручи" },
		{ 300, "До 300: Гибельная кожаная головная повязка" },
		{ 310, "До 310: Узловатая кожа" },
		{ 320, "До 320: Перчатки дренейского дикаря" },
		{ 325, "До 325: Утолщенные дренейские сапоги" },
		{ 335, "До 335: Толстая узловатая кожа\n|cFFFFD700Не продовайте их, пожже они вам понадобятся" },
		{ 340, "До 340: Утолщенная дренейская безрукавка" },
		{ 350, "До 350: Скверночешуйчатая кираса" },
		{ 375, "До 375: Накладки из борейской кожи" },
		{ 385, "До 385: Арктические сапоги" },
		{ 395, "До 395: Арктический пояс" },
		{ 400, "До 400: Арктические накулачники" },
		{ 405, "До 405: Нерубские накладки для поножей" },
		{ 410, "До 410: Any Черный нагрудник или поножи" },
		{ 425, "До 425: Любую Меховую подкладку\nСумки для профессий" },
		{ 450, "До 450: Изготовте любую вещь для получения очка,\nв зависимости от ваших потребностей" }
	},
	[TS.ENGINEERING] = {
		{ 40, "До 40: Грубое взрывчатое вещество" },
		{ 50, "До 50: Горсть медных винтов" },
		{ 51, "Изготовьте один Тангенциальный вращатель" },
		{ 65, "До 65: Медные трубы" },
		{ 75, "До 75: Грубый огнестрел" },
		{ 95, "До 95: Низкосортное взрывчатое вещество" },
		{ 105, "До 105: Серебряные контакты" },
		{ 120, "До 120: Бронзовые трубкы" },
		{ 125, "До 125: Небольшие бронзовые бомбы" },
		{ 145, "До 145: Тяжелое взрывчатое вещество" },
		{ 150, "До 150: Большие бронзовые бомбы" },
		{ 175, "До 175: Синие, Зеленые или Красные петарды" },
		{ 176, "Изготовьте один Шлицевой гироинструмент" },
		{ 190, "До 190: Твердое взрывчатое вещество" },
		{ 195, "До 195: Большие железные бомбы" },
		{ 205, "До 205: Мифриловые трубы" },
		{ 210, "До 210: Нестабильные пусковые устройства" },
		{ 225, "До 225: Бронебойные мифриловые пули" },
		{ 235, "До 235: Мифриловую обшивку" },
		{ 245, "До 245: Фугасные бомбы" },
		{ 250, "До 250: Мифриловый гиро-патрон" },
		{ 260, "До 260: Концентрированное взрывчатое вещество" },
		{ 290, "До 290: Ториевое устройство" },
		{ 300, "До 300: Ториевые трубы\nили Ториевые патроны (дешевле)" },
		{ 310, "До 310: Обшивка из оскверненного железа,\nГорсть винтов из оскверненного железа,\n и Взрывчатое вещество стихий\n|cFFFFD700Не продовайте их, пожже они вам понадобятся|r" },
		{ 320, "До 320: Бомбы из оскверненного железа" },
		{ 335, "До 335: Мушкеты из оскверненного железа" },
		{ 350, "До 350: Белые дымовые сигнальные ракеты" },
		{ 375, "До 375: Кобальтовые осколочные бомбы" },
		{ 430, "До 430: Детали для набора лечебных(маны) инъекций\nВы будете в них нуждается долгое время" },
		{ 435, "До 435: Детали для набора инъекций маны" },
		{ 450, "До 450: Изготовьте любую вещь для получения очка,\nв зависимости от ваших потребностей" }
	},
	[TS.JEWELCRAFTING] = {
		{ 20, "До 20: Delicate Copper Wire" },
		{ 30, "До 30: Rough Stone Statue" },
		{ 50, "До 50: Tigerseye Band" },
		{ 75, "До 75: Bronze Setting" },
		{ 80, "До 80: Solid Bronze Ring" },
		{ 90, "До 90: Elegant Silver Ring" },
		{ 110, "До 110: Ring of Silver Might" },
		{ 120, "До 120: Heavy Stone Statue" },
		{ 150, "До 150: Pendant of the Agate Shield\nor Golden Dragon Ring" },
		{ 180, "До 180: Mithril Filigree" },
		{ 200, "До 200: Engraved Truesilver Ring" },
		{ 210, "До 210: Citrine Ring of Rapid Healing" },
		{ 225, "До 225: Aquamarine Signet" },
		{ 250, "До 250: Thorium Setting" },
		{ 255, "До 255: Red Ring of Destruction" },
		{ 265, "До 265: Truesilver Healing Ring" },
		{ 275, "До 275: Simple Opal Ring" },
		{ 285, "До 285: Sapphire Signet" },
		{ 290, "До 290: Diamond Focus Ring" },
		{ 300, "До 300: Emerald Lion Ring" },
		{ 310, "До 310: Any green quality gem" },
		{ 315, "До 315: Fel Iron Blood Ring\nor any green quality gem" },
		{ 320, "До 320: Any green quality gem" },
		{ 325, "До 325: Azure Moonstone Ring" },
		{ 335, "До 335: Mercurial Adamantite (required later)\nor any green quality gem" },
		{ 350, "До 350: Heavy Adamantite Ring" },
		{ 355, "До 355: Any blue quality gem" },
		{ 360, "До 360: World drop recipes like:\nLiving Ruby Pendant\nor Thick Felsteel Necklace" },
		{ 365, "До 365: Ring of Arcane Shielding\nThe Sha'tar - Уважение" },
		{ 375, "До 375: Transmute diamonds\nWorld drops (blue quality)\nПочтение с Sha'tar, Honor Hold, Thrallmar" }
	},
	[TS.ENCHANTING] = {
		{ 2, "До 2: Рунический медный жезл" },
		{ 75, "До 75: Чары для наручей - здоровье I" },
		{ 85, "До 85: Чары для наручей - отражение I" },
		{ 100, "До 100: Чары для наручей - выносливость I" },
		{ 101, "Изготовьте один Рунический серебряный жезл" },
		{ 105, "До 105: Чары для наручей - выносливость I" },
		{ 120, "До 120: Большой магический жезл" },
		{ 130, "До 130: Чары для щита - выносливость I" },
		{ 150, "До 150: Чары для наручей - выносливость II" },
		{ 151, "Изготовьте один Рунический золотой жезл" },
		{ 160, "До 160: Чары для наручей - выносливость II" },
		{ 165, "До 165: Чары для щита - выносливость II" },
		{ 180, "До 180: Чары для наручей - дух III" },
		{ 200, "До 200: Чары для наручей - сила III" },
		{ 201, "Изготовьте один Рунический жезл истинного серебра" },
		{ 205, "До 205: Чары для наручей - сила III" },
		{ 225, "До 225: Чары для плаща - защита II" },
		{ 235, "До 235: Чары для перчаток - ловкость I" },
		{ 245, "До 245: Чары для нагрудника - здоровье V" },
		{ 250, "До 250: Чары для наручей - сила IV" },
		{ 270, "До 270: Простое масло маны\nРецепт продается в Силитусе" },
		{ 290, "До 290: Чары для щита - выносливость IV\nили Чары для обуви - выносливость IV" },
		{ 291, "Изготовьте один Рунический арканитовый жезл" },
		{ 300, "До 300: Чары для плаща - защита III" },
		{ 301, "Изготовьте один Рунический жезл из оскверненного железа" },
		{ 305, "До 305: Чары для плаща - защита III" },
		{ 315, "До 315: Чары для наручей - штурм II" },
		{ 325, "До 325: Чары для плаща - броня III\nили Чары для перчаток - штурм I" },
		{ 335, "До 335: Чары для нагрудника - дух" },
		{ 340, "До 340: Чары для щита - выносливость V" },
		{ 345, "До 345: Превосходное волшебное масло\nИзготавливайте до 350, если у вас есть достаточно матерьяла" },
		{ 350, "До 350: Чары для перчаток - сила III" },
		{ 351, "Изготовьте один Рунический адамантитовый жезл" },
		{ 360, "До 360: Чары для перчаток - сила III" },
		{ 370, "До 370: Чары для перчаток - точные удары\nТребуется Почтение с Кенарийской экспедицией" },
		{ 375, "До 375: Чары для кольца - целительная сила\nТребуется Почтение с Ша'таром" }
	},
	[TS.BLACKSMITHING] = {	
		{ 25, "До 25: Rough Sharpening Stones" },
		{ 45, "До 45: Rough Grinding Stones" },
		{ 75, "До 75: Copper Chain Belt" },
		{ 80, "До 80: Coarse Grinding Stones" },
		{ 100, "До 100: Runed Copper Belt" },
		{ 105, "До 105: Silver Rod" },
		{ 125, "До 125: Rough Bronze Leggings" },
		{ 150, "До 150: Heavy Grinding Stone" },
		{ 155, "До 155: Golden Rod" },
		{ 165, "До 165: Green Iron Leggings" },
		{ 185, "До 185: Green Iron Bracers" },
		{ 200, "До 200: Golden Scale Bracers" },
		{ 210, "До 210: Solid Grinding Stone" },
		{ 215, "До 215: Golden Scale Bracers" },
		{ 235, "До 235: Steel Plate Helm\nor Mithril Scale Bracers (cheaper)\nRecipe in Aerie Peak (A) or Stonard (H)" },
		{ 250, "До 250: Mithril Coif\nor Mothril Spurs (cheaper)" },
		{ 260, "До 260: Dense Sharpening Stones" },
		{ 270, "До 270: Thorium Belt or Bracers (cheaper)\nEarthforged Leggings (Armorsmith)\nLight Earthforged Blade (Swordsmith)\nLight Emberforged Hammer (Hammersmith)\nLight Skyforged Axe (Axesmith)" },
		{ 295, "До 295: Imperial Plate Bracers" },
		{ 300, "До 300: Imperial Plate Boots" },
		{ 305, "До 305: Fel Weightstone" },
		{ 320, "До 320: Fel Iron Plate Belt" },
		{ 325, "До 325: Fel Iron Plate Boots" },
		{ 330, "До 330: Lesser Rune of Warding" },
		{ 335, "До 335: Fel Iron Breastplate" },
		{ 340, "До 340: Adamantite Cleaver\nSold in Shattrah, Silvermoon, Exodar" },
		{ 345, "До 345: Lesser Rune of Shielding\nSold in Wildhammer Stronghold and Thrallmar" },
		{ 350, "До 350: Adamantite Cleaver" },
		{ 360, "До 360: Adamantite Weightstone\nRequires Cenarion Expedition - Уважение" },
		{ 370, "До 370: Felsteel Gloves (Auchenai Crypts)\nFlamebane Gloves (Aldor - Уважение)\nEnchanted Adamantite Belt (Scryer - Дружелюбие)" },
		{ 375, "До 375: Felsteel Gloves (Auchenai Crypts)\nFlamebane Breastplate (Aldor - Почтение)\nEnchanted Adamantite Belt (Scryer - Дружелюбие)" },
		{ 385, "До 385: Cobalt Gauntlets" },
		{ 393, "До 393: Spiked Cobalt Shoulders\nor Chestpiece" },
		{ 395, "До 395: Spiked Cobalt Gauntlets" },
		{ 400, "До 400: Spiked Cobalt Belt" },
		{ 410, "До 410: Spiked Cobalt Bracers" },
	},
	[TS.ALCHEMY] = {	
		{ 60, "До 60: Minor Healing Potion" },
		{ 110, "До 110: Lesser Healing Potion" },
		{ 140, "До 140: Healing Potion" },
		{ 155, "До 155: Lesser Mana Potion" },
		{ 185, "До 185: Greater Healing Potion" },
		{ 210, "До 210: Elixir of Agility" },
		{ 215, "До 215: Elixir of Greater Defense" },
		{ 230, "До 230: Superior Healing Potion" },
		{ 250, "До 250: Elixir of Detect Undead" },
		{ 265, "До 265: Elixir of Greater Agility" },
		{ 285, "До 285: Superior Mana Potion" },
		{ 300, "До 300: Major Healing Potion" },
		{ 315, "До 315: Volatile Healing Potion\nor Major Mana Potion" },
		{ 350, "До 350: Mad Alchemists's Potion\nTurns yellow at 335, but cheap to make" },
		{ 375, "До 375: Major Dreamless Sleep Potion\nSold in Allerian Stronghold (A)\nor Thunderlord Stronghold (H)" }
	},
	[L["Mining"]] = {
		{ 65, "До 65: Mine Copper\nAvailable in all starting zones" },
		{ 125, "До 125: Mine Tin, Silver, Incendicite and Lesser Bloodstone\n\nMine Incendicite at Thelgen Rock (Wetlands)\nEasy leveling up to 125" },
		{ 175, "До 175: Mine Iron and Gold\nDesolace, Ashenvale, Badlands, Arathi Highlands,\nAlterac Mountains, Stranglethorn Vale, Swamp of Sorrows" },
		{ 250, "До 250: Mine Mithril and Truesilver\nBlasted Lands, Searing Gorge, Badlands, The Hinterlands,\nWestern Plaguelands, Azshara, Winterspring, Felwood, Stonetalon Mountains, Tanaris" },
		{ 275, "До 275: Mine Thorium \nUn’goro Crater, Azshara, Winterspring, Blasted Lands\nSearing Gorge, Burning Steppes, Eastern Plaguelands, Western Plaguelands" },
		{ 330, "До 330: Mine Fel Iron\nHellfire Peninsula, Zangarmarsh" },
		{ 375, "До 375: Mine Fel Iron and Adamantite\nTerrokar Forest, Nagrand\nBasically everywhere in Outland" }
	},
	[L["Herbalism"]] = {
		{ 50, "До 50: Собираем Сребролист и Мироцвет\nДоступны в начальных зонах" },
		{ 70, "До 70: Собираем Магороза и Земляной корень\nСтепи, Западный Край, Серебряный бор, Лок Модан" },
		{ 100, "До 100: Собираем Остротерн\nСеребряный бор, Сумеречный лес, Темные берега,\nЛок Модан, Красногорье" },
		{ 115, "До 115: Собираем Синячник\nЯсеневый лес, Когтистые горы, Южные степи\nЛок Модан, Красногорье" },
		{ 125, "До 125: Собираем Дикий сталецвет\nКогтистые горы, Нагорье Арати, Тернистая долина\nЮжные степи, Тысяча Игл" },
		{ 160, "До 160: Собираем Королевская кровь\nЯсеневый лес, Когтистые горы, Болотина,\nПредгорья Хилсбрада, Болото Печали" },
		{ 185, "До 185: Собираем Бледнолист\nБолото Печали" },
		{ 205, "До 205: Собираем Кадгаров ус\nВнутренние земли, Нагорье Арати, Болото Печали" },
		{ 230, "До 230: Собираем Огнецвет\nТлеющее ущелье, Выжженные земли, Танарис" },
		{ 250, "До 250: Собираем Солнечник\nОскверненный лес, Фералас, Азшара\nВнутренние земли" },
		{ 270, "До 270: Собираем Кровь Грома\nОскверненный лес, Выжженные земли,\nMannoroc Coven in Пустоши" },
		{ 285, "До 285: Собираем Снолист\nКратер Ун'Горо, Азшара" },
		{ 300, "До 300: Собираем Чумоцвет\nВосточные и Западные Чумные земли, Оскверненный лес\nили Ледяной зев в Зимних Ключах" },
		{ 330, "До 330: Собираем Сквернопля\nПолуостров Адского Пламени, Зангартопь" },
		{ 375, "До 375: Все остальные цветы доступные в запределье\nВ основном в Зангартопе и в Лесу Тероккар" }
	},
	[L["Skinning"]] = {
		{ 375, "До 375: Разделите ваш текущий уровень на 5,\nи снемайте шкуру с животных полученного уровня" }
	},

	-- source: http://www.elsprofessions.com/inscription/leveling.html
	[L["Inscription"]] = {
		{ 18, "До 18: Ivory Ink" },
		{ 35, "До 35: Scroll of Intellect, Spirit or Stamina" },
		{ 50, "До 50: Moonglow Ink\nSave if for Minor Inscription Research" },
		{ 75, "До 75: Scroll of Recall, Armor Vellum" },
		{ 79, "До 79: Midnight Ink" },
		{ 80, "До 80: Minor Inscription Research" },
		{ 85, "До 85: Glyph of Backstab, Frost Nova\nRejuvenation, ..." },
		{ 87, "До 87: Hunter's Ink" },
		{ 90, "До 90: Glyph of Corruption, Flame Shock\nRapid Charge, Wrath" },
		{ 100, "До 100: Glyph of Ice Armor, Maul\nSerpent Sting" },
		{ 104, "До 104: Lion's Ink" },
		{ 105, "До 105: Glyph of Arcane Shot, Arcane Explosion" },
		{ 110, "До 110: Glyph of Eviscerate, Holy Light, Fade" },
		{ 115, "До 115: Glyph of Fire Nova Totem\nHealth Funel, Rending" },
		{ 120, "До 120: Glyph of Arcane Missiles, Healing Touch" },
		{ 125, "До 125: Glyph of Expose Armor\nFlash Heal, Judgment" },
		{ 130, "До 130: Dawnstar Ink" },
		{ 135, "До 135: Glyph of Blink\nImmolation, Moonfire" },
		{ 140, "До 140: Glyph of Lay on Hands\nGarrote, Inner Fire" },
		{ 142, "До 142: Glyph of Sunder Armor\nImp, Lightning Bolt" },
		{ 150, "До 150: Strange Tarot" },
		{ 155, "До 155: Jadefire Ink" },
		{ 160, "До 160: Scroll of Stamina III" },
		{ 165, "До 165: Glyph of Gouge, Renew" },
		{ 170, "До 170: Glyph of Shadow Bolt\nStrength of Earth Totem" },
		{ 175, "До 175: Glyph of Overpower" },
		{ 177, "До 177: Royal Ink" },
		{ 183, "До 183: Scroll of Agility III" },
		{ 185, "До 185: Glyph of Cleansing\nShadow Word: Pain" },
		{ 190, "До 190: Glyph of Insect Swarm\nFrost Shock, Sap" },
		{ 192, "До 192: Glyph of Revenge\nVoidwalker" },
		{ 200, "До 200: Arcane Tarot" },
		{ 204, "До 204: Celestial Ink" },
		{ 210, "До 210: Armor Vellum II" },
		{ 215, "До 215: Glyph of Smite, Sinister Strike" },
		{ 220, "До 220: Glyph of Searing Pain\nHealing Stream Totem" },
		{ 225, "До 225: Glyph of Starfire\nBarbaric Insults" },
		{ 227, "До 227: Fiery Ink" },
		{ 230, "До 230: Scroll of Agility IV" },
		{ 235, "До 235: Glyph of Dispel Magic" },
		{ 250, "До 250: Weapon Vellum II" },
		{ 255, "До 255: Scroll of Stamina V" },
		{ 260, "До 260: Scroll of Spirit V" },
		{ 265, "До 265: Glyph of Freezing Trap, Shred" },
		{ 270, "До 270: Glyph of Exorcism, Bone Shield" },
		{ 275, "До 275: Glyph of Fear Ward, Frost Strike" },
		{ 285, "До 285: Ink of the Sky" },
		{ 295, "До 295: Glyph of Execution\nSprint, Death Grip" },
		{ 300, "До 300: Scroll of Spirit VI" },
		{ 304, "До 304: Ethereal Ink" },
		{ 305, "До 305: Glyph of Plague Strike\nEarthliving Weapon, Flash of Light" },
		{ 310, "До 310: Glyph of Feint" },
		{ 315, "До 315: Glyph of Rake, Rune Tap" },
		{ 320, "До 320: Glyph of Holy Nova, Rapid Fire" },
		{ 325, "До 325: Glyph of Blood Strike, Sweeping Strikes" },
		{ 327, "До 327: Darkflame Ink" },
		{ 330, "До 330: Glyph of Mage Armor, Succubus" },
		{ 335, "До 335: Glyph of Scourge Strike, Windfury Weapon" },
		{ 340, "До 340: Glyph of Arcane Power, Seal of Command" },
		{ 345, "До 345: Glyph of Ambush, Death Strike" },
		{ 350, "До 350: Glyph of Whirlwind" },
		{ 350, "До 350: Glyph of Mind Flay, Banish" },
		
		{ 450, "До 450: Not yet implemented" }
	},

	-- source: http://www.almostgaming.com/wowguides/world-of-warcraft-lockpicking-guide
	[L["Lockpicking"]] = {
		{ 85, "До 85: Thieves Training\nAtler Mill, Redridge Moutains (A)\nShip near Ratchet (H)" },
		{ 150, "До 150: Chest near the boss of the poison quest\nWestfall (A) or The Barrens (H)" },
		{ 185, "До 185: Murloc camps (Wetlands)" },
		{ 225, "До 225: Sar'Theris Strand (Desolace)\n" },
		{ 250, "До 250: Angor Fortress (Badlands)" },
		{ 275, "До 275: Slag Pit (Searing Gorge)" },
		{ 300, "До 300: Lost Rigger Cove (Tanaris)\nBay of Storms (Azshara)" },
		{ 325, "До 325: Feralfen Village (Zangarmarsh)" },
		{ 350, "До 350: Kil'sorrow Fortress (Nagrand)\nPickpocket the Boulderfists in Nagrand" }
	},
	
	-- ** Secondary professions **
	[TS.COOKING] = {
		{ 40, "До 40: Хлеб с пряностями"	},
		{ 85, "До 85: Копченая медвежатина, Пирожок с мясом краба" },
		{ 100, "До 100: Cooked Crab Claw (A)\nDig Rat Stew (H)" },
		{ 125, "До 125: Dig Rat Stew (H)\nSeasoned Wolf Kabob (A)" },
		{ 175, "До 175: Curiously Tasty Omelet (A)\nHot Lion Chops (H)" },
		{ 200, "До 200: Roast Raptor" },
		{ 225, "До 225: Spider Sausage\n\n|cFFFFFFFFCooking quest:\n|cFFFFD70012 Giant Eggs,\n10 Zesty Clam Meat,\n20 Alterac Swiss " },
		{ 275, "До 275: Monster Omelet\nor Tender Wolf Steaks" },
		{ 285, "До 285: Runn Tum Tuber Surprise\nDire Maul (Pusillin)" },
		{ 300, "До 300: Smoked Desert Dumplings\nQuest in Silithus" },
		{ 325, "До 325: Ravager Dogs, Buzzard Bites" },
		{ 350, "До 350: Roasted Clefthoof\nWarp Burger, Talbuk Steak" },
		{ 375, "До 375: Crunchy Serpent\nMok'nathal Treats" }
	},	
	-- source: http://www.wowguideonline.com/fishing.html
	[TS.FISHING] = {
		{ 50, "До 50: Любая начальная зона" },
		{ 75, "До 75:\nВ каналах Штормграда\nВ прудах Оргриммара" },
		{ 150, "До 150: В реке Предгорья Хилсбрада" },
		{ 225, "До 225: Книга Рыболов-умелец продается в Пиратской бухте\nРыбачьте в Пустоши или Нагорьях Арати" },
		{ 250, "До 250: Внутренние земли, Танарис\n\n|cFFFFFFFFРыболовное задание в Пылевых топях\n|cFFFFD700Синий плавник Гибельного берега (Тернистая долина)\nФералас-ахи (Река Вердантис, Фералас)\nУдарник Сартериса (Северное побережье Сар'Терис, Пустоши)\nМахи-махи с Тростникового берега (Береговая линия Болот Печали)" },
		{ 260, "До 260: Оскверненный лес" },
		{ 300, "До 300: Азшара" },
		{ 330, "До 330: Рыбачьте на востоке Зангартопи\nКнига Рыболов-мастер у Кенарийской экспедиция" },
		{ 345, "До 345: Рыбачьте на западе Зангартопи" },
		{ 360, "До 360: Лес Тероккар" },
		{ 375, "До 375: Лесу Тероккар, в Скеттисе\nНужено летающее верховое животное" }
	},
	
	[TS.ARCHAEOLOGY] = {
		{ 300, "До 300: " .. continents[1] .. "\n" .. continents[2]},
		{ 375, "До 375: " .. continents[3]},
		{ 450, "До 450: " .. continents[4]},
		{ 525, "До 525: " .. C_Map.GetMapInfo(606).name .. "\n" .. C_Map.GetMapInfo(720).name .. "\n" .. C_Map.GetMapInfo(700).name},
		{ 600, "До 600: " .. continents[6]},
	},
	
	-- suggested leveling zones, as defined by recommended quest levels. map id's : http://wowpedia.org/MapID
	["Leveling"] = {
		{ 10, "До 10: Любая начальная зона" },
		{ 15, "До 15: " .. C_Map.GetMapInfo(39).name},
		{ 16, "До 16: " .. C_Map.GetMapInfo(684).name},
		{ 20, "До 20: " .. C_Map.GetMapInfo(181).name .. "\n" .. C_Map.GetMapInfo(35).name .. "\n" .. C_Map.GetMapInfo(476).name
							.. "\n" .. C_Map.GetMapInfo(42).name .. "\n" .. C_Map.GetMapInfo(21).name .. "\n" .. C_Map.GetMapInfo(11).name
							.. "\n" .. C_Map.GetMapInfo(463).name .. "\n" .. C_Map.GetMapInfo(36).name},
		{ 25, "До 25: " .. C_Map.GetMapInfo(34).name .. "\n" .. C_Map.GetMapInfo(40).name .. "\n" .. C_Map.GetMapInfo(43).name 
							.. "\n" .. C_Map.GetMapInfo(24).name},
		{ 30, "До 30: " .. C_Map.GetMapInfo(16).name .. "\n" .. C_Map.GetMapInfo(37).name .. "\n" .. C_Map.GetMapInfo(81).name},
		{ 35, "До 35: " .. C_Map.GetMapInfo(673).name .. "\n" .. C_Map.GetMapInfo(101).name .. "\n" .. C_Map.GetMapInfo(26).name
							.. "\n" .. C_Map.GetMapInfo(607).name},
		{ 40, "До 40: " .. C_Map.GetMapInfo(141).name .. "\n" .. C_Map.GetMapInfo(121).name .. "\n" .. C_Map.GetMapInfo(22).name},
		{ 45, "До 45: " .. C_Map.GetMapInfo(23).name .. "\n" .. C_Map.GetMapInfo(61).name},
		{ 48, "До 48: " .. C_Map.GetMapInfo(17).name},
		{ 50, "До 50: " .. C_Map.GetMapInfo(161).name .. "\n" .. C_Map.GetMapInfo(182).name .. "\n" .. C_Map.GetMapInfo(28).name},
		{ 52, "До 52: " .. C_Map.GetMapInfo(29).name},
		{ 54, "До 54: " .. C_Map.GetMapInfo(38).name},
		{ 55, "До 55: " .. C_Map.GetMapInfo(201).name .. "\n" .. C_Map.GetMapInfo(281).name},
		{ 58, "До 58: " .. C_Map.GetMapInfo(19).name},
		{ 60, "До 60: " .. C_Map.GetMapInfo(32).name .. "\n" .. C_Map.GetMapInfo(241).name .. "\n" .. C_Map.GetMapInfo(261).name},
		
		-- Outland
		-- 465 Hellfire Peninsula 
		-- 467 Zangarmarsh 
		-- 478 Terokkar Forest 
		-- 477 Nagrand 
		-- 475 Blade's Edge Mountains 
		-- 479 Netherstorm 
		-- 473 Shadowmoon Valley 
		
		{ 63, "До 63: " .. C_Map.GetMapInfo(465).name},
		{ 64, "До 64: " .. C_Map.GetMapInfo(467).name},
		{ 65, "До 65: " .. C_Map.GetMapInfo(478).name},
		{ 67, "До 67: " .. C_Map.GetMapInfo(477).name},
		{ 68, "До 68: " .. C_Map.GetMapInfo(475).name},
		{ 70, "До 70: " .. C_Map.GetMapInfo(479).name .. "\n" .. C_Map.GetMapInfo(473).name .. "\n" .. C_Map.GetMapInfo(499).name .. "\n" .. C_Map.GetMapInfo(32).name},

		-- Northrend
		-- 491 Howling Fjord 
		-- 486 Borean Tundra 
		-- 488 Dragonblight 
		-- 490 Grizzly Hills 
		-- 496 Zul'Drak 
		-- 493 Sholazar Basin 
		-- 510 Crystalsong Forest 
		-- 495 The Storm Peaks 
		-- 492 Icecrown 
		
		{ 72, "До 72: " .. C_Map.GetMapInfo(491).name .. "\n" .. C_Map.GetMapInfo(486).name},
		{ 75, "До 75: " .. C_Map.GetMapInfo(488).name .. "\n" .. C_Map.GetMapInfo(490).name},
		{ 76, "До 76: " .. C_Map.GetMapInfo(496).name},
		{ 78, "До 78: " .. C_Map.GetMapInfo(493).name},
		{ 80, "До 80: " .. C_Map.GetMapInfo(510).name .. "\n" .. C_Map.GetMapInfo(495).name .. "\n" .. C_Map.GetMapInfo(492).name},
		
		-- Cataclysm
		-- 606 Mount Hyjal 
		-- 613 Vashj'ir 
		-- 640 Deepholm 
		-- 720 Uldum 
		-- 700 Twilight Highlands 
		
		{ 82, "До 82: " .. C_Map.GetMapInfo(606).name .. "\n" .. C_Map.GetMapInfo(613).name},
		{ 83, "До 83: " .. C_Map.GetMapInfo(640).name},
		{ 84, "До 84: " .. C_Map.GetMapInfo(720).name},
		{ 85, "До 85: " .. C_Map.GetMapInfo(700).name},

		-- Pandaria
		-- 806 The Jade Forest 
		-- 807 Valley of the Four Winds 
		-- 857 Krasarang Wilds 
		-- 809 Kun-Lai Summit 
		-- 810 Townlong Steppes 
		-- 858 Dread Wastes 
		
		{ 86, "До 86: " .. C_Map.GetMapInfo(806).name},
		{ 87, "До 87: " .. C_Map.GetMapInfo(807).name .. "\n" .. C_Map.GetMapInfo(857).name},
		{ 88, "До 88: " .. C_Map.GetMapInfo(809).name},
		{ 89, "До 89: " .. C_Map.GetMapInfo(810).name},
		{ 90, "До 90: " .. C_Map.GetMapInfo(858).name},
	},
}
