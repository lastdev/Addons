--------------------------------------------------------------------------------
--[[ Quest Information - Utility and Wrapper functions for handling quest data. ]]--
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
-- REF.: <https://warcraft.wiki.gg/wiki/World_of_Warcraft_API>
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
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestInfoSharedDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestTaskInfoDocumentation.lua>
-- REF.: <https://warcraft.wiki.gg/wiki/API_C_QuestLog.GetQuestTagInfo>
-- (see also the function comments section for more reference)
--
--------------------------------------------------------------------------------

local AddonID, ns = ...;

-- Upvalues
local C_QuestLog = C_QuestLog;
local C_QuestInfoSystem = C_QuestInfoSystem;
local C_CampaignInfo = C_CampaignInfo;

local QuestFactionGroupID = ns.QuestFactionGroupID;  --> <Data.lua>
local LocalQuestCache = ns.QuestCacheUtil; --> <data\questcache.lua>
local LocalQuestFilter = ns.QuestFilter;  --> <data\questfilter.lua>

--------------------------------------------------------------------------------

local LocalQuestInfo = {};
ns.QuestInfo = LocalQuestInfo;

----- Wrapper -----

function LocalQuestInfo:GetQuestTagInfo(questID)
    return C_QuestLog.GetQuestTagInfo(questID);
end

-- Wrapper functions for quest classificationIDs.
---@param questID number
---@return (Enum.QuestClassification)? classificationID
-- 
-- Supported Enum.QuestClassification types (value/name): <br>
-- *  0 "Important" <br>
-- *  1 "Legendary" <br>
-- *  2 "Campaign" <br>
-- *  3 "Calling" <br>
-- *  4 "Meta" <br>
-- *  5 "Recurring" <br>
-- *  6 "Questline" <br>
-- *  7 "Normal" <br>
-- *  8 "BonusObjective" <br>
-- *  9 "Threat" <br>
-- * 10 "WorldQuest" <br>
--
-- REF.: [QuestInfoSharedDocumentation.lua](https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestInfoSharedDocumentation.lua) <br>
-- REF.: [QuestInfoSystemDocumentation.lua](https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestInfoSystemDocumentation.lua) <br>
-- REF.: [QuestUtils.lua](https://www.townlong-yak.com/framexml/live/Blizzard_FrameXMLUtil/QuestUtils.lua) <br>
--
function LocalQuestInfo:GetQuestClassificationID(questID)
    local classificationID = C_QuestInfoSystem.GetQuestClassification(questID);
    return classificationID;
end

function LocalQuestInfo:GetQuestClassificationDetails(questID, skipFormatting)
    return QuestUtil.GetQuestClassificationDetails(questID, skipFormatting);
end

-- returns { text=..., atlas=..., size=...}
function LocalQuestInfo:GetQuestClassificationInfo(classificationID)
    local info = QuestUtil.GetQuestClassificationInfo(classificationID);
    -- Add text + atlas for 'BonusObjective'. Leave 'Threat' and 'WorldQuest', since their type is dynamic and handled separately.
    local classificationInfoTableMore = {
        [Enum.QuestClassification.BonusObjective] =	{ text = MAP_LEGEND_BONUSOBJECTIVE, atlas = "questbonusobjective", size = 16 },
    };
    return info or classificationInfoTableMore[classificationID];
end

-- Return the factionGroupID for the given quest.
function LocalQuestInfo:GetQuestFactionGroup(questID)
    local questFactionGroup = GetQuestFactionGroup(questID);

    return questFactionGroup or QuestFactionGroupID.Neutral;
end

----- Handler -----

-- Check if given quest is part of a questline.
function LocalQuestInfo:HasQuestLineInfo(questID, uiMapID)                      --> TODO - Refine
    if not uiMapID then
        uiMapID = ns.activeZoneMapInfo and ns.activeZoneMapInfo.mapID or WorldMapFrame:GetMapID();
    end
    return (C_QuestLine.GetQuestLineInfo(questID, uiMapID)) ~= nil;
end

-- Extend a default World Map quest pin with additional details needed for this
-- addon to work properly. The pin comes already with a lot of useful functions
-- and variables. Here is an example:
-- * `.achievementID`
-- * `.dataProvider` --> `table` (eg. QuestDataProviderMixin)
-- * `.inProgress`
-- * `.isAccountCompleted`
-- * `.isCampaign`
-- * `.isCombatAllyQuest`
-- * `.isDaily`
-- * `.isHidden`
-- * `.isImportant`
-- * `.isLegendary`
-- * `.isLocalStory` --> "QuestLineInfo"
-- * `.isMeta`
-- * `.isQuestStart` --> `true`
-- * `.mapID`
-- * `.numObjectives`
-- * `.pinAlpha`
-- * `.pinLevel`
-- * `.pinTemplate`
-- * `.questClassification`
-- * `.questIcon`
-- * `.questID`
-- * `.questLineID`
-- * `.questLineName`
-- * `.questName`
-- * `.scaleFactor`
-- * `.superTracked`
-- * `.x, y, normalizedX, normalizedY`
-- 
-- REF.:
-- [MapCanvas_DataProviderBase.lua](https://www.townlong-yak.com/framexml/56162/Blizzard_MapCanvas/MapCanvas_DataProviderBase.lua),
-- [QuestDataProvider.lua](https://www.townlong-yak.com/framexml/56162/Blizzard_SharedMapDataProviders/QuestDataProvider.lua),
-- 
---@param pin table
---@return table questInfo
--
function LocalQuestInfo:GetQuestInfoForPin(pin)
    -- local questInfo = {};
    local questInfo = self:GetGameQuestInfo(pin.questID);
    questInfo.questID = pin.questID;
    questInfo.isAccountCompleted = pin.isAccountCompleted or C_QuestLog.IsQuestFlaggedCompletedOnAccount(questInfo.questID);
    questInfo.isFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted(questInfo.questID);  --> don't move from this position (!), might be overwritten by `:IsDaily` or `:IsWeekly`!

    local classificationID = pin.questClassification or LocalQuestInfo:GetQuestClassificationID(questInfo.questID);
    local tagInfo = self:GetQuestTagInfo(questInfo.questID);
    --> Note: Don't use `pin.questLineID`, yet. Currently NOT reliable! (11.0.2)
    -- questInfo.hasQuestLineInfo = (pin.questLineID ~= nil) or (classificationID and classificationID == Enum.QuestClassification.Questline or LocalQuestInfo:HasQuestLineInfo(questInfo.questID));
    questInfo.hasQuestLineInfo = (classificationID and classificationID == Enum.QuestClassification.Questline) or LocalQuestInfo:HasQuestLineInfo(questInfo.questID);
    questInfo.isAccountQuest = tagInfo and tagInfo.tagID == Enum.QuestTag.Account or C_QuestLog.IsAccountQuest(questInfo.questID);
    questInfo.isActive = C_TaskQuest.IsActive(questInfo.questID);
    questInfo.isBonusObjective = pin.isBonusObjective or (classificationID and classificationID == Enum.QuestClassification.BonusObjective or QuestUtils_IsQuestBonusObjective(questInfo.questID));
    questInfo.isCalling = (classificationID and classificationID == Enum.QuestClassification.Calling) or (tagInfo and tagInfo.tagID == Enum.QuestTagType.CovenantCalling) or C_QuestLog.IsQuestCalling(questInfo.questID);
    questInfo.isCampaign = pin.isCampaign or (pin.campaignID ~= nil) or (classificationID and classificationID == Enum.QuestClassification.Campaign) or C_CampaignInfo.IsCampaignQuest(questInfo.questID);
    questInfo.isDaily = pin.isDaily or LocalQuestFilter:IsDaily(questInfo.questID, questInfo);
    questInfo.isFailed = C_QuestLog.IsFailed(questInfo.questID);                      --> TODO - Check if these quests would be even visible on the map
    questInfo.isImportant = pin.isImportant or (classificationID and classificationID == Enum.QuestClassification.Important) or C_QuestLog.IsImportantQuest(questInfo.questID);
    questInfo.isLegendary = pin.isLegendary or (classificationID and classificationID == Enum.QuestClassification.Legendary) or C_QuestLog.IsLegendaryQuest(questInfo.questID);
    questInfo.isOnQuest = pin.inProgress or C_QuestLog.IsOnQuest(questInfo.questID);
    questInfo.isReadyForTurnIn = C_QuestLog.ReadyForTurnIn(questInfo.questID);
    questInfo.isRepeatable = C_QuestLog.IsRepeatableQuest(questInfo.questID) or C_QuestLog.IsQuestRepeatableType(questInfo.questID);
    questInfo.isStory = questInfo.isStory or LocalQuestFilter:IsStory(questInfo.questID, questInfo);
    questInfo.isThreat = (classificationID and classificationID == Enum.QuestClassification.Threat) or (tagInfo and tagInfo.tagID == Enum.QuestTagType.Threat);
    questInfo.isTrivial = pin.isHidden or questInfo.isHidden or C_QuestLog.IsQuestTrivial(questInfo.questID);
    questInfo.isWeekly = LocalQuestFilter:IsWeekly(questInfo.questID, questInfo);
    questInfo.isWorldQuest = questInfo.isTask or (classificationID and classificationID == Enum.QuestClassification.WorldQuest) or (tagInfo and tagInfo.worldQuestType ~= nil) or QuestUtils_IsQuestWorldQuest(questInfo.questID);
    questInfo.questFactionGroup = self:GetQuestFactionGroup(questInfo.questID);
    questInfo.questName = questInfo.questName or QuestUtils_GetQuestName(questInfo.questID);
    questInfo.questTagInfo = tagInfo;

    return questInfo;
end

local function AddMoreQuestInfo(questInfo)
    questInfo.isAccountCompleted = C_QuestLog.IsQuestFlaggedCompletedOnAccount(questInfo.questID);
    questInfo.isFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted(questInfo.questID);  --> don't move from this position (!), might be overwritten by `:IsDaily` or `:IsWeekly`!

    local classificationID = questInfo.questClassification or LocalQuestInfo:GetQuestClassificationID(questInfo.questID);
    local tagInfo = LocalQuestInfo:GetQuestTagInfo(questInfo.questID);
    questInfo.isDaily = LocalQuestFilter:IsDaily(questInfo.questID, questInfo);
    questInfo.isWeekly = LocalQuestFilter:IsWeekly(questInfo.questID, questInfo);
    questInfo.isFailed = C_QuestLog.IsFailed(questInfo.questID);
    questInfo.isAccountQuest = (tagInfo and tagInfo.tagID == Enum.QuestTag.Account) or C_QuestLog.IsAccountQuest(questInfo.questID);
    questInfo.isActive = C_TaskQuest.IsActive(questInfo.questID);
    questInfo.isBonusObjective = (classificationID and classificationID == Enum.QuestClassification.BonusObjective) or QuestUtils_IsQuestBonusObjective(questInfo.questID);
    questInfo.isCalling = (classificationID and classificationID == Enum.QuestClassification.Calling) or (tagInfo and tagInfo.tagID == Enum.QuestTagType.CovenantCalling) or C_QuestLog.IsQuestCalling(questInfo.questID);
    questInfo.isCampaign = (questInfo.campaignID ~= nil) or (classificationID and classificationID == Enum.QuestClassification.Campaign) or C_CampaignInfo.IsCampaignQuest(questInfo.questID);
    questInfo.isImportant = (classificationID and classificationID == Enum.QuestClassification.Important) or C_QuestLog.IsImportantQuest(questInfo.questID);
    questInfo.isLegendary = (classificationID and classificationID == Enum.QuestClassification.Legendary) or C_QuestLog.IsLegendaryQuest(questInfo.questID);
    questInfo.isOnQuest = C_QuestLog.IsOnQuest(questInfo.questID);
    questInfo.hasQuestLineInfo = (classificationID and classificationID == Enum.QuestClassification.Questline) or LocalQuestInfo:HasQuestLineInfo(questInfo.questID);
    questInfo.isReadyForTurnIn = C_QuestLog.ReadyForTurnIn(questInfo.questID);
    questInfo.isStory = questInfo.isStory or LocalQuestFilter:IsStory(questInfo.questID, questInfo);
    questInfo.isThreat = classificationID and classificationID == Enum.QuestClassification.Threat or (tagInfo and tagInfo.tagID == Enum.QuestTagType.Threat);
    questInfo.isTrivial = questInfo.isHidden or C_QuestLog.IsQuestTrivial(questInfo.questID);
    questInfo.isWorldQuest = questInfo.isTask or (classificationID and classificationID == Enum.QuestClassification.WorldQuest) or (tagInfo and tagInfo.worldQuestType ~= nil) or QuestUtils_IsQuestWorldQuest(questInfo.questID);
    questInfo.questFactionGroup = LocalQuestInfo:GetQuestFactionGroup(questInfo.questID);
    questInfo.questName = questInfo.title or QuestUtils_GetQuestName(questInfo.questID);
    questInfo.questTagInfo = questInfo.tagInfo or tagInfo;
    -- Internal legacy
    questInfo.questType = C_QuestLog.GetQuestType(questInfo.questID);
    -- Test
    questInfo.wasEarnedByMe = questInfo.isCompleted and not questInfo.isAccountCompleted;
    questInfo.isRepeatable = C_QuestLog.IsRepeatableQuest(questInfo.questID) or C_QuestLog.IsQuestRepeatableType(questInfo.questID);
    questInfo.isBreadcrumbQuest = IsBreadcrumbQuest(questInfo.questID);
    questInfo.isSequenced = IsQuestSequenced(questInfo.questID);
    -- isInvasion = C_QuestLog.IsQuestInvasion(questID),
    -- isMeta
end

-- Retrieve game native quest info for given quest.
---@param questID number
---@return QuestInfo|table questInfo
-- 
-- `QuestInfo` structure (name/type): <br>
-- * `campaignID` --> `number?`  <br>
-- * `difficultyLevel` --> `number` <br>
-- * `frequency` --> `QuestFrequency?`  <br>
-- * `hasLocalPOI` --> `boolean` <br>
-- * `headerSortKey` --> `number?`  <br>
-- * `isAbandonOnDisable` --> `boolean` <br>
-- * `isAutoComplete` --> `boolean` <br>
-- * `isBounty` --> `boolean` <br>
-- * `isCollapsed` --> `boolean` <br>
-- * `isHeader` --> `boolean` <br>
-- * `isHidden` --> `boolean` <br>
-- * `isInternalOnly` --> `boolean` <br>
-- * `isOnMap` --> `boolean` <br>
-- * `isScaling` --> `boolean` <br>
-- * `isStory` --> `boolean` <br>
-- * `isTask` --> `boolean` <br>
-- * `level` --> `number` <br>
-- * `overridesSortOrder` --> `boolean` <br>
-- * `questClassification` --> `QuestClassification` <br>
-- * `questID` --> `number` <br>
-- * `questLogIndex` --> `luaIndex` <br>
-- * `readyForTranslation` --> `boolean` <br>
-- * `sortAsNormalQuest` --> `boolean` <br>
-- * `startEvent` --> `boolean` <br>
-- * `suggestedGroup` --> `number` <br>
-- * `title` --> `string` <br>
-- * `useMinimalHeader` --> `boolean` <br>
--
-- REF.: [QuestLogDocumentation.lua](https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestLogDocumentation.lua) <br>
-- REF.: [QuestMixin](https://www.townlong-yak.com/framexml/live/Blizzard_ObjectAPI/Quest.lua)
-- 
function LocalQuestInfo:GetGameQuestInfo(questID)
    local questInfo = LocalQuestCache:Get(questID);
    if not questInfo then
        questInfo = C_QuestLog.GetInfo(questID);
    end
    if not questInfo then
        questInfo = { ["questID"] = questID };
    end

    return questInfo;
end

-- Retrieve custom quest info on top of the game's native data for given quest.
---@param questID number
---@return QuestInfo|table questInfo
-- 
function LocalQuestInfo:GetCustomQuestInfo(questID)
    local questInfo = self:GetGameQuestInfo(questID);
    AddMoreQuestInfo(questInfo);

    return questInfo;
end

-- Retrieve a limited amount of quest details needed to process quest related events.
---@param questID number
---@return table questInfo
--
function LocalQuestInfo:GetQuestInfoForQuestEvents(questID)
    local questInfo = self:GetGameQuestInfo(questID);
    -- Enrich details
    questInfo.questID = questID;
    questInfo.questName = questInfo.title or QuestUtils_GetQuestName(questInfo.questID);

    local classificationID = questInfo.questClassification or LocalQuestInfo:GetQuestClassificationID(questInfo.questID);
    questInfo.hasQuestLineInfo = (classificationID and classificationID == Enum.QuestClassification.Questline) or LocalQuestInfo:HasQuestLineInfo(questInfo.questID);
    questInfo.isCampaign = (questInfo.campaignID ~= nil) or (classificationID and classificationID == Enum.QuestClassification.Campaign) or C_CampaignInfo.IsCampaignQuest(questInfo.questID);
    questInfo.isDaily = LocalQuestFilter:IsDaily(questInfo.questID, questInfo);
    questInfo.isRepeatable = C_QuestLog.IsRepeatableQuest(questInfo.questID) or C_QuestLog.IsQuestRepeatableType(questInfo.questID);
    questInfo.isStory = questInfo.isStory or LocalQuestFilter:IsStory(questInfo.questID, questInfo);
    questInfo.isWeekly = LocalQuestFilter:IsWeekly(questInfo.questID, questInfo);

    return questInfo;
end

