local ADDON_NAME, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "enUS", true, true)

if not L then return end

-------------------------------------------------------------------------------
----------------------------------- ICECROWN ----------------------------------
-------------------------------------------------------------------------------
L["plaguewave"] = "This is |cFFFF0000NOT|r a real boss, just for showing shared loots and spawn order of bosses.|n|nThe boss respawn interval is 10 minutes, spawn order is: |n|n 1. Noth the Plaguebringer|n 2. Patchwerk|n 3. Blood Queen Lana'thel|n 4. Professor Putricide|n 5. Lady Deathwhisper|n 6. Skadi the Ruthless|n 7. Ingvar the Plunderer|n 8. Prince Keleseth|n 9. The Black Knight|n10. Bronjahm|n11. Scourgelord Tyrannus|n12. Forgemaster Garfrost|n13. Marwyn|n14. Falric|n15. The Prophet Tharon'ja|n16. Novos the Summoner|n17. Trollgore|n18. Krik'thir the Gatewatcher|n19. Prince Taldaram|n20. Elder Nadox";

L["id174067"] = "(1) Originally in Naxxramas."
L["id174066"] = "(2) Originally in Naxxramas."
L["id174065"] = "(3) Originally in Icecrown Citadel."
L["id174064"] = "(4) Originally in Icecrown Citadel."
L["id174063"] = "(5) Originally in Icecrown Citadel."
L["id174062"] = "(6) Originally in Utgarde Pinnacle."
L["id174061"] = "(7) Originally in Utgarde Keep."
L["id174060"] = "(8) Originally in Utgarde Keep and Icecrown Citadel."
L["id174059"] = "(9) Originally in Trial of the Champion."
L["id174058"] = "(10) Originally in The Forge of Souls."
L["id174057"] = "(11) Originally in Pit of Saron."
L["id174056"] = "(12) Originally in Pit of Saron."
L["id174055"] = "(13) Originally in Halls of Reflection."
L["id174054"] = "(14) Originally in Halls of Reflection."
L["id174053"] = "(15) Originally in Drak'Tharon Keep."
L["id174052"] = "(16) Originally in Drak'Tharon Keep."
L["id174051"] = "(17) Originally in Drak'Tharon Keep."
L["id174050"] = "(18) Originally in Azjol-Nerub."
L["id174049"] = "(19) Originally in Ahn'kahet: The Old Kingdom."
L["id174048"] = "(20) Originally in Ahn'kahet: The Old Kingdom."



-------------------------------------------------------------------------------
------------------------------------ GEAR -------------------------------------
-------------------------------------------------------------------------------

L["cloth"] = "Cloth";
L["leather"] = "Leather";
L["mail"] = "Mail";
L["plate"] = "Plate";

L["1h_mace"] = "1h Mace";
L["1h_sword"] = "1h Sword";
L["1h_axe"] = "1h Axe";
L["2h_mace"] = "2h Mace";
L["2h_axe"] = "2h Axe";
L["2h_sword"] = "2h Sword";
L["shield"] = "Shield";
L["dagger"] = "Dagger";
L["staff"] = "Staff";
L["fist"] = "Fist";
L["polearm"] = "Polearm";
L["bow"] = "Bow";
L["gun"] = "Gun";
L["wand"] = "Wand";
L["crossbow"] = "Crossbow";
L["offhand"] = "Off Hand";
L["warglaives"] = "Warglaives";

L["ring"] = "Ring";
L["amulet"] = "Amulet";
L["cloak"] = "Cloak";
L["trinket"] = "Trinket";

-------------------------------------------------------------------------------
---------------------------------- TOOLTIPS -----------------------------------
-------------------------------------------------------------------------------

L["retrieving"] = "Retrieving item link ...";
L["in_cave"] = "In a cave.";
L["weekly"] = "Weekly";
L["normal"] = "Normal";
L["hard"] = "Hard";
L["mount"] = "Mount";
L["pet"] = "Pet";
L["toy"] = "Toy";
L["completed"] = "Completed"
L["incomplete"] = "Incomplete"
L["known"] = "Known"
L["missing"] = "Missing"
L["unobtainable"] = "Unobtainable"
L["unlearnable"] = "Unlearnable"

-------------------------------------------------------------------------------
--------------------------------- CONTEXT MENU --------------------------------
-------------------------------------------------------------------------------

L["context_menu_title"] = "HandyNotes Scourge Invasion of Shadowlands";
L["context_menu_add_tomtom"] = "Add to TomTom";
L["context_menu_hide_node"] = "Hide this node";
L["context_menu_restore_hidden_nodes"] = "Restore all hidden nodes";
L["Icecrown"] = "Icecrown";

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

L["options_title"] = "Scourge Invasion of Shadowlands";

------------------------------------ ICONS ------------------------------------

L["options_icon_settings"] = "Icon Settings";
L["options_icons_treasures"] = "Treasure Icons";
L["options_icons_rares"] = "Rare Icons";
L["options_icons_caves"] = "Cave Icons";
L["options_icons_pet_battles"] = "Pet Battle Icons";
L["options_icons_other"] = "Other Icons";
L["options_scale"] = "Scale";
L["options_scale_desc"] = "1 = 100%";
L["options_opacity"] = "Opacity";
L["options_opacity_desc"] = "0 = transparent, 1 = opaque";

---------------------------------- VISIBILITY ---------------------------------

L["options_visibility_settings"] = "Visibility";
L["options_general_settings"] = "General";
L["options_toggle_looted_rares"] = "Always show all rares";
L["options_toggle_looted_rares_desc"] = "Show every rare regardless of looted status";
L["options_toggle_looted_treasures"] = "Already looted Treasures";
L["options_toggle_looted_treasures_desc"] = "Show every treasure regardless of looted status";
L["options_toggle_hide_done_rare"] = "Hide rare, if all loot known";
L["options_toggle_hide_done_rare_desc"] = "Hide all rares for which all loot is known.";
L["options_toggle_hide_minimap"] = "Hide all icons on the minimap";
L["options_toggle_hide_minimap_desc"] = "Hides all icons from this addon on the minimap and displays them only on the main map.";

L["options_toggle_battle_pets_desc"] = "Display locations of battle pet trainers and NPCs.";
L["options_toggle_battle_pets"] = "Battle Pets";
L["options_toggle_caves_desc"] = "Display cave entrances for other nodes.";
L["options_toggle_caves"] = "Caves";
L["options_toggle_misc"] = "Miscellaneous";
L["options_toggle_npcs"] = "NPCs";
L["options_toggle_rares_desc"] = "Display locations of rare NPCs.";
L["options_toggle_rares"] = "Rares";
L["options_toggle_supplies_desc"] = "Display all possible locations for war supply crates.";
L["options_toggle_supplies"] = "War Supply Drops";
L["options_toggle_treasures"] = "Treasures";

---------------------------------- TOOLTIP ---------------------------------

L["options_tooltip_settings"] = "Tooltip";
L["options_tooltip_settings_desc"] = "Tooltip";
L["options_toggle_show_loot"] = "Show Loot";
L["options_toggle_show_loot_desc"] = "Add loot information to the tooltip";
L["options_toggle_show_notes"] = "Show Notes";
L["options_toggle_show_notes_desc"] = "Add helpful notes to the tooltip where available";

--------------------------------- DEVELOPMENT ---------------------------------

L["options_dev_settings"] = "Development";
L["options_dev_settings_desc"] = "Development settings";
L["options_toggle_show_debug"] = "Debug";
L["options_toggle_show_debug_desc"] = "Show debug stuff";
L["options_toggle_ignore_quests"] = "Ignore Quests";
L["options_toggle_ignore_quests_desc"] = "Ignore quest status of nodes";
L["options_toggle_force_nodes"] = "Force Nodes";
L["options_toggle_force_nodes_desc"] = "Force display all nodes";

