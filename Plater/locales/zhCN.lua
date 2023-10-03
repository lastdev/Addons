do
    local addonId = ...
    local languageTable = DetailsFramework.Language.RegisterLanguage(addonId, "zhCN")
    local L = languageTable

------------------------------------------------------------
L["HIGHLIGHT_HOVEROVER"] = "鼠标悬停高亮"
L["HIGHLIGHT_HOVEROVER_ALPHA"] = "鼠标悬停高亮透明度"
L["HIGHLIGHT_HOVEROVER_DESC"] = "鼠标放在姓名版上时的高亮效果."
L["OPTIONS_ALPHA"] = "透明度"
L["OPTIONS_ALPHABYFRAME_ALPHAMULTIPLIER"] = "透明度倍数."
L["OPTIONS_ALPHABYFRAME_DEFAULT"] = "整体透明度"
L["OPTIONS_ALPHABYFRAME_DEFAULT_DESC"] = "整体框架透明度."
L["OPTIONS_ALPHABYFRAME_ENABLE_ENEMIES"] = "为敌人启用"
L["OPTIONS_ALPHABYFRAME_ENABLE_ENEMIES_DESC"] = "对敌方单位应用透明度设置."
L["OPTIONS_ALPHABYFRAME_ENABLE_FRIENDLY"] = "为友方启用"
L["OPTIONS_ALPHABYFRAME_ENABLE_FRIENDLY_DESC"] = "对友方单位应用透明度设置. "
L["OPTIONS_ALPHABYFRAME_TARGET_INRANGE"] = "范围内/目标透明度"
L["OPTIONS_ALPHABYFRAME_TARGET_INRANGE_DESC"] = "目标和范围内单位的框架透明度."
L["OPTIONS_ALPHABYFRAME_TITLE_ENEMIES"] = "框架透明度 - 敌方"
L["OPTIONS_ALPHABYFRAME_TITLE_FRIENDLY"] = "框架透明度 - 友方"
L["OPTIONS_AMOUNT"] = "数值"
L["OPTIONS_ANCHOR"] = "锚点"
L["OPTIONS_ANCHOR_BOTTOM"] = "底部"
L["OPTIONS_ANCHOR_BOTTOMLEFT"] = "左下"
L["OPTIONS_ANCHOR_BOTTOMRIGHT"] = "右下"
L["OPTIONS_ANCHOR_CENTER"] = "居中"
L["OPTIONS_ANCHOR_INNERBOTTOM"] = "底部内侧"
L["OPTIONS_ANCHOR_INNERLEFT"] = "左边内侧"
L["OPTIONS_ANCHOR_INNERRIGHT"] = "右边内侧"
L["OPTIONS_ANCHOR_INNERTOP"] = "顶部内侧"
L["OPTIONS_ANCHOR_LEFT"] = "左侧"
L["OPTIONS_ANCHOR_RIGHT"] = "右侧"
L["OPTIONS_ANCHOR_TARGET_SIDE"] = "这个小组件附着在姓名版的哪一边."
L["OPTIONS_ANCHOR_TOP"] = "顶部"
L["OPTIONS_ANCHOR_TOPLEFT"] = "左上"
L["OPTIONS_ANCHOR_TOPRIGHT"] = "右上"
L["OPTIONS_AURA_DEBUFF_HEIGHT"] = "Debuff的图标高度."
L["OPTIONS_AURA_DEBUFF_WITH"] = "Debuff的图标宽度."
L["OPTIONS_AURA_HEIGHT"] = "Debuff的图标高度."
L["OPTIONS_AURA_SHOW_BUFFS"] = "个人条显示Buff"
L["OPTIONS_AURA_SHOW_BUFFS_DESC"] = "在你的个人条上显示Buff"
L["OPTIONS_AURA_SHOW_DEBUFFS"] = "个人条显示Debuff"
L["OPTIONS_AURA_SHOW_DEBUFFS_DESC"] = "在你的个人条上显示Debuff"
L["OPTIONS_AURA_WIDTH"] = "Debuff的图标宽度."
L["OPTIONS_AURAS_ENABLETEST"] = "启用此选项可隐藏配置时显示的测试光环."
L["OPTIONS_AURAS_SORT"] = "光环排序"
L["OPTIONS_AURAS_SORT_DESC"] = "按剩余时间排序 (默认)."
L["OPTIONS_BACKGROUND_ALWAYSSHOW"] = "总是显示背景"
L["OPTIONS_BACKGROUND_ALWAYSSHOW_DESC"] = "启用一个显示可点击区域的背景."
L["OPTIONS_BORDER_COLOR"] = "姓名板边框颜色"
L["OPTIONS_BORDER_THICKNESS"] = "姓名板边框厚度"
L["OPTIONS_BUFFFRAMES"] = "Buff框架"
L["OPTIONS_CANCEL"] = "取消"
L["OPTIONS_CAST_COLOR_CHANNELING"] = "引导施法条"
L["OPTIONS_CAST_COLOR_INTERRUPTED"] = "可打断施法条"
L["OPTIONS_CAST_COLOR_REGULAR"] = "常规施法条"
L["OPTIONS_CAST_COLOR_SUCCESS"] = "施法成功"
L["OPTIONS_CAST_COLOR_UNINTERRUPTIBLE"] = "无法打断施法条"
L["OPTIONS_CAST_SHOW_TARGETNAME"] = "显示目标名字"
L["OPTIONS_CAST_SHOW_TARGETNAME_DESC"] = "显示当前施法条的目标(如果目标存在)"
L["OPTIONS_CAST_SHOW_TARGETNAME_TANK"] = "[坦克] 不要显示你的名字"
L["OPTIONS_CAST_SHOW_TARGETNAME_TANK_DESC"] = "如果你是坦克, 当施法目标是你时不要显示名字."
L["OPTIONS_CASTBAR_FADE_ANIM_ENABLED"] = "使用渐变动画"
L["OPTIONS_CASTBAR_FADE_ANIM_ENABLED_DESC"] = "动画开始和结束有渐变效果."
L["OPTIONS_CASTBAR_FADE_ANIM_TIME_END"] = "淡出时间"
L["OPTIONS_CASTBAR_FADE_ANIM_TIME_END_DESC"] = "当施法结束, 这是施法条从100%透明度到完全不可见的时间."
L["OPTIONS_CASTBAR_FADE_ANIM_TIME_START"] = "淡入时间"
L["OPTIONS_CASTBAR_FADE_ANIM_TIME_START_DESC"] = "当施法开始时, 施法条从完全透明变为完全不透明所花费的时间."
L["OPTIONS_CASTBAR_HEIGHT"] = "施法条高度"
L["OPTIONS_CASTBAR_HIDE_ENEMY"] = "隐藏敌方施法条"
L["OPTIONS_CASTBAR_HIDE_FRIENDLY"] = "隐藏友方施法条"
L["OPTIONS_CASTBAR_HIDEBLIZZARD"] = "隐藏暴雪玩家施法条"
L["OPTIONS_CASTBAR_ICON_CUSTOM_ENABLE"] = "启用图标自定义"
L["OPTIONS_CASTBAR_ICON_CUSTOM_ENABLE_DESC"] = "如果这个选项被禁用, Plater就不会修改法术图标而是留给脚本来做."
L["OPTIONS_CASTBAR_NO_SPELLNAME_LIMIT"] = "不受法术名称长度限制"
L["OPTIONS_CASTBAR_NO_SPELLNAME_LIMIT_DESC"] = "法术名字的文本不会被切割成适合于施法条的宽度."
L["OPTIONS_CASTBAR_SPARK_HALF"] = "半火花"
L["OPTIONS_CASTBAR_SPARK_HALF_DESC"] = "火花纹理的一半."
L["OPTIONS_CASTBAR_SPARK_HIDE_INTERRUPT"] = "打断时隐藏火花"
L["OPTIONS_CASTBAR_TOGGLE_TEST"] = "施法条测试开关"
L["OPTIONS_CASTBAR_TOGGLE_TEST_DESC"] = "点一次开始测试, 再点一次停止."
L["OPTIONS_CASTBAR_WIDTH"] = "施法条宽度"
L["OPTIONS_CLICK_SPACE_HEIGHT"] = "接受鼠标点击以选择目标的区域的高度"
L["OPTIONS_CLICK_SPACE_WIDTH"] = "接受鼠标点击来选择目标的区域的宽度"
L["OPTIONS_COLOR"] = "颜色"
L["OPTIONS_COLOR_BACKGROUND"] = "施法条背景色"
L["OPTIONS_CVAR_ENABLE_PERSONAL_BAR"] = "个人生命条和法力条|cFFFF7700*|r"
L["OPTIONS_CVAR_ENABLE_PERSONAL_BAR_DESC"] = [=[在你的角色下显示一个迷你生命和法力条.
|cFFFF7700[*]|r |cFFa0a0a0CVar, 保存在Plater配置文件中并在加载配置文件时恢复.|r]=]
L["OPTIONS_CVAR_NAMEPLATES_ALWAYSSHOW"] = "始终显示姓名版|cFFFF7700*|r"
L["OPTIONS_CVAR_NAMEPLATES_ALWAYSSHOW_DESC"] = [=[始终显示附近所有单位的姓名版. 如果禁用则仅在战斗中才显示姓名版.
|cFFFF7700[*]|r |cFFa0a0a0CVar, 保存在Plater配置文件中并在加载配置文件时恢复.|r]=]
L["OPTIONS_ENABLED"] = "启用"
L["OPTIONS_ERROR_CVARMODIFY"] = "cvars参数无法在战斗中修改。"
L["OPTIONS_ERROR_EXPORTSTRINGERROR"] = "导出失败"
L["OPTIONS_EXECUTERANGE"] = "斩杀范围"
L["OPTIONS_EXECUTERANGE_DESC"] = "当单位处于斩杀区间的时候显示一个指示器."
L["OPTIONS_EXECUTERANGE_HIGH_HEALTH"] = "斩杀范围(高生命值)"
L["OPTIONS_EXECUTERANGE_HIGH_HEALTH_DESC"] = "当单位处于斩杀区间的时候显示一个指示器."
L["OPTIONS_FONT"] = "字体"
L["OPTIONS_FORMAT_NUMBER"] = "数字格式"
L["OPTIONS_FRIENDLY"] = "友方"
L["OPTIONS_GENERALSETTINGS_HEALTHBAR_ANCHOR_TITLE"] = "生命条外观"
L["OPTIONS_GENERALSETTINGS_HEALTHBAR_BGCOLOR"] = "生命条背景颜色和透明度"
L["OPTIONS_GENERALSETTINGS_HEALTHBAR_BGTEXTURE"] = "生命条背景材质"
L["OPTIONS_GENERALSETTINGS_HEALTHBAR_TEXTURE"] = "生命条材质"
L["OPTIONS_GENERALSETTINGS_TRANSPARENCY_ANCHOR_TITLE"] = "透明度控制"
L["OPTIONS_GENERALSETTINGS_TRANSPARENCY_RANGECHECK"] = "范围检查"
L["OPTIONS_GENERALSETTINGS_TRANSPARENCY_RANGECHECK_ALPHA"] = "超出范围之后的透明度"
L["OPTIONS_GENERALSETTINGS_TRANSPARENCY_RANGECHECK_SPEC_DESC"] = "适用于此专精的范围检测技能。"
L["OPTIONS_HEALTHBAR"] = "血条"
L["OPTIONS_HEALTHBAR_HEIGHT"] = "血条高度"
L["OPTIONS_HEALTHBAR_SIZE_GLOBAL_DESC"] = "改变战斗中和非战斗的玩家和NPC的敌方和友方姓名版的大小. 这些选项中的每一个都可以在敌对Npc, 敌对玩家选项卡上单独更改."
L["OPTIONS_HEALTHBAR_WIDTH"] = "血条宽度"
L["OPTIONS_HEIGHT"] = "高度"
L["OPTIONS_HOSTILE"] = "敌对"
L["OPTIONS_ICON_ELITE"] = "精英图标"
L["OPTIONS_ICON_ENEMYCLASS"] = "敌对职业图标"
L["OPTIONS_ICON_ENEMYFACTION"] = "敌对阵营图标"
L["OPTIONS_ICON_ENEMYSPEC"] = "敌方专精图标"
L["OPTIONS_ICON_FRIENDLY_SPEC"] = "友方专精图标"
L["OPTIONS_ICON_FRIENDLYCLASS"] = "友方职业"
L["OPTIONS_ICON_FRIENDLYFACTION"] = "友方阵营图标"
L["OPTIONS_ICON_PET"] = "宠物图标"
L["OPTIONS_ICON_QUEST"] = "任务图标"
L["OPTIONS_ICON_RARE"] = "稀有图标"
L["OPTIONS_ICON_SHOW"] = "显示图标"
L["OPTIONS_ICON_SIDE"] = "图标侧"
L["OPTIONS_ICON_SIZE"] = "图标大小"
L["OPTIONS_ICON_WORLDBOSS"] = "世界Boss图标"
L["OPTIONS_ICONROWSPACING"] = "图标行间距"
L["OPTIONS_ICONSPACING"] = "图标间距"
L["OPTIONS_INDICATORS"] = "指示器"
L["OPTIONS_INTERRUPT_FILLBAR"] = "打断时填充施法条"
L["OPTIONS_INTERRUPT_SHOW_ANIM"] = "播放打断动画"
L["OPTIONS_INTERRUPT_SHOW_AUTHOR"] = "显示打断者名字"
L["OPTIONS_MINOR_SCALE_DESC"] = "显示次要单位时略微调整血条的大小(默认情况下这些单位的血条较小)."
L["OPTIONS_MINOR_SCALE_HEIGHT"] = "次要单位高度比例"
L["OPTIONS_MINOR_SCALE_WIDTH"] = "次要单位宽度比例"
L["OPTIONS_MOVE_HORIZONTAL"] = "略微水平移动"
L["OPTIONS_MOVE_VERTICAL"] = "略微垂直移动"
L["OPTIONS_NAMEPLATE_HIDE_FRIENDLY_HEALTH"] = "隐藏友方生命条|cFFFF7700*|r"
L["OPTIONS_NAMEPLATE_HIDE_FRIENDLY_HEALTH_DESC"] = [=[在地下城和团本中如果启用了友方姓名版, 它将只显示玩家的名字.\n如果任何Plater模块被禁用这也将影响这些姓名版.
|cFFFF7700[*]|r |cFFa0a0a0CVar, 保存在Plater配置文件中并在加载配置文件时恢复.|r
|cFFa0a0a0A /reload后生效.|r]=]
L["OPTIONS_NAMEPLATE_OFFSET"] = "稍微调整整个姓名版"
--[[Translation missing --]]
L["OPTIONS_NAMEPLATE_SHOW_ENEMY"] = "Show Enemy Nameplates|cFFFF7700*|r"
--[[Translation missing --]]
L["OPTIONS_NAMEPLATE_SHOW_ENEMY_DESC"] = [=[Show nameplate for enemy and neutral units.

|cFFFF7700[*]|r |cFFa0a0a0CVar, saved within Plater profile and restored when loading the profile.|r]=]
--[[Translation missing --]]
L["OPTIONS_NAMEPLATE_SHOW_FRIENDLY"] = "Show Friendly Nameplates|cFFFF7700*|r"
--[[Translation missing --]]
L["OPTIONS_NAMEPLATE_SHOW_FRIENDLY_DESC"] = [=[Show nameplate for friendly players.

|cFFFF7700[*]|r |cFFa0a0a0CVar, saved within Plater profile and restored when loading the profile.|r]=]
--[[Translation missing --]]
L["OPTIONS_NAMEPLATES_OVERLAP"] = "Nameplate Overlap (V)|cFFFF7700*|r"
--[[Translation missing --]]
L["OPTIONS_NAMEPLATES_OVERLAP_DESC"] = [=[The space between each nameplate vertically when stacking is enabled.

|cFFFFFFFFDefault: 1.10|r

|cFFFF7700[*]|r |cFFa0a0a0CVar, saved within Plater profile and restored when loading the profile.|r

|cFFFFFF00Important |r: if you find issues with this setting, use:
|cFFFFFFFF/run SetCVar ('nameplateOverlapV', '1.6')|r]=]
L["OPTIONS_NAMEPLATES_STACKING"] = "叠堆姓名版|cFFFF7700*|r"
--[[Translation missing --]]
L["OPTIONS_NAMEPLATES_STACKING_DESC"] = [=[If enabled, nameplates won't overlap with each other.

|cFFFF7700[*]|r |cFFa0a0a0CVar, saved within Plater profile and restored when loading the profile.|r

|cFFFFFF00Important |r: to set the amount of space between each nameplate see '|cFFFFFFFFNameplate Vertical Padding|r' option below.
Please check the Auto tab settings to setup automatic toggling of this option.]=]
L["OPTIONS_NEUTRAL"] = "中立"
L["OPTIONS_NOCOMBATALPHA_AMOUNT_DESC"] = "应用'非战斗'特性所需要的透明度."
L["OPTIONS_NOCOMBATALPHA_ENABLED"] = "使用非战斗透明度"
L["OPTIONS_NOCOMBATALPHA_ENABLED_DESC"] = [=[当你在战斗中但单位没有时改变姓名版的透明度.

|cFFFFFF00 重要 |r: 如果单位不在战斗中, 它将覆盖范围检查的透明度.]=]
L["OPTIONS_NOESSENTIAL_DESC"] = "在更新 Plater 时,新版本通常也会从脚本选项页更新脚本. \\n这可能会覆盖配置文件创建者所做的更改. 下面的选项可防止 Plater 修改插件收到更新时的脚本。\\n\\n注意：Plater的主要补丁和错误修复仍可能会更新脚本"
L["OPTIONS_NOESSENTIAL_NAME"] = "在 Plater 版本升级期间禁用非必要的脚本更新."
L["OPTIONS_NOESSENTIAL_SKIP_ALERT"] = "跳过非必要的补丁:"
L["OPTIONS_NOESSENTIAL_TITLE"] = "跳过非必要的脚本Script补丁"
L["OPTIONS_OKAY"] = "确定"
L["OPTIONS_OUTLINE"] = "轮廓"
--[[Translation missing --]]
L["OPTIONS_PERSONAL_HEALTHBAR_HEIGHT"] = "Height of the health bar."
--[[Translation missing --]]
L["OPTIONS_PERSONAL_HEALTHBAR_WIDTH"] = "Width of the health bar."
--[[Translation missing --]]
L["OPTIONS_PERSONAL_SHOW_HEALTHBAR"] = "Show health bar."
--[[Translation missing --]]
L["OPTIONS_PET_SCALE_DESC"] = "Slightly adjust the size of nameplates when showing a pet"
--[[Translation missing --]]
L["OPTIONS_PET_SCALE_HEIGHT"] = "Pet Height Scale"
--[[Translation missing --]]
L["OPTIONS_PET_SCALE_WIDTH"] = "Pet Width Scale"
L["OPTIONS_PLEASEWAIT"] = "可能需要等待几秒钟..."
--[[Translation missing --]]
L["OPTIONS_POWERBAR"] = "Power Bar"
--[[Translation missing --]]
L["OPTIONS_POWERBAR_HEIGHT"] = "Height of the power bar."
--[[Translation missing --]]
L["OPTIONS_POWERBAR_WIDTH"] = "Width of the power bar."
L["OPTIONS_PROFILE_CONFIG_EXPORTINGTASK"] = "Plater正在导出当前配置......"
L["OPTIONS_PROFILE_CONFIG_EXPORTPROFILE"] = "导出配置"
L["OPTIONS_PROFILE_CONFIG_IMPORTPROFILE"] = "导入配置"
L["OPTIONS_PROFILE_CONFIG_MOREPROFILES"] = "在Wago.io上获取更多的配置"
L["OPTIONS_PROFILE_CONFIG_OPENSETTINGS"] = "打开配置设置"
L["OPTIONS_PROFILE_CONFIG_PROFILENAME"] = "新的配置名称"
L["OPTIONS_PROFILE_CONFIG_PROFILENAME_DESC"] = [=[使用导入的字符串创建新配置文件。

如果有相同名字的配置文件，将会被覆盖。]=]
L["OPTIONS_PROFILE_ERROR_PROFILENAME"] = "配置名称无效"
L["OPTIONS_PROFILE_ERROR_STRINGINVALID"] = "无效的配置文件。"
L["OPTIONS_PROFILE_ERROR_WRONGTAB"] = [=[无效的配置文件.

在脚本或模组选项页面导入脚本或者模组的字符串.]=]
L["OPTIONS_PROFILE_IMPORT_OVERWRITE"] = "配置 '%s' 已经存在, 确定要覆盖吗?"
--[[Translation missing --]]
L["OPTIONS_RANGECHECK_NONE"] = "Nothing"
--[[Translation missing --]]
L["OPTIONS_RANGECHECK_NONE_DESC"] = "No alpha modifications is applyed."
--[[Translation missing --]]
L["OPTIONS_RANGECHECK_NOTMYTARGET"] = "Units Which Isn't Your Target"
--[[Translation missing --]]
L["OPTIONS_RANGECHECK_NOTMYTARGET_DESC"] = "When a nameplate isn't your current target, alpha is reduced."
--[[Translation missing --]]
L["OPTIONS_RANGECHECK_NOTMYTARGETOUTOFRANGE"] = "Out of Range + Isn't Your Target"
--[[Translation missing --]]
L["OPTIONS_RANGECHECK_NOTMYTARGETOUTOFRANGE_DESC"] = [=[Reduces the alpha of units which isn't your target.
Reduces even more if the unit is out of range.]=]
--[[Translation missing --]]
L["OPTIONS_RANGECHECK_OUTOFRANGE"] = "Units Out of Your Range"
--[[Translation missing --]]
L["OPTIONS_RANGECHECK_OUTOFRANGE_DESC"] = "When a nameplate is out of range, alpha is reduced."
--[[Translation missing --]]
L["OPTIONS_RESOURCES_TARGET"] = "Show Resources on Target"
--[[Translation missing --]]
L["OPTIONS_RESOURCES_TARGET_DESC"] = [=[Shows your resource such as combo points above your current target.
Uses Blizzard default resources and disables Platers own resources.

Character specific setting!]=]
L["OPTIONS_SCALE"] = "缩放"
--[[Translation missing --]]
L["OPTIONS_SCRIPTING_REAPPLY"] = "Re-Apply Default Values"
L["OPTIONS_SETTINGS_COPIED"] = "设置已经拷贝"
L["OPTIONS_SETTINGS_FAIL_COPIED"] = "从当前选择的标签页获取设置失败"
L["OPTIONS_SHADOWCOLOR"] = "阴影颜色"
--[[Translation missing --]]
L["OPTIONS_SHIELD_BAR"] = "Shield Bar"
--[[Translation missing --]]
L["OPTIONS_SHOW_CASTBAR"] = "Show cast bar"
--[[Translation missing --]]
L["OPTIONS_SHOW_POWERBAR"] = "Show power bar"
--[[Translation missing --]]
L["OPTIONS_SHOWTOOLTIP"] = "Show Tooltip"
--[[Translation missing --]]
L["OPTIONS_SHOWTOOLTIP_DESC"] = "Show tooltip when hovering over the aura icon."
L["OPTIONS_SIZE"] = "大小"
--[[Translation missing --]]
L["OPTIONS_STACK_AURATIME"] = "Show shortest time of stacked auras"
--[[Translation missing --]]
L["OPTIONS_STACK_AURATIME_DESC"] = "Show shortest time of stacked auras or the longes time, when disabled."
--[[Translation missing --]]
L["OPTIONS_STACK_SIMILAR_AURAS"] = "Stack Similar Auras"
--[[Translation missing --]]
L["OPTIONS_STACK_SIMILAR_AURAS_DESC"] = "Auras with the same name (e.g. warlock's unstable affliction debuff) get stacked together."
L["OPTIONS_STATUSBAR_TEXT"] = "你现在能够从|cFFFFAA00http://wago.io|r导入配置文件，模组，脚本，动画和颜色表。"
L["OPTIONS_TABNAME_ADVANCED"] = "高级配置"
L["OPTIONS_TABNAME_ANIMATIONS"] = "动画面板"
L["OPTIONS_TABNAME_AUTO"] = "自动选项"
L["OPTIONS_TABNAME_BUFF_LIST"] = "BUFF 列表"
L["OPTIONS_TABNAME_BUFF_SETTINGS"] = "BUFF 设置"
L["OPTIONS_TABNAME_BUFF_SPECIAL"] = "BUFF 特殊"
L["OPTIONS_TABNAME_BUFF_TRACKING"] = "BUFF 跟踪"
L["OPTIONS_TABNAME_CASTBAR"] = "施法条"
L["OPTIONS_TABNAME_CASTCOLORS"] = "施法颜色和名称 "
L["OPTIONS_TABNAME_COMBOPOINTS"] = "连击点"
L["OPTIONS_TABNAME_GENERALSETTINGS"] = "常规设置"
L["OPTIONS_TABNAME_MODDING"] = "模组"
L["OPTIONS_TABNAME_NPC_COLORNAME"] = "NPC颜色和名称"
L["OPTIONS_TABNAME_NPCENEMY"] = "敌对怪物/NPC"
L["OPTIONS_TABNAME_NPCFRIENDLY"] = "友方怪物/NPC"
L["OPTIONS_TABNAME_PERSONAL"] = "个人条"
L["OPTIONS_TABNAME_PLAYERENEMY"] = "敌对玩家"
L["OPTIONS_TABNAME_PLAYERFRIENDLY"] = "友方玩家"
L["OPTIONS_TABNAME_PROFILES"] = "配置文件"
L["OPTIONS_TABNAME_SCRIPTING"] = "脚本"
L["OPTIONS_TABNAME_SEARCH"] = "搜索"
L["OPTIONS_TABNAME_STRATA"] = "层级&层次"
L["OPTIONS_TABNAME_TARGET"] = "目标"
L["OPTIONS_TABNAME_THREAT"] = "仇恨颜色"
L["OPTIONS_TEXT_COLOR"] = "文字颜色."
L["OPTIONS_TEXT_FONT"] = "文字字体."
L["OPTIONS_TEXT_SIZE"] = "文字大小."
L["OPTIONS_TEXTURE"] = "材质"
L["OPTIONS_TEXTURE_BACKGROUND"] = "施法条背景材质"
L["OPTIONS_THREAT_AGGROSTATE_ANOTHERTANK"] = "[坦克] 仇恨在副坦上"
L["OPTIONS_THREAT_AGGROSTATE_HIGHTHREAT"] = "[输出 / 治疗] 高威胁"
L["OPTIONS_THREAT_AGGROSTATE_NOAGGRO"] = "丢失仇恨"
L["OPTIONS_THREAT_AGGROSTATE_NOTANK"] = "[输出 / 治疗] 无坦克仇恨"
L["OPTIONS_THREAT_AGGROSTATE_NOTINCOMBAT"] = "[坦克] 没进战斗"
L["OPTIONS_THREAT_AGGROSTATE_ONYOU_LOWAGGRO"] = "[坦克] 仇恨降低"
L["OPTIONS_THREAT_AGGROSTATE_ONYOU_LOWAGGRO_DESC"] = "该单位正在攻击你，但其他人的仇恨即将超过你。"
L["OPTIONS_THREAT_AGGROSTATE_ONYOU_SOLID"] = "仇恨在你身上"
L["OPTIONS_THREAT_AGGROSTATE_TAPPED"] = "丢失拾取权(灰怪)"
L["OPTIONS_THREAT_CLASSIC_USE_TANK_COLORS"] = "使用坦克仇恨颜色"
L["OPTIONS_THREAT_COLOR_DPS_ANCHOR_TITLE"] = "仇恨颜色[输出/治疗]"
L["OPTIONS_THREAT_COLOR_DPS_HIGHTHREAT_DESC"] = "该单位将要开始攻击你。"
L["OPTIONS_THREAT_COLOR_DPS_NOAGGRO_DESC"] = "该单位没有攻击你。"
L["OPTIONS_THREAT_COLOR_DPS_NOTANK_DESC"] = "该单位没有攻击你或者坦克，应该正在攻击你队伍或团队中的治疗或者输出。"
L["OPTIONS_THREAT_COLOR_DPS_ONYOU_SOLID_DESC"] = "该单位在攻击你"
L["OPTIONS_THREAT_COLOR_OVERRIDE_ANCHOR_TITLE"] = "覆盖默认的颜色"
L["OPTIONS_THREAT_COLOR_OVERRIDE_DESC"] = [=[修改默认的中立，敌对和友方的颜色。

在战斗中，如果使用仇恨血条颜色，那么这些颜色也同样会被覆盖。]=]
L["OPTIONS_THREAT_COLOR_TANK_ANCHOR_TITLE"] = "仇恨颜色[坦克]"
L["OPTIONS_THREAT_COLOR_TANK_ANOTHERTANK_DESC"] = "该单位被队伍中的其他坦克拉住了。"
L["OPTIONS_THREAT_COLOR_TANK_NOAGGRO_DESC"] = "该单位对你没有仇恨。"
L["OPTIONS_THREAT_COLOR_TANK_NOTINCOMBAT_DESC"] = "该单位没有在战斗中。"
L["OPTIONS_THREAT_COLOR_TANK_ONYOU_SOLID_DESC"] = "该单位正在攻击你，你的仇恨很稳定。"
L["OPTIONS_THREAT_COLOR_TAPPED_DESC"] = "其他人先摸了怪（也就是这个怪死了你是无法摸尸体的）。"
L["OPTIONS_THREAT_DPS_CANCHECKNOTANK"] = "没有坦克仇恨时的检查"
L["OPTIONS_THREAT_DPS_CANCHECKNOTANK_DESC"] = "作为输出或者治疗没有仇恨时，检查该单位是否正在攻击队伍或团队中另一个不是坦克的玩家。"
L["OPTIONS_THREAT_MODIFIERS_ANCHOR_TITLE"] = "仇恨颜色修改"
L["OPTIONS_THREAT_MODIFIERS_BORDERCOLOR"] = "边框颜色"
L["OPTIONS_THREAT_MODIFIERS_HEALTHBARCOLOR"] = "血条颜色"
L["OPTIONS_THREAT_MODIFIERS_NAMECOLOR"] = "姓名颜色"
--[[Translation missing --]]
L["OPTIONS_THREAT_PULL_FROM_ANOTHER_TANK"] = "Pulling From Another Tank"
--[[Translation missing --]]
L["OPTIONS_THREAT_PULL_FROM_ANOTHER_TANK_TANK"] = "The unit has aggro on another tank and you're about to pull it."
--[[Translation missing --]]
L["OPTIONS_THREAT_USE_AGGRO_FLASH"] = "Enable aggro flash"
--[[Translation missing --]]
L["OPTIONS_THREAT_USE_AGGRO_FLASH_DESC"] = "Enables the -AGGRO- flash animation on the nameplates when gaining aggro as dps."
--[[Translation missing --]]
L["OPTIONS_THREAT_USE_AGGRO_GLOW"] = "Enable aggro glow"
--[[Translation missing --]]
L["OPTIONS_THREAT_USE_AGGRO_GLOW_DESC"] = "Enables the healthbar glow on the nameplates when gaining aggro as dps or losing aggro as tank."
--[[Translation missing --]]
L["OPTIONS_THREAT_USE_SOLO_COLOR"] = "Solo Color"
--[[Translation missing --]]
L["OPTIONS_THREAT_USE_SOLO_COLOR_DESC"] = "Use the 'Solo' color when not in a group."
--[[Translation missing --]]
L["OPTIONS_THREAT_USE_SOLO_COLOR_ENABLE"] = "Use 'Solo' color"
--[[Translation missing --]]
L["OPTIONS_TOGGLE_TO_CHANGE"] = "|cFFFFFF00 Important |r: hide and show nameplates to see changes."
L["OPTIONS_WIDTH"] = "宽度"
L["OPTIONS_XOFFSET"] = "X 偏移"
L["OPTIONS_XOFFSET_DESC"] = [=[调整X轴上的位置.
右键输入数值.]=]
L["OPTIONS_YOFFSET"] = "Y 偏移"
L["OPTIONS_YOFFSET_DESC"] = [=[调整Y轴上的位置.
右键输入数值.]=]
--[[Translation missing --]]
L["TARGET_CVAR_ALWAYSONSCREEN"] = "Target Always on the Screen|cFFFF7700*|r"
--[[Translation missing --]]
L["TARGET_CVAR_ALWAYSONSCREEN_DESC"] = [=[When enabled, the nameplate of your target is always shown even when the enemy isn't in the screen.

|cFFFF7700[*]|r |cFFa0a0a0CVar, saved within Plater profile and restored when loading the profile.|r]=]
--[[Translation missing --]]
L["TARGET_CVAR_LOCKTOSCREEN"] = "Lock to Screen (Top Side)|cFFFF7700*|r"
--[[Translation missing --]]
L["TARGET_CVAR_LOCKTOSCREEN_DESC"] = [=[Min space between the nameplate and the top of the screen. Increase this if some part of the nameplate are going out of the screen.

|cFFFFFFFFDefault: 0.065|r

|cFFFFFF00 Important |r: if you're having issue, manually set using these macros:
/run SetCVar ('nameplateOtherTopInset', '0.065')
/run SetCVar ('nameplateLargeTopInset', '0.065')

|cFFFFFF00 Important |r: setting to 0 disables this feature.

|cFFFF7700[*]|r |cFFa0a0a0CVar, saved within Plater profile and restored when loading the profile.|r]=]
L["TARGET_HIGHLIGHT"] = "目标高亮"
L["TARGET_HIGHLIGHT_ALPHA"] = "目标高亮透明度"
L["TARGET_HIGHLIGHT_COLOR"] = "目标高亮颜色"
L["TARGET_HIGHLIGHT_DESC"] = "当前目标的姓名版上的高亮效果."
L["TARGET_HIGHLIGHT_SIZE"] = "目标高亮大小"
L["TARGET_HIGHLIGHT_TEXTURE"] = "目标高亮材质"
L["TARGET_OVERLAY_ALPHA"] = "目标血条透明度"
L["TARGET_OVERLAY_TEXTURE"] = "目标血条材质"
L["TARGET_OVERLAY_TEXTURE_DESC"] = "在当前目标的血条上使用."

end