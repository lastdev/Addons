-- Statistics UI Module
-- Detailed stats and graphs about the housing items database

local ADDON_NAME, ns = ...
local L = ns.L

local StatisticsUI = {}
StatisticsUI.__index = StatisticsUI

local statsContainer = nil
local backButton = nil
local parentFrame = nil
local currentFontSize = 12
local fontStrings = {}  -- Store references to all font strings for font size updates

-- Initialize statistics
function StatisticsUI:Initialize(parent)
    parentFrame = parent
    -- Load saved font size
    currentFontSize = (HousingDB and HousingDB.fontSize) or 12
end

-- Calculate collection-focused statistics
function StatisticsUI:CalculateStats()
    if not HousingDataManager then
        return nil
    end

    local allItems = HousingDataManager:GetAllItems()

    local stats = {
        total = #allItems,
        collected = 0,
        missing = 0,

        -- By Source with collected/total
        bySource = {
            Achievement = {total = 0, collected = 0, missing = 0, free = 0, goldCost = 0, currencyCost = 0},
            Quest = {total = 0, collected = 0, missing = 0, free = 0, goldCost = 0, currencyCost = 0},
            Drop = {total = 0, collected = 0, missing = 0, free = 0, goldCost = 0, currencyCost = 0},
            Vendor = {total = 0, collected = 0, missing = 0, free = 0, goldCost = 0, currencyCost = 0},
            Profession = {total = 0, collected = 0, missing = 0}
        },

        -- By Expansion with collected/total split by source
        byExpansion = {},

        -- By Category with collected/total split by source
        byCategory = {},

        -- By Faction with collected/total
        byFaction = {
            Horde = {total = 0, collected = 0, missing = 0},
            Alliance = {total = 0, collected = 0, missing = 0},
            Neutral = {total = 0, collected = 0, missing = 0}
        },

        -- By Profession
        byProfession = {},

        -- By Quality/Rarity
        byQuality = {},

        -- Housing inventory stats (from API)
        housingInventory = {
            totalStored = 0,
            totalPlaced = 0,
            itemsWithData = 0
        },

        -- Travel statistics
        travelStats = {
            uniqueLocations = 0,
            locationsByZone = {},
            totalVendors = 0,
            vendorsByExpansion = {}
        },

        -- Price statistics
        totalValue = {gold = 0, items = 0},
        collectedValue = {gold = 0, items = 0},
        missingValue = {gold = 0, items = 0},
        priceRanges = {
            free = {total = 0, collected = 0},
            cheap = {total = 0, collected = 0, min = 1, max = 100},      -- 1-100g
            moderate = {total = 0, collected = 0, min = 101, max = 1000},  -- 101-1000g
            expensive = {total = 0, collected = 0, min = 1001, max = 10000}, -- 1001-10000g
            luxury = {total = 0, collected = 0, min = 10001}               -- 10000g+
        },

        -- Currency statistics
        byCurrency = {},

        -- Most expensive uncollected items
        expensiveMissing = {},

        -- Easy wins (free/cheap uncollected items)
        easyWins = {}
    }
    
    for _, item in ipairs(allItems) do
        local itemID = tonumber(item.itemID)
        local isCollected = false
        
        -- First check: Do we have quantity data showing ownership? (owned = collected)
        local numStored = item._apiNumStored or 0
        local numPlaced = item._apiNumPlaced or 0
        local totalOwned = numStored + numPlaced
        
        if totalOwned > 0 then
            isCollected = true
        elseif itemID and CollectionAPI then
            -- Fallback: Check via CollectionAPI (for items without quantity data yet)
            isCollected = CollectionAPI:IsItemCollected(itemID)
        end
        
        if isCollected then
            stats.collected = stats.collected + 1
        else
            stats.missing = stats.missing + 1
        end
        
        -- Determine source type
        local sourceType = "Vendor"
        if item._isProfessionItem then
            sourceType = "Profession"
        elseif item.achievementRequired and item.achievementRequired ~= "" then
            sourceType = "Achievement"
        elseif item.questRequired and item.questRequired ~= "" then
            sourceType = "Quest"
        elseif item.dropSource and item.dropSource ~= "" then
            sourceType = "Drop"
        end

        -- Update source stats
        local sourceStats = stats.bySource[sourceType]
        if sourceStats then
            sourceStats.total = sourceStats.total + 1
            if isCollected then
                sourceStats.collected = sourceStats.collected + 1
            else
                sourceStats.missing = sourceStats.missing + 1
            end

            -- Count by cost type for this source (only for sources that track cost breakdown)
            if sourceStats.free then
                if item.currency and item.currency ~= "" then
                    sourceStats.currencyCost = sourceStats.currencyCost + 1
                elseif item.price and item.price > 0 then
                    sourceStats.goldCost = sourceStats.goldCost + 1
                else
                    sourceStats.free = sourceStats.free + 1
                end
            end
        end
        
        -- Track by expansion
        local expName = item.expansionName or "Other"
        if not stats.byExpansion[expName] then
            stats.byExpansion[expName] = {
                total = 0, collected = 0, missing = 0,
                bySource = {
                    Achievement = {total = 0, collected = 0},
                    Quest = {total = 0, collected = 0},
                    Drop = {total = 0, collected = 0},
                    Vendor = {total = 0, collected = 0},
                    Profession = {total = 0, collected = 0}
                }
            }
        end
        stats.byExpansion[expName].total = stats.byExpansion[expName].total + 1
        if stats.byExpansion[expName].bySource[sourceType] then
            stats.byExpansion[expName].bySource[sourceType].total = stats.byExpansion[expName].bySource[sourceType].total + 1
        end

        if isCollected then
            stats.byExpansion[expName].collected = stats.byExpansion[expName].collected + 1
            if stats.byExpansion[expName].bySource[sourceType] then
                stats.byExpansion[expName].bySource[sourceType].collected = stats.byExpansion[expName].bySource[sourceType].collected + 1
            end
        else
            stats.byExpansion[expName].missing = stats.byExpansion[expName].missing + 1
        end
        
        -- Track by category
        local catName = item.category or "Uncategorized"
        if not stats.byCategory[catName] then
            stats.byCategory[catName] = {
                total = 0, collected = 0, missing = 0,
                bySource = {
                    Achievement = {total = 0, collected = 0},
                    Quest = {total = 0, collected = 0},
                    Drop = {total = 0, collected = 0},
                    Vendor = {total = 0, collected = 0},
                    Profession = {total = 0, collected = 0}
                }
            }
        end
        stats.byCategory[catName].total = stats.byCategory[catName].total + 1
        if stats.byCategory[catName].bySource[sourceType] then
            stats.byCategory[catName].bySource[sourceType].total = stats.byCategory[catName].bySource[sourceType].total + 1
        end

        if isCollected then
            stats.byCategory[catName].collected = stats.byCategory[catName].collected + 1
            if stats.byCategory[catName].bySource[sourceType] then
                stats.byCategory[catName].bySource[sourceType].collected = stats.byCategory[catName].bySource[sourceType].collected + 1
            end
        else
            stats.byCategory[catName].missing = stats.byCategory[catName].missing + 1
        end
        
        -- Track by faction
        local faction = item.faction or "Neutral"
        if faction == "Horde" or faction == "Alliance" or faction == "Neutral" then
            local factionStats = stats.byFaction[faction]
            factionStats.total = factionStats.total + 1
            if isCollected then
                factionStats.collected = factionStats.collected + 1
            else
                factionStats.missing = factionStats.missing + 1
            end
        end
        
        -- Track by profession (for profession items)
        if item._isProfessionItem and item.profession then
            local profName = item.profession
            if not stats.byProfession[profName] then
                stats.byProfession[profName] = {total = 0, collected = 0, missing = 0}
            end
            stats.byProfession[profName].total = stats.byProfession[profName].total + 1
            if isCollected then
                stats.byProfession[profName].collected = stats.byProfession[profName].collected + 1
            else
                stats.byProfession[profName].missing = stats.byProfession[profName].missing + 1
            end
        end

        -- Track by quality (from API data)
        if item.quality then
            local qualityName = item.qualityName or "Unknown"
            if not stats.byQuality[qualityName] then
                stats.byQuality[qualityName] = {total = 0, collected = 0, missing = 0, quality = item.quality}
            end
            stats.byQuality[qualityName].total = stats.byQuality[qualityName].total + 1
            if isCollected then
                stats.byQuality[qualityName].collected = stats.byQuality[qualityName].collected + 1
            else
                stats.byQuality[qualityName].missing = stats.byQuality[qualityName].missing + 1
            end
        end

        -- Track housing inventory data (from API)
        if item._apiNumStored or item._apiNumPlaced then
            stats.housingInventory.itemsWithData = stats.housingInventory.itemsWithData + 1
            if item._apiNumStored then
                stats.housingInventory.totalStored = stats.housingInventory.totalStored + (item._apiNumStored or 0)
            end
            if item._apiNumPlaced then
                stats.housingInventory.totalPlaced = stats.housingInventory.totalPlaced + (item._apiNumPlaced or 0)
            end
        end

        -- Track travel statistics (unique vendor locations)
        if item.zoneName and item.zoneName ~= "" then
            local zoneName = item.zoneName

            -- Initialize zone if not exists
            if not stats.travelStats.locationsByZone[zoneName] then
                stats.travelStats.locationsByZone[zoneName] = {
                    locations = {},
                    total = 0,
                    collected = 0,
                    vendors = {}
                }
            end

            -- Track unique locations by vendor name and coordinates
            local locationKey = zoneName
            if item.vendorName and item.vendorName ~= "" then
                locationKey = locationKey .. "_" .. item.vendorName
                -- Track unique vendors
                if not stats.travelStats.locationsByZone[zoneName].vendors[item.vendorName] then
                    stats.travelStats.locationsByZone[zoneName].vendors[item.vendorName] = true
                    stats.travelStats.totalVendors = stats.travelStats.totalVendors + 1
                end
            end
            if item.vendorCoords then
                -- Convert coords to string if it's a table
                local coordsStr = ""
                if type(item.vendorCoords) == "table" then
                    coordsStr = tostring(item.vendorCoords.x or item.vendorCoords[1] or "") .. "_" .. tostring(item.vendorCoords.y or item.vendorCoords[2] or "")
                elseif type(item.vendorCoords) == "string" and item.vendorCoords ~= "" then
                    coordsStr = item.vendorCoords
                end
                if coordsStr ~= "" and coordsStr ~= "_" then
                    locationKey = locationKey .. "_" .. coordsStr
                end
            end

            -- Track unique location (minimal memory footprint)
            if not stats.travelStats.locationsByZone[zoneName].locations[locationKey] then
                stats.travelStats.locationsByZone[zoneName].locations[locationKey] = true
                stats.travelStats.uniqueLocations = stats.travelStats.uniqueLocations + 1
            end

            -- Count total/collected items for this zone
            stats.travelStats.locationsByZone[zoneName].total = stats.travelStats.locationsByZone[zoneName].total + 1
            if isCollected then
                stats.travelStats.locationsByZone[zoneName].collected = stats.travelStats.locationsByZone[zoneName].collected + 1
            end

            -- Track by expansion
            if expName then
                if not stats.travelStats.vendorsByExpansion[expName] then
                    stats.travelStats.vendorsByExpansion[expName] = {
                        zones = {},
                        vendorCount = 0,
                        locationCount = 0
                    }
                end
                if not stats.travelStats.vendorsByExpansion[expName].zones[zoneName] then
                    stats.travelStats.vendorsByExpansion[expName].zones[zoneName] = true
                end
            end
        end

        -- Track by currency type
        if item.currency and item.currency ~= "" then
            local currencyName = item.currency
            if not stats.byCurrency[currencyName] then
                stats.byCurrency[currencyName] = {total = 0, collected = 0, missing = 0}
            end
            stats.byCurrency[currencyName].total = stats.byCurrency[currencyName].total + 1
            if isCollected then
                stats.byCurrency[currencyName].collected = stats.byCurrency[currencyName].collected + 1
            else
                stats.byCurrency[currencyName].missing = stats.byCurrency[currencyName].missing + 1
            end
        end

        -- Track value and price ranges
        local goldValue = (item.price and item.price > 0) and item.price or 0
        if goldValue > 0 then
            stats.totalValue.gold = stats.totalValue.gold + goldValue
            stats.totalValue.items = stats.totalValue.items + 1

            -- Price range tracking
            local priceRange
            if goldValue == 0 then
                priceRange = "free"
            elseif goldValue <= 100 then
                priceRange = "cheap"
            elseif goldValue <= 1000 then
                priceRange = "moderate"
            elseif goldValue <= 10000 then
                priceRange = "expensive"
            else
                priceRange = "luxury"
            end

            if stats.priceRanges[priceRange] then
                stats.priceRanges[priceRange].total = stats.priceRanges[priceRange].total + 1
                if isCollected then
                    stats.priceRanges[priceRange].collected = stats.priceRanges[priceRange].collected + 1
                end
            end

            if isCollected then
                stats.collectedValue.gold = stats.collectedValue.gold + goldValue
                stats.collectedValue.items = stats.collectedValue.items + 1
            else
                stats.missingValue.gold = stats.missingValue.gold + goldValue
                stats.missingValue.items = stats.missingValue.items + 1

                -- Track expensive missing items
                if goldValue >= 100 then
                    table.insert(stats.expensiveMissing, {
                        name = item.name,
                        price = goldValue,
                        source = sourceType,
                        zone = item.zoneName
                    })
                end
            end
        else
            -- Free items
            stats.priceRanges.free.total = stats.priceRanges.free.total + 1
            if isCollected then
                stats.priceRanges.free.collected = stats.priceRanges.free.collected + 1
            end
        end
        
        -- Track easy wins (free or cheap uncollected items)
        if not isCollected then
            if goldValue == 0 or goldValue <= 50 then
                table.insert(stats.easyWins, {
                    name = item.name,
                    price = goldValue,
                    source = sourceType,
                    zone = item.zoneName,
                    currency = item.currency
                })
            end
        end
    end
    
    -- Sort expensive missing items
    table.sort(stats.expensiveMissing, function(a, b) return a.price > b.price end)
    
    -- Sort easy wins by source type, then price
    table.sort(stats.easyWins, function(a, b)
        if a.price == b.price then
            return a.source < b.source
        end
        return a.price < b.price
    end)
    
    return stats
end

-- Helper function to format gold amounts
local function FormatGold(amount)
    if amount >= 10000 then
        return string.format("%.1fk|cFFFFD700g|r", amount / 1000)
    elseif amount >= 1000 then
        return string.format("%.2fk|cFFFFD700g|r", amount / 1000)
    else
        return string.format("%d|cFFFFD700g|r", amount)
    end
end

-- Create a stat card (highlighted metric)
local function CreateStatCard(parent, label, value, color, xOffset, yOffset, width)
    local card = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    card:SetPoint("TOPLEFT", xOffset, yOffset)
    card:SetSize(width or 180, 70)
    card:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    card:SetBackdropColor(color[1] * 0.2, color[2] * 0.2, color[3] * 0.2, 0.6)
    card:SetBackdropBorderColor(color[1], color[2], color[3], 0.8)

    local valueText = card:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    valueText:SetPoint("CENTER", 0, 5)
    local valueFont, valueSize, valueFlags = valueText:GetFont()
    if currentFontSize ~= 12 then
        valueText:SetFont(valueFont, currentFontSize + 8, valueFlags)
    end
    valueText:SetText(value)
    valueText:SetTextColor(color[1], color[2], color[3], 1)
    table.insert(fontStrings, valueText)

    local labelText = card:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    labelText:SetPoint("BOTTOM", 0, 8)
    local labelFont, labelSize, labelFlags = labelText:GetFont()
    if currentFontSize ~= 12 then
        labelText:SetFont(labelFont, currentFontSize - 2, labelFlags)
    end
    labelText:SetText(label)
    labelText:SetTextColor(0.7, 0.7, 0.7, 1)
    table.insert(fontStrings, labelText)

    return card
end

-- Create an enhanced progress bar with gradient
local function CreateProgressBar(parent, label, current, total, xOffset, yOffset, width, color)
    local container = CreateFrame("Frame", nil, parent)
    container:SetPoint("TOPLEFT", xOffset, yOffset)
    container:SetSize(width or 600, 40)

    -- Label
    local labelText = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelText:SetPoint("TOPLEFT", 0, 0)
    local labelFont, labelSize, labelFlags = labelText:GetFont()
    if currentFontSize ~= 12 then
        labelText:SetFont(labelFont, currentFontSize, labelFlags)
    end
    labelText:SetText(label)
    labelText:SetTextColor(1, 1, 1, 1)
    table.insert(fontStrings, labelText)

    -- Percentage text
    local percentage = total > 0 and math.floor((current / total) * 100) or 0
    local percentText = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    percentText:SetPoint("TOPRIGHT", 0, 0)
    local percentFont, percentSize, percentFlags = percentText:GetFont()
    if currentFontSize ~= 12 then
        percentText:SetFont(percentFont, currentFontSize, percentFlags)
    end
    percentText:SetText(string.format("|cFF00FF00%d%%|r (%d/%d)", percentage, current, total))
    table.insert(fontStrings, percentText)

    -- Progress bar background
    local barBg = container:CreateTexture(nil, "BACKGROUND")
    barBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    barBg:SetPoint("TOPLEFT", 0, -20)
    barBg:SetSize(width or 600, 16)
    barBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)

    -- Progress bar fill (only show if there's progress)
    if percentage > 0 then
        local barFill = container:CreateTexture(nil, "ARTWORK")
        barFill:SetTexture("Interface\\Buttons\\WHITE8x8")
        barFill:SetPoint("LEFT", barBg, "LEFT", 0, 0)
        local fillWidth = ((width or 600) * percentage / 100)
        barFill:SetSize(math.max(2, fillWidth), 16)
        barFill:SetVertexColor(color[1], color[2], color[3], 0.9)
    end

    -- Border (thin outline around the bar)
    local borderTop = container:CreateTexture(nil, "OVERLAY")
    borderTop:SetTexture("Interface\\Buttons\\WHITE8x8")
    borderTop:SetPoint("TOPLEFT", barBg, "TOPLEFT", 0, 1)
    borderTop:SetSize(width or 600, 1)
    borderTop:SetVertexColor(0.4, 0.4, 0.4, 1)

    local borderBottom = container:CreateTexture(nil, "OVERLAY")
    borderBottom:SetTexture("Interface\\Buttons\\WHITE8x8")
    borderBottom:SetPoint("BOTTOMLEFT", barBg, "BOTTOMLEFT", 0, -1)
    borderBottom:SetSize(width or 600, 1)
    borderBottom:SetVertexColor(0.4, 0.4, 0.4, 1)

    return container, -45
end

-- Create a horizontal bar graph
local function CreateBarGraph(parent, data, maxValue, yOffset, colorFunc)
    local bars = {}
    local barHeight = 20
    local barSpacing = 5
    local maxWidth = 300
    local currentY = yOffset
    
    -- Sort data by value (descending)
    local sortedData = {}
    for key, value in pairs(data) do
        table.insert(sortedData, {key = key, value = value})
    end
    table.sort(sortedData, function(a, b) return a.value > b.value end)
    
    -- Create bars (limit to top 10)
    for i, entry in ipairs(sortedData) do
        if i > 10 then break end
        
        local barFrame = CreateFrame("Frame", nil, parent)
        barFrame:SetPoint("TOPLEFT", 20, currentY)
        barFrame:SetSize(maxWidth + 150, barHeight)
        
        -- Label
        local label = barFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("LEFT", 0, 0)
        label:SetWidth(140)
        label:SetJustifyH("LEFT")
        local labelFont, labelSize, labelFlags = label:GetFont()
        if currentFontSize ~= 12 then
            label:SetFont(labelFont, currentFontSize, labelFlags)
        end
        label:SetText(entry.key)
        table.insert(fontStrings, label)
        
        -- Bar background
        local barBg = barFrame:CreateTexture(nil, "BACKGROUND")
        barBg:SetTexture("Interface\\Buttons\\WHITE8x8")
        barBg:SetPoint("LEFT", 145, 0)
        barBg:SetSize(maxWidth, barHeight - 5)
        barBg:SetVertexColor(0.1, 0.1, 0.1, 0.5)
        
        -- Bar fill
        local barFill = barFrame:CreateTexture(nil, "ARTWORK")
        barFill:SetTexture("Interface\\Buttons\\WHITE8x8")
        barFill:SetPoint("LEFT", 145, 0)
        local barWidth = math.max(1, (entry.value / maxValue) * maxWidth)
        barFill:SetSize(barWidth, barHeight - 5)
        
        -- Color the bar
        if colorFunc then
            local r, g, b = colorFunc(entry.key)
            barFill:SetVertexColor(r, g, b, 0.8)
        else
            barFill:SetVertexColor(0.2, 0.6, 1, 0.8)
        end
        
        -- Value text
        local valueText = barFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        valueText:SetPoint("LEFT", 450, 0)
        valueText:SetTextColor(1, 1, 1, 1)
        local valueFont, valueSize, valueFlags = valueText:GetFont()
        if currentFontSize ~= 12 then
            valueText:SetFont(valueFont, currentFontSize, valueFlags)
        end
        valueText:SetText(tostring(entry.value))
        table.insert(fontStrings, valueText)
        
        table.insert(bars, barFrame)
        currentY = currentY - (barHeight + barSpacing)
    end
    
    return bars, currentY
end

-- Create statistics container in main UI
function StatisticsUI:CreateStatsContainer()
    if statsContainer then
        return statsContainer
    end
    
    if not parentFrame then
        return nil
    end
    
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
        StatisticsUI:Hide()
    end)

    -- Title
    local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    title:SetPoint("TOP", 0, -15)
    local titleFont, titleSize, titleFlags = title:GetFont()
    if currentFontSize ~= 12 then
        title:SetFont(titleFont, currentFontSize + 4, titleFlags)
    end
    title:SetText("|cFFFFD700" .. (L["STATS_TITLE"] or "Statistics Dashboard") .. "|r")
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
    
    statsContainer = container
    return container
end

-- Update statistics display
function StatisticsUI:UpdateStats()
    if not statsContainer or not statsContainer.content then
        return
    end

    local content = statsContainer.content

    -- Clear existing content
    for _, child in ipairs({content:GetChildren()}) do
        child:Hide()
        child:SetParent(nil)
    end

    -- Clear font string references to prevent memory leak
    wipe(fontStrings)

    -- Calculate stats
    local stats = self:CalculateStats()
    if not stats then
        return
    end

    local yOffset = -10

    -- Get content width for responsive sizing
    local contentWidth = content:GetWidth() or 1000
    local maxBarWidth = contentWidth - 40

    -- KEY METRICS STAT CARDS (all in one row)
    local percentage = stats.total > 0 and math.floor((stats.collected / stats.total) * 100) or 0
    local cardWidth = 140
    local cardSpacing = 10
    CreateStatCard(content, L["STATS_COMPLETION"] or "Completion", percentage .. "%", {0, 0.8, 0}, 0, yOffset, cardWidth)
    CreateStatCard(content, L["STATS_COLLECTED"] or "Collected", stats.collected, {0.2, 0.6, 1}, cardWidth + cardSpacing, yOffset, cardWidth)
    CreateStatCard(content, L["STATS_MISSING"] or "Missing", stats.missing, {1, 0.4, 0}, (cardWidth + cardSpacing) * 2, yOffset, cardWidth)
    
    -- Travel stat cards (same row)
    if stats.travelStats.uniqueLocations > 0 then
        local zoneCount = 0
        for _ in pairs(stats.travelStats.locationsByZone) do zoneCount = zoneCount + 1 end
        
        local travelCardWidth = 140
        CreateStatCard(content, L["STATS_ZONES_TO_VISIT"] or "Zones to Visit", zoneCount, {1, 0.5, 0}, (cardWidth + cardSpacing) * 3, yOffset, travelCardWidth)
        CreateStatCard(content, L["STATS_UNIQUE_LOCATIONS"] or "Unique Locations", stats.travelStats.uniqueLocations, {1, 0.65, 0}, (cardWidth + cardSpacing) * 3 + travelCardWidth + cardSpacing, yOffset, travelCardWidth)
        CreateStatCard(content, L["STATS_TOTAL_VENDORS"] or "Total Vendors", stats.travelStats.totalVendors, {1, 0.8, 0.2}, (cardWidth + cardSpacing) * 3 + (travelCardWidth + cardSpacing) * 2, yOffset, travelCardWidth)
    end

    yOffset = yOffset - 90

    -- MAIN PROGRESS BAR
    local sectionTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    sectionTitle:SetPoint("TOPLEFT", 0, yOffset)
    local titleFont, titleSize, titleFlags = sectionTitle:GetFont()
    if currentFontSize ~= 12 then
        sectionTitle:SetFont(titleFont, currentFontSize + 4, titleFlags)
    end
    sectionTitle:SetText("|cFFFFD700" .. (L["STATS_COLLECTION_OVERVIEW"] or "Collection Overview") .. "|r")
    table.insert(fontStrings, sectionTitle)
    yOffset = yOffset - 35

    CreateProgressBar(content, L["STATS_OVERALL_PROGRESS"] or "Overall Progress", stats.collected, stats.total, 20, yOffset, maxBarWidth, {0, 0.8, 0})
    yOffset = yOffset - 60
    
    -- ITEMS BY SOURCE (Enhanced with collection progress)
    local sourceTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    sourceTitle:SetPoint("TOPLEFT", 0, yOffset)
    local sourceFont, _, sourceFlags = sourceTitle:GetFont()
    if currentFontSize ~= 12 then
        sourceTitle:SetFont(sourceFont, currentFontSize + 2, sourceFlags)
    end
    sourceTitle:SetText("|cFFFFD700" .. (L["STATS_ITEMS_BY_SOURCE"] or "Items by Source") .. "|r")
    table.insert(fontStrings, sourceTitle)
    yOffset = yOffset - 35

    -- Source breakdown with progress bars
    local sourceOrder = {"Vendor", "Achievement", "Quest", "Drop", "Profession"}
    local sourceColors = {
        Vendor = {0.196, 0.804, 0.196},
        Achievement = {1, 0.843, 0},
        Quest = {0.118, 0.565, 1},
        Drop = {1, 0.271, 0},
        Profession = {0.8, 0.4, 1}
    }

    for _, sourceName in ipairs(sourceOrder) do
        local sourceData = stats.bySource[sourceName]
        if sourceData and sourceData.total > 0 then
            CreateProgressBar(content, sourceName, sourceData.collected, sourceData.total, 20, yOffset, maxBarWidth * 0.5, sourceColors[sourceName])
            yOffset = yOffset - 50
        end
    end

    yOffset = yOffset - 20
    
    -- Items by Faction
    local factionTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    factionTitle:SetPoint("TOPLEFT", 0, yOffset)
    local factionFont, factionSize, factionFlags = factionTitle:GetFont()
    if currentFontSize ~= 12 then
        factionTitle:SetFont(factionFont, currentFontSize + 2, factionFlags)
    end
    factionTitle:SetText("|cFFFFD700" .. (L["STATS_ITEMS_BY_FACTION"] or "Items by Faction") .. "|r")
    table.insert(fontStrings, factionTitle)
    yOffset = yOffset - 30
    
    local maxFaction = math.max(
        stats.byFaction.Horde.total or 0,
        stats.byFaction.Alliance.total or 0,
        stats.byFaction.Neutral.total or 0
    )
    -- Transform byFaction to simple key-value pairs for CreateBarGraph
    local byFactionSimple = {
        Horde = stats.byFaction.Horde.total,
        Alliance = stats.byFaction.Alliance.total,
        Neutral = stats.byFaction.Neutral.total
    }
    local factionColorFunc = function(key)
        if key == "Horde" then return 1, 0, 0
        elseif key == "Alliance" then return 0, 0.4, 1
        else return 0.7, 0.7, 0.7 end
    end
    local _, newY2 = CreateBarGraph(content, byFactionSimple, maxFaction, yOffset, factionColorFunc)
    yOffset = newY2 - 40
    
    -- Items by Expansion (with collection progress)
    local expTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    expTitle:SetPoint("TOPLEFT", 0, yOffset)
    local expTitleFont, expTitleSize, expTitleFlags = expTitle:GetFont()
    if currentFontSize ~= 12 then
        expTitle:SetFont(expTitleFont, currentFontSize + 2, expTitleFlags)
    end
    expTitle:SetText("|cFFFFD700" .. (L["STATS_COLLECTION_BY_EXPANSION"] or "Collection by Expansion") .. "|r")
    table.insert(fontStrings, expTitle)
    yOffset = yOffset - 30
    
    -- Create expansion collection bars
    local expData = {}
    for expName, expStats in pairs(stats.byExpansion) do
        table.insert(expData, {
            name = expName,
            collected = expStats.collected,
            total = expStats.total,
            percent = expStats.total > 0 and math.floor((expStats.collected / expStats.total) * 100) or 0
        })
    end
    table.sort(expData, function(a, b) return a.total > b.total end)
    
    for i, exp in ipairs(expData) do
        if i > 10 then break end
        
        local expBar = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        expBar:SetPoint("TOPLEFT", 20, yOffset)
        local expBarFont, expBarSize, expBarFlags = expBar:GetFont()
        if currentFontSize ~= 12 then
            expBar:SetFont(expBarFont, currentFontSize, expBarFlags)
        end
        expBar:SetText(string.format("|cFFFFFFFF%s:|r |cFF00FF00%d%%|r (%d/%d)", 
            exp.name, exp.percent, exp.collected, exp.total))
        table.insert(fontStrings, expBar)
        yOffset = yOffset - 20
    end
    
    yOffset = yOffset - 30
    
    -- Items by Category (with collection progress)
    local catTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    catTitle:SetPoint("TOPLEFT", 0, yOffset)
    local catTitleFont, catTitleSize, catTitleFlags = catTitle:GetFont()
    if currentFontSize ~= 12 then
        catTitle:SetFont(catTitleFont, currentFontSize + 2, catTitleFlags)
    end
    catTitle:SetText("|cFFFFD700" .. (L["STATS_COLLECTION_BY_CATEGORY"] or "Collection by Category") .. "|r")
    table.insert(fontStrings, catTitle)
    yOffset = yOffset - 30
    
    -- Create category collection bars
    local catData = {}
    for catName, catStats in pairs(stats.byCategory) do
        table.insert(catData, {
            name = catName,
            collected = catStats.collected,
            total = catStats.total,
            percent = catStats.total > 0 and math.floor((catStats.collected / catStats.total) * 100) or 0
        })
    end
    table.sort(catData, function(a, b) return a.total > b.total end)
    
    for i, cat in ipairs(catData) do
        if i > 10 then break end

        local catBar = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        catBar:SetPoint("TOPLEFT", 20, yOffset)
        local catBarFont, _, catBarFlags = catBar:GetFont()
        if currentFontSize ~= 12 then
            catBar:SetFont(catBarFont, currentFontSize, catBarFlags)
        end
        catBar:SetText(string.format("|cFFFFFFFF%s:|r |cFF00FF00%d%%|r (%d/%d)",
            cat.name, cat.percent, cat.collected, cat.total))
        table.insert(fontStrings, catBar)
        yOffset = yOffset - 20
    end

    yOffset = yOffset - 30

    -- PROFESSION ITEMS (if any)
    local profCount = 0
    for _ in pairs(stats.byProfession) do profCount = profCount + 1 end
    if profCount > 0 then
        local profTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        profTitle:SetPoint("TOPLEFT", 0, yOffset)
        local profFont, _, profFlags = profTitle:GetFont()
        if currentFontSize ~= 12 then
            profTitle:SetFont(profFont, currentFontSize + 2, profFlags)
        end
        profTitle:SetText("|cFFFFD700" .. (L["STATS_CRAFTED_BY_PROFESSION"] or "Crafted Items by Profession") .. "|r")
        table.insert(fontStrings, profTitle)
        yOffset = yOffset - 35

        local profData = {}
        for profName, profStats in pairs(stats.byProfession) do
            table.insert(profData, {
                name = profName,
                collected = profStats.collected,
                total = profStats.total,
                percent = profStats.total > 0 and math.floor((profStats.collected / profStats.total) * 100) or 0
            })
        end
        table.sort(profData, function(a, b) return a.total > b.total end)

        for _, prof in ipairs(profData) do
            CreateProgressBar(content, prof.name, prof.collected, prof.total, 20, yOffset, maxBarWidth * 0.5, {0.8, 0.4, 1})
            yOffset = yOffset - 50
        end

        yOffset = yOffset - 20
    end

    -- PRICE RANGE BREAKDOWN
    local priceTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    priceTitle:SetPoint("TOPLEFT", 0, yOffset)
    local priceFont, _, priceFlags = priceTitle:GetFont()
    if currentFontSize ~= 12 then
        priceTitle:SetFont(priceFont, currentFontSize + 2, priceFlags)
    end
    priceTitle:SetText("|cFFFFD700Items by Price Range|r")
    table.insert(fontStrings, priceTitle)
    yOffset = yOffset - 35

    local priceRangeOrder = {
        {key = "free", label = "Free", color = {0, 1, 0}},
        {key = "cheap", label = "Cheap (1-100g)", color = {0.2, 0.8, 0.2}},
        {key = "moderate", label = "Moderate (101-1kg)", color = {1, 0.843, 0}},
        {key = "expensive", label = "Expensive (1k-10kg)", color = {1, 0.5, 0}},
        {key = "luxury", label = "Luxury (10kg+)", color = {1, 0.2, 0.2}}
    }

    for _, range in ipairs(priceRangeOrder) do
        local rangeData = stats.priceRanges[range.key]
        if rangeData and rangeData.total > 0 then
            CreateProgressBar(content, range.label, rangeData.collected, rangeData.total, 20, yOffset, maxBarWidth * 0.5, range.color)
            yOffset = yOffset - 50
        end
    end

    yOffset = yOffset - 20

    -- ITEM QUALITY BREAKDOWN (if available)
    local qualityCount = 0
    for _ in pairs(stats.byQuality) do qualityCount = qualityCount + 1 end
    if qualityCount > 0 then
        local qualityTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        qualityTitle:SetPoint("TOPLEFT", 0, yOffset)
        local qualityFont, _, qualityFlags = qualityTitle:GetFont()
        if currentFontSize ~= 12 then
            qualityTitle:SetFont(qualityFont, currentFontSize + 2, qualityFlags)
        end
        qualityTitle:SetText("|cFFFFD700Items by Quality|r")
        table.insert(fontStrings, qualityTitle)
        yOffset = yOffset - 35

        local qualityData = {}
        for qualityName, qualityStats in pairs(stats.byQuality) do
            table.insert(qualityData, {
                name = qualityName,
                collected = qualityStats.collected,
                total = qualityStats.total,
                quality = qualityStats.quality or 0
            })
        end
        table.sort(qualityData, function(a, b) return a.quality > b.quality end)

        -- Quality colors based on WoW item quality
        local qualityColors = {
            [0] = {0.62, 0.62, 0.62}, -- Poor (gray)
            [1] = {1, 1, 1},           -- Common (white)
            [2] = {0.12, 1, 0},        -- Uncommon (green)
            [3] = {0, 0.44, 0.87},     -- Rare (blue)
            [4] = {0.64, 0.21, 0.93},  -- Epic (purple)
            [5] = {1, 0.5, 0},         -- Legendary (orange)
            [6] = {0.9, 0.8, 0.5},     -- Artifact (gold)
            [7] = {0, 0.8, 1}          -- Heirloom (cyan)
        }

        for _, quality in ipairs(qualityData) do
            local color = qualityColors[quality.quality] or {0.7, 0.7, 0.7}
            CreateProgressBar(content, quality.name, quality.collected, quality.total, 20, yOffset, maxBarWidth * 0.5, color)
            yOffset = yOffset - 50
        end

        yOffset = yOffset - 20
    end

    -- HOUSING INVENTORY STATS (if API data available)
    if stats.housingInventory.itemsWithData > 0 then
        local inventoryTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        inventoryTitle:SetPoint("TOPLEFT", 0, yOffset)
        local inventoryFont, _, inventoryFlags = inventoryTitle:GetFont()
        if currentFontSize ~= 12 then
            inventoryTitle:SetFont(inventoryFont, currentFontSize + 2, inventoryFlags)
        end
        inventoryTitle:SetText("|cFFFFD700Your Housing Inventory|r")
        table.insert(fontStrings, inventoryTitle)
        yOffset = yOffset - 30

        local inventoryInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        inventoryInfo:SetPoint("TOPLEFT", 20, yOffset)
        inventoryInfo:SetWidth(maxBarWidth - 40)
        inventoryInfo:SetJustifyH("LEFT")
        local inventoryInfoFont, _, inventoryInfoFlags = inventoryInfo:GetFont()
        if currentFontSize ~= 12 then
            inventoryInfo:SetFont(inventoryInfoFont, currentFontSize, inventoryInfoFlags)
        end
        inventoryInfo:SetText(string.format(
            "|cFFFFFFFFTotal Items in Storage:|r |cFF00FF00%d|r\n" ..
            "|cFFFFFFFFTotal Items Placed:|r |cFFFFD700%d|r\n" ..
            "|cFFAAAAAAItems with API data: %d of %d|r",
            stats.housingInventory.totalStored,
            stats.housingInventory.totalPlaced,
            stats.housingInventory.itemsWithData,
            stats.total
        ))
        table.insert(fontStrings, inventoryInfo)
        yOffset = yOffset - 80
    end

    -- TRAVEL STATISTICS (unique vendor locations)
    if stats.travelStats.uniqueLocations > 0 then
        local travelTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        travelTitle:SetPoint("TOPLEFT", 0, yOffset)
        local travelFont, _, travelFlags = travelTitle:GetFont()
        if currentFontSize ~= 12 then
            travelTitle:SetFont(travelFont, currentFontSize + 2, travelFlags)
        end
        travelTitle:SetText("|cFFFFD700Travel Statistics|r")
        table.insert(fontStrings, travelTitle)
        yOffset = yOffset - 30

        -- Count total zones
        local zoneCount = 0
        for _ in pairs(stats.travelStats.locationsByZone) do zoneCount = zoneCount + 1 end

        -- Summary info
        local travelSummary = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        travelSummary:SetPoint("TOPLEFT", 20, yOffset)
        travelSummary:SetWidth(maxBarWidth - 40)
        travelSummary:SetJustifyH("LEFT")
        local travelSummaryFont, _, travelSummaryFlags = travelSummary:GetFont()
        if currentFontSize ~= 12 then
            travelSummary:SetFont(travelSummaryFont, currentFontSize, travelSummaryFlags)
        end
        travelSummary:SetText(string.format(
            "|cFFFFFFFFUnique Vendor Locations:|r |cFF00FF00%d|r\n" ..
            "|cFFFFFFFFZones to Visit:|r |cFFFFD700%d|r\n" ..
            "|cFFFFFFFFTotal Vendors:|r |cFF00D4FF%d|r",
            stats.travelStats.uniqueLocations,
            zoneCount,
            stats.travelStats.totalVendors
        ))
        table.insert(fontStrings, travelSummary)
        yOffset = yOffset - 85

        -- Show zones with most uncollected items
        local travelSubtitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        travelSubtitle:SetPoint("TOPLEFT", 20, yOffset)
        local travelSubFont, _, travelSubFlags = travelSubtitle:GetFont()
        if currentFontSize ~= 12 then
            travelSubtitle:SetFont(travelSubFont, currentFontSize, travelSubFlags)
        end
        travelSubtitle:SetText("|cFFFFFFFFTop Zones by Uncollected Items:|r")
        table.insert(fontStrings, travelSubtitle)
        yOffset = yOffset - 30

        -- Convert zones to array and sort by missing items
        local zoneArray = {}
        for zoneName, zoneData in pairs(stats.travelStats.locationsByZone) do
            local missing = zoneData.total - zoneData.collected
            if missing > 0 then  -- Only show zones with uncollected items
                -- Count unique vendors in this zone
                local vendorCount = 0
                for _ in pairs(zoneData.vendors) do vendorCount = vendorCount + 1 end

                table.insert(zoneArray, {
                    name = zoneName,
                    total = zoneData.total,
                    collected = zoneData.collected,
                    missing = missing,
                    vendorCount = vendorCount
                })
            end
        end
        table.sort(zoneArray, function(a, b) return a.missing > b.missing end)

        -- Display top 10 zones
        for i, zone in ipairs(zoneArray) do
            if i > 10 then break end

            local zoneLabel = string.format("%s (%d vendor%s)",
                zone.name,
                zone.vendorCount,
                zone.vendorCount ~= 1 and "s" or ""
            )

            CreateProgressBar(
                content,
                zoneLabel,
                zone.collected,
                zone.total,
                40,
                yOffset,
                maxBarWidth * 0.5,
                {1, 0.5, 0}  -- Orange color for travel
            )
            yOffset = yOffset - 50
        end

        yOffset = yOffset - 20
    end

    -- CURRENCY TYPES (if any)
    local currencyCount = 0
    for _ in pairs(stats.byCurrency) do currencyCount = currencyCount + 1 end
    if currencyCount > 0 then
        local currencyTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        currencyTitle:SetPoint("TOPLEFT", 0, yOffset)
        local currencyFont, _, currencyFlags = currencyTitle:GetFont()
        if currentFontSize ~= 12 then
            currencyTitle:SetFont(currencyFont, currentFontSize + 2, currencyFlags)
        end
        currencyTitle:SetText("|cFFFFD700Items by Currency|r")
        table.insert(fontStrings, currencyTitle)
        yOffset = yOffset - 35

        local currencyData = {}
        for currencyName, currencyStats in pairs(stats.byCurrency) do
            table.insert(currencyData, {
                name = currencyName,
                collected = currencyStats.collected,
                total = currencyStats.total
            })
        end
        table.sort(currencyData, function(a, b) return a.total > b.total end)

        for i, currency in ipairs(currencyData) do
            if i > 10 then break end
            CreateProgressBar(content, currency.name, currency.collected, currency.total, 20, yOffset, maxBarWidth * 0.5, {0.5, 0.8, 1})
            yOffset = yOffset - 50
        end

        yOffset = yOffset - 20
    end

    -- QUICK WINS SECTION
    if #stats.easyWins > 0 then
        local easyTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        easyTitle:SetPoint("TOPLEFT", 0, yOffset)
        local easyFont, _, easyFlags = easyTitle:GetFont()
        if currentFontSize ~= 12 then
            easyTitle:SetFont(easyFont, currentFontSize + 2, easyFlags)
        end
        easyTitle:SetText("|cFF00FF00Easy Wins|r - Free or Cheap Uncollected Items")
        table.insert(fontStrings, easyTitle)
        yOffset = yOffset - 30

        local easyInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        easyInfo:SetPoint("TOPLEFT", 20, yOffset)
        local easyInfoFont, _, easyInfoFlags = easyInfo:GetFont()
        if currentFontSize ~= 12 then
            easyInfo:SetFont(easyInfoFont, currentFontSize - 1, easyInfoFlags)
        end
        easyInfo:SetText(string.format("|cFFAAAAAA%d items available for 50g or less|r", math.min(15, #stats.easyWins)))
        table.insert(fontStrings, easyInfo)
        yOffset = yOffset - 25

        for i, item in ipairs(stats.easyWins) do
            if i > 15 then break end

            local itemText = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            itemText:SetPoint("TOPLEFT", 40, yOffset)
            itemText:SetWidth(450)
            itemText:SetJustifyH("LEFT")
            local itemFont, _, itemFlags = itemText:GetFont()
            if currentFontSize ~= 12 then
                itemText:SetFont(itemFont, currentFontSize - 1, itemFlags)
            end

            local priceStr = item.price > 0 and FormatGold(item.price) or "|cFF00FF00Free|r"
            itemText:SetText(string.format("• %s - %s |cFF888888(%s)|r", item.name, priceStr, item.source))
            table.insert(fontStrings, itemText)
            yOffset = yOffset - 18
        end

        yOffset = yOffset - 20
    end

    -- Update scroll child size based on content
    content:SetHeight(math.abs(yOffset) + 500)
end

-- Show statistics UI (in main window)
function StatisticsUI:Show()
    if not statsContainer then
        self:CreateStatsContainer()
    end

    if not statsContainer then
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
    self:ApplyFontSize(currentFontSize)

    statsContainer:Show()
end

-- Hide statistics UI (return to item list)
function StatisticsUI:Hide()
    if statsContainer then
        statsContainer:Hide()
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
    if statsContainer and statsContainer:IsVisible() then
        self:Hide()
    else
        self:Show()
    end
end

-- Apply font size to all text elements
function StatisticsUI:ApplyFontSize(fontSize)
    fontSize = fontSize or (HousingDB and HousingDB.fontSize) or 12
    currentFontSize = fontSize
    
    -- If stats are currently displayed, refresh to apply font sizes to new elements
    if statsContainer and statsContainer:IsVisible() then
        self:UpdateStats()
    end
end

-- Make globally accessible
_G["HousingStatisticsUI"] = StatisticsUI

return StatisticsUI

