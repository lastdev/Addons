local ADDON_NAME, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "enUS", true, true)
if not L then return end

L["timelessisle"] = "Timeless Isle";
L["options_toggle_treasures"] = "Treasure chests"
L["options_toggle_treasures_desc"] = "Display locations of treasure chests."
L["options_toggle_rares"] = "Rares"
L["options_toggle_rares_desc"] = "Display locations of rares."

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

local GREEN = '(|cFF00FF00%s|r)';
local RED = '(|cFFFF0000%s|r)';
local ORANGE = '(|cFFFF8C00%s|r)';

L["(green)"] = GREEN;
L["(red)"] = RED;
L["(completed)"] = string.format(GREEN, "Completed");
L["(incomplete)"] = string.format(RED, "Incomplete");
L["(known)"] = string.format(GREEN, "Known");
L["(missing)"] = string.format(RED, "Missing");
L["(unlearnable)"] = string.format(ORANGE, "Unlearnable");
L["(gweekly)"] = string.format(GREEN, "Weekly");
L["(rweekly)"] = string.format(RED, "Weekly");

-------------------------------------------------------------------------------
--------------------------------- CONTEXT MENU --------------------------------
-------------------------------------------------------------------------------

L["context_menu_title"] = "HandyNotes Timeless Isle";
L["context_menu_add_tomtom"] = "Add to TomTom";
L["context_menu_hide_node"] = "Hide this node";
L["context_menu_restore_hidden_nodes"] = "Restore all hidden nodes";

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

L["options_title"] = "Timeless Isle";

------------------------------------ ICONS ------------------------------------

L["options_icon_settings"] = "Icon Settings";
L["options_icons_treasures"] = "Treasure Icons";
L["options_icons_rares"] = "Rare Icons";
L["options_icons_caves"] = "Caves Icons";
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
