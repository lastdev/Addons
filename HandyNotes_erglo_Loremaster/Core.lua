--------------------------------------------------------------------------------
--[[ HandyNotes: Loremaster ]]--
--
-- by erglo <erglo.coder+HNLM@gmail.com>
--
-- Copyright (C) 2023  Erwin D. Glockner (aka erglo)
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
--
-- Ace3 API reference:
-- REF.: <https://www.wowace.com/projects/ace3/pages/getting-started>
--
-- HandyNotes API reference:
-- REF.: <https://www.curseforge.com/wow/addons/handynotes>
-- REF.: <https://github.com/Nevcairiel/HandyNotes/blob/master/HandyNotes.lua>
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
-- (see also the function comments section for more reference)
--
--------------------------------------------------------------------------------

local AddonID, ns = ...

local loadSilent = true
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", loadSilent)
if not HandyNotes then
    error("Embedded library/addon required: HandyNotes", 0)
    return
end

local LibQTip = LibStub('LibQTip-1.0')
local ContentTooltip, ZoneStoryTooltip, CampaignTooltip

local LibQTipUtil = ns.utils.libqtip
local LocalAchievementUtil = ns.utils.achieve
local LocalMapUtils = ns.utils.worldmap

local LoreUtil = ns.lore  --> <Data.lua>
LoreUtil.storyQuests = {}

local DBUtil = ns.DatabaseUtil  --> <data\database.lua>
local LocalQuestCache = ns.QuestCacheUtil  --> <data\questcache.lua>
local LocalQuestFilter = ns.QuestFilter  --> <data\questfilter.lua>
local LocalQuestInfo = ns.QuestInfo  --> <data\questinfo.lua>
local LocalQuestTagUtil = ns.QuestTagUtil  --> <data\questtypetags.lua>

local format, tostring, strlen, strtrim, string_gsub = string.format, tostring, strlen, strtrim, string.gsub
local tContains, tInsert, tAppendAll = tContains, table.insert, tAppendAll

local C_QuestLog, C_QuestLine, C_CampaignInfo = C_QuestLog, C_QuestLine, C_CampaignInfo
local QuestUtils_GetQuestName, QuestUtils_GetQuestTagAtlas = QuestUtils_GetQuestName, QuestUtils_GetQuestTagAtlas
local QuestUtils_IsQuestWorldQuest, QuestUtils_IsQuestBonusObjective = QuestUtils_IsQuestWorldQuest, QuestUtils_IsQuestBonusObjective
local QuestUtils_IsQuestDungeonQuest = QuestUtils_IsQuestDungeonQuest
local QuestUtil = QuestUtil
local GetQuestFactionGroup, GetQuestUiMapID, QuestHasPOIInfo = GetQuestFactionGroup, GetQuestUiMapID, QuestHasPOIInfo
local IsBreadcrumbQuest, IsQuestSequenced, IsStoryQuest = IsBreadcrumbQuest, IsQuestSequenced, IsStoryQuest
local GetQuestExpansion, UnitFactionGroup = GetQuestExpansion, UnitFactionGroup
local C_Map = C_Map  -- C_TaskQuest
local C_QuestInfoSystem = C_QuestInfoSystem

local GREEN_FONT_COLOR, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR = GREEN_FONT_COLOR, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR
local BRIGHTBLUE_FONT_COLOR = BRIGHTBLUE_FONT_COLOR

local CATEGORY_NAME_COLOR = GRAY_FONT_COLOR
local ZONE_STORY_HEADER_COLOR = ACHIEVEMENT_COLOR
local QUESTLINE_HEADER_COLOR = SCENARIO_STAGE_COLOR
local CAMPAIGN_HEADER_COLOR = CAMPAIGN_COMPLETE_COLOR

local YELLOW = function(txt) return YELLOW_FONT_COLOR:WrapTextInColorCode(txt) end
local GRAY = function(txt) return GRAY_FONT_COLOR:WrapTextInColorCode(txt) end
local GREEN = function(txt) return FACTION_GREEN_COLOR:WrapTextInColorCode(txt) end
local RED = function(txt) return RED_FONT_COLOR:WrapTextInColorCode(txt) end
local ORANGE = function(txt) return ORANGE_FONT_COLOR:WrapTextInColorCode(txt) end
local BLUE = function(txt) return BRIGHTBLUE_FONT_COLOR:WrapTextInColorCode(txt) end  -- PURE_BLUE_COLOR, LIGHTBLUE_FONT_COLOR 
local HIGHLIGHT = function(txt) return HIGHLIGHT_FONT_COLOR:WrapTextInColorCode(txt) end

local function StringIsEmpty(str)
	return str == nil or strlen(str) == 0
end

-- local L = LibStub('AceLocale-3.0'):GetLocale(ADDON_NAME)
-- local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes", true)
local L = {}
-- WoW global strings
L.OPTION_STATUS_DISABLED = VIDEO_OPTIONS_DISABLED
L.OPTION_STATUS_ENABLED = VIDEO_OPTIONS_ENABLED
L.OPTION_STATUS_FORMAT = SLASH_TEXTTOSPEECH_HELP_FORMATSTRING
L.OPTION_STATUS_FORMAT_READY = LFG_READY_CHECK_PLAYER_IS_READY  -- "%s is ready."

L.CONGRATULATIONS = SPLASH_BOOST_HEADER

L.TEXT_DELIMITER = ITEM_NAME_DESCRIPTION_DELIMITER
L.TEXT_OPTIONAL = string_gsub(AUCTION_HOUSE_BUYOUT_OPTIONAL_LABEL, "|cff777777", NORMAL_FONT_COLOR_CODE)
L.GENERIC_FORMAT_FRACTION_STRING = GENERIC_FRACTION_STRING  --> "%d/%d"

L.ACHIEVEMENT_NOT_COMPLETED_BY  = string_gsub(ACHIEVEMENT_NOT_COMPLETED_BY, "HIGHLIGHT_FONT_COLOR", "BRIGHTBLUE_FONT_COLOR")

L.CATEGORY_NAME_ZONE_STORY = ZONE  --> WoW global string
L.CATEGORY_NAME_QUESTLINE = QUEST_CLASSIFICATION_QUESTLINE
L.CATEGORY_NAME_CAMPAIGN = QUEST_CLASSIFICATION_CAMPAIGN

L.QUEST_NAME_FORMAT_ALLIANCE = "%s |A:questlog-questtypeicon-alliance:16:16:0:-1|a"
L.QUEST_NAME_FORMAT_HORDE = "%s |A:questlog-questtypeicon-horde:16:16:0:-1|a"
L.QUEST_NAME_FORMAT_NEUTRAL = "%s"
L.QUEST_TYPE_NAME_FORMAT_TRIVIAL = string_gsub(TRIVIAL_QUEST_DISPLAY, "|cff000000", '')
-- MINIMAP_TRACKING_TRIVIAL_QUESTS = "Niedrigstufige Quests";                   --> TODO - Add requirement to activate trivial quest tracking

L.ZONE_NAME_FORMAT = "|T137176:16:16:0:-1|t %s"  -- 136366
L.ZONE_ACHIEVEMENT_NAME_FORMAT_COMPLETE = "%s |A:achievementcompare-YellowCheckmark:0:0:1:0|a"
L.ZONE_ACHIEVEMENT_NAME_FORMAT_INCOMPLETE = "%s"
L.ZONE_ACHIEVEMENT_ICON_NAME_FORMAT_COMPLETE = "|T%d:16:16:0:0|t %s  |A:achievementcompare-YellowCheckmark:0:0|a"
L.ZONE_ACHIEVEMENT_ICON_NAME_FORMAT_INCOMPLETE = "|T%d:16:16:0:0|t %s"
L.ZONE_NAME_ACCOUNT_ACHIEVEMENT_FORMAT = "%s |A:questlog-questtypeicon-account:0:0:1:0|a"

L.HINT_HOLD_KEY_FORMAT = "<Hold %s to see details>"
L.HINT_HOLD_KEY_FORMAT_HOVER = "<Hold %s and hover icon to see details>"
L.HINT_VIEW_ACHIEVEMENT_CRITERIA = "<Shift-hover to view chapters>"
L.HINT_VIEW_ACHIEVEMENT = "<Shift-click to view achievement>"  -- KEY_BUTTON1, KEY_BUTTON2 
L.HINT_SET_WAYPOINT = "<Alt-click to create waypoint>"

L.QUESTLINE_NAME_FORMAT = "|TInterface\\Icons\\INV_Misc_Book_07:16:16:0:-1|t %s"
L.QUESTLINE_CHAPTER_NAME_FORMAT = "|A:Campaign-QuestLog-LoreBook-Back:16:16:0:0|a %s"
L.QUESTLINE_PROGRESS_FORMAT = string_gsub(QUEST_LOG_COUNT_TEMPLATE, "%%s", "|cffffffff")

L.CAMPAIGN_NAME_FORMAT_COMPLETE = "|A:Campaign-QuestLog-LoreBook:16:16:0:0|a %s  |A:achievementcompare-YellowCheckmark:0:0|a"
L.CAMPAIGN_NAME_FORMAT_INCOMPLETE = "|A:Campaign-QuestLog-LoreBook:16:16:0:0|a %s"
L.CAMPAIGN_PROGRESS_FORMAT = "|"..string_gsub(strtrim(CAMPAIGN_PROGRESS_CHAPTERS_TOOLTIP, "|n"), "[|]n[|]c", HEADER_COLON.." |c", 1)
L.CAMPAIGN_TYPE_FORMAT_QUEST = "This quest is part of the %s campaign."
-- L.CAMPAIGN_TYPE_FORMAT_QUESTLINE = "|A:Campaign-QuestLog-LoreBook-Back:16:16:0:0|a This questline is part of the %s campaign."

L.CHAPTER_NAME_FORMAT_COMPLETED = "|TInterface\\Scenarios\\ScenarioIcon-Check:16:16:0:-1|t %s"
L.CHAPTER_NAME_FORMAT_NOT_COMPLETED = "|TInterface\\Scenarios\\ScenarioIcon-Dash:16:16:0:-1|t %s"
L.CHAPTER_NAME_FORMAT_CURRENT = "|A:common-icon-forwardarrow:16:16:2:-1|a %s"

-- Custom strings
L.SLASHCMD_USAGE = "Usage:"

-- local LibDD = LibStub:GetLibrary('LibUIDropDownMenu-4.0')

local CHECKMARK_ICON_STRING = "|A:achievementcompare-YellowCheckmark:0:0|a"
local UNKNOWN = UNKNOWN

local nodes = {}
ns.nodes = nodes

----- Debugging -----

local DEV_MODE = false

local debug = {}
debug.isActive = DEV_MODE
debug.showChapterIDsInTooltip = DEV_MODE
debug.print = function(self, ...)
    local prefix = "LM-DBG"
    if type(...) == "table" then
        local t = ...
        if t.debug then
            print(YELLOW(prefix.." "..t.debug_prefix), select(2, ...))
        end
    elseif self.isActive then
        print(YELLOW(prefix..":"), ...)
    end
end

local HookUtils =           { debug = false, debug_prefix = "HOOKS:" }
local CampaignUtils =       { debug = false, debug_prefix = "CP:" }
local LocalQuestUtils =     { debug = false, debug_prefix = ORANGE("QuestUtils:") }
local LocalQuestLineUtils = { debug = false, debug_prefix = "QL:" }
local ZoneStoryUtils =      { debug = false, debug_prefix = "ZS:" }
-- MergeTable(LocalMapUtils,   { debug = false, debug_prefix = "MAP:" })
local LocalUtils = {}

--> TODO: CampaignCache, QuestCache

-- In debug mode show additional infos in a quest icon's tooltip, eg. questIDs,
-- achievementIDs, etc.
function debug:AddDebugLineToLibQTooltip(tooltip, debugInfo)
    local text = debugInfo and debugInfo.text
    local addBlankLine = debugInfo and debugInfo.addBlankLine
    if debug.isActive then
        if text then LibQTipUtil:AddDisabledLine(tooltip, text) end
    elseif addBlankLine then
        LibQTipUtil:AddBlankLineToTooltip(tooltip)
    end
end

-- In debug mode show additional quest data.
function debug:CreateDebugQuestInfoTooltip(pin)
    pin.questInfo.pinMapID = GRAY(tostring(pin.mapID))
    debug.tooltip = LibQTip:Acquire(AddonID.."DebugLibQTooltip", 2, "LEFT", "RIGHT")
    LibQTipUtil:SetTitle(debug.tooltip, ns.pluginInfo.title, GRAY("questInfo"))
    local lineIndex, Column1Color, Column2Color
    for k, v in pairs(pin.questInfo) do
        lineIndex = debug.tooltip:AddLine(k, tostring(v))
        Column1Color = (v == true) and GREEN_FONT_COLOR or NORMAL_FONT_COLOR
        Column2Color = (v == true) and GREEN_FONT_COLOR or HIGHLIGHT_FONT_COLOR
        debug.tooltip:SetCellTextColor(lineIndex, 1, Column1Color:GetRGBA())
        debug.tooltip:SetCellTextColor(lineIndex, 2, Column2Color:GetRGBA())
    end
    local tagData = LocalQuestTagUtil:GetAllQuestTags(pin.questID, 20, 20)
    if tagData then
        for tagLabel, tagAtlasMarkup in pairs(tagData) do
            local text = string.format("%s %s", tagAtlasMarkup, tagLabel)
            local tagID = pin.questInfo.questTagInfo and pin.questInfo.questTagInfo.tagID or (pin.questInfo.questClassification or (pin.questType and pin.questType or "??"))
            lineIndex = debug.tooltip:AddLine(text, tostring(tagID))
        end
    end
    debug.tooltip:AddLine('New:')  --> blank line
    local tagInfoList = LocalQuestTagUtil:GetQuestTagInfoList(pin.questID, pin.questInfo)
    if (#tagInfoList > 0) then
        for _, tagInfo in ipairs(tagInfoList) do
            local text = string.format("%s %s", tagInfo.atlasMarkup or '', tagInfo.tagName or UNKNOWN)
            lineIndex = debug.tooltip:AddLine(text, tostring(tagInfo.tagID))
            -- if tagInfo.alpha then
            if pin.questInfo.isTrivial then     --> TODO - Add to settings
                local r, g, b = NORMAL_FONT_COLOR:GetRGB()
                -- local LineColor = CreateColor(r, g, b, tagInfo.alpha)
                debug.tooltip:SetCellTextColor(lineIndex, 1, r, g, b, tagInfo.alpha)
            end
        end
    end
end

----- Main ---------------------------------------------------------------------

local LoremasterPlugin = LibStub("AceAddon-3.0"):NewAddon("Loremaster", "AceConsole-3.0", "AceEvent-3.0")
--> AceConsole is used for chat frame related functions, eg. printing or slash commands
--> AceEvent is used for global event handling

function LoremasterPlugin:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("LoremasterDB", ns.pluginInfo.defaultOptions)
    --> Available AceDB sub-tables: char, realm, class, race, faction, factionrealm, factionrealmregion, profile, and global

    ns.settings = self.db.profile  --> All characters using the same profile share this database.
    ns.data = self.db.global  --> All characters on the same account share this database.
    ns.charDB = self.db.char

    self.options = ns.pluginInfo:InitializeOptions(LoremasterPlugin)

    -- Register options to Ace3 for a standalone config window
    LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(AddonID, self.options)  --> TODO - Check if library files are needed

    -- Register this addon + options to HandyNotes as a plugin
    HandyNotes:RegisterPluginDB(AddonID, self, self.options)

    ns.cprint = function(s, ...) self:Print(...) end
    ns.cprintf = function(s, ...) self:Printf(...) end

    self.slash_commands = {"lm", "loremaster"}                                  --> TODO - Keep slash commands ???
    self.hasRegisteredSlashCommands = false

    self:RegisterHooks()    --> TODO - Switch to AceHook for unhooking

    -- LoreUtil:PrepareData()
    -- print("num storyQuests:", #LoreUtil.storyQuests)
end

function LoremasterPlugin:OnEnable()
    -- Register slash commands via AceConsole
    for i, command in ipairs(self.slash_commands) do
        self:RegisterChatCommand(command, "ProcessSlashCommands")
    end
    self.hasRegisteredSlashCommands = true

    LocalQuestFilter:Init()

    -- Clean-up
    if ns.charDB["activeQuestlines"] then
        Temp_ConvertActiveQuestlineQuests()
        DBUtil:DeleteDbCategory("activeQuestlines")
    end
    -- if (Temp_CountOldActiveQuests() > 0) then
    --     Temp_RemoveOldActiveQuests()
    --     Temp_CountOldActiveQuests()
    -- end

    if ns.settings.showWelcomeMessage then
        self:Printf(L.OPTION_STATUS_FORMAT_READY, YELLOW(ns.pluginInfo.title))
    end
end

function LoremasterPlugin:OnDisable()
    -- Unregister slash commands from via AceConsole
    if self.hasRegisteredSlashCommands then
        for i, command in ipairs(self.slash_commands) do
            self:UnregisterChatCommand(command)
        end
    end
    self.hasRegisteredSlashCommands = false

    --> TODO - Add unhooking

    self:Printf(L.OPTION_STATUS_FORMAT, YELLOW(ns.pluginInfo.title), L.OPTION_STATUS_DISABLED)
end

----- Slash Commands ----------

local function OpenHandyNotesPluginSettings()
    -- HideUIPanel(WorldMapFrame)
    Settings.OpenToCategory(HandyNotes.name)
    LibStub('AceConfigDialog-3.0'):SelectGroup(HandyNotes.name, 'plugins', AddonID, "about")
end

function LoremasterPlugin:ProcessSlashCommands(msg)
    -- Process the slash command ('input' contains whatever follows the slash command)
    -- Registered in :OnEnable()
    local input = strtrim(msg)

    if (input == "help") then
        -- Print usage message to chat
        self:Print(L.SLASHCMD_USAGE, format(" '/%s <%s>'", self.slash_commands[1], YELLOW("arg")), "|",
        format(" '/%s <%s>'", self.slash_commands[2], YELLOW("arg")))

        -- local arg_list = {
        --     version = "Display addon version",
        --     config = "Display settings",
        -- }
        -- for arg_name, arg_description in pairs(arg_list) do
        --     self:Print(" ", L.OBJECTIVE_FORMAT:format(YELLOW(arg_name..":")), arg_description)
        -- end

    elseif (input == "version") then
        self:Print(ns.pluginInfo.version)

    elseif (input == "config" or input == "about") then
        OpenHandyNotesPluginSettings()

    else
        -- Without any input open stand-alone settings frame.
        LibStub("AceConfigDialog-3.0"):Open(AddonID)

    end
end

--------------------------------------------------------------------------------
----- Tooltip Data Handler -----------------------------------------------------
--------------------------------------------------------------------------------

local function GetCollapseTypeModifier(isComplete, varName)
    local types = {
        auto = (not isComplete) or IsShiftKeyDown(),
        hide = IsShiftKeyDown(),
        show = true,
        singleLine = false,
    }
    return types[ns.settings[varName]]
end

function LibQTipUtil:AddPluginNameLine(tooltip)
    local lineIndex = LibQTipUtil:AddColoredLine(tooltip, CATEGORY_NAME_COLOR, '')
    tooltip:SetCell(lineIndex, 1, LoremasterPlugin.name, nil, "RIGHT")  -- replaces line above with the new adjustments
end

function LibQTipUtil:AddCategoryNameLine(tooltip, name, categoryNameOnly)
    local lineText, lineIndex
    if categoryNameOnly then
        lineText = ns.settings.showCategoryNames and name or " "  --> string must not be empty or line won't be created

    elseif (ns.settings.showPluginName or ns.settings.showCategoryNames) then
        local pluginName = ns.settings.showPluginName and LoremasterPlugin.name or ''
        local delimiter = (ns.settings.showPluginName and ns.settings.showCategoryNames) and "|TInterface\\Scenarios\\ScenarioIcon-Dash:16:16:0:-1|t" or ''
        local categoryName = ns.settings.showCategoryNames and name or ''
        lineText = pluginName .. delimiter .. categoryName
    end
    if ( tooltip == ContentTooltip and StringIsEmpty(lineText) ) then
        -- Need an empty line in this case
        lineText = " "
    end
    lineIndex = LibQTipUtil:AddColoredLine(tooltip, CATEGORY_NAME_COLOR, '')
    tooltip:SetCell(lineIndex, 1, lineText, nil, "RIGHT")  -- replaces line above with the new adjustments
end

-- Adds a custom line with an indention before a GRAY text to a `LibQTip.Tooltip`.
function LibQTipUtil:AddDescriptionLine(tooltip, text, leftPadding, justify, maxWidth)
    local lineIndex = LibQTipUtil:AddDisabledLine(tooltip, '')
    --> REF.: qTip:SetCell(lineNum, colNum, value[, font][, justification][, colSpan][, provider][, leftPadding][, rightPadding][, maxWidth][, minWidth][, ...])
    tooltip:SetCell(lineIndex, 1, text, nil, justify or "LEFT", nil, nil, leftPadding or 20, nil, maxWidth or 400)
end

----- Zone Story ----------

ZoneStoryUtils.storiesOnMap = {}  --> { [mapID] = {storyAchievementID, storyAchievementID2, storyMapInfo}, ... }
ZoneStoryUtils.achievements = {}  --> { [achievementID] = achievementInfo, ... }

local ZoneExceptions = { LocalMapUtils.RUINS_OF_GILNEAS_MAP_ID }

-- Return the achievement ID for given zone.  
-- **Note:** Shadowlands + Dragonflight have 2 story achievements per zone.
---@param mapID number
---@param prepareCache boolean|nil
---@return number|nil storyAchievementID
---@return number|nil storyAchievementID2
---@return number|nil storyMapInfo
--
function ZoneStoryUtils:GetZoneStoryInfo(mapID, prepareCache)
    if not self.storiesOnMap[mapID] then
        local storyAchievementID, storyMapID = C_QuestLog.GetZoneStoryInfo(mapID)
        local achievementMapID = storyMapID or mapID
        local manualStoryAchievementID, storyAchievementID2 = nil, nil
        if (LoreUtil.AchievementsLocationMap[achievementMapID] ~= nil) then
            manualStoryAchievementID, storyAchievementID2 = SafeUnpack(LoreUtil.AchievementsLocationMap[achievementMapID])
        end
        local achievementID = not tContains(ZoneExceptions, achievementMapID) and storyAchievementID or manualStoryAchievementID  -- Prefer Blizzard's achievements
        if not achievementID then return end

        local mapInfo = LocalMapUtils:GetMapInfo(achievementMapID)
        self.storiesOnMap[mapID] = {achievementID, storyAchievementID2, mapInfo}
        debug:print(self, "Added zone story:", achievementID, achievementMapID, mapInfo.name)
        if storyAchievementID2 then
            debug:print(self, "Added 2nd zone story:", storyAchievementID2, achievementMapID, mapInfo.name)
        end
    end
    if not prepareCache then
        return SafeUnpack(self.storiesOnMap[mapID])
    end
end

function ZoneStoryUtils:HasZoneStoryInfo(mapID)
    return self.storiesOnMap[mapID] ~= nil
end

-- local function WasEarnedByMe(achievementInfo)
--     -- local isAccountWideAchievement = LoreUtil:IsAccountWideAchievement(achievementInfo.flags)
--     -- local earnedBy = achievementInfo.earnedBy
--     -- local wasEarnedByMe = achievementInfo.earnedBy == playerName
--     print(achievementInfo.achievementID, achievementInfo.earnedBy, playerName, achievementInfo.earnedBy == playerName)
--     return achievementInfo.earnedBy == playerName
-- end

-- Check if your current char or someone of your War Band has completed the given quest.
---@param questInfo QuestInfo|table
---@param questID number|nil
---@return boolean isCompleted
--
function LocalQuestUtils:IsQuestCompletedByAnyone(questInfo, questID)
    if questID then
        return C_QuestLog.IsQuestFlaggedCompleted(questID) or C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)
    end
    if questInfo then
        return questInfo.isFlaggedCompleted or questInfo.isAccountCompleted
    end

    return false
end

function ZoneStoryUtils:GetAchievementInfo(achievementID)
    if not achievementID then return end

    if not self.achievements[achievementID] then
        local achievementInfo = LocalAchievementUtil.GetWrappedAchievementInfo(achievementID)
        achievementInfo.numCriteria = LocalAchievementUtil.GetWrappedAchievementNumCriteria(achievementID)
        achievementInfo.numCompleted = 0  --> track char-specific progress
        achievementInfo.criteriaList = {}
        for criteriaIndex=1, achievementInfo.numCriteria do
            local criteriaInfo = LocalAchievementUtil.GetWrappedAchievementCriteriaInfo(achievementID, criteriaIndex)
            if criteriaInfo then
                -- -- Note: Currently (WoW 11.0.0) many char-specific achievements became Account or Warband achievements.
                -- if LoreUtil:IsHiddenCharSpecificAchievement(achievementID) then
                --     if (criteriaInfo.criteriaType == LocalUtils.CriteriaType.Quest) then
                --         criteriaInfo.completed = LocalQuestUtils:IsQuestCompletedByAnyone(criteriaInfo.assetID)
                --     end
                --     -- if C_AchievementInfo.IsValidAchievement(criteriaInfo.assetID) then
                --     --     local criteriaAchievementInfo = LocalAchievementUtil.GetWrappedAchievementInfo(criteriaInfo.assetID)
                --     --     criteriaInfo.completed = criteriaAchievementInfo.completed -- and WasEarnedByMe(achievementInfo)
                --     --     -- criteriaInfo.completed = WasEarnedByMe(criteriaAchievementInfo)
                --     -- end
                -- end
                if criteriaInfo.completed then
                    achievementInfo.numCompleted = achievementInfo.numCompleted + 1
                end
                tInsert(achievementInfo.criteriaList, criteriaInfo)
            end
        end

        -- Note: By default achievementInfo.completed shows you the account-wide
        -- Loremaster achievement progress. Count completed criteria (above) for
        -- char specific progress.
        if LoreUtil:IsHiddenCharSpecificAchievement(achievementID) then
            achievementInfo.completed = (achievementInfo.numCompleted == achievementInfo.numCriteria)
        end
        -- achievementInfo.completed = (achievementInfo.numCompleted == achievementInfo.numCriteria)

        -- Add some additional values
        achievementInfo.isOptionalAchievement = LoreUtil:IsOptionalAchievement(achievementID)
        achievementInfo.isAccountWide = LoreUtil:IsAccountWideAchievement(achievementInfo)
        achievementInfo.parentAchievementID = LoreUtil:GetParentAchievementID(achievementID)

        self.achievements[achievementID] = achievementInfo
        debug:print(self, "> Added achievementInfo:", achievementID, achievementInfo.name)
    end

    return self.achievements[achievementID]
end

function ZoneStoryUtils:IsZoneStoryActive(pin, criteriaInfo)
    if pin.questInfo and (pin.questInfo.hasQuestLineInfo and pin.questInfo.currentQuestLineName == criteriaInfo.criteriaString) then
        return true
    end
    if (criteriaInfo.criteriaType == LocalUtils.CriteriaType.Quest) then
        local questID = criteriaInfo.assetID and criteriaInfo.assetID or criteriaInfo.criteriaID
        return questID == pin.questID
    end

    return false
end

-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_AchievementUI/Blizzard_AchievementUI.lua> (see "AchievementShield_OnEnter")
--
local function CreateEarnedByString(achievementInfo)
    local msg = ''
    if (achievementInfo.isAccountWide) then
        msg = achievementInfo.completed and ACCOUNT_WIDE_ACHIEVEMENT_COMPLETED or ACCOUNT_WIDE_ACHIEVEMENT
    end
    if not StringIsEmpty(achievementInfo.earnedBy) then
        local charName = achievementInfo.wasEarnedByMe and achievementInfo.earnedBy or UnitName("player")
        msg = not StringIsEmpty(msg) and msg.."|n" or msg
        msg = msg..(achievementInfo.wasEarnedByMe and ACHIEVEMENT_COMPLETED_BY or L.ACHIEVEMENT_NOT_COMPLETED_BY)
        return msg:format(HIGHLIGHT(charName))
    elseif not achievementInfo.isAccountWide then
		return CHARACTER_ACHIEVEMENT_DESCRIPTION
	end

    return msg
end

function ZoneStoryUtils:AddZoneStoryDetailsToTooltip(tooltip, pin)
    debug:print(self, format(YELLOW("Scanning zone (%s) for stories..."), pin.mapID or "n/a"))

    local storyAchievementID = pin.achievementInfo and pin.achievementInfo.achievementID or pin.achievementID
    local is2nd = pin.achievementID == pin.achievementID2
    local achievementInfo = self:GetAchievementInfo(storyAchievementID)

    if not achievementInfo then return false end
    if (not pin.isOnContinent and not ns.settings.showOptionalZoneStories and LoreUtil:IsOptionalAchievement(achievementInfo.achievementID) )  then return end

    if (is2nd and ns.settings.collapseType_zoneStory ~= "singleLine") then
        LibQTipUtil:AddBlankLineToTooltip(tooltip)
    end

    -- Plugin / category name
    if not (is2nd or pin.pinTemplate == LocalUtils.HandyNotesPinTemplate) then
        local categoryNameOnly = tooltip == ContentTooltip and (ns.settings.showPluginName and LocalUtils:HasBasicTooltipContent(pin))
        LibQTipUtil:AddCategoryNameLine(tooltip, L.CATEGORY_NAME_ZONE_STORY, categoryNameOnly)

        debug:AddDebugLineToLibQTooltip(tooltip,  {text=format("> Q:%d - %s - %s_%s_%s", pin.questID, pin.pinTemplate, tostring(pin.questType), tostring(pin.questInfo.questType), pin.questInfo.isTrivial and "isTrivial" or pin.questInfo.isCampaign and "isCampaign" or "noHiddenType")})
    end
    debug:AddDebugLineToLibQTooltip(tooltip, {text=format("> A:%d \"%s\"", storyAchievementID, achievementInfo.name)})
    debug:AddDebugLineToLibQTooltip(tooltip, {text="account: "..tostring(achievementInfo.isAccountWide)..", completed: "..tostring(achievementInfo.completed)..", earnedBy: "..tostring(achievementInfo.wasEarnedByMe).."-"..tostring(achievementInfo.earnedBy)})

    -- Zone name
    if not (is2nd or pin.pinTemplate == LocalUtils.HandyNotesPinTemplate) then
        local storyName = pin.storyMapInfo and pin.storyMapInfo.name or achievementInfo.name
        LibQTipUtil:SetColoredTitle(tooltip, ZONE_STORY_HEADER_COLOR, L.ZONE_NAME_FORMAT:format(storyName))
    end

    -- Achievement name
    if not pin.isOnContinent then
        local achievementNameTemplate = achievementInfo.completed and L.ZONE_ACHIEVEMENT_NAME_FORMAT_COMPLETE or L.ZONE_ACHIEVEMENT_NAME_FORMAT_INCOMPLETE
        local achievementName = CONTENT_TRACKING_ACHIEVEMENT_FORMAT:format(achievementInfo.name)
        achievementName = achievementInfo.isOptionalAchievement and achievementName..L.TEXT_DELIMITER..AUCTION_HOUSE_BUYOUT_OPTIONAL_LABEL or achievementName
        LibQTipUtil:AddNormalLine(tooltip, achievementNameTemplate:format(achievementName))
    else
        local achievementHeaderNameTemplate = achievementInfo.completed and L.ZONE_ACHIEVEMENT_ICON_NAME_FORMAT_COMPLETE or L.ZONE_ACHIEVEMENT_ICON_NAME_FORMAT_INCOMPLETE
        LibQTipUtil:SetColoredTitle(tooltip, ZONE_STORY_HEADER_COLOR, achievementHeaderNameTemplate:format(achievementInfo.icon, achievementInfo.name))
    end
    if (not pin.isOnContinent and ns.settings.collapseType_zoneStory == "singleLine") then return true end
    if (pin.isOnContinent and ns.settings.collapseType_zoneStoryContinent == "singleLine") then return true end

    -- Account + earnedBy info
    if ns.settings.showEarnedByText then
        local earnedByString = CreateEarnedByString(achievementInfo)
        if earnedByString then
            -- LibQTipUtil:AddDescriptionLine(tooltip, BLUE(CreateEarnedByString(achievementInfo)), 0, nil, 250)
            LibQTipUtil:AddColoredLine(tooltip, BRIGHTBLUE_FONT_COLOR, earnedByString)
        end
    end

    -- Parent achievement
    if achievementInfo.parentAchievementID then
        local parentAchievementInfo = self:GetAchievementInfo(achievementInfo.parentAchievementID)
        local parentAchievementName = HIGHLIGHT(parentAchievementInfo and parentAchievementInfo.name or tostring(achievementInfo.parentAchievementID))
        LibQTipUtil:AddNormalLine(tooltip, "Part of: "..parentAchievementName) --> TODO - L10n
    end

    -- Chapter status
    if not TableIsEmpty(achievementInfo.criteriaList) then
        LibQTipUtil:AddHighlightLine(tooltip, QUEST_STORY_STATUS:format(achievementInfo.numCompleted, achievementInfo.numCriteria))
    else
        -- Show description for single achievements.
        LibQTipUtil:AddDescriptionLine(tooltip, NORMAL_FONT_COLOR:WrapTextInColorCode(achievementInfo.description), 0)
    end

    -- Chapter list
    if (not pin.isOnContinent and GetCollapseTypeModifier(achievementInfo.completed, "collapseType_zoneStory")) or
       (pin.isOnContinent and GetCollapseTypeModifier(achievementInfo.completed, "collapseType_zoneStoryContinent")) then
        local criteriaName
        for i, criteriaInfo in ipairs(achievementInfo.criteriaList) do
            criteriaName = criteriaInfo.criteriaString
            if debug.showChapterIDsInTooltip then
                if (not criteriaInfo.assetID) or (criteriaInfo.assetID == 0) then
                    criteriaName = format("|cffcc1919%03d %05d|r %s", criteriaInfo.criteriaType, criteriaInfo.criteriaID, criteriaInfo.criteriaString)
                else
                    criteriaName = format("|cff808080%03d %05d|r %s", criteriaInfo.criteriaType, criteriaInfo.assetID, criteriaInfo.criteriaString)
                end
            end
            -- criteriaName = criteriaName..(not StringIsEmpty(criteriaInfo.charName) and L.TEXT_DELIMITER..BLUE(PARENS_TEMPLATE:format(criteriaInfo.charName)) or " (?)")
            local isActive = self:IsZoneStoryActive(pin, criteriaInfo)
            -- criteriaName = isActive and criteriaName.."|A:common-icon-backarrow:0:0:2:-1|a" or criteriaName
            if (criteriaInfo.completed and isActive) then
                LibQTipUtil:AddColoredLine(tooltip, GREEN_FONT_COLOR, L.CHAPTER_NAME_FORMAT_CURRENT:format(criteriaName))
            elseif criteriaInfo.completed then
                LibQTipUtil:AddColoredLine(tooltip, GREEN_FONT_COLOR, L.CHAPTER_NAME_FORMAT_COMPLETED:format(criteriaName))
            elseif isActive then
                LibQTipUtil:AddNormalLine(tooltip, L.CHAPTER_NAME_FORMAT_CURRENT:format(criteriaName))
            else
                LibQTipUtil:AddHighlightLine(tooltip, L.CHAPTER_NAME_FORMAT_NOT_COMPLETED:format(criteriaName))
            end
            -- Show chapter quests
            if (not criteriaInfo.completed and criteriaInfo.criteriaType == LocalUtils.CriteriaType.Quest) then
                if (not pin.isOnContinent and (ns.settings.showStoryChapterQuests or debug.isActive)) or
                    (pin.isOnContinent and ns.settings.showContinentStoryChapterQuests) then
                    -- Format quest name and optionally show to user
                    local questID = criteriaInfo.assetID and criteriaInfo.assetID or criteriaInfo.criteriaID
                    local questInfo = LocalQuestUtils:GetQuestInfo(questID, "basic", pin.storyMapInfo and pin.storyMapInfo.mapID or pin.mapID)
                    local criteriaQuestName = LocalQuestUtils:FormatAchievementQuestName(questInfo, criteriaName)
                    LibQTipUtil:AddDescriptionLine(tooltip, criteriaQuestName, 15)
                    if not tContains(LoreUtil.storyQuests, tostring(questID)) then
                        tinsert(LoreUtil.storyQuests, tostring(questID))
                    end
                end
            end
        end
    elseif not TableIsEmpty(achievementInfo.criteriaList) then
        local textTemplate = (pin.pinTemplate == LocalUtils.QuestPinTemplate) and L.HINT_HOLD_KEY_FORMAT or L.HINT_HOLD_KEY_FORMAT_HOVER
        textTemplate = (pin.pinTemplate == LocalUtils.HandyNotesPinTemplate) and L.HINT_VIEW_ACHIEVEMENT_CRITERIA or textTemplate
        LibQTipUtil:AddInstructionLine(tooltip, textTemplate:format(GREEN(SHIFT_KEY)))
    end

    debug:print(self, format("Found story with %d |4chapter:chapters;.", achievementInfo.numCriteria))

    return true
end

----- Faction Group Labels ----------

local QuestFactionGroupID = ns.QuestFactionGroupID  --> <Data.lua>

local QuestNameFactionGroupTemplate = {
    [QuestFactionGroupID.Alliance] = L.QUEST_NAME_FORMAT_ALLIANCE,
    [QuestFactionGroupID.Horde] = L.QUEST_NAME_FORMAT_HORDE,
    [QuestFactionGroupID.Neutral] = L.QUEST_NAME_FORMAT_NEUTRAL,
}

LocalUtils.QuestTag = {}
LocalUtils.QuestTag.Class = 21
LocalUtils.QuestTag.Escort = 84
LocalUtils.QuestTag.Artifact = 107
LocalUtils.QuestTag.WorldQuest = 109
LocalUtils.QuestTag.BurningLegionWorldQuest = 145
LocalUtils.QuestTag.BurningLegionInvasionWorldQuest = 146
LocalUtils.QuestTag.Profession = 267
-- LocalUtils.QuestTag.Threat = 268
LocalUtils.QuestTag.WarModePvP = 255
LocalUtils.QuestTag.Important = 282

-- Expand the default quest tag atlas map
-- **Note:** Before adding more tag icons, check if they're not already part of QUEST_TAG_ATLAS!
--
--> REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_FrameXMLBase/Constants.lua>
--> REF.: <https://warcraft.wiki.gg/wiki/API_C_QuestLog.GetQuestTagInfo>
--
QUEST_TAG_ATLAS[LocalUtils.QuestTag.Artifact] = "ArtifactQuest"
QUEST_TAG_ATLAS[LocalUtils.QuestTag.BurningLegionWorldQuest] = "worldquest-icon-burninglegion"  --> Legion Invasion World Quest Wrapper (~= Enum.QuestTagType.Invasion)
QUEST_TAG_ATLAS[LocalUtils.QuestTag.BurningLegionInvasionWorldQuest] = "legioninvasion-map-icon-portal"  --> Legion Invasion World Quest Wrapper (~= Enum.QuestTagType.Invasion)
QUEST_TAG_ATLAS[LocalUtils.QuestTag.Class] = "questlog-questtypeicon-class"
QUEST_TAG_ATLAS[LocalUtils.QuestTag.Escort] = "nameplates-InterruptShield"
QUEST_TAG_ATLAS[LocalUtils.QuestTag.Profession] = "Profession"
QUEST_TAG_ATLAS[LocalUtils.QuestTag.WorldQuest] = "worldquest-tracker-questmarker"
-- QUEST_TAG_ATLAS[LocalUtils.QuestTag.Threat] = "worldquest-icon-nzoth"   -- "Ping_Map_Threat"
QUEST_TAG_ATLAS[LocalUtils.QuestTag.WarModePvP] = "questlog-questtypeicon-pvp"
QUEST_TAG_ATLAS["CAMPAIGN"] = "Quest-Campaign-Available"
QUEST_TAG_ATLAS["COMPLETED_CAMPAIGN"] = "Quest-Campaign-TurnIn"
QUEST_TAG_ATLAS["COMPLETED_DAILY_CAMPAIGN"] = "Quest-DailyCampaign-TurnIn"
QUEST_TAG_ATLAS["COMPLETED_IMPORTANT"] = "questlog-questtypeicon-importantturnin"  -- "quest-important-turnin"
QUEST_TAG_ATLAS["COMPLETED_REPEATABLE"] = "QuestRepeatableTurnin"
QUEST_TAG_ATLAS["DAILY_CAMPAIGN"] = "Quest-DailyCampaign-Available"
QUEST_TAG_ATLAS["IMPORTANT"] = "questlog-questtypeicon-important"  -- "quest-important-available"
QUEST_TAG_ATLAS[LocalUtils.QuestTag.Important] = "questlog-questtypeicon-important"
QUEST_TAG_ATLAS["TRIVIAL_CAMPAIGN"] = "Quest-Campaign-Available-Trivial"
QUEST_TAG_ATLAS["TRIVIAL_IMPORTANT"] = "quest-important-available-trivial"
QUEST_TAG_ATLAS["TRIVIAL_LEGENDARY"] = "quest-legendary-available-trivial"
QUEST_TAG_ATLAS["TRIVIAL"] = "TrivialQuests"
-- QUEST_TAG_ATLAS["MONTHLY"] = "questlog-questtypeicon-monthly"

local QuestTagNames = {
    ["CAMPAIGN"] = TRACKER_HEADER_CAMPAIGN_QUESTS,
    ["COMPLETED"] = COMPLETE,
    ["IMPORTANT"] = ENCOUNTER_JOURNAL_SECTION_FLAG5,
    ["LEGENDARY"] = MAP_LEGEND_LEGENDARY,  -- ITEM_QUALITY5_DESC,
    ["STORY"] = LOOT_JOURNAL_LEGENDARIES_SOURCE_ACHIEVEMENT,
    ["TRIVIAL_CAMPAIGN"] = L.QUEST_TYPE_NAME_FORMAT_TRIVIAL:format(TRACKER_HEADER_CAMPAIGN_QUESTS),
    ["TRIVIAL_IMPORTANT"] = L.QUEST_TYPE_NAME_FORMAT_TRIVIAL:format(ENCOUNTER_JOURNAL_SECTION_FLAG5),
    ["TRIVIAL_LEGENDARY"] = L.QUEST_TYPE_NAME_FORMAT_TRIVIAL:format(ITEM_QUALITY5_DESC),
    ["TRIVIAL"] = L.QUEST_TYPE_NAME_FORMAT_TRIVIAL:format(UNIT_NAMEPLATES_SHOW_ENEMY_MINUS),
}

local leftSidedTags = {Enum.QuestTag.Dungeon, Enum.QuestTag.Raid, LocalUtils.QuestTag.WorldQuest, LocalUtils.QuestTag.BurningLegionInvasionWorldQuest, LocalUtils.QuestTag.Threat, LocalUtils.QuestTag.Important}

-- Add quest type tags (text or icon) to a quest name.
function LocalQuestUtils:FormatQuestName(questInfo)
    local iconString, atlasName;
    local isReady = questInfo.isReadyForTurnIn
    local questTitle = QuestNameFactionGroupTemplate[questInfo.questFactionGroup]:format(questInfo.questName)

    if not StringIsEmpty(questInfo.questName) then
        if ( isReady and not (questInfo.isDaily or questInfo.isWeekly) ) then
            if ns.settings.showQuestTypeAsText then
                questTitle = BLUE(PARENS_TEMPLATE:format(QuestTagNames["COMPLETED"]))..L.TEXT_DELIMITER..questTitle
            else
                iconString = CreateAtlasMarkup(QUEST_TAG_ATLAS["COMPLETED"], 16, 16, -2)
                questTitle = iconString..questTitle
            end
        end
        if questInfo.isDaily then
            if ns.settings.showQuestTypeAsText then
                questTitle = BLUE(PARENS_TEMPLATE:format(DAILY))..L.TEXT_DELIMITER..questTitle
            else
                iconString = CreateAtlasMarkup(isReady and QUEST_TAG_ATLAS["COMPLETED_REPEATABLE"] or QUEST_TAG_ATLAS.DAILY, 16, 16, -2)
                questTitle = iconString..questTitle
            end
        end
        if questInfo.isWeekly then
            if ns.settings.showQuestTypeAsText then
                questTitle = BLUE(PARENS_TEMPLATE:format(WEEKLY))..L.TEXT_DELIMITER..questTitle
            else
                local iconTurnIn = CreateAtlasMarkup(QUEST_TAG_ATLAS["COMPLETED_REPEATABLE"], 16, 16, -1)
                local iconAvailable = CreateAtlasMarkup(QUEST_TAG_ATLAS.WEEKLY, 16, 16)
                iconString = isReady and iconTurnIn or iconAvailable
                questTitle = iconString..L.TEXT_DELIMITER..questTitle
            end
        end
        if questInfo.isStory then
            if (ns.settings.highlightStoryQuests and not LocalQuestUtils:IsQuestCompletedByAnyone(questInfo)) then
                questTitle = ORANGE(questTitle)
            end
            if ns.settings.showQuestTypeAsText then
                questTitle = BLUE(PARENS_TEMPLATE:format(QuestTagNames["STORY"]))..L.TEXT_DELIMITER..questTitle
            else
                iconString = CreateAtlasMarkup(QUEST_TAG_ATLAS["STORY"], 16, 16)
                questTitle = iconString..L.TEXT_DELIMITER..questTitle
            end
        end
        if questInfo.isAccountCompleted then
            if ns.settings.showQuestTypeAsText then
                questTitle = BLUE(PARENS_TEMPLATE:format(ACCOUNT_COMPLETED_QUEST_LABEL))..L.TEXT_DELIMITER..questTitle
            else
                iconString = CreateAtlasMarkup("questlog-questtypeicon-account", 16, 16, 2)
                -- questTitle = iconString..L.TEXT_DELIMITER..questTitle
                questTitle = questTitle..iconString
            end
        end
        if (questInfo.questType ~= 0) then
            if ns.settings.showQuestTypeAsText then
                questTitle = BLUE(PARENS_TEMPLATE:format(questInfo.questTagInfo.tagName))..L.TEXT_DELIMITER..questTitle
            elseif (QUEST_TAG_ATLAS[questInfo.questType] == nil) then
                -- This quest type is neither part of Blizzard's tag atlas variable, nor have I added it, yet.
                questTitle = BLUE(PARENS_TEMPLATE:format(questInfo.questTagInfo.tagName or UNKNOWN))..L.TEXT_DELIMITER..questTitle
            elseif tContains(leftSidedTags, questInfo.questType) then
                -- -- Threat Object icons can vary, eg. N'Zoth vs. one of the Shadowlands main factions.
                -- iconString = questInfo.questTagInfo.isThreat and QuestUtil.GetThreatPOIIcon(questInfo.questTagInfo.questID) or CreateAtlasMarkup(QUEST_TAG_ATLAS[questInfo.questType], 16, 16, -2)
                iconString = CreateAtlasMarkup(QUEST_TAG_ATLAS[questInfo.questType], 16, 16, -2)
                questTitle = iconString..questTitle
            else
                atlasName = QuestUtils_GetQuestTagAtlas(questInfo.questTagInfo.tagID, questInfo.questTagInfo.worldQuestType)
                iconString = (questInfo.questType == LocalUtils.QuestTag.Escort) and CreateAtlasMarkup(atlasName, 14, 16, 2) or CreateAtlasMarkup(atlasName, 16, 16, 2, -1)
                questTitle = questTitle..iconString
            end
        end
        if questInfo.isLegendary then
            if ns.settings.showQuestTypeAsText then
                questTitle = BLUE(PARENS_TEMPLATE:format(QuestTagNames["LEGENDARY"]))..L.TEXT_DELIMITER..questTitle
            else
                iconString = CreateAtlasMarkup(isReady and QUEST_TAG_ATLAS["COMPLETED_LEGENDARY"] or QUEST_TAG_ATLAS[Enum.QuestTag.Legendary], 16, 16)
                questTitle = iconString..L.TEXT_DELIMITER..questTitle
            end
        end
        if debug.showChapterIDsInTooltip then
            local colorCodeString = questInfo.questType == 0 and GRAY_FONT_COLOR_CODE or LIGHTBLUE_FONT_COLOR_CODE
            questTitle = format(colorCodeString.."%03d %05d|r %s", questInfo.questType, questInfo.questID, questTitle)
        end
    else
        -- debug:print("Empty:", questInfo.questID, tostring(questTitle), tostring(questInfo.questName))
        questTitle = RETRIEVING_DATA
        if debug.isActive then
            questTitle = format("> questFactionGroup: %s, questExpansionID: %d", tostring(questInfo.questFactionGroup), questInfo.questExpansionID)
        end
        if debug.showChapterIDsInTooltip then
            local colorCodeString = questInfo.questType == 0 and GRAY_FONT_COLOR_CODE or LIGHTBLUE_FONT_COLOR_CODE
            questTitle = format(colorCodeString.."%03d %05d|r %s", questInfo.questType, questInfo.questID, questTitle)
        end
    end

    return questTitle
end

function LocalQuestUtils:FormatAchievementQuestName(questInfo, fallbackName)
    if not StringIsEmpty(questInfo.questName) then
        local iconString = CreateAtlasMarkup("SmallQuestBang", 16, 16, 1, -1)
        local questTitle = iconString..QuestNameFactionGroupTemplate[questInfo.questFactionGroup]:format(questInfo.questName)
        if (questInfo.questType ~= 0) then
            iconString = (questInfo.questType == LocalUtils.QuestTag.Escort) and CreateAtlasMarkup(QUEST_TAG_ATLAS[questInfo.questType], 14, 16, 2) or CreateAtlasMarkup(QUEST_TAG_ATLAS[questInfo.questType], 16, 16, 2, -1)
            questTitle = questTitle..iconString
        end
        return questTitle
    end
    return fallbackName
end

----- Quest Handler ----------

-- LocalQuestUtils.cache = {}

LocalQuestUtils.GetQuestName = function(self, questID)
    -- REF.: <https://www.townlong-yak.com/framexml/live/QuestUtils.lua>
    -- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestLogDocumentation.lua>
	-- if not HaveQuestData(questID) then
	-- 	C_QuestLog.RequestLoadQuestByID(questID)
	-- end

    return QuestUtils_GetQuestName(questID)   -- QuestCache:Get(questID).title
end

local function ShouldIgnoreQuestTypeTag(questInfo)
    if not questInfo.questTagInfo then return true end

    local isKnownQuestTypeTag = QuestUtils_IsQuestDungeonQuest(questInfo.questID)
    local shouldIgnore = (questInfo.isOnQuest or questInfo.questTagInfo and questInfo.questTagInfo.worldQuestType) and isKnownQuestTypeTag
    if shouldIgnore then debug:print("Ignoring questTypeTag:", questInfo.questTagInfo.tagID, questInfo.questTagInfo.tagName) end

    return shouldIgnore
end

local classificationIgnoreTable = {
	Enum.QuestClassification.Legendary,
	Enum.QuestClassification.Campaign,
}

function LocalQuestUtils:AddQuestTagLinesToTooltip_New(tooltip, baseQuestInfo)
    local tagInfoList, questInfo = LocalQuestTagUtil:GetQuestTagInfoList(baseQuestInfo.questID, baseQuestInfo)
    if (#tagInfoList == 0) then return end

    local LineColor = NORMAL_FONT_COLOR

    for _, tagInfo in ipairs(tagInfoList) do
        local text = string.format("%s %s", tagInfo.atlasMarkup or '', tagInfo.tagName or UNKNOWN)
        local lineIndex = LibQTipUtil:AddColoredLine(tooltip, LineColor, text)
        if (questInfo.isTrivial and ns.settings.showTagTransparency) then
            local r, g, b = LineColor:GetRGB()
            tooltip:SetCellTextColor(lineIndex, 1, r, g, b, 0.5)
        end
    end
end

-- Add daily and weekly quests to known quest types.
function LocalQuestUtils:AddQuestTagLinesToTooltip(tooltip, questInfo)          --> TODO - Clean this up
    local LineColor = questInfo.isOnQuest and TOOLTIP_DEFAULT_COLOR or NORMAL_FONT_COLOR

    -- Blizzard's default tags
    local tagInfo = questInfo.questTagInfo
    if (tagInfo and not ShouldIgnoreQuestTypeTag(questInfo)) then
        local tagID = tagInfo.tagID
        local tagName = tagInfo.tagName
        -- Account-wide quest types are usually only shown in the questlog
        if (tagInfo.tagID == Enum.QuestTag.Account and questInfo.questFactionGroup ~= QuestFactionGroupID.Neutral) then
            local factionString = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and FACTION_HORDE or FACTION_ALLIANCE
            tagID = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and "HORDE" or "ALLIANCE"
            tagName = tagName..L.TEXT_DELIMITER..PARENS_TEMPLATE:format(factionString)
        end
        if (tagInfo.worldQuestType ~= nil) then                                 --> TODO - Add to '<utils\libqtip.lua>'
            local atlas, width, height = QuestUtil.GetWorldQuestAtlasInfo(questInfo.questID, tagInfo, questInfo.isActive)
            local atlasMarkup = CreateAtlasMarkup(atlas, 20, 20)
            LibQTipUtil:AddNormalLine(tooltip, string.format("%s %s", atlasMarkup, tagInfo.tagName))
        end
        if (tagInfo.tagID == Enum.QuestTagType.Threat or questInfo.isThreat) then
            local atlas = QuestUtil.GetThreatPOIIcon(questInfo.questID)
            local atlasMarkup = CreateAtlasMarkup(atlas, 20, 20)
            LibQTipUtil:AddNormalLine(tooltip, string.format("%s %s", atlasMarkup, tagInfo.tagName))
        end
        LibQTipUtil:AddQuestTagTooltipLine(tooltip, tagName, tagID, tagInfo.worldQuestType, LineColor)
    end

    -- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestInfoSystemDocumentation.lua>
    -- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_FrameXMLUtil/QuestUtils.lua>
    -- local classificationInfo = C_QuestInfoSystem.GetQuestClassification(questInfo.questID);
    -- local classificationString = QuestUtil.GetQuestClassificationString(questInfo.questID)
    local classificationID, classificationText, classificationAtlas, clSize = QuestUtil.GetQuestClassificationDetails(questInfo.questID)

    -- Custom tags
    if questInfo.isDaily then
        LibQTipUtil:AddQuestTagTooltipLine(tooltip, DAILY, "DAILY", nil, LineColor)
        -- if questInfo.isCampaign then
        --     local tagName = questInfo.isReadyForTurnIn and "COMPLETED_DAILY_CAMPAIGN" or "DAILY_CAMPAIGN"
        --     LibQTipUtil:AddQuestTagTooltipLine(tooltip, DAILY, tagName, nil, LineColor)
        -- else
        --     local tagName = questInfo.isReadyForTurnIn and "COMPLETED_REPEATABLE" or "DAILY"
        --     LibQTipUtil:AddQuestTagTooltipLine(tooltip, DAILY, tagName, nil, LineColor)
        -- end
    end
    if questInfo.isWeekly then
        LibQTipUtil:AddQuestTagTooltipLine(tooltip, WEEKLY, "WEEKLY", nil, LineColor)
        -- if questInfo.isCampaign then
        --     local tagName = questInfo.isReadyForTurnIn and "COMPLETED_DAILY_CAMPAIGN" or "DAILY_CAMPAIGN"
        --     LibQTipUtil:AddQuestTagTooltipLine(tooltip, WEEKLY, tagName, nil, LineColor)
        -- else
        --     local tagName = questInfo.isReadyForTurnIn and "COMPLETED_REPEATABLE" or "WEEKLY"
        --     LibQTipUtil:AddQuestTagTooltipLine(tooltip, WEEKLY, tagName, nil, LineColor)
        -- end
    end
    if (classificationID and not tContains(classificationIgnoreTable, classificationID)) then
        local atlasMarkup = CreateAtlasMarkup(classificationAtlas, 20, 20)
        LibQTipUtil:AddNormalLine(tooltip, LineColor:WrapTextInColorCode(string.format("%s %s", atlasMarkup, classificationText)))
    end
    if questInfo.isTrivial then
        if questInfo.isLegendary then
            LibQTipUtil:AddQuestTagTooltipLine(tooltip, QuestTagNames["TRIVIAL_LEGENDARY"], "TRIVIAL_LEGENDARY", nil, LineColor)
        -- elseif questInfo.isImportant then
        --     LibQTipUtil:AddQuestTagTooltipLine(tooltip, QuestTagNames["TRIVIAL_IMPORTANT"], "TRIVIAL_IMPORTANT", nil, LineColor)
        elseif questInfo.isCampaign then
            LibQTipUtil:AddQuestTagTooltipLine(tooltip, QuestTagNames["TRIVIAL_CAMPAIGN"], "TRIVIAL_CAMPAIGN", nil, LineColor)
        else
            LibQTipUtil:AddQuestTagTooltipLine(tooltip, QuestTagNames["TRIVIAL"], "TRIVIAL", nil, LineColor)
        end
    else
        if questInfo.isLegendary then
            local tagName = questInfo.isReadyForTurnIn and "COMPLETED_LEGENDARY" or Enum.QuestTag.Legendary
            LibQTipUtil:AddQuestTagTooltipLine(tooltip, QuestTagNames["LEGENDARY"], tagName, nil, LineColor)
        end
        -- if questInfo.isImportant then
        --     local tagName = questInfo.isReadyForTurnIn and "COMPLETED_IMPORTANT" or "IMPORTANT"
        --     LibQTipUtil:AddQuestTagTooltipLine(tooltip, QuestTagNames["IMPORTANT"], RED(tagName), nil, LineColor)
        -- end
        if questInfo.isCampaign then -- and not questInfo.isDaily and not questInfo.isWeekly) then
            local tagName = questInfo.isReadyForTurnIn and "COMPLETED_CAMPAIGN" or "CAMPAIGN"
            LibQTipUtil:AddQuestTagTooltipLine(tooltip, QuestTagNames["CAMPAIGN"], tagName, nil, LineColor)
        end
    end
    if questInfo.isStory then
        LibQTipUtil:AddQuestTagTooltipLine(tooltip, STORY_PROGRESS, "STORY", nil, LineColor)
    end
    -- if questInfo.isBonusObjective then
    --     local atlas = "questbonusobjective"
    --     local atlasMarkup = CreateAtlasMarkup(atlas, 20, 20)
    --     LibQTipUtil:AddNormalLine(tooltip, string.format("%s %s", atlasMarkup, MAP_LEGEND_BONUSOBJECTIVE))
    -- end
    if (not tagInfo or tagInfo.tagID ~= Enum.QuestTag.Account) and (questInfo.questFactionGroup ~= QuestFactionGroupID.Neutral) then
        -- Show faction group icon only when no tagInfo provided or not an account quest
        local tagName = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and ITEM_REQ_HORDE or ITEM_REQ_ALLIANCE
        local tagID = questInfo.questFactionGroup == LE_QUEST_FACTION_HORDE and "HORDE" or "ALLIANCE"
        LibQTipUtil:AddQuestTagTooltipLine(tooltip, tagName, tagID, nil, LineColor)
    end
end

-- Retrieve different quest details.
--
function LocalQuestUtils:GetQuestInfo(questID, targetType, pinMapID)
    local questName = self:GetQuestName(questID)
    if (targetType == "questline") then
        local questInfo = {
            isAccountQuest = C_QuestLog.IsAccountQuest(questID),
            -- isBounty = C_QuestLog.IsQuestBounty(questID),
            -- isBreadcrumbQuest = IsBreadcrumbQuest(questID),
            isCalling = C_QuestLog.IsQuestCalling(questID),
            isCampaign = C_CampaignInfo.IsCampaignQuest(questID),
            isComplete = C_QuestLog.IsComplete(questID),
            isDaily = LocalQuestFilter:IsDaily(questID),
            isDisabledForSession = C_QuestLog.IsQuestDisabledForSession(questID),
            isFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID),  -- self:IsQuestCompletedByAnyone(questInfo),
            isAccountCompleted = C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID),
            isReadyForTurnIn = C_QuestLog.ReadyForTurnIn(questID),
            isOnQuest = C_QuestLog.IsOnQuest(questID),
            isImportant = C_QuestLog.IsImportantQuest(questID),
            -- isInvasion = C_QuestLog.IsQuestInvasion(questID),
            isLegendary = C_QuestLog.IsLegendaryQuest(questID),
            isObsolete = LocalQuestFilter:IsObsolete(questID),
            isRepeatable = C_QuestLog.IsRepeatableQuest(questID),
            -- isReplayable = C_QuestLog.IsQuestReplayable(questID),
            isSequenced = IsQuestSequenced(questID),
            isStory = LocalQuestFilter:IsStory(questID),
            isThreat = C_QuestLog.IsThreatQuest(questID),
            isTrivial = C_QuestLog.IsQuestTrivial(questID),
            isWeekly = LocalQuestFilter:IsWeekly(questID),
            -- questDifficulty = C_PlayerInfo.GetContentDifficultyQuestForPlayer(questID),  --> Enum.RelativeContentDifficulty
            questExpansionID = GetQuestExpansion(questID),
            questFactionGroup = LocalQuestFilter:GetQuestFactionGroup(questID),
            questID = questID,
            questMapID = GetQuestUiMapID(questID),
            questName = questName,
            questType = C_QuestLog.GetQuestType(questID),  --> Enum.QuestTag
            questTagInfo = LocalQuestInfo:GetQuestTagInfo(questID),  --> QuestTagInfo table
            questClassification = C_QuestInfoSystem.GetQuestClassification(questID),
            isFailed = C_QuestLog.IsFailed(questID),
        }
        if ns.settings.saveRecurringQuests then
            -- Enhance completion flagging for recurring quests
            if (questInfo.isDaily and not questInfo.isFlaggedCompleted) then    --> TODO - Check if need include account
                questInfo.isFlaggedCompleted = DBUtil:IsCompletedRecurringQuest("Daily", questID)
            end
            if (questInfo.isWeekly and not questInfo.isFlaggedCompleted) then
                questInfo.isFlaggedCompleted = DBUtil:IsCompletedRecurringQuest("Weekly", questID)
            end
        end

        return questInfo
    end

    if (targetType == "pin") then
        local questInfo = {
            -- Test
            questMapID = GetQuestUiMapID(questID),
            hasPOIInfo = QuestHasPOIInfo(questID),
            isBounty = C_QuestLog.IsQuestBounty(questID),
            isCalling = C_QuestLog.IsQuestCalling(questID),
            isDisabledForSession = C_QuestLog.IsQuestDisabledForSession(questID),
            -- isInvasion = C_QuestLog.IsQuestInvasion(questID),
            isRepeatable = C_QuestLog.IsRepeatableQuest(questID),
            isReplayable = C_QuestLog.IsQuestReplayable(questID),
            isReplayedRecently = C_QuestLog.IsQuestReplayedRecently(questID),
            -- Keep
            isAccountQuest = C_QuestLog.IsAccountQuest(questID),
            isCampaign = C_CampaignInfo.IsCampaignQuest(questID),
            isComplete = C_QuestLog.IsComplete(questID),
            isDaily = LocalQuestFilter:IsDaily(questID),
            isFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID),  -- self:IsQuestCompletedByAnyone(questInfo),
            isImportant = C_QuestLog.IsImportantQuest(questID),
            isLegendary = C_QuestLog.IsLegendaryQuest(questID),
            isOnQuest = C_QuestLog.IsOnQuest(questID),
            isReadyForTurnIn = C_QuestLog.ReadyForTurnIn(questID),
            isStory = LocalQuestFilter:IsStory(questID),
            isTrivial = C_QuestLog.IsQuestTrivial(questID),
            isWeekly = LocalQuestFilter:IsWeekly(questID),
            questFactionGroup = LocalQuestFilter:GetQuestFactionGroup(questID),
            questID = questID,
            questName = questName,
            questTagInfo = LocalQuestInfo:GetQuestTagInfo(questID),  --> QuestTagInfo table, Enum.QuestTag
            questType = C_QuestLog.GetQuestType(questID),
            isBonusObjective = QuestUtils_IsQuestBonusObjective(questID),
            -- isDungeonQuest = QuestUtils_IsQuestDungeonQuest(questID),
            -- isWorldQuest = QuestUtils_IsQuestWorldQuest(questID),
            isThreat = C_QuestLog.IsThreatQuest(questID),
            questClassification = C_QuestInfoSystem.GetQuestClassification(questID),  --> Enum.QuestClassification
            isFailed = C_QuestLog.IsFailed(questID),
            -- Keep for further testing
            -- questDifficulty = C_PlayerInfo.GetContentDifficultyQuestForPlayer(questID),  --> Enum.RelativeContentDifficulty
            questExpansionID = GetQuestExpansion(questID),
            isBreadcrumbQuest = IsBreadcrumbQuest(questID),
            isSequenced = IsQuestSequenced(questID),
        }

        questInfo.hasZoneStoryInfo = ZoneStoryUtils:HasZoneStoryInfo(pinMapID)
        questInfo.hasQuestLineInfo = LocalQuestLineUtils:HasQuestLineInfo(questID, pinMapID)
        -- questInfo.hasHiddenQuestType = tContains({questInfo.isTrivial, questInfo.isCampaign, questInfo.isStory,
        --                                           questInfo.isDaily, questInfo.isWeekly, questInfo.isLegendary,
        --                                           -- questInfo.isBreadcrumbQuest, questInfo.isSequenced,
        --                                           questInfo.isImportant, questInfo.isAccountQuest,
        --                                           questInfo.questFactionGroup ~= QuestFactionGroupID.Neutral,
        --                                           questInfo.questClassification ~= Enum.QuestClassification.Normal,
        --                                           }, true)

        return questInfo
    end

    if (targetType == "event") then
        local playerMapID = LocalMapUtils:GetBestMapForPlayer()
        return {
            questID = questID,
            questName = questName,
            questLevel = C_QuestLog.GetQuestDifficultyLevel(questID),
            isFlaggedCompleted = self:IsQuestCompletedByAnyone(nil, questID),
            isDaily = LocalQuestFilter:IsDaily(questID),
            isWeekly = LocalQuestFilter:IsWeekly(questID),
            isCampaign = C_CampaignInfo.IsCampaignQuest(questID),
            isStory = LocalQuestFilter:IsStory(questID),
            hasQuestLineInfo = LocalQuestLineUtils:HasQuestLineInfo(questID, playerMapID),
            playerMapID = playerMapID
        }
    end

    if (targetType == "basic") then
        local playerMapID = LocalMapUtils:GetBestMapForPlayer()
        return {
            questID = questID,
            questName = questName,
            questFactionGroup = LocalQuestFilter:GetQuestFactionGroup(questID),
            questMapID = pinMapID or playerMapID,
            questTagInfo = LocalQuestInfo:GetQuestTagInfo(questID),  --> QuestTagInfo table
            questType = C_QuestLog.GetQuestType(questID),  --> Enum.QuestTag
        }
    end
end

-- Return a QuestLink string for given quest.
---@param questInfo table
---@return string questLink
--
-- REF.: <https://warcraft.wiki.gg/wiki/API_GetQuestLink><br>
-- REF.: <https://warcraft.wiki.gg/wiki/QuestLink><br>
-- REF.: <https://warcraft.wiki.gg/wiki/Hyperlinks#quest>
--
function LocalQuestUtils:GetCreateQuestLink(questInfo)
    local questLink = GetQuestLink(questInfo.questID)
    if not StringIsEmpty(questLink) then return questLink end

    -- Create manually; need at least questID, questLevel, questName
    local templateString = "|cff808080|Hquest:%d:%d|h[%s]|h|r"
    return templateString:format(questInfo.questID, questInfo.questLevel, questInfo.questName)
end

----- Questline Handler ----------
--
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestLineInfoDocumentation.lua>

LocalQuestLineUtils.questLineInfos = {}  --> { [questLineID] = {questLineInfo={questLineInfo1, questLineInfo2, ...}, mapIDs={mapID1, mapID2, ...} ...}, ... }
LocalQuestLineUtils.questLineQuestsOnMap = {}  --> { [questID] = {questLineID=questLineID, mapIDs={mapID1, mapID2, ...}} , ... }

-- Retrieve available questlines for given map.
---@param mapID number  The uiMapID
---@param prepareCache boolean?  If true, just updates the data without returning it.
---@return QuestLineInfo[]? questLineInfos
--
function LocalQuestLineUtils:GetAvailableQuestLines(mapID, prepareCache)
    if prepareCache then debug:print(self, "Preparing QuestLines for", mapID) end

    -- DBUtil:CheckInitCategory("questLines")

    local questLineInfos = self:GetCachedQuestLinesForMap(mapID)
    local isProcessedZone = questLineInfos ~= nil
    debug:print(self, "isProcessedZone:", isProcessedZone)
    debug:print(self, "questLineInfos:", questLineInfos)

    if not questLineInfos then
        questLineInfos = C_QuestLine.GetAvailableQuestLines(mapID)
        if TableIsEmpty(questLineInfos) then return end  --> still no infos

        debug:print(self, format("> Found %d questline |4info:infos; for map %d", #questLineInfos, mapID))
    end

    if not isProcessedZone then
        -- Once a zone has been opened/changed on the world map, update data
        for i, questLineInfo in ipairs(questLineInfos) do
            debug:print(self, ORANGE("%d - Processing QL %d"):format(i, questLineInfo.questLineID))
            self:AddQuestLineQuestToMap(mapID, questLineInfo.questLineID, questLineInfo.questID)
            self:AddSingleQuestLineToCache(questLineInfo, mapID)
            --> TODO - Add quests meta infos ???
        end
        debug:print(self, format(YELLOW("Cached or updated %d questline |4info:infos; for map %d"), #questLineInfos, mapID))
    end

    if not prepareCache then
        -- local questLineInfos = self.questLineInfos[mapID]
        debug:print(self, format("> Returning %d questline |4info:infos; for map %d", #questLineInfos, mapID))
        return questLineInfos
    end
end

function LocalQuestLineUtils:GetCachedQuestLinesForMap(mapID)
    debug:print(self, mapID, "Looking for cached QLs on map")
    local questLineInfos = {}
    for cachedQuestLineID, cachedQuestLineData in pairs(self.questLineInfos) do
        if tContains(cachedQuestLineData.mapIDs, mapID) then
            tInsert(questLineInfos, cachedQuestLineData.questLineInfo)
        end
    end
    if TableHasAnyEntries(questLineInfos) then
        debug:print(self, mapID, format("> Found %d QLs for map", #questLineInfos))
        return questLineInfos
    end
    debug:print(self, mapID, "> No QLs in cache found.")
end

function LocalQuestLineUtils:AddSingleQuestLineToCache(questLineInfo, mapID)
    if not self.questLineInfos[questLineInfo.questLineID] then
        self.questLineInfos[questLineInfo.questLineID] = {
            questLineInfo = questLineInfo,
            mapIDs = { mapID },
        }
        debug:print(self, format("%d Added QL and map %d to cache", questLineInfo.questLineID, mapID))
        -- Also save QL in database or update mapIDs
        -- local quests = LocalQuestCache:GetQuestLineQuests(questLineInfo.questLineID)
        -- DBUtil:SaveSingleQuestLine(questLineInfo, mapID, quests)
        return
    end
    if not tContains(self.questLineInfos[questLineInfo.questLineID].mapIDs, mapID) then
        tInsert(self.questLineInfos[questLineInfo.questLineID].mapIDs, mapID)
        debug:print(self, format("%d Updated cached QL with map %d", questLineInfo.questLineID, mapID))
        -- Also update database mapIDs
        -- DBUtil:SaveSingleQuestLine(questLineInfo, mapID)
    end
end

function LocalQuestLineUtils:AddQuestLineQuestToMap(mapID, questLineID, questID)
    debug:print(self, format("%d Adding quest %d to map %d", questLineID, questID, mapID))
    if not self.questLineQuestsOnMap[questID] then
        self.questLineQuestsOnMap[questID] = {
            questLineID = questLineID,
            mapIDs = { mapID },
        }
        debug:print(self, format("%d Added QL-quest %d to map %d", questLineID, questID, mapID))
        return
    end
    if not tContains(self.questLineQuestsOnMap[questID].mapIDs, mapID) then
        tInsert(self.questLineQuestsOnMap[questID].mapIDs, mapID)
        debug:print(self, format("%d Updated QL-quest %d with map %d", questLineID, questID, mapID))
    end
end

function LocalQuestLineUtils:FilterQuestLineQuests(questLineInfo)
    local filteredQuestInfos = {}
    filteredQuestInfos.quests = {}
    filteredQuestInfos.unfilteredQuests = LocalQuestCache:GetQuestLineQuests(questLineInfo.questLineID)
    filteredQuestInfos.numTotalUnfiltered = #filteredQuestInfos.unfilteredQuests
    filteredQuestInfos.numTotal = 0
    filteredQuestInfos.numCompleted = 0
    filteredQuestInfos.numRepeatable = 0
    for i, questID in ipairs(filteredQuestInfos.unfilteredQuests) do
        -- local questInfo = LocalQuestUtils:GetQuestInfo(questID, "questline")
        local questInfo = LocalQuestInfo:GetCustomQuestInfo(questID)
        if LocalQuestFilter:PlayerMatchesQuestRequirements(questInfo) then
            if not (questInfo.isDaily or questInfo.isWeekly) then
                if LocalQuestUtils:IsQuestCompletedByAnyone(questInfo) then
                    filteredQuestInfos.numCompleted = filteredQuestInfos.numCompleted + 1
                end
            else
                filteredQuestInfos.numRepeatable = filteredQuestInfos.numRepeatable + 1
            end
            tInsert(filteredQuestInfos.quests, questInfo)
        end
    end
    local numQuests = #filteredQuestInfos.quests - filteredQuestInfos.numRepeatable
    local isRepeatableQuestLine = (numQuests == 0 and filteredQuestInfos.numRepeatable > 0)
    filteredQuestInfos.numTotal = numQuests
    filteredQuestInfos.isComplete = (filteredQuestInfos.numCompleted == filteredQuestInfos.numTotal and not isRepeatableQuestLine)

    return filteredQuestInfos
end

-- Check if given quest is part of a questline.
---@param questID number
---@param mapID number
---@return boolean hasQuestLineInfo
--
function LocalQuestLineUtils:HasQuestLineInfo(questID, mapID)
    if not mapID then
        local activeMapInfo = LocalUtils:GetActiveMapInfo()
        mapID = activeMapInfo.mapID
    end
    return (self.questLineQuestsOnMap[questID] or C_QuestLine.GetQuestLineInfo(questID, mapID)) ~= nil
end

function LocalQuestLineUtils:GetCachedQuestLineInfo(questID, mapID)
    debug:print(self, questID, "Searching questLineQuestsOnMap", mapID)
    if self.questLineQuestsOnMap[questID] then
        local questLineID = self.questLineQuestsOnMap[questID].questLineID
        local questLineInfo = self.questLineInfos[questLineID].questLineInfo
        -- **Note:**
        -- Only the first questline info per questline is cached, which also
        -- means that the info values are not specific to the given quest,
        -- but these are currently not relevant.
        questLineInfo.questID = questID
        return questLineInfo
    else
        -- Might have slipped through caching (???); try API function
        debug:print(self, questID, "QL quest NOT cached, using API call for map", mapID)
        local questLineInfo = C_QuestLine.GetQuestLineInfo(questID, mapID)
        if questLineInfo then
            self:AddSingleQuestLineToCache(questLineInfo, mapID)
            return questLineInfo
        end
    end
end

LocalQuestLineUtils.GetQuestLineInfoByPin = function(self, pin)
    debug:print(self, "Searching QL for pin", pin.questID, pin.mapID)
    local questLineInfo = self:GetCachedQuestLineInfo(pin.questID, pin.mapID)
    if questLineInfo then
        debug:print(self, format("%d Found QL %d", pin.questID, questLineInfo.questLineID))
        return questLineInfo
    end
    debug:print(self, RED("Nothing found for pin"), pin.questID, pin.mapID)
end

LocalQuestLineUtils.AddQuestLineDetailsToTooltip = function(self, tooltip, pin, campaignChapterID)
    local questLineInfo;
    if campaignChapterID then
        local chapterInfo = C_CampaignInfo.GetCampaignChapterInfo(campaignChapterID)
        local chapterName = chapterInfo and chapterInfo.name or RED(RETRIEVING_DATA)
        questLineInfo = {
            questLineID = campaignChapterID,
            questLineName = chapterName,
        }
    else
        questLineInfo = self:GetQuestLineInfoByPin(pin)
    end
    if not questLineInfo then return false end

    pin.questInfo.currentQuestLineID = questLineInfo.questLineID
    -- Note: This is later needed for the currentChapterID in quest campaigns.
    -- The actual `C_CampaignInfo.GetCurrentChapterID(campaignID)` refers only
    -- to active quest campaigns.
    pin.questInfo.currentQuestLineName = questLineInfo.questLineName
    -- Note: This is used to identify the currently active zone story.

    local filteredQuestInfos = LocalQuestLineUtils:FilterQuestLineQuests(questLineInfo)

    -- Plugin / category name
    local categoryNameOnly = ns.settings.showPluginName and LocalUtils:HasBasicTooltipContent(pin) or (not ns.settings.showZoneStorySeparately and LocalUtils:ShouldShowZoneStoryDetails(pin))
    LibQTipUtil:AddCategoryNameLine(tooltip, L.CATEGORY_NAME_QUESTLINE, categoryNameOnly)

    debug:AddDebugLineToLibQTooltip(tooltip, {text=format("> Q:%d - %s - %s_%s_%s", pin.questID, pin.pinTemplate, tostring(pin.questType), tostring(pin.questInfo.questType), pin.questInfo.isTrivial and "isTrivial" or pin.questInfo.isCampaign and "isCampaign" or "noHiddenType")})
    debug:AddDebugLineToLibQTooltip(tooltip, {text=format("> L:%d \"%s\" #%d Quests", questLineInfo.questLineID, questLineInfo.questLineName, filteredQuestInfos.numTotalUnfiltered)})

    -- Questline header name + progress
    local questLineNameTemplate = pin.questInfo.isCampaign and L.QUESTLINE_CHAPTER_NAME_FORMAT or L.QUESTLINE_NAME_FORMAT
    questLineNameTemplate = filteredQuestInfos.isComplete and questLineNameTemplate.."  "..CHECKMARK_ICON_STRING or questLineNameTemplate
    LibQTipUtil:SetColoredTitle(tooltip, QUESTLINE_HEADER_COLOR, questLineNameTemplate:format(questLineInfo.questLineName))
    local questLineCountLine = L.QUESTLINE_PROGRESS_FORMAT:format(filteredQuestInfos.numCompleted, filteredQuestInfos.numTotal)
    local numActiveQuestLines = DBUtil:CountActiveQuestlineQuests(questLineInfo.questLineID)
    if (numActiveQuestLines > 0) then
        questLineCountLine = questLineCountLine..L.TEXT_DELIMITER..LIGHTYELLOW_FONT_COLOR:WrapTextInColorCode(PARENS_TEMPLATE:format(SPEC_ACTIVE..HEADER_COLON..L.TEXT_DELIMITER..tostring(numActiveQuestLines)))
    end
    if (filteredQuestInfos.numRepeatable > 0) then
        questLineCountLine = questLineCountLine..L.TEXT_DELIMITER..BLUE(PARENS_TEMPLATE:format("+"..tostring(filteredQuestInfos.numRepeatable)))
    end
    LibQTipUtil:AddNormalLine(tooltip, questLineCountLine)

    -- Questline quests
    if GetCollapseTypeModifier(filteredQuestInfos.isComplete, "collapseType_questline") then
        for i, questInfo in ipairs(filteredQuestInfos.quests) do
            local isActiveQuest = (questInfo.questID == pin.questInfo.questID)  -- or questInfo.isComplete
            local questTitle = LocalQuestUtils:FormatQuestName(questInfo)
            if not StringIsEmpty(questInfo.questName) then
                local completedByAnyone = LocalQuestUtils:IsQuestCompletedByAnyone(questInfo)
                if completedByAnyone and isActiveQuest then
                    LibQTipUtil:AddColoredLine(tooltip, GREEN_FONT_COLOR, L.CHAPTER_NAME_FORMAT_CURRENT:format(questTitle))
                elseif completedByAnyone then
                    LibQTipUtil:AddColoredLine(tooltip, GREEN_FONT_COLOR, L.CHAPTER_NAME_FORMAT_COMPLETED:format(questTitle))
                elseif isActiveQuest then
                    LibQTipUtil:AddNormalLine(tooltip, L.CHAPTER_NAME_FORMAT_CURRENT:format(questTitle))
                elseif DBUtil:IsQuestActiveLoreQuest(questInfo.questID) then
                    LibQTipUtil:AddColoredLine(tooltip, LIGHTYELLOW_FONT_COLOR, L.CHAPTER_NAME_FORMAT_NOT_COMPLETED:format(questTitle))
                else
                    LibQTipUtil:AddHighlightLine(tooltip, L.CHAPTER_NAME_FORMAT_NOT_COMPLETED:format(questTitle))
                end
            else
                LibQTipUtil:AddErrorLine(tooltip, L.CHAPTER_NAME_FORMAT_NOT_COMPLETED:format(questTitle))
            end
        end
    else
        local textTemplate = (pin.pinTemplate == LocalUtils.QuestPinTemplate) and L.HINT_HOLD_KEY_FORMAT or L.HINT_HOLD_KEY_FORMAT_HOVER
        LibQTipUtil:AddInstructionLine(tooltip, textTemplate:format(GREEN(SHIFT_KEY)))
    end

    return true
end

----- Common Utilities ----------

LocalUtils.QuestPinTemplate = "QuestPinTemplate"
LocalUtils.QuestOfferPinTemplate = "QuestOfferPinTemplate"
LocalUtils.BonusObjectivePinTemplate = "BonusObjectivePinTemplate"
LocalUtils.ThreatObjectivePinTemplate = "ThreatObjectivePinTemplate"
LocalUtils.WorldQuestPinTemplate = "WorldMap_WorldQuestPinTemplate"
LocalUtils.StorylineQuestPinTemplate = "StorylineQuestPinTemplate"
LocalUtils.HandyNotesPinTemplate = "HandyNotesWorldMapPinTemplate"
LocalUtils.CriteriaType = {
    Achievement = 8,
    Quest = 27,
}

----- Campaign Handler ----------
--
-- REF.: <https://www.townlong-yak.com/framexml/live/ObjectAPI/CampaignChapter.lua>
-- REF.: <https://warcraft.wiki.gg/wiki/API_C_CampaignInfo.GetCampaignInfo>

CampaignUtils.wrap_chapterName = false
CampaignUtils.leftOffset_description = 16

-- Extend default results from `C_CampaignInfo.GetCampaignInfo`
CampaignUtils.GetCampaignInfo = function(self, campaignID)
    local campaignInfo = C_CampaignInfo.GetCampaignInfo(campaignID)
    if not campaignInfo then return end

    campaignInfo.campaignID = campaignID
    campaignInfo.campaignState = C_CampaignInfo.GetState(campaignID)  --> Enum.CampaignState
    campaignInfo.isComplete = campaignInfo.campaignState == Enum.CampaignState.Complete
    campaignInfo.chapterIDs = C_CampaignInfo.GetChapterIDs(campaignID)
    campaignInfo.currentChapterID = C_CampaignInfo.GetCurrentChapterID(campaignID)  --> This refers to the currently active campaign's questline
    campaignInfo.chapterIndex = tIndexOf(campaignInfo.chapterIDs, campaignInfo.currentChapterID)
    campaignInfo.numChaptersTotal = #campaignInfo.chapterIDs
    campaignInfo.numChaptersCompleted = 0
    for i, chapterID in ipairs(campaignInfo.chapterIDs) do
        local chapterIsComplete = C_QuestLine.IsComplete(chapterID)
        if chapterIsComplete then
            campaignInfo.numChaptersCompleted = campaignInfo.numChaptersCompleted + 1
        end
    end

    return campaignInfo
end

function CampaignUtils:AddCampaignDetailsTooltip(tooltip, pin, questLineTooltip)
    local campaignID = C_CampaignInfo.GetCampaignID(pin.questID)
    local campaignInfo = self:GetCampaignInfo(campaignID)

    if not campaignInfo then return end

    -- Show quest line of current chapter
    if not pin.questInfo.hasQuestLineInfo and (campaignInfo.numChaptersTotal > 0) then
        LocalQuestLineUtils:AddQuestLineDetailsToTooltip(questLineTooltip or tooltip, pin, campaignInfo.currentChapterID)
    end

    -- Plugin / category name
    local categoryNameOnly = tooltip == ContentTooltip and (ns.settings.showPluginName and LocalUtils:HasBasicTooltipContent(pin) or LocalUtils:ShouldShowZoneStoryDetails(pin) or LocalUtils:ShouldShowQuestLineDetails(pin))
    LibQTipUtil:AddCategoryNameLine(tooltip, L.CATEGORY_NAME_CAMPAIGN, categoryNameOnly)

    debug:AddDebugLineToLibQTooltip(tooltip, {text=format("> Q:%d - %s - %s_%s_%s", pin.questID, pin.pinTemplate, tostring(pin.questType), tostring(pin.questInfo.questType), pin.questInfo.isTrivial and "isTrivial" or pin.questInfo.isCampaign and "isCampaign" or "noHiddenType")})
    debug:AddDebugLineToLibQTooltip(tooltip, {text=format("> C:%d, isWarCampaign: %d, currentChapterID: %d", campaignID, campaignInfo.isWarCampaign, campaignInfo.currentChapterID)})

    -- Campaign name + progress
    local campaignNameTemplate = campaignInfo.isComplete and L.CAMPAIGN_NAME_FORMAT_COMPLETE or L.CAMPAIGN_NAME_FORMAT_INCOMPLETE
    LibQTipUtil:SetColoredTitle(tooltip, CAMPAIGN_HEADER_COLOR, campaignNameTemplate:format(campaignInfo.name))
    LibQTipUtil:AddNormalLine(tooltip, L.CAMPAIGN_PROGRESS_FORMAT:format(campaignInfo.numChaptersCompleted, campaignInfo.numChaptersTotal))

    -- Campaign chapters
    if GetCollapseTypeModifier(campaignInfo.isComplete, "collapseType_campaign") then
        for i, chapterID in ipairs(campaignInfo.chapterIDs) do
            local chapterInfo = C_CampaignInfo.GetCampaignChapterInfo(chapterID)
            local chapterName = chapterInfo and chapterInfo.name or RED(RETRIEVING_DATA)
            local currentQuestlineID = pin.questInfo.hasQuestLineInfo and pin.questInfo.currentQuestLineID or campaignInfo.currentChapterID
            if debug.showChapterIDsInTooltip then chapterName = format("|cff808080%d|r %s", chapterID, chapterName) end
            if chapterInfo then
                local chapterIsComplete = C_QuestLine.IsComplete(chapterID)
                local isActive = (chapterID == campaignInfo.currentChapterID) or (chapterID == currentQuestlineID)
                if (chapterIsComplete and isActive) then
                    LibQTipUtil:AddColoredLine(tooltip, GREEN_FONT_COLOR, L.CHAPTER_NAME_FORMAT_CURRENT:format(chapterName))
                elseif chapterIsComplete then
                    LibQTipUtil:AddColoredLine(tooltip, GREEN_FONT_COLOR, L.CHAPTER_NAME_FORMAT_COMPLETED:format(chapterName))
                elseif isActive then
                    LibQTipUtil:AddNormalLine(tooltip, L.CHAPTER_NAME_FORMAT_CURRENT:format(chapterName))
                else
                    LibQTipUtil:AddHighlightLine(tooltip, L.CHAPTER_NAME_FORMAT_NOT_COMPLETED:format(chapterName))
                end
                if ns.settings.showCampaignChapterDescription and not StringIsEmpty(chapterInfo.description) then
                    local lineTextTemplate = "|TInterface\\GossipFrame\\GossipGossipIcon:16:16:0:0|t %s"
                    LibQTipUtil:AddDescriptionLine(tooltip, lineTextTemplate:format(chapterInfo.description))
                end
                if not ns.settings.showCampaignChapterDescription and debug.isActive and not StringIsEmpty(chapterInfo.description) then
                    LibQTipUtil:AddDescriptionLine(tooltip, L.CHAPTER_NAME_FORMAT_NOT_COMPLETED:format(chapterInfo.description))
                end
            end
        end
    else
        local textTemplate = (pin.pinTemplate == LocalUtils.QuestPinTemplate) and L.HINT_HOLD_KEY_FORMAT or L.HINT_HOLD_KEY_FORMAT_HOVER
        GameTooltip_AddInstructionLine(tooltip, textTemplate:format(GREEN(SHIFT_KEY)))
    end

    -- Campaign description
    if (ns.settings.showCampaignDescription or debug.isActive) and not StringIsEmpty(campaignInfo.description) then
        LibQTipUtil:AddBlankLineToTooltip(tooltip)
        LibQTipUtil:AddNormalLine(tooltip, QUEST_DESCRIPTION)
        LibQTipUtil:AddDescriptionLine(tooltip, campaignInfo.description)

        if campaignInfo.isWarCampaign then
            LibQTipUtil:AddErrorLine(tooltip, L.CHAPTER_NAME_FORMAT_NOT_COMPLETED:format(WAR_CAMPAIGN))
        end
    end
end

--> TODO - Continue campaign tests
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/WarCampaignDocumentation.lua>
-- C_CampaignInfo.GetAvailableCampaigns() : campaignIDs
-- C_CampaignInfo.UsesNormalQuestIcons(campaignID) : useNormalQuestIcons
-- C_CampaignInfo.GetFailureReason(campaignID) : failureReason

----- Tooltips helpers ---------------------------------------------------------

local function SetDebugTooltipAnchorPoint(pin, frame, anchorFrame)
    if pin:GetCenter() < pin.owningMap.ScrollContainer:GetCenter() then
        frame:SetPoint("LEFT", anchorFrame, "RIGHT")
    else
        frame:SetPoint("RIGHT", anchorFrame, "LEFT")
    end
    frame:SetClampedToScreen(true)
end

local function SetZoneStoryTooltipAnchorPoint()
    if WorldMapFrame:IsMaximized() then
        local uiScale = UIParent:GetEffectiveScale()
        local screenWidth = GetScreenWidth() * uiScale
        if ( GetCursorPosition() < screenWidth / 2 ) then
            ZoneStoryTooltip:SetPoint("TOPRIGHT", WorldMapFrame.ScrollContainer, "TOPRIGHT", 0, -38)
        else
            ZoneStoryTooltip:SetPoint("TOPLEFT", WorldMapFrame.ScrollContainer, "TOPLEFT")
        end
    else
        ZoneStoryTooltip:SetPoint("TOPLEFT", WorldMapFrame.BorderFrame, "TOPRIGHT")
    end
end

-- Positions and displays all tooltips.
--> Note: Left and bottom side of the screen are handled automatically by the
-- system by clamping the tooltips to the screen. We need to take care of the
-- top and right side of the screen.
-- 
local function ShowAllTooltips()
    local uiScale = UIParent:GetEffectiveScale()
    local screenHeight = GetScreenHeight() * uiScale
    local screenWidth = GetScreenWidth() * uiScale

    local primaryHeight = ContentTooltip:GetHeight() * uiScale
    local scrollStep = ns.settings.scrollStep
    -- Note: screen sizes need to be here, not reliable at start-up

    -- Too far on top, content tooltip is overlapping with the game tooltip
    if (ContentTooltip:GetTop() * uiScale) > (GameTooltip:GetBottom() * uiScale) then
        GameTooltip:ClearAllPoints()
        if CampaignTooltip then
            -- Show game tooltip on top of campaign tooltip
            GameTooltip:SetAnchorType("ANCHOR_NONE")  --> needed for active quest tooltips, those are anchored to the cursor
            GameTooltip:SetPoint("BOTTOMLEFT", CampaignTooltip, "TOPLEFT")
        else
            -- Show game tooltip on the right side of content tooltip
            GameTooltip:SetPoint("BOTTOMLEFT", ContentTooltip, "BOTTOMRIGHT")
        end
        -- Too far to the right, show the game tooltip on the left side of the content tooltip
        if (((ContentTooltip:GetRight() + GameTooltip:GetWidth()) * uiScale ) > screenWidth) then
            GameTooltip:ClearAllPoints()
            GameTooltip:SetPoint("BOTTOMRIGHT", ContentTooltip, "BOTTOMLEFT")
        end
    end

    -- Too long for screen height
    if (primaryHeight > screenHeight) then
        ContentTooltip:UpdateScrolling()
        ContentTooltip:SetScrollStep(IsShiftKeyDown() and scrollStep*1.5 or scrollStep)
    end
    ContentTooltip:SetClampedToScreen(true)
    ContentTooltip:Show()

    if ZoneStoryTooltip then
        if ns.isWorldMapMaximized and (ZoneStoryTooltip:GetRight() * uiScale > ContentTooltip:GetLeft() * uiScale) then
            ZoneStoryTooltip:ClearAllPoints()
            ZoneStoryTooltip:SetPoint("TOPRIGHT", WorldMapFrame.ScrollContainer, "TOPRIGHT", 0, -38)
        end
        ZoneStoryTooltip:SetClampedToScreen(true)
        ZoneStoryTooltip:Show()
    end

    if CampaignTooltip then
        if (CampaignTooltip:GetRight() * uiScale > screenWidth) then
            -- Too far to the right, show campaign tooltip on the left side of the content tooltip
            CampaignTooltip:ClearAllPoints()
            CampaignTooltip:SetPoint("BOTTOMRIGHT", ContentTooltip, "BOTTOMLEFT")
            if (ContentTooltip:GetTop() * uiScale) > (GameTooltip:GetBottom() * uiScale) then
                -- Too far in the upper right corner, show game tooltip on top the campaign tooltip
                GameTooltip:ClearAllPoints()
                GameTooltip:SetPoint("BOTTOMRIGHT", CampaignTooltip, "TOPRIGHT")
            end
        end
        CampaignTooltip:SetClampedToScreen(true)
        CampaignTooltip:Show()
    end
end

local function ShouldShowQuestType(pin)
    -- These are types which are not displayed as tags by Blizzard
    local hasHiddenQuestType = tContains({
        -- pin.questInfo.questClassification ~= Enum.QuestClassification.Normal,
        pin.questInfo.isAccountQuest,
        pin.questInfo.isBonusObjective,
        pin.questInfo.isDaily,
        pin.questInfo.isStory,
        pin.questInfo.isRepeatable,
        pin.questInfo.isTrivial,
        pin.questInfo.isWeekly,
        pin.questInfo.questFactionGroup ~= QuestFactionGroupID.Neutral,
    }, true)
    -- pin.questInfo.isBreadcrumbQuest,
    -- pin.questInfo.isCampaign,
    -- pin.questInfo.isImportant, 
    -- pin.questInfo.isLegendary,
    -- pin.questInfo.isSequenced,
    local hasTagsToShow = hasHiddenQuestType or not ShouldIgnoreQuestTypeTag(pin.questInfo)

    return ns.settings.showQuestType and hasTagsToShow
end

local function ShouldShowReadyForTurnInMessage(pin)
    return pin.questInfo.isOnQuest and ns.settings.showQuestTurnIn and pin.questInfo.isReadyForTurnIn
end

function LocalUtils:ShouldShowZoneStoryDetails(pin)
    local achievementID, achievementID2, storyMapInfo = ZoneStoryUtils:GetZoneStoryInfo(pin.mapID)
    local showInCompletedZones = not (ns.settings.hideZoneStoryInCompletedZones and LocalAchievementUtil.IsAchievementCompleted(achievementID))
    if not showInCompletedZones then
        return false
    end
    if ( not ns.settings.showOptionalZoneStories and LoreUtil:IsOptionalAchievement(achievementID) )  then
        return false
    end
    return ns.settings.showZoneStory and pin.questInfo.hasZoneStoryInfo
end

function LocalUtils:ShouldShowQuestLineDetails(pin)
    return ns.settings.showQuestLine and pin.questInfo.hasQuestLineInfo
end

function LocalUtils:ShouldShowCampaignDetails(pin)
    return ns.settings.showCampaign and pin.questInfo.isCampaign
end

function LocalUtils:HasBasicTooltipContent(pin)
    return ShouldShowQuestType(pin) or ShouldShowReadyForTurnInMessage(pin)
end

function LocalUtils:IsPinTaskQuest(pin)
    local taskMapPinTemplates = {
        LocalUtils.BonusObjectivePinTemplate,
        LocalUtils.ThreatObjectivePinTemplate,
        LocalUtils.WorldQuestPinTemplate,
    }

    return tContains(taskMapPinTemplates, pin.pinTemplate)
end

function LocalUtils:IsPinQuestOffer(pin)
    return pin.pinTemplate == LocalUtils.QuestOfferPinTemplate
end

function LocalUtils:IsPinActiveQuest(pin)
    return pin.pinTemplate == LocalUtils.QuestPinTemplate
end

local function GetWorldQuestQualityColor(questTagInfo)
    if not questTagInfo then return NORMAL_FONT_COLOR; end

    local quality = questTagInfo.quality or Enum.WorldQuestQuality.Common
    return WORLD_QUEST_QUALITY_COLORS[quality].color
end

--------------------------------------------------------------------------------
----- Hooking Functions --------------------------------------------------------
--------------------------------------------------------------------------------

local ticker = nil

local function Hook_QuestPin_OnLeave()
    if ticker then
        ticker:Cancel()
	    ticker = nil
    end

    -- Release tooltip(s)
    if ContentTooltip then
        LibQTip:Release(ContentTooltip)
        ContentTooltip = nil
    end
    if ZoneStoryTooltip then
        LibQTip:Release(ZoneStoryTooltip)
        ZoneStoryTooltip = nil
    end
    if CampaignTooltip then
        LibQTip:Release(CampaignTooltip)
        CampaignTooltip = nil
    end
    if debug.tooltip then
        LibQTip:Release(debug.tooltip)
        debug.tooltip = nil
    end
end

-- Create the 3 content tooltips and reposition the GameTooltip.
---@param pin table
---@return LibQTip.Tooltip|nil contentTooltip
--
local function CreateCustomTooltips(pin)
    -- Note: Timed pins have a timer for reloading and updating the tooltip
    -- content. The LibQTip tooltip needs to be released before a new one can
    -- be created. By default this only happens when the mouse leaves the
    -- worldmap pin, so we do this here manually w/o destroying the tooltip.
    Hook_QuestPin_OnLeave()

    -- Prepare tooltip name suffixes
    local suffixMapByPinTemplate = {
        [LocalUtils.QuestPinTemplate] = "Active",
        [LocalUtils.QuestOfferPinTemplate] = "Offer",
        [LocalUtils.WorldQuestPinTemplate] = "WQ",
        [LocalUtils.ThreatObjectivePinTemplate] = "WQ",
        [LocalUtils.BonusObjectivePinTemplate] = "WQ",
    }
    local suffix = suffixMapByPinTemplate[pin.pinTemplate]

    -- Primary tooltip (quest tags + questlines)
    ContentTooltip = LibQTip:Acquire(AddonID.."LibQTooltipContent"..suffix, 1, "LEFT")
    ContentTooltip:SetPoint("RIGHT", pin, "LEFT", 14, 0)

    -- Game tooltip: reposition the World Map pin's default tooltip
    GameTooltip:ClearAllPoints()
    GameTooltip:SetPoint("BOTTOMRIGHT", ContentTooltip, "TOPRIGHT")
    -- -- print("GameTooltip2:", GameTooltip:GetAnchorType(), GameTooltip:NumLines())

    -- Zone story tooltip
    if (ns.settings.showZoneStorySeparately and LocalUtils:ShouldShowZoneStoryDetails(pin)) then
        ZoneStoryTooltip = LibQTip:Acquire(AddonID.."LibQTooltipZoneStory"..suffix, 1, "LEFT")
        SetZoneStoryTooltipAnchorPoint()
    end

    -- Campaign tooltip
    if (ns.settings.showCampaignSeparately and LocalUtils:ShouldShowCampaignDetails(pin)) then
        CampaignTooltip = LibQTip:Acquire(AddonID.."LibQTooltipCampaign"..suffix, 1, "LEFT")
        CampaignTooltip:SetPoint("BOTTOMLEFT", ContentTooltip, "BOTTOMRIGHT")
    end

    return ContentTooltip
end

local function AddTooltipContent(contentTooltip, pin)

    debug:AddDebugLineToLibQTooltip(contentTooltip,  {text=format("> Q:%d - %s - %s_%s_%s", pin.questID, pin.pinTemplate, tostring(pin.questType), tostring(pin.questInfo.questType), pin.questInfo.isTrivial and "isTrivial" or pin.questInfo.isCampaign and "isCampaign" or "noHiddenType")})

    -- Add quest title + adjust tooltip width to the GameTooltip
    local TitleColor = LocalUtils:IsPinTaskQuest(pin) and GetWorldQuestQualityColor(pin.questInfo.questTagInfo) or NORMAL_FONT_COLOR
    local lineIndex, columnIndex = LibQTipUtil:SetColoredTitle(contentTooltip, TitleColor, '')
    --> REF.: qTip:SetCell(lineNum, colNum, value[, font][, justification][, colSpan][, provider][, leftPadding][, rightPadding][, maxWidth][, minWidth][, ...])
    contentTooltip:SetCell(lineIndex, 1, pin.questInfo.questName, nil, "LEFT", nil, nil, nil, nil, GameTooltip:GetWidth(), GameTooltip:GetWidth()-20)

    -- Plugin name
    if ( ns.settings.showPluginName and LocalUtils:HasBasicTooltipContent(pin) ) then
        LibQTipUtil:AddPluginNameLine(contentTooltip)
    end

    -- Turn-in message
    if (LocalUtils:IsPinActiveQuest(pin) and ShouldShowReadyForTurnInMessage(pin)) then
        if not ns.settings.showPluginName then
            LibQTipUtil:AddBlankLineToTooltip(contentTooltip)
        end
        LibQTipUtil:AddInstructionLine(contentTooltip, QUEST_WATCH_QUEST_READY)
    end

    -- Quest type tags
    if ShouldShowQuestType(pin) then
        if not ns.settings.showPluginName or (LocalUtils:IsPinActiveQuest(pin) and ShouldShowReadyForTurnInMessage(pin)) then
            LibQTipUtil:AddBlankLineToTooltip(contentTooltip)
        end
        LocalQuestUtils:AddQuestTagLinesToTooltip_New(contentTooltip, pin.questInfo)
        if debug.isActive then
            LibQTipUtil:AddDisabledLine(contentTooltip, "Older style tags")
            LocalQuestUtils:AddQuestTagLinesToTooltip(contentTooltip, pin.questInfo)
        end
    end

    -- Zone story
    if LocalUtils:ShouldShowZoneStoryDetails(pin) then
        local zsTooltip = ZoneStoryTooltip or contentTooltip
        pin.achievementID, pin.achievementID2, pin.storyMapInfo = ZoneStoryUtils:GetZoneStoryInfo(pin.mapID)
        ZoneStoryUtils:AddZoneStoryDetailsToTooltip(zsTooltip, pin)
        if pin.achievementID2 then
            pin.achievementID = pin.achievementID2
            ZoneStoryUtils:AddZoneStoryDetailsToTooltip(zsTooltip, pin)
        end
    end

    -- Questline
    if LocalUtils:ShouldShowQuestLineDetails(pin) then
        LocalQuestLineUtils:AddQuestLineDetailsToTooltip(contentTooltip, pin)
    end

    -- Campaign
    if LocalUtils:ShouldShowCampaignDetails(pin) then
        local cpTooltip = CampaignTooltip or contentTooltip
        CampaignUtils:AddCampaignDetailsTooltip(cpTooltip, pin, contentTooltip)
    end

    -- Waypoint hint - not needed for active quests or world quests
    if (LocalUtils:IsPinQuestOffer(pin) and LocalUtils:HasBasicTooltipContent(pin) and C_Map.CanSetUserWaypointOnMap(pin.mapID) ) then
        LibQTipUtil:AddBlankLineToTooltip(contentTooltip)
        LibQTipUtil:AddInstructionLine(contentTooltip, L.HINT_SET_WAYPOINT)
    end
end
----------

local function IsRelevantQuest(questInfo)
    return (questInfo.isCampaign or questInfo.isStory or questInfo.hasQuestLineInfo or questInfo.isBonusObjective or
            not LocalQuestTagUtil:ShouldIgnoreQuestTypeTag(questInfo))
            -- (questInfo.questTagInfo ~= nil and not ShouldIgnoreQuestTypeTag(questInfo))
end

-- Extend and update quest meta data
local function UpdateWorldMapPinQuestInfo(pin)
    local isSameAsPreviousPin = pin.questInfo and pin.questInfo.questID == pin.questID
    local isSameArea = pin.mapID and pin.mapID == ns.activeZoneMapInfo.mapID

    if not (isSameAsPreviousPin and isSameArea) then
        -- Only refresh quest data once when hovering a different quest pin or changing the area
        pin.mapID = pin:GetMap():GetMapID()
        -- pin.questInfo = LocalQuestUtils:GetQuestInfo(pin.questID, "pin", pin.mapID)
        pin.questInfo = LocalQuestInfo:GetQuestInfoForPin(pin)               --> TODO - Finish and switch to new questInfo
    end
    -- Update this every time
    pin.questInfo.hasZoneStoryInfo = ZoneStoryUtils:HasZoneStoryInfo(pin.mapID)
    if (pin.pinTemplate == LocalUtils.QuestPinTemplate) then
        pin.questInfo.isReadyForTurnIn = C_QuestLog.ReadyForTurnIn(pin.questID)
    end
end

local function WorldMapPin_RefreshAllData(pin)
    -- Extend quest meta data
    UpdateWorldMapPinQuestInfo(pin)

    -- Dev info
    if (debug.isActive and IsShiftKeyDown() and IsControlKeyDown()) then
        Hook_QuestPin_OnLeave()
        debug:CreateDebugQuestInfoTooltip(pin)  --> LibQTip type tooltip
        SetDebugTooltipAnchorPoint(pin, debug.tooltip, GetAppropriateTooltip())
        debug.tooltip:Show()
        return
    end

    -- Ignore basic quests w/o any lore and skip custom tooltip creation.
    if (not IsRelevantQuest(pin.questInfo) and not LocalUtils:HasBasicTooltipContent(pin)) then
        return
    end

    -- Add content
    local contentTooltip = CreateCustomTooltips(pin)
    if not contentTooltip then
        return
    end
    AddTooltipContent(contentTooltip, pin)

    ShowAllTooltips()
end

----------

local function Hook_StorylineQuestPin_OnEnter(pin)
    if not pin.questID then return end
    if (pin.pinTemplate ~= LocalUtils.QuestOfferPinTemplate) then return end

    WorldMapPin_RefreshAllData(pin)

    -- Add ticker to quest offers to update content
    --> REF.: [WorldQuestDataProvider.lua](https://www.townlong-yak.com/framexml/live/Blizzard_SharedMapDataProviders/WorldQuestDataProvider.lua)
    assert(ticker == nil)
	ticker = C_Timer.NewTicker(0.3, function() WorldMapPin_RefreshAllData(pin) end)
end

----------

local function Hook_ActiveQuestPin_OnEnter(pin)
    if not pin.questID then return end
    if (pin.pinTemplate ~= LocalUtils.QuestPinTemplate) then return end

    WorldMapPin_RefreshAllData(pin)
end

----------

local function Hook_WorldQuestsPin_OnEnter(pin)
    if not pin.questID then return end
    if (not ns.settings.trackWorldQuests and pin.pinTemplate == LocalUtils.WorldQuestPinTemplate) then return end
    if (not ns.settings.trackThreatObjectives and pin.pinTemplate == LocalUtils.ThreatObjectivePinTemplate) then return end
    if (not ns.settings.trackBonusObjectives and pin.pinTemplate == LocalUtils.BonusObjectivePinTemplate) then return end

    WorldMapPin_RefreshAllData(pin)
end

-----

local function Hook_QuestPin_OnClick(pin, mouseButton)
    if IsAltKeyDown() then
        debug:print(HookUtils, "Alt-Clicked:", pin.questID, pin.pinTemplate, mouseButton)    --> works, but only with "LeftButton" (!)

        local posX, posY = pin:GetPosition()
        local chatNotifyOnError = true
        LocalMapUtils:SetUserWaypointXY(pin.mapID, posX, posY, nil, chatNotifyOnError)
    end
end

local function Hook_WorldMap_OnFrameSizeChanged()
    if ( ns.isWorldMapMaximized ~= WorldMapFrame:IsMaximized() ) then
        ns.isWorldMapMaximized = WorldMapFrame:IsMaximized()
        LoremasterPlugin:RefreshAll()
    end
end

----- Ace3 Profile Handler ----------                                           --> TODO - Needed ?? ...or add to HNLM?

function LoremasterPlugin:OnProfileChanged(event, ...)
    -- REF.: <https://www.wowace.com/projects/ace3/pages/api/ace-db-3-0>
    debug:print(HookUtils, event, ...)

    if (event == "OnProfileReset") then
        -- local database = ...
        local noChildren, noCallbacks = nil, true
        self.db:ResetProfile(noChildren, noCallbacks)
    end

    if (event == "OnProfileDeleted") then
        -- local database = ...
        -- local noChildren, noCallbacks = nil, true
        -- self.db:ResetProfile(noChildren, noCallbacks)
        debug:print(event, ...)
    end

    -- Note: The database given to the event handler is the one that changed,
    -- ie. HandyNotes.db (do NOT use!)
    if (event == "OnProfileCopied") then
        local database, newProfileKey = ...
        local silent = true
        self.db:CopyProfile(newProfileKey, silent)
    end
    if (event == "OnProfileChanged") then
        local database, newProfileKey = ...
        self.db:SetProfile(newProfileKey)
    end
    ns.settings = self.db.profile
    self:Print(HandyNotes.name, "profile change adapted.")

    --> TODO - L10n
    -- REF.: <https://www.wowace.com/projects/ace3/localization>
end

function LoremasterPlugin:OnHandyNotesStateChanged()
    local parent_state = HandyNotes:IsEnabled()
    if (parent_state ~= self:IsEnabled()) then
        -- Toggle this plugin
        if parent_state then self:OnEnable() else self:OnDisable() end
        self:SetEnabledState(parent_state)
    end
end

function LoremasterPlugin:RegisterHooks()
    -- Hooking active/ongoing quests
    hooksecurefunc(QuestPinMixin, "OnMouseEnter", Hook_ActiveQuestPin_OnEnter)
    hooksecurefunc(QuestPinMixin, "OnMouseLeave", Hook_QuestPin_OnLeave)
    -- hooksecurefunc(QuestPinMixin, "OnClick", Hook_QuestPin_OnClick)

    -- Hooking storyline quests
    --> Note: "StorylineQuestPinMixin" has been removed in 11.0.0 from the game.
    hooksecurefunc(QuestOfferPinMixin, "OnMouseEnter", Hook_StorylineQuestPin_OnEnter)
    hooksecurefunc(QuestOfferPinMixin, "OnMouseLeave", Hook_QuestPin_OnLeave)
    hooksecurefunc(QuestOfferPinMixin, "OnClick", Hook_QuestPin_OnClick)

    -- Hooking threat-, bonus-, and world quests
    hooksecurefunc(ThreatObjectivePinMixin, "OnMouseEnter", Hook_WorldQuestsPin_OnEnter)  -- Hook_StorylineQuestPin_OnEnter)
    hooksecurefunc(ThreatObjectivePinMixin, "OnMouseLeave", Hook_QuestPin_OnLeave)

    hooksecurefunc(BonusObjectivePinMixin, "OnMouseEnter", Hook_WorldQuestsPin_OnEnter)
    hooksecurefunc(BonusObjectivePinMixin, "OnMouseLeave", Hook_QuestPin_OnLeave)

    hooksecurefunc(WorldMap_WorldQuestPinMixin, "OnMouseEnter", Hook_WorldQuestsPin_OnEnter)  -- Hook_StorylineQuestPin_OnEnter)
    hooksecurefunc(WorldMap_WorldQuestPinMixin, "OnMouseLeave", Hook_QuestPin_OnLeave)

    -- HandyNotes Hooks
    --> Callback types: <https://www.wowace.com/projects/ace3/pages/ace-db-3-0-tutorial#title-5>
    HandyNotes.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
    HandyNotes.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
    HandyNotes.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
    HandyNotes.db.RegisterCallback(self, "OnProfileDeleted", "OnProfileChanged")
    hooksecurefunc(HandyNotes, "OnEnable", self.OnHandyNotesStateChanged)
    hooksecurefunc(HandyNotes, "OnDisable", self.OnHandyNotesStateChanged)

    -- Keep track of World Map size changes, ie. to adjust icon scale, tooltips position, etc.
    hooksecurefunc(WorldMapFrame, "OnFrameSizeChanged", Hook_WorldMap_OnFrameSizeChanged)
end

----- Ace3 event handler

-- Inform user; print user-visible chat message
---@param questID number
---@param questLineID number|nil
---@param campaignID number|nil
--
local function PrintLoreQuestRemovedMessage(questID, questLineID, campaignID)
    local isQuestCompleted = LocalQuestUtils:IsQuestCompletedByAnyone(nil, questID)
    local numThreshold = not isQuestCompleted and 1 or 0
    local activeMapInfo = LocalUtils:GetActiveMapInfo()
    if (campaignID and ns.settings.showCampaignQuestProgressMessage) then
        local campaignInfo = CampaignUtils:GetCampaignInfo(campaignID)
        if campaignInfo then
            local questLineInfo = LocalQuestLineUtils:GetCachedQuestLineInfo(questID, activeMapInfo.mapID)
            if questLineInfo then
                local filteredQuestInfos = LocalQuestLineUtils:FilterQuestLineQuests(questLineInfo)
                ns:cprintf("You've completed %s quests of the %s chapter from the %s campaign.",
                           L.GENERIC_FORMAT_FRACTION_STRING:format(filteredQuestInfos.numCompleted + numThreshold, filteredQuestInfos.numTotal),
                           CAMPAIGN_HEADER_COLOR:WrapTextInColorCode(campaignInfo.name),
                           QUESTLINE_HEADER_COLOR:WrapTextInColorCode(questLineInfo.questLineName)
                )
            -- else
            --     ns:cprintf("This quest was part of the campaign %s.", CAMPAIGN_HEADER_COLOR:WrapTextInColorCode(campaignInfo.name))
            end

            return
        end
    end
    if (questLineID and ns.settings.showQuestlineQuestProgressMessage) then
        local questLineInfo = LocalQuestLineUtils:GetCachedQuestLineInfo(questID, activeMapInfo.mapID)
        if questLineInfo then
            local filteredQuestInfos = LocalQuestLineUtils:FilterQuestLineQuests(questLineInfo)
            ns:cprintf("You've completed %s quests of the %s questline.",
                       L.GENERIC_FORMAT_FRACTION_STRING:format(filteredQuestInfos.numCompleted + numThreshold, filteredQuestInfos.numTotal),
                       QUESTLINE_HEADER_COLOR:WrapTextInColorCode(questLineInfo.questLineName)
            )
            if (filteredQuestInfos.numCompleted + numThreshold == filteredQuestInfos.numTotal) then
                ns:cprint(GREEN(L.CONGRATULATIONS), format("You have completed all %s quests in %s.", QUESTLINE_HEADER_COLOR:WrapTextInColorCode(questLineInfo.questLineName), activeMapInfo.name))
            end
        end
    end
end

-- Inform user about adding a lore quest with a chat message
---@param questInfo table
---@return number|nil questLineID
---@return number|nil campaignID
--
local function PrintQuestAddedMessage(questInfo)
    local questLineID, campaignID, currentChapterID
    if questInfo.isCampaign then
        campaignID = C_CampaignInfo.GetCampaignID(questInfo.questID)
        local campaignInfo = CampaignUtils:GetCampaignInfo(campaignID)
        local activeMapInfo = LocalUtils:GetActiveMapInfo()
        if campaignInfo then
            local questLineInfo = LocalQuestLineUtils:GetCachedQuestLineInfo(questInfo.questID, activeMapInfo.mapID)
            if (questLineInfo and ns.settings.showCampaignQuestProgressMessage) then
                local filteredQuestInfos = LocalQuestLineUtils:FilterQuestLineQuests(questLineInfo)
                local numActiveQuestLines = DBUtil:CountActiveQuestlineQuests(questLineInfo.questLineID)
                ns:cprintf("This is quest %s of the %s campaign from the chapter %s.",
                           L.GENERIC_FORMAT_FRACTION_STRING:format(filteredQuestInfos.numCompleted + numActiveQuestLines + 1, filteredQuestInfos.numTotal),
                           CAMPAIGN_HEADER_COLOR:WrapTextInColorCode(campaignInfo.name),
                           QUESTLINE_HEADER_COLOR:WrapTextInColorCode(questLineInfo.questLineName)
                )
            end
            if not questInfo.hasQuestLineInfo then
                return campaignInfo.currentChapterID, campaignInfo.campaignID  --> questLineID, campaignID
            end
            currentChapterID = campaignInfo.currentChapterID
        end
    end
    if questInfo.hasQuestLineInfo then
        local questLineInfo = LocalQuestLineUtils:GetCachedQuestLineInfo(questInfo.questID, questInfo.playerMapID)
        if questLineInfo then
            if (ns.settings.showQuestlineQuestProgressMessage and not questInfo.isCampaign) then
                local filteredQuestInfos = LocalQuestLineUtils:FilterQuestLineQuests(questLineInfo)
                local numActiveQuestLines = DBUtil:CountActiveQuestlineQuests(questLineInfo.questLineID)
                ns:cprintf("This is quest %s from the %s questline.",
                            L.GENERIC_FORMAT_FRACTION_STRING:format(filteredQuestInfos.numCompleted + numActiveQuestLines + 1, filteredQuestInfos.numTotal),
                            QUESTLINE_HEADER_COLOR:WrapTextInColorCode(questLineInfo.questLineName)
                )
            end
            if not questInfo.isCampaign then
                return questLineInfo.questLineID
            end
            questLineID = questLineInfo.questLineID
        end
    end

    -- Note: Sometimes campaign chapter IDs and questline IDs ar *not* identical; prefer questline ID if available.
    return questLineID or currentChapterID, campaignID
end

-- Save the questline of an active quest, if available.
function LoremasterPlugin:QUEST_ACCEPTED(eventName, ...)
    local questID = ...
    -- local questInfo = LocalQuestUtils:GetQuestInfo(questID, "event")
    local questInfo = LocalQuestInfo:GetQuestInfoForQuestEvents(questID)
    debug:print(LocalQuestFilter, "Quest accepted:", questID, questInfo.questName)
    debug:print(LocalQuestFilter, "> isWeekly-isDaily:", questInfo.isWeekly, questInfo.isDaily)
    debug:print(LocalQuestFilter, "> isStory-isCampaign-isQuestLine:", questInfo.isStory, questInfo.isCampaign, questInfo.hasQuestLineInfo)

    if tContains({questInfo.isWeekly, questInfo.isDaily}, true) then return end  -- Not lore relevant; do nothing.

    if (questInfo.isCampaign or questInfo.hasQuestLineInfo) then
        local questLineID, campaignID = PrintQuestAddedMessage(questInfo)
        DBUtil:AddActiveLoreQuest(questID, questLineID, campaignID)
    end
    -- if questInfo.isStory then                                                --> TODO - Add this
    --     local nameTemplate = "A:questlog-questtypeicon-story:16:16:0:-1|a %s"
    --     ns:cprint(nameTemplate:format(ORANGE("This quest is part of a story.")))
    -- end
end

-- Save daily and weekly quests as completed, if they are lore relevant.
function LoremasterPlugin:QUEST_TURNED_IN(eventName, ...)
    local questID, xpReward, moneyReward = ...
    -- local questInfo = LocalQuestUtils:GetQuestInfo(questID, "event")
    local questInfo = LocalQuestInfo:GetQuestInfoForQuestEvents(questID)
    debug:print(LocalQuestFilter, "Quest turned in:", questID, questInfo.questName)
    debug:print(LocalQuestFilter, "> isWeekly-isDaily:", questInfo.isWeekly, questInfo.isDaily)
    debug:print(LocalQuestFilter, "> isStory-isCampaign-isQuestLine:", questInfo.isStory, questInfo.isCampaign, questInfo.hasQuestLineInfo)

    if LocalQuestFilter:ShouldSaveRecurringQuest(questInfo) then
        local recurringTypeName = questInfo.isWeekly and "Weekly" or "Daily"
        DBUtil:SetRecurringQuestCompleted(recurringTypeName, questID)
    end

    if DBUtil:IsQuestActiveLoreQuest(questID) then
        local questLineID, campaignID = DBUtil:RemoveActiveLoreQuest(questID)
        PrintLoreQuestRemovedMessage(questID, questLineID, campaignID)
    end
end

-- Remove saved active quests.
-- Note: This event fires before and sometimes after you turn-in a quest or when you abort a quest.
function LoremasterPlugin:QUEST_REMOVED(eventName, ...)
    local questID, wasReplayQuest = ...
    -- local questInfo = LocalQuestUtils:GetQuestInfo(questID, "event")
    local questInfo = LocalQuestInfo:GetQuestInfoForQuestEvents(questID)
    debug:print(LocalQuestFilter, "Quest removed:", questID, questInfo.questName)
    debug:print(LocalQuestFilter, "> wasReplayQuest:", wasReplayQuest)

    if DBUtil:IsQuestActiveLoreQuest(questID) then
        local questLineID, campaignID = DBUtil:RemoveActiveLoreQuest(questID)
        PrintLoreQuestRemovedMessage(questID, questLineID, campaignID)
    end
end

function LoremasterPlugin:ACHIEVEMENT_EARNED(eventName, ...)
    if not ns.settings.showCriteriaEarnedMessage then return end

    local achievementID, alreadyEarned = ...
    local playerMapID = LocalMapUtils:GetBestMapForPlayer()
    local storyAchievementID, storyAchievementID2, storyMapInfo = ZoneStoryUtils:GetZoneStoryInfo(playerMapID)
    if tContains({storyAchievementID, storyAchievementID2}, achievementID) then
        local achievementInfo = ZoneStoryUtils:GetAchievementInfo(achievementID)
        if achievementInfo then
            local achievementLink = LocalAchievementUtil.GetAchievementLinkWithIcon(achievementInfo)
            local mapInfo = LocalMapUtils:GetMapInfo(playerMapID)
            ns:cprint(ORANGE(L.CONGRATULATIONS), format("You have completed %s in %s.", achievementLink, mapInfo.name))
            ZoneStoryUtils.achievements[achievementID] = nil  --> reset cache for this achievement or details won't update
        end
    end
end

function LoremasterPlugin:CRITERIA_EARNED(eventName, ...)
    if not ns.settings.showCriteriaEarnedMessage then return end

    local achievementID, description = ...
    local playerMapID = LocalMapUtils:GetBestMapForPlayer()
    local storyAchievementID, storyAchievementID2, storyMapInfo = ZoneStoryUtils:GetZoneStoryInfo(playerMapID)
    if tContains({storyAchievementID, storyAchievementID2}, achievementID) then
        local achievementInfo = ZoneStoryUtils:GetAchievementInfo(achievementID)
        if achievementInfo then
            local achievementLink = LocalAchievementUtil.GetAchievementLinkWithIcon(achievementInfo)
            local criteriaAmount = PARENS_TEMPLATE:format(L.GENERIC_FORMAT_FRACTION_STRING:format(achievementInfo.numCompleted, achievementInfo.numCriteria))
            ns:cprint(YELLOW(ACHIEVEMENT_PROGRESSED)..HEADER_COLON, achievementLink, criteriaAmount)
            ZoneStoryUtils.achievements[achievementID] = nil  --> reset cache for this achievement or details won't update
            -- local numLeft = achievementInfo.numCriteria - achievementInfo.numCompleted
            -- if (numLeft > 0) then
            --     ns:cprintf(YELLOW("> %d more to go to complete this achievement."), numLeft)
            -- end
        end
    end
end
-- Test_Achievement = function() LoremasterPlugin:ACHIEVEMENT_EARNED(nil, 1195, false) end
-- Test_Criteria = function() LoremasterPlugin:CRITERIA_EARNED(nil, 1195, "Schattenmond") end

LoremasterPlugin:RegisterEvent("QUEST_ACCEPTED")
LoremasterPlugin:RegisterEvent("QUEST_TURNED_IN")
LoremasterPlugin:RegisterEvent("QUEST_REMOVED")
LoremasterPlugin:RegisterEvent("ACHIEVEMENT_EARNED")
LoremasterPlugin:RegisterEvent("CRITERIA_EARNED")

--------------------------------------------------------------------------------
----- Required functions for HandyNotes ----------------------------------------
--------------------------------------------------------------------------------

local iconZoneStoryComplete = "common-icon-checkmark"
local iconZoneStoryIncomplete = "common-icon-redx"
local iconOptionalZoneStoryComplete = "common-icon-checkmark-yellow"
local iconOptionalZoneStoryIncomplete = "common-icon-yellowx"
local iconHiddenCharSpecificComplete = {"common-icon-checkmark-yellow", 0.019, 0.461, 0.99, 1}  --> {atlasName, r, g, b, a}
local iconHiddenCharSpecificIncomplete = {"common-icon-yellowx", 0.019, 0.461, 0.99, 1}  -- dark green
-- local iconHiddenCharSpecificIncomplete = {"common-icon-redx", 0.592, 0.137, 0.027, 1}  -- dark red
-- local iconHiddenCharSpecificComplete = {"common-icon-checkmark-yellow", 0.831, 0, 1, 1}  -- red

local node2Offset = 0.008  -- ns.isWorldMapMaximized and 0.0001 or 0.008
local zoneOffsetInfo = {  --> Some nodes are overlapping with something else on the map.
    [LocalMapUtils.AZSHARA_MAP_ID] = { x = -0.02, y = 0 },
    [LocalMapUtils.BLASTED_LANDS_MAP_ID] = { x = -0.005, y = -0.01 },
    [LocalMapUtils.BROKEN_SHORE_MAP_ID] = { x = 0.025, y = 0 },
    [LocalMapUtils.DARKSHORE_MAP_ID] = { x = -0.015, y = 0 },
    [LocalMapUtils.FELWOOD_MAP_ID] = { x = -0.015, y = -0.01 },
    [LocalMapUtils.FERALAS_MAP_ID] = { x = 0.005, y = -0.02 },
    [LocalMapUtils.ICECROWN_MAP_ID] = { x = 0, y = 0.02},
    [LocalMapUtils.KRASARANG_WILDS_MAP_ID] = { x = 0, y = -0.02 },
    [LocalMapUtils.MECHAGON_ISLAND_MAP_ID] = { x = 0.015, y = 0 },
    [LocalMapUtils.TEROKKAR_FOREST_MAP_ID] = { x = 0.005, y = 0.02 },
    [LocalMapUtils.THALDRASZUS_MAP_ID] = { x = 0.03, y = 0.02 },
    [LocalMapUtils.TIRAGARDE_SOUND_MAP_ID] = { x = 0.08, y = -0.04 },
    [LocalMapUtils.VALSHARAH_MAP_ID] = { x = 0, y = -0.01 },
    [LocalMapUtils.ZARALEK_CAVERN_MAP_ID] = { x = -0.025, y = -0.01 },
}

-- Convert an atlas file to a texture table with coordinates suitable for
-- HandyNotes map icons.
---@param atlasData string|table
---@return table|nil textureInfo
--
-- REF.: <https://github.com/Nevcairiel/HandyNotes/blob/a8e8163c1ebc6f41dd42690aa43dc6de13211c87/HandyNotes.lua#L379C35-L379C35>
--
local function GetTextureInfoFromAtlas(atlasData)
    local atlasName = (type(atlasData) == "table") and atlasData[1] or atlasData
    local atlasInfo = C_Texture.GetAtlasInfo(atlasName)
    if atlasInfo then
        local iconpath = {
            tCoordLeft = atlasInfo.leftTexCoord,
            tCoordRight = atlasInfo.rightTexCoord,
            tCoordTop = atlasInfo.topTexCoord,
            tCoordBottom = atlasInfo.bottomTexCoord,
            icon = atlasInfo.file,
        }
        if (type(atlasData) == "table") then
            iconpath.r = atlasData[2]
            iconpath.g = atlasData[3]
            iconpath.b = atlasData[4]
            iconpath.a = atlasData[5] or 1
        end

        return iconpath
    end
end

local function GetAchievementTypeIcon(achievementInfo)
    if achievementInfo.isOptionalAchievement then
        return achievementInfo.completed and GetTextureInfoFromAtlas(iconOptionalZoneStoryComplete) or GetTextureInfoFromAtlas(iconOptionalZoneStoryIncomplete)
    end
    if LoreUtil:IsHiddenCharSpecificAchievement(achievementInfo.achievementID) then
        return achievementInfo.completed and GetTextureInfoFromAtlas(iconHiddenCharSpecificComplete) or GetTextureInfoFromAtlas(iconHiddenCharSpecificIncomplete)
    end

    return achievementInfo.completed and GetTextureInfoFromAtlas(iconZoneStoryComplete) or GetTextureInfoFromAtlas(iconZoneStoryIncomplete)
end

local function AddAchievementNode(mapID, x, y, achievementInfo, storyMapInfo)
    local icon = GetAchievementTypeIcon(achievementInfo)
    local iconSizeScale = achievementInfo.completed and 1.0 or 0.85 --> adjust size of red "x" icon, it is slightly bigger than the checkmark icon
    local mapSizeScale = ns.isWorldMapMaximized and 0.4 or 0   --> adjust icon size, they appear smaller on the full screen World Map
    local scale = ns.settings.continentIconScale * ( iconSizeScale + mapSizeScale)
	local alpha = ns.settings.continentIconAlpha or 1.0
    local coord = HandyNotes:getCoord(x, y)
    -- local coord = ns.utils.handynotes:GetCoordFromXY(x, y)
    -- print(i, mapID, mapChildInfo.name, "-->", coord)

    nodes[mapID][coord] = {mapInfo=storyMapInfo, icon=icon, scale=scale, alpha=alpha, achievementInfo=achievementInfo}  --> zoneData
end

local additionalMapInfos = {
    [LocalMapUtils.BROKEN_ISLES_MAP_ID] = {LocalMapUtils.ARGUS_MAP_ID},
    [LocalMapUtils.COSMIC_MAP_ID] = {LocalMapUtils.AZEROTH_MAP_ID},
    [LocalMapUtils.KUL_TIRAS_MAP_ID] = {LocalMapUtils.NAZJATAR_MAP_ID},
    [LocalMapUtils.NAZJATAR_MAP_ID] = {LocalMapUtils.ZANDALAR_MAP_ID, LocalMapUtils.KUL_TIRAS_MAP_ID},
    [LocalMapUtils.STRANGLETHORN_MAP_ID] = {LocalMapUtils.CAPE_OF_STRANGLETHORN_MAP_ID, LocalMapUtils.NORTHERN_STRANGLETHORN_MAP_ID},
    [LocalMapUtils.THE_SHADOWLANDS_MAP_ID] = {LocalMapUtils.ORIBOS_MAP_ID},
    [LocalMapUtils.VASHJIR_MAP_ID] = {LocalMapUtils.KELPTHAR_FOREST_MAP_ID, LocalMapUtils.ABYSSAL_DEPTHS_MAP_ID, LocalMapUtils.SHIMMERING_EXPANSE_MAP_ID},
    [LocalMapUtils.ZANDALAR_MAP_ID] = {LocalMapUtils.NAZJATAR_MAP_ID},
}

local function HideOptionalAchievement(achievementID)
    return not ns.settings.showContinentOptionalZoneStories and LoreUtil:IsOptionalAchievement(achievementID)
end

local function SetContinentNodes(parentMapInfo)
    local mapChildren = C_Map.GetMapChildrenInfo(parentMapInfo.mapID, Enum.UIMapType.Zone)
    if (parentMapInfo.mapType == Enum.UIMapType.World or parentMapInfo.mapType == Enum.UIMapType.Cosmic) then
        mapChildren = C_Map.GetMapChildrenInfo(parentMapInfo.mapID, Enum.UIMapType.Continent)
    end
    if additionalMapInfos[parentMapInfo.mapID] then
        for i, mapID in ipairs(additionalMapInfos[parentMapInfo.mapID]) do
            tInsert(mapChildren, LocalMapUtils:GetMapInfo( mapID ))
        end
    end

    if not nodes[parentMapInfo.mapID] then
        nodes[parentMapInfo.mapID] = {}

        for i, mapChildInfo in ipairs(mapChildren) do
            local storyAchievementID, storyAchievementID2, storyMapInfo = ZoneStoryUtils:GetZoneStoryInfo(mapChildInfo.mapID)
            if (storyAchievementID and not HideOptionalAchievement(storyAchievementID)) then
                local minX, maxX, minY, maxY = C_Map.GetMapRectOnMap(mapChildInfo.mapID, parentMapInfo.mapID)
                if (minX == 0) then return end
                local centerX = (maxX - minX) / 2 + minX
                local centerY = (maxY - minY) / 2 + minY

                -- Some nodes are overlapping with something else on the map. Use manual offset for those nodes.
                if (zoneOffsetInfo[mapChildInfo.mapID] ~= nil) then
                    local offSet = zoneOffsetInfo[mapChildInfo.mapID]
                    centerX = centerX + offSet.x
                    centerY = centerY + offSet.y
                end
                if (parentMapInfo.mapType == Enum.UIMapType.Cosmic and mapChildInfo.mapID == LocalMapUtils.AZEROTH_MAP_ID) then
                    node2Offset = 0.093
                else
                    node2Offset = 0.008
                end

                -- Get achievement details
                -- Note: only add a pin if the zone has a story achievement.
                -- Also note: Shadowlands + Dragonflight have 2 story achievements per zone (!)
                local achievementInfo = ZoneStoryUtils:GetAchievementInfo(storyAchievementID)
                if achievementInfo then
                    -- Adjust horizontal position if a 2nd achievement is available.
                    centerX = storyAchievementID2 and centerX - node2Offset or centerX
                    AddAchievementNode(parentMapInfo.mapID, centerX, centerY, achievementInfo, storyMapInfo)
                end
                if (storyAchievementID2 and not HideOptionalAchievement(storyAchievementID2)) then
                    local achievementInfo2 = ZoneStoryUtils:GetAchievementInfo(storyAchievementID2)
                    if achievementInfo2 then
                        centerX = centerX + (node2Offset * 2)
                        AddAchievementNode(parentMapInfo.mapID, centerX, centerY, achievementInfo2, storyMapInfo)
                    end
                end
            end
            -- else
            --     -- print(GRAY("> No storyAchievementID:"), parentMapInfo.mapID, mapChildInfo.mapID, storyAchievementID)
            --     if not ns.testDB[parentMapInfo.mapID] then
            --         ns.testDB[parentMapInfo.mapID] = {}
            --     end
            --     if not tContains(ns.testDB[parentMapInfo.mapID], mapChildInfo.mapID) then
            --         tInsert(ns.testDB[parentMapInfo.mapID], mapChildInfo.mapID)
            --     end
            -- end
        end
    -- else
        -- print("Skipping:", parentMapInfo.mapID, parentMapInfo.name)
    end
end

-- An iterator function that will loop over and return 5 values
-- (coord, uiMapID, iconpath, scale, alpha) for every node in the requested
-- zone. If the uiMapID return value is nil, we (HandyNotes devs) assume it is
-- the same uiMapID as the argument passed in. Mainly used for continent
-- uiMapID where the map passed in is a continent, and the return values are
-- coords of subzone maps.
--
local function NodeIterator(t, prev)
    if not t then return end

    local coord, zoneData = next(t, prev)
    while coord do
        if (zoneData and ns.settings.showContinentZoneIcons) then
            if not (ns.settings.hideCompletedContinentZoneIcons and zoneData.achievementInfo.completed) then
                -- Needed return values: coord, uiMapID, iconPath, iconScale, iconAlpha
                return coord, ns.activeContinentMapInfo.mapID, zoneData.icon, zoneData.scale, zoneData.alpha
            end
        end
        coord, zoneData = next(t, coord)
    end
end

function LocalUtils:GetBestMapInfoForPlayer()
    local mapID = LocalMapUtils:GetBestMapForPlayer()
    return LocalMapUtils:GetMapInfo(mapID)
end

function LocalUtils:GetActiveMapInfo()
    return ns.activeZoneMapInfo or LocalUtils:GetBestMapInfoForPlayer()
end

-- Required standard function for HandyNotes to get a location node.
---@param uiMapID number  The zone we want data for
---@param minimap boolean  Boolean argument indicating that we want to get nodes to display for the minimap
---@return function iter  An iterator function that will loop over and return 5 values (coord, uiMapID, iconpath, scale, alpha)
---@return any state  Arg 1 to pass into iter() on the initial iteration
---@return any value  Arg 2 to pass into iter() on the initial iteration
--
-- REF.: <World of Warcraft\_retail_\Interface\AddOns\HandyNotes\HandyNotes.lua><br>
-- REF.: <FrameXML/Blizzard_SharedMapDataProviders/QuestDataProvider.lua>
--
function LoremasterPlugin:GetNodes2(uiMapID, minimap)
    -- debug:print(GRAY("GetNodes2"), "> uiMapID:", uiMapID, "minimap:", minimap)
    if minimap then return NodeIterator end  -- minimap is currently not used

    if ( WorldMapFrame and WorldMapFrame:IsShown() ) then
        -- local isWorldMapShown = WorldMapFrame:IsShown()
        local mapID = uiMapID or WorldMapFrame:GetMapID()
        local mapInfo = LocalMapUtils:GetMapInfo(mapID)
        debug:print(GRAY("GetNodes2"), "> mapID:", uiMapID, mapID, "mapType:", mapInfo.mapType, "parent:", mapInfo.parentMapID)

        ns.activeZoneMapInfo = mapInfo

        -- Keep track of World Map size changes, ie. to adjust icon scale, etc.
        ns.isWorldMapMaximized = WorldMapFrame:IsMaximized()

        if (mapInfo.mapType == Enum.UIMapType.Zone) then
            debug:print(LocalQuestLineUtils, "Entering zone:", mapID, mapInfo.name)
            -- Update data cache for current zone
            local prepareCache = true
            ZoneStoryUtils:GetZoneStoryInfo(mapID, prepareCache)
            LocalQuestLineUtils:GetAvailableQuestLines(mapID, prepareCache)
        end
        if (mapInfo.mapType <= Enum.UIMapType.Continent or tContains({LocalMapUtils.VASHJIR_MAP_ID, LocalMapUtils.NAZJATAR_MAP_ID, LocalMapUtils.STRANGLETHORN_MAP_ID}, mapID) ) then
            ns.activeContinentMapInfo = mapInfo
            -- ns.testDB = DBUtil:GetInitDbCategory("TEST_Zones")
            SetContinentNodes(mapInfo)
            if TableHasAnyEntries(nodes) then
                return NodeIterator, nodes[mapInfo.mapID]
            end
        end

        return NodeIterator
    end

    return NodeIterator
end

----- Worldmap continent pin tooltip handler -----

local function IsContinentPin(continentMapInfo)
    local isOnContinentMap = continentMapInfo.mapType <= Enum.UIMapType.Continent
    local isException = additionalMapInfos[continentMapInfo.mapID] ~= nil
    return isOnContinentMap or isException
end

-- Function we will call when the mouse enters a HandyNote, you will generally produce a tooltip here.
function LoremasterPlugin:OnEnter(mapID, coord)
    local node = nodes[mapID] and nodes[mapID][coord]
    if node then
        -- Create tooltip
        self.tooltip = LibQTip:Acquire(AddonID.."LibQTooltipContinent", 1, "LEFT")

        if self:GetCenter() < self.owningMap.ScrollContainer:GetCenter() then
            self.tooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 10, 0)
        else
            self.tooltip:SetPoint("TOPRIGHT", self, "TOPLEFT")
        end

        -- Header: Plugin + zone name
        local title = node.achievementInfo.isOptionalAchievement and LoremasterPlugin.name..L.TEXT_DELIMITER..L.TEXT_OPTIONAL or LoremasterPlugin.name
        title = node.achievementInfo.isAccountWide and L.ZONE_NAME_ACCOUNT_ACHIEVEMENT_FORMAT:format(title) or title
        LibQTipUtil:SetTitle(self.tooltip, title)
        LibQTipUtil:AddNormalLine(self.tooltip, node.mapInfo.name)
        if debug.isActive then
            local mapIDstring = format("maps: %d-%d", mapID, node.mapInfo.mapID)
            LibQTipUtil:AddDisabledLine(self.tooltip, mapIDstring)
        -- else
        --     LibQTipUtil:AddBlankLineToTooltip(self.tooltip)
        end

         -- Zone Story details
        local continentMapInfo = LocalMapUtils:GetMapInfo(mapID)
         local fakePin = {
            mapID = mapID,
            achievementInfo = node.achievementInfo,  -- ZoneStoryUtils:GetAchievementInfo(node.achievementInfo.achievementID),
            pinTemplate = LocalUtils.HandyNotesPinTemplate,
            isOnContinent = IsContinentPin(continentMapInfo),
         }
         ZoneStoryUtils:AddZoneStoryDetailsToTooltip(self.tooltip, fakePin)

         -- Hint to open achievement frame
         if not LoreUtil:IsHiddenCharSpecificAchievement(node.achievementInfo.achievementID) then
            LibQTipUtil:AddBlankLineToTooltip(self.tooltip)
            LibQTipUtil:AddInstructionLine(self.tooltip, L.HINT_VIEW_ACHIEVEMENT)
        end

        --> TODO - Add more info to tooltip?

        self.tooltip:SetClampedToScreen(true)
        self.tooltip:Show()
    end
end

-- Function we will call when the mouse leaves a HandyNote, you will generally hide the tooltip here.
function LoremasterPlugin:OnLeave(mapID, coord)
    -- Release the tooltip
   LibQTip:Release(self.tooltip)
   self.tooltip = nil
end

-- Function we will call when the user clicks on a HandyNote, you will generally produce a menu here on right-click.
function LoremasterPlugin:OnClick(button, isDown, mapID, coord)
    -- Open the achievement frame at the current button's achievement.
    local node = nodes[mapID] and nodes[mapID][coord]
    if node then
        if (button == "LeftButton") then
            if IsShiftKeyDown() then
                local storyAchievementID = node.achievementInfo.achievementID
                -- REF.: <https://www.townlong-yak.com/framexml/live/UIParent.lua>
                HideUIPanel(WorldMapFrame)
                OpenAchievementFrameToAchievement(storyAchievementID)
            else
                -- Open subjacent zone map
                self.owningMap:SetMapID(node.mapInfo.mapID)
            end
        end
        -- if (button == "RightButton") then
        --     --> TODO - Add context menu
        -- end
    end
end

function LoremasterPlugin:Refresh()
    -- self:SendMessage('HandyNotes_NotifyUpdate', AddonID)  -- this updates World Map and Minimap
    HandyNotes:UpdateWorldMapPlugin(AddonID)
end

function LoremasterPlugin:RefreshAll()
    wipe(nodes)
    wipe(ZoneStoryUtils.achievements)
    self:Refresh()
end

----- Temporary solutions - Can be removed later

function Temp_ConvertActiveQuestlineQuests()
    local activeQuestlinesDB = DBUtil:GetInitDbCategory("activeQuestlines")
    debug:print("Processing active questlines...", activeQuestlinesDB and #activeQuestlinesDB)
    local count = 0
    for i, activeQuestLineInfo in ipairs(activeQuestlinesDB) do
        local campaignID = activeQuestLineInfo.isCampaign and C_CampaignInfo.GetCampaignID(activeQuestLineInfo.questID)
        local isQuestCompleted = LocalQuestUtils:IsQuestCompletedByAnyone(nil, activeQuestLineInfo.questID)
        local success = not isQuestCompleted and DBUtil:AddActiveLoreQuest(activeQuestLineInfo.questID, activeQuestLineInfo.questLineID, campaignID)
        if success then
            count = count + 1
        else
            debug:print("Skipped", activeQuestLineInfo.questID, activeQuestLineInfo.questLineID, campaignID, isQuestCompleted)
        end
    end
    debug:print(format("Converted %d |4entry:entries;", count))
end

