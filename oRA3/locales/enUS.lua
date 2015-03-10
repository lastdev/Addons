
local _, tbl = ...
local L = {}
tbl.locale = L

-- Generic
L.name = "Name"
L.checks = "Checks"
L.disbandGroup = "Disband Group"
L.disbandGroupDesc = "Disbands your current party or raid, kicking everyone from your group, one by one, until you are the last one remaining.\n\nSince this is potentially very destructive, you will be presented with a confirmation dialog. Hold down Control to bypass this dialog."
L.options = "Options"
L.disbandingGroupChatMsg = "Disbanding group."
L.disbandGroupWarning = "Are you sure you want to disband your group?"
L.unknown = "Unknown"
L.profile = "Profile"

-- Core
L.togglePane = "Toggle oRA3 Pane"
L.toggleWithRaid = "Open with raid pane"
L.toggleWithRaidDesc = "Opens and closes the oRA3 pane automatically along with the Blizzard raid pane. If you disable this option you can still open the oRA3 pane using the keybinding or with one of the slash commands, such as |cff44ff44/radur|r."
L.showHelpTexts = "Show interface help"
L.showHelpTextsDesc = "The oRA3 interface is full of helpful texts intended to better describe what is going on and what the different interface elements actually do. Disabling this option will remove them, limiting the clutter on each pane. |cffff4411Requires a interface reload on some panes.|r"
L.ensureRepair = "Ensure guild repairs are enabled for all ranks present in raid"
L.ensureRepairDesc = "If you are the Guild Master, whenever you join a raid group and are the leader or promoted, you will ensure that guild repairs are enabled for the duration of the raid (up to 300g). Once you leave the group, the flags will be restored to their original state |cffff4411provided you have not crashed during the raid.|r"
L.repairEnabled = "Enabled guild repairs for %s for the duration of this raid."
L.showRoleIcons = "Show role icons on raid pane"
L.showRoleIconsDesc = "Show role icons and the total count for each role on the Blizzard raid pane. You will need to reopen the raid pane for changes to this setting to take effect."

L.slashCommandsHeader = "Slash commands"
L.slashCommands = [[
oRA3 sports a range of slash commands to aid you in fast-paced raiding. In case you weren't around in the old CTRA days, here's a little reference. All of the slash commands have various shorthands and also longer, more descriptive alternatives in some cases, for convenience.

|cff44ff44/radur|r - Opens the durability list.
|cff44ff44/ragear|r - Opens the gear check list.
|cff44ff44/ralag|r - Opens the latency list.
|cff44ff44/razone|r - Opens the zone list.
|cff44ff44/radisband|r - Instantly disbands the raid with no verification.
|cff44ff44/raready|r - Performs a ready check.
|cff44ff44/rainv|r - Invites the whole guild to your group.
|cff44ff44/razinv|r - Invites guild members in the same zone as you.
|cff44ff44/rarinv <rank name>|r - Invites guild members of the given rank.
]]

-- Ready check module
L.notReady = "The following players are not ready: %s"
L.readyCheckSeconds = "Ready Check (%d seconds)"
L.ready = "Ready"
L.notReady = "Not Ready"
L.noResponse = "No Response"
L.offline = "Offline"
L.readyCheckSound = "Play the ready check sound using the Master sound channel when a ready check is performed. This will play the sound while \"Sound Effects\" is disabled and at a higher volume."
L.showWindow = "Show window"
L.showWindowDesc = "Show the window when a ready check is performed."
L.hideWhenDone = "Hide window when done"
L.hideWhenDoneDesc = "Automatically hide the window when the ready check is finished."
L.hideReadyPlayers = "Hide players who are ready"
L.hideReadyPlayersDesc = "Hide players that are marked as ready from the window."
L.hideInCombat = "Hide in combat"
L.hideInCombatDesc = "Automatically hide the ready check window when you get in combat."
L.printToRaid = "Relay ready check results to raid chat"
L.printToRaidDesc = "If you are promoted, relay the results of ready checks to the raid chat, allowing raid members to see what the holdup is. Please make sure yourself that only one person has this enabled."

-- Durability module
L.durability = "Durability"
L.average = "Average"
L.broken = "Broken"
L.minimum = "Minimum"

-- Invite module
L.invite = "Invite"
L.inviteDesc = "When people whisper you the keywords below, they will automatically be invited to your group. If you're in a party and it's full, you will convert to a raid group. The keywords will only stop working when you have a full raid of 40 people. Setting a keyword to nothing will disable it."
L.invitePrintMaxLevel = "All max level characters will be invited to raid in 10 seconds. Please leave your groups."
L.invitePrintZone = "All characters in %s will be invited to raid in 10 seconds. Please leave your groups."
L.invitePrintRank = "All characters of rank %s or higher will be invited to raid in 10 seconds. Please leave your groups."
L.invitePrintGroupIsFull = "Sorry, the group is full."
L.inviteGuildRankDesc = "Invite all guild members of rank %s or higher."
L.keyword = "Keyword"
L.keywordDesc = "Anyone who whispers you this keyword will automatically and immediately be invited to your group."
L.guildKeyword = "Guild Keyword"
L.guildKeywordDesc = "Any guild member who whispers you this keyword will automatically and immediately be invited to your group."
L.inviteGuild = "Invite guild"
L.inviteGuildDesc = "Invite everyone in your guild at the maximum level."
L.inviteZone = "Invite zone"
L.inviteZoneDesc = "Invite everyone in your guild who are in the same zone as you."
L.guildRankInvites = "Guild rank invites"
L.guildRankInvitesDesc = "Clicking any of the buttons below will invite anyone of the selected rank AND HIGHER to your group. So clicking the 3rd button will invite anyone of rank 1, 2 or 3, for example. It will first post a message in either guild or officer chat and give your guild members 10 seconds to leave their groups before doing the actual invites."
L.inviteInRaidOnly = "Only invite on keyword if in a raid group"

-- Promote module
L.demoteEveryone = "Demote everyone"
L.demoteEveryoneDesc = "Demotes everyone in the current group."
L.promote = "Promote"
L.massPromotion = "Mass promotion"
L.promoteEveryone = "Everyone"
L.promoteEveryoneDesc = "Promote everyone automatically."
L.promoteGuild = "Guild"
L.promoteGuildDesc = "Promote all guild members automatically."
L.byGuildRank = "By guild rank"
L.individualPromotions = "Individual promotions"
L.individualPromotionsDesc = "Note that names are case sensitive. To add a player, enter a player name in the box below and hit 'Enter' or click the button that pops up. To remove a player from being promoted automatically, just click their name in the dropdown below."
L.add = "Add"
L.remove = "Remove"

-- Cooldowns module
L.openMonitor = "Open monitor"
L.monitorSettings = "Monitor settings"
L.showMonitor = "Show monitor"
L.showMonitorDesc = "Show or hide the cooldown bar display in the game world."
L.lockMonitor = "Lock monitor"
L.lockMonitorDesc = "Note that locking the cooldown monitor will hide the title and the drag handle and make it impossible to move it, resize it or open the display options for the bars."
L.onlyMyOwnSpells = "Only show my own spells"
L.onlyMyOwnSpellsDesc = "Toggle whether the cooldown display should only show the cooldown for spells cast by you, basically functioning as a normal cooldown display addon."
L.cooldownSettings = "Cooldown settings"
L.selectClass = "Select class"
L.selectClassDesc = "Select which cooldowns to display using the dropdown and checkboxes below. Each class has a small set of spells available that you can view using the bar display. Select a class from the dropdown and then configure the spells for that class according to your own needs."
L.neverShowOwnSpells = "Never show my own spells"
L.neverShowOwnSpellsDesc = "Toggle whether the cooldown display should never show your own cooldowns. For example if you use another cooldown display addon for your own cooldowns."

-- monitor
L.cooldowns = "Cooldowns"
L.rightClick = "Right-Click me for options!"
L.barSettings = "Bar settings"
L.labelTextSettings = "Label text settings"
L.durationTextSettings = "Duration text settings"
L.spawnTestBar = "Spawn test bar"
L.useClassColor = "Use class color"
L.customColor = "Custom color"
L.height = "Height"
L.scale = "Scale"
L.texture = "Texture"
L.icon = "Icon"
L.duration = "Duration"
L.unitName = "Unit name"
L.spellName = "Spell name"
L.shortSpellName = "Short spell name"
L.font = "Font"
L.fontSize = "Font Size"
L.labelAlign = "Label Alignment"
L.left = "Left"
L.right = "Right"
L.center = "Center"
L.outline = "Outline"
L.thick = "Thick"
L.thin = "Thin"
L.growUpwards = "Grow upwards"

-- Zone module
L.zone = "Zone"

-- Loot module
L.makeLootMaster = "Leave empty to make yourself the Master Looter."
L.autoLootMethod = "Set the loot mode automatically when joining a group"
L.autoLootMethodDesc = "Allow oRA3 to automatically set the loot method to the one you specify below when entering a party or raid."

-- Tanks module
L.tanks = "Tanks"
L.tankTabTopText = "Click on players in the bottom list to make them a personal tank. If you want help with all the options here then move your mouse over the question mark."
L.deleteButtonHelp = "Remove from the tank list. Please note once removed they will not be re-added for the remainder of this session unless you manually re-add the tank."
L.blizzMainTank = "Blizzard Main Tank"
L.tankButtonHelp = "Toggle whether this tank should be a Blizzard Main Tank."
L.save = "Save"
L.saveButtonHelp = "Saves this tank on your personal list. Any time you are grouped with this player he will be listed as a personal tank."
L.whatIsThis = "What is all this?"
L.tankHelp = "The people in the top list are your personal sorted tanks. They are not shared with the raid, and everyone can have different personal tank lists. Clicking a name in the bottom list adds them to your personal tank list.\n\nClicking on the shield icon will make that person a Blizzard Main Tank. Blizzard tanks are shared between all members of your raid and you have to be promoted to toggle it.\n\nTanks that appear on the list due to someone else making them a Blizzard Main Tank will be removed from the list when they are no longer a Blizzard Main Tank.\n\nUse the green check mark to save a tank between sessions. The next time you are in a raid with that person, he will automatically be set as a personal tank."
L.sort = "Sort"
L.moveTankUp = "Click to move this tank up."
L.show = "Show"
L.showButtonHelp = "Show this tank in your personal sorted tank display. This option only has effect locally and will not change this tanks status for anyone else in your group."

-- Latency Module
L.latency = "Latency"
L.home = "Home"
L.world = "World"

-- Gear Module
L.gear = "Gear"
L.itemLevel = "Item Level"
L.missingGems = "Missing Gems"
L.missingEnchants = "Missing Enchants"

-- BattleRes Module
L.battleResTitle = "Battle Res Monitor"
L.battleResLockDesc = "Toggle locking the monitor. This will hide the header text, background, and prevent movement."
L.battleResShowDesc = "Toggle showing or hiding the monitor."

