-- Dragonflight specific changes

local _, IDTip = ...

if IDTip.Helpers.IsDragonflight() or IDTip.Helpers.IsPTR() then
	do
		IDTip:Log("Dragonflight Loaded")

		IDTip:RegisterAddonLoad("Blizzard_AchievementUI", function()
			hooksecurefunc(AchievementTemplateMixin, "OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 0, 0)
				IDTip:addLine(GameTooltip, self.id, IDTip.kinds.achievement)
				GameTooltip:Show()
			end)

			hooksecurefunc("AchievementFrameSummaryAchievement_OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 0, 0)
				IDTip:addLine(GameTooltip, self.id, IDTip.kinds.achievement)
				GameTooltip:Show()
			end)

			local hooked = {}

			local fr = AchievementTemplateMixin:GetObjectiveFrame()
			hooksecurefunc(fr, "GetMiniAchievement", function(self, index)
				local frame = self:GetElementAtIndex(
					"MiniAchievementTemplate",
					self.miniAchivements,
					index,
					AchievementButton_LocalizeMiniAchievement
				)

				if hooked[frame] then
					return
				end

				hooked[frame] = true

				frame:HookScript("OnEnter", function(self)
					local button = self:GetParent() and self:GetParent():GetParent()
					if not button or not button.id then
						return
					end

					local achievementList = {}
					for i in next, achievementList do
						achievementList[i] = nil
					end

					local achievementID = button.id

					tinsert(achievementList, 1, achievementID)
					while GetPreviousAchievement(achievementID) do
						tinsert(achievementList, 1, GetPreviousAchievement(achievementID))
						achievementID = GetPreviousAchievement(achievementID)
					end

					local aid = achievementList[index]
					-- GameTooltip:SetOwner(button:GetParent(), "ANCHOR_NONE")
					-- GameTooltip:SetPoint("TOPLEFT", button, "TOPRIGHT", 0, 0)
					IDTip:addLine(GameTooltip, aid, IDTip.kinds.achievement)
					GameTooltip:Show()
				end)

				frame:HookScript("OnLeave", function()
					GameTooltip:Hide()
				end)
			end)

			hooksecurefunc(fr, "GetCriteria", function(self, index)
				local frame = self:GetElementAtIndex(
					"AchievementCriteriaTemplate",
					self.criterias,
					index,
					AchievementFrame_LocalizeCriteria
				)

				if hooked[frame] then
					return
				end

				hooked[frame] = true

				frame:HookScript("OnEnter", function(self)
					local button = self:GetParent() and self:GetParent():GetParent()
					if not button or not button.id then
						return
					end

					local criteriaid = select(10, GetAchievementCriteriaInfo(button.id, index))
					GameTooltip:SetOwner(button:GetParent(), "ANCHOR_NONE")
					GameTooltip:SetPoint("TOPLEFT", button, "TOPRIGHT", 0, 0)
					IDTip:addLine(GameTooltip, button.id, IDTip.kinds.achievement)
					IDTip:addLine(GameTooltip, criteriaid, IDTip.kinds.criteria)
					GameTooltip:Show()
				end)

				frame:HookScript("OnLeave", function()
					GameTooltip:Hide()
				end)
			end)
		end)

		if not IDTip.Helpers.IsPTR() then -- TODO: Remove this eventually
			TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(self, a)
				local id = select(2, self:GetSpell())
				IDTip:addLine(self, id, IDTip.kinds.spell)

				local outputItemInfo = C_TradeSkillUI.GetRecipeOutputItemData(id, nil)
				if outputItemInfo and outputItemInfo.itemID then
					IDTip:addGenericLine(self, "== Recipe Output ==")
					IDTip:addLine(self, outputItemInfo.itemID, IDTip.kinds.item)
				end
			end)
		else
			GameTooltip:HookScript("OnTooltipSetSpell", function(self)
				local id = select(2, self:GetSpell())
				IDTip:addLine(self, id, IDTip.kinds.spell)
			end)
		end

		hooksecurefunc(NameplateBuffButtonTemplateMixin, "OnEnter", function(self)
			IDTip:addLine(NamePlateTooltip, self.spellID, IDTip.kinds.spell)
			IDTip:addLine(GameTooltip, self.spellID, IDTip.kinds.spell)
		end)

		hooksecurefunc(GameTooltip, "SetUnitBuffByAuraInstanceID", function(self, unit, auraInstanceID)
			local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID)
			if aura then
				IDTip:addLine(GameTooltip, aura.spellId, IDTip.kinds.spell)
			end
		end)

		hooksecurefunc(GameTooltip, "SetUnitDebuffByAuraInstanceID", function(self, unit, auraInstanceID)
			local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID)
			if aura then
				IDTip:addLine(GameTooltip, aura.spellId, IDTip.kinds.spell)
			end
		end)

		hooksecurefunc(SpellButtonMixin, "OnEnter", function(self)
			local slot = SpellBook_GetSpellBookSlot(self)
			local spellID = select(2, GetSpellBookItemInfo(slot, SpellBookFrame.bookType))
			IDTip:addLine(GameTooltip, spellID, IDTip.kinds.spell)
		end)

		hooksecurefunc(TalentDisplayMixin, "SetTooltipInternal", function(self)
			if self then
				local spellID = self:GetSpellID()
				if spellID then
					local overrideSpellID = C_SpellBook.GetOverrideSpell(spellID)

					IDTip:addLine(GameTooltip, overrideSpellID, IDTip.kinds.spell)
					IDTip:addLine(GameTooltip, self.entryID, IDTip.kinds.traitentry)
					IDTip:addLine(GameTooltip, self.definitionID, IDTip.kinds.traitdef)
					IDTip:addLine(GameTooltip, C_ClassTalents.GetActiveConfigID(), IDTip.kinds.traitconfig)
					IDTip:addLine(GameTooltip, self:GetNodeInfo().ID, IDTip.kinds.ctrait)
				end
			end
		end)

		if not IDTip.Helpers.IsPTR() then -- TODO: Remove this eventually
			hooksecurefunc(GameTooltip, "SetRecipeResultItemForOrder", function(self, id)
				IDTip:addLine(self, id, IDTip.kinds.spell)
			end)
		end

		local function onTooltipSetUnitFunction(tooltip, tooltipData)
			if not isClassicWow then
				if C_PetBattles.IsInBattle() then
					return
				end
			end
			local unit = select(2, tooltip:GetUnit())
			if unit then
				local guid = UnitGUID(unit) or ""
				local id = tonumber(guid:match("-(%d+)-%x+$"), 10)
				if id and guid:match("%a+") ~= "Player" then
					IDTip:addLine(GameTooltip, id, IDTip.kinds.unit)
					-- IDTip:addLine(GameTooltip, guid, IDTip.kinds.guid)
				end
			end
		end
		if not IDTip.Helpers.IsPTR() then -- TODO: Remove this eventually
			TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, onTooltipSetUnitFunction)
		end

		IDTip:RegisterAddonLoad("Blizzard_Collections", function()
			hooksecurefunc(CollectionWardrobeUtil, "SetAppearanceTooltip", function(self, sources)
				local visualIDs = {}
				local sourceIDs = {}
				local itemIDs = {}

				for i = 1, #sources do
					if sources[i].visualID and not IDTip.Helpers.contains(visualIDs, sources[i].visualID) then
						table.insert(visualIDs, sources[i].visualID)
					end
					if sources[i].sourceID and not IDTip.Helpers.contains(visualIDs, sources[i].sourceID) then
						table.insert(sourceIDs, sources[i].sourceID)
					end
					if sources[i].itemID and not IDTip.Helpers.contains(visualIDs, sources[i].itemID) then
						table.insert(itemIDs, sources[i].itemID)
					end
				end

				if #visualIDs ~= 0 then
					IDTip:addLine(GameTooltip, visualIDs, IDTip.kinds.visual)
				end
				if #sourceIDs ~= 0 then
					IDTip:addLine(GameTooltip, sourceIDs, IDTip.kinds.source)
				end
				if #itemIDs ~= 0 then
					IDTip:addLine(GameTooltip, itemIDs, IDTip.kinds.item)
				end
			end)
		end)

		hooksecurefunc(GameTooltip, "SetCurrencyByID", function(self, id)
			IDTip:addLine(self, id, IDTip.kinds.currency)
		end)

		hooksecurefunc(ProfessionSpecTabMixin, "OnEnter", function(self)
			IDTip:addLine(GameTooltip, self.traitTreeID, IDTip.kinds.profspectreeid)
		end)

		local function hookProfSpecPathEnter(self)
			local nid = self:GetNodeID()
			local cid = self:GetConfigID()
			-- local eid = C_ProfSpecs.GetUnlockEntryForPath(self:GetNodeID());
			local info = C_Traits.GetNodeInfo(cid, nid)
			if info.activeEntry then
				local eid = info.activeEntry.entryID
				local entry = C_Traits.GetEntryInfo(cid, eid)
				local did = entry.definitionID
				IDTip:addLine(GameTooltip, eid, IDTip.kinds.traitentry)
				IDTip:addLine(GameTooltip, did, IDTip.kinds.traitdef)
			end

			local f = self:GetTalentFrame()
			local rnid = f:GetRootNodeID()
			IDTip:addLine(GameTooltip, rnid, IDTip.kinds.rootprofspecnode)
			IDTip:addLine(GameTooltip, nid, IDTip.kinds.profspecnode)
			IDTip:addLine(GameTooltip, self:GetConfigID(), IDTip.kinds.traitconfig)
		end

		ProfessionsFrame.SpecPage.DetailedView.Path:HookScript("OnEnter", hookProfSpecPathEnter)

		hooksecurefunc(ProfessionsSpecPathMixin, "OnEnter", hookProfSpecPathEnter)

		-- local function gameobjecthandler(tooltip, tooltipData)
		--   -- DevTools_Dump(tooltipData)
		--   -- it may be possible to export GameObjects db2 and map GameObject[name][playerMapId] -> displayID/gameObjectID, but it would add probably 10-15MB of data to the addon, they could be seperate support files for users who want that functionality though..
		-- end
		-- TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Object, gameobjecthandler)
	end
end
