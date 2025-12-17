-- Version Filter for Housing Vendor
-- Automatically hides items not available in the current game version
-- Shows beta content (e.g., Midnight expansion) only when logged into beta client

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

-- Determine if we're on a beta/PTR client
function HousingVersionFilter:IsBetaClient()
    if not self.versionInfo then
        self:GetCurrentGameVersion()
    end

    local version = self.versionInfo.version or ""

    -- Check for beta/PTR indicators in version string
    -- Examples: "11.1.0.57689" (live), "12.0.0.12345" (Midnight beta)
    -- Beta versions typically have version numbers higher than current live
    local versionNumber = tonumber(version:match("^(%d+)%.")) or 0

    -- As of The War Within (11.x), Midnight would be 12.x
    -- Adjust this threshold as expansions release
    local MIDNIGHT_VERSION = 12

    return versionNumber >= MIDNIGHT_VERSION
end

-- Get available expansions for current client
function HousingVersionFilter:GetAvailableExpansions()
    local isBeta = self:IsBetaClient()

    local expansions = {
        "Classic",
        "BurningCrusade",
        "WrathoftheLichKing",
        "Cataclysm",
        "MistsofPandaria",
        "WarlordsofDraenor",
        "Legion",
        "BattleforAzeroth",
        "Shadowlands",
        "Dragonflight",
        "TheWarWithin"
    }

    -- Add Midnight only if on beta client
    if isBeta then
        table.insert(expansions, "Midnight")
    end

    return expansions
end

-- Check if an expansion should be shown
function HousingVersionFilter:ShouldShowExpansion(expansionName)
    local availableExpansions = self:GetAvailableExpansions()

    for _, expansion in ipairs(availableExpansions) do
        if expansion == expansionName then
            return true
        end
    end

    return false
end

-- Filter vendor data by available expansions
function HousingVersionFilter:FilterVendorLocations(vendorLocations)
    if not vendorLocations then
        return {}
    end

    local filtered = {}

    for expansion, zones in pairs(vendorLocations) do
        if self:ShouldShowExpansion(expansion) then
            filtered[expansion] = zones
        end
    end

    return filtered
end

-- Filter items by checking if they're from available expansions
-- This works with the DataManager to hide unavailable items
function HousingVersionFilter:FilterItems(items)
    if not items or not HousingVendorLocations then
        return items
    end

    local availableExpansions = self:GetAvailableExpansions()
    local availableItemIDs = {}

    -- Build set of available item IDs from vendor locations
    for expansion, zones in pairs(HousingVendorLocations) do
        if self:ShouldShowExpansion(expansion) then
            for zoneName, vendors in pairs(zones) do
                for _, vendor in ipairs(vendors) do
                    if vendor.items then
                        for _, item in ipairs(vendor.items) do
                            if item.itemID then
                                availableItemIDs[item.itemID] = true
                            end
                        end
                    end
                end
            end
        end
    end

    -- Filter items list
    local filtered = {}
    for _, item in ipairs(items) do
        local itemID = item.itemID or item.id
        -- If item is in available expansions OR not from vendor data (e.g., professions, drops)
        -- then include it
        if availableItemIDs[itemID] or not item.expansion then
            table.insert(filtered, item)
        elseif item.expansion and self:ShouldShowExpansion(item.expansion) then
            table.insert(filtered, item)
        end
    end

    return filtered
end

-- Initialize and print version info (optional, for debugging)
function HousingVersionFilter:Initialize()
    self:GetCurrentGameVersion()

    -- Optional: Print version info to chat (comment out for production)
    if HousingDB and HousingDB.debug then
        local isBeta = self:IsBetaClient()
        print("|cFF8A7FD4HousingVendor:|r Version Filter Initialized")
        print("  Game Version: " .. (self.versionInfo.version or "Unknown"))
        print("  Build: " .. (self.versionInfo.build or "Unknown"))
        print("  Client Type: " .. (isBeta and "|cFFFFD100Beta/PTR|r" or "|cFF00FF00Live|r"))

        local expansions = self:GetAvailableExpansions()
        print("  Available Expansions: " .. #expansions)

        if isBeta then
            print("  |cFFFFD100Midnight content is visible (Beta client detected)|r")
        else
            print("  |cFF808080Midnight content is hidden (Live client detected)|r")
        end
    end
end

-- Make globally available
_G.HousingVersionFilter = HousingVersionFilter
