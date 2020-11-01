local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local view
local isViewValid

local OPTION_RARESET = "UI.Tabs.Grids.Rares.CurrentRareSet"

local currentDDMText
local currentTexture
local dropDownFrame

local function BuildView()
	view = view or {}
	wipe(view)
	
	local currentRareSet = addon:GetOption(OPTION_RARESET)

	local rareList = DataStore:GetRareList()[currentRareSet][2]
    
    for listKey, rareList in pairs(rareList) do
        table.insert(view, rareList)
    end
	
	isViewValid = true
end

local function OnRareSetChange(self, rareSet)
	dropDownFrame:Close()

	addon:SetOption(OPTION_RARESET, rareSet)
		
	local rareList = DataStore:GetRareList()[rareSet]
	currentDDMText = rareList[1]
	AltoholicTabGrids:SetViewDDMText(currentDDMText)
	
	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function DropDown_Initialize(frame, level)
	if not level then return end

	local info = frame:CreateInfo()
	
	local currentRareSet = addon:GetOption(OPTION_RARESET)
	
	for rareSetKey, rareSet in pairs(DataStore:GetRareList()) do
		info.text = rareSet[1]
		info.func = OnRareSetChange
		info.checked = (currentRareSet == rareSetKey)
		info.arg1 = rareSetKey
		frame:AddButtonInfo(info, level)
	end
end

local callbacks = {
	OnUpdate = function() 
			if not isViewValid then
				BuildView()
			end

			local currentRareSet = addon:GetOption(OPTION_RARESET)
			
			AltoholicTabGrids:SetStatus(DataStore:GetRareList()[currentRareSet][1])
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			rowFrame.Name.Text:SetText(colors.white .. view[dataRowID][5])
			rowFrame.Name.Text:SetJustifyH("LEFT")
		end,
	RowOnEnter = function()	end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Background:SetTexture(nil)
			--button.Background:SetTexCoord(0, 1, 0, 1)
			button.Background:SetDesaturated(false)
        
            if DataStore:GetKilledRares(character) then -- backward compatibility with characters saved before the datastore module was added
                for creatureID, rareData in pairs(DataStore:GetKilledRares(character)) do
                    if view[dataRowID][1] == creatureID then
				        button.Background:SetVertexColor(1.0, 1.0, 1.0)
				        button.key = character
				        button.Name:SetJustifyH("CENTER")
				        button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
				        button.Name:SetFontObject("GameFontNormalSmall")
				        button.Name:SetText(colors.green..DataStore:GetRareKills(character, creatureID))
                        return
                    end
                end
                button.Name:SetJustifyH("CENTER")
				button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
				button.Name:SetFontObject("GameFontNormalSmall")
				button.Name:SetText(icons.notReady)
                return
            end
            button:Hide()
        end,
		
	OnEnter = function(frame) 
		end,
	OnClick = nil,
	OnLeave = function(self) 
		end,
	InitViewDDM = function(frame, title) 
			dropDownFrame = frame
			frame:Show()
			title:Show()

			local currentRareSet = addon:GetOption(OPTION_RARESET)
			
			currentDDMText = DataStore:GetRareList()[currentRareSet][1]
			
			frame:SetMenuWidth(100) 
			frame:SetButtonWidth(20)
			frame:SetText(currentDDMText)
			frame:Initialize(DropDown_Initialize, "MENU_NO_BORDERS")
		end,
}

AltoholicTabGrids:RegisterGrid(20, callbacks)
