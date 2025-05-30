local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes_Valdrakken", "zhCN", false, true)

if not L then return end
-- Simplified Chinese localization by nbyang ( https://www.curseforge.com/members/nbyang )
--  zhCN client: (NGA-男爵凯恩)
--  Last update: 2023/11/17
if L then
----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------

L["config_plugin_name"] = "瓦德拉肯"
L["config_plugin_desc"] = "在世界地图和小地图中显示瓦德拉肯所有NPC"

L["config_tab_general"] = "通用"
L["config_tab_scale_alpha"] = "缩放/透明度"
--L["config_scale_alpha_desc"] = "PH"
L["config_icon_scale"] = "图标大小"
L["config_icon_scale_desc"] = "调整图标的大小"
L["config_icon_alpha"] = "图标透明度"
L["config_icon_alpha_desc"] = "修改图标透明度"
L["config_what_to_display"] = "选择要显示的图标"
L["config_what_to_display_desc"] = "根据你的需要在下面调整所显示的图标"

L["config_auctioneer"] = "拍卖行"
L["config_auctioneer_desc"] = "显示拍卖行的位置"

L["config_banker"] = "银行"
L["config_banker_desc"] = "显示拍卖行的位置"

L["config_barber"] = "美容师"
L["config_barber_desc"] = "显示美容师的位置"

L["config_craftingorders"] = "制造订单"
L["config_craftingorders_desc"] = "显示制造订单的位置"

L["config_flightmaster"] = "飞行管理员"
L["config_flightmaster_desc"] = "显示飞行管理员的位置"

L["config_guildvault"] = "公会银行"
L["config_guildvault_desc"] = "显示公会银行图标"

L["config_innkeeper"] = "旅店"
L["config_innkeeper_desc"] = "显示旅店的位置"

L["config_mail"] = "邮箱"
L["config_mail_desc"] = "显示邮箱的位置"

L["config_portal"] = "传送门"
L["config_portal_desc"] = "显示传送门的位置。"

L["config_portaltrainer"] = "传送门训练师"
L["config_portaltrainer_desc"] = "显示传送门训练师图标"

L["config_tpplatform"] = "传送平台"
L["config_tpplatform_desc"] = "显示传送平台的位置"

L["config_travelguide_note"] = "|cFFFF0000* 由于 TravelGuide 的存在, 本模块不会启用 |r"

L["config_reforge"] = "物品升级"
L["config_reforge_desc"] = "显示物品升级NPC的位置"

L["config_rostrum"] = "幻形讲坛"
L["config_rostrum_desc"] = "显示幻形讲台的位置"

L["config_stablemaster"] = "兽栏管理员"
L["config_stablemaster_desc"] = "显示兽栏管理员的位置"

L["config_trainer"] = "专业训练师"
L["config_trainer_desc"] = "显示专业训练师的位置"

L["config_transmogrifier"] = "幻化师"
L["config_transmogrifier_desc"] = "显示幻化师的位置"

L["config_vendor"] = "商人"
L["config_vendor_desc"] = "显示商人的位置"

L["config_void"] = "虚空仓库"
L["config_void_desc"] = "显示虚空仓库的位置"

L["config_others"] = "其他"
L["config_others_desc"] = "显示其他的点"

L["config_onlymytrainers"] = "只显示与我专业相关的训练师和商人"
L["config_onlymytrainers_desc"] = [[
只显示与我专业相关的训练师和商人

|cFFFF0000 注意:只有学习了两个专业后该功能才有效果 |r
]]

L["config_fmaster_waypoint"] = "飞行点导航"
L["config_fmaster_waypoint_desc"] = "当你进入转移之环时, 自动在飞行点建立导航点."

L["config_easy_waypoints"] = "便捷导航"
L["config_easy_waypoints_desc"] = "使你可以更简单的建立导航路线, 你可以通过右键单击设定导航点或者使用CTRL+右键单击获得更多选项."

L["config_waypoint_dropdown"] = "选择"
L["config_waypoint_dropdown_desc"] = "选择如何建立导航点"
L["Blizzard"] = "暴雪原生"
L["TomTom"] = true
L["Both"] = "同时显示"

L["config_picons"] = "显示专业图标"
L["config_picons_vendor_desc"] = "显示专业图标而不是商人图标"
L["config_picons_trainer_desc"] = "显示专业图标而不是训练师图标"

L["config_use_old_picons"] = "显示旧职业图标"
L["config_use_old_picons_desc"] = "显示旧职业图标而不是新的图标 (巨龙时代之前的)."

L["config_restore_nodes"] = "恢复被隐藏的图标"
L["config_restore_nodes_desc"] = "恢复被你隐藏掉的图标"
L["config_restore_nodes_print"] = "所有隐藏的图标已被恢复"

----------------------------------------------------------------------------------------------------
-------------------------------------------------DEV------------------------------------------------
----------------------------------------------------------------------------------------------------

L["dev_config_tab"] = "DEV"

L["dev_config_force_nodes"] = "强制显示"
L["dev_config_force_nodes_desc"] = "无论你的职业或阵营, 强制显示所有的点."

L["dev_config_show_prints"] = "显示标记()"
L["dev_config_show_prints_desc"] = "在聊天窗口中显示标记()的信息"

----------------------------------------------------------------------------------------------------
-----------------------------------------------HANDLER----------------------------------------------
----------------------------------------------------------------------------------------------------

--==========================================CONTEXT_MENU==========================================--

L["handler_context_menu_addon_name"] = "HandyNotes:瓦德拉肯"
L["handler_context_menu_add_tomtom"] = "添加到 TomTom"
L["handler_context_menu_add_map_pin"] = "设置地图航点"
L["handler_context_menu_hide_node"] = "隐藏这个图标"

--============================================TOOLTIPS============================================--

L["handler_tooltip_requires"] = "需要"
L["handler_tooltip_requires_level"] = "需要玩家等级"
L["handler_tooltip_data"] = "检索数据中..."
L["handler_tooltip_quest"] = "解锁任务"

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

L["Crafting Orders"] = "制造订单"
L["Mailbox"] = "邮箱"
L["Portal to Orgrimmar"] = "通往奥格瑞玛"
L["Portal to Stormwind"] = "通往暴风城"
L["Rostrum of Transformation"] = "幻形讲坛"
L["Teleport to Seat of the Aspects"] = "传送到守护巨龙之座"
L["Visage of True Self"] = "凯旋幻容"
L["Portal to Badlands"] = "通往荒芜之地的传送门"
L["Portal to Central Encampment"] = "通往中心营地的传送门"
L["Portal to The Timeways"] = "通往时间流的传送门"
end
