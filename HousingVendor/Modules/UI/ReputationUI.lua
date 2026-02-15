-- Reputation UI
-- Multi-character reputation tracking panel

local _, ns = ...
local L = (ns and ns.L) or _G["HousingVendorL"] or {}

local ReputationUI = {}
ReputationUI.__index = ReputationUI

ReputationUI._reputationContainer = ReputationUI._reputationContainer or nil
ReputationUI._parentFrame = ReputationUI._parentFrame or nil
ReputationUI._currentFontSize = ReputationUI._currentFontSize or 12
ReputationUI._fontStrings = ReputationUI._fontStrings or {}
ReputationUI._scrollFrame = ReputationUI._scrollFrame or nil
ReputationUI._scrollChild = ReputationUI._scrollChild or nil
ReputationUI._searchText = ReputationUI._searchText or ""
ReputationUI._filterExpansion = ReputationUI._filterExpansion or "All"
ReputationUI._filterCategory = ReputationUI._filterCategory or "All"
ReputationUI._selectedCharacter = ReputationUI._selectedCharacter or nil
ReputationUI._expandedReputations = ReputationUI._expandedReputations or {}

local function SetNavButtonsVisible(visible)
    local buttons = _G["HousingNavButtons"]
    if type(buttons) ~= "table" then
        return
    end
    for _, btn in ipairs(buttons) do
        if btn and btn.SetShown then
            btn:SetShown(visible)
        end
    end
end

local modelViewerWasVisible = false

local function EnsureColorTable(color, fallback)
    if type(color) ~= "table" then
        return { fallback[1], fallback[2], fallback[3], fallback[4] }
    end
    local r, g, b, a = tonumber(color[1]), tonumber(color[2]), tonumber(color[3]), tonumber(color[4])
    if not r or not g or not b then
        return { fallback[1], fallback[2], fallback[3], fallback[4] }
    end
    if a == nil then
        a = fallback[4]
    end
    return { r, g, b, a }
end

local function GetThemeColors()
    local theme = _G.HousingTheme
    return (theme and theme.Colors) or {}
end

local function SetMainUIVisible(visible)
    if _G["HousingFilterFrame"] then
        _G["HousingFilterFrame"]:SetShown(visible)
    end
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:SetShown(visible)
    end
    if _G["HousingItemListContainer"] then
        _G["HousingItemListContainer"]:SetShown(visible)
    end
    if _G["HousingItemListHeader"] then
        _G["HousingItemListHeader"]:SetShown(visible)
    end
    if _G["HousingPreviewFrame"] then
        _G["HousingPreviewFrame"]:SetShown(visible)
    end
    local modelFrame = _G["HousingModelViewerFrame"]
    if not visible then
        modelViewerWasVisible = modelFrame and modelFrame:IsShown() or false
        if modelFrame then
            modelFrame:Hide()
        elseif _G["HousingModelViewer"] and _G["HousingModelViewer"].Hide then
            _G["HousingModelViewer"]:Hide()
        end
    elseif modelViewerWasVisible and modelFrame then
        modelFrame:Show()
    end
    SetNavButtonsVisible(visible)
end

local function BuildReputationVendorIndex()
    local map = {}
    if not HousingVendorItemToFaction or not HousingExpansionData then
        return map
    end

    for itemID, repInfo in pairs(HousingVendorItemToFaction) do
        local factionID = repInfo and repInfo.factionID
        if factionID then
            local factionKey = tostring(factionID)
            local itemData = HousingExpansionData[itemID]
            local vd = itemData and itemData.vendor and itemData.vendor.vendorDetails or nil
            if vd then
                local vendorName = vd.vendorName or vd.name
                if vendorName and vendorName ~= "" and vendorName ~= "None" then
                    local location = vd.location or vd.zone or nil
                    local expansion = vd.expansion or nil
                    map[factionKey] = map[factionKey] or { vendors = {}, order = {} }
                    local key = (vendorName or "") .. "|" .. (location or "") .. "|" .. (expansion or "")
                    if not map[factionKey].vendors[key] then
                        local entry = { name = vendorName, location = location, expansion = expansion }
                        map[factionKey].vendors[key] = entry
                        table.insert(map[factionKey].order, entry)
                    end
                end
            end
        end
    end

    return map
end

-- Initialize reputation UI
function ReputationUI:Initialize(parent)
    self._parentFrame = parent
    -- Load saved font size
    self._currentFontSize = (HousingDB and HousingDB.fontSize) or 12

    -- Set selected character to current character
    if HousingReputationHandler then
        self._selectedCharacter = HousingReputationHandler:GetCurrentCharacter()
    end
end

-- Create reputation container
function ReputationUI:CreateReputationContainer()
    if self._reputationContainer then
        return self._reputationContainer
    end

    local parentFrame = self._parentFrame
    if not parentFrame then
        return nil
    end

    local currentFontSize = self._currentFontSize or 12
    local fontStrings = self._fontStrings or {}
    self._fontStrings = fontStrings

    -- Create container that will replace the item list and filters
    local container = CreateFrame("Frame", "HousingVendorReputationContainer", parentFrame)
    container:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -70)
    container:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -20, 52)
    container:Hide()

    -- Back button (Midnight theme styled)
    local colors = GetThemeColors()
    local bgTertiary = EnsureColorTable(colors.bgTertiary, { 0.1, 0.1, 0.1, 1 })
    local borderPrimary = EnsureColorTable(colors.borderPrimary, { 0.3, 0.3, 0.3, 1 })
    local bgHover = EnsureColorTable(colors.bgHover, { 0.2, 0.2, 0.2, 1 })
    local accentPrimary = EnsureColorTable(colors.accentPrimary, { 0.8, 0.6, 0.2, 1 })
    local textPrimary = EnsureColorTable(colors.textPrimary, { 1, 1, 1, 1 })
    local textHighlight = EnsureColorTable(colors.textHighlight, { 1, 0.82, 0, 1 })

    local backBtn = CreateFrame("Button", nil, container, "BackdropTemplate")
    backBtn:SetSize(80, 28)
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
    backBtnText:SetText(L["BUTTON_BACK"] or "Back")
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
        ReputationUI:Hide()
        if _G.HousingUINew and _G.HousingUINew.ReturnToCaller then
            _G.HousingUINew:ReturnToCaller()
        end
    end)

    -- Title
    local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    local titleFont, titleSize, titleFlags = title:GetFont()
    if currentFontSize ~= 12 then
        title:SetFont(titleFont, currentFontSize + 4, titleFlags)
    end
    title:SetText("|cFFFFD700Housing Reputations|r")
    table.insert(fontStrings, title)

    -- Filter and search row
    local filterSearchFrame = CreateFrame("Frame", nil, container)
    filterSearchFrame:SetSize(container:GetWidth() - 40, 32)
    filterSearchFrame:SetPoint("TOP", title, "BOTTOM", 0, -15)

    -- Expansion filter (left side)
    local expFilterBtn = CreateFrame("Button", nil, filterSearchFrame, "BackdropTemplate")
    expFilterBtn:SetSize(180, 28)
    expFilterBtn:SetPoint("LEFT", 0, 0)
    expFilterBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    expFilterBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    expFilterBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])

    local expFilterText = expFilterBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    expFilterText:SetPoint("CENTER")
    expFilterText:SetText("Expansion: All")
    expFilterText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    expFilterBtn.label = expFilterText

    expFilterBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    expFilterBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    end)
    expFilterBtn:SetScript("OnClick", function(self)
        ReputationUI:ShowExpansionFilterMenu(self)
    end)
    container.expFilterBtn = expFilterBtn

    -- Category filter (next to expansion)
    local catFilterBtn = CreateFrame("Button", nil, filterSearchFrame, "BackdropTemplate")
    catFilterBtn:SetSize(180, 28)
    catFilterBtn:SetPoint("LEFT", expFilterBtn, "RIGHT", 10, 0)
    catFilterBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    catFilterBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    catFilterBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])

    local catFilterText = catFilterBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    catFilterText:SetPoint("CENTER")
    catFilterText:SetText("Category: All")
    catFilterText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    catFilterBtn.label = catFilterText

    catFilterBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    catFilterBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    end)
    catFilterBtn:SetScript("OnClick", function(self)
        ReputationUI:ShowCategoryFilterMenu(self)
    end)
    container.catFilterBtn = catFilterBtn

    -- Search bar (right side, aligned)
    local searchFrame = CreateFrame("Frame", nil, filterSearchFrame, "BackdropTemplate")
    searchFrame:SetSize(300, 28)
    searchFrame:SetPoint("RIGHT", 0, 0)
    searchFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    searchFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.9)
    searchFrame:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)

    local searchBox = CreateFrame("EditBox", nil, searchFrame)
    searchBox:SetSize(280, 24)
    searchBox:SetPoint("LEFT", 5, 0)
    searchBox:SetFontObject("GameFontNormal")
    searchBox:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    searchBox:SetAutoFocus(false)
    searchBox:SetMaxLetters(50)
    searchBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    searchBox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    searchBox:SetScript("OnTextChanged", function(self, userInput)
        if userInput then
            ReputationUI._searchText = self:GetText():lower()
            ReputationUI:Refresh()
        end
    end)
    container.searchBox = searchBox

    local searchPlaceholder = searchFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    searchPlaceholder:SetPoint("LEFT", searchBox, "LEFT", 5, 0)
    searchPlaceholder:SetText("|cFF808080Search reputations...|r")
    searchPlaceholder:SetJustifyH("LEFT")
    searchBox:SetScript("OnEditFocusGained", function() searchPlaceholder:Hide() end)
    searchBox:SetScript("OnEditFocusLost", function(self)
        if self:GetText() == "" then
            searchPlaceholder:Show()
        end
    end)

    -- Summary section
    local summaryFrame = CreateFrame("Frame", nil, container, "BackdropTemplate")
    summaryFrame:SetSize(container:GetWidth() - 40, 50)
    summaryFrame:SetPoint("TOP", filterSearchFrame, "BOTTOM", 0, -10)
    summaryFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    summaryFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.9)
    summaryFrame:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.5)

    container.summaryFrame = summaryFrame

    -- Scroll frame for reputation list
    local scrollFrame = CreateFrame("ScrollFrame", nil, container, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", summaryFrame, "BOTTOMLEFT", 0, -10)
    scrollFrame:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", -30, 10)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetSize(scrollFrame:GetWidth(), 1)
    scrollFrame:SetScrollChild(scrollChild)

    self._scrollFrame = scrollFrame
    self._scrollChild = scrollChild

    self._reputationContainer = container
    return container
end

-- Show expansion filter menu
function ReputationUI:ShowExpansionFilterMenu(button)
    local menu = CreateFrame("Frame", nil, button, "BackdropTemplate")
    menu:SetFrameStrata("DIALOG")
    menu:SetFrameLevel(200)
    menu:SetSize(200, 400)
    menu:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -2)
    menu:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    menu:SetBackdropColor(0.1, 0.1, 0.1, 0.95)
    menu:SetBackdropBorderColor(0.8, 0.6, 0.2, 1)

    local scrollFrame = CreateFrame("ScrollFrame", nil, menu, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 5, -5)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 5)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetSize(scrollFrame:GetWidth(), 1)
    scrollFrame:SetScrollChild(scrollChild)

    -- Get unique expansions
    local expansions = { "All" }
    local seen = {}

    if HousingReputationHandler then
        local reputationList = HousingReputationHandler:GetReputations(self._selectedCharacter)
        for _, repData in ipairs(reputationList) do
            local exp = repData.expansion or "Unknown"
            if not seen[exp] then
                seen[exp] = true
                table.insert(expansions, exp)
            end
        end
    end

    local yOffset = -5
    for _, exp in ipairs(expansions) do
        local btn = CreateFrame("Button", nil, scrollChild, "BackdropTemplate")
        btn:SetSize(165, 25)
        btn:SetPoint("TOPLEFT", 5, yOffset)
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            tile = false,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        btn:SetBackdropColor(0.15, 0.15, 0.15, 1)

        local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("LEFT", 8, 0)
        text:SetText(exp)
        if exp == self._filterExpansion then
            text:SetTextColor(1, 0.82, 0, 1)
        else
            text:SetTextColor(1, 1, 1, 1)
        end

        btn:SetScript("OnEnter", function(self) self:SetBackdropColor(0.25, 0.25, 0.25, 1) end)
        btn:SetScript("OnLeave", function(self) self:SetBackdropColor(0.15, 0.15, 0.15, 1) end)
        btn:SetScript("OnClick", function()
            ReputationUI._filterExpansion = exp
            ReputationUI._reputationContainer.expFilterBtn.label:SetText("Expansion: " .. exp)
            ReputationUI:Refresh()
            menu:Hide()
        end)

        yOffset = yOffset - 30
    end

    scrollChild:SetHeight(math.abs(yOffset))

    local clickCatcher = CreateFrame("Frame", nil, UIParent)
    clickCatcher:SetAllPoints(UIParent)
    clickCatcher:SetFrameStrata("DIALOG")
    clickCatcher:SetFrameLevel(199)
    clickCatcher:EnableMouse(true)
    clickCatcher:SetScript("OnMouseDown", function()
        if menu and menu.Hide then
            menu:Hide()
        end
    end)

    menu:SetScript("OnShow", function()
        if clickCatcher and clickCatcher.Show then
            clickCatcher:Show()
        end
    end)
    menu:SetScript("OnHide", function(self)
        if clickCatcher and clickCatcher.Hide then
            clickCatcher:Hide()
            clickCatcher:SetParent(nil)
        end
        self:SetParent(nil)
    end)
    menu:Show()
end

-- Show category filter menu
function ReputationUI:ShowCategoryFilterMenu(button)
    local menu = CreateFrame("Frame", nil, button, "BackdropTemplate")
    menu:SetFrameStrata("DIALOG")
    menu:SetFrameLevel(200)
    menu:SetSize(200, 300)
    menu:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -2)
    menu:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    menu:SetBackdropColor(0.1, 0.1, 0.1, 0.95)
    menu:SetBackdropBorderColor(0.8, 0.6, 0.2, 1)

    local scrollFrame = CreateFrame("ScrollFrame", nil, menu, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 5, -5)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 5)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetSize(scrollFrame:GetWidth(), 1)
    scrollFrame:SetScrollChild(scrollChild)

    -- Get unique categories
    local categories = { "All" }
    local seen = {}

    if HousingReputationHandler then
        local reputationList = HousingReputationHandler:GetReputations(self._selectedCharacter)
        for _, repData in ipairs(reputationList) do
            local cat = repData.category or "Unknown"
            if not seen[cat] then
                seen[cat] = true
                table.insert(categories, cat)
            end
        end
    end

    -- Sort categories alphabetically (except "All" stays first)
    table.sort(categories, function(a, b)
        if a == "All" then return true end
        if b == "All" then return false end
        return a < b
    end)

    local yOffset = -5
    for _, cat in ipairs(categories) do
        local btn = CreateFrame("Button", nil, scrollChild, "BackdropTemplate")
        btn:SetSize(165, 25)
        btn:SetPoint("TOPLEFT", 5, yOffset)
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            tile = false,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        btn:SetBackdropColor(0.15, 0.15, 0.15, 1)

        local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("LEFT", 8, 0)
        text:SetText(cat)
        if cat == self._filterCategory then
            text:SetTextColor(1, 0.82, 0, 1)
        else
            text:SetTextColor(1, 1, 1, 1)
        end

        btn:SetScript("OnEnter", function(self) self:SetBackdropColor(0.25, 0.25, 0.25, 1) end)
        btn:SetScript("OnLeave", function(self) self:SetBackdropColor(0.15, 0.15, 0.15, 1) end)
        btn:SetScript("OnClick", function()
            ReputationUI._filterCategory = cat
            ReputationUI._reputationContainer.catFilterBtn.label:SetText("Category: " .. cat)
            ReputationUI:Refresh()
            menu:Hide()
        end)

        yOffset = yOffset - 30
    end

    scrollChild:SetHeight(math.abs(yOffset))

    local clickCatcher = CreateFrame("Frame", nil, UIParent)
    clickCatcher:SetAllPoints(UIParent)
    clickCatcher:SetFrameStrata("DIALOG")
    clickCatcher:SetFrameLevel(199)
    clickCatcher:EnableMouse(true)
    clickCatcher:SetScript("OnMouseDown", function()
        if menu and menu.Hide then
            menu:Hide()
        end
    end)

    menu:SetScript("OnShow", function()
        if clickCatcher and clickCatcher.Show then
            clickCatcher:Show()
        end
    end)
    menu:SetScript("OnHide", function(self)
        if clickCatcher and clickCatcher.Hide then
            clickCatcher:Hide()
            clickCatcher:SetParent(nil)
        end
        self:SetParent(nil)
    end)
    menu:Show()
end

local function BuildRequiredStandingByFaction()
    local out = {}
    if type(HousingVendorItemToFaction) ~= "table" then
        return out
    end
    for _, repInfo in pairs(HousingVendorItemToFaction) do
        local factionID = repInfo and repInfo.factionID
        local requiredStanding = repInfo and repInfo.requiredStanding
        if factionID and requiredStanding and requiredStanding ~= "" then
            local key = tostring(factionID)
            if not out[key] then
                out[key] = tostring(requiredStanding)
            end
        end
    end
    return out
end

local function AcquireReputationFrame(scrollChild, index)
    scrollChild.reputations = scrollChild.reputations or {}
    if scrollChild.reputations[index] then
        return scrollChild.reputations[index]
    end

    local repFrame = CreateFrame("Button", nil, scrollChild, "BackdropTemplate")
    repFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    repFrame:SetBackdropColor(0.08, 0.08, 0.08, 0.9)
    repFrame:SetBackdropBorderColor(0.25, 0.25, 0.25, 1)
    repFrame:EnableMouse(true)

    repFrame.icon = repFrame:CreateTexture(nil, "ARTWORK")
    repFrame.icon:SetSize(40, 40)
    repFrame.icon:SetPoint("TOPLEFT", 10, -10)
    repFrame.icon:SetTexture("Interface\\Icons\\Achievement_Reputation_01")

    repFrame.nameText = repFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    repFrame.nameText:SetPoint("TOPLEFT", repFrame.icon, "TOPRIGHT", 12, -2)
    repFrame.nameText:SetPoint("RIGHT", -150, 0)
    repFrame.nameText:SetJustifyH("LEFT")
    repFrame.nameText:SetWordWrap(false)

    repFrame.detailsText = repFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    repFrame.detailsText:SetPoint("TOPLEFT", repFrame.nameText, "BOTTOMLEFT", 0, -2)
    repFrame.detailsText:SetJustifyH("LEFT")

    repFrame.standingText = repFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    repFrame.standingText:SetPoint("TOPRIGHT", -10, -10)

    repFrame.accountText = repFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    repFrame.accountText:SetPoint("TOPLEFT", repFrame.detailsText, "BOTTOMLEFT", 0, -2)
    repFrame.accountText:SetText("|cFF00CCFFAccount-wide|r")
    repFrame.accountText:Hide()

    repFrame.vendorText = repFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    repFrame.vendorText:SetPoint("RIGHT", -10, 0)
    repFrame.vendorText:SetJustifyH("LEFT")
    repFrame.vendorText:SetWordWrap(true)
    repFrame.vendorText:Hide()

    repFrame.progressBg = repFrame:CreateTexture(nil, "BACKGROUND")
    repFrame.progressBg:SetColorTexture(0.2, 0.2, 0.2, 0.8)
    repFrame.progressBg:Hide()

    repFrame.progressBar = repFrame:CreateTexture(nil, "ARTWORK")
    repFrame.progressBar:Hide()

    repFrame.progressText = repFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    repFrame.progressText:Hide()

    repFrame.notDiscoveredText = repFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    repFrame.notDiscoveredText:SetPoint("BOTTOMLEFT", repFrame, "BOTTOMLEFT", 62, 10)
    repFrame.notDiscoveredText:SetText("|cFFFF6600Faction not yet discovered - Visit the zone to unlock|r")
    repFrame.notDiscoveredText:Hide()

    repFrame.arrow = repFrame:CreateTexture(nil, "OVERLAY")
    repFrame.arrow:SetSize(16, 16)
    repFrame.arrow:SetPoint("BOTTOMRIGHT", -10, 10)

    repFrame.details = CreateFrame("Frame", nil, repFrame)
    repFrame.details:SetPoint("TOPLEFT", 10, -68)
    repFrame.details:SetPoint("BOTTOMRIGHT", -10, 10)
    repFrame.details:Hide()

    repFrame.detailsBg = repFrame.details:CreateTexture(nil, "BACKGROUND")
    repFrame.detailsBg:SetAllPoints(repFrame.details)
    repFrame.detailsBg:SetColorTexture(0, 0, 0, 0.3)

    repFrame.detailsHeader = repFrame.details:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    repFrame.detailsHeader:SetPoint("TOPLEFT", 10, -6)
    repFrame.detailsHeader:SetText("|cFFFFD700Reputation Details|r")

    -- Single compact details line
    repFrame.detailsCompact = repFrame.details:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    repFrame.detailsCompact:SetJustifyH("LEFT")
    repFrame.detailsCompact:SetPoint("TOPLEFT", repFrame.detailsHeader, "BOTTOMLEFT", 0, -6)
    repFrame.detailsCompact:SetPoint("RIGHT", -10, 0)

    repFrame.vendorHeader = repFrame.details:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    repFrame.vendorHeader:SetPoint("TOPLEFT", repFrame.detailsCompact, "BOTTOMLEFT", 0, -12)
    repFrame.vendorHeader:SetText("|cFFFFD700Vendor Locations|r")
    repFrame.vendorHeader:Hide()

    repFrame.vendorLines = {}

    repFrame.rewardsHeader = repFrame.details:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    repFrame.rewardsHeader:SetText("|cFFFFD700Housing Rewards|r")
    repFrame.rewardsHeader:Hide()

    repFrame.rewardLines = {}

    repFrame:SetScript("OnEnter", function(self)
        local hover = self._hvBgHover
        if hover then
            self:SetBackdropColor(hover[1], hover[2], hover[3], 0.9)
        end

        local repData = self._hvRepData
        if not repData then
            return
        end

        if not (GameTooltip and GameTooltip.SetOwner) then
            return
        end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(repData.label or "Unknown", 1, 0.82, 0, true)
        GameTooltip:AddLine(" ")

        local vendorInfo = self._hvVendorInfo
        if vendorInfo and vendorInfo.order and #vendorInfo.order > 0 then
            GameTooltip:AddLine("Vendors:", 0.8, 0.8, 0.8, true)
            for _, v in ipairs(vendorInfo.order) do
                local vendorText = v.name or "Unknown"
                if v.location and v.location ~= "" and v.location ~= "None" then
                    vendorText = vendorText .. " (" .. v.location .. ")"
                end
                if v.expansion and v.expansion ~= "" and v.expansion ~= "Unknown" then
                    vendorText = vendorText .. " - " .. v.expansion
                end
                GameTooltip:AddLine("- " .. vendorText, 0.9, 0.9, 0.9, true)
            end
        else
            GameTooltip:AddLine("No vendors found", 0.6, 0.6, 0.6, true)
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Click for more details", 0.5, 0.8, 1, true)
        GameTooltip:Show()
    end)
    repFrame:SetScript("OnLeave", function(self)
        self:SetBackdropColor(0.08, 0.08, 0.08, 0.9)
        if GameTooltip then
            GameTooltip:Hide()
        end
    end)
    repFrame:SetScript("OnClick", function(self)
        local factionID = self._hvFactionID
        if not factionID then
            return
        end
        ReputationUI._expandedReputations[factionID] = not ReputationUI._expandedReputations[factionID]
        ReputationUI:Refresh()
    end)

    scrollChild.reputations[index] = repFrame
    return repFrame
end

local function UpdateReputationFrame(repFrame, repData, vendorInfo, requiredStanding, colors, isExpanded)
    repFrame._hvRepData = repData
    repFrame._hvFactionID = repData and repData.factionID or nil
    repFrame._hvVendorInfo = vendorInfo
    repFrame._hvBgHover = colors.bgHover

    repFrame.nameText:SetText("|cFFFFFFFF" .. tostring(repData.label or "Unknown") .. "|r")

    local expansion = repData.expansion or "Unknown"
    local category = repData.category or "Unknown"

    local reqText = ""
    if requiredStanding and requiredStanding ~= "" then
        reqText = " |cFF808080-|r |cFFFFD700Requires: " .. requiredStanding .. "|r"
    end
    repFrame.detailsText:SetText("|cFF808080Faction ID:|r " .. tostring(repData.factionID or "Unknown") .. " |cFF808080(|r" .. tostring(expansion) .. "|cFF808080)|r |cFF808080-|r |cFF00CCFF" .. tostring(category) .. "|r" .. reqText)

    local standing = tostring(repData.standing or "Unknown")
    local standingColor = "|cFF00FF00"
    if standing == "Not Discovered" then
        standingColor = "|cFFFF6600"
    elseif standing:find("Exalted") or standing:find("Renown") then
        standingColor = "|cFFFFD700"
    elseif standing:find("Revered") then
        standingColor = "|cFF00FF00"
    elseif standing:find("Honored") or standing:find("Friendly") then
        standingColor = "|cFF00CCFF"
    else
        standingColor = "|cFFCCCCCC"
    end
    repFrame.standingText:SetText(standingColor .. standing .. "|r")

    repFrame.accountText:SetShown(repData.isRenown == true)

    local detailAnchor = repFrame.detailsText
    if repData.isRenown == true then
        detailAnchor = repFrame.accountText
    end

    local vendorLine = nil
    if vendorInfo and vendorInfo.order and #vendorInfo.order > 0 then
        local maxVendors = 2
        local parts = {}
        for i, v in ipairs(vendorInfo.order) do
            if i > maxVendors then
                break
            end
            local label = v.name or "Unknown"
            if v.location and v.location ~= "" and v.location ~= "None" then
                label = label .. " (" .. v.location .. ")"
            end
            parts[#parts + 1] = label
        end
        vendorLine = "Vendors: " .. table.concat(parts, "; ")
        if #vendorInfo.order > maxVendors then
            vendorLine = vendorLine .. string.format(" +%d more", #vendorInfo.order - maxVendors)
        end
    end
    if vendorLine then
        repFrame.vendorText:ClearAllPoints()
        repFrame.vendorText:SetPoint("TOPLEFT", detailAnchor, "BOTTOMLEFT", 0, -2)
        repFrame.vendorText:SetPoint("RIGHT", -10, 0)
        repFrame.vendorText:SetText(vendorLine)
        repFrame.vendorText:Show()
    else
        repFrame.vendorText:Hide()
    end

    local hasProgress = repData.standing ~= "Not Discovered"
        and repData.currentValue
        and repData.maxValue
        and repData.maxValue > 0

    repFrame.notDiscoveredText:SetShown(repData.standing == "Not Discovered")

    if hasProgress then
        -- Leave 120px on right for progress text (e.g., "1234/5678 (100%)")
        local barWidth = repFrame:GetWidth() - 180
        repFrame.progressBg:ClearAllPoints()
        repFrame.progressBg:SetSize(barWidth, 12)
        repFrame.progressBg:SetPoint("BOTTOMLEFT", repFrame, "BOTTOMLEFT", 62, 10)
        repFrame.progressBg:Show()

        local progress = math.min(repData.currentValue / repData.maxValue, 1)
        repFrame.progressBar:ClearAllPoints()
        repFrame.progressBar:SetSize(barWidth * progress, 12)
        repFrame.progressBar:SetPoint("LEFT", repFrame.progressBg, "LEFT", 0, 0)
        if progress >= 1 then
            repFrame.progressBar:SetColorTexture(0, 0.8, 0, 0.8)
        else
            repFrame.progressBar:SetColorTexture(colors.accentPrimary[1], colors.accentPrimary[2], colors.accentPrimary[3], 0.8)
        end
        repFrame.progressBar:Show()

        repFrame.progressText:ClearAllPoints()
        repFrame.progressText:SetPoint("RIGHT", repFrame, "RIGHT", -12, 0)
        repFrame.progressText:SetPoint("BOTTOM", repFrame.progressBg, "BOTTOM", 0, 0)
        local percentage = math.floor(progress * 100)
        repFrame.progressText:SetText(string.format("%d/%d (%d%%)", repData.currentValue, repData.maxValue, percentage))
        repFrame.progressText:Show()
    else
        repFrame.progressBg:Hide()
        repFrame.progressBar:Hide()
        repFrame.progressText:Hide()
    end

    if isExpanded then
        repFrame.arrow:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
        repFrame.arrow:SetRotation(0)
        repFrame.arrow:SetVertexColor(1, 0.82, 0, 1)
    else
        repFrame.arrow:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollEnd-Up")
        repFrame.arrow:SetRotation(math.rad(180))
        repFrame.arrow:SetVertexColor(0.5, 0.5, 0.5, 1)
    end

    if repFrame.details then
        repFrame.details:SetShown(isExpanded == true)
        if isExpanded == true then
            -- Build compact single-line details
            local detailsParts = {}
            table.insert(detailsParts, "|cFF808080ID:|r " .. tostring(repData.factionID or "?"))
            table.insert(detailsParts, "|cFF808080Exp:|r " .. tostring(repData.expansion or "?"))
            table.insert(detailsParts, "|cFF808080Cat:|r " .. tostring(repData.category or "?"))
            
            if repData.isRenown then
                table.insert(detailsParts, "|cFF808080Type:|r Renown")
            else
                table.insert(detailsParts, "|cFF808080Type:|r Standard")
            end
            
            table.insert(detailsParts, "|cFF808080Standing:|r " .. tostring(repData.standing or "?"))
            
            if repData.standing ~= "Not Discovered" and repData.currentValue and repData.maxValue and repData.maxValue > 0 then
                local percentage = math.floor((repData.currentValue / repData.maxValue) * 100)
                table.insert(detailsParts, "|cFF808080Progress:|r " .. tostring(repData.currentValue) .. "/" .. tostring(repData.maxValue) .. " (" .. tostring(percentage) .. "%)")
                
                if not repData.isRenown and repData.standingLevel and repData.standingLevel < 8 then
                    local repNeeded = repData.maxValue - repData.currentValue
                    table.insert(detailsParts, "|cFF808080Next:|r " .. tostring(repNeeded) .. " rep")
                elseif repData.isRenown and repData.currentValue < repData.maxValue then
                    local renownNeeded = repData.maxValue - repData.currentValue
                    table.insert(detailsParts, "|cFF808080Next:|r " .. tostring(renownNeeded))
                elseif (not repData.isRenown and repData.standingLevel == 8) or (repData.isRenown and repData.currentValue >= repData.maxValue) then
                    table.insert(detailsParts, "|cFF00FF00MAX|r")
                end
            end
            
            repFrame.detailsCompact:SetText(table.concat(detailsParts, " |cFF404040•|r "))

            local vendorCount = (vendorInfo and vendorInfo.order and #vendorInfo.order) or 0
            repFrame.vendorHeader:SetShown(vendorCount > 0)
            if vendorCount > 0 then
                local prev = repFrame.vendorHeader
                for i = 1, vendorCount do
                    local fs = repFrame.vendorLines[i]
                    if not fs then
                        fs = repFrame.details:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                        fs:SetJustifyH("LEFT")
                        fs:SetPoint("RIGHT", -10, 0)
                        repFrame.vendorLines[i] = fs
                    end
                    fs:ClearAllPoints()
                    fs:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 10, -6)
                    fs:SetPoint("RIGHT", -10, 0)
                    local v = vendorInfo.order[i]
                    local vendorLabel = (v and v.name) or "Unknown"
                    if v and v.location and v.location ~= "" and v.location ~= "None" then
                        vendorLabel = vendorLabel .. " |cFF808080(|r" .. v.location .. "|cFF808080)|r"
                    end
                    fs:SetText("- " .. vendorLabel)
                    fs:Show()
                    prev = fs
                end
                for i = vendorCount + 1, #repFrame.vendorLines do
                    repFrame.vendorLines[i]:Hide()
                end
            else
                for i = 1, #repFrame.vendorLines do
                    repFrame.vendorLines[i]:Hide()
                end
            end

            -- Show rewards grouped by standing
            local rewards = (HousingReputationHandler and HousingReputationHandler.GetFactionRewards)
                and HousingReputationHandler:GetFactionRewards(repData.factionID) or {}
            local rewardCount = #rewards
            if rewardCount > 0 then
                -- Group rewards by required standing
                local rewardsByStanding = {}
                local standingOrder = {} -- preserve order
                for _, reward in ipairs(rewards) do
                    local standing = reward.requiredStanding or "Unknown"
                    if not rewardsByStanding[standing] then
                        rewardsByStanding[standing] = {}
                        table.insert(standingOrder, standing)
                    end
                    
                    local itemName = reward.itemName or ("Item #" .. tostring(reward.itemID))
                    
                    -- Check if collected
                    local collected = false
                    if HousingReputationHandler and HousingReputationHandler.IsDecorCollected then
                        collected = HousingReputationHandler:IsDecorCollected(reward.itemID)
                    end
                    
                    -- Check if unlocked
                    local unlocked = HousingReputationHandler and HousingReputationHandler.IsRewardUnlocked
                        and HousingReputationHandler:IsRewardUnlocked(repData.factionID, reward) or false
                    
                    table.insert(rewardsByStanding[standing], {
                        name = itemName,
                        collected = collected,
                        unlocked = unlocked
                    })
                end
                
                -- Position rewards header after vendors or after detail compact line
                local rewardsHeaderAnchor = (vendorCount > 0 and repFrame.vendorLines[vendorCount]) or repFrame.detailsCompact
                repFrame.rewardsHeader:ClearAllPoints()
                repFrame.rewardsHeader:SetPoint("TOPLEFT", rewardsHeaderAnchor, "BOTTOMLEFT", 0, -12)
                repFrame.rewardsHeader:Show()

                local prev = repFrame.rewardsHeader
                local lineIndex = 1
                
                for _, standing in ipairs(standingOrder) do
                    local items = rewardsByStanding[standing]
                    if items and #items > 0 then
                        -- Create line for this standing
                        local fs = repFrame.rewardLines[lineIndex]
                        if not fs then
                            fs = repFrame.details:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                            fs:SetJustifyH("LEFT")
                            fs:SetWordWrap(true)
                            fs:SetPoint("RIGHT", -10, 0)
                            repFrame.rewardLines[lineIndex] = fs
                        end
                        fs:ClearAllPoints()
                        fs:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 10, -6)
                        fs:SetPoint("RIGHT", -10, 0)
                        
                        -- Build item list with status icons
                        local itemTexts = {}
                        for _, item in ipairs(items) do
                            local icon = ""
                            if item.collected then
                                icon = "|TInterface\\RAIDFRAME\\ReadyCheck-Ready:14:14|t"
                            elseif item.unlocked then
                                icon = "|TInterface\\RAIDFRAME\\ReadyCheck-Waiting:14:14|t"
                            else
                                icon = "|TInterface\\RAIDFRAME\\ReadyCheck-NotReady:14:14|t"
                            end
                            table.insert(itemTexts, icon .. " " .. item.name)
                        end
                        
                        local standingText = string.format("|cFFFFD700%s:|r %s", standing, table.concat(itemTexts, ", "))
                        fs:SetText(standingText)
                        fs:Show()
                        prev = fs
                        lineIndex = lineIndex + 1
                    end
                end
                
                -- Hide unused lines
                for i = lineIndex, #repFrame.rewardLines do
                    repFrame.rewardLines[i]:Hide()
                end
            else
                repFrame.rewardsHeader:Hide()
                for i = 1, #repFrame.rewardLines do
                    repFrame.rewardLines[i]:Hide()
                end
            end
        end
    end
end

-- Refresh reputation list
function ReputationUI:Refresh()
    if not self._reputationContainer or not self._scrollChild then
        return
    end

    local container = self._reputationContainer
    local scrollChild = self._scrollChild
    local summaryFrame = container.summaryFrame

    scrollChild.reputations = scrollChild.reputations or {}

    if not HousingReputationHandler then
        return
    end

    -- Get reputation list (live data for current character)
    local reputationList = HousingReputationHandler:GetReputations()

    if not reputationList or #reputationList == 0 then
        -- Show "no data" message
        local noDataText = summaryFrame.noDataText or summaryFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        summaryFrame.noDataText = noDataText
        noDataText:SetPoint("CENTER", scrollChild, "CENTER", 0, 0)
        noDataText:SetText("|cFFFF8040No reputation data available.|r")

        if summaryFrame.text then
            summaryFrame.text:Hide()
        end
        return
    end

    -- Hide no data message if it exists
    if summaryFrame.noDataText then
        summaryFrame.noDataText:Hide()
    end
    if summaryFrame.text then
        summaryFrame.text:Show()
    end

    local reqByFaction = BuildRequiredStandingByFaction()

    -- Filter reputations
    local filteredList = {}
    local lowerCache = self._hvLowerLabelCache or {}
    self._hvLowerLabelCache = lowerCache
    for _, repData in ipairs(reputationList) do
        local expansion = repData.expansion or "Unknown"
        local category = repData.category or "Unknown"

        local matchesExpansion = (self._filterExpansion == "All" or expansion == self._filterExpansion)
        local matchesCategory = (self._filterCategory == "All" or category == self._filterCategory)
        local matchesSearch = true
        if self._searchText ~= "" then
            local fid = tostring(repData.factionID or "")
            local label = tostring(repData.label or "")
            local cached = lowerCache[fid]
            if not cached or cached.label ~= label then
                cached = { label = label, lower = label:lower() }
                lowerCache[fid] = cached
            end
            matchesSearch = (cached.lower ~= "" and string.find(cached.lower, self._searchText, 1, true) ~= nil)
        end

        if matchesExpansion and matchesCategory and matchesSearch then
            table.insert(filteredList, repData)
        end
    end

    -- Update summary
    local summaryText = summaryFrame.text or summaryFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    summaryFrame.text = summaryText
    summaryText:SetPoint("CENTER")
    summaryText:SetJustifyH("CENTER")

    local charName = (self._selectedCharacter and self._selectedCharacter:match("^([^-]+)")) or "Current"
    summaryText:SetText(string.format(
        "|cFFFFD700%d|r factions for |cFF00CCFF%s|r",
        #filteredList, charName
    ))

    -- Display reputations
    local yOffset = -10
    local repFrames = scrollChild.reputations or {}
    scrollChild.reputations = repFrames
    local baseColors = GetThemeColors()
    local accentPrimary = EnsureColorTable(baseColors.accentPrimary, { 0.8, 0.6, 0.2, 1 })
    local bgHover = EnsureColorTable(baseColors.bgHover, { 0.2, 0.2, 0.2, 1 })
    local repVendorIndex = BuildReputationVendorIndex()

    local used = 0
    for _, repData in ipairs(filteredList) do
        used = used + 1
        -- Check if this reputation is expanded
        local isExpanded = self._expandedReputations[repData.factionID]

        -- Reputation card (increased height to fit faction details)
        local repFrame = AcquireReputationFrame(scrollChild, used)
        local extraLines = 0
        if repData.isRenown then
            extraLines = extraLines + 1
        end
        local vendorInfo = repVendorIndex[tostring(repData.factionID)]
        if vendorInfo and vendorInfo.order and #vendorInfo.order > 0 then
            extraLines = extraLines + 1
        end

        -- Calculate height based on expanded state
        local baseHeight = 70 + (extraLines * 16)
        local expandedHeight = 0
        if isExpanded then
            -- Add height for detailed information (Faction ID, Expansion, Category, Type, Standing)
            expandedHeight = 140

            -- Add height for progress info (Current Progress line)
            if repData.currentValue and repData.maxValue then
                expandedHeight = expandedHeight + 18

                -- Add height for "To Next Level" line
                if (not repData.isRenown and repData.standingLevel and repData.standingLevel < 8) or
                   (repData.isRenown and repData.currentValue < repData.maxValue) or
                   ((not repData.isRenown and repData.standingLevel == 8) or (repData.isRenown and repData.currentValue >= repData.maxValue)) then
                    expandedHeight = expandedHeight + 18
                end
            end

            -- Add spacing before vendors
            expandedHeight = expandedHeight + 4

            -- Add height for each vendor if there are vendors
            if vendorInfo and vendorInfo.order and #vendorInfo.order > 0 then
                expandedHeight = expandedHeight + (#vendorInfo.order * 20) + 22
            end
        end
        local repHeight = baseHeight + expandedHeight
        repFrame:SetSize(scrollChild:GetWidth() - 20, repHeight)
        repFrame:SetPoint("TOPLEFT", 10, yOffset)
        UpdateReputationFrame(
            repFrame,
            repData,
            vendorInfo,
            reqByFaction[tostring(repData.factionID)],
            { accentPrimary = accentPrimary, bgHover = bgHover },
            isExpanded == true
        )
        repFrame:Show()

        yOffset = yOffset - (repHeight + 8)
    end

    for i = used + 1, #repFrames do
        repFrames[i]:Hide()
    end
    scrollChild:SetHeight(math.abs(yOffset) + 20)
end

-- Show reputation UI
function ReputationUI:Show()
    local container = self._reputationContainer or self:CreateReputationContainer()
    if not container then
        return
    end

    -- Hide other UI panels
    if HousingAchievementsUI and HousingAchievementsUI.Hide then
        HousingAchievementsUI:Hide()
    end
    if HousingEndeavorsUI and HousingEndeavorsUI.Hide then
        HousingEndeavorsUI:Hide()
    end
    if HousingStatisticsUI and HousingStatisticsUI.Hide then
        HousingStatisticsUI:Hide()
    end
    if HousingAuctionHouseUI and HousingAuctionHouseUI.Hide then
        HousingAuctionHouseUI:Hide()
    end

    -- Hide main UI components and nav buttons
    SetMainUIVisible(false)

    -- Refresh and show
    self:Refresh()
    container:Show()
end

-- Hide reputation UI
function ReputationUI:Hide()
    if self._reputationContainer then
        self._reputationContainer:Hide()
    end

    -- Show main UI components and nav buttons again
    SetMainUIVisible(true)
end

-- Make globally accessible
_G.HousingReputationUI = ReputationUI

return ReputationUI
