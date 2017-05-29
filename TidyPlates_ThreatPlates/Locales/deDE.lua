﻿local L = LibStub("AceLocale-3.0"):NewLocale("TidyPlatesThreat", "deDE", false, true)
if not L then return end

----------------------
--[[ commands.lua ]]--
----------------------

L["-->>|cffff0000DPS Plates Enabled|r<<--"] = "-->>|cffff0000DPS Plaketten eingeschaltet|r<<--"
L["|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cffff0000dpsing / healing|r role."] = "|cff89F559Threat Plates|r: Wechsel auf DPS festgestellt, Du bist jetzt in Deiner |cffff0000DPS-/Heiler|r-Rolle."

L["-->>|cff00ff00Tank Plates Enabled|r<<--"] = "-->>|cff00ff00Tank-Plates eingeschaltet|r<<--"
L["|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff00ff00tanking|r role."] = "|cff89F559Threat Plates|r: Wechsel auf Tank festgestellt, du bist jetzt in Deiner |cff00ff00Tank|r -Rolle."
L["|cff89F559Threat Plates|r: Role toggle not supported because automatic role detection is enabled."] = "|cff89F559Threat Plates|r: Rollenwechsel nicht möglich, da die automatische Rollenermittlung eingeschaltet ist."

L["-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--"] = "-->>Namensplaketten-Überlappung ist nun |cff00ff00ON!|r<<--"
L["-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--"] = "-->>Namensplaketten-Überlappung ist nun |cffff0000OFF!|r<<--"

L["-->>Threat Plates verbose is now |cff00ff00ON!|r<<--"] = "-->>Threat Plates-Meldungen sind nun |cff00ff00ON!|r<<--"
L["-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!"] = "-->>Threat Plates-Meldungen sind nun |cffff0000OFF!|r<<-- psst!!"

L["Usage: /tptp [options]"] = "Verwendung: /tptp [Optionen]"
L["  options:"] = "  Optionen"
L["    update-profiles      Migrates deprecated settings in your configuration"] = "    update-profiles      Migriert veraltete Werte in deinen Einstellungen"
L["    new-default-profile  Updates the default profile with new default settings"] = "    new-default-profile  Aktualisiert das Standardprofil mit neuen Standardwerten"
L["    help                 Prints this help message"] = "    help                 Zeigt diese Hilfennachricht an"
L["    <no option>          Displays options dialog"] = "    <no option>          Öffnet den Optionsdialog"

L["Migrating deprecated settings in configuration ..."] = "Migriere veraltete Werte in deinen Einstellungen ..."
L["Updating default profile with new settings ..."] = "Aktualisiere das Standardprofil mit neuen Werten ..."
L["Unknown option: "] = "Ungültige Option: "

L["Profile "] = "Profile "
L[": Converting settings from aura widget to aura widget 2.0 ..."] = "Übertrage die Einstellungen von Aura-Widget nach Aura-Widget 2.0 ..."

------------------------------
--[[ TidyPlatesThreat.lua ]]--
------------------------------

L["|cff00ff00tanking|r"] = "|cff00ff00Tank|r"
L["|cffff0000dpsing / healing|r"] = "|cffff0000DPS/Heiler|r"

L["Undetermined"] = "Unbestimmt"

L["|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"] = "|cff89f559Willkommen bei |rTidy Plates: |cff89f559Threat Plates!\nDas ist das erste Mal, dass Du Threat Plates benutzt und Du bist ein(n):\n|r|cff"
L["|cff89f559You are currently in your "] = "|cff89f559Du bist derzeit in Deiner "
L["|cff89f559 role.|r"] = "|cff89f559 Rolle.|r"
L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"] = "|cff89f559Weitere Optionen können durch die Eingabe von |r'/tptp'|cff89F559 aufgerufen werden.|r"
L[":\n----------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI. \n Clicking '|cffff0000No|r' will open the Tidy Plates options."] = ":\n----------\nMöchtest Du Deine \nAnzeige auf |cff89F559Threat Plates|r umschalten?\n\nEin Klick auf '|cff00ff00Ja|r' wird Threat Plates voreinstellen und das UI neuladen. \n Durch Klick auf '|cffff0000Nein|r' öffnen sich die Tidy Plates-Optionen."
L["\n---------------------------------------\nThe current version of ThreatPlates requires at least TidyPlates "] = "\n---------------------------------------\nDie aktuelle Version von ThreatPlates benötigt mindestens TidyPlates "
L[". You have installed an older or incompatible version of TidyPlates: "] = ". Du hast eine ältere oder inkompatibele Version von TidyPlates installiert: "
L[". Please update TidyPlates, otherwise ThreatPlates will not work properly."] = ". Bitte aktualisiere TidyPlates, andernfalls wird ThreatPlates nicht ordnungsgemäß funktionieren."
L["Yes"] = "Ja"
L["Cancel"] = "Abbruch"
L["No"] = "Nein"

L["-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"] = "-->>|cffff0000Aktiviere Threat Plates über die Tidy Plates-Optionen|r<<--"
L["|cff89f559Threat Plates:|r Welcome back |cff"] = "|cff89f559Threat Plates:|r Willkommen zurück |cff"

L["|cff89F559Threat Plates|r: Player spec change detected: |cff"] = "|cff89F559Threat Plates|r: Talentwechsel festgestellt: |cff"
L[" role."] = " -Rolle."

-- Custom Nameplates
L["Shadow Fiend"] = "Schattengeist"
L["Spirit Wolf"] = "Geisterwolf"
L["Ebon Gargoyle"] = "Schwarzer Gargoyle"
L["Water Elemental"] = "Wasserelementar"
L["Treant"] = "Treant"
L["Viper"] = "Viper"
L["Venomous Snake"] = "Giftige Schlange"
L["Army of the Dead Ghoul"] = "Ghul aus der Armee der Toten"
L["Shadowy Apparition"] = "Schattenhafte Erscheinung"
L["Shambling Horror"] = "Torkelnder Schrecken"
L["Web Wrap"] = "Fangnetz"
L["Immortal Guardian"] = "Unvergängliche Wache"
L["Marked Immortal Guardian"] = "Markierte unvergängliche Wache"
L["Empowered Adherent"] = "Machterfüllter Kultist"
L["Deformed Fanatic"] = "Deformierter Fanatiker"
L["Reanimated Adherent"] = "Wiederbelebter Kultist"
L["Reanimated Fanatic"] = "Wiederbelebter Fanatiker"
L["Bone Spike"] = "Knochenstachel"
L["Onyxian Whelp"] = "Welpe von Onyxia"
L["Gas Cloud"] = "Gaswolke"
L["Volatile Ooze"] = "Flüchtiger Schlamm"
L["Darnavan"] = "Darnavan"
L["Val'kyr Shadowguard"] = "Schattenwächterin der Val'kyr"
L["Kinetic Bomb"] = "Kinetische Bombe"
L["Lich King"] = "Lichkönig"
L["Raging Spirit"] = "Tobender Geist"
L["Drudge Ghoul"] = "Ghulsklave"
L["Living Inferno"] = "Lebendiges Inferno"
L["Living Ember"] = "Lebendiger Funken"
L["Fanged Pit Viper"] = "Bissige Grubenotter"
L["Canal Crab"] = "Kanalkrebs"
L["Muddy Crawfish"] = "Schlammiger Flusskrebs"

---------------------
--[[ options.lua ]]--
---------------------

L["None"] = "Keine"
L["Outline"] = "Rahmenlinie"
L["Thick Outline"] = "Dicke Rahmenlinie"
L["No Outline, Monochrome"] = "Keine Rahmenlinie, einfarbig"
L["Outline, Monochrome"] = "Rahmenlinie, einfarbig"
L["Thick Outline, Monochrome"] = "Dicke Rahmenlinie, einfarbig"

L["White List"] = "White-List"
L["Black List"] = "Black-List"
L["White List (Mine)"] = "White-List (eigene)"
L["Black List (Mine)"] = "Black-List (eigene)"
L["All Auras"] = "Alle Auras"
L["All Auras (Mine)"] = "Alle Auras (eigene)"

-- Tab Titles
L["Nameplate Settings"] = "Einstellungen Namensplaketten"
L["Threat System"] = "Bedrohungs-System"
L["Widgets"] = "Widgets"
L["Totem Nameplates"] = "Totem-Namensplaketten"
L["Custom Nameplates"] = "Benutzerdefinierte Namensplaketten"
L["About"] = "Über"

------------------------
-- Nameplate Settings --
------------------------
L["General Settings"] = "Allgemeine Einstellungen"
L["Hiding"] = "Versteckt"
L["Show Tapped"] = "Getappte Gegner anzeigen"
L["Show Neutral"] = "Neutrale Gegner anzeigen"
L["Show Normal"] = "Normale Gegner anzeigen"
L["Show Elite"] = "Elite-Gegner anzeigen"
L["Show Boss"] = "Bosse anzeigen"

L["Blizzard Settings"] = "Blizzard-Einstellungen"
L["Open Blizzard Settings"] = "Blizzard-Einstellungen öffnen"

L["Friendly"] = "Freundlich"
L["Show Friends"] = "Freundliche Einheiten anzeigen"
L["Show Friendly NPCs"] = "Freundliche NPCs anzeigen"
L["Show Friendly Totems"] = "Freundliche Totems anzeigen"
L["Show Friendly Pets"] = "Freundliche Begleiter anzeigen"
L["Show Friendly Guardians"] = "Freundliche Wachen anzeigen"

L["Enemy"] = "Feindlich"
L["Show Enemies"] = "Feinde anzeigen"
L["Show Enemy Totems"] = "Feindliche Totems anzeigen"
L["Show Enemy Pets"] = "Feindliche Begleiter anzeigen"
L["Show Enemy Guardians"] = "Feindliche Wachen anzeigen"

----
L["Healthbar"] = "HP-Leiste"
L["Textures"] = "Texturen"
L["Show Border"] = "Rand anzeigen"
L["Normal Border"] = "Normaler Rand"
L["Show Elite Border"] = "Elite-Markierung anzeigen"
L["Mouseover"] = "Mouseover"
L["Use a custom color for the healtbar's background."] = "Benutzerdefinierte Farbe für den Hintergrund der HP-Leiste verwenden."
L["Custom"] = "Benutzerdefiniert"
L["Use the healthbar's foreground color also for the background."] = "Vordergrundfarbe der HP-Leiste auch für den Hintergrund verwenden."
L["Same as Foreground"] = "Wie Vordergrund"
L["Background Color:"] = "Hintergrundfarbe:"
L["Background Opacity"] = "Hintergrund-Transparenz"

----
L["Placement"] = "Platzierung"
L["Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"] = "Änderungen an dieser Einstellung wird die Platzierung der Namensplatten verschieben, die Mouseover-Informationen werden dem aber nicht folgen. |cffff0000Vorsicht im Gebrauch!|r"
L["Offset X"] = "Offset X"
L["Offset Y"] = "Offset Y"
L["X"] = "X"
L["Y"] = "Y"
L["Anchor"] = "Verankerung"
----
L["Coloring"] = "Farben"
L["Enable Coloring"] = "Farbcodierung einschalten"
----
L["HP Coloring"] = "Farbcodierung nach Lebenspunkten"
L["Color HP by amount"] = "Lebenspunkte basierend auf Menge einfärben"
L["Changes the HP color depending on the amount of HP the nameplate shows."] = "Verändert die Farbe der HP-Leiste basierend auf der Menge an Lebenspunkten, die die Plakette anzeigt."
L["Class Coloring"] = "Farbcodierung nach Klassen"
L["Enable Enemy Class colors"] = "Feindliche Klassenfarben anzeigen"
L["Enable Friendly Class Colors"] = "Freundliche Klassenfarben anzeigen"
L["Enable the showing of hostile player class color on hp bars."] = "Ermöglicht die Anzeige der Klassenfarbe feindlicher Spieler im HP-Balken."
L["Enable the showing of friendly player class color on hp bars."] = "Ermöglicht die Anzeige der Klassenfarbe freundlicher Spieler im HP-Balken."
L["Friendly Caching"] = "Caching freundlicher Einheiten"
L["This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"] = "Dies ermöglicht es, Informationen über freundliche Klassen während der Spielsitzung oder wenn sie den Spielbildschirm verlassen zu speichern.|cffff0000(Benötigt mehr Speicher)"
----
L["Custom HP Color"] = "Benutzerdefinierte Farben des HP-Balkens"
L["Enable Custom HP colors"] = "Benutzerdefinierte HP-Balkenfarben anzeigen"
L["Friendly Color"] = "Farbe für freundliche Einheiten"
L["Tapped Color"] = "Farbe für getappte Einheiten"
L["Neutral Color"] = "Farbe für neutrale Einheiten"
L["Enemy Color"] = "Farbe für gegnerische Einheiten"
----
L["Raid Mark HP Color"] = "Raidmarkierungsfarbe für HP-Balken"
L["Enable Raid Marked HP colors"] = "Raidmarkierungsfarbe für HP-Balken einschalten"
L["Colors"] = "Farben"
----
L["Threat Colors"] = "Bedrohungsfarben"
L["Show Threat Glow"] = "Zeige Glühen bei Bedrohung"
L["Only on Attacked Units"] = "Nur bei angegriffenen Einheiten"
L["Show threat glow only on units in combat with the player."] = "Glühen bei Bedrohung nur bei Einheiten anzeigen, mit denen der Spieler im Kampf ist."
L["|cff00ff00Low threat|r"] = "|cff00ff00Niedrige Bedrohung|r"
L["|cffffff00Medium threat|r"] = "|cffffff00Mittlere Bedrohung|r"
L["|cffff0000High threat|r"] = "|cffff0000Hohe Bedrohung|r"
L["|cffff0000Low threat|r"] = "|cffff0000Niedrige Bedrohung|r"
L["|cff00ff00High threat|r"] = "|cff00ff00Hohe Bedrohung|r"
L["Low Threat"] = "Niedrige Bedrohung"
L["Medium Threat"] = "Mittlere Bedrohung"
L["High Threat"] = "Hohe Bedrohung"

----
L["Castbar"] = "Zauberleiste"
L["Enable"] = "Einschalten"
L["Interruptable Casts"] = "Unterbrechbare Zauber"
L["Shielded Coloring"] = "Gesicherte Farbcodierung"
L["Uninterruptable Casts"] = "Nicht unterbrechbare Zauber"

----
L["Alpha"] = "Alpha"
L["Blizzard Target Fading"] = "Blizzards Ziel-Verblassen"
L["Enable Blizzard 'On-Target' Fading"] = "Blizzards 'Am-Ziel'-Verblassen einschalten"
L["Enabling this will allow you to set the alpha adjustment for non-target nameplates."] = "Bei Einschalten dieser Funktion kann der Alpha-Wert für Nicht-Ziel-Einheiten eingestellt werden."
L["Non-Target Alpha"] = "Nicht-Ziel-Alphawert"
L["Alpha Settings"] = "Alpha-Einstellungen"

----
L["Scale"] = "Skalierung"
L["Scale Settings"] = "Skalierungs-Einstellungen"

----
L["Name Text"] = "Namenstext"
L["Enable Name Text"] = "Namenstext einschalten"
L["Enables the showing of text on nameplates."] = "Ermöglicht die Anzeige von Text in Namensplaketten."
L["Options"] = "Optionen"
L["Font"] = "Schriftart"
L["Font Style"] = "Schriftart-Stil"
L["Set the outlining style of the text."] = "Rahmenlinien des Textes einstellen"
L["Enable Shadow"] = "Schattierung einschalten"
L["Color"] = "Farbe"
L["Text Bounds and Sizing"] = "Textbegrenzung und Größe"
L["Font Size"] = "Schriftgröße"
L["Text Boundaries"] = "Textbegrenzung"
L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."] = "Diese Einstellungen definieren den Platz, der einem Text auf der Plakette zur Verfügung steht.\nEine zu große Schriftart mit zu niedriger Höhe wird dazu führen, dass der Text nicht sichtbar ist."
L["Text Width"] = "Textweite"
L["Text Height"] = "Texthöhe"
L["Horizontal Align"] = "Horizontale Ausrichtung"
L["Vertical Align"] = "Vertikale Ausrichtung"

----
L["Health Text"] = "Lebenspunkte-Text"
L["Enable Health Text"] = "Lebenspunkte-Text einschalten"
L["Display Settings"] = "Einstellungen für Darstellung"
L["Text at Full HP"] = "Text bei vollen Lebenspunkten"
L["Display health text on targets with full HP."] = "Zeigt den Lebenspunkte-Text bei Zielen mit voller Gesundheit an."
L["Percent Text"] = "Prozent-Text"
L["Display health percentage text."] = "Zeigt den Prozent-Text an."
L["Amount Text"] = "Mengen-Text"
L["Display health amount text."] = "Zeigt den Mengen-Text an."
L["Amount Text Formatting"] = "Formatierung Mengen-Text"
L["Truncate Text"] = "Text verkürzen"
L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts."] = "Hiermit wird der Text verkürzt dargestellt mittels M oder K für Millionen bwz. Tausend. Wenn ausgeschaltet, werden exakte HP-Werte angezeigt."
L["Max HP Text"] = "Maximale Lebenspunkte-Text"
L["This will format text to show both the maximum hp and current hp."] = "Hierdurch werden sowohl die maximalen als auch die aktuellen Lebenspunkte angezeigt."
L["Deficit Text"] = "Defizit-Text"
L["This will format text to show hp as a value the target is missing."] = "Hierdurch werden die fehlenden Lebenspunkte als Wert angezeigt."

----
L["Spell Text"] = "Zauber-Text"
L["Enable Spell Text"] = "Zauber-Text einschalten"

----
L["Level Text"] = "Stufen-Text"
L["Enable Level Text"] = "Stufen-Text einschalten"

----
L["Elite Icon"] = "Elite-Symbol"
L["Enable Elite Icon"] = "Elite-Symbol einschalten"
L["Enables the showing of the elite icon on nameplates."] = "Ermöglicht die Darstellung des Elite-Symbols an Plaketten."
L["Texture"] = "Textur"
L["Preview"] = "Vorschau"
L["Elite Icon Style"] = "Elite-Symbol-Style"
L["Size"] = "Größe"

----
L["Skull Icon"] = "Totenkopf"
L["Enable Skull Icon"] = "Zeigt den Totenkopf an"
L["Enables the showing of the skull icon on nameplates."] = "Ermöglicht die Anzeige des Totenkopfs an Plaketten."

----
L["Spell Icon"] = "Zaubersymbol"
L["Enable Spell Icon"] = "Zaubersymbol"
L["Enables the showing of the spell icon on nameplates."] = "Ermöglicht die Anzeige des Zaubersymbols an Plaketten."

----
L["Raid Marks"] = "Raidmarkierungen"
L["Enable Raid Mark Icon"] = "Raidmarkierungssymbole"
L["Enables the showing of the raid mark icon on nameplates."] = "Ermöglicht die Anzeige von Raidmarkierungssymbolen an Plaketten."

-----
L["Headline View"] = "Headline-View"
L["Enable Headline View (Text-Only)"] = "Headline-View (Text-Only) einschalten"
L["This will enable headline view (Text-Only) for nameplates. TidyPlatesHub must be enabled for this to work. Use the TidyPlatesHub options for configuration."] = "Hiermit wird der Headline-View (Text-Only) für Plaketten eingeschaltet. Dafür muss TidyPlatesHub aktiviert sein. Bitte verwende den TidyPlatesHub-Dialog zur Konfiguration."
L["Enabling this will allow you to set the alpha adjustment for non-target names in headline view."] = "Bei Einschalten dieser Funktion kann der Alpha-Wert für Nicht-Ziel-Einheiten im Headline-View eingestellt werden."

-------------------
-- Threat System --
-------------------

L["Enable Threat System"] = "Bedrohungs-System einschalten"

----
L["Additional Toggles"] = "Weitere Optionen"
L["Ignore Non-Combat Threat"] = "Kampffreie Bedrohung ignorieren"
L["Disables threat feedback from mobs you're currently not in combat with."] = "Schaltet Bedrohungs-Feedback von Gegnern aus, mit denen Du derzeit nicht im Kampf bist."
L["Show Tapped Threat"] = "Tapped Bedrohung anzeigen"
L["Disables threat feedback from tapped mobs regardless of boss or elite levels."] = "Schalted Bedrohungs-Feedback von getappten Gegnern aus, unabhängig von Boss- oder Elite-Leveln."
L["Show Neutral Threat"] = "Neutrale Bedrohung anzeigen"
L["Disables threat feedback from neutral mobs regardless of boss or elite levels."] = "Schaltet Bedrohungs-Feedback von neutralen Gegnern aus, unabhängig von Boss- oder Elite-Leveln."
L["Show Normal Threat"] = "Normale Bedrohung anzeigen"
L["Disables threat feedback from normal mobs."] = "Schaltet Bedrohungs-Feedback von normalen Gegnern aus."
L["Show Elite Threat"] = "Elite-Bedrohung anzeigen"
L["Disables threat feedback from elite mobs."] = "Schaltet Bedrohungs-Feedback von Elite-Gegnern aus."
L["Show Boss Threat"] = "Boss-Bedrohung anzeigen"
L["Disables threat feedback from boss level mobs."] = "Schaltet Bedrohungs-Feedback von Boss-Gegnern aus."

----
L["Set alpha settings for different threat reaction types."] = "Alpha-Einstellungen für verschiedene Bedrohungs-Reaktionsarten einstellen."
L["Enable Alpha Threat"] = "Enable Alpha Threat"
L["Enable nameplates to change alpha depending on the levels you set below."] = "Ermöglicht es, dass der Alphawert der Plaketten sich basierend auf den nachfolgenden Einstellungen verändert."
L["|cff00ff00Tank|r"] = "|cff00ff00Tank|r"
L["|cffff0000DPS/Healing|r"] = "|cffff0000DPS/Heiler|r"
L["Tank"] = "Tank"
L["DPS/Healing"] = "DPS/Heiler"
----
L["Marked Targets"] = "Markierte Ziele"
L["Ignore Marked Targets"] = "Markierte Ziele ignorieren"
L["This will allow you to disabled threat alpha changes on marked targets."] = "Schaltet Alpha-Wert-Veränderungen durch Bedrohung auf markierten Zielen aus."
L["Ignored Alpha"] = "Alpha ignoriert"

----
L["Set scale settings for different threat reaction types."] = "Skalierungseinstellungen für verschiedene Bedrohungsreaktionen bearbeiten."
L["Enable Scale Threat"] = "Skalierung bei Bedrohung einschalten"
L["Enable nameplates to change scale depending on the levels you set below."] = "Ermöglicht es, dass Plaketten basierend auf den nachstehenden Einstellungen die Skalierung ändern."
L["This will allow you to disabled threat scale changes on marked targets."] = "Schaltet Skalierungs-Veränderungen durch Bedrohung auf markierten Zielen aus."
L["Ignored Scaling"] = "Skalierung ignoriert"
----
L["Additional Adjustments"] = "Zusätzliche Anpassungen"
L["Enable Adjustments"] = "Anpassungen einschalten"
L["This will allow you to add additional scaling changes to specific mob types."] = "Ermöglicht weitere Skalierungs-Veränderungen für bestimmte Gegnerarten."

----
L["Toggles"] = "Umschalter"
L["Color HP by Threat"] = "HP-Balken nach Bedrohung einfärben"
L["This allows HP color to be the same as the threat colors you set below."] = "Ermöglicht die Einfärbung des HP-Balkens gemäß den nachstehend festgelegten Einstellungen für die Bedrohung."

----
L["Spec Roles"] = "Spezialisierung"
L["Set the roles your specs represent."] = "Stellt die Rollen der Spezialisierung ein."
L["Sets your spec "] = "Legt die Spezialisierung "
L[" to DPS."] = " auf Schadensausteiler fest."
L[" to tanking."] = " auf Tank fest."
L["Determine your role (tank/dps/healing) automatically based on current spec."] = "Ermittelt deine Rolle (Tank/DPS/Heiler) automatisch basierend auf deiner Spezialisierung fest."

----
L["Set threat textures and their coloring options here."] = "Bedrohungs-Texturen und ihre Farboptionen können hier eingestellt werden."
L["These options are for the textures shown on nameplates at various threat levels."] = "Diese Optionen beziehen sich auf die Texturen, die bei den verschiedenen Bedrohungsstufen an Plaketten angezeigt werden."
----
L["Art Options"] = "Design-Optionen"
L["Style"] = "Style"
L["This will allow you to disabled threat art on marked targets."] = "Schaltet Design-Optionen bei markierten Zielen aus."

-------------
-- Widgets --
-------------

L["Class Icons"] = "Klassen-Symbole"
L["Enable Class Icons Widget"] = "Klassen-Symbole einschalten"
L["This widget will display class icons on nameplate with the settings you set below."] = "Zeigt die Klassensymbole an Plaketten an basierend auf den nachfolgenden Einstellungen."
L["Enable Friendly Icons"] = "Symbole für freundliche Einheiten anzeigen"
L["Enable the showing of friendly player class icons."] = "Ermöglicht die Anzeige von Klassensymbolen für freundliche Spieler."

----
L["Combo Points"] = "Combo-Punkte"
L["This widget will display combo points on your target nameplate."] = "Ermöglicht die Anzeige von Combo-Punkten an der Plakette des Ziels."

----
L["Aura"] = "Auras"
L["This widget will display auras that match your filtering on your target nameplate and others you recently moused over."] = "Hiermit werden Auras gemäß des eingestellten Filters auf der Plakette des Ziels sowie auf Zielen, über die kurz zuvor mit der Maus gegangen wurde, angezeigt."
L["This lets you select the layout style of the aura widget. (requires /reload)"] = "Hier wird die Art des Layouts für Auren ausgewählt (erfordert /reload)."
L["Wide"] = "Wide"
L["Square"] = "Square"
L["Target Only"] = "Nur Ziel"
L["This will toggle the aura widget to only show for your current target."] = "This will toggle the aura widget to only show for your current target."
L["Sizing"] = "Größe"
L["Cooldown Spiral"] = "Cooldown-Spirale"
L["This will toggle the aura widget to show the cooldown spiral on auras. (requires /reload)"] = "Hiermit wird die Cooldown-Spirale auf Auren eingeschaltet (erfordert /reload)."
L["Filtering"] = "Filter"
L["Mode"] = "Modus"
L["Filtered Auras"] = "Gefilterte Auras"
L["This widget will display auras that match your filtering on your target nameplate and others you recently moused over. The old aura widget (Aura) must be disabled first."] = "Hiermit werden Auras gemäß des eingestellten Filters auf der Plakette des Ziels sowie auf Zielen, über die kurz zuvor mit der Maus gegangen wurde, angezeigt. Das alte Aura-Widget (Aura) muss zuerst ausgeschaltet werden."
L["Enable Aura Widget 2.0"] = "Aura-Widget 2.0 einschalten"
L["Filter by Spell"] = "Nach Zauber filtern"
L["Filter by Unit Reaction"] = "Nach Reaktion der Einheit filtern"
L["Filter by Dispel Type"] = "Nach Bannart filtern"
L["Appearance"] = "Aussehen"
L["Color by Dispel Type"] = "Nach Bannart einfärben"
L["Aura 2.0"] = "Aura 2.0"
L["This will toggle the aura widget to show the cooldown spiral on auras."] = "Hiermit wird die Cooldown-Spirale auf Auren eingeschaltet."
L["This will color the aura based on its type (poison, disease, magic, curse) - for Icon Mode the icon border is colored, for Bar Mode the bar itself."] = "Hiermit wird die Aura basierend auf ihrem Typ (Gift, Krankheit, Magie, Fluch) eingefärbt - im Symbolmodus wird der Symbolrand eingefärbt, im Leistenmodus die Leiste selbst."
L["Default Buff Color"] = "Standardfarbe für Buffs"
L["Default Debuff Color"] = "Standardfarbe für Debuffs"
L["Sort Order"] = "Sortierungsreihenfolge"
L["None"] = "Keine"
L["A to Z"] = "A bis Z"
L["Sort in ascending alphabetical order."] = "Sortiert aufsteigend in alphabetischer Reihenfolge."
L["Time Left"] = "Verbleibende Zeit"
L["Sort by time left in ascending order."] = "Sortiert nach verbleibender Zeit in aufsteigender Reihenfolge."
L["Duration"] = "Dauer"
L["Sort by overall duration in ascending order."] = "Sortiert nach Gesamtdauer in aufsteigender Reihenfolge"
L["Creation"] = "Erzeugung"
L["Show auras in order created with oldest aura first."] = "Sortiert die Auren in der Reihenfolge, in der sie erzeugt wurden (älteste zuerst)."
L["Reverse Order"] = "Umgekehrte Reihenfolge"
L['Reverse the sort order (e.g., "A to Z" becomes "Z to A").'] = 'Kehrt die Sortierungsreihenfolge um (z. B. wird "A bis Z" zu "Z bis A")'
L["Stack Count"] = "Anzahl der Stapel"
L["Show stack count as overlay on aura icon."] = "Anzahl der Stapel als Overlay über dem Aurasymbol anzeigen."
L["Show auras as icons in a grid configuration."] = "Auren als Symbole in einem Raster anzeigen."
L["Icon Style"] = "Symbol-Stil"
L["This lets you select the layout style of the aura widget."] = "Hiermit kann der Stil des Aura-Widget-Layouts ausgewählt werden."
L["Icon Layout"] = "Symbol-Layout"
L["Column Limit"] = "Spaltenobergrenze"
L["Row Limit"] = "Zeilenobergrenze"
L["Horizontal Spacing"] = "Horizontaler Zwischenraum"
L["Vertical Spacing"] = "Vertikaler Zwischenraum"
L["Bar Mode"] = "Modus Leiste"
L["Show auras as bars (with optional icons)."] = "Auren als Leisten anzeigen (optional mit Symbolen)."
L["Bar Layout"] = "Leisten-Layout"
L["Bar Limit"] = "Leistenobergrenze"
L["Bar Width"] = "Leistenbreite"
L["Bar Height"] = "Leistenhöhe"
L["Bar Textures"] = "Leistentexturen"
L["Foreground Texture"] = "Vordergrundtextur"
L["Background Texture"] = "Hintergrundtextur"
L["Background Color"] = "Hintergrundfarbe"
L["Typeface"] = "Schriftart"
L["Label Text Offset"] = "Versatz der Beschriftungstextes"
L["Time Text Offset"] = "Versatz des Zeittextes"
L["Show Icon to the Left"] = "Symbole von links nach rechts anzeigen"
L["Offset"] = "Versatz"
L["Layout"] = "Layout"
L["Show Friendly"] = "Freundlich anzeigen"
L["Show Enemy"] = "Feindlich anzeigen"
L["Anchor Point"] = "Ankerpunkt"
L["Right-to-left"] = "Rechts nach links"
L["Left-to-right"] = "Links nach rechts"
L["Bottom-to-top"] = "Unten nach oben"
L["Top-to-bottom"] = "Oben nach unten"
L["Vertical Alignment"] = "Vertikale Ausrichtung"
L["Horizontal Alignment"] = "Horizontale Ausrichtung"

----
L["Social"] = "Soziale Widgets"
L["Enables the showing of indicator icons for friends, guildmates, and BNET Friends"] = "Ermöglicht eine Anzeige von Icons für Freunde, Gildenmitgliedern und Battlenet-Freunden"

----
L["Threat Line"] = "Bedrohungslinie"
L["This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates."] = "Ermöglicht die Anzeige einer schmalen Leiste, die in Relation zu anderen Spielern Deine aktuelle Bedrohung an der Namensplakette Deines Ziels oder Gegnern, über die Du kürzlich mit der Maus gefahren bist, anzeigt."

----
L["Tanked Targets"] = "Getankte Ziele"
L["This widget will display a small shield or dagger that will indicate if the nameplate is currently being tanked.|cffff00ffRequires tanking role.|r"] = "Ermöglicht die Anzeige eines kleinen Schilds oder Dolches an der Namensplakette zur Anzeige, ob das Ziel derzeit getankt wird. |cffff00ffBenötigt Tank-Rolle.|r"

----
L["Target Highlight"] = "Ziel-Highlight"
L["Enables the showing of a texture on your target nameplate"] = "Ermöglicht die Anzeige einer Textur an der Plakette des Ziels"

---- Quest Widget
L["Quest"] = "Quest"
L["Enable Quest Widget"] = "Quest-Widget aktivieren"
L["Enables highlighting of nameplates of mobs involved with any of your current quests."] = "Aktiviert das Hervorheben von Plaketten von Mobs, die Ziel deiner aktuellen Quest sind."
L["Health Bar Mode"] = "Modus Health-Bar"
L["Icon Mode"] = "Modus Icon"
L["Visibility"] = "Sichtbarkeit"
L["Use a custom color for the health bar of quest mobs."] = "Benutzerdefinierte Farbe für die Healthbar von Quest-Mobs verwenden"
L["Show an indicator icon at the nameplate for quest mobs."] = "Zeige ein Hinweissymbol an den Plaketten von Quest-Mobs an"
L["Hide in Combat"] = "Im Kampf verstecken"
L["Hide in Instance"] = "In Instanzen verstecken"
L["Hide on Attacked Units"] = "Bei angegriffenen Gegnern verstecken"

---- Stealth Widgets
L["Stealth"] = "Stealth"
L["Enable Stealth Widget (Feature not yet fully implemented!)"] = "Stealth-Widget aktiviern (Feature noch nicht vollständig implementiert!)"
L["Shows a stealth icon above the nameplate of units that can detect you while stealthed."] = "Zeigt ein Stealth-Icon über den Plaketten von Einheiten an, die dich in Verstohlenheit entdecken können"

----------------------
-- Totem Nameplates --
----------------------

L["|cffffffffTotem Settings|r"] = "|cffffffffTotem-Einstellungen|r"
L["Toggling"] = "Umschalten"
L["Hide Healthbars"] = "HP-Balken verstecken"
----
L["Icon"] = "Icon"
L["Icon Size"] = "Icon-Größe"
L["Totem Alpha"] = "Totem-Alpha"
L["Totem Scale"] = "Totem-Skalierung"
----
L["Show Nameplate"] = "Plakette zeigen"
----
L["Health Coloring"] = "Gesundheits-Farbcodierung"
L["Enable Custom Colors"] = "Eigene Farbwahl aktivieren"

-----------------------
-- Custom Nameplates --
-----------------------

L["|cffffffffGeneral Settings|r"] = "|cffffffffAllgemeine Einstellungen|r"
L["Disabling this will turn off any all icons without harming custom settings per nameplate."] = "Das Abschalten dieser Funktion schaltet alle Icons aus, ohne die benutzerdefinierten Einstellungen für Plaketten zu verändern."
----
L["Set Name"] = "Namen festlegen"
L["Use Target's Name"] = "Benutze Name des Ziels"
L["No target found."] = "Kein Ziel gefunden."
L["Clear"] = "Löschen"
L["Copy"] = "Kopieren"
L["Copied!"] = "Kopiert!"
L["Paste"] = "Einfügen"
L["Pasted!"] = "-Eingefügt!"
L["Nothing to paste!"] = "Nichts zum einfügen!"
L["Restore Defaults"] = "Standardeinstellungen wiederherstellen"
----
L["Use Custom Settings"] = "Benutzerdefinierte Einstellungen benutzen"
L["Custom Settings"] = "Benutzerdefinierte Einstellungen"
----
L["Disable Custom Alpha"] = "Benutzerdefinierte Alphaeinstellungen ausschalten"
L["Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings."] = "Schaltet die aktuellen benutzerdefinierten Alphaeinstellungen für diese Plakette ab und benutzt stattdessen die normalen Alphaeinstellungen."
L["Custom Alpha"] = "Benutzerdefinierte Alphaeinstellungen"
----
L["Disable Custom Scale"] = "Benutzerdefinierte Skalierungseinstellungen ausschalten"
L["Disables the custom scale setting for this nameplate and instead uses your normal scale settings."] = "Schaltet die benutzerdefinierten Skalierungseinstellungen für diese Plakette ab und benutzt stattdessen die normalen Skalierungseinstellungen."
L["Custom Scale"] = "Benutzerdefinierte Skalierungseinstellungen"
----
L["Allow Marked HP Coloring"] = "Lebenspunktebalken-Einfärbung auf markierten Zielen erlauben"
L["Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark."] = "Erlaubt die HP-Balken-Einfärbung gemäß Raidmarkierung statt eigenen Einstellungen für HP-Balken, wenn das Ziel eine Markierung hat."

----
L["Enable the showing of the custom nameplate icon for this nameplate."] = "Ermöglicht die Anzeige eines benutzerdefinierten Icons für diese Plakette."
L["Type direct icon texture path using '\\' to separate directory folders, or use a spellid."] = "Gib den direkten Dateipfad zur Textur ein. Benutze '\\' zur Separierung von Ordnerstrukturen oder eine Zauber-ID."
L["Set Icon"] = "Icon festlegen"

L["Use Threat Colors"] = "Threat-Farben verwenden"
L["Use coloring based an threat level (configured in Threat System) in combat (custom color is only used out of combat)."] = "Verwende im Kampf eine Einfärbung der Gesundheitsleite basierend auf dem Bedrohungsgrad (konfiguriert unter Bedrohungs-System). Die eigene Farbe wird dann nur außerhalb des Kampfes verwendet)."
L["Show a glow based on threat level around the nameplate's healthbar (in combat)."] = "Zeigt ein Glühen an der Gesundheitsleiste der Namensplaketten an, basierend auf dem Bedrohungsgrad (im Kampf)."

-----------
-- About --
-----------

L["Clear and easy to use nameplate theme for use with TidyPlates.\n\nCurrent version: "] = "Sauberes und leicht zu verwendendes Plakettendesign zur Benutzung mit TidyPlates..\n\nAktuelle Version: "
L["\n\nFeel free to email me at |cff00ff00threatplates@gmail.com|r\n\n--\n\nBlacksalsify\n\n(Original author: Suicidal Katt - |cff00ff00Shamtasticle@gmail.com|r)"] = "\n\nDu kannst mich gerne per E-Mail erreichen unter |cff00ff00threatplates@gmail.com|r\n\n--\n\nBlacksalsify\n\n(Ursprünglicher Autor: Suicidal Katt - |cff00ff00Shamtasticle@gmail.com|r)"

--------------------------------
-- Default Game Options Frame --
--------------------------------

L["You can access the "] = "Die Einstellungen können für "
L[" options by typing: /tptp"] = " über die Eingabe von /tptp erreicht werden"
L["Open Config"] = "Konfiguration öffnen"

------------------------
-- Additional Stances --
------------------------
L["Presences"] = "Präsenzen"
L["Shapeshifts"] = "Gestaltwandlungen"
L["Seals"] = "Auren"
L["Stances"] = "Haltungen"
