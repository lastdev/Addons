local ItemList = {}
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

local BUTTON_HEIGHT = 40
local BUTTON_SPACING = 3
local VISIBLE_BUTTONS = 15

local container = nil
local scrollFrame = nil
local buttons = {}
local allItems = {}
local filteredItems = {}
local currentFilters = {}
local sortDirty = true  -- Dirty flag to track when sorting is needed

-- Event frame for housing decor collection updates
local eventFrame = CreateFrame("Frame")

local tooltipScanner = CreateFrame("GameTooltip", "HousingVendorItemListTooltipScanner", UIParent, "GameTooltipTemplate")
tooltipScanner:SetOwner(UIParent, "ANCHOR_NONE")

-- Reusable tooltip scan callback (avoids creating new closures)
local tooltipScanCallback
local pendingTooltipData = {}

local function ProcessTooltipData(tooltipData)
    local numLines = tooltipScanner:NumLines()

    for i = 1, numLines do
        local leftText = _G[string.format("HousingVendorItemListTooltipScannerTextLeft%d", i)]
        local rightText = _G[string.format("HousingVendorItemListTooltipScannerTextRight%d", i)]
        local leftTexture = _G[string.format("HousingVendorItemListTooltipScannerTexture%d", i)]
        local rightTexture = _G[string.format("HousingVendorItemListTooltipScannerTexture%dRight", i)]

        local lineData = {
            leftText = nil,
            rightText = nil,
            leftTexture = nil,
            rightTexture = nil,
            leftColor = nil,
            rightColor = nil
        }

        if leftText then
            local text = leftText:GetText()
            if text then
                lineData.leftText = text
                local r, g, b = leftText:GetTextColor()
                lineData.leftColor = {r, g, b}

                if i == 1 then
                    tooltipData.itemName = text
                end

                local weight = string.match(text, "Weight:%s*(%d+)")
                if weight then
                    tooltipData.weight = tonumber(weight)
                end

                if string.find(text, "Binds") then
                    tooltipData.binding = text
                end

                if string.find(text, "Use:") then
                    tooltipData.useText = text
                end

                if string.find(text, "Collection Bonus") or string.find(text, "First%-Time") then
                    tooltipData.collectionBonus = text
                end

                local itemLevel = string.match(text, "Item Level (%d+)")
                if itemLevel then
                    tooltipData.itemLevel = tonumber(itemLevel)
                end

                local reqLevel = string.match(text, "Requires Level (%d+)")
                if reqLevel then
                    tooltipData.requiredLevel = tonumber(reqLevel)
                end

                if string.find(text, "Requires") and (string.find(text, "Class:") or string.find(text, "Warrior") or string.find(text, "Paladin") or string.find(text, "Hunter") or string.find(text, "Rogue") or string.find(text, "Priest") or string.find(text, "Death Knight") or string.find(text, "Shaman") or string.find(text, "Mage") or string.find(text, "Warlock") or string.find(text, "Monk") or string.find(text, "Druid") or string.find(text, "Demon Hunter") or string.find(text, "Evoker")) then
                    tooltipData.requiredClass = text
                end

                local font = tostring(leftText:GetFont() or "")
                if string.find(font, "Italic") and not tooltipData.description then
                    tooltipData.description = text
                end
            end
        end

        if rightText then
            local text = rightText:GetText()
            if text then
                lineData.rightText = text
                local r, g, b = rightText:GetTextColor()
                lineData.rightColor = {r, g, b}
            end
        end
        if leftTexture and leftTexture:IsShown() then
            local texture = leftTexture:GetTexture()
            if texture and texture ~= "" then
                local textureStr = tostring(texture)
                lineData.leftTexture = textureStr
                
                -- Look for house icon (not weapon icons or question marks)
                if not string.find(textureStr, "INV_Weapon") and
                   not string.find(textureStr, "INV_Sword") and
                   not string.find(textureStr, "INV_Axe") and
                   not string.find(textureStr, "INV_Mace") and
                   not string.find(textureStr, "INV_Shield") and
                   not string.find(textureStr, "INV_Misc_QuestionMark") and
                   not string.find(textureStr, "INV_Helmet") and
                   not string.find(textureStr, "INV_Armor") then
                    -- This could be the house icon
                    if not tooltipData.houseIcon then
                        tooltipData.houseIcon = texture
                    end
                end
            end
        end
        
        if rightTexture and rightTexture:IsShown() then
            local texture = rightTexture:GetTexture()
            if texture and texture ~= "" then
                local textureStr = tostring(texture)
                lineData.rightTexture = textureStr
                
                -- Check right texture for house icon too
                if not string.find(textureStr, "INV_Weapon") and
                   not string.find(textureStr, "INV_Sword") and
                   not string.find(textureStr, "INV_Axe") and
                   not string.find(textureStr, "INV_Mace") and
                   not string.find(textureStr, "INV_Shield") and
                   not string.find(textureStr, "INV_Misc_QuestionMark") and
                   not string.find(textureStr, "INV_Helmet") and
                   not string.find(textureStr, "INV_Armor") then
                    if not tooltipData.houseIcon then
                        tooltipData.houseIcon = texture
                    end
                end
            end
        end
        
        table.insert(tooltipData.allLines, lineData)
    end
end

local function ScanTooltipForAllData(itemID)
    local tooltipData = {
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
        allLines = {}
    }

    if not itemID or itemID == "" then
        return tooltipData
    end

    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return tooltipData
    end

    tooltipScanner:ClearLines()
    tooltipScanner:SetItemByID(numericItemID)

    -- Use single reusable callback instead of creating closures
    if not tooltipScanCallback then
        tooltipScanCallback = function()
            -- Process data from pending table
            for itemID, data in pairs(pendingTooltipData) do
                ProcessTooltipData(data)
                pendingTooltipData[itemID] = nil
            end
        end
    end
    
    -- Store pending data
    pendingTooltipData[numericItemID] = tooltipData
    C_Timer.After(0.1, tooltipScanCallback)

    return tooltipData
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

-- Initialize collection cache in saved variables (AllTheThings approach)
local function InitializeCollectionCache()
    if not HousingDB then
        HousingDB = {}
    end
    if not HousingDB.collectedDecor then
        HousingDB.collectedDecor = {}
    end
end

-- Check if item is cached as collected (AllTheThings approach)
local function IsItemCached(itemID)
    if not HousingDB or not HousingDB.collectedDecor then
        return false
    end
    return HousingDB.collectedDecor[itemID] == true
end

-- Mark item as collected in cache (AllTheThings approach)
local function CacheItemAsCollected(itemID)
    InitializeCollectionCache()
    if HousingDB and HousingDB.collectedDecor then
        HousingDB.collectedDecor[itemID] = true
    end
end

function ItemList:RefreshCollectionStatus()
    if not container or not container:IsVisible() then
        return
    end
    
    -- Initialize collection cache
    InitializeCollectionCache()
    
    -- Initialize catalog searcher once (AllTheThings approach - caches decor data)
    if not DecorSearcherCached and C_HousingCatalog and C_HousingCatalog.CreateCatalogSearcher then
        pcall(function()
            C_HousingCatalog.CreateCatalogSearcher()
        end)
        DecorSearcherCached = true
    end
    
    -- Update collection status for all visible buttons
    for _, button in ipairs(buttons) do
        if button:IsVisible() and button.itemData and button.collectedIcon then
            local item = button.itemData
            if item.itemID and item.itemID ~= "" then
                local itemID = tonumber(item.itemID)
                if itemID then
                    local isCollected = false
                    
                    -- Check cache first (AllTheThings approach - avoid repeated API calls)
                    if IsItemCached(itemID) then
                        isCollected = true
                    else
                        -- Method 1: Use C_Housing.IsDecorCollected (correct API for housing decor)
                        if C_Housing and C_Housing.IsDecorCollected then
                            local success, collected = pcall(function()
                                return C_Housing.IsDecorCollected(itemID)
                            end)
                            if success and collected ~= nil then
                                isCollected = collected
                                if isCollected then
                                    CacheItemAsCollected(itemID)
                                end
                            end
                        end
                        
                        -- Method 2: AllTheThings approach - Check numStored + numPlaced from catalog
                        if not isCollected and C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByItem then
                            local success, state = pcall(function()
                                return C_HousingCatalog.GetCatalogEntryInfoByItem(itemID, true)
                            end)
                            if success and state then
                                local sum = (state.numStored or 0) + (state.numPlaced or 0)
                                if sum > 0 and sum < 1000000 then
                                    isCollected = true
                                    CacheItemAsCollected(itemID)
                                end
                            end
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
    end
    
    -- Always schedule a delayed re-check for auto-learned items (0.1-2 second delay)
    C_Timer.After(1, function()
        ItemList:RefreshCollectionStatus()
    end)
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
    SafeRegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")  -- AllTheThings approach - fires when decor added to chest
    SafeRegisterEvent("HOUSING_COLLECTION_UPDATED")  -- Fires when collection status changes
    SafeRegisterEvent("HOUSING_ITEM_PURCHASED")     -- Fires when item is purchased
    
    -- Backup/edge case events (always available)
    eventFrame:RegisterEvent("MERCHANT_SHOW")  -- Backup refresh when vendor is opened
    eventFrame:RegisterEvent("MERCHANT_CLOSED")  -- Scan after closing vendor (catches items that may not have fired events)
    eventFrame:RegisterEvent("BAG_UPDATE_DELAYED")  -- Catches items appearing in bags silently (covers edge cases)
    eventFrame:RegisterEvent("CHAT_MSG_LOOT")  -- Detect when items are received via loot
    eventFrame:RegisterEvent("PLAYER_LOGIN")  -- Initial scan after login
    
    eventFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "HOUSE_DECOR_ADDED_TO_CHEST" then
            -- AllTheThings approach - decor added to chest (collected)
            local decorUid, decorID = ...
            -- Cache the decorID immediately (AllTheThings approach)
            if decorID then
                CacheItemAsCollected(decorID)
            end
            -- Refresh immediately when decor is collected
            ItemList:RefreshCollectionStatus()
            C_Timer.After(0.5, function() ItemList:RefreshCollectionStatus() end)
            C_Timer.After(1.5, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "HOUSING_COLLECTION_UPDATED" then
            -- Decor collection state changed - refresh immediately
            ItemList:RefreshCollectionStatus()
            C_Timer.After(0.5, function() ItemList:RefreshCollectionStatus() end)
            C_Timer.After(1.5, function() ItemList:RefreshCollectionStatus() end)
            C_Timer.After(2.5, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "HOUSING_ITEM_PURCHASED" then
            -- Item purchased - may not be collected yet (must be used from bags)
            C_Timer.After(0.5, function() ItemList:RefreshCollectionStatus() end)
            C_Timer.After(1.5, function() ItemList:RefreshCollectionStatus() end)
            C_Timer.After(2.5, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "MERCHANT_SHOW" or event == "MERCHANT_CLOSED" or event == "BAG_UPDATE_DELAYED" or event == "CHAT_MSG_LOOT" then
            -- Backup events - delayed checks to catch edge cases
            C_Timer.After(0.5, function() ItemList:RefreshCollectionStatus() end)
            C_Timer.After(1.5, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "PLAYER_LOGIN" then
            -- Initialize catalog searcher (AllTheThings approach - caches decor data)
            if C_HousingCatalog and C_HousingCatalog.CreateCatalogSearcher then
                pcall(function()
                    C_HousingCatalog.CreateCatalogSearcher()
                end)
            end
            -- Initial scan after login
            C_Timer.After(1, function()
                ItemList:RefreshCollectionStatus()
            end)
        end
    end)
end

-- Create item list section
function ItemList:CreateItemListSection(parentFrame)
    -- Create header row with column labels
    -- Position adjusted to account for filter section (110px height + spacing)
    local headerFrame = CreateFrame("Frame", "HousingItemListHeader", parentFrame, "BackdropTemplate")
    local topOffset = -195  -- Base offset
    if parentFrame.warningMessage then
        topOffset = -230  -- Extra offset if warning message exists
    end
    headerFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, topOffset)
    headerFrame:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -40, topOffset + 5)
    headerFrame:SetHeight(25)
    
    -- Header background
    headerFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    headerFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.9)
    headerFrame:SetBackdropBorderColor(0.8, 0.6, 0.2, 1)
    
    -- Item Name header (aligns with nameText which starts at icon + 10)
    local nameHeader = headerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    nameHeader:SetPoint("LEFT", 50, 0)
    nameHeader:SetText("|cFFFFD700Item Name|r")
    
    -- Source header (aligns with typeText which is nameText + 15 offset, nameText width is 300)
    local sourceHeader = headerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    sourceHeader:SetPoint("LEFT", 365, 0)
    sourceHeader:SetText("|cFFFFD700Source|r")
    
    -- Location header (aligns with tooltipInfoText, after typeText width 120 + housingIcon + weightText)
    local locationHeader = headerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    locationHeader:SetPoint("LEFT", 540, 0)
    locationHeader:SetText("|cFFFFD700Location|r")
    
    -- Price header removed - no longer displaying price in main UI
    
    -- Create scroll frame (full width now that preview panel is removed)
    -- Bottom padding increased to make room for legend footer
    -- Top padding adjusted for two-row filter section + header row
    scrollFrame = CreateFrame("ScrollFrame", "HousingItemListScrollFrame", parentFrame, "UIPanelScrollFrameTemplate")
    local scrollTopOffset = -222  -- Base offset (header + spacing)
    if parentFrame.warningMessage then
        scrollTopOffset = -257  -- Extra offset if warning message exists
    end
    scrollFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, scrollTopOffset)
    scrollFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -20, 52)
    
    -- Create container
    container = CreateFrame("Frame", "HousingItemListContainer", scrollFrame)
    container:SetWidth(scrollFrame:GetWidth() - 20)
    container:SetHeight(100) -- Will be updated based on item count
    scrollFrame:SetScrollChild(container)
    
    -- Buttons will be lazy-created on demand (no pre-allocation)
    
    -- Scroll handler - update visible buttons when scrolling
    scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
        ScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT + BUTTON_SPACING)
        C_Timer.After(0, function()
            if HousingItemList then
                HousingItemList:UpdateVisibleButtons()
            end
        end)
    end)
    
    -- Store references
    _G["HousingItemListContainer"] = container
    _G["HousingItemListScrollFrame"] = scrollFrame
end

-- Create a single item button
function ItemList:CreateItemButton(parent, index)
    local button = CreateFrame("Button", "HousingItemButton" .. index, parent, "BackdropTemplate")
    button:SetSize(parent:GetWidth() - 20, BUTTON_HEIGHT)
    button:SetPoint("TOPLEFT", 10, -(index - 1) * (BUTTON_HEIGHT + BUTTON_SPACING))
    
    -- Backdrop
    button:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    button:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
    
    -- Faction color bar (pronounced, stands out more)
    local factionBar = button:CreateTexture(nil, "OVERLAY")  -- Changed from BACKGROUND to OVERLAY
    factionBar:SetWidth(6)  -- 6px width for visibility
    factionBar:SetPoint("TOPLEFT", 2, -2)  -- Inset slightly from edge
    factionBar:SetPoint("BOTTOMLEFT", 2, 2)  -- Inset slightly from edge
    factionBar:SetTexture("Interface\\Buttons\\WHITE8x8")
    factionBar:SetVertexColor(1, 1, 1, 1)  -- Default white, will be colored later
    button.factionBar = factionBar
    
    -- Icon
    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetSize(32, 32)
    icon:SetPoint("LEFT", 8, 0)
    button.icon = icon

    -- Icon border
    local iconBorder = button:CreateTexture(nil, "BORDER")
    iconBorder:SetTexture("Interface\\Buttons\\WHITE8x8")
    iconBorder:SetSize(34, 34)
    iconBorder:SetPoint("CENTER", icon, "CENTER", 0, 0)
    iconBorder:SetVertexColor(0.3, 0.3, 0.3, 0.6)
    button.iconBorder = iconBorder
    
    -- Collected indicator (green tick)
    local collectedIcon = button:CreateTexture(nil, "OVERLAY")
    collectedIcon:SetSize(20, 20)
    collectedIcon:SetPoint("TOPRIGHT", icon, "TOPRIGHT", 2, 2)
    collectedIcon:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
    collectedIcon:SetVertexColor(0, 1, 0, 1) -- Green
    collectedIcon:Hide() -- Hidden by default, shown when item is collected
    button.collectedIcon = collectedIcon
    
    -- Name
    local nameText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("LEFT", icon, "RIGHT", 10, 0)
    nameText:SetWidth(300)
    nameText:SetJustifyH("LEFT")
    button.nameText = nameText

    -- Type
    local typeText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    typeText:SetPoint("LEFT", nameText, "RIGHT", 15, 0)
    typeText:SetWidth(120)
    typeText:SetJustifyH("LEFT")
    typeText:SetTextColor(0.7, 0.7, 0.7, 1)
    button.typeText = typeText
    
    -- Price removed - no longer displaying price in main UI
    
    -- Wishlist heart button (clickable)
    local wishlistButton = CreateFrame("Button", nil, button)
    wishlistButton:SetSize(40, 40)  -- Same height as item bar for better visibility
    wishlistButton:SetPoint("RIGHT", -60, 0)  -- Positioned before map icon
    wishlistButton:SetFrameLevel(button:GetFrameLevel() + 1)
    
    local wishlistIcon = wishlistButton:CreateTexture(nil, "ARTWORK")
    wishlistIcon:SetAllPoints()
    wishlistIcon:SetTexture("Interface\\Common\\friendship-heart")  -- Heart icon for favorites
    wishlistIcon:SetVertexColor(1, 0.2, 0.2, 0.6)  -- Red/pink, semi-transparent when not favorited
    wishlistButton.icon = wishlistIcon
    
    wishlistButton:SetScript("OnClick", function(self, mouseButton)
        if mouseButton == "LeftButton" then
            -- Stop event propagation to prevent waypoint click
            self:SetPropagateKeyboardInput(false)
            
            local item = self:GetParent().itemData
            if item and item.itemID then
                local itemID = tonumber(item.itemID)
                if itemID then
                    if not HousingDB then HousingDB = {} end
                    if not HousingDB.wishlist then HousingDB.wishlist = {} end
                    
                    if HousingDB.wishlist[itemID] then
                        -- Remove from wishlist
                        HousingDB.wishlist[itemID] = nil
                        self.icon:SetVertexColor(1, 0.2, 0.2, 0.6)  -- Dimmed red/pink
                    else
                        -- Add to wishlist
                        HousingDB.wishlist[itemID] = true
                        self.icon:SetVertexColor(1, 0.2, 0.2, 1)  -- Bright red/pink when favorited
                    end
                    
                    -- Refresh filters if wishlist filter is active
                    if HousingFilters then
                        local filters = HousingFilters:GetFilters()
                        if filters.source == "Wishlist" then
                            HousingFilters:ApplyFilters()
                        end
                    end
                    
                    -- Update visible buttons to refresh wishlist icons
                    if HousingItemList then
                        HousingItemList:UpdateVisibleButtons()
                    end
                end
            end
        end
    end)
    
    wishlistButton:SetScript("OnEnter", function(self)
        local item = self:GetParent().itemData
        if item and item.itemID then
            local itemID = tonumber(item.itemID)
            if itemID and HousingDB and HousingDB.wishlist and HousingDB.wishlist[itemID] then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Remove from Wishlist", 1, 1, 0.5)
                GameTooltip:Show()
            else
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Add to Wishlist", 1, 1, 0.5)
                GameTooltip:Show()
            end
        end
    end)
    
    wishlistButton:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    
    button.wishlistButton = wishlistButton
    
    -- Map icon indicator (shows when item has waypoint available)
    local mapIcon = button:CreateTexture(nil, "OVERLAY")
    mapIcon:SetSize(40, 40)  -- Full height of bar, proportional (square)
    mapIcon:SetPoint("RIGHT", -15, 0)  -- Positioned on the right edge
    mapIcon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")  -- Map icon
    mapIcon:SetVertexColor(1, 1, 1, 0.9)
    mapIcon:Hide()
    button.mapIcon = mapIcon
    
    -- Housing icon and weight (house icon + number)
    local housingIcon = button:CreateTexture(nil, "ARTWORK")
    housingIcon:SetSize(16, 16)
    housingIcon:SetPoint("LEFT", typeText, "RIGHT", 10, 0)
    housingIcon:Hide() -- Hidden by default
    button.housingIcon = housingIcon
    
    local weightText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    weightText:SetPoint("LEFT", housingIcon, "RIGHT", 3, 0)
    weightText:SetTextColor(0.7, 0.9, 1, 1) -- Light blue for weight
    weightText:Hide() -- Hidden by default
    button.weightText = weightText
    
    -- Tooltip info text (vendor, zone info) - create after weightText
    local tooltipInfoText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    tooltipInfoText:SetPoint("LEFT", weightText, "RIGHT", 8, 0)
    tooltipInfoText:SetPoint("RIGHT", wishlistButton, "LEFT", -10, 0)  -- Stop before wishlist button
    tooltipInfoText:SetJustifyH("LEFT")
    tooltipInfoText:SetTextColor(0.7, 0.7, 0.7, 1) -- Gray color, less prominent
    tooltipInfoText:SetWordWrap(false)
    tooltipInfoText:Hide() -- Hidden by default
    button.tooltipInfoText = tooltipInfoText
    
    -- Make the entire button clickable for waypoints
    button:EnableMouse(true)
    button:RegisterForClicks("LeftButtonUp")
    button:SetScript("OnClick", function(self, mouseButton)
        -- Don't trigger waypoint if clicking on wishlist button
        if self.wishlistButton and self.wishlistButton:IsMouseOver() then
            return
        end
        
        local item = self.itemData
        if item and item.vendorCoords and item.vendorCoords.x and item.vendorCoords.y and item.mapID and item.mapID > 0 then
            if HousingWaypointManager then
                HousingWaypointManager:SetWaypoint(item)
            else
                print("|cFFFF4040HousingVendor:|r Waypoint module not loaded!")
            end
        else
            -- Debug message when clicking item without waypoint
            print("|cFFFFAA00HousingVendor:|r This item has no waypoint coordinates")
        end
    end)
    
    -- Tooltip and hover effects
    button:SetScript("OnEnter", function(self)
        local item = self.itemData
        if item then
            -- Add a subtle glow border on hover
            self:SetBackdropBorderColor(1, 0.82, 0, 1)  -- Gold glow
            
            -- Show "clickable" cursor if item has waypoint
            if item.vendorCoords and item.vendorCoords.x and item.vendorCoords.y and item.mapID and item.mapID > 0 then
                -- Brighten the map icon to indicate clickability
                if self.mapIcon then
                    self.mapIcon:SetVertexColor(1, 1, 0, 1)  -- Yellow glow when hovering
                end
            end
            
            -- Brighten the backdrop color on hover (preserve faction/source colors)
            if self.originalBackdropColor then
                local r, g, b, a = unpack(self.originalBackdropColor)
                -- Brighten significantly for better visibility
                self:SetBackdropColor(math.min(r + 0.2, 1), math.min(g + 0.2, 1), math.min(b + 0.2, 1), 1)
            else
                -- Fallback if color wasn't stored
                self:SetBackdropColor(0.3, 0.3, 0.3, 1)
            end
            
            -- Gather all available information from all APIs
            local allInfo = {}
            if HousingPreviewPanel and HousingPreviewPanel.GatherAllItemInfo then
                allInfo = HousingPreviewPanel:GatherAllItemInfo(item)
                -- Safety check: ensure catalogInfo and decorInfo are tables or nil (never numbers)
                if allInfo.catalogInfo and type(allInfo.catalogInfo) ~= "table" then
                    allInfo.catalogInfo = nil
                end
                if allInfo.decorInfo and type(allInfo.decorInfo) ~= "table" then
                    allInfo.decorInfo = nil
                end
            end
            
            -- Show comprehensive tooltip
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:ClearLines()
            
            -- Try to show official WoW item tooltip first (if itemID is available)
            local showOfficialTooltip = false
            if item.itemID and item.itemID ~= "" then
                local numericItemID = tonumber(item.itemID)
                if numericItemID then
                    -- Request item data to be loaded
                    if C_Item and C_Item.RequestLoadItemDataByID then
                        C_Item.RequestLoadItemDataByID(numericItemID)
                    end
                    
                    -- Try to get item info
                    local itemInfo = allInfo.itemInfo
                    if not itemInfo and C_Item and C_Item.GetItemInfo then
                        itemInfo = C_Item.GetItemInfo(numericItemID)
                    end
                    
                    -- If we have item info, show official tooltip
                    if itemInfo then
                        GameTooltip:SetItemByID(numericItemID)
                        showOfficialTooltip = true
                    end
                end
            end
            
            -- If official tooltip didn't work, use custom tooltip
            if not showOfficialTooltip then
                -- Item name (colored by faction or quality)
                local nameColor = {1, 1, 1, 1}
                if item.faction == "Horde" then
                    nameColor = {1, 0.3, 0.3, 1} -- Red
                elseif item.faction == "Alliance" then
                    nameColor = {0.3, 0.6, 1, 1} -- Blue
                elseif allInfo.itemInfo and allInfo.itemInfo.itemQuality then
                    -- Use quality color if available
                    local qualityColors = {
                        [0] = {0.62, 0.62, 0.62, 1}, -- Poor
                        [1] = {1, 1, 1, 1}, -- Common
                        [2] = {0.12, 1, 0, 1}, -- Uncommon
                        [3] = {0, 0.44, 0.87, 1}, -- Rare
                        [4] = {0.64, 0.21, 0.93, 1}, -- Epic
                        [5] = {1, 0.5, 0, 1}, -- Legendary
                        [6] = {0.9, 0.8, 0.5, 1}, -- Artifact
                        [7] = {0.9, 0.8, 0.5, 1} -- Heirloom
                    }
                    local qualityColor = qualityColors[allInfo.itemInfo.itemQuality] or {1, 1, 1, 1}
                    nameColor = qualityColor
                end
                
                local displayName = item.name or "Unknown Item"
                if allInfo.itemInfo and allInfo.itemInfo.itemName then
                    displayName = allInfo.itemInfo.itemName
                elseif allInfo.catalogInfo and type(allInfo.catalogInfo) == "table" and allInfo.catalogInfo.name then
                    displayName = allInfo.catalogInfo.name
                elseif allInfo.decorInfo and type(allInfo.decorInfo) == "table" and allInfo.decorInfo.name then
                    displayName = allInfo.decorInfo.name
                end
                
                GameTooltip:SetText(displayName, nameColor[1], nameColor[2], nameColor[3], 1, true)
                
                -- Add API info if available
                if allInfo.itemInfo then
                    if allInfo.itemInfo.itemLevel then
                        GameTooltip:AddLine("Item Level: " .. allInfo.itemInfo.itemLevel, 0.8, 0.8, 0.8, 1)
                    end
                    if allInfo.itemInfo.itemType then
                        local typeText = allInfo.itemInfo.itemType
                        if allInfo.itemInfo.itemSubType then
                            typeText = string.format("%s - %s", typeText, allInfo.itemInfo.itemSubType)
                        end
                        GameTooltip:AddLine("Type: " .. typeText, 0.8, 0.8, 0.8, 1)
                    end
                end
            else
                -- Add separator after official tooltip (no header text)
                GameTooltip:AddLine(" ")
            end
            
            -- Add API information section (no header text)
            if allInfo.itemInfo or (allInfo.catalogInfo and type(allInfo.catalogInfo) == "table") or (allInfo.decorInfo and type(allInfo.decorInfo) == "table") then
                if (allInfo.catalogInfo and type(allInfo.catalogInfo) == "table") or (allInfo.decorInfo and type(allInfo.decorInfo) == "table") then
                    local desc = nil
                    if allInfo.catalogInfo and type(allInfo.catalogInfo) == "table" and allInfo.catalogInfo.description then
                        desc = allInfo.catalogInfo.description
                    elseif allInfo.decorInfo and type(allInfo.decorInfo) == "table" and allInfo.decorInfo.description then
                        desc = allInfo.decorInfo.description
                    end
                    if desc and desc ~= "" then
                        GameTooltip:AddLine("Description: " .. desc, 0.9, 0.9, 0.8, true)
                    end
                end
            end
            
            -- Type and Category
            if item.type and item.type ~= "" then
                GameTooltip:AddLine("Type: " .. item.type, 0.8, 0.8, 0.8, 1)
            end
            if item.category and item.category ~= "" then
                GameTooltip:AddLine("Category: " .. item.category, 0.8, 0.8, 0.8, 1)
            end
            
            GameTooltip:AddLine(" ") -- Spacer
            
            -- Generic NonVendor names to skip (redundant with source type)
            local genericVendors = {
                ["Achievement Items"] = true,
                ["Quest Items"] = true,
                ["Drop Items"] = true,
                ["Crafted Items"] = true,
                ["Replica Items"] = true,
                ["Miscellaneous Items"] = true,
                ["Event Rewards"] = true,
                ["Collection Items"] = true
            }
            local genericZones = {
                ["Achievement Rewards"] = true,
                ["Quest Rewards"] = true,
                ["Drop Rewards"] = true,
                ["Crafted"] = true,
                ["Replicas"] = true,
                ["Miscellaneous"] = true,
                ["Events"] = true,
                ["Collections"] = true
            }
            
            -- Vendor information (skip generic NonVendor names)
            if item.vendorName and item.vendorName ~= "" and not genericVendors[item.vendorName] then
                GameTooltip:AddLine("Vendor: " .. item.vendorName, 1, 0.82, 0, 1)
            end
            if item.zoneName and item.zoneName ~= "" and not genericZones[item.zoneName] then
                GameTooltip:AddLine("Zone: " .. item.zoneName, 1, 0.82, 0, 1)
            end
            if item.expansionName and item.expansionName ~= "" and not genericVendors[item.expansionName] then
                GameTooltip:AddLine("Expansion: " .. item.expansionName, 1, 0.82, 0, 1)
            end
            
            -- Coordinates
            if item.vendorCoords and item.vendorCoords.x and item.vendorCoords.y then
                GameTooltip:AddLine("Coordinates: " .. string.format("%.1f, %.1f", item.vendorCoords.x, item.vendorCoords.y), 0.7, 0.7, 0.7, 1)
            end
            
            -- Cost/Price information
            if item.currency and item.currency ~= "" then
                GameTooltip:AddLine("Cost: " .. item.currency, 1, 0.82, 0, 1)
            elseif item.price and item.price > 0 then
                GameTooltip:AddLine(string.format("Price: %d gold", item.price), 1, 0.82, 0, 1)
            else
                GameTooltip:AddLine("Price: Free", 0.3, 1, 0.3, 1)
            end
            
            -- Achievement requirement
            if item.achievementRequired and item.achievementRequired ~= "" then
                GameTooltip:AddLine("Achievement: " .. item.achievementRequired, 1, 0.5, 0, 1)
            end
            
            -- Quest requirement
            if item.questRequired and item.questRequired ~= "" then
                GameTooltip:AddLine("Quest: " .. item.questRequired, 0.5, 0.8, 1, 1)
            end
            
            -- Drop source
            if item.dropSource and item.dropSource ~= "" then
                GameTooltip:AddLine("Drops from: " .. item.dropSource, 0.8, 0.5, 1, 1)
            end
            
            -- Faction
            if item.faction and item.faction ~= "Neutral" then
                local factionColor = {1, 1, 1, 1}
                if item.faction == "Horde" then
                    factionColor = {1, 0.3, 0.3, 1}
                elseif item.faction == "Alliance" then
                    factionColor = {0.3, 0.6, 1, 1}
                end
                GameTooltip:AddLine("Faction: " .. item.faction, factionColor[1], factionColor[2], factionColor[3], 1)
            end
            
            -- Item ID (if available)
            if item.itemID and item.itemID ~= "" then
                GameTooltip:AddLine("Item ID: " .. item.itemID, 0.5, 0.5, 0.5, 1)
            end
            
            GameTooltip:Show()
        end
    end)
    button:SetScript("OnLeave", function(self)
        -- Restore original border color
        self:SetBackdropBorderColor(0.8, 0.6, 0.2, 1)
        
        -- Restore map icon color
        if self.mapIcon then
            self.mapIcon:SetVertexColor(1, 1, 1, 0.9)  -- Back to normal white
        end
        
        -- Restore the original backdrop color
        if self.originalBackdropColor then
            self:SetBackdropColor(unpack(self.originalBackdropColor))
        else
            -- Fallback if color wasn't stored
            self:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
        end
        GameTooltip:Hide()
    end)
    
    button:Hide()
    return button
end

-- Update item list with filtered items
function ItemList:UpdateItems(items, filters)
    if not container then return end
    
    allItems = items or {}
    filteredItems = allItems
    currentFilters = filters or {}
    
    -- Apply filters if provided
    if filters and HousingDataManager then
        local previousCount = #filteredItems
        filteredItems = HousingDataManager:FilterItems(allItems, filters)
        
        -- Mark as dirty if filter results changed
        if #filteredItems ~= previousCount then
            sortDirty = true
        end
    end
    
    -- Refresh collection status after updating items (with delayed re-check)
    C_Timer.After(0.1, function()
        ItemList:RefreshCollectionStatus()
    end)
    
    -- Only sort if data is dirty (not on every render)
    if sortDirty then
        -- Get player faction for smart sorting
        local playerFaction = UnitFactionGroup("player")
        
        -- Sort by faction priority (player's faction first, then neutral, then opposite faction), then alphabetically
        table.sort(filteredItems, function(a, b)
            local aFaction = a.faction or "Neutral"
            local bFaction = b.faction or "Neutral"
            
            -- Assign priority values (lower = shown first)
            local function getFactionPriority(faction)
                if faction == playerFaction then
                    return 1  -- Player's faction first
                elseif faction == "Neutral" then
                    return 2  -- Neutral second
                else
                    return 3  -- Opposite faction last
                end
            end
            
            local aPriority = getFactionPriority(aFaction)
            local bPriority = getFactionPriority(bFaction)
            
            -- If same priority, sort alphabetically
            if aPriority == bPriority then
                return a.name < b.name
            end
            
            -- Otherwise sort by priority
            return aPriority < bPriority
        end)
        
        sortDirty = false  -- Clear dirty flag
    end
    
    -- Update container height
    local totalHeight = math.max(100, #filteredItems * (BUTTON_HEIGHT + BUTTON_SPACING) + 10)
    container:SetHeight(totalHeight)

    -- Update scroll frame
    if scrollFrame then
        scrollFrame:UpdateScrollChildRect()
        -- Reset scroll to top when filters change
        scrollFrame:SetVerticalScroll(0)
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
    
    -- Hide all buttons first
    for _, button in ipairs(buttons) do
        button:Hide()
    end
    
    -- Show and update visible buttons (create on demand)
    for i = startIndex, endIndex do
        local buttonIndex = i - startIndex + 1
        
        -- Lazy-create button if it doesn't exist
        if not buttons[buttonIndex] then
            buttons[buttonIndex] = self:CreateItemButton(container, buttonIndex)
        end
        
        local button = buttons[buttonIndex]
        local item = filteredItems[i]
        
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
        end
    end
    
    -- Refresh collection status after updating visible buttons (with delayed re-check)
    C_Timer.After(0.1, function()
        ItemList:RefreshCollectionStatus()
    end)
end

-- Update a special view item button (expansion, location, vendor)
function ItemList:UpdateSpecialViewItemButton(button, item)
    -- Determine the type and set appropriate visuals
    local viewType = "Item"
    local viewColor = {0.196, 0.804, 0.196, 1}  -- Green for vendor (#32CD32)
    
    if item._isExpansion then
        viewType = "Expansion"
        viewColor = {0.64, 0.21, 0.93, 1}  -- Purple for expansion (#A035EE)
    elseif item._isZone then
        viewType = "Location"
        viewColor = {0, 0.44, 0.87, 1}  -- Blue for location (#0070DD)
    elseif item._isVendor then
        viewType = "Vendor"
        viewColor = {1, 0.5, 0, 1}  -- Orange for vendor (#FF8000)
    end
    
    -- Update faction/source color bar
    if button.factionBar then
        button.factionBar:SetVertexColor(viewColor[1], viewColor[2], viewColor[3], 1)
        button.factionBar:Show()
    end
    
    -- Update backdrop color
    local backdropColor = {0.1, 0.1, 0.1, 0.7}
    if item._isExpansion then
        backdropColor = {0.15, 0.05, 0.2, 0.9}  -- Dark purple for expansion
    elseif item._isZone then
        backdropColor = {0.05, 0.1, 0.2, 0.9}  -- Dark blue for location
    elseif item._isVendor then
        backdropColor = {0.2, 0.1, 0.05, 0.9}  -- Dark orange for vendor
    end
    
    button.originalBackdropColor = backdropColor
    button:SetBackdropColor(unpack(backdropColor))
    
    -- Update item name
    button.nameText:SetText(item.name)
    
    -- Update type text
    button.typeText:SetText(viewType)
    button.typeText:SetTextColor(viewColor[1], viewColor[2], viewColor[3], viewColor[4])
    
    -- Update tooltip info text
    if button.tooltipInfoText then
        if item._isExpansion then
            button.tooltipInfoText:SetText("Click to view items in this expansion")
        elseif item._isZone then
            button.tooltipInfoText:SetText("Click to view items in this location")
        elseif item._isVendor then
            button.tooltipInfoText:SetText("Click to view items from this vendor")
        else
            button.tooltipInfoText:SetText("")
        end
        button.tooltipInfoText:Show()
    end
    
    -- Price text removed - no longer displaying price in main UI
    
    -- Hide map icon for special view items
    button.mapIcon:Hide()
    
    -- Set a generic icon for special views
    button.icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
    
    -- Hide housing icon and weight for special views
    if button.housingIcon then
        button.housingIcon:Hide()
    end
    if button.weightText then
        button.weightText:Hide()
    end
    
    -- Override click behavior for special view items - drill down to show items
    button:SetScript("OnClick", function(self, mouseButton)
        if item._isExpansion and item._expansionData then
            -- Show all items in this expansion
            local expansionItems = item._expansionData.items
            if HousingFilters then
                local filters = HousingFilters:GetFilters()
                ItemList:UpdateItems(expansionItems, filters)
                -- Show back button
                if _G["HousingBackButton"] then
                    _G["HousingBackButton"]:Show()
                end
            end
        elseif item._isZone and item._zoneData then
            -- Show all items in this zone
            local zoneItems = item._zoneData.items
            if HousingFilters then
                local filters = HousingFilters:GetFilters()
                ItemList:UpdateItems(zoneItems, filters)
                -- Show back button
                if _G["HousingBackButton"] then
                    _G["HousingBackButton"]:Show()
                end
            end
        elseif item._isVendor and item._vendorData then
            -- Show all items from this vendor
            local vendorItems = item._vendorData.items
            if HousingFilters then
                local filters = HousingFilters:GetFilters()
                ItemList:UpdateItems(vendorItems, filters)
                -- Show back button
                if _G["HousingBackButton"] then
                    _G["HousingBackButton"]:Show()
                end
            end
        end
    end)
end

function ItemList:UpdateRegularItemButton(button, item, buttonIndex)
    buttonIndex = buttonIndex or 1
    local isAchievement = item.achievementRequired and item.achievementRequired ~= ""
    local isQuest = item.questRequired and item.questRequired ~= ""
    local isDrop = item.dropSource and item.dropSource ~= ""
    
    -- Update faction/source color bar (faction takes priority, then source type)
    if button.factionBar then
        if item.faction == "Horde" then
            button.factionBar:SetVertexColor(1, 0, 0, 1) -- Bright red for Horde
            button.factionBar:Show()
        elseif item.faction == "Alliance" then
            button.factionBar:SetVertexColor(0, 0.4, 1, 1) -- Bright blue for Alliance
            button.factionBar:Show()
        elseif isAchievement then
            button.factionBar:SetVertexColor(1, 0.843, 0, 1) -- Gold for achievement (#FFD700)
            button.factionBar:Show()
        elseif isQuest then
            button.factionBar:SetVertexColor(0.118, 0.565, 1, 1) -- Bright blue for quest (#1E90FF)
            button.factionBar:Show()
        elseif isDrop then
            button.factionBar:SetVertexColor(1, 0.271, 0, 1) -- Orange/red for drop (#FF4500)
            button.factionBar:Show()
        else
            button.factionBar:Hide() -- No bar for vendor-only items
        end
    end
    
    -- Update backdrop color with tint based on faction OR source type
    local backdropColor
    if item.faction == "Horde" then
        backdropColor = {0.3, 0.05, 0.05, 0.9} -- Red tint for Horde
    elseif item.faction == "Alliance" then
        backdropColor = {0.05, 0.15, 0.3, 0.9} -- Blue tint for Alliance
    elseif isAchievement then
        backdropColor = {0.25, 0.21, 0.0, 0.85} -- Gold/brown tint for achievement (#FFD700)
    elseif isQuest then
        backdropColor = {0.03, 0.14, 0.25, 0.85} -- Blue tint for quest (#1E90FF)
    elseif isDrop then
        backdropColor = {0.25, 0.07, 0.0, 0.85} -- Orange/red tint for drop (#FF4500)
    else
        backdropColor = {0.1, 0.1, 0.1, 0.7} -- Neutral gray for vendor
    end
    
    -- Store the original color for hover effects and apply it
    button.originalBackdropColor = backdropColor
    button:SetBackdropColor(unpack(backdropColor))
    
    -- Update item name (without redundant achievement info since it's shown in typeText)
    local displayName = item.name or "Unknown"
    button.nameText:SetText(displayName)
    
    -- Show source type instead of item type (Achievement, Quest, Drop, or Vendor) with color coding
    local sourceType = "Vendor"  -- Default to vendor
    local sourceColor = {0.196, 0.804, 0.196, 1}  -- Green for vendor (#32CD32)
    local sourceName = ""  -- The actual name of the achievement/quest/drop/vendor
    
    if item.achievementRequired and item.achievementRequired ~= "" then
        sourceType = "Achievement"
        sourceName = item.achievementRequired
        sourceColor = {1, 0.843, 0, 1}  -- Gold for achievement (#FFD700)
    elseif item.questRequired and item.questRequired ~= "" then
        sourceType = "Quest"
        sourceName = item.questRequired
        sourceColor = {0.118, 0.565, 1, 1}  -- Bright blue for quest (#1E90FF)
    elseif item.dropSource and item.dropSource ~= "" then
        sourceType = "Drop"
        sourceName = item.dropSource
        sourceColor = {1, 0.271, 0, 1}  -- Orange/red for drop (#FF4500)
    else
        -- For vendor items, show the vendor name
        sourceName = item.vendorName or ""
    end
    
    -- Combine source type with name if available
    local displayText = sourceType
    if sourceName ~= "" then
        displayText = string.format("%s: %s", sourceType, sourceName)
    end
    
    button.typeText:SetText(displayText)
    button.typeText:SetTextColor(sourceColor[1], sourceColor[2], sourceColor[3], sourceColor[4])
    
    -- Display useful info from our database - just zone (vendor name already shown in green)
    if button.tooltipInfoText then
        -- List of generic NonVendor zone names to exclude (they're redundant with source type)
        local genericZones = {
            ["Achievement Rewards"] = true,
            ["Quest Rewards"] = true,
            ["Drop Rewards"] = true,
            ["Crafted"] = true,
            ["Replicas"] = true,
            ["Miscellaneous"] = true,
            ["Events"] = true,
            ["Collections"] = true
        }
        
        -- Show only zone name (vendor name is already in the green source type text)
        if item.zoneName and item.zoneName ~= "" and not genericZones[item.zoneName] then
            local zoneName = item.zoneName
            if string.len(zoneName) > 30 then
                zoneName = string.format("%s...", string.sub(zoneName, 1, 27))
            end
            button.tooltipInfoText:SetText(zoneName)
            button.tooltipInfoText:Show()
        else
            button.tooltipInfoText:Hide()
        end
    end
    
    -- Price display removed - no longer showing price in main UI (still available in tooltip)

    -- Update wishlist icon state
    if button.wishlistButton and item.itemID then
        local itemID = tonumber(item.itemID)
        if itemID and HousingDB and HousingDB.wishlist and HousingDB.wishlist[itemID] then
            button.wishlistButton.icon:SetVertexColor(1, 0.2, 0.2, 1)  -- Bright red/pink when favorited
            button.wishlistButton:Show()
        else
            button.wishlistButton.icon:SetVertexColor(1, 0.2, 0.2, 0.6)  -- Dimmed red/pink when not favorited
            button.wishlistButton:Show()  -- Always show, just dimmed when not favorited
        end
    end
    
    -- Show/hide map icon based on coordinates
    if item.vendorCoords and item.vendorCoords.x and item.vendorCoords.y and item.mapID and item.mapID > 0 then
        button.mapIcon:Show()
    else
        button.mapIcon:Hide()
    end

    -- Update icon - try to get from cache or load asynchronously
    if item.itemID and item.itemID ~= "" then
        local itemID = tonumber(item.itemID)
        if itemID then
            -- Set question mark as placeholder
            button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

            -- Request item data to be loaded
            if C_Item and C_Item.RequestLoadItemDataByID then
                C_Item.RequestLoadItemDataByID(itemID)
            end

            -- Try to get icon with retries (item data may take time to load)
            local attempts = 0
            local maxAttempts = 5
            local retryDelay = 0.1

            local function TryLoadIcon()
                if not button:IsVisible() then return end

                local iconTexture = nil

                -- Method 1: Try C_Item.GetItemIconByID
                if C_Item and C_Item.GetItemIconByID then
                    iconTexture = C_Item.GetItemIconByID(itemID)
                end

                -- Method 2: Fallback to GetItemIcon
                if not iconTexture and GetItemIcon then
                    iconTexture = GetItemIcon(itemID)
                end

                -- If we got a valid texture, use it
                if iconTexture and iconTexture ~= "" then
                    button.icon:SetTexture(iconTexture)
                else
                    -- Retry if we haven't exceeded max attempts
                    attempts = attempts + 1
                    if attempts < maxAttempts then
                        C_Timer.After(retryDelay, TryLoadIcon)
                    end
                    -- If max attempts reached, keep the question mark
                end
            end

            -- Start loading with a small delay to stagger requests
            C_Timer.After(0.01 * buttonIndex, TryLoadIcon)
            
            -- Scan tooltip for weight and house icon ONLY (other data from our database)
            local scanAttempts = 0
            local maxScanAttempts = 5
            
            local function TryScanTooltipForWeightAndIcon()
                if not button:IsVisible() then return end
                
                -- Clear and set tooltip
                tooltipScanner:ClearLines()
                tooltipScanner:SetItemByID(itemID)
                
                -- Wait longer for tooltip to fully populate (housing icons may take time)
                C_Timer.After(0.25, function()
                    if not button:IsVisible() then return end
                    
                    local numLines = tooltipScanner:NumLines()
                    local foundWeight = nil
                    local foundIcon = nil
                    
                    -- Scan all lines for weight and house icon only
                    for i = 1, numLines do
                        local leftText = _G["HousingVendorItemListTooltipScannerTextLeft" .. i]
                        if leftText then
                            local text = leftText:GetText()
                            if text then
                                -- Look for weight
                                local weight = string.match(text, "Weight:%s*(%d+)")
                                if weight then
                                    foundWeight = tonumber(weight)
                                end
                            end
                        end
                        
                        -- Check ALL texture regions on this line (both left and right)
                        local leftTexture = _G["HousingVendorItemListTooltipScannerTexture" .. i]
                        local rightTexture = _G["HousingVendorItemListTooltipScannerTexture" .. i .. "Right"]
                        
                        -- Check left texture (don't require IsShown - sometimes texture exists but IsShown is false)
                        if leftTexture then
                            local texture = leftTexture:GetTexture()
                            if texture and texture ~= "" then
                                local textureStr = tostring(texture)
                                -- Filter out weapon/armor icons and question marks - be more permissive for house icons
                                if not string.find(textureStr, "INV_Weapon") and
                                   not string.find(textureStr, "INV_Sword") and
                                   not string.find(textureStr, "INV_Axe") and
                                   not string.find(textureStr, "INV_Mace") and
                                   not string.find(textureStr, "INV_Shield") and
                                   not string.find(textureStr, "INV_Helmet") and
                                   not string.find(textureStr, "INV_Armor") and
                                   not string.find(textureStr, "INV_Misc_QuestionMark") and
                                   not string.find(textureStr, "INV_Boots") and
                                   not string.find(textureStr, "INV_Gauntlets") and
                                   not string.find(textureStr, "INV_Shoulder") and
                                   not string.find(textureStr, "INV_Chest") then
                                    -- This could be the house icon - prioritize it
                                    if not foundIcon then
                                        foundIcon = texture
                                    end
                                end
                            end
                        end
                        
                        -- Check right texture
                        if rightTexture then
                            local texture = rightTexture:GetTexture()
                            if texture and texture ~= "" then
                                local textureStr = tostring(texture)
                                if not string.find(textureStr, "INV_Weapon") and
                                   not string.find(textureStr, "INV_Sword") and
                                   not string.find(textureStr, "INV_Axe") and
                                   not string.find(textureStr, "INV_Mace") and
                                   not string.find(textureStr, "INV_Shield") and
                                   not string.find(textureStr, "INV_Helmet") and
                                   not string.find(textureStr, "INV_Armor") and
                                   not string.find(textureStr, "INV_Misc_QuestionMark") and
                                   not string.find(textureStr, "INV_Boots") and
                                   not string.find(textureStr, "INV_Gauntlets") and
                                   not string.find(textureStr, "INV_Shoulder") and
                                   not string.find(textureStr, "INV_Chest") then
                                    if not foundIcon then
                                        foundIcon = texture
                                    end
                                end
                            end
                        end
                    end
                    
                    -- Update house icon
                    if foundIcon then
                        button.housingIcon:SetTexture(foundIcon)
                        button.housingIcon:Show()
                    elseif scanAttempts < maxScanAttempts then
                        -- Retry if icon not found
                        scanAttempts = scanAttempts + 1
                        C_Timer.After(0.5, TryScanTooltipForWeightAndIcon)
                    else
                        button.housingIcon:Hide()
                    end
                    
                    -- Update weight
                    if foundWeight then
                        button.weightText:SetText(tostring(foundWeight))
                        button.weightText:Show()
                    elseif scanAttempts < maxScanAttempts then
                        -- Retry if weight not found yet
                        scanAttempts = scanAttempts + 1
                        C_Timer.After(0.5, TryScanTooltipForWeightAndIcon)
                    else
                        button.weightText:Hide()
                    end
                    
                    -- Tooltip info is now populated from hardcoded data earlier, not from tooltip scan
                end)
            end
            
            -- Start scanning after a delay to allow item data to load
            C_Timer.After(0.3 * buttonIndex, TryScanTooltipForWeightAndIcon)
        else
            button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        end
    else
        button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
    
    -- Hide housing icon and weight by default (will be shown if data is found)
    if button.housingIcon then
        button.housingIcon:Hide()
    end
    if button.weightText then
        button.weightText:Hide()
    end
    
    -- Check if item is collected and show green tick
    if button.collectedIcon then
        if item.itemID and item.itemID ~= "" then
            local itemID = tonumber(item.itemID)
            if itemID then
                -- Check if item is collected using the correct housing decor API
                local isCollected = false
                
                -- Check cache first (AllTheThings approach - avoid repeated API calls)
                if IsItemCached(itemID) then
                    isCollected = true
                else
                    -- Method 1: Use C_Housing.IsDecorCollected (correct API for housing decor)
                    if C_Housing and C_Housing.IsDecorCollected then
                        local success, collected = pcall(function()
                            return C_Housing.IsDecorCollected(itemID)
                        end)
                        if success and collected ~= nil then
                            isCollected = collected
                            if isCollected then
                                CacheItemAsCollected(itemID)
                            end
                        end
                    end
                    
                    -- Method 2: AllTheThings approach - Check numStored + numPlaced from catalog
                    if not isCollected and C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByItem then
                        local success, state = pcall(function()
                            return C_HousingCatalog.GetCatalogEntryInfoByItem(itemID, true)
                        end)
                        if success and state then
                            local sum = (state.numStored or 0) + (state.numPlaced or 0)
                            if sum > 0 and sum < 1000000 then
                                isCollected = true
                                CacheItemAsCollected(itemID)
                            end
                        end
                    end
                    
                    -- Method 3: Fallback to housing catalog API (alternative method)
                    if not isCollected and C_HousingCatalog and C_HousingCatalog.GetCatalogEntryByItemID then
                        local success, entryInfo = pcall(function()
                            return C_HousingCatalog.GetCatalogEntryByItemID(itemID)
                        end)
                        if success and entryInfo then
                            if entryInfo.isCollected ~= nil then
                                isCollected = entryInfo.isCollected
                                if isCollected then
                                    CacheItemAsCollected(itemID)
                                end
                            elseif entryInfo.collected ~= nil then
                                isCollected = entryInfo.collected
                                if isCollected then
                                    CacheItemAsCollected(itemID)
                                end
                            end
                        end
                    end
                    
                    -- Method 4: Fallback to generic item collection API (for non-decor items)
                    if not isCollected and C_PlayerInfo and C_PlayerInfo.IsItemCollected then
                        local success, collected = pcall(function()
                            return C_PlayerInfo.IsItemCollected(itemID)
                        end)
                        if success and collected ~= nil then
                            isCollected = collected
                            if isCollected then
                                CacheItemAsCollected(itemID)
                            end
                        end
                    end
                end
                
                if isCollected then
                    button.collectedIcon:Show()
                else
                    button.collectedIcon:Hide()
                end
            else
                button.collectedIcon:Hide()
            end
        else
            button.collectedIcon:Hide()
        end
    end
    
    -- Restore default click behavior for regular items
    button:EnableMouse(true)
    button:SetScript("OnClick", function(self, mouseButton)
        local item = self.itemData
        if item and item.vendorCoords and item.vendorCoords.x and item.vendorCoords.y and item.mapID and item.mapID > 0 then
            if HousingWaypointManager then
                HousingWaypointManager:SetWaypoint(item)
            else
                print("|cFFFF4040HousingVendor:|r Waypoint module not loaded!")
            end
        else
            -- Debug message when clicking item without waypoint
            print("|cFFFFAA00HousingVendor:|r This item has no waypoint coordinates")
        end
    end)
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
        if button.typeText then
            local typeFont, _, typeFlags = button.typeText:GetFont()
            button.typeText:SetFont(typeFont or "Fonts\\FRIZQT__.TTF", fontSize - 2, typeFlags)
        end
        -- Price text removed - no longer displaying price in main UI
        if button.tooltipInfoText then
            local infoFont, _, infoFlags = button.tooltipInfoText:GetFont()
            button.tooltipInfoText:SetFont(infoFont or "Fonts\\FRIZQT__.TTF", fontSize - 2, infoFlags)
        end
        if button.weightText then
            local weightFont, _, weightFlags = button.weightText:GetFont()
            button.weightText:SetFont(weightFont or "Fonts\\FRIZQT__.TTF", fontSize - 2, weightFlags)
        end
    end
    
    -- Refresh visible buttons
    C_Timer.After(0.1, function()
        if HousingItemList then
            HousingItemList:UpdateVisibleButtons()
        end
    end)
end

-- Make globally accessible
_G["HousingItemList"] = ItemList

return ItemList

