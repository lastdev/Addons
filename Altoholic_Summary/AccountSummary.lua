local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local MODE_SUMMARY = 1
local MODE_BAGS = 2
local MODE_SKILLS = 3
local MODE_ACTIVITY = 4
local MODE_CURRENCIES = 5
local MODE_FOLLOWERS = 6
local MODE_COVENANT = 7
local MODE_MISCELLANEOUS = 8
local MODE_KEYSTONES = 9

local SKILL_CAP = 900
local CURRENCY_ID_JUSTICE = 395
local CURRENCY_ID_VALOR = 396
local CURRENCY_ID_APEXIS = 823
local CURRENCY_ID_GARRISON = 824
local CURRENCY_ID_SOTF = 994		-- Seals of Tempered Fate (WoD)
local CURRENCY_ID_ORDER_HALL = 1220
local CURRENCY_ID_SOBF = 1273		-- Seals of the Broken Fate (Legion)
local CURRENCY_ID_NETHERSHARD = 1226
local CURRENCY_ID_LFWS = 1342
local CURRENCY_ID_BFA_WAR_RES = 1560			-- BfA: War Resources
local CURRENCY_ID_BFA_SOWF = 1580				-- BfA: Seals of the Wartorn Fate
local CURRENCY_ID_BFA_DUBLOONS = 1710			-- BfA: Seafarer's Dubloon
local CURRENCY_ID_BFA_WAR_SUPPLIES = 1587		-- BfA: War Supplies
local CURRENCY_ID_BFA_AZERITE = 1565			-- BfA: Rich Azerite Fragment
local CURRENCY_ID_REDEEMED_SOUL = 1810			-- Shadowlands: Redeemed Soul
local CURRENCY_ID_ANIMA = 1813			-- Shadowlands: Reservoir Anima

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2
local THIS_ACCOUNT = "Default"
local MAX_LOGOUT_TIMESTAMP = 5000000000

local VIEW_BAGS = 1
local VIEW_QUESTS = 2
local VIEW_TALENTS = 3
local VIEW_AUCTIONS = 4
local VIEW_BIDS = 5
local VIEW_MAILS = 6
local VIEW_COMPANIONS = 7
local VIEW_SPELLS = 8
local VIEW_PROFESSION = 9
local VIEW_GARRISONS = 10
local VIEW_COVENANT_RENOWN = 11
local VIEW_COVENANT_SOULBINDS = 12

local TEXTURE_FONT = "|T%s:%s:%s|t"
local CRITERIA_COMPLETE_ICON = "\124TInterface\\AchievementFrame\\UI-Achievement-Criteria-Check:14\124t"

addon.Summary = {}

local ns = addon.Summary		-- ns = namespace

-- *** Utility functions ***
local function GetRestedXP(character)
	local rate, savedXP, savedRate, rateEarnedResting, xpEarnedResting, maxXP, isFullyRested, timeUntilFullyRested = DataStore:GetRestXPRate(character)

	-- display in 100% or 150% mode ?
	local coeff = 1
	if addon:GetOption("UI.Tabs.Summary.ShowRestXP150pc") then
		coeff = 1.5
	end
	
	-- coefficient remains the same for pandaren, only the max should be increased
	local maxCoeff = coeff
	if DataStore:GetCharacterRace(character) == "Pandaren" then 
		maxCoeff = maxCoeff * 2 -- show as "200%" or "300%" for pandaren, who can accumulate 3 levels instead of 1.5
	end
	
	rate = rate * maxCoeff
	
	-- second return value = the actual percentage of rest xp, as a numeric value (1 to 100, not 150)
	local color = colors.green
	if rate >= (100 * maxCoeff) then 
		rate = 100 * maxCoeff
	else
		if rate < (30 * coeff) then
			color = colors.red
		elseif rate < (60 * coeff) then
			color = colors.yellow
		end
	end

	return format("%s%2.0f", color, rate).."%", rate, savedXP, savedRate * maxCoeff, rateEarnedResting * maxCoeff, xpEarnedResting, maxXP, isFullyRested, timeUntilFullyRested
end

local function CanUpgradeRidingSkill(character, speed)
	local characterLevel = DataStore:GetCharacterLevel(character)
	local couldUpgrade = false
		
	-- Could the player upgrade ?
	DataStore:IterateRidingSkills(function(skill) 
		if characterLevel >= skill.minLevel and speed < skill.speed then
			couldUpgrade = true
		end
	end)
	
	return couldUpgrade
end

local function FormatBagType(link, bagType)
	link = link or ""
	if bagType and strlen(bagType) > 0 then
		return format("%s %s(%s)", link, colors.yellow, bagType)
	end
	
	-- not bag type ? just return the link
	return link
end

local function FormatBagSlots(size, free)
	return format(L["NUM_SLOTS_AND_FREE"], colors.cyan, size, colors.white, colors.green, free, colors.white)
end

local function FormatAiL(level)
	return format("%s%s %s%s", colors.yellow, L["COLUMN_ILEVEL_TITLE_SHORT"], colors.green, level)
end

local function FormatTexture(texture)
	-- all textures are formatted to be 18x18 on this panel
	return format("|T%s:18:18|t", texture)
end

local function FormatGreyIfEmpty(text, color)
	color = color or colors.white
		
	if not text or text == "" then
		text = NONE
		color = colors.grey
	end
	
	return format("%s%s", color, text)
end

local function FormatDuration(seconds)
	local color = (seconds == 0) and colors.grey or colors.white

	local hours = floor(seconds / 3600)
	seconds = mod(seconds, 3600)
	local minutes = floor(seconds / 60)
	seconds = mod(seconds, 60)

	return format("%s%02d:%02d:%02d", color, hours, minutes, seconds)	
end


local skillColors = { colors.recipeGrey, colors.red, colors.orange, colors.yellow, colors.green }

local function GetSkillRankColor(rank, skillCap)
	rank = rank or 0
	skillCap = skillCap or SKILL_CAP

	-- Get the index in the colors table
	local index = floor(rank / (skillCap/4)) + 1
	
	-- players with a high skill level may trigger an out of bounds index, so cap it
	if index > #skillColors then
		index = #skillColors
	end
	
	return skillColors[index]
end

local function TradeskillHeader_OnEnter(frame, tooltip)
	tooltip:AddLine(" ")
	tooltip:AddLine(format("%s%s|r %s %s", colors.recipeGrey, L["COLOR_GREY"], L["up to"], (floor(SKILL_CAP*0.25)-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s", colors.red, RED_GEM, L["up to"], (floor(SKILL_CAP*0.50)-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s", colors.orange, L["COLOR_ORANGE"], L["up to"], (floor(SKILL_CAP*0.75)-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s", colors.yellow, YELLOW_GEM, L["up to"], (SKILL_CAP-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s %s", colors.green, L["COLOR_GREEN"], L["at"], SKILL_CAP, L["and above"]),1,1,1)
end

local function RidingSkillHeader_OnEnter(frame, tooltip)
	tooltip:AddLine(" ")
	
	DataStore:IterateRidingSkills(function(skill) 
		tooltip:AddDoubleLine(
			format("%s%s %s%d |r(%s %s%s|r)", 
				colors.white, LEVEL, 
				colors.green, skill.minLevel, 
				COSTS_LABEL,
				colors.gold, format(GOLD_AMOUNT_TEXTURE_STRING, BreakUpLargeNumbers(skill.cost), 13, 13)), 
			format("%s%s%%", colors.white, skill.speed))
	end)
end

local function Tradeskill_OnEnter(frame, skillName, showRecipeStats)
	local character = frame:GetParent().character
	if not DataStore:GetModuleLastUpdateByKey("DataStore_Crafts", character) then return end
	
	local curRank, maxRank = DataStore:GetProfessionInfo(DataStore:GetProfession(character, skillName))
	local profession = DataStore:GetProfession(character, skillName)

	local tt = AltoTooltip
	
	tt:ClearLines()
	tt:SetOwner(frame, "ANCHOR_RIGHT")
	tt:AddLine(skillName,1,1,1)
	tt:AddLine(format("%s%s/%s", GetSkillRankColor(curRank), curRank, maxRank),1,1,1)
	
	if showRecipeStats then	-- for primary skills + cooking & first aid
		-- if DataStore:GetProfessionSpellID(skillName) ~= 2366 and skillName ~= GetSpellInfo(8613) then		-- no display for herbalism & skinning
			tt:AddLine(" ")
			
			if not profession then
				tt:AddLine(L["No data"])
				tt:Show()
				return
			end

			local numCategories = DataStore:GetNumRecipeCategories(profession)
			if numCategories == 0 then
				tt:AddLine(format("%s: 0 %s", L["No data"], TRADESKILL_SERVICE_LEARN),1,1,1)
			else
				for i = 1, numCategories do
					local _, name, rank, maxRank = DataStore:GetRecipeCategoryInfo(profession, i)
					
					if name and rank and maxRank then
						-- display the rank in the right color
						if (maxRank == 0) or (rank < (maxRank * 0.5)) then		-- red if no maxrank, or below 50%
							color = colors.red
						elseif rank < maxRank then										-- yellow when below max
							color = colors.yellow
						else																	-- green otherwise	
							color = colors.green
						end
						
						tt:AddDoubleLine(name, format("%s%s|r / %s%s", color, rank, colors.green, maxRank))
					-- else
						-- tt:AddLine(name)
					end
				end
			
				local orange, yellow, green, grey = DataStore:GetNumRecipesByColor(profession)
				
				tt:AddLine(" ")
				tt:AddLine(format("%d %s",
					(orange + yellow + green + grey),
					TRADESKILL_SERVICE_LEARN),1,1,1)
				tt:AddLine(format("%s%d %s%s|r / %s%d %s%s|r / %s%d %s%s",
					colors.white, green, colors.recipeGreen, L["COLOR_GREEN"],
					colors.white, yellow, colors.yellow, L["COLOR_YELLOW"],
					colors.white, orange, colors.recipeOrange, L["COLOR_ORANGE"]))
			end
		-- end
	end

	local suggestion = addon:GetSuggestion(skillName, curRank)
	if suggestion then
		tt:AddLine(" ")
		tt:AddLine(format("%s: ", L["Suggestion"]),1,1,1)
		tt:AddLine(format("%s%s", colors.teal, suggestion),1,1,1)
	end
	
	-- parse profession cooldowns
	if profession then
		DataStore:ClearExpiredCooldowns(profession)
		local numCooldows = DataStore:GetNumActiveCooldowns(profession)
		
		if numCooldows == 0 then
			tt:AddLine(" ")
			tt:AddLine(L["All cooldowns are up"],1,1,1)
		else
			tt:AddLine(" ")
			for i = 1, numCooldows do
				local craftName, expiresIn = DataStore:GetCraftCooldownInfo(profession, i)
				tt:AddDoubleLine(craftName, addon:GetTimeString(expiresIn))
			end
		end
	end
	
	tt:Show()
end

local function Tradeskill_OnClick(frame, skillName)
	local character = frame:GetParent().character
	if not skillName or not DataStore:GetModuleLastUpdateByKey("DataStore_Crafts", character) then return end

	local profession = DataStore:GetProfession(character, skillName)
	if not profession or DataStore:GetNumRecipeCategories(profession) == 0 then		-- if profession hasn't been scanned (or scan failed), exit
		return
	end
	
	local charName, realm, account = strsplit(".", character)
	local chat = ChatEdit_GetLastActiveWindow()
	
	if chat:IsShown() and IsShiftKeyDown() and realm == GetRealmName() then
		-- if shift-click, then display the profession link and exit
		local link = profession.FullLink	
		if link and link:match("trade:") then
			chat:Insert(link);
		end
		return
	end

	addon.Tabs:OnClick("Characters")
	addon.Tabs.Characters:SetAltKey(character)
	addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
	addon.Tabs.Characters:SetCurrentProfession(skillName)
end

local function CurrencyHeader_OnEnter(frame, currencyID)
	local tt = AltoTooltip
	
	tt:ClearLines()
	tt:SetOwner(frame, "ANCHOR_BOTTOM")
	tt:SetHyperlink(C_CurrencyInfo.GetCurrencyLink(currencyID, 0))
	tt:Show()
end

local Characters = addon.Characters

local function SortView(columnName)
	addon:SetOption("UI.Tabs.Summary.CurrentColumn", columnName)
	addon.Summary:Update()
end

local function GetColorFromAIL(level)
	if (level < 600) then return colors.grey end
	if (level <= 615) then return colors.green end
	if (level <= 630) then return colors.rare end
	return colors.epic
end


-- ** Right-Click Menu **
local function ViewAltInfo(self, characterInfoLine)
	addon.Tabs:OnClick("Characters")
	addon.Tabs.Characters:SetAlt(Characters:GetInfo(characterInfoLine))
	addon.Tabs.Characters:ViewCharInfo(self.value)
end

local function DeleteAlt_MsgBox_Handler(self, button, characterInfoLine)
	if not button then return end
	
	local name, realm, account = Characters:GetInfo(characterInfoLine)
	
	DataStore:DeleteCharacter(name, realm, account)
	
	-- rebuild the main character table, and all the menus
	Characters:InvalidateView()
	addon.Summary:Update()
		
	addon:Print(format( L["Character %s successfully deleted"], name))
end

local function DeleteAlt(self, characterInfoLine)
	local name, realm, account = Characters:GetInfo(characterInfoLine)
	
	if (account == THIS_ACCOUNT) and	(realm == GetRealmName()) and (name == UnitName("player")) then
		addon:Print(L["Cannot delete current character"])
		return
	end
	
	AltoMessageBox:SetHandler(DeleteAlt_MsgBox_Handler, characterInfoLine)
	AltoMessageBox:SetText(format("%s?\n%s", L["Delete this Alt"], name))
	AltoMessageBox:Show()
end

local function UpdateRealm(self, characterInfoLine)
	local _, realm, account = Characters:GetInfo(characterInfoLine)
	
	AltoAccountSharing_AccNameEditBox:SetText(account)
	AltoAccountSharing_UseTarget:SetChecked(nil)
	AltoAccountSharing_UseName:SetChecked(1)
	
	local _, updatedWith = addon:GetLastAccountSharingInfo(realm, account)
	AltoAccountSharing_AccTargetEditBox:SetText(updatedWith)
	
	addon.Tabs.Summary:AccountSharingButton_OnClick()
end

local function DeleteRealm_MsgBox_Handler(self, button, characterInfoLine)
	if not button then return end

	local _, realm, account = Characters:GetInfo(characterInfoLine)
	DataStore:DeleteRealm(realm, account)

	-- if the realm being deleted was the current ..
	local tc = addon.Tabs.Characters
	if tc and tc:GetRealm() == realm and tc:GetAccount() == account then
		
		-- reset to this player
		local player = UnitName("player")
		local realmName = GetRealmName()
		addon.Tabs.Characters:SetAlt(player, realmName, THIS_ACCOUNT)
		addon.Containers:UpdateCache()
		tc:ViewCharInfo(VIEW_BAGS)
	end
	
	-- rebuild the main character table, and all the menus
	Characters:InvalidateView()
	addon.Summary:Update()
		
	addon:Print(format( L["Realm %s successfully deleted"], realm))
end

local function DeleteRealm(self, characterInfoLine)
	local _, realm, account = Characters:GetInfo(characterInfoLine)
		
	if (account == THIS_ACCOUNT) and	(realm == GetRealmName()) then
		addon:Print(L["Cannot delete current realm"])
		return
	end

	AltoMessageBox:SetHandler(DeleteRealm_MsgBox_Handler, characterInfoLine)
	AltoMessageBox:SetText(format("%s?\n%s", L["Delete this Realm"], realm))
	AltoMessageBox:Show()
end

local function NameRightClickMenu_Initialize(frame)
	local characterInfoLine = ns.CharInfoLine
	if not characterInfoLine then return end

	local lineType = Characters:GetLineType(characterInfoLine)
	if not lineType then return end

	if lineType == INFO_REALM_LINE then
		local _, realm, account = Characters:GetInfo(characterInfoLine)
		local _, updatedWith = addon:GetLastAccountSharingInfo(realm, account)
		
		if updatedWith then
			frame:AddButtonWithArgs(format("Update from %s", colors.green..updatedWith), nil, UpdateRealm, characterInfoLine)
		end
		frame:AddButtonWithArgs(L["Delete this Realm"], nil, DeleteRealm, characterInfoLine)
		return
	end

	-- View => View xx ..
	-- Mark as => Bank types
	-- Delete this alt
	
	
	frame:AddTitle(DataStore:GetColoredCharacterName(Characters:Get(characterInfoLine).key))
	frame:AddTitle()
	frame:AddButtonWithArgs(L["View bags"], VIEW_BAGS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["View mailbox"], VIEW_MAILS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["View quest log"], VIEW_QUESTS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["View auctions"], VIEW_AUCTIONS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["View bids"], VIEW_BIDS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(COMPANIONS, VIEW_COMPANIONS, ViewAltInfo, characterInfoLine)
	frame:AddButtonWithArgs(L["Delete this Alt"], nil, DeleteAlt, characterInfoLine)
	frame:AddCloseMenu()
end

local function Name_OnClick(frame, button)
	local line = frame:GetParent():GetID()
	if line == 0 then return end

	local lineType = Characters:GetLineType(line)
	if lineType == INFO_TOTAL_LINE then
		return
	end
	
	if button == "RightButton" then
		ns.CharInfoLine = line	-- line containing info about the alt on which action should be taken (delete, ..)
		
		local scrollFrame = frame:GetParent():GetParent().ScrollFrame
		local menu = scrollFrame:GetParent():GetParent().ContextualMenu
		local offset = scrollFrame:GetOffset()
		
		menu:Initialize(NameRightClickMenu_Initialize, "LIST")
		menu:Close()
		menu:Toggle(frame, frame:GetWidth() - 20, 10)
			
		return
	elseif button == "LeftButton" and lineType == INFO_CHARACTER_LINE then
		addon.Tabs:OnClick("Characters")
		
		local tc = addon.Tabs.Characters
		tc:SetAlt(Characters:GetInfo(line))
		tc:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
		addon.Containers:UpdateCache()
		tc:ViewCharInfo(VIEW_BAGS)
	end
end


-- *** Specific sort functions ***
local function GetCharacterLevel(self, character)
	local level = DataStore:GetCharacterLevel(character) or 0
	local rate = DataStore:GetXPRate(character) or 0

	return level + (rate / 100)
end

local function GetRarityLevel(self, character)
	local numEpic = DataStore:GetNumEpicFollowers(character) or 0
	local numRare = DataStore:GetNumRareFollowers(character) or 0
	
	return numEpic + (numRare / 100)
end

local function GetFollowersLevel615To630(self, character)
	local num615 = DataStore:GetNumFollowersAtiLevel615(character) or 0
	local num630 = DataStore:GetNumFollowersAtiLevel630(character) or 0
	
	return num630 + (num615 / 100)
end

local function GetFollowersLevel645To660(self, character)
	local num645 = DataStore:GetNumFollowersAtiLevel645(character) or 0
	local num660 = DataStore:GetNumFollowersAtiLevel660(character) or 0
	
	return num660 + (num645 / 100)
end

local function GetFollowersItemLevel(self, character)
	local avgWeapon = DataStore:GetAvgWeaponiLevel(character) or 0
	local avgArmor = DataStore:GetAvgArmoriLevel(character) or 0
	
	avgWeapon = math.floor(avgWeapon*10)	-- 615.17 becomes 6151
	avgArmor = math.floor(avgArmor*10)
	
	return avgWeapon + (avgArmor / 10000)
end

local function GetRenownLevel(self, character)
	return select(3, DataStore:GetCovenantInfo(character)) or 0
end

local function GetGuildOrRank(self, character)
	local guildName, guildRank, rankIndex = DataStore:GetGuildInfo(character)

	--	return the combination of guild, rank + index to ensure sort order is preserved on refresh !
	return format("%s.%s.%s", guildName or "", rankIndex or "", guildRank or "")
end



-- *** Column definitions ***
local columns = {}

-- ** Account Summary **
columns["Name"] = {
	-- Header
	headerWidth = 100,
	headerLabel = NAME,
	headerOnClick = function() SortView("Name") end,
	headerSort = DataStore.GetCharacterName,
	
	-- Content
	Width = 150,
	JustifyH = "LEFT",
	GetText = function(character) 
			local name = DataStore:GetColoredCharacterName(character)
			local class = DataStore:GetCharacterClass(character)
			local icon = icons[DataStore:GetCharacterFaction(character)] or "Interface/Icons/INV_BannerPVP_03"

			return format("%s %s (%s)", FormatTexture(icon), name, class)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local tt = AltoTooltip
		
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), DataStore:GetColoredCharacterFaction(character))
			tt:AddLine(format("%s %s%s |r%s %s", L["Level"], 
				colors.green, DataStore:GetCharacterLevel(character), DataStore:GetCharacterRace(character), DataStore:GetCharacterClass(character)),1,1,1)

			local zone, subZone = DataStore:GetLocation(character)
			tt:AddLine(format("%s: %s%s |r(%s%s|r)", L["Zone"], colors.gold, zone, colors.gold, subZone),1,1,1)
			
			local guildName = DataStore:GetGuildInfo(character)
			if guildName then
				tt:AddLine(format("%s: %s%s", GUILD, colors.green, guildName),1,1,1)
			end

			local suggestion = addon:GetSuggestion("Leveling", DataStore:GetCharacterLevel(character))
			if suggestion then
				tt:AddLine(" ")
				tt:AddLine(L["Suggested leveling zone: "],1,1,1)
				tt:AddLine(format("%s%s:", colors.teal, suggestion),1,1,1)
			end

			-- parse saved instances
			local bLineBreak = true

			local dungeons = DataStore:GetSavedInstances(character)
			if dungeons then
				for key, _ in pairs(dungeons) do
					local hasExpired, expiresIn = DataStore:HasSavedInstanceExpired(character, key)
					
					if hasExpired then
						DataStore:DeleteSavedInstance(character, key)
					else
						if bLineBreak then
							tt:AddLine(" ")		-- add a line break only once
							bLineBreak = nil
						end
						
						local instanceName, instanceID = strsplit("|", key)
						tt:AddDoubleLine(format("%s (%sID: %s|r)", colors.gold..instanceName, colors.white, colors.green..instanceID), addon:GetTimeString(expiresIn))
					end
				end
			end

			tt:AddLine(" ")
			tt:AddLine(format("%s%s", colors.green, L["Right-Click for options"]))
			tt:Show()
		end,
	OnClick = Name_OnClick,
	GetTotal = function(line) return format("  %s", L["Totals"]) end,
}

columns["Level"] = {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_LEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_LEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_LEVEL_SUBTITLE"],
	headerOnClick = function() SortView("Level") end,
	headerSort = GetCharacterLevel,
	
	-- Content
	Width = 50,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetCharacterLevel(character)
		if level ~= MAX_PLAYER_LEVEL and addon:GetOption("UI.Tabs.Summary.ShowLevelDecimals") then
			local rate = DataStore:GetXPRate(character)
			level = format("%.1f", level + (rate/100))		-- show level as 98.4 if not level cap
		end
	
		return format("%s%s", colors.green, level)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_LEVEL_TITLE"])
			tt:AddLine(format("%s %s%s |r%s %s", L["Level"], 
				colors.green, DataStore:GetCharacterLevel(character), DataStore:GetCharacterRace(character), DataStore:GetCharacterClass(character)),1,1,1)
			
			tt:AddLine(" ")
			tt:AddLine(format("%s %s%s%s/%s%s%s (%s%s%%%s)", EXPERIENCE_COLON,
				colors.green, DataStore:GetXP(character), colors.white,
				colors.green, DataStore:GetXPMax(character), colors.white,
				colors.green, DataStore:GetXPRate(character), colors.white),1,1,1)
			tt:Show()
		end,
	OnClick = function(frame, button)
			addon:ToggleOption(nil, "UI.Tabs.Summary.ShowLevelDecimals")
			addon.Summary:Update()
		end,
	GetTotal = function(line) return Characters:GetField(line, "level") end,
}

columns["RestXP"] = {
	-- Header
	headerWidth = 65,
	headerLabel = L["COLUMN_RESTXP_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_RESTXP_TITLE"],
	tooltipSubTitle = L["COLUMN_RESTXP_SUBTITLE"],
	headerOnEnter = function(frame, tooltip)
			tooltip:AddLine(" ")
			tooltip:AddLine(L["COLUMN_RESTXP_DETAIL_1"], 1,1,1)
			tooltip:AddLine(L["COLUMN_RESTXP_DETAIL_2"], 1,1,1)
			tooltip:AddLine(L["COLUMN_RESTXP_DETAIL_3"], 1,1,1)
			tooltip:AddLine(" ")
			tooltip:AddLine(format(L["COLUMN_RESTXP_DETAIL_4"], 100, 100))
			tooltip:AddLine(format(L["COLUMN_RESTXP_DETAIL_4"], 150, 150))
		end,
	headerOnClick = function() SortView("RestXP") end,
	headerSort = DataStore.GetRestXPRate,
	
	-- Content
	Width = 65,
	JustifyH = "CENTER",
	GetText = function(character) 
		if DataStore:GetCharacterLevel(character) == MAX_PLAYER_LEVEL then
			return format("%s0%%", colors.white)	-- show 0% at max level
		end

		return GetRestedXP(character)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end

			local restXP = DataStore:GetRestXP(character)
			-- if not restXP or restXP == 0 then return end
			if not restXP or DataStore:GetCharacterLevel(character) == MAX_PLAYER_LEVEL then return end

			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ")
			
			local rate, _, savedXP, savedRate, rateEarnedResting, xpEarnedResting, maxXP, isFullyRested, timeUntilFullyRested = GetRestedXP(character)
			
			tt:AddLine(format("%s: %s%d", L["Maximum Rest XP"], colors.green, maxXP),1,1,1)
			tt:AddLine(format("%s: %s%d %s(%2.1f%%)", L["Saved Rest XP"], colors.green, savedXP, colors.yellow, savedRate),1,1,1)
			tt:AddLine(format("%s: %s%d %s(%2.1f%%)", L["XP earned while resting"], colors.green, xpEarnedResting, colors.yellow, rateEarnedResting),1,1,1)
			tt:AddLine(" ")
			if isFullyRested then
				tt:AddLine(format("%s", L["Fully rested"]),1,1,1)
			else
				tt:AddLine(format("%s%s: %s", colors.white, L["Fully rested in"], addon:GetTimeString(timeUntilFullyRested)))
			end
			
			tt:Show()
		end,
	OnClick = function(frame, button)
			addon:ToggleOption(nil, "UI.Tabs.Summary.ShowRestXP150pc")
			addon.Summary:Update()
		end,	
}

columns["Money"] = {
	-- Header
	headerWidth = 115,
	headerLabel = format("%s  %s", FormatTexture("Interface\\Icons\\inv_misc_coin_01"), L["COLUMN_MONEY_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_MONEY_TITLE"],
	tooltipSubTitle = L["COLUMN_MONEY_SUBTITLE_"..random(5)],
	headerOnClick = function() SortView("Money") end,
	headerSort = DataStore.GetMoney,
	
	-- Content
	Width = 110,
	JustifyH = "RIGHT",
	GetText = function(character) 
		return addon:GetMoneyString(DataStore:GetMoney(character))
	end,
	GetTotal = function(line) return addon:GetMoneyString(Characters:GetField(line, "money"), colors.white) end,
}

columns["Played"] = {
	-- Header
	headerWidth = 100,
	headerLabel = L["COLUMN_PLAYED_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_PLAYED_TITLE"],
	tooltipSubTitle = L["COLUMN_PLAYED_SUBTITLE"],
	headerOnClick = function() SortView("Played") end,
	headerSort = DataStore.GetPlayTime,
	
	-- Content
	Width = 100,
	JustifyH = "RIGHT",
	GetText = function(character) 
		return addon:GetTimeString(DataStore:GetPlayTime(character))
	end,
	OnClick = function(frame, button)
			DataStore:ToggleOption(nil, "DataStore_Characters", "HideRealPlayTime")
			addon.Summary:Update()
		end,
	GetTotal = function(line) return Characters:GetField(line, "played") end,
}

columns["AiL"] = {
	-- Header
	headerWidth = 55,
	headerLabel = L["COLUMN_ILEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_ILEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_ILEVEL_SUBTITLE"],
	headerOnClick = function() SortView("AiL") end,
	headerSort = DataStore.GetAverageItemLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local AiL = DataStore:GetAverageItemLevel(character) or 0
		if addon:GetOption("UI.Tabs.Summary.ShowILevelDecimals") then
			return format("%s%.1f", colors.yellow, AiL)
		else
			return format("%s%d", colors.yellow, AiL)
		end
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(format("%s%s: %s%.1f",
				colors.white, L["COLUMN_ILEVEL_TITLE"],
				colors.green, DataStore:GetAverageItemLevel(character)
			),1,1,1)

			addon:AiLTooltip()
			tt:Show()
		end,
	OnClick = function(frame, button)
			addon:ToggleOption(nil, "UI.Tabs.Summary.ShowILevelDecimals")
			addon.Summary:Update()
		end,
	GetTotal = function(line) return colors.white..format("%.1f", Characters:GetField(line, "realmAiL")) end,
}

columns["LastOnline"] = {
	-- Header
	headerWidth = 90,
	headerLabel = L["COLUMN_LASTONLINE_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_LASTONLINE_TITLE"],
	tooltipSubTitle = L["COLUMN_LASTONLINE_SUBTITLE"],
	headerOnClick = function() SortView("LastOnline") end,
	headerSort = DataStore.GetLastLogout,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local account, realm, player = strsplit(".", character)
		
		if (player == UnitName("player")) and (realm == GetRealmName()) and (account == "Default") then
			return format("%s%s", colors.green, GUILD_ONLINE_LABEL)
		end
		
		local lastLogout = DataStore:GetLastLogout(character)
		if lastLogout == MAX_LOGOUT_TIMESTAMP then
			return UNKNOWN
		end
		
		return format("%s%s", colors.white, addon:FormatDelay(lastLogout))
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end
			
			local text
			local account, realm, player = strsplit(".", character)
			
			if (player == UnitName("player")) and (realm == GetRealmName()) and (account == "Default") then
				-- current player ? show ONLINE
				text = format("%s%s", colors.green, GUILD_ONLINE_LABEL)
			else
				-- other player, show real time since last online
				local lastLogout = DataStore:GetLastLogout(character)
				
				if lastLogout == MAX_LOGOUT_TIMESTAMP then
					text = UNKNOWN
				else
					text = format("%s: %s", LASTONLINE, SecondsToTime(time() - lastLogout))
				end
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ")
			-- then - now = x seconds
			tt:AddLine(text,1,1,1)
			tt:Show()
		end,
}


-- ** Bag Usage **
columns["BagSlots"] = {
	-- Header
	headerWidth = 100,
	headerLabel = format("%s  %s", FormatTexture("Interface\\Icons\\inv_misc_bag_08"), L["COLUMN_BAGS_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_BAGS_TITLE"],
	tooltipSubTitle = L["COLUMN_BAGS_SUBTITLE_"..random(2)],
	headerOnClick = function() SortView("BagSlots") end,
	headerSort = DataStore.GetNumBagSlots,
	
	-- Content
	Width = 100,
	JustifyH = "LEFT",
	GetText = function(character)
				if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
					return UNKNOWN
				end
				
				return format("%s/%s|r/%s|r/%s|r/%s",
					DataStore:GetContainerSize(character, 0),
					DataStore:GetColoredContainerSize(character, 1),
					DataStore:GetColoredContainerSize(character, 2),
					DataStore:GetColoredContainerSize(character, 3),
					DataStore:GetColoredContainerSize(character, 4)
				)
			end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_BAGS_TITLE"])
			tt:AddLine(" ")
			
			local _, link, size, free, bagType = DataStore:GetContainerInfo(character, 0)
			tt:AddDoubleLine(format("%s[%s]", colors.white, BACKPACK_TOOLTIP), FormatBagSlots(size, free))
			
			for i = 1, 4 do
				_, link, size, free, bagType = DataStore:GetContainerInfo(character, i)

				if size ~= 0 then
					tt:AddDoubleLine(FormatBagType(link, bagType), FormatBagSlots(size, free))
				end
			end
			tt:Show()
		end,
	GetTotal = function(line) return format("%s%s |r%s", colors.white, Characters:GetField(line, "bagSlots"), L["slots"]) end,
	TotalJustifyH = "CENTER",
}

columns["FreeBagSlots"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FREEBAGSLOTS_TITLE"],
	tooltipSubTitle = L["COLUMN_FREEBAGSLOTS_SUBTITLE"],
	headerOnClick = function() SortView("FreeBagSlots") end,
	headerSort = DataStore.GetNumFreeBagSlots,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			local numSlots = DataStore:GetNumBagSlots(character)
			local numFree = DataStore:GetNumFreeBagSlots(character)
			local color = ((numFree / numSlots) <= 0.1) and colors.red or colors.green
			
			return format("%s%s|r/%s%s", color, numFree, colors.cyan, numSlots)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_FREEBAGSLOTS_TITLE"])
			tt:AddLine(" ")
			tt:AddLine(FormatBagSlots(DataStore:GetNumBagSlots(character), DataStore:GetNumFreeBagSlots(character)))
			tt:Show()
		end,
	GetTotal = function(line) return format("%s%s", colors.white, Characters:GetField(line, "freeBagSlots")) end,
}

columns["BankSlots"] = {
	-- Header
	headerWidth = 160,
	headerLabel = format("%s  %s", FormatTexture("Interface\\Icons\\achievement_guildperk_mobilebanking"), L["COLUMN_BANK_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_BANK_TITLE"],
	tooltipSubTitle = L["COLUMN_BANK_SUBTITLE_"..random(2)],
	headerOnClick = function() SortView("BankSlots") end,
	headerSort = DataStore.GetNumBankSlots,
	
	-- Content
	Width = 160,
	JustifyH = "LEFT",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return UNKNOWN
			end

			if DataStore:GetNumBankSlots(character) == 0 then
				return L["Bank not visited yet"]
			end
			
			return format("%s/%s|r/%s|r/%s|r/%s|r/%s|r/%s|r/%s",
				DataStore:GetContainerSize(character, 100),
				DataStore:GetColoredContainerSize(character, 5),
				DataStore:GetColoredContainerSize(character, 6),
				DataStore:GetColoredContainerSize(character, 7),
				DataStore:GetColoredContainerSize(character, 8),
				DataStore:GetColoredContainerSize(character, 9),
				DataStore:GetColoredContainerSize(character, 10),
				DataStore:GetColoredContainerSize(character, 11)
			)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_BANK_TITLE"])
			tt:AddLine(" ")
			
			if DataStore:GetNumBankSlots(character) == 0 then
				tt:AddLine(L["Bank not visited yet"],1,1,1)
				tt:Show()
				return
			end
			
			local _, link, size, free, bagType = DataStore:GetContainerInfo(character, 100)
			tt:AddDoubleLine(format("%s[%s]", colors.white, L["Bank"]), FormatBagSlots(size, free))
				
			for i = 5, 11 do
				_, link, size, free, bagType = DataStore:GetContainerInfo(character, i)
				
				if size ~= 0 then
					tt:AddDoubleLine(FormatBagType(link, bagType), FormatBagSlots(size, free))
				end
			end
			tt:Show()
		end,
	GetTotal = function(line) return format("%s%s |r%s", colors.white, Characters:GetField(line, "bankSlots"), L["slots"]) end,
	TotalJustifyH = "CENTER",
}

columns["FreeBankSlots"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_FREEBANKLOTS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FREEBANKLOTS_TITLE"],
	tooltipSubTitle = L["COLUMN_FREEBANKLOTS_SUBTITLE"],
	headerOnClick = function() SortView("FreeBankSlots") end,
	headerSort = DataStore.GetNumFreeBankSlots,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			local numSlots = DataStore:GetNumBankSlots(character)
			if numSlots == 0 then		-- Bank not visited yet
				return 0			
			end
			
			local numFree = DataStore:GetNumFreeBankSlots(character)
			local color = ((numFree / numSlots) <= 0.1) and colors.red or colors.green
			
			return format("%s%s|r/%s%s", color, numFree, colors.cyan, numSlots)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_FREEBANKLOTS_TITLE"])
			tt:AddLine(" ")
			tt:AddLine(FormatBagSlots(DataStore:GetNumBankSlots(character), DataStore:GetNumFreeBankSlots(character)))
			tt:Show()
		end,
	GetTotal = function(line) return format("%s%s", colors.white, Characters:GetField(line, "freeBankSlots")) end,
}

columns["FreeReagentBankSlots"] = {	-- TO DO 
	-- Header
	headerWidth = 50,
	headerLabel = LASTONLINE,
	-- headerOnClick = function(frame) 
		-- SortView("FreeReagentBankSlots") 
	-- end,
	--headerSort = DataStore.xxx,
	
	-- Content
	Width = 50,
	JustifyH = "CENTER",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			-- TO DO : problem to workaround GetContainerNumFreeSlots returns 0 when the bag (-3) is scanned when not at the bank..
			
			return 0
		end,
}

-- ** Skills **
columns["Prof1"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_PROFESSION_1_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_PROFESSION_1_TITLE"],
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerOnClick = function() SortView("Prof1") end,
	headerSort = DataStore.GetProfession1,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank, _, _, name = DataStore:GetProfession1(character)
			local spellID = DataStore:GetProfessionSpellID(name)
			local icon = spellID and FormatTexture(addon:GetSpellIcon(spellID)) .. " " or ""
			
			return format("%s%s%s", icon, GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			local _, _, _, skillName = DataStore:GetProfession1(character)
			Tradeskill_OnEnter(frame, skillName, true)
		end,
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			local _, _, _, skillName = DataStore:GetProfession1(character)
			Tradeskill_OnClick(frame, skillName)
		end,
}

columns["Prof2"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_PROFESSION_2_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_PROFESSION_2_TITLE"],
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerOnClick = function() SortView("Prof2") end,
	headerSort = DataStore.GetProfession2,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank, _, _, name = DataStore:GetProfession2(character)
			local spellID = DataStore:GetProfessionSpellID(name)
			local icon = spellID and FormatTexture(addon:GetSpellIcon(spellID)) .. " " or ""
			
			return format("%s%s%s", icon, GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			local _, _, _, skillName = DataStore:GetProfession2(character)
			Tradeskill_OnEnter(frame, skillName, true)
		end,
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			local _, _, _, skillName = DataStore:GetProfession2(character)
			Tradeskill_OnClick(frame, skillName)
		end,
}

columns["ProfCooking"] = {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", FormatTexture(addon:GetSpellIcon(2550))),
	tooltipTitle = GetSpellInfo(2550),
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerOnClick = function() SortView("ProfCooking") end,
	headerSort = DataStore.GetCookingRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank = DataStore:GetCookingRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(2550), true)
		end,
	OnClick = function(frame, button)
			Tradeskill_OnClick(frame, GetSpellInfo(2550))
		end,
}

columns["ProfFishing"] = {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", FormatTexture(addon:GetSpellIcon(131474))),
	tooltipTitle = GetSpellInfo(131474),
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerOnClick = function() SortView("ProfFishing") end,
	headerSort = DataStore.GetFishingRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank = DataStore:GetFishingRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(131474), true)
		end,
}

columns["ProfArchaeology"] = {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", FormatTexture(addon:GetSpellIcon(78670))),
	tooltipTitle = GetSpellInfo(78670),
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerOnClick = function() SortView("ProfArchaeology") end,
	headerSort = DataStore.GetArchaeologyRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank = DataStore:GetArchaeologyRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(78670))
		end,
}

columns["Riding"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("    %s", FormatTexture("Interface\\Icons\\spell_nature_swiftness")),
	tooltipTitle = L["Riding"],
	tooltipSubTitle = nil,
	headerOnEnter = RidingSkillHeader_OnEnter,
	headerOnClick = function() SortView("Riding") end,
	headerSort = DataStore.GetRidingSkill,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character) 
		local speed, _, _, equipmentID = DataStore:GetRidingSkill(character)
		local color = colors.white
		
		if speed == 0 then
			color = colors.grey
		elseif speed == 150 then
			color = colors.orange
		elseif speed == 280 then
			color = colors.yellow
		elseif speed == 310 then
			color = colors.green
		end
		
		local text = (CanUpgradeRidingSkill(character, speed)) 
			and format("%s%d%% %s!", color, speed, colors.gold)
			or format("%s%d%%", color, speed)
		
		-- If the mount is equipped, display its icon, info will be in the tooltip
		if equipmentID then 
			local icon = select(5, GetItemInfoInstant(equipmentID))
			
			if icon then
				return format("%s %s", text, FormatTexture(icon))
			end
		end
		
		return text	
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local speed, spellName, spellID, equipmentID = DataStore:GetRidingSkill(character)
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["Riding"])
			tt:AddLine(" ")

			if speed == 0 then 

			else
				tt:AddLine(spellName, 1, 1, 1)
				tt:AddLine(GetSpellDescription(spellID), nil, nil, nil, true)
			end
			
			-- Add the mount equipment
			if equipmentID then
				tt:AddLine(" ")
				local _, link, _, _, _, _, itemSubType, _, _, icon = GetItemInfo(equipmentID)
				
				if itemSubType then
					tt:AddLine(format("%s%s", colors.white, itemSubType))
				end
				
				if link and icon then
					tt:AddLine(format("%s %s", FormatTexture(icon), link))
				end
			end

			-- Add a line if riding skill is upgradeable
			if CanUpgradeRidingSkill(character, speed) then
				tt:AddLine(" ")
				tt:AddLine(L["COLUMN_RIDING_UPGRADEABLE"], 0, 1, 0)
			end
			
			tt:Show()
		end,
}

-- ** Activity **
columns["Mails"] = {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_MAILS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_MAILS_TITLE"],
	tooltipSubTitle = L["COLUMN_MAILS_SUBTITLE"],
	headerOnEnter = function(frame, tooltip)
			tooltip:AddLine(" ")
			tooltip:AddLine(L["COLUMN_MAILS_DETAIL_1"], 1,1,1)
			tooltip:AddLine(L["COLUMN_MAILS_DETAIL_2"], 1,1,1)
		end,
	headerOnClick = function() SortView("Mails") end,
	headerSort = DataStore.GetNumMails,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local color = colors.grey
			local num = DataStore:GetNumMails(character) or 0

			if num ~= 0 then
				color = colors.green		-- green by default, red if at least one mail is about to expire
							
				local threshold = DataStore:GetOption("DataStore_Mails", "MailWarningThreshold")
				if DataStore:GetNumExpiredMails(character, threshold) > 0 then
					color = colors.red
				end
			end
			return format("%s%s", color, num)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local num = DataStore:GetNumMails(character)
			if not num or num == 0 then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_MAILS_TITLE"])
			tt:AddLine(" ")
			tt:AddLine(format("%sMails found: %s%d", colors.white, colors.green, num))
			
			local numReturned, numDeleted, numExpired = 0, 0, 0
			local closestReturn
			local closestDelete
			
			for index = 1, num do
				local _, _, _, _, _, isReturned = DataStore:GetMailInfo(character, index)
				local _, seconds = DataStore:GetMailExpiry(character, index)
				
				if seconds < 0 then		-- mail has already expired
					if isReturned then	-- .. and it was a returned mail
						numExpired = numExpired + 1
					end
				else
					if isReturned then
						numDeleted = numDeleted + 1
						
						if not closestDelete then
							closestDelete = seconds
						else
							if seconds < closestDelete then
								closestDelete = seconds
							end
						end
					else
						numReturned = numReturned + 1
						
						if not closestReturn then
							closestReturn = seconds
						else
							if seconds < closestReturn then
								closestReturn = seconds
							end
						end
					end
				end
			end

			tt:AddLine(" ")
			tt:AddLine(format("%s%d %swill be returned upon expiry", colors.green, numReturned, colors.white))
			if closestReturn then
				tt:AddLine(format("%sClosest return in %s%s", colors.white, colors.green, SecondsToTime(closestReturn)))
			end
			
			if numDeleted > 0 then
				tt:AddLine(" ")
				tt:AddLine(format("%s%d %swill be %sdeleted%s upon expiry", colors.green, numDeleted, colors.white, colors.red, colors.white))
				if closestDelete then
					tt:AddLine(format("%sClosest deletion in %s%s", colors.white, colors.green, SecondsToTime(closestDelete)))
				end
			end
			
			if numExpired > 0 then
				tt:AddLine(" ")
				tt:AddLine(format("%s%d %shave expired !", colors.red, numExpired, colors.white))
			end
			
			tt:Show()
		end,
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			if not character then return end
	
			local num = DataStore:GetNumMails(character)
			if not num or num == 0 then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_MAILS)
		end,
}

columns["LastMailCheck"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_MAILBOX_VISITED_TITLE"],
	tooltipSubTitle = L["COLUMN_MAILBOX_VISITED_SUBTITLE"],
	headerOnClick = function() SortView("LastMailCheck") end,
	headerSort = DataStore.GetMailboxLastVisit,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			return format("%s%s", colors.white, addon:FormatDelay(DataStore:GetMailboxLastVisit(character)))
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Mails", character) then
				return
			end
			
			local lastVisit = DataStore:GetMailboxLastVisit(character)
			if not lastVisit then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), MINIMAP_TRACKING_MAILBOX)
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s", L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"], SecondsToTime(time() - lastVisit)),1,1,1)
			tt:Show()
		end,
}

columns["Auctions"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_AUCTIONS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_AUCTIONS_TITLE"],
	tooltipSubTitle = L["COLUMN_AUCTIONS_SUBTITLE"],
	headerOnClick = function() SortView("Auctions") end,
	headerSort = DataStore.GetNumAuctions,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local num = DataStore:GetNumAuctions(character) or 0
			return format("%s%s", ((num == 0) and colors.grey or colors.green), num)
		end,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local num = DataStore:GetNumAuctions(character)
			if not num or num == 0 then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_AUCTIONS)
		end,
}

columns["Bids"] = {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_BIDS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_BIDS_TITLE"],
	tooltipSubTitle = L["COLUMN_BIDS_SUBTITLE"],
	headerOnClick = function() SortView("Bids") end,
	headerSort = DataStore.GetNumBids,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local num = DataStore:GetNumBids(character) or 0
			return format("%s%s", ((num == 0) and colors.grey or colors.green), num)
		end,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local num = DataStore:GetNumBids(character)
			if not num or num == 0 then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_BIDS)
		end,
}

columns["AHLastVisit"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"],
	tooltipSubTitle = L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"],
	headerOnClick = function() SortView("AHLastVisit") end,
	headerSort = DataStore.GetAuctionHouseLastVisit,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			return format("%s%s", colors.white, addon:FormatDelay(DataStore:GetAuctionHouseLastVisit(character)))
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Mails", character) then
				return
			end
			
			local lastVisit = DataStore:GetAuctionHouseLastVisit(character)
			if not lastVisit then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), BUTTON_LAG_AUCTIONHOUSE)
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s", L["Visited"], SecondsToTime(time() - lastVisit)),1,1,1)
			tt:Show()
		end,
}

columns["MissionTableLastVisit"] = {
	-- Header
	headerWidth = 80,
	headerLabel = L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_GARRISON_MISSIONS_TITLE"],
	tooltipSubTitle = L["COLUMN_GARRISON_MISSIONS_SUBTITLE"],
	headerOnEnter = function(frame, tooltip)
			tooltip:AddLine(" ")
			tooltip:AddLine(format("%s* %s= %s", colors.green, colors.white, L["COLUMN_GARRISON_MISSIONS_DETAIL_1"]))
			tooltip:AddLine(format("%s* %s= %s", colors.red, colors.white, L["COLUMN_GARRISON_MISSIONS_DETAIL_2"]))
			tooltip:AddLine(format("%s! %s= %s", colors.gold, colors.white, L["COLUMN_GARRISON_MISSIONS_DETAIL_3"]))
		end,
	headerOnClick = function() SortView("MissionTableLastVisit") end,
	headerSort = DataStore.GetMissionTableLastVisit,
	
	-- Content
	Width = 65,
	JustifyH = "RIGHT",
	GetText = function(character)
			local numAvail = 	(DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0) or 0) + 
									(DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0) or 0) +
									(DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0) or 0) +
									(DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0) or 0)
			local numActive = (DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0) or 0) + 
									(DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0) or 0) +
									(DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0) or 0) +
									(DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0) or 0) 
			local numCompleted = (DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0) or 0) + 
										(DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0) or 0) +
										(DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0) or 0) +
										(DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0) or 0) 
			local text = ""
			
			if numCompleted > 0 then		-- add a '*' to show that there are some completed missions
				if numCompleted == numActive then
					text = format(" %s*", colors.red)	-- red if ALL active missions are complete
				else
					text = format(" %s*", colors.green)
				end
			elseif numActive == 0 and numAvail ~= 0 then
				text = format(" %s!", colors.gold)	-- red '!' no mission is active !
			end
	
			return format("%s%s%s", colors.white, addon:FormatDelay(DataStore:GetMissionTableLastVisit(character)), text)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Garrisons", character) then
				return
			end
			
			local lastVisit = DataStore:GetMissionTableLastVisit(character)
			if not lastVisit then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), GARRISON_MISSIONS_TITLE)
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s", L["Visited"], SecondsToTime(time() - lastVisit)),1,1,1)
			tt:AddLine(" ")
			
			-- ** Garrison Missions **
			
			local numAvail = DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0) or 0
			local numActive = DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0) or 0
			local numCompleted = DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0) or 0
			local color = colors.green
			
			tt:AddLine(GARRISON_MISSIONS_TITLE)
			tt:AddLine(format("Available Missions: %s%d", color, numAvail),1,1,1)
			
			if numActive == 0 and numAvail ~= 0 then
				color = colors.red
			end
			tt:AddLine(format("In Progress: %s%d", color, numActive),1,1,1)
			
			color = (numCompleted > 0) and colors.cyan or colors.white
			tt:AddLine(format("%sCompleted Missions: %s%d", color, colors.green, numCompleted),1,1,1)
			tt:AddLine(" ")
			
			-- ** Order Hall Missions **
			
			numAvail = DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0) or 0
			numActive = DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0) or 0
			numCompleted = DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0) or 0			
			color = colors.green
			
			tt:AddLine(ORDER_HALL_MISSIONS)
			tt:AddLine(format("Available Missions: %s%d", color, numAvail),1,1,1)
			
			if numActive == 0 and numAvail ~= 0 then
				color = colors.red
			end
			tt:AddLine(format("In Progress: %s%d", color, numActive),1,1,1)
			
			color = (numCompleted > 0) and colors.cyan or colors.white
			tt:AddLine(format("%sCompleted Missions: %s%d", color, colors.green, numCompleted),1,1,1)
			tt:AddLine(" ")
			
			-- ** War Campaign Missions **
            
			numAvail = DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0) or 0
			numActive = DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0) or 0
			numCompleted = DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0) or 0			
			color = colors.green
			
			tt:AddLine(format("%s %s", WAR_CAMPAIGN, WAR_MISSIONS)) 	-- "War Campaign Missions"
			tt:AddLine(format("Available Missions: %s%d", color, numAvail),1,1,1)
			
			if numActive == 0 and numAvail ~= 0 then
				color = colors.red
			end
			tt:AddLine(format("In Progress: %s%d", color, numActive),1,1,1)
			
			color = (numCompleted > 0) and colors.cyan or colors.white
			tt:AddLine(format("%sCompleted Missions: %s%d", color, colors.green, numCompleted),1,1,1)			
			tt:AddLine(" ")
			
			-- ** Covenant Sanctum Missions **
            
			numAvail = DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0) or 0
			numActive = DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0) or 0
			numCompleted = DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0) or 0			
			color = colors.green
			
			tt:AddLine(format("%s %s", GARRISON_TYPE_9_0_LANDING_PAGE_TITLE, GARRISON_TYPE_8_0_LANDING_PAGE_TITLE))
			tt:AddLine(format("Available Missions: %s%d", color, numAvail),1,1,1)
			
			if numActive == 0 and numAvail ~= 0 then
				color = colors.red
			end
			tt:AddLine(format("In Progress: %s%d", color, numActive),1,1,1)
			
			color = (numCompleted > 0) and colors.cyan or colors.white
			tt:AddLine(format("%sCompleted Missions: %s%d", color, colors.green, numCompleted),1,1,1)			
			
			tt:Show()
		end,
		
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			if not character then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_GARRISONS)
		end,
}


-- ** Currencies **
columns["CurrencyGarrison"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("  %s  6.0", FormatTexture("Interface\\Icons\\inv_garrison_resource")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_GARRISON)
		end,
	headerOnClick = function() SortView("CurrencyGarrison") end,
	headerSort = DataStore.GetGarrisonResources,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local uncollected = DataStore:GetUncollectedResources(character) or 0
			local amount = DataStore:GetCurrencyTotals(character, CURRENCY_ID_GARRISON) or 0
			local color = (amount == 0) and colors.grey or colors.white
			local colorUncollected
			
			if uncollected <= 300 then
				colorUncollected = colors.green
			elseif uncollected < 450 then
				colorUncollected = colors.yellow
			else
				colorUncollected = colors.red
			end

			return format("%s%s/%s+%s", color, amount, colorUncollected , uncollected)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Garrisons", character) then
				return
			end
			
			local amount = DataStore:GetCurrencyTotals(character, CURRENCY_ID_GARRISON) or 0
			local uncollected = DataStore:GetUncollectedResources(character) or 0
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["Garrison resources"])
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s%s", L["Garrison resources"], colors.green, amount),1,1,1)
			tt:AddLine(format("%s: %s%s", L["Uncollected resources"], colors.green, uncollected),1,1,1)
			
			local lastVisit = DataStore:GetLastResourceCollectionTime(character)
			if lastVisit then
				tt:AddLine(format("%s: %s", L["Last collected"], SecondsToTime(time() - lastVisit)),1,1,1)
			end
			
			if uncollected < 500 then
				tt:AddLine(" ")
				
				-- (resources not yet obtained * 600 seconds)
				tt:AddLine(format("%s: %s", L["Max. uncollected resources in"], SecondsToTime((500 - uncollected) * 600)),1,1,1)
			end
			tt:Show()
		end,
}

columns["CurrencyNethershard"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("        %s", FormatTexture("Interface\\Icons\\inv_datacrystal01")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_NETHERSHARD)
		end,
	headerOnClick = function() SortView("CurrencyNethershard") end,
	headerSort = DataStore.GetNethershards,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetCurrencyTotals(character, CURRENCY_ID_NETHERSHARD) or 0
			local color = (amount == 0) and colors.grey or colors.white
				
			return format("%s%s", color, amount)
		end,
}

columns["CurrencyLegionWarSupplies"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("      %s", FormatTexture("Interface\\Icons\\inv_misc_summonable_boss_token")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_LFWS)
		end,
	headerOnClick = function() SortView("CurrencyLegionWarSupplies") end,
	headerSort = DataStore.GetWarSupplies,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_LFWS)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
}

columns["CurrencySOBF"] = {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", FormatTexture("Interface\\Icons\\inv_misc_elvencoins")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_SOBF)
		end,
	headerOnClick = function() SortView("CurrencySOBF") end,
	headerSort = DataStore.GetSealsOfBrokenFate,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_SOBF)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
}

columns["CurrencyOrderHall"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("  %s  7.0", FormatTexture("Interface\\Icons\\inv_garrison_resource")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_ORDER_HALL)
		end,
	headerOnClick = function() SortView("CurrencyOrderHall") end,
	headerSort = DataStore.GetOrderHallResources,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetCurrencyTotals(character, CURRENCY_ID_ORDER_HALL) or 0
			local color = (amount == 0) and colors.grey or colors.white

			return format("%s%s", color, amount)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			
			tt:AddDoubleLine(
				DataStore:GetColoredCharacterName(character),
				DataStore:GetColoredCharacterFaction(character)
			)
			
			tt:AddLine(format("%s %s%s |r%s %s", L["Level"], colors.green, 
				DataStore:GetCharacterLevel(character), 
				DataStore:GetCharacterRace(character),	
				DataStore:GetCharacterClass(character))
			,1,1,1)

			local zone, subZone = DataStore:GetLocation(character)
			tt:AddLine(format("%s: %s%s |r(%s%s|r)", L["Zone"], colors.gold, zone, colors.gold, subZone),1,1,1)
			
			tt:AddLine(format("%s %s%s%s/%s%s%s (%s%s%%%s)", EXPERIENCE_COLON,
				colors.green, DataStore:GetXP(character), colors.white,
				colors.green, DataStore:GetXPMax(character), colors.white,
				colors.green, DataStore:GetXPRate(character), colors.white),1,1,1)
			
			local restXP = DataStore:GetRestXP(character)
			if restXP and restXP > 0 then
				tt:AddLine(format("%s: %s%s", L["Rest XP"], colors.green, restXP),1,1,1)
			end

			tt:AddLine(" ")
			tt:AddLine(format("%s%s:", colors.gold, CURRENCY),1,1,1)
			
			local num = DataStore:GetNumCurrencies(character) or 0
			for i = 1, num do
				local isHeader, name, count = DataStore:GetCurrencyInfo(character, i)
				name = name or ""
				
				if isHeader then
					tt:AddLine(format("%s%s", colors.yellow, name))
				else
					tt:AddLine(format("  %s: %s%s", name, colors.green, count),1,1,1)
				end
			end
			
			if num == 0 then
				tt:AddLine(format("%s%s", colors.white, NONE),1,1,1)
			end
			
			tt:Show()
		end,
}


columns["CurrencyBfAWarResources"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("      %s", FormatTexture("Interface\\Icons\\inv__faction_warresources")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_BFA_WAR_RES)
		end,
	headerOnClick = function() SortView("CurrencyBfAWarResources") end,
	headerSort = DataStore.GetBfAWarResources,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetCurrencyTotals(character, CURRENCY_ID_BFA_WAR_RES)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s", color, amount)
		end,
}

columns["CurrencyBfASOWF"] = {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", FormatTexture("Interface\\Icons\\timelesscoin_yellow")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_BFA_SOWF)
		end,
	headerOnClick = function() SortView("CurrencyBfASOWF") end,
	headerSort = DataStore.GetBfASealsOfWartornFate,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_BFA_SOWF)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
}

columns["CurrencyBfADubloons"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("      %s", FormatTexture("Interface\\Icons\\inv_misc_azsharacoin")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_BFA_DUBLOONS)
		end,
	headerOnClick = function() SortView("CurrencyBfADubloons") end,
	headerSort = DataStore.GetBfADubloons,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetCurrencyTotals(character, CURRENCY_ID_BFA_DUBLOONS)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s", color, amount)
		end,
}

columns["CurrencyBfAWarSupplies"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("      %s", FormatTexture("Interface\\Icons\\pvpcurrency-conquest-horde")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_BFA_WAR_SUPPLIES)
		end,
	headerOnClick = function() SortView("CurrencyBfAWarSupplies") end,
	headerSort = DataStore.GetBfAWarSupplies,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_BFA_WAR_SUPPLIES)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
}

columns["CurrencyBfARichAzerite"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("      %s", FormatTexture("Interface\\Icons\\inv_smallazeriteshard")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_BFA_AZERITE)
		end,
	headerOnClick = function() SortView("CurrencyBfARichAzerite") end,
	headerSort = DataStore.GetBfARichAzerite,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_BFA_AZERITE)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
}


columns["CurrencyStygia"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("     %s", FormatTexture("Interface\\Icons\\inv_stygia")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, DataStore.Enum.CurrencyIDs.Stygia)
		end,
	headerOnClick = function() SortView("CurrencyStygia") end,
	headerSort = function(self, character) return DataStore:GetCurrencyTotals(character, DataStore.Enum.CurrencyIDs.Stygia) end,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetCurrencyTotals(character, DataStore.Enum.CurrencyIDs.Stygia)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s", color, amount)
		end,
}

columns["CurrencyValor"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("     %s", FormatTexture("Interface\\Icons\\pvecurrency-valor")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, DataStore.Enum.CurrencyIDs.ValorPoints)
		end,
	headerOnClick = function() SortView("CurrencyValor") end,
	headerSort = function(self, character) return DataStore:GetCurrencyTotals(character, DataStore.Enum.CurrencyIDs.ValorPoints) end,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, DataStore.Enum.CurrencyIDs.ValorPoints)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
}

columns["CurrencyConquest"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("     %s", FormatTexture("Interface\\Icons\\achievement_legionpvp2tier3")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, DataStore.Enum.CurrencyIDs.Conquest)
		end,
	headerOnClick = function() SortView("CurrencyConquest") end,
	headerSort = function(self, character) return DataStore:GetCurrencyTotals(character, DataStore.Enum.CurrencyIDs.Conquest) end,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetCurrencyTotals(character, DataStore.Enum.CurrencyIDs.Conquest)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s", color, amount)
		end,
}

columns["CurrencySoulAsh"] = {
	-- Header
	headerWidth = 80,
	headerLabel = format("     %s", FormatTexture("Interface\\Icons\\inv_soulash")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, DataStore.Enum.CurrencyIDs.SoulAsh)
		end,
	headerOnClick = function() SortView("CurrencySoulAsh") end,
	headerSort = function(self, character) return DataStore:GetCurrencyTotals(character, DataStore.Enum.CurrencyIDs.SoulAsh) end,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetCurrencyTotals(character, DataStore.Enum.CurrencyIDs.SoulAsh)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s", color, amount)
		end,
}

-- ** Garrison Followers **
columns["FollowersLV40"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_FOLLOWERS_LV40_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FOLLOWERS_LV40_TITLE"],
	tooltipSubTitle = L["COLUMN_FOLLOWERS_LV40_SUBTITLE"],
	headerOnClick = function() SortView("FollowersLV40") end,
	headerSort = DataStore.GetNumFollowersAtLevel100,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetNumFollowers(character) or 0
			local color = (amount == 0) and colors.grey or colors.white
			local amountLv100 = DataStore:GetNumFollowersAtLevel100(character) or 0
			
			return format("%s%s/%s", color, amountLv100, amount)
		end,
}

columns["FollowersEpic"] = {
	-- Header
	headerWidth = 55,
	headerLabel = L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FOLLOWERS_RARITY_TITLE"],
	tooltipSubTitle = L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"],
	headerOnClick = function() SortView("FollowersEpic") end,
	headerSort = GetRarityLevel,
	
	-- Content
	Width = 55,
	JustifyH = "CENTER",
	GetText = function(character)
			local numRare = DataStore:GetNumRareFollowers(character) or 0
			local colorRare = (numRare == 0) and colors.grey or colors.rare
			
			local numEpic = DataStore:GetNumEpicFollowers(character) or 0
			local colorEpic = (numEpic == 0) and colors.grey or colors.epic
			
			return format("%s%s%s/%s%s", colorRare, numRare, colors.white, colorEpic, numEpic)
		end,
}

columns["FollowersLV630"] = {
	-- Header
	headerWidth = 70,
	headerLabel = "615/630",
	tooltipTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_TITLE"], "615/630"),
	tooltipSubTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"], "615 vs 630"),
	headerOnClick = function() SortView("FollowersLV630") end,
	headerSort = GetFollowersLevel615To630,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local num615 = DataStore:GetNumFollowersAtiLevel615(character) or 0
			local color615 = (num615 == 0) and colors.grey or colors.green
			local num630 = DataStore:GetNumFollowersAtiLevel630(character) or 0
			local color630 = (num630 == 0) and colors.grey or colors.rare
			
			return format("%s%s%s/%s%s", color615, num615, colors.white, color630, num630)
		end,
}

columns["FollowersLV660"] = {
	-- Header
	headerWidth = 70,
	headerLabel = "645/660",
	tooltipTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_TITLE"], "645/660"),
	tooltipSubTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"], "645 vs 660"),
	headerOnClick = function() SortView("FollowersLV660") end,
	headerSort = GetFollowersLevel645To660,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local num645 = DataStore:GetNumFollowersAtiLevel645(character) or 0
			local color645 = (num645 == 0) and colors.grey or colors.epic
			local num660 = DataStore:GetNumFollowersAtiLevel660(character) or 0
			local color660 = (num660 == 0) and colors.grey or colors.epic
			
			return format("%s%s%s/%s%s", color645, num645, colors.white, color660, num660)
		end,
}

columns["FollowersLV675"] = {
	-- Header
	headerWidth = 50,
	headerLabel = "675",
	tooltipTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_TITLE"], "675"),
	tooltipSubTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"], "675"),
	headerOnClick = function() SortView("FollowersLV675") end,
	headerSort = DataStore.GetNumFollowersAtiLevel675,
	
	-- Content
	Width = 50,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetNumFollowersAtiLevel675(character) or 0
			local color = (amount == 0) and colors.grey or colors.epic
			
			return format("%s%s", color, amount)
		end,
}

columns["FollowersItems"] = {
	-- Header
	headerWidth = 75,
	headerLabel = L["COLUMN_FOLLOWERS_AIL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FOLLOWERS_AIL_TITLE"],
	tooltipSubTitle = L["COLUMN_FOLLOWERS_AIL_SUBTITLE"],
	headerOnClick = function() SortView("FollowersItems") end,
	headerSort = GetFollowersItemLevel,
	
	-- Content
	Width = 75,
	JustifyH = "CENTER",
	GetText = function(character)
			local avgWeapon = DataStore:GetAvgWeaponiLevel(character) or 0
			local colorW = GetColorFromAIL(avgWeapon)
			
			local avgArmor = DataStore:GetAvgArmoriLevel(character) or 0
			local colorA = GetColorFromAIL(avgArmor)
			
			return format("%s%.1f%s/%s%.1f", colorW, avgWeapon, colors.white, colorA, avgArmor)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Garrisons", character) then
				return
			end
			
			local avgWeapon = DataStore:GetAvgWeaponiLevel(character) or 0
			local colorW = GetColorFromAIL(avgWeapon)
			local avgArmor = DataStore:GetAvgArmoriLevel(character) or 0
			local colorA = GetColorFromAIL(avgArmor)
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s%.1f", WEAPON, colorW, avgWeapon),1,1,1)
			tt:AddLine(format("%s: %s%.1f", ARMOR, colorA, avgArmor),1,1,1)
			tt:Show()
		end,
}


-- ** Covenant Sanctum **
local playStyles = {
	["main"] = L["Overall"],
	["raid"] = CALENDAR_TYPE_RAID,
	["mythic"] = MYTHIC_DUNGEONS,
	["torghast"] = L["Torghast"],
	["single"] = L["Single target build"],
	["aoe"] = L["AOE build"],
}

columns["CovenantName"] = {
	-- Header
	headerWidth = 80,
	headerLabel = L["COLUMN_COVENANT_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_COVENANT_TITLE"],
	tooltipSubTitle = L["COLUMN_COVENANT_SUBTITLE"],
	headerOnClick = function() SortView("CovenantName") end,
	headerSort = DataStore.GetCovenantName,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character) 
		return FormatGreyIfEmpty(DataStore:GetCovenantName(character))
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			-- Get the class ID, may be unknown if the character has not been logged in yet.
			local _, englishClass, classID = DataStore:GetCharacterClass(character)
			if not classID then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["Recommended Covenant"])
			
			for i = 1, GetNumSpecializationsForClassID(classID) do
				local _, specName, _, iconID = GetSpecializationInfoForClassID(classID, i)
				-- local icon = addon:GetSpellIcon(iconID)
				
				tt:AddLine(" ")
				tt:AddLine(format("%s%s", colors.gold, specName))
				-- tt:AddDoubleLine(format("%s%s", colors.white, specName), format(TEXTURE_FONT, icon, 18, 18))
				
				local info = DataStore:GetRecommendedCovenant(englishClass, i)
				
				for context, bestCovenantID in pairs(info) do
					local text = (playStyles[context]) and playStyles[context]

					if context == "choice1" then
						-- Maybe we have 2 equally viable choices
						tt:AddLine(format("%s%s : %s%s, %s", colors.white, L["Equally viable"], colors.cyan,
							DataStore:GetCovenantNameByID(info.choice1), 
							DataStore:GetCovenantNameByID(info.choice2)))
					elseif text then
						tt:AddLine(format("%s%s : %s%s", colors.white, text, colors.cyan, DataStore:GetCovenantNameByID(bestCovenantID)))
					end
					
				end
			end
			
			tt:Show()
		end,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local covenantID = DataStore:GetCovenantInfo(character)
			if not covenantID or covenantID == 0 then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_COVENANT_SOULBINDS)
		end,
}

columns["SoulbindName"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_SOULBIND_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_SOULBIND_TITLE"],
	tooltipSubTitle = L["COLUMN_SOULBIND_SUBTITLE"],
	headerOnClick = function() SortView("SoulbindName") end,
	headerSort = DataStore.GetActiveSoulbindName,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character) 
		return FormatGreyIfEmpty(DataStore:GetActiveSoulbindName(character))
	end,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local covenantID = DataStore:GetCovenantInfo(character)
			if not covenantID or covenantID == 0 then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_COVENANT_SOULBINDS)
		end,
}

columns["Renown"] = {
	-- Header
	headerWidth = 60,
	headerLabel = COVENANT_SANCTUM_TAB_RENOWN ,
	tooltipTitle = L["COLUMN_RENOWN_TITLE"],
	tooltipSubTitle = L["COLUMN_RENOWN_SUBTITLE"],
	headerOnClick = function() SortView("Renown") end,
	headerSort = GetRenownLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = select(3, DataStore:GetCovenantInfo(character))
		local color = (level >= 40) and colors.gold or colors.white
	
		return format("%s%s", color, level)
	end,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local covenantID = DataStore:GetCovenantInfo(character)
			if not covenantID or covenantID == 0 then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_COVENANT_RENOWN)
		end,
}

columns["CampaignProgress"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_CAMPAIGNPROGRESS_TITLE"],
	tooltipSubTitle = L["COLUMN_CAMPAIGNPROGRESS_SUBTITLE"],
	headerOnClick = function() SortView("CampaignProgress") end,
	headerSort = DataStore.GetCovenantCampaignProgress,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character) 
		local numCompleted = DataStore:GetCovenantCampaignProgress(character)
		local numQuests = DataStore:GetCovenantCampaignLength(character)

		local colorCompleted = (numCompleted == 0) and colors.grey or colors.white
		local colorNumQuests = (numQuests == 0) and colors.grey or colors.yellow
		
		return format("%s%s%s/%s%s", colorCompleted, numCompleted, colors.white, colorNumQuests, numQuests)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local numCompleted = DataStore:GetCovenantCampaignProgress(character)
			local numQuests = DataStore:GetCovenantCampaignLength(character)
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), DataStore:GetCovenantName(character))
			tt:AddLine(" ")
			tt:AddLine(format(CAMPAIGN_PROGRESS_CHAPTERS_TOOLTIP, numCompleted, numQuests))
			
			for _, info in pairs(DataStore:GetCovenantCampaignChaptersInfo(character)) do
				local color
				local icon = " - "
				
				if info.completed == nil then
					color = colors.grey				-- grey for not started
				elseif info.completed == false then
					color = colors.white				-- white for ongoing
				elseif info.completed == true then
					color = colors.green				-- green for completed
					icon = CRITERIA_COMPLETE_ICON
				end
				
				tt:AddLine(format("%s%s%s", icon, color, info.name))
			end
			tt:Show()
		end,
}

columns["CurrencyAnima"] = {
	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", FormatTexture("Interface\\Icons\\spell_animabastion_orb")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_ANIMA)
		end,
	headerOnClick = function() SortView("CurrencyAnima") end,
	headerSort = DataStore.GetReservoirAnima,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_ANIMA)
			local color = (amount == 0) and colors.grey or colors.white
			
			-- save some space by shortening the label
			if totalMax > 0 then
				totalMax = format("%sk", (totalMax / 1000))
			end
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
}

columns["CurrencyRedeemedSoul"] = {
	-- Header
	headerWidth = 60,
	headerLabel = format("  %s", FormatTexture("Interface\\Icons\\sha_spell_warlock_demonsoul_nightborne")),
	headerOnEnter = function(frame, tooltip)
			CurrencyHeader_OnEnter(frame, CURRENCY_ID_REDEEMED_SOUL)
		end,
	headerOnClick = function() SortView("CurrencyRedeemedSoul") end,
	headerSort = DataStore.GetRedeemedSouls,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_REDEEMED_SOUL)
			local color = (amount == 0) and colors.grey or colors.white
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
}


-- ** Miscellaneous **
columns["GuildName"] = {
	-- Header
	headerWidth = 120,
	headerLabel = format("%s  %s", FormatTexture("Interface\\Icons\\inv_shirt_guildtabard_01"), GUILD),
	tooltipTitle = L["COLUMN_GUILD_TITLE"],
	tooltipSubTitle = L["COLUMN_GUILD_SUBTITLE"],
	headerOnClick = function() SortView("GuildName") end,
	headerSort = GetGuildOrRank,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character) 
		local guildName, guildRank = DataStore:GetGuildInfo(character)
		
		if addon:GetOption("UI.Tabs.Summary.ShowGuildRank") then
			return FormatGreyIfEmpty(guildRank)
		else
			return FormatGreyIfEmpty(guildName, colors.green)
		end
	end,
	
	OnClick = function(frame, button)
			addon:ToggleOption(nil, "UI.Tabs.Summary.ShowGuildRank")
			addon.Summary:Update()
		end,	
}

columns["Hearthstone"] = {
	-- Header
	headerWidth = 120,
	headerLabel = format("%s  %s",	FormatTexture("Interface\\Icons\\inv_misc_rune_01"), L["COLUMN_HEARTHSTONE_TITLE"]),
	tooltipTitle = L["COLUMN_HEARTHSTONE_TITLE"],
	tooltipSubTitle = L["COLUMN_HEARTHSTONE_SUBTITLE"],
	headerOnClick = function() SortView("Hearthstone") end,
	headerSort = DataStore.GetBindLocation,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character) 
		return FormatGreyIfEmpty(DataStore:GetBindLocation(character))
	end,
}

columns["ClassAndSpec"] = {
	-- Header
	headerWidth = 160,
	headerLabel = format("%s   %s / %s", FormatTexture("Interface\\Icons\\Spell_Nature_NatureGuardian"), CLASS, SPECIALIZATION),
	tooltipTitle = format("%s / %s", CLASS, SPECIALIZATION),
	tooltipSubTitle = L["COLUMN_CLASS_SUBTITLE"],
	headerOnClick = function() SortView("ClassAndSpec") end,
	headerSort = DataStore.GetCharacterClass,
	
	-- Content
	Width = 160,
	JustifyH = "CENTER",
	GetText = function(character)
	
		local class = DataStore:GetCharacterClass(character)
		local spec = DataStore:GetActiveSpecInfo(character)
		local color = DataStore:GetCharacterClassColor(character)
		
		return format("%s%s |r/ %s", color, class, FormatGreyIfEmpty(spec, color))
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Talents", character) then
				return
			end
			
			-- Exit if no specialization yet
			local specName, specIndex, role = DataStore:GetActiveSpecInfo(character)
			if not specIndex or not specName or specName == "" then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), SPECIALIZATION)			-- Warlock
			tt:AddDoubleLine(
				format("%s%s", DataStore:GetCharacterClassColor(character), specName), 
				_G[role])

			tt:AddLine(" ")
			
			local _, class = DataStore:GetCharacterClass(character)
			
			DataStore:IterateTalentTiers(function(tierIndex, level) 
				
				-- Get the selected talent in this tier ..
				local choice = DataStore:GetSpecializationTierChoice(character, specIndex, tierIndex)
				
				-- Has talent been set yet ?
				if choice == 0 then
					tt:AddLine(format("%s%d: |r%s", colors.green, level, TALENT_NOT_SELECTED ))
				else
					-- .. then get the talent information ..
					local _, talentName, icon = DataStore:GetTalentInfo(class, specIndex, tierIndex, choice)
					if talentName and icon then
						tt:AddLine(format("%s%d: %s %s%s", colors.green, level, FormatTexture(icon), colors.white, talentName))
					else
						-- it may occasionally happen that information is no longer is the cache
						tt:AddLine(format("%s%d: %s-", colors.green, level, colors.white))
					end
				end
			end)

			tt:Show()
		end,
	
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			if not character then return end

			-- Exit if no specialization yet
			local spec = DataStore:GetActiveSpecInfo(character)
			if not spec or spec == "" then return end

			addon.Tabs:OnClick("Characters")
			addon.Tabs.Characters:SetAltKey(character)
			addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
			addon.Tabs.Characters:ViewCharInfo(VIEW_TALENTS)
		end,	
}


-- ** Keystones **
columns["KeyName"] = {
	-- Header
	headerWidth = 100,
	headerLabel = format("%s  %s", FormatTexture("Interface\\Icons\\inv_relics_hourglass"), L["COLUMN_KEYNAME_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_KEYNAME_TITLE"],
	tooltipSubTitle = L["COLUMN_KEYNAME_SUBTITLE"],
	headerOnClick = function() SortView("KeyName") end,
	headerSort = DataStore.GetKeystoneName,
	
	-- Content
	Width = 100,
	JustifyH = "CENTER",
	GetText = function(character) 
		return FormatGreyIfEmpty(DataStore:GetKeystoneName(character))
	end,
}

columns["KeyLevel"] = {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_LEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_KEYLEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_KEYLEVEL_SUBTITLE"],
	headerOnClick = function() SortView("KeyLevel") end,
	headerSort = DataStore.GetKeystoneLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetKeystoneLevel(character) or 0
		local color = (level == 0) and colors.grey or colors.yellow
	
		return format("%s%d", color, level)	
	end,
}

columns["WeeklyBestKeyName"] = {
	-- Header
	headerWidth = 110,
	headerLabel = format("%s  %s", FormatTexture("Interface\\Icons\\achievement_challengemode_gold"), CHALLENGE_MODE_WEEKLY_BEST),
	tooltipTitle = L["COLUMN_WEEKLYBEST_KEYNAME_TITLE"],
	tooltipSubTitle = L["COLUMN_WEEKLYBEST_KEYNAME_SUBTITLE"],
	headerOnClick = function() SortView("WeeklyBestKeyName") end,
	headerSort = DataStore.GetWeeklyBestKeystoneName,
	
	-- Content
	Width = 110,
	JustifyH = "CENTER",
	GetText = function(character) 
		return FormatGreyIfEmpty(DataStore:GetWeeklyBestKeystoneName(character))
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Stats", character) then
				return
			end
			
			local level = DataStore:GetWeeklyBestKeystoneLevel(character) or 0
			if level == 0 then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), CHALLENGE_MODE_WEEKLY_BEST)
			tt:AddLine(" ")
			
			for _, map in pairs(DataStore:GetWeeklyBestMaps(character)) do
				tt:AddDoubleLine(format("%s %s %s+%d", FormatTexture(map.texture), map.name, colors.green, map.level), FormatDuration(map.timeInSeconds))
			end

			tt:Show()
		end,	
}

columns["WeeklyBestKeyLevel"] = {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_LEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_WEEKLYBEST_KEYLEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_WEEKLYBEST_KEYLEVEL_SUBTITLE"],
	headerOnClick = function() SortView("WeeklyBestKeyLevel") end,
	headerSort = DataStore.GetWeeklyBestKeystoneLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetWeeklyBestKeystoneLevel(character) or 0
		local color = (level == 0) and colors.grey or colors.yellow
	
		return format("%s%d", color, level)	
	end,
}

columns["WeeklyBestKeyTime"] = {
	-- Header
	headerWidth = 90,
	headerLabel = format("%s  %s", FormatTexture("Interface\\Icons\\spell_holy_borrowedtime"), BEST),
	tooltipTitle = L["COLUMN_WEEKLYBEST_KEYTIME_TITLE"],
	tooltipSubTitle = L["COLUMN_WEEKLYBEST_KEYTIME_SUBTITLE"],
	headerOnClick = function() SortView("WeeklyBestKeyTime") end,
	headerSort = DataStore.GetWeeklyBestKeystoneTime,

	-- Content
	Width = 90,
	JustifyH = "CENTER",
	GetText = function(character) 
		local seconds = DataStore:GetWeeklyBestKeystoneTime(character) or 0
		return FormatDuration(seconds)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Stats", character) then
				return
			end
			
			local level = DataStore:GetWeeklyBestKeystoneLevel(character) or 0
			if level == 0 then return end
			
			local tt = AltoTooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), MYTHIC_PLUS_SEASON_BEST)
			tt:AddLine(" ")
			
			for _, map in pairs(DataStore:GetSeasonBestMaps(character)) do
				tt:AddDoubleLine(format("%s %s %s+%d", FormatTexture(map.texture), map.name, colors.green, map.level), FormatDuration(map.timeInSeconds))
			end
			
			
			local maps = DataStore:GetSeasonBestMapsOvertime(character)

			if DataStore:GetHashSize(maps) > 0 then
				tt:AddLine(" ")
				tt:AddLine(MYTHIC_PLUS_OVERTIME_SEASON_BEST, 1, 1, 1)
				tt:AddLine(" ")
			
				for _, map in pairs(maps) do
					tt:AddDoubleLine(format("%s %s %s+%d", FormatTexture(map.texture), map.name, colors.green, map.level), FormatDuration(map.timeInSeconds))
				end			
			end

			tt:Show()
		end,	
}



local function ColumnHeader_OnEnter(frame)
	local column = frame.column
	if not frame.column then return end		-- invalid data ? exit
	
	local tooltip = AltoTooltip
	
	tooltip:ClearLines()
	tooltip:SetOwner(frame, "ANCHOR_BOTTOM")
	
	-- Add the tooltip title
	if column.tooltipTitle then
		tooltip:AddLine(column.tooltipTitle)
	end

	-- Add the tooltip subtitle in cyan
	if column.tooltipSubTitle then
		tooltip:AddLine(column.tooltipSubTitle, 0, 1, 1)
	end

	-- Add the extra tooltip content, if any
	if column.headerOnEnter then
		column.headerOnEnter(frame, tooltip)
	end
	
	tooltip:Show()
end

local modes = {
	[MODE_SUMMARY] = { "Name", "Level", "RestXP", "Money", "Played", "AiL", "LastOnline" },
	[MODE_BAGS] = { "Name", "Level", "BagSlots", "FreeBagSlots", "BankSlots", "FreeBankSlots" },
	[MODE_SKILLS] = { "Name", "Level", "Prof1", "Prof2", "ProfCooking", "ProfFishing", "ProfArchaeology", "Riding" },
	-- [MODE_SKILLS] = { "Name", "Level", "ProfCooking", "ProfFishing", "ProfArchaeology" },
	[MODE_ACTIVITY] = { "Name", "Level", "Mails", "LastMailCheck", "Auctions", "Bids", "AHLastVisit", "MissionTableLastVisit" },
	-- [MODE_CURRENCIES] = { "Name", "Level", "CurrencyGarrison", "CurrencyNethershard", "CurrencyLegionWarSupplies", "CurrencySOBF", "CurrencyOrderHall" },
	-- [MODE_CURRENCIES] = { "Name", "Level", "CurrencyBfAWarResources", "CurrencyBfASOWF", "CurrencyBfADubloons", "CurrencyBfAWarSupplies", "CurrencyBfARichAzerite" },
	[MODE_CURRENCIES] = { "Name", "Level", "CurrencyStygia", "CurrencyValor", "CurrencyConquest", "CurrencySoulAsh" },
	[MODE_FOLLOWERS] = { "Name", "Level", "FollowersLV40", "FollowersEpic", "FollowersLV630", "FollowersLV660", "FollowersLV675", "FollowersItems" },
	[MODE_COVENANT] = { "Name", "Level", "CovenantName", "SoulbindName", "Renown", "CampaignProgress", "CurrencyAnima", "CurrencyRedeemedSoul" },
	[MODE_MISCELLANEOUS] = { "Name", "Level", "GuildName", "Hearthstone", "ClassAndSpec" },
	[MODE_KEYSTONES] = { "Name", "Level", "KeyName", "KeyLevel", "WeeklyBestKeyName", "WeeklyBestKeyLevel", "WeeklyBestKeyTime" },
}

function ns:SetMode(mode)
	addon:SetOption("UI.Tabs.Summary.CurrentMode", mode)
	
	local parent = AltoholicTabSummary
	
	-- add the appropriate columns for this mode
	for i = 1, #modes[mode] do
		local columnName = modes[mode][i]
		local column = columns[columnName]
		
		parent.SortButtons:SetButton(i, column.headerLabel, column.headerWidth, column.headerOnClick)
		
		local button = parent.SortButtons["Sort"..i]
		button.column = column
		button:SetScript("OnEnter", ColumnHeader_OnEnter)
		button:SetScript("OnLeave", function() AltoTooltip:Hide() end)
	end
end

function ns:Update()
	local frame = AltoholicFrameSummary
	local scrollFrame = frame.ScrollFrame
	local numRows = scrollFrame.numRows
	local offset = scrollFrame:GetOffset()

	local isRealmShown
	local numVisibleRows = 0
	local numDisplayedRows = 0

	local sortOrder = addon:GetOption("UI.Tabs.Summary.SortAscending")
	local currentColumn = addon:GetOption("UI.Tabs.Summary.CurrentColumn")
	local currentModeIndex = addon:GetOption("UI.Tabs.Summary.CurrentMode")
	local currentMode = modes[currentModeIndex]
	
	-- rebuild and get the view, then sort it
	Characters:InvalidateView()
	local view = Characters:GetView()
	if columns[currentColumn] then	-- an old column name might still be in the DB.
		Characters:Sort(sortOrder, columns[currentColumn].headerSort)
	end

	-- attempt to restore the arrow to the right sort button
	local container = AltoholicTabSummary.SortButtons
	for i = 0, #currentMode do
		if currentMode[i] == currentColumn then
			container["Sort"..i]:DrawArrow(sortOrder)
		end
	end
	
	local rowIndex = 1
	local item
	
	for _, line in pairs(view) do
		local rowFrame = scrollFrame:GetRow(rowIndex)
		local lineType = Characters:GetLineType(line)
		
		if (offset > 0) or (numDisplayedRows >= numRows) then		-- if the line will not be visible
			if lineType == INFO_REALM_LINE then								-- then keep track of counters
				if not Characters:IsRealmCollapsed(line) then
					isRealmShown = true
				else
					isRealmShown = false
				end
				
				numVisibleRows = numVisibleRows + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif isRealmShown then
				numVisibleRows = numVisibleRows + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if lineType == INFO_REALM_LINE then
				local _, realm, account = Characters:GetInfo(line)
				
				if not Characters:IsRealmCollapsed(line) then
					isRealmShown = true
				else
					isRealmShown = false
				end
				rowFrame:DrawRealmLine(line, realm, account, Name_OnClick)
			
				rowIndex = rowIndex + 1
				numVisibleRows = numVisibleRows + 1
				numDisplayedRows = numDisplayedRows + 1
			elseif isRealmShown then
				if (lineType == INFO_CHARACTER_LINE) then
					rowFrame:DrawCharacterLine(line, columns, currentMode)
				elseif (lineType == INFO_TOTAL_LINE) then
					rowFrame:DrawTotalLine(line, columns, currentMode)
				end

				rowIndex = rowIndex + 1
				numVisibleRows = numVisibleRows + 1
				numDisplayedRows = numDisplayedRows + 1
			end
		end
	end
	
	while rowIndex <= numRows do
		local rowFrame = scrollFrame:GetRow(rowIndex) 
		
		rowFrame:SetID(0)
		rowFrame:Hide()
		rowIndex = rowIndex + 1
	end

	scrollFrame:Update(numVisibleRows)
end

function addon:AiLTooltip()
	local tt = AltoTooltip
	
	tt:AddLine(" ")
	
-- https://www.wowhead.com/guides/shadowlands-season-1-mythic-dungeon-guide-affix-changes	
	
-- Keystone Level	End of Dungeon	Weekly Great Vault
-- Mythic 2	187	200
-- Mythic 3	190	203
-- Mythic 4	194	207
-- Mythic 5	194	210
-- Mythic 6	197	210
-- Mythic 7	200	213
-- Mythic 8	200	216
-- Mythic 9	200	216
-- Mythic 10	203	220
-- Mythic 11	203	220
-- Mythic 12	207	223
-- Mythic 13	207	223
-- Mythic 14	207	226
-- Mythic 15	210	226	

-- CHALLENGE_MODE_ITEM_POWER_LEVEL = "Mythic Level %d";
-- PVP_WEEKLY_REWARD = "Weekly Reward";
-- RATED_PVP_WEEKLY_VAULT = "Weekly Vault";

	-- tt:AddDoubleLine(
		-- format("%s (%s)", format(CHALLENGE_MODE_ITEM_POWER_LEVEL, 2), FormatAiL("187")),
		-- )
	
	
	tt:AddDoubleLine(format("%s%s", colors.teal, EXPANSION_NAME0), FormatAiL("1-62"))
	tt:AddDoubleLine(format("%s%s", colors.teal, EXPANSION_NAME1), FormatAiL("63-94"))
	tt:AddDoubleLine(format("%s%s", colors.teal, EXPANSION_NAME2), FormatAiL("95-102"))
	tt:AddDoubleLine(format("%s%s", colors.teal, EXPANSION_NAME3), FormatAiL("103-114"))
	tt:AddDoubleLine(format("%s%s", colors.teal, EXPANSION_NAME4), FormatAiL("115-130"))
	tt:AddDoubleLine(format("%s%s", colors.teal, EXPANSION_NAME5), FormatAiL("131-149"))
	tt:AddDoubleLine(format("%s%s", colors.teal, EXPANSION_NAME6), FormatAiL("150-265"))
	tt:AddDoubleLine(format("%s%s", colors.teal, EXPANSION_NAME7), FormatAiL("266+"))
end
