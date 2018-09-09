-- $Id: Handler.lua 57 2018-08-06 15:32:45Z arith $
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
_G.HandyNotes_SuramarShalAranTelemancy = addon

-- //////////////////////////////////////////////////////////////////////////
local function work_out_texture(point)
	if (point.type and private.constants.icon_texture[point.type]) then
		return private.constants.icon_texture[point.type]
	-- use the icon specified in point data
	elseif (point.icon) then
		return point.icon
	else
		return private.constants.defaultIcon
	end
end

local get_point_info = function(point)
	local icon
	if point then
		local label = point.label or UNKNOWN
		if (point.type and point.type == "portal" and point.quest) then
			if IsQuestFlaggedCompleted(point.quest) then
				icon = work_out_texture(point)
			else
				local texture, _, _, left, right, top, bottom = GetAtlasInfo("MagePortalHorde")
				icon = {
					icon = texture,
					tCoordLeft = left,
					tCoordRight = right,
					tCoordTop = top,
					tCoordBottom = bottom,
				}
			end
		elseif (point.type and point.type == "door") then
			if (not point.scale) then point.scale = 0.8 end
			if (not point.alpha) then point.alpha = 0.8 end
			icon = work_out_texture(point)
		else
			icon = work_out_texture(point)
		end

		return label, icon, point.scale, point.alpha
	end
end

local get_point_info_by_coord = function(uMapID, coord)
	return get_point_info(private.DB.points[uMapID] and private.DB.points[uMapID][coord])
end

local function handle_tooltip(tooltip, point)
	if point then
		if (point.label) then
			if (point.npc and profile.query_server) then
				tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
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
	else
		tooltip:SetText(UNKNOWN)
	end
	tooltip:Show()
end

local handle_tooltip_by_coord = function(tooltip, uMapID, coord)
	return handle_tooltip(tooltip, private.DB.points[uMapID] and private.DB.points[uMapID][coord])
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
	function PluginHandler:GetNodes2(uMapID, minimap)
		currentMapID = uMapID
		return iter, private.DB.points[uMapID], nil
	end
	function private:ShouldShow(coord, point, currentMapID)
		if (private.hidden[currentMapID] and private.hidden[currentMapID][coord]) then
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
		if (point.isTelemetryLabRelated and not profile.show_telemetryLab) then
			return false
		end
		if (point.isUnspecifiedEntrance and not profile.show_unspecifiedEntrances) then
 			return false
		end
		if (point.leyline and not profile.show_leyline) then
			return false
		end
		if (point.shalaran and not profile.show_shalaran) then
			return false
		end
		if (point.type and point.type == "door" and not point.quest and not point.isTelemetryLabRelated and not point.isUnspecifiedEntrance and not point.leyline and not profile.show_specifiedEntrance) then
			return false
		end
		if (point.hide_after and IsQuestFlaggedCompleted(point.hide_after)) then
			return false
		end
		if (point.hide_before and not IsQuestFlaggedCompleted(point.hide_before)) then
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
--[[
function addon:CLOSE_WORLD_MAP()
	closeAllDropdowns()
end
]]
-- //////////////////////////////////////////////////////////////////////////
