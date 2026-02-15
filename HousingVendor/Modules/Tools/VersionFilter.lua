-- Version Filter for Housing Vendor
-- Automatically hides items not available in the current game version
-- NOTE: Version gating has been retired in this addon build (all expansion data is always visible).

local HousingVersionFilter = {}

-- Version detection using WoW API
function HousingVersionFilter:GetCurrentGameVersion()
    local version, build, date, tocVersion = GetBuildInfo()

    -- Store version info
    self.versionInfo = {
        version = version,
        build = tonumber(build) or 0,
        date = date,
        tocVersion = tonumber(tocVersion) or 0
    }

    return self.versionInfo
end

-- Get available expansions for current client
function HousingVersionFilter:GetAvailableExpansions()
    -- Version gating retired: always expose all expansions shipped with the addon data.
    return {
        "Classic",
        "The Burning Crusade",
        "Wrath of the Lich King",
        "Cataclysm",
        "Mists of Pandaria",
        "Warlords of Draenor",
        "Legion",
        "Battle for Azeroth",
        "Shadowlands",
        "Dragonflight",
        "The War Within",
        "Midnight",
    }
end

-- Check if an expansion should be shown
function HousingVersionFilter:ShouldShowExpansion(expansionName)
    -- Version gating retired: never hide by expansion name.
    return true
end

-- Filter vendor data by available expansions
function HousingVersionFilter:FilterVendorLocations(vendorLocations)
    return vendorLocations or {}
end

-- Filter items by checking if they're from available expansions
-- This works with the DataManager to hide unavailable items
function HousingVersionFilter:FilterItems(items)
    -- Version gating retired: keep item lists untouched.
    return items
end

-- Initialize and print version info (optional, for debugging)
function HousingVersionFilter:Initialize()
    self:GetCurrentGameVersion()

    -- Optional: Print version info to chat (comment out for production)
    if HousingDB and HousingDB.debug then
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("Version Filter Initialized")
            _G.HousingVendorLog:Info("  Game Version: " .. (self.versionInfo.version or "Unknown"))
            _G.HousingVendorLog:Info("  Build: " .. (self.versionInfo.build or "Unknown"))
            _G.HousingVendorLog:Info("  Client Type: Live")
        end

        local expansions = self:GetAvailableExpansions()
        if _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("  Available Expansions: " .. #expansions)
            _G.HousingVendorLog:Info("  Version gating: OFF")
        end
    end
end

-- Make globally available
_G.HousingVersionFilter = HousingVersionFilter
