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

	    if _G.HousingPlanManager and _G.HousingPlanManager.RegisterListener then
	        _G.HousingPlanManager:RegisterListener("HousingUI_PlanButton", function(event, _, _, count)
	            if event ~= "plan_changed" and event ~= "plan_cleared" and event ~= "plan_loaded" then
	                return
	            end
	            if self._planButton and self._planButton.label and type(count) == "number" then
	                self._planButton.label:SetText(string.format(L["PLAN_BUTTON_FMT"] or "Craft List (%d)", tonumber(count) or 0))
            elseif self._planButton and self._planButton.label then
                local c = _G.HousingPlanManager.GetCount and _G.HousingPlanManager:GetCount() or 0
                self._planButton.label:SetText(string.format(L["PLAN_BUTTON_FMT"] or "Craft List (%d)", tonumber(c) or 0))
            end
        end)
    end
end

--------------------------------------------------------------------------------
-- MAIN FRAME CREATION
--------------------------------------------------------------------------------

function HousingUI:CreateMainFrame()
    local frame = CreateFrame("Frame", "HousingFrameNew", UIParent, "BackdropTemplate")
    
    -- Use theme dimensions or defaults (reduced width for compact layout)
    local dims = Theme.Dimensions or {}
    frame:SetSize(dims.mainFrameWidth or 800, dims.mainFrameHeight or 700)  -- Narrower to fit button edge
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("HIGH")
    frame:Hide()

    -- Add to UISpecialFrames so ESC key closes the window
    table.insert(UISpecialFrames, "HousingFrameNew")

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
    
    -- Header container
    local header = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    header:SetPoint("TOPLEFT", 2, -2)
    header:SetPoint("TOPRIGHT", -2, -2)
    header:SetHeight(headerHeight)
    
    -- Use theme colors instead of faction colors
    local bgPrimary = HousingTheme.Colors.bgPrimary
    local bgSecondary = HousingTheme.Colors.bgSecondary
    local accentPrimary = HousingTheme.Colors.accentPrimary
    
    -- Header background with dark gradient
    local headerBg = header:CreateTexture(nil, "BACKGROUND")
    headerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    headerBg:SetAllPoints()
    headerBg:SetGradient("HORIZONTAL", 
        CreateColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], 0.98),
        CreateColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.95))
    
    -- Bottom accent line (cyan/theme colored)
    local accentLine = header:CreateTexture(nil, "BORDER")
    accentLine:SetTexture("Interface\\Buttons\\WHITE8x8")
    accentLine:SetPoint("BOTTOMLEFT", 0, 0)
    accentLine:SetPoint("BOTTOMRIGHT", 0, 0)
    accentLine:SetHeight(2)
    accentLine:SetVertexColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.8)
    
    -- Main title
    local title = header:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    title:SetPoint("LEFT", 12, 0)
    title:SetText(L["HOUSING_VENDOR_TITLE"] or "Housing Vendor")
    local textPrimary = HousingTheme.Colors.textPrimary
    title:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    title:SetShadowOffset(1, -1)
    title:SetShadowColor(0, 0, 0, 0.8)

    -- Navigation buttons row below title
    self:CreateHeaderNavButtons(parent, header)
    
    parent.header = header
end

function HousingUI:CreateHeaderNavButtons(parent, header)
    -- No buttons in header anymore
    -- Items and Zone buttons removed, Settings moved to footer
end

--------------------------------------------------------------------------------
-- VERTICAL NAVIGATION SIDEBAR (REMOVED - navigation now in header)
--------------------------------------------------------------------------------

-- Show main items view (default view)
function HousingUI:ShowItemsView()
    -- Hide all other views
    if HousingAchievementsUI and HousingAchievementsUI.Hide then
        HousingAchievementsUI:Hide()
    end
    if HousingEndeavorsUI and HousingEndeavorsUI.Hide then
        HousingEndeavorsUI:Hide()
    end
    if HousingReputationUI and HousingReputationUI.Hide then
        HousingReputationUI:Hide()
    end
    if HousingStatisticsUI and HousingStatisticsUI.Hide then
        HousingStatisticsUI:Hide()
    end
    if HousingAuctionHouseUI and HousingAuctionHouseUI.Hide then
        HousingAuctionHouseUI:Hide()
    end
    
    -- Show main item list and filters
    if HousingItemList and HousingItemList.Show then
        HousingItemList:Show()
    end
    if HousingFilters and HousingFilters.Show then
        HousingFilters:Show()
    end
    if HousingPreviewPanel and HousingPreviewPanel.Show then
        HousingPreviewPanel:Show()
    end
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
    closeText:SetText(L["BUTTON_CLOSE_X"] or "X")
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
    versionText:SetPoint("RIGHT", -110, 0)  -- Moved left to make room for Settings button
    versionText:SetJustifyH("RIGHT")
    local textMuted = HousingTheme.Colors.textMuted
    versionText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    versionText:SetText("v" .. ADDON_VERSION)
    
    -- Settings button (bottom-right corner of footer)
    local settingsBtn = self:CreateHeaderButton(footer, "Settings", 90)
    settingsBtn:SetSize(90, 24)  -- Slightly smaller for footer
    settingsBtn:SetPoint("BOTTOMRIGHT", footer, "BOTTOMRIGHT", -6, 4)
    settingsBtn:SetScript("OnClick", function()
        if HousingConfigUI and HousingConfigUI.ShowEmbedded then
            HousingConfigUI:ShowEmbedded()
        elseif HousingConfigUI and HousingConfigUI.Show then
            HousingConfigUI:Show()
        end
    end)
    
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

    -- Apply user appearance settings to all addon frames (some are UIParent popouts).
    if HousingDB then
        if HousingDB.uiScale and self.ApplyScale then
            self:ApplyScale(HousingDB.uiScale)
        end
        if HousingDB.fontSize and self.ApplyFontSize then
            self:ApplyFontSize(HousingDB.fontSize)
        end
    end

    -- Ensure we always return to the default (items) view when reopening the main UI.
    -- If the UI was closed while an embedded panel (Endeavors/Achievements/etc.) was open,
    -- its container could remain shown and overlap with the main list on next open.
    pcall(function()
        if HousingEndeavorsUI and HousingEndeavorsUI.Hide then
            HousingEndeavorsUI:Hide()
        end
    end)
    pcall(function()
        if HousingAchievementsUI and HousingAchievementsUI.Hide then
            HousingAchievementsUI:Hide()
        end
    end)
    pcall(function()
        if HousingReputationUI and HousingReputationUI.Hide then
            HousingReputationUI:Hide()
        end
    end)
    pcall(function()
        if HousingStatisticsUI and HousingStatisticsUI.Hide then
            HousingStatisticsUI:Hide()
        end
    end)
    pcall(function()
        if HousingAuctionHouseUI and HousingAuctionHouseUI.Hide then
            HousingAuctionHouseUI:Hide()
        end
    end)
    pcall(function()
        if HousingPlanUI and HousingPlanUI.Hide then
            HousingPlanUI:Hide()
        end
    end)

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

    -- Auto-refresh owned decor cache (catalog snapshot) when UI opens (optional; can be disabled to reduce CPU spikes).
    if HousingCollectionAPI and HousingCollectionAPI.RefreshOwnedDecorCache then
        local settings = HousingDB and HousingDB.settings
        local wantsRefresh = not settings or settings.refreshOwnedDecorOnOpen ~= false
        local apiDisabled = settings and settings.disableApiCalls
        if wantsRefresh and not apiDisabled then
            HousingCollectionAPI:RefreshOwnedDecorCache(function(success)
                if success and mainFrame and mainFrame:IsVisible() and HousingDataManager and HousingFilters and HousingItemList then
                    local allItems = HousingDataManager.GetAllItemIDs and HousingDataManager:GetAllItemIDs() or HousingDataManager:GetAllItems()
                    local filters = HousingFilters:GetFilters()
                    HousingItemList:UpdateItems(allItems, filters)
                end
            end, false)
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
        
        -- Initialize achievements UI
        if HousingAchievementsUI then
            local success, err = pcall(function()
                HousingAchievementsUI:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing achievements UI: " .. tostring(err))
            end
        end

        -- Initialize endeavors UI
        if HousingEndeavorsUI then
            local success, err = pcall(function()
                HousingEndeavorsUI:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing endeavors UI: " .. tostring(err))
            end
        end

        -- Initialize reputation UI
        if HousingReputationUI then
            local success, err = pcall(function()
                HousingReputationUI:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing reputation UI: " .. tostring(err))
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
        
        -- Initialize plan UI
        if HousingPlanUI then
            local success, err = pcall(function()
                HousingPlanUI:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing plan UI: " .. tostring(err))
            end
        end
        
        -- Initialize materials tracker UI
        if HousingMaterialsTrackerUI then
            local success, err = pcall(function()
                HousingMaterialsTrackerUI:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing materials tracker UI: " .. tostring(err))
            end
        end
        
        -- Initialize model viewer UI
        if HousingModelViewer then
            local success, err = pcall(function()
                HousingModelViewer:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing model viewer UI: " .. tostring(err))
            end
        end

        if HousingAuctionHouseUI then
            local success, err = pcall(function()
                HousingAuctionHouseUI:Initialize(mainFrame)
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error initializing auction UI: " .. tostring(err))
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

    if self._planButton and self._planButton.label and _G.HousingPlanManager and _G.HousingPlanManager.GetCount then
        self._planButton.label:SetText(string.format(L["PLAN_BUTTON_FMT"] or "Craft List (%d)", tonumber(_G.HousingPlanManager:GetCount() or 0) or 0))
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
        -- Hide embedded panels to avoid overlap on next open and stop their event handlers/timers.
        if HousingEndeavorsUI and HousingEndeavorsUI.Hide then
            HousingEndeavorsUI:Hide()
        end
        if HousingAchievementsUI and HousingAchievementsUI.Hide then
            HousingAchievementsUI:Hide()
        end
        if HousingReputationUI and HousingReputationUI.Hide then
            HousingReputationUI:Hide()
        end
        if HousingStatisticsUI and HousingStatisticsUI.Hide then
            HousingStatisticsUI:Hide()
        end
        if HousingAuctionHouseUI and HousingAuctionHouseUI.Hide then
            HousingAuctionHouseUI:Hide()
        end
        if HousingPlanUI and HousingPlanUI.Hide then
            HousingPlanUI:Hide()
        end

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

        -- Don't stop zone popup handlers when main UI closes
        -- Zone popups should work independently and continue showing when zoning
        -- They are only stopped when the setting is disabled (handled in ConfigUI)

        if HousingAuctionHouseUI and HousingAuctionHouseUI.Hide then
            HousingAuctionHouseUI:Hide()
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
    scale = scale or 1.0

    local function ApplyScaleTo(frame)
        if frame and frame.SetScale then
            frame:SetScale(scale)
        end
    end

    ApplyScaleTo(mainFrame)
    ApplyScaleTo(_G["HousingVendorConfigFrame"])
    ApplyScaleTo(_G["HousingVendorMarkerFrame"])
    ApplyScaleTo(_G["HousingOutstandingPopup"])
    ApplyScaleTo(_G["HousingOutstandingFrame"])

    -- Filter dropdown list frames are UIParent children; keep them aligned with the scaled main frame.
    for k, v in pairs(_G) do
        if type(k) == "string" and k:match("^Housing.+ListFrame$") and v and v.SetScale then
            v:SetScale(scale)
        end
    end
end

local DEFAULT_BASE_FONT_SIZE = 12
local MIN_FONT_SIZE = 8
local MAX_FONT_SIZE = 32

local function Clamp(n, lo, hi)
    if n < lo then return lo end
    if n > hi then return hi end
    return n
end

local function ApplyFontSizeToFontString(fs, desiredBaseSize)
    if not (fs and fs.GetFont and fs.SetFont) then
        return
    end

    local fontPath, fontSize, fontFlags = fs:GetFont()
    if not (fontPath and fontSize) then
        return
    end

    if not fs._hvBaseFont then
        fs._hvBaseFont = { path = fontPath, size = fontSize, flags = fontFlags }
    end

    local baseSize = fs._hvBaseFont.size or fontSize
    local scaled = (baseSize / DEFAULT_BASE_FONT_SIZE) * desiredBaseSize
    local newSize = Clamp(math.floor(scaled + 0.5), MIN_FONT_SIZE, MAX_FONT_SIZE)
    fs:SetFont(fs._hvBaseFont.path or fontPath, newSize, fs._hvBaseFont.flags or fontFlags)
end

local function ApplyFontSizeToFrameTree(root, desiredBaseSize, visited)
    if not root then
        return
    end
    if not visited then
        visited = {}
    end
    if visited[root] then
        return
    end
    visited[root] = true

    if root.GetRegions then
        local regions = { root:GetRegions() }
        for i = 1, #regions do
            local region = regions[i]
            if region and region.GetObjectType and region:GetObjectType() == "FontString" then
                ApplyFontSizeToFontString(region, desiredBaseSize)
            end
        end
    end

    if root.GetChildren then
        local children = { root:GetChildren() }
        for i = 1, #children do
            ApplyFontSizeToFrameTree(children[i], desiredBaseSize, visited)
        end
    end
end

function HousingUI:ApplyFontSize(fontSize)
    fontSize = tonumber(fontSize) or (HousingDB and HousingDB.fontSize) or DEFAULT_BASE_FONT_SIZE

    local visited = {}
    ApplyFontSizeToFrameTree(mainFrame, fontSize, visited)
    ApplyFontSizeToFrameTree(_G["HousingVendorConfigFrame"], fontSize, visited)
    ApplyFontSizeToFrameTree(_G["HousingVendorMarkerFrame"], fontSize, visited)
    ApplyFontSizeToFrameTree(_G["HousingOutstandingPopup"], fontSize, visited)
    ApplyFontSizeToFrameTree(_G["HousingOutstandingFrame"], fontSize, visited)

    for k, v in pairs(_G) do
        if type(k) == "string" and k:match("^Housing.+ListFrame$") then
            ApplyFontSizeToFrameTree(v, fontSize, visited)
        end
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

    -- Refresh Materials Tracker popout
    if HousingMaterialsTrackerUI and HousingMaterialsTrackerUI.ApplyTheme then
        HousingMaterialsTrackerUI:ApplyTheme()
    end

    -- Refresh vendor waypoint/marker popout
    if HousingVendorMarker and HousingVendorMarker.ApplyTheme then
        HousingVendorMarker:ApplyTheme()
    end

end

--------------------------------------------------------------------------------
-- GLOBAL REGISTRATION
--------------------------------------------------------------------------------

_G["HousingUINew"] = HousingUI

return HousingUI
