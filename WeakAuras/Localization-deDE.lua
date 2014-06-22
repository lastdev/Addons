if not(GetLocale() == "deDE") then
    return;
end

local L = WeakAuras.L

-- Options translation
L["<"] = "< (Kleiner)"
L["<="] = "<= (Kleinergleich)"
L["="] = "= (Gleich)"
L[">"] = "> (Größer)"
L[">="] = ">= (Größergleich)"
L["!="] = "!= (Ungleich)"
L["10 Man Raid"] = "10er-Schlachtzug"
L["25 Man Raid"] = "25er-Schlachtzug"
L["5 Man Dungeon"] = "5er Gruppe"
L["Absorb"] = "Absorbieren"
L["Absorbed"] = "Absorbiert"
L["Action Usable"] = "Aktion nutzbar"
L["Affected"] = "Betroffen"
L["Air"] = "Luft"
L["Alive"] = "Am Leben"
L["All Triggers"] = "Alle Auslöser (UND)"
L["Alternate Power"] = "Alternative Energie"
L["Ambience"] = "Umgebung"
L["Amount"] = "Anzahl"
L["Any Triggers"] = "Ein Auslöser (ODER)"
L["Arena"] = "Arena"
L["Ascending"] = "Aufsteigend"
L["At Least One Enemy"] = "Zumindest ein Feind"
L["Attackable"] = "Angreifbar"
L["Aura"] = "Aura (Buff/Debuff)"
L["Aura:"] = "Aura:"
L["Aura Applied"] = "Aura angewant (AURA_APPLIED)"
L["Aura Applied Dose"] = "Aura angewant, Stack erhöht (AURA_APPLIED_DOSE)"
L["Aura Broken"] = "Aura gebrochen, Nahkampf (AURA_BROKEN)"
L["Aura Broken Spell"] = "Aura gebrochen, Zauber (AURA_BROKEN_SPELL)"
L["Aura Name"] = "Auraname"
L["Aura Refresh"] = "Aura erneuert (AURA_REFRESH)"
L["Aura Removed"] = "Aura entfernt (AURA_REMOVED)"
L["Aura Removed Dose"] = "Aura entfernt, Stack verringert (AURA_REMOVED_DOSE)"
L["Auras:"] = "Auren:"
L["Aura Stack"] = "Aurastacks"
L["Aura Type"] = "Auratyp"
L["Automatic"] = "Automatisch"
L["Back and Forth"] = "Vor und zurück"
L["Battleground"] = "Schlachtfeld"
L["Battle.net Whisper"] = "Battle.net-Flüster"
L["BG>Raid>Party>Say"] = "Schlachtfeld>Schhlachtzug>Gruppe>Sagen"
L["BG-System Alliance"] = "BG-System Allianz"
L["BG-System Horde"] = "BG-System Horde"
L["BG-System Neutral"] = "BG-System Neutral"
L["Blizzard Combat Text"] = "Kampflog"
L["Block"] = "Blocken"
L["Blocked"] = "Geblockt"
L["Blood Rune #1"] = "Blutrune #1"
L["Blood Rune #2"] = "Blutrune #2"
L["Blood runes"] = "Blutrunen" -- Needs review
L["Boss Emote"] = "Bossemote"
L["Bottom"] = "Unten"
L["Bottom Left"] = "Unten Links"
L["Bottom Right"] = "Unten Rechts"
L["Bottom to Top"] = "Von unten nach oben"
L["Bounce"] = "Hüpfen"
L["Bounce with Decay"] = "Abklingendes Hüpfen"
L["Buff"] = "Buff"
L["By |cFF69CCF0Mirrored|r of Dragonmaw(US) Horde"] = "Von |cFF69CCF0Mirrored|r auf Dragonmaw(US) Horde"
L["Cast"] = "Zaubern"
L["Cast Failed"] = "Zauber fehlgeschlagen (CAST_FAILED)"
L["Cast Start"] = "Zauber gestartet (CAST_START)"
L["Cast Success"] = "Zauber gelungen (CAST_SUCCESS)"
L["Cast Type"] = "Zaubertyp"
L["Center"] = "Mitte"
L["Centered Horizontal"] = "Horizontal-Zentriert"
L["Centered Vertical"] = "Vertikal zentriert"
L["Channel"] = "Chatkanal"
L["Channel (Spell)"] = "Kanalisieren (Zauber)"
L["Character Type"] = "Charaktertyp"
L["Chat Frame"] = "Chatframe"
L["Chat Message"] = "Chatnachricht"
L["Children:"] = "Kinder:"
L["Circle"] = "Kreis"
L["Circular"] = "Kreisförmig"
L["Class"] = "Klasse"
L["Click to close configuration"] = "|cFF8080FF(Klick)|r Config-GUI schließen"
L["Click to open configuration"] = "|cFF8080FF(Klick)|r Config-GUI öffnen"
L["Combat Log"] = "Kampflog"
L["Combo Points"] = "Kombopunkte"
L["Conditions"] = "Bedingungen"
L["Contains"] = "Enthält"
L["Cooldown Progress (Item)"] = "Abklingzeit (Gegenstand)"
L["Cooldown Progress (Spell)"] = "Abklingzeit (Zauber)"
L["Cooldown Ready (Item)"] = "Abklingzeit vorbei (Gegenstand)"
L["Cooldown Ready (Spell)"] = "Abklingzeit vorbei (Zauber)"
L["Create"] = "Erstellen"
L["Critical"] = "Kritisch"
L["Crowd Controlled"] = "Kontrollverlust"
L["Crushing"] = "Zerschmettern"
L["Curse"] = "Fluch"
L["Custom"] = "Benutzerdefiniert"
L["Custom Function"] = "Benutzerdefinierte Funktion"
L["Damage"] = "Schaden (DAMAGE)"
L["Damager"] = "Schadensausteiler"
L["Damage Shield"] = "Schadensschild (DAMAGE_SHIELD)"
L["Damage Shield Missed"] = "Schadensschild verfehlt (DAMAGE_SHIELD_MISSED)"
L["Damage Split"] = "Schadensteilung (DAMAGE_SPLIT)"
L["Death Knight"] = "Todesritter"
L["Death Knight Rune"] = "Todesritter Runen"
L["Death Rune"] = "Todes Rune"
L["Debuff"] = "Debuff"
L["Deflect"] = "Umlenken"
L["Descending"] = "Absteigend"
L["Destination Name"] = "Zielname"
L["Destination Unit"] = "Zieleinheit"
L["Disease"] = "Krankheit"
L["Dispel"] = "Bannen (DISPEL)"
L["Dispel Failed"] = "Bannen fehlgeschlagen (DISPEL_FAILED)"
L["Dodge"] = "Ausweichen (DODGE)"
L["Done"] = "Fertiggestellt"
L["Down"] = "Runter"
L["Drain"] = "Saugen (DRAIN)"
L["Drowning"] = "Ertinken (DROWNING)"
L["Druid"] = "Druide"
L["Dungeon Difficulty"] = "Instanzschwierigkeit"
L["Durability Damage"] = "Haltbarkeitsschaden (DURABILITY_DAMAGE)"
L["Durability Damage All"] = "Haltbarkeitsschaden, Alle (DURABILITY_DAMAGE_ALL)"
L["Earth"] = "Erde"
L["Eclipse Direction"] = "Finsternisausrichtung"
L["Eclipse Power"] = "Finsternisenergie"
L["Eclipse Type"] = "Finsternistyp"
L["Emote"] = "Emote"
L["Energize"] = "Aufladen (ENERGIZE)"
L["Energy"] = "Energie"
L["Enrage"] = "Wut"
L["Environmental"] = "Umgebung (ENVIRONMENTAL)"
L["Environment Type"] = "Umgebungstyp"
L["Evade"] = "Entkommen (EVADE)"
L["Event"] = "Ereignis"
L["Event(s)"] = "Ereignisse"
L["Every Frame"] = "Bei jedem OnUpdate"
L["Extra Amount"] = "Extra Betrag"
L["Extra Attacks"] = "Extra Angriffe (EXTRA_ATTACKS)"
L["Extra Spell Name"] = "Extra Zaubername"
L["Fade In"] = "Aufblenden"
L["Fade Out"] = "Abblenden"
L["Falling"] = "Fallen (FALLING)"
L["Fatigue"] = "Erschöpfung (FATIGUE)"
L["Fire"] = "Feuer"
L["First Tree"] = "Erster Talentbaum"
L["Flash"] = "Aufblitzen"
L["Flip"] = "Umdrehen"
L["Focus"] = "Fokus"
L["Form"] = "Form"
L["Friendly"] = "Freundlich"
L["From"] = "Von"
L["Frost Rune #1"] = "Frost Rune #1"
L["Frost Rune #2"] = "Frost Rune #2"
L["Frost Runes"] = "Frostrunen" -- Needs review
L["Glancing"] = "Gestreift (GLANCING)"
L["Global Cooldown"] = "Globale Abklingzeit"
L["Glow"] = "Leuchten"
L["Gradient"] = "Gradient"
L["Gradient Pulse"] = "Gradient Pulse"
L["Group"] = "Gruppe"
L["Group %s"] = "Gruppe %s"
L["Grow"] = "Wachsen"
L["Guild"] = "Gilde"
L["Happiness"] = "Zufriedenheit"
L["HasPet"] = "Begleiter aktiv"
L["Heal"] = "Heilen"
L["Healer"] = "Heiler"
L["Health"] = "Lebenspunkte"
L["Health (%)"] = "Lebenspunkte (%)"
L["Heroic"] = "Heroisch"
L["Hide"] = "Verbergen"
L["Higher Than Tank"] = "Höher als der Tank"
L["Holy Power"] = "Heilige Kraft"
L["Hostile"] = "Feindlich"
L["Hostility"] = "Ausrichtung"
L["Humanoid"] = "Humanoid"
L["Hunter"] = "Jäger"
L["Icon"] = "Symbol"
L["Ignore Rune CD"] = "Runen CD ignorieren"
L["Immune"] = "Immun (IMMUNE)"
L["Include Bank"] = "Bank einbeziehen"
L["Include Charges"] = "Aufladungen einbeziehen"
L["Include Death Runes"] = "Todesrunen miteinbeziehen" -- Needs review
L["In Combat"] = "Im Kampf"
L["Inherited"] = "Vererbt"
L["Inside"] = "Innerhalb"
L["Instakill"] = "Sofortiger Tod (INSTAKILL)"
L["Instance Type"] = "Instanztyp"
L["Interrupt"] = "Unterbrechen (INTERRUPT)"
L["Interruptible"] = "Unterbrechbar"
L["In Vehicle"] = "In Fahrzeug"
L["Inverse"] = "Invertieren"
L["Is Exactly"] = "Strikter Vergleich"
L["Item"] = "Gegenstand"
L["Item Count"] = "Gegenstandsanzahl"
L["Item Equipped"] = "Gegenstand angelegt"
L["Lava"] = "Lava"
L["Leech"] = "Saugen (LEECH)"
L["Left"] = "Links"
L["Left to Right"] = "Links -> Rechts"
L["Level"] = "Level"
L["Lower Than Tank"] = "Niedriger als der Tank"
L["Lunar"] = "Lunar"
L["Lunar Power"] = "Lunarenergie"
L["Mage"] = "Magier"
L["Magic"] = "Magie"
L["Main Hand"] = "Haupthand"
L["Mana"] = "Mana"
L["Master"] = "Master"
L["Matches (Pattern)"] = "Abgleichen (Muster)"
L["Message"] = "Nachricht"
L["Message type:"] = "Nachrichtentyp:"
L["Message Type"] = "Nachrichtentyp"
L["Miss"] = "Verfehlen"
L["Missed"] = "Verfehlt (MISSED)"
L["Missing"] = "Fehlend"
L["Miss Type"] = "Verfehlengrund"
L["Monochrome"] = "Schwarz-Weiß" -- Needs review
L["Monster Yell"] = "NPC-Schrei"
L["Mounted"] = "Reiten"
L["Multi-target"] = "Mehrfachziel"
L["Music"] = "Musik"
L["Name"] = "Name"
L["Never"] = "Nie"
L["Next"] = "Weiter"
L["No Children:"] = "Keine Kinder:"
L["No Instance"] = "Keine Instanz"
L["None"] = "Keine(r)"
L["Non-player Character"] = "Nicht-Spieler Charakter (NPC)"
L["Normal"] = "Normal"
L["Not On Threat Table"] = "Nicht auf der Bedrohungsliste"
L["Number"] = "Nummer"
L["Number Affected"] = "Betroffene Anzahl"
L["Off Hand"] = "Nebenhand"
L["Officer"] = "Offizier"
L["Opaque"] = "Deckend"
L["Orbit"] = "Orbit"
L["Outline"] = "Kontur" -- Needs review
L["Outside"] = "Außerhalb"
L["Overhealing"] = "Überheilung"
L["Overkill"] = "Overkill"
L["Paladin"] = "Paladin"
L["Parry"] = "Parieren"
L["Party"] = "Gruppe"
L["Party Kill"] = "Gruppen Tod (PARTY_KILL)"
L["Paused"] = "Pausiert"
L["Periodic Spell"] = "Periodischer Zauber (PERIODIC_SPELL)"
L["Pet"] = "Begleiter"
L["Player"] = "Spieler (Selbst)"
L["Player Character"] = "Spieler Charakter (PC)"
L["Player Class"] = "Spielerklasse"
L["Player Dungeon Role"] = "Spieler Gruppenrole"
L["Player Level"] = "Spielerlevel"
L["Player Name"] = "Spielername"
L["Player(s) Affected"] = "Beeinträchtigte Spieler"
L["Player(s) Not Affected"] = "Nicht betroffene Spieler"
L["Poison"] = "Gift"
L["Power"] = "Energie"
L["Power (%)"] = "Energie (%)"
L["Power Type"] = "Energietyp"
L["Preset"] = "Standard"
L["Priest"] = "Priester"
L["Progress"] = "Fortschritt"
L["Pulse"] = "Pulsieren"
L["PvP Flagged"] = "PvP aktiv"
L["Radius"] = "Raduis"
L["Rage"] = "Wut"
L["Raid"] = "Raid"
L["Raid Warning"] = "Raidwarnung"
L["Range"] = "Reichweite"
L["Ranged"] = "Distanz"
L["Receiving display information"] = "Erhalte Anzeigeinformationen von %s"
L["Reference Spell"] = "Referenzzauber"
L["Reflect"] = "Reflektieren (REFLECT)"
L["Relative"] = "Relativ"
L["Remaining Time"] = "Verbleibende Zeit"
L["Requested display does not exist"] = "Angeforderte Anzeige existiert nicht"
L["Requested display not authorized"] = "Angeforderte Anzeige ist nicht autorisiert"
L["Require Valid Target"] = "Erfordert gültiges Ziel"
L["Resist"] = "Wiederstehen"
L["Resisted"] = "Wiederstanden (RESISTED)"
L["Resolve collisions dialog"] = [=[
Ein externes Addon definiert |cFF8800FFWeakAuras|r Anzeigen die den selben Namen besitzten wie bereits existierende Anzeigen.

|cFF8800FFWeakAuras|r Anzeigen müssen umbenannt werden um Platz für die externen Anzeigen zu machen.

Gelöst: |cFFFF0000]=]
L["Resolve collisions dialog singular"] = [=[
Ein externes Addon definiert eine |cFF8800FFWeakAuras|r Anzeige die den selben Namen besitzten wie eine bereits existierende Anzeige.

|cFF8800FFWeakAuras|r Anzeige muss umbenannt werden um Platz für die externe Anzeige zu machen.

Gelöst: |cFFFF0000]=]
L["Resolve collisions dialog startup"] = [=[
Ein externes Addon definiert |cFF8800FFWeakAuras|r Anzeigen die den selben Namen besitzten wie bereits existierende Anzeigen.

|cFF8800FFWeakAuras|r Anzeigen müssen umbenannt werden um Platz für die externen Anzeigen zu machen.

Gelöst: |cFFFF0000]=]
L["Resolve collisions dialog startup singular"] = [=[
Ein externes Addon definiert eine |cFF8800FFWeakAuras|r Anzeige die den selben Namen besitzten wie eine bereits existierende Anzeige.

|cFF8800FFWeakAuras|r Anzeige muss umbenannt werden um Platz für die externe Anzeige zu machen.

Gelöst: |cFFFF0000]=]
L["Resting"] = "Erholen"
L["Resurrect"] = "Wiederbeleben"
L["Right"] = "Rechts"
L["Right to Left"] = "Rechts -> Links"
L["Rogue"] = "Schurke"
L["Rotate Left"] = "Nach links rotieren"
L["Rotate Right"] = "Nach rechts rotieren"
L["Rune"] = "Rune"
L["Runic Power"] = "Runenmacht"
L["Say"] = "Sagen"
L["Seconds"] = "Sekunden"
L["Second Tree"] = "Zweiter Talentbaum"
L["Shake"] = "Beben"
L["Shaman"] = "Schamane"
L["Shards"] = "Splitter"
L["Shift-Click to pause"] = "|cFF8080FF(Shift-Klick)|r Pause"
L["Shift-Click to resume"] = "|cFF8080FF(Shift-Klick)|r Fortsetzten"
L["Show"] = "Zeigen"
L["Shrink"] = "Schrumpfen"
L["Slide from Bottom"] = "Von unten eingleiten"
L["Slide from Left"] = "Von links eingleiten"
L["Slide from Right"] = "Von rechts eingleiten"
L["Slide from Top"] = "Von oben eingleiten"
L["Slide to Bottom"] = "Nach unten entgleiten"
L["Slide to Left"] = "Nach links entgleiten"
L["Slide to Right"] = "Nach rechts entgleiten"
L["Slide to Top"] = "Nach oben entgleiten"
L["Slime"] = "Schleim"
L["Solar"] = "Solar"
L["Solar Power"] = "Solarenergie"
L["Sound Effects"] = "Soundeffekte"
L["Source Name"] = "Quellname"
L["Source Unit"] = "Quelleinheit"
L["Spacing"] = "Abstand"
L["Specific Unit"] = "Konkrete Einheit"
L["Spell"] = "Zauber"
L["Spell (Building)"] = "Zauber, Gebäude (SPELL_BUILDING)"
L["Spell Name"] = "Zaubername"
L["Spin"] = "Drehen"
L["Spiral"] = "Winden"
L["Spiral In And Out"] = "Ein- und Auswinden"
L["Stacks"] = "Stacks"
L["Stance/Form/Aura"] = "Haltung/Form/Aura"
L["Status"] = "Status"
L["Stolen"] = "Gestohlen (STOLEN)"
L["Summon"] = "Herbeirufen (SUMMON)"
L["Swing"] = "Schwingen (SWING)"
L["Swing Timer"] = "Schlagtimer"
L["Talent Specialization"] = "Talentspezialisierung"
L["Tank"] = "Tank"
L["Tanking And Highest"] = "Höchster und Aggro"
L["Tanking But Not Highest"] = "Aggro aber nicht höchster"
L["Target"] = "Ziel"
L["Thick Outline"] = "Dicke Kontur" -- Needs review
L["Third Tree"] = "Dritter Talentbaum"
L["Threat Situation"] = "Bedrohungssituation"
L["Thrown"] = "Wurfwaffe"
L["Timed"] = "Zeitgesteuert"
L["Top"] = "Oben"
L["Top Left"] = "Oben Links"
L["Top Right"] = "Oben Rechts"
L["Top to Bottom"] = "Oben -> Unten"
L["Total"] = "Gesamt"
L["Totem"] = "Totem"
L["Totem Name"] = "Totemname"
L["Totem Type"] = "Totemtyp"
L["Transmission error"] = "Übertragungsfehler"
L["Trigger:"] = "Auslöser:"
L["Trigger Update"] = "Auslöser Aktualisierung"
L["Undefined"] = "Undefiniert"
L["Unholy Rune #1"] = "Unheilig Rune #1"
L["Unholy Rune #2"] = "Unheilig Rune #2"
L["Unholy Runes"] = "Unheilige Runen" -- Needs review
L["Unit"] = "Einheit"
L["Unit Characteristics"] = "Einheitencharakterisierung"
L["Unit Destroyed"] = "Einheit zerstört"
L["Unit Died"] = "Einheit gestorben"
L["Up"] = "Hoch"
L["Version error recevied higher"] = "Diese Anzeige ist inkompatibel zu dieser Version von Weakauras. Benötigte Version lautet %s, du besitzt Version %s. Bitte aktualisiere WeakAuras."
L["Version error recevied lower"] = "Diese Anzeige ist inkompatibel zu dieser Version von Weakauras. Benötigte Version lautet %s, du besitzt Version %s. Bitte lass die andere Person WeakAuras aktualisieren."
L["Warlock"] = "Hexenmeister"
L["Warrior"] = "Krieger"
L["Water"] = "Wasser"
L["WeakAuras"] = "WeakAuras"
L["WeakAurasModelPaths"] = "WeakAuras - 3D Modell Pfade"
L["WeakAurasModelPaths .toc Notes"] = "Stellt eine Liste der meisten 3D Modelle für WA Displays zur Verfügung."
L["WeakAurasOptions"] = "WeakAuras Optionen"
L["WeakAurasOptions .toc Notes"] = "Optionen für WeakAuras"
L["WeakAuras .toc Notes"] = "Eine leistungsfähiges, umfassendes Addon zur grafischen Darstellung von Informationen über Auren, Cooldowns, Timern und vielem mehr."
L["WeakAurasTutorials"] = "WeakAuras - Tutorials"
L["WeakAurasTutorials .toc Notes"] = "3D-Model Pfade für WeakAuras"
L["Weapon"] = "Waffen"
L["Weapon Enchant"] = "Waffenverzauberung"
L["Whisper"] = "Flüstern"
L["Wobble"] = "Wackeln"
L["Yell"] = "Schreien"
L["Zone"] = "Zone"
L["Options/1 Match"] = "1 Treffer"
L["Options/Actions"] = "Aktionen"
L["Options/Activate when the given aura(s) |cFFFF0000can't|r be found"] = "Aktiviere falls die angegebenen Auren |cFFFF0000nicht|r gefunden werden"
L["Options/Add a new display"] = "Neue Anzeige hinzufügen"
L["Options/Add Dynamic Text"] = "Dynamischen Text hinzufügen"
L["Options/Addon"] = "Addon"
L["Options/Addons"] = "Addons"
L["Options/Add to group %s"] = "Zur Gruppe %s hinzufügen"
L["Options/Add to new Dynamic Group"] = "Neue dynamische Gruppe hinzufügen"
L["Options/Add to new Group"] = "Neue Gruppe hinzufügen"
L["Options/Add Trigger"] = "Auslöser hinzufügen"
L["Options/A group that dynamically controls the positioning of its children"] = "Eine Gruppe, die dynamisch die Position ihrer Kinder steuert"
L["Options/Align"] = "Ausrichten"
L["Options/Allow Full Rotation"] = "Erlaubt eine vollständige Rotation"
L["Options/Alpha"] = "Transparenz"
L["Options/Anchor"] = "Anker"
L["Options/Anchor Point"] = "Ankerpunkt"
L["Options/Angle"] = "Winkel"
L["Options/Animate"] = "Animieren"
L["Options/Animated Expand and Collapse"] = "Erweitern und Verbergen animieren"
L["Options/Animation relative duration description"] = [=[Die Dauer der Animation relativ zur Dauer der Anzeige als Bruchteil (1/2), als Prozent (50%) oder als Dezimal (0.5).
|cFFFF0000Notiz:|r Falls die Anzeige keine Dauer besitzt (zb. Aura ohne Dauer) wird diese Animation nicht ausgeführt.

|cFF4444FFFBeispiel:|r
Falls die Dauer der Animation auf |cFF00CC0010%|r gesetzt wurde und die Dauer der Anzeige 20 Sekunden beträgt (zb. Debuff), dann wird diese Animation über eine Dauer von 2 Sekunden abgespielt.
Falls die Dauer der Animation auf |cFF00CC0010%|r gesetzt wurde undfür die Anzeige keine Dauer bekannt ist (Meistens kann diese auch manuell festgelegt werden) wird diese Animation nicht abgespielt.]=]
L["Options/Animations"] = "Animationen"
L["Options/Animation Sequence"] = "Animations-Sequenz"
L["Options/Aquatic"] = "Wasser"
L["Options/Aura (Paladin)"] = "Paladin Aura"
L["Options/Aura(s)"] = "Auren"
L["Options/Auto"] = "Auto"
L["Options/Auto-cloning enabled"] = "Auto-Klonen aktiviert"
L["Options/Automatic Icon"] = "Automatisches Symbol"
L["Options/Backdrop Color"] = "Hintergrundfarbe" -- Needs review
L["Options/Backdrop Style"] = "Hintergrundstil" -- Needs review
L["Options/Background"] = "Hintergrund"
L["Options/Background Color"] = "Hintergrundfarbe"
L["Options/Background Inset"] = "Hintergrundeinzug"
L["Options/Background Offset"] = "Hintergrundversatz"
L["Options/Background Texture"] = "Hintergrundtextur"
L["Options/Bar Alpha"] = "Balkentransparenz"
L["Options/Bar Color"] = "Balkenfarbe"
L["Options/Bar Color Settings"] = "Balkenfarben Einstellungen" -- Needs review
L["Options/Bar in Front"] = "Balken im Vordergrund" -- Needs review
L["Options/Bar Texture"] = "Balkentextur"
L["Options/Battle"] = "Angriff"
L["Options/Bear"] = "Bär"
L["Options/Berserker"] = "Berserker"
L["Options/Blend Mode"] = "Blendmodus"
L["Options/Blood"] = "Blut"
L["Options/Border"] = "Rand"
L["Options/Border Color"] = "Randfarbe" -- Needs review
L["Options/Border Inset"] = "Rahmeneinlassung" -- Needs review
L["Options/Border Offset"] = "Randversatz"
L["Options/Border Settings"] = "Rahmeneinstellungen" -- Needs review
L["Options/Border Size"] = "Rahmengröße" -- Needs review
L["Options/Border Style"] = "Rahmenstil" -- Needs review
L["Options/Bottom Text"] = "Text unten"
L["Options/Button Glow"] = "Aktionsleisten Glanz"
L["Options/Can be a name or a UID (e.g., party1). Only works on friendly players in your group."] = "Kann ein Name oder eine UID (zb. party1) sein. Funktioniert nur für freundliche Spieler innerhalb deiner Gruppe."
L["Options/Cancel"] = "Abbrechen"
L["Options/Cat"] = "Katze"
L["Options/Change the name of this display"] = "Den Namen der Anzeige ändern"
L["Options/Channel Number"] = "Chatnummer"
L["Options/Check On..."] = "Prüfen auf..."
L["Options/Choose"] = "Auswählen"
L["Options/Choose Trigger"] = "Auslöser Auswählen"
L["Options/Choose whether the displayed icon is automatic or defined manually"] = "Symbol automatisch oder manuell auswählen"
L["Options/Clone option enabled dialog"] = [=[
Eine Option die |cFFFF0000Auto-Klonen|r verwendet wurde aktiviert.

|cFFFF0000Auto-Klonen|r dupliziert automatisch eine Anzeige um mehrere passende Quellen (zb. Auren) darzustellen.
Solange die Anzeige sich nicht in einer |cFF22AA22Dynamischen Gruppe|r befindet, werden alle Klone nur hintereinander angeordnet.

Soll die Anzeige in einer neuen |cFF22AA22Dynamischen Gruppe|r plaziert werden?]=]
L["Options/Close"] = "Schließen"
L["Options/Collapse"] = "Minimieren"
L["Options/Collapse all loaded displays"] = "Alle geladenen Anzeigen minimieren"
L["Options/Collapse all non-loaded displays"] = "Alle nicht geladenen Anzeigen minimieren"
L["Options/Color"] = "Farbe"
L["Options/Compress"] = "Stauchen"
L["Options/Concentration"] = "Konzentration"
L["Options/Constant Factor"] = "Konstanter Faktor"
L["Options/Control-click to select multiple displays"] = "|cFF8080FF(CTRL-Klick)|r Mehrere Anzeigen auswählen"
L["Options/Controls the positioning and configuration of multiple displays at the same time"] = "Eine Gruppe, die die Position und Konfiguration ihrer Kinder kontrolliert"
L["Options/Convert to..."] = "Umwandeln zu..."
L["Options/Cooldown"] = "Abklingzeit"
L["Options/Copy"] = "Kopieren"
L["Options/Copy settings from..."] = "Kopiere Einstellungen von ..."
L["Options/Copy settings from another display"] = "Kopiere Einstellungen von einer anderen Anzeige"
L["Options/Copy settings from %s"] = "Kopiere Einstellungen von %s"
L["Options/Count"] = "Anzahl"
L["Options/Creating buttons: "] = "Erstelle Schaltflächen:"
L["Options/Creating options: "] = "Erstelle Optionen:"
L["Options/Crop X"] = "Abschneiden (X)"
L["Options/Crop Y"] = "Abschneiden (Y)"
L["Options/Crusader"] = "Kreuzfahrer"
L["Options/Custom Code"] = "Benutzerdefinierter Code"
L["Options/Custom Trigger"] = "Benutzerdefinierter Auslöser"
L["Options/Custom trigger event tooltip"] = [=[Wähle die Events, die den benutzerdefinierten Auslöser aufrufen sollen.
Mehrere Events können durch Komma oder Leerzeichen getrennt werden.

|cFF4444FFBeispiel:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
L["Options/Custom trigger status tooltip"] = [=[Wähle die Events, die den benutzerdefinierten Auslöser aufrufen sollen.
Da es sich um einen Zustands-Auslöser handelt, kann es passieren, dass WeakAuras nicht die in der WoW-API spezifizierten Argumente übergibt.
Mehrere Events können durch Komma oder Leerzeichen getrennt werden.

|cFF4444FFBeispiel:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
L["Options/Custom Untrigger"] = "Benutzerdefinierter Umkehr-Auslöser"
L["Options/Custom untrigger event tooltip"] = [=[Wähle die Events, die den benutzerdefinierten Umkehr-Auslöser aufrufen sollen.
Diese Events müssen nicht denen der benutzerdefinierten Auslöser entsprechen.
Mehrere Events können durch Komma oder Leerzeichen getrennt werden.

|cFF4444FFBeispiel:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
L["Options/Death"] = "Tod"
L["Options/Death Rune"] = "Todes Rune"
L["Options/Debuff Type"] = "Debufftyp"
L["Options/Defensive"] = "Defensive"
L["Options/Delete"] = "Löschen"
L["Options/Delete all"] = "Alle löschen"
L["Options/Delete children and group"] = "Lösche Gruppe und ihre Kinder"
L["Options/Deletes this display - |cFF8080FFShift|r must be held down while clicking"] = "|cFF8080FF(SHIFT-Klick)|r Lösche Anzeige"
L["Options/Delete Trigger"] = "Auslöser löschen"
L["Options/Desaturate"] = "Entsättigen"
L["Options/Devotion"] = "Hingabe"
L["Options/Disabled"] = "Deaktiviert"
L["Options/Discrete Rotation"] = "Rotation um x90°"
L["Options/Display"] = "Anzeige"
L["Options/Display Icon"] = "Anzeigesymbol"
L["Options/Display Text"] = "Anzeige-Text"
L["Options/Distribute Horizontally"] = "Horizontal verteilen"
L["Options/Distribute Vertically"] = "Vertical verteilen"
L["Options/Do not copy any settings"] = "Keine Einstellungen kopieren"
L["Options/Do not group this display"] = "Anzeige nicht gruppieren"
L["Options/Duplicate"] = "Duplizieren"
L["Options/Duration Info"] = "Dauerinformationen"
L["Options/Duration (s)"] = "Dauer (s)"
L["Options/Dynamic Group"] = "Dynamische Gruppe"
L["Options/Dynamic text tooltip"] = [=[Es werden einige spezielle Codes für dynamischen Text angeboten:

|cFFFF0000%p|r - Fortschritt - Die verbleibende Dauer der Anzeige
|cFFFF0000%t|r - Gesamt - Die maximale Dauer der Anzeige
|cFFFF0000%n|r - Name - Der (dynamische) Name der Anzeige (zb. Auraname) oder die ID der Anzeige
|cFFFF0000%i|r - Symbol - Das (dynamische) Symbol der Anzeige
|cFFFF0000%s|r - Stacks - Die Anzahl der Stacks
|cFFFF0000%c|r - Custom - Verwendet den String-Rückgabewert der benutzerdefinierten Lua-Funktion]=]
L["Options/Enabled"] = "Aktivieren"
L["Options/Enter an aura name, partial aura name, or spell id"] = "Auraname, Teilname oder Zauber-ID"
L["Options/Event Type"] = "Ereignistyp"
L["Options/Expand"] = "Erweitern"
L["Options/Expand all loaded displays"] = "Alle geladenen Anzeigen erweitern"
L["Options/Expand all non-loaded displays"] = "Alle nicht geladenen Anzeigen erweitern"
L["Options/Expand Text Editor"] = "Erweiterter Texteditor"
L["Options/Expansion is disabled because this group has no children"] = "Erweitern nicht möglich, da Gruppe keine Kinder besitzt"
L["Options/Export"] = "Exportieren"
L["Options/Export to Lua table..."] = "Als Lua-Tabelle exportieren..."
L["Options/Export to string..."] = "Als Klartext exportieren..."
L["Options/Fade"] = "Verblassen"
L["Options/Finish"] = "Endanimation"
L["Options/Fire Resistance"] = "Feuerresistenz"
L["Options/Flight(Non-Feral)"] = "Flug"
L["Options/Font"] = "Schriftart"
L["Options/Font Flags"] = "Schrifteinstellungen" -- Needs review
L["Options/Font Size"] = "Schriftgröße"
L["Options/Font Type"] = "Schriftart" -- Needs review
L["Options/Foreground Color"] = "Vordergrundfarbe"
L["Options/Foreground Texture"] = "Vordergrundtextur"
L["Options/Form (Druid)"] = "Form (Druide)"
L["Options/Form (Priest)"] = "Form (Priester)"
L["Options/Form (Shaman)"] = "Form (Schamane)"
L["Options/Form (Warlock)"] = "Form (Hexenmeister)"
L["Options/Frame"] = "Frame"
L["Options/Frame Strata"] = "Frame-Schicht"
L["Options/Frost"] = "Frost"
L["Options/Frost Resistance"] = "Frostresistenz"
L["Options/Full Scan"] = "Kompletter Scan"
L["Options/Ghost Wolf"] = "Geisterwolf"
L["Options/Glow Action"] = "Leuchtaktion"
L["Options/Group aura count description"] = [=[
Anzahl an Gruppen-/Raidmitgliedern die von einer der Auren betroffen sein muss um den Trigger auszulösen.
Es kann entweder ein fixer Wert sein (zb. 5) oder relativ sein (zb. 50%).
Falls die Zahl im Format als Bruch (1/2), Prozent (50%) oder Dezimal (0.5) vorliegt, wird sie relativ zur Größe der aktuellen Gruppenstärke gesetzt.

|cFF4444FFBeispiel:|r
 > 0 - Lößt aus, wenn jemand betroffen ist
 = 100%% - Lößt aus, wenn alle betroffen sind
 != 2 - Lößt aus, wenn weniger oder mehr als 2 Spieler betroffen sind
 <= 0.8 - Lößt aus, wenn 80%% betroffen sind (4/5, 8/10 oder 20/25)
 > 1/2 - Lößt aus, wenn die Hälfte der Mitglieder betroffen sind
 >= 0 - Lößt immer aus]=]
L["Options/Group Member Count"] = "Gruppengröße"
L["Options/Group (verb)"] = "Gruppe"
L["Options/Height"] = "Höhe"
L["Options/Hide this group's children"] = "Kinder der Gruppe verbergen"
L["Options/Hide When Not In Group"] = "Falls nicht in Gruppe, dann verbergen"
L["Options/Horizontal Align"] = "Horizontal Ausrichten"
L["Options/Icon Info"] = "Symbolinfo"
L["Options/Ignored"] = "Ignoriert"
L["Options/Ignore GCD"] = "Globale Abklingzeit ignorieren"
L["Options/%i Matches"] = "%i Treffer"
L["Options/Import"] = "Importieren"
L["Options/Import a display from an encoded string"] = "Anzeige von Klartext importieren"
L["Options/Justify"] = "Ausrichten"
L["Options/Left Text"] = "Text links"
L["Options/Load"] = "Laden"
L["Options/Loaded"] = "Geladen"
L["Options/Main"] = "Hauptanimation"
L["Options/Main Trigger"] = "Hauptauslößer"
L["Options/Mana (%)"] = "Mana (%)"
L["Options/Manage displays defined by Addons"] = "Bearbeite Anzeigen von externen Addons"
L["Options/Message Prefix"] = "Nachrichtenprefix"
L["Options/Message Suffix"] = "Nachrichtensuffix"
L["Options/Metamorphosis"] = "Metamorphose"
L["Options/Mirror"] = "Spiegeln"
L["Options/Model"] = "Modell"
L["Options/Moonkin/Tree/Flight(Feral)"] = "Mondkin"
L["Options/Move Down"] = "Runter bewegen"
L["Options/Move this display down in its group's order"] = "Anzeige innerhalb der Gruppe nach unten bewegen"
L["Options/Move this display up in its group's order"] = "Anzeige innerhalb der Gruppe nach oben bewegen"
L["Options/Move Up"] = "Hoch bewegen"
L["Options/Multiple Displays"] = "Mehrere Anzeigen"
L["Options/Multiple Triggers"] = "Mehrere Auslöser"
L["Options/Multiselect ignored tooltip"] = [=[
|cFFFF0000Ignoriert|r - |cFF777777Einfach|r - |cFF777777Mehrfach|r
Diese Option wird nicht verwendet um zu prüfen wann die Anzeige geladen wird.]=]
L["Options/Multiselect multiple tooltip"] = [=[
|cFFFF0000Ignoriert|r - |cFF777777Einfach|r - |cFF777777Mehrfach|r
Beliebige Anzahl an Werten zum vergleichen können ausgewählt werden.]=]
L["Options/Multiselect single tooltip"] = [=[
|cFFFF0000Ignoriert|r - |cFF777777Einfach|r - |cFF777777Mehrfach|r
Nur ein Wert kann ausgewählt werden.]=]
L["Options/Must be spelled correctly!"] = "Muss korrekt geschrieben sein!"
L["Options/Name Info"] = "Namensinfo"
L["Options/Negator"] = "Negator"
L["Options/New"] = "Neu"
L["Options/Next"] = "Weiter"
L["Options/No"] = "Nein"
L["Options/No Children"] = "Keine Kinder"
L["Options/Not all children have the same value for this option"] = "Nicht alle Kinder besitzten den selben Wert"
L["Options/Not Loaded"] = "Nicht geladen"
L["Options/No tooltip text"] = "Kein Tooltip"
L["Options/% of Progress"] = "Fortschritt in %"
L["Options/Okay"] = "Okey"
L["Options/On Hide"] = "Beim Ausblenden"
L["Options/Only match auras cast by people other than the player"] = "Nur Auren von anderen Spielern"
L["Options/Only match auras cast by the player"] = "Nur Auren vom Spieler selbst"
L["Options/On Show"] = "Beim Einblenden"
L["Options/Operator"] = "Operator"
L["Options/or"] = "oder"
L["Options/Orientation"] = "Orientierung"
L["Options/Other"] = "Sonstige"
L["Options/Outline"] = "Umriss"
L["Options/Own Only"] = "Nur eigene"
L["Options/Player Character"] = "Spieler Charakter (PC)"
L["Options/Play Sound"] = "Sound abspielen"
L["Options/Presence (DK)"] = "Präsenz (Todesritter)"
L["Options/Presence (Rogue)"] = "Präsenz (Schurke)"
L["Options/Prevents duration information from decreasing when an aura refreshes. May cause problems if used with multiple auras with different durations."] = "Verhindert, dass die Anzeige der Dauer der Aura sich verringert beim erneuern. Kann zu Problemen bei mehreren Auren führen!"
L["Options/Primary"] = "Erste"
L["Options/Progress Bar"] = "Fortschrittsbalken"
L["Options/Progress Texture"] = "Fortschrittstextur"
L["Options/Put this display in a group"] = "Anzeige zu einer Gruppe hinzufügen"
L["Options/Ready For Use"] = "Benutzterfertig"
L["Options/Re-center X"] = "Zentrum (X)"
L["Options/Re-center Y"] = "Zentrum (Y)"
L["Options/Remaining Time Precision"] = "Genauigkeit der verbleibenden Zeit"
L["Options/Remove this display from its group"] = "Anzeige aus Gruppe entfernen"
L["Options/Rename"] = "Umbennen"
L["Options/Requesting display information"] = "Forde Anzeigeinformationen von %s an"
L["Options/Required For Activation"] = "Vorrausgesetzt für Aktivierung"
L["Options/Retribution"] = "Vergeltung"
L["Options/Right-click for more options"] = "|cFF8080FF(Right-Klick)|r Mehr Optionen"
L["Options/Right Text"] = "Text rechts"
L["Options/Rotate"] = "Rotieren"
L["Options/Rotate In"] = "Nach innen rotieren"
L["Options/Rotate Out"] = "Nach außen rotieren"
L["Options/Rotate Text"] = "Text rotieren"
L["Options/Rotation"] = "Rotation"
L["Options/Same"] = "Gleich"
L["Options/Search"] = "Suchen"
L["Options/Secondary"] = "Zweite"
L["Options/Send To"] = "Senden an"
L["Options/Set tooltip description"] = "Tooltipbeschreibung festlegen"
L["Options/Shadow Dance"] = "Schattentanz"
L["Options/Shadowform"] = "Schattenform"
L["Options/Shadow Resistance"] = "Schattenresistenz"
L["Options/Shift-click to create chat link"] = "|cFF8080FF(Shift-Klick)|r Chatlink erstellen"
L["Options/Show all matches (Auto-clone)"] = "Alle Treffer anzeigen (Auto-Klonen)"
L["Options/Show players that are |cFFFF0000not affected"] = "Zeige Spieler die |cFFFF0000nicht|r betroffen sind"
L["Options/Shows a 3D model from the game files"] = "Zeigt ein 3D Modell"
L["Options/Shows a custom texture"] = "Zeigt eine benutzerdefinierte Textur"
L["Options/Shows a progress bar with name, timer, and icon"] = "Zeigt einen Fortschrittsbalken mit Name, Zeitanzeige und Symbol"
L["Options/Shows a spell icon with an optional a cooldown overlay"] = "Zeigt ein (Zauber-) Symbol mit optionalem Abklingzeit-Overlay"
L["Options/Shows a texture that changes based on duration"] = "Zeigt eine Textur, die sich über die Zeit verändert"
L["Options/Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "Zeigt ein oder mehrere Zeilen Text an, der dynamische Informationen anzeigen kann, z.B. Fortschritt oder Stacks"
L["Options/Shows the remaining or expended time for an aura or timed event"] = "Zeigt die verbleibende oder verstrichene Zeit einer Aura oder eines zeitlichen Ereignisses"
L["Options/Show this group's children"] = "Kinder der Gruppe anzeigen"
L["Options/Size"] = "Größe"
L["Options/Slide"] = "Gleiten"
L["Options/Slide In"] = "Einschieben"
L["Options/Slide Out"] = "Ausschieben"
L["Options/Sort"] = "Sortieren"
L["Options/Sound"] = "Sound"
L["Options/Sound Channel"] = "Soundkanal"
L["Options/Sound File Path"] = "Sounddatei"
L["Options/Space"] = "Abstand"
L["Options/Space Horizontally"] = "Horizontaler Abstand"
L["Options/Space Vertically"] = "Verticaler Abstand"
L["Options/Spell ID"] = "Zauber-ID"
L["Options/Spell ID dialog"] = [=[
Es wurde eine Aura/Zauber/ect. über |cFFFF0000Spell-ID|r definiert.

|cFF8800FFWeakAuras|r kann standardmäßig aus Performancegründen nicht zwischen Auren/Zaubern/ect. mit selben Namen aber unterschiedlichen |cFFFF0000Spell-IDs|r unterscheiden.
Wird allerdings |cFFFF0000Alle Auren scannen (CPU-Intensiv)|r aktiviert kann |cFF8800FFWeakAuras|r explizit nach bestimmten |cFFFF0000Spell-IDs|r suchen.

Soll |cFFFF0000Alle Auren scannen (CPU-Intensiv)|r aktiviert werden um diese |cFFFF0000Spell-ID|r zu finden?]=]
L["Options/Stack Count"] = "Stackanzahl"
L["Options/Stack Count Position"] = "Stackposition"
L["Options/Stack Info"] = "Stackinfo"
L["Options/Stacks Settings"] = "Stacks Einstellungen"
L["Options/Stagger"] = "Taumeln"
L["Options/Stance (Warrior)"] = "Haltung (Krieger)"
L["Options/Start"] = "Start"
L["Options/Stealable"] = "Zauberraub"
L["Options/Stealthed"] = "Getarnt"
L["Options/Sticky Duration"] = "Tesa-Dauer"
L["Options/Temporary Group"] = "Temporäre Gruppe"
L["Options/Text"] = "Text"
L["Options/Text Color"] = "Textfarbe"
L["Options/Text Position"] = "Textposition"
L["Options/Text Settings"] = "Text Einstellungen"
L["Options/Texture"] = "Textur"
L["Options/The children of this group have different display types, so their display options cannot be set as a group."] = "Anzeigeoptionen für diese Gruppe können nicht dargetsellt werden, weil die Kinder dieser Gruppe verschiedene Anzeigetypen haben."
L["Options/The duration of the animation in seconds."] = "Die Dauer der Animation in Sekunden."
L["Options/The type of trigger"] = "Auslösertyp"
L["Options/This condition will not be tested"] = "Diese Bedingungen werden nicht getestet"
L["Options/This display is currently loaded"] = "Diese Anzeige ist zur Zeit geladen"
L["Options/This display is not currently loaded"] = "Diese Anzeige ist zur Zeit nicht geladen"
L["Options/This display will only show when |cFF00FF00%s"] = "Diese Anzeige wird nur eingezeigt, wenn |cFF00FF00%s"
L["Options/This display will only show when |cFFFF0000 Not %s"] = "Diese Anzeige wird nur eingezeigt, wenn |cFF00FF00 nicht %s"
L["Options/This region of type \"%s\" has no configuration options."] = "Diese Region vom Typ \"%s\" besitzt keine Einstellungsmöglichkeiten." -- Needs review
L["Options/Time in"] = "Zeit in"
L["Options/Timer"] = "Zeitgeber"
L["Options/Timer Settings"] = "Timer Einstellungen"
L["Options/Toggle the visibility of all loaded displays"] = "Sichtbarkeit aller geladener Anzeigen umschalten"
L["Options/Toggle the visibility of all non-loaded displays"] = "Sichtbarkeit aller nicht geladener Anzeigen umschalten"
L["Options/Toggle the visibility of this display"] = "Sichtbarkeit aller Anzeigen umschalten"
L["Options/to group's"] = "an Gruppe"
L["Options/Tooltip"] = "Tooltip"
L["Options/Tooltip on Mouseover"] = "Tooltip bei Mausberührung"
L["Options/Top Text"] = "Text oben"
L["Options/to screen's"] = "an Bildschirm"
L["Options/Total Time Precision"] = "Gesamtzeit Genauigkeit"
L["Options/Tracking"] = "Aufspüren"
L["Options/Travel"] = "Reise"
L["Options/Trigger"] = "Auslöser"
L["Options/Trigger %d"] = "Auslöser %d"
L["Options/Triggers"] = "Auslöser"
L["Options/Type"] = "Typ"
L["Options/Ungroup"] = "Nicht gruppiert"
L["Options/Unholy"] = "Unheilig"
L["Options/Unit Exists"] = "Einheit existiert"
L["Options/Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "Anders als die Start- und Endanimation wird die Hauptanimation immer wieder wiederholt, bis die Anzeige in den Endstatus versetzt wird."
L["Options/Unstealthed"] = "Entarnt"
L["Options/Update Custom Text On..."] = "Aktualisiere benutzerdefinierten Text bei..."
L["Options/Use Full Scan (High CPU)"] = "Alle Auren scannen (CPU-Intensiv)"
L["Options/Use tooltip \"size\" instead of stacks"] = "Benutzte Tooltipgröße anstatt Stacks"
L["Options/Vertical Align"] = "Vertikale Ausrichtung"
L["Options/View"] = "Anzeigen"
L["Options/Width"] = "Breite"
L["Options/X Offset"] = "X-Versatz"
L["Options/X Scale"] = "Skalierung (X)"
L["Options/Yes"] = "Ja"
L["Options/Y Offset"] = "Y-Versatz"
L["Options/Y Scale"] = "Skalierung (Y)"
L["Options/Z Offset"] = "Z-Versatz"
L["Options/Zoom"] = "Zoom"
L["Options/Zoom In"] = "Einzoomen"
L["Options/Zoom Out"] = "Auszoomen"
L["Tutorials/Actions and Animations: 1/7"] = "Aktionen und Animationen: 1/7"
L["Tutorials/Actions and Animations: 2/7"] = "Aktionen und Animationen: 2/7"
L["Tutorials/Actions and Animations: 3/7"] = "Aktionen und Animationen: 3/7"
L["Tutorials/Actions and Animations: 4/7"] = "Aktionen und Animationen: 4/7"
L["Tutorials/Actions and Animations: 5/7"] = "Aktionen und Animationen: 5/7"
L["Tutorials/Actions and Animations: 6/7"] = "Aktionen und Animationen: 6/7"
L["Tutorials/Actions and Animations: 7/7"] = "Aktionen und Animationen: 7/7"
L["Tutorials/Actions and Animations Text"] = [=[Um die Animation zu testen muss die Anzeige versteckt und wieder eingeblendet werden. Dies lässt sich über den Ansicht-Knopf in der Seitenleiste erreichen.

Durch mehrmaliges Betätigen lässt sich die Start-Animation sehen.]=] -- Needs review
L["Tutorials/Activation Settings: 1/5"] = "Aktivierungseinstellungen: 1/5"
L["Tutorials/Activation Settings: 2/5"] = "Aktivierungseinstellungen: 2/5"
L["Tutorials/Activation Settings: 3/5"] = "Aktivierungseinstellungen: 3/5"
L["Tutorials/Activation Settings: 4/5"] = "Aktivierungseinstellungen: 4/5"
L["Tutorials/Activation Settings: 5/5"] = "Aktivierungseinstellungen: 5/5"
L["Tutorials/Activation Settings Text"] = "Da du ein %s bist, kannst du die Spielerklassen-Optionen aktivieren und %s auswählen." -- Needs review
L["Tutorials/Auto-cloning: 1/10"] = "Auto-Klonen: 1/10" -- Needs review
L["Tutorials/Auto-cloning 1/10 Text"] = [=[Die größte in |cFF8800FF1.4|r enthaltene Neuerung ist |cFFFF0000Auto-Klonen|r. |cFFFF0000Auto-Klonen|r erlaubt deinen Anzeigen sich automatisch zu vervielfältigen, um Informationen mehrerer Quellen anzuzeigen. Einer Dynamischen Gruppe hinzugefügt erlaubt dies die Anzeige umfangreicher dynamischer Informationssätze.

Es gibt drei Auslöser-Typen, die |cFFFF0000Auto-Klonen|r unterstützen: Voll-Scan Auras, Gruppen-Auras, and Mehrziel-Auras.]=] -- Needs review
L["Tutorials/Beginners Finished Text"] = [=[Hiermit ist die Einführung abgeschlossen. Allerdings hast du gerade mal einen kleinen Einblick in die Macht von |cFF8800FFWeakAuras|r bekommen.

Zukünftig werden |cFFFFFF00Weitere|r |cFFFF7F00Fortgeschrittene|r |cFFFF0000Tutorials|r veröffentlicht, die einen tieferen Einblick in |cFF8800FFWeakAuras|r endlose Möglichkeiten bieten werden.]=] -- Needs review
L["Tutorials/Beginners Guide Desc"] = "Einführung" -- Needs review
L["Tutorials/Beginners Guide Desc Text"] = "Eine Einführung in dir Grundeinstellungsmöglichkeiten von WeakAuras" -- Needs review
L["Tutorials/Create a Display: 1/5"] = "Eine Anzeige erzeugen: 1/5" -- Needs review
L["Tutorials/Create a Display: 2/5"] = "Eine Anzeige erzeugen: 2/5" -- Needs review
L["Tutorials/Create a Display: 3/5"] = "Eine Anzeige erzeugen: 3/5" -- Needs review
L["Tutorials/Create a Display: 4/5"] = "Eine Anzeige erzeugen: 4/5" -- Needs review
L["Tutorials/Create a Display: 5/5"] = "Eine Anzeige erzeugen: 5/5" -- Needs review
L["Tutorials/Create a Display Text"] = [=[Obwohl das Anzeige-Tab Schieberegler zur Steuerung von Breite, Höhe und X-/Y-Positionierung besitzt, gibt es eine einfachere Möglichkeit deine Anzeige zu bewegen und in der Größe anzupassen.

Du kannst deine Anzeige einfach anklicken und irgendwo auf den Bildschirm ziehen oder ihre Ecken anklicken und daran ziehen, um die Größe zu verändern.

Ebenso kannst du Shift drücken, um den Bewegungs-/Größeneinstellungsrahmen für genauere Positionierung zu verstecken.]=] -- Needs review
L["Tutorials/Display Options: 1/4"] = "Anzeige-Einstellungen: 1/4" -- Needs review
L["Tutorials/Display Options 1/4 Text"] = "Wähle jetzt eine Fortschrittsbalken-Anzeige aus (oder lege eine neue an)." -- Needs review
L["Tutorials/Display Options: 2/4"] = "Anzeige-Einstellungen: 2/4" -- Needs review
L["Tutorials/Display Options 2/4 Text"] = [=[|cFFFFFFFFFortschrittsbalken-|r und |cFFFFFFFFSymbol-Anzeigen|r haben nun eine Einstellungsmöglichkeit Tooltips beim Darüberhalten der Maus anzuzeigen.

Diese Einstellung ist nur verfügbar, wenn die Anzeige einen Auslöser der auf einer Aura, einem Gegenstand, oder einem Zauber basiert besitzt.]=] -- Needs review
L["Tutorials/Display Options: 4/4"] = "Anzeige-Einstellungen: 4/4" -- Needs review
L["Tutorials/Display Options 4/4 Text"] = "Zu guter letzt erlaubt der neue Anzeigentyp |cFFFFFFFFModell|r jedes beliebige 3D Modell aus den Spieldateien zu nutzen." -- Needs review
L["Tutorials/Dynamic Group Options: 2/4"] = "Dynamische Gruppen Einstellungen: 2/4" -- Needs review
L["Tutorials/Dynamic Group Options 2/4 Text"] = [=[Die größte Verbesserung der |cFFFFFFFFDynamischen Gruppen|r ist eine neue Auswahlmöglichkeit für die Wachstumseinstellung.

Wähle \"Kreisförmig\" um sie im Einsatz zu sehen.]=] -- Needs review
L["Tutorials/Dynamic Group Options: 3/4"] = "Dynamische Gruppen Einstellungen: 3/4" -- Needs review
L["Tutorials/Dynamic Group Options 3/4 Text"] = [=[Die Konstanter Faktor Einstellung ermöglicht dir die Kontrolle darüber, wie deine kreisförmige Gruppe wächst.

Eine kreisförmige Gruppe mit konstantem Abstand gewinnt an Radius je mehr Anzeigen hinzugefügt werden, während ein konstanter Radius dazu führt, dass Anzeigen näher aneinander rücken, je mehr hinzugefügt werden.]=] -- Needs review
L["Tutorials/Dynamic Group Options: 4/4"] = "Dynamische Gruppen Einstellungen: 4/4" -- Needs review
L["Tutorials/Dynamic Group Options 4/4 Text"] = [=[Dynamische Gruppen können ihre Elemente nun automatisch nach Verbleibender Zeit sortieren..

Anzeigen, die keine Verbleibende Zeit besitzen, werden je nach Auswahl von \"Aufsteigend\" oder \"Absteigend\" entsprechend oben oder unten plaziert..]=] -- Needs review
L["Tutorials/Finished"] = "Abgeschlossen" -- Needs review
L["Tutorials/Full-scan Auras: 2/10"] = "Komplett gescannte Auren: 2/10" -- Needs review
L["Tutorials/Full-scan Auras 2/10 Text"] = "Aktiviere zunächst die Kompletter Scan Einstellung." -- Needs review
L["Tutorials/Full-scan Auras: 3/10"] = "Komplett gescannte Auren: 3/10" -- Needs review
L["Tutorials/Full-scan Auras 3/10 Text"] = [=[|cFFFF0000Auto-Klonen|r kann nun über die \"%s\"-Einstellung aktiviert werden.

Dies sorgt dafür, dass für jeden den Parametern entsprechenden Treffer eine neue Anzeige angelegt wird.]=] -- Needs review
L["Tutorials/Full-scan Auras: 4/10"] = "Komplett gescannte Auren: 4/10" -- Needs review
L["Tutorials/Full-scan Auras 4/10 Text"] = [=[Ein Popup sollte aufgetaucht sein, das dich darauf hinweist, dass |cFFFF0000auto-geklonte|r Anzeigen im Allgemeinen in Dynamischen Gruppen verwendet werden sollten.

Drücke \"Ja\"um |cFF8800FFWeakAuras|r zu erlauben deine Anzeige automatisch in eine Dynamische Gruppe zu verschieben.]=] -- Needs review
L["Tutorials/Full-scan Auras: 5/10"] = "Komplett gescannte Auren: 5/10" -- Needs review
L["Tutorials/Full-scan Auras 5/10 Text"] = "Deaktiviere die Kompletter Scan Einstellung um andere Einheit Einstellungen zu reaktivieren." -- Needs review
L["Tutorials/Group Auras 6/10"] = "Gruppen Auren: 6/10" -- Needs review
L["Tutorials/Group Auras 6/10 Text"] = "Wähle jetzt \"Gruppe\" für die Einheiten-Einstellung." -- Needs review
L["Tutorials/Group Auras: 7/10"] = "Gruppen Auren: 7/10" -- Needs review
L["Tutorials/Group Auras 7/10 Text"] = [=[|cFFFF0000Auto-Klonen|r wird wieder über die \"%s\" Einstellung aktiviert.

Eine neue Anzeige wird für jedes Gruppenmitglied erstellt, das von der/den angegebenen Aura/Auren betroffen ist.]=] -- Needs review
L["Tutorials/Group Auras: 8/10"] = "Gruppen Auren: 8/10" -- Needs review
L["Tutorials/Group Auras 8/10 Text"] = "Aktivieren der %s Einstellung für eine Gruppen Aura mit aktiviertem |cFFFF0000Auto-Klonen|r sorgt dafür, dass für jedes Gruppenmitglied, das |cFFFFFFFFnicht|r von der/den angegebenen Aura/Auren betroffen ist, eine Anzeige erstellt wird." -- Needs review
L["Tutorials/Home"] = "Startseite" -- Needs review
L["Tutorials/Multi-target Auras: 10/10"] = "Mehrfachziel-Auren: 10/10" -- Needs review
L["Tutorials/Multi-target Auras 10/10 Text"] = [=[|cFFFF0000Auto-Klonen|r ist für Mehrfachziel-Auren standardmäßig aktiviert.

Auslöser für Mehrfachziel-Auren unterscheiden sich dadurch von normalen Aura-Auslösern, dass sie auf Kampf-Events reagieren, was heißt, dass sie durch Auren auf Gegnern ausgelöst werden, die niemand als Ziel hat (obwohl gewisse dynamische Informationen nicht verfügbar sind, solange niemand in deiner Gruppe den Gegner als Ziel hat).

Deshalb sind Mehrfachziel-Auren eine gute Wahl zur Verfolgung von DoTs auf mehreren Gegnern.]=] -- Needs review
L["Tutorials/Multi-target Auras: 9/10"] = "Mehrfachziel-Auren: 9/10" -- Needs review
L["Tutorials/Multi-target Auras 9/10 Text"] = "Wähle zum Abschluss\"Mehrfachziel\" bei der Einheiten Einstellung." -- Needs review
L["Tutorials/New in 1.4:"] = "Neu in 1.4:" -- Needs review
L["Tutorials/New in 1.4 Desc:"] = "Neu in 1.4" -- Needs review
L["Tutorials/New in 1.4 Desc Text"] = "Wirf einen Blick auf die neuen Features in WeakAuras 1.4" -- Needs review
L["Tutorials/New in 1.4 Finnished Text"] = [=[Selbstverständlich beinhaltet |cFF8800FFWeakAuras 1.4|r mehr neue Features als auf einmal abgedeckt werden können, auch ohne die zahllosen Bugfixes und Effizienzsteigerungen zu erwähnen.

Hoffentlich hat diese Einführung dich wenigstens über die wichtigsten neuen Funktionen aufgeklärt, die dir zur Verfügung stehen.

Wir danken dir vielmals für die Nutzung von |cFF8800FFWeakAuras|r!]=] -- Needs review
L["Tutorials/New in 1.4 Text1"] = [=[Version 1.4 von |cFF8800FFWeakAuras|r führt mehrere neu mächtige Features ein.

Diese Einführung bietet einen Überblick der wichtigsten neuen Funktionen und deren Nutzung.]=] -- Needs review
L["Tutorials/New in 1.4 Text2"] = "Lege zunächst eine neue Anzeige zu Demonstrationszwecken an." -- Needs review
L["Tutorials/Previous"] = "Zurück" -- Needs review
L["Tutorials/Trigger Options: 1/4"] = "Auslöser Einstellungen: 1/4" -- Needs review
L["Tutorials/Trigger Options 1/4 Text"] = [=[Zusätzlich zu \"Mehrfachziel\" gibt es noch eine Alternative für die Einheiten Einstellung: Konkrete Einheit.

Wähle sie aus, um ein neues Textfeld anlegen zu können.]=] -- Needs review
L["Tutorials/Trigger Options: 2/4"] = "Auslöser Einstellungen: 2/4" -- Needs review
L["Tutorials/Trigger Options 2/4 Text"] = [=[In diesem Feld kannst du den Namen eines beliebigen Spielers in deiner Gruppe, oder einer speziellen Unit ID angeben. Unit IDs wie \"boss1\", \"boss2\", usw. sind besonders für Schlachtzugsbegegnungen sehr hilfreich.

Alle Auslöser, die die Angabe einer Einheit ermöglichen (nicht nur Aura Auslöser) unterstützen nun die Konkrete Einheit Einstellung.]=] -- Needs review
L["Tutorials/Trigger Options: 3/4"] = "Auslöser Einstellungen: 3/4" -- Needs review
L["Tutorials/Trigger Options 3/4 Text"] = [=[|cFF8800FFWeakAuras 1.4|r bringt auch ein paar neue Auslöser-Typen mit sich.

Wähle die Status Kategorie um einen Blick auf sie zu werfen.]=] -- Needs review
L["Tutorials/Trigger Options: 4/4"] = "Auslöser Einstellungen: 4/4" -- Needs review
L["Tutorials/Trigger Options 4/4 Text"] = [=[Der |cFFFFFFFFEinheitencharakterisierungs|r Auslöser ermöglicht die Festelellung von Namen, Klasse, Feindseligkeit und ob es sich um einen Spieler- oder Nicht-Spieler-Charakter handelt.

Auslöser für |cFFFFFFFFGlobale Abklingzeit|r und |cFFFFFFFFSwing Timer|r ergänzen den Zauber Auslöser.]=] -- Needs review
L["Tutorials/WeakAuras Tutorials"] = "WeakAuras Einführungen" -- Needs review
L["Tutorials/Welcome"] = "Willkommen" -- Needs review
L["Tutorials/Welcome Text"] = [=[Willkommen zur |cFF8800FFWeakAuras|r Einführung.

Diese Einführung wird dir zeigen, wie WeakAuras genutzt werden kann und dabei grundlegende Einstellungen erläutern.]=] -- Needs review



