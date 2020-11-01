local addonName = ...
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local THIS_ACCOUNT = "Default"
local THIS_REALM = GetRealmName()

local storedLink = nil

local LGN = LibStub("LibGatheringNodes-1.0")

-- *** Utility functions ***
local function GetCraftNameFromRecipeLink(link)
	-- get the craft name from the itemlink (strsplit on | to get the 4th value, then split again on ":" )
	local recipeName = select(4, strsplit("|", link))
	local craftName

	-- try to determine if it's a transmute (has 2 colons in the string --> Alchemy: Transmute: blablabla)
	local pos = string.find(recipeName, L["Transmute"])
	if pos then	-- it's a transmute
		return string.sub(recipeName, pos, -2)
	else
		craftName = select(2, strsplit(":", recipeName))
	end
	
	if craftName == nil then		-- will be nil for enchants
		return string.sub(recipeName, 3, -2)		-- ex: "Enchant Weapon - Striking"
	end
	
	return string.sub(craftName, 2, -2)	-- at this point, get rid of the leading space and trailing square bracket
end

local function GetRequirementsFromRecipeLink(link)
    local expansionRequirement, specializationRequirement, expansionSkillRequirement
    
    local pattern = ITEM_MIN_SKILL
    -- this pattern is setup for use in string.format, need to change it to a regular expression for use in string.match
    -- in english, it is: ITEM_MIN_SKILL = "Requires %s (%d)"
    -- in Deutsch, it is: ITEM_MIN_SKILL = "Benotigi %1$s (%2$d)"
    -- remove any %1s and %2s in the string
    pattern = pattern:gsub("%%%d", "")
    -- swap any $s to %s
    pattern = pattern:gsub("$", "%")
    -- swap the (%d) to a %((%d+)%)
    pattern = pattern:gsub("%(%%d%)", "%%%(%(%%d+%)%%%)")
    -- swap the %s to a (.+)
    pattern = pattern:gsub("%%s", "(.+)")
    -- in english, it should now look like: "Requires (.+) %(%d+%)"
    -- yup, I did pattern matching on a pattern. If theres a better way to do that, let me know.
    
    local localizedGoblinEngineering = GetSpellInfo(20222)
    local localizedGnomishEngineering = GetSpellInfo(20219)
    
    local tooltip = AltoScanningTooltip
	tooltip:ClearLines()
	tooltip:SetHyperlink(link)	
	local tooltipName = tooltip:GetName()
	for i = tooltip:NumLines(), 2, -1 do			-- parse all tooltip lines, from last to second
		local tooltipText = _G[tooltipName .. "TextLeft" .. i]:GetText()
		if tooltipText then
            if not expansionRequirement then
                expansionRequirement, expansionSkillRequirement = string.match(tooltipText, pattern)
            end
            if not specializationRequirement then
                if string.find(tooltipText, string.format(ITEM_REQ_SKILL, localizedGoblinEngineering)) then
                    specializationRequirement = "Goblin"
                end
            end
            if not specializationRequirement then
                if string.find(tooltipText, string.format(ITEM_REQ_SKILL, localizedGnomishEngineering)) then
                    specializationRequirement = "Gnomish"
                end
            end
		end
	end
    
    return expansionRequirement, specializationRequirement, expansionSkillRequirement
end

local isTooltipDone, isNodeDone			-- for informant
local cachedItemID, cachedCount, cachedTotal, cachedSource
local cachedRecipeOwners

local itemCounts = {}
local itemCountsLabels = {	L["Bags"], L["Bank"], VOID_STORAGE, REAGENT_BANK, L["AH"], L["Equipped"], L["Mail"], CURRENCY }
local counterLines = {}		-- list of lines containing a counter to display in the tooltip

local function AddCounterLine(owner, counters)
	table.insert(counterLines, { ["owner"] = owner, ["info"] = counters } )
end

local function WriteCounterLines(tooltip)
	if #counterLines == 0 then return end

	if addon:GetOption("UI.Tooltip.ShowItemCount") then			-- add count per character/guild
		tooltip:AddLine(" ",1,1,1);
		for _, line in ipairs (counterLines) do
			tooltip:AddDoubleLine(line.owner,  colors.teal .. line.info);
		end
	end
end

local function WriteTotal(tooltip)
	if addon:GetOption("UI.Tooltip.ShowTotalItemCount") and cachedTotal then
		tooltip:AddLine(cachedTotal,1,1,1);
	end
end

local function GetRealmsList()
	-- returns the list of realms to check, either only this realm, or merged realms too.
	local realms = {}
	table.insert(realms, THIS_REALM)
	
	if addon:GetOption("UI.Tooltip.ShowAllRealmsCount") then
		for connectedRealm in pairs(DataStore:GetRealms()) do
        	if connectedRealm ~= THIS_REALM then
                table.insert(realms, connectedRealm)
            end
		end    
    elseif addon:GetOption("UI.Tooltip.ShowMergedRealmsCount") then
		for _, connectedRealm in pairs(DataStore:GetRealmsConnectedWith(THIS_REALM)) do
			table.insert(realms, connectedRealm)
		end
	end

	return realms
end

local function GetGuildRealmsList()
    if not addon:GetOption("UI.Tooltip.ShowMergedRealmsCount") then
        return GetRealmsList()
    end
    
    -- same as GetRealmsList except also include known guilds on connected servers
    local realms = GetRealmsList()
    for characterName, character in pairs(DataStore:GetCharacters(THIS_REALM, THIS_ACCOUNT)) do
        local _, _, _, guildRealm = DataStore:GetGuildInfo(character)
        if guildRealm then
            local exists = false
            for _, realm in pairs(realms) do
                if guildRealm == realm then
                    exists = true
                end
            end
            if not exists then
                table.insert(realms, guildRealm)
            end
        end
    end
    return realms
end

local function GetCharacterItemCount(character, searchedID)
	itemCounts[1], itemCounts[2], itemCounts[3], itemCounts[4] = DataStore:GetContainerItemCount(character, searchedID)
	itemCounts[5] = DataStore:GetAuctionHouseItemCount(character, searchedID)
	itemCounts[6] = DataStore:GetInventoryItemCount(character, searchedID)
	itemCounts[7] = DataStore:GetMailItemCount(character, searchedID)
	
	local charCount = 0
	for _, v in pairs(itemCounts) do
		charCount = charCount + v
	end
	
	if charCount > 0 then
		local account, realm, char = strsplit(".", character)
		local name = DataStore:GetColoredCharacterName(character) or char		-- if for any reason this char isn't in DS_Characters.. use the name part of the key
		
		local isOtherAccount = (account ~= THIS_ACCOUNT)
		local isOtherRealm = (realm ~= THIS_REALM)
		
		if isOtherAccount and isOtherRealm then		-- other account AND other realm
			name = format("%s%s (%s / %s)", name, colors.yellow, account, realm)
		elseif isOtherAccount then							-- only other account
			name = format("%s%s (%s)", name, colors.yellow, account)
		elseif isOtherRealm then							-- only other realm
			name = format("%s%s (%s)", name, colors.yellow, realm)
		end
		
		local t = {}
		for k, v in pairs(itemCounts) do
			if v > 0 then	-- if there are more than 0 items in this container
				table.insert(t, colors.white .. itemCountsLabels[k] .. ": "  .. colors.teal .. v)
			end
		end

		if addon:GetOption("UI.Tooltip.ShowSimpleCount") then
			AddCounterLine(name, format("%s%s", colors.orange, charCount))
		else
			-- charInfo should look like 	(Bags: 4, Bank: 8, Equipped: 1, Mail: 7), table concat takes care of this
			AddCounterLine(name, format("%s%s%s (%s%s)", colors.orange, charCount, colors.white, table.concat(t, colors.white..", "), colors.white))
		end
	end
	
	return charCount
end

local function GetAccountItemCount(account, searchedID)
	local count = 0

	for _, realm in pairs(GetRealmsList()) do
        -- sort the characters in alphabetical order
        local characters = DataStore:GetCharacters(realm, account)
        local characterKeys = {}
        for characterKey in pairs(characters) do
            table.insert(characterKeys, characterKey)
        end
        table.sort(characterKeys)
		for _, characterKey in ipairs(characterKeys) do
            local character = characters[characterKey]
			if addon:GetOption("UI.Tooltip.ShowCrossFactionCount") then
				count = count + GetCharacterItemCount(character, searchedID)
			else
				if	DataStore:GetCharacterFaction(character) == UnitFactionGroup("player") then
					count = count + GetCharacterItemCount(character, searchedID)
				end
			end
		end
	end
	return count
end

local function GetItemCount(searchedID)
	-- Return the total amount of times an item is present on this realm, and prepares the counterLines table for later display by the tooltip
	wipe(counterLines)

	local count = 0
	if addon:GetOption("UI.Tooltip.ShowAllAccountsCount") and not addon.Comm.Sharing.SharingInProgress then
		for account in pairs(DataStore:GetAccounts()) do
			count = count + GetAccountItemCount(account, searchedID)
		end
	else
		count = GetAccountItemCount(THIS_ACCOUNT, searchedID)
	end
	
	local showCrossFaction = addon:GetOption("UI.Tooltip.ShowCrossFactionCount")
    
	if addon:GetOption("UI.Tooltip.ShowGuildBankCount") then
		for _, realm in pairs(GetGuildRealmsList()) do
			for guildName, guildKey in pairs(DataStore:GetGuilds(realm)) do
				local altoGuild = addon:GetGuild(guildName)
				local bankFaction = DataStore:GetGuildBankFaction(guildKey)
								
				-- do not show cross faction counters for guild banks if they were not requested
				if (showCrossFaction or (not showCrossFaction and (DataStore:GetGuildBankFaction(guildKey) == UnitFactionGroup("player")))) 
					and (not altoGuild or (altoGuild and not altoGuild.hideInTooltip)) then
					local guildCount = 0
					
					if addon:GetOption("UI.Tooltip.ShowGuildBankCountPerTab") then
						local tabCounters = {}
						
						local tabCount
						for tabID = 1, 8 do 
							tabCount = DataStore:GetGuildBankTabItemCount(guildKey, tabID, searchedID)
							if tabCount and tabCount > 0 then
								table.insert(tabCounters,  format("%s: %s", colors.white .. DataStore:GetGuildBankTabName(guildKey, tabID), colors.teal..tabCount))
							end
						end
						
						if #tabCounters > 0 then
							guildCount = DataStore:GetGuildBankItemCount(guildKey, searchedID) or 0
                            if altoGuild.showGuildRealmInTooltip then
							    AddCounterLine(colors.green..guildName.." ("..realm..")", format("%s %s(%s%s)", colors.orange .. guildCount, colors.white, table.concat(tabCounters, ","), colors.white))
                            else
                                AddCounterLine(colors.green..guildName, format("%s %s(%s%s)", colors.orange .. guildCount, colors.white, table.concat(tabCounters, ","), colors.white))
                            end
						end
					else
						guildCount = DataStore:GetGuildBankItemCount(guildKey, searchedID) or 0
						if guildCount > 0 then
							AddCounterLine(colors.green..guildName, format("%s(%s: %s%s)", colors.white, GUILD_BANK, colors.teal..guildCount, colors.white))
						end
					end
						
					if addon:GetOption("UI.Tooltip.IncludeGuildBankInTotal") then
						count = count + guildCount
					end
				end
			end
		end
	end

	return count
end

function addon:GetRecipeOwners(professionName, link, recipeLevel, recipeRank)
	if not recipeRank then recipeRank = 1 end
    
    local craftName
	local spellID = addon:GetSpellIDFromRecipeLink(link)

	if not spellID then		-- spell id unknown ? let's parse the tooltip
		craftName = GetCraftNameFromRecipeLink(link)
		if not craftName then return end		-- still nothing usable ? then exit
	end

	local know = {}				-- list of alts who know this recipe
	local couldLearn = {}		-- list of alts who could learn it
	local willLearn = {}			-- list of alts who will be able to learn it later

	if not recipeLevel then
		-- it seems that some tooltip libraries interfere and cause a recipeLevel to be nil
		return know, couldLearn, willLearn
	end
    
    local expansionRequirement, specializationRequirement, expansionSkillRequirement = GetRequirementsFromRecipeLink(link)

	local profession, isKnownByChar
	for characterName, character in pairs(DataStore:GetCharacters()) do
		profession = DataStore:GetProfession(character, professionName)

		isKnownByChar = nil
		if profession then
			if spellID then			-- if spell id is known, just find its equivalent in the professions
				isKnownByChar = DataStore:IsCraftKnown(profession, spellID, recipeRank)
			else
				DataStore:IterateRecipes(profession, 0, 0, function(recipeData)
					local _, recipeID, isLearned, knownRecipeRank, totalRanks = DataStore:GetRecipeInfo(recipeData)
					local skillName = GetSpellInfo(recipeID) or ""

					if string.lower(skillName) == string.lower(craftName) and isLearned then
                        if tonumber(recipeRank) > tonumber(knownRecipeRank) then
                            isKnownByChar = false
                            return true
                        else
                            isKnownByChar = true
						    return true	-- stop iteration
                        end
					end
				end)
			end

			local coloredName = DataStore:GetColoredCharacterName(character)
			
            if coloredName then
    			if isKnownByChar then
    				table.insert(know, coloredName)
    			else
    				-- Which expansion's profession does it require?
                    local charactersProfession = DataStore:GetProfession(character, professionName)
                    if expansionRequirement then
                        -- remove the profession name from the string
                        expansionRequirement = string.gsub(expansionRequirement, professionName, "")
                        -- and trim it
                        expansionRequirement = strtrim(expansionRequirement) 
                        
                        -- iterate through each professions category
                        local numCategories = DataStore:GetNumRecipeCategories(charactersProfession)
                        if numCategories > 0 then
                            for index = 1, numCategories do 
                                local id, categoryName, rank, maxRank = DataStore:GetRecipeCategoryInfo(charactersProfession, index)
                                local shouldAdd = false
                                if (string.len(expansionRequirement) == 0) then
                                    local classicProfIDs = {362, 419, 379, 667, 604, 590, 415, 1044, 72, 372, 1078, 1060} 
                                    for _,v in pairs(classicProfIDs) do
                                        if id == v then
                                            shouldAdd = true
                                        end
                                    end 
                                else
                                    if categoryName and string.find(categoryName, expansionRequirement) then
                                        shouldAdd = true
                                    else
                                        -- cooking has weird category names, also some "pandaren" instead of "pandaria" and "broken isles" instead of "legion"
                                        -- TODO: Get localized versions of these names, move them all to the /Locales/ folder.
                                        if (expansionRequirement == "Northrend" and professionName == "Cooking" and id == 74) or
                                            (expansionRequirement == "Pandaria" and professionName == "Cooking" and id == 90) or
                                            (expansionRequirement == "Pandaria" and professionName == "Blacksmithing" and id == 553) or
                                            (expansionRequirement == "Legion" and professionName == "Alchemy" and id == 433) or
                                            (expansionRequirement == "Legion" and professionName == "Cooking" and id == 475) then
                                                shouldAdd = true
                                        end
                                    end
                                end
                                if shouldAdd then
                                    -- one final check before we actually add it: does it require gnomish/goblin engineering?
                                    if specializationRequirement == "Goblin" then
                                        local localizedGoblinEngineering = GetSpellInfo(20222)
                                        if string.find(charactersProfession.FullLink, localizedGoblinEngineering) then
                                            if rank < recipeLevel then
                                                table.insert(willLearn, format("%s |r(%d)", coloredName, rank))
                                            else
                                                table.insert(couldLearn, format("%s |r(%d)", coloredName, rank))
                                            end
                                            break
                                        end    
                                    elseif specializationRequirement == "Gnomish" then
                                        local localizedGnomishEngineering = GetSpellInfo(20219)
                                        if string.find(charactersProfession.FullLink, localizedGnomishEngineering) then
                                            if rank < recipeLevel then
                                                table.insert(willLearn, format("%s |r(%d)", coloredName, rank))
                                            else
                                                table.insert(couldLearn, format("%s |r(%d)", coloredName, rank))
                                            end
                                            break
                                        end                                         
                                    else
                                        if rank < recipeLevel then
                                            table.insert(willLearn, format("%s |r(%d)", coloredName, rank))
                                        else
                                            table.insert(couldLearn, format("%s |r(%d)", coloredName, rank))
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    else                        
                        -- Code should no longer get to this, as expansionRequirement should always have something. Keeping this here just in case a recipe slips through.
                        local currentLevel = DataStore:GetProfessionInfo(charactersProfession)
        				if currentLevel > 0 then
        					if currentLevel < recipeLevel then
        						table.insert(willLearn, format("%s |r(%d)", coloredName, currentLevel))
        					else
        						table.insert(couldLearn, format("%s |r(%d)", coloredName, currentLevel))
        					end
        				end
                    end
    			end
            end
		end
	end
	    
    local function sortStripFormatting(a, b)
        local escapes = {
            ["|c%x%x%x%x%x%x%x%x"] = "", -- color start
            ["|r"] = "", -- color end
            ["|H.-|h(.-)|h"] = "%1", -- links
            ["|T.-|t"] = "", -- textures
            ["{.-}"] = "", -- raid target icons
        }
        local function unescape(str)
            for k, v in pairs(escapes) do
                str = gsub(str, k, v)
            end
            return str
        end
        return (unescape(a) < unescape(b))
    end
    
    table.sort(know, sortStripFormatting)
    table.sort(couldLearn, sortStripFormatting)
    table.sort(willLearn, sortStripFormatting)
	return know, couldLearn, willLearn
end

local function GetRecipeOwnersText(professionName, link, recipeLevel, recipeRank)
	local know, couldLearn, willLearn = addon:GetRecipeOwners(professionName, link, recipeLevel, recipeRank)
	
	local lines = {}
	if #know > 0 then
		table.insert(lines, colors.teal .. L["Already known by "] ..": ".. colors.white.. table.concat(know, ", ") .."\n")
	end
	
	if #couldLearn > 0 then
		table.insert(lines, colors.yellow .. L["Could be learned by "] ..": ".. colors.white.. table.concat(couldLearn, ", ") .."\n")
	end
	
	if #willLearn > 0 then
		table.insert(lines, colors.red .. L["Will be learnable by "] ..": ".. colors.white.. table.concat(willLearn, ", ") .."\n")
	end
	
	return table.concat(lines, "\n")
end

local function AddGlyphOwners(itemID, tooltip)
	local know = {}				-- list of alts who know this glyoh
	local couldLearn = {}		-- list of alts who could learn it

	local knows, could
	for characterName, character in pairs(DataStore:GetCharacters()) do
		knows, could = DataStore:IsGlyphKnown(character, itemID)
		if knows then
			table.insert(know, characterName)
		elseif could then
			table.insert(couldLearn, characterName)
		end
	end
	
	if #know > 0 then
		tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(colors.teal .. L["Already known by "] ..": ".. colors.white.. table.concat(know, ", "), 1, 1, 1, 1);
	end
	
	if #couldLearn > 0 then
		tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(colors.yellow .. L["Could be learned by "] ..": ".. colors.white.. table.concat(couldLearn, ", "), 1, 1, 1, 1);
	end
end

local gatheringNodeWasShown

local function ShowGatheringNodeCounters()
    gatheringNodeWasShown = true
	-- exit if player does not want counters for known gathering nodes
	if addon:GetOption("UI.Tooltip.ShowGatheringNodesCount") == false then return end

	local itemID = LGN.getItemID( _G["GameTooltipTextLeft1"]:GetText() )
	if not itemID or (itemID == cachedItemID) then return end					-- is the item in the tooltip a known type of gathering node ?
	
	if Informant then
		isNodeDone = true
	end

	-- check player bags to see how many times he owns this item, and where
	if addon:GetOption("UI.Tooltip.ShowItemCount") or addon:GetOption("UI.Tooltip.ShowTotalItemCount") then
		cachedCount = GetItemCount(itemID) -- if one of the 2 options is active, do the count
		cachedTotal = (cachedCount > 0) and format("%s: %s", colors.gold..L["Total owned"], colors.teal..cachedCount) or nil
	end
	
	WriteCounterLines(GameTooltip)
	WriteTotal(GameTooltip)
    return true
end

local function ProcessTooltip(tooltip, link)
	if Informant and isNodeDone then
		return
	end
	
	local itemID = addon:GetIDFromLink(link)
	if not itemID then return end
	
	if (itemID == 0) and (TradeSkillFrame ~= nil) and TradeSkillFrame:IsVisible() then
		if (GetMouseFocus():GetName()) == "TradeSkillSkillIcon" then
			itemID = tonumber(GetTradeSkillItemLink(TradeSkillFrame.selectedSkill):match("item:(%d+):")) or nil
		else
			for i = 1, 8 do
				if (GetMouseFocus():GetName()) == "TradeSkillReagent"..i then
					itemID = tonumber(GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, i):match("item:(%d+):")) or nil
					break
				end
			end
		end
	end
    
    if addon:GetOption("UI.Tooltip.HideHearthstoneCounters") and addon:GetOption("UI.Tooltip.HiddenHearthstones")[itemID] then return end
	 
	if (itemID == 0) then return end
	-- if there's no cached item id OR if it's different from the previous one ..
	if (not cachedItemID) or 
		(cachedItemID and (itemID ~= cachedItemID)) then

		cachedRecipeOwners = nil
		cachedItemID = itemID			-- we have searched this ID ..
        
		-- these are the cpu intensive parts of the update .. so do them only if necessary
		cachedSource = nil
		if addon:GetOption("UI.Tooltip.ShowItemSource") then
			local domain, subDomain = addon.Loots:GetSource(itemID)

			if domain then
				subDomain = (subDomain) and format(", %s", subDomain) or ""
				cachedSource = format("%s: %s%s", colors.gold..L["Source"], colors.teal..domain, subDomain)
			end
		end
		
		-- .. then check player bags to see how many times he owns this item, and where
		if addon:GetOption("UI.Tooltip.ShowItemCount") or addon:GetOption("UI.Tooltip.ShowTotalItemCount") then
			cachedCount = GetItemCount(itemID) -- if one of the 2 options is active, do the count
			cachedTotal = (cachedCount > 0) and format("%s: %s", colors.gold..L["Total owned"], colors.teal..cachedCount) or nil
		end
	end

	-- add item cooldown text
	local owner = tooltip:GetOwner()
	if owner and owner.startTime then
		tooltip:AddLine(format(ITEM_COOLDOWN_TIME, SecondsToTime(owner.duration - (GetTime() - owner.startTime))),1,1,1);
	end

	WriteCounterLines(tooltip)
	WriteTotal(tooltip)
	
	if cachedSource then		-- add item source
		tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(cachedSource,1,1,1);
	end
	
	-- addon:CheckMaterialUtility(itemID)
	
	if addon:GetOption("UI.Tooltip.ShowItemID") then
		local iLevel = select(4, GetItemInfo(itemID))
		
		if iLevel then
			tooltip:AddLine(" ",1,1,1);
			tooltip:AddDoubleLine("Item ID: " .. colors.green .. itemID,  "iLvl: " .. colors.green .. iLevel);
		end
	end
	
	local _, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
	
	if itemType == GetItemClassInfo(LE_ITEM_CLASS_GLYPH) then
		AddGlyphOwners(itemID, tooltip)
		return
	end
	
	if addon:GetOption("UI.Tooltip.ShowKnownRecipes") == false then return end -- exit if recipe information is not wanted
	
	if itemType ~= L["ITEM_TYPE_RECIPE"] then return end		-- exit if not a recipe
	if itemSubType == L["ITEM_SUBTYPE_BOOK"] then return end		-- exit if it's a book

	if not cachedRecipeOwners then
        local recipeRank
        if (_G["GameTooltipTextLeft2"]:GetText()) then
            recipeRank = string.match(_G["GameTooltipTextLeft2"]:GetText(), 'Rank (%d)')
        else
            recipeRank = string.match(_G["ItemRefTooltipTextLeft2"]:GetText(), 'Rank (%d)')
        end
        if not recipeRank then recipeRank = 0 end
		cachedRecipeOwners = GetRecipeOwnersText(itemSubType, link, addon:GetRecipeLevel(link, tooltip), recipeRank)
	end
	
	if cachedRecipeOwners then
		tooltip:AddLine(" ",1,1,1);	
		tooltip:AddLine(cachedRecipeOwners, 1, 1, 1, 1);
	end	
end

local function Hook_LinkWrangler(frame)
	local _, link = frame:GetItem()
	if link then
		ProcessTooltip(frame, link)
	end
end

-- ** GameTooltip hooks **
local function OnGameTooltipShow(tooltip, ...)
    if GameTooltip:GetItem() then return end
	if ShowGatheringNodeCounters() then
	   GameTooltip:Show()
    end
end

local function OnGameTooltipUpdate(tooltip, elapsed)
    if not GameTooltip:IsVisible() then return end
    
    if not gatheringNodeWasShown then
        if ShowGatheringNodeCounters() then
            GameTooltip:Show()
        end
    end
end

local function OnGameTooltipSetItem(tooltip, ...)
	if (not isTooltipDone) and tooltip then
		isTooltipDone = true

		local name, link = tooltip:GetItem()
		-- Blizzard broke tooltip:GetItem() in 6.2. Detect and fix the bug if possible.
		if name == "" then
			local itemID = addon:GetIDFromLink(link)
			if not itemID or itemID == 0 then
				-- hooking SetRecipeResultItem & SetRecipeReagentItem is necessary for trade skill UI, link is captured and saved in storedLink
				link = storedLink
			end
		end
		
		if link then
			ProcessTooltip(tooltip, link)
		end
	end
end

local function OnGameTooltipCleared(tooltip, ...)
	isTooltipDone = nil
	isNodeDone = nil		-- for informant
	storedLink = nil
    cachedItemID = nil
    gatheringNodeWasShown = nil
    C_Timer.After(0.2, OnGameTooltipUpdate)
end

local function Hook_SetCurrencyToken(self,index,...)
	if not index then return end

	local info = C_CurrencyInfo.GetCurrencyListInfo(index)
    if not info then return end
    local currency = info.name
	if not currency then return end

	GameTooltip:AddLine(" ",1,1,1);

	local total = 0
	for _, character in pairs(DataStore:GetCharacters()) do
		local _, _, count = DataStore:GetCurrencyInfoByName(character, currency)
		if count and count > 0 then
			GameTooltip:AddDoubleLine(DataStore:GetColoredCharacterName(character),  colors.teal .. count);
			total = total + count
		end
		
	end
	
	if total > 0 then
		GameTooltip:AddLine(" ",1,1,1);
	end
	GameTooltip:AddLine(format("%s: %s", colors.gold..L["Total owned"], colors.teal..total ) ,1,1,1);
	GameTooltip:Show()
end

-- ** ItemRefTooltip hooks **
local function OnItemRefTooltipShow(tooltip, ...)
	addon:ListCharsOnQuest( _G["ItemRefTooltipTextLeft1"]:GetText(), UnitName("player"), ItemRefTooltip)
	ItemRefTooltip:Show()
end

local function OnItemRefTooltipSetItem(tooltip, ...)
	if (not isTooltipDone) and tooltip then
		local _, link = tooltip:GetItem()
		isTooltipDone = true
		if link then
			ProcessTooltip(tooltip, link)
		end
	end
end

local function OnItemRefTooltipCleared(tooltip, ...)
	isTooltipDone = nil
end

-- install a pre-/post-hook on the given tooltip's method
-- simplified version of LibExtraTip's hooking
local function InstallHook(tooltip, method, prehook, posthook)
	local orig = tooltip[method]
	local stub = function(...)
		if prehook then prehook(...) end
		local a,b,c,d,e,f,g,h,i,j,k = orig(...)
		if posthook then posthook(...) end
		return a,b,c,d,e,f,g,h,i,j,k
	end
	tooltip[method] = stub
end

function addon:InitTooltip()
	-- hooking config, format: MethodName = { prehook, posthook }
	local tooltipMethodHooks = {
		SetCurrencyToken = {
			nil,
			Hook_SetCurrencyToken
		},
		SetQuestItem = {
			function(self,type,index) storedLink = GetQuestItemLink(type,index) end,
			nil
		},
		SetQuestLogItem = {
			function(self,type,index) storedLink = GetQuestLogItemLink(type,index) end,
			nil
		},
		SetRecipeResultItem = {
			function(self, recipeID)
				if recipeID then
					storedLink = C_TradeSkillUI.GetRecipeItemLink(recipeID)
				end
			end,
			nil
		},
		SetRecipeReagentItem = {
			function(self, recipeID, reagentIndex)
				if recipeID and reagentIndex then
					storedLink = C_TradeSkillUI.GetRecipeReagentItemLink(recipeID, reagentIndex)
				end
			end,
			nil
		},
	}
	-- install all method hooks
	for m, hooks in pairs(tooltipMethodHooks) do
		InstallHook(GameTooltip, m, hooks[1], hooks[2])
	end

	-- script hooks
	GameTooltip:HookScript("OnShow", OnGameTooltipShow)
	GameTooltip:HookScript("OnTooltipSetItem", OnGameTooltipSetItem)
	GameTooltip:HookScript("OnTooltipCleared", OnGameTooltipCleared)

	ItemRefTooltip:HookScript("OnShow", OnItemRefTooltipShow)
	ItemRefTooltip:HookScript("OnTooltipSetItem", OnItemRefTooltipSetItem)
	ItemRefTooltip:HookScript("OnTooltipCleared", OnItemRefTooltipCleared)
	
	-- LinkWrangler support
	if LinkWrangler then
		LinkWrangler.RegisterCallback ("Altoholic",  Hook_LinkWrangler, "refresh")
	end
end

function addon:RefreshTooltip()
	cachedItemID = nil	-- putting this at NIL will force a tooltip refresh in self:ProcessToolTip
end

function addon:GetItemCount(searchedID)
	-- "public" for other addons using it
	return GetItemCount(searchedID)
end
