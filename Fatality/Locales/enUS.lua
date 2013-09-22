-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
Fatality_Locales = {}

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "Thank you for updating to the latest version!"
L.welcome2 = "In future, to access this menu and configure each character's settings, type either |cffff9900/fatality|r or |cffff9900/fat|r."
L.welcome3 = "|cffff0000[Note]|r This message will be displayed once per character."

-- Addon
L.addon_enabled = "|cff00ff00On|r"
L.addon_disabled = "|cffff0000Off|r"

-- Damage
L.damage_overkill = "O: %s"
L.damage_resist = "R: %s"
L.damage_absorb = "A: %s"
L.damage_block = "B: %s"
L.damage_critical = TEXT_MODE_A_STRING_RESULT_CRITICAL
L.damage_melee = MELEE
L.unknown = TIME_UNKNOWN

-- Error Messages
L.error_report = "(%s) Report cannot be sent because it exceeds the maximum character limit of 255. To fix this, type |cffff9900/fatality|r and adjust your settings accordingly. Alternatively, you can set |cfffdcf00set 'Output' to Self|r."
L.error_options = "|cffFF9933Fatality_Options|r could not be loaded."

-- Configuration: Title
L.config_promoted = "Promote"
L.config_lfr = "LFR"
L.config_raid = "Raid"
L.config_party = "Party"
L.config_overkill = "Overkill"
L.config_resist = "Resists"
L.config_absorb = "Absorbs"
L.config_block = "Blocks"
L.config_icons = "Icons"
L.config_school = "Schools"
L.config_source = "Source"
L.config_short = "Shorten"
L.config_limit10 = "Report Limit (10 man)"
L.config_limit25 = "Report Limit (25 man)"
L.config_history = "Event History"
L.config_threshold = "Damage Threshold"
L.config_output_raid = "Output (Raid Instances)"
L.config_output_party = "Output (Party Instances)"

-- Configuration: Description
L.config_promoted_desc = "Only announce if promoted ["..RAID_LEADER.."/"..RAID_ASSISTANT.."]"
L.config_lfr_desc = "Enable inside Raid Finder"
L.config_raid_desc = "Enable inside Raid instances"
L.config_party_desc = "Enable inside Party instances"
L.config_overkill_desc = "Include overkill"
L.config_resist_desc = "Include resisted damage"
L.config_absorb_desc = "Include absorbed damage"
L.config_block_desc = "Include blocked damage"
L.config_icons_desc = "Include raid icons"
L.config_school_desc = "Include damage school"
L.config_source_desc = "Include who caused the damage"
L.config_short_desc = "Shorten numbers [9431 = 9.4k]"
L.config_limit_desc = "How many deaths should be reported per combat session?"
L.config_history_desc = "How many damage events should be reported per person?"
L.config_threshold_desc = "What should be the minimum amount of damage recorded?"
L.config_channel_default = "<Channel Name>"
L.config_whisper_default = "<Character Name>"

-- Report
L.death = "Fatality: %s > %s"