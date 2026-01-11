-- Main UI Module
-- Midnight Theme - Clean, Modern, Performant

local ADDON_NAME, ns = ...
local L = ns.L

local HousingUI = {}
HousingUI.__index = HousingUI

local mainFrame = nil
local isInitialized = false
local isCleaningUp = false

-- Version info (from TOC file)
local ADDON_VERSION = C_AddOns.GetAddOnMetadata("HousingVendor", "Version") or "1.0.0"

-- Theme reference (loaded from UITheme.lua)
local Theme = nil

--------------------------------------------------------------------------------
-- INITIALIZATION
--------------------------------------------------------------------------------

function HousingUI:Initialize()
    if isInitialized then
        return
    end
    
    -- Get theme reference
    Theme = HousingTheme or {}

    -- IMPORTANT: Do not force-load large data at login.
    -- Data is loaded on-demand when the user opens the UI (`/hv`).

    -- PERFORMANCE: Process deferred data aggregation before initializing modules
    -- This was previously done at ADDON_LOADED, causing 20%+ CPU spike at login
    if HousingDataAggregator and HousingDataAggregator.ProcessPendingData then
        HousingDataAggregator:ProcessPendingData()
    end

    -- Ensure data manager is initialized
    if HousingDataManager then
        HousingDataManager:Initialize()
    else
        print("|cFF8A7FD4HousingVendor:|r HousingDataManager not found")
        return
    end
    
    -- Ensure icon cache is initialized
    if HousingIcons then
        HousingIcons:Initialize()
    else
        print("|cFF8A7FD4HousingVendor:|r HousingIcons not found")
        return
    end
    
    -- Create main frame
    local success, err = pcall(function()
        mainFrame = self:CreateMainFrame()
    end)
    
    if not success then
        print("|cFF8A7FD4HousingVendor:|r Error creating main frame: " .. tostring(err))
        return
    end
    
    isInitialized = true
end

--------------------------------------------------------------------------------
-- MAIN FRAME CREATION
--------------------------------------------------------------------------------

function HousingUI:CreateMainFrame()
    local frame = CreateFrame("Frame", "HousingFrameNew", UIParent, "BackdropTemplate")
    
    -- Use theme dimensions or defaults
    local dims = Theme.Dimensions or {}
    frame:SetSize(dims.mainFrameWidth or 1100, dims.mainFrameHeight or 700)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("HIGH")
    frame:Hide()
    
    -- Apply saved scale
    if HousingDB and HousingDB.uiScale then
        frame:SetScale(HousingDB.uiScale)
    end
    
    -- Make movable
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClampedToScreen(true)
    
    -- Apply Midnight theme backdrop
    self:ApplyMainBackdrop(frame)
    
    -- Drag handlers
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
    
    -- Create UI sections
    self:CreateHeader(frame)
    self:CreateCloseButton(frame)
    self:CreateFooter(frame)

    -- Centralize cleanup so it runs even when the frame is closed via ESC/Blizzard close flows.
    frame:HookScript("OnHide", function()
        self:CleanupAfterClose()
    end)

    -- Store frame reference
    _G["HousingFrameNew"] = frame

    return frame
end

--------------------------------------------------------------------------------
-- MIDNIGHT THEME BACKDROP
--------------------------------------------------------------------------------

function HousingUI:ApplyMainBackdrop(frame)
    local colors = Theme.Colors or {}
    
    -- Main backdrop
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 2,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    -- Deep midnight purple background
    local bg = HousingTheme.Colors.bgPrimary
    frame:SetBackdropColor(bg[1], bg[2], bg[3], bg[4])
    
    -- Subtle purple border
    local border = HousingTheme.Colors.borderPrimary
    frame:SetBackdropBorderColor(border[1], border[2], border[3], border[4])
    
    -- Add inner glow effect (subtle gradient overlay)
    local glowTop = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
    glowTop:SetTexture("Interface\\Buttons\\WHITE8x8")
    glowTop:SetPoint("TOPLEFT", 2, -2)
    glowTop:SetPoint("TOPRIGHT", -2, -2)
    glowTop:SetHeight(100)
    glowTop:SetGradient("VERTICAL", 
        CreateColor(0.15, 0.12, 0.25, 0.4), 
        CreateColor(0.08, 0.06, 0.12, 0))
    
    -- Bottom gradient (subtle)
    local glowBottom = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
    glowBottom:SetTexture("Interface\\Buttons\\WHITE8x8")
    glowBottom:SetPoint("BOTTOMLEFT", 2, 2)
    glowBottom:SetPoint("BOTTOMRIGHT", -2, 2)
    glowBottom:SetHeight(60)
    glowBottom:SetGradient("VERTICAL", 
        CreateColor(0.08, 0.06, 0.12, 0), 
        CreateColor(0.05, 0.04, 0.08, 0.5))
end

--------------------------------------------------------------------------------
-- HEADER
--------------------------------------------------------------------------------

function HousingUI:CreateHeader(parent)
    local colors = Theme.Colors or {}
    local dims = Theme.Dimensions or {}
    local headerHeight = dims.headerHeight or 50
    
    -- Get player faction
    local playerFaction = UnitFactionGroup("player") -- "Alliance" or "Horde"
    local factionColor, factionIcon
    
    if playerFaction == "Alliance" then
        factionColor = CreateColor(0.12, 0.35, 0.65, 0.95)  -- Alliance blue
        factionIcon = "Interface\\Icons\\Achievement_PVP_A_A"  -- Alliance icon
    elseif playerFaction == "Horde" then
        factionColor = CreateColor(0.60, 0.08, 0.08, 0.95)  -- Horde red
        factionIcon = "Interface\\Icons\\Achievement_PVP_H_H"  -- Horde icon
    else
        factionColor = CreateColor(0.12, 0.08, 0.20, 0.95)  -- Neutral purple
        factionIcon = "Interface\\Icons\\INV_Misc_Map02"  -- Default icon
    end
    
    -- Header container
    local header = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    header:SetPoint("TOPLEFT", 2, -2)
    header:SetPoint("TOPRIGHT", -2, -2)
    header:SetHeight(headerHeight)
    
    -- Header background with faction-colored gradient
    local headerBg = header:CreateTexture(nil, "BACKGROUND")
    headerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    headerBg:SetAllPoints()
    
    if playerFaction == "Alliance" then
        headerBg:SetGradient("HORIZONTAL", 
            CreateColor(0.12, 0.35, 0.65, 0.95),  -- Alliance blue
            CreateColor(0.08, 0.25, 0.50, 0.95))
    elseif playerFaction == "Horde" then
        headerBg:SetGradient("HORIZONTAL", 
            CreateColor(0.60, 0.08, 0.08, 0.95),  -- Horde red
            CreateColor(0.45, 0.06, 0.06, 0.95))
    else
        headerBg:SetGradient("HORIZONTAL", 
            CreateColor(0.12, 0.08, 0.20, 0.95),  -- Neutral purple
            CreateColor(0.08, 0.06, 0.15, 0.95))
    end
    
    -- Bottom accent line (faction colored)
    local accentLine = header:CreateTexture(nil, "BORDER")
    accentLine:SetTexture("Interface\\Buttons\\WHITE8x8")
    accentLine:SetPoint("BOTTOMLEFT", 0, 0)
    accentLine:SetPoint("BOTTOMRIGHT", 0, 0)
    accentLine:SetHeight(2)
    
    if playerFaction == "Alliance" then
        accentLine:SetVertexColor(0.30, 0.60, 0.95, 0.8)  -- Bright Alliance blue
    elseif playerFaction == "Horde" then
        accentLine:SetVertexColor(0.90, 0.15, 0.15, 0.8)  -- Bright Horde red
    else
        local accent = HousingTheme.Colors.accentPrimary
        accentLine:SetVertexColor(accent[1], accent[2], accent[3], 0.8)
    end
    
    -- Faction icon (instead of generic map icon) - Full height
    local titleIcon = header:CreateTexture(nil, "ARTWORK")
    titleIcon:SetSize(headerHeight - 4, headerHeight - 4)  -- Full height minus padding
    titleIcon:SetPoint("LEFT", 8, 0)
    titleIcon:SetTexture(factionIcon)
    titleIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92) -- Trim icon borders
    
    -- Icon border glow (faction colored)
    local iconGlow = header:CreateTexture(nil, "BACKGROUND")
    iconGlow:SetSize(headerHeight, headerHeight)  -- Full header height
    iconGlow:SetPoint("CENTER", titleIcon, "CENTER")
    iconGlow:SetTexture("Interface\\Buttons\\WHITE8x8")
    
    if playerFaction == "Alliance" then
        iconGlow:SetVertexColor(0.30, 0.60, 0.95, 0.3)
    elseif playerFaction == "Horde" then
        iconGlow:SetVertexColor(0.90, 0.15, 0.15, 0.3)
    else
        local accent = HousingTheme.Colors.accentPrimary
        iconGlow:SetVertexColor(accent[1], accent[2], accent[3], 0.3)
    end
    
    -- Main title
    local title = header:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("LEFT", titleIcon, "RIGHT", 12, 2)
    title:SetText(L["HOUSING_VENDOR_TITLE"] or "Housing Decor Locations")
    local textPrimary = HousingTheme.Colors.textPrimary
    title:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    title:SetShadowOffset(1, -1)
    title:SetShadowColor(0, 0, 0, 0.8)
    
    -- Subtitle
    local subtitle = header:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    subtitle:SetPoint("LEFT", titleIcon, "RIGHT", 12, -10)
    subtitle:SetText("Midnight Edition")
    local textMuted = HousingTheme.Colors.textMuted
    subtitle:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    
    -- Right side buttons container
    local buttonsContainer = CreateFrame("Frame", nil, header)
    buttonsContainer:SetSize(360, 32)
    buttonsContainer:SetPoint("RIGHT", -50, 0)

    -- Statistics button
    local statsBtn = self:CreateHeaderButton(buttonsContainer, L["BUTTON_STATISTICS"] or "Statistics", 85)
    statsBtn:SetPoint("RIGHT", -275, 0)
    statsBtn:SetScript("OnClick", function()
        if HousingStatisticsUI then
            HousingStatisticsUI:Show()
        end
    end)

    -- Zone popup button
    local zoneBtn = self:CreateHeaderButton(buttonsContainer, L["BUTTON_ZONE_POPUP"] or "Zone Popup", 95)
    zoneBtn:SetPoint("RIGHT", -175, 0)
    zoneBtn:SetScript("OnClick", function()
        if not HousingOutstandingItemsUI or not HousingOutstandingItemsUI.TogglePopup then
            print("|cFFFF4040HousingVendor:|r OutstandingItemsUI module not available")
            return
        end
        HousingOutstandingItemsUI:TogglePopup()
    end)
    
    -- Settings button
    local configBtn = self:CreateHeaderButton(buttonsContainer, L["BUTTON_SETTINGS"] or "Settings", 80)
    configBtn:SetPoint("RIGHT", 0, 0)
    configBtn:SetScript("OnClick", function()
        if HousingConfigUI then
            HousingConfigUI:Show()
        end
    end)
    
    parent.header = header
end

-- Create styled header button
function HousingUI:CreateHeaderButton(parent, text, width)
    local colors = Theme.Colors or {}
    
    local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    btn:SetSize(width or 80, 26)
    
    -- Button backdrop
    btn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    local bgTertiary = HousingTheme.Colors.bgTertiary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    btn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    btn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    -- Button text
    local label = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("CENTER")
    label:SetText(text)
    local textPrimary = HousingTheme.Colors.textPrimary
    label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    btn.label = label
    
    -- Hover effects
    local bgHover = HousingTheme.Colors.bgHover
    local accentPrimary = HousingTheme.Colors.accentPrimary
    local textHighlight = HousingTheme.Colors.textHighlight
    
    btn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
        self.label:SetTextColor(textHighlight[1], textHighlight[2], textHighlight[3], 1)
    end)
    
    btn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
        self.label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    end)
    
    return btn
end

--------------------------------------------------------------------------------
-- CLOSE BUTTON
--------------------------------------------------------------------------------

function HousingUI:CreateCloseButton(parent)
    local colors = Theme.Colors or {}
    
    local closeBtn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    closeBtn:SetSize(24, 24)
    closeBtn:SetPoint("TOPRIGHT", -8, -8)
    
    -- Backdrop
    closeBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    local bgTertiary = HousingTheme.Colors.bgTertiary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    closeBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    closeBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    -- X text
    local closeText = closeBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    closeText:SetPoint("CENTER", 0, 1)
    closeText:SetText("X")
    local textSecondary = HousingTheme.Colors.textSecondary
    closeText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    closeBtn.closeText = closeText
    
    -- Hover effects
    local statusError = HousingTheme.Colors.statusError
    
    closeBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(statusError[1], statusError[2], statusError[3], 0.3)
        self:SetBackdropBorderColor(statusError[1], statusError[2], statusError[3], 1)
        self.closeText:SetTextColor(statusError[1], statusError[2], statusError[3], 1)
    end)
    
    closeBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
        self.closeText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    end)
    
    closeBtn:SetScript("OnClick", function()
        self:Hide()
    end)
end

--------------------------------------------------------------------------------
-- FOOTER
--------------------------------------------------------------------------------

function HousingUI:CreateFooter(parent)
    local colors = Theme.Colors or {}
    local footerHeight = 32
    
    -- Footer container
    local footer = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    footer:SetPoint("BOTTOMLEFT", 2, 2)
    footer:SetPoint("BOTTOMRIGHT", -2, 2)
    footer:SetHeight(footerHeight)
    
    -- Footer background
    local footerBg = footer:CreateTexture(nil, "BACKGROUND")
    footerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    footerBg:SetAllPoints()
    local bgSecondary = HousingTheme.Colors.bgSecondary
    footerBg:SetVertexColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], bgSecondary[4])
    
    -- Top accent line
    local topLine = footer:CreateTexture(nil, "BORDER")
    topLine:SetTexture("Interface\\Buttons\\WHITE8x8")
    topLine:SetPoint("TOPLEFT", 0, 0)
    topLine:SetPoint("TOPRIGHT", 0, 0)
    topLine:SetHeight(1)
    local borderPrimary = HousingTheme.Colors.borderPrimary
    topLine:SetVertexColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.5)
    
    -- Color legend (left side)
    local legendText = footer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    legendText:SetPoint("LEFT", 12, 0)
    legendText:SetJustifyH("LEFT")
    
    local function Clamp01(value)
        if value == nil then return 0 end
        if value < 0 then return 0 end
        if value > 1 then return 1 end
        return value
    end

    local function ToColorCode(color)
        if not color then return "|cffffffff" end
        local r = math.floor(Clamp01(color[1]) * 255 + 0.5)
        local g = math.floor(Clamp01(color[2]) * 255 + 0.5)
        local b = math.floor(Clamp01(color[3]) * 255 + 0.5)
        return string.format("|cff%02x%02x%02x", r, g, b)
    end

    -- Build legend using current theme colors (matches item-list edge bars)
    local t = HousingTheme and HousingTheme.Colors or {}
    local legendParts = {
        ToColorCode(t.factionHorde) .. "Horde|r",
        ToColorCode(t.factionAlliance) .. "Alliance|r",
        ToColorCode(t.sourceAchievement) .. "Achievement|r",
        ToColorCode(t.sourceQuest) .. "Quest|r",
        ToColorCode(t.sourceDrop) .. "Drop|r",
        ToColorCode(t.sourceVendor) .. "Vendor|r",
    }
    legendText:SetText("Color Guide: " .. table.concat(legendParts, " | "))
    
    -- Instructions removed - map icon interaction no longer applies
    
    -- Version (right side)
    local versionText = footer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    versionText:SetPoint("RIGHT", -12, 0)
    versionText:SetJustifyH("RIGHT")
    local textMuted = HousingTheme.Colors.textMuted
    versionText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    versionText:SetText("v" .. ADDON_VERSION)
    
    parent.footer = footer
end

--------------------------------------------------------------------------------
-- SHOW / HIDE / TOGGLE
--------------------------------------------------------------------------------

function HousingUI:Show()
    -- Ensure initialization
    if not isInitialized then
        local success, err = pcall(function()
            self:Initialize()
        end)
        if not success then
            print("|cFF8A7FD4HousingVendor:|r Failed to initialize UI: " .. tostring(err))
            return
        end
    end

    -- TAINT FIX: Only create catalog searcher if safe delay period has passed
    -- Opening the UI within first 3 seconds could trigger taint if we call Housing APIs too early
    if _G.HousingCatalogSafeToCall and HousingAPI and HousingAPI.CreateCatalogSearcher then
        pcall(function() HousingAPI:CreateCatalogSearcher() end)
    end
    
    if not mainFrame then
        print("|cFF8A7FD4HousingVendor:|r Main frame not created")
        return
    end

    -- Load large data only when showing the UI.
    if HousingDataLoader and HousingDataLoader.LoadData then
        if not HousingDataLoader:LoadData() then
            print("|cFFFF0000HousingVendor:|r Data addon not loaded; cannot open UI")
            return
        end
    end
    
    mainFrame:Show()

    if HousingDataManager and HousingDataManager.SetUIActive then
        HousingDataManager:SetUIActive(true)
    end

    -- Only start background handlers when the main UI is open.
    if HousingCollectionAPI and HousingCollectionAPI.StartEventHandlers then
        HousingCollectionAPI:StartEventHandlers()
    end

    if HousingReputation and HousingReputation.StartTracking then
        HousingReputation:StartTracking()
    end

    if HousingDB and HousingDB.settings and HousingDB.settings.showOutstandingPopup then
        if HousingOutstandingItemsUI and HousingOutstandingItemsUI.StartEventHandlers then
            HousingOutstandingItemsUI:StartEventHandlers()
        end
    end

    if HousingDataEnhancer and HousingDataEnhancer.StartMarketRefresh then
        HousingDataEnhancer:StartMarketRefresh()
    end

    -- Check if collection cache is empty (e.g., after WTF deletion)
    local needsCollectionRefresh = false
    if HousingDB and (not HousingDB.collectedDecor or not next(HousingDB.collectedDecor)) then
        needsCollectionRefresh = true
    end

    -- Auto-refresh collection data if cache is empty (silently)
    if needsCollectionRefresh then
        -- Clear caches to force fresh data
        if HousingDB then
            HousingDB.collectedDecor = {}
        end

        if HousingDataManager and HousingDataManager.ClearCache then
            HousingDataManager:ClearCache()
        end
    end

    -- Initialize child components on first show
    if not mainFrame.componentsInitialized then
        -- Pre-load lightweight ID index (avoid building full item records)
        if HousingDataManager and HousingDataManager.GetAllItemIDs then
            pcall(function()
                HousingDataManager:GetAllItemIDs()
            end)
        end
        
        -- Initialize filters
        if HousingFilters then
            local success, err = pcall(function()
                HousingFilters:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing filters: " .. tostring(err))
            end
        end
        
        -- Initialize item list
        if HousingItemList then
            local success, err = pcall(function()
                HousingItemList:Initialize(mainFrame)
                if HousingDataManager and HousingFilters then
                    local allItems = HousingDataManager.GetAllItemIDs and HousingDataManager:GetAllItemIDs() or HousingDataManager:GetAllItems()
                    local filters = HousingFilters:GetFilters()
                    HousingItemList:UpdateItems(allItems, filters)

                    -- If we just refreshed collection data, schedule another update after API loads
                    if needsCollectionRefresh then
                        C_Timer.After(2, function()
                            if mainFrame and mainFrame:IsVisible() then
                                local refreshedItems = HousingDataManager.GetAllItemIDs and HousingDataManager:GetAllItemIDs() or HousingDataManager:GetAllItems()
                                HousingItemList:UpdateItems(refreshedItems, filters)
                            end
                        end)
                    end
                end
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing item list: " .. tostring(err))
            end
        end
        
        -- Initialize statistics UI
        if HousingStatisticsUI then
            local success, err = pcall(function()
                HousingStatisticsUI:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing statistics UI: " .. tostring(err))
            end
        end
        
        -- Initialize preview panel
        if HousingPreviewPanel then
            local success, err = pcall(function()
                HousingPreviewPanel:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing preview panel: " .. tostring(err))
            end
        end

        mainFrame.componentsInitialized = true
    else
        -- Re-register events after cleanup (when reopening UI)
        if HousingItemList and HousingItemList.ReRegisterEvents then
            HousingItemList:ReRegisterEvents()
        end

        -- Update item list with current filters when showing again
        if HousingDataManager and HousingFilters and HousingItemList then
            local allItems = HousingDataManager.GetAllItemIDs and HousingDataManager:GetAllItemIDs() or HousingDataManager:GetAllItems()
            local filters = HousingFilters:GetFilters()
            HousingItemList:UpdateItems(allItems, filters)

            -- If we just refreshed collection data, schedule another update after API loads
            if needsCollectionRefresh then
                C_Timer.After(2, function()
                    if mainFrame and mainFrame:IsVisible() then
                        local refreshedItems = HousingDataManager.GetAllItemIDs and HousingDataManager:GetAllItemIDs() or HousingDataManager:GetAllItems()
                        HousingItemList:UpdateItems(refreshedItems, filters)
                    end
                end)
            end
        end
    end
    
    -- Apply auto-filter by zone if enabled
    if HousingOutstandingItemsUI and HousingOutstandingItemsUI.ApplyInitialAutoFilter then
        HousingOutstandingItemsUI:ApplyInitialAutoFilter()
    end

    -- Start cache cleanup timer now that UI is active
    if HousingAPICache and HousingAPICache.StartCleanupTimer then
        HousingAPICache:StartCleanupTimer()
    end
end

function HousingUI:Hide()
    if mainFrame then
        mainFrame:Hide()
    end
end

function HousingUI:CleanupAfterClose()
    if isCleaningUp then
        return
    end
    isCleaningUp = true

    pcall(function()
        -- CRITICAL: Stop all background processing first
        if HousingDataManager and HousingDataManager.SetUIActive then
            HousingDataManager:SetUIActive(false)
        end
        if HousingDataManager and HousingDataManager.CancelBatchLoads then
            HousingDataManager:CancelBatchLoads()
        end

        -- Trigger cleanup in ItemList to unregister events and clear button references
        -- This prevents continuous event processing when UI is closed
        if HousingItemList and HousingItemList.Cleanup then
            HousingItemList:Cleanup()
        end

        -- CRITICAL: Stop ALL timers and event handlers to eliminate CPU usage when inactive
        -- This is the #1 cause of idle CPU drain

        -- Stop cache cleanup timer (60-second ticker)
        if HousingAPICache and HousingAPICache.StopCleanupTimer then
            HousingAPICache:StopCleanupTimer()
        end

        -- PERFORMANCE: Always stop collection event handlers when UI closes
        -- The zone popup doesn't need the EventRegistry tooltip callback
        -- This eliminates idle CPU from tooltip processing
        if HousingCollectionAPI and HousingCollectionAPI.StopEventHandlers then
            HousingCollectionAPI:StopEventHandlers()
        end

        -- Stop reputation tracking
        if HousingReputation and HousingReputation.StopTracking then
            HousingReputation:StopTracking()
        end

        -- Stop market data refresh ticker
        if HousingDataEnhancer and HousingDataEnhancer.StopMarketRefresh then
            HousingDataEnhancer:StopMarketRefresh()
        end

        -- Stop waypoint manager timers
        if HousingWaypointManager and HousingWaypointManager.ClearWaypoint then
            HousingWaypointManager:ClearWaypoint()
        end

        -- Stop model viewer timers
        if HousingModelViewer and HousingModelViewer.StopAllTimers then
            HousingModelViewer:StopAllTimers()
        end

        -- Stop preview panel timers
        if HousingPreviewPanel and HousingPreviewPanel.StopTimers then
            HousingPreviewPanel:StopTimers()
        end

        -- Keep zone popup handlers running only if setting is enabled
        if HousingOutstandingItemsUI and HousingOutstandingItemsUI.StopEventHandlers then
            if not (HousingDB and HousingDB.settings and HousingDB.settings.showOutstandingPopup) then
                HousingOutstandingItemsUI:StopEventHandlers()
            end
        end

        -- Aggressive cleanup: return to near-baseline memory/CPU after closing the UI.
        -- This clears session caches only (SavedVariables remain intact).
        if HousingAPICache and HousingAPICache.InvalidateAll then
            HousingAPICache:InvalidateAll()
        end
        if HousingDataManager and HousingDataManager.ClearCache then
            HousingDataManager:ClearCache()
        end
        if HousingIcons and HousingIcons.ClearCache then
            HousingIcons:ClearCache()
        end
        if HousingTooltipScanner and HousingTooltipScanner.ClearPendingScans then
            HousingTooltipScanner:ClearPendingScans()
        end
        if HousingCollectionAPI and HousingCollectionAPI.ClearSessionCache then
            HousingCollectionAPI:ClearSessionCache()
        end
        if HousingItemList and HousingItemList.ClearSessionCaches then
            HousingItemList:ClearSessionCaches()
        end

        -- Optional: Force garbage collection to reclaim memory from closed UI
        -- This runs asynchronously and won't cause FPS drops
        C_Timer.After(1, function()
            if collectgarbage then
                collectgarbage("collect")
            end
        end)
    end)

    isCleaningUp = false
end

function HousingUI:Toggle()
    -- PERFORMANCE: Lazy-initialize on first use (instead of at ADDON_LOADED)
    -- This defers the 20%+ CPU spike from login to when user actually opens the UI
    if not isInitialized then
        self:Initialize()
    end

    if mainFrame and mainFrame:IsVisible() then
        self:Hide()
    else
        self:Show()
    end
end

function HousingUI:ApplyScale(scale)
    if mainFrame then
        mainFrame:SetScale(scale or 1.0)
    end
end

-- Apply theme dynamically to all UI elements
function HousingUI:ApplyTheme()
    if not mainFrame then return end
    
    -- Reapply backdrop colors
    self:ApplyMainBackdrop(mainFrame)
    
    -- Refresh filters if loaded
    if HousingFilters and HousingFilters.RefreshTheme then
        HousingFilters:RefreshTheme()
    end
    
    -- Refresh item list if loaded
    if HousingItemList and HousingItemList.RefreshTheme then
        HousingItemList:RefreshTheme()
    end
    
    -- Refresh preview panel if loaded
    if HousingPreviewPanel and HousingPreviewPanel.RefreshTheme then
        HousingPreviewPanel:RefreshTheme()
    end
    
    -- Refresh statistics if loaded
    if HousingStatisticsUI and HousingStatisticsUI.RefreshTheme then
        HousingStatisticsUI:RefreshTheme()
    end

    -- Refresh zone popup (OutstandingItemsUI) if loaded
    if HousingOutstandingItemsUI and HousingOutstandingItemsUI.ApplyTheme then
        HousingOutstandingItemsUI:ApplyTheme()
    end
end

--------------------------------------------------------------------------------
-- GLOBAL REGISTRATION
--------------------------------------------------------------------------------

_G["HousingUINew"] = HousingUI

return HousingUI
