local L = LibStub("AceLocale-3.0"):NewLocale("AskMrRobot", "frFR", false)

if L then


--[[----------------------------------------------------------------------
General
------------------------------------------------------------------------]]

L.SpecsShort = {
	[1] = "Blood", -- DeathKnightBlood
    [2] = "Frost", -- DeathKnightFrost
    [3] = "Unholy", -- DeathKnightUnholy
	[4] = "Havoc", -- DemonHunterHavoc
	[5] = "Vengeance", -- DemonHunterVengeance
    [6] = "Moon", -- DruidBalance
    [7] = "Feral", -- DruidFeral
    [8] = "Bear", -- DruidGuardian
    [9] = "Resto", -- DruidRestoration
    [10] = "Devastate", -- EvokerDevastation
    [11] = "Preserve", -- EvokerPreservation
    [12] = "Augment", -- EvokerAugmentation
    [13] = "BM", -- HunterBeastMastery
    [14] = "Marks", -- HunterMarksmanship
    [15] = "Survival", -- HunterSurvival
    [16] = "Arcane", -- MageArcane
    [17] = "Fire", -- MageFire
    [18] = "Frost", -- MageFrost
    [19] = "Brew", -- MonkBrewmaster
    [20] = "Mist", -- MonkMistweaver
    [21] = "Wind", -- MonkWindwalker
    [22] = "Holy", -- PaladinHoly
    [23] = "Prot", -- PaladinProtection
    [24] = "Ret", -- PaladinRetribution
    [25] = "Disc", -- PriestDiscipline
    [26] = "Holy", -- PriestHoly
    [27] = "Shadow", -- PriestShadow
    [28] = "Assn", -- RogueAssassination
    [29] = "Outlaw", -- RogueOutlaw
    [30] = "Sub", -- RogueSubtlety
    [31] = "Elem", -- ShamanElemental
    [32] = "Enh", -- ShamanEnhancement
    [33] = "Resto", -- ShamanRestoration
    [34] = "Aff", -- WarlockAffliction
    [35] = "Demo", -- WarlockDemonology
    [36] = "Destro", -- WarlockDestruction
    [37] = "Arms", -- WarriorArms
    [38] = "Fury", -- WarriorFury
    [39] = "Prot", -- WarriorProtection
}

-- stat strings for e.g. displaying gem/enchant abbreviations, make as short as possible without being confusing/ambiguous
L.StatsShort = {
    ["Strength"] = "Str",
    ["Agility"] = "Agi",
    ["Intellect"] = "Int",
    ["CriticalStrike"] = "Crit",
    ["Haste"] = "Hâte",
    ["Mastery"] = "Maitrise",
    ["Multistrike"] = "FM",
    ["Versatility"] = "Poly",
    ["BonusArmor"] = "Armure",
    ["Spirit"] = "Esprit",
    ["Dodge"] = "Esquive",
    ["Parry"] = "Parade",
    ["MovementSpeed"] = "Vitesse",
    ["Avoidance"] = "Evitement",
    ["Stamina"] = "Endu",
    ["Armor"] = "Armure",
    ["AttackPower"] = "PA",
    ["SpellPower"] = "PS",
    ["PvpResilience"] = "JcJ Res",
    ["PvpPower"] = "JcJ Power",
}

L.InstanceNames = {
    [1861] = "Uldir",
    [2070] = "Dazar'alor",
    [2096] = "Crucible of Storms",
    [2164] = "The Eternal Palace",
    [2217] = "Ny'alotha",    
    [2296] = "Castle Nathria",
    [2450] = "Sanctum of Domination",
    [2481] = "Sepulcher of the First Ones",
    [2522] = "Vault of the Incarnates",
    [2569] = "Aberrus, the Shadowed Crucible",
    [2549] = "Amirdrassil, the Dream's Hope",
    [2657] = "Nerub-ar Palace",
    [2769] = "Liberation of Undermine"
}

L.DifficultyNames = {
	[17] = "LFR",
	[14] = "Normal",
	[15] = "Héroïque",
	[16] = "Mythique"
}

L.WeaponTypes = {
	None     = "Aucun",
	Axe      = "Hache",
	Mace     = "Masse",
	Sword    = "Epée",
	Fist     = "Arme de pugilat",
	Dagger   = "Dague",
	Staff    = "Bâton",
	Polearm  = "Arme d'hast",
	OffHand  = "Main Gauche",
	Shield   = "Bouclier",
	Wand     = "Baguette",
	Bow      = "Arc",
	Gun      = "Arme à feu",
	Crossbow = "Arbalète"
}

L.ArmorTypes = {
	None    = "Aucun",
	Plate   = "Plaques",
	Mail    = "Mailles",
	Leather = "Cuit",
	Cloth   = "Tissu"
}

L.OneHand = "Une Main"
L.TwoHand = "Deux Mains"
L.OffHand = "Main Gauche"


--[[----------------------------------------------------------------------
Main UI
------------------------------------------------------------------------]]
L.AlertOk = "OK"
L.CoverCancel = "annuler"

L.MinimapTooltip = 
[[Clic gauche pour ouvrir la fenêtre Ask Mr. Robot.

Clic droit pour changer de spé et equipper le stuff sauvegardé pour cette spé.]]

L.MainStatusText = function(version, url)
	return version .. " chargée. Documentation disponible à " .. url
end

L.TabExportText = "Exporter"
L.TabGearText = "Stuff"
L.TabLogText = "Combat Logs"
L.TabOptionsText = "Options"

L.VersionChatTitle = "Version Add-on AMR:"
L.VersionChatNotInstalled = "PAS INSTALLE"
L.VersionChatNotGrouped = "Tu n'es pas dans un groupe ou un raid !"


--[[----------------------------------------------------------------------
Export Tab
------------------------------------------------------------------------]]
L.ExportTitle = "Instructions pour exporter"
L.ExportHelp1 = "1. Copie le texte ci-dessous en appuyant Ctrl+C (ou Cmd+C sur un Mac)"
L.ExportHelp2 = "2. Va sur https://www.askmrrobot.com et charge ton perso"
L.ExportHelp3 = "3. Paste into the textbox under the AMR ADDON section" -- TODO

L.ExportSplashTitle = "Comment Démarrer"
L.ExportSplashSubtitle = "S'il s'agit de ta première utilisation de cette nouvelle version de l'add-on, procède comme suit pour initialiser la base de données d'items :"
L.ExportSplash1 = "1. Active chacune de tes spés une fois et pour chaque spé, équippe le stuff approprié"
L.ExportSplash2 = "2. Ouvre la fenêtre de ta banque et laisse la ouverte pendant au moins deux secondes"
L.ExportSplashClose = "Continuer"


--[[----------------------------------------------------------------------
Gear Tab
------------------------------------------------------------------------]]
L.GearImportNote = "Clique Importer pour coller des données du site."
L.GearBlank = "Tu n'as pas encore chargé de stuff pour cette spé."
L.GearBlank2 = "Va sur askmrrobot.com pour optimiser ton stuff. Ensuite, utilise le bouton Importer sur la gauche."
L.GearButtonEquip = function(spec)
	return string.format("Activer la spé %s et équipper le stuff", spec)
end
L.GearButtonJunk = "Voir Junk List"
L.GearButtonShop = "Voir Shopping List"

L.GearEquipErrorCombat = "Impossible de changer de spé/stuff pendant un combat !"
L.GearEquipErrorEmpty = "Pas de stuff sauvegardé pour la spé active."
L.GearEquipErrorNotFound = "Un item de ton stuff sauvegardé pour la spee n'a pas pu être équippé."
L.GearEquipErrorNotFound2 = "Essaie d'ouvrir la fenêtre de la banque et de lancer cette commande de nouveau."
L.GearEquipErrorBagFull = "Pas assez de place dans tes sacs pour équipper ton stuff sauvegardé."
L.GearEquipErrorSoulbound = function(itemLink)
	return itemLink .. " n'a pas pu être équippé car il n'est pas lié quand ramassé."
end

L.GearButtonImportText = "Importer"
L.GearButtonCleanText = "Nettoyer les Sacs"

L.GearTipTitle = "Infobulle !"
L.GearTipText = 
[[Dans les options, tu peux activer l'équippement automatique de ton stuff quand tu changes de spé.

Ou, tu peux faire un clic droit sur l'icône de la minimap pour changer de spé et equipper ton stuff.

OU! Tu peux utiliser des commandes /:]]

L.GearTipCommands = 
[[/amr equip [1-4]
pas d'argument = cycle]]
-- note to translators: the slash commands are literal and should stay as english

L.GearTalentError1 = "Unable to load your AMR setup talents at this time."


--[[----------------------------------------------------------------------
Import Dialog on Gear Tab
------------------------------------------------------------------------]]
L.ImportHeader = "Appuie sur Ctrl+V (ou Cmd+V sur un Mac) pour coller les données du site dans la zone de texte ci-dessous."
L.ImportButtonOk = "Importer"
L.ImportButtonCancel = "Annuler"

L.ImportErrorEmpty = "La zone de texte est vide."
L.ImportErrorFormat = "Les données ne sont pas dans le bon format."
L.ImportErrorVersion = "Les données ont été générées pour une version antérieure de l'add-on. Rends-toi sur le site pour générer des données à jour."
L.ImportErrorChar = function(importChar, yourChar)
	return "Les données sont pour " .. importChar .. ", mais tu as " .. yourChar .. "!"
end
L.ImportErrorRace = "On dirait que tu as changé de race. Rends-toi sur le site pour ré-optimiser."
L.ImportErrorFaction = "On dirait que tu as changé de faction. Rends-toi sur le site pour ré-optimiser."
L.ImportErrorLevel = "On dirait que tu as changé de niveau. Rends-toi sur le site pour ré-optimiser."

L.ImportOverwolfWait = "Performing Best in Bags optimization.  Please do not press Escape or close the addon until it has completed!"


--[[----------------------------------------------------------------------
Junk List
------------------------------------------------------------------------]]
L.JunkTitle = "Junk List"
L.JunkEmpty = "You have no junk items"
L.JunkScrap = "Click an item to add to the scrapper"
L.JunkVendor = "Click an item to sell"
L.JunkDisenchant = "Click an item to disenchant"
L.JunkBankText = function(count)
	return count .. " junk items are not in your bags"
end
L.JunkMissingText = function(count)
    return "Warning! " .. count .. " junk items could not be found"
end
L.JunkButtonBank = "Retrieve from Bank"
L.JunkOutOfSync = "An item in your junk list could not be found. Try opening your bank for a few seconds, then export to the website, then import again."
L.JunkItemNotFound = "That item could not be found in your bags. Try closing and opening the Junk List to refresh it."


--[[----------------------------------------------------------------------
Shopping List
------------------------------------------------------------------------]]
L.ShopTitle = "Shopping List"
L.ShopEmpty = "Il n'existe pas de données de shopping list pour ce perso."
L.ShopSpecLabel = "Spé"
L.ShopHeaderGems = "Gemmes"
L.ShopHeaderEnchants  = "Enchantements"
L.ShopHeaderMaterials = "Matériaux d'Enchantement"


--[[----------------------------------------------------------------------
Combat Log Tab
------------------------------------------------------------------------]]
L.LogChatStart = "Le log des données de combat a commencé et Mr. Robot enregistre les données de ton raid."
L.LogChatStop = "Le log des données de combat est maintenant arrêté."

L.LogChatWipe = function(wipeTime)
	return "Wipe manuel demandé à " .. wipeTime .. "."
end
L.LogChatUndoWipe = function(wipeTime)
	return "Wipe manuel à " .. wipeTime .. " a été effacé."
end
L.LogChatNoWipes = "Il n'y a pas de wipe manuel récent à effacer."

L.LogButtonStartText = "Commencer le log"
L.LogButtonStopText = "Arrêter le log"
L.LogButtonReloadText = "Recharger l'interface utilisateur"
L.LogButtonWipeText = "Wipe !"
L.LogButtonUndoWipeText = "Annuler Wipe"

L.LogNote = "Tu enregistres maintenant les logs des données de combat et de stuff."
L.LogReloadNote = "Avant d'uploader un fichier de log, il faut soit quitter WoW soit recharger l'interface utilisateur."
L.LogWipeNote = "La personne qui uploade les logs doit être celle qui utilise la commande de wipe."
L.LogWipeNote2 = function(cmd)
	return "'" .. cmd .. "' vont aussi faire ça."
end
L.LogUndoWipeNote = "Dernier wipe demandé:"
L.LogUndoWipeDate = function(day, timeOfDay)
	return day .. " à " .. timeOfDay
end

L.LogAutoTitle = "Auto-Logging"
L.LogAutoAllText = "Afficher/Cacher"

L.LogInstructionsTitle = "Instructions !"
L.LogInstructions = 
[[1.) Clique ``Commencer le log'' ou active Auto-Logging pour les instances désirées.

2.) Quand tu es prêt à uploader, quitte World of Warcraft* ou recharge l'interface utilisateur.**

3.) Lance le client AMR et upload tes logs.


*Il n'est pas nécessaire de quitter WoW, mais c'est recommandé. Cela permet au client AMR d'éviter que ton fichier de log devienne trop gros.

**L'add-on AMR collecte des données additionnelles au début de chaque combat pour tous les joueurs du raid. Les autres joueurs n'ont pas besoin d'activer les logs de combats ! Ils ont simplement besoin d'avoir l'add-on installé. Les données sont sauvegardées seulement lorsque tu quittes WoW ou que tu recharges l'interface utilisateur avant d'uploader.
]]


--[[----------------------------------------------------------------------
Options Tab
------------------------------------------------------------------------]]
L.OptionsHeaderGeneral = "Options Générales"

L.OptionsHideMinimapName = "Cacher icône minimap"
L.OptionsHideMinimapDesc = "L'icône de minimap est là pour te simplifier la vie, mais sache que toutes les actions peuvent lancées par des commandes / ou depuis l'interface utilisateur."

L.OptionsAutoGearName = "Equippe le stuff automatiquement lors d'un changement de spé"
L.OptionsAutoGearDesc = "Quand tu changes de spé (via l'interface utilisateur, un autre add-on, etc.) le stuff importé depuis AMR (onglet Gear) pour cette spé est automatiquement équippé."

L.OptionsJunkVendorName = "Automatically show junk list at vendors and scrapper"
L.OptionsJunkVendorDesc = "Whenever you open the scrapper or a vendor, automatically show the junk list window if your list is not empty."

L.OptionsShopAhName = "Voir la shopping list automatiquement à l'hôtel des ventes"
L.OptionsShopAhDesc = "Quand tu ouvres l'hôtel des ventes, la fenêtre de la shopping list s'ouvre automatiquement. Tu peux cliquer sur un item dans la shopping list pour le chercher automatiquement dans l'hôtel des ventes."

L.OptionsDisableEmName = "Disable creating Equipment Manager sets"
L.OptionsDisableEmDesc = "A Blizzard Equipment Manager set is created whenever you equip an AMR gear set, useful for marking items in your optimized sets. Check to disable this behavior if desired."

L.OptionsDisableTalName = "Do not change talents when changing gear sets"
L.OptionsDisableTalDesc = "A setup sent to the addon contains the selected talents and gear for that setup. Check this if you don't want the addon to automatically choose those talents when swapping gear."

-- TODO
L.OptionsUiScaleName = "Ask Mr. Robot UI scale"
L.OptionsUiScaleDesc = "Enter a value between 0.5 and 1.5 to change the scale of the Ask Mr. Robot user interface, press Enter, then close/open the window for it take effect. If the positioning gets messed up, use the /amr reset command."

end
