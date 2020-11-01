local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local ICON_VIEW_QUESTS = "Interface\\LFGFrame\\LFGIcon-Quest"
local OPTION_TOKEN = "UI.Tabs.Grids.Emissaries.CurrentTokenType"

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local questList
local view

local QUEST_IN_PROGRESS = 1
local QUEST_COMPLETE = 2

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
	
	local account = AltoholicTabGrids:GetAccount()
	
	-- parse the calling quests, but only the ones that have NOT been completed
    for realm in pairs(DataStore:GetRealms(account)) do
    	for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this account
    		for questID, timeLeft in pairs(DataStore:GetCallingQuests(character)) do
      
      			local isOnQuest, questLogIndex = DataStore:IsCharacterOnQuest(character, questID)
                local isCompleted = DataStore:IsQuestCompletedBy(character, questID)
      			
          		if timeLeft and timeLeft > 0 then
          			local questName = DataStore:GetQuestLogInfo(character, questLogIndex)
                    if not questName then questName = C_QuestLog.GetTitleForQuestID(questID) end
                    if not questName then questName = "" end
          
          			if not questList[questID] then
          				questList[questID] = {}
          				questList[questID].title = questName
          				questList[questID].timeLeft = timeLeft
          				questList[questID].completionStatus = {}
          			end				
          
                    if isOnQuest then
      			        questList[questID].completionStatus[character] = QUEST_IN_PROGRESS
                    elseif isCompleted then
                        questList[questID].completionStatus[character] = QUEST_COMPLETE
                    end
          		end
    		end
    	end
    end

	-- .. and only when the questList table is ready with calling info for all alts, loop again on the dailies
    for realm in pairs(DataStore:GetRealms(account)) do
    	for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this account
    		local num = DataStore:GetDailiesHistorySize(character) or 0
    		for i = 1, num do
    			local questID = DataStore:GetDailiesHistoryInfo(character, i)
    			if questList[questID] then
    				questList[questID].completionStatus[character] = QUEST_COMPLETE
    			end
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

local callbacks = {
	OnUpdate = function() 
			BuildView()
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local name = questList[ view[dataRowID] ].title
			if name then
				rowFrame.Name.Text:SetText(format("%s%s", colors.white, name))
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function() end,
	RowOnLeave = function() end,
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
				text = icons.notReady
			end

			button.key = character
			button.questID = questID
			button.Name:SetText(text)
			button:Show()
		end,
	OnEnter = function(self)
		end,
	OnClick = nil,
	OnLeave = function(self)
			AltoTooltip:Hide() 
		end,
		
	InitViewDDM = function(frame, title) 
			frame:Hide()
			title:Hide()
		end,
}

AltoholicTabGrids:RegisterGrid(18, callbacks)
