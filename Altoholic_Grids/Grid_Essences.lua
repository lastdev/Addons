local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local essenceList
local view

local function BuildView()
	essenceList = {}
	view = {}
	
	local account, realm = AltoholicTabGrids:GetAccount()
	
	if realm then
        for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this account
    		local essences = DataStore:GetAzeriteEssences(character)
            if essences then
        		for name, essence in pairs(essences) do
        			if not essenceList[name] then
                        essenceList[name] = {}
                        essenceList[name].isValidFor = {}
                        essenceList[name].unlockedBy = {}
                        essenceList[name].currentRank = {}
                        essenceList[name].icon = essence.icon
                    end
                    
                    essenceList[name].isValidFor[character] = true
                    essenceList[name].unlockedBy[character] = essence.unlocked
                    essenceList[name].currentRank[character] = essence.rank
        		end
            end
    	end
    else
        for realm in pairs(DataStore:GetRealms(account)) do
            for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this account
        		local essences = DataStore:GetAzeriteEssences(character)
                if essences then
            		for name, essence in pairs(essences) do
            			if not essenceList[name] then
                            essenceList[name] = {}
                            essenceList[name].isValidFor = {}
                            essenceList[name].unlockedBy = {}
                            essenceList[name].currentRank = {}
                            essenceList[name].icon = essence.icon
                        end
                        
                        essenceList[name].isValidFor[character] = true
                        essenceList[name].unlockedBy[character] = essence.unlocked
                        essenceList[name].currentRank[character] = essence.rank
            		end
                end
        	end
        end
    end
	
	for k, v in pairs(essenceList) do
		table.insert(view, k)
	end

	table.sort(view, function(a,b) 
		return a < b
	end)
end

local callbacks = {
	OnUpdate = function() 
			BuildView()
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local name = view[dataRowID]
			if name then
				rowFrame.Name.Text:SetText(format("%s%s", colors.white, name))
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function() end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			if essenceList[view[dataRowID]].isValidFor[character] then
    			button.Name:SetFontObject("NumberFontNormalLarge")
    			button.Name:SetJustifyH("CENTER")
    			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
    			button.Background:SetDesaturated(false)
    			button.Background:SetTexCoord(0, 1, 0, 1)
    			button.Background:SetTexture(essenceList[view[dataRowID]].icon)

                if essenceList[view[dataRowID]].unlockedBy[character] then
    				button.Background:SetVertexColor(1.0, 1.0, 1.0)
    				local rank = essenceList[view[dataRowID]].currentRank[character] 
                    if rank == 4 then
                        rank = icons.ready
                    end
                    button.Name:SetText(format("%s%s", colors.white, rank))
    			else
    				button.Background:SetVertexColor(0.4, 0.4, 0.4)
    				button.Name:SetText(icons.notReady)
    			end
            else
                button:Hide()
            end
		end,
	OnEnter = nil,
	OnClick = nil,
	OnLeave = nil,
		
	InitViewDDM = function(frame, title) 
			frame:Hide()
			title:Hide()
		end,
}

AltoholicTabGrids:RegisterGrid(5, callbacks)
