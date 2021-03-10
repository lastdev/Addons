local ADDON_NAME, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "zhCN", false, true)

if not L then return end

-------------------------------------------------------------------------------
----------------------------------- ICECROWN ----------------------------------
-------------------------------------------------------------------------------
L["plaguewave"] = "这|cFFFF0000不是|r真的BOSS，仅用于显示共享掉落和刷新顺序。 |n|nBOSS刷新间隔为10分钟，刷新顺序为：|n|n 1. 药剂师诺斯|n 2. 帕奇维克|n 3. 鲜血女王兰娜瑟尔|n 4. 普崔塞德教授|n 5. 亡语者女士|n 6. 残忍的斯卡迪|n 7. 掠夺者因格瓦尔|n 8. 凯雷塞斯王子|n 9. 黑骑士|n10. 布隆亚姆|n11. 天灾领主泰兰努斯|n12. 熔炉之主加弗斯特|n13. 玛维恩|n14. 法瑞克|n15. 先知萨隆亚|n16. 召唤者诺沃斯|n17. 托尔戈|n18. 看门者克里克希尔|n19. 塔达拉姆王子|n20. 纳多克斯长老";

L["id174067"] = "(1) 最初位于纳克萨玛斯。"
L["id174066"] = "(2) 最初位于纳克萨玛斯。"
L["id174065"] = "(3) 最初位于冰冠堡垒。"
L["id174064"] = "(4) 最初位于冰冠堡垒。"
L["id174063"] = "(5) 最初位于冰冠堡垒。"
L["id174062"] = "(6) 最初位于乌特加德之巅。"
L["id174061"] = "(7) 最初位于乌特加德城堡。"
L["id174060"] = "(8) 最初位于乌特加德城堡和冰冠堡垒。"
L["id174059"] = "(9) 最初位于冠军的试炼。"
L["id174058"] = "(10) 最初位于灵魂洪炉。"
L["id174057"] = "(11) 最初位于萨隆矿坑。"
L["id174056"] = "(12) 最初位于萨隆矿坑。"
L["id174055"] = "(13) 最初位于映像大厅。"
L["id174054"] = "(14) 最初位于映像大厅。"
L["id174053"] = "(15) 最初位于达克萨隆要塞。"
L["id174052"] = "(16) 最初位于达克萨隆要塞。"
L["id174051"] = "(17) 最初位于达克萨隆要塞。"
L["id174050"] = "(18) 最初位于艾卓-尼鲁布。"
L["id174049"] = "(19) 最初位于安卡赫特：古代王国。"
L["id174048"] = "(20) 最初位于安卡赫特：古代王国。"

-------------------------------------------------------------------------------
------------------------------------ GEAR -------------------------------------
-------------------------------------------------------------------------------

L["cloth"] = "布甲";
L["leather"] = "皮甲";
L["mail"] = "锁甲";
L["plate"] = "板甲";

L["1h_mace"] = "单手锤";
L["1h_sword"] = "单手剑";
L["1h_axe"] = "单手斧";
L["2h_mace"] = "双手锤";
L["2h_axe"] = "双手斧";
L["2h_sword"] = "双手剑";
L["shield"] = "盾牌";
L["dagger"] = "匕首";
L["staff"] = "法杖";
L["fist"] = "拳套";
L["polearm"] = "长柄武器";
L["bow"] = "弓";
L["gun"] = "枪";
L["wand"] = "魔杖";
L["crossbow"] = "弩";
L["offhand"] = "副手物品";
L["warglaives"] = "战刃";

L["ring"] = "戒指";
L["amulet"] = "项链";
L["cloak"] = "披风";
L["trinket"] = "饰品";

-------------------------------------------------------------------------------
---------------------------------- TOOLTIPS -----------------------------------
-------------------------------------------------------------------------------

L["retrieving"] = "获取物品链接 ...";
L["in_cave"] = "在洞穴中。";
L["weekly"] = "每周";
L["normal"] = "普通";
L["hard"] = "困难";
L["mount"] = "坐骑";
L["pet"] = "宠物";
L["toy"] = "玩具";
L["completed"] = "已完成"
L["incomplete"] = "未完成"
L["known"] = "已收藏"
L["missing"] = "未收藏"
L["unobtainable"] = "无法获取"
L["unlearnable"] = "无法解锁"

-------------------------------------------------------------------------------
--------------------------------- CONTEXT MENU --------------------------------
-------------------------------------------------------------------------------

L["context_menu_title"] = "HandyNotes 暗影国度天灾入侵";
L["context_menu_add_tomtom"] = "添加至TomTom";
L["context_menu_hide_node"] = "隐藏此节点";
L["context_menu_restore_hidden_nodes"] = "恢复所有隐藏节点";
L["Icecrown"] = "冰冠冰川";

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

L["options_title"] = "暗影国度天灾入侵";

------------------------------------ ICONS ------------------------------------

L["options_icon_settings"] = "图标设定";
L["options_icons_treasures"] = "宝藏图标";
L["options_icons_rares"] = "稀有图标";
L["options_icons_caves"] = "洞穴图标";
L["options_icons_pet_battles"] = "宠物图标";
L["options_icons_other"] = "其他图标";
L["options_scale"] = "缩放";
L["options_scale_desc"] = "1 = 100%";
L["options_opacity"] = "透明度";
L["options_opacity_desc"] = "0 = 全透明，1 = 不透明";

---------------------------------- VISIBILITY ---------------------------------

L["options_visibility_settings"] = "可见性";
L["options_general_settings"] = "一般";
L["options_toggle_looted_rares"] = "永久显示所有稀有";
L["options_toggle_looted_rares_desc"] = "显示所有稀有，无论是否有拾取";
L["options_toggle_looted_treasures"] = "已经拾取的宝藏";
L["options_toggle_looted_treasures_desc"] = "显示所有宝藏，无论是否有拾取";
L["options_toggle_hide_done_rare"] = "隐藏稀有，如果物品都已收藏";
L["options_toggle_hide_done_rare_desc"] = "隐藏全部拾取物品都已收藏的稀有。";
L["options_toggle_hide_minimap"] = "隐藏小地图的所有图标";
L["options_toggle_hide_minimap_desc"] = "在小地图上隐藏来自此插件的所有图标，并且显示在大地图上。";

L["options_toggle_battle_pets_desc"] = "限时战斗宠物训练师与NPC的位置。";
L["options_toggle_battle_pets"] = "战斗宠物";
L["options_toggle_caves_desc"] = "显示其他节点的洞穴入口。";
L["options_toggle_caves"] = "洞穴";
L["options_toggle_misc"] = "其他";
L["options_toggle_npcs"] = "NPC";
L["options_toggle_rares_desc"] = "显示稀有NPC的位置。";
L["options_toggle_rares"] = "稀有";
L["options_toggle_supplies_desc"] = "显示所有战争补给箱可能的位置。";
L["options_toggle_supplies"] = "战争补给掉落";
L["options_toggle_treasures"] = "宝藏";

---------------------------------- TOOLTIP ---------------------------------

L["options_tooltip_settings"] = "工具提示";
L["options_tooltip_settings_desc"] = "工具提示";
L["options_toggle_show_loot"] = "显示拾取";
L["options_toggle_show_loot_desc"] = "在工具提示中加入掉落信息";
L["options_toggle_show_notes"] = "显示备注";
L["options_toggle_show_notes_desc"] = "如果有的话在工具提示中显示备注";

--------------------------------- DEVELOPMENT ---------------------------------

L["options_dev_settings"] = "开发";
L["options_dev_settings_desc"] = "开发设定";
L["options_toggle_show_debug"] = "除错";
L["options_toggle_show_debug_desc"] = "显示除错内容";
L["options_toggle_ignore_quests"] = "忽略任务";
L["options_toggle_ignore_quests_desc"] = "忽略节点的任务状态";
L["options_toggle_force_nodes"] = "强制节点";
L["options_toggle_force_nodes_desc"] = "强制显示所有节点";

