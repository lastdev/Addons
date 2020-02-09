local addonName, addon = ...
-- If ACP is enabled, conditionally hook GetAddOnInfo to set the short name to be displayed in the ACP Group By Name control panel
local _, _, _, ACP_ENABLED = GetAddOnInfo("ACP")
if (ACP_ENABLED) then
    local func = GetAddOnInfo
    --noinspection GlobalCreationOutsideO
    function GetAddOnInfo(indexOrName)
        local addonInfo = { func(indexOrName) }
        --TODO: Make compatible with other locales: Group By Name, and title value
        if ((addonInfo[1] == addonName) and (ACP_Data) and (ACP_Data.sorter == "Group By Name")) then
            addonInfo[2] = "Holidays (Hallow's End)"
        end
        return unpack(addonInfo)
    end
end
