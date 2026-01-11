-- LegacyCompat.lua
-- Build minimal legacy tables expected by older modules using the new data format.

local _G = _G

if not _G.HousingDecorData then
    _G.HousingDecorData = {}
end

local HousingDecorData = _G.HousingDecorData
local HousingAllItems = _G.HousingAllItems
local HousingDNTItems = _G.HousingDNTItems

if type(HousingAllItems) == "table" then
    for itemID, decorData in pairs(HousingAllItems) do
        local itemIDNum = tonumber(itemID)
        if itemIDNum and not HousingDecorData[itemIDNum] then
            -- Skip known DNT items to match previous behavior.
            if not (HousingDNTItems and HousingDNTItems[itemIDNum]) then
                HousingDecorData[itemIDNum] = {
                    decorID = decorData[1],
                    modelFileID = decorData[2] or 0,
                    iconFileID = decorData[3] or 0,
                }
            end
        end
    end
end

