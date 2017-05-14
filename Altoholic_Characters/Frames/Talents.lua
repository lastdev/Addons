local addonName = "Altoholic"
local addon = _G[addonName]

local function _Update(frame)
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
	else
		for i = 1, 3 do
			frame["Spec" .. i]:SetWidth(210)
			frame["Spec" .. i]:Update(character, currentClass, i)
		end
		frame.Spec4:Hide()
	end
	
	frame:Show()
end

local function OnPlayerTalentUpdate()
	if AltoholicFrameTalents:IsVisible() then
		AltoholicFrameTalents:Update()
	end
end	

addon:RegisterEvent("PLAYER_TALENT_UPDATE", OnPlayerTalentUpdate)
addon:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", OnPlayerTalentUpdate)

addon:RegisterClassExtensions("AltoTalentPanel", {
	Update = _Update,
})
