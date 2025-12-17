-- Filters Module for HousingVendor addon
-- Clean filter controls and logic

local Filters = {}
Filters.__index = Filters

-- Cache global references for performance
local _G = _G
local CreateFrame = CreateFrame
local table_insert = table.insert

local filterFrame = nil

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
    selectedExpansions = {},
    selectedSources = {},
    selectedFactions = {}
}

-- Initialize filters
function Filters:Initialize(parentFrame)
    self:CreateFilterSection(parentFrame)
end

-- Create filter section
function Filters:CreateFilterSection(parentFrame)
    filterFrame = CreateFrame("Frame", "HousingFilterFrame", parentFrame, "BackdropTemplate")
    -- Adjust position if warning message exists (35px height)
    local topOffset = -70
    if parentFrame.warningMessage then
        topOffset = -105 -- Move down by 35px to account for warning message
    end
    filterFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 15, topOffset)
    filterFrame:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -15, topOffset)
    filterFrame:SetHeight(110)
    
    -- Modern dark background
    filterFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    filterFrame:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
    
    -- Perfect grid alignment - all dropdowns same width and spacing
    local dropdownWidth = 200  -- Wider dropdowns
    local spacing = 20  -- More breathing room
    local leftMargin = 15
    local col1X = leftMargin
    local col2X = col1X + dropdownWidth + spacing
    local col3X = col2X + dropdownWidth + spacing
    local col4X = col3X + dropdownWidth + spacing
    
    -- ROW 1: Search, Expansion, Vendor, Zone
    -- Search box (column 1) - positioned more to the left
    local searchBox = CreateFrame("EditBox", "HousingSearchBox", filterFrame, "InputBoxTemplate")
    searchBox:SetSize(dropdownWidth, 22)
    searchBox:SetPoint("TOPLEFT", col1X - 10, -25)
    searchBox:SetAutoFocus(false)
    searchBox:SetScript("OnTextChanged", function(self)
        currentFilters.searchText = self:GetText()
        Filters:ApplyFilters()
    end)
    
    local searchLabel = filterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    searchLabel:SetPoint("BOTTOMLEFT", searchBox, "TOPLEFT", -5, 3)  -- Top left of search box
    searchLabel:SetText("Search:")
    searchLabel:SetTextColor(1, 0.82, 0, 1)
    
    -- Expansion scrollable button selector (column 2)
    local expansionBtn = self:CreateScrollableSelector(filterFrame, "Expansion", col2X, -25, function(value)
        currentFilters.expansion = value
        self:ApplyFilters()
    end)

    -- Vendor scrollable button selector (column 3)
    local vendorBtn = self:CreateScrollableSelector(filterFrame, "Vendor", col3X, -25, function(value)
        currentFilters.vendor = value
        self:ApplyFilters()
    end)

    -- Zone scrollable button selector (column 4)
    local zoneBtn = self:CreateScrollableSelector(filterFrame, "Zone", col4X, -25, function(value)
        currentFilters.zone = value
        self:ApplyFilters()
    end)
    
    -- ROW 2: Type, Category, Source, Faction (perfectly aligned with row 1)
    local row2Y = -72  -- Slightly more spacing between rows

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

    -- Collection scrollable button selector (column 5 - next to Faction)
    local col5X = col4X + dropdownWidth + spacing
    local collectionBtn = self:CreateScrollableSelector(filterFrame, "Collection", col5X, row2Y, function(value)
        currentFilters.collection = value
        self:ApplyFilters()
    end)

    -- Back button (hidden by default, shown when drilling down into a view)
    local backBtn = CreateFrame("Button", "HousingBackButton", filterFrame, "UIPanelButtonTemplate")
    backBtn:SetSize(80, 26)
    backBtn:SetPoint("TOPRIGHT", -130, -25)
    backBtn:SetText("← Back")
    backBtn:SetNormalFontObject("GameFontNormalLarge")
    backBtn:Hide()  -- Hidden by default
    backBtn:SetScript("OnClick", function()
        -- Return to the appropriate view based on current display mode
        if HousingUINew and HousingDB and HousingDB.settings and HousingDB.settings.displayMode then
            HousingUINew:RefreshDisplay(HousingDB.settings.displayMode)
            backBtn:Hide()
        end
    end)
    _G["HousingBackButton"] = backBtn

    -- Modern Clear Filters button (top right, aligned with row 1)
    local clearBtn = CreateFrame("Button", nil, filterFrame, "UIPanelButtonTemplate")
    clearBtn:SetSize(110, 26)
    clearBtn:SetPoint("TOPRIGHT", -10, -25)
    clearBtn:SetText("Clear Filters")
    clearBtn:SetNormalFontObject("GameFontNormalLarge")
    clearBtn:SetScript("OnClick", function()
        self:ClearAllFilters()
    end)

    _G["HousingFilterFrame"] = filterFrame
end

-- Create a scrollable selector (button that opens scrollable list)
function Filters:CreateScrollableSelector(parent, label, xOffset, yOffset, onChange)
    local container = CreateFrame("Frame", "Housing" .. label .. "Container", parent)
    container:SetSize(200, 30)
    container:SetPoint("TOPLEFT", parent, "TOPLEFT", xOffset, yOffset)

    -- Label
    local labelText = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelText:SetPoint("BOTTOMLEFT", container, "TOPLEFT", 5, 3)
    labelText:SetText(label .. ":")
    labelText:SetTextColor(1, 0.82, 0, 1)

    -- Button that shows current selection
    local button = CreateFrame("Button", "Housing" .. label .. "Button", container, "UIPanelButtonTemplate")
    button:SetSize(200, 26)
    button:SetPoint("TOPLEFT", 0, 0)

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
    end
    button:SetText(defaultText)
    button:SetNormalFontObject("GameFontNormal")

    -- Scrollable list frame (hidden by default)
    local listFrame = CreateFrame("Frame", "Housing" .. label .. "ListFrame", UIParent, "BackdropTemplate")
    listFrame:SetSize(350, 400)
    listFrame:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -2)
    listFrame:SetFrameStrata("DIALOG")
    listFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    listFrame:SetBackdropBorderColor(1, 0.82, 0, 1)
    listFrame:Hide()
    listFrame:EnableMouse(true)

    -- Search box in list frame
    local searchBox = CreateFrame("EditBox", nil, listFrame, "InputBoxTemplate")
    searchBox:SetSize(320, 20)
    searchBox:SetPoint("TOPLEFT", 15, -10)
    searchBox:SetAutoFocus(false)
    searchBox:SetFontObject("ChatFontNormal")
    searchBox:SetScript("OnEscapePressed", function(editBox)
        editBox:ClearFocus()
        listFrame:Hide()
    end)

    local searchLabel = listFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    searchLabel:SetPoint("BOTTOMLEFT", searchBox, "TOPLEFT", 0, 2)
    searchLabel:SetText("Search:")
    searchLabel:SetTextColor(1, 0.82, 0, 1)

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
                local filterKey = string.lower(label)
                currentFilters[filterKey] = option
                button:SetText(option)
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
        HousingItemList:UpdateItems(allItems, currentFilters)
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
    currentFilters.selectedExpansions = {}
    currentFilters.selectedSources = {}
    currentFilters.selectedFactions = {}

    local searchBox = _G["HousingSearchBox"]
    if searchBox then
        searchBox:SetText("")
    end

    local expansionButton = _G["HousingExpansionButton"]
    if expansionButton then
        expansionButton:SetText("All Expansions")
    end

    local vendorButton = _G["HousingVendorButton"]
    if vendorButton then
        vendorButton:SetText("All Vendors")
    end

    local zoneButton = _G["HousingZoneButton"]
    if zoneButton then
        zoneButton:SetText("All Zones")
    end

    local typeButton = _G["HousingTypeButton"]
    if typeButton then
        typeButton:SetText("All Types")
    end

    local categoryButton = _G["HousingCategoryButton"]
    if categoryButton then
        categoryButton:SetText("All Categories")
    end

    local sourceButton = _G["HousingSourceButton"]
    if sourceButton then
        sourceButton:SetText("All Sources")
    end

    local factionButton = _G["HousingFactionButton"]
    if factionButton then
        factionButton:SetText(GetDefaultFaction())
    end

    local collectionButton = _G["HousingCollectionButton"]
    if collectionButton then
        collectionButton:SetText("All")
    end

    self:ApplyFilters()

    print("|cFFFFD100HousingVendor:|r Filters cleared")
end

-- Make globally accessible
_G["HousingFilters"] = Filters

return Filters

