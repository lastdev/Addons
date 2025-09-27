--[[
                                ----o----(||)----oo----(||)----o----

                                          Pilgrim's Bounty

                                       v1.11 - 2nd August 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

ns.defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
					remove = { true, true, true, true }, -- One Time, Seasonal, Weekly, Daily
					removeAchieveChar = false, removeAchieveAcct = false,
					removeOneTime = true, removeSeasonal = true, removeDaily = true,
					iconTables = 8, iconNPCs = 7 } }

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
			if pin.bountifulTable then
				return coord, nil, ns.textures[ ns.db.iconTables ],
						ns.db.iconScale * ns.scaling[ ns.db.iconTables ], ns.db.iconAlpha
			else
				return coord, nil, ns.textures[ ns.db.iconNPCs ],
						ns.db.iconScale * ns.scaling[ ns.db.iconNPCs ], ns.db.iconAlpha
			end
		end
		coord, pin = next( t, coord )
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

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
				iconTables = {
					type = "range",
					name = ns.L[ "Bountiful Tables" ],
					desc = ns.iconStandard, 
					min = 1, max = 10, step = 1,
					arg = "iconTables",
					order = 20,
				},
				iconNPCs = {
					type = "range",
					name = ns.L[ "NPCs" ],
					desc = ns.iconStandard, 
					min = 1, max = 10, step = 1,
					arg = "iconNPCs",
					order = 21,
				},
			},
		},
		notes = { type = "group", name = ns.L[ "Notes" ], inline = true,
			args = ns.MakeSetChatCommands( { "/pb", "/bounty", "/pilgrim", "/pilgrims", } ), },
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_PilgrimsBounty_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", ns.addOnName )
 end

function HandyNotes_PilgrimsBounty_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ ns.eventName ] .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ] .."/" ..ns.L[ "Right" ], ns.colour.plaintext
		..ns.L[ "Options" ] )
	GameTooltip:Show()
end

function HandyNotes_PilgrimsBounty_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_PilgrimsBounty1, SLASH_PilgrimsBounty2, SLASH_PilgrimsBounty3, SLASH_PilgrimsBounty4 =
		"/pb", "/bounty", "/pilgrim", "/pilgrims"
SlashCmdList[ "PilgrimsBounty" ] = function( options ) ns.Slash( options ) end