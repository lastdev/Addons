-- Localization for HousingVendor addon - Traditional Chinese
local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "住宅裝飾位置"
L["HOUSING_VENDOR_SUBTITLE"] = "瀏覽艾澤拉斯各地販售商的所有住宅裝飾"

-- Filter Labels
L["FILTER_SEARCH"] = "搜尋:"
L["FILTER_EXPANSION"] = "資料片:"
L["FILTER_VENDOR"] = "販售商:"
L["FILTER_ZONE"] = "區域:"
L["FILTER_TYPE"] = "類型:"
L["FILTER_CATEGORY"] = "分類:"
L["FILTER_FACTION"] = "陣營:"
L["FILTER_SOURCE"] = "來源:"
L["FILTER_PROFESSION"] = "專業:"
L["FILTER_CLEAR"] = "清除篩選"
L["FILTER_ALL_EXPANSIONS"] = "所有資料片"
L["FILTER_ALL_VENDORS"] = "所有販售商"
L["FILTER_ALL_ZONES"] = "所有區域"
L["FILTER_ALL_TYPES"] = "所有類型"
L["FILTER_ALL_CATEGORIES"] = "所有分類"
L["FILTER_ALL_SOURCES"] = "所有來源"
L["FILTER_ALL_FACTIONS"] = "所有陣營"

-- Column Headers
L["COLUMN_ITEM"] = "物品"
L["COLUMN_ITEM_NAME"] = "物品名稱"
L["COLUMN_SOURCE"] = "來源"
L["COLUMN_LOCATION"] = "位置"
L["COLUMN_PRICE"] = "價格"
L["COLUMN_COST"] = "花費"
L["COLUMN_VENDOR"] = "販售商"
L["COLUMN_TYPE"] = "類型"

-- Buttons
L["BUTTON_SETTINGS"] = "設定"
L["BUTTON_STATISTICS"] = "統計"
L["BUTTON_BACK"] = "← 返回"
L["BUTTON_CLOSE"] = "關閉"
L["BUTTON_WAYPOINT"] = "設置路徑點"
L["BUTTON_SAVE"] = "儲存"
L["BUTTON_RESET"] = "重置"

-- Settings Panel
L["SETTINGS_TITLE"] = "住宅插件設定"
L["SETTINGS_GENERAL_TAB"] = "一般"
L["SETTINGS_COMMUNITY_TAB"] = "社群"
L["SETTINGS_MINIMAP_SECTION"] = "小地圖按鈕"
L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "顯示小地圖按鈕"
L["SETTINGS_UI_SCALE_SECTION"] = "介面縮放"
L["SETTINGS_UI_SCALE"] = "介面縮放"
L["SETTINGS_FONT_SIZE"] = "字體大小"
L["SETTINGS_RESET"] = "重置"
L["SETTINGS_RESET_DEFAULTS"] = "重置為預設值"
L["SETTINGS_PROGRESS_TRACKING"] = "進度追蹤"
L["SETTINGS_SHOW_COLLECTED"] = "顯示已收集物品"
L["SETTINGS_WAYPOINT_NAVIGATION"] = "路徑點導航"
L["SETTINGS_USE_PORTAL_NAVIGATION"] = "使用智慧傳送門導航"

-- Tooltips
L["TOOLTIP_SETTINGS"] = "設定"
L["TOOLTIP_SETTINGS_DESC"] = "設定插件選項"
L["TOOLTIP_WAYPOINT"] = "設置路徑點"
L["TOOLTIP_WAYPOINT_DESC"] = "前往此販售商"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "智慧傳送門導航已啟用"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "跨越區域時將自動使用最近的傳送門"
L["TOOLTIP_DIRECT_NAVIGATION"] = "直接導航已啟用"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "路徑點將直接指向販售商位置（不建議用於跨區域旅行）"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "智慧傳送門導航已啟用。跨越區域時路徑點將自動使用最近的傳送門。"
L["MESSAGE_DIRECT_NAV_ENABLED"] = "直接導航已啟用。路徑點將直接指向販售商位置（不建議用於跨區域旅行）。"

-- Community Section
L["COMMUNITY_TITLE"] = "社群與支援"
L["COMMUNITY_INFO"] = "加入我們的社群來分享技巧、回報錯誤和建議新功能！"
L["COMMUNITY_DISCORD"] = "Discord 伺服器"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "回報錯誤"
L["COMMUNITY_SUGGEST_FEATURE"] = "建議功能"

-- Preview Panel
L["PREVIEW_TITLE"] = "物品預覽"
L["PREVIEW_NO_SELECTION"] = "選擇物品以查看詳細資訊"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "顯示 %d 個物品（共 %d 個）"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "住宅插件未初始化"
L["ERROR_UI_NOT_AVAILABLE"] = "HousingVendor 介面無法使用"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "設定面板無法使用"

-- Statistics UI
L["STATS_TITLE"] = "統計面板"
L["STATS_COLLECTION_PROGRESS"] = "收集進度"
L["STATS_ITEMS_BY_SOURCE"] = "按來源分類的物品"
L["STATS_ITEMS_BY_FACTION"] = "按陣營分類的物品"
L["STATS_COLLECTION_BY_EXPANSION"] = "按資料片分類的收集"
L["STATS_COLLECTION_BY_CATEGORY"] = "按分類收集"
L["STATS_COMPLETE"] = "%d%% 完成 - 已收集 %d / %d 個物品"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "顏色指南:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "點擊帶有 %s 的物品以設置路徑點"

-- Main UI
L["MAIN_SUBTITLE"] = "住宅目錄"

-- Common Strings
L["COMMON_FREE"] = "免費"
L["COMMON_UNKNOWN"] = "未知"
L["COMMON_NA"] = "不適用"
L["COMMON_GOLD"] = "金幣"
L["COMMON_ITEM_ID"] = "物品ID:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "住宅販售商瀏覽器"
L["MINIMAP_TOOLTIP_DESC"] = "左鍵切換住宅販售商瀏覽器"

-- Make the locale table globally available
_G["HousingVendorLocale"] = L