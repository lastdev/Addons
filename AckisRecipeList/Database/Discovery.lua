--[[
************************************************************************
Discovery.lua
************************************************************************
File date: 2012-08-18T04:52:05Z
File hash: 4d6b8e4
Project hash: f647594
Project version: 2.4
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]] --

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub

local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()

private.discovery_list	= {}

function addon:InitDiscovery()
	local function AddDiscovery(identifier, location, coord_x, coord_y, faction)
		private:AddListEntry(private.discovery_list, identifier, L[identifier], location, coord_x, coord_y, nil)
	end

	AddDiscovery("DISCOVERY_ALCH_ELIXIRFLASK")
	AddDiscovery("DISCOVERY_ALCH_POTION")
	AddDiscovery("DISCOVERY_ALCH_PROT")
	AddDiscovery("DISCOVERY_ALCH_BC_XMUTE")
	AddDiscovery("DISCOVERY_INSC_BOOK", BZ["Northrend"])
	AddDiscovery("DISCOVERY_INSC_MINOR")
	AddDiscovery("DISCOVERY_INSC_NORTHREND")
	AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")
	AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")
	AddDiscovery("ENG_DISC")

	self.InitDiscovery = nil
end

