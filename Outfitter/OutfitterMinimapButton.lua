function Outfitter:GetMinimapDropdownItems(items)
	-- Just return if not initialized yet
	if not self.Initialized then
		return
	end

	-- Add controls for the addon
	items:AddCategoryTitle(self.cTitleVersion)
	items:AddFunction(self.cOpenOutfitter, function ()
		self:OpenUI()
		end)
	items:AddToggle(self.cAutoSwitch,
		function ()
			return self.Settings.Options.DisableAutoSwitch
		end, function (menu, value)
			self:SetAutoSwitch(self.Settings.Options.DisableAutoSwitch)
		end)

	-- Add the outfits
	self:GetMinimapOutfitItems(items)
end

function Outfitter:GetMinimapOutfitItems(items)
	-- Just return if not initialized yet
	if not self.Initialized then
		return
	end

	--
	local inventoryCache = self:GetInventoryCache()
	local categoryOrder = self:GetCategoryOrder()

	for _, categoryID in ipairs(categoryOrder) do
		local categoryName = self["c"..categoryID.."Outfits"]
		local outfits = self:GetOutfitsByCategoryID(categoryID)

		if self:HasVisibleOutfits(outfits) then
			items:AddCategoryTitle(categoryName)

			for vIndex, outfit in ipairs(outfits) do
				if self:OutfitIsVisible(outfit) then
					local wearingOutfit = Outfitter:WearingOutfit(outfit)
					local missingItems, bankedItems = inventoryCache:GetMissingItems(outfit)
					local itemColor = nil

					if missingItems then
						itemColor = RED_FONT_COLOR
					elseif bankedItems then
						itemColor = Outfitter.BANKED_FONT_COLOR
					end

					items:AddToggleWithIcon(outfit:GetName(), self.OutfitBar:GetOutfitTexture(outfit), itemColor,
						function ()
							return wearingOutfit
						end, function (menu, value)
							local categoryID = outfit.CategoryID
							local doToggle = categoryID ~= "Complete"

							if IsModifierKeyDown() then
								self:AskSetCurrent(outfit)
							elseif doToggle
							and self:WearingOutfit(outfit) then
								self:RemoveOutfit(outfit)
							else
								self:WearOutfit(outfit)
							end
						end)
					--[[
					Outfitter:AddMenuItem(
							pFrame,
							outfit:GetName(),
							{CategoryID = categoryID, Index = vIndex},
							wearingOutfit, -- Checked
							nil, -- Level
							itemColor, -- Color
							nil, -- Disabled
							{icon = Outfitter.OutfitBar:GetOutfitTexture(outfit)})
					]]
				end
			end
		end
	end
end