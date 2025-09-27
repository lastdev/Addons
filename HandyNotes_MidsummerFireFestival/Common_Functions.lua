local _, ns = ...

-- Localisations
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetItemNameByID = C_Item.GetItemNameByID
local GetMapChildrenInfo = C_Map.GetMapChildrenInfo
local GetNumCollectedInfo = C_PetJournal.GetNumCollectedInfo
local GetTime = GetTime
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local UnitAura = C_UnitAuras.GetAuraDataByIndex

local format, gsub, ipairs, select = _G.format, string.gsub, _G.ipairs, select

local LibStub = _G.LibStub
local HandyNotes = _G.HandyNotes

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.PassAllChecks( pin )
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

function ns.PassAzerothCheck( pin )
	if ns.mapID ~= 947 or ( ns.db.showAzeroth == true and pin.noAzeroth == nil ) then return true end
	return false
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function CompletionShow( completed, whatever, colour, name, completionS ) -- Last two parms are optional
	GameTooltip:AddDoubleLine( ( whatever and ( colour ..ns.L[ whatever ] ) or " " ), 
		( ( completed == true ) and ( ns.colour.completeG ..ns.L[ "Completed" ] ) or ( ns.colour.completeR
		..ns.L[ "Not Completed" ] ) ) .." (" ..( ( ( completionS == nil ) or ( ns.version >= 100000 ) ) and "" or
		( ( completionS == true ) and ns.colour.completeG or ns.colour.completeR ) ) ..( name or ns.L[ "Account" ] )
		..( ( completed == true ) and ns.colour.completeG or ns.colour.completeR ) ..")" )
end

local function GetCriteriaName( source )
	-- The item ID is preferred as the result will be localised but watch for no data being returned from the server as
	-- the item may be unknown to the player (still an issue in 2025?)
	-- For my WE series of AddOns the return will normally be nil. But I added .name for extra future utility
	return GetItemNameByID( source.item or 0 ) or source.iName or source.object or source.npc or source.name
end

local function CharOrAcctName( id )
	-- The ns.aoa[] table is a list of Account Only Achievements, i.e., achievements impossible to report "per character" in Retail
	return ( ns.aoa[ id ] == nil or ns.version < 100000 ) and ns.name or nil
end

local function GetQuestCompletion( qt, targetCompleted )
	-- This routine is only invoked for AddOns with an ns.achievementIQ[] table, i.e., for each achievement member there is entries
	-- for each achievement criteria that is listed by quest ID, as there is no useful index available or the index is ignored
	if type( qt.aQuest ) == "table" then
		local target = ( targetCompleted == nil ) and #qt.aQuest or targetCompleted
		local numCompleted = 0
		for i, q in ipairs( qt.aQuest ) do
			completedQ = IsQuestFlaggedCompleted( q )
			if completedQ == true then
				numCompleted = numCompleted + 1
				if numCompleted >= target then
					return true
				end
			elseif ( i - numCompleted ) > ( #qt.aQuest - target ) then
				return false
			end
		end
	else
		return IsQuestFlaggedCompleted( qt.aQuest )
	end
	return true
end

local function CompletionFormatAndShow( v, targetCompleted, completionOnly )

	-- This routine aims to assemble enough completion data to add to the tooltip. Ideally there will be a quest to query.
	-- Achievement id might have a aQuest and/or an index. The aQuest might have an achievementIQ entry.
	-- The achievementIQ entry can be referenced by id/index or searching for the id/aQuest.
	-- The aQuest in the achievementIQ entry might be within an array in that achievementIQ entry.
	-- We will need to search for iName within the achievementIQ entry but the iName is never an array.
	-- targetCompleted is optional. Used for achievementIQ quest arrays. If missing assume #array.
	-- Failing to reach the target results on false for quest completion
	-- completionOnly is optional. It will result in only the completion status being returned and nothing displayed
	
	local iName, completedQ, target, completedC;
	
	if ns.achievementIQ[ v.id ] then
		if v.index then
			iName = GetCriteriaName( ns.achievementIQ[ v.id ][ v.index ] )
			completedQ = GetQuestCompletion( ns.achievementIQ[ v.id ][ v.index ], targetCompleted )
		elseif not v.aQuest then
			iName = GetCriteriaName( v ) or select( 2, GetAchievementInfo( v.id ) )
			for i, _ in ipairs( ns.achievementIQ[ v.id ] ) do
				completedQ = GetQuestCompletion( ns.achievementIQ[ v.id ][ i ], targetCompleted )
				if completedQ == false then break end
			end
		else
			for _, q in ipairs( ns.achievementIQ[ v.id ] ) do
				if q.aQuest == v.aQuest then
					iName = GetCriteriaName( q )
					break
				end
			end
			completedQ = IsQuestFlaggedCompleted( v.aQuest )
		end
	else
		-- I don't necessarily record the qName in points coord field. We'll use the indexed achieve name if present.
		-- Obtaining the qName would only work if it was in the quest log anyway. The official qName is often "Flag..." etc
		iName = GetCriteriaName( v ) or ( v.index and select( 1, GetAchievementCriteriaInfo( v.id, v.index ) ) ) or ""
		if v.aQuest then
			completedQ = IsQuestFlaggedCompleted( v.aQuest )
		elseif v.index then
			completedC = select( 3, GetAchievementCriteriaInfo( v.id, v.index ) )
		end
	end

	if not completionOnly then
		if completedQ ~= nil then
			if v.qType and v.qType ~= "One Time" then
				CompletionShow( completedQ, ( iName .." (" ..ns.L[ v.qType ] ..")" ), ns.colour.achieveI, ns.name )
			else
				CompletionShow( completedQ, iName, ns.colour.achieveI, ns.name )
			end
		elseif completedC ~= nil then
			-- Due to shared achievements and warbanding the character completion is most likely account completion in Retail
			CompletionShow( completedC, iName, ns.colour.achieveI, CharOrAcctName( v.id ) )
		end
		if v.quantity then
			GameTooltip:AddLine( ns.colour.achieveI ..( select( 9, GetAchievementCriteriaInfo( v.id, 1 ) ) ) )
		end
	end
	
	return completedQ
end

local function GetCompletionStatus( v )
	return CompletionFormatAndShow( v, nil, true )
end

-- ---------------------------------------------------------------------------------------------------------------------------------

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

-- ---------------------------------------------------------------------------------------------------------------------------------

local function IterateAndShowPetStatus( pin )
	if pin.pets then
		ns.firstOne = true
		local numColl, limitColl;
		for _, p in ipairs( pin.pets ) do
			if ns.PassAllChecks( p ) then
				if ns.firstOne == true then GameTooltip:AddLine( "\n" ) end
				numColl, limitColl = GetNumCollectedInfo( p.speciesID )
				GameTooltip:AddDoubleLine( ns.colour.achieveH ..ns.L[ p.name ],
					( ( numColl == nil or numColl == nil ) and "" or
						ns.colour.achieveI .."Collected: " ..ns.colour.achieveD ..numColl .."/" ..limitColl ) )			
				GuideTip( p )
				ns.firstOne = false
			end
		end
		if ns.firstOne == false then ns.spaceLine = "\n" end
	end
end

local function ShowQuestStatus( quest, colour, backupName )
	if ns.firstOne == true then
		GameTooltip:AddLine( ns.colour.highlight .."\n" ..ns.L[ quest.qType ] )
		ns.firstOne = false
	end
	local level = quest.level and ( ns.colour.plaintext .." (" ..ns.L[ "Level" ] .." " ..quest.level ..")" ) or ""
	local questName = ( ( quest.name == nil ) or ( quest.name == "" ) ) and
							( ( backupName == nil ) and ns.L[ "Try again" ] or ( backupName ..level ) ) or ( quest.name ..level )
	local completed = IsQuestFlaggedCompleted( quest.id )
	CompletionShow( completed, questName, colour, ns.name )
	if completed == false then GuideTip( quest ) end
end

local function IterateAndShowQuestStatus( pin, backupText )
	if pin.quests and ns.PassAllChecks( pin.quests ) then
		for i, v in ipairs( ns.questTypes ) do
			ns.firstOne = true
			for _, q in ipairs( pin.quests ) do
				if ns.PassAllChecks( q ) and ( q.qType == v ) then
					ShowQuestStatus( q, ns.questColours[ i ], backupText )
				end
			end
		end
		if GuideTip( pin.quests ) == true then ns.spaceLine = "\n" end
		if ns.firstOne == false then ns.spaceLine = "\n" end
	end
end

local function CorrectMapPhase( mapID, old )

	-- Pass old=true if you want the old phase. Pass old=false if you want the current times phase
	-- Tirisfal, Arathi have Zidormi quirks. Maybe Darkshore too. Regardless, this routine always works, even if the player isn't
	-- in the phase that they thought they requested (Tirisfal).
	-- Darkshore. I think I was dealing with several phases (those quests leading up to the burning). Probably moot now
	-- Arathi gives two different spellID buffs. Can test with login/out enter/exit the zone.
	-- Tirisfal. Player sometimes needs to do Zidormi TWICE to go back to the "old times".
	-- Reminder: GetMapArtID() was useful at times during testing, especially Darkshore and Tirisfal back in the day.
	
	if ( ns.version < 60000 ) then return true end -- Safe to drop through the code but more efficient to just exit

	if ( mapID == 17 ) or ( mapID == 18 ) or ( mapID == 2070 ) or -- Blasted Lands, 2 x Tirisfal Glades
			( mapID == 14 ) or ( mapID == 57 ) or ( mapID == 62 ) or -- Arathi Highlands, Teldrassil, Darkshore
			( mapID == 70 ) or ( mapID == 81 ) or -- Theramore (Dustwallow Marsh), Silithus, (Darnassus 89 not necessary)
			( mapID == 249 ) or ( mapID == 1527 ) then -- Uldum
		for i = 1, 40 do -- 40 is rather arbitrary these days I think
			local auraData = UnitAura( "player", i, "HELPFUL" )
			if auraData == nil then break end
			if auraData.spellId then -- Look for Time Travelling buff
				if ( auraData.spellId == 372329 ) or ( auraData.spellId == 276827 ) or -- Blasted Lands, Tirisfal Glades
						( auraData.spellId == 276950 ) or ( auraData.spellId == 276954 ) or -- Arathi. Two possible values :(
						( auraData.spellId == 290246 ) or ( auraData.spellId == 123979 ) or -- Darkshore/Teldrassil/Darn, Theramore
						( auraData.spellId == 255152 ) or ( auraData.spellId == 317785 ) then -- Silithus, Uldum
					return old
				end
			end
		end
		return not old
	else
		return true
	end
end

local function AddZidormiTip( pin, mapID, old )
	if ( pin.noZidormi == nil ) and ( CorrectMapPhase( mapID, old ) == false ) then
		ns.spaceLine = "\n"
		Tip( ns.L[ "ZidormiWrongPhase" ] )
	end
end

local function ShowCoordinates( pin, coord )
	if ( ns.db.showCoords == true ) and not pin.noCoords then
		local mX, mY = HandyNotes:getXY( coord )
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( "\n" ..ns.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function CharacterCompleted( character )
	-- This routine attempts to skirt around Warbands and other in-game sharing of achievements across characters. Perhaps to track
	-- progress per character due to good XP rewards or because the player is old school. The API no longer supports per character.
	-- This routine uses whatever hacks/quirks are available at the time. It is an evolving situation. Likely API calls are:
	-- _, _, _, completedA, _, _, _, _, _, _, _, _, earnedByMe, charName = GetAchievementInfo( v.id )
	-- _, _, completedC, _,  _, charName, _, _, _, _, eligible = GetAchievementCriteriaInfo( v.id, v.index )
	-- Pass parm #14 from GetAchievementInfo(). Returns if the character has really completed the achievement. Note the test for
	-- nil as 22/4/25 testing in Cata Classic revealed that nil is returned. Retail returns "" in that situation.
	-- Late March 2025 retail 11.1.0: Eligible is always true (at least outside of LF event), completedA is account wide,
	-- completedC is always false / charName is always nil except if the character has actually (for real) completed all of the
	-- (criteria of the) achievement. Unknown-use parameters also tested. EarnedByMe is account wide.
	-- The above testing outcomes indicate that the Wow Wiki GG website's API data is incorrect / not up to date as of March 2025.
	-- Going with CharName rather than CompletedC purely on a hunch that it'll need less maintenance over time lol
	if not character or character == "" then
		return false
	elseif character == ns.name then
		return true
	else
		return false
	end
end

ns.pluginHandler = {}

function ns.pluginHandler:OnEnter( mapFile, coord )
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
	else
		GameTooltip:SetOwner( self, "ANCHOR_RIGHT" )
	end

	local pin = ns.points[ mapFile ] and ns.points[ mapFile ][ coord ]
	if pin == nil then return end
	
	local overallCompleted, numCompleted, aName, completedA, description, charName, completedQ, iStart, iEnd, cType, completedC,
		assetID, qtyStr, criteriaID, eligible;
	ns.spaceLine, ns.firstOne  = "", true

	GameTooltip:SetText( ns.colour.prefix ..( ns.L[ pin.title ] or ns.L[ ns.eventName ] ) )

	if pin.achievements and ( ns.version > 30002 ) and ns.PassAllChecks( pin.achievements ) then
		for _, v in ipairs( pin.achievements ) do
			if ns.PassAllChecks( v ) then
				overallCompleted, numCompleted = true, 0
				_, aName, _, completedA, _, _, _, description, _, _, _, _, _, charName = GetAchievementInfo( v.id )
				-- the 13th "completed by me" boolean is no longer useful for my AddOns due to warbanding / shared achievements
				if not pin.meta or ns.firstOne == true then
					-- Meta pins will have just the one header. Others will have a header for each achievement
					GameTooltip:AddLine( "\n" )
					GameTooltip:AddLine( ns.colour.highlight ..ns.L[ "Achievement" ] )
					ns.firstOne = false
				end
				
				CompletionShow( completedA, aName, ns.colour.achieveH )

				if pin.noDesc == nil then
					GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
				end
				
				if v.showAllCriteria or ( v.criteriaSummary and ( ns.aoa[ v.id ] == nil or ns.version < 100000 ) ) then
					if ns.achievementIQ[ v.id ] then						
						-- Achievements able to be indexed by quest. Might also have an index present in the data but unnecessary
						for i, c in ipairs( ns.achievementIQ[ v.id ] ) do
							if v.showAllCriteria then
								CompletionFormatAndShow( { id=v.id, index=i }, 1 )
							else
								if CompletionFormatAndShow( { id=v.id, index=i }, 1, true ) == false then
									overallCompleted = false
									break
								end
							end
						end
						if v.criteriaSummary then
							CompletionShow( overallCompleted, GetCriteriaName( v ), ns.colour.achieveI, ns.name )
						end
					else
						-- Careful. If to here for an achievement with just the one criteria then num criteria will be zero
						-- And calling GetAchievementCriteriaInfo (with any dummy index like 0, 1, etc) will abend!
						iStart, iEnd = v.iStart or 1, v.iEnd or GetAchievementNumCriteria( v.id )
						for i = iStart, iEnd do					
							aName, cType, completedC, _, _, charName, _, assetID, qtyStr, criteriaID, eligible =
									GetAchievementCriteriaInfo( v.id, i )
							if v.criteriaSummary then
								if completedC == false then
									overallCompleted = false
									break
								end
							elseif cType == 8 then
								-- Occurs for World Event Meta achievements. Each criteria is itself an achievement
								_, aName, _, _, _, _, _, description, _, _, _, _, _, charName = GetAchievementInfo( assetID )
								if not ns.aoa[ assetID ] then
									completedC = CharacterCompleted( charName ) -- Hack that mostly works
									-- When the hack doesn't work, use the ns.aoa table (perhaps)
								end
								CompletionShow( completedC, aName, ns.colour.achieveH, CharOrAcctName( assetID ) )
								if completedC == false and description then
									GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
								end
							elseif cType == 27 then
								-- AssetID is a quest ID. Again, common in World Events
								if i == 1 then GameTooltip:AddLine( ns.colour.seasonal ..ns.L[ "Seasonal" ] ) end
								completedQ = IsQuestFlaggedCompleted( assetID )
								-- Quest might be daily/weekly/seasonal so a 5th parameter is needed to assist with formatting
								CompletionShow( completedQ, aName, ns.colour.achieveI, ns.name, completedC )
							else
								CompletionFormatAndShow( { id=v.id, index=i } )
							end
						end
						if v.criteriaSummary then
							CompletionShow( overallCompleted, nil, ns.colour.achieveI, CharOrAcctName( v.id ) )
						end
					end
				elseif ns.aoa[ v.id ] == nil or not v.criteriaSummary then
					CompletionFormatAndShow( v )
				end
				GuideTip( v )
			end
		end
	elseif pin.name then
		GameTooltip:AddLine( "\n" )
		GameTooltip:AddLine( ns.colour.highlight ..ns.L[ pin.name ] )
	end

	if ns.author and pin.author then
		GameTooltip:AddLine( ns.colour.highlight ..L[ pin.author ] )
	end
	
	IterateAndShowPetStatus( pin )
	IterateAndShowQuestStatus( pin, "Associated Quest" )
	GuideTip( pin )
	AddZidormiTip( pin, mapFile, true )
	ShowCoordinates( pin , coord )

	GameTooltip:Show()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.ShowAchievements( pin )
	if not pin.achievements then return false end
	if ns.version < 30002 then return false end -- Achievements began with WotLK patch 3.0.2
	if ns.PassAllChecks( pin.achievements ) == false then return false end

	local completed, charName;
	local possibleShow = false
	
	local acctCompleted, charCompleted = true, true
	for _,v in ipairs( pin.achievements ) do			
		if ns.PassAllChecks( v ) then
			possibleShow = true
			if v.index and ns.version < 100000 then
				-- Pre Warbands / account sharing this would be a definite per character result
				completed = select( 3, GetAchievementCriteriaInfo( v.id, v.index )	)				
				if completed == false then charCompleted = false end
			elseif v.aQuest then
				-- This gives definitive "per character" results, whether an indexed achievement or not
				completed = IsQuestFlaggedCompleted( v.aQuest )
				if completed == false then charCompleted = false end
			elseif ns.achievementIQ[ v.id ] then
				-- a table of achievements that have quests for each criteria. Any indexing is therefore irrelevant
				completed = GetCompletionStatus( v )
				if completed == false then charCompleted = false end
			elseif ns.aoa[ v.id ] and ns.version >= 100000 then
				-- Err on the side of caution. This is a table of achievements for which we'll never have character completion data
				-- Assume not completed for character so that the pins are not always suppressed by the account wide status
				charCompleted = false
			elseif v.index then
				-- This might give per character results, depending upon the API implementation in Retail for that achievement
				aName, _, completed, _, _, _, _, _ = GetAchievementCriteriaInfo( v.id, v.index )					
				if completed == false then charCompleted = false end
				-- The key understanding here is that we can only know for sure if NOT completed for a character
			end
			_, _, _, completed, _, _, _, _, _, _, _, _, _, charName = GetAchievementInfo( v.id )
			-- Must still do this test for a definitive account based result (at least since Cata and up. WotLK I'm not sure)
			if completed == false then acctCompleted = false end
		end
	end
	
	-- We tested all of the pin's achievements. We know for sure if some part of it was not completed by account / character
	-- In terms of whole completion, we can't be certain if it is wholly completed by character due to the account wide credit
	-- system as well as the more recent warbands. We've done our best.
	-- The reason per character is so important is that I'm trying to help the player to not show/check a pin unnecessarily
	-- and indeed an NPC/object might never show if it has been completed by a character for real

	if ( ns.db.removeAchieveAcct == true ) and ( acctCompleted == true ) then
		return false
	end
	if ( ns.db.removeAchieveChar == true ) and ( charCompleted == true ) then
		return false
	end

	-- The pin wasn't rejected on the basis of acct/char display.
	-- But PassAllChecks may have failed from within the pin's achievement table
	return ( ( possibleShow == true ) and true or false )
end

function ns.ShowQuests( pin )
	if not pin.quests then return false end
	if ns.PassAllChecks( pin.quests ) == true then
		for i, v in ipairs( ns.questTypes ) do
			for _, q in ipairs( pin.quests ) do
				if ns.PassAllChecks( q ) and ( q.qType == v ) then
					if ns.db[ ns.questTypesDB[ i ] ] == false then return true end
					if IsQuestFlaggedCompleted( q.id ) == false then return true end
				end
			end
		end
	end
	return false
end

function ns.ShowAnyway( pin)
	if pin.achievements or pin.quests then return false end
	return true
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.ScalePin( base )
	return ns.db.iconScale * ns.scaling[ base ] * ns.pinSizeVersionFudge *
			( ( ns.continents[ ns.mapID ] == nil ) and 1 or ( ( ns.mapID == 947 ) and 0.6 or 0.75 ) )
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.AddColouredText( inputText )
	local hash = gsub( ns.L[ inputText ], "%%e", ns.colour.highlight )
	return gsub( hash, "%%s", ns.colour.prefix )
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.pluginHandler:Refresh()
	if GetTime() > ( ns.delay or 0 ) then
		ns.delay = nil
		self:SendMessage( "HandyNotes_NotifyUpdate", ns.addOnName )
	end
end

ns.eventFrame = CreateFrame( "Frame" )

local function OnUpdate()
	if GetTime() > ( ns.saveTime or 0 ) then
		ns.saveTime = GetTime() + 10
		ns.pluginHandler:Refresh()
	end
end

ns.eventFrame:SetScript( "OnUpdate", OnUpdate )

local function OnEventHandler( self, event, ... )
	if ( event == "PLAYER_ENTERING_WORLD" ) or ( event == "PLAYER_LEAVING_WORLD" ) then
		ns.delay = GetTime() + 60 -- Some arbitrary large amount
	elseif ( event == "SPELLS_CHANGED" ) then
		ns.delay = GetTime() + 10 -- Allow a 10 second safety buffer before we resume refreshes
	end
end

ns.eventFrame:RegisterEvent( "PLAYER_ENTERING_WORLD" )
ns.eventFrame:RegisterEvent( "PLAYER_LEAVING_WORLD" )
ns.eventFrame:RegisterEvent( "SPELLS_CHANGED" )
ns.eventFrame:SetScript( "OnEvent", OnEventHandler )

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.pluginHandler:OnEnable()
	local HereBeDragons = LibStub( "HereBeDragons-2.0", true )
	if not HereBeDragons then return end
	for continentMapID in next, ns.continents do
		local children = GetMapChildrenInfo( continentMapID, nil, true )
		for _, map in next, children do
			if ns.points[ map.mapID ] then
				for coord, v in next, ns.points[ map.mapID ] do
					if ( v.noContinent == nil ) and ns.PassAllChecks( v ) then
						if ns.version > 50000 and ns.version < 60000 then
							local newCoord = ns.DragonsTreadLightlyCoords( coord, map.mapID, continentMapID )
							if newCoord then
								ns.points[ continentMapID ] = ns.points[ continentMapID ] or {}
								ns.points[ continentMapID ][ newCoord ] = v
							end
						elseif ns.DragonsTreadLightly.special[ map.mapID ] then
							local newCoord = ns.DragonsTreadLightlyCoords( coord, map.mapID, continentMapID )
							if newCoord then
								ns.points[ continentMapID ] = ns.points[ continentMapID ] or {}
								ns.points[ continentMapID ][ newCoord ] = v
							end
						else
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
	end
	HandyNotes:RegisterPluginDB( ns.addOnName, ns.pluginHandler, ns.options )
	ns.db = LibStub( "AceDB-3.0" ):New( ns.addOnName .."DB", ns.defaults, "Default" ).profile
	ns.pluginHandler:Refresh()
end

function ns.pluginHandler:GetNodes2( mapID )
	ns.mapID = mapID
	return ns.handyNotesPinIterator, ns.points[ mapID ]
end

function ns.pluginHandler:OnLeave()
	GameTooltip:Hide()
end

LibStub( "AceAddon-3.0" ):NewAddon( ns.pluginHandler, ns.addOnName .."DB", "AceEvent-3.0" )

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.Slash( options )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", ns.addOnName )
	if ( ns.version >= 100000 ) then
		print( ns.colour.prefix ..ns.L[ ns.addOnName ] ..": " ..ns.colour.highlight ..ns.L[ "TryMinimapMenu" ] )
	end
end

