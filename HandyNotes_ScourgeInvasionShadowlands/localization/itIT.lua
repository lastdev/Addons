local ADDON_NAME, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "itIT", false, true)

if not L then return end

-------------------------------------------------------------------------------
----------------------------------- ICECROWN ----------------------------------
-------------------------------------------------------------------------------
L["plaguewave"] = "Questo |cFFFF0000NON|r indica la posizione di un boss, viene usato solo per indicare il bottino condiviso di tutti i rari e l'ordine di apparizione.|n|nI vari boss hanno un tempo di respawn di 10 minuti, e l'ordine di apparizione è il seguente: |n|n 1. Noth l'Araldo della Piaga|n 2. Pezzacarne|n 3. Regina del Sangue Lana'thel|n 4. Professor Putricidio|n 5. Dama Soffiamorte|n 6. Skadi lo Spietato|n 7. Ingvar il Saccheggiatore|n 8. Principe Keleseth|n 9. Il Cavaliere Nero|n10. Bronjahm|n11. Signore della Piaga Tirannus|n12. Mastro Forgiatore Gargelo|n13. Marwyn|n14. Falric|n15. Tharon'ja il Profeta|n16. Novos l'Evocatore|n17. Falciatroll|n18. Krik'thir il Guardiano|n19. Principe Taldaram|n20. Anziano Nadox";

L["id174067"] = "(1) Originariamente a Naxxramas."
L["id174066"] = "(2) Originariamente a Naxxramas."
L["id174065"] = "(3) Originariamente a Rocca della Corona di Ghiaccio."
L["id174064"] = "(4) Originariamente a Rocca della Corona di Ghiaccio."
L["id174063"] = "(5) Originariamente a Rocca della Corona di Ghiaccio."
L["id174062"] = "(6) Originariamente a Pinnacolo di Utgarde."
L["id174061"] = "(7) Originariamente a Forte Utgarde."
L["id174060"] = "(8) Originariamente a Forte Utgarde e Rocca della Corona di Ghiaccio."
L["id174059"] = "(9) Originariamente a Ordalia dei Campioni."
L["id174058"] = "(10) Originariamente a Forgia delle Anime."
L["id174057"] = "(11) Originariamente a Fossa di Saron."
L["id174056"] = "(12) Originariamente a Fossa di Saron."
L["id174055"] = "(13) Originariamente a Sale dei Riflessi."
L["id174054"] = "(14) Originariamente a Sale dei Riflessi."
L["id174053"] = "(15) Originariamente a Forte di Drak'Tharon."
L["id174052"] = "(16) Originariamente a Forte di Drak'Tharon."
L["id174051"] = "(17) Originariamente a Forte di Drak'Tharon."
L["id174050"] = "(18) Originariamente a Azjol-Nerub."
L["id174049"] = "(19) Originariamente a Ahn'kahet, il Regno Antico."
L["id174048"] = "(20) Originariamente a Ahn'kahet, il Regno Antico."



-------------------------------------------------------------------------------
------------------------------------ GEAR -------------------------------------
-------------------------------------------------------------------------------

L["cloth"] = "Stoffa";
L["leather"] = "Cuoio";
L["mail"] = "Maglia";
L["plate"] = "Piastre";

L["1h_mace"] = "Mazza a una mano";
L["1h_sword"] = "Spada a una mano";
L["1h_axe"] = "Ascia a una mano";
L["2h_mace"] = "Mazza a due mani";
L["2h_axe"] = "Ascia a due mani";
L["2h_sword"] = "Spada a due mani";
L["shield"] = "Scudo";
L["dagger"] = "Pugnale";
L["staff"] = "Bastone";
L["fist"] = "Tirapugni";
L["polearm"] = "Arma ad Asta";
L["bow"] = "Arco";
L["gun"] = "Arma da Fuoco";
L["wand"] = "Bacchetta";
L["crossbow"] = "Balestra";
L["offhand"] = "Accessorio";
L["warglaives"] = "Lama da Guerra";

L["ring"] = "Anello";
L["amulet"] = "Collana";
L["cloak"] = "Mantello";
L["trinket"] = "Monile";

-------------------------------------------------------------------------------
---------------------------------- TOOLTIPS -----------------------------------
-------------------------------------------------------------------------------

L["retrieving"] = "Link oggetto in recupero ...";
L["in_cave"] = "In una grotta.";
L["weekly"] = "Settimanale";
L["normal"] = "Normale";
L["hard"] = "Eroico";
L["mount"] = "Cavalcatura";
L["pet"] = "Mascotte";
L["toy"] = "Giocattolo";
L["completed"] = "Completo"
L["incomplete"] = "Non completo"
L["known"] = "Conosciuto"
L["missing"] = "Mancante"
L["unobtainable"] = "Non ottenibile"
L["unlearnable"] = "Non imparabile"

-------------------------------------------------------------------------------
--------------------------------- CONTEXT MENU --------------------------------
-------------------------------------------------------------------------------

L["context_menu_title"] = "HandyNotes Invasione del Flagello di Shadowlands";
L["context_menu_add_tomtom"] = "Aggiungi a TomTom";
L["context_menu_hide_node"] = "Nascondi questo nodo";
L["context_menu_restore_hidden_nodes"] = "Reimposta tutti i nodi nascosti";
L["Icecrown"] = "Rocca della Corona di Ghiaccio";

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

L["options_title"] = "Invasione del Flagello di Shadowlands";

------------------------------------ ICONS ------------------------------------

L["options_icon_settings"] = "Impostazioni Icona";
L["options_icons_treasures"] = "Icona Tesoro";
L["options_icons_rares"] = "Icona Raro";
L["options_icons_caves"] = "Icona Grotta";
L["options_icons_pet_battles"] = "Icona Combattimento tra Mascotte";
L["options_icons_other"] = "Altre Icone";
L["options_scale"] = "Scalatura";
L["options_scale_desc"] = "1 = 100%";
L["options_opacity"] = "Opacità";
L["options_opacity_desc"] = "0 = trasparente, 1 = opaco";

---------------------------------- VISIBILITY ---------------------------------

L["options_visibility_settings"] = "Visibilità";
L["options_general_settings"] = "Generale";
L["options_toggle_looted_rares"] = "Mostra sempre tutti i rari";
L["options_toggle_looted_rares_desc"] = "Mostra ogni raro senza considerare l'effettivo status del bottino";
L["options_toggle_looted_treasures"] = "Tesori già depredati";
L["options_toggle_looted_treasures_desc"] = "Mostra ogni tesoro senza considerare l'effettivo status del bottino";
L["options_toggle_hide_done_rare"] = "Nascondi raro, se tutti i bottini sono stati depredati";
L["options_toggle_hide_done_rare_desc"] = "Nascondi tutti i rari di cui si è già depredato il relativo bottino.";
L["options_toggle_hide_minimap"] = "Nascondi tutte le icone sulla minimappa";
L["options_toggle_hide_minimap_desc"] = "Nascondi tutte le icone di questo addon sulla minimappa e mostrale solo sulla mappa principale.";

L["options_toggle_battle_pets_desc"] = "Mostra la locazione di tutti gli istruttori di Mascotte e PNG.";
L["options_toggle_battle_pets"] = "Mascotte da Battaglia";
L["options_toggle_caves_desc"] = "Mostra ingresso grotte per gli altri nodi.";
L["options_toggle_caves"] = "Grotte";
L["options_toggle_misc"] = "Varie";
L["options_toggle_npcs"] = "PNG";
L["options_toggle_rares_desc"] = "Mostra la locazione dei PNG Rari.";
L["options_toggle_rares"] = "Rari";
L["options_toggle_supplies_desc"] = "Mostra tutte le locazioni possibili dei lanci di Casse di Guerra.";
L["options_toggle_supplies"] = "Lancio di Casse di Guerra";
L["options_toggle_treasures"] = "Tesori";

---------------------------------- TOOLTIP ---------------------------------

L["options_tooltip_settings"] = "Tooltip";
L["options_tooltip_settings_desc"] = "Tooltip";
L["options_toggle_show_loot"] = "mostra bottino";
L["options_toggle_show_loot_desc"] = "Aggiungi informazioni sul bottino nel tooltip";
L["options_toggle_show_notes"] = "Mostra Nodi";
L["options_toggle_show_notes_desc"] = "Aggiungi note aggiuntive al tooltip quando disponibili";

--------------------------------- DEVELOPMENT ---------------------------------

L["options_dev_settings"] = "Sviluppo";
L["options_dev_settings_desc"] = "Impostazioni Sviluppo";
L["options_toggle_show_debug"] = "Debug";
L["options_toggle_show_debug_desc"] = "mostra output di debug";
L["options_toggle_ignore_quests"] = "Ignora Missioni";
L["options_toggle_ignore_quests_desc"] = "Ignore quest status of nodes";
L["options_toggle_force_nodes"] = "Forza Nodo";
L["options_toggle_force_nodes_desc"] = "Forza la visualizzazione di tutti i nodi";

