local ADDON_NAME, ns = ...
local L = ns.NewLocale('zhTW')
if not L then return end

-------------------------------------------------------------------------------
------------------------------------ GEAR -------------------------------------
-------------------------------------------------------------------------------

L['bag'] = '背包'
L['cloth'] = '布甲'
L['leather'] = '皮甲'
L['mail'] = '鎖甲'
L['plate'] = '鎧甲'
L['cosmetic'] = '裝飾品'
L['tabard'] = '外袍'

L['1h_mace'] = '單手錘'
L['1h_sword'] = '單手劍'
L['1h_axe'] = '單手斧'
L['2h_mace'] = '雙手錘'
L['2h_axe'] = '雙手斧'
L['2h_sword'] = '雙手劍'
L['shield'] = '盾牌'
L['dagger'] = '匕首'
L['staff'] = '法杖'
L['fist'] = '拳套'
L['polearm'] = '長柄武器'
L['bow'] = '弓'
L['gun'] = '槍'
L['wand'] = '魔杖'
L['crossbow'] = '弩'
L['offhand'] = '副手'
L['warglaive'] = '戰刃'

L['ring'] = '戒指'
L['neck'] = '項鍊'
L['cloak'] = '披風'
L['trinket'] = '飾品'

-------------------------------------------------------------------------------
---------------------------------- TOOLTIPS -----------------------------------
-------------------------------------------------------------------------------

L['activation_unknown'] = '啟動條件未知!'
L['requirement_not_found'] = '所需位置未知!'
L['multiple_spawns'] = '可能出現在多個位置.'
L['shared_drops'] = '共享掉落'
L['zone_drops_label'] = '區域掉落'
L['zone_drops_note'] = '下列的物品會由此區域的數個怪物掉落.'

L['poi_entrance_label'] = '入口'
L['change_map'] = '切換地圖'

L['requires'] = '需要'
L['ranked_research'] = '%s (等級 %d/%d)'

L['focus'] = '專注'
L['retrieving'] = '接收物品連結…'

L['normal'] = '普通'
L['hard'] = '困難'

L['completed'] = '已完成'
L['incomplete'] = '未完成'
L['claimed'] = '已取得'
L['unclaimed'] = '未取得'
L['known'] = '已獲得'
L['missing'] = '未獲得'
L['unobtainable'] = '無法獲得'
L['unlearnable'] = '無法解鎖'
L['defeated'] = '已擊敗'
L['undefeated'] = '未擊敗'
L['elite'] = '菁英'
L['quest'] = '任務'
L['quest_repeatable'] = '可重複任務'
L['achievement'] = '成就'

---------------------------------- LOCATION -----------------------------------
L['in_cave'] = '在洞穴.'
L['in_small_cave'] = '在小洞穴.'
L['in_water_cave'] = '在水下洞穴.'
L['in_waterfall_cave'] = '在瀑布後面洞穴內.'
L['in_water'] = '在水下.'
L['in_building'] = '在建築內.'

------------------------------------ TIME -------------------------------------
L['now'] = '現在'
L['hourly'] = '每小時'
L['daily'] = '每日'
L['weekly'] = '每週'

L['time_format_12hrs'] = '%m/%d - %I:%M %p 本地時間'
L['time_format_24hrs'] = '%m/%d - %H:%M 本地時間'

----------------------------------- REWARDS -----------------------------------
L['heirloom'] = '傳家寶'
L['item'] = '物品'
L['mount'] = '坐騎'
L['pet'] = '戰寵'
L['recipe'] = '配方'
L['spell'] = '法術'
L['title'] = '稱號'
L['toy'] = '玩具'
L['currency'] = '通貨'
L['rep'] = '聲望'
L['buff'] = '增益'
L['transmog'] = '塑型'
L['hunter_pet'] = nil

---------------------------------- FOLLOWERS ----------------------------------
L['follower_type_follower'] = '追隨者'
L['follower_type_champion'] = '勇士'
L['follower_type_companion'] = '夥伴'

--------------------------------- REPUTATION ----------------------------------
L['rep_honored'] = '尊敬'
L['rep_revered'] = '崇敬'
L['rep_exalted'] = '崇拜'

-------------------------------------------------------------------------------
------------------------------- SKYRIDING RACES -------------------------------
-------------------------------------------------------------------------------

L['sr_your_best_time'] = '你的最快時間：'
L['sr_your_target_time'] = '目標時間：'
L['sr_best_time'] = ' - %s: %.3fs'
L['sr_target_time'] = ' - %s: %ss / %ss'
L['sr_normal'] = '普通'
L['sr_advanced'] = '進階'
L['sr_reverse'] = '逆向'
L['sr_challenge'] = '挑戰'
L['sr_reverse_challenge'] = '逆向挑戰'
L['sr_storm_race'] = '風暴競速'
L['sr_bronze'] = '完成賽事來取得 ' .. ns.color.Bronze('銅牌') .. '.'
L['sr_vendor_note'] = '使用 {currency:2588} 交換飛龍觀察者手稿和塑型.'
L['options_icons_skyriding_race'] = nil
L['options_icons_skyriding_race_desc'] = '顯示區域內所有飛龍競速的位置.'

-------------------------------------------------------------------------------
--------------------------------- CONTEXT MENU --------------------------------
-------------------------------------------------------------------------------

L['context_menu_set_waypoint'] = '設定地圖路徑點'
L['context_menu_add_tomtom'] = '加入到TomTom'
L['context_menu_add_group_tomtom'] = '加入群組到TomTom'
L['context_menu_add_focus_group_tomtom'] = '加入相關點到TomTom'
L['context_menu_hide_node'] = '隱藏此節點'
L['context_menu_restore_hidden_nodes'] = '恢復所有隱藏節點'

L['map_button_text'] = '調整此地圖上的圖示顯示與否、透明度與縮放程度.'

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

L['options_global'] = '整體'
L['options_zones'] = '區域'

L['options_general_description'] = '控制節點行為和獎勵的設定.'
L['options_global_description'] = '控制全部區域節點顯示的設定.'
L['options_zones_description'] = '控制每個單獨區域節點顯示的設定.'

L['options_open_settings_panel'] = '打開設定面板…'
L['options_open_world_map'] = '打開世界地圖'
L['options_open_world_map_desc'] = '在世界地圖中開啟此區域'

------------------------------------ ICONS ------------------------------------

L['options_icon_settings'] = '圖示設定'
L['options_scale'] = '縮放'
L['options_scale_desc'] = '1 = 100%'
L['options_opacity'] = '透明度'
L['options_opacity_desc'] = '0 = 透明, 1 = 不透明'

---------------------------------- VISIBILITY ---------------------------------

L['options_show_worldmap_button'] = '顯示世界地圖按鈕'
L['options_show_worldmap_button_desc'] = '在世界地圖右上角新增一個快速切換內容的下拉式選單.'

L['options_visibility_settings'] = '可視性'
L['options_general_settings'] = '一般'
L['options_show_completed_nodes'] = '顯示已完成'
L['options_show_completed_nodes_desc'] = '顯示所有的節點，即使它今天已被拾取或完成.'
L['options_toggle_hide_done_rare'] = '隱藏所有戰利品已取得的稀有'
L['options_toggle_hide_done_rare_desc'] = '隱藏所有戰利品都已取得的稀有.'
L['options_toggle_hide_done_treasure'] = '隱藏所有獎勵已取得的寶藏'
L['options_toggle_hide_done_treasure_desc'] = '隱藏所有獎勵都已取得的寶藏.'
L['options_toggle_hide_minimap'] = '隱藏小地圖上的所有圖示'
L['options_toggle_hide_minimap_desc'] = '在小地圖上隱藏此插件的所有圖示，並只在主地圖上顯示它們.'
L['options_toggle_maximized_enlarged'] = '當世界地圖時最大化時放大圖示'
L['options_toggle_maximized_enlarged_desc'] = '當世界地圖放到最大時，放大所有的圖示.'
L['options_toggle_use_char_achieves'] = '使用角色成就'
L['options_toggle_use_char_achieves_desc'] = '用此角色的成就進度來替代顯示整個帳號的進度.'
L['options_toggle_per_map_settings'] = '使用區域個別設定'
L['options_toggle_per_map_settings_desc'] = '只使用各個地圖各自獨立的切換、縮放和透明度設定'
L['options_restore_hidden_nodes'] = '恢復隱藏的節點'
L['options_restore_hidden_nodes_desc'] = '恢復所有使用右鍵選單隱藏的節點.'

L['ignore_class_restrictions'] = '忽略職業限制'
L['ignore_class_restrictions_desc'] = '顯示需要非當前角色職業的群組, 節點和獎勵.'
L['ignore_faction_restrictions'] = '忽略陣營限制'
L['ignore_faction_restrictions_desc'] = '顯示需要對方陣營的群組, 節點和獎勵.'

L['options_rewards_settings'] = '獎勵'
L['options_reward_behaviors_settings'] = '獎勵行為'
L['options_reward_types'] = '顯示獎勵類型'
L['options_manuscript_rewards'] = '顯示飛龍觀察者手稿獎勵'
L['options_manuscript_rewards_desc'] = '在提示顯示飛龍觀察者手稿並追蹤收集狀態.'
L['options_mount_rewards'] = '顯示坐騎獎勵'
L['options_mount_rewards_desc'] = '在提示顯示坐騎獎勵並追蹤收集狀態.'
L['options_pet_rewards'] = '顯示戰寵獎勵'
L['options_pet_rewards_desc'] = '在提示顯示戰寵獎勵並追蹤收集狀態.'
L['options_recipe_rewards'] = '顯示配方獎勵'
L['options_recipe_rewards_desc'] = '在提示顯示配方獎勵並追蹤收集狀態.'
L['options_toy_rewards'] = '顯示玩具獎勵'
L['options_toy_rewards_desc'] = '在提示顯示玩具獎勵並追蹤收集狀態.'
L['options_transmog_rewards'] = '顯示塑形獎勵'
L['options_transmog_rewards_desc'] = '在提示顯示塑型獎勵並追蹤收集狀態.'
L['options_all_transmog_rewards'] = '顯示無法取得的塑形獎勵'
L['options_all_transmog_rewards_desc'] = '顯示其他職業可以取得的塑形獎勵.'
L['options_rep_rewards'] = '顯示聲望獎勵'
L['options_rep_rewards_desc'] = '在提示顯示聲望獎勵並追蹤收集狀態.'
L['options_claimed_rep_rewards'] = '在提示顯示已取得的聲望獎勵'
L['options_claimed_rep_rewards_desc'] = '在提示顯示已由你的戰隊取得的聲望獎勵.'

L['options_icons_misc_desc'] = '顯示其他節點的位置.'
L['options_icons_misc'] = '其他'
L['options_icons_pet_battles_desc'] = '顯示戰寵訓練師與NPC的位置.'
L['options_icons_pet_battles'] = '戰寵'
L['options_icons_rares_desc'] = '顯示稀有NPC的位置.'
L['options_icons_rares'] = '稀有'
L['options_icons_treasures_desc'] = '顯示隱藏寶藏的位置.'
L['options_icons_treasures'] = '寶藏'
L['options_icons_vendors_desc'] = '顯示軍需官的位置.'
L['options_icons_vendors'] = '軍需官'

------------------------------------ FOCUS ------------------------------------

L['options_focus_settings'] = '興趣點'
L['options_poi_color'] = '興趣點顏色'
L['options_poi_color_desc'] = '設定被設為專注的興趣點圖示顏色.'
L['options_path_color'] = '路徑顏色'
L['options_path_color_desc'] = '設定圖示被設為專注的路徑顏色.'
L['options_reset_poi_colors'] = '重置顏色'
L['options_reset_poi_colors_desc'] = '重置以上的顏色為預設值.'

----------------------------------- TOOLTIP -----------------------------------

L['options_tooltip_settings'] = '工具提示'
L['options_toggle_show_loot'] = '顯示戰利品'
L['options_toggle_show_loot_desc'] = '在工具提示中加入戰利品資訊'
L['options_toggle_show_notes'] = '顯示註記'
L['options_toggle_show_notes_desc'] = '在可用的工具提示中加入有用的註記'
L['options_toggle_use_standard_time'] = '使用12小時制'
L['options_toggle_use_standard_time_desc'] = '在提示使用12小時制 (例. 8:00 PM) 而不是24小時制 (例. 20:00).'
L['options_toggle_show_npc_id'] = '顯示 NPC ID'
L['options_toggle_show_npc_id_desc'] = '顯示用於稀有搜尋插件的 NPC ID.'

--------------------------------- DEVELOPMENT ---------------------------------

L['options_dev_settings'] = '開發'
L['options_toggle_show_debug_currency'] = '偵錯通貨ID'
L['options_toggle_show_debug_currency_desc'] = '顯示通貨的偵錯資訊 (需要重載)'
L['options_toggle_show_debug_map'] = '偵錯地圖ID'
L['options_toggle_show_debug_map_desc'] = '顯示地圖的偵錯資訊'
L['options_toggle_show_debug_quest'] = '偵錯任務ID'
L['options_toggle_show_debug_quest_desc'] = '顯示任務變換的偵錯資訊 (需要重載)'
L['options_toggle_force_nodes'] = '強制節點'
L['options_toggle_force_nodes_desc'] = '強制顯示全部節點'
