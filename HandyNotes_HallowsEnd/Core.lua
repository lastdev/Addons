--[[
                                ----o----(||)----oo----(||)----o----

                                            Hallow's End

                                      v4.08 - 3rd October 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

ns.defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
					remove = { true, true, true, true }, -- One Time, Seasonal, Weekly, Daily
					removeAchieveChar = false, removeAchieveAcct = false,
					removeOneTime = true, removeSeasonal = true, removeDaily = true,
					iconTricksTreat = 11, iconDailies = 10, iconFires = 13, iconSpecial = 15 } }

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
			if pin.candy then
				if pin.large then
					return coord, nil, ns.textures[ 21 ], ns.ScalePin( 21 ) * 1.7, ns.db.iconAlpha
				else
					hash = ( ns.db.iconTricksTreat <= 10 ) and ns.db.iconTricksTreat or ( ns.db.iconTricksTreat + 10 )
					return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
				end
			elseif pin.fires then
				hash = ( ns.db.iconFires <= 10 ) and ns.db.iconFires or ( ns.db.iconFires + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.rotten then
				hash = ( ns.db.iconDailies <= 10 ) and ns.db.iconDailies or ( ns.db.iconDailies + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.pumpkin then
				return coord, nil, ns.textures[ 22 ], ns.ScalePin( 22 ), ns.db.iconAlpha
			elseif pin.bat then
				return coord, nil, ns.textures[ 24 ], ns.ScalePin( 24 ), ns.db.iconAlpha
			elseif pin.cat then
				return coord, nil, ns.textures[ 25 ], ns.ScalePin( 25 ), ns.db.iconAlpha
			elseif pin.evilP then
				return coord, nil, ns.textures[ 23 ], ns.ScalePin( 23 ), ns.db.iconAlpha
			elseif pin.ghost then
				return coord, nil, ns.textures[ 26 ], ns.ScalePin( 26 ), ns.db.iconAlpha
			elseif pin.witch then
				return coord, nil, ns.textures[ 27 ], ns.ScalePin( 27 ) * 2, ns.db.iconAlpha
			else
				hash = ( ns.db.iconSpecial <= 10 ) and ns.db.iconSpecial or ( ns.db.iconSpecial + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			end				
		end
		coord, pin = next( t, coord )
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local iconHE = "\n11 = " ..ns.L[ "Candy Swirl" ] .."\n12 = " ..ns.L[ "Pumpkin" ] .."\n13 = " ..ns.L[ "Evil Pumpkin" ] .."\n14 = "
				..ns.L[ "Bat" ] .."\n15 = " ..ns.L[ "Cat" ] .."\n16 = " ..ns.L[ "Ghost" ] .."\n17 = " ..ns.L[ "Witch" ]

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
				iconTricksTreat = {
					type = "range",
					name = ns.L[ "Tricks and Treats" ],
					desc = ns.iconStandard, 
					min = 1, max = 17, step = 1,
					arg = "iconTricksTreat",
					order = 20,
				},
				iconDailies = {
					type = "range",
					name = ns.L[ "Rotten Hallow Dailies" ],
					desc = ns.iconStandard, 
					min = 1, max = 17, step = 1,
					arg = "iconDailies",
					order = 21,
				},
				iconFires = {
					type = "range",
					name = ns.L[ "Fires" ],
					desc = ns.iconStandard, 
					min = 1, max = 17, step = 1,
					arg = "iconFires",
					order = 22,
				},
				iconSpecial = {
					type = "range",
					name = ns.L[ "Special" ] .."++",
					desc = ns.iconStandard, 
					min = 1, max = 17, step = 1,
					arg = "iconSpecial",
					order = 23,
				},
			},
		},
		notes = { type = "group", name = ns.L[ "Notes" ], inline = true,
			args = ns.MakeSetChatCommands( { "/he", "/hend", "/hallows", } ), },
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_HallowsEnd_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", ns.addOnName )
end

function HandyNotes_HallowsEnd_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ ns.eventName ] .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ] .."/" ..ns.L[ "Right" ], ns.colour.plaintext
		..ns.L[ "Options" ] )
	GameTooltip:Show()
end

function HandyNotes_HallowsEnd_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_HallowsEnd1, SLASH_HallowsEnd2, SLASH_HallowsEnd3 = "/he", "/hend", "/hallows"
SlashCmdList[ "HallowsEnd" ] = function( options ) ns.Slash( options ) end