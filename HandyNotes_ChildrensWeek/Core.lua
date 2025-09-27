--[[
                                ----o----(||)----oo----(||)----o----

                                           Children's Week

                                       v1.14 - 2nd August 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

ns.defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
					remove = { true, true, true }, -- Seasonal, Daily, One Time
					removeAchieveChar = false, removeAchieveAcct = false,
					removeOneTime = true, removeSeasonal = true, removeDaily = true,
					iconOrphan = 17, iconAchieves = 11, iconMeta = 18, iconBadEx = 13,
					iconFlavour = 14, iconPets = 15, iconRelated = 16, iconUtgarde = 12,
					iconVendor = 13, } }
					
-- Localised
local ipairs, next = _G.ipairs,  _G.next

local GameTooltip = _G.GameTooltip
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local LibStub = _G.LibStub
local HandyNotes = _G.HandyNotes

-- ---------------------------------------------------------------------------------------------------------------------------------

local function PassOracleFrenzyheart( q )
	if ( q.id == 13926 ) or ( q.id == 13929 ) or ( q.id == 13933 ) or ( q.id == 13950 ) or ( q.id == 13956 ) or
				( q.id == 13954 ) or ( q.id == 13937 ) or ( q.id == 13959 ) then -- Oracles
		if IsQuestFlaggedCompleted( 13927 ) == true then return false end
	elseif ( q.id == 13927 ) or ( q.id == 13930 ) or ( q.id == 13934 ) or ( q.id == 13951 ) or ( q.id == 13955 ) or
				( q.id == 13957 ) or ( q.id == 13938 ) or ( q.id == 13960 ) then -- Frenzyheart
		if IsQuestFlaggedCompleted( 13926 ) == true then return false end
	end
	return true
end

local function ShowQuests( pin )
	if not pin.quests then return false end
	if ns.PassAllChecks( pin.quests ) == true then
		for i, v in ipairs( ns.questTypes ) do
			for _, q in ipairs( pin.quests ) do
				if ns.PassAllChecks( q ) and ( q.qType == v ) and PassOracleFrenzyheart( q ) then
					if ns.db[ ns.questTypesDB[ i ] ] == false then return true end
					if IsQuestFlaggedCompleted( q.id ) == false then return true end
				end
			end
		end
	end
	return false
end

function ns.handyNotesPinIterator( t, prev )
	if not t then return end
	local hash;
	local coord, pin = next( t, prev )
	while coord do
		if pin and ns.PassAzerothCheck( pin ) and ns.PassAllChecks( pin ) and 
				( pin.alwaysShow or ns.ShowAchievements( pin ) or ShowQuests( pin ) or ns.ShowAnyway( pin) ) then
			if pin.orphan then
				hash = ( ns.db.iconOrphan <= 10 ) and ns.db.iconOrphan or ( ns.db.iconOrphan + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.achieves then
				hash = ( ns.db.iconAchieves <= 10 ) and ns.db.iconAchieves or ( ns.db.iconAchieves + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.meta then
				hash = ( ns.db.iconMeta <= 10 ) and ns.db.iconMeta or ( ns.db.iconMeta + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.badEx then
				hash = ( ns.db.iconBadEx <= 10 ) and ns.db.iconBadEx or ( ns.db.iconBadEx + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.flavour then
				hash = ( ns.db.iconFlavour <= 10 ) and ns.db.iconFlavour or ( ns.db.iconFlavour + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ) * 2, ns.db.iconAlpha
			elseif pin.pets then
				hash = ( ns.db.iconPets <= 10 ) and ns.db.iconPets or ( ns.db.iconPets + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.related then
				hash = ( ns.db.iconRelated <= 10 ) and ns.db.iconRelated or ( ns.db.iconRelated + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.utgarde then
				hash = ( ns.db.iconUtgarde <= 10 ) and ns.db.iconUtgarde or ( ns.db.iconUtgarde + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.vendor then
				hash = ( ns.db.iconVendor <= 10 ) and ns.db.iconVendor or ( ns.db.iconVendor + 10 )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			end				
		end
		coord, pin = next( t, coord )
	end
end
	
-- ---------------------------------------------------------------------------------------------------------------------------------

local iconCW = "\n11 = " ..ns.L[ "Cupcake" ] .." - " ..ns.L[ "Pink" ] .."\n12 = " ..ns.L[ "Cupcake" ] .." - "
				..ns.L[ "White" ] .."\n13 = " ..ns.L[ "Icecream Cone" ] .."\n14 = " ..ns.L[ "Toy Train" ] .."\n15 = "
				..ns.L[ "Teddy Bear" ] .." - " ..ns.L[ "Brown" ] .."\n16 = " ..ns.L[ "Teddy Bear" ] .." - " ..ns.L[ "Dark Blue" ]
				.."\n17 = " ..ns.L[ "Teddy Bear" ] .." - " ..ns.L[ "Light Blue" ] .."\n18 = " ..ns.L[ "Teddy Bear" ] .." - "
				..ns.L[ "Light Green" ]

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
				iconOrphan = {
					type = "range",
					name = ns.L[ "Orphan" ],
					desc = ns.iconStandard ..iconCW,
					min = 1, max = 18, step = 1,
					arg = "iconOrphan",
					order = 21,
				},
				iconAchieves = {
					type = "range",
					name = ns.L[ "Achievement" ],
					desc = ns.iconStandard ..iconCW,
					min = 1, max = 18, step = 1,
					arg = "iconAchieves",
					disabled = ns.preAchievements,
					order = 22,
				},
				iconMeta = {
					type = "range",
					name = ns.L[ "For the Children" ],
					desc = ns.iconStandard ..iconCW,
					min = 1, max = 18, step = 1,
					arg = "iconMeta",
					disabled = ns.preAchievements,
					order = 23,
				},
				iconBadEx = {
					type = "range",
					name = ns.L[ "Bad Example" ],
					desc = ns.iconStandard ..iconCW,
					min = 1, max = 18, step = 1,
					arg = "iconBadEx",
					disabled = ns.preAchievements,
					order = 24,
				},
				iconFlavour = {
					type = "range",
					name = ns.L[ "Flavour" ],
					desc = ns.iconStandard ..iconCW,
					min = 1, max = 18, step = 1,
					arg = "iconFlavour",
					order = 25,
				},
				iconPets = {
					type = "range",
					name = ns.L[ "Pet Parade" ],
					desc = ns.iconStandard ..iconCW,
					min = 1, max = 18, step = 1,
					arg = "iconPets",
					order = 26,
				},
				iconRelated = {
					type = "range",
					name = ns.L[ "Related" ],
					desc = ns.iconStandard ..iconCW,
					min = 1, max = 18, step = 1,
					arg = "iconRelated",
					disabled = ns.preAchievements,
					order = 27,
				},
				iconUtgarde = {
					type = "range",
					name = ns.L[ "Utgarde" ] .."++",
					desc = ns.iconStandard ..iconCW,
					min = 1, max = 18, step = 1,
					arg = "iconUtgarde",
					disabled = ns.preAchievements,
					order = 28,
				},
				iconVendor = {
					type = "range",
					name = ns.L[ "Vendors" ] .."++",
					desc = ns.iconStandard ..iconCW,
					min = 1, max = 18, step = 1,
					arg = "iconVendor",
					disabled = ( ns.version < 110105 ),
					order = 29,
				},
			},
		},
		notes = { type = "group", name = ns.L[ "Notes" ], inline = true,
			args = ns.MakeSetChatCommands( { "/cw", "/childrens", "/cweek", } ), },
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_ChildrensWeek_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", ns.addOnName )
end

function HandyNotes_ChildrensWeek_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ ns.eventName ] .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ] .."/" ..ns.L[ "Right" ], ns.colour.plaintext
		..ns.L[ "Options" ] )
	GameTooltip:Show()
end

function HandyNotes_ChildrensWeek_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_ChildrensWeek1, SLASH_ChildrensWeek2, SLASH_ChildrensWeek3 = "/cw", "/childrens", "/cweek"
SlashCmdList[ "ChildrensWeek" ] = function( options ) ns.Slash( options ) end