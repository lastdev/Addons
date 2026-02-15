local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "zhCN")

if not L then return end

-- translated using chatgpt

-- Globals
L["Khamuls Collections for Krowi's Achievement Filter"] = "Khamul 的收藏（用于 Krowi 的成就过滤器）"
L["Khamul's Meta-Expansion Achievement List"] = "Khamul 的资料片元坐骑收藏"
L["Khamul's House Decor Achievement List"] = "Khamul 的装饰收藏"
L["Khamul's Campsite Achievement List"] = "Khamul 的营地收藏"
L["Khamul's Battle Pet Achievement List"] = "Khamul 的战斗宠物收藏"

-- Special categories
L["Cross-Expansion"] = "跨资料片"

-- Missing category titles
L["Hard"] = "困难"
L["Nightmare"] = "梦魇"

-- Tooltips
L["Tt_ACM_15035"] = "只需 4 个即可完成该元成就"
L["Tt_UseMetaAchievementPlugin"] = "使用“Khamul 的元坐骑收藏”分类，以获取“{1}”的详细概览。"

-- Messages
L["Krowi's Achievement Filter Addon not loaded!"] = "Krowi 的成就过滤器插件未加载！"

-- Options
L["Show List for Expansion Meta Achievements"] = "显示元坐骑收藏"
L["If enabled, a list with all achievements required for expansion meta achievements will be shown"] = "启用后，将显示包含所有资料片元成就所需成就的收藏。"
L["Show List for Achievements with decors as reward"] = "显示以装饰品为奖励的成就收藏"
L["If enabled, a list with all achievements, which have a decor as reward, will be shown"] = "启用后，将显示所有以装饰品作为奖励的成就收藏。"
L["Show List for Achievements with warband campsites as reward"] = "显示以战团营地为奖励的成就收藏"
L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"] = "启用后，将显示所有以战团营地作为奖励的成就收藏。"
L["Show List for Achievements with battle pets as reward"] = "显示以战斗宠物为奖励的成就收藏"
L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"] = "启用后，将显示所有以战斗宠物作为奖励的成就收藏。"
L["Krowi AchievementFilter status: "] = "Krowi AchievementFilter 状态："
L["detected"] = "已检测到"
L["not detected"] = "未检测到"
L["Decor Collection Settings"] = "装饰收藏设置"
L["Meta-Mount Collection Settings"] = "元坐骑收藏设置"
L["Campsite Collection Settings"] = "营地收藏设置"
L["Pet Collection Settings"] = "宠物收藏设置"
L["Flatten collection structure"] = "扁平化收藏结构"
L["The collections depth will be flatten and all achievements will be displayed in the expansions category"] = "收藏层级将被扁平化，所有成就都会显示在资料片分类中。"
L["Include Child Achievements"] = "包含子成就"
L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."] = "如果某个成就需要其他成就作为前置，它们将显示在一个额外的分类中。"
L["Changing any option on this page, requires a reload to take affect."] = "更改此页面上的任何选项都需要重新加载界面才能生效。"
L["Include Battle-Pet related rewards"] = "包含战斗宠物相关奖励"
L["This will include Achievements with Pet-Battle rewards like daily quests unlock, costumes and toys"] = "这将包含带有战斗宠物奖励的成就，例如解锁日常任务、外观和玩具"