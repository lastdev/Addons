--[[
	WARNING: This is a generated file.
	If you wish to perform or update localizations, please go to our Localizer website at:
	http://localizer.norganna.org/

	AddOn: Gatherer
	Revision: $Id: GatherStrings.lua 1075 2013-03-07 05:00:08Z LocalizerAutoCommit $
	Version: 4.2.0 (<%codename%>)

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]

GathererLocalizations = {

	csCZ = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "Odeslat položku z %1 na %2";
		["COMM_NODE_SEND_TWO"]	= "Odeslat položku z %1 na %2 a %3";
		["COMM_RECEIVE_NODE"]	= "Odeslat položku z %1 na %2 a %3 (%4)";
		["NODE_ADD"]	= "Přidat položku z %1";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Ukaž načtenou zpravu";
		["CONFIG_ENABLE_HERB"]	= "Ukaž pozice kytek";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "Pouze kytky";
		["CONFIG_ENABLE_MINE"]	= "Ukaž pozice mineralů";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "Pouze minerály";

		-- Section: Database Version Messages
		["STORAGE_DB_VERSION_INVALID"]	= "POZOR!!!\nGatherer objevil, že vaše verze databáze je zastaralá. Prosím Klikněte na tlačítko potvrdit pro smazání databaze, nebo klikněte na ignorovat a pokuste se databázi opravit manualně.";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{Klikni - Pravým tlačítkem myši}} aby si viděl report z toho co jsi natěžil.";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Možnosti";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Netherdust Pollen";
		["ORE_ADAMANTITE"]	= "Tvrdokov";
		["ORE_BLOODSTONE"]	= "Chudý krvekov";
		["ORE_COPPER"]	= "Měď";
		["ORE_DARKIRON"]	= "Černé železo";
		["ORE_FELIRON"]	= "Felezo";
		["ORE_GOLD"]	= "Zlato";
		["ORE_INCENDICITE"]	= "Plamenec";
		["ORE_INDURIUM"]	= "Trvalec";
		["ORE_IRON"]	= "Železo";
		["ORE_KHORIUM"]	= "Chorium";
		["ORE_MITHRIL"]	= "Mitril";
		["ORE_NETHERCITE"]	= "Nethercite";
		["ORE_OBSIDIAN"]	= "Obsidián";
		["ORE_RADAMANTITE"]	= "Bohatý tvrdokov";
		["ORE_RTHORIUM"]	= "Bohaté torium";
		["ORE_SILVER"]	= "Stříbro";
		["ORE_THORIUM"]	= "Chudé torium";
		["ORE_TIN"]	= "Cín";
		["ORE_TRUESILVER"]	= "Rtuť";
		["TREASURE_BARREL"]	= "Sudy";
		["TREASURE_BLOODPETAL"]	= "Výhonky Krvekvětu";
		["TREASURE_BOX"]	= "Krabice";
		["TREASURE_CASK"]	= "Soudky";
		["TREASURE_CHEST"]	= "Truhly pokladů";
		["TREASURE_CLAM"]	= "Obří škeble";
		["TREASURE_CRATE"]	= "Bedny";
		["TREASURE_FOOTLOCKER"]	= "Skříňky";
		["TREASURE_GLOWCAP"]	= "Zářekvěty";
		["TREASURE_NIGHTDRAGON"]	= "Dech Draka Noci";
		["TREASURE_POWERCRYST"]	= "Krystaly síly";
		["TREASURE_SHELLFISHTRAP"]	= "Pasti na korýše";
		["TREASURE_SONGFLOWER"]	= "Zpěvokvěty";
		["TREASURE_UNGOROSOIL"]	= "Hlína z Un'Goro";
		["TREASURE_WHIPPERROOT"]	= "Třasohlízy";
		["TREASURE_WINDBLOSSOM"]	= "Větrůvky";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "$1 další drop";
		["NOTE_COUNT"]	= "Vytěženo %1-krát";
		["NOTE_DISTANCE"]	= "Vzdálenost: %1 yardů";
		["NOTE_IMPORTED"]	= "Importovaný objev";
		["NOTE_LASTVISITED"]	= "Naposled navštíveno: %1";
		["NOTE_OVERALLDROPS"]	= "Přehled nálezů zde:";
		["NOTE_SOURCE"]	= "Objevitel: %1";
		["NOTE_UNSKILLED"]	= "Objeveno bez možnosti vytěžení";

		-- Section: Time
		["DAYS"]	= "Den";
		["DAYS_ABBR"]	= "D";
		["DAYS_ABBR_P1"]	= "Dny";
		["DAYS_P1"]	= "D";
		["HOURS"]	= "Hodina";
		["HOURS_ABBR"]	= "H";
		["HOURS_ABBR_P1"]	= "H";
		["HOURS_P1"]	= "Hodin(-y)";
		["MINUTES"]	= "Minuta";
		["MINUTES_ABBR"]	= "Min";
		["MINUTES_ABBR_P1"]	= "Min";
		["MINUTES_P1"]	= "Minut(-y)";
		["SECONDS"]	= "Sekund";
		["SECONDS_ABBR"]	= "S";
		["SECONDS_ABBR_P1"]	= "S";
		["SECONDS_P1"]	= "Sekund(-y)";
		["WEEKS"]	= "Týden";
		["WEEKS_ABBR"]	= "Týden";
		["WEEKS_ABBR_P1"]	= "Týdny(-ů)";
		["WEEKS_P1"]	= "Týdny(-ů)";

		-- Section: Trade Skill Names
		["TRADE_HERBALISM"]	= "Bylinkářství";
		["TRADE_MINING"]	= "Kov-kopectví";

	};

	daDK = {

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Vis Redigerings Dialog";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Netherdust Pollen";
		["ORE_ADAMANTITE"]	= "Adamantit";
		["ORE_BLOODSTONE"]	= "Mindre Blodsten";
		["ORE_COPPER"]	= "Kobber";
		["ORE_DARKIRON"]	= "Mørkt Jern";
		["ORE_FELIRON"]	= "Demonisk Jern";
		["ORE_GOLD"]	= "Guld";
		["ORE_INCENDICITE"]	= "Incendicite";
		["ORE_INDURIUM"]	= "Indurium";
		["ORE_IRON"]	= "Jern";
		["ORE_KHORIUM"]	= "Khorium";
		["ORE_MITHRIL"]	= "mithril";
		["ORE_NETHERCITE"]	= "Nethercite";
		["ORE_OBSIDIAN"]	= "Obsidian";
		["ORE_RADAMANTITE"]	= "Beriget Adamantit";
		["ORE_RTHORIUM"]	= "Beriget Thorium";
		["ORE_SILVER"]	= "sølv";
		["ORE_THORIUM"]	= "thorium";
		["ORE_TIN"]	= "tin";
		["ORE_TRUESILVER"]	= "Ædelsølv";
		["TREASURE_BARREL"]	= "Tønder";
		["TREASURE_BLOODPETAL"]	= "Blodblomst skud";
		["TREASURE_BOX"]	= "Kasser";
		["TREASURE_CASK"]	= "Fustage";
		["TREASURE_CHEST"]	= "Skatte kiste";
		["TREASURE_CLAM"]	= "Kæmpe muslinger";
		["TREASURE_CRATE"]	= "Kister";
		["TREASURE_FOOTLOCKER"]	= "Skibskiste";
		["TREASURE_GLOWCAP"]	= "Lysende Svampe";
		["TREASURE_NIGHTDRAGON"]	= "Natte Dragens ånde";
		["TREASURE_POWERCRYST"]	= "Kraft krystal";
		["TREASURE_SHELLFISHTRAP"]	= "Krebsdyr fælde";
		["TREASURE_SONGFLOWER"]	= "Sangblomster";
		["TREASURE_UNGOROSOIL"]	= "Un'Goro muld";
		["TREASURE_WHIPPERROOT"]	= "Piskerod knold";
		["TREASURE_WINDBLOSSOM"]	= "Vindblomst bær";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "1% ekstra drop(s)...";
		["NOTE_COUNT"]	= "Samlet %1 gange";
		["NOTE_DISTANCE"]	= "Distance: %1 meter";
		["NOTE_IMPORTED"]	= "Importeret Gather";
		["NOTE_LASTVISITED"]	= "Sidst samlet: %1";
		["NOTE_OVERALLDROPS"]	= "Total drop rate:";
		["NOTE_SOURCE"]	= "Kilde: %1";
		["NOTE_UNSKILLED"]	= "Ulært Samler";

		-- Section: Time
		["DAYS"]	= "Dag";
		["DAYS_ABBR"]	= "Dag";
		["DAYS_ABBR_P1"]	= "Dage";
		["DAYS_P1"]	= "Dage";
		["HOURS"]	= "Time";
		["HOURS_ABBR"]	= "Time";
		["HOURS_ABBR_P1"]	= "Timer";
		["HOURS_P1"]	= "Timer";
		["MINUTES"]	= "Minut";
		["MINUTES_ABBR"]	= "Min";
		["MINUTES_ABBR_P1"]	= "Minutter";
		["MINUTES_P1"]	= "Minutter";
		["SECONDS"]	= "Sekund";
		["SECONDS_ABBR"]	= "Sek";
		["SECONDS_ABBR_P1"]	= "Sekunder";
		["SECONDS_P1"]	= "Sekunder";
		["WEEKS"]	= "Uge";
		["WEEKS_ABBR"]	= "Uge";
		["WEEKS_ABBR_P1"]	= "Uger";
		["WEEKS_P1"]	= "Uger";

		-- Section: Trade Skill Names
		["TRADE_HERBALISM"]	= "Urter";
		["TRADE_MINING"]	= "Mineraler";

	};

	deDE = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "Sende Fund von %1 an %2";
		["COMM_NODE_SEND_TWO"]	= "Sende Fund von %1 an %2 und %3";
		["COMM_RECEIVE_NODE"]	= "Fund von %1 in %2 von %3 erhalten";
		["NODE_ADD"]	= "Fund von %1 hinzugefügt";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Zeige Lade-Nachricht";
		["CONFIG_ALL_FILTER_NOTE"]	= "Die '%1' Einstellungen werden wegen der aktuellen Filter ignoriert und sorgen dafür dass alle Punkte in dieser Kategorie angezeigt werden.";
		["CONFIG_ARCH_MAX_NOTES"]	= "Zeige: %d nächste";
		["CONFIG_ENABLE_HERB"]	= "Zeige Kräutervorkommen";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "Nur Kräuterkunde";
		["CONFIG_ENABLE_MINE"]	= "Zeige Erzvorkommen";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "Nur Bergbau";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "Nur bei suche";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "Minimap-Optionen";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "Minimap Verfolgungs-Optionen";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "Weltkarten-Optionen";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "Weltkarten Verfolgungs-Optionen";
		["CONFIG_HERB_FILTER_LABEL"]	= "Zu suchende Kräuter";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "Bist Du sicher, dass Du alle geteilten Knoten dieses Spielers aus deiner Datenbank entfernen möchtest?\nDiese Aktion kann NICHT RÜCKGÄNGIG gemacht werden und wird die Knotenpunkte von %d aus deiner Gatherer-Datenbank entfernen...";
		["CONFIG_IGNORE_PURGE_DONE"]	= "%d Knoten wurden endgültig aus deiner Gatherer-Datenbank entfernt.";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "Möchtest Du alle geteilten Knotenpunkte dieses Spielers entfernen?";
		["CONFIG_MINE_FILTER_LABEL"]	= "Mineralienvorkommen verfolgen";
		["CONFIG_MINIICON_ANGLE"]	= "Schalter Winkel: %d°";
		["CONFIG_MINIICON_DISTANCE"]	= "Entfernung: %d";
		["CONFIG_MINIICON_ENABLE"]	= "Zeige Minimap-Button";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "Minimap-Zusatz";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "Zeige anonyme Punkte";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "Knoten Transparenz: %d %";
		["CONFIG_MINIMAP_ANON_TINT"]	= "Färbe unerkannte Punkte rot";
		["CONFIG_MINIMAP_DISTANCE"]	= "Entfernung: %d Meter";
		["CONFIG_MINIMAP_ENABLE"]	= "Zeige die Punkte in der Minimap";
		["CONFIG_MINIMAP_FADE_DIST"]	= "Nach %d Metern ausblenden";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "Mini-Knoten ausblenden";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "Entfernung zum Ausblenden: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "Punktegröße: %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "Untersuche bei: %d Yards";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "Knoten als untersucht markieren";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "Ausblenden nach %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "Wiedervorlage nach: %d Sek.";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "Während des untersuchens grün färben";
		["CONFIG_MINIMAP_LABEL"]	= "Minimap-Optionen";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "Zeige die %d nächsten Knoten an";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "Derzeitige Durchsichtigkeit %d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "Nur für die aktive Suche";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "Zum Tracking-Icon ändern wenn in der Nähe";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "verfolgen bis: %d Meter";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "Erlaube Trackingfeature";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "Icon Transparenz: 5d %";
		["CONFIG_OPEN_FILTER_LABEL"]	= "Schätze die gesucht werden";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "Profil auswählen: %1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "Profil kopieren";
		["CONFIG_PROFILE_CREATE_NEW"]	= "Neues Profil erstellen";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "Ein Profil aktivieren";
		["CONFIG_PROFILE_NEW"]	= "Profil erstellen oder ersetzen";
		["CONFIG_PROFILE_NEW_LABEL"]	= "Neuer Profilname:";
		["CONFIG_SECTION_ABOUT"]	= "Über";
		["CONFIG_SECTION_GENERAL"]	= "Grundeinstellung";
		["CONFIG_SECTION_HEADER_CORE"]	= "Hauptoptionen";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "Plugins";
		["CONFIG_SECTION_MINIMAP"]	= "Minimap";
		["CONFIG_SECTION_OPEN"]	= "Schatz";
		["CONFIG_SECTION_PROFILES"]	= "Profile";
		["CONFIG_SECTION_SHARING"]	= "Teilen";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "Über Gatherer";
		["CONFIG_SECTION_TITLE_ARCH"]	= "Archäologieoptionen";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "Haupt-Gatherer-Optionen";
		["CONFIG_SECTION_TITLE_HERB"]	= "Kräuterkunde-Filteroptionen";
		["CONFIG_SECTION_TITLE_MINE"]	= "Bergbau-Filteroptionen";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "Minimap-Gatherer-Optionen";
		["CONFIG_SECTION_TITLE_OPEN"]	= "Schatzfilteroptionen";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "Erstelle, konfiguriere und editiere Profile";
		["CONFIG_SECTION_TITLE_SHARING"]	= "Synchronisationsoptionen";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "Teile Blacklist";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "Füge empfangene Funde aus der Gruppe meiner Datenbank hinzu";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "Aktiviere Gruppen-Synchronisation";
		["CONFIG_SHARING_GROUP_LABEL"]	= "Teilen im Raid/in der Gruppe";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "Zeige eine Nachricht bei Empfang eines Fundes aus der Gruppe";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "Zeige eine Nachricht beim Senden eines Fundes an die Gruppe";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "Füge empfangene Funde aus der Gilde meiner Datenbank hinzu";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "Aktiviere Gildensynchronisation";
		["CONFIG_SHARING_GUILD_LABEL"]	= "Teilen in der Gilde";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "Zeige eine Nachricht bei Empfang eines Fundes aus der Gilde";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "Zeige eine Nachricht beim Senden eines Fundes an die Gilde";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "Zeige eine Nachricht wenn ein eigener Fund der Datenbank hinzugefügt wird";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "Persönliche Warnung";
		["CONFIG_TOOLTIP_COUNTS"]	= "Zeige wie oft \"geerntet\" wurde";
		["CONFIG_TOOLTIP_DISTANCE"]	= "Zeige Entfernung zum Knoten";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "Zeige Droprate";
		["CONFIG_TOOLTIP_ENABLE"]	= "Zeige Tooltipps";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "Zeige wann zuletzt gesehen";
		["CONFIG_TOOLTIP_SOURCE"]	= "Zeige Notiz-Quelle";
		["CONFIG_WORLDMAP_ENABLE"]	= "Zeige Knotenpunkte auf der Weltkarte";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "Icon-Größe";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "Zeige: %d Punkte";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "(Un-)Durchsichtigkeit";
		["ENABLE_OPEN"]	= "Zeige Schatzpunkte";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "Passend zu diesem Bösewicht, verbrannte Todesschwinge's Rückkehr alle Kräuter, lies die Erzvorkommen schmelzen und zerstörte sämtliche Truhen. Jetzt müssen sie alle neu wachsen, rekristallisiert oder von Piraten wieder, an neuen Orten, versteckt werden.\nSchatzsuche!!!\n(Alte Weltdaten wurden gelöscht aufgrund großer geographischer Veränderungen.)";
		["STORAGE_DB_VERSION_INVALID"]	= "WARNUNG!!!\nGatherer hat festgestellt dass deine Datenbankversion falsch ist.\nBitte drücke auf Akzeptieren zum löschen der Datenbank, oder drücke Ignorieren wenn du deine Datenbank selber reparieren möchtest.";
		["STORAGE_DB_VERSION_NEWER"]	= "Deine gespeicherte Gatherer-Datenbank ist zu neu.\nDie aktuelle Datenbank wird beiseite gelegt bis du Gatherer upgradest.";

		-- Section: Game Object Tooltip
		["GAME_OBJECT_REQUIRES_REWRITE"]	= "%1$s %2$d";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "Entf";
		["REPORT_COLUMN_HEADER_REGION"]	= "Gebiet";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "Quelle";
		["REPORT_COLUMN_HEADER_TYPE"]	= "Art";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "Möchtest Du %d Gatherer-Knoten löschen?";
		["REPORT_DELETE_MARKED"]	= "Lösche markierte Knoten";
		["REPORT_MARKED_NODES_COUNT"]	= "Markierte Knoten: %1";
		["REPORT_MARKING_NOTE"]	= "HINWEIS!\nWenn Du Knoten markierst bleiben sie markiert, bis du sie duch klicken oder benutzen des \"Unmark\"-Buttons entmarkierst - oder das Spiel neu lädtst.";
		["REPORT_MARK_THESE"]	= "Markiere diese";
		["REPORT_SEARCH_BY_REGION"]	= "Nach Gebiet";
		["REPORT_SEARCH_BY_SOURCE"]	= "Nach Quelle";
		["REPORT_SEARCH_BY_TYPE"]	= "Nach Art";
		["REPORT_SEND_MARKED"]	= "Sende markierte";
		["REPORT_TITLE"]	= "Bericht";
		["REPORT_UNMARK_ALL"]	= "Markierung rückgängig: alle";
		["REPORT_UNMARK_THESE"]	= "Markierung rückgängig: diese";

		-- Section: Generic Messages
		["DESCRIPTION"]	= "Gatherer ist ein Addon dass sich deine Fundorte merkt und sie dir auf der Hauptkarte, deiner Minimap, oder in einem HUD ausgibt.\nEs bietet auch die Möglichkeit deine Funorte mit deinem Raid, deiner Gilde und deinen Freunden zu teilen.";
		["DESCRIPTION_LICENSE"]	= "Gatherer ist Open-source Software und steht unter der GNU General Public License v2. Siehe gpl.txt, im Addon enthalten, um die ganze Lizenz zu sehen.";
		["LOADED_NOTIFICATION"]	= "Gatherer v%1 -- Geladen!";
		["MANIFEST_INVALID_VERSIONS_WARNING"]	= "{{Warnung:}} Deine Gatherer Installation scheint fehlerhafte Datei Versionen zu haben.\n\nBitte stelle sicher dass du das alte:\n %1\nVerzeichnis löschst, eine neue Kopie von:\n %2\ninstallierst und WoW komplett neustartest bevor du irgendeinen Bug meldest.\n\nVielen Dank,\n Das Gatherer Dev Team";
		["VERSION_MESSAGE"]	= "Das ist Gatherer v%1";
		["ZONETOKENS_UNIDENTIFIED_ZONES_WARNING"]	= "Gatherer konnte folgende Zonen nicht identifizieren: {{%1}}\nWenn dies eine Neue Zone ist, dann ist das kein problem, und du kannst wie gewohnt weiter machen.\nWenn dies keine Neue Zone ist, dann erinnere Calm als {{deine Daten sind nicht Verloren geganen!}} Deine Daten für diese Zonen sind weiter intakt, aber du mußt dein Gatherer updaten um auf sie zuzugreifen. Bis dahin kannst du fortfahren wie gehabt und all deine Daten werden zusammengefügt bis du upgradest.\n\n{{Bitte Gatherer updaten wenn möglich.}}";

		-- Section: Generic Strings
		["ACCEPT"]	= "Akzeptieren";
		["ALL"]	= "Alle";
		["CANCEL"]	= "Abbrechen";
		["DELETE"]	= "Löschen";
		["DONE"]	= "Erledigt";
		["ENABLE"]	= "Einschalten";
		["IGNORE"]	= "Ignorieren";
		["IGNORE_PLAYER"]	= "Spieler ignorieren";
		["NO"]	= "Nein";
		["OKAY"]	= "Ok";
		["SEARCH"]	= "Suchen";
		["STOP_IGNORE"]	= "Spieler löschen";
		["STRATA_BACKGROUND"]	= "Hintergrund";
		["STRATA_HIGH"]	= "Hoch";
		["STRATA_LOW"]	= "Tief";
		["STRATA_MEDIUM"]	= "Medium";
		["YES"]	= "Ja";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "{{Click}} zum schalten der Anzeige der Knoten.";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{Rechts-Click}} Zeige den sammelbericht.";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "{{Shift-Click}} zum schalten der Projektionsanzeige";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "{{Shift-Rechts-Click}} zum bearbeiten der Einstellungen.";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "HUD";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "HUD Anzeigeoptionen";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "HUD Heat Verfolgungsmodus";
		["HUD_CONFIG_HIDING_LABEL"]	= "HUD verstecke Optionen";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "Sichtwinkel: %d°";
		["HUD_CONFIG_plugin.gatherer_hud.base.color"]	= "Hintergrundfarbe";
		["HUD_CONFIG_plugin.gatherer_hud.base.enable"]	= "HUD abdunkeln, um Sicht zu verbessern";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "Farbe zentrieren";
		["HUD_CONFIG_plugin.gatherer_hud.center.enable"]	= "Aktiviere Sichtfeldkreis des Spielers";
		["HUD_CONFIG_plugin.gatherer_hud.fade"]	= "Punkte blenden aus bei: %d%% Radius";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "speichert Abklingzeit: %d Sekunden";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "Zeigt gespeicherte Reise (heiß)";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "Niemals abklingen";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "Folgepfadbreite: %d Meter";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "Verstecke im Kampf";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "Verstecke im Flug";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "Verstecke in Gebäuden";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "Verstecke wenn gemountet";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "Verstecke wenn ausruhend";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "Verstecke wenn unsichtbar";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "Verstecke wenn schwimmend";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "Verstecke bei ausgewähltem Ziel";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "Verstecke wenn nicht gemountet";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "Punktegröße: %d Pixel";
		["HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"]	= "Minimum Bildrate zum zeigen jedes Fenster: %dfps";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "Horizontaler Abstand: %d Pixel";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "Vertikaler Abstand: %d Pixel";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "Gruppenmitgliederfarbe";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "Zeige andere Gruppenmitglieder";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "Gruppensymbolgröße: %d Pixel";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "Sichtlevel : %0.1F";
		["HUD_CONFIG_plugin.gatherer_hud.radius"]	= "Gesamter HUD-Radius: %d Pixel";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "Punkteumkreis: %d Meter";
		["HUD_CONFIG_STRATA_LABEL"]	= "Strata (Zeichnungs Level)";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "HUD Sichtbarkeitsoptionen";
		["HUD_DESCRIPTION"]	= "HUD ist ein Navigationsbestandteil, das einem gefundene Gathererables auf dem Bildschirm anzeigt.";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "Deine CT_MapMod Daten wurden importiert.";
		["IMPORT_CTMOD_NODATA"]	= "Keine CT_MapMod Daten für den Import gefunden.";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Optionsmenü ein/ausblenden";

		-- Section: Labels
		["GENERAL_LABEL"]	= "Allgemein";
		["LABEL_CONFIG"]	= "Einstellungen";
		["LABEL_DENSITY_REPORT"]	= "Suchen";
		["LABEL_NOTE"]	= "Notiz";
		["LABEL_REPORT"]	= "Bericht";
		["MAP_NOTES_HIDE"]	= "Verstecke Gegenstände";
		["MAP_NOTES_SHOW"]	= "Zeige Gegenstände";
		["NOTIFICATIONS_TITLE"]	= "Gatherer: Warnungen";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "Upload abgebrochen.";
		["MASS_SHARING_ABORTED"]	= "Abgebrochen bei %1";
		["MASS_SHARING_ACCEPTED"]	= "Beginne...";
		["MASS_SHARING_ASKING"]	= "Frage...";
		["MASS_SHARING_BUSY"]	= "Spieler beschäftigt.";
		["MASS_SHARING_CLOSED"]	= "ist geschlossen.";
		["MASS_SHARING_COMPLETE"]	= "Erfolg!";
		["MASS_SHARING_DONE"]	= "Fertig %1";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%1$s will dir %2$d Gatherer Knoten schicken. Erlauben?";
		["MASS_SHARING_GATHERER_REPORT_TRANSMIT"]	= "Willst du %1$s Knoten zu %2$s schicken?\n(Nicht vergessen, sie müssen das Berichts Fenster offen haben.)";
		["MASS_SHARING_RECEIVED_COUNT"]	= "Empfangen %1";
		["MASS_SHARING_REJECT"]	= "Abgelenht!";
		["MASS_SHARING_SENDING"]	= "Übertrage...";
		["MASS_SHARING_SENT"]	= "gesendet %1";
		["MASS_SHARING_TIMEOUT"]	= "Zeitüberschreitung.";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Netherstaubpollen";
		["ORE_ADAMANTITE"]	= "Adamantit";
		["ORE_BLOODSTONE"]	= "Geringer Blutstein";
		["ORE_COPPER"]	= "Kupfer";
		["ORE_DARKIRON"]	= "Dunkeleisen";
		["ORE_FELIRON"]	= "Teufelseisen";
		["ORE_GOLD"]	= "Gold";
		["ORE_INCENDICITE"]	= "Pyrophor";
		["ORE_INDURIUM"]	= "Indurium";
		["ORE_IRON"]	= "Eisen";
		["ORE_KHORIUM"]	= "Khorium";
		["ORE_MITHRIL"]	= "Mithril";
		["ORE_NETHERCITE"]	= "Netherit";
		["ORE_OBSIDIAN"]	= "Obsidian";
		["ORE_RADAMANTITE"]	= "Reiches Adamantit";
		["ORE_RTHORIUM"]	= "Reiches Thorium";
		["ORE_SILVER"]	= "Silber";
		["ORE_THORIUM"]	= "Thorium";
		["ORE_TIN"]	= "Zinn";
		["ORE_TRUESILVER"]	= "Echtsilber";
		["TREASURE_BARREL"]	= "Fass";
		["TREASURE_BLOODPETAL"]	= "Blutblütensprösslinge";
		["TREASURE_BOX"]	= "Kiste";
		["TREASURE_CASK"]	= "Fässlein";
		["TREASURE_CHEST"]	= "Schatztruhe";
		["TREASURE_CLAM"]	= "Riesenmuschel";
		["TREASURE_CRATE"]	= "Kiste";
		["TREASURE_FOOTLOCKER"]	= "Schließkiste";
		["TREASURE_GLOWCAP"]	= "Glühkappe";
		["TREASURE_NIGHTDRAGON"]	= "Nachtdrachenodem";
		["TREASURE_POWERCRYST"]	= "Machtkristall";
		["TREASURE_SHELLFISHTRAP"]	= "Schalentierfalle";
		["TREASURE_SONGFLOWER"]	= "Liedblume";
		["TREASURE_UNGOROSOIL"]	= "Erde von Un'Goro";
		["TREASURE_WHIPPERROOT"]	= "Peitscherwurzelknollen";
		["TREASURE_WINDBLOSSOM"]	= "Windblütenbeeren";

		-- Section: Node Database Plugins
		["DATABASE_IMPORT_BUTTON_LABEL"]	= "Importieren";
		["DATABASE_IMPORT_HEADER"]	= "Import der Sammelpunkte durchführen:";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "Lage";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "# Knoten";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "Prozent";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "Art";
		["DENSITY_SEARCH_TITLE"]	= "Knoten Dichte Suche";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 zusätzliche(r) Drop(s)...";
		["NOTE_COUNT"]	= "%1 mal gesammelt";
		["NOTE_DISTANCE"]	= "Entfernung: %1 Meter";
		["NOTE_IMPORTED"]	= "Importiert";
		["NOTE_LASTVISITED"]	= "Zuletzt gesehen: %1";
		["NOTE_OVERALLDROPS"]	= "Gesamte Droprate:";
		["NOTE_SOURCE"]	= "Quelle: %1";
		["NOTE_UNSKILLED"]	= "Fertigkeit zu niedrig";

		-- Section: Time
		["DAYS"]	= "Tag";
		["DAYS_ABBR"]	= "Tag";
		["DAYS_ABBR_P1"]	= "Tage";
		["DAYS_P1"]	= "Tagen";
		["HOURS"]	= "Stunde";
		["HOURS_ABBR"]	= "h";
		["HOURS_ABBR_P1"]	= "h";
		["HOURS_P1"]	= "Stunden";
		["MINUTES"]	= "Minute";
		["MINUTES_ABBR"]	= "min";
		["MINUTES_ABBR_P1"]	= "min";
		["MINUTES_P1"]	= "Minuten";
		["SECONDS"]	= "Sekunde";
		["SECONDS_ABBR"]	= "Sek.";
		["SECONDS_ABBR_P1"]	= "Sek.";
		["SECONDS_P1"]	= "Sekunden";
		["WEEKS"]	= "Woche";
		["WEEKS_ABBR"]	= "Wo.";
		["WEEKS_ABBR_P1"]	= "Wo.";
		["WEEKS_P1"]	= "Wochen";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "Archäologie";
		["TRADE_HERBALISM"]	= "Kräuterkunde";
		["TRADE_MINING"]	= "Bergbau";

	};

	elGR = {

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "ρυθμίσεις";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "κοιτασμα Netherdust";
		["ORE_ADAMANTITE"]	= "Adamantite(αδαμαντιτης)";
		["ORE_BLOODSTONE"]	= "lesser bloodstone(μικρη αιματοπετρα)";
		["ORE_COPPER"]	= "copper(χαλκος)";
		["ORE_DARKIRON"]	= "dark iron(μαυροσιδερος)";
		["ORE_FELIRON"]	= "Fel iron(αστροσιδερος)";
		["ORE_GOLD"]	= "gold(χρυσος)";
		["ORE_INCENDICITE"]	= "incendicite";
		["ORE_INDURIUM"]	= "indurium(ινδωριο)";
		["ORE_IRON"]	= "iron(σιδερο)";
		["ORE_KHORIUM"]	= "khorium(χοριουμ)";
		["ORE_MITHRIL"]	= "mithril(μιθριλ)";
		["ORE_NETHERCITE"]	= "Nethercite(νεθερσιτης)";
		["ORE_OBSIDIAN"]	= "Obsidian(ομπσιθιανος)";
		["ORE_RADAMANTITE"]	= "Rich Adamantite(πλουσια πιγη Αδαμαντιτη)";
		["ORE_RTHORIUM"]	= "Rich Thorium(πλουσια πιγη Θοριου)";
		["ORE_SILVER"]	= "Silver(ασήμi)";
		["ORE_THORIUM"]	= "Thorium(θοριο)";
		["ORE_TIN"]	= "Tin(κασσίτερος)";
		["ORE_TRUESILVER"]	= "Truesilver(απσεγαδιαστο ασημι)";
		["TREASURE_BARREL"]	= "βαρελια";
		["TREASURE_BLOODPETAL"]	= "Bloodpetal Sprouts";
		["TREASURE_BOX"]	= "κουτια";
		["TREASURE_CASK"]	= "κασετίνα θησαυρου";
		["TREASURE_CHEST"]	= "σεντουκι θησαυρου";
		["TREASURE_CLAM"]	= "Γιγαντια οστρακοειδή";
		["TREASURE_CRATE"]	= "καφάσια";
		["TREASURE_FOOTLOCKER"]	= "μικρο σεντουκι";
		["TREASURE_GLOWCAP"]	= "Glowcaps(φοσφοροκεφαλο)";
		["TREASURE_NIGHTDRAGON"]	= "Night Dragon's Breath (ανασα νιχτοδρακου)";
		["TREASURE_POWERCRYST"]	= "power Crystals(κρυσταλοι ενεργειας)";
		["TREASURE_SHELLFISHTRAP"]	= "Shellfish Traps(παγιδες οστρακοδερμων)";
		["TREASURE_SONGFLOWER"]	= "Songflowers(μουσικα λουλουδια)";
		["TREASURE_UNGOROSOIL"]	= "Un'Goro Soil(χωμα)";
		["TREASURE_WHIPPERROOT"]	= "Whipper Root Tubers(σολινοτες ριζες ιτιας)";
		["TREASURE_WINDBLOSSOM"]	= "Windblossom Berries(μουρα απο αγριολουλουδα)";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 πρόσθετα λαφυρα";
		["NOTE_COUNT"]	= "συλλέκτικε %1 φορα(ες)";
		["NOTE_DISTANCE"]	= "αποσταση: %1 γιαρδες";
		["NOTE_IMPORTED"]	= "εισηχθεμενη συλλογη";
		["NOTE_LASTVISITED"]	= "επισκευθηκε: %1";
		["NOTE_OVERALLDROPS"]	= "συνολικο ποσοστό λαφυρων";
		["NOTE_SOURCE"]	= "πηγη: %1";
		["NOTE_UNSKILLED"]	= "ανειδίκευτος για συλογη";

		-- Section: Time
		["DAYS"]	= "μερα";
		["DAYS_ABBR"]	= "ημερα";
		["DAYS_ABBR_P1"]	= "ημερες";
		["DAYS_P1"]	= "ημερες";
		["HOURS"]	= "ωρα";
		["HOURS_ABBR"]	= "ωρα";
		["HOURS_ABBR_P1"]	= "ωρες";
		["HOURS_P1"]	= "ωρες";
		["MINUTES"]	= "λεπτο";
		["MINUTES_ABBR"]	= "λεπτο";
		["MINUTES_ABBR_P1"]	= "λεπτα";
		["MINUTES_P1"]	= "λεπτα";
		["SECONDS"]	= "δευτερολεπτο";
		["SECONDS_ABBR"]	= "δευτερολεπτο";
		["SECONDS_ABBR_P1"]	= "δευτερολεπτα";
		["SECONDS_P1"]	= "δευτερολεπτα";
		["WEEKS"]	= "εβδομαδα";
		["WEEKS_ABBR"]	= "εβδομαδα";
		["WEEKS_ABBR_P1"]	= "εβδομαδες";
		["WEEKS_P1"]	= "εβδομαδες";

		-- Section: Trade Skill Names
		["TRADE_HERBALISM"]	= "Βοτανολογεια";
		["TRADE_MINING"]	= "μεταλογνωσεια";

	};

	enUS = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "Sent gather of %1 to %2";
		["COMM_NODE_SEND_TWO"]	= "Sent gather of %1 to %2 and %3";
		["COMM_RECEIVE_NODE"]	= "Received gather of %1 in %2 from %3 (%4)";
		["NODE_ADD"]	= "Added gather of %1";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Show Loaded Message";
		["CONFIG_ALL_FILTER_NOTE"]	= "The '%1' options cause the current filters to be ignored and force all nodes in that category to be shown.";
		["CONFIG_ARCH_MAX_NOTES"]	= "Display: %d closest";
		["CONFIG_ENABLE_HERB"]	= "Show herbalism nodes";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "Herbalists Only";
		["CONFIG_ENABLE_MINE"]	= "Show mining nodes";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "Miners Only";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "Only if tracking";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "Minimap Button Options";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "Minimap Tracking Options";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "World Map Options";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "World Map Tracking Options";
		["CONFIG_HERB_FILTER_LABEL"]	= "Herbal nodes to track";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "Are you sure you wish to purge all shares from this player from your database?  This operation CANNOT be undone and will remove up to %d node(s) from your Gatherer database.";
		["CONFIG_IGNORE_PURGE_DONE"]	= "%d node(s) have been permenently removed from your Gatherer database.";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "Do you wish to remove all nodes that have been shared by this player?";
		["CONFIG_MINE_FILTER_LABEL"]	= "Mineral nodes to track";
		["CONFIG_MINIICON_ANGLE"]	= "Button angle: %d°";
		["CONFIG_MINIICON_DISTANCE"]	= "Distance: %d";
		["CONFIG_MINIICON_ENABLE"]	= "Display Minimap Button";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "Minimap Additional";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "Display anonymous nodes";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "Anon opacity: %d%%";
		["CONFIG_MINIMAP_ANON_TINT"]	= "Tint anonymous nodes red";
		["CONFIG_MINIMAP_DISTANCE"]	= "Distance: %d yards";
		["CONFIG_MINIMAP_ENABLE"]	= "Display notes on Minimap";
		["CONFIG_MINIMAP_FADE_DIST"]	= "Fade at: %d yards";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "Fade out mini-notes";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "Distance fading: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "Icon Size: %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "Inspect at: %d yards";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "Mark nodes as inspected";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "Inspected fading: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "Reinspect: %d secs";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "Tint green while inspecting";
		["CONFIG_MINIMAP_LABEL"]	= "Minimap Options";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "Display: %d closest";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "Default opacity: %d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "Only for active tracking skill";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "Convert to tracking icon when close";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "Track at: %d yards";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "Enable tracking skill feature";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "Icon opacity: %d%%";
		["CONFIG_OPEN_FILTER_LABEL"]	= "Treasure nodes to track";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "Changing profile: %1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "Create copy";
		["CONFIG_PROFILE_CREATE_NEW"]	= "Create new";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "Activate a current profile";
		["CONFIG_PROFILE_NEW"]	= "Create or replace a profile";
		["CONFIG_PROFILE_NEW_LABEL"]	= "New profile name:";
		["CONFIG_SECTION_ABOUT"]	= "About";
		["CONFIG_SECTION_GENERAL"]	= "General";
		["CONFIG_SECTION_HEADER_CORE"]	= "Core Options";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "Plugins";
		["CONFIG_SECTION_MINIMAP"]	= "Minimap";
		["CONFIG_SECTION_OPEN"]	= "Treasure";
		["CONFIG_SECTION_PROFILES"]	= "Profiles";
		["CONFIG_SECTION_SHARING"]	= "Sharing";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "About Gatherer";
		["CONFIG_SECTION_TITLE_ARCH"]	= "Archaeology Options";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "Main Gatherer Options";
		["CONFIG_SECTION_TITLE_HERB"]	= "Herbalism Filter Options";
		["CONFIG_SECTION_TITLE_MINE"]	= "Mining Filter Options";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "Minimap Gatherer Options";
		["CONFIG_SECTION_TITLE_OPEN"]	= "Treasure Filter Options";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "Setup, configure and edit profiles";
		["CONFIG_SECTION_TITLE_SHARING"]	= "Synchronization Options";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "Sharing Blacklist";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "Add received group gathers to my database";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "Enable group synchronization";
		["CONFIG_SHARING_GROUP_LABEL"]	= "Raid/Party Sharing";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "Print a message when receiving a group gather";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "Print a message when sending a group gather";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "Add received guild gathers to my database";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "Enable guild synchronization";
		["CONFIG_SHARING_GUILD_LABEL"]	= "Guild Sharing";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "Print a message when receiving a guild gather";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "Print a message when sending a guild gather";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "Print a message when adding own gather to DB";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "Personal Alert";
		["CONFIG_TOOLTIP_COUNTS"]	= "Display harvest counts";
		["CONFIG_TOOLTIP_DISTANCE"]	= "Display node distance";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "Display drop rates";
		["CONFIG_TOOLTIP_ENABLE"]	= "Display tooltips";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "Display last seen time";
		["CONFIG_TOOLTIP_SOURCE"]	= "Display note source";
		["CONFIG_WORLDMAP_ENABLE"]	= "Display notes on World Map";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "Icon Size: %d";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "Display: %d notes";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "Opacity: %d%%";
		["ENABLE_OPEN"]	= "Show treasure nodes";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "Being the mean super-villan that he is, Deathwing's return has burned all the herbs, melted all the ore deposits and obliterated all of the chests.  Now they all have to regrow, be recrystallized or be re-hidden by pirates and they're probably all in new locations.  Treasure Hunt!!!\n(Old World data has been wiped due to widespread geography changes.)";
		["STORAGE_DB_VERSION_INVALID"]	= "WARNING!!!\nGatherer has detected that your database version is invalid.  Please press accept to clear your database, or select ignore if you want to try to repair your database manually.";
		["STORAGE_DB_VERSION_NEWER"]	= "Your saved Gatherer database is too new.  Your current database has been set aside until you upgrade Gatherer.";

		-- Section: Game Object Tooltip
		["GAME_OBJECT_REQUIRES_REWRITE"]	= "%1$s %2$d";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "Dist";
		["REPORT_COLUMN_HEADER_REGION"]	= "Region";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "Source";
		["REPORT_COLUMN_HEADER_TYPE"]	= "Type";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "Do you want to delete %d Gatherer nodes?";
		["REPORT_DELETE_MARKED"]	= "Delete marked";
		["REPORT_MARKED_NODES_COUNT"]	= "Marked nodes: %1";
		["REPORT_MARKING_NOTE"]	= "Note: When you mark nodes, they will remain marked until you unmark them by either clicking the line item in the report, using the Unmark buttons above or reloading the game.";
		["REPORT_MARK_THESE"]	= "Mark these";
		["REPORT_SEARCH_BY_REGION"]	= "By Region";
		["REPORT_SEARCH_BY_SOURCE"]	= "By Source";
		["REPORT_SEARCH_BY_TYPE"]	= "By Type";
		["REPORT_SEND_MARKED"]	= "Send marked";
		["REPORT_TITLE"]	= "Gatherables Report";
		["REPORT_UNMARK_ALL"]	= "Unmark all";
		["REPORT_UNMARK_THESE"]	= "Unmark these";

		-- Section: Generic Messages
		["DESCRIPTION"]	= "Gatherer is an addon that allows you to remember your gathering locations and view them on either or all of your main map, your minimap, or in an onscreen display HUD. It also allows you to share your finds with your guild, raid or your friends.";
		["DESCRIPTION_LICENSE"]	= "Gatherer is open source software and is licensed under the GNU General Public License v2.  Please see gpl.txt, included with this AddOn, for the full license.";
		["LOADED_NOTIFICATION"]	= "Gatherer v%1 -- Loaded!";
		["MANIFEST_INVALID_VERSIONS_WARNING"]	= "{{Warning:}} Your Gatherer installation appears to have mismatching file versions.\n\nPlease make sure you delete the old:\n  %1\ndirectory, reinstall a fresh copy from:\n  %2\nand restart WoW completely before reporting any bugs.\n\nThanks,\n  The Gatherer Dev Team";
		["VERSION_MESSAGE"]	= "This is Gatherer v%1";
		["ZONETOKENS_UNIDENTIFIED_ZONES_WARNING"]	= "Gatherer was unable to identify the following zones: {{%1}}\nIf these are new zones, then this is not a problem, and you can continue as normal.\nIf these are not new zones, then remain calm as {{your data IS NOT LOST!}}  Your data for these zones is still intact, but you will need to update Gatherer in order to access it.  Until then you can continue as normal and any new data you collect will be merged with your old data once you upgrade.  \n\n{{Please upgrade Gatherer when convenient.}}";

		-- Section: Generic Strings
		["ACCEPT"]	= "Accept";
		["ALL"]	= "All";
		["CANCEL"]	= "Cancel";
		["DELETE"]	= "Delete";
		["DONE"]	= "Done";
		["ENABLE"]	= "Enable";
		["IGNORE"]	= "Ignore";
		["IGNORE_PLAYER"]	= "Ignore Player";
		["NO"]	= "No";
		["OKAY"]	= "Okay";
		["SEARCH"]	= "Search";
		["STOP_IGNORE"]	= "Remove Player";
		["STRATA_BACKGROUND"]	= "Background";
		["STRATA_HIGH"]	= "High";
		["STRATA_LOW"]	= "Low";
		["STRATA_MEDIUM"]	= "Medium";
		["YES"]	= "Yes";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "{{Click}} to toggle display of nodes.";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{Right-Click}} to view the gather report.";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "{{Shift-Click}} to toggle HUD display.";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "{{Shift-Right-Click}} to edit the configuration.";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "HUD";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "HUD Display Options";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "HUD Heat Tracking Mode";
		["HUD_CONFIG_HIDING_LABEL"]	= "HUD Hiding Options";
		["HUD_CONFIG_plugin.gatherer_hud.alpha"]	= "Overall HUD Alpha: %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "Viewing Angle: %d°";
		["HUD_CONFIG_plugin.gatherer_hud.base.color"]	= "Underlay colour";
		["HUD_CONFIG_plugin.gatherer_hud.base.enable"]	= "Darken HUD to improve visibility";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "Center colour";
		["HUD_CONFIG_plugin.gatherer_hud.center.enable"]	= "Enable player Field Of View circle";
		["HUD_CONFIG_plugin.gatherer_hud.fade"]	= "Notes fade out at: %d%% of radius";
		["HUD_CONFIG_plugin.gatherer_hud.heat.color"]	= "Heat colour";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "Tracking cooldown: %d seconds";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "Show travel tracking (heat)";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "Never cooldown";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "Tracking trail width: %d yards";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "Hide while in combat";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "Hide while flying";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "Hide while inside";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "Hide while mounted";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "Hide while resting";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "Hide while stealthed";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "Hide while swimming";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "Hide while targetting";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "Hide while not mounted";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "Note Size: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"]	= "Minimum framerate to draw every frame: %dfps";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "Horizontal Offset: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "Vertical Offset: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "Party member colour";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "Show other party members";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "Party icon size: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "Perspective Level: %0.1f";
		["HUD_CONFIG_plugin.gatherer_hud.radius"]	= "Overall HUD radius: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "Note Range: %d yards";
		["HUD_CONFIG_STRATA_LABEL"]	= "HUD Strata (Drawing Level)";
		["HUD_CONFIG_USAGE_NOTE"]	= "The use of the HUD will consume frames from your framerate, and will consume even more frames if you enable the \"Heat\" tracking mode which keeps track of your past traffic via a heat trail.";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "HUD Visibility Options";
		["HUD_DESCRIPTION"]	= "The HUD is a navigation component that allows you to track the location of gatherables on your screen in a heads-up style overlay.";
		["HUD_TITLE"]	= "Gatherer Heads-Up Display Plugin";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "Your CT_MapMod data has been imported.";
		["IMPORT_CTMOD_NODATA"]	= "No CT_MapMod data found to import.";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Toggle Options Dialog";

		-- Section: Labels
		["GENERAL_LABEL"]	= "General";
		["LABEL_CONFIG"]	= "Config";
		["LABEL_DENSITY_REPORT"]	= "Node Search";
		["LABEL_NOTE"]	= "Note";
		["LABEL_REPORT"]	= "Gatherables Report";
		["MAP_NOTES_HIDE"]	= "Hide Items";
		["MAP_NOTES_SHOW"]	= "Show Items";
		["NOTIFICATIONS_TITLE"]	= "Gatherer: Warnings";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "Aborted upload.";
		["MASS_SHARING_ABORTED"]	= "Aborted at %1";
		["MASS_SHARING_ACCEPTED"]	= "Beginning...";
		["MASS_SHARING_ASKING"]	= "Asking...";
		["MASS_SHARING_BUSY"]	= "User busy.";
		["MASS_SHARING_CLOSED"]	= "Is closed.";
		["MASS_SHARING_COMPLETE"]	= "Success!";
		["MASS_SHARING_DONE"]	= "Finished %1";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%1$s wants to send you %2$d Gatherer nodes. Accept?";
		["MASS_SHARING_GATHERER_REPORT_TRANSMIT"]	= "Do you wish to send %1$s nodes to %2$s?\n(Remember, they need to have the Gatherables Report window open.)";
		["MASS_SHARING_RECEIVED_COUNT"]	= "Received %1";
		["MASS_SHARING_REJECT"]	= "Rejected!";
		["MASS_SHARING_SENDING"]	= "Sending...";
		["MASS_SHARING_SENT"]	= "Sent %1";
		["MASS_SHARING_TIMEOUT"]	= "Timed out.";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Netherdust Pollen";
		["ORE_ADAMANTITE"]	= "Adamantite";
		["ORE_BLOODSTONE"]	= "Lesser Bloodstone";
		["ORE_COPPER"]	= "Copper";
		["ORE_DARKIRON"]	= "Dark Iron";
		["ORE_FELIRON"]	= "Fel Iron";
		["ORE_GOLD"]	= "Gold";
		["ORE_INCENDICITE"]	= "Incendicite";
		["ORE_INDURIUM"]	= "Indurium";
		["ORE_IRON"]	= "Iron";
		["ORE_KHORIUM"]	= "Khorium";
		["ORE_MITHRIL"]	= "Mithril";
		["ORE_NETHERCITE"]	= "Nethercite";
		["ORE_OBSIDIAN"]	= "Obsidian";
		["ORE_RADAMANTITE"]	= "Rich Adamantite";
		["ORE_RTHORIUM"]	= "Rich Thorium";
		["ORE_SILVER"]	= "Silver";
		["ORE_THORIUM"]	= "Thorium";
		["ORE_TIN"]	= "Tin";
		["ORE_TRUESILVER"]	= "Truesilver";
		["TREASURE_BARREL"]	= "Barrels";
		["TREASURE_BLOODPETAL"]	= "Bloodpetal Sprouts";
		["TREASURE_BOX"]	= "Boxes";
		["TREASURE_CASK"]	= "Casks";
		["TREASURE_CHEST"]	= "Treasure Chests";
		["TREASURE_CLAM"]	= "Giant Clams";
		["TREASURE_CRATE"]	= "Crates";
		["TREASURE_FOOTLOCKER"]	= "Footlockers";
		["TREASURE_GLOWCAP"]	= "Glowcaps";
		["TREASURE_NIGHTDRAGON"]	= "Night Dragon's Breath";
		["TREASURE_POWERCRYST"]	= "Power Crystals";
		["TREASURE_SHELLFISHTRAP"]	= "Shellfish Traps";
		["TREASURE_SONGFLOWER"]	= "Songflowers";
		["TREASURE_UNGOROSOIL"]	= "Un'Goro Soil";
		["TREASURE_WHIPPERROOT"]	= "Whipper Root Tubers";
		["TREASURE_WINDBLOSSOM"]	= "Windblossom Berries";

		-- Section: Node Database Plugins
		["DATABASE_IMPORT_BUTTON_LABEL"]	= "Import";
		["DATABASE_IMPORT_HEADER"]	= "Perform import of node database:";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "Location";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "# Nodes";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "Percent";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "Type";
		["DENSITY_SEARCH_TITLE"]	= "Node Density Search";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 additional drop(s)...";
		["NOTE_COUNT"]	= "Gathered %1 times";
		["NOTE_DISTANCE"]	= "Distance: %1 yards";
		["NOTE_IMPORTED"]	= "Imported Gather";
		["NOTE_LASTVISITED"]	= "Last visited: %1";
		["NOTE_OVERALLDROPS"]	= "Overall drop rates:";
		["NOTE_SOURCE"]	= "Source: %1";
		["NOTE_UNSKILLED"]	= "Unskilled Gather";

		-- Section: Time
		["DAYS"]	= "Day";
		["DAYS_ABBR"]	= "Day";
		["DAYS_ABBR_P1"]	= "Days";
		["DAYS_P1"]	= "Days";
		["HOURS"]	= "Hour";
		["HOURS_ABBR"]	= "Hr";
		["HOURS_ABBR_P1"]	= "Hrs";
		["HOURS_P1"]	= "Hours";
		["MINUTES"]	= "Minute";
		["MINUTES_ABBR"]	= "Min";
		["MINUTES_ABBR_P1"]	= "Mins";
		["MINUTES_P1"]	= "Minutes";
		["SECONDS"]	= "Second";
		["SECONDS_ABBR"]	= "Sec";
		["SECONDS_ABBR_P1"]	= "Secs";
		["SECONDS_P1"]	= "Seconds";
		["WEEKS"]	= "Week";
		["WEEKS_ABBR"]	= "Wk";
		["WEEKS_ABBR_P1"]	= "Wks";
		["WEEKS_P1"]	= "Weeks";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "Archaeology";
		["TRADE_HERBALISM"]	= "Herbalism";
		["TRADE_MINING"]	= "Mining";

	};

	esES = {

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Mostrar Mensaje Cargado";
		["CONFIG_ALL_FILTER_NOTE"]	= "La opción '1%' hace que el filtro actual sea ignorado y fuerza que todos los nodos en esa categoría sean mostrados.";
		["CONFIG_ARCH_MAX_NOTES"]	= "Mostrar: %d más cercano.";
		["CONFIG_ENABLE_HERB"]	= "Mostrar nodos de Herbalismo.";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "Estás seguro que quieres purgar todos los datos compartidos de este jugador en tu base de datos? Esta operación NO ES REVERSIBLE y eliminará %d nodo(s) de tu base de datos Gatherer.";
		["CONFIG_IGNORE_PURGE_DONE"]	= "%d nodo(s) han sido eliminados permanentemente de tu base de datos Gatherer.";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "Deseas eliminar todos los nodos que han sido compartidos por este jugador?";
		["CONFIG_MINIICON_ANGLE"]	= "Ángulo de botón: %d°";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "Opacidad Anon: %d%%";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "Distancia the apagar gradualmente: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "Tamaño de Ícono: %d";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "Marcar nodos como inspeccionados.";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "Apagar gradualmente inspeccionados: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "Re-inspeccionar: %d segundos";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "Matizar verde mientras inspeccionando";
		["CONFIG_MINIMAP_LABEL"]	= "Opciones Minimapa";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "Mostrar: %d más cercano";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "Opacidad defecta: %d%%";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Recopilador";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Activa la Ventana de Opciones";

		-- Section: Labels
		["GENERAL_LABEL"]	= "General";
		["LABEL_CONFIG"]	= "Configuración";
		["LABEL_DENSITY_REPORT"]	= "Búsqueda de nodo";
		["LABEL_NOTE"]	= "Nota";
		["LABEL_REPORT"]	= "Informe";
		["NOTIFICATIONS_TITLE"]	= "Gatherer: Avisos";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Polen de polvo abisal";
		["ORE_ADAMANTITE"]	= "Adamantita";
		["ORE_BLOODSTONE"]	= "Sangrita inferior";
		["ORE_COPPER"]	= "Cobre";
		["ORE_DARKIRON"]	= "Hierro negro";
		["ORE_FELIRON"]	= "Hierro vil";
		["ORE_GOLD"]	= "Oro";
		["ORE_INCENDICITE"]	= "Incendicita";
		["ORE_INDURIUM"]	= "Indurio";
		["ORE_IRON"]	= "Hierro";
		["ORE_KHORIUM"]	= "Korio";
		["ORE_MITHRIL"]	= "Mitril";
		["ORE_NETHERCITE"]	= "Abisalita";
		["ORE_OBSIDIAN"]	= "Obsidiana";
		["ORE_RADAMANTITE"]	= "Adamantita enriquecida";
		["ORE_RTHORIUM"]	= "Torio enriquecido";
		["ORE_SILVER"]	= "Plata";
		["ORE_THORIUM"]	= "Torio";
		["ORE_TIN"]	= "Estaño";
		["ORE_TRUESILVER"]	= "Veraplata";
		["TREASURE_BARREL"]	= "Barriles";
		["TREASURE_BLOODPETAL"]	= "Brotes pétalo de sangre";
		["TREASURE_BOX"]	= "Cajas";
		["TREASURE_CASK"]	= "Barriles";
		["TREASURE_CHEST"]	= "Cofres del tesoro";
		["TREASURE_CLAM"]	= "Almejas gigantes";
		["TREASURE_CRATE"]	= "Cajones";
		["TREASURE_FOOTLOCKER"]	= "Cajas personales";
		["TREASURE_GLOWCAP"]	= "Fluochampiñones";
		["TREASURE_NIGHTDRAGON"]	= "Alientos de Dragón nocturno";
		["TREASURE_POWERCRYST"]	= "Cristales de poder";
		["TREASURE_SHELLFISHTRAP"]	= "Trampas de marisco";
		["TREASURE_SONGFLOWER"]	= "Melodías";
		["TREASURE_UNGOROSOIL"]	= "Tierra de Un'Goro";
		["TREASURE_WHIPPERROOT"]	= "Tubérculos de blancoria";
		["TREASURE_WINDBLOSSOM"]	= "Frutos de la flor del viento";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 aparición(es) adicional(es)";
		["NOTE_COUNT"]	= "Recogido %1 veces";
		["NOTE_DISTANCE"]	= "Distancia: %1 metros";
		["NOTE_IMPORTED"]	= "Recogido Importado";
		["NOTE_LASTVISITED"]	= "Última visita: %1";
		["NOTE_OVERALLDROPS"]	= "Frecuencia general de apariciones:";
		["NOTE_SOURCE"]	= "Fuente: %1";
		["NOTE_UNSKILLED"]	= "Recogido Sin Habilidad";

		-- Section: Time
		["DAYS"]	= "Day";
		["DAYS_ABBR"]	= "Day";
		["DAYS_ABBR_P1"]	= "Day";
		["DAYS_P1"]	= "Días";
		["HOURS"]	= "Day";
		["HOURS_ABBR"]	= "Day";
		["HOURS_ABBR_P1"]	= "Hrs";
		["HOURS_P1"]	= "Horas";
		["MINUTES"]	= "Minuto";
		["MINUTES_ABBR"]	= "Min";
		["MINUTES_ABBR_P1"]	= "Min";
		["MINUTES_P1"]	= "Minutos";
		["SECONDS"]	= "Segundo";
		["SECONDS_ABBR"]	= "Seg";
		["SECONDS_ABBR_P1"]	= "Seg";
		["SECONDS_P1"]	= "Segundos";
		["WEEKS"]	= "Semana";
		["WEEKS_ABBR"]	= "Sem";
		["WEEKS_ABBR_P1"]	= "Sems";
		["WEEKS_P1"]	= "Semanas";

		-- Section: Trade Skill Names
		["TRADE_HERBALISM"]	= "Herboristería";
		["TRADE_MINING"]	= "Minería";

	};

	esMX = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "Se envió recolección de %1 a %2";
		["COMM_NODE_SEND_TWO"]	= "Se envió recolección de %1 a %2 y a %3";
		["COMM_RECEIVE_NODE"]	= "Se recibió recolección de %1 en %2 de %3 (%4)";
		["NODE_ADD"]	= "Se agregó recolección de %1";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Mostrar mensaje cargado";
		["CONFIG_ALL_FILTER_NOTE"]	= "Las opciones '%1' ignorarán los filtros actuales y forzarán la visualización de todos los nodos de esa categoría.";
		["CONFIG_ARCH_MAX_NOTES"]	= "Mostrar: los %d más cercanos";
		["CONFIG_ENABLE_HERB"]	= "Mostrar nodos de herboristería";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "Solo herboristas";
		["CONFIG_ENABLE_MINE"]	= "Mostrar nodos de minería";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "Solo mineros";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "Solo si se rastrea";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "Opciones de botones del minimapa";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "Opciones de rastreo del minimapa";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "Opciones del Mapa del mundo";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "Opciones de rastreo del Mapa del mundo";
		["CONFIG_HERB_FILTER_LABEL"]	= "Nodos de herboristería por rastrear";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "¿Estás seguro de que deseas borrar todos los datos compartidos de este jugador de tu base de datos? Esta operación NO SE PUEDE deshacer y eliminará hasta %d nodo(s) de tu base de datos de Gatherer.";
		["CONFIG_IGNORE_PURGE_DONE"]	= "Se eliminaron permanentemente %d nodo(s) de tu base de datos de Gatherer.";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "¿Deseas borrar todos los nodos compartidos por este jugador?";
		["CONFIG_MINE_FILTER_LABEL"]	= "Nodos de minerales por rastrear";
		["CONFIG_MINIICON_ANGLE"]	= "Ángulo del botón: %dº";
		["CONFIG_MINIICON_DISTANCE"]	= "Distancia: %d";
		["CONFIG_MINIICON_ENABLE"]	= "Mostrar botón en el minimapa";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "Opciones adicionales del minimapa";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "Mostrar nodos anónimos";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "Opacidad de anón.: %d%%";
		["CONFIG_MINIMAP_ANON_TINT"]	= "Teñir nodos anónimos de rojo";
		["CONFIG_MINIMAP_DISTANCE"]	= "Distancia: %d metros";
		["CONFIG_MINIMAP_ENABLE"]	= "Mostrar nodos en el minimapa";
		["CONFIG_MINIMAP_FADE_DIST"]	= "Desaparecer a: %d metros";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "Desvanecer mininotas";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "Distancia de desvanecimiento: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "Tamaño de los íconos: %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "Revisar a: %d metros";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "Marcar nodos como revisados";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "Desvanecimiento de revisión: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "Volver a revisar: %d seg.";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "Teñir de verde durante la revisión";
		["CONFIG_MINIMAP_LABEL"]	= "Opciones del minimapa";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "Mostrar: los %d más cercanos";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "Opacidad predeterminada: %d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "Solo para la habilidad de rastreo activa";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "Convertir al ícono de rastreo al estar cerca";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "Rastrear a: %d metros";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "Activar la función de habilidad de rastreo";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "Opacidad de íconos: %d%%";
		["CONFIG_OPEN_FILTER_LABEL"]	= "Nodos de tesoros por rastrear";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "Cambio de perfil: %1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "Crear copia";
		["CONFIG_PROFILE_CREATE_NEW"]	= "Crear nuevo";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "Activar un perfil actual";
		["CONFIG_PROFILE_NEW"]	= "Crear o reemplazar un perfil";
		["CONFIG_PROFILE_NEW_LABEL"]	= "Nombre del nuevo perfil:";
		["CONFIG_SECTION_ABOUT"]	= "Acerca de";
		["CONFIG_SECTION_GENERAL"]	= "General";
		["CONFIG_SECTION_HEADER_CORE"]	= "Opciones principales";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "Complementos";
		["CONFIG_SECTION_MINIMAP"]	= "Minimapa";
		["CONFIG_SECTION_OPEN"]	= "Tesoros";
		["CONFIG_SECTION_PROFILES"]	= "Perfiles";
		["CONFIG_SECTION_SHARING"]	= "Compartir";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "Acerca de Gatherer";
		["CONFIG_SECTION_TITLE_ARCH"]	= "Opciones de arqueología";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "Opciones principales de Gatherer";
		["CONFIG_SECTION_TITLE_HERB"]	= "Opciones de filtros de herboristería";
		["CONFIG_SECTION_TITLE_MINE"]	= "Opciones de filtros de minería";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "Opciones del minimapa de Gatherer";
		["CONFIG_SECTION_TITLE_OPEN"]	= "Opciones del filtro de tesoros";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "Configurar y editar perfiles";
		["CONFIG_SECTION_TITLE_SHARING"]	= "Opciones de sincronización";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "Lista negra de uso compartido";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "Agregar recolecciones recibidas del grupo a mi base de datos";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "Activar sincronización con grupo";
		["CONFIG_SHARING_GROUP_LABEL"]	= "Compartir con grupo o banda";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "Mostrar un mensaje al recibir una recolección del grupo";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "Mostrar un mensaje al enviar una recolección al grupo";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "Agregar recolecciones recibidas de la hermandad a mi base de datos";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "Activar sincronización con hermandad";
		["CONFIG_SHARING_GUILD_LABEL"]	= "Compartir con hermandad";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "Mostrar un mensaje al recibir una recolección de la hermandad";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "Mostrar un mensaje al enviar una recolección a la hermandad";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "Mostrar un mensaje al agregar una recolección propia a la base de datos";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "Alerta personal";
		["CONFIG_TOOLTIP_COUNTS"]	= "Mostrar conteos de recolección";
		["CONFIG_TOOLTIP_DISTANCE"]	= "Mostrar distancia al nodo";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "Mostrar frecuencias de apariciones";
		["CONFIG_TOOLTIP_ENABLE"]	= "Mostrar información sobre herramientas";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "Mostrar última visita";
		["CONFIG_TOOLTIP_SOURCE"]	= "Mostrar fuente de la nota";
		["CONFIG_WORLDMAP_ENABLE"]	= "Mostrar notas en el Mapa del mundo";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "Tamaño de los íconos: %d";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "Mostrar: %d notas";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "Opacidad: %d%%";
		["ENABLE_OPEN"]	= "Mostrar nodos de tesoros";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "Alamuerte, en su calidad de supervillano malvado, quemó todas las hierbas, derritió todos los depósitos de minerales y destruyó todos los cofres. Ahora, deben volver a crecer, cristalizarse o esconderse, y seguramente lo harán en nuevas ubicaciones. ¡Hay que encontrarlos!\n(Los datos anteriores se eliminaron, debido a los cambios drásticos en la geografía).";
		["STORAGE_DB_VERSION_INVALID"]	= "ADVERTENCIA:\nGatherer detectó que la versión de tu base de datos no es válida. Presiona Aceptar para limpiarla o selecciona Ignorar si deseas intentar repararla manualmente.";
		["STORAGE_DB_VERSION_NEWER"]	= "Tu base de datos de Gatherer guardada es demasiado nueva. Tu base de datos actual se ha apartado hasta que actualices Gatherer.";

		-- Section: Game Object Tooltip
		["GAME_OBJECT_REQUIRES_REWRITE"]	= "%1$s %2$d";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Abre la ventana de opciones";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Polen de polvo abisal";
		["ORE_ADAMANTITE"]	= "Adamantita";
		["ORE_BLOODSTONE"]	= "Sangrita inferior";
		["ORE_COPPER"]	= "Cobre";
		["ORE_DARKIRON"]	= "Hierro negro";
		["ORE_FELIRON"]	= "Hierro vil";
		["ORE_GOLD"]	= "Oro";
		["ORE_INCENDICITE"]	= "Incendicita";
		["ORE_INDURIUM"]	= "Indurio";
		["ORE_IRON"]	= "Hierro";
		["ORE_KHORIUM"]	= "Korio";
		["ORE_MITHRIL"]	= "Mithril";
		["ORE_NETHERCITE"]	= "Abisalita";
		["ORE_OBSIDIAN"]	= "Obsidiana";
		["ORE_RADAMANTITE"]	= "Deposito rico en adamantita";
		["ORE_RTHORIUM"]	= "Deposito rico en torio";
		["ORE_SILVER"]	= "Plata";
		["ORE_THORIUM"]	= "Torio";
		["ORE_TIN"]	= "Estaño";
		["ORE_TRUESILVER"]	= "Veraplata";
		["TREASURE_BARREL"]	= "Barriles";
		["TREASURE_BLOODPETAL"]	= "Brote pétalo de sangre";
		["TREASURE_BOX"]	= "Cajas";
		["TREASURE_CASK"]	= "Barriles";
		["TREASURE_CHEST"]	= "Cofres del tesoro";
		["TREASURE_CLAM"]	= "Almejas gigantes";
		["TREASURE_CRATE"]	= "Cajones";
		["TREASURE_FOOTLOCKER"]	= "Cajas personales";
		["TREASURE_GLOWCAP"]	= "Fluochampiñones";
		["TREASURE_NIGHTDRAGON"]	= "Aliento de Dragón nocturno";
		["TREASURE_POWERCRYST"]	= "Cristales de poder";
		["TREASURE_SHELLFISHTRAP"]	= "Trampas de marisco";
		["TREASURE_SONGFLOWER"]	= "Melodías";
		["TREASURE_UNGOROSOIL"]	= "Tierra de Un'Goro";
		["TREASURE_WHIPPERROOT"]	= "Tubérculos de blancoria";
		["TREASURE_WINDBLOSSOM"]	= "Bayas de flor de viento";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 aparición(es) adicional(es)";
		["NOTE_COUNT"]	= "Recogido %1 veces";
		["NOTE_DISTANCE"]	= "Distancia: %1 metros";
		["NOTE_IMPORTED"]	= "Recolecciones Importadas";
		["NOTE_LASTVISITED"]	= "Ultima visita: %1";
		["NOTE_OVERALLDROPS"]	= "Frecuencia total de apariciones:";
		["NOTE_SOURCE"]	= "Fuente: %1";
		["NOTE_UNSKILLED"]	= "Recogido Sin Habilidad";

		-- Section: Time
		["DAYS"]	= "Dia";
		["DAYS_ABBR"]	= "D";
		["DAYS_ABBR_P1"]	= "D";
		["DAYS_P1"]	= "Dias";
		["HOURS"]	= "Hora";
		["HOURS_ABBR"]	= "Hr";
		["HOURS_ABBR_P1"]	= "Hrs";
		["HOURS_P1"]	= "Horas";
		["MINUTES"]	= "Minuto";
		["MINUTES_ABBR"]	= "Min";
		["MINUTES_ABBR_P1"]	= "Mins";
		["MINUTES_P1"]	= "Minutos";
		["SECONDS"]	= "Segundo";
		["SECONDS_ABBR"]	= "Sec";
		["SECONDS_ABBR_P1"]	= "Sec";
		["SECONDS_P1"]	= "Segundos";
		["WEEKS"]	= "Semana";
		["WEEKS_ABBR"]	= "Semana";
		["WEEKS_ABBR_P1"]	= "Semanas";
		["WEEKS_P1"]	= "Semanas";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "Arqueología";
		["TRADE_HERBALISM"]	= "Herboristería";
		["TRADE_MINING"]	= "Mineria";

	};

	frFR = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "Envoi de %1 à %2";
		["COMM_NODE_SEND_TWO"]	= "Envoi de %1 à %2 et %3";
		["COMM_RECEIVE_NODE"]	= "Réception %1 à %2 venant de %3 (%4)";
		["NODE_ADD"]	= "Ajout %1";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Voir message au chargement";
		["CONFIG_ALL_FILTER_NOTE"]	= "l'option '%1' force les filtres courants à être ignorés et affichera tous les ressources de cette catégorie";
		["CONFIG_ARCH_MAX_NOTES"]	= "Affichage : %d le plus proche";
		["CONFIG_ENABLE_HERB"]	= "Voir notes d'herboristerie";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "Herboristerie Seulement";
		["CONFIG_ENABLE_MINE"]	= "Voir notes de minage";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "Mineur Seulement";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "Seulement en recherche";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "Bouton d'option Minimap";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "Options de recherche Minimap";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "Options Carte du Monde";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "Options de recherche Carte de Monde";
		["CONFIG_HERB_FILTER_LABEL"]	= "Ressources d'herboristerie à rechercher";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "Êtes-vous certain de vouloir effacer de votre base de donnée toutes les informations partagées par ce joueur? Cettes opération NE PEU PAS être annulé et retirera %d ressources de votre base de donnée";
		["CONFIG_IGNORE_PURGE_DONE"]	= "%d ressource(s) ont été effacée(s) de manière permanente de votre base de donnée Gatherer";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "Voulez-vous retirer toutes les ressources qui ont été partagée par ce joueur?";
		["CONFIG_MINE_FILTER_LABEL"]	= "Ressources de minerais à surveiller";
		["CONFIG_MINIICON_ANGLE"]	= "Angle du bouton: %d°";
		["CONFIG_MINIICON_DISTANCE"]	= "Distance: %d";
		["CONFIG_MINIICON_ENABLE"]	= "Afficher Bouton Minimap";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "Option Minimap";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "Afficher les ressources inderterminées";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "opacité des ressources indéterminées";
		["CONFIG_MINIMAP_ANON_TINT"]	= "Colorer les ressources indéterminées en rouge";
		["CONFIG_MINIMAP_DISTANCE"]	= "Distance : %d mètres";
		["CONFIG_MINIMAP_ENABLE"]	= "Afficher les notes sur la Minimap";
		["CONFIG_MINIMAP_FADE_DIST"]	= "Transparence à: %d mètres";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "Disparition des mini-notes";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "Disparition vue: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "Taille icônes : %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "Inspection à : %d mètres";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "Marquer comme inspecté";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "Inspecté disparition: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "Réinspecté: %d secs";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "Afficher en vert les inspectés";
		["CONFIG_MINIMAP_LABEL"]	= "Options Minimap";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "Affiche les: %d plus proches";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "Opacité par défaut: %d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "Seulement si recherche actif";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "Transformer en icone de recherche quand refermé";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "Chercher à: %d mètres";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "Activer la fonctionnalité de suivi";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "Opacité d'icône: %d%%";
		["CONFIG_OPEN_FILTER_LABEL"]	= "Choisir les trésors à chercher";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "Changement de profil: %1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "Créer copie";
		["CONFIG_PROFILE_CREATE_NEW"]	= "Créer nouveau";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "Profil actuellement activé";
		["CONFIG_PROFILE_NEW"]	= "Créer ou remplacer un profil";
		["CONFIG_PROFILE_NEW_LABEL"]	= "Nouveau nom de profil:";
		["CONFIG_SECTION_ABOUT"]	= "A propos";
		["CONFIG_SECTION_GENERAL"]	= "Général";
		["CONFIG_SECTION_HEADER_CORE"]	= "Options Général";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "Plugins";
		["CONFIG_SECTION_MINIMAP"]	= "Minimap";
		["CONFIG_SECTION_OPEN"]	= "Trésor";
		["CONFIG_SECTION_PROFILES"]	= "Profils";
		["CONFIG_SECTION_SHARING"]	= "Partage";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "A propos de Gatherer";
		["CONFIG_SECTION_TITLE_ARCH"]	= "Option d'archéologie";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "Options Générales Gatherer";
		["CONFIG_SECTION_TITLE_HERB"]	= "Options Filtre Herboristerie";
		["CONFIG_SECTION_TITLE_MINE"]	= "Options Filtre Minage";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "Option Minimap Gatherer";
		["CONFIG_SECTION_TITLE_OPEN"]	= "Option Filtre Trésor";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "Configuration de profil";
		["CONFIG_SECTION_TITLE_SHARING"]	= "Option de Synchronisation";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "Liste Noire de Partage";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "Ajouter les notes envoyées par les membres du groupe dans ma base de données";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "Synchronisation de groupe activée";
		["CONFIG_SHARING_GROUP_LABEL"]	= "Partage Raid/Groupe";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "Afficher un message lors d'une notification de récolte du groupe";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "Afficher un message lors de l'envoi d'une note au groupe";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "Ajouter les notes venant des membres de la guilde";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "Synchronisation de guilde activé";
		["CONFIG_SHARING_GUILD_LABEL"]	= "Partage de Guilde";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "Afficher un message lors d'une notification de récolte de la guilde";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "Afficher un message lors de l'envoi d'une note à la guilde";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "Afficher un message quand une note s'ajoute à ma base de donnée";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "Alerte personnelle";
		["CONFIG_TOOLTIP_COUNTS"]	= "Afficher le nombre de zones de ressources";
		["CONFIG_TOOLTIP_DISTANCE"]	= "Afficher distance note";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "Afficher taux de drop";
		["CONFIG_TOOLTIP_ENABLE"]	= "Afficher les astuces";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "Afficher la plus récente visualisation de la ressource";
		["CONFIG_TOOLTIP_SOURCE"]	= "Afficher la source de la note";
		["CONFIG_WORLDMAP_ENABLE"]	= "Afficher la note sur la carte du monde";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "Taille d'icône: %d";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "Afficher: %d notes";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "Opacité: %d%%";
		["ENABLE_OPEN"]	= "Voir note trésor";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "Depuis l'arrivée du boss Aile-de-mort avec l'extension Cataclysm, certaines zones ont subis une transformation et donc les notes de l'ancien monde ont été supprimées";
		["STORAGE_DB_VERSION_INVALID"]	= "ATTENTION !!!\nGatherer à détecté que la version de votre base de donnée est invalide. Appuyer sur \"accepter\" pour effacer votre base de donnée, ou sur \"ignorer\" si vous voulez essayer de la réparer manuellement";
		["STORAGE_DB_VERSION_NEWER"]	= "Votre base de donnée de Gatherer est trop récente. Votre base de donnée à été mise de coté jusqu'à ce que vous mettiez Gatherer à jour.";

		-- Section: Game Object Tooltip
		["GAME_OBJECT_REQUIRES_REWRITE"]	= "%1$s %2$d";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "Distance";
		["REPORT_COLUMN_HEADER_REGION"]	= "Région";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "Source";
		["REPORT_COLUMN_HEADER_TYPE"]	= "Type";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "Voulez-vous supprimer les %d marques ?";
		["REPORT_DELETE_MARKED"]	= "Effacer la sélection";
		["REPORT_MARKED_NODES_COUNT"]	= "notes sélectionnées : %1";
		["REPORT_MARKING_NOTE"]	= "Lorsque vous sélectionnez les notes, elles le resteront  jusqu'à ce que vous les dé-sélectionnez en utilisant les boutons ci-dessus.";
		["REPORT_MARK_THESE"]	= "Tout marquer";
		["REPORT_SEARCH_BY_REGION"]	= "Par Région";
		["REPORT_SEARCH_BY_SOURCE"]	= "Par Source";
		["REPORT_SEARCH_BY_TYPE"]	= "Par Type";
		["REPORT_SEND_MARKED"]	= "Envoyer la selection";
		["REPORT_TITLE"]	= "Rapport de ressources";
		["REPORT_UNMARK_ALL"]	= "Tout déselectionner";
		["REPORT_UNMARK_THESE"]	= "Décocher celles-ci";

		-- Section: Generic Messages
		["DESCRIPTION"]	= "Gatherer est un addon qui vous permet de mémoriser les emplacements de collecte et de les revoir sur votre Carte, Minimap ou de les afficher sur une interface à l'écran. Il vous permet également de faire un partage des marques découvertes avec votre guilde, raid ou vos amis en groupe.";
		["DESCRIPTION_LICENSE"]	= "Gatherer est un addon en Open-Source et est sous licence GNU v2 General Public License. Pour plus d'information sur la licence voir le fichier gpl.txt inclus avec l'addon.";
		["LOADED_NOTIFICATION"]	= "Gatherer v%1 -- Chargé!";
		["MANIFEST_INVALID_VERSIONS_WARNING"]	= "Attention : Votre installation de Gatherer semble avoir certains fichiers corrompu.\n\nS'il vous plaît assurez-vous d'avoir correctement supprimé l'ancien: 1% répertoire et réinstaller une nouvelle version à partir de: 2% et redémarrer WoW Complètement avant de faire une requête de bug.\n\nMerci, l'Equipe de Dev. Gatherer";
		["VERSION_MESSAGE"]	= "Gatherer v%1";
		["ZONETOKENS_UNIDENTIFIED_ZONES_WARNING"]	= "Gatherer ne peut identifier les zones suivantes: {{1}}%\nSi ce sont de nouvelles zones, alors ce n'est pas un problème et vous pouvez donc continuer comme d'habitude.\nSi ce ne sont pas de nouvelle zones, vous devez donc mettre à jour votre Gatherer pour y accéder, les anciennes marques seront toujours présente et les nouvelles collecte seront fusionnés avec vos anciennes données une fois la mise à jour effectuée.";

		-- Section: Generic Strings
		["ACCEPT"]	= "Accepter";
		["ALL"]	= "Tous";
		["CANCEL"]	= "Annuler";
		["DELETE"]	= "Supprimer";
		["DONE"]	= "Fini";
		["ENABLE"]	= "Activer";
		["IGNORE"]	= "Ignorer";
		["IGNORE_PLAYER"]	= "Ignorer joueur";
		["NO"]	= "Non";
		["OKAY"]	= "Ok";
		["SEARCH"]	= "Chercher";
		["STOP_IGNORE"]	= "Supprimer joueur";
		["STRATA_BACKGROUND"]	= "Fond";
		["STRATA_HIGH"]	= "Haut";
		["STRATA_LOW"]	= "Bas";
		["STRATA_MEDIUM"]	= "Moyen";
		["YES"]	= "Oui";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "{{Clic}} pour afficher/cacher les notes.";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{Clic-Droit}} Pour voir le tableau des marques.";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "{{Maj-Clic}} Pour voir le HUD à l'écran.";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "{{Maj-Clic-Droit}} pour afficher les options.";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "HUD";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "HUD Option d'affichage";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "HUD : Suivi du trajet parcouru";
		["HUD_CONFIG_HIDING_LABEL"]	= "HUD : Options d'affichage et masquage";
		["HUD_CONFIG_plugin.gatherer_hud.alpha"]	= "HUD alpha général : %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "Angle de vue: %d°";
		["HUD_CONFIG_plugin.gatherer_hud.base.color"]	= "Couleur de soulignement";
		["HUD_CONFIG_plugin.gatherer_hud.base.enable"]	= "Assombrir HUD pour améliorer la visibilité";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "Couleur du centre";
		["HUD_CONFIG_plugin.gatherer_hud.center.enable"]	= "Activer la zone de vue autour du joueur";
		["HUD_CONFIG_plugin.gatherer_hud.fade"]	= "Atténuation de l'affichage des notes à : %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.heat.color"]	= "Couleur principale";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "Temps de suivi : %d secondes";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "Afficher le chemin parcouru";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "Pas de cooldown";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "Largeur du tracé de chemin parcouru";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "Cacher pendant le combat";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "Cacher en vol";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "Cacher en intérieur";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "Cacher quand monté";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "Cacher pendant la regen";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "Cacher pendant le camouflage";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "Cacher pendant la nage";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "Cacher en ciblant";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "cacher quand non monté";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "Taille note: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"]	= "FPS minimal pour affichage optimal : %dfps";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "Décalage Horizontale: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "Décalage Verticale: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "Couleur des membres du groupe";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "Voir les autres membres du groupe";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "Taille d'icône groupe: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "Niveau de perspective : %0.1f";
		["HUD_CONFIG_plugin.gatherer_hud.radius"]	= "Taille générale du HUD : %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "distance des notes : %d yards";
		["HUD_CONFIG_STRATA_LABEL"]	= "Qualité d'affichage du HUD";
		["HUD_CONFIG_USAGE_NOTE"]	= "L'utilisation du HUD peut entrainer une baisse de votre fps, et plus encore si vous utilisez le suivi du trajet parcouru.";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "HUD Options Visibilité";
		["HUD_DESCRIPTION"]	= "Le HUD est un outil de navigation qui vous permet de suivre les emplacements des ressources sur votre écran à la façon d'un viseur tête haute";
		["HUD_TITLE"]	= "Plugin de Visualisation Tête Haute pour Gatherer";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "Vos marques CT_MapMod ont été importées.";
		["IMPORT_CTMOD_NODATA"]	= "Aucune marque CT_MapMod n'a été trouvée.";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Affiche/Ferme les Options";

		-- Section: Labels
		["GENERAL_LABEL"]	= "Général";
		["LABEL_CONFIG"]	= "Configuration";
		["LABEL_DENSITY_REPORT"]	= "Recherche note";
		["LABEL_NOTE"]	= "Note";
		["LABEL_REPORT"]	= "Tableau des marques";
		["MAP_NOTES_HIDE"]	= "Masquer les objets";
		["MAP_NOTES_SHOW"]	= "Afficher les objets";
		["NOTIFICATIONS_TITLE"]	= "Gatherer: Alerte";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "Chargement annulé.";
		["MASS_SHARING_ABORTED"]	= "Annulé à %1";
		["MASS_SHARING_ACCEPTED"]	= "Début...";
		["MASS_SHARING_ASKING"]	= "Demande...";
		["MASS_SHARING_BUSY"]	= "Joueur absent.";
		["MASS_SHARING_CLOSED"]	= "Fermé.";
		["MASS_SHARING_COMPLETE"]	= "Succès!";
		["MASS_SHARING_DONE"]	= "Terminé %1";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%1$s veut vous envoyer %2$d marques, Accepter?";
		["MASS_SHARING_GATHERER_REPORT_TRANSMIT"]	= "Voulez-vous envoyer %1$s marques à %2$s\n(Rappel, l'autre joueur doit ouvrir sa fenêtre de Gatherer.)";
		["MASS_SHARING_RECEIVED_COUNT"]	= "Reçu 1%";
		["MASS_SHARING_REJECT"]	= "Rejeté!";
		["MASS_SHARING_SENDING"]	= "Envoi...";
		["MASS_SHARING_SENT"]	= "Expédié 1%";
		["MASS_SHARING_TIMEOUT"]	= "Temps écoulé.";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Pollen de pruinéante";
		["ORE_ADAMANTITE"]	= "Adamantite";
		["ORE_BLOODSTONE"]	= "Pierre de Sang Inférieure";
		["ORE_COPPER"]	= "Cuivre";
		["ORE_DARKIRON"]	= "Sombrefer";
		["ORE_FELIRON"]	= "Gangrefer";
		["ORE_GOLD"]	= "Or";
		["ORE_INCENDICITE"]	= "Incendicite";
		["ORE_INDURIUM"]	= "Indurium";
		["ORE_IRON"]	= "Fer";
		["ORE_KHORIUM"]	= "Khorium";
		["ORE_MITHRIL"]	= "Mithril";
		["ORE_NETHERCITE"]	= "Néanticite";
		["ORE_OBSIDIAN"]	= "Obsidienne";
		["ORE_RADAMANTITE"]	= "Riche gisement d'adamantite";
		["ORE_RTHORIUM"]	= "Riche filon de thorium";
		["ORE_SILVER"]	= "Argent";
		["ORE_THORIUM"]	= "Thorium";
		["ORE_TIN"]	= "Etain";
		["ORE_TRUESILVER"]	= "Vrai-argent";
		["TREASURE_BARREL"]	= "Tonneaux";
		["TREASURE_BLOODPETAL"]	= "Pousse de Pétale-de-sang";
		["TREASURE_BOX"]	= "Boîtes";
		["TREASURE_CASK"]	= "Tonneaux";
		["TREASURE_CHEST"]	= "Coffres";
		["TREASURE_CLAM"]	= "Palourdes Géantes";
		["TREASURE_CRATE"]	= "Caisses";
		["TREASURE_FOOTLOCKER"]	= "Cantines";
		["TREASURE_GLOWCAP"]	= "Chapeluisant";
		["TREASURE_NIGHTDRAGON"]	= "Souffle de dragon nocturne";
		["TREASURE_POWERCRYST"]	= "Cristaux de puissance";
		["TREASURE_SHELLFISHTRAP"]	= "Casier à crustacés";
		["TREASURE_SONGFLOWER"]	= "Fleur-de-chant";
		["TREASURE_UNGOROSOIL"]	= "Humus d'Un'Goro";
		["TREASURE_WHIPPERROOT"]	= "Tubercule de navetille";
		["TREASURE_WINDBLOSSOM"]	= "Baie de fleur-de-vent";

		-- Section: Node Database Plugins
		["DATABASE_IMPORT_BUTTON_LABEL"]	= "Importer";
		["DATABASE_IMPORT_HEADER"]	= "Importation de la base de données en cours";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "Localisation";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "Notes";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "Pourcentage";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "Type";
		["DENSITY_SEARCH_TITLE"]	= "Rechercher un objet";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 objet(s) supplémentaire(s)";
		["NOTE_COUNT"]	= "Collecté %1 fois";
		["NOTE_DISTANCE"]	= "Distance: %1 mètre(s)";
		["NOTE_IMPORTED"]	= "Collecte importée";
		["NOTE_LASTVISITED"]	= "Dernière visite: %1";
		["NOTE_OVERALLDROPS"]	= "Fréquence générale:";
		["NOTE_SOURCE"]	= "Source: %1";
		["NOTE_UNSKILLED"]	= "Collecte hors-compétence";

		-- Section: Time
		["DAYS"]	= "Jour";
		["DAYS_ABBR"]	= "Jour";
		["DAYS_ABBR_P1"]	= "Jours";
		["DAYS_P1"]	= "Jours";
		["HOURS"]	= "Heure";
		["HOURS_ABBR"]	= "H";
		["HOURS_ABBR_P1"]	= "H";
		["HOURS_P1"]	= "Heures";
		["MINUTES"]	= "minute";
		["MINUTES_ABBR"]	= "Min";
		["MINUTES_ABBR_P1"]	= "Min";
		["MINUTES_P1"]	= "Minutes";
		["SECONDS"]	= "Seconde";
		["SECONDS_ABBR"]	= "Sec";
		["SECONDS_ABBR_P1"]	= "Sec";
		["SECONDS_P1"]	= "Secondes";
		["WEEKS"]	= "Semaine";
		["WEEKS_ABBR"]	= "Sem";
		["WEEKS_ABBR_P1"]	= "Sem";
		["WEEKS_P1"]	= "Semaines";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "Archéologie";
		["TRADE_HERBALISM"]	= "Herboristerie";
		["TRADE_MINING"]	= "Minage";

	};

	itIT = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "Inviato nodo di %1 a %2";
		["COMM_NODE_SEND_TWO"]	= "Inviato nodo di %1 a %2 e %3";
		["COMM_RECEIVE_NODE"]	= "Ricevuto nodo di %1 a %2 da %3 (%4)";
		["NODE_ADD"]	= "Aggiunto nodo di %1";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Mostra Messaggio Caricato";
		["CONFIG_ALL_FILTER_NOTE"]	= "L'opzione %1 fa in modo che i filtri attuali siano ignorati o obbliga a essere mostrati tutti i nodi in quella categoria.";
		["CONFIG_ARCH_MAX_NOTES"]	= "Mostra: %d più vicino";
		["CONFIG_ENABLE_HERB"]	= "Mostra nodi Erbalismo";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "Solo per Erboristi";
		["CONFIG_ENABLE_MINE"]	= "Mostra i punti d'estrazione";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "Solo per Estrattori";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "Solo se tracciati";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "Opzioni Pulsante Minimappa";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "Opzioni tracciamento minimappa";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "Opzioni Mappa del Mondo";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "Opzioni Traccia Mappa del Mondo";
		["CONFIG_HERB_FILTER_LABEL"]	= "Nodi erbe da tracciare";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "Sei sicuro di voler eliminare tutte le condivisioni dal tuo database di quel giocatore? Questa operazione NON può essere fermata e eliminerà i nodi %d dal tuo database.";
		["CONFIG_IGNORE_PURGE_DONE"]	= "I nodi di %d sono stati rimossi completamente dal tuo database Gatherer.";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "Desideri rimuovere tutti i nodi che sono stati condivisi da questo giocatore?";
		["CONFIG_MINE_FILTER_LABEL"]	= "Nodi minerali da tracciare";
		["CONFIG_MINIICON_ANGLE"]	= "Angolo del pulsante: %d°";
		["CONFIG_MINIICON_DISTANCE"]	= "Distanza: %d";
		["CONFIG_MINIICON_ENABLE"]	= "Mostra pulsante Minimappa";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "Minimappa Aggiuntiva";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "Mostra nodi anonimi";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "Opacità: %d%%";
		["CONFIG_MINIMAP_ANON_TINT"]	= "Tingi i nodi anonimi di rosso";
		["CONFIG_MINIMAP_DISTANCE"]	= "Distanza: %d iarde";
		["CONFIG_MINIMAP_ENABLE"]	= "Mostra le note sulla Minimappa";
		["CONFIG_MINIMAP_FADE_DIST"]	= "Scompari a: %d iarde";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "Fai scomparire le mini note";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "Distanza trasparenza: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "Gradenzza Icona: %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "Ispeziona a: %d iarde";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "Evidenzia i nodi come ispezionati";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "Trasparenza ispezionati: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "Ricontrolla: %d sec.";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "Tingi di verde mentre ispezioni";
		["CONFIG_MINIMAP_LABEL"]	= "Opzioni Minimappa";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "Mostra: %d più vicina";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "Opacità predefinita: %d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "Solo per le abilità traccianti attive";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "Converti ad icona tracciante quando chiudi";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "Traccia a: %d iarde";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "Attiva funzione tracciamento";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "Opacità icona: %d%%";
		["CONFIG_OPEN_FILTER_LABEL"]	= "Nodi del tesoro da tracciare";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "Aggiornamento profilo: %1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "Crea una copia";
		["CONFIG_PROFILE_CREATE_NEW"]	= "Crea nuovo";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "Attiva il profilo corrente";
		["CONFIG_PROFILE_NEW"]	= "Crea o rimpiazza profilo";
		["CONFIG_PROFILE_NEW_LABEL"]	= "Nuovo nome profilo:";
		["CONFIG_SECTION_ABOUT"]	= "Informazioni";
		["CONFIG_SECTION_GENERAL"]	= "Generali";
		["CONFIG_SECTION_HEADER_CORE"]	= "Opzioni Centrali";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "Plugin";
		["CONFIG_SECTION_MINIMAP"]	= "Minimappa";
		["CONFIG_SECTION_OPEN"]	= "Tesoro";
		["CONFIG_SECTION_PROFILES"]	= "Profili";
		["CONFIG_SECTION_SHARING"]	= "Condivisione";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "Su Gatherer";
		["CONFIG_SECTION_TITLE_ARCH"]	= "Opzioni Archeologia";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "Opzioni Principali Gatherer";
		["CONFIG_SECTION_TITLE_HERB"]	= "Opzioni Filtro Erbalismo";
		["CONFIG_SECTION_TITLE_MINE"]	= "Opzioni Filtro Estrazione";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "Opzioni minimappa Gatherer";
		["CONFIG_SECTION_TITLE_OPEN"]	= "Opzioni Filtro Tesori";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "Imposta, configura e modifica profili";
		["CONFIG_SECTION_TITLE_SHARING"]	= "Opzioni sincronizzazione";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "Lista nera condivioni";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "Aggiungi il gruppo di raccolta ricevuto al database";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "Attiva la sincronizzazione di gruppo";
		["CONFIG_SHARING_GROUP_LABEL"]	= "Condivisione Incursione/Gruppo";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "Mostra un messaggio quando ricevi una raccolta dal gruppo";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "Mostra un messaggio quando invii una raccolta al gruppo";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "Aggiungi le raccolte di gilda al database";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "Attiva sincronizzazione di gilda";
		["CONFIG_SHARING_GUILD_LABEL"]	= "Condivisione di Gilda";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "Mostra un messaggio quando ricevi una raccolta dalla gilda";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "Mostra un messaggio quando invii una raccolta alla gilda";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "Mostra un messaggio quando aggiungi la tua raccolta al DB";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "Avviso Personale";
		["CONFIG_TOOLTIP_COUNTS"]	= "Mostra il numero delle raccolte";
		["CONFIG_TOOLTIP_DISTANCE"]	= "Mostra la distanza dei nodi";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "Mostra il numero di drop";
		["CONFIG_TOOLTIP_ENABLE"]	= "Mostra suggerimenti";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "Mostra il tempo dell'ultima raccolta";
		["CONFIG_TOOLTIP_SOURCE"]	= "Mostra la fonte della nota";
		["CONFIG_WORLDMAP_ENABLE"]	= "Mostra le note sulla Mappa del Mondo";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "Grandezza Icona: %d";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "Mostra: note %d";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "Opacità: %d%%";
		["ENABLE_OPEN"]	= "Mostra i nodi dei tesori";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "Essendo il cattivo e crudele che è, il ritorno di Alamorte ha bruciato tutte le erbe, fuso i minerali e obliterato tutti i tesori. Ora devono ricrescere, essere ricristallizati o nascosti dai pirati e sono probabilmente in nuovi luoghi. Caccia al Tesoro!!! (I vecchi deti sono stati cancellati a causa dei cambiamenti geografici globali).";
		["STORAGE_DB_VERSION_INVALID"]	= "ATTENZIONE!!!\nGatherer ha individuato una versione errata del tuo database. Per favore, premi Accetta per eliminare il database, o seleziona ignora se vuoi cercare di riparare manualmente il database.";
		["STORAGE_DB_VERSION_NEWER"]	= "Il database salvato di Gatherer è troppo recente. Il tuo database attuale è stato messo da parte fino a quando non aggiornerai Gatherer.";

		-- Section: Game Object Tooltip
		["GAME_OBJECT_REQUIRES_REWRITE"]	= "%1$s %2$d";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "Dist";
		["REPORT_COLUMN_HEADER_REGION"]	= "Regione";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "Fonte";
		["REPORT_COLUMN_HEADER_TYPE"]	= "Tipo";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "Vuoi eliminare i nodi %d di Gatherer?";
		["REPORT_DELETE_MARKED"]	= "Elimina selezionati";
		["REPORT_MARKED_NODES_COUNT"]	= "Nodi selezionati: %1";
		["REPORT_MARKING_NOTE"]	= "Nota: Quando selezioni i nodi, rimarranno selezionati fino a quando non li deselezionerai cliccando l'oggetti nel rapporto, oppure usando i pulsanti di Deselezione in alto o ricaricando il gioco.";
		["REPORT_MARK_THESE"]	= "Seleziona questi";
		["REPORT_SEARCH_BY_REGION"]	= "Per Regione";
		["REPORT_SEARCH_BY_SOURCE"]	= "Per Fonte";
		["REPORT_SEARCH_BY_TYPE"]	= "Per Tipo";
		["REPORT_SEND_MARKED"]	= "Invia selezionati";
		["REPORT_TITLE"]	= "Rapporto Raccolti";
		["REPORT_UNMARK_ALL"]	= "Deseleziona tutti";
		["REPORT_UNMARK_THESE"]	= "Deseleziona questi";

		-- Section: Generic Messages
		["DESCRIPTION"]	= "Gatherer è un addon che ti consente di memorizzare i luoghi di raccolta e vederli tutti o alcuni sulla mappa principale, la tua minimappa, o su un'interfaccia a schermo. Consente inoltre di condividere le scoperte con la tua gilda, raid o i tuoi amici.";
		["DESCRIPTION_LICENSE"]	= "Gatherer è un sofrware libero ed è licenziato sotto la Licenza Pubblica Generale GNU v2. Per favore leggi il file gpl.txt, incluso con questo AddOn, per la licenza completa.";
		["LOADED_NOTIFICATION"]	= "Gatherer vers%1 -- Caricato!";
		["MANIFEST_INVALID_VERSIONS_WARNING"]	= "{{Attenzione:}} Sembra che la tua installazione di Gatherer abbia differenti versioni dei file.\nAssicurati di aver eliminato la vecchia cartella: \n  %1\nreinstalla una nuova versione da:\n  %2\nriavvia WoW completamente prima di riportare qualunque bug.\n\nGrazie,\n  Il Team Sviluppo Gatherer";
		["VERSION_MESSAGE"]	= "Questo è Gatherer vers.1%";
		["ZONETOKENS_UNIDENTIFIED_ZONES_WARNING"]	= "Gatherer non ha potuto identificare le seguenti zone: {{%1}}\nSe queste sono nuove regioni, non è un problema e potrai continuare come al solito. \nSe queste non sono nuove regioni, allora resta tranquillo perchè {{i tuoi dati NON SONO PERDUTI!}} I tuoi dati per queste zone sono ancora intatti, ma dovrai aggiornare Gatherer per accedervi. Fino ad allora potrai continuare a giocare come sempre e ogni nuovo dato che raccoglierai, sarà unito con i tuoi vecchi dati, quando effettuerai l'aggiornamento. \n\n{{Per favore aggiorna Gatherer quando possibile.}}";

		-- Section: Generic Strings
		["ACCEPT"]	= "Accetta";
		["ALL"]	= "Tutti";
		["CANCEL"]	= "Cancella";
		["DELETE"]	= "Elimina";
		["DONE"]	= "Fatto";
		["ENABLE"]	= "Attiva";
		["IGNORE"]	= "Ignora";
		["IGNORE_PLAYER"]	= "Ignora Giocatore";
		["NO"]	= "No";
		["OKAY"]	= "Ok";
		["SEARCH"]	= "Cerca";
		["STOP_IGNORE"]	= "Rimuovi Giocatore";
		["STRATA_BACKGROUND"]	= "Sfondo";
		["STRATA_HIGH"]	= "Alto";
		["STRATA_LOW"]	= "Basso";
		["STRATA_MEDIUM"]	= "Medio";
		["YES"]	= "Si";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "{{Clicca}} per attivare la schermata dei nodi.";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{Clic Destro}} per vedere il rapporto di raccolta.";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "{{Maiuscolo-Clic Sinistro}} per attivare l'interfaccia HUD.";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "{{Maiuscolo-Clic Destro}} per modificare le opzioni.";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "HUD";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "Opzioni Finestra HUD";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "Modalità Ricerca Calore HUD";
		["HUD_CONFIG_HIDING_LABEL"]	= "Opzioni Invsibilità HUD";
		["HUD_CONFIG_plugin.gatherer_hud.alpha"]	= "Alfa Generale HUD: %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "Angolo Visuale: %d°";
		["HUD_CONFIG_plugin.gatherer_hud.base.color"]	= "Colore Sfondo";
		["HUD_CONFIG_plugin.gatherer_hud.base.enable"]	= "Ombreggia l'HUD per aumentare la visibilità";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "Centra il colore";
		["HUD_CONFIG_plugin.gatherer_hud.center.enable"]	= "Attiva il cerchio del Campo Visivo del giocatore";
		["HUD_CONFIG_plugin.gatherer_hud.fade"]	= "Le note scompaiono alla distanza di: %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.heat.color"]	= "Colore Modalità Calore";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "Tempo di Ricarica traccia: %d secondi";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "Mostra la traccia di movimento (calore)";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "Nessun tempo di ricarica";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "Traccia la grandezza della scia: %d iarde";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "Nascondi mentre sei in combattimento";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "Nascondi mentre sei in volo";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "Nascondi mentre sei in luoghi chiusi";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "Nascondi quando sei su una cavalcatura";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "Nascondi quando ti riposi";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "Nascondi quando sei invisibile";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "Nascondi quando nuoti";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "Nascondo quando segui un bersaglio";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "Nascondi quando non sei su una cavalcatura";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "Grandezza note: %d pixel";
		["HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"]	= "Numero di Fotogrammi al secondo minimo da disegnare: %dfps";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "Sezione Orizzontale: %d pixel";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "Sezione verticale: %d pixel";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "Colore membri del gruppo";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "Mostra altri membri del gruppo";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "Grandezza icona del gruppo: %d pixel";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "Livello prospettiva: %0.1f";
		["HUD_CONFIG_plugin.gatherer_hud.radius"]	= "Raggio di ampiezza HUD: %d pixel";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "Raggio delle Note: %d iarde";
		["HUD_CONFIG_STRATA_LABEL"]	= "Strati HUD (Livello di Disegno)";
		["HUD_CONFIG_USAGE_NOTE"]	= "L'uso dell'HUD consumerà fotogrammi da quelli di gioco, e ne consumerà ancora di più se attiverai il tracciamento a \"Calore\" che tiene conto del tuo traffico precedente attraverso una scia di calore.";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "Opzioni Visibilità HUD";
		["HUD_DESCRIPTION"]	= "L'Hud è un componente di navigazione che ti consente di tracciare la posizione dei nodi di raccolta sul tuo schermo, come una sorta di nota in evidenza.";
		["HUD_TITLE"]	= "Gatherer Heads-Up Display Plugin";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "I tuoi dati CT_MapMod sono stati importati.";
		["IMPORT_CTMOD_NODATA"]	= "Non è stato trovato nessun dato CT_MapMod da importare.";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Mostra Sempre il Dialogo delle Opzioni";

		-- Section: Labels
		["GENERAL_LABEL"]	= "Generali";
		["LABEL_CONFIG"]	= "Config";
		["LABEL_DENSITY_REPORT"]	= "Ricerca Nodo";
		["LABEL_NOTE"]	= "Note";
		["LABEL_REPORT"]	= "Rapporti Raccolta nodi";
		["MAP_NOTES_HIDE"]	= "Nascondi Oggetti";
		["MAP_NOTES_SHOW"]	= "Mostra Oggetti";
		["NOTIFICATIONS_TITLE"]	= "Gatherer: Avvisi";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "Upload interrotto.";
		["MASS_SHARING_ABORTED"]	= "Interroto al %1";
		["MASS_SHARING_ACCEPTED"]	= "Avvio...";
		["MASS_SHARING_ASKING"]	= "Richiesta in corso...";
		["MASS_SHARING_BUSY"]	= "Utente occupato.";
		["MASS_SHARING_CLOSED"]	= "E' chiuso.";
		["MASS_SHARING_COMPLETE"]	= "Successo!";
		["MASS_SHARING_DONE"]	= "Completato al %1";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%1$s vuole inviarti i nodi %2$d di Gatherer. Confermi?";
		["MASS_SHARING_GATHERER_REPORT_TRANSMIT"]	= "Desideri inviare i nodi %1$s a %2$s? (Ricorda, devono avere la finestra Rapporti Gatherer aperta).";
		["MASS_SHARING_RECEIVED_COUNT"]	= "Ricevuto %1";
		["MASS_SHARING_REJECT"]	= "Rifiutato!";
		["MASS_SHARING_SENDING"]	= "Invio...";
		["MASS_SHARING_SENT"]	= "Inviato %1";
		["MASS_SHARING_TIMEOUT"]	= "Tempo scaduto.";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Polline di Nubefatua";
		["ORE_ADAMANTITE"]	= "Adamantite";
		["ORE_BLOODSTONE"]	= "Sanguinite Inferiore";
		["ORE_COPPER"]	= "Rame";
		["ORE_DARKIRON"]	= "Ferroscuro";
		["ORE_FELIRON"]	= "Vilferro";
		["ORE_GOLD"]	= "Oro";
		["ORE_INCENDICITE"]	= "Incendiocite";
		["ORE_INDURIUM"]	= "Indurio";
		["ORE_IRON"]	= "Ferro";
		["ORE_KHORIUM"]	= "Korio";
		["ORE_MITHRIL"]	= "Mithril";
		["ORE_NETHERCITE"]	= "Faturcite";
		["ORE_OBSIDIAN"]	= "Obsidio";
		["ORE_RADAMANTITE"]	= "Ricco di Adamantite";
		["ORE_RTHORIUM"]	= "Ricca di Torio";
		["ORE_SILVER"]	= "Argento";
		["ORE_THORIUM"]	= "Torio";
		["ORE_TIN"]	= "Stagno";
		["ORE_TRUESILVER"]	= "Verargento";
		["TREASURE_BARREL"]	= "Barili";
		["TREASURE_BLOODPETAL"]	= "Germoglio di Petalorosso";
		["TREASURE_BOX"]	= "Scatole";
		["TREASURE_CASK"]	= "Botti";
		["TREASURE_CHEST"]	= "Forzieri del Tesoro";
		["TREASURE_CLAM"]	= "Bivalve Giganti";
		["TREASURE_CRATE"]	= "Casse";
		["TREASURE_FOOTLOCKER"]	= "Scrigni";
		["TREASURE_GLOWCAP"]	= "Cappaluce";
		["TREASURE_NIGHTDRAGON"]	= "Mentina all'Alito di Drago";
		["TREASURE_POWERCRYST"]	= "Cristalli Energetico";
		["TREASURE_SHELLFISHTRAP"]	= "Trappole per Crostacei";
		["TREASURE_SONGFLOWER"]	= "Fiorcantanti";
		["TREASURE_UNGOROSOIL"]	= "Terreno di Un'Goro";
		["TREASURE_WHIPPERROOT"]	= "Tubero Sferzarapa";
		["TREASURE_WINDBLOSSOM"]	= "Bacche di Sbocciavento";

		-- Section: Node Database Plugins
		["DATABASE_IMPORT_BUTTON_LABEL"]	= "Importa";
		["DATABASE_IMPORT_HEADER"]	= "Importa il database dei nodi:";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "Posizione";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "# Nodi";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "Percentuale";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "Tipo";
		["DENSITY_SEARCH_TITLE"]	= "Ricerca Densità del Nodo";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 drop aggiuntivi";
		["NOTE_COUNT"]	= "Raccolto %1 volte";
		["NOTE_DISTANCE"]	= "Distanza: %1 metri";
		["NOTE_IMPORTED"]	= "Raccolta Importata";
		["NOTE_LASTVISITED"]	= "Ultima visita: %1";
		["NOTE_OVERALLDROPS"]	= "Probabilità drop complessiva:";
		["NOTE_SOURCE"]	= "Origine: %1";
		["NOTE_UNSKILLED"]	= "Skill raccolta troppo bassa";

		-- Section: Time
		["DAYS"]	= "Giorno";
		["DAYS_ABBR"]	= "Grn";
		["DAYS_ABBR_P1"]	= "Giorni";
		["DAYS_P1"]	= "Grni";
		["HOURS"]	= "Ora";
		["HOURS_ABBR"]	= "Ora";
		["HOURS_ABBR_P1"]	= "Ore";
		["HOURS_P1"]	= "Ore";
		["MINUTES"]	= "Minuto";
		["MINUTES_ABBR"]	= "Min";
		["MINUTES_ABBR_P1"]	= "Min";
		["MINUTES_P1"]	= "Minuti";
		["SECONDS"]	= "Secondo";
		["SECONDS_ABBR"]	= "Sec";
		["SECONDS_ABBR_P1"]	= "Sec";
		["SECONDS_P1"]	= "Secondi";
		["WEEKS"]	= "Settimana";
		["WEEKS_ABBR"]	= "Set";
		["WEEKS_ABBR_P1"]	= "Set";
		["WEEKS_P1"]	= "Settimane";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "Archeologia";
		["TRADE_HERBALISM"]	= "Erbalismo";
		["TRADE_MINING"]	= "Estrazione";

	};

	koKR = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "%1 에서 %2로 수집 보냄";
		["COMM_NODE_SEND_TWO"]	= "%1 에서 %2 와 %3로 수집 보냄";
		["NODE_ADD"]	= "%1에서 수집 추가됨";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "읽음 메세지 표시";
		["CONFIG_ARCH_MAX_NOTES"]	= "표시: %d 근접";
		["CONFIG_ENABLE_HERB"]	= "약초 노드 표시";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "약초만";
		["CONFIG_ENABLE_MINE"]	= "광물 노드 표시";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "광물만";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "추적 가능한 것만";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "미니맵 버튼 옵션";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "미니맵 추적 옵션";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "월드맵 옵션";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "월드맵 추적 옵션";
		["CONFIG_HERB_FILTER_LABEL"]	= "약초 노드 추적";
		["CONFIG_IGNORE_PURGE_DONE"]	= "Gatherer 데이터에서 %d 노드가 영구적으로 제거됩니다.";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "이 플레이어에게 공유한 모든 노드를 제거하기 원합니까?";
		["CONFIG_MINE_FILTER_LABEL"]	= "광물 노드 추적";
		["CONFIG_MINIICON_ANGLE"]	= "버튼 각도: %d";
		["CONFIG_MINIICON_DISTANCE"]	= "거리: %d";
		["CONFIG_MINIICON_ENABLE"]	= "미니맵 버튼 표시";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "미니맵 추가";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "익명의 노드 표시";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "근접 투명도: %d%%";
		["CONFIG_MINIMAP_ANON_TINT"]	= "익명의 노드 붉은색";
		["CONFIG_MINIMAP_DISTANCE"]	= "거리: %d 야드";
		["CONFIG_MINIMAP_ENABLE"]	= "미니맵에 노트 표시";
		["CONFIG_MINIMAP_FADE_DIST"]	= "사라짐: %d 야드";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "미니 노트 희미해짐";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "희미해지는 거리: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "아이콘 크기: %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "검사: %d 야드";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "표시된 노드 검사됨";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "검사 사라짐: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "재검사: %d 초";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "검사중 초록색";
		["CONFIG_MINIMAP_LABEL"]	= "미니맵 옵션";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "표시: %d 근접";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "기본 투명도: %d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "활성화된 추적 스킬만";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "닫을때 추적 아이콘 변환";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "추적: %d 야드";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "추적 스킬 특성 활성화";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "아이콘 투명도: %d%%";
		["CONFIG_OPEN_FILTER_LABEL"]	= "보물 노드 추적";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "프로필 변경: %1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "복사 생성";
		["CONFIG_PROFILE_CREATE_NEW"]	= "새로 생성";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "현제 프로필 활성화";
		["CONFIG_PROFILE_NEW"]	= "프로필 생성 또는 대체";
		["CONFIG_PROFILE_NEW_LABEL"]	= "새 프로파일 이름:";
		["CONFIG_SECTION_ABOUT"]	= "대해서";
		["CONFIG_SECTION_GENERAL"]	= "일반";
		["CONFIG_SECTION_HEADER_CORE"]	= "핵심 옵션";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "플러그인";
		["CONFIG_SECTION_MINIMAP"]	= "미니맵";
		["CONFIG_SECTION_OPEN"]	= "보물";
		["CONFIG_SECTION_PROFILES"]	= "프로필";
		["CONFIG_SECTION_SHARING"]	= "공유";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "Gatherer에 대해서";
		["CONFIG_SECTION_TITLE_ARCH"]	= "고고학 옵션";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "주 Gatherer 옵션";
		["CONFIG_SECTION_TITLE_HERB"]	= "약초 필터 옵션";
		["CONFIG_SECTION_TITLE_MINE"]	= "광물 필터 옵션";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "미니맵 Gatherer 옵션";
		["CONFIG_SECTION_TITLE_OPEN"]	= "보물 필터 옵션";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "셋업, 프로필 수정과 설정";
		["CONFIG_SECTION_TITLE_SHARING"]	= "동기화 옵션";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "공유 블랙리스트";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "나의 데이터에 그룹에서 받은 수집 추가";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "그룹 동기화 활성화";
		["CONFIG_SHARING_GROUP_LABEL"]	= "공격대/파티 공유";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "그룹 수집을 받았을 때 메세지 출력";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "그룹 수집 보낼때 메세지 출력";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "나의 데이터에 길드 수집 추가됨";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "길드 동기화 활성화";
		["CONFIG_SHARING_GUILD_LABEL"]	= "길드 공유";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "길드 수집을 받았을 때 메세지 출력";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "길드 수집을 보낼때 메세지 출력";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "DB에 나의 수집이 추가될 때 메세지 출력";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "개인 경고";
		["CONFIG_TOOLTIP_COUNTS"]	= "수집 갯수 표시";
		["CONFIG_TOOLTIP_DISTANCE"]	= "노드 거리 표시";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "드랍율 표시";
		["CONFIG_TOOLTIP_ENABLE"]	= "툴팁 표시";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "마지막 목격 시간 표시";
		["CONFIG_TOOLTIP_SOURCE"]	= "노트 소스 표시";
		["CONFIG_WORLDMAP_ENABLE"]	= "월드맵에 노트 표시";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "아이콘 사이즈: %d";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "표시: %d 노트";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "투명도: %d%%";
		["ENABLE_OPEN"]	= "보물 노드 표시";

		-- Section: Game Object Tooltip
		["GAME_OBJECT_REQUIRES_REWRITE"]	= "%1$s %2$d";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "거리";
		["REPORT_COLUMN_HEADER_REGION"]	= "지역";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "소스";
		["REPORT_COLUMN_HEADER_TYPE"]	= "종류";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "%d Gatherer 노드를 지우시겠습니까?";
		["REPORT_DELETE_MARKED"]	= "마크 삭제";
		["REPORT_MARKED_NODES_COUNT"]	= "마크된 노드: %1";
		["REPORT_MARK_THESE"]	= "이것 마크";
		["REPORT_SEARCH_BY_REGION"]	= "지역에";
		["REPORT_SEARCH_BY_SOURCE"]	= "소스에";
		["REPORT_SEARCH_BY_TYPE"]	= "종류에";
		["REPORT_SEND_MARKED"]	= "마크 보냄";
		["REPORT_TITLE"]	= "수집된 보고서";
		["REPORT_UNMARK_ALL"]	= "모든 마크 해제";
		["REPORT_UNMARK_THESE"]	= "이것 마크 해제";

		-- Section: Generic Strings
		["ACCEPT"]	= "수락";
		["ALL"]	= "전체";
		["CANCEL"]	= "취소";
		["DELETE"]	= "삭제";
		["DONE"]	= "완료";
		["ENABLE"]	= "활성";
		["IGNORE"]	= "무시";
		["IGNORE_PLAYER"]	= "무시한 플레이어";
		["NO"]	= "아니요";
		["OKAY"]	= "OK";
		["SEARCH"]	= "검색";
		["STOP_IGNORE"]	= "플레이어 제거";
		["STRATA_BACKGROUND"]	= "배경";
		["STRATA_HIGH"]	= "높음";
		["STRATA_LOW"]	= "낮음";
		["STRATA_MEDIUM"]	= "중간";
		["YES"]	= "예";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "{{Click}} 노드 표시/끄기";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{Right-Click}} 수집 보고서 보기";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "{{Shift-Click}} HUD 표시/끄기";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "{{Shift-Right-Click}} 설정 수정";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "HUD";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "HUD 표시 옵션";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "HUD 온도 추적 모드";
		["HUD_CONFIG_HIDING_LABEL"]	= "HUD 숨김 옵션";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "시야 각도: %d";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "중앙 색";
		["HUD_CONFIG_plugin.gatherer_hud.heat.color"]	= "온도 색";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "추적 쿨타임: %d 초";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "경로 추적 표시(온도)";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "쿨타임 없음";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "추적 자국 넓이: %d 야드";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "전투중에 숨김";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "비행중에 숨김";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "안에 있는중에 숨김";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "탈것타는 중에 숨김";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "휴식중에 숨김";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "은신중에 숨김";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "수영중에 숨김";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "타겟팅중에 숨김";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "걷는중에 숨김";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "노트 크기: %d 픽셀";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "수평 오프셋: %d 픽셀";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "수직 오프셋: %d 픽셀";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "파티 맴버 색";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "다른 파티 맴버 표시";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "파티 아이콘 크기: %d 픽셀";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "시각 레벨: %0.1f";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "노트 범위: %d 야드";
		["HUD_CONFIG_STRATA_LABEL"]	= "HUD 층 (레벨 그림)";
		["HUD_CONFIG_USAGE_NOTE"]	= "HUD 사용시 프레임 저하가 생기며, \"온도\" 추적 모드 의 온도 자국 유지시 프레임 저하가 더 발생합니다.";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "HUD 가시거리 옵션";
		["HUD_DESCRIPTION"]	= "HUD는 화면에 신속한 스타일로 지역의 수집가능한 요소를 추적할수 있게 해주는 네비게이션 입니다.";
		["HUD_TITLE"]	= "Gatherer 신속한 표시 플러그인";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "CT_MapMod 데이터가 변환 되었습니다.";
		["IMPORT_CTMOD_NODATA"]	= "변환할 CT_MapMod 데이터를 찾을수 없습니다.";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "야생 철쭉";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "야생 철쭉";

		-- Section: Labels
		["GENERAL_LABEL"]	= "일반";
		["LABEL_CONFIG"]	= "설정";
		["LABEL_DENSITY_REPORT"]	= "노드 검색";
		["LABEL_NOTE"]	= "노트";
		["LABEL_REPORT"]	= "수집된 보고서";
		["MAP_NOTES_HIDE"]	= "아이템 숨김";
		["MAP_NOTES_SHOW"]	= "아이템 보기";
		["NOTIFICATIONS_TITLE"]	= "Gatherer: 경고";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "업로드 취소됨.";
		["MASS_SHARING_ABORTED"]	= "%1에 취소됨";
		["MASS_SHARING_ACCEPTED"]	= "시작중...";
		["MASS_SHARING_ASKING"]	= "질의중...";
		["MASS_SHARING_BUSY"]	= "유저 바쁨.";
		["MASS_SHARING_CLOSED"]	= "닫힘.";
		["MASS_SHARING_COMPLETE"]	= "성공!";
		["MASS_SHARING_DONE"]	= "%1 완료됨";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%2$d Gatherer 노드를 %1$s 당신에가 보내기를 원합니다. 수락?";
		["MASS_SHARING_RECEIVED_COUNT"]	= "%1 받음";
		["MASS_SHARING_REJECT"]	= "거절!";
		["MASS_SHARING_SENDING"]	= "전송중...";
		["MASS_SHARING_SENT"]	= "%1 보냄";
		["MASS_SHARING_TIMEOUT"]	= "시간 초과.";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "황천티끌 꽃가루";
		["ORE_ADAMANTITE"]	= "아다만타이트";
		["ORE_BLOODSTONE"]	= "저급 혈석";
		["ORE_COPPER"]	= "구리";
		["ORE_DARKIRON"]	= "검은 무쇠";
		["ORE_FELIRON"]	= "지옥 무쇠";
		["ORE_GOLD"]	= "금";
		["ORE_INCENDICITE"]	= "발연";
		["ORE_INDURIUM"]	= "인듀리움";
		["ORE_IRON"]	= "철";
		["ORE_KHORIUM"]	= "코륨";
		["ORE_MITHRIL"]	= "미스릴";
		["ORE_NETHERCITE"]	= "황천연";
		["ORE_OBSIDIAN"]	= "흑요석";
		["ORE_RADAMANTITE"]	= "풍부한 아다만타이트";
		["ORE_RTHORIUM"]	= "풍부한 토륨";
		["ORE_SILVER"]	= "은";
		["ORE_THORIUM"]	= "토륨";
		["ORE_TIN"]	= "주석";
		["ORE_TRUESILVER"]	= "진은";
		["TREASURE_BARREL"]	= "통";
		["TREASURE_BLOODPETAL"]	= "붉은꽃잎 씨앗";
		["TREASURE_BOX"]	= "상자";
		["TREASURE_CASK"]	= "과즙통";
		["TREASURE_CHEST"]	= "보물 상자";
		["TREASURE_CLAM"]	= "대합";
		["TREASURE_CRATE"]	= "상자";
		["TREASURE_FOOTLOCKER"]	= "사물함";
		["TREASURE_GLOWCAP"]	= "초롱버섯";
		["TREASURE_NIGHTDRAGON"]	= "어둠용의 숨결";
		["TREASURE_POWERCRYST"]	= "마력의 수정";
		["TREASURE_SHELLFISHTRAP"]	= "가재 통발";
		["TREASURE_SONGFLOWER"]	= "노래꽃";
		["TREASURE_UNGOROSOIL"]	= "운고로 토양";
		["TREASURE_WHIPPERROOT"]	= "채찍뿌리 줄기";
		["TREASURE_WINDBLOSSOM"]	= "바람꽃 열매";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "지역";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "# 노드";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "퍼센트";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "종류";
		["DENSITY_SEARCH_TITLE"]	= "노드 밀도 검색";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 추가 드랍됨.";
		["NOTE_COUNT"]	= "%1번 채집(채광)함";
		["NOTE_DISTANCE"]	= "%1 미터 떨어짐";
		["NOTE_IMPORTED"]	= "게더러에서 가져오기";
		["NOTE_LASTVISITED"]	= "마지막 수집: %1";
		["NOTE_OVERALLDROPS"]	= "전체 드랍율:";
		["NOTE_SOURCE"]	= "정보 제공: %1";
		["NOTE_UNSKILLED"]	= "채집(채광)기술을 배우지 않음";

		-- Section: Time
		["DAYS"]	= "일";
		["DAYS_ABBR"]	= "일";
		["DAYS_ABBR_P1"]	= "일";
		["DAYS_P1"]	= "일";
		["HOURS"]	= "시";
		["HOURS_ABBR"]	= "시";
		["HOURS_ABBR_P1"]	= "시간";
		["HOURS_P1"]	= "시간";
		["MINUTES"]	= "분";
		["MINUTES_ABBR"]	= "분";
		["MINUTES_ABBR_P1"]	= "분";
		["MINUTES_P1"]	= "분";
		["SECONDS"]	= "초";
		["SECONDS_ABBR"]	= "초";
		["SECONDS_ABBR_P1"]	= "초";
		["SECONDS_P1"]	= "초";
		["WEEKS"]	= "주";
		["WEEKS_ABBR"]	= "주";
		["WEEKS_ABBR_P1"]	= "주";
		["WEEKS_P1"]	= "몇주";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "고고학";
		["TRADE_HERBALISM"]	= "약초채집";
		["TRADE_MINING"]	= "채광";

	};

	nlNL = {

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Verzamelaar";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Wissel Instellingen Dialoog";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Netherdust Pollen";
		["ORE_ADAMANTITE"]	= "Adamantite";
		["ORE_BLOODSTONE"]	= "Mindere Bloedsteen";
		["ORE_COPPER"]	= "koper";
		["ORE_DARKIRON"]	= "duister ijzer";
		["ORE_FELIRON"]	= "Fel ijzer";
		["ORE_GOLD"]	= "goud";
		["ORE_INCENDICITE"]	= "Incendicite";
		["ORE_INDURIUM"]	= "Indurium";
		["ORE_IRON"]	= "ijzer";
		["ORE_KHORIUM"]	= "Khorium";
		["ORE_MITHRIL"]	= "mithril";
		["ORE_NETHERCITE"]	= "Nethercite";
		["ORE_OBSIDIAN"]	= "Obsidian";
		["ORE_RADAMANTITE"]	= "Rijk Adamantite";
		["ORE_RTHORIUM"]	= "Rijk Thorium";
		["ORE_SILVER"]	= "zilver";
		["ORE_THORIUM"]	= "thorium";
		["ORE_TIN"]	= "tin";
		["ORE_TRUESILVER"]	= "waarzilver";
		["TREASURE_BARREL"]	= "Vaten";
		["TREASURE_BLOODPETAL"]	= "Bloedpetal knoppen";
		["TREASURE_BOX"]	= "Schatkist";
		["TREASURE_CASK"]	= "Vaten";
		["TREASURE_CHEST"]	= "Schatkist";
		["TREASURE_CLAM"]	= "Grote Schelp";
		["TREASURE_CRATE"]	= "krat";
		["TREASURE_FOOTLOCKER"]	= "Opbergkisten";
		["TREASURE_GLOWCAP"]	= "Gloei Paddestoelen";
		["TREASURE_NIGHTDRAGON"]	= "Nacht Draaks Adem";
		["TREASURE_POWERCRYST"]	= "Kracht kristallen";
		["TREASURE_SHELLFISHTRAP"]	= "Schaaldiervallen";
		["TREASURE_SONGFLOWER"]	= "Zingbloemen";
		["TREASURE_UNGOROSOIL"]	= "Un'Goro grond";
		["TREASURE_WHIPPERROOT"]	= "Whipper grondwortels";
		["TREASURE_WINDBLOSSOM"]	= "Windbloem bessen";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 bijkomende drops";
		["NOTE_COUNT"]	= "%1 keer verzameld";
		["NOTE_DISTANCE"]	= "Afstand: %1 meter";
		["NOTE_IMPORTED"]	= "Geimporteerd";
		["NOTE_LASTVISITED"]	= "Laatst bezocht: %1";
		["NOTE_OVERALLDROPS"]	= "Algemene drophoeveelheid";
		["NOTE_SOURCE"]	= "Bron: %1";
		["NOTE_UNSKILLED"]	= "Verzameld zonder skill";

		-- Section: Time
		["DAYS"]	= "Dag";
		["DAYS_ABBR"]	= "Dag";
		["DAYS_ABBR_P1"]	= "Dagen";
		["DAYS_P1"]	= "Dagen";
		["HOURS"]	= "Uur";
		["HOURS_ABBR"]	= "Hr";
		["HOURS_ABBR_P1"]	= "Hrs";
		["HOURS_P1"]	= "Uren";
		["MINUTES"]	= "Minuut";
		["MINUTES_ABBR"]	= "Min";
		["MINUTES_ABBR_P1"]	= "Mins";
		["MINUTES_P1"]	= "Minuten";
		["SECONDS"]	= "Seconde";
		["SECONDS_ABBR"]	= "Sec";
		["SECONDS_ABBR_P1"]	= "Secs";
		["SECONDS_P1"]	= "Seconden";
		["WEEKS"]	= "Week";
		["WEEKS_ABBR"]	= "Wk";
		["WEEKS_ABBR_P1"]	= "Wks";
		["WEEKS_P1"]	= "Weken";

		-- Section: Trade Skill Names
		["TRADE_HERBALISM"]	= "Kruidenleer";
		["TRADE_MINING"]	= "Mijnwerkerij";

	};

	plPL = {

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Zbieracz, Kolekcjoner";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Przełącz okno opcji";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Piekielny pyłek kwiatowy";
		["ORE_ADAMANTITE"]	= "Adamantium";
		["ORE_BLOODSTONE"]	= "Mniejszy Krwisty Kamień";
		["ORE_COPPER"]	= "Miedź";
		["ORE_DARKIRON"]	= "Mroczne Żelazo";
		["ORE_FELIRON"]	= "Demoniczne Żelazo";
		["ORE_GOLD"]	= "Złoto";
		["ORE_INCENDICITE"]	= "Incedencyt";
		["ORE_INDURIUM"]	= "Indurium";
		["ORE_IRON"]	= "Żelazo";
		["ORE_KHORIUM"]	= "Khorium";
		["ORE_MITHRIL"]	= "Mithril";
		["ORE_NETHERCITE"]	= "Netherocyt";
		["ORE_OBSIDIAN"]	= "Obsydian";
		["ORE_RADAMANTITE"]	= "Bogate Adamantium";
		["ORE_RTHORIUM"]	= "Bogaty Tor";
		["ORE_SILVER"]	= "Srebro";
		["ORE_THORIUM"]	= "Tor";
		["ORE_TIN"]	= "Cyna";
		["ORE_TRUESILVER"]	= "Czyste Srebro";
		["TREASURE_BARREL"]	= "Beczki";
		["TREASURE_BLOODPETAL"]	= "Pęd Krwiopłatka";
		["TREASURE_BOX"]	= "Pudła";
		["TREASURE_CASK"]	= "Baryłka";
		["TREASURE_CHEST"]	= "Skrzynie skarbów";
		["TREASURE_CLAM"]	= "Olbrzymie Małże";
		["TREASURE_CRATE"]	= "Skrzynie";
		["TREASURE_FOOTLOCKER"]	= "Szkatułka";
		["TREASURE_GLOWCAP"]	= "Świecące kapelusze";
		["TREASURE_NIGHTDRAGON"]	= "Oddech Mrocznego Smoka";
		["TREASURE_POWERCRYST"]	= "Kryształy Mocy";
		["TREASURE_SHELLFISHTRAP"]	= "Pułapki na muszloryby";
		["TREASURE_SONGFLOWER"]	= "Kwiaty Pieśni";
		["TREASURE_UNGOROSOIL"]	= "Gleba z Un'Goro";
		["TREASURE_WHIPPERROOT"]	= "Leśny Por";
		["TREASURE_WINDBLOSSOM"]	= "Nasiona Kwiatów Wiatru";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 dodatkowych zbiorów";
		["NOTE_COUNT"]	= "Zebrano %1 razy";
		["NOTE_DISTANCE"]	= "Odległość: %1 metrów";
		["NOTE_IMPORTED"]	= "Zaimportowany zbiór";
		["NOTE_LASTVISITED"]	= "Ostatnio odwiedzony: %1";
		["NOTE_OVERALLDROPS"]	= "Lista zbiorów:";
		["NOTE_SOURCE"]	= "Od: %1";
		["NOTE_UNSKILLED"]	= "Zbyt mało doświadczony";

		-- Section: Time
		["DAYS"]	= "Dzień";
		["DAYS_ABBR"]	= "Dzień";
		["DAYS_ABBR_P1"]	= "Dni";
		["DAYS_P1"]	= "Dni";
		["HOURS"]	= "Godzina";
		["HOURS_ABBR"]	= "Godz.";
		["HOURS_ABBR_P1"]	= "Godziny";
		["HOURS_P1"]	= "Godzin(y)";
		["MINUTES"]	= "Minuta";
		["MINUTES_ABBR"]	= "Min.";
		["MINUTES_ABBR_P1"]	= "Min.";
		["MINUTES_P1"]	= "Minuty";
		["SECONDS"]	= "Sekunda";
		["SECONDS_ABBR"]	= "Sek.";
		["SECONDS_ABBR_P1"]	= "Sek.";
		["SECONDS_P1"]	= "Sekund(y)";
		["WEEKS"]	= "Tydzień";
		["WEEKS_ABBR"]	= "Tydz";
		["WEEKS_ABBR_P1"]	= "Tyg";
		["WEEKS_P1"]	= "Tygodni";

		-- Section: Trade Skill Names
		["TRADE_HERBALISM"]	= "Zielarstwo";
		["TRADE_MINING"]	= "Górnictwo";

	};

	ptBR = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "Coleta enviada de %1 para %2";
		["COMM_NODE_SEND_TWO"]	= "Coleta enviada de %1 para %2 e %3";
		["COMM_RECEIVE_NODE"]	= "Coleta Recebida de %1 em %2 de %3 (%4)";
		["NODE_ADD"]	= "Coleta Adicionada de %1";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Mostrar Mensagem Carregada";
		["CONFIG_ALL_FILTER_NOTE"]	= "A '%1\" opção faz com que os filtros atuais sejam ignorados e força todos os nodos nessa categoria serem mostrados.";
		["CONFIG_ARCH_MAX_NOTES"]	= "Exibição: %d próximo";
		["CONFIG_ENABLE_HERB"]	= "Mostrar nodos de Herbalismo";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "Somente Herbalistas";
		["CONFIG_ENABLE_MINE"]	= "Mostrar nodos de mineração";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "Somente Mineradores";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "Somente se rastreando";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "Opções do Botão do Minimapa";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "Opções de Rastreamento do Minimapa";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "Opções do Mapa Mundi";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "Opções de Rastreamento do Mapa Mundi";
		["CONFIG_HERB_FILTER_LABEL"]	= "Nodos de ervas para rastrear";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "Você tem certeza que quer limpar todos os compartilhamentos deste jogador de seu banco de dados? Esta operação NÃO PODE ser desfeita e irá remover %d nodo(s) de seu banco de dados do Gatherer.";
		["CONFIG_IGNORE_PURGE_DONE"]	= "%d nodo(s) foram permanentemente removidos do seu banco de dados do Gatherer.";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "Você deseja remover todos os nodos que foram compartilhados por este jogador?";
		["CONFIG_MINE_FILTER_LABEL"]	= "Nodos minerais para rastrear";
		["CONFIG_MINIICON_ANGLE"]	= "Ângulo do Botão: %dº";
		["CONFIG_MINIICON_DISTANCE"]	= "Distância: %d";
		["CONFIG_MINIICON_ENABLE"]	= "Visualização do Botão do Minimapa";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "Minimapa Adicional";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "Exibir nodos anônimos";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "Opacidade Anon: %d%%";
		["CONFIG_MINIMAP_ANON_TINT"]	= "Tonalidade dos nodos anônimos vermelha";
		["CONFIG_MINIMAP_DISTANCE"]	= "Distância: %d metros";
		["CONFIG_MINIMAP_ENABLE"]	= "Exibir nodos no Minimapa";
		["CONFIG_MINIMAP_FADE_DIST"]	= "Desaparecer em: %d metros";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "Desaparecimento gradual das mini-notas";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "Distância de desaparecimento: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "Tamanho do Ícone: %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "Inspecionar em: %d metros";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "Marcar nodos conforme inspecionados";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "Desaparecimento dos Inspecionados: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "Reinspecionar: %d segs";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "Tonalidade verde enquanto inspecionando";
		["CONFIG_MINIMAP_LABEL"]	= "Opções do Minimapa";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "Exibir: %d próximo";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "Opacidade padrão: %d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "Somente para habilidade de rastreamento ativa";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "Converter para o ícone de rastreamento quando perto";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "Rastrear em: %d metros";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "Habilitar o recurso de rastreamento de habilidade";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "Opacidade do ícone: %d%%";
		["CONFIG_OPEN_FILTER_LABEL"]	= "Nodos de tesouros para rastrear";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "Mudando perfil: %1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "Criar cópia";
		["CONFIG_PROFILE_CREATE_NEW"]	= "Criar novo";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "Ativar o perfil atual";
		["CONFIG_PROFILE_NEW"]	= "Criar ou substituir o perfil";
		["CONFIG_PROFILE_NEW_LABEL"]	= "Nome do novo perfil:";
		["CONFIG_SECTION_ABOUT"]	= "Sobre";
		["CONFIG_SECTION_GENERAL"]	= "Geral";
		["CONFIG_SECTION_HEADER_CORE"]	= "Opções do Núcleo";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "Plugins";
		["CONFIG_SECTION_MINIMAP"]	= "Minimapa";
		["CONFIG_SECTION_OPEN"]	= "Tesouro";
		["CONFIG_SECTION_PROFILES"]	= "Perfis";
		["CONFIG_SECTION_SHARING"]	= "Compartilhamento";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "Sobre o Gatherer";
		["CONFIG_SECTION_TITLE_ARCH"]	= "Opções de Arqueologia";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "Opções principais do Gatherer";
		["CONFIG_SECTION_TITLE_HERB"]	= "Opções do Filtro de Herbalismo";
		["CONFIG_SECTION_TITLE_MINE"]	= "Opções do Filtro de Mineração";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "Opções do Minimapa do Gatherer";
		["CONFIG_SECTION_TITLE_OPEN"]	= "Opções do Filtro de Tesouro";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "Configurar e editar perfis";
		["CONFIG_SECTION_TITLE_SHARING"]	= "Opções de Sincronização";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "Compartilhando Lista Negra";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "Adicionar grupo de coletas recebido para o meu banco de dados";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "Ativar sincronização de grupo";
		["CONFIG_SHARING_GROUP_LABEL"]	= "Compartilhamento de Raide/Grupo";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "Publica uma mensagem ao receber um grupo de coleta";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "Publica uma mensagem ao enviar um grupo de coleta";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "Adicionar coletas de guilda recebidas para o meu banco de dados";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "Ativar sincronização de guilda";
		["CONFIG_SHARING_GUILD_LABEL"]	= "Compartilhamento de guilda";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "Publica uma mensagem ao receber uma coleta de guilda";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "Publica uma mensagem ao enviar uma coleta de guilda";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "Publica uma mensagem ao adicionar coleta própria ao BD";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "Alerta Pessoal";
		["CONFIG_TOOLTIP_COUNTS"]	= "Exibir contagens de colheita";
		["CONFIG_TOOLTIP_DISTANCE"]	= "Exibir distância dos nodos";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "Exibir chances de queda";
		["CONFIG_TOOLTIP_ENABLE"]	= "Exibir dicas de ferramentas";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "Exibir a hora vista pela última vez";
		["CONFIG_TOOLTIP_SOURCE"]	= "Exibir a origem da nota";
		["CONFIG_WORLDMAP_ENABLE"]	= "Exibir notas no Mapa Mundi";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "Tamanho do Ícone: %d";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "Exibir: %d nodos";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "Opacidade: %d%%";
		["ENABLE_OPEN"]	= "Mostrar nodos de tesouro";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "Sendo o vil super-vilão que ele é, o retorno do Asa da Morte queimou todas as ervas, derreteu todos os depósitos de minério e obliterou todos os baús. Agora todos têm que voltar a crescer, ser recristalizados ou serem re-escondidos por piratas e provavelmente eles estão todos em novos locais. Caça ao tesouro!!! (Dados do Velho Mundo foram apagados devido a mudanças generalizadas ma geografia.)";
		["STORAGE_DB_VERSION_INVALID"]	= "CUIDADO!!!\no Gatherer detectou que seu banco de dado é inválido. Por favor pressione aceitar para limpar seu banco de dados, ou selecione ignorar se você quer tentar reparar seu banco de dados manualmente.";
		["STORAGE_DB_VERSION_NEWER"]	= "Seu banco de dados do Gatherer é muito novo. Seu banco de dados será deixado de lado até que você atualize o Gatherer.";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "Dist";
		["REPORT_COLUMN_HEADER_REGION"]	= "Região";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "Origem";
		["REPORT_COLUMN_HEADER_TYPE"]	= "Tipo";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "Você quer deletar %d nodos do Gatherer?";
		["REPORT_DELETE_MARKED"]	= "Deletar Marcados";
		["REPORT_MARKED_NODES_COUNT"]	= "Nodos Marcados: %1";
		["REPORT_MARKING_NOTE"]	= "Nota: Quando você marca nodos, eles permanecerão marcados até que você desmarque-os clicando na linha do item no relatório, usando os botões Desmarcar acima ou recarregar o jogo.";
		["REPORT_MARK_THESE"]	= "Marcar estes";
		["REPORT_SEARCH_BY_REGION"]	= "Por Região";
		["REPORT_SEARCH_BY_SOURCE"]	= "Por Origem";
		["REPORT_SEARCH_BY_TYPE"]	= "Por Tipo";
		["REPORT_SEND_MARKED"]	= "Enviar marcados";
		["REPORT_TITLE"]	= "Relatório de Coletáveis";
		["REPORT_UNMARK_ALL"]	= "Desmarcar todos";
		["REPORT_UNMARK_THESE"]	= "Desmarcar estes";

		-- Section: Generic Messages
		["DESCRIPTION"]	= "Gatherer é um addon que permite que você lembre-se dos locais de coleta e visualize-os em seu mapa principal, seu minimapa, ou em uma exibição no seu HUD. Ele também permite que você compartilhe suas descobertas com a sua guilda, raid ou seus amigos.";
		["DESCRIPTION_LICENSE"]	= "Gatherer é um software de código aberto e está licenciado sob a GNU General Public License v2. Por favor, veja GPL.TXT, incluído neste AddOn, para a licença completa.";
		["LOADED_NOTIFICATION"]	= "Gatherer v%1 - Carregado!";
		["MANIFEST_INVALID_VERSIONS_WARNING"]	= "{{Aviso:}} Sua instalação do Gatherer parece ter versões de arquivos incompatíveis.\n\nPor favor certifique-se de apagar o velho:\n  %1\nDiretório, reinstale uma cópia nova de :\n  %2\ne reinicie o WoW completamente antes de reportar qualquer bug.\n\nObrigado, \n O Dev Team Gatherer";
		["VERSION_MESSAGE"]	= "Este é o Gatherer v%1";
		["ZONETOKENS_UNIDENTIFIED_ZONES_WARNING"]	= "Gatherer foi incapaz de identificar as seguintes zonas: {{%1}}\nSe estas são novas zonas, então este não é um problema, e você pode continuar normalmente. \nSe estas não são novas zonas, então mantenha a calma que {{seus dados NÃO ESTÃO PERDIDOS!}} Seus dados para estas zonas ainda estão intactos, mas você vai precisar atualizar o Gatherer a fim de acessá-los. Até lá, você pode continuar normalmente e quaisquer novos dados que você coletar serão mesclados com os dados antigos, quando você atualizar. \n\n{{Por favor, atualize o Gatherer quando for conveniente.}}";

		-- Section: Generic Strings
		["ACCEPT"]	= "Aceitar";
		["ALL"]	= "Todos";
		["CANCEL"]	= "Cancelar";
		["DELETE"]	= "Deletar";
		["DONE"]	= "Feito";
		["ENABLE"]	= "Ativar";
		["IGNORE"]	= "Ignorar";
		["IGNORE_PLAYER"]	= "Ignorar Jogador";
		["NO"]	= "Não";
		["OKAY"]	= "Certo";
		["SEARCH"]	= "Procurar";
		["STOP_IGNORE"]	= "Remover Jogador";
		["STRATA_BACKGROUND"]	= "Fundo";
		["STRATA_HIGH"]	= "Alto";
		["STRATA_LOW"]	= "Baixo";
		["STRATA_MEDIUM"]	= "Médio";
		["YES"]	= "Sim";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "{{Clique}} para alternar a exibição dos nodos.";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{Clique-Direito}} para visualizar o relatório de coletagem.";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "{{Shift+Clique}} para alternar a visualização do HUD.";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "{{Shift+Clique-Direito}} para editar a configuração.";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "HUD";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "Opções de Exibição do HUD";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "Modo de Rastreamento Térmico do HUD";
		["HUD_CONFIG_HIDING_LABEL"]	= "Opções de Ocultação do HUD";
		["HUD_CONFIG_plugin.gatherer_hud.alpha"]	= "Alfa Global do HUD: %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "Ângulo de Visualização: %dº";
		["HUD_CONFIG_plugin.gatherer_hud.base.color"]	= "Cor Subjacente";
		["HUD_CONFIG_plugin.gatherer_hud.base.enable"]	= "Escurecer o HUD para melhorar a visibilidade";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "Cor Central";
		["HUD_CONFIG_plugin.gatherer_hud.center.enable"]	= "Ativar Círculo de Campo de Visão do Jogador";
		["HUD_CONFIG_plugin.gatherer_hud.fade"]	= "Notas desaparecem em: %d%% do raio";
		["HUD_CONFIG_plugin.gatherer_hud.heat.color"]	= "Cor Térmica";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "Recarga do Rastreamento: %d segundos";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "Mostrar rastreamento de viagens (térmico)";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "Nunca recarregar";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "Largura do caminho de Rastreamento: %d metros";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "Ocultar enquanto em combate";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "Ocultar durante o voo";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "Ocultar enquanto no interior";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "Ocultar enquanto estiver montado";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "Ocultar enquanto descansa";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "Ocultar enquanto furtivo";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "Ocultar enquanto nada";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "Ocultar ao alvejar";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "Ocultar enquanto não estiver montado";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "Tamanho da Nota: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"]	= "Taxa de quadros mínima para desenhar cada quadro: %dqps";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "Deslocamento Horizontal: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "Deslocamento Vertical: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "Cor dos membros do Grupo";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "Mostrar outros membros do grupo";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "Tamanho do ícone do grupo: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "Nível de perspectiva: %0.1f";
		["HUD_CONFIG_plugin.gatherer_hud.radius"]	= "Raio Geral do HUD: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "Alcance da Nota: %d metros";
		["HUD_CONFIG_STRATA_LABEL"]	= "Camadas do HUD (Nível de Desenho)";
		["HUD_CONFIG_USAGE_NOTE"]	= "O uso do HUD irá consumir quadros da sua Taxa de Quadros, e irá consumir ainda mais quadros se você ativar o modo de rastreamento \"Térmico\" que mantém registro do seu tráfego passado pelo caminho térmico.";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "Opções de Visibilidade do HUD";
		["HUD_DESCRIPTION"]	= "O HUD é um componente de navegação que lhe permite controlar a localização de coletáveis em sua tela em uma sobreposição de estilo sobre-a-cabeça.";
		["HUD_TITLE"]	= "Plugin de Visualização Sobre a Cabeça do Gatherer";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "Seus dados CT_MapMod foram importados.";
		["IMPORT_CTMOD_NODATA"]	= "Nenhum dado CT_MapMod foi localizado para importação.";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Alternar Janela de Opções";

		-- Section: Labels
		["GENERAL_LABEL"]	= "Geral";
		["LABEL_CONFIG"]	= "Configuração";
		["LABEL_DENSITY_REPORT"]	= "Pesquisa de Nodos";
		["LABEL_NOTE"]	= "Nota";
		["LABEL_REPORT"]	= "Relatório de Coletáveis";
		["MAP_NOTES_HIDE"]	= "Ocultar Itens\nOcultar Notas";
		["MAP_NOTES_SHOW"]	= "Mostrar Itens\nMostrar Notas";
		["NOTIFICATIONS_TITLE"]	= "Avisos";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "Upload Abortado.";
		["MASS_SHARING_ABORTED"]	= "Abortado em %1";
		["MASS_SHARING_ACCEPTED"]	= "Iniciando...";
		["MASS_SHARING_ASKING"]	= "Solicitando...";
		["MASS_SHARING_BUSY"]	= "Usuário Ocupado.";
		["MASS_SHARING_CLOSED"]	= "Está fechado.";
		["MASS_SHARING_COMPLETE"]	= "Sucesso!";
		["MASS_SHARING_DONE"]	= "Concluído %1";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%1$s quer enviar para você %2$d nodos do Gatherer. Aceitar?";
		["MASS_SHARING_GATHERER_REPORT_TRANSMIT"]	= "Você deseja enviar %1$s nodos para %2$s? (Lembre, eles precisam ter a janela de Relatório de Coletáveis aberta.";
		["MASS_SHARING_RECEIVED_COUNT"]	= "Recebido %1";
		["MASS_SHARING_REJECT"]	= "Rejeitado!";
		["MASS_SHARING_SENDING"]	= "Enviando...";
		["MASS_SHARING_SENT"]	= "Enviado %1";
		["MASS_SHARING_TIMEOUT"]	= "Expirou.";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Pólen de Poeira Etérea";
		["ORE_ADAMANTITE"]	= "Adamantita";
		["ORE_BLOODSTONE"]	= "Pedra-sangrenta Inferior";
		["ORE_COPPER"]	= "Cobre";
		["ORE_DARKIRON"]	= "Ferro Negro";
		["ORE_FELIRON"]	= "Ferrovil";
		["ORE_GOLD"]	= "Ouro";
		["ORE_INCENDICITE"]	= "Incendicita";
		["ORE_INDURIUM"]	= "Indúrio";
		["ORE_IRON"]	= "Ferro";
		["ORE_KHORIUM"]	= "Kório";
		["ORE_MITHRIL"]	= "Mithril";
		["ORE_NETHERCITE"]	= "Etercita";
		["ORE_OBSIDIAN"]	= "Obsídio";
		["ORE_RADAMANTITE"]	= "Adamantita Abundante";
		["ORE_RTHORIUM"]	= "Tório Abundante";
		["ORE_SILVER"]	= "Prata";
		["ORE_THORIUM"]	= "Tório";
		["ORE_TIN"]	= "Estanho";
		["ORE_TRUESILVER"]	= "Veraprata";
		["TREASURE_BARREL"]	= "Barris";
		["TREASURE_BLOODPETAL"]	= "Brotos de Pétala Sangrenta";
		["TREASURE_BOX"]	= "Caixas";
		["TREASURE_CASK"]	= "Barril";
		["TREASURE_CHEST"]	= "Baú de Tesouro";
		["TREASURE_CLAM"]	= "Mariscos Gigantes";
		["TREASURE_CRATE"]	= "Caixote";
		["TREASURE_FOOTLOCKER"]	= "Baús";
		["TREASURE_GLOWCAP"]	= "Chapéus opalinos";
		["TREASURE_NIGHTDRAGON"]	= "Sopro de Dragão Noturno";
		["TREASURE_POWERCRYST"]	= "Cristais de Poder";
		["TREASURE_SHELLFISHTRAP"]	= "Armadilha de Lagostins";
		["TREASURE_SONGFLOWER"]	= "Songflowers";
		["TREASURE_UNGOROSOIL"]	= "Solo de Un'Goro";
		["TREASURE_WHIPPERROOT"]	= "Tubérculo de Raiz-açoite";
		["TREASURE_WINDBLOSSOM"]	= "Amoras do Botão Selvagem";

		-- Section: Node Database Plugins
		["DATABASE_IMPORT_BUTTON_LABEL"]	= "Importar";
		["DATABASE_IMPORT_HEADER"]	= "Importar Base de Dados de Nodos";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "Localização";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "# Nodos";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "Porcentagem";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "Tipo";
		["DENSITY_SEARCH_TITLE"]	= "Pesquisar Densidade do Nodo";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 queda(s) adicional(is)...";
		["NOTE_COUNT"]	= "Coletado %1 vezes";
		["NOTE_DISTANCE"]	= "Distância: %1 metros";
		["NOTE_IMPORTED"]	= "Coleta importada";
		["NOTE_LASTVISITED"]	= "Última visita: %1";
		["NOTE_OVERALLDROPS"]	= "Taxas gerais de queda:";
		["NOTE_SOURCE"]	= "Fonte: %1";
		["NOTE_UNSKILLED"]	= "Coleta não qualificada";

		-- Section: Time
		["DAYS"]	= "Dia";
		["DAYS_ABBR"]	= "Dia";
		["DAYS_ABBR_P1"]	= "Dias";
		["DAYS_P1"]	= "Dias";
		["HOURS"]	= "Hora";
		["HOURS_ABBR"]	= "H";
		["HOURS_ABBR_P1"]	= "Hs";
		["HOURS_P1"]	= "Horas";
		["MINUTES"]	= "Minutos";
		["MINUTES_ABBR"]	= "Min";
		["MINUTES_ABBR_P1"]	= "Mins";
		["MINUTES_P1"]	= "Minutos";
		["SECONDS"]	= "Segundo";
		["SECONDS_ABBR"]	= "Seg";
		["SECONDS_ABBR_P1"]	= "Segs";
		["SECONDS_P1"]	= "Segundos";
		["WEEKS"]	= "Semana";
		["WEEKS_ABBR"]	= "Sem";
		["WEEKS_ABBR_P1"]	= "Sems";
		["WEEKS_P1"]	= "Semanas";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "Arqueologia";
		["TRADE_HERBALISM"]	= "Herborismo";
		["TRADE_MINING"]	= "Mineração";

	};

	ptPT = {

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Alternar opções de diálogo";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Pólen Netherdust";
		["ORE_ADAMANTITE"]	= "Adamantita";
		["ORE_BLOODSTONE"]	= "Pequena Pedra de Sangue";
		["ORE_COPPER"]	= "Cobre";
		["ORE_DARKIRON"]	= "Ferro escuro";
		["ORE_FELIRON"]	= "Ferro Impuro";
		["ORE_GOLD"]	= "Ouro";
		["ORE_INCENDICITE"]	= "Incendicita";
		["ORE_INDURIUM"]	= "Indurio";
		["ORE_IRON"]	= "Ferro";
		["ORE_KHORIUM"]	= "Khorium";
		["ORE_MITHRIL"]	= "Mitril";
		["ORE_NETHERCITE"]	= "Nethercita";
		["ORE_OBSIDIAN"]	= "Obsidio";
		["ORE_RADAMANTITE"]	= "Adamantita enriquecida";
		["ORE_RTHORIUM"]	= "Tório enriquecido";
		["ORE_SILVER"]	= "Prata";
		["ORE_THORIUM"]	= "Tório";
		["ORE_TIN"]	= "Estanho";
		["ORE_TRUESILVER"]	= "Prata Pura";
		["TREASURE_BARREL"]	= "Barris";
		["TREASURE_BLOODPETAL"]	= "Brotos de Bloodpetal";
		["TREASURE_BOX"]	= "Caixas";
		["TREASURE_CASK"]	= "Barrilete";
		["TREASURE_CHEST"]	= "Baus de Tesouro";
		["TREASURE_CLAM"]	= "Moluscos gigantes";
		["TREASURE_CRATE"]	= "Container";
		["TREASURE_FOOTLOCKER"]	= "Footlockers";
		["TREASURE_GLOWCAP"]	= "Glowcaps";
		["TREASURE_NIGHTDRAGON"]	= "Night Dragon's Breath";
		["TREASURE_POWERCRYST"]	= "Cristais poderosos";
		["TREASURE_SHELLFISHTRAP"]	= "Armadilhas para Shellfish";
		["TREASURE_SONGFLOWER"]	= "Songflowers";
		["TREASURE_UNGOROSOIL"]	= "Solo de Un'Goro";
		["TREASURE_WHIPPERROOT"]	= "Tubérculo Whipper";
		["TREASURE_WINDBLOSSOM"]	= "Uvas Windblossom";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 drops adicionais...";
		["NOTE_COUNT"]	= "Coletado %1 vezes";
		["NOTE_DISTANCE"]	= "Distancia: %1 jardas";
		["NOTE_IMPORTED"]	= "Coleta Importada";
		["NOTE_LASTVISITED"]	= "Ultima visita em: %1";
		["NOTE_OVERALLDROPS"]	= "Frequencia de drops:";
		["NOTE_SOURCE"]	= "Fonte: %1";
		["NOTE_UNSKILLED"]	= "Coletor Sem Habilidade";

		-- Section: Time
		["DAYS"]	= "Dia";
		["DAYS_ABBR"]	= "Dia";
		["DAYS_ABBR_P1"]	= "Dias";
		["DAYS_P1"]	= "Dias";
		["HOURS"]	= "Hora";
		["HOURS_ABBR"]	= "H";
		["HOURS_ABBR_P1"]	= "H";
		["HOURS_P1"]	= "Horas";
		["MINUTES"]	= "Minuto";
		["MINUTES_ABBR"]	= "m";
		["MINUTES_ABBR_P1"]	= "m";
		["MINUTES_P1"]	= "Minutos";
		["SECONDS"]	= "Segundos";
		["SECONDS_ABBR"]	= "Seg";
		["SECONDS_ABBR_P1"]	= "Segs";
		["SECONDS_P1"]	= "Segundos";
		["WEEKS"]	= "Semana";
		["WEEKS_ABBR"]	= "Sem.";
		["WEEKS_ABBR_P1"]	= "Sem.";
		["WEEKS_P1"]	= "Semanas";

		-- Section: Trade Skill Names
		["TRADE_HERBALISM"]	= "Herbalismo";
		["TRADE_MINING"]	= "Mineração";

	};

	ruRU = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "Отправка точки %1 в %2";
		["COMM_NODE_SEND_TWO"]	= "Отправка точки %1 в %2 и %3";
		["COMM_RECEIVE_NODE"]	= "Приём точки %1 из %2 от %3 (%4)";
		["NODE_ADD"]	= "Добавлена точка %1";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Показать сообщение при загрузке";
		["CONFIG_ALL_FILTER_NOTE"]	= "Текущие настройки фильтров '%1' будут проигнорированы и будут показаны все точки в этой категории.";
		["CONFIG_ARCH_MAX_NOTES"]	= "Показывать: %d ближайших";
		["CONFIG_ENABLE_HERB"]	= "Показывать точки травников";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "Только травникам";
		["CONFIG_ENABLE_MINE"]	= "Показывать точки горняков";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "Только горнякам";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "Только если ведется поиск";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "Настройки кнопки миникарты";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "Свойства отслеживания на миникарте";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "Настройки глобальной карты";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "Настройки отслеживания на глобальной карте";
		["CONFIG_HERB_FILTER_LABEL"]	= "Точки сбора травников к отслеживанию";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "Вы уверены, что желаете удалить все точки этого игрока из базы данных? Это операцию НЕВОЗМОЖНО отменить и она удалит %d из базы данных Gatherer.";
		["CONFIG_IGNORE_PURGE_DONE"]	= "%d точка(ек) безвозвратно удалены из Вашей базы данных Gatherer.";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "Вы хотите удалить все точки сбора расшаренные этим игроком?";
		["CONFIG_MINE_FILTER_LABEL"]	= "Отслеживать точки сбора горняков";
		["CONFIG_MINIICON_ANGLE"]	= "Угол кнопки: %d°";
		["CONFIG_MINIICON_DISTANCE"]	= "Расстояние: %d";
		["CONFIG_MINIICON_ENABLE"]	= "Показывать кнопку на миникарте";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "Миникарта дополнительно";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "Показывать неизвестные точки сбора";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "Прозрачность неизвестных точек: %d%%";
		["CONFIG_MINIMAP_ANON_TINT"]	= "Окрасить неизвестные точки красным";
		["CONFIG_MINIMAP_DISTANCE"]	= "Расстояние: %d ярдов";
		["CONFIG_MINIMAP_ENABLE"]	= "Примечания на миникарте";
		["CONFIG_MINIMAP_FADE_DIST"]	= "Угасание в: %d ярдах";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "Угасание примечаний";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "Расстояние угасания: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "Размер иконки: %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "Обследовать в: %d ярдах";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "Отмечать точки как обследованные";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "Угасание обследованных: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "Переобследование: %d сек.";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "Окрасить зеленым при обследовании";
		["CONFIG_MINIMAP_LABEL"]	= "Настройки миникарты";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "Показывать: %d ближайших";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "Прозрачность по умолчанию: %d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "Только для активного навыка";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "Преобразовать в иконку слежения при приближении";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "Следить в: %d ярдах";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "Включить отслеживание";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "Прозрачность иконки: %d%%";
		["CONFIG_OPEN_FILTER_LABEL"]	= "Отслеживать сокровища";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "Смена профиля: %1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "Копировать";
		["CONFIG_PROFILE_CREATE_NEW"]	= "Новый";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "Активировать текущий профиль";
		["CONFIG_PROFILE_NEW"]	= "Создать или заменить профиль";
		["CONFIG_PROFILE_NEW_LABEL"]	= "Имя нового профиля:";
		["CONFIG_SECTION_ABOUT"]	= "О дополнении";
		["CONFIG_SECTION_GENERAL"]	= "Общие настройки";
		["CONFIG_SECTION_HEADER_CORE"]	= "Основные Настройки";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "Дополнения";
		["CONFIG_SECTION_MINIMAP"]	= "Миникарта";
		["CONFIG_SECTION_OPEN"]	= "Сокровища";
		["CONFIG_SECTION_PROFILES"]	= "Профили";
		["CONFIG_SECTION_SHARING"]	= "Расшаривание";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "О дополнении Gatherer";
		["CONFIG_SECTION_TITLE_ARCH"]	= "Настройки Археологии";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "Основные настройки Gatherer";
		["CONFIG_SECTION_TITLE_HERB"]	= "Настройки фильтра Травничество";
		["CONFIG_SECTION_TITLE_MINE"]	= "Настройки фильтра Горное дело";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "Настройки миникарты Gatherer";
		["CONFIG_SECTION_TITLE_OPEN"]	= "Настройки фильтра Сокровища";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "Установка, настройка и редактирование профилей";
		["CONFIG_SECTION_TITLE_SHARING"]	= "Настройки синхронизации";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "Черный список синхронизации";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "Добавить принятые точки группы в свою базу данных";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "Включить синхронизацию с группой";
		["CONFIG_SHARING_GROUP_LABEL"]	= "Синхронизация с Группой/Рейдом";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "Показать сообщение когда принимается точка сбора от группы";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "Показать сообщение когда отправляется точка группе";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "Добавить принятые от гильдии точки в базу данных";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "Включить синхронизацию с гильдией";
		["CONFIG_SHARING_GUILD_LABEL"]	= "Синхронизация с гильдией";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "Показать сообщение когда принимается точка от гильдии";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "Показать сообщение когда отправляется точка в гильдию";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "Показать сообщение когда собственная точка сбора добавляется к базе данных";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "Персональное предупреждение";
		["CONFIG_TOOLTIP_COUNTS"]	= "Показать счетчики урожая";
		["CONFIG_TOOLTIP_DISTANCE"]	= "Показывать расстояние до точки";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "Показывать шансы выпадения";
		["CONFIG_TOOLTIP_ENABLE"]	= "Показывать советы";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "Показывать когда обследовалась";
		["CONFIG_TOOLTIP_SOURCE"]	= "Показывать источник заметки";
		["CONFIG_WORLDMAP_ENABLE"]	= "Показывать заметки на глобальной карте";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "Размер иконки: %d";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "Показывать: %d заметок";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "Прозрачность: %d%%";
		["ENABLE_OPEN"]	= "Показывать точки сокровищ";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "Произошел Катаклизм, вернулся Смертокрыл, он сжёг все растения, расплавил все металлы, уничтожил все сундуки. Сейчас всё это вновь растёт, выкристаллизовывается и препрятывается от пиратов, и меняет расположение. Охота началась!!!\n(Старые данные мира очищены всвязи с изменением географии мира.)";
		["STORAGE_DB_VERSION_INVALID"]	= "ВНИМАНИЕ!!!\nGatherer обнаружил, что у Вас неправильная версия базы данных. Пожалуйста нажмите принять, чтобы очистить Вашу базу данных, или выберите игнорировать, чтобы попробывать восстановить её вручную.";
		["STORAGE_DB_VERSION_NEWER"]	= "Ваша база данных слишком новая для Gatherer, и не будет использоваться до тех пор, пока Вы не обновите Gatherer.";

		-- Section: Game Object Tooltip
		["GAME_OBJECT_REQUIRES_REWRITE"]	= "%1$s %2$d";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "Расст.";
		["REPORT_COLUMN_HEADER_REGION"]	= "Локация";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "Источник";
		["REPORT_COLUMN_HEADER_TYPE"]	= "Тип";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "Вы хотите удалить %d точек сбора Gatherer?";
		["REPORT_DELETE_MARKED"]	= "Удалить отмеченное";
		["REPORT_MARKED_NODES_COUNT"]	= "Отмеченные точки: %1";
		["REPORT_MARKING_NOTE"]	= "Примечание: Кода Вы отмечаете точки сбора, они остаются отмеченными до тех пор, пока Вы не щелкните по ним в списке, используя кнопки маркировки выше или не перезагрузите игру.";
		["REPORT_MARK_THESE"]	= "Отметить указанные";
		["REPORT_SEARCH_BY_REGION"]	= "По локациям";
		["REPORT_SEARCH_BY_SOURCE"]	= "По источнику";
		["REPORT_SEARCH_BY_TYPE"]	= "По типу";
		["REPORT_SEND_MARKED"]	= "Отослать отмеченные";
		["REPORT_TITLE"]	= "Список точек сбора";
		["REPORT_UNMARK_ALL"]	= "Снять выд. с всех";
		["REPORT_UNMARK_THESE"]	= "Снять выд. с указанных";

		-- Section: Generic Messages
		["DESCRIPTION"]	= "Gatherer это дополнение, которое позволяет Вам запоминать точки сбора ресурсов и показывать их на Вашей карте или радаре, или внутри интерфейса игры. Также оно позволяет расшаривать свои находки с Вашей гильдией или рейдом.";
		["DESCRIPTION_LICENSE"]	= "Gatherer это программное обеспечение с открытым исходным кодом, распространяемое в соответствии с GNU General Public License v2. Чтобы ознакомится с полным текстом лицензии прочитайте файл gpl.txt, прилагаемый к дополнению.";
		["LOADED_NOTIFICATION"]	= "Gatherer v%1 -- Загружен!";
		["MANIFEST_INVALID_VERSIONS_WARNING"]	= "{{Внимание:}} В Вашем экземпляре установки Gatherer обнаружены несоответствия версий файлов.\n\nУбедитесь в том, что удалили старую версию из:\n  %1\nкаталога, преустановите свежую копию из:\n  %2\nи полностью перезапустите WoW, прежде чем писать о каких либо неполадках.\n\nС благодарностью,\n  Команда разработчиков Gatherer";
		["VERSION_MESSAGE"]	= "Это Gatherer v%1";
		["ZONETOKENS_UNIDENTIFIED_ZONES_WARNING"]	= "Gatherer не может идентифицировать следующие зоны: {{%1}}\nЕсли это новые зоны, тогда это не является проблемой, и Вы можете продолжать в нормальном режиме.\nЕсли это не новые зоны, тогда сохраняйте спокойствие {{ваши данные НЕ ПОТЕРЯНЫ!}} Ваши данные для этих зон всё ещё целы, но чтобы получить доступ к ним, Вы должны обновить Gatherer. Вы можете продолжать игру как обычно и собирать любые новые данные, как только Вы обновите Gatherer, Ваши старые данные будут объеденены с новыми. \n\n{{Пожалуйста обновите Gatherer, кода Вам будет удобно.}}";

		-- Section: Generic Strings
		["ACCEPT"]	= "Принять";
		["ALL"]	= "Все";
		["CANCEL"]	= "Отмена";
		["DELETE"]	= "Удалить";
		["DONE"]	= "Закончить";
		["ENABLE"]	= "Доступно";
		["IGNORE"]	= "Игнорировать";
		["IGNORE_PLAYER"]	= "Игнорировать игрока";
		["NO"]	= "Нет";
		["OKAY"]	= "Да";
		["SEARCH"]	= "Поиск";
		["STOP_IGNORE"]	= "Удалить Игрока";
		["STRATA_BACKGROUND"]	= "В фоне";
		["STRATA_HIGH"]	= "Высокий";
		["STRATA_LOW"]	= "Низкий";
		["STRATA_MEDIUM"]	= "Средний";
		["YES"]	= "Да";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "{{Щелчок ЛКМ}} для включения отображения точек сбора.";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{Щелчок ПКМ}} для просмотра списка точек сбора.";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "{{Shift - Щелчок ЛКМ}} для включения окна интерфейса.";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "{{Shift - Щелчок ПКМ}} для изменения настроек.";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "Игровой интерфейс";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "Настройки отображения игрового интерфейса";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "Игровой интерфейс опции тепловизора";
		["HUD_CONFIG_HIDING_LABEL"]	= "Игровой интерфейс опции скрытия";
		["HUD_CONFIG_plugin.gatherer_hud.alpha"]	= "Общая прозрачность: %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "Угол обзора: %d°";
		["HUD_CONFIG_plugin.gatherer_hud.base.color"]	= "Цвет подложки";
		["HUD_CONFIG_plugin.gatherer_hud.base.enable"]	= "Затемнить интерфейс для лучшего восприятия";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "Цвет центра";
		["HUD_CONFIG_plugin.gatherer_hud.center.enable"]	= "Отображать поле зрения игрока";
		["HUD_CONFIG_plugin.gatherer_hud.fade"]	= "Примечания пропадают в: %d%% радиусах";
		["HUD_CONFIG_plugin.gatherer_hud.heat.color"]	= "Цвет теплового следа";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "Восстановление отслеживания: %d секунд";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "Показывать тепловой след";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "Больше не перегружать";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "Ширина отслеживаемой зоны: %d ярдов";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "Прятать в бою";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "Прятать в полёте";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "Прятать внутри помещений";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "Прятать на маунте";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "Прятать во время отдыха";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "Прятать когда скрыт";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "Прятать при плавании";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "Прятать при прицеливании";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "Прятать не на маунте";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "Размер примечаний: %d пикселей";
		["HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"]	= "Минимальная частота фреймов: %dfps";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "Горизонтальное смещение : %d пикселей";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "Вертикальное смещение : %d пикселей";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "Цвет членов группы";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "Показывать других членов группы";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "Размер иконки группы: %d пикселей";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "Уровень переспективы: %0.1f";
		["HUD_CONFIG_plugin.gatherer_hud.radius"]	= "Общий радиус интерфейса: %d пикселей";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "Дистанция примечаний: %d ярдов";
		["HUD_CONFIG_STRATA_LABEL"]	= "Приоритет прорисовки";
		["HUD_CONFIG_USAGE_NOTE"]	= "Использование этого интерфейса снижает общую частоту кадров и будет снижать её ещё больше, если Вы включите отслеживание вашего маршрута по тепловизору.";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "HUD Настройки видимости";
		["HUD_DESCRIPTION"]	= "HUD это навигационный компонент, позволяющий отслеживать местонахождение ресурсов на экране в стиле прибора ночного видения";
		["HUD_TITLE"]	= "Плагин отображения Gatherer в стиле прибора ночного видения";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "Ваши данные CT_MapMod импортированы.";
		["IMPORT_CTMOD_NODATA"]	= "Не найдено данных CT_MapMod для импорта.";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Переключение окна опций";

		-- Section: Labels
		["GENERAL_LABEL"]	= "Основные";
		["LABEL_CONFIG"]	= "Настройки";
		["LABEL_DENSITY_REPORT"]	= "Поиск точки";
		["LABEL_NOTE"]	= "Примечание";
		["LABEL_REPORT"]	= "Сводка о ресурсах";
		["MAP_NOTES_HIDE"]	= "Скрыть предметы";
		["MAP_NOTES_SHOW"]	= "Показать предметы";
		["NOTIFICATIONS_TITLE"]	= "Gatherer: Предупреждения";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "Отправка прервана.";
		["MASS_SHARING_ABORTED"]	= "Прервано на %1";
		["MASS_SHARING_ACCEPTED"]	= "Начинаю....";
		["MASS_SHARING_ASKING"]	= "Запрос...";
		["MASS_SHARING_BUSY"]	= "Пользователь занят.";
		["MASS_SHARING_CLOSED"]	= "Закрыто.";
		["MASS_SHARING_COMPLETE"]	= "Успешно!";
		["MASS_SHARING_DONE"]	= "Завершено %1";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%1$ хочет послать Вам %2$d точек сбора. Принять их?";
		["MASS_SHARING_GATHERER_REPORT_TRANSMIT"]	= "Вы хотите послать %1$s точек сбора %2$s?\n(Не забудьте, что у принимающей стороны всё это время должно быть открыто окно списка точек сбора.)";
		["MASS_SHARING_RECEIVED_COUNT"]	= "Принято %1";
		["MASS_SHARING_REJECT"]	= "Прервано!";
		["MASS_SHARING_SENDING"]	= "Отсылаю...";
		["MASS_SHARING_SENT"]	= "Послано %1";
		["MASS_SHARING_TIMEOUT"]	= "Время вышло.";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "Пыльца пустопраха";
		["ORE_ADAMANTITE"]	= "Адамантитовая руда";
		["ORE_BLOODSTONE"]	= "Бедная кровавая руда";
		["ORE_COPPER"]	= "Медная руда";
		["ORE_DARKIRON"]	= "Руда чёрного железа";
		["ORE_FELIRON"]	= "Руда оскверненного железа";
		["ORE_GOLD"]	= "Золотая руда";
		["ORE_INCENDICITE"]	= "Огневитовая руда";
		["ORE_INDURIUM"]	= "Индарилиевая руда";
		["ORE_IRON"]	= "Железная руда";
		["ORE_KHORIUM"]	= "Кориевая руда";
		["ORE_MITHRIL"]	= "Мифриловая руда";
		["ORE_NETHERCITE"]	= "Хаотитовая руда";
		["ORE_OBSIDIAN"]	= "Обсидиановая руда";
		["ORE_RADAMANTITE"]	= "Богатые залежи адамантита";
		["ORE_RTHORIUM"]	= "Богатая ториевая жила";
		["ORE_SILVER"]	= "Серебро";
		["ORE_THORIUM"]	= "Ториевая руда";
		["ORE_TIN"]	= "Олово";
		["ORE_TRUESILVER"]	= "Руда истинного серебра";
		["TREASURE_BARREL"]	= "Бочонок";
		["TREASURE_BLOODPETAL"]	= "Побеги кровоцвета";
		["TREASURE_BOX"]	= "Коробка";
		["TREASURE_CASK"]	= "Бочка";
		["TREASURE_CHEST"]	= "Сундук с сокровищами";
		["TREASURE_CLAM"]	= "Огромная Мидия";
		["TREASURE_CRATE"]	= "Ящик";
		["TREASURE_FOOTLOCKER"]	= "Сундучки";
		["TREASURE_GLOWCAP"]	= "Огнешляпка";
		["TREASURE_NIGHTDRAGON"]	= "Ночное дыхание дракона";
		["TREASURE_POWERCRYST"]	= "кристалл силы";
		["TREASURE_SHELLFISHTRAP"]	= "Ловушка на моллюска";
		["TREASURE_SONGFLOWER"]	= "Песньцветы";
		["TREASURE_UNGOROSOIL"]	= "Земля Ун'Горо";
		["TREASURE_WHIPPERROOT"]	= "Плод кнутокорня";
		["TREASURE_WINDBLOSSOM"]	= "Ягоды ветроцвета";

		-- Section: Node Database Plugins
		["DATABASE_IMPORT_BUTTON_LABEL"]	= "Импорт";
		["DATABASE_IMPORT_HEADER"]	= "Выполните импорт узла базы данных:";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "Расположение";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "№ Точки";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "Проценты";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "Тип";
		["DENSITY_SEARCH_TITLE"]	= "Поиск точки по плотности";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "Ещё %1 сбор(ов)...";
		["NOTE_COUNT"]	= "Собрано %1 раз";
		["NOTE_DISTANCE"]	= "Дистанция: %1 метр(ов)";
		["NOTE_IMPORTED"]	= "Импортировано";
		["NOTE_LASTVISITED"]	= "Последний раз посещён: %1";
		["NOTE_OVERALLDROPS"]	= "Общий шанс сбора:";
		["NOTE_SOURCE"]	= "Источник: %1";
		["NOTE_UNSKILLED"]	= "Сбор без умения";

		-- Section: Time
		["DAYS"]	= "День";
		["DAYS_ABBR"]	= "День";
		["DAYS_ABBR_P1"]	= "Дней";
		["DAYS_P1"]	= "Дней";
		["HOURS"]	= "Час";
		["HOURS_ABBR"]	= "ч";
		["HOURS_ABBR_P1"]	= "ч";
		["HOURS_P1"]	= "Часов";
		["MINUTES"]	= "Минута";
		["MINUTES_ABBR"]	= "мин";
		["MINUTES_ABBR_P1"]	= "мин";
		["MINUTES_P1"]	= "Минут";
		["SECONDS"]	= "Секунда";
		["SECONDS_ABBR"]	= "сек";
		["SECONDS_ABBR_P1"]	= "сек";
		["SECONDS_P1"]	= "Секунд";
		["WEEKS"]	= "Неделя";
		["WEEKS_ABBR"]	= "Нед";
		["WEEKS_ABBR_P1"]	= "Нед";
		["WEEKS_P1"]	= "Недель";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "Археология";
		["TRADE_HERBALISM"]	= "Травничество";
		["TRADE_MINING"]	= "Горное дело";

	};

	trTR = {

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "Yüklenen mesajı göster";
		["CONFIG_ALL_FILTER_NOTE"]	= "%1'lik seçenekler, geçerli filtrelerin yok sayılıp, o kategorideki tüm noktaların gösterilmesine sebep olur.";
		["CONFIG_ARCH_MAX_NOTES"]	= "En yakın %d kadarını göster.";
		["CONFIG_ENABLE_HERB"]	= "Bitki noktalarını göster.";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "Bitkicilere Özel";
		["CONFIG_ENABLE_MINE"]	= "Maden noktalarını göster";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "Madencilere özel";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "Sadece takip ediliyorsa";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "Minimap düğmesi seçenekleri";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "Minimap takip seçenekleri";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "Büyük harita seçenekleri";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "Büyük harita takip seçenekleri";
		["CONFIG_HERB_FILTER_LABEL"]	= "Takip edilecek bitki noktaları";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "Bu kişiden gelen tüm paylaşımları silmek istediğinize emin misiniz? Bu işlem geri ALINAMAZ ve %d noktayı Gatherer veritabanınızdan kaldırır.";
		["CONFIG_IGNORE_PURGE_DONE"]	= "Gatherer veritabanınızdan %d nokta tamamen kaldırıldı.";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "Bu kişiden gelen tüm noktaları kaldırmak istiyor musunuz?";
		["CONFIG_MINE_FILTER_LABEL"]	= "Takip edilecek maden noktaları";
		["CONFIG_MINIICON_DISTANCE"]	= "Menzil: %d";
		["CONFIG_MINIICON_ENABLE"]	= "Minimap Düğmesini Göster";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "Minimap Ek";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "Anonim noktaları göster";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "Anon şeffaflığı: %d%%";
		["CONFIG_MINIMAP_ANON_TINT"]	= "Anonim noktaları kırmızıya boya";
		["CONFIG_MINIMAP_DISTANCE"]	= "Menzil: %d yard";
		["CONFIG_MINIMAP_ENABLE"]	= "Notları Minimap'te göster";
		["CONFIG_MINIMAP_FADE_DIST"]	= "Silikleştir: %d yard";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "mini-notları silikleştir";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "Silikleştirme menzili: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "İkon boyutu: %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "Şu kadar alanı incele: %d yard";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "Noktaları, incelendikçe işaretle.";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "İnceleneni silikleştir: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "Tekrar incele: %d saniye";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "İncelerken yeşile boya";
		["CONFIG_MINIMAP_LABEL"]	= "Minimap seçenekleri";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "Göster: En yakın %d tane";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "Varsayılan şeffaflık:  %d%%";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "Yakınlaştıkça izleme ikonuna çevir.";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "İzleme menzili: %d yard";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "İzleme yeteneğini aktif et.";
		["CONFIG_OPEN_FILTER_LABEL"]	= "İzlenecek hazine noktaları";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "Dünyanın en kötüsü olarak dönüş yapan Deathwing, tüm çiçekleri yakıp, madenleri eritip, hazine kutularını parçaladı. Şimdi hepsi yeniden büyümeli, yeniden kristalize olmalı, ya da korsanlar tarafından tekrar saklanmalılar, muhtemelen yeni yerlerinde. Hazine Avı!!! (Eski dünya bilgileri büyük çapta coğrafya değişimi sebebiyle tamamen silindi.)";
		["STORAGE_DB_VERSION_INVALID"]	= "DİKKAT!!!\nGatherer, veritabanı versiyonunuzun geçersiz olduğunu keşfetti. Lütfen veritabanınızı temizlemek için \"kabul et\"e basın, ya da veritabanınızı manuel olarak tamir etmek isterseniz \"yoksay\"a basın";
		["STORAGE_DB_VERSION_NEWER"]	= "Kaydedilmiş Gatherer veritabanınız oldukça yeni. Şu anki veritabanınız, Gatherer'ı güncelleyene kadar beklemede kalacaktır.";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "Msfe";
		["REPORT_COLUMN_HEADER_REGION"]	= "Bölge";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "Kaynak";
		["REPORT_COLUMN_HEADER_TYPE"]	= "Tip";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "%d Gatherer noktasını silmek istiyor musunuz?";
		["REPORT_DELETE_MARKED"]	= "İşaretlileri sil";
		["REPORT_MARKED_NODES_COUNT"]	= "İşaretli noktalar: %1";
		["REPORT_MARKING_NOTE"]	= "Not: Bir noktayı seçtiğiniz zaman, o nokta siz reload yapmadıkça, o seçimi tekrar tıklayarak kaldırmadıkça ya da yukardaki seçimi sil butonlarını kullanmadıkça işaretli kalır";
		["REPORT_MARK_THESE"]	= "Bunları işaretle";
		["REPORT_SEARCH_BY_REGION"]	= "Bölgeye göre";
		["REPORT_SEARCH_BY_SOURCE"]	= "Kaynağa göre";
		["REPORT_SEARCH_BY_TYPE"]	= "Tipe göre";
		["REPORT_SEND_MARKED"]	= "Seçilileri gönder";
		["REPORT_TITLE"]	= "Toplanabilirlerin Raporu";
		["REPORT_UNMARK_ALL"]	= "Tüm seçimleri kaldır";
		["REPORT_UNMARK_THESE"]	= "Bunların seçimini kaldır";

		-- Section: Generic Strings
		["ACCEPT"]	= "Kabul et";
		["ALL"]	= "Hepsi";
		["CANCEL"]	= "İptal";
		["DELETE"]	= "Sil";
		["DONE"]	= "Tamamlandı";
		["ENABLE"]	= "Aktif et";
		["IGNORE"]	= "Yoksay";
		["IGNORE_PLAYER"]	= "Kullanıcıyı yoksay";
		["NO"]	= "Hayır";
		["OKAY"]	= "Tamam";
		["SEARCH"]	= "Ara";
		["STOP_IGNORE"]	= "Kullanıcıyı kaldır";
		["STRATA_BACKGROUND"]	= "Arkaplan";
		["STRATA_HIGH"]	= "Yüksek";
		["STRATA_LOW"]	= "Düşük";
		["STRATA_MEDIUM"]	= "Orta";
		["YES"]	= "Evet";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "Noktaları göster/gizle {{Click}}";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "Toplanabilirlerin raporu için {{Right-Click}}";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "HUD görünümü aç/kapa {{Shift-Click}}";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "Ayarlar için {{Shift-Right-Click}}";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "HUD";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "HUD Görüntüleme Seçenekleri";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "HUD Isıl yol İzleme Modu";
		["HUD_CONFIG_HIDING_LABEL"]	= "HUD Gizleme Seçenekleri";
		["HUD_CONFIG_plugin.gatherer_hud.alpha"]	= "Genel HUD şeffaflığı: %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "Görüntüleme açısı: %d°";
		["HUD_CONFIG_plugin.gatherer_hud.base.color"]	= "Alt katman rengi";
		["HUD_CONFIG_plugin.gatherer_hud.base.enable"]	= "Görüş kalitesini arttırmak için HUD'ı karart.";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "Merkez renk";
		["HUD_CONFIG_plugin.gatherer_hud.center.enable"]	= "Görüş Alanı halkasını aktif et";
		["HUD_CONFIG_plugin.gatherer_hud.fade"]	= "Notların silikleşmesi: Çapın %d%% kadarı";
		["HUD_CONFIG_plugin.gatherer_hud.heat.color"]	= "Isıl yol rengi";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "İzleme yenilemesi: %d saniye";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "Seyehat izini göster (Isıl yol)";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "Asla yenileme";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "Seyahat izi genişliği: %d yard";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "Savaş esnasında gizle";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "Uçarken gizle";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "İç mekandayken gizle";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "Binek üstündeyken gizle";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "Dinlenirken gizle (rested)";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "Stealth modundayken gizle";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "Yüzerken gizle";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "Hedef seçili iken gizle";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "Binek üstünde değilken gizle";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "Nokta boyutu: %d piksel";
		["HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"]	= "İzleme ekranının minimum yenilenme hızı: %dfps";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "Yatay Hiza: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "Dikey Hiza: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "Parti üyesi rengi";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "Diğer parti üyelerini göster";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "Parti ikon boyutu: %d pixels";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "Perspektif Seviyesi: %0.1f";
		["HUD_CONFIG_plugin.gatherer_hud.radius"]	= "Genel HUD çapı: %d piksel";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "Nokta menzili: %d yards";
		["HUD_CONFIG_STRATA_LABEL"]	= "HUD Katmanı (Görüntülenme önceliği)";
		["HUD_CONFIG_USAGE_NOTE"]	= "HUD kullanımı sizin fps'inizden yer, Geçtiğiniz yolları çizerek izleyen Isıl yol mod'u daha da fazla fps yer.";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "HUD Grünürlük Ayarları";
		["HUD_DESCRIPTION"]	= "HUD, toplanabilir materyallerinizin izini ekranınınzdan görebilmenizi sağlayan bir navigasyon bileşenidir.";
		["HUD_TITLE"]	= "Gatherer Navigasyon Eklentisi";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "CT_MapMod bilgileriniz, içe alındı.";
		["IMPORT_CTMOD_NODATA"]	= "İçe almak için hiç bir CT_MapMod bilgisi bulunmadı.";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "Gatherer";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "Seçenekleri aç/kapat";

		-- Section: Labels
		["GENERAL_LABEL"]	= "Genel";
		["LABEL_CONFIG"]	= "Ayar";
		["LABEL_DENSITY_REPORT"]	= "Nokta Ara";
		["LABEL_NOTE"]	= "Not";
		["LABEL_REPORT"]	= "Toplanabilirler Raporu";
		["NOTIFICATIONS_TITLE"]	= "Gatherer: Uyarılar";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "Gönderme iptal edildi";
		["MASS_SHARING_ABORTED"]	= "%1'de iptal edildi";
		["MASS_SHARING_ACCEPTED"]	= "Başlatılıyor...";
		["MASS_SHARING_ASKING"]	= "Soruluyor...";
		["MASS_SHARING_BUSY"]	= "Kullanıcı meşgul.";
		["MASS_SHARING_CLOSED"]	= "kapalı.";
		["MASS_SHARING_COMPLETE"]	= "Başarılı!";
		["MASS_SHARING_DONE"]	= "%1'de bitti";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%1$s sizden %2$d Gatherer noktası göndermenizi istiyor. Kabul ediyor musunuz?";
		["MASS_SHARING_GATHERER_REPORT_TRANSMIT"]	= "%2$s isimli kullanıcıya %1$s noktayı göndermek istiyor musunuz?";
		["MASS_SHARING_RECEIVED_COUNT"]	= "%1 Alındı";
		["MASS_SHARING_REJECT"]	= "Reddedildi!";
		["MASS_SHARING_SENDING"]	= "Gönderiliyor...";
		["MASS_SHARING_SENT"]	= "%1 Gönderildi";
		["MASS_SHARING_TIMEOUT"]	= "Zaman aşımı";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "since we do not have wow TR support, all of the ores can stay in english, ignore the translations, they will make confusion only.";
		["ORE_ADAMANTITE"]	= "since we do not have wow TR support, all of the ores can stay in english, ignore the translations, they will make confusion only.";
		["ORE_BLOODSTONE"]	= "Arkadaşlar, az blood stone nedir allah aşkına. Az akıl az fikir.\nLütfen bu kısmı ingilizceye çevirmeyin, wow'un kendisi türkçe olmadığı için sadece karışıklık yaratır.";
		["ORE_COPPER"]	= "Bakır";
		["ORE_DARKIRON"]	= "Kara Demir";
		["ORE_FELIRON"]	= "Fel Demir";
		["ORE_GOLD"]	= "Altın";
		["ORE_INCENDICITE"]	= "Incendicite";
		["ORE_INDURIUM"]	= "Indurium";
		["ORE_IRON"]	= "Demir";
		["ORE_KHORIUM"]	= "Khorium";
		["ORE_MITHRIL"]	= "Mithril";
		["ORE_NETHERCITE"]	= "Nethercite";
		["ORE_OBSIDIAN"]	= "Obsidiyen";
		["ORE_RADAMANTITE"]	= "Zengin Adamantite";
		["ORE_RTHORIUM"]	= "Zengin Toryum";
		["ORE_SILVER"]	= "Gümüş";
		["ORE_THORIUM"]	= "Toryum";
		["ORE_TIN"]	= "Kalay";
		["ORE_TRUESILVER"]	= "Gerçekgümüş";
		["TREASURE_BARREL"]	= "Varil";
		["TREASURE_BLOODPETAL"]	= "Bloodpetal Lahanası";
		["TREASURE_BOX"]	= "Kutuları";
		["TREASURE_CASK"]	= "Fıçılar";
		["TREASURE_CHEST"]	= "Hazine Sandıklar";
		["TREASURE_CLAM"]	= "Dev istiridye";
		["TREASURE_CRATE"]	= "Kasalar";
		["TREASURE_FOOTLOCKER"]	= "Footlockers";
		["TREASURE_GLOWCAP"]	= "Glowcaps";
		["TREASURE_NIGHTDRAGON"]	= "Gece Dragon's Breath";
		["TREASURE_POWERCRYST"]	= "Güç Kristaller";
		["TREASURE_SHELLFISHTRAP"]	= "Kabuklu deniz Tuzaklar";
		["TREASURE_SONGFLOWER"]	= "Şarkıçiçekler";
		["TREASURE_UNGOROSOIL"]	= "Un'Goro Toprak";
		["TREASURE_WHIPPERROOT"]	= "Kırbaç Kök yumrular";
		["TREASURE_WINDBLOSSOM"]	= "Rüzgarçiçek Karpuzu";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "Bölge";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "# Nokta";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "Yüzde";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "Tip";
		["DENSITY_SEARCH_TITLE"]	= "Nokta sıklığı arama";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 ek içerik.";
		["NOTE_COUNT"]	= "%1 kere toplandı";
		["NOTE_DISTANCE"]	= "Menzil: %1 yard";
		["NOTE_IMPORTED"]	= "İçe alınan nokta";
		["NOTE_LASTVISITED"]	= "Son ziyaret: %1";
		["NOTE_OVERALLDROPS"]	= "Toplam düşürme oranı:";
		["NOTE_SOURCE"]	= "Kaynak: %1";
		["NOTE_UNSKILLED"]	= "Yetersiz yetenek";

		-- Section: Time
		["DAYS"]	= "Gün";
		["DAYS_ABBR"]	= "Gün";
		["DAYS_ABBR_P1"]	= "Gün";
		["DAYS_P1"]	= "Gün";
		["HOURS"]	= "Saat";
		["HOURS_ABBR"]	= "Sa";
		["HOURS_ABBR_P1"]	= "Sa";
		["HOURS_P1"]	= "Saat";
		["MINUTES"]	= "Dakika";
		["MINUTES_ABBR"]	= "Dk";
		["MINUTES_ABBR_P1"]	= "Dk";
		["MINUTES_P1"]	= "Dakika";
		["SECONDS"]	= "Saniye";
		["SECONDS_ABBR"]	= "Sn";
		["SECONDS_ABBR_P1"]	= "Sn";
		["SECONDS_P1"]	= "Saniye";
		["WEEKS"]	= "Hafta";
		["WEEKS_ABBR"]	= "Hf";
		["WEEKS_ABBR_P1"]	= "Hf";
		["WEEKS_P1"]	= "Hafta";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "Arkeoloji";
		["TRADE_HERBALISM"]	= "Bitki toplayıcı";
		["TRADE_MINING"]	= "Madencilik";

	};

	zhCN = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "送出采集点 %1 给 %2";
		["COMM_NODE_SEND_TWO"]	= "送出采集点 %1 给 %2 和 %3";
		["COMM_RECEIVE_NODE"]	= "已接收采集点 %1 于 %2 从 %3 (%4)";
		["NODE_ADD"]	= "已增加采集点 %1";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "显示加载完成信息";
		["CONFIG_ALL_FILTER_NOTE"]	= "'%1' 将导致目前的过滤设定被忽略,并且强制显示该类别的所有采集点";
		["CONFIG_ARCH_MAX_NOTES"]	= "显示: 最靠近 %d";
		["CONFIG_ENABLE_HERB"]	= "显示采药点";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "仅当学会采药时显示";
		["CONFIG_ENABLE_MINE"]	= "显示采矿点";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "仅当学会采矿时显示";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "仅当正在跟踪时";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "小地图按钮选项";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "小地图跟踪选项";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "世界地图选项";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "世界地图跟踪选项";
		["CONFIG_HERB_FILTER_LABEL"]	= "要跟踪的采药点";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "你确定要从资料库中删除此玩家分享的采集点吗? 这将永久性地删除掉 %d 个采集点";
		["CONFIG_IGNORE_PURGE_DONE"]	= "%d 个采集点已被永久地从资料库中删除";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "你真的想删除此玩家分享的所有采集点数据吗?";
		["CONFIG_MINE_FILTER_LABEL"]	= "要跟踪的采矿点";
		["CONFIG_MINIICON_ANGLE"]	= "按钮角度: %d°";
		["CONFIG_MINIICON_DISTANCE"]	= "距离: %d";
		["CONFIG_MINIICON_ENABLE"]	= "显示小地图按钮";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "小地图附加";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "显示匿名的采集点";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "匿名采集点的不透明度：%d%%";
		["CONFIG_MINIMAP_ANON_TINT"]	= "将匿名的采集点设为红色";
		["CONFIG_MINIMAP_DISTANCE"]	= "距离: %d 码";
		["CONFIG_MINIMAP_ENABLE"]	= "在小地图上显示注释";
		["CONFIG_MINIMAP_FADE_DIST"]	= "淡出于: %d 码";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "淡出小地图注释";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "淡出距离: %d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "图标大小: %d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "显示于：%d 码";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "标记采集点为监视点";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "监视点淡出: %d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "再检查于：%d 秒";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "检查中的显示为绿色";
		["CONFIG_MINIMAP_LABEL"]	= "小地图选项";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "显示: %d 最接近";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "预设不透明度: %d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "只在跟踪技能开启时";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "当接近时改变追踪图标";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "跟踪于：%d 码";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "开启跟踪技能";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "图标不透平度: %d%%";
		["CONFIG_OPEN_FILTER_LABEL"]	= "要跟踪的宝箱点";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "更改设定档：%1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "创建副本";
		["CONFIG_PROFILE_CREATE_NEW"]	= "新建";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "启用一个当前的设定档";
		["CONFIG_PROFILE_NEW"]	= "创建或替换一个设定档";
		["CONFIG_PROFILE_NEW_LABEL"]	= "新设定档名";
		["CONFIG_SECTION_ABOUT"]	= "关于";
		["CONFIG_SECTION_GENERAL"]	= "通用";
		["CONFIG_SECTION_HEADER_CORE"]	= "核心选项";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "插件";
		["CONFIG_SECTION_MINIMAP"]	= "小地图";
		["CONFIG_SECTION_OPEN"]	= "宝箱";
		["CONFIG_SECTION_PROFILES"]	= "设定档";
		["CONFIG_SECTION_SHARING"]	= "分享";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "关于Gatherer";
		["CONFIG_SECTION_TITLE_ARCH"]	= "考古选项";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "主选项";
		["CONFIG_SECTION_TITLE_HERB"]	= "采药过滤器";
		["CONFIG_SECTION_TITLE_MINE"]	= "采矿过滤器";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "小地图选项";
		["CONFIG_SECTION_TITLE_OPEN"]	= "宝箱过滤器";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "新建，设置和编辑设定档";
		["CONFIG_SECTION_TITLE_SHARING"]	= "同步选项";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "分享黑名单";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "加入队友发送的采集信息到数据库";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "开启小队同步";
		["CONFIG_SHARING_GROUP_LABEL"]	= "团队分享";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "当收到小队发送的采集信息时,显示一条信息";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "当发送给队友采集信息时,显示一条信息";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "加入公会会员发送的采集信息到资料库";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "开启公会同步";
		["CONFIG_SHARING_GUILD_LABEL"]	= "公会分享";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "当收到公会会员发送的采集信息时,显示一条信息";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "当发送给公会会员采集信息时,显示一条信息";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "当自己自己的采集点到数据库时,显示一条信息";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "私人通知";
		["CONFIG_TOOLTIP_COUNTS"]	= "显示采集到的数量";
		["CONFIG_TOOLTIP_DISTANCE"]	= "显示采集点距离";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "显示掉落率";
		["CONFIG_TOOLTIP_ENABLE"]	= "显示鼠标提示";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "显示最近一次发现的时间";
		["CONFIG_TOOLTIP_SOURCE"]	= "显示采集点来源";
		["CONFIG_WORLDMAP_ENABLE"]	= "在世界地图上显示采集点";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "图标大小: %d";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "显示: %d 采集点";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "不透明度: %d%%";
		["ENABLE_OPEN"]	= "显示宝箱采集点";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "当那个邪恶的超级坏蛋,死亡之翼的返回已经烧掉所有的草药,融化所有的矿石和摧毁所有的宝箱后 现在它们全部已经重新生长,重新结晶化,以及重新被海盗们再次藏起之后它们已经都出现在新的地点 寻宝吧!!(旧世界资料已经被清除由于广大的地理改变";
		["STORAGE_DB_VERSION_INVALID"]	= "警告！！！\n采集助手已侦测到你的数据库版本是失效的。 请按下接受来清除你的数据库，或是选择忽略若你想要自行修复数据库的话。";
		["STORAGE_DB_VERSION_NEWER"]	= "你拥有的采集数据库太新了。 你目前的数据库已被搁置直到你更新升级了采集助手。";

		-- Section: Game Object Tooltip
		["GAME_OBJECT_REQUIRES_REWRITE"]	= "%1$s %2$d";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "距离";
		["REPORT_COLUMN_HEADER_REGION"]	= "地区";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "来源";
		["REPORT_COLUMN_HEADER_TYPE"]	= "种类";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "你真的要删除 %d 的采集点？";
		["REPORT_DELETE_MARKED"]	= "删除已标记的";
		["REPORT_MARKED_NODES_COUNT"]	= "已标记的采集点：%1";
		["REPORT_MARKING_NOTE"]	= "附注：当你标记采集点后，它们将持续保持标记状态,直到你在看报告中点选该物品，使用解除标记按钮或离开游戏。";
		["REPORT_MARK_THESE"]	= "标记这些";
		["REPORT_SEARCH_BY_REGION"]	= "依照地区";
		["REPORT_SEARCH_BY_SOURCE"]	= "依照来源";
		["REPORT_SEARCH_BY_TYPE"]	= "依照种类";
		["REPORT_SEND_MARKED"]	= "发送已标记的";
		["REPORT_TITLE"]	= "采集报告";
		["REPORT_UNMARK_ALL"]	= "取消所有标记";
		["REPORT_UNMARK_THESE"]	= "取消这些的标记";

		-- Section: Generic Messages
		["DESCRIPTION"]	= "采集助手(Gatherer)是一个允许你纪录你的采集点位置并显示于你的大小地图和采集助手附加的抬头显示模式的插件。并允许你向你的队友、团队成员以及朋友来分享你的采集数据。";
		["DESCRIPTION_LICENSE"]	= "采集助手(Gatherer)是一款基于 GNU GPL v2 的开放原始码软件。请查看插件目录内附的gpl.txt 以了解完整的内容。";
		["LOADED_NOTIFICATION"]	= "采集助手 Gatherer v%1 -- 已载入！---BY 主宰之剑 永恒残星";
		["MANIFEST_INVALID_VERSIONS_WARNING"]	= "{{警告：}}你的采集助手似乎混和了不同版本的文件。\n\n请确认你删除了旧版本：\n%1\n目录，并从\n%2\n重新安装一个全新的\n先完整地重新启动魔兽世界后再回报任何可能出现的问题 。\n\n谢谢，\n  采集助手 Gatherer 开发团队";
		["VERSION_MESSAGE"]	= "采集助手 Gatherer v%1";
		["ZONETOKENS_UNIDENTIFIED_ZONES_WARNING"]	= "采集助手(Gatherer)无法辨认出以下的区域：{{%1}}\n如果那些区域是新的区域，那么这个并不是问题，而且你可以正常继续。\n但如果那些区域不是新的区域，那么请保持冷静{{你的数据并没有消失！}} 你的那些数据将会在你更新采集助手并进入游戏后升级，然后才能继续正常使用并收集新的采集点纪录。\n\n{{为了方便，请更新升级采集助手 Gatherer。}}";

		-- Section: Generic Strings
		["ACCEPT"]	= "接受";
		["ALL"]	= "全部";
		["CANCEL"]	= "取消";
		["DELETE"]	= "删除";
		["DONE"]	= "完成";
		["ENABLE"]	= "启用";
		["IGNORE"]	= "忽略";
		["IGNORE_PLAYER"]	= "忽略玩家";
		["NO"]	= "不";
		["OKAY"]	= "OK";
		["SEARCH"]	= "搜索";
		["STOP_IGNORE"]	= "移除玩家";
		["STRATA_BACKGROUND"]	= "背景";
		["STRATA_HIGH"]	= "高";
		["STRATA_LOW"]	= "低";
		["STRATA_MEDIUM"]	= "中";
		["YES"]	= "是";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "{{点击}} 来启动采集点显示。";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{右击}} 来查看采集报告。";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "{{Shift+点击}} 来启动HUD显示。";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "{{Shift+右击}} 來編輯编辑設置。";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "HUD";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "HUD 显示选项";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "HUD 热追踪模式";
		["HUD_CONFIG_HIDING_LABEL"]	= "HUD 隐藏选项";
		["HUD_CONFIG_plugin.gatherer_hud.alpha"]	= "全局 HUD 不透明度：%d%%";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "视角：%d°";
		["HUD_CONFIG_plugin.gatherer_hud.base.color"]	= "底色";
		["HUD_CONFIG_plugin.gatherer_hud.base.enable"]	= "使HUD变暗(提升可视性)";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "中心的颜色";
		["HUD_CONFIG_plugin.gatherer_hud.center.enable"]	= "启用玩家视野(Field Of View)圈";
		["HUD_CONFIG_plugin.gatherer_hud.fade"]	= "淡出注释于：半径 %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.heat.color"]	= "热追踪颜色";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "追踪冷却：%d 秒";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "显示探索追踪(热追踪)";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "永不冷却";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "追踪轨迹宽度：%d 码";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "战斗中隐藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "飞行时隐藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "室内隐藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "骑乘时隐藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "休息时隐藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "潜行时隐藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "游泳时隐藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "选定目标时隐藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "未上座骑时隐藏";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "注释大小：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"]	= "最低帧数：%d fps";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "水平偏移：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "垂直偏移：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "队友颜色";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "显示其他队友";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "小队图标大小：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "透视等级：%0.1f";
		["HUD_CONFIG_plugin.gatherer_hud.radius"]	= "全局 HUD 半径：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "注释范围：%d 码";
		["HUD_CONFIG_STRATA_LABEL"]	= "HUD 位层(图层等级)";
		["HUD_CONFIG_USAGE_NOTE"]	= "使用HUD将会降低你的帧数，若你开启了热追踪功能会在绘制热轨迹时降低更多的帧数。";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "HUD 可视性选项";
		["HUD_DESCRIPTION"]	= "HUD是一个允许你在你的屏幕上显示雷达的方式来追踪采集点位置的导航模块。";
		["HUD_TITLE"]	= "采集助手HUD插件";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "你的 CT_MapMod 数据已经导入。";
		["IMPORT_CTMOD_NODATA"]	= "没有发现任何要导入的 CT_MapMod 数据。";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "采集助手";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "显示/关闭选项对话框";

		-- Section: Labels
		["GENERAL_LABEL"]	= "通用";
		["LABEL_CONFIG"]	= "设置";
		["LABEL_DENSITY_REPORT"]	= "采集点搜索";
		["LABEL_NOTE"]	= "注释";
		["LABEL_REPORT"]	= "采集报告";
		["MAP_NOTES_HIDE"]	= "隐藏物品";
		["MAP_NOTES_SHOW"]	= "显示物品";
		["NOTIFICATIONS_TITLE"]	= "采集助手:警报";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "放弃上传。";
		["MASS_SHARING_ABORTED"]	= "已于 %1 时放弃";
		["MASS_SHARING_ACCEPTED"]	= "开始";
		["MASS_SHARING_ASKING"]	= "请求";
		["MASS_SHARING_BUSY"]	= "用户忙";
		["MASS_SHARING_CLOSED"]	= "已关闭";
		["MASS_SHARING_COMPLETE"]	= "成功";
		["MASS_SHARING_DONE"]	= "结束于 %1";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%1$s 想发送给你 %2$d 采集点 接受吗?";
		["MASS_SHARING_GATHERER_REPORT_TRANSMIT"]	= "你希望发送 %1$s 采集点给 %2$s 吗？\n(注意，他们必须要开启采集报告[Gatherables Report]窗口才能接收。)";
		["MASS_SHARING_RECEIVED_COUNT"]	= "接受 %1";
		["MASS_SHARING_REJECT"]	= "拒绝";
		["MASS_SHARING_SENDING"]	= "发送中";
		["MASS_SHARING_SENT"]	= "发送 %1";
		["MASS_SHARING_TIMEOUT"]	= "超时";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "灵尘花粉";
		["ORE_ADAMANTITE"]	= "精金";
		["ORE_BLOODSTONE"]	= "次级血石";
		["ORE_COPPER"]	= "铜矿";
		["ORE_DARKIRON"]	= "黑铁";
		["ORE_FELIRON"]	= "魔铁";
		["ORE_GOLD"]	= "金";
		["ORE_INCENDICITE"]	= "火岩";
		["ORE_INDURIUM"]	= "精铁碎片";
		["ORE_IRON"]	= "铁矿石";
		["ORE_KHORIUM"]	= "氪金";
		["ORE_MITHRIL"]	= "秘银";
		["ORE_NETHERCITE"]	= "虚空";
		["ORE_OBSIDIAN"]	= "黑曜石";
		["ORE_RADAMANTITE"]	= "富精金";
		["ORE_RTHORIUM"]	= "富瑟";
		["ORE_SILVER"]	= "银";
		["ORE_THORIUM"]	= "瑟银";
		["ORE_TIN"]	= "锡";
		["ORE_TRUESILVER"]	= "真银";
		["TREASURE_BARREL"]	= "桶";
		["TREASURE_BLOODPETAL"]	= "血瓣花苗";
		["TREASURE_BOX"]	= "箱子";
		["TREASURE_CASK"]	= "桶";
		["TREASURE_CHEST"]	= "宝箱";
		["TREASURE_CLAM"]	= "巨型蚌壳";
		["TREASURE_CRATE"]	= "补给箱";
		["TREASURE_FOOTLOCKER"]	= "手提箱";
		["TREASURE_GLOWCAP"]	= "亮顶蘑菇";
		["TREASURE_NIGHTDRAGON"]	= "夜龙之息";
		["TREASURE_POWERCRYST"]	= "能量水晶";
		["TREASURE_SHELLFISHTRAP"]	= "贝壳陷阱";
		["TREASURE_SONGFLOWER"]	= "轻歌花";
		["TREASURE_UNGOROSOIL"]	= "安戈洛的泥土";
		["TREASURE_WHIPPERROOT"]	= "鞭根块茎";
		["TREASURE_WINDBLOSSOM"]	= "风花果";

		-- Section: Node Database Plugins
		["DATABASE_IMPORT_BUTTON_LABEL"]	= "导入";
		["DATABASE_IMPORT_HEADER"]	= "要导入的采集点数据库：";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "地区";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "# 采集点";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "百分比";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "种类";
		["DENSITY_SEARCH_TITLE"]	= "采集点密度搜索";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1附加掉落...";
		["NOTE_COUNT"]	= "已采过%1";
		["NOTE_DISTANCE"]	= "距离: %1码";
		["NOTE_IMPORTED"]	= "导入采集数据";
		["NOTE_LASTVISITED"]	= "上次访问: %1";
		["NOTE_OVERALLDROPS"]	= "总体下降率:";
		["NOTE_SOURCE"]	= "来源: %1";
		["NOTE_UNSKILLED"]	= "无法采集";

		-- Section: Time
		["DAYS"]	= "天";
		["DAYS_ABBR"]	= "天";
		["DAYS_ABBR_P1"]	= "天";
		["DAYS_P1"]	= "天";
		["HOURS"]	= "小时";
		["HOURS_ABBR"]	= "时";
		["HOURS_ABBR_P1"]	= "时";
		["HOURS_P1"]	= "小时";
		["MINUTES"]	= "分钟";
		["MINUTES_ABBR"]	= "分";
		["MINUTES_ABBR_P1"]	= "分";
		["MINUTES_P1"]	= "分钟";
		["SECONDS"]	= "秒";
		["SECONDS_ABBR"]	= "秒";
		["SECONDS_ABBR_P1"]	= "秒";
		["SECONDS_P1"]	= "秒";
		["WEEKS"]	= "星期";
		["WEEKS_ABBR"]	= "周";
		["WEEKS_ABBR_P1"]	= "周";
		["WEEKS_P1"]	= "星期";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "考古学";
		["TRADE_HERBALISM"]	= "草药学";
		["TRADE_MINING"]	= "采矿";

	};

	zhTW = {

		-- Section: AddOn Communication
		["COMM_NODE_SEND"]	= "送出採集點 %1 給 %2";
		["COMM_NODE_SEND_TWO"]	= "送出採集點 %1 給 %2 和 %3";
		["COMM_RECEIVE_NODE"]	= "已接收採集點 %1 於 %2 從 %3 (%4)";
		["NODE_ADD"]	= "已增加採集點 %1";

		-- Section: Configuration
		["CONFIG_ABOUT_LOADED_ENABLE"]	= "顯示讀取完成訊息";
		["CONFIG_ALL_FILTER_NOTE"]	= "這 '%1' 選項將導致目前的過濾設定被忽略掉以及強制顯示該類別的所有採集點。";
		["CONFIG_ARCH_MAX_NOTES"]	= "顯示：最靠近 %d";
		["CONFIG_ENABLE_HERB"]	= "顯示草藥採集點";
		["CONFIG_ENABLE_HERB_HERBALIST_ONLY"]	= "只有草藥學角色";
		["CONFIG_ENABLE_MINE"]	= "顯示採礦採集點";
		["CONFIG_ENABLE_MINE_MINER_ONLY"]	= "只有採礦角色";
		["CONFIG_ENABLE_ONLY_IF_TRACKING"]	= "只於正在追蹤時";
		["CONFIG_GENERAL_MINIICON_LABEL"]	= "小地圖按鈕選項";
		["CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"]	= "小地圖追蹤選項";
		["CONFIG_GENERAL_WORLDMAP_LABEL"]	= "世界地圖選項";
		["CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"]	= "世界地圖追蹤選項";
		["CONFIG_HERB_FILTER_LABEL"]	= "要追蹤的草藥採集點";
		["CONFIG_IGNORE_PURGE_CONFIRM"]	= "你確定你真要從你的採集資料庫中清掉此玩家分享的採集點嗎？此動作 無法 被反轉並將會自你的採集資料庫中移除 %d 個採集點。";
		["CONFIG_IGNORE_PURGE_DONE"]	= "%d 個採集點已經被永久地從你的採集助手資料庫中移除。";
		["CONFIG_IGNORE_PURGE_QUESTION"]	= "你真的希望移除所有此玩家所分享的採集點資料？";
		["CONFIG_MINE_FILTER_LABEL"]	= "要追蹤的礦物採集點";
		["CONFIG_MINIICON_ANGLE"]	= "按鈕角度：%d°";
		["CONFIG_MINIICON_DISTANCE"]	= "距離：%d";
		["CONFIG_MINIICON_ENABLE"]	= "顯示小地圖按鈕";
		["CONFIG_MINIMAP_ADD_LABEL"]	= "小地圖添加";
		["CONFIG_MINIMAP_ANON_ENABLE"]	= "顯示匿名的採集點";
		["CONFIG_MINIMAP_ANON_OPACITY"]	= "匿名的不透明度：%d%%";
		["CONFIG_MINIMAP_ANON_TINT"]	= "將匿名的採集點設為紅色";
		["CONFIG_MINIMAP_DISTANCE"]	= "距離：%d 碼";
		["CONFIG_MINIMAP_ENABLE"]	= "在小地圖上顯示說明提示";
		["CONFIG_MINIMAP_FADE_DIST"]	= "淡出於：%d 碼";
		["CONFIG_MINIMAP_FADE_ENABLE"]	= "淡出小地圖的註解";
		["CONFIG_MINIMAP_FADE_PERCENT"]	= "淡出的距離：%d%%";
		["CONFIG_MINIMAP_ICON_SIZE"]	= "圖示大小：%d";
		["CONFIG_MINIMAP_INSPECT_DIST"]	= "檢視於：%d 碼";
		["CONFIG_MINIMAP_INSPECT_ENABLE"]	= "標記採集點為被檢視點";
		["CONFIG_MINIMAP_INSPECT_FADING"]	= "淡出被檢視點於：%d%%";
		["CONFIG_MINIMAP_INSPECT_TIMEOUT"]	= "再檢視於：%d 秒";
		["CONFIG_MINIMAP_INSPECT_TINT_ENABLE"]	= "綠色化當檢視中";
		["CONFIG_MINIMAP_LABEL"]	= "小地圖選項";
		["CONFIG_MINIMAP_MAX_NOTES"]	= "顯示：最接近 %d";
		["CONFIG_MINIMAP_NOTE_OPACITY"]	= "預設不透明度：%d%%";
		["CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"]	= "只在追蹤技能開啟時";
		["CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"]	= "當接近時轉變追蹤中圖示";
		["CONFIG_MINIMAP_TRACKING_DISTANCE"]	= "追蹤於：%d 碼";
		["CONFIG_MINIMAP_TRACKING_ENABLE"]	= "啟用追蹤技能功能";
		["CONFIG_MINIMAP_TRACKING_OPACITY"]	= "圖示不透明度：%d%%";
		["CONFIG_OPEN_FILTER_LABEL"]	= "要追蹤的寶箱採集點";
		["CONFIG_PROFILE_CHANGE_NOTIFICATION"]	= "更改設定檔：%1";
		["CONFIG_PROFILE_CREATE_COPY"]	= "建立複製";
		["CONFIG_PROFILE_CREATE_NEW"]	= "建立新的";
		["CONFIG_PROFILE_CURRENT_LABEL"]	= "啟用一個目前的設定檔";
		["CONFIG_PROFILE_NEW"]	= "建立或替換一個設定檔";
		["CONFIG_PROFILE_NEW_LABEL"]	= "新設定檔名稱：";
		["CONFIG_SECTION_ABOUT"]	= "關於";
		["CONFIG_SECTION_GENERAL"]	= "通用";
		["CONFIG_SECTION_HEADER_CORE"]	= "核心選項";
		["CONFIG_SECTION_HEADER_PLUGINS"]	= "插件";
		["CONFIG_SECTION_MINIMAP"]	= "小地圖";
		["CONFIG_SECTION_OPEN"]	= "寶箱";
		["CONFIG_SECTION_PROFILES"]	= "設定檔";
		["CONFIG_SECTION_SHARING"]	= "分享";
		["CONFIG_SECTION_TITLE_ABOUT"]	= "關於採集助手";
		["CONFIG_SECTION_TITLE_ARCH"]	= "考古學選項";
		["CONFIG_SECTION_TITLE_GENERAL"]	= "主要採集助手選項";
		["CONFIG_SECTION_TITLE_HERB"]	= "草藥學過濾器選項";
		["CONFIG_SECTION_TITLE_MINE"]	= "採礦過濾器選項";
		["CONFIG_SECTION_TITLE_MINIMAP"]	= "小地圖採集助手選項";
		["CONFIG_SECTION_TITLE_OPEN"]	= "寶箱過濾器選項";
		["CONFIG_SECTION_TITLE_PROFILES"]	= "設定，設置和編輯設定檔";
		["CONFIG_SECTION_TITLE_SHARING"]	= "同步化選項";
		["CONFIG_SHARING_BLACKLIST_LABEL"]	= "分享黑名單列表";
		["CONFIG_SHARING_GROUP_DATABASE"]	= "加入已收到的隊伍採集點到我的資料庫";
		["CONFIG_SHARING_GROUP_ENABLE"]	= "啟用隊伍同步分享功能";
		["CONFIG_SHARING_GROUP_LABEL"]	= "團隊/隊伍分享";
		["CONFIG_SHARING_GROUP_MESSAGE_RECV"]	= "當收到隊伍採集點時顯示一個訊息";
		["CONFIG_SHARING_GROUP_MESSAGE_SENT"]	= "當送出隊伍採集點時顯示一個訊息";
		["CONFIG_SHARING_GUILD_DATABASE"]	= "加入已收到的公會採集點到我的資料庫";
		["CONFIG_SHARING_GUILD_ENABLE"]	= "啟用公會同步分享功能";
		["CONFIG_SHARING_GUILD_LABEL"]	= "公會分享";
		["CONFIG_SHARING_GUILD_MESSAGE_RECV"]	= "當收到公會採集點時顯示一個訊息";
		["CONFIG_SHARING_GUILD_MESSAGE_SENT"]	= "當送出公會採集點時顯示一個訊息";
		["CONFIG_SHARING_PERSONAL_ENABLE"]	= "當增加自己的採集點時顯示一個訊息";
		["CONFIG_SHARING_PERSONAL_LABEL"]	= "私人通知";
		["CONFIG_TOOLTIP_COUNTS"]	= "顯示採集的數量";
		["CONFIG_TOOLTIP_DISTANCE"]	= "顯示採集點距離";
		["CONFIG_TOOLTIP_DROP_RATES"]	= "顯示掉落率";
		["CONFIG_TOOLTIP_ENABLE"]	= "顯示提示窗";
		["CONFIG_TOOLTIP_LAST_SEEN"]	= "顯示最後看見的時間";
		["CONFIG_TOOLTIP_SOURCE"]	= "顯示採集點來源";
		["CONFIG_WORLDMAP_ENABLE"]	= "顯示世界地圖上的註解";
		["CONFIG_WORLDMAP_ICON_SIZE"]	= "圖示大小：%d";
		["CONFIG_WORLDMAP_MAX_NOTES"]	= "顯示：%d 採集點";
		["CONFIG_WORLDMAP_NOTE_OPACITY"]	= "不透明度：%d%%";
		["ENABLE_OPEN"]	= "顯示寶箱採集點";

		-- Section: Database Version Messages
		["STORAGE_DB_CATACLYSMIC"]	= "當那個邪惡的超級壞蛋，死亡之翼的返回已經燒掉所有的草藥，融化所有的礦石和摧毀所有的寶箱後。 現在它們全部已經重新生長，重新結晶化，以及重新被海盜們再次藏起之後它們已經都出現在新的地點。 尋寶吧！！(舊世界資料已經被清除由於廣大的地理改變。)";
		["STORAGE_DB_VERSION_INVALID"]	= "警告！！！\n採集助手已偵測到你的資料庫版本是失效的。 請按下接受來清除你的資料庫，或是選擇忽略若你想要自行修復資料庫的話。";
		["STORAGE_DB_VERSION_NEWER"]	= "你擁有的採集資料庫太新了。 你目前的資料庫已被擱置直到你更新升級了採集助手。";

		-- Section: Game Object Tooltip
		["GAME_OBJECT_REQUIRES_REWRITE"]	= "%1$s %2$d";

		-- Section: Gatherables Report
		["REPORT_COLUMN_HEADER_DIST"]	= "距離";
		["REPORT_COLUMN_HEADER_REGION"]	= "地區";
		["REPORT_COLUMN_HEADER_SOURCE"]	= "來源";
		["REPORT_COLUMN_HEADER_TYPE"]	= "類別";
		["REPORT_COLUMN_HEADER_X"]	= "X";
		["REPORT_COLUMN_HEADER_Y"]	= "Y";
		["REPORT_DELETE_CONFIRMATION"]	= "你真的要刪除 %d 的採集點？";
		["REPORT_DELETE_MARKED"]	= "刪除已標記的";
		["REPORT_MARKED_NODES_COUNT"]	= "已標記的採集點：%1";
		["REPORT_MARKING_NOTE"]	= "附註：當你標記採集點，它們將持續標記著直到你點選報告中的該欄物品，或使用解除標記鈕又或是離開遊戲時。";
		["REPORT_MARK_THESE"]	= "標記這些";
		["REPORT_SEARCH_BY_REGION"]	= "於地區";
		["REPORT_SEARCH_BY_SOURCE"]	= "於來源";
		["REPORT_SEARCH_BY_TYPE"]	= "於類別";
		["REPORT_SEND_MARKED"]	= "送出已標記";
		["REPORT_TITLE"]	= "採集報告";
		["REPORT_UNMARK_ALL"]	= "全部解除標記";
		["REPORT_UNMARK_THESE"]	= "解除標記這些";

		-- Section: Generic Messages
		["DESCRIPTION"]	= "採集助手(Gatherer)是一個允許你紀錄你的採集點位置並顯示於你的大小地圖和採集助手附加的抬頭顯示模式的插件。並允許你向你的隊友、團隊成員以及朋友來分享你的採集資料。";
		["DESCRIPTION_LICENSE"]	= "採集助手(Gatherer)是一款基於 GNU GPL v2 的開放原始碼軟體。請查看插件目錄內附的gpl.txt 以瞭解完整的內容。";
		["LOADED_NOTIFICATION"]	= "採集助手 Gatherer v%1 -- 已載入！";
		["MANIFEST_INVALID_VERSIONS_WARNING"]	= "{{警告：}}你的採集助手安裝似乎混和了不同版本的檔案。\n\n請確認你刪除了舊的：\n%1\n目錄，並重新安裝一個全新的自：\n%2\n然後再回報任何問題前請先完整地重新啟動 魔獸世界 。\n\n謝謝，\n  採集助手 Gatherer 開發團隊";
		["VERSION_MESSAGE"]	= "這是 採集助手 Gatherer v%1";
		["ZONETOKENS_UNIDENTIFIED_ZONES_WARNING"]	= "採集助手(Gatherer)無法辨認出以下的區域：{{%1}}\n如果那些區域是新的區域，那麼這個並不是問題，而且你可以正常繼續。\n但如果那些區域不是新的區域，那麼請保持冷靜{{你的資料並沒有消失！}} 你的那些資料將會在你更新採集助手並進入遊戲後升級，然後才能繼續正常使用並收集新的採集點紀錄。\n\n{{為了方便，請更新升級採集助手 Gatherer。}}";

		-- Section: Generic Strings
		["ACCEPT"]	= "接受";
		["ALL"]	= "全部";
		["CANCEL"]	= "取消";
		["DELETE"]	= "刪除";
		["DONE"]	= "完成";
		["ENABLE"]	= "啟用";
		["IGNORE"]	= "忽略";
		["IGNORE_PLAYER"]	= "忽略玩家";
		["NO"]	= "不";
		["OKAY"]	= "好";
		["SEARCH"]	= "搜尋";
		["STOP_IGNORE"]	= "移除玩家";
		["STRATA_BACKGROUND"]	= "背景";
		["STRATA_HIGH"]	= "高";
		["STRATA_LOW"]	= "低";
		["STRATA_MEDIUM"]	= "中";
		["YES"]	= "是";

		-- Section: HelpTooltip
		["MINIICON_ACTIONS_CLICK"]	= "{{Click}} 來觸發採集點顯示。";
		["MINIICON_ACTIONS_RIGHT_CLICK"]	= "{{Right-Click}} 來查看採集回報。";
		["MINIICON_ACTIONS_SHIFT_CLICK"]	= "{{Shift-Click}} 來觸發抬頭顯示器式顯示。";
		["MINIICON_ACTIONS_SHIFT_RIGHT_CLICK"]	= "{{Shift-Right-Click}} 來編輯設置。";

		-- Section: HUD
		["HUD_ABBREVIATION"]	= "HUD";
		["HUD_CONFIG_DISPLAY_LABEL"]	= "HUD 顯示選項";
		["HUD_CONFIG_HEAT_TRACKING_LABEL"]	= "HUD 熱追蹤模式";
		["HUD_CONFIG_HIDING_LABEL"]	= "HUD 隱匿選項";
		["HUD_CONFIG_plugin.gatherer_hud.alpha"]	= "全域 HUD 不透明度：%d%%";
		["HUD_CONFIG_plugin.gatherer_hud.angle"]	= "觀看的角度：%d°";
		["HUD_CONFIG_plugin.gatherer_hud.base.color"]	= "基底的顏色";
		["HUD_CONFIG_plugin.gatherer_hud.base.enable"]	= "暗化 HUD 來提升可視性";
		["HUD_CONFIG_plugin.gatherer_hud.center.color"]	= "中心的顏色";
		["HUD_CONFIG_plugin.gatherer_hud.center.enable"]	= "啟用玩家視野(Field Of View)圈";
		["HUD_CONFIG_plugin.gatherer_hud.fade"]	= "淡出註解於：半徑 %d%%";
		["HUD_CONFIG_plugin.gatherer_hud.heat.color"]	= "熱追蹤的顏色";
		["HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"]	= "追蹤冷卻：%d 秒";
		["HUD_CONFIG_plugin.gatherer_hud.heat.enable"]	= "顯示探索追蹤(熱追蹤)";
		["HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"]	= "永不冷卻";
		["HUD_CONFIG_plugin.gatherer_hud.heat.size"]	= "追蹤軌跡寬度：%d 碼";
		["HUD_CONFIG_plugin.gatherer_hud.hide.combat"]	= "在戰鬥中隱藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.flying"]	= "當飛行時隱藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.inside"]	= "在內部時隱藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.mounted"]	= "上坐騎時隱藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.resting"]	= "於休息中隱藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.stealth"]	= "當潛行時隱藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.swimming"]	= "當游泳時隱藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.target"]	= "點選目標時隱藏";
		["HUD_CONFIG_plugin.gatherer_hud.hide.walking"]	= "未上座騎時隱藏";
		["HUD_CONFIG_plugin.gatherer_hud.iconsize"]	= "註解大小：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"]	= "最低描畫每一畫框格的格率：%d fps";
		["HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"]	= "水平偏移：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.offset.vertical"]	= "垂直偏移：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.party.color"]	= "隊伍成員的顏色";
		["HUD_CONFIG_plugin.gatherer_hud.party.enable"]	= "顯示其他隊伍成員";
		["HUD_CONFIG_plugin.gatherer_hud.party.size"]	= "隊伍圖示大小：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.perspective"]	= "透視等級：%0.1f";
		["HUD_CONFIG_plugin.gatherer_hud.radius"]	= "全域 HUD 半徑：%d 像素";
		["HUD_CONFIG_plugin.gatherer_hud.yards"]	= "註解範圍：%d 碼";
		["HUD_CONFIG_STRATA_LABEL"]	= "HUD 位層(描繪等級)";
		["HUD_CONFIG_USAGE_NOTE"]	= "使用抬頭顯示器(HUD)將會降低你的畫框速率(framerate)，若你開啟了熱追蹤功能會在畫出你經過路線的熱軌跡時降低更多的畫框速率。";
		["HUD_CONFIG_VISIBILITY_LABEL"]	= "HUD 可視性選項";
		["HUD_DESCRIPTION"]	= "此 HUD 是一個允許你在你的螢幕上以抬頭顯示式重疊畫面的方式來追蹤採集點位置的導航元件。";
		["HUD_TITLE"]	= "採集助手抬頭顯示(HUD)插件";

		-- Section: Import Modules
		["IMPORT_CTMOD_DONE"]	= "你的 CT_MapMod 資料已經匯入。";
		["IMPORT_CTMOD_NODATA"]	= "沒有發現任何要匯入的 CT_MapMod 資料。";

		-- Section: Keybinding Text
		["BINDING_HEADER_GATHERER"]	= "採集助手";
		["BINDING_NAME_GATHERER_TOGGLE_OPTIONS_DIALOG"]	= "選項對話框開關";

		-- Section: Labels
		["GENERAL_LABEL"]	= "通用";
		["LABEL_CONFIG"]	= "設置";
		["LABEL_DENSITY_REPORT"]	= "採集點查詢";
		["LABEL_NOTE"]	= "註解";
		["LABEL_REPORT"]	= "採集回報";
		["MAP_NOTES_HIDE"]	= "隱藏物件";
		["MAP_NOTES_SHOW"]	= "顯示物件";
		["NOTIFICATIONS_TITLE"]	= "採集助手：警告";

		-- Section: Mass Sharing Messages
		["MASS_SHARING_ABORT"]	= "放棄上傳。";
		["MASS_SHARING_ABORTED"]	= "已於 %1 處放棄";
		["MASS_SHARING_ACCEPTED"]	= "開始中...";
		["MASS_SHARING_ASKING"]	= "詢問中...";
		["MASS_SHARING_BUSY"]	= "忙碌中。";
		["MASS_SHARING_CLOSED"]	= "已經關閉。";
		["MASS_SHARING_COMPLETE"]	= "成功！";
		["MASS_SHARING_DONE"]	= "%1 已完成";
		["MASS_SHARING_GATHERER_COMM_REQUESTSEND"]	= "%1$s 想要傳送給你 %2$d 採集助手的採集點。接受嗎？";
		["MASS_SHARING_GATHERER_REPORT_TRANSMIT"]	= "你希望傳送 %1$s 採集點 給 %2$s ？\n(記得，他們必須要開啟採集回報[Gatherables Report]視窗才能接收。)";
		["MASS_SHARING_RECEIVED_COUNT"]	= "%1 已接收";
		["MASS_SHARING_REJECT"]	= "已被拒絕！";
		["MASS_SHARING_SENDING"]	= "傳送中...";
		["MASS_SHARING_SENT"]	= "%1 已傳送";
		["MASS_SHARING_TIMEOUT"]	= "已逾時。";

		-- Section: Node Category Names
		["HERB_NETHERDUST"]	= "虛空之塵花粉";
		["ORE_ADAMANTITE"]	= "堅鋼";
		["ORE_BLOODSTONE"]	= "次級血石";
		["ORE_COPPER"]	= "銅";
		["ORE_DARKIRON"]	= "黑鐵";
		["ORE_FELIRON"]	= "魔鐵";
		["ORE_GOLD"]	= "金";
		["ORE_INCENDICITE"]	= "火岩";
		["ORE_INDURIUM"]	= "精鐵";
		["ORE_IRON"]	= "鐵";
		["ORE_KHORIUM"]	= "克銀";
		["ORE_MITHRIL"]	= "秘銀";
		["ORE_NETHERCITE"]	= "虛空傳喚礦石";
		["ORE_OBSIDIAN"]	= "黑曜石";
		["ORE_RADAMANTITE"]	= "豐沃的堅鋼";
		["ORE_RTHORIUM"]	= "富瑟銀";
		["ORE_SILVER"]	= "銀";
		["ORE_THORIUM"]	= "瑟銀";
		["ORE_TIN"]	= "錫";
		["ORE_TRUESILVER"]	= "真銀";
		["TREASURE_BARREL"]	= "桶";
		["TREASURE_BLOODPETAL"]	= "血瓣花苗";
		["TREASURE_BOX"]	= "盒子";
		["TREASURE_CASK"]	= "桶";
		["TREASURE_CHEST"]	= "寶箱";
		["TREASURE_CLAM"]	= "巨型蚌殼";
		["TREASURE_CRATE"]	= "箱子";
		["TREASURE_FOOTLOCKER"]	= "提箱";
		["TREASURE_GLOWCAP"]	= "白閃菇";
		["TREASURE_NIGHTDRAGON"]	= "夜龍之息";
		["TREASURE_POWERCRYST"]	= "能量水晶";
		["TREASURE_SHELLFISHTRAP"]	= "貝殼陷阱";
		["TREASURE_SONGFLOWER"]	= "輕歌花";
		["TREASURE_UNGOROSOIL"]	= "安戈洛的泥土";
		["TREASURE_WHIPPERROOT"]	= "鞭根塊莖";
		["TREASURE_WINDBLOSSOM"]	= "風花果";

		-- Section: Node Database Plugins
		["DATABASE_IMPORT_BUTTON_LABEL"]	= "匯入";
		["DATABASE_IMPORT_HEADER"]	= "要匯入的採集點資料庫：";

		-- Section: Node Density Search
		["DENSITY_COLUMN_HEADER_LOCATION"]	= "地點";
		["DENSITY_COLUMN_HEADER_NUM_NODE"]	= "# 採集點";
		["DENSITY_COLUMN_HEADER_PERCENT"]	= "百分比";
		["DENSITY_COLUMN_HEADER_TYPE"]	= "類別";
		["DENSITY_SEARCH_TITLE"]	= "採集點密度搜尋";

		-- Section: Node Tooltip Messages
		["NOTE_ADDITIONAL"]	= "%1 附加的掉落...";
		["NOTE_COUNT"]	= "已採集 %1 次";
		["NOTE_DISTANCE"]	= "距離: %1 碼";
		["NOTE_IMPORTED"]	= "匯入的採集";
		["NOTE_LASTVISITED"]	= "上次採集: %1";
		["NOTE_OVERALLDROPS"]	= "整體掉落率:";
		["NOTE_SOURCE"]	= "來源: %1";
		["NOTE_UNSKILLED"]	= "無法採集";

		-- Section: Time
		["DAYS"]	= "日";
		["DAYS_ABBR"]	= "日";
		["DAYS_ABBR_P1"]	= "日";
		["DAYS_P1"]	= "日";
		["HOURS"]	= "時";
		["HOURS_ABBR"]	= "時";
		["HOURS_ABBR_P1"]	= "時";
		["HOURS_P1"]	= "時";
		["MINUTES"]	= "分";
		["MINUTES_ABBR"]	= "分";
		["MINUTES_ABBR_P1"]	= "分";
		["MINUTES_P1"]	= "分";
		["SECONDS"]	= "秒";
		["SECONDS_ABBR"]	= "秒";
		["SECONDS_ABBR_P1"]	= "秒";
		["SECONDS_P1"]	= "秒";
		["WEEKS"]	= "周";
		["WEEKS_ABBR"]	= "周";
		["WEEKS_ABBR_P1"]	= "周";
		["WEEKS_P1"]	= "周";

		-- Section: Trade Skill Names
		["PROFESSIONS_ARCHAEOLOGY"]	= "考古學";
		["TRADE_HERBALISM"]	= "草藥學";
		["TRADE_MINING"]	= "採礦";

	};

}