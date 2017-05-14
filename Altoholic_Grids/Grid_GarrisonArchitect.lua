local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local BUILDING_ALCHEMY = "AlchemyLab"
local BUILDING_BARN = "Barn"
local BUILDING_BARRACKS = "Barracks"
local BUILDING_DWARVEN_BUNKER = "DwarvenBunker"
local BUILDING_ENCHANTERS_STUDY = "EnchantersStudy"
local BUILDING_ENGINEERING_WORKS = "EngineeringWorks"
local BUILDING_FISHING_SHACK = "FishingShack"
local BUILDING_GEM_BOUTIQUE = "GemBoutique"
local BUILDING_GLADIATORS_SANCTUM = "GladiatorsSanctum"
local BUILDING_GNOMISH_GEARWORKS = "GnomishGearworks"
local BUILDING_HERB_GARDEN = "HerbGarden"
local BUILDING_LUMBER_MILL = "LumberMill"
local BUILDING_LUNARFALL_EXCAVATION = "LunarfallExcavation"
local BUILDING_LUNARFALL_INN = "LunarfallInn"
local BUILDING_MAGE_TOWER = "MageTower"
local BUILDING_MENAGERIE = "Menagerie"
local BUILDING_SALVAGE_YARD = "SalvageYard"
local BUILDING_SCRIBES_QUARTERS = "ScribesQuarters"
local BUILDING_STABLES = "Stables"
local BUILDING_STOREHOUSE = "Storehouse"
local BUILDING_TAILORING_EMPORIUM = "TailoringEmporium"
local BUILDING_THE_FORGE = "TheForge"
local BUILDING_THE_TANNERY = "TheTannery"
local BUILDING_TRADING_POST = "TradingPost"

local BUILDING_TOWN_HALL = "TownHall"


local Buildings = {
	{	-- [1]
		name = OTHER,
		{ 
			buildingType = BUILDING_TOWN_HALL, 
			name = format("%s / %s", GARRISON_TOWN_HALL_ALLIANCE, GARRISON_TOWN_HALL_HORDE), 
			tex = "Interface\\Icons\\inv_garrison_resource",
			id = 0, 
		},
		{ buildingType = BUILDING_LUNARFALL_EXCAVATION, id = 61 },
		{ buildingType = BUILDING_HERB_GARDEN, id = 29 },
		{ buildingType = BUILDING_FISHING_SHACK, id = 64 },
		{ buildingType = BUILDING_MENAGERIE, id = 42 },
	},
	{	-- [2]
		name = nil,	-- "Small"
		{ buildingType = BUILDING_ALCHEMY, id = 76 },
		{ buildingType = BUILDING_ENCHANTERS_STUDY, id = 93 },
		{ buildingType = BUILDING_ENGINEERING_WORKS, id = 91 },
		{ buildingType = BUILDING_GEM_BOUTIQUE, id = 96 },
		{ buildingType = BUILDING_SALVAGE_YARD, id = 52 },
		{ buildingType = BUILDING_SCRIBES_QUARTERS, id = 95 },
		{ buildingType = BUILDING_STOREHOUSE, id = 51 },
		{ buildingType = BUILDING_TAILORING_EMPORIUM, id = 94 },
		{ buildingType = BUILDING_THE_FORGE, id = 60 },
		{ buildingType = BUILDING_THE_TANNERY, id = 90 },
	},
	{	-- [3]
		name = nil,	-- "Medium"
		{ buildingType = BUILDING_BARN, id = 24 },
		{ buildingType = BUILDING_GLADIATORS_SANCTUM, id = 159 },
		{ buildingType = BUILDING_LUMBER_MILL, id = 40 },
		{ buildingType = BUILDING_LUNARFALL_INN, id = 34 },
		{ buildingType = BUILDING_TRADING_POST, id = 111 },
	},
	{	-- [4]
		name = nil,	-- "Large"
		{ buildingType = BUILDING_BARRACKS, id = 26 },
		{ buildingType = BUILDING_DWARVEN_BUNKER, id = 8 },
		{ buildingType = BUILDING_GNOMISH_GEARWORKS, id = 162 },
		{ buildingType = BUILDING_MAGE_TOWER, id = 37 },
		{ buildingType = BUILDING_STABLES, id = 65 },
	},

}

local view
local isViewValid

local OPTION_BUILDINGS = "UI.Tabs.Grids.Garrisons.CurrentBuildings"

local currentDDMText
local dropDownFrame

local function BuildView()
	view = view or {}
	wipe(view)
	
	local currentBuildings = addon:GetOption(OPTION_BUILDINGS)
	
	for i, building in ipairs(Buildings[currentBuildings]) do
		table.insert(view, building)	-- insert the table pointer
	end
	
	isViewValid = true
end

local function OnBuildingTypeSelected(self)
	dropDownFrame:Close()
	
	addon:SetOption(OPTION_BUILDINGS, self.value)
	
	currentDDMText = Buildings[self.value].name
	AltoholicTabGrids:SetViewDDMText(currentDDMText)
	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function DropDown_Initialize(frame, level)
	if not level then return end

	local info = frame:CreateInfo()
	
	local currentBuildings = addon:GetOption(OPTION_BUILDINGS)
	
	if level == 1 then
		for index = 1, #Buildings do
			info.text = Buildings[index].name
			info.func = OnBuildingTypeSelected
			info.checked = (currentBuildings == index)
			info.value = index
			frame:AddButtonInfo(info, level)
		end
		frame:AddCloseMenu()
	end
end

local callbacks = {
	OnUpdate = function()
			if not isViewValid then
				BuildView()
			end
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local v = view[dataRowID]
			local name = v.name or select(2, C_Garrison.GetBuildingInfo(v.id))
			
			if name then
				rowFrame.Name.Text:SetText(colors.white .. name)
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function()	end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("NumberFontNormal")
			button.Name:SetJustifyH("RIGHT")
			button.Name:SetPoint("BOTTOMRIGHT", -3, 0)
			
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			
			local v = view[dataRowID]
			local buildingType = v.buildingType
			local id, level = DataStore:GetBuildingInfo(character, buildingType)
			
			if id and level then	-- if the id exists, this character owns this building type
				button.buildingID = id
				button.Background:SetVertexColor(1.0, 1.0, 1.0)
				
				local tex = v.tex or select(4, C_Garrison.GetBuildingInfo(v.id))
				
				button.Background:SetTexture(tex)
				button.Name:SetText(colors.green .. level)
				button:Show()
			else
				button.buildingID = nil
				button.Name:SetText("")
				button:Hide()
			end
		end,
	OnEnter = function(frame) 
			local buildingID = frame.buildingID
			local _, buildingName, _, _, _, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan, _, _, upgrades, canUpgrade = C_Garrison.GetBuildingInfo(buildingID);
			
			-- from Blizzard_GarrisonBuildingUI.lua / GarrisonBuilding_ShowLevelTooltip()
			
			local Tooltip = AltoholicTabGrids.BuildingLevelTooltip
			
			Tooltip.Name:SetText(buildingName)
			local height = Tooltip.Name:GetHeight() + 30; --15 pixels of padding on top and bottom
			
			Tooltip.FollowerText:SetText(nil);
			Tooltip.Rank1:SetPoint("TOPLEFT", Tooltip.Name, "BOTTOMLEFT", 0, -10);
	
			for i = 1, 3 do
				Tooltip["Rank"..i]:SetFormattedText(GARRISON_CURRENT_LEVEL, i);
			end
			
			if (not upgrades or #upgrades == 0) then
				return;
			end
			
			Tooltip.Rank1Tooltip:SetVertexColor(0.5, 0.5, 0.5, 1);
			Tooltip.Rank2Tooltip:SetVertexColor(0.5, 0.5, 0.5, 1);
			Tooltip.Rank3Tooltip:SetVertexColor(0.5, 0.5, 0.5, 1);
			
			for i = 1, 3 do
				Tooltip["Rank"..i.."Tooltip"]:SetVertexColor(1, 1, 1, 1);
			end
			
			local nextAnchor = nil;
			for i=1, #upgrades do
				local tooltip = C_Garrison.GetBuildingTooltip(upgrades[i]);
				if (tooltip == "") then 
					tooltip = nil 
				end
				
				if (nextAnchor) then
					Tooltip["Rank"..i]:SetPoint("TOPLEFT", nextAnchor, "BOTTOMLEFT", -10, -10);
				end
				local tooltipText = tooltip;
				
				Tooltip["Rank"..i.."Tooltip"]:SetText(tooltipText);
				Tooltip["Rank"..i]:Show();
				Tooltip["Rank"..i.."Tooltip"]:Show();
				--10 pixels padding above rank title, 5 pixels above rank tooltip
				height = height + Tooltip["Rank"..i.."Tooltip"]:GetHeight() + Tooltip["Rank"..i]:GetHeight() + 15;
			end
		
			Tooltip.UnlockText:SetText(nil);
			
			Tooltip:SetHeight(height);
			-- Tooltip:SetPoint("LEFT", frame, "RIGHT", -3, -5);
			Tooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT", 1, 1);
			Tooltip:Show();
		end,
	OnClick = function(frame, button)
		end,
	OnLeave = function(self)
			AltoholicTabGrids.BuildingLevelTooltip:Hide()
		end,
	InitViewDDM = function(frame, title)
			dropDownFrame = frame
			frame:Show()
			title:Show()
			
			local t = C_Garrison.GetBuildingSizes()			-- t[1] = small; t[2] = medium; t[3] = large
			for i = 1, 3 do
				Buildings[i+1].name = t[i].name
			end
			
			local currentBuildings = addon:GetOption(OPTION_BUILDINGS)
			
			currentDDMText = Buildings[currentBuildings].name
			
			frame:SetMenuWidth(100) 
			frame:SetButtonWidth(20)
			frame:SetText(currentDDMText)
			frame:Initialize(DropDown_Initialize, "MENU_NO_BORDERS")
		end,
}

AltoholicTabGrids:RegisterGrid(9, callbacks)
