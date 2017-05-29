-- Copyright 2016, r. brian harrison.  all rights reserved.

local ADDON_NAME = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
assert(AceLocale, string.format("%s requires %s", ADDON_NAME, "AceLocale-3.0"))

local L = AceLocale:NewLocale(ADDON_NAME, "enUS", true)
if not L then return end

-- import

L["%s requires %s"] = true

-- config

L["Icon Scale"] = true
L["The size of the icons."] = true
L["Icon Alpha"] = true
L["The transparency of the icons."] = true
L["Show Completed"] = true
L["Show map pins for achievements you have completed."] = true
L["Consolidate Zone Pins"] = true
L["Show fewer map pins."] = true
L["Just Mine"] = true
L["Show more map pins by including achievements completed only by other characters."] = true
L["Season Warning"] = true
L["Days in advance to show pins for seasonal holiday achievements."] = true
