---------------------------------------------------------
-- Addon declaration
HandyNotes_Directions = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_Directions","AceEvent-3.0")
local HD = HandyNotes_Directions
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_Directions", true)

local debugf = tekDebug and tekDebug:GetFrame("Directions")
local function Debug(...) if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end end

---------------------------------------------------------
-- Our db upvalue and db defaults
local db
local defaults = {
	global = {
		landmarks = {
			["*"] = {},  -- [mapID] = {[coord] = "name", [coord] = "name"}
		},
	},
	profile = {
		icon_scale         = 1.0,
		icon_alpha         = 1.0,
	},
}

---------------------------------------------------------
-- Localize some globals
local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes

---------------------------------------------------------
-- Constants

local icon
local function setupLandmarkIcon(texture, left, right, top, bottom)
	return {
		icon = texture,
		tCoordLeft = left,
		tCoordRight = right,
		tCoordTop = top,
		tCoordBottom = bottom,
	}
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HDHandler = {}
local info = {}
local clickedLandmark = nil
local clickedLandmarkZone = nil
local lastGossip = nil
local currentOptions

function HDHandler:OnEnter(mapID, coord)
	local tooltip = GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	tooltip:SetText(HD.db.global.landmarks[mapID][coord])
	tooltip:Show()
	clickedLandmark = nil
	clickedLandmarkZone = nil
end

local function deletePin(button, mapID, coord)
	HD.db.global.landmarks[mapID][coord] = nil
	HD:SendMessage("HandyNotes_NotifyUpdate", "Directions")
end

local function createWaypoint(button, mapID, coord)
	local x, y = HandyNotes:getXY(coord)
	local name = HD.db.global.landmarks[mapID][coord]
	if TomTom then
		TomTom:AddWaypoint(mapID, x, y, {
			title = name,
			world = false,
			minimap = true,
		})
	end
end

local function generateMenu(button, level)
	if (not level) then return end
	for k in pairs(info) do info[k] = nil end
	if (level == 1) then
		-- Create the title of the menu
		info.isTitle      = 1
		info.text         = "HandyNotes - Directions"
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		if TomTom then
			-- Waypoint menu item
			info.disabled     = nil
			info.isTitle      = nil
			info.notCheckable = true
			info.text = "Create waypoint"
			info.icon = nil
			info.func = createWaypoint
			info.arg1 = clickedLandmarkZone
			info.arg2 = clickedLandmark
			UIDropDownMenu_AddButton(info, level);
		end

		-- Delete menu item
		info.disabled     = nil
		info.isTitle      = nil
		info.notCheckable = true
		info.text = "Delete landmark"
		info.icon = "poi-islands-table"
		info.func = deletePin
		info.arg1 = clickedLandmarkZone
		info.arg2 = clickedLandmark
		UIDropDownMenu_AddButton(info, level);

		-- Close menu item
		info.text         = "Close"
		info.icon         = nil
		info.func         = function() CloseDropDownMenus() end
		info.arg1         = nil
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level);
	end
end

local HD_Dropdown
function HDHandler:OnClick(button, down, mapID, coord)
	if button == "RightButton" and not down then
		if not HD_Dropdown then
			HD_Dropdown = CreateFrame("Frame", "HandyNotes_DirectionsDropdownMenu")
			HD_Dropdown.displayMode = "MENU"
			HD_Dropdown.initialize = generateMenu
		end
		clickedLandmarkZone = mapID
		clickedLandmark = coord
		ToggleDropDownMenu(1, nil, HD_Dropdown, self, 0, 0)
	end
end

function HDHandler:OnLeave(mapFile, coord)
	GameTooltip:Hide()
end

do
	-- This is a custom iterator we use to iterate over every node in a given zone
	local function iter(t, prestate)
		if not t then return nil end
		local state, value = next(t, prestate)
		while state do -- Have we reached the end of this zone?
			if value then
				Debug("iter step", state, icon, db.icon_scale, db.icon_alpha)
				return state, nil, icon, db.icon_scale, db.icon_alpha
			end
			state, value = next(t, state) -- Get next data
		end
		return nil, nil, nil, nil
	end
	function HDHandler:GetNodes2(mapID)
		return iter, HD.db.global.landmarks[mapID], nil
	end
end


---------------------------------------------------------
-- Core functions

local alreadyAdded = {}
function HD:CheckForLandmarks()
	Debug("CheckForLandmarks", lastGossip)
	if not lastGossip then return end
	local mapID = C_Map.GetBestMapForUnit('player')
	local poiID = C_GossipInfo.GetPoiForUiMapID(mapID)

	if poiID and not alreadyAdded[poiID] then
		local gossipInfo = C_GossipInfo.GetPoiInfo(mapID, poiID);
		if gossipInfo and gossipInfo.textureIndex == 7 then
			Debug("Found POI", gossipInfo.name)
			alreadyAdded[poiID] = true
			self:AddLandmark(mapID, gossipInfo.position.x, gossipInfo.position.y, lastGossip)
		end
	end
end

function HD:AddLandmark(mapID, x, y, name)
	local loc = HandyNotes:getCoord(x, y)
	for coord, value in pairs(self.db.global.landmarks[mapID]) do
		if value and value:match("^"..name) then
			Debug("already a match on name", name, value)
			return
		end
	end
	self.db.global.landmarks[mapID][loc] = name
	self:SendMessage("HandyNotes_NotifyUpdate", "Directions")
	createWaypoint(nil, mapID, loc)
end

local replacements = {
	[L["A profession trainer"]] = L["Trainer"],
	[L["Profession Trainer"]] = L["Trainer"],
	[L["A class trainer"]] = L["Trainer"],
	[L["Class Trainer"]] = L["Trainer"],
	[L["Alliance Battlemasters"]] = FACTION_ALLIANCE,
	[L["Horde Battlemasters"]] = FACTION_HORDE,
	[L["To the east."]] = L["East"],
	[L["To the west."]] = L["West"],
	[L["The east."]] = L["East"],
	[L["The west."]] = L["West"],
}
function HD:OnGossipSelectOption(optionID, ...)
	Debug("OnGossipSelectOption", optionID, currentOptions)
	if not currentOptions then return end
	local selected
	for _, option in ipairs(currentOptions) do
		if option.gossipOptionID == optionID then
			selected = option
			break
		end
	end
	if not selected then return end
	local name = selected.name
	if replacements[name] then name = replacements[name] end
	if lastGossip then
		lastGossip = lastGossip .. ': ' .. name
	else
		lastGossip = name
	end
	Debug(" -> lastGossip", lastGossip)
end

function HD:GOSSIP_SHOW()
	Debug("GOSSIP_SHOW")
	currentOptions = C_GossipInfo.GetOptions()
end

function HD:GOSSIP_CLOSED()
	Debug("GOSSIP_CLOSED")
	lastGossip = nil
end

---------------------------------------------------------
-- Options table
local options = {
	type = "group",
	name = "Directions",
	desc = "Directions",
	get = function(info) return db[info.arg] end,
	set = function(info, v)
		db[info.arg] = v
		HD:SendMessage("HandyNotes_NotifyUpdate", "Directions")
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon. Note that HandyNotes_Directions does not come with any precompiled data, when you ask a guard for directions, it will automatically add the data into your database.",
			type = "description",
			order = 0,
		},
		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "The scale of the icons",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 10,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "The alpha transparency of the icons",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 20,
		},
	},
}


---------------------------------------------------------
-- Addon initialization, enabling and disabling


function HD:OnInitialize()
	-- Set up our database
	self.db = LibStub("AceDB-3.0"):New("HandyNotes_DirectionsDB", defaults)
	db = self.db.profile
	for k, v in pairs(self.db.global.landmarks) do
		if type(k) == "string" then
			self.db.global.landmarks[k] = {}
		end
	end

	icon = setupLandmarkIcon([[Interface\Minimap\POIIcons]], (_G.GetPOITextureCoords or C_Minimap.GetPOITextureCoords)(7)) -- the cute lil' flag

	-- Initialize our database with HandyNotes
	HandyNotes:RegisterPluginDB("Directions", HDHandler, options)
end

local orig_SelectGossipOption
function HD:OnEnable()
	self:RegisterEvent("DYNAMIC_GOSSIP_POI_UPDATED", "CheckForLandmarks")
	self:RegisterEvent("GOSSIP_CLOSED")
	self:RegisterEvent("GOSSIP_SHOW")

	hooksecurefunc(C_GossipInfo, "SelectOption", function(...)
		HD:OnGossipSelectOption(...)
	end)
end
