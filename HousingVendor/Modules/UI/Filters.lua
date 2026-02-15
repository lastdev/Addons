-- Filters Module
-- Midnight Theme - Clean, Modern Filter Controls

local ADDON_NAME, ns = ...
local L = ns.L

local Filters = {}
Filters.__index = Filters

-- Cache global references for performance
local _G = _G
local CreateFrame = CreateFrame
local table_insert = table.insert

local filterFrame = nil

-- Track any dropdown/list popups that create full-screen click-catchers so we can hide them
-- when switching to other sub-UIs (Auction House, Achievements, etc.).
local popupRegistry = {}
Filters._popupRegistry = popupRegistry

function Filters:HideAllPopups()
    for i = 1, #popupRegistry do
        local entry = popupRegistry[i]
        if entry then
            local listFrame = entry.listFrame
            local clickCatcher = entry.clickCatcher
            if clickCatcher and clickCatcher.Hide then
                clickCatcher:Hide()
            end
            if listFrame and listFrame.Hide and listFrame.IsShown and listFrame:IsShown() then
                listFrame:Hide()
            end
        end
    end
end

-- Theme reference
local Theme = nil
local function GetTheme()
    if not Theme then
        Theme = HousingTheme or {}
    end
    return Theme
end

local FilterModel = ns.FilterModel

-- Get default faction based on player's faction
local function GetPlayerFactionDefault()
    local playerFaction = UnitFactionGroup and UnitFactionGroup("player") or nil
    if playerFaction == "Alliance" or playerFaction == "Horde" then
        return playerFaction
    end
    return "All Factions"
end

local currentFilters = (FilterModel and FilterModel.CreateDefaultFilters and FilterModel:CreateDefaultFilters()) or {
    searchText = "",
    expansion = "All Expansions",
    vendor = "All Vendors",
    zone = "All Zones",
    type = "All Types",
    category = "All Categories",
    faction = GetPlayerFactionDefault(),
    source = "All Sources",
    collection = "All",
    quality = "All Qualities",
    requirement = "All Requirements",
    hideVisited = false,
    hideNotReleased = false,
    showOnlyAvailable = true,
    selectedExpansions = {},
    selectedSources = {},
    selectedFactions = {},
    selectedCategories = {},
    excludeExpansions = false,
    excludeSources = false,
    zoneMapID = nil,
    _userSetZone = false,
}

-- Expose the live filters table for other modules (VendorHelper, tooltips, etc).
-- IMPORTANT: this must be the same table that `ApplyFilters()` passes to the item list.
Filters.currentFilters = currentFilters

-- Initialize filters
function Filters:Initialize(parentFrame)
    self:CreateFilterSection(parentFrame)
end

-- Create filter section (Midnight Theme)
function Filters:CreateFilterSection(parentFrame)
    local theme = GetTheme()
    local colors = theme.Colors or {}
    
    filterFrame = CreateFrame("Frame", "HousingFilterFrame", parentFrame, "BackdropTemplate")
    filterFrame._hvControls = {}
    -- Position below header
    local topOffset = -55  -- Just below header
    filterFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 2, topOffset)
    filterFrame:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -2, topOffset)
    filterFrame:SetHeight(130)  -- Compact height for 3 rows
    
    -- Midnight theme backdrop
    filterFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    local bgSecondary = HousingTheme.Colors.bgSecondary
    local bgTertiary = HousingTheme.Colors.bgTertiary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    filterFrame:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], bgSecondary[4])
    filterFrame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.5)
    
    -- Perfect grid alignment - all dropdowns same width and spacing
    local dropdownWidth = 200  -- Wider dropdowns
    local spacing = 20  -- More breathing room
    local leftMargin = 15
    local col1X = leftMargin
    local col2X = col1X + dropdownWidth + spacing
    local col3X = col2X + dropdownWidth + spacing
    local col4X = col3X + dropdownWidth + spacing
    
    -- ROW 1: Search, Expansion, Vendor (compact spacing)
    local row1Y = -18  -- First row closer to top
    
    -- Search box (column 1) - Midnight theme styled
    local searchContainer = CreateFrame("Frame", nil, filterFrame, "BackdropTemplate")
    searchContainer:SetSize(dropdownWidth - 10, 24)
    searchContainer:SetPoint("TOPLEFT", col1X, row1Y)
    searchContainer:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    local bgTertiary = HousingTheme.Colors.bgTertiary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    searchContainer:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    searchContainer:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    local searchBox = CreateFrame("EditBox", "HousingSearchBox", searchContainer)
    searchBox:SetPoint("TOPLEFT", 8, -4)
    searchBox:SetPoint("BOTTOMRIGHT", -8, 4)
    searchBox:SetAutoFocus(false)
    searchBox:SetFontObject("GameFontNormalSmall")
    local textPrimary = HousingTheme.Colors.textPrimary
    searchBox:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    searchBox:SetScript("OnTextChanged", function(self)
        currentFilters.searchText = self:GetText()
        Filters:ApplyFilters()
    end)
    searchBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    
    local searchLabel = filterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    searchLabel:SetPoint("BOTTOMLEFT", searchContainer, "TOPLEFT", 2, 1)
    searchLabel:SetText("Search:")
    local accentPrimary = HousingTheme.Colors.accentPrimary
    searchLabel:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    searchContainer._hvLabelText = searchLabel
    
    -- Expansion scrollable button selector with MULTI-SELECT (column 2)
    local expansionBtn = self:CreateMultiSelectSelector(filterFrame, "Expansion", col2X, row1Y, function(selectedItems)
        -- Update the selectedExpansions table
        currentFilters.selectedExpansions = selectedItems
        
        -- For backward compatibility, set expansion to first selected or "All Expansions"
        local count = 0
        local firstSelected = nil
        for exp, _ in pairs(selectedItems) do
            count = count + 1
            if not firstSelected then
                firstSelected = exp
            end
        end
        
        if count == 0 then
            currentFilters.expansion = "All Expansions"
        elseif count == 1 then
            currentFilters.expansion = firstSelected
        else
            currentFilters.expansion = "Multiple"
        end
        
        self:ApplyFilters()
    end)
    self:AttachNotToggle(expansionBtn, "excludeExpansions")

    -- Vendor scrollable button selector (column 3)
    local vendorBtn = self:CreateScrollableSelector(filterFrame, "Vendor", col3X, row1Y, function(value)
        currentFilters.vendor = value
        self:ApplyFilters()
    end)
    
    -- ROW 2: Type, Source, Faction (compact spacing)
    local row2Y = -58  -- Second row

    -- Type scrollable button selector (column 1 - aligns with Search)
    local typeBtn = self:CreateScrollableSelector(filterFrame, "Type", col1X, row2Y, function(value)
        currentFilters.type = value
        self:ApplyFilters()
    end)

    -- Source scrollable button selector with MULTI-SELECT (column 2 - aligns with Expansion)
    local sourceBtn = self:CreateMultiSelectSelector(filterFrame, "Source", col2X, row2Y, function(selectedItems)
        -- Update the selectedSources table
        currentFilters.selectedSources = selectedItems
        
        -- For backward compatibility
        local count = 0
        local firstSelected = nil
        for src, _ in pairs(selectedItems) do
            count = count + 1
            if not firstSelected then
                firstSelected = src
            end
        end
        
        if count == 0 then
            currentFilters.source = "All Sources"
        elseif count == 1 then
            currentFilters.source = firstSelected
        else
            currentFilters.source = "Multiple"
        end
        
        self:ApplyFilters()
    end)
    self:AttachNotToggle(sourceBtn, "excludeSources")

    -- Faction scrollable button selector (column 3 - aligns with Vendor)
    local factionBtn = self:CreateScrollableSelector(filterFrame, "Faction", col3X, row2Y, function(value)
        currentFilters.faction = value
        self:ApplyFilters()
    end)

    -- ROW 3: Collection, Quality, Zone (compact spacing)
    local row3Y = -98  -- Third row

    -- Collection scrollable button selector (column 1)
    local collectionBtn = self:CreateScrollableSelector(filterFrame, "Collection", col1X, row3Y, function(value)
        currentFilters.collection = value

        -- Apply filter immediately - collection checks are fast due to caching in HousingCollectionAPI
        -- The IsItemCollected method uses persistent cache (HousingDB.collectedDecor) and session cache
        -- for instant lookups, falling back to API calls only for uncached items
        self:ApplyFilters()
    end)

    -- Quality scrollable button selector (column 2)
    local qualityBtn = self:CreateScrollableSelector(filterFrame, "Quality", col2X, row3Y, function(value)
        currentFilters.quality = value
        self:ApplyFilters()
    end)
    -- Hard-data-only mode: allow quality only if the DataManager supports API quality enrichment.
    if HousingDataManager and HousingDataManager.HARD_DATA_ONLY and not HousingDataManager.ALLOW_API_QUALITY then
        currentFilters.quality = "All Qualities"
        if qualityBtn and qualityBtn.button and qualityBtn.button.buttonText then
            qualityBtn.button.buttonText:SetText("All Qualities")
        end
        if qualityBtn and qualityBtn.button and qualityBtn.button.Disable then
            qualityBtn.button:Disable()
            qualityBtn.button:SetAlpha(0.65)
        end
    end

    -- Zone scrollable button selector (column 3 - under Faction)
    local zoneBtn = self:CreateScrollableSelector(filterFrame, "Zone", col3X, row3Y, function(value)
        currentFilters.zone = value
        currentFilters.zoneMapID = nil
        -- Treat a manual zone selection as user intent; don't auto-override on zone events.
        currentFilters._userSetZone = value ~= "All Zones"
        self:ShowAutoFilterIndicator(nil)
        self:ApplyFilters()
    end)

    filterFrame._hvControls.searchContainer = searchContainer
    filterFrame._hvControls.expansion = expansionBtn
    filterFrame._hvControls.vendor = vendorBtn
    filterFrame._hvControls.zone = zoneBtn
    filterFrame._hvControls.type = typeBtn
    filterFrame._hvControls.source = sourceBtn
    filterFrame._hvControls.faction = factionBtn
    filterFrame._hvControls.collection = collectionBtn
    filterFrame._hvControls.quality = qualityBtn

    -- Note: "Hide Visited Vendors" moved to Settings UI
    -- Note: "Only Show Live Items" removed from UI - now controlled by /hv showall command
    -- Default behavior: Only show live items (showOnlyAvailable = true)

    -- Navigation buttons in 2x2 grid on right side of filter area (anchored to filterFrame)
    local navBtnWidth = 105
    local navBtnHeight = 28
    local navBtnSpacing = 8
    -- Position on right side of filter frame with equal spacing as between dropdowns
    local navGridX = col3X + dropdownWidth + spacing  -- Use same spacing as between dropdowns (20px)
    local navRow1Y = row1Y
    local navRow2Y = row2Y

    -- Helper function to create navigation button (on filterFrame)
    local function CreateNavButton(parent, label, xPos, yPos, onClick)
        local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
        btn:SetSize(navBtnWidth, navBtnHeight)
        btn:SetPoint("TOPLEFT", xPos, yPos)

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

        local btnText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        btnText:SetPoint("CENTER")
        btnText:SetText(label)
        btnText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        btn.label = btnText

        local bgHover = HousingTheme.Colors.bgHover
        local accentPrimary = HousingTheme.Colors.accentPrimary
        local textHighlight = HousingTheme.Colors.textHighlight

        btn:SetScript("OnEnter", function(self)
            self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
            self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
            self.label:SetTextColor(textHighlight[1], textHighlight[2], textHighlight[3], 1)

            -- Show tooltip
            if self.tooltipText then
                GameTooltip:SetOwner(self, "ANCHOR_TOP")
                GameTooltip:SetText(self.tooltipText, 1, 1, 1, 1, true)
                GameTooltip:Show()
            end
        end)

        btn:SetScript("OnLeave", function(self)
            self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
            self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
            self.label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

            -- Hide tooltip
            GameTooltip:Hide()
        end)

        btn:SetScript("OnClick", onClick)

        return btn
    end

    -- Create navigation buttons in 2x2 grid (on filterFrame)
    -- Row 1: Achievements, Reputation
    local achBtn = CreateNavButton(filterFrame, "Achievements", navGridX, navRow1Y, function()
        if HousingAchievementsUI then
            -- Toggle: if already showing, hide and return to main UI
            if HousingAchievementsUI._achievementsContainer and HousingAchievementsUI._achievementsContainer:IsShown() then
                HousingAchievementsUI:Hide()
            else
                HousingAchievementsUI:Show()
            end
        end
    end)
    achBtn.tooltipText = L["TOOLTIP_ACHIEVEMENTS"] or "View housing-related achievements\nand track your progress"

    local repBtn = CreateNavButton(filterFrame, "Reputation", navGridX + navBtnWidth + navBtnSpacing, navRow1Y, function()
        if HousingReputationUI then
            -- Toggle: if already showing, hide and return to main UI
            if HousingReputationUI._reputationContainer and HousingReputationUI._reputationContainer:IsShown() then
                HousingReputationUI:Hide()
            else
                HousingReputationUI:Show()
            end
        end
    end)
    repBtn.tooltipText = L["TOOLTIP_REPUTATION"] or "Track reputation requirements\nacross all your characters"

    -- Row 2: Statistics, Auction House
    local statsBtn = CreateNavButton(filterFrame, "Statistics", navGridX, navRow2Y, function()
        if HousingStatisticsUI then
            -- Toggle: if already showing, hide and return to main UI
            if HousingStatisticsUI._statsContainer and HousingStatisticsUI._statsContainer:IsShown() then
                HousingStatisticsUI:Hide()
            else
                HousingStatisticsUI:Show()
            end
        end
    end)
    statsBtn.tooltipText = L["TOOLTIP_STATISTICS"] or "View collection statistics\nand progress charts"

    local ahBtn = CreateNavButton(filterFrame, L["AUCTION_HOUSE_TITLE"] or "Auction House", navGridX + navBtnWidth + navBtnSpacing, navRow2Y, function()
        if HousingAuctionHouseUI then
            if HousingAuctionHouseUI._container and HousingAuctionHouseUI._container:IsShown() then
                HousingAuctionHouseUI:Hide()
            else
                HousingAuctionHouseUI:Show()
            end
        end
    end)
    ahBtn.tooltipText = L["TOOLTIP_AUCTION_HOUSE"] or "View auction prices\nand scan for updates"

    -- Row 3: Endeavors, Plan
    local endeavorsBtn = CreateNavButton(filterFrame, "Endeavors", navGridX, row3Y, function()
        if HousingEndeavorsUI then
            if HousingEndeavorsUI._container and HousingEndeavorsUI._container:IsShown() then
                HousingEndeavorsUI:Hide()
            else
                HousingEndeavorsUI:Show()
            end
        end
    end)
    endeavorsBtn.tooltipText = L["TOOLTIP_ENDEAVORS"] or "Track Housing Endeavors\nand view current tasks and progress"

    local planBtn = CreateNavButton(filterFrame, "Plan", navGridX + navBtnWidth + navBtnSpacing, row3Y, function()
        if _G.HousingPlanUI and _G.HousingPlanUI.Toggle then
            _G.HousingPlanUI:Toggle()
        end
    end)
    planBtn.tooltipText = L["TOOLTIP_PLAN"] or "View and manage your shopping list"

    -- Expose nav buttons for layout/visibility toggles.
    -- NOTE: this is separate from the Zone filter dropdown.
    filterFrame.navButtons = { achBtn, repBtn, statsBtn, ahBtn, endeavorsBtn, planBtn }
    _G["HousingNavButtons"] = filterFrame.navButtons

    achBtn._hvNavOrigin = { parent = filterFrame, x = navGridX, y = navRow1Y }
    repBtn._hvNavOrigin = { parent = filterFrame, x = navGridX + navBtnWidth + navBtnSpacing, y = navRow1Y }
    statsBtn._hvNavOrigin = { parent = filterFrame, x = navGridX, y = navRow2Y }
    ahBtn._hvNavOrigin = { parent = filterFrame, x = navGridX + navBtnWidth + navBtnSpacing, y = navRow2Y }
    endeavorsBtn._hvNavOrigin = { parent = filterFrame, x = navGridX, y = row3Y }
    planBtn._hvNavOrigin = { parent = filterFrame, x = navGridX + navBtnWidth + navBtnSpacing, y = row3Y }

    -- Back button (Midnight theme styled, hidden by default)
    local backBtn = CreateFrame("Button", "HousingBackButton", filterFrame, "BackdropTemplate")
    backBtn:SetSize(80, 24)
    backBtn:SetPoint("TOPRIGHT", -130, -18)
    backBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    backBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    backBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    local backBtnText = backBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    backBtnText:SetPoint("CENTER")
    backBtnText:SetText(L["BUTTON_BACK"] or "Back")
    local textPrimary = HousingTheme.Colors.textPrimary
    backBtnText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    backBtn.label = backBtnText
    
    local bgHover = HousingTheme.Colors.bgHover
    local accentPrimary = HousingTheme.Colors.accentPrimary
    local textHighlight = HousingTheme.Colors.textHighlight
    
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
    backBtn:Hide()
    backBtn:SetScript("OnClick", function()
        if HousingUINew and HousingDB and HousingDB.settings and HousingDB.settings.displayMode then
            HousingUINew:RefreshDisplay(HousingDB.settings.displayMode)
            backBtn:Hide()
        end
    end)
    _G["HousingBackButton"] = backBtn

    -- Clear Filters button - placed below filters, above item list (right side)
    local clearBtn = CreateFrame("Button", nil, filterFrame, "BackdropTemplate")
    clearBtn:SetSize(75, 19)
    -- Align with the item list area (avoid overlapping the preview/info panel on the far right).
    -- Item list uses a -370 right offset; filter frame right edge is at -2, so shift left ~368px.
    clearBtn:SetPoint("BOTTOMRIGHT", filterFrame, "BOTTOMRIGHT", -401, -22)
    clearBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    clearBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    clearBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    local clearBtnText = clearBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    clearBtnText:SetPoint("CENTER")
    clearBtnText:SetText(L["FILTER_CLEAR"] or "Clear Filters")
    -- Red tint for clear action
    clearBtnText:SetTextColor(0.95, 0.45, 0.45, 1)  -- Red tint
    clearBtn.label = clearBtnText
    
    local statusError = HousingTheme.Colors.statusError or { 1, 0.3, 0.3, 1 }
    clearBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(statusError[1], statusError[2], statusError[3], 1)  -- Red border on hover
        self.label:SetTextColor(1, 0.5, 0.5, 1)  -- Brighter red on hover
    end)
    clearBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
        self.label:SetTextColor(0.95, 0.45, 0.45, 1)  -- Back to red tint
    end)
    clearBtn:SetScript("OnClick", function()
        self:ClearAllFilters()
    end)
    filterFrame._hvClearBtn = clearBtn
    clearBtn._hvOrigin = { parent = filterFrame, point = "BOTTOMRIGHT", relPoint = "BOTTOMRIGHT", x = -380, y = -18 }

    _G["HousingFilterFrame"] = filterFrame
end

function Filters:SetSimpleMode(enabled)
    if not filterFrame or not filterFrame._hvControls then
        return
    end

    local simple = enabled == true

    -- Move nav buttons to the top row in simple mode.
    if filterFrame.navButtons then
        if simple then
            local anchor = filterFrame

            -- Order right-to-left.
            local order = {
                filterFrame.navButtons[6], -- Plan
                filterFrame.navButtons[5], -- Endeavors
                filterFrame.navButtons[4], -- Auction House
                filterFrame.navButtons[3], -- Statistics
                filterFrame.navButtons[2], -- Reputation
                filterFrame.navButtons[1], -- Achievements
            }

            local prev = nil
            for _, btn in ipairs(order) do
                if btn and btn.SetShown then
                    btn:SetShown(true)
                    btn:ClearAllPoints()
                    if prev then
                        btn:SetPoint("RIGHT", prev, "LEFT", -10, 0)
                    else
                        btn:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", -10, -10)
                    end
                    prev = btn
                end
            end
        else
            for _, btn in ipairs(filterFrame.navButtons) do
                if btn and btn._hvNavOrigin and btn.SetShown then
                    btn:SetShown(true)
                    btn:ClearAllPoints()
                    btn:SetPoint("TOPLEFT", btn._hvNavOrigin.parent, "TOPLEFT", btn._hvNavOrigin.x, btn._hvNavOrigin.y)
                end
            end
        end
    end

    if _G["HousingBackButton"] and _G["HousingBackButton"].SetShown then
        _G["HousingBackButton"]:SetShown(not simple)
    end

    local c = filterFrame._hvControls
    local show = {
        searchContainer = true,
        expansion = true,
        source = true,
        zone = true,
    }

    for key, frame in pairs(c) do
        if frame and frame.SetShown then
            local shouldShow = (not simple) or (show[key] == true)
            frame:SetShown(shouldShow)
        end
    end

    -- Compact single-row layout in simple mode.
    if simple then
        filterFrame:SetHeight(92)

        local leftMargin = 15
        local dropdownWidth = 200
        local spacing = 20
        local rowY = -52

        -- Nav buttons into a top row so they don't overlap the dropdowns.

        if c.searchContainer then
            c.searchContainer:ClearAllPoints()
            c.searchContainer:SetPoint("TOPLEFT", leftMargin, rowY)
        end
        if c.expansion then
            c.expansion:ClearAllPoints()
            c.expansion:SetPoint("TOPLEFT", leftMargin + (dropdownWidth + spacing), rowY)
        end
        if c.source then
            c.source:ClearAllPoints()
            c.source:SetPoint("TOPLEFT", leftMargin + (dropdownWidth + spacing) * 2, rowY)
        end
        if c.zone then
            c.zone:ClearAllPoints()
            c.zone:SetPoint("TOPLEFT", leftMargin + (dropdownWidth + spacing) * 3, rowY)
        end

        if filterFrame.navButtons then
            local prev = nil
            local order = {
                filterFrame.navButtons[6], -- Plan
                filterFrame.navButtons[5], -- Endeavors
                filterFrame.navButtons[4], -- Auction House
                filterFrame.navButtons[3], -- Statistics
                filterFrame.navButtons[2], -- Reputation
                filterFrame.navButtons[1], -- Achievements
            }
            for _, btn in ipairs(order) do
                if btn and btn.SetShown then
                    btn:SetShown(true)
                    btn:ClearAllPoints()
                    if prev then
                        btn:SetPoint("RIGHT", prev, "LEFT", -10, 0)
                    else
                        btn:SetPoint("TOPRIGHT", filterFrame, "TOPRIGHT", -10, -10)
                    end
                    prev = btn
                end
            end
        end

        -- Hide the small labels above controls to keep the bar tight.
        if c.searchContainer and c.searchContainer._hvLabelText then
            c.searchContainer._hvLabelText:Hide()
        end
        if c.expansion and c.expansion.labelText then
            c.expansion.labelText:Hide()
        end
        if c.source and c.source.labelText then
            c.source.labelText:Hide()
        end
        if c.zone and c.zone.labelText then
            c.zone.labelText:Hide()
        end
    else
        filterFrame:SetHeight(130)

        -- Restore Clear Filters original position.
        local clearBtn = filterFrame._hvClearBtn
        if clearBtn and clearBtn._hvOrigin and clearBtn.SetPoint then
            clearBtn:ClearAllPoints()
            clearBtn:SetPoint(clearBtn._hvOrigin.point, clearBtn._hvOrigin.parent, clearBtn._hvOrigin.relPoint, clearBtn._hvOrigin.x, clearBtn._hvOrigin.y)
        end

        -- Restore labels if present.
        if c.searchContainer and c.searchContainer._hvLabelText then
            c.searchContainer._hvLabelText:Show()
        end
        if c.expansion and c.expansion.labelText then
            c.expansion.labelText:Show()
        end
        if c.source and c.source.labelText then
            c.source.labelText:Show()
        end
        if c.zone and c.zone.labelText then
            c.zone.labelText:Show()
        end

        -- Re-anchor back to original grid positions (rebuild by re-running CreateFilterSection is too heavy).
        local dropdownWidth = 200
        local spacing = 20
        local leftMargin = 15
        local col1X = leftMargin
        local col2X = col1X + dropdownWidth + spacing
        local col3X = col2X + dropdownWidth + spacing
        local col4X = col3X + dropdownWidth + spacing
        local row1Y = -18
        local row2Y = -58
        local row3Y = -98

        if c.searchContainer then
            c.searchContainer:ClearAllPoints()
            c.searchContainer:SetPoint("TOPLEFT", col1X, row1Y)
        end
        if c.expansion then
            c.expansion:ClearAllPoints()
            c.expansion:SetPoint("TOPLEFT", filterFrame, "TOPLEFT", col2X, row1Y)
        end
        if c.vendor then
            c.vendor:ClearAllPoints()
            c.vendor:SetPoint("TOPLEFT", filterFrame, "TOPLEFT", col3X, row1Y)
        end
        if c.zone then
            c.zone:ClearAllPoints()
            c.zone:SetPoint("TOPLEFT", filterFrame, "TOPLEFT", col4X, row1Y)
        end
        if c.type then
            c.type:ClearAllPoints()
            c.type:SetPoint("TOPLEFT", filterFrame, "TOPLEFT", col1X, row2Y)
        end
        if c.source then
            c.source:ClearAllPoints()
            c.source:SetPoint("TOPLEFT", filterFrame, "TOPLEFT", col2X, row2Y)
        end
        if c.faction then
            c.faction:ClearAllPoints()
            c.faction:SetPoint("TOPLEFT", filterFrame, "TOPLEFT", col3X, row2Y)
        end
        if c.collection then
            c.collection:ClearAllPoints()
            c.collection:SetPoint("TOPLEFT", filterFrame, "TOPLEFT", col1X, row3Y)
        end
        if c.quality then
            c.quality:ClearAllPoints()
            c.quality:SetPoint("TOPLEFT", filterFrame, "TOPLEFT", col2X, row3Y)
        end
        if c.requirement then
            c.requirement:ClearAllPoints()
            c.requirement:SetPoint("TOPLEFT", filterFrame, "TOPLEFT", col3X, row3Y)
        end
    end
end

-- Create a scrollable selector (Midnight Theme)
function Filters:CreateScrollableSelector(parent, label, xOffset, yOffset, onChange)
    local theme = GetTheme()
    local colors = theme.Colors or {}
    
    local container = CreateFrame("Frame", "Housing" .. label .. "Container", parent)
    container:SetSize(190, 30)
    container:SetPoint("TOPLEFT", parent, "TOPLEFT", xOffset, yOffset)

    -- Label (Midnight theme)
    local labelText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    labelText:SetPoint("BOTTOMLEFT", container, "TOPLEFT", 2, 1)
    labelText:SetText(label .. ":")
    local accentPrimary = HousingTheme.Colors.accentPrimary
    labelText:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    container.labelText = labelText

    -- Button (Midnight theme styled)
    local button = CreateFrame("Button", "Housing" .. label .. "Button", container, "BackdropTemplate")
    button:SetSize(190, 24)
    button:SetPoint("TOPLEFT", 0, 0)
    
    -- Button backdrop
    button:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    local bgTertiary = HousingTheme.Colors.bgTertiary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    button:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    button:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    -- Button text
    local buttonText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    buttonText:SetPoint("LEFT", 8, 0)
    buttonText:SetPoint("RIGHT", -20, 0)
    buttonText:SetJustifyH("LEFT")
    local textPrimary = HousingTheme.Colors.textPrimary
    buttonText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    button.buttonText = buttonText
    
    -- Dropdown arrow
    local arrow = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arrow:SetPoint("RIGHT", -6, 0)
    arrow:SetText("v")
    local textMuted = HousingTheme.Colors.textMuted
    arrow:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)

    -- Set initial button text based on filter type
    local defaultText = "All " .. label .. "s"
    if label == "Expansion" then
        defaultText = "All Expansions"
    elseif label == "Faction" then
        defaultText = (FilterModel and FilterModel.GetDefaultFaction and FilterModel:GetDefaultFaction()) or "All Factions"
    elseif label == "Source" then
        defaultText = "All Sources"
    elseif label == "Collection" then
        defaultText = "All"
    elseif label == "Quality" then
        defaultText = "All Qualities"
    elseif label == "Requirement" then
        defaultText = "All Requirements"
    end
    buttonText:SetText(defaultText)
    
    -- Hover effects
    local bgHover = HousingTheme.Colors.bgHover
    button:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    button:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    end)

    -- Scrollable list frame (Midnight theme)
    local listFrame = CreateFrame("Frame", "Housing" .. label .. "ListFrame", UIParent, "BackdropTemplate")
    listFrame:SetSize(300, 350)
    listFrame:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -2)
    listFrame:SetFrameStrata("DIALOG")
    if HousingDB and HousingDB.uiScale then
        listFrame:SetScale(HousingDB.uiScale)
    end
    listFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    local bgPrimary = HousingTheme.Colors.bgPrimary
    listFrame:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], 0.98)
    listFrame:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.8)
    listFrame:Hide()
    listFrame:EnableMouse(true)

    -- Search box in list frame (Midnight theme)
    local searchContainer = CreateFrame("Frame", nil, listFrame, "BackdropTemplate")
    searchContainer:SetSize(270, 24)
    searchContainer:SetPoint("TOPLEFT", 15, -12)
    searchContainer:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    searchContainer:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.8)
    searchContainer:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.6)
    
    local searchBox = CreateFrame("EditBox", nil, searchContainer)
    searchBox:SetPoint("TOPLEFT", 8, -4)
    searchBox:SetPoint("BOTTOMRIGHT", -8, 4)
    searchBox:SetAutoFocus(false)
    searchBox:SetFontObject("GameFontNormalSmall")
    searchBox:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    searchBox:SetScript("OnEscapePressed", function(editBox)
        editBox:ClearFocus()
        listFrame:Hide()
    end)

    local searchLabel = listFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    searchLabel:SetPoint("BOTTOMLEFT", searchContainer, "TOPLEFT", 0, 2)
    searchLabel:SetText("Search:")
    searchLabel:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)

    -- Scroll frame
    local scrollFrame = CreateFrame("ScrollFrame", nil, listFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 10, -40)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)

    -- Content frame for scroll
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(310, 1)
    scrollFrame:SetScrollChild(content)

    -- Store for option buttons
    local optionButtons = {}

    -- Function to populate list
    local function PopulateList(filterText)
        -- Clear existing buttons
        for _, btn in ipairs(optionButtons) do
            btn:Hide()
            btn:SetParent(nil)
        end
        wipe(optionButtons)

        -- Get options
        local options = {}
        if label == "Collection" then
            -- Collection has fixed options
            options = {"Collected", "Uncollected"}
        elseif label == "Quality" then
            -- Quality requires API enrichment; allow it only if enabled.
            if HousingDataManager and HousingDataManager.HARD_DATA_ONLY and not HousingDataManager.ALLOW_API_QUALITY then
                options = {}
            else
                options = {"Poor", "Common", "Uncommon", "Rare", "Epic", "Legendary"}
            end
        elseif label == "Requirement" then
            -- Requirement has fixed options
            -- Note: Event, Race commented out - no housing items have these requirements
            options = {"None", "Vendor", "Achievement", "Quest", "Reputation", "Renown", "Profession", "Class"}
        elseif HousingDataManager then
            local filterOptions = HousingDataManager:GetFilterOptions()
            if filterOptions then
                if label == "Expansion" then
                    options = filterOptions.expansions or {}
                elseif label == "Vendor" then
                    options = filterOptions.vendors or {}
                elseif label == "Zone" then
                    options = filterOptions.zones or {}
                elseif label == "Type" then
                    options = filterOptions.types or {}
                elseif label == "Category" then
                    options = filterOptions.categories or {}
                elseif label == "Faction" then
                    options = filterOptions.factions or {}
                elseif label == "Source" then
                    options = filterOptions.sources or {}
                end
            end
        end

        -- Add "All" option with proper pluralization
        local allText = "All"
        if label == "Expansion" then
            allText = "All Expansions"
        elseif label == "Faction" then
            allText = "All Factions"
        elseif label == "Source" then
            allText = "All Sources"
        elseif label == "Collection" then
            allText = "All"
        elseif label == "Quality" then
            allText = "All Qualities"
        elseif label == "Requirement" then
            allText = "All Requirements"
        else
            allText = "All " .. label .. "s"
        end
        local filteredOptions = {allText}

        -- Filter options by search text
        local lowerFilter = string.lower(filterText or "")
        for _, option in ipairs(options) do
            if lowerFilter == "" or string.find(string.lower(option), lowerFilter, 1, true) then
                table.insert(filteredOptions, option)
            end
        end

        -- Create buttons
        local yOffset = 0
        for _, option in ipairs(filteredOptions) do
            local btn = CreateFrame("Button", nil, content)
            btn:SetSize(310, 24)
            btn:SetPoint("TOPLEFT", 0, yOffset)

            -- Background
            local bg = btn:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetColorTexture(0.1, 0.1, 0.1, 0.5)
            btn.bg = bg

            -- Text
            local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            text:SetPoint("LEFT", 5, 0)
            text:SetText(option)
            text:SetJustifyH("LEFT")
            btn.text = text

            -- Highlight
            btn:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")

            -- Click handler
            btn:SetScript("OnClick", function()
                -- Hide first so the click-catcher doesn't get stuck if filtering throws.
                if listFrame and listFrame.Hide then
                    listFrame:Hide()
                end

                local ok, err = pcall(function()
                    local filterKey = string.lower(label)
                    currentFilters[filterKey] = option
                    if button.buttonText then
                        button.buttonText:SetText(option)
                    end
                    if onChange then
                        onChange(option)
                    end
                    if searchBox then
                        searchBox:SetText("")
                    end
                end)

                if not ok then
                    print("|cFFFF0000HousingVendor:|r Filter error: " .. tostring(err))
                end
            end)

            -- Highlight current selection
            local filterKey = string.lower(label)
            if currentFilters[filterKey] == option then
                bg:SetColorTexture(0.2, 0.5, 0.2, 0.5)
            end

            table.insert(optionButtons, btn)
            yOffset = yOffset - 24
        end

        -- Update content height
        content:SetHeight(math.max(1, #filteredOptions * 24))
    end

    -- Search box text changed
    searchBox:SetScript("OnTextChanged", function(editBox)
        PopulateList(editBox:GetText())
    end)

    -- Button click to show/hide list
    button:SetScript("OnClick", function()
        if listFrame:IsShown() then
            listFrame:Hide()
        else
            PopulateList("")
            listFrame:Show()
            searchBox:SetFocus()
        end
    end)

    -- Close when clicking outside (avoid per-frame OnUpdate polling)
    local clickCatcher = CreateFrame("Button", nil, UIParent)
    clickCatcher:SetAllPoints(UIParent)
    clickCatcher:EnableMouse(true)
    clickCatcher:Hide()
    clickCatcher:SetScript("OnClick", function()
        listFrame:Hide()
    end)

    listFrame:SetScript("OnShow", function()
        clickCatcher:SetFrameStrata(listFrame:GetFrameStrata() or "DIALOG")
        clickCatcher:SetFrameLevel(math.max(0, (listFrame:GetFrameLevel() or 1) - 1))
        clickCatcher:Show()
    end)

    listFrame:SetScript("OnHide", function()
        searchBox:SetText("")
        searchBox:ClearFocus()
        clickCatcher:Hide()
    end)

    table_insert(popupRegistry, { listFrame = listFrame, clickCatcher = clickCatcher })

    -- Store references
    container.button = button
    container.listFrame = listFrame
    container.label = label

    return container
end

-- Create a multi-select selector with highlight-based selection (for Expansion, Category, Source filters)
function Filters:CreateMultiSelectSelector(parent, label, xOffset, yOffset, onChange)
    local theme = GetTheme()
    local colors = theme.Colors or {}

    local container = CreateFrame("Frame", "Housing" .. label .. "Container", parent)
    container:SetSize(190, 30)
    container:SetPoint("TOPLEFT", parent, "TOPLEFT", xOffset, yOffset)

    -- Label (Midnight theme)
    local labelText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    labelText:SetPoint("BOTTOMLEFT", container, "TOPLEFT", 2, 1)
    labelText:SetText(label .. ":")
    local accentPrimary = HousingTheme.Colors.accentPrimary
    labelText:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    container.labelText = labelText

    -- Button (Midnight theme styled)
    local button = CreateFrame("Button", "Housing" .. label .. "Button", container, "BackdropTemplate")
    button:SetSize(190, 24)
    button:SetPoint("TOPLEFT", 0, 0)

    -- Button backdrop
    button:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })

    local bgTertiary = HousingTheme.Colors.bgTertiary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    button:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    button:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])

    -- Button text
    local buttonText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    buttonText:SetPoint("LEFT", 8, 0)
    buttonText:SetPoint("RIGHT", -20, 0)
    buttonText:SetJustifyH("LEFT")
    local textPrimary = HousingTheme.Colors.textPrimary
    buttonText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    -- Set default text based on label
    local defaultText = "All " .. label .. "s"
    if label == "Expansion" then
        defaultText = "All Expansions"
    elseif label == "Source" then
        defaultText = "All Sources"
    elseif label == "Category" then
        defaultText = "All Categories"
    end
    buttonText:SetText(defaultText)
    button.buttonText = buttonText

    -- Dropdown arrow
    local arrow = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arrow:SetPoint("RIGHT", -6, 0)
    arrow:SetText("v")
    local textMuted = HousingTheme.Colors.textMuted
    arrow:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)

    -- Hover effects
    local bgHover = HousingTheme.Colors.bgHover
    button:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    button:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    end)

    -- Scrollable list frame (Midnight theme)
    local listFrame = CreateFrame("Frame", "Housing" .. label .. "ListFrame", UIParent, "BackdropTemplate")
    listFrame:SetSize(300, 350)
    listFrame:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -2)
    listFrame:SetFrameStrata("DIALOG")
    listFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })

    local bgPrimary = HousingTheme.Colors.bgPrimary
    listFrame:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], 0.98)
    listFrame:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.8)
    listFrame:Hide()
    listFrame:EnableMouse(true)

    -- Scroll frame
    local scrollFrame = CreateFrame("ScrollFrame", nil, listFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 10, -40)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 50)

    -- Content frame for scroll
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(260, 1)
    scrollFrame:SetScrollChild(content)

    -- Store for option buttons and selected items
    local optionButtons = {}
    local selectedItems = {} -- {["Dragonflight"] = true, ["War Within"] = true}

    -- Function to update button text based on selections
    local function UpdateButtonText()
        local count = 0
        for _ in pairs(selectedItems) do
            count = count + 1
        end

        if count == 0 then
            buttonText:SetText(defaultText)
        elseif count == 1 then
            -- Show the single selected item
            for item, _ in pairs(selectedItems) do
                buttonText:SetText(item)
                break
            end
        else
            -- Show count
            buttonText:SetText(count .. " selected")
        end
    end

    -- Function to populate list with clickable options
    local function PopulateList()
        -- Clear existing buttons
        for _, btn in ipairs(optionButtons) do
            btn:Hide()
            btn:SetParent(nil)
        end
        wipe(optionButtons)

        -- Get options based on label
        local options = {}
        if HousingDataManager then
            local filterOptions = HousingDataManager:GetFilterOptions()
            if filterOptions then
                if label == "Expansion" then
                    options = filterOptions.expansions or {}
                elseif label == "Source" then
                    options = filterOptions.sources or {}
                elseif label == "Category" then
                    options = filterOptions.categories or {}
                end
            end
        end

        -- Create buttons for each option
        local yOffset = 0
        for _, option in ipairs(options) do
            local btn = CreateFrame("Button", nil, content)
            btn:SetSize(260, 24)
            btn:SetPoint("TOPLEFT", 0, yOffset)

            -- Background
            local bg = btn:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetColorTexture(0.1, 0.1, 0.1, 0.5)
            btn.bg = bg

            -- Text
            local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            text:SetPoint("LEFT", 5, 0)
            text:SetText(option)
            text:SetJustifyH("LEFT")
            text:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
            btn.text = text

            -- Highlight on hover
            btn:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")

            -- Click handler - toggle selection
            btn:SetScript("OnClick", function(self)
                -- Toggle selection
                if selectedItems[option] then
                    selectedItems[option] = nil
                    bg:SetColorTexture(0.1, 0.1, 0.1, 0.5)
                else
                    selectedItems[option] = true
                    bg:SetColorTexture(0.3, 0.5, 0.3, 0.6)
                end

                UpdateButtonText()

                -- Trigger onChange callback
                if onChange then
                    local ok, err = pcall(onChange, selectedItems)
                    if not ok then
                        print("|cFFFF0000HousingVendor:|r Filter error: " .. tostring(err))
                    end
                end
            end)

            -- Set initial state
            if selectedItems[option] then
                bg:SetColorTexture(0.3, 0.5, 0.3, 0.6)
            end

            table.insert(optionButtons, btn)
            yOffset = yOffset - 24
        end

        -- Update content height
        content:SetHeight(math.max(1, #options * 24))
    end

    -- Button click to show/hide list
    button:SetScript("OnClick", function()
        if listFrame:IsShown() then
            listFrame:Hide()
        else
            PopulateList()
            listFrame:Show()
        end
    end)

    -- Done button at bottom of list
    local doneButton = CreateFrame("Button", nil, listFrame, "BackdropTemplate")
    doneButton:SetSize(100, 30)
    doneButton:SetPoint("BOTTOM", 0, 10)
    doneButton:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    doneButton:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    doneButton:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])

    local doneText = doneButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    doneText:SetPoint("CENTER")
    doneText:SetText("Done")
    doneText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    doneButton.label = doneText

    doneButton:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
        self.label:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    doneButton:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
        self.label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    end)
    doneButton:SetScript("OnClick", function()
        listFrame:Hide()
    end)

    -- Close when clicking outside (avoid per-frame OnUpdate polling)
    local clickCatcher = CreateFrame("Button", nil, UIParent)
    clickCatcher:SetAllPoints(UIParent)
    clickCatcher:EnableMouse(true)
    clickCatcher:Hide()
    clickCatcher:SetScript("OnClick", function()
        listFrame:Hide()
    end)

    listFrame:SetScript("OnShow", function()
        clickCatcher:SetFrameStrata(listFrame:GetFrameStrata() or "DIALOG")
        clickCatcher:SetFrameLevel(math.max(0, (listFrame:GetFrameLevel() or 1) - 1))
        clickCatcher:Show()
    end)

    listFrame:SetScript("OnHide", function()
        clickCatcher:Hide()
    end)

    table_insert(popupRegistry, { listFrame = listFrame, clickCatcher = clickCatcher })

    -- Store references
    container.button = button
    container.listFrame = listFrame
    container.label = label
    container.labelText = labelText
    container.selectedItems = selectedItems
    container.UpdateButtonText = UpdateButtonText

    return container
end

function Filters:AttachNotToggle(container, excludeFlagKey)
    if not container or not excludeFlagKey then
        return
    end

    local label = container.label or ""
    if label ~= "Expansion" and label ~= "Source" then
        return
    end

    local theme = GetTheme()
    local colors = theme.Colors or HousingTheme.Colors
    local accentPrimary = colors.accentPrimary
    local bgTertiary = colors.bgTertiary
    local borderPrimary = colors.borderPrimary
    local textPrimary = colors.textPrimary
    local bgHover = colors.bgHover

    local name = "Housing" .. label .. "NotToggle"
    local toggle = CreateFrame("Button", name, container, "BackdropTemplate")
    toggle:SetSize(32, 14)
    toggle:SetPoint("BOTTOMRIGHT", container, "TOPRIGHT", 0, 2)
    toggle:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })

    local txt = toggle:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    txt:SetPoint("CENTER", 0, 0)
    txt:SetText("NOT")
    txt:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    toggle.text = txt

    local function SetActive(active)
        if active then
            toggle:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
            toggle:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
            if container.labelText then
                container.labelText:SetText(label .. " (NOT):")
            end
        else
            toggle:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
            toggle:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
            if container.labelText then
                container.labelText:SetText(label .. ":")
            end
        end
    end

    toggle:SetScript("OnEnter", function()
        toggle:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        toggle:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)

    toggle:SetScript("OnLeave", function()
        SetActive(currentFilters[excludeFlagKey] == true)
    end)

    toggle:SetScript("OnClick", function()
        currentFilters[excludeFlagKey] = not (currentFilters[excludeFlagKey] == true)
        SetActive(currentFilters[excludeFlagKey] == true)
        self:ApplyFilters()
    end)

    container.notToggle = toggle
    container.notToggle.SetActive = SetActive
    SetActive(currentFilters[excludeFlagKey] == true)
end

-- Apply filters and update item list
function Filters:ApplyFilters()
    if HousingItemList and HousingDataManager then
        local ok, err = pcall(function()
            local allItems = HousingDataManager.GetAllItemIDs and HousingDataManager:GetAllItemIDs() or HousingDataManager:GetAllItems()
            HousingItemList:UpdateItems(allItems, currentFilters)
        end)

        if not ok then
            print("|cFFFF0000HousingVendor:|r Filter error: " .. tostring(err))
        end

        -- Keep preview panel visible when filters change (don't hide it)
        -- The preview panel will update if the selected item is still in the filtered list
    else
        print("|cFFFF0000HousingVendor:|r Filter error - HousingItemList or HousingDataManager not available")
    end
end

-- Get current filters
function Filters:GetFilters()
    return currentFilters
end

-- Set zone filter programmatically (for auto-filter feature)
function Filters:SetZoneFilter(zoneName, mapID)
    if not zoneName then return end

    -- When auto-filtering by zone, respect manual user zone selections.
    -- Auto-filter calls pass `mapID`; if the user manually set a zone, don't override.
    if mapID and currentFilters._userSetZone then
        return
    end

    currentFilters.zone = zoneName
    -- Store mapID for language-independent zone filtering
    currentFilters.zoneMapID = mapID
    currentFilters._userSetZone = false

    -- Update zone button text
    local zoneBtn = _G["HousingZoneButton"]
    if zoneBtn then
        if zoneBtn.buttonText then
            zoneBtn.buttonText:SetText(zoneName)
        elseif zoneBtn.SetText then
            zoneBtn:SetText(zoneName)
        end
    end

    -- Show auto-filter indicator
    self:ShowAutoFilterIndicator(zoneName)

    -- Apply filters
    self:ApplyFilters()
end

-- Toggle "Show Only Available" filter (for /hv showall command)
function Filters:ToggleShowAll()
    currentFilters.showOnlyAvailable = not currentFilters.showOnlyAvailable
    self:ApplyFilters()
    return currentFilters.showOnlyAvailable
end

-- Show/hide auto-filter indicator
function Filters:ShowAutoFilterIndicator(zoneName)
    if not filterFrame then return end
    
    -- Create indicator if it doesn't exist
    if not filterFrame.autoFilterIndicator then
        local indicator = filterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        -- Position between filter frame and item list (below filters, above list)
        indicator:SetPoint("BOTTOMLEFT", filterFrame, "BOTTOMLEFT", 15, -18)
        indicator:SetTextColor(HousingTheme.Colors.accentPrimary[1], HousingTheme.Colors.accentPrimary[2], HousingTheme.Colors.accentPrimary[3], 1)
        filterFrame.autoFilterIndicator = indicator
    end
    
    if zoneName and zoneName ~= "All Zones" then
        filterFrame.autoFilterIndicator:SetText(string.format("|cFF8A7FD4Auto-filtered to:|r %s", zoneName))
        filterFrame.autoFilterIndicator:Show()
    else
        filterFrame.autoFilterIndicator:Hide()
    end
end

-- Clear all filters
function Filters:ClearAllFilters()
    if FilterModel and FilterModel.ResetToDefaults then
        FilterModel:ResetToDefaults(currentFilters)
    else
        currentFilters.searchText = ""
        currentFilters.expansion = "All Expansions"
        currentFilters.vendor = "All Vendors"
        currentFilters.zone = "All Zones"
        currentFilters.zoneMapID = nil
        currentFilters._userSetZone = false
        currentFilters.type = "All Types"
        currentFilters.category = "All Categories"
        currentFilters.faction = "All Factions"
        currentFilters.source = "All Sources"
        currentFilters.collection = "All"
        currentFilters.quality = "All Qualities"
        currentFilters.requirement = "All Requirements"
        currentFilters.hideVisited = false
        currentFilters.showOnlyAvailable = true
        currentFilters.selectedExpansions = {}
        currentFilters.selectedSources = {}
        currentFilters.selectedFactions = {}
        currentFilters.selectedCategories = {}
        currentFilters.excludeExpansions = false
        currentFilters.excludeSources = false
    end

    local searchBox = _G["HousingSearchBox"]
    if searchBox then
        searchBox:SetText("")
    end

    -- Update the checkbox in Settings UI if it exists
    local hideVisitedCheckbox = _G["HousingConfigHideVisitedCheckbox"]
    if hideVisitedCheckbox then
        hideVisitedCheckbox:SetChecked(false)
    end

    local showOnlyAvailableCheckbox = _G["HousingShowOnlyAvailableCheckbox"]
    if showOnlyAvailableCheckbox then
        showOnlyAvailableCheckbox:SetChecked(true)  -- Reset to default (checked)
    end

    -- Helper to set button text (handles both old and new button styles)
    local function SetButtonText(buttonName, text)
        local btn = _G[buttonName]
        if btn then
            if btn.buttonText then
                btn.buttonText:SetText(text)
            elseif btn.SetText then
                btn:SetText(text)
            end
        end
    end

    SetButtonText("HousingExpansionButton", "All Expansions")
    SetButtonText("HousingVendorButton", "All Vendors")
    SetButtonText("HousingZoneButton", "All Zones")
    SetButtonText("HousingTypeButton", "All Types")
    SetButtonText("HousingSourceButton", "All Sources")
    SetButtonText("HousingFactionButton", (FilterModel and FilterModel.GetDefaultFaction and FilterModel:GetDefaultFaction()) or "All Factions")
    SetButtonText("HousingCollectionButton", "All")
    SetButtonText("HousingQualityButton", "All Qualities")
    SetButtonText("HousingRequirementButton", "All Requirements")

    -- Clear multi-select selections
    local function ClearMultiSelectContainer(containerName)
        local container = _G[containerName]
        if container and container.selectedItems then
            wipe(container.selectedItems)
        end
    end

    ClearMultiSelectContainer("HousingExpansionContainer")
    ClearMultiSelectContainer("HousingCategoryContainer")
    ClearMultiSelectContainer("HousingSourceContainer")

    local expContainer = _G["HousingExpansionContainer"]
    if expContainer and expContainer.notToggle and expContainer.notToggle.SetActive then
        expContainer.notToggle.SetActive(false)
    end
    local sourceContainer = _G["HousingSourceContainer"]
    if sourceContainer and sourceContainer.notToggle and sourceContainer.notToggle.SetActive then
        sourceContainer.notToggle.SetActive(false)
    end

    -- Hide auto-filter indicator
    self:ShowAutoFilterIndicator(nil)

    self:ApplyFilters()

end

-- Refresh theme colors dynamically
function Filters:RefreshTheme()
    if not filterFrame then return end
    
    local colors = HousingTheme.Colors
    
    -- Update filter frame backdrop
    filterFrame:SetBackdropColor(colors.bgSecondary[1], colors.bgSecondary[2], colors.bgSecondary[3], colors.bgSecondary[4])
    filterFrame:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], 0.5)
    
    -- Update search container if it exists
    local searchContainer = filterFrame:GetChildren()
    for _, child in pairs({filterFrame:GetChildren()}) do
        if child:GetObjectType() == "Frame" and child.GetBackdrop and child:GetBackdrop() then
            -- Update backdrop colors for all frames
            child:SetBackdropColor(colors.bgTertiary[1], colors.bgTertiary[2], colors.bgTertiary[3], colors.bgTertiary[4])
            child:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], colors.borderPrimary[4])
        elseif child:GetObjectType() == "Button" and child.GetBackdrop and child:GetBackdrop() then
            -- Update backdrop colors for all buttons
            child:SetBackdropColor(colors.bgTertiary[1], colors.bgTertiary[2], colors.bgTertiary[3], colors.bgTertiary[4])
            child:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], colors.borderPrimary[4])
        end
    end
    
    -- Update all text elements
    local regions = {filterFrame:GetRegions()}
    for _, region in ipairs(regions) do
        if region:GetObjectType() == "FontString" then
            -- Check if it's a label (accent color) or regular text (primary color)
            local text = region:GetText()
            if text and string.find(text, ":") then
                -- Labels end with ":" - use accent color
                region:SetTextColor(colors.accentPrimary[1], colors.accentPrimary[2], colors.accentPrimary[3], 1)
            else
                -- Regular text - use primary color
                region:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
            end
        end
    end
end

-- Make globally accessible
_G["HousingFilters"] = Filters

return Filters
