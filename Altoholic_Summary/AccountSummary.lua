local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LCC = LibStub("LibCraftCategories-1.0")

local MODE_SUMMARY = 1
local MODE_BAGS = 2
local MODE_SKILLS = 3
local MODE_ACTIVITY = 4
local MODE_CURRENCIES = 5
local MODE_FOLLOWERS = 6
local MODE_KEYSTONES = 7
local MODE_HEARTHSTONE = 8
local MODE_GEAR = 9

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
local CURRENCY_ID_BFA_COAL_VISIONS = 1755
local CURRENCY_ID_BFA_TITAN_RESIDUUM = 1718

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2
local THIS_ACCOUNT = "Default"

local VIEW_BAGS = 1
local VIEW_QUESTS = 2
local VIEW_AUCTIONS = 4
local VIEW_BIDS = 5
local VIEW_MAILS = 6
local VIEW_COMPANIONS = 7
local VIEW_SPELLS = 8
local VIEW_PROFESSION = 9
local VIEW_GARRISONS = 10

local TEXTURE_FONT = "|T%s:%s:%s|t"

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

local skillColors = { colors.recipeGrey, colors.red, colors.orange, colors.yellow, colors.green }

local function GetSkillRankColor(rank, skillCap)
	rank = rank or 0
	skillCap = skillCap or SKILL_CAP
    if skillCap == 0 then return colors.recipeGrey end
	return skillColors[ floor(rank / (skillCap/4)) + 1 ]
end

local function TradeskillHeader_OnEnter(frame, tooltip)
	tooltip:AddLine(" ")
	tooltip:AddLine(format("%s%s|r %s %s", colors.recipeGrey, L["COLOR_GREY"], L["up to"], (floor(SKILL_CAP*0.25)-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s", colors.red, RED_GEM, L["up to"], (floor(SKILL_CAP*0.50)-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s", colors.orange, L["COLOR_ORANGE"], L["up to"], (floor(SKILL_CAP*0.75)-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s", colors.yellow, YELLOW_GEM, L["up to"], (SKILL_CAP-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s %s", colors.green, L["COLOR_GREEN"], L["at"], SKILL_CAP, L["and above"]),1,1,1)
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
						local color = (maxRank == 0) and colors.red or colors.green
						tt:AddDoubleLine(name, format("%s%s|r / %s%s", color, rank, color, maxRank))
					-- else
						-- tt:AddLine(name)
					end
				end
			
				local orange, yellow, green, grey = DataStore:GetNumRecipesByColor(profession)
				
				tt:AddLine(" ")
				tt:AddLine(orange+yellow+green+grey .. " " .. TRADESKILL_SERVICE_LEARN,1,1,1)
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
	tt:SetHyperlink(C_CurrencyInfo.GetCurrencyLink(currencyID,0))
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

local function ExcludeRealm(self, characterInfoLine)
    local _, realm, account = Characters:GetInfo(characterInfoLine)

    addon:SetOption(format("UI.Tabs.Summary.ExcludeRealms.%s.%s", account, realm), not addon:GetOption(format("UI.Tabs.Summary.ExcludeRealms.%s.%s", account, realm)))
    addon.Characters.InvalidateView()
    addon.Summary:Update()
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
        frame:AddTitle()
        frame:AddButtonWithArgs("Exclude this realm from totals", nil, ExcludeRealm, characterInfoLine, nil, addon:GetOption(format("UI.Tabs.Summary.ExcludeRealms.%s.%s", account, realm)))
		return
	end

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

			return format("%s %s (%s)", format(TEXTURE_FONT, icon, 18, 18), name, class)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local tt = AltoTooltip
		
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), DataStore:GetColoredCharacterFaction(character))
			if DataStore:GetCharacterRealm(character) then
                tt:AddLine("Realm: "..colors.green..DataStore:GetCharacterRealm(character))
            end
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
				tt:AddLine(colors.teal .. suggestion,1,1,1)
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
	headerWidth = 50,
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
    OnTotalClick = function(frame, button)
            addon:ToggleOption(nil, "UI.Tabs.Summary.ShowLevelTotalAverage")
            addon.Summary:Update()
        end,
}

columns["RestXP"] = {
	-- Header
	headerWidth = 60,
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
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		if DataStore:GetCharacterLevel(character) == MAX_PLAYER_LEVEL then
			return colors.white .. "0%"	-- show 0% at max level
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
	headerWidth = 120,
	headerLabel = L["COLUMN_MONEY_TITLE_SHORT"],
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
	headerWidth = 80,
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
		
		return format("%s%s", colors.white, addon:FormatDelay(DataStore:GetLastLogout(character)))
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
				text = format("%s: %s", LASTONLINE, SecondsToTime(time() - DataStore:GetLastLogout(character)))
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
	headerLabel = L["COLUMN_BAGS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_BAGS_TITLE"],
	tooltipSubTitle = L["COLUMN_BAGS_SUBTITLE_"..random(2)],
	headerOnClick = function() SortView("BagSlots") end,
	headerSort = DataStore.GetNumBagSlots,
	
	-- Content
	Width = 100,
	JustifyH = "CENTER",
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
	headerLabel = L["COLUMN_BANK_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_BANK_TITLE"],
	tooltipSubTitle = L["COLUMN_BANK_SUBTITLE_"..random(2)],
	headerOnClick = function() SortView("BankSlots") end,
	headerSort = DataStore.GetNumBankSlots,
	
	-- Content
	Width = 160,
	JustifyH = "CENTER",
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

columns["FreeReagentBankSlots"] = { 
	-- Header
	headerWidth = 80,
	headerLabel = L["COLUMN_FREEREAGENTBANKSLOTS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FREEREAGENTBANKSLOTS_TITLE"],
	tooltipSubTitle = L["COLUMN_FREEREAGENTBANKSLOTS_SUBTITLE"],
	headerOnClick = function(frame)	SortView("FreeReagentBankSlots") end,
	headerSort = DataStore.GetNumFreeReagentBankSlots,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			local numFree = DataStore:GetNumFreeReagentBankSlots(character) or 0
			local color = ((numFree / 98) <= 0.1) and colors.red or colors.green
			
			return format("%s%s|r/%s%s", color, numFree, colors.cyan, 98)
		end,
}

columns["FreeVoidStorageSlots"] = {
	-- Header
	headerWidth = 120,
	headerLabel = L["COLUMN_FREEVOIDSTORAGESLOTS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FREEVOIDSTORAGESLOTS_TITLE"],
	tooltipSubTitle = L["COLUMN_FREEVOIDSTORAGESLOTS_SUBTITLE"],
	headerOnClick = function(frame)	SortView("FreeVoidStorageSlots") end,
	headerSort = DataStore.GetNumFreeVoidStorageSlots,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			local numFree = DataStore:GetNumFreeVoidStorageSlots(character) or 0
			local color = ((numFree / 160) <= 0.1) and colors.red or colors.green
			
			return format("%s%s|r/%s%s", color, numFree, colors.cyan, 160)
		end,
}

-- ** Skills **
local professionExpansion = addon:GetOption("UI.Tabs.Summary.ProfessionExpansion") or 0

local function ProfessionSelected(self, newExpansionID)
    addon:SetOption("UI.Tabs.Summary.ProfessionExpansion", newExpansionID)
    professionExpansion = newExpansionID
    self:GetParent():Close()
    addon.Summary:Update()
    ns:SetMode(addon:GetOption("UI.Tabs.Summary.CurrentMode"))
end

local function ProfessionRightClickMenu_Initialize(frame)
    frame:AddTitle("Select Expansion:")
    frame:AddTitle()
    
    if professionExpansion == 0 then
        frame:AddButtonWithArgs("All", 0, ProfessionSelected, 0, nil, true)
    else
        frame:AddButtonWithArgs("All", 0, ProfessionSelected, 0)
    end
    
    for expansionIndex = 1, EJ_GetNumTiers() do
        local expansionName = EJ_GetTierInfo(expansionIndex)
        if professionExpansion == expansionIndex then
            frame:AddButtonWithArgs(expansionName, expansionIndex, ProfessionSelected, expansionIndex, nil, true)
        else
            frame:AddButtonWithArgs(expansionName, expansionIndex, ProfessionSelected, expansionIndex)
        end
    end
    
    frame:AddCloseMenu()
end

for profIndex = 1, 2 do
    columns["Prof"..profIndex] = {
    	-- Header
    	headerWidth = 70,
    	headerLabel = L["COLUMN_PROFESSION_"..profIndex.."_TITLE_SHORT"],
    	tooltipTitle = L["COLUMN_PROFESSION_"..profIndex.."_TITLE"],
    	tooltipSubTitle = nil,
    	headerOnEnter = TradeskillHeader_OnEnter,
    	headerOnClick = function() SortView("Prof"..profIndex) end,
    	headerSort = DataStore["GetProfession"..profIndex],
    	
    	-- Content
    	Width = 70,
    	JustifyH = "CENTER",
    	GetText = function(character)
    			local rank, maxRank, _, name = DataStore["GetProfession"..profIndex](DataStore, character)
                
                if professionExpansion > 0 then
                    local found = false
                    local profession = DataStore:GetProfession(character, name)
                    if profession then
                        for i = 1, DataStore:GetNumRecipeCategories(profession) do
                            _, categoryName, rank, maxRank = DataStore:GetRecipeCategoryInfo(profession, i)
                            if LCC.categoryNameToExpansionID(categoryName) == professionExpansion then
                                found = true
                                break
                            end
                        end
                    end
                    -- player hasn't learned this category yet
                    if not found then
                        rank = 0
                        maxRank = 0
                    end
                end
                
                local rankColor = GetSkillRankColor(rank, maxRank) 
    			local spellID = DataStore:GetProfessionSpellID(name)
    			local icon = spellID and format(TEXTURE_FONT, addon:GetSpellIcon(spellID), 18, 18) .. " " or ""
                rank = rank or 0
    			
    			return format("%s%s%s", icon, rankColor, rank)
    		end,
    	OnEnter = function(frame)
    			local character = frame:GetParent().character
    			local _, _, _, skillName = DataStore["GetProfession"..profIndex](DataStore, character)
    			Tradeskill_OnEnter(frame, skillName, true)
    		end,
    	OnClick = function(frame, button)
    			if button == "LeftButton" then
                    local character = frame:GetParent().character
    			    local _, _, _, skillName = DataStore["GetProfession"..profIndex](DataStore, character)
    			    Tradeskill_OnClick(frame, skillName)
                elseif button == "RightButton" then
                	local scrollFrame = frame:GetParent():GetParent().ScrollFrame
                	local menu = scrollFrame:GetParent():GetParent().ContextualMenu
                	local offset = scrollFrame:GetOffset()
                		
                	menu:Initialize(ProfessionRightClickMenu_Initialize, "MENU_WITH_BORDERS", 1)
                	menu:Close()
                	menu:Toggle(frame, frame:GetWidth() - 20, 10)
                			
                	return                
                end
    		end,
    }
end

columns["ProfCooking"] = {
	-- Header
	headerWidth = 60,
	headerLabel = "   " .. format(TEXTURE_FONT, addon:GetSpellIcon(2550), 18, 18),
	tooltipTitle = GetSpellInfo(2550),
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerOnClick = function() SortView("ProfCooking") end,
	headerSort = DataStore.GetCookingRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
    		local rank, maxRank = DataStore:GetCookingRank(character)
            local name = GetSpellInfo(2550)
            
            if professionExpansion > 0 then
                local found = false
                local profession = DataStore:GetProfession(character, name)
                if profession then
                    for i = 1, DataStore:GetNumRecipeCategories(profession) do
                        _, categoryName, rank, maxRank = DataStore:GetRecipeCategoryInfo(profession, i)
                        if LCC.categoryNameToExpansionID(categoryName) == professionExpansion then
                            found = true
                            break
                        end
                    end
                end
                -- player hasn't learned this category yet
                if not found then
                    rank = 0
                    maxRank = 0
                end
            end
            
            local rankColor = GetSkillRankColor(rank, maxRank) 
			local spellID = DataStore:GetProfessionSpellID(name)
			local icon = spellID and format(TEXTURE_FONT, addon:GetSpellIcon(spellID), 18, 18) .. " " or ""
            rank = rank or 0
			
			return format("%s%s", rankColor, rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(2550), true)
		end,
	OnClick = function(frame, button)
      		if button == "LeftButton" then
		        Tradeskill_OnClick(frame, GetSpellInfo(2550))
              elseif button == "RightButton" then
              	local scrollFrame = frame:GetParent():GetParent().ScrollFrame
              	local menu = scrollFrame:GetParent():GetParent().ContextualMenu
              	local offset = scrollFrame:GetOffset()
              		
              	menu:Initialize(ProfessionRightClickMenu_Initialize, "MENU_WITH_BORDERS", 1)
              	menu:Close()
              	menu:Toggle(frame, frame:GetWidth() - 20, 10)
              			
              	return                
              end
		end,
}

columns["ProfFishing"] = {
	-- Header
	headerWidth = 60,
	headerLabel = "   " .. format(TEXTURE_FONT, addon:GetSpellIcon(131474), 18, 18),
	tooltipTitle = GetSpellInfo(131474),
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerOnClick = function() SortView("ProfFishing") end,
	headerSort = DataStore.GetFishingRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
        	local rank, maxRank = DataStore:GetFishingRank(character)
            local name = GetSpellInfo(131474)
            
            if professionExpansion > 0 then
                local found = false
                local profession = DataStore:GetProfession(character, name)
                if profession then
                    for i = 1, DataStore:GetNumRecipeCategories(profession) do
                        _, categoryName, rank, maxRank = DataStore:GetRecipeCategoryInfo(profession, i)
                        if LCC.categoryNameToExpansionID(categoryName) == professionExpansion then
                            found = true
                            break
                        end
                    end
                end
                -- player hasn't learned this category yet
                if not found then
                    rank = 0
                    maxRank = 0
                end
            end
            
            local rankColor = GetSkillRankColor(rank, maxRank) 
			local spellID = DataStore:GetProfessionSpellID(name)
			local icon = spellID and format(TEXTURE_FONT, addon:GetSpellIcon(spellID), 18, 18) .. " " or ""
            rank = rank or 0
			
			return format("%s%s", rankColor, rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(131474), true)
		end,
    OnClick = function(frame, button)
          	if button == "RightButton" then
              	local scrollFrame = frame:GetParent():GetParent().ScrollFrame
              	local menu = scrollFrame:GetParent():GetParent().ContextualMenu
              	local offset = scrollFrame:GetOffset()
              		
              	menu:Initialize(ProfessionRightClickMenu_Initialize, "MENU_WITH_BORDERS", 1)
              	menu:Close()
              	menu:Toggle(frame, frame:GetWidth() - 20, 10)
              			
              	return                
            end
        end,
}

columns["ProfArchaeology"] = {
	-- Header
	headerWidth = 60,
	headerLabel = "   " .. format(TEXTURE_FONT, addon:GetSpellIcon(78670), 18, 18),
	tooltipTitle = GetSpellInfo(78670),
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerOnClick = function() SortView("ProfArchaeology") end,
	headerSort = DataStore.GetArchaeologyRank,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local rank = DataStore:GetArchaeologyRank(character) or 0
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame)
			Tradeskill_OnEnter(frame, GetSpellInfo(78670))
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
            tt:AddLine(format("%s%s %s%d", colors.white, L["Mails found:"], colors.green, num))
			
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
			tt:AddLine(format("%s%d %s%s", colors.green, numReturned, colors.white, L["will be returned upon expiry"]))
			if closestReturn then
 				tt:AddLine(format(colors.white..L["CLOSEST_RETURN_IN_PATTERN"], colors.green..SecondsToTime(closestReturn))) 
			end
			
			if numDeleted > 0 then
				tt:AddLine(" ")
                tt:AddLine(format(L["MAIL_WILL_BE_DELETED_PATTERN"], numDeleted))
				if closestDelete then
 					tt:AddLine(format(colors.white..L["CLOSEST_DELETION_IN_PATTERN"], colors.green..SecondsToTime(closestDelete))) 
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
									(DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0) or 0)
			local numActive = (DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0) or 0) + 
									(DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0) or 0)
			local numCompleted = (DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0) or 0) + 
										(DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0) or 0)
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
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), WAR_MISSIONS)
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
            
            -- **War Campaign Missions **
            
			numAvail = DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0) or 0
			numActive = DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0) or 0
			numCompleted = DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0) or 0			
			color = colors.green
			
			tt:AddLine(L["War Campaign Missions"]) -- Couldn't find a GlobalString for "War Campaign Missions". How long until someone playing in another language complains?
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

local defaultCurrencies = {
    CURRENCY_ID_BFA_WAR_RES,
    CURRENCY_ID_BFA_SOWF,
    CURRENCY_ID_BFA_DUBLOONS,
    CURRENCY_ID_BFA_COAL_VISIONS,
    CURRENCY_ID_BFA_TITAN_RESIDUUM
}

-- ** Currencies **
for currencyIndex = 1, 5 do
    local currencyID = addon:GetOption("UI.Tabs.Summary.Currency"..currencyIndex) or defaultCurrencies[currencyIndex]
    
    local function CurrencySelected(self, newCurrencyID)
        addon:SetOption("UI.Tabs.Summary.Currency"..currencyIndex, newCurrencyID)
        currencyID = newCurrencyID
        self:GetParent():Close()
        columns["Currency"..currencyIndex]["headerLabel"] = "         " .. format(TEXTURE_FONT, C_CurrencyInfo.GetBasicCurrencyInfo(currencyID).icon, 18, 18)
        addon.Summary:Update()
        ns:SetMode(addon:GetOption("UI.Tabs.Summary.CurrentMode"))
    end
    
    local function CurrencyRightClickMenu_Initialize(frame, level)
    	if level == 1 then
            frame:AddTitle("Select Currency:")
            frame:AddTitle()
            for currencyListIndex = 1, C_CurrencyInfo.GetCurrencyListSize() do
                local info = C_CurrencyInfo.GetCurrencyListInfo(currencyListIndex)
                local name, isHeader = info.name, info.isHeader
                if isHeader then
                    frame:AddCategoryButton(name, currencyListIndex, level)
                end
            end
            frame:AddCloseMenu()
        elseif level == 2 then
            for currencyListIndex = (frame:GetCurrentOpenMenuValue() + 1), C_CurrencyInfo.GetCurrencyListSize() do
                local info = C_CurrencyInfo.GetCurrencyListInfo(currencyListIndex)  
                local name, isHeader = info.name, info.isHeader 
                if not isHeader then
                    frame:AddButtonWithArgs(name, currencyListIndex, CurrencySelected, C_CurrencyInfo.GetCurrencyIDFromLink(C_CurrencyInfo.GetCurrencyListLink(currencyListIndex)), nil, false, level) 
                else
                    break
                end
            end
        end
    end

    columns["Currency"..currencyIndex] = {
    	-- Header
    	headerWidth = 80,
    	headerLabel = "         " .. format(TEXTURE_FONT, C_CurrencyInfo.GetBasicCurrencyInfo(currencyID).icon, 18, 18),
    	headerOnEnter = function(frame, tooltip)
    			CurrencyHeader_OnEnter(frame, currencyID)
    		end,
    	headerOnClick = function(button) SortView("Currency"..currencyIndex) end,
    	headerSort = function(self, character) return DataStore:GetCurrencyTotals(character, currencyID) end,
    	
    	-- Content
    	Width = 80,
    	JustifyH = "CENTER",
    	GetText = function(character)
    			local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, currencyID)
    			if not amount then amount = 0 end
                if totalMax and totalMax > 0 then
                    local color = (amount == 0) and colors.grey or colors.white
			        return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
                else
                    local color = (amount == 0) and colors.grey or colors.white
    			    return format("%s%s", color, amount)                
                end
            end,
        OnClick = function(frame, button)
                if button == "RightButton" then            		
            		local scrollFrame = frame:GetParent():GetParent().ScrollFrame
            		local menu = scrollFrame:GetParent():GetParent().ContextualMenu
            		local offset = scrollFrame:GetOffset()
            		
            		menu:Initialize(CurrencyRightClickMenu_Initialize, "MENU_WITH_BORDERS", 1)
            		menu:Close()
            		menu:Toggle(frame, frame:GetWidth() - 20, 10)
            			
            		return
	           end
            end,
    	OnEnter = function(frame)
    			local tt = AltoTooltip
    			tt:ClearLines()
    			tt:SetOwner(frame, "ANCHOR_RIGHT")
    			tt:AddLine(colors.green .. "Right-click to change the Currency.",1,1,1)
    			tt:Show()
    		end,
    }
end

-- ** Garrison Followers **
columns["FollowersLV100"] = {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_FOLLOWERS_LV100_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FOLLOWERS_LV100_TITLE"],
	tooltipSubTitle = L["COLUMN_FOLLOWERS_LV100_SUBTITLE"],
	headerOnClick = function() SortView("FollowersLV100") end,
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
	headerWidth = 85,
	headerLabel = L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FOLLOWERS_RARITY_TITLE"],
	tooltipSubTitle = L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"],
	headerOnClick = function() SortView("FollowersEpic") end,
	headerSort = GetRarityLevel,
	
	-- Content
	Width = 85,
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

columns["CurrentKeystoneName"] = {
	-- Header
	headerWidth = 100,
	headerLabel = L["COLUMN_CURRENT_KEYSTONE_NAME_SHORT"],
	tooltipTitle = L["COLUMN_CURRENT_KEYSTONE_NAME"],
	tooltipSubTitle = nil,
	headerOnClick = nil,
	headerSort = nil,
	
	-- Content
	Width = 100,
	JustifyH = "CENTER",
	GetText = function(character)
            local keystoneName = DataStore:GetCurrentKeystone(character)
            if not keystoneName then return end
			return colors.white .. keystoneName 
		end,
	OnEnter = function(frame)
		end,
}

columns["CurrentKeystoneLevel"] = {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_CURRENT_KEYSTONE_LEVEL_SHORT"],
	tooltipTitle = L["COLUMN_CURRENT_KEYSTONE_LEVEL"],
	tooltipSubTitle = nil,
	headerOnClick = nil,
	headerSort = nil,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
            local _, _, keystoneLevel = DataStore:GetCurrentKeystone(character)
            if not keystoneLevel then return end
			return colors.white .. keystoneLevel 
		end,
	OnEnter = function(frame)
		end,
}

columns["HighestKeystoneName"] = {
	-- Header
	headerWidth = 100,
	headerLabel = L["COLUMN_HIGHEST_KEYSTONE_NAME_SHORT"],
	tooltipTitle = L["COLUMN_HIGHEST_KEYSTONE_NAME"],
	tooltipSubTitle = nil,
	headerOnClick = nil,
	headerSort = nil,
	
	-- Content
	Width = 100,
	JustifyH = "CENTER",
	GetText = function(character)
            local keystoneName = DataStore:GetHighestKeystone(character)
            if not keystoneName then return end
			return colors.white .. keystoneName 
		end,
	OnEnter = function(frame)
		end,
}

columns["HighestKeystoneLevel"] = {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_HIGHEST_KEYSTONE_LEVEL_SHORT"],
	tooltipTitle = L["COLUMN_HIGHEST_KEYSTONE_LEVEL"],
	tooltipSubTitle = nil,
	headerOnClick = nil,
	headerSort = nil,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
            local _, _, keystoneLevel = DataStore:GetHighestKeystone(character)
            if not keystoneLevel then return end
			return colors.white .. keystoneLevel 
		end,
	OnEnter = function(frame)
		end,
}

columns["HighestKeystoneTime"] = {
	-- Header
	headerWidth = 120,
	headerLabel = L["COLUMN_HIGHEST_KEYSTONE_TIME_SHORT"],
	tooltipTitle = L["COLUMN_HIGHEST_KEYSTONE_TIME"],
	tooltipSubTitle = nil,
	headerOnClick = nil,
	headerSort = nil,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character)
            local _, keystoneTime = DataStore:GetHighestKeystone(character)
            if not keystoneTime then return end
            local seconds = math.floor(keystoneTime / 1000)
            local minutes = math.floor(seconds / 60)
            seconds = math.floor(seconds % 60)
			return format("%s%sm %ss", colors.white, minutes, seconds) 
		end,
	OnEnter = function(frame)
		end,
}

local hearthstoneName = "" 
local item = Item:CreateFromItemID(6948)
item:ContinueOnItemLoad(function()
	hearthstoneName = item:GetItemName()
end)

columns["BindLocation"] = {
	-- Header
	headerWidth = 120,
	headerLabel = hearthstoneName,
	tooltipTitle = L["Bind Location"],
	tooltipSubTitle = nil,
	headerOnClick = function() SortView("BindLocation") end,
	headerSort = DataStore.GetHearthstone,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character)
            local name = DataStore:GetHearthstone(character) or ""
			return format("%s%s", colors.white, name) 
		end,
	OnEnter = function(frame)
		end,
}

columns["ConquestPoints"] = {
	-- Header
	headerWidth = 80,
	headerLabel = PVP_CONQUEST,
	tooltipTitle = L["Conquest Points"],
	tooltipSubTitle = nil,
	headerOnClick = function() SortView("ConquestPoints") end,
	headerSort = DataStore.GetConquestPoints,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character)
            local count = DataStore:GetConquestPoints(character) or ""
            count = tonumber(count) or 0
            local color = colors.white
            if count >= 500 then
                color = colors.red
            end
			return format("%s%s", color, count) 
		end,
	OnEnter = function(frame)
		end,
}

columns["RenownLevel"] = {
	-- Header
	headerWidth = 90,
	headerLabel = COVENANT_SANCTUM_TAB_RENOWN,
	tooltipTitle = COVENANT_SANCTUM_TAB_RENOWN,
	tooltipSubTitle = nil,
	headerOnClick = function() SortView("RenownLevel") end,
	headerSort = DataStore.GetRenownLevel,
	
	-- Content
	Width = 90,
	JustifyH = "CENTER",
	GetText = function(character)
            local count = DataStore:GetRenownLevel(character) or 0
            count = tonumber(count) or 0
            local color = colors.white
            if count >= 40 then
                color = colors.green
            end
			return format("%s%s", color, count) 
		end,
	OnEnter = function(frame)
		end,
}

for i = 1, 19 do
    if i ~= 18 then
        -- Skip ranged slot
        columns["Equipment"..i] = {
        	-- Header
        	headerWidth = 25,
        	headerLabel = format(TEXTURE_FONT, addon:GetEquipmentSlotIcon(i), 18, 18),
        	tooltipTitle = nil,
        	tooltipSubTitle = nil,
        	headerOnEnter = function() end,
        	headerOnClick = function() end,
        	headerSort = nil,
        	
        	-- Content
        	Width = 25,
        	JustifyH = "CENTER",
        	GetText = function(character)
                    local item = DataStore:GetInventoryItem(character, i)
        			if item then
                        return format(TEXTURE_FONT, GetItemIcon(item), 18, 18)
                    else
                        return ""
                    end
        		end,
        	OnEnter = function(frame)
                    local character = frame:GetParent().character
                    local item = DataStore:GetInventoryItem(character, i)
                    if item then
                    	local tt = AltoTooltip
                    	
                    	tt:ClearLines()
                    	tt:SetOwner(frame, "ANCHOR_RIGHT")
                    	tt:SetHyperlink(item)
                        tt:Show()
                    end
        		end,
        	OnClick = function(frame, button)
        		end,
        }
    end
end

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
	[MODE_SKILLS] = { "Name", "Level", "Prof1", "Prof2", "ProfCooking", "ProfFishing", "ProfArchaeology" },
	[MODE_ACTIVITY] = { "Name", "Level", "Mails", "LastMailCheck", "Auctions", "Bids", "AHLastVisit", "MissionTableLastVisit" },
    [MODE_CURRENCIES] = { "Name", "Level", "Currency1", "Currency2", "Currency3", "Currency4", "Currency5" },
	[MODE_FOLLOWERS] = { "Name", "Level", "FollowersLV100", "FollowersEpic", "FollowersLV630", "FollowersLV660", "FollowersLV675", "FollowersItems" },
    [MODE_KEYSTONES] = { "Name", "CurrentKeystoneName", "CurrentKeystoneLevel", "HighestKeystoneName", "HighestKeystoneLevel", "HighestKeystoneTime" },
    [MODE_HEARTHSTONE] = { "Name", "BindLocation", "ConquestPoints", "RenownLevel", "FreeReagentBankSlots", "FreeVoidStorageSlots" },
    [MODE_GEAR] = {"Name", }
}

for i = 1, 19 do
    if i ~= 18 then
        table.insert(modes[MODE_GEAR], "Equipment"..i)
    end
end

function ns:SetMode(mode)
	addon:SetOption("UI.Tabs.Summary.CurrentMode", mode)
	
	local parent = AltoholicTabSummary
	
	-- add the appropriate columns for this mode
	for i = 1, #modes[mode] do
		local columnName = modes[mode][i]
		local column = columns[columnName]
		
		parent.SortButtons:SetButton(i, column.headerLabel, column.headerWidth, column.headerOnClick)
		parent.SortButtons["Sort"..i].column = column
		parent.SortButtons["Sort"..i]:SetScript("OnEnter", ColumnHeader_OnEnter)
		parent.SortButtons["Sort"..i]:SetScript("OnLeave", function() AltoTooltip:Hide() end)
	end
end

function ns:Update()
    AltoholicTabSummary_DesMephistoButton:SetText(L["Reset Filters"]) -- TODO: find a better home for this
    
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
                    rowIndex = rowIndex + 1
				    numVisibleRows = numVisibleRows + 1
				    numDisplayedRows = numDisplayedRows + 1
				elseif (lineType == INFO_TOTAL_LINE) then
					rowFrame:DrawTotalLine(line, columns, currentMode)
                    rowIndex = rowIndex + 1
				    numVisibleRows = numVisibleRows + 1
				    numDisplayedRows = numDisplayedRows + 1
				end
			end
		end
	end
	
	while rowIndex <= 50 do
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
	tt:AddDoubleLine(format("%s%s", colors.teal, "Intro (1-10)"), FormatAiL("1-44"))
	tt:AddDoubleLine(format("%s%s", colors.teal, "Chromie Time (11-49)"), FormatAiL("13-125"))
	tt:AddDoubleLine(format("%s%s", colors.teal, "Shadowlands (50-59)"), FormatAiL("59-164"))
	tt:AddDoubleLine(format("%s%s", colors.teal, "Shadowlands (60)"), FormatAiL("165+"))
end

AltoholicFrame:RegisterResizeEvent("AltoholicFrameSummary", 13, ns)