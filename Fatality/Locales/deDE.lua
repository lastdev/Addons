-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
if GetLocale() ~= "deDE" then return end

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "Danke, dass du auf die neuste Version aktualisiert hast."
L.welcome2 = "In Zukunft kannst du |cffff9900/fatality|r oder |cffff9900/fat|r benutzen, um dieses Menü und die Charakter-Einstellungen zu erreichen."
L.welcome3 = "|cffff0000[Hinweis]|r Diese Nachricht wird einmal pro Charakter angezeigt."

-- Addon
L.addon_enabled = "|cff00ff00An|r"
L.addon_disabled = "|cffff0000Aus|r"

-- Damage
L.damage_overkill = "Ü: %s"
L.damage_resist = "W: %s"
L.damage_absorb = "A: %s"
L.damage_block = "B: %s"

-- Error Messages
L.error_report = "(%s) Der Bericht konnte nicht ausgegeben werden, da er mehr als 255 Zeichen lang ist. Um dies zu beheben, gebe |cffff9900/fatality|r ein und verringere den 'Ereignis-Verlauf' oder setze die 'Ausgabe' auf Self."
L.error_options = "|cffFF9933Fatality_Options|r konnten nicht geladen werden."

-- Configuration: Title
L.config_promoted = "Promote"
L.config_lfr = "LFR"
L.config_raid = "Schlachtzug"
L.config_party = "Gruppe"
L.config_overkill = "Überschaden"
L.config_resist = "Widerstanden"
L.config_absorb = "Absorbieren"
L.config_block = "Blocken"
L.config_icons = "Symbole"
L.config_school = "Magieart"
L.config_source = "Quelle"
L.config_short = "Abkürzen"
L.config_limit10 = "Anzeige-Limit (10er)"
L.config_limit25 = "Anzeige-Limit (25er)"
L.config_history = "Ereignis-Verlauf"
L.config_threshold = "Schadens-Grenzwert"
L.config_output_raid = "Ausgabe (Schlachtzügen)"
L.config_output_party = "Ausgabe (Gruppeninstanzen)"

-- Configuration: Description
L.config_promoted_desc = "Nur ansagen, wenn befördert ["..RAID_LEADER.."/"..RAID_ASSISTANT.."]"
L.config_lfr_desc = "Im Schlachtzugsbrowser aktivieren"
L.config_raid_desc = "Im Schlachtzügen aktivieren"
L.config_party_desc = "In Gruppeninstanzen aktivieren"
L.config_overkill_desc = "Überschaden einbeziehen"
L.config_resist_desc = "Widerstandenen Schaden einbeziehen"
L.config_absorb_desc = "Widerstandenen Schaden einbeziehen"
L.config_block_desc = "Geblockten Schaden einbeziehen"
L.config_icons_desc = "Raid-Symbole anzeigen"
L.config_school_desc = "Magieart anzeigen"
L.config_source_desc = "Schadensquelle/-verursacher einbeziehen"
L.config_short_desc = "Zahlen abkürzen [9431 = 9.4k]"
L.config_limit_desc = "Wie viele Tode sollen während eines einzelnen Kampfes gemeldet werden?"
L.config_history_desc = "Wie viele Schadens-Ereignisse sollen pro Person gemeldet werden?"
L.config_threshold_desc = "Was soll das Minimum an Schaden sein, der angezeigt wird?"
L.config_channel_default = "<Channel Name>"
L.config_whisper_default = "<Charakter-Name>"