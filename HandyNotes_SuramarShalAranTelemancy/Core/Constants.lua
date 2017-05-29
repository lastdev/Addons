-- $Id: Constants.lua 23 2017-05-02 07:16:40Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
private.addon_name = "HandyNotes_SuramarShalAranTelemancy"

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

local constants = {}
private.constants = constants

constants.defaults = {
	profile = {
		show_npcs = true,
		icon_scale = 1.5,
		icon_alpha = 1.0,
		query_server = true,
		show_note = true,
		ignore_InOutDoor = false,
		show_telemetryLab = true,
		show_unspecifiedEntrances = true,
		show_specifiedEntrance = true,
		show_leyline = true,
		show_shalaran = true,
	},
	char = {
		hidden = {
			['*'] = {},
		},
	},
}

constants.icon_texture = {
	flight = "Interface\\MINIMAP\\TRACKING\\FlightMaster",
	yellowButton = "Interface\\AddOns\\HandyNotes_SuramarShalAranTelemancy\\Images\\YellowButton",
	portal = {
		icon = 1121272,
		tCoordLeft = 0.33203125,
		tCoordRight = 0.39453125,
		tCoordTop = 0.1953125,
		tCoordBottom = 0.2578125,
	},
	door = "Interface\\MINIMAP\\Suramar_Door_Icon",
}

-- Define the default icon here
constants.defaultIcon = constants.icon_texture["portal"]

constants.events = {
	"ZONE_CHANGED",
	"ZONE_CHANGED_INDOORS",
	-- Fires when stepping off of a world map object. 
	-- Appears to fire whenever the player has moved off of a structure 
	-- such as a bridge or building and onto terrain or another object.
	"NEW_WMO_CHUNK",
};
