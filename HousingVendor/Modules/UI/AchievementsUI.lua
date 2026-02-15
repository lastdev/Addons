-- Achievements UI Module
-- Browse and track housing achievement progress

local ADDON_NAME, ns = ...
local L = ns.L

local AchievementsUI = {}
AchievementsUI.__index = AchievementsUI

AchievementsUI._achievementsContainer = AchievementsUI._achievementsContainer or nil
AchievementsUI._parentFrame = AchievementsUI._parentFrame or nil
AchievementsUI._currentFontSize = AchievementsUI._currentFontSize or 12
AchievementsUI._fontStrings = AchievementsUI._fontStrings or {}
AchievementsUI._scrollFrame = AchievementsUI._scrollFrame or nil
AchievementsUI._scrollChild = AchievementsUI._scrollChild or nil
AchievementsUI._searchText = AchievementsUI._searchText or ""
AchievementsUI._filterExpansion = AchievementsUI._filterExpansion or "All"
AchievementsUI._filterStatus = AchievementsUI._filterStatus or "All"
AchievementsUI._expandedAchievements = AchievementsUI._expandedAchievements or {}

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

local function AcquireAchievementFrame(scrollChild, index)
    if not scrollChild then return nil end
    scrollChild._hvAchFramePool = scrollChild._hvAchFramePool or {}
    local pool = scrollChild._hvAchFramePool
    if pool[index] then
        return pool[index]
    end

    local achFrame = CreateFrame("Button", nil, scrollChild, "BackdropTemplate")
    achFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    achFrame:SetBackdropColor(0.08, 0.08, 0.08, 0.9)
    achFrame:SetBackdropBorderColor(0.25, 0.25, 0.25, 1)

    achFrame.icon = achFrame:CreateTexture(nil, "ARTWORK")
    achFrame.icon:SetSize(48, 48)
    achFrame.icon:SetPoint("TOPLEFT", 10, -11)

    achFrame.checkmark = achFrame:CreateTexture(nil, "OVERLAY")
    achFrame.checkmark:SetSize(24, 24)
    achFrame.checkmark:SetPoint("BOTTOMRIGHT", achFrame.icon, "BOTTOMRIGHT", 2, -2)
    achFrame.checkmark:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
    achFrame.checkmark:Hide()

    achFrame.nameText = achFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    achFrame.nameText:SetPoint("TOPLEFT", achFrame.icon, "TOPRIGHT", 12, -2)
    achFrame.nameText:SetPoint("RIGHT", -60, 0)
    achFrame.nameText:SetJustifyH("LEFT")
    achFrame.nameText:SetWordWrap(false)

    achFrame.descText = achFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    achFrame.descText:SetPoint("TOPLEFT", achFrame.nameText, "BOTTOMLEFT", 0, -4)
    achFrame.descText:SetPoint("RIGHT", achFrame.nameText, "RIGHT", 0, 0)
    achFrame.descText:SetJustifyH("LEFT")
    achFrame.descText:SetWordWrap(true)
    achFrame.descText:Hide()

    achFrame.infoText = achFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    achFrame.infoText:SetJustifyH("LEFT")

    achFrame.rewardText = achFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    achFrame.rewardText:SetPoint("TOPRIGHT", -10, -10)
    achFrame.rewardText:Hide()

    achFrame.progressBg = achFrame:CreateTexture(nil, "BACKGROUND")
    achFrame.progressBg:SetColorTexture(0.2, 0.2, 0.2, 0.8)
    achFrame.progressBg:Hide()

    achFrame.progressBar = achFrame:CreateTexture(nil, "ARTWORK")
    achFrame.progressBar:Hide()

    achFrame.progressText = achFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    achFrame.progressText:Hide()

    achFrame.arrow = achFrame:CreateTexture(nil, "OVERLAY")
    achFrame.arrow:SetSize(16, 16)
    achFrame.arrow:SetPoint("RIGHT", -10, 0)
    achFrame.arrow:Hide()

    achFrame.criteriaBg = achFrame:CreateTexture(nil, "BACKGROUND", nil, -1)
    achFrame.criteriaBg:SetColorTexture(0, 0, 0, 0.3)
    achFrame.criteriaBg:Hide()

    achFrame.criteriaRows = {}

    achFrame:SetScript("OnEnter", function(self)
        local theme = HousingTheme or {}
        local colors = theme.Colors or {}
        local bgHover = colors.bgHover or {0.2, 0.2, 0.2, 1}
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], 0.9)

        local achData = self._hvAchData
        local achInfo = self._hvAchInfo
        local completed = self._hvCompleted == true
        if not (achData and achInfo and GameTooltip) then
            return
        end

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(achData.name or "Unknown", 1, 0.82, 0, true)
        GameTooltip:AddLine(" ")

        if achData.description then
            GameTooltip:AddLine(achData.description, 0.6, 0.6, 0.6, true)
            GameTooltip:AddLine(" ")
        end

        if achInfo.title then
            GameTooltip:AddLine("Housing Item Reward:", 0.8, 0.8, 0.8, true)
            GameTooltip:AddLine("  " .. achInfo.title, 1, 1, 1, true)
        else
            GameTooltip:AddLine("No housing item reward", 0.6, 0.6, 0.6, true)
        end

        GameTooltip:AddLine(" ")
        if completed then
            GameTooltip:AddLine("Achievement Completed!", 0, 1, 0, true)
        else
            GameTooltip:AddLine("Not yet completed", 0.8, 0.5, 0, true)
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Click for more details", 0.5, 0.8, 1, true)
        GameTooltip:Show()
    end)

    achFrame:SetScript("OnLeave", function(self)
        self:SetBackdropColor(0.08, 0.08, 0.08, 0.9)
        if GameTooltip then
            GameTooltip:Hide()
        end
    end)

    achFrame:SetScript("OnClick", function(self)
        local achInfo = self._hvAchInfo
        if not achInfo then return end
        AchievementsUI._expandedAchievements[achInfo.id] = not AchievementsUI._expandedAchievements[achInfo.id]
        AchievementsUI:Refresh()
    end)

    pool[index] = achFrame
    return achFrame
end

-- Initialize achievements UI
function AchievementsUI:Initialize(parent)
    self._parentFrame = parent
    -- Load saved font size
    self._currentFontSize = (HousingDB and HousingDB.fontSize) or 12
end

-- Create achievements container in main UI
function AchievementsUI:CreateAchievementsContainer()
    if self._achievementsContainer then
        return self._achievementsContainer
    end

    local parentFrame = self._parentFrame
    if not parentFrame then
        return nil
    end

    local currentFontSize = self._currentFontSize or 12
    local fontStrings = self._fontStrings or {}
    self._fontStrings = fontStrings

    -- Create container that will replace the item list and filters
    local container = CreateFrame("Frame", "HousingVendorAchievementsContainer", parentFrame)
    container:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -70)
    container:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -20, 52)
    container:Hide()

    -- Back button (Midnight theme styled)
    local theme = HousingTheme or {}
    local bgTertiary = theme.Colors.bgTertiary or {0.1, 0.1, 0.1, 1}
    local borderPrimary = theme.Colors.borderPrimary or {0.3, 0.3, 0.3, 1}
    local bgHover = theme.Colors.bgHover or {0.2, 0.2, 0.2, 1}
    local accentPrimary = theme.Colors.accentPrimary or {0.8, 0.6, 0.2, 1}
    local textPrimary = theme.Colors.textPrimary or {1, 1, 1, 1}
    local textHighlight = theme.Colors.textHighlight or {1, 0.82, 0, 1}

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
	        AchievementsUI:Hide()
	        if _G.HousingUINew and _G.HousingUINew.ReturnToCaller then
	            _G.HousingUINew:ReturnToCaller()
	        end
	    end)

    -- Title
    local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    title:SetPoint("TOP", 0, -15)
    local titleFont, titleSize, titleFlags = title:GetFont()
    if currentFontSize ~= 12 then
        title:SetFont(titleFont, currentFontSize + 4, titleFlags)
    end
    title:SetText("|cFFFFD700" .. (L["ACHIEVEMENTS_TITLE"] or "Housing Achievements") .. "|r")
    table.insert(fontStrings, title)

    -- Scan button
    local scanBtn = CreateFrame("Button", nil, container, "BackdropTemplate")
    scanBtn:SetSize(80, 28)
    scanBtn:SetPoint("TOPRIGHT", -10, -10)
    scanBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    scanBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    scanBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])

    local scanBtnText = scanBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scanBtnText:SetPoint("CENTER")
    scanBtnText:SetText(L["ACHIEVEMENTS_SCAN_BUTTON"] or "Scan")
    scanBtnText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    scanBtn.label = scanBtnText

    scanBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
        self.label:SetTextColor(textHighlight[1], textHighlight[2], textHighlight[3], 1)
    end)
    scanBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
        self.label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    end)
    scanBtn:SetScript("OnClick", function()
        AchievementsUI:ScanAchievements()
    end)

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
    expFilterText:SetText(string.format("%s: %s", L["FILTER_EXPANSION"] or "Expansion", L["FILTER_ALL_EXPANSIONS"] or "All"))
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
        AchievementsUI:ShowExpansionFilterMenu(self)
    end)
    container.expFilterBtn = expFilterBtn

    -- Status filter (next to expansion)
    local statusFilterBtn = CreateFrame("Button", nil, filterSearchFrame, "BackdropTemplate")
    statusFilterBtn:SetSize(180, 28)
    statusFilterBtn:SetPoint("LEFT", expFilterBtn, "RIGHT", 10, 0)
    statusFilterBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    statusFilterBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    statusFilterBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])

    local statusFilterText = statusFilterBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statusFilterText:SetPoint("CENTER")
    statusFilterText:SetText(string.format("%s: %s", L["ACHIEVEMENTS_FILTER_STATUS"] or "Status", L["STATUS_ALL"] or "All"))
    statusFilterText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    statusFilterBtn.label = statusFilterText

    statusFilterBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    statusFilterBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    end)
    statusFilterBtn:SetScript("OnClick", function(self)
        AchievementsUI:ShowStatusFilterMenu(self)
    end)
    container.statusFilterBtn = statusFilterBtn

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
            AchievementsUI._searchText = self:GetText():lower()
            AchievementsUI:Refresh()
        end
    end)
    container.searchBox = searchBox

    local searchPlaceholder = searchFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    searchPlaceholder:SetPoint("LEFT", searchBox, "LEFT", 5, 0)
    searchPlaceholder:SetText("|cFF808080" .. (L["ACHIEVEMENTS_SEARCH_PLACEHOLDER"] or "Search achievements...") .. "|r")
    searchPlaceholder:SetJustifyH("LEFT")
    searchBox:SetScript("OnEditFocusGained", function() searchPlaceholder:Hide() end)
    searchBox:SetScript("OnEditFocusLost", function(self)
        if self:GetText() == "" then
            searchPlaceholder:Show()
        end
    end)

    -- Summary section (compact)
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

    -- Scroll frame for achievement list
    local scrollFrame = CreateFrame("ScrollFrame", nil, container, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", summaryFrame, "BOTTOMLEFT", 0, -10)
    scrollFrame:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", -30, 10)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetSize(scrollFrame:GetWidth(), 1)
    scrollFrame:SetScrollChild(scrollChild)

    self._scrollFrame = scrollFrame
    self._scrollChild = scrollChild

    self._achievementsContainer = container
    return container
end

-- Show expansion filter menu
function AchievementsUI:ShowExpansionFilterMenu(button)
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
    local achievementList = HousingAchievementHandler:GetAchievementList()
    if achievementList then
        for _, achInfo in ipairs(achievementList) do
            local exp = achInfo.expansion or "Unknown"
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
            AchievementsUI._filterExpansion = exp
            AchievementsUI._achievementsContainer.expFilterBtn.label:SetText(string.format("%s: %%s", L["FILTER_EXPANSION"] or "Expansion"):format(exp))
            AchievementsUI:Refresh()
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

-- Show status filter menu
function AchievementsUI:ShowStatusFilterMenu(button)
    local menu = CreateFrame("Frame", nil, button, "BackdropTemplate")
    menu:SetFrameStrata("DIALOG")
    menu:SetFrameLevel(200)
    menu:SetSize(200, 120)
    menu:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -2)
    menu:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    menu:SetBackdropColor(0.1, 0.1, 0.1, 0.95)
    menu:SetBackdropBorderColor(0.8, 0.6, 0.2, 1)

    local statuses = { "All", "Completed", "Incomplete", "In Progress" }
    local yOffset = -10

    for _, status in ipairs(statuses) do
        local btn = CreateFrame("Button", nil, menu, "BackdropTemplate")
        btn:SetSize(180, 25)
        btn:SetPoint("TOPLEFT", 10, yOffset)
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            tile = false,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        btn:SetBackdropColor(0.15, 0.15, 0.15, 1)

        local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("LEFT", 8, 0)
        text:SetText(status)
        if status == self._filterStatus then
            text:SetTextColor(1, 0.82, 0, 1)
        else
            text:SetTextColor(1, 1, 1, 1)
        end

        btn:SetScript("OnEnter", function(self) self:SetBackdropColor(0.25, 0.25, 0.25, 1) end)
        btn:SetScript("OnLeave", function(self) self:SetBackdropColor(0.15, 0.15, 0.15, 1) end)
        btn:SetScript("OnClick", function()
            AchievementsUI._filterStatus = status
            AchievementsUI._achievementsContainer.statusFilterBtn.label:SetText(string.format("%s: %%s", L["ACHIEVEMENTS_FILTER_STATUS"] or "Status"):format(status))
            AchievementsUI:Refresh()
            menu:Hide()
        end)

        yOffset = yOffset - 30
    end

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

-- Scan achievements
function AchievementsUI:ScanAchievements()
    if not HousingAchievementHandler then
        print("|cFFFF4040HousingVendor:|r Achievement handler not available")
        return
    end

    print("|cFF8A7FD4HousingVendor:|r Scanning achievements...")

    -- Force rescan when user manually clicks the Scan button
    HousingAchievementHandler:ScanAllAchievements(function(success, error, scanned, completed)
        if success then
            AchievementsUI:Refresh()
            print("|cFF00FF00Scan complete!|r Scanned " .. scanned .. " achievements, " .. completed .. " completed")
        else
            print("|cFFFF4040Error:|r " .. tostring(error))
        end
    end, true)  -- true = force rescan
end

-- Refresh the achievements display
function AchievementsUI:Refresh()
    if not self._achievementsContainer or not HousingAchievementHandler then
        return
    end

    local container = self._achievementsContainer
    local summaryFrame = container.summaryFrame
    local scrollChild = self._scrollChild

    scrollChild.achievements = scrollChild.achievements or {}

    -- Get statistics
    local stats = HousingAchievementHandler:GetStatistics()
    if not stats then
        return
    end

    -- Get filtered achievements
    local achievementList = HousingAchievementHandler:GetAchievementList()
    if not achievementList or #achievementList == 0 then
        -- Show "no data" message
        local noDataText = summaryFrame.noDataText or summaryFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        summaryFrame.noDataText = noDataText
        noDataText:SetPoint("CENTER", scrollChild, "CENTER", 0, 0)
        noDataText:SetText("|cFFFF8040No achievement data loaded.\n\nClick the 'Scan' button to load achievements.|r")

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

    local filteredList = {}
    local filteredCompleted = 0

    for _, achInfo in ipairs(achievementList) do
        local achData = HousingAchievementHandler:GetAchievement(achInfo.id)
        local expansion = achInfo.expansion or "Unknown"
        local completed = achData and achData.completed or false
        local inProgress = achData and achData.numCriteria and achData.numCompleted > 0 and not completed

        -- Apply filters
        local matchesExpansion = (self._filterExpansion == "All" or expansion == self._filterExpansion)
        local matchesStatus = (self._filterStatus == "All") or
            (self._filterStatus == "Completed" and completed) or
            (self._filterStatus == "Incomplete" and not completed) or
            (self._filterStatus == "In Progress" and inProgress)
        local matchesSearch = (self._searchText == "" or
            (achData and achData.name and string.find(achData.name:lower(), self._searchText, 1, true)))

        if matchesExpansion and matchesStatus and matchesSearch then
            table.insert(filteredList, achInfo)
            if completed then
                filteredCompleted = filteredCompleted + 1
            end
        end
    end

    -- Update summary
    local summaryText = summaryFrame.text or summaryFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    summaryFrame.text = summaryText
    summaryText:SetPoint("CENTER")
    summaryText:SetJustifyH("CENTER")

    local filteredPercent = #filteredList > 0 and math.floor((filteredCompleted / #filteredList) * 100) or 0
    summaryText:SetText(string.format(
        "|cFFFFD700%d/%d|r |cFF808080(%d%%)|r",
        filteredCompleted, #filteredList, filteredPercent
    ))

    -- Display achievements (reuses frames to avoid churn/leaks)
    local yOffset = -10
    local theme = HousingTheme or {}
    local colors = theme.Colors or {}
    local accentPrimary = colors.accentPrimary or {0.8, 0.6, 0.2, 1}

    local used = 0

    for _, achInfo in ipairs(filteredList) do
        local achData = HousingAchievementHandler:GetAchievement(achInfo.id)
        if achData then
            used = used + 1
            local completed = achData.completed
            local isExpanded = self._expandedAchievements[achInfo.id]

            -- Calculate height based on expanded state
            local baseHeight = 70
            local criteriaHeight = 0
            if isExpanded and achData.criteria and #achData.criteria > 0 then
                criteriaHeight = (#achData.criteria * 25) + 40
            end
            local totalHeight = baseHeight + criteriaHeight

            local achFrame = AcquireAchievementFrame(scrollChild, used)
            achFrame:SetParent(scrollChild)
            achFrame:SetSize(scrollChild:GetWidth() - 20, totalHeight)
            achFrame:SetPoint("TOPLEFT", 10, yOffset)
            achFrame:Show()
            achFrame._hvAchInfo = achInfo
            achFrame._hvAchData = achData
            achFrame._hvCompleted = completed == true

            if achFrame.icon then
                achFrame.icon:SetTexture(achData.icon or "Interface\\Icons\\Achievement_GarrisonFollower_ItemLevel600")
            end

            if achFrame.checkmark then
                if completed then achFrame.checkmark:Show() else achFrame.checkmark:Hide() end
            end

            if achFrame.nameText then
                local nameColor = completed and "|cFF00FF00" or "|cFFFFFFFF"
                achFrame.nameText:SetText(nameColor .. (achData.name or "Unknown") .. "|r")
            end

            local lastAnchor = achFrame.nameText
            if achFrame.descText then
                if achData.description and achData.description ~= "" then
                    achFrame.descText:SetText("|cFF9D9D9D" .. achData.description .. "|r")
                    achFrame.descText:Show()
                    lastAnchor = achFrame.descText
                else
                    achFrame.descText:Hide()
                end
            end

            if achFrame.infoText then
                achFrame.infoText:ClearAllPoints()
                achFrame.infoText:SetPoint("TOPLEFT", lastAnchor, "BOTTOMLEFT", 0, -3)
                local expansion = achInfo.expansion or "Unknown"
                achFrame.infoText:SetText("|cFF808080" .. (L["ACHIEVEMENTS_ID"] or "Achievement ID:") .. "|r " .. achInfo.id .. " |cFF808080(|r" .. expansion .. "|cFF808080)|r")
                achFrame.infoText:Show()
            end

            -- Achievement points (hidden per user request)
            -- if achData.points and achData.points > 0 then
            --     local pointsText = achFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            --     pointsText:SetPoint("TOPRIGHT", -10, -10)
            --     pointsText:SetText("|cFFFFD700" .. achData.points .. " pts|r")
            -- end

            -- Reward item (show what housing item you get)
            if achFrame.rewardText then
                local itemName = nil
                if achInfo.itemID then
                    itemName = GetItemInfo(achInfo.itemID)
                    if not itemName and achInfo.title then
                        itemName = achInfo.title
                    end
                end
                if itemName then
                    achFrame.rewardText:SetText("|cFF00CCFFReward:|r " .. itemName)
                    achFrame.rewardText:Show()
                else
                    achFrame.rewardText:Hide()
                end
            end

            -- Progress bar (if has criteria)
            if achData.numCriteria and achData.numCriteria > 0 and achFrame.progressBg and achFrame.progressBar and achFrame.progressText then
                -- Leave 50px on right for progress text (e.g., "5/5")
                local barWidth = achFrame:GetWidth() - 130
                achFrame.progressBg:SetSize(barWidth, 12)
                achFrame.progressBg:ClearAllPoints()
                achFrame.progressBg:SetPoint("BOTTOMLEFT", achFrame.icon, "BOTTOMRIGHT", 12, 0)
                achFrame.progressBg:Show()

                local progress = (achData.numCompleted or 0) / (achData.numCriteria or 1)
                if progress < 0 then progress = 0 end
                if progress > 1 then progress = 1 end
                achFrame.progressBar:SetSize(barWidth * progress, 12)
                achFrame.progressBar:ClearAllPoints()
                achFrame.progressBar:SetPoint("LEFT", achFrame.progressBg, "LEFT", 0, 0)
                if completed then
                    achFrame.progressBar:SetColorTexture(0, 0.8, 0, 0.8)
                else
                    achFrame.progressBar:SetColorTexture(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.8)
                end
                achFrame.progressBar:Show()

                achFrame.progressText:ClearAllPoints()
                achFrame.progressText:SetPoint("RIGHT", achFrame, "RIGHT", -12, 0)
                achFrame.progressText:SetPoint("BOTTOM", achFrame.progressBg, "BOTTOM", 0, 0)
                achFrame.progressText:SetText(string.format("%d/%d", achData.numCompleted or 0, achData.numCriteria or 0))
                achFrame.progressText:Show()
            else
                if achFrame.progressBg then achFrame.progressBg:Hide() end
                if achFrame.progressBar then achFrame.progressBar:Hide() end
                if achFrame.progressText then achFrame.progressText:Hide() end
            end

            -- Expand arrow (using texture instead of emoticons)
            if achFrame.arrow then
                if achData.criteria and #achData.criteria > 0 then
                    achFrame.arrow:Show()
                if isExpanded then
                    -- Down arrow for expanded state
                    achFrame.arrow:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
                    achFrame.arrow:SetRotation(0)
                    achFrame.arrow:SetVertexColor(1, 0.82, 0, 1)  -- Gold color
                else
                    -- Right arrow for collapsed state
                    achFrame.arrow:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollEnd-Up")
                    achFrame.arrow:SetRotation(math.rad(180))  -- Rotate to point right
                    achFrame.arrow:SetVertexColor(0.5, 0.5, 0.5, 1)  -- Gray color
                end
                else
                    achFrame.arrow:Hide()
                end
            end

            -- Expanded criteria section
            if isExpanded and achData.criteria and #achData.criteria > 0 and achFrame.criteriaBg then
                achFrame.criteriaBg:ClearAllPoints()
                achFrame.criteriaBg:SetPoint("TOPLEFT", achFrame.icon, "BOTTOMLEFT", -5, -10)
                achFrame.criteriaBg:SetPoint("BOTTOMRIGHT", -5, 5)
                achFrame.criteriaBg:Show()
                local criteriaYOffset = -85
                local rowUsed = 0
                for i, criteria in ipairs(achData.criteria) do
                    rowUsed = rowUsed + 1
                    local row = achFrame.criteriaRows[rowUsed]
                    if not row then
                        row = {}
                        row.frame = CreateFrame("Frame", nil, achFrame)
                        row.frame:SetSize(achFrame:GetWidth() - 40, 22)
                        row.checkIcon = row.frame:CreateTexture(nil, "OVERLAY")
                        row.checkIcon:SetSize(16, 16)
                        row.checkIcon:SetPoint("LEFT", 0, 0)
                        row.text = row.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                        row.text:SetPoint("LEFT", row.checkIcon, "RIGHT", 8, 0)
                        row.text:SetPoint("RIGHT", -10, 0)
                        row.text:SetJustifyH("LEFT")
                        row.text:SetWordWrap(false)
                        achFrame.criteriaRows[rowUsed] = row
                    end

                    row.frame:SetSize(achFrame:GetWidth() - 40, 22)
                    row.frame:ClearAllPoints()
                    row.frame:SetPoint("TOPLEFT", 20, criteriaYOffset)
                    row.frame:Show()

                    if criteria.completed then
                        row.checkIcon:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
                    else
                        row.checkIcon:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")
                    end

                    local criteriaColor = criteria.completed and "|cFF00FF00" or "|cFFCCCCCC"
                    local criteriaStr = criteria.text or "Unknown Criteria"
                    if criteria.quantity and criteria.reqQuantity and criteria.reqQuantity > 1 then
                        criteriaStr = criteriaStr .. string.format(" (%d/%d)", criteria.quantity, criteria.reqQuantity)
                    end
                    row.text:SetText(criteriaColor .. criteriaStr .. "|r")

                    criteriaYOffset = criteriaYOffset - 25
                end

                for i = rowUsed + 1, #achFrame.criteriaRows do
                    local row = achFrame.criteriaRows[i]
                    if row and row.frame then
                        row.frame:Hide()
                    end
                end
            else
                if achFrame.criteriaBg then achFrame.criteriaBg:Hide() end
                if achFrame.criteriaRows then
                    for i = 1, #achFrame.criteriaRows do
                        local row = achFrame.criteriaRows[i]
                        if row and row.frame then
                            row.frame:Hide()
                        end
                    end
                end
            end
            yOffset = yOffset - totalHeight - 8
        end
    end
    scrollChild.achievements = scrollChild._hvAchFramePool
    for i = used + 1, #(scrollChild._hvAchFramePool or {}) do
        local f = scrollChild._hvAchFramePool[i]
        if f then
            f:Hide()
            f:SetParent(nil)
            f._hvAchInfo = nil
            f._hvAchData = nil
            f._hvCompleted = nil
        end
    end
    scrollChild:SetHeight(math.abs(yOffset) + 20)
end

-- Show achievements UI
function AchievementsUI:Show()
    local container = self._achievementsContainer or self:CreateAchievementsContainer()
    if not container then
        return
    end

    -- Hide other UI panels
    if HousingReputationUI and HousingReputationUI.Hide then
        HousingReputationUI:Hide()
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

    -- Auto-scan achievements if needed (uses cache if available)
    if HousingAchievementHandler then
        HousingAchievementHandler:ScanAllAchievements(function(success, error, scanned, completed)
            if success then
                self:Refresh()
            end
        end, false)  -- false = use cache if available
    end

    -- Refresh and show
    self:Refresh()
    container:Show()
end

-- Hide achievements UI
function AchievementsUI:Hide()
    if self._achievementsContainer then
        self._achievementsContainer:Hide()
    end

    -- Show main UI components and nav buttons again
    SetMainUIVisible(true)
end

-- Make globally accessible
_G["HousingAchievementsUI"] = AchievementsUI

return AchievementsUI
