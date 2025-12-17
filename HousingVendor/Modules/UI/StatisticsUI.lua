-- Statistics UI Module for HousingVendor addon
-- Detailed stats and graphs about the housing items database

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
            Vendor = {total = 0, collected = 0, missing = 0, free = 0, goldCost = 0, currencyCost = 0}
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
        
        -- Price statistics
        totalValue = {gold = 0, items = 0},
        collectedValue = {gold = 0, items = 0},
        missingValue = {gold = 0, items = 0},
        
        -- Most expensive uncollected items
        expensiveMissing = {},
        
        -- Easy wins (free/cheap uncollected items)
        easyWins = {}
    }
    
    for _, item in ipairs(allItems) do
        local itemID = tonumber(item.itemID)
        local isCollected = false
        if itemID and HousingDataManager then
            isCollected = HousingDataManager:IsItemCollected(itemID)
        end
        
        if isCollected then
            stats.collected = stats.collected + 1
        else
            stats.missing = stats.missing + 1
        end
        
        -- Determine source type
        local sourceType = "Vendor"
        if item.achievementRequired and item.achievementRequired ~= "" then
            sourceType = "Achievement"
        elseif item.questRequired and item.questRequired ~= "" then
            sourceType = "Quest"
        elseif item.dropSource and item.dropSource ~= "" then
            sourceType = "Drop"
        end
        
        -- Update source stats
        local sourceStats = stats.bySource[sourceType]
        sourceStats.total = sourceStats.total + 1
        if isCollected then
            sourceStats.collected = sourceStats.collected + 1
        else
            sourceStats.missing = sourceStats.missing + 1
        end
        
        -- Count by cost type for this source
        if item.currency and item.currency ~= "" then
            sourceStats.currencyCost = sourceStats.currencyCost + 1
        elseif item.price and item.price > 0 then
            sourceStats.goldCost = sourceStats.goldCost + 1
        else
            sourceStats.free = sourceStats.free + 1
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
                    Vendor = {total = 0, collected = 0}
                }
            }
        end
        stats.byExpansion[expName].total = stats.byExpansion[expName].total + 1
        stats.byExpansion[expName].bySource[sourceType].total = stats.byExpansion[expName].bySource[sourceType].total + 1
        
        if isCollected then
            stats.byExpansion[expName].collected = stats.byExpansion[expName].collected + 1
            stats.byExpansion[expName].bySource[sourceType].collected = stats.byExpansion[expName].bySource[sourceType].collected + 1
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
                    Vendor = {total = 0, collected = 0}
                }
            }
        end
        stats.byCategory[catName].total = stats.byCategory[catName].total + 1
        stats.byCategory[catName].bySource[sourceType].total = stats.byCategory[catName].bySource[sourceType].total + 1
        
        if isCollected then
            stats.byCategory[catName].collected = stats.byCategory[catName].collected + 1
            stats.byCategory[catName].bySource[sourceType].collected = stats.byCategory[catName].bySource[sourceType].collected + 1
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
        
        -- Track value
        local goldValue = (item.price and item.price > 0) and item.price or 0
        if goldValue > 0 then
            stats.totalValue.gold = stats.totalValue.gold + goldValue
            stats.totalValue.items = stats.totalValue.items + 1
            
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
    
    -- Back button
    local backBtn = CreateFrame("Button", nil, container, "UIPanelButtonTemplate")
    backBtn:SetSize(100, 30)
    backBtn:SetPoint("TOPLEFT", 10, -10)
    backBtn:SetText("Back")
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
    title:SetText("|cFFFFD700Statistics Dashboard|r")
    table.insert(fontStrings, title)
    
    -- Scroll frame for content
    local scrollFrame = CreateFrame("ScrollFrame", nil, container, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 20, -60)
    scrollFrame:SetPoint("BOTTOMRIGHT", -40, 20)
    
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(1120, 2000)
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
    
    -- Calculate stats
    local stats = self:CalculateStats()
    if not stats then
        return
    end
    
    local yOffset = -10
    
    -- Collection Progress Overview
    local overviewTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    overviewTitle:SetPoint("TOPLEFT", 0, yOffset)
    local overviewFont, overviewSize, overviewFlags = overviewTitle:GetFont()
    if currentFontSize ~= 12 then
        overviewTitle:SetFont(overviewFont, currentFontSize + 4, overviewFlags)
    end
    overviewTitle:SetText("|cFFFFD700Collection Progress|r")
    table.insert(fontStrings, overviewTitle)
    yOffset = yOffset - 35
    
    -- Overall progress
    local percentage = stats.total > 0 and math.floor((stats.collected / stats.total) * 100) or 0
    local progressText = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    progressText:SetPoint("TOPLEFT", 20, yOffset)
    local progressFont, progressSize, progressFlags = progressText:GetFont()
    if currentFontSize ~= 12 then
        progressText:SetFont(progressFont, currentFontSize + 2, progressFlags)
    end
    progressText:SetText(string.format("|cFF00FF00%d%%|r Complete - |cFFFFFFFF%d|r / |cFFFFD700%d|r items collected", 
        percentage, stats.collected, stats.total))
    table.insert(fontStrings, progressText)
    yOffset = yOffset - 30
    
    -- Progress bar
    local progressBar = CreateFrame("Frame", nil, content, "BackdropTemplate")
    progressBar:SetPoint("TOPLEFT", 20, yOffset)
    progressBar:SetSize(600, 25)
    progressBar:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false, edgeSize = 12,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    progressBar:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
    progressBar:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
    
    local progressFill = progressBar:CreateTexture(nil, "ARTWORK")
    progressFill:SetTexture("Interface\\Buttons\\WHITE8x8")
    progressFill:SetPoint("LEFT", 2, 0)
    progressFill:SetSize((596 * percentage / 100), 21)
    progressFill:SetVertexColor(0, 0.8, 0, 0.8)
    
    yOffset = yOffset - 40
    
    -- Items by Source
    local sourceTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    sourceTitle:SetPoint("TOPLEFT", 0, yOffset)
    local sourceFont, sourceSize, sourceFlags = sourceTitle:GetFont()
    if currentFontSize ~= 12 then
        sourceTitle:SetFont(sourceFont, currentFontSize + 2, sourceFlags)
    end
    sourceTitle:SetText("|cFFFFD700Items by Source|r")
    table.insert(fontStrings, sourceTitle)
    yOffset = yOffset - 30
    
    local maxSource = math.max(
        stats.bySource.Achievement.total or 0,
        stats.bySource.Quest.total or 0,
        stats.bySource.Drop.total or 0,
        stats.bySource.Vendor.total or 0
    )
    local sourceColorFunc = function(key)
        if key == "Achievement" then return 1, 0.843, 0
        elseif key == "Quest" then return 0.118, 0.565, 1
        elseif key == "Drop" then return 1, 0.271, 0
        else return 0.196, 0.804, 0.196 end
    end
    -- Transform bySource to simple key-value pairs for CreateBarGraph
    local bySourceSimple = {
        Achievement = stats.bySource.Achievement.total,
        Quest = stats.bySource.Quest.total,
        Drop = stats.bySource.Drop.total,
        Vendor = stats.bySource.Vendor.total
    }
    local _, newY = CreateBarGraph(content, bySourceSimple, maxSource, yOffset, sourceColorFunc)
    yOffset = newY - 40
    
    -- Items by Faction
    local factionTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    factionTitle:SetPoint("TOPLEFT", 0, yOffset)
    local factionFont, factionSize, factionFlags = factionTitle:GetFont()
    if currentFontSize ~= 12 then
        factionTitle:SetFont(factionFont, currentFontSize + 2, factionFlags)
    end
    factionTitle:SetText("|cFFFFD700Items by Faction|r")
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
    expTitle:SetText("|cFFFFD700Collection by Expansion|r")
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
    catTitle:SetText("|cFFFFD700Collection by Category|r")
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
        local catBarFont, catBarSize, catBarFlags = catBar:GetFont()
        if currentFontSize ~= 12 then
            catBar:SetFont(catBarFont, currentFontSize, catBarFlags)
        end
        catBar:SetText(string.format("|cFFFFFFFF%s:|r |cFF00FF00%d%%|r (%d/%d)", 
            cat.name, cat.percent, cat.collected, cat.total))
        table.insert(fontStrings, catBar)
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
    
    -- Hide filters and item list
    if _G["HousingFilterFrame"] then
        _G["HousingFilterFrame"]:Hide()
    end
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:Hide()
    end
    if _G["HousingItemListHeader"] then
        _G["HousingItemListHeader"]:Hide()
    end
    
    -- Update and show stats
    self:UpdateStats()
    -- Apply current font size after update
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

