-- German translator required
------------
-- GERMAN --
------------
--
-- Ä = \195\132
-- Ö = \195\150
-- Ü = \195\156
-- ß = \195\159
-- ä = \195\164
-- ö = \195\182
-- ü = \195\188
--
-- (http://www.wowwiki.com/Localizing_an_addon)
-- If you want to translate for this region, please first confirm by email:  healbot@outlook.com
-- Include your registered username on the healbot website and the region you’re interested in taking responsibility for.
--


function HealBot_Lang_deDE()

-----------------
-- Translation --
-----------------=
-- Class
    HEALBOT_DRUID                           = "Druide";
    HEALBOT_HUNTER                          = "J\195\164ger";
    HEALBOT_MAGE                            = "Magier";
    HEALBOT_PALADIN                         = "Paladin";
    HEALBOT_PRIEST                          = "Priester";
    HEALBOT_ROGUE                           = "Schurke";
    HEALBOT_SHAMAN                          = "Schamane";
    HEALBOT_WARLOCK                         = "Hexenmeister";
    HEALBOT_WARRIOR                         = "Krieger";
    HEALBOT_DEATHKNIGHT                     = "Todesritter";
HEALBOT_MONK                            = "Monk";

    HEALBOT_DISEASE                         = "Krankheit";   
    HEALBOT_MAGIC                           = "Magie";
    HEALBOT_CURSE                           = "Fluch";   
    HEALBOT_POISON                          = "Gift";

    HB_TOOLTIP_OFFLINE                      ="Offline";
    HB_OFFLINE                              ="offline"; -- has gone offline msg
    HB_ONLINE                               ="online"; -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " geladen.";

    HEALBOT_ACTION_OPTIONS                  = "Optionen";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS                = "Defaults";
    HEALBOT_OPTIONS_CLOSE                   = "Schlie\195\159en";
HEALBOT_OPTIONS_HARDRESET               = "ReloadUI"
HEALBOT_OPTIONS_SOFTRESET               = "ResetHB"
    HEALBOT_OPTIONS_TAB_GENERAL             = "Allg.";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Spr\195\188che";  
    HEALBOT_OPTIONS_TAB_HEALING             = "Heilung";
    HEALBOT_OPTIONS_TAB_CDC                 = "Debuffs";  
    HEALBOT_OPTIONS_TAB_SKIN                = "Skin";   
    HEALBOT_OPTIONS_TAB_TIPS                = "Tips";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Buffs";

    HEALBOT_OPTIONS_BARALPHA                = "Balken Transparenz";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Ankomm.Heilung Transparenz";
HEALBOT_OPTIONS_BARALPHABACK            = "Background bar opacity";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Trasparenz wenn au\195\159er Reichweite";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Fenster fixieren";
    HEALBOT_OPTIONS_AUTOSHOW                = "Automatisch \195\182ffnen";
    HEALBOT_OPTIONS_PANELSOUNDS             = "Sound beim \195\150ffnen";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Kein Optionen-Knopf";
    HEALBOT_OPTIONS_PROTECTPVP              = "Vermeidung des PvP Flags";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Chat-Optionen";

HEALBOT_OPTIONS_FRAMESCALE              = "Frame Scale"
    HEALBOT_OPTIONS_SKINTEXT                = "Benutze Skin";  
HEALBOT_SKINS_STD                       = "Standard";
    HEALBOT_OPTIONS_SKINTEXTURE             = "Textur";  
    HEALBOT_OPTIONS_SKINHEIGHT              = "H\195\182he";  
    HEALBOT_OPTIONS_SKINWIDTH               = "Breite";   
    HEALBOT_OPTIONS_SKINNUMCOLS             = "Anzahl Spalten";  
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "Anzahl Gruppen pro Spalte";
    HEALBOT_OPTIONS_SKINBRSPACE             = "Reihenabstand";   
    HEALBOT_OPTIONS_SKINBCSPACE             = "Spaltenabstand";  
    HEALBOT_OPTIONS_EXTRASORT               = "Sort. Extrabalken nach";  
HEALBOT_SORTBY_NAME                     = "Name";  
    HEALBOT_SORTBY_CLASS                    = "Klasse";  
    HEALBOT_SORTBY_GROUP                    = "Gruppe";
    HEALBOT_SORTBY_MAXHEALTH                = "Max. Leben";
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Neuer Debuff"   
    HEALBOT_OPTIONS_DELSKIN                 = "L\195\182schen"; 
    HEALBOT_OPTIONS_NEWSKINTEXT             = "Neuer Skin";   
    HEALBOT_OPTIONS_SAVESKIN                = "Speichern";  
    HEALBOT_OPTIONS_SKINBARS                = "Balken-Optionen";  
    HEALBOT_SKIN_ENTEXT                      = "Aktiv";   
    HEALBOT_SKIN_DISTEXT                    = "Inaktiv";   
    HEALBOT_SKIN_DEBTEXT                    = "Debuff";   
    HEALBOT_SKIN_BACKTEXT                   = "Hintergrund"; 
    HEALBOT_SKIN_BORDERTEXT                 = "Rand"; 
    HEALBOT_OPTIONS_SKINFONT                = "Font"
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Schriftgr\195\182\195\159e";
HEALBOT_OPTIONS_SKINFOUTLINE            = "Font Outline"
    HEALBOT_OPTIONS_BARALPHADIS             = "Inaktiv-Transparenz";
    HEALBOT_OPTIONS_SHOWHEADERS             = "Zeige \195\156berschriften";

    HEALBOT_OPTIONS_ITEMS                   = "Gegenst\195\164nde";

    HEALBOT_OPTIONS_COMBOCLASS              = "Tastenkombinationen f\195\188r";
    HEALBOT_OPTIONS_CLICK                   = "Klick";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Strg";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Auch unverletzte Ziele heilen";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Keine Benachrichtigungen";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Nachricht an mich selbst";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Nachricht ans Ziel";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Nachricht an die Gruppe";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Nachricht an den Raid ";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "Channel";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Benachrichtigung nur bei Wiederbelebung";

    HEALBOT_OPTIONS_CDCBARS                 = "Balkenfarben";   
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "Lebensbalkenfarbe \195\164ndern";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "Aggrobalkenfarbe \195\164ndern";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Warnung bei Debuffs";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Zeige Debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Zeige Warnung bei Debuff";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Spiele Ton bei Debuff"; 
    HEALBOT_OPTIONS_SOUND                   = "Ton";  

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Heilungsbalken f\195\188r";
    HEALBOT_OPTIONS_SELFHEALS               = "Selbst";
    HEALBOT_OPTIONS_PETHEALS                = "Begleiter";
    HEALBOT_OPTIONS_GROUPHEALS              = "Gruppe";
    HEALBOT_OPTIONS_TANKHEALS               = "Maintanks";
    HEALBOT_OPTIONS_MAINASSIST              = "Hauptassistent";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Eigene Maintanks";
    HEALBOT_OPTIONS_TARGETHEALS             = "Ziele";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raid";
    HEALBOT_OPTIONS_ALERTLEVEL              = "Alarmstufe";
    HEALBOT_OPTIONS_EMERGFILTER             = "Notfall-Optionen f\195\188r";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Klassenauswahl nach";
    HEALBOT_OPTIONS_COMBOBUTTON             = "Maustaste";  
    HEALBOT_OPTIONS_BUTTONLEFT              = "Links";  
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Mitte";  
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Rechts"; 
    HEALBOT_OPTIONS_BUTTON4                 = "Taste4";  
    HEALBOT_OPTIONS_BUTTON5                 = "Taste5";  
    HEALBOT_OPTIONS_BUTTON6                 = "Taste6";
    HEALBOT_OPTIONS_BUTTON7                 = "Taste7";
    HEALBOT_OPTIONS_BUTTON8                 = "Taste8";
    HEALBOT_OPTIONS_BUTTON9                 = "Taste9";
    HEALBOT_OPTIONS_BUTTON10                = "Taste10";
    HEALBOT_OPTIONS_BUTTON11                = "Taste11";
    HEALBOT_OPTIONS_BUTTON12                = "Taste12";
    HEALBOT_OPTIONS_BUTTON13                = "Taste13";
    HEALBOT_OPTIONS_BUTTON14                = "Taste14";
    HEALBOT_OPTIONS_BUTTON15                = "Taste15";

    HEALBOT_CLASSES_ALL                     = "Alle Klassen";
    HEALBOT_CLASSES_MELEE                   = "Nahkampf";
    HEALBOT_CLASSES_RANGES                  = "Fernkampf";
    HEALBOT_CLASSES_HEALERS                 = "Heiler";
    HEALBOT_CLASSES_CUSTOM                  = "Pers\195\182nlich";

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Zeige Tooltips"; 
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Zeige detaillierte Spruchinfos";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Zeige Zauber-Cooldown";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Zeige Zielinfos";  
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Zeige empf. Sofortzauber";
    HEALBOT_TOOLTIP_POSDEFAULT              = "Standardposition";  
    HEALBOT_TOOLTIP_POSLEFT                 = "Links von Healbot";  
    HEALBOT_TOOLTIP_POSRIGHT                = "Rechts von Healbot";   
    HEALBOT_TOOLTIP_POSABOVE                = "\195\156ber Healbot";  
    HEALBOT_TOOLTIP_POSBELOW                = "Unter Healbot";   
    HEALBOT_TOOLTIP_POSCURSOR               = "Neben Mauszeiger";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Sofortzauber-Empfehlung";
    HEALBOT_TOOLTIP_NONE                    = "nicht verf\195\188gbar";
    HEALBOT_TOOLTIP_CORPSE                  = "Leichnam von "
    HEALBOT_TOOLTIP_CD                      = " (CD ";
    HEALBOT_TOOLTIP_SECS                    = "s)";
    HEALBOT_WORDS_SEC                       = "Sek";
    HEALBOT_WORDS_CAST                      = "Zauber";
    HEALBOT_WORDS_UNKNOWN                   = "Unbekannt";
    HEALBOT_WORDS_YES                       = "Ja";
    HEALBOT_WORDS_NO                        = "Nein";
HEALBOT_WORDS_THIN                      = "Thin";
HEALBOT_WORDS_THICK                     = "Thick";

    HEALBOT_WORDS_NONE                      = "Nichts";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_DISABLED_TARGET                 = "Ziel";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Zeige Klasse";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Zeige Leben auf Balken";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Zeige ankommende Heilung";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "getrennte ankommende Heilung";
    HEALBOT_OPTIONS_BARHEALTH1              = "Defizit";
    HEALBOT_OPTIONS_BARHEALTH2              = "prozentual";
    HEALBOT_OPTIONS_TIPTEXT                 = "Tooltip-Anzeige";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Tooltip-Position";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "mit Namen";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Text in Klassenfarben";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "in Gruppe";

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS             = "Setze Standard-Einstellungen";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Stelle alle Optionen auf Standard zur\195\188ck";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "Panel-Rechtsklick \195\182ffnet Optionen";

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "\195\156berschriften-Optionen"; 
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Icon-Optionen";
    HEALBOT_SKIN_HEADERBARCOL               = "Balkenfarbe"; 
    HEALBOT_SKIN_HEADERTEXTCOL              = "Textfarbe"; 
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Buff-Typ";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "auf Mitglieder"; 
    HEALBOT_OPTIONS_BUFFSTEXT3              = "Balkenfarbe"; 
    HEALBOT_OPTIONS_BUFF                    = "Buff "; 
    HEALBOT_OPTIONS_BUFFSELF                = "nur selbst"; 
    HEALBOT_OPTIONS_BUFFPARTY               = "f\195\188r Gruppe"; 
    HEALBOT_OPTIONS_BUFFRAID                = "f\195\188r Raid"; 
    HEALBOT_OPTIONS_MONITORBUFFS            = "\195\156berwachung fehlender Buffs"; 
    HEALBOT_OPTIONS_MONITORBUFFSC           = "auch im Kampf"; 
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "SmartCast au\195\159erhalb des Kampfs"; 
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Inclusive Spr\195\188che"; 
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Entferne Debuffs"; 
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Buffen"; 
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Heilen"; 
    HEALBOT_OPTIONS_BAR2SIZE                = "Manabalken-Gr\195\182\195\159e"; 
    HEALBOT_OPTIONS_SETSPELLS               = "Setze Zauber f\195\188r"; 
    HEALBOT_OPTIONS_ENABLEDBARS             = "Aktive Balken zu jeder Zeit"; 
    HEALBOT_OPTIONS_DISABLEDBARS            = "Inaktive Balken au\195\159erhalb des Kampfs"; 
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Debuff-\195\188berwachung"; 
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Zauber zum Entfernen des Debuffs"; 

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignoriere:"; 
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "Klassen"; 
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Verlangsamung"; 
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Kurzer Effekt"; 
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Kein negativer Effekt"; 
HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "When cure spell CoolDown > 1.5 secs (GCD)";
HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "When caster is known as friend";

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Reichweite, Aura und Aggro \195\156berpr\195\188fungs-Frequenz";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Keine Portraits";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Spieler- und Zielportrait ausblenden";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "HealBot deaktivieren";

    HEALBOT_ASSIST                          = "Helfen";
    HEALBOT_FOCUS                           = "Fokus";
    HEALBOT_MENU                            = "Men\195\188";
HEALBOT_MAINTANK                        = "Main tank";
HEALBOT_MAINASSIST                      = "Main assist";
HEALBOT_STOP                            = "Stop";
    HEALBOT_TELL                            = "Sagen";

HEALBOT_TITAN_SMARTCAST                 = "SmartCast";
    HEALBOT_TITAN_MONITORBUFFS              = "\195\156berwache Buffs";
    HEALBOT_TITAN_MONITORDEBUFFS            = "\195\156berwache Debuffs";
    HEALBOT_TITAN_SHOWBARS                  = "Zeige Balken f\195\188r";
    HEALBOT_TITAN_EXTRABARS                 = "Extra Balken";
    HEALBOT_BUTTON_TOOLTIP                  = "Linksklick f\195\188r Umschalten der Optionspanels\nRechtsklick (und halten) zum Verschieben";
    HEALBOT_TITAN_TOOLTIP                   = "Linksklick f\195\188r Umschalten der Optionspanels";
    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Zeige Minimap-Button";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Zeige HoT";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Zeige Schlachtzugssymbols";
    HEALBOT_OPTIONS_HOTONBAR                = "auf Balken";
    HEALBOT_OPTIONS_HOTOFFBAR               = "neben Balken";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "rechte Seite";
    HEALBOT_OPTIONS_HOTBARLEFT              = "linke Seite";

    HEALBOT_ZONE_AB                         = "Arathibecken";
    HEALBOT_ZONE_AV                         = "Alteractal";
    HEALBOT_ZONE_ES                         = "Auge des Sturms";
    HEALBOT_ZONE_IC                         = "Insel der Eroberung";
    HEALBOT_ZONE_SA                         = "Strand der Uralten";

    HEALBOT_OPTION_AGGROTRACK               = "Aggro aufsp\195\188ren"; 
    HEALBOT_OPTION_AGGROBAR                 = "Aufblitzen"; 
    HEALBOT_OPTION_AGGROTXT                 = ">> Zeige Text <<"; 
HEALBOT_OPTION_AGGROIND                 = "Indicator"
    HEALBOT_OPTION_BARUPDFREQ               = "Balken-Aktualisierungsfrequenz";
    HEALBOT_OPTION_USEFLUIDBARS             = "'flie\195\159ende' Balken";
    HEALBOT_OPTION_CPUPROFILE               = "CPU-Profiler verwenden (Addons CPU usage Info)"
    HEALBOT_OPTIONS_RELOADUIMSG             = "Diese Option ben\195\182tigt einen UI Reload, jetzt neu laden?"

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE						= "PvE"
    HEALBOT_OPTIONS_ANCHOR                  = "Rahmen Anker"
    HEALBOT_OPTIONS_BARSANCHOR              = "Balken Anker"
    HEALBOT_OPTIONS_TOPLEFT                 = "Oben Links"
    HEALBOT_OPTIONS_BOTTOMLEFT              = "Unten Links"
    HEALBOT_OPTIONS_TOPRIGHT                = "Oben Rechts"
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Unten Rechts"
    HEALBOT_OPTIONS_TOP                     = "Oben"
    HEALBOT_OPTIONS_BOTTOM                  = "Unten"

HEALBOT_PANEL_BLACKLIST                 = "BlackList"

    HEALBOT_WORDS_REMOVEFROM                = "Entferne von";
    HEALBOT_WORDS_ADDTO                     = "Hinzuf\195\188gen";
    HEALBOT_WORDS_INCLUDE                   = "f\195\188r";

    HEALBOT_OPTIONS_TTALPHA                 = "Transparenz"
    HEALBOT_TOOLTIP_TARGETBAR               = "Ziel-Balken"
    HEALBOT_OPTIONS_MYTARGET                = "meine Ziele"

    HEALBOT_DISCONNECTED_TEXT               = "<DC>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Zeige meine Buffs";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "St\195\164ndig updaten";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Zeige Buffs, bevor sie auslaufen";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Kurze Buffs"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Lange Buffs"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Nachricht"
    HEALBOT_WORDS_YOU                       = "dir/dich";
    HEALBOT_NOTIFYOTHERMSG                  = "Wirke #s auf #n";

HEALBOT_OPTIONS_HOTPOSITION             = "Icon position";
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Zeige Icontext";
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Z\195\164hler";
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Dauer";
    HEALBOT_OPTIONS_ICONSCALE               = "Icon Ma\195\159stab"
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Icon Text Ma\195\159stab"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Gr\195\182\195\159e des Aggrobalkens";
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Zweifache Textzeilen";
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Text-Ausrichtung";
    HEALBOT_VEHICLE                         = "Fahrzeug"
HEALBOT_WORDS_ERROR                     = "Error"
    HEALBOT_SPELL_NOT_FOUND                 = "Zauber nicht gefunden"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Kein Tooltipp im Kampf"
    HEALBOT_OPTIONS_ENABLELIBQH             = "libFastHealth einschalten";

    HEALBOT_OPTIONS_BUFFNAMED               = "Eingabe der Spielernamen f\195\188r\n\n"
    HEALBOT_WORD_ALWAYS                     = "Immer";
    HEALBOT_WORD_SOLO                       = "Solo";
    HEALBOT_WORD_NEVER                      = "Nie";
    HEALBOT_SHOW_CLASS_AS_ICON              = "als Icon";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "als Text";
HEALBOT_SHOW_ROLE                       = "show role when set";

    HEALBOT_SHOW_INCHEALS                   = "Zeige ankommende Heilung";

HEALBOT_HELP={  [1] = "[HealBot] /hb h -- zeige Hilfe (Diese Liste)",
                [2] = "[HealBot] /hb o -- Optionen umschalten",
   [3] = "[HealBot] /hb ri -- Reset HealBot",
                [4] = "[HealBot] /hb t -- zwischen Healbot aktiviert/deaktiviert umschalten",
                [5] = "[HealBot] /hb bt -- zwischen Buff Monitor aktiviert/deaktiviert umschalten",
                [6] = "[HealBot] /hb dt -- zwischen Debuff Monitor aktiviert/deaktiviert umschalten",
                [7] = "[HealBot] /hb skin <skinName> -- wechselt Skins",
                [8] = "[HealBot] /hb ui -- UI neu laden",
   [9] = "[HealBot] /hb hs -- Display additional slash commands",
              }

HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- Optionen auf Standard zur\195\188cksetzen",
    [2] = "[HealBot] /hb aggro 2 <n> -- Set aggro level 2 on threat percentage <n>",
    [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                [4] = "[HealBot] /hb tr <Role> -- Setze h\195\182chste Rollenpriorit\195\164t f\195\188r Untersortierung nach Rolle. G\195\188ltige Rollen sind 'TANK', 'HEALER' oder 'DPS'",
                [5] = "[HealBot] /hb use10 -- Benutze automatisch Ingenieurskunst Slot 10",
                [6] = "[HealBot] /hb pcs <n> -- Anpassen der Gr\195\182\195\159e der Heilige Kraft Ladungsanzeige um <n>, Standardwert ist 7 ",
                [7] = "[HealBot] /hb spt -- zwischen Eigenen Begleiter aktiviert/deaktiviert umschalten",
                [8] = "[HealBot] /hb ws -- Umschalten zwischen Verstecken/Zeigen des Geschw\195\164chte Seele Icons anstatt MW:S mit einem -",
   [9] = "[HealBot] /hb rld <n> -- In seconds, how long the players name stays green after a res",
   [10] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
   [11] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
              }
              
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Mouseover hervorheben"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Ziel hervorheben"
    HEALBOT_OPTIONS_TESTBARS                = "Test Balken"
    HEALBOT_OPTION_NUMBARS                  = "Anzahl Balken"
    HEALBOT_OPTION_NUMTANKS                 = "Anzahl Tanks"
    HEALBOT_OPTION_NUMMYTARGETS             = "Anzahl meine Ziele"
    HEALBOT_OPTION_NUMPETS                  = "Anzahl Begleiter"
    HEALBOT_WORD_TEST                       = "Test";
    HEALBOT_WORD_OFF                        = "Aus";
    HEALBOT_WORD_ON                         = "An";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Schutz"
    HEALBOT_OPTIONS_TAB_CHAT                = "Chat"
    HEALBOT_OPTIONS_TAB_HEADERS             = "\195\156berschriften"
    HEALBOT_OPTIONS_TAB_BARS                = "Balken"
    HEALBOT_OPTIONS_TAB_ICONS               = "Icons"
    HEALBOT_OPTIONS_TAB_WARNING             = "Warnung"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Standardskin f\195\188r"
    HEALBOT_OPTIONS_INCHEAL                 = "Ankommende Heilungen"
HEALBOT_WORD_ARENA                      = "Arena"
    HEALBOT_WORD_BATTLEGROUND               = "Schlachtfeld"
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Text Optionen"
    HEALBOT_WORD_PARTY                      = "Gruppe"
        HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto Ziel"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Schmuck"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Benutze Gruppen pro Spalte"

    HEALBOT_OPTIONS_MAINSORT                = "Hauptsortierung"
    HEALBOT_OPTIONS_SUBSORT                 = "Untersortierung"
    HEALBOT_OPTIONS_SUBSORTINC              = "Ebenfalls sortieren"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Wirke beim"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "dr\195\188cken"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "loslassen"

    HEALBOT_INFO_ADDONCPUUSAGE              = "== Addon CPU Nutzung in Sek. =="
    HEALBOT_INFO_ADDONCOMMUSAGE             = "== Addon Comms Nutzung =="
    HEALBOT_WORD_HEALER                     = "Heiler"
HEALBOT_WORD_DAMAGER                    = "Damager"
HEALBOT_WORD_TANK                       = "Tank"
HEALBOT_WORD_LEADER                     = "Leader"
HEALBOT_WORD_VERSION                    = "Version"
HEALBOT_WORD_CLIENT                     = "Client"
HEALBOT_WORD_ADDON                      = "Addon"
    HEALBOT_INFO_CPUSECS                    = "CPU Sek."
    HEALBOT_INFO_MEMORYKB                   = "Speicher KB"
    HEALBOT_INFO_COMMS                      = "Komm. KB"

    HEALBOT_WORD_STAR                       = "Stern"
    HEALBOT_WORD_CIRCLE                     = "Kreis"
    HEALBOT_WORD_DIAMOND                    = "Diamant"
    HEALBOT_WORD_TRIANGLE                   = "Dreieck"
    HEALBOT_WORD_MOON                       = "Mond"
    HEALBOT_WORD_SQUARE                     = "Viereck"
    HEALBOT_WORD_CROSS                      = "Kreuz"
    HEALBOT_WORD_SKULL                      = "Totenkopf"

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Akzeptiere [HealBot] Skin: "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " von "
    HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Teile mit"

    HEALBOT_CHAT_ADDONID                    = "[HealBot]  "
    HEALBOT_CHAT_NEWVERSION1                = "Eine neuere Version ist unter"
    HEALBOT_CHAT_NEWVERSION2                = HEALBOT_ABOUT_URL.." verf\195\188gbar"
    HEALBOT_CHAT_SHARESKINERR1              = " Skin zum Teilen nicht gefunden"
    HEALBOT_CHAT_SHARESKINERR3              = " nicht gefunden zum Skin Teilen"
    HEALBOT_CHAT_SHARESKINACPT              = "Geteiltes Skin akzeptiert von "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Skins auf Standard gesetzt"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Pers\195\182nliche Debuffs zur\195\188ckgesetzt"
    HEALBOT_CHAT_CHANGESKINERR1             = "Unbekanntes skin: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2             = "G\195\188ltige skins:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Aktuelle Spr\195\188che f\195\188r in alle Skillungen \195\188bernommen"
    HEALBOT_CHAT_UNKNOWNCMD                 = "Unbekanntes Kommandozeilenbefehl: /hb "
    HEALBOT_CHAT_ENABLED                    = "Status jetzt aktiviert"
    HEALBOT_CHAT_DISABLED                   = "Status jetzt deaktiviert"
    HEALBOT_CHAT_SOFTRELOAD                 = "Healbot Reload angefragt"
    HEALBOT_CHAT_HARDRELOAD                 = "UI Reload angefragt"
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "Spr\195\188che wurden zur\195\188ckgesetzt"
    HEALBOT_CHAT_CONFIRMCURESRESET          = "Heilung wurde zur\195\188ckgesetzt"
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Buffs wurde zur\195\188ckgesetzt"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Es ist nicht m\195\182glich alle Skin-Einstellungen zu empfangen - evtl. fehlen SharedMedia-Daten."
    HEALBOT_CHAT_MACROSOUNDON               = "Sound wird nicht unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Sound wird unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
    HEALBOT_CHAT_MACROERRORON               = "Fehler werden nicht unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
    HEALBOT_CHAT_MACROERROROFF              = "Fehler werden unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
    HEALBOT_CHAT_ACCEPTSKINON               = "Teile Skin - Zeige Akzeptiere-Skin-Popup wenn jemand ein Skin mit dir teilen m\195\182chte"
    HEALBOT_CHAT_ACCEPTSKINOFF              = "Teile Skin - Skin Teilen von allen immer ignorieren"
    HEALBOT_CHAT_USE10ON                    = "Auto Schmuck - Use10 ist eingeschaltet - Damit use10 funktioniert muss ein Auto Schmuck aktiviert sein"
    HEALBOT_CHAT_USE10OFF                   = "Auto Schmuck - Use10 ist ausgeschaltet"
    HEALBOT_CHAT_SKINREC                    = " Skin erhalten von " 

    HEALBOT_OPTIONS_SELFCASTS               = "Nur eigene Zauber"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Zeige Icon"
    HEALBOT_OPTIONS_ALLSPELLS               = "Alle Spr\195\188che"
    HEALBOT_OPTIONS_DOUBLEROW               = "zweizeilig"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "unter Balken"
    HEALBOT_OPTIONS_OTHERSPELLS             = "andere Spr\195\188che"
    HEALBOT_WORD_MACROS                     = "Makros"
    HEALBOT_WORD_SELECT                     = "Ausw\195\164hlen"
    HEALBOT_OPTIONS_QUESTION                = "?"
    HEALBOT_WORD_CANCEL                     = "Abbrechen"
    HEALBOT_WORD_COMMANDS                   = "Kommandos"
    HEALBOT_OPTIONS_BARHEALTH3              = "als Gesundheit";
    HEALBOT_SORTBY_ROLE                     = "Rolle"
    HEALBOT_WORD_DPS                        = "DPS"
    HEALBOT_CHAT_TOPROLEERR                 = " Rolle in diesem Zusammenhang nicht g\195\188ltig - benutze 'TANK', 'DPS' oder 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE                 = "H\195\188chste obere Rolle ist jetzt "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Spieler wird in Untersortierung als erstes gesetzt"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Spieler wird in Untersortierung normal gesetzt"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Zeige Ready Check";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Selbst zuerst"
HEALBOT_WORD_FILTER                     = "Filter"
    HEALBOT_OPTION_AGGROPCTBAR              = "Bew. Balken"
    HEALBOT_OPTION_AGGROPCTTXT              = "Zeige Text"
    HEALBOT_OPTION_AGGROPCTTRACK            = "Prozentual verfolgen" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - hat hohe Bedrohung und tankt nichts"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - unsicher ob tankt, nicht die h\195\182chste Bedrohung am Gegner"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - tankt sicher mindestens einen Gegner"
    HEALBOT_OPTIONS_AGGROALERT              = "Bar Alarm Level"
HEALBOT_OPTIONS_AGGROINDALERT           = "Indicator alert level"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Zeige aktiv verfolgte HoT Details"
HEALBOT_WORDS_MIN                       = "min"
HEALBOT_WORDS_MAX                       = "max"
    HEALBOT_CHAT_SELFPETSON                 = "Eigenen Begleiter anschalten"
    HEALBOT_CHAT_SELFPETSOFF                = "Eigenen Begleiter ausschalten"
    HEALBOT_WORD_PRIORITY                   = "Priorit\195\164t"
    HEALBOT_VISIBLE_RANGE                   = "Innerhalb 100 Metern"
    HEALBOT_SPELL_RANGE                     = "In Zauberreichweite"
HEALBOT_WORD_RESET                      = "Reset"
    HEALBOT_HBMENU                          = "HBmenu"
    HEALBOT_ACTION_HBFOCUS                  = "Linksklick um Ziel als\nFokus zu setzen"
    HEALBOT_WORD_CLEAR                      = "L\195\182schen"
    HEALBOT_WORD_SET                        = "Setze"
    HEALBOT_WORD_HBFOCUS                    = "HealBot Fokus"
    HEALBOT_WORD_OUTSIDE                    = "Au\195\159erhalb"
    HEALBOT_WORD_ALLZONE                    = "Alle Zonen"
    HEALBOT_OPTIONS_TAB_ALERT               = "Alarm"
    HEALBOT_OPTIONS_TAB_SORT                = "Sortieren"
HEALBOT_OPTIONS_TAB_HIDE                = "Hide"
HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
HEALBOT_OPTIONS_TAB_ICONTEXT            = "Icon Text"
    HEALBOT_OPTIONS_TAB_TEXT                = "Balken Text"
    HEALBOT_OPTIONS_AGGRO3COL               = "Tankt\nsicher"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Aufblitz-Frequenz"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Aufblitz-Durchsichtigkeit"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Zeige Dauer ab"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Dauer Warnung ab"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Reset pers\195\182nliche Debuffs"
HEALBOT_CMD_RESETSKINS                  = "Reset skins"
    HEALBOT_CMD_CLEARBLACKLIST              = "L\195\182sche BlackList"
    HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Umschalten Akzeptieren von Skins Anderer"
HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Toggle Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Now Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "No longer Dislike Mount"
    HEALBOT_CMD_COPYSPELLS                  = "\195\156bernehme aktuelle Spr\195\188che f\195\188r alle Skillungen"
    HEALBOT_CMD_RESETSPELLS                 = "Reset Spr\195\188che"
    HEALBOT_CMD_RESETCURES                  = "Reset Heilungen"
    HEALBOT_CMD_RESETBUFFS                  = "Reset Buffs"
    HEALBOT_CMD_RESETBARS                   = "Reset Balken Position"
    HEALBOT_CMD_SUPPRESSSOUND               = "Umschalten der Soundunterdr\195\188ckung, wenn Auto Schmuck benutzt wird"
    HEALBOT_CMD_SUPPRESSERRORS              = "Umschalten der Fehlerunterdr\195\188ckung, wenn Auto Schmuck benutzt wird"
    HEALBOT_OPTIONS_COMMANDS                = "HealBot Kommandos"
    HEALBOT_WORD_RUN                        = "Ausf\195\188hren"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Aktiviere Men\195\188 auf Mausrad"
HEALBOT_OPTIONS_MOUSEUP                 = "Wheel up"
HEALBOT_OPTIONS_MOUSEDOWN               = "Wheel down"
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "L\195\182sche pers\195\182nliche Debuffs mit Priorit\195\164t 10"
    HEALBOT_ACCEPTSKINS                     = "Akzeptiere Skins von anderen"
    HEALBOT_SUPPRESSSOUND                   = "Auto Schmuck: Unterdr\195\188cke Sound"
    HEALBOT_SUPPRESSERROR                   = "Auto Schmuck: Unterdr\195\188cke Fehler"
HEALBOT_OPTIONS_CRASHPROT               = "Crash Protection"
    HEALBOT_CP_MACRO_LEN                    = "Makro Name muss zwischen 1 und 14 Zeichen lang sein"
    HEALBOT_CP_MACRO_BASE                   = "Grund-Makro Name"
    HEALBOT_CP_MACRO_SAVE                   = "Zuletzt gespeichert um: "
    HEALBOT_CP_STARTTIME                    = "Schutzdauer beim Einloggen"
    HEALBOT_WORD_RESERVED                   = "Reserviert"
HEALBOT_OPTIONS_COMBATPROT              = "Combat Protection"
    HEALBOT_COMBATPROT_PARTYNO              = "Balken f\195\188r Gruppe reserviert"
    HEALBOT_COMBATPROT_RAIDNO               = "Balken f\195\188r Raid reserviert"

    HEALBOT_WORD_HEALTH                     = "Gesundheit"
    HEALBOT_OPTIONS_DONT_SHOW               = "nicht zeigen"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Gleich wie Gesundheit (jetzige Gesundheit)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Gleich wie Gesundheit (zuk\195\188nftige Gesundheit)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "zuk\195\188nftige Gesundheit"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Gesundheitsbalken Farbe";
HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Background bar";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Ankomm. Heilung Farbe";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Ziel: Immer anzeigen"
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Fokus: Immer anzeigen"
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: Groups of five"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Benutze Spiel Tooltip"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Zeige Kraft Z\195\164hler"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Zeige Heilige Kraft"
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

HEALBOT_CUSTOM_CATEGORY                 = "Kategorie"
HEALBOT_CUSTOM_CAT_CUSTOM               = "Pers\195\182nlich"
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
HEALBOT_ABOUT_CATH                     = "Category:"
HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
HEALBOT_ABOUT_CREDITH                  = "Credits:"
HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, CT, Moonlight Han Xing"  -- Anyone taking on translations (if required), feel free to add yourself here.
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
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Frame Title"
    HEALBOT_OPTIONS_FRAME_ALIAS_SHOW        = "Show Title"
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
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Bar Colors";
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Apply current tab settings to all Frames"
    HEALBOT_WORDS_PROFILE                   = "Profile"
    HEALBOT_SHARE_SCREENSHOT                = "ScreenShot taken"
    HEALBOT_SHARE_INSTRUCTION               = "Go to the website for instrunctions on sharing with "..HEALBOT_ABOUT_URL
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
end
