--[[
                                ----o----(||)----oo----(||)----o----

                                          Functions_Events

                                      v2.06 - 1st November 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

-- Summary:

-- Available functions:

	-- ns.AddOnEventTooltipLines( pin )
		-- The order of display is Title/Name lines in Functions_Common.
		-- Then AddOnSpecificTooltipLines is invoked here (as necessary).
		-- Then AddOnSpecificTooltipLines is invoked in the AddOn's Core file (as necesary).
		-- Then Guide/Tip lines are invoked in Functions_Common.
		-- Routines here include Achievement processing, as well as Quests and Pets.
		
	-- ns.PassAdditionalEventChecks( pin )
		-- This will occur after ns.PassGeneralChecks( pin ) in Functiuons_Common
		-- and prior to ns.PassAdditionalAddOnSpecificChecks( pin ) in Core
		-- Returns true or false

local _, ns = ...

-- Localisations
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementInfo = GetAchievementInfo
local GetItemNameByID = C_Item.GetItemNameByID
local GetNumCollectedInfo = C_PetJournal.GetNumCollectedInfo
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local UnitAura = C_UnitAuras.GetAuraDataByIndex

local format, gsub, ipairs, select = _G.format, string.gsub, _G.ipairs, select

-- ---------------------------------------------------------------------------------------------------------------------------------

local function CompletionShow( completed, whatever, colour, name, completionS )
	-- completionS is optional. It allows for an achievement criteria to be completed account wide (all green text) but with the
	-- character name red to indicate that that character hasn't completed it.
	if completed == nil then
		if whatever then GameTooltip:AddLine( colour ..ns.L[ whatever ] ) end
	else
		GameTooltip:AddDoubleLine( ( whatever and ( colour ..ns.L[ whatever ] ) or " " ), ( ( completed == true ) and
			( ns.colour.completeG ..ns.L[ "Completed" ] ) or ( ns.colour.completeR ..ns.L[ "Not Completed" ] ) ) .." ("
				..( ( completionS == nil ) and "" or ( ( completionS == true ) and
					ns.colour.completeG or ns.colour.completeR ) ) ..( name or ns.L[ "Account" ] )
			..( ( completed == true ) and ns.colour.completeG or ns.colour.completeR ) ..")" )
	end
end

local function GetCriteriaName( source )
	-- The item ID is preferred as the result will be localised but watch for no data being returned from the server as
	-- the item may be unknown to the player (still an issue in 2025?)
	-- For my WE series of AddOns the return will normally be nil. But I added .name for extra future utility
	return GetItemNameByID( source.item or 0 ) or source.iName or source.object or source.npc or source.name
end

local function CharOrAcctName( id )
	-- The ns.aoa[] table is a list of Account Only Achievements, i.e., achievements impossible to report "per character" in Retail
	return ( ns.aoa[ id ] == nil or ns.version < 50000 ) and ns.name or ns.L[ "Account" ]
end

local function GetQuestCompletion( qt, targetCompleted )
	-- This routine is only invoked for AddOns with an ns.achievementIQ[] table, i.e., for each achievement member there are entries
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
	-- targetCompleted is optional. See GetQuestCompletion() above. Failing to reach the target results on false for completion.
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
		iName = GetCriteriaName( v )
		if v.aQuest then
			completedQ = IsQuestFlaggedCompleted( v.aQuest )
		end
		if v.index then
			local aName, cType, completedC, _, _, _, _, assetID = GetAchievementCriteriaInfo( v.id, v.index )
			if completedQ == nil then
				if cType == 27 then
					completedQ = IsQuestFlaggedCompleted( assetID )
				elseif cType == 8 then
					local charName = select( 14, GetAchievementInfo( assetID ) )
					completedQ = CharacterCompleted( charName )
					-- Not a quest but we can glean per character completion data due to this hack
				end
			end
			iName = iName or aName
		end
	end

	if not completionOnly then -- The only time this is coded is for "true"
		if completedQ ~= nil then
			iName = ns.StringSubstitutions( iName )
			if v.qType and v.qType ~= "One Time" then
				CompletionShow( completedQ, ( iName .." (" ..ns.L[ v.qType ] ..")" ), ns.colour.achieveI, ns.name )
			else
				CompletionShow( completedQ, iName, ns.colour.achieveI, ns.name )
			end
		elseif completedC ~= nil or v.forceShowLine then
			-- Due to shared achievements and warbanding the character completion is most likely account completion in Retail
			CompletionShow( completedC, ns.StringSubstitutions( iName ), ns.colour.achieveI, CharOrAcctName( v.id ) )
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

local function IterateAndShowPetStatus( pin )
	if pin.pets then
		ns.firstOne = true
		local numColl, limitColl;
		for _, p in ipairs( pin.pets ) do
			if ns.PassGeneralChecks( p ) then
				if ns.firstOne == true then GameTooltip:AddLine( "\n" ) end
				numColl, limitColl = GetNumCollectedInfo( p.speciesID )
				GameTooltip:AddDoubleLine( ns.colour.achieveH ..ns.L[ p.name ],
					( ( numColl == nil or numColl == nil ) and "" or
						ns.colour.achieveI .."Collected: " ..ns.colour.achieveD ..numColl .."/" ..limitColl ) )			
				ns.GuideTip( p )
				ns.firstOne = false
			end
			if ns.firstOne == false then ns.spaceLine = "\n" end
		end
		ns.GuideTip( pin.pets )
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
	if completed == false then ns.GuideTip( quest ) end
end

local function IterateAndShowQuestStatus( pin, backupText )
	if pin.quests and ns.PassGeneralChecks( pin.quests ) then
		for i, v in ipairs( ns.questTypes ) do
			ns.firstOne = true
			for _, q in ipairs( pin.quests ) do
				if ns.PassGeneralChecks( q ) and ( q.qType == v ) then
					ShowQuestStatus( q, ns.questColours[ i ], backupText )
				end
			end
			if ns.firstOne == false then ns.spaceLine = "\n" end
		end
		ns.GuideTip( pin.quests )
	end
end

local function CharacterCompleted( character )

	-- 11.2.5 7/10/25 (important to note as the goalposts get regularly moved in the last 12 months)...
	-- Parm #14, charName, in GetAchievementInfo( assetID ) will return "" OR the player's name IF the player has really completed
	-- that achievement. Testing 22/4/25 noted that Cata Classic returns nil rather than "".	
	-- Thus, this routine simply returns true or false for a character actually completing an achievement. 	
	-- This routine is obviously a hack as it bypasses other parameters meant to report on character completion. Essentially we're
	-- working around Warbanding and achievements shared across an account.

	if not character or character == "" then
		return false
	elseif character == ns.name then
		return true
	else
		return false -- Safety first catch all
	end
end

function ns.AddOnEventTooltipLines( pin )

	local overallCompleted, numCompleted, aName, completedA, description, charName, completedQ, iStart, iEnd, cType, completedC,
		assetID, qtyStr, criteriaID, eligible;
	ns.firstOne  = true

	if pin.achievements and ( ns.version > 30002 ) and ns.PassGeneralChecks( pin.achievements ) then
		for _, v in ipairs( pin.achievements ) do
			if ns.PassGeneralChecks( v ) then
				overallCompleted, numCompleted = true, 0
				_, aName, _, completedA, _, _, _, description, _, _, _, _, _, charName = GetAchievementInfo( v.id )
				if not pin.meta or ns.firstOne == true then
					-- Meta pins will have just the one header. Others will have a header for each achievement
					GameTooltip:AddLine( "\n" )
					GameTooltip:AddLine( ns.colour.highlight ..ns.L[ "Achievement" ] )
					ns.firstOne = false
				end
				
				CompletionShow( completedA, aName, ns.colour.achieveH )
				if ns.aoa[ v.id ] == nil or ns.version < 100000 then
					completedC = CharacterCompleted( charName )
					CompletionShow( completedC, nil, ns.colour.achieveH, ns.name )
				end
				if not pin.meta then
					-- For Summary Tooltips that have way too many achievements - can't fit the descriptions in too. Eg. EAP AddOn
					GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
				end
				
				-- From now on we are dealing with multiple criteria of the achievement. Normally, the data is available via a
				-- GetAchievementCriteriaInfo call. Due to Warbanding / account wide achievements this is now unreliable.
				-- Also achievements throughout Patch 5.x.x are often not suported via GetAchievementCriteriaInfo.
				
				if v.showAllCriteria or ( v.criteriaSummary and ( ns.aoa[ v.id ] == nil or ns.version < 100000 ) ) or v.index then			
					-- A breakdown is required for the criteria for the achievement, a line for each criteria
					if ns.achievementIQ[ v.id ] then
						-- The achievement cannot be indexed by GetAchievementNumCriteria (i.e. using Blizzard's own API system)
						-- But, I noticed a work around. Criteria such as quest ID's, item names etc are in ns.achievementIQ. This
						-- is prevalent throughout Mists of Pandaria achievements where thankfully hacks are possible.
						for i, c in ipairs( ns.achievementIQ[ v.id ] ) do
							-- Example possibility is the secret "Flag..." quest IDs that Blizzard used during MoP
							if v.showAllCriteria then
								-- A breakdown of each element is requested. Imitating a GetAchievementNumCriteria[i] call
								CompletionFormatAndShow( { id=v.id, index=i }, 1 )
							elseif CompletionFormatAndShow( { id=v.id, index=i }, 1, true ) == false then
								-- We are cycling through to see if the achievement has been completed. This is for when per
								-- character is unavailable (warbanding / account wide ) but nevertheless can be deduced.
								overallCompleted = false
								break
							end
						end
						if v.criteriaSummary then
							CompletionShow( overallCompleted, GetCriteriaName( v ), ns.colour.achieveI, ns.name )
						end
					else
						iStart, iEnd = v.iStart or v.index or 1, v.iEnd or v.index or GetAchievementNumCriteria( v.id )
						for i = iStart, iEnd do -- v.iStart, v.iEnd is for splitting massive criteria lists between pins
							aName, cType, completedC, _, _, charName, _, assetID, qtyStr = GetAchievementCriteriaInfo( v.id, i )
							if v.criteriaSummary then
								if completedC == false then
									overallCompleted = false
									break
								end							
							elseif cType == 8 then
								-- Occurs for Meta achievements where each criteria is itself an achievement
								_, _, _, completedA, _, _, _, description, _, _, _, _, _, charName = GetAchievementInfo( assetID )
								if ns.aoa[ assetID ] == nil or ns.version < 100000 then
									completedC = CharacterCompleted( charName )
									CompletionShow( completedA, aName, ns.colour.achieveI, ns.name, completedC )
									if completedC == false and description then
										GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
									end
								else
									CompletionShow( completedA, aName, ns.colour.achieveI )
									if completedA == false and description then
										GameTooltip:AddLine( ns.colour.achieveD ..description, nil, nil, nil, true )
									end
								end
							else
								if ( cType == 27 ) then
									-- The third completion parm gives account completion status.
									completedQ = IsQuestFlaggedCompleted( assetID )
									CompletionShow( completedC, aName, ns.colour.achieveI, ns.name, completedQ )
--								elseif ns.cba[ v.id ] and ns.PassGeneralChecks( ns.cba[ v.id ] ) then
								elseif ns.version < 100000 then
									CompletionShow( completedC, aName, ns.colour.achieveI, ns.name )								
								elseif ns.aoa[ v.id ] == nil then
									-- Every achievement here needs investigation. Following is code that usually works
									CompletionFormatAndShow( { id=v.id, index=i, forceShowLine=v.forceShowLine } )
								else
									-- Had to give up. Couldn't find any hacks
									CompletionShow( completedA, aName, ns.colour.achieveH )
								end
							end
						end
						if v.criteriaSummary then
							CompletionShow( overallCompleted, nil, ns.colour.achieveI, CharOrAcctName( v.id ) )
						end
					end
				elseif ns.aoa[ v.id ] == nil or ns.version < 100000 or not v.criteriaSummary then
					-- All the single criteria pins arrive here, both simple and Mists of Pandaria complex, in order to standardise
					-- formatting. The Account and character summary has already been shown. Maybe nothing else to show
					CompletionFormatAndShow( v )
				end
				ns.GuideTip( v )
			end
		end
		
	end

	IterateAndShowPetStatus( pin )
	IterateAndShowQuestStatus( pin, "Associated Quest" )
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function ShowAchievements( pin )
	if not pin.achievements then return false end
	if ns.version < 30002 then return false end -- Achievements began with WotLK patch 3.0.2
	if ns.PassGeneralChecks( pin.achievements ) == false then return false end

	local completed, charName;
	local acctCompleted, charCompleted, possibleShow = true, true, false
	
	for _,v in ipairs( pin.achievements ) do			
		if ns.PassGeneralChecks( v ) then
			possibleShow = true
			_, aName, _, completed, _, _, _, _, _, _, _, _, _, charName = GetAchievementInfo( v.id )
			-- Must still do this test for a definitive account based result (at least since Cata and up. WotLK I'm not sure)
			if completed == false then acctCompleted = false end
			if v.index and ( ns.version < 100000 ) then
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
			elseif ns.aoa[ v.id ] and ( ns.version >= 100000 ) then
				-- Err on the side of caution. This is a table of achievements for which we'll never have character completion data.
				-- Assume not completed for character so that any pin supression is driven by the account wide status.
				charCompleted = false
			elseif v.index then
				-- This might give per character results, depending upon the API implementation in Retail for that achievement
				aName, _, completed, _, _, _, _, _ = GetAchievementCriteriaInfo( v.id, v.index )					
				if completed == false then charCompleted = false end
				-- The key understanding here is that we can only know for sure if NOT completed for a character
			else
				completed = CharacterCompleted( charName )
				if completed == false then charCompleted = false end			
			end
		end
	end
	
	-- We tested all of the pin's achievements. We know for sure if some part of it was not completed by account / character.
	-- In terms of whole completion, we can't always be certain if it is wholly completed by character due to the account wide
	-- credit system as well as the more recent Warbands. We've done our best.
	-- The reason per character is so important is that I'm trying to help the player to not show/check a pin unnecessarily
	-- and indeed an NPC/object might never show if it has been completed by a character for real. Plus to assist alt farming of
	-- Candy Buckets, Elders, etc

	if ( _G[ ns.db ][ "Achievements Acct" ] == true ) and ( acctCompleted == true ) then
		return false
	end
	if ( _G[ ns.db ][ "Achievements Char" ] == true ) and ( charCompleted == true ) then
		return false
	end

	-- The pin wasn't rejected on the basis of acct/char display.
	-- But PassAllChecks may have failed from within the pin's achievement table
	return ( ( possibleShow == true ) and true or false )
end

local function ShowQuests( pin )
	if not pin.quests then return false end
	if ns.PassGeneralChecks( pin.quests ) == true then
		for i, v in ipairs( ns.questTypes ) do
			for _, q in ipairs( pin.quests ) do
				if ns.PassGeneralChecks( q ) and ( q.qType == v ) and
						( ( ns.PassAdditionalQuestChecks == nil ) or ( ns.PassAdditionalQuestChecks( q ) == true ) ) then
						-- This will be in Core of a specific AddOn, as necessary
					if _G[ ns.db ][ ns.questTypesDB[ i ] ] == false then return true end
					if IsQuestFlaggedCompleted( q.id ) == false then return true end
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

function ns.PassAdditionalEventChecks( pin )
	if pin.alwaysShow ~= nil then return true end
	if ShowAchievements( pin ) or ShowQuests( pin ) or ShowAnyway( pin) then return true end
	return false
end

