if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    print("DataStore_Keystones does not support Classic WoW")
    return
end

--[[	*** DataStore_Keystones ***
Written by : Teelo, US-Jubei'thos
https://www.patreon.com/teelojubeithos
--]]

if not DataStore then return end
local addonName = "DataStore_Keystones"
_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")
local addon = _G[addonName]

local AddonDB_Defaults = {
	global = {
		Options = {
			WeeklyResetDay = nil,		-- weekday (0 = Sunday, 6 = Saturday)
			WeeklyResetHour = nil,		-- 0 to 23
			NextWeeklyReset = nil,
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				currentKeystone = {},
				highestKeystoneThisWeek = {},
			}
		},
        Guilds = {
            ['*'] = {
                lastUpdate = nil,
                
            }
        },
	}
}

local ReferenceDB_Defaults = {
	global = {
		['*'] = {							-- "englishClass" like "MAGE", "DRUID" etc..
			Version = nil,					-- build number under which this class ref was saved
			Locale = nil,					-- locale under which this class ref was saved
		},
	}
}

-- *** Utility functions ***
local function GetOption(option)
	return addon.db.global.Options[option]
end

local function SetOption(option, value)
	addon.db.global.Options[option] = value
end

-- *** Scanning functions ***
local function ScanCurrentKeystoneInfo()
    local char = addon.ThisCharacter
    
    if not C_MythicPlus.GetOwnedKeystoneChallengeMapID() then 
        wipe(char.currentKeystone)
        return 
    end
    
    local name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(C_MythicPlus.GetOwnedKeystoneChallengeMapID())
    local keyStoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
    
    if char.currentKeystone.name ~= name then
        -- Keystone has changed since last scan
        char.currentKeystone.name = name
        char.currentKeystone.texture = texture
        char.currentKeystone.keystoneLevel = keyStoneLevel
    end        
    
    char.lastUpdate = time()
end

local function ScanHighestKeystone()
    local char = addon.ThisCharacter
    wipe(char.highestKeystoneThisWeek)
    local maps = C_ChallengeMode.GetMapTable()
    if not maps then return end
    
    local bestTime, bestLevel
    for i = 1, #maps do
		local durationSec, weeklyLevel = C_MythicPlus.GetWeeklyBestForMap(maps[i])
        if weeklyLevel then
            if (not bestTime) or (weeklyLevel > bestLevel) or ((weeklyLevel == bestLevel) and (durationSec < bestTime)) then
                local name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(maps[i])
                char.highestKeystoneThisWeek.name = name
                char.highestKeystoneThisWeek.completionMilliseconds = durationSec * 1000
                char.highestKeystoneThisWeek.level = weeklyLevel
                char.highestKeystoneThisWeek.texture = texture
                char.highestKeystoneThisWeek.backgroundTexture = backgroundTexture
                
                char.lastUpdate = time()
                
                bestTime = durationSec * 1000
                bestLevel = weeklyLevel
            end
        end
    end
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanCurrentKeystoneInfo()
end

local function OnAffixUpdate()
    ScanHighestKeystone()
end

local function OnItemReceived(event, bag)
    if (bag < 0) or (bag >= 5) then
		return
	end
    ScanCurrentKeystoneInfo()
end

-- *** Keystone Info ***
local function _GetCurrentKeystone(character)
    local keystone = character.currentKeystone
    if not keystone then return nil, nil, nil end    
    return keystone.name, keystone.texture, keystone.keystoneLevel
end

local function _GetHighestKeystone(character)
    local keystone = character.highestKeystoneThisWeek
    if not keystone then return nil, nil, nil, nil, nil end
    return keystone.name, keystone.completionMilliseconds, keystone.level, keystone.texture, keystone.backgroundTexture
end

-- from DataStore_Agenda
local function GetWeeklyResetDayByRegion(region)
	local day = 2		-- default to US, 2 = Tuesday
	
	if region then
		if region == "EU" then 
			day = 3 
		elseif region == "CN" or region == "KR" or region == "TW" then
			day = 4
		end
	end
	
	return day
end

-- from DataStore_Agenda
local function GetNextWeeklyReset(weeklyResetDay)
	local year = tonumber(date("%Y"))
	local month = tonumber(date("%m"))
	local day = tonumber(date("%d"))
	local todaysWeekDay = tonumber(date("%w"))
	local numDays = 0		-- number of days to add
	
	-- how many days should we add to today's date ?
	if todaysWeekDay < weeklyResetDay then					-- if it is Monday (1), and reset is on Wednesday (3)
		numDays = weeklyResetDay - todaysWeekDay		-- .. then we add 2 days
	elseif todaysWeekDay > weeklyResetDay then			-- if it is Friday (5), and reset is on Wednesday (3)
		numDays = weeklyResetDay - todaysWeekDay + 7	-- .. then we add 5 days (3 - 5 + 7)
	else
		-- Same day : if the weekly reset period has passed, add 7 days, if not yet, than 0 days
		numDays = (tonumber(date("%H")) > GetOption("WeeklyResetHour")) and 7 or 0
	end
	
	-- if numDays == 0 then return end
	if numDays == 0 then return date("%Y-%m-%d") end
	
	local newDay = day + numDays	-- 25th + 2 days = 27, or 28th + 10 days = 38 days (used to check days overflow in a month)

	local daysPerMonth = { 31,28,31,30,31,30,31,31,30,31,30,31 }
	if (year % 4 == 0) and (year % 100 ~= 0 or year % 400 == 0) then	-- is leap year ?
		daysPerMonth[2] = 29
	end	
	
	-- no overflow ? (25th + 2 days = 27, we stay in the same month)
	if newDay <= daysPerMonth[month] then
		return format("%04d-%02d-%02d", year, month, newDay)
	end
	
	-- we have a "day" overflow, but still in the same year
	if month <= 11 then
		-- 27/03 + 10 days = 37 - 31 days in March, so 6/04
		return format("%04d-%02d-%02d", year, month+1, newDay - daysPerMonth[month])
	end
	
	-- at this point, we had a day overflow in December, so jump to next year
	return format("%04d-%02d-%02d", year+1, 1, newDay - daysPerMonth[month])
end

-- from DataStore_Agenda
local function InitializeWeeklyParameters()
	local weeklyResetDay = GetWeeklyResetDayByRegion(GetCVar("portal"))
	SetOption("WeeklyResetDay", weeklyResetDay)
	SetOption("WeeklyResetHour", 6)			-- 6 am should be ok in most zones
	SetOption("NextWeeklyReset", GetNextWeeklyReset(weeklyResetDay))
end

-- from DataStore_Agenda, adjusted
local function ClearExpiredKeystones()
	-- WeeklyResetDay = nil,		-- weekday (0 = Sunday, 6 = Saturday)
	-- WeeklyResetHour = nil,		-- 0 to 23
	-- NextWeeklyReset = nil,
	
	local weeklyResetDay = GetOption("WeeklyResetDay")
	
	if not weeklyResetDay then			-- if the weekly reset day has not been set yet ..
		InitializeWeeklyParameters()
		return	-- initial pass, nothing to clear
	end
	
	local nextReset = GetOption("NextWeeklyReset")
	if not nextReset then		-- heal broken data
		InitializeWeeklyParameters()
		nextReset = GetOption("NextWeeklyReset") -- retry
	end
	
	local today = date("%Y-%m-%d")

	if (today < nextReset) then return end		-- not yet ? exit
	if (today == nextReset) and (tonumber(date("%H")) < GetOption("WeeklyResetHour")) then return end
	
	-- at this point, we may reset
	for key, character in pairs(addon.db.global.Characters) do
		wipe(character.currentKeystone)
        wipe(character.highestKeystoneThisWeek)
	end
	
	-- finally, set the next reset day
	SetOption("NextWeeklyReset", GetNextWeeklyReset(weeklyResetDay))
end

local PublicMethods = {
    GetCurrentKeystone = _GetCurrentKeystone,
    GetHighestKeystone = _GetHighestKeystone,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	addon.ref = LibStub("AceDB-3.0"):New(addonName .. "RefDB", ReferenceDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)

	DataStore:SetCharacterBasedMethod("GetCurrentKeystone")
	DataStore:SetCharacterBasedMethod("GetHighestKeystone")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("BAG_UPDATE", OnItemReceived)
    addon:RegisterEvent("CHALLENGE_MODE_MAPS_UPDATE", OnAffixUpdate)
    ClearExpiredKeystones()
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("CHALLENGE_MODE_MAPS_UPDATE")
	addon:UnregisterEvent("BAG_UPDATE")
end
