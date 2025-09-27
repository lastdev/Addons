--[[
                                ----o----(||)----oo----(||)----o----

                                             Noblegarden

                                     v4.22 - 7th September 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

ns.defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
					remove = { true, true, true, true }, -- One Time, Seasonal, Weekly, Daily
					removeAchieveChar = false, removeAchieveAcct = false,
					removeOneTime = true, removeSeasonal = true, removeDaily = true,
					showBCE = true,
					iconNGBCE = 19, iconQuackingDown = 14, iconDaetan = 12, iconDesertRose = 15,
					iconSpringFling = 11, iconGreatEggHunt = 20, iconHardBoiled = 17, } }

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
			if pin.bce then
				if pin.alwaysShow or ( ns.continents[ ns.mapID ] ~= nil ) then -- pin cluster or continent marker
					hash = ( ns.db.iconNGBCE <= 10 ) and ns.db.iconNGBCE or ( ns.db.iconNGBCE + 10 )
					return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
				elseif ( ns.db.showBCE == true )then
					if ( ns.author ~= nil ) and ( pin.author ~= nil ) then
						return coord, nil, ns.textures[ 3 ], ns.ScalePin( 3 ) * 0.65, ns.db.iconAlpha
					else
						hash = ( ns.db.iconNGBCE <= 10 ) and ns.db.iconNGBCE or ( ns.db.iconNGBCE + 10 )
						return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ) * 0.65, ns.db.iconAlpha
					end
				end
			elseif pin.quack then
				hash = ( ns.db.iconQuackingDown <= 10 ) and ns.db.iconQuackingDown or ( ns.db.iconQuackingDown + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.daetan then
				hash = ( ns.db.iconDaetan <= 10 ) and ns.db.iconDaetan or ( ns.db.iconDaetan + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.rose then
				hash = ( ns.db.iconDesertRose <= 10 ) and ns.db.iconDesertRose or ( ns.db.iconDesertRose + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.fling then
				hash = ( ns.db.iconSpringFling <= 10 ) and ns.db.iconSpringFling or ( ns.db.iconSpringFling + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.flavour then
				hash = ( ns.db.iconNGBCE <= 10 ) and ns.db.iconNGBCE or ( ns.db.iconNGBCE + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ) * 2, ns.db.iconAlpha
			elseif pin.eggHunt then
				hash = ( ns.db.iconGreatEggHunt <= 10 ) and ns.db.iconGreatEggHunt or ( ns.db.iconGreatEggHunt + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.hardBoiled or pin.hide then
				hash = ( ns.db.iconHardBoiled <= 10 ) and ns.db.iconHardBoiled or ( ns.db.iconHardBoiled + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			end				
		end
		coord, pin = next( t, coord )
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local iconNG = "\n11 = " ..ns.L[ "Noblegarden" ] .." - " ..ns.L[ "Yellow" ] .."\n12 = " ..ns.L[ "Noblegarden" ] .." - "
				..ns.L[ "Orange" ] .."\n13 = " ..ns.L[ "Noblegarden" ] .." - " ..ns.L[ "Red" ] .."\n14 = " ..ns.L[ "Noblegarden" ]
				.." - " ..ns.L[ "Magenta" ] .."\n15 = " ..ns.L[ "Noblegarden" ] .." - " ..ns.L[ "Purple" ] .."\n16 = "
				..ns.L[ "Noblegarden" ] .." - " ..ns.L[ "Light Blue" ] .."\n17 = " ..ns.L[ "Noblegarden" ] .." - " ..ns.L[ "Blue" ]
				.."\n18 = " ..ns.L[ "Noblegarden" ] .." - " ..ns.L[ "Dark Blue" ] .."\n19 = " ..ns.L[ "Noblegarden" ] .." - "
				..ns.L[ "Turquoise" ] .."\n20 = " ..ns.L[ "Noblegarden" ] .." - " ..ns.L[ "Light Green" ]  
			 
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
				showBCE = {
					name = "Show Brightly Colored Eggs",
					desc = "Show a (much smaller) pin in Razor Hill / Dolanaar etc",
					type = "toggle",
					width = "full",
					arg = "showBCE",
					order = 10,
				},
			},
		},
		icon = {
			type = "group",
			name = ns.L[ "Map Pin Selections" ],
			inline = true,
			args = {
				iconNGBCE = {
					type = "range",
					name = ns.L[ "Brightly Colored Egg" ],
					desc = ns.iconStandard ..iconNG, 
					min = 1, max = 18, step = 1,
					arg = "iconNGBCE",
					order = 20,
				},
				iconQuackingDown = {
					type = "range",
					name = ns.L[ "Quacking Down" ],
					desc = ns.iconStandard ..iconNG, 
					min = 1, max = 20, step = 1,
					arg = "iconQuackingDown",
					disabled = ns.preAchievements,
					order = 21,
				},
				iconDaetan = {
					type = "range",
					name = ns.L[ "Daetan Swiftplume" ],
					desc = ns.iconStandard ..iconNG, 
					min = 1, max = 20, step = 1,
					arg = "iconDaetan",
					disabled = ns.preAchievements,
					order = 22,
				},
				iconDesertRose = {
					type = "range",
					name = ns.L[ "Desert Rose" ],
					desc = ns.iconStandard ..iconNG, 
					min = 1, max = 20, step = 1,
					arg = "iconDesertRose",
					disabled = ns.preAchievements,
					order = 23,
				},
				iconSpringFling = {
					type = "range",
					name = ns.L[ "Spring Fling" ],
					desc = ns.iconStandard ..iconNG, 
					min = 1, max = 20, step = 1,
					arg = "iconSpringFling",
					disabled = ns.preAchievements,
					order = 24,
				},
				iconGreatEggHunt = {
					type = "range",
					name = ns.L[ "The Great Egg Hunt" ],
					desc = ns.iconStandard ..iconNG, 
					min = 1, max = 20, step = 1,
					arg = "iconGreatEggHunt",
					arg = "iconHardBoiled",
					disabled = ns.preAchievements,
					order = 25,
				},
				
				iconHardBoiled = {
					type = "range",
					name = ns.L[ "Hard Boiled" ] .."/" ..ns.L[ "Noblegarden" ],
					desc = ns.iconStandard ..iconNG, 
					min = 1, max = 20, step = 1,
					arg = "iconHardBoiled",
					disabled = ns.preAchievements,
					order = 26,
				},
				
			},
		},
		notes = { type = "group", name = ns.L[ "Notes" ], inline = true,
			args = ns.MakeSetChatCommands( { "/ng", "/noble", } ), },
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_Noblegarden_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", ns.addOnName )
end

function HandyNotes_Noblegarden_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ ns.eventName ] .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ] .."/" ..ns.L[ "Right" ], ns.colour.plaintext
		..ns.L[ "Options" ] )
	GameTooltip:Show()
end

function HandyNotes_Noblegarden_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_Noblegarden1, SLASH_Noblegarden2 = "/ng", "/noble"
SlashCmdList[ "Noblegarden" ] = function( options ) ns.Slash( options ) end