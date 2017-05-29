-- Copyright 2016, r. brian harrison.  all rights reserved.

local ADDON_NAME = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
assert(AceLocale, string.format("%s requires %s", ADDON_NAME, "AceLocale-3.0"))

local L = AceLocale:NewLocale(ADDON_NAME, "zhCN")
if not L then return end

-- import

-- L["%s requires %s"] = ""

-- config

L["Icon Scale"] = "图标缩放"
-- L["The size of the icons."] = ""
L["Icon Alpha"] = "图标透明度"
-- L["The transparency of the icons."] = ""
-- L["Show Completed"] = ""
-- L["Show map pins for achievements you have completed."] = ""
-- L["Consolidate Zone Pins"] = ""
-- L["Show fewer map pins."] = ""
-- L["Just Mine"] = ""
-- L["Show more map pins by including achievements completed only by other characters."] = ""
-- L["Season Warning"] = ""
-- L["Days in advance to show pins for seasonal holiday achievements."] = ""
