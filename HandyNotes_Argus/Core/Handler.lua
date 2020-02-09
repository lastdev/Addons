-- $Id: Handler.lua 70 2017-07-02 14:53:21Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
local string = _G.string
local format, gsub = string.format, string.gsub
local next, wipe, pairs, select, type = next, wipe, pairs, select, type
local GameTooltip, WorldMapTooltip, GetSpellInfo, CreateFrame, UnitClass = _G.GameTooltip, _G.WorldMapTooltip, _G.GetSpellInfo, _G.CreateFrame, _G.UnitClass
local UIDropDownMenu_CreateInfo, CloseDropDownMenus, UIDropDownMenu_AddButton, ToggleDropDownMenu = _G.UIDropDownMenu_CreateInfo, _G.CloseDropDownMenus, _G.UIDropDownMenu_AddButton, _G.ToggleDropDownMenu

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local LH = LibStub("AceLocale-3.0"):GetLocale("HandyNotes", false)
local AceDB = LibStub("AceDB-3.0")

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local addon = LibStub("AceAddon-3.0"):NewAddon(private.addon_name, "AceEvent-3.0")
addon.constants = private.constants
addon.constants.addon_name = private.addon_name

addon.descName 		= private.descName
addon.description 	= private.description
addon.pluginName 	= private.pluginName

addon.Name = FOLDER_NAME
_G.HandyNotes_Argus = addon

local profile

-- //////////////////////////////////////////////////////////////////////////
-- get creature's name from server
local mcache_tooltip = CreateFrame("GameTooltip", private.addon_name.."_mcacheToolTip", UIParent, "GameTooltipTemplate")
local creature_cache

-- activation code
local function getCreatureNamebyID(id)
	mcache_tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	mcache_tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
	creature_cache = _G[private.addon_name.."_mcacheToolTipTextLeft1"]:GetText()
end
-- //////////////////////////////////////////////////////////////////////////
local function work_out_texture(point)
	local icon_key
	
	if (point.entrance) then icon_key = "entrance" end
	if (point.ramp) then icon_key = "ramp" end
	if (point.rare) then icon_key = "rare" end
	if (point.treasure) then icon_key = "treasure" end
	if (point.felbloom) then icon_key = "greenButton" end
	if (point.portal and not point.icon) then icon_key = "portal" end
	
	if (icon_key and private.constants.icon_texture[icon_key]) then
		return private.constants.icon_texture[icon_key]
	elseif (point.type and private.constants.icon_texture[point.type]) then
		return private.constants.icon_texture[point.type]
	-- use the icon specified in point data
	elseif (point.icon) then
		if (private.constants.icon_texture[point.icon]) then
			return private.constants.icon_texture[point.icon]
		else
			return point.icon
		end
	else
		return private.constants.defaultIcon
	end
end

local get_point_info = function(point)
	if point then
		local label = point.label or UNKNOWN
		if (point.treasure) then 
			if not point.label then point.label = L["Treasure Chest"] end
			if not point.scale then point.scale = 1.0 end
			if not point.alpha then point.alpha = 0.5 end
		end
		if (point.rare) then
			if not point.alpha then point.alpha = 0.6 end
		end
		if (point.entrance) then
			if not point.scale then point.scale = 0.8 end
			if not point.alpha then point.alpha = 0.8 end
		end
		if (point.netherPortal) then 
			if not point.label then point.label = L["Unstable Nether Portal"] end
			if not point.scale then point.scale = 1.4 end
			if not point.alpha then point.alpha = 0.6 end
		end

		local icon = work_out_texture(point)

		return label, icon, point.scale, point.alpha
	end
end

local get_point_info_by_coord = function(uMapID, coord)
	return get_point_info(private.DB.points[uMapID] and private.DB.points[uMapID][coord])
end

local function handle_tooltip(tooltip, point, coord)
	if point then
		if (point.label) then
			if (point.npc and profile.query_server) then
				--tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
				getCreatureNamebyID(point.npc)
				tooltip:AddLine(creature_cache or point.label)
				creature_cache = nil
			else
				tooltip:AddLine(point.label)
			end
		end
		if (point.spell) then
			local spellName = GetSpellInfo(point.spell)
			if (spellName) then
				tooltip:AddLine(spellName, 1, 1, 1, true)
			end
		end
		if (point.note and profile.show_note) then
			tooltip:AddLine("("..point.note..")", nil, nil, nil, true)
		end
		if (profile.show_coords and coord) then
			local x, y = HandyNotes:getXY(coord)
			tooltip:AddLine(format("%.2f, %.2f", x*100, y*100), 1, 1, 1, true)
		end
--[===[@debug@
		if (point.quest) then
			if (IsQuestFlaggedCompleted(point.quest)) then
				tooltip:AddDoubleLine(L["QuestID"], point.quest or UNKNOWN, 0.5, 0.5, 1, 1, 0.5, 1)
			else
				tooltip:AddDoubleLine(L["QuestID"], point.quest or UNKNOWN, 0.5, 0.5, 1, 0.5, 0.5, 1)
			end
		end
--@end-debug@]===]
	else
		tooltip:SetText(UNKNOWN)
	end
	tooltip:Show()
end

local handle_tooltip_by_coord = function(tooltip, uMapID, coord)
	return handle_tooltip(tooltip, private.DB.points[uMapID] and private.DB.points[uMapID][coord], coord)
end

-- //////////////////////////////////////////////////////////////////////////
local PluginHandler = {}
local info = {}

function PluginHandler:OnEnter(uMapID, coord)
	local tooltip = self:GetParent() == WorldMapFrame:GetCanvas() and WorldMapTooltip or GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	handle_tooltip_by_coord(tooltip, uMapID, coord)
end

function PluginHandler:OnLeave(uMapID, coord)
	if self:GetParent() == WorldMapFrame:GetCanvas() then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local function hideNode(button, uMapID, coord)
	private.hidden[uMapID][coord] = true
	addon:Refresh()
end

local function closeAllDropdowns()
	CloseDropDownMenus(1)
end

local function addTomTomWaypoint(button, uMapID, coord)
	if TomTom then
		local x, y = HandyNotes:getXY(coord)
		TomTom:AddWaypoint(uMapID, x, y, {
			title = get_point_info_by_coord(uMapID, coord),
			persistent = nil,
			minimap = true,
			world = true
		})
	end
end

local function addAllTreasureToWayPoint(button, uMapID)
	if TomTom then
		for k, v in pairs(private.DB.treasures) do
			local x, y = HandyNotes:getXY(k)
			TomTom:AddWaypoint(uMapID, x, y, {
				title = L["Veiled Wyrmtongue Chest"],
				persistent = nil,
				minimap = true,
				world = true
			})
		end
	end
end

local function addAllShrineToWayPoint(button, uMapID)
	if TomTom then
		local spellName = GetSpellInfo(239933)
		for k, v in pairs(private.DB.shrines) do
			local x, y = HandyNotes:getXY(k)
			TomTom:AddWaypoint(uMapID, x, y, {
				title = spellName,
				persistent = nil,
				minimap = true,
				world = true
			})
		end
	end
end

local function addAllNetherPortalToWayPoint(button, uMapID)
	if TomTom then
		for k, v in pairs(private.DB.netherPortals) do
			local x, y = HandyNotes:getXY(k)
			TomTom:AddWaypoint(uMapID, x, y, {
				title = L["Unstable Nether Portal"],
				persistent = nil,
				minimap = true,
				world = true
			})
		end
	end
end

do
	local currentMapID = nil
	local currentCoord = nil
	local function generateMenu(button, level)
		if (not level) then return end
		if (level == 1) then
			-- Create the title of the menu
			info = UIDropDownMenu_CreateInfo()
			info.isTitle 		= true
			info.text 		= "HandyNotes - " ..addon.pluginName
			info.notCheckable 	= true
			UIDropDownMenu_AddButton(info, level)

			if TomTom then
				-- Waypoint menu item
				info = UIDropDownMenu_CreateInfo()
				info.text = LH["Add this location to TomTom waypoints"]
				info.notCheckable = true
				info.func = addTomTomWaypoint
				info.arg1 = currentMapID
				info.arg2 = currentCoord
				UIDropDownMenu_AddButton(info, level)

				info = UIDropDownMenu_CreateInfo()
				info.text = L["Add all treasure nodes to TomTom waypoints"]
				info.notCheckable = true
				info.func = addAllTreasureToWayPoint
				info.arg1 = currentMapID
				UIDropDownMenu_AddButton(info, level)

				info = UIDropDownMenu_CreateInfo()
				info.text = L["Add all Ancient Shrine nodes to TomTom waypoints"]
				info.notCheckable = true
				info.func = addAllShrineToWayPoint
				info.arg1 = currentMapID
				UIDropDownMenu_AddButton(info, level)

				info = UIDropDownMenu_CreateInfo()
				info.text = L["Add all Unstable Nether Portal nodes to TomTom waypoints"]
				info.notCheckable = true
				info.func = addAllNetherPortalToWayPoint
				info.arg1 = currentMapID
				UIDropDownMenu_AddButton(info, level)
			end

			-- Hide menu item
			info = UIDropDownMenu_CreateInfo()
			info.text		= HIDE 
			info.notCheckable 	= true
			info.func		= hideNode
			info.arg1		= currentMapID
			info.arg2		= currentCoord
			UIDropDownMenu_AddButton(info, level)

			-- Close menu item
			info = UIDropDownMenu_CreateInfo()
			info.text		= CLOSE
			info.func		= closeAllDropdowns
			info.notCheckable 	= true
			UIDropDownMenu_AddButton(info, level)
		end
	end
	local HL_Dropdown = CreateFrame("Frame", private.addon_name.."DropdownMenu")
	HL_Dropdown.displayMode = "MENU"
	HL_Dropdown.initialize = generateMenu

	function PluginHandler:OnClick(button, down, uMapID, coord)
		if (button == "RightButton" and not down) then
			currentMapID = uMapID
			currentCoord = coord
			ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
		end
	end
end

do
--	local tablepool = setmetatable({}, {__mode = 'k'})

	-- This is a custom iterator we use to iterate over every node in a given zone
	local currentMapID = nil
	local function iter(t, prestate)
		if not t then return nil end
		local state, value = next(t, prestate)
		while state do -- Have we reached the end of this zone?
			if value and private:ShouldShow(state, value, currentMapID) then
				local label, icon, scale, alpha = get_point_info(value)
				scale = (scale or 1) * (icon and icon.scale or 1) * profile.icon_scale
				alpha = (alpha or 1) * (icon and icon.alpha or 1) * profile.icon_alpha
				return state, nil, icon, scale, alpha
			end
			state, value = next(t, state) -- Get next data
		end
		return nil, nil, nil, nil, nil, nil
	end
--[[
	local function iterCont(t, prestate)
		if not t then return end
		local zone = t.C[t.Z]
		local data = private.DB.points[zone]
		local state, value

		while zone do
			if data then -- only if there is data for this zone
				state, value = next(data, prestate)
				while state do -- have we reached the end of this zone?
					if value and private:ShouldShow(state, value, currentMapID) then
						local label, icon, scale, alpha = get_point_info(value)
						scale = (scale or 1) * (icon and icon.scale or 1) * profile.icon_scale
						alpha = (alpha or 1) * (icon and icon.alpha or 1) * profile.icon_alpha
						return state, mapFile, icon, scale, alpha
					end
					state, value = next(data, state) -- get next data
				end
			end
			-- get next zone
			t.Z = next(t.C, t.Z)
			zone = t.C[t.Z]
			data = private.DB.points[zone]
			prestate = nil
		end
		wipe(t)
		tablepool[t] = true
	end
]]
	function PluginHandler:GetNodes2(uMapID, minimap)
--[[		local C = HandyNotes:GetContinentZoneList(uMapID) -- Is this a continent?
		if C and profile.showNodesOnContinentMap then -- Once we added a config section in config panel, user will be able to toggle this
			local tbl = next(tablepool) or {}
			tablepool[tbl] = nil
			tbl.C = C
			tbl.Z = next(C)
			tbl.contId = uMapID
			return iterCont, tbl, nil
		else
			local tbl = next(tablepool) or {}
			tablepool[tbl] = nil
			tbl.data = private.DB.points[uMapID]
			currentMapID = uMapID
			return iter, tbl, nil
		end
]]
		currentMapID = uMapID
		return iter, private.DB.points[uMapID], nil
	end
	function private:ShouldShow(coord, point, currentMapID)
		if (private.hidden[currentMapID] and private.hidden[currentMapID][coord]) then
			return false
		end
		if (point.entrance and not profile.show_entrance) then
			return false
		end
		if (point.ramp and not profile.show_ramp) then
			return false
		end
		if (point.rare and not profile.show_rare) then
			return false
		end
		if (point.others and not profile.show_others) then
			return false
		end
		if (point.treasure and not profile.show_treasure) then
			return false
		end
		if (point.shrine and not profile.show_shrine) then
			return false
		end
		if (point.infernalCore and not profile.show_infernalCores) then
			return false
		end
		if (point.tamer and not profile.show_tamer) then
			return false
		end
		if (point.netherPortal and not profile.show_netherPortals) then
			return false
		end
		if (point.dungeonLevel and point.dungeonLevel ~= currentLevel) then
			return false
		end
		if (point.hide_indoor and not profile.ignore_InOutDoor and IsIndoors()) then
			return false
		end
		if (point.hide_outdoor and not profile.ignore_InOutDoor and IsOutdoors()) then
			return false
		end
		if (point.rare and point.quest and profile.hide_completed and IsQuestFlaggedCompleted(point.quest)) then
			return false
		end
		-- this will check if any node is for specific class
		if (point.class and point.class ~= select(2, UnitClass("player"))) then
			return false
		end
		return true
	end
end

-- //////////////////////////////////////////////////////////////////////////
function addon:OnInitialize()
	self.db = AceDB:New(private.addon_name.."DB", private.constants.defaults)
	
	profile = self.db.profile
	private.db = profile
	private.hidden = self.db.char.hidden

	-- Initialize database with HandyNotes
	HandyNotes:RegisterPluginDB(addon.pluginName, PluginHandler, private.config.options)
end

function addon:OnEnable()
	for key, value in pairs( addon.constants.events ) do
		self:RegisterEvent( value );
	end
end

function addon:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
end

function addon:ZONE_CHANGED()
	addon:Refresh()
end

function addon:ZONE_CHANGED_INDOORS()
	addon:Refresh()
end

function addon:NEW_WMO_CHUNK()
	addon:Refresh()
end

function addon:ENCOUNTER_LOOT_RECEIVED()
	addon:Refresh()
end
--[[
function addon:CLOSE_WORLD_MAP()
	closeAllDropdowns()
end
]]
-- //////////////////////////////////////////////////////////////////////////
