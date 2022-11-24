local _, Addon = ...
local locale = Addon:GetLocale()
local SettingsFeature = {
    NAME = "Settings", 
    VERSION = 1,
    Categories = {}
}

--[[
    Called when feature is initialized
]]
function SettingsFeature:OnInitialize()


    local profile = Addon:GetProfile()
	local buyback = profile:GetValue(Addon.c_Config_SellLimit)
    if (buyback) then
        profile:SetValue(Addon.c_Config_SellLimit, true)
    else
        profile:SetValue(Addon.c_Config_SellLimit, false)
    end
end


--[[
     Retrieves a list of all the settings supported, this is an ordered list of items
     based on the categoriies order.  each entry also has a function to create the list
]]
function SettingsFeature:GetSettings()
    local settings = {}
    local categories = self.Categories
    if type(categories) == "table" then
        for _, category in pairs(categories) do
            table.insert(settings, {
                Key = category:GetName(),
                Text = category:GetText(),
                Help = category:GetSummary(),
                Order = category:GetOrder() or 1000,
                CreateList = function(parent)
                    return category:CreateList(parent)
                end
            })
        end
    end

    table.sort(settings, function(a, b)
            return (a.Order < b.Order)
        end)



    return settings
end

--[[
    Callback for when the feature is terminated
]]
function SettingsFeature:OnTerminate()
end

Addon.Features.Settings = SettingsFeature