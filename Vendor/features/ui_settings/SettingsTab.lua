local _, Addon = ...
local Settings = Addon.Features.Settings
local SettingsTab = {}

--[[ Retreive the categories for the rules ]]
function SettingsTab:GetCategories()
    return Settings:GetSettings()
end

function SettingsTab:OnActivate()
    self.settings:EnsureSelection()
    Addon:RegisterCallback(Settings.Events.OnPagesChanged, self,
        GenerateClosure(self.settings.Rebuild, self.settings))
end

function SettingsTab:OnDeactivate()
    Addon:UnregisterCallback(Settings.Events.OnPagesChanged, self)
end

function SettingsTab:ShowSettings(settings)
    local frame = settings.frame
    if (not frame) then
        settings.frame = settings.CreateList(self)
        frame = settings.frame
        self.frames = self.frames or {}
        table.insert(self.frames, frame) 
    end

    -- Hide the other frames
    if (self.frames) then
        for _, f in ipairs(self.frames) do
            if (f ~= frame) then
                f:Hide()
            end
        end
    end

    -- Show this frame
    frame:SetAllPoints(self.host)
    frame:Show()
end

Settings.SettingsTab = SettingsTab