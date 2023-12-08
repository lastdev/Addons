local addonName = ...
local addon = _G[addonName]

local eventFrame = CreateFrame("Frame")
local tldrButton = CreateFrame("Button", "TLDRMissionsToggleButton", UIParent, "UIPanelButtonTemplate")
tldrButton:SetText("TL;DR")
tldrButton:SetWidth(80)
tldrButton:SetHeight(25)
TLDRMissionsToggleButtonText:SetScale(1.3)
tldrButton:Hide()

tldrButton:SetScript("OnClick", function (self, button)
    addon.GUI:SetShown(not addon.GUI:IsShown())
end)

local shortcutButton = CreateFrame("Button", "TLDRMissionsShortcutButton", UIParent, "UIPanelButtonTemplate")
shortcutButton:SetText(GARRISON_START_MISSION)
shortcutButton:SetWidth(80)
shortcutButton:SetHeight(15)
shortcutButton:SetPoint("TOPLEFT", tldrButton, "BOTTOMLEFT")
shortcutButton:Hide()

shortcutButton:SetScript("OnClick", function(self, button)
    if #C_Garrison.GetCompleteMissions(123) > 0 then
        addon.GUI.CompleteMissionsButton.usedShortcut = true
        addon.GUI.CompleteMissionsButton:Click()
        return
    end
    if addon.GUI.CalculateButton:IsEnabled() then
        addon.GUI.CalculateButton:Click()
    end
end)

addon.GUI.shortcutButton = shortcutButton

local function adventureMapOpenHandler(followerTypeID)
    if followerTypeID ~= 123 then return end

    tldrButton:Show()
    tldrButton:SetParent(CovenantMissionFrame.MissionTab)
    tldrButton:SetPoint("TOPLEFT", CovenantMissionFrame, 80, -20)
    tldrButton:SetFrameStrata("DIALOG")
    addon.GUI:SetParent(CovenantMissionFrame)
    addon.GUI:SetFrameStrata("DIALOG")
    addon.GUI:SetShown(addon.db.profile.autoShowUI)
    if (not addon.GUI:IsUserPlaced()) and (not addon.db.profile.guiX) and (not addon.db.profile.guiY) then
        addon.GUI:ClearAllPoints()
        addon.GUI:SetPoint("RIGHT", CovenantMissionFrame, "LEFT")
    end
    
    if addon.db.profile.autoStart then
        shortcutButton:Show()
        shortcutButton:SetText(COVENANT_MISSIONS_START_ADVENTURE)
        shortcutButton:SetParent(CovenantMissionFrame.MissionTab)
        shortcutButton:SetFrameStrata("DIALOG")
    else
        shortcutButton:Hide()
    end
end

local function adventureMapClosedHandler()
    tldrButton:Hide()
    addon.GUI:Hide()
    shortcutButton:Hide()
end

local itemInfoCache = {}
function addon:GetItemInfo(itemID)
    if itemInfoCache[itemID] then
        return unpack(itemInfoCache[itemID])
    end
    return GetItemInfo(itemID)
end
local function preloadItemRewards()
    local missions = C_Garrison.GetAvailableMissions(123)
    if not missions then return end
    for _, mission in pairs(missions) do
        for _, reward in pairs(mission.rewards) do
            if reward.itemID then
                local item = Item:CreateFromItemID(reward.itemID)
                item:ContinueOnItemLoad(function()
                	itemInfoCache[reward.itemID] = {GetItemInfo(reward.itemID)}
                end)
            end
        end
    end
end

local function eventHandler(self, event, ...)
    local arg1 = ...
    if event == "GARRISON_MISSION_NPC_OPENED" then
        if arg1 ~= 123 then return end
        if C_Map.GetBestMapForUnit("player") == 2022 then return end -- this is The Waking Shores. There is an interactable "Scouting Map" that passes in 123 for some reason.
        if C_Map.GetBestMapForUnit("player") == 2024 then return end -- same with Azure Span - from the Blue Dragon quests campaign
        adventureMapOpenHandler(arg1)
        preloadItemRewards()
        if #C_Garrison.GetCompleteMissions(123) == 0 then
            addon.GUI.CompleteMissionsButton:Hide()
        else
            addon.GUI.CompleteMissionsButton:Show()
        end
    elseif (event == "ADDON_LOADED") then
        if _G.GarrisonLandingPageFollowerList then
			addon.followerList:Init()
		end
    elseif event == "GARRISON_MISSION_COMPLETE_RESPONSE" then
        addon:logCompletedMission(...)
    elseif event == "GARRISON_MISSION_STARTED" then
        addon:garrisonMissionStartedHandler(...)
    elseif event == "GARRISON_MISSION_FINISHED" then
        addon.GUI.CompleteMissionsButton:Show()
    elseif event == "GARRISON_SHIPYARD_NPC_CLOSED" then
        adventureMapClosedHandler()
    end
end

eventFrame:SetScript("OnEvent", eventHandler)
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE")
eventFrame:RegisterEvent("GARRISON_MISSION_STARTED")
eventFrame:RegisterEvent("GARRISON_MISSION_FINISHED")
eventFrame:RegisterEvent("GARRISON_MISSION_NPC_OPENED")
eventFrame:RegisterEvent("GARRISON_SHIPYARD_NPC_CLOSED")

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    addon:RefreshProfile()
end)
