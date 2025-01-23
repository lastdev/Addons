--[[
                                ----o----(||)----oo----(||)----o----

                                             Winter Veil

                                      v4.13 - 7th January 2025
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

-- Xmas theme
ns.colour = {}
ns.colour.prefix	= "\124cFF7FFF00" -- Chartreuse
ns.colour.highlight = "\124cFFFF2400" -- Scarlet Red
ns.colour.achieveH	= "\124cFFFFEF00" -- Canary Yellow
ns.colour.achieveI	= "\124cFFF6BE00" -- Deep Yellow
ns.colour.achieveD	= "\124cFFFBE7A1" -- Golden Blonde
ns.colour.seasonal	= "\124cFF5EFB6E" -- Jade Green
ns.colour.daily		= "\124cFF00BFFF" -- Deep Sky Blue
ns.colour.Guide		= "\124cFF12AD2B" -- Parrot Green
ns.colour.plaintext = "\124cFF66CDAA" -- Medium Aquamarine
ns.colour.completeR	= "\124cFFFF0000" -- Red
ns.colour.completeG	= "\124cFF00FF00" -- Green

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								removeDailies = true, removeSeasonal = true, removeAchieveChar = true,
								removeAchieveAcct = false,
								icon_LittleHelper = 16, icon_frostyShake = 13, icon_caroling = 17,
								icon_vendor = 15, icon_ogrila = 12, icon_letItSnow = 9, 
								icon_onMetzen = 20, icon_holidayBromance = 8, icon_tisSeason = 10,
								icon_dailies = 11, icon_gourmet = 19, icon_bbKing = 7,
								icon_ironArmada = 14, icon_special = 18, } }
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetMapChildrenInfo = C_Map.GetMapChildrenInfo
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
--local GetMapInfo = C_Map.GetMapInfo -- phase checking during testing
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local gsub = string.gsub
local next = _G.next

local HandyNotes = _G.HandyNotes

ns.version = select( 4, GetBuildInfo() )

ns.continents = ( ns.version < 50000 ) and
{
	[ 1414 ] = true, -- Kalimdor
	[ 1415 ] = true, -- Eastern Kingdoms
	[ 1945 ] = ( ns.version >= 20000) and true or nil, -- Outland
	[ 113 ]  = ( ns.version >= 30000) and true or nil, -- Northrend
	[ 203 ] = ( ns.version >= 40000) and true or nil, -- Vashj'ir
	[ 947 ]  = true, -- World
}
or
{
	[ 12 ]   = true, -- Kalimdor
	[ 13 ]   = true, -- Eastern Kingdoms
	[ 101 ]  = true, -- Outland
	[ 113 ]  = true, -- Northrend
	[ 203 ]  = true, -- Vashj'ir
	[ 572 ]  = true, -- Draenor
	[ 946 ]  = true, -- Azeroth
}

-- ---------------------------------------------------------------------------------------------------------------------------------

ns.name = UnitName( "player" ) or "Character"
ns.faction = UnitFactionGroup( "player" )

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

local function CompletionShow( completed, whatever, colour, name )
	GameTooltip:AddDoubleLine( ( whatever and ( colour ..whatever) or " " ), 
		( ( completed == true ) and ( ns.colour.completeG ..ns.L["Completed"] ) or ( ns.colour.completeR ..ns.L["Not Completed"] ) )
		..( ( name == nil ) and "" or ( " (" ..( ( name == true ) and ns.name or ns.L["Account"] ) ..")" ) ) )
end

local function GuideTip( pin )
	if pin.guide then
		GameTooltip:AddLine( ns.colour.highlight .."\n" ..ns.L[ "Guide" ] .."\n" ..ns.colour.Guide ..pin.guide,
				nil, nil, nil, true )
	end
	if pin.tip then
		GameTooltip:AddLine( ns.colour.plaintext .."\n" ..pin.tip, nil, nil, nil, true )
	end
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
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]

	local firstTime, aName, completed, description, earnedByMe, completedMe, cType, assetID;
	
	if pin.name then
		GameTooltip:SetText( ns.colour.prefix ..ns.L[ pin.name ] )
	else
		GameTooltip:SetText( ns.colour.prefix ..( ns.L[ "Winter Veil" ] ) )
	end
	
	if pin.achievements and ( ns.version > 30002 ) then
		firstTime = true
		for _,v in ipairs( pin.achievements ) do
			if PassFactionCheck( v ) and PassVersionCheck( v ) then
				_, aName, _, completed, _, _, _, description, _, _, _, _, earnedByMe = GetAchievementInfo( v.id )
				SpacerFirstTimeHeader( firstTime, ns.L[ "Achievement" ], ns.colour.highlight )
				CompletionShow( completed, aName, ns.colour.achieveH, false )
				-- Strictly speaking the results are NOT correct from the API for the Merrymaker meta for earnedByMe
				CompletionShow( earnedByMe , nil, nil, true )
				if v.showAllCriteria then
					GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
					numCriteria = GetAchievementNumCriteria( v.id )
					for i = 1, numCriteria do
						aName, cType, completed, _, _, _, _, assetID = GetAchievementCriteriaInfo( v.id, i )
						if ( cType ~= 8 ) then
							CompletionShow( completed, aName, ns.colour.achieveI, true )
							description = select( 8, GetAchievementInfo( assetID ) )
						else
							-- Achievement type. Merrmaker. cType will show each line as an achievement
							-- Must do it this way as "completed" for the criteria becomes account wide for meta achievements
							_, aName, _, completed, _, _, _, description, _, _, _, _, earnedByMe = GetAchievementInfo( assetID )
							CompletionShow( earnedByMe, aName, ns.colour.achieveH, true )
							completed = earnedByMe
						end
						if completed == false and description then
							GameTooltip:AddLine( ns.colour.plaintext ..description, nil, nil, nil, true )
						end
					end
				else
					GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
					if v.index then
						aName, _, completed = GetAchievementCriteriaInfo( v.id, v.index )
						CompletionShow( completed, aName, ns.colour.achieveI, true )
					end
				end
				GuideTip( v )
			end
		end
	end

	if pin.quests then
		firstTime = true
		for _,v in ipairs( pin.quests ) do
			if PassFactionCheck( v ) and PassVersionCheck( v ) and PassClassCheck( v ) and ( v.qType == "Seasonal" ) then
				if ( v.id == 7022 ) or ( v.id == 7023 ) then
					v.id = 7022
				elseif ( v.id == 6961 ) or ( v.id == 7021 ) or ( v.id == 7024 ) then
					v.id = 6961
				end
				completed = IsQuestFlaggedCompleted( v.id )
				firstTime = SpacerFirstTimeHeader( firstTime, ns.L[ "Seasonal" ], ns.colour.highlight )
				CompletionShow( completed, GetQuestName( v ), ns.colour.seasonal, true )
				GuideTip( v )
			end
		end
		
		firstTime = true
		for _,v in ipairs( pin.quests ) do
			if PassFactionCheck( v ) and PassVersionCheck( v ) and PassClassCheck( v ) and ( v.qType == "Daily" ) then
				completed = IsQuestFlaggedCompleted( v.id )
				firstTime = SpacerFirstTimeHeader( firstTime, ns.L[ "Daily" ], ns.colour.highlight )
				CompletionShow( completed, GetQuestName( v ), ns.colour.daily, true )
				GuideTip( v )
			end
		end
		
		firstTime = true
		for _,v in ipairs( pin.quests ) do
			if PassFactionCheck( v ) and PassVersionCheck( v ) and PassClassCheck( v ) and ( v.qType == "One Time" ) then
				completed = IsQuestFlaggedCompleted( v.id )
				firstTime = SpacerFirstTimeHeader( firstTime, ns.L[ "One Time" ], ns.colour.highlight )
				CompletionShow( completed, GetQuestName( v ), ns.colour.seasonal, true )
				GuideTip( v )
			end
		end
	end
	
	if pin.tip then
		GuideTip( pin )
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
			if ( v.id == 7022 ) or ( v.id == 7023 ) then
				v.id = 7022
			elseif ( v.id == 6961 ) or ( v.id == 7021 ) or ( v.id == 7024 ) then
				v.id = 6961
			end
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
			completed = IsQuestFlaggedCompleted( v.id )
			if completed == false then return true end
		end
	end
	return false
end

local function ShowOneTime( pin )
	if not pin.quests then return false end

	local completed;
	for _,v in ipairs( pin.quests ) do
		if PassFactionCheck( v ) and PassVersionCheck( v ) and ( v.qType == "One Time" ) then
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
				if pin.miscQuests then
					if pin.showAnyway or ShowSeasonal( pin ) or ShowDailies( pin ) or ShowOneTime( pin ) then
						return coord, nil, ns.textures[ ns.db.icon_ironArmada ],
							ns.db.iconScale * ns.scaling[ ns.db.icon_ironArmada ], ns.db.iconAlpha
					end
				elseif pin.vendor then
					return coord, nil, ns.textures[ ns.db.icon_vendor ],
						ns.db.iconScale * ns.scaling[ ns.db.icon_vendor ], ns.db.iconAlpha
				elseif pin.special then
					return coord, nil, ns.textures[ ns.db.icon_special ],
						ns.db.iconScale * 2 * ns.scaling[ ns.db.icon_special ], ns.db.iconAlpha
				else
					if pin.showAnyway or ShowAchievements( pin ) or ShowSeasonal( pin )
							or ShowDailies( pin ) or ShowOneTime( pin ) then
						if pin.wondervolt then
							return coord, nil, ns.textures[ ns.db.icon_LittleHelper ],
								ns.db.iconScale * ns.scaling[ ns.db.icon_LittleHelper ], ns.db.iconAlpha
						end
						if pin.bbKing then
							return coord, nil, ns.textures[ns.db.icon_bbKing],
								ns.db.iconScale * ns.scaling[ns.db.icon_bbKing], ns.db.iconAlpha
						end
						if pin.caroling then
							return coord, nil, ns.textures[ns.db.icon_caroling],
								ns.db.iconScale * ns.scaling[ns.db.icon_caroling], ns.db.iconAlpha
						end
						if pin.bromance then
							return coord, nil, ns.textures[ns.db.icon_holidayBromance],
								ns.db.iconScale * ns.scaling[ns.db.icon_holidayBromance], ns.db.iconAlpha
						end
						if pin.falala then
							return coord, nil, ns.textures[ns.db.icon_ogrila],
								ns.db.iconScale * ns.scaling[ns.db.icon_ogrila], ns.db.iconAlpha
						end
						if pin.frostyShake then
							return coord, nil, ns.textures[ns.db.icon_frostyShake],
								ns.db.iconScale * ns.scaling[ns.db.icon_frostyShake], ns.db.iconAlpha
						end
						if pin.armada then
							return coord, nil, ns.textures[ns.db.icon_ironArmada],
								ns.db.iconScale * ns.scaling[ns.db.icon_ironArmada], ns.db.iconAlpha
						end
						if pin.onMetzen then
							return coord, nil, ns.textures[ns.db.icon_onMetzen],
								ns.db.iconScale * ns.scaling[ns.db.icon_onMetzen], ns.db.iconAlpha
						end
						if pin.letItSnow then
							return coord, nil, ns.textures[ns.db.icon_letItSnow],
								ns.db.iconScale * ns.scaling[ns.db.icon_letItSnow], ns.db.iconAlpha
						end
						if pin.gourmet then
							return coord, nil, ns.textures[ns.db.icon_gourmet],
								ns.db.iconScale * ns.scaling[ns.db.icon_gourmet], ns.db.iconAlpha
						end
						if pin.tisSeason then
							return coord, nil, ns.textures[ns.db.icon_tisSeason],
								ns.db.iconScale * ns.scaling[ns.db.icon_tisSeason], ns.db.iconAlpha
						end
	--				print( "M="..ns.mapID.." C="..coord.." unexpected pin category" )
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
				.."\n5 = " ..ns.L["Green"] .."\n6 = " ..ns.L["Grey"] .."\n7 = " .. ns.L["Blue Ribbon Box"] .."\n8 = " ..ns.L["Green Ribbon Box"]
				.."\n9 = " ..ns.L["Pink Ribbon Box"] .."\n10 = " ..ns.L["Purple Ribbon Box"] .."\n11 = " ..ns.L["Red Ribbon Box"]
				.."\n12 = " ..ns.L["Teal Ribbon Box"] .."\n13 = " ..ns.L["Blue Santa Hat"] .."\n14 = " ..ns.L["Green Santa Hat"]
				.."\n15 = " ..ns.L["Pink Santa Hat"] .."\n16 = " ..ns.L["Red Santa Hat"] .."\n17 = " ..ns.L["Yellow Santa Hat"]
				.."\n18 = " ..ns.L["Candy Cane"] .."\n19 = " ..ns.L["Ginger Bread"] .."\n20 = " ..ns.L["Holly"]

-- Interface -> Addons -> Handy Notes -> Plugins -> Winter Veil options
ns.options = {
	type = "group",
	name = ns.L["Winter Veil"],
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
				icon_bbKing = {
					type = "range",
					name = ns.L["BB King"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_bbKing",
					order = 10,
				},
				icon_caroling = {
					type = "range",
					name = ns.L["Caroling"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_caroling",
					order = 11,
				},
--[[				icon_dailies = {
					type = "range",
					name = ns.L["Daily"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_dailies",
					order = 12,
				},]]
				icon_frostyShake = {
					type = "range",
					name = ns.L["Frosty Shake"] .."/" ..ns.L["Merrymaker"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_frostyShake",
					order = 13,
				},
				icon_gourmet = {
					type = "range",
					name = ns.L["Gourmet"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_gourmet",
					order = 14,
				},
				icon_holidayBromance = {
					type = "range",
					name = ns.L["Holiday Bromance"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_holidayBromance",
					order = 15,
				},
				icon_ironArmada = {
					type = "range",
					name = ns.L["Iron Armada"] .."/" ..ns.L["Scrooge"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_ironArmada",
					order = 16,
				},
				icon_letItSnow = {
					type = "range",
					name = ns.L["Let It Snow"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_letItSnow",
					order = 17,
				},
				icon_LittleHelper = {
					type = "range",
					name = ns.L["Little Helper"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_LittleHelper",
					order = 18,
				},
				icon_ogrila = {
					type = "range",
					name = ns.L["Ogri'la"] .."/" ..ns.L["Pepe"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_ogrila",
					order = 19,
				},
				icon_onMetzen = {
					type = "range",
					name = ns.L["On Metzen!"] .."/" ..ns.L["Simply Abominable"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_onMetzen",
					order = 20,
				},
				icon_tisSeason = {
					type = "range",
					name = ns.L["'Tis the Season"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_tisSeason",
					order = 21,
				},
				icon_vendor = {
					type = "range",
					name = ns.L["Vendors"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_vendor",
					order = 22,
				},
				icon_special = {
					type = "range",
					name = ns.L["Special"],
					desc = ns.iconStandard, 
					min = 1, max = 20, step = 1,
					arg = "icon_special",
					order = 23,
				},
			},
		},
		notes = {
			type = "group",
			name = ns.L["Notes"],
			inline = true,
			args = {
				noteMenu = { type = "description", name = "A shortcut to open this panel is via the Minimap AddOn"
					.." menu, which is immediately below the Calendar icon. Just click your mouse\n\n", order = 30, },
				separator1 = { type = "header", name = "", order = 31, },
				noteChat = { type = "description", name = "Chat command shortcuts are also supported.\n\n"
					..ns.colour.plaintext .."/wv" ..HIGHLIGHT_FONT_COLOR_CODE .." - Show this panel\n",
					order = 32, },
			},
		},
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_WinterVeil_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "WinterVeil" )
end
 
function HandyNotes_WinterVeil_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( ns.colour.prefix ..ns.L["Winter Veil"] )
	GameTooltip:AddLine( ns.colour.highlight .." " )
	GameTooltip:AddDoubleLine( ns.colour.highlight ..ns.L["Left"] .."/" ..ns.L["Right"], ns.colour.plaintext ..ns.L["Options"] )
	GameTooltip:Show()
end

function HandyNotes_WinterVeil_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
	for continentMapID in next, ns.continents do
		local children = GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
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
			elseif coords then
				for coord, pin in next, coords do
					local function AddToContinent()
						local mx, my = HandyNotes:getXY(coord)
						local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
						if cx and cy then
							ns.points[continentMapID] = ns.points[continentMapID] or {}
							ns.points[continentMapID][HandyNotes:getCoord(cx, cy)] = pin
						end
					end
					if not pin.noContinent then
						AddToContinent()
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("WinterVeil", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_WinterVeilDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	if not ns.delay then self:SendMessage("HandyNotes_NotifyUpdate", "WinterVeil") end
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_WinterVeilDB", "AceEvent-3.0")

-- ---------------------------------------------------------------------------------------------------------------------------------

ns.eventFrame = CreateFrame( "Frame" )
ns.timeSinceLastUpdate, ns.curTime = 0, 0

local function OnUpdate()
	ns.curTime = GetTime()
	if ns.curTime - ns.timeSinceLastUpdate <= 7 then return end
	ns.timeSinceLastUpdate = ns.curTime
	pluginHandler:Refresh()
end

ns.eventFrame:SetScript( "OnUpdate", OnUpdate )

local function OnEventHandler( self, event, ... )
	-- This is based upon my own research as documented in my WDW AddOn
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		ns.delay = true
	elseif ( event == "SPELLS_CHANGED" ) then
		ns.delay = nil
	end
end

ns.eventFrame:RegisterEvent( "PLAYER_ENTERING_WORLD" )
ns.eventFrame:RegisterEvent( "SPELLS_CHANGED" )
ns.eventFrame:SetScript( "OnEvent", OnEventHandler )

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_WinterVeil1, SLASH_WinterVeil2 = "/wv", "/winter"

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
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "WinterVeil" )
	if ( ns.version >= 100000 ) then
		print( ns.colour.prefix ..ns.L["Winter Veil"] ..": " ..ns.colour.highlight
			.."Try the Minimap AddOn Menu (below the Calendar)" )
	end
end

SlashCmdList[ "WinterVeil" ] = function( options ) Slash( options ) end