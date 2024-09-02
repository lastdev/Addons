--------------------------------------------------------------------------------
--[[ HandyNotes: Loremaster - Options ]]--
--
-- by erglo <erglo.coder+HNLM@gmail.com>
--
-- Copyright (C) 2024  Erwin D. Glockner (aka erglo)
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
-- Files used for reference:
-- REF.: <https://wowpedia.fandom.com/wiki/API_C_AddOns.GetAddOnMetadata>
-- (see also the function comments section for more reference)
--
--------------------------------------------------------------------------------
local AddonID, ns = ...

ns.currentLocale = GetLocale()

local GetAddOnMetadata = C_AddOns.GetAddOnMetadata
local format = string.format

local BRIGHTBLUE_FONT_COLOR = BRIGHTBLUE_FONT_COLOR
local GRAY_FONT_COLOR = GRAY_FONT_COLOR
local LIGHTGRAY_FONT_COLOR = LIGHTGRAY_FONT_COLOR
local NORMAL_FONT_COLOR = NORMAL_FONT_COLOR
local ORANGE_FONT_COLOR = ORANGE_FONT_COLOR

local NORMAL_FONT_COLOR_CODE = NORMAL_FONT_COLOR_CODE
local FONT_COLOR_CODE_CLOSE = FONT_COLOR_CODE_CLOSE

local ADVANCED_OPTIONS = ADVANCED_OPTIONS                                       --> TODO - Move to l10n
local ADVANCED_OPTIONS_TOOLTIP = ADVANCED_OPTIONS_TOOLTIP
local DEFAULT = DEFAULT
local EXAMPLE_TEXT = EXAMPLE_TEXT
local DESCRIPTION = DESCRIPTION
local QUEST_CLASSIFICATION_QUESTLINE = QUEST_CLASSIFICATION_QUESTLINE

local LocalOptionUtils = {}
LocalOptionUtils.newParagraph = "|n|n"
LocalOptionUtils.newLine = "|n"
LocalOptionUtils.colon = HEADER_COLON
LocalOptionUtils.textDelimiter = ITEM_NAME_DESCRIPTION_DELIMITER
LocalOptionUtils.parensStringFormat = PARENS_TEMPLATE
LocalOptionUtils.statusStringFormat = SLASH_TEXTTOSPEECH_HELP_FORMATSTRING
LocalOptionUtils.statusEnabledText = VIDEO_OPTIONS_ENABLED
LocalOptionUtils.statusDisabledText = VIDEO_OPTIONS_DISABLED
LocalOptionUtils.tocKeys = {"Author", "X-Email", "X-Website", "X-License"}
LocalOptionUtils.dashLineStringFormat = "|TInterface\\Scenarios\\ScenarioIcon-Dash:16:16:0:-1|t %s"
LocalOptionUtils.dashIconString = "|TInterface\\Scenarios\\ScenarioIcon-Dash:16:16:0:-1|t"
LocalOptionUtils.questTypeIconFormat = "|A:questlog-questtypeicon-%s:16:16:0:-1|a"
LocalOptionUtils.suffixTextDefault = LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(LocalOptionUtils.parensStringFormat:format(DEFAULT))

ns.pluginInfo = {}
ns.pluginInfo.title = GetAddOnMetadata(AddonID, "Title")
ns.pluginInfo.icon = GetAddOnMetadata(AddonID, "IconTexture") or GetAddOnMetadata(AddonID, "IconAtlas")
ns.pluginInfo.version = GetAddOnMetadata(AddonID, "Version")
ns.pluginInfo.description = GetAddOnMetadata(AddonID, "Notes-"..ns.currentLocale) or GetAddOnMetadata(AddonID, "Notes")
ns.pluginInfo.defaultOptions = {
	profile = {
        ["*"] = true,
        ["collapseType_zoneStory"] = "show",
        ["collapseType_questline"] = "show",
        ["collapseType_campaign"] = "show",
        ["collapseType_zoneStoryContinent"] = "auto",
        ["hideCompletedContinentZoneIcons"] = false,
        ["showCampaignChapterDescription"] = false,
        ["showQuestTypeAsText"] = false,
        ["scrollStep"] = 30,
        ["continentIconScale"] = 1.5,
        ["continentIconAlpha"] = 0.75,
        ["hideZoneStoryInCompletedZones"] = false,
        ["showTagQuestline"] = false,
	},
}
ns.pluginInfo.needWorldMapRefresh = {
    "showContinentZoneIcons",
    "hideCompletedContinentZoneIcons",
}
ns.pluginInfo.needWorldMapRefreshAll = {
    "scrollStep",
    "continentIconScale",
    "continentIconAlpha"
}
ns.pluginInfo.InitializeOptions = function(self, LoremasterPlugin)
    return {
        type = 'group',
        name = self.title:gsub("HandyNotes: ", ''),  --> "Loremaster"
        desc = self.description,
        childGroups = "tab",
        get = function(info) return ns.settings[info.arg] end,
        set = function(info, value)
            ns.settings[info.arg] = value
            if ( strsplit("_", info.arg) == "collapseType" ) then
                local collapseTypeValue = LocalOptionUtils.collapseTypeValues[value] or LocalOptionUtils.collapseTypeExtraValues[value]
                LocalOptionUtils:printOption(collapseTypeValue, true)
            elseif tContains(self.needWorldMapRefresh, info.arg) then
                LocalOptionUtils:printOption(info.option.name, value)
                LoremasterPlugin:Refresh()
            elseif tContains(self.needWorldMapRefreshAll, info.arg) then
                LoremasterPlugin:RefreshAll()
            else
                LocalOptionUtils:printOption(info.option.name, value)
            end
        end,
        args = {
            about = {
                type = "group",
                name = "About this plugin",                                     --> TODO - L10n
                order = 9,
                args = {
                    heading = {
                        type = "description",
                        name = LocalOptionUtils:CreateAboutHeadingText(),
                        fontSize = "medium",
                        order = 0,
                    },
                    description = {
                        type = "description",
                        name = LocalOptionUtils.newLine..self.description,
                        order = 1,
                    },
                    body = {
                        type = "description",
                        name = LocalOptionUtils:CreateAboutBodyText(),
                        order = 2,
                    },
                }
            },  --> about
            tooltip_details_zone = {
                type = "group",
                name = "Tooltip"..LocalOptionUtils.textDelimiter..LocalOptionUtils.parensStringFormat:format(ZONE),
                desc = "Select the tooltip details which should be shown when hovering a quest icon on the World Map.",
                order = 1,
                childGroups = "tab",
                args = {
                    description = {
                        type = "description",
                        name = "Select the tooltip details which should be shown when hovering a quest icon on the World Map."..LocalOptionUtils.newParagraph,
                        order = 0,
                    },
                    general_details = {
                        type = "group",
                        name = GENERAL_LABEL,
                        desc = "The settings in this group apply to all tooltips.",
                        order = 1,
                        args = {
                            description = {
                                type = "description",
                                name = "The settings in this section apply to all tooltips."..LocalOptionUtils.newParagraph,
                                order = 0,
                            },
                            plugin_name = {
                                type = "toggle",
                                name = "Show Plugin Name",
                                desc = "The plugin name indicates that everything below it is content created by this plugin. Deactivate to hide the name.",
                                arg = "showPluginName",
                                width = "full",
                                order = 1,
                            },                                                  --> TODO - Show quest ID, trivial quests ???
                            category_names = {
                                type = "toggle",
                                name = "Show Category Names",
                                desc = "Each content category is indicated by its name. Deactivate to hide those names.",
                                arg = "showCategoryNames",
                                width = "full",
                                order = 2,
                            },
                            quest_type = {
                                type = "toggle",
                                name = "Show Quest Type",
                                desc = "Show or hide the type name and icon of a quest. Blizzard shows you this detail only after accepting a quest."..LocalOptionUtils:AppendQuestTypeExampleText(CALENDAR_TYPE_RAID, "raid"),
                                arg = "showQuestType",
                                width = "full",
                                order = 3,
                            },
                            quest_turn_in = {
                                type = "toggle",
                                name = format("Show %s Message", LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(QUEST_WATCH_QUEST_READY)),
                                desc = "Show or hide this message. This option affects active quests only.",
                                arg = "showQuestTurnIn",
                                width = "full",
                                order = 4,
                            },
                            separator_pre_advanced = {
                                type = "description",
                                name = LocalOptionUtils.newLine,
                                order = 20,
                            },
                            header_advanced = {
                                type = "header",
                                name = ADVANCED_OPTIONS,
                                width = "half",
                                order = 21,
                            },
                            separator_post_advanced = {
                                type = "description",
                                name = LocalOptionUtils.newLine,
                                order = 22,
                            },
                            track_worldquests = {
                                type = "toggle",
                                name = "Track World Quests",
                                desc = "Show additional details for World Quests in a separate tooltip below the quest tooltip.",
                                arg = "trackWorldQuests",
                                width = 1.2,
                                order = 30,
                            },
                            track_threatquests = {
                                type = "toggle",
                                name = "Track Threat Objectives",
                                desc = "Show additional details for Threat Objectives in a separate tooltip below the quest tooltip.",
                                arg = "trackThreatObjectives",
                                width = 1.2,
                                order = 31,
                            },
                            track_bonusquests = {
                                type = "toggle",
                                name = "Track Bonus Objectives",
                                desc = "Show additional details for Bonus Objectives in a separate tooltip below the quest tooltip.",
                                arg = "trackBonusObjectives",
                                width = 1.2,
                                order = 32,
                            },
                            --> TODO - Track active quests / ready-for-turnin quests
                            --> TODO - Add reminder for tracking trivial quests in World Map filter.
                            quest_tag_alpha = {
                                type = "toggle",
                                name = "Quest Tag Transparency",
                                desc = "Display quest tag lines of lower level quests semi-transparent.",
                                arg = "showTagTransparency",
                                width = 1.2,
                                order = 35,
                            },
                            quest_tag_questline = {
                                type = "toggle",
                                name = "Show Storyline Tag",
                                desc = "Display a quest tag line for quests with a storyline.",
                                arg = "showTagQuestline",
                                width = 1.2,
                                order = 36,
                            },
                        },
                    },  --> general_details
                    zs_group = {
                        type = "group",
                        name = ZONE,
                        desc = "Show or hide story achievement details of the currently viewed zone.",
                        inline = false,
                        order = 10,
                        args = {
                            show_zone_story = {
                                type = "toggle",
                                name = "Show Zone Story",
                                desc = "Show or hide story details of the currently viewed zone.",
                                descStyle = "inline",
                                arg = "showZoneStory",
                                width = "full",
                                order = 1,
                            },
                            separate_tooltip_sz = {
                                type = "toggle",
                                name = "Use Separate Tooltip",
                                desc = "Displays this category's details in a separate tooltip.",
                                arg = "showZoneStorySeparately",
                                disabled = function() return not ns.settings["showZoneStory"] end,
                                width = 1.2,
                                order = 2,
                            },
                            collapse_type_sz = {
                                type = "select",
                                name = "Select Display Type...",
                                desc = LocalOptionUtils.CreateCollapseTypeDescriptionText,
                                values = LocalOptionUtils.SetCollapseTypeValues,
                                arg = "collapseType_zoneStory",
                                disabled = function() return not ns.settings["showZoneStory"] end,
                                width = 1.2,
                                order = 3,
                            },
                            show_chapter_quests_sz = {
                                type = "toggle",
                                name = "Include Chapter Quests",
                                desc = "Some chapters are directly linked to a quest. If activated, each linked quest name will be shown below the chapter name."..LocalOptionUtils:AppendExampleText("QuestName", "SmallQuestBang"),
                                arg = "showStoryChapterQuests",
                                disabled = function() return (ns.settings["collapseType_zoneStory"] == "singleLine") or not ns.settings["showZoneStory"] end,
                                width = "double",
                                order = 4,
                            },
                            optional_stories_sz = {
                                type = "toggle",
                                name = "Include Optional Zone Stories",
                                desc = "Some zones have a story achievement of their own or an additional one which is not part of a Loremaster achievement.",
                                arg = "showOptionalZoneStories",
                                disabled = function() return not ns.settings["showZoneStory"] end,
                                width = "double",
                                order = 5,
                            },
                            only_in_incomplete_zones = {
                                type = "toggle",
                                name = "Hide in Completed Zones",
                                desc = "Show zone story details only in zones with an incomplete achievement.",
                                arg = "hideZoneStoryInCompletedZones",
                                disabled = function() return not ns.settings["showZoneStory"] end,
                                width = "double",
                                order = 6,
                            },
                        },
                    },  --> zs_group
                    ql_group = {
                        type = "group",
                        name = QUEST_CLASSIFICATION_QUESTLINE,
                        desc = "Show or hide storyline details associated with the hovered quest.",
                        inline = false,
                        order = 20,
                        args = {
                            show_questline = {
                                type = "toggle",
                                name = "Show Storyline",
                                desc = "Show or hide storyline details associated with the hovered quest.",
                                descStyle = "inline",
                                arg = "showQuestLine",
                                width = "full",
                                order = 1,
                            },
                            quest_type_names = {
                                type = "toggle",
                                name = "Quest Type Icons as Text",
                                desc = "Displays the quest type in quest names as text instead of using icons."..LocalOptionUtils:AppendQuestTypeExampleText("Quest Name", WEEKLY, true, true)..LocalOptionUtils.newLine..PET_BATTLE_UI_VS..LocalOptionUtils:AppendQuestTypeExampleText("Quest Name", "WEEKLY", true, false, true),
                                arg = "showQuestTypeAsText",
                                disabled = function() return not ns.settings["showQuestLine"] end,
                                width = 1.2,
                                order = 2,
                            },
                            collapse_type_ql = {
                                type = "select",
                                name = "Select Display Type...",
                                desc = LocalOptionUtils.CreateCollapseTypeDescriptionText,
                                values = LocalOptionUtils.SetCollapseTypeValues,
                                arg = "collapseType_questline",
                                disabled = function() return not ns.settings["showQuestLine"] end,
                                width = 1.2,
                                order = 3,
                            },
                            highlight_story_quests = {
                                type = "toggle",
                                name = "Highlight Story Quests",
                                desc = "Lore-related quests will be highlighted in a different text color, if activated."..LocalOptionUtils:AppendExampleText("QuestName", nil, nil, nil, ORANGE_FONT_COLOR),
                                arg = "highlightStoryQuests",
                                disabled = function() return not ns.settings["showQuestLine"] end,
                                width = "double",
                                order = 5,
                            },
                            save_recurring_quests = {
                                type = "toggle",
                                name = "Remember Recurring Quests",
                                desc = "By default Blizzard resets recurring quests eg. daily or weekly.|nActivate to display recurring quests as completed, once you've turned them in.",
                                arg = "saveRecurringQuests",
                                disabled = function() return not ns.settings["showQuestLine"] end,
                                width = "double",
                                order = 6,
                            },
                            separator_pre_advanced_ql = {
                                type = "description",
                                name = LocalOptionUtils.newLine,
                                order = 20,
                            },
                            header_advanced_ql = {
                                type = "header",
                                name = ADVANCED_OPTIONS,
                                desc = ADVANCED_OPTIONS_TOOLTIP,
                                width = "half",
                                order = 21,
                            },
                            separator_post_advanced_ql = {
                                type = "description",
                                name = LocalOptionUtils.newLine,
                                order = 22,
                            },
                            tooltip_slider_speed_ql = {
                                type = "range",
                                name = "Tooltip Scroll Speed",
                                desc = "Set the step size (speed) for this tooltip's scrollbar."..LocalOptionUtils:AppendDefaultValueText("scrollStep"),
                                min = 10,
                                max = 150,
                                step = 10,
                                arg = "scrollStep",
                                disabled = function() return not ns.settings["showQuestLine"] end,
                                order = 30,
                            },
                        },
                    },  --> ql_group
                    cp_group = {
                        type = "group",
                        name = TRACKER_HEADER_CAMPAIGN_QUESTS,
                        desc = "Show or hide story campaign details associated with the hovered quest.",
                        inline = false,
                        order = 30,
                        args = {
                            campaign = {
                                type = "toggle",
                                name = "Show Campaign",
                                desc = "Show or hide story campaign details associated with the hovered quest.",
                                descStyle = "inline",
                                arg = "showCampaign",
                                width = "full",
                                order = 1,
                            },
                            separate_tooltip_cp = {
                                type = "toggle",
                                name = "Use Separate Tooltip",
                                desc = "Shows the campaign details in a separate tooltip.",
                                arg = "showCampaignSeparately",
                                disabled = function() return not ns.settings["showCampaign"] end,
                                width = 1.2,
                                order = 2,
                            },
                            collapse_type_cp = {
                                type = "select",
                                name = "Select Display Type...",
                                desc = LocalOptionUtils.CreateCollapseTypeDescriptionText,
                                values = LocalOptionUtils.SetCollapseTypeValues,
                                arg = "collapseType_campaign",
                                disabled = function() return not ns.settings["showCampaign"] end,
                                width = 1.2,
                                order = 3,
                            },
                            chapter_description = {
                                type = "toggle",
                                name = "Include Chapter Description",
                                desc = "Some chapters have a description or an alternative chapter name.|nIf activated, these will be shown below the default chapter name."..LocalOptionUtils:AppendExampleText(DESCRIPTION, 132053),
                                arg = "showCampaignChapterDescription",
                                disabled = function() return not ns.settings["showCampaign"] end,
                                width = "double",
                                order = 4,
                            },
                            campaign_description = {
                                type = "toggle",
                                name = "Show Campaign Description",
                                desc = "Some campaigns have a description.|nIf activated, it will be shown below the chapter list."..LocalOptionUtils:AppendExampleText(DESCRIPTION),
                                arg = "showCampaignDescription",
                                disabled = function() return not ns.settings["showCampaign"] end,
                                width = "double",
                                order = 5,
                            },
                        },
                    },  --> cp_group
                }
            },  --> tooltip_details_zone
            continent_settings = {
                type = "group",
                name = CONTINENT,
                desc = "Select the details for the continent view on the World Map.",
                childGroups = "tab",
                order = 2,
                args = {
                    description = {
                        type = "description",
                        name = "Select the details for the continent view on the World Map."..LocalOptionUtils.newParagraph,
                        order = 0,
                    },
                    show_zone_icons = {
                        type = "toggle",
                        name = "Show Zone Icon",
                        desc = "Shows the icons on a continent for zones with at least one achievement.",
                        arg = "showContinentZoneIcons",
                        width ="double",
                        order = 1,
                    },
                    completed_zone_icons = {
                        type = "toggle",
                        name = "Hide Completed Zone Icon",
                        desc = "Hide the icons on a continent from zones with a completed achievement.",
                        arg = "hideCompletedContinentZoneIcons",
                        disabled = function() return not ns.settings["showContinentZoneIcons"] end,
                        width ="double",
                        order = 2,
                    },
                    optional_stories_szc = {
                        type = "toggle",
                        name = "Include Optional Zone Stories",
                        desc = "Some zones have a story achievement of their own or an additional one which is not part of a Loremaster achievement."..LocalOptionUtils.newParagraph.."These optional achievements will be displayed as yellow icons.",
                        set = function(info, value)
                            ns.settings[info.arg] = value
                            LocalOptionUtils:printOption(info.option.name, value)
                            LoremasterPlugin:RefreshAll()
                        end,
                        arg = "showContinentOptionalZoneStories",
                        disabled = function() return not ns.settings["showContinentZoneIcons"] end,
                        width = "double",
                        order = 3,
                    },
                    wasEarnedBy_text = {
                        type = "toggle",
                        name = "Show Who Earned Achievement",
                        desc = "Shows you additional information about who earned an achievement."..LocalOptionUtils:AppendExampleText(ACHIEVEMENT_COMPLETED_BY:format(UnitName("player")), nil, nil, nil, BRIGHTBLUE_FONT_COLOR),
                        arg = "showEarnedByText",
                        disabled = function() return not ns.settings["showContinentZoneIcons"] end,
                        width ="double",
                        order = 4,
                    },
                    -- char_specific_icons = {
                    --     type = "toggle",
                    --     name = "Character-Specific Progress",
                    --     desc = "By default Blizzard shows you the Loremaster achievements of all your characters. If activated, only the progress of your currently used char will be shown.",
                    --     set = function(info, value)
                    --         ns.settings[info.arg] = value
                    --         LocalOptionUtils:printOption(info.option.name, value)
                    --         LoremasterPlugin:RefreshAll()
                    --     end,
                    --     arg = "showCharSpecificProgress",
                    --     disabled = function() return not ns.settings["showContinentZoneIcons"] end,
                    --     width ="double",
                    --     order = 4,
                    -- },
                    continent_tooltip_group = {
                        type = "group",
                        name = "Tooltip",
                        desc = "Select the tooltip details which should be shown when hovering an icon in continent view on the World Map.",
                        inline = false,
                        disabled = function() return not ns.settings["showContinentZoneIcons"] end,
                        order = 10,
                        args = {
                            description = {
                                type = "description",
                                name = "Select the tooltip details which should be shown when hovering an icon in continent view on the World Map."..LocalOptionUtils.newParagraph,
                                order = 0,
                            },
                            collapse_type_szc = {
                                type = "select",
                                name = "Select Display Type...",
                                desc = LocalOptionUtils.CreateCollapseTypeDescriptionText,
                                values = LocalOptionUtils.SetCollapseTypeValues,
                                arg = "collapseType_zoneStoryContinent",
                                width = 1.2,
                                order = 1,
                            },
                            chapter_quests_szc = {
                                type = "toggle",
                                name = "Include Chapter Quests",
                                desc = "Some chapters are directly linked to a quest. If activated, each linked quest name will be shown below the chapter name."..LocalOptionUtils:AppendExampleText("QuestName", "SmallQuestBang"),
                                arg = "showContinentStoryChapterQuests",
                                disabled = function() return ns.settings["collapseType_zoneStoryContinent"] == "singleLine" end,
                                width = "full",
                                order = 2,
                            },
                        },
                    },  --> continent_tooltip_group
                    continent_advanced_group = {
                        type = "group",
                        name = ADVANCED_OPTIONS,
                        desc = ADVANCED_OPTIONS_TOOLTIP,
                        inline = false,
                        disabled = function() return not ns.settings["showContinentZoneIcons"] end,
                        order = 20,
                        args = {
                            description = {
                                type = "description",
                                name = ADVANCED_OPTIONS_TOOLTIP..LocalOptionUtils.newParagraph,
                                order = 0,
                            },
                            icon_scale_szc = {
                                type = "range",
                                name = "World Map Icon Scale",
                                desc = "Set the size of the continent icons on the World Map."..LocalOptionUtils:AppendDefaultValueText("continentIconScale"),
                                min = 0.3,
                                max = 3,
                                step = 0.1,
                                arg = "continentIconScale",
                                width = 1.2,
                                order = 23,
                            },
                            icon_alpha_szc = {
                                type = "range",
                                name = "World Map Icon Alpha",
                                desc = "Set the transparency of the continent icons on the World Map."..LocalOptionUtils:AppendDefaultValueText("continentIconAlpha"),
                                min = 0,
                                max = 1,
                                step = 0.01,
                                isPercent = true,
                                arg = "continentIconAlpha",
                                width = 1.2,
                                order = 24,
                            },
                        },
                    },  --> continent_advanced_group
                },
            },  --> continent_settings
            notification_settings = {
                type = "group",
                name = "Notifications",
                desc = "Choose how or whether you want to be notified of lore relevant content.",
                order = 3,
                args = {
                    description = {
                        type = "description",
                        name = "Choose how or whether you want to be notified of plugin changes."..LocalOptionUtils.newParagraph,
                        order = 0,
                    },
                    chat_notifications_group = {
                        type = "group",
                        name = CHAT_LABEL,
                        inline = true,
                        order = 10,
                        args = {
                            welcome_msg = {
                                type = "toggle",
                                name = "Show Plugin-is-Ready Message",
                                desc = format("Show or hide the \"%s\" message on startup.", LFG_READY_CHECK_PLAYER_IS_READY:format(self.title)),
                                arg = "showWelcomeMessage",
                                width ="double",
                                order = 1,
                            },
                            criteria_earned_msg = {
                                type = "toggle",
                                name = "Show Achievement Progress Message",
                                desc = "Notifies you in chat when you earned a lore relevant achievement or criteria.",
                                arg = "showCriteriaEarnedMessage",
                                width ="double",
                                order = 2,
                            },
                            quest_is_questline_msg = {
                                type = "toggle",
                                name = "Show Storyline Progress Message",
                                desc = "Notifies you in chat when you accepted or completed a storyline quest.",
                                arg = "showQuestlineQuestProgressMessage",
                                width ="double",
                                order = 3,
                            },
                            quest_is_campaign_msg = {
                                type = "toggle",
                                name = "Show Campaign Progress Message",
                                desc = "Notifies you in chat when you accepted or completed a quest which is part of a campaign.",
                                arg = "showCampaignQuestProgressMessage",
                                width ="double",
                                order = 4,
                            },
                        },
                    },  --> chat_notifications
                },
            },  --> notification_settings
        } --> root parent group
    }
end

----- Utility functions ----------

LocalOptionUtils.printOption = function(self, text, isEnabled)
    -- Print a user-friendly chat message about the currently selected setting.
    local msg = isEnabled and self.statusEnabledText or self.statusDisabledText
    ns:cprintf(self.statusStringFormat, text or '', NORMAL_FONT_COLOR:WrapTextInColorCode(msg))
end

LocalOptionUtils.CreateAboutHeadingText = function(self)
    local versionString = GRAY_FONT_COLOR:WrapTextInColorCode(ns.pluginInfo.version)
    local pluginName = NORMAL_FONT_COLOR:WrapTextInColorCode(ns.pluginInfo.title)
    return self.newLine..pluginName..self.textDelimiter..versionString
end

LocalOptionUtils.CreateAboutBodyText = function(self)
    local text = self.newParagraph
    for i, key in ipairs(self.tocKeys) do
        local keyString = string.gsub(key, "X[-]", '')
        text = text..NORMAL_FONT_COLOR_CODE..keyString..FONT_COLOR_CODE_CLOSE
        text = text..self.colon..self.textDelimiter..GetAddOnMetadata(AddonID, key)
        text = text..self.newParagraph
    end
    return text..self.newParagraph
end

LocalOptionUtils.AppendQuestTypeExampleText = function(self, text, tagName, prepend, asText, skipHeader)
    local exampleText = skipHeader and self.newLine or self.newParagraph..EXAMPLE_TEXT..self.newLine
    local tagString = asText and BRIGHTBLUE_FONT_COLOR:WrapTextInColorCode(self.parensStringFormat:format(tagName)) or self.questTypeIconFormat:format(tagName)
    if (tagName == "raid") then
        return exampleText..tagString..self.textDelimiter..NORMAL_FONT_COLOR:WrapTextInColorCode(text)
    end
    if prepend then
        return exampleText..format(self.dashLineStringFormat, tagString)..self.textDelimiter..NORMAL_FONT_COLOR:WrapTextInColorCode(text)
    end
    return exampleText..format(self.dashLineStringFormat, NORMAL_FONT_COLOR:WrapTextInColorCode(text))..self.textDelimiter..tagString
end

LocalOptionUtils.AppendExampleText = function(self, text, icon, iconWidth, iconHeight, textColor)
    local exampleText = self.newParagraph..EXAMPLE_TEXT..self.newLine
    local TextColor = textColor or GRAY_FONT_COLOR
    if not icon then
        return exampleText..self.dashIconString..self.textDelimiter..TextColor:WrapTextInColorCode(text)
    end
    local CreateMarkupFunction = type(icon) == "number" and CreateSimpleTextureMarkup or CreateAtlasMarkup
    local width = iconWidth or 16
    local height = iconHeight or 16
    return exampleText..CreateMarkupFunction(icon, width, height)..self.textDelimiter..TextColor:WrapTextInColorCode(text)
end

LocalOptionUtils.AppendDefaultValueText = function(self, arg)
    local textTemplate = LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(self.newParagraph..DEFAULT..self.colon)..self.textDelimiter.."%s"
    local valueString = tostring( ns.pluginInfo.defaultOptions.profile[arg] )
    return textTemplate:format(valueString)
end

LocalOptionUtils.collapseTypeValues = {
    auto = "Auto-Collapse",
    hide = "Collapsed",
    show = "Opened",
}

LocalOptionUtils.collapseTypeExtraValues = {
    singleLine = "Single Line",  -- only for zone story achievements
}

LocalOptionUtils.SetCollapseTypeValues = function(info)
    local self = LocalOptionUtils
    local valueList = CopyTable(self.collapseTypeValues, true)
    if tContains({"collapseType_zoneStory", "collapseType_zoneStoryContinent"}, info.arg) then
        MergeTable(valueList, self.collapseTypeExtraValues)
    end
    local defaultKey = ns.pluginInfo.defaultOptions.profile[info.arg]
    local defaultLabel = valueList[defaultKey]
    -- Update/replaces default label
    valueList[defaultKey] = defaultLabel..self.textDelimiter..self.suffixTextDefault

    return valueList
end

LocalOptionUtils.CreateCollapseTypeDescriptionText = function(info)
    local self = LocalOptionUtils
    local desc = "Choose how the details in this category should be displayed."
    desc = desc..self.newParagraph
    desc = desc..NORMAL_FONT_COLOR:WrapTextInColorCode(self.collapseTypeValues.auto..self.colon)
    desc = desc..self.textDelimiter.."Automatically collapse this category's details when completed."
    desc = desc..self.newParagraph
    desc = desc..NORMAL_FONT_COLOR:WrapTextInColorCode(self.collapseTypeValues.hide..self.colon)
    desc = desc..self.textDelimiter.."Always show category details collapsed."
    desc = desc..self.newParagraph
    desc = desc..NORMAL_FONT_COLOR:WrapTextInColorCode(self.collapseTypeValues.show..self.colon)
    desc = desc..self.textDelimiter.."Always show full category details."
    if tContains({"collapseType_zoneStory", "collapseType_zoneStoryContinent"}, info.arg) then
        desc = desc..self.newParagraph
        desc = desc..NORMAL_FONT_COLOR:WrapTextInColorCode(self.collapseTypeExtraValues.singleLine..self.colon)
        desc = desc..self.textDelimiter.."Displays each story achievement in a single line instead of multiple lines."
    end
    -- Append default value text
    local defaultKey = ns.pluginInfo.defaultOptions.profile[info.arg]
    local defaultLabel = self.collapseTypeValues[defaultKey] or self.collapseTypeExtraValues[defaultKey]
    local textTemplate = LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(self.newParagraph..DEFAULT..self.colon)..self.textDelimiter.."%s"
    desc = desc..textTemplate:format(defaultLabel)

    return desc
end

