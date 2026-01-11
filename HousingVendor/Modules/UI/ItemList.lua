local ItemList = _G["HousingItemList"] or {}
_G["HousingItemList"] = ItemList
ItemList.__index = ItemList

-- Cache global references for performance
local _G = _G
local C_Timer = C_Timer
local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local tonumber = tonumber
local tostring = tostring
local string_format = string.format
local string_find = string.find
local string_match = string.match
local string_sub = string.sub
local string_lower = string.lower
local math_floor = math.floor
local math_min = math.min
local math_max = math.max
local table_insert = table.insert

local BUTTON_HEIGHT = 48  -- Slightly taller for modern look
local BUTTON_SPACING = 4   -- More spacing between cards
local VISIBLE_BUTTONS = 12 -- Fewer visible due to larger size

-- Theme reference
local Theme = nil
local function GetTheme()
    if not Theme then
        Theme = HousingTheme or {}
    end
    return Theme
end

local container = nil
local scrollFrame = nil
local buttons = {}
local allItems = {}
local filteredItems = {}
local currentFilters = {}
local sortDirty = true  -- Dirty flag to track when sorting is needed
local scrollUpdateHandle = nil
local scrollIdleHandle = nil

-- Event frame for housing decor collection updates
local eventFrame = CreateFrame("Frame")
-- Note: Blizzard may not have a specific favorite changed event
-- We'll check favorites on item update instead

-- Use centralized tooltip scanner (replaces local implementation)
local function ScanTooltipForAllData(itemID)
    if HousingTooltipScanner then
        return HousingTooltipScanner:ScanItem(itemID)
    end

    -- Fallback if scanner not available
    return {
        weight = nil,
        houseIcon = nil,
        description = nil,
        itemName = nil,
        itemQuality = nil,
        itemLevel = nil,
        itemType = nil,
        itemSubType = nil,
        binding = nil,
        useText = nil,
        collectionBonus = nil,
        sellPrice = nil,
        requiredLevel = nil,
        requiredClass = nil,
        requiredFaction = nil,
        requiredReputation = nil,
    }
end

-- Legacy function name for compatibility
local function ScanTooltipForHousingData(itemID)
    local allData = ScanTooltipForAllData(itemID)
    return {
        weight = allData.weight,
        houseIcon = allData.houseIcon,
        description = allData.description
    }
end

-- Refresh collection status for all visible buttons
local DecorSearcherCached = false

function ItemList:RefreshCollectionStatus()
    if not container or not container:IsVisible() then
        return
    end
    
    -- Update collection status for all visible buttons using HousingCollectionAPI
    for _, button in ipairs(buttons) do
        if button:IsVisible() and button.itemData and button.collectedIcon then
            local item = button.itemData
            local isCollected = false
            
            -- First check: Do we have quantity data showing ownership?
            local numStored = item._apiNumStored or 0
            local numPlaced = item._apiNumPlaced or 0
            local totalOwned = numStored + numPlaced
            
            if totalOwned > 0 then
                isCollected = true
            elseif item.itemID and item.itemID ~= "" then
                -- Fallback: Check via HousingCollectionAPI (for items without quantity data yet)
                local itemID = tonumber(item.itemID)
                if itemID and HousingCollectionAPI then
                    isCollected = HousingCollectionAPI:IsItemCollected(itemID)
                end
            end
            
            if isCollected then
                button.collectedIcon:Show()
            else
                button.collectedIcon:Hide()
            end
        end
    end
end

-- Refresh collection status for all filtered items (not just visible ones)
function ItemList:RefreshAllCollectionStatus()
    if not container or not container:IsVisible() then
        return
    end
    
    -- Update collection status for all filtered items, not just visible buttons
    for i, item in ipairs(filteredItems) do
        -- Find the button for this item if it exists and is visible
        local button = nil
        for _, btn in ipairs(buttons) do
            if btn.itemData == item and btn:IsVisible() then
                button = btn
                break
            end
        end
        
        -- If button exists and is visible, update it directly
        if button and button.collectedIcon then
            local isCollected = false
            
            -- First check: Do we have quantity data showing ownership?
            local numStored = item._apiNumStored or 0
            local numPlaced = item._apiNumPlaced or 0
            local totalOwned = numStored + numPlaced
            
            if totalOwned > 0 then
                isCollected = true
            elseif item.itemID and item.itemID ~= "" then
                -- Fallback: Check via HousingCollectionAPI (for items without quantity data yet)
                local itemID = tonumber(item.itemID)
                if itemID and HousingCollectionAPI then
                    isCollected = HousingCollectionAPI:IsItemCollected(itemID)
                end
            end
            
            if isCollected then
                button.collectedIcon:Show()
            else
                button.collectedIcon:Hide()
            end
        end
    end
end

-- Initialize item list
function ItemList:Initialize(parentFrame)
    self:CreateItemListSection(parentFrame)
    
    -- Register events for housing decor collection updates
    -- Primary events (may not exist in all WoW versions - use pcall for safety)
    local function SafeRegisterEvent(eventName)
        local success, err = pcall(function()
            eventFrame:RegisterEvent(eventName)
        end)
        if not success then
            -- Event doesn't exist in this version, skip it silently
            return false
        end
        return true
    end
    
    -- Try to register housing-specific events (may not exist in all versions)
    SafeRegisterEvent("HOUSING_COLLECTION_UPDATED")  -- Fires when collection status changes
    
    -- Minimal always-available events to keep the list fresh without heavy listeners
    eventFrame:RegisterEvent("MERCHANT_CLOSED")  -- Scan after closing vendor (catches items that may not have fired events)
    eventFrame:RegisterEvent("BAG_UPDATE_DELAYED")  -- Catches items appearing in bags silently (covers edge cases)
    
    eventFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "HOUSING_COLLECTION_UPDATED" then
            -- Single debounced refresh (replaces 4x stacked calls)
            C_Timer.After(1, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "MERCHANT_CLOSED" or event == "BAG_UPDATE_DELAYED" then
            -- Single debounced refresh (replaces 2x stacked calls)
            C_Timer.After(1, function() ItemList:RefreshCollectionStatus() end)
        end
    end)
end

-- Create item list section
function ItemList:CreateItemListSection(parentFrame)
    -- Create scroll frame (narrower to fit preview panel on the right)
    -- Preview panel is 500px wide + 20px margin = 520px from right edge
    -- No header row - items start directly below filters
    scrollFrame = CreateFrame("ScrollFrame", "HousingItemListScrollFrame", parentFrame, "UIPanelScrollFrameTemplate")
    -- Header is ~55px, filters are 140px (3 compact rows), plus small spacing
    local scrollTopOffset = -215  -- Base offset (header 55 + filters 140 + spacing 20)
    if parentFrame.warningMessage then
        scrollTopOffset = -250  -- Extra offset if warning message exists (35px warning)
    end
    scrollFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, scrollTopOffset)
    scrollFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -520, 52)  -- Leave space for preview panel (520px = 500px panel + 20px margin)
    
    -- Create container
    container = CreateFrame("Frame", "HousingItemListContainer", scrollFrame)
    container:SetWidth(scrollFrame:GetWidth() - 20)
    container:SetHeight(100) -- Will be updated based on item count
    scrollFrame:SetScrollChild(container)
    
    -- Buttons will be lazy-created on demand (no pre-allocation)
    
    -- Scroll handler - update visible buttons when scrolling
    scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
        ScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT + BUTTON_SPACING)

        -- Throttle scroll updates and run a small idle cleanup after scrolling stops.
        if scrollUpdateHandle and scrollUpdateHandle.Cancel then
            scrollUpdateHandle:Cancel()
        end
        scrollUpdateHandle = C_Timer.NewTimer(0.03, function()
            if HousingItemList then
                HousingItemList:UpdateVisibleButtons()
            end
        end)

        if scrollIdleHandle and scrollIdleHandle.Cancel then
            scrollIdleHandle:Cancel()
        end
        scrollIdleHandle = C_Timer.NewTimer(0.6, function()
            if HousingItemList and HousingItemList.OnScrollIdle then
                HousingItemList:OnScrollIdle()
            end
        end)
    end)
    
    -- Store references
    _G["HousingItemListContainer"] = container
    _G["HousingItemListScrollFrame"] = scrollFrame
end

-- Create a single item button (Midnight Theme)
function ItemList:CreateItemButton(parent, index)
    local theme = GetTheme()
    local colors = theme.Colors or {}
    
    local button = CreateFrame("Button", "HousingItemButton" .. index, parent, "BackdropTemplate")
    button:SetSize(parent:GetWidth() - 16, BUTTON_HEIGHT)
    button:SetPoint("TOPLEFT", 8, -(index - 1) * (BUTTON_HEIGHT + BUTTON_SPACING))
    
    -- Midnight theme backdrop (card style)
    button:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    -- Deep purple background
    local bgTertiary = colors.bgTertiary or {0.16, 0.12, 0.24, 0.90}
    local borderPrimary = colors.borderPrimary or {0.35, 0.30, 0.50, 0.8}
    button:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    button:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    -- LEFT EDGE: Split color bar (top half = faction, bottom half = source type)
    -- Top half - faction color (Alliance/Horde) or source if no faction
    local factionBar = button:CreateTexture(nil, "OVERLAY")
    factionBar:SetWidth(4)
    factionBar:SetPoint("TOPLEFT", 0, 0)
    factionBar:SetPoint("BOTTOMLEFT", 0, BUTTON_HEIGHT / 2)  -- Top half only
    factionBar:SetTexture("Interface\\Buttons\\WHITE8x8")
    factionBar:SetVertexColor(0.35, 0.80, 0.45, 1)  -- Default green (vendor)
    button.factionBar = factionBar

    -- Bottom half - source type color (achievement/quest/drop/vendor)
    local sourceBar = button:CreateTexture(nil, "OVERLAY")
    sourceBar:SetWidth(4)
    sourceBar:SetPoint("TOPLEFT", 0, -BUTTON_HEIGHT / 2)  -- Bottom half only
    sourceBar:SetPoint("BOTTOMLEFT", 0, 0)
    sourceBar:SetTexture("Interface\\Buttons\\WHITE8x8")
    sourceBar:SetVertexColor(0.35, 0.80, 0.45, 1)  -- Default green (vendor)
    button.sourceBar = sourceBar
    
    -- Icon (larger for modern look)
    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetSize(38, 38)  -- Larger icon
    icon:SetPoint("LEFT", 12, 0)
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)  -- Trim icon borders
    button.icon = icon

    -- Icon border (quality glow)
    local iconBorder = CreateFrame("Frame", nil, button, "BackdropTemplate")
    iconBorder:SetSize(42, 42)
    iconBorder:SetPoint("CENTER", icon, "CENTER", 0, 0)
    -- Ensure the backdrop sits BEHIND the icon texture (otherwise it darkens the icon).
    local buttonLevel = button.GetFrameLevel and button:GetFrameLevel() or 1
    iconBorder:SetFrameLevel(math.max(0, (buttonLevel or 1) - 1))
    iconBorder:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    iconBorder:SetBackdropColor(0.05, 0.05, 0.05, 0.8)
    iconBorder:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    button.iconBorder = iconBorder
    
    -- Collected indicator (checkmark)
    local collectedIcon = button:CreateTexture(nil, "OVERLAY")
    collectedIcon:SetSize(18, 18)
    collectedIcon:SetPoint("TOPRIGHT", icon, "TOPRIGHT", 4, 4)
    collectedIcon:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
    local statusSuccess = colors.statusSuccess or {0.30, 0.85, 0.50, 1.0}
    collectedIcon:SetVertexColor(statusSuccess[1], statusSuccess[2], statusSuccess[3], 1)
    collectedIcon:Hide()
    button.collectedIcon = collectedIcon

    -- Owned quantity text (bottom-left of icon, larger)
    local quantityText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    quantityText:SetPoint("BOTTOMLEFT", icon, "BOTTOMLEFT", -2, -2)
    quantityText:SetTextColor(statusSuccess[1], statusSuccess[2], statusSuccess[3], 1)
    quantityText:Hide()
    button.quantityText = quantityText
    
    -- Name text (primary)
    local nameText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("LEFT", icon, "RIGHT", 12, 4)
    nameText:SetWidth(200)
    nameText:SetJustifyH("LEFT")
    local textPrimary = colors.textPrimary or {0.92, 0.90, 0.96, 1.0}
    nameText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    button.nameText = nameText
    
    -- Vendor text (secondary, below name)
    local vendorText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    vendorText:SetPoint("TOPLEFT", nameText, "BOTTOMLEFT", 0, -2)
    vendorText:SetWidth(200)
    vendorText:SetJustifyH("LEFT")
    local textSecondary = colors.textSecondary or {0.70, 0.68, 0.78, 1.0}
    vendorText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    vendorText:SetText("")
    button.vendorText = vendorText
    
    -- Cost text (right side, gold accent)
    local costText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    costText:SetPoint("RIGHT", button, "RIGHT", -12, 0)
    costText:SetJustifyH("RIGHT")
    local accentGold = colors.accentGold or {0.85, 0.75, 0.45, 1.0}
    costText:SetTextColor(accentGold[1], accentGold[2], accentGold[3], 1)
    button.costText = costText
    
    -- Zone text (above cost, smaller)
    local zoneText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    zoneText:SetPoint("BOTTOMRIGHT", costText, "TOPRIGHT", 0, 2)
    zoneText:SetJustifyH("RIGHT")
    local textMuted = colors.textMuted or {0.50, 0.48, 0.58, 1.0}
    zoneText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    button.zoneText = zoneText
    
    -- Make the entire button clickable
    button:EnableMouse(true)
    button:RegisterForClicks("LeftButtonUp")
    button:SetScript("OnClick", function(self, mouseButton)
        local item = self.itemData
        if not item then return end
        
        -- Click: Show preview panel
        if HousingPreviewPanel then
            HousingPreviewPanel:ShowItem(item)
        else
            -- Silently handle missing PreviewPanel
            -- print("|cFF8A7FD4HousingVendor:|r HousingPreviewPanel not found")
        end
    end)
    
    -- Hover tooltip scripts are attached via a separate module to keep this file smaller.
    if HousingVendorItemListTooltip and HousingVendorItemListTooltip.AttachButton then
        HousingVendorItemListTooltip.AttachButton(button)
    end

    
    button:Hide()
    return button
end

-- Update item list with filtered items
function ItemList:UpdateItems(items, filters)
    if not container then return end
    
    allItems = items or {}
    filteredItems = allItems
    currentFilters = filters or {}

    -- Only reset scroll position when filters actually change (prevents flashing/jumping during
    -- background refreshes like quality-cache warmup).
    local filterHash = ""
    if HousingDataManager and HousingDataManager.Util and HousingDataManager.Util.GetFilterHash then
        filterHash = HousingDataManager.Util.GetFilterHash(currentFilters) or ""
    end
    local filtersChanged = (filterHash ~= (self._lastFilterHash or ""))
    self._lastFilterHash = filterHash
    
    -- Apply filters if provided (ID-based, low overhead)
    if filters and HousingDataManager and HousingDataManager.FilterItemIDs then
        filteredItems = HousingDataManager:FilterItemIDs(allItems, filters)
        sortDirty = false
    end
    
    -- Refresh collection status after updating items (instant)
    ItemList:RefreshCollectionStatus()
    
    -- Low overhead default: keep ID order (sorted ascending in DataManager index)
    -- If `filteredItems` contains full item tables (legacy), sorting is handled above.
    
    -- Update container height
    local totalHeight = math.max(100, #filteredItems * (BUTTON_HEIGHT + BUTTON_SPACING) + 10)
    container:SetHeight(totalHeight)

    -- Update scroll frame
    if scrollFrame then
        scrollFrame:UpdateScrollChildRect()
        if filtersChanged then
            scrollFrame:SetVerticalScroll(0)
        end
    end

    -- Update visible buttons synchronously (no delay needed)
    self:UpdateVisibleButtons()
end

-- Update which buttons are visible (virtual scrolling with lazy creation)
function ItemList:UpdateVisibleButtons()
    if not container or not scrollFrame then return end
    
    local scrollOffset = scrollFrame:GetVerticalScroll()
    local startIndex = math.floor(scrollOffset / (BUTTON_HEIGHT + BUTTON_SPACING)) + 1
    local endIndex = math.min(startIndex + VISIBLE_BUTTONS, #filteredItems)
    local visibleCount = math.max(0, endIndex - startIndex + 1)
    
    -- Hide buttons that are no longer needed and cancel any async work on them.
    for idx = visibleCount + 1, #buttons do
        local button = buttons[idx]
        if button then
            if ItemList.CancelAsyncWork then
                ItemList.CancelAsyncWork(button)
            end
            button.itemData = nil
            button:Hide()
        end
    end

    -- Empty-state label
    if not container.emptyText then
        local colors = HousingTheme and HousingTheme.Colors or {}
        local textMuted = colors.textMuted or {0.50, 0.48, 0.58, 1.0}
        local t = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        t:SetPoint("TOPLEFT", container, "TOPLEFT", 10, -10)
        t:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
        t:SetJustifyH("LEFT")
        t:SetText("No items match the current filters.")
        t:Hide()
        container.emptyText = t
    end

    if #filteredItems == 0 then
        -- No results: stop all async work on pooled buttons.
        for idx = 1, #buttons do
            local button = buttons[idx]
            if button then
                if ItemList.CancelAsyncWork then
                    ItemList.CancelAsyncWork(button)
                end
                button.itemData = nil
                button:Hide()
            end
        end
        if HousingDataManager and HousingDataManager._state and HousingDataManager._state._qualityFilterLoading then
            container.emptyText:SetText("Loading quality data...")
        else
            container.emptyText:SetText("No items match the current filters.")
        end
        container.emptyText:Show()
        return
    end
    container.emptyText:Hide()
    
    -- Show and update visible buttons (create on demand)
    for i = startIndex, endIndex do
        local buttonIndex = i - startIndex + 1
        
        -- Lazy-create button if it doesn't exist
        if not buttons[buttonIndex] then
            buttons[buttonIndex] = self:CreateItemButton(container, buttonIndex)
        end
        
        local button = buttons[buttonIndex]
        local entry = filteredItems[i]
        local item = entry
        if type(entry) == "number" and HousingDataManager and HousingDataManager.GetItemRecord then
            item = HousingDataManager:GetItemRecord(entry)
        end
        
        if item then
            -- Update button position
            button:ClearAllPoints()
            button:SetPoint("TOPLEFT", container, "TOPLEFT", 10, -(i - 1) * (BUTTON_HEIGHT + BUTTON_SPACING))
            
            -- Update button data
            button.itemData = item
            
            -- Check if this is a special view item (expansion, location, vendor)
            if item._isExpansion or item._isZone or item._isVendor then
                -- Handle special view items differently
                self:UpdateSpecialViewItemButton(button, item)
            else
                -- Handle regular item buttons
                self:UpdateRegularItemButton(button, item, buttonIndex)
            end
            
            button:Show()
        else
            -- Clear slot if record could not be resolved.
            if ItemList.CancelAsyncWork then
                ItemList.CancelAsyncWork(button)
            end
            button.itemData = nil
            button:Hide()
        end
    end
    
    -- Refresh collection status after updating visible buttons (instant)
    ItemList:RefreshCollectionStatus()
end

-- Called after scrolling has been idle for a short period.
function ItemList:OnScrollIdle()
    -- Cancel async work on any hidden pooled buttons (safety).
    for _, button in ipairs(buttons) do
        if button and (not button.IsShown or not button:IsShown()) then
            if ItemList.CancelAsyncWork then
                ItemList.CancelAsyncWork(button)
            end
            button.itemData = nil
        end
    end

    -- Light GC step to reduce memory pressure after heavy scrolling.
    if collectgarbage then
        collectgarbage("step", 500)
    end
end

-- Apply font size to all buttons
function ItemList:ApplyFontSize(fontSize)
    fontSize = fontSize or 12
    
    -- Update all button text elements
    for _, button in ipairs(buttons) do
        if button.nameText then
            local nameFont, _, nameFlags = button.nameText:GetFont()
            button.nameText:SetFont(nameFont or "Fonts\\FRIZQT__.TTF", fontSize, nameFlags)
        end
        -- Removed: typeText, tooltipInfoText, weightText (fields removed)
    end
    
    -- Refresh visible buttons
    C_Timer.After(0.1, function()
        if HousingItemList then
            HousingItemList:UpdateVisibleButtons()
        end
    end)
end

-- Cleanup function to unregister events and clear references
-- This is called when the UI is hidden to free resources
function ItemList:Cleanup()
    -- Unregister all events to stop processing when UI is closed
    if eventFrame then
        eventFrame:UnregisterAllEvents()
        -- Note: We don't clear the OnEvent handler, so events can be re-registered on Show
    end

    -- Hide buttons but keep references for re-use (better performance than recreating)
    for i = 1, #buttons do
        if buttons[i] then
            -- Cancel any in-flight async work (tickers/timers) so they don't keep references alive.
            if ItemList.CancelAsyncWork then
                ItemList.CancelAsyncWork(buttons[i])
            end
            buttons[i].itemData = nil
            buttons[i]:Hide()
        end
    end

    -- Clear data arrays to allow garbage collection of large tables
    -- These will be repopulated when UI is shown again
    allItems = {}
    filteredItems = {}

    -- Note: We intentionally keep currentFilters and button pool for faster reopening
end

-- Re-register events after cleanup (called on UI Show)
function ItemList:ReRegisterEvents()
    if not eventFrame then return end

    local function SafeRegisterEvent(eventName)
        local success = pcall(function()
            eventFrame:RegisterEvent(eventName)
        end)
        return success
    end

    -- Re-register all housing events
    SafeRegisterEvent("HOUSING_COLLECTION_UPDATED")
    SafeRegisterEvent("MERCHANT_CLOSED")
    SafeRegisterEvent("BAG_UPDATE_DELAYED")
end

-- Refresh theme colors dynamically
function ItemList:RefreshTheme()
    if not scrollFrame then return end
    
    -- Re-render visible items with new theme colors
    ItemList:UpdateVisibleButtons()
end

-- Make globally accessible
_G["HousingItemList"] = ItemList

return ItemList
