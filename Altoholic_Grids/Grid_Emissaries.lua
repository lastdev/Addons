local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local icons = AddonFactory.Icons

local MVC = LibStub("LibMVC-1.0")
local ICON_VIEW_QUESTS = "Interface\\LFGFrame\\LFGIcon-Quest"

local tab = AltoholicFrame.TabGrids

local questList
local view
local isViewValid

local QUEST_IN_PROGRESS = 1
local QUEST_COMPLETE = 2

local function GetExpansionLabel(level, withVersion)
	local expansion = _G[ format("EXPANSION_NAME%d", level) ]

	return (withVersion) 
		and format("%s[%s%s.0%s] %s%s", colors.white, colors.green, level+1, colors.white, colors.gold, expansion)
		or format("%s%s", colors.white, expansion)
end

local function GetPercentageColor(percent)
	if percent >= 75 then
		return colors.green
	elseif percent >= 50 then
		return colors.yellow
	elseif percent >= 25 then
		return colors.orange
	else
		return colors.red
	end
end

local function BuildView()
	questList = {}
	view = {}
	
	local options = Altoholic_GridsTab_Options
	local currentXPack = options["Emissaries.CurrentXPack"]
	
	-- parse the emissary quests, but only the ones that have NOT been completed
	for _, character in pairs(DataStore:GetCharacters(tab:GetRealm())) do	-- all alts on this realm
		for questID, _ in pairs(DataStore:GetEmissaryQuests()) do
			local isOnQuest, questLogIndex = DataStore:IsCharacterOnQuest(character, questID)
			local _, _, timeLeft, _, _, expansionLevel = DataStore:GetEmissaryQuestInfo(character, questID)

			if isOnQuest and timeLeft and timeLeft > 0 and expansionLevel == currentXPack then
				-- 2021-01-10 : Callings injected as emissaries will cause the player not yet to be "on the quest"
				-- Param 3 : questID important if it is a calling, not used otherwise
				local questName = DataStore:GetQuestName(questID)

				if not questList[questID] then
					questList[questID] = {}
					questList[questID].title = questName
					questList[questID].timeLeft = timeLeft
					questList[questID].completionStatus = {}
					questList[questID].expansionLevel = expansionLevel
				end				

				questList[questID].completionStatus[character] = QUEST_IN_PROGRESS
			end
		end
	end

	-- .. and only when the questList table is ready with emissaries info for all alts, loop again on the dailies
	for _, character in pairs(DataStore:GetCharacters(tab:GetRealm())) do	-- all alts on this realm
		local num = DataStore:GetDailiesHistorySize(character) or 0
		for i = 1, num do
			local questID = DataStore:GetDailiesHistoryInfo(character, i)
			if questList[questID] then
				questList[questID].completionStatus[character] = QUEST_COMPLETE
			end
		end
	end
	
	for k, v in pairs(questList) do
		table.insert(view, k)
	end

	table.sort(view, function(a,b) 
		return questList[a].timeLeft < questList[b].timeLeft
	end)
end

tab:RegisterGrid(12, {
	InvalidateView = function()
		isViewValid = nil
	end,
	OnUpdate = function() 
			if not isViewValid then
				BuildView()
			end
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local questID = view[dataRowID]
			local quest = questList[questID]
			local level = quest.expansionLevel
			local questTitle = quest.title
			local button = rowFrame.Name
			
			button.questID = questID
			button.questTitle = questTitle

			if questTitle then
				button.Text:SetText(format("%s%s\n%s", colors.white, questTitle, GetExpansionLabel(level, true)))
				button.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function(frame)
			local link = DataStore:GetQuestLink(frame.questID, frame.questTitle)
			if not link then return end
			
			AddonFactory_Tooltip:ShowAtCursor(frame, function(tt)
				tt:SetHyperlink(link)
			end)
		end,
	RowOnLeave = function(self)
			AddonFactory_Tooltip:Hide()
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.key = nil
			button.questID = nil

			local questID = view[dataRowID]
			local quest = questList[questID]

			-- if this character has not completed the quest, and it's not in the quest log .. just leave
			local questStatus = quest.completionStatus[character]
			if not questStatus then
				button:Hide()
				return
			end

			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			button.Background:SetTexture(ICON_VIEW_QUESTS)
			button.Background:SetVertexColor(0.3, 0.3, 0.3)

			-- if the quest is fully complete and validated
			local text
			if questStatus == QUEST_COMPLETE then
				text = icons.ready
				button.Background:SetVertexColor(1.0, 1.0, 1.0)
			else			
				local numFulfilled, numRequired, timeLeft = DataStore:GetEmissaryQuestInfo(character, questID)

				-- if not timeLeft or timeLeft == 0 then
				-- 	button:Hide()
				-- 	return
				-- end

				numFulfilled = numFulfilled or 0
				numRequired = numRequired or 1	-- to avoid a division by 0
				local percent = (numFulfilled / numRequired) * 100

				if percent == 0 then
					text = icons.notReady
				else
					text = format("%s%d%%", GetPercentageColor(percent), percent)
					button.Name:SetPoint("BOTTOMRIGHT", 0, 0)
				end
			end

			button.key = character
			button.questID = questID
			button.Name:SetText(text)
			button:Show()
		end,
	OnEnter = function(frame)
			local character = frame.key
			local questID = frame.questID
			local quest = questList[questID]
			local _, _, timeLeft, objective = DataStore:GetEmissaryQuestInfo(character, questID)
			
			AddonFactory_Tooltip:ShowAtCursor(frame, function(tt)
				tt:AddLine(format("%s%s", colors.white, quest.title))
				tt:AddLine(format(BONUS_OBJECTIVE_TIME_LEFT, SecondsToTime(quest.timeLeft, true)))
				tt:AddLine(" ")
				if quest.completionStatus[character] == QUEST_COMPLETE then
					tt:AddLine(format("- %s%s", colors.white, COMPLETE))
				else
					tt:AddLine(format("- %s%s", colors.white, objective or ""))
				end
			end)
		end,
	OnLeave = function(self)
			AddonFactory_Tooltip:Hide() 
		end,

})
