-- OutstandingItems Sub-module: Popup rendering
-- Part of HousingOutstandingItemsUI

local _G = _G
local OutstandingItemsUI = _G["HousingOutstandingItemsUI"]
if not OutstandingItemsUI then return end

local GameTooltip = GameTooltip
local ipairs = ipairs
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local string_format = string.format

local function CreatePopupItemRow(parent, x, y, width, height)
    local row = CreateFrame("Button", nil, parent, "BackdropTemplate")
    row:SetPoint("TOPLEFT", x, y)
    row:SetSize(width, height)
    row:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    row:SetBackdropColor(0, 0, 0, 0)
    row:SetBackdropBorderColor(0, 0, 0, 0)
    row.originalBackdropColor = { 0, 0, 0, 0 }
    return row
end

local function AttachFullItemTooltip(row, item)
    if not row then return end
    row.itemData = item

    local tooltip = _G.HousingVendorItemListTooltip
    if tooltip and tooltip.AttachButton then
        tooltip.AttachButton(row, { noHoverSkin = true })
        return
    end

    -- Minimal fallback if the shared tooltip module isn't available yet.
    row:SetScript("OnEnter", function(btn)
        if not item then return end
        if not GameTooltip then return end
        GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:SetText(item.name or "Item", 1, 1, 1, 1, true)
        local itemID = item.itemID and tonumber(item.itemID) or nil
        if itemID and GameTooltip.SetItemByID then
            GameTooltip:SetItemByID(itemID)
        end
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", function()
        if GameTooltip then GameTooltip:Hide() end
    end)
end

function OutstandingItemsUI:ApplyPopupTheme(frame)
    if not frame then return end

    local colors = (HousingTheme and HousingTheme.Colors) or {}
    local bg = colors.bgPrimary or {0.1, 0.1, 0.1, 0.95}
    local border = colors.borderPrimary or {0.3, 0.3, 0.3, 1}

    frame:SetBackdropColor(bg[1], bg[2], bg[3], bg[4])
    frame:SetBackdropBorderColor(border[1], border[2], border[3], border[4])

    local glowTop = frame._glowTop
    if not glowTop then
        glowTop = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
        glowTop:SetTexture("Interface\\Buttons\\WHITE8x8")
        glowTop:SetPoint("TOPLEFT", 2, -2)
        glowTop:SetPoint("TOPRIGHT", -2, -2)
        glowTop:SetHeight(90)
        frame._glowTop = glowTop
    end

    local glowBottom = frame._glowBottom
    if not glowBottom then
        glowBottom = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
        glowBottom:SetTexture("Interface\\Buttons\\WHITE8x8")
        glowBottom:SetPoint("BOTTOMLEFT", 2, 2)
        glowBottom:SetPoint("BOTTOMRIGHT", -2, 2)
        glowBottom:SetHeight(55)
        frame._glowBottom = glowBottom
    end

    local glowA = colors.bgTertiary or {0.16, 0.12, 0.24, 0.9}
    local glowB = colors.bgPrimary or {0.08, 0.06, 0.12, 0.95}
    glowTop:SetGradient("VERTICAL", CreateColor(glowA[1], glowA[2], glowA[3], 0.35), CreateColor(glowB[1], glowB[2], glowB[3], 0.0))
    glowBottom:SetGradient("VERTICAL", CreateColor(glowB[1], glowB[2], glowB[3], 0.0), CreateColor(glowB[1], glowB[2], glowB[3], 0.45))

    if frame.title then
        local titleColor = colors.accentGold or colors.textHighlight or {1, 0.95, 0.80, 1}
        frame.title:SetTextColor(titleColor[1], titleColor[2], titleColor[3], 1)
    end

    if frame.zoneName then
        local accent = colors.accentPrimary or {0.55, 0.65, 0.90, 1}
        frame.zoneName:SetTextColor(accent[1], accent[2], accent[3], 1)
    end
end


-- Show popup with outstanding items
function OutstandingItemsUI:ShowPopup(zoneName, outstanding)
    local frame = self:CreatePopup()
    if not frame then return end

    local currentFontSize = self._currentFontSize or 12

    frame._lastOutstanding = outstanding
    
    frame.zoneName:SetText(zoneName)
    
    -- Store zone name for View All button
    frame._currentZone = zoneName
    
    -- Clear existing content
    for _, child in ipairs({frame.content:GetChildren()}) do
        child:Hide()
        child:SetParent(nil)
    end
    
    local yOffset = -5
    
    -- Summary
    local summary = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    summary:SetPoint("TOPLEFT", 5, yOffset)
    summary:SetText(string.format("%d Uncollected Items", outstanding.total))
    do
        local colors = HousingTheme and HousingTheme.Colors or {}
        local c = colors.accentGold or colors.textHighlight or {1, 0.95, 0.80, 1}
        summary:SetTextColor(c[1], c[2], c[3], 1)
    end
    yOffset = yOffset - 30
    
	-- Vendors
	local vendorCount = 0
	for _ in pairs(outstanding.vendors) do vendorCount = vendorCount + 1 end
	if vendorCount > 0 then
		-- Take a reputation snapshot once for consistent progress display
		if HousingReputation and HousingReputation.SnapshotReputation then
			pcall(HousingReputation.SnapshotReputation)
		end

 		local vendorHeader = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
 		vendorHeader:SetPoint("TOPLEFT", 5, yOffset)
 		vendorHeader:SetText(string.format("Vendors: %d", vendorCount))
        do
            local colors = HousingTheme and HousingTheme.Colors or {}
            local c = colors.sourceVendor or colors.statusSuccess or {0.35, 0.80, 0.45, 1}
            vendorHeader:SetTextColor(c[1], c[2], c[3], 1)
        end
 		yOffset = yOffset - 20
        
        for vendorName, vendorData in pairs(outstanding.vendors) do
            -- Get first item to extract coordinates and map data
            local firstItem = vendorData.items and vendorData.items[1]

            local hasValidCoords = false
            local waypointItem = nil
            if firstItem and firstItem.coords and firstItem.coords.x and firstItem.coords.y then
                local mapID = firstItem.mapID or (firstItem.coords and firstItem.coords.mapID)
                if mapID and mapID ~= 0 then
                    hasValidCoords = true
                    -- Use VendorHelper for faction-aware zone selection
                    local itemZoneName = nil
                    if _G.HousingVendorHelper then
                        itemZoneName = _G.HousingVendorHelper:GetZoneName(firstItem, nil)
                    else
                        itemZoneName = firstItem._apiZone or firstItem.zoneName
                    end

                    waypointItem = {
                        vendorName = vendorName,
                        zoneName = itemZoneName or zoneName,
                        expansionName = firstItem.expansionName,
                        coords = { x = firstItem.coords.x, y = firstItem.coords.y },
                        mapID = mapID,
                    }
                end
            end

			-- Check for reputation requirements on any item from this vendor
			local repStatus = nil
			local repProgress = nil
			local repLabel = nil
			local repItemID = nil
			if HousingVendorItemToFaction and HousingReputation and HousingReputations then
				for _, item in ipairs(vendorData.items) do
					local itemID = item and tonumber(item.itemID) or nil
					local repInfo = itemID and HousingVendorItemToFaction[itemID] or nil
					if repInfo then
						repItemID = itemID
						local isUnlocked = HousingReputation.IsItemUnlocked and HousingReputation.IsItemUnlocked(itemID) or false
						local cfg = HousingReputations[repInfo.factionID]
						repLabel = (cfg and cfg.label) and (cfg.label .. " - " .. repInfo.requiredStanding) or repInfo.requiredStanding

						-- Prefer a progress bar (renown/standard) like the preview panel; fall back to colored text otherwise.
						if cfg and cfg.rep == "renown" and repInfo.requiredStanding then
							local requiredRenown = tonumber(tostring(repInfo.requiredStanding):match("Renown%s+(%d+)")) or 0
							local bestRec = HousingReputation.GetBestRepRecord and HousingReputation.GetBestRepRecord(repInfo.factionID) or nil
							local current = (bestRec and bestRec.renownLevel) or 0
							if isUnlocked then
								repProgress = { current = 1, max = 1, text = "Requirement Met" }
							elseif requiredRenown > 0 then
								repProgress = { current = current, max = requiredRenown, text = string.format("%d / %d", current, requiredRenown) }
							end
						elseif cfg and cfg.rep == "standard" and repInfo.requiredStanding then
							local reactionNames = { "Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted" }
							local requiredReaction = 0
							for i, name in ipairs(reactionNames) do
								if name == repInfo.requiredStanding then
									requiredReaction = i
									break
								end
							end
							local bestRec = HousingReputation.GetBestRepRecord and HousingReputation.GetBestRepRecord(repInfo.factionID) or nil
							local currentReaction = (bestRec and bestRec.reaction) or 0
							if isUnlocked then
								repProgress = { current = 1, max = 1, text = "Requirement Met" }
							elseif requiredReaction > 0 then
								repProgress = {
									current = currentReaction,
									max = requiredReaction,
									text = string.format("%s / %s", reactionNames[currentReaction] or "Unknown", repInfo.requiredStanding),
								}
							end
						end

						if not repProgress then
							if isUnlocked then
								repStatus = string.format("|cFF00FF00%s|r", repLabel)
							else
								repStatus = string.format("|cFFFF0000%s|r", repLabel)
							end
						end

						break -- Use first rep requirement found
					end
				end
			end

			-- Build vendor text - show actual uncollected count vs total
			local uncollectedCount = 0
			local totalCount = #vendorData.items
			for _, item in ipairs(vendorData.items) do
				local isCollected = false
				if item.itemID and HousingCollectionAPI then
					local itemIDNum = tonumber(item.itemID)
					if itemIDNum then
						isCollected = HousingCollectionAPI:IsItemCollected(itemIDNum)
					end
				end
				if not isCollected then
					uncollectedCount = uncollectedCount + 1
				end
			end

			local vendorTextStr
			if uncollectedCount < totalCount then
				-- Some items are collected, show both counts
				vendorTextStr = string.format("%s (%d/%d uncollected)", vendorName, uncollectedCount, totalCount)
			else
				-- All items uncollected, show simple count
				vendorTextStr = string.format("%s (%d item%s)", vendorName, totalCount, totalCount > 1 and "s" or "")
			end

			if repStatus and not repProgress then
				vendorTextStr = vendorTextStr .. "\n     " .. repStatus
			end

			local inlineRepBarCreated = false

            if hasValidCoords and HousingWaypointManager and waypointItem then
                -- Create clickable map button
                local mapBtn = CreateFrame("Button", nil, frame.content)
                mapBtn:SetSize(14, 14)
                mapBtn:SetPoint("TOPLEFT", 15, yOffset + 2)

                -- Map icon texture
                local icon = mapBtn:CreateTexture(nil, "ARTWORK")
                icon:SetAllPoints()
                icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
                icon:SetVertexColor(0.5, 0.8, 1, 1)
                mapBtn.icon = icon

                -- Vendor text (offset to make room for button) - make it a button for tooltip interaction
                local vendorTextFrame = CreateFrame("Button", nil, frame.content)
                vendorTextFrame:SetPoint("TOPLEFT", 32, yOffset)

	                -- Calculate height based on whether reputation is shown
	                local rowHeight = repProgress and ((repLabel and repLabel ~= "") and 52 or 38) or (repStatus and 40 or 22)
	                vendorTextFrame:SetSize(305, rowHeight)

	                local vendorText = vendorTextFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	                vendorText:SetPoint("TOPLEFT", vendorTextFrame, "TOPLEFT", 0, 0)
	                if not repProgress then
	                    vendorText:SetPoint("BOTTOMRIGHT", vendorTextFrame, "BOTTOMRIGHT", 0, 0)
	                else
	                    vendorText:SetWidth(305)
	                    vendorText:SetHeight(16)
	                end
	                vendorText:SetJustifyH("LEFT")
	                vendorText:SetJustifyV("TOP")
	                vendorText:SetWordWrap(true)
	                vendorText:SetSpacing(2)
	                vendorText:SetText(vendorTextStr)
	                vendorTextFrame.textString = vendorText

	                -- If a progress bar is shown, also show which reputation it is for (faction + required standing).
	                local repLabelText = nil
	                if repProgress and repLabel and repLabel ~= "" then
	                    repLabelText = vendorTextFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	                    repLabelText:SetPoint("TOPLEFT", vendorTextFrame, "TOPLEFT", 0, -16)
	                    repLabelText:SetWidth(305)
	                    repLabelText:SetHeight(14)
	                    repLabelText:SetJustifyH("LEFT")
	                    repLabelText:SetJustifyV("TOP")
	                    repLabelText:SetTextColor(0.9, 0.7, 0.3, 1)
	                    repLabelText:SetText(repLabel)
	                    vendorTextFrame.repLabelText = repLabelText
	                end

	                -- Reputation progress bar (matches the preview panel styling)
	                if repProgress and repProgress.max and repProgress.max > 0 then
	                    local progress = math.min((repProgress.current or 0) / repProgress.max, 1)

	                    local repBar = CreateFrame("StatusBar", nil, vendorTextFrame)
	                    repBar:SetPoint("TOPLEFT", vendorTextFrame, "TOPLEFT", 0, repLabelText and -32 or -16)
	                    repBar:SetSize(305, 12)
	                    repBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	                    repBar:SetMinMaxValues(0, 1)
	                    repBar:SetValue(progress)

	                    if progress >= 1 then
	                        repBar:SetStatusBarColor(0.2, 0.8, 0.2, 1)
	                    elseif progress >= 0.5 then
	                        repBar:SetStatusBarColor(0.2, 0.6, 1, 1)
	                    else
	                        repBar:SetStatusBarColor(0.8, 0.3, 0.3, 1)
	                    end

	                    local repBarBg = repBar:CreateTexture(nil, "BACKGROUND")
	                    repBarBg:SetAllPoints(repBar)
	                    repBarBg:SetColorTexture(0.1, 0.1, 0.1, 0.5)

	                    local repBarText = repBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	                    repBarText:SetPoint("CENTER", repBar, "CENTER", 0, 0)
		                    repBarText:SetTextColor(1, 1, 1, 1)
		                    repBarText:SetText(repProgress.text or "")
		                    repBar.text = repBarText
		                    inlineRepBarCreated = true
		                end

                -- TAINT FIX: Removed complex tooltip to prevent taint issues
                -- Tooltips can cause taint when shown during protected UI operations (ESC key)

                -- Button click handler - navigate to vendor
                mapBtn:SetScript("OnClick", function()
                    HousingWaypointManager:SetWaypoint(waypointItem)
                end)

                -- Hover effects
                mapBtn:SetScript("OnEnter", function(btn)
                    btn.icon:SetVertexColor(1, 1, 0, 1)
                    GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
                    GameTooltip:SetText("Set waypoint to " .. vendorName, 1, 1, 1)
                    GameTooltip:AddLine("Click to navigate", 0.5, 0.8, 1)
                    GameTooltip:Show()
                end)
                mapBtn:SetScript("OnLeave", function(btn)
                    btn.icon:SetVertexColor(0.5, 0.8, 1, 1)
                    GameTooltip:Hide()
                end)
            else
                -- No coords - show text as a button so we can still provide the full tooltip on hover.
                local vendorTextFrame = CreateFrame("Button", nil, frame.content)
                vendorTextFrame:SetPoint("TOPLEFT", 15, yOffset)

                local rowHeight = repProgress and ((repLabel and repLabel ~= "") and 52 or 38) or (repStatus and 40 or 22)
                vendorTextFrame:SetSize(320, rowHeight)

                local vendorText = vendorTextFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                vendorText:SetPoint("TOPLEFT", vendorTextFrame, "TOPLEFT", 0, 0)
                vendorText:SetWidth(320)
                vendorText:SetJustifyH("LEFT")
                vendorText:SetJustifyV("TOP")
                vendorText:SetWordWrap(true)
                vendorText:SetSpacing(2)
                if repProgress and repLabel and repLabel ~= "" then
                    vendorText:SetText(string.format("  - %s\n     %s", vendorTextStr, repLabel))
                else
                    vendorText:SetText(string.format("  - %s", vendorTextStr))
                end
                vendorTextFrame.textString = vendorText

                -- TAINT FIX: Removed complex tooltip to prevent taint issues
                -- Tooltips can cause taint when shown during protected UI operations (ESC key)
	            end

	            if not inlineRepBarCreated and repProgress and repProgress.max and repProgress.max > 0 then
	                local progress = math.min((repProgress.current or 0) / repProgress.max, 1)
	                local barX = (hasValidCoords and HousingWaypointManager and waypointItem) and 32 or 15
	                local barY = yOffset - ((repLabel and repLabel ~= "") and 32 or 16)

	                local repBar = CreateFrame("StatusBar", nil, frame.content)
	                repBar:SetPoint("TOPLEFT", frame.content, "TOPLEFT", barX, barY)
	                repBar:SetSize(305, 12)
	                repBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	                repBar:SetMinMaxValues(0, 1)
	                repBar:SetValue(progress)

	                if progress >= 1 then
	                    repBar:SetStatusBarColor(0.2, 0.8, 0.2, 1)
	                elseif progress >= 0.5 then
	                    repBar:SetStatusBarColor(0.2, 0.6, 1, 1)
	                else
	                    repBar:SetStatusBarColor(0.8, 0.3, 0.3, 1)
	                end

	                local repBarBg = repBar:CreateTexture(nil, "BACKGROUND")
	                repBarBg:SetAllPoints(repBar)
	                repBarBg:SetColorTexture(0.1, 0.1, 0.1, 0.5)

	                local repBarText = repBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	                repBarText:SetPoint("CENTER", repBar, "CENTER", 0, 0)
	                repBarText:SetTextColor(1, 1, 1, 1)
	                repBarText:SetText(repProgress.text or "")
	                repBar.text = repBarText
	            end

	            -- Add extra space if reputation shown (rep bar row or 2-line text fallback)
	            if repProgress and repProgress.max and repProgress.max > 0 then
	                yOffset = yOffset - ((repLabel and repLabel ~= "") and 52 or 38)
	            elseif repStatus then
	                yOffset = yOffset - 40
	            else
	                yOffset = yOffset - 22
	            end
	        end
	        yOffset = yOffset - 8
	    end
    
    -- Quests (rows use the same enriched tooltip as the main item list)
    if #outstanding.quests > 0 then
        local questHeader = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        questHeader:SetPoint("TOPLEFT", 5, yOffset)
        questHeader:SetText(string.format("Quests: %d item%s", #outstanding.quests, #outstanding.quests > 1 and "s" or ""))
        do
            local colors = HousingTheme and HousingTheme.Colors or {}
            local c = colors.sourceQuest or colors.statusInfo or {0.40, 0.70, 0.95, 1}
            questHeader:SetTextColor(c[1], c[2], c[3], 1)
        end
        yOffset = yOffset - 20
        for _, item in ipairs(outstanding.quests) do
            local row = CreatePopupItemRow(frame.content, 15, yOffset, 320, 16)

            local questText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            questText:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
            questText:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
            questText:SetJustifyH("LEFT")
            questText:SetJustifyV("MIDDLE")
            questText:SetText(string.format("  - %s", item._questName or item.name or "Quest Item"))
            row.textString = questText
            AttachFullItemTooltip(row, item)

            yOffset = yOffset - 16
        end
        yOffset = yOffset - 5
    end
    
    -- Achievements
    if #outstanding.achievements > 0 then
        local achHeader = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        achHeader:SetPoint("TOPLEFT", 5, yOffset)
        achHeader:SetText(string.format("Achievements: %d item%s", #outstanding.achievements, #outstanding.achievements > 1 and "s" or ""))
        do
            local colors = HousingTheme and HousingTheme.Colors or {}
            local c = colors.sourceAchievement or colors.accentGold or {0.95, 0.80, 0.25, 1}
            achHeader:SetTextColor(c[1], c[2], c[3], 1)
        end
        yOffset = yOffset - 20
        for _, item in ipairs(outstanding.achievements) do
            local row = CreatePopupItemRow(frame.content, 15, yOffset, 320, 16)

            local achText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            achText:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
            achText:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
            achText:SetJustifyH("LEFT")
            achText:SetJustifyV("MIDDLE")
            achText:SetText(string.format("  - %s", item._achievementName or item.name or "Achievement Item"))
            row.textString = achText
            AttachFullItemTooltip(row, item)

            yOffset = yOffset - 16
        end
        yOffset = yOffset - 5
    end
    
    -- Drops
    if #outstanding.drops > 0 then
        local dropHeader = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        dropHeader:SetPoint("TOPLEFT", 5, yOffset)
        dropHeader:SetText(string.format("Drops: %d item%s", #outstanding.drops, #outstanding.drops > 1 and "s" or ""))
        do
            local colors = HousingTheme and HousingTheme.Colors or {}
            local c = colors.sourceDrop or colors.statusWarning or {0.95, 0.60, 0.25, 1}
            dropHeader:SetTextColor(c[1], c[2], c[3], 1)
        end
        yOffset = yOffset - 20
        for _, item in ipairs(outstanding.drops) do
            local row = CreatePopupItemRow(frame.content, 15, yOffset, 320, 16)

            local dropText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            dropText:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
            dropText:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
            dropText:SetJustifyH("LEFT")
            dropText:SetJustifyV("MIDDLE")
            dropText:SetText(string_format("  - %s", item.name or "Drop Item"))
            row.textString = dropText

            AttachFullItemTooltip(row, item)
            yOffset = yOffset - 16
        end
        yOffset = yOffset - 5
    end

    -- Professions
    if outstanding.professions and #outstanding.professions > 0 then
        local profHeader = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        profHeader:SetPoint("TOPLEFT", 5, yOffset)
        profHeader:SetText(string_format("Professions: %d item%s", #outstanding.professions, #outstanding.professions > 1 and "s" or ""))
        do
            local colors = HousingTheme and HousingTheme.Colors or {}
            local c = colors.sourceVendor or colors.statusInfo or {0.6, 0.8, 1.0, 1}
            profHeader:SetTextColor(c[1], c[2], c[3], 1)
        end
        yOffset = yOffset - 20
        for _, item in ipairs(outstanding.professions) do
            local row = CreatePopupItemRow(frame.content, 15, yOffset, 320, 16)

            local profText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            profText:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
            profText:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
            profText:SetJustifyH("LEFT")
            profText:SetJustifyV("MIDDLE")
            profText:SetText(string_format("  - %s", item.name or "Profession Item"))
            row.textString = profText

            AttachFullItemTooltip(row, item)
            yOffset = yOffset - 16
        end
        yOffset = yOffset - 5
    end
    
    -- Update content height
    frame.content:SetHeight(math.abs(yOffset) + 20)

    self:ApplyPopupTheme(frame)
    frame:Show()
end


return OutstandingItemsUI

