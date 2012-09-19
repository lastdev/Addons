------------
-- GERMAN --
------------

-- Ä = \195\132
-- Ö = \195\150
-- Ü = \195\156
-- ß = \195\159
-- ä = \195\164
-- ö = \195\182
-- ü = \195\188


if (GetLocale() == "deDE") then

-------------------
-- Compatibility --
-------------------

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

HEALBOT_DISEASE                         = "Krankheit";   
HEALBOT_MAGIC                           = "Magie";
HEALBOT_CURSE                           = "Fluch";   
HEALBOT_POISON                          = "Gift";
HEALBOT_DISEASE_en                      = "Disease";  -- Do NOT localize this value.
HEALBOT_MAGIC_en                        = "Magic";  -- Do NOT localize this value.
HEALBOT_CURSE_en                        = "Curse";  -- Do NOT localize this value.
HEALBOT_POISON_en                       = "Poison";  -- Do NOT localize this value.
HEALBOT_CUSTOM_en                       = "Custom";  -- Do NOT localize this value. 

-- Debuffs
HEALBOT_DEBUFF_ANCIENT_HYSTERIA         = "Uralte Hysterie";
HEALBOT_DEBUFF_IGNITE_MANA              = "Mana entz\195\188nden";
HEALBOT_DEBUFF_TAINTED_MIND             = "Besudelte Gedanken";
HEALBOT_DEBUFF_VIPER_STING              = "Vipernbiss";
HEALBOT_DEBUFF_SILENCE                  = "Stille";
HEALBOT_DEBUFF_MAGMA_SHACKLES           = "Magmafesseln";
HEALBOT_DEBUFF_FROSTBOLT                = "Frostblitz";
HEALBOT_DEBUFF_HUNTERS_MARK             = "Mal des J\195\164gers";
HEALBOT_DEBUFF_SLOW                     = "Verlangsamen";
HEALBOT_DEBUFF_ARCANE_BLAST             = "Arkanschlag";
HEALBOT_DEBUFF_IMPOTENCE                = "Fluch der Machtlosigkeit";
HEALBOT_DEBUFF_DECAYED_STR              = "Verfallene St\195\164rke";
HEALBOT_DEBUFF_DECAYED_INT              = "Verfallene Intelligenz";
HEALBOT_DEBUFF_CRIPPLE                  = "Verkr\195\188ppeln";
HEALBOT_DEBUFF_CHILLED                  = "K\195\164lte";
HEALBOT_DEBUFF_CONEOFCOLD               = "K\195\164ltekegel";
HEALBOT_DEBUFF_CONCUSSIVESHOT           = "Ersch\195\188tternder Schuss";
HEALBOT_DEBUFF_THUNDERCLAP              = "Donnerknall";         
HEALBOT_DEBUFF_HOWLINGSCREECH           = "Heulender Schrei";
HEALBOT_DEBUFF_DAZED                    = "Benommen";
HEALBOT_DEBUFF_UNSTABLE_AFFL            = "Instabiles Gebrechen";
HEALBOT_DEBUFF_DREAMLESS_SLEEP          = "Traumloser Schlaf";
HEALBOT_DEBUFF_GREATER_DREAMLESS        = "Gro\195\159er traumloser Schlaf";
HEALBOT_DEBUFF_MAJOR_DREAMLESS          = "\195\156berragender traumloser Schlaf";
HEALBOT_DEBUFF_FROST_SHOCK              = "Frostschock";

HB_TOOLTIP_MANA                         = "^(%d+) Mana$";
HB_TOOLTIP_INSTANT_CAST                 = "Spontanzauber";
HB_TOOLTIP_CAST_TIME                    = "(%d+.?%d*) Sek";
HB_TOOLTIP_CHANNELED                    = "Abgebrochen"; 
HB_TOOLTIP_OFFLINE                      ="Offline";
HB_OFFLINE                              ="offline"; -- has gone offline msg
HB_ONLINE                               ="online"; -- has come online msg

-----------------
-- Translation --
-----------------

HEALBOT_ADDON                           = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED                          = " geladen.";

HEALBOT_ACTION_OPTIONS                  = "Optionen";

HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS                = "Defaults";
HEALBOT_OPTIONS_CLOSE                   = "Schlie\195\159en";
HEALBOT_OPTIONS_HARDRESET               = "ReloadUI"
HEALBOT_OPTIONS_SOFTRESET               = "ResetHB"
HEALBOT_OPTIONS_INFO                    = "Info"
HEALBOT_OPTIONS_TAB_GENERAL             = "Allg.";
HEALBOT_OPTIONS_TAB_SPELLS              = "Spr\195\188che";  
HEALBOT_OPTIONS_TAB_HEALING             = "Heilung";
HEALBOT_OPTIONS_TAB_CDC                 = "Debuffs";  
HEALBOT_OPTIONS_TAB_SKIN                = "Skin";   
HEALBOT_OPTIONS_TAB_TIPS                = "Tips";
HEALBOT_OPTIONS_TAB_BUFFS               = "Buffs";

HEALBOT_OPTIONS_BARALPHA                = "Balken Transparenz";
HEALBOT_OPTIONS_BARALPHAINHEAL          = "Ankomm.Heilung Transparenz";
HEALBOT_OPTIONS_BARALPHAEOR             = "Trasparenz wenn au\195\159er Reichweite";
HEALBOT_OPTIONS_ACTIONLOCKED            = "Fenster fixieren";
HEALBOT_OPTIONS_AUTOSHOW                = "Automatisch \195\182ffnen";
HEALBOT_OPTIONS_PANELSOUNDS             = "Sound beim \195\150ffnen";
HEALBOT_OPTIONS_HIDEOPTIONS             = "Kein Optionen-Knopf";
HEALBOT_OPTIONS_PROTECTPVP              = "Vermeidung des PvP Flags";
HEALBOT_OPTIONS_HEAL_CHATOPT            = "Chat-Optionen";

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
HEALBOT_SKIN_ENTEXT                     = "Aktiv";   
HEALBOT_SKIN_DISTEXT                    = "Inaktiv";   
HEALBOT_SKIN_DEBTEXT                    = "Debuff";   
HEALBOT_SKIN_BACKTEXT                   = "Hintergrund"; 
HEALBOT_SKIN_BORDERTEXT                 = "Rand"; 
HEALBOT_OPTIONS_SKINFONT                = "Font"
HEALBOT_OPTIONS_SKINFHEIGHT             = "Schriftgr\195\182\195\159e";
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

HEALBOT_OPTIONS_RANGECHECKFREQ          = "Reichweite, Aura und Aggro \195\156berpr\195\188fungs-Frequenz";

HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Keine Portraits";
HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Spieler- und Zielportrait ausblenden";
HEALBOT_OPTIONS_DISABLEHEALBOT          = "HealBot deaktivieren";

HEALBOT_OPTIONS_CHECKEDTARGET           = "Checked";

HEALBOT_ASSIST                          = "Helfen";
HEALBOT_FOCUS                           = "Fokus";
HEALBOT_MENU                            = "Men\195\188";
HEALBOT_MAINTANK                        = "Main-Tank";
HEALBOT_MAINASSIST                      = "Main-Assist";
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
HEALBOT_ZONE_WG                         = "Kriegshymnenschlucht";

HEALBOT_OPTION_AGGROTRACK               = "Aggro aufsp\195\188ren"; 
HEALBOT_OPTION_AGGROBAR                 = "Aufblitzen"; 
HEALBOT_OPTION_AGGROTXT                 = ">> Zeige Text <<"; 
HEALBOT_OPTION_BARUPDFREQ               = "Balken-Aktualisierungsfrequenz";
HEALBOT_OPTION_USEFLUIDBARS             = "'flie\195\159ende' Balken";
HEALBOT_OPTION_CPUPROFILE               = "CPU-Profiler verwenden (Addons CPU usage Info)"
HEALBOT_OPTIONS_RELOADUIMSG             = "Diese Option ben\195\182tigt einen UI Reload, jetzt neu laden?"

HEALBOT_SELF_PVP                        = "selbst im PvP"
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

HEALBOT_BALANCE                         = "Gleichgewicht"
HEALBOT_FERAL                           = "Wilder Kampf"
HEALBOT_RESTORATION                     = "Wiederherstellung"
HEALBOT_SHAMAN_RESTORATION              = "Wiederherstellung"
HEALBOT_ARCANE                          = "Arkan"
HEALBOT_FIRE                            = "Feuer"
HEALBOT_FROST                           = "Frost"
HEALBOT_DISCIPLINE                      = "Disziplin"
HEALBOT_HOLY                            = "Heilig"
HEALBOT_SHADOW                          = "Schatten"
HEALBOT_ASSASSINATION                   = "Meucheln"
HEALBOT_COMBAT                          = "Kampf"
HEALBOT_SUBTLETY                        = "T\195\164uschung"
HEALBOT_ARMS                            = "Waffen"
HEALBOT_FURY                            = "Furor"
HEALBOT_PROTECTION                      = "Schutz"
HEALBOT_BEASTMASTERY                    = "Tierherrschaft"
HEALBOT_MARKSMANSHIP                    = "Treffsicherheit"
HEALBOT_SURVIVAL                        = "\195\156berleben"
HEALBOT_RETRIBUTION                     = "Vergeltung"
HEALBOT_ELEMENTAL                       = "Elementar"
HEALBOT_ENHANCEMENT                     = "Verst\195\164rkung"
HEALBOT_AFFLICTION                      = "Gebrechen"
HEALBOT_DEMONOLOGY                      = "D\195\164monologie"
HEALBOT_DESTRUCTION                     = "Destruction"
HEALBOT_BLOOD                           = "Blut"
HEALBOT_UNHOLY                          = "Unheilig"

HEALBOT_OPTIONS_VISIBLERANGE            = "Balken deaktivieren, wenn Entfernung > 100 Meter"
HEALBOT_OPTIONS_NOTIFY_HEAL_MSG         = "Nachricht beim Heilen"
HEALBOT_OPTIONS_NOTIFY_MSG              = "Nachricht"
HEALBOT_WORDS_YOU                       = "dir/dich";
HEALBOT_NOTIFYHEALMSG                   = "Wirke #s und heile #n um #h";
HEALBOT_NOTIFYOTHERMSG                  = "Wirke #s auf #n";

HEALBOT_OPTIONS_HOTPOSITION             = "Icon-Position";
HEALBOT_OPTIONS_HOTSHOWTEXT             = "Zeige Icontext";
HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Z\195\164hler";
HEALBOT_OPTIONS_HOTTEXTDURATION         = "Dauer";
HEALBOT_OPTIONS_ICONSCALE               = "Icon Ma\195\159stab"
HEALBOT_OPTIONS_ICONTEXTSCALE           = "Icon Text Ma\195\159stab"

HEALBOT_SKIN_FLUID                      = "Fluid";
HEALBOT_SKIN_VIVID                      = "Vivid";
HEALBOT_SKIN_LIGHT                      = "Light";
HEALBOT_SKIN_SQUARE                     = "Square";
HEALBOT_OPTIONS_AGGROBARSIZE            = "Gr\195\182\195\159e des Aggrobalkens";
HEALBOT_OPTIONS_TARGETBARMODE           = "Beschr\195\164nke Targetbalken auf vordefinierte Einstellungen"
HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Zweifache Textzeilen";
HEALBOT_OPTIONS_TEXTALIGNMENT           = "Text-Ausrichtung";
HEALBOT_OPTIONS_ENABLELIBQH             = "libQuickHealth einschalten";
HEALBOT_VEHICLE                         = "Fahrzeug"
HEALBOT_OPTIONS_UNIQUESPEC              = "Speichere individuelle Einstellungen f\195\188r jede Skillung"
HEALBOT_WORDS_ERROR                     = "Error"
HEALBOT_SPELL_NOT_FOUND                 = "Zauber nicht gefunden"
HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Kein Tooltipp im Kampf"

HEALBOT_OPTIONS_BUFFNAMED               = "Eingabe der Spielernamen f\195\188r\n\n"
HEALBOT_WORD_ALWAYS                     = "Immer";
HEALBOT_WORD_SOLO                       = "Solo";
HEALBOT_WORD_NEVER                      = "Nie";
HEALBOT_SHOW_CLASS_AS_ICON              = "als Icon";
HEALBOT_SHOW_CLASS_AS_TEXT              = "als Text";

HEALBOT_SHOW_INCHEALS                   = "Zeige ankommende Heilung";
HEALBOT_D_DURATION                      = "Direkte Dauer";
HEALBOT_H_DURATION                      = "HoT Dauer";
HEALBOT_C_DURATION                      = "Kanalisierte Dauer";

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- zeige Hilfe (Diese Liste)",
               [2] = "[HealBot] /hb o -- Optionen umschalten",
               [3] = "[HealBot] /hb d -- Optionen auf Standard zur\195\188cksetzen",
               [4] = "[HealBot] /hb ui -- UI neu laden",
               [5] = "[HealBot] /hb ri -- Reset HealBot",
               [6] = "[HealBot] /hb t -- zwischen Healbot aktiviert/deaktiviert umschalten",
               [7] = "[HealBot] /hb bt -- zwischen Buff Monitor aktiviert/deaktiviert umschalten",
               [8] = "[HealBot] /hb dt -- zwischen Debuff Monitor aktiviert/deaktiviert umschalten",
               [9] = "[HealBot] /hb skin <skinName> -- wechselt Skins",
               [10] = "[HealBot] /hb tr <Role> -- Setze h\195\182chste Rollenpriorit\195\164t f\195\188r Untersortierung nach Rolle. G\195\188ltige Rollen sind 'TANK', 'HEALER' oder 'DPS'",
               [11] = "[HealBot] /hb use10 -- Benutze automatisch Ingenieurskunst Slot 10",
               [12] = "[HealBot] /hb pcs <n> -- Anpassen der Gr\195\182\195\159e der Heilige Kraft Ladungsanzeige um <n>, Standardwert ist 7 ",
               [13] = "[HealBot] /hb info -- Zeige das Infofenster",
               [14] = "[HealBot] /hb spt -- zwischen Eigenen Begleiter aktiviert/deaktiviert umschalten",
               [15] = "[HealBot] /hb ws -- Umschalten zwischen Verstecken/Zeigen des Geschw\195\164chte Seele Icons anstatt MW:S mit einem -",
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

HEALBOT_INFO_INCHEALINFO                = "== Ankommende Heilung Info =="
HEALBOT_INFO_ADDONCPUUSAGE              = "== Addon CPU Nutzung in Sek. =="
HEALBOT_INFO_ADDONCOMMUSAGE             = "== Addon Comms Nutzung =="
HEALBOT_WORD_HEALER                     = "Heiler"
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
HEALBOT_CHAT_NEWVERSION2                = "http://healbot.alturl.com verf\195\188gbar"
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
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Es ist nicht m\195\182glich alle Skin-Einstellungen zu empfangen - evtl. fehlen SharedMedia-Daten. Links hierzu siehe HealBot/Docs/readme.html"
HEALBOT_CHAT_MACROSOUNDON               = "Sound wird nicht unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
HEALBOT_CHAT_MACROSOUNDOFF              = "Sound wird unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
HEALBOT_CHAT_MACROERRORON               = "Fehler werden nicht unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
HEALBOT_CHAT_MACROERROROFF              = "Fehler werden unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
HEALBOT_CHAT_TITANON                    = "Titan Panel - Updates an"
HEALBOT_CHAT_TITANOFF                   = "Titan Panel - Updates aus"
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
HEALBOT_OPTIONS_ALERTAGGROLEVEL0        = "0 - hat niedrige Bedrohung und tankt nichts"
HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - hat hohe Bedrohung und tankt nichts"
HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - unsicher ob tankt, nicht die h\195\182chste Bedrohung am Gegner"
HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - tankt sicher mindestens einen Gegner"
HEALBOT_OPTIONS_AGGROALERT              = "Aggro Alarm Level"
HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Zeige aktiv verfolgte HoT Details"
HEALBOT_WORDS_MIN                       = "min"
HEALBOT_WORDS_MAX                       = "max"
HEALBOT_WORDS_R                         = "R"
HEALBOT_WORDS_G                         = "G"
HEALBOT_WORDS_B                         = "B"
HEALBOT_CHAT_SELFPETSON                 = "Eigenen Begleiter anschalten"
HEALBOT_CHAT_SELFPETSOFF                = "Eigenen Begleiter ausschalten"
HEALBOT_WORD_PRIORITY                   = "Priorit\195\164t"
HEALBOT_VISIBLE_RANGE                   = "Innerhalb 100 Metern"
HEALBOT_SPELL_RANGE                     = "In Zauberreichweite"
HEALBOT_CUSTOM_CATEGORY                 = "Kategorie"
HEALBOT_CUSTOM_CAT_CUSTOM               = "Pers\195\182nlich"
HEALBOT_CUSTOM_CAT_CLASSIC              = "Classic"
HEALBOT_CUSTOM_CAT_TBC_OTHER            = "TBC - Sonstige"
HEALBOT_CUSTOM_CAT_TBC_BT               = "TBC - Der Schwarze Tempel"
HEALBOT_CUSTOM_CAT_TBC_SUNWELL          = "TBC - Sonnenbrunnenplateau"
HEALBOT_CUSTOM_CAT_LK_OTHER             = "WotLK - Sonstige"
HEALBOT_CUSTOM_CAT_LK_ULDUAR            = "WotLK - Ulduar"
HEALBOT_CUSTOM_CAT_LK_TOC               = "WotLK - Kolosseum der Kreuzfahrers"
HEALBOT_CUSTOM_CAT_LK_ICC_LOWER         = "WotLK - ICC Zitadelle"
HEALBOT_CUSTOM_CAT_LK_ICC_PLAGUEWORKS   = "WotLK - ICC Die Seuchenwerke"
HEALBOT_CUSTOM_CAT_LK_ICC_CRIMSON       = "WotLK - ICC Die Blutrote Halle"
HEALBOT_CUSTOM_CAT_LK_ICC_FROSTWING     = "WotLK - ICC Hallen der Frostschwingen"
HEALBOT_CUSTOM_CAT_LK_ICC_THRONE        = "WotLK - ICC Frostthron"
HEALBOT_CUSTOM_CAT_LK_RS_THRONE         = "WotLK - Das Rubinsanktum"
HEALBOT_CUSTOM_CAT_CATA_OTHER           = "Cata - Sonstige"
HEALBOT_CUSTOM_CAT_CATA_PARTY           = "Cata - Gruppe"
HEALBOT_CUSTOM_CAT_CATA_RAID            = "Cata - Schlachtzug"
HEALBOT_WORD_RESET                      = "Reset"
HEALBOT_HBMENU                          = "HBmenu"
HEALBOT_ACTION_HBFOCUS                  = "Linksklick um Ziel als\nFokus zu setzen"
HEALBOT_WORD_CLEAR                      = "L\195\182schen"
HEALBOT_WORD_SET                        = "Setze"
HEALBOT_WORD_HBFOCUS                    = "HealBot Fokus"
HEALBOT_WORD_OUTSIDE                    = "Au\195\159erhalb"
HEALBOT_WORD_ALLZONE                    = "Alle Zonen"
HEALBOT_WORD_OTHER                      = "Sonstige"
HEALBOT_OPTIONS_TAB_ALERT               = "Alarm"
HEALBOT_OPTIONS_TAB_SORT                = "Sortieren"
HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
HEALBOT_OPTIONS_TAB_ICONTEXT            = "Icon Text"
HEALBOT_OPTIONS_TAB_TEXT                = "Balken Text"
HEALBOT_OPTIONS_AGGROBARCOLS            = "Aggro Balken Farben";
HEALBOT_OPTIONS_AGGRO1COL               = "Hat hohe\nBedrohung"
HEALBOT_OPTIONS_AGGRO2COL               = "Unsicher \nob tankt"
HEALBOT_OPTIONS_AGGRO3COL               = "Tankt\nsicher"
HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Aufblitz-Frequenz"
HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Aufblitz-Durchsichtigkeit"
HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Zeige Dauer ab"
HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Dauer Warnung ab"
HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Reset pers\195\182nliche Debuffs"
HEALBOT_CMD_RESETSKINS                  = "Reset Skins"
HEALBOT_CMD_CLEARBLACKLIST              = "L\195\182sche BlackList"
HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Umschalten Akzeptieren von Skins Anderer"
HEALBOT_CMD_COPYSPELLS                  = "\195\156bernehme aktuelle Spr\195\188che f\195\188r alle Skillungen"
HEALBOT_CMD_RESETSPELLS                 = "Reset Spr\195\188che"
HEALBOT_CMD_RESETCURES                  = "Reset Heilungen"
HEALBOT_CMD_RESETBUFFS                  = "Reset Buffs"
HEALBOT_CMD_RESETBARS                   = "Reset Balken Position"
HEALBOT_CMD_TOGGLETITAN                 = "Umschalten Titan Updates"
HEALBOT_CMD_SUPPRESSSOUND               = "Umschalten der Soundunterdr\195\188ckung, wenn Auto Schmuck benutzt wird"
HEALBOT_CMD_SUPPRESSERRORS              = "Umschalten der Fehlerunterdr\195\188ckung, wenn Auto Schmuck benutzt wird"
HEALBOT_OPTIONS_COMMANDS                = "HealBot Kommandos"
HEALBOT_WORD_RUN                        = "Ausf\195\188hren"
HEALBOT_OPTIONS_MOUSEWHEEL              = "Aktiviere Men\195\188 auf Mausrad"
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
HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Ankomm. Heilung Farbe";
HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Ziel: Immer anzeigen"
HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Fokus: Immer anzeigen"
HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Benutze Spiel Tooltip"

HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Zeige Kraft Z\195\164hler"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Zeige Heilige Kraft"

end
