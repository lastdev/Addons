-- Chinese sim by CWDG 月色狼影
-- CWDG site: http://Cwowaddon.com

-------------
-- CHINESE --
-------------

if (GetLocale() == "zhCN") then

-------------------
-- Compatibility --
-------------------

HEALBOT_DRUID   = "德鲁伊";
HEALBOT_HUNTER  = "猎人";
HEALBOT_MAGE    = "法师";
HEALBOT_PALADIN = "圣骑士";
HEALBOT_PRIEST  = "牧师";
HEALBOT_ROGUE   = "潜行者";
HEALBOT_SHAMAN  = "萨满祭司";
HEALBOT_WARLOCK = "术士";
HEALBOT_WARRIOR = "战士";
HEALBOT_DEATHKNIGHT = "死亡骑士";

HEALBOT_DISEASE            = "疾病";
HEALBOT_MAGIC              = "魔法";
HEALBOT_CURSE              = "诅咒";
HEALBOT_POISON             = "中毒";

HEALBOT_DEBUFF_ANCIENT_HYSTERIA = "上古狂乱";
HEALBOT_DEBUFF_IGNITE_MANA      = "点燃法力";
HEALBOT_DEBUFF_TAINTED_MIND     = "污浊之魂";
HEALBOT_DEBUFF_VIPER_STING      = "蝰蛇钉刺";
HEALBOT_DEBUFF_SILENCE          = "沉默";
HEALBOT_DEBUFF_MAGMA_SHACKLES   = "熔岩镣铐";
HEALBOT_DEBUFF_FROSTBOLT        = "冰霜箭";
HEALBOT_DEBUFF_HUNTERS_MARK     = "猎人印记";
HEALBOT_DEBUFF_SLOW             = "减速术";
HEALBOT_DEBUFF_ARCANE_BLAST     = "奥术冲击";
HEALBOT_DEBUFF_IMPOTENCE        = "无力诅咒";--tbc spell
HEALBOT_DEBUFF_DECAYED_STR      = "力量衰减";
HEALBOT_DEBUFF_DECAYED_INT      = "智力衰减";--tbc Decayed Intellect
HEALBOT_DEBUFF_CRIPPLE          = "残废术";
HEALBOT_DEBUFF_CHILLED          = "冰冻";
HEALBOT_DEBUFF_CONEOFCOLD       = "冰锥术";
HEALBOT_DEBUFF_CONCUSSIVESHOT   = "震荡射击";
HEALBOT_DEBUFF_THUNDERCLAP      = "雷霆一击";
HEALBOT_DEBUFF_HOWLINGSCREECH   = "尖啸";--tbc
HEALBOT_DEBUFF_DAZED            = "眩晕";
HEALBOT_DEBUFF_UNSTABLE_AFFL    = "痛苦无常";--tbc
HEALBOT_DEBUFF_DREAMLESS_SLEEP  = "无梦睡眠";
HEALBOT_DEBUFF_GREATER_DREAMLESS = "强效昏睡";
HEALBOT_DEBUFF_MAJOR_DREAMLESS  = "特效无梦睡眠";--tbc
HEALBOT_DEBUFF_FROST_SHOCK      = "冰霜震击"
HEALBOT_DEBUFF_WEAKENED_SOUL    = GetSpellInfo(6788)

HEALBOT_RANK_1              = "(等级 1)";
HEALBOT_RANK_2              = "(等级 2)";
HEALBOT_RANK_3              = "(等级 3)";
HEALBOT_RANK_4              = "(等级 4)";
HEALBOT_RANK_5              = "(等级 5)";
HEALBOT_RANK_6              = "(等级 6)";
HEALBOT_RANK_7              = "(等级 7)";
HEALBOT_RANK_8              = "(等级 8)";
HEALBOT_RANK_9              = "(等级 9)";
HEALBOT_RANK_10             = "(等级 10)";
HEALBOT_RANK_11             = "(等级 11)";
HEALBOT_RANK_12             = "(等级 12)";
HEALBOT_RANK_13             = "(等级 13)";
HEALBOT_RANK_14             = "(等级 14)";
HEALBOT_RANK_15             = "(等级 15)";
HEALBOT_RANK_16             = "(等级 16)";
HEALBOT_RANK_17             = "(等级 17)";
HEALBOT_RANK_18             = "(等级 18)";

HB_SPELL_PATTERN_LESSER_HEAL         = "治疗目标，恢复(%d+)到(%d+)点生命值";
HB_SPELL_PATTERN_HEAL                = "治疗目标，恢复(%d+)到(%d+)点生命值";
HB_SPELL_PATTERN_GREATER_HEAL        = "施法缓慢的法术，可以为单一目标治疗(%d+)到(%d+)点伤害";
HB_SPELL_PATTERN_FLASH_HEAL          = "治疗友方目标，恢复(%d+)到(%d+)点生命值";
HB_SPELL_PATTERN_RENEW               = "治疗目标，在(%d+)秒内恢复总计(%d+)到(%d+)点生命值";
HB_SPELL_PATTERN_RENEW1              = "治疗目标，在(%d+)秒内恢复总计(%d+)到(%d+)点生命值";
HB_SPELL_PATTERN_RENEW2              = "Not needed for en";
HB_SPELL_PATTERN_RENEW3              = "Not needed for en";
HB_SPELL_PATTERN_SHIELD              = "可吸收(%d+)点伤害，持续(%d+)秒。";
HB_SPELL_PATTERN_HEALING_TOUCH       = "治疗友方目标，恢复(%d+)到(%d+)点生命值";
HB_SPELL_PATTERN_REGROWTH            = "治疗友方目标，恢复(%d+)到(%d+)点生命值，并在(%d+)秒内恢复额外的(%d+)点生命值";
HB_SPELL_PATTERN_REGROWTH1           = "Heals a friendly target for (%d+) to (%d+) and another (%d+) to (%d+) over (%d+) sec";
HB_SPELL_PATTERN_HOLY_LIGHT          = "治疗友方目标，恢复(%d+)到(%d+)点生命值";
HB_SPELL_PATTERN_FLASH_OF_LIGHT      = "治疗友方目标，恢复(%d+)到(%d+)点生命值";
HB_SPELL_PATTERN_HEALING_WAVE        = "治疗友方目标，恢复(%d+)到(%d+)点生命值";--check
HB_SPELL_PATTERN_LESSER_HEALING_WAVE = "治疗友方目标，恢复(%d+)到(%d+)点生命值";
HB_SPELL_PATTERN_REJUVENATION        = "治疗目标，在(%d+)秒内恢复总计(%d+)点生命值";
HB_SPELL_PATTERN_REJUVENATION1       = "Heals the target for (%d+) to (%d+) over (%d+) sec";
HB_SPELL_PATTERN_REJUVENATION2       = "Not needed for en";
HB_SPELL_PATTERN_MEND_PET            = "集中注意力为宠物治疗，在(%d+)秒内为其恢复(%d+)点生命值";

HB_TOOLTIP_MANA                    = "^(%d+)法力值$";
HB_TOOLTIP_RANGE                   = "(%d+)码距离";
HB_TOOLTIP_INSTANT_CAST            = "瞬发法术";
HB_TOOLTIP_CAST_TIME               = "(%d+.?%d*)秒施法时间";
HB_TOOLTIP_CHANNELED               = "需引导";
HB_TOOLTIP_OFFLINE                 = "离线";
HB_OFFLINE                			   = "离线"; -- has gone offline msg
HB_ONLINE                				   = "在线"; -- has come online msg
HB_HASLEFTRAID                     = "^([^%s]+)离开了团队。";
HB_HASLEFTPARTY                    = "^([^%s]+)离开了队伍。";
HB_YOULEAVETHEGROUP                = "你离开了队伍。"
HB_YOULEAVETHERAID                 = "你已经离开了这个团队。"
HB_YOUJOINTHERAID                  = "你加入了一个团队。"
HB_YOUJOINTHEGROUP                 = "你加入了队伍。"

-----------------
-- Translation --
-----------------

HEALBOT_ADDON = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED = "";


HEALBOT_ACTION_OPTIONS    = "设置";

HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS      = "预设";
HEALBOT_OPTIONS_CLOSE         = "关闭";
HEALBOT_OPTIONS_HARDRESET     = "重载界面"
HEALBOT_OPTIONS_SOFTRESET     = "重载HealBot"
HEALBOT_OPTIONS_INFO          = "信息"
HEALBOT_OPTIONS_TAB_GENERAL   = "综合";
HEALBOT_OPTIONS_TAB_SPELLS    = "法术";
HEALBOT_OPTIONS_TAB_HEALING   = "治疗";
HEALBOT_OPTIONS_TAB_CDC       = "驱散";--curse
HEALBOT_OPTIONS_TAB_SKIN      = "样式";
HEALBOT_OPTIONS_TAB_TIPS      = "提示";
HEALBOT_OPTIONS_TAB_BUFFS     = "增益"

HEALBOT_OPTIONS_PANEL_TEXT    = "治疗面板设置"
HEALBOT_OPTIONS_BARALPHA      = "样式条透明度";
HEALBOT_OPTIONS_BARALPHAINHEAL= "进入治疗状态时透明度";
HEALBOT_OPTIONS_BARALPHAEOR   = "超出范围透明度";
HEALBOT_OPTIONS_ACTIONLOCKED  = "锁定";
HEALBOT_OPTIONS_AUTOSHOW      = "关闭自动显示";
HEALBOT_OPTIONS_PANELSOUNDS   = "使用声音提示";
HEALBOT_OPTIONS_HIDEOPTIONS   = "隐藏设置按钮";
HEALBOT_OPTIONS_PROTECTPVP    = "防止意外进入PVP状态";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "聊天设置";

HEALBOT_OPTIONS_SKINTEXT      = "样式"
HEALBOT_SKINS_STD             = "标准"
HEALBOT_OPTIONS_SKINTEXTURE   = "材质"
HEALBOT_OPTIONS_SKINHEIGHT    = "高度"
HEALBOT_OPTIONS_SKINWIDTH     = "宽度"
HEALBOT_OPTIONS_SKINNUMCOLS   = "每列显示小组数量"
HEALBOT_OPTIONS_SKINNUMHCOLS  = "编号显示标题头"
HEALBOT_OPTIONS_SKINBRSPACE   = "横向间隔"
HEALBOT_OPTIONS_SKINBCSPACE   = "纵向间隔"
HEALBOT_OPTIONS_EXTRASORT     = "排列方式"
HEALBOT_SORTBY_NAME           = "名称"
HEALBOT_SORTBY_CLASS          = "职业"
HEALBOT_SORTBY_GROUP          = "队伍"
HEALBOT_SORTBY_MAXHEALTH      = "最大生命值"
HEALBOT_OPTIONS_NEWDEBUFFTEXT = "新Debuff"
HEALBOT_OPTIONS_DELSKIN       = "删除"
HEALBOT_OPTIONS_NEWSKINTEXT   = "新皮肤"
HEALBOT_OPTIONS_SAVESKIN      = "保存"
HEALBOT_OPTIONS_SKINBARS      = "样式条设置"
HEALBOT_OPTIONS_SKINPANEL     = "面板风格"
HEALBOT_SKIN_ENTEXT           = "启用"
HEALBOT_SKIN_DISTEXT          = "禁用"
HEALBOT_SKIN_DEBTEXT          = "Debuff"
HEALBOT_SKIN_BACKTEXT         = "背景颜色"
HEALBOT_SKIN_BORDERTEXT       = "边框颜色"
HEALBOT_OPTIONS_SKINFONT   		= "字体"
HEALBOT_OPTIONS_SKINFHEIGHT   = "字体尺寸"
HEALBOT_OPTIONS_BARALPHADIS   = "禁用透明度"
HEALBOT_OPTIONS_SHOWHEADERS   = "显示标题头"

HEALBOT_OPTIONS_ITEMS  = "物品";
HEALBOT_OPTIONS_SPELLS = "法术";

HEALBOT_OPTIONS_COMBOCLASS    = "组合键设置";
HEALBOT_OPTIONS_CLICK         = "点击";
HEALBOT_OPTIONS_SHIFT         = "Shift";
HEALBOT_OPTIONS_CTRL          = "Ctrl";
HEALBOT_OPTIONS_ENABLEHEALTHY = "总是使用已启用的设置";

HEALBOT_OPTIONS_CASTNOTIFY1   = "无信息";
HEALBOT_OPTIONS_CASTNOTIFY2   = "通知自己";
HEALBOT_OPTIONS_CASTNOTIFY3   = "通知目标";
HEALBOT_OPTIONS_CASTNOTIFY4   = "通知队伍";
HEALBOT_OPTIONS_CASTNOTIFY5   = "通知团队";
HEALBOT_OPTIONS_CASTNOTIFY6   = "通知频道";
HEALBOT_OPTIONS_CASTNOTIFYRESONLY = "只在复活目标发出信息";
HEALBOT_OPTIONS_TARGETWHISPER = "治疗时密语目标";

HEALBOT_OPTIONS_CDCBARS       = "Debuff颜色设置";
HEALBOT_OPTIONS_CDCSHOWHBARS  = "显示生命条";
HEALBOT_OPTIONS_CDCSHOWABARS  = "显示仇恨条";
HEALBOT_OPTIONS_CDCCLASS      = "监视职业";
HEALBOT_OPTIONS_CDCWARNINGS   = "Debuff警报";
HEALBOT_OPTIONS_SHOWDEBUFFICON = "显示debuff图标";
HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "有debuff时显示警告";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "有debuff时声音提示";
HEALBOT_OPTIONS_SOUND         = "声音"
HEALBOT_OPTIONS_SOUND1        = "声音 1"
HEALBOT_OPTIONS_SOUND2        = "声音 2"
HEALBOT_OPTIONS_SOUND3        = "声音 3"

HEALBOT_OPTIONS_HEAL_BUTTONS  = "治疗按钮:";
HEALBOT_OPTIONS_SELFHEALS     = "自我"
HEALBOT_OPTIONS_PETHEALS      = "宠物"
HEALBOT_OPTIONS_GROUPHEALS    = "小队";
HEALBOT_OPTIONS_TANKHEALS     = "MT";
HEALBOT_OPTIONS_TARGETHEALS   = "目标";
HEALBOT_OPTIONS_EMERGENCYHEALS= "额外";
HEALBOT_OPTIONS_ALERTLEVEL    = "OT警报等级设置";
HEALBOT_OPTIONS_EMERGFILTER   = "设置团队框架";
HEALBOT_OPTIONS_EMERGFCLASS   = "设置职业";
HEALBOT_OPTIONS_COMBOBUTTON   = "按钮";
HEALBOT_OPTIONS_BUTTONLEFT    = "左";
HEALBOT_OPTIONS_BUTTONMIDDLE  = "中";
HEALBOT_OPTIONS_BUTTONRIGHT   = "右";
HEALBOT_OPTIONS_BUTTON4       = "按钮4";
HEALBOT_OPTIONS_BUTTON5       = "按钮5";

HEALBOT_CLASSES_ALL     = "所有职业";
HEALBOT_CLASSES_MELEE   = "近战";
HEALBOT_CLASSES_RANGES  = "远程";
HEALBOT_CLASSES_HEALERS = "治疗";
HEALBOT_CLASSES_CUSTOM  = "定制";

HEALBOT_OPTIONS_SHOWTOOLTIP     = "显示提示";
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "显示详细法术信息";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "显示目标信息";
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "显示治疗结束时间的建议";
HEALBOT_OPTIONS_SHOWPDCTOOLTIP  = "显示说明信息";--check
HEALBOT_TOOLTIP_POSDEFAULT      = "本地预设";
HEALBOT_TOOLTIP_POSLEFT         = "Healbot左边";
HEALBOT_TOOLTIP_POSRIGHT        = "Healbot右边";
HEALBOT_TOOLTIP_POSABOVE        = "Healbot上部";
HEALBOT_TOOLTIP_POSBELOW        = "Healbot下部";
HEALBOT_TOOLTIP_POSCURSOR       = "随鼠标指针";
HEALBOT_TOOLTIP_RECOMMENDTEXT   = "治疗结束时间的建议";
HEALBOT_TOOLTIP_NONE            = "无可用";
HEALBOT_TOOLTIP_ITEMBONUS       = "物品奖励";
HEALBOT_TOOLTIP_ACTUALBONUS     = "目前奖励是";
HEALBOT_TOOLTIP_SHIELD          = "治疗";
HEALBOT_TOOLTIP_LOCATION        = "位置";
HEALBOT_TOOLTIP_CORPSE          = "Corpse of ";
HEALBOT_WORDS_OVER              = "持续时间";
HEALBOT_WORDS_SEC               = "秒";
HEALBOT_WORDS_TO                = "到";
HEALBOT_WORDS_CAST              = "施放时间";
HEALBOT_WORDS_FOR               = "为";
HEALBOT_WORDS_UNKNOWN           = "未知";
HEALBOT_WORDS_YES               = "是";
HEALBOT_WORDS_NO                = "否";

HEALBOT_WORDS_NONE              = "空";
HEALBOT_OPTIONS_ALT             = "Alt";
HEALBOT_DISABLED_TARGET         = "TARGET";
HEALBOT_OPTIONS_SHOWCLASSONBAR  = "显示职业名称";
HEALBOT_OPTIONS_SHOWHEALTHONBAR = "显示生命";
HEALBOT_OPTIONS_BARHEALTHINCHEALS = "包含进入治疗";
HEALBOT_OPTIONS_BARHEALTH1      = "详细数值";
HEALBOT_OPTIONS_BARHEALTH2      = "百分比";
HEALBOT_OPTIONS_TIPTEXT         = "提示信息";
HEALBOT_OPTIONS_BARINFOTEXT     = "样式条信息";
HEALBOT_OPTIONS_POSTOOLTIP      = "启用提示";
HEALBOT_OPTIONS_SHOWNAMEONBAR   = "显示玩家名";
HEALBOT_OPTIONS_BARCLASSCOLOUR	= "样式条按职业着色";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "玩家名着色";
HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "包含小队";

HEALBOT_ONE   = "1";
HEALBOT_TWO   = "2";
HEALBOT_THREE = "3";
HEALBOT_FOUR  = "4";
HEALBOT_FIVE  = "5";
HEALBOT_SIX   = "6";
HEALBOT_SEVEN = "7";
HEALBOT_EIGHT = "8";

HEALBOT_OPTIONS_SETDEFAULTS    = "设置默认";
HEALBOT_OPTIONS_SETDEFAULTSMSG = "恢复所有设置为默认值";
HEALBOT_OPTIONS_RIGHTBOPTIONS  = "右击图标打开设置面板";

HEALBOT_OPTIONS_HEADEROPTTEXT  = "标题头设置";
HEALBOT_OPTIONS_ICONOPTTEXT    = "图标设定";
HEALBOT_SKIN_HEADERBARCOL      = "样式条颜色";
HEALBOT_SKIN_HEADERTEXTCOL     = "字体颜色";
HEALBOT_OPTIONS_BUFFSTEXT1      = "设置施放buff的技能";
HEALBOT_OPTIONS_BUFFSTEXT2      = "检查范围";
HEALBOT_OPTIONS_BUFFSTEXT3      = "样式条颜色";
HEALBOT_OPTIONS_BUFF           = "Buff ";
HEALBOT_OPTIONS_BUFFSELF       = "对自身";
HEALBOT_OPTIONS_BUFFPARTY      = "对队伍";
HEALBOT_OPTIONS_BUFFRAID       = "对团队";
HEALBOT_OPTIONS_MONITORBUFFS   = "监测缺少BUFF";
HEALBOT_OPTIONS_MONITORBUFFSC  = "战斗中同样监测";
HEALBOT_OPTIONS_ENABLESMARTCAST  = "当结束战斗启用SmartCast";
HEALBOT_OPTIONS_SMARTCASTSPELLS  = "包含法术";
HEALBOT_OPTIONS_SMARTCASTDISPELL = "解除debuff";
HEALBOT_OPTIONS_SMARTCASTBUFF    = "增加buff";
HEALBOT_OPTIONS_SMARTCASTHEAL    = "治疗法术";
HEALBOT_OPTIONS_BAR2SIZE         = "法力条尺寸";
HEALBOT_OPTIONS_SETSPELLS        = "设置法术";
HEALBOT_OPTIONS_ENABLEDBARS     = "总是启用样式条";
HEALBOT_OPTIONS_DISABLEDBARS    = "忽略时间极短的Debuff";
HEALBOT_OPTIONS_MONITORDEBUFFS  = "监测debuff";
HEALBOT_OPTIONS_DEBUFFTEXT1     = "设置解debuff的技能";

HEALBOT_OPTIONS_IGNOREDEBUFF         = "忽略debuff:";
HEALBOT_OPTIONS_IGNOREDEBUFFCLASS    = "不关联职业";
HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "减速效果";
HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "短时间";
HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM   = "忽略无害效果";

HEALBOT_OPTIONS_RANGECHECKFREQ       = "范围检测频率";
HEALBOT_OPTIONS_RANGECHECKUNITS      = "在施法距离内寻找伤害最大及最小单位"

HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "隐藏队伍框体";
HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "包含玩家和目标";
HEALBOT_OPTIONS_DISABLEHEALBOT       = "禁用HealBot";

HEALBOT_OPTIONS_CHECKEDTARGET        = "检查";

HEALBOT_ASSIST  = "ASSIST";
HEALBOT_FOCUS   = "FOCUS";

HEALBOT_TITAN_SMARTCAST      = "SmartCast";
HEALBOT_TITAN_MONITORBUFFS   = "监视buff";
HEALBOT_TITAN_MONITORDEBUFFS = "监视debuff"
HEALBOT_TITAN_SHOWBARS       = "显示样式条";
HEALBOT_TITAN_EXTRABARS      = "额外样式条";
HEALBOT_BUTTON_TOOLTIP       = "左击打开HealBot设置面板";
HEALBOT_TITAN_TOOLTIP        = "左击打开HealBot设置面板";
HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "显示小地图按钮";
HEALBOT_OPTIONS_BARBUTTONSHOWHOT  = "显示HoT图标";
HEALBOT_OPTIONS_HOTONBAR     = "打开"
HEALBOT_OPTIONS_HOTOFFBAR    = "关闭"
HEALBOT_OPTIONS_HOTBARRIGHT  = "右边"
HEALBOT_OPTIONS_HOTBARLEFT   = "左边"

HEALBOT_OPTIONS_ENABLETARGETSTATUS = "当目标进入战斗，使用启用设置"

HEALBOT_ZONE_AB = "阿拉希盆地";
HEALBOT_ZONE_AV = "奥特兰克山谷";
HEALBOT_ZONE_ES = "风暴之眼";
HEALBOT_ZONE_WG = "战歌峡谷";

HEALBOT_OPTION_AGGROTRACK = "仇恨提醒"
HEALBOT_OPTION_AGGROBAR = "闪烁条"
HEALBOT_OPTION_AGGROTXT = ">> 显示文字 <<"
HEALBOT_OPTION_BARUPDFREQ = "闪烁频率"
HEALBOT_OPTION_USEFLUIDBARS = "动态监视"
HEALBOT_OPTION_CPUPROFILE  = "使用CPU性能测试（插件CPU使用信息）"
HEALBOT_OPTIONS_RELOADUIMSG = "该选项需要重载UI，现在重载?"

HEALBOT_SELF_PVP              = "自身PvP"
HEALBOT_OPTIONS_ANCHOR        = "锚点"
HEALBOT_OPTIONS_TOPLEFT       = "左上"
HEALBOT_OPTIONS_BOTTOMLEFT    = "左下"
HEALBOT_OPTIONS_TOPRIGHT      = "右上"
HEALBOT_OPTIONS_BOTTOMRIGHT   = "右下"

HEALBOT_PANEL_BLACKLIST       = "黑名单"

HEALBOT_WORDS_REMOVEFROM      = "移除";
HEALBOT_WORDS_ADDTO           = "增加";
HEALBOT_WORDS_INCLUDE         = "包含";

HEALBOT_OPTIONS_TTALPHA       = "透明度"
HEALBOT_TOOLTIP_TARGETBAR     = "目标监视条"
HEALBOT_OPTIONS_MYTARGET      = "我的目标"

HEALBOT_DISCONNECTED_TEXT			= "<离线>"
HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "显示我的增益";
HEALBOT_OPTIONS_TOOLTIPUPDATE       = "更新频率";
HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "在Buff持续结束时显示";
HEALBOT_OPTIONS_SHORTBUFFTIMER      = "短Buff"
HEALBOT_OPTIONS_LONGBUFFTIMER       = "长Buff"

HEALBOT_BALANCE       = "平衡"
HEALBOT_FERAL         = "野性战斗"--check
HEALBOT_RESTORATION   = "恢复"
HEALBOT_SHAMAN_RESTORATION = "恢复"
HEALBOT_ARCANE        = "奥术"
HEALBOT_FIRE          = "火焰"
HEALBOT_FROST         = "冰霜"
HEALBOT_DISCIPLINE    = "戒律"
HEALBOT_HOLY          = "神圣"
HEALBOT_SHADOW        = "暗影"
HEALBOT_ASSASSINATION = "刺杀"
HEALBOT_COMBAT        = "战斗"
HEALBOT_SUBTLETY      = "敏锐"
HEALBOT_ARMS          = "武器"
HEALBOT_FURY          = "狂怒"
HEALBOT_PROTECTION    = "防御"
HEALBOT_BEASTMASTERY  = "野兽控制"
HEALBOT_MARKSMANSHIP  = "射击"
HEALBOT_SURVIVAL      = "生存"
HEALBOT_RETRIBUTION   = "惩戒"
HEALBOT_ELEMENTAL     = "元素"
HEALBOT_ENHANCEMENT   = "增强"
HEALBOT_AFFLICTION    = "痛苦"
HEALBOT_DEMONOLOGY    = "恶魔学识"
HEALBOT_DESTRUCTION   = "毁灭"
HEALBOT_BLOOD         = "鲜血"
HEALBOT_UNHOLY        = "邪恶"

HEALBOT_OPTIONS_VISIBLERANGE = "当超过100码距离禁用状态条"
HEALBOT_OPTIONS_NOTIFY_HEAL_MSG  = "治疗信息"
HEALBOT_OPTIONS_NOTIFY_OTHER_MSG = "其他信息"
HEALBOT_WORDS_YOU                = "你";
HEALBOT_NOTIFYHEALMSG            = "施放#s, 为#n治疗了#h";
HEALBOT_NOTIFYOTHERMSG           = "在#n上施放了#s";

HEALBOT_OPTIONS_HOTPOSITION     = "图标位置"
HEALBOT_OPTIONS_HOTSHOWTEXT     = "显示图标文本"
HEALBOT_OPTIONS_HOTTEXTCOUNT    = "次数"
HEALBOT_OPTIONS_HOTTEXTDURATION = "持续时间"
HEALBOT_OPTIONS_ICONSCALE       = "图标缩放比例"
HEALBOT_OPTIONS_ICONTEXTSCALE   = "图标文字缩放比例"

HEALBOT_SKIN_FLUID              = "流动"
HEALBOT_SKIN_VIVID              = "生动"
HEALBOT_SKIN_LIGHT              = "光亮"
HEALBOT_SKIN_SQUARE             = "方形"
HEALBOT_OPTIONS_AGGROBARSIZE    = "OT状态条尺寸"
HEALBOT_OPTIONS_TARGETBARMODE   = "把目标状态条限制在预订设置之中"
HEALBOT_OPTIONS_DOUBLETEXTLINES = "双行文字"
HEALBOT_OPTIONS_TEXTALIGNMENT   = "文本调整"
HEALBOT_OPTIONS_ENABLELIBQH     = "启用libQuickHealth"
HEALBOT_VEHICLE                 = "载具"

end