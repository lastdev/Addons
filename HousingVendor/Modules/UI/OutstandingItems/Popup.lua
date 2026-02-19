-- OutstandingItems Sub-module: Popup rendering

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

local function AttachVendorHoverTooltip(btn, vendorDisplayName, vendorCoords, vendorMapID, vendorData, repLabel, repStatus, repProgress)
    if not btn then return end

    local function Refresh(self)
        if not GameTooltip then return end
        if InCombatLockdown and InCombatLockdown() then return end
        if _G.GameMenuFrame and _G.GameMenuFrame.IsShown and _G.GameMenuFrame:IsShown() then return end

        local showDetails = IsShiftKeyDown and IsShiftKeyDown() or false

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(tostring(vendorDisplayName or "Vendor"), 1, 0.82, 0, true)

        if vendorCoords and vendorCoords.x and vendorCoords.y then
            GameTooltip:AddLine(string.format("Coords: %.1f, %.1f", vendorCoords.x, vendorCoords.y), 0.7, 0.7, 0.7, 1)
        end
        if vendorMapID and tonumber(vendorMapID) then
            GameTooltip:AddLine("MapID: " .. tostring(vendorMapID), 0.6, 0.6, 0.6, 1)
        end

        if repProgress and repLabel and repLabel ~= "" then
            GameTooltip:AddLine("Reputation: " .. tostring(repLabel), 0.9, 0.7, 0.3, 1)
        elseif repStatus and repStatus ~= "" then
            GameTooltip:AddLine("Reputation: " .. tostring(repStatus), 0.9, 0.7, 0.3, 1)
        end

        local items = vendorData and vendorData.items or nil
        if showDetails and type(items) == "table" and #items > 0 then
            GameTooltip:AddLine(" ", 1, 1, 1, 1)
            GameTooltip:AddLine("Items:", 0.8, 0.8, 0.8, true)

            for i = 1, #items do
                local it = items[i]
                local name = it and (it.name or it.itemName or it.ItemName) or nil
                if (not name or name == "") and it and it.itemID and C_Item and C_Item.GetItemNameByID then
                    local ok, n = pcall(C_Item.GetItemNameByID, tonumber(it.itemID))
                    if ok and n and n ~= "" then name = n end
                end
                name = tostring(name or (it and it.itemID and ("Item " .. tostring(it.itemID)) or "Unknown Item"))

                local collected = false
                do
                    local itemID = it and it.itemID and tonumber(it.itemID) or nil
                    if itemID then
                        -- First check if we have API data in the item itself
                        local numStored = tonumber(it._apiNumStored) or 0
                        local numPlaced = tonumber(it._apiNumPlaced) or 0
                        if (numStored + numPlaced) > 0 then
                            collected = true
                        end
                        
                        -- If not collected yet, check HousingDB caches
                        if not collected then
                            if HousingDB and HousingDB.collectedDecor and HousingDB.collectedDecor[itemID] == true then
                                collected = true
                            elseif HousingDB and HousingDB.ownedDecorCache and HousingDB.ownedDecorCache.items then
                                local owned = HousingDB.ownedDecorCache.items[itemID]
                                if owned and (tonumber(owned.totalOwned) or 0) > 0 then
                                    collected = true
                                end
                            end
                        end
                        
                        -- Always check the collection API as the authoritative source
                        if not collected and _G.HousingCatalogSafeToCall and HousingCollectionAPI and HousingCollectionAPI.IsItemCollected then
                            local ok, res = pcall(HousingCollectionAPI.IsItemCollected, HousingCollectionAPI, itemID)
                            if ok and res == true then
                                collected = true
                            end
                        end
                    end
                end

                if collected then
                    GameTooltip:AddLine(name, 0.2, 1.0, 0.2, true)
                else
                    GameTooltip:AddLine(name, 1, 1, 1, true)
                end
            end
        elseif type(items) == "table" and #items > 0 then
            GameTooltip:AddLine("Hold SHIFT for item list", 0.6, 0.6, 0.6, 1)
        end

        GameTooltip:Show()
    end

    btn:SetScript("OnEnter", function(self)
        if self.RegisterEvent then
            self:RegisterEvent("MODIFIER_STATE_CHANGED")
            self:SetScript("OnEvent", function(frame, event)
                if event == "MODIFIER_STATE_CHANGED" and frame.IsMouseOver and frame:IsMouseOver() then
                    Refresh(frame)
                end
            end)
        end

        Refresh(self)
    end)

    btn:SetScript("OnLeave", function()
        if btn and btn.UnregisterEvent then
            btn:UnregisterEvent("MODIFIER_STATE_CHANGED")
            btn:SetScript("OnEvent", nil)
        end
        if GameTooltip then GameTooltip:Hide() end
    end)
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

    local alpha = (bg[4] or 0.95) * 0.6

    frame:SetBackdropColor(bg[1], bg[2], bg[3], alpha)
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
    glowTop:SetGradient("VERTICAL", CreateColor(glowA[1], glowA[2], glowA[3], 0.25), CreateColor(glowB[1], glowB[2], glowB[3], 0.0))
    glowBottom:SetGradient("VERTICAL", CreateColor(glowB[1], glowB[2], glowB[3], 0.0), CreateColor(glowB[1], glowB[2], glowB[3], 0.35))

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
function OutstandingItemsUI:ShowPopup(zoneName, outstanding, currentMapID)
    local frame = self:CreatePopup()
    if not frame then return end

    local currentFontSize = self._currentFontSize or 12

    -- Recalculate content width from current frame size (supports resize)
    local frameWidth = (frame.GetWidth and frame:GetWidth()) or 250
    local contentWidth = math.max(1, frameWidth - 50)
    frame._contentWidth = contentWidth
    if frame.content then
        frame.content:SetWidth(contentWidth)
    end
    local itemRowX = 15
    local itemRowWidth = math.max(120, contentWidth - itemRowX)

    local vendorTextXWithButtons = 37
    local vendorTextXNoCoords = 20
    local vendorTextWidthWithButtons = math.max(120, contentWidth - vendorTextXWithButtons - 5)
    local vendorTextWidthNoCoords = math.max(120, contentWidth - vendorTextXNoCoords - 5)

    frame._lastOutstanding = outstanding
    frame._currentMapID = currentMapID
     
    frame.zoneName:SetText(zoneName)
     
    frame._currentZone = zoneName
    
    -- Properly cleanup children to prevent memory leak
    for _, child in ipairs({frame.content:GetChildren()}) do
        -- Call Release if the object supports it (for pooled frames)
        if child.Release then
            child:Release()
        end
        child:Hide()
        child:SetParent(nil)
    end
    for _, region in ipairs({frame.content:GetRegions()}) do
        region:Hide()
        region:SetParent(nil)
    end
    
    local yOffset = -5
    
    local summary = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    summary:SetPoint("TOPLEFT", 5, yOffset)
    summary:SetText(string.format("%d Uncollected Items", outstanding.total))
    do
        local colors = HousingTheme and HousingTheme.Colors or {}
        local c = colors.accentGold or colors.textHighlight or {1, 0.95, 0.80, 1}
        summary:SetTextColor(c[1], c[2], c[3], 1)
    end
    yOffset = yOffset - 30

    -- Apply popup filters
    local popupFilters = HousingDB and HousingDB.popupFilters or {}
    local showQuests = popupFilters.showQuests ~= false
    local showAchievements = popupFilters.showAchievements ~= false
    local showDrops = popupFilters.showDrops ~= false
    local showProfessions = popupFilters.showProfessions ~= false

    -- Check if all items were from muted vendors or filtered out
    local hasAnyContent = false
    local vendorCount = 0
	for _ in pairs(outstanding.vendors) do vendorCount = vendorCount + 1 end
    if vendorCount > 0 then
        hasAnyContent = true
    end
    if (#outstanding.quests > 0 and showQuests) or
       (#outstanding.achievements > 0 and showAchievements) or
       (#outstanding.drops > 0 and showDrops) or
       (outstanding.professions and #outstanding.professions > 0 and showProfessions) then
        hasAnyContent = true
    end

    -- Show message if everything is muted
    if not hasAnyContent and outstanding.total == 0 then
        local mutedMessage = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        mutedMessage:SetPoint("TOPLEFT", 5, yOffset)
        mutedMessage:SetWidth(340)
        mutedMessage:SetJustifyH("LEFT")
        mutedMessage:SetText("All vendors in this zone are muted.\n\nYou can unmute them in Settings.")
        do
            local colors = HousingTheme and HousingTheme.Colors or {}
            local c = colors.textSecondary or {0.7, 0.7, 0.7, 1}
            mutedMessage:SetTextColor(c[1], c[2], c[3], 0.8)
        end
        yOffset = yOffset - 80
    end

	-- Vendors
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
        
        for vendorKey, vendorData in pairs(outstanding.vendors) do
            -- Get first item to extract coordinates and map data
            local firstItem = vendorData.items and vendorData.items[1]

            local hasValidCoords = false
            local waypointItem = nil
            local vendorCoords = vendorData and vendorData.coords or nil
            local vendorMapID = vendorData and (vendorData.mapID or (vendorData.coords and vendorData.coords.mapID)) or nil
            local vendorName = vendorData and (vendorData.baseName or vendorData.name) or nil
            local vendorDisplayName = vendorData and vendorData.name or vendorName or vendorKey

            if vendorCoords and vendorCoords.x and vendorCoords.y and vendorMapID and vendorMapID ~= 0 then
                hasValidCoords = true
                local itemZoneName = nil
                if _G.HousingVendorHelper then
                    itemZoneName = _G.HousingVendorHelper:GetZoneName(firstItem, nil, nil, vendorMapID)
                else
                    itemZoneName = firstItem and (firstItem._apiZone or firstItem.zoneName) or nil
                end

                waypointItem = {
                    vendorName = vendorName or vendorDisplayName,
                    zoneName = itemZoneName or zoneName,
                    expansionName = firstItem and firstItem.expansionName or nil,
                    coords = { x = vendorCoords.x, y = vendorCoords.y, mapID = vendorMapID },
                    mapID = vendorMapID,
                    npcID = vendorData and vendorData.npcID or (firstItem and firstItem.npcID) or nil,
                    name = firstItem and firstItem.name or nil,
                }
            elseif firstItem and firstItem.coords and firstItem.coords.x and firstItem.coords.y then
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
                        vendorName = vendorName or vendorDisplayName,
                        zoneName = itemZoneName or zoneName,
                        expansionName = firstItem.expansionName,
                        coords = { x = firstItem.coords.x, y = firstItem.coords.y, mapID = mapID },
                        mapID = mapID,
                        npcID = firstItem.npcID or (vendorData and vendorData.npcID) or nil,
                        name = firstItem.name,
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
						-- Wrap IsItemUnlocked in pcall for safety
						local isUnlocked = false
						if HousingReputation and HousingReputation.IsItemUnlocked then
							local ok, result = pcall(HousingReputation.IsItemUnlocked, itemID)
							if ok then isUnlocked = result end
						end

						local cfg = HousingReputations[repInfo.factionID]
						repLabel = (cfg and cfg.label) and (cfg.label .. " - " .. repInfo.requiredStanding) or repInfo.requiredStanding

						-- Prefer a progress bar (renown/standard) like the preview panel; fall back to colored text otherwise.
						if cfg and cfg.rep == "renown" and repInfo.requiredStanding then
							local requiredRenown = tonumber(tostring(repInfo.requiredStanding):match("Renown%s+(%d+)")) or 0
							-- Wrap GetBestRepRecord in pcall for safety
							local bestRec = nil
							if HousingReputation and HousingReputation.GetBestRepRecord then
								local ok, result = pcall(HousingReputation.GetBestRepRecord, repInfo.factionID)
								if ok then bestRec = result end
							end
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
							-- Wrap GetBestRepRecord in pcall for safety
							local bestRec = nil
							if HousingReputation and HousingReputation.GetBestRepRecord then
								local ok, result = pcall(HousingReputation.GetBestRepRecord, repInfo.factionID)
								if ok then bestRec = result end
							end
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
						-- Wrap in pcall to prevent errors if API call fails
						local ok, result = pcall(HousingCollectionAPI.IsItemCollected, HousingCollectionAPI, itemIDNum)
						if ok then
							isCollected = result
						end
					end
				end
				if not isCollected then
					uncollectedCount = uncollectedCount + 1
				end
			end

			local vendorTextStr
			if uncollectedCount < totalCount then
				-- Some items are collected, show both counts
				vendorTextStr = string.format("%s (%d/%d uncollected)", vendorDisplayName, uncollectedCount, totalCount)
			else
				-- All items uncollected, show simple count
				vendorTextStr = string.format("%s (%d item%s)", vendorDisplayName, totalCount, totalCount > 1 and "s" or "")
			end

			if repStatus and not repProgress then
				vendorTextStr = vendorTextStr .. "\n     " .. repStatus
			end

			local inlineRepBarCreated = false

            if hasValidCoords and HousingWaypointManager and waypointItem then
                -- Create mute button (X icon)
                local muteBtn = CreateFrame("Button", nil, frame.content)
                muteBtn:SetSize(12, 12)
                muteBtn:SetPoint("TOPLEFT", 5, yOffset + 2)

                local muteIcon = muteBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                muteIcon:SetAllPoints()
                muteIcon:SetText("×")
                muteIcon:SetTextColor(0.7, 0.3, 0.3, 1)
                muteBtn.icon = muteIcon

                muteBtn:SetScript("OnClick", function()
                    -- Prevent rapid-click spam by disabling button during processing
                    muteBtn:Disable()

                    if not HousingDB then HousingDB = {} end
                    if not HousingDB.mutedVendors then HousingDB.mutedVendors = {} end
                    HousingDB.mutedVendors[vendorKey] = true
                    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                        _G.HousingVendorLog:Info("Muted vendor: " .. (vendorDisplayName or vendorKey))
                    end

                    -- Refresh popup by regenerating the outstanding items and re-showing
                    C_Timer.After(0.1, function()
                        if OutstandingItemsUI and OutstandingItemsUI.GetOutstandingItemsForZone and OutstandingItemsUI.ShowPopup then
                            local mapID, zoneName = OutstandingItemsUI:GetCurrentZone()
                            local outstanding = OutstandingItemsUI:GetOutstandingItemsForZone(mapID, zoneName)
                            if outstanding then
                                -- Show popup even if total is 0 (all vendors muted)
                                if outstanding.total == 0 then
                                    outstanding.total = 0
                                    outstanding.vendors = {}
                                    outstanding.quests = {}
                                    outstanding.achievements = {}
                                    outstanding.drops = {}
                                    outstanding.professions = {}
                                end
                                OutstandingItemsUI:ShowPopup(zoneName or "Current Zone", outstanding, mapID)
                            else
                                frame:Hide()
                            end
                        end
                        -- Re-enable button after processing (if it still exists)
                        if muteBtn and muteBtn.Enable then
                            muteBtn:Enable()
                        end
                    end)
                end)

                muteBtn:SetScript("OnEnter", function(btn)
                    btn.icon:SetTextColor(1, 0.5, 0.5, 1)
                    GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
                    GameTooltip:SetText("Mute this vendor", 1, 1, 1)
                    GameTooltip:AddLine("Hide notifications for items from this vendor", 0.7, 0.7, 0.7)
                    GameTooltip:Show()
                end)

                muteBtn:SetScript("OnLeave", function(btn)
                    btn.icon:SetTextColor(0.7, 0.3, 0.3, 1)
                    GameTooltip:Hide()
                end)

                -- Create clickable map button
                local mapBtn = CreateFrame("Button", nil, frame.content)
                mapBtn:SetSize(14, 14)
                mapBtn:SetPoint("TOPLEFT", 20, yOffset + 2)

                -- Map icon texture
                local icon = mapBtn:CreateTexture(nil, "ARTWORK")
                icon:SetAllPoints()
                icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
                icon:SetVertexColor(0.5, 0.8, 1, 1)
                mapBtn.icon = icon

                -- Vendor text (offset to make room for buttons) - make it a button for tooltip interaction
                local vendorTextFrame = CreateFrame("Button", nil, frame.content)
                vendorTextFrame:SetPoint("TOPLEFT", 37, yOffset)

	                -- Calculate height based on whether reputation is shown
	                local rowHeight = repProgress and ((repLabel and repLabel ~= "") and 52 or 38) or (repStatus and 40 or 22)
	                vendorTextFrame:SetSize(vendorTextWidthWithButtons, rowHeight)

	                local vendorText = vendorTextFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	                vendorText:SetPoint("TOPLEFT", vendorTextFrame, "TOPLEFT", 0, 0)
	                if not repProgress then
	                    vendorText:SetPoint("BOTTOMRIGHT", vendorTextFrame, "BOTTOMRIGHT", 0, 0)
	                else
	                    vendorText:SetWidth(vendorTextWidthWithButtons)
	                    vendorText:SetHeight(16)
	                end
	                vendorText:SetJustifyH("LEFT")
	                vendorText:SetJustifyV("TOP")
	                vendorText:SetWordWrap(true)
	                vendorText:SetSpacing(2)
	                vendorText:SetText(vendorTextStr)
	                vendorTextFrame.textString = vendorText

                    AttachVendorHoverTooltip(vendorTextFrame, vendorDisplayName, vendorCoords, vendorMapID, vendorData, repLabel, repStatus, repProgress)

	                -- If a progress bar is shown, also show which reputation it is for (faction + required standing).
	                local repLabelText = nil
	                if repProgress and repLabel and repLabel ~= "" then
	                    repLabelText = vendorTextFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	                    repLabelText:SetPoint("TOPLEFT", vendorTextFrame, "TOPLEFT", 0, -16)
	                    repLabelText:SetWidth(vendorTextWidthWithButtons)
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
	                    repBar:SetSize(vendorTextWidthWithButtons, 12)
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
                    -- If vendor marker is enabled, let it handle setting the waypoint so we don't double-print routes.
                    if HousingDB and HousingDB.settings and HousingDB.settings.enableVendorMarker
                        and HousingVendorMarker and waypointItem and waypointItem.npcID then
                        local vendorName = waypointItem.vendorName or waypointItem.name or "Vendor"
                        local npcID = waypointItem.npcID

                        -- Only show if NPC ID is valid (not "None" or empty)
                        if npcID and npcID ~= "None" and npcID ~= "" and tonumber(npcID) then
                            local coords = {
                                x = waypointItem.coords and waypointItem.coords.x or waypointItem.x,
                                y = waypointItem.coords and waypointItem.coords.y or waypointItem.y,
                                mapID = (waypointItem.coords and waypointItem.coords.mapID) or waypointItem.mapID
                            }
                            HousingVendorMarker:ShowForVendor(vendorName, npcID, coords)
                            return
                        end
                    end

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
                -- Create mute button (X icon)
                local muteBtn = CreateFrame("Button", nil, frame.content)
                muteBtn:SetSize(12, 12)
                muteBtn:SetPoint("TOPLEFT", 5, yOffset + 2)

                local muteIcon = muteBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                muteIcon:SetAllPoints()
                muteIcon:SetText("×")
                muteIcon:SetTextColor(0.7, 0.3, 0.3, 1)
                muteBtn.icon = muteIcon

                muteBtn:SetScript("OnClick", function()
                    -- Prevent rapid-click spam by disabling button during processing
                    muteBtn:Disable()

                    if not HousingDB then HousingDB = {} end
                    if not HousingDB.mutedVendors then HousingDB.mutedVendors = {} end
                    HousingDB.mutedVendors[vendorKey] = true
                    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                        _G.HousingVendorLog:Info("Muted vendor: " .. (vendorDisplayName or vendorKey))
                    end

                    -- Refresh popup by regenerating the outstanding items and re-showing
                    C_Timer.After(0.1, function()
                        if OutstandingItemsUI and OutstandingItemsUI.GetOutstandingItemsForZone and OutstandingItemsUI.ShowPopup then
                            local mapID, zoneName = OutstandingItemsUI:GetCurrentZone()
                            local outstanding = OutstandingItemsUI:GetOutstandingItemsForZone(mapID, zoneName)
                            if outstanding then
                                -- Show popup even if total is 0 (all vendors muted)
                                if outstanding.total == 0 then
                                    outstanding.total = 0
                                    outstanding.vendors = {}
                                    outstanding.quests = {}
                                    outstanding.achievements = {}
                                    outstanding.drops = {}
                                    outstanding.professions = {}
                                end
                                OutstandingItemsUI:ShowPopup(zoneName or "Current Zone", outstanding, mapID)
                            else
                                frame:Hide()
                            end
                        end
                        -- Re-enable button after processing (if it still exists)
                        if muteBtn and muteBtn.Enable then
                            muteBtn:Enable()
                        end
                    end)
                end)

                muteBtn:SetScript("OnEnter", function(btn)
                    btn.icon:SetTextColor(1, 0.5, 0.5, 1)
                    GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
                    GameTooltip:SetText("Mute this vendor", 1, 1, 1)
                    GameTooltip:AddLine("Hide notifications for items from this vendor", 0.7, 0.7, 0.7)
                    GameTooltip:Show()
                end)

                muteBtn:SetScript("OnLeave", function(btn)
                    btn.icon:SetTextColor(0.7, 0.3, 0.3, 1)
                    GameTooltip:Hide()
                end)

                -- No coords - show text as a button so we can still provide the full tooltip on hover.
                local vendorTextFrame = CreateFrame("Button", nil, frame.content)
                vendorTextFrame:SetPoint("TOPLEFT", 20, yOffset)

                local rowHeight = repProgress and ((repLabel and repLabel ~= "") and 52 or 38) or (repStatus and 40 or 22)
                vendorTextFrame:SetSize(vendorTextWidthNoCoords, rowHeight)

                local vendorText = vendorTextFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                vendorText:SetPoint("TOPLEFT", vendorTextFrame, "TOPLEFT", 0, 0)
                vendorText:SetWidth(vendorTextWidthNoCoords)
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

                AttachVendorHoverTooltip(vendorTextFrame, vendorDisplayName, vendorCoords, vendorMapID, vendorData, repLabel, repStatus, repProgress)

                -- TAINT FIX: Removed complex tooltip to prevent taint issues
                -- Tooltips can cause taint when shown during protected UI operations (ESC key)
	            end

	            if not inlineRepBarCreated and repProgress and repProgress.max and repProgress.max > 0 then
	                local progress = math.min((repProgress.current or 0) / repProgress.max, 1)
	                local barX = (hasValidCoords and HousingWaypointManager and waypointItem) and 32 or 15
	                local barY = yOffset - ((repLabel and repLabel ~= "") and 32 or 16)

	                local repBar = CreateFrame("StatusBar", nil, frame.content)
	                repBar:SetPoint("TOPLEFT", frame.content, "TOPLEFT", barX, barY)
	                repBar:SetSize(math.max(120, contentWidth - barX - 5), 12)
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

    if #outstanding.quests > 0 and showQuests then
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
            local row = CreatePopupItemRow(frame.content, 15, yOffset, itemRowWidth, 16)

            local questText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            questText:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
            questText:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
            questText:SetJustifyH("LEFT")
            questText:SetJustifyV("MIDDLE")

            local displayQuestText = item._questName or item.name or "Quest Item"
            local numericQuestID = item and (tonumber(item._questId) or tonumber(item.questRequired) or tonumber(item.questID)) or nil
            if numericQuestID and type(displayQuestText) == "string" and displayQuestText:match("^%d+$") then
                displayQuestText = "Quest #" .. numericQuestID
            end

            questText:SetText(string.format("  - %s", displayQuestText))
            row.textString = questText
            AttachFullItemTooltip(row, item)

            -- Update quest title async when it loads.
            if numericQuestID and (displayQuestText:match("^Quest%s+#%d+") or (type(item._questName) == "string" and item._questName:match("^%d+$"))) then
                local resolver = _G.HousingQuestTitleResolver
                if resolver and resolver.GetTitle then
                    resolver:GetTitle(numericQuestID, function(title)
                        if not frame or not frame.IsShown or not frame:IsShown() then return end
                        if not questText or not questText.SetText then return end
                        questText:SetText(string.format("  - %s", title))
                    end)
                end
            end

            yOffset = yOffset - 16
        end
        yOffset = yOffset - 5
    end
    
    if #outstanding.achievements > 0 and showAchievements then
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
            local row = CreatePopupItemRow(frame.content, 15, yOffset, itemRowWidth, 16)

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
    
    if #outstanding.drops > 0 and showDrops then
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
            local row = CreatePopupItemRow(frame.content, 15, yOffset, itemRowWidth, 16)

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

    if outstanding.professions and #outstanding.professions > 0 and showProfessions then
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
            local row = CreatePopupItemRow(frame.content, 15, yOffset, itemRowWidth, 16)

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
    
    frame.content:SetHeight(math.abs(yOffset) + 20)

    if self.ApplyPopupResizeLayout then
        self:ApplyPopupResizeLayout(frame)
    end
    if self.ApplyPopupFontScale then
        self:ApplyPopupFontScale(frame)
    end

    self:ApplyPopupTheme(frame)
    frame:Show()
end


return OutstandingItemsUI
