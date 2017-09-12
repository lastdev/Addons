local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon:Controller("AltoholicUI.QuestLogRow", {
	SetName = function(frame, name, level)
		frame.Name.Text:SetText(format("%s[%s%d%s] |r%s", colors.white, colors.cyan, level, colors.white, name))
	end,
	SetType = function(frame, tagID)
		local icon = frame.QuestType.Icon
		
		local tagCoords = QUEST_TAG_TCOORDS[tagID]
		if tagCoords then
			icon:SetTexture("Interface\\QuestFrame\\QuestTypeIcons")
			icon:SetTexCoord(unpack(tagCoords))
		else
			icon:SetTexture("Interface\\LFGFrame\\LFGIcon-Quest")
			icon:SetTexCoord(0, 1, 0, 1)
		end
		icon:Show()
	end,
	SetLevel = function(frame, level)
		frame.Level:SetText(format("%s%s", colors.cyan, level))
		frame.Level:Show()
	end,

	-- SetRewards = function(frame, rewards)
		-- frame.Reward1:Hide()
		-- frame.Reward2:Hide()
		
		-- local index = 2
		-- for id, reward in pairs(rewards) do
			-- local button = frame["Reward" ..index]
			-- button:SetReward(reward)
			-- index = index - 1
		-- end
	-- end,

	Name_OnEnter = function(frame)
		local id = frame:GetID()
		if id == 0 then return end

		local character = addon.Tabs.Characters:GetAltKey()
		local questName, questID, link, _, level = DataStore:GetQuestLogInfo(character, id)
		if not link then return end

		GameTooltip:ClearLines()
		GameTooltip:SetOwner(frame.Name, "ANCHOR_LEFT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:AddLine(" ",1,1,1)
		
		GameTooltip:AddDoubleLine(format("%s: %s%d", LEVEL, colors.teal, level), format("%s: %s%d", L["QuestID"], colors.teal, questID))
		
		local player = addon.Tabs.Characters:GetAlt()
		addon:ListCharsOnQuest(questName, player, GameTooltip)
		GameTooltip:Show()
	end,
})
