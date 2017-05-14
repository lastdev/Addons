local addonName = "Altoholic"
local addon = _G[addonName]

local ICON_NOTREADY = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_READY = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"

local OPTION_RACE = "UI.Tabs.Grids.Archaeology.CurrentRace"
local currentItemID

local function OnRaceChange(self)
	addon:SetOption(OPTION_RACE, self.value)

	AltoholicTabGrids:SetViewDDMText(GetArchaeologyRaceInfo(self.value))
	AltoholicTabGrids:Update()
end

local function DropDown_Initialize(frame)
	local numRaces = GetNumArchaeologyRaces()
	local race, icon
	
	local currentRace = addon:GetOption(OPTION_RACE)
	
	for i = 1, numRaces do
		race, icon = GetArchaeologyRaceInfo(i)
		frame:AddButton(race, i, OnRaceChange, icon, (i==currentRace))
	end

	frame:AddCloseMenu()
end

local callbacks = {
	OnUpdate = function()
			AltoholicTabGrids:SetStatus(GetArchaeologyRaceInfo(addon:GetOption(OPTION_RACE)))
		end,
	GetSize = function() return DataStore:GetRaceNumArtifacts(addon:GetOption(OPTION_RACE)) end,
	RowSetup = function(self, rowFrame, dataRowID)
			local artifact = DataStore:GetArtifactInfo(addon:GetOption(OPTION_RACE), dataRowID)
			currentItemID = artifact.itemID
			
			if currentItemID then
				local _, _, _, hexColor = GetItemQualityColor(artifact.rarity)
				local itemName = GetSpellInfo(artifact.spellID)
				
				rowFrame.Name.Text:SetText("|c" .. hexColor .. itemName)
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function()	end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			button.Background:SetTexture(GetItemIcon(currentItemID))
			
			local artifact = DataStore:GetArtifactInfo(addon:GetOption(OPTION_RACE), dataRowID)
			if DataStore:IsArtifactKnown(character, artifact.spellID) then
				button.Background:SetVertexColor(1.0, 1.0, 1.0);
				button.Name:SetText(ICON_READY)
				
				local _, _, itemRarity, itemLevel = GetItemInfo(currentItemID)
				if itemRarity and itemRarity >= 2 then
					local r, g, b = GetItemQualityColor(itemRarity)
					button.IconBorder:SetVertexColor(r, g, b, 0.5)
					button.IconBorder:Show()
				end
			else
				button.Background:SetVertexColor(0.4, 0.4, 0.4);
				button.Name:SetText(ICON_NOTREADY)
			end
			button.id = currentItemID
		end,
	OnEnter = function(self) 
			self.link = nil
			addon:Item_OnEnter(self) 
		end,
	OnClick = function(self, button)
			self.link = nil
			addon:Item_OnClick(self, button)
		end,
	OnLeave = function(self)
			GameTooltip:Hide() 
		end,
		
	InitViewDDM = function(frame, title) 
			frame:Show()
			title:Show()
			
			frame:SetMenuWidth(100) 
			frame:SetButtonWidth(20)
			frame:SetText(GetArchaeologyRaceInfo(addon:GetOption(OPTION_RACE)))
			frame:Initialize(DropDown_Initialize, "MENU_NO_BORDERS")
		end,
}

AltoholicTabGrids:RegisterGrid(8, callbacks)
