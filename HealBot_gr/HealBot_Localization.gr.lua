-- Greek maintained by Snaomi.

-------------
-- GREEK --
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

function HealBot_Lang_grGR()

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

    HEALBOT_ACTION_OPTIONS                  = "Ρυθμίσεις";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "Προεπιλογές";
    HEALBOT_OPTIONS_CLOSE                   = "Κλείσιμο";
    HEALBOT_OPTIONS_HARDRESET               = "Ανανεωση UI"
    HEALBOT_OPTIONS_SOFTRESET               = "Επαναφορά HB"
    HEALBOT_OPTIONS_TAB_GENERAL             = "Γενικά";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Spells";
    HEALBOT_OPTIONS_TAB_HEALING             = "Healing";
    HEALBOT_OPTIONS_TAB_CDC                 = "Cure";
    HEALBOT_OPTIONS_TAB_SKIN                = "Skins";
    HEALBOT_OPTIONS_TAB_TIPS                = "Συμβουλές";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Buffs"

    HEALBOT_OPTIONS_BARALPHA                = "opacity ενεργό";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Οpacity εισερχομενων heals";
    HEALBOT_OPTIONS_BARALPHABACK            = "Opacity μπαρας φόντου";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Opacity εκτος εμβελειας ";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Κλείδωμα θεσης";
    HEALBOT_OPTIONS_AUTOSHOW                = "Αυτοματο κλείσιμο";
    HEALBOT_OPTIONS_PANELSOUNDS             = "Aναπαραγωγη ηχου σε ανοιγμα";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Aποκρυψη κουμπιου ρυθμισεων";
    HEALBOT_OPTIONS_PROTECTPVP              = "Αποφυγη PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Ρυθμίσεις Chat";

    HEALBOT_OPTIONS_FRAMESCALE              = "Κλιμακα Frame";
    HEALBOT_OPTIONS_SKINTEXT                = "Χρηση skin";
    HEALBOT_SKINS_STD                       = "Προτυπο";
    HEALBOT_OPTIONS_SKINTEXTURE             = "Texture";
    HEALBOT_OPTIONS_SKINHEIGHT              = "Υψος";
    HEALBOT_OPTIONS_SKINWIDTH               = "Μηκος";
    HEALBOT_OPTIONS_SKINNUMCOLS             = "Αριθμ. σειρων";
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "Αριθμ. group ανα σειρα";
    HEALBOT_OPTIONS_SKINBRSPACE             = "Αποσταση σειρας";
    HEALBOT_OPTIONS_SKINBCSPACE             = "Αποσταση στηλης";
    HEALBOT_OPTIONS_EXTRASORT               = "Ταξινόμηση μπαρας Raid ανα";
    HEALBOT_SORTBY_NAME                     = "Ονομα";
    HEALBOT_SORTBY_CLASS                    = "Κλαση";
    HEALBOT_SORTBY_GROUP                    = "Group";
    HEALBOT_SORTBY_MAXHEALTH                = "Μεγιστο health";
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Νεα debuff";
    HEALBOT_OPTIONS_DELSKIN                 = "Διαγραφη";
    HEALBOT_OPTIONS_NEWSKINTEXT             = "Νεο skin";
    HEALBOT_OPTIONS_SAVESKIN                = "Αποθηκευση";
    HEALBOT_OPTIONS_SKINBARS                = "Επιλογες Μπαρας";
    HEALBOT_SKIN_ENTEXT                     = "Ενεργο";
    HEALBOT_SKIN_DISTEXT                    = "Απενεργο";
    HEALBOT_SKIN_DEBTEXT                    = "Debuff";
    HEALBOT_SKIN_BACKTEXT                   = "Φοντο";
    HEALBOT_SKIN_BORDERTEXT                 = "Πλαισιο";
    HEALBOT_OPTIONS_SKINFONT                = "Γραμματοσειρες";
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Μεγεθ. Γραμματοσειρας";
    HEALBOT_OPTIONS_SKINFOUTLINE            = "Font Outline";
    HEALBOT_OPTIONS_BARALPHADIS             = "Απενεργοποιηση opacity";
    HEALBOT_OPTIONS_SHOWHEADERS             = "Εμφανιση headers";

    HEALBOT_OPTIONS_ITEMS                   = "Αντικειμενα";

    HEALBOT_OPTIONS_COMBOCLASS              = "Key combos για";
    HEALBOT_OPTIONS_CLICK                   = "Click";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Always use enabled";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Κανενα μηνυμα";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Share σε εμενα";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Share στο target";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Share στο Party";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Share στο Raid";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "Share σε καναλι";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Share μονο για Resurection";

    HEALBOT_OPTIONS_CDCBARS                 = "Bar colors";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "Change health bar color"
    HEALBOT_OPTIONS_CDCSHOWABARS            = "Change aggro bar color"
    HEALBOT_OPTIONS_CDCWARNINGS             = "Προειδοποιήσεις Debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Εμφανιση debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Εμφανιση warning στο debuff";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Αναπαραγωγη ηχου στο debuff";
    HEALBOT_OPTIONS_SOUND                   = "Ηχος";

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Healing bars";
    HEALBOT_OPTIONS_SELFHEALS               = "Προσωπικα";
    HEALBOT_OPTIONS_PETHEALS                = "Pets";
    HEALBOT_OPTIONS_GROUPHEALS              = "Group";
    HEALBOT_OPTIONS_TANKHEALS               = "Main tanks";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Private main tanks";
    HEALBOT_OPTIONS_TARGETHEALS             = "Targets";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raid";
    HEALBOT_OPTIONS_EMERGFILTER             = "Εμφανιση raid bar για";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Διαμορφωση των classes για";
    HEALBOT_OPTIONS_COMBOBUTTON             = "Κουμπι mouse";
    HEALBOT_OPTIONS_BUTTONLEFT              = "Αριστερο";
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Μεσαιο";
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Δεξι";
    HEALBOT_OPTIONS_BUTTON4                 = "Κουμπι4";
    HEALBOT_OPTIONS_BUTTON5                 = "Κουμπι5";
    HEALBOT_OPTIONS_BUTTON6                 = "Κουμπι6";
    HEALBOT_OPTIONS_BUTTON7                 = "Κουμπι7";
    HEALBOT_OPTIONS_BUTTON8                 = "Κουμπι8";
    HEALBOT_OPTIONS_BUTTON9                 = "Κουμπι9";
    HEALBOT_OPTIONS_BUTTON10                = "Κουμπι10";
    HEALBOT_OPTIONS_BUTTON11                = "Κουμπι11";
    HEALBOT_OPTIONS_BUTTON12                = "Κουμπι12";
    HEALBOT_OPTIONS_BUTTON13                = "Κουμπι13";
    HEALBOT_OPTIONS_BUTTON14                = "Κουμπι14";
    HEALBOT_OPTIONS_BUTTON15                = "Κουμπι15";

    HEALBOT_CLASSES_ALL                     = "Ολες οι classes";
    HEALBOT_CLASSES_MELEE                   = "Melee";
    HEALBOT_CLASSES_RANGES                  = "Ranged";
    HEALBOT_CLASSES_HEALERS                 = "Healers";
    HEALBOT_CLASSES_CUSTOM                  = "Προσαρμογη";

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Εμφανιση επεξηγησεων";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Εμφανιση πληροφοριων για το spell";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Εμφανιση spell cooldown";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Εμφανιση πληροφοριων για το target ";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Εμφανιση προτεινόμενου heal over time";
    HEALBOT_TOOLTIP_POSDEFAULT              = "Προεπιλεγμενη τοποθεσια";
    HEALBOT_TOOLTIP_POSLEFT                 = "Αριστερα του Healbot";
    HEALBOT_TOOLTIP_POSRIGHT                = "Δεξια του Healbot";
    HEALBOT_TOOLTIP_POSABOVE                = "Απο πανω απο το Healbot";
    HEALBOT_TOOLTIP_POSBELOW                = "Απο κατω απο το Healbot";
    HEALBOT_TOOLTIP_POSCURSOR               = "Διπλα απο τον Cursor";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Υποδειξη Heal over time ";
    HEALBOT_TOOLTIP_NONE                    = "μη Διαθεσιμο";
    HEALBOT_TOOLTIP_CORPSE                  = "Πτωμα του παιχτη ";
    HEALBOT_TOOLTIP_CD                      = " (CD ";
    HEALBOT_TOOLTIP_SECS                    = "s)";
    HEALBOT_WORDS_SEC                       = "δευτ.";
    HEALBOT_WORDS_CAST                      = "Cast";
    HEALBOT_WORDS_UNKNOWN                   = "Αγνωστο";
    HEALBOT_WORDS_YES                       = "Ναι";
    HEALBOT_WORDS_NO                        = "Οχι";
    HEALBOT_WORDS_THIN                      = "Λεπτο";
    HEALBOT_WORDS_THICK                     = "Παχυ";

    HEALBOT_WORDS_NONE                      = "Κανενα";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_DISABLED_TARGET                 = "Target";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Eμφανιση class στην μπαρα";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Εμφανιση health στην bar";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Περιλαμβανωμενων incoming heals";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Ανεξαρτητα incoming heals";
    HEALBOT_OPTIONS_BARHEALTH1              = "as delta";
    HEALBOT_OPTIONS_BARHEALTH2              = "ως ποσοστο";
    HEALBOT_OPTIONS_TIPTEXT                 = "Πληροφοριες επεξηγησης";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Θεση επεξηγησης";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Εμφανιση ονοματος στην μπαρα";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Color text by class";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Περιλαμβανωμενων raid groups";

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS             = "Ορισμος ως προεπιλογη";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Επαναφορα ρυθμισεων";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "Ανοιγμα επιλογων με το Δεξι click";

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "Επιλογες Header";
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Επιλογες Εικονιδιου";
    HEALBOT_SKIN_HEADERBARCOL               = "Bar color"
    HEALBOT_SKIN_HEADERTEXTCOL              = "Text color"
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Spell to buff";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "Ελεγχος μελων";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "bar colors";
    HEALBOT_OPTIONS_BUFF                    = "Buff ";
    HEALBOT_OPTIONS_BUFFSELF                = "σε εμενα";
    HEALBOT_OPTIONS_BUFFPARTY               = "στο party";
    HEALBOT_OPTIONS_BUFFRAID                = "στο raid";
    HEALBOT_OPTIONS_MONITORBUFFS            = "Ελεγχος για τα buffs";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "οταν βρισκομαι σε combat";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "SmartCast εκτος combat";
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Περιλαμβανωμενων spells";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Aφαιρεση debuffs";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Προσθηκη buffs";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Healing spells";
    HEALBOT_OPTIONS_BAR2SIZE                = "Μεγεθος Power bar";
    HEALBOT_OPTIONS_SETSPELLS               = "Ρυθμίσεις για";
    HEALBOT_OPTIONS_ENABLEDBARS             = "Ενεργα bars ανεξαρτητος καταστασης";
    HEALBOT_OPTIONS_DISABLEDBARS            = "Αποκρυψη bars οταν βρισκομαι εκτος combat";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Ελεγχος για αφαιρεση debuffs";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Spell για αφαιρεση debuffs";

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Αγνοησε debuffs:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "Ανα class";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Slow movement";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Short duration";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Non harmful";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "Οταν το spell CoolDown ειναι > 1.5 secs (GCD)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "Οταν ο caster ειναι φιλικο unit";

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Συχνοτητα ελεγχου Range, Aura και Aggro";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Αποκρυψη party";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Περιλαμβανωμενων παιχτων και target";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Απενεργοποιηση HealBot";

    HEALBOT_ASSIST                          = "Assist";
    HEALBOT_FOCUS                           = "Focus";
    HEALBOT_MENU                            = "Μενου";
    HEALBOT_MAINTANK                        = "MainTank";
    HEALBOT_STOP                            = "Stop";
    HEALBOT_TELL                            = "Λεω";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Εμφανιση κουμπιου στο minimap";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Εμφανιση HoT";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Εμφανιση Raid Target";
    HEALBOT_OPTIONS_HOTONBAR                = "στην bar";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Εκτος bar";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "Δεξια μερια";
    HEALBOT_OPTIONS_HOTBARLEFT              = "Αριστερη μερια";

    HEALBOT_ZONE_AB                         = GetMapNameByID(461) or "Arathi Basin";
    HEALBOT_ZONE_AV                         = GetMapNameByID(401) or "Alterac Valley";
    HEALBOT_ZONE_ES                         = GetMapNameByID(482) or "Eye of the Storm";
    HEALBOT_ZONE_IC                         = GetMapNameByID(540) or "Isle of Conquest";
    HEALBOT_ZONE_SA                         = GetMapNameByID(512) or "Strand of the Ancients";

    HEALBOT_OPTION_AGGROTRACK               = "Ελεγχος Aggro";
    HEALBOT_OPTION_AGGROBAR                 = "Bar";
    HEALBOT_OPTION_AGGROTXT                 = ">> Κειμενο <<";
    HEALBOT_OPTION_AGGROIND                 = "Ενδειξη";
    HEALBOT_OPTION_BARUPDFREQ               = "Ανανεωση Multiplier";
    HEALBOT_OPTION_USEFLUIDBARS             = "Εφαρμογη fluid bars";
    HEALBOT_OPTION_CPUPROFILE               = "Eφαρμογη CPU profiler (Πληροφοριες χρησης CPU απο τα Addons)";
    HEALBOT_OPTIONS_RESETUIMSG             = "Αυτη η επιλογη απαιτει Ανανεωση UI, να γινει τωρα?";

    HEALBOT_BUFF_PVP                        = "PvP";
    HEALBOT_BUFF_PVE						= "PvE";
    HEALBOT_OPTIONS_ANCHOR                  = "Frame anchor";
    HEALBOT_OPTIONS_BARSANCHOR              = "Bars anchor";
    HEALBOT_OPTIONS_TOPLEFT                 = "Πανω Αριστερα";
    HEALBOT_OPTIONS_BOTTOMLEFT              = "Κατω Αριστερα";
    HEALBOT_OPTIONS_TOPRIGHT                = "Πανω Δεξια";
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Κατω Δεξια";
    HEALBOT_OPTIONS_TOP                     = "Πανω";
    HEALBOT_OPTIONS_BOTTOM                  = "Κατω";

    HEALBOT_PANEL_BLACKLIST                 = "BlackList";

    HEALBOT_WORDS_REMOVEFROM                = "Διαγραφη απο";
    HEALBOT_WORDS_ADDTO                     = "Εισαγωγη σε";
    HEALBOT_WORDS_INCLUDE                   = "Περιλαμβανωμενων";

    HEALBOT_OPTIONS_TTALPHA                 = "Opacity";
    HEALBOT_TOOLTIP_TARGETBAR               = "Target Bar";
    HEALBOT_OPTIONS_MYTARGET                = "Οι Targets μου";

    HEALBOT_DISCONNECTED_TEXT               = "<DC>";
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Εμφανιση των buffs μου";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "Συνεχομενη ανανεωση";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Εμφανιση buff πριν απο το τελος";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Mικρα σε διαρκεια buffs";
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Μεγαλα σε διαρκεια buffs";

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Μηνυμα";
    HEALBOT_WORDS_YOU                       = "εσυ";
    HEALBOT_NOTIFYOTHERMSG                  = "Κασταρω #s στον παιχτη #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Θέση εικονίδιου";
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Εμφανιση κειμένου στο εικονίδιο";
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Μετρητής";
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Διάρκεια";
    HEALBOT_OPTIONS_ICONSCALE               = "Κλίμακα εικονιδίου";
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Κλιμακα κειμένου εικονίδιου";

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Μεγεθος Aggro bar";
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Διπλες γραμμες κειμενου";
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Ευθυγραμμιση κειμενου";
    HEALBOT_VEHICLE                         = "Οχημα";
    HEALBOT_WORDS_ERROR                     = "ΛΑθΟΣ";
    HEALBOT_SPELL_NOT_FOUND	                = "Το Spell δεν βρεθηκε";
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Αποκρυψη	Tooltip οταν ειμαι σε Combat";
    HEALBOT_OPTIONS_ENABLELIBQH             = "Ενεργοποιηση HealBot fastHealth";

    HEALBOT_OPTIONS_BUFFNAMED               = "Εισαγωγη ονοματος παιχτη για παρακολουθηση\n\n";
    HEALBOT_WORD_ALWAYS                     = "Παντα";
    HEALBOT_WORD_SOLO                       = "Solo";
    HEALBOT_WORD_NEVER                      = "Ποτε";
    HEALBOT_SHOW_CLASS_AS_ICON              = "ως εικονίδιο";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "ως κειμενο";
    HEALBOT_SHOW_ROLE                       = "Να γινει εμφανιση του ρολου";

    HEALBOT_SHOW_INCHEALS                   = "Εμφανιση εισερχομενων heals";

    HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Εμφανιση βοηθειας",
                   [2] = "[HealBot] /hb o -- Εναλλαγη Επιλογων",
                   [3] = "[HealBot] /hb t -- Εναλλαγη Healbot απο ενεργο σε ανενεργο",
                   [4] = "[HealBot] /hb bt -- Εναλλαγη Buff Monitor απο ενεργο σε ανενεργο",
                   [5] = "[HealBot] /hb dt -- Εναλλαγη Debuff Monitor απο ενεργο σε ανενεργο",
                   [6] = "[HealBot] /hb skin <skinName> -- Αλλγη Skins",
                   [7] = "[HealBot] /hb d -- Επαναφορα στις αρχικες επιλογες",
                   [8] = "[HealBot] /hb spt -- Εναλλαγη Self Pet",
                   [9] = "[HealBot] /hb flb -- Εναλλαγη της παρακαμψεις του frame lock ( το frame μετακινητε παντα με Ctrl+Alt+Αριστερο click)",
                   [10] = "[HealBot] /hb hs -- Εμφανιση επιπλεον εντολων",
                  }

    HEALBOT_HELP2={ [1] = "[HealBot] /hb rtb -- Εναλαγη restrict target bar σε Αριστερο=SmartCast και Δεξι= προσθηκη/αφαιρεση σε/απο τα Targets μου",
                    [2] = "[HealBot] /hb aggro 2 <n> -- Εφαρμογη aggro level 2 στο ποσοστο threat <n>",
                    [3] = "[HealBot] /hb aggro 3 <n> -- Εφαρμογη aggro level 3 στο ποσοστο threat <n>",
                    [4] = "[HealBot] /hb tr <Role> -- Εφαρμογη προτεραιοτητ μεγαλυτερου ρολου για SubSort by Role. Οι εγκυροι ρολοι ειναι 'TANK', 'HEALER' ή 'DPS'",
                    [5] = "[HealBot] /hb use10 -- Αυτοματη χρηση της Engineering slot 10",
                    [6] = "[HealBot] /hb pcs <n> -- Διαμορφωση μεγεθους του δεικτη Holy power σε <n>, το προεπιλεγμενο ειναι 7 ",
                    [7] = "[HealBot] /hb hrfm -- Εναλαγη μεθοδου για αποκρυψη των raid frames της Blizzard , πληρη απενεργοποιηση ή αποκρυψη",
                    [8] = "[HealBot] /hb ws -- Εναλαγη Εμφανισης / Αποκρυψης του εικονιδιου Weaken Soul αντι του PW:S με -",
                    [9] = "[HealBot] /hb rld <n> -- Ποσα δευτερολεπτα μενει πρασινο το ονομα του παιχτη μετα απο ενα resurection",
                    [10] = "[HealBot] /hb shhp <n> -- Εμφανιση του HYMN OF HOPE Buff οταν το μανα βρισκεται κατω απο <n>",
                    [11] = "[HealBot] - Εμφανιση εντολων στο tab Γενικα στις Ρυθμίσεις",
                  }
                  
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Επισημανση mouseover";
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Επισημανση target";
    HEALBOT_OPTIONS_TESTBARS                = "Test Bars";
    HEALBOT_OPTION_NUMBARS                  = "Αριθμος Bars";
    HEALBOT_OPTION_NUMTANKS                 = "Αριθμος Tanks";
    HEALBOT_OPTION_NUMMYTARGETS             = "Αριθμος των MyTargets";
    HEALBOT_OPTION_NUMHEALERS               = "Αριθμος Healers";
    HEALBOT_OPTION_NUMPETS                  = "Αριθμος Pets";
    HEALBOT_WORD_TEST                       = "Test";
    HEALBOT_WORD_OFF                        = "-Απενεργοποιηση";
    HEALBOT_WORD_ON                         = "-Ενεργοποιηση";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Προστασια";
    HEALBOT_OPTIONS_TAB_CHAT                = "Chat";
    HEALBOT_OPTIONS_TAB_HEADERS             = "Κεφαλιδες";
    HEALBOT_OPTIONS_TAB_BARS                = "Bars";
    HEALBOT_OPTIONS_TAB_ICONS               = "Εικονιδια";
    HEALBOT_OPTIONS_TAB_WARNING             = "Προειδοποιήση";
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Default Skin για";
    HEALBOT_OPTIONS_INCHEAL                 = "Εισερχομενα heals";
    HEALBOT_WORD_ARENA                      = "Arena";
    HEALBOT_WORD_BATTLEGROUND               = "Battle Ground";
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Επιλογες κειμενου";
    HEALBOT_WORD_PARTY                      = "Party";
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto\nTarget";
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Trinket";
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Εφαρμογη Groups ανα στηλη";

    HEALBOT_OPTIONS_MAINSORT                = "Main sort";
    HEALBOT_OPTIONS_SUBSORT                 = "Sub sort";
    HEALBOT_OPTIONS_SUBSORTINC              = "Also sub sort:";

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "cast οταν";
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "το πατας";
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "το αφηνεις";

    HEALBOT_INFO_ADDONCPUUSAGE              = "== Χρηση CPU απο τα Addons, σε δευτερ. ==";
    HEALBOT_INFO_ADDONCOMMUSAGE             = "== Χρηση Addon Comms ==";
    HEALBOT_WORD_HEALER                     = "Healer";
    HEALBOT_WORD_DAMAGER                    = "Damager";
    HEALBOT_WORD_TANK                       = "Tank";
    HEALBOT_WORD_LEADER                     = "Leader";
    HEALBOT_WORD_VERSION                    = "Εκδοση";
    HEALBOT_WORD_CLIENT                     = "Client";
    HEALBOT_WORD_ADDON                      = "Addon";
    HEALBOT_INFO_CPUSECS                    = "CPU σε δευτερ.";
    HEALBOT_INFO_MEMORYMB                   = "Μνημη σε MB";
    HEALBOT_INFO_COMMS                      = "Comms σε KB";

    HEALBOT_WORD_STAR                       = "Star"
    HEALBOT_WORD_CIRCLE                     = "Circle"
    HEALBOT_WORD_DIAMOND                    = "Diamond"
    HEALBOT_WORD_TRIANGLE                   = "Triangle"
    HEALBOT_WORD_MOON                       = "Moon"
    HEALBOT_WORD_SQUARE                     = "Square"
    HEALBOT_WORD_CROSS                      = "Cross"
    HEALBOT_WORD_SKULL                      = "Skull"

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Αποδοχη του [HealBot] Skin: ";
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " απο ";
    HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Μοιρασου το με";

    HEALBOT_CHAT_ADDONID                    = "[HealBot]  "
    HEALBOT_CHAT_NEWVERSION1                = "Μια καινουργια εκδοση ειναι διαθεσιμη"
    HEALBOT_CHAT_NEWVERSION2                = "στο site "..HEALBOT_ABOUT_URL
    HEALBOT_CHAT_SHARESKINERR1              = " το Skin δεν ωρεθηκε"
    HEALBOT_CHAT_SHARESKINERR3              = " δεν βρεθηκε για Sharing"
    HEALBOT_CHAT_SHARESKINACPT              = "το Share Skin αποδεχτηκε απο "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Εφαρμογη Skins σε Defaults"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "επαναφορα Custom Debuffs"
    HEALBOT_CHAT_CHANGESKINERR1             = "Αγνωστο skin: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2             = "Εγκυρο skins:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Τα τρεχοντα spells αντιγραφικαν για ολα τα specs"
    HEALBOT_CHAT_UNKNOWNCMD                 = "Αγνωστη εντολη: /hb "
    HEALBOT_CHAT_ENABLED                    = "Εισοδος σε κατασταση ενεργοποιησης"
    HEALBOT_CHAT_DISABLED                   = "Εισοδος σε κατασταση απενεργοποιησης"
    HEALBOT_CHAT_SOFTRESET                = "Αιτημα Reload healbot"
    HEALBOT_CHAT_HARDRESET                 = "Αιτημα Reload UI"
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "τα Spells εχουν επαναφερθει"
    HEALBOT_CHAT_CONFIRMCURESRESET          = "τα Cures εχουν επαναφερθει"
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "τα Buffs εχουν επαναφερθει"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Δεν ηταν δυνατον να ληφθουν ολες οι ρυθμισεις των Skin - Πιθανον να λειπει το SharedMedia, κατεβασε το απο το curse.com"
    HEALBOT_CHAT_MACROSOUNDON               = "Να μην καταστελλεται ο ηχος οταν χρησιμοποιω auto trinkets"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Να καταστελλεται ο ηχος οταν χρησιμοποιω auto trinkets"
    HEALBOT_CHAT_MACROERRORON               = "Να μην καταστελλωνται τα λαθη οταν χρησιμοποιω auto trinkets"
    HEALBOT_CHAT_MACROERROROFF              = "Να καταστελλωται τα λαθη οταν χρησιμοποιω auto trinkets"
    HEALBOT_CHAT_ACCEPTSKINON               = "Share Skin - Εμφανιση παραθυρου οταν καποιος μοιραζετε ενα skin μαζι σου"
    HEALBOT_CHAT_ACCEPTSKINOFF              = "Share Skin - Παντα να αγνοω τα share skins απο τους αλλους παιχτες"
    HEALBOT_CHAT_USE10ON                    = "Auto Trinket - το Use10 ειναι ενεργο - Πρεπει να ενεργοποιησεις ενα υπαρχων auto trinket για να δουλεψει το use10"
    HEALBOT_CHAT_USE10OFF                   = "Auto Trinket - το Use10 ειναι απενεργο"
    HEALBOT_CHAT_SKINREC                    = " Λαμβανω ενα skin απο παιχτη " 

    HEALBOT_OPTIONS_SELFCASTS               = "Μονο Self casts"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Εμφανιση εικονιδίου"
    HEALBOT_OPTIONS_ALLSPELLS               = "Ολα τα spells"
    HEALBOT_OPTIONS_DOUBLEROW               = "Διπλη σειρα"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Κατω απο τη bar"
    HEALBOT_OPTIONS_OTHERSPELLS             = "Διαφορα spells"
    HEALBOT_WORD_MACROS                     = "Macros"
    HEALBOT_WORD_SELECT                     = "Επιλογη"
    HEALBOT_OPTIONS_QUESTION                = ";"
    HEALBOT_WORD_CANCEL                     = "Ακυρο"
    HEALBOT_WORD_COMMANDS                   = "Εντολες"
    HEALBOT_OPTIONS_BARHEALTH3              = "ως health";
    HEALBOT_SORTBY_ROLE                     = "Ρολος"
    HEALBOT_WORD_DPS                        = "DPS"
    HEALBOT_CHAT_TOPROLEERR                 = " ο ρολος δεν ειναι εχκυρος - χρηση ως 'TANK', 'DPS' ή 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE                 = "Ο υψηλοτερος ρολος , τωρα, ειναι "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Ο παιχτης θα ταξινομηθει πρωτος στο SubSort"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Ο παιχτης θα ταξινομηθει σε κανονικη σειρα στο SubSort"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Εμφανιση Ready Check";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Να εμφανιζομαι πρωτος"
    HEALBOT_WORD_FILTER                     = "Φιλτρο"
    HEALBOT_OPTION_AGGROPCTBAR              = "Μετακινηση bar"
    HEALBOT_OPTION_AGGROPCTTXT              = "Εμφανιση κειμενου"
    HEALBOT_OPTION_AGGROPCTTRACK            = "Εμφανιση ποσοστου" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Μικρο threat"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - Υψηλο threat"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Tanking"
    HEALBOT_OPTIONS_AGGROALERT              = "Επιπεδο προειδοποιησης Bar"
    HEALBOT_OPTIONS_AGGROINDALERT           = "Επιπεδο προειδοποιησης Indicator"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Εμφανιση πληροφοριων ενεργου HoT"
    HEALBOT_WORDS_MIN                       = "min"
    HEALBOT_WORDS_MAX                       = "max"
    HEALBOT_CHAT_SELFPETSON                 = "το Pet μου να ειναι απενεργοποιημενο"
    HEALBOT_CHAT_SELFPETSOFF                = "το Pet μου να ειναι ενεργοποιημενο"
    HEALBOT_WORD_PRIORITY                   = "Προτεραιοτητα"
    HEALBOT_VISIBLE_RANGE                   = "Εντος 100 yards"
    HEALBOT_SPELL_RANGE                     = "Εντος εμβελειας spell"
    HEALBOT_WORD_RESET                      = "Επαναφορα"
    HEALBOT_HBMENU                          = "HBmenu"
    HEALBOT_ACTION_HBFOCUS                  = "Αριστερο click για να βαλεις το\ntarget σου σε focus"
    HEALBOT_WORD_CLEAR                      = "Καθαρισμος"
    HEALBOT_WORD_SET                        = "Ορισμος"
    HEALBOT_WORD_HBFOCUS                    = "HealBot Focus"
    HEALBOT_WORD_OUTSIDE                    = "Εκτος"
    HEALBOT_WORD_ALLZONE                    = "Ολες οι ζωνες"
    HEALBOT_OPTIONS_TAB_ALERT               = "Προειδοποιήση"
    HEALBOT_OPTIONS_TAB_SORT                = "Ταξινόμηση"
    HEALBOT_OPTIONS_TAB_HIDE                = "Αποκρυψη"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Κειμενο εικονίδιου"
    HEALBOT_OPTIONS_TAB_TEXT                = "Κειμενο Bar"
    HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncolor"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Συχνοτητα του Flash"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "opacity του Flash "
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Εμφανιση διαρκειας απο"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Διαρκεια προειδοποιησης απο"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Επαναφορα custom debuffs"
    HEALBOT_CMD_RESETSKINS                  = "Επαναφορα skins"
    HEALBOT_CMD_CLEARBLACKLIST              = "Καθαρισμος BlackList"
    HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Εναλλαγη αποδοχης Skins απο αλλους"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Εναλλαγη Dislike Mount"
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Ενεργοποιηση Dislike Mount"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Απενεργοποιηση Dislike Mount"
    HEALBOT_CMD_COPYSPELLS                  = "Αντιγραφη των spells σε ολα τα specs"
    HEALBOT_CMD_RESETSPELLS                 = "Επαναφορα spells"
    HEALBOT_CMD_RESETCURES                  = "Επαναφορα cures"
    HEALBOT_CMD_RESETBUFFS                  = "Επαναφορα buffs"
    HEALBOT_CMD_RESETBARS                   = "Επαναφορά της θεσης των bar"
    HEALBOT_CMD_SUPPRESSSOUND               = "Εναλλαγη καταστολλης ηχου οταν χρησιμοποιω auto trinkets"
    HEALBOT_CMD_SUPPRESSERRORS              = "Εναλλαγη καταστολλης λαθων οταν χρησιμοποιω auto trinkets"
    HEALBOT_OPTIONS_COMMANDS                = "Εντολες HealBot"
    HEALBOT_WORD_RUN                        = "Ορισμος"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Εφαρμογη mouse wheel"
    HEALBOT_OPTIONS_MOUSEUP                 = "Wheel up"
    HEALBOT_OPTIONS_MOUSEDOWN               = "Wheel down"
    HEALBOT_CMD_DELCUSTOMDEBUFF9            = "Διαγραφη custom debuffs στο priority 9"
	HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Διαγραφη custom debuffs στο priority 10"
	HEALBOT_CMD_DELCUSTOMDEBUFF11           = "Διαγραφη custom debuffs στο priority 11"
	HEALBOT_CMD_DELCUSTOMDEBUFF12           = "Διαγραφη custom debuffs στο priority 12"
    HEALBOT_ACCEPTSKINS                     = "Αποδοχη Skins απο παιχτες"
    HEALBOT_SUPPRESSSOUND                   = "Auto Trinket: Καταστολή Ηχου"
    HEALBOT_SUPPRESSERROR                   = "Auto Trinket: Απενεργοποιηση Λαθων"
    HEALBOT_OPTIONS_CRASHPROT               = "Προστασια απο Crash"
    HEALBOT_CP_MACRO_LEN                    = "Το ονομα του μακρο πρεπει να ειναι μεταξυ 1 κ 14 χαρακτηρες"
    HEALBOT_CP_MACRO_BASE                   = "Βασικη ονομασια macro"
    HEALBOT_CP_MACRO_SAVE                   = "Τελευταια αποθηκευση στης: "
    HEALBOT_CP_STARTTIME                    = "Protect duration on logon"
    HEALBOT_WORD_RESERVED                   = "Reserved"
    HEALBOT_OPTIONS_COMBATPROT              = "Προστασια Combat"
    HEALBOT_COMBATPROT_PARTYNO              = "bars Reserved για το Party"
    HEALBOT_COMBATPROT_RAIDNO               = "bars Reserved για το Raid"

    HEALBOT_WORD_HEALTH                     = "Health"
    HEALBOT_OPTIONS_DONT_SHOW               = "Να μην εμφανιζετε"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Ιδιο οπως το health (τρεχων health)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Ιδιο οπως το health (προβλεψη health)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "Προβλεψη health"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Health bar";
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "bar Φοντου";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Εισερχομενα heals";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Target: Εμφανιση παντα"
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Focus: Εμφανιση παντα"
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: Group ανα 5"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Χρηση Game Tooltip"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Εμφανιση μετρητη power"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Εμφανιση holy power"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Εμφανιση chi power"
    HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Αντιθετη διαρκεια"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "Μονο solo"
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Ολα τα Disease"
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Ολα τα Magic"
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Ολα τα Curse"
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Ολα τα Poison"
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Cast απο "

    HEALBOT_BLIZZARD_MENU                   = "Blizzard menu"
    HEALBOT_HB_MENU                         = "Healbot menu"
    HEALBOT_FOLLOW                          = "Follow"
    HEALBOT_TRADE                           = "Trade"
    HEALBOT_PROMOTE_RA                      = "Προβιβασε σε raid assistant"
    HEALBOT_DEMOTE_RA                       = "Υποβιβασε raid assistant"
    HEALBOT_TOGGLE_ENABLED                  = "ενεργοποιημενη Εναλλαγη"
    HEALBOT_TOGGLE_MYTARGETS                = "Εναλλαγη των My Targets"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Εναλλαγη σε προσωπικα tanks"
    HEALBOT_RESET_BAR                       = "Επαναφορα των bar"
    HEALBOT_HIDE_BARS                       = "Αποκρυψη των bars πανω απο 100 yards"
    HEALBOT_RANDOMMOUNT                     = "Τυχαιο Mount"
    HEALBOT_RANDOMGOUNDMOUNT                = "Τυχαιο μη πετουμενο Mount"
    HEALBOT_RANDOMPET                       = "Τυχαιο	Pet"
    HEALBOT_ZONE_AQ40                       = "Ahn'Qiraj"
    HEALBOT_ZONE_VASHJIR1                   = "Kelp'thar Forest"
    HEALBOT_ZONE_VASHJIR2                   = "Shimmering Expanse"
    HEALBOT_ZONE_VASHJIR3                   = "Abyssal Depths"
    HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
    HEALBOT_RESLAG_INDICATOR                = "Διατηρηση του ονοματος σε πρασινο.Μετα απο το res να γινει" 
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Διατηρηση του ονοματος σε πρασινο.Μετα απο το res πρεπει να ειναι μεταξυ 1 και 30" 
    HEALBOT_FRAMELOCK_BYPASS_OFF            = "Παραβλεψη του Frame lock, απενεργοποιημενο"
    HEALBOT_FRAMELOCK_BYPASS_ON             = "Παραβλεψη του Frame lock (Ctl+Alt+Left), ενεργοποιημενο"
    HEALBOT_RESTRICTTARGETBAR_ON            = "Περιορισμος του Target bar, ενεργοποιημενο"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Περιορισμος του Target bar απενεργοποιημενο"
    HEALBOT_AGGRO2_ERROR_MSG                = "Για να ορισεις aggro level 2, το ποσοστο threat πρεπει να ειναι αναμεσα στο 25 και 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "Για να ορισεις aggro level 3, το ποσοστο threat πρεπει να ειναι αναμεσα στο 75 και 100"
    HEALBOT_AGGRO2_SET_MSG                  = "Ορισε Aggro level 2 στο ποσοστο threat"
    HEALBOT_AGGRO3_SET_MSG                  = "Ορισε Aggro level 3 στο ποσοστο threat"
    HEALBOT_WORD_THREAT                     = "Threat"
    HEALBOT_AGGRO_ERROR_MSG                 = "Μη εγκυρο aggro level - χρησιμοποιησε 2 ή 3"

    HEALBOT_OPTIONS_QUERYTALENTS            = "Αναζητηση δεδομενων talent"       
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Low Mana indicator"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Να μην εμφανιζετε"
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Παραβλεψη των aura events οταν ειμαι σε resting"

    HEALBOT_WORD_ENABLE                     = "Ενεργο"
    HEALBOT_WORD_DISABLE                    = "Απενεργο"

    HEALBOT_OPTIONS_MYCLASS                 = "Η Class μου"

    HEALBOT_OPTIONS_CONTENT_ABOUT           = "        ΠΛηροφοριες"
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Mouse Wheel"
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Test"
    HEALBOT_OPTIONS_CONTENT_USAGE           = "        Χρηση"
    HEALBOT_OPTIONS_REFRESH                 = "Ανανεωση"

    HEALBOT_CUSTOM_CATEGORY                 = "Κατηγορια"
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Προσαρμοσμενο"
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

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Ολοι"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Enemy"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Friend"
    
    HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT     = "Σημαντικα Debuffs"
	HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE        = "Damaging Debuffs"
    HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT        = "Effect Debuffs"
    HEALBOT_CUSTOM_CAT_CUSTOM_MISC          = "Υπολοιπα Debuffs"
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
    HEALBOT_ABOUT_WEBSITE                  = "Ιστοσελιδα:"
    HEALBOT_ABOUT_AUTHORH                  = "Δημιουργος:"
    HEALBOT_ABOUT_AUTHORD                  = "Strife"
    HEALBOT_ABOUT_CATH                     = "Κατηγορια:"
    HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
    HEALBOT_ABOUT_CREDITH                  = "Credits:"
    HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, Moonlight Han Xing, CTShammy, Hermis, Ariá, Snaomi"  -- Anyone taking on translations (if required), feel free to add yourself here.
    HEALBOT_ABOUT_LOCALH                   = "Γλωσσες:"
    HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW"
    HEALBOT_ABOUT_FAQH                     = "Συχνες ερωτησεις"
    HEALBOT_ABOUT_FAQ_QUESTION             = "Ερωτηση"
    HEALBOT_ABOUT_FAQ_ANSWER               = "Απαντηση"

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

    HEALBOT_OPTIONS_SKINAUTHOR              = "Σχεδιαστης Skin"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Αποφυγη\nΜπλε Cursor"
    HEALBOT_PLAYER_OF_REALM                 = "του"
    
    HEALBOT_OPTIONS_LANG                    = "Γλωσσα"
    
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN - by Ydzzs)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK - by Strife)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS - by Strife)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR - by Kubik)"
    HEALBOT_OPTIONS_LANG_DEDE               = "German (deDE - by Snaomi)"
    HEALBOT_OPTIONS_LANG_GRGR               = "Greek (grGR - by Snaomi)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU - by Von)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR - translator required)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT - by Brezza)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR - by Aldetal)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russian (ruRU - translator required)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES - translator required)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW - translator required)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Αποτυχια φορτωσης addon για localization"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Λογος αποτυχιας:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Σημειωση στην τωρινη version"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Αποτυχια φορτωσης headbot"
    
    HEALBOT_OPTIONS_IN_A_GROUP              = "Μονο για Group ή Raid"
    
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
    HEALBOT_OPTIONS_OUTLINE                 = "Σχεδιαγραμμα"
    HEALBOT_OPTIONS_FRAME                   = "Frame"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. "Frames"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Επιλογες των Frames"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Ορισε την θεση του Tooltip"
    HEALBOT_OPTIONS_FRAME_TITLE             = "Τιτλος Frame"
    HEALBOT_OPTIONS_FRAME_TITLE_SHOW        = "Εμφανιση Τιτλου"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Κατευθηνση"
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Οριζοντια"
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Καθετα"
    HEALBOT_OPTIONS_FONT_OFFSET             = "Font Offset"
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Επιλογη Heal Groups"
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Εξερουνται τα Mount"
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "Χωρις να εξερουνται τα Mount"
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Εναλαγη εξερεσης Mount"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Αποκρυψη των mini boss frames";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Αποκρυψη των raid frames";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Ψευδωνυμο"
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Heal Groups"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Bar Colors"
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Eφαρμογη των ρυθμισεων σε ολα τα Frames"
    HEALBOT_WORDS_PROFILE                   = "Profile"
    HEALBOT_SHARE_SCREENSHOT                = "ScreenShot"
    HEALBOT_SHARE_INSTRUCTION               = "Πηγαινε στο website για περισσοτερες πληροφοριες "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "Εφαρμογη frame"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Περιλαμβανωμενων των target μου"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Περιλαμβανωμενων των tanks targets"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Επιλογες για Enemy";
    HEALBOT_OPTIONS_SHARE_OPT               = "Επιλογες για Share";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Share"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Enemy"
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "Φορτωση skin"
    HEALBOT_ENEMY_NO_TARGET                 = "Δεν υπαρχεει target"
    HEALBOT_OPTIONS_ENEMYBARS               = "Να υπαρχουν παντα enemy bars";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Harmful Spells"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Περιλαμβανωμενων των targets των My Targets"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Αριθμος Bosses"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Αποκρυψη των bars οταν ειμαι εκτος combat"
    HEALBOT_ENEMY_EXISTS_SHOW               = "Εμφανιση μονο σε combat".."\n".."εμφανιση οταν υπαρχει"
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Player targets"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Boss bars"
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Target: Εμφανιση μονο Friendly"
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "Focus: Εμφανιση Friendly"
    HEALBOT_OPTIONS_PROFILE                 = "Profile για".."\n".."Spells/Buffs/Cures"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Χαρακτηρας"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Κλαση"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Επιπεδο κινδυνου - Σε Μαχη ";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Επιπεδο κινδυνου - Εκτος μαχης";
    HEALBOT_OPTION_NUMENEMYS                = "Αριθμος Enemies"
    HEALBOT_WORD_AUTO                       = "Auto"
	HEALBOT_OPTIONS_ENABLEAUTOCOMBAT        = "Ενεργοποιηση HealBot autoCombat"
    HEALBOT_WORDS_REMOVETEMPCUSTOMNAME      = "Αφαιρεση προσωρινου ονοματος"
    HEALBOT_WORDS_REMOVEPERMCUSTOMNAME      = "Αφαιρεση μονιμου ονοματος"
    HEALBOT_WORDS_ADDTEMPCUSTOMNAME         = "Προσθηκη προσωρινου ονοματος"
    HEALBOT_WORDS_ADDPERMCUSTOMNAME         = "Προσθηκη μονιμου ονοματος"
    HEALBOT_OPTIONS_ENABLELIBUTF8           = "Ενεργοποιηση UTF8 library"
    HEALBOT_OPTIONS_SHOWDIRECTION           = "Εμφανιση βελους οταν ειναι Out of Range"
    HEALBOT_OPTIONS_SHOWDIRECTIONMOUSE      = "Μονο σε Mouse Over"
end

if (GetLocale() == "enUK") then
    HealBot_Lang_enUK()
else
    HealBot_Lang_enUS()
end