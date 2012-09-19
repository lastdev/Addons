-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------

if (GetLocale() == "deDE") then


-- Debuff types, in english in game!
--[[
SMARTDEBUFF_DISEASE = "Krankheit";
SMARTDEBUFF_MAGIC   = "Magie";
SMARTDEBUFF_POISON  = "Gift";
SMARTDEBUFF_CURSE   = "Fluch";
SMARTDEBUFF_CHARMED = "Verführung";
]]--


-- Creatures
SMARTDEBUFF_HUMANOID  = "Humanoid";
SMARTDEBUFF_DEMON     = "Dämon";
SMARTDEBUFF_BEAST     = "Wildtier";
SMARTDEBUFF_ELEMENTAL = "Elementar";
SMARTDEBUFF_IMP       = "Wichtel";
SMARTDEBUFF_FELHUNTER = "Teufelsjäger";
SMARTDEBUFF_DOOMGUARD = "Verdammniswache";

-- Classes
SMARTDEBUFF_CLASSES = { ["DRUID"] = "Druide", ["HUNTER"] = "Jäger", ["MAGE"] = "Magier", ["PALADIN"] = "Paladin", ["PRIEST"] = "Priester", ["ROGUE"] = "Schurke"
                      , ["SHAMAN"] = "Schamane", ["WARLOCK"] = "Hexer", ["WARRIOR"] = "Krieger", ["DEATHKNIGHT"] = "Todesritter", ["MONK"] = "Mönch", ["HPET"] = "Jäger Pet", ["WPET"] = "Hexer Pet"};

-- Bindings
BINDING_NAME_SMARTDEBUFF_BIND_OPTIONS = "Optionen";

SMARTDEBUFF_KEYS = {["L"]  = "Links",
                    ["R"]  = "Rechts",
                    ["M"]  = "Mitte",
                    ["SL"] = "Shift links",
                    ["SR"] = "Shift rechts",
                    ["SM"] = "Shift mitte",
                    ["AL"] = "Alt links",
                    ["AR"] = "Alt rechts",
                    ["AM"] = "Alt mitte",
                    ["CL"] = "Strg links",
                    ["CR"] = "Strg rechts",
                    ["CM"] = "Strg mitte"
                    };


-- Messages
SMARTDEBUFF_MSG_LOADED         = "geladen";
SMARTDEBUFF_MSG_SDB            = "SmartDebuff Optionen";

-- Frame text
SMARTDEBUFF_FT_MODES           = "Tasten/Modus";
SMARTDEBUFF_FT_MODENORMAL      = "Norm";
SMARTDEBUFF_FT_MODETARGET      = "Ziel";


-- Options frame text
SMARTDEBUFF_OFT                = "Zeige/verberge SmartDebuff Optionen";
SMARTDEBUFF_OFT_HUNTERPETS     = "Jäger Pets";
SMARTDEBUFF_OFT_WARLOCKPETS    = "Hexer Pets";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "Todesritter Pets";
SMARTDEBUFF_OFT_HP             = "HP";
SMARTDEBUFF_OFT_MANA           = "Mana";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "Invertiert";
SMARTDEBUFF_OFT_CLASSVIEW      = "Klassenansicht";
SMARTDEBUFF_OFT_CLASSCOLOR     = "Klassenfarben";
SMARTDEBUFF_OFT_SHOWLR         = "L / R / M";
SMARTDEBUFF_OFT_HEADERS        = "Titel";
SMARTDEBUFF_OFT_GROUPNR        = "Gruppen Nr.";
SMARTDEBUFF_OFT_SOUND          = "Warnton";
SMARTDEBUFF_OFT_TOOLTIP        = "Tooltip";
SMARTDEBUFF_OFT_TARGETMODE     = "Ziel-Modus";
SMARTDEBUFF_OFT_HEALRANGE      = "Heil-Reichweite";
SMARTDEBUFF_OFT_SHOWAGGRO      = "Aggro";
SMARTDEBUFF_OFT_VERTICAL       = "Vertikal anordnen";
SMARTDEBUFF_OFT_VERTICALUP     = "Unten -> Oben";
SMARTDEBUFF_OFT_HEADERROW      = "Titelleiste";
SMARTDEBUFF_OFT_BACKDROP       = "Hintergrund";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "Farbverlauf";
SMARTDEBUFF_OFT_INFOFRAME      = "Status-Fenster";
SMARTDEBUFF_OFT_AUTOHIDE       = "Auto. verbergen";
SMARTDEBUFF_OFT_COLUMNS        = "Spalten";
SMARTDEBUFF_OFT_INTERVAL       = "Interval";
SMARTDEBUFF_OFT_FONTSIZE       = "Schriftgrösse";
SMARTDEBUFF_OFT_WIDTH          = "Breite";
SMARTDEBUFF_OFT_HEIGHT         = "Höhe";
SMARTDEBUFF_OFT_BARHEIGHT      = "Balkenhöhe";
SMARTDEBUFF_OFT_OPACITYNORMAL  = "In Reichweite";
SMARTDEBUFF_OFT_OPACITYOOR     = "Ausser Reichweite";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "Debuff";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "Debuff Wächter";
SMARTDEBUFF_OFT_VEHICLE        = "Fahrzeuge";
SMARTDEBUFF_OFT_SHOWRAIDICON   = "Raidsymbole";
SMARTDEBUFF_OFT_SHOWSPELLICON  = "Cast Symbol";
SMARTDEBUFF_OFT_INFOROW        = "Info-Zeile";
SMARTDEBUFF_OFT_ROLE           = "Rolle";
SMARTDEBUFF_OFT_ADVANCHORS     = "Anker Setup";
SMARTDEBUFF_OFT_ICONSIZE       = "Symbolgrösse";
SMARTDEBUFF_OFT_COLORSETUP     = "Farbeinstellungen";
SMARTDEBUFF_OFT_SPACEX         = "Abstand X";
SMARTDEBUFF_OFT_SPACEY         = "Abstand Y";
SMARTDEBUFF_OFT_TESTMODE       = "Test Modus";
SMARTDEBUFF_OFT_STOPCAST       = "Stoppe Zauber";

SMARTDEBUFF_AOFT_SORTBYCLASS   = "Klassenanordnung";
SMARTDEBUFF_NRDT_TITLE         = "Unentfernbare Debuffs";
SMARTDEBUFF_SG_TITLE           = "Zauber-Wächter";
SMARTDEBUFF_S_TITLE            = "Debuff Warnton";


-- Tooltip text
SMARTDEBUFF_TT                 = "Shift-Links ziehen: Fenster verschieben\n|cff20d2ff- S Knopf -|r\nLinks Klick: Ordne nach Klassen\nShift-Links Klick: Klassen-Farben\nAlt-Links Klick: Zeige L/R\nRechts Klick: Hintergrund";
SMARTDEBUFF_TT_TARGETMODE      = "Im Ziel-Modus w\195\164hlt |cff20d2fflinks klick|r die Einheit aus und |cff20d2ffrechts klick|r zaubert den schnellsten Heilspruch.\n|cff20d2ffAlt-Links/Rechts klick|r wird zum Debuffen benutzt.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "Zeigt kritische Debuffs an,\nauch wenn sie nicht entfernt\nwerden k\195\182nnen.";
SMARTDEBUFF_TT_HP              = "Zeigt die aktuellen Lebenspunkte\nder Einheit an.";
SMARTDEBUFF_TT_MANA            = "Zeigt das aktuelle Mana\nder Einheit an.";
SMARTDEBUFF_TT_HPTEXT          = "Zeigt die aktuellen Lebens-\nund Manapunkte der Einheit\nals Text in Prozent an.";
SMARTDEBUFF_TT_INVERT          = "Stellt die Lebenspunkte und\ndas Mana invertiert dar.";
SMARTDEBUFF_TT_CLASSVIEW       = "Stellt die Kn\195\182pfe nach\nKlasse sortiert dar.";
SMARTDEBUFF_TT_CLASSCOLOR      = "Stellt die Kn\195\182pfe in der\njeweiligen Klassenfarbe dar.";
SMARTDEBUFF_TT_SHOWLR          = "Zeigt den zugeh\195\182rigen\nMausknopf (L/R/M)\nan, wenn jemand\neinen Debuff hat.";
SMARTDEBUFF_TT_HEADERS         = "Stellt den Klassennamen\nals Zeilentitel dar.";
SMARTDEBUFF_TT_GROUPNR         = "Blendet die Gruppennummer\nvor dem Spielernamen ein.";
SMARTDEBUFF_TT_SOUND           = "Spielt einen Ton ab, wenn\njemand einen Debuff bekommt.";
SMARTDEBUFF_TT_TOOLTIP         = "Zeigt Tooltip-Infos zum\njeweiligen Knopf an, nur\nausserhalb des Kampfes.";
SMARTDEBUFF_TT_HEALRANGE       = "Stellt einen roten Rahmen dar,\nwenn der Heil-Zauber ausser\nReichweite ist.";
SMARTDEBUFF_TT_SHOWAGGRO       = "Zeigt wer gerade\nAggro hat.";
SMARTDEBUFF_TT_VERTICAL        = "Stellt die Kn\195\182pfe vertikal\nangeordnet dar.";
SMARTDEBUFF_TT_VERTICALUP      = "Baut die Kn\195\182pfe vertikal\nvon unten nach oben auf.";
SMARTDEBUFF_TT_HEADERROW       = "Stellt die Titelzeile, inklusiv\nder Men\195\188-Kn\195\182pfe dar.";
SMARTDEBUFF_TT_BACKDROP        = "Blendet einen schwarzen\nHintergrund ein.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "Stellt die Kn\195\182pfe mit\neinem Farbverlauf dar.";
SMARTDEBUFF_TT_INFOFRAME       = "Blendet das Status-Fenster ein,\nnur in der Gruppe oder Raid.";
SMARTDEBUFF_TT_AUTOHIDE        = "Verbirgt die Kn\195\182pfe automatisch,\nwenn man nicht mehr im Kampf\nist und niemand einen Debuff hat.";
SMARTDEBUFF_TT_VEHICLE         = "Stellt zus\195\164tzlich das Fahrzeug der\nEinheit als eigener Knopf dar.";
SMARTDEBUFF_TT_SHOWRAIDICON    = "Stellt das Raidsymbol\nder Einheit dar.";
SMARTDEBUFF_TT_SHOWSPELLICON   = "Stellt das Cast-Symbol\nauf der Einheit dar.";
SMARTDEBUFF_TT_INFOROW         = "Zeigt in kurzform eine Infozeile #\nSpieler/Tot/AFK/Offline\nHP/Mana\nReady check Status\n(Nur im Raid)";
SMARTDEBUFF_TT_ROLE            = "Stellt die Kn\195\182pfe nach\nRolle sortiert dar.";
SMARTDEBUFF_TT_ADVANCHORS      = "Stellt dar und benutzt das\nerweiterte Anker-Setup\nf\195\188r das Debuff-Fenster.";
SMARTDEBUFF_TT_STOPCAST        = "Stoppt sofort den aktuellen\nZauber, um den definierten\nZauber benutzen zu k\195\182nnen.\n(Nur Debuff-Zauber)";

--SMARTDEBUFF_TT_COLUMNS         = "Columns";
--SMARTDEBUFF_TT_INTERVAL        = "Interval";
--SMARTDEBUFF_TT_FONTSIZE        = "Font size";
--SMARTDEBUFF_TT_WIDTH           = "Width";
--SMARTDEBUFF_TT_HEIGHT          = "Height";
--SMARTDEBUFF_TT_BARHEIGHT       = "Bar height";
--SMARTDEBUFF_TT_OPACITYNORMAL   = "Opacity in range";
--SMARTDEBUFF_TT_OPACITYOOR      = "Opacity out of range";
--SMARTDEBUFF_TT_OPACITYDEBUFF   = "Opacity debuff";

-- Tooltip text key bindings
SMARTDEBUFF_TT_DROP            = "Drop";
SMARTDEBUFF_TT_DROPINFO        = "F\195\188ge einen Zauber/Item/Makro\naus dem Buch/Inventar ein.\n|cff00ff00Mausklick\nLinks: Ziel-Funktion setzen\nShift-Links: Men\195\188-Funktion setzen";
SMARTDEBUFF_TT_DROPSPELL       = "Zauber klick:\nLinks Aufnehmen\nShift-Links Kopieren\nRechts: Entfernen";
SMARTDEBUFF_TT_DROPITEM        = "Item klick\nLinks: Aufnehmen\nShift-Links: Kopieren\nRechts: Entfernen";
SMARTDEBUFF_TT_DROPMACRO       = "Makro klick\nLinks: Aufnehmen\nShift-Links: Kopieren\nRechts: Entfernen";
SMARTDEBUFF_TT_TARGET          = "Ziel";
SMARTDEBUFF_TT_TARGETINFO      = "Selektiert die gew\195\164hlte Einheit\nund nimmt diese ins Ziel.";
SMARTDEBUFF_TT_DROPTARGET      = "Mausklick\nRechts: Entfernen";
SMARTDEBUFF_TT_DROPACTION      = "Pet-Aktion:\nEntfernen nicht m\195\182glich!";
SMARTDEBUFF_TT_MENU            = "Menu";
SMARTDEBUFF_TT_MENUINFO        = "\195\150ffnet das Optionenmen\195\188\nder Einheit.";
SMARTDEBUFF_TT_DROPMENU        = "Mausklick\nRechts: Entfernen";

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\nLinks Klick: Optionen Men\195\188\nShift-Links Klick: An/Aus";
SMARTDEBUFF_BROKER_TT          = "\nLinks Klick: Optionen Men\195\188\nRechts Klick: An/Aus";

end
