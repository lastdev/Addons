-- Event handling
local addonName, addon = ...

_G["HousingEvents"] = {}
local HousingEvents = _G["HousingEvents"]

function HousingEvents:OnEvent(event, ...)
  if event == "ADDON_LOADED" then
    local name = ...
    if name == "HousingVendor" then
      -- Make Housing globally available
      _G.Housing = Housing or {}
      Housing.Initialize = Housing.Initialize or function(self)
        self:InitializeSavedVariables()
        
        -- Initialize other modules with error handling
        local initErrors = {}
        
        if HousingAPI then
          if HousingAPI.Initialize then
            local success, err = pcall(function() HousingAPI:Initialize() end)
            if not success then
              table.insert(initErrors, "HousingAPI: " .. tostring(err))
            end
          end
        end
        
        if HousingCatalogAPI then
          if HousingCatalogAPI.Initialize then
            local success, err = pcall(function() HousingCatalogAPI:Initialize() end)
            if not success then
              table.insert(initErrors, "HousingCatalogAPI: " .. tostring(err))
            end
          end
        end
        
        if CollectionAPI then
          if CollectionAPI.Initialize then
            local success, err = pcall(function() CollectionAPI:Initialize() end)
            if not success then
              table.insert(initErrors, "CollectionAPI: " .. tostring(err))
            end
          end
        end
        
        if HousingDecorAPI then
          if HousingDecorAPI.Initialize then
            local success, err = pcall(function() HousingDecorAPI:Initialize() end)
            if not success then
              table.insert(initErrors, "HousingDecorAPI: " .. tostring(err))
            end
          end
        end
        
        if HousingEditorAPI then
          if HousingEditorAPI.Initialize then
            local success, err = pcall(function() HousingEditorAPI:Initialize() end)
            if not success then
              table.insert(initErrors, "HousingEditorAPI: " .. tostring(err))
            end
          end
        end
        
        if HousingDataEnhancer then
          if HousingDataEnhancer.Initialize then
            local success, err = pcall(function() HousingDataEnhancer:Initialize() end)
            if not success then
              table.insert(initErrors, "HousingDataEnhancer: " .. tostring(err))
            end
          end
        end
        
        if HousingIconCache then
          if HousingIconCache.Initialize then
            local success, err = pcall(function() HousingIconCache:Initialize() end)
            if not success then
              table.insert(initErrors, "HousingIconCache: " .. tostring(err))
            end
          end
        end

        if HousingWaypointManager then
          if HousingWaypointManager.Initialize then
            local success, err = pcall(function() HousingWaypointManager:Initialize() end)
            if not success then
              table.insert(initErrors, "HousingWaypointManager: " .. tostring(err))
            end
          end
        end

        if #initErrors > 0 then
          print("|cFFFF0000Housing|r|cFF0066FFVendor|r version" .. (Housing.version or " unknown") .. " loaded (some modules failed)")
        else
          print("|cFFFF0000Housing|r|cFF0066FFVendor|r version" .. (Housing.version or " unknown") .. " loaded")
        end
      end
      
      Housing.InitializeSavedVariables = Housing.InitializeSavedVariables or function(self)
        -- Set defaults if DB doesn't exist
        if not HousingDB then
          HousingDB = {}
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
          }
        end

        -- Ensure new settings are initialized for existing users
        if HousingDB.settings.usePortalNavigation == nil then
          HousingDB.settings.usePortalNavigation = true
        end

        if HousingDB.settings.showCollected == nil then
          HousingDB.settings.showCollected = true
        end
        
        if not HousingDB.collectedItems then
          HousingDB.collectedItems = {}
        end
        
        if not HousingDB.uiScale then
          HousingDB.uiScale = 1.0
        end
        
        if not HousingDB.fontSize then
          HousingDB.fontSize = 12
        end
        
        -- Initialize icon cache
        if not HousingDB.iconCache then
          HousingDB.iconCache = {}
        end
        
        -- Initialize collection cache
        if not HousingDB.collectedDecor then
          HousingDB.collectedDecor = {}
        end
        
        -- Initialize wishlist (account-wide)
        if not HousingDB.wishlist then
          HousingDB.wishlist = {}
        end
      end
      
      Housing:Initialize()

      -- Initialize VersionFilter (should be done early to filter expansion data)
      if HousingVersionFilter then
        local success, err = pcall(HousingVersionFilter.Initialize, HousingVersionFilter)
        if not success then
          print("HousingVendor: VersionFilter initialization error: " .. tostring(err))
        end
      end

      -- Initialize DataManager and Icons first (required by UI)
      if HousingDataManager then
        local success, err = pcall(HousingDataManager.Initialize, HousingDataManager)
        if not success then
          print("HousingVendor: DataManager initialization error: " .. tostring(err))
        end
      end
      
      if HousingIcons then
        local success, err = pcall(HousingIcons.Initialize, HousingIcons)
        if not success then
          print("HousingVendor: Icons initialization error: " .. tostring(err))
        end
      end

      -- Initialize config UI
      if HousingConfigUI then
        local success, err = pcall(HousingConfigUI.Initialize, HousingConfigUI)
        if not success then
          print("HousingVendor: ConfigUI initialization error: " .. tostring(err))
        end
      end
      
      -- Initialize statistics UI
      if HousingStatisticsUI then
        local success, err = pcall(HousingStatisticsUI.Initialize, HousingStatisticsUI)
        if not success then
          print("HousingVendor: StatisticsUI initialization error: " .. tostring(err))
        end
      end

      -- Initialize new UI after all modules and data are loaded
      if HousingUINew then
        local success, err = pcall(HousingUINew.Initialize, HousingUINew)
        if success then
          -- Silently initialized
        else
          print("HousingVendor UI initialization error: " .. tostring(err))
        end
      else
        print("HousingVendor UI module not found - check file loading order")
      end
      
      -- Debug: Check if modules are loaded
      if HousingDebugPrint then
        HousingDebugPrint("Module check:")
        HousingDebugPrint("  HousingDataManager: " .. tostring(HousingDataManager ~= nil))
        HousingDebugPrint("  HousingIcons: " .. tostring(HousingIcons ~= nil))
        HousingDebugPrint("  HousingUINew: " .. tostring(HousingUINew ~= nil))
        HousingDebugPrint("  HousingItemList: " .. tostring(HousingItemList ~= nil))
        HousingDebugPrint("  HousingFilters: " .. tostring(HousingFilters ~= nil))
        HousingDebugPrint("  HousingPreviewPanel: " .. tostring(HousingPreviewPanel ~= nil))
      end
    end
  end
end

-- Register events
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, ...)
  HousingEvents:OnEvent(event, ...)
end)