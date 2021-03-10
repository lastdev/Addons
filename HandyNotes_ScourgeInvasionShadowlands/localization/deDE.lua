local ADDON_NAME, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "deDE", false, true)

if not L then return end

-------------------------------------------------------------------------------
----------------------------------- ICECROWN ----------------------------------
-------------------------------------------------------------------------------
L["plaguewave"] = "Dies ist |cFFFF0000KEIN|r echter Boss und dient zur Demonstration geteilten Loots und Spawnreihenfolge der Bosse.|n|nDer Boss respawn-Intervall beträgt 10 Minuten, Spawnreihenfolge ist: |n|n 1. Noth der Seuchenfürst|n 2. Flickwerk|n 3. Blutkönigin Lana'thel|n 4. Professor Seuchenmord|n 5. Lady Todeswisper|n 6. Skadi der Skrupellose|n 7. Ingvar der Brandschatzer|n 8. Prinz Keleseth|n 9. Der schwarze Ritter|n10. Bronjahm|n11. Geißelfürst Tyrannus|n12. Schmiedemeister Garfrost|n13. Marwyn|n14. Falric|n15. Der Prophet Tharon'ja|n16. Novos der Beschwörer|n17. Trollgrind|n18. Krik'thir der Torwächter|n19. Prinz Taldaram|n20. Urahne Nadox";

L["id174067"] = "(1) Ursprünglich in Naxxramas."
L["id174066"] = "(2) Ursprünglich in Naxxramas."
L["id174065"] = "(3) Ursprünglich in Eiskronenzitadelle."
L["id174064"] = "(4) Ursprünglich in Eiskronenzitadelle."
L["id174063"] = "(5) Ursprünglich in Eiskronenzitadelle."
L["id174062"] = "(6) Ursprünglich in Turm Utgarde."
L["id174061"] = "(7) Ursprünglich in Burg Utgarde."
L["id174060"] = "(8) Ursprünglich in Burg Utgarde und Eiskronenzitadelle."
L["id174059"] = "(9) Ursprünglich in Prüfung des Champions."
L["id174058"] = "(10) Ursprünglich in Seelenschmiede."
L["id174057"] = "(11) Ursprünglich in Grube von Saron."
L["id174056"] = "(12) Ursprünglich in Grube von Saron."
L["id174055"] = "(13) Ursprünglich in Hallen der Reflektion."
L["id174054"] = "(14) Ursprünglich in Hallen der Reflektion."
L["id174053"] = "(15) Ursprünglich in Feste Drak'Tharon."
L["id174052"] = "(16) Ursprünglich in Feste Drak'Tharon."
L["id174051"] = "(17) Ursprünglich in Feste Drak'Tharon."
L["id174050"] = "(18) Ursprünglich in Azjol-Nerub."
L["id174049"] = "(19) Ursprünglich in Ahn'kahet: Das alte Königreich."
L["id174048"] = "(20) Ursprünglich in Ahn'kahet: Das alte Königreich."



-------------------------------------------------------------------------------
------------------------------------ GEAR -------------------------------------
-------------------------------------------------------------------------------

L["cloth"] = "Stoff";
L["leather"] = "Leder";
L["mail"] = "Kette";
L["plate"] = "Platte";

L["1h_mace"] = "1h Streitkolben";
L["1h_sword"] = "1h Schwert";
L["1h_axe"] = "1h Axt";
L["2h_mace"] = "2h Streitkolben";
L["2h_axe"] = "2h Axt";
L["2h_sword"] = "2h Schwert";
L["shield"] = "Schild";
L["dagger"] = "Dolch";
L["staff"] = "Stab";
L["fist"] = "Faustwaffe";
L["polearm"] = "Stangenwaffe";
L["bow"] = "Bogen";
L["gun"] = "Gewehr";
L["wand"] = "Zauberstab";
L["crossbow"] = "Armbrust";
L["offhand"] = "Off Hand";
L["warglaives"] = "Kriegsgleve";

L["ring"] = "Ring";
L["amulet"] = "Amulett";
L["cloak"] = "Umhang";
L["trinket"] = "Schmuckstück";

-------------------------------------------------------------------------------
---------------------------------- TOOLTIPS -----------------------------------
-------------------------------------------------------------------------------

L["retrieving"] = "Rufe Gegenstandsinformationen ab...";
L["in_cave"] = "In einer Höhle.";
L["weekly"] = "Wöchentlich";
L["normal"] = "Normal";
L["hard"] = "Schwer";
L["mount"] = "Reittier";
L["pet"] = "Haustier";
L["toy"] = "Spielzeug";
L["completed"] = "Vollständig"
L["incomplete"] = "Unvollständig"
L["known"] = "Bekannt"
L["missing"] = "Fehlend"
L["unobtainable"] = "Unerreichbar"
L["unlearnable"] = "Nicht erlernbar"

-------------------------------------------------------------------------------
--------------------------------- CONTEXT MENU --------------------------------
-------------------------------------------------------------------------------

L["context_menu_title"] = "HandyNotes Scourge Invasion of Shadowlands";
L["context_menu_add_tomtom"] = "Zu TomTom hinzufügen";
L["context_menu_hide_node"] = "Diesen Knoten verbergen";
L["context_menu_restore_hidden_nodes"] = "Alle verborgenen Knoten wiederherstellen";
L["Icecrown"] = "Eiskrone";

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

L["options_title"] = "Scourge Invasion of Shadowlands";

------------------------------------ ICONS ------------------------------------

L["options_icon_settings"] = "Symboleinstellungen";
L["options_icons_treasures"] = "Schatz-Symbole";
L["options_icons_rares"] = "Seltene-Symbole";
L["options_icons_caves"] = "Höhlen-Symbole";
L["options_icons_pet_battles"] = "Haustierkampf-Symbole";
L["options_icons_other"] = "Andere Symbole";
L["options_scale"] = "Maßstab";
L["options_scale_desc"] = "1 = 100%";
L["options_opacity"] = "Deckkraft";
L["options_opacity_desc"] = "0 = Transparent, 1 = Undurchsichtig";

---------------------------------- VISIBILITY ---------------------------------

L["options_visibility_settings"] = "Sichtbarkeit";
L["options_general_settings"] = "Allgemein";
L["options_toggle_looted_rares"] = "Immer alle Rares anzeigen";
L["options_toggle_looted_rares_desc"] = "Zeige sämtliche Rares ungeachtet des Lootstatus";
L["options_toggle_looted_treasures"] = "Bereits geplünderte Schätze";
L["options_toggle_looted_treasures_desc"] = "Zeige sämtliche Schätze ungeachtet des Lootstatus";
L["options_toggle_hide_done_rare"] = "Rare ausblenden, sofern sämtlicher Loot bereits bekannt";
L["options_toggle_hide_done_rare_desc"] = "Alle Rares ausblenden, bei welchen sämtlicher Loot bereits bekannt ist.";
L["options_toggle_hide_minimap"] = "Alle Symbole auf der Minimap ausblenden";
L["options_toggle_hide_minimap_desc"] = "Alle Symbole dieses Addons auf der Minimap ausblenden und lediglich auf der Hauptkarte anzeigen.";

L["options_toggle_battle_pets_desc"] = "Zeigt die Standorte von Kampfhaustiertrainern und NPCs.";
L["options_toggle_battle_pets"] = "Kampfhaustiere";
L["options_toggle_caves_desc"] = "Zeigt Höhleneingänge anderer Knoten an.";
L["options_toggle_caves"] = "Höhlen";
L["options_toggle_misc"] = "Verschiedenes";
L["options_toggle_npcs"] = "NPCs";
L["options_toggle_rares_desc"] = "Zeigt die Standorte von seltenen NPCs.";
L["options_toggle_rares"] = "Rare-Mobs";
L["options_toggle_supplies_desc"] = "Zeigt alle möglichen Standorte der Kriegsausrüstungstruhen.";
L["options_toggle_supplies"] = "Kriegsausrüstungs Drops";
L["options_toggle_treasures"] = "Schätze";

---------------------------------- TOOLTIP ---------------------------------

L["options_tooltip_settings"] = "Tooltip";
L["options_tooltip_settings_desc"] = "Tooltip";
L["options_toggle_show_loot"] = "Zeige Loot";
L["options_toggle_show_loot_desc"] = "Füge Lootinformationen zum Tooltip hinzu";
L["options_toggle_show_notes"] = "Zeige Anmerkungen";
L["options_toggle_show_notes_desc"] = "Füge hilfreiche Anmerkungen zum Tooltip, sofern verfügbar";

--------------------------------- DEVELOPMENT ---------------------------------

L["options_dev_settings"] = "Entwickler";
L["options_dev_settings_desc"] = "Entwicklereinstellungen";
L["options_toggle_show_debug"] = "Debug";
L["options_toggle_show_debug_desc"] = "Zeige Debuginformationen";
L["options_toggle_ignore_quests"] = "Quests ignorieren";
L["options_toggle_ignore_quests_desc"] = "Ignoriere Queststatus der Knoten";
L["options_toggle_force_nodes"] = "Forciere Knoten";
L["options_toggle_force_nodes_desc"] = "Erzwinge Anzeige aller Knoten";
