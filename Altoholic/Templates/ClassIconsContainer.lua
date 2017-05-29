local addonName = "Altoholic"
local addon = _G[addonName]

local function _UpdateClassIcons(frame, account, realm)
	local tabName = frame.tabName
	local numIcons = frame.numIcons
	
	local key = addon:GetOption(format("Tabs.%s.%s.%s.Column1", tabName, account, realm))
	if not key then	-- first time this realm is displayed, or reset by player
	
		local index = 1

		-- add the first 11 keys found on this realm
		for characterName, characterKey in pairs(DataStore:GetCharacters(realm, account)) do	
			-- ex: : ["Tabs.Grids.Default.MyRealm.Column4"] = "Account.realm.alt7"

			addon:SetOption(format("Tabs.%s.%s.%s.Column%d", tabName, account, realm, index), characterKey)
			
			index = index + 1
			if index > numIcons then
				break
			end
		end
		
		while index <= numIcons do
			addon:SetOption(format("Tabs.%s.%s.%s.Column%d", tabName, account, realm, index), nil)
			index = index + 1
		end
	end

	-- Set each class/icon
	for i = 1, numIcons do
		local class, faction, _
		
		key = addon:GetOption(format("Tabs.%s.%s.%s.Column%d", tabName, account, realm, i))
		if key then
			_, class = DataStore:GetCharacterClass(key)
			faction = DataStore:GetCharacterFaction(key)
		end
		
		frame[frame.iconPrefix..i]:SetClass(class, faction)
	end
end

addon:RegisterClassExtensions("AltoClassIconsContainer", {
	Update = _UpdateClassIcons
})
