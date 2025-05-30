local VERSION = 116

--[[
Special icons for rares, pvp or pet battle quests in list
Better sorting for all reward types
Quest position on general Broken Isles map
Number of artifact power on item in list
New quests will be marked as "new" for another 3 min
Minor localization fixes

Added Eye Of Azshara zone
Note for BOE gear rewards
Fix for 1k+ AP items
Minor fixes

Added helper for Kirin Tor enigma world quest
Added minor functionality for leveling

Blood of Sargeras filter
Icon on map for hidden quests (that expires in 15min)
Icon in list for profession quests
Fix for Kirin-Tor helper (quest is 7x7 now instead 8x8)

Added button "Show all quests"
QOL improvements (mouseovering + shift, click on quest)
Fixed changing order for quests with same timer while sorting by time
Click on quest now send you to zone map
Added ElvUI support
Bugfixes

Added icon on the flight map for recently chosen quest

Added filters for pvp, pet battles & professions quests
Added checkbox above map to disable WQL

Artifact weapon color for all artifact power items
Minor notification for artifact power items that can be earned after reaching next artifact knowledge level
Dungeon icon for dungeons world quests
Added options for scale, anchor and arrow

Added tooltip with date for timeleft
Enigma helper disabled ("/enigmahelper" still works)
Added "Total AP" text
Minor fixes

Fixed highlighting faction for emissary quests (You can do Watchers or Kirin-tor quests for zone emissary)
Added "Total gold & total order resources" text
Minor fixes

Fixed summary while filtered
Added "Time to Complete" for marked ("**") quests
Added 7.1 support
Different color for elite quests
Some pvp quests shows honor as reward if reward is only gold [filter for them gold as before]
Minor fixes

7.1 Update

New option "Ignore filter for bounty quests"
Minor fixes

Last client update (not addon) broke something with world quests (updating info too frequently). I added 5 second limit for updating (so may need time for update rewards after login), dropdowns will closing every 5 sec too. Sorry for the inconvenience, it'll not be too long until I write real solution

Added "Barrels o' Fun" helper
Minor fixes

Rewards updates must be faster
Added options for enable/disabe Enigma Helper/Barrels Helper
Added option "Ignore filter for PvP quests"

Added scroll (use mouse wheel or buttons for navigate) [still in testing]
AP numbers divided by 1000 for artifact knowledge 26 or higher
7.2 PTR Update (Note: this version works on both clients: live 7.1.5 and ptr 7.2.0)

More "Ignore filter" options
7.2 Updates (Note: this version works on both clients: live 7.1.5 and ptr 7.2.0)

7.2 toc update
Added dalaran quests to general map
Added option for AP number formatting
Added header line for quick sorting (and option for disabling it)
Added switcher to regular quests (not WQ) for max level chars
Tooltip with icons for all factions if quest can be done for any emissary
Added option for disabling highlight for new quests

Added quests without timer to list (unlimited quests; expired quests)
Added sorting by distance to quest
Sorting by reward: Gear rewards had low priority for high ilvl chars
Minor fixes

Bugfixes

Added invasions quests to list for low level chars
Added faction icons for emissary quests (can be disabled in options)
Threshold for lower priority on gear rewards was lowered to 880 ilvl

7.2.5 Update

7.3.0 PTR Update
Added TomTom support

Fixed debug numbers in chat
TomTom now have higher prior if both addons for arrow enabled

Added autoremoving arrow for TomTom if you completed or leaved quest area [in testing]
Added ignoring quests [right click on quest name]

Added option for changing arrow style (TomTom or ExRT)
Minor 7.3.0 Updates

7.3.0 Update
Graphical updates
New anchor position: inside map [experimental]
Frame now movable if you run it via "/wql" [Use "/wql reset" if you somehow lost frame out of the screen]

Added "Ignore filter" oprions for factions "Army of the Light" & "Argussian Reach"
Added new anchor position: free outside [Use "/wql resetanchor" or "/wql reset" if you somehow lost frame out of the screen]
Minor fixes

Added Invasion Points

Fixes

General Argus Map were replaced with zones map [in testing, you can disable this in options]
Readded info for AP quests that can be done with next Aknowledge level [only for EU and US servers]

Fixes for ADDON_ACTION_BLOCKED errors
Added "/wql argus" command

Fixes

Added option for percentage of the current level's max AP number (by Corveroth)
Update for korean translation (by yuk6196)
Fixes (Frame strata for free position)

Minor fixes
Update for chinese translation (by dxlmike)

Added Veiled Argunite filter

BfA update (8.0.1)
added button for quick navigate between Zandalar and Kul-Tiras
quest icons on general (continents) maps
quick link to wowhead (right click on quest name)
shell game helper
new filters (azerite, reputations)
new factions filters
tooltip with reputation rewards for quests
options for manipulations with list on azeroth/Broken Isles maps (i.e. include/exclude agrus/legion quests, etc)
second icon for profession quests
standalone arrow, no addons required
text color for zone names
added treasure/rares mode [beta]

Added LFG (group finder) option [in testing]

LFG: Less clicks to find group
LFG: Click with shift button will try to find group by quest name
Added tooltip for eye buttons
LFG: Right click on map icons will start search groups for this quest
LFG: Added popup window when you enter quest area (and option to disable it)
LFG: Added submit with enter key
Moved agrus rep token revards to reputation category
Minor fixes

Options dropdown menu now available all time in wq mode
Major fixes

Find party popup now uses default search for rare quests
Added option for disabling search on rightclick on map icons
Minor fixes

Blacklisted some quests for auto popup (pet battles, supplies, work orders)
Added "/wql options" command
Minor fixes

Added reward type on icons on map [in testmode, you can enable it in options]
Added "Start a group" button after success search
Bigger icons on general map in fullscreen map mode
More blacklisted quests (kirin tor & tortollan puzzles)

LFG: "Convert to raid" popup must not be displayed for non-elite quests
Minor fixes

Added "Map icons scale" option
Hovered world quest icon will be on top
Added reward-on-icons for the flightmap
Autotoggle all languages for LFG fliter search

Fix for wq icons scale for non-general maps in fullscreen mode
LFG: Blizzard's group finder is broken again for elite quests, so added button "Try with Quest ID" on group creation page
Added world quest type mini icon (pvp, profession, pet battle)
Added option "Hide ribbon graphic"
Added option for arrow for regular quests (via right click on map)
LFG: added support for regular quests (via list or right click on map)
LFG: groups for non-elite quests with 5 players will be marked as red
Minor fixes

Added option "Disable all, except LFG" ("/wql options" > "Enable LFG search"  > "Disable all, except LFG")
TomTom arrow is back as option
Fixed WQ icons random shifting
WQ icons on world map will stay if list is hidden
Minor fixes

Fixed free mode anchor
Some tweaks for fullscreen map mode
Added option "Disable eye for quest tracker on right"
Minor fixes

LFG Hotfixes, must work as before [Report any bugs/errors]

More fixes for fullscreen map mode
Added "max lines" option
Minor LFG updates

LFG Hotfixes

LFG fixes

Added option to highlight quest for selected factions reputations
Minor fixes

LFG: no more 'wwwwwww' in searchbox if player is moving
LFG: leave party popup only for quest groups
Added shift+right click to expand azerite gear rewards
Localizations updates by sprider00
Minor fixes

Added requeue button for current quest (replace eye in quest tracker)
Fix for "addon blocked" error
Minor updates

Added option "Disable popup after quest completion (leave party)"
Added "/wql way X Y" command for manual arrow
Right click on LFG popup will hide it
Minor fixes

Update for Arathi rares
Added "/way X Y" if no other addon found for it
Some fixes for sorting
Fix autoinvite for non-quest lfg groups

Major fixes

8.1.0 Update
Added option to replace trinkets rewards with expulsom
Update for quick navigation buttons
Fixes

Darkshore rares update
LFG Fixes

toc update
Added next invasion timer (hover quick nav buttons)
Rares update

Added lfg eye for main assault quests
Added colors for questmarks on map for emissary quests (Options > Enable reward on map icons > Enable emissary quests colors)
Added zones names for next invasion timer

Added Calligraphy game helper (horde only)
Fixed invasion timer list for some connected realms
Fixed lua errors when you put azerite neck into the bank
Fixed naga quest reward

Fixes
Removed Service Medal filter

Grayed out azerite rewards if azerite neck is maxed
Updated German localization by Sunflow72
Added seconds for time remaining (<5min)
Added Calligraphy game helper for alliance
8.2.0 PTR update

8.2.0 Update
Added icon for quests for achievements (can be disabled via option)

8.2.5 toc update
Fixed arrow for regular quests in Nazjatar
Fixed Nazjatar WQs for azeroth map

Added "Priority options" for rewards sorting
Redone sorting by time (time>rewards), sorting by zone(zone>time>rewards)
Fixed dead lock while shell game
Fixed emissary highlights for Broken Isles map

8.3 Update

Shadowlands update

Bugfixes

Fixed Shift-clicks on quests
Fixed TomTom arrow

9.0.2 toc update
Bugfixes

LFG fixes
Added Aspirant Training quest helper

Adeed shadowlands achievements
Updated german translation (by sunflow72)

Added Tough Crowd helper
Minor fixes

9.0.5 update
Added warmode bonus for shadowlands quests

Wago update

9.1.5 update

Bugfixes

9.2 update

toc update

fixes

fixes

toc update
Restructured options dropdowns: now options for different expansions always visible
Added option to hide emerald dream quest icons from main map

11.0 update

fixes

TWW content update
Added numbers on quest icons

fixes
Added dragonriding filter
]]

local GlobalAddonName, WQLdb = ...

local VWQL = nil

local GetCurrentMapID = function() return WorldMapFrame:GetMapID() or 0 end
local IsQuestComplete, IsQuestCriteriaForBounty = C_QuestLog.IsComplete, C_QuestLog.IsQuestCriteriaForBounty


local function GetCurrencyInfo(id)
	local data = C_CurrencyInfo.GetCurrencyInfo(id)
	return data.name, nil, data.iconFileID
end
local function GetQuestLogTitle(id)
	local data = C_QuestLog.GetInfo(id)
	return data.title, data.level, data.suggestedGroup, data.isHeader, data.isCollapsed, data.isComplete, data.frequency, data.questID
end
local function GetQuestTagInfo(id)
	local data = C_QuestLog.GetQuestTagInfo(id)
	return data.tagID, data.tagName, data.worldQuestType, data.quality, data.isElite, data.tradeskillLineID, data.displayExpiration
end

local GetFactionInfoByID = GetFactionInfoByID or function(id)
	local data = C_Reputation.GetFactionDataByID(id)
	if not data then
		return
	end
	return data.name, data.description
end

local GetNumQuestLogRewardCurrencies, GetQuestLogRewardCurrencyInfo = GetNumQuestLogRewardCurrencies, GetQuestLogRewardCurrencyInfo
if not GetNumQuestLogRewardCurrencies then
	local reward_cache = {}
	local function GetData(questID)
		local data = reward_cache[questID]
		local t = GetTime()
		if not data or t > data.expTime then
			data = C_QuestLog.GetQuestRewardCurrencies(questID)
			data.expTime = t + 5
		end
		return data
	end
	function GetNumQuestLogRewardCurrencies(questID)
		local data = GetData(questID)
		return #data
	end
	function GetQuestLogRewardCurrencyInfo(i, questID)
		local data = GetData(questID)[i]
		if not data then
			return
		end
		return data.name, data.texture, data.totalRewardAmount, data.currencyID
		--data.totalRewardAmount
	end
end

local LE = {
	LE_QUEST_TAG_TYPE_INVASION = Enum.QuestTagType.Invasion,
	LE_QUEST_TAG_TYPE_DUNGEON = Enum.QuestTagType.Dungeon,
	LE_QUEST_TAG_TYPE_RAID = Enum.QuestTagType.Raid,
	LE_WORLD_QUEST_QUALITY_RARE = Enum.WorldQuestQuality.Rare,
	LE_WORLD_QUEST_QUALITY_EPIC = Enum.WorldQuestQuality.Epic,
	LE_QUEST_TAG_TYPE_PVP = Enum.QuestTagType.PvP,
	LE_QUEST_TAG_TYPE_PET_BATTLE = Enum.QuestTagType.PetBattle,
	LE_QUEST_TAG_TYPE_PROFESSION = Enum.QuestTagType.Profession,
	LE_ITEM_QUALITY_COMMON = Enum.WorldQuestQuality.Common,
	LE_QUEST_TAG_TYPE_FACTION_ASSAULT = Enum.QuestTagType.FactionAssault,
	LE_QUEST_TAG_TYPE_THREAT = Enum.QuestTagType.Threat,

	BAG_ITEM_QUALITY_COLORS = BAG_ITEM_QUALITY_COLORS,
	ITEM_SPELL_TRIGGER_ONUSE = ITEM_SPELL_TRIGGER_ONUSE,
	ITEM_BIND_ON_EQUIP = ITEM_BIND_ON_EQUIP,
	ARTIFACT_POWER = ARTIFACT_POWER,
	AZERITE = GetCurrencyInfo(1553),
	ORDER_RESOURCES_NAME_LEGION = GetCurrencyInfo(1220),
	ORDER_RESOURCES_NAME_BFA = GetCurrencyInfo(1560),
}
      
local charKey = (UnitName'player' or "").."-"..(GetRealmName() or ""):gsub(" ","")

local locale = GetLocale()
local LOCALE = 
	locale == "ruRU" and {
		gear = "Экипировка",
		gold = "Золото",
		blood = "Кровь Саргераса",
		knowledgeTooltip = "** Можно выполнить после повышения уровня знаний вашего артефакта",
		disableArrow = "Отключить стрелку",
		anchor = "Привязка",
		totalap = "Всего силы артефакта: ",
		totalapdisable = 'Отключить сумму силы артефакта',
		timeToComplete = "Времени на выполнение: ",
		bountyIgnoreFilter = "Задания посланника",
		enigmaHelper = "Включить Enigma Helper",
		barrelsHelper = "Включить Barrels Helper",
		honorIgnoreFilter = "PvP задания",
		ignoreFilter = "Игнорировать фильтр для",
		epicIgnoreFilter = '"Золотые" задания',
		wantedIgnoreFilter = 'Задания "Разыскиваются"',
		apFormatSetup = "Формат силы артефакта",
		headerEnable = "Включить полосу-заголовок",
		disabeHighlightNewQuests = "Отключить подсветку новых заданий",
		distance = "Расстояние",
		disableBountyIcon = "Отключить иконку фракций для заданий посланника",
		arrow = "Стрелка",
		invasionPoints = "Точки вторжения",
		argusMap = "Включить карту Аргуса",
		ignoreList = "Список игнорирования",
		addQuestsOpposite = "Добавить задания другого континента",
		hideLegion = "Скрыть задания из Легиона",
		disableArrowMove = "Отключить перемещение",
		shellGameHelper = "Включить Shell Game Helper",
		iconsOnMinimap = "Включить иконки на общих картах",
		addQuestsArgus = "Добавить задания Аргуса",
		lfgSearchOption = "Включить поиск в LFG",
		lfgAutoinvite = "Включите опцию автоприглашения",
		lfgTypeText = "Введите цифры (ID квеста) в поле для ввода",
		lfgLeftButtonClick = "ЛКМ - найти группу",
		lfgLeftButtonClick2 = "ЛКМ + shift - найти группу по названию",
		lfgRightButtonClick = "ПКМ - создать группу",
		lfgDisablePopup = "Отключить всплывающее окно",
		lfgDisableRightClickIcons = "Отключить правый клик по иконкам на карте",
		disableRewardIcons = "Включить награду на иконках на карте",
		mapIconsScale = "Масштаб иконок на карте",
		disableRibbon = "Отключить графику ленты",
		enableRibbonGeneralMap = "Включить ленту на картах континентов",
		enableArrowQuests = "Включить стрелку для обычных заданий",
		tryWithQuestID = "Поиск по quest ID",
		lfgDisableAll = "Отключить все, кроме LFG",
		lfgDisableAll2 = "Все настройки аддона будут сброшены. Отключить все функции, кроме LFG?",
		lfgDisableEyeRight = "Отключить кнопку глаза в меню заданий справа",
		lfgDisableEyeList = "Скрыть кнопку глаза в списке",
		listSize = "Размер списка",
		topLine = "Верхняя строка",
		bottomLine = "Нижняя строка",
		unlimited = "Неограниченно",
		maxLines = "Лимит строк",
		lfgDisablePopupLeave = "Отключить всплывающее окно после завершения задания (покинуть группу)",
		expulsom = "Дистиллиум",
		expulsomReplace = "Заменить награды аксессуаров на Дистиллиум",
		enableBountyColors = "Включить цвета заданий посланников",
		calligraphyGameHelper = "Включить Calligraphy Helper",
		addQuestsNazjatar = "Добавить задания Назжатара",
		questsForAchievements = "Показывать задания для достижений",
		rewardSortOption = "Настройка приоритетов",
		rewardSortCurrOther = "Другие валюты",
		rewardSortItemOther = "Другие предметы",
		aspirantTraining = "Помощник тренировки претендента",
		toughCrowdHelper = "Помощник требовательной публики",
		disableQuestNumber = "Отключить нумерацию заданий на иконках",
		repAccAlert = "Включить стрелку награды репутации",
	} or
	locale == "deDE" and {    --by SunnySunflow
	        gear = "Ausrüstung",
	        gold = "Gold",
	        blood = "Blut von Sargeras",
	        knowledgeTooltip = "** Kann nach dem Erreichen des nächsten Artefaktwissens abgeschlossen werden",
	        disableArrow = "Deaktiviert den Pfeil",
	        anchor = "Anker",
	        totalap = "Artefaktmacht insgesamt: ",
	        totalapdisable = 'Deaktiviert "Gesamt-Artefaktmacht"',
	        timeToComplete = "Zeit zum Abschließen: ",
	        bountyIgnoreFilter = "Abgesandten Quests",
	        enigmaHelper = "Aktiviert Rätsel Helfer",
	        barrelsHelper = "Aktiviert Fässer Helfer",
	        honorIgnoreFilter = "PVP Quests",
	        ignoreFilter = "Filter ignorieren für",
	        epicIgnoreFilter = '"Weltbosse" Quests',
	        wantedIgnoreFilter = "Missionen Quests",
	        apFormatSetup = "Artefaktmacht Format",
	        headerEnable = "Aktiviert die Kopfzeile",
	        disabeHighlightNewQuests = "Deaktiviert die Markierung für neue Quests",
	        distance = "Entfernung",
	        disableBountyIcon = "Deaktiviert die Fraktionssymbole für Abgesandten Quests",
	        arrow = "Pfeil",
	        invasionPoints = "Invasions-Punkte",
	        argusMap = "Aktiviert Argus Karte",
	        ignoreList = "Ignorier-Liste",
	        addQuestsOpposite = "Fügt Quests von anderen Kontinent hinzu",
	        hideLegion = "Verbergt Quests von Legion",
	        disableArrowMove = "Deaktiviert das Verschieben",
	        shellGameHelper = "Aktiviert Panzerspiel Helfer",
	        iconsOnMinimap = "Aktiviert Symbole auf Kontinentkarten",
	        addQuestsArgus = "Fügt Quests von Argus hinzu",
	        lfgSearchOption = "Aktiviert die LFG-Suche",
	        lfgAutoinvite = "Aktiviert die automatische Einladungsoption",
	        lfgTypeText = "Gib die Quest-ID in das Eingabefeld ein",
	        lfgLeftButtonClick = "Linksklick - Gruppe finden",
	        lfgLeftButtonClick2 = "Linksklick + Shift - Gruppe finden nach Namen",
	        lfgRightButtonClick = "Rechtsklick - Gruppe erstellen",
	        lfgDisablePopup = "Deaktiviert Popup im Questbereich",
	        lfgDisableRightClickIcons = "Deaktiviert die rechte Maustaste auf Symbole der Karte",
	        disableRewardIcons = "Aktiviert die Belohnungssymbole auf Karten",
	        mapIconsScale = "Kartensymbole skalieren",
	        disableRibbon = "Deaktiviert die Bandgrafiken",
	        enableRibbonGeneralMap = "Aktiviert die Bandgrafik auf Kontinentkarten",
	        enableArrowQuests = "Aktiviert den Pfeil für normale Quests",
	        tryWithQuestID = "Suche nach Quest-ID",
	        lfgDisableAll = "Deaktiviert alle, außer LFG",
	        lfgDisableAll2 = "Alle Addon-Einstellungen werden zurückgesetzt. Deaktiviert alle Optionen, außer LFG?",
	        lfgDisableEyeRight = "Deaktiviert Augenknopf bei Quest-Ziele auf der rechten Seite",
	        lfgDisableEyeList = "Augenknopf in Liste ausblenden",
	        listSize = "Listengröße",
	        topLine = "Obere Zeile",
	        bottomLine = "Untere Zeile",
	        unlimited = "Unbegrenzt",
	        maxLines = "Maximale Anzahl an Zeilen",
	        lfgDisablePopupLeave = "Deaktiviert Popup nach Abschluss der Quest (Gruppe verlassen)",
	        expulsom = "Expulsom",
	        expulsomReplace = "Ersetzt Schmuckstücke durch Expulsom",
	        enableBountyColors = "Aktiviert die Farben der Kopfgeldquests",
	        calligraphyGameHelper = "Aktiviert Kalligraphie Helfer",
	        addQuestsNazjatar = "Fügt Quests von Nazjatar hinzu",
	        questsForAchievements = "Zeigt Quests für Erfolge",
	        rewardSortOption = "Prioritätsoptionen",
	        rewardSortCurrOther = "Andere Währungen",
	        rewardSortItemOther = "Andere Gegenstände",
	        aspirantTraining = "Aspiranten Übungskampf Helfer",
		toughCrowdHelper = "Schwieriges Publikum Helfer",
		disableQuestNumber = "Disable numbers on quest icons",
		repAccAlert = "Enable reputation award notification",
	} or
	locale == "frFR" and {
		gear = "Équipement",
		gold = "Or",
		blood = "Sang de Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
		arrow = "Arrow",
		invasionPoints = "Invasion Points",
		argusMap = "Enable Argus map",
		ignoreList = "Ignore list",
		addQuestsOpposite = "Add quests from the opposite continent",
		hideLegion = "Hide quests from Legion",
		disableArrowMove = "Disable moving",
		shellGameHelper = "Enable Shell Game Helper",
		iconsOnMinimap = "Enable icons on General maps",
		addQuestsArgus = "Add quests from Argus",
		lfgSearchOption = "Enable LFG search",
		lfgAutoinvite = "Set autoinvite option on",
		lfgTypeText = "Type numbers (QuestID) to edit box",
		lfgLeftButtonClick = "Left Click - find group",
		lfgLeftButtonClick2 = "Left Click + shift - find group by name",
		lfgRightButtonClick = "Right Click - create group",
		lfgDisablePopup = "Disable popup in questarea",
		lfgDisableRightClickIcons = "Disable right click on map icons",
		disableRewardIcons = "Enable reward on map icons",
		mapIconsScale = "Map icons scale",
		disableRibbon = "Disable ribbon graphic",
		enableRibbonGeneralMap = "Enable ribbon on general maps",
		enableArrowQuests = "Enable arrow for regular quests",
		tryWithQuestID = "Try by quest ID",
		lfgDisableAll = "Disable all, except LFG",
		lfgDisableAll2 = "All addon settings will be lost. Disable all options, except LFG?",
		lfgDisableEyeRight = "Disable eye for quest tracker on right",
		lfgDisableEyeList = "Hide eye in list",
		listSize = "List size",
		topLine = "Top line",
		bottomLine = "Bottom line",
		unlimited = "Unlimited",
		maxLines = "Max lines",
		lfgDisablePopupLeave = "Disable popup after quest completion (leave party)",
		expulsom = "Expulsom",
		expulsomReplace = "Replace trinkets rewards with Expulsom",
		enableBountyColors = "Enable bounty quests colors",
		calligraphyGameHelper = "Enable Calligraphy Helper",
		addQuestsNazjatar = "Add quests from Nazjatar",
		questsForAchievements = "Show quests for achievements",
		rewardSortOption = "Priority options",
		rewardSortCurrOther = "Other currencies",
		rewardSortItemOther = "Other items",
		aspirantTraining = "Aspirant Training Helper",
		toughCrowdHelper = "Tough Crowd Helper",
		disableQuestNumber = "Disable numbers on quest icons",
		repAccAlert = "Enable reputation award notification",
	} or
	(locale == "esES" or locale == "esMX") and {
		gear = "Equipo",
		gold = "Oro",
		blood = "Sangre de Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
		arrow = "Arrow",
		invasionPoints = "Invasion Points",
		argusMap = "Enable Argus map",
		ignoreList = "Ignore list",
		addQuestsOpposite = "Add quests from the opposite continent",
		hideLegion = "Hide quests from Legion",
		disableArrowMove = "Disable moving",
		shellGameHelper = "Enable Shell Game Helper",
		iconsOnMinimap = "Enable icons on General maps",
		addQuestsArgus = "Add quests from Argus",
		lfgSearchOption = "Enable LFG search",
		lfgAutoinvite = "Set autoinvite option on",
		lfgTypeText = "Type numbers (QuestID) to edit box",
		lfgLeftButtonClick = "Left Click - find group",
		lfgLeftButtonClick2 = "Left Click + shift - find group by name",
		lfgRightButtonClick = "Right Click - create group",
		lfgDisablePopup = "Disable popup in questarea",
		lfgDisableRightClickIcons = "Disable right click on map icons",
		disableRewardIcons = "Enable reward on map icons",
		mapIconsScale = "Map icons scale",
		disableRibbon = "Disable ribbon graphic",
		enableRibbonGeneralMap = "Enable ribbon on general maps",
		enableArrowQuests = "Enable arrow for regular quests",
		tryWithQuestID = "Try by quest ID",
		lfgDisableAll = "Disable all, except LFG",
		lfgDisableAll2 = "All addon settings will be lost. Disable all options, except LFG?",
		lfgDisableEyeRight = "Disable eye for quest tracker on right",
		lfgDisableEyeList = "Hide eye in list",
		listSize = "List size",
		topLine = "Top line",
		bottomLine = "Bottom line",
		unlimited = "Unlimited",
		maxLines = "Max lines",
		lfgDisablePopupLeave = "Disable popup after quest completion (leave party)",
		expulsom = "Expulsom",
		expulsomReplace = "Replace trinkets rewards with Expulsom",
		enableBountyColors = "Enable bounty quests colors",
		calligraphyGameHelper = "Enable Calligraphy Helper",
		addQuestsNazjatar = "Add quests from Nazjatar",
		questsForAchievements = "Show quests for achievements",
		rewardSortOption = "Priority options",
		rewardSortCurrOther = "Other currencies",
		rewardSortItemOther = "Other items",
		aspirantTraining = "Aspirant Training Helper",
		toughCrowdHelper = "Tough Crowd Helper",
		disableQuestNumber = "Disable numbers on quest icons",
		repAccAlert = "Enable reputation award notification",
	} or
	locale == "itIT" and {
		gear = "Equipaggiamento",
		gold = "Oro",
		blood = "Sangue di Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
		arrow = "Arrow",
		invasionPoints = "Invasion Points",
		argusMap = "Enable Argus map",
		ignoreList = "Ignore list",
		addQuestsOpposite = "Add quests from the opposite continent",
		hideLegion = "Hide quests from Legion",
		disableArrowMove = "Disable moving",
		shellGameHelper = "Enable Shell Game Helper",
		iconsOnMinimap = "Enable icons on General maps",
		addQuestsArgus = "Add quests from Argus",
		lfgSearchOption = "Enable LFG search",
		lfgAutoinvite = "Set autoinvite option on",
		lfgTypeText = "Type numbers (QuestID) to edit box",
		lfgLeftButtonClick = "Left Click - find group",
		lfgLeftButtonClick2 = "Left Click + shift - find group by name",
		lfgRightButtonClick = "Right Click - create group",
		lfgDisablePopup = "Disable popup in questarea",
		lfgDisableRightClickIcons = "Disable right click on map icons",
		disableRewardIcons = "Enable reward on map icons",
		mapIconsScale = "Map icons scale",
		disableRibbon = "Disable ribbon graphic",
		enableRibbonGeneralMap = "Enable ribbon on general maps",
		enableArrowQuests = "Enable arrow for regular quests",
		tryWithQuestID = "Try by quest ID",
		lfgDisableAll = "Disable all, except LFG",
		lfgDisableAll2 = "All addon settings will be lost. Disable all options, except LFG?",
		lfgDisableEyeRight = "Disable eye for quest tracker on right",
		lfgDisableEyeList = "Hide eye in list",
		listSize = "List size",
		topLine = "Top line",
		bottomLine = "Bottom line",
		unlimited = "Unlimited",
		maxLines = "Max lines",
		lfgDisablePopupLeave = "Disable popup after quest completion (leave party)",
		expulsom = "Expulsom",
		expulsomReplace = "Replace trinkets rewards with Expulsom",
		enableBountyColors = "Enable bounty quests colors",
		calligraphyGameHelper = "Enable Calligraphy Helper",
		addQuestsNazjatar = "Add quests from Nazjatar",
		questsForAchievements = "Show quests for achievements",
		rewardSortOption = "Priority options",
		rewardSortCurrOther = "Other currencies",
		rewardSortItemOther = "Other items",
		aspirantTraining = "Aspirant Training Helper",
		toughCrowdHelper = "Tough Crowd Helper",
		disableQuestNumber = "Disable numbers on quest icons",
		repAccAlert = "Enable reputation award notification",
	} or
	locale == "ptBR" and {
		gear = "Equipamento",
		gold = "Ouro",
		blood = "Sangue de Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
		arrow = "Arrow",
		invasionPoints = "Invasion Points",
		argusMap = "Enable Argus map",
		ignoreList = "Ignore list",
		addQuestsOpposite = "Add quests from the opposite continent",
		hideLegion = "Hide quests from Legion",
		disableArrowMove = "Disable moving",
		shellGameHelper = "Enable Shell Game Helper",
		iconsOnMinimap = "Enable icons on General maps",
		addQuestsArgus = "Add quests from Argus",
		lfgSearchOption = "Enable LFG search",
		lfgAutoinvite = "Set autoinvite option on",
		lfgTypeText = "Type numbers (QuestID) to edit box",
		lfgLeftButtonClick = "Left Click - find group",
		lfgLeftButtonClick2 = "Left Click + shift - find group by name",
		lfgRightButtonClick = "Right Click - create group",
		lfgDisablePopup = "Disable popup in questarea",
		lfgDisableRightClickIcons = "Disable right click on map icons",
		disableRewardIcons = "Enable reward on map icons",
		mapIconsScale = "Map icons scale",
		disableRibbon = "Disable ribbon graphic",
		enableRibbonGeneralMap = "Enable ribbon on general maps",
		enableArrowQuests = "Enable arrow for regular quests",
		tryWithQuestID = "Try by quest ID",
		lfgDisableAll = "Disable all, except LFG",
		lfgDisableAll2 = "All addon settings will be lost. Disable all options, except LFG?",
		lfgDisableEyeRight = "Disable eye for quest tracker on right",
		lfgDisableEyeList = "Hide eye in list",
		listSize = "List size",
		topLine = "Top line",
		bottomLine = "Bottom line",
		unlimited = "Unlimited",
		maxLines = "Max lines",
		lfgDisablePopupLeave = "Disable popup after quest completion (leave party)",
		expulsom = "Expulsom",
		expulsomReplace = "Replace trinkets rewards with Expulsom",
		enableBountyColors = "Enable bounty quests colors",
		calligraphyGameHelper = "Enable Calligraphy Helper",
		addQuestsNazjatar = "Add quests from Nazjatar",
		questsForAchievements = "Show quests for achievements",
		rewardSortOption = "Priority options",
		rewardSortCurrOther = "Other currencies",
		rewardSortItemOther = "Other items",
		aspirantTraining = "Aspirant Training Helper",
		toughCrowdHelper = "Tough Crowd Helper",
		disableQuestNumber = "Disable numbers on quest icons",
		repAccAlert = "Enable reputation award notification",
	} or
	locale == "koKR" and {
		gear = "장비",
		gold = "골드",
		blood = "살게라스의 피",
		knowledgeTooltip = "** 다음 유물 지식 레벨에 도달한 후 완료할 수 있습니다",
		disableArrow = "화살표 비활성화",
		anchor = "고정기",
		totalap = "총 유물력: ",
		totalapdisable = '"총 유물력" 비활성화',
		timeToComplete = "완료까지 시간: ",
		bountyIgnoreFilter = "사절 퀘스트",
		enigmaHelper = "수수께끼 도우미 활성화",
		barrelsHelper = "통 토우미 활성화",
		honorIgnoreFilter = "PvP 퀘스트",
		ignoreFilter = "다음에 필터 무시",
		epicIgnoreFilter = '"금테" 퀘스트',
		wantedIgnoreFilter = "현상수배 퀘스트", 
		apFormatSetup = "유물력 형식",
		headerEnable = "제목 줄 활성화",
		disabeHighlightNewQuests = "새로운 퀘스트 강조 비활성화",
		distance = "거리",
		disableBountyIcon = "평판 이름에 사절 아이콘 비활성화",
		arrow = "화살표",
		invasionPoints = "침공 거점",
		argusMap = "아르거스 지도 활성화",
		ignoreList = "Ignore list",
		addQuestsOpposite = "Add quests from the opposite continent",
		hideLegion = "Hide quests from Legion",
		disableArrowMove = "Disable moving",
		shellGameHelper = "Enable Shell Game Helper",
		iconsOnMinimap = "Enable icons on General maps",
		addQuestsArgus = "Add quests from Argus",
		lfgSearchOption = "Enable LFG search",
		lfgAutoinvite = "Set autoinvite option on",
		lfgTypeText = "Type numbers (QuestID) to edit box",
		lfgLeftButtonClick = "Left Click - find group",
		lfgLeftButtonClick2 = "Left Click + shift - find group by name",
		lfgRightButtonClick = "Right Click - create group",
		lfgDisablePopup = "Disable popup in questarea",
		lfgDisableRightClickIcons = "Disable right click on map icons",
		disableRewardIcons = "Enable reward on map icons",
		mapIconsScale = "Map icons scale",
		disableRibbon = "Disable ribbon graphic",
		enableRibbonGeneralMap = "Enable ribbon on general maps",
		enableArrowQuests = "Enable arrow for regular quests",
		tryWithQuestID = "Try by quest ID",
		lfgDisableAll = "Disable all, except LFG",
		lfgDisableAll2 = "All addon settings will be lost. Disable all options, except LFG?",
		lfgDisableEyeRight = "Disable eye for quest tracker on right",
		lfgDisableEyeList = "Hide eye in list",
		listSize = "List size",
		topLine = "Top line",
		bottomLine = "Bottom line",
		unlimited = "Unlimited",
		maxLines = "Max lines",
		lfgDisablePopupLeave = "Disable popup after quest completion (leave party)",
		expulsom = "Expulsom",
		expulsomReplace = "Replace trinkets rewards with Expulsom",
		enableBountyColors = "Enable bounty quests colors",
		calligraphyGameHelper = "Enable Calligraphy Helper",
		addQuestsNazjatar = "Add quests from Nazjatar",
		questsForAchievements = "Show quests for achievements",
		rewardSortOption = "Priority options",
		rewardSortCurrOther = "Other currencies",
		rewardSortItemOther = "Other items",
		aspirantTraining = "Aspirant Training Helper",
		toughCrowdHelper = "Tough Crowd Helper",
		disableQuestNumber = "Disable numbers on quest icons",
		repAccAlert = "Enable reputation award notification",
	} or
	locale == "zhCN" and {	--by sprider00
		gear = "装备",
		gold = "金币",
		blood = "萨格拉斯之血",
		knowledgeTooltip = "** 在达到下个神器知识等级后完成",
		disableArrow = "关闭箭头",
		anchor = "锚点",
		totalap = "神器点数: ",
		totalapdisable = '禁用列表点数汇总',
		timeToComplete = "剩余: ",
		bountyIgnoreFilter = "宝箱任务",
		enigmaHelper = "开启解密助手",
		barrelsHelper = "开启欢乐桶助手",
		honorIgnoreFilter = "PvP 任务",
		ignoreFilter = "不过滤：",
		epicIgnoreFilter = '精英任务',
		wantedIgnoreFilter = "通缉任务", 
		apFormatSetup = "神器点显示格式",
		headerEnable = "显示标题栏",
		disabeHighlightNewQuests = "关闭新任务高亮",
		distance = "距离",
		disableBountyIcon = "关闭列表中大使任务的阵营图标",
		arrow = "箭头",
		invasionPoints = "入侵点",
		argusMap = "启用阿古斯地图",
		ignoreList = "忽略列表",
		addQuestsOpposite = "相应地图显示任务",
		hideLegion = "隐藏军团空袭任务",
		disableArrowMove = "锁定位置",
		shellGameHelper = "启用ShellGame助手",
		iconsOnMinimap = "地图上显示任务图标",
		addQuestsArgus = "列表中添加阿古斯任务",
		lfgSearchOption = "启用LFG搜索",
		lfgAutoinvite = "自动邀请选项",
		lfgTypeText = "任务ID类型",
		lfgLeftButtonClick = "查找(按任务名)：点击",
		lfgLeftButtonClick2 = "查找(按任务ID)：Shift+点击",
		lfgRightButtonClick = "创建(输入ID/任务名)：右键",
		lfgDisablePopup = "禁止自动弹出组队框",
		lfgDisableRightClickIcons = "禁用任务图标右键互动",
		disableRewardIcons = "图标上显示奖励",
		mapIconsScale = "任务图标缩放",
		disableRibbon = "关闭背景条",
		enableRibbonGeneralMap = "一般任务背景条",
		enableArrowQuests = "一般任务也启用箭头",
		tryWithQuestID = "刷新任务ID",
		lfgDisableAll = "禁用所有LFG",
		lfgDisableAll2 = "关闭所有LFG选项，LFG设置将丢失",
		lfgDisableEyeRight = "追踪的任务禁用眼睛",
		lfgDisableEyeList = "任务列表中禁用眼睛",
		listSize = "列表大小",
		topLine = "名称列",
		bottomLine = "总数列",
		unlimited = "无限制",
		maxLines = "列数上限",
		lfgDisablePopupLeave = "Disable popup after quest completion (leave party)",
		expulsom = "Expulsom",
		expulsomReplace = "Replace trinkets rewards with Expulsom",
		enableBountyColors = "Enable bounty quests colors",
		calligraphyGameHelper = "Enable Calligraphy Helper",
		addQuestsNazjatar = "Add quests from Nazjatar",
		questsForAchievements = "Show quests for achievements",
		rewardSortOption = "Priority options",
		rewardSortCurrOther = "Other currencies",
		rewardSortItemOther = "Other items",
		aspirantTraining = "Aspirant Training Helper",
		toughCrowdHelper = "Tough Crowd Helper",
		disableQuestNumber = "Disable numbers on quest icons",
		repAccAlert = "Enable reputation award notification",
	} or
	locale == "zhTW" and {	--by sprider00
		gear = "裝備",
		gold = "金幣",
		blood = "薩格拉斯之血",
		knowledgeTooltip = "** 可在達到下一個神器知識等級後完成",
		disableArrow = "禁用 箭頭",
		anchor = "外掛程式位置",
		totalap = "神兵之力總數：",
		totalapdisable = '禁用 "神兵之力總數"',
		timeToComplete = "剩餘時間：",
		bountyIgnoreFilter = "寶箱任務",
		enigmaHelper = "開啟迷宮助手",
		barrelsHelper = "開啟桶樂會助手",
		honorIgnoreFilter = "PvP 任務",
		ignoreFilter = "不過濾：",
		epicIgnoreFilter = '精英任務',
		wantedIgnoreFilter = "通緝任務", 
		apFormatSetup = "神兵之力數位格式",
		headerEnable = "開啟 標題行",
		disabeHighlightNewQuests = "禁用新任務高亮",
		distance = "距離",
		disableBountyIcon = "大使任務不在清單中顯示派系圖示",
		arrow = "箭頭",
		invasionPoints = "入侵點",
		argusMap = "啟用阿古斯地圖",
		ignoreList = "忽略列表",
		addQuestsOpposite = "顯示對面地圖的任務",
		hideLegion = "隱藏軍團入侵的任務",
		disableArrowMove = "鎖定箭頭位置",
		shellGameHelper = "開啟龜殼遊戲助手",
		iconsOnMinimap = "大地圖上顯示任務圖示",
		addQuestsArgus = "顯示阿古斯的任務",
		lfgSearchOption = "啟用預組搜索",
		lfgAutoinvite = "自動邀請設定",
		lfgTypeText = "輸入任務ID",
		lfgLeftButtonClick = "左鍵 - 尋找隊伍（任務ID）",
		lfgLeftButtonClick2 = "SHIFT + 左鍵 - 尋找隊伍（任務名稱）",
		lfgRightButtonClick = "右鍵 - 編組隊伍",
		lfgDisablePopup = "禁止自動彈出組隊框架",
		lfgDisableRightClickIcons = "禁用任務圖示右鍵互動",
		disableRewardIcons = "地圖圖標顯示獎勵",
		mapIconsScale = "地圖圖標大小",
		disableRibbon = "禁用背景條",
		enableRibbonGeneralMap = "大地圖圖標上顯示背景條",
		enableArrowQuests = "一般任務啟用箭頭",
		tryWithQuestID = "刷新任務ID",
		lfgDisableAll = "禁用所有設定，除了預組",
		lfgDisableAll2 = "所有設定將會丟失。確定禁用所有設定，除了預組？",
		lfgDisableEyeRight = "追蹤任務禁用眼睛",
		lfgDisableEyeList = "任務列表禁用眼睛",
		listSize = "列表大小",
		topLine = "名稱列",
		bottomLine = "總數列",
		unlimited = "無限制",
		maxLines = "列數上限",
		lfgDisablePopupLeave = "Disable popup after quest completion (leave party)",
		expulsom = "Expulsom",
		expulsomReplace = "Replace trinkets rewards with Expulsom",
		enableBountyColors = "Enable bounty quests colors",
		calligraphyGameHelper = "Enable Calligraphy Helper",
		addQuestsNazjatar = "Add quests from Nazjatar",
		questsForAchievements = "Show quests for achievements",
		rewardSortOption = "Priority options",
		rewardSortCurrOther = "Other currencies",
		rewardSortItemOther = "Other items",
		aspirantTraining = "Aspirant Training Helper",
		toughCrowdHelper = "Tough Crowd Helper",
		disableQuestNumber = "Disable numbers on quest icons",
		repAccAlert = "Enable reputation award notification",
	} or 
	{
		gear = "Gear",
		gold = "Gold",
		blood = "Blood of Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
		arrow = "Arrow",
		invasionPoints = "Invasion Points",
		argusMap = "Enable Argus map",
		ignoreList = "Ignore list",
		addQuestsOpposite = "Add quests from the opposite continent",
		hideLegion = "Hide quests from Legion",
		disableArrowMove = "Disable moving",
		shellGameHelper = "Enable Shell Game Helper",
		iconsOnMinimap = "Enable icons on General maps",
		addQuestsArgus = "Add quests from Argus",
		lfgSearchOption = "Enable LFG search",
		lfgAutoinvite = "Set autoinvite option on",
		lfgTypeText = "Type numbers (QuestID) to edit box",
		lfgLeftButtonClick = "Left Click - find group",
		lfgLeftButtonClick2 = "Left Click + shift - find group by name",
		lfgRightButtonClick = "Right Click - create group",
		lfgDisablePopup = "Disable popup in questarea",
		lfgDisableRightClickIcons = "Disable right click on map icons",
		disableRewardIcons = "Enable reward on map icons",
		mapIconsScale = "Map icons scale",
		disableRibbon = "Disable ribbon graphic",
		enableRibbonGeneralMap = "Enable ribbon on general maps",
		enableArrowQuests = "Enable arrow for regular quests",
		tryWithQuestID = "Try by quest ID",
		lfgDisableAll = "Disable all, except LFG",
		lfgDisableAll2 = "All addon settings will be lost. Disable all options, except LFG?",
		lfgDisableEyeRight = "Disable eye for quest tracker on right",
		lfgDisableEyeList = "Hide eye in list",
		listSize = "List size",
		topLine = "Top line",
		bottomLine = "Bottom line",
		unlimited = "Unlimited",
		maxLines = "Max lines",
		lfgDisablePopupLeave = "Disable popup after quest completion (leave party)",
		expulsom = "Expulsom",
		expulsomReplace = "Replace trinkets rewards with Expulsom",
		enableBountyColors = "Enable emissary quests colors",
		calligraphyGameHelper = "Enable Calligraphy Helper",
		addQuestsNazjatar = "Add quests from Nazjatar",
		questsForAchievements = "Show quests for achievements",
		rewardSortOption = "Priority options",
		rewardSortCurrOther = "Other currencies",
		rewardSortItemOther = "Other items",
		aspirantTraining = "Aspirant Training Helper",
		toughCrowdHelper = "Tough Crowd Helper",
		disableQuestNumber = "Disable numbers on quest icons",
		repAccAlert = "Enable reputation award notification",
	}

local filters = {
	{LOCALE.gear,2^0},
	{LE.ARTIFACT_POWER,2^1},
	{LE.ORDER_RESOURCES_NAME_LEGION,2^2},
	{LOCALE.blood,2^5},
	{LOCALE.gold,2^3},
	{OTHER,2^4},
}
local ActiveFilter = 2 ^ #filters - 1
local ActiveFilterType

local ActiveSort = 5

local UpdateScale
local UpdateAnchor

local DEBUG = false

local defSortPrio = {
	bounty_cache = 0.6,
	azerite = 1,
	anima = 1.5,
	curr1560 = 2,
	curr1721 = 3,
	curr1508 = 4,
	curr1533 = 5,
	rep = 6,
	currother = 7,
	gold = 8,
	honor = 9,
	itemcraft = 10,
	itemgear = 11,
	itemunk = 12,
	pet = 13,
	other = 14,

	curr2815 = 12.5,
	curr3008 = 12.5,
	dragonriding = 12.6,
}

local ELib = WQLdb.ELib

local WorldQuestList_Update

local UpdateTicker = nil


local WorldQuestList

local WorldQuestList_Width = 450+70
local WorldQuestList_ZoneWidth = 100

--local WorldMapFrame = TestWorldMapFrame
local WorldMapButton = WorldMapFrame.ScrollContainer.Child

WorldQuestList = CreateFrame("Frame","WorldQuestsListFrame",WorldMapFrame)
WorldQuestList:SetPoint("TOPLEFT",WorldMapFrame,"TOPRIGHT",10,-4)
WorldQuestList:SetSize(550,300)

--WorldQuestList:SetClampedToScreen(true)
--WorldQuestList:SetClampRectInsets(0, 0, 30, 0)

_G.WorldQuestList = WorldQuestList

if WQLdb.ToMain then
	for k,v in pairs(WQLdb.ToMain) do
		if not WorldQuestList[k] then
			WorldQuestList[k] = v
		end
	end
end
WorldQuestList.Arrow = WQLdb.Arrow

local TomTomCache = {}
function WorldQuestList.AddArrow(x,y,questID,name,hideRange,arrowFunc)
	if VWQL.DisableArrow or VWQL.ArrowStyle == 2 then
		return
	end
	WQLdb.Arrow:ShowRunTo(x,y,hideRange or 40,nil,true,nil,nil,arrowFunc)
end

function WorldQuestList.AddArrowNWC(x,y,mapID,questID,name,hideRange)
	if VWQL.DisableArrow or VWQL.ArrowStyle ~= 2 then
		return
	end
	if type(TomTom)=='table' and type(TomTom.AddWaypoint)=='function' then
		local uid = TomTom:AddWaypoint(mapID, x, y, {title = name})
		TomTomCache[questID or 0] = uid
	end
end

WorldQuestList:SetScript("OnHide",function(self)
	WorldQuestList.IsSoloRun = false
	if VWQL.Anchor == 1 then
		WorldQuestList.moveHeader:Hide()
	end
	if self:GetParent() ~= WorldMapFrame then
		self:SetParent(WorldMapFrame)
		UpdateAnchor()
	end
	WorldQuestList.Cheader:SetVerticalScroll(0)
	WorldQuestList.Close:Hide()
end)
WorldQuestList:SetScript("OnShow",function(self)
	if not WorldQuestList.IsSoloRun then
		--UpdateAnchor(true)
	end
	C_Timer.After(2.5,function()
		UpdateTicker = true
	end)
end)

WorldQuestList.Cheader = CreateFrame("ScrollFrame", nil, WorldQuestList) 
WorldQuestList.Cheader:SetPoint("LEFT")
WorldQuestList.Cheader:SetPoint("RIGHT")
WorldQuestList.Cheader:SetPoint("BOTTOM")
WorldQuestList.Cheader:SetPoint("TOP")

WorldQuestList.Cheader.lines = {}
for i=1,100 do
	local line = CreateFrame("Frame",nil,WorldQuestList.Cheader)
	line:SetPoint("TOPLEFT",0,-(i-1)*16)
	line:SetSize(1,16)
	WorldQuestList.Cheader.lines[i] = line
end

WorldQuestList.C = CreateFrame("Frame", nil, WorldQuestList.Cheader) 
WorldQuestList.Cheader:SetScrollChild(WorldQuestList.C)
WorldQuestList.Cheader:SetScript("OnMouseWheel", function (self,delta)
	delta = delta * 16
	local max = max(0 , WorldQuestList.C:GetHeight() - self:GetHeight() )
	local val = self:GetVerticalScroll()
	if (val - delta) < 0 then
		self:SetVerticalScroll(0)
	elseif (val - delta) > max then
		self:SetVerticalScroll(max)
	else
		self:SetVerticalScroll(val - delta)
	end
end)
WorldQuestList.C:SetWidth(WorldQuestList_Width)

local function UpdateScrollButtonsState()
	local val = WorldQuestList.Cheader:GetVerticalScroll()

	if val > 3.5 then
		WorldQuestList.ScrollUpLine:Show()
	else
		WorldQuestList.ScrollUpLine:Hide()
	end

	local maxScroll = WorldQuestList.Cheader:GetVerticalScrollRange()
	if maxScroll > 4.5 and not ((maxScroll - val) < 5) then
		WorldQuestList.ScrollDownLine:Show()
	else
		WorldQuestList.ScrollDownLine:Hide()
	end

	if WorldQuestList.currentResult and #WorldQuestList.currentResult == 0 then
		WorldQuestList.ScrollUpLine:Hide()
		WorldQuestList.ScrollDownLine:Hide()
	end
end

WorldQuestList.Cheader:SetScript("OnVerticalScroll",function(self,val)
	UpdateScrollButtonsState()
end)

WorldQuestList.SCROLL_FIX_BOTTOM = 0
WorldQuestList.SCROLL_FIX_TOP = 0

WorldQuestList.ScrollDownLine = CreateFrame("Button", nil, WorldQuestList)
WorldQuestList.ScrollDownLine:SetPoint("LEFT",0,0)
WorldQuestList.ScrollDownLine:SetPoint("RIGHT",0,0)
WorldQuestList.ScrollDownLine:SetPoint("BOTTOM",WorldQuestList.Cheader,0,-1)
WorldQuestList.ScrollDownLine:SetHeight(16)
WorldQuestList.ScrollDownLine:SetFrameLevel(120)
WorldQuestList.ScrollDownLine:Hide()
WorldQuestList.ScrollDownLine:SetScript("OnEnter",function(self)
	self.entered = true
	self.timer = C_Timer.NewTicker(.05,function(timer)
		if not self.entered then
			self.timer:Cancel()
			self.timer = nil
			return
		end
		local limit = WorldQuestList.C:GetHeight()
		local curr = WorldQuestList.Cheader:GetVerticalScroll()
		WorldQuestList.Cheader:SetVerticalScroll(min(curr + 4,limit - WorldQuestList.Cheader:GetHeight() + 14))
	end)
end)
WorldQuestList.ScrollDownLine:SetScript("OnLeave",function(self)
	self.entered = nil
end)
WorldQuestList.ScrollDownLine:SetScript("OnHide",function(self)
	if self.timer then
		self.timer:Cancel()
	end
	self.timer = nil
	self.entered = nil
end)
WorldQuestList.ScrollDownLine:SetScript("OnClick",function(self)
	local limit = WorldQuestList.C:GetHeight()
	WorldQuestList.Cheader:SetVerticalScroll(limit - WorldQuestList.Cheader:GetHeight())
end)

WorldQuestList.ScrollDownLine.b = WorldQuestList.ScrollDownLine:CreateTexture(nil,"BACKGROUND")
WorldQuestList.ScrollDownLine.b:SetAllPoints()
WorldQuestList.ScrollDownLine.b:SetColorTexture(.3,.3,.3,.9)

WorldQuestList.ScrollDownLine.i = WorldQuestList.ScrollDownLine:CreateTexture(nil,"ARTWORK")
WorldQuestList.ScrollDownLine.i:SetTexture("Interface\\AddOns\\WorldQuestsList\\navButtons")
WorldQuestList.ScrollDownLine.i:SetPoint("CENTER")
WorldQuestList.ScrollDownLine.i:SetTexCoord(0,.25,0,1)
WorldQuestList.ScrollDownLine.i:SetSize(14,14)


WorldQuestList.ScrollUpLine = CreateFrame("Button", nil, WorldQuestList)
WorldQuestList.ScrollUpLine:SetPoint("LEFT",0,0)
WorldQuestList.ScrollUpLine:SetPoint("RIGHT",0,0)
WorldQuestList.ScrollUpLine:SetPoint("TOP",WorldQuestList.Cheader,0,0)
WorldQuestList.ScrollUpLine:SetHeight(16)
WorldQuestList.ScrollUpLine:SetFrameLevel(120)
WorldQuestList.ScrollUpLine:Hide()
WorldQuestList.ScrollUpLine:SetScript("OnEnter",function(self)
	self.entered = true
	self.timer = C_Timer.NewTicker(.05,function(timer)
		if not self.entered then
			self.timer:Cancel()
			self.timer = nil
			return
		end
		local limit = WorldQuestList.C:GetHeight()
		local curr = WorldQuestList.Cheader:GetVerticalScroll()
		WorldQuestList.Cheader:SetVerticalScroll(max(curr - 4,0))
	end)
end)
WorldQuestList.ScrollUpLine:SetScript("OnLeave",function(self)
	self.entered = nil
end)
WorldQuestList.ScrollUpLine:SetScript("OnHide",function(self)
	if self.timer then
		self.timer:Cancel()
	end
	self.timer = nil
	self.entered = nil
end)
WorldQuestList.ScrollUpLine:SetScript("OnClick",function(self)
	WorldQuestList.Cheader:SetVerticalScroll(0)
end)

WorldQuestList.ScrollUpLine.b = WorldQuestList.ScrollUpLine:CreateTexture(nil,"BACKGROUND")
WorldQuestList.ScrollUpLine.b:SetAllPoints()
WorldQuestList.ScrollUpLine.b:SetColorTexture(.3,.3,.3,.9)

WorldQuestList.ScrollUpLine.i = WorldQuestList.ScrollUpLine:CreateTexture(nil,"ARTWORK")
WorldQuestList.ScrollUpLine.i:SetTexture("Interface\\AddOns\\WorldQuestsList\\navButtons")
WorldQuestList.ScrollUpLine.i:SetPoint("CENTER")
WorldQuestList.ScrollUpLine.i:SetTexCoord(.25,.5,0,1)
WorldQuestList.ScrollUpLine.i:SetSize(14,14)

WorldQuestList.b = WorldQuestList:CreateTexture(nil,"BACKGROUND")
WorldQuestList.b:SetAllPoints()
WorldQuestList.b:SetColorTexture(0.04,0.04,0.04,.97)
WorldQuestList.b.A = .97

WorldQuestList.backdrop = CreateFrame("Frame",nil,WorldQuestList)
WorldQuestList.backdrop:SetAllPoints()

ELib.Templates:Border(WorldQuestList.backdrop,.3,.3,.3,1,1)
WorldQuestList.shadow = ELib:Shadow(WorldQuestList.backdrop,20,28)

WorldQuestList.mapC = WorldMapButton:CreateTexture(nil,"OVERLAY")
WorldQuestList.mapC:SetSize(50,50)
WorldQuestList.mapC:SetTexture("Interface\\AddOns\\WorldQuestsList\\Button-Pushed")
WorldQuestList.mapC:Hide()

WorldQuestList.mapC = CreateFrame("Frame", nil, WorldMapButton)
WorldQuestList.mapC:SetFrameStrata("TOOLTIP")
WorldQuestList.mapC:SetSize(3,3)
WorldQuestList.mapC:Hide()

WorldQuestList.mapCs = WorldQuestList.mapC:CreateTexture(nil,"OVERLAY",nil,7)
WorldQuestList.mapCs:SetSize(50*3,50*3)
WorldQuestList.mapCs:SetTexture("Interface\\AddOns\\WorldQuestsList\\Button-Pushed")
WorldQuestList.mapCs:SetPoint("CENTER")
WorldQuestList.mapC:Hide()

WorldQuestList.mapD = WorldQuestList.mapC:CreateTexture(nil,"OVERLAY",nil,7)
WorldQuestList.mapD:SetSize(24*3,24*3)
WorldQuestList.mapD:SetAtlas("XMarksTheSpot")
WorldQuestList.mapD:SetPoint("CENTER",WorldQuestList.mapC)
WorldQuestList.mapD:Hide()

WorldQuestList.Close = CreateFrame("Button",nil,WorldQuestList)
WorldQuestList.Close:SetPoint("BOTTOMLEFT",WorldQuestList,"TOPRIGHT",1,1)
WorldQuestList.Close:SetSize(22,22)
WorldQuestList.Close:SetScript("OnClick",function()
	WorldQuestList:Hide()
	if not (WorldMapFrame:IsVisible() and WorldMapFrame:IsMaximized() and (VWQL.Anchor == 1 or not VWQL.Anchor)) then
		WorldQuestList:Show()
	end
end)
WorldQuestList.Close:Hide()

ELib.Templates:Border(WorldQuestList.Close,.22,.22,.3,1,1)
WorldQuestList.Close.shadow = ELib:Shadow2(WorldQuestList.Close,16)

WorldQuestList.Close.X = WorldQuestList.Close:CreateFontString(nil,"ARTWORK","GameFontWhite")
WorldQuestList.Close.X:SetPoint("CENTER",WorldQuestList.Close)
WorldQuestList.Close.X:SetText("X")
do
	local a1,a2 = WorldQuestList.Close.X:GetFont()
	WorldQuestList.Close.X:SetFont(a1,14)
end
WorldQuestList.Close.b = WorldQuestList.Close:CreateTexture(nil,"BACKGROUND")
WorldQuestList.Close.b:SetAllPoints()
WorldQuestList.Close.b:SetColorTexture(0.14,0.04,0.04,.97)

WorldQuestList.Close.hl = WorldQuestList.Close:CreateTexture(nil, "BACKGROUND",nil,1)
WorldQuestList.Close.hl:SetPoint("TOPLEFT", 0, 0)
WorldQuestList.Close.hl:SetPoint("BOTTOMRIGHT", 0, 0)
WorldQuestList.Close.hl:SetTexture("Interface\\Buttons\\WHITE8X8")
WorldQuestList.Close.hl:SetVertexColor(1,.7,.7,.25)
WorldQuestList.Close.hl:Hide()

WorldQuestList.Close:SetScript("OnEnter",function(self) self.hl:Show() end)
WorldQuestList.Close:SetScript("OnLeave",function(self) self.hl:Hide() end)


local ArrowsHelpFrame = CreateFrame("Frame",nil,WorldMapButton) 
ArrowsHelpFrame:SetFrameStrata("TOOLTIP")
ArrowsHelpFrame:SetSize(40,40)
ArrowsHelpFrame:SetPoint("CENTER")
ArrowsHelpFrame:Hide()
ArrowsHelpFrame.t = -1
ArrowsHelpFrame:SetScript("OnShow",function(self)
	self.t = 3
	self.map = GetCurrentMapID()
end)
ArrowsHelpFrame:SetScript("OnUpdate",function(self,tmr)
	self.t = self.t - tmr
	if self.t <= 0 or self.map ~= GetCurrentMapID() then
		self:Hide()
		return
	end
end)
WorldQuestList.ArrowsHelpFrame = ArrowsHelpFrame

ArrowsHelpFrame.top = CreateFrame("PlayerModel",nil,ArrowsHelpFrame)
ArrowsHelpFrame.top:SetPoint("BOTTOM",ArrowsHelpFrame,"TOP",0,0)
ArrowsHelpFrame.top:SetSize(48,48)
ArrowsHelpFrame.top:SetMouseClickEnabled(false)
ArrowsHelpFrame.top:SetMouseMotionEnabled(false)
ArrowsHelpFrame.top:SetDisplayInfo(63509)
ArrowsHelpFrame.top:SetRoll(0)

ArrowsHelpFrame.bottom = CreateFrame("PlayerModel",nil,ArrowsHelpFrame)
ArrowsHelpFrame.bottom:SetPoint("TOP",ArrowsHelpFrame,"BOTTOM",0,0)
ArrowsHelpFrame.bottom:SetSize(48,48)
ArrowsHelpFrame.bottom:SetMouseClickEnabled(false)
ArrowsHelpFrame.bottom:SetMouseMotionEnabled(false)
ArrowsHelpFrame.bottom:SetDisplayInfo(63509)
ArrowsHelpFrame.bottom:SetRoll(-math.pi)

ArrowsHelpFrame.left = CreateFrame("PlayerModel",nil,ArrowsHelpFrame)
ArrowsHelpFrame.left:SetPoint("RIGHT",ArrowsHelpFrame,"LEFT",0,0)
ArrowsHelpFrame.left:SetSize(48,48)
ArrowsHelpFrame.left:SetMouseClickEnabled(false)
ArrowsHelpFrame.left:SetMouseMotionEnabled(false)
ArrowsHelpFrame.left:SetDisplayInfo(63509)
ArrowsHelpFrame.left:SetRoll(math.pi / 2)

ArrowsHelpFrame.right = CreateFrame("PlayerModel",nil,ArrowsHelpFrame)
ArrowsHelpFrame.right:SetPoint("LEFT",ArrowsHelpFrame,"RIGHT",0,0)
ArrowsHelpFrame.right:SetSize(48,48)
ArrowsHelpFrame.right:SetMouseClickEnabled(false)
ArrowsHelpFrame.right:SetMouseMotionEnabled(false)
ArrowsHelpFrame.right:SetDisplayInfo(63509)
ArrowsHelpFrame.right:SetRoll(-math.pi / 2)



WorldQuestList:RegisterEvent('ADDON_LOADED')
if UnitLevel'player' < 70 then
	WorldQuestList:RegisterEvent('PLAYER_LEVEL_UP')
end
WorldQuestList:RegisterEvent('QUEST_REMOVED')
WorldQuestList:SetScript("OnEvent",function(self,event,...)
	if event == 'ADDON_LOADED' then
		self:UnregisterEvent('ADDON_LOADED')

		if type(_G.VWQL)~='table' then
			_G.VWQL = {
				VERSION = VERSION,
				Scale = 0.8,
				DisableIconsGeneralMap947 = true,
				AzeriteFormat = 20,
				--DisableRewardIcons = true,
				HideLegion = true,
				DisableLFG_Popup = true,
			}
		end
		VWQL = _G.VWQL

		VWQL[charKey] = VWQL[charKey] or {}

		VWQL[charKey].Quests = VWQL[charKey].Quests or {}

		VWQL[charKey].Filter = VWQL[charKey].Filter and tonumber(VWQL[charKey].Filter) or ActiveFilter
		ActiveFilter = VWQL[charKey].Filter

		VWQL[charKey].FilterType = VWQL[charKey].FilterType or {}
		ActiveFilterType = VWQL[charKey].FilterType

		VWQL.Sort = VWQL.Sort and tonumber(VWQL.Sort) or ActiveSort
		ActiveSort = VWQL.Sort

		VWQL.SortPrio = VWQL.SortPrio or {}

		VWQL.Ignore = VWQL.Ignore or {}

		WorldQuestList.WorldMapHideWQLCheck:SetChecked(not VWQL[charKey].HideMap)

		if not (type(VWQL[charKey].VERSION)=='number') or VWQL[charKey].VERSION < 51 then
			--WorldQuestList:ForceModeCheck()
		end
		if not (type(VWQL.VERSION)=='number') or VWQL.VERSION < 51 then
			VWQL.AzeriteFormat = 20
			VWQL.DisableIconsGeneralMap947 = true
		end
		if not (type(VWQL.VERSION)=='number') or VWQL.VERSION < 66 then
			--VWQL.DisableRewardIcons = true
		end
		if not (type(VWQL.VERSION)=='number') or VWQL.VERSION < 69 then
			if type(VWQL.MapIconsScale)=='number' and VWQL.MapIconsScale < 1 then
				VWQL.MapIconsScale = 1
			end
		end
		if not (type(VWQL.VERSION)=='number') or VWQL.VERSION < 71 then
			VWQL.Anchor3PosLeft = nil
			VWQL.Anchor3PosTop = nil
		end
		if not (type(VWQL.VERSION)=='number') or VWQL.VERSION < 91 then
			VWQL.LFG_HideEyeInList = true
		end

		WorldQuestList.modeSwitcherCheck:AutoSetValue()

		UpdateScale()
		UpdateAnchor()
		WorldQuestList.header:Update()

		WorldQuestList.ViewAllButton:Update()

		if WQLdb.Arrow then
			if VWQL.Arrow_PointX and VWQL.Arrow_PointY and VWQL.Arrow_Point1 and VWQL.Arrow_Point2 then
				WQLdb.Arrow:LoadPosition(VWQL.Arrow_Point1,UIParent,VWQL.Arrow_Point2,VWQL.Arrow_PointX,VWQL.Arrow_PointY)
			else
				WQLdb.Arrow:LoadPosition("TOP",UIParent,"TOP",0,-100)
			end

			if VWQL.Arrow_Scale then
				WQLdb.Arrow:Scale(tonumber(VWQL.Arrow_Scale) or 1)
			end

			if VWQL.DisableArrowMove then
				WQLdb.Arrow.frame:SetMovable(false)
			end
		end

		if WorldQuestList.QuestCreationBox and VWQL.AnchorQCBLeft and VWQL.AnchorQCBTop then
			WorldQuestList.QuestCreationBox:ClearAllPoints()
			WorldQuestList.QuestCreationBox:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",VWQL.AnchorQCBLeft,VWQL.AnchorQCBTop)
		end

		VWQL.VERSION = VERSION
		VWQL[charKey].VERSION = VERSION
	elseif event == 'QUEST_REMOVED' then
		local questID = ...
		if questID and TomTomCache[questID] then
			local qKey = TomTomCache[questID]
			if type(qKey) == 'table' and type(TomTom) == 'table' then
				TomTom:RemoveWaypoint(qKey)
			end
		end
	elseif event == "PLAYER_LEVEL_UP" then
		C_Timer.After(1,function()
			WorldQuestList:ForceModeCheck()
		end)
	end
end)


local HookWQbuttons
do
	local hooked = {}
	local hookFunc = function(self,button)
		if self.clickData then
			local x,y = WorldQuestList:GetQuestWorldCoord2(-1,self.clickData.mapID,self.clickData.x,self.clickData.y,true)
			if x and y then
				WorldQuestList.AddArrow(x,y,nil,nil,5,self.arrowFunc)
			end
		elseif self.questID then
			local mapCanvas = self:GetMap()
			local mapID = mapCanvas and mapCanvas:GetMapID() or 0
			local x,y = self:GetPosition()

			if (VWQL and not VWQL.DisableLFG and not VWQL.DisableLFG_RightClickIcon) and button == "RightButton" then
				if WorldMapFrame:IsMaximized() or WorldMapFrame:IsVisible() then
					ToggleWorldMap()
				end
				if C_LFGList.CanCreateQuestGroup(self.questID) then
					LFGListUtil_FindQuestGroup(self.questID)
				else
					WorldQuestList.LFG_Search(self.questID)
				end
			end

			do
				local name = C_TaskQuest.GetQuestInfoByQuestID(self.questID) or ""
				WorldQuestList.AddArrowNWC(x,y,mapID,self.questID,name)
			end
			if x and y then
				local continentID, worldPos = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(x, y))
				if worldPos then
					local wy,wx = worldPos:GetXY()
					if wx and wy then
						local name = C_TaskQuest.GetQuestInfoByQuestID(self.questID) or ""
						WorldQuestList.AddArrow(wx,wy,self.questID,name)
						return
					end
				end
			end
			local x,y = WorldQuestList:GetQuestWorldCoord(self.questID)
			if x and y then
				local name = C_TaskQuest.GetQuestInfoByQuestID(self.questID) or ""
				WorldQuestList.AddArrow(x,y,self.questID,name)
			end
		end
	end
	local hookQuestFunc = function(self,button)
		if self.questID then
			if not self:GetMap() then return end
			local mapID = self:GetMap():GetMapID()
			local x,y = self:GetPosition()
			if (VWQL and not VWQL.DisableLFG and not VWQL.DisableLFG_RightClickIcon) and button == "RightButton" and not IsQuestComplete(self.questID) then
				if WorldMapFrame:IsMaximized() and WorldMapFrame:IsVisible() then
					ToggleWorldMap()
				end
				if C_LFGList.CanCreateQuestGroup(self.questID) then
					LFGListUtil_FindQuestGroup(self.questID)
				else
					WorldQuestList.LFG_Search(self.questID)
				end
			end
			if x and y then
				local continentID, worldPos = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(x, y))
				if worldPos then
					local wy,wx = worldPos:GetXY()
					if wx and wy and VWQL and VWQL.EnableArrowQuest then
						local name = C_QuestLog.GetTitleForQuestID(self.questID) or C_TaskQuest.GetQuestInfoByQuestID(self.questID) or ""
						WorldQuestList.AddArrow(wx,wy,self.questID,name)
						WorldQuestList.AddArrowNWC(x,y,mapID,self.questID,name)
						return
					end
				end
				x,y = WorldQuestList:GetQuestWorldCoord2(self.questID,GetCurrentMapID(),x,y,true)
				if x and y and VWQL and VWQL.EnableArrowQuest then
					local questIndex = C_QuestLog.GetLogIndexForQuestID(self.questID)
					local name = GetQuestLogTitle(questIndex) or ""
					WorldQuestList.AddArrow(x,y,self.questID,name)
				end
			end
		end
	end
	local hookVignetteFunc = function(self,button)
		if self.vignetteInfo and (self.vignetteInfo.atlasName == "VignetteLoot" or self.vignetteInfo.atlasName == "VignetteLootElite") then
			local mapID = self:GetMap():GetMapID()
			if not self:GetMap() then return end
			local x,y = self:GetPosition()
			if x and y then
				local wx,wy = WorldQuestList:GetMapCoordAdj(x,y,mapID)
				if x and y and VWQL and VWQL.EnableArrowQuest then
					WorldQuestList.AddArrow(wx,wy)
					WorldQuestList.AddArrowNWC(x,y,mapID,nil,self.vignetteInfo.name)

					C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y))
					C_SuperTrack.SetSuperTrackedUserWaypoint(true)
				end
			end
		end
	end
	WorldQuestList.hookClickFunc = hookFunc
	WorldQuestList.hookQuestClickFunc = hookQuestFunc
	function HookWQbuttons()
		if WorldMapFrame.pinPools then
			for button in WorldMapFrame:EnumeratePinsByTemplate("WorldMap_WorldQuestPinTemplate") do
				if not hooked[button] then
					button:HookScript("OnMouseUp",hookFunc)
					hooked[button] = true
				end
			end
			for button in WorldMapFrame:EnumeratePinsByTemplate("QuestPinTemplate") do
				if not hooked[button] then
					button:HookScript("OnMouseUp",hookQuestFunc)
					hooked[button] = true
				end
			end
			for button in WorldMapFrame:EnumeratePinsByTemplate("ThreatObjectivePinTemplate") do
				if not hooked[button] then
					button:HookScript("OnMouseUp",hookQuestFunc)
					hooked[button] = true
				end
			end
			for button in WorldMapFrame:EnumeratePinsByTemplate("VignettePinTemplate") do
				if not hooked[button] then
					button:HookScript("OnMouseUp",hookVignetteFunc)
					hooked[button] = true
				end
			end
		end

	end
end


do
	local realmsDB = WQLdb.RealmRegion or {}
	function WorldQuestList:GetCurrentRegion()
		if WorldQuestList.currentRegion then
			return WorldQuestList.currentRegion
		end
		local guid = UnitGUID("player")
		local _,serverID = strsplit("-",guid)
		local regionID = 0
		if serverID then
			regionID = realmsDB[tonumber(serverID) or -1] or 0
		end
		WorldQuestList.currentRegion = regionID
		return regionID
	end

end

do
	local resetTimes = {
		[1] = 1505228400,	--us
		[2] = 1505286000,	--eu
	}
	function WorldQuestList:GetNextResetTime(region)
		if region and resetTimes[region] then
			local t = resetTimes[region]
			local c = GetServerTime()
			while t < c do
				t = t + 604800
			end
			return (t - c) / 60
		end
	end

end

do
	local Zones = {
		[619] = "Legion",
		[790] = "Legion",
		[630] = "Legion",
		[627] = "Legion",
		[641] = "Legion",
		[680] = "Legion",
		[650] = "Legion",
		[634] = "Legion",
		[646] = "Legion",
		[905] = "Legion",
		[885] = "Legion",
		[882] = "Legion",
		[830] = "Legion",
		[864] = "Bfa",
		[863] = "Bfa",
		[862] = "Bfa",
		[1165] = "Bfa",
		[875] = "Bfa",
		[942] = "Bfa",
		[896] = "Bfa",
		[895] = "Bfa",
		[876] = "Bfa",
		[1161] = "Bfa",
		[1169] = "Bfa",
	}
	function WorldQuestList:IsLegionZone(mapID)
		mapID = mapID or GetCurrentMapID()
		if Zones[mapID] == "Legion" then
			return true
		else
			return false
		end
	end

	function WorldQuestList:IsBfaZone(mapID)
		mapID = mapID or GetCurrentMapID()
		if Zones[mapID] == "Bfa" then
			return true
		else
			return false
		end
	end

	function WorldQuestList:IsShadowlandsZone(mapID)
		mapID = mapID or GetCurrentMapID()
		if mapID >= 1525 and mapID < 2022 and mapID ~= 1978 then
			return true
		else
			return false
		end
	end

	function WorldQuestList:IsDragonflightZone(mapID)
		mapID = mapID or GetCurrentMapID()
		if mapID >= 2022 or mapID == 1978 then
			return true
		else
			return false
		end
	end
end

do
	local cache = {}
	function WorldQuestList:GetMapName(mapID)
		if not cache[mapID] then
			cache[mapID] = (C_Map.GetMapInfo(mapID or 0) or {}).name or ("Map ID "..mapID)
		end
		return cache[mapID]
	end
end

do
	function WorldQuestList:AtlasToText(atlasName,widthInText,heightInText)
		local info = C_Texture.GetAtlasInfo(atlasName)

		local textureWidth,textureHeight = info.width/(info.rightTexCoord-info.leftTexCoord), info.height/(info.bottomTexCoord-info.topTexCoord)

		return "|T"..info.file..":"..(widthInText or 16)..":"..(heightInText or 16)..":0:0:"..textureWidth..":"..textureHeight..":"..
			format("%d",info.leftTexCoord*textureWidth)..":"..format("%d",info.rightTexCoord*textureWidth)..":"..format("%d",info.topTexCoord*textureHeight)..":"..format("%d",info.bottomTexCoord*textureHeight).."|t"
	end
	local mapIcons = {
		[619] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[790] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[630] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[627] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[641] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[680] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[650] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[634] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[646] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[905] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[885] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[882] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[830] = WorldQuestList:AtlasToText("worldquest-icon-burninglegion"),
		[864] = "|TInterface\\FriendsFrame\\PlusManz-Horde:16|t",
		[863] = "|TInterface\\FriendsFrame\\PlusManz-Horde:16|t",
		[862] = "|TInterface\\FriendsFrame\\PlusManz-Horde:16|t",
		[1165] = "|TInterface\\FriendsFrame\\PlusManz-Horde:16|t",
		[875] = "|TInterface\\FriendsFrame\\PlusManz-Horde:16|t",
		[942] = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16|t",
		[896] = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16|t",
		[895] = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16|t",
		[876] = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16|t",
		[1161] = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16|t",
		[1169] = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16|t",
		[14] = WorldQuestList:AtlasToText("worldquest-icon-pvp-ffa"),
		[62] = WorldQuestList:AtlasToText("worldquest-icon-pvp-ffa"),
		[1355] = WorldQuestList:AtlasToText("Mobile-Inscription"),
		[1533] = WorldQuestList:AtlasToText("shadowlands-landingbutton-kyrian-up"),
		[1536] = WorldQuestList:AtlasToText("shadowlands-landingbutton-necrolord-up"),
		[1565] = WorldQuestList:AtlasToText("shadowlands-landingbutton-NightFae-up"),
		[1525] = WorldQuestList:AtlasToText("shadowlands-landingbutton-venthyr-up"),
	}
	function WorldQuestList:GetMapIcon(mapID)
		return mapIcons[mapID] or ""
	end
end
do
	local mapColors = {
		[864] = format("%02x%02x%02x",255,169,186),
		[863] = format("%02x%02x%02x",255,200,100),
		[862] = format("%02x%02x%02x",206,225,84),
		[942] = format("%02x%02x%02x",206,225,84),
		[895] = format("%02x%02x%02x",255,200,100),
		[896] = format("%02x%02x%02x",220,180,165),
		[1355] = format("%02x%02x%02x",142,160,255),

		[1533] = format("%02x%02x%02x",190,190,190),
		[1536] = format("%02x%02x%02x",28,145,31),
		[1565] = format("%02x%02x%02x",54,93,233),
		[1525] = format("%02x%02x%02x",233,27,40),
	}
	WorldQuestList.mapTextColorData = mapColors
	function WorldQuestList:GetMapTextColor(mapID)
		return mapColors[mapID] and "|cff"..mapColors[mapID] or ""
	end
end


do
	local subZonesList = {
		[630] = true,
		[641] = true,
		[650] = true,
		[634] = true,
		[680] = true,
		[630] = true,
		[646] = true,

		[864] = true,
		[863] = true,
		[862] = true,
		[896] = true,
		[895] = true,
		[942] = true,

		[2025] = true,
		[2022] = true,
		[2023] = true,
		[2024] = true,

		[2214] = true,
		[2215] = true,
		[2255] = true,
	}
	function WorldQuestList:FilterCurrentZone(mapID)
		if subZonesList[mapID] then
			return true
		else
			return false
		end
	end
end

do
	local cache = {}
	WorldQuestList.IsMapParentCache = cache		--debug
	function WorldQuestList:IsMapParent(childMapID,parentMapID)
		if childMapID == parentMapID then
			return true
		elseif not childMapID or not parentMapID then
			return
		end

		if cache[childMapID] and cache[childMapID][parentMapID] then
			return cache[childMapID][parentMapID] == 1 and true or false
		end
		cache[childMapID] = cache[childMapID] or {}

		local mapInfo = C_Map.GetMapInfo(childMapID)
		while mapInfo do
			if not mapInfo.parentMapID then
				cache[childMapID][parentMapID] = 0
				return
			elseif mapInfo.parentMapID == parentMapID then
				cache[childMapID][parentMapID] = 1
				return true
			end
			mapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
		end
		cache[childMapID][parentMapID] = 0
	end
end

do
	local cache = {}
	local mapCoords = {	--leftX,topY,rightX,bottomY
		--UiMapAssignment.db2: Region_4,Region_3,Region_1,Region_0
		[875] = {8728.96,4532.46,-4939.41,-4582.09},	--Zandalar
		[876] = {7521.37,5475.55,-5587.68,-3263.90},	--Кул-Тирас
		[619] = {13099.97,7262.06,-5737.99,-5296.67},	--Broken Isles
		[12] = {17070.87,12307.30,-19738.77,-12223.41},	--Kalimdor
		[13] = {18174.75,11172.79,-22571.59,-15971.07},	--Eastern Kingdoms
		[113] = {9762.67,11106.09,-9077.17,-1453.98},	--Northrend
		[424] = {8753.04,6679.51,-6762.53,-3664.92},	--Pandaria
		[572] = {12244.10,11192.62,-10494.56,-3962.45},	--Дренор

		[882] = {11545.8,6622.92,8287.5,4450},		--macari
		[830] = {3772.92,2654.17,58.334,177.084},	--krokun
		[885] = {11279.2,-1789.58,7879.17,-4056.25},	--antorus

		[1355] = {1598.10,2787.43,-2666.83,-56.17},	--Назжатар

		[1550] = {12568.46,6330.90,-11587.08,-9772.61},	--shadowlands

		[1978] = {13342.78,8432.13,-12137.89,-8544.50},	--Драконьи острова
		[2133] = {6068.75,2329.16,-1195.83,-2514.58},	--Cave
		[2200] = {10891.70,1393.75,3414.58,-3589.58},	--Emerald Dream

		[2274] = {-556.25,5141.669921875,-6883.330078125,1662.5},	--Khaz Algar
		[2346] = {1416.6669921875,697.9169921875,-635.416015625,-670.833984375},	--Undermine
	}
	function WorldQuestList:DevCreateMapCoords(mapID)
		self.DCMC = self.DCMC or CreateFrame("Frame")
		self.DCMC:RegisterEvent("PLAYER_STARTED_MOVING")
		self.DCMC:RegisterEvent("PLAYER_STOPPED_MOVING")
		local sX,sY,msX,msY
		self.DCMC:SetScript("OnEvent",function(self,event)
			if event == "PLAYER_STARTED_MOVING" then
				local mapPos = C_Map.GetPlayerMapPosition(mapID, "player")
				if mapPos then
					msX,msY = mapPos:GetXY()
					sY,sX = UnitPosition'player'
				end
			elseif event == "PLAYER_STOPPED_MOVING" then
				if not sX then
					return
				end
				self:UnregisterAllEvents()
				local mapPos = C_Map.GetPlayerMapPosition(mapID, "player")
				if mapPos then
					local meX,meY = mapPos:GetXY()
					local eY,eX = UnitPosition'player'

					local dist = sqrt((sX - eX) ^ 2 + (sY - eY) ^ 2)

					local width, height = (sX - eX) / (msX - meX), (sY - eY) / (msY - meY)
					local leftX,rightX = sX - width * msX, sX + width * (1 - msX)
					local topY,bottomY = sY - height * msY, sY + height * (1 - msY)

					print('dist',dist,'mapID',mapID,'coords',leftX,rightX,topY,bottomY)
					if GMRT then
						GMRT.F:Export2("["..mapID.."] = {"..format("%.2f",leftX)..","..format("%.2f",topY)..","..format("%.2f",rightX)..","..format("%.2f",bottomY).."},\t--"..C_Map.GetMapInfo(mapID).name)
					end
				end
			end
		end)
	end


	function WorldQuestList:GetQuestWorldCoord(questID)
		if cache[questID] then
			return unpack(cache[questID])
		end
		for mapID,mapCoord in pairs(mapCoords) do
			local taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(mapID)
			for _,info in pairs(taskInfo or WorldQuestList.NULLTable) do
				if info.questID == questID then
					cache[questID] = {
						mapCoord[1] + (info.x or -1) * (mapCoord[3]-mapCoord[1]),
						mapCoord[2] + (info.y or -1) * (mapCoord[4]-mapCoord[2]),
					}
					return unpack(cache[questID])
				end
			end
		end
	end
	function WorldQuestList:GetQuestCoord(questID)
		for mapID,mapCoord in pairs(mapCoords) do
			local taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(mapID)
			for _,info in pairs(taskInfo or WorldQuestList.NULLTable) do
				if info.questID == questID then
					if info.mapID then
						local taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(info.mapID)
						for _,info in pairs(taskInfo or WorldQuestList.NULLTable) do
							if info.questID == questID then
								return info.x, info.y, info.mapID
							end
						end
					end
					return nil
				end
			end
		end
	end
	function WorldQuestList:GetQuestWorldCoord2(questID,questMapID,x,y,ignoreCache)
		if cache[questID] and not ignoreCache then
			return unpack(cache[questID])
		end
		for mapID,mapCoord in pairs(mapCoords) do
			if questMapID ~= 1355 or mapID == 1355 then
				local xMin,xMax,yMin,yMax = C_Map.GetMapRectOnMap(questMapID,mapID)
				if xMin ~= xMax and yMin ~= yMax then
					x = xMin + x * (xMax - xMin)
					y = yMin + y * (yMax - yMin)

					cache[questID] = {
						mapCoord[1] + (x or -1) * (mapCoord[3]-mapCoord[1]),
						mapCoord[2] + (y or -1) * (mapCoord[4]-mapCoord[2]),
					}
					return unpack(cache[questID])
				end
			end
		end
	end

	function WorldQuestList:GetQuestCoord_NonWQ(questID,questMapID,currMapID)
		local data = C_QuestLog.GetQuestsOnMap(questMapID)
		if data then
			for i=1,#data do
				if data[i].questID == questID then
					local xMin,xMax,yMin,yMax = C_Map.GetMapRectOnMap(questMapID,currMapID)
					if xMin ~= xMax and yMin ~= yMax then
						return xMin + data[i].x * (xMax - xMin), yMin + data[i].y * (yMax - yMin)
					end
				end
			end
		end
	end

	function WorldQuestList:GetMapCoordAdj(x,y,MapID)
		for mapID,mapCoord in pairs(mapCoords) do
			if MapID ~= 1355 or mapID == 1355 then
				local xMin,xMax,yMin,yMax = C_Map.GetMapRectOnMap(MapID,mapID)
				if xMin ~= xMax and yMin ~= yMax then
					x = xMin + x * (xMax - xMin)
					y = yMin + y * (yMax - yMin)

					return mapCoord[1] + (x or -1) * (mapCoord[3]-mapCoord[1]), mapCoord[2] + (y or -1) * (mapCoord[4]-mapCoord[2])
				end
			end
		end
	end

	function WorldQuestList:GetMapCoordAdj2(x,y,mainMapID,subMapID)
		local xMin,xMax,yMin,yMax = C_Map.GetMapRectOnMap(subMapID,mainMapID)
		if xMin ~= xMax and yMin ~= yMax then
			x = xMin + x * (xMax - xMin)
			y = yMin + y * (yMax - yMin)

			return x, y
		end
		return x,y
	end
end

do
	local list = {
		[1579] = 2164,
		[1598] = 2163,

		[1600] = 2157,
		[1595] = 2156,
		[1597] = 2103,
		[1596] = 2158,

		[1599] = 2159,
		[1593] = 2160,
		[1594] = 2162,
		[1592] = 2161,

		[1738] = 2373,
		[1739] = 2400,
		[1740] = 2391,
		[1742] = 2391,

		[1804] = 2407,
		[1805] = 2410,
		[1806] = 2465,
		[1807] = 2413,

		[1837] = 2445,
		[1838] = 2449,
		[1839] = 2453,
		[1840] = 2460,
		[1841] = 2455,
		[1842] = 2446,
		[1843] = 2461,
		[1844] = 2457,
		[1845] = 2450,
		[1846] = 2459,
		[1847] = 2458,
		[1848] = 2452,
		[1849] = 2448,
		[1850] = 2454,
		[1851] = 2456,
		[1852] = 2451,
		[1853] = 2447,

		[1907] = 2470,

		[1982] = 2478,

		[2106] = 2510,
		[2031] = 2507,
		[2108] = 2503,
		[2109] = 2511,

		[2420] = 2568,

		[2819] = 2615,
		[2652] = 2574,
 
		[2903] = 2600,
		[3004] = 2607,
		[3003] = 2605,
		[3002] = 2601,
		[2897] = 2590,
		[2899] = 2570,
	}
	local fg_list = {
		[2164] = "Both",
		[2163] = "Both",
		[2157] = "Horde",
		[2156] = "Horde",
		[2103] = "Horde",
		[2158] = "Horde",
		[2159] = "Alliance",
		[2160] = "Alliance",
		[2162] = "Alliance",
		[2161] = "Alliance",

		[2391] = "Both",
		[2373] = "Horde",
		[2400] = "Alliance",

		[2465] = "Both",
		[2410] = "Both",
		[2413] = "Both",
		[2407] = "Both",

		[2478] = "Both",
	}
	function WorldQuestList:IsFactionCurrency(currencyID)
		if list[currencyID or 0] then
			return true
		elseif C_CurrencyInfo.GetFactionGrantedByCurrency(currencyID) then
			list[currencyID] = C_CurrencyInfo.GetFactionGrantedByCurrency(currencyID)
			return true
		else
			return false
		end
	end

	function WorldQuestList:IsFactionAvailable(factionID)
		factionID = factionID or 0
		if not fg_list[factionID] or fg_list[factionID] == "Both" or UnitFactionGroup("player") == fg_list[factionID] then
			return true
		else
			return false
		end
	end

	function WorldQuestList:FactionCurrencyToID(currencyID)
		if list[currencyID or 0] then
			return list[currencyID]
		end
		local factionID = C_CurrencyInfo.GetFactionGrantedByCurrency(currencyID or 0)
		if factionID then
			list[currencyID] = factionID
			return factionID
		end
	end
	function WorldQuestList:FactionIDToCurrency(factionID)
		for currencyID,fID in pairs(list) do
			if fID == factionID then
				return currencyID
			end
		end
	end
end

do
	local prevTime = 0
	local prevRes
	function WorldQuestList:GetCallingQuests()
		local nowTime = GetTime()
		if (nowTime - prevTime < 15) and prevRes then
			return unpack(prevRes)
		end
		prevTime = nowTime
		prevRes = {}
		for i=1,C_QuestLog.GetNumQuestLogEntries() do
			--[[
			local entry = C_QuestLog.GetInfo(i)
			if entry and entry.questID and C_QuestLog.IsQuestCalling(entry.questID) then
				prevRes[#prevRes+1] = entry.questID
			end
			]]
			local questID = C_QuestLog.GetQuestIDForLogIndex(i)
			if questID ~= 0 and C_QuestLog.IsQuestCalling(questID) then
				prevRes[#prevRes+1] = questID
			end
		end
		return unpack(prevRes)
	end
end
do
	local cache = {}
	function WorldQuestList:GetQuestName(questID)
		if cache[questID] then
			return cache[questID]
		end
		local index = C_QuestLog.GetLogIndexForQuestID(questID)
		if index then
			local entry = C_QuestLog.GetInfo(index)
			if entry then
				cache[questID] = entry.title
				return entry.title
			end
		end
	end
end

function WorldQuestList:SetMapDot(x,y)
	if not x then
		WorldQuestList.mapC:Hide()
		WorldQuestList.mapD:Hide()
		return
	end
	local size = 46 * WorldMapButton:GetWidth() / 1002
	WorldQuestList.mapCs:SetSize(size,size)
	WorldQuestList.mapD:SetSize(size*0.48,size*0.48)

	WorldQuestList.mapC:ClearAllPoints()
	WorldQuestList.mapC:SetPoint("CENTER",WorldMapButton,"BOTTOMRIGHT",-WorldMapButton:GetWidth() * (1 - x),WorldMapButton:GetHeight() * (1 - y))
	WorldQuestList.mapC:Show()
	WorldQuestList.mapD:Show()
end
function WorldQuestList:SetMapArrowsHelp(x,y)
	local size = 48 * WorldMapButton:GetWidth() / 1002
	ArrowsHelpFrame.top:SetSize(size,size)
	ArrowsHelpFrame.bottom:SetSize(size,size)
	ArrowsHelpFrame.left:SetSize(size,size)
	ArrowsHelpFrame.right:SetSize(size,size)
	ArrowsHelpFrame:SetSize(size*0.6,size*0.6)

	ArrowsHelpFrame:ClearAllPoints()
	ArrowsHelpFrame:SetPoint("CENTER",WorldMapButton,"BOTTOMRIGHT",-WorldMapButton:GetWidth() * (1 - x),WorldMapButton:GetHeight() * (1 - y))
	ArrowsHelpFrame:Show()
end

do
	local questToAchievement = {
		[52798] = 13041,
		[50786] = 13022,
		[53704] = 13285,
		[55344] = 13512,	--Zuldazar
		[55342] = 13512,	--Nazmir
		[55343] = 13512,	--Voldun
		[55264] = 13512,	--Dru
		[55340] = 13512,	--Tir
		[55341] = 13512,	--Storm
		[53346] = 13059,
		[54415] = 13437,
		[54512] = 13426,
		[53196] = 13050,
		[52159] = 13050,
		[49994] = 13060,
		[53189] = 13060,
		[53188] = 13060,
		[51173] = 13009,
		[51178] = 13035,
		[50717] = 13025,
		[50899] = 13026,
		[50559] = 13023,
		[51127] = 13023,
		[54689] = 13435,
		[54498] = 13440,
		[54505] = 13441,
		[50665] = 13021,
		[51974] = 13054,
		[51976] = 13054,
		[51977] = 13054,
		[51978] = 13054,
		
		[59718] = 14766,
		[59643] = 14765,
		[60739] = 14671,
		[60911] = 14741,
		[60602] = 14772,
		[60858] = 14762,
		[59848] = 14233,
		[59852] = 14233,
		[59850] = 14233,
		[59853] = 14233,
		[60844] = 14735, -- Flight School: Falling With Style
		[59717] = 14737, -- Things Remembered
		[60475] = 14672, -- We'll Workshop It
		[59825] = 14516, -- Impressing Zo'Sorg (Seed Hunting)
		[59803] = 14516, -- Impressing Zo'Sorg (For Honor)
		[59658] = 14516, -- Impressing Zo'Sorg (Express Dominance)
		[60231] = 14516, -- Impressing Zo'Sorg (State of Decay)
		[59705] = 14737,

		[82580] = {40623,40630},
		[83101] = 40507,
		[82133] = 16566,
	}
	function WorldQuestList:IsQuestForAchievement(questID)
		if questID and questToAchievement[questID] then
			local achievementID = questToAchievement[questID]
			if type(achievementID) == "table" then
				local r = {}
				for i=1,#achievementID do
					local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch, wasEarnedByMe, earnedBy = GetAchievementInfo(achievementID[i])
					r[#r+1] = achievementID[i]
					r[#r+1] = completed or false
				end		
				return true, unpack(r)
			end
			local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch, wasEarnedByMe, earnedBy = GetAchievementInfo(achievementID)
			return true, achievementID, completed
		else
			return false
		end
	end
end

local function WorldQuestList_Line_OnEnter(self)
	self.hl:Show()

	local data = self.data
	if data.x and data.y and data.mapID then
		WorldQuestList:SetMapDot(data.x,data.y)
	end
end

local function WorldQuestList_Line_OnLeave(self)
	WorldQuestList:SetMapDot()
	self.hl:Hide()
end

local function WorldQuestList_Line_OnClick(self,button)
	if button == "RightButton" then
		local mapID = GetCurrentMapID()
		local mapInfo = C_Map.GetMapInfo(mapID)
		if mapInfo and mapInfo.parentMapID then
			WorldMapFrame:SetMapID(mapInfo.parentMapID)
		end
	end
end

local additionalTooltips = {}

local function GetAdditionalTooltip(i,isBottom)
	if not additionalTooltips[i] then
		additionalTooltips[i] = CreateFrame("GameTooltip", "WorldQuestsListAdditionalTooltip"..i, UIParent, "GameTooltipTemplate")
	end
	local tooltip = additionalTooltips[i]
	local owner = nil
	if i == 2 then
		owner = GameTooltip
	else
		owner = additionalTooltips[i - 1]
	end
	tooltip:SetOwner(owner, "ANCHOR_NONE")
	tooltip:ClearAllPoints()
	if isBottom then
		tooltip:SetPoint("TOPLEFT",owner,"BOTTOMLEFT",0,0)
	else
		tooltip:SetPoint("TOPRIGHT",owner,"TOPLEFT",0,0)
	end

	return tooltip
end

local function WorldQuestList_LineReward_OnEnter(self)
	local line = self:GetParent()
	if line.reward.ID and GetNumQuestLogRewards(line.reward.ID) > 0 and not line.isRewardLink then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetQuestLogItem("reward", 1, line.reward.ID)
		GameTooltip:Show()

		local additional = 2
		if line.reward.IDs then
			for i=2,line.reward.IDs do
				local tooltip = GetAdditionalTooltip(additional)
				tooltip:SetQuestLogItem("reward", i, line.reward.ID)
				tooltip:Show()
				additional = additional + 1
			end
		end
		if line.reward.artifactKnowlege then
			local tooltip = GetAdditionalTooltip(additional,true)
			tooltip:AddLine(LOCALE.knowledgeTooltip)
			if line.reward.timeToComplete then
				local timeLeftMinutes, timeString = line.reward.timeToComplete
				if timeLeftMinutes >= 14400 then
					timeString = ""		--A lot, 10+ days
				elseif timeLeftMinutes >= 1440 then
					timeString = format("%d.%02d:%02d",floor(timeLeftMinutes / 1440),floor(timeLeftMinutes / 60) % 24, timeLeftMinutes % 60)
				else
					timeString = (timeLeftMinutes >= 60 and (floor(timeLeftMinutes / 60) % 24) or "0")..":"..format("%02d",timeLeftMinutes % 60)
				end

				tooltip:AddLine(LOCALE.timeToComplete..timeString)
			end
			tooltip:Show()
			additional = additional + 1
		end
		if line.reward:IsTruncated() then
			local text = line.reward:GetText()
			if text and text ~= "" then
				local tooltip = GetAdditionalTooltip(additional,true)
				tooltip:AddLine(text)
				tooltip:Show()
				additional = additional + 1
			end
		end

		self:RegisterEvent('MODIFIER_STATE_CHANGED')
	elseif line.reward.ID and line.isRewardLink then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetHyperlink(line.reward.ID)
		GameTooltip:Show()

		if line.reward:IsTruncated() then
			local text = line.reward:GetText()
			if text and text ~= "" then
				local tooltip = GetAdditionalTooltip(2,true)
				tooltip:AddLine(text)
				tooltip:Show()
			end
			if line.rewardLink2 then
				local tooltip = GetAdditionalTooltip(3,true)
				tooltip:SetHyperlink(line.rewardLink2)
				tooltip:Show()
			end
		end
	elseif line.reward:IsTruncated() then
		local text = line.reward:GetText()
		if text and text ~= "" then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(text)
			GameTooltip:Show()
		end
	end
	if not line.reward.ID and line.reward.artifactKnowlege and line.reward.timeToComplete then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(LOCALE.knowledgeTooltip)
		local timeLeftMinutes, timeString = line.reward.timeToComplete
		if timeLeftMinutes >= 14400 then
			timeString = ""		--A lot, 10+ days
		elseif timeLeftMinutes >= 1440 then
			timeString = format("%d.%02d:%02d",floor(timeLeftMinutes / 1440),floor(timeLeftMinutes / 60) % 24, timeLeftMinutes % 60)
		else
			timeString = (timeLeftMinutes >= 60 and (floor(timeLeftMinutes / 60) % 24) or "0")..":"..format("%02d",timeLeftMinutes % 60)
		end
		GameTooltip:AddLine(LOCALE.timeToComplete..timeString)
		GameTooltip:Show()
	end

	WorldQuestList_Line_OnEnter(line)
end
local function WorldQuestList_LineReward_OnLeave(self)
	self:UnregisterEvent('MODIFIER_STATE_CHANGED')
	GameTooltip_Hide()
	GameTooltip:ClearLines()
	WorldQuestList_Line_OnLeave(self:GetParent())
	for _,tip in pairs(additionalTooltips) do
		tip:Hide()
	end
end
local function WorldQuestList_LineReward_OnClick(self,button)
	if button == "LeftButton" then
		local itemLink = self:GetParent().rewardLink
		if not itemLink then
			return
		elseif IsModifiedClick("DRESSUP") then
			return DressUpItemLink(itemLink)
		elseif IsModifiedClick("CHATLINK") then
			if ChatEdit_GetActiveWindow() then
				ChatEdit_InsertLink(itemLink)
			else
				ChatFrame_OpenChat(itemLink)
			end
		end
	elseif button == "RightButton" then
		if ( IsModifiedClick("EXPANDITEM") ) then
			local link = self:GetParent().rewardLink
			if link and C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(link) then
				OpenAzeriteEmpoweredItemUIFromLink(link)
				return
			end
		end


		WorldQuestList_Line_OnClick(self:GetParent(),"RightButton")
	end
end
local function WorldQuestList_LineReward_OnEvent(self)
	if self:IsMouseOver() then
		WorldQuestList_LineReward_OnLeave(self)
		WorldQuestList_LineReward_OnEnter(self)
	end
end

local function WorldQuestList_LineFaction_OnEnter(self)
	local tipAdded = nil
	if self.tooltip then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(self.tooltip)
		GameTooltip:Show()
		tipAdded = true
	end
	if self.reputationList then
		if not tipAdded then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		end
		GameTooltip:AddLine(REPUTATION..":")
		local list = {strsplit(",",self.reputationList)}
		for i=1,#list do
			local factionID = tonumber(list[i])
			if WorldQuestList:IsFactionAvailable(factionID) then
				local name = GetFactionInfoByID(factionID)
				if name then
					local currencyID = WorldQuestList:FactionIDToCurrency(factionID)
					local icon
					if currencyID then
						local _,_,c_icon = GetCurrencyInfo(currencyID)
						if c_icon then
							icon = " (|T"..c_icon..":24|t)"
						end
					end
					GameTooltip:AddLine("- "..name..(icon or ""))
				end
			end
		end
		GameTooltip:Show()
		tipAdded = true
	end
	if self:GetParent().faction:IsTruncated() and self:GetParent().isLeveling then
		local text = self:GetParent().faction:GetText()
		if text and text ~= "" then
			if not tipAdded then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			end
			GameTooltip:AddLine(text)
			GameTooltip:Show()
			tipAdded = true
		end
	end
	if self:GetParent().questID and C_QuestLog.QuestContainsFirstTimeRepBonusForPlayer(self:GetParent().questID) then
		if not tipAdded then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		end
		GameTooltip:AddLine(QUEST_REWARDS_CONTAINS_ONE_TIME_REP_BONUS,.5,.5,1)
		GameTooltip:Show()
		tipAdded = true
	end
	WorldQuestList_Line_OnEnter(self:GetParent())
end
local function WorldQuestList_LineFaction_OnLeave(self)
	GameTooltip_Hide()
	WorldQuestList_Line_OnLeave(self:GetParent())
end


local function WorldQuestList_LineName_OnEnter(self)
	local line = self:GetParent()
	local questID = line.questID
	if line.debugTooltip then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(line.debugTooltip,1,1,1)
		GameTooltip:Show()
	elseif questID and not line.isLeveling then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		local title, factionID = C_TaskQuest.GetQuestInfoByQuestID(questID)
		local tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex = GetQuestTagInfo(questID)

		local color = WORLD_QUEST_QUALITY_COLORS[rarity]
		GameTooltip:SetText(title, color.r, color.g, color.b)

		if ( factionID ) then
			local factionName = GetFactionInfoByID(factionID)
			if ( factionName ) then
				GameTooltip:AddLine(factionName)
			end
		end

		for objectiveIndex = 1, line.numObjectives do
			local objectiveText, objectiveType, finished = GetQuestObjectiveInfo(questID, objectiveIndex, false)
			if ( objectiveText and #objectiveText > 0 ) then
				local color = finished and GRAY_FONT_COLOR or HIGHLIGHT_FONT_COLOR;
				GameTooltip:AddLine(QUEST_DASH .. objectiveText, color.r, color.g, color.b, true)
			end
		end

		GameTooltip:AddLine(format("QuestID: %d",questID),.5,.5,1)

		GameTooltip:Show()

		if line.achievementID then
			local link = GetAchievementLink(line.achievementID)
			if link then
				local tooltip = GetAdditionalTooltip(2)
				tooltip:SetHyperlink(link)
				tooltip:Show()
			end
		end
	elseif line.isLeveling and questID and not line.isTreasure then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetHyperlink("quest:"..questID)
		GameTooltip:AddLine("Quest ID: "..questID)
		GameTooltip:Show()
	end
	WorldQuestList_Line_OnEnter(line)
end
local function WorldQuestList_LineName_OnLeave(self)
	GameTooltip_Hide()
	WorldQuestList_Line_OnLeave(self:GetParent())
	for _,tip in pairs(additionalTooltips) do
		tip:Hide()
	end
end

local function WorldQuestList_LineName_OnClick(self,button)
	local line = self:GetParent()
	if button == "LeftButton" then
		local questID = line.questID

		if not line.isLeveling and questID then
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			local watchType = C_QuestLog.GetQuestWatchType(questID)

			if IsShiftKeyDown() then
				if watchType == Enum.QuestWatchType.Manual or (watchType == Enum.QuestWatchType.Automatic and C_SuperTrack.GetSuperTrackedQuestID() == questID) then
					QuestUtil.UntrackWorldQuest(questID)
				else
					QuestUtil.TrackWorldQuest(questID, Enum.QuestWatchType.Manual)
				end
			else
				if watchType == Enum.QuestWatchType.Manual then
					C_SuperTrack.SetSuperTrackedQuestID(questID)
				else
					QuestUtil.TrackWorldQuest(questID, Enum.QuestWatchType.Automatic)
				end
			end
		end

		if not IsShiftKeyDown() then
			local x,y
			if line.isLeveling and line.data.mapID and line.data.x then
				x,y = WorldQuestList:GetQuestWorldCoord2(questID,line.data.defMapID or line.data.mapID,line.data.x,line.data.y,true)
			else
				x,y = WorldQuestList:GetQuestWorldCoord(questID)
			end
			if x and y then
				local name = questID and C_TaskQuest.GetQuestInfoByQuestID(line.questID) or line.data.name or "unk"
				WorldQuestList.AddArrow(x,y,questID,name)
			end

			local x,y,mapID = WorldQuestList:GetQuestCoord(questID)
			if x and y then
				local name = C_TaskQuest.GetQuestInfoByQuestID(questID) or ""
				WorldQuestList.AddArrowNWC(x,y,mapID,questID,name)
			end

			local mapAreaID = GetCurrentMapID()
			if WorldQuestList.GeneralMaps[mapAreaID] then
				local data = line.data
				if data and data.mapID and WorldMapFrame:IsVisible() then
					WorldMapFrame:SetMapID(data.mapID)

					local xMin,xMax,yMin,yMax = C_Map.GetMapRectOnMap(data.mapID,data.dMap or mapAreaID)
					if xMin ~= xMax and yMin ~= yMax and (data.x or data.dX) then
						local x,y = data.dX or data.x,data.dY or data.y

						x = (x - xMin) / (xMax - xMin)
						y = (y - yMin) / (yMax - yMin)

						WorldQuestList:SetMapDot()
						WorldQuestList:SetMapArrowsHelp(x,y)
					else
						WorldQuestList:SetMapDot()
					end
				end
			end
		end
	elseif button == "RightButton" then
		if not line.questID or line.isTreasure then
			return
		end
		ELib.ScrollDropDown.ClickButton(self)
	end
end

local function WorldQuestList_LineZone_OnEnter(self)
	WorldQuestList_Line_OnEnter(self:GetParent())
end
local function WorldQuestList_LineZone_OnLeave(self)
	WorldQuestList_Line_OnLeave(self:GetParent())
end

local function WorldQuestList_LineZone_OnClick(self,button)
	if button == "LeftButton" then
		local info = self:GetParent().data
		if info and info.mapID then
			WorldMapFrame:SetMapID(info.mapID)
		end
	elseif button == "RightButton" then
		WorldQuestList_Line_OnClick(self:GetParent(),"RightButton")
	end
end

local function WorldQuestList_Timeleft_OnEnter(self)
	WorldQuestList_Line_OnEnter(self:GetParent())
	if self._t then
		local t = time() + self._t * 60
		t = floor(t / 60) * 60
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		local format = "%x %X"
		if date("%x",t) == date("%x") then
			format = "%X"
		end
		GameTooltip:AddLine(date(format,t))
		GameTooltip:Show()
	end
end
local function WorldQuestList_Timeleft_OnLeave(self)
	WorldQuestList_Line_OnLeave(self:GetParent())
	GameTooltip_Hide()
end

local function WorldQuestList_LFGButton_OnClick(self,button)
	local questID = self.questID
	if not questID then
		return
	elseif C_LFGList.CanCreateQuestGroup(questID) then
		LFGListUtil_FindQuestGroup(questID)
	elseif button == "RightButton" then
		WorldQuestList.LFG_StartQuest(questID)
	else
		WorldQuestList.LFG_Search(questID)
	end
end
local function WorldQuestList_LFGButton_OnEnter(self)
	WorldQuestList_Line_OnEnter(self:GetParent())
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddLine(LOOK_FOR_GROUP)
	GameTooltip:AddLine(LOCALE.lfgLeftButtonClick,1,1,1)
	GameTooltip:AddLine(LOCALE.lfgLeftButtonClick2,1,1,1)
	GameTooltip:AddLine(LOCALE.lfgRightButtonClick,1,1,1)
	GameTooltip:Show()
end
local function WorldQuestList_LFGButton_OnLeave(self)
	WorldQuestList_Line_OnLeave(self:GetParent())
	GameTooltip_Hide()
end
local function WorldQuestList_LFGButton_OnShow(self)
	if not self.questID then
		self:SetEnabled(false)
		self.texture:Hide()
	else
		self:SetEnabled(true)
		self.texture:Show()
	end
	self:SetWidth(18)
end
local function WorldQuestList_LFGButton_OnHide(self)
	self:SetWidth(1)
end
local function WorldQuestList_LFGButton_OnUpdate(self,el)
	if self.t > 1 then
		self.t = 0
		local questID = self.questID
		if questID then
			local n = WorldQuestList.LFG_LastResult[questID]
			if n then
				self.text:SetText(n)
			else
				self.text:SetText("")
			end
		else
			self.text:SetText("")
		end
	end
	self.t = self.t + el
end


local IgnoreListDropDown = {
	{
		text = IGNORE_QUEST,
		func = function()
			ELib.ScrollDropDown.Close()
			local questID = ELib.ScrollDropDown.DropDownList[1].parent:GetParent().questID
			if questID then
				VWQL.Ignore[questID] = time()
				WorldQuestList_Update()
				if WorldQuestList.BlackListWindow:IsShown() then
					WorldQuestList.BlackListWindow:Hide()
					WorldQuestList.BlackListWindow:Show()
				end
			end
		end,
	},
	{
		text = COMMUNITIES_INVITE_MANAGER_COLUMN_TITLE_LINK..": Wowhead",
		func = function()
			ELib.ScrollDropDown.Close()
			local questID = ELib.ScrollDropDown.DropDownList[1].parent:GetParent().questID
			if questID then
				GExRT.F.ShowInput(COMMUNITIES_INVITE_MANAGER_COLUMN_TITLE_LINK..": Wowhead",function()end,nil,false,	(
					locale == "deDE" and "https://de." or
					locale == "esES" and "https://es." or
					locale == "esMX" and "https://es." or
					locale == "frFR" and "https://fr." or
					locale == "itIT" and "https://it." or
					locale == "koKR" and "https://ko." or
					locale == "ptBR" and "https://pt." or
					locale == "ruRU" and "https://ru." or
					locale == "zhCN" and "https://cn." or
					locale == "zhTW" and "https://cn." or
						"https://www." ) ..
				"wowhead.com/quest="..questID)
			end
		end,
		shownFunc = function() return GExRT and GExRT.F and GExRT.F.ShowInput end,
	},
	{
		text = CLOSE,
		func = function()
			ELib.ScrollDropDown.Close()
		end,
	},
}

WorldQuestList.NAME_WIDTH = 135

WorldQuestList.l = {}
local function WorldQuestList_CreateLine(i)
	if WorldQuestList.l[i] then
		return
	end
	WorldQuestList.l[i] = CreateFrame("Button",nil,WorldQuestList.C)
	local line = WorldQuestList.l[i]
	line:SetPoint("TOPLEFT",0,-(i-1)*16)
	line:SetPoint("BOTTOMRIGHT",WorldQuestList.C,"TOPRIGHT",0,-i*16)

	line:SetScript("OnEnter",WorldQuestList_Line_OnEnter)
	line:SetScript("OnLeave",WorldQuestList_Line_OnLeave)
	line:SetScript("OnClick",WorldQuestList_Line_OnClick)
	line:RegisterForClicks("RightButtonUp")

	line.nameicon = line:CreateTexture(nil, "BACKGROUND")
	line.nameicon:SetPoint("LEFT",4,0)
	line.nameicon:SetSize(1,16)

	line.secondicon = line:CreateTexture(nil, "BACKGROUND")
	line.secondicon:SetPoint("LEFT",line.nameicon,"RIGHT",0,0)
	line.secondicon:SetSize(1,16)

	line.name = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.name:SetPoint("LEFT",line.secondicon,"RIGHT",0,0)
	line.name:SetSize(WorldQuestList.NAME_WIDTH,20)
	line.name:SetJustifyH("LEFT")
	line.name:SetMaxLines(1)

	line.LFGButton = CreateFrame("Button",nil,line)
	line.LFGButton:SetPoint("LEFT",line.name,"RIGHT")
	line.LFGButton:SetSize(18,18)
	line.LFGButton:SetScript("OnClick",WorldQuestList_LFGButton_OnClick)
	line.LFGButton:SetScript("OnEnter",WorldQuestList_LFGButton_OnEnter)
	line.LFGButton:SetScript("OnLeave",WorldQuestList_LFGButton_OnLeave)
	line.LFGButton:SetScript("OnShow",WorldQuestList_LFGButton_OnShow)
	line.LFGButton:SetScript("OnHide",WorldQuestList_LFGButton_OnHide)
	line.LFGButton.t = 0
	--line.LFGButton:SetScript("OnUpdate",WorldQuestList_LFGButton_OnUpdate)
	line.LFGButton:RegisterForClicks("LeftButtonDown","RightButtonUp")
	line.LFGButton.texture = line.LFGButton:CreateTexture(nil, "BACKGROUND")
	line.LFGButton.texture:SetPoint("CENTER")
	line.LFGButton.texture:SetSize(16,16)
	line.LFGButton.texture:SetAtlas("socialqueuing-icon-eye")

	line.LFGButton.HighlightTexture = line.LFGButton:CreateTexture()
	line.LFGButton.HighlightTexture:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	line.LFGButton.HighlightTexture:SetSize(16,16)
	line.LFGButton.HighlightTexture:SetPoint("CENTER")
	line.LFGButton:SetHighlightTexture(line.LFGButton.HighlightTexture,"ADD")

	line.LFGButton.text = line.LFGButton:CreateFontString(nil,"OVERLAY")
	line.LFGButton.text:SetPoint("BOTTOMLEFT",2,0)
	line.LFGButton.text:SetFont("Interface\\AddOns\\WorldQuestsList\\ariblk.ttf", 14, "OUTLINE")

	line.LFGButton:Hide()

	line.reward = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.reward:SetPoint("LEFT",line.LFGButton,"RIGHT",3,0)
	line.reward:SetSize(180,20)
	line.reward:SetJustifyH("LEFT")
	line.reward:SetMaxLines(1)

	line.faction = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.faction:SetPoint("LEFT",line.reward,"RIGHT",5,0)
	line.faction:SetSize(115,20)
	line.faction:SetJustifyH("LEFT")
	line.faction:SetMaxLines(1)

	line.faction.f = CreateFrame("Frame",nil,line)
	line.faction.f:SetAllPoints(line.faction)
	line.faction.f:SetScript("OnEnter",WorldQuestList_LineFaction_OnEnter)
	line.faction.f:SetScript("OnLeave",WorldQuestList_LineFaction_OnLeave)

	line.timeleft = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.timeleft:SetPoint("LEFT",line.faction,"RIGHT",5,0)
	line.timeleft:SetSize(65,20)
	line.timeleft:SetJustifyH("LEFT")

	line.zone = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.zone:SetPoint("LEFT",line.timeleft,"RIGHT",5,0)
	line.zone:SetPoint("RIGHT",-5,0)
	line.zone:SetHeight(20)
	line.zone:SetJustifyH("LEFT")
	line.zone:SetMaxLines(1)

	line.zone.f = CreateFrame("Button",nil,line)
	line.zone.f:SetAllPoints(line.zone)
	line.zone.f:SetScript("OnEnter",WorldQuestList_LineZone_OnEnter)
	line.zone.f:SetScript("OnLeave",WorldQuestList_LineZone_OnLeave)
	line.zone.f:SetScript("OnClick",WorldQuestList_LineZone_OnClick)
	line.zone.f:RegisterForClicks("LeftButtonDown","RightButtonUp")

	line.reward.f = CreateFrame("Button",nil,line)
	line.reward.f:SetAllPoints(line.reward)
	line.reward.f:SetScript("OnEnter",WorldQuestList_LineReward_OnEnter)
	line.reward.f:SetScript("OnLeave",WorldQuestList_LineReward_OnLeave)
	line.reward.f:SetScript("OnClick",WorldQuestList_LineReward_OnClick)
	line.reward.f:SetScript("OnEvent",WorldQuestList_LineReward_OnEvent)
	line.reward.f:RegisterForClicks("LeftButtonDown","RightButtonUp")

	--line.reward.f.icon = line.reward.f:CreateTexture(nil, "BACKGROUND")

	line.name.f = CreateFrame("Button",nil,line)
	line.name.f:SetAllPoints(line.name)
	line.name.f:SetScript("OnEnter",WorldQuestList_LineName_OnEnter)
	line.name.f:SetScript("OnLeave",WorldQuestList_LineName_OnLeave)
	line.name.f:SetScript("OnClick",WorldQuestList_LineName_OnClick)
	line.name.f:RegisterForClicks("LeftButtonDown","RightButtonUp")

	line.name.f.Width = 120
	line.name.f.isButton = true
	line.name.f.List = IgnoreListDropDown

	line.timeleft.f = CreateFrame("Frame",nil,line)
	line.timeleft.f:SetAllPoints(line.timeleft)
	line.timeleft.f:SetScript("OnEnter",WorldQuestList_Timeleft_OnEnter)
	line.timeleft.f:SetScript("OnLeave",WorldQuestList_Timeleft_OnLeave)

	line.hl = line:CreateTexture(nil, "BACKGROUND")
	line.hl:SetPoint("TOPLEFT", 0, 0)
	line.hl:SetPoint("BOTTOMRIGHT", 0, 0)
	line.hl:SetTexture("Interface\\Buttons\\WHITE8X8")
	line.hl:SetVertexColor(.7,.7,1,.25)
	line.hl:Hide()

	line.nqhl = line:CreateTexture(nil, "BACKGROUND",nil,-1)
	line.nqhl:SetPoint("TOPLEFT", 0, 0)
	line.nqhl:SetPoint("BOTTOMRIGHT", 0, 0)
	line.nqhl:SetTexture("Interface\\Buttons\\WHITE8X8")
	line.nqhl:SetBlendMode("ADD")
	line.nqhl:SetVertexColor(.7,.7,1,.1)
	line.nqhl:Hide()
end

do
	local function WorldQuestList_HeaderLine_OnClick(self)
		if ActiveSort == self.sort then
			VWQL.ReverseSort = not VWQL.ReverseSort
		end
		ActiveSort = self.sort
		VWQL.Sort = ActiveSort
		ELib.ScrollDropDown.Close()
		WorldQuestList_Update()
	end
	local function WorldQuestList_HeaderLine_OnEnter(self)
		local _,parent = self:GetPoint()
		parent:SetTextColor(1,1,0)
	end
	local function WorldQuestList_HeaderLine_OnLeave(self)
		local _,parent = self:GetPoint()
		parent:SetTextColor(1,1,1)
	end

	WorldQuestList.HEADER_HEIGHT = 18

	WorldQuestList.header = CreateFrame("Button",nil,WorldQuestList)
	local line = WorldQuestList.header
	line:SetPoint("TOPLEFT",0,0)
	line:SetPoint("BOTTOMRIGHT",WorldQuestList,"TOPRIGHT",0,-WorldQuestList.HEADER_HEIGHT)

	line.b = line:CreateTexture(nil,"BACKGROUND")
	line.b:SetAllPoints()
	line.b:SetColorTexture(.25,.25,.25,1)

	line.name = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.name:SetPoint("LEFT",4,0)
	line.name:SetSize(WorldQuestList.NAME_WIDTH,WorldQuestList.HEADER_HEIGHT)
	line.name:SetJustifyH("LEFT")
	line.name:SetJustifyV("MIDDLE")
	line.name.text = CALENDAR_EVENT_NAME

	line.name.f = CreateFrame("Button",nil,line)
	line.name.f:SetAllPoints(line.name)
	line.name.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.name.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.name.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.name.f:RegisterForClicks("LeftButtonDown")
	line.name.f.sort = 3

	line.LFGButton = CreateFrame("Button",nil,line)
	line.LFGButton:SetPoint("LEFT",line.name,"RIGHT")
	line.LFGButton:SetSize(18,18)

	line.reward = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.reward:SetPoint("LEFT",line.LFGButton,"RIGHT",2,0)
	line.reward:SetSize(180,WorldQuestList.HEADER_HEIGHT)
	line.reward:SetJustifyH("LEFT")
	line.reward:SetJustifyV("MIDDLE")
	line.reward.text = REWARDS

	line.reward.f = CreateFrame("Button",nil,line)
	line.reward.f:SetAllPoints(line.reward)
	line.reward.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.reward.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.reward.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.reward.f:RegisterForClicks("LeftButtonDown")
	line.reward.f.sort = 5

	line.faction = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.faction:SetPoint("LEFT",line.reward,"RIGHT",5,0)
	line.faction:SetSize(115,WorldQuestList.HEADER_HEIGHT)
	line.faction:SetJustifyH("LEFT")
	line.faction:SetJustifyV("MIDDLE")
	line.faction.text = FACTION

	line.faction.f = CreateFrame("Button",nil,line)
	line.faction.f:SetAllPoints(line.faction)
	line.faction.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.faction.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.faction.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.faction.f:RegisterForClicks("LeftButtonDown")
	line.faction.f.sort = 4

	line.timeleft = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.timeleft:SetPoint("LEFT",line.faction,"RIGHT",5,0)
	line.timeleft:SetSize(65,WorldQuestList.HEADER_HEIGHT)
	line.timeleft:SetJustifyH("LEFT")
	line.timeleft:SetJustifyV("MIDDLE")
	line.timeleft.text = TIME_LABEL:match("^[^:]+")

	line.timeleft.f = CreateFrame("Button",nil,line)
	line.timeleft.f:SetAllPoints(line.timeleft)
	line.timeleft.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.timeleft.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.timeleft.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.timeleft.f:RegisterForClicks("LeftButtonDown")
	line.timeleft.f.sort = 1

	line.zone = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.zone:SetPoint("LEFT",line.timeleft,"RIGHT",5,0)
	line.zone:SetSize(100,WorldQuestList.HEADER_HEIGHT)
	line.zone:SetJustifyH("LEFT")
	line.zone:SetJustifyV("MIDDLE")
	line.zone.text = ZONE

	line.zone.f = CreateFrame("Button",nil,line)
	line.zone.f:SetAllPoints(line.zone)
	line.zone.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.zone.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.zone.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.zone.f:RegisterForClicks("LeftButtonDown")
	line.zone.f.sort = 2

	local str = {'name','reward','faction','timeleft','zone'}

	line.Update = function(self,disable,disabeZone,lfgIconEnabled)
		if VWQL.DisableHeader or disable then
			self:Hide()
			WorldQuestList.Cheader:SetPoint("TOP",0,-1)
			WorldQuestList.SCROLL_FIX_TOP = 1
			return
		else
			self:Show()
			WorldQuestList.Cheader:SetPoint("TOP",0,-WorldQuestList.HEADER_HEIGHT)
			WorldQuestList.SCROLL_FIX_TOP = 0
		end

		line.zone:SetShown(disabeZone)
		line.zone.f:SetShown(disabeZone)

		line.LFGButton:SetWidth(lfgIconEnabled and 18 or 1)

		for _,n in pairs(str) do
			line[n]:SetText("  "..line[n].text)
		end

		local currSort = nil
		if ActiveSort == 1 then
			currSort = line.timeleft
		elseif ActiveSort == 2 then
			currSort = line.zone
		elseif ActiveSort == 3 then
			currSort = line.name
		elseif ActiveSort == 4 then
			currSort = line.faction
		elseif ActiveSort == 5 then
			currSort = line.reward
		end

		if currSort and VWQL.ReverseSort then
			currSort:SetText("|TInterface\\AddOns\\WorldQuestsList\\navButtons:16:16:0:0:64:16:17:32:0:16|t "..currSort:GetText():gsub("^ *",""))
		elseif currSort and not VWQL.ReverseSort then
			currSort:SetText("|TInterface\\AddOns\\WorldQuestsList\\navButtons:16:16:0:0:64:16:0:16:0:16|t "..currSort:GetText():gsub("^ *",""))
		end
	end
end


do
	WorldQuestList.FOOTER_HEIGHT = 18

	WorldQuestList.footer = CreateFrame("Button",nil,WorldQuestList)
	local line = WorldQuestList.footer
	line:SetPoint("BOTTOMLEFT",0,0)
	line:SetPoint("TOPRIGHT",WorldQuestList,"BOTTOMRIGHT",0,WorldQuestList.FOOTER_HEIGHT)

	line.BorderTop = line:CreateTexture(nil,"BACKGROUND")
	line.BorderTop:SetColorTexture(unpack(WorldQuestList.backdrop.BorderColor))
	line.BorderTop:SetPoint("TOPLEFT",0,-1)
	line.BorderTop:SetPoint("BOTTOMRIGHT",line,"TOPRIGHT",0,0)

	line.ap = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.ap:SetPoint("LEFT",5,0)
	line.ap:SetHeight(WorldQuestList.FOOTER_HEIGHT)
	line.ap:SetJustifyH("LEFT")
	line.ap:SetJustifyV("MIDDLE")

	line.OR = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.OR:SetPoint("CENTER",0,0)
	line.OR:SetHeight(WorldQuestList.FOOTER_HEIGHT)
	line.OR:SetJustifyH("CENTER")
	line.OR:SetJustifyV("MIDDLE")

	line.gold = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.gold:SetPoint("RIGHT",-5,0)
	line.gold:SetHeight(WorldQuestList.FOOTER_HEIGHT)
	line.gold:SetJustifyH("RIGHT")
	line.gold:SetJustifyV("MIDDLE")

	line.Update = function(self,disable)
		if VWQL.DisableTotalAP or disable then
			self:Hide()
			WorldQuestList.Cheader:SetPoint("BOTTOM",0,2)
			WorldQuestList.SCROLL_FIX_BOTTOM = 2
		else
			self:Show()
			WorldQuestList.Cheader:SetPoint("BOTTOM",0,WorldQuestList.FOOTER_HEIGHT+1)
			WorldQuestList.SCROLL_FIX_BOTTOM = 1
		end
	end
end


local ViewAllButton = CreateFrame("Button", nil, WorldQuestList)
ViewAllButton:SetPoint("TOPLEFT",0,-5)
ViewAllButton:SetSize(400,25)
ViewAllButton:Hide()

WorldQuestList.ViewAllButton = ViewAllButton

ViewAllButton.b = ViewAllButton:CreateTexture(nil,"BACKGROUND",nil,1)
ViewAllButton.b:SetAllPoints()
ViewAllButton.b:SetColorTexture(0.28,0.08,0.08,1)

ViewAllButton.t = ViewAllButton:CreateFontString(nil,"ARTWORK","GameFontWhite")
ViewAllButton.t:SetPoint("CENTER",0,0)

ELib.Templates:Border(ViewAllButton,.3,.12,.12,1,1)
ViewAllButton.shadow = ELib:Shadow2(ViewAllButton,16)

ViewAllButton:SetScript("OnEnter",function(self) self.b:SetColorTexture(0.42,0.12,0.12,1) end)
ViewAllButton:SetScript("OnLeave",function(self) self.b:SetColorTexture(0.28,0.08,0.08,1) end)


ViewAllButton.Argus = CreateFrame("Button", nil, ViewAllButton)
ViewAllButton.Argus:SetPoint("TOP",ViewAllButton,"BOTTOM",0,-5)
ViewAllButton.Argus:SetSize(400,25)

ViewAllButton.Argus.b = ViewAllButton.Argus:CreateTexture(nil,"BACKGROUND",nil,1)
ViewAllButton.Argus.b:SetAllPoints()
ViewAllButton.Argus.b:SetColorTexture(0.28,0.08,0.08,1)

ViewAllButton.Argus.t = ViewAllButton.Argus:CreateFontString(nil,"ARTWORK","GameFontWhite")
ViewAllButton.Argus.t:SetPoint("CENTER",0,0)

ELib.Templates:Border(ViewAllButton.Argus,.3,.12,.12,1,1)
ViewAllButton.Argus.shadow = ELib:Shadow2(ViewAllButton.Argus,16)

ViewAllButton.Argus:SetScript("OnEnter",function(self) self.b:SetColorTexture(0.42,0.12,0.12,1) end)
ViewAllButton.Argus:SetScript("OnLeave",function(self) self.b:SetColorTexture(0.28,0.08,0.08,1) end)

ViewAllButton.Update = function()
	if UnitLevel'player' >= 71 then
		ViewAllButton:SetScript("OnClick",function()
			WorldMapFrame:SetMapID(2274)
		end)
		ViewAllButton.t:SetText("World Quests List: "..EXPANSION_NAME10)

		ViewAllButton.Argus:SetScript("OnClick",function()
			WorldMapFrame:SetMapID(947)
		end)
		ViewAllButton.Argus.t:SetText("World Quests List: "..WorldQuestList:GetMapName(947))
	elseif UnitLevel'player' >= 61 then
		ViewAllButton:SetScript("OnClick",function()
			WorldMapFrame:SetMapID(1978)
		end)
		ViewAllButton.t:SetText("World Quests List: "..EXPANSION_NAME9)

		ViewAllButton.Argus:SetScript("OnClick",function()
			WorldMapFrame:SetMapID(947)
		end)
		ViewAllButton.Argus.t:SetText("World Quests List: "..WorldQuestList:GetMapName(947))
	elseif UnitLevel'player' >= 51 then
		ViewAllButton:SetScript("OnClick",function()
			WorldMapFrame:SetMapID(1550)
		end)
		ViewAllButton.t:SetText("World Quests List: "..EXPANSION_NAME8)

		ViewAllButton.Argus:SetScript("OnClick",function()
			WorldMapFrame:SetMapID(947)
		end)
		ViewAllButton.Argus.t:SetText("World Quests List: "..WorldQuestList:GetMapName(947))
	else
		local button1, button2
		if UnitFactionGroup("player") == "Alliance" then
			button1, button2 = ViewAllButton, ViewAllButton.Argus
		else
			button1, button2 = ViewAllButton.Argus, ViewAllButton
		end
		button1:SetScript("OnClick",function()
			WorldMapFrame:SetMapID(876)
		end)
		button1.t:SetText("World Quests List: "..WorldQuestList:GetMapName(876).." |TInterface\\FriendsFrame\\PlusManz-Alliance:16|t")

		button2:SetScript("OnClick",function()
			WorldMapFrame:SetMapID(875)
		end)
		button2.t:SetText("World Quests List: "..WorldQuestList:GetMapName(875).." |TInterface\\FriendsFrame\\PlusManz-Horde:16|t")

	end
end


WorldQuestList.sortDropDown = ELib:DropDown(WorldQuestList,RAID_FRAME_SORT_LABEL:gsub(" ([^ ]+)$",""), nil)
WorldQuestList.sortDropDown:SetWidth(85)
WorldQuestList.sortDropDown.Button.Width = 180
WorldQuestList.sortDropDown:MakeSolidButton()

local function SetSort(_, arg1)
	ActiveSort = arg1
	VWQL.Sort = ActiveSort
	VWQL.ReverseSort = false
	ELib.ScrollDropDown.Close()
	WorldQuestList_Update()
end

local TableSortNames = {
	TIME_LABEL:match("^[^:]+"),
	ZONE,
	NAME,
	FACTION,
	REWARDS,
	LOCALE.distance,
}

do
	local list = {}
	WorldQuestList.sortDropDown.Button.List = list
	for i=1,#TableSortNames do
		list[i] = {
			text = TableSortNames[i],
			radio = true,
			arg1 = i,
			func = SetSort,
		}
	end
	list[#list+1] = {text = LOCALE.rewardSortOption,func = function() WorldQuestList.SortPriorWindow:Show() ELib.ScrollDropDown.Close() end,	padding = 16,	}
	list[#list+1] = {text = CLOSE,			func = function() ELib.ScrollDropDown.Close() end,						padding = 16,	}
	function WorldQuestList.sortDropDown.Button:additionalToggle()
		for i=1,#self.List-2 do
			self.List[i].checkState = ActiveSort == i
		end
	end
end


WorldQuestList.filterDropDown = ELib:DropDown(WorldQuestList,FILTERS)
WorldQuestList.filterDropDown:SetWidth(85)
WorldQuestList.filterDropDown.Button.Width = 220
WorldQuestList.filterDropDown:MakeSolidButton()

do
	local list = {}
	WorldQuestList.filterDropDown.Button.List = list

	local DF = function() return WorldQuestList:IsDragonflightZone() end
	local SL = function() return WorldQuestList:IsShadowlandsZone() end
	local LEGION = function() return WorldQuestList:IsLegionZone() and not SL() and not DF() end
	local NOT_LEGION = function() return not WorldQuestList:IsLegionZone() and not SL() and not DF() end
	local GetFaction = function(id,non_translated) 
		return FACTION.." "..(GetFactionInfoByID(id) or non_translated or ("ID "..tostring(id)))
	end


	local function SetFilter(_, arg1)
		if bit.band(filters[arg1][2],ActiveFilter) > 0 then
			ActiveFilter = bit.bxor(ActiveFilter,filters[arg1][2])
		else
			ActiveFilter = bit.bor(ActiveFilter,filters[arg1][2])
		end
		VWQL[charKey].Filter = ActiveFilter
		ELib.ScrollDropDown.UpdateChecks()
		WorldQuestList_Update()
	end

	local function SetFilterType(_, arg1)
		ActiveFilterType[arg1] = not ActiveFilterType[arg1]
		ELib.ScrollDropDown.UpdateChecks()
		WorldQuestList_Update()
	end

	local function SetIgnoreFilter(_, arg1)
		VWQL[charKey][arg1] = not VWQL[charKey][arg1]
		ELib.ScrollDropDown.UpdateChecks()
		WorldQuestList_Update()
	end


	list[#list+1] = {
		text = CHECK_ALL,
		func = function()
			ActiveFilter = 2 ^ #filters - 1
			VWQL[charKey].Filter = ActiveFilter
			ActiveFilterType.azerite = nil
			ActiveFilterType.bfa_orderres = nil
			ActiveFilterType.rep = nil
			ActiveFilterType.expulsom = nil
			ActiveFilterType.manapearl = nil
			VWQL[charKey].arguniteFilter = nil
			VWQL[charKey].wakeningessenceFilter = nil
			VWQL[charKey].invasionPointsFilter = nil
			ELib.ScrollDropDown.Close()
			WorldQuestList_Update()
		end,
	}
	list[#list+1] = {
		text = UNCHECK_ALL,
		func = function()
			ActiveFilter = 0
			VWQL[charKey].Filter = ActiveFilter
			ActiveFilterType.azerite = true
			ActiveFilterType.bfa_orderres = true
			ActiveFilterType.rep = true
			ActiveFilterType.expulsom = true
			ActiveFilterType.manapearl = true
			VWQL[charKey].arguniteFilter = true
			VWQL[charKey].wakeningessenceFilter = true
			VWQL[charKey].invasionPointsFilter = true
			ELib.ScrollDropDown.Close()
			WorldQuestList_Update()
		end,
	}

	list[#list+1] = {text = LOCALE.gear,			func = SetFilter,	arg1 = 1,					checkable = true,				}
	list[#list+1] = {text = LOCALE.gold,			func = SetFilter,	arg1 = 5,					checkable = true,				}
	list[#list+1] = {text = REPUTATION,			func = SetFilterType,	arg1 = "rep",					checkable = true,				}
	list[#list+1] = {text = OTHER,				func = SetFilter,	arg1 = 6,					checkable = true,				}

	list[#list+1] = {text = EXPANSION_NAME6, padding = 16, subMenu = {
		{text = LE.ARTIFACT_POWER,		func = SetFilter,	arg1 = 2,					checkable = true},
		{text = LE.ORDER_RESOURCES_NAME_LEGION,	func = SetFilter,	arg1 = 3,					checkable = true},
		{text = LOCALE.blood,			func = SetFilter,	arg1 = 4,					checkable = true},
		{text = GetCurrencyInfo(1508),		func = SetIgnoreFilter,	arg1 = "arguniteFilter",	arg2 = true,	checkable = true},
		{text = GetCurrencyInfo(1533),		func = SetIgnoreFilter,	arg1 = "wakeningessenceFilter",	arg2 = true,	checkable = true},
		{text = LOCALE.invasionPoints,		func = SetIgnoreFilter,	arg1 = "invasionPointsFilter",	arg2 = true,	checkable = true},
	}}
	list[#list+1] = {text = EXPANSION_NAME7, padding = 16, subMenu = {
		{text = LE.AZERITE,			func = SetFilterType,	arg1 = "azerite",				checkable = true},
		{text = LE.ORDER_RESOURCES_NAME_BFA,	func = SetFilterType,	arg1 = "bfa_orderres",				checkable = true},
		{text = LOCALE.expulsom,		func = SetFilterType,	arg1 = "expulsom",				checkable = true},
		{text = GetCurrencyInfo(1721),		func = SetFilterType,	arg1 = "manapearl",				checkable = true},
		{text = "8.3 Chest",			func = SetFilterType,	arg1 = "bounty_cache",				checkable = true},
	}}
	list[#list+1] = {text = EXPANSION_NAME8, padding = 16, subMenu = {
		{text = WORLD_QUEST_REWARD_FILTERS_ANIMA,func = SetFilterType,	arg1 = "anima",					checkable = true}
	}}
	list[#list+1] = {text = EXPANSION_NAME10, padding = 16, subMenu = {
		{text = MOUNT_JOURNAL_FILTER_DRAGONRIDING,func = SetFilterType,	arg1 = "dragonriding",				checkable = true},
		{text = PVP_SPECIAL_EVENT_BUTTON_TT_TITLE,func = SetFilterType,	arg1 = "tww_bounty",				checkable = true},
		{text = GetCurrencyInfo(2815),		func = SetFilterType,	arg1 = "curr2815",				checkable = true},
		{text = GetCurrencyInfo(3008),		func = SetFilterType,	arg1 = "curr3008",				checkable = true},
	}}


	list[#list+1] = {
		text = TYPE,
		isTitle = true,
	}
	list[#list+1] = {text = PVP,			func = SetFilterType,	arg1 = "pvp",	checkable = true,	}
	list[#list+1] = {text = DUNGEONS,		func = SetFilterType,	arg1 = "dung",	checkable = true,	}
	list[#list+1] = {text = TRADE_SKILLS,		func = SetFilterType,	arg1 = "prof",	checkable = true,	}
	list[#list+1] = {text = PET_BATTLE_PVP_QUEUE,	func = SetFilterType,	arg1 = "pet",	checkable = true,	}

	list[#list+1] = {
		text = LOCALE.ignoreFilter,
		isTitle = true,
	}
	list[#list+1] = {text = LOCALE.bountyIgnoreFilter,		func = SetIgnoreFilter,	arg1 = "bountyIgnoreFilter",		checkable = true,				}
	list[#list+1] = {text = LOCALE.honorIgnoreFilter,		func = SetIgnoreFilter,	arg1 = "honorIgnoreFilter",		checkable = true,				}
	list[#list+1] = {text = SHOW_PET_BATTLES_ON_MAP_TEXT,		func = SetIgnoreFilter,	arg1 = "petIgnoreFilter",		checkable = true,				}
	list[#list+1] = {text = LOCALE.wantedIgnoreFilter,		func = SetIgnoreFilter,	arg1 = "wantedIgnoreFilter",		checkable = true,				}
	list[#list+1] = {text = LOCALE.epicIgnoreFilter,		func = SetIgnoreFilter,	arg1 = "epicIgnoreFilter",		checkable = true,				}
	list[#list+1] = {text = LOCALE.ignoreList,			func = SetIgnoreFilter,	arg1 = "ignoreIgnore",			checkable = true,				}

	local function CreateFactionFilterSubmenu(subMenu,list)
		subMenu = subMenu or {}
		for i=1,#list do
			local factionID = list[i]
			subMenu[#subMenu+1] = {text = GetFaction(factionID),	func = SetIgnoreFilter,	arg1 = "faction"..factionID.."IgnoreFilter",	checkable = true,	shownFunc = function() return WorldQuestList:IsFactionAvailable(factionID) end	}
		end
		return subMenu 
	end

	list[#list+1] = {text = EXPANSION_NAME6, padding = 16, subMenu = {
		{text = LE.ARTIFACT_POWER,			func = SetIgnoreFilter,	arg1 = "apIgnoreFilter",		checkable = true},
		{text = GetFaction(2045,"Legionfall"),		func = SetIgnoreFilter,	arg1 = "legionfallIgnoreFilter",	checkable = true},
		{text = GetFaction(2165,"Army of the Light"),	func = SetIgnoreFilter,	arg1 = "aotlIgnoreFilter",		checkable = true},
		{text = GetFaction(2170,"Argussian Reach"),	func = SetIgnoreFilter,	arg1 = "argusReachIgnoreFilter",	checkable = true},
	}}

	list[#list+1] = {text = EXPANSION_NAME7, padding = 16, subMenu = {
		{text = LE.AZERITE,				func = SetIgnoreFilter,	arg1 = "azeriteIgnoreFilter",		checkable = true},
		{text = GetCurrencyInfo(1721),			func = SetIgnoreFilter,	arg1 = "manapearlIgnoreFilter",		checkable = true},
	}}
	CreateFactionFilterSubmenu(list[#list].subMenu,{2164,2163,2157,2156,2103,2158,2159,2160,2162,2161,2391,2400,2373})

	list[#list+1] = {text = EXPANSION_NAME8, padding = 16, subMenu = {
		{text = WORLD_QUEST_REWARD_FILTERS_ANIMA,	func = SetIgnoreFilter,	arg1 = "animaIgnoreFilter",		checkable = true},
	}}
	CreateFactionFilterSubmenu(list[#list].subMenu,{2465,2410,2413,2407,2478})

	list[#list+1] = {text = EXPANSION_NAME9, padding = 16, subMenu = {}}
	CreateFactionFilterSubmenu(list[#list].subMenu,{2510,2507,2503,2511,2564,2615,2574})

	list[#list+1] = {text = EXPANSION_NAME10, padding = 16, subMenu = {}}
	CreateFactionFilterSubmenu(list[#list].subMenu,{2594,2600,2607,2605,2601,2590,2570, 2653,2673,2669,2675,2677,2685})

	list[#list+1] = {text = CLOSE,			func = function() ELib.ScrollDropDown.Close() end,		padding = 16,	}

	local function CheckEntry(entry)
		if entry.func == SetFilter then
			entry.checkState = bit.band(filters[ entry.arg1 ][2],ActiveFilter) > 0
		elseif entry.func == SetFilterType then
			entry.checkState = not ActiveFilterType[ entry.arg1 ]
		elseif entry.func == SetIgnoreFilter and not entry.arg2 then 
			entry.checkState = VWQL[charKey][entry.arg1]
		elseif entry.func == SetIgnoreFilter and entry.arg2 then 
			entry.checkState = not VWQL[charKey][entry.arg1]
		end
	end
	function WorldQuestList.filterDropDown.Button:additionalToggle()
		for i=1,#self.List do
			CheckEntry(self.List[i])
			if self.List[i].subMenu then
				for j=1,#self.List[i].subMenu do
					CheckEntry(self.List[i].subMenu[j])
				end
			end
		end
	end
end

function UpdateScale()
	local scale = tonumber(VWQL.Scale) or 1
	if VWQL.Anchor == 2 and WorldMapFrame:IsVisible() then
		scale = scale * WorldMapButton:GetWidth() / 1002 * 0.8
	end
	WorldQuestList:SetScale(scale)
end
function UpdateAnchor(forceFreeMode)
	WorldQuestList:ClearAllPoints()

	local mode = 
		VWQL.Anchor == 1 and 1 or	--bottom
		VWQL.Anchor == 2 and 2 or	--inside
		(VWQL.Anchor == 3 or forceFreeMode) and 3 or	--free
		4				--default

	if mode == 1 then
		WorldQuestList.filterDropDown:ClearAllPoints()
		WorldQuestList.filterDropDown:SetPoint("TOPLEFT",WorldQuestList,"TOPRIGHT",1,0)

		WorldQuestList.sortDropDown:ClearAllPoints()
		WorldQuestList.sortDropDown:SetPoint("TOP",WorldQuestList.filterDropDown,"BOTTOM",0,-3)

		WorldQuestList.optionsDropDown:ClearAllPoints()
		WorldQuestList.optionsDropDown:SetPoint("TOP",WorldQuestList.sortDropDown,"BOTTOM",0,-3)

		WorldQuestList.modeSwitcherCheck:ClearAllPoints()
		WorldQuestList.modeSwitcherCheck:SetPoint("TOP",WorldQuestList.optionsDropDown,"BOTTOM",0,-3)

		WorldQuestList.oppositeContinentButton:ClearAllPoints()
		WorldQuestList.oppositeContinentButton:SetPoint("TOPLEFT",WorldQuestList.modeSwitcherCheck,"BOTTOMLEFT",0,-3)

		WorldQuestList:SetParent(WorldMapFrame)
		WorldQuestList:SetPoint("TOPLEFT",WorldMapFrame,"BOTTOMLEFT",3,-7)

		WorldQuestList.moveHeader.disabled = nil
		WorldQuestList.moveHeader:Hide()

		ELib.ScrollDropDown.DropDownList[1]:SetParent(UIParent)
		ELib.ScrollDropDown.DropDownList[2]:SetParent(UIParent)
	elseif mode == 2 then
		WorldQuestList.moveHeader.disabled = nil
		WorldQuestList.moveHeader:Show()
		WorldQuestList.moveHeader:ClearAllPoints()
		WorldQuestList.moveHeader:SetPoint("BOTTOMLEFT",WorldQuestList,"TOPLEFT",0,1)
		WorldQuestList.moveHeader:SetWidth(40)

		WorldQuestList.oppositeContinentButton:ClearAllPoints()
		WorldQuestList.oppositeContinentButton:SetPoint("LEFT",WorldQuestList.moveHeader,"RIGHT",5,0)

		WorldQuestList.modeSwitcherCheck:ClearAllPoints()
		WorldQuestList.modeSwitcherCheck:SetPoint("LEFT",WorldQuestList.oppositeContinentButton,"RIGHT",5,0)

		WorldQuestList.optionsDropDown:ClearAllPoints()
		WorldQuestList.optionsDropDown:SetPoint("LEFT",WorldQuestList.modeSwitcherCheck,"RIGHT",5,0)

		WorldQuestList.sortDropDown:ClearAllPoints()
		WorldQuestList.sortDropDown:SetPoint("LEFT",WorldQuestList.optionsDropDown,"RIGHT",5,0)

		WorldQuestList.filterDropDown:ClearAllPoints()
		WorldQuestList.filterDropDown:SetPoint("LEFT",WorldQuestList.sortDropDown,"RIGHT",5,0)

		WorldQuestList:SetParent(WorldMapButton)
		WorldQuestList:SetPoint("TOPRIGHT",WorldMapButton,"TOPRIGHT",-10,-70)

		WorldQuestList:SetFrameStrata("TOOLTIP")

		ELib.ScrollDropDown.DropDownList[1]:SetParent(WorldMapFrame)
		ELib.ScrollDropDown.DropDownList[2]:SetParent(WorldMapFrame)
	elseif mode == 3 then
		WorldQuestList.moveHeader.disabled = nil
		WorldQuestList.moveHeader:Show()
		WorldQuestList.moveHeader:ClearAllPoints()
		WorldQuestList.moveHeader:SetPoint("BOTTOMLEFT",WorldQuestList,"TOPLEFT",0,1)
		WorldQuestList.moveHeader:SetWidth(40)

		WorldQuestList.oppositeContinentButton:ClearAllPoints()
		WorldQuestList.oppositeContinentButton:SetPoint("LEFT",WorldQuestList.moveHeader,"RIGHT",5,0)

		WorldQuestList.modeSwitcherCheck:ClearAllPoints()
		WorldQuestList.modeSwitcherCheck:SetPoint("LEFT",WorldQuestList.oppositeContinentButton,"RIGHT",5,0)

		WorldQuestList.optionsDropDown:ClearAllPoints()
		WorldQuestList.optionsDropDown:SetPoint("LEFT",WorldQuestList.modeSwitcherCheck,"RIGHT",5,0)

		WorldQuestList.sortDropDown:ClearAllPoints()
		WorldQuestList.sortDropDown:SetPoint("LEFT",WorldQuestList.optionsDropDown,"RIGHT",5,0)

		WorldQuestList.filterDropDown:ClearAllPoints()
		WorldQuestList.filterDropDown:SetPoint("LEFT",WorldQuestList.sortDropDown,"RIGHT",5,0)
		if not forceFreeMode then
			WorldQuestList:SetParent(WorldMapFrame)
		end
		if VWQL.Anchor3PosLeft and VWQL.Anchor3PosTop and not forceFreeMode then
			WorldQuestList:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",VWQL.Anchor3PosLeft,VWQL.Anchor3PosTop)
		else
			if WorldMapFrame:IsMaximized() then
				WorldQuestList:SetPoint("TOPLEFT",WorldMapFrame,"TOPRIGHT",-500,-30)
			else
				WorldQuestList:SetPoint("TOPLEFT",WorldMapFrame,"TOPRIGHT",10,-4)
			end
		end

		WorldQuestList:SetFrameStrata("DIALOG")

		ELib.ScrollDropDown.DropDownList[1]:SetParent(UIParent)
		ELib.ScrollDropDown.DropDownList[2]:SetParent(UIParent)
	else
		WorldQuestList:SetParent(WorldMapFrame)
		WorldQuestList:SetPoint("TOPLEFT",WorldMapFrame,"TOPRIGHT",10+45,-4)

		WorldQuestList.moveHeader.disabled = true
		WorldQuestList.moveHeader:Show()
		WorldQuestList.moveHeader:ClearAllPoints()
		WorldQuestList.moveHeader:SetPoint("BOTTOMLEFT",WorldQuestList,"TOPLEFT",0,1)
		WorldQuestList.moveHeader:SetWidth(40)

		WorldQuestList.oppositeContinentButton:ClearAllPoints()
		WorldQuestList.oppositeContinentButton:SetPoint("LEFT",WorldQuestList.moveHeader,"RIGHT",5,0)

		WorldQuestList.modeSwitcherCheck:ClearAllPoints()
		WorldQuestList.modeSwitcherCheck:SetPoint("LEFT",WorldQuestList.oppositeContinentButton,"RIGHT",5,0)

		WorldQuestList.optionsDropDown:ClearAllPoints()
		WorldQuestList.optionsDropDown:SetPoint("LEFT",WorldQuestList.modeSwitcherCheck,"RIGHT",5,0)

		WorldQuestList.sortDropDown:ClearAllPoints()
		WorldQuestList.sortDropDown:SetPoint("LEFT",WorldQuestList.optionsDropDown,"RIGHT",5,0)

		WorldQuestList.filterDropDown:ClearAllPoints()
		WorldQuestList.filterDropDown:SetPoint("LEFT",WorldQuestList.sortDropDown,"RIGHT",5,0)

		ELib.ScrollDropDown.DropDownList[1]:SetParent(UIParent)
		ELib.ScrollDropDown.DropDownList[2]:SetParent(UIParent)
	end
end

WorldQuestList.optionsDropDown = ELib:DropDown(WorldQuestList,GAMEOPTIONS_MENU)
WorldQuestList.optionsDropDown:SetWidth(85)
WorldQuestList.optionsDropDown.Button.Width = 220
WorldQuestList.optionsDropDown:SetClampedToScreen(true)
WorldQuestList.optionsDropDown:MakeSolidButton()

do
	local list = {}
	WorldQuestList.optionsDropDown.Button.List = list

	local DF = function() return WorldQuestList:IsDragonflightZone() end
	local SL = function() return WorldQuestList:IsShadowlandsZone() end
	local LEGION = function() return WorldQuestList:IsLegionZone() and not SL() and not DF() end
	local NOT_LEGION = function() return not WorldQuestList:IsLegionZone() and not SL()and not DF() end

	local lfgSubMenu = {
		{
			text = LOCALE.lfgDisablePopup,
			func = function()
				VWQL.DisableLFG_Popup = not VWQL.DisableLFG_Popup
			end,
			checkable = true,
		},
		{
			text = LOCALE.lfgDisablePopupLeave,
			func = function()
				VWQL.DisableLFG_PopupLeave = not VWQL.DisableLFG_PopupLeave
			end,
			checkable = true,
		},
		{
			text = LOCALE.lfgDisableRightClickIcons,
			func = function()
				VWQL.DisableLFG_RightClickIcon = not VWQL.DisableLFG_RightClickIcon
				WorldQuestList_Update()
			end,
			checkable = true,
		},
		{
			text = LOCALE.lfgDisableEyeRight,
			func = function()
				VWQL.DisableLFG_EyeRight = not VWQL.DisableLFG_EyeRight
				if WorldQuestList.ObjectiveTracker_Update_hook then
					WorldQuestList.ObjectiveTracker_Update_hook(2)
				end
			end,
			checkable = true,
		},
		{
			text = LOCALE.lfgDisableEyeList,
			func = function()
				VWQL.LFG_HideEyeInList = not VWQL.LFG_HideEyeInList
				WorldQuestList_Update()
			end,
			checkable = true,
		},


		{
			text = LOCALE.lfgDisableAll,
			func = function()
				StaticPopupDialogs["WQL_LFG_DISABLE_ALL"] = {
					text = LOCALE.lfgDisableAll2,
					button1 = YES,
					button2 = NO,
					OnAccept = function()
						VWQL.DisableLFG_Popup = nil
						VWQL.DisableLFG = nil
						VWQL.DisableIconsGeneral = true
						VWQL.DisableRewardIcons = true
						VWQL.MapIconsScale = nil
						VWQL.EnableEnigma = nil
						VWQL.DisableShellGame = true
						VWQL.DisableArrow = true

						VWQL[charKey].HideMap = true

						WorldQuestList.IconsGeneralLastMap = -1
						WorldQuestList_Update()
						WorldQuestList:Hide()

						WorldQuestList:WQIcons_RemoveIcons()
						WorldQuestList:WQIcons_RemoveScale()
					end,
					timeout = 0,
					whileDead = true,
					hideOnEscape = true,
					preferredIndex = 3,
				}
				ELib.ScrollDropDown.Close()
				StaticPopup_Show("WQL_LFG_DISABLE_ALL")
			end,
			checkable = false,
			padding = 16,
		},
	}

	list[#list+1] = {
		text = LOCALE.lfgSearchOption,
		func = function()
			VWQL.DisableLFG = not VWQL.DisableLFG
			WorldQuestList_Update()
		end,
		checkable = true,
		subMenu = lfgSubMenu,
	}

	local function SetScaleArrow(_, arg1)
		VWQL.Arrow_Scale = arg1
		WQLdb.Arrow:Scale(arg1 or 1)
	end

	local arrowMenu = {
		{
			text = LOCALE.disableArrow,
			func = function()
				VWQL.DisableArrow = not VWQL.DisableArrow
				WorldQuestList_Update()
				if VWQL.DisableArrow then
					WQLdb.Arrow:Hide()
				end
			end,
			checkable = true,
		},

		{text = TYPE,			isTitle = true,		padding = 16,			},
		{text = DEFAULT,	func = function() VWQL.ArrowStyle = nil ELib.ScrollDropDown.Close()	end,	radio = true,	},
		{text = "TomTom",	func = function() VWQL.ArrowStyle = 2	ELib.ScrollDropDown.Close()	end,	radio = true,	},

		{text = UI_SCALE,		isTitle = true,		padding = 16,			},
		{text = "300%",			func = SetScaleArrow,	arg1 = 3,	radio = true	},
		{text = "250%",			func = SetScaleArrow,	arg1 = 2.5,	radio = true	},
		{text = "200%",			func = SetScaleArrow,	arg1 = 2,	radio = true	},
		{text = "175%",			func = SetScaleArrow,	arg1 = 1.75,	radio = true	},
		{text = "150%",			func = SetScaleArrow,	arg1 = 1.5,	radio = true	},
		{text = "140%",			func = SetScaleArrow,	arg1 = 1.4,	radio = true	},
		{text = "125%",			func = SetScaleArrow,	arg1 = 1.25,	radio = true	},
		{text = "110%",			func = SetScaleArrow,	arg1 = 1.1,	radio = true	},
		{text = "|cff00ff00100%",	func = SetScaleArrow,	arg1 = nil,	radio = true	},
		{text = "90%",			func = SetScaleArrow,	arg1 = 0.9,	radio = true	},
		{text = "80%",			func = SetScaleArrow,	arg1 = 0.8,	radio = true	},
		{text = "70%",			func = SetScaleArrow,	arg1 = 0.7,	radio = true	},
		{text = "60%",			func = SetScaleArrow,	arg1 = 0.6,	radio = true	},
		{text = "50%",			func = SetScaleArrow,	arg1 = 0.5,	radio = true	},
		{text = "40%",			func = SetScaleArrow,	arg1 = 0.4,	radio = true	},
		{
			text = LOCALE.disableArrowMove,
			func = function()
				VWQL.DisableArrowMove = not VWQL.DisableArrowMove
				WQLdb.Arrow.frame:SetMovable(not VWQL.DisableArrowMove)
				WorldQuestList_Update()
			end,
			checkable = true,
		},
		{
			text = LOCALE.enableArrowQuests,
			func = function()
				VWQL.EnableArrowQuest = not VWQL.EnableArrowQuest
			end,
			checkable = true,
		},
	}

	list[#list+1] = {
		text = LOCALE.arrow,
		subMenu = arrowMenu,
		padding = 16,
	}

	local function SetScaleOption(_, arg1)
		VWQL.Scale = arg1
		ELib.ScrollDropDown.Close()
		UpdateScale()
		WorldQuestList_Update()
	end

	local scaleSubMenu = {
		{text = "200%",			func = SetScaleOption,	arg1 = 2,	radio = true	},
		{text = "175%",			func = SetScaleOption,	arg1 = 1.75,	radio = true	},
		{text = "150%",			func = SetScaleOption,	arg1 = 1.5,	radio = true	},
		{text = "140%",			func = SetScaleOption,	arg1 = 1.4,	radio = true	},
		{text = "125%",			func = SetScaleOption,	arg1 = 1.25,	radio = true	},
		{text = "110%",			func = SetScaleOption,	arg1 = 1.1,	radio = true	},
		{text = "|cff00ff00100%",	func = SetScaleOption,	arg1 = nil,	radio = true	},
		{text = "90%",			func = SetScaleOption,	arg1 = 0.9,	radio = true	},
		{text = "85%",			func = SetScaleOption,	arg1 = 0.85,	radio = true	},
		{text = "80%",			func = SetScaleOption,	arg1 = 0.8,	radio = true	},
		{text = "75%",			func = SetScaleOption,	arg1 = 0.75,	radio = true	},
		{text = "70%",			func = SetScaleOption,	arg1 = 0.7,	radio = true	},
		{text = "65%",			func = SetScaleOption,	arg1 = 0.65,	radio = true	},
		{text = "60%",			func = SetScaleOption,	arg1 = 0.6,	radio = true	},
		{text = "50%",			func = SetScaleOption,	arg1 = 0.5,	radio = true	},
		{text = "40%",			func = SetScaleOption,	arg1 = 0.4,	radio = true	},
	}

	list[#list+1] = {
		text = UI_SCALE,
		subMenu = scaleSubMenu,
		padding = 16,
	}

	local function SetAnchorOption(_, arg1)
		VWQL.Anchor = arg1
		UpdateAnchor()
		UpdateScale()
		ELib.ScrollDropDown.Close()
		WorldQuestList_Update()
	end

	local anchorSubMenu = {
		{text = "1 Right",		func = SetAnchorOption,	arg1 = nil,	radio = true	},
		{text = "2 Bottom",		func = SetAnchorOption,	arg1 = 1,	radio = true	},
		{text = "3 Inside",		func = SetAnchorOption,	arg1 = 2,	radio = true	},
		{text = "4 Free (Outside)",	func = SetAnchorOption,	arg1 = 3,	radio = true	},
	}

	list[#list+1] = {
		text = LOCALE.anchor,
		subMenu = anchorSubMenu,
		padding = 16,
	}

	local azeriteFormatSubMenu = {
		{
			text = "2100",
			func = function()
				VWQL.AzeriteFormat = nil
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "1.1%",
			func = function()
				VWQL.AzeriteFormat = 10
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "2100 (1.1%)",
			func = function()
				VWQL.AzeriteFormat = 20
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update()
			end,
			radio = true,
		},
	}


	local function SetIconGeneral(_, arg1)
		VWQL["DisableIconsGeneralMap"..arg1] = not VWQL["DisableIconsGeneralMap"..arg1]
		WorldQuestList.IconsGeneralLastMap = -1
		WorldQuestList_Update()	  
	end

	local iconsGeneralSubmenu = {
		{text = WorldQuestList:GetMapName(2274),func = SetIconGeneral,	checkable = true,	arg1=2274	},
		{text = WorldQuestList:GetMapName(1978),func = SetIconGeneral,	checkable = true,	arg1=1978	},
		{text = WorldQuestList:GetMapName(1550),func = SetIconGeneral,	checkable = true,	arg1=1550	},
		{text = WorldQuestList:GetMapName(947),	func = SetIconGeneral,	checkable = true,	arg1=947	},
		{text = WorldQuestList:GetMapName(875),	func = SetIconGeneral,	checkable = true,	arg1=875	},
		{text = WorldQuestList:GetMapName(876),	func = SetIconGeneral,	checkable = true,	arg1=876	},
		{text = WorldQuestList:GetMapName(619),	func = SetIconGeneral,	checkable = true,	arg1=619	},
		{text = WorldQuestList:GetMapName(905),	func = SetIconGeneral,	checkable = true,	arg1=905	},
		{text = WorldQuestList:GetMapName(12),	func = SetIconGeneral,	checkable = true,	arg1=12 	},
		{text = WorldQuestList:GetMapName(13),	func = SetIconGeneral,	checkable = true,	arg1=13 	},
	}
	list[#list+1] = {
		text = LOCALE.iconsOnMinimap,
		func = function()
			VWQL.DisableIconsGeneral = not VWQL.DisableIconsGeneral
			WorldQuestList.IconsGeneralLastMap = -1
			WorldQuestList_Update()
		end,
		checkable = true,
		subMenu = iconsGeneralSubmenu,
	}

	local rewardsIconsSubMenu = {
		{
			text = LOCALE.disableRibbon,
			func = function()
				VWQL.DisableRibbon = not VWQL.DisableRibbon
				WorldMapFrame:TriggerEvent("WorldQuestsUpdate", WorldMapFrame:GetNumActivePinsByTemplate("WorldMap_WorldQuestPinTemplate"))
			end,
			checkable = true,
		},
		{
			text = LOCALE.enableRibbonGeneralMap,
			func = function()
				VWQL.EnableRibbonGeneralMaps = not VWQL.EnableRibbonGeneralMaps
				WorldMapFrame:TriggerEvent("WorldQuestsUpdate", WorldMapFrame:GetNumActivePinsByTemplate("WorldMap_WorldQuestPinTemplate"))
			end,
			checkable = true,
		},
		{
			text = LOCALE.enableBountyColors,
			func = function()
				VWQL.RewardIcons_DisableBountyColors = not VWQL.RewardIcons_DisableBountyColors
				WorldMapFrame:TriggerEvent("WorldQuestsUpdate", WorldMapFrame:GetNumActivePinsByTemplate("WorldMap_WorldQuestPinTemplate"))
			end,
			checkable = true,
		},
	}
	list[#list+1] = {
		text = LOCALE.disableRewardIcons,
		colorCode = "|cff00ff00",
		func = function()
			VWQL.DisableRewardIcons = not VWQL.DisableRewardIcons
			if VWQL.DisableRewardIcons then
				WorldQuestList:WQIcons_RemoveIcons()
			else
				WorldQuestList:WQIcons_AddIcons()
			end
		end,
		checkable = true,
		subMenu = rewardsIconsSubMenu,
	}

	local mapIconsScaleSubmenu = {
		{text = "",	isTitle = true,	slider = {min = 20, max = 300, val = 100, afterText = "%", func = nil}	},
		{
			text = DISABLE,
			func = function()
				VWQL.DisableWQScale_Hidden = not VWQL.DisableWQScale_Hidden
			end,
			checkable = true,
			sub_arg = 1001,
		},
	}
	mapIconsScaleSubmenu[1].slider.func = function(self,val)
		mapIconsScaleSubmenu[1].slider.val = val
		VWQL.MapIconsScale = val / 100
		WorldMapFrame:TriggerEvent("WorldQuestsUpdate", WorldMapFrame:GetNumActivePinsByTemplate("WorldMap_WorldQuestPinTemplate"))
	end
	list[#list+1] = {
		text = LOCALE.mapIconsScale,
		padding = 16,
		subMenu = mapIconsScaleSubmenu,
	}

	list[#list+1] = {
		text = LOCALE.disableQuestNumber,
		func = function()
			VWQL.DisableQuestNumber = not VWQL.DisableQuestNumber
			WorldQuestList:WQIcons_AddIcons()
		end,
		checkable = true,
	}

	local listSizeSubmenu = {
		{
			text = LOCALE.topLine,
			func = function()
				VWQL.DisableHeader = not VWQL.DisableHeader
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update()
			end,
			checkable = true,
		},
		{
			text = LOCALE.bottomLine,
			func = function()
				VWQL.DisableTotalAP = not VWQL.DisableTotalAP
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update()
			end,
			checkable = true,
		},
		{
			text = LOCALE.maxLines,
			isTitle = true,
		},
		{text = "",	isTitle = true,	slider = {min = 9, max = 101, val = 9, func = nil}	},
	}
	listSizeSubmenu[4].slider.func = function(self,val)
		listSizeSubmenu[4].slider.val = val
		if val < 10 or val > 100 then
			val = nil
		end
		VWQL.MaxLinesShow = val
		self.text:SetText(val or LOCALE.unlimited)
		WorldQuestList_Update()
	end
	listSizeSubmenu[4].slider.show = function(self)
		if not VWQL.MaxLinesShow then
			self.text:SetText(LOCALE.unlimited)
		end
	end

	list[#list+1] = {
		text = LOCALE.listSize,
		padding = 16,
		subMenu = listSizeSubmenu,
	}

	list[#list+1] = {
		text = LOCALE.disabeHighlightNewQuests,
		func = function()
			VWQL.DisableHighlightNewQuest = not VWQL.DisableHighlightNewQuest
			WorldQuestList_Update()
		end,
		checkable = true,
	}

	local GetFaction = function(id,non_translated) 
		return FACTION.." "..(GetFactionInfoByID(id) or non_translated or ("ID "..tostring(id)))
	end
	local function SetHighlighFaction(_, arg1)
		VWQL[charKey][arg1] = not VWQL[charKey][arg1]
		ELib.ScrollDropDown.UpdateChecks()
		WorldQuestList_Update()
	end
	local function CreateFactionHighlightSubmenu(list)
		local subMenu = {}
		for i=1,#list do
			local factionID = list[i]
			subMenu[#subMenu+1] = {text = GetFaction(factionID),	func = SetHighlighFaction,	arg1 = "faction"..factionID.."Highlight",	checkable = true,	shownFunc = function() return WorldQuestList:IsFactionAvailable(factionID) end	}
		end
		return subMenu
	end
	local highlightingSubmenu = {
		{text = EXPANSION_NAME7, padding = 16, subMenu = CreateFactionHighlightSubmenu({2164,2163,2157,2156,2103,2158,2159,2160,2162,2161})},
		{text = EXPANSION_NAME8, padding = 16, subMenu = CreateFactionHighlightSubmenu({2465,2410,2413,2407,2478})},
		{text = EXPANSION_NAME9, padding = 16, subMenu = CreateFactionHighlightSubmenu({2510,2507,2503,2511,2564,2615,2574})},
		{text = EXPANSION_NAME10, padding = 16, subMenu = CreateFactionHighlightSubmenu({2594,2600,2607,2605,2601,2590,2570, 2653,2673,2669,2675,2677,2685})},
	}

	list[#list+1] = {
		text = HIGHLIGHTING.." "..REPUTATION,
		padding = 16,
		subMenu = highlightingSubmenu,
	}

	list[#list+1] = {
		text = LOCALE.questsForAchievements,
		func = function()
			VWQL.ShowQuestAchievements = not VWQL.ShowQuestAchievements
			WorldQuestList_Update()

			ELib.ScrollDropDown.UpdateChecks()
		end,
		checkable = true,
	}

	list[#list+1] = {text = EXPANSION_NAME6, padding = 16, subMenu = {
		{
			text = LOCALE.addQuestsArgus,
			func = function()
				VWQL.OppositeContinentArgus = not VWQL.OppositeContinentArgus
				WorldQuestList_Update()
			end,
			checkable = true,
		},
		{
			text = LOCALE.argusMap,
			func = function()
				VWQL.ArgusMap = not VWQL.ArgusMap
				ELib.ScrollDropDown.Close()
				if GetCurrentMapID() == 905 then
					WorldMapFrame:SetMapID(885)
					WorldMapFrame:SetMapID(905)
				end
				WorldQuestList_Update()
			end,
			checkable = true,
		},
		{
			text = LOCALE.enigmaHelper,
			func = function()
				VWQL.EnableEnigma = not VWQL.EnableEnigma
			end,
			checkable = true,
		},
		{
			text = LOCALE.barrelsHelper,
			func = function()
				VWQL.DisableBarrels = not VWQL.DisableBarrels
			end,
			checkable = true,
		},
	}}

	list[#list+1] = {text = EXPANSION_NAME7, padding = 16, subMenu = {
		{
			text = LOCALE.apFormatSetup,
			subMenu = azeriteFormatSubMenu,
			padding = 16,
		},
		{
			text = LOCALE.expulsomReplace,
			func = function()
				VWQL.ExpulsomReplace = not VWQL.ExpulsomReplace
				WorldQuestList_Update()
			end,
			checkable = true,
		},
		{
			text = (UnitFactionGroup("player") == "Alliance" and "|TInterface\\FriendsFrame\\PlusManz-Alliance:16|t " or "|TInterface\\FriendsFrame\\PlusManz-Horde:16|t ")..LOCALE.addQuestsOpposite,
			func = function()
				VWQL.OppositeContinent = not VWQL.OppositeContinent
				WorldQuestList_Update()
			end,
			checkable = true,
			mark = "OppositeContinent",
		},
		{
			text = LOCALE.addQuestsNazjatar,
			func = function()
				VWQL.OppositeContinentNazjatar = not VWQL.OppositeContinentNazjatar
				WorldQuestList_Update()
			end,
			checkable = true,
		},
		{
			text = WorldQuestList:GetMapIcon(619).." "..LOCALE.hideLegion,
			func = function()
				VWQL.HideLegion = not VWQL.HideLegion
				WorldQuestList_Update()
			end,
			checkable = true,
			mark = "HideLegion",
		},
		{
			text = LOCALE.shellGameHelper,
			func = function()
				VWQL.DisableShellGame = not VWQL.DisableShellGame
			end,
			checkable = true,
		},
		{
			text = LOCALE.calligraphyGameHelper,
			func = function()
				VWQL.DisableCalligraphy = not VWQL.DisableCalligraphy
			end,
			checkable = true,
		}
	}}

	list[#list+1] = {text = EXPANSION_NAME8, padding = 16, subMenu = {
		{
			text = LOCALE.aspirantTraining,
			func = function()
				VWQL.DisableAspirantTraining = not VWQL.DisableAspirantTraining
			end,
			checkable = true,
		},
		{
			text = LOCALE.toughCrowdHelper,
			func = function()
				VWQL.DisableToughCrowd = not VWQL.DisableToughCrowd
			end,
			checkable = true,
		}
	}}


	local opt_name_dfcave = WorldQuestList:GetMapName(2133).." quests on main map"
	local opt_name_dfemeralddream = WorldQuestList:GetMapName(2200).." quests on main map"
	list[#list+1] = {text = EXPANSION_NAME9, padding = 16, subMenu = {
		{
			text = opt_name_dfcave,
			func = function()
				VWQL.DFCaveMap = not VWQL.DFCaveMap
				ELib.ScrollDropDown.Close()
				if GetCurrentMapID() == 1978 then
					WorldMapFrame:SetMapID(885)
					WorldMapFrame:SetMapID(1978)
				end
				WorldQuestList_Update()
			end,
			checkable = true,
		},
		{
			text = opt_name_dfemeralddream,
			func = function()
				VWQL.EmeraldDreamMap = not VWQL.EmeraldDreamMap
				ELib.ScrollDropDown.Close()
				if GetCurrentMapID() == 1978 then
					WorldMapFrame:SetMapID(885)
					WorldMapFrame:SetMapID(1978)
				end
				WorldQuestList_Update()
			end,
			checkable = true,
		},
	}}

	list[#list+1] = {text = EXPANSION_NAME10, padding = 16, subMenu = {
		{
			text = LOCALE.repAccAlert,
			func = function()
				VWQL.DisableReputationAccAlert = not VWQL.DisableReputationAccAlert
			end,
			checkable = true,
		}
	}}


	list[#list+1] = {
		text = LOCALE.ignoreList,
		func = function()
			ELib.ScrollDropDown.Close()
			WorldQuestList.BlackListWindow:Show()
		end,
		padding = 16,
	}

	list[#list+1] = {
		text = CLOSE,
		func = function() ELib.ScrollDropDown.Close() end,
		padding = 16,
	}

	local function CheckEntry(entry)
		if entry.text == LOCALE.barrelsHelper then
			entry.checkState = not VWQL.DisableBarrels
		elseif entry.text == LOCALE.enigmaHelper then
			entry.checkState = VWQL.EnableEnigma
		elseif entry.text == LOCALE.disabeHighlightNewQuests then
			entry.checkState = VWQL.DisableHighlightNewQuest
		elseif entry.text == LOCALE.disableBountyIcon then
			entry.checkState = VWQL.DisableBountyIcon
		elseif entry.mark == "OppositeContinent" then
			entry.checkState = VWQL.OppositeContinent
		elseif entry.mark == "HideLegion" then
			entry.checkState = VWQL.HideLegion
		elseif entry.text == LOCALE.shellGameHelper then
			entry.checkState = not VWQL.DisableShellGame
		elseif entry.text == LOCALE.iconsOnMinimap then
			entry.checkState = not VWQL.DisableIconsGeneral
		elseif entry.text == LOCALE.addQuestsArgus then
			entry.checkState = not VWQL.OppositeContinentArgus
		elseif entry.text == LOCALE.argusMap then
			entry.checkState = not VWQL.ArgusMap
		elseif entry.text == LOCALE.lfgSearchOption then
			entry.checkState = not VWQL.DisableLFG
		elseif entry.text == LOCALE.disableRewardIcons then
			entry.checkState = not VWQL.DisableRewardIcons
		elseif entry.text == LOCALE.expulsomReplace then
			entry.checkState = VWQL.ExpulsomReplace
		elseif entry.text == LOCALE.calligraphyGameHelper then
			entry.checkState = not VWQL.DisableCalligraphy
		elseif entry.text == LOCALE.addQuestsNazjatar then
			entry.checkState = not VWQL.OppositeContinentNazjatar
		elseif entry.text == LOCALE.questsForAchievements then
			entry.checkState = not VWQL.ShowQuestAchievements
		elseif entry.text == LOCALE.aspirantTraining then
			entry.checkState = not VWQL.DisableAspirantTraining
		elseif entry.text == LOCALE.toughCrowdHelper then
			entry.checkState = not VWQL.DisableToughCrowd
		elseif entry.text == opt_name_dfemeralddream then
			entry.checkState = not VWQL.EmeraldDreamMap
		elseif entry.text == opt_name_dfcave then
			entry.checkState = not VWQL.DFCaveMap
		elseif entry.text == LOCALE.disableQuestNumber then
			entry.checkState = VWQL.DisableQuestNumber
		elseif entry.text == LOCALE.repAccAlert then
			entry.checkState = not VWQL.DisableReputationAccAlert
		elseif entry.sub_arg == 1001 then
			entry.checkState = VWQL.DisableWQScale_Hidden
		end
	end
	function WorldQuestList.optionsDropDown.Button:additionalToggle()
		for i=1,#self.List do
			CheckEntry(self.List[i])
			if self.List[i].subMenu then
				for j=1,#self.List[i].subMenu do
					CheckEntry(self.List[i].subMenu[j])
				end
			end
		end
		anchorSubMenu[1].checkState = not VWQL.Anchor
		anchorSubMenu[2].checkState = VWQL.Anchor == 1
		anchorSubMenu[3].checkState = VWQL.Anchor == 2
		anchorSubMenu[4].checkState = VWQL.Anchor == 3
		for i=1,#scaleSubMenu do
			scaleSubMenu[i].checkState = VWQL.Scale == scaleSubMenu[i].arg1
		end
		azeriteFormatSubMenu[1].checkState = not VWQL.AzeriteFormat
		azeriteFormatSubMenu[2].checkState = VWQL.AzeriteFormat == 10
		azeriteFormatSubMenu[3].checkState = VWQL.AzeriteFormat == 20
		arrowMenu[1].checkState = VWQL.DisableArrow
		arrowMenu[3].checkState = VWQL.ArrowStyle ~= 2
		arrowMenu[4].checkState = VWQL.ArrowStyle == 2
		for i=6,#arrowMenu-2 do
			arrowMenu[i].checkState = VWQL.Arrow_Scale == arrowMenu[i].arg1
		end
		arrowMenu[#arrowMenu - 1].checkState = VWQL.DisableArrowMove
		arrowMenu[#arrowMenu].checkState = VWQL.EnableArrowQuest
		for i=1,#iconsGeneralSubmenu do
			iconsGeneralSubmenu[i].checkState = not VWQL["DisableIconsGeneralMap"..iconsGeneralSubmenu[i].arg1]
		end
		lfgSubMenu[1].checkState = VWQL.DisableLFG_Popup
		lfgSubMenu[2].checkState = VWQL.DisableLFG_PopupLeave
		lfgSubMenu[3].checkState = VWQL.DisableLFG_RightClickIcon
		lfgSubMenu[4].checkState = VWQL.DisableLFG_EyeRight
		lfgSubMenu[5].checkState = VWQL.LFG_HideEyeInList
		mapIconsScaleSubmenu[1].slider.val = (VWQL.MapIconsScale or 1) * 100
		rewardsIconsSubMenu[1].checkState = VWQL.DisableRibbon
		rewardsIconsSubMenu[2].checkState = VWQL.EnableRibbonGeneralMaps
		rewardsIconsSubMenu[3].checkState = not VWQL.RewardIcons_DisableBountyColors
		listSizeSubmenu[1].checkState = not VWQL.DisableHeader
		listSizeSubmenu[2].checkState = not VWQL.DisableTotalAP
		listSizeSubmenu[4].slider.val = (VWQL.MaxLinesShow or 9)
		for i=1,#highlightingSubmenu do
			if highlightingSubmenu[i].subMenu then
				for j=1,#highlightingSubmenu[i].subMenu do
					highlightingSubmenu[i].subMenu[j].checkState = VWQL[charKey][highlightingSubmenu[i].subMenu[j].arg1]
				end
			else
				highlightingSubmenu[i].checkState = VWQL[charKey][highlightingSubmenu[i].arg1]
			end
		end
	end
	function WorldQuestList.optionsDropDown.Button:additionalClick()
		ELib.ScrollDropDown.UpdateChecks()
	end
end

WorldQuestList.modeSwitcherCheck = CreateFrame("Frame", nil, WorldQuestList)
WorldQuestList.modeSwitcherCheck:SetSize(90,22)

WorldQuestList.modeSwitcherCheck.b = WorldQuestList.modeSwitcherCheck:CreateTexture(nil,"BACKGROUND",nil,1)
WorldQuestList.modeSwitcherCheck.b:SetAllPoints()
WorldQuestList.modeSwitcherCheck.b:SetColorTexture(0.04,0.04,0.14,.97)

ELib.Templates:Border(WorldQuestList.modeSwitcherCheck,.22,.22,.3,1,1)
WorldQuestList.modeSwitcherCheck.shadow = ELib:Shadow2(WorldQuestList.modeSwitcherCheck,16)

WorldQuestList.modeSwitcherCheck.ShadowLeftBottom:Hide()
WorldQuestList.modeSwitcherCheck.ShadowBottom:Hide()
WorldQuestList.modeSwitcherCheck.ShadowBottomLeftInside:Hide()
WorldQuestList.modeSwitcherCheck.ShadowBottomRightInside:Hide()
WorldQuestList.modeSwitcherCheck.ShadowBottomRight:Hide()

WorldQuestList.modeSwitcherCheck.s = CreateFrame("Slider", nil, WorldQuestList.modeSwitcherCheck)
WorldQuestList.modeSwitcherCheck.s:SetPoint("CENTER")
WorldQuestList.modeSwitcherCheck.s:SetSize(76,16)
ELib.Templates:Border(WorldQuestList.modeSwitcherCheck.s,.22,.22,.3,1,1,2)

WorldQuestList.modeSwitcherCheck.s.thumb = WorldQuestList.modeSwitcherCheck.s:CreateTexture(nil, "ARTWORK")
WorldQuestList.modeSwitcherCheck.s.thumb:SetColorTexture(.32,.32,.4,1)
WorldQuestList.modeSwitcherCheck.s.thumb:SetSize(22,12)

WorldQuestList.modeSwitcherCheck.s:SetThumbTexture(WorldQuestList.modeSwitcherCheck.s.thumb)
WorldQuestList.modeSwitcherCheck.s:SetOrientation("HORIZONTAL")
WorldQuestList.modeSwitcherCheck.s:SetMinMaxValues(0,2)
WorldQuestList.modeSwitcherCheck.s:SetValue(0)
WorldQuestList.modeSwitcherCheck.s:SetValueStep(1)
WorldQuestList.modeSwitcherCheck.s:SetObeyStepOnDrag(true)

WorldQuestList.modeSwitcherCheck.s.dd = CreateFrame("Frame",nil,WorldQuestList.modeSwitcherCheck.s)
WorldQuestList.modeSwitcherCheck.s.dd:SetPoint("CENTER")
WorldQuestList.modeSwitcherCheck.s.dd:SetSize(1,1)
WorldQuestList.modeSwitcherCheck.s.dd.Width = 120
WorldQuestList.modeSwitcherCheck.s.dd.isButton = true
WorldQuestList.modeSwitcherCheck.s.dd.SetValueFunc = function(self,arg1)
	VWQL[charKey].TreasureModeType = arg1
	ELib.ScrollDropDown.Close()
	WQL_AreaPOIDataProviderMixin:RefreshAllData()
	WorldQuestList_Update()
end
WorldQuestList.modeSwitcherCheck.s.dd.List = {
	{text = "Treasures/Rares",	func = WorldQuestList.modeSwitcherCheck.s.dd.SetValueFunc,	arg1 = nil,	radio = true	},
	{text = "Treasures",		func = WorldQuestList.modeSwitcherCheck.s.dd.SetValueFunc,	arg1 = 2,	radio = true	},
	{text = "Rares",		func = WorldQuestList.modeSwitcherCheck.s.dd.SetValueFunc,	arg1 = 3,	radio = true	},
	{text = "Professions",		func = WorldQuestList.modeSwitcherCheck.s.dd.SetValueFunc,	arg1 = 4,	radio = true	},
	{text = CLOSE,			func = function() ELib.ScrollDropDown.Close() end,		padding = 16,	},
}

WorldQuestList.modeSwitcherCheck.s:SetScript("OnMouseDown",function(self, button)
	if button == "RightButton" and VWQL[charKey].TreasureMode then
		for i=1,#self.dd.List-1 do
			self.dd.List[i].checkState = VWQL[charKey].TreasureModeType == self.dd.List[i].arg1
		end
		ELib.ScrollDropDown.ClickButton(self.dd)
	end
end)


WorldQuestList.modeSwitcherCheck.s.isSetup = true
WorldQuestList.modeSwitcherCheck.s:SetScript("OnValueChanged",function(self)
	if self.isSetup then
		return
	end
	local val = floor(self:GetValue() + 0.5)
	local p = self:GetParent().Values[val * 2] or 0

	if bit.band(p,0x001) > 0 then
		VWQL[charKey].RegularQuestMode = true
	else
		VWQL[charKey].RegularQuestMode = nil
	end
	if bit.band(p,0x010) > 0 then
		VWQL[charKey].TreasureMode = true
	else
		VWQL[charKey].TreasureMode = nil
	end
	if bit.band(p,0x100) > 0 then
		VWQL[charKey].HolidaysMode = true
	else
		VWQL[charKey].HolidaysMode = nil
	end

	WQL_AreaPOIDataProviderMixin:RefreshAllData()
	WQL_HolidayDataProviderMixin:RefreshAllData()
	WorldQuestList_Update()
end)

WorldQuestList.modeSwitcherCheck.s.hl = WorldQuestList.modeSwitcherCheck.s:CreateTexture(nil, "BACKGROUND")
WorldQuestList.modeSwitcherCheck.s.hl:SetPoint("TOPLEFT", -2, 0)
WorldQuestList.modeSwitcherCheck.s.hl:SetPoint("BOTTOMRIGHT", 2, 0)
WorldQuestList.modeSwitcherCheck.s.hl:SetTexture("Interface\\Buttons\\WHITE8X8")
WorldQuestList.modeSwitcherCheck.s.hl:SetVertexColor(.7,.7,1,.15)
WorldQuestList.modeSwitcherCheck.s.hl:Hide()

WorldQuestList.modeSwitcherCheck.s:SetScript("OnEnter",function(self) self.hl:Show() end)
WorldQuestList.modeSwitcherCheck.s:SetScript("OnLeave",function(self) self.hl:Hide() end)

WorldQuestList.modeSwitcherCheck.Values = {}
WorldQuestList.modeSwitcherCheck.Update = function(self,showTrasure)
	self.s.isSetup = true

	wipe(self.Values)
	self.Values[#self.Values+1] = "WQ"
	self.Values[#self.Values+1] = 0x000

	if showTrasure then
		self.Values[#self.Values+1] = "T"
		self.Values[#self.Values+1] = 0x010
	end

	self.Values[#self.Values+1] = "Q"
	self.Values[#self.Values+1] = 0x001

	do
		self.holidays = nil

		--[[
		local eventsOn = {}
		local eventFoundAny

		local eventIndex = 1
		local eventInfo = C_Calendar.GetHolidayInfo(0,date("*t").day,eventIndex)
		while eventInfo do
			eventFoundAny = true

			eventsOn[eventInfo.texture or -1] = true

			eventIndex = eventIndex + eventIndex
			eventInfo = C_Calendar.GetHolidayInfo(0,date("*t").day,eventIndex)
		end

		for eventID,_ in pairs(WQLdb.HolidaysHeaders) do
			if eventsOn[eventID] then
				self.holidays = 1
				break
			end
		end
		]]

		local today = time()
		for i=1,#WQLdb.HolidaysDates do
			if today >= WQLdb.HolidaysDates[i][1] and today <= WQLdb.HolidaysDates[i][2] then
				self.holidays = 1
				break
			end
		end
	end

	if self.holidays == 1 then
		self.Values[#self.Values+1] = "H"
		self.Values[#self.Values+1] = 0x100
	end

	local index = 1
	while self.s["text"..index] do
		self.s["text"..index]:SetText("")
		index = index + 2
	end

	for i=1,#self.Values,2 do
		local t = self.s["text"..i] or self.s:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
		self.s["text"..i] = t
		t:SetText(self.Values[i])
		t:ClearAllPoints()

		local w = self.s:GetWidth() / (#self.Values / 2)

		t:SetPoint("CENTER",self.s,"LEFT",w*(i/2),0)

		local p = self.Values[i+1]
		if VWQL[charKey].HolidaysMode and p == 0x100 then
			val = (i - 1) / 2 + 1
		elseif VWQL[charKey].TreasureMode and p == 0x010 then
			val = (i - 1) / 2 + 1
		elseif VWQL[charKey].RegularQuestMode and p == 0x001 then
			val = (i - 1) / 2 + 1
		end
	end
	self.s:SetMinMaxValues(1,#self.Values / 2)
	self.s.thumb:SetWidth( self.s:GetWidth() / (#self.Values / 2) )
	self:AutoSetValue()

	self.s.isSetup = nil
end

WorldQuestList.modeSwitcherCheck.AutoSetValue = function(self)
	local val = 1
	for i=1,#self.Values,2 do
		local p = self.Values[i+1]
		if VWQL[charKey].HolidaysMode and p == 0x100 then
			val = (i - 1) / 2 + 1
		elseif VWQL[charKey].TreasureMode and p == 0x010 then
			val = (i - 1) / 2 + 1
		elseif VWQL[charKey].RegularQuestMode and p == 0x001 then
			val = (i - 1) / 2 + 1
		end
	end
	self.s:SetValue(val)
end


WorldQuestList.oppositeContinentButton = ELib:DropDown(WorldQuestList,"|TInterface\\FriendsFrame\\PlusManz-Alliance:16|t")
WorldQuestList.oppositeContinentButton.t:ClearAllPoints()
WorldQuestList.oppositeContinentButton.t:SetPoint("CENTER")
WorldQuestList.oppositeContinentButton:SetWidth(110)
WorldQuestList.oppositeContinentButton.l:Hide()

do
	local weekdays = {WEEKDAY_SUNDAY, WEEKDAY_MONDAY, WEEKDAY_TUESDAY, WEEKDAY_WEDNESDAY, WEEKDAY_THURSDAY, WEEKDAY_FRIDAY, WEEKDAY_SATURDAY}
	local zones = {862, 895,863, 942,864, 896}
	WorldQuestList.oppositeContinentButton.OnEnterFunc = function(self)
		self.hl:Show() 
		if self.mapID == 876 or self.mapID == 875 then
			local region = WorldQuestList:GetCurrentRegion()
			if region == 1 or region == 2 then
				local currTime = GetServerTime()
				local invTime = (region == 2 and 1545195600 or 1545228000)
				local zone = 1
				while (currTime - 25200) > invTime do
					invTime = invTime + 68400
					zone = zone + 1
					if zone > 6 then zone = 1 end
				end
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
				GameTooltip:AddLine(SPLASH_BATTLEFORAZEROTH_8_1_FEATURE2_TITLE)
				for i=0,5 do
					local nowInvTime = invTime + (68400 * i)
					local nowZone = zone + i
					if nowZone > 6 then nowZone = nowZone - 6 end
					local startTime = nowInvTime
					local endTime = nowInvTime + 25200
					if date("%x",startTime) ~= date("%x",endTime) then
						startTime = date("%X ",startTime):gsub(":00 "," ") .. FormatShortDate(date("*t",startTime).day,date("*t",startTime).month) .. ", " ..weekdays[ date("*t",startTime).wday ]
						endTime = date("%X ",endTime):gsub(":00 "," ") .. FormatShortDate(date("*t",endTime).day,date("*t",endTime).month) .. ", " ..weekdays[ date("*t",endTime).wday ]
					else
						startTime = date("%X",startTime):gsub(":00$","")
						endTime = date("%X ",endTime):gsub(":00 "," ") .. FormatShortDate(date("*t",endTime).day,date("*t",endTime).month) .. ", " ..weekdays[ date("*t",endTime).wday ]
					end
					GameTooltip:AddDoubleLine(
						(nowInvTime < currTime and "|cff00ff00"..CONTRIBUTION_ACTIVE or WorldQuestList:FormatTime((nowInvTime - currTime)/60):gsub("|c........",""))..
						(nowZone % 2 == 1 and "|TInterface\\FriendsFrame\\PlusManz-Horde:0|t" or "|TInterface\\FriendsFrame\\PlusManz-Alliance:0|t")..
						" ("..startTime.." - "..endTime..")",
						WorldQuestList:GetMapName(zones[nowZone])
					)
				end
				GameTooltip:Show()
			end
		end
	end
	WorldQuestList.oppositeContinentButton.OnLeaveFunc = function(self)
		self.hl:Hide() 
		GameTooltip_Hide()

	end
end

WorldQuestList.oppositeContinentButton.Button:Hide()
WorldQuestList.oppositeContinentButton.t:Hide()
for i=1,6 do
	local button = CreateFrame("Button",nil,WorldQuestList.oppositeContinentButton)
	WorldQuestList.oppositeContinentButton["Button"..i] = button
	if i == 1 then
		button:SetPoint("LEFT",1,0)
	else
		button:SetPoint("LEFT",WorldQuestList.oppositeContinentButton["Button"..(i-1)],"RIGHT",1,0)
	end
	button:SetScript("OnClick",function(self)
		local mapID = self.mapID or 875
		if type(mapID) == 'table' then
			local curr = (self.prev or 1) - 1
			if curr < 1 then
				curr = #mapID
			end
			if GetCurrentMapID() == mapID[curr] then
				curr = curr - 1
				if curr < 1 then
					curr = #mapID
				end
			end
			mapID = mapID[curr]
			self.prev = curr
		end
		WorldMapFrame:SetMapID(mapID)
		WorldQuestList.SoloMapID = mapID
		if WorldQuestList.IsSoloRun then
			WorldQuestList_Update()
		end
	end)
	button:SetSize(17,17)

	button.hl = button:CreateTexture(nil, "BACKGROUND")
	button.hl:SetPoint("TOPLEFT", 0, 0)
	button.hl:SetPoint("BOTTOMRIGHT", 0, 0)
	button.hl:SetTexture("Interface\\Buttons\\WHITE8X8")
	button.hl:SetVertexColor(.7,.7,1,.25)
	button.hl:Hide()

	button.t = button:CreateTexture(nil,"ARTWORK")
	button.t:SetPoint("CENTER")
	button.t:SetSize(14,14)

	button.t2 = button:CreateTexture(nil,"ARTWORK",nil,2)
	button.t2:SetPoint("CENTER",-2,-2)
	button.t2:SetSize(10,10)

	button.t3 = button:CreateTexture(nil,"ARTWORK",nil,1)
	button.t3:SetPoint("CENTER",2,2)
	button.t3:SetSize(10,10)

	button:SetScript("OnEnter",WorldQuestList.oppositeContinentButton.OnEnterFunc)
	button:SetScript("OnLeave",WorldQuestList.oppositeContinentButton.OnLeaveFunc)
end

WorldQuestList.oppositeContinentButton.Update = function(self) 
	local level = UnitLevel'player'
	if level > 70 and self.State ~= 80 then
		self.Button6.mapID = 619
		self.Button6.t:SetTexCoord(0,1,0,1)
		self.Button6.t:SetAtlas("worldquest-icon-burninglegion")
		self.Button6.t:SetDesaturated(false)

		self.Button5.mapID = 876
		self.Button5.t:SetTexCoord(0,1,0,1)
		self.Button5.t:SetAtlas("worldquest-icon-alliance")
		self.Button5.t:SetSize(17,17)

		self.Button4.mapID = 875
		self.Button4.t:SetAtlas("worldquest-icon-horde")
		self.Button4.t2:SetTexture("")
		self.Button4.t3:SetTexture("")
		self.Button4.t:SetSize(17,17)

		self.Button3.mapID = 1550
		self.Button3.t:SetAtlas("Mobile-Inscription")
		self.Button3.t2:SetTexture("")
		self.Button3.t3:SetTexture("")
		self.Button3.t:SetSize(17,17)

		self.Button2.mapID = 1978
		self.Button2.t:SetAtlas("dragon-rostrum")
		self.Button2.t:SetSize(14,14)

		self.Button1.mapID = 2274
		self.Button1.t:SetAtlas("warwithin-landingbutton-up")

		self.State = 80
	elseif level > 60 and level <= 70 and self.State ~= 70 then
		self.Button6.mapID = 619
		self.Button6.t:SetTexCoord(0,1,0,1)
		self.Button6.t:SetAtlas("worldquest-icon-burninglegion")
		self.Button6.t:SetDesaturated(false)

		self.Button5.mapID = 876
		self.Button5.t:SetTexCoord(0,1,0,1)
		self.Button5.t:SetAtlas("worldquest-icon-alliance")
		self.Button5.t:SetSize(17,17)

		self.Button4.mapID = 875
		self.Button4.t:SetAtlas("worldquest-icon-horde")
		self.Button4.t2:SetTexture("")
		self.Button4.t3:SetTexture("")
		self.Button4.t:SetSize(17,17)

		self.Button3.mapID = 1550
		self.Button3.t:SetAtlas("Mobile-Inscription")
		self.Button3.t2:SetTexture("")
		self.Button3.t3:SetTexture("")
		self.Button3.t:SetSize(17,17)

		self.Button2.mapID = 2200
		self.Button2.t:SetAtlas("SeedPlanting-Full")
		self.Button2.t:SetSize(17,17)

		self.Button1.mapID = 1978
		self.Button1.t:SetAtlas("dragon-rostrum")

		self.State = 70
	elseif level > 50 and level <= 60 and self.State ~= 60 then
		self.Button6.mapID = 1543
		self.Button6.t:SetTexCoord(0,1,0,1)
		self.Button6.t:SetAtlas("Dungeon")
		self.Button6.t:SetDesaturated(true)

		self.Button5.mapID = 1525
		self.Button5.t:SetTexCoord(0,1,0,1)
		self.Button5.t:SetAtlas("shadowlands-landingbutton-venthyr-up")
		self.Button5.t:SetSize(20,20)

		self.Button4.mapID = 1565
		self.Button4.t:SetAtlas("shadowlands-landingbutton-NightFae-up")
		self.Button4.t2:SetTexture("")
		self.Button4.t3:SetTexture("")
		self.Button4.t:SetSize(20,20)

		self.Button3.mapID = 1536
		self.Button3.t:SetAtlas("shadowlands-landingbutton-necrolord-up")
		self.Button3.t2:SetTexture("")
		self.Button3.t3:SetTexture("")
		self.Button3.t:SetSize(20,20)

		self.Button2.mapID = 1533
		self.Button2.t:SetAtlas("shadowlands-landingbutton-kyrian-up")
		self.Button2.t:SetSize(20,20)

		self.Button1.mapID = 1550
		self.Button1.t:SetAtlas("Mobile-Inscription")

		self.State = 60
	elseif level == 50 and self.State ~= 50 then
		self.Button6.mapID = {1527,1530}
		self.Button6.t:SetAtlas("worldquest-icon-nzoth")
		self.Button6.t:SetTexCoord(0,1,0,1)

		self.Button5.mapID = 1355
		self.Button5.t:SetAtlas("Mobile-Inscription")
		self.Button5.t:SetTexCoord(0,1,0,1)

		self.Button4.mapID = 62
		self.Button4.t:SetTexture("")
		self.Button4.t2:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")
		self.Button4.t3:SetAtlas("worldquest-icon-pvp-ffa")

		self.Button3.mapID = 14
		self.Button3.t:SetTexture("")
		self.Button3.t2:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")
		self.Button3.t3:SetAtlas("worldquest-icon-pvp-ffa")

		self.Button2.mapID = 876
		self.Button2.t:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")

		self.Button1.mapID = 875
		self.Button1.t:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")

		self.State = 50
	elseif level < 50 and self.State ~= 1 then
		self.Button6.mapID = 947
		self.Button6.t:SetAtlas("TaxiNode_Continent_Neutral")
		self.Button6.t:SetTexCoord(.2,.8,.2,.8)

		self.Button5.mapID = 424
		self.Button5.t:SetAtlas("raceicon-pandaren-female")
		self.Button5.t:SetTexCoord(.15,.85,.15,.85)

		self.Button4.mapID = 113
		self.Button4.t:SetAtlas("Dungeon")
		self.Button4.t2:SetTexture("")
		self.Button4.t3:SetTexture("")

		self.Button3.mapID = 101
		self.Button3.t:SetAtlas("Raid")
		self.Button3.t2:SetTexture("")
		self.Button3.t3:SetTexture("")

		self.Button2.mapID = 13
		self.Button2.t:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")

		self.Button1.mapID = 12
		self.Button1.t:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")

		self.State = 1
	end
	--FlightMasterArgus
	--raceicon-pandaren-female
	--Mobile-Inscription
	--legionmission-landingbutton-warrior-up
	--MagePortalHorde
	--Vehicle-Mogu
end
WorldQuestList.oppositeContinentButton.State = nil
WorldQuestList.oppositeContinentButton:Update()


WorldQuestList.moveHeader = ELib:DropDown(WorldQuestList,"WQL")
WorldQuestList.moveHeader:SetPoint("BOTTOMLEFT",WorldQuestList,"TOPLEFT",0,1)
--WorldQuestList.moveHeader:SetWidth(50)
WorldQuestList.moveHeader.l:Hide()
WorldQuestList.moveHeader.t:ClearAllPoints()
WorldQuestList.moveHeader.t:SetPoint("CENTER",0,0)
WorldQuestList.moveHeader.Button.i:Hide()
WorldQuestList.moveHeader.Button:SetAllPoints()
WorldQuestList.moveHeader.Button:SetScript("OnClick",nil)
WorldQuestList.moveHeader.Button:RegisterForDrag("LeftButton")

WorldQuestList.moveHeader.Button:SetScript("OnDragStart", function(self)
	if WorldQuestList.moveHeader.disabled and not WorldQuestList.IsSoloRun then return end
	WorldQuestList:SetMovable(true)
	--WorldQuestList:SetClampedToScreen(true)
	WorldQuestList:StartMoving()
	WorldQuestList.IsOnMove = true
	self.ticker = C_Timer.NewTicker(0.5,function()
		WorldQuestList_Update()
	end)
end)
WorldQuestList.moveHeader.Button:SetScript("OnDragStop", function(self)
	if WorldQuestList.moveHeader.disabled and not WorldQuestList.IsSoloRun then return end
	WorldQuestList:StopMovingOrSizing()
	WorldQuestList:SetMovable(false)
	WorldQuestList:SetClampedToScreen(false)
	WorldQuestList.IsOnMove = nil
	if WorldQuestList.IsSoloRun then
		VWQL.PosLeft = WorldQuestList:GetLeft()
		VWQL.PosTop = WorldQuestList:GetTop()

		WorldQuestList:ClearAllPoints()
		WorldQuestList:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",VWQL.PosLeft,VWQL.PosTop)
	end
	if VWQL.Anchor == 3 and WorldMapFrame:IsVisible() then
		VWQL.Anchor3PosLeft = WorldQuestList:GetLeft()
		VWQL.Anchor3PosTop = WorldQuestList:GetTop()

		WorldQuestList:ClearAllPoints()
		WorldQuestList:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",VWQL.Anchor3PosLeft,VWQL.Anchor3PosTop)
	end
	if self.ticker then
		self.ticker:Cancel()
		self.ticker = nil
	end
end)

WorldQuestList.moveHeader:SetClampedToScreen(true)


local SortFuncs = {}
SortFuncs[1] = function(a,b) if a and b and a.time and b.time then 
			if abs(a.time - b.time) <= 2 then 
				return SortFuncs[5](a,b)
			else 
				return a.time < b.time 
			end 
		end 
	end
SortFuncs[2] = function(a,b) if a and b then 
			if a.zoneID == b.zoneID then
				if abs(a.time - b.time) <= 2 then 
					return SortFuncs[5](a,b)
				else
					return a.time < b.time 
				end
			else
				return a.zoneID < b.zoneID
			end
		end
	end
SortFuncs[3] = function(a,b) return a.name < b.name end
SortFuncs[4] = function(a,b) if a.factionSort == b.factionSort then 
			if a.time and b.time then 
				if abs(a.time - b.time) <= 2 then 
					return SortFuncs[5](a,b)
				else 
					return a.time < b.time 
				end 
			else 
				return a.name < b.name 
			end
		else 
			return a.factionSort < b.factionSort 
		end
	end
SortFuncs[5] = function(a,b) if a and b then 
			if a.rewardType ~= b.rewardType then 
				return a.rewardType < b.rewardType 
			elseif a.rewardSort == b.rewardSort then
				return (a.name or "0") > (b.name or "0")
			else
				return a.rewardSort > b.rewardSort 
			end 
		end 
	end
SortFuncs[6] = function(a,b) if a and b then return a.distance < b.distance end end



WorldQuestList.WMF_activePins = {}
local WQ_provider
for provider,status in pairs(WorldMapFrame.dataProviders) do
	if status and provider.AddWorldQuest and provider:GetPinTemplate() == "WorldMap_WorldQuestPinTemplate" then	--Any way to do this not so ugly?
		WQ_provider = provider
		break
	end
end


--[[
WQ_provider = CreateFromMixins(WorldMap_WorldQuestDataProviderMixin)

function WQ_provider:GetPinTemplate()
	return "WQL_WorldQuestPinTemplate";
end

WorldMapFrame:AddDataProvider(WQ_provider)
]]

WorldQuestList.WMF_WQ_provider = WQ_provider
if WQ_provider then
	WQ_provider:GetMap():RegisterCallback("WorldQuestsUpdate", function()
		if WorldQuestList.IconsGeneralLastMap and WorldMapFrame:GetMapID() ~= WorldQuestList.IconsGeneralLastMap then
			for questId in pairs(WorldQuestList.WMF_activePins) do
				if WQ_provider.pingPin and WQ_provider.pingPin.questID == questId then
					WQ_provider.pingPin:Stop()
				end
				local pin = WorldQuestList.WMF_activePins[questId]

				WQ_provider:GetMap():RemovePin(pin)
			end
			wipe(WorldQuestList.WMF_activePins)
			WorldQuestList.IconsGeneralLastMap = nil
		else
			for questId,pin in pairs(WorldQuestList.WMF_activePins) do
				pin:RefreshVisuals()
			end
			--WorldQuestList:WQIcons_AddIcons()
		end

		local mapID = WQ_provider:GetMap():GetMapID()
		if VWQL[charKey].TreasureMode and WorldQuestList.TreasureData[mapID or 0] then
			WQ_provider:RemoveAllData()
		end
	end, WQ_provider)
end

--[[
local WQ_provider_Extra = CreateFromMixins(WorldMap_WorldQuestDataProviderMixin)

function WQ_provider_Extra:GetPinTemplate()
	return "WQL_WorldQuestPinTemplate";
end

function WQ_provider_Extra:RefreshAllData()
	local pinsToRemove = {};
	for questId in pairs(self.activePins) do
		pinsToRemove[questId] = true;
	end
end

WorldMapFrame:AddDataProvider(WQ_provider_Extra)
]]


WQL_AreaPOIDataProviderMixin = CreateFromMixins(AreaPOIDataProviderMixin)

function WQL_AreaPOIDataProviderMixin:OnShow()
end

function WQL_AreaPOIDataProviderMixin:GetPinTemplate()
	return "WQL_AreaPOIPinTemplate";
end
function WQL_AreaPOIDataProviderMixin:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate(self:GetPinTemplate())
end
function WQL_AreaPOIDataProviderMixin:RefreshAllData()
	if not self:GetMap() then	--fix error on load
		return
	end
	self:RemoveAllData()

	if not VWQL[charKey].TreasureMode then
		return
	end

	local mapID = self:GetMap():GetMapID()

	local treasureModeType = VWQL[charKey].TreasureModeType

	local treasureData = WorldQuestList.TreasureData[mapID]
	if treasureData then
		for i=1,#treasureData do
			local x,y,name,tType,reward,note,questID,specialFunc = 
				treasureData[i][1],treasureData[i][2],treasureData[i][3],treasureData[i][4],treasureData[i][5],treasureData[i][6],treasureData[i][7],treasureData[i][8]

			if (not specialFunc or specialFunc()) and (
				(not treasureModeType and (tType == 1 or tType == 2 or tType == 3))
				or (treasureModeType == 2 and (tType == 3))
				or (treasureModeType == 3 and (tType == 1 or tType == 2))
				or (treasureModeType == 4 and (tType == 4))
			)
			then
				local pin = self:GetMap():AcquirePin(self:GetPinTemplate(), {
					areaPoiID = 0,
					name = name,
					description = note,
					position = CreateVector2D(x, y),
					atlasName = tType == 3 and "VignetteLoot" or 
						tType == 2 and "worldquest-questmarker-epic" or
						"worldquest-questmarker-rare",
					itemID = reward,
					clickData = {
						x = x,
						y = y,
						mapID = mapID,
					},
				})

				if not pin.Background then
					pin.Background = pin:CreateTexture()
					pin.Background:SetPoint("CENTER",1,-1)
				end
				if not pin.Overlay then
					pin.Overlay = pin:CreateTexture(nil,"OVERLAY")
					pin.Overlay:SetPoint("CENTER",0,0)
				end

				if tType == 2 then
					pin.Background:SetAtlas("worldquest-questmarker-dragon")
					pin.Background:SetSize(22,22)
				else
					pin.Background:SetTexture()
				end

				if tType == 2 or tType == 1 then
					pin.Overlay:SetAtlas("worldquest-questmarker-questbang")
					pin.Overlay:SetSize(3,8)
				elseif tType == 4 then
					pin.Overlay:SetTexture(treasureData[i].icon or "133778")
					pin.Overlay:SetSize(12,12)
				else
					pin.Overlay:SetTexture()
				end

				if tType == 3 then
					pin:SetSize(17,17)
					pin.Texture:SetSize(20,20)
				elseif tType == 4 then
					pin:SetSize(24,24)
					pin.Texture:SetSize(21,21)
				else
					pin:SetSize(15,15)
					pin.Texture:SetSize(13,13)
				end

				if questID and C_QuestLog.IsQuestFlaggedCompleted(questID) then
					pin.Texture:SetDesaturated(true)
					pin.Overlay:SetAtlas("XMarksTheSpot")
					pin.Overlay:SetSize(6,6)
				else
					pin.Texture:SetDesaturated(false)
				end
			end
		end
	end
end
WQL_AreaPOIDataProviderMixin.WQL_Signature = true



WorldQuestList.Waypoints = {}

WQL_WayDataProviderMixin = CreateFromMixins(AreaPOIDataProviderMixin)

function WQL_WayDataProviderMixin:OnShow()
end

function WQL_WayDataProviderMixin:GetPinTemplate()
	return "WQL_WayPinTemplate";
end
function WQL_WayDataProviderMixin:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate(self:GetPinTemplate())
end
function WQL_WayDataProviderMixin:RefreshAllData()
	if not self:GetMap() then	--fix error on load
		return
	end
	self:RemoveAllData()

	local mapID = self:GetMap():GetMapID()

	for i=1,#WorldQuestList.Waypoints do
		local waypoint = WorldQuestList.Waypoints[i]
		local x,y = waypoint.x,waypoint.y
		local passMapCheck = mapID == waypoint.mapID
		local size = 1
		if not passMapCheck then
			local xMin,xMax,yMin,yMax = C_Map.GetMapRectOnMap(waypoint.mapID,mapID)
			if xMin ~= xMax and yMin ~= yMax then
				x = xMin + x * (xMax - xMin)
				y = yMin + y * (yMax - yMin)

				passMapCheck = true
				size = .65
			end
		end
		if passMapCheck then
			local pin = self:GetMap():AcquirePin(self:GetPinTemplate(), {
				areaPoiID = 0,
				name = "X",
				description = "WQL Arrow",
				size = size,
				position = CreateVector2D(x, y),
				atlasName = "XMarksTheSpot",
				clickData = {
					x = x,
					y = y,
					mapID = mapID,
				},
				data = waypoint,
			})
		end
	end
end
WQL_WayDataProviderMixin.WQL_Signature = true

WorldMapFrame:AddDataProvider(WQL_WayDataProviderMixin)

function WorldQuestList:WaypointRemove(waypoint)
	waypoint = waypoint or WorldQuestList.Waypoints[1]
	for i=#WorldQuestList.Waypoints,1,-1 do
		if WorldQuestList.Waypoints[i] == waypoint then
			tremove(WorldQuestList.Waypoints,i)
			WQL_WayDataProviderMixin:RefreshAllData()
			return
		end
	end
end

local ITEM_LEVEL = (ITEM_LEVEL or "NO DATA FOR ITEM_LEVEL"):gsub("%%d","(%%d+%+*)")

local NUM_WORLDMAP_TASK_POIS = 0

local function WorldQuestList_Leveling_Update()
	local quests = {}
	local prevHeader = nil
	for i=1,C_QuestLog.GetNumQuestLogEntries() do
		local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(i)
		if isHeader then
			prevHeader = title
		elseif questID and QuestUtils_IsQuestWorldQuest(questID) then

		elseif questID and questID ~= 0 then
			quests[#quests+1] = {
				title = title,
				header = prevHeader,
				questID = questID,
				isCompleted = IsQuestComplete(questID),
				id = i,
			}
		end
	end


	local currMapID = GetCurrentMapID()
	local taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(currMapID)
	if UnitLevel'player' < 50 then
		for _,info in pairs(taskInfo or WorldQuestList.NULLTable) do
			if HaveQuestData(info.questID) and QuestUtils_IsQuestWorldQuest(info.questID) then
				local _,_,worldQuestType,rarity, isElite, tradeskillLineIndex, allowDisplayPastCritical = GetQuestTagInfo(info.questID)

				quests[#quests+1] = {
					title = C_TaskQuest.GetQuestInfoByQuestID(info.questID),
					header = MAP_UNDER_INVASION,
					questID = info.questID,
					isCompleted = false,
					isInvasion = worldQuestType == LE.LE_QUEST_TAG_TYPE_INVASION,
					isElite = isElite,
					isWQ = true,
				}
			end
		end
	end

	local questsOnMap = C_QuestLog.GetQuestsOnMap(currMapID)
	
	for i, questData in ipairs(quests) do
		for _,info in pairs(taskInfo or WorldQuestList.NULLTable) do
			if info.questID == questData.questID then
				questData.x = info.x
				questData.y = info.y
				break
			end
		end
		for _,info in pairs(questsOnMap or WorldQuestList.NULLTable) do
			if info.questID == questData.questID then
				questData.x = info.x
				questData.y = info.y
				break
			end
		end
	end

	local numTaskPOIs = #quests

	if ( NUM_WORLDMAP_TASK_POIS < numTaskPOIs ) then
		for i=NUM_WORLDMAP_TASK_POIS+1, numTaskPOIs do
			WorldQuestList_CreateLine(i)
		end
		NUM_WORLDMAP_TASK_POIS = numTaskPOIs
	end

	local result = {}
	local taskIconIndex = 1


	if ( numTaskPOIs > 0 ) then
		for i, questData in ipairs(quests) do
			local title = questData.title
			local header = questData.header
			local questID = questData.questID

			local x,y = questData.x,questData.y
			if questData.isWQ then
				x,y = C_TaskQuest.GetQuestLocation(questID,currMapID)
			end

			local overrideMap = nil
			if not x then
				local questMapID = GetQuestUiMapID(questID)
				if questMapID then
					x,y = WorldQuestList:GetQuestCoord_NonWQ(questID,questMapID,currMapID)
					if x then
						overrideMap = questMapID
					end
				end
			end

			if x and y and x ~= 0 and y ~= 0 then
				local rewardXP = GetQuestLogRewardXP(questID)
				if rewardXP == 0 then
					rewardXP = nil
				end

				local reward, rewardColor

				local numRewards = GetNumQuestLogRewards(questID)
				if numRewards > 0 then
					local name,icon,numItems,quality,_,itemID = GetQuestLogRewardInfo(1,questID)
					if name then
						reward = "|T"..icon..":0|t "..name..(numItems and numItems > 1 and " x"..numItems or "")
					end

					if quality and quality >= LE.LE_ITEM_QUALITY_COMMON and LE.BAG_ITEM_QUALITY_COLORS[quality] then
						rewardColor = LE.BAG_ITEM_QUALITY_COLORS[quality]
					end

				end

				if not reward then
					local numQuestCurrencies = GetNumQuestLogRewardCurrencies(questID)
					for i = 1, numQuestCurrencies do
						local name, texture, numItems = GetQuestLogRewardCurrencyInfo(i, questID)
						local text = BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT:format(texture, numItems, name)

						reward = text
					end
				end

				tinsert(result,{
					questID = questID,
					name = (questData.isCompleted and "|cff00ff00" or "")..title,
					info = {
						x = x,
						y = y,
						mapID = overrideMap or currMapID,
						defMapID = currMapID,
					},
					rewardXP = rewardXP,
					reward = reward,
					rewardColor = rewardColor,
					header = header,
					numRewards = numRewards,
					isInvasion = questData.isInvasion,
					isElite = questData.isElite,
					isCompleted = questData.isCompleted,
					disableLFG = WorldQuestList:IsQuestDisabledForLFG(questID),
				})
			end
		end
	end

	local lfgEyeStatus = true
	if C_LFGList.GetActiveEntryInfo() or VWQL.DisableLFG or VWQL.LFG_HideEyeInList then
		lfgEyeStatus = false
	end

	for i=1,#result do
		local data = result[i]
		local line = WorldQuestList.l[taskIconIndex]

		line.name:SetText(data.name)
		line.name:SetTextColor(1,1,1)

		line.nameicon:SetTexture("")
		line.nameicon:SetWidth(1)
		line.secondicon:SetTexture("")
		line.secondicon:SetWidth(1)

		line.reward:SetText(data.reward or "")
		if data.rewardColor then
			line.reward:SetTextColor(data.rewardColor.r, data.rewardColor.g, data.rewardColor.b)
		else
			line.reward:SetTextColor(1,1,1)
		end
		if data.reward then
			line.reward.ID = data.questID
		else
			line.reward.ID = nil
		end
		if data.numRewards and data.numRewards > 1 then
			line.reward.IDs = data.numRewards
		else
			line.reward.IDs = nil
		end
		line.isRewardLink = nil

		local questNameWidth = WorldQuestList.NAME_WIDTH
		if data.isInvasion then
			line.secondicon:SetAtlas("worldquest-icon-burninglegion")
			line.secondicon:SetWidth(16)

			line.name:SetTextColor(0.78, 1, 0)

			if data.isElite then
				line.nameicon:SetAtlas("nameplates-icon-elite-silver")
				line.nameicon:SetWidth(16)
				questNameWidth = questNameWidth - 15
			end

			questNameWidth = questNameWidth - 15
		end

		line.name:SetWidth(questNameWidth)

		line.faction:SetText(data.header or "")
		line.faction:SetTextColor(1,1,1)

		line.zone:SetText("")
		line.timeleft:SetText(data.rewardXP or "")

		line.zone:Hide()
		line.zone.f:Hide()

		line.questID = data.questID
		line.numObjectives = 0

		line.nqhl:Hide()

		if lfgEyeStatus then
			if data.isCompleted or data.disableLFG then
				line.LFGButton.questID = nil
			else
				line.LFGButton.questID = data.questID
			end
			line.LFGButton:Hide()
			line.LFGButton:Show()
		else
			line.LFGButton:Hide()
		end

		line.name:SetWordWrap(false)	--icon-in-text v-spacing fix
		line.faction:SetWordWrap(false)	--icon-in-text v-spacing fix

		line.rewardLink = nil
		line.data = data.info
		line.dataResult = data
		line.faction.f.tooltip = nil
		line.faction.f.reputationList = nil
		line.isInvasionPoint = nil
		line.timeleft.f._t = nil
		line.achievementID = nil

		line.isLeveling = true
		line.isTreasure = nil

		line:Show()

		taskIconIndex = taskIconIndex + 1
	end

	WorldQuestList.currentResult = result

	WorldQuestList:SetWidth(WorldQuestList_Width)

	WorldQuestList:SetHeight(max(16*(taskIconIndex-1)+WorldQuestList.SCROLL_FIX_BOTTOM+WorldQuestList.SCROLL_FIX_TOP,1))
	WorldQuestList.C:SetHeight(max(16*(taskIconIndex-1),1))

	local lowestLine = #WorldQuestList.Cheader.lines
	for i=1,#WorldQuestList.Cheader.lines do
		local bottomPos = WorldQuestList.Cheader.lines[i]:GetBottom() or 0
		if bottomPos and bottomPos < 40 then
			lowestLine = i - 1
			break
		end
	end

	if VWQL.MaxLinesShow then
		lowestLine = min(VWQL.MaxLinesShow,lowestLine)
	end

	if lowestLine >= taskIconIndex then
		WorldQuestList.Cheader:SetVerticalScroll(0)
	else
		WorldQuestList:SetHeight((lowestLine+1)*16)
		WorldQuestList.Cheader:SetVerticalScroll( max(min(WorldQuestList.C:GetHeight() - WorldQuestList.Cheader:GetHeight(),WorldQuestList.Cheader:GetVerticalScroll()),0) )
	end
	UpdateScrollButtonsState()
	C_Timer.After(0,UpdateScrollButtonsState)

	WorldQuestList.header:Update(true)
	WorldQuestList.footer:Update(true)
	ViewAllButton:Hide()

	for i = taskIconIndex, NUM_WORLDMAP_TASK_POIS do
		WorldQuestList.l[i]:Hide()
	end

	if taskIconIndex == 1 then
		WorldQuestList.b:SetAlpha(0)
		WorldQuestList.backdrop:Hide()
	else
		WorldQuestList.b:SetAlpha(WorldQuestList.b.A or 1)
		WorldQuestList.backdrop:Show()
	end

	WorldQuestList.oppositeContinentButton:Update()
	WorldQuestList.modeSwitcherCheck:Update(WorldQuestList.TreasureData[currMapID])

	HookWQbuttons()

	if VWQL.Anchor == 2 then	--Inside
		UpdateScale()
	end
end


local function WorldQuestList_Treasure_Update()
	local currMapID = GetCurrentMapID()

	local result = {}

	local treasureData = WorldQuestList.TreasureData[currMapID]
	local treasureModeType = VWQL[charKey].TreasureModeType
	if treasureData then
		for i=1,#treasureData do
			local rewardText, rewardColor, rewardLink

			local x,y,name,tType,reward,note,questID,specialFunc = 
				treasureData[i][1],treasureData[i][2],treasureData[i][3],treasureData[i][4],treasureData[i][5],treasureData[i][6],treasureData[i][7],treasureData[i][8]

			if (not questID or not C_QuestLog.IsQuestFlaggedCompleted(questID)) and (not specialFunc or specialFunc()) and (
				(not treasureModeType and (tType == 1 or tType == 2 or tType == 3))
				or (treasureModeType == 2 and (tType == 3))
				or (treasureModeType == 3 and (tType == 1 or tType == 2))
				or (treasureModeType == 4 and (tType == 4))
			) then
				local rewardsTable
				if type(reward) == 'table' then 
					rewardsTable = reward
					reward = reward[1] 
				end

				if reward then
					local name,link,quality,itemLevel,_,_,_,_,_,icon = C_Item.GetItemInfo(reward)
					if name then
						rewardText = "|T"..icon..":0|t "..name
					end

					rewardLink = link

					if quality and quality >= LE.LE_ITEM_QUALITY_COMMON and LE.BAG_ITEM_QUALITY_COLORS[quality] then
						rewardColor = LE.BAG_ITEM_QUALITY_COLORS[quality]

						if quality == 1 then
							rewardColor = nil
						end
					elseif quality and quality == 0 then
						rewardColor = LE.BAG_ITEM_QUALITY_COLORS[1]
					end
				end
				local rewardLink2
				if rewardsTable then
					for j=2,#rewardsTable do
						local name,link,quality,itemLevel,_,_,_,_,_,icon = C_Item.GetItemInfo(rewardsTable[j])
						if name then
							rewardText = (rewardText or "") .. ", |T"..icon..":0|t "..name
						end
						rewardLink2 = link
					end
				end

				tinsert(result,{
					uid = i,
					questID = questID or -100000-i,
					name = name,
					info = {
						x = x,
						y = y,
						mapID = currMapID,
						questID = -i,
					},
					reward = rewardText,
					rewardColor = rewardColor,
					rewardID = rewardLink,
					rewardID2 = rewardLink2,
					note = note,
					isElite = tType == 2,
					isTreasure = tType == 3,
					rarity = 1,
				})
			end
		end
	end

	if not WQL_AreaPOIDataProviderMixin.isAdded then
		WorldMapFrame:AddDataProvider(WQL_AreaPOIDataProviderMixin)

		WQL_AreaPOIDataProviderMixin:RefreshAllData()
	end
	if WQ_provider then
		WorldQuestList.IconsGeneralLastMap = nil
		WQ_provider:GetMap():TriggerEvent("WorldQuestsUpdate", WQ_provider:GetMap():GetNumActivePinsByTemplate(WQ_provider:GetPinTemplate()))
		--WQ_provider:RemoveAllData()
	end

	local numTaskPOIs = #result

	if ( NUM_WORLDMAP_TASK_POIS < numTaskPOIs ) then
		for i=NUM_WORLDMAP_TASK_POIS+1, numTaskPOIs do
			WorldQuestList_CreateLine(i)
		end
		NUM_WORLDMAP_TASK_POIS = numTaskPOIs
	end

	local taskIconIndex = 1

	for i=1,#result do
		local data = result[i]
		local line = WorldQuestList.l[taskIconIndex]

		line.name:SetText(data.name)
		line.name:SetTextColor(1,1,1)

		line.nameicon:SetTexture("")
		line.nameicon:SetWidth(1)
		line.secondicon:SetTexture("")
		line.secondicon:SetWidth(1)

		line.reward:SetText(data.reward or "")
		if data.rewardColor then
			line.reward:SetTextColor(data.rewardColor.r, data.rewardColor.g, data.rewardColor.b)
		else
			line.reward:SetTextColor(1,1,1)
		end

		if data.rewardID then
			line.reward.ID = data.rewardID
			line.isRewardLink = true
			line.rewardLink = data.rewardID
		else
			line.reward.ID = nil
			line.isRewardLink = nil
			line.rewardLink = nil
		end
		line.reward.IDs = nil

		if data.rewardID2 then
			line.rewardLink2 = data.rewardID2
		else
			line.rewardLink2 = nil
		end

		local questNameWidth = WorldQuestList.NAME_WIDTH
		if data.isElite then
			line.nameicon:SetAtlas("nameplates-icon-elite-silver")
			line.nameicon:SetWidth(16)
			questNameWidth = questNameWidth - 15
		end

		if data.isTreasure then
			line.nameicon:SetAtlas("VignetteLoot")
			line.nameicon:SetWidth(16)
			questNameWidth = questNameWidth - 15
		end

		line.name:SetWidth(questNameWidth)

		line.faction:SetText(data.note or "")
		line.faction:SetTextColor(1,1,1)

		line.zone:SetText("")
		line.timeleft:SetText("")

		if data.questID < 0 then
			line.timeleft:SetText("no tracking")
		end

		line.zone:Hide()
		line.zone.f:Hide()

		line.questID = data.questID
		line.numObjectives = 0

		line.nqhl:Hide()

		line.LFGButton:Hide()

		line.rewardLink = nil
		line.data = data.info
		line.dataResult = data
		line.faction.f.tooltip = nil
		line.faction.f.reputationList = nil
		line.isInvasionPoint = nil
		line.timeleft.f._t = nil
		line.achievementID = nil

		line.isLeveling = true
		line.isTreasure = true

		line:Show()

		taskIconIndex = taskIconIndex + 1
	end

	WorldQuestList.currentResult = result

	WorldQuestList:SetWidth(WorldQuestList_Width)

	WorldQuestList:SetHeight(max(16*(taskIconIndex-1)+WorldQuestList.SCROLL_FIX_BOTTOM+WorldQuestList.SCROLL_FIX_TOP,1))
	WorldQuestList.C:SetHeight(max(16*(taskIconIndex-1),1))

	local lowestLine = #WorldQuestList.Cheader.lines
	for i=1,#WorldQuestList.Cheader.lines do
		local bottomPos = WorldQuestList.Cheader.lines[i]:GetBottom() or 0
		if bottomPos and bottomPos < 40 then
			lowestLine = i - 1
			break
		end
	end

	if VWQL.MaxLinesShow then
		lowestLine = min(VWQL.MaxLinesShow,lowestLine)
	end

	if lowestLine >= taskIconIndex then
		WorldQuestList.Cheader:SetVerticalScroll(0)
	else
		WorldQuestList:SetHeight((lowestLine+1)*16)
		WorldQuestList.Cheader:SetVerticalScroll( max(min(WorldQuestList.C:GetHeight() - WorldQuestList.Cheader:GetHeight(),WorldQuestList.Cheader:GetVerticalScroll()),0) )
	end
	UpdateScrollButtonsState()
	C_Timer.After(0,UpdateScrollButtonsState)

	WorldQuestList.header:Update(true)
	WorldQuestList.footer:Update(true)
	ViewAllButton:Hide()

	for i = taskIconIndex, NUM_WORLDMAP_TASK_POIS do
		WorldQuestList.l[i]:Hide()
	end

	if taskIconIndex == 1 then
		WorldQuestList.b:SetAlpha(0)
		WorldQuestList.backdrop:Hide()
	else
		WorldQuestList.b:SetAlpha(WorldQuestList.b.A or 1)
		WorldQuestList.backdrop:Show()
	end

	WorldQuestList.oppositeContinentButton:Update()
	WorldQuestList.modeSwitcherCheck:Update(WorldQuestList.TreasureData[currMapID])

	HookWQbuttons()

	if VWQL.Anchor == 2 then	--Inside
		UpdateScale()
	end
end


do
	local lastCheck = 0
	local azeriteItemLocation
	function WorldQuestList:FormatAzeriteNumber(azerite,ignorePercentForm)
		if (VWQL.AzeriteFormat == 10 or VWQL.AzeriteFormat == 20) and not ignorePercentForm then
			if C_AzeriteItem.HasActiveAzeriteItem() then
				local currTime = GetTime()
				if currTime - lastCheck > 5 then
					azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
					lastCheck = currTime
				end

				if azeriteItemLocation then
					local isEx, isAzeriteItem = pcall(C_AzeriteItem.IsAzeriteItem,azeriteItemLocation)	--C_AzeriteItem.IsAzeriteItem spams errors if you put neck into the bank
					if isEx and isAzeriteItem then
						local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
						--local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
						--local xpToNextLevel = totalLevelXP - xp

						if totalLevelXP and totalLevelXP ~= 0 then
							if VWQL.AzeriteFormat == 20 then
								return format("%d (%.1f%%)", azerite,azerite / totalLevelXP * 100)
							else
								return format("%.1f%%", azerite / totalLevelXP * 100)
							end
						end
					end
				end
			end

			return WorldQuestList:FormatAzeriteNumber(azerite,true)
		else
			return tostring(azerite)
		end
	end
	function WorldQuestList:IsAzeriteItemAtMaxLevel()
		return C_AzeriteItem.IsAzeriteItemAtMaxLevel()
	end
end

function WorldQuestList:FormatTime(timeLeftMinutes)
	if not timeLeftMinutes then
		return ""
	end
	local color
	local timeString

	local time_red,time_yellow = 30, 180
	if WorldQuestList:IsDragonflightZone() then
		time_red, time_yellow = 120, 1440
	end

	if ( timeLeftMinutes <= WORLD_QUESTS_TIME_CRITICAL_MINUTES ) then
		color = "|cffff3333"
		timeString = SecondsToTime(timeLeftMinutes * 60)
	else
		if timeLeftMinutes <= time_red then
			color = "|cffff3333"
		elseif timeLeftMinutes <= time_yellow then
			color = "|cffffff00"
		end

		if timeLeftMinutes >= 14400 then	--A lot, 10+ days
			timeString = format("%dd",floor(timeLeftMinutes / 1440))
		elseif timeLeftMinutes >= 1440 then
			timeString = format("%d.%02d:%02d",floor(timeLeftMinutes / 1440),floor(timeLeftMinutes / 60) % 24, timeLeftMinutes % 60)
		else
			timeString = (timeLeftMinutes >= 60 and (floor(timeLeftMinutes / 60) % 24) or "0")..":"..format("%02d",timeLeftMinutes % 60)
		end
	end
	return (color or "")..(timeString or "")
end

function WorldQuestList:FormatTimeSeconds(secondsRemaining)
	if not secondsRemaining then
		return ""
	end
	local color
	local timeString

	local time_red,time_yellow = 30, 180
	if WorldQuestList:IsDragonflightZone() then
		time_red, time_yellow = 120, 1440
	end

	if secondsRemaining <= 300 then
		color = "|cffff3333"
		timeString = SecondsToTime(secondsRemaining):gsub(" ",""):lower()
	elseif ( secondsRemaining <= 900 ) then
		color = "|cffff3333"
		local m = secondsRemaining / 60
		timeString = SecondsToTime((m - m % 1)*60)
	else
		local timeLeftMinutes = secondsRemaining / 60
		if timeLeftMinutes <= time_red then
			color = "|cffff3333"
		elseif timeLeftMinutes <= time_yellow then
			color = "|cffffff00"
		end

		if timeLeftMinutes >= 14400 then	--A lot, 10+ days
			timeString = format("%dd",floor(timeLeftMinutes / 1440))
		elseif timeLeftMinutes >= 1440 then
			timeString = format("%d.%02d:%02d",floor(timeLeftMinutes / 1440),floor(timeLeftMinutes / 60) % 24, timeLeftMinutes % 60)
		else
			timeString = (timeLeftMinutes >= 60 and (floor(timeLeftMinutes / 60) % 24) or "0")..":"..format("%02d",timeLeftMinutes % 60)
		end
	end
	return (color or "")..(timeString or "")
end

function WorldQuestList:CalculateSqDistanceTo(x2, y2)
	local mapPos = C_Map.GetPlayerMapPosition(GetCurrentMapID(), "player")
	if mapPos and x2 then
	        local x,y = mapPos:GetXY()
	        if x and y then
			local dX = (x - x2)
			local dY = (y - y2)
			return dX * dX + dY * dY
		end
	end
	return math.huge
end

function WorldQuestList:GetRadiantWQPosition(info,result,extraradius)
	local count,self_pos = 0
	for i=1,#result do
		if result[i].info and result[i].info.x == info.x and result[i].info.y == info.y and result[i].info.questID then
			count = count + 1
		end
		if info == result[i].info then
			self_pos = count
		end
	end
	if count <= 1 or not self_pos then
		return info
	end
	local newInfo = {}
	for q,w in pairs(info) do newInfo[q]=w end
	local radius = 0.05 + (extraradius or 0) + count * 0.003
	newInfo.x = newInfo.x + radius * math.cos(math.pi * 2 / count * (self_pos - 1) - math.pi / 2) / 1.5
	newInfo.y = newInfo.y + radius * math.sin(math.pi * 2 / count * (self_pos - 1) - math.pi / 2)
	return newInfo
end

function WorldQuestList:GetLinearWQPosition(info,result,direction)
	direction = direction or 1
	local count,self_pos = 0
	for i=1,#result do
		if result[i].info and result[i].info.x == info.x and result[i].info.y == info.y and result[i].info.questID then
			count = count + 1
		end
		if info == result[i].info then
			self_pos = count
		end
	end
	if count <= 1 or not self_pos then
		return info
	end
	local newInfo = {}
	for q,w in pairs(info) do newInfo[q]=w end
	newInfo.x = newInfo.x + self_pos * 0.05 * (direction == 1 and 0 or direction == 2 and -1 or direction == 3 and 0 or 1)
	newInfo.y = newInfo.y + self_pos * 0.05 * (direction == 1 and -1 or direction == 2 and 0 or direction == 3 and 1 or 0)
	return newInfo
end

local TableQuestsViewed = {}
local TableQuestsViewed_Time = {}

local WANTED_TEXT,DANGER_TEXT,DANGER_TEXT_2,DANGER_TEXT_3

function WorldQuestList:ForceModeCheck()
	local level = UnitLevel'player' 
	local xp = UnitXP'player'

	if level == 60 then
		VWQL[charKey].RegularQuestMode = nil
	--elseif level < 60 then
	--	VWQL[charKey].RegularQuestMode = true
	elseif level == 50 and xp <= 50000 then
		VWQL[charKey].RegularQuestMode = nil
	--elseif level == 50 and xp > 50000 then
	--	VWQL[charKey].RegularQuestMode = true
	elseif level < 50 then
		VWQL[charKey].RegularQuestMode = true
	else
		VWQL[charKey].RegularQuestMode = nil
	end
	VWQL[charKey].TreasureMode = nil

	WorldQuestList.modeSwitcherCheck:AutoSetValue()
end

WorldQuestList.ColorYellow = {r=1,g=1,b=.6}
WorldQuestList.ColorBlueLight = {r=.5,g=.65,b=1}

local WAR_MODE_BONUS = 1.1

local BOUNTY_QUEST_TO_FACTION = {
	[50562] = 2164,
	[50604] = 2163,
	[50606] = 2157,
	[50602] = 2156,
	[50598] = 2103,
	[50603] = 2158,
	[50605] = 2159,
	[50599] = 2160,
	[50601] = 2162,
	[50600] = 2161,

	[42422] = 1894,
	[42234] = 1948,
	[42421] = 1859,
	[43179] = 1090,
	[42170] = 1883,
	[46777] = 2045,
	[42233] = 1828,
	[42420] = 1900,
	[48639] = 2165,
	[48641] = 2045,
	[48642] = 2170,
}

local DF_MAP_LIST = {2022,2023,2024,2025}
local function InList(k,t,p)
	for _,v in pairs(t) do 
		if (p and v[p]==k) or (not p and v==k) then 
			return true 
		end 
	end
end

local GENERAL_MAPS = {	--1: continent A, 2: azeroth, 3: argus, 4: continent B
	[947] = 2,
	[875] = 1,
	[876] = 1,
	[619] = 4,
	[905] = 3,
	[994] = 3,
	[572] = 4,
	[113] = 4,
	[424] = 4,
	[12] = 4,
	[13] = 4,
	[101] = 4,
	[1550] = 1,
	[1978] = 1,
	[2274] = 1,
}
WorldQuestList.GeneralMaps = GENERAL_MAPS

local ArgusZonesList = {830,885,882}

WorldQuestList.RewardSpecialSortTypes = {
	[30.1716] = 130,	--Service Medal
	[30.1717] = 130,	--Service Medal
	[30.1342] = 130,	--Legionfall War Supplies
	[30.1226] = 130.1,	--Nethershard
}

local RewardListStrings = {}
local RewardListType = {}
local RewardListSort = {}
local RewardListColor = {}
local RewardListPos = {}
local RewardListSorted = {}
local function RewardListSortFunc(a,b)
	return (WorldQuestList.RewardSpecialSortTypes[ RewardListType[a] ] or RewardListType[a]) < (WorldQuestList.RewardSpecialSortTypes[ RewardListType[b] ] or RewardListType[b])
end
WorldQuestList.RewardListTables = {
	RewardListStrings,
	RewardListType,
	RewardListSort,
	RewardListColor,
	RewardListPos,
	RewardListSorted,
}

local function FindInReward(rewardType)
	for i=1,#RewardListStrings do
		if RewardListType[i] == rewardTypeToFind then
			return true
		end
	end
end

WorldQuestList.NULLTable = {}

WorldQuestList.QuestIDtoMapID = {}
WorldQuestList.CacheSLAnimaItems = {}

function WorldQuestList_Update(preMapID,forceUpdate)
	if not WorldQuestList:IsVisible() and not VWQL[charKey].HideMap and not forceUpdate then
	--if not WorldQuestList:IsVisible() then
		return
	end

	local mapAreaID = GetCurrentMapID()
	if type(preMapID)=='number' then
		mapAreaID = preMapID
	end
	if WorldQuestList.IsSoloRun then
		mapAreaID = WorldQuestList.SoloMapID or mapAreaID
	end

	if VWQL[charKey].TreasureMode and WorldQuestList.TreasureData[mapAreaID] then
		WorldQuestList.sortDropDown:Hide()
		WorldQuestList.filterDropDown:Hide()
		WorldQuestList.optionsDropDown:Hide()
		WorldQuestList_Treasure_Update()
		return
	elseif VWQL[charKey].RegularQuestMode then
		WorldQuestList.IconsGeneralLastMap = -1
		WorldQuestList.sortDropDown:Hide()
		WorldQuestList.filterDropDown:Hide()
		WorldQuestList.optionsDropDown:Hide()
		WorldQuestList_Leveling_Update()
		return
	else
		WorldQuestList.sortDropDown:Show()
		WorldQuestList.filterDropDown:Show()
		WorldQuestList.optionsDropDown:Show()
	end

	local currTime = GetTime()

	local O = {
		isGeneralMap = false,
		isGearLessRelevant = false,
		nextResearch = nil,
	}

	local taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(mapAreaID)
	taskInfo = taskInfo or {}

	if GENERAL_MAPS[mapAreaID] then
		O.isGeneralMap = true
		O.generalMapType = GENERAL_MAPS[mapAreaID]

		if VWQL.OppositeContinent and (mapAreaID == 875 or mapAreaID == 876) then
			local oppositeMapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(mapAreaID == 875 and 876 or 875)
			for _,info in pairs(oppositeMapQuests or WorldQuestList.NULLTable) do
				taskInfo[#taskInfo+1] = info
				info.dX,info.dY,info.dMap = info.x,info.y,mapAreaID == 875 and 876 or 875
				info.x,info.y = nil
			end
		end
		if not VWQL.OppositeContinentArgus and (mapAreaID == 619 or mapAreaID == 947) then
			for _,mapID in pairs(ArgusZonesList) do
				local oppositeMapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(mapID)
				for _,info in pairs(oppositeMapQuests or WorldQuestList.NULLTable) do
					taskInfo[#taskInfo+1] = info
					info.dX,info.dY,info.dMap = info.x,info.y,mapID
					info.x,info.y = mapAreaID == 619 and 0.87,mapAreaID == 619 and 0.165
				end
			end
		end
		if not VWQL.OppositeContinentNazjatar and (mapAreaID == 875 or mapAreaID == 876) then
			local oppositeMapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(1355)
			for _,info in pairs(oppositeMapQuests or WorldQuestList.NULLTable) do
				taskInfo[#taskInfo+1] = info
				info.dX,info.dY,info.dMap = info.x,info.y,1355
				info.x,info.y = 0.87, 0.12
			end
		end
		if (mapAreaID == 947) then
			local oppositeMapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(1355)
			for _,info in pairs(oppositeMapQuests or WorldQuestList.NULLTable) do
				taskInfo[#taskInfo+1] = info
				info.dX,info.dY,info.dMap = info.x,info.y,1355
				info.x,info.y = nil
			end
		end
		if (mapAreaID == 1550) then
			local oppositeMapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(1970)
			for _,info in pairs(oppositeMapQuests or WorldQuestList.NULLTable) do
				taskInfo[#taskInfo+1] = info
				info.dX,info.dY,info.dMap = info.x,info.y,1970
				info.x,info.y = 0.86, 0.80
			end
		end
		if (mapAreaID == 1978) then
			local oppositeMapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(2133)
			for _,info in pairs(oppositeMapQuests or WorldQuestList.NULLTable) do
				taskInfo[#taskInfo+1] = info
				info.dX,info.dY,info.dMap = info.x,info.y,2133
				if not VWQL.DFCaveMap then	--reverse opt
					info.x,info.y = 0.87, 0.81
				else
					info.x,info.y = nil
				end
			end
			local oppositeMapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(2200)
			for _,info in pairs(oppositeMapQuests or WorldQuestList.NULLTable) do
				taskInfo[#taskInfo+1] = info
				info.dX,info.dY,info.dMap = info.x,info.y,2200
				if not VWQL.EmeraldDreamMap then	--reverse opt
					info.x,info.y = 0.31, 0.56
				else
					info.x,info.y = nil
				end
			end
		end
		if (mapAreaID == 2274) then
			local oppositeMapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(2346)
			for _,info in pairs(oppositeMapQuests or WorldQuestList.NULLTable) do
				taskInfo[#taskInfo+1] = info
				info.dX,info.dY,info.dMap = info.x,info.y,2346
				if not VWQL.DFCaveMap then	--reverse opt
					info.x,info.y = 0.82, 0.72
				else
					info.x,info.y = nil
				end
			end
		end
	end

	if mapAreaID == 905 then	--Argus
		WorldQuestList:RegisterArgusMap()

		local moddedMap
		if not VWQL.ArgusMap then
			moddedMap = C_TaskQuest.GetQuestsForPlayerByMapID(994)
		end
		for _,mapID in pairs(ArgusZonesList) do
			local mapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(mapID) or WorldQuestList.NULLTable
			for _,info in pairs(mapQuests) do
				taskInfo[#taskInfo+1] = info
				info.dX,info.dY,info.dMap = info.x,info.y,mapID
				if moddedMap then
					info.x,info.y = nil
					for i=1,#moddedMap do
						if info.questID == moddedMap[i].questID then
							info.x,info.y = moddedMap[i].x,moddedMap[i].y
							break
						end
					end
				elseif mapID == 830 then
					info.x,info.y = 0.60,0.65
				elseif mapID == 885 then
					info.x,info.y = 0.30,0.48
				elseif mapID == 882 then
					info.x,info.y = 0.63,0.28
				end
			end
		end
	end

	if mapAreaID == 1163 then
		--[[
		taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(875)
		for _,info in pairs(taskInfo) do
			info.dX,info.dY,info.dMap = info.x,info.y,875
			info.x,info.y = nil
		end
		]]
		WorldMapFrame:SetMapID(875)
		return
	end

	if mapAreaID == 905 or mapAreaID == 830 or mapAreaID == 885 or mapAreaID == 882 or (not VWQL.OppositeContinentArgus and (mapAreaID == 619 or (mapAreaID == 947 and not VWQL.HideLegion))) then
		for _,mapID in pairs((mapAreaID == 905 or mapAreaID == 619 or mapAreaID == 947) and ArgusZonesList or {mapAreaID}) do
			local pois = C_AreaPoiInfo.GetAreaPOIForMap(mapID)
			for i=1,#pois do
				local poiData = C_AreaPoiInfo.GetAreaPOIInfo(mapID,pois[i])
				if poiData and type(poiData.atlasName) == 'string' and (poiData.atlasName:find("^poi%-rift%d+$") or poiData.atlasName=="poi-nzothpylon") then
					taskInfo.poi = taskInfo.poi or {}
					if mapAreaID == 905 and VWQL.ArgusMap then
						poiData.position.dX, poiData.position.dY, poiData.position.dMap = poiData.position.x,poiData.position.y,mapID
						if mapID == 830 then
							poiData.position.x,poiData.position.y = 0.60,0.65
						elseif mapID == 885 then
							poiData.position.x,poiData.position.y = 0.30,0.48
						elseif mapID == 882 then
							poiData.position.x,poiData.position.y = 0.63,0.28
						end
					elseif mapAreaID == 905 and not VWQL.ArgusMap then
						poiData.position.dX, poiData.position.dY, poiData.position.dMap = poiData.position.x,poiData.position.y,mapID
						local poiModdedData = C_AreaPoiInfo.GetAreaPOIInfo(994,pois[i])
						if poiModdedData then
							poiData.position.x,poiData.position.y = poiModdedData.position.x,poiModdedData.position.y
						else
							poiData.position.x,poiData.position.y = nil
						end
					elseif mapAreaID == 619 or mapAreaID == 947 then
						poiData.position.dX, poiData.position.dY = poiData.position.x,poiData.position.y
						poiData.position.x,poiData.position.y = mapAreaID == 619 and 0.87,mapAreaID == 619 and 0.165
					end
					tinsert(taskInfo.poi, {poiData.name, poiData.description, poiData.position.x, poiData.position.y, pois[i], poiData.atlasName, 1, mapID, poiData.position.dX, poiData.position.dY})
				end
			end
		end
	end
	do
		--local mapID = mapAreaID == 947 and 424 or mapAreaID
		for _,smapAreaID in pairs(mapAreaID == 2274 and {2274,2248,2215,2214,2255,2374} or {mapAreaID}) do
			local pois = C_AreaPoiInfo.GetAreaPOIForMap(smapAreaID)
			for i=1,#pois do
				local poiData = C_AreaPoiInfo.GetAreaPOIInfo(smapAreaID,pois[i])
				if poiData and type(poiData.atlasName) == 'string' and poiData.atlasName == "poi-nzothpylon" then
					taskInfo.poi = taskInfo.poi or {}
	
					poiData.position.dX, poiData.position.dY, poiData.position.dMap = poiData.position.x,poiData.position.y,smapAreaID
	
					tinsert(taskInfo.poi, {poiData.name, poiData.description, poiData.position.x, poiData.position.y, pois[i], poiData.atlasName, 2, smapAreaID, poiData.position.dX, poiData.position.dY})
				elseif poiData and type(poiData.atlasName) == 'string' and poiData.atlasName:find("worldquest-Capstone-questmarker",1,true) then
					taskInfo.poi = taskInfo.poi or {}
	
					poiData.position.dX, poiData.position.dY, poiData.position.dMap = poiData.position.x,poiData.position.y,smapAreaID
					if mapAreaID == 2274 then
						poiData.position.x, poiData.position.y = WorldQuestList:GetMapCoordAdj2(poiData.position.x, poiData.position.y,2274,smapAreaID)
						if smapAreaID == 2374 then
							poiData.position.x, poiData.position.y = 0.82, 0.72
						end
					end
	
					tinsert(taskInfo.poi, {poiData.name, poiData.description, poiData.position.x, poiData.position.y, pois[i], poiData.atlasName, 4, smapAreaID, poiData.position.dX, poiData.position.dY, widget = poiData.tooltipWidgetSet})
				end
			end
		end
	end
	if mapAreaID == 1978 or InList(mapAreaID, DF_MAP_LIST) then
		for _,mapID in pairs(mapAreaID == 1978 and DF_MAP_LIST or {mapAreaID}) do
			local pois = C_AreaPoiInfo.GetAreaPOIForMap(mapID)
			for i=1,#pois do
				local poiData = C_AreaPoiInfo.GetAreaPOIInfo(mapID,pois[i])
				if poiData and type(poiData.atlasName) == 'string' and (poiData.atlasName:find("^ElementalStorm") or poiData.atlasName=="racing") and (not taskInfo.poi or not InList(pois[i],taskInfo.poi,5)) then
					taskInfo.poi = taskInfo.poi or {}
					poiData.position.dX, poiData.position.dY, poiData.position.dMap = poiData.position.x,poiData.position.y,mapID
	
					local xMin,xMax,yMin,yMax = C_Map.GetMapRectOnMap(mapID,mapAreaID)
					if xMin ~= xMax and yMin ~= yMax then
						poiData.position.x, poiData.position.y = xMin + poiData.position.x * (xMax - xMin),yMin + poiData.position.y * (yMax - yMin)
					else
						poiData.position.x, poiData.position.y = nil
					end
	
					tinsert(taskInfo.poi, {poiData.name, poiData.description, poiData.position.x, poiData.position.y, pois[i], poiData.atlasName, 3, mapID, poiData.position.dX, poiData.position.dY})
				end
			end
		end
	end


	if WorldQuestList:FilterCurrentZone(mapAreaID) and taskInfo then
		for i=#taskInfo,1,-1 do
			--if taskInfo[i].mapID ~= mapAreaID and not WorldQuestList:IsMapParent(taskInfo[i].mapID,mapAreaID) then
			if taskInfo[i].mapID ~= mapAreaID and not (mapAreaID == 862 and taskInfo[i].mapID == 1165) then
				tremove(taskInfo,i)
			end
		end
	end

	if mapAreaID == 947 and VWQL.HideLegion and taskInfo then
		for i=#taskInfo,1,-1 do
			if taskInfo[i].mapID and WorldQuestList:IsLegionZone(taskInfo[i].mapID) then
				tremove(taskInfo,i)
			end
		end
	end

	if mapAreaID ~= 946 then
		local threatMaps = C_QuestLog.GetActiveThreatMaps()
		if threatMaps then
			local threatQuests = C_TaskQuest.GetThreatQuests()
			for i=1,#threatMaps do
				if WorldQuestList:IsMapParent(threatMaps[i],mapAreaID) then
					for j=1,#threatQuests do
						if C_TaskQuest.IsActive(threatQuests[j]) and C_TaskQuest.GetQuestZoneID(threatQuests[j]) == threatMaps[i] then
							taskInfo = taskInfo or {}
							local x,y = C_TaskQuest.GetQuestLocation(threatQuests[j],mapAreaID)
							tinsert(taskInfo,{
								mapID = threatMaps[i],
								questID = threatQuests[j],
								x = x,
								y = y,
								forced = true,
								isNzothThreat = true,
							})
						end
					end
				end
			end
		end
		--[[
			/run local q=C_TaskQuest.GetThreatQuests()for i=1,#q do print(q[i],C_TaskQuest.GetQuestZoneID(q[i]),C_TaskQuest.GetQuestInfoByQuestID(q[i]),C_TaskQuest.IsActive(q[i])) end
		]]
	end

	WorldQuestList.currentMapID = mapAreaID

	--if time() > 1534550400 and time() < 1543968000 then	--beetween 18.08.18 (second week, same AK as first) and 05.12.18 (AK level 17, max for now,30.07.2018)
	if time() > 1547942400 and time() < 1556280000 then	--beetween 23.01.19 and 24.03.19 (max for now,04.04.2019)
		O.nextResearch = WorldQuestList:GetNextResetTime(WorldQuestList:GetCurrentRegion())
	end

	local bounties = C_QuestLog.GetBountiesForMapID(WorldQuestList:IsLegionZone(mapAreaID) and 680 or 875)
	local bountiesInProgress = {}
	for _,bountyData in pairs(bounties or {}) do
		local questID = bountyData.questID
		if questID and not IsQuestComplete(questID) then
			bountiesInProgress[ questID ] = bountyData.icon or 0
		end
	end

	local mapsToHighlightCallings = {}
	do
		local p = 1
		local questID = WorldQuestList:GetCallingQuests()
		while questID do
			local mapID, worldQuests, worldQuestsElite, dungeons, treasures = C_QuestLog.GetQuestAdditionalHighlights(questID)
			--if mapID and mapID ~= 0 and not (treasures and not (worldQuests or worldQuestsElite or dungeons)) then
			if mapID and mapID ~= 0 then
				if mapsToHighlightCallings[mapID] then
					local pos = #mapsToHighlightCallings[mapID]
					mapsToHighlightCallings[mapID][pos+1] = questID
					mapsToHighlightCallings[mapID][pos+2] = worldQuests
					mapsToHighlightCallings[mapID][pos+3] = worldQuestsElite
					mapsToHighlightCallings[mapID][pos+4] = dungeons
				else
					mapsToHighlightCallings[mapID] = {questID, worldQuests, worldQuestsElite, dungeons}
				end
			end
			p = p + 1
			questID = select(p,WorldQuestList:GetCallingQuests())
		end
	end

	local numTaskPOIs = 0
	if(taskInfo ~= nil) then
		numTaskPOIs = #taskInfo
	end

	local result = {}
	local totalAP,totalOR,totalG,totalAzerite,totalORbfa,totalWE = 0,0,0,0,0,0
	local totalAnima = 0

	if not WANTED_TEXT then
		local qName = C_TaskQuest.GetQuestInfoByQuestID(43612)
		if qName and qName:find(":") then
			WANTED_TEXT = qName:match("^([^:]+):")
			if WANTED_TEXT then
				WANTED_TEXT = WANTED_TEXT:lower()
			end
		end
	end
	if not DANGER_TEXT then
		local qName = C_TaskQuest.GetQuestInfoByQuestID(43798)
		if qName and qName:find(":") then
			DANGER_TEXT = qName:match("^([^:]+):")
			if DANGER_TEXT then
				DANGER_TEXT = DANGER_TEXT:lower()
			end
		end
	end
	if not DANGER_TEXT_2 then
		local qName = C_TaskQuest.GetQuestInfoByQuestID(41697)
		if qName and qName:find(":") then
			DANGER_TEXT_2 = qName:match("^([^:]+):")
			if DANGER_TEXT_2 then
				DANGER_TEXT_2 = DANGER_TEXT_2:lower()
			end
		end
	end
	if not DANGER_TEXT_3 then
		local qName = C_TaskQuest.GetQuestInfoByQuestID(44114)
		if qName and qName:find(":") then
			DANGER_TEXT_3 = qName:match("^([^:]+):")
			if DANGER_TEXT_3 then
				DANGER_TEXT_3 = DANGER_TEXT_3:lower()
			end
		end
	end

	WAR_MODE_BONUS = C_PvP.GetWarModeRewardBonus() / 100 + 1

	local noRewardCount = 0

	local taskIconIndex = 1
	local totalQuestsNumber = 0
	if ( numTaskPOIs > 0 ) then
		for i_info, info  in pairs(taskInfo) do if type(i_info)=='number' then
			local questID = info.questID
			if HaveQuestData(questID) and (QuestUtils_IsQuestWorldQuest(questID) or info.forced) and (VWQL[charKey].ignoreIgnore or not VWQL.Ignore[questID]) then
				local isNewQuest = not VWQL[charKey].Quests[ questID ] or (TableQuestsViewed_Time[ questID ] and TableQuestsViewed_Time[ questID ] > currTime)

				for i=1,#RewardListStrings do
					RewardListStrings[i] = nil
					RewardListType[i] = nil
					RewardListSort[i] = nil
					RewardListSorted[i] = nil
					RewardListPos[i] = nil
					RewardListColor[i] = nil
				end
				local rewardItem
				local rewardColor
				local faction,factionSort = "",""
				local factionInProgress
				local timeleft = ""
				local name = ""
				local rewardType = 0
				local rewardSort = 0
				local rewardItemLink
				local nameicon = nil
				--local artifactKnowlege
				local isEliteQuest
				local timeToComplete
				local isInvasion
				local WarSupplies
				local ShardsNothing,ServiceMedal,ConqPoints
				local bountyTooltip
				local isUnlimited
				local questColor	--nil - white, 1 - blue, 2 - epic, 3 - invasion
				local reputationList
				local highlightFaction
				local debugLine = ""
				local showAchievement
				local reputationAcc, reputationNoRep

				local professionFix
				local IsPvPQuest
				local IsWantedQuest

				local isValidLine = 1

				local title, factionID = C_TaskQuest.GetQuestInfoByQuestID(questID)
				name = title

				local _,_,worldQuestType,rarity, isElite, tradeskillLineIndex, allowDisplayPastCritical = GetQuestTagInfo(questID)

				if DEBUG or WQL_DEBUG then
					debugLine = debugLine .. "QuestID: "..questID..";worldQuestType: "..(worldQuestType or "")..";rarity: "..(rarity or "")..
						";isElite: "..tostring(isElite)..";tradeskillLineIndex: "..(tradeskillLineIndex or "")..";allowDisplayPastCritical: "..tostring(allowDisplayPastCritical)..
						"|n"
				end

				local tradeskillLineID = nil
				if tradeskillLineIndex then
					local spellBookIndex = C_SpellBook.GetSkillLineIndexByID(tradeskillLineIndex)
					if spellBookIndex then
						tradeskillLineID = select(7, GetProfessionInfo(spellBookIndex))
					end
				else
					tradeskillLineID = 0
				end

				if isElite then
					isEliteQuest = true
					nameicon = -1
				end

				if worldQuestType == LE.LE_QUEST_TAG_TYPE_FACTION_ASSAULT then
					isInvasion = 2
					questColor = 4
				elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_INVASION then
					isInvasion = 1
					questColor = 3
				elseif (worldQuestType == LE.LE_QUEST_TAG_TYPE_THREAT or info.isNzothThreat) then
					isInvasion = 3
					questColor = 2
				end

				if worldQuestType == LE.LE_QUEST_TAG_TYPE_DUNGEON then
					questColor = 1
					nameicon = -6
					if ActiveFilterType.dung then 
						isValidLine = 0 
					end
				elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_RAID then
					nameicon = -7
					if ActiveFilterType.dung then 
						isValidLine = 0 
					end
					questColor = 2
				elseif rarity == LE.LE_WORLD_QUEST_QUALITY_RARE then
					questColor = 1
				elseif rarity == LE.LE_WORLD_QUEST_QUALITY_EPIC then
					nameicon = -2
					questColor = 2
				elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PVP then
					nameicon = -3
					if ActiveFilterType.pvp then 
						isValidLine = 0 
					end
				elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE then
					nameicon = -4
					if ActiveFilterType.pet then 
						isValidLine = 0 
					end
				elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PROFESSION then
					nameicon = -5
					if ActiveFilterType.prof or not tradeskillLineID then 
						isValidLine = 0 
						if not tradeskillLineID then
							professionFix = true
						end
					end
				elseif worldQuestType == Enum.QuestTagType.DragonRiderRacing then
					nameicon = -11
					if ActiveFilterType.dragonriding then 
						isValidLine = 0 
					end
				end

				if (WANTED_TEXT and name:lower():find("^"..WANTED_TEXT)) or (DANGER_TEXT and name:lower():find("^"..DANGER_TEXT)) or (DANGER_TEXT_2 and name:lower():find("^"..DANGER_TEXT_2)) or (DANGER_TEXT_3 and name:lower():find("^"..DANGER_TEXT_3)) then
					IsWantedQuest = true
				end
				if not IsWantedQuest and info.numObjectives == 1 and (rarity == LE.LE_WORLD_QUEST_QUALITY_RARE or rarity == LE.LE_WORLD_QUEST_QUALITY_EPIC) then
					local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, 1, false)
					if objectiveType == "monster" and numRequired == 1 then
						IsWantedQuest = true
					end
				end

				if ( factionID ) then
					local factionName = GetFactionInfoByID(factionID)
					if ( factionName ) then
						faction = factionName
						factionSort = faction
					end

					if VWQL[charKey]["faction"..factionID.."Highlight"] then
						highlightFaction = true
					end

					if DEBUG or WQL_DEBUG then
						debugLine = debugLine .. "Faction: ID:"..factionID..";Name:"..(factionName or "").."|n"
					end
				end

				for bountyQuestID,bountyIcon in pairs(bountiesInProgress) do
					if IsQuestCriteriaForBounty(questID, bountyQuestID) then
						faction = "|T" .. bountyIcon .. ":0|t " .. (faction or "")

						factionInProgress = true

						if bountyIcon and bountyIcon ~= 0 then
							bountyTooltip = bountyTooltip or ""
							bountyTooltip = bountyTooltip .. (bountyTooltip ~= "" and " " or "") .. "|T" .. bountyIcon .. ":32|t"
						end
					end
				end

				if info.mapID and mapsToHighlightCallings[info.mapID] then
					local callingHighlight = mapsToHighlightCallings[info.mapID]
					
					for ch=1,#callingHighlight,4 do
						if callingHighlight[ch+1] or (callingHighlight[ch+2] and isElite) then
							factionInProgress = true
		
							local n = WorldQuestList:GetQuestName(callingHighlight[ch+0])
							if n then
								bountyTooltip = bountyTooltip or ""
								bountyTooltip = bountyTooltip .. (bountyTooltip ~= "" and "|n" or "") .. n
							end
						end
					end
				end
				if info.mapID then
					WorldQuestList.QuestIDtoMapID[questID] = info.mapID
				end

				for bountyQuestID,bountyFactionID in pairs(BOUNTY_QUEST_TO_FACTION) do
					if IsQuestCriteriaForBounty(questID, bountyQuestID) then
						reputationList = reputationList and (reputationList..","..bountyFactionID) or bountyFactionID

						if VWQL[charKey]["faction"..bountyFactionID.."Highlight"] then
							highlightFaction = true
						end
					end
				end

				if C_QuestLog.QuestContainsFirstTimeRepBonusForPlayer(questID) and not VWQL.DisableReputationAccAlert then
					reputationAcc = true
				end
				if factionID and not C_QuestLog.DoesQuestAwardReputationWithFaction(questID, factionID) then
					reputationNoRep = true
				end
				

				local isAchievement, questAchievementId, isAchievementCompleted, questAchievementId2, isAchievementCompleted2 = WorldQuestList:IsQuestForAchievement(questID)
				if isAchievement and not isAchievementCompleted and not VWQL.ShowQuestAchievements then
					showAchievement = questAchievementId
				elseif isAchievement and not isAchievementCompleted2 and not VWQL.ShowQuestAchievements then
					showAchievement = questAchievementId2
				end

				local secondsRemaining = C_TaskQuest.GetQuestTimeLeftSeconds(questID)
				local timeLeftMinutes
				if secondsRemaining then
					timeLeftMinutes = secondsRemaining / 60
					timeleft = WorldQuestList:FormatTimeSeconds(secondsRemaining)

					if timeLeftMinutes == 0 and not C_TaskQuest.IsActive(questID) then
						isValidLine = 0
					end
					if not allowDisplayPastCritical then
						timeLeftMinutes = timeLeftMinutes + 1440 * 15
						isUnlimited = true
					end
				end

				if GetQuestLogRewardXP(questID) > 0 or GetNumQuestLogRewardCurrencies(questID) > 0 or GetNumQuestLogRewards(questID) > 0 or GetQuestLogRewardMoney(questID) > 0 or GetQuestLogRewardHonor(questID) > 0 then
					local hasRewardFiltered = false
					-- xp
					local xp = GetQuestLogRewardXP(questID)
					if ( xp > 0 ) then
						RewardListStrings[#RewardListStrings+1] = BONUS_OBJECTIVE_EXPERIENCE_FORMAT:format(xp)
						RewardListSort[#RewardListStrings] = xp
						RewardListType[#RewardListStrings] = 50
					end

					-- currency
					local numQuestCurrencies = GetNumQuestLogRewardCurrencies(questID)
					for i = 1, numQuestCurrencies do
						local name, texture, numItems, currencyID = GetQuestLogRewardCurrencyInfo(i, questID)
						if DEBUG or WQL_DEBUG then
							debugLine = debugLine .. "Currency: "..name..";|T"..texture..":0|t;"..numItems..";ID:"..currencyID.."|n"
						end
						if C_PvP.IsWarModeDesired() and C_QuestLog.QuestCanHaveWarModeBonus(questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) then
							numItems = floor(numItems * WAR_MODE_BONUS + .5)
						end
						if numItems and numItems > 0 then
							local text = BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT:format(texture, numItems, name)
							RewardListStrings[#RewardListStrings+1] = text
							RewardListSort[#RewardListStrings] = numItems or 0
							RewardListType[#RewardListStrings] = (VWQL.SortPrio.currother or defSortPrio.currother) + currencyID / 10000
	
							if currencyID == 1508 then	--Veiled Argunite
								hasRewardFiltered = true
								if VWQL[charKey].arguniteFilter then
									isValidLine = 0 
								end
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.curr1508 or defSortPrio.curr1508)
							elseif currencyID == 1553 then	-- azerite
								hasRewardFiltered = true
								if ActiveFilterType.azerite then 
									isValidLine = 0  
								end
								if isValidLine ~= 0 then
									totalAzerite = totalAzerite + (numItems or 0)
								end
	
								local entry = C_CurrencyInfo.GetCurrencyContainerInfo(currencyID, numItems)
								if entry then 
									texture = entry.icon
								end
								if WorldQuestList:IsAzeriteItemAtMaxLevel() then
									RewardListColor[#RewardListStrings] = LE.BAG_ITEM_QUALITY_COLORS[LE.LE_ITEM_QUALITY_COMMON]
									RewardListType[#RewardListStrings] = (VWQL.SortPrio.other or defSortPrio.other)
								else
									RewardListColor[#RewardListStrings] = LE.BAG_ITEM_QUALITY_COLORS[6]
									RewardListType[#RewardListStrings] = (VWQL.SortPrio.azerite or defSortPrio.azerite)
								end
	
								RewardListStrings[#RewardListStrings] = BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT:format(texture, WorldQuestList:FormatAzeriteNumber(numItems), name)
	
								if O.nextResearch and (timeLeftMinutes - 5) > O.nextResearch then
									timeToComplete = timeLeftMinutes - O.nextResearch
									RewardListStrings[#RewardListStrings] = RewardListStrings[#RewardListStrings]:gsub("( [^ ]+)$","**%1")
									--artifactKnowlege = true
								end
							elseif currencyID == 1533 then	--Wakening Essence
								hasRewardFiltered = true
								if VWQL[charKey].wakeningessenceFilter then
									isValidLine = 0 
								end
								if isValidLine ~= 0 then
									totalWE = totalWE + (numItems or 0)
								end
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.curr1533 or defSortPrio.curr1533)
							elseif currencyID == 1220 then	--Order Resources
								hasRewardFiltered = true
								if bit.band(filters[3][2],ActiveFilter) == 0 then 
									isValidLine = 0 
								end
								if isValidLine ~= 0 then
									totalOR = totalOR + (numItems or 0)
								end
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.curr1560 or defSortPrio.curr1560) + 0.2
							elseif currencyID == 1560 then	--War Resources
								hasRewardFiltered = true
								if ActiveFilterType.bfa_orderres then 
									isValidLine = 0 
								end
								if isValidLine ~= 0 then
									totalORbfa = totalORbfa + (numItems or 0)
								end
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.curr1560 or defSortPrio.curr1560) + 0.1
							elseif currencyID == 1721 then	--Prismatic Manapearl
								hasRewardFiltered = true
								for j=1,#RewardListStrings-1 do
									if RewardListType[j] == (VWQL.SortPrio.curr1721 or defSortPrio.curr1721) then
										RewardListStrings[j] = RewardListStrings[j]:gsub("|t(%d+)",function(val)
											return "|t"..tostring( tonumber(val)+(numItems or 0) )
										end)
										RewardListSort[j] = RewardListSort[j] + (numItems or 0)
										local toremove = #RewardListStrings
										tremove(RewardListStrings,toremove)
										tremove(RewardListType,toremove)
										tremove(RewardListSort,toremove)
										break
									end
								end
								if ActiveFilterType.manapearl then 
									isValidLine = 0 
								end
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.curr1721 or defSortPrio.curr1721)
							elseif currencyID == 1602 then	--Conq Points
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.honor or defSortPrio.honor) + 0.1
							elseif currencyID == 2408 or currencyID == 2245 then
								hasRewardFiltered = true
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.curr1508 or defSortPrio.curr1508)
							elseif currencyID == 2815 then
								hasRewardFiltered = true
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.curr2815 or defSortPrio.curr2815)
								if ActiveFilterType.curr2815 then 
									isValidLine = 0 
								end
							elseif currencyID == 3008 then
								hasRewardFiltered = true
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.curr3008 or defSortPrio.curr3008)
								if ActiveFilterType.curr3008 then 
									isValidLine = 0 
								end
							elseif WorldQuestList:IsFactionCurrency(currencyID) then
								hasRewardFiltered = true
								if ActiveFilterType.rep then 
									isValidLine = 0 
								end
								RewardListColor[#RewardListStrings] = WorldQuestList.ColorYellow
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.rep or defSortPrio.rep) + 10 + currencyID / 10000
	
								if VWQL[charKey]["faction"..WorldQuestList:FactionCurrencyToID(currencyID).."Highlight"] then
									highlightFaction = true
								end
							end
						end
					end

					-- items
					local numQuestRewards = GetNumQuestLogRewards(questID)
					if numQuestRewards > 0 then
						local name,icon,numItems,quality,_,itemID = GetQuestLogRewardInfo(1,questID)

						RewardListStrings[#RewardListStrings+1] = (numItems and numItems > 1 and numItems.."x " or "").."item "..(itemID or 0)
						RewardListType[#RewardListStrings] = (VWQL.SortPrio.itemunk or defSortPrio.itemunk)
						RewardListSort[#RewardListStrings] = itemID or icon or 0

						if name then
							RewardListStrings[#RewardListStrings] = "|T"..icon..":0|t "..(numItems and numItems > 1 and numItems.."x " or "")..name
							rewardItem = true

							if quality and quality >= LE.LE_ITEM_QUALITY_COMMON and LE.BAG_ITEM_QUALITY_COLORS[quality] then
								RewardListColor[#RewardListStrings] = LE.BAG_ITEM_QUALITY_COLORS[quality]

								if quality == 1 or nameicon == -4 then
									RewardListColor[#RewardListStrings] = nil

									if bit.band(filters[6][2],ActiveFilter) == 0 then 
										isValidLine = 0 
									end
								end
								hasRewardFiltered = true
							elseif quality and quality == 0 then
								RewardListColor[#RewardListStrings] = LE.BAG_ITEM_QUALITY_COLORS[1]
								RewardListType[#RewardListStrings] = (VWQL.SortPrio.other or defSortPrio.other)
								hasRewardFiltered = true
								if bit.band(filters[6][2],ActiveFilter) == 0 then 
									isValidLine = 0 
								end
							end

							if icon == 1387622 then		--Rank 3 recipe
								RewardListColor[#RewardListStrings] = WorldQuestList.ColorBlueLight
							elseif icon == 1387621 then		--Rank 2 recipe
								RewardListColor[#RewardListStrings] = WorldQuestList.ColorBlueLight
							elseif icon == 1392955 then		--no-rank recipe
								RewardListColor[#RewardListStrings] = WorldQuestList.ColorBlueLight
							end
						end
						local itemIlvl
						local isBoeItem = nil
						local isAnimaItem = nil

						if itemID and WorldQuestList.CacheSLAnimaItems[itemID] then
							isAnimaItem = WorldQuestList.CacheSLAnimaItems[itemID]
						else
							local tooltipData = C_TooltipInfo.GetQuestLogItem("reward", 1, questID)
							if tooltipData then
								rewardItemLink = tooltipData.hyperlink
								for j=2, #tooltipData.lines do
									local tooltipLine = tooltipData.lines[j]
									local text = tooltipLine.leftText
									if text and text:find(ITEM_LEVEL) then
										local ilvl = text:match(ITEM_LEVEL)
										RewardListStrings[#RewardListStrings] = RewardListStrings[#RewardListStrings]:gsub("(|t %d*x* *)","%1"..ilvl.." ")
										ilvl = tonumber( ilvl:gsub("%+",""),nil )
										if ilvl then
											RewardListType[#RewardListStrings] = (VWQL.SortPrio.itemgear or defSortPrio.itemgear)
											RewardListSort[#RewardListStrings] = ilvl + (itemID / 1000000)
											itemIlvl = ilvl
											hasRewardFiltered = true
										end
									elseif text and text:find(LE.ITEM_BIND_ON_EQUIP) and j<=4 then
										isBoeItem = true
									elseif text and text:find(WORLD_QUEST_REWARD_FILTERS_ANIMA.."|r$") then
										isAnimaItem = true
									elseif text and isAnimaItem and text:find("^"..LE.ITEM_SPELL_TRIGGER_ONUSE) then
										local num = text:gsub("(%d+)[ %.,]+(%d+)","%1%2"):match("%d+")
										isAnimaItem = tonumber(num or "")
										if isAnimaItem then
											WorldQuestList.CacheSLAnimaItems[itemID] = isAnimaItem
										end
										isAnimaItem = isAnimaItem or 35
									end 
								end
							end
						end

						if isAnimaItem then
							hasRewardFiltered = true
							if ActiveFilterType.anima then 
								isValidLine = 0  
							end
							if type(isAnimaItem)=='number' then
								numItems = (numItems or 0) * isAnimaItem
							end
							if C_PvP.IsWarModeDesired() and C_QuestLog.QuestCanHaveWarModeBonus(questID) then
								local bonus = floor(numItems * (WAR_MODE_BONUS - 1) + .5)
								--if isAnimaItem <= 35 then
									bonus = bonus - bonus % 3
								--else
								--	bonus = bonus - bonus % 5
								--end
								numItems = numItems + bonus
							end
							if isValidLine ~= 0 then
								totalAnima = totalAnima + (numItems or 0)
							end

							RewardListColor[#RewardListStrings] = LE.BAG_ITEM_QUALITY_COLORS[6]
							RewardListType[#RewardListStrings] = (VWQL.SortPrio.anima or defSortPrio.anima)

							RewardListStrings[#RewardListStrings] = numItems .. " ".. WORLD_QUEST_REWARD_FILTERS_ANIMA
							RewardListSort[#RewardListStrings] = (numItems or 0) + (itemID / 1000000)
						end

						if itemID == 124124 then
							RewardListType[#RewardListStrings] = (VWQL.SortPrio.itemcraft or defSortPrio.itemcraft) + 0.5
							RewardListSort[#RewardListStrings] = numItems or 0
							hasRewardFiltered = true
							if bit.band(filters[4][2],ActiveFilter) == 0 then 
								isValidLine = 0 
							end
						elseif itemID == 151568 then
							RewardListType[#RewardListStrings] = (VWQL.SortPrio.itemcraft or defSortPrio.itemcraft) + 0.6
							RewardListSort[#RewardListStrings] = numItems or 0
							hasRewardFiltered = true
							if bit.band(filters[4][2],ActiveFilter) == 0 then 
								isValidLine = 0 
							end
						elseif itemID == 152960 or itemID == 152957 then
							hasRewardFiltered = true
							RewardListSort[#RewardListStrings] = numItems or 0
							if ActiveFilterType.rep then 
								isValidLine = 0 
							end
							RewardListType[#RewardListStrings] = (VWQL.SortPrio.rep or defSortPrio.rep) + (itemID == 152960 and 0.2170 or 0.2165)
							RewardListColor[#RewardListStrings] = WorldQuestList.ColorYellow
						elseif itemID == 173372 or itemID == 174960 or itemID == 174961 or itemID == 174958 or itemID == 174959 then
							hasRewardFiltered = true
							RewardListSort[#RewardListStrings] = numItems or 0
							if ActiveFilterType.bounty_cache then 
								isValidLine = 0 
							end
							RewardListType[#RewardListStrings] = (VWQL.SortPrio.bounty_cache or defSortPrio.bounty_cache)
						elseif itemID == 226264 then
							hasRewardFiltered = true
							RewardListSort[#RewardListStrings] = numItems or 0
							if ActiveFilterType.bounty_cache then 
								--isValidLine = 0 
							end
							RewardListType[#RewardListStrings] = (VWQL.SortPrio.bounty_cache or defSortPrio.bounty_cache)
						end

						if (quality or 0) >= 3 and VWQL.ExpulsomReplace then
							local _,_,_,itemType,expulsomIcon = C_Item.GetItemInfoInstant(itemID)
							if itemType == "INVTYPE_TRINKET" and (itemIlvl or 0) >= 280 then
								itemID = 152668
								numItems = 1
								RewardListStrings[#RewardListStrings] = "|T2065568:0|t "..(C_Item.GetItemInfo(152668) or "Expulsom")
								RewardListColor[#RewardListStrings] = LE.BAG_ITEM_QUALITY_COLORS[3]
							end
						end

						if itemID == 152668 then	--expulsom
							RewardListType[#RewardListStrings] = (VWQL.SortPrio.itemcraft or defSortPrio.itemcraft) + 0.4
							RewardListSort[#RewardListStrings] = numItems or 0
							hasRewardFiltered = true
							if ActiveFilterType.expulsom then
								isValidLine = 0 
							end
						end

						if itemID and (RewardListType[#RewardListStrings] == (VWQL.SortPrio.itemgear or defSortPrio.itemgear)) then
							hasRewardFiltered = true
							if bit.band(filters[1][2],ActiveFilter) == 0 then 
								isValidLine = 0 
							end
							if isBoeItem then
								RewardListStrings[#RewardListStrings] = RewardListStrings[#RewardListStrings]:gsub("(|t %d+) ","%1 BOE ")
							end
						end

						if itemID and RewardListType[#RewardListStrings] == (VWQL.SortPrio.itemunk or defSortPrio.itemunk) then
							RewardListSort[#RewardListStrings] = (quality or 1) * 1000000 + itemID + min(numItems,999) / 1000

							if bit.band(filters[6][2],ActiveFilter) == 0 then 
								isValidLine = 0 
							end
						end

						if itemID and RewardListType[#RewardListStrings] == (VWQL.SortPrio.itemunk or defSortPrio.itemunk) and worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE then
							RewardListType[#RewardListStrings] = (VWQL.SortPrio.pet or defSortPrio.pet)
						end
					end

					-- honor
					local honorAmount = GetQuestLogRewardHonor(questID)
					if ( honorAmount and honorAmount > 0 ) then
						RewardListStrings[#RewardListStrings+1] = BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT:format("Interface\\ICONS\\Achievement_LegionPVPTier4", honorAmount, HONOR)
						RewardListSort[#RewardListStrings] = honorAmount
						RewardListType[#RewardListStrings] = (VWQL.SortPrio.honor or defSortPrio.honor) + 0.2
						hasRewardFiltered = true
						if bit.band(filters[6][2],ActiveFilter) == 0 then 
							isValidLine = 0 
						end

						IsPvPQuest = true
					end

					-- money
					local money = GetQuestLogRewardMoney(questID)
					if ( money > 0 ) then
						if C_PvP.IsWarModeDesired() and C_QuestLog.QuestCanHaveWarModeBonus(questID) then
							money = money * WAR_MODE_BONUS
							money = money - money % 100
						end
						money = money - money % 100 --remove copper
						RewardListStrings[#RewardListStrings+1] = C_CurrencyInfo.GetCoinTextureString(money)
						RewardListSort[#RewardListStrings] = money
						RewardListType[#RewardListStrings] = (VWQL.SortPrio.gold or defSortPrio.gold)
						if money > 400000 then
							hasRewardFiltered = true

							if bit.band(filters[5][2],ActiveFilter) == 0 then 
								isValidLine = 0 
							end
							if isValidLine ~= 0 then
								totalG = totalG + money
							end
						end
					end

					if #RewardListStrings > 0 then
						for j=1,#RewardListStrings do
							RewardListPos[j] = j
						end
						sort(RewardListPos,RewardListSortFunc)

						--swap low gold amount reward
						if RewardListType[ RewardListPos[1] ] == (VWQL.SortPrio.gold or defSortPrio.gold)
							and RewardListStrings[ RewardListPos[1] ]:find("\\MoneyFrame\\") 
							and RewardListSort[ RewardListPos[1] ] <= 1000000
							and RewardListPos[2] and RewardListType[ RewardListPos[2] ] then
							RewardListPos[1], RewardListPos[2] = RewardListPos[2], RewardListPos[1]
						end

						rewardType = RewardListType[ RewardListPos[1] ]
						rewardSort = RewardListSort[ RewardListPos[1] ]
						rewardColor = RewardListColor[ RewardListPos[1] ]
						for j=1,#RewardListPos do
							RewardListSorted[j] = RewardListStrings[ RewardListPos[j] ]
						end
					end


					if not hasRewardFiltered then
						rewardType = (VWQL.SortPrio.other or defSortPrio.other)
						if bit.band(filters[6][2],ActiveFilter) == 0 then 
							isValidLine = 0 
						end
					end
				else
					rewardType = (VWQL.SortPrio.other or defSortPrio.other) + 0.5
					if bit.band(filters[6][2],ActiveFilter) == 0 then 
						isValidLine = 0 
					end

					noRewardCount = noRewardCount + 1
					if noRewardCount > 3 then
						WorldQuestList:ResetTicker()
					end
				end


				if not professionFix then
					if VWQL[charKey].bountyIgnoreFilter and factionInProgress then 
						isValidLine = 1
					end
					if VWQL[charKey].honorIgnoreFilter and IsPvPQuest then
						isValidLine = 1
					end
					if VWQL[charKey].petIgnoreFilter and worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE then
						isValidLine = 1
					end
					if VWQL[charKey].azeriteIgnoreFilter and FindInReward(VWQL.SortPrio.azerite or defSortPrio.azerite) then
						isValidLine = 1
					end
					if VWQL[charKey].animaIgnoreFilter and FindInReward(VWQL.SortPrio.anima or defSortPrio.anima) then
						isValidLine = 1
					end
					if VWQL[charKey].epicIgnoreFilter and rarity == LE.LE_WORLD_QUEST_QUALITY_EPIC then
						isValidLine = 1
					end
					if VWQL[charKey].wantedIgnoreFilter and IsWantedQuest then
						isValidLine = 1
					end
					if VWQL[charKey].manapearlIgnoreFilter and FindInReward(VWQL.SortPrio.curr1721 or defSortPrio.curr1721) then
						isValidLine = 1
					end
					if VWQL[charKey].legionfallIgnoreFilter and factionID == 2045 then
						isValidLine = 1
					elseif VWQL[charKey].aotlIgnoreFilter and factionID == 2165 then
						isValidLine = 1
					elseif VWQL[charKey].argusReachIgnoreFilter and factionID == 2170 then
						isValidLine = 1
					elseif factionID and VWQL[charKey]["faction"..factionID.."IgnoreFilter"] and WorldQuestList:IsFactionAvailable(factionID) then
						isValidLine = 1
					end
				end

				if isValidLine == 1 then
					TableQuestsViewed[ questID ] = true
					if not VWQL[charKey].Quests[ questID ] then
						TableQuestsViewed_Time[ questID ] = currTime + 180
					end
					tinsert(result,{
						info = info,
						reward = table.concat(RewardListSorted,", "),
						rewardItem = rewardItem,
						rewardItemLink = rewardItemLink,
						rewardColor = rewardColor,
						faction = faction,
						factionInProgress = factionInProgress,
						factionSort = factionSort,
						zone = (((VWQL.OppositeContinent and (mapAreaID == 875 or mapAreaID == 876)) or mapAreaID == 947 or mapAreaID == 1550 or mapAreaID == 1978 or mapAreaID == 2274) and WorldQuestList:GetMapIcon(info.mapID) or "")..
							((mapAreaID == 875 or mapAreaID == 876 or mapAreaID == 1550 or mapAreaID == 1978 or mapAreaID == 2274) and WorldQuestList:GetMapTextColor(info.mapID) or "")..WorldQuestList:GetMapName(info.mapID),
						zoneID = info.mapID or 0,
						timeleft = timeleft,
						time = timeLeftMinutes or 0,
						numObjectives = info.numObjectives,
						questID = questID,
						isNewQuest = isNewQuest,
						name = name,
						rewardType = rewardType,
						rewardSort = rewardSort,
						nameicon = nameicon,
						--artifactKnowlege = artifactKnowlege,
						isEliteQuest = isEliteQuest,
						timeToComplete = timeToComplete,
						isInvasion = isInvasion,
						bountyTooltip = bountyTooltip,
						isUnlimited = isUnlimited,
						distance = C_QuestLog.GetDistanceSqToQuest(questID) or math.huge,
						questColor = questColor,
						reputationList = reputationList,
						professionIndex = tradeskillLineIndex and tradeskillLineID,
						disableLFG = WorldQuestList:IsQuestDisabledForLFG(questID) or worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE,
						highlightFaction = highlightFaction,
						debugLine = debugLine,
						showAchievement = showAchievement,
						showAsRegQuest = info.forced,
						reputationAcc = reputationAcc,
						reputationNoRep = reputationNoRep,
					})
				end

				totalQuestsNumber = totalQuestsNumber + 1
			end
		end end
	end

	if taskInfo and taskInfo.poi then
		for i=1,#taskInfo.poi do
			local name, description, x, y, poiID, atlasIcon, poiWQLType, zoneID, dX, dY = unpack(taskInfo.poi[i])
			if poiWQLType == 1 and not VWQL[charKey].invasionPointsFilter then	--invasion points
				local timeLeftMinutes = (C_AreaPoiInfo.GetAreaPOISecondsLeft(poiID) or 0) / 60
				local isGreat = atlasIcon:match("%d+$") == "2"
				if x == -1 then
					x = nil
					y = nil
				end
				tinsert(result,{
					info = {
						x = x,
						y = y,
						mapID = zoneID,
						name = description,
						dX = dX,
						dY = dY,
						dMap = zoneID,
					},
					reward = description and description:gsub("^.-: ","") or "",
					faction = "",
					factionSort = "",
					zone = ((mapAreaID == 947 or mapAreaID == 1550) and WorldQuestList:GetMapIcon(zoneID) or "")..WorldQuestList:GetMapName(zoneID),
					zoneID = zoneID or 0,
					timeleft = WorldQuestList:FormatTime(timeLeftMinutes),
					time = timeLeftMinutes,
					numObjectives = 0,
					name = name,
					rewardType = 70,
					rewardSort = poiID,
					nameicon = isGreat and -9 or -8,
					distance = WorldQuestList:CalculateSqDistanceTo(x, y),
					questColor = 3,
					isInvasionPoint = true,
				})
				numTaskPOIs = numTaskPOIs + 1
			elseif poiWQLType == 2 then
				local timeLeftMinutes = (C_AreaPoiInfo.GetAreaPOISecondsLeft(poiID) or 0) / 60
				tinsert(result,{
					info = {
						x = x,
						y = y,
						mapID = zoneID,
						name = description,
						dX = dX,
						dY = dY,
						dMap = zoneID,
					},
					reward = description and description:gsub("^.-: ","") or "",
					faction = "",
					factionSort = "",
					zone = WorldQuestList:GetMapName(zoneID),
					zoneID = zoneID or 0,
					timeleft = WorldQuestList:FormatTime(timeLeftMinutes),
					time = timeLeftMinutes,
					numObjectives = 0,
					name = name,
					rewardType = 70,
					rewardSort = poiID,
					nameicon = -10,
					distance = WorldQuestList:CalculateSqDistanceTo(x, y),
					questColor = 5,
					isInvasionPoint = true,
				})
				numTaskPOIs = numTaskPOIs + 1
			elseif poiWQLType == 3 then
				local timeLeftMinutes = (C_AreaPoiInfo.GetAreaPOISecondsLeft(poiID) or 0) / 60
				tinsert(result,{
					info = {
						x = x,
						y = y,
						mapID = zoneID,
						name = description,
						dX = dX,
						dY = dY,
						dMap = zoneID,
					},
					reward = description and description:gsub("^.-: ","") or "",
					faction = "",
					factionSort = "",
					zone = WorldQuestList:GetMapName(zoneID),
					zoneID = zoneID or 0,
					timeleft = WorldQuestList:FormatTime(timeLeftMinutes),
					time = timeLeftMinutes,
					numObjectives = 0,
					name = name,
					rewardType = 70,
					rewardSort = poiID,
					nameicon = atlasIcon,
					distance = WorldQuestList:CalculateSqDistanceTo(x, y),
					questColor = nil,
					isInvasionPoint = true,
				})
				numTaskPOIs = numTaskPOIs + 1
			elseif (poiWQLType == 4 and not ActiveFilterType.tww_bounty) then
				local timeLeftMinutes = (C_AreaPoiInfo.GetAreaPOISecondsLeft(poiID) or 0) / 60
				local timeLeftString
				local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(taskInfo.poi[i].widget)
				if widgets then
					for j=1,#widgets do
						local d = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(widgets[j].widgetID)
						if d and d.text and d.text:find(TIME_REMAINING) then
							timeLeftString = d.text:gsub(TIME_REMAINING,""):trim()
							break
						end
					end
				end
				tinsert(result,{
					info = {
						x = x,
						y = y,
						mapID = zoneID,
						name = description,
						dX = dX,
						dY = dY,
						dMap = zoneID,
					},
					reward = description and description:gsub("^.-: ","") or "",
					faction = "",
					factionSort = "",
					zone = WorldQuestList:GetMapName(zoneID),
					zoneID = zoneID or 0,
					timeleft = timeLeftString or WorldQuestList:FormatTime(timeLeftMinutes),
					time = timeLeftMinutes,
					numObjectives = 0,
					name = name,
					rewardType = 70,
					rewardSort = poiID,
					nameicon = atlasIcon,
					distance = WorldQuestList:CalculateSqDistanceTo(x, y),
					questColor = nil,
					isInvasionPoint = true,
				})
				numTaskPOIs = numTaskPOIs + 1
			end
			totalQuestsNumber = totalQuestsNumber + 1
		end
	end

	sort(result,SortFuncs[ActiveSort])

	if VWQL.ReverseSort then
		local newResult = {}
		for i=#result,1,-1 do
			newResult[#newResult+1] = result[i]
		end
		result = newResult
	end

	if WQ_provider and WorldMapFrame:IsVisible() then
		local pinsToRemove = {}
		for questId in pairs(WorldQuestList.WMF_activePins) do
			pinsToRemove[questId] = true
		end
		local isUpdateReq = nil

		if O.isGeneralMap and not VWQL.DisableIconsGeneral and not VWQL["DisableIconsGeneralMap"..mapAreaID] then
			WorldQuestList.IconsGeneralLastMap = mapAreaID
			for i=1,#result do
				local info = result[i].info
				if info and info.questID and info.x and not result[i].showAsRegQuest then
					if (O.generalMapType == 3 and VWQL.ArgusMap) or 
						(mapAreaID == 619 and info.x == 0.87 and info.y == 0.165) or 
						((mapAreaID == 875 or mapAreaID == 876) and info.x == 0.87 and info.y == 0.12) or 
						(mapAreaID == 1550 and info.x == 0.86 and info.y == 0.80) or 
						(mapAreaID == 1978 and info.x == 0.87 and info.y == 0.81)
					then
						info = WorldQuestList:GetRadiantWQPosition(info,result)
					elseif
						(mapAreaID == 1978 and info.x == 0.31 and info.y == 0.56)
					then
						info = WorldQuestList:GetLinearWQPosition(info,result,3)
					elseif
						(mapAreaID == 2274 and info.x == 0.82 and info.y == 0.72)
					then
						info = WorldQuestList:GetRadiantWQPosition(info,result,0.05)
					end
					pinsToRemove[info.questID] = nil
					local pin = WorldQuestList.WMF_activePins[info.questID]
					if pin then
						pin:RefreshVisuals()
						pin:SetPosition(info.x, info.y)

						if WQ_provider.pingPin and WQ_provider.pingPin.questID == info.questID then
							WQ_provider.pingPin:SetPosition(info.x, info.y)
						end
					else
						WorldQuestList.WMF_activePins[info.questID] = WQ_provider:AddWorldQuest(info)
					end
				end
			end
			isUpdateReq = true
		end

		for questId in pairs(pinsToRemove) do
			if WQ_provider.pingPin and WQ_provider.pingPin.questID == questId then
				WQ_provider.pingPin:Stop()
			end
			local pin = WorldQuestList.WMF_activePins[questId]

			WQ_provider:GetMap():RemovePin(pin)
			WorldQuestList.WMF_activePins[questId] = nil
		end

		if isUpdateReq then
			WorldMapFrame:TriggerEvent("WorldQuestsUpdate", WorldMapFrame:GetNumActivePinsByTemplate("WorldMap_WorldQuestPinTemplate"))
		end
	end

	if ( NUM_WORLDMAP_TASK_POIS < numTaskPOIs ) then
		for i=NUM_WORLDMAP_TASK_POIS+1, numTaskPOIs do
			WorldQuestList_CreateLine(i)
		end
		NUM_WORLDMAP_TASK_POIS = numTaskPOIs
	end

	local lfgEyeStatus = true
	if C_LFGList.GetActiveEntryInfo() or VWQL.DisableLFG or VWQL.LFG_HideEyeInList then
		lfgEyeStatus = false
	end

	for i=1,#result do
		local data = result[i]
		local line = WorldQuestList.l[taskIconIndex]

		line.name:SetText(data.name)
		if data.questColor == 3 then
			line.name:SetTextColor(0.78, 1, 0)
		elseif data.questColor == 4 then
			line.name:SetTextColor(1,.8,.2)
		elseif data.questColor == 1 then
			line.name:SetTextColor(.2,.5,1)
		elseif data.questColor == 2 then
			line.name:SetTextColor(.63,.2,.9)
		elseif data.questColor == 5 then
			line.name:SetTextColor(.66,.5,.9)
		else
			line.name:SetTextColor(1,1,1)
		end

		local questNameWidth = WorldQuestList.NAME_WIDTH
		if data.nameicon then
			line.nameicon:SetWidth(16)
			if data.nameicon == -1 then
				line.nameicon:SetAtlas("nameplates-icon-elite-silver")
			elseif data.nameicon == -2 then
				line.nameicon:SetAtlas("nameplates-icon-elite-gold")
			elseif data.nameicon == -3 then
				line.nameicon:SetAtlas("worldquest-icon-pvp-ffa")
			elseif data.nameicon == -4 then
				line.nameicon:SetAtlas("worldquest-icon-petbattle")
			elseif data.nameicon == -5 then
				line.nameicon:SetAtlas("worldquest-icon-engineering")
			elseif data.nameicon == -6 then
				line.nameicon:SetAtlas("Dungeon")
			elseif data.nameicon == -7 then
				line.nameicon:SetAtlas("Raid")
			elseif data.nameicon == -8 then
				line.nameicon:SetAtlas("poi-rift1")
			elseif data.nameicon == -9 then
				line.nameicon:SetAtlas("poi-rift2")
			elseif data.nameicon == -10 then
				line.nameicon:SetAtlas("worldquest-icon-nzoth")
			elseif data.nameicon == -11 then
				line.nameicon:SetAtlas("worldquest-icon-race")
			elseif type(data.nameicon) == "string" then
				line.nameicon:SetAtlas(data.nameicon)
			end
			questNameWidth = questNameWidth - 15
		else
			line.nameicon:SetTexture("")
			line.nameicon:SetWidth(1)
		end

		line.achievementID = nil
		if data.showAchievement then
			line.secondicon:SetAtlas("QuestNormal")
			--"TrivialQuests"	"groupfinder-icon-quest"
			line.secondicon:SetWidth(16)

			questNameWidth = questNameWidth - 15

			line.achievementID = data.showAchievement
		elseif data.isInvasion then
			if data.isInvasion == 3 then
				line.secondicon:SetAtlas("worldquest-icon-nzoth")
			elseif data.isInvasion == 2 then
				local factionTag = UnitFactionGroup("player")
				line.secondicon:SetAtlas(factionTag == "Alliance" and "worldquest-icon-horde" or "worldquest-icon-alliance")
			else
				line.secondicon:SetAtlas("worldquest-icon-burninglegion")
			end
			line.secondicon:SetWidth(16)

			questNameWidth = questNameWidth - 15
		elseif data.professionIndex and WORLD_QUEST_ICONS_BY_PROFESSION[data.professionIndex] and data.nameicon then
			line.secondicon:SetAtlas(WORLD_QUEST_ICONS_BY_PROFESSION[data.professionIndex])
			line.secondicon:SetWidth(16)

			questNameWidth = questNameWidth - 15
		else
			line.secondicon:SetTexture("")
			line.secondicon:SetWidth(1)
		end

		if data.isInvasionPoint and (not O.isGeneralMap or not VWQL.ArgusMap) then
			line.isInvasionPoint = true
		else
			line.isInvasionPoint = nil
		end

		if lfgEyeStatus then
			if data.disableLFG then
				line.LFGButton.questID = nil
			else
				line.LFGButton.questID = data.questID
			end
			line.LFGButton:Hide()
			line.LFGButton:Show()
		else
			line.LFGButton:Hide()
		end

		line.name:SetWidth(questNameWidth)

		line.reward:SetText(data.reward)
		if data.rewardColor then
			line.reward:SetTextColor(data.rewardColor.r, data.rewardColor.g, data.rewardColor.b)
		else
			line.reward:SetTextColor(1,1,1)
		end
		if data.rewardItem then
			line.reward.ID = data.questID
		else
			line.reward.ID = nil
		end
		line.isRewardLink = nil

		line.faction:SetText((data.reputationAcc and "|A:loottoast-arrow-blue:0:0|a" or "")..data.faction)
		if data.reputationNoRep then
			line.faction:SetTextColor(.5,.5,.5)
		elseif data.highlightFaction then
			line.faction:SetTextColor(.8,.35,1)
		elseif data.factionInProgress then
			line.faction:SetTextColor(.5,1,.5)
		else
			line.faction:SetTextColor(1,1,1)
		end

		line.zone:SetText(data.zone)
		line.zone:SetWordWrap(false)	--icon-in-text v-spacing fix

		line.name:SetWordWrap(false)	--icon-in-text v-spacing fix
		line.faction:SetWordWrap(false)	--icon-in-text v-spacing fix

		line.timeleft:SetText(data.timeleft or "")
		if data.isUnlimited then
			line.timeleft.f._t = nil
		else
			line.timeleft.f._t = data.time
		end

		if O.isGeneralMap then
			line.zone:Show()
			line.zone.f:Show()
		else
			line.zone:Hide()
			line.zone.f:Hide()
		end

		line.questID = data.questID
		line.numObjectives = data.numObjectives
		line.data = data.info
		line.dataResult = data

		line.debugTooltip = data.debugLine and data.debugLine ~= "" and data.debugLine:gsub("|n$","") or nil

		if data.isNewQuest and not VWQL.DisableHighlightNewQuest then
			line.nqhl:Show()
		else
			line.nqhl:Hide()
		end

		if data.artifactKnowlege then
			line.reward.artifactKnowlege = true
			line.reward.timeToComplete = data.timeToComplete
		else
			line.reward.artifactKnowlege = nil
			line.reward.timeToComplete = nil
		end

		if data.showAsRegQuest then
			line.isLeveling = true
		else
			line.isLeveling = nil
		end

		line.rewardLink = data.rewardItemLink

		line.faction.f.tooltip = data.bountyTooltip
		line.faction.f.reputationList = data.reputationList

		line.isTreasure = nil
		line.reward.IDs = nil

		line:Show()

		taskIconIndex = taskIconIndex + 1
	end

	WorldQuestList.currentResult = result
	WorldQuestList.currentO = O

	if O.isGeneralMap then
		WorldQuestList:SetWidth(WorldQuestList_Width+WorldQuestList_ZoneWidth)
		WorldQuestList.C:SetWidth(WorldQuestList_Width+WorldQuestList_ZoneWidth)
	else
		WorldQuestList:SetWidth(WorldQuestList_Width)
		WorldQuestList.C:SetWidth(WorldQuestList_Width)
	end

	WorldQuestList:SetHeight(max(16*(taskIconIndex-1)+(VWQL.DisableHeader and 0 or WorldQuestList.HEADER_HEIGHT)+(VWQL.DisableTotalAP and 0 or WorldQuestList.FOOTER_HEIGHT)+WorldQuestList.SCROLL_FIX_BOTTOM+WorldQuestList.SCROLL_FIX_TOP,1))
	WorldQuestList.C:SetHeight(max(16*(taskIconIndex-1),1))

	local lowestLine = #WorldQuestList.Cheader.lines
	local lowestPosConst = 30
	local lowestFixAnchorInside = VWQL.Anchor == 2 and WorldMapButton:GetBottom() or 0
	for i=1,#WorldQuestList.Cheader.lines do
		local bottomPos = (WorldQuestList.Cheader.lines[i]:GetBottom() or 0) - lowestFixAnchorInside
		if bottomPos and bottomPos < lowestPosConst then
			lowestLine = i - 1
			break
		end
	end

	if VWQL.MaxLinesShow then
		lowestLine = min(VWQL.MaxLinesShow,lowestLine)
	end

	if lowestLine >= taskIconIndex then
		WorldQuestList.Cheader:SetVerticalScroll(0)
	else
		WorldQuestList:SetHeight((lowestLine+1)*16+WorldQuestList.SCROLL_FIX_BOTTOM+WorldQuestList.SCROLL_FIX_TOP+(VWQL.DisableTotalAP and 0 or WorldQuestList.FOOTER_HEIGHT)+(VWQL.DisableHeader and 0 or WorldQuestList.HEADER_HEIGHT-16))
		WorldQuestList.Cheader:SetVerticalScroll( min(WorldQuestList.Cheader:GetVerticalScrollRange(),WorldQuestList.Cheader:GetVerticalScroll()) )
	end
	UpdateScrollButtonsState()
	C_Timer.After(0,UpdateScrollButtonsState)

	for i = taskIconIndex, NUM_WORLDMAP_TASK_POIS do
		WorldQuestList.l[i]:Hide()
	end

	if taskIconIndex == 1 then
		WorldQuestList.b:SetAlpha(0)
		WorldQuestList.backdrop:Hide()
		if mapAreaID == 619 or mapAreaID == 875 or mapAreaID == 876 or mapAreaID == 905 then
			ViewAllButton:Hide()
		else
			ViewAllButton:Show()
		end
		WorldQuestList.header:Update(true,nil,lfgEyeStatus)
		WorldQuestList.footer:Update(true)
	else
		WorldQuestList.b:SetAlpha(WorldQuestList.b.A or 1)
		WorldQuestList.backdrop:Show()
		ViewAllButton:Hide()
		WorldQuestList.header:Update(false,O.isGeneralMap,lfgEyeStatus)
		WorldQuestList.footer:Update(false,O.isGeneralMap)
	end

	if WorldQuestList:IsShadowlandsZone(mapAreaID) then
		WorldQuestList.footer.ap:SetText(WORLD_QUEST_REWARD_FILTERS_ANIMA..": "..totalAnima)
		WorldQuestList.footer.OR:SetText("")
	elseif WorldQuestList:IsLegionZone(mapAreaID) then
		local name,_,icon = GetCurrencyInfo(1533)
		WorldQuestList.footer.ap:SetText((icon and "|T"..icon..":0|t " or "")..name..": "..totalWE)
		WorldQuestList.footer.OR:SetText(format("|T%d:0|t %d",1397630,totalOR))
	elseif WorldQuestList:IsBfaZone(mapAreaID) then
		local az_name,_,icon = GetCurrencyInfo(1553)

		WorldQuestList.footer.ap:SetText((icon and "|T"..icon..":0|t " or "")..az_name..": "..WorldQuestList:FormatAzeriteNumber(totalAzerite))
		WorldQuestList.footer.OR:SetText(format("|T%d:0|t %d",2032600,totalORbfa))
	else
		WorldQuestList.footer.ap:SetText("")
		WorldQuestList.footer.OR:SetText("")
	end
	WorldQuestList.footer.gold:SetText(totalG > 0 and C_CurrencyInfo.GetCoinTextureString(totalG) or "")

	WorldQuestList.oppositeContinentButton:Update()
	WorldQuestList.modeSwitcherCheck:Update(WorldQuestList.TreasureData[mapAreaID])

	if totalQuestsNumber == 0 then
		WorldQuestList.sortDropDown:Hide()
		WorldQuestList.filterDropDown:Hide()
		WorldQuestList.optionsDropDown:Show()
	else
		WorldQuestList.sortDropDown:Show()
		WorldQuestList.filterDropDown:Show()
		WorldQuestList.optionsDropDown:Show()
	end

	HookWQbuttons()

	if VWQL.Anchor == 2 then	--Inside
		UpdateScale()
	end
end

WorldQuestList.UpdateList = WorldQuestList_Update

C_Timer.NewTicker(.8,function()
	if UpdateTicker then
		UpdateTicker = nil
		WorldQuestList_Update()
	end
end)

function WorldQuestList:ResetTicker()
	UpdateTicker = true
end

local UpdateDB_Sch = nil

local listZonesToUpdateDB = {1550,947,830,885,882}
local function UpdateDB()
	UpdateDB_Sch = nil
	for questID,_ in pairs(TableQuestsViewed) do
		VWQL[charKey].Quests[ questID ] = true
	end
	local questsList = {}

	for _,mapID in pairs(listZonesToUpdateDB) do
		local z = C_TaskQuest.GetQuestsForPlayerByMapID(mapID)
		for i, info  in pairs(z or WorldQuestList.NULLTable) do
			local questID = info.questID
			if HaveQuestData(questID) and QuestUtils_IsQuestWorldQuest(questID) then
				questsList[ questID ] = true
			end
		end
	end

	local toRemove = {}
	for questID,_ in pairs(VWQL[charKey].Quests) do
		if not questsList[ questID ] then
			toRemove[ questID ] = true
		end
	end
	for questID,_ in pairs(toRemove) do
		VWQL[charKey].Quests[ questID ] = nil
	end

	wipe(TableQuestsViewed)

end

local WorldMapButton_HookShowHide = CreateFrame("Frame",nil,WorldMapButton)
WorldMapButton_HookShowHide:SetPoint("TOPLEFT")
WorldMapButton_HookShowHide:SetSize(1,1)

WorldMapButton_HookShowHide:SetScript('OnHide',function()
	if UpdateDB_Sch then
		UpdateDB_Sch:Cancel()
	end
	UpdateDB_Sch = C_Timer.NewTimer(.2,UpdateDB)
end)
WorldMapButton_HookShowHide:SetScript('OnShow',function()
	if UpdateDB_Sch then
		UpdateDB_Sch:Cancel()
	end
	if VWQL[charKey].HideMap then
		--if not InCombatLockdown() then
			WorldQuestList:Hide()
		--end
		return
	end
	if WorldMapFrame:IsMaximized() and (VWQL.Anchor == 1 or not VWQL.Anchor) and (WorldMapFrame:GetWidth() / GetScreenWidth()) > 0.75 then
		if not WorldQuestList.IsSoloRun then
			WorldQuestList:Hide()
		end
		return
	elseif not WorldQuestList:IsVisible() then
		WorldQuestList:Show()
	end
	if (VWQL.Anchor == 3) then
		UpdateAnchor()
	end
	if WorldQuestList:IsVisible() then
		WorldQuestList:Hide()
		WorldQuestList:Show()
	end
end)

local prevZone, prevMapMode
WorldMapButton_HookShowHide:SetScript('OnUpdate',function(self)
	local mapMode = WorldMapFrame:IsMaximized()
	if prevMapMode ~= mapMode then
		prevMapMode = mapMode
		self:GetScript("OnShow")(self)
	end
	local currZone = GetCurrentMapID()
	if currZone ~= prevZone then
		WorldQuestList_Update()
		if not VWQL.DisableIconsGeneral and WorldMapFrame:IsMaximized() and not WorldQuestList:IsVisible() then
			WorldQuestList_Update(nil,true)
		end
	end
	prevZone = currZone
	UpdateTicker = true
end)
WorldMapButton_HookShowHide:RegisterEvent("QUEST_LOG_UPDATE")
WorldMapButton_HookShowHide:SetScript("OnEvent",function()
	if WorldMapFrame:IsVisible() 
		--or (WorldQuestList:IsVisible() and WorldQuestList.IsSoloRun) 
		then
		UpdateTicker = true
	end
end)

local slashfunc = function(arg)
	local argL = strlower(arg)
	if (arg == "" and WorldMapFrame:IsVisible() and not WorldMapFrame:IsMaximized()) or argL == "help" then
		print("World Quests List v."..VERSION)
		print("|cffffff00/wql options|r - force options dropdown")
		print("|cffffff00/wql reset|r - reset position")
		print("|cffffff00/wql resetanchor|r - reset anchor to default")
		print("|cffffff00/wql resetscale|r - reset scale to default (100%)")
		print("|cffffff00/wql scale 80|r - set custom scale (example, 80%)")
		return
	elseif argL == "reset" then
		VWQL.PosLeft = nil
		VWQL.PosTop = nil
		VWQL.Anchor3PosLeft = nil
		VWQL.Anchor3PosTop = nil
		ReloadUI()
		print("Position Reseted")
		return
	elseif argL == "resetanchor" then 
		VWQL.Anchor = nil
		UpdateAnchor()
		print("Anchor Reseted")
		return
	elseif argL == "resetscale" then 
		VWQL.Scale = nil
		UpdateScale()
		print("Scale Reseted")
		return
	elseif argL:find("^scale %d+") then 
		VWQL.Scale = tonumber( argL:match("%d+"),nil ) / 100
		UpdateScale()
		print("Scale set to "..(VWQL.Scale * 100).."%")
		return
	elseif argL:find("^iconscale %d+") then 
		VWQL.MapIconsScale = tonumber( argL:match("%d+"),nil ) / 100
		print("Icons scale set to "..(VWQL.MapIconsScale * 100).."%")
		return
	elseif argL:find("^way ") then 
		if argL:find("^way ml") then
			print("Added multiline")
			WorldQuestList.MultiArrow = true
		end
		local id,x,y = argL:match("#?(%d*) ?([%d%.,%-]+) ([%d%.,%-]+)")
		if x and y then
			x = tonumber( x:gsub(",$",""):gsub(",","."),nil )
			y = tonumber( y:gsub(",$",""):gsub(",","."),nil )
			if x and y then
				local mapID = C_Map.GetBestMapForUnit("player")
				if WorldMapFrame:IsVisible() then
					mapID = GetCurrentMapID()
				end
				if id and id ~= "" then
					mapID = tonumber(id)
				end
				if mapID then
					local wX,wY --= WorldQuestList:GetQuestWorldCoord2(-10,mapID,x / 100,y / 100,true)
					if not wX then
						local continentID, worldPos = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(x/100, y/100))
						if worldPos then
							wY,wX = worldPos:GetXY()
						end
					end
					if not wX then
						wX,wY = WorldQuestList:GetQuestWorldCoord2(-10,mapID,x / 100,y / 100,true)
					end
					if wX and wY then
						local comment = argL:match("^way +[^ ]+ +[^ ]+ (.-)$")

						local waypoint = {
							mapID = mapID,
							x = x/100,
							y = y/100,
							wX = wX,
							wY = wY,
							comment = comment,
						}
						if WorldQuestList.MultiArrow then
							WQLdb.Arrow:AddPoint(wX,wY,5,nil,nil,waypoint)
							WorldQuestList.Waypoints[#WorldQuestList.Waypoints+1] = waypoint
						else
							WQLdb.Arrow:ShowRunTo(wX,wY,5,nil,true,nil,waypoint)
							WorldQuestList.Waypoints[1] = waypoint
						end
					end

					local uiMapPoint = UiMapPoint.CreateFromCoordinates(mapID, x/100, y/100)
					C_Map.SetUserWaypoint(uiMapPoint)
					C_SuperTrack.SetSuperTrackedUserWaypoint(true)
				end
			end
		end
		return
	elseif argL == "options" then 
		WorldQuestList.optionsDropDown.Button:Click()
		return
	elseif WorldQuestList:IsVisible() then
		WorldQuestList:Hide()
		WorldQuestList:Show()
		return
	end
	WorldQuestList:ClearAllPoints()
	WorldQuestList:SetParent(UIParent)
	if type(VWQL)=='table' and type(VWQL.PosLeft)=='number' and type(VWQL.PosTop) == 'number' then
		WorldQuestList:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",VWQL.PosLeft,VWQL.PosTop)
	else
		if WorldMapFrame:GetPoint() then
			WorldQuestList:SetPoint("TOPLEFT",WorldMapFrame,20,0)
		else
			WorldQuestList:SetPoint("TOPLEFT",UIParent,"TOPLEFT",20,-200)
		end
	end
	WorldQuestList.IsSoloRun = true
	local currZone = C_Map.GetBestMapForUnit("player")--GetCurrentMapID()
	if argL == "argus" then
		currZone = 905
	elseif argL == "all" then
		currZone = 947
	elseif currZone == 905 or currZone == 885 or currZone == 882 or currZone == 830 then
		currZone = 905
	elseif WorldQuestList:IsLegionZone(currZone) then
		currZone = 619
	elseif WorldQuestList:IsMapParent(currZone,875) then
		currZone = 875
	elseif WorldQuestList:IsMapParent(currZone,876) then
		currZone = 876
	elseif WorldQuestList:IsMapParent(currZone,1550) then
		currZone = 1550
	else
		currZone = 947
	end

	WorldQuestList.SoloMapID = currZone

	UpdateScale()
	WorldQuestList.Close:Show()
	WorldQuestList.moveHeader:Show()
	WorldQuestList:Show()
	WorldQuestList_Update()

	WorldQuestList:SetFrameStrata("DIALOG")

	C_Timer.After(.5,WorldQuestList_Update)
	C_Timer.After(1.5,WorldQuestList_Update)
	if currZone == 947 then
		C_Timer.After(2.5,WorldQuestList_Update)
	end
end
SlashCmdList["WQLSlash"] = slashfunc

SLASH_WQLSlash1 = "/wql"
SLASH_WQLSlash2 = "/worldquestslist"

--Add /way
C_Timer.After(10,function()
	if C_AddOns.IsAddOnLoaded("TomTom") then
		return
	end
	SlashCmdList["WQLSlashWay"] = function(arg)
		for prefix,cmd in pairs(_G) do
			if type(prefix)=="string" and prefix:find("^SLASH_") and cmd == "/way" and prefix ~= "SLASH_WQLSlashWay1" then
				return
			end
		end
		slashfunc("way "..(arg or ""))
	end
	SLASH_WQLSlashWay1 = "/way"
end)

WorldQuestList.WorldMapHideWQLCheck = CreateFrame("CheckButton",nil,WorldMapFrame,"UICheckButtonTemplate")  
WorldQuestList.WorldMapHideWQLCheck:SetPoint("TOPLEFT", WorldMapFrame, "TOPRIGHT", -130, 25)
WorldQuestList.WorldMapHideWQLCheck.text:SetText("World Quests List")
WorldQuestList.WorldMapHideWQLCheck:SetScript("OnClick", function(self,event) 
	if not self:GetChecked() then
		VWQL[charKey].HideMap = true
		WorldQuestList:Hide()
	else
		VWQL[charKey].HideMap = nil
		WorldQuestList:Show()
		WorldQuestList_Update()
	end
end)




WorldQuestList.BlackListWindow = CreateFrame("Frame",nil,UIParent,"BackdropTemplate")
WorldQuestList.BlackListWindow:SetBackdrop({bgFile="Interface/Buttons/WHITE8X8"})
WorldQuestList.BlackListWindow:SetBackdropColor(0.05,0.05,0.07,0.98)
WorldQuestList.BlackListWindow.title = WorldQuestList.BlackListWindow:CreateFontString(nil,"OVERLAY","GameFontNormal")
WorldQuestList.BlackListWindow.title:SetPoint("TOP",0,-3)
WorldQuestList.BlackListWindow.title:SetTextColor(1,0.66,0,1)
WorldQuestList.BlackListWindow.title:SetText(IGNORE)
WorldQuestList.BlackListWindow:SetPoint("CENTER")
WorldQuestList.BlackListWindow:Hide()
WorldQuestList.BlackListWindow:SetFrameStrata("DIALOG")
WorldQuestList.BlackListWindow:SetClampedToScreen(true)
WorldQuestList.BlackListWindow:EnableMouse(true)
WorldQuestList.BlackListWindow:SetMovable(true)
WorldQuestList.BlackListWindow:RegisterForDrag("LeftButton")
WorldQuestList.BlackListWindow:SetDontSavePosition(true)
WorldQuestList.BlackListWindow:SetScript("OnDragStart", function(self) 
	self:StartMoving() 
end)
WorldQuestList.BlackListWindow:SetScript("OnDragStop", function(self) 
	self:StopMovingOrSizing() 
end)
WorldQuestList.BlackListWindow:SetSize(500,300)

WorldQuestList.BlackListWindow:SetScript("OnShow", function(self) 
	if not self.created then
		self.created = true

		self.close = ELib:Button(self,CLOSE)
		self.close:SetSize(100,20)
		self.close:SetPoint("BOTTOM",0,5)
		self.close:SetScript("OnClick",function() self:Hide() end)

		--lazy solution
		self.S = CreateFrame("ScrollFrame", nil, self)
		self.C = CreateFrame("Frame", nil, self.S) 
		self.S:SetScrollChild(self.C)
		self.S:SetSize(470,250)
		self.C:SetSize(470,250)
		self.S:SetPoint("TOP",-7,-20)

		self.S:SetScript("OnMouseWheel",function (self,delta)
			delta = delta * 5
			local min,max = self.ScrollBar:GetMinMaxValues()
			local val = self.ScrollBar:GetValue()
			if (val - delta) < min then
				self.ScrollBar:SetValue(min)
			elseif (val - delta) > max then
				self.ScrollBar:SetValue(max)
			else
				self.ScrollBar:SetValue(val - delta)
			end  
		end)

		self.S.ScrollBar = CreateFrame("Slider", nil, self.S)
		self.S.ScrollBar:SetPoint("TOPLEFT",self.S,"TOPRIGHT",1,0)
		self.S.ScrollBar:SetPoint("BOTTOMLEFT",self.S,"BOTTOMRIGHT",1,0)
		self.S.ScrollBar:SetWidth(14)
		ELib.Templates:Border(self.S.ScrollBar,.24,.25,.30,1,1)

		self.S.ScrollBar.thumb = self.S.ScrollBar:CreateTexture(nil, "OVERLAY")
		self.S.ScrollBar.thumb:SetColorTexture(0.44,0.45,0.50,.7)
		self.S.ScrollBar.thumb:SetSize(10,20)

		self.S.ScrollBar:SetThumbTexture(self.S.ScrollBar.thumb)
		self.S.ScrollBar:SetOrientation("VERTICAL")
		self.S.ScrollBar:SetMinMaxValues(0,0)
		self.S.ScrollBar:SetValue(0)
		self.S:SetVerticalScroll(0) 

		self.S.ScrollBar:SetScript("OnValueChanged",function(_,value)
			self.S:SetVerticalScroll(value) 
		end)

		ELib.Templates:Border(self.S,.24,.25,.30,1,1)

		self.L = {}

		local function UnignoreQuest(self)
			local questID = self:GetParent().d
			if not questID then
				return
			end
			questID = questID[1]
			VWQL.Ignore[questID] = nil
			WorldQuestList_Update()
			WorldQuestList.BlackListWindow:Hide()
			WorldQuestList.BlackListWindow:Show()
		end

		self.GetLine = function(i)
			if self.L[i] then
				return self.L[i]
			end
			local line = CreateFrame("Frame",nil,self.C)
			self.L[i] = line
			line:SetPoint("TOPLEFT",0,-(i-1)*18)
			line:SetSize(470,18)

			line.n = line:CreateFontString(nil,"ARTWORK","GameFontNormal")
			line.n:SetPoint("LEFT",5,0)
			line.n:SetSize(140,18)
			line.n:SetJustifyH("LEFT")
			line.n:SetFont(line.n:GetFont(),10)

			line.z = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
			line.z:SetPoint("LEFT",line.n,"RIGHT",5,0)
			line.z:SetSize(100,18)
			line.z:SetJustifyH("LEFT")
			line.z:SetFont(line.z:GetFont(),10)

			line.t = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
			line.t:SetPoint("LEFT",line.z,"RIGHT",5,0)
			line.t:SetSize(120,18)
			line.t:SetJustifyH("LEFT")
			line.t:SetFont(line.t:GetFont(),10)

			line.d = ELib:Button(line,DELETE)
			line.d:SetSize(80,16)
			line.d:SetPoint("RIGHT",-5,0)
			line.d:SetScript("OnClick",UnignoreQuest)

			return line
		end
	end

	local list = {}
	for questID,timeAdded in pairs(VWQL.Ignore) do
		local name,factionID = C_TaskQuest.GetQuestInfoByQuestID(questID)

		local factionName
		if ( factionID ) then
			factionName = GetFactionInfoByID(factionID)
		end

		list[#list+1] = {questID,timeAdded,name or "Quest "..questID,factionName,date("%x %X",timeAdded)}
	end
	sort(list,function(a,b) return a[2]>b[2] end)

	for i=1,#list do
		local line = self.GetLine(i)
		line.n:SetText(list[i][3])
		line.z:SetText(list[i][4] or "")
		line.t:SetText(list[i][5])

		line.d = list[i]
		line:Show()
	end
	for i=#list+1,#self.L do
		self.L[i]:Hide()
	end

	self.C:SetHeight(1+#list*18)
	--self.S:SetVerticalScroll(0) 

	local maxHeight = max(0,#list*18 - 250)
	self.S.ScrollBar:SetMinMaxValues(0,maxHeight)

	local oldVal = self.S.ScrollBar:GetValue()
	self.S.ScrollBar:SetValue(min(oldVal,maxHeight))
end)


WorldQuestList.SortPriorWindow = CreateFrame("Frame",nil,UIParent,"BackdropTemplate")
WorldQuestList.SortPriorWindow:SetBackdrop({bgFile="Interface/Buttons/WHITE8X8"})
WorldQuestList.SortPriorWindow:SetBackdropColor(0.05,0.05,0.07,0.98)
WorldQuestList.SortPriorWindow.title = WorldQuestList.SortPriorWindow:CreateFontString(nil,"OVERLAY","GameFontNormal")
WorldQuestList.SortPriorWindow.title:SetPoint("TOP",0,-3)
WorldQuestList.SortPriorWindow.title:SetTextColor(1,0.66,0,1)
WorldQuestList.SortPriorWindow.title:SetText(RAID_FRAME_SORT_LABEL:gsub(" ([^ ]+)$",""))
WorldQuestList.SortPriorWindow:SetPoint("CENTER")
WorldQuestList.SortPriorWindow:Hide()
WorldQuestList.SortPriorWindow:SetFrameStrata("DIALOG")
WorldQuestList.SortPriorWindow:SetClampedToScreen(true)
WorldQuestList.SortPriorWindow:EnableMouse(true)
WorldQuestList.SortPriorWindow:SetMovable(true)
WorldQuestList.SortPriorWindow:RegisterForDrag("LeftButton")
WorldQuestList.SortPriorWindow:SetDontSavePosition(true)
WorldQuestList.SortPriorWindow:SetScript("OnDragStart", function(self) 
	self:StartMoving() 
end)
WorldQuestList.SortPriorWindow:SetScript("OnDragStop", function(self) 
	self:StopMovingOrSizing() 
end)
WorldQuestList.SortPriorWindow:SetSize(440,25)

WorldQuestList.SortPriorWindow:SetScript("OnShow", function(self) 
	if not self.created then
		self.created = true

		self.Close = CreateFrame("Button",nil,self)
		self.Close:SetPoint("TOPRIGHT",self,"TOPRIGHT",-1,-1)
		self.Close:SetSize(14,14)
		self.Close:SetScript("OnClick",function()
			self:Hide()
		end)

		self.Close.X = self.Close:CreateFontString(nil,"ARTWORK","GameFontWhite")
		self.Close.X:SetPoint("CENTER",self.Close)
		self.Close.X:SetText("X")
		do
			local a1,a2 = self.Close.X:GetFont()
			self.Close.X:SetFont(a1,12)
		end

		local list = {
			{"bounty_cache","8.3 Chest",133572},
			{"anima",WORLD_QUEST_REWARD_FILTERS_ANIMA,613397},
			{"azerite",C_CurrencyInfo.GetBasicCurrencyInfo(1553).name,C_CurrencyInfo.GetCurrencyContainerInfo(1553, 3000).icon},
			{"curr1560","|T"..C_CurrencyInfo.GetBasicCurrencyInfo(1560).icon..":18|t "..C_CurrencyInfo.GetBasicCurrencyInfo(1560).name.." / ".."|T"..C_CurrencyInfo.GetBasicCurrencyInfo(1220).icon..":18|t "..C_CurrencyInfo.GetBasicCurrencyInfo(1220).name},	--War Resources
			{"curr1508",C_CurrencyInfo.GetBasicCurrencyInfo(1508).name,C_CurrencyInfo.GetBasicCurrencyInfo(1508).icon},	--Veiled Argunite
			{"curr1533",C_CurrencyInfo.GetBasicCurrencyInfo(1533).name,C_CurrencyInfo.GetBasicCurrencyInfo(1533).icon},	--Wakening Essence
			{"curr1721",C_CurrencyInfo.GetBasicCurrencyInfo(1721).name,C_CurrencyInfo.GetBasicCurrencyInfo(1721).icon},	--Prismatic Manapearl
			{"rep",REPUTATION,WorldQuestList:AtlasToText("poi-workorders",18,18)},
			{"currother",LOCALE.rewardSortCurrOther},
			{"gold",LOCALE.gold,C_CurrencyInfo.GetCoinTextureString(10000):gsub("^1",""):gsub(":14:14:",":18:18:"),nil},
			{"itemunk",LOCALE.rewardSortItemOther},
			{"itemgear",LOCALE.gear},
			{"itemcraft","|T2065568:18|t "..LOCALE.expulsom.." / ".."|T1417744:18|t "..LOCALE.blood},
			{"honor","|T1455894:18|t "..HONOR.." / ".."|T"..C_CurrencyInfo.GetBasicCurrencyInfo(1602).icon..":18|t "..C_CurrencyInfo.GetBasicCurrencyInfo(1602).name},
			{"other",OTHER},
			{"pet",PET_BATTLE_COMBAT_LOG,WorldQuestList:AtlasToText("worldquest-icon-petbattle",18,18)},
			{"curr2815",C_CurrencyInfo.GetBasicCurrencyInfo(2815).name,C_CurrencyInfo.GetBasicCurrencyInfo(2815).icon},	--
			{"curr3008",C_CurrencyInfo.GetBasicCurrencyInfo(3008).name,C_CurrencyInfo.GetBasicCurrencyInfo(3008).icon},	--
		}
		self.buttons = {}
		for i=1,#list do
			local button = CreateFrame("Frame",nil,self)
			self.buttons[i] = button
			button:SetPoint("TOP",0,-10)
			button:SetSize(430,20)

			button.text = button:CreateFontString(nil,"ARTWORK","GameFontWhite")
			button.text:SetPoint("CENTER")
			button.text:SetJustifyV("MIDDLE")
			button.text:SetText(
				(list[i][3] and (
					type(list[i][3]) == 'number' and ("|T"..list[i][3]..":18|t ") or (list[i][3].." ")
				) or "")..
				list[i][2]
			)

			button.moveTop = CreateFrame("Button",nil,button)
			button.moveTop:SetPoint("RIGHT",-28,0)
			button.moveTop:SetSize(18,18)
			button.moveTop.tex = button.moveTop:CreateTexture(nil,"ARTWORK")
			button.moveTop.tex:SetTexture("Interface\\AddOns\\WorldQuestsList\\navButtons")
			button.moveTop.tex:SetPoint("CENTER")
			button.moveTop.tex:SetTexCoord(0,.25,1,0)
			button.moveTop.tex:SetSize(18,18)
			button.moveTop:SetScript("OnClick",function()
				if not button.prev then
					return
				end
				VWQL.SortPrio[ button.data[1] ],VWQL.SortPrio[ button.prev.data[1] ] = VWQL.SortPrio[ button.prev.data[1] ],VWQL.SortPrio[ button.data[1] ]
				self:Sort()
			end)

			button.moveBot = CreateFrame("Button",nil,button)
			button.moveBot:SetPoint("RIGHT",-5,0)
			button.moveBot:SetSize(18,18)
			button.moveBot.tex = button.moveBot:CreateTexture(nil,"ARTWORK")
			button.moveBot.tex:SetTexture("Interface\\AddOns\\WorldQuestsList\\navButtons")
			button.moveBot.tex:SetPoint("CENTER")
			button.moveBot.tex:SetTexCoord(0,.25,0,1)
			button.moveBot.tex:SetSize(18,18)
			button.moveBot:SetScript("OnClick",function()
				if not button.next then
					return
				end
				VWQL.SortPrio[ button.data[1] ],VWQL.SortPrio[ button.next.data[1] ] = VWQL.SortPrio[ button.next.data[1] ],VWQL.SortPrio[ button.data[1] ]
				self:Sort()
			end)

			ELib.Templates:Border(button,.22,.22,.3,1,1)
			button.shadow = ELib:Shadow2(button,16)

			button.back = button:CreateTexture(nil,"BACKGROUND")
			button.back:SetAllPoints()
			button.back:SetColorTexture(1,1,1,.1)
			button.back:Hide()

			button:SetScript("OnEnter",function(self) self.back:Show() self.back:SetColorTexture(1,1,1,.1) end)
			button:SetScript("OnLeave",function(self) self.back:Hide() self.back:SetColorTexture(1,1,1,.1) end)
			button.moveTop:SetScript("OnEnter",function(self) button.back:Show() self.tex:SetVertexColor(0,1,0,1) button.back:SetColorTexture(0,1,0,.1) end)
			button.moveTop:SetScript("OnLeave",function(self) button.back:Hide() self.tex:SetVertexColor(1,1,1,1) button.back:SetColorTexture(1,1,1,.1) end)
			button.moveBot:SetScript("OnEnter",function(self) button.back:Show() self.tex:SetVertexColor(1,0,0,1) button.back:SetColorTexture(1,0,0,.1) end)
			button.moveBot:SetScript("OnLeave",function(self) button.back:Hide() self.tex:SetVertexColor(1,1,1,1) button.back:SetColorTexture(1,1,1,.1) end)

			button.data = list[i]
		end

		self:SetHeight(20 + 25 * #self.buttons)

		self.Sort = function()
			local l = {}
			for i=1,#self.buttons do
				l[#l+1] = self.buttons[i]
			end
			sort(l,function(a,b) return (VWQL.SortPrio[ a.data[1] ] or defSortPrio[ a.data[1] ]) < (VWQL.SortPrio[ b.data[1] ] or defSortPrio[ b.data[1] ]) end)
			for i=1,#l do
				l[i]:SetPoint("TOP",0,-20-(i-1)*25)
				l[i].prev = l[i-1]
				l[i].next = l[i+1]
				VWQL.SortPrio[ l[i].data[1] ] = i
			end
		end
	end
	self:Sort()
end)

--Flight Map X

local FlightMap = CreateFrame("Frame")
FlightMap:RegisterEvent("ADDON_LOADED")
FlightMap:SetScript("OnEvent",function (self, event, arg)
	if arg == "Blizzard_FlightMap" then
		local X_icons = {}
		local f = CreateFrame("Frame",nil,FlightMapFrame.ScrollContainer.Child)
		f:SetPoint("TOPLEFT")
		f:SetSize(1,1)
		f:SetFrameStrata("TOOLTIP")
		f:SetScript("OnShow",function()
			f:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
			local mapID = GetTaxiMapID()
			local x_count = 0
			if mapID and (not VWQL or not VWQL.DisableTaxiX) then
				local mapQuests = C_TaskQuest.GetQuestsForPlayerByMapID(mapID)
				local questsWatched = C_QuestLog.GetNumWorldQuestWatches()
				for _,questData in pairs(mapQuests or WorldQuestList.NULLTable) do
					for i=1,questsWatched do
						local questID = C_QuestLog.GetQuestIDForQuestWatchIndex(i)
						if questID == questData.questID then
							x_count = x_count + 1
							local X_icon = X_icons[x_count]
							if not X_icon then
								X_icon = f:CreateTexture(nil,"OVERLAY")
								X_icons[x_count] = X_icon
								X_icon:SetAtlas("XMarksTheSpot")
							end
							local func = function()
								local width = FlightMapFrame.ScrollContainer.Child:GetWidth()
								local size = 24 * width / 1002
								X_icon:SetSize(size,size)
								X_icon:SetPoint("CENTER",FlightMapFrame.ScrollContainer.Child,"TOPLEFT",width * questData.x,-FlightMapFrame.ScrollContainer.Child:GetHeight() * questData.y)
								X_icon:Show()
							end
							C_Timer.After(.1,func)
							break
						end
					end
				end
			end
			for i=x_count+1,#X_icons do
				X_icons[i]:Hide()
			end
		end)
		f:SetScript("OnHide",function()
			f:UnregisterEvent("QUEST_WATCH_LIST_CHANGED")
		end)
		local prevScale = 0
		f:SetScript("OnEvent",function(self,event)
			if event == "QUEST_WATCH_LIST_CHANGED" then
				self:GetScript("OnShow")(self)
				prevScale = 0
			end
		end)
		f:SetScript("OnUpdate",function()
			local scale = FlightMapFrame.ScrollContainer.Child:GetScale()
			if scale ~= prevScale then
				prevScale = scale
				if scale < .4 then
					for i=1,#X_icons do
						X_icons[i]:SetAlpha(1)
					end
				else
					local alpha = 1 - min(max(0,scale - .4) / .4, 1)
					for i=1,#X_icons do
						X_icons[i]:SetAlpha(alpha)
					end
				end
			end
		end)

		self:UnregisterAllEvents()
	end
end)


-- Argus map
do
	local WQL_Argus_Map = CreateFromMixins(MapCanvasDataProviderMixin)

	local texturesList = {}
	local textureState = nil

	local bountyOverlayFrame

	local function CreateArgusMap()
		local size = 70
		for i=1,10 do
			for j=1,15 do
				local t = WorldMapButton:CreateTexture(nil,"BACKGROUND")
				texturesList[#texturesList + 1] = t
				t:SetSize(size,size)
				t:SetPoint("TOPLEFT",size*(j-1),-size*(i-1))
				t:SetTexture("Interface\\AdventureMap\\Argus\\AM_"..((i-1)*15 + j - 1))
				t:SetAlpha(0)
			end
		end
		CreateArgusMap = nil
	end

	local function UpdateBountyOverlayPos()
		if bountyOverlayFrame then
			WorldMapFrame:SetOverlayFrameLocation(bountyOverlayFrame, 3)
		end
	end
	local function UpdatePOIs()
		local areaPOIs = C_AreaPoiInfo.GetAreaPOIForMap(994)
		for _, areaPoiID in pairs(areaPOIs) do
			local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(994, areaPoiID)
			if poiInfo and (type(poiInfo.atlasName)~='string' or not poiInfo.atlasName:find("Vindicaar")) then
				poiInfo.dataProvider = AreaPOIDataProviderMixin
				WorldMapFrame:AcquirePin(AreaPOIDataProviderMixin:GetPinTemplate(), poiInfo)
			end
		end	  
	end
	local function UpdateTaxiNodes()
		local taxiNodes = C_TaxiMap.GetTaxiNodesForMap(994)
		local factionGroup = UnitFactionGroup("player")
		for _, taxiNodeInfo in pairs(taxiNodes) do
			if FlightPointDataProviderMixin:ShouldShowTaxiNode(factionGroup, taxiNodeInfo) and (type(taxiNodeInfo.textureKitPrefix)~='string' or not taxiNodeInfo.textureKitPrefix:find("Vindicaar")) then
				WorldMapFrame:AcquirePin("FlightPointPinTemplate", taxiNodeInfo)
			end
		end
	end

	function WQL_Argus_Map:RefreshAllData()
		if not VWQL or VWQL.ArgusMap then
			if textureState then
				for i=1,#texturesList do
					texturesList[i]:SetAlpha(0)
				end
				self:UnregisterEvent("QUEST_LOG_UPDATE")
				self:UnregisterEvent("AREA_POIS_UPDATED")
				textureState = nil
			end
			return
		end
		local mapID = self:GetMap():GetMapID()
		if mapID == 905 then
			if CreateArgusMap then 
				CreateArgusMap()
			end
			if not textureState then
				for i=1,#texturesList do
					texturesList[i]:SetAlpha(1)
				end
				self:RegisterEvent("QUEST_LOG_UPDATE")
				self:RegisterEvent("AREA_POIS_UPDATED")
				textureState = true
			end
			if not bountyOverlayFrame then
				for _,frame in pairs(WorldMapFrame.overlayFrames) do
					if frame.ShowBountyTooltip then
						bountyOverlayFrame = frame
						break
					end
				end
			end

			--Some ugly code here
			UpdateBountyOverlayPos()
			C_Timer.After(0,UpdateBountyOverlayPos)

			UpdatePOIs()
			C_Timer.After(0,UpdatePOIs)

			UpdateTaxiNodes()
			C_Timer.After(0,UpdateTaxiNodes)
		elseif textureState then
			for i=1,#texturesList do
				texturesList[i]:SetAlpha(0)
			end
			self:UnregisterEvent("QUEST_LOG_UPDATE")
			self:UnregisterEvent("AREA_POIS_UPDATED")
			textureState = nil
		end
	end

	function WQL_Argus_Map:OnEvent(event, ...)
		if event == "QUEST_LOG_UPDATE" and WorldMapFrame:IsVisible() and WorldMapFrame:GetMapID() == 905 then
			UpdateBountyOverlayPos()
			C_Timer.After(0,UpdateBountyOverlayPos)
		elseif event == "AREA_POIS_UPDATED" and WorldMapFrame:IsVisible() and WorldMapFrame:GetMapID() == 905 then
			UpdatePOIs()
			C_Timer.After(0,UpdatePOIs)
		end
	end

	WQL_Argus_Map.WQL_Signature = true

	local isRegistered = false
	function WorldQuestList:RegisterArgusMap()
		if isRegistered then
			return
		end
		WorldMapFrame:AddDataProvider(WQL_Argus_Map)
		isRegistered = true
		WQL_Argus_Map:RefreshAllData()
	end
end

-- TreasureData

WorldQuestList.TreasureData = WQLdb.TreasureData or {}

--- LFG features


local QuestCreationBox = CreateFrame("Button","WQL_QuestCreationBox",UIParent)
QuestCreationBox:SetSize(350,120)
QuestCreationBox:SetPoint("CENTER",0,250)
QuestCreationBox:SetMovable(false)
QuestCreationBox:EnableMouse(true)
QuestCreationBox:SetClampedToScreen(true)
QuestCreationBox:RegisterForDrag("LeftButton")
QuestCreationBox:RegisterForClicks("RightButtonUp")
QuestCreationBox:Hide()

QuestCreationBox:SetScript("OnClick",function(self)
	self:Hide()
end)

--tinsert(UISpecialFrames, "WQL_QuestCreationBox")

WorldQuestList.QuestCreationBox = QuestCreationBox

QuestCreationBox.b = QuestCreationBox:CreateTexture(nil,"BACKGROUND")
QuestCreationBox.b:SetAllPoints()
QuestCreationBox.b:SetColorTexture(0.04,0.04,0.04,.97)
QuestCreationBox.b.A = .97

QuestCreationBox.Text1 = QuestCreationBox:CreateFontString(nil,"ARTWORK","GameFontWhite")
QuestCreationBox.Text1:SetPoint("TOP",0,-5)
do
	local a1,a2 = QuestCreationBox.Text1:GetFont()
	QuestCreationBox.Text1:SetFont(a1,12)
end

QuestCreationBox.Text2 = QuestCreationBox:CreateFontString(nil,"ARTWORK","GameFontWhite")
QuestCreationBox.Text2:SetPoint("TOP",0,-25)
QuestCreationBox.Text2:SetTextColor(0,1,0)
do
	local a1,a2 = QuestCreationBox.Text2:GetFont()
	QuestCreationBox.Text2:SetFont(a1,20)
end

QuestCreationBox.Close = CreateFrame("Button",nil,QuestCreationBox)
QuestCreationBox.Close:SetPoint("TOPRIGHT")
QuestCreationBox.Close:SetSize(22,22)
QuestCreationBox.Close:SetScript("OnClick",function()
	QuestCreationBox:Hide()
end)

ELib.Templates:Border(QuestCreationBox.Close,.22,.22,.3,1,1)

QuestCreationBox.Close.X = QuestCreationBox.Close:CreateFontString(nil,"ARTWORK","GameFontWhite")
QuestCreationBox.Close.X:SetPoint("CENTER",QuestCreationBox.Close)
QuestCreationBox.Close.X:SetText("X")
do
	local a1,a2 = QuestCreationBox.Close.X:GetFont()
	QuestCreationBox.Close.X:SetFont(a1,14)
end

QuestCreationBox.PartyLeave = ELib:Button(QuestCreationBox,PARTY_LEAVE)
QuestCreationBox.PartyLeave:SetSize(220,25)
QuestCreationBox.PartyLeave:SetPoint("BOTTOM",0,5)
QuestCreationBox.PartyLeave:SetScript("OnClick",function()
	local n = GetNumGroupMembers() or 0
	if n == 0 then
		if C_LFGList.GetActiveEntryInfo() then
			C_LFGList.RemoveListing()
		end
	else
		C_PartyInfo.LeaveParty()
	end
	QuestCreationBox:Hide()
end)
QuestCreationBox.PartyLeave:Hide()


QuestCreationBox.PartyFind = ELib:Button(QuestCreationBox,FIND_A_GROUP)
QuestCreationBox.PartyFind:SetSize(220,22)
QuestCreationBox.PartyFind:SetPoint("BOTTOM",0,5)
QuestCreationBox.PartyFind:SetScript("OnClick",function(self,button)
	QuestCreationBox:Hide()
	if C_LFGList.CanCreateQuestGroup(self.questID) then
		LFGListUtil_FindQuestGroup(self.questID, true)	--taint error
	elseif button == "RightButton" then
		WorldQuestList.LFG_StartQuest(self.questID)
	else
		WorldQuestList.LFG_Search(self.questID)
	end
end)
QuestCreationBox.PartyFind:Hide()

QuestCreationBox.ListGroup = ELib:Button(QuestCreationBox,FIND_A_GROUP)
QuestCreationBox.ListGroup:SetSize(220,25)
QuestCreationBox.ListGroup:SetPoint("BOTTOM",0,5)
QuestCreationBox.ListGroup:Hide()
QuestCreationBox.ListGroup:SetText(LIST_GROUP)

QuestCreationBox.FindGroup = ELib:Button(QuestCreationBox,SEARCH)
QuestCreationBox.FindGroup:SetSize(220,25)
QuestCreationBox.FindGroup:SetPoint("BOTTOM",0,5)
QuestCreationBox.FindGroup:Hide()
QuestCreationBox.FindGroup:SetText(SEARCH)

QuestCreationBox:SetScript("OnDragStart", function(self)
	self:SetMovable(true)
	self:StartMoving()
end)
QuestCreationBox:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	self:SetMovable(false)

	if VWQL then
		VWQL.AnchorQCBLeft = self:GetLeft()
		VWQL.AnchorQCBTop = self:GetTop() 
	end
end)
QuestCreationBox:SetScript("OnUpdate",function(self)
	if QuestCreationBox.type == 4 and LFGListFrame.SearchPanel.SearchBox:GetText():lower() == QuestCreationBox.Text2:GetText():lower() then
		QuestCreationBox.Text2:SetTextColor(0,1,0)
	elseif QuestCreationBox.type ~= 4 and LFGListFrame.EntryCreation.Name:GetText() == QuestCreationBox.Text2:GetText() then
		QuestCreationBox.Text2:SetTextColor(0,1,0)
	else
		QuestCreationBox.Text2:SetTextColor(1,1,0)
	end
end)

ELib.Templates:Border(QuestCreationBox,.22,.22,.3,1,1)
QuestCreationBox.shadow = ELib:Shadow2(QuestCreationBox,16)

local defPoints
local defPointsSearch

local minIlvlReq = UnitLevel'player' >= 60 and 120 or 50

function WQL_LFG_StartQuest(questID)
	if GroupFinderFrame:IsShown() or C_LFGList.GetActiveEntryInfo() then
		return
	end

	local edit = LFGListFrame.EntryCreation.Name
	local button = QuestCreationBox.ListGroup
	local check = LFGListFrame.ApplicationViewer.AutoAcceptButton

	QuestCreationBox:Show()
	QuestCreationBox:SetSize(350,120)
	QuestCreationBox.PartyLeave:Hide()
	QuestCreationBox.PartyFind:Hide()
	QuestCreationBox.FindGroup:Hide()
	QuestCreationBox.ListGroup:Show()

	LFGListUtil_OpenBestWindow()

	PVEFrame:ClearAllPoints() 
	PVEFrame:SetPoint("TOP",UIParent,"BOTTOM",0,-100)

	local autoCreate = nil
	if tostring(questID) == edit:GetText() then
		LFGListEntryCreation_SetEditMode(LFGListFrame.EntryCreation, false)
		LFGListEntryCreation_UpdateValidState(LFGListFrame.EntryCreation)
		LFGListFrame_SetActivePanel(LFGListFrame.EntryCreation:GetParent(), LFGListFrame.EntryCreation)
		autoCreate = true
	else
		--LFGListEntryCreation_Show(LFGListFrame.EntryCreation, LFGListFrame.baseFilters, 1, 0)
	end

	local activityID, categoryID, filters, questName = LFGListUtil_GetQuestCategoryData(questID)
	if activityID then
		LFGListEntryCreation_Select(LFGListFrame.EntryCreation, filters, categoryID, nil, activityID)
	end

	if not defPoints and false then
		defPoints = {
			[edit] = {edit:GetPoint()},
		}
		button:SetScript("OnClick",function()
			if not QuestCreationBox:IsShown() or edit:GetText() == "" then
				return
			end

			local playerIlvl = GetAverageItemLevel()
			local itemLevel = minIlvlReq > playerIlvl and floor(playerIlvl) or minIlvlReq
			local honorLevel = 0
			local autoAccept = true
			local privateGroup = false

			LFGListEntryCreation_ListGroupInternal(LFGListFrame.EntryCreation, LFGListFrame.EntryCreation.selectedActivity, itemLevel, autoAccept, privateGroup, questID, 0, 0, 0)
			--C_LFGList.CreateListing(activityID, itemLevel, honorLevel, autoAccept, privateGroup, questID)

			edit:ClearAllPoints()
			edit:SetPoint(unpack(defPoints[edit]))
			edit.Instructions:SetText(LFG_LIST_ENTER_NAME)

			PVEFrame_ToggleFrame()
			QuestCreationBox:Hide()

			if LFGListFrame:IsVisible() then
				PVEFrame_ToggleFrame()
			end
		end)
		edit:HookScript("OnEnterPressed",function()
			if not QuestCreationBox:IsShown() then
				return
			end

			button:Click()
		end)
	end

	QuestCreationBox.Text1:SetText("WQL: "..LOCALE.lfgTypeText)
	QuestCreationBox.Text2:SetText(questID)
	QuestCreationBox.questID = questID
	QuestCreationBox.type = 1

	edit:ClearAllPoints()
	edit:SetPoint("TOP",QuestCreationBox,"TOP",0,-50)
	edit.Instructions:SetText(questID)
	if IsPlayerMoving() then
		edit:ClearFocus()
	end

	local apps = C_LFGList.GetApplications()
	for i=1, #apps do
		C_LFGList.CancelApplication(apps[i])
	end

	if autoCreate then
		button:Click()
	end
end
WorldQuestList.LFG_StartQuest = WQL_LFG_StartQuest

--[[
LFGListFrame.EntryCreation:HookScript("OnShow",function()
	if not defPoints then
		return
	end
	local edit = LFGListFrame.EntryCreation.Name

	edit:ClearAllPoints()
	edit:SetPoint(unpack(defPoints[edit]))
	edit.Instructions:SetText(LFG_LIST_ENTER_NAME)
end)
]]

QuestCreationBox:SetScript("OnHide",function()
	if defPoints then
		local edit = LFGListFrame.EntryCreation.Name

		edit:ClearAllPoints()
		edit:SetPoint(unpack(defPoints[edit]))
		edit.Instructions:SetText(LFG_LIST_ENTER_NAME)

		edit:ClearFocus()
	end

	if defPointsSearch then
		local edit = LFGListFrame.SearchPanel.SearchBox

		edit:ClearAllPoints()
		edit:SetPoint(unpack(defPointsSearch[edit]))
		edit.Instructions:SetText(FILTER)

		edit:ClearFocus()

		local fb = LFGListFrame.SearchPanel.FilterButton

		fb:ClearAllPoints()
		fb:SetPoint(unpack(defPointsSearch[fb]))
	end

	if QuestCreationBox.type == 1 or QuestCreationBox.type == 4 then
		if GroupFinderFrame:IsVisible() then
			PVEFrame_ToggleFrame()
		end
	end
end)

local searchQuestID = nil
local isAfterSearch = nil
local autoCreateQuestID = nil

function WQL_LFG_Search(questID)
	searchQuestID = nil

	if C_LFGList.GetActiveEntryInfo() then
		return
	end

	if not GroupFinderFrame:IsVisible() then
		LFGListUtil_OpenBestWindow()
	end

	PVEFrame:ClearAllPoints() 
	PVEFrame:SetPoint("TOP",UIParent,"BOTTOM",0,-100)

	local edit = LFGListFrame.SearchPanel.SearchBox
	local fb = LFGListFrame.SearchPanel.FilterButton
	local button = QuestCreationBox.FindGroup

	if not defPointsSearch then
		defPointsSearch = {
			[edit] = {edit:GetPoint()},
			[fb] = {fb:GetPoint()},
		}
		button:SetScript("OnClick",function()
			QuestCreationBox:Hide()
			PVEFrame_ToggleFrame()

			edit:GetScript("OnEnterPressed")(edit)

			searchQuestID = edit.WQL_questID
		end)
		edit:HookScript("OnEnterPressed",function(self)
			if not QuestCreationBox:IsShown() then
				return
			end

			QuestCreationBox:Hide()
			PVEFrame_ToggleFrame()

			searchQuestID = self.WQL_questID
		end)
	end


	local languagesOn = C_LFGList.GetLanguageSearchFilter()
	local languagesAll = C_LFGList.GetAvailableLanguageSearchFilter()
	local languagesCount = 0
	for _ in pairs(languagesOn) do languagesCount = languagesCount + 1 end
	if languagesCount ~= #languagesAll then
	        local languages = {}
	        for _,lang in pairs(languagesAll) do 
	        	languages[lang]=true 
	        end
		C_LFGList.SaveLanguageSearchFilter(languages)
	end

	local panel = LFGListFrame.CategorySelection
	LFGListFrame_SetActivePanel(LFGListFrame, panel)
	LFGListCategorySelection_SelectCategory(panel, 1, 0)

	local autoSearch = nil
	if tostring(questID) == edit:GetText() then
		--copy of LFGListCategorySelection_StartFindGroup
		local baseFilters = panel:GetParent().baseFilters

		local searchPanel = panel:GetParent().SearchPanel
		C_LFGList.ClearSearchResults()
		searchPanel.selectedResult = nil
		LFGListSearchPanel_UpdateResultList(searchPanel)
		LFGListSearchPanel_UpdateResults(searchPanel)
		LFGListSearchPanel_SetCategory(searchPanel, panel.selectedCategory, panel.selectedFilters, baseFilters)
		LFGListSearchPanel_DoSearch(searchPanel)
		LFGListFrame_SetActivePanel(panel:GetParent(), searchPanel)
		autoSearch = true
	else
		LFGListCategorySelection_StartFindGroup(panel, QuestCreationBox.questID)
	end

	QuestCreationBox:Show()
	QuestCreationBox:SetSize(350,120)
	QuestCreationBox.PartyLeave:Hide()
	QuestCreationBox.PartyFind:Hide()
	QuestCreationBox.ListGroup:Hide()
	QuestCreationBox.FindGroup:Show()

	QuestCreationBox.Text1:SetText(SEARCH..": "..LOCALE.lfgTypeText)
	QuestCreationBox.Text2:SetText(questID)
	QuestCreationBox.questID = questID
	QuestCreationBox.type = 4

	edit:ClearAllPoints()
	edit:SetPoint("TOP",QuestCreationBox,"TOP",0,-50)
	edit.Instructions:SetText(questID)
	edit:SetFocus()
	if IsPlayerMoving() then
		edit:ClearFocus()
	end

	edit.WQL_questID = questID

	fb:ClearAllPoints()
	fb:SetPoint("TOP",UIParent,"BOTTOM",0,-100)

	searchQuestID = questID

	if type(questID)=='number' then
		local questName = C_TaskQuest.GetQuestInfoByQuestID(questID)
		if not questName then
			questName = GetQuestLogTitle(C_QuestLog.GetLogIndexForQuestID(questID))
		end

		if questName and IsShiftKeyDown() then
			QuestCreationBox.Text2:SetText(questName)
		end
		if questName then
			edit.Instructions:SetText(questID..", "..questName)
		end
	end

	if autoSearch then
		button:Click()
	end

end
WorldQuestList.LFG_Search = WQL_LFG_Search

--[[
LFGListFrame.SearchPanel:HookScript("OnShow",function()
	if not defPointsSearch then
		return
	end
	local edit = LFGListFrame.SearchPanel.SearchBox
	local fb = LFGListFrame.SearchPanel.FilterButton

	edit:ClearAllPoints()
	edit:SetPoint(unpack(defPointsSearch[edit]))
	edit.Instructions:SetText(FILTER)

	fb:ClearAllPoints()
	fb:SetPoint(unpack(defPointsSearch[fb]))
end)
]]

local function IsTeoreticalWQ(name)
	if name and name:find("k00000|") then
		return true
	end
end

--[[
hooksecurefunc("LFGListSearchPanel_SelectResult", function(self, resultID)
	if not VWQL or VWQL.DisableLFG then
		return
	end
	local data = C_LFGList.GetSearchResultInfo(resultID)
	if data and data.name and LFGListFrame.SearchPanel.categoryID == 1 then
		LFGListFrame.SearchPanel.SignUpButton:Click()
		LFGListApplicationDialog.SignUpButton:Click()
	end
end)

hooksecurefunc("LFGListGroupDataDisplayPlayerCount_Update", function(self, displayData, disabled)
	local line = self:GetParent():GetParent()
	local numPlayers = displayData.TANK + displayData.HEALER + displayData.DAMAGER + displayData.NOROLE
	if disabled or not line or not line.resultID or numPlayers ~= 5 then
		return
	end
	local data = C_LFGList.GetSearchResultInfo(line.resultID)
	if data and data.name and LFGListFrame.SearchPanel.categoryID == 1 then
		self.Count:SetText("|cffff0000"..numPlayers)
	end
end)
]]


WorldQuestList.LFG_LastResult = {}

QuestCreationBox.PopupBlacklist = WQLdb.WorldQuestPopupBlacklist or {}

local function CheckQuestPassPopup(questID)
	local _,_,worldQuestType = GetQuestTagInfo(questID)
	if (worldQuestType == LE_QUEST_TAG_TYPE_DUNGEON) or
		(worldQuestType == LE_QUEST_TAG_TYPE_RAID) or
		(worldQuestType == LE_QUEST_TAG_TYPE_PET_BATTLE) 
	then
		return false
	end

	local _, zoneType = IsInInstance()
	if zoneType == "arena" or zoneType == "raid" or zoneType == "party" then
		return false
	end

	if QuestCreationBox.PopupBlacklist[questID] then
		return false
	end

	return true
end

function WorldQuestList:IsQuestDisabledForLFG(questID)
	if QuestCreationBox.PopupBlacklist[questID or 0] then
		return true
	else
		return false
	end
end

local LFGListFrameSearchPanelStartGroup = CreateFrame("Button",nil,LFGListFrame.SearchPanel,"UIPanelButtonTemplate")
LFGListFrameSearchPanelStartGroup:SetPoint("LEFT",LFGListFrame.SearchPanel.BackButton,"RIGHT")
LFGListFrameSearchPanelStartGroup:SetPoint("RIGHT",LFGListFrame.SearchPanel.SignUpButton,"LEFT")
LFGListFrameSearchPanelStartGroup:SetHeight(22)
LFGListFrameSearchPanelStartGroup:SetText(START_A_GROUP)
LFGListFrameSearchPanelStartGroup:SetScript("OnClick",function(self)
	if self.questID then
		PVEFrame_ToggleFrame()
		WQL_LFG_StartQuest(self.questID)
	end
end)

local LFGListFrameSearchPanelBackButtonSavedSize,LFGListFrameSearchPanelSignUpButtonSavedSize
C_Timer.After(1,function()
	LFGListFrameSearchPanelBackButtonSavedSize,LFGListFrameSearchPanelSignUpButtonSavedSize = LFGListFrame.SearchPanel.BackButton:GetWidth(),LFGListFrame.SearchPanel.SignUpButton:GetWidth()
end)

LFGListFrameSearchPanelStartGroup:SetScript("OnShow",function(self)
	LFGListFrame.SearchPanel.BackButton:SetWidth(110)
	LFGListFrame.SearchPanel.SignUpButton:SetWidth(110)
	if not self.isSkinned then
		self.isSkinned = true
		if ElvUI and ElvUI[1] and ElvUI[1].GetModule then
			local S = ElvUI[1]:GetModule('Skins')
			if S then
				S:HandleButton(self, true)
			end
		end
	end
end)
LFGListFrameSearchPanelStartGroup:SetScript("OnHide",function()
	LFGListFrame.SearchPanel.BackButton:SetWidth(LFGListFrameSearchPanelBackButtonSavedSize or 135)
	LFGListFrame.SearchPanel.SignUpButton:SetWidth(LFGListFrameSearchPanelSignUpButtonSavedSize or 135)
end)

local LFGListFrameSearchPanelShowerFrame = CreateFrame("Frame",nil,LFGListFrame.SearchPanel)
LFGListFrameSearchPanelShowerFrame:SetPoint("TOPLEFT")
LFGListFrameSearchPanelShowerFrame:SetSize(1,1)
LFGListFrameSearchPanelShowerFrame:SetScript("OnShow",function()
	LFGListFrameSearchPanelStartGroup:Hide()
end)
LFGListFrameSearchPanelShowerFrame:SetScript("OnHide",function()
	LFGListFrameSearchPanelStartGroup:Hide()
end)


local LFGListFrameSearchPanelTryWithQuestID = CreateFrame("Button",nil,LFGListFrame.EntryCreation,"UIPanelButtonTemplate")
LFGListFrameSearchPanelTryWithQuestID:SetPoint("LEFT",LFGListFrame.EntryCreation.CancelButton,"RIGHT")
LFGListFrameSearchPanelTryWithQuestID:SetPoint("RIGHT",LFGListFrame.EntryCreation.ListGroupButton,"LEFT")
LFGListFrameSearchPanelTryWithQuestID:SetHeight(22)
LFGListFrameSearchPanelTryWithQuestID:SetText(LOCALE.tryWithQuestID)
LFGListFrameSearchPanelTryWithQuestID:SetScript("OnClick",function(self)
	if self.questID then
		WorldQuestList.LFG_Search(self.questID)
	end
end)

local LFGListFrameEntryCreationCancelButtonSavedSize,LFGListFrameEntryCreationListGroupButtonSavedSize
C_Timer.After(1,function()
	LFGListFrameEntryCreationCancelButtonSavedSize,LFGListFrameEntryCreationListGroupButtonSavedSize = LFGListFrame.EntryCreation.CancelButton:GetWidth(),LFGListFrame.EntryCreation.ListGroupButton:GetWidth()
end)

LFGListFrameSearchPanelTryWithQuestID:SetScript("OnShow",function(self)
	LFGListFrame.EntryCreation.CancelButton:SetWidth(110)
	LFGListFrame.EntryCreation.ListGroupButton:SetWidth(110)
	if not self.isSkinned then
		self.isSkinned = true
		if ElvUI and ElvUI[1] and ElvUI[1].GetModule then
			local S = ElvUI[1]:GetModule('Skins')
			if S then
				S:HandleButton(self, true)
			end
		end
	end
end)
LFGListFrameSearchPanelTryWithQuestID:SetScript("OnHide",function()
	LFGListFrame.EntryCreation.CancelButton:SetWidth(LFGListFrameEntryCreationCancelButtonSavedSize or 135)
	LFGListFrame.EntryCreation.ListGroupButton:SetWidth(LFGListFrameEntryCreationListGroupButtonSavedSize or 135)
end)

local LFGListFrameEntryCreationShowerFrame = CreateFrame("Frame",nil,LFGListFrame.EntryCreation)
LFGListFrameEntryCreationShowerFrame:SetPoint("TOPLEFT")
LFGListFrameEntryCreationShowerFrame:SetSize(1,1)
LFGListFrameEntryCreationShowerFrame:SetScript("OnShow",function()
	LFGListFrameSearchPanelTryWithQuestID:Hide()
end)
LFGListFrameEntryCreationShowerFrame:SetScript("OnHide",function()
	LFGListFrameSearchPanelTryWithQuestID:Hide()
end)


--[[
QuestCreationBox:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
QuestCreationBox:RegisterEvent("LFG_LIST_APPLICANT_LIST_UPDATED")
QuestCreationBox:RegisterEvent("PARTY_INVITE_REQUEST")
QuestCreationBox:RegisterEvent("QUEST_TURNED_IN")
QuestCreationBox:RegisterEvent("QUEST_ACCEPTED")
QuestCreationBox:RegisterEvent("QUEST_REMOVED")
QuestCreationBox:RegisterEvent("PARTY_LEADER_CHANGED")
QuestCreationBox:RegisterEvent("GROUP_ROSTER_UPDATE")
]]
QuestCreationBox:SetScript("OnEvent",function (self,event,arg1,arg2)
	if event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" then
		--if LFGListFrameSearchPanelStartGroup:IsShown() then
		--	LFGListFrameSearchPanelStartGroup:Hide()
		--end
		local total,results = C_LFGList.GetSearchResults()
		if total == 0 and searchQuestID and (VWQL and not VWQL.DisableLFG) then
			isAfterSearch = true
		else
			isAfterSearch = nil
			searchQuestID = nil
		end

		if LFGListFrame.SearchPanel.SearchBox:IsVisible() and LFGListFrame.SearchPanel.categoryID == 1 then
			local searchQ = LFGListFrame.SearchPanel.SearchBox:GetText()
			searchQ = tonumber(searchQ)
			if searchQ and searchQ > 10000 and searchQ < 1000000 then
		--		LFGListFrameSearchPanelStartGroup.questID = searchQ
		--		LFGListFrameSearchPanelStartGroup:Show()
			end
		end

		autoCreateQuestID = nil
		if LFGListFrame.EntryCreation.autoCreateActivityType == "quest" and LFGListFrame.SearchPanel.categoryID == 1 then
			local questID = LFGListFrame.EntryCreation.autoCreateContextID
			if type(questID) == 'number' and questID > 10000 and questID < 1000000 then
				local name = C_TaskQuest.GetQuestInfoByQuestID(questID)
				if name == LFGListFrame.SearchPanel.SearchBox:GetText() then
					autoCreateQuestID = questID
				end
			end
		end
	elseif event == "LFG_LIST_APPLICANT_LIST_UPDATED" then
		if not VWQL or VWQL.DisableLFG or not UnitIsGroupLeader("player", LE_PARTY_CATEGORY_HOME) then
			return
		end
		local data = C_LFGList.GetActiveEntryInfo()
		if data then
			if data.activityID then
				local activityInfo = C_LFGList.GetActivityInfoTable(data.activityID)
				if not activityInfo or activityInfo.categoryID ~= 1 then
					return
				end
			end
			--StaticPopup_Hide("LFG_LIST_AUTO_ACCEPT_CONVERT_TO_RAID")

			if not data.autoAccept and
				(  GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) + C_LFGList.GetNumInvitedApplicantMembers() + C_LFGList.GetNumPendingApplicantMembers() <= 5  )
			then
				local applicants = C_LFGList.GetApplicants()
				for _,applicantID in pairs(applicants) do
					local applicantData = C_LFGList.GetApplicantInfo(applicantID)
					if applicantData and applicantData.applicationStatus == "applied" and applicantData.numMembers == 1 then
						for memberIdx=1,applicantData.numMembers do
							local name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage, assignedRole = C_LFGList.GetApplicantMemberInfo(applicantID, memberIdx)
							if name then
								C_PartyInfo.InviteUnit(name)
							end
						end
					end
				end
			end
		end
	elseif event == "PARTY_LEADER_CHANGED" then
		if not VWQL or VWQL.DisableLFG or not UnitIsGroupLeader("player", LE_PARTY_CATEGORY_HOME) or not C_LFGList.GetActiveEntryInfo() then
			return
		end
		self:GetScript("OnEvent")(self,"LFG_LIST_APPLICANT_LIST_UPDATED")
	elseif event == "PARTY_INVITE_REQUEST" then
		local name = arg1
		if name then
			local app = C_LFGList.GetApplications()
			for _,id in pairs(app) do
				local searchResultInfo = C_LFGList.GetSearchResultInfo(id)
				if searchResultInfo and name == searchResultInfo.leaderName then
					AcceptGroup()
					StaticPopupSpecial_Hide(LFGInvitePopup)
					for i = 1, 4 do
						local frame = _G["StaticPopup"..i]
						if frame:IsVisible() and frame.which=="PARTY_INVITE" then
							frame.inviteAccepted = true
							StaticPopup_Hide("PARTY_INVITE")
							return
						elseif frame:IsVisible() and frame.which=="PARTY_INVITE_XREALM" then
							frame.inviteAccepted = true
							StaticPopup_Hide("PARTY_INVITE_XREALM")
							return
						end
					end
				end
			end
		end
	elseif event == "QUEST_TURNED_IN" then
		if not VWQL or VWQL.DisableLFG or not arg1 or VWQL.DisableLFG_PopupLeave then
			return
		end
		if (C_LFGList.GetActiveEntryInfo() or LFGListFrame.SearchPanel.SearchBox:GetText()==tostring(arg1)) and 
			QuestUtils_IsQuestWorldQuest(arg1) and 
			CheckQuestPassPopup(arg1) and 
			(not QuestCreationBox:IsShown() or (QuestCreationBox.type ~= 1 and QuestCreationBox.type ~= 4) or (QuestCreationBox.type == 1 and QuestCreationBox.questID == arg1) or (QuestCreationBox.type == 4 and QuestCreationBox.questID == arg1)) and 
			(GetNumGroupMembers() or 0) > 1 
		then
			local data = C_LFGList.GetActiveEntryInfo()
			if data and data.activityID then
				local activityInfo = C_LFGList.GetActivityInfoTable(data.activityID)
				if not activityInfo or activityInfo.categoryID ~= 1 then
					return
				end
			end

			QuestCreationBox.Text1:SetText("WQL")
			QuestCreationBox.Text2:SetText("")
			QuestCreationBox.PartyLeave:Show()

			QuestCreationBox.PartyFind:Hide()
			QuestCreationBox.ListGroup:Hide()
			QuestCreationBox.FindGroup:Hide()

			QuestCreationBox.type = 2

			QuestCreationBox:Show()
			QuestCreationBox:SetSize(350,60)
		end
	elseif event == "QUEST_ACCEPTED" then
		if WorldQuestList.ObjectiveTracker_Update_hook then
			WorldQuestList.ObjectiveTracker_Update_hook(2)
		end
		if not VWQL or VWQL.DisableLFG or not arg1 or C_LFGList.GetActiveEntryInfo() or VWQL.DisableLFG_Popup or (GetNumGroupMembers() or 0) > 1 then
			return
		end
		if true then	--disabled at all
			return
		end
		if QuestUtils_IsQuestWorldQuest(arg1) and 					--is WQ
			(not QuestCreationBox:IsShown() or (QuestCreationBox.type ~= 1 and QuestCreationBox.type ~= 4)) and	--popup if not busy
			 CheckQuestPassPopup(arg1) 						--wq pass filters
		 then
			QuestCreationBox.Text1:SetText("WQL|n"..(C_TaskQuest.GetQuestInfoByQuestID(arg1) or ""))
			QuestCreationBox.Text2:SetText("")
			QuestCreationBox.PartyFind.questID = arg1
			QuestCreationBox.PartyFind:Show()

			QuestCreationBox.PartyLeave:Hide()
			QuestCreationBox.ListGroup:Hide()
			QuestCreationBox.FindGroup:Hide()

			QuestCreationBox.questID = arg1
			QuestCreationBox.type = 3

			QuestCreationBox:Show()
			QuestCreationBox:SetSize(350,60)
		end
	elseif event == "QUEST_REMOVED" then
		if WorldQuestList.ObjectiveTracker_Update_hook then
			WorldQuestList.ObjectiveTracker_Update_hook(2)
		end
		if QuestCreationBox:IsShown() and QuestCreationBox.type == 3 and QuestCreationBox.questID == arg1 then
			QuestCreationBox:Hide()
		end
	elseif event == "GROUP_ROSTER_UPDATE" then
		if GetNumGroupMembers() == 0 and QuestCreationBox:IsShown() and QuestCreationBox.type == 2 and not C_LFGList.GetActiveEntryInfo() then
			QuestCreationBox:Hide()
		end
	end
end)

if false then
	local button = LFGListSearchPanelScrollFrame.ScrollChild and LFGListSearchPanelScrollFrame.ScrollChild.StartGroupButton or LFGListSearchPanelScrollFrame.StartGroupButton
	button:HookScript("OnClick",function()
		if isAfterSearch then
			PVEFrame_ToggleFrame()
			WQL_LFG_StartQuest(searchQuestID)
		elseif autoCreateQuestID then
			C_Timer.After(.5,function()
				if not C_LFGList.GetActiveEntryInfo() and GroupFinderFrame:IsVisible() and LFGListFrame.EntryCreation:IsVisible() then
					if autoCreateQuestID then
						LFGListFrameSearchPanelTryWithQuestID.questID = autoCreateQuestID
						LFGListFrameSearchPanelTryWithQuestID:Show()
					end
					autoCreateQuestID = nil
				end
			end)
		end
		isAfterSearch = nil
		searchQuestID = nil
	end)
	button:HookScript("OnHide",function()
		if isAfterSearch then
			C_Timer.After(0.1,function()
				isAfterSearch = nil
				searchQuestID = nil
			end)
		end
	end)
end


local objectiveTrackerButtons = {}
WorldQuestList.LFG_objectiveTrackerButtons = objectiveTrackerButtons
local objectiveTrackerMainFrame = CreateFrame("Frame",nil,UIParent)
objectiveTrackerMainFrame:SetPoint("TOPRIGHT")
objectiveTrackerMainFrame:SetSize(1,1)

local function objectiveTrackerButtons_OnClick(self,button)
	if C_LFGList.GetActiveEntryInfo() and tostring(self.questID) == LFGListFrame.EntryCreation.Name:GetText() then
		return
	elseif tostring(self.questID) == LFGListFrame.EntryCreation.Name:GetText() then
		WorldQuestList.LFG_StartQuest(self.questID)
		return
	end
	if C_LFGList.GetActiveEntryInfo() or ((GetNumGroupMembers() or 0) > 1 and not UnitIsGroupLeader("player")) then
		StaticPopupDialogs["WQL_LFG_LEAVE"] = {
			text = PARTY_LEAVE,
			button1 = YES,
			button2 = NO,
			OnAccept = function()
				C_PartyInfo.LeaveParty()
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 3,
		}
		StaticPopup_Show("WQL_LFG_LEAVE")
		return
	end
	if button == "RightButton" then
		WorldQuestList.LFG_StartQuest(self.questID)
	else
		WorldQuestList.LFG_Search(self.questID)
	end
end

local function objectiveTrackerButtons_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:AddLine("WQL: "..LOOK_FOR_GROUP)
	GameTooltip:AddLine(LOCALE.lfgLeftButtonClick,1,1,1)
	GameTooltip:AddLine(LOCALE.lfgLeftButtonClick2,1,1,1)
	GameTooltip:AddLine(LOCALE.lfgRightButtonClick,1,1,1)
	GameTooltip:Show()
end
local function objectiveTrackerButtons_OnLeave(self)
	GameTooltip_Hide()
end
local function objectiveTrackerButtons_OnUpdate(self)
	if not self.parent:IsVisible() then
		self:Hide()
	end
end

local function IsQuestValidForEye(questID)
	if type(questID) == "number" and questID <= 10000000 and questID > 0 then
		return QuestUtils_IsQuestWorldQuest(questID) or (WQLdb.WorldQuestBfAAssaultQuests[questID or 0] and not IsQuestComplete(questID or 0))
	end
end

local function ObjectiveTracker_Update_hook(reason, questID)
	for _,b in pairs(objectiveTrackerButtons) do
		if b:IsShown() and ((b.questID ~= b.parent.id or not VWQL or VWQL.DisableLFG or VWQL.DisableLFG_EyeRight) or (b.parent.hasGroupFinderButton)) then
			b:Hide()
		end
	end
	if not VWQL or VWQL.DisableLFG or VWQL.DisableLFG_EyeRight then
		return
	end
	if reason and reason ~= 1 then
		if not ObjectiveTrackerFrame or not ObjectiveTrackerFrame.MODULES then
			return
		end
		local createdID = LFGListFrame.EntryCreation.Name:GetText()
		for _,module in pairs(ObjectiveTrackerFrame.MODULES) do
			if module.usedBlocks then
				for _,templateBlock in pairs(module.usedBlocks) do
					for _,block in pairs(templateBlock) do
						local questID = block.id
						if questID and IsQuestValidForEye(questID) and not block.hasGroupFinderButton and not WorldQuestList:IsQuestDisabledForLFG(questID) then
							local b = objectiveTrackerButtons[block]
							if not b then
								b = CreateFrame("Button",nil,objectiveTrackerMainFrame)
								objectiveTrackerButtons[block] = b
								b.parent = block
								b:SetSize(26,26)
								b:SetPoint("TOPLEFT",block,"TOPRIGHT",-18,0)
								b:SetScript("OnClick",objectiveTrackerButtons_OnClick)
								b:SetScript("OnEnter",objectiveTrackerButtons_OnEnter)
								b:SetScript("OnLeave",objectiveTrackerButtons_OnLeave)
								b:SetScript("OnUpdate",objectiveTrackerButtons_OnUpdate)
								b:RegisterForClicks("LeftButtonDown","RightButtonUp")
	
								b.HighlightTexture = b:CreateTexture()
								b.HighlightTexture:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
								b.HighlightTexture:SetSize(26,26)
								b.HighlightTexture:SetPoint("CENTER")
								b:SetHighlightTexture(b.HighlightTexture,"ADD")
	
								b.texture = b:CreateTexture(nil, "BACKGROUND")
								b.texture:SetPoint("CENTER")
								b.texture:SetSize(26,26)
								b.texture:SetAtlas("hud-microbutton-LFG-Up")
	
								b.texture2 = b:CreateTexture(nil, "ARTWORK")
								b.texture2:SetPoint("CENTER")
								b.texture2:SetSize(14,14)
							end
							if block.itemButton and block.itemButton:IsVisible() and not b.icon_pos then
								b:SetPoint("TOPLEFT",block,"TOPRIGHT",-44,0)
								b.icon_pos = true
							elseif (not block.itemButton or not block.itemButton:IsVisible()) and b.icon_pos then
								b:SetPoint("TOPLEFT",block,"TOPRIGHT",-18,0)
								b.icon_pos = false
							end
							b:SetFrameStrata(block:GetFrameStrata())
							b:SetFrameLevel(block:GetFrameLevel()+1)
							b.questID = questID
							b:Show()
							if createdID == tostring(questID) and (GetNumGroupMembers() > 0) then
								if C_LFGList.GetActiveEntryInfo() or (GetNumGroupMembers() >= 5) then
									b:Hide()
								end
								if not b.texture.refresh then
									b.texture:SetTexture("Interface\\Buttons\\UI-SquareButton-Up")
									b.texture2:SetTexture("Interface\\Buttons\\UI-RefreshButton")
									b.texture.refresh = true
								end
							else
								if b.texture.refresh then
									b.texture:SetAtlas("hud-microbutton-LFG-Up")
									b.texture2:SetTexture()
									b.texture.refresh = nil
								end
							end
						end
					end
				end
			end
		end
	end
end

if false then
	WorldQuestList.ObjectiveTracker_Update_hook = ObjectiveTracker_Update_hook
	C_Timer.NewTicker(1,function()
		WorldQuestList.ObjectiveTracker_Update_hook(2)
	end)
end


--Add Map Icons

do
	local CacheQuestItemReward = {}
	local CacheIsAnimaItem = {}

	local SlotToIcon = {
		["INVTYPE_HEAD"]="transmog-nav-slot-head",
		["INVTYPE_NECK"]="Warlock-ReadyShard",
		["INVTYPE_SHOULDER"]="transmog-nav-slot-shoulder",
		["INVTYPE_CHEST"]="transmog-nav-slot-chest",
		["INVTYPE_WAIST"]="transmog-nav-slot-waist",
		["INVTYPE_LEGS"]="transmog-nav-slot-legs",
		["INVTYPE_FEET"]="transmog-nav-slot-feet",
		["INVTYPE_WRIST"]="transmog-nav-slot-wrist",
		["INVTYPE_HAND"]="transmog-nav-slot-hands", 
		["INVTYPE_FINGER"]="Warlock-ReadyShard", 
		["INVTYPE_TRINKET"]="Warlock-ReadyShard",
		["INVTYPE_CLOAK"]="transmog-nav-slot-back",

		["INVTYPE_WEAPON"]="transmog-nav-slot-mainhand",
		["INVTYPE_2HWEAPON"]="transmog-nav-slot-mainhand",
		["INVTYPE_RANGED"]="transmog-nav-slot-mainhand",
		["INVTYPE_RANGEDRIGHT"]="transmog-nav-slot-mainhand",
		["INVTYPE_WEAPONMAINHAND"]="transmog-nav-slot-mainhand", 
		["INVTYPE_SHIELD"]="transmog-nav-slot-secondaryhand",
		["INVTYPE_WEAPONOFFHAND"]="transmog-nav-slot-secondaryhand",

		[select(3,C_Item.GetItemInfoInstant(141265))] = "Warlock-ReadyShard",
	}

	local function HookOnEnter(self)
		self.pinFrameLevelType = "PIN_FRAME_LEVEL_TOPMOST"
		self:ApplyFrameLevel()
	end
	local function HookOnLeave(self)
		self.pinFrameLevelType = "PIN_FRAME_LEVEL_WORLD_QUEST"
		self:ApplyFrameLevel()
	end

	local function CreateMapTextOverlay(mapFrame,pinName)
		local mapCanvas = mapFrame:GetCanvas()
		local textsFrame = CreateFrame("Frame",nil,mapCanvas)
		textsFrame:SetPoint("TOPLEFT")
		textsFrame:SetSize(1,1)
		textsFrame:SetFrameLevel(10000)
		local textsTable = {}

		textsTable.s = 1

		local prevScale = nil
		textsFrame:SetScript("OnUpdate",function(self)
			local nowScale = mapCanvas:GetScale()
			if nowScale ~= prevScale then
				local pins = mapFrame.pinPools[pinName]
				if pins then
					local scaleFactor,startScale,endScale
					for obj in mapFrame:EnumeratePinsByTemplate("WorldMap_WorldQuestPinTemplate") do
						scaleFactor = obj.scaleFactor
						startScale = obj.startScale
						endScale = obj.endScale
						break
					end
					local scale
					if startScale and startScale and endScale then
						local parentScaleFactor = 1.0 / mapFrame:GetCanvasScale()
						scale = parentScaleFactor * Lerp(startScale, endScale, Saturate(scaleFactor * mapFrame:GetCanvasZoomPercent()))
					else
						scale = 1
					end
					if scale then
						scale = scale * mapFrame:GetGlobalPinScale()

						for i=1,#textsTable do
							textsTable[i]:SetScale(scale)
						end
					end
					textsTable.s = scale or 1
				end
			end
		end)

		textsTable.f = textsFrame
		textsTable.c = mapCanvas

		return textsTable
	end

	local WorldMapFrame_TextTable = CreateMapTextOverlay(WorldMapFrame,"WorldMap_WorldQuestPinTemplate")

	local UpdateFrameLevelFunc = function(self) 
		if not self.obj:IsVisible() then
			self:Hide()
		elseif self.obj then 
			local lvl = self.obj:GetFrameLevel()
			if self.frLvl ~= lvl then
				self:SetFrameLevel(lvl)
				self.frLvl = lvl
			end
		end
	end

	local function AddText(table,obj,num,text)
		num = num + 1
		local t = table[num]
		if not t then
			t = CreateFrame("Frame",nil,table.c)
			t:SetSize(1,1)
			t.t = t:CreateFontString(nil,"OVERLAY","GameFontWhite")
			t.t:SetPoint("CENTER")
			t:SetScale(table.s)
			t:SetScript("OnUpdate",UpdateFrameLevelFunc)
			table[num] = t
		end
		t.obj = obj:GetParent()
		if VWQL.DisableRibbon and t.type ~= 2 then
			t.type = 2
			t.t:SetFont("Interface\\AddOns\\WorldQuestsList\\ariblk.ttf",10,"OUTLINE")
			t.t:SetTextColor(1,1,1,1)
		elseif not VWQL.DisableRibbon and t.type ~= 1 then
			t.type = 1
			t.t:SetFont("Interface\\AddOns\\WorldQuestsList\\ariblk.ttf",10)
			t.t:SetTextColor(.1,.1,.1,1)
		end

		t:SetPoint("CENTER",obj,0,0)
		t.t:SetText(text)
		if not t:IsShown() then
			t:Show()
		end
		return num
	end

	function WorldQuestList:WQIcons_AddIcons(frame,pinName)
		frame = frame or WorldMapFrame
		local pins = frame.pinPools[pinName or "WorldMap_WorldQuestPinTemplate"]
		if pins and VWQL and not VWQL.DisableRewardIcons then
			local isWorldMapFrame = frame == WorldMapFrame
			local isRibbonDisabled = isWorldMapFrame and GENERAL_MAPS[GetCurrentMapID()] and not VWQL.EnableRibbonGeneralMaps
			local tCount = 0
			local bountyMapID = frame:GetMapID() or 0
			if bountyMapID == 1014 then bountyMapID = 876 
			elseif bountyMapID == 1011 then bountyMapID = 875 end
			local bounties = C_QuestLog.GetBountiesForMapID(bountyMapID) or {}
			for _,bountyData in pairs(bounties) do
				local t = C_TaskQuest.GetQuestTimeLeftMinutes(bountyData.questID) or 0
				if t < 1440 then
					bountyData.lowTime = true
				elseif t < 2880 then
					bountyData.middleTime = true
				end
				if IsQuestComplete(bountyData.questID) or t == 0 then
					bountyData.completed = true
				end
			end
			local mapsToHighlightCallings = {}
			do
				local p = 1
				local questID = WorldQuestList:GetCallingQuests()
				while questID do
					local mapID, worldQuests, worldQuestsElite, dungeons, treasures = C_QuestLog.GetQuestAdditionalHighlights(questID)
					if mapID and mapID ~= 0 then
						local callingData = {questID = questID, mapID = mapID, worldQuests = worldQuests, worldQuestsElite = worldQuestsElite, dungeons = dungeons, treasures = treasures}

						local t = C_TaskQuest.GetQuestTimeLeftMinutes(questID) or 0
						if t < 1440 then
							callingData.lowTime = true
						elseif t < 2880 then
							callingData.middleTime = true
						end
						if IsQuestComplete(questID) or t == 0 then
							callingData.completed = true
						end

						--mapsToHighlightCallings[mapID] = callingData
						mapsToHighlightCallings[#mapsToHighlightCallings+1] = callingData
					end
					p = p + 1
					questID = select(p,WorldQuestList:GetCallingQuests())
				end
			end
			if isWorldMapFrame then
				if not WorldMapFrame_TextTable.f:IsShown() then
					WorldMapFrame_TextTable.f:Show()
				end
			end
			local warMode = C_PvP.IsWarModeDesired()
			local warModeBonus = C_PvP.GetWarModeRewardBonus() / 100 + 1
			for obj in frame:EnumeratePinsByTemplate("WorldMap_WorldQuestPinTemplate") do
				local icon = obj.WQL_rewardIcon
				if obj.questID then
					if not icon then
						icon = obj:CreateTexture(nil,"ARTWORK")
						obj.WQL_rewardIcon = icon
						icon:SetPoint("CENTER",0,0)
						icon:SetSize(26,26)

						local iconWMask = obj:CreateTexture(nil,"ARTWORK")
						obj.WQL_rewardIconWMask = iconWMask
						iconWMask:SetPoint("CENTER",0,0)
						iconWMask:SetSize(26,26)
						iconWMask:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")

						local ribbon = obj:CreateTexture(nil,"BACKGROUND")
						obj.WQL_rewardRibbon = ribbon
						ribbon:SetPoint("TOP",obj,"BOTTOM",0,5)
						ribbon:SetSize(100*0.6,40*0.6)
						ribbon:SetAtlas("UI-Frame-Neutral-Ribbon")
						if C_AddOns.IsAddOnLoaded("Mapster") then
							ribbon:SetPoint("TOP",obj,"BOTTOM",0,20)
						end

						if not isWorldMapFrame then
							local ribbonText = obj:CreateFontString(nil,"BORDER","GameFontWhite")
							obj.WQL_rewardRibbonText = ribbonText
							local a1,a2 = ribbonText:GetFont()
							ribbonText:SetFont(a1,18)
							ribbonText:SetPoint("CENTER",ribbon,0,-1)
							ribbonText:SetTextColor(0,0,0,1)
						end

						local iconTopRight = obj:CreateTexture(nil,"OVERLAY")
						obj.WQL_iconTopRight = iconTopRight
						iconTopRight:SetPoint("CENTER",obj,"TOPRIGHT",0,0)
						iconTopRight:SetSize(20*0.75,20*0.75)
						iconTopRight.SIZE_MOD = 0.7

						obj:HookScript("OnEnter",HookOnEnter)
						obj:HookScript("OnLeave",HookOnLeave)

						obj.WQL_BountyRing_defSize = obj.BountyRing and obj.BountyRing:GetSize()
					end

					local tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex, displayTimeLeft = GetQuestTagInfo(obj.questID)

					local iconAtlas,iconTexture,iconVirtual,iconGray = nil
					local ajustSize,ajustMask = 0
					local amount,amountIcon,amountColor = 0

					-- money
					local money = GetQuestLogRewardMoney(obj.questID)
					if money > 0 then
						iconAtlas = "Auctioneer"
						amount = floor(money / 10000 * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and warModeBonus or 1))
					end

					-- currency
					for i = 1, GetNumQuestLogRewardCurrencies(obj.questID) do
						local name, texture, numItems, currencyID = GetQuestLogRewardCurrencyInfo(i, obj.questID)
						if not numItems or numItems <= 0 then

						elseif currencyID == 1508 or currencyID == 1533 or currencyID == 1721 then	--Veiled Argunite, Wakening Essence, Prismatic Manapearl
							iconTexture = texture
							ajustMask = true
							ajustSize = 8
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							if not (currencyID == 1717 or currencyID == 1716) then
								break
							end
						elseif currencyID == 1553 then	--azerite
							--iconAtlas = "Islands-AzeriteChest"
							iconAtlas = "AzeriteReady"
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							ajustSize = 5
							iconTexture, ajustMask = nil
							if WorldQuestList:IsAzeriteItemAtMaxLevel() then
								iconGray = true
							end
							break
						elseif currencyID == 1220 or currencyID == 1560 then	--OR
							iconAtlas = "legionmission-icon-currency"
							ajustSize = 5
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							iconTexture, ajustMask = nil
							break
						elseif currencyID == 2003 then
							iconTexture = texture
							ajustMask = true
							ajustSize = 5
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							break
						elseif currencyID == 2408 or currencyID == 2245 or currencyID == 2706 or currencyID == 2815 or currencyID == 3008 then
							iconTexture = texture
							ajustMask = true
							ajustSize = 8
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							break
						elseif WorldQuestList:IsFactionCurrency(currencyID or 0) then
							iconAtlas = "poi-workorders"
							amount = numItems
							amountIcon = texture
							ajustSize, iconTexture, ajustMask = 0
							break
						end
					end

					-- item
					if GetNumQuestLogRewards(obj.questID) > 0 then
						local name,icon,numItems,quality,_,itemID = GetQuestLogRewardInfo(1,obj.questID)
						if itemID then
							local itemLevel = select(4,C_Item.GetItemInfo(itemID)) or 0
							if itemLevel > 60 or (itemLevel > 40 and not WorldQuestList:IsShadowlandsZone(bountyMapID)) then
								iconAtlas = "Banker"
								amount = 0
								--iconAtlas = "ChallengeMode-icon-chest"

								local itemLink = CacheQuestItemReward[obj.questID]
								if not itemLink then
									local tooltipData = C_TooltipInfo.GetQuestLogItem("reward", 1, obj.questID)
									if tooltipData then
										itemLink = tooltipData.hyperlink
									end

									CacheQuestItemReward[obj.questID] = itemLink
								end
								if itemLink then
									itemLevel = select(4,C_Item.GetItemInfo(itemLink))
									if itemLevel then
										amount = itemLevel
										if quality and quality > 1 then
											--local colorTable = BAG_ITEM_QUALITY_COLORS[quality]
											--amountColor = format("|cff%02x%02x%02x",colorTable.r * 255,colorTable.g * 255,colorTable.b * 255)
										end
									end
								end
								local itemSubType,inventorySlot = select(3,C_Item.GetItemInfoInstant(itemID))
								if inventorySlot and SlotToIcon[inventorySlot] then
									iconAtlas = SlotToIcon[inventorySlot]
									ajustSize = iconAtlas == "Warlock-ReadyShard" and 0 or 10
								elseif itemSubType and SlotToIcon[itemSubType] then
									iconAtlas = SlotToIcon[itemSubType]
									ajustSize = iconAtlas == "Warlock-ReadyShard" and 0 or 10
								end
							end
							if itemID == 124124 or itemID == 151568 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
								if numItems then
									amount = numItems
								end
							elseif itemID == 152960 or itemID == 152957 then
								iconAtlas = "poi-workorders"
							elseif itemID == 163857 or itemID == 143559 or itemID == 141920 or itemID == 152668 or itemID == 209839 or itemID == 209837 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
								if itemID == 152668 and numItems and numItems > 1 then
									amount = numItems
								end
							elseif itemID == 169480 then
								iconAtlas = SlotToIcon.INVTYPE_CHEST
								ajustSize = 10
							elseif itemID == 169479 then
								iconAtlas = SlotToIcon.INVTYPE_HEAD
								ajustSize = 10
							elseif itemID == 169477 then
								iconAtlas = SlotToIcon.INVTYPE_WAIST
								ajustSize = 10
							elseif itemID == 169484 then
								iconAtlas = SlotToIcon.INVTYPE_SHOULDER
								ajustSize = 10
							elseif itemID == 169478 then
								iconAtlas = SlotToIcon.INVTYPE_WRIST
								ajustSize = 10
							elseif itemID == 169482 then
								iconAtlas = SlotToIcon.INVTYPE_LEGS
								ajustSize = 10
							elseif itemID == 169481 then
								iconAtlas = SlotToIcon.INVTYPE_CLOAK
								ajustSize = 10
							elseif itemID == 169483 then
								iconAtlas = SlotToIcon.INVTYPE_FEET
								ajustSize = 10
							elseif itemID == 169485 then
								iconAtlas = SlotToIcon.INVTYPE_HAND
								ajustSize = 10
							elseif itemID == 229899 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
							elseif itemID == 226264 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
							elseif itemID == 198048 or itemID == 198056 or itemID == 198058 or itemID == 198059 or itemID == 204673 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
								amount = itemID == 198048 and "I" or itemID == 198056 and "II" or itemID == 198058 and "III" or itemID == 204673 and "V" or "IV"
							elseif itemID == 228339 or itemID == 228338 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
								amount = itemID == 228338 and "I" or itemID == 228339 and "II" or "III" 
							end

							if CacheIsAnimaItem[itemID] then
								iconTexture = 613397
								ajustMask = true
								ajustSize = 10
								amount = numItems * CacheIsAnimaItem[itemID]
								if warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) then
									local bonus = floor(amount * (warModeBonus - 1) + .5)
									--if CacheIsAnimaItem[itemID] <= 35 then
										bonus = bonus - bonus % 3
									--else
									--	bonus = bonus - bonus % 5
									--end
									amount = amount + bonus
								end
							elseif select(2,C_Item.GetItemInfoInstant(itemID)) == MISCELLANEOUS then
								local tooltipData = C_TooltipInfo.GetQuestLogItem("reward", 1, obj.questID)
								if tooltipData then
									local isAnima
									for j=2, #tooltipData.lines do
										local tooltipLine = tooltipData.lines[j]
										local text = tooltipLine.leftText
										if text and text:find(WORLD_QUEST_REWARD_FILTERS_ANIMA.."|r$") then
											isAnima = 1
										elseif text and isAnima and text:find("^"..LE.ITEM_SPELL_TRIGGER_ONUSE) then
											local num = text:gsub("(%d+)[ %.,]+(%d+)","%1%2"):match("%d+")
											isAnima = tonumber(num or "") or 1
											break
										end 
									end
									if isAnima then
										if isAnima ~= 1 then
											CacheIsAnimaItem[itemID] = isAnima
										end
										iconTexture = 613397
										ajustMask = true
										ajustSize = 10
										amount = numItems * isAnima
										if warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) then
											local bonus = floor(amount * (warModeBonus - 1) + .5)
											--if isAnima <= 35 then
												bonus = bonus - bonus % 3
											--else
											--	bonus = bonus - bonus % 5
											--end
											amount = amount + bonus
										end
									end
								end
							end

							if worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE then
								iconVirtual = true
								amountIcon = icon
								amount = numItems
							elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_DUNGEON or worldQuestType == LE.LE_QUEST_TAG_TYPE_RAID then
								iconVirtual = true
								amountIcon = icon
								amount = itemLevel or numItems
							end
						end
					end

					if worldQuestType == LE.LE_QUEST_TAG_TYPE_DUNGEON then
						iconAtlas,iconTexture = nil
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_RAID then
						iconAtlas,iconTexture = nil
					end

					if worldQuestType == LE.LE_QUEST_TAG_TYPE_PVP then
						if obj.WQL_iconTopRight.curr ~= "worldquest-icon-pvp-ffa" then
							obj.WQL_iconTopRight:SetSize(20*obj.WQL_iconTopRight.SIZE_MOD,20*obj.WQL_iconTopRight.SIZE_MOD)
							obj.WQL_iconTopRight:SetAtlas("worldquest-icon-pvp-ffa")
							obj.WQL_iconTopRight.curr = "worldquest-icon-pvp-ffa"
						end
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE and (iconTexture or iconAtlas) then
						if obj.WQL_iconTopRight.curr ~= "worldquest-icon-petbattle" then
							obj.WQL_iconTopRight:SetSize(20*obj.WQL_iconTopRight.SIZE_MOD,20*obj.WQL_iconTopRight.SIZE_MOD)
							obj.WQL_iconTopRight:SetAtlas("worldquest-icon-petbattle")
							obj.WQL_iconTopRight.curr = "worldquest-icon-petbattle"
						end
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PROFESSION then
						if obj.WQL_iconTopRight.curr ~= "worldquest-icon-engineering" then
							obj.WQL_iconTopRight:SetSize(20*obj.WQL_iconTopRight.SIZE_MOD,20*obj.WQL_iconTopRight.SIZE_MOD)
							obj.WQL_iconTopRight:SetAtlas("worldquest-icon-engineering")
							obj.WQL_iconTopRight.curr = "worldquest-icon-engineering"
						end
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_INVASION then
						if obj.WQL_iconTopRight.curr ~= "worldquest-icon-burninglegion" then
							obj.WQL_iconTopRight:SetSize(20*obj.WQL_iconTopRight.SIZE_MOD,20*obj.WQL_iconTopRight.SIZE_MOD)
							obj.WQL_iconTopRight:SetAtlas("worldquest-icon-burninglegion")
							obj.WQL_iconTopRight.curr = "worldquest-icon-burninglegion"
						end
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_FACTION_ASSAULT  then
						local factionTag = UnitFactionGroup("player")
						local icon = factionTag == "Alliance" and "worldquest-icon-horde" or "worldquest-icon-alliance"
						if obj.WQL_iconTopRight.curr ~= icon then
							obj.WQL_iconTopRight:SetSize(20*obj.WQL_iconTopRight.SIZE_MOD,20*obj.WQL_iconTopRight.SIZE_MOD)
							obj.WQL_iconTopRight:SetAtlas(icon)
							obj.WQL_iconTopRight.curr = icon
						end
					else
						if obj.WQL_iconTopRight.curr then
							obj.WQL_iconTopRight:SetSize(20*obj.WQL_iconTopRight.SIZE_MOD,20*obj.WQL_iconTopRight.SIZE_MOD)
							obj.WQL_iconTopRight:SetTexture()
							obj.WQL_iconTopRight.curr = nil
						end
					end

					if iconTexture or iconAtlas or iconVirtual then
						if not iconVirtual then
							local res_size = (26+ajustSize) * 0.5
							icon:SetSize(res_size,res_size)
							obj.WQL_rewardIconWMask:SetSize(res_size,res_size)
							if iconTexture then
								if ajustMask then
									if obj.WQL_rewardIconWMask.curr ~= iconTexture then
										obj.WQL_rewardIconWMask:SetTexture(iconTexture)
										obj.WQL_rewardIconWMask.curr = iconTexture
									end
									if icon.curr then
										icon:SetTexture()
										icon.curr = nil
									end
								else
									if obj.WQL_rewardIconWMask.curr then
										obj.WQL_rewardIconWMask:SetTexture()
										obj.WQL_rewardIconWMask.curr = nil
									end
									if icon.curr ~= iconTexture then
										icon:SetTexture(iconTexture)
										icon.curr = iconTexture
										if iconGray then
											icon:SetDesaturated(true)
										else
											icon:SetDesaturated(false)
										end
									end
								end
							else
								if obj.WQL_rewardIconWMask.curr then
									obj.WQL_rewardIconWMask:SetTexture()
									obj.WQL_rewardIconWMask.curr = nil
								end
								if icon.curr ~= iconAtlas then
									icon:SetAtlas(iconAtlas)
									icon.curr = iconAtlas
									if iconGray then
										icon:SetDesaturated(true)
									else
										icon:SetDesaturated(false)
									end
								end
							end
							if obj.Display then
								obj.Display.Icon:SetTexture()
								obj.WQL_rewardIcon:SetParent(obj.Display.Icon:GetParent())
								obj.WQL_rewardIcon:SetDrawLayer("OVERLAY",5)
								obj.WQL_rewardIconWMask:SetParent(obj.Display.Icon:GetParent())
								obj.WQL_rewardIconWMask:SetDrawLayer("OVERLAY",5)
							end
						else
							if obj.WQL_rewardIconWMask.curr then
								obj.WQL_rewardIconWMask:SetTexture()
								obj.WQL_rewardIconWMask.curr = nil
							end
							if icon.curr then
								icon:SetTexture()
								icon.curr = nil
							end
						end

						if ((type(amount)=="number" and amount > 0) or type(amount) == "string") and not isRibbonDisabled then
							if not obj.WQL_rewardRibbon:IsShown() then
								obj.WQL_rewardRibbon:Show()
							end
							if VWQL.DisableRibbon and obj.WQL_rewardRibbon.type ~= 2 then
								obj.WQL_rewardRibbon.type = 2
								if not isWorldMapFrame then
									obj.WQL_rewardRibbonText:SetFont("Interface\\AddOns\\WorldQuestsList\\ariblk.ttf",18,"OUTLINE")
									obj.WQL_rewardRibbonText:SetTextColor(1,1,1,1)
								end
								obj.WQL_rewardRibbon:SetAlpha(0)
							elseif not VWQL.DisableRibbon and obj.WQL_rewardRibbon.type ~= 1 then
								obj.WQL_rewardRibbon.type = 1
								if not isWorldMapFrame then
									obj.WQL_rewardRibbonText:SetFont("Interface\\AddOns\\WorldQuestsList\\ariblk.ttf",18)
									obj.WQL_rewardRibbonText:SetTextColor(.1,.1,.1,1)
								end
								obj.WQL_rewardRibbon:SetAlpha(1)
							end
							if not isWorldMapFrame then
								obj.WQL_rewardRibbonText:SetText((amountIcon and "|T"..amountIcon..":0|t" or "")..(amountColor or "")..amount)
							end
							obj.WQL_rewardRibbon:SetWidth( ((#tostring(amount) + (amountIcon and 1.5 or 0)) * 16 + 40) * 0.6 )

							obj.TimeLowFrame:SetPoint("CENTER",-8,-8)

							if isWorldMapFrame then
								tCount = AddText(WorldMapFrame_TextTable,obj.WQL_rewardRibbon,tCount,(amountIcon and "|T"..amountIcon..":0|t" or "")..(amountColor or "")..amount)
							end
						elseif obj.WQL_rewardRibbon:IsShown() then
							obj.WQL_rewardRibbon:Hide()
							if not isWorldMapFrame then
								obj.WQL_rewardRibbonText:SetText("")
							end
							obj.TimeLowFrame:SetPoint("CENTER",8,-8)
						end
					else
						if obj.WQL_rewardIconWMask.curr then
							obj.WQL_rewardIconWMask:SetTexture()
							obj.WQL_rewardIconWMask.curr = nil
						end
						if icon.curr then
							icon:SetTexture()
							icon.curr = nil
						end
						if obj.WQL_rewardRibbon:IsShown() then
							obj.WQL_rewardRibbon:Hide()
							if not isWorldMapFrame then
								obj.WQL_rewardRibbonText:SetText("")
							end
							obj.TimeLowFrame:SetPoint("CENTER",8,-8)
						end
					end
					obj.WQL_questID = obj.questID

					if obj.BountyRing then
						obj.BountyRing:SetVertexColor(1,1,1)
						obj.BountyRing:SetSize(obj.WQL_BountyRing_defSize,obj.WQL_BountyRing_defSize)
						obj.BountyRing.WQL_color = 4
						if not VWQL.RewardIcons_DisableBountyColors then
							obj.BountyRing:Hide()
							for _,bountyData in pairs(bounties) do
								if IsQuestCriteriaForBounty(obj.questID, bountyData.questID) and not bountyData.completed then
									obj.BountyRing:SetSize(64,64)
									obj.BountyRing:Show()
									if bountyData.lowTime and obj.BountyRing.WQL_color > 1 then
										obj.BountyRing:SetVertexColor(1,0,0)
										obj.BountyRing.WQL_color = 1
									elseif bountyData.middleTime and obj.BountyRing.WQL_color > 2 then
										obj.BountyRing:SetVertexColor(1,.5,0)
										obj.BountyRing.WQL_color = 2
									elseif not bountyData.lowTime and not bountyData.middleTime and obj.BountyRing.WQL_color > 3 then
										obj.BountyRing:SetVertexColor(.3,1,.3)
										obj.BountyRing.WQL_color = 3
									end
								end
							end
							local mapID = WorldQuestList.QuestIDtoMapID[obj.questID or 0]
							if mapID then
								for i=1,#mapsToHighlightCallings do
									local callingData = mapsToHighlightCallings[i]
									if callingData and callingData.mapID == mapID and (callingData.worldQuests or (callingData.worldQuestsElite and isElite)) and not callingData.completed then
										obj.BountyRing:SetSize(64,64)
										obj.BountyRing:Show()
										if callingData.lowTime and obj.BountyRing.WQL_color > 1 then
											obj.BountyRing:SetVertexColor(1,0,0)
											obj.BountyRing.WQL_color = 1
										elseif callingData.middleTime and obj.BountyRing.WQL_color > 2 then
											obj.BountyRing:SetVertexColor(1,.5,0)
											obj.BountyRing.WQL_color = 2
										elseif not callingData.lowTime and not callingData.middleTime and obj.BountyRing.WQL_color > 3 then
											obj.BountyRing:SetVertexColor(.3,1,.3)
											obj.BountyRing.WQL_color = 3
										end
									end
								end
							end
						end
					end
				else
					if obj.WQL_rewardIcon then
						if obj.WQL_rewardIconWMask.curr then
							obj.WQL_rewardIconWMask:SetTexture()
							obj.WQL_rewardIconWMask.curr = nil
						end
						if obj.WQL_rewardIcon.curr then
							obj.WQL_rewardIcon:SetTexture()
							obj.WQL_rewardIcon.curr = nil
						end
						if obj.WQL_iconTopRight.curr then
							obj.WQL_iconTopRight:SetTexture()
							obj.WQL_iconTopRight.curr = nil
						end
						obj.WQL_rewardRibbon:Hide()
						if not isWorldMapFrame then
							obj.WQL_rewardRibbonText:SetText("")
						end
						obj.TimeLowFrame:SetPoint("CENTER",8,-8)
						if obj.BountyRing then
							obj.BountyRing:SetSize(obj.WQL_BountyRing_defSize,obj.WQL_BountyRing_defSize)
							obj.BountyRing:SetVertexColor(1,1,1)
						end
					end
					obj.WQL_questID = nil
				end
			end
			if isWorldMapFrame then
				for i=tCount+1,#WorldMapFrame_TextTable do
					WorldMapFrame_TextTable[i]:Hide()
				end
			end

		elseif frame == WorldMapFrame then
			for i=1,#WorldMapFrame_TextTable do
				WorldMapFrame_TextTable[i]:Hide()
			end
		end

		WorldQuestList:WQUpdateWMIcons(frame)
	end

	function WorldQuestList:WQIcons_RemoveIcons()
		for _,frames in pairs({{WorldMapFrame,"WorldMap_WorldQuestPinTemplate"},{FlightMapFrame,"FlightMap_WorldQuestPinTemplate"}}) do
			local frame = frames[1]
			if frame then
				local pins = frame.pinPools[ frames[2] ]
				if pins then
					for obj in frame:EnumeratePinsByTemplate(frames[2]) do
						if obj.WQL_rewardIcon then
							obj.WQL_rewardIconWMask:SetTexture()
							obj.WQL_rewardIconWMask.curr = nil
							obj.WQL_rewardIcon:SetTexture()
							obj.WQL_rewardIcon.curr = nil
							obj.WQL_iconTopRight:SetTexture()
							obj.WQL_iconTopRight.curr = nil
							obj.WQL_rewardRibbon:Hide()
							if obj.WQL_rewardRibbonText then
								obj.WQL_rewardRibbonText:SetText("")
							end
							obj.TimeLowFrame:SetPoint("CENTER",8,-8)
							if obj.BountyRing then
								obj.BountyRing:SetSize(obj.WQL_BountyRing_defSize,obj.WQL_BountyRing_defSize)
								obj.BountyRing:SetVertexColor(1,1,1)
							end
						end
					end
					frame:RefreshAllDataProviders()
				end
			end
		end
		for i=1,#WorldMapFrame_TextTable do
			WorldMapFrame_TextTable[i]:Hide()
		end

		WorldQuestList:WQUpdateWMIcons()
	end

	function WorldQuestList:WQUpdateWMIcons(frame)
		frame = frame or WorldMapFrame
		local isEnabled = VWQL and not VWQL.DisableQuestNumber
		if frame.EnumeratePinsByTemplate then
			local currNum, questsNum = 0
			if isEnabled then
				for i = 1, C_QuestLog.GetNumQuestLogEntries() do
					local info = C_QuestLog.GetInfo(i)
					if info.questID and not C_QuestLog.IsComplete(info.questID) and not info.isHeader then
						if not questsNum then
							questsNum = {}
						end
						currNum = currNum + 1
						questsNum[info.questID] = currNum
					end
				end
			end
			for obj in frame:EnumeratePinsByTemplate("QuestPinTemplate") do
				if not obj.Display then

				elseif questsNum and questsNum[obj.questID] then
					--obj.Display.Icon:SetTexture()
					obj.Display.Icon:SetAlpha(0)
					if not obj.Display.WQL_Text then
						obj.Display.WQL_Text = obj:CreateFontString(nil,"OVERLAY","GameFontNormal")
						local a1,a2 = obj.Display.WQL_Text:GetFont()
						obj.Display.WQL_Text:SetFont(a1,12,"OUTLINE")
						obj.Display.WQL_Text:SetPoint("CENTER",0,-1)
					end
					obj.Display.WQL_Text:SetText(questsNum[obj.questID])
					obj.Display.WQL_Text:Show()
				elseif obj.Display.WQL_Text then
					obj.Display.Icon:SetAlpha(1)
					obj.Display.WQL_Text:Hide()
				end
			end
			for obj in QuestScrollFrame.Contents.buttonPool:EnumerateActive() do
				if not obj.Display then

				elseif obj.questID and questsNum and questsNum[obj.questID] then
					--obj.Display.Icon:SetTexture()
					obj.Display.Icon:SetAlpha(0)
					if not obj.Display.WQL_Text then
						obj.Display.WQL_Text = obj:CreateFontString(nil,"OVERLAY","GameFontNormal")
						local a1,a2 = obj.Display.WQL_Text:GetFont()
						obj.Display.WQL_Text:SetFont(a1,12,"OUTLINE")
						obj.Display.WQL_Text:SetPoint("CENTER",0,-1)
					end
					obj.Display.WQL_Text:SetText(questsNum[obj.questID])
					obj.Display.WQL_Text:Show()
				elseif obj.Display and obj.Display.WQL_Text then
					obj.Display.Icon:SetAlpha(1)
					obj.Display.WQL_Text:Hide()
				end
			end
		end
	end

end

WorldMapFrame:RegisterCallback("WorldQuestsUpdate", function()
	WorldQuestList:WQIcons_AddIcons()
end)

local WQIcons_FlightMapLoad = CreateFrame("Frame")
WQIcons_FlightMapLoad:RegisterEvent("ADDON_LOADED")
WQIcons_FlightMapLoad:SetScript("OnEvent",function (self, event, arg)
	if arg == "Blizzard_FlightMap" then
		self:UnregisterAllEvents()
		FlightMapFrame:RegisterCallback("WorldQuestsUpdate", function()
			WorldQuestList:WQIcons_AddIcons(FlightMapFrame,"FlightMap_WorldQuestPinTemplate")
		end, self)
	end
end)


--- Icons size on map

local defScaleFactor, defStartScale, defEndScale = 1, 1, 1
if WorldMap_WorldQuestPinMixin then
	local f = CreateFrame("Frame")
	f.SetScalingLimits = function(_,scaleFactor, startScale, endScale) 
		defScaleFactor = scaleFactor or defScaleFactor
		defStartScale = startScale or defStartScale
		defEndScale = endScale or defEndScale
	end
	pcall(function() WorldMap_WorldQuestPinMixin.OnLoad(f) end)
end

function WorldQuestList:WQIcons_RemoveScale()
	local pins = WorldMapFrame.pinPools["WorldMap_WorldQuestPinTemplate"]
	if pins then
		for obj in WorldMapFrame:EnumeratePinsByTemplate("WorldMap_WorldQuestPinTemplate") do
			pcall(function() 
				obj:SetScalingLimits(defScaleFactor, defStartScale, defEndScale)
				if obj:GetMap() and obj:GetMap().ScrollContainer.zoomLevels then	--fix unk error in 8.3
					obj:ApplyCurrentScale()
				end
			end)
		end
	end
end

function WorldQuestList:WQIcons_UpdateScale()
	local pins = WorldMapFrame.pinPools["WorldMap_WorldQuestPinTemplate"]
	if pins and VWQL and not VWQL.DisableWQScale_Hidden then
		local startScale, endScale = defStartScale, defEndScale
		local generalMap = GENERAL_MAPS[GetCurrentMapID()]
		local scaleFactor = (VWQL.MapIconsScale or 1)
		if not generalMap then
			startScale, endScale = defStartScale, defEndScale
		elseif generalMap == 2 then
			--startScale, endScale = 0.15, 0.2
			startScale, endScale = .8, .8
			scaleFactor = scaleFactor * (WorldMapFrame:IsMaximized() and 1.25 or 1)
		elseif generalMap == 4 then
			startScale, endScale = .8, .8
			--startScale, endScale = 0.3, 0.425
			scaleFactor = scaleFactor * (WorldMapFrame:IsMaximized() and 1.25 or 1)
		else
			--startScale, endScale = 0.35, 0.425
			startScale, endScale = 1, 1
			scaleFactor = scaleFactor * (WorldMapFrame:IsMaximized() and 1.25 or 1)
		end
		startScale, endScale = startScale * scaleFactor, endScale * scaleFactor

		for obj in WorldMapFrame:EnumeratePinsByTemplate("WorldMap_WorldQuestPinTemplate") do
			--scaleFactor, startScale, endScale
			if obj.startScale ~= startScale or obj.endScale ~= endScale then
				obj:SetScalingLimits(1, startScale, endScale)
				if obj:GetMap() and obj:GetMap().ScrollContainer.zoomLevels then	--fix unk error in 8.3
					obj:ApplyCurrentScale()
				end
			end
		end
	end
end

WorldMapFrame:RegisterCallback("WorldQuestsUpdate", function()
	WorldQuestList:WQIcons_UpdateScale()
end)

local ArrowHolidayFuncCheck = {
	prev = nil,
	tmr = GetTime(),
	sound = 0,
	prevmin = nil,
}
function ArrowHolidayFuncCheck.func(y)
	local t = GetTime()
	if t - ArrowHolidayFuncCheck.tmr < 1 then
		return
	end
	ArrowHolidayFuncCheck.tmr = t

	y = floor(y + 0.5)
	if ArrowHolidayFuncCheck.prev == y and (ArrowHolidayFuncCheck.sound ~= y) then
		--PlaySoundFile([[Interface\AddOns\SharedMedia_Causese\sound\Stop.ogg]],"Master")
		ArrowHolidayFuncCheck.sound = y
	end 
	if y < 200 and not ArrowHolidayFuncCheck.prevmin then
		--Interface\AddOns\SharedMedia_Causese\sound\Next.ogg
		PlaySoundFile([[Interface\AddOns\BigWigs\Media\Sounds\Info.ogg]],"Master")
		ArrowHolidayFuncCheck.prevmin = y
	end 
	if y > (ArrowHolidayFuncCheck.prev or math.huge) then
		ArrowHolidayFuncCheck.prevmin = nil
		local diff = y - (ArrowHolidayFuncCheck.prev or math.huge)
		if diff < 50 and diff > 0 then
			--PlaySoundFile([[Interface\AddOns\SharedMedia_Causese\sound\Dodge.ogg]],"Master")
		end
	end
	ArrowHolidayFuncCheck.prev = y
end



WQL_HolidayDataProviderMixin = CreateFromMixins(AreaPOIDataProviderMixin)

function WQL_HolidayDataProviderMixin:OnShow()
end

function WQL_HolidayDataProviderMixin:GetPinTemplate()
	return "WQL_HolidayPinTemplate";
end
function WQL_HolidayDataProviderMixin:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate(self:GetPinTemplate())
end
function WQL_HolidayDataProviderMixin:RefreshAllData()
	if not self:GetMap() then	--fix error on load
		return
	end
	self:RemoveAllData()
	if not VWQL or not VWQL[charKey].HolidaysMode then
		return
	end

	local mapID = self:GetMap():GetMapID()

	local eventsOn = {}
	local eventFoundAny

	--[[
	local eventIndex = 1
	local eventInfo = C_Calendar.GetHolidayInfo(0,date("*t").day,eventIndex)
	while eventInfo do
		eventFoundAny = true

		eventsOn[eventInfo.texture or -1] = true

		eventIndex = eventIndex + eventIndex
		eventInfo = C_Calendar.GetHolidayInfo(0,date("*t").day,eventIndex)
	end
	]]
	local today = time()
	for i=1,#WQLdb.HolidaysDates do
		if today >= WQLdb.HolidaysDates[i][1] and today <= WQLdb.HolidaysDates[i][2] then
			eventsOn[ WQLdb.HolidaysDates[i][3] ] = true
			eventFoundAny = true
		end
	end

	if not eventFoundAny then
		return
	end

	for i=1,#WQLdb.Holidays do
		local data = WQLdb.Holidays[i]

		if 
			(not data[1] or eventsOn[ data[1] ]) and
			(not data[6] or (data[6] == 1 and UnitFactionGroup("player") == "Horde") or (data[6] == 2 and UnitFactionGroup("player") == "Alliance")) and
			(not data[5] or not C_QuestLog.IsQuestFlaggedCompleted(data[5])) 
		then
			local x,y = data[3],data[4]
			local passMapCheck = mapID == data[2]
			local size = 1
			if not passMapCheck then
				local xMin,xMax,yMin,yMax = C_Map.GetMapRectOnMap(data[2],mapID)
				if xMin ~= xMax and yMin ~= yMax then
					x = xMin + x * (xMax - xMin)
					y = yMin + y * (yMax - yMin)

					passMapCheck = true
					size = .65
				end
			end
			if passMapCheck then
				local pin = self:GetMap():AcquirePin(self:GetPinTemplate(), {
					areaPoiID = 0,
					name = data[8],
					description = WQLdb.HolidaysHeaders[ data[1] ] or "",
					size = size,
					position = CreateVector2D(x, y),
					texture = data[7],
					clickData = {
						x = x,
						y = y,
						mapID = mapID,
						arrowFunc = ArrowHolidayFuncCheck.func,
					},
					data = data,
				})
			end
		end
	end
end
WQL_HolidayDataProviderMixin.WQL_Signature = true


WorldMapFrame:AddDataProvider(WQL_HolidayDataProviderMixin)