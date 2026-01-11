-- Event handling
local addonName, addon = ...

_G["HousingEvents"] = {}
local HousingEvents = _G["HousingEvents"]

function HousingEvents:OnEvent(event, ...)
  if event == "ADDON_LOADED" then
    local name = ...
    if name == "HousingVendor" then
      -- Avoid using generic globals like `_G.Housing` (can collide with Blizzard UI / other addons).
      local HousingVendorAddon = _G.HousingVendorAddon or {}
      _G.HousingVendorAddon = HousingVendorAddon

      HousingVendorAddon.Initialize = HousingVendorAddon.Initialize or function(self)
        self:InitializeSavedVariables()
        
        -- Initialize other modules with error handling
        local initErrors = {}

        -- CRITICAL: Initialize CollectionAPI FIRST (sets global safety flag and defers other module init)
        -- TAINT FIX: All other Housing API module initialization is now deferred to the 6-second timer
        -- This prevents ANY code from touching C_Housing* globals during ADDON_LOADED
        if HousingCollectionAPI then
          if HousingCollectionAPI.Initialize then
            local success, err = pcall(function() HousingCollectionAPI:Initialize() end)
            if not success then
              table.insert(initErrors, "HousingCollectionAPI: " .. tostring(err))
            end
          end
        end

        -- NOTE: HousingAPI, HousingCatalogAPI, HousingDecorAPI, HousingEditorAPI, and HousingDataEnhancer
        -- are now initialized AFTER the 6-second delay by CollectionAPI:Initialize()
        
        if HousingWaypointManager then
          if HousingWaypointManager.Initialize then
            local success, err = pcall(function() HousingWaypointManager:Initialize() end)
            if not success then
              table.insert(initErrors, "HousingWaypointManager: " .. tostring(err))
            end
          end
        end

        if #initErrors > 0 then
          print("|cFFFF0000Housing|r|cFF0066FFVendor|r version" .. (HousingVendorAddon.version or " unknown") .. " loaded (some modules failed)")
        else
          print("|cFFFF0000Housing|r|cFF0066FFVendor|r version" .. (HousingVendorAddon.version or " unknown") .. " loaded")
        end
      end
      
      HousingVendorAddon.InitializeSavedVariables = HousingVendorAddon.InitializeSavedVariables or function(self)
        -- Schema version for SavedVariables migrations
        local CURRENT_SCHEMA_VERSION = 2

        -- Set defaults if DB doesn't exist
        if not HousingDB then
          HousingDB = {}
        end

        -- Initialize schema version
        if not HousingDB.schemaVersion then
          HousingDB.schemaVersion = 1
        end
        
        -- Initialize saved variables
        if not HousingDB.minimapButton then
          HousingDB.minimapButton = {
            hide = false,
            position = {
              minimapPos = 225,
            },
          }
        end
        
        if not HousingDB.settings then
          HousingDB.settings = {
            showCollected = true,
            usePortalNavigation = true,
            displayMode = "items",
            autoTrackCompletion = false,
            enableMarketData = false,
            preloadApiData = false,
            preloadDataOnLogin = false,
            disableApiCalls = false,
          }
        end

        -- Ensure new settings are initialized for existing users
        if HousingDB.settings.usePortalNavigation == nil then
          HousingDB.settings.usePortalNavigation = true
        end

        if HousingDB.settings.disableApiCalls == nil then
          HousingDB.settings.disableApiCalls = false
        end

        if HousingDB.settings.showCollected == nil then
          HousingDB.settings.showCollected = true
        end

        if HousingDB.settings.autoTrackCompletion == nil then
          HousingDB.settings.autoTrackCompletion = false
        end

        if HousingDB.settings.enableMarketData == nil then
          HousingDB.settings.enableMarketData = false
        end

        if HousingDB.settings.preloadApiData == nil then
          HousingDB.settings.preloadApiData = false
        end
        
        if HousingDB.settings.showOutstandingPopup == nil then
          HousingDB.settings.showOutstandingPopup = true
        end
        
        if HousingDB.settings.autoFilterByZone == nil then
          HousingDB.settings.autoFilterByZone = false
        end

        if HousingDB.settings.preloadDataOnLogin == nil then
          HousingDB.settings.preloadDataOnLogin = false
        end

        -- Migration: preloading the datapack at login defeats low-memory goals.
        -- Disable it once for existing users; they can re-enable via settings if desired.
        if HousingDB.settings.preloadDataOnLogin == true and HousingDB.settings._preloadDataOnLoginDisabledOnce ~= true then
          HousingDB.settings.preloadDataOnLogin = false
          HousingDB.settings._preloadDataOnLoginDisabledOnce = true
          print("|cFF8A7FD4HousingVendor:|r Disabled 'preload data on login' to reduce login memory (re-enable in settings if you really want it).")
        end

        if not HousingDB.uiScale then
          HousingDB.uiScale = 1.0
        end
        
        if not HousingDB.fontSize then
          HousingDB.fontSize = 12
        end

        -- Icon cache is session-only (never persisted to SavedVariables)
        if HousingDB.iconCache ~= nil then
          HousingDB.iconCache = nil
        end
        if HousingDB.settings.persistIconCache ~= nil then
          HousingDB.settings.persistIconCache = nil
        end

        -- Initialize wishlist (account-wide)
        if not HousingDB.wishlist then
          HousingDB.wishlist = {}
        end

        -- KEEP collectedDecor persistent cache - it's now used for instant collection lookup
        -- The "bloat" concern was misplaced: collected items are finite (~3000 max = ~60KB)
        -- Persisting collected status prevents race conditions and improves performance
        if not HousingDB.collectedDecor then
          HousingDB.collectedDecor = {}
        end
        if HousingDB.apiDataCache ~= nil or HousingDB.apiDataCacheAccess ~= nil then
          HousingDB.apiDataCache = nil
          HousingDB.apiDataCacheAccess = nil
        end
        if HousingDB.apiDump ~= nil or HousingDB.apiDumpByFaction ~= nil then
          HousingDB.apiDump = nil
          HousingDB.apiDumpByFaction = nil
        end
        if collectgarbage then
          collectgarbage("step", 1000)
        end

        -- Migration: Remove deprecated collectedItems field (replaced by collectedDecor)
        if HousingDB.collectedItems ~= nil then
          HousingDB.collectedItems = nil
        end

        -- Run schema migrations
        self:MigrateSchema()
      end

      HousingVendorAddon.MigrateSchema = HousingVendorAddon.MigrateSchema or function(self)
        local CURRENT_SCHEMA_VERSION = 2
        local version = HousingDB.schemaVersion or 1

        -- Migration from v1 to v2
        if version < 2 then
          -- v2: Removed deprecated collectedItems field
          -- (Already handled above, but formalized here)
          if HousingDB.collectedItems ~= nil then
            HousingDB.collectedItems = nil
          end

          HousingDB.schemaVersion = 2
        end

        -- Future migrations go here
        -- if version < 3 then
        --   -- Migration from v2 to v3
        --   HousingDB.schemaVersion = 3
        -- end
      end
      
      HousingVendorAddon:Initialize()

      -- Initialize VersionFilter (should be done early to filter expansion data)
      if HousingVersionFilter then
        local success, err = pcall(HousingVersionFilter.Initialize, HousingVersionFilter)
        if not success then
          print("HousingVendor: VersionFilter initialization error: " .. tostring(err))
        end
      end

      -- Initialize Performance Auditor
      if HousingPerformanceAuditor then
        local success, err = pcall(HousingPerformanceAuditor.Initialize, HousingPerformanceAuditor)
        if not success then
          print("HousingVendor: PerformanceAuditor initialization error: " .. tostring(err))
        end
      end

      -- PERFORMANCE: Defer heavy initialization until UI is actually opened
      -- DataManager.Initialize() processes 2,319 items and causes 20%+ CPU spike at login
      -- These modules are now lazy-initialized when the UI opens (see HousingUI.lua)

      -- DataManager, Icons, ConfigUI, StatisticsUI, OutstandingItemsUI, and HousingUINew
      -- will auto-initialize when first accessed via their Initialize() methods

      -- NOTE: Heavy modules (DataManager, ConfigUI, StatisticsUI, etc.) are now
      -- lazy-initialized when HousingUI:Toggle() is first called.
      -- This reduces login CPU from 22% to near-zero.
    end
  end

  if event == "PLAYER_LOGIN" then
    -- PERFORMANCE: Removed preload and CreateCatalogSearcher from login
    -- These were causing unnecessary CPU usage at login
    -- Both are now deferred until the UI is actually opened

    -- CRITICAL: If zone popup is enabled, we MUST process data at login
    -- Zone popup needs HousingExpansionData to detect items in zones
    if HousingDB and HousingDB.settings and HousingDB.settings.showOutstandingPopup then
      -- Process deferred data aggregation so zone popup has data to work with
      if HousingDataAggregator and HousingDataAggregator.ProcessPendingData then
        HousingDataAggregator:ProcessPendingData()
      end

      -- Start zone popup event handlers
      if HousingOutstandingItemsUI and HousingOutstandingItemsUI.StartEventHandlers then
        pcall(HousingOutstandingItemsUI.StartEventHandlers, HousingOutstandingItemsUI)
      end
    end
  end

  if event == "PLAYER_LOGOUT" then
    if HousingEvents.Shutdown then
      HousingEvents:Shutdown()
    end
  end
end

function HousingEvents:Shutdown()
  print("|cFF8A7FD4HousingVendor:|r Shutting down...")

  if HousingDataManager and HousingDataManager.SetUIActive then
    HousingDataManager:SetUIActive(false)
  end
  if HousingDataManager and HousingDataManager.CancelBatchLoads then
    HousingDataManager:CancelBatchLoads()
  end

  if HousingAPICache and HousingAPICache.StopCleanupTimer then
    HousingAPICache:StopCleanupTimer()
  end
  if HousingDataEnhancer and HousingDataEnhancer.StopMarketRefresh then
    HousingDataEnhancer:StopMarketRefresh()
  end
  if HousingCollectionAPI and HousingCollectionAPI.StopEventHandlers then
    HousingCollectionAPI:StopEventHandlers()
  end
  if HousingWaypointManager and HousingWaypointManager.ClearWaypoint then
    HousingWaypointManager:ClearWaypoint()
  end
  if HousingOutstandingItemsUI and HousingOutstandingItemsUI.StopEventHandlers then
    HousingOutstandingItemsUI:StopEventHandlers()
  end
  if HousingItemList and HousingItemList.Cleanup then
    HousingItemList:Cleanup()
  end
  if HousingReputation and HousingReputation.StopTracking then
    HousingReputation:StopTracking()
  end

  collectgarbage("collect")
end

-- Register events
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", function(self, event, ...)
  HousingEvents:OnEvent(event, ...)
end)
