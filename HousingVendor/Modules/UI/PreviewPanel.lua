local PreviewPanel = {}
PreviewPanel.__index = PreviewPanel

local previewFrame = nil
local currentItem = nil

local tooltipScanner = CreateFrame("GameTooltip", "HousingVendorTooltipScanner", UIParent, "GameTooltipTemplate")
tooltipScanner:SetOwner(UIParent, "ANCHOR_NONE")
function PreviewPanel:ScanTooltipForHousingData(itemID)
    local housingData = {
        weight = nil,
        houseIcon = nil,
        description = nil
    }

    if not itemID or itemID == "" then
        return housingData
    end

    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return housingData
    end

    -- Clear and set tooltip
    tooltipScanner:ClearLines()
    tooltipScanner:SetItemByID(numericItemID)

    for i = 1, tooltipScanner:NumLines() do
        local leftText = _G["HousingVendorTooltipScannerTextLeft" .. i]
        if leftText then
            local text = leftText:GetText()
            if text then
                local weight = string.match(text, "Weight:%s*(%d+)")
                if weight then
                    housingData.weight = tonumber(weight)
                end

                if leftText:GetFont() and string.find(tostring(leftText:GetFont()), "Italic") then
                    if not housingData.description then
                        housingData.description = text
                    end
                end
            end
        end

        local leftTexture = _G["HousingVendorTooltipScannerTexture" .. i]
        if leftTexture and leftTexture:IsShown() then
            local texture = leftTexture:GetTexture()
            if texture then
                housingData.houseIcon = texture
            end
        end
    end

    return housingData
end
function PreviewPanel:GatherAllItemInfo(item)
    local allInfo = {
        custom = {
            name = item.name,
            type = item.type,
            category = item.category,
            vendorName = item.vendorName or item.vendor,
            zoneName = item.zoneName,
            expansionName = item.expansionName,
            vendorCoords = item.vendorCoords,
            price = item.price,
            currency = item.currency,
            achievementRequired = item.achievementRequired,
            questRequired = item.questRequired,
            dropSource = item.dropSource,
            faction = item.faction,
            itemID = item.itemID,
            modelFileID = item.modelFileID,
            thumbnailFileID = item.thumbnailFileID,
            mapID = item.mapID
        },
        itemInfo = nil,
        catalogInfo = nil,
        decorInfo = nil
    }

    allInfo.catalogInfo = nil
    allInfo.decorInfo = nil

    if item.itemID and item.itemID ~= "" then
        local numericItemID = tonumber(item.itemID)
        if numericItemID then
            if C_Item and C_Item.RequestLoadItemDataByID then
                C_Item.RequestLoadItemDataByID(numericItemID)
            end

            if C_Item and C_Item.GetItemInfo then
                local success, info = pcall(function()
                    return C_Item.GetItemInfo(numericItemID)
                end)
                if success and info then
                    allInfo.itemInfo = info
                end
            end
        end
    end

    if allInfo.catalogInfo and type(allInfo.catalogInfo) ~= "table" then
        allInfo.catalogInfo = nil
    end
    if allInfo.decorInfo and type(allInfo.decorInfo) ~= "table" then
        allInfo.decorInfo = nil
    end

    allInfo.housingData = self:ScanTooltipForHousingData(item.itemID)

    return allInfo
end

function PreviewPanel:Initialize(parentFrame)
    self:CreatePreviewSection(parentFrame)
end
function PreviewPanel:CreatePreviewSection(parentFrame)
    previewFrame = CreateFrame("Frame", "HousingPreviewFrame", parentFrame, "BackdropTemplate")
    previewFrame:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -20, -135)
    previewFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -20, 20)
    previewFrame:SetWidth(500)
    
    previewFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    previewFrame:SetBackdropColor(0, 0, 0, 0.8)
    
    -- Header section with icon and name side by side
    local headerFrame = CreateFrame("Frame", nil, previewFrame)
    headerFrame:SetPoint("TOP", 0, -15)
    headerFrame:SetSize(450, 80)
    previewFrame.headerFrame = headerFrame

    -- Item icon (larger, on left)
    local itemIcon = headerFrame:CreateTexture(nil, "ARTWORK")
    itemIcon:SetSize(64, 64)
    itemIcon:SetPoint("LEFT", 10, 0)
    -- Add border to icon
    local iconBorder = headerFrame:CreateTexture(nil, "BORDER")
    iconBorder:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
    iconBorder:SetSize(72, 72)
    iconBorder:SetPoint("CENTER", itemIcon, "CENTER", 0, 0)
    iconBorder:SetVertexColor(0.8, 0.8, 0.8, 1)
    previewFrame.itemIcon = itemIcon
    previewFrame.iconBorder = iconBorder

    -- Item name (to the right of icon, larger font)
    local itemName = headerFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    itemName:SetPoint("LEFT", itemIcon, "RIGHT", 15, 10)
    itemName:SetPoint("RIGHT", -10, 0)
    itemName:SetJustifyH("LEFT")
    itemName:SetJustifyV("TOP")
    itemName:SetWordWrap(true)
    previewFrame.itemName = itemName

    -- Item ID below name (smaller, grayed out)
    local itemIDPreview = headerFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    itemIDPreview:SetPoint("TOPLEFT", itemName, "BOTTOMLEFT", 0, -5)
    itemIDPreview:SetTextColor(0.5, 0.5, 0.5, 1)
    previewFrame.itemIDPreview = itemIDPreview

    local housingIcon = headerFrame:CreateTexture(nil, "ARTWORK")
    housingIcon:SetSize(16, 16)
    housingIcon:SetPoint("LEFT", itemIDPreview, "RIGHT", 5, 0)
    previewFrame.housingIcon = housingIcon
    housingIcon:Hide()

    local waypointBtn = CreateFrame("Button", nil, previewFrame, "UIPanelButtonTemplate")
    waypointBtn:SetSize(200, 30)
    waypointBtn:SetPoint("BOTTOM", 0, 15)
    waypointBtn:SetText("Set Waypoint")
    waypointBtn:SetScript("OnClick", function()
        if currentItem and HousingWaypointManager then
            HousingWaypointManager:SetWaypoint(currentItem)
        end
    end)
    previewFrame.waypointBtn = waypointBtn
    waypointBtn:Hide()

    local detailsScrollFrame = CreateFrame("ScrollFrame", "HousingPreviewDetailsScroll", previewFrame, "UIPanelScrollFrameTemplate")
    detailsScrollFrame:SetPoint("TOP", headerFrame, "BOTTOM", 0, -10)
    detailsScrollFrame:SetPoint("LEFT", 10, 0)
    detailsScrollFrame:SetPoint("RIGHT", -30, 0)
    detailsScrollFrame:SetPoint("BOTTOM", waypointBtn, "TOP", 0, 5)
    
    local detailsFrame = CreateFrame("Frame", nil, detailsScrollFrame)
    detailsFrame:SetWidth(detailsScrollFrame:GetWidth() - 20)
    detailsScrollFrame:SetScrollChild(detailsFrame)
    previewFrame.detailsFrame = detailsFrame
    previewFrame.detailsScrollFrame = detailsScrollFrame

    local yOffset = -10
    local lineHeight = 22
    local sectionSpacing = 15
    local function CreateSectionHeader(parent, text, yPos)
        local header = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        header:SetPoint("TOPLEFT", 5, yPos)
        header:SetText(text)
        header:SetTextColor(1, 0.82, 0, 1)

        local separator = parent:CreateTexture(nil, "ARTWORK")
        separator:SetTexture("Interface\\Buttons\\WHITE8x8")
        separator:SetHeight(1)
        separator:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -3)
        separator:SetPoint("RIGHT", parent, "RIGHT", -10, 0)
        separator:SetVertexColor(0.5, 0.5, 0.5, 0.5)

        return header, separator
    end
    local function CreateDetailLine(parent, label, yPos, isHeader)
        local labelText = parent:CreateFontString(nil, "OVERLAY", isHeader and "GameFontNormalLarge" or "GameFontNormal")
        labelText:SetPoint("TOPLEFT", 10, yPos)
        labelText:SetText(label)
        labelText:SetWidth(110)
        labelText:SetJustifyH("LEFT")
        if isHeader then
            labelText:SetTextColor(1, 0.82, 0, 1)
        else
            labelText:SetTextColor(0.7, 0.7, 0.7, 1)
        end
        return labelText
    end

    local function CreateDetailValue(parent, label, yPos)
        local valueText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        valueText:SetPoint("LEFT", label, "RIGHT", 10, 0)
        valueText:SetPoint("TOP", label, "TOP", 0, 0)
        valueText:SetPoint("RIGHT", parent, "RIGHT", -10, 0)
        valueText:SetJustifyH("LEFT")
        valueText:SetWordWrap(true)
        valueText:SetNonSpaceWrap(false)
        valueText:SetTextColor(1, 1, 1, 1)
        return valueText
    end
    local basicInfoHeader, basicInfoSeparator = CreateSectionHeader(detailsFrame, "Basic Information", yOffset)
    previewFrame.basicInfoHeader = basicInfoHeader
    yOffset = yOffset - 25

    local typeLabel = CreateDetailLine(detailsFrame, "Type:", yOffset, false)
    local typeValue = CreateDetailValue(detailsFrame, typeLabel, yOffset)
    previewFrame.typeValue = typeValue
    yOffset = yOffset - lineHeight

    local categoryLabel = CreateDetailLine(detailsFrame, "Category:", yOffset, false)
    local categoryValue = CreateDetailValue(detailsFrame, categoryLabel, yOffset)
    previewFrame.categoryValue = categoryValue
    yOffset = yOffset - lineHeight

    local weightLabel = CreateDetailLine(detailsFrame, "Weight:", yOffset, false)
    local weightValue = CreateDetailValue(detailsFrame, weightLabel, yOffset)
    weightValue:SetTextColor(0.7, 0.9, 1, 1)
    previewFrame.weightLabel = weightLabel
    previewFrame.weightValue = weightValue
    yOffset = yOffset - lineHeight

    local costLabel = CreateDetailLine(detailsFrame, "Cost:", yOffset, false)
    costLabel:ClearAllPoints()
    costLabel:SetPoint("TOPLEFT", 5, yOffset)
    costLabel:SetWidth(100)
    local costValue = CreateDetailValue(detailsFrame, costLabel, yOffset)
    previewFrame.costValue = costValue
    yOffset = yOffset - lineHeight

    local achievementLabel = CreateDetailLine(detailsFrame, "Achievement:", yOffset, false)
    local achievementValue = CreateDetailValue(detailsFrame, achievementLabel, yOffset)
    achievementValue:SetTextColor(1, 0.5, 0, 1)
    previewFrame.achievementLabel = achievementLabel
    previewFrame.achievementValue = achievementValue
    yOffset = yOffset - lineHeight

    local questLabel = CreateDetailLine(detailsFrame, "Quest:", yOffset, false)
    local questValue = CreateDetailValue(detailsFrame, questLabel, yOffset)
    questValue:SetTextColor(0.5, 0.8, 1, 1)
    previewFrame.questLabel = questLabel
    previewFrame.questValue = questValue
    yOffset = yOffset - lineHeight

    local dropLabel = CreateDetailLine(detailsFrame, "Drops from:", yOffset, false)
    local dropValue = CreateDetailValue(detailsFrame, dropLabel, yOffset)
    dropValue:SetTextColor(0.8, 0.5, 1, 1)
    previewFrame.dropLabel = dropLabel
    previewFrame.dropValue = dropValue
    yOffset = yOffset - lineHeight - sectionSpacing

    local vendorInfoHeader = CreateSectionHeader(detailsFrame, "Vendor & Location", yOffset)
    previewFrame.vendorInfoHeader = vendorInfoHeader
    yOffset = yOffset - 25

    local vendorLabel = CreateDetailLine(detailsFrame, "Vendor:", yOffset, false)
    local vendorValue = CreateDetailValue(detailsFrame, vendorLabel, yOffset)
    previewFrame.vendorValue = vendorValue
    yOffset = yOffset - lineHeight

    local factionLabel = CreateDetailLine(detailsFrame, "Faction:", yOffset, false)
    local factionValue = CreateDetailValue(detailsFrame, factionLabel, yOffset)
    previewFrame.factionValue = factionValue
    yOffset = yOffset - lineHeight

    local zoneLabel = CreateDetailLine(detailsFrame, "Zone:", yOffset, false)
    local zoneValue = CreateDetailValue(detailsFrame, zoneLabel, yOffset)
    previewFrame.zoneValue = zoneValue
    yOffset = yOffset - lineHeight

    local expansionLabel = CreateDetailLine(detailsFrame, "Expansion:", yOffset, false)
    local expansionValue = CreateDetailValue(detailsFrame, expansionLabel, yOffset)
    previewFrame.expansionValue = expansionValue
    yOffset = yOffset - lineHeight

    local coordsLabel = CreateDetailLine(detailsFrame, "Coordinates:", yOffset, false)
    local coordsValue = CreateDetailValue(detailsFrame, coordsLabel, yOffset)
    previewFrame.coordsValue = coordsValue
    yOffset = yOffset - lineHeight

    detailsFrame:SetHeight(math.abs(yOffset) + lineHeight)
    previewFrame:Hide()

    _G["HousingPreviewFrame"] = previewFrame
end
function PreviewPanel:ShowItem(item)
    if not previewFrame then return end

    currentItem = item
    previewFrame:Show()

    local allInfo = self:GatherAllItemInfo(item)

    if allInfo.catalogInfo and type(allInfo.catalogInfo) ~= "table" then
        allInfo.catalogInfo = nil
    end
    if allInfo.decorInfo and type(allInfo.decorInfo) ~= "table" then
        allInfo.decorInfo = nil
    end
    local displayName = item.name or "Unknown Item"
    if allInfo.itemInfo and allInfo.itemInfo.itemName then
        displayName = allInfo.itemInfo.itemName
    elseif allInfo.catalogInfo and type(allInfo.catalogInfo) == "table" and allInfo.catalogInfo.name then
        displayName = allInfo.catalogInfo.name
    elseif allInfo.decorInfo and type(allInfo.decorInfo) == "table" and allInfo.decorInfo.name then
        displayName = allInfo.decorInfo.name
    end
    previewFrame.itemName:SetText(displayName)

    if item.itemID and item.itemID ~= "" then
        previewFrame.itemIDPreview:SetText("Item ID: " .. item.itemID)
    else
        previewFrame.itemIDPreview:SetText("")
    end

    previewFrame.typeValue:SetText(item.type or "Unknown")
    previewFrame.categoryValue:SetText(item.category or "Unknown")
    if allInfo.housingData and allInfo.housingData.weight then
        previewFrame.weightLabel:Show()
        previewFrame.weightValue:SetText(tostring(allInfo.housingData.weight))
        previewFrame.weightValue:Show()
    else
        previewFrame.weightLabel:Hide()
        previewFrame.weightValue:Hide()
    end

    -- Housing icon indicator in header
    if allInfo.housingData and allInfo.housingData.houseIcon then
        previewFrame.housingIcon:SetTexture(allInfo.housingData.houseIcon)
        previewFrame.housingIcon:Show()
    else
        previewFrame.housingIcon:Hide()
    end

    -- Cost/Price
    if item.currency and item.currency ~= "" then
        previewFrame.costValue:SetText(item.currency)
        previewFrame.costValue:SetTextColor(1, 0.82, 0, 1)
    elseif item.price and item.price > 0 then
        previewFrame.costValue:SetText(item.price .. " gold")
        previewFrame.costValue:SetTextColor(1, 0.82, 0, 1)
    else
        previewFrame.costValue:SetText("Free")
        previewFrame.costValue:SetTextColor(0.3, 1, 0.3, 1)
    end
    
    -- Achievement requirement
    if item.achievementRequired and item.achievementRequired ~= "" then
        previewFrame.achievementLabel:Show()
        previewFrame.achievementValue:SetText(item.achievementRequired)
        previewFrame.achievementValue:Show()
    else
        previewFrame.achievementLabel:Hide()
        previewFrame.achievementValue:Hide()
    end
    
    -- Quest requirement
    if item.questRequired and item.questRequired ~= "" then
        previewFrame.questLabel:Show()
        previewFrame.questValue:SetText(item.questRequired)
        previewFrame.questValue:Show()
    else
        previewFrame.questLabel:Hide()
        previewFrame.questValue:Hide()
    end
    
    -- Drop source
    if item.dropSource and item.dropSource ~= "" then
        previewFrame.dropLabel:Show()
        previewFrame.dropValue:SetText(item.dropSource)
        previewFrame.dropValue:Show()
    else
        previewFrame.dropLabel:Hide()
        previewFrame.dropValue:Hide()
    end
    
    -- Vendor (prefer item.vendor, fallback to vendorName)
    local vendorText = item.vendor or item.vendorName or "Unknown"
    previewFrame.vendorValue:SetText(vendorText)
    
    -- Zone
    previewFrame.zoneValue:SetText(item.zoneName or "Unknown")
    
    -- Expansion
    previewFrame.expansionValue:SetText(item.expansionName or "Unknown")
    
    -- Coordinates
    if item.vendorCoords and item.vendorCoords.x and item.vendorCoords.y then
        previewFrame.coordsValue:SetText(string.format("%.1f, %.1f", item.vendorCoords.x, item.vendorCoords.y))
    else
        previewFrame.coordsValue:SetText("N/A")
    end
    
    -- Faction
    if item.faction and item.faction ~= "Neutral" then
        previewFrame.factionValue:SetText(item.faction)
        if item.faction == "Horde" then
            previewFrame.factionValue:SetTextColor(1, 0.3, 0.3, 1)
        elseif item.faction == "Alliance" then
            previewFrame.factionValue:SetTextColor(0.3, 0.6, 1, 1)
        end
    else
        previewFrame.factionValue:SetText("Neutral")
        previewFrame.factionValue:SetTextColor(0.8, 0.8, 0.8, 1)
    end

    local minY = 0
    local fieldsToCheck = {
        previewFrame.typeValue, previewFrame.categoryValue, previewFrame.weightValue, previewFrame.costValue,
        previewFrame.achievementValue, previewFrame.questValue, previewFrame.dropValue,
        previewFrame.vendorValue, previewFrame.zoneValue, previewFrame.expansionValue,
        previewFrame.coordsValue, previewFrame.factionValue
    }

    for _, field in ipairs(fieldsToCheck) do
        if field and field:IsVisible() then
            local _, _, _, _, yOfs = field:GetPoint(1)
            if yOfs and type(yOfs) == "number" and yOfs < minY then
                minY = yOfs
            end
        end
    end

    local contentHeight = math.abs(minY) + 40
    if contentHeight < 200 then contentHeight = 200 end
    previewFrame.detailsFrame:SetHeight(contentHeight)

    if item.vendorCoords and item.vendorCoords.x and item.vendorCoords.y and
       item.mapID and item.mapID > 0 then
        previewFrame.waypointBtn:Show()
    else
        previewFrame.waypointBtn:Hide()
    end
    if item.itemID and item.itemID ~= "" then
        local itemID = tonumber(item.itemID)
        if itemID then
            previewFrame.itemIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

            if C_Item and C_Item.RequestLoadItemDataByID then
                C_Item.RequestLoadItemDataByID(itemID)
            end

            local attempts = 0
            local maxAttempts = 5
            local retryDelay = 0.1

            local function TryLoadIcon()
                local iconTexture = nil

                if C_Item and C_Item.GetItemIconByID then
                    iconTexture = C_Item.GetItemIconByID(itemID)
                end

                if not iconTexture and GetItemIcon then
                    iconTexture = GetItemIcon(itemID)
                end

                if iconTexture and iconTexture ~= "" then
                    previewFrame.itemIcon:SetTexture(iconTexture)
                else
                    attempts = attempts + 1
                    if attempts < maxAttempts then
                        C_Timer.After(retryDelay, TryLoadIcon)
                    end
                end
            end

            TryLoadIcon()
        else
            previewFrame.itemIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        end
    else
        previewFrame.itemIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
end
_G["HousingPreviewPanel"] = PreviewPanel

return PreviewPanel

