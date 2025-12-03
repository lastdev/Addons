--[[
                                ----o----(||)----oo----(||)----o----

                                           Lunar Festival

                                      v4.29 - 5th November 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

ns.defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
					remove = { true, true, true, true }, -- One Time, Seasonal, Weekly, Daily
					removeAchieveChar = false, removeAchieveAcct = false,
					removeOneTime = true, removeSeasonal = true, removeDaily = true,
					iconZoneElders = 19, iconDungeonElders = 18, iconCrown = 17,
					iconFactionElders = 15, iconPreservation = 13, iconSeasonal=16,
					iconMeta = 20, iconHistory = 14, iconSpecial = 12, } }

-- Localised
local ipairs, next = _G.ipairs,  _G.next

local GameTooltip = _G.GameTooltip
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local LibStub = _G.LibStub
local HandyNotes = _G.HandyNotes

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.handyNotesPinIterator( t, prev )
	if not t then return end
	local hash;
	local coord, pin = next( t, prev )
	while coord do
		if pin and ns.PassAzerothCheck( pin ) and ns.PassAllChecks( pin ) and 
				( pin.alwaysShow or ns.ShowAchievements( pin ) or ns.ShowQuests( pin ) or ns.ShowAnyway( pin) ) then
			if pin.elder then
				hash = ( ns.db.iconZoneElders <= 10 ) and ns.db.iconZoneElders or ( ns.db.iconZoneElders + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.elderDungeon then
				hash = ( ns.db.iconDungeonElders <= 10 ) and ns.db.iconDungeonElders or ( ns.db.iconDungeonElders + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.elderFaction then
				hash = ( ns.db.iconFactionElders <= 10 ) and ns.db.iconFactionElders or ( ns.db.iconFactionElders + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.history then
				hash = ( ns.db.iconHistory <= 10 ) and ns.db.iconHistory or ( ns.db.iconHistory + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ) * 2, ns.db.iconAlpha
			elseif pin.metaLarge then
				hash = ( ns.db.iconMeta <= 10 ) and ns.db.iconMeta or ( ns.db.iconMeta + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ) * 1.7, ns.db.iconAlpha
			elseif pin.honor then
				hash = ( ns.db.iconMeta <= 10 ) and ns.db.iconMeta or ( ns.db.iconMeta + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.pyro then
				hash = ( ns.db.iconSpecial <= 10 ) and ns.db.iconSpecial or ( ns.db.iconSpecial + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.preservation then
				hash = ( ns.db.iconPreservation <= 10 ) and ns.db.iconPreservation or ( ns.db.iconPreservation + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.seasonalQuest then
				hash = ( ns.db.iconSeasonal <= 10 ) and ns.db.iconSeasonal or ( ns.db.iconSeasonal + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.coins then
				hash = ( ns.db.iconCrown <= 10 ) and ns.db.iconCrown or ( ns.db.iconCrown + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.crown and ( IsQuestFlaggedCompleted( 56842 ) == true ) then -- Lunar Preservation
				hash = ( ns.db.iconCrown <= 10 ) and ns.db.iconCrown or ( ns.db.iconCrown + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ) * 0.5, ns.db.iconAlpha
			end				
		end
		coord, pin = next( t, coord )
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local iconLF = "\n11 = " ..ns.L["Coin"] .." - " ..ns.L[ "Blue" ] .."\n12 = " ..ns.L["Coin"] .." - " ..ns.L["Deep Green"] .."\n13 = "
			..ns.L["Coin"] .." - " ..ns.L["Deep Pink"] .."\n14 = " ..ns.L["Coin"] .." - " ..ns.L["Deep Red"] .."\n15 = "
			..ns.L["Coin"] .." - " ..ns.L["Green"] .."\n16 = " ..ns.L["Coin"] .." - " ..ns.L["Light Blue"] .."\n17 = "
			..ns.L["Coin"] .." - " ..ns.L["Pink"] .."\n18 = " ..ns.L["Coin"] .." - " ..ns.L["Purple"] .."\n19 = " ..ns.L["Coin"]
			.." - " ..ns.L["Teal"] .."\n20 = " ..ns.L["Coin"] .." - " ..ns.L["Original"]

ns.options = {
	type = "group",
	name = ns.L[ ns.eventName ],
	desc = ns.AddColouredText( "AddOn Description" ),
	get = function( info ) return ns.db[ info[ #info ] ] end,
	set = function( info, v )
		ns.db[ info[ #info ] ] = v
		ns.pluginHandler:Refresh()
	end,
	args = {
		options = {
			-- Add a " " to force this to be before the first group. HN arranges alphabetically on local language
			type = "group", name = " " ..ns.L[ "Options" ], inline = true,
			args = { iconScale = ns.setIconScale, iconAlpha = ns.setIconAlpha, showCoords = ns.setShowCoords,
				removeSeasonal = ns.setRemoveSeasonal, removeDailies = ns.setRemoveDailies, 
				removeAchieveChar = ns.setRemoveAchieveChar, removeAchieveAcct = ns.setRemoveAchieveAcct,
				showAzeroth = ns.setShowAzeroth,
			},
		},
		icon = {
			type = "group",
			name = ns.L[ "Map Pin Selections" ],
			inline = true,
			args = {
				iconZoneElders = {
					type = "range",
					name = ns.L[ "Zones" ],
					desc = ns.iconStandard ..iconLF, 
					min = 1, max = 20, step = 1,
					arg = "iconZoneElders",
					order = 20,
				},
				iconDungeonElders = {
					type = "range",
					name = ns.L[ "Dungeons" ],
					desc = ns.iconStandard ..iconLF, 
					min = 1, max = 20, step = 1,
					arg = "iconDungeonElders",
					order = 21,
				},
				iconFactionElders = {
					type = "range",
					name = ns.L[ "Factions" ],
					desc = ns.iconStandard ..iconLF, 
					min = 1, max = 20, step = 1,
					arg = "iconFactionElders",
					order = 22,
				},
				iconPreservation = {
					type = "range",
					name = ns.L[ "Lunar Preservation" ],
					desc = ns.iconStandard ..iconLF, 
					min = 1, max = 20, step = 1,
					arg = "iconPreservation",
					order = 23,
				},
				iconCrown = {
					type = "range",
					name = ns.L[ "Crown of... Quests" ],
					desc = ns.iconStandard ..iconLF, 
					min = 1, max = 20, step = 1,
					arg = "iconCrown",
					order = 24,
				},
				iconSeasonal = {
					type = "range",
					name = ns.L[ "Seasonal" ] .." " ..ns.L[ "Quests" ],
					desc = ns.iconStandard ..iconLF, 
					min = 1, max = 20, step = 1,
					arg = "iconSeasonal",
					order = 25,
				},
				iconMeta = {
					type = "range",
					name = ns.L[ "HonorElders" ],
					desc = ns.iconStandard ..iconLF, 
					min = 1, max = 20, step = 1,
					arg = "iconMeta",
					order = 26,
				},
				iconHistory = {
					type = "range",
					name = ns.L[ "History" ],
					desc = ns.iconStandard ..iconLF, 
					min = 1, max = 20, step = 1,
					arg = "iconHistory",
					order = 27,
				},
				iconSpecial = {
					type = "range",
					name = ns.L[ "Special" ],
					desc = ns.iconStandard ..iconLF, 
					min = 1, max = 20, step = 1,
					arg = "iconSpecial",
					order = 28,
				},
			},
		},
		notes = { type = "group", name = ns.L[ "Notes" ], inline = true,
			args = ns.MakeSetChatCommands( { "/lf", "/lunar", } ), },
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_LunarFestival_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", ns.addOnName )
end

function HandyNotes_LunarFestival_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ ns.eventName ] .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ] .."/" ..ns.L[ "Right" ], ns.colour.plaintext
		..ns.L[ "Options" ] )
	GameTooltip:Show()
end

function HandyNotes_LunarFestival_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_LunarFestival1, SLASH_LunarFestival2 = "/lf", "/lunar"
SlashCmdList[ "LunarFestival" ] = function( options ) ns.Slash( options ) end