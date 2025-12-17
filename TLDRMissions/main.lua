local addonName, addon = ...

addon.GUI = CreateFrame("Frame", "TLDRMissionsFrame", UIParent, "BackdropTemplate")
addon.WODGUI = CreateFrame("Frame", "TLDRMissionsWODFrame", UIParent, "BackdropTemplate")
addon.LegionGUI = CreateFrame("Frame", "TLDRMissionsLegionFrame", UIParent, "BackdropTemplate")
addon.BFAGUI = CreateFrame("Frame", "TLDRMissionsBFAFrame", UIParent, "BackdropTemplate")

local GUIs = {
    [Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower] = addon.WODGUI,
    [Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower] = addon.LegionGUI,
    [Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower] = addon.BFAGUI,
    [Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower] = addon.GUI,
}
function addon:GetGUI(followerTypeID)
    return GUIs[followerTypeID]
end

for followerTypeID, gui in pairs(GUIs) do
    gui.followerTypeID = followerTypeID
end

addon.BaseGUIMixin = {}

addon.BFAGUI.RESOURCE_CURRENCY_ID = 1560
addon.LegionGUI.RESOURCE_CURRENCY_ID = 1220

addon.BFAGUI.missionFrame = BFAMissionFrame
addon.LegionGUI.missionFrame = OrderHallMissionFrame