--[[
                                ----o----(||)----oo----(||)----o----

                                         Love is in the Air

                                     v1.09 - 16th February 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...
ns.db = {}

-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}

-- Love Is In The Air Theme
ns.colour = {}
ns.colour.prefix	= "\124cFFFF007F" -- Bright Pink
ns.colour.highlight = "\124cFFF433FF" -- Bright Neon Pink
ns.colour.achieveH	= "\124cFFFF69B4" -- Hot Pink
ns.colour.achieveI	= "\124cFF9E7BFF" -- Purple Mimosa
ns.colour.achieveD	= "\124cFFB666D2" -- Rich Lilac
ns.colour.seasonal	= "\124cFFE0B0FF" -- Mauve
ns.colour.daily		= "\124cFFCCCCFF" -- Periwinkle
ns.colour.Guide		= "\124cFFF9B7FF" -- Blossom Pink
ns.colour.plaintext = "\124cFFFF69B4" -- Hot Pink
ns.colour.completeR	= "\124cFFFF0000" -- Red
ns.colour.completeG	= "\124cFF00FF00" -- Green

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								removeDailies = true, removeSeasonal = true, removeAchieveChar = true,
								removeAchieveAcct = false,
								iconFoolForLove = 12, iconLoveRays = 11, iconFistful = 8, iconVendorAchieves = 7,
								iconDungeon = 10, iconDangerous = 9, iconHistory = 18, iconCrushing = 9,
								iconLoveLanguage = 7, iconScenicGetaway = 13, iconSelfCare = 14, iconSupport = 16,
								iconIntroduction = 13, } }
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetMapChildrenInfo = C_Map.GetMapChildrenInfo
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local UnitAura = C_UnitAuras.GetAuraDataByIndex
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local gsub = string.gsub
local next = _G.next
local pairs = _G.pairs

local HandyNotes = _G.HandyNotes

_, _, _, ns.version = GetBuildInfo()
ns.faction = UnitFactionGroup( "player" )
ns.name = UnitName( "player" ) or "Character"

ns.continents = {}
if ( ns.version < 60000) then
	ns.continents[ 1414 ] = true -- Kalimdor
	ns.continents[ 1415 ] = true -- Eastern Kingdoms
	ns.continents[ 1945 ] = ( ns.version >= 20000) and true or nil -- Outland
else
	ns.continents[ 12 ] = true -- Kalimdor
	ns.continents[ 13 ] = true -- Eastern Kingdoms
	ns.continents[ 101 ] = true -- Outland
end
ns.continents[ 113 ] = ( ns.version >= 30000) and true or nil -- Northrend
ns.continents[ 203 ] = ( ns.version >= 40000) and true or nil -- Vashj'ir
ns.continents[ 948 ] = ( ns.version >= 40000) and true or nil -- Vashj'ir
ns.continents[ 424 ] = ( ns.version >= 50000) and true or nil -- Pandaria
ns.continents[ 572 ] = ( ns.version >= 60000) and true or nil -- Draenor
ns.continents[ 619 ] = ( ns.version >= 70000) and true or nil -- Broken Isles
ns.continents[ 875 ] = ( ns.version >= 80000) and true or nil -- Zandalar
ns.continents[ 876 ] = ( ns.version >= 80000) and true or nil -- Kul Tiras
ns.continents[ 1978 ] = ( ns.version >= 90000) and true or nil -- Dragon Isles
ns.continents[ 947 ] = true -- Azeroth

-- ---------------------------------------------------------------------------------------------------------------------------------

local function PassClassCheck( pin )
	if ( pin.class == nil) or ( ns.class == pin.class ) then
		return true
	end
	return false
end

local function PassFactionCheck( pin )
	if ( pin.faction == nil)
			or ( ( ns.faction == "Horde" ) and ( ( pin.faction == "Neutral" ) or ( pin.faction == "Horde" ) ) )
			or ( ( ns.faction == "Alliance" ) and ( ( pin.faction == "Neutral" ) or ( pin.faction == "Alliance" ) ) )
			or ( ( ns.faction == "Neutral" ) and ( pin.faction == "Neutral" ) ) then
		return true
	end
	return false
end

local function PassVersionCheck( pin )
	if pin.version then
		if ns.version >= pin.version then return true end
		return false
	end
	if pin.versionUnder then
		if ns.version < pin.versionUnder then return true end
		return false
	end	
	return true
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function SpacerFirstTimeHeader( firstTime, heading, colour )
	if firstTime == true then
		GameTooltip:AddLine( "\n" )
		GameTooltip:AddLine( colour ..heading )
	end
	return false
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
		GameTooltip:AddLine( ns.colour.plaintext ..ns.L[ tip ], nil, nil, nil, true )
	end
end

local function GuideTip( pin, completed )
	-- Guides preceed Tips
	-- Guides and Tips are not shown for completed Quests/Achievements
	-- A Guide will be extensive, way beyond the scope of a Google Translate
	-- A tip should be quite short, perhaps fineesing a generic guide. A tip often should be translated
	if completed == true then return end
	if pin.guide then
--		GameTooltip:AddLine( ns.colour.highlight .."\n" ..ns.L[ "Guide" ] .."\n" ..ns.colour.Guide ..pin.guide,
		GameTooltip:AddLine( ns.colour.Guide ..pin.guide, nil, nil, nil, true )
	end
	if pin.tip then
		Tip( pin.tip )
	end
	return ( pin.tip or pin.guide ) and true or false
end

local function GetQuestName( pin )
	-- Favour the returned name as it'll be translated but only if a name was returned from the API
	local result = QuestUtils_GetQuestName( pin.id )
	local level = pin.level and ( ns.colour.plaintext .." (" ..ns.L[ "Level" ] .." " ..pin.level ..")" ) or ""
	if result and result ~= "" then return result ..level end
	if pin.name then return ns.L[ pin.name ] ..level end
	return "?"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
	else
		GameTooltip:SetOwner( self, "ANCHOR_RIGHT" )
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]

	local firstTime, aName, completed, description, earnedByMe, earnedByMeSub, cType, assetID;
	
	if pin.name then
		GameTooltip:SetText( ns.colour.prefix ..ns.L[ pin.name ] )
	else
		GameTooltip:SetText( ns.colour.prefix ..( ns.L[ "Love Is In The Air" ] ) )
	end
	
	if pin.achievements and ( ns.version > 30002 ) then
		firstTime = true
		for _,v in ipairs( pin.achievements ) do
			if PassFactionCheck( v ) and PassVersionCheck( v ) then
				_, aName, _, completed, _, _, _, description, _, _, _, _, earnedByMe = GetAchievementInfo( v.id )
				SpacerFirstTimeHeader( firstTime, ns.L[ "Achievement" ], ns.colour.highlight )
				CompletionShow( completed, aName, ns.colour.achieveH )
				-- Strictly speaking the results are NOT correct from the API for the event's meta for earnedByMe
				CompletionShow( earnedByMe , nil, nil, ns.name )
				if v.showAllCriteria then
					GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
					numCriteria = GetAchievementNumCriteria( v.id )
					for i = 1, numCriteria do
						aName, cType, completed, _, _, _, _, assetID = GetAchievementCriteriaInfo( v.id, i )
						if ( cType == 27 ) then
							-- Quest type
								if i == 1 then GameTooltip:AddLine( ns.colour.achieveH ..ns.L[ "Seasonal" ] ) end
								completedQ = IsQuestFlaggedCompleted( assetID )
								CompletionShow( completedQ, aName, ns.colour.achieveI, ns.name, completed )
						elseif ( cType == 8 ) then
							-- Achievement type. Meta. cType will show each line as an achievement
							-- Must do it this way as "completed" for the criteria becomes account wide for meta achievements
							_, aName, _, completed, _, _, _, description, _, _, _, _, earnedByMe = GetAchievementInfo( assetID )
							CompletionShow( earnedByMe, aName, ns.colour.achieveH, ns.name )
							if earnedByMe == false and description then
								GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
							end
						elseif ( cType == 0 ) or ( cType == 29 ) then 
							-- For Love Language Expert this showed an NPC ID mostly
							CompletionShow( completed, aName, ns.colour.achieveH, ns.name )
						end
					end
				else
					GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
					if v.index then
						aName, _, completed = GetAchievementCriteriaInfo( v.id, v.index )
						CompletionShow( completed, aName, ns.colour.achieveI, ns.name )
					end
				end
				GuideTip( v )
			end
		end
	end

	if pin.quests then
		firstTime = true
		for i,v in ipairs( pin.quests ) do
			if PassFactionCheck( v ) and PassVersionCheck( v ) and PassClassCheck( v ) and ( v.qType == "Seasonal" ) then
				GameTooltip:AddLine( ns.colour.highlight .."\n" ..ns.L[ "Seasonal" ] )
				completed = IsQuestFlaggedCompleted( v.id )
				CompletionShow( completed, GetQuestName( v ), ns.colour.seasonal, ns.name )
				GuideTip( v, completed )
			end
		end
		
		firstTime = true
		for i,v in ipairs( pin.quests ) do
			if PassFactionCheck( v ) and PassVersionCheck( v ) and PassClassCheck( v ) and ( v.qType == "Daily" ) then
				completed = IsQuestFlaggedCompleted( v.id )
				GameTooltip:AddLine( ns.colour.highlight .."\n" ..ns.L[ "Daily" ] )
				CompletionShow( completed, GetQuestName( v ), ns.colour.daily, ns.name )
				GuideTip( v )
			end
		end
		
		firstTime = true
		for i,v in ipairs( pin.quests ) do
			if PassFactionCheck( v ) and PassVersionCheck( v ) and PassClassCheck( v ) and ( v.qType == "One Time" ) then
				completed = IsQuestFlaggedCompleted( v.id )
				GameTooltip:AddLine( ns.colour.highlight .."\n" ..ns.L[ "One Time" ] )
				CompletionShow( completed, GetQuestName( v ), ns.colour.seasonal, ns.name )
				GuideTip( v )
			end
		end
	end
	
	GuideTip( pin )

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
	if ns.db.removeAchieveChar == false then return true end

	local completed, earnedByMe;
	for _,v in ipairs( pin.achievements ) do
		if PassFactionCheck( v ) and PassVersionCheck( v ) then
			_, _, _, completed, _, _, _, _, _, _, _, _, earnedByMe = GetAchievementInfo( v.id )
			-- We now know the account and character situation
			if ( ns.db.removeAchieveAcct == true ) and ( completed == true ) then
				-- We don't wanna see this pin
			elseif earnedByMe == true then
				-- Again, we don't wanna see it ( we know that the DB options flag must be true too )
			else
				-- We must now check if it's an indexed achievement pin
				if not v.index then
					-- We definitely need to see this pin
					return true
				end
				_, _, completed = GetAchievementCriteriaInfo( v.id, v.index )
				if completed == false then return true end
			end
		end
		-- To here if we don't want to see the pin but, we may be showing > 1 achievements on the pin
	end
	return false
end

local function ShowSeasonal( pin )
	if not pin.quests then return false end

	local completed;
	for _,v in ipairs( pin.quests ) do
		if PassFactionCheck( v ) and PassVersionCheck( v ) and ( v.qType == "Seasonal" ) then
			if ns.db.removeSeasonal == false then return true end
			completed = IsQuestFlaggedCompleted( v.id )
			if completed == false then return true end
		end
	end
	return false
end

local function ShowDailies( pin )
	if not pin.quests then return false end

	local completed;
	for _,v in ipairs( pin.quests ) do
		if PassFactionCheck( v ) and PassVersionCheck( v ) and ( v.qType == "Daily" ) then
			if ns.db.removeDailies == false then return true end
			-- Group Relaxation, Relief, Self-Care
			if ( v.id == 78679 ) or ( v.id == 78674 ) or ( v.id == 78664 ) then
				if ( IsQuestFlaggedCompleted( 78679 ) == true ) or ( IsQuestFlaggedCompleted( 78674 ) == true ) or 
						( IsQuestFlaggedCompleted( 78664 ) == true ) then
				else
					return true
				end
			elseif ( v.id == 78991 ) or ( v.id == 78990 ) or ( v.id == 78989 ) then
				if ( IsQuestFlaggedCompleted( 78991 ) == true ) or ( IsQuestFlaggedCompleted( 78990 ) == true ) or 
						( IsQuestFlaggedCompleted( 78989 ) == true ) then
				else
					return true
				end
			-- Group Feralas, Grizzly Hills and Nagrand
			elseif ( v.id == 78988 ) or ( v.id == 78986 ) or ( v.id == 78987 ) then
				if ( IsQuestFlaggedCompleted( 78988 ) == true ) or ( IsQuestFlaggedCompleted( 78986 ) == true ) or 
						( IsQuestFlaggedCompleted( 78987 ) == true ) then
				else
					return true
				end
			elseif ( v.id == 78594 ) or ( v.id == 78565 ) or ( v.id == 78591 ) then
				if ( IsQuestFlaggedCompleted( 78594 ) == true ) or ( IsQuestFlaggedCompleted( 78565 ) == true ) or 
						( IsQuestFlaggedCompleted( 78591 ) == true ) then
				else
					return true
				end
			else
				completed = IsQuestFlaggedCompleted( v.id )
				if completed == false then return true end
			end
		end
	end
	return false
end

local function ShowOneTime( pin )
	if not pin.quests then return false end

	local completed;
	for _,v in ipairs( pin.quests ) do
		if PassFactionCheck( v ) and PassVersionCheck( v ) and ( v.qType == "One Time" ) then
			if ns.db.removeOneTime == false then return true end
			completed = IsQuestFlaggedCompleted( v.id )
			if completed == false then return true end
		end
	end
	return false
end

do
	local function iterator( t, prev )
		if not t then return end
		local coord, pin = next( t, prev )
		while coord do
			if pin and PassFactionCheck( pin ) and PassVersionCheck( pin ) then			
				if pin.showAnyway or ShowAchievements( pin ) or ShowSeasonal( pin ) or ShowDailies( pin ) or ShowOneTime( pin ) then
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
			end
			coord, pin = next( t, coord )
		end
	end
	function pluginHandler:GetNodes2( mapID )
		ns.mapID = mapID
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
	name = ns.L["Love is in the Air"],
	desc = AddColouredText( "AddOn Description" ),
	get = function(info) return ns.db[info[#info]] end,
	set = function(info, v)
		ns.db[info[#info]] = v
		pluginHandler:Refresh()
	end,
	args = {
		options = {
			type = "group",
			-- Add a " " to force this to be before the first group. HN arranges alphabetically on local language
			name = " " ..ns.L["Options"],
			inline = true,
			args = {
				iconScale = {
					type = "range",
					name = ns.L["Map Pin Size"],
					desc = ns.L["The Map Pin Size"],
					min = 1, max = 4, step = 0.1,
					arg = "iconScale",
					order = 1,
				},
				iconAlpha = {
					type = "range",
					name = ns.L["Map Pin Alpha"],
					desc = ns.L["The alpha transparency of the map pins"],
					min = 0, max = 1, step = 0.01,
					arg = "iconAlpha",
					order = 2,
				},
				showCoords = {
					name = ns.L["Show Coordinates"],
					desc = ns.L["Show Coordinates Description"] 
							..ns.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 3,
				},
				removeDailies = {
					name = SubstitutePlayerOrElseAcct( "RWCQuestDailies", true ),
					desc = SubstitutePlayerOrElseAcct( "RWCQuestDailiesDesc", true ),
					type = "toggle",
					width = "full",
					arg = "removeDailies",
					order = 4,
				},
				removeSeasonal = {
					name = SubstitutePlayerOrElseAcct( "RWCQuestSeasonal", true ),
					desc = SubstitutePlayerOrElseAcct( "RWCQuestSeasonalDesc", true ),
					type = "toggle",
					width = "full",
					arg = "removeSeasonal",
					order = 5,
				},
				removeAchieveChar = {
					name = SubstitutePlayerOrElseAcct( "RWCAchievements", true ),
					desc = SubstitutePlayerOrElseAcct( "RWCAchievementsDesc", true ),
					type = "toggle",
					width = "full",
					arg = "removeAchieveChar",
					order = 6,
				},
				removeAchieveAcct = {
					name = SubstitutePlayerOrElseAcct( "RWCAchievements" ),
					desc = SubstitutePlayerOrElseAcct( "RWCAchievementsDescAcct" ),
					type = "toggle",
					width = "full",
					arg = "removeAchieveAcct",
					order = 7,
				},
			},
		},
		icon = {
			type = "group",
			name = ns.L["Map Pin Selections"],
			inline = true,
			args = {
				iconFoolForLove = {
					type = "range",
					name = select( 2, GetAchievementInfo( 1693 ) ), -- Fool For Love
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconFoolForLove",
					order = 10,
				},
				iconLoveRays = {
					type = "range",
					name = select( 2, GetAchievementInfo( 9394 ) ) .."++", -- 50 Love Rays plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconLoveRays",
					order = 11,
				},
				iconFistful = {
					type = "range",
					name = select( 2, GetAchievementInfo( 1699 ) ) .."++", -- Fistful of Love plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconFistful",
					order = 12,
				},
				iconVendorAchieves = {
					type = "range",
					name = select( 2, GetAchievementInfo( 1702 ) ) .."++", -- Sweet Tooth plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconVendorAchieves",
					order = 13,
				},
				iconDungeon = {
					type = "range",
					name = select( 2, GetAchievementInfo( 4624 ) ) .."++", -- Tough Love plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconDungeon",
					order = 14,
				},
				iconDangerous = {
					type = "range",
					name = select( 2, GetAchievementInfo( 1695 ) ) .."++", -- Dangerous Love plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconDangerous",
					order = 15,
				},
				iconHistory = {
					type = "range",
					name = ns.L[ "History" ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconHistory",
					order = 16,
				},
				iconCrushing = {
					type = "range",
					name = ns.L[ "Crushing the Crown" ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconCrushing",
					order = 17,
				},
				iconLoveLanguage = {
					type = "range",
					name = select( 2, GetAchievementInfo( 19508 ) ) .."++", -- Love Language Expert plus others
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconLoveLanguage",
					order = 18,
				},
				iconScenicGetaway = {
					type = "range",
					name = ns.L[ "Getaway to Scenic..." ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconScenicGetaway",
					order = 19,
				},
				iconSelfCare = {
					type = "range",
					name = ns.L[ "The Gift of..." ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconSelfCare",
					order = 20,
				},
				iconSupport = {
					type = "range",
					name = select( 2, GetAchievementInfo( 19400 ) ), -- Support Your Local Artisans
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconSupport",
					order = 21,
				},
				iconIntroduction = {
					type = "range",
					name = ns.L[ "Take a Look Around" ],
					desc = ns.iconStandard, 
					min = 1, max = 19, step = 1,
					arg = "iconIntroduction",
					order = 22,
				},
			},
		},
		notes = {
			type = "group",
			name = ns.L[ "Notes" ],
			inline = true,
			args = {
				noteMenu = { type = "description", name = ns.L[ "MinimapMenu" ], order = 20, },
				separator1 = { type = "header", name = "", order = 21, },
				noteChat = { type = "description", name = ns.L[ "ChatCommands" ]
					..NORMAL_FONT_COLOR_CODE .."/loveair" ..HIGHLIGHT_FONT_COLOR_CODE ..", "
					..NORMAL_FONT_COLOR_CODE .."/liita" ..HIGHLIGHT_FONT_COLOR_CODE ..ns.L[ "ShowPanel" ],
					order = 22, },
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
	GameTooltip:AddLine( ns.colour.prefix ..ns.L[ "Love Is In The Air" ] )
	GameTooltip:AddLine( ns.colour.highlight .." " )
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
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			if ns.points[map.mapID] then
				-- Maps here will not propagate upwards
				if ( map.mapID == 7 ) or -- Mulgore
					( map.mapID == 84 ) or -- Stormwind
					( map.mapID == 85 ) or -- Orgrimmar
					( map.mapID == 87 ) or -- Ironforge
					( map.mapID == 90 ) or -- Undercity
					( map.mapID == 103 ) or -- The Exodar
					( map.mapID == 110 ) or -- Silvermoon City
					( map.mapID == 127 ) or -- Crystalsong Forest
					( map.mapID == 224 ) or -- Stranglethorn Vale
					( map.mapID == 582 ) or -- Lunarfall Alliance Garrison
					( map.mapID == 590 ) then -- Frostwall Horde Garrison
				else
					for coord, v in next, ns.points[map.mapID] do
						if v.noContinent == nil then
							local mx, my = HandyNotes:getXY(coord)
							local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
							if cx and cy then
								ns.points[continentMapID] = ns.points[continentMapID] or {}
								ns.points[continentMapID][HandyNotes:getCoord(cx, cy)] = v
							end
						end
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB( "LoveIsInTheAir", pluginHandler, ns.options )
	ns.db = LibStub( "AceDB-3.0" ):New( "HandyNotes_LoveIsInTheAirDB", defaults, "Default" ).profile
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

--	if type( options ) == "number" then
	--	OpenWorldMap( options )
	--	if true then return end
--	end

--[[local i = 1
 while GetQuestLogTitle(i) do
  local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(i)
  if ( not isHeader ) then
   print(title ..": " ..questID)
  end
  i = i + 1
 end]]

	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "LoveIsInTheAir" )
	if ( ns.version >= 100000 ) then
		print( ns.colour.prefix ..ns.L["Winter Veil"] ..": " ..ns.colour.highlight
			.."Try the Minimap AddOn Menu (below the Calendar)" )
	end
end

SlashCmdList[ "LoveIsInTheAir" ] = function( options ) Slash( options ) end