--[[
                                ----o----(||)----oo----(||)----o----

                                         Love is in the Air

                                       v1.20 - 2nd August 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

ns.defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
					remove = { true, true, true, true }, -- One Time, Seasonal, Weekly, Daily
					removeAchieveChar = false, removeAchieveAcct = false,
					removeOneTime = true, removeSeasonal = true, removeDaily = true,
					iconFoolForLove = 16, iconLoveRays = 15, iconFistful = 12, iconVendorAchieves = 11,
					iconDungeon = 14, iconDangerous = 13, iconHistory = 23, iconCrushing = 13,
					iconLoveLanguage = 11, iconScenicGetaway = 18, iconSelfCare = 19, iconSupport = 21,
					iconIntroduction = 18, } }

-- Localised
local ipairs, next = _G.ipairs,  _G.next

local GameTooltip = _G.GameTooltip
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local LibStub = _G.LibStub
local HandyNotes = _G.HandyNotes

-- ---------------------------------------------------------------------------------------------------------------------------------

local function ShowQuests( pin )
	if not pin.quests then return false end
	if ns.PassAllChecks( pin.quests ) == true then
		for i, v in ipairs( ns.questTypes ) do
			for _, q in ipairs( pin.quests ) do
				if ns.PassAllChecks( q ) and ( q.qType == v ) then
					if ns.db[ ns.questTypesDB[ i ] ] == false then return true end
					-- Customised for LIITA
					-- Group Relaxation, Relief, Self-Care for Alliance and Horde
					if ( q.id == 78679 ) or ( q.id == 78674 ) or ( q.id == 78664 ) then
						if ( IsQuestFlaggedCompleted( 78679 ) == true ) or ( IsQuestFlaggedCompleted( 78674 ) == true ) or 
								( IsQuestFlaggedCompleted( 78664 ) == true ) then
						else
							return true
						end
					elseif ( q.id == 78991 ) or ( q.id == 78990 ) or ( q.id == 78989 ) then
						if ( IsQuestFlaggedCompleted( 78991 ) == true ) or ( IsQuestFlaggedCompleted( 78990 ) == true ) or 
								( IsQuestFlaggedCompleted( 78989 ) == true ) then
						else
							return true
						end
					-- Group Feralas, Grizzly Hills and Nagrand for Alliance and Horde
					elseif ( q.id == 78988 ) or ( q.id == 78986 ) or ( q.id == 78987 ) then
						if ( IsQuestFlaggedCompleted( 78988 ) == true ) or ( IsQuestFlaggedCompleted( 78986 ) == true ) or 
								( IsQuestFlaggedCompleted( 78987 ) == true ) then
						else
							return true
						end
					elseif ( q.id == 78594 ) or ( q.id == 78565 ) or ( q.id == 78591 ) then
						if ( IsQuestFlaggedCompleted( 78594 ) == true ) or ( IsQuestFlaggedCompleted( 78565 ) == true ) or 
								( IsQuestFlaggedCompleted( 78591 ) == true ) then
						else
							return true
						end
					elseif IsQuestFlaggedCompleted( q.id ) == false then
						return true
					end
					return true
				end
			end
		end
	end
	return false
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function TextureArrayIndex( seed )
	return ( ( seed <= 10 ) and seed or
			( ( seed <= 17 ) and ( seed + 10 ) or ( ( seed <= 21 ) and ( seed + 13 ) or ( seed + 19 ) ) ) )
end

function ns.handyNotesPinIterator( t, prev )
	if not t then return end
	local hash;
	local coord, pin = next( t, prev )
	while coord do
		if pin and ns.PassAzerothCheck( pin ) and ns.PassAllChecks( pin ) and 
				( pin.alwaysShow or ns.ShowAchievements( pin ) or ShowQuests( pin ) or ns.ShowAnyway( pin) ) then
			if pin.crushing then
				hash = TextureArrayIndex( ns.db.iconCrushing )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.loveLanguage then
				hash = TextureArrayIndex( ns.db.iconLoveLanguage )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.selfCare then
				hash = TextureArrayIndex( ns.db.iconSelfCare )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.scenicGetaway then
				hash = TextureArrayIndex( ns.db.iconScenicGetaway )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.introduction then
				hash = TextureArrayIndex( ns.db.iconIntroduction )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.support then
				hash = TextureArrayIndex( ns.db.iconSupport )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.foolForLove then
				hash = TextureArrayIndex( ns.db.iconFoolForLove )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.vendorAchieves then
				hash = TextureArrayIndex( ns.db.iconVendorAchieves )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.loveRays then
				hash = TextureArrayIndex( ns.db.iconLoveRays )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.fistful then
				hash = TextureArrayIndex( ns.db.iconFistful )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.dungeon then
				hash = TextureArrayIndex( ns.db.iconDungeon )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.dangerous then
				hash = TextureArrayIndex( ns.db.iconDangerous )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ), ns.db.iconAlpha
			elseif pin.history then
				hash = TextureArrayIndex( ns.db.iconHistory )
				return coord, nil, ns.textures[ hash ], ns.ScalePin( hash ) * 2, ns.db.iconAlpha
			end				
		end
		coord, pin = next( t, coord )
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function ReturnAchievementName( aID, extra )
	if ns.version > 30000 then
		return ( select( 2, GetAchievementInfo( aID ) ) ..extra )
	else
		return ""
	end
end

ns.iconLIITA = "\n11 = " .. ns.L["Basket"] .."\n12 = " ..ns.L["Candy Sack"] .."\n13 = " ..ns.L["Cologne"] .."\n14 = " ..ns.L["Perfume"]
			.."\n15 = " ..ns.L["Ray"] .."\n16 = " ..ns.L["Rocket"] .."\n17 = " ..ns.L["Love Token"] .."\n18 = " ..ns.L["Love"] .." "
			..ns.L["Blue"] .."\n19 = " ..ns.L["Love"] .." " ..ns.L["Green"] .."\n20 = " ..ns.L["Love"] .." " ..ns.L["Red"] .."/"
			..ns.L["Pink"] .."\n21 = " ..ns.L["Love"] ..ns.L["Red"] .."/" ..ns.L["Yellow"] .."\n22 = " ..ns.L["Candy"] .." "
			..ns.L["Blue"] .."\n23 = " ..ns.L["Candy"] .." " ..ns.L["Pink"]

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
				iconFoolForLove = {
					type = "range",
					name = ReturnAchievementName( 1693, "" ), -- Fool For Love
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconFoolForLove",
					disabled = ns.preAchievements,
					order = 20,
				},
				iconLoveRays = {
					type = "range",
					name = ReturnAchievementName( 9394, "++" ), -- 50 Love Rays plus others
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconLoveRays",
					disabled = ns.preAchievements,
					order = 21,
				},
				iconFistful = {
					type = "range",
					name = ReturnAchievementName( 1699, "++" ), -- Fistful of Love plus others
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconFistful",
					disabled = ns.preAchievements,
					order = 22,
				},
				iconVendorAchieves = {
					type = "range",
					name = ReturnAchievementName( 1702, "++" ), -- Sweet Tooth plus others
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconVendorAchieves",
					disabled = ns.preAchievements,
					order = 23,
				},
				iconDungeon = {
					type = "range",
					name = ReturnAchievementName( 4624, "++" ), -- Tough Love plus others
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconDungeon",
					disabled = ns.preAchievements,
					order = 24,
				},
				iconDangerous = {
					type = "range",
					name = ReturnAchievementName( 1695, "++" ), -- Dangerous Love plus others
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconDangerous",
					disabled = ns.preAchievements,
					order = 25,
				},
				iconHistory = {
					type = "range",
					name = ns.L[ "History" ],
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconHistory",
					disabled = ns.preAchievements,
					order = 26,
				},
				iconCrushing = {
					type = "range",
					name = ns.L[ "Crushing the Crown" ],
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconCrushing",
					disabled = ns.preAchievements,
					order = 27,
				},
				iconLoveLanguage = {
					type = "range",
					name = ReturnAchievementName( 19508, "++" ), -- Love Language Expert plus others
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconLoveLanguage",
					disabled = ns.preAchievements,
					order = 28,
				},
				iconScenicGetaway = {
					type = "range",
					name = ns.L[ "Getaway to Scenic..." ],
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconScenicGetaway",
					disabled = ns.preAchievements,
					order = 29,
				},
				iconSelfCare = {
					type = "range",
					name = ns.L[ "The Gift of..." ],
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconSelfCare",
					disabled = ns.preAchievements,
					order = 30,
				},
				iconSupport = {
					type = "range",
					name = ReturnAchievementName( 19400, "" ), -- Support Your Local Artisans
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconSupport",
					disabled = ns.preAchievements,
					order = 31,
				},
				iconIntroduction = {
					type = "range",
					name = ns.L[ "Take a Look Around" ],
					desc = ns.iconStandard ..ns.iconLIITA, 
					min = 1, max = 23, step = 1,
					arg = "iconIntroduction",
					disabled = ns.preAchievements,
					order = 32,
				},
			},
		},
		notes = { type = "group", name = ns.L[ "Notes" ], inline = true,
			args = ns.MakeSetChatCommands( { "/loveair", "/liita", } ), },
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_LoveIsInTheAir_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", ns.addOnName )
end
 
function HandyNotes_LoveIsInTheAir_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ ns.eventName ] .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ] .."/" ..ns.L[ "Right" ], ns.colour.plaintext
		..ns.L[ "Options" ] )
	GameTooltip:Show()
end

function HandyNotes_LoveIsInTheAir_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_LoveIsInTheAir1, SLASH_LoveIsInTheAir2 = "/loveair", "/liita" -- Can't use /love
SlashCmdList[ "LoveIsInTheAir" ] = function( options ) ns.Slash( options ) end