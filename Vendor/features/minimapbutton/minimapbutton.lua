local AddonName, Addon = ...
local L = Addon:GetLocale()


-- Feature Definition
local MinimapButton = {
    NAME = "MinimapButton",
    VERSION = 1,
    -- you can also use GetDependencies
    DEPENDENCIES = {
        "LibDataBroker",
        "LDBStatusPlugin",
    },
}

-- Default minimap state and position
local mapdefault = {
    hide = false,
    minimapPos = 225
}

-- Used for tracking the actual data.
-- The button holds truth since it can be manipulated by other addons to manage how minimap buttons
-- appear. So another addon may disable our minimap button on the user's behalf so we will reflect
-- that state here.
local minimapButton = nil

function MinimapButton:Get()
    return minimapButton
end

local function updateMinimapButtonVisibility()
    if not minimapButton then return end
    local accountMapData = Addon:GetAccountSetting(Addon.c_Config_MinimapData)


    if accountMapData.hide then
        minimapButton.hide = true
        minimapButton:Hide()
    else
        minimapButton.hide = false
        minimapButton:Show()
    end
end

local function saveMinimapSettings()
    -- It's possible the minimap button wasn't created if the dependency is missing.
    if not minimapButton then return end

    -- The button holds truth since it can be manipulated by other addons to manage how minimap buttons
    -- appear. So another addon may disable our minimap button on the user's behalf so we will reflect
    -- that state here.
    -- It's possible the minimap button wasn't created if the dependency is missing.
    Addon:SetAccountSetting(Addon.c_Config_MinimapData, minimapButton.db)
end

local function resetMinimapDataToDefault()

    Addon:SetAccountSetting(Addon.c_Config_MinimapData, mapdefault)
end

function MinimapButton:CreateSettingForMinimapButton()
    return Addon.Features.Settings.CreateSetting(nil, true, self.IsMinimapButtonEnabled, self.SetMinimapButtonEnabled)
end

function MinimapButton.IsMinimapButtonEnabled()
    local accountMapData = Addon:GetAccountSetting(Addon.c_Config_MinimapData)
    if accountMapData then
        return not accountMapData.hide
    else
        -- Going to assume that if the data is corrupted or missing they want the minimap button.
        -- this should help get back into a good state.
        resetMinimapDataToDefault()
        return true
    end
end

function MinimapButton.SetMinimapButtonEnabled(value)
    local accountMapData = Addon:GetAccountSetting(Addon.c_Config_MinimapData)
    if value then
        accountMapData.hide = false
        Addon:SetAccountSetting(Addon.c_Config_MinimapData, accountMapData)
    else
        accountMapData.hide = true
        Addon:SetAccountSetting(Addon.c_Config_MinimapData, accountMapData)
    end
end

function MinimapButton:Create()
    -- If this is already created we have nothing to create.
    if minimapButton then
        return true
    end

    -- We depend on LibDataBroker for this and the LDBIcon library.
    local ldb = Addon:GetFeature("LibDataBroker")
    if not ldb or not ldb:IsLDBIconAvailable() then

        return false
    end

    -- We also require the LDBStatusPlugin to be enabled.
    local ldbstatusplugin = Addon:GetFeature("LDBStatusPlugin")
    if not ldbstatusplugin then

        return false
    end

    -- Get data from the account setting.
    local accountMapData = Addon:GetAccountSetting(Addon.c_Config_MinimapData, mapdefault)

    -- Create the minimap button.
    minimapButton = ldb:CreateLDBIcon(ldbstatusplugin:GetDataObjectName(), accountMapData)


    return not not minimapButton
end

function MinimapButton:OnInitialize()

    local created = self:Create()
    if not created then

        return
    end


end

function MinimapButton:OnTerminate()

    saveMinimapSettings()
end

function MinimapButton:OnAccountSettingChange(settings)
    if not minimapButton then return end
    if (settings[Addon.c_Config_MinimapData]) then

        updateMinimapButtonVisibility()
    end
end

Addon.Features.MinimapButton = MinimapButton