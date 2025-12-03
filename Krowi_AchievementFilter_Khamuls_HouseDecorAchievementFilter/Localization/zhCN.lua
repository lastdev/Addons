local addonName, addon = ...;
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")
if not L then return end
addon.L = L;

-- Globals
L["Khamul's House Decor Achievement List"] = "卡穆尔的房屋装饰清单"
L["Unknown Achievement"] = "未知成就"

-- Tooltips
L["Tt_UseMetaAchievementPlugin"] = "使用插件 \"Khamul's Expansion Meta Achievement Filters\" 来获取 {1} 的详细概览。"