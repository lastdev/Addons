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
	
	local account, realm = AltoholicTabGrids:GetAccount()
	
	-- parse the emissary quests, but only the ones that have NOT been completed
    if realm then
    	for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this realm
    		for questID, _ in pairs(DataStore:GetEmissaryQuests()) do
                if (not addon:GetOption(OPTION_TOKEN)) or 
                        ((addon:GetOption(OPTION_TOKEN) == EXPANSION_NAME6) and questID < 50000) or
                        ((addon:GetOption(OPTION_TOKEN) == EXPANSION_NAME7) and questID > 50000) then
  
        			local isOnQuest, questLogIndex = DataStore:IsCharacterOnQuest(character, questID)
                    local isCompleted = DataStore:IsQuestCompletedBy(character, questID)
        			local _, _, timeLeft, objective, emissaryQuestName = DataStore:GetEmissaryQuestInfo(character, questID)
        			
        			if timeLeft and timeLeft > 0 then
        				local questName = DataStore:GetQuestLogInfo(character, questLogIndex)
                        if not questName then questName = emissaryQuestName end
                        if not emissaryQuestName then questName = C_QuestLog.GetTitleForQuestID(questID) end
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
            
            if (not addon:GetOption(OPTION_TOKEN)) or (addon:GetOption(OPTION_TOKEN) == EXPANSION_NAME7) then
                for questID, _ in pairs(DataStore:GetRegularZoneQuests()) do
                    local isOnQuest, questLogIndex = DataStore:IsCharacterOnQuest(character, questID)
                    local isCompleted = DataStore:IsQuestCompletedBy(character, questID)
        			local numFulfilled, numRequired, timeLeft, objective, questName = DataStore:GetRegularZoneQuestInfo(character, questID)
        			
        			if numRequired and timeLeft and timeLeft > 0 then
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
    else
        for realm in pairs(DataStore:GetRealms(account)) do
        	for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this realm
        		for questID, _ in pairs(DataStore:GetEmissaryQuests()) do
                    if (not addon:GetOption(OPTION_TOKEN)) or 
                            ((addon:GetOption(OPTION_TOKEN) == EXPANSION_NAME6) and questID < 50000) or
                            ((addon:GetOption(OPTION_TOKEN) == EXPANSION_NAME7) and questID > 50000) then
                            -- TODO: In Badowlands, find the questIDs of emissaries there and extend this out  
            			local isOnQuest, questLogIndex = DataStore:IsCharacterOnQuest(character, questID)
                        local isCompleted = DataStore:IsQuestCompletedBy(character, questID)
            			local _, _, timeLeft, objective, emissaryQuestName = DataStore:GetEmissaryQuestInfo(character, questID)
            			
            			if timeLeft and timeLeft > 0 then
            				local questName = DataStore:GetQuestLogInfo(character, questLogIndex)
                            if not questName then questName = emissaryQuestName end
                            if not emissaryQuestName then questName = C_QuestLog.GetQuestInfo(questID) end
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
                
                if (not addon:GetOption(OPTION_TOKEN)) or (addon:GetOption(OPTION_TOKEN) == EXPANSION_NAME7) then
                    for questID, _ in pairs(DataStore:GetRegularZoneQuests()) do
                        local isOnQuest, questLogIndex = DataStore:IsCharacterOnQuest(character, questID)
                        local isCompleted = DataStore:IsQuestCompletedBy(character, questID)
            			local numFulfilled, numRequired, timeLeft, objective, questName = DataStore:GetRegularZoneQuestInfo(character, questID)
            			
            			if numRequired and timeLeft and timeLeft > 0 then
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
        end
    end

	-- .. and only when the questList table is ready with emissaries info for all alts, loop again on the dailies
	for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this realm
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

local function OnTokenChange(self, header)
	addon:SetOption(OPTION_TOKEN, header)
	AltoholicTabGrids:SetViewDDMText(header)

	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function OnTokensAllInOne(self)
	addon:SetOption(OPTION_TOKEN, nil)
	AltoholicTabGrids:SetViewDDMText(L["All-in-one"])

	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function DropDown_Initialize(frame)
	frame:AddButtonWithArgs(EXPANSION_NAME6, nil, OnTokenChange, EXPANSION_NAME6, nil, (addon:GetOption(OPTION_TOKEN) == EXPANSION_NAME6))
	frame:AddButtonWithArgs(EXPANSION_NAME7, nil, OnTokenChange, EXPANSION_NAME7, nil, (addon:GetOption(OPTION_TOKEN) == EXPANSION_NAME7))
	frame:AddButtonWithArgs(L["All-in-one"], nil, OnTokensAllInOne, nil, nil, (addon:GetOption(OPTION_TOKEN) == nil))
	frame:AddCloseMenu()
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
				local numFulfilled, numRequired, timeLeft, objective, questName = DataStore:GetEmissaryQuestInfo(character, questID)
                if not numFulfilled then
                    numFulfilled, numRequired, timeLeft, objective, questName = DataStore:GetRegularZoneQuestInfo(character, questID)
                end

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
	OnEnter = function(self)
			local character = self.key
			local questID = self.questID
			local quest = questList[questID]
			local _, _, timeLeft, objective = DataStore:GetEmissaryQuestInfo(character, questID)
            if not objective then
                _, _, timeLeft, objective = DataStore:GetRegularZoneQuestInfo(character, questID)
            end

			local tooltip = AltoTooltip
			tooltip:SetOwner(self, "ANCHOR_LEFT")
			tooltip:ClearLines()
			tooltip:AddLine(format("%s%s", colors.white, quest.title))
			tooltip:AddLine(format(BONUS_OBJECTIVE_TIME_LEFT, SecondsToTime(quest.timeLeft, true)))
			tooltip:AddLine(" ")
			if quest.completionStatus[character] == QUEST_COMPLETE then
				tooltip:AddLine(format("- %s%s", colors.white, COMPLETE))
			else
				tooltip:AddLine(format("- %s%s", colors.white, objective or ""))
			end
			tooltip:Show()
		end,
	OnClick = nil,
	OnLeave = function(self)
			AltoTooltip:Hide() 
		end,
		
	InitViewDDM = function(frame, title) 
			frame:Show()
			title:Show()
			
			frame:SetMenuWidth(100) 
			frame:SetButtonWidth(20)
			frame:SetText(addon:GetOption(OPTION_TOKEN) or L["All-in-one"])
			frame:Initialize(DropDown_Initialize, "MENU_NO_BORDERS")
		end,
}

AltoholicTabGrids:RegisterGrid(12, callbacks)
