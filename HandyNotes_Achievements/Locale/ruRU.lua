-- Copyright 2016, r. brian harrison.  all rights reserved.

local ADDON_NAME = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
assert(AceLocale, string.format("%s requires %s", ADDON_NAME, "AceLocale-3.0"))

local L = AceLocale:NewLocale(ADDON_NAME, "ruRU")
if not L then return end

-- import

-- L["%s requires %s"] = ""

-- config

L["Icon Scale"] = "Масштаб значка"
-- L["The size of the icons."] = "Размер иконок."
L["Icon Alpha"] = "Прозрачность значка"
-- L["The transparency of the icons."] = "Прозрачность иконок."
-- L["Show Completed"] = "Показать Достижение."
-- L["Show map pins for achievements you have completed."] = "Показать на карте метки достижений, которые вы завершили."
-- L["Consolidate Zone Pins"] = "Объединить Зону Меток"
-- L["Show fewer map pins."] = "Показать меньше меток."
-- L["Just Mine"] = "Только мои"
-- L["Show more map pins by including achievements completed only by other characters."] = "Показать больше меток на карте, включая достижения, выполненные только другими персонажами."
-- L["Season Warning"] = "Сезонное Предупреждение"
-- L["Days in advance to show pins for seasonal holiday achievements."] = "За сколько дней заранее показывать метки достижений сезонных праздников."
-- L["Sort by tracked"] = ""
-- L["Sort achievements by tracked"] = ""
