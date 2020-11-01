local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local CHARS_PER_FRAME = 12

addon:Controller("AltoholicUI.AchievementRow", {
	Update = function(frame, account, realm, allianceID, hordeID)
		local _, achName, _, isComplete, _, _, _, _, flags = GetAchievementInfo(allianceID)
		
		-- if not achName then 
			-- DEFAULT_CHAT_FRAME:AddMessage(allianceID)
			-- achName = allianceID
		-- end
		
		local isAccountBound = ( bit.band(flags, ACHIEVEMENT_FLAGS_ACCOUNT) == ACHIEVEMENT_FLAGS_ACCOUNT ) 
		
		frame.Name.Text:SetText(format("%s%s", (isAccountBound and colors.cyan or colors.white), achName))
		frame.Name.Text:SetJustifyH("LEFT")
		frame.id = allianceID
		
		local button
		local character
		local achievementID
        
        local current_start_col, start_char_index = addon:GetAchievementsCurrentColumnScrollInfo()		
        local current_end_col = current_start_col + CHARS_PER_FRAME
        if current_end_col > 50 then current_end_col = 50 end
		
        for colIndex = 1, 50 do
			button = frame["Item"..colIndex]
			button.IconBorder:Hide()
			
			if realm then
                character = addon:GetOption(format("Tabs.Achievements.%s.%s.Column%d", account, realm, colIndex))
            else
                character = addon:GetOption(format("Tabs.Achievements.%s.Column%d", account, colIndex))
            end
			if character then
				if hordeID and DataStore:GetCharacterFaction(character) ~= "Alliance" then
					achievementID = hordeID
				else
					achievementID = allianceID
				end
				
				button:SetImage(achievementID)
				button:SetCompletionStatus(character, achievementID, isAccountBound)
				
				-- do not remove this one, the button achievement ID could be different than that of the row
				-- row could be alliance, and button could be horde
				button:SetInfo(character, achievementID)
				button:Show()
                
                button:ClearAllPoints()
                if (colIndex < current_start_col) or (colIndex >= current_end_col) then
                    -- Column is out of range, hide it
                    button:Hide()
                elseif colIndex == current_start_col then
                    -- Column is the left-most one, anchor it to the left
                    button:SetPoint("BOTTOMRIGHT", frame["Name"], "BOTTOMRIGHT", 50, 0)
                else
                    -- Column is in the middle, anchor it to the one next to it
                    button:SetPoint("BOTTOMLEFT", frame["Item"..(colIndex-1)], "BOTTOMLEFT", 35, 0)
                end
			else
				button:SetInfo(nil, nil)
				button:Hide()
			end
		end
		frame:Show()
	end,
	Name_OnEnter = function(frame)
		local achievementID = frame.id
		local _, achName, points, _, _, _, _, description, flags, image, rewardText = GetAchievementInfo(achievementID)

		local tooltip = AltoTooltip
		tooltip:ClearLines()
		tooltip:SetOwner(frame.Name, "ANCHOR_TOP")
		tooltip:AddLine(achName)
		tooltip:AddLine(description, 1, 1, 1, 1, 1)
		tooltip:AddLine(" ")
		tooltip:AddLine(format("%s%s: %s%s", colors.white, ACHIEVEMENT_TITLE, colors.green, points))

		-- Add the reward text, if any
		if strlen(rewardText) > 0 then		-- not nil if empty, so test the length of the string
			tooltip:AddLine(" ")
			tooltip:AddLine(format("%s%s", colors.green, rewardText))
		end
		tooltip:AddLine(" ")

		-- Add the achievement ID and whether or not it is account wide
		local isAccountBound = ( bit.band(flags, ACHIEVEMENT_FLAGS_ACCOUNT) == ACHIEVEMENT_FLAGS_ACCOUNT ) 
		local idText = format("ID: %s%d", colors.green , achievementID)
		local accountWideText = format("%s%s", colors.cyan, L["ACCOUNT_WIDE"])
		
		if isAccountBound then
			tooltip:AddDoubleLine(idText, accountWideText)
		else
			tooltip:AddLine(idText)
		end
		tooltip:Show()
	end,
})
