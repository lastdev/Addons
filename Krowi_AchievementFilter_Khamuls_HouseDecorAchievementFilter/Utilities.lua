local addonName, addon = ...;

addon.Achievements = addon.Achievements or {}

-- Setup some vars
addon.L = LibStub("AceLocale-3.0"):GetLocale(addonName);

function HousingUtilitiesGetAchievementNameWithPrefix(achievementID, prefix) 
    --print(achievementID)
    if not prefix then
        prefix = ""
    end

    local name = GetAchievementName(achievementID)
    
    if name == addon.L["Unknown Achievement"] then
        -- try to get the achievementname from locale
        local achievementLocaleKey = "ACM_" .. achievementID

        if addon.L[achievementLocaleKey] then
            name = addon.L[achievementLocaleKey]
        else
            name = name .. ": (" .. achievementID .. ")"
        end
    end
    
    return prefix .. name
end

function HousingUtilitiesGetAchievementName(achievementID)
    local name = select(2, GetAchievementInfo(achievementID)) or addon.L["Unknown Achievement"]

    return name
end

function HousingUtilitiesReplacePlaceholderInText(template, values) 
    return template:gsub("{(%d+)}", function(index)
        return values[tonumber(index)] or "{" .. index .. "}"
    end)
end