if GetLocale() ~= "zhCN" then return end -- Simplified Chinese

local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Lockit
local Lockit = DelveCompanion.Lockit
-- ====================== NO ADDON DATA BELOW, ONLY LOCKIT ===================================================

-- Common

Lockit.UI_COMMON_BOUNTIFUL_DELVE_TITLE = "丰裕地下堡"
Lockit.UI_COMMON_MISSING_ADDON_TITLE = "缺少必需的插件：%s" -- `%s`: name of the missing AddOn, e.g. DelveCompanion

-- Delves List

Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLICK_INSTRUCTION = "<Shift + 左键：设置地下堡的路径点>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CURRENT_TEXT = "路径点设置"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_INSTRUCTION = "<Shift + 左键：清空路径点>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_MPE = "Please use MapPinEnhanced Tracker to remove the waypoint."

-- Delves UI

Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA = "在卡兹阿加地区时可获取鎏金藏匿物进度"
Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE = "仅出现在 |cnNORMAL_FONT_COLOR:难度 11|r 丰裕地下堡|A:delves-bountiful:16:16|a。"
Lockit.UI_NO_ACTIVE_BOUNTIFUL = "今日所有丰裕地下堡已完成"
Lockit.UI_LOOT_INFO_BUTTON_TOOLTIP_INSTRUCTION = "<左键：显示地下堡战利品信息>"

-- Loot Info

Lockit.UI_LOOT_INFO_DESCRIPTION = "完成地下堡获取战利品："

-- Keys Info

Lockit.UI_BOUNTIFUL_KEYS_COUNT_CACHES_PREFIX = "宝箱里获取的钥匙数量"

-- Compartment (these are shown hovering over the addon in the corresponding dropdown menu)

Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK = "|cnGREEN_FONT_COLOR:左键|r 显示插件信息界面。"
Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK = "|cnGREEN_FONT_COLOR:右键|r 显示插件设置界面。"

-- Settings

Lockit.UI_SETTINGS_SECTION_TITLE_ACCOUNT = "账号设置"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME = "地下堡进度信息"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_TOOLTIP = "冒险指南-地下堡：显示各个地下堡的成就进度（故事和探索）。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_NAME = "路径点跟踪风格"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_START = "选择导航使用的路径点类型。\n\n可用选项："
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_BLIZZARD = "- 暴雪导航点（游戏内置）。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM = "- TomTom 路径点。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_MPE = "- MapPinEnhanced Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT = "%s (%s)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_NAME = "Blizzard"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_DESCRIPTION = "暴雪导航点。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_NAME = "TomTom"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_DESCRIPTION = "TomTom 路径点。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_NAME = "MapPinEnhanced"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_DESCRIPTION = "Use MapPinEnhanced Waypoints."

Lockit.UI_SETTINGS_SECTION_TITLE_CHARACTER = "角色设置"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_NAME = "额外提示信息"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_TOOLTIP = "在鼠标提示中显示额外信息（例如，本周宝箱里获取的 |cnITEM_EPIC_COLOR:修复的宝匣钥匙|r 数量）。"
Lockit.UI_SETTING_COMPANION_CONFIG_NAME = "地下堡伙伴配置控件"
Lockit.UI_SETTING_COMPANION_CONFIG_TOOLTIP = "启用显示地下堡伙伴当前专精和珍玩的控件。\n可直接在地下堡面板修改地下堡伙伴的专精和珍玩。\n注意：布局类型不影响功能实现，仅涉及视觉排布方式。"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_NAME = "水平布局"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_DESCRIPTION = "采用水平排列按钮的精简布局。地下堡伙伴模型可见。"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_NAME = "垂直布局"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_DESCRIPTION = "采用垂直排列按钮的详细布局。地下堡伙伴模型隐藏。"
Lockit.UI_SETTING_GV_DETAILS_NAME = "宏伟宝库版块"
Lockit.UI_SETTING_GV_DETAILS_TOOLTIP = "直接在地下堡面板显示宏伟宝库（地下堡部分）的奖励和进度。"
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_NAME = "地下堡概要版块"
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_TOOLTIP = "显示地下堡附加的概要信息，它包含鎏金藏匿物、丰裕地下堡和地下堡相关消耗品的内容。"

Lockit.UI_SETTINGS_TRANSLATION_TITLE = "特别鸣谢翻译贡献者："

Lockit.UI_SETTINGS_LINKS_TITLE = "链接"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_CURSEFORGE = "点击复制 |cnNORMAL_FONT_COLOR:CurseForge|r 插件页面网址。"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WAGO = "点击复制 |cnNORMAL_FONT_COLOR:Wago.io|r 插件页面网址。"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WOWINT = "点击复制 |cnNORMAL_FONT_COLOR:WoW Interface|r 插件页面网址。"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_GITHUB = "点击复制 |cnNORMAL_FONT_COLOR:GitHub|r 插件页面网址。\n\n提交反馈 | 申请新功能 | 报告漏洞（您的建议将驱动插件进化）"
Lockit.UI_SETTINGS_ADDON_LINK_POPUP_TEXT = "|cnGREEN_FONT_COLOR:Ctrl + C|r 复制 |cnNORMAL_FONT_COLOR:%s|r 网址。" -- `%s`: website name, e.g. CurseForge.
