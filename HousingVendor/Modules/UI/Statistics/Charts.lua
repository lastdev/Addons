-- Statistics Sub-module: Charts/rendering
-- Part of HousingStatisticsUI

local _G = _G
local StatisticsUI = _G["HousingStatisticsUI"]
if not StatisticsUI then return end

local statsContainer = nil
local currentFontSize = 12
local fontStrings = StatisticsUI._fontStrings or {}
StatisticsUI._fontStrings = fontStrings

local function AttachTooltip(frame, title, linesOrFn)
    if not frame then return end
    frame:EnableMouse(true)

    frame:SetScript("OnEnter", function(self)
        if not _G.GameTooltip then return end
        _G.GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if title and title ~= "" then
            _G.GameTooltip:SetText(title, 1, 0.82, 0, true)
        else
            _G.GameTooltip:SetText("", 1, 1, 1, true)
        end

        local lines = linesOrFn
        if type(linesOrFn) == "function" then
            local ok, result = pcall(linesOrFn, self)
            if ok then
                lines = result
            else
                lines = nil
            end
        end

        if type(lines) == "table" then
            for _, line in ipairs(lines) do
                if type(line) == "table" then
                    _G.GameTooltip:AddDoubleLine(
                        tostring(line[1] or ""),
                        tostring(line[2] or ""),
                        1, 1, 1,
                        0.8, 0.8, 0.8
                    )
                else
                    _G.GameTooltip:AddLine(tostring(line), 0.9, 0.9, 0.9, true)
                end
            end
        elseif type(lines) == "string" and lines ~= "" then
            _G.GameTooltip:AddLine(lines, 0.9, 0.9, 0.9, true)
        end

        _G.GameTooltip:Show()
    end)

    frame:SetScript("OnLeave", function()
        if _G.GameTooltip then
            _G.GameTooltip:Hide()
        end
    end)
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
local function CreateStatCard(parent, label, value, color, xOffset, yOffset, width, tooltipTitle, tooltipLinesOrFn)
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

    if tooltipTitle or tooltipLinesOrFn then
        AttachTooltip(card, tooltipTitle or label, tooltipLinesOrFn)
    end

    return card
end

-- Create an enhanced progress bar with gradient
local function CreateProgressBar(parent, label, current, total, xOffset, yOffset, width, color, tooltipTitle, tooltipLinesOrFn)
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

    if tooltipTitle or tooltipLinesOrFn then
        AttachTooltip(container, tooltipTitle or label, tooltipLinesOrFn)
    end

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


-- Update statistics display
function StatisticsUI:UpdateStats()
    statsContainer = self._statsContainer
    currentFontSize = self._currentFontSize or 12
    fontStrings = self._fontStrings or fontStrings or {}
    self._fontStrings = fontStrings
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
    CreateStatCard(content, "Completion", percentage .. "%", {0, 0.8, 0}, 0, yOffset, cardWidth, "Completion", {
        "Percent collected across all known housing items.",
        {"Collected", string.format("%d / %d", stats.collected, stats.total)},
        "Collected = owned (>0 stored+placed) or via collection fallback.",
    })
    CreateStatCard(content, "Collected", stats.collected, {0.2, 0.6, 1}, cardWidth + cardSpacing, yOffset, cardWidth, "Collected Items", {
        "Items you currently own (stored+placed), with fallback to collection check.",
        {"Count", tostring(stats.collected)},
    })
    CreateStatCard(content, "Missing", stats.missing, {1, 0.4, 0}, (cardWidth + cardSpacing) * 2, yOffset, cardWidth, "Missing Items", {
        "Items not currently owned (stored+placed=0 and not collected by fallback).",
        {"Count", tostring(stats.missing)},
        {"Ready to Collect", tostring(stats.readyMissing or 0)},
    })
    
    -- Travel stat cards (same row)
    if stats.travelStats.uniqueLocations > 0 then
        local zoneCount = 0
        for _ in pairs(stats.travelStats.locationsByZone) do zoneCount = zoneCount + 1 end
        
        local travelCardWidth = 140
        CreateStatCard(content, "Zones to Visit", zoneCount, {1, 0.5, 0}, (cardWidth + cardSpacing) * 3, yOffset, travelCardWidth, "Zones to Visit", {
            "Zones that have at least one vendor/location entry in the data set.",
            {"Zones", tostring(zoneCount)},
        })
        CreateStatCard(content, "Unique Locations", stats.travelStats.uniqueLocations, {1, 0.65, 0}, (cardWidth + cardSpacing) * 3 + travelCardWidth + cardSpacing, yOffset, travelCardWidth, "Unique Locations", {
            "Unique vendor location keys (zone + vendor + coords when available).",
            {"Locations", tostring(stats.travelStats.uniqueLocations)},
        })
        CreateStatCard(content, "Total Vendors", stats.travelStats.totalVendors, {1, 0.8, 0.2}, (cardWidth + cardSpacing) * 3 + (travelCardWidth + cardSpacing) * 2, yOffset, travelCardWidth, "Total Vendors", {
            "Unique vendor names encountered while scanning items.",
            {"Vendors", tostring(stats.travelStats.totalVendors)},
        })
    end

    yOffset = yOffset - 90

    -- MAIN PROGRESS BAR
    local sectionTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    sectionTitle:SetPoint("TOPLEFT", 0, yOffset)
    local titleFont, titleSize, titleFlags = sectionTitle:GetFont()
    if currentFontSize ~= 12 then
        sectionTitle:SetFont(titleFont, currentFontSize + 4, titleFlags)
    end
    sectionTitle:SetText("|cFFFFD700Collection Overview|r")
    table.insert(fontStrings, sectionTitle)
    yOffset = yOffset - 35

    CreateProgressBar(content, "Overall Progress", stats.collected, stats.total, 20, yOffset, maxBarWidth, {0, 0.8, 0}, "Overall Progress", {
        "Collection progress across all known housing items.",
        {"Collected", string.format("%d / %d", stats.collected, stats.total)},
    })
    yOffset = yOffset - 60

    -- READY TO COLLECT (unlocked but missing)
    if stats.missing and stats.missing > 0 and stats.readyMissing and stats.readyMissing > 0 then
        CreateProgressBar(content, "Ready to Collect (Unlocked)", stats.readyMissing, stats.missing, 20, yOffset, maxBarWidth * 0.6, {0, 0.85, 0.8}, "Ready to Collect (Unlocked)", {
            "Missing items whose requirements are already completed.",
            {"Ready", string.format("%d / %d missing", stats.readyMissing, stats.missing)},
            {"From Achievements", tostring((stats.readyBy and stats.readyBy.Achievement) or 0)},
            {"From Quests", tostring((stats.readyBy and stats.readyBy.Quest) or 0)},
        })
        yOffset = yOffset - 55

        if stats.readyItems and #stats.readyItems > 0 then
            local readyTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            readyTitle:SetPoint("TOPLEFT", 20, yOffset)
            local readyFont, _, readyFlags = readyTitle:GetFont()
            if currentFontSize ~= 12 then
                readyTitle:SetFont(readyFont, currentFontSize, readyFlags)
            end
            readyTitle:SetText("|cFFFFFFFFExamples (Unlocked but Uncollected):|r")
            table.insert(fontStrings, readyTitle)
            yOffset = yOffset - 25

            for i, item in ipairs(stats.readyItems) do
                if i > 12 then break end
                if item and item.name then
                    local itemText = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                    itemText:SetPoint("TOPLEFT", 40, yOffset)
                    itemText:SetWidth(520)
                    itemText:SetJustifyH("LEFT")
                    local itemFont, _, itemFlags = itemText:GetFont()
                    if currentFontSize ~= 12 then
                        itemText:SetFont(itemFont, currentFontSize - 1, itemFlags)
                    end

                    local costStr = nil
                    if item.currency and item.currency ~= "" then
                        costStr = item.currency
                    elseif item.price and item.price > 0 then
                        costStr = FormatGold(item.price)
                    else
                        costStr = "|cFF00FF00Free|r"
                    end

                    local zoneStr = (item.zone and item.zone ~= "") and (" |cFF888888(" .. item.zone .. ")|r") or ""
                    local reasonStr = item.reason or "Unlocked"
                    if item.achievementDate and type(item.achievementDate) == "string" and item.achievementDate ~= "" then
                        reasonStr = reasonStr .. " " .. item.achievementDate
                    end
                    itemText:SetText(string.format("- %s - %s |cFF888888(%s, %s)|r%s", item.name, costStr, item.source or "Unknown", reasonStr, zoneStr))
                    table.insert(fontStrings, itemText)
                    yOffset = yOffset - 18
                end
            end

            yOffset = yOffset - 15
        end
    end

    -- ACHIEVEMENT TRACKING SECTION
    if stats.achievementStats.totalAchievements > 0 then
        local achTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        achTitle:SetPoint("TOPLEFT", 0, yOffset)
        local achTitleFont, _, achTitleFlags = achTitle:GetFont()
        if currentFontSize ~= 12 then
            achTitle:SetFont(achTitleFont, currentFontSize + 2, achTitleFlags)
        end
        achTitle:SetText("|cFFFFD700Achievement Tracking|r")
        table.insert(fontStrings, achTitle)
        yOffset = yOffset - 35

        -- Achievement stat cards
        local achCardWidth = 160
        local achCardSpacing = 10
        CreateStatCard(content, "Total Achievements", stats.achievementStats.totalAchievements, {1, 0.843, 0}, 0, yOffset, achCardWidth, "Total Achievements", {
            "Unique achievement IDs referenced by housing items.",
            {"Achievements", tostring(stats.achievementStats.totalAchievements)},
        })
        CreateStatCard(content, "Completed", stats.achievementStats.achievementsCompleted, {0, 0.8, 0}, achCardWidth + achCardSpacing, yOffset, achCardWidth, "Completed Achievements", {
            "Completed achievements (via achievement API).",
            {"Completed", tostring(stats.achievementStats.achievementsCompleted)},
        })
        CreateStatCard(content, "Incomplete", stats.achievementStats.achievementsIncomplete, {1, 0.4, 0}, (achCardWidth + achCardSpacing) * 2, yOffset, achCardWidth, "Incomplete Achievements", {
            "Incomplete achievements (via achievement API).",
            {"Incomplete", tostring(stats.achievementStats.achievementsIncomplete)},
        })
        CreateStatCard(content, "Achievement Points", stats.achievementStats.earnedPoints .. "/" .. stats.achievementStats.totalPoints, {0.64, 0.21, 0.93}, (achCardWidth + achCardSpacing) * 3, yOffset, achCardWidth, "Achievement Points", {
            "Points from the referenced achievements (earned/total).",
            {"Points", string.format("%d / %d", stats.achievementStats.earnedPoints, stats.achievementStats.totalPoints)},
        })

        yOffset = yOffset - 85

        -- Achievement progress bar
        CreateProgressBar(content, "Achievement Completion", stats.achievementStats.achievementsCompleted, stats.achievementStats.totalAchievements, 20, yOffset, maxBarWidth * 0.6, {1, 0.843, 0}, "Achievement Completion", {
            "How many of the referenced achievements you have completed.",
            {"Completed", string.format("%d / %d", stats.achievementStats.achievementsCompleted, stats.achievementStats.totalAchievements)},
        })
        yOffset = yOffset - 55

        -- Achievement points progress
        CreateProgressBar(content, "Achievement Points Earned", stats.achievementStats.earnedPoints, stats.achievementStats.totalPoints, 20, yOffset, maxBarWidth * 0.6, {0.64, 0.21, 0.93}, "Achievement Points Earned", {
            "Achievement points earned from the referenced achievements.",
            {"Points", string.format("%d / %d", stats.achievementStats.earnedPoints, stats.achievementStats.totalPoints)},
        })
        yOffset = yOffset - 55

        -- Items from achievements info
        local achItemInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        achItemInfo:SetPoint("TOPLEFT", 20, yOffset)
        local achItemFont, _, achItemFlags = achItemInfo:GetFont()
        if currentFontSize ~= 12 then
            achItemInfo:SetFont(achItemFont, currentFontSize, achItemFlags)
        end
        achItemInfo:SetText(string.format("|cFFFFFFFFTotal Housing Items from Achievements:|r |cFFFFD700%d|r", stats.achievementStats.itemsFromAchievements))
        table.insert(fontStrings, achItemInfo)
        yOffset = yOffset - 30

        -- Achievement breakdown by expansion (if available)
        local expCount = 0
        for _ in pairs(stats.achievementStats.byExpansion) do expCount = expCount + 1 end
        if expCount > 0 then
            local achExpTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            achExpTitle:SetPoint("TOPLEFT", 20, yOffset)
            local achExpFont, _, achExpFlags = achExpTitle:GetFont()
            if currentFontSize ~= 12 then
                achExpTitle:SetFont(achExpFont, currentFontSize, achExpFlags)
            end
            achExpTitle:SetText("|cFFFFFFFFAchievements by Expansion:|r")
            table.insert(fontStrings, achExpTitle)
            yOffset = yOffset - 25

            -- Sort and display expansions
            local achExpData = {}
            for expName, expStats in pairs(stats.achievementStats.byExpansion) do
                table.insert(achExpData, {
                    name = expName,
                    total = expStats.total,
                    completed = expStats.completed,
                    points = expStats.points,
                    earnedPoints = expStats.earnedPoints
                })
            end
            table.sort(achExpData, function(a, b) return a.total > b.total end)

            for i, exp in ipairs(achExpData) do
                if i > 10 then break end
                local percent = exp.total > 0 and math.floor((exp.completed / exp.total) * 100) or 0
                local expText = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                expText:SetPoint("TOPLEFT", 40, yOffset)
                local expFont, _, expFlags = expText:GetFont()
                if currentFontSize ~= 12 then
                    expText:SetFont(expFont, currentFontSize - 1, expFlags)
                end
                expText:SetText(string.format("- %s: |cFF00FF00%d%%|r (%d/%d) - |cFFFFD700%dpts|r", 
                    exp.name, percent, exp.completed, exp.total, exp.earnedPoints))
                table.insert(fontStrings, expText)
                yOffset = yOffset - 18
            end
        end

        yOffset = yOffset - 30
    end

    -- QUEST TRACKING SECTION
    if stats.questStats.totalQuests > 0 then
        local questTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        questTitle:SetPoint("TOPLEFT", 0, yOffset)
        local questTitleFont, _, questTitleFlags = questTitle:GetFont()
        if currentFontSize ~= 12 then
            questTitle:SetFont(questTitleFont, currentFontSize + 2, questTitleFlags)
        end
        questTitle:SetText("|cFFFFD700Quest Tracking|r")
        table.insert(fontStrings, questTitle)
        yOffset = yOffset - 35

        -- Quest stat cards
        local questCardWidth = 160
        local questCardSpacing = 10
        CreateStatCard(content, "Total Quests", stats.questStats.totalQuests, {0.118, 0.565, 1}, 0, yOffset, questCardWidth, "Total Quests", {
            "Unique quest IDs referenced by housing items.",
            {"Quests", tostring(stats.questStats.totalQuests)},
        })
        CreateStatCard(content, "Completed", stats.questStats.questsCompleted, {0, 0.8, 0}, questCardWidth + questCardSpacing, yOffset, questCardWidth, "Completed Quests", {
            "Completed quests (via quest completion API).",
            {"Completed", tostring(stats.questStats.questsCompleted)},
        })
        CreateStatCard(content, "Incomplete", stats.questStats.questsIncomplete, {1, 0.4, 0}, (questCardWidth + questCardSpacing) * 2, yOffset, questCardWidth, "Incomplete Quests", {
            "Incomplete quests (via quest completion API).",
            {"Incomplete", tostring(stats.questStats.questsIncomplete)},
        })

        yOffset = yOffset - 85

        -- Quest progress bar
        CreateProgressBar(content, "Quest Completion", stats.questStats.questsCompleted, stats.questStats.totalQuests, 20, yOffset, maxBarWidth * 0.6, {0.118, 0.565, 1}, "Quest Completion", {
            "How many of the referenced quests you have completed.",
            {"Completed", string.format("%d / %d", stats.questStats.questsCompleted, stats.questStats.totalQuests)},
        })
        yOffset = yOffset - 55

        -- Items from quests info
        local questItemInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        questItemInfo:SetPoint("TOPLEFT", 20, yOffset)
        local questItemFont, _, questItemFlags = questItemInfo:GetFont()
        if currentFontSize ~= 12 then
            questItemInfo:SetFont(questItemFont, currentFontSize, questItemFlags)
        end
        questItemInfo:SetText(string.format("|cFFFFFFFFTotal Housing Items from Quests:|r |cFF00D4FF%d|r", stats.questStats.itemsFromQuests))
        table.insert(fontStrings, questItemInfo)
        yOffset = yOffset - 30

        -- Quest breakdown by expansion (if available)
        local questExpCount = 0
        for _ in pairs(stats.questStats.byExpansion) do questExpCount = questExpCount + 1 end
        if questExpCount > 0 then
            local questExpTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            questExpTitle:SetPoint("TOPLEFT", 20, yOffset)
            local questExpFont, _, questExpFlags = questExpTitle:GetFont()
            if currentFontSize ~= 12 then
                questExpTitle:SetFont(questExpFont, currentFontSize, questExpFlags)
            end
            questExpTitle:SetText("|cFFFFFFFFQuests by Expansion:|r")
            table.insert(fontStrings, questExpTitle)
            yOffset = yOffset - 25

            -- Sort and display expansions
            local questExpData = {}
            for expName, expStats in pairs(stats.questStats.byExpansion) do
                table.insert(questExpData, {
                    name = expName,
                    total = expStats.total,
                    completed = expStats.completed
                })
            end
            table.sort(questExpData, function(a, b) return a.total > b.total end)

            for i, exp in ipairs(questExpData) do
                if i > 10 then break end
                local percent = exp.total > 0 and math.floor((exp.completed / exp.total) * 100) or 0
                local expText = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                expText:SetPoint("TOPLEFT", 40, yOffset)
                local expFont, _, expFlags = expText:GetFont()
                if currentFontSize ~= 12 then
                    expText:SetFont(expFont, currentFontSize - 1, expFlags)
                end
                expText:SetText(string.format("- %s: |cFF00FF00%d%%|r (%d/%d)", 
                    exp.name, percent, exp.completed, exp.total))
                table.insert(fontStrings, expText)
                yOffset = yOffset - 18
            end
        end

        yOffset = yOffset - 30
    end
    
    -- ITEMS BY SOURCE (Enhanced with collection progress)
    local sourceTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    sourceTitle:SetPoint("TOPLEFT", 0, yOffset)
    local sourceFont, _, sourceFlags = sourceTitle:GetFont()
    if currentFontSize ~= 12 then
        sourceTitle:SetFont(sourceFont, currentFontSize + 2, sourceFlags)
    end
    sourceTitle:SetText("|cFFFFD700Items by Source|r")
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
        profTitle:SetText("|cFFFFD700Crafted Items by Profession|r")
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
                {1, 0.5, 0},  -- Orange color for travel
                zone.name,
                {
                    {"Uncollected", tostring(zone.missing)},
                    {"Collected", string.format("%d / %d", zone.collected, zone.total)},
                    {"Vendors", tostring(zone.vendorCount)},
                }
            )
            yOffset = yOffset - 50
        end

        -- Show vendors with most uncollected vendor items (vendor items only)
        local vendorArray = {}
        if stats.byVendor then
            for _, vendorData in pairs(stats.byVendor) do
                if vendorData and vendorData.missing and vendorData.missing > 0 and vendorData.total and vendorData.total > 0 then
                    table.insert(vendorArray, vendorData)
                end
            end
        end

        if #vendorArray > 0 then
            table.sort(vendorArray, function(a, b)
                if a.missing == b.missing then
                    return (a.missingValue or 0) > (b.missingValue or 0)
                end
                return a.missing > b.missing
            end)

            local vendorSubtitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            vendorSubtitle:SetPoint("TOPLEFT", 20, yOffset)
            local vendorSubFont, _, vendorSubFlags = vendorSubtitle:GetFont()
            if currentFontSize ~= 12 then
                vendorSubtitle:SetFont(vendorSubFont, currentFontSize, vendorSubFlags)
            end
            vendorSubtitle:SetText("|cFFFFFFFFTop Vendors by Uncollected Vendor Items:|r")
            table.insert(fontStrings, vendorSubtitle)
            yOffset = yOffset - 30

            for i, vendor in ipairs(vendorArray) do
                if i > 10 then break end

                local missingValueStr = ((vendor.missingValue or 0) > 0) and FormatGold(vendor.missingValue) or "|cFF00FF00Free|r"
                local vendorLabel = string.format(
                    "%s (%s) |cFF888888- %d missing (%s)|r",
                    vendor.vendor or "Unknown Vendor",
                    vendor.zone or "Unknown Zone",
                    vendor.missing or 0,
                    missingValueStr
                )

                CreateProgressBar(
                    content,
                    vendorLabel,
                    vendor.collected or 0,
                    vendor.total or 0,
                    40,
                    yOffset,
                    maxBarWidth * 0.7,
                    {0, 0.8, 1},  -- Blue color for vendor section
                    (vendor.vendor or "Vendor") .. " (" .. (vendor.zone or "Zone") .. ")",
                    {
                        {"Uncollected", tostring(vendor.missing or 0)},
                        {"Collected", string.format("%d / %d", vendor.collected or 0, vendor.total or 0)},
                        {"Missing Value", missingValueStr},
                        {"Free Missing", tostring(vendor.freeMissing or 0)},
                        {"Cheap (<=50g)", tostring(vendor.cheapMissing or 0)},
                    }
                )
                yOffset = yOffset - 50
            end
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

            -- Validate item has required fields before displaying
            if item and item.name then
                local itemText = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                itemText:SetPoint("TOPLEFT", 40, yOffset)
                itemText:SetWidth(450)
                itemText:SetJustifyH("LEFT")
                local itemFont, _, itemFlags = itemText:GetFont()
                if currentFontSize ~= 12 then
                    itemText:SetFont(itemFont, currentFontSize - 1, itemFlags)
                end

                local priceStr = (item.price and item.price > 0) and FormatGold(item.price) or "|cFF00FF00Free|r"
                local sourceStr = item.source or "Unknown"
                itemText:SetText(string.format("- %s - %s |cFF888888(%s)|r", item.name, priceStr, sourceStr))
                table.insert(fontStrings, itemText)
                yOffset = yOffset - 18
            end
        end

        yOffset = yOffset - 20
    end

    -- Update scroll child size based on content
    content:SetHeight(math.abs(yOffset) + 500)
end


return StatisticsUI

