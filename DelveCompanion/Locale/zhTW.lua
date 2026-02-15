if GetLocale() ~= "zhTW" then return end  -- Traditional Chinese

local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Lockit
local Lockit = DelveCompanion.Lockit
-- ====================== NO ADDON DATA BELOW, ONLY LOCKIT ===================================================

-- Common

Lockit.UI_COMMON_BOUNTIFUL_DELVE_TITLE = "豐碩探究"
Lockit.UI_COMMON_MISSING_ADDON_TITLE = "缺少必需的插件：%s" -- `%s`: name of the missing AddOn, e.g. DelveCompanion

-- Delves List

Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLICK_INSTRUCTION = "<Shift + 左鍵：設置地下堡的路徑點>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CURRENT_TEXT = "路徑點設置"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_INSTRUCTION = "<Shift + 左鍵：清空路徑點>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_MPE = "Please use MapPinEnhanced Tracker to remove the waypoint."

-- Delves UI

Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA = "在卡茲阿爾加地區時可獲取鍍金儲物箱進度"
Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE = "僅出現在 |cnNORMAL_FONT_COLOR:難度 11|r 豐碩探究|A:delves-bountiful:16:16|a。"
Lockit.UI_NO_ACTIVE_BOUNTIFUL = "任意難度11豐碩探究可啟動進度"
Lockit.UI_LOOT_INFO_BUTTON_TOOLTIP_INSTRUCTION = "<點擊來顯示探究的拾取資訊>"

-- Loot Info

Lockit.UI_LOOT_INFO_DESCRIPTION = "完成探究可獲得戰利品："

-- Keys Info

Lockit.UI_BOUNTIFUL_KEYS_COUNT_CACHES_PREFIX = "寶箱裡獲取的鑰匙數量"

-- Compartment (these are shown hovering over the addon in the corresponding dropdown menu)

Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK = "左鍵點擊開啟訊息視窗。"
Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK = "右鍵點擊變更選項。"

-- Settings

Lockit.UI_SETTINGS_SECTION_TITLE_ACCOUNT = "帳號設置"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME = "探究的進度資訊"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_TOOLTIP = "冒險指南-探究：顯示探究成就進度（劇情和探索）。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_NAME = "路徑點追蹤類型"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_START = "選擇哪種類型的路徑點用於導航。\n\n可能的選項:"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_BLIZZARD = "- Blizzard的地圖標記 (遊戲內建的導航)"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM = "- TomTom路徑點"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_MPE = "- MapPinEnhanced Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT = "%s (%s)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_NAME = "Blizzard"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_DESCRIPTION = "使用Blizzard的地圖標記。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_NAME = "TomTom"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_DESCRIPTION = "使用TomTom路徑點。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_NAME = "MapPinEnhanced"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_DESCRIPTION = "Use MapPinEnhanced Waypoints."

Lockit.UI_SETTINGS_SECTION_TITLE_CHARACTER = "角色設置"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_NAME = "提示的額外資訊"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_TOOLTIP = "在提示中顯示額外資訊 (例如 本週收到的 |cnITEM_EPIC_COLOR:復原的寶庫鑰匙|r 的數量)。"
Lockit.UI_SETTING_COMPANION_CONFIG_NAME = "夥伴設置組件"
Lockit.UI_SETTING_COMPANION_CONFIG_TOOLTIP = "探究介面: 啟用一個組件來顯示當前夥伴的專精與技能。\n它可用於直接從探究介面修改配置。"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_NAME = "水平佈局"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_DESCRIPTION = "一個緊湊的佈局，其按鈕水平排列。夥伴模型保持完整。"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_NAME = "垂直佈局"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_DESCRIPTION = "一個詳細的佈局，垂直排列的按鈕。夥伴模型為隱藏。"
Lockit.UI_SETTING_GV_DETAILS_NAME = "自訂寶庫"
Lockit.UI_SETTING_GV_DETAILS_TOOLTIP = "探究介面: 直接在探究介面顯示寶庫獎勵與進度 (與探究相關的)。 "
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_NAME = "探究總覽部分"
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_TOOLTIP = "探究介面: 顯示一個額外的總覽部分。它包含有關鍍金儲物箱，可用的豐碩探究及與探究相關的貨幣和物品的訊息。"

Lockit.UI_SETTINGS_TRANSLATION_TITLE = "特別鳴謝翻譯者："

Lockit.UI_SETTINGS_LINKS_TITLE = "Links"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_CURSEFORGE = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:CurseForge|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WAGO = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:Wago.io|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WOWINT = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:WoW Interface|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_GITHUB = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:GitHub|r.\n\nShare feedback, request new features, or report a bug. It helps making the addon even better!"
Lockit.UI_SETTINGS_ADDON_LINK_POPUP_TEXT = "|cnGREEN_FONT_COLOR:Ctrl + C|r to copy the |cnNORMAL_FONT_COLOR:%s|r URL." -- `%s`: website name, e.g. CurseForge.
