local ADDON_NAME, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "esES", false, true)

if not L then return end

-------------------------------------------------------------------------------
----------------------------------- ICECROWN ----------------------------------
-------------------------------------------------------------------------------
L["plaguewave"] = "Esto |cFFFF0000NO|r es un jefe, sirve únicamente para mostrar el botín compartido entre jefes y el orden de aparición de estos.|n|nEl intervalo de reaparición de los jefes es de 10 minutos, y el orden de aparición es el siguiente: |n|n 1. Noth el Pesteador|n 2. Remendejo|n 3. Reina de Sangre Lana'thel|n 4. Profesor Putricidio|n 5. Lady Susurramuerte|n 6. Skadi el Despiadado|n 7. Ingvar el Desvalijador|n 8. Príncipe Keleseth|n 9. El Caballero Negro|n10. Bronjahm|n11. Señor de la Plaga Tyrannus|n12. Maestro de forja Gargelus|n13. Marwyn|n14. Falric|n15. El profeta Tharon'ja|n16. Novos el Invocador|n17. Cuernotrol|n18. Krik'thir el Vigía de las puertas|n19. Príncipe Taldaram|n20. Ancestro Nadox";

L["id174067"] = "(1) Originalmente en Naxxramas."
L["id174066"] = "(2) Originalmente en Naxxramas."
L["id174065"] = "(3) Originalmente en Ciudadela de la Corona de Hielo."
L["id174064"] = "(4) Originalmente en Ciudadela de la Corona de Hielo."
L["id174063"] = "(5) Originalmente en Ciudadela de la Corona de Hielo."
L["id174062"] = "(6) Originalmente en Pináculo de Utgarde."
L["id174061"] = "(7) Originalmente en Fortaleza de Utgarde."
L["id174060"] = "(8) Originalmente en Fortaleza de Utgarde y Ciudadela de la Corona de Hielo."
L["id174059"] = "(9) Originalmente en Prueba del Campeón."
L["id174058"] = "(10) Originalmente en La Forja de Almas."
L["id174057"] = "(11) Originalmente en Foso de Saron."
L["id174056"] = "(12) Originalmente en Foso de Saron."
L["id174055"] = "(13) Originalmente en Cámaras de Reflexión."
L["id174054"] = "(14) Originalmente en Cámaras de Reflexión."
L["id174053"] = "(15) Originalmente en Fortaleza de Drak'Tharon."
L["id174052"] = "(16) Originalmente en Fortaleza de Drak'Tharon."
L["id174051"] = "(17) Originalmente en Fortaleza de Drak'Tharon."
L["id174050"] = "(18) Originalmente en Azjol-Nerub."
L["id174049"] = "(19) Originalmente en Ahn'kahet: El Antiguo Reino."
L["id174048"] = "(20) Originalmente en Ahn'kahet: El Antiguo Reino."



-------------------------------------------------------------------------------
------------------------------------ GEAR -------------------------------------
-------------------------------------------------------------------------------

L["cloth"] = "Tela";
L["leather"] = "Cuero";
L["mail"] = "Malla";
L["plate"] = "Placas";

L["1h_mace"] = "Maza 1M";
L["1h_sword"] = "Espada 1M";
L["1h_axe"] = "Hacha 1M";
L["2h_mace"] = "Maza 2M";
L["2h_axe"] = "Hacha 2M";
L["2h_sword"] = "Espada 2M";
L["shield"] = "Escudo";
L["dagger"] = "Daga";
L["staff"] = "Bastón";
L["fist"] = "Arma de puño";
L["polearm"] = "Arma de asta";
L["bow"] = "Arco";
L["gun"] = "Arma de fuego";
L["wand"] = "Varita";
L["crossbow"] = "Ballesta";
L["offhand"] = "Mano izquierda";
L["warglaives"] = "Guja de guerra";

L["ring"] = "Anillo";
L["amulet"] = "Amuleto";
L["cloak"] = "Capa";
L["trinket"] = "Abalorio";

-------------------------------------------------------------------------------
---------------------------------- TOOLTIPS -----------------------------------
-------------------------------------------------------------------------------

L["retrieving"] = "Recuperando el enlace al objeto...";
L["in_cave"] = "En una cueva.";
L["weekly"] = "Semanal";
L["normal"] = "Normal";
L["hard"] = "Difícil";
L["mount"] = "Montura";
L["pet"] = "Mascota";
L["toy"] = "Juguete";
L["completed"] = "Completedo"
L["incomplete"] = "Incompleto"
L["known"] = "Aprendido"
L["missing"] = "No aprendido"
L["unobtainable"] = "Imposible de obtener"
L["unlearnable"] = "No utilizable"

-------------------------------------------------------------------------------
--------------------------------- CONTEXT MENU --------------------------------
-------------------------------------------------------------------------------

L["context_menu_title"] = "HandyNotes Invasión de la Plaga de Shadowlands";
L["context_menu_add_tomtom"] = "Añadir a TomTom";
L["context_menu_hide_node"] = "Esconder este nodo";
L["context_menu_restore_hidden_nodes"] = "Restaurar todos los nodos escondidos";
L["Icecrown"] = "Corona de Hielo";

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

L["options_title"] = "Invasión de la Plaga de Shadowlands";

------------------------------------ ICONS ------------------------------------

L["options_icon_settings"] = "Opciones de iconos";
L["options_icons_treasures"] = "Iconos de tesoros";
L["options_icons_rares"] = "Iconos de enemigos poco comunes";
L["options_icons_caves"] = "Iconos de cuevas";
L["options_icons_pet_battles"] = "Iconos de mascotas de duelo";
L["options_icons_other"] = "Otros iconos";
L["options_scale"] = "Escala";
L["options_scale_desc"] = "1 = 100%";
L["options_opacity"] = "Opacidad";
L["options_opacity_desc"] = "0 = transparente, 1 = opaco";

---------------------------------- VISIBILITY ---------------------------------

L["options_visibility_settings"] = "Visibilidad";
L["options_general_settings"] = "General";
L["options_toggle_looted_rares"] = "Mostrar siempre todos los enemigos poco comunes";
L["options_toggle_looted_rares_desc"] = "Mostrar todos los enemigos poco comunes independientemente de si ya han sido despojados.";
L["options_toggle_looted_treasures"] = "Mostrar siempre los tesoros conseguidos";
L["options_toggle_looted_treasures_desc"] = "Mostrar todos los tesoros independientemente de si ya han sido despojados.";
L["options_toggle_hide_done_rare"] = "Ocultar enemigo poco común, si todo su botín ha sido aprendido";
L["options_toggle_hide_done_rare_desc"] = "Oculta todos los enemigos poco comunes para los cuales todo su botín ha sido aprendido.";
L["options_toggle_hide_minimap"] = "Ocultar todos los iconos en el minimapa";
L["options_toggle_hide_minimap_desc"] = "Oculta todos los iconos de este AddOn en el minimapa y los muestra solamente en el mapa principal.";

L["options_toggle_battle_pets_desc"] = "Mostrar ubicaciones de intructores de mascotas de duelo.";
L["options_toggle_battle_pets"] = "Mascotas de duelo";
L["options_toggle_caves_desc"] = "Mostrar entradas de cuevas para otros nodos.";
L["options_toggle_caves"] = "Cuevas";
L["options_toggle_misc"] = "Miscelánea";
L["options_toggle_npcs"] = "PNJ";
L["options_toggle_rares_desc"] = "Mostrar ubicaciónes de enemigos poco comunes.";
L["options_toggle_rares"] = "Enemigos poco comunes";
L["options_toggle_supplies_desc"] = "Mostrar todas las posibles ubicaciones para los cajones de suministros de guerra.";
L["options_toggle_supplies"] = "Envíos de suministros aéreos";
L["options_toggle_treasures"] = "Tesoros";

---------------------------------- TOOLTIP ---------------------------------

L["options_tooltip_settings"] = "Descripción emergente";
L["options_tooltip_settings_desc"] = "Descripción emergente.";
L["options_toggle_show_loot"] = "Mostrar botín";
L["options_toggle_show_loot_desc"] = "Mostrar información del botín en la descripción emergente.";
L["options_toggle_show_notes"] = "Mostrar notas";
L["options_toggle_show_notes_desc"] = "Añadir notas de ayuda en la descripción emergente cuando esten disponibles.";

--------------------------------- DEVELOPMENT ---------------------------------

L["options_dev_settings"] = "Desarrollo";
L["options_dev_settings_desc"] = "Opciones de desarrollo.";
L["options_toggle_show_debug"] = "Depuración";
L["options_toggle_show_debug_desc"] = "Mostrar depuración.";
L["options_toggle_ignore_quests"] = "Ignorar misiones";
L["options_toggle_ignore_quests_desc"] = "Ignorar estado de las misiones de los nodos.";
L["options_toggle_force_nodes"] = "Forzar nodos";
L["options_toggle_force_nodes_desc"] = "Forzar visualizaciónn de todos los nodos.";

