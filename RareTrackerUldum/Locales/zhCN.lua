-- The locale for the Chinese language, provided generously by cikichen.
local L = LibStub("AceLocale-3.0"):NewLocale("RareTrackerUldum", "zhCN")
if not L then return end

-- Option menu strings.
L["Rare window scale"] = "稀有窗口缩放"
L["Set the scale of the rare window."] = "设定稀有窗口缩放。"
L["Disable All"] = "禁用全部"
L["Disable all non-favorite rares in the list."] = "禁用全部非偏好稀有列表。"
L["Enable All"] = "启用全部"
L["Enable all rares in the list."] = "启用全部稀有列表。"
L["Reset Favorites"] = "重置偏好"
L["Reset the list of favorite rares."] = "重置偏好稀有列表。"
L["General Options"] = "通用选项"
L["Enable filter fallback"] = "启用过滤后备"
L["Show only rares that drop special loot (mounts/pets/toys) when no assault data is available."] = "当没有可用的攻击数据时，仅显示掉下特殊拾取的稀有物品（坐骑/宠物/玩具）。"
L["Rare List Options"] = "偏好列表选项"
L["Active Rares"] = "激活稀有"

-- Status messages.
L["<%s> Moving to shard "] = "<%s> 移动到分片 "
L["<%s> Failed to register AddonPrefix '%s'. %s will not function properly."] = "<%s> 无法注册插件前缀 '%s'。%s无法正常运行。"