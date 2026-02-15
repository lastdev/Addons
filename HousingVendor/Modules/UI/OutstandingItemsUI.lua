-- Outstanding Items UI Module

local ADDON_NAME, ns = ...
local L = ns.L

local OutstandingItemsUI = {}
OutstandingItemsUI.__index = OutstandingItemsUI

local outstandingFrame = nil
local popupFrame = nil
local eventFrame = nil
local currentZoneKey = nil
local lastPopupZoneKey = nil
local currentFontSize = 12

local function GetPopupPositionStore()
    if not HousingDB then
        HousingDB = {}
    end
    if not HousingDB.outstandingPopupPosition then
        HousingDB.outstandingPopupPosition = {}
    end
    return HousingDB.outstandingPopupPosition
end

local function IsInNonWorldInstance()
    if not IsInInstance then return false end
    local inInstance, instanceType = IsInInstance()
    if inInstance and C_Map and C_Map.GetBestMapForUnit then
        local mapID = C_Map.GetBestMapForUnit("player")
        if mapID == 2351 or mapID == 2352 then
            return false
        end
    end
    return inInstance and instanceType and instanceType ~= "none"
end

local function HidePopupIfShown()
    if popupFrame and popupFrame.IsShown and popupFrame:IsShown() then
        popupFrame:Hide()
    end
end

function OutstandingItemsUI:Initialize()
    currentFontSize = (HousingDB and HousingDB.fontSize) or 12
    self._currentFontSize = currentFontSize
    self._currentZoneKey = nil
    self._lastPopupZoneKey = nil
    self._popupFrame = popupFrame
    self._outstandingFrame = outstandingFrame
    
    -- Initialize settings
    if HousingDB and not HousingDB.settings then
        HousingDB.settings = {}
    end
    
    if HousingDB and HousingDB.settings.showOutstandingPopup == nil then
        HousingDB.settings.showOutstandingPopup = true
    end
    
    -- Theme updates are applied via HousingUINew:ApplyTheme() which calls HousingOutstandingItemsUI:ApplyTheme().
end


function OutstandingItemsUI:CreatePopup()
    if popupFrame then
        return popupFrame
    end
    
    local colors = (HousingTheme and HousingTheme.Colors) or {}
    local bgPrimary = colors.bgPrimary or {0.1, 0.1, 0.1, 0.95}
    local bgSecondary = colors.bgSecondary or {0.15, 0.15, 0.15, 0.9}
    local bgTertiary = colors.bgTertiary or {0.2, 0.2, 0.2, 0.9}
    local bgHover = colors.bgHover or {0.25, 0.25, 0.25, 0.95}
    local borderPrimary = colors.borderPrimary or {0.3, 0.3, 0.3, 1}
    local accentPrimary = colors.accentPrimary or {0.55, 0.45, 0.85, 1}
    local textPrimary = colors.textPrimary or {0.9, 0.9, 0.9, 1}
    
    local frame = CreateFrame("Frame", "HousingOutstandingPopup", UIParent, "BackdropTemplate")
    frame:SetSize(250, 320)
    do
        local pos = HousingDB and HousingDB.outstandingPopupPosition
        if pos and pos.point and pos.relPoint and pos.x and pos.y then
            frame:SetPoint(pos.point, UIParent, pos.relPoint, pos.x, pos.y)
        else
            frame:SetPoint("CENTER", 0, 100)
        end
    end
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 2,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    frame:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], (bgPrimary[4] or 0.95) * 0.6)
    frame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    frame:SetFrameStrata("DIALOG")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, relPoint, xOfs, yOfs = self:GetPoint(1)
        if point and relPoint then
            local store = GetPopupPositionStore()
            store.point = point
            store.relPoint = relPoint
            store.x = xOfs
            store.y = yOfs
        end
    end)
    frame:Hide()

    -- Match the main UI scale.
    if HousingDB and HousingDB.uiScale then
        frame:SetScale(HousingDB.uiScale)
    end

    table.insert(UISpecialFrames, "HousingOutstandingPopup")

    frame.UpdateTheme = function(self)
        local currentColors = (HousingTheme and HousingTheme.Colors) or {}
        local bg = currentColors.bgPrimary or bgPrimary
        local accent = currentColors.accentPrimary or accentPrimary
        local text = currentColors.textPrimary or textPrimary
        local bgTert = currentColors.bgTertiary or bgTertiary
        local bgHov = currentColors.bgHover or bgHover
        local border = currentColors.borderPrimary or borderPrimary
        local textSecondary = currentColors.textSecondary or {0.7, 0.7, 0.7, 1}
        local statusError = currentColors.statusError or {1, 0.2, 0.2, 1}
        
        self:SetBackdropColor(bg[1], bg[2], bg[3], (bg[4] or 0.95) * 0.6)
        self:SetBackdropBorderColor(border[1], border[2], border[3], border[4])

        if self.title then
            local titleColor = currentColors.accentGold or currentColors.textHighlight or {1, 0.95, 0.80, 1}
            self.title:SetTextColor(titleColor[1], titleColor[2], titleColor[3], 1)
        end
        
        if self.zoneName then
            self.zoneName:SetTextColor(accent[1], accent[2], accent[3], 1)
        end

        if self.closeBtn then
            local btn = self.closeBtn
            if btn._isHover then
                btn:SetBackdropColor(statusError[1], statusError[2], statusError[3], 0.3)
                btn:SetBackdropBorderColor(statusError[1], statusError[2], statusError[3], 1)
                if btn.closeText then
                    btn.closeText:SetTextColor(statusError[1], statusError[2], statusError[3], 1)
                end
            else
                btn:SetBackdropColor(bgTert[1], bgTert[2], bgTert[3], bgTert[4])
                btn:SetBackdropBorderColor(border[1], border[2], border[3], border[4])
                if btn.closeText then
                    btn.closeText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
                end
            end
        end

        OutstandingItemsUI:ApplyPopupTheme(self)
        
        if self.viewAllBtn then
            self.viewAllBtn:SetBackdropColor(bgTert[1], bgTert[2], bgTert[3], bgTert[4])
            self.viewAllBtn:SetBackdropBorderColor(border[1], border[2], border[3], border[4])
            if self.viewAllBtn.label then
                self.viewAllBtn.label:SetTextColor(text[1], text[2], text[3], 1)
            end
        end
        
        if self.dontShowBtn then
            self.dontShowBtn:SetBackdropColor(bgTert[1], bgTert[2], bgTert[3], bgTert[4])
            self.dontShowBtn:SetBackdropBorderColor(border[1], border[2], border[3], border[4])
            if self.dontShowBtn.label then
                self.dontShowBtn.label:SetTextColor(text[1], text[2], text[3], 1)
            end
        end
    end
    
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText(L["OUTSTANDING_ITEMS_IN_ZONE"] or "Outstanding Items in Zone")
    frame.title = title
    
    local zoneName = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    zoneName:SetPoint("TOP", title, "BOTTOM", 0, -5)
    zoneName:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    frame.zoneName = zoneName
    
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 15, -60)
    scrollFrame:SetPoint("BOTTOMRIGHT", -35, 50)
    
    local content = CreateFrame("Frame", nil, scrollFrame)
    local contentWidth = math.max(1, (frame.GetWidth and frame:GetWidth() or 250) - 50)
    content:SetSize(contentWidth, 200)
    scrollFrame:SetScrollChild(content)
    frame.content = content
    frame.scrollFrame = scrollFrame
    frame._contentWidth = contentWidth
    
    -- Close button (styled like the main addon UI)
    local closeBtn = CreateFrame("Button", nil, frame, "BackdropTemplate")
    closeBtn:SetSize(24, 24)
    closeBtn:SetPoint("TOPRIGHT", -8, -8)
    closeBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    closeBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    closeBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])

    local closeText = closeBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    closeText:SetPoint("CENTER", 0, 1)
    closeText:SetText(L["BUTTON_CLOSE_X"] or "X")
    do
        local textSecondary = colors.textSecondary or {0.7, 0.7, 0.7, 1}
        closeText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    end
    closeBtn.closeText = closeText

    closeBtn:SetScript("OnEnter", function(self)
        self._isHover = true
        local currentColors = (HousingTheme and HousingTheme.Colors) or {}
        local statusError = currentColors.statusError or {1, 0.2, 0.2, 1}
        self:SetBackdropColor(statusError[1], statusError[2], statusError[3], 0.3)
        self:SetBackdropBorderColor(statusError[1], statusError[2], statusError[3], 1)
        if self.closeText then
            self.closeText:SetTextColor(statusError[1], statusError[2], statusError[3], 1)
        end
    end)
    closeBtn:SetScript("OnLeave", function(self)
        self._isHover = false
        local currentColors = (HousingTheme and HousingTheme.Colors) or {}
        local bgTert = currentColors.bgTertiary or bgTertiary
        local border = currentColors.borderPrimary or borderPrimary
        local textSecondary = currentColors.textSecondary or {0.7, 0.7, 0.7, 1}
        self:SetBackdropColor(bgTert[1], bgTert[2], bgTert[3], bgTert[4])
        self:SetBackdropBorderColor(border[1], border[2], border[3], border[4])
        if self.closeText then
            self.closeText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
        end
    end)
    closeBtn:SetScript("OnClick", function()
        frame:Hide()
    end)
    frame.closeBtn = closeBtn
    
    local viewAllBtn
    local usingThemedButtons = HousingTheme and HousingTheme.CreateButton
    local buttonSidePadding = 15
    local buttonGap = 10
    local buttonWidth = math.max(80, math.floor(((frame.GetWidth and frame:GetWidth() or 250) - (buttonSidePadding * 2) - buttonGap) / 2))
    if usingThemedButtons then
        viewAllBtn = HousingTheme:CreateButton(frame, L["BUTTON_MAIN_UI"] or "Main UI", buttonWidth, 24)
        viewAllBtn:ClearAllPoints()
        viewAllBtn:SetPoint("BOTTOMLEFT", buttonSidePadding, 12)
        viewAllBtn:SetSize(buttonWidth, 24)
    else
        viewAllBtn = CreateFrame("Button", nil, frame, "BackdropTemplate")
        viewAllBtn:SetSize(buttonWidth, 24)
        viewAllBtn:SetPoint("BOTTOMLEFT", buttonSidePadding, 12)
        viewAllBtn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false, edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
    
        viewAllBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        viewAllBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
        local viewAllText = viewAllBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        viewAllText:SetPoint("CENTER")
        viewAllText:SetText(L["BUTTON_MAIN_UI"] or "Main UI")
        viewAllText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        viewAllBtn.label = viewAllText
    end
    
    if usingThemedButtons then
        viewAllBtn:HookScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:ClearLines()
            GameTooltip:SetText(L["BUTTON_MAIN_UI"] or "Main UI", 1, 1, 1, 1, true)
            GameTooltip:AddLine(L["OUTSTANDING_MAIN_UI_TOOLTIP_DESC"] or "Opens your default UI mode filtered to this zone.", 0.9, 0.9, 0.9, true)
            GameTooltip:Show()
        end)
        viewAllBtn:HookScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    else
        viewAllBtn:SetScript("OnEnter", function(self)
            local currentColors = HousingTheme.Colors or {}
            local hover = currentColors.bgHover or bgHover
            local accent = currentColors.accentPrimary or accentPrimary
            self:SetBackdropColor(hover[1], hover[2], hover[3], hover[4])
            self:SetBackdropBorderColor(accent[1], accent[2], accent[3], 1)
            self.label:SetTextColor(accent[1], accent[2], accent[3], 1)
    
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:ClearLines()
            GameTooltip:SetText(L["BUTTON_MAIN_UI"] or "Main UI", 1, 1, 1, 1, true)
            GameTooltip:AddLine(L["OUTSTANDING_MAIN_UI_TOOLTIP_DESC"] or "Opens your default UI mode filtered to this zone.", 0.9, 0.9, 0.9, true)
            GameTooltip:Show()
        end)
        viewAllBtn:SetScript("OnLeave", function(self)
            local currentColors = HousingTheme.Colors or {}
            local bgTert = currentColors.bgTertiary or bgTertiary
            local border = currentColors.borderPrimary or borderPrimary
            local text = currentColors.textPrimary or textPrimary
            self:SetBackdropColor(bgTert[1], bgTert[2], bgTert[3], bgTert[4])
            self:SetBackdropBorderColor(border[1], border[2], border[3], border[4])
            self.label:SetTextColor(text[1], text[2], text[3], 1)
            GameTooltip:Hide()
        end)
    end
    
    viewAllBtn:SetScript("OnClick", function()
        -- Get zone from popup frame
        local zone = frame._currentZone
    
        frame:Hide()
        OutstandingItemsUI:Show(zone)
    end)
    frame.viewAllBtn = viewAllBtn
    
    local dontShowBtn
    if usingThemedButtons then
        dontShowBtn = HousingTheme:CreateButton(frame, L["SETTINGS_ZONE_POPUPS"] or "Zone Popups", buttonWidth, 24)
        dontShowBtn:ClearAllPoints()
        dontShowBtn:SetPoint("BOTTOMRIGHT", -buttonSidePadding, 12)
        dontShowBtn:SetSize(buttonWidth, 24)
    else
        dontShowBtn = CreateFrame("Button", nil, frame, "BackdropTemplate")
        dontShowBtn:SetSize(buttonWidth, 24)
        dontShowBtn:SetPoint("BOTTOMRIGHT", -buttonSidePadding, 12)
        dontShowBtn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false, edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        dontShowBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        dontShowBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
        local dontShowText = dontShowBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        dontShowText:SetPoint("CENTER")
        dontShowText:SetText("Don't Show Again")
        dontShowText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        dontShowBtn.label = dontShowText
    
        dontShowBtn:SetScript("OnEnter", function(self)
            local currentColors = HousingTheme.Colors or {}
            local hover = currentColors.bgHover or bgHover
            local accent = currentColors.accentPrimary or accentPrimary
            self:SetBackdropColor(hover[1], hover[2], hover[3], hover[4])
            self:SetBackdropBorderColor(accent[1], accent[2], accent[3], 1)
            self.label:SetTextColor(accent[1], accent[2], accent[3], 1)
        end)
        dontShowBtn:SetScript("OnLeave", function(self)
            local currentColors = HousingTheme.Colors or {}
            local bgTert = currentColors.bgTertiary or bgTertiary
            local border = currentColors.borderPrimary or borderPrimary
            local text = currentColors.textPrimary or textPrimary
            self:SetBackdropColor(bgTert[1], bgTert[2], bgTert[3], bgTert[4])
            self:SetBackdropBorderColor(border[1], border[2], border[3], border[4])
            self.label:SetTextColor(text[1], text[2], text[3], 1)
        end)
    end
    
    dontShowBtn:SetScript("OnClick", function()
        if HousingDB and HousingDB.settings then
            HousingDB.settings.showOutstandingPopup = false
            print("|cFFFF0000Housing|r|cFF0066FFVendor|r: Zone popups disabled. Re-enable in Settings.")
        end
        frame:Hide()
    end)
    frame.dontShowBtn = dontShowBtn
    
    popupFrame = frame
    self._popupFrame = frame
    
    return frame
end

function OutstandingItemsUI:ApplyTheme()
    if popupFrame and popupFrame.UpdateTheme then
        popupFrame:UpdateTheme()
        if popupFrame.IsShown and popupFrame:IsShown() and popupFrame._currentZone and popupFrame._lastOutstanding then
            self:ShowPopup(popupFrame._currentZone, popupFrame._lastOutstanding)
        end
    end
end

-- Create main outstanding items frame
function OutstandingItemsUI:CreateFrame()
    if outstandingFrame then
        return outstandingFrame
    end
    
    local frame = CreateFrame("Frame", "HousingOutstandingFrame", UIParent, "BackdropTemplate")
    frame:SetSize(800, 600)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:Hide()

    -- Match the main UI scale.
    if HousingDB and HousingDB.uiScale then
        frame:SetScale(HousingDB.uiScale)
    end
    

    outstandingFrame = frame
    self._outstandingFrame = frame

    return frame
end

-- Show outstanding items UI
function OutstandingItemsUI:Show(zoneName)
    self:StartEventHandlers()

    local mapID = nil
    if zoneName then
        mapID = select(1, self:GetCurrentZone()) -- language-independent filtering
    end

    -- Full UI: open main addon UI with Uncollected filter and zone filter
    if HousingUINew then
        if not HousingUINew.mainFrame or not HousingUINew.mainFrame:IsShown() then
            HousingUINew:Show()
        end

        C_Timer.After(0.1, function()
            if HousingFilters then
                local collectionBtn = _G["HousingCollectionButton"]
                if collectionBtn and collectionBtn.buttonText then
                    collectionBtn.buttonText:SetText("Uncollected")
                end

                if HousingFilters.currentFilters then
                    HousingFilters.currentFilters.collection = "Uncollected"
                end

                if zoneName and HousingFilters.SetZoneFilter then
                    HousingFilters:SetZoneFilter(zoneName, mapID)
                else
                    HousingFilters:ApplyFilters()
                end
            end
        end)
    end

    -- Refresh once on show in case player changed zones while UI was closed
    self:OnZoneChanged()
end

-- Apply initial auto-filter (called when addon opens)
function OutstandingItemsUI:ApplyInitialAutoFilter()
    if HousingDB and HousingDB.settings and HousingDB.settings.autoFilterByZone then
        local mapID, zoneName = self:GetCurrentZone()
        if zoneName and HousingFilters and HousingFilters.SetZoneFilter then
            C_Timer.After(0.5, function()
                -- Verify Housing APIs are ready before applying filter
                if not _G.HousingCatalogSafeToCall then
                    -- APIs not ready yet, skip filter (will apply on next zone change)
                    return
                end
                HousingFilters:SetZoneFilter(zoneName, mapID)
            end)
        end
    end
end

-- Hide outstanding items UI
function OutstandingItemsUI:Hide()
    if outstandingFrame then
        outstandingFrame:Hide()
    end

    -- Don't stop zone popup event handlers when main UI is closed
    -- Zone popups should continue working independently
    -- Only stop if the setting is disabled (handled in ConfigUI)
end

-- Toggle outstanding items UI
function OutstandingItemsUI:Toggle()
    if outstandingFrame and outstandingFrame:IsVisible() then
        self:Hide()
    else
        self:Show()
    end
end

-- Toggle the zone popup window (open/close).
-- Always opens the popup even when there are 0 outstanding items.
function OutstandingItemsUI:TogglePopup()
    local frame = self:CreatePopup()
    if frame and frame.IsShown and frame:IsShown() then
        frame:Hide()
        return
    end

    local function ShowNow()
        local mapID, zoneName = self:GetCurrentZone()

        -- Wrap GetOutstandingItemsForZone in pcall for error handling
        local ok, outstanding = pcall(self.GetOutstandingItemsForZone, self, mapID, zoneName)
        if not ok or not outstanding then
            -- Error occurred or no data, show empty popup
            outstanding = { total = 0, vendors = {}, quests = {}, achievements = {}, drops = {}, professions = {} }
        end

        self:ShowPopup(zoneName or "Current Zone", outstanding)
    end

    if HousingDataLoader and HousingDataLoader.EnsureDataLoaded then
        HousingDataLoader:EnsureDataLoaded(function()
            ShowNow()
        end)
    else
        ShowNow()
    end
end

-- Make globally accessible
_G["HousingOutstandingItemsUI"] = OutstandingItemsUI

return OutstandingItemsUI

