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
    selectedExpansions = {},
    selectedSources = {},
    selectedFactions = {}
}

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
    searchLabel:SetText(L["FILTER_SEARCH"] or "Search:")
    local accentPrimary = HousingTheme.Colors.accentPrimary
    searchLabel:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    
    -- Expansion scrollable button selector (column 2)
    local expansionBtn = self:CreateScrollableSelector(filterFrame, "Expansion", col2X, row1Y, function(value)
        currentFilters.expansion = value
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
        self:ApplyFilters()
    end)
    
    -- ROW 2: Type, Category, Source, Faction (compact spacing)
    local row2Y = -58  -- Second row

    -- Type scrollable button selector (column 1 - aligns with Search)
    local typeBtn = self:CreateScrollableSelector(filterFrame, "Type", col1X, row2Y, function(value)
        currentFilters.type = value
        self:ApplyFilters()
    end)

    -- Category scrollable button selector (column 2 - aligns with Expansion)
    local categoryBtn = self:CreateScrollableSelector(filterFrame, "Category", col2X, row2Y, function(value)
        currentFilters.category = value
        self:ApplyFilters()
    end)

    -- Source scrollable button selector (column 3 - aligns with Vendor)
    local sourceBtn = self:CreateScrollableSelector(filterFrame, "Source", col3X, row2Y, function(value)
        currentFilters.source = value
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
        
        -- If switching to Collected/Uncollected filter, batch-check items BEFORE filtering
        if value ~= "All" and CollectionAPI then
            if HousingItemList and HousingDataManager then
                local allItems = HousingDataManager:GetAllItems()
                if allItems and #allItems > 0 then
                    -- Collect itemIDs that need checking (not in persistent OR session cache)
                    local itemIDsToCheck = {}
                    for _, item in ipairs(allItems) do
                        local itemID = tonumber(item.itemID)
                        if itemID then
                            -- Check if item is in persistent cache
                            local inPersistentCache = HousingDB and HousingDB.collectedDecor and HousingDB.collectedDecor[itemID] == true
                            -- We can't check session cache directly, so we'll check via CollectionAPI
                            -- But to avoid API spam, we'll batch-check items that aren't in persistent cache
                            if not inPersistentCache then
                                table.insert(itemIDsToCheck, itemID)
                            end
                        end
                    end
                    
                    -- If we have uncached items, batch-check them first, THEN apply filter
                    if #itemIDsToCheck > 0 then
                        -- Batch check in chunks to avoid overwhelming the API
                        local batchSize = 50
                        local currentBatch = 1
                        local totalBatches = math.ceil(#itemIDsToCheck / batchSize)
                        
                        local function ProcessBatch()
                            local startIdx = (currentBatch - 1) * batchSize + 1
                            local endIdx = math.min(startIdx + batchSize - 1, #itemIDsToCheck)
                            local batch = {}
                            for i = startIdx, endIdx do
                                table.insert(batch, itemIDsToCheck[i])
                            end
                            
                            -- Check this batch
                            CollectionAPI:BatchRefreshCollectionStatus(batch)
                            
                            currentBatch = currentBatch + 1
                            
                            -- If more batches, schedule next one
                            if currentBatch <= totalBatches then
                                C_Timer.After(0.1, ProcessBatch)
                            else
                                -- All batches done - now apply the filter
                                C_Timer.After(0.2, function()
                                    self:ApplyFilters()
                                end)
                            end
                        end
                        
                        -- Start batch processing
                        ProcessBatch()
                        return  -- Don't apply filter yet, wait for batch check to complete
                    end
                end
            end
        end
        
        -- Apply filter immediately (either "All" was selected, or cache is already populated)
        self:ApplyFilters()
    end)

    -- Quality scrollable button selector (column 2) - API data
    local qualityBtn = self:CreateScrollableSelector(filterFrame, "Quality", col2X, row3Y, function(value)
        currentFilters.quality = value
        self:ApplyFilters()
    end)

    -- Requirement scrollable button selector (column 3) - API data
    local requirementBtn = self:CreateScrollableSelector(filterFrame, "Requirement", col3X, row3Y, function(value)
        currentFilters.requirement = value
        self:ApplyFilters()
    end)

    -- Hide Visited Vendors checkbox (column 4)
    local hideVisitedCheckbox = CreateFrame("CheckButton", "HousingHideVisitedCheckbox", filterFrame, "UICheckButtonTemplate")
    hideVisitedCheckbox:SetSize(24, 24)
    hideVisitedCheckbox:SetPoint("TOPLEFT", col4X, row3Y)
    hideVisitedCheckbox:SetChecked(currentFilters.hideVisited)
    
    local hideVisitedLabel = filterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hideVisitedLabel:SetPoint("LEFT", hideVisitedCheckbox, "RIGHT", 5, 0)
    hideVisitedLabel:SetText(L["FILTER_HIDE_VISITED"] or "Hide Visited")
    hideVisitedLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    hideVisitedCheckbox:SetScript("OnClick", function(self)
        currentFilters.hideVisited = self:GetChecked()
        Filters:ApplyFilters()
        -- Silently toggle visited vendors filter
        -- print("|cFF8A7FD4HousingVendor:|r " .. (currentFilters.hideVisited and "Hiding" or "Showing") .. " visited vendors")
    end)

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
    clearBtnText:SetText(L["FILTER_CLEAR"] or "Clear Filters")
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
        defaultText = L["FILTER_ALL_EXPANSIONS"] or "All Expansions"
    elseif label == "Faction" then
        defaultText = L["FILTER_ALL_FACTIONS"] or GetDefaultFaction()
    elseif label == "Source" then
        defaultText = L["FILTER_ALL_SOURCES"] or "All Sources"
    elseif label == "Collection" then
        defaultText = "All"
    elseif label == "Quality" then
        defaultText = L["FILTER_ALL_QUALITIES"] or "All Qualities"
    elseif label == "Requirement" then
        defaultText = L["FILTER_ALL_REQUIREMENTS"] or "All Requirements"
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
            -- Quality has fixed options (sorted by rarity)
            options = {"Poor", "Common", "Uncommon", "Rare", "Epic", "Legendary"}
        elseif label == "Requirement" then
            -- Requirement has fixed options
            -- Note: Event, Class, Race commented out - no housing items have these requirements
            options = {"None", "Achievement", "Quest", "Reputation", "Renown", "Profession"}
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
            allText = L["FILTER_ALL_EXPANSIONS"] or "All Expansions"
        elseif label == "Faction" then
            allText = L["FILTER_ALL_FACTIONS"] or "All Factions"
        elseif label == "Source" then
            allText = L["FILTER_ALL_SOURCES"] or "All Sources"
        elseif label == "Collection" then
            allText = "All"
        elseif label == "Quality" then
            allText = L["FILTER_ALL_QUALITIES"] or "All Qualities"
        elseif label == "Requirement" then
            allText = L["FILTER_ALL_REQUIREMENTS"] or "All Requirements"
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

            -- Get display text (localized for all filter types)
            local displayText = option
            if HousingDataManager and option ~= allText then
                if label == "Expansion" then
                    displayText = HousingDataManager:GetLocalizedExpansionName(option) or option
                elseif label == "Faction" then
                    displayText = HousingDataManager:GetLocalizedFactionName(option) or option
                elseif label == "Source" then
                    displayText = HousingDataManager:GetLocalizedSourceName(option) or option
                elseif label == "Quality" then
                    displayText = HousingDataManager:GetLocalizedQualityName(option) or option
                elseif label == "Collection" then
                    displayText = HousingDataManager:GetLocalizedCollectionStatus(option) or option
                elseif label == "Requirement" then
                    displayText = HousingDataManager:GetLocalizedRequirementName(option) or option
                elseif label == "Category" then
                    displayText = HousingDataManager:GetLocalizedCategoryName(option) or option
                elseif label == "Type" then
                    displayText = HousingDataManager:GetLocalizedTypeName(option) or option
                end
            end

            -- Text
            local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            text:SetPoint("LEFT", 5, 0)
            text:SetText(displayText)
            text:SetJustifyH("LEFT")
            btn.text = text

            -- Highlight
            btn:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")

            -- Click handler
            btn:SetScript("OnClick", function()
                local filterKey = string.lower(label)
                currentFilters[filterKey] = option
                if button.buttonText then
                    -- Show localized text on button but keep internal value unchanged
                    button.buttonText:SetText(displayText)
                end
                if onChange then
                    onChange(option)
                end
                listFrame:Hide()
                searchBox:SetText("")
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

    -- Close when clicking outside
    listFrame:SetScript("OnHide", function()
        searchBox:SetText("")
        searchBox:ClearFocus()
    end)

    -- Store references
    container.button = button
    container.listFrame = listFrame
    container.label = label

    return container
end

-- Apply filters and update item list
function Filters:ApplyFilters()
    if HousingItemList and HousingDataManager then
        local allItems = HousingDataManager:GetAllItems()
        
        -- Debug: Print filter state
        local filterCount = 0
        local activeFilters = {}
        if currentFilters.expansion and currentFilters.expansion ~= "All Expansions" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Expansion: " .. currentFilters.expansion)
        end
        if currentFilters.vendor and currentFilters.vendor ~= "All Vendors" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Vendor: " .. currentFilters.vendor)
        end
        if currentFilters.zone and currentFilters.zone ~= "All Zones" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Zone: " .. currentFilters.zone)
        end
        if currentFilters.type and currentFilters.type ~= "All Types" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Type: " .. currentFilters.type)
        end
        if currentFilters.category and currentFilters.category ~= "All Categories" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Category: " .. currentFilters.category)
        end
        if currentFilters.faction and currentFilters.faction ~= "All Factions" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Faction: " .. currentFilters.faction)
        end
        if currentFilters.source and currentFilters.source ~= "All Sources" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Source: " .. currentFilters.source)
        end
        if currentFilters.collection and currentFilters.collection ~= "All" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Collection: " .. currentFilters.collection)
        end
        if currentFilters.quality and currentFilters.quality ~= "All Qualities" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Quality: " .. currentFilters.quality)
        end
        if currentFilters.requirement and currentFilters.requirement ~= "All Requirements" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Requirement: " .. currentFilters.requirement)
        end
        if currentFilters.searchText and currentFilters.searchText ~= "" then
            filterCount = filterCount + 1
            table.insert(activeFilters, "Search: " .. currentFilters.searchText)
        end
        
        if filterCount > 0 then
            -- Silently apply filters
            -- print("|cFF8A7FD4HousingVendor:|r Applying " .. filterCount .. " filter(s): " .. table.concat(activeFilters, ", "))
        end
        
        HousingItemList:UpdateItems(allItems, currentFilters)
        
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

-- Clear all filters
function Filters:ClearAllFilters()
    currentFilters.searchText = ""
    currentFilters.expansion = "All Expansions"
    currentFilters.vendor = "All Vendors"
    currentFilters.zone = "All Zones"
    currentFilters.type = "All Types"
    currentFilters.category = "All Categories"
    currentFilters.faction = GetDefaultFaction()
    currentFilters.source = "All Sources"
    currentFilters.collection = "All"
    currentFilters.quality = "All Qualities"
    currentFilters.requirement = "All Requirements"
    currentFilters.hideVisited = false
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

    SetButtonText("HousingExpansionButton", L["FILTER_ALL_EXPANSIONS"] or "All Expansions")
    SetButtonText("HousingVendorButton", L["FILTER_ALL_VENDORS"] or "All Vendors")
    SetButtonText("HousingZoneButton", L["FILTER_ALL_ZONES"] or "All Zones")
    SetButtonText("HousingTypeButton", L["FILTER_ALL_TYPES"] or "All Types")
    SetButtonText("HousingCategoryButton", L["FILTER_ALL_CATEGORIES"] or "All Categories")
    SetButtonText("HousingSourceButton", L["FILTER_ALL_SOURCES"] or "All Sources")
    SetButtonText("HousingFactionButton", L["FILTER_ALL_FACTIONS"] or GetDefaultFaction())
    SetButtonText("HousingCollectionButton", "All")
    SetButtonText("HousingQualityButton", L["FILTER_ALL_QUALITIES"] or "All Qualities")
    SetButtonText("HousingRequirementButton", L["FILTER_ALL_REQUIREMENTS"] or "All Requirements")

    self:ApplyFilters()

    -- Silently clear filters
    -- print("|cFF8A7FD4HousingVendor:|r Filters cleared")
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

