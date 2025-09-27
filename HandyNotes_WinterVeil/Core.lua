--[[
                                ----o----(||)----oo----(||)----o----

                                             Winter Veil

                                       v4.27 - 9th August 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

ns.defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
					remove = { true, true, true, true }, -- One Time, Seasonal, Weekly, Daily
					removeAchieveChar = false, removeAchieveAcct = false,
					removeOneTime = true, removeSeasonal = true, removeDaily = true,
					icon_bbKing = 17, icon_caroling = 21, icon_gourmet = 16, icon_reveler = 13,
					icon_miscQuests = 18, icon_vendor = 19, icon_onMetzen = 24, icon_armada = 23, 
					icon_scroogePvP = 14, icon_wondervolt = 20, icon_flavour = 22, } }

-- Localised
local ipairs, next = _G.ipairs,  _G.next

local GameTooltip = _G.GameTooltip
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local LibStub = _G.LibStub
local HandyNotes = _G.HandyNotes

-- ---------------------------------------------------------------------------------------------------------------------------------

local function TextureArrayIndex( seed )
	return ( ( seed <= 10 ) and seed or
			( ( seed <= 16 ) and ( seed + 10 ) or ( ( seed <= 21 ) and ( seed + 14 ) or ( seed + 19 ) ) ) )
end

function ns.handyNotesPinIterator( t, prev )
	if not t then return end
	local hash;
	local coord, pin = next( t, prev )
	while coord do
		if pin and ns.PassAzerothCheck( pin ) and ns.PassAllChecks( pin ) and 
				( pin.alwaysShow or ns.ShowAchievements( pin ) or ns.ShowQuests( pin ) or ns.ShowAnyway( pin) ) then
			if pin.bbKing then
				hash = TextureArrayIndex( ns.db.icon_bbKing )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.caroling then
				hash = TextureArrayIndex( ns.db.icon_caroling )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.gourmet then
				hash = TextureArrayIndex( ns.db.icon_gourmet )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.reveler then
				hash = TextureArrayIndex( ns.db.icon_reveler )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.miscQuests then
				hash = TextureArrayIndex( ns.db.icon_miscQuests )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.vendor then
				hash = TextureArrayIndex( ns.db.icon_vendor )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.onMetzen then
				hash = TextureArrayIndex( ns.db.icon_onMetzen )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.armada then
				hash = TextureArrayIndex( ns.db.icon_armada )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.scroogePvP then
				hash = TextureArrayIndex( ns.db.icon_scroogePvP )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.wondervolt then
				hash = TextureArrayIndex( ns.db.icon_wondervolt )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.flavour then
				hash = TextureArrayIndex( ns.db.icon_flavour )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ) * 2, ns.db.iconAlpha
			end
		end
		coord, pin = next( t, coord )
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local iconWV = "\n11 = " .. ns.L[ "Ribbon Box" ] .." - " ..ns.L[ "Blue" ] .."\n12 = " ..ns.L[ "Ribbon Box" ] .." - "
			..ns.L[ "Green" ] .."\n13 = " ..ns.L[ "Ribbon Box" ] .." - " ..ns.L[ "Pink" ] .."\n14 = " ..ns.L[ "Ribbon Box" ] .." - "
			..ns.L[ "Purple" ] .."\n15 = " ..ns.L[ "Ribbon Box" ] .." - " ..ns.L[ "Red" ] .."\n16 = " ..ns.L[ "Ribbon Box" ] .." - "
			..ns.L[ "Turquoise" ] .."\n17 = " ..ns.L[ "Santa Hat" ] .." - " ..ns.L[ "Blue" ] .."\n18 = " ..ns.L[ "Santa Hat" ]
			.." - " ..ns.L[ "Green" ] .."\n19 = " ..ns.L[ "Santa Hat" ] .." - " ..ns.L[ "Pink" ] .."\n20 = " ..ns.L[ "Santa Hat" ]
			.." - " ..ns.L[ "Red" ] .."\n21 = " ..ns.L[ "Santa Hat" ] .." - " ..ns.L[ "Yellow" ] .."\n22 = " ..ns.L[ "Candy Cane" ]
			.."\n23 = " ..ns.L[ "Ginger Bread" ] .."\n24 = " ..ns.L[ "Holly" ]

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
				icon_bbKing = {
					type = "range",
					name = ns.L[ "BB King" ],
					desc = ns.iconStandard ..iconWV, 
					min = 1, max = 24, step = 1,
					arg = "icon_bbKing",
					disabled = ns.preAchievements,
					order = 20,
				},
				icon_caroling = {
					type = "range",
					name = ns.L[ "Caroling" ] .." ++",
					desc = ns.iconStandard ..iconWV, 
					min = 1, max = 24, step = 1,
					arg = "icon_caroling",
					disabled = ns.preAchievements,
					order = 21,
				},
				icon_gourmet = {
					type = "range",
					name = ns.L[ "Gourmet" ],
					desc = ns.iconStandard ..iconWV, 
					min = 1, max = 24, step = 1,
					arg = "icon_gourmet",
					disabled = ns.preAchievements,
					order = 22,
				},
				icon_reveler = {
					type = "range",
					name = ns.L[ "Ogri'la" ] .."++",
					desc = ns.iconStandard ..iconWV .."\n\n" ..ns.L[ "Ogri'la" ] ..", " ..ns.L[ "Holiday Bromance" ] ..", "
							..ns.L[ "Let It Snow" ], 
					min = 1, max = 24, step = 1,
					arg = "icon_reveler",
					disabled = ns.preAchievements,
					order = 23,
				},
				icon_miscQuests = {
					type = "range",
					name = ns.L[ "Other Quests" ],
					desc = ns.iconStandard ..iconWV, 
					min = 1, max = 24, step = 1,
					arg = "icon_miscQuests",
					order = 24,
				},
				icon_vendor = {
					type = "range",
					name = ns.L[ "Vendors" ],
					desc = ns.iconStandard ..iconWV, 
					min = 1, max = 24, step = 1,
					arg = "icon_vendor",
					order = 25,
				},
				icon_onMetzen = {
					type = "range",
					name = ns.L[ "On Metzen!" ] .."/" ..ns.L[ "'Tis the Season" ] .." ++",
					desc = ns.iconStandard ..iconWV, 
					min = 1, max = 24, step = 1,
					arg = "icon_onMetzen",
					disabled = ns.preAchievements,
					order = 26,
				},
				icon_armada = {
					type = "range",
					name = ns.L[ "Iron Armada" ] .." ++",
					desc = ns.iconStandard ..iconWV, 
					min = 1, max = 24, step = 1,
					arg = "icon_armada",
					disabled = ns.preAchievements,
					order = 27,
				},
				icon_scroogePvP = {
					type = "range",
					name = ns.L[ "Scrooge" ] .." ++",
					desc = ns.iconStandard ..iconWV, 
					min = 1, max = 24, step = 1,
					arg = "icon_scroogePvP",
					disabled = ns.preAchievements,
					order = 28,
				},
				icon_wondervolt = {
					type = "range",
					name = ns.L[ "Little Helper" ],
					desc = ns.iconStandard, 
					min = 1, max = 24, step = 1,
					arg = "icon_wondervolt",
					disabled = ns.preAchievements,
					order = 29,
				},
				icon_flavour = {
					type = "range",
					name = ns.L[ "Winter Veil" ],
					desc = ns.iconStandard ..iconWV, 
					min = 1, max = 24, step = 1,
					arg = "icon_flavour",
					order = 30,
				},
			},
		},
		notes = { type = "group", name = ns.L[ "Notes" ], inline = true,
			args = ns.MakeSetChatCommands( { "/wv", "/winter", "/santa", } ), },
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_WinterVeil_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", ns.addOnName )
end
 
function HandyNotes_WinterVeil_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ ns.eventName ] .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ] .."/" ..ns.L[ "Right" ], ns.colour.plaintext
		..ns.L[ "Options" ] )
	GameTooltip:Show()
end

function HandyNotes_WinterVeil_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_WinterVeil1, SLASH_WinterVeil2, SLASH_WinterVeil3 = "/wv", "/winter", "/santa"
SlashCmdList[ "WinterVeil" ] = function( options ) ns.Slash( options ) end