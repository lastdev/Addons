local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TalentPanel", {
	OnBind = function(frame)
		local function OnPlayerTalentUpdate()
			if frame:IsVisible() then
				frame:Update()
			end
		end	

		addon:RegisterEvent("PLAYER_TALENT_UPDATE", OnPlayerTalentUpdate)
		addon:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", OnPlayerTalentUpdate)
	end,
	Update = function(frame)
		frame:Hide()
		
		local character = addon.Tabs.Characters:GetAltKey()
		if not character then return end
		
		AltoholicTabCharacters.Status:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character), TALENTS))
		
		local _, currentClass = DataStore:GetCharacterClass(character)
		if not DataStore:IsClassKnown(currentClass) then return end
		
		local level = DataStore:GetCharacterLevel(character)
		if not level or level < 10 then return end

		if currentClass == "DRUID" then
			for i = 1, 4 do
				frame["Spec" .. i]:SetWidth(150)
				frame["Spec" .. i]:Update(character, currentClass, i)
			end
		elseif currentClass == "DEMONHUNTER" then
			for i = 1, 2 do
				frame["Spec" .. i]:SetWidth(300)
				frame["Spec" .. i]:Update(character, currentClass, i)
			end
			frame.Spec3:Hide()
			frame.Spec4:Hide()
		else
			for i = 1, 3 do
				frame["Spec" .. i]:SetWidth(210)
				frame["Spec" .. i]:Update(character, currentClass, i)
			end
			frame.Spec4:Hide()
		end
		
		frame:Show()
	end,
})
