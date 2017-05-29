-- Copyright 2016, r. brian harrison.  all rights reserved.

local ADDON_NAME = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
assert(AceLocale, string.format("%s requires %s", ADDON_NAME, "AceLocale-3.0"))

local L = AceLocale:NewLocale(ADDON_NAME, "zhTW")
if not L then return end

-- import

L["%s requires %s"] = "%s 需要 %s"

-- config

L["Icon Scale"] = "圖示大小"
L["The size of the icons."] = "圖示的大小。"
L["Icon Alpha"] = "圖示透明度"
L["The transparency of the icons."] = "圖示的透明度。"
L["Show Completed"] = "顯示已完成的成就"
L["Show map pins for achievements you have completed."] = "在地圖上顯示已經完成的成就內容。"
L["Consolidate Zone Pins"] = "合併同一個區域的成就內容"
L["Show fewer map pins."] = "在地圖上顯示較少的圖示。"
L["Just Mine"] = "只有這個角色的成就"
L["Show more map pins by including achievements completed only by other characters."] = "顯示較多的成就內容，包含其他角色已經完成的共通成就。"
L["Season Warning"] = "節慶通知天數"
L["Days in advance to show pins for seasonal holiday achievements."] = "要顯示未來多少天內的季節性節慶成就。"
