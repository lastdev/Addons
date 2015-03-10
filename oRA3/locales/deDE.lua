
if GetLocale() ~= "deDE" then return end
local _, tbl = ...
local L = tbl.locale

L["add"] = "Hinzufügen"
L["autoLootMethod"] = "Die Plündermethode bei Gruppenbeitritt automatisch setzen"
L["autoLootMethodDesc"] = "Lässt oRA3 die Plündermethode bei Gruppen- oder Schlachtzugsbeitritt automatisch auf unten angegebenes setzen."
L["average"] = "Durchschnitt"
L["barSettings"] = "Leisteneinstellungen"
L["blizzMainTank"] = "Blizzard Main Tank"
L["broken"] = "Kaputt"
L["byGuildRank"] = "Nach Gildenrang"
L["center"] = "Mittig"
L["cooldowns"] = "Cooldowns"
L["cooldownSettings"] = "Auswahl der Cooldowns"
L["customColor"] = "Eigene Farbe"
L["deleteButtonHelp"] = "Entfernt den Spieler aus der Tankliste. Sobald ein Spieler einmal entfernt wurde, wird er für die Dauer des Schlachtzugs nicht mehr automatisch hinzugefügt. Du kannst ihn aber wieder manuell zur Tankliste hinzufügen."
L["demoteEveryone"] = "Massendegradierung"
L["demoteEveryoneDesc"] = "Degradiert jeden in deiner aktuellen Gruppe."
L["disbandGroup"] = "Gruppe auflösen"
L["disbandGroupDesc"] = [=[Löst die Gruppe oder den Schlachtzug auf, indem nacheinander jeder rausgeworfen wird, bis nur noch du übrig bist.

Da dies sehr destruktiv sein kann, wirst du eine Bestätigung sehen. Halte STRG gedrückt, um diesen Dialog zu umgehen.]=]
L["disbandGroupWarning"] = "Bist du sicher, dass du die Gruppe auflösen willst?"
L["disbandingGroupChatMsg"] = "Gruppe aufgelöst."
L["durability"] = "Haltbarkeit"
L["duration"] = "Dauer"
L["ensureRepair"] = "Stellt sicher, dass Gildenreparatur für alle im Schlachtzug anwesenden Ränge aktiviert ist"
L["ensureRepairDesc"] = "Falls du Gildenleiter und zugleich Raidleiter/Assistent der aktuellen Schlachtgruppe bist, wirst du die Gildenreparatur für die Dauer der Gruppe aktivieren (bis 300g). Sobald du die Gruppe verlässt, wird der vorherige Status wieder gesetzt, |cffff4411sofern du nicht aus dem Spiel geflogen bist.|r"
L["font"] = "Schriftart" -- Needs review
L["fontSize"] = "Schriftgröße" -- Needs review
L["gear"] = "Ausrüstung" -- Needs review
L["growUpwards"] = "Nach oben erweitern"
L["guildKeyword"] = "Gildenschlüsselwort"
L["guildKeywordDesc"] = "Jedes Gildenmitglied, das Dir dieses Schlüsselwort zuflüstert, wird automatisch und sofort in deine Gruppe eingeladen."
L["guildRankInvites"] = "Gildenränge einladen"
L["guildRankInvitesDesc"] = "Sobald Du auf einen der unteren Buttons klickst, werden alle Mitglieder des ausgewählten Rangs UND DARÜBERLIEGENDE in deine Gruppe eingeladen. Dementsprechend läd z.B. das Klicken auf den dritten Button jeden des Rangs 1, 2 und 3 ein. Dies wird zudem entweder eine Nachricht im Gilden- oder Offizierschat auslösen, die deinen Gildenmitgliedern 10 Sekunden Zeit gibt, ihre Gruppen zu verlassen, bevor sie wirklich eingeladen werden."
L["height"] = "Höhe"
L["hideInCombat"] = "Im Kampf verstecken"
L["hideInCombatDesc"] = "Blendet das Fenster automatisch aus, wenn du in einen Kampf gerätst."
L["hideReadyPlayers"] = "Bereite Spieler ausblenden"
L["hideReadyPlayersDesc"] = "Blendet Spieler, die als 'Bereit' markiert wurden, aus dem Fenster aus."
L["hideWhenDone"] = "Fenster nach Durchlauf schließen"
L["hideWhenDoneDesc"] = "Schließt das Fenster automatisch, sobald der Bereitschaftscheck durchgelaufen ist."
L["icon"] = "Symbol"
L["individualPromotions"] = "Individuelle Beförderungen"
L["individualPromotionsDesc"] = "Beachte, dass Spielernamen abhängig von Groß- und Kleinschreibung sowie Sonderzeichen sind. Um einen Spieler hinzuzufügen, musst Du seinen Namen in der untenstehenden Box eingeben und Enter oder den aufpoppenden Button drücken. Um einen Spieler zu entfernen, musst Du nur seinen Namen im Dropdown Menü anklicken."
L["invite"] = "Einladen"
L["inviteDesc"] = "Wenn Spieler Dir das unten aufgeführte Schlüsselwort zuflüstern, werden sie automatisch in deine Gruppe eingeladen. Wenn du in einer bereits vollen Gruppe bist, wird diese in eine Raidgruppe umgewandelt. Die Schlüsselwortmethode funktioniert so lange, bis der Raid volle 40 Mann erreicht hat. Wenn nichts als Schlüsselwort angegeben wird, wird die Methode ausgeschalten."
L["inviteGuild"] = "Gilde einladen"
L["inviteGuildDesc"] = "Läd jeden in deiner Gilde ein, der auf Maximallevel ist."
L["inviteGuildRankDesc"] = "Läd alle Gildenmitglieder des Rangs %s oder höher ein."
L["invitePrintGroupIsFull"] = "Sorry, die Gruppe ist voll."
L["invitePrintMaxLevel"] = "Alle Charaktere auf Maximallevel werden in 10 Sekunden in den Raid eingeladen. Bitte verlasst Eure Gruppen."
L["invitePrintRank"] = "Alle Charaktere des Rangs %s oder höher werden in 10 Sekunden in den Raid eingeladen. Bitte verlasst Eure Gruppen."
L["invitePrintZone"] = "Alle Charaktere in %s werden in 10 Sekunden in den Raid eingeladen. Bitte verlasst Eure Gruppen."
L["inviteZone"] = "Zone einladen"
L["inviteZoneDesc"] = "Läd jeden in deiner Gilde ein, der sich in der selben Zone wie Du aufhält."
L["itemLevel"] = "Gegenstandsstufe" -- Needs review
L["keyword"] = "Schlüsselwort"
L["keywordDesc"] = "Jeder, der Dir dieses Schlüsselwort zuflüstert, wird automatisch und sofort in deine Gruppe eingeladen."
L["labelAlign"] = "Textausrichtung"
L["latency"] = "Latenz" -- Needs review
L["left"] = "Links"
L["lockMonitor"] = "Anzeige sperren"
L["lockMonitorDesc"] = "Beachte, dass das Sperren der Anzeige den Titel versteckt und die Möglichkeiten entfernt, die Größe zu ändern, die Anzeige zu bewegen oder die Leistenoptionen aufzurufen."
L["makeLootMaster"] = "Freilassen, um dich selbst zum Plündermeister zu machen."
L["massPromotion"] = "Massenbeförderung"
L["minimum"] = "Minimum"
L["missingEnchants"] = "Fehlende Verzauberungen" -- Needs review
L["missingGems"] = "Fehlende Edelsteine" -- Needs review
L["monitorSettings"] = "Einstellungen der Anzeige"
L["moveTankUp"] = "Hier klicken, um den Tank nach oben zu schieben."
L["name"] = "Name" -- Needs review
L["neverShowOwnSpells"] = "Niemals eigene Zaubersprüche anzeigen"
L["neverShowOwnSpellsDesc"] = "Entscheidet, ob nur die Abklingzeiten anderer Spieler angezeigt werden sollen. Nützlich, wenn Du z.B. zur Anzeige deiner Cooldowns ein anderes Addon nutzt."
L["noResponse"] = "Keine Antwort"
L["notReady"] = "Nicht bereit"
L["offline"] = "Offline"
L["onlyMyOwnSpells"] = "Nur eigene Zaubersprüche anzeigen"
L["onlyMyOwnSpellsDesc"] = "Entscheidet, ob nur eigene Abklingzeiten angezeigt werden sollen. Funktioniert wie ein normales Addon zur Anzeige eigener Cooldowns."
L["openMonitor"] = "Anzeige öffnen"
L["options"] = "Optionen"
L["printToRaid"] = "Bereitschaftscheck in den Chat weiterleiten"
L["printToRaidDesc"] = "Falls du Assistent/Leiter bist, wird das Ergebnis des Bereitschaftschecks im Schlachtzugschat angezeigt, um Mitspielern zu zeigen, wer sie aufhält. Bitte versichere Dich, dass nur eine Person diese Funktion aktiviert hat."
L["profile"] = "Profile"
L["promote"] = "Befördern"
L["promoteEveryone"] = "Jeder"
L["promoteEveryoneDesc"] = "Befördert automatisch jeden."
L["promoteGuild"] = "Gilde"
L["promoteGuildDesc"] = "Befördert automatisch alle Gildenmitglieder."
L["ready"] = "Bereit"
L["readyCheckSeconds"] = "Bereitschaftscheck (%d Sekunden)"
L["remove"] = "Entfernen"
L["repairEnabled"] = "Gildenreparatur für %s für die Dauer dieses Schlachtzugs aktiviert."
L["right"] = "Rechts"
L["rightClick"] = "Rechts-klicken für Optionen!"
L["save"] = "Speichern"
L["saveButtonHelp"] = "Speichert den Tank in deiner persönlichen Liste. Von nun an wird dieser Tank immer als persönlicher Tank gesetzt, sobald ihr zusammen in einer Gruppe seid."
L["scale"] = "Skalierung"
L["selectClass"] = "Klasse wählen"
L["selectClassDesc"] = "Wähle über das untenstehende Dropdown Menü und die Checkboxen, welche Cooldowns angezeigt werden sollen. Jede Klasse verfügt über ein paar voreingestellte Zaubersprüche, deren Cooldowns dann über die Anzeige eingesehen werden können. Wähle eine Klasse und markiere dann die Sprüche, die deinen Vorlieben entsprechen."
L["shortSpellName"] = "Zauberspruch abkürzen"
L["show"] = "Einblenden"
L["showButtonHelp"] = "Blendet diesen Tank in deiner Tankanzeige ein. Diese Option hat nur einen lokalen Effekt und verändert nicht den Tankstatus des betroffenen Spielers für alle anderen Gruppenmitglieder."
L["showHelpTexts"] = "Interface Hilfe anzeigen"
L["showHelpTextsDesc"] = "Das oRA3 Interface ist voll von hilfreichen Tips, die eine bessere Beschreibung der einzelnen Elemente liefern und deren Funktion erklären. Falls du diese Option deaktivierst, begrenzt du das Durcheinander in allen Fenstern. |cffff4411Manche Fenster benötigen ein Neuladen des Interfaces.|r"
L["showMonitor"] = "Anzeige einschalten"
L["showMonitorDesc"] = "Schaltet die Anzeige der Cooldowns in der Spielwelt ein oder aus."
L["showWindow"] = "Fenster anzeigen"
L["showWindowDesc"] = "Zeigt das Fenster, wenn ein Bereitschaftscheck durchgeführt wird."
L["slashCommands"] = [=[
oRA3 verfügt über eine Reihe von Befehlen, die in hektischer Raidumgebung hilfreich sein können. Für den Fall, dass du in den alten CTRA-Tagen nicht dabei warst: Eine kleine Referenz. Alle Befehle haben diverse Abkürzungen, aber manchmal auch längere, aussagekräftigere Alternativen.

|cff44ff44/radur|r - Öffnet die Haltbarkeitsliste.
|cff44ff44/ragear|r - Opens the gear check list.
|cff44ff44/ralag|r - Opens the latency list.
|cff44ff44/razone|r - Öffnet die Zonenliste.
|cff44ff44/radisband|r - Löst die Gruppe ohne Bestätigung auf.
|cff44ff44/raready|r - Führt einen Bereitschaftscheck durch.
|cff44ff44/rainv|r - Läd die gesamte Gilde in deine Gruppe ein.
|cff44ff44/razinv|r - Läd Gildenmitglieder in deiner aktuellen Zone ein.
|cff44ff44/rarinv <rank name>|r - Läd Gildenmitglieder eines bestimmten Rangs ein.
]=]
L["slashCommandsHeader"] = "Befehle"
L["sort"] = "Sortieren"
L["spawnTestBar"] = "Testleiste erzeugen"
L["spellName"] = "Zauberspruch"
L["tankButtonHelp"] = "Setzt oder entfernt den Blizzard MT-Status."
L["tankHelp"] = [=[Spieler in der oberen Liste sind deine persönlichen, sortierten Tanks. Diese Liste wird nicht mit dem Raid geteilt, jeder kann daher eine andere persönliche Tankliste haben. Sobald du einen Namen in der unteren Liste anklickst, wird dieser zu deiner persönlichen Tankliste hinzugefügt.

Sobald du auf das Schild-Symbol klickst, wird der Spieler zum Blizzard Main Tank befördert. Blizzard MTs werden für alle Schlachtzugsmitglieder gesetzt, daher musst du Assistent oder höher sein.

Tanks, die in der Liste erscheinen, weil jemand anders sie als Blizzard MT gesetzt hat, werden automatisch aus der Liste gelöscht, sobald ihr Tankstatus entfernt wird.

Benutze das grüne Häckchen, um Tanks zwischen Schlachtzügen zu speichern. Sobald du das nächste Mal mit diesem Spieler in einem Schlachtzug bist, wird er automatisch als persönlicher Tank gesetzt.]=]
L["tanks"] = "Tanks"
L["tankTabTopText"] = "Klicke auf Spieler in der unteren Liste, um sie zu persönlichen Tanks zu machen. Falls du Hilfe bei den verschiedenen Optionen brauchst, solltest du deine Maus über das Fragezeichen bewegen."
L["texture"] = "Textur"
L["togglePane"] = "oRA3 Fenster öffnen/schließen"
L["toggleWithRaid"] = "Mit Schlachtzugsfenster öffnen"
L["toggleWithRaidDesc"] = "Öffnet und schließt das oRA3 Fenster zusammen mit Blizzards Schlachtzugsfenster. Falls du diese Option deaktivierst, kannst du das oRA3 Fenster nach wie vor via Tastenbelegung oder einem Befehl öffnen, z.B. |cff44ff44/radur|r."
L["unitName"] = "Spielername"
L["unknown"] = "Unbekannt"
L["useClassColor"] = "Klassenfarben"
L["whatIsThis"] = "Um was geht es hier?"
L["zone"] = "Zone"
