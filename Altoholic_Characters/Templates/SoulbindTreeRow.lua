local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.SoulbindTreeRow", {
	Update = function(frame, character, soulbindData, row)
		-- attempt to see if the row may be moved up a little (because the whole frame only has room for 7 rows, not 8)
		local isMovable = true
		
		local parent = frame:GetParent()
		local previousRow = parent["Tier"..(row - 1)]	-- ex: this is Tier3, we want to check Tier2
		
		for column = 1, 3 do
			local button = frame["Talent" .. column]
			
			button:Hide()	-- hide the button, unless we find data for it
			
			for _, node in pairs(soulbindData.tree.nodes) do
				-- tier - 1 because rows go from 0 to 7
				-- show the node only if it is part of the tree
				if node.row == (row - 1) and node.column == (column - 1) then
					button:Show()
					button.spellID = node.spellID
					
					local state, conduitID, conduitRank, conduitType, reason = DataStore:GetSoulbindInfo(character, node.ID)
					button.reason = reason
					
					-- Set the right icon
					local icon
					
					if node.spellID ~= 0 then		-- it's a spell
						icon = select(3, GetSpellInfo(button.spellID or 0))
					
					elseif conduitID ~= 0 then		-- it's an item
						local itemID = select(2, DataStore:GetConduitInfo(character, conduitID))
						icon = GetItemIcon(itemID)
						
						button.conduitID = conduitID
						button.conduitRank = conduitRank
					elseif conduitType ~= -1 then		-- it's an empty socket for a conduit
						button.conduitType = conduitType
					end
					
					if icon then
						button:SetIcon(icon)
					end
					
					if state == Enum.SoulbindNodeState.Unavailable or 
						state == Enum.SoulbindNodeState.Unselected then
						
						button:DisableIcon()
						button.Border:Hide()
					else
						button:EnableIcon()
						button.Border:Show()
					end
				end
			end

			-- If the button we just worked on is visible, and the one just above it is also visible, then the whole row may not move
			if row == 1 then
				isMovable = false		-- row 1 may never move
			elseif button:IsShown() and previousRow["Talent" .. column]:IsShown() then
				isMovable = false
			end
		end
		
		if isMovable then
			frame:SetPoint("TOPLEFT", previousRow, "BOTTOMLEFT", 0, -2)
		end
		
		frame:Show()
	end,
})
