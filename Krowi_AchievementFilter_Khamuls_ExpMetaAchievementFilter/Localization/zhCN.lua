local addonName, addon = ...;
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")
if not L then return end
addon.L = L;

-- Globals
L["Khamul's Meta-Expansion Achievement List"] = "Khamul's Meta-资料片新增成就列表"
L["Unknown Achievement"] = "未知成就"

-- Tooltips
L["Tt_ACM_15035"] = "只需4个即可完成成就"