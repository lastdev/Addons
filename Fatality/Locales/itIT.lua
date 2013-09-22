-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
if GetLocale() ~= "itIT" then return end

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "Grazie per aver aggiornato all'ultima versione!"
L.welcome2 = "In futuro, per accedere a questo menù e configurare ogni pg, scrivi |cffff9900/fatality|r o |cffff9900/fat|r."
L.welcome3 = "|cffff0000[Nota]|r Questo messaggio verrà visualizzato una volta per ogni PG."

-- Addon
L.addon_enabled = "|cff00ff00Attivo|r"
L.addon_disabled = "|cffff0000Disattivo|r"

-- Damage
L.damage_overkill = "O: %s"
L.damage_resist = "R: %s"
L.damage_absorb = "A: %s"
L.damage_block = "B: %s"

-- Error Messages
L.error_report = "(%s) Il rapporto non può essere inviato perchè è più lungo di 255 caratteri. Per risolvere, scrivi |cffff9900/fatality|r e modifica i settaggi. Altrimenti puoi settare |cfffdcf00Imposta 'Canale' su Individuale|r."
L.error_options = "|cffFF9933Fatality_Options|r non può essere caricato."

-- Configuration: Title
L.config_promoted = "Promosso"
L.config_lfr = "LFR"
L.config_raid = "Incursione"
L.config_party = "Gruppo"
L.config_overkill = "Overkill"
L.config_resist = "Resistito"
L.config_absorb = "Assorbito"
L.config_block = "Bloccato"
L.config_icons = "Icone"
L.config_school = "Scuole"
L.config_source = "Fonte"
L.config_short = "Più corto"
L.config_limit10 = "Limite del Rapporto (10 uomini)"
L.config_limit25 = "Limite del Rapporto (25 uomini)"
L.config_history = "Storia degli Eventi"
L.config_threshold = "Soglia di Danno"
L.config_output_raid = "Uscita (Incursioni)"
L.config_output_party = "Uscita (Gruppi)"

-- Configuration: Description
L.config_promoted_desc = "Annuncia solo se promosso ["..RAID_LEADER.."/"..RAID_ASSISTANT.."]"
L.config_lfr_desc = "Abilita nella Ricerca di Incurisioni"
L.config_raid_desc = "Abilita nelle Incursioni"
L.config_party_desc = "Abilita nelle istanze"
L.config_overkill_desc = "Includi OverKills"
L.config_resist_desc = "Includi Danno Resistito"
L.config_absorb_desc = "Includi Danno Assorbito"
L.config_block_desc = "Includi Danno Bloccato"
L.config_icons_desc = "Includi Icone di Incursione"
L.config_school_desc = "Includi Scuole di Danno"
L.config_source_desc = "Includi chi ha provocato il danno"
L.config_short_desc = "Numeri Condensati [9431 = 9.4k]"
L.config_limit_desc = "Quanti morti devono essere messi nel report per incontro?"
L.config_history_desc = "Quanti eventi devono essere messi nel report per persona?"
L.config_threshold_desc = "Qual'è il danno minimo registrato per persona?"
L.config_channel_default = "<Nome del Canale>"
L.config_whisper_default = "<Nome del personaggio>"