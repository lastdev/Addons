if GetLocale() ~= "ruRU" then return end
local L

---------------------------
--  Shriekwing --
---------------------------
--L= DBM:GetModLocalization(2393)

---------------------------
--  Altimor the Huntsman --
---------------------------
--L= DBM:GetModLocalization(2429)

---------------------------
--  Hungering Destroyer --
---------------------------
L= DBM:GetModLocalization(2428)

L:SetOptionLocalization({
	SortDesc 				= "Сортировать $spell:334755 на инфофрейме по наибольшему стаку дебаффов (вместо наименьшего).",
	ShowTimeNotStacks		= "Показать оставшееся время $spell:334755 на инфофрейме вместо количества стака."
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
--L= DBM:GetModLocalization(2418)

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
L= DBM:GetModLocalization(2420)

L:SetTimerLocalization{
	timerDesiresContainer		= "Желания полны",
	timerBottledContainer		= "Бутылка полная",
	timerSinsContainer			= "Грехи полны",
	timerConcentrateContainer	= "Концентрат полный"
}

L:SetOptionLocalization({
	timerContainers2			= "Показать таймер, который будет показывать прогресс заполнения контейнера и время, оставшееся до заполнения"
})

---------------------------
--  The Council of Blood --
---------------------------
--L= DBM:GetModLocalization(2426)

---------------------------
--  Sludgefist --
---------------------------
--L= DBM:GetModLocalization(2394)

---------------------------
--  Stoneborne Generals --
---------------------------
L= DBM:GetModLocalization(2425)

L:SetOptionLocalization({
	ExperimentalTimerCorrection	= "Автоматически настраивать таймеры, когда способности попадают в очередь заклинаний из-за других способностей",
	BladeMarking				= "Установить режим маркировки для рейда (если лидер рейда, то переопределяет рейд)",
	SetOne						= "DBM по умолчанию",
	SetTwo						= "BigWigs по умолчанию"
})

L:SetMiscLocalization({
	DBMConfigMsg		= "Настройки иконок установлены ​​на %s для соответствия конфигурации рейд-лидеров."
})

---------------------------
--  Sire Denathrius --
---------------------------
--L= DBM:GetModLocalization(2424)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Замок Нафрия"
})

---------------------------
--  The Tarragrue --
---------------------------
L= DBM:GetModLocalization(2435)

L:SetOptionLocalization({
	warnRemnant	= "Объявить персональные стаки дебаффов Фрагмента"
})

L:SetMiscLocalization({
	Remnant	= "Фрагмент"
})

---------------------------
--  The Eye of the Jailer --
---------------------------
L= DBM:GetModLocalization(2442)

L:SetOptionLocalization({
	ContinueRepeating	= "Продолжать повторять крики о $spell:355240 и $spell:355245, пока дебаффы не исчезнут"
})

---------------------------
--  The Nine --
---------------------------
L= DBM:GetModLocalization(2439)

L:SetMiscLocalization({
	Fragment		= "Фрагмент ",--Пробел специально. Оставить пробел, чтобы добавить после него цифру
	PrePull			= "А-а-а!"
})

---------------------------
--  Remnant of Ner'zhul --
---------------------------
--L= DBM:GetModLocalization(2444)

---------------------------
--  Soulrender Dormazain --
---------------------------
--L= DBM:GetModLocalization(2445)

---------------------------
--  Painsmith Raznal --
---------------------------
--L= DBM:GetModLocalization(2443)

---------------------------
--  Guardian of the First Ones --
---------------------------
L= DBM:GetModLocalization(2446)

L:SetOptionLocalization({
	IconBehavior	= "Установить режим маркировки для рейда (если лидер рейда, переопределяет рейд)",
	TypeOne			= "DBM по умолчанию (Ближний бой > Дальний бой)",
	TypeTwo			= "BigWigs по умолчанию (Порядок ведения журнала боя)"
})

L:SetMiscLocalization({
	Dissection	= "Рассечение!",
	Dismantle	= "Демонтаж"
})

---------------------------
--  Fatescribe Roh-Kalo --
---------------------------
--L= DBM:GetModLocalization(2447)

---------------------------
--  Kel'Thuzad --
---------------------------
--L= DBM:GetModLocalization(2440)

---------------------------
--  Sylvanas Windrunner --
---------------------------
L= DBM:GetModLocalization(2441)

L:SetMiscLocalization({
	PrePull	= "Герои Азерота. Вы наконец-то здесь."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SanctumofDomTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Святилище Господства"
})

---------------------------
--  Vigilant Guardian --
---------------------------
--L= DBM:GetModLocalization(2458)

---------------------------
--  Dausegne, the Fallen Oracle --
---------------------------
--L= DBM:GetModLocalization(2459)

---------------------------
--  Artificer Xy'mox --
---------------------------
--L= DBM:GetModLocalization(2470)

---------------------------
--  Prototype Pantheon --
---------------------------
L= DBM:GetModLocalization(2460)

L:SetOptionLocalization({
	RitualistIconSetting	= "Установить режим настройки меток Ритуалистов. Используется предпочтение рейд-лидеров, если они используют DBM.",
	SetOne					= "Отличие от семян / Ночного охотника (без конфликтов) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t",--5-8 (по умолчанию)
	SetTwo					= "Совпадение семян / Ночного охотника (конфликтует, если семена и ритуалисты в одно и то же время) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"-- 1-4
--	SetThree				= "Match seeds/Night Hunter (no conflicts, but requires raid members having extended icons properly installed to see them) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"--9-12
})

L:SetMiscLocalization({
	Deathtouch		= "Смертельное касание",
	Dispel			= "Рассеивание",
	ExtendReset		= "Настройка раскрывающегося списка значков Ритуалиста была сброшена из-за того, что Вы раньше использовали расширенные значки, но теперь не используете их"
})

---------------------------
--  Lihuvim, Principal Architect --
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener --
---------------------------
L= DBM:GetModLocalization(2465)

L:SetTimerLocalization{
	timerComboCD		= "~Танковое комбо (%d)"
}

L:SetOptionLocalization({
	timerComboCD		= "Отсчёт времени (со счётчиком) до перезарядки танкового комбо"
})

---------------------------
--  Halondrus the Reclaimer --
---------------------------
L= DBM:GetModLocalization(2463)

L:SetMiscLocalization({
	Mote		= "Частице"
})

---------------------------
--  Anduin Wrynn --
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior		= "Установить режим мода для 'Кощунства'. Используется предпочтение рейд-лидеров, если они используют DBM.",
	Auto				= "Оповещать 'на тебе' с автоматически назначенным партнером. Облачка чата показывают уникальные символы для совпадений.",
	Generic				= "Оповещать 'на тебе' без назначенного партнера. Облачка чата показывают общие символы для двух дебаффов.",--По умолчанию
	None				= "Оповещать 'на тебе' без назначенного партнера. Без облачков чата."
})

---------------------------
--  Lords of Dread --
---------------------------
--L= DBM:GetModLocalization(2457)

---------------------------
--  Rygelon --
---------------------------
--L= DBM:GetModLocalization(2467)

---------------------------
--  The Jailer --
---------------------------
L= DBM:GetModLocalization(2464)

L:SetWarningLocalization({
	warnHealAzeroth		= "Исцеление Азерот (%s)",
	warnDispel			= "Рассеивание (%s)"
})

L:SetTimerLocalization{
	timerPits			= "Лунки открываются",
	timerHealAzeroth	= "Исцеление Азерот (%s)",
	timerDispels		= "Рассеивания (%s)"
}

L:SetOptionLocalization({
	timerPits			= "Показать таймер, когда открываются лунки в полу, в которые можно упасть",
	warnHealAzeroth		= "Показать предупреждение о том, когда Вам нужно исцелить Азерот (через механику боя) на мифической сложности, основываясь на стратегии гильдии Эхо",
	warnDispel			= "Показать предупреждение о том, когда нужно рассеять 'Смертный приговор' на мифической сложности, основываясь на стратегии гильдии Эхо",
	timerHealAzeroth	= "Показать таймер, когда Вам нужно исцелить Азерот (через механику боя) на мифической сложности, основываясь на стратегии гильдии Эхо",
	timerDispels		= "Показать таймер, когда нужно рассеять 'Смертный приговор' на мифической сложности, основываясь на стратегии гильдии Эхо"
})

L:SetMiscLocalization({
	Pylon				= "Пилону",
	AzerothSoak			= "Поглощение Азерот"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Гробница Предвечных"
})

-----------------------
-- <<< Fated Raid Affixes >>> --
-----------------------
L = DBM:GetModLocalization("FatedAffixes")

L:SetGeneralLocalization({
	name =	"Судьбоносные аффиксы"
})
