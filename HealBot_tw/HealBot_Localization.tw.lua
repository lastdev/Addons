-- Taiwanese translator required

---------------
-- TAIWANESE --
---------------
--
-- (http://www.wowwiki.com/Localizing_an_addon)
--
-- If you want to translate for this region, please first confirm by email:  healbot@outlook.com
-- Include your registered username on the healbot website and the region you’re interested in taking responsibility for.
--
--
--
--





function HealBot_Lang_zhTW()

-----------------
-- Translation --
-----------------

-- Class
    HEALBOT_DRUID   = "德魯伊";
    HEALBOT_HUNTER  = "獵人";
    HEALBOT_MAGE    = "法師";
    HEALBOT_PALADIN = "聖騎士";
    HEALBOT_PRIEST  = "牧師";
    HEALBOT_ROGUE   = "盜賊";
    HEALBOT_SHAMAN  = "薩滿";
    HEALBOT_WARLOCK = "術士";
    HEALBOT_WARRIOR = "戰士";
    HEALBOT_DEATHKNIGHT = "死亡騎士";
HEALBOT_MONK                            = "Monk";

    HEALBOT_DISEASE            = "疾病";
    HEALBOT_MAGIC              = "魔法";
    HEALBOT_CURSE              = "詛咒";
    HEALBOT_POISON             = "毒";

    HB_TOOLTIP_OFFLINE                 = "離線";
    HB_OFFLINE              = "離線"; -- has gone offline msg
    HB_ONLINE               = "在線"; -- has come online msg

HEALBOT_HEALBOT                         = "HealBot";
HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED = " 載入";

    HEALBOT_ACTION_OPTIONS    = "設定";

    HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS      = "預設";
    HEALBOT_OPTIONS_CLOSE         = "結束";
    HEALBOT_OPTIONS_HARDRESET     = "重載 UI"
    HEALBOT_OPTIONS_SOFTRESET     = "重置 HB"
    HEALBOT_OPTIONS_TAB_GENERAL   = "一般";
    HEALBOT_OPTIONS_TAB_SPELLS    = "法術";
    HEALBOT_OPTIONS_TAB_HEALING   = "治療";
    HEALBOT_OPTIONS_TAB_CDC       = "驅散";
    HEALBOT_OPTIONS_TAB_SKIN      = "面板";
    HEALBOT_OPTIONS_TAB_TIPS      = "提示";
    HEALBOT_OPTIONS_TAB_BUFFS     = "增益"

    HEALBOT_OPTIONS_BARALPHA      = "動作條透明度";
    HEALBOT_OPTIONS_BARALPHAINHEAL = "進入治療時透明度";
HEALBOT_OPTIONS_BARALPHABACK            = "Background bar opacity";
    HEALBOT_OPTIONS_BARALPHAEOR   = "超出範圍時透明度";
    HEALBOT_OPTIONS_ACTIONLOCKED  = "鎖定";
    HEALBOT_OPTIONS_AUTOSHOW      = "關閉自動顯示";
    HEALBOT_OPTIONS_PANELSOUNDS   = "使用音效提示";
    HEALBOT_OPTIONS_HIDEOPTIONS   = "隱藏設定按鈕";
    HEALBOT_OPTIONS_PROTECTPVP    = "防止意外進入PVP狀態";
    HEALBOT_OPTIONS_HEAL_CHATOPT  = "聊天選項";

HEALBOT_OPTIONS_FRAMESCALE              = "Frame Scale"
    HEALBOT_OPTIONS_SKINTEXT      = "使用面板"
    HEALBOT_SKINS_STD             = "標準"
    HEALBOT_OPTIONS_SKINTEXTURE   = "材質"
    HEALBOT_OPTIONS_SKINHEIGHT    = "高度"
    HEALBOT_OPTIONS_SKINWIDTH     = "寬度"
    HEALBOT_OPTIONS_SKINNUMCOLS   = "欄位編號"
    HEALBOT_OPTIONS_SKINNUMHCOLS  = "在標題顯示編號"
    HEALBOT_OPTIONS_SKINBRSPACE   = "直列間隔"
    HEALBOT_OPTIONS_SKINBCSPACE   = "橫列間隔"
    HEALBOT_OPTIONS_EXTRASORT     = "排列方式"
    HEALBOT_SORTBY_NAME           = "名稱"
    HEALBOT_SORTBY_CLASS          = "職業"
    HEALBOT_SORTBY_GROUP          = "隊伍"
    HEALBOT_SORTBY_MAXHEALTH      = "最大生命值"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT = "新Debuff"
    HEALBOT_OPTIONS_DELSKIN       = "刪除"
    HEALBOT_OPTIONS_NEWSKINTEXT   = "新面板"
    HEALBOT_OPTIONS_SAVESKIN      = "儲存"
    HEALBOT_OPTIONS_SKINBARS      = "動作條設定"
    HEALBOT_SKIN_ENTEXT           = "啟用"
    HEALBOT_SKIN_DISTEXT          = "關閉"
    HEALBOT_SKIN_DEBTEXT          = "Debuff"
    HEALBOT_SKIN_BACKTEXT         = "背景顏色"
    HEALBOT_SKIN_BORDERTEXT       = "邊框顏色"
    HEALBOT_OPTIONS_SKINFONT      = "字體"
    HEALBOT_OPTIONS_SKINFHEIGHT   = "字體大小"
HEALBOT_OPTIONS_SKINFOUTLINE            = "Font Outline"
    HEALBOT_OPTIONS_BARALPHADIS   = "關閉透明度"
    HEALBOT_OPTIONS_SHOWHEADERS   = "顯示標題"

    HEALBOT_OPTIONS_ITEMS  = "物品";

    HEALBOT_OPTIONS_COMBOCLASS    = "組合鍵設定";
    HEALBOT_OPTIONS_CLICK         = "點擊";
HEALBOT_OPTIONS_SHIFT                   = "Shift";
HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY = "總是使用已啟用的設定";

    HEALBOT_OPTIONS_CASTNOTIFY1   = "關閉通知";
    HEALBOT_OPTIONS_CASTNOTIFY2   = "通知自己";
    HEALBOT_OPTIONS_CASTNOTIFY3   = "通知目標";
    HEALBOT_OPTIONS_CASTNOTIFY4   = "通知隊伍";
    HEALBOT_OPTIONS_CASTNOTIFY5   = "通知團隊";
    HEALBOT_OPTIONS_CASTNOTIFY6   = "通知頻道";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY = "只通知復活目標";

    HEALBOT_OPTIONS_CDCBARS       = "色彩設定";
    HEALBOT_OPTIONS_CDCSHOWHBARS  = "顯示生命條";
    HEALBOT_OPTIONS_CDCSHOWABARS  = "顯示仇恨條";
    HEALBOT_OPTIONS_CDCWARNINGS   = "Debuff警報";
    HEALBOT_OPTIONS_SHOWDEBUFFICON = "顯示Debuff圖示";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "有Debuff時顯示警告";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "有Debuff時音效提示";
    HEALBOT_OPTIONS_SOUND         = "音效"

    HEALBOT_OPTIONS_HEAL_BUTTONS  = "治療動作條:";
    HEALBOT_OPTIONS_SELFHEALS     = "自我"
    HEALBOT_OPTIONS_PETHEALS      = "寵物"
    HEALBOT_OPTIONS_GROUPHEALS    = "小隊";
    HEALBOT_OPTIONS_TANKHEALS     = "主坦";
HEALBOT_OPTIONS_MAINASSIST              = "Main assist";
HEALBOT_OPTIONS_PRIVATETANKS            = "Private main tanks";
    HEALBOT_OPTIONS_TARGETHEALS   = "目標";
    HEALBOT_OPTIONS_EMERGENCYHEALS= "額外";
    HEALBOT_OPTIONS_ALERTLEVEL    = "OT警報等級設定";
    HEALBOT_OPTIONS_EMERGFILTER   = "設定團隊框架";
    HEALBOT_OPTIONS_EMERGFCLASS   = "設定分類治療";
    HEALBOT_OPTIONS_COMBOBUTTON   = "按鈕";
    HEALBOT_OPTIONS_BUTTONLEFT    = "左";
    HEALBOT_OPTIONS_BUTTONMIDDLE  = "中";
    HEALBOT_OPTIONS_BUTTONRIGHT   = "右";
    HEALBOT_OPTIONS_BUTTON4       = "按鈕4";
    HEALBOT_OPTIONS_BUTTON5       = "按鈕5";
    HEALBOT_OPTIONS_BUTTON6                 = "按鈕6";
    HEALBOT_OPTIONS_BUTTON7                 = "按鈕7";
    HEALBOT_OPTIONS_BUTTON8                 = "按鈕8";
    HEALBOT_OPTIONS_BUTTON9                 = "按鈕9";
    HEALBOT_OPTIONS_BUTTON10                = "按鈕10";
    HEALBOT_OPTIONS_BUTTON11                = "按鈕11";
    HEALBOT_OPTIONS_BUTTON12                = "按鈕12";
    HEALBOT_OPTIONS_BUTTON13                = "按鈕13";
    HEALBOT_OPTIONS_BUTTON14                = "按鈕14";
    HEALBOT_OPTIONS_BUTTON15                = "按鈕15";

    HEALBOT_CLASSES_ALL     = "所有職業";
    HEALBOT_CLASSES_MELEE   = "近戰";
    HEALBOT_CLASSES_RANGES  = "遠程";
    HEALBOT_CLASSES_HEALERS = "治療";
    HEALBOT_CLASSES_CUSTOM  = "自定";

    HEALBOT_OPTIONS_SHOWTOOLTIP     = "顯示提示";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "顯示詳細法術訊息";
HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Show spell cooldown";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "顯示目標訊息";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "顯示建議的治療";
    HEALBOT_TOOLTIP_POSDEFAULT      = "預設位置";
    HEALBOT_TOOLTIP_POSLEFT         = "Healbot左側";
    HEALBOT_TOOLTIP_POSRIGHT        = "Healbot右側";
    HEALBOT_TOOLTIP_POSABOVE        = "Healbot上面";
    HEALBOT_TOOLTIP_POSBELOW        = "Healbot下面";
    HEALBOT_TOOLTIP_POSCURSOR       = "跟隨遊標";
    HEALBOT_TOOLTIP_RECOMMENDTEXT   = "建議的治療";
    HEALBOT_TOOLTIP_NONE            = "無可用";
    HEALBOT_TOOLTIP_CORPSE          = "屍體 of "; --check
HEALBOT_TOOLTIP_CD                      = " (CD ";
HEALBOT_TOOLTIP_SECS                    = "s)";
    HEALBOT_WORDS_SEC               = "秒";
    HEALBOT_WORDS_CAST              = "施放時間";
    HEALBOT_WORDS_UNKNOWN           = "未知";
    HEALBOT_WORDS_YES               = "是";
    HEALBOT_WORDS_NO                = "否";
HEALBOT_WORDS_THIN                      = "Thin";
HEALBOT_WORDS_THICK                     = "Thick";

    HEALBOT_WORDS_NONE              = "無";
HEALBOT_OPTIONS_ALT             = "Alt";
    HEALBOT_DISABLED_TARGET         = "目標";
    HEALBOT_OPTIONS_SHOWCLASSONBAR  = "顯示職業名稱";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR = "顯示生命";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS = "包含進入治療";
HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Separate incoming heals";
    HEALBOT_OPTIONS_BARHEALTH1      = "數值";
    HEALBOT_OPTIONS_BARHEALTH2      = "百分比";
    HEALBOT_OPTIONS_TIPTEXT         = "提示訊息";
    HEALBOT_OPTIONS_POSTOOLTIP      = "啟用提示";
    HEALBOT_OPTIONS_SHOWNAMEONBAR   = "顯示玩家名字";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "玩家名字按職業著色";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "包含小隊";

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS    = "設定成預設選項";
    HEALBOT_OPTIONS_SETDEFAULTSMSG = "重置所有設定為預設值";
    HEALBOT_OPTIONS_RIGHTBOPTIONS  = "右擊面板打開設定";

    HEALBOT_OPTIONS_HEADEROPTTEXT  = "標題設定";
    HEALBOT_OPTIONS_ICONOPTTEXT    = "圖示設定";
    HEALBOT_SKIN_HEADERBARCOL      = "動作條顏色";
    HEALBOT_SKIN_HEADERTEXTCOL     = "字體顏色";
    HEALBOT_OPTIONS_BUFFSTEXT1      = "設定施放Buff的技能";
    HEALBOT_OPTIONS_BUFFSTEXT2      = "檢查成員";
    HEALBOT_OPTIONS_BUFFSTEXT3      = "動作條顏色";
    HEALBOT_OPTIONS_BUFF           = "Buff ";
    HEALBOT_OPTIONS_BUFFSELF       = "對自己";
    HEALBOT_OPTIONS_BUFFPARTY      = "對小隊";
    HEALBOT_OPTIONS_BUFFRAID       = "對團隊";
    HEALBOT_OPTIONS_MONITORBUFFS   = "監測缺少的Buff";
    HEALBOT_OPTIONS_MONITORBUFFSC  = "戰鬥中同樣監測";
    HEALBOT_OPTIONS_ENABLESMARTCAST  = "當結束戰鬥開啟智能施法視窗";
    HEALBOT_OPTIONS_SMARTCASTSPELLS  = "包含法術";
    HEALBOT_OPTIONS_SMARTCASTDISPELL = "解除 Debuff";
    HEALBOT_OPTIONS_SMARTCASTBUFF    = "增加 Buff";
    HEALBOT_OPTIONS_SMARTCASTHEAL    = "治療法術";
    HEALBOT_OPTIONS_BAR2SIZE         = "法力條大小";
    HEALBOT_OPTIONS_SETSPELLS        = "設定法術";
    HEALBOT_OPTIONS_ENABLEDBARS     = "總是啟用動作條";
    HEALBOT_OPTIONS_DISABLEDBARS    = "忽略時間極短的Debuff";
    HEALBOT_OPTIONS_MONITORDEBUFFS  = "監測Debuff";
    HEALBOT_OPTIONS_DEBUFFTEXT1     = "設定解Debuff的技能";

    HEALBOT_OPTIONS_IGNOREDEBUFF         = "忽略的Debuff:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS    = "職業忽略";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "減速效果";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "短時間";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM   = "無害效果";
HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "When cure spell CoolDown > 1.5 secs (GCD)";
HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "When caster is known as friend";

    HEALBOT_OPTIONS_RANGECHECKFREQ       = "距離檢測頻率";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "隱藏隊伍框體";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "包含玩家和目標";
    HEALBOT_OPTIONS_DISABLEHEALBOT       = "關閉HealBot視窗";

    HEALBOT_ASSIST      = "協助";
    HEALBOT_FOCUS       = "焦點";
    HEALBOT_MENU        = "目錄";
    HEALBOT_MAINTANK    = "主坦";
    HEALBOT_MAINASSIST  = "主協助";
HEALBOT_STOP                            = "Stop";
HEALBOT_TELL                            = "Tell";

    HEALBOT_TITAN_SMARTCAST      = "智能施法視窗";
    HEALBOT_TITAN_MONITORBUFFS   = "監視Buff";
    HEALBOT_TITAN_MONITORDEBUFFS = "監視Debuff"
    HEALBOT_TITAN_SHOWBARS       = "顯示動作條";
    HEALBOT_TITAN_EXTRABARS      = "額外動作條";
    HEALBOT_BUTTON_TOOLTIP       = "左鍵 打開HealBot設定面板\n右鍵 (按住) 移動圖示";
    HEALBOT_TITAN_TOOLTIP        = "左鍵 打開HealBot設定面板";
    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "顯示小地圖按鈕";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT  = "顯示HoT圖示";
HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Show Raid Target";
    HEALBOT_OPTIONS_HOTONBAR     = "打開"
    HEALBOT_OPTIONS_HOTOFFBAR    = "關閉"
    HEALBOT_OPTIONS_HOTBARRIGHT  = "右邊"
    HEALBOT_OPTIONS_HOTBARLEFT   = "左邊"

    HEALBOT_ZONE_AB = "阿拉希盆地";
    HEALBOT_ZONE_AV = "奧特蘭克山谷";
    HEALBOT_ZONE_ES = "暴風之眼";
HEALBOT_ZONE_IC                         = "Isle of Conquest";
HEALBOT_ZONE_SA                         = "Strand of the Ancients";

    HEALBOT_OPTION_AGGROTRACK = "仇恨提醒"
    HEALBOT_OPTION_AGGROBAR = "閃爍條"
    HEALBOT_OPTION_AGGROTXT = ">> 顯示文字 <<"
HEALBOT_OPTION_AGGROIND                 = "Indicator"
    HEALBOT_OPTION_BARUPDFREQ = "閃爍頻率"
    HEALBOT_OPTION_USEFLUIDBARS = "動態監視"
    HEALBOT_OPTION_CPUPROFILE  = "使用CPU性能測試（插件CPU使用訊息）"
    HEALBOT_OPTIONS_RELOADUIMSG = "該選項需要重載UI，現在重載嗎？"

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE						= "PvE"
    HEALBOT_OPTIONS_ANCHOR        = "錨點"
HEALBOT_OPTIONS_BARSANCHOR              = "Bars anchor"
    HEALBOT_OPTIONS_TOPLEFT       = "左上"
    HEALBOT_OPTIONS_BOTTOMLEFT    = "左下"
    HEALBOT_OPTIONS_TOPRIGHT      = "右上"
    HEALBOT_OPTIONS_BOTTOMRIGHT   = "右下"
HEALBOT_OPTIONS_TOP                     = "Top"
HEALBOT_OPTIONS_BOTTOM                  = "Bottom"

    HEALBOT_PANEL_BLACKLIST       = "黑名單"

    HEALBOT_WORDS_REMOVEFROM      = "移除";
    HEALBOT_WORDS_ADDTO           = "增加";
    HEALBOT_WORDS_INCLUDE         = "包含";

    HEALBOT_OPTIONS_TTALPHA       = "透明度"
    HEALBOT_TOOLTIP_TARGETBAR     = "目標監視條"
    HEALBOT_OPTIONS_MYTARGET      = "我的目標"

    HEALBOT_DISCONNECTED_TEXT			= "<離線>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "顯示我的增益";
    HEALBOT_OPTIONS_TOOLTIPUPDATE       = "不斷更新提示";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "在增益效果結束前顯示";
    HEALBOT_OPTIONS_SHORTBUFFTIMER      = "短增益"
    HEALBOT_OPTIONS_LONGBUFFTIMER       = "長增益"

HEALBOT_OPTIONS_NOTIFY_MSG              = "Message"
    HEALBOT_WORDS_YOU                = "你";
    HEALBOT_NOTIFYOTHERMSG           = "在#n身上施放了#s";

    HEALBOT_OPTIONS_HOTPOSITION     = "圖示位置"
    HEALBOT_OPTIONS_HOTSHOWTEXT     = "顯示圖示文本"
    HEALBOT_OPTIONS_HOTTEXTCOUNT    = "次數"
    HEALBOT_OPTIONS_HOTTEXTDURATION = "持續時間"
    HEALBOT_OPTIONS_ICONSCALE       = "圖示縮放比例"
    HEALBOT_OPTIONS_ICONTEXTSCALE   = "圖示文字縮放比例"

    HEALBOT_OPTIONS_AGGROBARSIZE    = "OT狀態條尺寸"
    HEALBOT_OPTIONS_DOUBLETEXTLINES = "兩排文字"
    HEALBOT_OPTIONS_TEXTALIGNMENT   = "調整文字"
    HEALBOT_VEHICLE                 = "載具"
    HEALBOT_WORDS_ERROR		= "錯誤"
    HEALBOT_SPELL_NOT_FOUND         = "找不到法術" --check
HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Hide Tooltip in Combat"
    HEALBOT_OPTIONS_ENABLELIBQH     = "啟用快速治療函式庫 fastHealth"

HEALBOT_OPTIONS_BUFFNAMED               = "Enter the player names to watch for\n\n"
HEALBOT_WORD_ALWAYS                     = "Always";
HEALBOT_WORD_SOLO                       = "Solo";
HEALBOT_WORD_NEVER                      = "Never";
HEALBOT_SHOW_CLASS_AS_ICON              = "as icon";
HEALBOT_SHOW_CLASS_AS_TEXT              = "as text";
HEALBOT_SHOW_ROLE                       = "show role when set";

HEALBOT_SHOW_INCHEALS                   = "Show incoming heals";

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Display help",
               [2] = "[HealBot] /hb o -- Toggles options",
               [3] = "[HealBot] /hb ri -- Reset HealBot",
               [4] = "[HealBot] /hb t -- Toggle Healbot between disabled and enabled",
               [5] = "[HealBot] /hb bt -- Toggle Buff Monitor between disabled and enabled",
               [6] = "[HealBot] /hb dt -- Toggle Debuff Monitor between disabled and enabled",
               [7] = "[HealBot] /hb skin <skinName> -- Switch Skins",
               [8] = "[HealBot] /hb ui -- Reload UI",
               [9] = "[HealBot] /hb hs -- Display additional slash commands",
              }

HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- Reset options to default",
                [2] = "[HealBot] /hb aggro 2 <n> -- Set aggro level 2 on threat percentage <n>",
                [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                [4] = "[HealBot] /hb tr <Role> -- Set highest role priority for SubSort by Role. Valid Roles are 'TANK', 'HEALER' or 'DPS'",
                [5] = "[HealBot] /hb use10 -- Automatically use Engineering slot 10",
                [6] = "[HealBot] /hb pcs <n> -- Adjust the size of the Holy power charge indicator by <n>, Default value is 7 ",
                [7] = "[HealBot] /hb spt -- Self Pet toggle",
                [8] = "[HealBot] /hb ws -- Toggle Hide/Show the Weaken Soul icon instead of the PW:S with a -",
                [9] = "[HealBot] /hb rld <n> -- In seconds, how long the players name stays green after a res",
                [10] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
                [11] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
              }
              
HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Highlight mouseover"
HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Highlight target"
HEALBOT_OPTIONS_TESTBARS                = "Test Bars"
HEALBOT_OPTION_NUMBARS                  = "Number of Bars"
HEALBOT_OPTION_NUMTANKS                 = "Number of Tanks"
HEALBOT_OPTION_NUMMYTARGETS             = "Number of MyTargets"
HEALBOT_OPTION_NUMPETS                  = "Number of Pets"
HEALBOT_WORD_TEST                       = "Test";
HEALBOT_WORD_OFF                        = "Off";
HEALBOT_WORD_ON                         = "On";

HEALBOT_OPTIONS_TAB_PROTECTION          = "Protection"
HEALBOT_OPTIONS_TAB_CHAT                = "Chat"
HEALBOT_OPTIONS_TAB_HEADERS             = "Headers"
HEALBOT_OPTIONS_TAB_BARS                = "Bars"
HEALBOT_OPTIONS_TAB_ICONS               = "Icons"
HEALBOT_OPTIONS_TAB_WARNING             = "Warning"
HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Skin default for"
HEALBOT_OPTIONS_INCHEAL                 = "Incoming heals"
HEALBOT_WORD_ARENA                      = "Arena"
HEALBOT_WORD_BATTLEGROUND               = "Battle Ground"
HEALBOT_OPTIONS_TEXTOPTIONS             = "Text Options"
HEALBOT_WORD_PARTY                      = "Party"
HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto\nTarget"
HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Trinket"
HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Use Groups per Column"

HEALBOT_OPTIONS_MAINSORT                = "Main sort"
HEALBOT_OPTIONS_SUBSORT                 = "Sub sort"
HEALBOT_OPTIONS_SUBSORTINC              = "Also sub sort:"

HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "cast when"
HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Pressed"
HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Released"

HEALBOT_INFO_ADDONCPUUSAGE              = "== Addon CPU Usage in Seconds =="
HEALBOT_INFO_ADDONCOMMUSAGE             = "== Addon Comms Usage =="
HEALBOT_WORD_HEALER                     = "Healer"
HEALBOT_WORD_DAMAGER                    = "Damager"
HEALBOT_WORD_TANK                       = "Tank"
HEALBOT_WORD_LEADER                     = "Leader"
HEALBOT_WORD_VERSION                    = "Version"
HEALBOT_WORD_CLIENT                     = "Client"
HEALBOT_WORD_ADDON                      = "Addon"
HEALBOT_INFO_CPUSECS                    = "CPU Secs"
HEALBOT_INFO_MEMORYMB                   = "Memory MB"
HEALBOT_INFO_COMMS                      = "Comms KB"

HEALBOT_WORD_STAR                       = "Star"
HEALBOT_WORD_CIRCLE                     = "Circle"
HEALBOT_WORD_DIAMOND                    = "Diamond"
HEALBOT_WORD_TRIANGLE                   = "Triangle"
HEALBOT_WORD_MOON                       = "Moon"
HEALBOT_WORD_SQUARE                     = "Square"
HEALBOT_WORD_CROSS                      = "Cross"
HEALBOT_WORD_SKULL                      = "Skull"

HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Accept [HealBot] Skin: "
HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " from "
HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Share with"

HEALBOT_CHAT_ADDONID                    = "[HealBot]  "
HEALBOT_CHAT_NEWVERSION1                = "A newer version is available"
HEALBOT_CHAT_NEWVERSION2                = "at "..HEALBOT_ABOUT_URL
HEALBOT_CHAT_SHARESKINERR1              = " Skin not found for Sharing"
HEALBOT_CHAT_SHARESKINERR3              = " not found for Skin Sharing"
HEALBOT_CHAT_SHARESKINACPT              = "Share Skin accepted from "
HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Skins set to Defaults"
HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Custom Debuffs reset"
HEALBOT_CHAT_CHANGESKINERR1             = "Unknown skin: /hb skin "
HEALBOT_CHAT_CHANGESKINERR2             = "Valid skins:  "
HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Current spells copied for all specs"
HEALBOT_CHAT_UNKNOWNCMD                 = "Unknown slash command: /hb "
HEALBOT_CHAT_ENABLED                    = "Entering enabled state"
HEALBOT_CHAT_DISABLED                   = "Entering disabled state"
HEALBOT_CHAT_SOFTRELOAD                 = "Reload healbot requested"
HEALBOT_CHAT_HARDRELOAD                 = "Reload UI requested"
HEALBOT_CHAT_CONFIRMSPELLRESET          = "Spells have been reset"
HEALBOT_CHAT_CONFIRMCURESRESET          = "Cures have been reset"
HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Buffs have been reset"
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Unable to receive all Skin settings - Possibly missing SharedMedia, download from curse.com"
HEALBOT_CHAT_MACROSOUNDON               = "Sound not suppressed when using auto trinkets"
HEALBOT_CHAT_MACROSOUNDOFF              = "Sound suppressed when using auto trinkets"
HEALBOT_CHAT_MACROERRORON               = "Errors not suppressed when using auto trinkets"
HEALBOT_CHAT_MACROERROROFF              = "Errors suppressed when using auto trinkets"
HEALBOT_CHAT_ACCEPTSKINON               = "Share Skin - Show accept skin popup when someone shares a skin with you"
HEALBOT_CHAT_ACCEPTSKINOFF              = "Share Skin - Always ignore share skins from everyone"
HEALBOT_CHAT_USE10ON                    = "Auto Trinket - Use10 is on - You must enable an existing auto trinket for use10 to work"
HEALBOT_CHAT_USE10OFF                   = "Auto Trinket - Use10 is off"
HEALBOT_CHAT_SKINREC                    = " skin received from " 

HEALBOT_OPTIONS_SELFCASTS               = "Self casts only"
HEALBOT_OPTIONS_HOTSHOWICON             = "Show icon"
HEALBOT_OPTIONS_ALLSPELLS               = "All spells"
HEALBOT_OPTIONS_DOUBLEROW               = "Double row"
HEALBOT_OPTIONS_HOTBELOWBAR             = "Below bar"
HEALBOT_OPTIONS_OTHERSPELLS             = "Other spells"
HEALBOT_WORD_MACROS                     = "Macros"
HEALBOT_WORD_SELECT                     = "Select"
HEALBOT_OPTIONS_QUESTION                = "?"
HEALBOT_WORD_CANCEL                     = "Cancel"
HEALBOT_WORD_COMMANDS                   = "Commands"
HEALBOT_OPTIONS_BARHEALTH3              = "as health";
HEALBOT_SORTBY_ROLE                     = "Role"
HEALBOT_WORD_DPS                        = "DPS"
HEALBOT_CHAT_TOPROLEERR                 = " role not valid in this context - use 'TANK', 'DPS' or 'HEALER'"
HEALBOT_CHAT_NEWTOPROLE                 = "Highest top role is now "
HEALBOT_CHAT_SUBSORTPLAYER1             = "Player will be set to first in SubSort"
HEALBOT_CHAT_SUBSORTPLAYER2             = "Player will be sorted normally in SubSort"
HEALBOT_OPTIONS_SHOWREADYCHECK          = "Show Ready Check";
HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Self First"
HEALBOT_WORD_FILTER                     = "Filter"
HEALBOT_OPTION_AGGROPCTBAR              = "Move bar"
HEALBOT_OPTION_AGGROPCTTXT              = "Show text"
HEALBOT_OPTION_AGGROPCTTRACK            = "Track percentage" 
HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Low threat"
HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - High threat"
HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Tanking"
HEALBOT_OPTIONS_AGGROALERT              = "Bar alert level"
HEALBOT_OPTIONS_AGGROINDALERT           = "Indicator alert level"
HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Show active monitored HoT details"
HEALBOT_WORDS_MIN                       = "min"
HEALBOT_WORDS_MAX                       = "max"
HEALBOT_CHAT_SELFPETSON                 = "Self Pet switched on"
HEALBOT_CHAT_SELFPETSOFF                = "Self Pet switched off"
HEALBOT_WORD_PRIORITY                   = "Priority"
HEALBOT_VISIBLE_RANGE                   = "Within 100 yards"
HEALBOT_SPELL_RANGE                     = "Within spell range"
HEALBOT_WORD_RESET                      = "Reset"
HEALBOT_HBMENU                          = "HBmenu"
HEALBOT_ACTION_HBFOCUS                  = "Left click to set\nfocus on target"
HEALBOT_WORD_CLEAR                      = "Clear"
HEALBOT_WORD_SET                        = "Set"
HEALBOT_WORD_HBFOCUS                    = "HealBot Focus"
HEALBOT_WORD_OUTSIDE                    = "Outside"
HEALBOT_WORD_ALLZONE                    = "All zones"
HEALBOT_OPTIONS_TAB_ALERT               = "Alert"
HEALBOT_OPTIONS_TAB_SORT                = "Sort"
HEALBOT_OPTIONS_TAB_HIDE                = "Hide"
HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
HEALBOT_OPTIONS_TAB_ICONTEXT            = "Icon text"
HEALBOT_OPTIONS_TAB_TEXT                = "Bar text"
HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncolour"
HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Flash frequency"
HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Flash opacity"
HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Show duration from"
HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Duration warning from"
HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Reset custom debuffs"
HEALBOT_CMD_RESETSKINS                  = "Reset skins"
HEALBOT_CMD_CLEARBLACKLIST              = "Clear BlackList"
HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Toggle accept Skins from others"
HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Toggle Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Now Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "No longer Dislike Mount"
HEALBOT_CMD_COPYSPELLS                  = "Copy current spells to all specs"
HEALBOT_CMD_RESETSPELLS                 = "Reset spells"
HEALBOT_CMD_RESETCURES                  = "Reset cures"
HEALBOT_CMD_RESETBUFFS                  = "Reset buffs"
HEALBOT_CMD_RESETBARS                   = "Reset bar position"
HEALBOT_CMD_SUPPRESSSOUND               = "Toggle suppress sound when using auto trinkets"
HEALBOT_CMD_SUPPRESSERRORS              = "Toggle suppress errors when using auto trinkets"
HEALBOT_OPTIONS_COMMANDS                = "HealBot Commands"
HEALBOT_WORD_RUN                        = "Run"
HEALBOT_OPTIONS_MOUSEWHEEL              = "Use mouse wheel"
HEALBOT_OPTIONS_MOUSEUP                 = "Wheel up"
HEALBOT_OPTIONS_MOUSEDOWN               = "Wheel down"
HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Delete custom debuffs on priority 10"
HEALBOT_ACCEPTSKINS                     = "Accept Skins from others"
HEALBOT_SUPPRESSSOUND                   = "Auto Trinket: Suppress sound"
HEALBOT_SUPPRESSERROR                   = "Auto Trinket: Suppress errors"
HEALBOT_OPTIONS_CRASHPROT               = "Crash Protection"
HEALBOT_CP_MACRO_LEN                    = "Macro name must be between 1 and 14 characters"
HEALBOT_CP_MACRO_BASE                   = "Base macro name"
HEALBOT_CP_MACRO_SAVE                   = "Last saved at: "
HEALBOT_CP_STARTTIME                    = "Protect duration on logon"
HEALBOT_WORD_RESERVED                   = "Reserved"
HEALBOT_OPTIONS_COMBATPROT              = "Combat Protection"
HEALBOT_COMBATPROT_PARTYNO              = "bars Reserved for Party"
HEALBOT_COMBATPROT_RAIDNO               = "bars Reserved for Raid"

HEALBOT_WORD_HEALTH                     = "Health"
HEALBOT_OPTIONS_DONT_SHOW               = "Don't show"
HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Same as health (current health)"
HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Same as health (future health)"
HEALBOT_OPTIONS_FUTURE_HLTH             = "Future health"
HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Health bar";
HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Background bar";
HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Incoming heals";
HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Target: Always show"
HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Focus: Always show"
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: Groups of five"
HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Use Game Tooltip"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Show power counter"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Show holy power"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Show chi power"
HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Reverse Duration"
HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "only when solo"
HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "All Disease"
HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "All Magic"
HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "All Curse"
HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "All Poison"
HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Cast By"

HEALBOT_BLIZZARD_MENU                   = "Blizzard menu"
HEALBOT_HB_MENU                         = "Healbot menu"
HEALBOT_FOLLOW                          = "Follow"
HEALBOT_TRADE                           = "Trade"
HEALBOT_PROMOTE_RA                      = "Promote raid assistant"
HEALBOT_DEMOTE_RA                       = "Demote raid assistant"
HEALBOT_TOGGLE_ENABLED                  = "Toggle enabled"
HEALBOT_TOGGLE_MYTARGETS                = "Toggle My Targets"
HEALBOT_TOGGLE_PRIVATETANKS             = "Toggle private tanks"
HEALBOT_RESET_BAR                       = "Reset bar"
HEALBOT_HIDE_BARS                       = "Hide bars over 100 yards"
HEALBOT_RANDOMMOUNT                     = "Random Mount"
HEALBOT_RANDOMGOUNDMOUNT                = "Random Ground Mount"
HEALBOT_RANDOMPET                       = "Random Pet"
HEALBOT_ZONE_AQ40                       = "Ahn'Qiraj"
HEALBOT_ZONE_VASHJIR1                   = "Kelp'thar Forest"
HEALBOT_ZONE_VASHJIR2                   = "Shimmering Expanse"
HEALBOT_ZONE_VASHJIR3                   = "Abyssal Depths"
HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
HEALBOT_RESLAG_INDICATOR                = "Keep name green after res set to" 
HEALBOT_RESLAG_INDICATOR_ERROR          = "Keep name green after res must be between 1 and 30" 
HEALBOT_FRAMELOCK_BYPASS_OFF            = "Frame lock bypass turned Off"
HEALBOT_FRAMELOCK_BYPASS_ON             = "Frame lock bypass (Ctl+Alt+Left) turned On"
HEALBOT_RESTRICTTARGETBAR_ON            = "Restrict Target bar turned On"
HEALBOT_RESTRICTTARGETBAR_OFF           = "Restrict Target bar turned Off"
HEALBOT_PRELOADOPTIONS_ON               = "PreLoad Options turned On"
HEALBOT_PRELOADOPTIONS_OFF              = "PreLoad Options turned Off"
HEALBOT_AGGRO2_ERROR_MSG                = "To set aggro level 2, threat percentage must be between 25 and 95"
HEALBOT_AGGRO3_ERROR_MSG                = "To set aggro level 3, threat percentage must be between 75 and 100"
HEALBOT_AGGRO2_SET_MSG                  = "Aggro level 2 set at threat percentage "
HEALBOT_AGGRO3_SET_MSG                  = "Aggro level 3 set at threat percentage "
HEALBOT_WORD_THREAT                     = "Threat"
HEALBOT_AGGRO_ERROR_MSG                 = "Invalid aggro level - use 2 or 3"

HEALBOT_OPTIONS_QUERYTALENTS            = "Query talent data"       
HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Low Mana indicator"
HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Don't show"
HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignore aura events when resting"

HEALBOT_WORD_ENABLE                     = "Enable"
HEALBOT_WORD_DISABLE                    = "Disable"

HEALBOT_OPTIONS_MYCLASS                 = "My Class"

HEALBOT_OPTIONS_CONTENT_ABOUT           = "        About"
HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Mouse Wheel"
HEALBOT_OPTIONS_CONTENT_TEST            = "        Test"
HEALBOT_OPTIONS_CONTENT_USAGE           = "        Usage"
HEALBOT_OPTIONS_REFRESH                 = "Refresh"

HEALBOT_CUSTOM_CATEGORY                 = "Category"
HEALBOT_CUSTOM_CAT_CUSTOM               = "Custom"
HEALBOT_CUSTOM_CAT_02                   = "A - B"   -- ****************************************************
HEALBOT_CUSTOM_CAT_03                   = "C - D"   -- Custom Debuff Categories can be translated
HEALBOT_CUSTOM_CAT_04                   = "E - F"   -- 
HEALBOT_CUSTOM_CAT_05                   = "G - H"   -- If translating into a language with a completely different alphabet,
HEALBOT_CUSTOM_CAT_06                   = "I - J"   -- the descriptions of HEALBOT_CUSTOM_CAT_02 - HEALBOT_CUSTOM_CAT_14 can be changed.
HEALBOT_CUSTOM_CAT_07                   = "K - L"   -- Just ensure all 13 variables are used
HEALBOT_CUSTOM_CAT_08                   = "M - N"   -- 
HEALBOT_CUSTOM_CAT_09                   = "O - P"   -- Setting debuffs in HEALBOT_CUSTOM_DEBUFF_CATS,
HEALBOT_CUSTOM_CAT_10                   = "Q - R"   -- The only rule is the category number needs to match the last digits of the variable names, for example:
HEALBOT_CUSTOM_CAT_11                   = "S - T"   -- If HEALBOT_DEBUFF_AGONIZING_FLAMES starts with an T in a different region
HEALBOT_CUSTOM_CAT_12                   = "U - V"   -- the category would be 11, simply change the 2 to 11.
HEALBOT_CUSTOM_CAT_13                   = "W - X"   --
HEALBOT_CUSTOM_CAT_14                   = "Y - Z"   -- ****************************************************

HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Everyone"
HEALBOT_CUSTOM_CASTBY_ENEMY             = "Enemy"
HEALBOT_CUSTOM_CASTBY_FRIEND            = "Friend"

HEALBOT_CUSTOM_DEBUFF_CATS = {
        [HEALBOT_DEBUFF_ACID_DRENCHED_MANDIBLES] = 2,
        [HEALBOT_DEBUFF_AGONIZING_FLAMES]      = 2,
        [HEALBOT_DEBUFF_BOILING_BLOOD]         = 2,
        [HEALBOT_DEBUFF_BURN]                  = 2,
        [HEALBOT_DEBUFF_BURNING_BILE]          = 2,
        [HEALBOT_DEBUFF_CHILLED_BONE]          = 3,
        [HEALBOT_DEBUFF_COMBUSTION]            = 3,
        [HEALBOT_DEBUFF_CONFLAGRATION]         = 3,
        [HEALBOT_DEBUFF_CONSUMING_FLAMES]      = 3,
        [HEALBOT_DEBUFF_CONSUMPTION]           = 3,
        [HEALBOT_DEBUFF_CORROSION]             = 3,
        [HEALBOT_DEBUFF_DARK_BARRAGE]          = 3,
        [HEALBOT_DEBUFF_DEFILE]                = 3,
        [HEALBOT_DEBUFF_DELIRIOUS_SLASH]       = 3,
        [HEALBOT_DEBUFF_DOOMFIRE]              = 3,
        [HEALBOT_DEBUFF_ENCAPSULATE]           = 4,
        [HEALBOT_DEBUFF_ESSENCE_BLOOD_QUEEN]   = 4,
        [HEALBOT_DEBUFF_EXPLOSIVE_CINDERS]     = 4,
        [HEALBOT_DEBUFF_EXPOSE_WEAKNESS]       = 4,
        [HEALBOT_DEBUFF_FATAL_ATTRACTION]      = 4,
        [HEALBOT_DEBUFF_FEL_RAGE]              = 4,
        [HEALBOT_DEBUFF_FEL_RAGE2]             = 4,
        [HEALBOT_DEBUFF_FERAL_POUNCE]          = 4, 
        [HEALBOT_DEBUFF_FIERY_COMBUSTION]      = 4,
        [HEALBOT_DEBUFF_FIRE_BLOOM]            = 4,
        [HEALBOT_DEBUFF_FIRE_BOMB]             = 4,
        [HEALBOT_DEBUFF_FLAME_SEAR]            = 4, 
        [HEALBOT_DEBUFF_FLASH_FREEZE]          = 4,
        [HEALBOT_DEBUFF_FROST_BEACON]          = 4,
        [HEALBOT_DEBUFF_FROST_BLAST]           = 4,
        [HEALBOT_DEBUFF_FROST_BREATH]          = 4,
        [HEALBOT_DEBUFF_FROST_TOMB]            = 4,
        [HEALBOT_DEBUFF_GAS_SPORE]             = 5,
        [HEALBOT_DEBUFF_GASEOUS_BLOAT]         = 5,
        [HEALBOT_DEBUFF_GASTRIC_BLOAT]         = 5,
        [HEALBOT_DEBUFF_GLITTERING_SPARKS]     = 5,
        [HEALBOT_DEBUFF_GRAVITY_BOMB]          = 5,
        [HEALBOT_DEBUFF_GRAVITY_CORE]          = 5,
        [HEALBOT_DEBUFF_GRAVITY_CRUSH]         = 5,
        [HEALBOT_DEBUFF_GRIEVOUS_BITE]         = 5,         
        [HEALBOT_DEBUFF_GRIEVOUS_THROW]        = 5,
        [HEALBOT_DEBUFF_GUT_SPRAY]             = 5,
        [HEALBOT_DEBUFF_HARVEST_SOUL]          = 5,
        [HEALBOT_DEBUFF_ICEBOLT]               = 6,
        [HEALBOT_DEBUFF_ICE_TOMB]              = 6,
        [HEALBOT_DEBUFF_IMPALE]                = 6,
        [HEALBOT_DEBUFF_IMPALED]               = 6,
        [HEALBOT_DEBUFF_IMPALING_SPINE]        = 6,
        [HEALBOT_DEBUFF_INCINERATE_FLESH]      = 6,
        [HEALBOT_DEBUFF_INFEST]                = 6,
        [HEALBOT_DEBUFF_INSTABILITY]           = 6,
        [HEALBOT_DEBUFF_IRON_ROOTS]            = 6,
        [HEALBOT_DEBUFF_JAGGED_KNIFE]          = 6, 
        [HEALBOT_DEBUFF_LEGION_FLAME]          = 7, 
        [HEALBOT_DEBUFF_LIGHTNING_ROD]         = 7,
        [HEALBOT_DEBUFF_FALLEN_CHAMPION]       = 8,
        [HEALBOT_DEBUFF_MISTRESS_KISS]         = 8,
        [HEALBOT_DEBUFF_MUTATED_INFECTION]     = 8,
        [HEALBOT_DEBUFF_MUTATED_PLAGUE]        = 8,
        [HEALBOT_DEBUFF_MYSTIC_BUFFET]         = 8,
        [HEALBOT_DEBUFF_NAPALM_SHELL]          = 8,
        [HEALBOT_DEBUFF_NECROTIC_PLAGUE]       = 8,
        [HEALBOT_DEBUFF_NECROTIC_STRIKE]       = 8,
        [HEALBOT_DEBUFF_PACT_DARKFALLEN]       = 9,
        [HEALBOT_DEBUFF_PARALYTIC_TOXIN]       = 9,
        [HEALBOT_DEBUFF_PARASITIC_INFECT]      = 9,
        [HEALBOT_DEBUFF_PARASITIC_SHADOWFIEND] = 9,
        [HEALBOT_DEBUFF_PENETRATING_COLD]      = 9,
        [HEALBOT_DEBUFF_RUNE_OF_BLOOD]         = 10,
        [HEALBOT_DEBUFF_SACRIFICE]             = 11,
        [HEALBOT_DEBUFF_SARA_BLESSING]         = 11,
        [HEALBOT_DEBUFF_SHADOW_PRISON]         = 11,
        [HEALBOT_DEBUFF_SLAG_POT]              = 11,
        [HEALBOT_DEBUFF_SNOBOLLED]             = 11,
        [HEALBOT_DEBUFF_SOUL_CONSUMPTION]      = 11,
        [HEALBOT_DEBUFF_SPINNING_PAIN_SPIKE]   = 11,
        [HEALBOT_DEBUFF_STONE_GRIP]            = 11,
        [HEALBOT_DEBUFF_SWARMING_SHADOWS]      = 11,
        [HEALBOT_DEBUFF_TOUCH_OF_DARKNESS]     = 11,
        [HEALBOT_DEBUFF_TOUCH_OF_LIGHT]        = 11,
        [HEALBOT_DEBUFF_TOXIC_SPORES]          = 11,
        [HEALBOT_DEBUFF_VILE_GAS]              = 12,
        [HEALBOT_DEBUFF_VOLATILE_OOZE]         = 12,
        [HEALBOT_DEBUFF_WATERLOGGED]           = 13,
        [HEALBOT_DEBUFF_WEB_WRAP]              = 13,
    }

HEALBOT_ABOUT_DESC1                    = "Add a panel with skinable bars for healing, decursive, buffing, ressing and aggro tracking"
HEALBOT_ABOUT_WEBSITE                  = "Website:"
HEALBOT_ABOUT_AUTHORH                  = "Author:"
HEALBOT_ABOUT_AUTHORD                  = "Strife"
HEALBOT_ABOUT_EMAILH                   = "Email:"
HEALBOT_ABOUT_EMAILD                   = "healbot@outlook.com"
HEALBOT_ABOUT_CATH                     = "Category:"
HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
HEALBOT_ABOUT_CREDITH                  = "Credits:"
HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza"  -- Anyone taking on translations (if required), feel free to add yourself here.
HEALBOT_ABOUT_LOCALH                   = "Localizations:"
HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW"
HEALBOT_ABOUT_FAQH                     = "Frequently Asked Questions"
HEALBOT_ABOUT_FAQ_QUESTION             = "Question"
HEALBOT_ABOUT_FAQ_ANSWER               = "Answer"

HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - All the bars are White, what happened",
                                  [2]   = "Casting - Sometimes the cursor turns blue and I can't do anything",
                                  [3]   = "Macros - Do you have any cooldown examples",
                                  [4]   = "Macros - Do you have any spell casting examples",
                                  [5]   = "Mouse - How do I use my mouseover macros with the mouse wheel",
                                  [6]   = "Options - Can bars be sorted by groups, for example have 2 groups per column",
                                  [7]   = "Options - Can I hide all the bars and only show those needing a debuff removed",
                                  [8]   = "Options - Can I hide the incoming heals",
                                  [9]   = "Options - Healbot does not save my options when i logout/logon",
                                  [10]   = "Options - How do I always use enabled settings",
                                  [11]  = "Options - How do I disable healbot automatically",
                                  [12]  = "Options - How do I make the bars grow a different direction",
                                  [13]  = "Options - How do I setup 'My Targets'",
                                  [14]  = "Options - How do I setup 'Private Tanks'",
                                  [15]  = "Options - Will Healbot create a bar for an NPC",
                                  [16]  = "Range - I can't see when people are out of range, how do I fix this",
                                  [17]  = "Spells - Healbot casts a different spell to my setup",
                                  [18]  = "Spells - I can no longer cast heals on unwounded targets",
                              }

HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "This is due to options set on the Spells tab \n" ..
                                          "try changing the following and testing: \n\n" ..
                                          "     1: On the spells tab: Turn on Always Use Enabled \n" ..
                                          "     2: On the spells tab: Turn off SmartCast \n\n" ..
                                          "Note: It is expected that most users will want to \n"..
                                          "          turn SmartCast back on \n\n" ..
                                          "Note: It is expected that experienced users will want to \n" ..
                                          "          turn off Always Use Enabled  \n" ..
                                          "          and set the spells for disabled bars"
                                          
HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "You are monitoring for missing buffs \n\n" .. 
                                          "This can be turned off on the buffs tab \n" ..
                                          "Alternatively click on the bar and cast the buff",
                                  [2]   = "This is blizzard functionality, not Healbot \n\n" .. 
                                          "Using the standard blizzard frames, \n" ..
                                          "try casting a spell thats on Cooldown \n" ..
                                          "Notice how the cursor turns blue. \n\n" ..
                                          "Note: Nothing can be done to prevent this while \n" ..
                                          "in combat, since WoW 2.0 Blizzard has locked down \n" ..
                                          "the ui while in combat stopping all addons from \n" ..
                                          "changing spells or targets from what has been predefined \n\n" ..
                                          "It may help to monitor the spell cooldown in the tooltips",
                                  [3]   = "Yes \n\n"..
                                          "Paladin Hand of Salvation cooldown macro example: \n\n" ..
                                          "    #show Hand of Salvation \n" ..
                                          '    /script local n=UnitName("hbtarget"); ' .. "\n" ..
                                          '    if GetSpellCooldown("Hand of Salvation")==0 then ' .. " \n" ..
                                          '        SendChatMessage("Hand of Salvation on "..n,"YELL") ' .. "\n" ..
                                          '        SendChatMessage("Hand of Salvation!","WHISPER",nil,n) ' .. "\n" ..
                                          "    end; \n" ..
                                          "    /cast [@hbtarget] Hand of Salvation",
                                  [4]   = "Yes \n\n"..
                                          "Preist Flash Heal, example using both trinkets: \n\n" ..
                                          "    #show Flash Heal \n" ..
                                          "    /script UIErrorsFrame:Hide() \n" ..
                                          "    /console Sound_EnableSFX 0 \n" ..
                                          "    /use 13 \n" ..
                                          "    /use 14 \n" ..
                                          "    /console Sound_EnableSFX 1 \n" ..
                                          "    /cast [@hbtarget] Flash Heal \n" ..
                                          "    /script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                  [5]   = "1: On the Mouse Wheel tab: Turn off Use Mouse Wheel \n" ..
                                          "2: Bind your macros to blizzard's bindings with [@mouseover] \n\n\n" ..
                                          "Eample macro: \n\n" ..
                                          "    #showtooltip Flash Heal \n" ..
                                          "    /cast [@mouseover] Flash Heal \n",
                                  [6]   = "Yes \n\n\n"..
                                          "With Headers: \n" ..
                                          "     1: On the Skins>Headers tab, switch on Show Headers \n" ..
                                          "     2: On the Skins>Bars tab, set Number of Groups per column \n\n" ..
                                          "Without Headers: \n" ..
                                          "     1: On the Skins>Bars tab, switch on Use Groups per Column \n" ..
                                          "     2: On the Skins>Bars tab, set Number of Groups per column ",
                                  [7]   = "Yes \n\n"..
                                          "1: On the Skins>Healing>Alert tab, set Alert Level to 0 \n" ..
                                          "2: On the Skins>Aggro tab, turn off the Aggro Monitor \n" .. 
                                          "3: On the Skins>Bars tab, set Disabled opacity to 0 \n" ..
                                          "4: On the Skins>Bars tab, set Background opacity to 0 \n" ..
                                          "5: On the Skins>Bar Text tab, click on the bar Disabled \n" ..
                                          "     and set the Disabled text opacity to 0 \n" ..
                                          "6: On the Skins>General tab, click on the bar Background \n" ..
                                          "     and set the Background opacity to 0 \n" ..
                                          "7: On the Cure tab, Turn on debuff monitoring",
                                  [8]   = "Yes \n\n"..
                                          "1: On the Skins>Bars tab, set Incoming Heals to Dont Show \n" ..
                                          "2: On the Skins>Bar Text tab, \n" ..
                                          "          set Show Health on Bar to No Incoming Heals",
                                  [9]   = "This has been present since a change in WoW 3.2, \n" ..
                                          "it can affects characters with weird letters in their name \n\n" ..
                                          "If your on Vista or Win7, try the follow: \n"..
                                          "     change system locale to English (for non-unicode programs) \n" ..
                                          "     in Control Panel > Region and Language > Administrative Tab",

                                  [10]   = "On the spells tab turn on Always Use Enabled \n\n" ..
                                          "Some my also want to set the Alert Level to 100 \n" ..
                                          "This can be done on the Skins>Healing>Alert tab",
                                  [11]  = "Disable for a character: \n\n" ..
                                          "     1: Open the General tab \n" ..
                                          "     2: Turn on the Disable option \n\n\n" ..
                                          "Disable when solo: \n\n" ..
                                          "     1: Open the General tab \n" ..
                                          "     2: To the right of the Disable option, Select only when solo \n" ..
                                          "     3: Turn on the Disable option",
                                  [12]  = "Change the Bars Anchor setting on the Skins>General tab  \n\n" ..
                                          "     Top Right:        the bars will grow Down and Left \n" ..
                                          "     Top Left:          the bars will grow Down and Right \n" ..
                                          "     Bottom Right:  the bars will grow Up and Left \n" ..
                                          "     Bottom Left:     the bars will grow Up and Right",
                                  [13]  = "My Targets allows you to create a list of Targets you want to \n" ..
                                          "group separately from others, similar to the MT group \n\n" ..
                                          "The following options are available for \n" .. 
                                          "adding/removing people to/from the My Targets group \n\n" ..
                                          "     - Shift+Ctrl+Alt+Right click on the bar \n" ..
                                          '     - Use the Healbot Menu, enter "hbmenu" on the spells tab ' .. "\n" ..
                                          "     - Use the Mouse Wheel, set on the Mouse Wheel tab",
                                  [14]  = "Private Tanks can be added to the Main Tanks list, \n" ..
                                          "the Private tanks are only visible in your Healbot \n" ..
                                          "and do not affect other players or addons \n\n" ..
                                          "The following options are available for \n" ..
                                          "adding/removing people to/from the Tanks list \n\n" ..
                                          '     - Use the Healbot Menu, enter "hbmenu" on the spells tab ' .. "\n" ..
                                          "     - Use the Mouse Wheel, set on the Mouse Wheel tab",
                                  
                                  [15]  = "Yes \n\n"..
                                          "     1: On the Skins>Healing tab, turn on Focus \n" ..
                                          "     2: set your focus on the NPC (or PC not in raid/party) \n" ..
                                          "          Healbot will create a bar in your My Targets list \n\n" ..
                                          "Note: If in a combat situation where you zone in and out while \n" ..
                                          "          in combat and need to reset focus on an NPC \n" ..
                                          "          on the Skins>Healing tab set Focus: always show to on \n" ..
                                          "          This will keep the bar available during combat. \n\n" ..
                                          "Note: The HealBot Menu has the option 'Set HealBot Focus' \n" ..
                                          "          This can make setting focus easy on NPC's and \n" ..
                                          "          serves as a reminder to set focus. \n\n" ..
                                          "          Enter 'hbmenu' on the spells tab to use HealBot Menu \n" ..
                                          "          or use the Mouse Wheel tab to and set HealBot Menu",
                                  [16]  = "1:  On the Skins>Bars tab, adjust the disabled bar opacity \n" ..
                                          "2:  On the Skins>Bars Text tab, adjust the disabled text opacity \n" ..
                                          "       To do this click on the bar labeled Disabled. \n\n" ..
                                          "Some my also want to set the Alert Level to 100 \n" ..
                                          "This can be done on the Skins>Healing>Alert tab",
                                  [17]  = "Actually Healbot is casting exacly as the setup. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                              }

HEALBOT_OPTIONS_SKINAUTHOR              = "Skin Author:"
HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Avoid\nBlue Cursor"
HEALBOT_PLAYER_OF_REALM                 = "of"
    
    HEALBOT_OPTIONS_LANG                    = "Language"
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN - 月夜寒星@银月)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK - by Strife)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS - by Strife)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR - by Kubik)"
    HEALBOT_OPTIONS_LANG_DEDE               = "German (deDE - translator required)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU - by Von)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT - by Brezza)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR - translator required)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR - by aldetal)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russian (ruRU - translator required)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES - translator required)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW - translator required)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Failed to load addon for localization"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Reason for failure is:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note in the current verison, this is the only warning for"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Failed to load headbot addon"
    
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "        " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "        " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_PROT      = "        " .. HEALBOT_OPTIONS_TAB_PROTECTION
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "        " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "        " .. HEALBOT_SKIN_DEBTEXT
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "        " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "        " .. HEALBOT_OPTIONS_TAB_WARNING
end
