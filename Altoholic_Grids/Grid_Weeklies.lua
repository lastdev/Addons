local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)
local ICON_VIEW_QUESTS = "Interface\\LFGFrame\\LFGIcon-Quest"

local tab = AltoholicFrame.TabGrids

local questList
local view

local function BuildView()
	questList = {}
	view = {}
	
	-- Dailies are actual dailies that have been completed, + emissaries that have been completed
	for _, character in pairs(DataStore:GetCharacters(tab:GetRealm())) do	-- all alts on this realm
		local num = DataStore:GetWeekliesHistorySize(character) or 0
		for i = 1, num do
			local id, title = DataStore:GetWeekliesHistoryInfo(character, i)
			
			if not questList[id] then
				questList[id] = {}
				questList[id].title = title
				questList[id].completedBy = {}
			end
			
			questList[id].completedBy[character] = true
		end
	end
	
	for k, v in pairs(questList) do
		table.insert(view, k)
	end

	table.sort(view, function(a,b) 
		return questList[a].title < questList[b].title
	end)
end

tab:RegisterGrid(14, {
	OnUpdate = function() 
		BuildView()
		if not questList then
			DataStore:ListenTo("DATASTORE_QUEST_TURNED_IN", function(event, sender, character)
				BuildView()
				tab:Update()
			end)
		end
		
		tab:SetStatus(format("%s%s|r / %s%s", 
			colors.white, QUESTS_LABEL, 
			colors.green, L["Weekly Quests"]))
	end,
	
	GetSize = function() return #view end,
	
	RowSetup = function(self, rowFrame, dataRowID)
		local questID = view[dataRowID]
		local questTitle = questList[questID].title
		local button = rowFrame.Name
		
		button.questID = questID
		button.questTitle = questTitle
		
		if questTitle then

			button.Text:SetText(format("%s%s", colors.white, questTitle))
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
		button.Name:SetFontObject("GameFontNormalSmall")
		button.Name:SetJustifyH("CENTER")
		button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
		
		button.Background:SetDesaturated(false)
		button.Background:SetTexCoord(0, 1, 0, 1)
		button.Background:SetTexture(ICON_VIEW_QUESTS)

		local icons = AddonFactory.Icons
		
		if questList[view[dataRowID]].completedBy[character]  then
			button.Background:SetVertexColor(1.0, 1.0, 1.0)
			button.Name:SetText(icons.ready)
		else
			button.Background:SetVertexColor(0.4, 0.4, 0.4)
			button.Name:SetText(icons.notReady)
		end
	end,
})
