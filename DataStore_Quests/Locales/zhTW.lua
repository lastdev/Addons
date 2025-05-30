local addonName = ...
local L = AddonFactory:SetLocale(addonName, "zhTW")
if not L then return end

L["AUTO_UPDATE_DISABLED"] = "任務紀錄將繼續留在目前的狀態，無論是空的或過時."
L["AUTO_UPDATE_ENABLED"] = "每次登錄該角色時任務紀錄將刷新一次."
L["AUTO_UPDATE_LABEL"] = "自動更新任務紀錄"
L["AUTO_UPDATE_TITLE"] = "自動更新任務"
L["DAILY_QUESTS_RESET_LABEL"] = "每日任務重置於"
L["TRACK_TURNINS_DISABLED"] = "任務繳交將繼續留在目前的狀態，無論是空的或過時."
L["TRACK_TURNINS_ENABLED"] = "已繳交的任務被保存到任務紀錄，以確保它仍然不斷地有效."
L["TRACK_TURNINS_LABEL"] = "追踪任務繳交"
L["TRACK_TURNINS_TITLE"] = "追踪繳交"
