-------------------------------------------------------------------------------
-- Simplified Chinese localization
-- By Kurax Kuang
-------------------------------------------------------------------------------

if (GetLocale() == "zhCN") then

-- smartbuff credits
SMARTBUFF_CREDITS = "|cffffffff"
  .."Codermik 的 Shadowlands 版本。 请在 CurseForge 或我的 discord 上报告任何问题：\n\n"
  .."|cff00e0ffhttps://discord.gg/R6EkZ94TKK\n\n"
  .."|cffffffff如果您感谢所涉及的工作量以及为您带来这些各种插件所花费的时间，请考虑通过以下方式支持我：\n\n"
  .."|cffffffffTwitch: |cff00e0ffhttps://www.twitch.tv/codermik\n"
  .."|cffffffffPayPal.Me: |cff00e0ffhttps://paypal.me/codermik\n\n"
;

-- 德鲁伊
SMARTBUFF_DRUID_CAT = "猎豹形态";
SMARTBUFF_DRUID_MOONKIN = "枭兽形态";
SMARTBUFF_DRUID_TRACK = "追踪人型生物";

SMARTBUFF_MOTW = "野性印记";
SMARTBUFF_GOTW = "野性赐福";
SMARTBUFF_THORNS = "荆棘术";
SMARTBUFF_OMENOFCLARITY = "清晰预兆";
SMARTBUFF_BARKSKIN = "树皮术";
SMARTBUFF_NATURESGRASP = "自然之握";
SMARTBUFF_TIGERSFURY = "猛虎之怒";
SMARTBUFF_REJUVENATION = "回春术";
SMARTBUFF_REGROWTH = "愈合";

SMARTBUFF_REMOVECURSE = "解除诅咒";
SMARTBUFF_ABOLISHPOISON = "驱毒术";

-- 法师
SMARTBUFF_AI = "奥术智慧";
SMARTBUFF_AB = "奥术光辉";
SMARTBUFF_ICEARMOR = "冰甲术";
SMARTBUFF_FROSTARMOR = "霜甲术";
SMARTBUFF_MAGEARMOR = "法师护甲";
SMARTBUFF_MOLTENARMOR = "熔岩护甲";
SMARTBUFF_DAMPENMAGIC = "魔法抑制";
SMARTBUFF_AMPLIFYMAGIC = "魔法增效";
SMARTBUFF_MANASHIELD = "法力护盾";
SMARTBUFF_FIREWARD = "防护火焰结界";
SMARTBUFF_FROSTWARD = "防护冰霜结界";
SMARTBUFF_ICEBARRIER = "寒冰护体";
SMARTBUFF_COMBUSTION = "燃烧";
SMARTBUFF_ARCANEPOWER = "奥术强化";
SMARTBUFF_PRESENCEOFMIND = "气定神闲";
SMARTBUFF_ICYVEINS = "冰冷血脉";

SMARTBUFF_MAGE_PATTERN = {"%a+护甲$"};

--  牧师
SMARTBUFF_PWF = "真言术：韧";
SMARTBUFF_POF = "坚韧祷言";
SMARTBUFF_SP = "防护暗影";
SMARTBUFF_POSP = "暗影防护祷言";
SMARTBUFF_INNERFIRE = "心灵之火";
SMARTBUFF_DS = "神圣之灵";
SMARTBUFF_POS = "精神祷言";
SMARTBUFF_PWS = "真言术：盾";
SMARTBUFF_FEARWARD = "防护恐惧结界";
SMARTBUFF_ELUNESGRACE = "艾露恩的赐福";
SMARTBUFF_FEEDBACK = "回馈";
SMARTBUFF_SHADOWGUARD = "暗影守卫";
SMARTBUFF_TOUCHOFWEAKNESS = "虚弱之触";
SMARTBUFF_INNERFOCUS = "心灵专注";
SMARTBUFF_RENEW = "恢复";

-- 术士
SMARTBUFF_FELARMOR = "邪甲术";
SMARTBUFF_DEMONARMOR = "魔甲术";
SMARTBUFF_DEMONSKIN = "恶魔皮肤";
SMARTBUFF_UNENDINGBREATH = "魔息术";
SMARTBUFF_DGINVISIBILITY = "侦测强效隐形";
SMARTBUFF_DINVISIBILITY = "侦测隐形";
SMARTBUFF_DLINVISIBILITY = "侦测次级隐形";
SMARTBUFF_SOULLINK = "灵魂链接";
SMARTBUFF_SHADOWWARD = "暗影守卫";
SMARTBUFF_DARKPACT = "黑暗契约";
SMARTBUFF_SOULSTONE = "灵魂石复活";

SMARTBUFF_WARLOCK_PATTERN = {"^恶魔%a+"};

-- 猎人
SMARTBUFF_TRUESHOTAURA = "强击光环";
SMARTBUFF_RAPIDFIRE = "急速射击";
SMARTBUFF_AOTH = "雄鹰守护";
SMARTBUFF_AOTM = "灵猴守护";
SMARTBUFF_AOTW = "野性守护";
SMARTBUFF_AOTB = "野兽守护";
SMARTBUFF_AOTC = "猎豹守护";
SMARTBUFF_AOTP = "豹群守护";
SMARTBUFF_AOTV = "蝰蛇守护";

SMARTBUFF_HUNTER_PATTERN = {"守护$"};

-- 萨满祭司
SMARTBUFF_LIGHTNINGSHIELD = "闪电之盾";
SMARTBUFF_WATERSHIELD = "水之护盾";
SMARTBUFF_EARTHSHIELD = "大地之盾";
SMARTBUFF_ROCKBITERW = "石化武器";
SMARTBUFF_FROSTBRANDW = "冰封武器";
SMARTBUFF_FLAMETONGUEW = "火舌武器";
SMARTBUFF_WINDFURYW = "风怒武器";
SMARTBUFF_WATERBREATHING = "水下呼吸";

SMARTBUFF_SHAMAN_PATTERN = {"%a+之盾$"};

-- 战士
SMARTBUFF_BATTLESHOUT = "战斗怒吼";
SMARTBUFF_COMMANDINGSHOUT = "命令怒吼";
SMARTBUFF_BERSERKERRAGE = "狂暴之怒";
SMARTBUFF_BLOODRAGE = "血性狂暴";
SMARTBUFF_RAMPAGE = "暴怒";

-- 盗贼
SMARTBUFF_BLADEFLURRY = "剑刃乱舞";
SMARTBUFF_SAD = "切割";
SMARTBUFF_EVASION = "闪避";
SMARTBUFF_INSTANTPOISON = "速效药膏";
SMARTBUFF_WOUNDPOISON = "致伤药膏";
--SMARTBUFF_MINDPOISON = "Mind\194\173numbing Poison";
--SMARTBUFF_MINDPOISON = "Mind\45numbing Poison";
SMARTBUFF_MINDPOISON = "麻痹药膏";
SMARTBUFF_DEADLYPOISON = "致命药膏";
SMARTBUFF_CRIPPLINGPOISON = "减速药膏";
SMARTBUFF_ANESTHETICPOISON = "麻醉药膏";

-- 圣骑士
SMARTBUFF_RIGHTEOUSFURY = "正义之怒";
SMARTBUFF_HOLYSHIELD = "神圣之盾";
SMARTBUFF_BOM = "力量祝福";
SMARTBUFF_GBOM = "强效力量祝福";
SMARTBUFF_BOW = "智慧祝福";
SMARTBUFF_GBOW = "强效智慧祝福";
SMARTBUFF_BOSAL = "拯救祝福";
SMARTBUFF_GBOSAL = "强效拯救祝福";
SMARTBUFF_BOK = "王者祝福";
SMARTBUFF_GBOK = "强效王者祝福";
SMARTBUFF_BOSAN = "庇护祝福";
SMARTBUFF_GBOSAN = "强效庇护祝福";
SMARTBUFF_BOL = "光明祝福";
SMARTBUFF_GBOL = "强效光明祝福";
SMARTBUFF_BOF = "自由祝福";
SMARTBUFF_BOP = "保护祝福";
SMARTBUFF_SOCOMMAND = "命令圣印";
SMARTBUFF_SOFURY = "愤怒圣印";
SMARTBUFF_SOJUSTICE = "公正圣印";
SMARTBUFF_SOLIGHT = "光明圣印";
SMARTBUFF_SORIGHTEOUSNESS = "正义圣印";
SMARTBUFF_SOWISDOM = "智慧圣印";
SMARTBUFF_SOTCRUSADER = "十字军圣印";
SMARTBUFF_SOVENGEANCE = "复仇圣印";
SMARTBUFF_SOBLOOD = "鲜血圣印";
SMARTBUFF_DEVOTIONAURA = "虔诚光环";
SMARTBUFF_RETRIBUTIONAURA = "惩罚光环";
SMARTBUFF_CONCENTRATIONAURA = "专注光环";
SMARTBUFF_SHADOWRESISTANCEAURA = "暗影抗性光环";
SMARTBUFF_FROSTRESISTANCEAURA = "冰霜抗性光环";
SMARTBUFF_FIRERESISTANCEAURA = "火焰抗性光环";
SMARTBUFF_SANCTITYAURA = "圣洁光环";
SMARTBUFF_CRUSADERAURA = "十字军光环";

SMARTBUFF_PALADIN_PATTERN = {"%a+圣印$"};

-- 石头和油类
SMARTBUFF_SSROUGH = "劣质磨刀石";
SMARTBUFF_SSCOARSE = "粗制磨刀石";
SMARTBUFF_SSHEAVY = "重磨刀石";
SMARTBUFF_SSSOLID = "坚固的磨刀石";
SMARTBUFF_SSDENSE = "致密磨刀石";
SMARTBUFF_SSELEMENTAL = "元素磨刀石";
SMARTBUFF_SSFEL = "魔能磨刀石";
SMARTBUFF_SSADAMANTITE = "精金磨刀石";
SMARTBUFF_WSROUGH = "劣质平衡石";
SMARTBUFF_WSCOARSE = "粗制平衡石";
SMARTBUFF_WSHEAVY = "重平衡石";
SMARTBUFF_WSSOLID = "坚固的平衡石";
SMARTBUFF_WSDENSE = "致密平衡石";
SMARTBUFF_WSFEL = "魔能平衡石";
SMARTBUFF_WSADAMANTITE = "精金平衡石";
SMARTBUFF_SHADOWOIL = "暗影之油";
SMARTBUFF_FROSTOIL = "冰霜之油";
SMARTBUFF_MANAOILMINOR = "初级法力之油";
SMARTBUFF_MANAOILLESSER = "次级法力之油";
SMARTBUFF_MANAOILBRILLIANT = "卓越法力之油";
SMARTBUFF_MANAOILSUPERIOR = "超级法力之油";
SMARTBUFF_WIZARDOILMINOR = "初级巫师之油";
SMARTBUFF_WIZARDOILLESSER = "次级巫师之油";
SMARTBUFF_WIZARDOIL = "巫师之油";
SMARTBUFF_WIZARDOILBRILLIANT = "卓越巫师之油";
SMARTBUFF_WIZARDOILSUPERIOR = "超级巫师之油";

SMARTBUFF_WEAPON_STANDARD = {"匕首", "斧", "剑", "锤", "法杖", "拳套", "长柄武器"};
SMARTBUFF_WEAPON_BLUNT = {"魔杖", "法杖", "拳套"};
SMARTBUFF_WEAPON_BLUNT_PATTERN = "平衡石$";
SMARTBUFF_WEAPON_SHARP = {"匕首", "斧", "剑", "长柄武器"};
SMARTBUFF_WEAPON_SHARP_PATTERN = "磨刀石$";

-- 跟踪类
SMARTBUFF_FINDMINERALS = "寻找矿物";
SMARTBUFF_FINDHERBS = "寻找草药";
SMARTBUFF_FINDTREASURE = "寻找财宝";
SMARTBUFF_TRACKHUMANOIDS = "追踪人型生物";
SMARTBUFF_TRACKBEASTS = "追踪野兽";
SMARTBUFF_TRACKUNDEAD = "追踪亡灵";
SMARTBUFF_TRACKHIDDEN = "追踪隐藏生物";
SMARTBUFF_TRACKELEMENTALS = "追踪元素生物";
SMARTBUFF_TRACKDEMONS = "追踪恶魔";
SMARTBUFF_TRACKGIANTS = "追踪巨人";
SMARTBUFF_TRACKDRAGONKIN = "追踪龙类";
SMARTBUFF_SENSEDEMONS = "感知恶魔";
SMARTBUFF_SENSEUNDEAD = "感知亡灵";

-- 种族技能
SMARTBUFF_STONEFORM = "石像形态";
SMARTBUFF_PRECEPTION = "感知";
SMARTBUFF_BLOODFURY = "血之狂怒";
SMARTBUFF_BERSERKING = "狂暴";
SMARTBUFF_WOTFORSAKEN = "亡灵意志";

-- 材料
SMARTBUFF_WILDBERRIES = "野生浆果";
SMARTBUFF_WILDTHORNROOT = "野生棘根草";
SMARTBUFF_WILDQUILLVINE = "野生刺藤";
SMARTBUFF_ARCANEPOWDER = "魔粉";
SMARTBUFF_HOLYCANDLE = "圣洁蜡烛";
SMARTBUFF_SACREDCANDLE = "神圣蜡烛";
SMARTBUFF_SYMBOLOFKINGS = "神圣符印";

-- Food
--SMARTBUFF_ = "";
SMARTBUFF_SAGEFISHDELIGHT = "美味鼠尾鱼";
SMARTBUFF_BUZZARDBITES = "美味秃鹫";
SMARTBUFF_RAVAGERDOG = "掠食者热狗";
SMARTBUFF_FELTAILDELIGHT = "美味魔尾鱼";
SMARTBUFF_CLAMBAR = "蚌柳";
SMARTBUFF_SPORELINGSNACK = "孢子小吃";
SMARTBUFF_BLACKENEDSPOREFISH = "烟熏孢子鱼";
SMARTBUFF_BLACKENEDBASILISK = "烟熏蜥蜴";
SMARTBUFF_GRILLEDMUDFISH = "烤泥鱼";
SMARTBUFF_POACHEDBLUEFISH = "水煮蓝鱼";
SMARTBUFF_ROASTEDCLEFTHOOF = "烧烤裂蹄牛";
SMARTBUFF_WARPBURGER = "迁跃兽汉堡";
SMARTBUFF_TALBUKSTEAK = "塔布肉排";
SMARTBUFF_GOLDENFISHSTICKS = "金色鱼柳";
SMARTBUFF_CRUNCHYSERPENT = "香脆蛇";
SMARTBUFF_MOKNATHALSHORTRIBS = "莫克纳萨肋排";
SMARTBUFF_SPICYCRAWDAD = "香辣小龙虾";

SMARTBUFF_FOOD_AURA = "进食充分";


-- 生物类型
SMARTBUFF_HUMANOID  = "人型生物";
SMARTBUFF_DEMON     = "恶魔";
SMARTBUFF_BEAST     = "野兽";
SMARTBUFF_ELEMENTAL = "元素生物";
SMARTBUFF_DEMONTYPE = "小鬼";

-- 职业
SMARTBUFF_CLASSES = {"德鲁伊", "猎人", "法师", "圣骑士", "牧师", "潜行者", "萨满祭司", "术士", "战士", "死亡骑士", "武僧", "恶魔猎手", "唤魔者", "猎人宠物", "术士宠物", "Death Knight Pet", "Tank", "Healer", "Damage Dealer"};

-- 模板和地图
SMARTBUFF_TEMPLATES = {"Solo", "组队", "团队", "战场", "卡拉赞", "祖阿曼", "地狱火堡垒", "盘牙水库", "奥金顿", "风暴要塞", "格鲁尔巢穴", "时光之穴", "黑暗神庙", "自定义 1", "自定义 2", "自定义 3"};
SMARTBUFF_INSTANCES = {"卡拉赞", "祖阿曼", "玛瑟里顿的巢穴", "毒蛇神殿", "风暴之眼", "格鲁尔的巢穴", "海加尔", "黑暗神庙", "熔火之心", "奥妮克希亚的巢穴", "黑翼之巢", "纳克萨玛斯", "安其拉", "祖尔格拉布", "奥特兰克山谷", "阿拉希盆地", "战歌峡谷", "刀锋山", "纳格兰竞技场"};

-- 骑乘
SMARTBUFF_MOUNT = "速度提高(%d+)%%.";

-- 快捷键设置
BINDING_NAME_SMARTBUFF_BIND_TRIGGER = "触发";
BINDING_NAME_SMARTBUFF_BIND_TARGET  = "目标";
BINDING_NAME_SMARTBUFF_BIND_OPTIONS = "设置窗口";
BINDING_NAME_SMARTBUFF_BIND_RESETBUFFTIMERS = "重新设定BUFF定时器";

-- 设置窗口

-- experimental feature - for testing.
SMARTBUFF_OFT_FIXBUFF        = "修复 铸造"
SMARTBUFF_OFTT_FIXBUFF       = "如果施放 buff 失败，请勾选此选项。"

SMARTBUFF_OFT                = "启用SmartBuff";
SMARTBUFF_OFT_MENU           = "显示/隐藏配置菜单";
SMARTBUFF_OFT_AUTO           = "提醒";
SMARTBUFF_OFT_AUTOTIMER      = "检测间隔";
SMARTBUFF_OFT_AUTOCOMBAT     = "战斗";
SMARTBUFF_OFT_AUTOCHAT       = "聊天";
SMARTBUFF_OFT_AUTOSPLASH     = "闪烁";
SMARTBUFF_OFT_AUTOSOUND      = "声音";
SMARTBUFF_OFT_AUTOREST       = "城市内禁用";
SMARTBUFF_OFT_HUNTERPETS     = "BUFF猎人宠物";
SMARTBUFF_OFT_WARLOCKPETS    = "BUFF术士宠物";
SMARTBUFF_OFT_ARULES         = "高级规则";
SMARTBUFF_OFT_GRP            = "监视的组别";
SMARTBUFF_OFT_SUBGRPCHANGED  = "自动开启选项窗口";
SMARTBUFF_OFT_BUFFS          = "可施放项目";
SMARTBUFF_OFT_TARGET         = "BUFF选定目标";
SMARTBUFF_OFT_DONE           = "确定";
SMARTBUFF_OFT_APPLY          = "应用";
SMARTBUFF_OFT_GRPBUFFSIZE    = "触发人数";
SMARTBUFF_OFT_CLASSBUFFSIZE  = "职业人数";
SMARTBUFF_OFT_MESSAGES       = "禁用信息";
SMARTBUFF_OFT_MSGNORMAL      = "正常";
SMARTBUFF_OFT_MSGWARNING     = "警告";
SMARTBUFF_OFT_MSGERROR       = "错误";
SMARTBUFF_OFT_HIDEMMBUTTON   = "隐藏小地图按钮";
SMARTBUFF_OFT_INCLUDETOYS    = "展示玩具";
SMARTBUFF_OFT_REBUFFTIMER    = "提醒时间";
SMARTBUFF_OFT_AUTOSWITCHTMP  = "自动开启配置";
SMARTBUFF_OFT_SELFFIRST      = "首选自身";
SMARTBUFF_OFT_SCROLLWHEEL    = "鼠标滚轴触发";
SMARTBUFF_OFT_SCROLLWHEELUP  = "向上滚动时触发";
SMARTBUFF_OFT_SCROLLWHEELDOWN= "向下时";
SMARTBUFF_OFT_TARGETSWITCH   = "目标改变触发";
SMARTBUFF_OFT_BUFFTARGET     = "目标 BUFF";
SMARTBUFF_OFT_BUFFPVP        = "PVP BUFF";
SMARTBUFF_OFT_AUTOSWITCHTMPINST = "自动更换方案";
SMARTBUFF_OFT_CHECKCHARGES   = "检查次数";
SMARTBUFF_OFT_RBT            = "重置计时器";
SMARTBUFF_OFT_BUFFINCITIES   = "在主城内BUFF";
SMARTBUFF_OFT_UISYNC         = "UI同步";
SMARTBUFF_OFT_ADVGRPBUFFCHECK = "队伍BUFF检查";
SMARTBUFF_OFT_ADVGRPBUFFRANGE = "队伍范围检查";
SMARTBUFF_OFT_BLDURATION     = "忽略名单";
SMARTBUFF_OFT_COMPMODE       = "兼容模式";
SMARTBUFF_OFT_MINIGRP        = "迷你团队";
SMARTBUFF_OFT_ANTIDAZE       = "自动切换守护";
SMARTBUFF_OFT_HIDESABUTTON   = "隐藏动作按钮";
SMARTBUFF_OFT_INCOMBAT       = "战斗中触发";
SMARTBUFF_OFT_SMARTDEBUFF    = "SmartDebuff";
SMARTBUFF_OFT_PURGE_DATA     = "您确定要重置所有 SmartBuff 数据吗？\n此操作将强制重新加载 UI！";
SMARTBUFF_OFT_RESETBUFFS     = "Reset Buffs";
SMARTBUFF_OFT_PURGE_BUFFS    = "New Version, reset ALL SmartBuff buff data?\nThis will reset all buff profiles!";
SMARTBUFF_OFT_REQ_RELOAD     = "新版本需要重新加载 GUI\n准备就绪后单击继续。";
SMARTBUFF_OFT_YES            = "是的";
SMARTBUFF_OFT_NO             = "不";
SMARTBUFF_OFT_OKAY           = "继续"

-- 设置信息提示
SMARTBUFF_OFTT               = "启用智能施法";
SMARTBUFF_OFTT_AUTO          = "启用BUFF信息提示";
SMARTBUFF_OFTT_AUTOTIMER     = "BUFF监视时间的间隔";
SMARTBUFF_OFTT_AUTOCOMBAT    = "战斗时仍保持监视";
SMARTBUFF_OFTT_AUTOCHAT      = "在聊天窗口中显示施法有关信息";
SMARTBUFF_OFTT_AUTOSPLASH    = "在游戏屏幕的中央以闪烁方式显示施法失败的有关信息";
SMARTBUFF_OFTT_AUTOSOUND     = "声音提示施法失败事件";
SMARTBUFF_OFTT_AUTOREST      = "在主城内禁用信息提示";
SMARTBUFF_OFTT_HUNTERPETS    = "对猎人宠物施法";
SMARTBUFF_OFTT_WARLOCKPETS   = "对术士宠物施法，" .. SMARTBUFF_DEMONTYPE .. "除外。";
SMARTBUFF_OFTT_ARULES        = "设定以下情况不施法：法师、牧师和术士不施放荆棘术,无魔法职业不施放奥术智慧、神圣之灵。";
SMARTBUFF_OFTT_SUBGRPCHANGED = "当你所在队伍发生变动后，自动开启Smartbuff配置窗口。";
SMARTBUFF_OFTT_GRPBUFFSIZE   = "设定所在小队中玩家的BUFF消失的人数上限，来触发群体BUFF的施放。";
SMARTBUFF_OFTT_HIDEMMBUTTON  = "隐藏小地图按钮。";
SMARTBUFF_OFTT_INCLUDETOYS   = "将玩具与您的咒语和食物一起列入清单。";
SMARTBUFF_OFTT_REBUFFTIMER   = "设定当BUFF消失前多少秒，提示你重新施法。0 = 不提示";
SMARTBUFF_OFTT_SELFFIRST     = "优先给自己施放BUFF。";
SMARTBUFF_OFTT_SCROLLWHEELUP = "当鼠标滚轴向上滚动时触发技能。";
SMARTBUFF_OFTT_SCROLLWHEELDOWN = "当鼠标滚轴向下滚动时触发技能。";
SMARTBUFF_OFTT_TARGETSWITCH  = "当你改变目标时触发技能。";
SMARTBUFF_OFTT_BUFFTARGET    = "当目标为友好状态时，给予该目标施放BUFF。";
SMARTBUFF_OFTT_BUFFPVP       = "将给PVP开启的玩家施放BUFF。";
SMARTBUFF_OFTT_AUTOSWITCHTMP = "当你所在队伍成员发生改变时，自动开启Smartbuff的配置窗口。";
SMARTBUFF_OFTT_AUTOSWITCHTMPINST = "根据你是否处于组队、团队、副本的情况，自动更换预定的方案。";
SMARTBUFF_OFTT_CHECKCHARGES  = "当BUFF次数过低时报警。";
SMARTBUFF_OFTT_BUFFINCITIES  = "即使是在主城内仍然BUFF。\n如果你在PVP状态下，无论何种情况均会BUFF。";
SMARTBUFF_OFTT_UISYNC        = "开启同步选项，以从其他玩家那里获取你的BUFF的剩余时间。";
SMARTBUFF_OFTT_ADVGRPBUFFCHECK = "在检查群体BUFF的同时\n也检查单个BUFF的补给情况。";
SMARTBUFF_OFTT_ADVGRPBUFFRANGE = "在施放群体BUFF时\n检查所有队员是否在施法范围内。";
SMARTBUFF_OFTT_BLDURATION    = "剩余多少时间内的玩家将被忽略。\n0 = 停用";
SMARTBUFF_OFTT_COMPMODE      = "兼容性模式\n注意!!!\n如果你存在无法自我施法的问题,\n必须使用此模式。";
SMARTBUFF_OFTT_MINIGRP       = "用迷你团队模式显示合理化的团队框架。";
SMARTBUFF_OFTT_ANTIDAZE      = "当自己队伍中有成员晕眩时，自动取消猎豹守护/豹群守护。";
SMARTBUFF_OFTT_SPLASHSTYLE   = "改变BUFF提示信息的字体。";
SMARTBUFF_OFTT_HIDESABUTTON  = "隐藏SmartBuff动作按钮。";
SMARTBUFF_OFTT_INCOMBAT      = "目前只能用于你自己身上。\n你设定的第一个战斗中可释放的BUFF将在战斗前放置到动作按钮上，\n因此你可以在战斗中施放这个法术。\n警告：战斗中所有逻辑判断都将不可用！";
SMARTBUFF_OFTT_SMARTDEBUFF   = "显示SmartDebuff窗口。";
SMARTBUFF_OFTT_SPLASHDURATION= "设定多少秒后提示信息消失。";
SMARTBUFF_OFTT_SOUNDSELECT   = "选择所需的飞溅声.";


-- BUFF设置内容
SMARTBUFF_BST_SELFONLY       = "仅对自身施法";
SMARTBUFF_BST_SELFNOT        = "不对自身施法";
SMARTBUFF_BST_COMBATIN       = "战斗状态触发";
SMARTBUFF_BST_COMBATOUT      = "非战斗状态触发";
SMARTBUFF_BST_MAINHAND       = "主手";
SMARTBUFF_BST_OFFHAND        = "副手";
SMARTBUFF_BST_REMINDER       = "通报";
SMARTBUFF_BST_MANALIMIT      = "最低值";

-- BUFF设置提示信息内容
SMARTBUFF_BSTT_SELFONLY      = "仅BUFF自己，不给其他队友BUFF。"; 
SMARTBUFF_BSTT_SELFNOT       = "BUFF所有其他选择的职业，但是不BUFF自己。";
SMARTBUFF_BSTT_COMBATIN      = "在战斗状态时仍保持自动触发技能";
SMARTBUFF_BSTT_COMBATOUT     = "在非战斗状态时保持自动触发技能";
SMARTBUFF_BSTT_MAINHAND      = "给主手武器施放BUFF。";
SMARTBUFF_BSTT_OFFHAND       = "给副手武器施放BUFF。";
SMARTBUFF_BSTT_REMINDER      = "显示提醒信息。";
SMARTBUFF_BSTT_REBUFFTIMER   = "设定当BUFF消失前多少秒时发出警告信息。\n0 = 不提示";
SMARTBUFF_BSTT_MANALIMIT     = "当魔法值/怒气值/能量值低于你设置的值时将不会BUFF。";

-- 玩家设置窗口信息提示
SMARTBUFF_PSTT_RESIZE        = "最小化/最大化\n主设置窗口";

-- 命令行信息提示内容
SMARTBUFF_MSG_LOADED         = "已加载";
SMARTBUFF_MSG_NEWVER1        = "|cff00e0ffSmartbuff : |cffffffff 有可用的新版本，您正在使用 |cffFFFF00";
SMARTBUFF_MSG_NEWVER2        = "|cffffffff 和修订 |cffFFFF00r"
SMARTBUFF_MSG_NEWVER3        = "|cffffffff 目前可供下载。 加入 Discord 以获取所有最新信息： https://discord.gg/R6EkZ94TKK.";
SMARTBUFF_MSG_DISABLED       = "SmartBuff已禁用！";
SMARTBUFF_MSG_SUBGROUP       = "你已经加入一个新的队伍，请检查你的设置。";
SMARTBUFF_MSG_NOTHINGTODO    = "没有指令可以执行。";
SMARTBUFF_MSG_BUFFED         = "已经施放";
SMARTBUFF_MSG_OOR            = "不在施法范围内。";
--SMARTBUFF_MSG_CD             = "技能CD时间已到。";
SMARTBUFF_MSG_CD             = "正处于公共CD时间！";
SMARTBUFF_MSG_CHAT           = "没有发现任何聊天窗口。";
SMARTBUFF_MSG_SHAPESHIFT     = "在变形状态下不能使用法术！";
SMARTBUFF_MSG_NOACTIONSLOT   = "动作条没有可用位置，需要一个空位置才能正常工作！";
SMARTBUFF_MSG_GROUP          = "队伍";
SMARTBUFF_MSG_NEEDS          = "需要加BUFF：";
SMARTBUFF_MSG_OOM            = "没有足够的魔法/怒气/能量!";
SMARTBUFF_MSG_STOCK          = "目前存放的";
SMARTBUFF_MSG_NOREAGENT      = "没有施法材料：";
SMARTBUFF_MSG_DEACTIVATED    = "禁用！";
SMARTBUFF_MSG_REBUFF         = "你的BUFF：";
SMARTBUFF_MSG_LEFT           = "以后消失！";
SMARTBUFF_MSG_CLASS          = "职业";
SMARTBUFF_MSG_CHARGES        = "次数";
SMARTBUFF_MSG_SOUNDS         = "飞溅声音选择: "

-- Support
SMARTBUFF_MINIMAP_TT         = "左键：选项菜单\n右键：开/关\nAlt+左键：SmartDebuff\n按Shift拖拽：移动按钮";
SMARTBUFF_TITAN_TT           = "左键：选项菜单\n右键：开/关\nAlt+左键：SmartDebuff";
SMARTBUFF_FUBAR_TT           = "左键：选项菜单\n右键：开/关\nAlt+左键：SmartDebuff";

SMARTBUFF_DEBUFF_TT          = "按Shift和左键拖拽：移动窗口\n|cff20d2ff- S按钮 -|r\n左键：按职业显示\nShift和左键：职业颜色\nAlt和左键：高亮左/右\n|cff20d2ff- P按钮 -|r\n左键：开/关隐藏宠物";

end
