--[[	*** DataStore_Rares ***
Written by : Teelo - Jubei'thos US
September 28 2020
--]]

if not DataStore then return end

local addonName = "DataStore_Rares"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local THIS_REALM = GetRealmName()

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"]
				lastUpdate = nil,
				Rares = {},
                RareKillsCounter = {},
			}
		},
	}
}

addon.RareList = {}

local function ClearExpiredRares()
	-- this function will clear all the rares from the day(s) / week(s) before
	local now = time()

	for characterKey, character in pairs(addon.Characters) do
		local rares = character.Rares
		
		for questID, data in pairs(rares) do
			if now > (character.lastUpdate + data.resetTime) then
				rares[questID] = nil
			end
		end
	end
end

local function ScanRares()
	local char = addon.ThisCharacter
	local rares = char.Rares
    
    for _, rareList in pairs(addon.RareList) do
        local listName = rareList[1]
        local list = rareList[2]
        local resetPeriod = rareList[3]
        
        for _, rareDetails in pairs(list) do
            local creatureID = rareDetails[1]
            local questID = rareDetails[2]
            local allianceQuestID = rareDetails[3]
            local hordeQuestID = rareDetails[4]
            local creatureName = rareDetails[5]
            
            if not questID then
                if ((UnitFactionGroup("player")) == "Alliance") and (allianceQuestID ~= nil) then
                    questID = allianceQuestID
                elseif ((UnitFactionGroup("player")) == "Horde") and (hordeQuestID ~= nil) then
                    questID = hordeQuestID
                end
            end
            
            if questID and C_QuestLog.IsQuestFlaggedCompleted(questID) then
                if not rares[creatureID] then
                    local counter = char.RareKillsCounter
                    if not counter[creatureID] then counter[creatureID] = 0 end
                    counter[creatureID] = counter[creatureID] + 1
                end
                if resetPeriod == "DAILY" then
                    rares[creatureID] = {["resetTime"] = GetQuestResetTime(), ["name"] = creatureName}
                elseif resetPeriod == "WEEKLY" then
                    rares[creatureID] = {["resetTime"] = C_DateAndTime.GetSecondsUntilWeeklyReset(), ["name"] = creatureName}
                end
                
            end
        end
    end

	addon.ThisCharacter.lastUpdate = time()
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanRares()
end

local function OnQuestLogUpdate()
	ScanRares()
end

-- ** Mixins **
local function _GetKilledRares(character)
    return character.Rares
end

local function _GetRareList()
    return addon.RareList
end

local function _GetRareKills(character, creatureID)
    return character.RareKillsCounter[creatureID]
end

local PublicMethods = {
	GetKilledRares = _GetKilledRares,
    GetRareList = _GetRareList,
    GetRareKills = _GetRareKills,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetKilledRares")
    DataStore:SetCharacterBasedMethod("GetRareKills")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("QUEST_LOG_UPDATE", OnQuestLogUpdate)
	
	ClearExpiredRares()
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("QUEST_LOG_UPDATE")
end