--------------------------------------------------------------------------------
--[[ Quest Type Tags - Utility and wrapper functions for handling quest tags. ]]--
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
-- REF.: <https://warcraft.wiki.gg/wiki/API_C_QuestLog.GetQuestTagInfo>
-- (see also the function comments section for more reference)
--
--------------------------------------------------------------------------------

local AddonID, ns = ...

local LocalQuestTagUtil = {}
ns.QuestTagUtil = LocalQuestTagUtil

local QuestFactionGroupID = ns.QuestFactionGroupID  --> <Data.lua>
local LocalQuestInfo = ns.QuestInfo  --> <data\questinfo.lua>

----- Constants ----------------------------------------------------------------

--> TODO - L10n, outsource table `L`
local L = {}
L.CATEGORY_NAME_QUESTLINE = QUEST_CLASSIFICATION_QUESTLINE
L.QUEST_TYPE_NAME_FORMAT_TRIVIAL = string.gsub(TRIVIAL_QUEST_DISPLAY, "|cff000000", '')
L.TEXT_DELIMITER = ITEM_NAME_DESCRIPTION_DELIMITER

-- Upvalues + Wrapper
local QUEST_TAG_ATLAS = QUEST_TAG_ATLAS
local QuestUtils_GetQuestTagAtlas = QuestUtils_GetQuestTagAtlas
local QuestUtils_IsQuestDungeonQuest = QuestUtils_IsQuestDungeonQuest;
local QuestUtils_IsQuestWorldQuest = QuestUtils_IsQuestWorldQuest;

-- Quest tag IDs, additional to `Enum.QuestTag` and `Enum.QuestTagType`
--> REF.: [Enum.QuestTag](https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestLogDocumentation.lua)
--> REF.: [Enum.QuestTagType](https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestConstantsDocumentation.lua)
--
local LocalQuestTag = {}
LocalQuestTag.Class = 21
LocalQuestTag.Escort = 84
LocalQuestTag.Artifact = 107
LocalQuestTag.WorldQuest = 109
LocalQuestTag.BurningLegionWorldQuest = 145
LocalQuestTag.BurningLegionInvasionWorldQuest = 146
LocalQuestTag.WarModePvP = 255
LocalQuestTag.Profession = 267
LocalQuestTag.Threat = 268
LocalQuestTag.CovenantCalling = 271
LocalQuestTag.Important = 282


-- Expand the default quest tag atlas map
-- **Note:** Before adding more tag icons, check if they're not already part of `QUEST_TAG_ATLAS`!
--
local shallowCopy = true;
LocalQuestTagUtil.QUEST_TAG_ATLAS = CopyTable(QUEST_TAG_ATLAS, shallowCopy);
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.Artifact] = "ArtifactQuest"
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.BurningLegionWorldQuest] = "worldquest-icon-burninglegion"  --> Legion Invasion World Quest Wrapper (~= Enum.QuestTagType.Invasion)
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.BurningLegionInvasionWorldQuest] = "legioninvasion-map-icon-portal"  --> Legion Invasion World Quest Wrapper (~= Enum.QuestTagType.Invasion)
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.Class] = "questlog-questtypeicon-class"
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.Escort] = "nameplates-InterruptShield"
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.Profession] = "Profession"
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.WorldQuest] = "worldquest-tracker-questmarker"
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.Threat] = "worldquest-icon-nzoth"   -- "Ping_Map_Threat"
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.WarModePvP] = "questlog-questtypeicon-pvp"
LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.CovenantCalling] = "Quest-DailyCampaign-Available"
LocalQuestTagUtil.QUEST_TAG_ATLAS["CAMPAIGN"] = "Quest-Campaign-Available"
LocalQuestTagUtil.QUEST_TAG_ATLAS["COMPLETED_CAMPAIGN"] = "Quest-Campaign-TurnIn"
LocalQuestTagUtil.QUEST_TAG_ATLAS["COMPLETED_DAILY_CAMPAIGN"] = "Quest-DailyCampaign-TurnIn"
-- LocalQuestTagUtil.QUEST_TAG_ATLAS["COMPLETED_IMPORTANT"] = "questlog-questtypeicon-importantturnin"  -- "quest-important-turnin"
LocalQuestTagUtil.QUEST_TAG_ATLAS["COMPLETED_REPEATABLE"] = "QuestRepeatableTurnin"
LocalQuestTagUtil.QUEST_TAG_ATLAS["DAILY_CAMPAIGN"] = "Quest-DailyCampaign-Available"
-- LocalQuestTagUtil.QUEST_TAG_ATLAS["IMPORTANT"] = "questlog-questtypeicon-important"  -- "quest-important-available"
-- LocalQuestTagUtil.QUEST_TAG_ATLAS[LocalQuestTag.Important] = "questlog-questtypeicon-important"
LocalQuestTagUtil.QUEST_TAG_ATLAS["TRIVIAL_CAMPAIGN"] = "Quest-Campaign-Available-Trivial"
-- LocalQuestTagUtil.QUEST_TAG_ATLAS["TRIVIAL_IMPORTANT"] = "quest-important-available-trivial"
LocalQuestTagUtil.QUEST_TAG_ATLAS["TRIVIAL_LEGENDARY"] = "quest-legendary-available-trivial"
LocalQuestTagUtil.QUEST_TAG_ATLAS["TRIVIAL"] = "TrivialQuests"
-- LocalQuestTagUtil.QUEST_TAG_ATLAS["MONTHLY"] = "questlog-questtypeicon-monthly"

--------------------------------------------------------------------------------

-- These types are handled separately or have fallback handler.
local classificationIgnoreTable = {
	-- Enum.QuestClassification.Important,
	-- Enum.QuestClassification.Legendary,
	Enum.QuestClassification.Campaign,
	Enum.QuestClassification.Calling,
	-- Enum.QuestClassification.Meta,
	-- Enum.QuestClassification.Recurring,
	-- Enum.QuestClassification.Questline,
	Enum.QuestClassification.Normal,
    -- Enum.QuestClassification.BonusObjective,
    -- Enum.QuestClassification.Threat,
    -- Enum.QuestClassification.WorldQuest,
}

local function FormatTagName(tagName, questInfo)
    if questInfo.isTrivial then
        questInfo.hasTrivialTag = true;
        return L.QUEST_TYPE_NAME_FORMAT_TRIVIAL:format(tagName) or tagName;
    end

    return tagName;
end

function LocalQuestTagUtil:ShouldIgnoreQuestTypeTag(questInfo)
    if not questInfo.questTagInfo then return true; end

    local isKnownQuestTypeTag = QuestUtils_IsQuestDungeonQuest(questInfo.questID);
    local shouldIgnoreShownTag = questInfo.isOnQuest and isKnownQuestTypeTag;

    return shouldIgnoreShownTag;
end

LocalQuestTagUtil.defaultIconWidth = 20;
LocalQuestTagUtil.defaultIconHeight = 20;

function LocalQuestTagUtil:GetQuestTagInfoList(questID, baseQuestInfo)
    local questInfo = baseQuestInfo or LocalQuestInfo:GetCustomQuestInfo(questID);
    local width = self.defaultIconWidth;
    local height = self.defaultIconHeight;
    local tagInfoList = {};  --> {{atlasMarkup=..., tagName=..., tagID=...}, ...}

    -- Supported classification details from the game
    local classificationID, classificationText, classificationAtlas, clSize = LocalQuestInfo:GetQuestClassificationDetails(questID);
    if (classificationID and not tContains(classificationIgnoreTable, classificationID)) then
        local atlas = (classificationID == Enum.QuestClassification.Recurring and questInfo.isReadyForTurnIn) and "quest-recurring-turnin" or classificationAtlas;
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup(atlas, width, height),
            ["tagName"] = classificationText,
            ["tagID"] = classificationID,
            ["ranking"] = 1,  -- manually ranking the quest type
        });
    end
    -- Supported quest (type) tags from the game
    if questInfo.questTagInfo then
        local info = {};
        info["tagID"] = questInfo.questTagInfo.tagID;
        info["tagName"] = FormatTagName(questInfo.questTagInfo.tagName, questInfo);
        info["ranking"] = 2;

        if (questInfo.questTagInfo.worldQuestType ~= nil) then
            local atlasName, atlasWidth, atlasHeight = QuestUtil.GetWorldQuestAtlasInfo(questInfo.questID, questInfo.questTagInfo, questInfo.isActive)
            info["atlasMarkup"] = CreateAtlasMarkup(atlasName, width, height);
        else
            -- Check WORLD_QUEST_TYPE_ATLAS and QUEST_TAG_ATLAS for a matching icon, alternatively try our local copy of QUEST_TAG_ATLAS.
            -- Note: works only with `Enum.QuestTag` and partially with `Enum.QuestTagType`. (see `Constants.lua`)
            local atlasName = QuestUtils_GetQuestTagAtlas(questInfo.questTagInfo.tagID, questInfo.questTagInfo.worldQuestType) or self.QUEST_TAG_ATLAS[questInfo.questTagInfo.tagID];
            if atlasName then
                info["atlasMarkup"] = CreateAtlasMarkup(atlasName, width, height);
            end
        end
        if questInfo.isThreat then
            local atlas = QuestUtil.GetThreatPOIIcon(questInfo.questID);
            info["atlasMarkup"] = CreateAtlasMarkup(atlas, width, height);
        end
        if (questInfo.questTagInfo.tagID == Enum.QuestTag.Account and questInfo.questFactionGroup ~= QuestFactionGroupID.Neutral) then
            local factionString = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and FACTION_HORDE or FACTION_ALLIANCE;
            local factionTagID = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and "HORDE" or "ALLIANCE";
            local tagName = questInfo.questTagInfo.tagName..L.TEXT_DELIMITER..PARENS_TEMPLATE:format(factionString);
            info["atlasMarkup"] = CreateAtlasMarkup(self.QUEST_TAG_ATLAS[factionTagID], width, height);
            info["tagName"] = FormatTagName(tagName, questInfo);
        end
        if not self:ShouldIgnoreQuestTypeTag(questInfo) then                         --> TODO - priorities (tagInfo vs. manual vs. classification)
            tinsert(tagInfoList, info);
        elseif questInfo.hasTrivialTag then
            questInfo.hasTrivialTag = nil;
        end
    end
    -- Neglected or unsupported tags prior to Dragonflight (tags unsupported through `questTagInfo`, but still in `QUEST_TAG_ATLAS`)
    local isRecurring = classificationID and classificationID == Enum.QuestClassification.Recurring;
    if (questInfo.isDaily and not isRecurring) then
        local atlas = questInfo.isReadyForTurnIn and "QuestRepeatableTurnin" or self.QUEST_TAG_ATLAS.DAILY;
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup(atlas, width, height),
            ["tagName"] = DAILY,
            ["tagID"] = "D",
            ["ranking"] = 3,
        });
    end
    if (questInfo.isWeekly and not isRecurring) then
        local atlas = questInfo.isReadyForTurnIn and "QuestRepeatableTurnin" or self.QUEST_TAG_ATLAS.WEEKLY
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup(atlas, width, height),
            ["tagName"] = WEEKLY,
            ["tagID"] = "W",
            ["ranking"] = 3,
        });
    end
    -- if (questInfo.isRepeatable and not isRecurring and not (questInfo.isDaily or questInfo.isWeekly) and not questInfo.isWorldQuest) then
    if (questInfo.isRepeatable and not isRecurring and not questInfo.isWorldQuest) then
        local atlas = questInfo.isReadyForTurnIn and "RecurringActiveQuestIcon" or "RecurringAvailableQuestIcon"
        tinsert(tagInfoList, {  -- "quest-recurring-turnin" or "quest-recurring-available"
            ["atlasMarkup"] = CreateAtlasMarkup(atlas, width, height),
            ["tagName"] = MAP_LEGEND_REPEATABLE ,
            ["tagID"] = "R",
            ["ranking"] = 3,
        });
    end
    if questInfo.isFailed then
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup(self.QUEST_TAG_ATLAS.FAILED, width, height),
            ["tagName"] = FAILED,
            ["tagID"] = "F",
            ["ranking"] = 3,
        });
    end
    if questInfo.isStory then
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup(self.QUEST_TAG_ATLAS.STORY, width, height),
            ["tagName"] = STORY_PROGRESS,
            ["tagID"] = "S",
            ["ranking"] = 3,
        });
    end
    -- Unsupported by QuestClassification                                       --> TODO- Check frequently, currently: 11.0.2
    if questInfo.isBonusObjective then
        local bonusClassificationID = Enum.QuestClassification.BonusObjective;
        local bonusClassificationInfo = LocalQuestInfo:GetQuestClassificationInfo(bonusClassificationID);
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup(bonusClassificationInfo.atlas, width, height),
            ["tagName"] = bonusClassificationInfo.text,
            ["tagID"] = bonusClassificationID,
            ["ranking"] = 3,
        });
    end
    if questInfo.isCampaign then
        -- Is supported by classification, but icon is awful.
        local atlas = questInfo.isReadyForTurnIn and "Quest-Campaign-TurnIn" or "Quest-Campaign-Available"
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup(atlas, width, height),
            ["tagName"] = FormatTagName(QUEST_CLASSIFICATION_CAMPAIGN, questInfo),
            ["tagID"] = "C",
            ["ranking"] = 3,
        });
    end
    -- if questInfo.isCalling then
    --     -- Is supported by classification, but icon is awful.
    --     local atlas = questInfo.isReadyForTurnIn and "Quest-DailyCampaign-TurnIn" or "Quest-DailyCampaign-Available";
    --     tinsert(tagInfoList, {
    --         ["atlasMarkup"] = CreateAtlasMarkup(atlas, width, height),
    --         ["tagName"] = FormatTagName(QUEST_CLASSIFICATION_CALLING, questInfo),
    --         ["tagID"] = "CC",
    --         ["ranking"] = 3,
    --     });
    -- end
    if (questInfo.hasQuestLineInfo and ns.settings.showTagQuestline) then
        local questlineClassificationID = Enum.QuestClassification.Questline;
        local questlineClassificationInfo = LocalQuestInfo:GetQuestClassificationInfo(questlineClassificationID);
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup(questlineClassificationInfo.atlas, width, height),
            ["tagName"] = questlineClassificationInfo.text,
            ["tagID"] = questlineClassificationID,
            ["ranking"] = 3,
        });
    end
    -- Legacy Tags (removed by Blizzard from `QUEST_TAG_ATLAS`)
    if questInfo.isAccountQuest then
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup("questlog-questtypeicon-account", width, height),
            ["tagName"] = ACCOUNT_QUEST_LABEL,
            ["tagID"] = Enum.QuestTag.Account,
            ["ranking"] = 3,
        });
    end
    -- Custom tags
    if questInfo.isAccountCompleted then
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup("questlog-questtypeicon-account", width, height),
            ["tagName"] = ACCOUNT_COMPLETED_QUEST_LABEL,
            ["tagID"] = -1,
            ["ranking"] = 4,
        });
    end
    if questInfo.isCompleted then       --> Test
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup("questlog-questtypeicon-wrapperturnin", width, height),
            ["tagName"] = GOAL_COMPLETED,
            ["tagID"] = -1,
            ["ranking"] = 4,
        });
    end
    if questInfo.wasEarnedByMe then     --> Test
        local TEXT_DELIMITER = ITEM_NAME_DESCRIPTION_DELIMITER;
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup("UI-Achievement-Shield-2", width, height / 1.1272),
            ["tagName"] = QUEST_COMPLETE..HEADER_COLON..TEXT_DELIMITER..UnitName("player"),
            ["tagID"] = -1,
            ["ranking"] = 4,
        });
    end

    self:AddTrivialQuestTagInfo(questInfo, tagInfoList);

    if (not questInfo.questTagInfo or questInfo.questTagInfo.tagID ~= Enum.QuestTag.Account) and (questInfo.questFactionGroup ~= QuestFactionGroupID.Neutral) then
        -- Add *faction group icon only* when no questTagInfo provided or not an account-wide quest
        local tagName = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and FACTION_HORDE or FACTION_ALLIANCE;
        local factionTagID = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and "HORDE" or "ALLIANCE";
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup(self.QUEST_TAG_ATLAS[factionTagID], width, height),
            ["tagName"] = tagName,
            ["tagID"] = factionTagID,
            ["ranking"] = 5,
        });
    end

    return tagInfoList, questInfo;
end


-- Return all available quest tags for given quest.
---@param questID number
---@param iconWidth number
---@param iconHeight number|nil  Defaults to the size of `iconWidth`.
---@return table|nil tagData  --> `{tagName: string = tagAtlasMarkup: string, ...}` or `nil`.
--
-- REF.: [Constants.lua](https://www.townlong-yak.com/framexml/live/Blizzard_FrameXMLBase/Constants.lua),
--       [QuestUtils.lua](https://www.townlong-yak.com/framexml/live/Blizzard_FrameXMLUtil/QuestUtils.lua)
--
function LocalQuestTagUtil:GetAllQuestTags(questID, iconWidth, iconHeight)
    local questInfo = LocalQuestInfo:GetCustomQuestInfo(questID)
    local width, height = iconWidth, iconHeight or iconWidth
    local tagData = {}
    -- Neglected tags (tags unsupported through `questTagInfo`, but still in `QUEST_TAG_ATLAS`)
    -- if questInfo.isReadyForTurnIn then                                       --> TODO - Keep ???
    --     local atlasMarkup = CreateAtlasMarkup(QUEST_TAG_ATLAS.COMPLETED, width, height)
    --     tagData[GOAL_COMPLETED] = atlasMarkup
    -- end
    if questInfo.isDaily then
        local atlas = questInfo.isReadyForTurnIn and "QuestRepeatableTurnin" or QUEST_TAG_ATLAS.DAILY
        local atlasMarkup = CreateAtlasMarkup(atlas, width, height)
        tagData[DAILY] = atlasMarkup
    end
    if questInfo.isWeekly then
        local atlas = questInfo.isReadyForTurnIn and "QuestRepeatableTurnin" or QUEST_TAG_ATLAS.WEEKLY
        local atlasMarkup = CreateAtlasMarkup(atlas, width, height)
        tagData[WEEKLY] = atlasMarkup
    end
    if questInfo.isFailed then
        local atlasMarkup = CreateAtlasMarkup(QUEST_TAG_ATLAS.FAILED, width, height)
        tagData[FAILED] = atlasMarkup
    end
    if questInfo.isAccountCompleted then
        local atlasMarkup = CreateAtlasMarkup("questlog-questtypeicon-account", width, height)
        tagData[ACCOUNT_COMPLETED_QUEST_LABEL ] = atlasMarkup
    end
    -- Prefer classification over tag IDs
    if (questInfo.questClassification and not tContains(classificationIgnoreTable, questInfo.questClassification)) then  --> Enum.QuestClassification
        local classificationID, classificationText, classificationAtlas, clSize = QuestUtil.GetQuestClassificationDetails(questInfo.questID)
        -- Note: Blizzard seems to currently prioritize the classification details over tag infos.
        local fallbackAtlas, fallbackText = "common-icon-forwardarrow-disable", UNKNOWN
        local atlasMarkup = CreateAtlasMarkup(classificationAtlas or fallbackAtlas, width, height)
        tagData[classificationText or fallbackText] = atlasMarkup
    end
    -- Quest (type) tags
    if questInfo.questTagInfo then
        if (questInfo.questTagInfo.worldQuestType ~= nil) then
            local atlasName, atlasWidth, atlasHeight = QuestUtil.GetWorldQuestAtlasInfo(questInfo.questID, questInfo.questTagInfo, questInfo.isActive)
            local atlasMarkup = CreateAtlasMarkup(atlasName, width, height)
            tagData[questInfo.questTagInfo.tagName] = atlasMarkup
        end
        -- Check WORLD_QUEST_TYPE_ATLAS and QUEST_TAG_ATLAS for a matching icon.
        -- Note: works only with `Enum.QuestTag` and partially with `Enum.QuestTagType`. (see `Constants.lua`)
        local atlasName = QuestUtils_GetQuestTagAtlas(questInfo.questTagInfo.tagID, questInfo.questTagInfo.worldQuestType)
        if atlasName then
            local atlasMarkup = CreateAtlasMarkup(atlasName, width, height)
            tagData[questInfo.questTagInfo.tagName] = atlasMarkup
        end
        if (questInfo.questTagInfo.tagID == Enum.QuestTagType.Threat or questInfo.isThreat) then
            local atlas = QuestUtil.GetThreatPOIIcon(questInfo.questID)
            local atlasMarkup = CreateAtlasMarkup(atlas, width, height)
            tagData[questInfo.questTagInfo.tagName] = atlasMarkup
        end
        if (questInfo.questTagInfo.tagID == Enum.QuestTag.Account and questInfo.questFactionGroup ~= QuestFactionGroupID.Neutral) then
            local factionString = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and FACTION_HORDE or FACTION_ALLIANCE
            local tagID = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and "HORDE" or "ALLIANCE"
            local tagName = questInfo.questTagInfo.tagName..L.TEXT_DELIMITER..PARENS_TEMPLATE:format(factionString)
            local atlasMarkup = CreateAtlasMarkup(QUEST_TAG_ATLAS[tagID], width, height)
            tagData[tagName] = atlasMarkup
        end
    end
    if (not questInfo.questTagInfo or questInfo.questTagInfo.tagID ~= Enum.QuestTag.Account) and (questInfo.questFactionGroup ~= QuestFactionGroupID.Neutral) then
        -- Add faction group icon only when no questTagInfo provided or not an account-wide quest
        local tagName = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and ITEM_REQ_HORDE or ITEM_REQ_ALLIANCE
        local tagID = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and "HORDE" or "ALLIANCE"
        local atlasMarkup = CreateAtlasMarkup(QUEST_TAG_ATLAS[tagID], width, height)
        tagData[tagName] = atlasMarkup
    end
	if (QuestUtils_ShouldDisplayExpirationWarning(questInfo.questID) and QuestUtils_IsQuestWithinLowTimeThreshold(questInfo.questID)) then
        local atlas = QuestUtils_IsQuestWithinCriticalTimeThreshold(questInfo.questID) and "questlog-questtypeicon-clockorange" or "questlog-questtypeicon-clockyellow"
        local atlasMarkup = CreateAtlasMarkup(atlas, width, height)
        tagData[PROFESSIONS_COLUMN_HEADER_EXPIRATION] = atlasMarkup
    end
    if questInfo.isStory then
        local atlasMarkup = CreateAtlasMarkup(QUEST_TAG_ATLAS.STORY, width, height)
        tagData[STORY_PROGRESS] = atlasMarkup
    end
    -- Legacy Tags (removed by Blizzard from `QUEST_TAG_ATLAS`)
    if questInfo.isAccountQuest then
        local tagName = Enum.QuestTag.Account
        local atlasMarkup = CreateAtlasMarkup(QUEST_TAG_ATLAS[tagName] or "questlog-questtypeicon-account", width, height)
        tagData[ACCOUNT_QUEST_LABEL] = atlasMarkup
    end
    if questInfo.isLegendary then
        local tagName = questInfo.isReadyForTurnIn and "COMPLETED_LEGENDARY" or Enum.QuestTag.Legendary
        local atlasMarkup = CreateAtlasMarkup(QUEST_TAG_ATLAS[tagName] or "questlog-questtypeicon-legendary", width, height)
        tagData[MAP_LEGEND_LEGENDARY] = atlasMarkup
    end
    -- Custom tags
    if questInfo.hasQuestLineInfo then
        local atlasMarkup = CreateAtlasMarkup("questlog-storylineicon", width, height)
        tagData[L.CATEGORY_NAME_QUESTLINE] = atlasMarkup
    end
    if questInfo.isTrivial then
        local atlasMarkup = CreateAtlasMarkup("TrivialQuests", width, height)
        local tagName = L.QUEST_TYPE_NAME_FORMAT_TRIVIAL:format(UNIT_NAMEPLATES_SHOW_ENEMY_MINUS)
        tagData[tagName] = atlasMarkup
    end
    if questInfo.isCampaign then -- and not questInfo.isDaily and not questInfo.isWeekly) then
        local atlas = questInfo.isReadyForTurnIn and "Quest-Campaign-TurnIn" or "Quest-Campaign-Available"
        local atlasMarkup = CreateAtlasMarkup(atlas, width, height)
        tagData[MAP_LEGEND_CAMPAIGN] = atlasMarkup
    end
    if questInfo.isBonusObjective then
        local atlasMarkup = CreateAtlasMarkup("QuestBonusObjective", width, height)
        tagData[MAP_LEGEND_BONUSOBJECTIVE] = atlasMarkup
    end
    -- if questInfo.isDaily then
    --     local atlas, tagName;
    --     if questInfo.isCampaign then
    --         atlas = questInfo.isReadyForTurnIn and "Quest-DailyCampaign-TurnIn" or "Quest-DailyCampaign-Available"
    --         tagName = MAP_LEGEND_CAMPAIGN..L.TEXT_DELIMITER..PARENS_TEMPLATE:format(DAILY)
    --     else
    --         atlas = questInfo.isReadyForTurnIn and "QuestRepeatableTurnin" or "QuestDaily"
    --         tagName = DAILY  -- ERR_QUEST_OBJECTIVE_COMPLETE_S:format(DAILY)
    --     end
    --     if atlas then
    --         local atlasMarkup = CreateAtlasMarkup(atlas, width, height)
    --         tagData[tagName] = atlasMarkup
    --     end
    -- end

    if tagData ~= {} then
        -- table.sort(tagData, function(a, b)
        --     return a[0] < b[0];  --> 0-9
        -- end)
        return tagData
    end
end

function LocalQuestTagUtil:AddTrivialQuestTagInfo(questInfo, tagInfoList)
    if (#tagInfoList < 2 and (questInfo.isTrivial and not questInfo.hasTrivialTag)) then
        -- Add a standalone "trivial" tag
        tinsert(tagInfoList, {
            ["atlasMarkup"] = CreateAtlasMarkup("TrivialQuests", 20, 20),
            ["tagName"] = L.QUEST_TYPE_NAME_FORMAT_TRIVIAL:format(UNIT_NAMEPLATES_SHOW_ENEMY_MINUS),
            ["tagID"] = "T",
            ["ranking"] = 0,
            ["alpha"] = 0.5,
        });
    end
end

