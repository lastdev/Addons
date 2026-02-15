local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

local function OnPlayerLogin()
    -- Logger.Log("OnPlayerLogin start...")

    DelveCompanion.AddonSettings:Init()

    DelveCompanion.Variables.maxLevelReached =
        UnitLevel("player") == GetMaxLevelForExpansionLevel(Config.DELVES_MIN_EXPANSION)
    DelveCompanion_TooltipExtension_Init()

    -- Logger.Log("OnPlayerLogin finish")
end

local function OnAddonLoaded()
    -- Logger.Log("OnAddonLoaded start...")

    DelveCompanion.Variables.tomTomAvailable = TomTom ~= nil
    DelveCompanion.Variables.mpeAvailable = MapPinEnhanced ~= nil

    DelveCompanion:InitAccountSave()
    DelveCompanion:InitCharacterSave()

    DelveCompanion:InitDelvesData()

    -- Logger.Log("OnAddonLoaded finish")
end

-- EventRegistry:RegisterFrameEventAndCallback("ADDON_LOADED", function(_, name)
--     Logger.Log(name)
-- end)
-- EventRegistry:RegisterFrameEventAndCallback("GOSSIP_SHOW", function(payload, arg1, arg2)
--     if arg1 == "delves-difficulty-picker" then
--         -- local options = DelvesDifficultyPickerFrame:GetOptions()
--         Logger.Log("=================")
--         Logger.Log("Modifiers info:")
--         Logger.LogTable(DelvesDifficultyPickerFrame.DelveModifiersWidgetContainer.widgetFrames)
--     end
-- end)
EventRegistry:RegisterFrameEventAndCallback("PLAYER_LOGIN", OnPlayerLogin)
EventUtil.ContinueOnAddOnLoaded(addonName, OnAddonLoaded)
