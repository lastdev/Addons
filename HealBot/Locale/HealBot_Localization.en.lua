-- English maintained by Strife.

-------------
-- ENGLISH --
-------------
--
--
--
--
--
--
--
--
--

function HealBot_Lang_enUK()
    HEALBOT_enWORD_COLOUR_SUFFIX = "our"
    HealBot_Lang_enALL()
end

function HealBot_Lang_enUS()
    HEALBOT_enWORD_COLOUR_SUFFIX = "or"
    HealBot_Lang_enALL()
end

function HealBot_Lang_enALL()

    -----------------
    -- Translation --
    -----------------

    -- Class
    HEALBOT_DRUID                           = "Druid";
    HEALBOT_HUNTER                          = "Hunter";
    HEALBOT_MAGE                            = "Mage";
    HEALBOT_PALADIN                         = "Paladin";
    HEALBOT_PRIEST                          = "Priest";
    HEALBOT_ROGUE                           = "Rogue";
    HEALBOT_SHAMAN                          = "Shaman";
    HEALBOT_WARLOCK                         = "Warlock";
    HEALBOT_WARRIOR                         = "Warrior";
    HEALBOT_DEATHKNIGHT                     = "Death Knight";
    HEALBOT_MONK                            = "Monk";

    HEALBOT_DISEASE                         = "Disease";
    HEALBOT_MAGIC                           = "Magic";
    HEALBOT_CURSE                           = "Curse";
    HEALBOT_POISON                          = "Poison";

    HB_TOOLTIP_OFFLINE                      = "Offline";
    HB_OFFLINE                              = "offline"; -- has gone offline msg
    HB_ONLINE                               = "online"; -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " loaded.";

    HEALBOT_ACTION_OPTIONS                  = "Options";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "Defaults";
    HEALBOT_OPTIONS_CLOSE                   = "Close";
    HEALBOT_OPTIONS_HARDRESET               = "ReloadUI"
    HEALBOT_OPTIONS_SOFTRESET               = "ResetHB"
    HEALBOT_OPTIONS_TAB_GENERAL             = "General";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Spells";
    HEALBOT_OPTIONS_TAB_HEALING             = "Healing";
    HEALBOT_OPTIONS_TAB_CDC                 = "Cure";
    HEALBOT_OPTIONS_TAB_SKIN                = "Skins";
    HEALBOT_OPTIONS_TAB_TIPS                = "Tips";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Buffs"

    HEALBOT_OPTIONS_BARALPHA                = "Enabled opacity";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Incoming heals opacity";
    HEALBOT_OPTIONS_BARALPHABACK            = "Background bar opacity";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Out of range opacity";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Lock position";
    HEALBOT_OPTIONS_AUTOSHOW                = "Close automatically";
    HEALBOT_OPTIONS_PANELSOUNDS             = "Play sound on open";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Hide options button";
    HEALBOT_OPTIONS_PROTECTPVP              = "Avoid PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Chat Options";

    HEALBOT_OPTIONS_FRAMESCALE              = "Frame Scale"
    HEALBOT_OPTIONS_SKINTEXT                = "Use skin"
    HEALBOT_SKINS_STD                       = "Standard"
    HEALBOT_OPTIONS_SKINTEXTURE             = "Texture"
    HEALBOT_OPTIONS_SKINHEIGHT              = "Height"
    HEALBOT_OPTIONS_SKINWIDTH               = "Width"
    HEALBOT_OPTIONS_SKINNUMCOLS             = "No. columns"
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "No. groups per column"
    HEALBOT_OPTIONS_SKINBRSPACE             = "Row spacer"
    HEALBOT_OPTIONS_SKINBCSPACE             = "Col spacer"
    HEALBOT_OPTIONS_EXTRASORT               = "Sort raid bars by"
    HEALBOT_SORTBY_NAME                     = "Name"
    HEALBOT_SORTBY_CLASS                    = "Class"
    HEALBOT_SORTBY_GROUP                    = "Group"
    HEALBOT_SORTBY_MAXHEALTH                = "Max health"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "New debuff"
    HEALBOT_OPTIONS_DELSKIN                 = "Delete"
    HEALBOT_OPTIONS_NEWSKINTEXT             = "New skin"
    HEALBOT_OPTIONS_SAVESKIN                = "Save"
    HEALBOT_OPTIONS_SKINBARS                = "Bar options"
    HEALBOT_SKIN_ENTEXT                     = "Enabled"
    HEALBOT_SKIN_DISTEXT                    = "Disabled"
    HEALBOT_SKIN_DEBTEXT                    = "Debuff"
    HEALBOT_SKIN_BACKTEXT                   = "Background"
    HEALBOT_SKIN_BORDERTEXT                 = "Border"
    HEALBOT_OPTIONS_SKINFONT                = "Font"
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Font Size"
    HEALBOT_OPTIONS_SKINFOUTLINE            = "Font Outline"
    HEALBOT_OPTIONS_BARALPHADIS             = "Disabled opacity"
    HEALBOT_OPTIONS_SHOWHEADERS             = "Show headers"

    HEALBOT_OPTIONS_ITEMS                   = "Items";

    HEALBOT_OPTIONS_COMBOCLASS              = "Key combos for";
    HEALBOT_OPTIONS_CLICK                   = "Click";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Always use enabled";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "No messages";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Notify self";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Notify target";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Notify party";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Notify raid";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "Notify chan";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Notify for resurrection only";

    HEALBOT_OPTIONS_CDCBARS                 = "Bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "Change health bar col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_OPTIONS_CDCSHOWABARS            = "Change aggro bar col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_OPTIONS_CDCWARNINGS             = "Debuff warnings";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Show debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Display warning on debuff";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Play sound on debuff";
    HEALBOT_OPTIONS_SOUND                   = "Sound"

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Healing bars";
    HEALBOT_OPTIONS_SELFHEALS               = "Self"
    HEALBOT_OPTIONS_PETHEALS                = "Pets"
    HEALBOT_OPTIONS_GROUPHEALS              = "Group";
    HEALBOT_OPTIONS_TANKHEALS               = "Main tanks";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Private main tanks";
    HEALBOT_OPTIONS_TARGETHEALS             = "Targets";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raid";
    HEALBOT_OPTIONS_EMERGFILTER             = "Show raid bars for";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Configure classes for";
    HEALBOT_OPTIONS_COMBOBUTTON             = "Button";
    HEALBOT_OPTIONS_BUTTONLEFT              = "Left";
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Middle";
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Right";
    HEALBOT_OPTIONS_BUTTON4                 = "Button4";
    HEALBOT_OPTIONS_BUTTON5                 = "Button5";
    HEALBOT_OPTIONS_BUTTON6                 = "Button6";
    HEALBOT_OPTIONS_BUTTON7                 = "Button7";
    HEALBOT_OPTIONS_BUTTON8                 = "Button8";
    HEALBOT_OPTIONS_BUTTON9                 = "Button9";
    HEALBOT_OPTIONS_BUTTON10                = "Button10";
    HEALBOT_OPTIONS_BUTTON11                = "Button11";
    HEALBOT_OPTIONS_BUTTON12                = "Button12";
    HEALBOT_OPTIONS_BUTTON13                = "Button13";
    HEALBOT_OPTIONS_BUTTON14                = "Button14";
    HEALBOT_OPTIONS_BUTTON15                = "Button15";

    HEALBOT_CLASSES_ALL                     = "All classes";
    HEALBOT_CLASSES_MELEE                   = "Melee";
    HEALBOT_CLASSES_RANGES                  = "Ranged";
    HEALBOT_CLASSES_HEALERS                 = "Healers";
    HEALBOT_CLASSES_CUSTOM                  = "Custom";

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Show tooltips";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Show detailed spell information";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Show spell cooldown";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Show target information";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Show heal over time recommendation";
    HEALBOT_TOOLTIP_POSDEFAULT              = "Default location";
    HEALBOT_TOOLTIP_POSLEFT                 = "Left of Healbot";
    HEALBOT_TOOLTIP_POSRIGHT                = "Right of Healbot";
    HEALBOT_TOOLTIP_POSABOVE                = "Above Healbot";
    HEALBOT_TOOLTIP_POSBELOW                = "Below Healbot";
    HEALBOT_TOOLTIP_POSCURSOR               = "Next to Cursor";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Heal over time Recommendation";
    HEALBOT_TOOLTIP_NONE                    = "none available";
    HEALBOT_TOOLTIP_CORPSE                  = "Corpse of ";
    HEALBOT_TOOLTIP_CD                      = " (CD ";
    HEALBOT_TOOLTIP_SECS                    = "s)";
    HEALBOT_WORDS_SEC                       = "sec";
    HEALBOT_WORDS_CAST                      = "Cast";
    HEALBOT_WORDS_UNKNOWN                   = "Unknown";
    HEALBOT_WORDS_YES                       = "Yes";
    HEALBOT_WORDS_NO                        = "No";
    HEALBOT_WORDS_THIN                      = "Thin";
    HEALBOT_WORDS_THICK                     = "Thick";

    HEALBOT_WORDS_NONE                      = "None";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_DISABLED_TARGET                 = "Target";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Show class on bar";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Show health on bar";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Include incoming heals";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Separate incoming heals";
    HEALBOT_OPTIONS_BARHEALTH1              = "as delta";
    HEALBOT_OPTIONS_BARHEALTH2              = "as percentage";
    HEALBOT_OPTIONS_TIPTEXT                 = "Tooltip information";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Position tooltip";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Show name on bar";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." text by class";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Include raid groups";

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS             = "Set defaults";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Reset all options to default values";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "Right click opens options";

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "Header options";
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Icon options";
    HEALBOT_SKIN_HEADERBARCOL               = "Bar col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_SKIN_HEADERTEXTCOL              = "Text col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Spell to buff";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "check members";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s";
    HEALBOT_OPTIONS_BUFF                    = "Buff ";
    HEALBOT_OPTIONS_BUFFSELF                = "on self";
    HEALBOT_OPTIONS_BUFFPARTY               = "on party";
    HEALBOT_OPTIONS_BUFFRAID                = "on raid";
    HEALBOT_OPTIONS_MONITORBUFFS            = "Monitor for missing buffs";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "also in combat";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "SmartCast out of combat";
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Include spells";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Remove debuffs";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Add buffs";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Healing spells";
    HEALBOT_OPTIONS_BAR2SIZE                = "Power bar size";
    HEALBOT_OPTIONS_SETSPELLS               = "Set spells for";
    HEALBOT_OPTIONS_ENABLEDBARS             = "Enabled bars at all times";
    HEALBOT_OPTIONS_DISABLEDBARS            = "Disabled bars when out of combat";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Monitor to remove debuffs";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Spell to remove debuffs";

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignore debuffs:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "By class";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Slow movement";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Short duration";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Non harmful";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "When cure spell CoolDown > 1.5 secs (GCD)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "When caster is known as friend";

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Range, Aura and Aggro check frequency";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Hide party frames";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Include player and target";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Disable HealBot";

    HEALBOT_ASSIST                          = "Assist";
    HEALBOT_FOCUS                           = "Focus";
    HEALBOT_MENU                            = "Menu";
    HEALBOT_MAINTANK                        = "MainTank";
    HEALBOT_STOP                            = "Stop";
    HEALBOT_TELL                            = "Tell";

    HEALBOT_TITAN_SMARTCAST                 = "SmartCast";
    HEALBOT_TITAN_MONITORBUFFS              = "Monitor buffs";
    HEALBOT_TITAN_MONITORDEBUFFS            = "Monitor debuffs"
    HEALBOT_TITAN_SHOWBARS                  = "Show bars for";
    HEALBOT_TITAN_EXTRABARS                 = "Extra bars";
    HEALBOT_BUTTON_TOOLTIP                  = "Click to toggle HealBot options panel\nClick and hold to move this icon";
    HEALBOT_TITAN_TOOLTIP                   = "Left click to toggle HealBot options panel";
    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Show minimap button";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Show HoT";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Show Raid Target";
    HEALBOT_OPTIONS_HOTONBAR                = "On bar";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Off bar";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "Right side";
    HEALBOT_OPTIONS_HOTBARLEFT              = "Left side";

    HEALBOT_ZONE_AB                         = GetMapNameByID(461) or "Arathi Basin";
    HEALBOT_ZONE_AV                         = GetMapNameByID(401) or "Alterac Valley";
    HEALBOT_ZONE_ES                         = GetMapNameByID(482) or "Eye of the Storm";
    HEALBOT_ZONE_IC                         = GetMapNameByID(540) or "Isle of Conquest";
    HEALBOT_ZONE_SA                         = GetMapNameByID(512) or "Strand of the Ancients";

    HEALBOT_OPTION_AGGROTRACK               = "Monitor Aggro"
    HEALBOT_OPTION_AGGROBAR                 = "Bar"
    HEALBOT_OPTION_AGGROTXT                 = ">> Text <<"
    HEALBOT_OPTION_AGGROIND                 = "Indicator"
    HEALBOT_OPTION_BARUPDFREQ               = "Refresh Multiplier"
    HEALBOT_OPTION_USEFLUIDBARS             = "Use fluid bars"
    HEALBOT_OPTION_CPUPROFILE               = "Use CPU profiler (Addons CPU usage Info)"
    HEALBOT_OPTIONS_RELOADUIMSG             = "This option requires a UI Reload, Reload now?"

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE						= "PvE"
    HEALBOT_OPTIONS_ANCHOR                  = "Frame anchor"
    HEALBOT_OPTIONS_BARSANCHOR              = "Bars anchor"
    HEALBOT_OPTIONS_TOPLEFT                 = "Top Left"
    HEALBOT_OPTIONS_BOTTOMLEFT              = "Bottom Left"
    HEALBOT_OPTIONS_TOPRIGHT                = "Top Right"
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Bottom Right"
    HEALBOT_OPTIONS_TOP                     = "Top"
    HEALBOT_OPTIONS_BOTTOM                  = "Bottom"

    HEALBOT_PANEL_BLACKLIST                 = "BlackList"

    HEALBOT_WORDS_REMOVEFROM                = "Remove from";
    HEALBOT_WORDS_ADDTO                     = "Add to";
    HEALBOT_WORDS_INCLUDE                   = "Include";

    HEALBOT_OPTIONS_TTALPHA                 = "Opacity"
    HEALBOT_TOOLTIP_TARGETBAR               = "Target Bar"
    HEALBOT_OPTIONS_MYTARGET                = "My Targets"

    HEALBOT_DISCONNECTED_TEXT               = "<DC>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Show my buffs";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "Constantly update";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Show buff before it expires";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Short buffs"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Long buffs"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Message"
    HEALBOT_WORDS_YOU                       = "you";
    HEALBOT_NOTIFYOTHERMSG                  = "Casting #s on #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Icon position"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Show icon text"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Count"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Duration"
    HEALBOT_OPTIONS_ICONSCALE               = "Icon Scale"
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Icon Text Scale"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Aggro bar size"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Double text lines"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Text Alignment"
    HEALBOT_VEHICLE                         = "Vehicle"
    HEALBOT_WORDS_ERROR                     = "Error"
    HEALBOT_SPELL_NOT_FOUND	                = "Spell Not Found"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Hide Tooltip in Combat"
    HEALBOT_OPTIONS_ENABLELIBQH             = "Enable HealBot fastHealth"

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
                   [3] = "[HealBot] /hb t -- Toggle Healbot between disabled and enabled",
                   [4] = "[HealBot] /hb bt -- Toggle Buff Monitor between disabled and enabled",
                   [5] = "[HealBot] /hb dt -- Toggle Debuff Monitor between disabled and enabled",
                   [6] = "[HealBot] /hb skin <skinName> -- Switch Skins",
                   [7] = "[HealBot] /hb d -- Reset options to default",
                   [8] = "[HealBot] /hb spt -- Self Pet toggle",
                   [9] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
                   [10] = "[HealBot] /hb hs -- Display additional slash commands",
                  }

    HEALBOT_HELP2={ [1] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
                    [2] = "[HealBot] /hb aggro 2 <n> -- Set aggro level 2 on threat percentage <n>",
                    [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                    [4] = "[HealBot] /hb tr <Role> -- Set highest role priority for SubSort by Role. Valid Roles are 'TANK', 'HEALER' or 'DPS'",
                    [5] = "[HealBot] /hb use10 -- Automatically use Engineering slot 10",
                    [6] = "[HealBot] /hb pcs <n> -- Adjust the size of the Holy power charge indicator by <n>, Default value is 7 ",
                    [7] = "[HealBot] /hb hrfm -- Toggle method for hiding Blizzard raid frames, disable completly or just hide",
                    [8] = "[HealBot] /hb ws -- Toggle Hide/Show the Weaken Soul icon instead of the PW:S with a -",
                    [9] = "[HealBot] /hb rld <n> -- In seconds, how long the players name stays green after a res",
                    [10] = "[HealBot] /hb shhp <n> -- Show HYMN OF HOPE Buff only when mana is below <n>",
                    [11] = "[HealBot] - Also see Commands on the General tab in Options",
                  }
                  
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Highlight mouseover"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Highlight target"
    HEALBOT_OPTIONS_TESTBARS                = "Test Bars"
    HEALBOT_OPTION_NUMBARS                  = "Number of Bars"
    HEALBOT_OPTION_NUMTANKS                 = "Number of Tanks"
    HEALBOT_OPTION_NUMMYTARGETS             = "Number of MyTargets"
    HEALBOT_OPTION_NUMHEALERS               = "Number of Healers"
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
    HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncol"..HEALBOT_enWORD_COLOUR_SUFFIX
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
    HEALBOT_CMD_DELCUSTOMDEBUFF9            = "Delete custom debuffs on priority 9"
	HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Delete custom debuffs on priority 10"
	HEALBOT_CMD_DELCUSTOMDEBUFF11           = "Delete custom debuffs on priority 11"
	HEALBOT_CMD_DELCUSTOMDEBUFF12           = "Delete custom debuffs on priority 12"
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
    HEALBOT_CUSTOM_CAT_02                   = "A-B" 
    HEALBOT_CUSTOM_CAT_03                   = "C-D"
    HEALBOT_CUSTOM_CAT_04                   = "E-F"
    HEALBOT_CUSTOM_CAT_05                   = "G-H"
    HEALBOT_CUSTOM_CAT_06                   = "I-J"
    HEALBOT_CUSTOM_CAT_07                   = "K-L"
    HEALBOT_CUSTOM_CAT_08                   = "M-N"
    HEALBOT_CUSTOM_CAT_09                   = "O-P"
    HEALBOT_CUSTOM_CAT_10                   = "Q-R"
    HEALBOT_CUSTOM_CAT_11                   = "S-T"
    HEALBOT_CUSTOM_CAT_12                   = "U-V"
    HEALBOT_CUSTOM_CAT_13                   = "W-X"
    HEALBOT_CUSTOM_CAT_14                   = "Y-Z"

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Everyone"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Enemy"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Friend"
    
    HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT     = "Important Debuffs"
	HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE        = "Damaging Debuffs"
    HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT        = "Effect Debuffs"
    HEALBOT_CUSTOM_CAT_CUSTOM_MISC          = "Other Debuffs"
    HEALBOT_CUSTOM_DEBUFF_CATS = {
             -- Defaults
            [HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT]  = 1,
			[HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE]     = 1,
            [HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT]     = 1,
            [HEALBOT_CUSTOM_CAT_CUSTOM_MISC]       = 1,

			--Class Profession Debuffs
			[HEALBOT_DARK_BARGAIN]             = 3, --Warlock
			[HEALBOT_SHROUD_OF_PURGATORY]      = 11, --Death Knight
			[HEALBOT_DEBUFF_ROCKET_FUEL_LEAK]  = 10, --Engineering
			
			--Scenario, Proving Grounds
			[HEALBOT_DEBUFF_CHOMP]             = 3, -- Healer Challenge 
			[HEALBOT_DEBUFF_LAVA_BURNS]        = 7, -- Healer Challenge	
			
		    --[[World Bosses
	        Sha of Anger]]
		    [HEALBOT_DEBUFF_SEETHE]             = 11, -- Sha of Anger      
	        [HEALBOT_DEBUFF_AGGRESSIVE_BEHAVIOR] = 2, -- Sha of Anger      
	        --HEALBOT_DEBUFF_BITTER_THOUGHTS]      = 2, -- Sha of Anger 
			--Oondasta
			[HEALBOT_DEBUFF_CRUSH]             = 3, -- Oondasta    
			--Nalak, the Storm Lord
			[HEALBOT_DEBUFF_LIGHTNING_TETHER]  = 7, -- Nalak, the Storm Lord      
			[HEALBOT_DEBUFF_STORMCLOUD]        = 11, -- Nalak, the Storm Lord 
			--Celestials
			[HEALBOT_DEBUFF_SPECTRAL_SWIPE]    = 11, --Xuen   
			--[HEALBOT_DEBUFF_JADEFLAME_BUFFET]  = 6, --Chi Ji       
			--Ordos
			[HEALBOT_DEBUFF_BURNING_SOUL]      = 2, --Ordos            
			[HEALBOT_DEBUFF_POOL_OF_FIRE]      = 9, --Ordos       
			[HEALBOT_DEBUFF_ANCIENT_FLAME]     = 2, --Ordos        
									
			--Scenario, Proving Grounds
			[HEALBOT_DEBUFF_CHOMP]             = 3, -- Healer Challenge 
			[HEALBOT_DEBUFF_LAVA_BURNS]        = 7, -- Healer Challenge	
			
		    --[[World Bosses
	        Sha of Anger]]
		    [HEALBOT_DEBUFF_SEETHE]             = 11, -- Sha of Anger      
	        [HEALBOT_DEBUFF_AGGRESSIVE_BEHAVIOR] = 2, -- Sha of Anger      
	        --HEALBOT_DEBUFF_BITTER_THOUGHTS]      = 2, -- Sha of Anger 
			--Oondasta
			[HEALBOT_DEBUFF_CRUSH]             = 3, -- Oondasta    
			--Nalak, the Storm Lord
			[HEALBOT_DEBUFF_LIGHTNING_TETHER]  = 7, -- Nalak, the Storm Lord      
			[HEALBOT_DEBUFF_STORMCLOUD]        = 11, -- Nalak, the Storm Lord 
			--Celestials
			[HEALBOT_DEBUFF_SPECTRAL_SWIPE]    = 11, --Xuen   
			--[HEALBOT_DEBUFF_JADEFLAME_BUFFET]  = 6, --Chi Ji       
			--Ordos
			[HEALBOT_DEBUFF_BURNING_SOUL]      = 2, --Ordos            
			[HEALBOT_DEBUFF_POOL_OF_FIRE]      = 9, --Ordos       
			[HEALBOT_DEBUFF_ANCIENT_FLAME]     = 2, --Ordos        
									
			--[[Updated 5.2 Mists of Pandaria Expansion by Ariá - Silvermoon EU
			= GetMapNameByID(896) or "--Mogu'shan Vaults"]]
			[HEALBOT_DEBUFF_SUNDERING_BITE]    = 11, -- Trash       
			[HEALBOT_DEBUFF_FULLY_PETRIFIED]   = 4, -- Trash
			[HEALBOT_DEBUFF_FOCUSED_ASSAULT]   = 4, -- Trash        
			[HEALBOT_DEBUFF_GROUND_SLAM]       = 5, -- Trash         
			[HEALBOT_DEBUFF_IMPALE]            = 6, -- Trash         
			[HEALBOT_DEBUFF_PYROBLAST]         = 9, -- Trash              
			[HEALBOT_DEBUFF_TROLL_RUSH]        = 11, -- Trash
			[HEALBOT_DEBUFF_SUNDER_ARMOR]      = 11, -- Trash			
			[HEALBOT_DEBUFF_AMETHYST_POOL]     = 2, -- The Stone Guard         
			[HEALBOT_DEBUFF_REND_FLESH]        = 10, -- The Stone Guard     
			[HEALBOT_DEBUFF_LIVING_AMETHYST]   = 7, -- The Stone Guard Heroic     
			[HEALBOT_DEBUFF_LIVING_COBALT]     = 7, -- The Stone Guard Heroic     
			[HEALBOT_DEBUFF_LIVING_JADE]       = 7, -- The Stone Guard Heroic     
			[HEALBOT_DEBUFF_LIVING_JASPER]     = 7, -- The Stone Guard Heroic
			--[HEALBOT_DEBUFF_JASPER_CHAINS]     = 6, -- The Stone Guard 			
			[HEALBOT_DEBUFF_LIGHTNING_LASH]    = 7, -- Feng the Accursed  
			[HEALBOT_DEBUFF_LIGHTNING_CHARGE]  = 7, -- Feng the Accursed   
			[HEALBOT_DEBUFF_FLAMING_SPEAR]     = 4, -- Feng the Accursed    
			[HEALBOT_DEBUFF_WILDFIRE_SPARK]    = 13, -- Feng the Accursed   
			[HEALBOT_DEBUFF_ARCANE_SHOCK]      = 2, -- Feng the Accursed   
			[HEALBOT_DEBUFF_ARCANE_RESONANCE]  = 2, -- Feng the Accursed    
			[HEALBOT_DEBUFF_SHADOWBURN]        = 11, -- Feng the Accursed Heroic      
			--[HEALBOT_DEBUFF_EPICENTRE          = 4, -- Feng the Accursed         
			[HEALBOT_DEBUFF_VOODOO_DOLL]       = 12, -- Gara'jal the Spiritbinder 
			--[[[HEALBOT_DEBUFF_CROSSED_OVER]      = 3, -- Gara'jal the Spiritbinder 
			[HEALBOT_DEBUFF_SOUL_SEVER]        = 11, -- Gara'jal the Spiritbinder]]
			[HEALBOT_DEBUFF_PINNED_DOWN]       = 9, -- The Spirit Kings
			[HEALBOT_DEBUFF_UNDYING_SHADOWS]   = 12, -- The Spirit Kings 
			--[[[HEALBOT_DEBUFF_PILLAGED]          = 9, -- The Spirit Kings
			[HEALBOT_DEBUFF_ROBBED_BLIND]      = 10, -- The Spirit Kings Heroic]]
			--[HEALBOT_DEBUFF_OVERCHARGED]       = 9, -- Elegon  
			[HEALBOT_DEBUFF_FOCUSED_ASSAULT]   = 4, -- Will of the Emporer
			[HEALBOT_DEBUFF_ENERGIZING_SMASH]  = 4, -- Will of the Emporer 
			[HEALBOT_DEBUFF_IMPEDING_THRUST]   = 6, -- Will of the Emporer   
			[HEALBOT_DEBUFF_FOCUSED_DEFENSE]   = 4, -- Will of the Emporer 
			[HEALBOT_DEBUFF_DEVASTATING_ARC]   = 3, -- Will of the Emporer 
			[HEALBOT_DEBUFF_STOMP]             = 11, -- Will of the Emporer      
			--[[[HEALBOT_DEBUFF_FOCUSED_ENERGY]    = 4, -- Will of the Emporer Heroic
			[HEALBOT_DEBUFF_TITAN_GAS]         = 11, -- Will of the Emporer]]
			
			--= GetMapNameByID(897) or "--Heart of Fear"
			[HEALBOT_DEBUFF_ARTERIAL_BLEEDING] = 2, -- Trash         
			[HEALBOT_DEBUFF_DISMANTLED_ARMOR] = 3, -- Trash          
			[HEALBOT_DEBUFF_STUNNING_STRIKE]  = 11, -- Trash         
			[HEALBOT_DEBUFF_GALE_FORCE_WINDS] = 5, -- Trash 
			[HEALBOT_DEBUFF_MORTAL_REND]      = 8, -- Trash        
			[HEALBOT_DEBUFF_GRIEVOUS_WHIRL]   = 5, -- Trash        
			[HEALBOT_DEBUFF_BURNING_STING]    = 2, -- Trash         
			[HEALBOT_DEBUFF_SLAM]             = 11, -- Trash 
			[HEALBOT_DEBUFF_ZEALOUS_PARASITE] = 14, -- Trash
			[HEALBOT_DEBUFF_EXHALE]           = 4, -- Imperial Vizier Zor'lok       
			[HEALBOT_DEBUFF_CONVERT]          = 3, -- Imperial Vizier Zor'lok          
			--[HEALBOT_DEBUFF_PHEROMONES_OF_ZEAL] = 9, -- Imperial Vizier Zor'lok  
			[HEALBOT_DEBUFF_OVERWHELMING_ASSAULT] = 9, -- Blade Lord Ta'yak      
			[HEALBOT_DEBUFF_WIND_STEP]        = 13, -- Blade Lord Ta'yak			 
			[HEALBOT_DEBUFF_UNSEEN_STRIKE]    = 12, -- Blade Lord Ta'yak  
			[HEALBOT_DEBUFF_PHEROMONES]      = 9, -- Garalon		    
			--[HEALBOT_DEBUFF_PUNGENCY]      	 = 9, -- Garalon
			[HEALBOT_DEBUFF_AMBER_PRISON]     = 2, -- Wind Lord Mel'jarak 		 
			[HEALBOT_DEBUFF_CORROSIVE_RESIN]  = 3, -- Wind Lord Mel'jarak  		
			[HEALBOT_DEBUFF_KORTHIK_STRIKE]   = 7, -- Wind Lord Mel'jarak 
			[HEALBOT_DEBUFF_RESHAPE_LIFE]     = 10, -- Amber-Shaper Un'sok		
			[HEALBOT_DEBUFF_PARASITIC_GROWTH] = 9, -- Amber-Shaper Un'sok    	 
			[HEALBOT_DEBUFF_FLING]     	      = 4, -- Amber-Shaper Un'sok      
			[HEALBOT_DEBUFF_AMBER_GLOBULE]    = 2, -- Amber-Shaper Un'sok Heroic 
			[HEALBOT_DEBUFF_EYES_OF_THE_EMPRESS] = 4, -- Grand Empress Shek'zeer 
			[HEALBOT_DEBUFF_CRY_OF_TERROR]    = 3, -- Grand Empress Shek'zeer 	    
			[HEALBOT_DEBUFF_STICKY_RESIN]     = 11, -- Grand Empress Shek'zeer	         
			[HEALBOT_DEBUFF_POISON_BOMB]      = 9, -- Grand Empress Shek'zeer	         
			[HEALBOT_DEBUFF_POISON_DRENCHED_ARMOR] = 9, -- Grand Empress Shek'zeer    
			[HEALBOT_DEBUFF_VISIONS_OF_DEMISE] = 12, -- Grand Empress Shek'zeer  
			[HEALBOT_DEBUFF_HEART_OF_FEAR]    = 5, -- Grand Empress Shek'zeer Heroic				
			
			--= GetMapNameByID(886) or "--Terrace of Endless Spring"
			[HEALBOT_DEBUFF_TOUCH_OF_SHA]      = 11, -- Protectors of the Endless      
			[HEALBOT_DEBUFF_DEFILED_GROUND]    = 3, -- Protectors of the Endless       
			--[HEALBOT_DEBUFF_OVERWHELMING_CORRUPTION] = 9, -- Protectors of the Endless 
			[HEALBOT_DEBUFF_SHADOW_BREATH]     = 11, -- Tsulong     
			--[HEALBOT_DEBUFF_DREAD_SHADOWS]     = 3, -- Tsulong       
			[HEALBOT_DEBUFF_SPRAY]             = 11, -- Lei Shi       
			[HEALBOT_DEBUFF_SCARY_FOG]         = 11, -- Lei Shi Heroic     
			[HEALBOT_DEBUFF_PENETRATING_BOLT]  =9, -- Sha of Fear              
			[HEALBOT_DEBUFF_NAKED_AND_AFRAID]  = 8, -- Sha of Fear Heroic 
			[HEALBOT_DEBUFF_HUDDLE_IN_TERROR]  = 5, -- Sha of Fear Heroic 
			[HEALBOT_DEBUFF_CHAMPION_OF_THE_LIGHT] = 3, -- Sha of Fear Heroic 
			[HEALBOT_DEBUFF_OMINOUS_CACKLE]    = 9, -- Sha of Fear 
			--[HEALBOT_DEBUFF_DREAD_SPRAY]       = 3, -- Sha of Fear 
			
			--[[Updated 5.3 Mists of Pandaria Expansion by Ariá - Silvermoon EU      
			= GetMapNameByID(930) or "--Throne of Thunder"]]
			[HEALBOT_DEBUFF_WOUNDING_STRIKE]   = 13, -- Trash
			[HEALBOT_DEBUFF_STORM_ENERGY]      = 11, -- Trash
			[HEALBOT_DEBUFF_ANCIENT_VENOM]     = 2, -- Trash 
			[HEALBOT_DEBUFF_TORMENT]           = 11, -- Trash
			[HEALBOT_DEBUFF_CRUSH_ARMOR]       = 3, -- Trash
			[HEALBOT_DEBUFF_STORMCLOUD]        = 11, -- Trash
			[HEALBOT_DEBUFF_SLASHING_TALONS]   = 11, -- Trash
			[HEALBOT_DEBUFF_SHALE_SHARDS]      = 11, -- Trash
			[HEALBOT_DEBUFF_CHOKING_MISTS]     = 3, -- Trash
			[HEALBOT_DEBUFF_CORROSIVE_BREATH]  = 3, -- Trash
			[HEALBOT_DEBUFF_COCOON]            = 3, -- Trash   
			[HEALBOT_DEBUFF_CHOKING_GAS]       = 3, -- Trash
			[HEALBOT_DEBUFF_GNAWED_UPON]       = 5, -- Trash
			[HEALBOT_DEBUFF_RETRIEVE_SPEAR]    = 10, -- Trash
			[HEALBOT_DEBUFF_STATIC_WOUND]      = 11, -- Jin'rokh the Breaker
			[HEALBOT_DEBUFF_THUNDERING_THROW]  = 11, -- Jin'rokh the Breaker
			[HEALBOT_DEBUFF_FOCUSED_LIGHTNING] = 4, -- Jin'rokh the Breaker
			[HEALBOT_DEBUFF_ELECTRIFIED_WATERS] = 4, -- Jin'rokh the Breaker 
			[HEALBOT_DEBUFF_TRIPLE_PUNCTURE]   = 11, -- Horridon
			[HEALBOT_DEBUFF_RENDING_CHARGE]    = 10, -- Horridon
			[HEALBOT_DEBUFF_FROZEN_BOLT]       = 4, -- Horridon
			[HEALBOT_DEBUFF_FRIGID_ASSAULT]    = 4, -- Council of Elders 
			[HEALBOT_DEBUFF_BITING_COLD]       = 2, -- Council of Elders    
			[HEALBOT_DEBUFF_FROSTBITE]         = 4, -- Council of Elders  
			[HEALBOT_DEBUFF_BODY_HEAT]         = 2, -- Council of Elders Heroic
			[HEALBOT_DEBUFF_MARKED_SOUL]       = 8, -- Council of Elders
			[HEALBOT_DEBUFF_SOUL_FRAGMENT]     = 11, -- Council of Elders Heroic
			--[HEALBOT_DEBUFF_SHADOWED_SOUL]     = 11, -- Council of Elders Heroic
			[HEALBOT_DEBUFF_ENTRAPPED]         = 4, -- Council of Elders Magic
			[HEALBOT_DEBUFF_QUAKE_STOMP]       = 10, -- Tortos
			[HEALBOT_DEBUFF_CRYSTAL_SHELL]     = 3, -- Tortos
			[HEALBOT_DEBUFF_CRYSTAL_SHELL_FULL_CAPACITY] = 3, -- Tortos 
			[HEALBOT_DEBUFF_IGNITE_FLESH]      = 6, -- Megaera  
			[HEALBOT_DEBUFF_ARCTIC_FREEZE]     = 2, -- Megaera  
			[HEALBOT_DEBUFF_ROT_ARMOR]         = 10, -- Megaera 
			[HEALBOT_DEBUFF_TORRENT_OF_ICE]    = 11, -- Megaera
			--[HEALBOT_DEBUFF_ICY_GROUND]        = 6, -- Megaera  		
			[HEALBOT_DEBUFF_TALON_RAKE]        = 11, -- Ji-Kun
			[HEALBOT_DEBUFF_INFECTED_TALONS]   = 6, -- ji-Kun
			[HEALBOT_DEBUFF_FEED_POOL]         = 4, -- ji-Kun
			[HEALBOT_DEBUFF_SLIMED]            = 11, -- ji-Kun      
			[HEALBOT_DEBUFF_SERIOUS_WOUND]     = 11, -- Durumu the Forgotten
			[HEALBOT_DEBUFF_ARTERIAL_CUT]      = 2, -- Durumu the Forgotten
			[HEALBOT_DEBUFF_LINGERING_GAZE]    = 7, -- Durumu the Forgotten
			[HEALBOT_DEBUFF_LIFE_DRAIN]        = 7, -- Durumu the Forgotten
			--[[[HEALBOT_DEBUFF_BLUE_RAY_TRACKING] = 2, -- Durumu the Forgotten       
			[HEALBOT_DEBUFF_BLUE_RAYS]         = 2, -- Durumu the Forgotten       
			[HEALBOT_DEBUFF_INFRARED_TRACKING] = 6, -- Durumu the Forgotten       
			[HEALBOT_DEBUFF_INFRARED_LIGHT]    = 6, -- Durumu the Forgotten       
			[HEALBOT_DEBUFF_BRIGHT_LIGHT]      = 2,]] -- Durumu the Forgotten 
			[HEALBOT_DEBUFF_MALFORMED_BLOOD]   = 8, -- Primordius
			[HEALBOT_DEBUFF_VOLATILE_PATHOGEN] = 12, -- Primordius
			[HEALBOT_DEBUFF_CRIMSON_WAKE]      = 3, -- Dark Animus
			[HEALBOT_DEBUFF_EXPLOSIVE_SLAM]    = 4, -- Dark Animus
			[HEALBOT_DEBUFF_ANIMA_RING]        = 2, -- Dark Animus
			[HEALBOT_DEBUFF_TOUCH_OF_ANIMUS]   = 11, -- Dark Animus
			--[HEALBOT_DEBUFF_ANIMA_FONT]        = 2, -- Dark Animus
			[HEALBOT_DEBUFF_SCORCHED]          = 11, -- Iron Qon
			[HEALBOT_DEBUFF_FREEZE]            = 4, -- Iron Qon
			[HEALBOT_DEBUFF_STORM_CLOUD]       = 11, -- Iron Qon
			--[HEALBOT_DEBUFF_ARCING_LIGHTNING]  = 2, -- Iron Qon   
			[HEALBOT_DEBUFF_FAN_OF_FLAMES]     = 4, -- Twin Consorts 
			[HEALBOT_DEBUFF_BEAST_OF_NIGHTMARES] = 2, -- Twin Consorts
			[HEALBOT_DEBUFF_CORRUPTED_HEALING] = 3, -- Twin Consorts 
			--[HEALBOT_DEBUFF_FLAMES_OF_PASSION] = 4, -- Twin Consorts
			[HEALBOT_DEBUFF_DECAPITATE]        = 3, -- Lei Shen 
			[HEALBOT_DEBUFF_STATIC_SHOCK]      = 11, -- Lei Shen
			[HEALBOT_DEBUFF_OVERCHARGED]       = 9, -- Lei Shen
			[HEALBOT_DEBUFF_HELM_OF_COMMAND]   = 5, -- Lei Shen Heroic
			[HEALBOT_DEBUFF_ELECTRICAL_SHOCK]  = 4, -- Lei Shen 
			--[[[HEALBOT_DEBUFF_CRASHING_THUNDER]  = 3, -- Lei Shen
			[HEALBOT_DEBUFF_DISCHARGED_ENERGY] = 3, -- Lei Shen        
			[HEALBOT_DEBUFF_WINDBURN]          = 13, -- Lei Shen]]
			[HEALBOT_DEBUFF_UNSTABLE_VITA]     = 12, -- Ra-Den
			[HEALBOT_DEBUFF_VITA_SENSITIVITY]  = 12, -- Ra-Den
			
			--[[Updated 5.4 Mists of Pandaria Expansion by Ariá - Silvermoon EU 	   			
			= GetMapNameByID(953) or "--Siege of Orgrimmar"]]                       
			[HEALBOT_DEBUFF_LOCKED_ON]         = 7, -- Trash        
			[HEALBOT_DEBUFF_OBLITERATING_STRIKE] = 9,-- Trash
			[HEALBOT_DEBUFF_PIERCE]            = 9, --Trash 
			[HEALBOT_DEBUFF_BLOOD_OF_YSHAARJ]  = 2, -- Trash
			[HEALBOT_DEBUFF_REAPING_WHIRLWIND] = 10, -- Trash 
			[HEALBOT_DEBUFF_FIRE_PIT]          = 4, -- Trash
			[HEALBOT_DEBUFF_OVERCONFIDENCE]    = 9, -- Trash            
			[HEALBOT_DEBUFF_JEALOUSY]          = 6, -- Trash  			
			[HEALBOT_DEBUFF_GROWING_OVERCONFIDENCE] = 5, -- Trash
			[HEALBOT_DEBUFF_BRIBE]             = 2, -- Trash 
			[HEALBOT_DEBUFF_INTIMIDATING_SHOUT] = 6, -- Trash
			[HEALBOT_DEBUFF_FULL_OF_MEAT]      = 4, -- Trash
			[HEALBOT_DEBUFF_SCORCHED_EARTH]    = 11, -- Trash
			[HEALBOT_DEBUFF_DREAD_HOWL]        = 3, -- Trash  
			[HEALBOT_DEBUFF_SLOW_AND_STEADY]   = 11, -- Trash 
			[HEALBOT_DEBUFF_RESONATING_AMBER]  = 10, -- Trash 
			[HEALBOT_DEBUFF_CORROSIVE_BLAST]   = 3, -- Immerseus 
			[HEALBOT_DEBUFF_SHA_POOL]          = 11, -- Immerseus
			--[HEALBOT_DEBUFF_SHA_SPLASH]        = 11, -- Immerseus  
			[HEALBOT_DEBUFF_NOXIOUS_POISON]    = 8, -- The Fallen Protectors       
			[HEALBOT_DEBUFF_DEFILED_GROUND]    = 3, -- The Fallen Protectors                  
			[HEALBOT_DEBUFF_VENGEFUL_STRIKES]  = 12, -- The Fallen Protectors     
			[HEALBOT_DEBUFF_CORRUPTION_KICK]   = 3, -- The Fallen Protectors    
			[HEALBOT_DEBUFF_GARROTE]           = 5, -- The Fallen Protectors     
			[HEALBOT_DEBUFF_GOUGE]             = 5, -- The Fallen Protectors    
			[HEALBOT_DEBUFF_MARK_OF_ANGUISH]   = 8, -- The Fallen Protectors         
			[HEALBOT_DEBUFF_SHA_SEAR]          = 11, -- The Fallen Protectors
			[HEALBOT_DEBUFF_FIXATE]            = 4, -- The Fallen Protectors
			--[[[HEALBOT_DEBUFF_DEBILITATION]      = 3, -- The Fallen Protectors
			HEALBOT_DEBUFF_SHADOWED_WEAKNESS]  = 11, -- The Fallen Protectors
			[HEALBOT_DEBUFF_CORRUPTED_BREW]    = 3, -- The Fallen Protectors]] 			     
			[HEALBOT_DEBUFF_SELF_DOUBT]        = 11, -- Norushen
			[HEALBOT_DEBUFF_BOTTOMLESS_PIT]    = 2, -- Norushen
			[HEALBOT_DEBUFF_DISHEARTENING_LAUGH] = 3, -- Norushen  
			--[[[HEALBOT_DEBUFF_DESPAIR]             = 3, -- Norushen 
			[HEALBOT_DEBUFF_TEST_OF_SERENITY]  = 11, -- Norushen       
			[HEALBOT_DEBUFF_TEST_OF_RELIANCE]  = 11, -- Norushen       
			[HEALBOT_DEBUFF_TEST_OF_CONDIDENCE] = 11,]] -- Norushen  
			[HEALBOT_DEBUFF_WOUNDED_PRIDE]     = 13, -- Sha of Pride
			[HEALBOT_DEBUFF_CORRUPTED_PRISON]  = 3, -- Sha of Pride  
			[HEALBOT_DEBUFF_BANISHMENT]        = 2, -- Sha of Pride Heroic            
			[HEALBOT_DEBUFF_REACHING_ATTACK]   = 10, -- Sha of Pride 
			[HEALBOT_DEBUFF_AURA_OF_PRIDE]     = 2, -- Sha of Pride 
			[HEALBOT_DEBUFF_MARK_OF_ARROGANCE] = 8, -- Sha of Pride Magic   
			[HEALBOT_DEBUFF_FRACTURE]          = 4, -- Galakras
			[HEALBOT_DEBUFF_POISON_CLOUD]      = 9, -- Galakras
			--[[[HEALBOT_DEBUFF_FLAME_ARROWS]      = 4, -- Galakras
			[HEALBOT_DEBUFF_FLAMES_OF_GALAKROND] = 4, -- Galakras]]
			[HEALBOT_DEBUFF_LASER_BURN]        = 7, -- Iron Juggernaut
			[HEALBOT_DEBUFF_IGNITE_ARMOUR]     = 6, -- Iron Juggernaut
			[HEALBOT_DEBUFF_EXPLOSIVE_TAR]     = 4, -- Iron Juggernaut
			[HEALBOT_DEBUFF_CUTTER_LASER_TARGET] = 3, -- Iron Juggernaut
			[HEALBOT_DEBUFF_REND]              = 10, -- Kor'kron Dark Shaman
			[HEALBOT_DEBUFF_FROSTSTORM_STRIKE] = 4, -- Kor'kron Dark Shaman
			[HEALBOT_DEBUFF_TOXIC_MIST]        = 11, -- Kor'kron Dark Shaman
			[HEALBOT_DEBUFF_IRON_PRISON]       = 6, -- Kor'kron Dark Shaman Heroic
			--[HEALBOT_DEBUFF_FOUL_GEYSER]       = 4, -- Kor'kron Dark Shaman
			--[HEALBOT_DEBUFF_TOXICITY]          = 11, -- Kor'kron Dark Shaman
			[HEALBOT_DEBUFF_SUNDERING_BLOW]    = 11, -- General Nazgrim
			[HEALBOT_DEBUFF_BONECRACKER]       = 2, -- General Nazgrim
			[HEALBOT_DEBUFF_ASSASSINS_MARK]    = 2, -- General Nazgrim
			[HEALBOT_DEBUFF_HUNTERS_MARK]      = 5, -- General Nazgrim Heroic
			[HEALBOT_DEBUFF_FATAL_STRIKE]      = 4, -- Malkorok                         
			[HEALBOT_WEEK_ANCIENT_BARRIER]     = 13, -- Malkorok       
			[HEALBOT_ANCIENT_BARRIER]          = 2, -- Malkorok 
			[HEALBOT_STRONG_ANCIENT_BARRIER]   = 11, -- Malkorok   
			--[[HEALBOT_DEBUFF_ANCIENT_MIASMA]    = 2, -- Malkorok               
			[HEALBOT_DEBUFF_LANGUISH]          = 7, -- Malkorok Heroic]] 
			[HEALBOT_DEBUFF_SET_TO_BLOW]       = 11, -- Spoils of Pandaria
			[HEALBOT_DEBUFF_CARNIVOROUS_BITE]  = 3, -- Spoils of Pandaria
			[HEALBOT_DEBUFF_ENCAPSULATED_PHEROMONES] = 4, -- Spoils of Pandaria
			[HEALBOT_DEBUFF_KEG_TOSS]          = 7, -- Spoils of Pandaria
			[HEALBOT_DEBUFF_GUSTING_BOMB]      = 5, -- Spoils of Pandaria 
			--[HEALBOT_DEBUFF_UNSTABLE_DEFENSE_SYSTEMS] = 12, -- Spoils of Pandaria 
			[HEALBOT_DEBUFF_PANIC]             = 9, -- Thok the Bloodthirsty      
			[HEALBOT_DEBUFF_TAIL_LASH]         = 11, -- Thok the Bloodthirsty     
			[HEALBOT_DEBUFF_FIXATE]            = 4, -- Thok the Bloodthirsty     
			[HEALBOT_DEBUFF_ACID_BREATH]       = 2, -- Thok the Bloodthirsty     
			[HEALBOT_DEBUFF_FREEZING_BREATH]   = 4, -- Thok the Bloodthirsty         
			[HEALBOT_DEBUFF_SCORCHING_BREATH]  = 11, -- Thok the Bloodthirsty    
			--[[[HEALBOT_DEBUFF_BURNING_BLOOD]     = 2, -- Thok the Bloodthirsty 
			[HEALBOT_DEBUFF_ICY_BLOOD]         = 6, -- Thok the Bloodthirsty
			[HEALBOT_DEBUFF_BLOODIED]          = 2, -- Thok the Bloodthirsty]]     
			[HEALBOT_DEBUFF_ELECTROSTATIC_CHARGE] = 4, --Siegecrafter Blackfuse
			[HEALBOT_DEBUFF_OVERLOAD]          = 9, -- Siegecrafter Blackfuse           
			[HEALBOT_DEBUFF_SUPERHEATED]       = 11, -- Siegecrafter Blackfuse          
			--HEALBOT_DEBUFF_MAGNETIC_CRUSH]    = 8, -- Siegecrafter Blackfuse 
			[HEALBOT_DEBUFF_MUTATE]            = 8, -- Paragons of the Klaxxi
			[HEALBOT_DEBUFF_EXPOSED_VEINS]     = 4, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_GOUGE]             = 5, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_CAUSTIC_BLOOD]     = 3, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_TENDERZING_STRIKES] = 11, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_MEZMERIZE]         = 8, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_SHIELD_BASH]       = 11, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_CAUSTIC_AMBER]     = 3, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_HEWN]              = 5, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_GENETIC_ALTERATION] = 5, -- Paragons of the Klaxxi
			[HEALBOT_DEBUFF_INJECTION]         = 6, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_AIM]               = 2, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_WHIRLING]          = 13, -- Paragons of the Klaxxi
			[HEALBOT_DEBUFF_FIERY_EDGE]        = 4, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_FEED]              = 4, -- Paragons of the Klaxxi 
			[HEALBOT_DEBUFF_NOXIOUS_VAPORS]    = 8, -- Paragons of the Klaxxi
			[HEALBOT_DEBUFF_CANNED_HEAT]       = 3, -- Paragons of the Klaxxi Heroic      
			[HEALBOT_DEBUFF_EERIE_FOG]         = 4, -- Paragons of the Klaxxi Heroic
			--[[[HEALBOT_DEBUFF_CHILLED_TO_THE_BONE] = 3, -- Paragons of the Klaxxi Heroic 
			[HEALBOT_DEBUFF_HUNGER]            = 5, -- Paragons of the Klaxxi]]
			[HEALBOT_DEBUFF_HAMSTRING]         = 5, -- Garrosh Hellscream   
			[HEALBOT_DEBUFF_EMBODIED_DOUBT]    = 4, -- Garrosh Hellscream
			[HEALBOT_DEBUFF_TOUCH_OF_YSHAARJ]  = 11, -- Garrosh Hellscream 
			[HEALBOT_DEBUFF_EMPOWERED_TOUCH_OF_YSHAARJ] = 4, -- Garrosh Hellscream
			[HEALBOT_DEBUFF_GRIPPING_DESPAIR]  = 5, -- Garrosh Hellscream
			[HEALBOT_DEBUFF_EMPOWERED_GRIPPING_DESPAIR] = 4, -- Garrosh Hellscream
            [HEALBOT_DEBUFF_MALICE]            = 8, -- Garrosh Hellscream Heroic
			[HEALBOT_DEBUFF_MALICIOUS_BLAST]   = 8, -- Garrosh Hellscream Heroic 
			[HEALBOT_DEBUFF_FIXATE]            = 4, -- Garrosh Hellscream Heroic 
			[HEALBOT_DEBUFF_NAPALM]            = 8, -- Garrosh Hellscream Heroic
			[HEALBOT_DEBUFF_EXPLOSIVE_DESPAIR] = 4, -- Garrosh Hellscream
			[HEALBOT_DEBUFF_FAITH]             = 4, -- Garrosh Hellscream Buff
			[HEALBOT_DEBUFF_HOPE]              = 5, -- Garrosh Hellscream Buff 
			[HEALBOT_DEBUFF_COURAGE]           = 3, -- Garrosh Hellscream Buff 
			--[HEALBOT_DEBUFF_DESECRATED]        = 3, -- Garrosh Hellscream]] 
			}

    HEALBOT_ABOUT_DESC1                    = "Add frames with skinable bars for healing, decursive, buffing, ressing, aggro tracking"
    HEALBOT_ABOUT_WEBSITE                  = "Website:"
    HEALBOT_ABOUT_AUTHORH                  = "Author:"
    HEALBOT_ABOUT_AUTHORD                  = "Strife"
    HEALBOT_ABOUT_CATH                     = "Category:"
    HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
    HEALBOT_ABOUT_CREDITH                  = "Credits:"
    HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, Moonlight Han Xing, CTShammy, Hermis, Ariá"  -- Anyone taking on translations (if required), feel free to add yourself here.
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
                                      [10]  = "Options - How do I always use enabled settings",
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
                                              "1: On the spells tab: Turn on Always Use Enabled \n" ..
                                              "2: On the spells tab: Turn off SmartCast \n\n" ..
                                              "Note: It is expected that most users will want to \n"..
                                              "turn SmartCast back on \n\n" ..
                                              "Note: It is expected that experienced users will want to \n" ..
                                              "turn off Always Use Enabled  \n" ..
                                              "and set the spells for disabled bars"
                                              
    HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "You are monitoring for missing buffs \n\n" .. 
                                              "This can be turned off on the buffs tab \n" ..
                                              "Alternatively click on the bar and cast the buff",
                                      [2]   = "This is blizzard functionality, not Healbot \n\n" .. 
                                              "Using the standard blizzard frames, \n" ..
                                              "try casting a spell thats on Cooldown \n" ..
                                              "Notice how the cursor turns blue. \n\n" ..
                                              "On the spells tab, use Avoid Blue Cursor",
									  [3]   = "Yes \n\n"..
                                              "Paladin Hand of Salvation cooldown macro example: \n\n" ..
                                              "#show Hand of Salvation \n" ..
                                              '/script local n=UnitName("hbtarget"); ' .. "\n" ..
                                              'if GetSpellCooldown("Hand of Salvation")==0 then ' .. " \n" ..
                                              'SendChatMessage("Hand of Salvation on "..n,"YELL") ' .. "\n" ..
                                              'SendChatMessage("Hand of Salvation!","WHISPER",nil,n) ' .. "\n" ..
                                              "end; \n" ..
                                              "/cast [@hbtarget] Hand of Salvation",
                                      [4]   = "Yes \n\n"..
											  "Preist Flash Heal, example using both trinkets: \n\n" ..
                                              "#show Flash Heal \n" ..
                                              "/script UIErrorsFrame:Hide() \n" ..
                                              "/console Sound_EnableSFX 0 \n" ..
                                              "/use 13 \n" ..
                                              "/use 14 \n" ..
                                              "/console Sound_EnableSFX 1 \n" ..
                                              "/cast [@hbtarget] Flash Heal \n" ..
                                              "/script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                      [5]   = "1: On the Mouse Wheel tab: Turn off Use Mouse Wheel \n" ..
                                              "2: Bind your macros to blizzard's bindings with\n[@mouseover] \n\n\n" ..
                                              "Eample macro: \n\n" ..
                                              "#showtooltip Flash Heal \n" ..
                                              "/cast [@mouseover] Flash Heal \n",
                                      [6]   = "Yes \n\n\n"..
                                              "With Headers: \n" ..
                                              "1: On the Skins>Headers tab, switch on Show Headers \n" ..
                                              "2: On the Skins>Bars tab, set Number of Groups per\ncolumn \n\n" ..
                                              "Without Headers: \n" ..
                                              "1: On the Skins>Bars tab, switch on Use Groups per\nColumn \n" ..
                                              "2: On the Skins>Bars tab, set Number of Groups per\ncolumn ",
                                      [7]   = "Yes \n\n"..
                                              "1: On the Skins>Healing>Alert tab, set Alert Level to 0 \n" ..
                                              "2: On the Skins>Aggro tab, turn off the Aggro Monitor \n" .. 
                                              "3: On the Skins>Bars tab, set Disabled opacity to 0 \n" ..
                                              "4: On the Skins>Bars tab, set Background opacity to 0 \n" ..
                                              "5: On the Skins>Bar Text tab, click on the bar Disabled \n" ..
                                              "and set the Disabled text opacity to 0 \n" ..
                                              "6: On the Skins>General tab, click on the bar\n" ..
                                              "Background and set the Background opacity to 0 \n" ..
                                              "7: On the Cure tab, Turn on debuff monitoring",
                                      [8]   = "Yes \n\n"..
                                              "1: On the Skins>Bars tab, set Incoming Heals to Dont\nShow\n" ..
                                              "2: On the Skins>Bar Text tab, \n" ..
                                              "set Show Health on Bar to No Incoming Heals",
                                      [9]   = "This has been present since a change in WoW 3.2, \n" ..
                                              "it can affects characters with weird letters in their name \n\n" ..
                                              "If your on Vista or Win7, try the follow: \n"..
                                              "change system locale to English\n(for non-unicode programs) \n" ..
                                              "in Control Panel > Region and Language >\nAdministrative Tab",
                                      [10]   = "On the spells tab turn on Always Use Enabled \n\n" ..
                                              "Some my also want to set the Alert Level to 100 \n" ..
                                              "This can be done on the Skins>Healing>Alert tab",
                                      [11]  = "Disable for a character: \n\n" ..
                                              "1: Open the General tab \n" ..
                                              "2: Turn on the Disable option \n\n\n" ..
                                              "Disable when solo: \n\n" ..
                                              "1: Open the General tab \n" ..
                                              "2: To the right of the Disable option, Select only when\nsolo \n" ..
                                              "3: Turn on the Disable option",
                                      [12]  = "Change the Bars Anchor setting on the Skins>General\ntab  \n\n" ..
                                              "Top Right: the bars will grow Down and Left \n" ..
                                              "Top Left: the bars will grow Down and Right \n" ..
                                              "Bottom Right: the bars will grow Up and Left \n" ..
                                              "Bottom Left: the bars will grow Up and Right",
                                      [13]  = "My Targets allows you to create a list of Targets you \n" ..
                                              "want to group separately from others, similar to the\nMT group \n\n" ..
                                              "The following options are available for \n" .. 
                                              "adding/removing people to/from the My Targets group \n\n" ..
                                              "- Shift+Ctrl+Alt+Right click on the bar \n" ..
                                              '- Use the Healbot Menu, enter "hbmenu" on the spells\ntab ' .. "\n" ..
                                              "- Use the Mouse Wheel, set on the Mouse Wheel tab",
                                      [14]  = "Private Tanks can be added to the Main Tanks list, \n" ..
                                              "the Private tanks are only visible in your Healbot \n" ..
                                              "and do not affect other players or addons \n\n" ..
                                              "The following options are available for \n" ..
                                              "adding/removing people to/from the Tanks list \n\n" ..
                                              '- Use the Healbot Menu, enter "hbmenu" on the spells\ntab ' .. "\n" ..
                                              "- Use the Mouse Wheel, set on the Mouse Wheel tab",                                     
                                      [15]  = "Yes \n\n"..
                                              "1: On the Skins>Healing tab, turn on Focus \n" ..
                                              "2: set your focus on the NPC (or PC not in raid/party) \n" ..
                                              "Healbot will create a bar in your My Targets list \n\n" ..
                                              "Note: If in a combat situation where you zone in and out\nwhile \n" ..
                                              "in combat and need to reset focus on an NPC \n" ..
                                              "on the Skins>Healing tab set Focus: always show to on \n" ..
                                              "This will keep the bar available during combat. \n\n" ..
                                              "Note: The HealBot Menu has the option\n'Set HealBot Focus' \n" ..
                                              "This can make setting focus easy on NPC's and \n" ..
                                              "serves as a reminder to set focus. \n\n" ..
                                              "Enter 'hbmenu' on the spells tab to use HealBot Menu \n" ..
                                              "or use the Mouse Wheel tab to and set HealBot Menu",
                                      [16]  = "1: On the Skins>Bars tab, adjust the disabled bar\nopacity \n" ..
                                              "2: On the Skins>Bars Text tab, adjust the disabled text \n" ..
                                              "opacity to do this click on the bar labeled Disabled. \n\n" ..
                                              "Some my also want to set the Alert Level to 100 \n" ..
                                              "This can be done on the Skins>Healing>Alert tab",
                                      [17]  = "Actually Healbot is casting exacly as the setup. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                      [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  }
								  
	HEALBOT_ABOUT_FAQ_ANSWERS_BUTTON = { [1] = "Not used - Buttons!",
	                                   }

    HEALBOT_OPTIONS_SKINAUTHOR              = "Skin Author"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Avoid\nBlue Cursor"
    HEALBOT_PLAYER_OF_REALM                 = "of"
    
    HEALBOT_OPTIONS_LANG                    = "Language"
    
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN - by Ydzzs)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK - by Strife)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS - by Strife)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR - by Kubik)"
    HEALBOT_OPTIONS_LANG_DEDE               = "German (deDE - translator required)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU - by Von)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR - translator required)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT - by Brezza)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR - by Aldetal)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russian (ruRU - translator required)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES - translator required)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW - translator required)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Failed to load addon for localization"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Reason for failure is:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note in the current verison, this is the only warning for"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Failed to load headbot addon"
    
    HEALBOT_OPTIONS_IN_A_GROUP              = "Only when in a Group or Raid"
    
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "    " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "    " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_PROT      = "    " .. HEALBOT_OPTIONS_TAB_PROTECTION
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "    " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "    " .. HEALBOT_SKIN_DEBTEXT
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "    " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "    " .. HEALBOT_OPTIONS_TAB_WARNING
    
    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Absorb effects";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Absorb effects opacity";
    HEALBOT_OPTIONS_OUTLINE                 = "Outline"
    HEALBOT_OPTIONS_FRAME                   = "Frame"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. "Frames"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Frames options"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Set Tooltip Position"
    HEALBOT_OPTIONS_FRAME_TITLE             = "Frame Title"
    HEALBOT_OPTIONS_FRAME_TITLE_SHOW        = "Show Title"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Grow Direction"
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Horizontal"
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Vertical"
    HEALBOT_OPTIONS_FONT_OFFSET             = "Font Offset"
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Assign Heal Groups"
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Now Excluding Mount"
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "No longer Excluding Mount"
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Toggle Exclude Mount"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Hide mini boss frames";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Hide raid frames";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Alias"
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Heal Groups"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Apply current tab settings to all Frames"
    HEALBOT_WORDS_PROFILE                   = "Profile"
    HEALBOT_SHARE_SCREENSHOT                = "ScreenShot taken"
    HEALBOT_SHARE_INSTRUCTION               = "Go to the website for instructions on sharing with "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "Use frame"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Include my target"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Include tanks targets"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Enemy Options";
    HEALBOT_OPTIONS_SHARE_OPT               = "Share Options";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Share"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Enemy"
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "Load skin"
    HEALBOT_ENEMY_NO_TARGET                 = "No target"
    HEALBOT_OPTIONS_ENEMYBARS               = "Enemy bars at all times";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Harmful Spells"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Include My Targets targets"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Number of Bosses"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Hide bars out of combat"
    HEALBOT_ENEMY_EXISTS_SHOW               = "Entering combat only".."\n".."show when exists"
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Player targets"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Boss bars"
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Target: Only show Friendly"
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "Focus: Only show Friendly"
    HEALBOT_OPTIONS_PROFILE                 = "Profile for".."\n".."Spells/Buffs/Cures"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Character"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Class"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Alert Level - In Combat";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Alert Level - Out of Combat";
    HEALBOT_OPTION_NUMENEMYS                = "Number of Enemys"
    HEALBOT_WORD_AUTO                       = "Auto"
	HEALBOT_OPTIONS_ENABLEAUTOCOMBAT        = "Enable HealBot autoCombat"
end

if (GetLocale() == "enUK") then
    HealBot_Lang_enUK()
else
    HealBot_Lang_enUS()
end