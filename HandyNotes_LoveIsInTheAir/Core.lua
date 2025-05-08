--[[
                                ----o----(||)----oo----(||)----o----

                                         Love is in the Air

                                        v1.15 - 5th May 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

ns.defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
					remove = { true, true, true }, -- Seasonal, Daily, One Time
					removeAchieveChar = false, removeAchieveAcct = false,
					removeOneTime = true, removeSeasonal = true, removeDaily = true,
					iconFoolForLove = 12, iconLoveRays = 11, iconFistful = 8, iconVendorAchieves = 7,
					iconDungeon = 10, iconDangerous = 9, iconHistory = 18, iconCrushing = 9,
					iconLoveLanguage = 7, iconScenicGetaway = 13, iconSelfCare = 14, iconSupport = 16,
					iconIntroduction = 13, } }
local pluginHandler = {}

-- Localised
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementNumCriteria = GetAchievementNumCriteria
local GetMapChildrenInfo = C_Map.GetMapChildrenInfo
local GetTime = GetTime
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local LibStub = _G.LibStub
local QuestUtils_GetQuestName = QuestUtils_GetQuestName
local UIParent = _G.UIParent
local format = _G.format
local gsub = string.gsub
local ipairs = _G.ipairs
local next = _G.next

local HandyNotes = _G.HandyNotes

-- ---------------------------------------------------------------------------------------------------------------------------------

local function PassAllChecks( pin )
	-- Class
	if ( pin.class == nil) or ( pin.class == ns.class ) then
	else
		return false
	end
	-- Faction
	if ( pin.faction == nil ) or ( ( pin.faction == "Horde" ) and ( ns.faction == "Horde" ) ) or
								( ( pin.faction == "Alliance" ) and ( ns.faction == "Alliance" ) ) then
	else
		return false
	end
	-- Game Version
	if pin.version and pin.versionUnder then
		if ( ns.version >= pin.version ) and ( ns.version < pin.versionUnder ) then
			return true
		end
	elseif pin.version then
		if ( ns.version >= pin.version ) then
			return true
		end
	elseif pin.versionUnder then
		if ( ns.version < pin.versionUnder ) then
			return true
		end
	else	
 		return true
	end
	return false
end

local function CharacterCompleted( character )
	-- Pass it parm #14 from GetAchievementInfo(). Returns if the character has really completed the achievement.
	-- This fuction disregards sharing and Warbands and effectively relies upon a data return quirk to work.
	-- _, _, _, completedA, _, _, _, _, _, _, _, _, _, charName = GetAchievementInfo( v.id )
	-- _, _, completedC, _,  _, charName, _, _, _, _, eligible = GetAchievementCriteriaInfo( v.id, v.index )
	-- Testing late March 2025, retail 11.1.0:
	-- Eligible is always true - at least outside of the event. CompletedA is an account wide completion boolean
	-- CompletedC is always false except if the character has actually (for real) completed all of the criteria
	-- CharName is always nil except if the character has actually (for real) completed the achievement
	-- The above testing outcomes indicate that the Wow Wiki GG website's API data is incorrect / not up to date as of March 2025
	-- Going with CharName rather than CompletedC purely on a hunch that it'll need less maintenance over time lol
	-- 22/4/25: Classic Cataclysm has nil charNames. Retail would have been ""
	if ( character == nil ) or ( character ~= ns.name ) then
		return false
	else
		return true
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function CorrectMapPhase( mapID, old )

	if ( ns.version < 60000 ) then return true end -- Safe to drop through the code but more efficient to just exit

	if ( mapID == 17 ) or -- Blasted Lands
			( mapID == 18 ) or ( mapID == 2070 ) or -- Tirisfal Glades
			( mapID == 57 ) or ( mapID == 62 ) or ( mapID == 70 ) or ( mapID == 81 ) or
				-- Teldrassil, Silithus, Darkshore, Theramore, Darnassus
			( mapID == 249 ) or ( mapID == 1527 ) then -- Uldum
		for i = 1, 40 do -- 40 is rather arbitrary these days I think
			local auraData = UnitAura( "player", i, "HELPFUL" )
			if auraData == nil then break end
			if auraData.spellId then
				if ( auraData.spellId == 372329 ) or ( auraData.spellId == 276827 ) or ( auraData.spellId == 255152 ) or
					-- Time Travelling buff for Blasted Lands, Tirisfal Glades, Silithus
						( auraData.spellId == 290246 ) or ( auraData.spellId == 123979 ) or ( auraData.spellId == 317785 )  then
					-- Time Travelling buff for Darkshore/Teldrassil/Darnassus, Theramore, Uldum
					return old
				end
			end
		end
		return not old
	else
		return true
	end
end

local function CompletionShow( completed, whatever, colour, name, completionS ) -- Last two parms are optional
	GameTooltip:AddDoubleLine( ( whatever and ( colour ..whatever) or " " ), 
		( ( completed == true ) and ( ns.colour.completeG ..ns.L[ "Completed" ] ) or ( ns.colour.completeR
		..ns.L[ "Not Completed" ] ) ) .." (" ..( ( completionS == nil ) and "" or ( ( completionS == true ) and
		ns.colour.completeG or ns.colour.completeR ) ) ..( name or "Account" )
		..( ( completed == true ) and ns.colour.completeG or ns.colour.completeR ) ..")" )
end

local function Tip( tip )
	if tip then
		GameTooltip:AddLine( ns.spaceLine ..ns.colour.plaintext ..ns.L[ tip ], nil, nil, nil, true )
		ns.spaceLine = ""
	end
end

local function GuideTip( pin )
	-- Guides preceed Tips. Guides and Tips are not shown for completed Quests/Achievements
	-- A Guide will be extensive, way beyond the scope of a Google Translate, for example.
	-- A tip should be quite short, perhaps finessing a generic guide. A tip often should be translated
	if pin.guide then
		GameTooltip:AddLine( ns.spaceLine ..ns.colour.Guide ..pin.guide, nil, nil, nil, true )
		ns.spaceLine = ""
	end
	if pin.tip then
		Tip( pin.tip )
	end
	return ( pin.tip or pin.guide ) and true or false
end

local function ShowQuestStatus( quest, colour, backupName )
	if ns.firstOne == true then
		GameTooltip:AddLine( ns.colour.highlight .."\n" ..ns.L[ quest.qType ] )
		ns.firstOne = false
	end
	local level = quest.level and ( ns.colour.plaintext .." (" ..ns.L[ "Level" ] .." " ..quest.level ..")" ) or ""
	local questName = QuestUtils_GetQuestName( quest.id )
	-- Reminder: C_QuestLog.GetTitleForQuestID() works too for Retail but not for Classic Cata
	-- These calls return localised text. Doesn't need to be in the Quest Log. Server won't immediately respond. 
	questName = ( questName ~= "" ) and ( questName ..level ) or ( quest.name and ( quest.name ..level ) ) or
				( backupName and ( backupName ..level ) ) or ns.L[ "Try again" ]
	local completed = IsQuestFlaggedCompleted( quest.id )
	CompletionShow( completed, questName, colour, ns.name )
	if completed == false then GuideTip( quest ) end
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter( mapFile, coord )
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
	else
		GameTooltip:SetOwner( self, "ANCHOR_RIGHT" )
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]
	if pin == nil then return end
	
	local aName, completedA, completedC, completedQ, description, charName, cType, numCriteria, assetID;
	ns.spaceLine = ""

	GameTooltip:SetText( ns.colour.prefix ..( pin.title or ns.L[ "Children's Week" ] ) )

	if pin.achievements and ( ns.version > 30002 ) and PassAllChecks( pin.achievements ) then
		for _, v in ipairs( pin.achievements ) do
			if PassAllChecks( v ) then
				_, aName, _, completedA, _, _, _, description, _, _, _, _, _, charName = GetAchievementInfo( v.id )
				-- 13th "Earned By Me" parameter is no longer useful. Always true if any other character has the achievement
				GameTooltip:AddLine( "\n" )
				GameTooltip:AddLine( ns.colour.highlight ..ns.L[ "Achievement" ] )
				CompletionShow( completedA, aName, ns.colour.achieveH )
				if ( ns.version < 60000 ) then
					completedC = CharacterCompleted( charName )
					CompletionShow( completedC, nil, nil, ns.name )
				end
				if v.showAllCriteria then
					-- A pin with completion criteria or a meta pin
					GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
					numCriteria = GetAchievementNumCriteria( v.id )					
					for i = 1, numCriteria do
						aName, cType, completedC, _, _, _, _, assetID = GetAchievementCriteriaInfo( v.id, i )
						-- Due to shared achievements and now Warbands there is no indiviudual achievement data available for Retail
						if ( cType == 8 ) then
							-- Achievement type. Meta. cType will show each line as an achievement
							-- Must do it this way as "completed" for the criteria is account wide and for the overall meta
							_, aName, _, _, _, _, _, description, _, _, _, _, _, charName = GetAchievementInfo( assetID )
							completedC = CharacterCompleted( charName )
							CompletionShow( completedC, aName, ns.colour.achieveH, ns.name )
							if completedC == false and description then
								GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
							end
						elseif ( cType == 27 ) then
							-- Quests, eg zones. During the event we can track indiviudual progress towards the achievement
							if i == 1 then GameTooltip:AddLine( ns.colour.achieveH ..ns.L[ "Seasonal" ] ) end
							completedQ = IsQuestFlaggedCompleted( assetID )
							CompletionShow( completedQ, aName, ns.colour.achieveI, ns.name, completedC )
						elseif ns.version < 60000 then
							CompletionShow( completedC, aName, ns.colour.achieveI, ns.name )
						else
							CompletionShow( CharacterCompleted( charName ), aName, ns.colour.achieveH, ns.name )
--							GameTooltip:AddLine( ns.colour.achieveI ..aName )
						end
					end
				else
					GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
					if v.index and ( completedC == false ) then
						aName = GetAchievementCriteriaInfo( v.id, v.index )
						CompletionShow( completedC, aName, ns.colour.achieveI, ns.name )
					end
				end
				GuideTip( v )
			end
		end
	elseif pin.name then
		GameTooltip:AddLine( "\n" )
		GameTooltip:AddLine( ns.colour.highlight ..ns.L[ pin.name ] )
	end

	ns.spaceLine = ""
	
	if pin.quests and PassAllChecks( pin.quests ) then
		for i, v in ipairs( ns.questTypes ) do
			ns.firstOne = true
			for _, q in ipairs( pin.quests ) do
				if PassAllChecks( q ) and ( q.qType == v ) then
					ShowQuestStatus( q, ns.questColours[ i ], ( pin.bce and ns.L[ "Brightly Colored Egg" ] or nil ) )
				end
			end
		end
		GuideTip( pin.quests )
		ns.spaceLine = "\n"
	end

	GuideTip( pin )

	if ( pin.noZidormi == nil ) and ( CorrectMapPhase( mapFile, true ) == false ) then -- True = old
		ns.spaceLine = "\n"
		Tip( ns.L[ "ZidormiWrongPhase" ] )
	end

	if ( ns.db.showCoords == true ) and not pin.noCoords then
		local mX, mY = HandyNotes:getXY(coord)
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( "\n" ..ns.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end

	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function ShowAchievements( pin )
	if not pin.achievements then return false end
	if ns.version < 30002 then return false end -- Achievements began with WotLK patch 3.0.2
	if PassAllChecks( pin.achievements ) == false then return false end
	if ( ns.db.removeAchieveChar == false ) and ( ns.db.removeAchieveAcct == false ) then return true end

	local completed, charName;
	
	local acctCompleted, charCompleted = true, true
	for _,v in ipairs( pin.achievements ) do
		if PassAllChecks( v ) then
			_, _, _, completed, _, _, _, _, _, _, _, _, _, charName = GetAchievementInfo( v.id )
			if completed == false then acctCompleted = false end
			if ( charName == nil ) or ( charName ~= ns.name ) then charCompleted = false end
			-- Using this hack for character specific status as due to sharing/Warbands data is otherwise unavailable
		end
	end
	if ( ns.db.removeAchieveAcct == true ) and ( acctCompleted == true ) then
		return false
	end
	if ( ns.db.removeAchieveChar == true ) and ( charCompleted == true ) then
		return false
	end
	
	return true
end

local function ShowQuests( pin )
	if not pin.quests then return false end
	if PassAllChecks( pin.quests ) == true then
		for i, v in ipairs( ns.questTypes ) do
			for _, q in ipairs( pin.quests ) do
				if PassAllChecks( q ) and ( q.qType == v ) then
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
				end
			end
		end
	end
	return false
end

local function ShowAnyway( pin)
	if pin.achievements or pin.quests then return false end
	return true
end

do
	local function iterator( t, prev )
		if not t then return end
		local coord, pin = next( t, prev )
		while coord do
			if pin and PassAllChecks( pin ) and 
					( pin.alwaysShow or ShowAchievements( pin ) or ShowQuests( pin ) or ShowAnyway( pin) ) then
				if pin.crushing then
					return coord, nil, ns.textures[ ns.db.iconCrushing ],
						ns.db.iconScale * ns.scaling[ ns.db.iconCrushing ], ns.db.iconAlpha
				elseif pin.loveLanguage then
					return coord, nil, ns.textures[ ns.db.iconLoveLanguage ],
						ns.db.iconScale * ns.scaling[ ns.db.iconLoveLanguage ], ns.db.iconAlpha
				elseif pin.selfCare then
					return coord, nil, ns.textures[ ns.db.iconSelfCare ],
						ns.db.iconScale * ns.scaling[ ns.db.iconSelfCare ], ns.db.iconAlpha
				elseif pin.scenicGetaway then
					return coord, nil, ns.textures[ ns.db.iconScenicGetaway ],
						ns.db.iconScale * ns.scaling[ ns.db.iconScenicGetaway ], ns.db.iconAlpha
				elseif pin.introduction then
					return coord, nil, ns.textures[ ns.db.iconIntroduction ],
						ns.db.iconScale * ns.scaling[ ns.db.iconIntroduction ], ns.db.iconAlpha
				elseif pin.support then
					return coord, nil, ns.textures[ ns.db.iconSupport ],
						ns.db.iconScale * ns.scaling[ ns.db.iconSupport ], ns.db.iconAlpha
				elseif pin.foolForLove then
					return coord, nil, ns.textures[ ns.db.iconFoolForLove ],
						ns.db.iconScale * ns.scaling[ ns.db.iconFoolForLove ], ns.db.iconAlpha
				elseif pin.vendorAchieves then
					return coord, nil, ns.textures[ ns.db.iconVendorAchieves ],
						ns.db.iconScale * ns.scaling[ ns.db.iconVendorAchieves ], ns.db.iconAlpha
				elseif pin.loveRays then
					return coord, nil, ns.textures[ ns.db.iconLoveRays ],
						ns.db.iconScale * ns.scaling[ ns.db.iconLoveRays ], ns.db.iconAlpha
				elseif pin.fistful then
					return coord, nil, ns.textures[ ns.db.iconFistful ],
						ns.db.iconScale * ns.scaling[ ns.db.iconFistful ], ns.db.iconAlpha
				elseif pin.dungeon then
					return coord, nil, ns.textures[ ns.db.iconDungeon ],
						ns.db.iconScale * ns.scaling[ ns.db.iconDungeon ], ns.db.iconAlpha
				elseif pin.dangerous then
					return coord, nil, ns.textures[ ns.db.iconDangerous ],
						ns.db.iconScale * ns.scaling[ ns.db.iconDangerous ], ns.db.iconAlpha
				elseif pin.history then
					return coord, nil, ns.textures[ ns.db.iconHistory ],
						ns.db.iconScale * 2 * ns.scaling[ ns.db.iconHistory ], ns.db.iconAlpha
				end
			end
			coord, pin = next( t, coord )
		end
	end
	function pluginHandler:GetNodes2( mapID )
		return iterator, ns.points[ mapID ]
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function AddColouredText( inputText )
	local hash = gsub( ns.L[ inputText ], "%%e", ns.colour.highlight )
	return gsub( hash, "%%s", ns.colour.prefix )
end

local function SubstitutePlayerOrElseAcct( theType, character )
	return gsub( ns.L[ theType ], "%%p", ( character and ns.name or ns.L[ "Account" ] ) )
end

local function ReturnAchievementName( aID, extra )
	if ns.version > 30000 then
		return ( select( 2, GetAchievementInfo( 9394 ) ) ..extra )
	else
		return ""
	end
end

ns.iconStandard = "1 = " ..ns.L["White"] .."\n2 = " ..ns.L["Purple"] .."\n3 = " ..ns.L["Red"] .."\n4 = " ..ns.L["Yellow"]
				.."\n5 = " ..ns.L["Green"] .."\n6 = " ..ns.L["Grey"] .."\n7 = " .. ns.L["Basket"] .."\n8 = " ..ns.L["Candy Sack"]
				.."\n9 = " ..ns.L["Cologne"] .."\n10 = " ..ns.L["Perfume"] .."\n11 = " ..ns.L["Ray"] .."\n12 = " ..ns.L["Rocket"]
				.."\n13 = " ..ns.L["Love"] .." " ..ns.L["Blue"] .."\n14 = " ..ns.L["Love"] .." " ..ns.L["Green"]
				.."\n15 = " ..ns.L["Love"] .." " ..ns.L["Red"] .." " ..ns.L["Pink"]
				.."\n16 = " ..ns.L["Love"] ..ns.L["Red"] .." " ..ns.L["Yellow"] .."\n17 = " ..ns.L["Candy"] .." " ..ns.L["Blue"]
				.."\n18 = " ..ns.L["Candy"] .." " ..ns.L["Pink"] .."\n19 = " ..ns.L["Love Token"]

-- Interface -> Addons -> Handy Notes -> Plugins -> Love is in the Air options
ns.options = {
	type = "group",
	name = ns.L[ "Love is in the Air" ],
	desc = AddColouredText( "AddOn Description" ),
	get = function( info ) return ns.db[ info[ #info ] ] end,
	set = function( info, v )
		ns.db[ info[ #info ] ] = v
		pluginHandler:Refresh()
	end,
	args = {
		options = {
			type = "group",
			-- Add a " " to force this to be before the first group. HN arranges alphabetically on local language
			name = " " ..ns.L[ "Options" ],
			inline = true,
			args = {
				iconScale = {
					type = "range",
					name = ns.L[ "Map Pin Size" ],
					desc = ns.L[ "The Map Pin Size" ],
					min = 1, max = 4, step = 0.1,
					arg = "iconScale",
					order = 1,
				},
				iconAlpha = {
					type = "range",
					name = ns.L[ "Map Pin Alpha" ],
					desc = ns.L[ "The alpha transparency of the map pins" ],
					min = 0, max = 1, step = 0.01,
					arg = "iconAlpha",
					order = 2,
				},
				showCoords = {
					name = ns.L[ "Show Coordinates" ],
					desc = ns.L[ "Show Coordinates Description" ] ..ns.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 3,
				},
				removeSeasonal = {
					name = SubstitutePlayerOrElseAcct( "RWCQuestSeasonal", true ),
					desc = SubstitutePlayerOrElseAcct( "RWCQuestSeasonalDesc", true ),
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					disabled = ns.preAchievements,
					order = 5,
				},
				removeDailies = {
					name = SubstitutePlayerOrElseAcct( "RWCQuestDailies", true ),
					desc = SubstitutePlayerOrElseAcct( "RWCQuestDailiesDesc", true ),
					type = "toggle",
					width = "full",
					arg = "removeDailies",
					disabled = ns.preAchievements,
					order = 6,
				},
				removeAchieveChar = {
					name = SubstitutePlayerOrElseAcct( "RWCAchievements", true ),
					desc = SubstitutePlayerOrElseAcct( "RWCAchievementsDesc", true ),
					type = "toggle",
					width = "full",
					arg = "removeAchieveChar",
					disabled = ns.preAchievements,
					order = 7,
				},
				removeAchieveAcct = {
					name = SubstitutePlayerOrElseAcct( "RWCAchievements" ),
					desc = SubstitutePlayerOrElseAcct( "RWCAchievementsDescAcct" ),
					type = "toggle",
					width = "full",
					arg = "removeAchieveAcct",
					disabled = ns.preAchievements,
					order = 8,
				},
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
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconFoolForLove",
					disabled = ns.preAchievements,
					order = 10,
				},
				iconLoveRays = {
					type = "range",
					name = ReturnAchievementName( 9394, "++" ), -- 50 Love Rays plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconLoveRays",
					disabled = ns.preAchievements,
					order = 11,
				},
				iconFistful = {
					type = "range",
					name = ReturnAchievementName( 1699, "++" ), -- Fistful of Love plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconFistful",
					disabled = ns.preAchievements,
					order = 12,
				},
				iconVendorAchieves = {
					type = "range",
					name = ReturnAchievementName( 1702, "++" ), -- Sweet Tooth plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconVendorAchieves",
					disabled = ns.preAchievements,
					order = 13,
				},
				iconDungeon = {
					type = "range",
					name = ReturnAchievementName( 4624, "++" ), -- Tough Love plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconDungeon",
					disabled = ns.preAchievements,
					order = 14,
				},
				iconDangerous = {
					type = "range",
					name = ReturnAchievementName( 1695, "++" ), -- Dangerous Love plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconDangerous",
					disabled = ns.preAchievements,
					order = 15,
				},
				iconHistory = {
					type = "range",
					name = ns.L[ "History" ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconHistory",
					disabled = ns.preAchievements,
					order = 16,
				},
				iconCrushing = {
					type = "range",
					name = ns.L[ "Crushing the Crown" ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconCrushing",
					disabled = ns.preAchievements,
					order = 17,
				},
				iconLoveLanguage = {
					type = "range",
					name = ReturnAchievementName( 19508, "++" ), -- Love Language Expert plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconLoveLanguage",
					disabled = ns.preAchievements,
					order = 18,
				},
				iconScenicGetaway = {
					type = "range",
					name = ns.L[ "Getaway to Scenic..." ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconScenicGetaway",
					disabled = ns.preAchievements,
					order = 19,
				},
				iconSelfCare = {
					type = "range",
					name = ns.L[ "The Gift of..." ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconSelfCare",
					disabled = ns.preAchievements,
					order = 20,
				},
				iconSupport = {
					type = "range",
					name = ReturnAchievementName( 19400, "" ), -- Support Your Local Artisans
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconSupport",
					disabled = ns.preAchievements,
					order = 21,
				},
				iconIntroduction = {
					type = "range",
					name = ns.L[ "Take a Look Around" ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconIntroduction",
					disabled = ns.preAchievements,
					order = 22,
				},
			},
		},
		notes = {
			type = "group",
			name = ns.L[ "Notes" ],
			inline = true,
			args = {
				noteMenu = { type = "description", name = ns.L[ "MinimapMenu" ], order = 30, },
				separator1 = { type = "header", name = "", order = 31, },
				noteChat = { type = "description", name = ns.L[ "ChatCommands" ]
					..NORMAL_FONT_COLOR_CODE .."/loveair" ..HIGHLIGHT_FONT_COLOR_CODE ..", "
					..NORMAL_FONT_COLOR_CODE .."/liita" ..HIGHLIGHT_FONT_COLOR_CODE ..ns.L[ "ShowPanel" ],
					order = 32, },
			},
		},
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_LoveIsInTheAir_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "LoveIsInTheAir" )
end
 
function HandyNotes_LoveIsInTheAir_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ "Love Is In The Air" ] .."\n\n" )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L[ "Left" ] .."/" ..ns.L[ "Right" ], ns.colour.plaintext
		..ns.L[ "Options" ] )
	GameTooltip:Show()
end

function HandyNotes_LoveIsInTheAir_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub( "HereBeDragons-2.0", true )
	if not HereBeDragons then return end
	
	for continentMapID in next, ns.continents do
		local children = GetMapChildrenInfo( continentMapID, nil, true )
		for _, map in next, children do
			if ns.points[ map.mapID ] then -- Maps here will not propagate upwards
				for coord, v in next, ns.points[ map.mapID ] do
					if ( v.noContinent == nil ) and ( ( v.noAzeroth == nil ) or ( continentMapID ~= 947 ) ) then
						local mx, my = HandyNotes:getXY( coord )
						local cx, cy = HereBeDragons:TranslateZoneCoordinates( mx, my, map.mapID, continentMapID )
						if cx and cy then
							ns.points[ continentMapID ] = ns.points[ continentMapID ] or {}
							ns.points[ continentMapID ][ HandyNotes:getCoord( cx, cy ) ] = v
						end
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB( "LoveIsInTheAir", pluginHandler, ns.options )
	ns.db = LibStub( "AceDB-3.0" ):New( "HandyNotes_LoveIsInTheAirDB", ns.defaults, "Default" ).profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	if GetTime() > ( ns.delay or 0 ) then
		ns.delay = nil
		self:SendMessage( "HandyNotes_NotifyUpdate", "LoveIsInTheAir" )
	end
end

LibStub( "AceAddon-3.0" ):NewAddon( pluginHandler, "HandyNotes_LoveIsInTheAirDB", "AceEvent-3.0" )

-- ---------------------------------------------------------------------------------------------------------------------------------

ns.eventFrame = CreateFrame( "Frame" )

local function OnUpdate()
	if GetTime() > ( ns.saveTime or 0 ) then
		ns.saveTime = GetTime() + 5
		pluginHandler:Refresh()
	end
end

ns.eventFrame:SetScript( "OnUpdate", OnUpdate )

local function OnEventHandler( self, event, ... )
	if ( event == "PLAYER_ENTERING_WORLD" ) or ( event == "PLAYER_LEAVING_WORLD" ) then
		ns.delay = GetTime() + 60 -- Some arbitrary large amount
	elseif ( event == "SPELLS_CHANGED" ) then
		ns.delay = GetTime() + 5 -- Allow a 5 second safety buffer before we resume refreshes
	end
end

ns.eventFrame:RegisterEvent( "PLAYER_ENTERING_WORLD" )
ns.eventFrame:RegisterEvent( "PLAYER_LEAVING_WORLD" )
ns.eventFrame:RegisterEvent( "SPELLS_CHANGED" )
ns.eventFrame:SetScript( "OnEvent", OnEventHandler )

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_LoveIsInTheAir1, SLASH_LoveIsInTheAir2 = "/loveair", "/liita" -- Can't use /love

local function Slash( options )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "LoveIsInTheAir" )
	if ( ns.version >= 100000 ) then
		print( ns.colour.prefix ..ns.L[ "Love Is In The Air" ] ..": " ..ns.colour.highlight ..ns.L[ "TryMinimapMenu" ] )
	end
end

SlashCmdList[ "LoveIsInTheAir" ] = function( options ) Slash( options ) end