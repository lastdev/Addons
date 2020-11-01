local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.ClassIconsContainer", {
	OnBind = function(frame)
		local prefix = frame.iconPrefix
			
		-- auto create the sort buttons, with the quantity passed as key
		for i = 1, frame.numIcons do
			local button = CreateFrame("Button", nil, frame, frame.iconTemplate)
			
			if i == 1 then
				button:SetPoint("TOPLEFT")
			else
				-- attach to previous frame
				button:SetPoint("TOPLEFT", frame[prefix..(i-1)], "TOPRIGHT", 5, 0)
			end
			
			button:SetID(i)
			frame[prefix..i] = button
		end	
	end,
	Update = function(frame, account, realm)
		local tabName = frame.tabName
		local numIcons = frame.numIcons

		local key 
        if realm then
            key = addon:GetOption(format("Tabs.%s.%s.%s.Column1", tabName, account, realm))
        else
            key = addon:GetOption(format("Tabs.%s.%s.Column1", tabName, account))
        end
		if not key then	-- first time this account is displayed, or reset by player		
			local index = 1

			-- add the first 11 keys found on this account
			if realm then
                for characterName, characterKey in pairs(DataStore:GetCharacters(realm, account)) do	
    				-- ex: : ["Tabs.Grids.Default.Column4"] = "Account.realm.alt7"
    
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
            else
                for realm in pairs(DataStore:GetRealms(account)) do
                    for characterName, characterKey in pairs(DataStore:GetCharacters(realm, account)) do	
        				-- ex: : ["Tabs.Grids.Default.Column4"] = "Account.realm.alt7"
        
        				addon:SetOption(format("Tabs.%s.%s.Column%d", tabName, account, index), characterKey)
        				
        				index = index + 1
        				if index > numIcons then
        					break
        				end
        			end
                end
                while index <= numIcons do
    				addon:SetOption(format("Tabs.%s.%s.Column%d", tabName, account, index), nil)
				    index = index + 1
			    end
            end
		end

		-- Set each class/icon
		for i = 1, numIcons do
			local class, faction
			
			if realm then
                key = addon:GetOption(format("Tabs.%s.%s.%s.Column%d", tabName, account, realm, i)) 
            else
                key = addon:GetOption(format("Tabs.%s.%s.Column%d", tabName, account, i))
            end
			if key then
				_, class = DataStore:GetCharacterClass(key)
				faction = DataStore:GetCharacterFaction(key)
			end
			frame[frame.iconPrefix..i]:SetClass(class, faction)
		end
	end,
})
