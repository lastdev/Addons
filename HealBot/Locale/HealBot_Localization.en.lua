-------------
-- ENGLISH --
-------------

-------------------
-- Compatibility --
-------------------

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

-- Debuffs
HEALBOT_DEBUFF_ANCIENT_HYSTERIA         = "Ancient Hysteria";
HEALBOT_DEBUFF_IGNITE_MANA              = "Ignite Mana";
HEALBOT_DEBUFF_TAINTED_MIND             = "Tainted Mind";
HEALBOT_DEBUFF_VIPER_STING              = "Viper Sting";
HEALBOT_DEBUFF_SILENCE                  = "Silence";
HEALBOT_DEBUFF_MAGMA_SHACKLES           = "Magma Shackles";
HEALBOT_DEBUFF_FROSTBOLT                = "Frostbolt";
HEALBOT_DEBUFF_HUNTERS_MARK             = "Hunter's Mark";
HEALBOT_DEBUFF_SLOW                     = "Slow";
HEALBOT_DEBUFF_ARCANE_BLAST             = "Arcane Blast";
HEALBOT_DEBUFF_IMPOTENCE                = "Curse of Impotence";
HEALBOT_DEBUFF_DECAYED_STR              = "Decayed Strength";
HEALBOT_DEBUFF_DECAYED_INT              = "Decayed Intellect";
HEALBOT_DEBUFF_CRIPPLE                  = "Cripple";
HEALBOT_DEBUFF_CHILLED                  = "Chilled";
HEALBOT_DEBUFF_CONEOFCOLD               = "Cone of Cold";
HEALBOT_DEBUFF_CONCUSSIVESHOT           = "Concussive Shot";
HEALBOT_DEBUFF_THUNDERCLAP              = "Thunderclap";
HEALBOT_DEBUFF_HOWLINGSCREECH           = "Howling Screech";
HEALBOT_DEBUFF_DAZED                    = "Dazed";
HEALBOT_DEBUFF_UNSTABLE_AFFL            = "Unstable Affliction";
HEALBOT_DEBUFF_DREAMLESS_SLEEP          = "Dreamless Sleep";
HEALBOT_DEBUFF_GREATER_DREAMLESS        = "Greater Dreamless Sleep";
HEALBOT_DEBUFF_MAJOR_DREAMLESS          = "Major Dreamless Sleep";
HEALBOT_DEBUFF_FROST_SHOCK              = "Frost Shock"

HB_TOOLTIP_MANA                         = "^(%d+) Mana$";
HB_TOOLTIP_INSTANT_CAST                 = "Instant cast";
HB_TOOLTIP_CAST_TIME                    = "(%d+.?%d*) sec cast";
HB_TOOLTIP_CHANNELED                    = "Channeled";
HB_TOOLTIP_OFFLINE                      = "Offline";
HB_OFFLINE                              = "offline"; -- has gone offline msg
HB_ONLINE                               = "online"; -- has come online msg

-----------------
-- Translation --
-----------------

HEALBOT_ADDON                           = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED                          = " loaded.";

HEALBOT_ACTION_OPTIONS                  = "Options";

HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS                = "Defaults";
HEALBOT_OPTIONS_CLOSE                   = "Close";
HEALBOT_OPTIONS_HARDRESET               = "ReloadUI"
HEALBOT_OPTIONS_SOFTRESET               = "ResetHB"
HEALBOT_OPTIONS_INFO                    = "Info"
HEALBOT_OPTIONS_TAB_GENERAL             = "General";
HEALBOT_OPTIONS_TAB_SPELLS              = "Spells";
HEALBOT_OPTIONS_TAB_HEALING             = "Healing";
HEALBOT_OPTIONS_TAB_CDC                 = "Cure";
HEALBOT_OPTIONS_TAB_SKIN                = "Skins";
HEALBOT_OPTIONS_TAB_TIPS                = "Tips";
HEALBOT_OPTIONS_TAB_BUFFS               = "Buffs"

HEALBOT_OPTIONS_BARALPHA                = "Enabled opacity";
HEALBOT_OPTIONS_BARALPHAINHEAL          = "Incoming heals opacity";
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
HEALBOT_SKIN_DISABLED                   = HEALBOT_SKIN_DISTEXT
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

HEALBOT_OPTIONS_CDCBARS                 = "Bar colours";
HEALBOT_OPTIONS_CDCSHOWHBARS            = "Change health bar colour";
HEALBOT_OPTIONS_CDCSHOWABARS            = "Change aggro bar colour";
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
HEALBOT_OPTIONS_MAINASSIST              = "Main assist";
HEALBOT_OPTIONS_PRIVATETANKS            = "Private main tanks";
HEALBOT_OPTIONS_TARGETHEALS             = "Targets";
HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raid";
HEALBOT_OPTIONS_ALERTLEVEL              = "Alert Level";
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
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Colour text by class";
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
HEALBOT_SKIN_HEADERBARCOL               = "Bar colour";
HEALBOT_SKIN_HEADERTEXTCOL              = "Text colour";
HEALBOT_OPTIONS_BUFFSTEXT1              = "Spell to buff";
HEALBOT_OPTIONS_BUFFSTEXT2              = "check members";
HEALBOT_OPTIONS_BUFFSTEXT3              = "bar colours";
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

HEALBOT_OPTIONS_RANGECHECKFREQ          = "Range, Aura and Aggro check frequency";

HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Hide party frames";
HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Include player and target";
HEALBOT_OPTIONS_DISABLEHEALBOT          = "Disable HealBot";

HEALBOT_OPTIONS_CHECKEDTARGET           = "Checked";

HEALBOT_ASSIST                          = "Assist";
HEALBOT_FOCUS                           = "Focus";
HEALBOT_MENU                            = "Menu";
HEALBOT_MAINTANK                        = "MainTank";
HEALBOT_MAINASSIST                      = "MainAssist";
HEALBOT_STOP                            = "Stop";
HEALBOT_TELL                            = "Tell";

HEALBOT_TITAN_SMARTCAST                 = "SmartCast";
HEALBOT_TITAN_MONITORBUFFS              = "Monitor buffs";
HEALBOT_TITAN_MONITORDEBUFFS            = "Monitor debuffs"
HEALBOT_TITAN_SHOWBARS                  = "Show bars for";
HEALBOT_TITAN_EXTRABARS                 = "Extra bars";
HEALBOT_BUTTON_TOOLTIP                  = "Left click to toggle HealBot options panel\nRight click (hold) to move this icon";
HEALBOT_TITAN_TOOLTIP                   = "Left click to toggle HealBot options panel";
HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Show minimap button";
HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Show HoT";
HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Show Raid Target";
HEALBOT_OPTIONS_HOTONBAR                = "On bar";
HEALBOT_OPTIONS_HOTOFFBAR               = "Off bar";
HEALBOT_OPTIONS_HOTBARRIGHT             = "Right side";
HEALBOT_OPTIONS_HOTBARLEFT              = "Left side";

HEALBOT_ZONE_AB                         = "Arathi Basin";
HEALBOT_ZONE_AV                         = "Alterac Valley";
HEALBOT_ZONE_ES                         = "Eye of the Storm";
HEALBOT_ZONE_IC                         = "Isle of Conquest";
HEALBOT_ZONE_SA                         = "Strand of the Ancients";
HEALBOT_ZONE_WG                         = "Warsong Gulch";

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

HEALBOT_BALANCE                         = "Balance"
HEALBOT_FERAL                           = "Feral"
HEALBOT_RESTORATION                     = "Restoration"
HEALBOT_SHAMAN_RESTORATION              = "Restoration"
HEALBOT_ARCANE                          = "Arcane"
HEALBOT_FIRE                            = "Fire"
HEALBOT_FROST                           = "Frost"
HEALBOT_DISCIPLINE                      = "Discipline"
HEALBOT_HOLY                            = "Holy"
HEALBOT_SHADOW                          = "Shadow"
HEALBOT_ASSASSINATION                   = "Assassination"
HEALBOT_COMBAT                          = "Combat"
HEALBOT_SUBTLETY                        = "Subtlety"
HEALBOT_ARMS                            = "Arms"
HEALBOT_FURY                            = "Fury"
HEALBOT_PROTECTION                      = "Protection"
HEALBOT_BEASTMASTERY                    = "Beast Mastery"
HEALBOT_MARKSMANSHIP                    = "Marksmanship"
HEALBOT_SURVIVAL                        = "Survival"
HEALBOT_RETRIBUTION                     = "Retribution"
HEALBOT_ELEMENTAL                       = "Elemental"
HEALBOT_ENHANCEMENT                     = "Enhancement"
HEALBOT_AFFLICTION                      = "Affliction"
HEALBOT_DEMONOLOGY                      = "Demonology"
HEALBOT_DESTRUCTION                     = "Destruction"
HEALBOT_BLOOD                           = "Blood"
HEALBOT_UNHOLY                          = "Unholy"

HEALBOT_OPTIONS_NOTIFY_HEAL_MSG         = "Heal Message"
HEALBOT_OPTIONS_NOTIFY_MSG              = "Message"
HEALBOT_WORDS_YOU                       = "you";
HEALBOT_NOTIFYOTHERMSG                  = "Casting #s on #n";

HEALBOT_OPTIONS_HOTPOSITION             = "Icon position"
HEALBOT_OPTIONS_HOTSHOWTEXT             = "Show icon text"
HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Count"
HEALBOT_OPTIONS_HOTTEXTDURATION         = "Duration"
HEALBOT_OPTIONS_ICONSCALE               = "Icon Scale"
HEALBOT_OPTIONS_ICONTEXTSCALE           = "Icon Text Scale"

HEALBOT_SKIN_FLUID                      = "Fluid"
HEALBOT_SKIN_VIVID                      = "Vivid"
HEALBOT_SKIN_LIGHT                      = "Light"
HEALBOT_SKIN_SQUARE                     = "Square"
HEALBOT_OPTIONS_AGGROBARSIZE            = "Aggro bar size"
HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Double text lines"
HEALBOT_OPTIONS_TEXTALIGNMENT           = "Text Alignment"
HEALBOT_VEHICLE                         = "Vehicle"
HEALBOT_OPTIONS_UNIQUESPEC              = "Save unique spells for each spec"
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
HEALBOT_D_DURATION                      = "Direct duration";
HEALBOT_H_DURATION                      = "HoT Duration";
HEALBOT_C_DURATION                      = "Channelled Duration";

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
                [7] = "[HealBot] /hb info -- Show the info window",
                [8] = "[HealBot] /hb spt -- Self Pet toggle",
                [9] = "[HealBot] /hb ws -- Toggle Hide/Show the Weaken Soul icon instead of the PW:S with a -",
               [10] = "[HealBot] /hb rld <n> -- In seconds, how long the players name stays green after a res",
               [11] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
               [12] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
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
HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto Target"
HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Trinket"
HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Use Groups per Column"

HEALBOT_OPTIONS_MAINSORT                = "Main sort"
HEALBOT_OPTIONS_SUBSORT                 = "Sub sort"
HEALBOT_OPTIONS_SUBSORTINC              = "Also sub sort:"

HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "cast when"
HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Pressed"
HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Released"

HEALBOT_INFO_INCHEALINFO                = "== Healbot Version Information =="
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
HEALBOT_CHAT_NEWVERSION2                = "at http://www.healbot.info"
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
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Unable to receive all Skin settings - Possibly missing SharedMedia, see HealBot/Docs/readme.html for links"
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
HEALBOT_WORDS_R                         = "R"
HEALBOT_WORDS_G                         = "G"
HEALBOT_WORDS_B                         = "B"
HEALBOT_CHAT_SELFPETSON                 = "Self Pet switched on"
HEALBOT_CHAT_SELFPETSOFF                = "Self Pet switched off"
HEALBOT_WORD_PRIORITY                   = "Priority"
HEALBOT_VISIBLE_RANGE                   = "Within 100 yards"
HEALBOT_SPELL_RANGE                     = "Within spell range"
HEALBOT_CUSTOM_CATEGORY                 = "Category"
HEALBOT_CUSTOM_CAT_CUSTOM               = "Custom"
HEALBOT_CUSTOM_CAT_CLASSIC              = "Classic"
HEALBOT_CUSTOM_CAT_TBC_OTHER            = "TBC - Other"
HEALBOT_CUSTOM_CAT_TBC_BT               = "TBC - Black Temple"
HEALBOT_CUSTOM_CAT_TBC_SUNWELL          = "TBC - Sunwell"
HEALBOT_CUSTOM_CAT_LK_OTHER             = "WotLK - Other"
HEALBOT_CUSTOM_CAT_LK_ULDUAR            = "WotLK - Ulduar"
HEALBOT_CUSTOM_CAT_LK_TOC               = "WotLK - Trial of the Crusader"
HEALBOT_CUSTOM_CAT_LK_ICC_LOWER         = "WotLK - ICC Lower Spire"
HEALBOT_CUSTOM_CAT_LK_ICC_PLAGUEWORKS   = "WotLK - ICC The Plagueworks"
HEALBOT_CUSTOM_CAT_LK_ICC_CRIMSON       = "WotLK - ICC The Crimson Hall"
HEALBOT_CUSTOM_CAT_LK_ICC_FROSTWING     = "WotLK - ICC Frostwing Halls"
HEALBOT_CUSTOM_CAT_LK_ICC_THRONE        = "WotLK - ICC The Frozen Throne"
HEALBOT_CUSTOM_CAT_LK_RS_THRONE         = "WotLK - Ruby Sanctum"
HEALBOT_CUSTOM_CAT_CATA_OTHER           = "Cata - Other"
HEALBOT_CUSTOM_CAT_CATA_PARTY           = "Cata - Party"
HEALBOT_CUSTOM_CAT_CATA_RAID            = "Cata - Raid"
HEALBOT_WORD_RESET                      = "Reset"
HEALBOT_HBMENU                          = "HBmenu"
HEALBOT_ACTION_HBFOCUS                  = "Left click to set\nfocus on target"
HEALBOT_WORD_CLEAR                      = "Clear"
HEALBOT_WORD_SET                        = "Set"
HEALBOT_WORD_HBFOCUS                    = "HealBot Focus"
HEALBOT_WORD_OUTSIDE                    = "Outside"
HEALBOT_WORD_ALLZONE                    = "All zones"
HEALBOT_WORD_OTHER                      = "Other"
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
HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Health bar colour";
HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Incoming heals colour";
HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Target: Always show"
HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Focus: Always show"
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: Groups of five"
HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Use Game Tooltip"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Show power counter"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Show holy power"
HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Reverse Duration"
HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "only when solo"

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
HEALBOT_ZONE_THEOCULUS                  = "The Oculus"
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