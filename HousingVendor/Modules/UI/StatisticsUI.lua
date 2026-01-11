-- Statistics UI Module
-- Detailed stats and graphs about the housing items database

local ADDON_NAME, ns = ...
local L = ns.L

local StatisticsUI = {}
StatisticsUI.__index = StatisticsUI

StatisticsUI._statsContainer = StatisticsUI._statsContainer or nil
StatisticsUI._parentFrame = StatisticsUI._parentFrame or nil
StatisticsUI._currentFontSize = StatisticsUI._currentFontSize or 12
StatisticsUI._fontStrings = StatisticsUI._fontStrings or {}  -- Store references to all font strings for font size updates

-- Sub-modules loaded via TOC:
-- - Statistics/Data.lua (data computation)
-- - Statistics/Charts.lua (chart rendering)
-- - Statistics/Filters.lua (filter UI)

-- Initialize statistics
function StatisticsUI:Initialize(parent)
    self._parentFrame = parent
    -- Load saved font size
    self._currentFontSize = (HousingDB and HousingDB.fontSize) or 12
end


-- Create statistics container in main UI
function StatisticsUI:CreateStatsContainer()
    if self._statsContainer then
        return self._statsContainer
    end

    local parentFrame = self._parentFrame
    if not parentFrame then
        return nil
    end

    local currentFontSize = self._currentFontSize or 12
    local fontStrings = self._fontStrings or {}
    self._fontStrings = fontStrings
    
    -- Create container that will replace the item list
    local container = CreateFrame("Frame", "HousingVendorStatisticsContainer", parentFrame)
    container:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -70)
    container:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -20, 52)
    container:Hide()
    
    -- Back button (modern Midnight theme styled)
    local theme = HousingTheme or {}
    local colors = theme.Colors or {}
    local bgTertiary = HousingTheme.Colors.bgTertiary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    local bgHover = HousingTheme.Colors.bgHover
    local accentPrimary = HousingTheme.Colors.accentPrimary
    local textPrimary = HousingTheme.Colors.textPrimary
    local textHighlight = HousingTheme.Colors.textHighlight
    
    local backBtn = CreateFrame("Button", nil, container, "BackdropTemplate")
    backBtn:SetSize(100, 30)
    backBtn:SetPoint("TOPLEFT", 10, -10)
    backBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    backBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    backBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    local backBtnText = backBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    backBtnText:SetPoint("CENTER")
    backBtnText:SetText("Back")
    backBtnText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    backBtn.label = backBtnText
    
    backBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
        self.label:SetTextColor(textHighlight[1], textHighlight[2], textHighlight[3], 1)
    end)
    backBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
        self.label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    end)
    backBtn:SetScript("OnClick", function()
        StatisticsUI:Hide()
    end)

    -- Title
    local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    title:SetPoint("TOP", 0, -15)
    local titleFont, titleSize, titleFlags = title:GetFont()
    if currentFontSize ~= 12 then
        title:SetFont(titleFont, currentFontSize + 4, titleFlags)
    end
    title:SetText("|cFFFFD700Statistics Dashboard|r")
    table.insert(fontStrings, title)
    
    -- Scroll frame for content
    local scrollFrame = CreateFrame("ScrollFrame", nil, container, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 20, -60)
    scrollFrame:SetPoint("BOTTOMRIGHT", -40, 20)

    local content = CreateFrame("Frame", nil, scrollFrame)
    -- Make content width match the available space (accounting for scrollbar)
    local contentWidth = container:GetWidth() - 80
    content:SetSize(contentWidth, 2000)
    scrollFrame:SetScrollChild(content)
    
    -- Store references
    container.content = content
    container.scrollFrame = scrollFrame
    
    self._statsContainer = container
    return container
end


-- Show statistics UI (in main window)
function StatisticsUI:Show()
    if not self._statsContainer then
        self:CreateStatsContainer()
    end

    if not self._statsContainer then
        print("HousingVendor: Failed to create statistics container")
        return
    end

    -- Hide filters, item list, and preview panel
    if _G["HousingFilterFrame"] then
        _G["HousingFilterFrame"]:Hide()
    end
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:Hide()
    end
    if _G["HousingItemListHeader"] then
        _G["HousingItemListHeader"]:Hide()
    end
    -- Hide preview panel
    if _G["HousingPreviewFrame"] then
        _G["HousingPreviewFrame"]:Hide()
    end
    -- Also hide model viewer if it exists
    if HousingModelViewer and HousingModelViewer.Hide then
        HousingModelViewer:Hide()
    end

    -- Update and show stats
    self:UpdateStats()
    self:ApplyFontSize(self._currentFontSize)

    self._statsContainer:Show()
end

-- Hide statistics UI (return to item list)
function StatisticsUI:Hide()
    if self._statsContainer then
        self._statsContainer:Hide()
    end
    
    -- Show filters and item list again
    if _G["HousingFilterFrame"] then
        _G["HousingFilterFrame"]:Show()
    end
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:Show()
    end
    if _G["HousingItemListHeader"] then
        _G["HousingItemListHeader"]:Show()
    end
end

-- Toggle statistics UI
function StatisticsUI:Toggle()
    if self._statsContainer and self._statsContainer:IsVisible() then
        self:Hide()
    else
        self:Show()
    end
end

-- Apply font size to all text elements
function StatisticsUI:ApplyFontSize(fontSize)
    fontSize = fontSize or (HousingDB and HousingDB.fontSize) or 12
    self._currentFontSize = fontSize
    
    -- If stats are currently displayed, refresh to apply font sizes to new elements
    if self._statsContainer and self._statsContainer:IsVisible() then
        self:UpdateStats()
    end
end

-- Make globally accessible
_G["HousingStatisticsUI"] = StatisticsUI

return StatisticsUI
