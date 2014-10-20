-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
if GetLocale() ~= "frFR" then return end

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "Merci de télécharger la dernière version!"
L.welcome2 = "A l'avenir, pour accéder à ce menu et configurer les préférences de chaque personnage, tapez |cffff9900/fatality|r ou |cffff9900/fat|r."
L.welcome3 = "|cffff0000[Note]|r Ce message sera affiché pour chaque personnage."

-- Addon
L.addon_enabled = "|cff00ff00Activé|r"
L.addon_disabled = "|cffff0000Désactivé|r"

-- Damage
L.damage_overkill = "E: %s"
L.damage_resist = "R: %s"
L.damage_absorb = "A: %s"
L.damage_block = "B: %s"

-- Error Messages
L.error_report = "(%s) Le rapport n'a pas pu être envoyé car il a dépassé la limite des 255 caractères. Pour corriger ceci, tapez |cffff9900/fatality|r et, soit vous diminuez l'option 'Historique des évènements,' soit sélectionnez 'Self' dans 'Sortie'"
L.error_options = "|cffFF9933Fatality_Options|r n'a pas pu être chargé."

-- Configuration: Title
L.config_promoted = "Promotion"
L.config_lfr = "RdR"
L.config_raid = "Raid"
L.config_party = "Groupe"
L.config_overkill = "Excès"
L.config_resist = "Résistances"
L.config_absorb = "Absorptions"
L.config_block = "Blocages"
L.config_icons = "Icônes"
L.config_school = "Ecoles"
L.config_source = "Source"
L.config_short = "Abréger"
L.config_limit10 = "Reportées (10 personnes)"
L.config_limit25 = "Reportées (25 personnes)"
L.config_history = "Historique des évènements"
L.config_threshold = "Seuil de dégâts"
L.config_output_raid = "Sortie (Raids)"
L.config_output_party = "Sortie (Groupes)"

-- Configuration: Description
L.config_promoted_desc = "Seulement annoncer quand vous être promu ["..RAID_LEADER.."/"..RAID_ASSISTANT.."]"
L.config_lfr_desc = "Activer en Recherche de Raid"
L.config_raid_desc = "Activer en raid"
L.config_party_desc = "Activer en groupe"
L.config_overkill_desc = "Inclure excès"
L.config_resist_desc = "Inclure les dommages résistés"
L.config_absorb_desc = "Inclure les dommages absorbés"
L.config_block_desc = "Inclure les dommages bloqués"
L.config_icons_desc = "Inclure les icônes de raid"
L.config_school_desc = "Inclure les écoles de dommage"
L.config_source_desc = "Indiquer qui a causé le dommage"
L.config_short_desc = "Abréger les nombres [9431 = 9.4k]"
L.config_limit_desc = "Nombre de morts reportées par combat?"
L.config_history_desc = "Nombre de causes de dégâts affichées par personne?"
L.config_threshold_desc = "Montant minimum de dégâts enregistré?"
L.config_channel_default = "<Nom du canal>"
L.config_whisper_default = "<Nom du personnage>"