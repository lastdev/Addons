--[[
                                ----o----(||)----oo----(||)----o----

                                        A Path Less Travelled

                                      v1.33 - 25th January 2024
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local myName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
-- Cyan theme
ns.colour = {}
ns.colour.prefix	= "\124cFF00FFFF" -- Cyan
ns.colour.highlight = "\124cFF00CED1" -- Dark Turquoise
ns.colour.plaintext = "\124cFF6495ED" -- Cornflower Blue

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = false,
								iconChoice = 7 } }
local continents = {}
local pluginHandler = {}

-- Upvalues
local GameTooltip = _G.GameTooltip
local GetItemNameByID = C_Item.GetItemNameByID
local IsOutdoors = IsOutdoors
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format, next, random = format, next, math.random

local HandyNotes = _G.HandyNotes
ns.name = UnitName( "player" ) or "Character"

continents[ 12 ] = true -- Kalimdor
continents[ 13 ] = true -- Eastern Kingdoms
continents[ 101 ] = true -- Outland
continents[ 113 ] = true -- Northrend
continents[ 424 ] = true -- Pandaria

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[mapFile] and ns.points[mapFile][coord]
	local itemName, completed;
	local setText = ns.colour.prefix
	
	if pin.name then
		GameTooltip:SetText( setText ..pin.name )
		setText = ns.colour.highlight
		if pin.quest or pin.item or pin.tip then
			GameTooltip:AddLine( "\n" )
		end
	end
	
	if pin.item then
		itemName = GetItemNameByID( pin.item ) or pin.item
	end
	
	if pin.quest then
		for i,v in ipairs( pin.quest ) do
			completed = IsQuestFlaggedCompleted( v )
			-- Following allows for single "Flag" quest situations for clickable items like chests
			-- Also, ensure that if the quest does not have a questName then item must not me an itemID
			GameTooltip:AddDoubleLine( setText ..( pin.questName and ( "!" ..pin.questName[ i ] ) or itemName or " " ),
					( completed == true ) and ( "\124cFF00FF00" .."Completed" .." (" ..ns.name ..")" ) 
						or ( "\124cFFFF0000" .."Not Completed" .." (" ..ns.name ..")" ) )
			setText = ns.colour.highlight
		end
		if pin.tip then
			GameTooltip:AddLine( "\n" )
		end
				
	elseif pin.item then
		GameTooltip:AddLine( setText ..itemName )
		if pin.tip then
			GameTooltip:AddLine( "\n" )
		end
	end
	
	if pin.tip then
		GameTooltip:AddLine( ns.colour.plaintext ..pin.tip )
	end	
	if ( ns.db.showCoords == true ) then
		local mX, mY = HandyNotes:getXY(coord)
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( ns.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end

	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

do	
	local function iterator(t, prev)
		if not t then return end
		local coord, pin = next(t, prev)
		while coord do
			if pin then
				if pin.outdoors ~= nil then
					if pin.outdoors == IsOutdoors() then
						return coord, nil, ns.textures[ns.db.iconChoice],
							ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
					end
				elseif pin.random then
					if random() < pin.random then
						return coord, nil, ns.textures[ns.db.iconChoice],
							ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
					end
				else
					return coord, nil, ns.textures[ns.db.iconChoice],
						ns.db.iconScale * ns.scaling[ns.db.iconChoice], ns.db.iconAlpha
				end
			end
			coord, pin = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		ns.CurrentMap = mapID
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> A Path Less Travelled options
ns.options = {
	type = "group",
	name = "A Path Less Travelled",
	desc = "Travel with me and discover the amazing!",
	get = function(info) return ns.db[info[#info]] end,
	set = function(info, v)
		ns.db[info[#info]] = v
		pluginHandler:Refresh()
	end,
	args = {
		options = {
			type = "group",
			name = " Options",
			inline = true,
			args = {
				iconScale = {
					type = "range",
					name = "Map Pin Size",
					desc = "The Map Pin Size",
					min = 1, max = 4, step = 0.1,
					arg = "iconScale",
					order = 1,
				},
				iconAlpha = {
					type = "range",
					name = "Map Pin Alpha",
					desc = "The alpha transparency of the map pins",
					min = 0, max = 1, step = 0.01,
					arg = "iconAlpha",
					order = 2,
				},
				showCoords = {
					name = "Show Coordinates",
					desc = "Display coordinates in tooltips on the world map and the mini map" 
							..ns.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 3,
				},
			},
		},
		icon = {
			type = "group",
			name = "Map Pin Selections",
			inline = true,
			args = {
				iconChoice = {
					type = "range",
					name = "Pin Choice",
					desc = "White\n2 = Purple\n3 = Red\n4 = Yellow\n5 = Green\n6 = Grey"
							.."\n7 = Mana Orb\n8 = Phasing\n9 = Raptor egg\n10 = Stars"
							.."\n11 = Cogwheel\n12 = Frost\n13 = Diamond\n14 = Screw",
					min = 1, max = 14, step = 1,
					arg = "iconChoice",
					order = 4,
				},
			},
		},
	},
}

function HandyNotes_APathLessTravelled_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "APathLessTravelled" )
 end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			if map.mapID == 84 then --Stormwind
			elseif coords then
				for coord, pin in next, coords do
					local function AddToContinent()
						local mx, my = HandyNotes:getXY(coord)
						local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
						if cx and cy then
							ns.points[continentMapID] = ns.points[continentMapID] or {}
							ns.points[continentMapID][HandyNotes:getCoord(cx, cy)] = pin
						end
					end
					if pin.outdoors then
						if pin.outdoors == IsOutdoors() then
							AddToContinent()
						end
					else
						AddToContinent()
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("APathLessTravelled", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_APathLessTravelledDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "APathLessTravelled")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_APathLessTravelledDB", "AceEvent-3.0")