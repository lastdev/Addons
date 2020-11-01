if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    print("DataStore_Currencies does not support Classic WoW")
    return
end

--[[	*** DataStore_Currencies ***
Written by : Thaoky, EU-Marécages de Zangar
July 6th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Currencies"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local CURRENCY_ID_JUSTICE = 395
local CURRENCY_ID_VALOR = 1191
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
local CURRENCY_ID_CONQUEST = 1602

local AddonDB_Defaults = {
	global = {
		Reference = {
			Currencies = {},			-- ex: [1] = "Dungeon and Raid", [2] = "Justice Points", ...
			CurrencyTextRev = {},	-- reverse lookup

			Headers = {},			-- ex: [1] = "Dungeon and Raid", [2] = "Miscellaneous", ...
			HeadersRev = {},		-- reverse lookup of Headers
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Currencies = {},
				CurrencyInfo = {},
				Archeology = {},
			}
		}
	}
}

-- *** Utility functions ***
local headersState
local headerCount

local function SaveHeaders()
	headersState = {}
	headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.
	
	for i = C_CurrencyInfo.GetCurrencyListSize(), 1, -1 do		-- 1st pass, expand all categories
        local info = C_CurrencyInfo.GetCurrencyListInfo(i)
		local isHeader, isExpanded = info.isHeader, info.isHeaderExpanded
		if isHeader then
			headerCount = headerCount + 1
			if not isExpanded then
				C_CurrencyInfo.ExpandCurrencyList(i, 1)
				headersState[headerCount] = true
			end
		end
	end
end

local function RestoreHeaders()
	headerCount = 0
	for i = C_CurrencyInfo.GetCurrencyListSize(), 1, -1 do
		local isHeader = C_CurrencyInfo.GetCurrencyListInfo(i).isHeader
		if isHeader then
			headerCount = headerCount + 1
			if headersState[headerCount] then
				C_CurrencyInfo.ExpandCurrencyList(i, 0)		-- collapses the header
			end
		end
	end
	headersState = nil
end


-- *** Scanning functions ***
local function ScanCurrencyTotals(id, divWeekly, divTotal)
	local denomWeekly = divWeekly or 1
	local denomTotal = divTotal or 1
	
    local info = C_CurrencyInfo.GetCurrencyInfo(id) 
    local amount, earnedThisWeek, weeklyMax, totalMax = info.quantity, info.quantityEarnedThisWeek, info.maxWeeklyQuantity, info.maxQuantity
	
	weeklyMax = math.floor(weeklyMax / denomWeekly)
	totalMax = math.floor(totalMax / denomTotal)
	
	addon.ThisCharacter.CurrencyInfo[id] = format("%s-%s-%s-%s", amount or 0, earnedThisWeek or 0, weeklyMax or 0, totalMax or 0)
end

local function ScanTotals()
-- deprecated
end

local function ScanCurrencies()
	SaveHeaders()
	
	local ref = addon.db.global.Reference
	local currencies = addon.ThisCharacter.Currencies
	wipe(currencies)
	
	local refIndex

	for i = 1, C_CurrencyInfo.GetCurrencyListSize() do
        local info = C_CurrencyInfo.GetCurrencyListInfo(i)
		local name, isHeader, count, icon = info.name, info.isHeader, info.quantity, info.iconFileID
		
		if not ref.CurrencyTextRev[name] then		-- currency does not exist yet in our reference table
			table.insert(ref.Currencies, format("%s|%s", name, icon or "") )			-- ex; [3] = "PVP"
			ref.CurrencyTextRev[name] = #ref.Currencies		-- ["PVP"] = 3
		end
		
		if isHeader then
			count = 0
        else
            local currencyLink = C_CurrencyInfo.GetCurrencyListLink(i)
            if currencyLink then
                ScanCurrencyTotals(C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink))
            end        
		end

		currencies[i] = { ["isHeader"] = isHeader, ["index"] = ref.CurrencyTextRev[name], ["count"] = count }
	end
    
    local currentValue = PVPGetConquestLevelInfo()
    addon.ThisCharacter.Conquest = currentValue
	
	RestoreHeaders()
	
	addon.ThisCharacter.lastUpdate = time()
end

local function ScanArcheology()
	local currencies = addon.ThisCharacter.Archeology
	wipe(currencies)
	
	for i = 1, GetNumArchaeologyRaces() do
		-- Warning for extreme caution here: while testing MoP, the following line of code triggered an error while trying to activate a glyph.
		-- _, _, _, currencies[i] = GetArchaeologyRaceInfo(i)
		-- The work around is to simply unroll the code on two lines.. I'll have to investigate why
		-- At first sight, the problem seems to come from addressing the table element direcly, same has happened in DataStore_Stats.
		
		local _, _, _, n = GetArchaeologyRaceInfo(i)
		currencies[i] = n
	end

end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanCurrencies()
end

local function OnCurrencyDisplayUpdate()
	ScanCurrencies()
	ScanArcheology()
end

local function OnChatMsgSystem(event, arg)
	if arg and arg == ITEM_REFUND_MSG then
		ScanCurrencies()
		ScanArcheology()
	end
end

local function OnArtifactHistoryReady()
	ScanArcheology()
end

-- ** Mixins **
local function _GetNumCurrencies(character)
	return #character.Currencies
end

local function _GetCurrencyInfo(character, index)
	local ref = addon.db.global.Reference
	local currency = character.Currencies[index]
	
    if not currency then return false, "", 0, "" end
    if type(currency) ~= "table" then return false, "", 0, "" end -- backward compatibility workaround
	
    local isHeader = currency.isHeader
	local refIndex = currency.index
	local count = currency.count

	local info = ref.Currencies[refIndex]
	local name, icon = strsplit("|", info or "")
	
	return isHeader, name, count, icon
end

local function _GetCurrencyInfoByName(character, token)
	local ref = addon.db.global.Reference
	
	local isHeader, name, count, icon
	for i = 1, #character.Currencies do
		isHeader, name, count, icon = _GetCurrencyInfo(character, i)
	
		if name == token then
			return isHeader, name, count, icon
		end
	end
end

local function _GetCurrencyItemCount(character, searchedID)
	local _, _, count = _GetCurrencyInfo(character, searchedID)
    return count
end

local function _GetArcheologyCurrencyInfo(character, index)
	return character.Archeology[index] or 0
end

local function _GetCurrencyTotals(character, id)
	local info = character.CurrencyInfo[id]
	if not info then
		return 0, 0, 0, 0
	end

	local amount, earnedThisWeek, weeklyMax, totalMax = strsplit("-", info)
	return tonumber(amount), tonumber(earnedThisWeek), tonumber(weeklyMax), tonumber(totalMax)
end

local function _GetJusticePoints(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_JUSTICE)
end

local function _GetValorPoints(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_VALOR)
end

local function _GetValorPointsPerWeek(character)
	local info = character.CurrencyInfo[CURRENCY_ID_VALOR]
	if not info then
		return 0
	end
	
	local _, earnedThisWeek = strsplit("-", info)
	return tonumber(earnedThisWeek)
end

local function _GetGarrisonResources(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_GARRISON)
end

local function _GetApexisCrystals(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_APEXIS)
end

local function _GetSealsOfFate(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_SOTF)
end

local function _GetSealsOfBrokenFate(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_SOBF)
end

local function _GetOrderHallResources(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_ORDER_HALL)
end

local function _GetNethershards(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_NETHERSHARD)
end

local function _GetWarSupplies(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_LFWS)
end

local function _GetBfAWarResources(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_BFA_WAR_RES)
end

local function _GetBfASealsOfWartornFate(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_BFA_SOWF)
end

local function _GetBfADubloons(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_BFA_DUBLOONS)
end

local function _GetBfAWarSupplies(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_BFA_WAR_SUPPLIES)
end

local function _GetBfARichAzerite(character)
	return _GetCurrencyTotals(character, CURRENCY_ID_BFA_AZERITE)
end

local function _GetBfACoalVisions(character)
    return _GetCurrencyTotals(character, CURRENCY_ID_BFA_COAL_VISIONS)
end

local function _GetBfATitanResiduum(character)
    return _GetCurrencyTotals(character, CURRENCY_ID_BFA_TITAN_RESIDUUM)
end

local function _GetConquestPoints(character)
    return character.Conquest
end

local PublicMethods = {
	GetNumCurrencies = _GetNumCurrencies,
	GetCurrencyInfo = _GetCurrencyInfo,
	GetCurrencyInfoByName = _GetCurrencyInfoByName,
	GetCurrencyItemCount = _GetCurrencyItemCount,
	GetArcheologyCurrencyInfo = _GetArcheologyCurrencyInfo,
	GetCurrencyTotals = _GetCurrencyTotals,
	GetJusticePoints = _GetJusticePoints,
	GetValorPoints = _GetValorPoints,
	GetValorPointsPerWeek = _GetValorPointsPerWeek,
	GetApexisCrystals = _GetApexisCrystals,
	GetGarrisonResources = _GetGarrisonResources,
	GetSealsOfFate = _GetSealsOfFate,
	GetSealsOfBrokenFate = _GetSealsOfBrokenFate,
	GetOrderHallResources = _GetOrderHallResources,
	GetNethershards = _GetNethershards,
	GetWarSupplies = _GetWarSupplies,
	GetBfAWarResources = _GetBfAWarResources,
	GetBfASealsOfWartornFate = _GetBfASealsOfWartornFate,
	GetBfADubloons = _GetBfADubloons,
	GetBfAWarSupplies = _GetBfAWarSupplies,
	GetBfARichAzerite = _GetBfARichAzerite,
    GetBfACoalVisions = _GetBfACoalVisions,
    GetBfATitanResiduum = _GetBfATitanResiduum,
    GetConquestPoints = _GetConquestPoints,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
    
    -- Update 2020/03/28: Clearing all old character data due to change in datastructure. Cannot salvage old data as it is corrupted now due to a datatype overflow bug.
    if not addon.db.global.Characters then
        addon.db.global.DatastoreCurrencies8_3_006Update = true
    end
    if not addon.db.global.DatastoreCurrencies8_3_006Update then
        wipe(addon.db.global.Characters)
        addon.db.global.DatastoreCurrencies8_3_006Update = true
    end

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetNumCurrencies")
	DataStore:SetCharacterBasedMethod("GetCurrencyInfo")
	DataStore:SetCharacterBasedMethod("GetCurrencyInfoByName")
	DataStore:SetCharacterBasedMethod("GetCurrencyItemCount")
	DataStore:SetCharacterBasedMethod("GetArcheologyCurrencyInfo")
	DataStore:SetCharacterBasedMethod("GetCurrencyTotals")
	DataStore:SetCharacterBasedMethod("GetJusticePoints")
	DataStore:SetCharacterBasedMethod("GetValorPoints")
	DataStore:SetCharacterBasedMethod("GetValorPointsPerWeek")
	DataStore:SetCharacterBasedMethod("GetApexisCrystals")
	DataStore:SetCharacterBasedMethod("GetGarrisonResources")
	DataStore:SetCharacterBasedMethod("GetSealsOfFate")
	DataStore:SetCharacterBasedMethod("GetSealsOfBrokenFate")
	DataStore:SetCharacterBasedMethod("GetOrderHallResources")
	DataStore:SetCharacterBasedMethod("GetNethershards")
	DataStore:SetCharacterBasedMethod("GetWarSupplies")
	DataStore:SetCharacterBasedMethod("GetBfAWarResources")
	DataStore:SetCharacterBasedMethod("GetBfASealsOfWartornFate")
	DataStore:SetCharacterBasedMethod("GetBfADubloons")
	DataStore:SetCharacterBasedMethod("GetBfAWarSupplies")
	DataStore:SetCharacterBasedMethod("GetBfARichAzerite")
    DataStore:SetCharacterBasedMethod("GetBfACoalVisions")
    DataStore:SetCharacterBasedMethod("GetBfATitanResiduum")
    DataStore:SetCharacterBasedMethod("GetConquestPoints")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("CURRENCY_DISPLAY_UPDATE", OnCurrencyDisplayUpdate)
	addon:RegisterEvent("CHAT_MSG_SYSTEM", OnChatMsgSystem)
	
	local _, _, arch = GetProfessions()

	if arch then
		--	ARTIFACT_HISTORY_READY deprecated in 8.0
		-- addon:RegisterEvent("ARTIFACT_HISTORY_READY", OnArtifactHistoryReady)
		RequestArtifactCompletionHistory()		-- this will trigger ARTIFACT_HISTORY_READY
	end
end

function addon:OnDisable()
	addon:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")
end
