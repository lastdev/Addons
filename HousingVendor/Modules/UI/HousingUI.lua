-- Main UI Module for HousingVendor addon (Rewritten)
-- Clean, simple, performant UI

local HousingUI = {}
HousingUI.__index = HousingUI

local mainFrame = nil
local isInitialized = false

-- Version info (from TOC file)
local ADDON_VERSION = C_AddOns.GetAddOnMetadata("HousingVendor", "Version") or "1.0.0"

-- Initialize the UI
function HousingUI:Initialize()
    if isInitialized then
        return
    end
    
    -- Check dependencies
    if not HousingData then
        print("HousingVendor: HousingData not found - UI cannot initialize")
        return
    end
    
    -- Ensure data manager is initialized (may already be initialized in Events.lua)
    if HousingDataManager then
        HousingDataManager:Initialize()
    else
        print("HousingVendor: HousingDataManager not found")
        return
    end
    
    -- Ensure icon cache is initialized (may already be initialized in Events.lua)
    if HousingIcons then
        HousingIcons:Initialize()
    else
        print("HousingVendor: HousingIcons not found")
        return
    end
    
    -- Create main frame
    local success, err = pcall(function()
        mainFrame = self:CreateMainFrame()
    end)
    
    if not success then
        print("HousingVendor: Error creating main frame: " .. tostring(err))
        return
    end
    
    isInitialized = true
end

-- Create main frame
function HousingUI:CreateMainFrame()
    local frame = CreateFrame("Frame", "HousingFrameNew", UIParent, "BackdropTemplate")
    frame:SetSize(1200, 750)
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
    
    -- Backdrop
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.7)
    frame:SetBackdropBorderColor(0.8, 0.6, 0.2, 1)
    
    -- Drag handlers
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
    
    -- Create sections
    self:CreateHeader(frame)
    self:CreateWarningMessage(frame)
    self:CreateCloseButton(frame)
    self:CreateFooter(frame)

    -- Store frame reference
    _G["HousingFrameNew"] = frame
    
    return frame
end

-- Create header
function HousingUI:CreateHeader(parent)
    local headerBg = parent:CreateTexture(nil, "BACKGROUND")
    headerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    headerBg:SetPoint("TOPLEFT", 12, -12)
    headerBg:SetPoint("TOPRIGHT", -12, -12)
    headerBg:SetHeight(55)
    headerBg:SetGradient("HORIZONTAL", CreateColor(0.15, 0.10, 0.25, 0.9), CreateColor(0.05, 0.05, 0.15, 0.9))

    -- Add bottom border to header
    local headerBorder = parent:CreateTexture(nil, "BORDER")
    headerBorder:SetTexture("Interface\\Buttons\\WHITE8x8")
    headerBorder:SetPoint("BOTTOMLEFT", headerBg, "BOTTOMLEFT", 0, 0)
    headerBorder:SetPoint("BOTTOMRIGHT", headerBg, "BOTTOMRIGHT", 0, 0)
    headerBorder:SetHeight(2)
    headerBorder:SetVertexColor(1, 0.82, 0, 0.8)

    -- Title
    local title = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge2")
    title:SetPoint("LEFT", headerBg, "LEFT", 15, 0)
    title:SetText("Housing Decor Locations")
    title:SetTextColor(1, 0.82, 0, 1)
    title:SetShadowOffset(2, -2)
    title:SetShadowColor(0, 0, 0, 0.8)

    -- Subtitle/version
    local subtitle = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    subtitle:SetPoint("LEFT", title, "RIGHT", 15, 0)
    subtitle:SetText("|cFF888888Housing Catalog|r")
    subtitle:SetTextColor(0.6, 0.6, 0.6, 1)
    
    -- Statistics button
    local statsBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    statsBtn:SetSize(85, 28)
    statsBtn:SetPoint("RIGHT", headerBg, "RIGHT", -145, 0)
    statsBtn:SetText("Statistics")
    statsBtn:SetScript("OnClick", function()
        if HousingStatisticsUI then
            HousingStatisticsUI:Show()
        else
            print("HousingVendor: Statistics UI not loaded")
        end
    end)
    
    -- Config button
    local configBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    configBtn:SetSize(80, 28)
    configBtn:SetPoint("RIGHT", headerBg, "RIGHT", -50, 0)
    configBtn:SetText("Settings")
    configBtn:SetScript("OnClick", function()
        if HousingConfigUI then
            HousingConfigUI:Show()
        else
            print("HousingVendor: Config UI not loaded")
        end
    end)
end

-- Create warning message
function HousingUI:CreateWarningMessage(parent)
    local warningFrame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    warningFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, -70)
    warningFrame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -15, -70)
    warningFrame:SetHeight(35)

    -- Warning background
    warningFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    warningFrame:SetBackdropColor(0.8, 0.3, 0, 0.3)  -- Orange tint
    warningFrame:SetBackdropBorderColor(1, 0.5, 0, 0.8)  -- Orange border

    -- Warning icon
    local warningIcon = warningFrame:CreateTexture(nil, "ARTWORK")
    warningIcon:SetSize(24, 24)
    warningIcon:SetPoint("LEFT", 10, 0)
    warningIcon:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")

    -- Warning text
    local warningText = warningFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    warningText:SetPoint("LEFT", warningIcon, "RIGHT", 8, 0)
    warningText:SetPoint("RIGHT", -10, 0)
    warningText:SetJustifyH("LEFT")
    warningText:SetText()

    -- Store reference so filters can adjust position
    parent.warningMessage = warningFrame
end

-- Create close button
function HousingUI:CreateCloseButton(parent)
    local closeBtn = CreateFrame("Button", nil, parent, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -8, -8)
    closeBtn:SetScript("OnClick", function()
        self:Hide()
    end)
end

-- Create footer with color legend
function HousingUI:CreateFooter(parent)
    local footerHeight = 30
    
    -- Footer background
    local footerBg = parent:CreateTexture(nil, "BACKGROUND")
    footerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    footerBg:SetPoint("BOTTOMLEFT", 12, 12)
    footerBg:SetPoint("BOTTOMRIGHT", -12, 12)
    footerBg:SetHeight(footerHeight)
    footerBg:SetVertexColor(0.05, 0.05, 0.05, 0.8)
    
    -- Top border for footer
    local footerBorder = parent:CreateTexture(nil, "BORDER")
    footerBorder:SetTexture("Interface\\Buttons\\WHITE8x8")
    footerBorder:SetPoint("TOPLEFT", footerBg, "TOPLEFT", 0, 0)
    footerBorder:SetPoint("TOPRIGHT", footerBg, "TOPRIGHT", 0, 0)
    footerBorder:SetHeight(1)
    footerBorder:SetVertexColor(0.3, 0.3, 0.3, 0.8)
    
    -- Color legend text (left side)
    local legendText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    legendText:SetPoint("LEFT", footerBg, "LEFT", 10, 0)
    legendText:SetJustifyH("LEFT")
    
    -- Build legend with colored text (matching source colors)
    local legendParts = {
        "|cFFFF0000Horde|r",
        "|cFF0066FFAlliance|r",
        "|cFFFFD700Achievement|r",  -- Gold (#FFD700)
        "|cFF1E90FFQuest|r",        -- Bright blue (#1E90FF)
        "|cFFFF4500Drop|r",         -- Orange/red (#FF4500)
        "|cFF32CD32Vendor|r"        -- Green (#32CD32)
    }
    legendText:SetText("Color Guide: " .. table.concat(legendParts, " | "))
    
    -- Instruction text (center)
    local instructionText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    instructionText:SetPoint("CENTER", footerBg, "CENTER", 0, 0)
    instructionText:SetJustifyH("CENTER")
    instructionText:SetText("|cFF00FF00Click any item with |r|TInterface\\Icons\\INV_Misc_Map_01:14:14:0:0|t|cFF00FF00 to set waypoint|r")
    
    -- Version text (far right)
    local versionText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    versionText:SetPoint("RIGHT", footerBg, "RIGHT", -10, 0)
    versionText:SetText(string.format("|cFF888888v%s|r", ADDON_VERSION))
    versionText:SetJustifyH("RIGHT")
end

-- Show the UI
function HousingUI:Show()
    -- Ensure initialization
    if not isInitialized then
        local success, err = pcall(function()
            self:Initialize()
        end)
        if not success then
            print("HousingVendor: Failed to initialize UI: " .. tostring(err))
            return
        end
    end
    
    if not mainFrame then
        print("HousingVendor: Main frame not created")
        return
    end
    
    mainFrame:Show()
    
    -- Initialize child components on first show
    if not mainFrame.componentsInitialized then
        -- Pre-load data
        if HousingDataManager then
            local success, err = pcall(function()
                HousingDataManager:GetAllItems() -- Pre-load data
            end)
            if not success then
                print("HousingVendor: Error loading data: " .. tostring(err))
            end
        end
        
        -- Initialize filters
        if HousingFilters then
            local success, err = pcall(function()
                HousingFilters:Initialize(mainFrame)
            end)
            if not success then
                print("HousingVendor: Error initializing filters: " .. tostring(err))
            end
        end
        
        -- Initialize item list
        if HousingItemList then
            local success, err = pcall(function()
                HousingItemList:Initialize(mainFrame)
                -- Load items after filters are ready
                if HousingDataManager and HousingFilters then
                    local allItems = HousingDataManager:GetAllItems()
                    local filters = HousingFilters:GetFilters()
                    HousingItemList:UpdateItems(allItems, filters)
                end
            end)
            if not success then
                print("HousingVendor: Error initializing item list: " .. tostring(err))
            end
        end
        
        -- Initialize statistics UI
        if HousingStatisticsUI then
            local success, err = pcall(function()
                HousingStatisticsUI:Initialize(mainFrame)
            end)
            if not success then
                print("HousingVendor: Error initializing statistics UI: " .. tostring(err))
            end
        end
        
        -- Preview panel removed - waypoint buttons are now in item list rows

        mainFrame.componentsInitialized = true
    else
        -- Update item list with current filters when showing again
        if HousingDataManager and HousingFilters and HousingItemList then
            local allItems = HousingDataManager:GetAllItems()
            local filters = HousingFilters:GetFilters()
            
            -- Always use items view (other display modes not implemented)
            HousingItemList:UpdateItems(allItems, filters)
        end
    end
end

-- Hide the UI
function HousingUI:Hide()
    if mainFrame then
        mainFrame:Hide()
    end
end

-- Toggle the UI
function HousingUI:Toggle()
    if mainFrame and mainFrame:IsVisible() then
        self:Hide()
    else
        self:Show()
    end
end

-- Apply scale setting
function HousingUI:ApplyScale(scale)
    if mainFrame then
        mainFrame:SetScale(scale or 1.0)
    end
end

-- Make globally accessible
_G["HousingUINew"] = HousingUI

return HousingUI

