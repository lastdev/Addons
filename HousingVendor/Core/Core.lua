local ADDON_NAME, ns = ...

local Housing = {}

Housing.version = " 13.12.25.85"

_G.Housing = Housing
ns.Housing = Housing

SLASH_HOUSING1 = "/hv"
SLASH_HOUSING2 = "/housing"
SLASH_HOUSING3 = "/decor"
SlashCmdList["HOUSING"] = function(msg)
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
    
    if cmd == "version" then
        print("Version: " .. Housing.version)
    elseif cmd == "stats" or cmd == "statistics" then
        if HousingCompletionTracker then
            local stats = HousingCompletionTracker:GetStatistics()
            print("|cFF8A7FD4HousingVendor Completion Statistics:|r")
            print("  Vendors visited: |cFFFFD100" .. stats.vendorsVisited .. "|r")
            print("  Achievements earned: |cFFFFD100" .. stats.achievementsEarned .. "|r")
            print("  Quests completed: |cFFFFD100" .. stats.questsCompleted .. "|r")
        else
            print("HousingVendor: CompletionTracker not available")
        end
    elseif cmd == "scan" or cmd == "refresh" or cmd == "rescan" then
        -- Force scan all housing decor items via API
        if CollectionAPI then
            print("|cFF8A7FD4HousingVendor:|r Starting collection scan...")
            print("|cFF808080This may take a moment. Scanning in batches to avoid performance issues.|r")
            
            CollectionAPI:ScanAllDecorItems(function(success, scanned, collected, error)
                if success then
                    local cacheStats = CollectionAPI:GetCacheStats()
                    print("|cFF00FF00Scan complete!|r")
                    print("  Items scanned: |cFFFFD100" .. scanned .. "|r")
                    print("  Newly collected: |cFF00FF00" .. collected .. "|r")
                    print("  Total cached: |cFFFFD100" .. cacheStats.total .. "|r (|cFF808080" .. cacheStats.persistent .. " persistent, " .. cacheStats.session .. " session|r)")
                    
                    -- Refresh UI if open
                    if HousingItemList and HousingItemList.RefreshCollectionStatus then
                        C_Timer.After(0.5, function()
                            HousingItemList:RefreshCollectionStatus()
                        end)
                    end
                else
                    print("|cFFFF0000Scan failed:|r " .. (error or "Unknown error"))
                end
            end)
        else
            print("|cFFFF4040HousingVendor:|r CollectionAPI not available")
        end
    elseif cmd == "version" or cmd == "versioncheck" or cmd == "versionfilter" then
        if HousingVersionFilter then
            local info = HousingVersionFilter:GetCurrentGameVersion()
            local isBeta = HousingVersionFilter:IsBetaClient()
            local expansions = HousingVersionFilter:GetAvailableExpansions()

            print("|cFF8A7FD4HousingVendor Version Filter:|r")
            print("  Game Version: |cFFFFD100" .. (info.version or "Unknown") .. "|r")
            print("  Build: |cFFFFD100" .. (info.build or "Unknown") .. "|r")
            print("  TOC Version: |cFFFFD100" .. (info.tocVersion or "Unknown") .. "|r")
            print("  Client Type: " .. (isBeta and "|cFFFFD100Beta/PTR|r" or "|cFF00FF00Live|r"))
            print("  Available Expansions: |cFFFFD100" .. #expansions .. "|r")

            for _, expansion in ipairs(expansions) do
                print("    - " .. expansion)
            end

            if isBeta then
                print("  |cFFFFD100Midnight content is VISIBLE (Beta client detected)|r")
            else
                print("  |cFF808080Midnight content is HIDDEN (Live client detected)|r")
            end
        else
            print("|cFFFF4040HousingVendor:|r VersionFilter not available")
        end
    else
        if HousingUINew and HousingUINew.Toggle then
            HousingUINew:Toggle()
        else
            print("HousingVendor UI not available - modules may not be loaded")
        end
    end
end
