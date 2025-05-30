local ns = select(2, ...) ---@class ns @The addon namespace.

local L = ns:NewLocale() ---@class Locale
ns.L = L

L.LOCALE_NAME = "enUS"

L.UNKNOWN_SERVER_FOUND = "|cffFFFFFF%s|r has encountered a new server. Please write down this information |cffFF9999{|r |cffFFFFFF%s|r |cffFF9999,|r |cffFFFFFF%s|r |cffFF9999}|r and report it to the developers. Thank you!"
L.OUTDATED_EXPIRED_ALERT = "|cffFFFFFF%s|r is using expired data. Please update now to see the most accurate data: |cffFFFFFF%s|r"
L.OUTDATED_EXPIRED_TITLE = "Raider.IO Data Has Expired"
L.OUTDATED_EXPIRES_IN_DAYS = "Raider.IO Data Expires In %d Days"
L.OUTDATED_EXPIRES_IN_HOURS = "Raider.IO Data Expires In %d Hours"
L.OUTDATED_EXPIRES_IN_MINUTES = "Raider.IO Data Expires In %d Minutes"
L.OUTDATED_DOWNLOAD_LINK = "Download: |cffFFBD0A%s|r"
L.OUTDATED_PROFILE_TOOLTIP_MESSAGE = "Please update your addon now to see the most accurate data.\n\nPlayers work hard to improve their progress, and displaying very old data is a disservice to them.\n\nYou can use the Raider.IO Client to keep your data in sync automatically."
L.PROVIDER_NOT_LOADED = "|cffFF0000Warning:|r |cffFFFFFF%s|r cannot find data for your current faction. Please check your |cffFFFFFF/raiderio|r settings and enable tooltip data for |cffFFFFFF%s|r."
L.OUTDATED_DATABASE = "Scores are %d Days Old"
L.OUTDATED_DATABASE_HOURS = "Scores are %d Hours Old"
L.OUT_OF_SYNC_DATABASE_S = "|cffFFFFFF%s|r has Horde/Alliance faction data that is not in sync. Please update your Raider.IO client settings to sync both factions."
L.CHANGES_REQUIRES_UI_RELOAD = "Your changes have been saved, but you must reload your interface for them to take effect.\r\n\r\nDo you wish to do that now?"
L.RELOAD_NOW = "Reload Now"
L.RELOAD_LATER = "I'll Reload Later"
L.RAIDERIO_MYTHIC_OPTIONS = "Raider.IO Addon Options"
L.MYTHIC_PLUS_SCORES = "Mythic+ Score Tooltips"
L.SHOW_ON_PLAYER_UNITS = "Show on Player Unit Tooltips"
L.SHOW_ON_PLAYER_UNITS_DESC = "Show progress when you mouseover player units."
L.SHOW_IN_LFD = "Show in Dungeon Finder Tooltips"
L.SHOW_IN_LFD_CLASSIC = "Show in Group Finder Tooltips"
L.SHOW_IN_LFD_DESC = "Show progress when you mouseover groups or applicants."
L.SHOW_IN_FRIENDS = "Show in Friends List Tooltips"
L.SHOW_IN_FRIENDS_DESC = "Show progress when you mouseover your friends."
L.SHOW_ON_GUILD_ROSTER = "Show on Guild and Community Roster Tooltips"
L.SHOW_ON_GUILD_ROSTER_DESC = "Show progress when you mouseover guild and community members in the roster."
L.SHOW_IN_WHO_UI = "Show in \"Who List\" Window Tooltips"
L.SHOW_IN_WHO_UI_DESC = "Show progress when you mouseover in the Who results dialog."
L.SHOW_IN_SLASH_WHO_RESULTS = "Show in \"/who\" Results"
L.SHOW_IN_SLASH_WHO_RESULTS_DESC = "Show Mythic+ Score when you \"/who\" someone specific."
L.GENERAL_TOOLTIP_OPTIONS = "General Tooltip Options"
L.SHOW_WARBAND_SCORE = "Show Warband M+ Score and Progress on Tooltips"
L.SHOW_WARBAND_SCORE_DESC = "Shows the player's Warband's Mythic+ score from the current season and raid progress on the tooltip. Players must have registered on Raider.IO and synced their BNET for Warband progress to work."
L.SHOW_MAINS_SCORE = "Show Main's M+ Score and Progress on Tooltips"
L.SHOW_MAINS_SCORE_DESC = "Shows the player's Main's Mythic+ score from the current season and raid progress on the tooltip. Players must have registered on Raider.IO and declared a character as their main."
L.SHOW_BEST_MAINS_SCORE = "Show Main's Mythic+ Score from Best Season"
L.SHOW_BEST_MAINS_SCORE_DESC = "Shows the player's Main's best season's Mythic+ score and raid progress on the tooltip. Players must have registered on Raider.IO and declared a character as their main."
L.ENABLE_SIMPLE_SCORE_COLORS = "Use Simple Mythic+ Score Colors"
L.ENABLE_SIMPLE_SCORE_COLORS_DESC = "Shows scores with standard item quality colors only. This can make it easier for those with color vision deficiencies to distinguish score tiers."
L.ENABLE_NO_SCORE_COLORS = "Disable All Mythic+ Score Colors"
L.ENABLE_NO_SCORE_COLORS_DESC = "Disables colorization of scores. All scores will be shown as white."
L.SHOW_CHESTS_AS_MEDALS = "Show Mythic+ Medal Icons"
L.SHOW_CHESTS_AS_MEDALS_DESC = "Shows keystone medals earned as icons instead of the plus (+) signs."
L.SHOW_SCORE_IN_COMBAT = "Show Raider.IO Tooltip Info in Combat"
L.SHOW_SCORE_IN_COMBAT_DESC = "Disable to minimize performance impact while hovering players during combat."
L.SHOW_SCORE_WITH_MODIFIER = "Show Raider.IO Tooltip Info with Modifier"
L.SHOW_SCORE_WITH_MODIFIER_DESC = "Disable showing data when hovering players unless a modifier key is held down."
L.SHOW_KEYSTONE_INFO = "Show Base Raider.IO Score for Keystones"
L.SHOW_KEYSTONE_INFO_DESC = "Adds base Raider.IO Score for Keystones on their tooltips. Also shows the dungeon's best tracked run for each player in your group."
L.SHOW_ROLE_ICONS = "Show Role Icons in Tooltips"
L.SHOW_ROLE_ICONS_DESC = "When enabled, the player's top roles in Mythic+ will show on their tooltips."
L.COPY_RAIDERIO_PROFILE_URL = "Copy Raider.IO URL"
L.SHOW_RAIDERIO_PROFILE_OPTION = "Show Raider.IO Profile"
L.ALLOW_ON_PLAYER_UNITS = "Allow on Player Unit Frames"
L.ALLOW_ON_PLAYER_UNITS_DESC = "Right-click player unit frames to copy Raider.IO Profile URL."
L.ALLOW_IN_LFD = "Allow in Dungeon Finder"
L.ALLOW_IN_LFD_CLASSIC = "Allow in Group Finder"
L.ALLOW_IN_LFD_DESC = "Right-click groups or applicants in Dungeon Finder to copy Raider.IO Profile URL."
L.ALLOW_IN_LFD_CLASSIC_DESC = "Right-click groups or applicants in Group Finder to copy Raider.IO Profile URL."
L.DB_MODULES_HEADER_MYTHIC_PLUS = "Mythic+"
L.DB_MODULES_HEADER_RAIDING = "Raiding"
L.DB_MODULES_HEADER_RECRUITMENT = "Recruitment"
L.DB_MODULES = "Database Modules"
L.MODULE_AMERICAS = "Americas"
L.MODULE_EUROPE = "Europe"
L.MODULE_KOREA = "Korea"
L.MODULE_TAIWAN = "Taiwan"
L.OPEN_CONFIG = "Open Config"
L.RAIDERIO_MP_SCORE = "Raider.IO M+ Score"
L.RAIDERIO_MP_BEST_SCORE = "Raider.IO M+ Score (%s)"
L.RAIDERIO_BEST_RUN = "Raider.IO M+ Best Run"
L.RAIDERIO_MP_BASE_SCORE = "Raider.IO M+ Base Score"
L.RECENT_RUNS_WITH_YOU = "Recent Runs With You"
L.CURRENT_SCORE = "Current M+ Score"
L.PREVIOUS_SCORE = "Previous M+ Score (%s)"
L.BEST_SCORE = "Best M+ Score (%s)"
L.MAINS_SCORE = "Main's M+ Score"
L.MAINS_BEST_SCORE_BEST_SEASON = "Main's Best M+ Score (%s)"
L.WARBAND_SCORE = "Warband M+ Score"
L.WARBAND_BEST_SCORE_BEST_SEASON = "Warband Best M+ Score (%s)"
L.COPY_RAIDERIO_URL = "Copy Raider.IO URL"
L.TANK = "Tank"
L.HEALER = "Healer"
L.DPS = "DPS"
L.BEST_RUN = "Best Run"
L.BEST_FOR_DUNGEON = "Best For Dungeon"
L.TIMED_RUNS_RANGE = "Timed +%d-%d Runs"
L.TIMED_RUNS_MINIMUM = "Timed %d+ Runs"
L.DUNGEON_SHORT_NAME_TOTT = "TOTT"
L.DUNGEON_SHORT_NAME_GB = "GB"
L.DUNGEON_SHORT_NAME_VP = "VP"
L.DUNGEON_SHORT_NAME_TJS = "TJS"
L.DUNGEON_SHORT_NAME_SBG = "SBG"
L.DUNGEON_SHORT_NAME_ID = "ID"
L.DUNGEON_SHORT_NAME_GD = "GD"
L.DUNGEON_SHORT_NAME_EB = "EB"
L.DUNGEON_SHORT_NAME_NL = "NL"
L.DUNGEON_SHORT_NAME_HOV = "HOV"
L.DUNGEON_SHORT_NAME_DHT = "DHT"
L.DUNGEON_SHORT_NAME_VOTW = "VOTW"
L.DUNGEON_SHORT_NAME_BRH = "BRH"
L.DUNGEON_SHORT_NAME_MOS = "MOS"
L.DUNGEON_SHORT_NAME_ARC = "ARC"
L.DUNGEON_SHORT_NAME_EOA = "EOA"
L.DUNGEON_SHORT_NAME_ML = "ML"
L.DUNGEON_SHORT_NAME_COS = "COS"
L.DUNGEON_SHORT_NAME_COEN = "COEN"
L.DUNGEON_SHORT_NAME_SEAT = "SEAT"
L.DUNGEON_SHORT_NAME_AD = "AD"
L.DUNGEON_SHORT_NAME_FH = "FH"
L.DUNGEON_SHORT_NAME_TD = "TD"
L.DUNGEON_SHORT_NAME_SIEGE = "SIEGE"
L.DUNGEON_SHORT_NAME_UNDR = "UNDR"
L.DUNGEON_SHORT_NAME_WM = "WM"
L.DUNGEON_SHORT_NAME_SOTS = "SOTS"
L.DUNGEON_SHORT_NAME_KR = "KR"
L.DUNGEON_SHORT_NAME_TOS = "TOS"
L.DUNGEON_SHORT_NAME_HOA = "HOA"
L.DUNGEON_SHORT_NAME_SOA = "SOA"
L.DUNGEON_SHORT_NAME_TOP = "TOP"
L.DUNGEON_SHORT_NAME_SD = "SD"
L.DUNGEON_SHORT_NAME_NW = "NW"
L.DUNGEON_SHORT_NAME_PF = "PF"
L.DUNGEON_SHORT_NAME_DOS = "DOS"
L.DUNGEON_SHORT_NAME_MISTS = "MISTS"
L.DUNGEON_SHORT_NAME_AV = "AV"
L.DUNGEON_SHORT_NAME_ULD = "ULD"
L.DUNGEON_SHORT_NAME_NO = "NO"
L.DUNGEON_SHORT_NAME_BH = "BH"
L.DUNGEON_SHORT_NAME_NELT = "NELT"
L.DUNGEON_SHORT_NAME_AA = "AA"
L.DUNGEON_SHORT_NAME_RLP = "RLP"
L.DUNGEON_SHORT_NAME_HOI = "HOI"
L.DUNGEON_SHORT_NAME_DFC = "DFC"
L.DUNGEON_SHORT_NAME_SV = "SV"
L.DUNGEON_SHORT_NAME_ROOK = "ROOK"
L.DUNGEON_SHORT_NAME_PSF = "PSF"
L.DUNGEON_SHORT_NAME_DAWN = "DAWN"
L.DUNGEON_SHORT_NAME_COT = "COT"
L.DUNGEON_SHORT_NAME_ARAK = "ARAK"
L.DUNGEON_SHORT_NAME_BREW = "BREW"
L.DUNGEON_SHORT_NAME_FLOOD = "FLOOD"
L.DUNGEON_SHORT_NAME_YARD = "YARD"
L.DUNGEON_SHORT_NAME_WORK = "WORK"
L.DUNGEON_SHORT_NAME_LOWR = "LOWR"
L.DUNGEON_SHORT_NAME_UPPR = "UPPR"
L.DUNGEON_SHORT_NAME_STRT = "STRT"
L.DUNGEON_SHORT_NAME_GMBT = "GMBT"
L.DUNGEON_SHORT_NAME_FALL = "FALL"
L.DUNGEON_SHORT_NAME_RISE = "RISE"
L.RAIDERIO_AVERAGE_PLAYER_SCORE = "Avg. Scores for Timed +%s"
L.SHOW_AVERAGE_PLAYER_SCORE_INFO = "Show Average Scores for In-time Runs"
L.SHOW_AVERAGE_PLAYER_SCORE_INFO_DESC = "Shows the average Raider.IO score seen on members of in-time runs. This is visible on Keystone Tooltips and Player Tooltips in the Dungeon Finder."
L.MY_PROFILE_TITLE = "Raider.IO Profile"
L.PROFILE_BEST_RUNS = "Best Runs by Dungeon"
L.TOOLTIP_PROFILE = "Raider.IO Profile Tooltip Customization"
L.SHOW_RAIDERIO_BESTRUN_FIRST = "(Experimental) Prioritize Showing Raider.IO Best Run"
L.SHOW_RAIDERIO_BESTRUN_FIRST_DESC = "This is an experimental feature. Instead of showing the Raider.IO score as the first line, show the player's best run."
L.SHOW_RAIDERIO_PROFILE = "Show Raider.IO Profile Tooltip"
L.SHOW_RAIDERIO_PROFILE_DESC = "Show the Raider.IO Profile Tooltip"
L.SHOW_LEADER_PROFILE = "Allow Raider.IO Profile Tooltip Modifier"
L.SHOW_LEADER_PROFILE_DESC = "Hold down a modifier (shift/ctrl/alt) to toggle Profile Tooltip between Personal/Leader Profile."
L.INVERSE_PROFILE_MODIFIER = "Invert Raider.IO Profile Tooltip Modifier"
L.INVERSE_PROFILE_MODIFIER_DESC = "Enabling this will invert the behavior of the Raider.IO Profile Tooltip modifier (shift/ctrl/alt): hold to toggle the view between Personal/Leader profile or Leader/Personal profile."
L.ENABLE_AUTO_FRAME_POSITION = "Position Raider.IO Profile Frame Automatically"
L.ENABLE_AUTO_FRAME_POSITION_DESC = "Enabling this will keep the M+ Profile tooltip next to Dungeon Finder Frame or player tooltip."
L.ENABLE_LOCK_PROFILE_FRAME = "Lock Raider.IO Profile Frame"
L.ENABLE_LOCK_PROFILE_FRAME_DESC = "Prevents the M+ Profile Frame from being dragged. This has no effect if the M+ Profile Frame is set to be positioned automatically."
L.WARNING_LOCK_POSITION_FRAME_AUTO = "Raider.IO: You must disable Automatic Positioning for Raider.IO Profile first."
L.LOCKING_PROFILE_FRAME = "Raider.IO: Locking the M+ Profile Frame."
L.UNLOCKING_PROFILE_FRAME = "Raider.IO: Unlocking the M+ Profile Frame."
L.PROFILE_TOOLTIP_ANCHOR_TOOLTIP = "Lock Raider.IO Profile Frame or enable Automatic Positioning in order to hide this anchor."
L.MISC_SETTINGS = "Miscellaneous"
L.ENABLE_LFG_EXPORT_BUTTON = "Show export group button in LFG"
L.ENABLE_LFG_EXPORT_BUTTON_DESC = "Displays a magnifying glass button at the bottom of the LFG frame that when clicked exports your current group and queued applicants for you to copy and paste into the Raider.IO website to look up everyones profiles."
L.RAIDERIO_CLIENT_CUSTOMIZATION = "Raider.IO Client Customization"
L.ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS = "Allow Raider.IO Client Enhancements"
L.ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS_DESC = "Enabling this will allow you to view detailed Raider.IO Profile data downloaded from the Raider.IO Client for your claimed characters."
L.RAIDERIO_LIVE_TRACKING = "Raider.IO Live Tracking"
L.USE_RAIDERIO_CLIENT_LIVE_TRACKING_SETTINGS = "Allow Raider.IO Client to Control Combat Log"
L.USE_RAIDERIO_CLIENT_LIVE_TRACKING_SETTINGS_DESC = "Allow the Raider.IO Client (when present) to control your Combat Logging settings automatically."
L.AUTO_COMBATLOG = "Automatically Enable Combat Logging"
L.AUTO_COMBATLOG_DESC = "Turn Combat Logging on or off automatically when entering and exiting supported raids and dungeons."
L.AUTO_COMBATLOG_DISABLED_DESC = "Combat Logging is disabled on a Timerunner."
L.GUILD_BEST_TITLE = "Raider.IO Records"
L.GUILD_BEST_WEEKLY = "Guild: Weekly Best"
L.GUILD_BEST_SEASON = "Guild: Season Best"
L.SHOW_CLIENT_GUILD_BEST = "Show Best Records in Group Finder Mythic Dungeons"
L.SHOW_CLIENT_GUILD_BEST_DESC = "Enabling this will display your guild's Top 5 runs (Season or Weekly) in the Mythic Dungeons tab of the Group Finder window."
L.CHECKBOX_DISPLAY_WEEKLY = "Display Weekly"
L.NO_GUILD_RECORD = "No Guild Records"
L.API_DEPRECATED = "|cffFF0000Warning!|r The addon |cffFFFFFF%s|r is calling a deprecated function RaiderIO.%s. This function will be removed in future releases. Please encourage the author of %s to update their addon. Call stack: %s"
L.API_DEPRECATED_WITH = "|cffFF0000Warning!|r The addon |cffFFFFFF%s|r is calling a deprecated function RaiderIO.%s. This function will be removed in future releases. Please encourage the author of %s to update to the new API RaiderIO.%s instead. Call stack: %s"
L.API_DEPRECATED_UNKNOWN_ADDON = "<Unknown AddOn>"
L.API_DEPRECATED_UNKNOWN_FILE = "<Unknown AddOn File>"
L.API_INVALID_DATABASE = "|cffFF0000Warning!|r Detected an invalid Raider.IO database in |cffFFFFFF%s|r. Please refresh all regions and factions in the Raider.IO Client, or reinstall the Addon manually."
L.EXPORTJSON_COPY_TEXT = "Copy the following and paste it anywhere on |cff00C8FFhttps://raider.io|r to look up all players."
L.RAID_DIFFICULTY_SUFFIX_NORMAL = "N"
L.RAID_DIFFICULTY_SUFFIX_HEROIC = "H"
L.RAID_DIFFICULTY_SUFFIX_MYTHIC = "M"
L.RAID_DIFFICULTY_NAME_NORMAL = "Normal"
L.RAID_DIFFICULTY_NAME_HEROIC = "Heroic"
L.RAID_DIFFICULTY_NAME_MYTHIC = "Mythic"
L.RAID_DIFFICULTY_SUFFIX_NORMAL10 = "N10"
L.RAID_DIFFICULTY_SUFFIX_HEROIC10 = "H10"
L.RAID_DIFFICULTY_NAME_NORMAL10 = "Normal 10"
L.RAID_DIFFICULTY_NAME_HEROIC10 = "Heroic 10"
L.RAID_DIFFICULTY_SUFFIX_NORMAL25 = "N25"
L.RAID_DIFFICULTY_SUFFIX_HEROIC25 = "H25"
L.RAID_DIFFICULTY_NAME_NORMAL25 = "Normal 25"
L.RAID_DIFFICULTY_NAME_HEROIC25 = "Heroic 25"
L.RAID_ICC = "Icecrown Citadel"
L.RAID_FL = "Firelands"
L.RAID_DS = "Dragon Soul"
L.RAID_RS = "Ruby Sanctum"
L.RAID_BRD = "Blackrock Depths"
L.RAID_TOTFW = "Throne of the Four Winds"
L.RAID_BOT = "Bastion of Twilight"
L.RAID_BWD = "Blackwing Descent"
L.RAID_NP = "Nerub-ar Palace"
L.RAID_LOU = "Liberation of Undermine"
L.RAID_BOSS_NP_1 = "Ulgrax"
L.RAID_BOSS_NP_2 = "Bloodbound Horror"
L.RAID_BOSS_NP_3 = "Sikran"
L.RAID_BOSS_NP_4 = "Rasha'nan"
L.RAID_BOSS_NP_5 = "Ovi'nax"
L.RAID_BOSS_NP_6 = "Nexus-Princess"
L.RAID_BOSS_NP_7 = "Silken Court"
L.RAID_BOSS_NP_8 = "Queen Ansurek"
L.RAID_BOSS_ICC_1 = "Lord Marrowgar"
L.RAID_BOSS_ICC_2 = "Lady Deathwhisper"
L.RAID_BOSS_ICC_3 = "Icecrown Gunship Battle"
L.RAID_BOSS_ICC_4 = "Deathbringer Saurfang"
L.RAID_BOSS_ICC_5 = "Festergut"
L.RAID_BOSS_ICC_6 = "Rotface"
L.RAID_BOSS_ICC_7 = "Professor Putricide"
L.RAID_BOSS_ICC_8 = "Blood Council"
L.RAID_BOSS_ICC_9 = "Queen Lana'thel"
L.RAID_BOSS_ICC_10 = "Valithria Dreamwalker"
L.RAID_BOSS_ICC_11 = "Sindragosa"
L.RAID_BOSS_ICC_12 = "The Lich King"
L.RAID_BOSS_RS_1 = "Halion"
L.RAID_BOSS_BWD_1 = "Omnotron Defense System"
L.RAID_BOSS_BWD_2 = "Magmaw"
L.RAID_BOSS_BWD_3 = "Atramedes"
L.RAID_BOSS_BWD_4 = "Chimaeron"
L.RAID_BOSS_BWD_5 = "Maloriak"
L.RAID_BOSS_BWD_6 = "Nefarian's End"
L.RAID_BOSS_BOT_1 = "Halfus Wyrmbreaker"
L.RAID_BOSS_BOT_2 = "Theralion and Valiona"
L.RAID_BOSS_BOT_3 = "Ascendant Council"
L.RAID_BOSS_BOT_4 = "Cho'gall"
L.RAID_BOSS_BOT_5 = "Sinestra"
L.RAID_BOSS_TOTFW_1 = "Conclave of Wind"
L.RAID_BOSS_TOTFW_2 = "Al'Akir"
L.RAID_BOSS_BRD_1 = "Lord Roccor"
L.RAID_BOSS_BRD_2 = "Bael'Gar"
L.RAID_BOSS_BRD_3 = "Lord Incendius"
L.RAID_BOSS_BRD_4 = "Golem Lord Argelmach"
L.RAID_BOSS_BRD_5 = "The Seven"
L.RAID_BOSS_BRD_6 = "General Angerforge"
L.RAID_BOSS_BRD_7 = "Ambassador Flamelash"
L.RAID_BOSS_BRD_8 = "Emperor Dagran Thaurissan"
L.RAID_BOSS_FL_1 = "Beth'tilac"
L.RAID_BOSS_FL_2 = "Lord Rhyolith"
L.RAID_BOSS_FL_3 = "Shannox"
L.RAID_BOSS_FL_4 = "Alysrazor"
L.RAID_BOSS_FL_5 = "Baleroc"
L.RAID_BOSS_FL_6 = "Majordomo Staghelm"
L.RAID_BOSS_FL_7 = "Ragnaros"
L.RAID_BOSS_DS_1 = "Morchok"
L.RAID_BOSS_DS_2 = "Warlord Zon'ozz"
L.RAID_BOSS_DS_3 = "Yor'sahj the Unsleeping"
L.RAID_BOSS_DS_4 = "Hagara"
L.RAID_BOSS_DS_5 = "Ultraxion"
L.RAID_BOSS_DS_6 = "Warmaster Blackhorn"
L.RAID_BOSS_DS_7 = "Spine of Deathwing"
L.RAID_BOSS_DS_8 = "Madness of Deathwing"
L.RAID_BOSS_LOU_1 = "Vexie and the Geargrinders"
L.RAID_BOSS_LOU_2 = "Cauldron of Carnage"
L.RAID_BOSS_LOU_3 = "Rik Reverb"
L.RAID_BOSS_LOU_4 = "Stix Bunkjunker"
L.RAID_BOSS_LOU_5 = "Sprocketmonger Lockenstock"
L.RAID_BOSS_LOU_6 = "One-Armed Bandit"
L.RAID_BOSS_LOU_7 = "Mug'Zee, Heads of Security"
L.RAID_BOSS_LOU_8 = "Chrome King Gallywix"
L.RAID_ENCOUNTERS_DEFEATED_TITLE = "Raid Encounters Defeated"
L.RAIDING_DATA_HEADER = "Raider.IO Raid Progress"
L.PVP_DATA_HEADER = "Raider.IO PvP Profile"
L.CONFIG_WHERE_TO_SHOW_TOOLTIPS = "Where to Show Mythic+ and Raid Progress"
L.MAINS_RAID_PROGRESS = "Main's Progress"
L.HIDE_OWN_PROFILE = "Hide Personal Raider.IO Profile Tooltip"
L.HIDE_OWN_PROFILE_DESC = "When set this will not show your own Raider.IO Profile Tooltip, but may show other player's if they have one."
L.SHOW_RAID_ENCOUNTERS_IN_PROFILE = "Show Raid Encounters in Profile Tooltip"
L.SHOW_RAID_ENCOUNTERS_IN_PROFILE_DESC = "When set this will show Raid Encounter progress in Raider.IO Profile Tooltips"
L.CHOOSE_HEADLINE_HEADER = "Mythic+ Tooltip Headline"
L.SHOW_CURRENT_SEASON = "Show Current Mythic+ Season Score as Headline"
L.SHOW_CURRENT_SEASON_DESC = "Shows the player's current Mythic+ season score as the tooltip headline."
L.SHOW_BEST_SEASON = "Show Best Mythic+ Season Score as Headline"
L.SHOW_BEST_SEASON_DESC = "Shows the player's best Mythic+ season score as the tooltip headline. If the score is from a previous season, the season will be indicated as part of the tooltip headline."
L.SHOW_BEST_RUN = "Show Best Mythic+ Run as Headline"
L.SHOW_BEST_RUN_DESC = "Show the player's best Mythic+ run from the current season as the tooltip headline."
L.SEASON_LABEL_1 = "S1"
L.SEASON_LABEL_2 = "S2"
L.SEASON_LABEL_3 = "Post-S1"
L.SEASON_LABEL_4 = "S4"
L.USE_ENGLISH_ABBREVIATION = "Force English Abbreviations"
L.USE_ENGLISH_ABBREVIATION_DESC = "When set, this will overrides the abbreviations used for instances to be the English versions, rather than your current language."
L.CANCEL = "Cancel"
L.CONFIRM = "Confirm"
L.ENABLE_DEBUG_MODE_RELOAD = "You are enabling Debug Mode. This is intended for testing and development purposes only, and will incur additional memory usage.\n\n Clicking Confirm will Reload your Interface."
L.DISABLE_DEBUG_MODE_RELOAD = "Your are disabling Debug Mode.\n\nClicking Confirm will Reload your Interface."
L.WARNING_DEBUG_MODE_ENABLE = "|cffFFFFFF%s|r Debug Mode is enabled. You may disable it by typing |cffFFFFFF/raiderio debug|r."
L.ENABLE_RWF_MODE_RELOAD = "You are enabling Race World First Mode. This is intended for use with the Mythic World First race, and should only be used for this purposes only along with the Raider.IO Client for data uploading.\n\n Clicking Confirm will Reload your Interface."
L.DISABLE_RWF_MODE_RELOAD = "Your are disabling Race World First Mode.\n\nClicking Confirm will Reload your Interface."
L.WARNING_RWF_MODE_ENABLE = "|cffFFFFFF%s|r Race World First Mode is enabled. You may disable it by typing |cffFFFFFF/raiderio rwf|r."
L.ENABLE_RWF_MODE_BUTTON = "Enable"
L.ENABLE_RWF_MODE_BUTTON_TOOLTIP = "Click to enable Race World First Mode.\r\nThis will cause your Interface to Reload."
L.DISABLE_RWF_MODE_BUTTON = "Disable"
L.DISABLE_RWF_MODE_BUTTON_TOOLTIP = "Click to disable Race World First Mode.\r\nThis will cause your Interface to Reload."
L.RELOAD_RWF_MODE_BUTTON = "Save"
L.RELOAD_RWF_MODE_BUTTON_TOOLTIP = "Click to save the log to storage file.\r\nThis will cause your Interface to Reload."
L.RWF_MINIBUTTON_TOOLTIP = "Left-click whenever there is pending loot.\r\nThis will cause your Interface to Reload.\r\nRight-click to open the Race World First frame."
L.WIPE_RWF_MODE_BUTTON = "Wipe"
L.WIPE_RWF_MODE_BUTTON_TOOLTIP = "Click to wipe the log from the storage file.\r\nThis will cause your Interface to Reload."
L.RWF_TITLE = "|cffFFFFFFRaider.IO|r Race World First"
L.RWF_SUBTITLE_LOGGING_LOOT = "(logging loot)"
L.RWF_SUBTITLE_LOGGING_FILTERED_LOOT = "(logging relevant items)"
L.SEARCH_REGION_LABEL = "Region"
L.SEARCH_REALM_LABEL = "Realm"
L.SEARCH_NAME_LABEL = "Name"
L.CHARACTER_LF_GUILD_RAID_MYTHIC = "Looking For Mythic Raiding Guild"
L.CHARACTER_LF_GUILD_RAID_HEROIC = "Looking For Heroic Raiding Guild"
L.CHARACTER_LF_GUILD_RAID_NORMAL = "Looking For Normal Raiding Guild"
L.CHARACTER_LF_GUILD_RAID_DEFAULT = "Looking For Raiding Guild"
L.CHARACTER_LF_GUILD_MPLUS = "Looking For Guild Mythic+"
L.CHARACTER_LF_GUILD_MPLUS_WITH_SCORE = "Looking For Guild Mythic+"
L.CHARACTER_LF_GUILD_SOCIAL = "Looking for Social Guild"
L.CHARACTER_LF_GUILD_PVP = "Looking for Guild PvP"
L.CHARACTER_LF_TEAM_MPLUS_WITH_SCORE = "Looking For %d+ Mythic+ Team"
L.CHARACTER_LF_TEAM_MPLUS_DEFAULT = "Looking For Mythic+ Team"
L.GUILD_LF_RAID_MYTHIC = "Recruiting Mythic Raiders"
L.GUILD_LF_RAID_HEROIC = "Recruiting Heroic Raiders"
L.GUILD_LF_RAID_NORMAL = "Recruiting Normal Raiders"
L.GUILD_LF_RAID_DEFAULT = "Recruiting Raiders"
L.GUILD_LF_MPLUS_WITH_SCORE = "Recruiting %d+ Mythic+ Players"
L.GUILD_LF_MPLUS_DEFAULT = "Recruiting Mythic+ Players"
L.GUILD_LF_SOCIAL = "Recruiting Social Players"
L.GUILD_LF_PVP = "Recruiting PvP Players"
L.TEAM_LF_MPLUS_WITH_SCORE = "Recruiting %d+ Mythic+ Players"
L.TEAM_LF_MPLUS_DEFAULT = "Recruiting Mythic+ Players"
L.COPY_RAIDERIO_RECRUITMENT_URL = "Copy Recruitment URL"
L.ENABLE_REPLAY = "Show Mythic+ Replay System"
L.ENABLE_REPLAY_DESC = "Enabling this will allow you to race against recorded Mythic+ runs."
L.REPLAY_AUTO_SELECTION = "Preferred Replay Type"
L.REPLAY_AUTO_SELECTION_DESC = "Choose the type of replay that you wish to be automatically selected."
L.REPLAY_AUTO_SELECTION_MOST_RECENT = "Most Recent"
L.REPLAY_AUTO_SELECTION_PERSONAL_BEST = "Personal Best"
L.REPLAY_AUTO_SELECTION_TEAM_BEST = "Team Best"
L.REPLAY_AUTO_SELECTION_GUILD_BEST = "Guild Best"
L.REPLAY_AUTO_SELECTION_STARRED = "Starred"
L.REPLAY_BACKGROUND_COLOR = "Replay Background Color"
L.REPLAY_BACKGROUND_COLOR_DESC = "Specify the background color used in the replay frame."
L.REPLAY_FRAME_ALPHA = "Replay Frame Opacity"
L.REPLAY_FRAME_ALPHA_DESC = "Specify the opacity for the replay frame."
L.REPLAY_SETTINGS_TOOLTIP = "Settings"
L.REPLAY_STYLE_TITLE_MODERN = "Standard"
L.REPLAY_STYLE_TITLE_MODERN_COMPACT = "Compact"
L.REPLAY_STYLE_TITLE_MODERN_SPLITS = "Bosses Only"
L.REPLAY_STYLE_TITLE_MDI = "MDI"
L.REPLAY_TIMING_TITLE_BOSS = "Boss Time"
L.REPLAY_TIMING_TITLE_DUNGEON = "Dungeon Time"
L.REPLAY_MENU_COPY_URL = "Copy Replay URL"
L.REPLAY_MENU_REPLAY = "Replay"
L.REPLAY_MENU_TIMING = "Timing"
L.REPLAY_MENU_STYLE = "Style"
L.REPLAY_MENU_POSITION = "Position"
L.REPLAY_MENU_DOCK = "Dock"
L.REPLAY_MENU_UNDOCK = "Undock"
L.REPLAY_MENU_LOCK = "Lock"
L.REPLAY_MENU_UNLOCK = "Unlock"
L.REPLAY_MENU_DISABLE = "Disable"
L.REPLAY_REPLAY_CHANGING = "Changing your replay will reset the live data."
L.REPLAY_DISABLE_CONFIRM = "If you disable the |cffFFBD0AMythic+ Replay System|r you can turn it back on via the Settings panel under the |cffFFBD0ARaider.IO Client Customization|r category."
L.REPLAY_SUMMARY_LOGGED = "|cffFFFFFF%s|r logged your completion of this |cffFFFFFF+%s|r in |cffFFFFFF%s|r."
L.MINIMAP_SHORTCUT_HELP_LEFT_CLICK = "Left Click"
L.MINIMAP_SHORTCUT_HELP_RIGHT_CLICK = "Right Click"
L.MINIMAP_SHORTCUT_HELP_SEARCH = "Search"
L.MINIMAP_SHORTCUT_HELP_SETTINGS = "Settings"
L.MINIMAP_SHORTCUT_HEADER = "Minimap"
L.MINIMAP_SHORTCUT_BROKER_ENABLE = "Enable addon compartment button"
L.MINIMAP_SHORTCUT_BROKER_ENABLE_DESC = "Enable to display the icon inside the addon compartment menu. This will also make it available in any other addon that supports the broker system."
L.MINIMAP_SHORTCUT_MINIMAP_ENABLE = "Enable minimap button"
L.MINIMAP_SHORTCUT_MINIMAP_ENABLE_DESC = "Enable to display the icon around the minimap."
L.MINIMAP_SHORTCUT_MINIMAP_LOCK = "Lock minimap button"
L.RESET_BUTTON = "Reset Defaults"
L.RESET_CONFIRM_TEXT = "Are you sure that you want to reset Raider.IO to the default settings?"
L.RESET_CONFIRM_BUTTON = "Reset and Reload"
L.ENTER_REALM_AND_CHARACTER = "Enter realm and character name:"
L.BINDING_CATEGORY_RAIDERIO = "Raider.IO"
L.BINDING_HEADER_RAIDERIO_REPLAYUI = "Replay UI"
L.BINDING_NAME_RAIDERIO_REPLAYUI_TOGGLE = "Toggle Replay UI"
L.BINDING_NAME_RAIDERIO_REPLAYUI_TIMING_BOSS = "Set Timing to Boss Time"
L.BINDING_NAME_RAIDERIO_REPLAYUI_TIMING_DUNGEON = "Set Timing to Dungeon Time"

-- Bindings.xml
BINDING_CATEGORY_RAIDERIO = L.BINDING_CATEGORY_RAIDERIO
BINDING_HEADER_RAIDERIO_REPLAYUI = L.BINDING_HEADER_RAIDERIO_REPLAYUI
BINDING_NAME_RAIDERIO_REPLAYUI_TOGGLE = L.BINDING_NAME_RAIDERIO_REPLAYUI_TOGGLE
BINDING_NAME_RAIDERIO_REPLAYUI_TIMING_BOSS = L.BINDING_NAME_RAIDERIO_REPLAYUI_TIMING_BOSS
BINDING_NAME_RAIDERIO_REPLAYUI_TIMING_DUNGEON = L.BINDING_NAME_RAIDERIO_REPLAYUI_TIMING_DUNGEON
