-- Housing API Integration for HousingVendor addon
local HousingAPI = {}
HousingAPI.__index = HousingAPI

-- Check if housing APIs are available
function HousingAPI:IsAvailable()
    return C_HousingCatalog ~= nil
end

-- Get the current data mode (static, hybrid, or live)
function HousingAPI:GetDataMode()
    if self:IsAvailable() then
        return "hybrid"  -- Static data enhanced with live data
    else
        return "static"  -- Static data only
    end
end

-- Initialize the API module
function HousingAPI:Initialize()
    print("HousingAPI: Initializing...")
    
    -- Load submodules
    if self:IsAvailable() then
        print("HousingAPI: Live housing APIs detected, enabling enhanced features")
    else
        print("HousingAPI: Live housing APIs not available, using static data only")
    end
end