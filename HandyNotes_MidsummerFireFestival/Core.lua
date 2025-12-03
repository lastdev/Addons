--[[
                                ----o----(||)----oo----(||)----o----

                                       Midsummer Fire Festival

                                     v3.16 - 12th November 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

ns.defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true, showAzeroth = true,
					remove = { true, true, true, true }, -- One Time, Seasonal, Weekly, Daily
					removeAchieveChar = false, removeAchieveAcct = false, removeSeasonal = true, 
					removeDaily = true, removeOneTime = true, removeWeekly = true,
					iconHonor = 14, iconDesecrate = 12, iconThief = 15 } }
					
-- Localised
local ipairs, next = _G.ipairs,  _G.next

local GameTooltip = _G.GameTooltip
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local LibStub = _G.LibStub
local HandyNotes = _G.HandyNotes

-- ---------------------------------------------------------------------------------------------------------------------------------

local function randomExcept( limS, limE, exception )
	while true do
		local hash = random( limS, limE )
		if hash ~= exception then return hash end
	end
end

function ns.handyNotesPinIterator( t, prev )
	if not t then return end
	local hash;
	local coord, pin = next( t, prev )
	while coord do
		if pin and ns.PassAzerothCheck( pin ) and ns.PassAllChecks( pin ) and 
				( pin.alwaysShow or ns.ShowAchievements( pin ) or ns.ShowQuests( pin ) or ns.ShowAnyway( pin) ) then
			if pin.wardenKeeper or pin.festival or pin.light then
				hash = ( ns.db.iconHonor <= 10 ) and ns.db.iconHonor or ( ns.db.iconHonor + 20 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.extinguish or pin.flicker then
				hash = ( ns.db.iconDesecrate <= 10 ) and ns.db.iconDesecrate or ( ns.db.iconDesecrate + 30 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.king or pin.wild then
				hash = ( ns.db.iconThief <= 10 ) and ns.db.iconThief or ( ns.db.iconThief + 10 )
				return coord, nil, ns.textures[ hash ],  ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.flavour then
				return coord, nil, ns.textures[ 52 ],  ns.ScalePin( 52 ) * 2, ns.db.iconAlpha
			elseif pin.ext2 then
				hash = randomExcept( 11, 15, ns.db.iconDesecrate ) + 30
				return coord, nil, ns.textures[ hash ],  ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.flame2 then
				-- Note this will blink for Vanilla. The only one
				hash = randomExcept( 11, 14, ns.db.iconHonor ) + 20
				return coord, nil, ns.textures[ hash ],  ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.flame3 then
				hash = randomExcept( 11, 14, ns.db.iconThief ) + 10
				return coord, nil, ns.textures[ hash ],  ns.ScalePin( hash ), ns.db.iconAlpha
			end				
		end
		coord, pin = next( t, coord )
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------
				
-- Interface -> Addons -> Handy Notes -> Plugins -> Midsummer Fire Festival options
ns.options = {
	type = "group",
	name = ns.L[ "Midsummer Fire Festival" ],
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
				removeAchieveChar = ns.setRemoveAchieveChar, removeAchieveAcct = ns.setRemoveAchieveAcct,
				showAzeroth = ns.setShowAzeroth,
			},
		},
		icon = {
			type = "group",
			name = ns.L[ "Map Pin Selections" ],
			inline = true,
			args = {
				iconHonor = {
					type = "range", name = ( ns.version > 40000 ) and ns.L[ "Honor the Flames" ] 
																	or ns.L[ "Capital City Bonfires / NPCs" ],
					desc = ns.iconStandard .."\n11 = " ..ns.L[ "Symbol" ] .." - " ..ns.L[ "Blue" ] .."\n12 = " ..ns.L[ "Symbol" ]
						.." - " ..ns.L[ "Green" ] .."\n13 = " ..ns.L[ "Symbol" ] .." - " ..ns.L[ "Magenta" ] .."\n14 = "
						..ns.L[ "Symbol" ] .." - " ..ns.L[ "Orange" ],
					min = 1, max = 14, step = 1, arg = "iconHonor", order = 21,
				},
				iconDesecrate = {
					type = "range", name = ( ns.version > 40000 ) and ns.L[ "Desecrate/Extinguish" ] or ns.L[ "Flickering Flames" ],
					desc = ns.iconStandard .."\n11 = " ..ns.L[ "Fire" ] .." - " ..ns.L[ "Arcane" ] .."\n12 = " ..ns.L[ "Fire" ]
						.." - " ..ns.L[ "Blood" ] .."\n13 = " ..ns.L[ "Fire" ] .." - " ..ns.L[ "Fel" ] .."\n14 = "
						..ns.L[ "Fire" ] .." - " ..ns.L[ "Frost" ] .."\n15 = " ..ns.L[ "Fire" ] .." - " ..ns.L[ "Nature" ],
					min = 1, max = 15, step = 1, arg = "iconDesecrate", order = 22,
				},
				iconThief = {
					type = "range", name = ( ns.version > 40000 ) and ns.L[ "Thief's Reward" ] or ns.L[ "Wild Fires" ],
					desc = ns.iconStandard .."\n11 = " ..ns.L[ "Symbol" ] .." - " ..ns.L[ "Blue" ] .."\n12 = " ..ns.L[ "Symbol" ]
						.." - " ..ns.L[ "Cyan" ] .."\n13 = " ..ns.L[ "Symbol" ] .." - " ..ns.L[ "Gold" ] .."\n14 = "
						..ns.L[ "Symbol" ] .." - " ..ns.L[ "Green" ]  .."\n15 = " ..ns.L[ "Symbol" ] .." - "
						..ns.L[ "Light Green" ],
					min = 1, max = 15, step = 1, arg = "iconThief", order = 23,
				},
			},
		},
		notes = { type = "group", name = ns.L[ "Notes" ], inline = true,
			args = ns.MakeSetChatCommands( { "/mff", "/midsummer", } ),
		},
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_MidsummerFireFestival_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", ns.addOnName )
end

function HandyNotes_MidsummerFireFestival_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ ns.eventName ] .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ] .."/" ..ns.L[ "Right" ], ns.colour.plaintext
		..ns.L[ "Options" ] )
	GameTooltip:Show()
end

function HandyNotes_MidsummerFireFestival_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_Midsummer1, SLASH_Midsummer2 = "/mff", "/midsummer"
SlashCmdList[ "Midsummer" ] = function( options ) ns.Slash( options ) end