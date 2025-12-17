-- Main UI Module
-- Midnight Theme - Clean, Modern, Performant

local ADDON_NAME, ns = ...
local L = ns.L

local HousingUI = {}
HousingUI.__index = HousingUI

local mainFrame = nil
local isInitialized = false

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
    
    -- Check dependencies
    if not HousingData then
        print("|cFF8A7FD4HousingVendor:|r HousingData not found - UI cannot initialize")
        return
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
    subtitle:SetText(L["MAIN_SUBTITLE"] or "Housing Catalog")
    local textMuted = HousingTheme.Colors.textMuted
    subtitle:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    
    -- Right side buttons container
    local buttonsContainer = CreateFrame("Frame", nil, header)
    buttonsContainer:SetSize(250, 32)
    buttonsContainer:SetPoint("RIGHT", -50, 0)
    
    -- Statistics button
    local statsBtn = self:CreateHeaderButton(buttonsContainer, L["BUTTON_STATISTICS"] or "Statistics", 85)
    statsBtn:SetPoint("RIGHT", -95, 0)
    statsBtn:SetScript("OnClick", function()
        if HousingStatisticsUI then
            HousingStatisticsUI:Show()
        end
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
    
    -- Build legend with themed colors
    local legendParts = {
        "|cFFE63946Horde|r",           -- Red
        "|cFF4080E6Alliance|r",        -- Blue  
        "|cFFF2CC8FAchievement|r",     -- Gold
        "|cFF66B3FFQuest|r",           -- Light blue
        "|cFFFF9933Drop|r",            -- Orange
        "|cFF33CC66Vendor|r"           -- Green
    }
    legendText:SetText((L["FOOTER_COLOR_GUIDE"] or "Color Guide:") .. " " .. table.concat(legendParts, " | "))
    
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
    
    if not mainFrame then
        print("|cFF8A7FD4HousingVendor:|r Main frame not created")
        return
    end
    
    mainFrame:Show()

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
            HousingDB.apiDataCache = {}
        end

        if HousingDataManager and HousingDataManager.ClearCache then
            HousingDataManager:ClearCache()
        end
    end

    -- Initialize child components on first show
    if not mainFrame.componentsInitialized then
        -- Pre-load data
        if HousingDataManager then
            local success, err = pcall(function()
                HousingDataManager:GetAllItems()
            end)
            if not success then
                print("|cFF8A7FD4HousingVendor:|r Error loading data: " .. tostring(err))
            end
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
                    local allItems = HousingDataManager:GetAllItems()
                    local filters = HousingFilters:GetFilters()
                    HousingItemList:UpdateItems(allItems, filters)

                    -- If we just refreshed collection data, schedule another update after API loads
                    if needsCollectionRefresh then
                        C_Timer.After(2, function()
                            if mainFrame and mainFrame:IsVisible() then
                                local refreshedItems = HousingDataManager:GetAllItems()
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
            local allItems = HousingDataManager:GetAllItems()
            local filters = HousingFilters:GetFilters()
            HousingItemList:UpdateItems(allItems, filters)

            -- If we just refreshed collection data, schedule another update after API loads
            if needsCollectionRefresh then
                C_Timer.After(2, function()
                    if mainFrame and mainFrame:IsVisible() then
                        local refreshedItems = HousingDataManager:GetAllItems()
                        HousingItemList:UpdateItems(refreshedItems, filters)
                    end
                end)
            end
        end
    end
end

function HousingUI:Hide()
    if mainFrame then
        mainFrame:Hide()

        -- Trigger cleanup in ItemList to unregister events and clear button references
        -- This prevents continuous event processing when UI is closed
        if HousingItemList and HousingItemList.Cleanup then
            HousingItemList:Cleanup()
        end

        -- Note: We intentionally keep API caches intact for faster reopening
        -- Caches are cleaned automatically by the 60-second ticker in HousingAPICache

        -- Optional: Force garbage collection to reclaim memory from closed UI
        -- This runs asynchronously and won't cause FPS drops
        collectgarbage("step", 1000)
    end
end

function HousingUI:Toggle()
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
end

--------------------------------------------------------------------------------
-- GLOBAL REGISTRATION
--------------------------------------------------------------------------------

_G["HousingUINew"] = HousingUI

return HousingUI
