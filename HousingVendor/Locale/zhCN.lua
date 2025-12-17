-- Simplified Chinese Localization
if not HousingVendorLocales then
    HousingVendorLocales = {}
end

local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "住宅装饰位置"
L["HOUSING_VENDOR_SUBTITLE"] = "浏览艾泽拉斯各地商贩的所有住宅装饰"

-- Filter Labels
L["FILTER_SEARCH"] = "搜索:"
L["FILTER_EXPANSION"] = "资料片:"
L["FILTER_VENDOR"] = "商贩:"
L["FILTER_ZONE"] = "区域:"
L["FILTER_TYPE"] = "类型:"
L["FILTER_CATEGORY"] = "分类:"
L["FILTER_FACTION"] = "阵营:"
L["FILTER_SOURCE"] = "来源:"
L["FILTER_PROFESSION"] = "专业:"
L["FILTER_CLEAR"] = "清除筛选"
L["FILTER_ALL_EXPANSIONS"] = "所有资料片"
L["FILTER_ALL_VENDORS"] = "所有商贩"
L["FILTER_ALL_ZONES"] = "所有区域"
L["FILTER_ALL_TYPES"] = "所有类型"
L["FILTER_ALL_CATEGORIES"] = "所有分类"
L["FILTER_ALL_SOURCES"] = "所有来源"
L["FILTER_ALL_FACTIONS"] = "所有阵营"

-- Column Headers
L["COLUMN_ITEM"] = "物品"
L["COLUMN_ITEM_NAME"] = "物品名称"
L["COLUMN_SOURCE"] = "来源"
L["COLUMN_LOCATION"] = "位置"
L["COLUMN_PRICE"] = "价格"
L["COLUMN_COST"] = "花费"
L["COLUMN_VENDOR"] = "商贩"
L["COLUMN_TYPE"] = "类型"

-- Buttons
L["BUTTON_SETTINGS"] = "设置"
L["BUTTON_STATISTICS"] = "统计"
L["BUTTON_BACK"] = "返回"
L["BUTTON_CLOSE"] = "关闭"
L["BUTTON_WAYPOINT"] = "设置路径点"
L["BUTTON_SAVE"] = "保存"
L["BUTTON_RESET"] = "重置"

-- Settings Panel
L["SETTINGS_TITLE"] = "住宅插件设置"
L["SETTINGS_GENERAL_TAB"] = "一般"
L["SETTINGS_COMMUNITY_TAB"] = "社区"
L["SETTINGS_MINIMAP_SECTION"] = "小地图按钮"
L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "显示小地图按钮"
L["SETTINGS_UI_SCALE_SECTION"] = "界面缩放"
L["SETTINGS_UI_SCALE"] = "界面缩放"
L["SETTINGS_FONT_SIZE"] = "字体大小"
L["SETTINGS_RESET"] = "重置"
L["SETTINGS_RESET_DEFAULTS"] = "重置为默认值"
L["SETTINGS_PROGRESS_TRACKING"] = "进度追踪"
L["SETTINGS_SHOW_COLLECTED"] = "显示已收集物品"
L["SETTINGS_WAYPOINT_NAVIGATION"] = "路径点导航"
L["SETTINGS_USE_PORTAL_NAVIGATION"] = "使用智能传送门导航"

-- Tooltips
L["TOOLTIP_SETTINGS"] = "设置"
L["TOOLTIP_SETTINGS_DESC"] = "设置插件选项"
L["TOOLTIP_WAYPOINT"] = "设置路径点"
L["TOOLTIP_WAYPOINT_DESC"] = "前往此商贩"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "智能传送门导航已启用"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "跨越区域时将自动使用最近的传送门"
L["TOOLTIP_DIRECT_NAVIGATION"] = "直接导航已启用"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "路径点将直接指向商贩位置（不建议用于跨区域旅行）"

-- Info Panel Tooltips
L["TOOLTIP_INFO_EXPANSION"] = "此物品来自的魔兽世界资料片"
L["TOOLTIP_INFO_FACTION"] = "哪个阵营可以从商贩处购买此物品"
L["TOOLTIP_INFO_VENDOR"] = "出售此物品的NPC商贩"
L["TOOLTIP_INFO_VENDOR_WITH_COORDS"] = "出售此物品的NPC商贩\n\n位置：%s\n坐标：%s"
L["TOOLTIP_INFO_ZONE"] = "此商贩所在的区域"
L["TOOLTIP_INFO_ZONE_WITH_COORDS"] = "此商贩所在的区域\n\n坐标：%s"
L["TOOLTIP_INFO_REPUTATION"] = "从商贩处购买此物品所需的声望要求"
L["TOOLTIP_INFO_RENOWN"] = "解锁此物品所需的主要阵营名望等级"
L["TOOLTIP_INFO_PROFESSION"] = "制作此物品所需的专业技能"
L["TOOLTIP_INFO_PROFESSION_SKILL"] = "制作此物品所需的专业技能等级"
L["TOOLTIP_INFO_PROFESSION_RECIPE"] = "制作此物品的配方或图样名称"
L["TOOLTIP_INFO_EVENT"] = "此物品可用的特殊活动或节日"
L["TOOLTIP_INFO_CLASS"] = "此物品只能由此职业使用"
L["TOOLTIP_INFO_RACE"] = "此物品只能由此种族使用"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "智能传送门导航已启用。跨越区域时路径点将自动使用最近的传送门。"
L["MESSAGE_DIRECT_NAV_ENABLED"] = "直接导航已启用。路径点将直接指向商贩位置（不建议用于跨区域旅行）。"

-- Community Section
L["COMMUNITY_TITLE"] = "社区与支持"
L["COMMUNITY_INFO"] = "加入我们的社区来分享技巧、报告错误和建议新功能！"
L["COMMUNITY_DISCORD"] = "Discord 服务器"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "报告错误"
L["COMMUNITY_SUGGEST_FEATURE"] = "建议功能"

-- Preview Panel
L["PREVIEW_TITLE"] = "物品预览"
L["PREVIEW_NO_SELECTION"] = "选择物品以查看详细信息"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "显示 %d 个物品（共 %d 个）"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "住宅插件未初始化"
L["ERROR_UI_NOT_AVAILABLE"] = "HousingVendor 界面无法使用"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "设置面板无法使用"

-- Statistics UI
L["STATS_TITLE"] = "统计面板"
L["STATS_COLLECTION_PROGRESS"] = "收集进度"
L["STATS_ITEMS_BY_SOURCE"] = "按来源分类的物品"
L["STATS_ITEMS_BY_FACTION"] = "按阵营分类的物品"
L["STATS_COLLECTION_BY_EXPANSION"] = "按资料片分类的收集"
L["STATS_COLLECTION_BY_CATEGORY"] = "按分类收集"
L["STATS_COMPLETE"] = "%d%% 完成 - 已收集 %d / %d 个物品"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "颜色指南:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "点击带有 %s 的物品以设置路径点"

-- Main UI
L["MAIN_SUBTITLE"] = "住宅目录"

-- Common Strings
L["COMMON_FREE"] = "免费"
L["COMMON_UNKNOWN"] = "未知"
L["COMMON_NA"] = "不适用"
L["COMMON_GOLD"] = "金币"
L["COMMON_ITEM_ID"] = "物品ID:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "住宅商贩浏览器"
L["MINIMAP_TOOLTIP_DESC"] = "左键切换住宅商贩浏览器"

-- Expansion Names
L["EXPANSION_CLASSIC"] = "经典旧世"
L["EXPANSION_THEBURNINGCRUSADE"] = "燃烧的远征"
L["EXPANSION_WRATHOFTHELLICHKING"] = "巫妖王之怒"
L["EXPANSION_CATACLYSM"] = "大地的裂变"
L["EXPANSION_MISTSOFPANDARIA"] = "熊猫人之谜"
L["EXPANSION_WARLORDSOF DRAENOR"] = "德拉诺之王"
L["EXPANSION_LEGION"] = "军团再临"
L["EXPANSION_BATTLEFORAZEROTH"] = "争霸艾泽拉斯"
L["EXPANSION_SHADOWLANDS"] = "暗影国度"
L["EXPANSION_DRAGONFLIGHT"] = "巨龙时代"
L["EXPANSION_THEWARWITHIN"] = "地心之战"
L["EXPANSION_MIDNIGHT"] = "午夜"

-- Faction Names
L["FACTION_ALLIANCE"] = "联盟"
L["FACTION_HORDE"] = "部落"
L["FACTION_NEUTRAL"] = "中立"

-- Source Types
L["SOURCE_VENDOR"] = "商贩"
L["SOURCE_ACHIEVEMENT"] = "成就"
L["SOURCE_QUEST"] = "任务"
L["SOURCE_DROP"] = "掉落"
L["SOURCE_PROFESSION"] = "专业"
L["SOURCE_REPUTATION"] = "声望"

-- Quality Names
L["QUALITY_POOR"] = "低劣"
L["QUALITY_COMMON"] = "普通"
L["QUALITY_UNCOMMON"] = "优秀"
L["QUALITY_RARE"] = "精良"
L["QUALITY_EPIC"] = "史诗"
L["QUALITY_LEGENDARY"] = "传说"

-- Collection Status
L["COLLECTION_COLLECTED"] = "已收集"
L["COLLECTION_UNCOLLECTED"] = "未收集"

-- Requirement Types
L["REQUIREMENT_NONE"] = "无"
L["REQUIREMENT_ACHIEVEMENT"] = "成就"
L["REQUIREMENT_QUEST"] = "任务"
L["REQUIREMENT_REPUTATION"] = "声望"
L["REQUIREMENT_RENOWN"] = "名望"
L["REQUIREMENT_PROFESSION"] = "专业"

-- Common Category/Type Names
L["CATEGORY_FURNITURE"] = "家具"
L["CATEGORY_DECORATIONS"] = "装饰品"
L["CATEGORY_LIGHTING"] = "照明"
L["CATEGORY_PLACEABLES"] = "可放置物品"
L["CATEGORY_ACCESSORIES"] = "配饰"
L["CATEGORY_RUGS"] = "地毯"
L["CATEGORY_PLANTS"] = "植物"
L["CATEGORY_PAINTINGS"] = "绘画"
L["CATEGORY_BANNERS"] = "旗帜"
L["CATEGORY_BOOKS"] = "书籍"
L["CATEGORY_FOOD"] = "食物"
L["CATEGORY_TOYS"] = "玩具"

-- Type Names
L["TYPE_CHAIR"] = "椅子"
L["TYPE_TABLE"] = "桌子"
L["TYPE_BED"] = "床"
L["TYPE_LAMP"] = "灯"
L["TYPE_CANDLE"] = "蜡烛"
L["TYPE_RUG"] = "地毯"
L["TYPE_PAINTING"] = "绘画"
L["TYPE_BANNER"] = "旗帜"
L["TYPE_PLANT"] = "植物"
L["TYPE_BOOKSHELF"] = "书架"
L["TYPE_CHEST"] = "箱子"
L["TYPE_WEAPON_RACK"] = "武器架"

-- Filter Options
L["FILTER_HIDE_VISITED"] = "隐藏已访问"
L["FILTER_ALL_QUALITIES"] = "所有品质"
L["FILTER_ALL_REQUIREMENTS"] = "所有要求"

-- UI Theme Names
L["THEME_MIDNIGHT"] = "午夜"
L["THEME_ALLIANCE"] = "联盟"
L["THEME_HORDE"] = "部落"
L["THEME_SLEEK_BLACK"] = "时尚黑"
L["SETTINGS_UI_THEME"] = "界面主题"

-- Make the locale table globally available
HousingVendorLocales["zhCN"] = L