local _, ns = ...

if ns:IsSameLocale("frFR") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "frFR"

L["ALLOW_IN_LFD"] = "Autoriser pour la recherche de donjon"
L["ALLOW_IN_LFD_DESC"] = "Ajoute une option pour copier l'url du profil Raider.IO dans le menu du bouton droit d'un groupe ou d'un candidat"
L["ALLOW_ON_PLAYER_UNITS"] = "Autoriser pour les cadres d'unité"
L["ALLOW_ON_PLAYER_UNITS_DESC"] = "Ajoute une option pour copier l'url du profil Raider.IO dans le menu bouton droit d'un cadre d'unité."
L["ALWAYS_SHOW_EXTENDED_INFO"] = "Toujours afficher les scores des rôles"
L["ALWAYS_SHOW_EXTENDED_INFO_DESC"] = "Garder une des touches (shift/ctrl/alt) permet d'afficher les scores des différents rôles du joueur. Si on active cette option, alors l'info-bulle possédera toujours les scores des rôles."
L["BEST_FOR_DUNGEON"] = "Meilleure clé pour le donjon"
L["BEST_RUN"] = "Meilleure clé"
L["CHANGES_REQUIRES_UI_RELOAD"] = [=[Vos changements ont été sauvegardé, mais il faut recharger l'interface pour qu'elles prennent effets.

Voulez-vous faire cela maintenant ?]=]
L["CHECKBOX_DISPLAY_WEEKLY"] = "Hebdomadaire"
L["COPY_RAIDERIO_PROFILE_URL"] = "Copier le profil Raider.IO"
L["COPY_RAIDERIO_URL"] = "Copier l'url Raider.IO"
L["DPS"] = "DPS"
L["DPS_SCORE"] = "Score en DPS"
L["DUNGEON_SHORT_NAME_ARC"] = "ARC"
L["DUNGEON_SHORT_NAME_BRH"] = "BRH"
L["DUNGEON_SHORT_NAME_COEN"] = "COEN"
L["DUNGEON_SHORT_NAME_COS"] = "COS"
L["DUNGEON_SHORT_NAME_DHT"] = "DHT"
L["DUNGEON_SHORT_NAME_EOA"] = "EOA"
L["DUNGEON_SHORT_NAME_HOV"] = "HOV"
L["DUNGEON_SHORT_NAME_LOWR"] = "LOWR"
L["DUNGEON_SHORT_NAME_MOS"] = "MOS"
L["DUNGEON_SHORT_NAME_NL"] = "NL"
L["DUNGEON_SHORT_NAME_SEAT"] = "SEAT"
L["DUNGEON_SHORT_NAME_UPPR"] = "UPPR"
L["DUNGEON_SHORT_NAME_VOTW"] = "VOTW"
--[[Translation missing --]]
--[[ L["ENABLE_AUTO_FRAME_POSITION"] = ""--]] 
--[[Translation missing --]]
--[[ L["ENABLE_AUTO_FRAME_POSITION_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["ENABLE_LOCK_PROFILE_FRAME"] = ""--]] 
--[[Translation missing --]]
--[[ L["ENABLE_LOCK_PROFILE_FRAME_DESC"] = ""--]] 
L["ENABLE_NO_SCORE_COLORS"] = "Désactiver les couleurs de score"
L["ENABLE_NO_SCORE_COLORS_DESC"] = "Tous les scores seront affichés en blanc."
--[[Translation missing --]]
--[[ L["ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS_DESC"] = ""--]] 
L["ENABLE_SIMPLE_SCORE_COLORS"] = "Utiliser les couleurs de rareté pour le score"
L["ENABLE_SIMPLE_SCORE_COLORS_DESC"] = "Utiliser les couleurs de raretés (rare, épique, etc ...) pour les scores. Cela peut aider pour distinguer les tiers de score."
L["GUILD_BEST_SEASON"] = "Guilde: Top Saison"
L["GUILD_BEST_WEEKLY"] = "Guilde : Top Semaine"
L["HEALER"] = "Heal"
L["HEALER_SCORE"] = "Score en heal"
L["INVERSE_PROFILE_MODIFIER"] = "Inverser le modificateur de l'info bulle"
L["INVERSE_PROFILE_MODIFIER_DESC"] = "Activer cette option va inverser le comportement de l'info-bulle lorsque l'on utilise les touches (shift/ctrl/alt)."
L["KEYSTONE_COMPLETED_10"] = "+10-14 (CM)"
L["KEYSTONE_COMPLETED_15"] = "+15 (MM)"
--[[Translation missing --]]
--[[ L["LOCKING_PROFILE_FRAME"] = ""--]] 
L["MAINS_SCORE"] = "Score du personnage principal"
L["MAINS_SCORE_COLON"] = "Score du personnage principal :"
L["MODULE_AMERICAS"] = "Amérique"
L["MODULE_EUROPE"] = "Europe"
L["MODULE_KOREA"] = "Corée"
L["MODULE_TAIWAN"] = "Taïwan"
L["MY_PROFILE_TITLE"] = "Mon Profil Mythic+"
L["MYTHIC_PLUS_DB_MODULES"] = "Module Données Mythique+"
L["MYTHIC_PLUS_SCORES"] = "Scores Mythique+ "
L["NO_GUILD_RECORD"] = "Aucun donjon de guilde"
L["OPEN_CONFIG"] = "Ouvrir la configuration"
L["OUT_OF_SYNC_DATABASE_S"] = "|cffFFFFFF%s|r a des données de dates différentes entre les factions. Pour résoudre ça, merci de mettre à jour vos paramètres sur le client RaiderIO pour mettre à jour les deux factions."
L["OUTDATED_DATABASE"] = "Dernière mise à jour des scores il y a %d jours"
L["OUTDATED_DATABASE_HOURS"] = "Dernière mise à jour des scores il y a %d heures"
L["OUTDATED_DATABASE_S"] = "|cffFFFFFF%s|r utilise de la data qui est vieux de |cffFF6666%d|r jours. Merci de mettre à jour l'addon pour avoir des scores plus justes."
L["PLAYER_PROFILE_TITLE"] = "Profil Mythic+ du joueur"
L["PREV_SEASON_SUFFIX"] = "(*)"
L["PROFILE_BEST_RUNS"] = "Meilleurs Donjons"
L["RAIDERIO_AVERAGE_PLAYER_SCORE"] = "Moy. de score Raider.IO sur des +%s"
L["RAIDERIO_CLIENT_CUSTOMIZATION"] = "Modification avec le Client RaiderIO"
L["RAIDERIO_MP_BASE_SCORE"] = "Score MM+ Raider.IO de base "
L["RAIDERIO_MP_SCORE"] = "Score Raider.IO M+"
L["RAIDERIO_MP_SCORE_COLON"] = "Score Raider.IO M+ :"
L["RAIDERIO_MYTHIC_OPTIONS"] = "Options de l'addon Raider.IO"
L["RELOAD_LATER"] = "Je rechargerai l'interface plus tard"
L["RELOAD_NOW"] = "Recharger l'interface maintenant"
L["SHOW_AVERAGE_PLAYER_SCORE_INFO"] = "Afficher le score moyen des joueurs pour une clé dans les temps"
L["SHOW_AVERAGE_PLAYER_SCORE_INFO_DESC"] = "Afficher la moyenne des scores Raider.IO des joueurs ayant fini une clé dans les temps. Cela est visible sur l'infobulle de la clé ainsi que des joueurs dans la recherche de groupe."
--[[Translation missing --]]
--[[ L["SHOW_CLIENT_GUILD_BEST"] = ""--]] 
--[[Translation missing --]]
--[[ L["SHOW_CLIENT_GUILD_BEST_DESC"] = ""--]] 
L["SHOW_IN_FRIENDS"] = "Afficher dans la liste d'amis"
L["SHOW_IN_FRIENDS_DESC"] = "Afficher le score Mythique+ lorsqu'on survole un ami."
L["SHOW_IN_LFD"] = "Afficher dans la recherche de donjons"
L["SHOW_IN_LFD_DESC"] = "Afficher le score Mythique+ lorsqu'on survole un groupe ou un candidat."
L["SHOW_IN_SLASH_WHO_RESULTS"] = "Afficher dans les résultats du /qui"
L["SHOW_IN_SLASH_WHO_RESULTS_DESC"] = "Afficher le score Mythique+ lorsque l'on /qui quelqu'un de spécifique."
L["SHOW_IN_WHO_UI"] = "Afficher dans la fenêtre \"Qui\""
L["SHOW_IN_WHO_UI_DESC"] = "Afficher le score Mythique+ lorsqu'on survole les résultats de la fenêtre \"Qui\"."
L["SHOW_KEYSTONE_INFO"] = "Affiche les informations de la clé"
L["SHOW_KEYSTONE_INFO_DESC"] = "Ajoute des informations sur l'info-bulle de la clé. Propose un score Mythique+ pour le groupe."
L["SHOW_LEADER_PROFILE"] = "Activer l'utilisation des touches (shift/ctrl/alt)"
L["SHOW_LEADER_PROFILE_DESC"] = "Utiliser un des touches (shift/ctrl/alt), permet de changer entre la vue de son profil et celui du chef de groupe."
L["SHOW_MAINS_SCORE"] = "Afficher le score du personnage principal"
L["SHOW_MAINS_SCORE_DESC"] = "Afficher le score du personnage principal du joueur pour la saison actuelle. Ces joueurs doivent avoir un compte sur Raider.IO où il a définit un personnage comme son personnage principal."
L["SHOW_ON_GUILD_ROSTER"] = "Afficher dans l'onglet guilde"
L["SHOW_ON_GUILD_ROSTER_DESC"] = "Afficher le score Mythique+ lorsqu'on survole un joueur dans la liste des membres de la guilde."
L["SHOW_ON_PLAYER_UNITS"] = "Afficher sur les cadres d'unité"
L["SHOW_ON_PLAYER_UNITS_DESC"] = "Afficher le score Mythique+ lorsqu'on survole le cadre d'un joueur. "
L["SHOW_RAIDERIO_PROFILE"] = "Afficher le Profil Raider.IO dans la recherche de donjon"
L["SHOW_RAIDERIO_PROFILE_DESC"] = "Afficher le Profil Raider.IO en Info-Bulle dans la recherche de donjon"
L["SHOW_SCORE_IN_COMBAT"] = "Afficher le score en combat"
L["SHOW_SCORE_IN_COMBAT_DESC"] = "Le désactiver pour diminuer l'impact sur les performances lorsque l'on survole un joueur en combat."
L["TANK"] = "Tank"
L["TANK_SCORE"] = "Score en tank"
L["TIMED_10_RUNS"] = "10-14+ dans les temps"
L["TIMED_15_RUNS"] = "15+ dans les temps"
L["TOOLTIP_CUSTOMIZATION"] = "Modification de l'info-bulle"
L["TOOLTIP_PROFILE"] = "Modification du Profil"
L["UNKNOWN_SCORE"] = "Inconnu"
L["UNKNOWN_SERVER_FOUND"] = "|cffFFFFFF%s|r a rencontré une erreur. S'il vous plait, écrivez ces informations |cffFF9999{|r |cffFFFFFF%s|r |cffFF9999,|r |cffFFFFFF%s|r |cffFF9999}|r et reporter le aux développers. Merci !"
--[[Translation missing --]]
--[[ L["UNLOCKING_PROFILE_FRAME"] = ""--]] 
--[[Translation missing --]]
--[[ L["WARNING_LOCK_POSITION_FRAME_AUTO"] = ""--]] 


	ns.L = L
end
