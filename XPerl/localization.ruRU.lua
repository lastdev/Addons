-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)
--Russian localization file translated by StingerSoft
if (GetLocale() == "ruRU") then

XPerl_ProductName	    = "|cFFD00000X-Perl|r Фреймы Игроков"
XPerl_Description	    = XPerl_ProductName.." от "..XPerl_Author
XPerl_Version		    = XPerl_Description.." - "..XPerl_VersionNumber
XPERL_LongDescription	= "Фреймы Игроков заменяются на новый вид Игроков, Питомцев, Группы, Цели, Целей Цели, Фокуса, Рейда"

	XPERL_MINIMAP_HELP1		= "|c00FFFFFFЛевый rклик|r - опции  (а также |c0000FF00перемещение фреймов|r)"
	XPERL_MINIMAP_HELP2		= "|c00FFFFFFПравый клик|r - перемещение иконки"
	XPERL_MINIMAP_HELP3		= "\rУчастники рейда: |c00FFFF80%d|r\rУчастники рейда: |c00FFFF80%d|r"
	XPERL_MINIMAP_HELP4		= "\rВы лидер группы/рейда"
	XPERL_MINIMAP_HELP5		= "|c00FFFFFFAlt|r для просмотра потребления памяти X-Perl'ом"
	XPERL_MINIMAP_HELP6		= "|c00FFFFFF+Shift|r для просмотра потребления памяти X-Perl'ом после запуска"

	XPERL_MINIMENU_OPTIONS		= "Опции"
	XPERL_MINIMENU_ASSIST		= "Показ Фрейма Поддержки"
	XPERL_MINIMENU_CASTMON		= "Показ Монитора применений"
	XPERL_MINIMENU_RAIDAD		= "Показ Рейд Админа"
	XPERL_MINIMENU_ITEMCHK		= "Показ проверку вещей"
	XPERL_MINIMENU_RAIDBUFF		= "Баффы Рейда"
	XPERL_MINIMENU_ROSTERTEXT	="Список-Текст"
	XPERL_MINIMENU_RAIDSORT		= "Сортировка рейда"
	XPERL_MINIMENU_RAIDSORT_GROUP	= "Сортировать по группам"
	XPERL_MINIMENU_RAIDSORT_CLASS	= "Сортировать по классам"

	XPERL_TYPE_NOT_SPECIFIED	= "Не указанно"
	XPERL_TYPE_PET				= PET		-- "Pet"
	XPERL_TYPE_BOSS				= "Босс"
	XPERL_TYPE_RAREPLUS			= "Редкий+"
	XPERL_TYPE_ELITE			= "Элита"
	XPERL_TYPE_RARE				= "Редкий"
	
-- Zones
XPERL_LOC_ZONE_SERPENTSHRINE_CAVERN = "Змеиное святилище"
XPERL_LOC_ZONE_BLACK_TEMPLE = "Черный храм"
XPERL_LOC_ZONE_HYJAL_SUMMIT = "Вершина Хиджала"
XPERL_LOC_ZONE_KARAZHAN = "Каражан"
XPERL_LOC_ZONE_SUNWELL_PLATEAU = "Плато Солнечного Колодца"
XPERL_LOC_ZONE_NAXXRAMAS = "Наксрамас"
XPERL_LOC_ZONE_OBSIDIAN_SANCTUM = "Обсидиановое святилище"
XPERL_LOC_ZONE_EYE_OF_ETERNITY = "Око Вечности"
XPERL_LOC_ZONE_ULDUAR = "Ульдуар"
XPERL_LOC_ZONE_TRIAL_OF_THE_CRUSADER = "Испытание крестоносца"
XPERL_LOC_ZONE_ICECROWN_CITADEL = "Цитадель Ледяной Короны"
XPERL_LOC_ZONE_RUBY_SANCTUM = "Рубиновое святилище"

-- Status
	XPERL_LOC_DEAD			= DEAD		-- "Dead"
	XPERL_LOC_GHOST			= "Дух"
	XPERL_LOC_FEIGNDEATH	= "Притворяется мертвым"
	XPERL_LOC_OFFLINE		= PLAYER_OFFLINE	-- "Офлайн"
	XPERL_LOC_RESURRECTED	= "Воскрешаемый"
	XPERL_LOC_SS_AVAILABLE	= "Камень души доступен"
	XPERL_LOC_UPDATING		= "Обновляется"
	XPERL_LOC_ACCEPTEDRES	= "Принято"	-- Res accepted
	XPERL_RAID_GROUP		= "Группа %d"
	XPERL_RAID_GROUPSHORT	= "Г%d"

	XPERL_LOC_NONEWATCHED	= "не наблюдался"

	XPERL_LOC_STATUSTIP = "Статус подсвечивания: " 	-- Tooltip explanation of status highlight on unit
	XPERL_LOC_STATUSTIPLIST = {
	HOT = "Исцеления за Время",
	AGGRO = "Аггро",
	MISSING = "Отсутствие классового' баффа",
	HEAL = "Излечен",
	SHIELD = "Защищенный"
}

	XPERL_OK	= "OK"
	XPERL_CANCEL	= "Отмена"

	XPERL_LOC_LARGENUMDIV	= 1000
	XPERL_LOC_LARGENUMTAG	= "K"
	XPERL_LOC_HUGENUMDIV	= 1000000
	XPERL_LOC_HUGENUMTAG	= "M"

	BINDING_HEADER_XPERL = 	XPERL_ProductName
	BINDING_NAME_TOGGLERAID = "Окна рейда"
	BINDING_NAME_TOGGLERAIDSORT = "Сорт рейда по классам/группам"
	BINDING_NAME_TOGGLERAIDPETS = "Питомцы рейда"
	BINDING_NAME_TOGGLEOPTIONS = "Окно опций"
	BINDING_NAME_TOGGLEBUFFTYPE = "Баффы/Дебаффы/пусто"
	BINDING_NAME_TOGGLEBUFFCASTABLE = "Примен./Лечение"
	BINDING_NAME_TEAMSPEAKMONITOR = "Монитор Teamspeak'a"
	BINDING_NAME_TOGGLERANGEFINDER = "Определитель досягаемости"

	XPERL_KEY_NOTICE_RAID_BUFFANY = "Показ всех баффов/дебаффов"
	XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "Показ только читаемые/исцеляющие баффы или дебаффы"
	XPERL_KEY_NOTICE_RAID_BUFFS = "Показ баффов рейда"
	XPERL_KEY_NOTICE_RAID_DEBUFFS = "Показ дебаффов рейда"
	XPERL_KEY_NOTICE_RAID_NOBUFFS = "Не показ баффов рейда"

	XPERL_DRAGHINT1	= "|c00FFFFFFКлик|r для масштабирования окна"
	XPERL_DRAGHINT2	= "|c00FFFFFFShift+Клик|r для изменения размера окна"

-- Usage
	XPerlUsageNameList	= {XPerl = "Основной", 	XPERL_Player = "Игрок", 	XPERL_PlayerPet = "Питомец", 	XPERL_Target = "Цель", 	XPERL_TargetTarget = "Цель цели", 	XPERL_Party = "Группа", 	XPERL_PartyPet = "Питомцы группы", 	XPERL_RaidFrames = "Фреймы рейда", 	XPERL_RaidHelper = "Помощник рейда", 	XPERL_RaidAdmin = "Рейд-админ", 	XPERL_TeamSpeak = "Монитор TS", 	XPERL_RaidMonitor = "Рейд-монитор", 	XPERL_RaidPets = "Питомцы рейда", 	XPERL_ArcaneBar = "Индикатор заклинаний", 	XPERL_PlayerBuffs = "Баффы игрока", 	XPERL_GrimReaper = "Grim Reaper"}
	XPERL_USAGE_MEMMAX	= "UI Макс Пам: %d"
	XPERL_USAGE_MODULES = "Модули: "
	XPERL_USAGE_NEWVERSION	= "*Новейшая версия"
	XPERL_USAGE_AVAILABLE	= "%s |c00FFFFFF%s|r доступна для скачивания"

	XPERL_CMD_HELP	= "|c00FFFF80Используйте: |c00FFFFFF/xperl menu | lock | unlock | config list | config delete <сервер> <имя>"
	XPERL_CANNOT_DELETE_CURRENT = "Невозможно удалить ваши текущие настройки"
	XPERL_CONFIG_DELETED	= "Настройки для %s/%s удалены"
	XPERL_CANNOT_FIND_DELETE_TARGET = "Нет настроек для удаления (%s/%s)"
	XPERL_CANNOT_DELETE_BADARGS = "Введите реалм и ник игрока"
	XPERL_CONFIG_LIST	= "Список настроек:"
	XPERL_CONFIG_CURRENT	= " (текущий)"

	XPERL_RAID_TOOLTIP_WITHBUFF		= "С баффом: (%s)"
	XPERL_RAID_TOOLTIP_WITHOUTBUFF	= "Без баффа: (%s)"
	XPERL_RAID_TOOLTIP_BUFFEXPIRING	= "%s'а %s заканчивается через %s"	-- Name, buff name, time to expire

-- Status highlight spells
XPERL_HIGHLIGHT_SPELLS = {
	hotSpells  = {
		[GetSpellInfo(774)] = 12,			-- Rejuvenation (old id 26982)
		[GetSpellInfo(8936)] = 6,			-- Regrowth (old id 26980)
		[GetSpellInfo(139)] = 12,			-- Renew (old id 25222)
	    [GetSpellInfo(48438)] = 7,			-- Wild Growth 
		[GetSpellInfo(33763)] = 8,			-- Lifebloom
		[GetSpellInfo(28880)] = 15,			-- Gift of the Naaru (Racial)
		[GetSpellInfo(61295)] = 15,			-- Riptide
	},
	pomSpells = {
		[GetSpellInfo(33076)] = 30			-- Prayer of Mending
	},
	shieldSpells = {
		[GetSpellInfo(17)] = 30,			-- Power Word: Shield
		[GetSpellInfo(76669)] = 6,			-- Illuminated Healing
		[GetSpellInfo(974)] = 600			-- Earth Shield	(old id 32594)
	},
	healSpells = {
		[GetSpellInfo(2061)] = 1.5,			-- Flash of Light (old id 25235)
		[GetSpellInfo(2060)] = 3,			-- Greater Heal (old id 25213)
		[GetSpellInfo(2050)] = 3,			-- Heal (old id 6064)
		[GetSpellInfo(5185)] = 3,			-- Healing Touch (old id 26979)
		[GetSpellInfo(8936)] = 1.5,			-- Regrowth (old id 26980)
		[GetSpellInfo(331)] = 3,			-- Healing Wave (old id 25396)
		[GetSpellInfo(8004)] = 1.5,			-- Lesser Healing Wave (old id 25420)
		[GetSpellInfo(19750)] = 1.5,		-- Flash Heal (old id 27137)
		[GetSpellInfo(635)] = 2.5,			-- Holy Light (old id 27136)
		[GetSpellInfo(50464)] = 3.0			-- Nourish
	},
	buffSpells = {
		PRIEST = {
			[GetSpellInfo(21532)] = true	-- Power Word: Fortitude (old id 25389)
		},
	    DRUID = {
			[GetSpellInfo(1126)] = true		-- Mark of the Wild (old id 26990)
		},
	    MAGE = {
			[GetSpellInfo(1459)] = true		-- Arcane Intellect (old id 27126)
		},
	    PALADIN = {
			[GetSpellInfo(19740)] = true,	-- Blessing of Might
			[GetSpellInfo(20217)] = true	-- Blessing of Kings
		},
	},
	groupHealSpells = {
		[GetSpellInfo(596)] = 2.5,			-- Prayer of Healing (old id 25308)
		[GetSpellInfo(1064)] = 2.5,			-- Chain Heal
	},
}


-- Default spells for range checking in the healer visual out-of-range cues.
XPerl_DefaultRangeSpells = {
	DRUID	= {spell = GetSpellInfo(5185)},				-- Healing Touch
	PALADIN = {spell = GetSpellInfo(635)},				-- Holy Light
	PRIEST	= {spell = GetSpellInfo(2061)},				-- Flash Heal
	SHAMAN	= {spell = GetSpellInfo(331)},				-- Healing Wave
	MAGE	= {spell = GetSpellInfo(475)},				-- Remove Lesser Curse
	WARLOCK	= {spell = GetSpellInfo(5697)},				-- Underwater Breathing
	ANY		= {item = GetItemInfo(21991)}				-- Heavy Netherweave Bandage
}

-- Don't highlight these magical debuffs
XPerl_ArcaneExclusions = {
	[GetSpellInfo(63559)] = true,						-- Bind Life
	[GetSpellInfo(30451)] = true,						-- Arcane Blast (again) (old 42897)
	[GetSpellInfo(30108)] = true,						-- Unstable Affliction (old 30405)
	[GetSpellInfo(15822)] = true,						-- Dreamless Sleep
	[GetSpellInfo(24360)] = true,						-- Greater Dreamless Sleep
	[GetSpellInfo(28504)] = true,						-- Major Dreamless Sleep
	[GetSpellInfo(31257)] = true,						-- Chilled
	[GetSpellInfo(710)] = true,							-- Banish
	[GetSpellInfo(44836)] = true,						-- Also Banish !?
	[GetSpellInfo(24306)] = true,						-- Delusions of Jin'do
	[GetSpellInfo(46543)] = {ROGUE = true, WARRIOR = true},	-- Ignite Mana
	[GetSpellInfo(16567)] = {ROGUE = true, WARRIOR = true},	-- Tainted Mind
	[GetSpellInfo(39052)] = {ROGUE = true},				-- Sonic Burst
	[GetSpellInfo(41190)] = {ROGUE = true, WARRIOR = true}, -- Mind-numbing Poison
	[GetSpellInfo(25195)] = {ROGUE = true},				-- Curse of Tongues
	[GetSpellInfo(30129)] = true,						-- Charred Earth - Nightbane debuff, can't be cleansed, but shows as magic
	[GetSpellInfo(31651)] = {MAGE = true, WARLOCK = true, PRIEST = true},	-- Banshee Curse, Melee hit rating debuff
	[GetSpellInfo(38913)] = {ROGUE = true},				-- Silence
	[GetSpellInfo(31555)] = {ROGUE = true, WARRIOR = true}, -- Decayed Intellect
}

end
