--------------------------------------------------------------------------------
--[[ Quest Filter - Utility and wrapper functions for filtering quest types. ]]--
-- 
-- by erglo <erglo.coder+HNLM@gmail.com>
--
-- Copyright (C) 2024  Erwin D. Glockner (aka erglo, ergloCoder)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see http://www.gnu.org/licenses.
--
-- World of Warcraft API reference:
-- REF.: <https://www.townlong-yak.com/framexml/live/Helix/GlobalStrings.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_SharedXMLBase/TableUtil.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestLogDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_UIPanels_Game/QuestMapFrame.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/MapConstantsDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestConstantsDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_FrameXMLBase/Constants.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_SharedXML/SharedConstants.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestInfoSystemDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestLogDocumentation.lua>
-- (see also the function comments section for more reference)
--
--------------------------------------------------------------------------------

local AddonID, ns = ...;

local DBUtil = ns.DatabaseUtil;  --> <data\database.lua>
local LocalQuestCache = ns.QuestCacheUtil;  --> <data\questcache.lua>
local LoreUtil = ns.lore;  --> <Data.lua>

-- Upvalues
local tinsert, tContains = tinsert, tContains;
local tostring = tostring;

--------------------------------------------------------------------------------
----- Quest Filter Handler -----------------------------------------------------
--------------------------------------------------------------------------------

local LocalQuestFilter = { debug = false, debug_prefix = "QFilter:" };
ns.QuestFilter = LocalQuestFilter;

function LocalQuestFilter:Init()
    for i, weeklyQuestLineID in ipairs(self.weeklyQuestLines) do
        local weeklyQuestIDs = LocalQuestCache:GetQuestLineQuests(weeklyQuestLineID)
        tAppendAll(self.weeklyQuests, weeklyQuestIDs)
    end
    for i, dailyQuestLineID in ipairs(self.dailyQuestLines) do
        local dailyQuestIDs = LocalQuestCache:GetQuestLineQuests(dailyQuestLineID)
        tAppendAll(self.dailyQuests, dailyQuestIDs)
    end
    -- debug:print(self, "Filter data have been prepared")
end

-- All quests in this table are weekly quests of different questlines.
LocalQuestFilter.weeklyQuests = {
    75665, 78444,  -- Dragonflight, "A Worthy Ally: Loamm Niffen/Dream Wardens"
    78821,  -- Dragonflight, "Blooming Dreamseeds"
    77251,  -- Dragonflight, "Shaping the Dreamsurge"
    70750, 72068, 72373, 72374, 72375, 75259, 75859, 75860, 75861, 77254, 77976,  -- Dragonflight, "Aiding the Accord" quests
    78446, 78447, 78861,  -- Dragonflight, "Aiding the Accord" quests
    80385, 80386, 80388, 80389,  -- Dragonflight, "Last Hurrah" quests
    66042,  -- Shadowlands, Zereth Mortis, "Patterns Within Patterns"
    63949,  -- Shadowlands, Korthia, "Shaping Fate"
    61332, 62861, 62862, 62863,  -- Shadowlands, Covenant Sanctum (Kyrian), "Return Lost Souls" quests
    61982,  -- Shadowlands (Kyrian), "Replenish the Reservoir"
    57301,  -- Shadowlands, Maldraxxus, "Callous Concoctions"
};

function LocalQuestFilter:ShouldSaveRecurringQuest(questInfo)
    return (
        ns.settings.saveRecurringQuests and
        (questInfo.isWeekly or questInfo.isDaily or questInfo.isRepeatable) and
        (questInfo.isStory or questInfo.isCampaign or questInfo.hasQuestLineInfo)
    )
end

-- All quests of these questlines are weekly quests.
LocalQuestFilter.weeklyQuestLines = {
    1416,  -- Dragonflight, Valdrakken, "Bonus Event Holiday Quests"
}

-- All quests in this table are daily quests of different questlines.
LocalQuestFilter.dailyQuests = {
    59826, 59827, 59828, -- Shadowlands, Maldraxxus, "Bet On Yourself"
}

-- All quests of these questlines are daily quests or daily single quest questlines.
LocalQuestFilter.dailyQuestLines = {
    971,  -- Battle for Azeroth, Mechagon, "Visit from Archivist Bitbyte"
    974,  -- Battle for Azeroth, Mechagon, "Visit from Tortollans"
}

-- All quests in this table have been marked obsolete by Blizzard and cannot be
-- obtained or completed.
LocalQuestFilter.obsoleteQuests = {
    -- 25443,  -- Mount Hyjal, The Name Never Spoken (alternative Version of #25412)
    26398,  -- Kalimdor, Mulgore (previously Orgrimmar), "Walk With The Earth Mother"
    43931,  -- Legion, Artifact, "Balance of Power"
    44556, 44886, 44887, 44944,  -- Legion, "Return to Karazhan"
    48017, 49970,  -- Battle for Azeroth, Zuldazar, "The Sunken City"
    48325, 48328,  -- Battle for Azeroth, Vol'dun, "Port of Zem'lan"
    49976, 50056, 50057, 50341,  -- Eastern Kingdom, Stormwind City, "Silithus: The Wound"
    53031,  -- Battle for Azeroth, Hall of Communion, "The Speaker's Imperative"
    56065,  -- BfA, Nazjatar, (???)
    62699,  -- Shadowlands, Covenant Sanctum (Kyrian)
    -- 70777,  -- Dragonflight, Waking Shores, "Tarjin the Blind"
    70846,  -- Dragonflight, Thaldraszus, "The Spark of Ingenuity"
    72943,  -- Dragonflight, "United Again"
    77488,  -- Dragonflight, Ohn'ahra, "Azerothian Archives - Excavation Sites"
    79992, 79994, 79995, 79996, 79997,  -- Dragonflight, "Azerothian Archives"
    -- 78717, 78718, 78719, 7872, 78721, 78722, 79105, 79106, 80321,  -- The War Within (pre-patch), "Visions of Azeroth"
    72719, 72724, 72725, 72726, 72727, 72810, -- Dragonflight, Valdrakken, "Bonus Event Holiday Quests"
    81466,  -- Dragonflight, Thaldraszus, "Dragon Isles Emissary"
    83360, 83363,  -- Dragonflight, Valdrakken, "Bonus Event Holiday Quests"
}

----- Player Race ----------

-- local playerRaceName, raceFileName, playerRaceID = UnitRace("player")
local playerRaceID = select(3, UnitRace("player"))

-- All quests in this table are bound to a specific player race.
-- REF.: <https://wowpedia.fandom.com/wiki/RaceId>
local raceQuests = {
    ["8325"] = { 10 },  -- Eastern Kingdoms, Sunstrider Isle, "Reclaiming Sunstrider Isle" (Horde)
    ["8326"] = { 10 },  -- Eastern Kingdoms, Sunstrider Isle, "Unfortunate Measures" (Horde)
    ["8334"] = { 10 },  -- Eastern Kingdoms, Sunstrider Isle, "Aggression" (Horde)
    ["8335"] = { 10 },  -- Eastern Kingdoms, Sunstrider Isle, "Felendren the Banished" (Horde)
    ["8347"] = { 10 },  -- Eastern Kingdoms, Sunstrider Isle, "Aiding the Outrunners" (Horde)
    ["9327"] = { 10 },  -- Eastern Kingdoms, Ghostlands, "The Forsaken"
    ["9762"] = { 11 },  -- Kalimdor, Bloodmyst Isle, "The Unwritten Prophecy"
    ["28202"] = { 3, 29, 34 },  -- Eastern Kingdoms, Burning Steppes, "A Perfect Costume" (Alliance)
    ["28204"] = { 7, 9 },  -- Eastern Kingdoms, Burning Steppes, "A Perfect Costume" (Alliance)
    ["28205"] = { 4 },  -- Eastern Kingdoms, Burning Steppes, "A Perfect Costume" (Alliance)
    ["28428"] = { 2, 5, 36 },  -- Eastern Kingdoms, Burning Steppes, "A Perfect Costume" (Horde)
    ["28429"] = { 6, 24, 25, 26, 28 }, -- Eastern Kingdoms, Burning Steppes, "A Perfect Costume" (Horde)
    ["28430"] = { 9, 35 },  -- Eastern Kingdoms, Burning Steppes, "A Perfect Costume" (Horde)
    ["28431"] = { 8, 10, 27 },  -- Eastern Kingdoms, Burning Steppes, "A Perfect Costume" (Horde)
    ["31139"] = { 32 },  -- Eastern Kingdoms, Northshire, "Beating Them Back!"
    ["50694"] = { 4, 7, 22 },  -- Battle for Azeroth, Stormsong Valley, "A Bloody Mess" (Alliance)
    ["77201"] = { 4 },  -- Dragonflight, Emerald Dream, "A Personal Offering" (Alliance)
}

-- Quests which are not bound to a specific player race are considered playable.
function LocalQuestFilter:ShouldShowRaceQuest(questID)
    local questIDstring = tostring(questID)
    if not raceQuests[questIDstring] then return true end

    return tContains(raceQuests[questIDstring], playerRaceID)
end

----- Player Class ----------

-- local playerClassName, classFilename, playerClassID = UnitClass("player")
local playerClassID = select(3, UnitClass("player"))

-- All quests in this table are specific to aka player class.  
-- REF.: <https://wowpedia.fandom.com/wiki/ClassId>
local classQuests = {
    ["28757"] = { 8 },  -- Eastern Kingdoms, Northshire, "Beating Them Back!"   (Night Elf,  Gnome, Draenei)
    ["28762"] = { 2 },  -- Eastern Kingdoms, Northshire, "Beating Them Back!"   (Draenei)
    ["28763"] = { 5 },  -- Eastern Kingdoms, Northshire, "Beating Them Back!"
    ["28764"] = { 4 },  -- Eastern Kingdoms, Northshire, "Beating Them Back!"   (Night Elf,  Gnome, Worgen)
    ["28765"] = { 9 },  -- Eastern Kingdoms, Northshire, "Beating Them Back!"   (Gnome)
    ["28766"] = { 1 },  -- Eastern Kingdoms, Northshire, "Beating Them Back!"
    ["28767"] = { 3 },  -- Eastern Kingdoms, Northshire, "Beating Them Back!"
    ["40815"] = { 12 }, -- Legion, Azsuna, "From Within"
    ["43503"] = { 8 },  -- Legion, Suramar, "The Power Within"
    ["43505"] = { 8 },  -- Legion, Suramar, "The Power Within"
    ["44137"] = { 12 }, -- Legion, Azsuna, "Into the Fray"
    ["44140"] = { 12 }, -- Legion, Azsuna, "From Within"
    ["54058"] = { 5 },  -- Battle for Azeroth, Crucible of Storms, "Unintended Consequences" (Neutral)
    ["54118"] = { 5 },  -- Battle for Azeroth, Crucible of Storms, "Every Little Death Helps" (Horde)
    ["54433"] = { 5 },  -- Battle for Azeroth, Crucible of Storms, "Orders from Azshara" (Horde)
    ["57715"] = { 6 },   -- Shadowlands, Bastion, "The Archon's Answer"
    ["60217"] = { 12 },  -- Shadowlands, Bastion, "The Archon's Answer"
    ["60218"] = { 11 },  -- Shadowlands, Bastion, "The Archon's Answer"
    ["60219"] = { 3 },   -- Shadowlands, Bastion, "The Archon's Answer"
    ["60220"] = { 8 },   -- Shadowlands, Bastion, "The Archon's Answer"
    ["60221"] = { 10 },  -- Shadowlands, Bastion, "The Archon's Answer"
    ["60222"] = { 2 },   -- Shadowlands, Bastion, "The Archon's Answer"
    ["60223"] = { 5 },   -- Shadowlands, Bastion, "The Archon's Answer"
    ["60224"] = { 4 },   -- Shadowlands, Bastion, "The Archon's Answer"
    ["60225"] = { 7 },   -- Shadowlands, Bastion, "The Archon's Answer"
    ["60226"] = { 9 },   -- Shadowlands, Bastion, "The Archon's Answer"
    ["60229"] = { 1 },   -- Shadowlands, Bastion, "The Archon's Answer"
}

--> TODO - Handle auto-accept quest types
-- 29078  -- Eastern Kingdoms, Northshire, "Beating Them Back!" (Auto-Accept, Worgen, Warrior)
-- 29066  -- Kalimdor, Mount Hyjal, "Good News... and Bad News" (Auto-Accept, only finish-able before #25462 "The Bears Up There")

-- Quests which are not bound to a specific player class are considered playable.
function LocalQuestFilter:ShouldShowClassQuest(questID)
    local questIDstring = tostring(questID)
    if not classQuests[questIDstring] then return true end

    return tContains(classQuests[questIDstring], playerClassID)
end

----- Faction Groups ----------

-- local playerFactionGroup = UnitFactionGroup("player")

-- -- Quest faction groups: {Alliance=1, Horde=2, Neutral=3}
-- local QuestFactionGroupID = EnumUtil.MakeEnum(PLAYER_FACTION_GROUP[1], PLAYER_FACTION_GROUP[0], "Neutral")

local QuestFactionGroupID = ns.QuestFactionGroupID  --> <Data.lua>

-- Sometimes `GetQuestFactionGroup()` does not return the correct faction group ID, eg. Neutral instead of Horde.
local correctFactionGroupQuests = {
    -- ["26334"] = QuestFactionGroupID.Horde,  -- Eastern Kingdoms, Northern Stranglethorn, "Bloodlord Mandokir"
    -- ["26554"] = QuestFactionGroupID.Horde,  -- Eastern Kingdoms, The Cape of Stranglethorn, "Plunging Into Zul'Gurub"
    ["26081"] = QuestFactionGroupID.Horde,  -- Eastern Kingdoms, Arathi Highlands, "Alina's Reward"
    -- ["26090"] = QuestFactionGroupID.Horde,  -- Eastern Kingdoms, Abyssal Depths, "I Brought You This Egg"
    -- ["26091"] = QuestFactionGroupID.Horde,  -- Eastern Kingdoms, Abyssal Depths, "Here Fishie Fishie 2: Eel-Egg-Trick Boogaloo"
    -- ["26149"] = QuestFactionGroupID.Horde,  -- Eastern Kingdoms, Abyssal Depths, "Prisoners"
    ["27090"] = QuestFactionGroupID.Horde,  -- Eastern Kingdoms, Western Plaguelands, "Andorhal, Once and For All"
    -- ["25561"] = QuestFactionGroupID.Alliance,  -- Kalimdor, Thousand Needles, "Circle the Wagons... er, Boats"
    ["70050"] = QuestFactionGroupID.Alliance,  -- Eastern Kingdoms, Stormwind City, (Dragonflight), "Chasing Storms"
    ["69944"] = QuestFactionGroupID.Horde,  -- Kalimdor, Durotar, (Dragonflight), "Chasing Storms"
    ["13260"] = QuestFactionGroupID.Horde,  -- Northrend, Icecrown, "Takes One to Know One"
    ["13271"] = QuestFactionGroupID.Horde,  -- Northrend, Icecrown, "A Voice in the Dark"
    -- ["13390"] = QuestFactionGroupID.Alliance,  -- Northrend, Icecrown, "A Voice in the Dark"
    ["13275"] = QuestFactionGroupID.Horde,  -- Northrend, Icecrown, "Time to Hide"
    ["13348"] = QuestFactionGroupID.Horde,  -- Northrend, Icecrown, "Futility"
    ["13359"] = QuestFactionGroupID.Horde,  -- Northrend, Icecrown, "Where Dragons Fell"
    ["13361"] = QuestFactionGroupID.Horde,  -- Northrend, Icecrown, "The Hunter and the Prince"
    ["71025"] = QuestFactionGroupID.Horde,  -- Dragonflight, World PvP, 10.0 Faction Swap Protection [DNT], "Against Overwhelming Odds"
}

-- Some quest are specified as Neutral, but are Alliance or Horde quests instead.
function LocalQuestFilter:GetQuestFactionGroup(questID)
    local questFactionGroup = GetQuestFactionGroup(questID)
    local correctedQuestFactionGroup = correctFactionGroupQuests[tostring(questID)]

    return correctedQuestFactionGroup or questFactionGroup or QuestFactionGroupID.Neutral
end

-----

-- Quests are either for a specific faction group, quest type, phase, etc. Try to match those.
---@param questInfo table
---@return boolean
--
function LocalQuestFilter:PlayerMatchesQuestRequirements(questInfo)
    if self:IsObsolete(questInfo.questID) then
        -- debug:print(self, "Skipping OBSOLETE quest:", questInfo.questID)
        return false
    end
    if not self:ShouldShowRaceQuest(questInfo.questID) then
        -- debug:print(self, "Skipping RACE quest:", questInfo.questID)
        return false
    end
    if not self:ShouldShowClassQuest(questInfo.questID) then
        -- debug:print(self, "Skipping CLASS quest:", questInfo.questID)
        return false
    end

    -- Filter quest by faction group (1 == Alliance, 2 == Horde, [3 == Neutral])  --> Player = 1|2
    local isFactionGroupMatch = tContains({QuestFactionGroupID.Player, QuestFactionGroupID.Neutral}, questInfo.questFactionGroup)
    return isFactionGroupMatch
end

--> TODO - Add more filter types
    -- eg. quests which are optional (?), different class, phase (?), weekly, daily, etc.
--> TODO - Check quest giver quests
--> TODO - Check quest types: warfront (?), WorldQuests (!, QL-940) 
    -- [quest=53955]  -- "Warfront: The Battle for Darkshore" (???)
--> TODO - Add filter for wrong factionGroup quests
    -- [quest=54114]  -- Battle for Azeroth, Crucible of Storms, "Every Little Death Helps" (Alliance, not Neutral)

----- Filtering Handler --------------------------------------------------------

function LocalQuestFilter:IsDaily(questID, baseQuestInfo)
    local questInfo = baseQuestInfo or LocalQuestCache:Get(questID);
    local isFrequencyDaily = (questInfo and questInfo.frequency) and questInfo.frequency == Enum.QuestFrequency.Daily;
    local isSavedCompletedDailyQuest = DBUtil:IsCompletedRecurringQuest("Daily", questID);

    if (isSavedCompletedDailyQuest and ns.settings.saveRecurringQuests) then
        -- Enhance completion flagging for recurring quests
        if not questInfo.isFlaggedCompleted then
            questInfo.isFlaggedCompleted = isSavedCompletedDailyQuest;
        end
    end

    return isFrequencyDaily or tContains(self.dailyQuests, questID) or isSavedCompletedDailyQuest;
end

function LocalQuestFilter:IsWeekly(questID, baseQuestInfo)
    local questInfo = baseQuestInfo or LocalQuestCache:Get(questID);
    local isFrequencyWeekly = (questInfo and questInfo.frequency) and questInfo.frequency == Enum.QuestFrequency.Weekly;
    local isSavedCompletedWeeklyQuest = DBUtil:IsCompletedRecurringQuest("Weekly", questID);

    if (isSavedCompletedWeeklyQuest and ns.settings.saveRecurringQuests) then
        -- Enhance completion flagging for recurring quests
        if not questInfo.isFlaggedCompleted then
            questInfo.isFlaggedCompleted = isSavedCompletedWeeklyQuest;
        end
    end

    return isFrequencyWeekly or tContains(self.weeklyQuests, questID) or isSavedCompletedWeeklyQuest;
end

function LocalQuestFilter:IsStory(questID, baseQuestInfo)
    local questInfo = baseQuestInfo or LocalQuestCache:Get(questID);

    return questInfo.isStory or tContains(LoreUtil.storyQuests, tostring(questID)) or IsStoryQuest(questID);
end

----- QuestLine Quest Filter -----

-- Some quests which are still in the game have been marked obsolete by Blizzard
-- and cannot be obtained or completed.
-- **Note:** This is not a foolproof solution, but seems to work so far.
function LocalQuestFilter:IsObsolete(questID)
    local isManuallyMarked = tContains(self.obsoleteQuests, questID);
    local hasInvalidExpansionID = GetQuestExpansion(questID) < 0;
    local hasCachedData = LocalQuestCache:IsCached(questID);
    local hasQuestData = HaveQuestData(questID);

    return isManuallyMarked or hasInvalidExpansionID or not hasCachedData or not hasQuestData;
end

