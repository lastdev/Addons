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

-- Theme reference
local Theme = nil
local function GetTheme()
    if not Theme then
        Theme = HousingTheme or {}
    end
    return Theme
end

-- Get default faction based on player's faction
local function GetDefaultFaction()
    local playerFaction = UnitFactionGroup("player")
    -- Return player's faction, which will show that faction + neutral items
    if playerFaction == "Alliance" or playerFaction == "Horde" then
        return playerFaction
    end
    return "All Factions" -- Fallback
end

local currentFilters = {
    searchText = "",
    expansion = "All Expansions",
    vendor = "All Vendors",
    zone = "All Zones",
    type = "All Types",
    category = "All Categories",
    faction = GetDefaultFaction(),
    source = "All Sources",
    collection = "All",
    quality = "All Qualities",
    requirement = "All Requirements",
    hideVisited = false,
    hideNotReleased = false,
    showOnlyAvailable = true,  -- Default to showing only live items
    selectedExpansions = {},
    selectedSources = {},
    selectedFactions = {},
    zoneMapID = nil, -- optional language-independent zone filter
    _userSetZone = false, -- prevent auto-filter from overriding manual zone selection
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
    
    -- ROW 1: Search, Expansion, Vendor, Zone (compact spacing)
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

    -- Vendor scrollable button selector (column 3)
    local vendorBtn = self:CreateScrollableSelector(filterFrame, "Vendor", col3X, row1Y, function(value)
        currentFilters.vendor = value
        self:ApplyFilters()
    end)

    -- Zone scrollable button selector (column 4)
    local zoneBtn = self:CreateScrollableSelector(filterFrame, "Zone", col4X, row1Y, function(value)
        currentFilters.zone = value
        currentFilters.zoneMapID = nil
        -- Treat a manual zone selection as user intent; don't auto-override on zone events.
        currentFilters._userSetZone = value ~= "All Zones"
        self:ShowAutoFilterIndicator(nil)
        self:ApplyFilters()
    end)
    
    -- ROW 2: Type, Category, Source, Faction (compact spacing)
    local row2Y = -58  -- Second row

    -- Type scrollable button selector (column 1 - aligns with Search)
    local typeBtn = self:CreateScrollableSelector(filterFrame, "Type", col1X, row2Y, function(value)
        currentFilters.type = value
        self:ApplyFilters()
    end)

    -- Category scrollable button selector with MULTI-SELECT (column 2 - aligns with Expansion)
    local categoryBtn = self:CreateMultiSelectSelector(filterFrame, "Category", col2X, row2Y, function(selectedItems)
        -- Update the selectedCategories table
        currentFilters.selectedCategories = selectedItems
        
        -- For backward compatibility
        local count = 0
        local firstSelected = nil
        for cat, _ in pairs(selectedItems) do
            count = count + 1
            if not firstSelected then
                firstSelected = cat
            end
        end
        
        if count == 0 then
            currentFilters.category = "All Categories"
        elseif count == 1 then
            currentFilters.category = firstSelected
        else
            currentFilters.category = "Multiple"
        end
        
        self:ApplyFilters()
    end)

    -- Source scrollable button selector with MULTI-SELECT (column 3 - aligns with Vendor)
    local sourceBtn = self:CreateMultiSelectSelector(filterFrame, "Source", col3X, row2Y, function(selectedItems)
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

    -- Faction scrollable button selector (column 4 - aligns with Zone)
    local factionBtn = self:CreateScrollableSelector(filterFrame, "Faction", col4X, row2Y, function(value)
        currentFilters.faction = value
        self:ApplyFilters()
    end)

    -- ROW 3: Collection, Quality, Requirement (compact spacing)
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

    -- Requirement scrollable button selector (column 3) - API data
    local requirementBtn = self:CreateScrollableSelector(filterFrame, "Requirement", col3X, row3Y, function(value)
        currentFilters.requirement = value
        self:ApplyFilters()
    end)

    -- Hide Visited Vendors checkbox (column 4, row 3)
    local hideVisitedCheckbox = CreateFrame("CheckButton", "HousingHideVisitedCheckbox", filterFrame, "UICheckButtonTemplate")
    hideVisitedCheckbox:SetSize(24, 24)
    hideVisitedCheckbox:SetPoint("TOPLEFT", col4X, row3Y)
    hideVisitedCheckbox:SetChecked(currentFilters.hideVisited)

    local hideVisitedLabel = filterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hideVisitedLabel:SetPoint("LEFT", hideVisitedCheckbox, "RIGHT", 5, 0)
    hideVisitedLabel:SetText("Hide Visited")
    hideVisitedLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    hideVisitedCheckbox:SetScript("OnClick", function(self)
        currentFilters.hideVisited = self:GetChecked()
        Filters:ApplyFilters()
    end)

    -- Note: "Only Show Live Items" removed from UI - now controlled by /hv showall command
    -- Default behavior: Only show live items (showOnlyAvailable = true)

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
    backBtnText:SetText("Back")
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

    -- Clear Filters button (Midnight theme styled)
    local clearBtn = CreateFrame("Button", nil, filterFrame, "BackdropTemplate")
    clearBtn:SetSize(100, 24)
    clearBtn:SetPoint("TOPRIGHT", -10, -18)
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
    clearBtnText:SetText("Clear Filters")
    clearBtnText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    clearBtn.label = clearBtnText
    
    clearBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
        self.label:SetTextColor(textHighlight[1], textHighlight[2], textHighlight[3], 1)
    end)
    clearBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
        self.label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    end)
    clearBtn:SetScript("OnClick", function()
        self:ClearAllFilters()
    end)

    _G["HousingFilterFrame"] = filterFrame
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
        defaultText = GetDefaultFaction()
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
            options = {"None", "Achievement", "Quest", "Reputation", "Renown", "Profession", "Class"}
        elseif HousingDataManager then
            local filterOptions = HousingDataManager:GetFilterOptions()
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

    -- Store references
    container.button = button
    container.listFrame = listFrame
    container.label = label
    container.selectedItems = selectedItems
    container.UpdateButtonText = UpdateButtonText

    return container
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
        indicator:SetPoint("BOTTOMLEFT", filterFrame, "BOTTOMLEFT", 15, 5)
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
    currentFilters.searchText = ""
    currentFilters.expansion = "All Expansions"
    currentFilters.vendor = "All Vendors"
    currentFilters.zone = "All Zones"
    currentFilters.zoneMapID = nil
    currentFilters._userSetZone = false
    currentFilters.type = "All Types"
    currentFilters.category = "All Categories"
    currentFilters.faction = GetDefaultFaction()
    currentFilters.source = "All Sources"
    currentFilters.collection = "All"
    currentFilters.quality = "All Qualities"
    currentFilters.requirement = "All Requirements"
    currentFilters.hideVisited = false
    currentFilters.showOnlyAvailable = true
    currentFilters.selectedExpansions = {}
    currentFilters.selectedSources = {}
    currentFilters.selectedFactions = {}

    local searchBox = _G["HousingSearchBox"]
    if searchBox then
        searchBox:SetText("")
    end

    local hideVisitedCheckbox = _G["HousingHideVisitedCheckbox"]
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
    SetButtonText("HousingCategoryButton", "All Categories")
    SetButtonText("HousingSourceButton", "All Sources")
    SetButtonText("HousingFactionButton", GetDefaultFaction())
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
