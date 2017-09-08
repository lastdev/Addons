local L
L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "enUS", true)










L["Loading"] = true
L["Loaded (running in debug mode)"] = true
L["Profile modified, rebooting"] = true
L["(running in debug mode)"] = true
L["Grow Up"] = true
L["Debug mode OFF"] = true
L["Debug mode ON"] = true
L["None"] = true
L["Tooltip can't be shown in combat"] = true
L["Rarity is loading..."] = true
L["Welcome to Rarity r%d. Your settings have been reset."] = true
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = true
L["Obtained On Your First Attempt"] = true
L["Obtained After %d Attempts"] = true
L["Unknown"] = true
L["Attempts"] = true
L["Progress"] = true
L["Likelihood"] = true
L["Time"] = true
L["Battle Pets"] = true
L["%s: %d attempt"] = true
L["%s: %d attempts"] = true
L["Luckiness"] = true
L["Lucky"] = true
L["Unlucky"] = true
L["Mounts"] = true
L[" (Group)"] = true
L["Shift-Click to open options"] = true
L["Click to toggle the progress bar"] = true
L["%d attempt - %.2f%%"] = true
L["%d attempts - %.2f%%"] = true
L["Found on your first attempt!"] = true
L["Found after %d attempts!"] = true
L["%s: collection completed!"] = true
L["Toys & Items"] = true
L["%s: %d attempt (%d total)"] = true
L["%s: %d attempts (%d total)"] = true
L["%s: Found on the first attempt!"] = true
L["%s: Found after %d attempts!"] = true
L["Dwarf"] = true
L["Draenei"] = true
L["Fossil"] = true
L["Night Elf"] = true
L["Nerubian"] = true
L["Orc"] = true
L["Tol'vir"] = true
L["Troll"] = true
L["Vrykul"] = true
L["Other"] = true
L["Drops from NPC(s)"] = true
L["Drops from a boss requiring a group"] = true
L["Drops from any mob in a zone"] = true
L["Obtained by using an item or opening a container"] = true
L["Obtained by fishing"] = true
L["Obtained as an archaeology project"] = true
L["Mount"] = true
L["Battle Pet"] = true
L["Toy or Item"] = true
L["Usually requires a group of around %d players"] = true
L["1 in %d chance"] = true
L["Lucky if you obtain in %d or less"] = true
L["Since last drop"] = true
L["Time spent farming"] = true
L["Chance so far"] = true
L["Total"] = true
L["Total found"] = true
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = true
L["Data has been imported from Bunny Hunter"] = true
L["#%d: %d attempt (%.2f%%)"] = true
L["#%d: %d attempts (%.2f%%)"] = true
L["Already known"] = true
L["General"] = true
L["Show minimap icon"] = true
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = true
L["Announcements"] = true
L["Enable announcements"] = true
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = true
L["Feed text"]= true
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = true
L["Minimal"] = true
L["Normal"] = true
L["Verbose"] = true
L["%d attempts"] = true
L["%d attempt"] = true
L["%s: %d attempt - %.2f%%"] = true
L["%s: %d attempts - %.2f%%"] = true
L["Create a new item to track"] = true
L["Delete this item"] = true
L["Are you sure you want to delete this item?"] = true
L["Create a New Item"] = true
L["New item"] = true
L["Custom"] = true
L["To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.\n\nYou can't change this name after you create the item, so choose it well."] = true
L["Item ID"] = true
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = true
L["You must enter an item ID."] = true
L["You must enter a valid number."] = true
L["You entered an item ID that is already being used by another item."] = true
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = true
L["Chance"] = true
L["You must enter an amount."] = true
L["You must enter a number larger than 1."] = true
L["You must enter a number larger than or equal to 0."] = true
L["How many attempts you've made so far."] = true
L["Track this"] = true
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = true
L["Repeatable"] = true
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = true
L["Enables announcements whenever you complete a new attempt toward this item."] = true
L["Type of item"] = true
L["Announce"] = true
L["Determines what type of item this is."] = true
L["Identify the Item"] = true
L["Toggles"] = true
L["Statistics"] = true
L["Spell ID"] = true
L["You must enter a spell ID."] = true
L["You entered a spell ID that is already being used by another item."] = true
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = true
L["You must enter a number larger than 0."] = true
L["Method of obtaining"] = true
L["Determines how this item is obtained."] = true
L["Group size"] = true
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = true
L["Equal odds"] = true
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = true
L["Archaeology race"] = true
L["Determines which race includes this archaeology project."] = true
L["Zones"] = true
L["A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.\n\nEnter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.\n\nPLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language."] = true
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = true
L["You must enter at least one zone."] = true
L["Please enter a comma-separated list of zones."] = true
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = true
L["Items to Use"] = true
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = true
L["You must enter at least one item ID."] = true
L["Please enter a comma-separated list of item IDs."] = true
L["Every item ID must be a number greater than 0."] = true
L["NPCs"] = true
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = true
L["You must enter at least one NPC ID."] = true
L["Please enter a comma-separated list of NPC IDs."] = true
L["Every NPC ID must be a number greater than 0."] = true
L["The name you entered is already being used by another item. Please enter a unique name."] = true
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = true
L["Click to switch to this item"] = true
L["Shift-Click to link your progress to chat"] = true
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = true
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = true
L["lucky"] = true
L["unlucky"] = true
L["Requires a pool"] = true
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = true
L["Special case"] = true
L["Obtained by mining"] = true
L["Mysterious Camel Figurine"] = true
L["Obtained by mining Elementium Vein"] = true
L["Session"] = true
L["Today"] = true
L["Yesterday"] = true
L["Last Week"] = true
L["Last Month"] = true
L["Left"] = true
L["Right"] = true
L["Hidden"] = true
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = true
L["Kill Statistic IDs"] = true
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = true
L["You must enter at least one Statistic ID."] = true
L["Please enter a comma-separated list of Statistic IDs."] = true
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = true
L["Ctrl-Click to change sort order"] = true
L["Sorting by name"] = true
L["Sorting by difficulty"] = true
L["Sorting by percent complete"] = true
L["Progress Bar"] = true
L["Width"] = true
L["Height"] = true
L["Scale"] = true
L["Show anchor"] = true
L["Locked"] = true
L["Other Requirements"] = true
L["Horde only"] = true
L["This item is only available to Horde players."] = true
L["Alliance only"] = true
L["This item is only available to Alliance players."] = true
L["Debug mode"] = true
L["Enter 1 or leave this blank to mark the item as soloable."] = true
L["Classic"] = true
L["The Burning Crusade"] = true
L["Wrath of the Lich King"] = true
L["Cataclysm"] = true
L["Mists of Pandaria"] = true
L["Holiday"] = true
L["Content Category"] = true
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = true
L["Hide high chance items"] = true
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = true
L["Undefeated"] = true
L["Defeated"] = true
L["Creature ID"] = true
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = true
L["You must enter a creature ID."] = true
L["You entered a creature ID that is already being used by another item."] = true
L["Mantid"] = true
L["Pandaren"] = true
L["Mogu"] = true
L["Enable Coins"] = true
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = true
L["Warlords of Draenor"] = true
L["Arakkoa"] = true
L["Draenor Clans"] = true
L["Ogre"] = true
L["Obtained by collecting a number of items"] = true
L["Collect %d %s"] = true
L["Collected"] = true
L["Dropped from dinosaurs on Isle of Giants"] = true
L["Collection complete!"] = true
L["%d collected - %.2f%%"] = true
L["Collection Complete"] = true
L["How many items you've collected so far."] = true
L["Collection Size"] = true
L["How many items you need to collect."] = true
L["Item ID to Collect"] = true
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = true
L["You entered an item ID that is already set as the collected item for something else."] = true
L["%s: %d collected"] = true
L["Rarity: "] = true
L["Enable tooltip additions"] = true
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = true
L["Blank line before tooltip additions"] = true
L["This causes Rarity to put a blank line above its tooltip additions."] = true
L["Font"] = true
L["Texture"] = true
L["Font Size"] = true
L["Right-Aligned"] = true
L["Show Icon"] = true
L["Show Text"] = true
L["Obtained Achievement ID"] = true
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = true
L["You entered a achievement ID that is already being used by another item."] = true
L["Instance Difficulty"] = true
L["Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.\n\nIf you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.\n\nYou can check multiple items in this list at once."] = true
L["Take screenshots"] = true
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = true
L["Already known"] = true
L["(%d/%d attempts)"] = true
L["(%d/%d collected)"] = true
L["Show attempts in tooltips"] = true
L["When enabled, Rarity tooltips will include how many attempts you've made."] = true
L["Already defeated"] = true
L["Unavailable"] = true
L["Hide unavailable items"] = true
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = true
L["Holiday reminders"] = true
L["When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest."] = true
L["A holiday event is available today for %s! Go get it!"] = true
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = true
L["Sorting by category, then name"] = true
L["Show category icons"] = true
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = true
L["Primary tooltip scale"] = true
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = true
L["Rarity Tooltip Options"] = true
L["World Tooltip Options"] = true
L["General Options"] = true
L["Secondary tooltip display"] = true
L["Requires Pickpocketing"] = true
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = true
L["Required for %s"] = true
L["Already defeated for %s"] = true
L["Profiling ON"] = true
L["Profiling OFF"] = true
L["Enable profiling"] = true
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = true
L["Use your bonus roll for a chance at this item"] = true
L["There are more holiday items available, but Rarity only reminds you about the first two."] = true
L["Rarity has %d |4coordinate:coordinates; for this item."] = true
L["You already defeated %d of them."] = true
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = true
L["Ctrl-Click to create TomTom waypoint(s)."] = true
L["Install TomTom to enable waypoint creation."] = true
L["Added %d |4waypoint:waypoints; to TomTom"] = true
L["Hide defeated items"] = true
L["When on, items marked as Defeated will be hidden from the tooltip."] = true
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = true
L["You already defeated all of them."] = true
L["Zone"] = true
L["%d |4zone:zones;"] = true
L["Draenor Garrison"] = true
L["and %d |4other zone:other zones;"] = true
L["Found in: "] = true
L["Show Time column"] = true
L["When on, the Time column will be shown in the main tooltip."] = true
L["Show Luckiness column"] = true
L["When on, the Luckiness column will be shown in the main tooltip."] = true
L["Show Zone column"] = true
L["When on, the Zone column will be shown in the main tooltip."] = true
L["Group(s) found!"] = true
L["Auto"] = true
L["Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.\n\nThis checkbox is provided by Rarity. You can hide the checkbox in Rarity options."] = true
L["Group Finder Options"] = true
L["Show auto refresh checkbox"] = true
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = true
L["Play a sound when groups are found"] = true
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = true
L["Legion"] = true
L["Demonic"] = true
L["Highmountain Tauren"] = true
L["Highborne"] = true
L["Primary tooltip hide delay"] = true
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = true
L["Defeat Detection"] = true
L["Quest ID"] = true
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = true
L["Please enter a comma-separated list of Quest IDs."] = true
L["Every Quest ID must be a number greater than 0."] = true
L["Options"] = true
L["Dungeon ID"] = true
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = true
L["Boss Name"] = true
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = true
L["Only announce when found"] = true
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = true
L["Death Knight"] = true
L["Demon Hunter"] = true
L["Druid"] = true
L["Hunter"] = true
L["Mage"] = true
L["Monk"] = true
L["Paladin"] = true
L["Priest"] = true
L["Rogue"] = true
L["Shaman"] = true
L["Warlock"] = true
L["Warrior"] = true
L["Disable for classes"] = true
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = true
L["Export this item"] = true
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = true
L["Import/Export"] = true
L["This tab lets you import and export items into and out of your Custom tab."] = true
L["Import Rarity Item Pack"] = true
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = true
L["Export Rarity Item Pack"] = true
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = true
L["Unable to retrieve item information from the server"] = true
L["Rarity Item Pack String"] = true
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = true
L["Import"] = true
L["Are you sure you want to import the Rarity Item Pack you entered?"] = true
L["Export"] = true
L["The following %d item(s) have been selected to export:"] = true
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = true
L["Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.\n\nFeel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page."] = true
L["Clear All Exports"] = true
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = true
L["Error serializing item pack"] = true
L["Error compressing item pack"] = true
L["Close"] = true
L["Error encoding item pack"] = true
L["Here is a preview of what will (or won't) be imported:"] = true
L["The selected Rarity Item Pack string is invalid."] = true
L["Here is a preview of what will (or won't) be imported:"] = true
L["(Warning: item could not be retrieved from server)"] = true
L["will be imported"] = true
L["an item already exists by this name, so it will not be imported"] = true
L["an item with the same Item ID already exists, so it will not be imported"] = true
L["not imported"] = true
L["imported successfully"] = true
L["Obtained Quest ID"] = true
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = true
L["Hide items with no attempts"] = true
L["When on, items that have no attempts yet will be hidden from the tooltip."] = true
L["Put \"Rarity:\" on a separate line"] = true
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = true
L["Distance"] = true
L["Sorting by zone"] = true
L["Hide items not in your zone"] = true
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = true
L["No items to display! Either you've obtained every item, or you have\none or more options turned on which hide things from the tooltip."] = true















-- Sources
L[""] = true
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = true
L["Players have a personal loot chance to obtain this item."] = true
L["All players can participate in killing this world boss once per week, regardless of faction"] = true
L["Contained in bonus satchels"] = true
L["Appears in the Black Market"] = true
L["Can be obtained with a bonus roll"] = true
L["This mount is only obtainable by Alliance players"] = true
L["This mount is only obtainable by Horde players"] = true

L["All raid formats except Raid Finder"] = true
L["Any raid size or difficulty"] = true
L["25-player heroic"] = true
L["Mythic difficulty"] = true
L["Heroic difficulty"] = true
L["Any difficulty"] = true
L["Any raid size"] = true
L["Heroic, any raid size"] = true
L["Only Raid Finder difficulty"] = true
L["Raid Finder or Flexible difficulty"] = true
L["40-player Event raid"] = true
L["5-player Event instance"] = true
L["25-player Event scenario"] = true
L["Mythic 5-player instance"] = true
L["Timewalker 5-player instance"] = true


L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = true
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = true
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = true
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = true
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = true
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = true
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = true
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = true
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = true
L["Obtained as a rare project for the Fossil branch of archaeology"] = true
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = true
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = true
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = true
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = true
L["The Warbringer will be riding the mount color he has a chance to drop."] = true
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = true
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = true
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = true
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = true
L["Obtained by fishing in pools located in Terrokar Forest"] = true
L["Obtained by fishing in any water in Orgrimmar"] = true
L["Obtained by fishing in any water in Ironforge"] = true
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = true
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = true
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = true
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = true
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = true
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = true
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = true
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = true
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = true
L["Available starting December 25th"] = true
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = true
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = true
L["Will only drop for druids."] = true
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = true
L["Dropped from monsters in Fang'rila"] = true
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = true
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = true
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = true
L["Obtained by opening Snow Mound in Frostfire Ridge"] = true
L["Greatfather Winter's Tree"] = true


-- Multi-step defeat detection
L["Garrison Invasion Gold Victory"] = true -- quest: 37640
L["Garrison Invasion Platinum Victory"] = true -- quest: 38482

L["Vengeance"] = true -- quest: 39290
L["Deathtalon"] = true -- quest: 39287
L["Terrorfist"] = true -- quest: 39288
L["Doomroller"] = true -- quest: 39289

L["Bleakclaw"] = true -- quest: 39168
L["Chaos Pup"] = true -- quest: 39161
L["Corrupted Thundertail"] = true -- quest: 39160
L["Cursed Spirit"] = true -- quest: 39162
L["Dark Gazer"] = true -- quest: 39167
L["Defiled Earth"] = true -- quest: 39173
L["Dreadwalker"] = true -- quest: 39170
L["Direflame"] = true -- quest: 39165
L["Felfly"] = true -- quest: 39163
L["Felsworn Sentry"] = true -- quest: 39157
L["Mirecroak"] = true -- quest: 39166
L["Netherfist"] = true -- quest: 39171
L["Skrillix"] = true -- quest: 39172
L["Tainted Maulclaw"] = true -- quest: 39164
L["Vile Blood of Draenor"] = true -- quest: 39169


-- Instance difficulties
L["None (not in an instance)"] = true
L["5-player instance"] = true
L["5-player Heroic instance"] = true
L["10-player Raid instance (legacy content; not flexible)"] = true
L["25-player Raid instance (legacy content; not flexible)"] = true
L["10-player Heroic Raid instance (legacy content; not flexible)"] = true
L["25-player Heroic Raid instance (legacy content; not flexible)"] = true
L["Raid Finder instance (legacy content; fixed at 25 players)"] = true
L["Challenge Mode instance"] = true
L["40-player Raid instance (legacy content; not flexible)"] = true
L["Heroic Scenario instance"] = true
L["Scenario instance"] = true
L["Normal Raid (10-30 players)"] = true
L["Heroic Raid (10-30 players)"] = true
L["Mythic Raid (20 player)"] = true
L["Looking For Raid (10-30 players)"] = true

-- Fishing pools
L["Floating Wreckage"] = true
L["Patch of Elemental Water"] = true
L["Floating Debris"] = true
L["Floating Debris Pool"] = true
L["Oil Spill"] = true
L["Firefin Snapper School"] = true
L["Greater Sagefish School"] = true
L["Oily Blackmouth School"] = true
L["Sagefish School"] = true
L["School of Deviate Fish"] = true
L["Stonescale Eel Swarm"] = true
L["Muddy Churning Water"] = true
L["Highland Mixed School"] = true
L["Pure Water"] = true
L["Bluefish School"] = true
L["Feltail School"] = true
L["Brackish Mixed School"] = true
L["Mudfish School"] = true
L["School of Darter"] = true
L["Sporefish School"] = true
L["Steam Pump Flotsam"] = true
L["School of Tastyfish"] = true
L["Borean Man O' War School"] = true
L["Deep Sea Monsterbelly School"] = true
L["Dragonfin Angelfish School"] = true
L["Fangtooth Herring School"] = true
L["Floating Wreckage Pool"] = true
L["Glacial Salmon School"] = true
L["Glassfin Minnow School"] = true
L["Imperial Manta Ray School"] = true
L["Moonglow Cuttlefish School"] = true
L["Musselback Sculpin School"] = true
L["Nettlefish School"] = true
L["Strange Pool"] = true
L["Schooner Wreckage"] = true
L["Schooner Wreckage Pool"] = true
L["Waterlogged Wreckage"] = true
L["Waterlogged Wreckage Pool"] = true
L["Bloodsail Wreckage"] = true
L["Bloodsail Wreckage Pool"] = true
L["Lesser Sagefish School"] = true
L["Lesser Oily Blackmouth School"] = true
L["Sparse Oily Blackmouth School"] = true
L["Abundant Oily Blackmouth School"] = true
L["Teeming Oily Blackmouth School"] = true
L["Lesser Firefin Snapper School"] = true
L["Sparse Firefin Snapper School"] = true
L["Abundant Firefin Snapper School"] = true
L["Teeming Firefin Snapper School"] = true
L["Lesser Floating Debris"] = true
L["Sparse Schooner Wreckage"] = true
L["Abundant Bloodsail Wreckage"] = true
L["Teeming Floating Wreckage"] = true
L["Albino Cavefish School"] = true
L["Algaefin Rockfish School"] = true
L["Blackbelly Mudfish School"] = true
L["Fathom Eel Swarm"] = true
L["Highland Guppy School"] = true
L["Mountain Trout School"] = true
L["Pool of Fire"] = true
L["Shipwreck Debris"] = true
L["Deepsea Sagefish School"] = true
L["Emperor Salmon School"] = true
L["Giant Mantis Shrimp Swarm"] = true
L["Golden Carp School"] = true
L["Jade Lungfish School"] = true
L["Krasarang Paddlefish School"] = true
L["Redbelly Mandarin School"] = true
L["Reef Octopus Swarm"] = true
L["Floating Shipwreck Debris"] = true
L["Jewel Danio School"] = true
L["Spinefish School"] = true
L["Tiger Gourami School"] = true
L["Large Swarm of Migrated Reef Octopus"] = true
L["Large Pool of Sha-Touched Spinefish"] = true
L["Large Pool of Glowing Jade Lungfish"] = true
L["Large Pool of Crowded Redbelly Mandarin"] = true
L["Large Tangled Mantis Shrimp Cluster"] = true
L["Large Swarm of Panicked Paddlefish"] = true
L["Large Pool of Tiger Gourami Slush"] = true
L["Large Pool of Glimmering Jewel Danio Pool"] = true
L["Large Pool of Brew Frenzied Emperor Salmon"] = true
L["Brew Frenzied Emperor Salmon"] = true
L["Glimmering Jewel Danio Pool"] = true
L["Tiger Gourami Slush"] = true
L["Swarm of Panicked Paddlefish"] = true
L["Tangled Mantis Shrimp Cluster"] = true
L["Crowded Redbelly Mandarin"] = true
L["Glowing Jade Lungfish"] = true
L["Sha-Touched Spinefish"] = true
L["Abyssal Gulper School"] = true
L["Oily Abyssal Gulper School"] = true
L["Blackwater Whiptail School"] = true
L["Blind Lake Sturgeon School"] = true
L["Fat Sleeper School"] = true
L["Fire Ammonite School"] = true
L["Jawless Skulker School"] = true
L["Sea Scorpion School"] = true
L["Oily Sea Scorpion School"] = true
L["Savage Piranha Pool"] = true
L["Black Barracuda School"] = true
L["Cursed Queenfish School"] = true
L["Runescale Koi School"] = true
L["Fever of Stormrays"] = true
L["Highmountain Salmon School"] = true
L["Mossgill Perch School"] = true




-- Mining nodes
L["Copper Vein"] = true
L["Tin Vein"] = true
L["Iron Deposit"] = true
L["Silver Vein"] = true
L["Gold Vein"] = true
L["Mithril Deposit"] = true
L["Ooze Covered Mithril Deposit"] = true
L["Truesilver Deposit"] = true
L["Ooze Covered Silver Vein"] = true
L["Ooze Covered Gold Vein"] = true
L["Ooze Covered Truesilver Deposit"] = true
L["Ooze Covered Rich Thorium Vein"] = true
L["Ooze Covered Thorium Vein"] = true
L["Small Thorium Vein"] = true
L["Rich Thorium Vein"] = true
L["Dark Iron Deposit"] = true
L["Lesser Bloodstone Deposit"] = true
L["Incendicite Mineral Vein"] = true
L["Indurium Mineral Vein"] = true
L["Fel Iron Deposit"] = true
L["Adamantite Deposit"] = true
L["Rich Adamantite Deposit"] = true
L["Khorium Vein"] = true
L["Large Obsidian Chunk"] = true
L["Small Obsidian Chunk"] = true
L["Nethercite Deposit"] = true
L["Cobalt Deposit"] = true
L["Rich Cobalt Deposit"] = true
L["Titanium Vein"] = true
L["Saronite Deposit"] = true
L["Rich Saronite Deposit"] = true
L["Obsidium Deposit"] = true
L["Huge Obsidian Slab"] = true
L["Pure Saronite Deposit"] = true
L["Elementium Vein"] = true
L["Rich Elementium Vein"] = true
L["Pyrite Deposit"] = true
L["Rich Obsidium Deposit"] = true
L["Rich Pyrite Deposit"] = true
L["Rich Pyrite Deposit"] = true
L["Ghost Iron Deposit"] = true
L["Rich Ghost Iron Deposit"] = true
L["Black Trillium Deposit"] = true
L["White Trillium Deposit"] = true
L["Kyparite Deposit"] = true
L["Rich Kyparite Deposit"] = true
L["Trillium Vein"] = true
L["Rich Trillium Vein"] = true
L["True Iron Deposit"] = true
L["Rich True Iron Deposit"] = true
L["Blackrock Deposit"] = true
L["Rich Blackrock Deposit"] = true
L["Leystone Deposit"] = true
L["Rich Leystone Deposit"] = true
L["Leystone Seam"] = true
L["Felslate Deposit"] = true
L["Rich Felslate Deposit"] = true
L["Felslate Seam"] = true





-- Tracked items
L["Reins of the Vitreous Stone Drake"] = true
L["Ashes of Al'ar"] = true
L["Reins of the Blue Proto-Drake"] = true
L["Reins of the Raven Lord"] = true
L["Swift White Hawkstrider"] = true
L["Fiery Warhorse's Reins"] = true
L["Azure Whelpling"] = true
L["Reins of the Onyxian Drake"] = true
L["Mojo"] = true
L["Disgusting Oozeling"] = true
L["Reins of the White Polar Bear"] = true
L["Flametalon of Alysrazor"] = true
L["Reins of the Azure Drake"] = true
L["Sea Turtle"] = true
L["Scepter of Azj'Aqir"] = true
L["Scorched Stone"] = true
L["Parrot Cage (Hyacinth Macaw)"] = true
L["Parrot Cage (Green Wing Macaw)"] = true
L["Deviate Hatchling"] = true
L["Gundrak Hatchling"] = true
L["Dark Whelpling"] = true
L["Tiny Emerald Whelpling"] = true
L["Captured Firefly"] = true
L["Phoenix Hatchling"] = true
L["Sprite Darter Egg"] = true
L["Fox Kit"] = true
L["Deathcharger's Reins"] = true
L["The Horseman's Reins"] = true
L["Invincible's Reins"] = true
L["Mimiron's Head"] = true
L["Razzashi Hatchling"] = true
L["Tiny Crimson Whelpling"] = true
L["Cat Carrier (Black Tabby)"] = true
L["Reins of the Blue Drake"] = true
L["Reins of the Green Proto-Drake"] = true
L["Big Love Rocket"] = true
L["Armored Razzashi Raptor"] = true
L["Fossilized Raptor"] = true
L["Reins of the Drake of the North Wind"] = true
L["Reins of the Drake of the South Wind"] = true
L["Swift Zulian Panther"] = true
L["Red Qiraji Resonating Crystal"] = true
L["Giant Sewer Rat"] = true
L["Mr. Pinchy"] = true
L["Mr. Grubbs"] = true
L["Reins of the Grey Riding Camel"] = true
L["Elementium Geode"] = true
L["Smoldering Egg of Millagazor"] = true
L["Sea Pony"] = true
L["Ice Chip"] = true
L["Reins of the Grand Black War Mammoth"] = true
L["Experiment 12-B"] = true
L["Reins of the Blazing Drake"] = true
L["Lump of Coal"] = true
L["Toxic Wasteling"] = true
L["Strand Crawler"] = true
L["Great Brewfest Kodo"] = true
L["Swift Brewfest Ram"] = true
L["Son of Galleon's Saddle"] = true
L["Reins of the Astral Cloud Serpent"] = true
L["Reins of the Heavenly Onyx Cloud Serpent"] = true
L["Skyshard"] = true
L["Whistle of Chromatic Bone"] = true
L["Blackwing Banner"] = true
L["Unscathed Egg"] = true
L["Anubisath Idol"] = true
L["Jewel of Maddening Whispers"] = true
L["Viscidus Globule"] = true
L["Core of Hardened Ash"] = true
L["Mark of Flame"] = true
L["Blazing Rune"] = true
L["Blighted Spore"] = true
L["Dusty Clutch of Eggs"] = true
L["Gluth's Bone"] = true
L["Reins of the Thundering Cobalt Cloud Serpent"] = true
L["Reins of the Cobalt Primordial Direhorn"] = true
L["Hollow Reed"] = true
L["Imbued Jade Fragment"] = true
L["Reins of the Slate Primordial Direhorn"] = true
L["Reins of the Amber Primordial Direhorn"] = true
L["Reins of the Jade Primordial Direhorn"] = true
L["Reins of the Green Primal Raptor"] = true
L["Reins of the Black Primal Raptor"] = true
L["Primal Egg"] = true
L["Living Sandling"] = true
L["Son of Animus"] = true
L["Sunfur Panda"] = true
L["Snowy Panda"] = true
L["Mountain Panda"] = true
L["Ji-Kun Hatchling"] = true
L["Porcupette"] = true
L["Direhorn Runt"] = true
L["Brilliant Phoenix Hawk Feather"] = true
L["Crystal of the Void"] = true
L["Dark Quivering Blob"] = true
L["Dripping Strider Egg"] = true
L["Half-Empty Food Container"] = true
L["Instant Arcane Sanctum Security Kit"] = true
L["Netherspace Portal-Stone"] = true
L["Pygmy Direhorn"] = true
L["Quivering Blob"] = true
L["Satyr Charm"] = true
L["Shell of Tide-Calling"] = true
L["Spiky Collar"] = true
L["Tainted Core"] = true
L["Tiny Fel Engine Key"] = true
L["Spawn of Horridon"] = true
L["Clutch of Ji-Kun"] = true
L["Darkmoon Eye"] = true
L["Reins of the Thundering Onyx Cloud Serpent"] = true
L["Ashleaf Spriteling"] = true
L["Death Adder Hatchling"] = true
L["Gu'chi Swarmling"] = true
L["Gulp Froglet"] = true
L["Jadefire Spirit"] = true
L["Jademist Dancer"] = true
L["Ominous Flame"] = true
L["Ruby Droplet"] = true
L["Skunky Alemental"] = true
L["Spineclaw Crab"] = true
L["Blackfuse Bombling"] = true
L["Lil' Bling"] = true
L["Droplet of Y'Shaarj"] = true
L["Gooey Sha-ling"] = true
L["Crane Nest"] = true
L["Snow Mound"] = true
L["Azure Crane Chick"] = true
L["Obtained by opening Crane Nests on the Timeless Isle"] = true
L["Bonkers"] = true
L["Obtained by opening Timeless Chests on the Timeless Isle"] = true
L["Timeless Chest"] = true
L["Dandelion Frolicker"] = true
L["Moon Moon"] = true
L["Kovok"] = true
L["Zandalari Anklerender"] = true
L["Zandalari Footslasher"] = true
L["Zandalari Kneebiter"] = true
L["Zandalari Toenibbler"] = true
L["Rotten Helper Box"] = true
L["Imperial Moth"] = true
L["Life-Binder's Handmaiden"] = true
L["Reins of the Bone-White Primal Raptor"] = true
L["Chuck's Bucket"] = true
L["Muckbreaths's Bucket"] = true
L["Snarly's Bucket"] = true
L["Toothy's Bucket"] = true
L["Old Crafty"] = true
L["Old Ironjaw"] = true
L["Time-Locked Box"] = true
L["Kor'kron Juggernaut"] = true
L["Sky-Bo"] = true
L["Shadowhide Pearltusk"] = true
L["Garn Steelmaw"] = true
L["Giant Coldsnout"] = true
L["Smoky Direwolf"] = true
L["Solar Spirehawk"] = true
L["Garn Nighthowl"] = true
L["Syd the Squid"] = true
L["Decahedral Dwarven Dice"] = true
L["Worn Troll Dice"] = true
L["Loaded Gnomish Dice"] = true
L["Ai-Li's Skymirror"] = true
L["Blackflame Daggers"] = true
L["Chalice of Secrets"] = true
L["Eternal Kiln"] = true
L["Farwater Conch"] = true
L["Frenzyheart Brew"] = true
L["Gastropod Shell"] = true
L["Hozen Beach Ball"] = true
L["Kang's Bindstone"] = true
L["Moonfang Shroud"] = true
L["Moonfang's Paw"] = true
L["Mr. Smite's Brass Compass"] = true
L["Odd Polished Stone"] = true
L["Pandaren Firework Launcher"] = true
L["Panflute of Pandaria"] = true
L["Rime of the Time-Lost Mariner"] = true
L["The Heartbreaker"] = true
L["Time-Lost Figurine"] = true
L["Unusual Compass"] = true
L["Warning Sign"] = true
L["Nightshade Sproutling"] = true
L["Red Goren Egg"] = true
L["Silver-Plated Turkey Shooter"] = true
L["Frightened Bush Chicken"] = true
L["Clockwork Rocket Bot"] = true
L["Snowman Kit"] = true
L["Red Helper Box"] = true
L["Jingling Bell"] = true
L["Green Helper Box"] = true
L["Crashin' Thrashin' Flyer Controller"] = true
L["The Pigskin"] = true
L["MiniZep Controller"] = true
L["Foot Ball"] = true
L["Crashin' Thrashin' Racer Controller"] = true
L["Safari Lounge Cushion"] = true
L["Fuzzy Green Lounge Cushion"] = true
L["Zhevra Lounge Cushion"] = true
L["Pineapple Lounge Cushion"] = true
L["Albino Chimaeraling"] = true
L["Weebomination"] = true
L["Sunfire Kaliri"] = true
L["Sun Sproutling"] = true
L["Spectral Bell"] = true
L["Firewing"] = true
L["Puddle Terror"] = true
L["Zomstrok"] = true
L["Bone Serpent"] = true
L["Slithershock Elver"] = true
L["Young Talbuk"] = true
L["Fragment of Anger"] = true
L["Fragment of Desire"] = true
L["Fragment of Suffering"] = true
L["Grotesque Statue"] = true
L["Hyjal Wisp"] = true
L["Leviathan Egg"] = true
L["Servant's Bell"] = true
L["Shard of Supremus"] = true
L["Smelly Gravestone"] = true
L["Sultry Grimoire"] = true
L["Sunblade Rune of Activation"] = true
L["Void Collar"] = true
L["Armored Razorback"] = true
L["Armored Razorback"] = true
L["Warsong Direfang"] = true
L["Tundra Icehoof"] = true
L["Periwinkle Calf"] = true
L["Zangar Spore"] = true
L["Seaborne Spore"] = true
L["Nightmare Bell"] = true
L["Gahz'rooki's Summoning Stone"] = true
L["Riding Turtle"] = true
L["Fandral's Seed Pouch"] = true
L["Corrupted Nest Guardian"] = true
L["Bristling Hellboar"] = true
L["Wild Goretusk"] = true
L["Reins of the Crimson Water Strider"] = true
L["Sack of Spectral Spiders"] = true
L["Coin of Many Faces"] = true
L["Servant of Demidos"] = true
L["Glittering Arcane Crystal"] = true
L["Vibrating Arcane Crystal"] = true
L["Warm Arcane Crystal"] = true
L["Savage Cub"] = true
L["Reins of the Infinite Timereaver"] = true
L["Minion of Grumpus"] = true
L["Grumpling"] = true
L["Crashin' Thrashin' Cannon Controller"] = true
L["Crashin' Thrashin' Mortar Controller"] = true
L["Crashin' Thrashin' Roller Controller"] = true
L["Gondar"] = true
L["Smashum Grabb"] = true
L["Drakum"] = true
L["Goren \"Log\" Roller"] = true
L["Sassy Imp"] = true
L["Battle Horn"] = true
L["Eternal Warrior's Sigil"] = true
L["Aqua Jewel"] = true
L["Salyin Battle Banner"] = true
L["Hardened Shell"] = true
L["Essence of the Breeze"] = true
L["Helpful Wikky's Whistle"] = true
L["Bottled Tornado"] = true
L["Ash-Covered Horn"] = true
L["Chain Pet Leash"] = true
L["Sahn Tidehunter"] = true
L["Blackhoof"] = true
L["Gibblette the Cowardly"] = true
L["Imp-Master Valessa"] = true
L["Gar'lok"] = true
L["Salyin Warscout"] = true
L["Nessos the Oracle"] = true
L["Ai-Ran the Shifting Cloud"] = true
L["Major Nanners"] = true
L["Kal'tik the Blight"] = true
L["High Priest of Ordos"] = true
L["Guk"] = true
L["Rukdug"] = true
L["Pugg"] = true
L["Sea Calf"] = true
L["Land Shark"] = true
L["Fathom Dweller"] = true
L["Living Infernal Core"] = true
L["Brinedeep Bottom-Feeder"] = true
L["Sting Ray Pup"] = true
L["Ironhoof Destroyer"] = true
L["Felsteel Annihilator"] = true
L["Jeremy Feasel"] = true
L["Snow Mound"] = true
L["Ahune"] = true
L["Moonfang"] = true
L["Christoph VonFeasel"] = true
L["Kael'thas Sunstrider"] = true
L["Old Man Barlo"] = true
L["Cupri"] = true
L["Orb of the Sin'dorei"] = true
L["Imperial Silkworm"] = true
L["Faintly Glowing Flagon of Mead"] = true
L["Don Carlos' Famous Hat"] = true
L["Burgy Blackheart's Handsome Hat"] = true
L["Knockoff Blingtron"] = true
L["Eye of Inquisition"] = true
L["Red-Hot Coal"] = true
L["Ironbound Collar"] = true
L["Stormforged Rune"] = true
L["Glittering Ball of Yarn"] = true
L["Blessed Seed"] = true
L["Ominous Pile of Snow"] = true
L["Overcomplicated Controller"] = true
L["Wriggling Darkness"] = true
L["Fragment of Frozen Bone"] = true
L["Remains of a Blood Beast"] = true
L["Putricide's Alchemy Supplies"] = true
L["Skull of a Frozen Whelp"] = true
L["Drudge Remains"] = true
L["Call of the Frozen Blade"] = true
L["Giant Worm Egg"] = true
L["Magnataur Hunting Horn"] = true
L["Nerubian Relic"] = true
L["Midnight's Eternal Reins"] = true
L["Orphaned Felbat"] = true
L["Sira's Extra Cloak"] = true
L["Highmountain Elderhorn"] = true
L["Valarjar Stormwing"] = true
L["Wild Dreamrunner"] = true
L["Leywoven Flying Carpet"] = true
L["Cloudwing Hippogryph"] = true
L["Scraps"] = true
L["Curious Wyrmtongue Cache"] = true
L["Ageless Bronze Drake"] = true
L["Bronze Proto-Whelp"] = true
L["Crysa"] = true
L["Muyani"] = true
L["Albino Buzzard"] = true
L["Everliving Spore"] = true
L["Cavern Moccasin"] = true
L["Young Venomfang"] = true
L["Torn Invitation"] = true
L["The quest starter item for Reins of the Llothien Prowler"] = true
L["Arcano-Shower"] = true
L["Displacer Meditation Stone"] = true
L["Kaldorei Light Globe"] = true
L["Unstable Powder Box"] = true
L["Wisp in a Bottle"] = true
L["Ley Spider Eggs"] = true
L["Glimmering Treasure Chest"] = true
L["Ancient Mana"] = true
L["Chromie"] = true
L["Abyss Worm"] = true
L["Blight Boar Microphone"] = true
L["Nightmare Whelpling"] = true









--[[
					The rest of this file is auto-generated using the WoWAce localization application.
					Please go to http://www.wowace.com/projects/rarity/localization/ to update translations.
					Anyone with a WowAce/CurseForge account can edit them. 
]] 


L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "deDE")
if L then
L[" (Group)"] = " (Gruppe)"
L["#%d: %d attempt (%.2f%%)"] = "#%d: %d Versuch (%.2f%%)"
L["#%d: %d attempts (%.2f%%)"] = "#%d: %d Versuche (%.2f%%)"
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = "%d |4Wegpunkt:Wegpunkte; |4befindet sich:befinden sich; im Inneren |4der Instanz:der Instanzen; und |4wurde:wurden; nicht hinzugefügt"
L["%d |4zone:zones;"] = "%d |4Zone:Zonen;"
L["%d attempt"] = "%d Versuch"
L["%d attempt - %.2f%%"] = "%d Versuch - %.2f%%"
L["%d attempts"] = "%d Versuche"
L["%d attempts - %.2f%%"] = "%d Versuche - %.2f%%"
L["%d collected - %.2f%%"] = "%d gesammelt - %.2f%%"
L["%s: %d attempt"] = "%s: %d Versuch"
L["%s: %d attempt - %.2f%%"] = "%s: %d Versuch - %.2f%%"
L["%s: %d attempt (%d total)"] = "%s: %d Versuch (%d gesamt)"
L["%s: %d attempts"] = "%s: %d Versuche"
L["%s: %d attempts - %.2f%%"] = "%s: %d Versuche - %.2f%%"
L["%s: %d attempts (%d total)"] = "%s: %d Versuche (%d gesamt)"
L["%s: %d collected"] = "%s: %d gesammelt"
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = "%s: 0/%d bisheriger Versuch (%.2f%% - %s)"
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = "%s: 0/%d bisherige Versuche (%.2f%% - %s)"
L["%s: collection completed!"] = "%s: Sammlung vollständig!"
L["%s: Found after %d attempts!"] = "%s: Gefunden nach %d Versuchen!"
L["%s: Found on the first attempt!"] = "%s erbeutet beim ersten Versuch!"
L["(%d/%d attempts)"] = "(%d/%d versucht)"
L["(%d/%d collected)"] = "(%d/%d gesammelt)"
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = "(Die rot markierten Gegenstände konnten auf dem Server nicht gefunden werden. Eventuell existieren sie nicht und können daher entfernt werden.)"
L["(running in debug mode)"] = "Läuft im Debug Modus"
L["(Warning: item could not be retrieved from server)"] = "(Warnung: Gegenstand wurde auf dem Server nicht gefunden)"
L["1 in %d chance"] = "1 zu %d Chance"
L["10-player Heroic Raid instance (legacy content; not flexible)"] = "10 Spieler heroischer Schlachtzug (alter Content, kein Flexmode)"
L["10-player Raid instance (legacy content; not flexible)"] = "10 Spieler Schlachtzug (alter Content, kein Flexmode)"
L["25-player Event scenario"] = "25 Spieler Event Szenario"
L["25-player heroic"] = "25 Spieler heroisch"
L["25-player Heroic Raid instance (legacy content; not flexible)"] = "25 Spieler heroischer Schlachtzug (alter Content, kein Flexmode)"
L["25-player Raid instance (legacy content; not flexible)"] = "25 Spieler Schlachtzug (alter Content, kein Flexmode)"
L["40-player Event raid"] = "40 Spieler Event Schlachtzug"
L["40-player Raid instance (legacy content; not flexible)"] = "40 Spieler Schlachtzug (alter Content, kein Flexmode)"
L["5-player Event instance"] = "5 Spieler Event Instanz "
L["5-player Heroic instance"] = "5 Spieler heroische Instanz"
L["5-player instance"] = "5 Spieler Instanz "
--Translation missing 
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = "A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = "Eine durch Kommas getrennte Liste der NPCs, die dieses Item droppen. Nutze WoW-Head oder ähnliche Seiten um die NPC-IDs zu finden."
--Translation missing 
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = "A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."
--Translation missing 
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = "A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."
--Translation missing 
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = "A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."
--Translation missing 
L[ [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=] ] = [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=]
--Translation missing 
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = "A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."
--Translation missing 
L["A holiday event is available today for %s! Go get it!"] = "A holiday event is available today for %s! Go get it!"
L["Abundant Bloodsail Wreckage"] = "Blutsegelwrackteile"
L["Abundant Firefin Snapper School"] = "Ein ergiebiger Schwarm Feuerflossenschnapper"
L["Abundant Oily Blackmouth School"] = "Ergiebiger Schwarm öliger Schwarzmaulfische"
L["Abyss Worm"] = "Kluftwurm"
L["Abyssal Gulper School"] = "Ein Schwarm Tiefseeschluckaale"
L["Adamantite Deposit"] = "Adamantitvorkommen"
L["Added %d |4waypoint:waypoints; to TomTom"] = "%d |4Wegpunkt:Wegpunkte; zu TomTom hinzugefügt"
--Translation missing 
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = "Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."
--Translation missing 
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = "After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."
L["Ageless Bronze Drake"] = "Nie alternder Bronzedrache"
L["Ahune"] = true
L["Ai-Li's Skymirror"] = "Ai-Lis Himmelsspiegel"
L["Ai-Ran the Shifting Cloud"] = "Ai-Ran die flüchtige Wolke"
L["Albino Buzzard"] = "Albinobussard"
L["Albino Cavefish School"] = "Ein Schwarm Albinohöhlenfische"
L["Albino Chimaeraling"] = "Albinoschimärling"
L["Algaefin Rockfish School"] = "Ein Schwarm Algenflossenbarsche"
--Translation missing 
L["All players can participate in killing this world boss once per week, regardless of faction"] = "All players can participate in killing this world boss once per week, regardless of faction"
L["All raid formats except Raid Finder"] = "Alle Schlachtzugsschwierigkeitsgrade außer Schlachtzugbrowser"
L["Alliance only"] = "Nur Allianz"
L["Already defeated"] = "bereits besiegt"
L["Already defeated for %s"] = "bereits besiegt für %s"
L["Already known"] = "Bereits bekannt"
--Translation missing 
L["an item already exists by this name, so it will not be imported"] = "an item already exists by this name, so it will not be imported"
--Translation missing 
L["an item with the same Item ID already exists, so it will not be imported"] = "an item with the same Item ID already exists, so it will not be imported"
L["Ancient Mana"] = "Uraltes Mana"
L["and %d |4other zone:other zones;"] = "und %d |4andere Zone:andere Zonen;"
L["Announce"] = "Ankündigung"
L["Announcements"] = "Ankündigungen"
--Translation missing 
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = "Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."
L["Anubisath Idol"] = "Götze des Anubisath"
L["Any difficulty"] = "Jeder Schwierigkeitsgrad"
L["Any raid size"] = "Jede Schlachtzugsgröße"
L["Any raid size or difficulty"] = "Jede Schlachtzugsgröße und Schwierigkeitsgrad"
L["Appears in the Black Market"] = "Erscheint im Schwarzmarkt"
L["Aqua Jewel"] = "Wasserjuwel"
L["Arakkoa"] = true
L["Arcano-Shower"] = "Arkandusche"
L["Archaeology race"] = "Archäologie Rasse"
L["Are you sure you want to delete this item?"] = "Bist du sicher, dass du diesen Gegenstand löschen möchtest?"
--Translation missing 
L["Are you sure you want to import the Rarity Item Pack you entered?"] = "Are you sure you want to import the Rarity Item Pack you entered?"
--Translation missing 
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = "Are you sure you want to turn off the Export toggle for all your Custom items?"
L["Armored Razorback"] = "Gepanzerter Klingenrücken"
L["Armored Razzashi Raptor"] = "Gepanzerter Razzashiraptor"
L["Ash-Covered Horn"] = "Aschebedecktes Horn"
L["Ashes of Al'ar"] = "Al'ars Asche"
L["Ashleaf Spriteling"] = "Eschenblattgeistling"
L["Attempts"] = "Versuche"
--Translation missing 
L["Auto"] = "Auto"
L["Available starting December 25th"] = "Erhältlich ab dem 25. Dezember"
L["Azure Crane Chick"] = "Azurblaues Kranichküken"
L["Azure Whelpling"] = "Azurblauer Welpling"
L["Battle Horn"] = "Schlachthorn"
L["Battle Pet"] = "Kampfhaustier"
L["Battle Pets"] = "Kampfhaustiere"
L["Big Love Rocket"] = "Große Liebesrakete"
L["Black Barracuda School"] = "Ein Schwarm schwarzer Barrakudas"
L["Black Trillium Deposit"] = "Schwarzes Trilliumvorkommen"
L["Blackbelly Mudfish School"] = "Ein Schwarm Schwarzbauchmatschflosser"
L["Blackflame Daggers"] = "Schwarzflammendolche"
L["Blackfuse Bombling"] = "Rußschmieds Bömbchen"
L["Blackhoof"] = "Schwarzhuf"
L["Blackrock Deposit"] = "Schwarzfelsvorkommen"
L["Blackwater Whiptail School"] = "Ein Schwarm Schwarzwasserpeitschflossen"
L["Blackwing Banner"] = "Banner der Pechschwingen"
--Translation missing 
L["Blank line before tooltip additions"] = "Blank line before tooltip additions"
L["Blazing Rune"] = "Lodernde Rune"
L["Bleakclaw"] = "Trübklaue"
L["Blessed Seed"] = "Gesegnetes Samenkorn"
L["Blight Boar Microphone"] = "Mikrofon von Seuchensau"
L["Blighted Spore"] = "Verseuchte Sporen"
L["Blind Lake Sturgeon School"] = "Ein Schwarm blinder Seestöre"
L["Bloodsail Wreckage"] = "Blutsegelwrackteile"
L["Bloodsail Wreckage Pool"] = "Ein Schwarm Blutsegelwrackteile"
L["Bluefish School"] = "Blauflossenschwarm"
L["Bone Serpent"] = "Knochenschlange"
L["Bonkers"] = "Flipps"
L["Borean Man O' War School"] = "Ein Schwarm boreanischer Galeeren"
--Translation missing 
L["Boss Name"] = "Boss Name"
L["Bottled Tornado"] = "Abgefüllter Tornado"
L["Brackish Mixed School"] = "Brackwasserschwarm"
L["Brew Frenzied Emperor Salmon"] = "Brauverrückter Kaiserlachs"
L["Brilliant Phoenix Hawk Feather"] = "Glänzende Phönixfalkenfeder"
L["Brinedeep Bottom-Feeder"] = "Gründling der salzigen Tiefen"
L["Bristling Hellboar"] = "Stachelhölleneber"
L["Bronze Proto-Whelp"] = "Bronzener Protowelpe"
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = "Bunny Hunter läuft. Willst du, dass Rarity Daten von Bunny Hunter importiert? Schalte Bunny Hunter aus, oder klicke auf Ja, wenn du nicht noch einmal gefragt werden mächtest."
L["Burgy Blackheart's Handsome Hat"] = "Bürgi Schwarzherzens Hübscher Hut"
L["Call of the Frozen Blade"] = "Ruf der gefrorenen Klinge"
--Translation missing 
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = "Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."
--Translation missing 
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = "Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."
--Translation missing 
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = "Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."
--Translation missing 
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = "Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."
L["Can be obtained with a bonus roll"] = "Kann auch mit einen Bonuswurf erbeutet werden"
--Translation missing 
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = "Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."
L["Captured Firefly"] = "Gefangenes Glühwürmchen"
L["Cat Carrier (Black Tabby)"] = "Katzentransportkorb (Schwarze Tigerkatze)"
L["Cataclysm"] = true
L["Cavern Moccasin"] = "Höhlenmokassinschlange"
--Translation missing 
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = "Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"
L["Chain Pet Leash"] = "Haustierkette"
L["Chalice of Secrets"] = "Kelch der Geheimnisse"
--Translation missing 
L["Challenge Mode instance"] = "Challenge Mode instance"
L["Chance"] = true
L["Chance so far"] = "Chance bis jetzt"
L["Chaos Pup"] = "Chaoswelpe"
--Translation missing 
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = "Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."
--Translation missing 
L[ [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=] ] = [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=]
--Translation missing 
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = "Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."
L["Christoph VonFeasel"] = "Christoph von Feasel"
L["Chromie"] = true
L["Chuck's Bucket"] = "Schnapps Eimer"
L["Classic"] = true
--Translation missing 
L["Clear All Exports"] = "Clear All Exports"
L["Click to switch to this item"] = "Klicken um diesen Gegenstand auszuwählen"
L["Click to toggle the progress bar"] = "Klicken um die Fortschrittsanzeige zu aktvieren/deaktivieren"
L["Clockwork Rocket Bot"] = "Aufziehraketenbot"
--Translation missing 
L["Close"] = "Close"
L["Cloudwing Hippogryph"] = "Wolkenschwingenhippogryph"
L["Clutch of Ji-Kun"] = "Kralle von Ji-Kun"
L["Cobalt Deposit"] = "Kobaltvorkommen"
L["Coin of Many Faces"] = "Münze der vielen Gesichter"
L["Collect %d %s"] = "Sammel %d %s"
L["Collected"] = "Gesammelt"
L["Collection Complete"] = "Sammlung vollständig"
L["Collection complete!"] = "Sammlung vollständig!"
--Translation missing 
L["Collection Size"] = "Collection Size"
L["Contained in bonus satchels"] = "Enthalten in Bonusbeuteln"
--Translation missing 
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = "Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."
--Translation missing 
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = "Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."
--Translation missing 
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = "Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."
--Translation missing 
L["Content Category"] = "Content Category"
--Translation missing 
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = "Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."
--Translation missing 
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = "Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."
L["Copper Vein"] = "Kupferader"
--Translation missing 
L[ [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=] ] = [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=]
L["Core of Hardened Ash"] = "Gehärteter Aschekern"
L["Corrupted Nest Guardian"] = "Verderbter Nestwächter"
L["Corrupted Thundertail"] = "Verderbter Donnerschwanz"
L["Crane Nest"] = "Kranichnest"
L["Crashin' Thrashin' Cannon Controller"] = "Krachbummkanonensteuerung"
L["Crashin' Thrashin' Flyer Controller"] = "Steuerung des Krachbummfliegers"
L["Crashin' Thrashin' Mortar Controller"] = "Krachbummmörsersteuerung"
L["Crashin' Thrashin' Racer Controller"] = "Steuerung für Krachbummflitzer"
L["Crashin' Thrashin' Roller Controller"] = "Krachbummwalzensteuerung"
L["Create a New Item"] = "Einen neuen Gegenstand erstellen"
L["Create a new item to track"] = "Einen neuen Gegenstand zum Beobachten erstellen."
--Translation missing 
L["Creature ID"] = "Creature ID"
L["Crowded Redbelly Mandarin"] = "Ein Schwarm wimmelnder Rotbauchmandarine"
L["Crysa"] = true
L["Crystal of the Void"] = "Leerenkristall"
L["Ctrl-Click to change sort order"] = "Strg-Klick auf das Minimap-Icon um die Sortierung zu ändern"
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = "Strg-Klick um die restlichen TomTom Wegpunkte zu erstellen"
L["Ctrl-Click to create TomTom waypoint(s)."] = "Strg-Klick um TomTom Wegpunkt(e) zu erstellen"
L["Cupri"] = true
L["Curious Wyrmtongue Cache"] = "Seltsame Wyrmzungentruhe"
L["Cursed Queenfish School"] = "Ein Schwarm verfluchter Königinnenfische"
L["Cursed Spirit"] = "Verfluchter Geist"
L["Custom"] = "Benutzerdefiniert"
L["Dandelion Frolicker"] = "Löwenzahnwitzbold"
L["Dark Gazer"] = "Dunkles Auge"
L["Dark Iron Deposit"] = "Dunkeleisenablagerung"
L["Dark Quivering Blob"] = "Dunkler wabernder Klumpen"
L["Dark Whelpling"] = "Dunkelwelpling"
L["Darkmoon Eye"] = "Dunkelmond-Auge"
L["Data has been imported from Bunny Hunter"] = "Daten wurden aus Bunny Hunter importiert."
L["Death Adder Hatchling"] = "Todesnatterjungtier"
L["Death Knight"] = "Todesritter"
L["Deathcharger's Reins"] = "Zügel des Todesstreitrosses"
L["Deathtalon"] = "Todeskralle"
L["Debug mode"] = "Debug-Modus"
L["Debug mode OFF"] = "Debug Modus AUS"
L["Debug mode ON"] = "Debug Modus AN"
L["Decahedral Dwarven Dice"] = "Zehnseitige Zwergenwürfel"
L["Deep Sea Monsterbelly School"] = "Ein Schwarm Tiefseemonsterbäuche"
L["Deepsea Sagefish School"] = "Ein Schwarm Tiefseeweisenfische"
--Translation missing 
L["Defeat Detection"] = "Defeat Detection"
L["Defeated"] = "Besiegt"
L["Defiled Earth"] = "Entweihte Erde"
L["Delete this item"] = "Gegenstand löschen"
L["Demon Hunter"] = "Dämonenjäger"
L["Demonic"] = "Dämonisch"
--Translation missing 
L["Determines how this item is obtained."] = "Determines how this item is obtained."
--Translation missing 
L["Determines what type of item this is."] = "Determines what type of item this is."
--Translation missing 
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = "Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."
--Translation missing 
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = "Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."
--Translation missing 
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = "Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."
--Translation missing 
L[ [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=] ] = [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=]
--Translation missing 
L["Determines which race includes this archaeology project."] = "Determines which race includes this archaeology project."
L["Deviate Hatchling"] = "Deviatjungtier"
L["Direflame"] = "Terrorflamme"
L["Direhorn Runt"] = "Terrorhörnchen"
L["Disable for classes"] = "Deaktiveren für Klassen"
L["Disgusting Oozeling"] = "Ekelhafter Schlammling"
L["Displacer Meditation Stone"] = "Entrückender Meditationsstein"
L["Distance"] = "Entfernung"
L["Don Carlos' Famous Hat"] = "Don Carlos' berühmter Hut"
L["Doomroller"] = "Verdammniswalze"
L["Draenei"] = true
L["Draenor Clans"] = "Klans von Draenor"
L["Draenor Garrison"] = "Dreanor Garnison"
L["Dragonfin Angelfish School"] = "Engelsdrachenfischschwarm"
L["Drakum"] = true
L["Dreadwalker"] = "Schreckenswandler"
L["Dripping Strider Egg"] = "Tropfendes Schreiterei"
L["Droplet of Y'Shaarj"] = "Tröpfchen von Y'Shaarj"
--Translation missing 
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = "Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."
--Translation missing 
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = "Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."
--Translation missing 
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = "Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."
--Translation missing 
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = "Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"
--Translation missing 
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = "Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."
--Translation missing 
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = "Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."
--Translation missing 
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = "Dropped by Malygos in The Eye of Eternity (any raid size)"
--Translation missing 
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = "Dropped by Onyxia in Onyxia's Lair (any raid size)"
--Translation missing 
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = "Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"
--Translation missing 
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = "Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"
--Translation missing 
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = "Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"
--Translation missing 
L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = "Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"
--Translation missing 
L["Dropped from dinosaurs on Isle of Giants"] = "Dropped from dinosaurs on Isle of Giants"
--Translation missing 
L["Dropped from monsters in Fang'rila"] = "Dropped from monsters in Fang'rila"
L["Drops from a boss requiring a group"] = "Erbeutet von einem Boss der eine Gruppe benötigt"
L["Drops from any mob in a zone"] = "Erbeutet von jedem Mob in der Zone"
L["Drops from NPC(s)"] = "Erbeutet von NPC(s)"
L["Drudge Remains"] = "Sklavenüberreste"
L["Druid"] = "Druide"
--Translation missing 
L["Dungeon ID"] = "Dungeon ID"
L["Dusty Clutch of Eggs"] = "Staubiges Gelege"
L["Dwarf"] = "Zwerg"
--Translation missing 
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = "Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."
L["Elementium Geode"] = "Elementiumgeode"
L["Elementium Vein"] = "Elementiumader"
L["Emperor Salmon School"] = "Ein Schwarm Kaiserlachse"
L["Enable announcements"] = "Ankündigungen aktivieren"
--Translation missing 
L["Enable Coins"] = "Enable Coins"
--Translation missing 
L["Enable profiling"] = "Enable profiling"
--Translation missing 
L["Enable tooltip additions"] = "Enable tooltip additions"
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = "Aktiviert die Option, dass immer wenn ein Versuch ein item zu bekommen, welches von Rarity beobachtet wird, beendet wird eine Ankündigung gemacht wird. Man kann auch Ankündigungen für jedes Item einzeln aktivieren, aber diese Option ist der Hautschalter"
--Translation missing 
L["Enables announcements whenever you complete a new attempt toward this item."] = "Enables announcements whenever you complete a new attempt toward this item."
--Translation missing 
L["Enter 1 or leave this blank to mark the item as soloable."] = "Enter 1 or leave this blank to mark the item as soloable."
--Translation missing 
L["Equal odds"] = "Equal odds"
--Translation missing 
L["Error compressing item pack"] = "Error compressing item pack"
--Translation missing 
L["Error encoding item pack"] = "Error encoding item pack"
--Translation missing 
L["Error serializing item pack"] = "Error serializing item pack"
L["Essence of the Breeze"] = "Essenz der Brise"
L["Eternal Kiln"] = "Ewiger Flammenkessel"
L["Eternal Warrior's Sigil"] = "Siegel des ewigen Kriegers"
--Translation missing 
L["Everliving Spore"] = "Everliving Spore"
L["Every item ID must be a number greater than 0."] = "Jede Item-ID muss eine Zahl größer als 0 sein."
L["Every NPC ID must be a number greater than 0."] = "Jede NPC-ID muss eine Zahl größer als 0 sein."
--Translation missing 
L["Every Quest ID must be a number greater than 0."] = "Every Quest ID must be a number greater than 0."
L["Experiment 12-B"] = true
--Translation missing 
L["Export"] = "Export"
--Translation missing 
L["Export Rarity Item Pack"] = "Export Rarity Item Pack"
--Translation missing 
L["Export this item"] = "Export this item"
L["Eye of Inquisition"] = "Untersuchendes Auge"
L["Faintly Glowing Flagon of Mead"] = "Schwach leuchtende Metflasche"
L["Fandral's Seed Pouch"] = "Fandrals Samenbeutel"
L["Fangtooth Herring School"] = "Ein Schwarm Fangzahnheringe"
L["Farwater Conch"] = "Weitwassermuschelhorn"
L["Fat Sleeper School"] = "Ein Schwarm dicker Schläfer"
L["Fathom Dweller"] = "Tiefenbewohner"
L["Fathom Eel Swarm"] = "Klafteraalschwarm"
--Translation missing 
L["Feed text"] = "Feed text"
L["Fel Iron Deposit"] = "Teufelseisenvorkommen"
L["Felfly"] = "Teufelsfliege"
L["Felslate Deposit"] = "Teufelsschiefervorkommen"
L["Felslate Seam"] = "Teufelsschieferflöz"
L["Felsteel Annihilator"] = "Teufelsstahlvernichter"
L["Felsworn Sentry"] = "Wächter des Dämonenpakts"
L["Feltail School"] = "Teufelsfinnenschwarm"
L["Fever of Stormrays"] = "Eine Gruppe Sturmrochen"
L["Fiery Warhorse's Reins"] = "Zügel des feurigen Schlachtrosses"
L["Fire Ammonite School"] = "Ein Schwarm Feuerammoniten"
L["Firefin Snapper School"] = "Feuerflossenschnapperschwarm"
L["Firewing"] = "Feuerflügel"
--Translation missing 
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = "Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"
L["Flametalon of Alysrazor"] = "Flammenkralle von Alysrazar"
L["Floating Debris"] = "Schwimmende Trümmer"
L["Floating Debris Pool"] = "Ein Schwarm Schwimmende Trümmer"
L["Floating Shipwreck Debris"] = "Schwimmende Schiffswrack Trümmer"
L["Floating Wreckage"] = "Treibende Wrackteile"
L["Floating Wreckage Pool"] = true
L["Font"] = "Schriftart"
L["Font Size"] = "Schriftgröße"
L["Foot Ball"] = "Fußball"
L["Fossil"] = true
L["Fossilized Raptor"] = "Fossiler Raptor"
L["Found after %d attempts!"] = "Nach %d Versuchen gefunden!"
L["Found in: "] = "Gefunden in: "
L["Found on your first attempt!"] = "Beim ersten Versuch erbeutet!"
L["Fox Kit"] = "Fuchswelpe"
L["Fragment of Anger"] = "Fragment des Zorns"
L["Fragment of Desire"] = "Fragment der Begierde"
L["Fragment of Frozen Bone"] = "Gefrorenes Knochenfragment"
L["Fragment of Suffering"] = "Fragment des Leidens"
L["Frenzyheart Brew"] = "Wildherzengebräu"
L["Frightened Bush Chicken"] = "Aufgeschrecktes Buschhuhn"
L["Fuzzy Green Lounge Cushion"] = "Knallgrünes Sitzpolster"
L["Gahz'rooki's Summoning Stone"] = "Gahz'rookis Beschwörungsstein"
L["Gar'lok"] = true
L["Garn Nighthowl"] = "Garn Nachtheuler"
L["Garn Steelmaw"] = "Garnstahlrachen"
--Translation missing 
L["Garrison Invasion Gold Victory"] = "Garrison Invasion Gold Victory"
--Translation missing 
L["Garrison Invasion Platinum Victory"] = "Garrison Invasion Platinum Victory"
L["Gastropod Shell"] = "Schneckenhaus"
L["General"] = "Allgemein"
L["General Options"] = "Allgemeine Einstellungen"
L["Ghost Iron Deposit"] = "Geistereisenvorkommen"
L["Giant Coldsnout"] = "Riesige Kaltschnauze"
L["Giant Mantis Shrimp Swarm"] = "Ein Schwarm riesiger Mantisgarnelen"
L["Giant Sewer Rat"] = "Riesige Kanalratte"
L["Giant Worm Egg"] = "Riesenwurmei"
L["Gibblette the Cowardly"] = "Gibblett der Feigling"
L["Glacial Salmon School"] = "Ein Schwarm Winterlachse"
L["Glassfin Minnow School"] = "Ein Schwarm Glasflossenelritzen"
L["Glimmering Jewel Danio Pool"] = "Ein Schwarm glitzernder Juwelendanios"
L["Glimmering Treasure Chest"] = "Glitzernde Schatztruhe"
L["Glittering Arcane Crystal"] = "Glitzernder arkaner Kristall"
L["Glittering Ball of Yarn"] = "Schimmerndes Wollknäuel"
L["Glowing Jade Lungfish"] = "Leuchtender Jadelungenfisch"
L["Gluth's Bone"] = "Gluths Knochen"
L["Gold Vein"] = "Goldader"
L["Golden Carp School"] = "Ein Schwarm Goldkarpfen"
L["Gondar"] = true
L["Gooey Sha-ling"] = true
L["Goren \"Log\" Roller"] = "Goren-\"Stamm\"-Walze"
L["Great Brewfest Kodo"] = "Großer Braufestkodo"
L["Greater Sagefish School"] = "Großer Schwarm Weisenfische"
--Translation missing 
L["Greatfather Winter's Tree"] = "Greatfather Winter's Tree"
L["Green Helper Box"] = "Grüne Helferbox"
L["Grotesque Statue"] = "Groteskenstatue"
L["Group Finder Options"] = "Gruppen Finder Optionen"
L["Group size"] = "Gruppengröße"
L["Group(s) found!"] = "Gruppe(n) gefunden!"
--Translation missing 
L["Grow Up"] = "Grow Up"
L["Grumpling"] = true
--Translation missing 
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = "Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."
L["Gu'chi Swarmling"] = "Schwarmling von Gu'chi"
L["Guk"] = true
L["Gulp Froglet"] = "Schluckfroschling"
L["Gundrak Hatchling"] = "Jungtier aus Gundrak"
L["Half-Empty Food Container"] = "Halbleerer Essensbehälter"
L["Hardened Shell"] = "Gehärteter Panzer"
L["Height"] = "Höhe"
L["Helpful Wikky's Whistle"] = "Pfeife des hilfreichen Nupsi"
--Translation missing 
L["Here is a preview of what will (or won't) be imported:"] = "Here is a preview of what will (or won't) be imported:"
L["Heroic difficulty"] = "Heroischer Schwierigkeitsgrad"
L["Heroic Raid (10-30 players)"] = "Heroischer Schlachtzug (10-30 Spieler)"
L["Heroic Scenario instance"] = "Heroisches Szenario"
L["Heroic, any raid size"] = "Heroisch, jede Schlachtzuggröße"
L["Hidden"] = "Versteckt"
--Translation missing 
L["Hide defeated items"] = "Hide defeated items"
L["Hide high chance items"] = "Verstecke Gegenstände mit hoher Dropchance"
L["Hide items not in your zone"] = "Verstecke Gegenstände außerhalb deiner Zone"
L["Hide items with no attempts"] = "Verstecke Gegenstände ohne Versuche"
L["Hide unavailable items"] = "Verstecke nicht verfügbare Gegenstände"
L["High Priest of Ordos"] = "Hohepriester von Ordos"
L["Highborne"] = "Hochgeborene"
L["Highland Guppy School"] = "Ein Schwarm Hochlandguppys"
L["Highland Mixed School"] = "Mischschwarm des Hochlands"
L["Highmountain Elderhorn"] = "Hochbergurhorn"
L["Highmountain Salmon School"] = "Ein Schwarm Hochberglachse"
L["Highmountain Tauren"] = "Hochbergtauren"
L["Holiday"] = "Weltereignisse"
--Translation missing 
L["Holiday reminders"] = "Holiday reminders"
L["Hollow Reed"] = "Hohles Schilfrohr"
L["Horde only"] = "Nur Horde"
--Translation missing 
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = "How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."
L["How many attempts you've made so far."] = "Anzahl der Versuche bis jetzt."
--Translation missing 
L["How many items you need to collect."] = "How many items you need to collect."
--Translation missing 
L["How many items you've collected so far."] = "How many items you've collected so far."
L["Hozen Beach Ball"] = "Ho-zen-Strandball"
L["Huge Obsidian Slab"] = "Sehr große Obsidian-Platte "
L["Hunter"] = "Jäger"
L["Hyjal Wisp"] = "Irrwisch des Hyjal"
L["Ice Chip"] = "Eissplitter"
L["Identify the Item"] = "Identifizieren Sie den Artikel"
L["Imbued Jade Fragment"] = "Erfülltes Jadefragment"
L["Imperial Manta Ray School"] = "Ein Schwarm imperialer Mantarochen"
L["Imperial Moth"] = "Kaisermotte"
L["Imperial Silkworm"] = "Kaiserliche Seidenraupe"
L["Imp-Master Valessa"] = "Wichtelmeisterin Valessa"
--Translation missing 
L["Import"] = "Import"
--Translation missing 
L["Import Rarity Item Pack"] = "Import Rarity Item Pack"
--Translation missing 
L["Import/Export"] = "Import/Export"
--Translation missing 
L["imported successfully"] = "imported successfully"
L["Incendicite Mineral Vein"] = "Pyrophormineralvorkommen"
L["Indurium Mineral Vein"] = "Induriummineralvorkommen"
L["Install TomTom to enable waypoint creation."] = "Installiere TomTom, um die Wegpunkt Erstellung zu aktivieren"
L["Instance Difficulty"] = "Instanz-Schwierigkeitsgrad"
L["Instant Arcane Sanctum Security Kit"] = "Schnellbaukasten der arkanen Sanktensicherheit"
L["Invincible's Reins"] = "Unbesiegbars Zügel"
L["Iron Deposit"] = "Eisenvorkommen"
L["Ironbound Collar"] = "Eisenbeschlagenes Halsband"
L["Ironhoof Destroyer"] = "Eisenhufzerstörer"
L["Item ID"] = "Gegenstands-ID"
--Translation missing 
L["Item ID to Collect"] = "Item ID to Collect"
L["Items to Use"] = "Gegenstände zu benutzen"
L["Jade Lungfish School"] = "Ein Schwarm Jadelungenfische"
L["Jadefire Spirit"] = "Jadefeuergeist"
L["Jademist Dancer"] = "Jadenebeltänzer"
L["Jawless Skulker School"] = "Ein Schwarm kieferloser Schleicher"
L["Jeremy Feasel"] = true
L["Jewel Danio School"] = "Ein Schwarm Juwelendanios"
L["Jewel of Maddening Whispers"] = "Juwel des flüsternden Wahnsinns"
L["Ji-Kun Hatchling"] = "Küken von Ji-Kun"
L["Jingling Bell"] = "Bimmelglöckchen"
L["Kael'thas Sunstrider"] = "Kael'thas Sonnenwanderer"
L["Kaldorei Light Globe"] = "Lichtkugel der Kaldorei"
L["Kal'tik the Blight"] = "Kal'tik der Veröder"
L["Kang's Bindstone"] = "Kangs Bindungsstein"
L["Khorium Vein"] = "Khoriumader"
--Translation missing 
L["Kill Statistic IDs"] = "Kill Statistic IDs"
L["Knockoff Blingtron"] = "Billiges Blingtron-Imitat"
L["Kor'kron Juggernaut"] = "Koloss der Kor'kron"
L["Kovok"] = true
L["Krasarang Paddlefish School"] = "Ein Schwarm Krasaranglöffelstöre"
L["Kyparite Deposit"] = "Kyparitvorkommen"
L["Land Shark"] = "Landhai"
L["Large Obsidian Chunk"] = "Großer Obsidiumvorkommen"
L["Large Pool of Brew Frenzied Emperor Salmon"] = "Großer Schwarm brauverrückter Kaiserlachse"
L["Large Pool of Crowded Redbelly Mandarin"] = "Ein großer Schwarm wimmelnder Rotbauchmandarine"
L["Large Pool of Glimmering Jewel Danio Pool"] = "Ein großer Schwarm glitzernder Juwelendanios"
L["Large Pool of Glowing Jade Lungfish"] = "Großer Schwarm leuchtender Jadelungenfische"
L["Large Pool of Sha-Touched Spinefish"] = "Ein großer Schwarm Sha-berührter Stachelfische"
L["Large Pool of Tiger Gourami Slush"] = "Großer Schwarm Tigerguramischlick"
L["Large Swarm of Migrated Reef Octopus"] = "Großer Schwarm gewanderter Riffkraken"
L["Large Swarm of Panicked Paddlefish"] = "Großer Schwarm panischer Krasaranglöffelstöre"
L["Large Tangled Mantis Shrimp Cluster"] = "Großer verhedderter Schwarm riesiger Mantisgarnelen"
L["Last Month"] = "Letzter Monat"
L["Last Week"] = "Letzte Woche"
L["Left"] = "Links"
L["Legion"] = true
L["Lesser Bloodstone Deposit"] = "Geringe Blutsteinablagerung"
L["Lesser Firefin Snapper School"] = "Kleiner Feuerflossenschnapperschwarm"
L["Lesser Floating Debris"] = true
L["Lesser Oily Blackmouth School"] = "Kleiner Schwarm öliger Schwarzmaulfische"
L["Lesser Sagefish School"] = "Kleiner Weisenfischschwarm"
L["Leviathan Egg"] = "Leviathanei"
L["Ley Spider Eggs"] = "Leyspinneneier"
L["Leystone Deposit"] = "Leysteinvorkommen"
L["Leystone Seam"] = "Leysteinflöz"
L["Leywoven Flying Carpet"] = "Leygewobener fliegender Teppich"
L["Life-Binder's Handmaiden"] = "Erste Dame der Lebensbinderin"
L["Likelihood"] = "Wahrscheinlichkeit"
L["Lil' Bling"] = "Klein Bling"
L["Living Infernal Core"] = "Lebender Höllenkern"
L["Living Sandling"] = "Lebendiger Sandling"
L["Loaded (running in debug mode)"] = "Geladen (läuft im Debug Modus)"
L["Loaded Gnomish Dice"] = "Gezinkte gnomische Würfel"
L["Loading"] = "Lädt"
L["Locked"] = "Gesperrt"
--Translation missing 
L["Looking For Raid (10-30 players)"] = "Looking For Raid (10-30 players)"
L["Luckiness"] = "Glück"
L["Lucky"] = "glücklich"
L["lucky"] = "glücklich"
L["Lucky if you obtain in %d or less"] = "Glücklich, wenn du es nach %d oder weniger Versuchen erhältst"
L["Lump of Coal"] = "Kohleklumpen"
--Translation missing 
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = "Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."
L["Mage"] = "Magier"
L["Magnataur Hunting Horn"] = "Magnataurenjagdhorn"
L["Major Nanners"] = "Major Affentanz"
L["Mantid"] = "Mantis"
L["Mark of Flame"] = "Mal der Flamme"
L["Method of obtaining"] = "Verfahren zur Gewinnung"
L["Midnight's Eternal Reins"] = "Mittnachts ewige Zügel"
L["Mimiron's Head"] = "Mimirons Kopf"
L["Minimal"] = true
L["Minion of Grumpus"] = "Diener von Grumpus"
L["MiniZep Controller"] = "MiniZep-Steuerung"
L["Mirecroak"] = "Schlammquaker"
L["Mists of Pandaria"] = true
L["Mithril Deposit"] = "Mithrilvorkommen"
L["Mogu"] = true
L["Mojo"] = true
L["Monk"] = "Mönch"
L["Moon Moon"] = "Mondflausch"
L["Moonfang"] = "Mondfang"
L["Moonfang Shroud"] = "Mondfangpelz"
L["Moonfang's Paw"] = "Mondfangs Pfote"
L["Moonglow Cuttlefish School"] = "Ein Schwarm Mondlichtsepia"
L["Mossgill Perch School"] = "Ein Schwarm Mooskiemenbarsche"
L["Mount"] = "Reittier"
L["Mountain Panda"] = "Bergpanda"
L["Mountain Trout School"] = "Ein Schwarm Bergforellen"
L["Mounts"] = "Reittiere"
L["Mr. Grubbs"] = "Maderich"
L["Mr. Pinchy"] = "Dr. Zwicky"
L["Mr. Smite's Brass Compass"] = "Handlanger Peins Messingkompass"
L["Muckbreaths's Bucket"] = "Matschbrabbels Eimer"
L["Muddy Churning Water"] = "Schlammiges aufgewühltes Wasser"
L["Mudfish School"] = "Matschflosserschwarm"
L["Musselback Sculpin School"] = "Muschelrückengropperschwarm"
L["Muyani"] = true
L["Mysterious Camel Figurine"] = "Mysteriöse Kamelfigur"
L["Mythic 5-player instance"] = "Mythischer Dungeon"
L["Mythic difficulty"] = "Mythischer Schwierigkeitsgrad"
L["Mythic Raid (20 player)"] = "Mythtischer Schlachtzug"
L["Nerubian"] = "Neruber"
L["Nerubian Relic"] = "Nerubisches Relikt"
L["Nessos the Oracle"] = "Nessos das Orakel"
L["Nethercite Deposit"] = "Netheritablagerung"
L["Netherfist"] = "Netherfaust"
L["Netherspace Portal-Stone"] = "Netherraumportalstein"
L["Nettlefish School"] = "Ein Schwarm Nesselfische"
L["New item"] = "Neuer Gegenstand"
L["Night Elf"] = "Nachtelf"
L["Nightmare Bell"] = "Alptraumglocke"
L["Nightmare Whelpling"] = "Alptraumwelpling"
L["Nightshade Sproutling"] = "Nachtschattensprössling"
--Translation missing 
L[ [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=] ] = [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=]
L["None"] = "Nichts"
L["None (not in an instance)"] = "Nichts (nicht in einer Instanz)"
L["Normal"] = true
L["Normal Raid (10-30 players)"] = "Schlachtzug (10-30 Spieler)"
--Translation missing 
L["not imported"] = "not imported"
L["NPCs"] = true
L["Obsidium Deposit"] = "Obsidiumvorkommen"
--Translation missing 
L["Obtained Achievement ID"] = "Obtained Achievement ID"
L["Obtained After %d Attempts"] = "Erbeutet nach %d Versuchen"
--Translation missing 
L["Obtained as a rare project for the Fossil branch of archaeology"] = "Obtained as a rare project for the Fossil branch of archaeology"
--Translation missing 
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = "Obtained as a very rare project for the Tol'vir branch of archaeology"
L["Obtained as an archaeology project"] = "Erbeutet mit einem Archäologie Projekt"
L["Obtained by collecting a number of items"] = "Erbeutet durch Sammeln von einer gewissen Anzahl von Gegenständen"
L["Obtained by fishing"] = "Erbeutet mit Angeln"
L["Obtained by fishing in any water in Ironforge"] = "Erbeutet mit Angeln in Eisenschmiede"
L["Obtained by fishing in any water in Orgrimmar"] = "Erbeutet mit Angeln in Orgrimmar"
L["Obtained by fishing in pools located in Terrokar Forest"] = "Erbeutet mit Angeln in Schwärmen in den Wäldern von Terokkar"
L["Obtained by mining"] = "Erbeutet mit Bergbau"
--Translation missing 
L["Obtained by mining Elementium Vein"] = "Obtained by mining Elementium Vein"
--Translation missing 
L["Obtained by opening Crane Nests on the Timeless Isle"] = "Obtained by opening Crane Nests on the Timeless Isle"
--Translation missing 
L["Obtained by opening Snow Mound in Frostfire Ridge"] = "Obtained by opening Snow Mound in Frostfire Ridge"
--Translation missing 
L["Obtained by opening Timeless Chests on the Timeless Isle"] = "Obtained by opening Timeless Chests on the Timeless Isle"
L["Obtained by using an item or opening a container"] = "Erbeutet durch Benutzen oder Öffnen eines Gegenstandes"
L["Obtained On Your First Attempt"] = "Erhalten beim ersten Versuch"
--Translation missing 
L["Obtained Quest ID"] = "Obtained Quest ID"
--Translation missing 
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = "Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"
L["Odd Polished Stone"] = "Seltsamer glatt geschliffener Stein"
L["Ogre"] = "Oger"
L["Oil Spill"] = "Ölfleck"
L["Oily Abyssal Gulper School"] = "Ein Schwarm ölige Tiefseeschluckaale"
L["Oily Blackmouth School"] = "Schwarm öliger Schwarzmaulfische"
L["Oily Sea Scorpion School"] = "Ein Schwarm ölige Seeskorpione"
L["Old Crafty"] = "Alter Fuchs"
L["Old Ironjaw"] = "Alter Eisenkiefer"
L["Old Man Barlo"] = "Der alte Barlo"
L["Ominous Flame"] = "Ominöse Flamme"
L["Ominous Pile of Snow"] = "Verdächtiger Schneehaufen"
--Translation missing 
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = "One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."
--Translation missing 
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = "One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."
--Translation missing 
L["Only announce when found"] = "Only announce when found"
L["Only Raid Finder difficulty"] = "Nur Schlachtzugbrowser"
L["Ooze Covered Gold Vein"] = "Schlammbedecktes Goldvorkommen"
L["Ooze Covered Mithril Deposit"] = "Schlammbedeckte Mithrilablagerung"
L["Ooze Covered Rich Thorium Vein"] = "Schlammbedecktes reiches Thoriumvorkommen"
L["Ooze Covered Silver Vein"] = "Schlammbedecktes Silbervorkommen"
L["Ooze Covered Thorium Vein"] = "Schlammbedeckte Thoriumader"
L["Ooze Covered Truesilver Deposit"] = "Schlammbedecktes Echtsilbervorkommen"
--Translation missing 
L["Options"] = "Options"
L["Orb of the Sin'dorei"] = "Kugel der Sin'dorei"
L["Orc"] = "Ork"
L["Orphaned Felbat"] = "Verwaiste Teufelsfledermaus"
L["Other"] = "Andere"
L["Other Requirements"] = "Sonstige Anforderungen"
L["Overcomplicated Controller"] = "Überkomplizierte Steuerung"
L["Paladin"] = true
L["Pandaren"] = true
L["Pandaren Firework Launcher"] = "Pandarischer Raketenzünder"
L["Panflute of Pandaria"] = "Pandarische Panflöte"
L["Parrot Cage (Green Wing Macaw)"] = "Papageienkäfig (Grünflügelara)"
L["Parrot Cage (Hyacinth Macaw)"] = "Papageienkäfig (Hyazinthara)"
--Translation missing 
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = "Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."
L["Patch of Elemental Water"] = "Stelle mit Elementarwasser"
L["Periwinkle Calf"] = "Lilablassblaues Kalb"
L["Phoenix Hatchling"] = "Phönixküken"
L["Pineapple Lounge Cushion"] = "Ananasräkelkissen"
L["Play a sound when groups are found"] = "Einen Sound abspielen, wenn Gruppen gefunden wurden"
L["Players have a personal loot chance to obtain this item."] = "Spieler können diesen Gegenständ als persönliche Beute erhalten."
--Translation missing 
L["Please enter a comma-separated list of item IDs."] = "Please enter a comma-separated list of item IDs."
--Translation missing 
L["Please enter a comma-separated list of NPC IDs."] = "Please enter a comma-separated list of NPC IDs."
--Translation missing 
L["Please enter a comma-separated list of Quest IDs."] = "Please enter a comma-separated list of Quest IDs."
--Translation missing 
L["Please enter a comma-separated list of Statistic IDs."] = "Please enter a comma-separated list of Statistic IDs."
--Translation missing 
L["Please enter a comma-separated list of zones."] = "Please enter a comma-separated list of zones."
L["Pool of Fire"] = "Feuerteich"
L["Porcupette"] = "Stachelschweinchen"
L["Priest"] = "Priester"
L["Primal Egg"] = "Urei"
--Translation missing 
L["Primary tooltip hide delay"] = "Primary tooltip hide delay"
--Translation missing 
L["Primary tooltip scale"] = "Primary tooltip scale"
L["Profile modified, rebooting"] = "Profil verändert, starte neu"
--Translation missing 
L["Profiling OFF"] = "Profiling OFF"
--Translation missing 
L["Profiling ON"] = "Profiling ON"
L["Progress"] = "Fortschritt"
L["Progress Bar"] = "Fortschrittsanzeige"
L["Puddle Terror"] = "Pfützenschreck"
L["Pugg"] = true
--Translation missing 
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = "Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."
L["Pure Saronite Deposit"] = "Reine Saronitablagerung"
L["Pure Water"] = "Reines Wasser"
--Translation missing 
L["Put \"Rarity:\" on a separate line"] = "Put \"Rarity:\" on a separate line"
L["Putricide's Alchemy Supplies"] = "Seuchenmords Alchemiekasten"
L["Pygmy Direhorn"] = "Winziges Terrorhorn"
L["Pyrite Deposit"] = "Pyritvorkommen"
--Translation missing 
L["Quest ID"] = "Quest ID"
L["Quivering Blob"] = "Wabernder Klumpen"
L["Raid Finder instance (legacy content; fixed at 25 players)"] = "Schlachtzugbrowserinstanz (alter Content, für 25 Spieler)"
L["Raid Finder or Flexible difficulty"] = "Schlachtzugbrowser- oder Flexmodeschwierigkeitsgrad"
L["Rarity has %d |4coordinate:coordinates; for this item."] = "Rarity hat %d |4Koordinate:Koordinaten; für diesen Gegenstand."
L["Rarity is loading..."] = "Rarity wird geladen..."
--Translation missing 
L["Rarity Item Pack String"] = "Rarity Item Pack String"
L["Rarity Tooltip Options"] = "Rarity Tooltip Einstellungen"
L["Rarity: "] = true
L["Razzashi Hatchling"] = "Razzashijungtier"
L["Red Goren Egg"] = "Rotes Gorenei"
L["Red Helper Box"] = "Rote Helferbox"
L["Red Qiraji Resonating Crystal"] = "Roter Qirajiresonanzkristall"
L["Redbelly Mandarin School"] = "Ein Schwarm Rotbauchmandarine"
L["Red-Hot Coal"] = "Rotglühende Kohle"
L["Reef Octopus Swarm"] = "Ein Schwarm Riffkraken"
L["Reins of the Amber Primordial Direhorn"] = "Zügel des goldgelben Urterrorhorns"
L["Reins of the Astral Cloud Serpent"] = "Zügel der astralen Wolkenschlange"
L["Reins of the Azure Drake"] = "Zügel des Azurblauen Drachen"
L["Reins of the Black Primal Raptor"] = "Zügel des schwarzen Urraptors"
L["Reins of the Blazing Drake"] = "Zügel des lodernden Drachen"
L["Reins of the Blue Drake"] = "Zügel des Blaudrachen"
L["Reins of the Blue Proto-Drake"] = "Zügel des blauen Protodrachen"
L["Reins of the Bone-White Primal Raptor"] = "Zügel des knochenweißen Urraptors"
L["Reins of the Cobalt Primordial Direhorn"] = "Zügel des kobaltblauen Urterrorhorns"
L["Reins of the Crimson Water Strider"] = "Zügel des purpurroten Wasserschreiters"
L["Reins of the Drake of the North Wind"] = "Zügel des Drachen des Nordwinds"
L["Reins of the Drake of the South Wind"] = "Zügel des Drachen des Südwinds"
L["Reins of the Grand Black War Mammoth"] = "Zügel des großen schwarzen Kriegsmammuts"
L["Reins of the Green Primal Raptor"] = "Zügel des grünen Urraptors"
L["Reins of the Green Proto-Drake"] = "Zügel des grünen Protodrachen"
L["Reins of the Grey Riding Camel"] = "Zügel des grauen Reitkamels"
L["Reins of the Heavenly Onyx Cloud Serpent"] = "Zügel der himmlischen Onyxwolkenschlange"
L["Reins of the Infinite Timereaver"] = "Zügel des ewigen Zeithäschers"
L["Reins of the Jade Primordial Direhorn"] = "Zügel des jadegrünen Urterrorhorns"
L["Reins of the Onyxian Drake"] = "Zügel des Drachen von Onyxia"
L["Reins of the Raven Lord"] = "Zügel des Rabenfürsten"
L["Reins of the Slate Primordial Direhorn"] = "Zügel des schiefergrauen Urterrorhorns"
L["Reins of the Thundering Cobalt Cloud Serpent"] = "Zügel der donnernden Kobaltwolkenschlange"
L["Reins of the Thundering Onyx Cloud Serpent"] = "Zügel der donnernden Onyxwolkenschlange"
L["Reins of the Vitreous Stone Drake"] = "Zügel des Vitriolsteindrachen"
L["Reins of the White Polar Bear"] = "Zügel des weißen Eisbären"
L["Remains of a Blood Beast"] = "Überreste einer Blutbestie"
L["Repeatable"] = "Wiederholbar"
L["Required for %s"] = "Benötigt für %s"
--Translation missing 
L["Requires a pool"] = "Requires a pool"
L["Requires Pickpocketing"] = "Erfordert Taschendiebstahl"
L["Rich Adamantite Deposit"] = "Reiches Adamantitvorkommen"
L["Rich Blackrock Deposit"] = "Reiches Schwarzfelsvorkommen"
L["Rich Cobalt Deposit"] = "Reiches Kobaltvorkommen"
L["Rich Elementium Vein"] = "Reiche Elementiumader"
L["Rich Felslate Deposit"] = "Reiches Teufelsschiefervorkommen"
L["Rich Ghost Iron Deposit"] = "Reiches Geistereisenvorkommen"
L["Rich Kyparite Deposit"] = "Reiches Kyparitvorkommen"
L["Rich Leystone Deposit"] = "Reiches Leysteinvorkommen"
L["Rich Obsidium Deposit"] = "Reiches Obsidiumvorkommen"
L["Rich Pyrite Deposit"] = "Reiches Pyritvorkommen"
L["Rich Saronite Deposit"] = "Reiches Saronitvorkommen"
L["Rich Thorium Vein"] = "Reiche Thoriumader"
L["Rich Trillium Vein"] = "Reiche Trilliumader"
L["Rich True Iron Deposit"] = "Reiches Echteisenvorkommen"
L["Riding Turtle"] = "Reitschildkröte"
L["Right"] = "Rechts"
L["Right-Aligned"] = "Rechtsbündig"
L["Rime of the Time-Lost Mariner"] = "Reif des zeitverlorenen Seefahrers"
L["Rogue"] = "Schurke"
L["Rotten Helper Box"] = "Miese Helferbox"
L["Ruby Droplet"] = "Rubinrotes Tröpfchen"
L["Rukdug"] = true
L["Runescale Koi School"] = "Ein Schwarm Runenschuppenkoi"
L["Sack of Spectral Spiders"] = "Sack mit spektralen Spinnen"
L["Safari Lounge Cushion"] = "Safariräkelkissen"
L["Sagefish School"] = "Weisenfischschwarm"
L["Sahn Tidehunter"] = "Sahn Gezeitenjäger"
L["Salyin Battle Banner"] = "Schlachtbanner von Salyis"
L["Salyin Warscout"] = "Kriegsspäher von Salyis"
L["Saronite Deposit"] = "Saronitvorkommen"
L["Sassy Imp"] = "Vorlauter Wichtel"
L["Satyr Charm"] = "Satyrglücksbringer"
L["Savage Cub"] = "Wildes Tigerjunges"
L["Savage Piranha Pool"] = "Ein Schwarm Mordlustiger Piranha"
L["Scale"] = "Skalierung"
L["Scenario instance"] = "Szenario"
L["Scepter of Azj'Aqir"] = "Szepter von Azj'Aqir"
L["School of Darter"] = "Stachelflosserschwarm"
L["School of Deviate Fish"] = "Deviatfischschwarm"
L["School of Tastyfish"] = "Leckerfischschwarm"
L["Schooner Wreckage"] = "Schiffswrackteile"
L["Schooner Wreckage Pool"] = "Ein Schwarm Schiffswrackteile"
L["Scorched Stone"] = "Versengter Stein"
L["Scraps"] = "Fetzie"
L["Sea Calf"] = "Seekalb"
L["Sea Pony"] = "Seepony"
L["Sea Scorpion School"] = "Ein Schwarm Seeskorpione"
L["Sea Turtle"] = "Meeresschildkröte"
L["Seaborne Spore"] = "Meeresspore"
--Translation missing 
L["Secondary tooltip display"] = "Secondary tooltip display"
L["Servant of Demidos"] = "Diener von Demidos"
L["Servant's Bell"] = "Dienerglocke"
L["Session"] = "Sitzung"
--Translation missing 
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = "Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."
L["Shadowhide Pearltusk"] = "Schattenfellperlzahn"
L["Shaman"] = "Schamane"
L["Shard of Supremus"] = "Fragment von Supremus"
L["Sha-Touched Spinefish"] = "Ein Schwarm Sha-berührter Stachelfische"
L["Shell of Tide-Calling"] = "Muschel des Gezeitenrufers"
L["Shift-Click to link your progress to chat"] = "Shift-Klick um deinen Forschritt im Chat zu verlinken"
L["Shift-Click to open options"] = "Shift-Klick um die Einstellungen zu öffnen"
L["Shipwreck Debris"] = "Schiffswracktrümmer"
--Translation missing 
L["Show anchor"] = "Show anchor"
L["Show attempts in tooltips"] = "Zeige Versuche in Tooltips"
--Translation missing 
L["Show auto refresh checkbox"] = "Show auto refresh checkbox"
L["Show category icons"] = "Zeige Kategorie-Icons"
L["Show Icon"] = "Icon anzeigen"
L["Show Luckiness column"] = "Zeige Glück Spalte"
L["Show minimap icon"] = "Zeige Minimap-Icon"
L["Show Text"] = "Text anzeigen"
L["Show Time column"] = "Zeit Spalte anzeigen"
L["Show Zone column"] = "Zonen Spalte anzeigen"
L["Silver Vein"] = "Silberader"
L["Silver-Plated Turkey Shooter"] = "Versilberte Truthahnbüchse"
L["Since last drop"] = "Seit dem letzten Fund"
L["Sira's Extra Cloak"] = "Siras Ersatzumhang"
L["Skrillix"] = true
L["Skull of a Frozen Whelp"] = "Schädel eines gefrorenen Welpen"
L["Skunky Alemental"] = "Ranziger Bierlementar"
L["Sky-Bo"] = "Himmel-Bo"
L["Skyshard"] = "Himmelssplitter"
L["Slithershock Elver"] = "Glitschschockaal"
L["Small Obsidian Chunk"] = "Kleiner Obsidiumvorkommen"
L["Small Thorium Vein"] = "Kleine Thoriumader"
L["Smashum Grabb"] = "Zaggund Hopp"
L["Smelly Gravestone"] = "Stinkender Grabstein"
L["Smoky Direwolf"] = "Rauchgrauer Terrorwolf"
L["Smoldering Egg of Millagazor"] = "Schwelendes Ei von Millagazor"
L["Snarly's Bucket"] = "Knurris Eimer"
L["Snow Mound"] = "Schneehügel"
L["Snowman Kit"] = "Schneemannset"
L["Snowy Panda"] = "Schneepanda"
L["Solar Spirehawk"] = "Sonnenfalke der Spitzen"
L["Son of Animus"] = "Sohn des Animus"
L["Son of Galleon's Saddle"] = "Sattel des Sohnes von Galleon"
L["Sorting by category, then name"] = "Sortieren nach Kategorie und Name"
L["Sorting by difficulty"] = "Sortieren nach Schwierigkeitsgrad"
L["Sorting by name"] = "Sortierung nach Name"
L["Sorting by percent complete"] = "Sortierung nach Prozent abgeschlossen"
L["Sorting by zone"] = "Sortieren nach Zone"
L["Sparse Firefin Snapper School"] = "Spärlicher Feuerflossenschnapperschwarm"
L["Sparse Oily Blackmouth School"] = "Spärlicher Schwarm öliger Schwarzmaulfische"
L["Sparse Schooner Wreckage"] = true
L["Spawn of Horridon"] = "Ausgeburt von Horridon"
L["Special case"] = "Spezialfall"
L["Spectral Bell"] = "Spektrale Glocke"
L["Spell ID"] = "Spell-ID"
L["Spiky Collar"] = "Stachelhalsband"
L["Spineclaw Crab"] = "Dornzangenkrabbe"
L["Spinefish School"] = "Ein Schwarm Stachelfische"
L["Sporefish School"] = "Sporenfischschwarm"
L["Sprite Darter Egg"] = "Grimmlingflitzerei"
L["Statistics"] = "Statistiken"
L["Steam Pump Flotsam"] = "Treibgut der Dampfpumpe"
L["Sting Ray Pup"] = "Stachelrochenjunges"
L["Stonescale Eel Swarm"] = "Steinschuppenaalschwarm"
L["Stormforged Rune"] = "Sturmgeschmiedete Rune"
L["Strand Crawler"] = "Strandkriecher"
L["Strange Pool"] = true
L["Sultry Grimoire"] = "Verführerischer Foliant"
L["Sun Sproutling"] = "Sonnensprössling"
L["Sunblade Rune of Activation"] = "Aktivierungsrune der Sonnenklingen"
L["Sunfire Kaliri"] = "Sonnenfeuerkaliri"
L["Sunfur Panda"] = "Sonnenpelzpanda"
L["Swarm of Panicked Paddlefish"] = "Ein Schwarm panischer Krasaranglöffelstöre"
L["Swift Brewfest Ram"] = "Schneller Braufestwidder"
L["Swift White Hawkstrider"] = "Schneller weißer Falkenschreiter"
L["Swift Zulian Panther"] = "Schneller zulianischer Panther"
L["Syd the Squid"] = "Kalle die Qualle"
L["Tainted Core"] = "Besudelter Kern"
L["Tainted Maulclaw"] = "Besudeltes Klauenmaul"
L["Take screenshots"] = "Screenshot machen"
L["Tangled Mantis Shrimp Cluster"] = "Verhedderter Schwarm riesiger Mantisgarnelen"
L["Teeming Firefin Snapper School"] = "Wimmelnder Feuerflossenschnapperschwarm"
L["Teeming Floating Wreckage"] = true
L["Teeming Oily Blackmouth School"] = "Wimmelnder Schwarm öliger Schwarzmaulfische"
L["Terrorfist"] = "Terrorfaust"
L["Texture"] = "Textur"
--Translation missing 
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = "The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."
L["The Burning Crusade"] = true
--Translation missing 
L["The following %d item(s) have been selected to export:"] = "The following %d item(s) have been selected to export:"
L["The Heartbreaker"] = "Der Herzbrecher"
L["The Horseman's Reins"] = "Die Zügel des Reiters"
--Translation missing 
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = "The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."
--Translation missing 
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = "The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."
L["The name you entered is already being used by another item. Please enter a unique name."] = [=[Der eingegebene Name wird bereits von einem anderen Element verwendet.
Bitte geben Sie einen eindeutigen Namen ein.]=]
--Translation missing 
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = "The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."
--Translation missing 
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = "The number of players it takes to obtain the item. This will lower your chances of obtaining the item."
L["The Pigskin"] = "Football"
--Translation missing 
L["The quest starter item for Reins of the Llothien Prowler"] = "The quest starter item for Reins of the Llothien Prowler"
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = "Das Rarity Optionsmodul wurde deaktiviert. Logge dich aus und aktiviere es im Addon Menü."
--Translation missing 
L["The selected Rarity Item Pack string is invalid."] = "The selected Rarity Item Pack string is invalid."
--Translation missing 
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = "The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."
--Translation missing 
L["The Warbringer will be riding the mount color he has a chance to drop."] = "The Warbringer will be riding the mount color he has a chance to drop."
--Translation missing 
L["There are more holiday items available, but Rarity only reminds you about the first two."] = "There are more holiday items available, but Rarity only reminds you about the first two."
--Translation missing 
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = "These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = "This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."
--Translation missing 
L["This causes Rarity to put a blank line above its tooltip additions."] = "This causes Rarity to put a blank line above its tooltip additions."
--Translation missing 
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = "This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."
L["This item is only available to Alliance players."] = "Dieses Item ist nur für Allianz Spieler verfügbar."
--Translation missing 
L["This item is only available to Horde players."] = "This item is only available to Horde players."
L["This mount is only obtainable by Alliance players"] = "Dieses Mount kann nur von Allianz Spielern erbeutet werden."
L["This mount is only obtainable by Horde players"] = "Dieses Mount kann nur von Horde Spielern erbeutet werden."
--Translation missing 
L["This tab lets you import and export items into and out of your Custom tab."] = "This tab lets you import and export items into and out of your Custom tab."
--Translation missing 
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = "This was a guaranteed drop for players who defeated the encounter when it was current"
L["Tiger Gourami School"] = "Ein Schwarm Tigerguramis"
L["Tiger Gourami Slush"] = "Tigerguramischlick"
L["Time"] = "Zeit"
L["Time spent farming"] = "Zeit mit Suchen verbracht"
L["Timeless Chest"] = "Zeitlose Truhe"
L["Time-Locked Box"] = "Zeitverschlossene Kiste"
L["Time-Lost Figurine"] = "Zeitverlorene Statuette"
L["Timewalker 5-player instance"] = "Zeitwanderungsdungeon "
L["Tin Vein"] = "Zinnader"
L["Tiny Crimson Whelpling"] = "Winziger purpurroter Welpling"
L["Tiny Emerald Whelpling"] = "Winziger smaragdgrüner Welpling"
L["Tiny Fel Engine Key"] = "Winziger Teufelszündschlüssel"
L["Titanium Vein"] = "Titanader"
--Translation missing 
L[ [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=] ] = [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=]
--Translation missing 
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = "To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."
--Translation missing 
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = "To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."
L["Today"] = "Heute"
--Translation missing 
L["Toggles"] = "Toggles"
L["Tol'vir"] = true
L["Tooltip can't be shown in combat"] = "Die Übersicht kann im Kampf nicht angezeigt werden"
L["Toothy's Bucket"] = "Zähnchens Eimer"
L["Torn Invitation"] = "Zerrissene Einladung"
L["Total"] = "Gesamt"
L["Total found"] = "Insgesamt gefunden"
L["Toxic Wasteling"] = "Giftmüllschleimling"
L["Toy or Item"] = "Spielzeug oder Gegenstand"
L["Toys & Items"] = "Spielzeuge & Gegenstände"
L["Track this"] = "Fortschritt verfolgen"
L["Trillium Vein"] = "Trilliumader"
L["Troll"] = true
L["True Iron Deposit"] = "Echteisenvorkommen"
L["Truesilver Deposit"] = "Echtsilbervorkommen"
L["Tundra Icehoof"] = "Tundraeishuf"
--Translation missing 
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = "Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."
--Translation missing 
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = "Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."
--Translation missing 
L["Type of item"] = "Type of item"
--Translation missing 
L["Unable to retrieve item information from the server"] = "Unable to retrieve item information from the server"
L["Unavailable"] = "nicht verfügbar"
L["Undefeated"] = "Unbesiegt"
L["Unknown"] = "Unbekannt"
L["Unlucky"] = "unglücklich"
L["unlucky"] = "unglücklich"
L["Unscathed Egg"] = "Unbeschadetes Ei"
L["Unstable Powder Box"] = "Instabile Puderdose"
L["Unusual Compass"] = "Ungewöhnlicher Kompass"
L["Use your bonus roll for a chance at this item"] = "Benutze deinen Bonuswurf für eine Chance auf diesen Gegenstand"
L["Usually requires a group of around %d players"] = "Benötigt normalerweise eine Gruppe von ungefähr %d Spielern"
L["Valarjar Stormwing"] = "Sturmschwinge der Valarjar"
L["Vengeance"] = "Rache "
--Translation missing 
L["Verbose"] = "Verbose"
L["Vibrating Arcane Crystal"] = "Vibrierender arkaner Kristall"
L["Vile Blood of Draenor"] = "Übles Blut von Draenor"
L["Viscidus Globule"] = "Visciduströpfchen"
L["Void Collar"] = "Leerenhalsband"
L["Vrykul"] = true
L["Warlock"] = "Hexenmeister"
L["Warlords of Draenor"] = true
L["Warm Arcane Crystal"] = "Warmer arkaner Kristall"
L["Warning Sign"] = "Warnschild"
L["Warrior"] = "Krieger"
L["Warsong Direfang"] = "Terrorzahn des Kriegshymnenklans"
L["Waterlogged Wreckage"] = "Treibholzwrackteile"
L["Waterlogged Wreckage Pool"] = "Ein Schwarm Schwimmende Wrackteile"
L["Weebomination"] = "Monstrositätchen"
L["Welcome to Rarity r%d. Your settings have been reset."] = "Willkommen zu Rarity r%d. Deine Einstellungen wurden zurückgesetzt."
--Translation missing 
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = "When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."
--Translation missing 
L["When enabled, Rarity tooltips will include how many attempts you've made."] = "When enabled, Rarity tooltips will include how many attempts you've made."
--Translation missing 
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = "When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."
--Translation missing 
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = "When enabled, Rarity will add obtainable items to game tooltips whenever possible."
--Translation missing 
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = "When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."
--Translation missing 
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = "When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."
--Translation missing 
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = "When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."
L["When on, items marked as Defeated will be hidden from the tooltip."] = "Wenn aktiviert, werden Items die als \"besiegt\" markiert sind im Tooltip versteckt."
--Translation missing 
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = "When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."
--Translation missing 
L["When on, items that have no attempts yet will be hidden from the tooltip."] = "When on, items that have no attempts yet will be hidden from the tooltip."
--Translation missing 
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = "When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."
--Translation missing 
L[ [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=] ] = [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=]
--Translation missing 
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = "When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."
--Translation missing 
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = "When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."
--Translation missing 
L["When on, the Luckiness column will be shown in the main tooltip."] = "When on, the Luckiness column will be shown in the main tooltip."
--Translation missing 
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = "When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."
--Translation missing 
L["When on, the Time column will be shown in the main tooltip."] = "When on, the Time column will be shown in the main tooltip."
--Translation missing 
L["When on, the Zone column will be shown in the main tooltip."] = "When on, the Zone column will be shown in the main tooltip."
--Translation missing 
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = "When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."
--Translation missing 
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = "When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."
L["Whistle of Chromatic Bone"] = "Chromatische Knochenpfeife"
L["White Trillium Deposit"] = "Weißes Trilliumvorkommen"
L["Width"] = "Breite"
L["Wild Dreamrunner"] = "Wilder Traumläufer"
L["Wild Goretusk"] = "Wilder Geiferzahn"
--Translation missing 
L["will be imported"] = "will be imported"
L["Will only drop for druids."] = "Droppt nur für Druiden."
L["Wisp in a Bottle"] = "Irrwisch in der Flasche"
--Translation missing 
L["World Tooltip Options"] = "World Tooltip Options"
L["Worn Troll Dice"] = "Abgenutzte Trollwürfel"
L["Wrath of the Lich King"] = true
L["Wriggling Darkness"] = "Windende Dunkelheit"
L["Yesterday"] = "Gestern"
L["You already defeated %d of them."] = "Du hast bereits %d von ihnen besiegt."
L["You already defeated all of them."] = "Du hast sie bereits alle besiegt."
--Translation missing 
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = "You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."
--Translation missing 
L["You entered a achievement ID that is already being used by another item."] = "You entered a achievement ID that is already being used by another item."
--Translation missing 
L["You entered a creature ID that is already being used by another item."] = "You entered a creature ID that is already being used by another item."
--Translation missing 
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = "You entered a reserved name. Please enter the correct item name as it appears in game."
--Translation missing 
L["You entered a spell ID that is already being used by another item."] = "You entered a spell ID that is already being used by another item."
L["You entered an item ID that is already being used by another item."] = "Du hast eine Item-ID eingegeben, die bereits von einem anderem Item benutzt wird."
--Translation missing 
L["You entered an item ID that is already set as the collected item for something else."] = "You entered an item ID that is already set as the collected item for something else."
--Translation missing 
L["You must enter a creature ID."] = "You must enter a creature ID."
L["You must enter a number larger than 0."] = "Du musst eine Zahl größer als 0 eingeben."
L["You must enter a number larger than 1."] = "Du musst eine Zahl größer als 1 eingeben."
L["You must enter a number larger than or equal to 0."] = "Du musst eine Zahl größer oder gleich 0 eingeben."
L["You must enter a spell ID."] = "Du musst eine Spell-ID eingeben."
L["You must enter a valid number."] = "Du musst eine gültigen Nummer eingeben."
L["You must enter an amount."] = "Du musst eine Anzahl eingeben."
L["You must enter an item ID."] = "Du musst eine Item-ID eingeben."
--Translation missing 
L["You must enter at least one item ID."] = "You must enter at least one item ID."
--Translation missing 
L["You must enter at least one NPC ID."] = "You must enter at least one NPC ID."
--Translation missing 
L["You must enter at least one Statistic ID."] = "You must enter at least one Statistic ID."
--Translation missing 
L["You must enter at least one zone."] = "You must enter at least one zone."
L["Young Talbuk"] = "Junger Talbuk"
L["Young Venomfang"] = "Junger Giftzahn"
L["Zandalari Anklerender"] = "Knöchelreißer der Zandalari"
L["Zandalari Footslasher"] = "Fußschlitzer der Zandalari"
L["Zandalari Kneebiter"] = "Wadenbeißer der Zandalari"
L["Zandalari Toenibbler"] = "Zehenknabberer der Zandalari"
L["Zangar Spore"] = "Zangarspore"
L["Zhevra Lounge Cushion"] = "Zhevrasitzpolster"
L["Zomstrok"] = true
L["Zone"] = true
L["Zones"] = "Zonen"

end

L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "esES")
if L then
L[" (Group)"] = "Grupo"
L["#%d: %d attempt (%.2f%%)"] = "#%d: %d intento (%.2f%%)"
L["#%d: %d attempts (%.2f%%)"] = "#%d: %d intentos (%.2f%%)"
--Translation missing 
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = "%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"
--Translation missing 
L["%d |4zone:zones;"] = "%d |4zone:zones;"
L["%d attempt"] = "%d intento"
L["%d attempt - %.2f%%"] = "%d intento - %.2f%%"
L["%d attempts"] = "%d intentos"
L["%d attempts - %.2f%%"] = "%d intentos - %.2f%%"
L["%d collected - %.2f%%"] = "%d recogido - %.2f%%"
L["%s: %d attempt"] = "%s: %d intento"
L["%s: %d attempt - %.2f%%"] = "%s: %d intento - %.2f%%"
L["%s: %d attempt (%d total)"] = "%s: %d intentos (%d total)"
L["%s: %d attempts"] = "%s: %d intentos"
L["%s: %d attempts - %.2f%%"] = "%s: %d intentos - %.2f%%"
L["%s: %d attempts (%d total)"] = "%s: %d intentos (%d total)"
--Translation missing 
L["%s: %d collected"] = "%s: %d collected"
--Translation missing 
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = "%s: 0/%d attempt so far (%.2f%% - %s)"
--Translation missing 
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = "%s: 0/%d attempts so far (%.2f%% - %s)"
--Translation missing 
L["%s: collection completed!"] = "%s: collection completed!"
--Translation missing 
L["%s: Found after %d attempts!"] = "%s: Found after %d attempts!"
--Translation missing 
L["%s: Found on the first attempt!"] = "%s: Found on the first attempt!"
--Translation missing 
L["(%d/%d attempts)"] = "(%d/%d attempts)"
--Translation missing 
L["(%d/%d collected)"] = "(%d/%d collected)"
--Translation missing 
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = "(Items listed in red could not be found on the server and may not exist. Consider removing them.)"
L["(running in debug mode)"] = "(se ejecuta en modo 'debug')"
--Translation missing 
L["(Warning: item could not be retrieved from server)"] = "(Warning: item could not be retrieved from server)"
L["1 in %d chance"] = "1 posibilidad entre %d"
--Translation missing 
L["10-player Heroic Raid instance (legacy content; not flexible)"] = "10-player Heroic Raid instance (legacy content; not flexible)"
--Translation missing 
L["10-player Raid instance (legacy content; not flexible)"] = "10-player Raid instance (legacy content; not flexible)"
--Translation missing 
L["25-player Event scenario"] = "25-player Event scenario"
--Translation missing 
L["25-player heroic"] = "25-player heroic"
--Translation missing 
L["25-player Heroic Raid instance (legacy content; not flexible)"] = "25-player Heroic Raid instance (legacy content; not flexible)"
--Translation missing 
L["25-player Raid instance (legacy content; not flexible)"] = "25-player Raid instance (legacy content; not flexible)"
--Translation missing 
L["40-player Event raid"] = "40-player Event raid"
--Translation missing 
L["40-player Raid instance (legacy content; not flexible)"] = "40-player Raid instance (legacy content; not flexible)"
--Translation missing 
L["5-player Event instance"] = "5-player Event instance"
--Translation missing 
L["5-player Heroic instance"] = "5-player Heroic instance"
--Translation missing 
L["5-player instance"] = "5-player instance"
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = "Una lista separada por comas de ID de objetos que, utilizados o abiertos, puedan dar este objeto. Utilice Wowhead o un servicio similar para buscar la ID de los objetos."
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = "Introduce las IDs del los NPCs separadas por comas. Utiliza el servicio WowHead o similar para ver las IDs de los NPCs"
--Translation missing 
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = "A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."
--Translation missing 
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = "A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."
--Translation missing 
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = "A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."
--Translation missing 
L[ [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=] ] = [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=]
--Translation missing 
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = "A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."
--Translation missing 
L["A holiday event is available today for %s! Go get it!"] = "A holiday event is available today for %s! Go get it!"
L["Abundant Bloodsail Wreckage"] = "Restos de los Velasangre abundantes"
L["Abundant Firefin Snapper School"] = "Banco de Pargos de Fuego abundantes"
L["Abundant Oily Blackmouth School"] = "Banco de Bocanegras Grasos abundantes"
--Translation missing 
L["Abyss Worm"] = "Abyss Worm"
L["Abyssal Gulper School"] = "Banco de Anguila devoradora abisal"
L["Adamantite Deposit"] = "Depósito de adamantita"
--Translation missing 
L["Added %d |4waypoint:waypoints; to TomTom"] = "Added %d |4waypoint:waypoints; to TomTom"
--Translation missing 
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = "Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."
--Translation missing 
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = "After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."
--Translation missing 
L["Ageless Bronze Drake"] = "Ageless Bronze Drake"
--Translation missing 
L["Ahune"] = "Ahune"
--Translation missing 
L["Ai-Li's Skymirror"] = "Ai-Li's Skymirror"
--Translation missing 
L["Ai-Ran the Shifting Cloud"] = "Ai-Ran the Shifting Cloud"
--Translation missing 
L["Albino Buzzard"] = "Albino Buzzard"
L["Albino Cavefish School"] = "Banco de cavernosos albinos"
--Translation missing 
L["Albino Chimaeraling"] = "Albino Chimaeraling"
L["Algaefin Rockfish School"] = "Banco de aletalgas de roca"
--Translation missing 
L["All players can participate in killing this world boss once per week, regardless of faction"] = "All players can participate in killing this world boss once per week, regardless of faction"
--Translation missing 
L["All raid formats except Raid Finder"] = "All raid formats except Raid Finder"
L["Alliance only"] = "Sólo Alianza"
--Translation missing 
L["Already defeated"] = "Already defeated"
--Translation missing 
L["Already defeated for %s"] = "Already defeated for %s"
L["Already known"] = "Ya conocido"
--Translation missing 
L["an item already exists by this name, so it will not be imported"] = "an item already exists by this name, so it will not be imported"
--Translation missing 
L["an item with the same Item ID already exists, so it will not be imported"] = "an item with the same Item ID already exists, so it will not be imported"
L["Ancient Mana"] = "Maná antiguo"
--Translation missing 
L["and %d |4other zone:other zones;"] = "and %d |4other zone:other zones;"
L["Announce"] = "Anunciar"
L["Announcements"] = "Anuncios"
--Translation missing 
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = "Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."
--Translation missing 
L["Anubisath Idol"] = "Anubisath Idol"
--Translation missing 
L["Any difficulty"] = "Any difficulty"
--Translation missing 
L["Any raid size"] = "Any raid size"
--Translation missing 
L["Any raid size or difficulty"] = "Any raid size or difficulty"
--Translation missing 
L["Appears in the Black Market"] = "Appears in the Black Market"
--Translation missing 
L["Aqua Jewel"] = "Aqua Jewel"
--Translation missing 
L["Arakkoa"] = "Arakkoa"
--Translation missing 
L["Arcano-Shower"] = "Arcano-Shower"
L["Archaeology race"] = "Razas de arqueología"
L["Are you sure you want to delete this item?"] = "¿Estas seguro de que quieres borrar el objeto?"
--Translation missing 
L["Are you sure you want to import the Rarity Item Pack you entered?"] = "Are you sure you want to import the Rarity Item Pack you entered?"
--Translation missing 
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = "Are you sure you want to turn off the Export toggle for all your Custom items?"
--Translation missing 
L["Armored Razorback"] = "Armored Razorback"
L["Armored Razzashi Raptor"] = "Raptor Razzashi acorazado"
--Translation missing 
L["Ash-Covered Horn"] = "Ash-Covered Horn"
L["Ashes of Al'ar"] = "Cenizas de Al'ar"
--Translation missing 
L["Ashleaf Spriteling"] = "Ashleaf Spriteling"
L["Attempts"] = "Intentos"
--Translation missing 
L["Auto"] = "Auto"
--Translation missing 
L["Available starting December 25th"] = "Available starting December 25th"
--Translation missing 
L["Azure Crane Chick"] = "Azure Crane Chick"
L["Azure Whelpling"] = "Vástago azur"
--Translation missing 
L["Battle Horn"] = "Battle Horn"
--Translation missing 
L["Battle Pet"] = "Battle Pet"
--Translation missing 
L["Battle Pets"] = "Battle Pets"
L["Big Love Rocket"] = "Gran cohete de amor"
--Translation missing 
L["Black Barracuda School"] = "Black Barracuda School"
L["Black Trillium Deposit"] = "[Black Trillium Deposit]"
L["Blackbelly Mudfish School"] = "Banco de pezfangos panzanegra"
--Translation missing 
L["Blackflame Daggers"] = "Blackflame Daggers"
--Translation missing 
L["Blackfuse Bombling"] = "Blackfuse Bombling"
--Translation missing 
L["Blackhoof"] = "Blackhoof"
L["Blackrock Deposit"] = "Depósito de roca negra"
L["Blackwater Whiptail School"] = "Banco de Bagre de Aguasnegras"
--Translation missing 
L["Blackwing Banner"] = "Blackwing Banner"
--Translation missing 
L["Blank line before tooltip additions"] = "Blank line before tooltip additions"
--Translation missing 
L["Blazing Rune"] = "Blazing Rune"
--Translation missing 
L["Bleakclaw"] = "Bleakclaw"
--Translation missing 
L["Blessed Seed"] = "Blessed Seed"
--Translation missing 
L["Blight Boar Microphone"] = "Blight Boar Microphone"
--Translation missing 
L["Blighted Spore"] = "Blighted Spore"
L["Blind Lake Sturgeon School"] = "Banco de Esturión ciego de lago"
L["Bloodsail Wreckage"] = "Restos de los Velasangre"
L["Bloodsail Wreckage Pool"] = "Banco de Restos de los Velasangre"
L["Bluefish School"] = "Banco de pezazules"
--Translation missing 
L["Bone Serpent"] = "Bone Serpent"
--Translation missing 
L["Bonkers"] = "Bonkers"
L["Borean Man O' War School"] = "Banco de carabelas boreales"
--Translation missing 
L["Boss Name"] = "Boss Name"
--Translation missing 
L["Bottled Tornado"] = "Bottled Tornado"
L["Brackish Mixed School"] = "Banco mixto salobre"
--Translation missing 
L["Brew Frenzied Emperor Salmon"] = "Brew Frenzied Emperor Salmon"
--Translation missing 
L["Brilliant Phoenix Hawk Feather"] = "Brilliant Phoenix Hawk Feather"
--Translation missing 
L["Brinedeep Bottom-Feeder"] = "Brinedeep Bottom-Feeder"
--Translation missing 
L["Bristling Hellboar"] = "Bristling Hellboar"
--Translation missing 
L["Bronze Proto-Whelp"] = "Bronze Proto-Whelp"
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = "Cargado Bunny Hunter. ¿Te gustaría importar los datos de Bunny Hunter ahora? Desactiva el Bunny Hunter o pincha en Si si no quieres que se te pregunte de nuevo"
--Translation missing 
L["Burgy Blackheart's Handsome Hat"] = "Burgy Blackheart's Handsome Hat"
--Translation missing 
L["Call of the Frozen Blade"] = "Call of the Frozen Blade"
--Translation missing 
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = "Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."
--Translation missing 
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = "Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."
--Translation missing 
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = "Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."
--Translation missing 
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = "Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."
--Translation missing 
L["Can be obtained with a bonus roll"] = "Can be obtained with a bonus roll"
--Translation missing 
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = "Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."
L["Captured Firefly"] = "Luciérnaga capturada"
L["Cat Carrier (Black Tabby)"] = "Jaula para gatos (atigrado negro)"
--Translation missing 
L["Cataclysm"] = "Cataclysm"
--Translation missing 
L["Cavern Moccasin"] = "Cavern Moccasin"
--Translation missing 
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = "Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"
--Translation missing 
L["Chain Pet Leash"] = "Chain Pet Leash"
--Translation missing 
L["Chalice of Secrets"] = "Chalice of Secrets"
--Translation missing 
L["Challenge Mode instance"] = "Challenge Mode instance"
L["Chance"] = "Posibilidad"
L["Chance so far"] = "Posibilidades hasta ahora"
--Translation missing 
L["Chaos Pup"] = "Chaos Pup"
--Translation missing 
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = "Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."
--Translation missing 
L[ [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=] ] = [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=]
--Translation missing 
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = "Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."
--Translation missing 
L["Christoph VonFeasel"] = "Christoph VonFeasel"
--Translation missing 
L["Chromie"] = "Chromie"
--Translation missing 
L["Chuck's Bucket"] = "Chuck's Bucket"
--Translation missing 
L["Classic"] = "Classic"
--Translation missing 
L["Clear All Exports"] = "Clear All Exports"
--Translation missing 
L["Click to switch to this item"] = "Click to switch to this item"
--Translation missing 
L["Click to toggle the progress bar"] = "Click to toggle the progress bar"
--Translation missing 
L["Clockwork Rocket Bot"] = "Clockwork Rocket Bot"
--Translation missing 
L["Close"] = "Close"
--Translation missing 
L["Cloudwing Hippogryph"] = "Cloudwing Hippogryph"
--Translation missing 
L["Clutch of Ji-Kun"] = "Clutch of Ji-Kun"
L["Cobalt Deposit"] = "Depósito de cobalto"
L["Coin of Many Faces"] = "Moneda de muchas caras"
L["Collect %d %s"] = "Recoger %d %s"
L["Collected"] = "Recogido"
L["Collection Complete"] = "Colección completa"
L["Collection complete!"] = "¡Colección completa!"
L["Collection Size"] = "Tamaño de colección"
--Translation missing 
L["Contained in bonus satchels"] = "Contained in bonus satchels"
--Translation missing 
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = "Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."
--Translation missing 
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = "Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."
--Translation missing 
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = "Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."
L["Content Category"] = "Descripción de la categoría"
--Translation missing 
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = "Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."
--Translation missing 
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = "Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."
L["Copper Vein"] = "Filón de cobre"
--Translation missing 
L[ [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=] ] = [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=]
--Translation missing 
L["Core of Hardened Ash"] = "Core of Hardened Ash"
--Translation missing 
L["Corrupted Nest Guardian"] = "Corrupted Nest Guardian"
--Translation missing 
L["Corrupted Thundertail"] = "Corrupted Thundertail"
--Translation missing 
L["Crane Nest"] = "Crane Nest"
L["Crashin' Thrashin' Cannon Controller"] = "Controlador de cañón triturador"
--Translation missing 
L["Crashin' Thrashin' Flyer Controller"] = "Crashin' Thrashin' Flyer Controller"
L["Crashin' Thrashin' Mortar Controller"] = "Controlador de mortero triturador"
--Translation missing 
L["Crashin' Thrashin' Racer Controller"] = "Crashin' Thrashin' Racer Controller"
L["Crashin' Thrashin' Roller Controller"] = "Controlador de apisonadora trituradora"
L["Create a New Item"] = "Crear nuevo objeto"
L["Create a new item to track"] = "Crear un nuevo objeto para rastrear"
--Translation missing 
L["Creature ID"] = "Creature ID"
--Translation missing 
L["Crowded Redbelly Mandarin"] = "Crowded Redbelly Mandarin"
--Translation missing 
L["Crysa"] = "Crysa"
--Translation missing 
L["Crystal of the Void"] = "Crystal of the Void"
L["Ctrl-Click to change sort order"] = "Ctrl+Click para cambiar el orden de clasificación"
--Translation missing 
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = "Ctrl-Click to create the remaining TomTom waypoint(s)."
--Translation missing 
L["Ctrl-Click to create TomTom waypoint(s)."] = "Ctrl-Click to create TomTom waypoint(s)."
--Translation missing 
L["Cupri"] = "Cupri"
L["Curious Wyrmtongue Cache"] = "Alijo Lenguavermis curioso"
--Translation missing 
L["Cursed Queenfish School"] = "Cursed Queenfish School"
--Translation missing 
L["Cursed Spirit"] = "Cursed Spirit"
L["Custom"] = "Personalizado"
--Translation missing 
L["Dandelion Frolicker"] = "Dandelion Frolicker"
--Translation missing 
L["Dark Gazer"] = "Dark Gazer"
L["Dark Iron Deposit"] = "Depósito de Hierro negro"
--Translation missing 
L["Dark Quivering Blob"] = "Dark Quivering Blob"
L["Dark Whelpling"] = "Vástago oscuro"
--Translation missing 
L["Darkmoon Eye"] = "Darkmoon Eye"
L["Data has been imported from Bunny Hunter"] = "Los datos han sido importados desde Bunny Hunter"
--Translation missing 
L["Death Adder Hatchling"] = "Death Adder Hatchling"
--Translation missing 
L["Death Knight"] = "Death Knight"
L["Deathcharger's Reins"] = "Riendas de destrero de la muerte"
--Translation missing 
L["Deathtalon"] = "Deathtalon"
--Translation missing 
L["Debug mode"] = "Debug mode"
L["Debug mode OFF"] = "Modo Debug OFF"
L["Debug mode ON"] = "Modo Debug ON"
--Translation missing 
L["Decahedral Dwarven Dice"] = "Decahedral Dwarven Dice"
L["Deep Sea Monsterbelly School"] = "Banco de tripayuyus de las profundidades"
L["Deepsea Sagefish School"] = "Banco de peces sabiola marfunda"
--Translation missing 
L["Defeat Detection"] = "Defeat Detection"
--Translation missing 
L["Defeated"] = "Defeated"
--Translation missing 
L["Defiled Earth"] = "Defiled Earth"
L["Delete this item"] = "Eliminar este objeto"
--Translation missing 
L["Demon Hunter"] = "Demon Hunter"
--Translation missing 
L["Demonic"] = "Demonic"
L["Determines how this item is obtained."] = "Señalar como se consigue el objeto."
L["Determines what type of item this is."] = "Informe de que tipo de objeto se trata."
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = "Determina si el objeto sólo se puede obtener de la pesca en los charcos. Para que esta opción funcione, los bancos de pesca deben haber sido traducidos al idioma de su juego."
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = "Determina si se debe habilitar el seguimiento para este objeto. Los objetos que están desactivados no aparecerán en la descripción."
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = "Determina si se desea buscar en varias ocasiones este objeto. Si se activa esta opción y encuentra el objeto, Rarity marcará el artículo como no localizado después de unos segundos ."
--Translation missing 
L[ [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=] ] = [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=]
L["Determines which race includes this archaeology project."] = "Define en que raza se encuentra este proyecto de arqueoligía."
L["Deviate Hatchling"] = "Prole descarriada"
--Translation missing 
L["Direflame"] = "Direflame"
--Translation missing 
L["Direhorn Runt"] = "Direhorn Runt"
--Translation missing 
L["Disable for classes"] = "Disable for classes"
L["Disgusting Oozeling"] = "Moquillo desagradable"
--Translation missing 
L["Displacer Meditation Stone"] = "Displacer Meditation Stone"
--Translation missing 
L["Distance"] = "Distance"
--Translation missing 
L["Don Carlos' Famous Hat"] = "Don Carlos' Famous Hat"
--Translation missing 
L["Doomroller"] = "Doomroller"
L["Draenei"] = true
L["Draenor Clans"] = "Clanes de Draenor"
--Translation missing 
L["Draenor Garrison"] = "Draenor Garrison"
L["Dragonfin Angelfish School"] = "Banco de peces ángel aletadragón"
L["Drakum"] = true
--Translation missing 
L["Dreadwalker"] = "Dreadwalker"
--Translation missing 
L["Dripping Strider Egg"] = "Dripping Strider Egg"
--Translation missing 
L["Droplet of Y'Shaarj"] = "Droplet of Y'Shaarj"
--Translation missing 
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = "Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."
--Translation missing 
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = "Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."
--Translation missing 
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = "Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."
--Translation missing 
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = "Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"
--Translation missing 
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = "Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."
--Translation missing 
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = "Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."
--Translation missing 
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = "Dropped by Malygos in The Eye of Eternity (any raid size)"
--Translation missing 
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = "Dropped by Onyxia in Onyxia's Lair (any raid size)"
--Translation missing 
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = "Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"
--Translation missing 
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = "Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"
--Translation missing 
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = "Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"
--Translation missing 
L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = "Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"
L["Dropped from dinosaurs on Isle of Giants"] = "Tirado por dinosaurios en la Isla de los Gigantes"
--Translation missing 
L["Dropped from monsters in Fang'rila"] = "Dropped from monsters in Fang'rila"
L["Drops from a boss requiring a group"] = "Despojado de Jefe de mazmorra"
L["Drops from any mob in a zone"] = "Despojado de cuaquier mob en una zona"
L["Drops from NPC(s)"] = "Despojado de NPC(s)"
--Translation missing 
L["Drudge Remains"] = "Drudge Remains"
--Translation missing 
L["Druid"] = "Druid"
--Translation missing 
L["Dungeon ID"] = "Dungeon ID"
--Translation missing 
L["Dusty Clutch of Eggs"] = "Dusty Clutch of Eggs"
L["Dwarf"] = "Enano"
--Translation missing 
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = "Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."
L["Elementium Geode"] = "Geoda de elementium"
L["Elementium Vein"] = "Filón de elementium"
L["Emperor Salmon School"] = "Banco de salmones emperador"
L["Enable announcements"] = "Activar anuncios"
--Translation missing 
L["Enable Coins"] = "Enable Coins"
--Translation missing 
L["Enable profiling"] = "Enable profiling"
--Translation missing 
L["Enable tooltip additions"] = "Enable tooltip additions"
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = "Activa los anuncios cada vez que se realiza un nuevo intento para cualquier cosa que Rarity este rastreando. También puede habilitar anuncios por objeto, pero este es el cambio principal ."
L["Enables announcements whenever you complete a new attempt toward this item."] = "Activa los anuncios cada vez que se realiza un nuevo intento para este objeto."
--Translation missing 
L["Enter 1 or leave this blank to mark the item as soloable."] = "Enter 1 or leave this blank to mark the item as soloable."
L["Equal odds"] = "Igualdad de probabilidades"
--Translation missing 
L["Error compressing item pack"] = "Error compressing item pack"
--Translation missing 
L["Error encoding item pack"] = "Error encoding item pack"
--Translation missing 
L["Error serializing item pack"] = "Error serializing item pack"
--Translation missing 
L["Essence of the Breeze"] = "Essence of the Breeze"
--Translation missing 
L["Eternal Kiln"] = "Eternal Kiln"
--Translation missing 
L["Eternal Warrior's Sigil"] = "Eternal Warrior's Sigil"
--Translation missing 
L["Everliving Spore"] = "Everliving Spore"
L["Every item ID must be a number greater than 0."] = "Cada ID de objeto debe ser un número mayor que 0."
L["Every NPC ID must be a number greater than 0."] = "Cada NPC ID debe ser un número mayor que 0."
--Translation missing 
L["Every Quest ID must be a number greater than 0."] = "Every Quest ID must be a number greater than 0."
--Translation missing 
L["Experiment 12-B"] = "Experiment 12-B"
--Translation missing 
L["Export"] = "Export"
--Translation missing 
L["Export Rarity Item Pack"] = "Export Rarity Item Pack"
--Translation missing 
L["Export this item"] = "Export this item"
--Translation missing 
L["Eye of Inquisition"] = "Eye of Inquisition"
--Translation missing 
L["Faintly Glowing Flagon of Mead"] = "Faintly Glowing Flagon of Mead"
--Translation missing 
L["Fandral's Seed Pouch"] = "Fandral's Seed Pouch"
L["Fangtooth Herring School"] = "Banco de arenques colmillo"
--Translation missing 
L["Farwater Conch"] = "Farwater Conch"
L["Fat Sleeper School"] = "Banco de Coto gordo"
--Translation missing 
L["Fathom Dweller"] = "Fathom Dweller"
L["Fathom Eel Swarm"] = "Banco de anguilas de las profundidades"
--Translation missing 
L["Feed text"] = "Feed text"
L["Fel Iron Deposit"] = "Depósito de hierro vil"
--Translation missing 
L["Felfly"] = "Felfly"
--Translation missing 
L["Felslate Deposit"] = "Felslate Deposit"
--Translation missing 
L["Felslate Seam"] = "Felslate Seam"
--Translation missing 
L["Felsteel Annihilator"] = "Felsteel Annihilator"
--Translation missing 
L["Felsworn Sentry"] = "Felsworn Sentry"
L["Feltail School"] = "Banco de colaviles"
--Translation missing 
L["Fever of Stormrays"] = "Fever of Stormrays"
L["Fiery Warhorse's Reins"] = "Riendas de caballo de guerra ígneo"
L["Fire Ammonite School"] = "Banco de Amonites de fuego"
L["Firefin Snapper School"] = "Banco de pargos de fuego"
--Translation missing 
L["Firewing"] = "Firewing"
--Translation missing 
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = "Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"
L["Flametalon of Alysrazor"] = "Garfa de fuego de Alysrazor"
L["Floating Debris"] = "Restos flotando"
L["Floating Debris Pool"] = "Banco de Restos flotando"
L["Floating Shipwreck Debris"] = "[Floating Shipwreck Debris]"
L["Floating Wreckage"] = "Restos de un naufragio"
L["Floating Wreckage Pool"] = "Banco de Restos de un naufragio"
--Translation missing 
L["Font"] = "Font"
--Translation missing 
L["Font Size"] = "Font Size"
--Translation missing 
L["Foot Ball"] = "Foot Ball"
L["Fossil"] = "Fosil"
L["Fossilized Raptor"] = "Raptor fosilizado"
L["Found after %d attempts!"] = "Encontrado después de %d intentos"
--Translation missing 
L["Found in: "] = "Found in: "
L["Found on your first attempt!"] = "¡Encontrado en tu primer intento!"
L["Fox Kit"] = "Vulpix"
--Translation missing 
L["Fragment of Anger"] = "Fragment of Anger"
--Translation missing 
L["Fragment of Desire"] = "Fragment of Desire"
--Translation missing 
L["Fragment of Frozen Bone"] = "Fragment of Frozen Bone"
--Translation missing 
L["Fragment of Suffering"] = "Fragment of Suffering"
--Translation missing 
L["Frenzyheart Brew"] = "Frenzyheart Brew"
--Translation missing 
L["Frightened Bush Chicken"] = "Frightened Bush Chicken"
--Translation missing 
L["Fuzzy Green Lounge Cushion"] = "Fuzzy Green Lounge Cushion"
--Translation missing 
L["Gahz'rooki's Summoning Stone"] = "Gahz'rooki's Summoning Stone"
--Translation missing 
L["Gar'lok"] = "Gar'lok"
--Translation missing 
L["Garn Nighthowl"] = "Garn Nighthowl"
--Translation missing 
L["Garn Steelmaw"] = "Garn Steelmaw"
--Translation missing 
L["Garrison Invasion Gold Victory"] = "Garrison Invasion Gold Victory"
--Translation missing 
L["Garrison Invasion Platinum Victory"] = "Garrison Invasion Platinum Victory"
--Translation missing 
L["Gastropod Shell"] = "Gastropod Shell"
L["General"] = true
--Translation missing 
L["General Options"] = "General Options"
L["Ghost Iron Deposit"] = "Depósito de hierro fantasma"
--Translation missing 
L["Giant Coldsnout"] = "Giant Coldsnout"
L["Giant Mantis Shrimp Swarm"] = "Enjambre de gambas mantis gigantes"
L["Giant Sewer Rat"] = "Rata de cloaca gigante"
--Translation missing 
L["Giant Worm Egg"] = "Giant Worm Egg"
--Translation missing 
L["Gibblette the Cowardly"] = "Gibblette the Cowardly"
L["Glacial Salmon School"] = "Banco de salmones glaciales"
L["Glassfin Minnow School"] = "Banco de pezqueñines aletacristal"
--Translation missing 
L["Glimmering Jewel Danio Pool"] = "Glimmering Jewel Danio Pool"
L["Glimmering Treasure Chest"] = "Cofre del tesoro reluciente"
L["Glittering Arcane Crystal"] = "Cristal Arcano relumbrante"
--Translation missing 
L["Glittering Ball of Yarn"] = "Glittering Ball of Yarn"
--Translation missing 
L["Glowing Jade Lungfish"] = "Glowing Jade Lungfish"
--Translation missing 
L["Gluth's Bone"] = "Gluth's Bone"
L["Gold Vein"] = "Filón de oro"
L["Golden Carp School"] = "[Golden Carp School]"
L["Gondar"] = true
--Translation missing 
L["Gooey Sha-ling"] = "Gooey Sha-ling"
--Translation missing 
L["Goren \"Log\" Roller"] = "Goren \"Log\" Roller"
--Translation missing 
L["Great Brewfest Kodo"] = "Great Brewfest Kodo"
L["Greater Sagefish School"] = "Banco de sabiolas superior"
--Translation missing 
L["Greatfather Winter's Tree"] = "Greatfather Winter's Tree"
--Translation missing 
L["Green Helper Box"] = "Green Helper Box"
--Translation missing 
L["Grotesque Statue"] = "Grotesque Statue"
--Translation missing 
L["Group Finder Options"] = "Group Finder Options"
L["Group size"] = "Tamaño del grupo"
--Translation missing 
L["Group(s) found!"] = "Group(s) found!"
--Translation missing 
L["Grow Up"] = "Grow Up"
L["Grumpling"] = "Gruñoncito"
--Translation missing 
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = "Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."
--Translation missing 
L["Gu'chi Swarmling"] = "Gu'chi Swarmling"
--Translation missing 
L["Guk"] = "Guk"
--Translation missing 
L["Gulp Froglet"] = "Gulp Froglet"
L["Gundrak Hatchling"] = "Prole de Gundrak"
--Translation missing 
L["Half-Empty Food Container"] = "Half-Empty Food Container"
--Translation missing 
L["Hardened Shell"] = "Hardened Shell"
--Translation missing 
L["Height"] = "Height"
--Translation missing 
L["Helpful Wikky's Whistle"] = "Helpful Wikky's Whistle"
--Translation missing 
L["Here is a preview of what will (or won't) be imported:"] = "Here is a preview of what will (or won't) be imported:"
--Translation missing 
L["Heroic difficulty"] = "Heroic difficulty"
--Translation missing 
L["Heroic Raid (10-30 players)"] = "Heroic Raid (10-30 players)"
--Translation missing 
L["Heroic Scenario instance"] = "Heroic Scenario instance"
--Translation missing 
L["Heroic, any raid size"] = "Heroic, any raid size"
--Translation missing 
L["Hidden"] = "Hidden"
--Translation missing 
L["Hide defeated items"] = "Hide defeated items"
--Translation missing 
L["Hide high chance items"] = "Hide high chance items"
--Translation missing 
L["Hide items not in your zone"] = "Hide items not in your zone"
--Translation missing 
L["Hide items with no attempts"] = "Hide items with no attempts"
--Translation missing 
L["Hide unavailable items"] = "Hide unavailable items"
--Translation missing 
L["High Priest of Ordos"] = "High Priest of Ordos"
--Translation missing 
L["Highborne"] = "Highborne"
L["Highland Guppy School"] = "Banco de lebistes de las Tierras Altas"
L["Highland Mixed School"] = "Banco mixto de las Tierras Altas"
--Translation missing 
L["Highmountain Elderhorn"] = "Highmountain Elderhorn"
--Translation missing 
L["Highmountain Salmon School"] = "Highmountain Salmon School"
--Translation missing 
L["Highmountain Tauren"] = "Highmountain Tauren"
--Translation missing 
L["Holiday"] = "Holiday"
--Translation missing 
L["Holiday reminders"] = "Holiday reminders"
--Translation missing 
L["Hollow Reed"] = "Hollow Reed"
L["Horde only"] = "Sólo Horda"
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = "Cómo de probable es que aparezca el objeto, expresado como 1 en X, donde X es el número que se introduce aquí ."
L["How many attempts you've made so far."] = "Número de intentos que ha realizado hasta el momento."
L["How many items you need to collect."] = "Número de objetos que necesitas recoger ."
--Translation missing 
L["How many items you've collected so far."] = "How many items you've collected so far."
--Translation missing 
L["Hozen Beach Ball"] = "Hozen Beach Ball"
L["Huge Obsidian Slab"] = "Gran Trozo Obsidiana"
--Translation missing 
L["Hunter"] = "Hunter"
--Translation missing 
L["Hyjal Wisp"] = "Hyjal Wisp"
--Translation missing 
L["Ice Chip"] = "Ice Chip"
L["Identify the Item"] = "Identicar el objeto"
--Translation missing 
L["Imbued Jade Fragment"] = "Imbued Jade Fragment"
L["Imperial Manta Ray School"] = "Banco de mantas raya imperiales"
--Translation missing 
L["Imperial Moth"] = "Imperial Moth"
--Translation missing 
L["Imperial Silkworm"] = "Imperial Silkworm"
--Translation missing 
L["Imp-Master Valessa"] = "Imp-Master Valessa"
--Translation missing 
L["Import"] = "Import"
--Translation missing 
L["Import Rarity Item Pack"] = "Import Rarity Item Pack"
--Translation missing 
L["Import/Export"] = "Import/Export"
--Translation missing 
L["imported successfully"] = "imported successfully"
L["Incendicite Mineral Vein"] = "Filón de mineral de incendicita"
L["Indurium Mineral Vein"] = "Filón de mineral de indurio"
--Translation missing 
L["Install TomTom to enable waypoint creation."] = "Install TomTom to enable waypoint creation."
--Translation missing 
L["Instance Difficulty"] = "Instance Difficulty"
--Translation missing 
L["Instant Arcane Sanctum Security Kit"] = "Instant Arcane Sanctum Security Kit"
L["Invincible's Reins"] = "Riendas de Invencible"
L["Iron Deposit"] = "Depósito de hierro"
--Translation missing 
L["Ironbound Collar"] = "Ironbound Collar"
--Translation missing 
L["Ironhoof Destroyer"] = "Ironhoof Destroyer"
L["Item ID"] = "ID del objeto"
--Translation missing 
L["Item ID to Collect"] = "Item ID to Collect"
L["Items to Use"] = "Objetos a utilizar"
L["Jade Lungfish School"] = "Banco de peces alveolares de jade"
--Translation missing 
L["Jadefire Spirit"] = "Jadefire Spirit"
--Translation missing 
L["Jademist Dancer"] = "Jademist Dancer"
L["Jawless Skulker School"] = "Banco de Vagador mermaquija"
--Translation missing 
L["Jeremy Feasel"] = "Jeremy Feasel"
L["Jewel Danio School"] = "Banco de danios enjoyados"
--Translation missing 
L["Jewel of Maddening Whispers"] = "Jewel of Maddening Whispers"
--Translation missing 
L["Ji-Kun Hatchling"] = "Ji-Kun Hatchling"
--Translation missing 
L["Jingling Bell"] = "Jingling Bell"
--Translation missing 
L["Kael'thas Sunstrider"] = "Kael'thas Sunstrider"
--Translation missing 
L["Kaldorei Light Globe"] = "Kaldorei Light Globe"
--Translation missing 
L["Kal'tik the Blight"] = "Kal'tik the Blight"
--Translation missing 
L["Kang's Bindstone"] = "Kang's Bindstone"
L["Khorium Vein"] = "Filón de korio"
--Translation missing 
L["Kill Statistic IDs"] = "Kill Statistic IDs"
--Translation missing 
L["Knockoff Blingtron"] = "Knockoff Blingtron"
--Translation missing 
L["Kor'kron Juggernaut"] = "Kor'kron Juggernaut"
--Translation missing 
L["Kovok"] = "Kovok"
L["Krasarang Paddlefish School"] = "Banco de poliodóntidos de Krasarang"
L["Kyparite Deposit"] = "Depósito de kyparita"
--Translation missing 
L["Land Shark"] = "Land Shark"
L["Large Obsidian Chunk"] = "Gran Trozo obsidiana"
--Translation missing 
L["Large Pool of Brew Frenzied Emperor Salmon"] = "Large Pool of Brew Frenzied Emperor Salmon"
--Translation missing 
L["Large Pool of Crowded Redbelly Mandarin"] = "Large Pool of Crowded Redbelly Mandarin"
--Translation missing 
L["Large Pool of Glimmering Jewel Danio Pool"] = "Large Pool of Glimmering Jewel Danio Pool"
--Translation missing 
L["Large Pool of Glowing Jade Lungfish"] = "Large Pool of Glowing Jade Lungfish"
--Translation missing 
L["Large Pool of Sha-Touched Spinefish"] = "Large Pool of Sha-Touched Spinefish"
--Translation missing 
L["Large Pool of Tiger Gourami Slush"] = "Large Pool of Tiger Gourami Slush"
--Translation missing 
L["Large Swarm of Migrated Reef Octopus"] = "Large Swarm of Migrated Reef Octopus"
--Translation missing 
L["Large Swarm of Panicked Paddlefish"] = "Large Swarm of Panicked Paddlefish"
--Translation missing 
L["Large Tangled Mantis Shrimp Cluster"] = "Large Tangled Mantis Shrimp Cluster"
--Translation missing 
L["Last Month"] = "Last Month"
--Translation missing 
L["Last Week"] = "Last Week"
--Translation missing 
L["Left"] = "Left"
--Translation missing 
L["Legion"] = "Legion"
L["Lesser Bloodstone Deposit"] = "Depósito de sangrita inferior"
L["Lesser Firefin Snapper School"] = "[Lesser Firefin Snapper School]"
L["Lesser Floating Debris"] = "[Lesser Floating Debris]"
L["Lesser Oily Blackmouth School"] = "[Lesser Oily Blackmouth School]"
L["Lesser Sagefish School"] = "[Lesser Sagefish School]"
--Translation missing 
L["Leviathan Egg"] = "Leviathan Egg"
--Translation missing 
L["Ley Spider Eggs"] = "Ley Spider Eggs"
--Translation missing 
L["Leystone Deposit"] = "Leystone Deposit"
--Translation missing 
L["Leystone Seam"] = "Leystone Seam"
--Translation missing 
L["Leywoven Flying Carpet"] = "Leywoven Flying Carpet"
--Translation missing 
L["Life-Binder's Handmaiden"] = "Life-Binder's Handmaiden"
L["Likelihood"] = "Probabilidad"
--Translation missing 
L["Lil' Bling"] = "Lil' Bling"
--Translation missing 
L["Living Infernal Core"] = "Living Infernal Core"
--Translation missing 
L["Living Sandling"] = "Living Sandling"
L["Loaded (running in debug mode)"] = "Cargado (se ejecuta en modo 'debug')"
--Translation missing 
L["Loaded Gnomish Dice"] = "Loaded Gnomish Dice"
L["Loading"] = "Carga"
--Translation missing 
L["Locked"] = "Locked"
--Translation missing 
L["Looking For Raid (10-30 players)"] = "Looking For Raid (10-30 players)"
L["Luckiness"] = "Fortuna"
L["Lucky"] = "Afortunado"
L["lucky"] = "afortuado"
L["Lucky if you obtain in %d or less"] = "Serás afortunado si lo encuentras en %d intentos o menos"
--Translation missing 
L["Lump of Coal"] = "Lump of Coal"
--Translation missing 
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = "Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."
--Translation missing 
L["Mage"] = "Mage"
--Translation missing 
L["Magnataur Hunting Horn"] = "Magnataur Hunting Horn"
--Translation missing 
L["Major Nanners"] = "Major Nanners"
--Translation missing 
L["Mantid"] = "Mantid"
--Translation missing 
L["Mark of Flame"] = "Mark of Flame"
L["Method of obtaining"] = "Forma de obtención"
--Translation missing 
L["Midnight's Eternal Reins"] = "Midnight's Eternal Reins"
L["Mimiron's Head"] = "Cabeza de Mimiron"
L["Minimal"] = "Mínimo"
L["Minion of Grumpus"] = "Esbirro de Gruñoncio"
--Translation missing 
L["MiniZep Controller"] = "MiniZep Controller"
--Translation missing 
L["Mirecroak"] = "Mirecroak"
--Translation missing 
L["Mists of Pandaria"] = "Mists of Pandaria"
L["Mithril Deposit"] = "Depósito de mitril"
--Translation missing 
L["Mogu"] = "Mogu"
L["Mojo"] = true
--Translation missing 
L["Monk"] = "Monk"
--Translation missing 
L["Moon Moon"] = "Moon Moon"
--Translation missing 
L["Moonfang"] = "Moonfang"
--Translation missing 
L["Moonfang Shroud"] = "Moonfang Shroud"
--Translation missing 
L["Moonfang's Paw"] = "Moonfang's Paw"
L["Moonglow Cuttlefish School"] = "Banco de sepias resplandor lunar"
--Translation missing 
L["Mossgill Perch School"] = "Mossgill Perch School"
L["Mount"] = "Montura"
--Translation missing 
L["Mountain Panda"] = "Mountain Panda"
L["Mountain Trout School"] = "Banco de truchas de montaña"
L["Mounts"] = "Monturas"
L["Mr. Grubbs"] = "Sr. Oruga"
L["Mr. Pinchy"] = "Tenacitas"
--Translation missing 
L["Mr. Smite's Brass Compass"] = "Mr. Smite's Brass Compass"
--Translation missing 
L["Muckbreaths's Bucket"] = "Muckbreaths's Bucket"
L["Muddy Churning Water"] = "[Muddy Churning Water]"
L["Mudfish School"] = "Banco de peces barro"
L["Musselback Sculpin School"] = "Banco de peces escorpión mejillón"
--Translation missing 
L["Muyani"] = "Muyani"
L["Mysterious Camel Figurine"] = "Figurilla de camello misteriosa"
--Translation missing 
L["Mythic 5-player instance"] = "Mythic 5-player instance"
--Translation missing 
L["Mythic difficulty"] = "Mythic difficulty"
--Translation missing 
L["Mythic Raid (20 player)"] = "Mythic Raid (20 player)"
L["Nerubian"] = "Nerubiano"
--Translation missing 
L["Nerubian Relic"] = "Nerubian Relic"
--Translation missing 
L["Nessos the Oracle"] = "Nessos the Oracle"
L["Nethercite Deposit"] = "Depósito de abisalita"
--Translation missing 
L["Netherfist"] = "Netherfist"
--Translation missing 
L["Netherspace Portal-Stone"] = "Netherspace Portal-Stone"
L["Nettlefish School"] = "Banco de medusas"
L["New item"] = "Nuevo objeto"
L["Night Elf"] = "Elfo de la noche"
--Translation missing 
L["Nightmare Bell"] = "Nightmare Bell"
--Translation missing 
L["Nightmare Whelpling"] = "Nightmare Whelpling"
--Translation missing 
L["Nightshade Sproutling"] = "Nightshade Sproutling"
--Translation missing 
L[ [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=] ] = [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=]
L["None"] = "Ninguno"
--Translation missing 
L["None (not in an instance)"] = "None (not in an instance)"
L["Normal"] = true
--Translation missing 
L["Normal Raid (10-30 players)"] = "Normal Raid (10-30 players)"
--Translation missing 
L["not imported"] = "not imported"
L["NPCs"] = true
L["Obsidium Deposit"] = "Depósito de obsidium"
--Translation missing 
L["Obtained Achievement ID"] = "Obtained Achievement ID"
L["Obtained After %d Attempts"] = "Obtenido después de %d intentos"
--Translation missing 
L["Obtained as a rare project for the Fossil branch of archaeology"] = "Obtained as a rare project for the Fossil branch of archaeology"
--Translation missing 
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = "Obtained as a very rare project for the Tol'vir branch of archaeology"
L["Obtained as an archaeology project"] = "Obtenido de un descubrimiento arqueológico"
--Translation missing 
L["Obtained by collecting a number of items"] = "Obtained by collecting a number of items"
L["Obtained by fishing"] = "Obtenido pescando"
--Translation missing 
L["Obtained by fishing in any water in Ironforge"] = "Obtained by fishing in any water in Ironforge"
--Translation missing 
L["Obtained by fishing in any water in Orgrimmar"] = "Obtained by fishing in any water in Orgrimmar"
--Translation missing 
L["Obtained by fishing in pools located in Terrokar Forest"] = "Obtained by fishing in pools located in Terrokar Forest"
L["Obtained by mining"] = "Obtenido minando"
L["Obtained by mining Elementium Vein"] = "Se obtiene por extracción del Filón de elementium"
--Translation missing 
L["Obtained by opening Crane Nests on the Timeless Isle"] = "Obtained by opening Crane Nests on the Timeless Isle"
L["Obtained by opening Snow Mound in Frostfire Ridge"] = "Obtenido al abrir los Montículos de nieve en Cresta Fuego Glacial"
--Translation missing 
L["Obtained by opening Timeless Chests on the Timeless Isle"] = "Obtained by opening Timeless Chests on the Timeless Isle"
L["Obtained by using an item or opening a container"] = "Obtenido al usar un objeto o abrir un recipiente"
L["Obtained On Your First Attempt"] = "Obtenido en tu primer intento"
--Translation missing 
L["Obtained Quest ID"] = "Obtained Quest ID"
--Translation missing 
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = "Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"
--Translation missing 
L["Odd Polished Stone"] = "Odd Polished Stone"
L["Ogre"] = "Ogro"
L["Oil Spill"] = "Vertido de petróleo"
L["Oily Abyssal Gulper School"] = "Banco aceitoso de Anguila devoradora abisal"
L["Oily Blackmouth School"] = "Banco de bocanegras grasos"
L["Oily Sea Scorpion School"] = "Banco aceitoso de Escorpina"
--Translation missing 
L["Old Crafty"] = "Old Crafty"
--Translation missing 
L["Old Ironjaw"] = "Old Ironjaw"
--Translation missing 
L["Old Man Barlo"] = "Old Man Barlo"
--Translation missing 
L["Ominous Flame"] = "Ominous Flame"
--Translation missing 
L["Ominous Pile of Snow"] = "Ominous Pile of Snow"
--Translation missing 
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = "One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = "Una de las zonas o subzonas que ha introducido (%s) no se puede encontrar. Compruebe que la ha escrito correctamente y de que sea en Inglés americano o en el idioma local de su juego."
--Translation missing 
L["Only announce when found"] = "Only announce when found"
--Translation missing 
L["Only Raid Finder difficulty"] = "Only Raid Finder difficulty"
L["Ooze Covered Gold Vein"] = "Filón de oro cubierto de moco"
L["Ooze Covered Mithril Deposit"] = "Filón de mitril cubierto de moco"
L["Ooze Covered Rich Thorium Vein"] = "Filón de torio enriquecido cubierto de moco"
L["Ooze Covered Silver Vein"] = "Filón de plata cubierto de moco"
L["Ooze Covered Thorium Vein"] = "Filón de torio cubierto de moco"
L["Ooze Covered Truesilver Deposit"] = "Filón de veraplata cubierta de moco"
--Translation missing 
L["Options"] = "Options"
--Translation missing 
L["Orb of the Sin'dorei"] = "Orb of the Sin'dorei"
L["Orc"] = "Orco"
--Translation missing 
L["Orphaned Felbat"] = "Orphaned Felbat"
L["Other"] = "Otro"
--Translation missing 
L["Other Requirements"] = "Other Requirements"
--Translation missing 
L["Overcomplicated Controller"] = "Overcomplicated Controller"
--Translation missing 
L["Paladin"] = "Paladin"
--Translation missing 
L["Pandaren"] = "Pandaren"
--Translation missing 
L["Pandaren Firework Launcher"] = "Pandaren Firework Launcher"
--Translation missing 
L["Panflute of Pandaria"] = "Panflute of Pandaria"
L["Parrot Cage (Green Wing Macaw)"] = "Jaula de loro (papagayo rojo)"
L["Parrot Cage (Hyacinth Macaw)"] = "Jaula de loro (papagayo azul)"
--Translation missing 
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = "Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."
L["Patch of Elemental Water"] = "[Patch of Elemental Water]"
--Translation missing 
L["Periwinkle Calf"] = "Periwinkle Calf"
L["Phoenix Hatchling"] = "Prole de fénix"
--Translation missing 
L["Pineapple Lounge Cushion"] = "Pineapple Lounge Cushion"
--Translation missing 
L["Play a sound when groups are found"] = "Play a sound when groups are found"
--Translation missing 
L["Players have a personal loot chance to obtain this item."] = "Players have a personal loot chance to obtain this item."
L["Please enter a comma-separated list of item IDs."] = "Por favor, introduzca una lista separada por comas de las ID de los objetos."
L["Please enter a comma-separated list of NPC IDs."] = "Por favor, introduzca una lista separada por comas de las IDs de los NPC ."
--Translation missing 
L["Please enter a comma-separated list of Quest IDs."] = "Please enter a comma-separated list of Quest IDs."
--Translation missing 
L["Please enter a comma-separated list of Statistic IDs."] = "Please enter a comma-separated list of Statistic IDs."
L["Please enter a comma-separated list of zones."] = "Por favor, introduzca una lista separada por comas de las zonas."
L["Pool of Fire"] = "Piscina de fuego"
--Translation missing 
L["Porcupette"] = "Porcupette"
--Translation missing 
L["Priest"] = "Priest"
--Translation missing 
L["Primal Egg"] = "Primal Egg"
--Translation missing 
L["Primary tooltip hide delay"] = "Primary tooltip hide delay"
--Translation missing 
L["Primary tooltip scale"] = "Primary tooltip scale"
L["Profile modified, rebooting"] = "Perfil modificado, reiniciando"
--Translation missing 
L["Profiling OFF"] = "Profiling OFF"
--Translation missing 
L["Profiling ON"] = "Profiling ON"
L["Progress"] = "Progreso"
--Translation missing 
L["Progress Bar"] = "Progress Bar"
--Translation missing 
L["Puddle Terror"] = "Puddle Terror"
--Translation missing 
L["Pugg"] = "Pugg"
--Translation missing 
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = "Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."
L["Pure Saronite Deposit"] = "Deposito de Saronita Puro"
L["Pure Water"] = "Agua pura"
--Translation missing 
L["Put \"Rarity:\" on a separate line"] = "Put \"Rarity:\" on a separate line"
--Translation missing 
L["Putricide's Alchemy Supplies"] = "Putricide's Alchemy Supplies"
--Translation missing 
L["Pygmy Direhorn"] = "Pygmy Direhorn"
L["Pyrite Deposit"] = "Depósito de pirita"
--Translation missing 
L["Quest ID"] = "Quest ID"
--Translation missing 
L["Quivering Blob"] = "Quivering Blob"
--Translation missing 
L["Raid Finder instance (legacy content; fixed at 25 players)"] = "Raid Finder instance (legacy content; fixed at 25 players)"
--Translation missing 
L["Raid Finder or Flexible difficulty"] = "Raid Finder or Flexible difficulty"
--Translation missing 
L["Rarity has %d |4coordinate:coordinates; for this item."] = "Rarity has %d |4coordinate:coordinates; for this item."
--Translation missing 
L["Rarity is loading..."] = "Rarity is loading..."
--Translation missing 
L["Rarity Item Pack String"] = "Rarity Item Pack String"
--Translation missing 
L["Rarity Tooltip Options"] = "Rarity Tooltip Options"
L["Rarity: "] = true
L["Razzashi Hatchling"] = "Prole Razzashi"
--Translation missing 
L["Red Goren Egg"] = "Red Goren Egg"
--Translation missing 
L["Red Helper Box"] = "Red Helper Box"
L["Red Qiraji Resonating Crystal"] = "Cristal resonador qiraji rojo"
L["Redbelly Mandarin School"] = "Banco de mandarines panzarroja"
--Translation missing 
L["Red-Hot Coal"] = "Red-Hot Coal"
L["Reef Octopus Swarm"] = "Banco de pulpos de arrecife"
--Translation missing 
L["Reins of the Amber Primordial Direhorn"] = "Reins of the Amber Primordial Direhorn"
--Translation missing 
L["Reins of the Astral Cloud Serpent"] = "Reins of the Astral Cloud Serpent"
L["Reins of the Azure Drake"] = "Riendas del draco azur"
--Translation missing 
L["Reins of the Black Primal Raptor"] = "Reins of the Black Primal Raptor"
--Translation missing 
L["Reins of the Blazing Drake"] = "Reins of the Blazing Drake"
L["Reins of the Blue Drake"] = "Riendas del draco azul"
L["Reins of the Blue Proto-Drake"] = "Riendas del draco azul"
--Translation missing 
L["Reins of the Bone-White Primal Raptor"] = "Reins of the Bone-White Primal Raptor"
--Translation missing 
L["Reins of the Cobalt Primordial Direhorn"] = "Reins of the Cobalt Primordial Direhorn"
--Translation missing 
L["Reins of the Crimson Water Strider"] = "Reins of the Crimson Water Strider"
L["Reins of the Drake of the North Wind"] = "Riendas del draco del Viento del Norte"
L["Reins of the Drake of the South Wind"] = "Riendas del draco del Viento del Sur"
--Translation missing 
L["Reins of the Grand Black War Mammoth"] = "Reins of the Grand Black War Mammoth"
--Translation missing 
L["Reins of the Green Primal Raptor"] = "Reins of the Green Primal Raptor"
L["Reins of the Green Proto-Drake"] = "Riendas del protodraco verde"
L["Reins of the Grey Riding Camel"] = "Riendas del camello de montar gris"
--Translation missing 
L["Reins of the Heavenly Onyx Cloud Serpent"] = "Reins of the Heavenly Onyx Cloud Serpent"
L["Reins of the Infinite Timereaver"] = "Riendas del atracador del Tiempo Infinito"
--Translation missing 
L["Reins of the Jade Primordial Direhorn"] = "Reins of the Jade Primordial Direhorn"
L["Reins of the Onyxian Drake"] = "Riendas del draco de Onyxia"
L["Reins of the Raven Lord"] = "Riendas del Lord Cuervo"
--Translation missing 
L["Reins of the Slate Primordial Direhorn"] = "Reins of the Slate Primordial Direhorn"
--Translation missing 
L["Reins of the Thundering Cobalt Cloud Serpent"] = "Reins of the Thundering Cobalt Cloud Serpent"
--Translation missing 
L["Reins of the Thundering Onyx Cloud Serpent"] = "Reins of the Thundering Onyx Cloud Serpent"
L["Reins of the Vitreous Stone Drake"] = "Riendas del draco de piedra vítreo"
L["Reins of the White Polar Bear"] = "Riendas del oso polar blanco"
--Translation missing 
L["Remains of a Blood Beast"] = "Remains of a Blood Beast"
L["Repeatable"] = "Repetible"
--Translation missing 
L["Required for %s"] = "Required for %s"
L["Requires a pool"] = "Requiere nodo"
--Translation missing 
L["Requires Pickpocketing"] = "Requires Pickpocketing"
L["Rich Adamantite Deposit"] = "Depósito rico en adamantita"
L["Rich Blackrock Deposit"] = "Depósito rico en roca negra"
L["Rich Cobalt Deposit"] = "Depósito de cobalto rico"
L["Rich Elementium Vein"] = "Filón de elementium rico"
--Translation missing 
L["Rich Felslate Deposit"] = "Rich Felslate Deposit"
L["Rich Ghost Iron Deposit"] = "Depósito de hierro fantasma rico"
L["Rich Kyparite Deposit"] = "Depósito de kyparita rico"
--Translation missing 
L["Rich Leystone Deposit"] = "Rich Leystone Deposit"
L["Rich Obsidium Deposit"] = "Depósito de obsidium rico"
L["Rich Pyrite Deposit"] = "Depósito de pirita rico"
L["Rich Saronite Deposit"] = "Depósito de saronita rico"
L["Rich Thorium Vein"] = "Filón de torio enriquecido"
L["Rich Trillium Vein"] = "Filón de trillium enriquecido"
L["Rich True Iron Deposit"] = "Depósito rico en verahierro"
--Translation missing 
L["Riding Turtle"] = "Riding Turtle"
--Translation missing 
L["Right"] = "Right"
L["Right-Aligned"] = "Alineado a la derecha"
--Translation missing 
L["Rime of the Time-Lost Mariner"] = "Rime of the Time-Lost Mariner"
--Translation missing 
L["Rogue"] = "Rogue"
--Translation missing 
L["Rotten Helper Box"] = "Rotten Helper Box"
--Translation missing 
L["Ruby Droplet"] = "Ruby Droplet"
--Translation missing 
L["Rukdug"] = "Rukdug"
--Translation missing 
L["Runescale Koi School"] = "Runescale Koi School"
L["Sack of Spectral Spiders"] = "Saco de arañas espectrales"
--Translation missing 
L["Safari Lounge Cushion"] = "Safari Lounge Cushion"
L["Sagefish School"] = "Banco de sabiolas"
--Translation missing 
L["Sahn Tidehunter"] = "Sahn Tidehunter"
--Translation missing 
L["Salyin Battle Banner"] = "Salyin Battle Banner"
--Translation missing 
L["Salyin Warscout"] = "Salyin Warscout"
L["Saronite Deposit"] = "Depósito de saronita"
--Translation missing 
L["Sassy Imp"] = "Sassy Imp"
--Translation missing 
L["Satyr Charm"] = "Satyr Charm"
L["Savage Cub"] = "Cachorro salvaje"
L["Savage Piranha Pool"] = "Banco de Pirañas salvajes"
--Translation missing 
L["Scale"] = "Scale"
--Translation missing 
L["Scenario instance"] = "Scenario instance"
L["Scepter of Azj'Aqir"] = "Cetro de Azj'Aqir"
L["School of Darter"] = "Banco de dardos"
L["School of Deviate Fish"] = "Banco de peces descarriados"
L["School of Tastyfish"] = "Banco de pezricos"
L["Schooner Wreckage"] = "Restos de goleta"
L["Schooner Wreckage Pool"] = "Banco de Restos de goleta"
L["Scorched Stone"] = "Piedra agostada"
--Translation missing 
L["Scraps"] = "Scraps"
--Translation missing 
L["Sea Calf"] = "Sea Calf"
L["Sea Pony"] = "Poni de mar"
L["Sea Scorpion School"] = "Banco de Escorpina"
L["Sea Turtle"] = "Tortuga marina"
--Translation missing 
L["Seaborne Spore"] = "Seaborne Spore"
--Translation missing 
L["Secondary tooltip display"] = "Secondary tooltip display"
L["Servant of Demidos"] = "Sirviente de Demidos"
--Translation missing 
L["Servant's Bell"] = "Servant's Bell"
--Translation missing 
L["Session"] = "Session"
--Translation missing 
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = "Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."
--Translation missing 
L["Shadowhide Pearltusk"] = "Shadowhide Pearltusk"
--Translation missing 
L["Shaman"] = "Shaman"
--Translation missing 
L["Shard of Supremus"] = "Shard of Supremus"
--Translation missing 
L["Sha-Touched Spinefish"] = "Sha-Touched Spinefish"
--Translation missing 
L["Shell of Tide-Calling"] = "Shell of Tide-Calling"
--Translation missing 
L["Shift-Click to link your progress to chat"] = "Shift-Click to link your progress to chat"
--Translation missing 
L["Shift-Click to open options"] = "Shift-Click to open options"
L["Shipwreck Debris"] = "Desechos de Naufragio"
--Translation missing 
L["Show anchor"] = "Show anchor"
--Translation missing 
L["Show attempts in tooltips"] = "Show attempts in tooltips"
--Translation missing 
L["Show auto refresh checkbox"] = "Show auto refresh checkbox"
--Translation missing 
L["Show category icons"] = "Show category icons"
L["Show Icon"] = "Mostrar icono"
--Translation missing 
L["Show Luckiness column"] = "Show Luckiness column"
L["Show minimap icon"] = "Mostrar icono en minimapa"
L["Show Text"] = "Mostrar texto"
--Translation missing 
L["Show Time column"] = "Show Time column"
--Translation missing 
L["Show Zone column"] = "Show Zone column"
L["Silver Vein"] = "Filón de plata"
--Translation missing 
L["Silver-Plated Turkey Shooter"] = "Silver-Plated Turkey Shooter"
L["Since last drop"] = "Desde el último despojo"
--Translation missing 
L["Sira's Extra Cloak"] = "Sira's Extra Cloak"
--Translation missing 
L["Skrillix"] = "Skrillix"
--Translation missing 
L["Skull of a Frozen Whelp"] = "Skull of a Frozen Whelp"
--Translation missing 
L["Skunky Alemental"] = "Skunky Alemental"
--Translation missing 
L["Sky-Bo"] = "Sky-Bo"
--Translation missing 
L["Skyshard"] = "Skyshard"
--Translation missing 
L["Slithershock Elver"] = "Slithershock Elver"
L["Small Obsidian Chunk"] = "Pequeño fragmento de obsidiana"
L["Small Thorium Vein"] = "Filón pequeño de torio"
L["Smashum Grabb"] = "Machaki Yarrastre"
--Translation missing 
L["Smelly Gravestone"] = "Smelly Gravestone"
--Translation missing 
L["Smoky Direwolf"] = "Smoky Direwolf"
L["Smoldering Egg of Millagazor"] = "Huevo humeante de Millagazor"
--Translation missing 
L["Snarly's Bucket"] = "Snarly's Bucket"
L["Snow Mound"] = "Montículo de nieve"
--Translation missing 
L["Snowman Kit"] = "Snowman Kit"
--Translation missing 
L["Snowy Panda"] = "Snowy Panda"
--Translation missing 
L["Solar Spirehawk"] = "Solar Spirehawk"
--Translation missing 
L["Son of Animus"] = "Son of Animus"
--Translation missing 
L["Son of Galleon's Saddle"] = "Son of Galleon's Saddle"
--Translation missing 
L["Sorting by category, then name"] = "Sorting by category, then name"
--Translation missing 
L["Sorting by difficulty"] = "Sorting by difficulty"
--Translation missing 
L["Sorting by name"] = "Sorting by name"
--Translation missing 
L["Sorting by percent complete"] = "Sorting by percent complete"
--Translation missing 
L["Sorting by zone"] = "Sorting by zone"
L["Sparse Firefin Snapper School"] = "[Sparse Firefin Snapper School]"
L["Sparse Oily Blackmouth School"] = "[Sparse Oily Blackmouth School]"
L["Sparse Schooner Wreckage"] = "[Sparse Schooner Wreckage]"
--Translation missing 
L["Spawn of Horridon"] = "Spawn of Horridon"
--Translation missing 
L["Special case"] = "Special case"
--Translation missing 
L["Spectral Bell"] = "Spectral Bell"
L["Spell ID"] = "ID de hechizo"
--Translation missing 
L["Spiky Collar"] = "Spiky Collar"
--Translation missing 
L["Spineclaw Crab"] = "Spineclaw Crab"
L["Spinefish School"] = "Banco de peces espinosos"
L["Sporefish School"] = "Banco de pecesporas"
L["Sprite Darter Egg"] = "Huevo de duende dardo"
L["Statistics"] = "Estadísticas"
L["Steam Pump Flotsam"] = "Restos flotantes de bomba de vapor"
--Translation missing 
L["Sting Ray Pup"] = "Sting Ray Pup"
L["Stonescale Eel Swarm"] = "Banco de anguilas escama pétrea"
--Translation missing 
L["Stormforged Rune"] = "Stormforged Rune"
--Translation missing 
L["Strand Crawler"] = "Strand Crawler"
L["Strange Pool"] = "Banco extraño"
--Translation missing 
L["Sultry Grimoire"] = "Sultry Grimoire"
--Translation missing 
L["Sun Sproutling"] = "Sun Sproutling"
--Translation missing 
L["Sunblade Rune of Activation"] = "Sunblade Rune of Activation"
--Translation missing 
L["Sunfire Kaliri"] = "Sunfire Kaliri"
--Translation missing 
L["Sunfur Panda"] = "Sunfur Panda"
--Translation missing 
L["Swarm of Panicked Paddlefish"] = "Swarm of Panicked Paddlefish"
--Translation missing 
L["Swift Brewfest Ram"] = "Swift Brewfest Ram"
L["Swift White Hawkstrider"] = "Halcón zancudo blanco presto"
L["Swift Zulian Panther"] = "Pantera Zulian presta"
--Translation missing 
L["Syd the Squid"] = "Syd the Squid"
--Translation missing 
L["Tainted Core"] = "Tainted Core"
--Translation missing 
L["Tainted Maulclaw"] = "Tainted Maulclaw"
--Translation missing 
L["Take screenshots"] = "Take screenshots"
--Translation missing 
L["Tangled Mantis Shrimp Cluster"] = "Tangled Mantis Shrimp Cluster"
L["Teeming Firefin Snapper School"] = "Banco de pargos de fuego abundante"
L["Teeming Floating Wreckage"] = "[Teeming Floating Wreckage]"
L["Teeming Oily Blackmouth School"] = "Banco de bocanegras grasos abundante"
--Translation missing 
L["Terrorfist"] = "Terrorfist"
L["Texture"] = "Textura"
--Translation missing 
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = "The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."
--Translation missing 
L["The Burning Crusade"] = "The Burning Crusade"
--Translation missing 
L["The following %d item(s) have been selected to export:"] = "The following %d item(s) have been selected to export:"
--Translation missing 
L["The Heartbreaker"] = "The Heartbreaker"
L["The Horseman's Reins"] = "Riendas de Jinete decapitado"
--Translation missing 
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = "The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = "La ID del objeto para el seguimiento. Este es el objeto tal como aparece en su inventario o en una ventana de botín. Utilice Wowhead o un servicio similar para buscar la ID de los objetos. Este debe ser un número válido y único ."
L["The name you entered is already being used by another item. Please enter a unique name."] = "El nombre que ha introducido ya está siendo utilizado por otro objeto. Por favor, introduzca un nombre único."
--Translation missing 
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = "The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = "El número de jugadores que se necesita para obtener el objeto. Esto reducirá las posibilidades de obtener el objeto."
--Translation missing 
L["The Pigskin"] = "The Pigskin"
--Translation missing 
L["The quest starter item for Reins of the Llothien Prowler"] = "The quest starter item for Reins of the Llothien Prowler"
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = "El módulo de opciones de Rarity esta inactivo. Desconecte y actívelo desde el menú de accesorios."
--Translation missing 
L["The selected Rarity Item Pack string is invalid."] = "The selected Rarity Item Pack string is invalid."
--Translation missing 
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = "The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."
--Translation missing 
L["The Warbringer will be riding the mount color he has a chance to drop."] = "The Warbringer will be riding the mount color he has a chance to drop."
--Translation missing 
L["There are more holiday items available, but Rarity only reminds you about the first two."] = "There are more holiday items available, but Rarity only reminds you about the first two."
--Translation missing 
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = "These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = "This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."
L["This causes Rarity to put a blank line above its tooltip additions."] = "Esto hace que Rarity ponga una línea en blanco por encima de las descripciones añadidas."
--Translation missing 
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = "This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."
--Translation missing 
L["This item is only available to Alliance players."] = "This item is only available to Alliance players."
--Translation missing 
L["This item is only available to Horde players."] = "This item is only available to Horde players."
--Translation missing 
L["This mount is only obtainable by Alliance players"] = "This mount is only obtainable by Alliance players"
--Translation missing 
L["This mount is only obtainable by Horde players"] = "This mount is only obtainable by Horde players"
--Translation missing 
L["This tab lets you import and export items into and out of your Custom tab."] = "This tab lets you import and export items into and out of your Custom tab."
--Translation missing 
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = "This was a guaranteed drop for players who defeated the encounter when it was current"
L["Tiger Gourami School"] = "Banco de guramis tigre"
--Translation missing 
L["Tiger Gourami Slush"] = "Tiger Gourami Slush"
L["Time"] = "Tiempo"
L["Time spent farming"] = "Tiempo de farmeo"
--Translation missing 
L["Timeless Chest"] = "Timeless Chest"
--Translation missing 
L["Time-Locked Box"] = "Time-Locked Box"
--Translation missing 
L["Time-Lost Figurine"] = "Time-Lost Figurine"
--Translation missing 
L["Timewalker 5-player instance"] = "Timewalker 5-player instance"
L["Tin Vein"] = "Filón de estaño"
L["Tiny Crimson Whelpling"] = "Vástago carmesí diminuto"
L["Tiny Emerald Whelpling"] = "Vástago esmeralda diminuto"
--Translation missing 
L["Tiny Fel Engine Key"] = "Tiny Fel Engine Key"
L["Titanium Vein"] = "Filón de titanio"
L[ [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=] ] = [=[Para crear un nuevo objeto, introduzca un nombre único para el objeto y haga clic en Aceptar. El nombre se utilizará si el servidor no responde que el enlace del objeto o el objeto no son válidos.

No se puede cambiar este nombre después de crear el objeto, así que elige bien.]=]
--Translation missing 
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = "To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."
--Translation missing 
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = "To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."
--Translation missing 
L["Today"] = "Today"
L["Toggles"] = "Alterna"
L["Tol'vir"] = true
--Translation missing 
L["Tooltip can't be shown in combat"] = "Tooltip can't be shown in combat"
--Translation missing 
L["Toothy's Bucket"] = "Toothy's Bucket"
--Translation missing 
L["Torn Invitation"] = "Torn Invitation"
L["Total"] = true
L["Total found"] = "Total encontrados"
--Translation missing 
L["Toxic Wasteling"] = "Toxic Wasteling"
--Translation missing 
L["Toy or Item"] = "Toy or Item"
--Translation missing 
L["Toys & Items"] = "Toys & Items"
L["Track this"] = "Realizar un seguimiento de este"
L["Trillium Vein"] = "Filón de trillium"
L["Troll"] = "Trol"
L["True Iron Deposit"] = "Depósito de verahierro"
L["Truesilver Deposit"] = "Depósito de veraplata"
--Translation missing 
L["Tundra Icehoof"] = "Tundra Icehoof"
--Translation missing 
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = "Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."
--Translation missing 
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = "Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."
L["Type of item"] = "Tipo de objeto"
--Translation missing 
L["Unable to retrieve item information from the server"] = "Unable to retrieve item information from the server"
--Translation missing 
L["Unavailable"] = "Unavailable"
--Translation missing 
L["Undefeated"] = "Undefeated"
L["Unknown"] = "Desconocido"
L["Unlucky"] = "Desafortunado"
L["unlucky"] = "desafortunado"
--Translation missing 
L["Unscathed Egg"] = "Unscathed Egg"
--Translation missing 
L["Unstable Powder Box"] = "Unstable Powder Box"
--Translation missing 
L["Unusual Compass"] = "Unusual Compass"
--Translation missing 
L["Use your bonus roll for a chance at this item"] = "Use your bonus roll for a chance at this item"
L["Usually requires a group of around %d players"] = "Por lo general requiere un grupo de %d jugadores"
--Translation missing 
L["Valarjar Stormwing"] = "Valarjar Stormwing"
--Translation missing 
L["Vengeance"] = "Vengeance"
--Translation missing 
L["Verbose"] = "Verbose"
L["Vibrating Arcane Crystal"] = "Cristal Arcano vibrante"
--Translation missing 
L["Vile Blood of Draenor"] = "Vile Blood of Draenor"
--Translation missing 
L["Viscidus Globule"] = "Viscidus Globule"
--Translation missing 
L["Void Collar"] = "Void Collar"
L["Vrykul"] = true
--Translation missing 
L["Warlock"] = "Warlock"
--Translation missing 
L["Warlords of Draenor"] = "Warlords of Draenor"
L["Warm Arcane Crystal"] = "Cristal Arcano cálido"
--Translation missing 
L["Warning Sign"] = "Warning Sign"
--Translation missing 
L["Warrior"] = "Warrior"
--Translation missing 
L["Warsong Direfang"] = "Warsong Direfang"
L["Waterlogged Wreckage"] = "Restos con marcas de agua"
L["Waterlogged Wreckage Pool"] = "Banco de Restos encharcados"
--Translation missing 
L["Weebomination"] = "Weebomination"
L["Welcome to Rarity r%d. Your settings have been reset."] = "Bienvenido a Rarity r%d. Sus ajustes se han restablecido."
--Translation missing 
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = "When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."
--Translation missing 
L["When enabled, Rarity tooltips will include how many attempts you've made."] = "When enabled, Rarity tooltips will include how many attempts you've made."
--Translation missing 
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = "When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = "Cuando está activada, Rarity añadirá objetos que se pueden obtener a la descripción del juego siempre que sea posible."
--Translation missing 
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = "When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."
--Translation missing 
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = "When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."
--Translation missing 
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = "When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."
--Translation missing 
L["When on, items marked as Defeated will be hidden from the tooltip."] = "When on, items marked as Defeated will be hidden from the tooltip."
--Translation missing 
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = "When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."
--Translation missing 
L["When on, items that have no attempts yet will be hidden from the tooltip."] = "When on, items that have no attempts yet will be hidden from the tooltip."
--Translation missing 
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = "When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."
--Translation missing 
L[ [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=] ] = [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=]
--Translation missing 
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = "When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."
--Translation missing 
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = "When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."
--Translation missing 
L["When on, the Luckiness column will be shown in the main tooltip."] = "When on, the Luckiness column will be shown in the main tooltip."
--Translation missing 
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = "When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."
--Translation missing 
L["When on, the Time column will be shown in the main tooltip."] = "When on, the Time column will be shown in the main tooltip."
--Translation missing 
L["When on, the Zone column will be shown in the main tooltip."] = "When on, the Zone column will be shown in the main tooltip."
--Translation missing 
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = "When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."
--Translation missing 
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = "When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."
--Translation missing 
L["Whistle of Chromatic Bone"] = "Whistle of Chromatic Bone"
L["White Trillium Deposit"] = "[White Trillium Deposit]"
--Translation missing 
L["Width"] = "Width"
--Translation missing 
L["Wild Dreamrunner"] = "Wild Dreamrunner"
--Translation missing 
L["Wild Goretusk"] = "Wild Goretusk"
--Translation missing 
L["will be imported"] = "will be imported"
--Translation missing 
L["Will only drop for druids."] = "Will only drop for druids."
--Translation missing 
L["Wisp in a Bottle"] = "Wisp in a Bottle"
--Translation missing 
L["World Tooltip Options"] = "World Tooltip Options"
--Translation missing 
L["Worn Troll Dice"] = "Worn Troll Dice"
--Translation missing 
L["Wrath of the Lich King"] = "Wrath of the Lich King"
--Translation missing 
L["Wriggling Darkness"] = "Wriggling Darkness"
--Translation missing 
L["Yesterday"] = "Yesterday"
--Translation missing 
L["You already defeated %d of them."] = "You already defeated %d of them."
--Translation missing 
L["You already defeated all of them."] = "You already defeated all of them."
--Translation missing 
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = "You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."
--Translation missing 
L["You entered a achievement ID that is already being used by another item."] = "You entered a achievement ID that is already being used by another item."
--Translation missing 
L["You entered a creature ID that is already being used by another item."] = "You entered a creature ID that is already being used by another item."
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = "Ha introducido un nombre reservado. Por favor, introduzca el nombre del objeto correcto, tal y como aparece en el juego."
L["You entered a spell ID that is already being used by another item."] = "Ha introducido un ID de hechizo que ya está siendo utilizado por otro objeto."
L["You entered an item ID that is already being used by another item."] = "Ha introducido un ID de objeto que ya está siendo utilizado por otro objeto."
--Translation missing 
L["You entered an item ID that is already set as the collected item for something else."] = "You entered an item ID that is already set as the collected item for something else."
--Translation missing 
L["You must enter a creature ID."] = "You must enter a creature ID."
L["You must enter a number larger than 0."] = "Debe introducir un número mayor que 0."
--Translation missing 
L["You must enter a number larger than 1."] = "You must enter a number larger than 1."
--Translation missing 
L["You must enter a number larger than or equal to 0."] = "You must enter a number larger than or equal to 0."
--Translation missing 
L["You must enter a spell ID."] = "You must enter a spell ID."
--Translation missing 
L["You must enter a valid number."] = "You must enter a valid number."
--Translation missing 
L["You must enter an amount."] = "You must enter an amount."
--Translation missing 
L["You must enter an item ID."] = "You must enter an item ID."
--Translation missing 
L["You must enter at least one item ID."] = "You must enter at least one item ID."
--Translation missing 
L["You must enter at least one NPC ID."] = "You must enter at least one NPC ID."
--Translation missing 
L["You must enter at least one Statistic ID."] = "You must enter at least one Statistic ID."
--Translation missing 
L["You must enter at least one zone."] = "You must enter at least one zone."
--Translation missing 
L["Young Talbuk"] = "Young Talbuk"
--Translation missing 
L["Young Venomfang"] = "Young Venomfang"
--Translation missing 
L["Zandalari Anklerender"] = "Zandalari Anklerender"
--Translation missing 
L["Zandalari Footslasher"] = "Zandalari Footslasher"
--Translation missing 
L["Zandalari Kneebiter"] = "Zandalari Kneebiter"
--Translation missing 
L["Zandalari Toenibbler"] = "Zandalari Toenibbler"
--Translation missing 
L["Zangar Spore"] = "Zangar Spore"
--Translation missing 
L["Zhevra Lounge Cushion"] = "Zhevra Lounge Cushion"
--Translation missing 
L["Zomstrok"] = "Zomstrok"
--Translation missing 
L["Zone"] = "Zone"
--Translation missing 
L["Zones"] = "Zones"

end

L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "esMX")
if L then
L[" (Group)"] = "(Grupo)"
--Translation missing 
L["#%d: %d attempt (%.2f%%)"] = "#%d: %d attempt (%.2f%%)"
--Translation missing 
L["#%d: %d attempts (%.2f%%)"] = "#%d: %d attempts (%.2f%%)"
--Translation missing 
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = "%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"
--Translation missing 
L["%d |4zone:zones;"] = "%d |4zone:zones;"
--Translation missing 
L["%d attempt"] = "%d attempt"
--Translation missing 
L["%d attempt - %.2f%%"] = "%d attempt - %.2f%%"
--Translation missing 
L["%d attempts"] = "%d attempts"
--Translation missing 
L["%d attempts - %.2f%%"] = "%d attempts - %.2f%%"
--Translation missing 
L["%d collected - %.2f%%"] = "%d collected - %.2f%%"
L["%s: %d attempt"] = "%s: %d intentos"
--Translation missing 
L["%s: %d attempt - %.2f%%"] = "%s: %d attempt - %.2f%%"
--Translation missing 
L["%s: %d attempt (%d total)"] = "%s: %d attempt (%d total)"
L["%s: %d attempts"] = "%s: %d intentos"
--Translation missing 
L["%s: %d attempts - %.2f%%"] = "%s: %d attempts - %.2f%%"
--Translation missing 
L["%s: %d attempts (%d total)"] = "%s: %d attempts (%d total)"
--Translation missing 
L["%s: %d collected"] = "%s: %d collected"
--Translation missing 
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = "%s: 0/%d attempt so far (%.2f%% - %s)"
--Translation missing 
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = "%s: 0/%d attempts so far (%.2f%% - %s)"
--Translation missing 
L["%s: collection completed!"] = "%s: collection completed!"
--Translation missing 
L["%s: Found after %d attempts!"] = "%s: Found after %d attempts!"
--Translation missing 
L["%s: Found on the first attempt!"] = "%s: Found on the first attempt!"
--Translation missing 
L["(%d/%d attempts)"] = "(%d/%d attempts)"
--Translation missing 
L["(%d/%d collected)"] = "(%d/%d collected)"
--Translation missing 
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = "(Items listed in red could not be found on the server and may not exist. Consider removing them.)"
L["(running in debug mode)"] = "(ejecutando en modo debug)"
--Translation missing 
L["(Warning: item could not be retrieved from server)"] = "(Warning: item could not be retrieved from server)"
--Translation missing 
L["1 in %d chance"] = "1 in %d chance"
--Translation missing 
L["10-player Heroic Raid instance (legacy content; not flexible)"] = "10-player Heroic Raid instance (legacy content; not flexible)"
--Translation missing 
L["10-player Raid instance (legacy content; not flexible)"] = "10-player Raid instance (legacy content; not flexible)"
--Translation missing 
L["25-player Event scenario"] = "25-player Event scenario"
--Translation missing 
L["25-player heroic"] = "25-player heroic"
--Translation missing 
L["25-player Heroic Raid instance (legacy content; not flexible)"] = "25-player Heroic Raid instance (legacy content; not flexible)"
--Translation missing 
L["25-player Raid instance (legacy content; not flexible)"] = "25-player Raid instance (legacy content; not flexible)"
--Translation missing 
L["40-player Event raid"] = "40-player Event raid"
--Translation missing 
L["40-player Raid instance (legacy content; not flexible)"] = "40-player Raid instance (legacy content; not flexible)"
--Translation missing 
L["5-player Event instance"] = "5-player Event instance"
--Translation missing 
L["5-player Heroic instance"] = "5-player Heroic instance"
--Translation missing 
L["5-player instance"] = "5-player instance"
--Translation missing 
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = "A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."
--Translation missing 
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = "A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."
--Translation missing 
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = "A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."
--Translation missing 
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = "A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."
--Translation missing 
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = "A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."
--Translation missing 
L[ [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=] ] = [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=]
--Translation missing 
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = "A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."
--Translation missing 
L["A holiday event is available today for %s! Go get it!"] = "A holiday event is available today for %s! Go get it!"
--Translation missing 
L["Abundant Bloodsail Wreckage"] = "Abundant Bloodsail Wreckage"
--Translation missing 
L["Abundant Firefin Snapper School"] = "Abundant Firefin Snapper School"
--Translation missing 
L["Abundant Oily Blackmouth School"] = "Abundant Oily Blackmouth School"
--Translation missing 
L["Abyss Worm"] = "Abyss Worm"
--Translation missing 
L["Abyssal Gulper School"] = "Abyssal Gulper School"
--Translation missing 
L["Adamantite Deposit"] = "Adamantite Deposit"
--Translation missing 
L["Added %d |4waypoint:waypoints; to TomTom"] = "Added %d |4waypoint:waypoints; to TomTom"
--Translation missing 
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = "Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."
--Translation missing 
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = "After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."
--Translation missing 
L["Ageless Bronze Drake"] = "Ageless Bronze Drake"
--Translation missing 
L["Ahune"] = "Ahune"
--Translation missing 
L["Ai-Li's Skymirror"] = "Ai-Li's Skymirror"
--Translation missing 
L["Ai-Ran the Shifting Cloud"] = "Ai-Ran the Shifting Cloud"
--Translation missing 
L["Albino Buzzard"] = "Albino Buzzard"
--Translation missing 
L["Albino Cavefish School"] = "Albino Cavefish School"
--Translation missing 
L["Albino Chimaeraling"] = "Albino Chimaeraling"
--Translation missing 
L["Algaefin Rockfish School"] = "Algaefin Rockfish School"
--Translation missing 
L["All players can participate in killing this world boss once per week, regardless of faction"] = "All players can participate in killing this world boss once per week, regardless of faction"
--Translation missing 
L["All raid formats except Raid Finder"] = "All raid formats except Raid Finder"
--Translation missing 
L["Alliance only"] = "Alliance only"
--Translation missing 
L["Already defeated"] = "Already defeated"
--Translation missing 
L["Already defeated for %s"] = "Already defeated for %s"
--Translation missing 
L["Already known"] = "Already known"
--Translation missing 
L["an item already exists by this name, so it will not be imported"] = "an item already exists by this name, so it will not be imported"
--Translation missing 
L["an item with the same Item ID already exists, so it will not be imported"] = "an item with the same Item ID already exists, so it will not be imported"
L["Ancient Mana"] = "Maná ancestral"
--Translation missing 
L["and %d |4other zone:other zones;"] = "and %d |4other zone:other zones;"
--Translation missing 
L["Announce"] = "Announce"
--Translation missing 
L["Announcements"] = "Announcements"
--Translation missing 
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = "Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."
--Translation missing 
L["Anubisath Idol"] = "Anubisath Idol"
--Translation missing 
L["Any difficulty"] = "Any difficulty"
--Translation missing 
L["Any raid size"] = "Any raid size"
--Translation missing 
L["Any raid size or difficulty"] = "Any raid size or difficulty"
--Translation missing 
L["Appears in the Black Market"] = "Appears in the Black Market"
--Translation missing 
L["Aqua Jewel"] = "Aqua Jewel"
--Translation missing 
L["Arakkoa"] = "Arakkoa"
--Translation missing 
L["Arcano-Shower"] = "Arcano-Shower"
--Translation missing 
L["Archaeology race"] = "Archaeology race"
--Translation missing 
L["Are you sure you want to delete this item?"] = "Are you sure you want to delete this item?"
--Translation missing 
L["Are you sure you want to import the Rarity Item Pack you entered?"] = "Are you sure you want to import the Rarity Item Pack you entered?"
--Translation missing 
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = "Are you sure you want to turn off the Export toggle for all your Custom items?"
--Translation missing 
L["Armored Razorback"] = "Armored Razorback"
--Translation missing 
L["Armored Razzashi Raptor"] = "Armored Razzashi Raptor"
--Translation missing 
L["Ash-Covered Horn"] = "Ash-Covered Horn"
L["Ashes of Al'ar"] = "Cenizas de Al'ar"
--Translation missing 
L["Ashleaf Spriteling"] = "Ashleaf Spriteling"
L["Attempts"] = "Intentos"
--Translation missing 
L["Auto"] = "Auto"
--Translation missing 
L["Available starting December 25th"] = "Available starting December 25th"
--Translation missing 
L["Azure Crane Chick"] = "Azure Crane Chick"
L["Azure Whelpling"] = "Vástago Azur"
--Translation missing 
L["Battle Horn"] = "Battle Horn"
--Translation missing 
L["Battle Pet"] = "Battle Pet"
--Translation missing 
L["Battle Pets"] = "Battle Pets"
--Translation missing 
L["Big Love Rocket"] = "Big Love Rocket"
--Translation missing 
L["Black Barracuda School"] = "Black Barracuda School"
--Translation missing 
L["Black Trillium Deposit"] = "Black Trillium Deposit"
--Translation missing 
L["Blackbelly Mudfish School"] = "Blackbelly Mudfish School"
--Translation missing 
L["Blackflame Daggers"] = "Blackflame Daggers"
--Translation missing 
L["Blackfuse Bombling"] = "Blackfuse Bombling"
--Translation missing 
L["Blackhoof"] = "Blackhoof"
--Translation missing 
L["Blackrock Deposit"] = "Blackrock Deposit"
--Translation missing 
L["Blackwater Whiptail School"] = "Blackwater Whiptail School"
--Translation missing 
L["Blackwing Banner"] = "Blackwing Banner"
--Translation missing 
L["Blank line before tooltip additions"] = "Blank line before tooltip additions"
--Translation missing 
L["Blazing Rune"] = "Blazing Rune"
--Translation missing 
L["Bleakclaw"] = "Bleakclaw"
--Translation missing 
L["Blessed Seed"] = "Blessed Seed"
--Translation missing 
L["Blight Boar Microphone"] = "Blight Boar Microphone"
--Translation missing 
L["Blighted Spore"] = "Blighted Spore"
--Translation missing 
L["Blind Lake Sturgeon School"] = "Blind Lake Sturgeon School"
--Translation missing 
L["Bloodsail Wreckage"] = "Bloodsail Wreckage"
--Translation missing 
L["Bloodsail Wreckage Pool"] = "Bloodsail Wreckage Pool"
--Translation missing 
L["Bluefish School"] = "Bluefish School"
--Translation missing 
L["Bone Serpent"] = "Bone Serpent"
--Translation missing 
L["Bonkers"] = "Bonkers"
--Translation missing 
L["Borean Man O' War School"] = "Borean Man O' War School"
--Translation missing 
L["Boss Name"] = "Boss Name"
--Translation missing 
L["Bottled Tornado"] = "Bottled Tornado"
--Translation missing 
L["Brackish Mixed School"] = "Brackish Mixed School"
--Translation missing 
L["Brew Frenzied Emperor Salmon"] = "Brew Frenzied Emperor Salmon"
--Translation missing 
L["Brilliant Phoenix Hawk Feather"] = "Brilliant Phoenix Hawk Feather"
--Translation missing 
L["Brinedeep Bottom-Feeder"] = "Brinedeep Bottom-Feeder"
--Translation missing 
L["Bristling Hellboar"] = "Bristling Hellboar"
--Translation missing 
L["Bronze Proto-Whelp"] = "Bronze Proto-Whelp"
--Translation missing 
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = "Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."
--Translation missing 
L["Burgy Blackheart's Handsome Hat"] = "Burgy Blackheart's Handsome Hat"
--Translation missing 
L["Call of the Frozen Blade"] = "Call of the Frozen Blade"
--Translation missing 
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = "Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."
--Translation missing 
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = "Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."
--Translation missing 
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = "Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."
--Translation missing 
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = "Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."
--Translation missing 
L["Can be obtained with a bonus roll"] = "Can be obtained with a bonus roll"
--Translation missing 
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = "Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."
--Translation missing 
L["Captured Firefly"] = "Captured Firefly"
--Translation missing 
L["Cat Carrier (Black Tabby)"] = "Cat Carrier (Black Tabby)"
--Translation missing 
L["Cataclysm"] = "Cataclysm"
--Translation missing 
L["Cavern Moccasin"] = "Cavern Moccasin"
--Translation missing 
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = "Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"
--Translation missing 
L["Chain Pet Leash"] = "Chain Pet Leash"
--Translation missing 
L["Chalice of Secrets"] = "Chalice of Secrets"
--Translation missing 
L["Challenge Mode instance"] = "Challenge Mode instance"
--Translation missing 
L["Chance"] = "Chance"
--Translation missing 
L["Chance so far"] = "Chance so far"
--Translation missing 
L["Chaos Pup"] = "Chaos Pup"
--Translation missing 
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = "Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."
--Translation missing 
L[ [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=] ] = [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=]
--Translation missing 
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = "Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."
--Translation missing 
L["Christoph VonFeasel"] = "Christoph VonFeasel"
--Translation missing 
L["Chromie"] = "Chromie"
--Translation missing 
L["Chuck's Bucket"] = "Chuck's Bucket"
--Translation missing 
L["Classic"] = "Classic"
--Translation missing 
L["Clear All Exports"] = "Clear All Exports"
--Translation missing 
L["Click to switch to this item"] = "Click to switch to this item"
--Translation missing 
L["Click to toggle the progress bar"] = "Click to toggle the progress bar"
--Translation missing 
L["Clockwork Rocket Bot"] = "Clockwork Rocket Bot"
--Translation missing 
L["Close"] = "Close"
--Translation missing 
L["Cloudwing Hippogryph"] = "Cloudwing Hippogryph"
--Translation missing 
L["Clutch of Ji-Kun"] = "Clutch of Ji-Kun"
--Translation missing 
L["Cobalt Deposit"] = "Cobalt Deposit"
--Translation missing 
L["Coin of Many Faces"] = "Coin of Many Faces"
--Translation missing 
L["Collect %d %s"] = "Collect %d %s"
--Translation missing 
L["Collected"] = "Collected"
--Translation missing 
L["Collection Complete"] = "Collection Complete"
--Translation missing 
L["Collection complete!"] = "Collection complete!"
--Translation missing 
L["Collection Size"] = "Collection Size"
--Translation missing 
L["Contained in bonus satchels"] = "Contained in bonus satchels"
--Translation missing 
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = "Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."
--Translation missing 
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = "Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."
--Translation missing 
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = "Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."
--Translation missing 
L["Content Category"] = "Content Category"
--Translation missing 
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = "Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."
--Translation missing 
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = "Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."
--Translation missing 
L["Copper Vein"] = "Copper Vein"
--Translation missing 
L[ [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=] ] = [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=]
--Translation missing 
L["Core of Hardened Ash"] = "Core of Hardened Ash"
--Translation missing 
L["Corrupted Nest Guardian"] = "Corrupted Nest Guardian"
--Translation missing 
L["Corrupted Thundertail"] = "Corrupted Thundertail"
--Translation missing 
L["Crane Nest"] = "Crane Nest"
--Translation missing 
L["Crashin' Thrashin' Cannon Controller"] = "Crashin' Thrashin' Cannon Controller"
--Translation missing 
L["Crashin' Thrashin' Flyer Controller"] = "Crashin' Thrashin' Flyer Controller"
--Translation missing 
L["Crashin' Thrashin' Mortar Controller"] = "Crashin' Thrashin' Mortar Controller"
--Translation missing 
L["Crashin' Thrashin' Racer Controller"] = "Crashin' Thrashin' Racer Controller"
--Translation missing 
L["Crashin' Thrashin' Roller Controller"] = "Crashin' Thrashin' Roller Controller"
--Translation missing 
L["Create a New Item"] = "Create a New Item"
--Translation missing 
L["Create a new item to track"] = "Create a new item to track"
--Translation missing 
L["Creature ID"] = "Creature ID"
--Translation missing 
L["Crowded Redbelly Mandarin"] = "Crowded Redbelly Mandarin"
--Translation missing 
L["Crysa"] = "Crysa"
--Translation missing 
L["Crystal of the Void"] = "Crystal of the Void"
--Translation missing 
L["Ctrl-Click to change sort order"] = "Ctrl-Click to change sort order"
--Translation missing 
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = "Ctrl-Click to create the remaining TomTom waypoint(s)."
--Translation missing 
L["Ctrl-Click to create TomTom waypoint(s)."] = "Ctrl-Click to create TomTom waypoint(s)."
--Translation missing 
L["Cupri"] = "Cupri"
L["Curious Wyrmtongue Cache"] = "Alijo de lenguavermis peculiar"
--Translation missing 
L["Cursed Queenfish School"] = "Cursed Queenfish School"
--Translation missing 
L["Cursed Spirit"] = "Cursed Spirit"
--Translation missing 
L["Custom"] = "Custom"
--Translation missing 
L["Dandelion Frolicker"] = "Dandelion Frolicker"
--Translation missing 
L["Dark Gazer"] = "Dark Gazer"
--Translation missing 
L["Dark Iron Deposit"] = "Dark Iron Deposit"
--Translation missing 
L["Dark Quivering Blob"] = "Dark Quivering Blob"
--Translation missing 
L["Dark Whelpling"] = "Dark Whelpling"
--Translation missing 
L["Darkmoon Eye"] = "Darkmoon Eye"
--Translation missing 
L["Data has been imported from Bunny Hunter"] = "Data has been imported from Bunny Hunter"
--Translation missing 
L["Death Adder Hatchling"] = "Death Adder Hatchling"
--Translation missing 
L["Death Knight"] = "Death Knight"
--Translation missing 
L["Deathcharger's Reins"] = "Deathcharger's Reins"
--Translation missing 
L["Deathtalon"] = "Deathtalon"
--Translation missing 
L["Debug mode"] = "Debug mode"
L["Debug mode OFF"] = "Modo Debug DESACTIVADO"
L["Debug mode ON"] = "Modo Debug ACTIVADO"
--Translation missing 
L["Decahedral Dwarven Dice"] = "Decahedral Dwarven Dice"
--Translation missing 
L["Deep Sea Monsterbelly School"] = "Deep Sea Monsterbelly School"
--Translation missing 
L["Deepsea Sagefish School"] = "Deepsea Sagefish School"
--Translation missing 
L["Defeat Detection"] = "Defeat Detection"
--Translation missing 
L["Defeated"] = "Defeated"
--Translation missing 
L["Defiled Earth"] = "Defiled Earth"
--Translation missing 
L["Delete this item"] = "Delete this item"
--Translation missing 
L["Demon Hunter"] = "Demon Hunter"
--Translation missing 
L["Demonic"] = "Demonic"
--Translation missing 
L["Determines how this item is obtained."] = "Determines how this item is obtained."
--Translation missing 
L["Determines what type of item this is."] = "Determines what type of item this is."
--Translation missing 
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = "Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."
--Translation missing 
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = "Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."
--Translation missing 
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = "Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."
--Translation missing 
L[ [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=] ] = [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=]
--Translation missing 
L["Determines which race includes this archaeology project."] = "Determines which race includes this archaeology project."
--Translation missing 
L["Deviate Hatchling"] = "Deviate Hatchling"
--Translation missing 
L["Direflame"] = "Direflame"
--Translation missing 
L["Direhorn Runt"] = "Direhorn Runt"
--Translation missing 
L["Disable for classes"] = "Disable for classes"
L["Disgusting Oozeling"] = "Moquillo Desagradable"
--Translation missing 
L["Displacer Meditation Stone"] = "Displacer Meditation Stone"
--Translation missing 
L["Distance"] = "Distance"
--Translation missing 
L["Don Carlos' Famous Hat"] = "Don Carlos' Famous Hat"
--Translation missing 
L["Doomroller"] = "Doomroller"
--Translation missing 
L["Draenei"] = "Draenei"
--Translation missing 
L["Draenor Clans"] = "Draenor Clans"
--Translation missing 
L["Draenor Garrison"] = "Draenor Garrison"
--Translation missing 
L["Dragonfin Angelfish School"] = "Dragonfin Angelfish School"
--Translation missing 
L["Drakum"] = "Drakum"
--Translation missing 
L["Dreadwalker"] = "Dreadwalker"
--Translation missing 
L["Dripping Strider Egg"] = "Dripping Strider Egg"
--Translation missing 
L["Droplet of Y'Shaarj"] = "Droplet of Y'Shaarj"
--Translation missing 
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = "Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."
--Translation missing 
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = "Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."
--Translation missing 
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = "Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."
--Translation missing 
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = "Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"
--Translation missing 
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = "Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."
--Translation missing 
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = "Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."
--Translation missing 
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = "Dropped by Malygos in The Eye of Eternity (any raid size)"
--Translation missing 
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = "Dropped by Onyxia in Onyxia's Lair (any raid size)"
--Translation missing 
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = "Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"
--Translation missing 
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = "Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"
--Translation missing 
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = "Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"
--Translation missing 
L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = "Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"
--Translation missing 
L["Dropped from dinosaurs on Isle of Giants"] = "Dropped from dinosaurs on Isle of Giants"
--Translation missing 
L["Dropped from monsters in Fang'rila"] = "Dropped from monsters in Fang'rila"
--Translation missing 
L["Drops from a boss requiring a group"] = "Drops from a boss requiring a group"
--Translation missing 
L["Drops from any mob in a zone"] = "Drops from any mob in a zone"
--Translation missing 
L["Drops from NPC(s)"] = "Drops from NPC(s)"
--Translation missing 
L["Drudge Remains"] = "Drudge Remains"
--Translation missing 
L["Druid"] = "Druid"
--Translation missing 
L["Dungeon ID"] = "Dungeon ID"
--Translation missing 
L["Dusty Clutch of Eggs"] = "Dusty Clutch of Eggs"
--Translation missing 
L["Dwarf"] = "Dwarf"
--Translation missing 
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = "Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."
--Translation missing 
L["Elementium Geode"] = "Elementium Geode"
--Translation missing 
L["Elementium Vein"] = "Elementium Vein"
--Translation missing 
L["Emperor Salmon School"] = "Emperor Salmon School"
--Translation missing 
L["Enable announcements"] = "Enable announcements"
--Translation missing 
L["Enable Coins"] = "Enable Coins"
--Translation missing 
L["Enable profiling"] = "Enable profiling"
--Translation missing 
L["Enable tooltip additions"] = "Enable tooltip additions"
--Translation missing 
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = "Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."
--Translation missing 
L["Enables announcements whenever you complete a new attempt toward this item."] = "Enables announcements whenever you complete a new attempt toward this item."
--Translation missing 
L["Enter 1 or leave this blank to mark the item as soloable."] = "Enter 1 or leave this blank to mark the item as soloable."
--Translation missing 
L["Equal odds"] = "Equal odds"
--Translation missing 
L["Error compressing item pack"] = "Error compressing item pack"
--Translation missing 
L["Error encoding item pack"] = "Error encoding item pack"
--Translation missing 
L["Error serializing item pack"] = "Error serializing item pack"
--Translation missing 
L["Essence of the Breeze"] = "Essence of the Breeze"
--Translation missing 
L["Eternal Kiln"] = "Eternal Kiln"
--Translation missing 
L["Eternal Warrior's Sigil"] = "Eternal Warrior's Sigil"
--Translation missing 
L["Everliving Spore"] = "Everliving Spore"
--Translation missing 
L["Every item ID must be a number greater than 0."] = "Every item ID must be a number greater than 0."
--Translation missing 
L["Every NPC ID must be a number greater than 0."] = "Every NPC ID must be a number greater than 0."
--Translation missing 
L["Every Quest ID must be a number greater than 0."] = "Every Quest ID must be a number greater than 0."
--Translation missing 
L["Experiment 12-B"] = "Experiment 12-B"
--Translation missing 
L["Export"] = "Export"
--Translation missing 
L["Export Rarity Item Pack"] = "Export Rarity Item Pack"
--Translation missing 
L["Export this item"] = "Export this item"
--Translation missing 
L["Eye of Inquisition"] = "Eye of Inquisition"
--Translation missing 
L["Faintly Glowing Flagon of Mead"] = "Faintly Glowing Flagon of Mead"
--Translation missing 
L["Fandral's Seed Pouch"] = "Fandral's Seed Pouch"
--Translation missing 
L["Fangtooth Herring School"] = "Fangtooth Herring School"
--Translation missing 
L["Farwater Conch"] = "Farwater Conch"
--Translation missing 
L["Fat Sleeper School"] = "Fat Sleeper School"
--Translation missing 
L["Fathom Dweller"] = "Fathom Dweller"
--Translation missing 
L["Fathom Eel Swarm"] = "Fathom Eel Swarm"
--Translation missing 
L["Feed text"] = "Feed text"
--Translation missing 
L["Fel Iron Deposit"] = "Fel Iron Deposit"
--Translation missing 
L["Felfly"] = "Felfly"
--Translation missing 
L["Felslate Deposit"] = "Felslate Deposit"
--Translation missing 
L["Felslate Seam"] = "Felslate Seam"
--Translation missing 
L["Felsteel Annihilator"] = "Felsteel Annihilator"
--Translation missing 
L["Felsworn Sentry"] = "Felsworn Sentry"
--Translation missing 
L["Feltail School"] = "Feltail School"
--Translation missing 
L["Fever of Stormrays"] = "Fever of Stormrays"
L["Fiery Warhorse's Reins"] = "Riendas de Caballo de Guerra Ígneo"
--Translation missing 
L["Fire Ammonite School"] = "Fire Ammonite School"
--Translation missing 
L["Firefin Snapper School"] = "Firefin Snapper School"
--Translation missing 
L["Firewing"] = "Firewing"
--Translation missing 
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = "Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"
L["Flametalon of Alysrazor"] = "Garfa de fuego de Alysrazor"
--Translation missing 
L["Floating Debris"] = "Floating Debris"
--Translation missing 
L["Floating Debris Pool"] = "Floating Debris Pool"
--Translation missing 
L["Floating Shipwreck Debris"] = "Floating Shipwreck Debris"
--Translation missing 
L["Floating Wreckage"] = "Floating Wreckage"
--Translation missing 
L["Floating Wreckage Pool"] = "Floating Wreckage Pool"
--Translation missing 
L["Font"] = "Font"
--Translation missing 
L["Font Size"] = "Font Size"
--Translation missing 
L["Foot Ball"] = "Foot Ball"
--Translation missing 
L["Fossil"] = "Fossil"
--Translation missing 
L["Fossilized Raptor"] = "Fossilized Raptor"
--Translation missing 
L["Found after %d attempts!"] = "Found after %d attempts!"
--Translation missing 
L["Found in: "] = "Found in: "
--Translation missing 
L["Found on your first attempt!"] = "Found on your first attempt!"
--Translation missing 
L["Fox Kit"] = "Fox Kit"
--Translation missing 
L["Fragment of Anger"] = "Fragment of Anger"
--Translation missing 
L["Fragment of Desire"] = "Fragment of Desire"
--Translation missing 
L["Fragment of Frozen Bone"] = "Fragment of Frozen Bone"
--Translation missing 
L["Fragment of Suffering"] = "Fragment of Suffering"
--Translation missing 
L["Frenzyheart Brew"] = "Frenzyheart Brew"
--Translation missing 
L["Frightened Bush Chicken"] = "Frightened Bush Chicken"
--Translation missing 
L["Fuzzy Green Lounge Cushion"] = "Fuzzy Green Lounge Cushion"
--Translation missing 
L["Gahz'rooki's Summoning Stone"] = "Gahz'rooki's Summoning Stone"
--Translation missing 
L["Gar'lok"] = "Gar'lok"
--Translation missing 
L["Garn Nighthowl"] = "Garn Nighthowl"
--Translation missing 
L["Garn Steelmaw"] = "Garn Steelmaw"
--Translation missing 
L["Garrison Invasion Gold Victory"] = "Garrison Invasion Gold Victory"
--Translation missing 
L["Garrison Invasion Platinum Victory"] = "Garrison Invasion Platinum Victory"
--Translation missing 
L["Gastropod Shell"] = "Gastropod Shell"
--Translation missing 
L["General"] = "General"
--Translation missing 
L["General Options"] = "General Options"
--Translation missing 
L["Ghost Iron Deposit"] = "Ghost Iron Deposit"
--Translation missing 
L["Giant Coldsnout"] = "Giant Coldsnout"
--Translation missing 
L["Giant Mantis Shrimp Swarm"] = "Giant Mantis Shrimp Swarm"
--Translation missing 
L["Giant Sewer Rat"] = "Giant Sewer Rat"
--Translation missing 
L["Giant Worm Egg"] = "Giant Worm Egg"
--Translation missing 
L["Gibblette the Cowardly"] = "Gibblette the Cowardly"
--Translation missing 
L["Glacial Salmon School"] = "Glacial Salmon School"
--Translation missing 
L["Glassfin Minnow School"] = "Glassfin Minnow School"
--Translation missing 
L["Glimmering Jewel Danio Pool"] = "Glimmering Jewel Danio Pool"
--Translation missing 
L["Glimmering Treasure Chest"] = "Glimmering Treasure Chest"
--Translation missing 
L["Glittering Arcane Crystal"] = "Glittering Arcane Crystal"
--Translation missing 
L["Glittering Ball of Yarn"] = "Glittering Ball of Yarn"
--Translation missing 
L["Glowing Jade Lungfish"] = "Glowing Jade Lungfish"
--Translation missing 
L["Gluth's Bone"] = "Gluth's Bone"
--Translation missing 
L["Gold Vein"] = "Gold Vein"
--Translation missing 
L["Golden Carp School"] = "Golden Carp School"
--Translation missing 
L["Gondar"] = "Gondar"
--Translation missing 
L["Gooey Sha-ling"] = "Gooey Sha-ling"
--Translation missing 
L["Goren \"Log\" Roller"] = "Goren \"Log\" Roller"
--Translation missing 
L["Great Brewfest Kodo"] = "Great Brewfest Kodo"
--Translation missing 
L["Greater Sagefish School"] = "Greater Sagefish School"
--Translation missing 
L["Greatfather Winter's Tree"] = "Greatfather Winter's Tree"
--Translation missing 
L["Green Helper Box"] = "Green Helper Box"
--Translation missing 
L["Grotesque Statue"] = "Grotesque Statue"
--Translation missing 
L["Group Finder Options"] = "Group Finder Options"
--Translation missing 
L["Group size"] = "Group size"
--Translation missing 
L["Group(s) found!"] = "Group(s) found!"
--Translation missing 
L["Grow Up"] = "Grow Up"
--Translation missing 
L["Grumpling"] = "Grumpling"
--Translation missing 
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = "Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."
--Translation missing 
L["Gu'chi Swarmling"] = "Gu'chi Swarmling"
--Translation missing 
L["Guk"] = "Guk"
--Translation missing 
L["Gulp Froglet"] = "Gulp Froglet"
--Translation missing 
L["Gundrak Hatchling"] = "Gundrak Hatchling"
--Translation missing 
L["Half-Empty Food Container"] = "Half-Empty Food Container"
--Translation missing 
L["Hardened Shell"] = "Hardened Shell"
--Translation missing 
L["Height"] = "Height"
--Translation missing 
L["Helpful Wikky's Whistle"] = "Helpful Wikky's Whistle"
--Translation missing 
L["Here is a preview of what will (or won't) be imported:"] = "Here is a preview of what will (or won't) be imported:"
--Translation missing 
L["Heroic difficulty"] = "Heroic difficulty"
--Translation missing 
L["Heroic Raid (10-30 players)"] = "Heroic Raid (10-30 players)"
--Translation missing 
L["Heroic Scenario instance"] = "Heroic Scenario instance"
--Translation missing 
L["Heroic, any raid size"] = "Heroic, any raid size"
--Translation missing 
L["Hidden"] = "Hidden"
--Translation missing 
L["Hide defeated items"] = "Hide defeated items"
--Translation missing 
L["Hide high chance items"] = "Hide high chance items"
--Translation missing 
L["Hide items not in your zone"] = "Hide items not in your zone"
--Translation missing 
L["Hide items with no attempts"] = "Hide items with no attempts"
--Translation missing 
L["Hide unavailable items"] = "Hide unavailable items"
--Translation missing 
L["High Priest of Ordos"] = "High Priest of Ordos"
--Translation missing 
L["Highborne"] = "Highborne"
--Translation missing 
L["Highland Guppy School"] = "Highland Guppy School"
--Translation missing 
L["Highland Mixed School"] = "Highland Mixed School"
--Translation missing 
L["Highmountain Elderhorn"] = "Highmountain Elderhorn"
--Translation missing 
L["Highmountain Salmon School"] = "Highmountain Salmon School"
--Translation missing 
L["Highmountain Tauren"] = "Highmountain Tauren"
--Translation missing 
L["Holiday"] = "Holiday"
--Translation missing 
L["Holiday reminders"] = "Holiday reminders"
--Translation missing 
L["Hollow Reed"] = "Hollow Reed"
--Translation missing 
L["Horde only"] = "Horde only"
--Translation missing 
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = "How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."
--Translation missing 
L["How many attempts you've made so far."] = "How many attempts you've made so far."
--Translation missing 
L["How many items you need to collect."] = "How many items you need to collect."
--Translation missing 
L["How many items you've collected so far."] = "How many items you've collected so far."
--Translation missing 
L["Hozen Beach Ball"] = "Hozen Beach Ball"
--Translation missing 
L["Huge Obsidian Slab"] = "Huge Obsidian Slab"
--Translation missing 
L["Hunter"] = "Hunter"
--Translation missing 
L["Hyjal Wisp"] = "Hyjal Wisp"
--Translation missing 
L["Ice Chip"] = "Ice Chip"
--Translation missing 
L["Identify the Item"] = "Identify the Item"
--Translation missing 
L["Imbued Jade Fragment"] = "Imbued Jade Fragment"
--Translation missing 
L["Imperial Manta Ray School"] = "Imperial Manta Ray School"
--Translation missing 
L["Imperial Moth"] = "Imperial Moth"
--Translation missing 
L["Imperial Silkworm"] = "Imperial Silkworm"
--Translation missing 
L["Imp-Master Valessa"] = "Imp-Master Valessa"
--Translation missing 
L["Import"] = "Import"
--Translation missing 
L["Import Rarity Item Pack"] = "Import Rarity Item Pack"
--Translation missing 
L["Import/Export"] = "Import/Export"
--Translation missing 
L["imported successfully"] = "imported successfully"
--Translation missing 
L["Incendicite Mineral Vein"] = "Incendicite Mineral Vein"
--Translation missing 
L["Indurium Mineral Vein"] = "Indurium Mineral Vein"
--Translation missing 
L["Install TomTom to enable waypoint creation."] = "Install TomTom to enable waypoint creation."
--Translation missing 
L["Instance Difficulty"] = "Instance Difficulty"
--Translation missing 
L["Instant Arcane Sanctum Security Kit"] = "Instant Arcane Sanctum Security Kit"
--Translation missing 
L["Invincible's Reins"] = "Invincible's Reins"
--Translation missing 
L["Iron Deposit"] = "Iron Deposit"
--Translation missing 
L["Ironbound Collar"] = "Ironbound Collar"
--Translation missing 
L["Ironhoof Destroyer"] = "Ironhoof Destroyer"
--Translation missing 
L["Item ID"] = "Item ID"
--Translation missing 
L["Item ID to Collect"] = "Item ID to Collect"
--Translation missing 
L["Items to Use"] = "Items to Use"
--Translation missing 
L["Jade Lungfish School"] = "Jade Lungfish School"
--Translation missing 
L["Jadefire Spirit"] = "Jadefire Spirit"
--Translation missing 
L["Jademist Dancer"] = "Jademist Dancer"
--Translation missing 
L["Jawless Skulker School"] = "Jawless Skulker School"
--Translation missing 
L["Jeremy Feasel"] = "Jeremy Feasel"
--Translation missing 
L["Jewel Danio School"] = "Jewel Danio School"
--Translation missing 
L["Jewel of Maddening Whispers"] = "Jewel of Maddening Whispers"
--Translation missing 
L["Ji-Kun Hatchling"] = "Ji-Kun Hatchling"
--Translation missing 
L["Jingling Bell"] = "Jingling Bell"
--Translation missing 
L["Kael'thas Sunstrider"] = "Kael'thas Sunstrider"
--Translation missing 
L["Kaldorei Light Globe"] = "Kaldorei Light Globe"
--Translation missing 
L["Kal'tik the Blight"] = "Kal'tik the Blight"
--Translation missing 
L["Kang's Bindstone"] = "Kang's Bindstone"
--Translation missing 
L["Khorium Vein"] = "Khorium Vein"
--Translation missing 
L["Kill Statistic IDs"] = "Kill Statistic IDs"
--Translation missing 
L["Knockoff Blingtron"] = "Knockoff Blingtron"
--Translation missing 
L["Kor'kron Juggernaut"] = "Kor'kron Juggernaut"
--Translation missing 
L["Kovok"] = "Kovok"
--Translation missing 
L["Krasarang Paddlefish School"] = "Krasarang Paddlefish School"
--Translation missing 
L["Kyparite Deposit"] = "Kyparite Deposit"
--Translation missing 
L["Land Shark"] = "Land Shark"
--Translation missing 
L["Large Obsidian Chunk"] = "Large Obsidian Chunk"
--Translation missing 
L["Large Pool of Brew Frenzied Emperor Salmon"] = "Large Pool of Brew Frenzied Emperor Salmon"
--Translation missing 
L["Large Pool of Crowded Redbelly Mandarin"] = "Large Pool of Crowded Redbelly Mandarin"
--Translation missing 
L["Large Pool of Glimmering Jewel Danio Pool"] = "Large Pool of Glimmering Jewel Danio Pool"
--Translation missing 
L["Large Pool of Glowing Jade Lungfish"] = "Large Pool of Glowing Jade Lungfish"
--Translation missing 
L["Large Pool of Sha-Touched Spinefish"] = "Large Pool of Sha-Touched Spinefish"
--Translation missing 
L["Large Pool of Tiger Gourami Slush"] = "Large Pool of Tiger Gourami Slush"
--Translation missing 
L["Large Swarm of Migrated Reef Octopus"] = "Large Swarm of Migrated Reef Octopus"
--Translation missing 
L["Large Swarm of Panicked Paddlefish"] = "Large Swarm of Panicked Paddlefish"
--Translation missing 
L["Large Tangled Mantis Shrimp Cluster"] = "Large Tangled Mantis Shrimp Cluster"
--Translation missing 
L["Last Month"] = "Last Month"
--Translation missing 
L["Last Week"] = "Last Week"
--Translation missing 
L["Left"] = "Left"
--Translation missing 
L["Legion"] = "Legion"
--Translation missing 
L["Lesser Bloodstone Deposit"] = "Lesser Bloodstone Deposit"
--Translation missing 
L["Lesser Firefin Snapper School"] = "Lesser Firefin Snapper School"
--Translation missing 
L["Lesser Floating Debris"] = "Lesser Floating Debris"
--Translation missing 
L["Lesser Oily Blackmouth School"] = "Lesser Oily Blackmouth School"
--Translation missing 
L["Lesser Sagefish School"] = "Lesser Sagefish School"
--Translation missing 
L["Leviathan Egg"] = "Leviathan Egg"
--Translation missing 
L["Ley Spider Eggs"] = "Ley Spider Eggs"
--Translation missing 
L["Leystone Deposit"] = "Leystone Deposit"
--Translation missing 
L["Leystone Seam"] = "Leystone Seam"
--Translation missing 
L["Leywoven Flying Carpet"] = "Leywoven Flying Carpet"
--Translation missing 
L["Life-Binder's Handmaiden"] = "Life-Binder's Handmaiden"
--Translation missing 
L["Likelihood"] = "Likelihood"
--Translation missing 
L["Lil' Bling"] = "Lil' Bling"
--Translation missing 
L["Living Infernal Core"] = "Living Infernal Core"
--Translation missing 
L["Living Sandling"] = "Living Sandling"
L["Loaded (running in debug mode)"] = "Cargado (ejecutando en modo debug)"
--Translation missing 
L["Loaded Gnomish Dice"] = "Loaded Gnomish Dice"
L["Loading"] = "Cargando"
--Translation missing 
L["Locked"] = "Locked"
--Translation missing 
L["Looking For Raid (10-30 players)"] = "Looking For Raid (10-30 players)"
--Translation missing 
L["Luckiness"] = "Luckiness"
L["Lucky"] = "Suerte"
--Translation missing 
L["lucky"] = "lucky"
--Translation missing 
L["Lucky if you obtain in %d or less"] = "Lucky if you obtain in %d or less"
--Translation missing 
L["Lump of Coal"] = "Lump of Coal"
--Translation missing 
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = "Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."
--Translation missing 
L["Mage"] = "Mage"
--Translation missing 
L["Magnataur Hunting Horn"] = "Magnataur Hunting Horn"
--Translation missing 
L["Major Nanners"] = "Major Nanners"
--Translation missing 
L["Mantid"] = "Mantid"
--Translation missing 
L["Mark of Flame"] = "Mark of Flame"
--Translation missing 
L["Method of obtaining"] = "Method of obtaining"
--Translation missing 
L["Midnight's Eternal Reins"] = "Midnight's Eternal Reins"
--Translation missing 
L["Mimiron's Head"] = "Mimiron's Head"
--Translation missing 
L["Minimal"] = "Minimal"
--Translation missing 
L["Minion of Grumpus"] = "Minion of Grumpus"
--Translation missing 
L["MiniZep Controller"] = "MiniZep Controller"
--Translation missing 
L["Mirecroak"] = "Mirecroak"
--Translation missing 
L["Mists of Pandaria"] = "Mists of Pandaria"
--Translation missing 
L["Mithril Deposit"] = "Mithril Deposit"
--Translation missing 
L["Mogu"] = "Mogu"
L["Mojo"] = true
--Translation missing 
L["Monk"] = "Monk"
--Translation missing 
L["Moon Moon"] = "Moon Moon"
--Translation missing 
L["Moonfang"] = "Moonfang"
--Translation missing 
L["Moonfang Shroud"] = "Moonfang Shroud"
--Translation missing 
L["Moonfang's Paw"] = "Moonfang's Paw"
--Translation missing 
L["Moonglow Cuttlefish School"] = "Moonglow Cuttlefish School"
--Translation missing 
L["Mossgill Perch School"] = "Mossgill Perch School"
--Translation missing 
L["Mount"] = "Mount"
--Translation missing 
L["Mountain Panda"] = "Mountain Panda"
--Translation missing 
L["Mountain Trout School"] = "Mountain Trout School"
L["Mounts"] = "Monturas"
--Translation missing 
L["Mr. Grubbs"] = "Mr. Grubbs"
--Translation missing 
L["Mr. Pinchy"] = "Mr. Pinchy"
--Translation missing 
L["Mr. Smite's Brass Compass"] = "Mr. Smite's Brass Compass"
--Translation missing 
L["Muckbreaths's Bucket"] = "Muckbreaths's Bucket"
--Translation missing 
L["Muddy Churning Water"] = "Muddy Churning Water"
--Translation missing 
L["Mudfish School"] = "Mudfish School"
--Translation missing 
L["Musselback Sculpin School"] = "Musselback Sculpin School"
--Translation missing 
L["Muyani"] = "Muyani"
--Translation missing 
L["Mysterious Camel Figurine"] = "Mysterious Camel Figurine"
--Translation missing 
L["Mythic 5-player instance"] = "Mythic 5-player instance"
--Translation missing 
L["Mythic difficulty"] = "Mythic difficulty"
--Translation missing 
L["Mythic Raid (20 player)"] = "Mythic Raid (20 player)"
--Translation missing 
L["Nerubian"] = "Nerubian"
--Translation missing 
L["Nerubian Relic"] = "Nerubian Relic"
--Translation missing 
L["Nessos the Oracle"] = "Nessos the Oracle"
--Translation missing 
L["Nethercite Deposit"] = "Nethercite Deposit"
--Translation missing 
L["Netherfist"] = "Netherfist"
--Translation missing 
L["Netherspace Portal-Stone"] = "Netherspace Portal-Stone"
--Translation missing 
L["Nettlefish School"] = "Nettlefish School"
--Translation missing 
L["New item"] = "New item"
--Translation missing 
L["Night Elf"] = "Night Elf"
--Translation missing 
L["Nightmare Bell"] = "Nightmare Bell"
--Translation missing 
L["Nightmare Whelpling"] = "Nightmare Whelpling"
--Translation missing 
L["Nightshade Sproutling"] = "Nightshade Sproutling"
--Translation missing 
L[ [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=] ] = [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=]
--Translation missing 
L["None"] = "None"
--Translation missing 
L["None (not in an instance)"] = "None (not in an instance)"
--Translation missing 
L["Normal"] = "Normal"
--Translation missing 
L["Normal Raid (10-30 players)"] = "Normal Raid (10-30 players)"
--Translation missing 
L["not imported"] = "not imported"
--Translation missing 
L["NPCs"] = "NPCs"
--Translation missing 
L["Obsidium Deposit"] = "Obsidium Deposit"
--Translation missing 
L["Obtained Achievement ID"] = "Obtained Achievement ID"
L["Obtained After %d Attempts"] = "Obtenido luego de %d Intentos"
--Translation missing 
L["Obtained as a rare project for the Fossil branch of archaeology"] = "Obtained as a rare project for the Fossil branch of archaeology"
--Translation missing 
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = "Obtained as a very rare project for the Tol'vir branch of archaeology"
--Translation missing 
L["Obtained as an archaeology project"] = "Obtained as an archaeology project"
--Translation missing 
L["Obtained by collecting a number of items"] = "Obtained by collecting a number of items"
--Translation missing 
L["Obtained by fishing"] = "Obtained by fishing"
--Translation missing 
L["Obtained by fishing in any water in Ironforge"] = "Obtained by fishing in any water in Ironforge"
--Translation missing 
L["Obtained by fishing in any water in Orgrimmar"] = "Obtained by fishing in any water in Orgrimmar"
--Translation missing 
L["Obtained by fishing in pools located in Terrokar Forest"] = "Obtained by fishing in pools located in Terrokar Forest"
--Translation missing 
L["Obtained by mining"] = "Obtained by mining"
--Translation missing 
L["Obtained by mining Elementium Vein"] = "Obtained by mining Elementium Vein"
--Translation missing 
L["Obtained by opening Crane Nests on the Timeless Isle"] = "Obtained by opening Crane Nests on the Timeless Isle"
--Translation missing 
L["Obtained by opening Snow Mound in Frostfire Ridge"] = "Obtained by opening Snow Mound in Frostfire Ridge"
--Translation missing 
L["Obtained by opening Timeless Chests on the Timeless Isle"] = "Obtained by opening Timeless Chests on the Timeless Isle"
--Translation missing 
L["Obtained by using an item or opening a container"] = "Obtained by using an item or opening a container"
L["Obtained On Your First Attempt"] = "Obtenido en tu primer intento"
--Translation missing 
L["Obtained Quest ID"] = "Obtained Quest ID"
--Translation missing 
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = "Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"
--Translation missing 
L["Odd Polished Stone"] = "Odd Polished Stone"
--Translation missing 
L["Ogre"] = "Ogre"
--Translation missing 
L["Oil Spill"] = "Oil Spill"
--Translation missing 
L["Oily Abyssal Gulper School"] = "Oily Abyssal Gulper School"
--Translation missing 
L["Oily Blackmouth School"] = "Oily Blackmouth School"
--Translation missing 
L["Oily Sea Scorpion School"] = "Oily Sea Scorpion School"
--Translation missing 
L["Old Crafty"] = "Old Crafty"
--Translation missing 
L["Old Ironjaw"] = "Old Ironjaw"
--Translation missing 
L["Old Man Barlo"] = "Old Man Barlo"
--Translation missing 
L["Ominous Flame"] = "Ominous Flame"
--Translation missing 
L["Ominous Pile of Snow"] = "Ominous Pile of Snow"
--Translation missing 
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = "One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."
--Translation missing 
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = "One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."
--Translation missing 
L["Only announce when found"] = "Only announce when found"
--Translation missing 
L["Only Raid Finder difficulty"] = "Only Raid Finder difficulty"
--Translation missing 
L["Ooze Covered Gold Vein"] = "Ooze Covered Gold Vein"
--Translation missing 
L["Ooze Covered Mithril Deposit"] = "Ooze Covered Mithril Deposit"
--Translation missing 
L["Ooze Covered Rich Thorium Vein"] = "Ooze Covered Rich Thorium Vein"
--Translation missing 
L["Ooze Covered Silver Vein"] = "Ooze Covered Silver Vein"
--Translation missing 
L["Ooze Covered Thorium Vein"] = "Ooze Covered Thorium Vein"
--Translation missing 
L["Ooze Covered Truesilver Deposit"] = "Ooze Covered Truesilver Deposit"
--Translation missing 
L["Options"] = "Options"
--Translation missing 
L["Orb of the Sin'dorei"] = "Orb of the Sin'dorei"
--Translation missing 
L["Orc"] = "Orc"
--Translation missing 
L["Orphaned Felbat"] = "Orphaned Felbat"
--Translation missing 
L["Other"] = "Other"
--Translation missing 
L["Other Requirements"] = "Other Requirements"
--Translation missing 
L["Overcomplicated Controller"] = "Overcomplicated Controller"
--Translation missing 
L["Paladin"] = "Paladin"
--Translation missing 
L["Pandaren"] = "Pandaren"
--Translation missing 
L["Pandaren Firework Launcher"] = "Pandaren Firework Launcher"
--Translation missing 
L["Panflute of Pandaria"] = "Panflute of Pandaria"
--Translation missing 
L["Parrot Cage (Green Wing Macaw)"] = "Parrot Cage (Green Wing Macaw)"
--Translation missing 
L["Parrot Cage (Hyacinth Macaw)"] = "Parrot Cage (Hyacinth Macaw)"
--Translation missing 
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = "Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."
--Translation missing 
L["Patch of Elemental Water"] = "Patch of Elemental Water"
--Translation missing 
L["Periwinkle Calf"] = "Periwinkle Calf"
--Translation missing 
L["Phoenix Hatchling"] = "Phoenix Hatchling"
--Translation missing 
L["Pineapple Lounge Cushion"] = "Pineapple Lounge Cushion"
--Translation missing 
L["Play a sound when groups are found"] = "Play a sound when groups are found"
--Translation missing 
L["Players have a personal loot chance to obtain this item."] = "Players have a personal loot chance to obtain this item."
--Translation missing 
L["Please enter a comma-separated list of item IDs."] = "Please enter a comma-separated list of item IDs."
--Translation missing 
L["Please enter a comma-separated list of NPC IDs."] = "Please enter a comma-separated list of NPC IDs."
--Translation missing 
L["Please enter a comma-separated list of Quest IDs."] = "Please enter a comma-separated list of Quest IDs."
--Translation missing 
L["Please enter a comma-separated list of Statistic IDs."] = "Please enter a comma-separated list of Statistic IDs."
--Translation missing 
L["Please enter a comma-separated list of zones."] = "Please enter a comma-separated list of zones."
--Translation missing 
L["Pool of Fire"] = "Pool of Fire"
--Translation missing 
L["Porcupette"] = "Porcupette"
--Translation missing 
L["Priest"] = "Priest"
--Translation missing 
L["Primal Egg"] = "Primal Egg"
--Translation missing 
L["Primary tooltip hide delay"] = "Primary tooltip hide delay"
--Translation missing 
L["Primary tooltip scale"] = "Primary tooltip scale"
L["Profile modified, rebooting"] = "Perfil modificado, reiniciando"
--Translation missing 
L["Profiling OFF"] = "Profiling OFF"
--Translation missing 
L["Profiling ON"] = "Profiling ON"
L["Progress"] = "Progreso"
--Translation missing 
L["Progress Bar"] = "Progress Bar"
--Translation missing 
L["Puddle Terror"] = "Puddle Terror"
--Translation missing 
L["Pugg"] = "Pugg"
--Translation missing 
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = "Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."
--Translation missing 
L["Pure Saronite Deposit"] = "Pure Saronite Deposit"
--Translation missing 
L["Pure Water"] = "Pure Water"
--Translation missing 
L["Put \"Rarity:\" on a separate line"] = "Put \"Rarity:\" on a separate line"
--Translation missing 
L["Putricide's Alchemy Supplies"] = "Putricide's Alchemy Supplies"
--Translation missing 
L["Pygmy Direhorn"] = "Pygmy Direhorn"
--Translation missing 
L["Pyrite Deposit"] = "Pyrite Deposit"
--Translation missing 
L["Quest ID"] = "Quest ID"
--Translation missing 
L["Quivering Blob"] = "Quivering Blob"
--Translation missing 
L["Raid Finder instance (legacy content; fixed at 25 players)"] = "Raid Finder instance (legacy content; fixed at 25 players)"
--Translation missing 
L["Raid Finder or Flexible difficulty"] = "Raid Finder or Flexible difficulty"
--Translation missing 
L["Rarity has %d |4coordinate:coordinates; for this item."] = "Rarity has %d |4coordinate:coordinates; for this item."
--Translation missing 
L["Rarity is loading..."] = "Rarity is loading..."
--Translation missing 
L["Rarity Item Pack String"] = "Rarity Item Pack String"
--Translation missing 
L["Rarity Tooltip Options"] = "Rarity Tooltip Options"
--Translation missing 
L["Rarity: "] = "Rarity: "
--Translation missing 
L["Razzashi Hatchling"] = "Razzashi Hatchling"
--Translation missing 
L["Red Goren Egg"] = "Red Goren Egg"
--Translation missing 
L["Red Helper Box"] = "Red Helper Box"
--Translation missing 
L["Red Qiraji Resonating Crystal"] = "Red Qiraji Resonating Crystal"
--Translation missing 
L["Redbelly Mandarin School"] = "Redbelly Mandarin School"
--Translation missing 
L["Red-Hot Coal"] = "Red-Hot Coal"
--Translation missing 
L["Reef Octopus Swarm"] = "Reef Octopus Swarm"
--Translation missing 
L["Reins of the Amber Primordial Direhorn"] = "Reins of the Amber Primordial Direhorn"
--Translation missing 
L["Reins of the Astral Cloud Serpent"] = "Reins of the Astral Cloud Serpent"
L["Reins of the Azure Drake"] = "Riendas del Draco Azur"
--Translation missing 
L["Reins of the Black Primal Raptor"] = "Reins of the Black Primal Raptor"
--Translation missing 
L["Reins of the Blazing Drake"] = "Reins of the Blazing Drake"
--Translation missing 
L["Reins of the Blue Drake"] = "Reins of the Blue Drake"
L["Reins of the Blue Proto-Drake"] = "Riendas del Protodraco Azul"
--Translation missing 
L["Reins of the Bone-White Primal Raptor"] = "Reins of the Bone-White Primal Raptor"
--Translation missing 
L["Reins of the Cobalt Primordial Direhorn"] = "Reins of the Cobalt Primordial Direhorn"
--Translation missing 
L["Reins of the Crimson Water Strider"] = "Reins of the Crimson Water Strider"
--Translation missing 
L["Reins of the Drake of the North Wind"] = "Reins of the Drake of the North Wind"
--Translation missing 
L["Reins of the Drake of the South Wind"] = "Reins of the Drake of the South Wind"
--Translation missing 
L["Reins of the Grand Black War Mammoth"] = "Reins of the Grand Black War Mammoth"
--Translation missing 
L["Reins of the Green Primal Raptor"] = "Reins of the Green Primal Raptor"
--Translation missing 
L["Reins of the Green Proto-Drake"] = "Reins of the Green Proto-Drake"
--Translation missing 
L["Reins of the Grey Riding Camel"] = "Reins of the Grey Riding Camel"
--Translation missing 
L["Reins of the Heavenly Onyx Cloud Serpent"] = "Reins of the Heavenly Onyx Cloud Serpent"
--Translation missing 
L["Reins of the Infinite Timereaver"] = "Reins of the Infinite Timereaver"
--Translation missing 
L["Reins of the Jade Primordial Direhorn"] = "Reins of the Jade Primordial Direhorn"
L["Reins of the Onyxian Drake"] = "Riendas del draco de Onixya"
L["Reins of the Raven Lord"] = "Riendas de Lord Cuervo"
--Translation missing 
L["Reins of the Slate Primordial Direhorn"] = "Reins of the Slate Primordial Direhorn"
--Translation missing 
L["Reins of the Thundering Cobalt Cloud Serpent"] = "Reins of the Thundering Cobalt Cloud Serpent"
--Translation missing 
L["Reins of the Thundering Onyx Cloud Serpent"] = "Reins of the Thundering Onyx Cloud Serpent"
L["Reins of the Vitreous Stone Drake"] = "Riendas del draco de piedra vítreo"
--Translation missing 
L["Reins of the White Polar Bear"] = "Reins of the White Polar Bear"
--Translation missing 
L["Remains of a Blood Beast"] = "Remains of a Blood Beast"
--Translation missing 
L["Repeatable"] = "Repeatable"
--Translation missing 
L["Required for %s"] = "Required for %s"
--Translation missing 
L["Requires a pool"] = "Requires a pool"
--Translation missing 
L["Requires Pickpocketing"] = "Requires Pickpocketing"
--Translation missing 
L["Rich Adamantite Deposit"] = "Rich Adamantite Deposit"
--Translation missing 
L["Rich Blackrock Deposit"] = "Rich Blackrock Deposit"
--Translation missing 
L["Rich Cobalt Deposit"] = "Rich Cobalt Deposit"
--Translation missing 
L["Rich Elementium Vein"] = "Rich Elementium Vein"
--Translation missing 
L["Rich Felslate Deposit"] = "Rich Felslate Deposit"
--Translation missing 
L["Rich Ghost Iron Deposit"] = "Rich Ghost Iron Deposit"
--Translation missing 
L["Rich Kyparite Deposit"] = "Rich Kyparite Deposit"
--Translation missing 
L["Rich Leystone Deposit"] = "Rich Leystone Deposit"
--Translation missing 
L["Rich Obsidium Deposit"] = "Rich Obsidium Deposit"
--Translation missing 
L["Rich Pyrite Deposit"] = "Rich Pyrite Deposit"
--Translation missing 
L["Rich Saronite Deposit"] = "Rich Saronite Deposit"
--Translation missing 
L["Rich Thorium Vein"] = "Rich Thorium Vein"
--Translation missing 
L["Rich Trillium Vein"] = "Rich Trillium Vein"
--Translation missing 
L["Rich True Iron Deposit"] = "Rich True Iron Deposit"
--Translation missing 
L["Riding Turtle"] = "Riding Turtle"
--Translation missing 
L["Right"] = "Right"
--Translation missing 
L["Right-Aligned"] = "Right-Aligned"
--Translation missing 
L["Rime of the Time-Lost Mariner"] = "Rime of the Time-Lost Mariner"
--Translation missing 
L["Rogue"] = "Rogue"
--Translation missing 
L["Rotten Helper Box"] = "Rotten Helper Box"
--Translation missing 
L["Ruby Droplet"] = "Ruby Droplet"
--Translation missing 
L["Rukdug"] = "Rukdug"
--Translation missing 
L["Runescale Koi School"] = "Runescale Koi School"
--Translation missing 
L["Sack of Spectral Spiders"] = "Sack of Spectral Spiders"
--Translation missing 
L["Safari Lounge Cushion"] = "Safari Lounge Cushion"
--Translation missing 
L["Sagefish School"] = "Sagefish School"
--Translation missing 
L["Sahn Tidehunter"] = "Sahn Tidehunter"
--Translation missing 
L["Salyin Battle Banner"] = "Salyin Battle Banner"
--Translation missing 
L["Salyin Warscout"] = "Salyin Warscout"
--Translation missing 
L["Saronite Deposit"] = "Saronite Deposit"
--Translation missing 
L["Sassy Imp"] = "Sassy Imp"
--Translation missing 
L["Satyr Charm"] = "Satyr Charm"
--Translation missing 
L["Savage Cub"] = "Savage Cub"
--Translation missing 
L["Savage Piranha Pool"] = "Savage Piranha Pool"
--Translation missing 
L["Scale"] = "Scale"
--Translation missing 
L["Scenario instance"] = "Scenario instance"
--Translation missing 
L["Scepter of Azj'Aqir"] = "Scepter of Azj'Aqir"
--Translation missing 
L["School of Darter"] = "School of Darter"
--Translation missing 
L["School of Deviate Fish"] = "School of Deviate Fish"
--Translation missing 
L["School of Tastyfish"] = "School of Tastyfish"
--Translation missing 
L["Schooner Wreckage"] = "Schooner Wreckage"
--Translation missing 
L["Schooner Wreckage Pool"] = "Schooner Wreckage Pool"
--Translation missing 
L["Scorched Stone"] = "Scorched Stone"
--Translation missing 
L["Scraps"] = "Scraps"
--Translation missing 
L["Sea Calf"] = "Sea Calf"
--Translation missing 
L["Sea Pony"] = "Sea Pony"
--Translation missing 
L["Sea Scorpion School"] = "Sea Scorpion School"
--Translation missing 
L["Sea Turtle"] = "Sea Turtle"
--Translation missing 
L["Seaborne Spore"] = "Seaborne Spore"
--Translation missing 
L["Secondary tooltip display"] = "Secondary tooltip display"
--Translation missing 
L["Servant of Demidos"] = "Servant of Demidos"
--Translation missing 
L["Servant's Bell"] = "Servant's Bell"
--Translation missing 
L["Session"] = "Session"
--Translation missing 
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = "Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."
--Translation missing 
L["Shadowhide Pearltusk"] = "Shadowhide Pearltusk"
--Translation missing 
L["Shaman"] = "Shaman"
--Translation missing 
L["Shard of Supremus"] = "Shard of Supremus"
--Translation missing 
L["Sha-Touched Spinefish"] = "Sha-Touched Spinefish"
--Translation missing 
L["Shell of Tide-Calling"] = "Shell of Tide-Calling"
--Translation missing 
L["Shift-Click to link your progress to chat"] = "Shift-Click to link your progress to chat"
--Translation missing 
L["Shift-Click to open options"] = "Shift-Click to open options"
--Translation missing 
L["Shipwreck Debris"] = "Shipwreck Debris"
--Translation missing 
L["Show anchor"] = "Show anchor"
--Translation missing 
L["Show attempts in tooltips"] = "Show attempts in tooltips"
--Translation missing 
L["Show auto refresh checkbox"] = "Show auto refresh checkbox"
--Translation missing 
L["Show category icons"] = "Show category icons"
--Translation missing 
L["Show Icon"] = "Show Icon"
--Translation missing 
L["Show Luckiness column"] = "Show Luckiness column"
--Translation missing 
L["Show minimap icon"] = "Show minimap icon"
--Translation missing 
L["Show Text"] = "Show Text"
--Translation missing 
L["Show Time column"] = "Show Time column"
--Translation missing 
L["Show Zone column"] = "Show Zone column"
--Translation missing 
L["Silver Vein"] = "Silver Vein"
--Translation missing 
L["Silver-Plated Turkey Shooter"] = "Silver-Plated Turkey Shooter"
--Translation missing 
L["Since last drop"] = "Since last drop"
--Translation missing 
L["Sira's Extra Cloak"] = "Sira's Extra Cloak"
--Translation missing 
L["Skrillix"] = "Skrillix"
--Translation missing 
L["Skull of a Frozen Whelp"] = "Skull of a Frozen Whelp"
--Translation missing 
L["Skunky Alemental"] = "Skunky Alemental"
--Translation missing 
L["Sky-Bo"] = "Sky-Bo"
--Translation missing 
L["Skyshard"] = "Skyshard"
--Translation missing 
L["Slithershock Elver"] = "Slithershock Elver"
--Translation missing 
L["Small Obsidian Chunk"] = "Small Obsidian Chunk"
--Translation missing 
L["Small Thorium Vein"] = "Small Thorium Vein"
--Translation missing 
L["Smashum Grabb"] = "Smashum Grabb"
--Translation missing 
L["Smelly Gravestone"] = "Smelly Gravestone"
--Translation missing 
L["Smoky Direwolf"] = "Smoky Direwolf"
--Translation missing 
L["Smoldering Egg of Millagazor"] = "Smoldering Egg of Millagazor"
--Translation missing 
L["Snarly's Bucket"] = "Snarly's Bucket"
L["Snow Mound"] = "Montículo de nieve"
--Translation missing 
L["Snowman Kit"] = "Snowman Kit"
--Translation missing 
L["Snowy Panda"] = "Snowy Panda"
--Translation missing 
L["Solar Spirehawk"] = "Solar Spirehawk"
--Translation missing 
L["Son of Animus"] = "Son of Animus"
--Translation missing 
L["Son of Galleon's Saddle"] = "Son of Galleon's Saddle"
--Translation missing 
L["Sorting by category, then name"] = "Sorting by category, then name"
--Translation missing 
L["Sorting by difficulty"] = "Sorting by difficulty"
--Translation missing 
L["Sorting by name"] = "Sorting by name"
--Translation missing 
L["Sorting by percent complete"] = "Sorting by percent complete"
--Translation missing 
L["Sorting by zone"] = "Sorting by zone"
--Translation missing 
L["Sparse Firefin Snapper School"] = "Sparse Firefin Snapper School"
--Translation missing 
L["Sparse Oily Blackmouth School"] = "Sparse Oily Blackmouth School"
--Translation missing 
L["Sparse Schooner Wreckage"] = "Sparse Schooner Wreckage"
--Translation missing 
L["Spawn of Horridon"] = "Spawn of Horridon"
--Translation missing 
L["Special case"] = "Special case"
--Translation missing 
L["Spectral Bell"] = "Spectral Bell"
--Translation missing 
L["Spell ID"] = "Spell ID"
--Translation missing 
L["Spiky Collar"] = "Spiky Collar"
--Translation missing 
L["Spineclaw Crab"] = "Spineclaw Crab"
--Translation missing 
L["Spinefish School"] = "Spinefish School"
--Translation missing 
L["Sporefish School"] = "Sporefish School"
--Translation missing 
L["Sprite Darter Egg"] = "Sprite Darter Egg"
--Translation missing 
L["Statistics"] = "Statistics"
--Translation missing 
L["Steam Pump Flotsam"] = "Steam Pump Flotsam"
--Translation missing 
L["Sting Ray Pup"] = "Sting Ray Pup"
--Translation missing 
L["Stonescale Eel Swarm"] = "Stonescale Eel Swarm"
--Translation missing 
L["Stormforged Rune"] = "Stormforged Rune"
--Translation missing 
L["Strand Crawler"] = "Strand Crawler"
--Translation missing 
L["Strange Pool"] = "Strange Pool"
--Translation missing 
L["Sultry Grimoire"] = "Sultry Grimoire"
--Translation missing 
L["Sun Sproutling"] = "Sun Sproutling"
--Translation missing 
L["Sunblade Rune of Activation"] = "Sunblade Rune of Activation"
--Translation missing 
L["Sunfire Kaliri"] = "Sunfire Kaliri"
--Translation missing 
L["Sunfur Panda"] = "Sunfur Panda"
--Translation missing 
L["Swarm of Panicked Paddlefish"] = "Swarm of Panicked Paddlefish"
--Translation missing 
L["Swift Brewfest Ram"] = "Swift Brewfest Ram"
--Translation missing 
L["Swift White Hawkstrider"] = "Swift White Hawkstrider"
--Translation missing 
L["Swift Zulian Panther"] = "Swift Zulian Panther"
--Translation missing 
L["Syd the Squid"] = "Syd the Squid"
--Translation missing 
L["Tainted Core"] = "Tainted Core"
--Translation missing 
L["Tainted Maulclaw"] = "Tainted Maulclaw"
--Translation missing 
L["Take screenshots"] = "Take screenshots"
--Translation missing 
L["Tangled Mantis Shrimp Cluster"] = "Tangled Mantis Shrimp Cluster"
--Translation missing 
L["Teeming Firefin Snapper School"] = "Teeming Firefin Snapper School"
--Translation missing 
L["Teeming Floating Wreckage"] = "Teeming Floating Wreckage"
--Translation missing 
L["Teeming Oily Blackmouth School"] = "Teeming Oily Blackmouth School"
--Translation missing 
L["Terrorfist"] = "Terrorfist"
--Translation missing 
L["Texture"] = "Texture"
--Translation missing 
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = "The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."
--Translation missing 
L["The Burning Crusade"] = "The Burning Crusade"
--Translation missing 
L["The following %d item(s) have been selected to export:"] = "The following %d item(s) have been selected to export:"
--Translation missing 
L["The Heartbreaker"] = "The Heartbreaker"
--Translation missing 
L["The Horseman's Reins"] = "The Horseman's Reins"
--Translation missing 
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = "The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."
--Translation missing 
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = "The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."
--Translation missing 
L["The name you entered is already being used by another item. Please enter a unique name."] = "The name you entered is already being used by another item. Please enter a unique name."
--Translation missing 
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = "The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."
--Translation missing 
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = "The number of players it takes to obtain the item. This will lower your chances of obtaining the item."
--Translation missing 
L["The Pigskin"] = "The Pigskin"
--Translation missing 
L["The quest starter item for Reins of the Llothien Prowler"] = "The quest starter item for Reins of the Llothien Prowler"
--Translation missing 
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = "The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."
--Translation missing 
L["The selected Rarity Item Pack string is invalid."] = "The selected Rarity Item Pack string is invalid."
--Translation missing 
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = "The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."
--Translation missing 
L["The Warbringer will be riding the mount color he has a chance to drop."] = "The Warbringer will be riding the mount color he has a chance to drop."
--Translation missing 
L["There are more holiday items available, but Rarity only reminds you about the first two."] = "There are more holiday items available, but Rarity only reminds you about the first two."
--Translation missing 
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = "These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = "This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."
--Translation missing 
L["This causes Rarity to put a blank line above its tooltip additions."] = "This causes Rarity to put a blank line above its tooltip additions."
--Translation missing 
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = "This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."
--Translation missing 
L["This item is only available to Alliance players."] = "This item is only available to Alliance players."
--Translation missing 
L["This item is only available to Horde players."] = "This item is only available to Horde players."
--Translation missing 
L["This mount is only obtainable by Alliance players"] = "This mount is only obtainable by Alliance players"
--Translation missing 
L["This mount is only obtainable by Horde players"] = "This mount is only obtainable by Horde players"
--Translation missing 
L["This tab lets you import and export items into and out of your Custom tab."] = "This tab lets you import and export items into and out of your Custom tab."
--Translation missing 
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = "This was a guaranteed drop for players who defeated the encounter when it was current"
--Translation missing 
L["Tiger Gourami School"] = "Tiger Gourami School"
--Translation missing 
L["Tiger Gourami Slush"] = "Tiger Gourami Slush"
--Translation missing 
L["Time"] = "Time"
--Translation missing 
L["Time spent farming"] = "Time spent farming"
--Translation missing 
L["Timeless Chest"] = "Timeless Chest"
--Translation missing 
L["Time-Locked Box"] = "Time-Locked Box"
--Translation missing 
L["Time-Lost Figurine"] = "Time-Lost Figurine"
--Translation missing 
L["Timewalker 5-player instance"] = "Timewalker 5-player instance"
--Translation missing 
L["Tin Vein"] = "Tin Vein"
--Translation missing 
L["Tiny Crimson Whelpling"] = "Tiny Crimson Whelpling"
--Translation missing 
L["Tiny Emerald Whelpling"] = "Tiny Emerald Whelpling"
--Translation missing 
L["Tiny Fel Engine Key"] = "Tiny Fel Engine Key"
--Translation missing 
L["Titanium Vein"] = "Titanium Vein"
--Translation missing 
L[ [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=] ] = [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=]
--Translation missing 
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = "To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."
--Translation missing 
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = "To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."
--Translation missing 
L["Today"] = "Today"
--Translation missing 
L["Toggles"] = "Toggles"
--Translation missing 
L["Tol'vir"] = "Tol'vir"
--Translation missing 
L["Tooltip can't be shown in combat"] = "Tooltip can't be shown in combat"
--Translation missing 
L["Toothy's Bucket"] = "Toothy's Bucket"
--Translation missing 
L["Torn Invitation"] = "Torn Invitation"
--Translation missing 
L["Total"] = "Total"
--Translation missing 
L["Total found"] = "Total found"
--Translation missing 
L["Toxic Wasteling"] = "Toxic Wasteling"
--Translation missing 
L["Toy or Item"] = "Toy or Item"
--Translation missing 
L["Toys & Items"] = "Toys & Items"
--Translation missing 
L["Track this"] = "Track this"
--Translation missing 
L["Trillium Vein"] = "Trillium Vein"
--Translation missing 
L["Troll"] = "Troll"
--Translation missing 
L["True Iron Deposit"] = "True Iron Deposit"
--Translation missing 
L["Truesilver Deposit"] = "Truesilver Deposit"
--Translation missing 
L["Tundra Icehoof"] = "Tundra Icehoof"
--Translation missing 
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = "Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."
--Translation missing 
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = "Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."
--Translation missing 
L["Type of item"] = "Type of item"
--Translation missing 
L["Unable to retrieve item information from the server"] = "Unable to retrieve item information from the server"
--Translation missing 
L["Unavailable"] = "Unavailable"
--Translation missing 
L["Undefeated"] = "Undefeated"
--Translation missing 
L["Unknown"] = "Unknown"
--Translation missing 
L["Unlucky"] = "Unlucky"
--Translation missing 
L["unlucky"] = "unlucky"
--Translation missing 
L["Unscathed Egg"] = "Unscathed Egg"
--Translation missing 
L["Unstable Powder Box"] = "Unstable Powder Box"
--Translation missing 
L["Unusual Compass"] = "Unusual Compass"
--Translation missing 
L["Use your bonus roll for a chance at this item"] = "Use your bonus roll for a chance at this item"
--Translation missing 
L["Usually requires a group of around %d players"] = "Usually requires a group of around %d players"
--Translation missing 
L["Valarjar Stormwing"] = "Valarjar Stormwing"
--Translation missing 
L["Vengeance"] = "Vengeance"
--Translation missing 
L["Verbose"] = "Verbose"
--Translation missing 
L["Vibrating Arcane Crystal"] = "Vibrating Arcane Crystal"
--Translation missing 
L["Vile Blood of Draenor"] = "Vile Blood of Draenor"
--Translation missing 
L["Viscidus Globule"] = "Viscidus Globule"
--Translation missing 
L["Void Collar"] = "Void Collar"
--Translation missing 
L["Vrykul"] = "Vrykul"
--Translation missing 
L["Warlock"] = "Warlock"
--Translation missing 
L["Warlords of Draenor"] = "Warlords of Draenor"
--Translation missing 
L["Warm Arcane Crystal"] = "Warm Arcane Crystal"
--Translation missing 
L["Warning Sign"] = "Warning Sign"
--Translation missing 
L["Warrior"] = "Warrior"
--Translation missing 
L["Warsong Direfang"] = "Warsong Direfang"
--Translation missing 
L["Waterlogged Wreckage"] = "Waterlogged Wreckage"
--Translation missing 
L["Waterlogged Wreckage Pool"] = "Waterlogged Wreckage Pool"
--Translation missing 
L["Weebomination"] = "Weebomination"
--Translation missing 
L["Welcome to Rarity r%d. Your settings have been reset."] = "Welcome to Rarity r%d. Your settings have been reset."
--Translation missing 
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = "When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."
--Translation missing 
L["When enabled, Rarity tooltips will include how many attempts you've made."] = "When enabled, Rarity tooltips will include how many attempts you've made."
--Translation missing 
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = "When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."
--Translation missing 
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = "When enabled, Rarity will add obtainable items to game tooltips whenever possible."
--Translation missing 
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = "When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."
--Translation missing 
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = "When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."
--Translation missing 
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = "When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."
--Translation missing 
L["When on, items marked as Defeated will be hidden from the tooltip."] = "When on, items marked as Defeated will be hidden from the tooltip."
--Translation missing 
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = "When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."
--Translation missing 
L["When on, items that have no attempts yet will be hidden from the tooltip."] = "When on, items that have no attempts yet will be hidden from the tooltip."
--Translation missing 
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = "When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."
--Translation missing 
L[ [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=] ] = [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=]
--Translation missing 
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = "When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."
--Translation missing 
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = "When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."
--Translation missing 
L["When on, the Luckiness column will be shown in the main tooltip."] = "When on, the Luckiness column will be shown in the main tooltip."
--Translation missing 
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = "When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."
--Translation missing 
L["When on, the Time column will be shown in the main tooltip."] = "When on, the Time column will be shown in the main tooltip."
--Translation missing 
L["When on, the Zone column will be shown in the main tooltip."] = "When on, the Zone column will be shown in the main tooltip."
--Translation missing 
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = "When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."
--Translation missing 
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = "When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."
--Translation missing 
L["Whistle of Chromatic Bone"] = "Whistle of Chromatic Bone"
--Translation missing 
L["White Trillium Deposit"] = "White Trillium Deposit"
--Translation missing 
L["Width"] = "Width"
--Translation missing 
L["Wild Dreamrunner"] = "Wild Dreamrunner"
--Translation missing 
L["Wild Goretusk"] = "Wild Goretusk"
--Translation missing 
L["will be imported"] = "will be imported"
--Translation missing 
L["Will only drop for druids."] = "Will only drop for druids."
--Translation missing 
L["Wisp in a Bottle"] = "Wisp in a Bottle"
--Translation missing 
L["World Tooltip Options"] = "World Tooltip Options"
--Translation missing 
L["Worn Troll Dice"] = "Worn Troll Dice"
--Translation missing 
L["Wrath of the Lich King"] = "Wrath of the Lich King"
--Translation missing 
L["Wriggling Darkness"] = "Wriggling Darkness"
--Translation missing 
L["Yesterday"] = "Yesterday"
--Translation missing 
L["You already defeated %d of them."] = "You already defeated %d of them."
--Translation missing 
L["You already defeated all of them."] = "You already defeated all of them."
--Translation missing 
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = "You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."
--Translation missing 
L["You entered a achievement ID that is already being used by another item."] = "You entered a achievement ID that is already being used by another item."
--Translation missing 
L["You entered a creature ID that is already being used by another item."] = "You entered a creature ID that is already being used by another item."
--Translation missing 
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = "You entered a reserved name. Please enter the correct item name as it appears in game."
--Translation missing 
L["You entered a spell ID that is already being used by another item."] = "You entered a spell ID that is already being used by another item."
--Translation missing 
L["You entered an item ID that is already being used by another item."] = "You entered an item ID that is already being used by another item."
--Translation missing 
L["You entered an item ID that is already set as the collected item for something else."] = "You entered an item ID that is already set as the collected item for something else."
--Translation missing 
L["You must enter a creature ID."] = "You must enter a creature ID."
--Translation missing 
L["You must enter a number larger than 0."] = "You must enter a number larger than 0."
--Translation missing 
L["You must enter a number larger than 1."] = "You must enter a number larger than 1."
--Translation missing 
L["You must enter a number larger than or equal to 0."] = "You must enter a number larger than or equal to 0."
--Translation missing 
L["You must enter a spell ID."] = "You must enter a spell ID."
--Translation missing 
L["You must enter a valid number."] = "You must enter a valid number."
--Translation missing 
L["You must enter an amount."] = "You must enter an amount."
--Translation missing 
L["You must enter an item ID."] = "You must enter an item ID."
--Translation missing 
L["You must enter at least one item ID."] = "You must enter at least one item ID."
--Translation missing 
L["You must enter at least one NPC ID."] = "You must enter at least one NPC ID."
--Translation missing 
L["You must enter at least one Statistic ID."] = "You must enter at least one Statistic ID."
--Translation missing 
L["You must enter at least one zone."] = "You must enter at least one zone."
--Translation missing 
L["Young Talbuk"] = "Young Talbuk"
--Translation missing 
L["Young Venomfang"] = "Young Venomfang"
--Translation missing 
L["Zandalari Anklerender"] = "Zandalari Anklerender"
--Translation missing 
L["Zandalari Footslasher"] = "Zandalari Footslasher"
--Translation missing 
L["Zandalari Kneebiter"] = "Zandalari Kneebiter"
--Translation missing 
L["Zandalari Toenibbler"] = "Zandalari Toenibbler"
--Translation missing 
L["Zangar Spore"] = "Zangar Spore"
--Translation missing 
L["Zhevra Lounge Cushion"] = "Zhevra Lounge Cushion"
--Translation missing 
L["Zomstrok"] = "Zomstrok"
--Translation missing 
L["Zone"] = "Zone"
--Translation missing 
L["Zones"] = "Zones"

end

L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "frFR")
if L then
L[" (Group)"] = "(Groupe)"
L["#%d: %d attempt (%.2f%%)"] = "#%d: %d essai (%.2f%%)"
L["#%d: %d attempts (%.2f%%)"] = "#%d: %d essais (%.2f%%)"
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = "%d |4point de navigation:points de navigation; |4est situé:sont situés; dans |4une instance:des instances; et |4n'a pas été ajouté:n'ont pas été ajoutés;."
L["%d |4zone:zones;"] = true
L["%d attempt"] = "%d essai"
L["%d attempt - %.2f%%"] = "%d essai - %.2f%%"
L["%d attempts"] = "%d essais"
L["%d attempts - %.2f%%"] = "%d essais - %.2f%%"
L["%d collected - %.2f%%"] = "%d collectés - %.2f%%"
L["%s: %d attempt"] = "%s: %d essai"
L["%s: %d attempt - %.2f%%"] = "%s: %d essai - %.2f%%"
L["%s: %d attempt (%d total)"] = "%s: %d essai (%d total)"
L["%s: %d attempts"] = "%s: %d essais"
L["%s: %d attempts - %.2f%%"] = "%s: %d essais - %.2f%%"
L["%s: %d attempts (%d total)"] = "%s: %d essais (%d total)"
L["%s: %d collected"] = "%s : %d |4collecté:collectés;"
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = "%s: 0/%d essai à ce jour (%.2f%% - %s)"
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = "%s: 0/%d essais à ce jour (%.2f%% - %s)"
L["%s: collection completed!"] = "%s: collection terminée !"
L["%s: Found after %d attempts!"] = "%s : trouvé après %d essais !"
L["%s: Found on the first attempt!"] = "%s : Trouvé à la première tentative !"
L["(%d/%d attempts)"] = "(%d/%d essais)"
L["(%d/%d collected)"] = "(%d/%d collectés)"
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = "(Les objets listés en rouge n'ont pas pu être trouvés sur le serveur et peuvent ne pas exister. Vous devriez considérer de les retirer.)"
L["(running in debug mode)"] = "(lancé en mode de debuggage)"
L["(Warning: item could not be retrieved from server)"] = "(Attention : l'objet n'a pas pu être récupéré depuis le serveur)"
L["1 in %d chance"] = "1 chance sur %d"
L["10-player Heroic Raid instance (legacy content; not flexible)"] = "Raid héroïque 10 joueurs (contenu héritage, non dynamique)"
L["10-player Raid instance (legacy content; not flexible)"] = "Raid 10 joueurs (contenu héritage, non dynamique)"
L["25-player Event scenario"] = "Scénario d'événement à 25 joueurs"
L["25-player heroic"] = "Héroïque à 25 joueurs"
L["25-player Heroic Raid instance (legacy content; not flexible)"] = "Raid héroïque 25 joueurs (contenu héritage, non dynamique)"
L["25-player Raid instance (legacy content; not flexible)"] = "Raid 25 joueurs (contenu héritage, non dynamique)"
L["40-player Event raid"] = "Raid d'événement à 40 joueurs"
L["40-player Raid instance (legacy content; not flexible)"] = "Raid 40 joueurs (contenu héritage, non dynamique)"
L["5-player Event instance"] = "Donjon d'événement à 5 joueurs"
L["5-player Heroic instance"] = "Donjon héroïque 5 joueurs"
L["5-player instance"] = "Donjon 5 joueurs"
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = "Une liste des identifiants des objets qui, lorsque utilisés ou ouverts, peuvent vous donner cet objet. Utilisez WowHead ou un service similaire pour trouver les identifiants des objets."
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = "Une liste des identifiants des PNJs qui laissent tomber cet objet. Utilisez WowHead ou un service similaire pour trouver les identifiants des PNJs."
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = "Une liste d'identifiants de quêtes séparés par des virgules. Lorsque ces quêtes seront terminées, l'objet sera considéré comme Vaincu."
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = "Une liste d'identifiants de statistiques séparés par des virgules qui suit le nombre de mises à mort pour obtenir cet objet."
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = "Une liste d'identifiants de statistiques séparés par des virgules qui suit le nombre de mises à mort pour obtenir cet objet. Ces statistiques seront combinées. Utilisez WowHead ou un service similaire pour obtenir les identifiants de statistiques."
L[ [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=] ] = [=[Une liste de zones ou de sous-zones séparées par des virgules dans lesquelles cet objet peut être trouvé. Pour les zones, vous pouvez saisir soit l'identifiant de la carte (ex: 811 pour le Val de l’Éternel printemps), soit le nom complet de la zone. Pour les sous-zones, vous devez entrer le nom complet de la sous-zone.

Entrez les noms de zones avec l'orthographe correct, la capitalisation et la ponctuation. Ils peuvent être entrés en Anglais US ou dans la langue de votre client. Utilisez WowHead ou un service similaire pour être certain que vous entrez le nom des zones parfaitement.

NOTE : La traduction des zones peut être incorrecte. Pour les zones, il est recommandé d'utiliser l'identifiant de la carte plutôt que le nom. Pour les sous-zones, vous devez saisir le nom. Si la détection des sous-zones ne marche pas pour vous, veuillez visiter la page LibBabble-SubZone-3.0 de wowace.com et mettre à jour les traductions pour votre langue.]=]
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = "L'identifiant d'un donjon qui, lorsque signalé comme terminé par le client du jeu, provoquera le statut Vaincu pour cet objet. Ceci est principalement utilisé pour les objets des événements saisonniers qui ont des identifiants de donjon uniques."
L["A holiday event is available today for %s! Go get it!"] = "Un événement saisonnier est disponible aujourd'hui pour obtenir %s ! Allez-y !"
L["Abundant Bloodsail Wreckage"] = "Débris abondants de la Voile sanglante"
L["Abundant Firefin Snapper School"] = "Banc abondant de lutjans de nagefeu"
L["Abundant Oily Blackmouth School"] = "Banc abondant de bouches-noires huileux"
--Translation missing 
L["Abyss Worm"] = "Abyss Worm"
L["Abyssal Gulper School"] = "Banc de grangousiers des abysses"
L["Adamantite Deposit"] = "Gisement d'adamantite"
L["Added %d |4waypoint:waypoints; to TomTom"] = "%d |4point de navigation ajouté:points de navigation ajoutés; à TomTom."
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = "Ajuste la taille de l'infobulle principale. Ceci prendra effet la prochaine fois que l'infobulle s'affichera."
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = "Après avoir amélioré votre Cabane de pêche du fief au niveau 3, pêchez une Carpe de Chutelune ou un Vairon givre-profond pour attirer un troglodyte qui pourra vous donner cette monture."
--Translation missing 
L["Ageless Bronze Drake"] = "Ageless Bronze Drake"
L["Ahune"] = true
L["Ai-Li's Skymirror"] = "Moire ciel d’Ai Li"
L["Ai-Ran the Shifting Cloud"] = "Ai Ran le Nuage Fantasque"
--Translation missing 
L["Albino Buzzard"] = "Albino Buzzard"
L["Albino Cavefish School"] = "Banc de tétras cavernicoles albinos"
L["Albino Chimaeraling"] = "Chimérion albinos"
L["Algaefin Rockfish School"] = "Banc de sébastes nagealgue"
L["All players can participate in killing this world boss once per week, regardless of faction"] = "Tous les joueurs peuvent participer au combat face à ce world boss une fois par semaine, peu importe la faction."
L["All raid formats except Raid Finder"] = "Tous les formats de raid à l'exception de la recherche de raid"
L["Alliance only"] = "Alliance uniquement"
L["Already defeated"] = "Déjà vaincu"
L["Already defeated for %s"] = "Déjà vaincu pour %s"
L["Already known"] = "Déjà connu"
L["an item already exists by this name, so it will not be imported"] = "Un objet avec ce nom existe déjà, et ne sera pas importé."
L["an item with the same Item ID already exists, so it will not be imported"] = "Un objet avec le même identifiant d'objet existe déjà, et ne sera pas importé."
L["Ancient Mana"] = "Mana ancestral"
L["and %d |4other zone:other zones;"] = "et %d |4autre zone:autres zones;"
L["Announce"] = "Annoncer"
L["Announcements"] = "Annonces"
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = "Les annonces s'afficheront uniquement lorsque l'objet sera trouvé. Quand ceci est désactivé, Rarity annoncera chaque essai et lorsque l'objet sera trouvé."
L["Anubisath Idol"] = "Idole d’Anubisath"
L["Any difficulty"] = "Toutes les difficultés"
L["Any raid size"] = "Toutes les tailles de raid"
L["Any raid size or difficulty"] = "N'importe quelle taille ou difficulté de raid"
L["Appears in the Black Market"] = "Apparaît au Marché noir."
L["Aqua Jewel"] = "Joyau d'eau"
L["Arakkoa"] = true
--Translation missing 
L["Arcano-Shower"] = "Arcano-Shower"
L["Archaeology race"] = "Race d'archéologie"
L["Are you sure you want to delete this item?"] = "Etes-vous certain de vouloir supprimer cet objet ?"
L["Are you sure you want to import the Rarity Item Pack you entered?"] = "Etes-vous sûr de vouloir importer le pack d'objets Rarity que vous avez entré ?"
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = "Etes-vous sûr de vouloir décocher la case Exporter cet objet de tous vos objets personnalisés ?"
L["Armored Razorback"] = "Tranchedos cuirassé"
L["Armored Razzashi Raptor"] = "Raptor razzashi cuirassé"
L["Ash-Covered Horn"] = "Corne couverte de cendres"
L["Ashes of Al'ar"] = "Cendres d'Al'ar"
L["Ashleaf Spriteling"] = "Petit lutin feuille-d’orne"
L["Attempts"] = "Essais"
L["Auto"] = true
L["Available starting December 25th"] = "Disponible à partir du 25 décembre"
L["Azure Crane Chick"] = "Gruon azur"
L["Azure Whelpling"] = "Bébé dragonnet azur"
L["Battle Horn"] = "Cor de bataille"
L["Battle Pet"] = "Mascotte de combat"
L["Battle Pets"] = "Mascottes de combat"
L["Big Love Rocket"] = "Grande fusée d'amour"
L["Black Barracuda School"] = "Banc de barracudas noirs"
L["Black Trillium Deposit"] = "Gisement de trillium noir"
L["Blackbelly Mudfish School"] = "Banc d'éperlans ventre-noir"
L["Blackflame Daggers"] = "Dagues de la flamme noire"
L["Blackfuse Bombling"] = "Bombinette Boîte-Noire"
L["Blackhoof"] = "Sabot d’Encre"
L["Blackrock Deposit"] = "Gisement de rochenoire"
L["Blackwater Whiptail School"] = "Banc de hokis des flots noirs"
L["Blackwing Banner"] = "Bannière de l’Aile noire"
L["Blank line before tooltip additions"] = "Retour à la ligne avant les ajouts dans les infobulles"
L["Blazing Rune"] = "Rune flamboyante"
L["Bleakclaw"] = "Morne-Serre"
--Translation missing 
L["Blessed Seed"] = "Blessed Seed"
--Translation missing 
L["Blight Boar Microphone"] = "Blight Boar Microphone"
L["Blighted Spore"] = "Spore chancreux"
L["Blind Lake Sturgeon School"] = "Banc d’esturgeons jaunes aveugles"
L["Bloodsail Wreckage"] = "Débris de la Voile sanglante"
L["Bloodsail Wreckage Pool"] = "Débris de la Voile sanglante"
L["Bluefish School"] = "Banc de tassergals"
L["Bone Serpent"] = "Serpent d’os"
L["Bonkers"] = "Foldingue"
L["Borean Man O' War School"] = "Banc de poissons-méduses boréens"
L["Boss Name"] = "Nom du Boss"
L["Bottled Tornado"] = "Tornade en bouteille"
L["Brackish Mixed School"] = "Banc mixte en eaux saumâtres"
L["Brew Frenzied Emperor Salmon"] = "Saumon empereur affolé par la bière"
L["Brilliant Phoenix Hawk Feather"] = "Plume de jeune faucon-phénix brillante"
L["Brinedeep Bottom-Feeder"] = "Saumefond benthique"
L["Bristling Hellboar"] = "Sanglier infernal hirsute"
--Translation missing 
L["Bronze Proto-Whelp"] = "Bronze Proto-Whelp"
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = "Bunny Hunter est actif. Voulez-vous que Rarity importe les données depuis Bunny Hunter maintenant ? Désactivez Bunny Hunter ou cliquez sur Oui si vous ne voulez pas être de nouveau interrogé."
L["Burgy Blackheart's Handsome Hat"] = "Beau chapeau de Burgy Cœur-noir"
--Translation missing 
L["Call of the Frozen Blade"] = "Call of the Frozen Blade"
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = "Peut être obtenu dans la Boîte en forme de cœur, en terminant le donjon de l'évènement saisonnier De l'amour dans l'air."
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = "Peut être obtenu dans le Coffre au trésor en forme de tonneau, en terminant le donjon de l'évènement saisonnier La Fête des Brasseurs."
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = "Peut être obtenu dans la Citrouille remplie de butin, en terminant le donjon de l'évènement saisonnier La Sanssaint."
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = "Peut être obtenu dans la Cage en fer cliquetante, qui a une chance de se trouver sur n'importe lequel des quatre champions de la Citadelle des Flammes infernales dans la Jungle de Tanaan (Poing-de-terreur, Serres-mort, Vengeance ou Compresseur funeste). Chacun d'entre eux peut être fouillé une fois par jour. Rarity considèrera cette monture \"Vaincu\" pour la journée lorsque vous tuez l'un des quatre."
L["Can be obtained with a bonus roll"] = "Peut être obtenu via un jet de dé bonus."
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = "Peut se trouver dans les Fournitures pour mascottes touchées par la gangrène, qui sont obtenues en venant à bout des mascottes légendaires gangrénées dans la jungle de Tanaan."
L["Captured Firefly"] = "Luciole capturée"
L["Cat Carrier (Black Tabby)"] = "Panier à chat (tigré noir)"
L["Cataclysm"] = "Cataclysme"
--Translation missing 
L["Cavern Moccasin"] = "Cavern Moccasin"
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = "Certains objets, comme les Illusions dans votre garde-robe, renvoient un identifiant de quête terminée quand vous les apprenez. Rarity peut automatiquement arrêter de suivre cet objet si vous entrez cet identifiant de quête ici. (seulement un identifiant, pas une liste.)"
L["Chain Pet Leash"] = "Laisse en chaîne pour mascotte"
L["Chalice of Secrets"] = "Calice de secrets"
L["Challenge Mode instance"] = "Donjon en mode Défi"
L["Chance"] = true
L["Chance so far"] = "Chance à ce jour"
L["Chaos Pup"] = "Louveteau du chaos"
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = "Cochez ceci pour chaque objet personnalisé que vous souhaitez exporter. Puis cliquez sur l'onglet Import/Export et sur le bouton Export. Ce case à cocher sera désactiver jusqu'à ce qu'assez d'informations aient été remplies ci-dessous pour en faire un objet détectable."
L[ [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=] ] = "Cochez ceci pour actualiser automatiquement votre recherche toutes les 5 secondes tant que cette fenêtre est ouverte. L'actualisation automatique ne fonctionne que si vous avez tapé quelque chose dans la case de recherche, et si vous n'avez rien sélectionné dans la liste ci-dessous."
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = "Choisissez pour quelle(s) classe(s) cet objet doit être désactivé. Cocher une classe ci-dessous cachera l'objet de l'infobulle de Rarity et empêchera le suivi. Vous pouvez toujours activer Suivre ceci, mais cet objet ne sera pas suivi pour les classes sélectionnées ici."
L["Christoph VonFeasel"] = true
--Translation missing 
L["Chromie"] = "Chromie"
L["Chuck's Bucket"] = "Seau de Chuck"
L["Classic"] = "Classique"
L["Clear All Exports"] = "Effacer tous les exports"
L["Click to switch to this item"] = "Cliquer pour passer à cet objet."
L["Click to toggle the progress bar"] = "Clic sur un objet pour afficher la barre de progression"
L["Clockwork Rocket Bot"] = "Rob-fusée mécanique"
L["Close"] = "Fermer"
--Translation missing 
L["Cloudwing Hippogryph"] = "Cloudwing Hippogryph"
L["Clutch of Ji-Kun"] = "Etreinte de Ji Kun"
L["Cobalt Deposit"] = "Gisement de cobalt"
L["Coin of Many Faces"] = "Pièce aux nombreuses faces"
L["Collect %d %s"] = "Collecter %d %s"
L["Collected"] = "Collectés"
L["Collection Complete"] = "Collecte terminée"
L["Collection complete!"] = "Collecte terminée!"
L["Collection Size"] = "Taille de la collection"
L["Contained in bonus satchels"] = "Contenu dans les sacoches bonus."
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = "Cette monture a 5% de chance d'apparaitre dans l'Oeuf brisé, lequel est obtenu en devant Révéré auprès des Oracles, en achetant un Oeuf mystérieux auprès de leur intendant, puis en attendant trois jours."
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = "Cette monture a 3% de chance d'apparaitre dans le Butin hyldnir, lequel est obtenu en récompense des quêtes journalières données par Gretta la Médiatrice à Brunnhildar dans les pics Foudroyés."
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = "Contenu dans la Jarre dégoûtante mûre, laquelle est obtenue en devenant Révéré auprès de la Tribu Frénécœur, en achetant une Jarre dégoûtante auprès de leur intendant, puis en attendant trois jours."
L["Content Category"] = "Catégorie de contenu"
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = "Définit de quel coté l'infobulle secondaire apparaît lorsque vous survolez un objet dans l'infobulle principale. Si l'infobulle principale est du coté droit de l'écran, placez ceci sur Gauche. Autrement, choisissez Droite. Vous pouvez aussi cacher l'infobulle secondaire complètement."
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = "Définit quel type de texte est utilisé dans le flux LDB de Rarity. Minimal n'indique que le nombre d'essais. Normal ajoute la probabilité en pourcentage, et verbose ajoute le lien de l'objet."
L["Copper Vein"] = "Filon de cuivre"
L[ [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=] ] = [=[Copiez le lien du pack d'objets Rarity généré ci-dessous en utilisant Ctrl+C. Vous pouvez ensuite le coller ailleurs en utilisant Ctrl+V.

N'hésitez pas à commenter sur le site Curse pour partager vos liens de pack d'objets. Allara affichera les meilleurs sur la page principale de l'add-on !]=]
L["Core of Hardened Ash"] = "Noyau de cendre pétrifiée"
L["Corrupted Nest Guardian"] = "Gardien de nid corrompu"
L["Corrupted Thundertail"] = "Foudrequeue corrompu"
L["Crane Nest"] = "Nid de grues"
L["Crashin' Thrashin' Cannon Controller"] = "Commande de Cogn’Baff à canon"
L["Crashin' Thrashin' Flyer Controller"] = "Commande du Cogn’Baff volant"
L["Crashin' Thrashin' Mortar Controller"] = "Commande de Cogn’Baff mortier"
L["Crashin' Thrashin' Racer Controller"] = "Commande du Cogn’Baff de course"
L["Crashin' Thrashin' Roller Controller"] = "Commande de Cogn’Baff compresseur"
L["Create a New Item"] = "Créer un nouvel objet"
L["Create a new item to track"] = "Créer un nouvel objet à suivre"
L["Creature ID"] = "ID de la créature"
L["Crowded Redbelly Mandarin"] = "Mandarins ventre-rouge agglutinés"
--Translation missing 
L["Crysa"] = "Crysa"
L["Crystal of the Void"] = "Cristal du Vide"
L["Ctrl-Click to change sort order"] = "Ctrl+Clic pour modifier l'ordre d'affichage"
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = "Ctrl+Clic pour créer le ou les points de navigation TomTom restants."
L["Ctrl-Click to create TomTom waypoint(s)."] = "Ctrl+Clic pour créer un ou des points de navigation TomTom."
L["Cupri"] = true
L["Curious Wyrmtongue Cache"] = "Cache de langue-de-wyrm curieux"
L["Cursed Queenfish School"] = "Banc de talangs maudits"
L["Cursed Spirit"] = "Esprit maudit"
L["Custom"] = "Personnalisé"
L["Dandelion Frolicker"] = "Jonquille boute-en-train"
L["Dark Gazer"] = "Sombre contemplateur"
L["Dark Iron Deposit"] = "Gisement de sombrefer"
L["Dark Quivering Blob"] = "Goutte tremblante sombre"
L["Dark Whelpling"] = "Bébé dragonnet sombre"
L["Darkmoon Eye"] = "Oeil de Sombrelune"
L["Data has been imported from Bunny Hunter"] = "Les données ont été importées depuis Bunny Hunter."
L["Death Adder Hatchling"] = "Jeune aspic mortel"
L["Death Knight"] = "Chevalier de la mort"
L["Deathcharger's Reins"] = "Rênes de destrier de la mort"
L["Deathtalon"] = "Serres-mort"
L["Debug mode"] = "Mode Debug"
L["Debug mode OFF"] = "Mode de débuggage DESACTIVE"
L["Debug mode ON"] = "Mode de débuggage ACTIVE"
L["Decahedral Dwarven Dice"] = "Dés nains décaèdraux"
L["Deep Sea Monsterbelly School"] = "Banc de baudroies abyssales"
L["Deepsea Sagefish School"] = "Banc de sagerelles abyssales"
L["Defeat Detection"] = "Détection de Vaincu"
L["Defeated"] = "Vaincu"
L["Defiled Earth"] = "Terre profanée"
L["Delete this item"] = "Supprimer cet objet"
L["Demon Hunter"] = "Chasseur de démons"
L["Demonic"] = "Démoniaque"
L["Determines how this item is obtained."] = "Détermine la manière dont cet objet est obtenu."
L["Determines what type of item this is."] = "Détermine le type de l'objet."
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = "Détermine si l'objet peut seulement être acquis en pêchant dans un banc. Pour que cette option fonctionne, les bancs doivent tous avoir été traduits dans la langue de votre client."
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = "Détermine si l'affichage du suivi doit être activé pour cet objet. Les objets qui ne sont pas activés n'apparaissent pas dans l'infobulle."
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = "Détermine si vous voulez obtenir cet objet plusieurs fois. Si cela est activé et que l'objet est trouvé, Rarity affichera cet objet comme non-trouvé après quelques secondes."
L[ [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=] ] = [=[Détermine dans quelle difficulté d'instance cet objet peut être obtenu. Laissez vide si la difficulté de l'instance ne change rien.

Si vous avez spécifié un identifiant statistique pour cet objet, alors la difficulté de l'instance est probablement obsolète, car toute les identifiants statistique récents incorpore déjà la difficulté.

Vous pouvez cocher plusieurs cases dans cette liste à la fois.]=]
L["Determines which race includes this archaeology project."] = "Détermine quelle race est concernée par ce projet d'archéologie."
L["Deviate Hatchling"] = "Bébé raptor déviant"
L["Direflame"] = "Navreflamme"
L["Direhorn Runt"] = "Navrecorne frêle"
L["Disable for classes"] = "Désactivé pour les classes"
L["Disgusting Oozeling"] = "Suinteux dégoûtant"
--Translation missing 
L["Displacer Meditation Stone"] = "Displacer Meditation Stone"
L["Distance"] = true
L["Don Carlos' Famous Hat"] = "Célèbre chapeau de don Carlos"
L["Doomroller"] = "Compresseur funeste"
L["Draenei"] = "Draeneï"
L["Draenor Clans"] = "Clans de Draenor"
L["Draenor Garrison"] = "Fief de Draenor"
L["Dragonfin Angelfish School"] = "Banc de demoiselles aileron-de-dragon"
L["Drakum"] = true
L["Dreadwalker"] = "Marcheur de l’effroi"
L["Dripping Strider Egg"] = "Oeuf de trotteur visqueux"
L["Droplet of Y'Shaarj"] = "Gouttelette d’Y’Shaarj"
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = "Obtenu sur tout les monstres du Val de l’Éternel printemps (sauf les monstres mineurs). Combinez-en 10 pour percer le bouclier d'Alani et engager le combat avec une chance garantie d'obtenir les Rênes de serpent-nuage de rubis fulminant."
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = "Obtenu sur les dinosaures de l'Île des Géants. Éclora après trois jours pour donner l'une de trois montures Raptors primordiaux."
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = "Butin de Boguelin perturbé, lequel a une chance d'apparaître quand vous ramassez des herbes en Draenor."
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = "Butin d'Elegon aux Caveaux Mogu'shan (tous les formats de raid à l'exception de la recherche de raid)."
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = "Butin de Protecteur goren, lequel a une chance d'apparaître quand vous minez un filon en Draenor."
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = "Obtenu sur Koralon le Veilleur des flammes, Emalon le Guetteur d'orage, Archavon le Gardien des pierres, et Toravon la Sentinelle de glace dans le Caveau d’Archavon (n'importe quelle taille de raid)."
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = "Butin de Malygos dans l'Oeil de l'éternité (n'importe quelle taille de raid)."
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = "Butin d'Onyxia dans le Repaire d'Onyxia (n'importe quelle taille de raid)."
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = "Butin de la Folie d'Aile de mort dans l'Âme des dragons (n'importe quelle taille ou difficulté de raid)."
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = "Butin de la Folie d'Aile de mort dans l'Âme des dragons (héroïque, n'importe quelle taille de raid)."
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = "Butin d'Ultraxion dans l'Âme des dragons (n'importe quelle taille ou difficulté de raid)."
L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = "Butin de Yogg-Saron dans Ulduar (25 joueurs) sans l'assistance des gardiens."
L["Dropped from dinosaurs on Isle of Giants"] = "Butin des dinosaures de l'Île des Géants."
L["Dropped from monsters in Fang'rila"] = "Butin des monstres de Croc’rila."
L["Drops from a boss requiring a group"] = "Obtenu sur un boss nécessitant un groupe."
L["Drops from any mob in a zone"] = "Obtenu sur n'importe quelle monstre d'une zone."
L["Drops from NPC(s)"] = "Obtenu auprès d'un PNJ."
--Translation missing 
L["Drudge Remains"] = "Drudge Remains"
L["Druid"] = "Druide"
L["Dungeon ID"] = "ID du donjon"
L["Dusty Clutch of Eggs"] = "Chapelet d’œufs poussiéreux"
L["Dwarf"] = "Nain"
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = "Obtenu en échangeant 9999 Os de dinosaure géant avec Ku’ma sur l'Île des Géants. Les Os de dinosaure géant se trouvent sur tout les dinosaures et les Dinomanciens zandalaris de l'Île des Géants."
L["Elementium Geode"] = "Géode en élémentium"
L["Elementium Vein"] = "Filon d'élémentium"
L["Emperor Salmon School"] = "Banc de saumons empereurs"
L["Enable announcements"] = "Activer les annonces"
L["Enable Coins"] = "Suivre les jets de dé bonus"
L["Enable profiling"] = "Activer le profilage"
L["Enable tooltip additions"] = "Ajouts dans les infobulles en jeu"
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = "Active les annonces lorsque vous effectuez un nouvel essai pour quoi que ce soit suivi par Rarity. Vous pouvez aussi activer les annonces objet par objet, mais ceci est la commande principale."
L["Enables announcements whenever you complete a new attempt toward this item."] = "Active les annonces lorsque vous complétez une nouvelle tentative pour cet objet."
L["Enter 1 or leave this blank to mark the item as soloable."] = "Entrez 1 ou laissez vide pour marquer l'objet comme étant obtenable en solo."
L["Equal odds"] = "Chance répartie"
L["Error compressing item pack"] = "Erreur lors de la compression du pack d'objet(s)."
L["Error encoding item pack"] = "Erreur lors du codage du pack d'objet(s)."
L["Error serializing item pack"] = "Erreur lors de la mise en série du pack d'objet(s)."
L["Essence of the Breeze"] = "Essence de la brise"
L["Eternal Kiln"] = "Four éternel"
L["Eternal Warrior's Sigil"] = "Cachet du guerrier éternel"
--Translation missing 
L["Everliving Spore"] = "Everliving Spore"
L["Every item ID must be a number greater than 0."] = "Tous les identifiants des objets doivent être supérieurs à 0."
L["Every NPC ID must be a number greater than 0."] = "Tous les identifiants des PNJs doivent être supérieurs à 0."
L["Every Quest ID must be a number greater than 0."] = "Tous les identifiants de quête doivent être un nombre plus grand que 0."
L["Experiment 12-B"] = "Expérience 12-B"
L["Export"] = "Exporter"
L["Export Rarity Item Pack"] = "Exporter un pack d'objets Rarity"
L["Export this item"] = "Exporter cet objet"
L["Eye of Inquisition"] = "Oeil d'inquisition"
L["Faintly Glowing Flagon of Mead"] = "Pichet d'hydromel légèrement luminescent"
L["Fandral's Seed Pouch"] = "Bourse de graine de Fandral"
L["Fangtooth Herring School"] = "Banc de harengs crocs-pointus"
L["Farwater Conch"] = "Conque de Guette-Loin"
L["Fat Sleeper School"] = "Banc de dormeurs tachetés"
L["Fathom Dweller"] = "Créature des grands fonds"
L["Fathom Eel Swarm"] = "Banc d'anguilles des profondeurs"
L["Feed text"] = "Taille du texte"
L["Fel Iron Deposit"] = "Gisement de gangrefer"
L["Felfly"] = "Gangreluciole"
L["Felslate Deposit"] = "Gisement de gangreschiste"
L["Felslate Seam"] = "Veine de gangreschiste"
L["Felsteel Annihilator"] = "Annihilateur en gangracier"
L["Felsworn Sentry"] = "Factionnaire gangrelige"
L["Feltail School"] = "Banc de gangre-queues"
L["Fever of Stormrays"] = "Multitude de raies-tempête"
L["Fiery Warhorse's Reins"] = "Rênes de cheval de guerre embrasé"
L["Fire Ammonite School"] = "Banc d’ammonites de feu"
L["Firefin Snapper School"] = "Banc de lutjans de nagefeu"
L["Firewing"] = "Aile-de-feu"
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = "Pêché n'importe où en Draenor (sauf dans le fief) avec l'aide de Nat Pagle."
L["Flametalon of Alysrazor"] = "Serres-de-Flammes d’Alysrazor"
L["Floating Debris"] = "Débris flottant"
L["Floating Debris Pool"] = "Déchets flottants"
L["Floating Shipwreck Debris"] = "Débris d’épave flottants"
L["Floating Wreckage"] = "Débris flottants"
L["Floating Wreckage Pool"] = "Déchets flottants"
L["Font"] = "Police"
L["Font Size"] = "Taille de police"
L["Foot Ball"] = "Ballon rond"
L["Fossil"] = "Fossile"
L["Fossilized Raptor"] = "Raptor fossilisé"
L["Found after %d attempts!"] = "Trouvé après %d essais !"
L["Found in: "] = "Se trouve à : "
L["Found on your first attempt!"] = "Trouvé au premier essai !"
L["Fox Kit"] = "Renardeau"
L["Fragment of Anger"] = "Fragment de colère"
L["Fragment of Desire"] = "Fragment de désir"
--Translation missing 
L["Fragment of Frozen Bone"] = "Fragment of Frozen Bone"
L["Fragment of Suffering"] = "Fragment de souffrance"
L["Frenzyheart Brew"] = "Bière frénécœur"
L["Frightened Bush Chicken"] = "Poulet des fourrés effrayé"
L["Fuzzy Green Lounge Cushion"] = "Coussin de salon vert duveteux"
L["Gahz'rooki's Summoning Stone"] = "Pierre d’invocation de Gahz’rooki"
L["Gar'lok"] = "Gar’lok"
L["Garn Nighthowl"] = "Garn Nocthurle"
L["Garn Steelmaw"] = "Garn gueule-d’acier"
L["Garrison Invasion Gold Victory"] = "Invasion de fief : victoire Or"
L["Garrison Invasion Platinum Victory"] = "Invasion de fief : victoire Platine"
L["Gastropod Shell"] = "Carapace de gastéropode"
L["General"] = "Général"
L["General Options"] = "Options générales"
L["Ghost Iron Deposit"] = "Gisement d’ectofer"
L["Giant Coldsnout"] = "Groin-froid géant"
L["Giant Mantis Shrimp Swarm"] = "Banc de crevettes-mantes géantes"
L["Giant Sewer Rat"] = "Rat d'égout géant"
--Translation missing 
L["Giant Worm Egg"] = "Giant Worm Egg"
L["Gibblette the Cowardly"] = "Gibblette le Poltron"
L["Glacial Salmon School"] = "Banc de saumons glaciaires"
L["Glassfin Minnow School"] = "Banc de vairons nageverres"
L["Glimmering Jewel Danio Pool"] = "Banc de danios joyaux scintillants"
L["Glimmering Treasure Chest"] = "Coffre au trésor scintillant"
L["Glittering Arcane Crystal"] = "Cristal arcanique lumineux"
--Translation missing 
L["Glittering Ball of Yarn"] = "Glittering Ball of Yarn"
L["Glowing Jade Lungfish"] = "Dipneuste de jade luminescent"
L["Gluth's Bone"] = "Os de Gluth"
L["Gold Vein"] = "Filon d'or"
L["Golden Carp School"] = "Banc de carpes dorées"
L["Gondar"] = true
L["Gooey Sha-ling"] = "Sha-ton gluant"
L["Goren \"Log\" Roller"] = "Rouleur de « bûches » goren"
L["Great Brewfest Kodo"] = "Grand kodo de la fête des Brasseurs"
L["Greater Sagefish School"] = "Banc de grandes sagerelles"
L["Greatfather Winter's Tree"] = "Sapin de Grand-père Hiver"
L["Green Helper Box"] = "Boîte à assistant vert"
L["Grotesque Statue"] = "Statue grotesque"
L["Group Finder Options"] = "Options de l'outil Recherche de groupe"
L["Group size"] = "Composition du groupe"
L["Group(s) found!"] = "Groupe(s) trouvé(s) !"
L["Grow Up"] = "Vers le haut"
L["Grumpling"] = "Ronchonus"
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = "Butin garanti de Dormus le Collectionneur de dromadaires. Accéder à sa rencontre nécessite de trouver une\"Figurine de dromadaire mystérieuse\" à Uldum. Celles-ci sont difficiles à trouver et, après avoir cliqué dessus, ont une faible chance de vous téléporter auprès de Dormus. Rarity comptera combien de figurines vous avez trouvé si vous passez la souris dessus."
L["Gu'chi Swarmling"] = "Couvelin de Gu’chi"
L["Guk"] = true
L["Gulp Froglet"] = "Jeune grenouille gobeuse"
L["Gundrak Hatchling"] = "Bébé raptor de Gundrak"
L["Half-Empty Food Container"] = "Récipient de nourriture à moitié vide"
L["Hardened Shell"] = "Carapace durcie"
L["Height"] = "Hauteur"
L["Helpful Wikky's Whistle"] = "Sifflet de Wikky le Serviable"
L["Here is a preview of what will (or won't) be imported:"] = "Voici un aperçu de ce qui sera (ou ne sera pas) importé :"
L["Heroic difficulty"] = "Difficulté héroïque"
L["Heroic Raid (10-30 players)"] = "Raid héroïque (10-30 joueurs)"
L["Heroic Scenario instance"] = "Scénario héroïque"
L["Heroic, any raid size"] = "Héroïque, n'importe quelle taille"
L["Hidden"] = "Caché"
L["Hide defeated items"] = "Cacher les entités vaincues"
L["Hide high chance items"] = "Cacher les objets à haute probabilité"
L["Hide items not in your zone"] = "Cacher les objets non présents dans votre zone"
L["Hide items with no attempts"] = "Cacher les objets sans aucun essai"
L["Hide unavailable items"] = "Cacher les objets indisponibles"
L["High Priest of Ordos"] = "Grand prêtre d’Ordos"
L["Highborne"] = "Bien-né"
L["Highland Guppy School"] = "Banc de guppys des Hautes terres"
L["Highland Mixed School"] = "Banc mixte des Hautes-terres"
--Translation missing 
L["Highmountain Elderhorn"] = "Highmountain Elderhorn"
L["Highmountain Salmon School"] = "Banc de saumons de Haut-Roc"
L["Highmountain Tauren"] = "Taurène de Haut-Roc"
L["Holiday"] = "Saisonnier"
L["Holiday reminders"] = "Rappels des événements saisonniers"
L["Hollow Reed"] = "Roseau creux"
L["Horde only"] = "Horde uniquement"
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = "La probabilité qu'un objet apparaisse, exprimé sous format 1 pour X, où X est le nombre que vous entrez."
L["How many attempts you've made so far."] = "Combien d'essais vous avez fait à ce jour."
L["How many items you need to collect."] = "Le nombre d'objets que vous devez collecter."
L["How many items you've collected so far."] = "Le nombre d'objets que vous avez collectés jusqu'à présent."
L["Hozen Beach Ball"] = "Ballon de plage hozen"
L["Huge Obsidian Slab"] = "Enorme bloc d'obsidienne"
L["Hunter"] = "Chasseur"
L["Hyjal Wisp"] = "Feu follet d’Hyjal"
L["Ice Chip"] = "Glaçon"
L["Identify the Item"] = "Détails de l'objet"
L["Imbued Jade Fragment"] = "Fragment de jade imprégné"
L["Imperial Manta Ray School"] = "Banc de raies manta impériales"
L["Imperial Moth"] = "Phalène impérial"
L["Imperial Silkworm"] = "Ver à soie impérial"
L["Imp-Master Valessa"] = "Maîtresse des diablotins Valessa"
L["Import"] = "Importer"
L["Import Rarity Item Pack"] = "Importer un pack d'objets Rarity"
L["Import/Export"] = true
L["imported successfully"] = "importé avec succès"
L["Incendicite Mineral Vein"] = "Filon d'incendicite"
L["Indurium Mineral Vein"] = "Filon d'indurium"
L["Install TomTom to enable waypoint creation."] = "Installez TomTom pour activer la création de points de navigation."
L["Instance Difficulty"] = "Difficulté de l'instance"
L["Instant Arcane Sanctum Security Kit"] = "Kit sécurité instantané du sanctum des arcanes"
L["Invincible's Reins"] = "Rênes d'Invincible"
L["Iron Deposit"] = "Gisement de fer"
--Translation missing 
L["Ironbound Collar"] = "Ironbound Collar"
L["Ironhoof Destroyer"] = "Destructeur sabot-de-fer"
L["Item ID"] = "ID de l'objet"
L["Item ID to Collect"] = "ID de l'objet à collecter"
L["Items to Use"] = "Objets à utiliser"
L["Jade Lungfish School"] = "Banc de dipneustes de jade"
L["Jadefire Spirit"] = "Esprit jadefeu"
L["Jademist Dancer"] = "Danseur brumejade"
L["Jawless Skulker School"] = "Banc de furtifs agnathes"
L["Jeremy Feasel"] = true
L["Jewel Danio School"] = "Banc de danios joyaux"
L["Jewel of Maddening Whispers"] = "Joyau de murmures démentiels"
L["Ji-Kun Hatchling"] = "Bébé de Ji Kun"
L["Jingling Bell"] = "Clochette tintinnabulante"
L["Kael'thas Sunstrider"] = "Kael’thas Haut-Soleil"
--Translation missing 
L["Kaldorei Light Globe"] = "Kaldorei Light Globe"
L["Kal'tik the Blight"] = "Kal’tik le Chancre"
L["Kang's Bindstone"] = "Pierre de lien de Kang"
L["Khorium Vein"] = "Filon de khorium"
L["Kill Statistic IDs"] = "Identifiants de statistiques de mises à mort."
L["Knockoff Blingtron"] = "Bling-o-tron de contrefaçon"
L["Kor'kron Juggernaut"] = "Mastodonte kor’kron"
L["Kovok"] = true
L["Krasarang Paddlefish School"] = "Banc de poissons-spatules de Krasarang"
L["Kyparite Deposit"] = "Gisement de kyparite"
L["Land Shark"] = "Requin terrestre"
L["Large Obsidian Chunk"] = "Grand morceau d'obsidienne"
L["Large Pool of Brew Frenzied Emperor Salmon"] = "Grande réserve de saumons empereurs affolés par la bière"
L["Large Pool of Crowded Redbelly Mandarin"] = "Grande réserve de mandarins ventre-rouge agglutinés"
L["Large Pool of Glimmering Jewel Danio Pool"] = "Grande réserve de danios joyaux scintillants"
L["Large Pool of Glowing Jade Lungfish"] = "Grande réserve de dipneustes de jade luminescents"
L["Large Pool of Sha-Touched Spinefish"] = "Grande réserve de poissons-hérissons touchés par les sha"
L["Large Pool of Tiger Gourami Slush"] = "Grande réserve de boue de gouramis tigres"
L["Large Swarm of Migrated Reef Octopus"] = "Grande colonie de poulpes des récifs migrants"
L["Large Swarm of Panicked Paddlefish"] = "Grande colonie de poissons-spatules paniqués"
L["Large Tangled Mantis Shrimp Cluster"] = "Grand amas de crevettes-mantes enchevêtrées"
L["Last Month"] = "Mois dernier :"
L["Last Week"] = "Semaine dernière :"
L["Left"] = "Gauche"
L["Legion"] = "Légion"
L["Lesser Bloodstone Deposit"] = "Gisement de pierre de sang inférieure"
L["Lesser Firefin Snapper School"] = "Banc clairsemé de lutjans de nagefeu"
L["Lesser Floating Debris"] = "Débris flottants inférieurs"
L["Lesser Oily Blackmouth School"] = "Petit banc de bouches-noires huileux"
L["Lesser Sagefish School"] = "Petit banc de sagerelles"
L["Leviathan Egg"] = "Oeuf de léviathan"
--Translation missing 
L["Ley Spider Eggs"] = "Ley Spider Eggs"
L["Leystone Deposit"] = "Gisement de tellurium"
L["Leystone Seam"] = "Veine de tellurium"
--Translation missing 
L["Leywoven Flying Carpet"] = "Leywoven Flying Carpet"
L["Life-Binder's Handmaiden"] = "Suivante de la Lieuse-de-vie"
L["Likelihood"] = "Probabilité"
L["Lil' Bling"] = "P’tit Bling-Bling"
L["Living Infernal Core"] = "Noyau de brasier infernal"
L["Living Sandling"] = "Sablon vivant"
L["Loaded (running in debug mode)"] = "Chargé (lancé en mode de débuggage)"
L["Loaded Gnomish Dice"] = "Dés gnomes pipés"
L["Loading"] = "En cours de chargement"
L["Locked"] = "Verrouillé"
L["Looking For Raid (10-30 players)"] = "Recherche de raid (10-30 joueurs)"
L["Luckiness"] = "Chance"
L["Lucky"] = "Chanceux"
L["lucky"] = "chanceux"
L["Lucky if you obtain in %d or less"] = "Chanceux si obtenu en %d ou moins."
L["Lump of Coal"] = "Morceau de charbon"
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = "Les malabars peuvent être pêchés n'importe où en Draenor (sauf dans le fief) après avoir obtenu une Cabane de pêche de niveau 3 et recruté Nat Pagle en sujet de fief."
L["Mage"] = true
--Translation missing 
L["Magnataur Hunting Horn"] = "Magnataur Hunting Horn"
L["Major Nanners"] = "Major Sinok"
L["Mantid"] = "Mantide"
L["Mark of Flame"] = "Marque de la flamme"
L["Method of obtaining"] = "Méthode d'obtention"
--Translation missing 
L["Midnight's Eternal Reins"] = "Midnight's Eternal Reins"
L["Mimiron's Head"] = "Tête de Mimiron"
L["Minimal"] = "Minimum"
L["Minion of Grumpus"] = "Serviteur de Grognus"
L["MiniZep Controller"] = "Contrôles de minizep"
L["Mirecroak"] = "Fangecoasse"
L["Mists of Pandaria"] = true
L["Mithril Deposit"] = "Gisement de mithril"
L["Mogu"] = true
L["Mojo"] = true
L["Monk"] = "Moine"
L["Moon Moon"] = "Loulou"
L["Moonfang"] = "Croc-de-Lune"
L["Moonfang Shroud"] = "Voile de Croc-de-Lune"
L["Moonfang's Paw"] = "Patte de Croc-de-Lune"
L["Moonglow Cuttlefish School"] = "Banc de seiches lueur-de-lune"
L["Mossgill Perch School"] = "Banc de perches moussebranchies"
L["Mount"] = "Monture"
L["Mountain Panda"] = "Panda des montagnes"
L["Mountain Trout School"] = "Banc de truites de montagne"
L["Mounts"] = "Montures"
L["Mr. Grubbs"] = "M. Boustifs"
L["Mr. Pinchy"] = "Monsieur Pince-mi"
L["Mr. Smite's Brass Compass"] = "Boussole de cuivre de M. Châtiment"
L["Muckbreaths's Bucket"] = "Seau de Bourbe-haleine"
L["Muddy Churning Water"] = "Eaux troubles et agitées"
L["Mudfish School"] = "Banc d'éperlans"
L["Musselback Sculpin School"] = "Banc de rascasses dos-de-moule"
--Translation missing 
L["Muyani"] = "Muyani"
L["Mysterious Camel Figurine"] = "Figurine de dromadaire mystérieuse"
L["Mythic 5-player instance"] = "Donjon mythique à 5 joueurs"
L["Mythic difficulty"] = "Difficulté mythique"
L["Mythic Raid (20 player)"] = "Raid mythique (20 joueurs)"
L["Nerubian"] = "Nérubien"
--Translation missing 
L["Nerubian Relic"] = "Nerubian Relic"
L["Nessos the Oracle"] = "Nessos l'Oracle"
L["Nethercite Deposit"] = "Gisement de néanticite"
L["Netherfist"] = "Poing-du-Néant"
L["Netherspace Portal-Stone"] = "Pierre du portal du Néantespace"
L["Nettlefish School"] = "Banc de méduses"
L["New item"] = "Nouvel objet"
L["Night Elf"] = "Elfe de la nuit"
L["Nightmare Bell"] = "Carillon cauchemardesque"
--Translation missing 
L["Nightmare Whelpling"] = "Nightmare Whelpling"
L["Nightshade Sproutling"] = "Jeune pousse de belladone"
L[ [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=] ] = "Aucun objet à afficher ! Soit vous avez obtenu tous les objets, soit vous avez une ou des options activées qui cachent des éléments de l'infobulle."
L["None"] = "Aucun"
L["None (not in an instance)"] = "Aucune (pas dans une instance)"
L["Normal"] = true
L["Normal Raid (10-30 players)"] = "Raid normal (10-30 joueurs)"
L["not imported"] = "pas importé"
L["NPCs"] = "ID de PNJs"
L["Obsidium Deposit"] = "Gisement d'obsidium"
L["Obtained Achievement ID"] = "ID de haut fait accompli"
L["Obtained After %d Attempts"] = "Obtenu après %d essais."
L["Obtained as a rare project for the Fossil branch of archaeology"] = "Obtenu via un projet rare d'archéologie Fossile."
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = "Obtenu via un projet très rare d'archéologie Tol'vir."
L["Obtained as an archaeology project"] = "Obtenu via un projet d'archéologie."
L["Obtained by collecting a number of items"] = "Obtenu en collectant un certain nombre d'objets."
L["Obtained by fishing"] = "Obtenu en pêchant"
L["Obtained by fishing in any water in Ironforge"] = "Obtenu en pêchant n'importe où dans Forgefer."
L["Obtained by fishing in any water in Orgrimmar"] = "Obtenu en pêchant en n'importe où dans Orgrimmar."
L["Obtained by fishing in pools located in Terrokar Forest"] = "Obtenu en pêchant dans les bancs de la Forêt de Terrokar."
L["Obtained by mining"] = "Obtenu en minant."
L["Obtained by mining Elementium Vein"] = "Obtenu en minant un filon d'élémentium."
L["Obtained by opening Crane Nests on the Timeless Isle"] = "Obtenu en ouvrant les Nids de grues sur l'Île du Temps figé."
L["Obtained by opening Snow Mound in Frostfire Ridge"] = "Obtenu en fouillant un Monticule de neige dans la Crête de Givrefeu."
L["Obtained by opening Timeless Chests on the Timeless Isle"] = "Obtenu en ouvrant les Coffres intemporels sur l'Île du Temps figé."
L["Obtained by using an item or opening a container"] = "Obtenu en utilisant un objet ou contenu à l'intérieur d'un objet."
L["Obtained On Your First Attempt"] = "Obtenu au premier essai."
L["Obtained Quest ID"] = "ID de quête terminée"
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = "Obtenu très rarement en pêchant dans les bancs situés dans une zone d'une extension (pas dans les zones classiques)."
L["Odd Polished Stone"] = "Etrange pierre polie"
L["Ogre"] = true
L["Oil Spill"] = "Nappe de pétrole"
L["Oily Abyssal Gulper School"] = "Banc de grangousiers des abysses huileux"
L["Oily Blackmouth School"] = "Banc de bouches-noires huileux"
L["Oily Sea Scorpion School"] = "Banc de scorpions de mer huileux"
L["Old Crafty"] = "Vieux malin"
L["Old Ironjaw"] = "Vieux gueule-de-fer"
L["Old Man Barlo"] = "Vieux Barlo"
L["Ominous Flame"] = "Flamme inquiétante"
--Translation missing 
L["Ominous Pile of Snow"] = "Ominous Pile of Snow"
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = "Un des identifiants de la carte que vous avez saisi (%s) est incorrect. Veuillez saisir des nombres plus grands que zéro."
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = "L'une des zones ou sous-zones que vous avez saisies (%s) ne peut être trouvée. Vérifiez si l'orthographe est correcte, et est en Anglais US ou dans la langue de votre client."
L["Only announce when found"] = "Annoncer uniquement quand trouvé"
L["Only Raid Finder difficulty"] = "Uniquement en recherche de raid."
L["Ooze Covered Gold Vein"] = "Filon d'or couvert de limon"
L["Ooze Covered Mithril Deposit"] = "Gisement de mithril couvert de vase"
L["Ooze Covered Rich Thorium Vein"] = "Riche filon de thorium couvert de limon"
L["Ooze Covered Silver Vein"] = "Filon d'argent couvert de limon"
L["Ooze Covered Thorium Vein"] = "Filon de thorium couvert de limon"
L["Ooze Covered Truesilver Deposit"] = "Gisement de vrai-argent couvert de vase"
L["Options"] = true
L["Orb of the Sin'dorei"] = "Orbe des Sin'dorei"
L["Orc"] = true
--Translation missing 
L["Orphaned Felbat"] = "Orphaned Felbat"
L["Other"] = "Autre"
L["Other Requirements"] = "Autres prérequis"
--Translation missing 
L["Overcomplicated Controller"] = "Overcomplicated Controller"
L["Paladin"] = true
L["Pandaren"] = "Pandarène"
L["Pandaren Firework Launcher"] = "Lanceur de feux d’artifice pandaren"
L["Panflute of Pandaria"] = "Flûte de Pan de Pandarie"
L["Parrot Cage (Green Wing Macaw)"] = "Cage de perroquet (ara aile verte)"
L["Parrot Cage (Hyacinth Macaw)"] = "Cage de perroquet (ara jacinthe)"
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = "Copiez un lien de pack d'objets Rarity ici en utilisant Ctrl+V, puis cliquez sur le bouton Import."
L["Patch of Elemental Water"] = "Remous d'eau élémentaire"
L["Periwinkle Calf"] = "Jeune potamodonte pervenche"
L["Phoenix Hatchling"] = "Jeune phénix"
L["Pineapple Lounge Cushion"] = "Coussin de salon ananas"
L["Play a sound when groups are found"] = "Jouer un son lorsque des groupes sont trouvés"
L["Players have a personal loot chance to obtain this item."] = "Les joueurs ont une chance d'obtenir cet objet en butin personnel."
L["Please enter a comma-separated list of item IDs."] = "Veuillez entrer une liste d'identifiants d'objets séparés par des virgules."
L["Please enter a comma-separated list of NPC IDs."] = "Veuillez entrer une liste d'identifiants de PNJs séparés par des virgules."
L["Please enter a comma-separated list of Quest IDs."] = "Veuillez entrer une liste d'identifiants de quêtes séparés par des virgules."
L["Please enter a comma-separated list of Statistic IDs."] = "Veuillez entrer une liste d'identifiants de statistiques séparés de virgules."
L["Please enter a comma-separated list of zones."] = "Veuillez entrer une liste de zones séparées par des virgules."
L["Pool of Fire"] = "Flaque de feu"
L["Porcupette"] = "Porc-épique"
L["Priest"] = "Prêtre"
L["Primal Egg"] = "Oeuf primordial"
L["Primary tooltip hide delay"] = "Délai de disparition de l'infobulle principale"
L["Primary tooltip scale"] = "Échelle de l'infobulle principale"
L["Profile modified, rebooting"] = "Profil modifié, redémarrage"
L["Profiling OFF"] = "Profilage DÉSACTIVÉ"
L["Profiling ON"] = "Profilage ACTIVÉ"
L["Progress"] = "Progression"
L["Progress Bar"] = "Barre de progression"
L["Puddle Terror"] = "Terreur des flaques"
L["Pugg"] = true
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = "Acheté auprès de Z’tenga le Marcheur à Croc'rila dans la Jungle de Tanaan. Les Griffes de Croc-Noir se trouvent sur tous les monstres de Croc'rila."
L["Pure Saronite Deposit"] = "Gisement de saronite pure"
L["Pure Water"] = "Eau pure"
L["Put \"Rarity:\" on a separate line"] = "Ajouter \"Rarity :\" sur une ligne séparée"
--Translation missing 
L["Putricide's Alchemy Supplies"] = "Putricide's Alchemy Supplies"
L["Pygmy Direhorn"] = "Navrecorne pygmée"
L["Pyrite Deposit"] = "Gisement de pyrite"
L["Quest ID"] = "ID de quête"
L["Quivering Blob"] = "Goutte tremblante"
L["Raid Finder instance (legacy content; fixed at 25 players)"] = "Recherche de raid (contenu héritage, fixé à 25 joueurs)"
L["Raid Finder or Flexible difficulty"] = "Difficulté recherche de raid ou dynamique"
L["Rarity has %d |4coordinate:coordinates; for this item."] = "Rarity a %d |4coordonnée:coordonnées; pour cet objet."
L["Rarity is loading..."] = "Chargement de Rarity..."
L["Rarity Item Pack String"] = "Lien de pack d'objets Rarity"
L["Rarity Tooltip Options"] = "Options des infobulles de Rarity"
L["Rarity: "] = "Rarity : "
L["Razzashi Hatchling"] = "Bébé raptor razzashi"
L["Red Goren Egg"] = "Oeuf de goren rouge"
L["Red Helper Box"] = "Boîte à assistante rouge"
L["Red Qiraji Resonating Crystal"] = "Cristal de résonance qiraji rouge"
L["Redbelly Mandarin School"] = "Banc de mandarins ventre-rouge"
--Translation missing 
L["Red-Hot Coal"] = "Red-Hot Coal"
L["Reef Octopus Swarm"] = "Banc de poulpes des récifs"
L["Reins of the Amber Primordial Direhorn"] = "Rênes de navrecorne primordial d’ambre"
L["Reins of the Astral Cloud Serpent"] = "Rênes de serpent-nuage astral"
L["Reins of the Azure Drake"] = "Rênes de drake azur"
L["Reins of the Black Primal Raptor"] = "Rênes de raptor primordial noir"
L["Reins of the Blazing Drake"] = "Rênes de drake flamboyant"
L["Reins of the Blue Drake"] = "Rênes de drake bleu"
L["Reins of the Blue Proto-Drake"] = "Rênes de proto-drake bleu"
L["Reins of the Bone-White Primal Raptor"] = "Rênes de raptor primordial ivoirin"
L["Reins of the Cobalt Primordial Direhorn"] = "Rênes de navrecorne primordial cobalt"
L["Reins of the Crimson Water Strider"] = "Rênes de trotteur aquatique cramoisi"
L["Reins of the Drake of the North Wind"] = "Rênes de drake du vent du Nord"
L["Reins of the Drake of the South Wind"] = "Rênes de drake du vent du Sud"
L["Reins of the Grand Black War Mammoth"] = "Rênes de grand mammouth de guerre noir"
L["Reins of the Green Primal Raptor"] = "Rênes de raptor primordial vert"
L["Reins of the Green Proto-Drake"] = "Rênes de proto-drake vert"
L["Reins of the Grey Riding Camel"] = "Rênes de dromadaire gris"
L["Reins of the Heavenly Onyx Cloud Serpent"] = "Rênes de serpent-nuage céleste onyx"
L["Reins of the Infinite Timereaver"] = "Rênes de saccageur temporel infini"
L["Reins of the Jade Primordial Direhorn"] = "Rênes de navrecorne primordial de jade"
L["Reins of the Onyxian Drake"] = "Rênes de drake onyxien"
L["Reins of the Raven Lord"] = "Rênes du seigneur corbeau"
L["Reins of the Slate Primordial Direhorn"] = "Rênes de navrecorne primordial ardoise"
L["Reins of the Thundering Cobalt Cloud Serpent"] = "Rênes de serpent-nuage de cobalt fulminant"
L["Reins of the Thundering Onyx Cloud Serpent"] = "Rênes de serpent-nuage d’onyx fulminant"
L["Reins of the Vitreous Stone Drake"] = "Rênes de drake de pierre volcanique"
L["Reins of the White Polar Bear"] = "Rênes d'ours polaire blanc"
--Translation missing 
L["Remains of a Blood Beast"] = "Remains of a Blood Beast"
L["Repeatable"] = "Répétable"
L["Required for %s"] = "Requis pour %s"
L["Requires a pool"] = "Nécessite un banc de poissons"
L["Requires Pickpocketing"] = "Nécessite Vol à la tire"
L["Rich Adamantite Deposit"] = "Riche gisement d'adamantite"
L["Rich Blackrock Deposit"] = "Riche gisement de rochenoire"
L["Rich Cobalt Deposit"] = "Riche gisement de cobalt"
L["Rich Elementium Vein"] = "Riche filon d'élémentium"
L["Rich Felslate Deposit"] = "Riche gisement de gangreschiste"
L["Rich Ghost Iron Deposit"] = "Riche gisement d’ectofer"
L["Rich Kyparite Deposit"] = "Riche gisement de kyparite"
L["Rich Leystone Deposit"] = "Riche gisement de tellurium"
L["Rich Obsidium Deposit"] = "Riche gisement d'obsidienne"
L["Rich Pyrite Deposit"] = "Riche gisement de pyrite"
L["Rich Saronite Deposit"] = "Riche gisement de saronite"
L["Rich Thorium Vein"] = "Riche filon de thorium"
L["Rich Trillium Vein"] = "Riche filon de trillium"
L["Rich True Iron Deposit"] = "Riche gisement de vérifer"
L["Riding Turtle"] = "Tortue de monte"
L["Right"] = "Droite"
L["Right-Aligned"] = "Aligné à droite"
L["Rime of the Time-Lost Mariner"] = "Complainte du marin au temps figé"
L["Rogue"] = "Voleur"
L["Rotten Helper Box"] = "Boîte à assistant infect"
L["Ruby Droplet"] = "Gouttelette rubis"
L["Rukdug"] = true
L["Runescale Koi School"] = "Banc de koïs runécailles"
L["Sack of Spectral Spiders"] = "Sac d’araignées spectrales"
L["Safari Lounge Cushion"] = "Coussin de salon safari"
L["Sagefish School"] = "Banc de sagerelles"
L["Sahn Tidehunter"] = "Sahn Chasse Marée"
L["Salyin Battle Banner"] = "Bannière de bataille salyin"
L["Salyin Warscout"] = "Eclaireur de guerre salyin"
L["Saronite Deposit"] = "Gisement de saronite"
L["Sassy Imp"] = "Diablotin insolent"
L["Satyr Charm"] = "Charme de satyre"
L["Savage Cub"] = "Bébé tigre sauvage"
L["Savage Piranha Pool"] = "Bassin de piranhas sauvages"
L["Scale"] = "Echelle"
L["Scenario instance"] = "Scénario"
L["Scepter of Azj'Aqir"] = "Sceptre d'Azj'Aqir"
L["School of Darter"] = "Banc de dards"
L["School of Deviate Fish"] = "Banc de poissons déviants"
L["School of Tastyfish"] = "Banc de courbines"
L["Schooner Wreckage"] = "Débris de goélette"
L["Schooner Wreckage Pool"] = "Débris de goélette"
L["Scorched Stone"] = "Pierre brûlée"
--Translation missing 
L["Scraps"] = "Scraps"
L["Sea Calf"] = "Bébé phoque"
L["Sea Pony"] = "Jeune hippocampe"
L["Sea Scorpion School"] = "Banc de scorpions de mer"
L["Sea Turtle"] = "Tortue de mer"
L["Seaborne Spore"] = "Spore aquatique"
L["Secondary tooltip display"] = "Affichage de l'infobulle secondaire"
L["Servant of Demidos"] = "Serviteur de Demidos"
L["Servant's Bell"] = "Cloche du serviteur"
L["Session"] = true
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = "Saisissez l'identifiant du haut fait qui indique que cet objet a été obtenu. Ceci est utile pour les objets qui ne confèrent pas de monture ou de mascotte, mais qui attribuent un haut fait, tel que Vieux malin ou Vieux gueule-de-fer. Laissez vide pour les montures et les mascottes. Utilisez WowHead pour obtenir les identifiants des haut faits."
L["Shadowhide Pearltusk"] = "Brocheperle sombrepoil"
L["Shaman"] = "Chaman"
L["Shard of Supremus"] = "Eclat de Supremus"
L["Sha-Touched Spinefish"] = "Poisson-hérisson touché par les sha"
L["Shell of Tide-Calling"] = "Ecaille d’appel des flots"
L["Shift-Click to link your progress to chat"] = "Maj+Clic pour créer un lien de votre progression dans la fenêtre de discussion."
L["Shift-Click to open options"] = "Maj+Clic pour afficher les options"
L["Shipwreck Debris"] = "Débris d'épave"
L["Show anchor"] = "Barre de titre"
L["Show attempts in tooltips"] = "Essais dans les infobulles en jeu"
L["Show auto refresh checkbox"] = "Afficher la case à cocher d'actualisation automatique"
L["Show category icons"] = "Icônes des catégories"
L["Show Icon"] = "Afficher l'icône"
L["Show Luckiness column"] = "Colonne Chance"
L["Show minimap icon"] = "Icône de la mini-carte"
L["Show Text"] = "Afficher le texte"
L["Show Time column"] = "Colonne Durée"
L["Show Zone column"] = "Colonne Zone"
L["Silver Vein"] = "Filon d'argent"
L["Silver-Plated Turkey Shooter"] = "Dindoflingue plaqué argent"
L["Since last drop"] = "Depuis la dernière obtention"
--Translation missing 
L["Sira's Extra Cloak"] = "Sira's Extra Cloak"
L["Skrillix"] = true
--Translation missing 
L["Skull of a Frozen Whelp"] = "Skull of a Frozen Whelp"
L["Skunky Alemental"] = "Elémenbière puant"
L["Sky-Bo"] = "Ciel Bo"
L["Skyshard"] = "Eclat céleste"
L["Slithershock Elver"] = "Civelle foudrondule"
L["Small Obsidian Chunk"] = "Petit morceau d'obsidienne"
L["Small Thorium Vein"] = "Petit filon de thorium"
L["Smashum Grabb"] = "Commande de Cogn’Baff mortier"
L["Smelly Gravestone"] = "Pierre tombale puante"
L["Smoky Direwolf"] = "Loup redoutable anthracite"
L["Smoldering Egg of Millagazor"] = "Oeuf fumant de Millagazor"
L["Snarly's Bucket"] = "Seau de Patibulle"
L["Snow Mound"] = "Monticule de neige"
L["Snowman Kit"] = "Boîte de bonhomme de neige"
L["Snowy Panda"] = "Panda neigeux"
L["Solar Spirehawk"] = "Faucon des flêches-solaire"
L["Son of Animus"] = "Fils d’Animus"
L["Son of Galleon's Saddle"] = "Selle du fils de Galion"
L["Sorting by category, then name"] = "Tri par catégorie, puis par nom"
L["Sorting by difficulty"] = "Tri par difficulté"
L["Sorting by name"] = "Tri par nom"
L["Sorting by percent complete"] = "Tri par pourcentage d'accomplissement"
L["Sorting by zone"] = "Tri par zone"
L["Sparse Firefin Snapper School"] = "Banc épars de lutjans de nagefeu"
L["Sparse Oily Blackmouth School"] = "Banc clairsemé de bouches-noires huileux"
L["Sparse Schooner Wreckage"] = "Débris clairsemés de goélette"
L["Spawn of Horridon"] = "Rejeton d’Horridon"
L["Special case"] = "Cas spécial"
L["Spectral Bell"] = "Cloche spectrale"
L["Spell ID"] = "ID du sort"
L["Spiky Collar"] = "Collier à pointes"
L["Spineclaw Crab"] = "Crabe pincépine"
L["Spinefish School"] = "Banc de poissons-hérissons"
L["Sporefish School"] = "Banc de poissons-spores"
L["Sprite Darter Egg"] = "Oeuf de fée fléchetteuse"
L["Statistics"] = "Statistiques"
L["Steam Pump Flotsam"] = "Détritus de la pompe à vapeur"
L["Sting Ray Pup"] = "Jeune pastenague"
L["Stonescale Eel Swarm"] = "Banc d'anguilles pierre-écaille"
--Translation missing 
L["Stormforged Rune"] = "Stormforged Rune"
L["Strand Crawler"] = "Clampant des rivages"
L["Strange Pool"] = "Bassin étrange"
L["Sultry Grimoire"] = "Grimoire sensuel"
L["Sun Sproutling"] = "Jeune pousse solaire"
L["Sunblade Rune of Activation"] = "Rune d’activation lamesoleil"
L["Sunfire Kaliri"] = "Kaliri feu-solaire"
L["Sunfur Panda"] = "Panda crin-de-soleil"
L["Swarm of Panicked Paddlefish"] = "Colonie de poissons-spatules paniqués"
L["Swift Brewfest Ram"] = "Bélier rapide de la fête des Brasseurs"
L["Swift White Hawkstrider"] = "Faucon-pérégrin blanc rapide"
L["Swift Zulian Panther"] = "Panthère zulienne rapide"
L["Syd the Squid"] = "Syd le calmar"
L["Tainted Core"] = "Noyau contaminé"
L["Tainted Maulclaw"] = "Tranchepince impur"
L["Take screenshots"] = "Captures d'écran"
L["Tangled Mantis Shrimp Cluster"] = "Amas de crevettes-mantes enchevêtrées"
L["Teeming Firefin Snapper School"] = "Banc grouillant de lutjans de nagefeu"
L["Teeming Floating Wreckage"] = "Débris flottants grouillants"
L["Teeming Oily Blackmouth School"] = "Banc grouillant de bouches-noires huileux"
L["Terrorfist"] = "Poing-de-terreur"
L["Texture"] = true
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = "Le nom du boss, en anglais (enUS), qui apparaît sur le verrouillage d'instance dans le panneau Infos Raid. Le nom sera automatiquement traduit à la langue de votre jeu en utilisant la bibliothèque LibBoss (si la détection échoue, vérifiez que la traduction existe dans cette bibliothèque). IMPORTANT : cette méthode de détection fonctionne uniquement si le boss n'existe que dans un endroit à la fois. Certains boss, comme Ragnaros ou Kael'thas existent dans deux instances à la fois. Ces boss peuvent être utilisés ici, mais les tuer dans n'importe laquelle de leurs instances activera cette méthode de détection."
L["The Burning Crusade"] = true
L["The following %d item(s) have been selected to export:"] = "Les %d objets suivants ont été sélectionnés pour l'exportation :"
L["The Heartbreaker"] = "Le Bourreau des cœurs"
L["The Horseman's Reins"] = "Les rênes du Cavalier"
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = "L'identifiant de l'objet que vous devez collecter. Rarity utilise le nombre de ces objets présents dans vos sacs comme progression. Utilisez WowHead ou un service similaire pour obtenir les identifiants des objets. Ce numéro doit être valide et unique."
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = "L'identifiant de l'objet à suivre. Ceci est l'objet tel qu'il apparaît dans vos sacs ou dans une fenêtre de butin. Utilisez WowHead ou un service similaire pour trouver les identifiants des objets. Ce numéro doit être valide et unique."
L["The name you entered is already being used by another item. Please enter a unique name."] = "Le nom que vous avez entré est déjà utilisé par un autre objet. Veuillez entrer un nom unique."
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = "L'identifiant de la créature qui apparaît lorsque vous invoquez cette mascotte. Ceci est utilisé pour suivre les mascottes de combat liées au compte."
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = "Le nombre de joueurs requis pour obtenir l'objet. Ceci diminue vos chances d'obtenir l'objet."
L["The Pigskin"] = "Ballon ovale"
--Translation missing 
L["The quest starter item for Reins of the Llothien Prowler"] = "The quest starter item for Reins of the Llothien Prowler"
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = "Le module \"Rarity Options\" a été désactivé. Déconnectez-vous et activez-le à partir du menu des addons."
L["The selected Rarity Item Pack string is invalid."] = "Le lien de pack d'objets Rarity est invalide."
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = "L'identifiant du sort de l'objet une fois que vous l'avez apprit. S'applique uniquement aux compagnons et montures et est représenté par le sort tel qu'il apparaît dans votre livre de sort. Utilisez WowHead ou un service similaire pour rechercher les identifiants des sorts. Ce numéro doit être valide et unique."
L["The Warbringer will be riding the mount color he has a chance to drop."] = "Le porte-guerre chevauchera la monture de la couleur de celle qu'il peut donner en butin."
L["There are more holiday items available, but Rarity only reminds you about the first two."] = "Il y a d'autres objets des fêtes disponibles, mais Rarity ne vous rappelle que les deux premiers."
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = "Cette commande contrôle la façon dont les objets apparaissent dans l'infobulle principale de Rarity. Les objets sont classés selon l'extension qui les a introduits (bien que les objets d’événements saisonniers aient une catégorie séparée). Décocher une case n'empêchera pas le suivi des objets de cette catégorie, mais cachera simplement les objets de l'infobulle afin de réduire la liste des objets suivis."
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = "Ce sac est obtenu en récompense du combat de mascottes journalier proposé par Christoph VonFeasel à la Foire de Sombrelune."
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = "Ce sac est obtenu en récompense du combat de mascottes journalier proposé par Jeremy Feasel  à la Foire de Sombrelune."
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = "Ce sac est donné en récompense pour une victoire Or ou Platine dans une invasion de fief."
L["This causes Rarity to put a blank line above its tooltip additions."] = "Ceci forcera Rarity à ajouter une ligne blanche au dessus de ses ajouts aux infobulles en jeu."
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = "Cet objet a 1 chance sur 4 de se trouver sur Golganarr, un monstre rare de l'Île du Temps figé, et 1 chance sur 250 de se trouver sur un Hante-falaise érodé de l'Île du Temps figé."
L["This item is only available to Alliance players."] = "Cet objet n'est disponible que pour l'Alliance."
L["This item is only available to Horde players."] = "Cet objet n'est disponible que pour la Horde."
L["This mount is only obtainable by Alliance players"] = "Cette monture est récupérable uniquement par les joueurs de l'Alliance."
L["This mount is only obtainable by Horde players"] = "Cette monture est récupérable uniquement par les joueurs de la Horde."
L["This tab lets you import and export items into and out of your Custom tab."] = "Cet onglet vous permet d'importer et d'exporter des objets depuis votre onglet Personnalisé."
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = "Ceci était un butin garanti pour les joueurs étant venu à bout de la rencontre lorsqu'elle était d'actualité."
L["Tiger Gourami School"] = "Banc de gouramis tigres"
L["Tiger Gourami Slush"] = "Boue de gouramis tigres"
L["Time"] = "Durée"
L["Time spent farming"] = "Temps consacré à farmer"
L["Timeless Chest"] = "Coffre intemporel"
L["Time-Locked Box"] = "Boîte scellée par le temps"
L["Time-Lost Figurine"] = "Figurine perdue dans le temps"
L["Timewalker 5-player instance"] = "Donjon marcheur du temps à 5 joueurs"
L["Tin Vein"] = "Filon d'étain"
L["Tiny Crimson Whelpling"] = "Minuscule jeune dragonnet cramoisi"
L["Tiny Emerald Whelpling"] = "Minuscule jeune dragonnet d'émeraude"
L["Tiny Fel Engine Key"] = "Minuscule clé de contact gangrenée"
L["Titanium Vein"] = "Veine de titane"
L[ [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=] ] = [=[Pour créer un nouvel objet, entrez un nom unique pour cet objet puis appuyez sur OK. Le nom sera utilisé si le serveur ne retourne pas le lien de l'objet ou si l'objet n'est pas valide.

Vous ne pouvez pas changer ce nom après avoir créé l'objet, choisissez donc soigneusement.]=]
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = "Pour exporter un groupe d'objets, sélectionnez chacun des objets voulus dans votre onglet Personnalisé et cochez ou décochez les cases Exporter cet objet. La case sera désactivée si vous n'avez pas encore rempli assez d'informations pour que Rarity puisse détecter l'objet. Une fois cela fait, revenez ici et cliquez sur le bouton Exporter. Un lien de pack d'objets Rarity sera généré et vous pourrez le copier en utilisant Ctrl+C."
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = "Pour importer un groupe d'objets, copiez un lien de pack d'objets Rarity dans la case ci-dessous et cliquez sur le bouton Importer. Rarity vous dira quels objets ont été importés (ou ceux dont l'importation a échouée) dans votre fenêtre de chat. Vous pouvez trouver beaucoup de packs d'objets Rarity sur le site Curse, ou ailleurs sur le web."
L["Today"] = "Aujourd'hui :"
L["Toggles"] = "Bascule"
L["Tol'vir"] = true
L["Tooltip can't be shown in combat"] = "L'infobulle ne peut pas être affichée en combat."
L["Toothy's Bucket"] = "Seau de Chicot"
--Translation missing 
L["Torn Invitation"] = "Torn Invitation"
L["Total"] = true
L["Total found"] = "Total découvert"
L["Toxic Wasteling"] = "Gaspi toxique"
L["Toy or Item"] = "Jouet ou objet"
L["Toys & Items"] = "Jouets & Objets"
L["Track this"] = "Suivre ceci"
L["Trillium Vein"] = "Filon de trillium"
L["Troll"] = true
L["True Iron Deposit"] = "Gisement de vérifer"
L["Truesilver Deposit"] = "Gisement de vrai-argent"
L["Tundra Icehoof"] = "Sabot-glacé de la toundra"
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = "Cochez ceci si l'obtention de l'objet requiert un groupe, mais que chaque joueur a une chance égale de l'obtenir. Ceci ne s'applique actuellement qu'à certaines montures d'évènements saisonniers. Lorsque vous cochez ceci, Rarity cessera de réduire vos chances d'obtenir l'objet en fonction de la taille du groupe."
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = "Affiche l'icone de la mini-carte de Rarity. Utilise cette option si vous n'avez pas d'addon d'affichage LDB."
L["Type of item"] = "Type d'objet"
L["Unable to retrieve item information from the server"] = "Impossible de récupérer les informations sur l'objet depuis le serveur."
L["Unavailable"] = "Non disponible"
L["Undefeated"] = "Invaincu"
L["Unknown"] = "Inconnu"
L["Unlucky"] = "Malchanceux"
L["unlucky"] = "malchanceux"
L["Unscathed Egg"] = "Oeuf indemne"
--Translation missing 
L["Unstable Powder Box"] = "Unstable Powder Box"
L["Unusual Compass"] = "Boussole insolite"
L["Use your bonus roll for a chance at this item"] = "Utilisez votre jet de dé bonus pour avoir une chance d'obtenir cet objet."
L["Usually requires a group of around %d players"] = "Nécessite habituellement un groupe d'environ %d joueurs."
--Translation missing 
L["Valarjar Stormwing"] = "Valarjar Stormwing"
L["Vengeance"] = true
L["Verbose"] = true
L["Vibrating Arcane Crystal"] = "Cristal arcanique vibrant"
L["Vile Blood of Draenor"] = "Sang infâme de Draenor"
L["Viscidus Globule"] = "Globule de Viscidus"
L["Void Collar"] = "Collier du Vide"
L["Vrykul"] = true
L["Warlock"] = "Démoniste"
L["Warlords of Draenor"] = true
L["Warm Arcane Crystal"] = "Cristal arcanique chaud"
L["Warning Sign"] = "Panneau d’avertissement"
L["Warrior"] = "Guerrier"
L["Warsong Direfang"] = "Morne-croc chanteguerre"
L["Waterlogged Wreckage"] = "Débris trempés"
L["Waterlogged Wreckage Pool"] = "Débris trempés"
L["Weebomination"] = "Minignominie"
L["Welcome to Rarity r%d. Your settings have been reset."] = "Bienvenue sur Rarity r%d. Votre configuration a été réinitialisée."
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = "Lorsqu'un jet de dé bonus est utilisé dans les 90 secondes suivant un essai sur cet objet, un autre essai sera compté. A n'utiliser que pour les objets qui peuvent légitimement être obtenus via les jet de dé bonus."
L["When enabled, Rarity tooltips will include how many attempts you've made."] = "Indique dans les infobulles de Rarity combien d'essais vous avez effectués."
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = "Ajoute une case à cocher d'actualisation automatique sur la fenêtre de recherche de la Recherche de groupe. Vous pouvez cocher cette case pour activer l'actualisation automatique de vos recherches toutes les 5 secondes."
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = "Ajoute les objets accessibles aux infobulles en jeu dès que cela est possible."
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = "Joue un son quand l'actualisation automatique de recherche trouve un ou plusieurs groupes dans la Recherche de groupe. Ce son ne sera pas joué plus d'une fois par minute."
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = "Ajoute des messages de débogage de profilage à la fenêtre de chat lorsque certaines choses se produisent. Ceci est utilisé pour déterminer quelles parties du code sont lentes."
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = "A activer si l'objet ne peut être obtenu que par Vol à la tire. L'objet sera alors marqué comme Indisponible pour les non-voleurs."
L["When on, items marked as Defeated will be hidden from the tooltip."] = "Les entités marquées comme Vaincu seront cachées de l'infobulle."
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = "Cache les objets marqués comme Indisponible de l'infobulle. De cette façon, les objets nécessitant un événement saisonnier particulier seront automatiquement cachés lorsque l’événement n'est pas en cours."
L["When on, items that have no attempts yet will be hidden from the tooltip."] = "Cache les objets qui n'ont pas encore d'essai de l'infobulle."
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = "Quand activé, seuls les objets qui peuvent être obtenus dans votre zone actuelle seront affichés dans l'infobulle. Quand ceci est activé et que vous vous trouvez dans une instance, la difficulté de l'instance est également vérifiée afin de s'assurer qu'elle correspond à ce que l'objet supporte."
L[ [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=] ] = "Si activé, Rarity vous rappellera d'aller à la recherche des objets d’événements saisonniers qu'il vous manque si l’événement est actif et que l'objet est perçu comme Invaincu. (Cela ne marche que pour les objets provenant des donjons ou des quêtes journalières de l’événement). Le rappel se fait à chaque connexion ou rechargement de l'interface, et cesse pour la journée au cours de laquelle vous terminez le donjon ou la quête de l’événement."
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = "Afficher à côté de chaque objet dans l'infobulle une icône indiquant à quelle extension il appartient."
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = "Prend une capture d'écran quand l'alerte de haut fait apparaît pour indiquer que vous avez obtenu un objet."
L["When on, the Luckiness column will be shown in the main tooltip."] = "Affiche la colonne Chance dans l'infobulle principale."
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = "Ajoute le texte \"Rarity :\" sur sa propre ligne dans les infobulles en jeu."
L["When on, the Time column will be shown in the main tooltip."] = "Affiche la colonne Durée dans l'infobulle principale."
L["When on, the Zone column will be shown in the main tooltip."] = "Affiche la colonne Zone dans l'infobulle principale."
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = "Cache tout objet dont le taux d'obtention est d'1 sur 49 ou meilleur. L'objet sera caché de l'infobulle afin de la garder propre mais sera toujours suivi de façon normale."
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = "Le temps nécessaire avant que l'infobulle Rarity ne disparaissent après avoir passé la souris dessus."
L["Whistle of Chromatic Bone"] = "Sifflet en os chromatique"
L["White Trillium Deposit"] = "Gisement de trillium blanc"
L["Width"] = "Largeur"
--Translation missing 
L["Wild Dreamrunner"] = "Wild Dreamrunner"
L["Wild Goretusk"] = "Broche-tripes sauvage"
L["will be imported"] = "sera importé"
L["Will only drop for druids."] = "Ne tombera que pour les druides."
--Translation missing 
L["Wisp in a Bottle"] = "Wisp in a Bottle"
L["World Tooltip Options"] = "Options des infobulles en jeu"
L["Worn Troll Dice"] = "Dés trolls usés"
L["Wrath of the Lich King"] = true
--Translation missing 
L["Wriggling Darkness"] = "Wriggling Darkness"
L["Yesterday"] = "Hier :"
L["You already defeated %d of them."] = "Vous avez déjà vaincu %d d'entre eux."
L["You already defeated all of them."] = "Vous les avez déjà tous vaincus."
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = "Vous pouvez désactiver les rappels d’événements saisonniers entièrement ou bien objet par objet en vous rendant sur le panneau des options de Rarity."
L["You entered a achievement ID that is already being used by another item."] = "Vous avez entré un identifiant de haut fait qui est déjà utilisé par un autre objet."
L["You entered a creature ID that is already being used by another item."] = "Vous avez entré un identifiant de créature qui est déjà utilisé par un autre objet."
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = "Vous avez entré un nom réservé. Veuillez entrer un nom d'objet correct tel qu'affiché en jeu."
L["You entered a spell ID that is already being used by another item."] = "Vous avez entré un identifiant de sort qui est déjà utilisé par un autre objet."
L["You entered an item ID that is already being used by another item."] = "Vous avez entré un identifiant d'objet qui est déjà utilisé par un autre objet."
L["You entered an item ID that is already set as the collected item for something else."] = "Vous avez entré un identifiant d'objet qui est déjà défini comme l'objet à collecter pour quelque chose d'autre."
L["You must enter a creature ID."] = "Vous devez entrer un identifiant de créature."
L["You must enter a number larger than 0."] = "Vous devez entrer un nombre supérieur à 0."
L["You must enter a number larger than 1."] = "Vous devez entrer un nombre supérieur à 1."
L["You must enter a number larger than or equal to 0."] = "Vous devez entrer un nombre supérieur ou égal à 0."
L["You must enter a spell ID."] = "Vous devez entrer un identifiant de sort."
L["You must enter a valid number."] = "Vous devez entrer un nombre valide."
L["You must enter an amount."] = "Vous devez entrer une quantité."
L["You must enter an item ID."] = "Vous devez entrer un identifiant d'objet."
L["You must enter at least one item ID."] = "Vous devez entrer au moins un identifiant d'objet."
L["You must enter at least one NPC ID."] = "Vous devez entrer au moins un identifiant de PNJ."
L["You must enter at least one Statistic ID."] = "Vous devez entrer au moins un identifiant de statistique."
L["You must enter at least one zone."] = "Vous devez entrer au moins une zone."
L["Young Talbuk"] = "Jeune talbuk"
--Translation missing 
L["Young Venomfang"] = "Young Venomfang"
L["Zandalari Anklerender"] = "Mordille-chevilles zandalari"
L["Zandalari Footslasher"] = "Ecrase-pieds zandalari"
L["Zandalari Kneebiter"] = "Mordilleur zandalari"
L["Zandalari Toenibbler"] = "Ronge-orteils zandalari"
L["Zangar Spore"] = "Spore de Zangar"
L["Zhevra Lounge Cushion"] = "Coussin de salon zhévra"
L["Zomstrok"] = true
L["Zone"] = true
L["Zones"] = true

end

L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "koKR")
if L then
L[" (Group)"] = "(파티)"
L["#%d: %d attempt (%.2f%%)"] = "#%d: %d번 시도 (%.2f%%)"
L["#%d: %d attempts (%.2f%%)"] = "#%d: %d번 시도 (%.2f%%)"
--Translation missing 
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = "%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"
L["%d |4zone:zones;"] = "%d 지역"
L["%d attempt"] = "%d번 시도"
L["%d attempt - %.2f%%"] = "%d번 시도 - %.2f%%"
L["%d attempts"] = "%d번 시도"
L["%d attempts - %.2f%%"] = "%d번 시도 - %.2f%%"
L["%d collected - %.2f%%"] = "%d개 수집됨 - %.2f%%"
L["%s: %d attempt"] = "%s: %d 시도"
L["%s: %d attempt - %.2f%%"] = "%s: %d 시도 - %.2f%%"
L["%s: %d attempt (%d total)"] = "%s: %d 시도 (총 %d)"
L["%s: %d attempts"] = "%s: %d 시도"
L["%s: %d attempts - %.2f%%"] = "%s: %d 시도 - %.2f%%"
L["%s: %d attempts (%d total)"] = "%s: %d 시도 (총 %d)"
L["%s: %d collected"] = "%s: %d 수집됨"
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = "%s: 0/%d 시도까지 (%.2f%% - %s)"
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = "%s: 0/%d 시도까지 (%.2f%% - %s)"
--Translation missing 
L["%s: collection completed!"] = "%s: collection completed!"
--Translation missing 
L["%s: Found after %d attempts!"] = "%s: Found after %d attempts!"
--Translation missing 
L["%s: Found on the first attempt!"] = "%s: Found on the first attempt!"
L["(%d/%d attempts)"] = "(%d/%d 번 시도)"
L["(%d/%d collected)"] = "(%d/%d 수집됨)"
--Translation missing 
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = "(Items listed in red could not be found on the server and may not exist. Consider removing them.)"
L["(running in debug mode)"] = "(디버그 모드에서 실행중)"
--Translation missing 
L["(Warning: item could not be retrieved from server)"] = "(Warning: item could not be retrieved from server)"
L["1 in %d chance"] = "%d 대 1 확률"
L["10-player Heroic Raid instance (legacy content; not flexible)"] = "10인 영웅 공격대 던전 (예전 콘텐츠, 탄력적 아님)"
L["10-player Raid instance (legacy content; not flexible)"] = "10인 공격대 던전 (예전 콘텐츠, 탄력적 아님)"
L["25-player Event scenario"] = "25인 이벤트 시나리오"
L["25-player heroic"] = "25인 영웅"
L["25-player Heroic Raid instance (legacy content; not flexible)"] = "25인 영웅 공격대 던전 (예전 콘텐츠, 탄력적 아님)"
L["25-player Raid instance (legacy content; not flexible)"] = "25인 공격대 던전 (예전 콘텐츠, 탄력적 아님)"
L["40-player Event raid"] = "40인 이벤트 공격대"
L["40-player Raid instance (legacy content; not flexible)"] = "0인 공격대 던전 (예전 콘텐츠, 탄력적 아님)"
L["5-player Event instance"] = "5인 이벤트 던전"
L["5-player Heroic instance"] = "5인 영웅 던전"
L["5-player instance"] = "5인 던전"
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = "\"사용하거나 열 때, 이 아이템을 줄 수 있으며, 아이템 ID를 쉼표로 구분시킨 목록입니다. 아이템 ID를 조회하려면 Wowhead 또는 이와 유사한 서비스를 이용하십시오."
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = "이 아이템을 누가 떨어뜨리는지 NPC ID를 쉼표로 구분시킨 목록입니다. NPC ID를 조회하려면 Wowhead 또는 이와 유사한 서비스를 이용하십시오."
--Translation missing 
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = "A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = "이 아이템을 얻기 위해 처치한 횟수를 추척할 통계 ID를 쉼표로 구분시킨 목록입니다."
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = "이 아이템을 얻기 위해 처치한 횟수를 추척할 통계 ID를 쉼표로 구분시킨 목록입니다. 이러한 통계는 함께 추가됩니다. 통계 ID를 조회하려면 WowHead 또는 이와 유사한 서비스를 이용하십시오."
L[ [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=] ] = [=[이 아이템을 발견할 수 있는 지역 또는 하위-지역의 쉼표로 구분된 목록입니다. 지역의 경우, 지도 ID(예: 811은 영원꽃 골짜기) 또는 지역의 전체 이름, 둘 중 하나를 입력할 수 있습니다. 하위-지역의 경우, 하위-지역의 전체 이름을 입력해야 합니다.

적절한 맞춤법, 대문자 사용, 구두점으로 지역 이름을 입력합니다. 그들은 미국 영어 또는 고객의 현지 언어 중 하나를 입력할 수 있습니다. 이 지역의 이름을 완벽하게 입력했는지 확인하려면 WowHead 또는 이와 유사한 서비스를 이용하십시오.

참고하세요: 지역의 번역이 정확하지 않을 수 있습니다. 지역에는 이름 대신 지도 ID를 사용할 것을 강력히 추천합니다. 하위-지역에는 이름을 입력해야 합니다. 하위-지역 탐지가 잘되지 않으면, wowace.com에 LibBable0SubZone-3.0 라이브러리 페이지에 방문하여 귀하의 언어에 대한 번역을 갱신해 주십시오.]=]
--Translation missing 
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = "A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."
L["A holiday event is available today for %s! Go get it!"] = "축제 이벤트 %s|1이;가; 오늘 가능합니다! 가서 얻으세요!"
L["Abundant Bloodsail Wreckage"] = "풍부한 붉은해적단 잔해"
L["Abundant Firefin Snapper School"] = "풍부한 불지느러미퉁돔 떼"
L["Abundant Oily Blackmouth School"] = "풍부한 기름기 많은 아귀 떼"
--Translation missing 
L["Abyss Worm"] = "Abyss Worm"
L["Abyssal Gulper School"] = "심연 풍선장어 떼"
L["Adamantite Deposit"] = "아다만타이트 광맥"
L["Added %d |4waypoint:waypoints; to TomTom"] = "TomTom에 %d 목표지점 추가됨"
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = "기본 툴팁의 규모를 조정합니다. 이것은 다음 번에 표시되는 툴팁에서 효과를 가지게됩니다."
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = "3 레벨로 주둔지의 낚시터를 강화한 후, 낚아 올린 5마리의 송사리로 동굴살이를 소환하면, 이 탈것을 떨어뜨릴 수도 있습니다."
--Translation missing 
L["Ageless Bronze Drake"] = "Ageless Bronze Drake"
--Translation missing 
L["Ahune"] = "Ahune"
--Translation missing 
L["Ai-Li's Skymirror"] = "Ai-Li's Skymirror"
--Translation missing 
L["Ai-Ran the Shifting Cloud"] = "Ai-Ran the Shifting Cloud"
--Translation missing 
L["Albino Buzzard"] = "Albino Buzzard"
L["Albino Cavefish School"] = "백색 동굴어 떼"
--Translation missing 
L["Albino Chimaeraling"] = "Albino Chimaeraling"
L["Algaefin Rockfish School"] = "심해 총명어 떼"
L["All players can participate in killing this world boss once per week, regardless of faction"] = "모든 플레이어는 진영과 관계없이 일주일에 한 번 세계 우두머리를 처치하는데 참여할 수 있습니다."
L["All raid formats except Raid Finder"] = "공격대 찾기를 제외한 모든 공격대 형식"
L["Alliance only"] = "얼라이언스 전용"
L["Already defeated"] = "이미 처치함"
L["Already defeated for %s"] = "이미 %s에 의해 처치됨"
L["Already known"] = "이미 배움"
--Translation missing 
L["an item already exists by this name, so it will not be imported"] = "an item already exists by this name, so it will not be imported"
--Translation missing 
L["an item with the same Item ID already exists, so it will not be imported"] = "an item with the same Item ID already exists, so it will not be imported"
--Translation missing 
L["Ancient Mana"] = "Ancient Mana"
L["and %d |4other zone:other zones;"] = "및 %d의 기타 지역"
L["Announce"] = "알림"
L["Announcements"] = "공지 사항"
--Translation missing 
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = "Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."
--Translation missing 
L["Anubisath Idol"] = "Anubisath Idol"
L["Any difficulty"] = "모든 난이도"
L["Any raid size"] = "모든 공격대 크기"
L["Any raid size or difficulty"] = "모든 공격대 크기나 난이도"
L["Appears in the Black Market"] = "암시장에서 나타남"
--Translation missing 
L["Aqua Jewel"] = "Aqua Jewel"
--Translation missing 
L["Arakkoa"] = "Arakkoa"
--Translation missing 
L["Arcano-Shower"] = "Arcano-Shower"
L["Archaeology race"] = "고고학 종족"
L["Are you sure you want to delete this item?"] = "정말로 이 아이템을 삭제하시겠습니까?"
--Translation missing 
L["Are you sure you want to import the Rarity Item Pack you entered?"] = "Are you sure you want to import the Rarity Item Pack you entered?"
--Translation missing 
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = "Are you sure you want to turn off the Export toggle for all your Custom items?"
--Translation missing 
L["Armored Razorback"] = "Armored Razorback"
--Translation missing 
L["Armored Razzashi Raptor"] = "Armored Razzashi Raptor"
--Translation missing 
L["Ash-Covered Horn"] = "Ash-Covered Horn"
L["Ashes of Al'ar"] = "알라르의 재"
--Translation missing 
L["Ashleaf Spriteling"] = "Ashleaf Spriteling"
L["Attempts"] = "시도"
L["Auto"] = "자동"
L["Available starting December 25th"] = "12월 25일부터 유효"
--Translation missing 
L["Azure Crane Chick"] = "Azure Crane Chick"
--Translation missing 
L["Azure Whelpling"] = "Azure Whelpling"
--Translation missing 
L["Battle Horn"] = "Battle Horn"
L["Battle Pet"] = "애완동물 대전"
L["Battle Pets"] = "애완동물 대전"
L["Big Love Rocket"] = "커다란 사랑의 로켓"
--Translation missing 
L["Black Barracuda School"] = "Black Barracuda School"
L["Black Trillium Deposit"] = "검은 트릴리움 광맥"
L["Blackbelly Mudfish School"] = "검은배 미꾸라지 떼"
--Translation missing 
L["Blackflame Daggers"] = "Blackflame Daggers"
--Translation missing 
L["Blackfuse Bombling"] = "Blackfuse Bombling"
--Translation missing 
L["Blackhoof"] = "Blackhoof"
L["Blackrock Deposit"] = "검은바위 광맥"
L["Blackwater Whiptail School"] = "검은바다 채찍꼬리 떼"
--Translation missing 
L["Blackwing Banner"] = "Blackwing Banner"
L["Blank line before tooltip additions"] = "툴팁을 추가하기 전에 줄 비우기"
--Translation missing 
L["Blazing Rune"] = "Blazing Rune"
--Translation missing 
L["Bleakclaw"] = "Bleakclaw"
--Translation missing 
L["Blessed Seed"] = "Blessed Seed"
--Translation missing 
L["Blight Boar Microphone"] = "Blight Boar Microphone"
--Translation missing 
L["Blighted Spore"] = "Blighted Spore"
L["Blind Lake Sturgeon School"] = "눈먼 철갑상어 떼"
L["Bloodsail Wreckage"] = "붉은해적단 잔해"
L["Bloodsail Wreckage Pool"] = "붉은해적단 잔해"
L["Bluefish School"] = "게르치 떼"
--Translation missing 
L["Bone Serpent"] = "Bone Serpent"
--Translation missing 
L["Bonkers"] = "Bonkers"
L["Borean Man O' War School"] = "북풍 해파리 떼"
--Translation missing 
L["Boss Name"] = "Boss Name"
--Translation missing 
L["Bottled Tornado"] = "Bottled Tornado"
L["Brackish Mixed School"] = "검은색 물고기 떼"
--Translation missing 
L["Brew Frenzied Emperor Salmon"] = "Brew Frenzied Emperor Salmon"
--Translation missing 
L["Brilliant Phoenix Hawk Feather"] = "Brilliant Phoenix Hawk Feather"
--Translation missing 
L["Brinedeep Bottom-Feeder"] = "Brinedeep Bottom-Feeder"
--Translation missing 
L["Bristling Hellboar"] = "Bristling Hellboar"
--Translation missing 
L["Bronze Proto-Whelp"] = "Bronze Proto-Whelp"
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = "Bunny Hunter가 실행중입니다. 지금 Rarity로 Bunny Hunter에서 자료를 가져오시겠습니까? 두 번 다시 요청을 원하지 않으시면, Bunny Hunter를 끄시거나 예를 클릭하세요."
--Translation missing 
L["Burgy Blackheart's Handsome Hat"] = "Burgy Blackheart's Handsome Hat"
--Translation missing 
L["Call of the Frozen Blade"] = "Call of the Frozen Blade"
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = "온누리에 사랑을 축제 기간 동안에 세계 이벤트 던전을 완료하면 보상으로 주는, 심장모양 상자에 포함되어 있을 수 있습니다."
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = "가을 축제 기간 동안에 세계 이벤트 던전을 완료하면 보상으로 주는, 술통형 보물 상자에 포함되어 있을 수 있습니다."
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = "할로윈 축제 기간 동안에 세계 이벤트 던전을 완료하면 보상으로 주는, 전리품 가득한 호박에 포함되어 있을 수 있습니다."
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = "타나안 정글에 지옥불 성채의 네 정예(공포주먹, 죽음갈퀴, 복수, 파멸바퀴)에게서 떨어질 확률이 있는 달그락거리는 강철 우리에서 획득할 수 있습니다. 그들은 각각 하루에 한 번 전리품을 얻을 수 있습니다. 넷 중 하나를 죽이면 그 날은 이 탈것을 \\\"처치\\\"로 여깁니다."
L["Can be obtained with a bonus roll"] = "추가 주사위로 획득 가능"
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = "타나안 정글에 지옥 마력으로 오염된 전설 애완동물을 처치하면 획득하는 마에 물든 애완동물용품에서 떨어질 수 있습니다."
L["Captured Firefly"] = "사로잡은 반딧불이"
--Translation missing 
L["Cat Carrier (Black Tabby)"] = "Cat Carrier (Black Tabby)"
L["Cataclysm"] = "대격변"
--Translation missing 
L["Cavern Moccasin"] = "Cavern Moccasin"
--Translation missing 
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = "Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"
--Translation missing 
L["Chain Pet Leash"] = "Chain Pet Leash"
--Translation missing 
L["Chalice of Secrets"] = "Chalice of Secrets"
L["Challenge Mode instance"] = "도전 모드 던전"
L["Chance"] = "기회"
L["Chance so far"] = "기회까지"
--Translation missing 
L["Chaos Pup"] = "Chaos Pup"
--Translation missing 
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = "Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."
L[ [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=] ] = [=[이 창이 열려있는 동안 매 5초마다 검색을 자동으로 새로고침하려면 이것을 선택합니다. 검색 창에 무언가가 입력하거나 아래 목록 중 하나가 선택되어 있지 않을 때에만 자동 새로고침이 작동됩니다.

이 확인란은 Rarity에 의해 제공됩니다. Rarity 설정에서 확인란을 숨길 수 있습니다.]=]
--Translation missing 
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = "Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."
--Translation missing 
L["Christoph VonFeasel"] = "Christoph VonFeasel"
--Translation missing 
L["Chromie"] = "Chromie"
--Translation missing 
L["Chuck's Bucket"] = "Chuck's Bucket"
L["Classic"] = "오리지널"
--Translation missing 
L["Clear All Exports"] = "Clear All Exports"
L["Click to switch to this item"] = "클릭으로 이 아이템으로 전환"
L["Click to toggle the progress bar"] = "클릭으로 진행 바 전환"
--Translation missing 
L["Clockwork Rocket Bot"] = "Clockwork Rocket Bot"
--Translation missing 
L["Close"] = "Close"
--Translation missing 
L["Cloudwing Hippogryph"] = "Cloudwing Hippogryph"
--Translation missing 
L["Clutch of Ji-Kun"] = "Clutch of Ji-Kun"
L["Cobalt Deposit"] = "코발트 광맥"
--Translation missing 
L["Coin of Many Faces"] = "Coin of Many Faces"
L["Collect %d %s"] = "수집 %d %s"
L["Collected"] = "수집됨"
L["Collection Complete"] = "수집 완료"
L["Collection complete!"] = "수집 완료!"
L["Collection Size"] = "수집 크기"
L["Contained in bonus satchels"] = "추가 가방에 포함"
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = "점쟁이 조합과 매우 우호적 일 때, 평판 상인에게 수수께끼의 알을 구입하고, 3일을 기다리면 얻을 수 있는, 깨진 알에 들어있습니다. 탈것은 깨진 알에서 5%의 확률로 나타납니다."
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = "브룬힐다르 마을에 중재자 그레타에게 받는 일퀘 완료 보상인 힐드니르 가방에 들어있습니다. 탈것은 힐드니르 가방에서 3%의 확률로 나타납니다."
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = "광란심장 일족과 매우 우호적 일 때, 평판 상인에게 구역질나는 병을 구입하고, 3일을 기다리면 얻을 수 있는, 숙성한 구역질나는 병에 들어있습니다."
L["Content Category"] = "콘텐츠 범주"
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = "기본 툴팁의 아이템 위로 마우스를 갖다대면 옆에 보조 툴팁이 나타나게 제어합니다. 기본 툴팁이 화면의 오른쪽에 있으면 왼쪽으로 변경되고, 그렇지 않으면 오른쪽으로 선택됩니다. 또는, 완전히 상태 툴팁을 숨길 수 있습니다."
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = "Rarity의 LDB 공급에 표시되는 글자의 유형을 제어합니다. 단순은 시도한 숫자 만을 표시합니다. 보통은 가능성 확률 추가, 그리고 자세히는 아이템 링크까지 추가합니다."
L["Copper Vein"] = "구리 광맥"
--Translation missing 
L[ [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=] ] = [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=]
--Translation missing 
L["Core of Hardened Ash"] = "Core of Hardened Ash"
--Translation missing 
L["Corrupted Nest Guardian"] = "Corrupted Nest Guardian"
--Translation missing 
L["Corrupted Thundertail"] = "Corrupted Thundertail"
--Translation missing 
L["Crane Nest"] = "Crane Nest"
--Translation missing 
L["Crashin' Thrashin' Cannon Controller"] = "Crashin' Thrashin' Cannon Controller"
--Translation missing 
L["Crashin' Thrashin' Flyer Controller"] = "Crashin' Thrashin' Flyer Controller"
--Translation missing 
L["Crashin' Thrashin' Mortar Controller"] = "Crashin' Thrashin' Mortar Controller"
--Translation missing 
L["Crashin' Thrashin' Racer Controller"] = "Crashin' Thrashin' Racer Controller"
--Translation missing 
L["Crashin' Thrashin' Roller Controller"] = "Crashin' Thrashin' Roller Controller"
L["Create a New Item"] = "새 아이템 만들기"
L["Create a new item to track"] = "추적을 위해 새 아이템 만들기"
L["Creature ID"] = "생물 ID"
--Translation missing 
L["Crowded Redbelly Mandarin"] = "Crowded Redbelly Mandarin"
--Translation missing 
L["Crysa"] = "Crysa"
--Translation missing 
L["Crystal of the Void"] = "Crystal of the Void"
L["Ctrl-Click to change sort order"] = "\"Ctrl-클릭으로 정렬 순서 변경"
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = "Ctrl-클릭으로 나머지 TomTom 목표지점 생성"
L["Ctrl-Click to create TomTom waypoint(s)."] = "Ctrl-클릭으로 TomTom 목표지점 생성"
--Translation missing 
L["Cupri"] = "Cupri"
--Translation missing 
L["Curious Wyrmtongue Cache"] = "Curious Wyrmtongue Cache"
--Translation missing 
L["Cursed Queenfish School"] = "Cursed Queenfish School"
--Translation missing 
L["Cursed Spirit"] = "Cursed Spirit"
L["Custom"] = "사용자 정의"
L["Dandelion Frolicker"] = "민들레 까불이"
L["Dark Gazer"] = "어둠의 주시자"
L["Dark Iron Deposit"] = "검은무쇠 광맥"
L["Dark Quivering Blob"] = "벌벌떠는 검은 수액"
L["Dark Whelpling"] = "작은 암흑 새끼용"
L["Darkmoon Eye"] = "다크문 눈"
L["Data has been imported from Bunny Hunter"] = "자료는 Bunny Hunter에서 가져옵니다."
L["Death Adder Hatchling"] = "새끼 죽음살무사"
--Translation missing 
L["Death Knight"] = "Death Knight"
L["Deathcharger's Reins"] = "죽음의 군마 고삐"
L["Deathtalon"] = "죽음갈퀴"
L["Debug mode"] = "디버그 모드"
L["Debug mode OFF"] = "디버그 모드 끔"
L["Debug mode ON"] = "디버그 모드 켬"
L["Decahedral Dwarven Dice"] = "십면체 드워프 주사위"
L["Deep Sea Monsterbelly School"] = "깊은 바다 뚱뚱보물고기 떼"
L["Deepsea Sagefish School"] = "심해 총명어 떼"
--Translation missing 
L["Defeat Detection"] = "Defeat Detection"
L["Defeated"] = "처치"
L["Defiled Earth"] = "부정한 대지"
L["Delete this item"] = "이 아이템 삭제"
--Translation missing 
L["Demon Hunter"] = "Demon Hunter"
--Translation missing 
L["Demonic"] = "Demonic"
L["Determines how this item is obtained."] = "어떻게 이 아이템을 얻는지 정합니다."
L["Determines what type of item this is."] = "여기에 아이템의 유형이 무엇인지 정합니다."
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = "낚시 떼에서만 획득할 수 있는 아이템인지 여부를 정합니다. 이 설정이 작동하기 위해서는, 낚시 떼는 모든 고객의 언어로 번역되어 있어야합니다."
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = "이 아이템에 대한 추적을 사용할 지 여부를 결정합니다. 이 항목을 사용하지 않으면 툴팁에 나타나지 않습니다."
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = "이 아이템을 반복적으로 작업할 것인지 정합니다. 만약 이것을 켜고 아이템을 발견하면, Ratiry는 몇 초 후에 발견하지 못 한 아이템으로 표기합니다."
L[ [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=] ] = [=[이 항목에서 획득할 수 있는 던전 난이도를 결정합니다. 던전 난이도가 중요하지 않다면 모두 선택하지 않고 남겨둡니다.

이 아이템에 대한 통계 ID를 지정하면, 현재 모든 통계에는 이미 난이도가 포함되어 있기 때문에 던전 난이도는 아마 의미가 없을 것입니다. 

한 번에 이 목록에서 여러 항목을 선택할 수 있습니다.]=]
L["Determines which race includes this archaeology project."] = "이 고고학 복원에 포함되는 종족을 정합니다."
L["Deviate Hatchling"] = "새끼 돌연변이 랩터"
L["Direflame"] = "공포불꽃"
L["Direhorn Runt"] = "아기 공포뿔"
--Translation missing 
L["Disable for classes"] = "Disable for classes"
L["Disgusting Oozeling"] = "메스꺼운 수액덩어리"
--Translation missing 
L["Displacer Meditation Stone"] = "Displacer Meditation Stone"
--Translation missing 
L["Distance"] = "Distance"
--Translation missing 
L["Don Carlos' Famous Hat"] = "Don Carlos' Famous Hat"
L["Doomroller"] = "파멸바퀴"
L["Draenei"] = "드레나이"
L["Draenor Clans"] = "드레노어 부족들"
L["Draenor Garrison"] = "드레노어 주둔지"
L["Dragonfin Angelfish School"] = "용지느러미 천사돔 떼"
L["Drakum"] = "드라쿰"
L["Dreadwalker"] = "초소형 강철절단기"
L["Dripping Strider Egg"] = "흠뻑 젖은 포자손 알"
L["Droplet of Y'Shaarj"] = "이샤라즈 방울"
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = "영원꽃 골짜기에 있는 몹이 떨어뜨립니다(작은 몹 제외). 이것 10개로 알라니의 보호막을 깨뜨려 연결시키고, 전투를 허용하고 요동치는 루비 운룡 고삐가 떨어지는 것을 보장합니다."
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = "괴수의 섬에 공룡들이 떨어뜨리며, 3일 후에 세 종류의 원시 랩터 탈것 중 하나로 부화합니다."
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = "드레노어에서 약초를 채집할 때 일정 확률로 나오는 성난 포들링에게서 떨어짐"
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = "모구샨 금고에서 엘레곤에게서 떨어짐(모든 공격대 형식, 공격대 찾기 제외)"
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = "드레노어에서 광석을 채굴할 때 일정 확률로 나오는 고렌 파수꾼에게서 떨어짐"
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = "아카본 석실에서 화염 감시자 코랄론, 폭풍 감시자 에말론, 바위 감시자 아카본 그리고 얼음 감시자 토라본에게서 떨어짐(모든 공격대 크기)"
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = "영원의 눈에서 말리고스에게서 떨어짐(모든 공격대 크기)"
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = "오닉시아의 둥지에서 오닉시아에게서 떨어짐(모든 공격대 크기)"
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = "영의 영혼에서 데스윙의 광기 교전에서 떨어짐(모든 공격대 크기나 난이도)"
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = "영의 영혼에서 데스윙의 광기 교전에서 떨어짐(영웅, 모든 공격대 크기)"
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = "용의 영혼에서 울트락시온에게서 떨어짐(모든 공격대 크기나 난이도)"
L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = "울드아르(25인)에서 수호자의 지원 없는 요그사론에게서 떨어짐"
L["Dropped from dinosaurs on Isle of Giants"] = "괴수의 섬에 공룡들에게서 떨어짐"
L["Dropped from monsters in Fang'rila"] = "팡그릴라에서 괴물에게서 떨어짐"
L["Drops from a boss requiring a group"] = "파티를 필요로하는 우두머리에게서 떨어짐"
L["Drops from any mob in a zone"] = "지역에 있는 모든 몹에게서 떨어짐"
L["Drops from NPC(s)"] = "NPC에게서 떨어짐"
--Translation missing 
L["Drudge Remains"] = "Drudge Remains"
--Translation missing 
L["Druid"] = "Druid"
--Translation missing 
L["Dungeon ID"] = "Dungeon ID"
L["Dusty Clutch of Eggs"] = "먼지투성이 알"
L["Dwarf"] = "드워프"
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = "괴수의 섬에 쿠마에게 거대 공룡 뼈 9999개를 주면 획득합니다. 괴수의 섬에 모든 공룡과 잔달라 공룡술사에게서 거대 공룡 뼈가 떨어집니다."
L["Elementium Geode"] = "엘레멘티움 정동석"
L["Elementium Vein"] = "엘레멘티움 광맥"
L["Emperor Salmon School"] = "황제연어 떼"
L["Enable announcements"] = "공지 사항 사용"
L["Enable Coins"] = "동전 사용"
L["Enable profiling"] = "프로필 사용"
L["Enable tooltip additions"] = "추가 툴팁 사용"
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = "Rarity가 무언가 추척하려고 새로운 시도를 완료 할 때 마다 알림을 활설화합니다. 또한, 이것은 마스터 스위치이며, 아이템마다 따로 알림을 활성화 할 수 있습니다."
L["Enables announcements whenever you complete a new attempt toward this item."] = "이 아이템에 대해 새로운 시도를 완료 할 때 마다 알림을 활성화합니다."
L["Enter 1 or leave this blank to mark the item as soloable."] = "1을 입력하거나 혼자서 가능한 아이템인지 표시하려면 이곳을 공백으로 남깁니다."
L["Equal odds"] = "동일 확률"
--Translation missing 
L["Error compressing item pack"] = "Error compressing item pack"
--Translation missing 
L["Error encoding item pack"] = "Error encoding item pack"
--Translation missing 
L["Error serializing item pack"] = "Error serializing item pack"
--Translation missing 
L["Essence of the Breeze"] = "Essence of the Breeze"
L["Eternal Kiln"] = "영원의 가마솥"
--Translation missing 
L["Eternal Warrior's Sigil"] = "Eternal Warrior's Sigil"
--Translation missing 
L["Everliving Spore"] = "Everliving Spore"
L["Every item ID must be a number greater than 0."] = "모든 아이템 ID는 0보다 큰 숫자여야 합니다."
L["Every NPC ID must be a number greater than 0."] = "모든 NPC ID는 0보다 큰 숫자여야 합니다."
--Translation missing 
L["Every Quest ID must be a number greater than 0."] = "Every Quest ID must be a number greater than 0."
L["Experiment 12-B"] = "실험체 12-B"
--Translation missing 
L["Export"] = "Export"
--Translation missing 
L["Export Rarity Item Pack"] = "Export Rarity Item Pack"
--Translation missing 
L["Export this item"] = "Export this item"
--Translation missing 
L["Eye of Inquisition"] = "Eye of Inquisition"
--Translation missing 
L["Faintly Glowing Flagon of Mead"] = "Faintly Glowing Flagon of Mead"
--Translation missing 
L["Fandral's Seed Pouch"] = "Fandral's Seed Pouch"
L["Fangtooth Herring School"] = "송곳니 청어 떼"
--Translation missing 
L["Farwater Conch"] = "Farwater Conch"
L["Fat Sleeper School"] = "통통 망둑어 떼"
--Translation missing 
L["Fathom Dweller"] = "Fathom Dweller"
L["Fathom Eel Swarm"] = "심연 뱀장어 떼"
L["Feed text"] = "글자 공급"
L["Fel Iron Deposit"] = "지옥무쇠 광맥"
--Translation missing 
L["Felfly"] = "Felfly"
L["Felslate Deposit"] = "지옥판암 광맥"
--Translation missing 
L["Felslate Seam"] = "Felslate Seam"
--Translation missing 
L["Felsteel Annihilator"] = "Felsteel Annihilator"
--Translation missing 
L["Felsworn Sentry"] = "Felsworn Sentry"
L["Feltail School"] = "지옥꼬리퉁돔 떼"
--Translation missing 
L["Fever of Stormrays"] = "Fever of Stormrays"
--Translation missing 
L["Fiery Warhorse's Reins"] = "Fiery Warhorse's Reins"
L["Fire Ammonite School"] = "화염 암모나이트 떼"
L["Firefin Snapper School"] = "불지느러미퉁돔 떼"
L["Firewing"] = "불꽃날개"
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = "내트 페이글의 도움으로 드레노어의 모든 곳에서 낚시로(주둔지 제외)"
L["Flametalon of Alysrazor"] = "알리스라조르의 화염갈퀴"
L["Floating Debris"] = "표류하는 파편"
--Translation missing 
L["Floating Debris Pool"] = "Floating Debris Pool"
--Translation missing 
L["Floating Shipwreck Debris"] = "Floating Shipwreck Debris"
L["Floating Wreckage"] = "표류하는 잔해"
L["Floating Wreckage Pool"] = true
L["Font"] = "글꼴"
L["Font Size"] = "글꼴 크기"
L["Foot Ball"] = "발공"
L["Fossil"] = "화석"
L["Fossilized Raptor"] = "화석 랩터"
L["Found after %d attempts!"] = "%d번의 시도 끝에 발견!"
L["Found in: "] = "발견 장소: "
L["Found on your first attempt!"] = "첫 시도에서 발견!"
--Translation missing 
L["Fox Kit"] = "Fox Kit"
--Translation missing 
L["Fragment of Anger"] = "Fragment of Anger"
--Translation missing 
L["Fragment of Desire"] = "Fragment of Desire"
--Translation missing 
L["Fragment of Frozen Bone"] = "Fragment of Frozen Bone"
--Translation missing 
L["Fragment of Suffering"] = "Fragment of Suffering"
--Translation missing 
L["Frenzyheart Brew"] = "Frenzyheart Brew"
--Translation missing 
L["Frightened Bush Chicken"] = "Frightened Bush Chicken"
--Translation missing 
L["Fuzzy Green Lounge Cushion"] = "Fuzzy Green Lounge Cushion"
--Translation missing 
L["Gahz'rooki's Summoning Stone"] = "Gahz'rooki's Summoning Stone"
--Translation missing 
L["Gar'lok"] = "Gar'lok"
--Translation missing 
L["Garn Nighthowl"] = "Garn Nighthowl"
--Translation missing 
L["Garn Steelmaw"] = "Garn Steelmaw"
L["Garrison Invasion Gold Victory"] = "주둔지 침략 금메달 승리"
L["Garrison Invasion Platinum Victory"] = "주둔지 침략 백금에달 승리"
--Translation missing 
L["Gastropod Shell"] = "Gastropod Shell"
L["General"] = "일반"
L["General Options"] = "일반 설정"
L["Ghost Iron Deposit"] = "유령무쇠 광맥"
--Translation missing 
L["Giant Coldsnout"] = "Giant Coldsnout"
L["Giant Mantis Shrimp Swarm"] = "거대 사마귀 새우 떼"
--Translation missing 
L["Giant Sewer Rat"] = "Giant Sewer Rat"
--Translation missing 
L["Giant Worm Egg"] = "Giant Worm Egg"
--Translation missing 
L["Gibblette the Cowardly"] = "Gibblette the Cowardly"
L["Glacial Salmon School"] = "빙하연어 떼"
L["Glassfin Minnow School"] = "유리지느러미 송사리 떼"
--Translation missing 
L["Glimmering Jewel Danio Pool"] = "Glimmering Jewel Danio Pool"
--Translation missing 
L["Glimmering Treasure Chest"] = "Glimmering Treasure Chest"
--Translation missing 
L["Glittering Arcane Crystal"] = "Glittering Arcane Crystal"
--Translation missing 
L["Glittering Ball of Yarn"] = "Glittering Ball of Yarn"
--Translation missing 
L["Glowing Jade Lungfish"] = "Glowing Jade Lungfish"
--Translation missing 
L["Gluth's Bone"] = "Gluth's Bone"
L["Gold Vein"] = "금 광맥"
L["Golden Carp School"] = "황금 잉어 떼"
--Translation missing 
L["Gondar"] = "Gondar"
--Translation missing 
L["Gooey Sha-ling"] = "Gooey Sha-ling"
--Translation missing 
L["Goren \"Log\" Roller"] = "Goren \"Log\" Roller"
--Translation missing 
L["Great Brewfest Kodo"] = "Great Brewfest Kodo"
L["Greater Sagefish School"] = "대형 총명어 떼"
--Translation missing 
L["Greatfather Winter's Tree"] = "Greatfather Winter's Tree"
L["Green Helper Box"] = "녹색 도우미 상자"
--Translation missing 
L["Grotesque Statue"] = "Grotesque Statue"
L["Group Finder Options"] = "파티 찾기 설정"
L["Group size"] = "파티 크기"
L["Group(s) found!"] = "파티 발견!"
--Translation missing 
L["Grow Up"] = "Grow Up"
--Translation missing 
L["Grumpling"] = "Grumpling"
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = "낙타사육사 도르무스에게서 떨어지는게 확실합니다. 이와 만나 접촉하려면 울둠에 있는 드문 수수께끼 낙타 조각상을 발견해야 합니다. 어떤 것은 장소가 까다롭고, 클릭하면, 도르무스와 만나서 접촉할 수 있는 적은 기회가 있습니다. Rarity는 그것에 마우스를 갖다대면 당신이 얼마나 많은 조각상을 발견했는지 계산합니다."
--Translation missing 
L["Gu'chi Swarmling"] = "Gu'chi Swarmling"
--Translation missing 
L["Guk"] = "Guk"
--Translation missing 
L["Gulp Froglet"] = "Gulp Froglet"
--Translation missing 
L["Gundrak Hatchling"] = "Gundrak Hatchling"
--Translation missing 
L["Half-Empty Food Container"] = "Half-Empty Food Container"
--Translation missing 
L["Hardened Shell"] = "Hardened Shell"
L["Height"] = "높이"
--Translation missing 
L["Helpful Wikky's Whistle"] = "Helpful Wikky's Whistle"
--Translation missing 
L["Here is a preview of what will (or won't) be imported:"] = "Here is a preview of what will (or won't) be imported:"
L["Heroic difficulty"] = "영웅 난이도"
L["Heroic Raid (10-30 players)"] = "영웅 공격대 (10-30인)"
L["Heroic Scenario instance"] = "영웅 시나리오 던전"
L["Heroic, any raid size"] = "영웅, 모든 공격대 크기"
L["Hidden"] = "숨김"
L["Hide defeated items"] = "처치한 아이템 숨김"
L["Hide high chance items"] = "확률이 높은 아이템 숨김"
--Translation missing 
L["Hide items not in your zone"] = "Hide items not in your zone"
--Translation missing 
L["Hide items with no attempts"] = "Hide items with no attempts"
L["Hide unavailable items"] = "얻을 수 없는 아이템 숨김"
--Translation missing 
L["High Priest of Ordos"] = "High Priest of Ordos"
--Translation missing 
L["Highborne"] = "Highborne"
L["Highland Guppy School"] = "고원 송사리 떼"
L["Highland Mixed School"] = "고원의 물고기 떼"
--Translation missing 
L["Highmountain Elderhorn"] = "Highmountain Elderhorn"
--Translation missing 
L["Highmountain Salmon School"] = "Highmountain Salmon School"
--Translation missing 
L["Highmountain Tauren"] = "Highmountain Tauren"
L["Holiday"] = "축제"
L["Holiday reminders"] = "축제 알림"
L["Hollow Reed"] = "속이 빈 갈대"
L["Horde only"] = "호드 전용"
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = "아이템이 나타날 가능성이 얼마나 되는지, X에 1로 표현, X는 여기에 입력할 숫자입니다."
L["How many attempts you've made so far."] = "지금까지 시도한 횟수"
L["How many items you need to collect."] = "수집하길 원하는 아이템의 양"
L["How many items you've collected so far."] = "지금까지 수집한 아이템의 양"
--Translation missing 
L["Hozen Beach Ball"] = "Hozen Beach Ball"
L["Huge Obsidian Slab"] = "풍부한 흑요암 광맥"
--Translation missing 
L["Hunter"] = "Hunter"
--Translation missing 
L["Hyjal Wisp"] = "Hyjal Wisp"
--Translation missing 
L["Ice Chip"] = "Ice Chip"
L["Identify the Item"] = "아이템 발견"
--Translation missing 
L["Imbued Jade Fragment"] = "Imbued Jade Fragment"
L["Imperial Manta Ray School"] = "황제 쥐가오리 떼"
--Translation missing 
L["Imperial Moth"] = "Imperial Moth"
--Translation missing 
L["Imperial Silkworm"] = "Imperial Silkworm"
--Translation missing 
L["Imp-Master Valessa"] = "Imp-Master Valessa"
--Translation missing 
L["Import"] = "Import"
--Translation missing 
L["Import Rarity Item Pack"] = "Import Rarity Item Pack"
--Translation missing 
L["Import/Export"] = "Import/Export"
--Translation missing 
L["imported successfully"] = "imported successfully"
L["Incendicite Mineral Vein"] = "발연 광석 광맥"
L["Indurium Mineral Vein"] = "인듀리움 광맥"
L["Install TomTom to enable waypoint creation."] = "목표지점 생성이 가능하게 하려면 TomTom을 설치합니다."
L["Instance Difficulty"] = "던전 난이도"
L["Instant Arcane Sanctum Security Kit"] = "즉석 비전 성소 봉안 장치"
--Translation missing 
L["Invincible's Reins"] = "Invincible's Reins"
L["Iron Deposit"] = "철 광맥"
--Translation missing 
L["Ironbound Collar"] = "Ironbound Collar"
--Translation missing 
L["Ironhoof Destroyer"] = "Ironhoof Destroyer"
L["Item ID"] = "아이템 ID"
L["Item ID to Collect"] = "수집하려는 아이템 ID"
L["Items to Use"] = "사용되는 아이템"
L["Jade Lungfish School"] = "비취 폐어 떼"
--Translation missing 
L["Jadefire Spirit"] = "Jadefire Spirit"
--Translation missing 
L["Jademist Dancer"] = "Jademist Dancer"
L["Jawless Skulker School"] = "무턱 모래무지 떼"
--Translation missing 
L["Jeremy Feasel"] = "Jeremy Feasel"
L["Jewel Danio School"] = "보석 열대어 떼"
--Translation missing 
L["Jewel of Maddening Whispers"] = "Jewel of Maddening Whispers"
--Translation missing 
L["Ji-Kun Hatchling"] = "Ji-Kun Hatchling"
--Translation missing 
L["Jingling Bell"] = "Jingling Bell"
--Translation missing 
L["Kael'thas Sunstrider"] = "Kael'thas Sunstrider"
--Translation missing 
L["Kaldorei Light Globe"] = "Kaldorei Light Globe"
--Translation missing 
L["Kal'tik the Blight"] = "Kal'tik the Blight"
--Translation missing 
L["Kang's Bindstone"] = "Kang's Bindstone"
L["Khorium Vein"] = "코륨 광맥"
L["Kill Statistic IDs"] = "처치 통계 ID"
--Translation missing 
L["Knockoff Blingtron"] = "Knockoff Blingtron"
--Translation missing 
L["Kor'kron Juggernaut"] = "Kor'kron Juggernaut"
--Translation missing 
L["Kovok"] = "Kovok"
L["Krasarang Paddlefish School"] = "크라사랑 주걱철갑상어 떼"
L["Kyparite Deposit"] = "키파라이트 광맥"
--Translation missing 
L["Land Shark"] = "Land Shark"
L["Large Obsidian Chunk"] = "풍부한 흑요암 광맥"
--Translation missing 
L["Large Pool of Brew Frenzied Emperor Salmon"] = "Large Pool of Brew Frenzied Emperor Salmon"
--Translation missing 
L["Large Pool of Crowded Redbelly Mandarin"] = "Large Pool of Crowded Redbelly Mandarin"
--Translation missing 
L["Large Pool of Glimmering Jewel Danio Pool"] = "Large Pool of Glimmering Jewel Danio Pool"
--Translation missing 
L["Large Pool of Glowing Jade Lungfish"] = "Large Pool of Glowing Jade Lungfish"
--Translation missing 
L["Large Pool of Sha-Touched Spinefish"] = "Large Pool of Sha-Touched Spinefish"
--Translation missing 
L["Large Pool of Tiger Gourami Slush"] = "Large Pool of Tiger Gourami Slush"
--Translation missing 
L["Large Swarm of Migrated Reef Octopus"] = "Large Swarm of Migrated Reef Octopus"
--Translation missing 
L["Large Swarm of Panicked Paddlefish"] = "Large Swarm of Panicked Paddlefish"
--Translation missing 
L["Large Tangled Mantis Shrimp Cluster"] = "Large Tangled Mantis Shrimp Cluster"
L["Last Month"] = "지난달"
L["Last Week"] = "지난주"
L["Left"] = "왼쪽"
--Translation missing 
L["Legion"] = "Legion"
L["Lesser Bloodstone Deposit"] = "저급 혈석 광맥"
L["Lesser Firefin Snapper School"] = "소량의 불지느러미퉁돔 떼"
L["Lesser Floating Debris"] = "소량의 표류하는 파편"
L["Lesser Oily Blackmouth School"] = "소량의 기름기 많은 아귀 떼"
L["Lesser Sagefish School"] = "소량의 총명어 떼"
--Translation missing 
L["Leviathan Egg"] = "Leviathan Egg"
--Translation missing 
L["Ley Spider Eggs"] = "Ley Spider Eggs"
L["Leystone Deposit"] = "지맥석 광맥"
--Translation missing 
L["Leystone Seam"] = "Leystone Seam"
--Translation missing 
L["Leywoven Flying Carpet"] = "Leywoven Flying Carpet"
--Translation missing 
L["Life-Binder's Handmaiden"] = "Life-Binder's Handmaiden"
L["Likelihood"] = "가능성"
--Translation missing 
L["Lil' Bling"] = "Lil' Bling"
--Translation missing 
L["Living Infernal Core"] = "Living Infernal Core"
--Translation missing 
L["Living Sandling"] = "Living Sandling"
L["Loaded (running in debug mode)"] = "불러옴 (디버그 모드에서 실행)"
--Translation missing 
L["Loaded Gnomish Dice"] = "Loaded Gnomish Dice"
L["Loading"] = "불러오는 중"
L["Locked"] = "잠김"
L["Looking For Raid (10-30 players)"] = "공격대 찾기 (10-30인)"
L["Luckiness"] = "행운"
L["Lucky"] = "운"
L["lucky"] = "운"
L["Lucky if you obtain in %d or less"] = "%d 이하에서 얻을 수 있는 운"
--Translation missing 
L["Lump of Coal"] = "Lump of Coal"
--Translation missing 
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = "Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."
--Translation missing 
L["Mage"] = "Mage"
--Translation missing 
L["Magnataur Hunting Horn"] = "Magnataur Hunting Horn"
--Translation missing 
L["Major Nanners"] = "Major Nanners"
L["Mantid"] = "사마귀"
L["Mark of Flame"] = "화염의 징표"
L["Method of obtaining"] = "얻는 방법"
--Translation missing 
L["Midnight's Eternal Reins"] = "Midnight's Eternal Reins"
--Translation missing 
L["Mimiron's Head"] = "Mimiron's Head"
L["Minimal"] = "단순"
--Translation missing 
L["Minion of Grumpus"] = "Minion of Grumpus"
--Translation missing 
L["MiniZep Controller"] = "MiniZep Controller"
L["Mirecroak"] = "수렁개구리"
L["Mists of Pandaria"] = "판다리아의 안개"
L["Mithril Deposit"] = "미스릴 광맥"
L["Mogu"] = "모구"
L["Mojo"] = "모조"
--Translation missing 
L["Monk"] = "Monk"
--Translation missing 
L["Moon Moon"] = "Moon Moon"
--Translation missing 
L["Moonfang"] = "Moonfang"
--Translation missing 
L["Moonfang Shroud"] = "Moonfang Shroud"
--Translation missing 
L["Moonfang's Paw"] = "Moonfang's Paw"
L["Moonglow Cuttlefish School"] = "달빛 오징어 떼"
--Translation missing 
L["Mossgill Perch School"] = "Mossgill Perch School"
L["Mount"] = "탈것"
--Translation missing 
L["Mountain Panda"] = "Mountain Panda"
L["Mountain Trout School"] = "산악 송어 떼"
L["Mounts"] = "탈것"
--Translation missing 
L["Mr. Grubbs"] = "Mr. Grubbs"
--Translation missing 
L["Mr. Pinchy"] = "Mr. Pinchy"
--Translation missing 
L["Mr. Smite's Brass Compass"] = "Mr. Smite's Brass Compass"
--Translation missing 
L["Muckbreaths's Bucket"] = "Muckbreaths's Bucket"
--Translation missing 
L["Muddy Churning Water"] = "Muddy Churning Water"
L["Mudfish School"] = "미꾸라지 떼"
L["Musselback Sculpin School"] = "조개등 둑중개 떼"
--Translation missing 
L["Muyani"] = "Muyani"
L["Mysterious Camel Figurine"] = "수수께끼 낙타 조각상"
L["Mythic 5-player instance"] = "신화 5인 던전"
L["Mythic difficulty"] = "신화 난이도"
L["Mythic Raid (20 player)"] = "신화 공격대 (20인)"
L["Nerubian"] = "네루비안"
--Translation missing 
L["Nerubian Relic"] = "Nerubian Relic"
--Translation missing 
L["Nessos the Oracle"] = "Nessos the Oracle"
L["Nethercite Deposit"] = "황천연 광맥"
--Translation missing 
L["Netherfist"] = "Netherfist"
--Translation missing 
L["Netherspace Portal-Stone"] = "Netherspace Portal-Stone"
L["Nettlefish School"] = "해파리 떼"
L["New item"] = "새 아이템"
L["Night Elf"] = "나이트 엘프"
--Translation missing 
L["Nightmare Bell"] = "Nightmare Bell"
--Translation missing 
L["Nightmare Whelpling"] = "Nightmare Whelpling"
--Translation missing 
L["Nightshade Sproutling"] = "Nightshade Sproutling"
--Translation missing 
L[ [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=] ] = [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=]
L["None"] = "없음"
L["None (not in an instance)"] = "없음 (던전 아님)"
L["Normal"] = "보통"
L["Normal Raid (10-30 players)"] = "일반 공격대 (10-30인)"
--Translation missing 
L["not imported"] = "not imported"
--Translation missing 
L["NPCs"] = "NPCs"
L["Obsidium Deposit"] = "흑요암 광맥"
--Translation missing 
L["Obtained Achievement ID"] = "Obtained Achievement ID"
L["Obtained After %d Attempts"] = "%d번의 시도 끝에 획득"
L["Obtained as a rare project for the Fossil branch of archaeology"] = "고고학의 화석에 대한 희귀 복원으로 획득"
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = "고고학의 톨비르에 대한 매우 희귀 복원으로 획득"
L["Obtained as an archaeology project"] = "고고학 복원으로 획득"
L["Obtained by collecting a number of items"] = "아이템의 개수로 수집하여 획득"
L["Obtained by fishing"] = "낚시로 획득"
L["Obtained by fishing in any water in Ironforge"] = "아이언포지에 있는 물가에서 낚시로 획득"
L["Obtained by fishing in any water in Orgrimmar"] = "오그리마에 있는 물가에서 낚시로 획득"
L["Obtained by fishing in pools located in Terrokar Forest"] = "테로카르 숲에 위치한 물고기 떼에서 낚시로 획득"
L["Obtained by mining"] = "채광으로 획득"
L["Obtained by mining Elementium Vein"] = "엘레멘티움 광맥 채광으로 획득"
L["Obtained by opening Crane Nests on the Timeless Isle"] = "영원의 섬에 학 둥지를 열어 획득"
L["Obtained by opening Snow Mound in Frostfire Ridge"] = "서리불꽃 마루에 있는 눈더미를 열어 획득"
L["Obtained by opening Timeless Chests on the Timeless Isle"] = "영원의 섬에 영원의 상자를 열어 획득"
L["Obtained by using an item or opening a container"] = "아이템을 사용하거나 상자를 열어서 획득"
L["Obtained On Your First Attempt"] = "첫 번째 시도에 획득"
--Translation missing 
L["Obtained Quest ID"] = "Obtained Quest ID"
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = "모든 확장팩 지역(오리지널 지역 아님)에 위치한 물고기 떼에서 매우 드물게 획득."
--Translation missing 
L["Odd Polished Stone"] = "Odd Polished Stone"
L["Ogre"] = "오우거"
L["Oil Spill"] = "떠다니는 기름"
L["Oily Abyssal Gulper School"] = "기름투성이 심연 풍선장어 떼"
L["Oily Blackmouth School"] = "기름기 많은 아귀 떼"
L["Oily Sea Scorpion School"] = "기름투성이 바다 전갈 떼"
L["Old Crafty"] = "늙은 재주꾼"
L["Old Ironjaw"] = "늙은 무쇠턱"
--Translation missing 
L["Old Man Barlo"] = "Old Man Barlo"
--Translation missing 
L["Ominous Flame"] = "Ominous Flame"
--Translation missing 
L["Ominous Pile of Snow"] = "Ominous Pile of Snow"
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = "지도 ID 중 하나(%s)가 부정확하게 입력되었습니다. 0보다 큰 숫자를 입력하십시오."
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = "입력한 지역이나 하위 지역(%s) 중 하나를 찾을 수 없습니다. US 영어 또는 고객의 현지 언어 중 하나이며, 정확한 철자인지 확인합니다."
--Translation missing 
L["Only announce when found"] = "Only announce when found"
L["Only Raid Finder difficulty"] = "공격대 찾기 난이도 전용"
L["Ooze Covered Gold Vein"] = "진흙으로 덮인 금 광맥"
L["Ooze Covered Mithril Deposit"] = "진흙으로 덮인 미스릴 광맥"
L["Ooze Covered Rich Thorium Vein"] = "진흙으로 덮인 풍부한 토륨 광맥"
L["Ooze Covered Silver Vein"] = "진흙으로 덮인 은 광맥"
L["Ooze Covered Thorium Vein"] = "진흙으로 덮인 토륨 광맥"
L["Ooze Covered Truesilver Deposit"] = "진흙으로 덮인 진은 광맥"
--Translation missing 
L["Options"] = "Options"
--Translation missing 
L["Orb of the Sin'dorei"] = "Orb of the Sin'dorei"
L["Orc"] = "오크"
--Translation missing 
L["Orphaned Felbat"] = "Orphaned Felbat"
L["Other"] = "기타"
L["Other Requirements"] = "기타 요구 사항"
--Translation missing 
L["Overcomplicated Controller"] = "Overcomplicated Controller"
--Translation missing 
L["Paladin"] = "Paladin"
L["Pandaren"] = "판다렌"
L["Pandaren Firework Launcher"] = "판다렌 폭죽 발사대"
L["Panflute of Pandaria"] = "판다리아의 팬플푸트"
L["Parrot Cage (Green Wing Macaw)"] = "초록금강앵무 새장"
L["Parrot Cage (Hyacinth Macaw)"] = "유리금강앵무 새장"
--Translation missing 
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = "Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."
L["Patch of Elemental Water"] = "정기가 흐르는 물 웅덩이"
L["Periwinkle Calf"] = "청보라색 강물하마"
L["Phoenix Hatchling"] = "새끼 불사조"
L["Pineapple Lounge Cushion"] = "파인애플 라운지 쿠션"
L["Play a sound when groups are found"] = "파티가 발견되면 소리 재생"
L["Players have a personal loot chance to obtain this item."] = "플레이어는 개인 전리품으로 이 아이템을 얻을 기회가 있습니다."
L["Please enter a comma-separated list of item IDs."] = "아이템 ID로 된 목록을 쉼표로 구분하여 입력해 주십시오."
L["Please enter a comma-separated list of NPC IDs."] = "NPC ID로 된 목록을 쉼표로 구분하여 입력해 주십시오."
--Translation missing 
L["Please enter a comma-separated list of Quest IDs."] = "Please enter a comma-separated list of Quest IDs."
L["Please enter a comma-separated list of Statistic IDs."] = "통계 ID로 된 목록을 쉼표로 구분하여 입력해 주십시오."
L["Please enter a comma-separated list of zones."] = "지역으로 된 목록을 쉼표로 구분하여 입력해 주십시오."
L["Pool of Fire"] = "불타는 웅덩이"
L["Porcupette"] = "새끼 호저"
--Translation missing 
L["Priest"] = "Priest"
L["Primal Egg"] = "원시 알"
--Translation missing 
L["Primary tooltip hide delay"] = "Primary tooltip hide delay"
L["Primary tooltip scale"] = "기본 툴팁 크기"
L["Profile modified, rebooting"] = "프로필 수정됨, 재부팅"
L["Profiling OFF"] = "프로필 끔"
L["Profiling ON"] = "프로필 켬"
L["Progress"] = "진행"
L["Progress Bar"] = "진행 바"
L["Puddle Terror"] = "공포의 물방울"
--Translation missing 
L["Pugg"] = "Pugg"
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = "타나안 정글에 팡그릴라에서 걷는 자 즈텡가 <서슬추적자 병참방교>에게서 구입합니다. 팡그릴라 안에 있는 모든 괴물이 검은송곳니 발톱을 떨어뜨립니다."
L["Pure Saronite Deposit"] = "순수한 사로나이트 광맥"
L["Pure Water"] = "깨끗한 물"
--Translation missing 
L["Put \"Rarity:\" on a separate line"] = "Put \"Rarity:\" on a separate line"
--Translation missing 
L["Putricide's Alchemy Supplies"] = "Putricide's Alchemy Supplies"
L["Pygmy Direhorn"] = "꼬마 공포뿔"
L["Pyrite Deposit"] = "황철석 광맥"
--Translation missing 
L["Quest ID"] = "Quest ID"
L["Quivering Blob"] = "벌벌떠는 수액"
L["Raid Finder instance (legacy content; fixed at 25 players)"] = "공격대 찾기 던전 (예전 콘텐츠, 25인에 고정)"
L["Raid Finder or Flexible difficulty"] = "공격대 찾기 또는 탄력적 난이도"
L["Rarity has %d |4coordinate:coordinates; for this item."] = "이 아이템에 대한 %d개의 좌표가 Rarity에 있습니다."
--Translation missing 
L["Rarity is loading..."] = "Rarity is loading..."
--Translation missing 
L["Rarity Item Pack String"] = "Rarity Item Pack String"
L["Rarity Tooltip Options"] = "Rarity 툴팁 설정"
--Translation missing 
L["Rarity: "] = "Rarity: "
L["Razzashi Hatchling"] = "새끼 래즈자쉬 랩터"
L["Red Goren Egg"] = "붉은 고렌 알"
--Translation missing 
L["Red Helper Box"] = "Red Helper Box"
--Translation missing 
L["Red Qiraji Resonating Crystal"] = "Red Qiraji Resonating Crystal"
L["Redbelly Mandarin School"] = "붉은배 쏘가리 떼"
--Translation missing 
L["Red-Hot Coal"] = "Red-Hot Coal"
L["Reef Octopus Swarm"] = "암초문어 떼"
--Translation missing 
L["Reins of the Amber Primordial Direhorn"] = "Reins of the Amber Primordial Direhorn"
--Translation missing 
L["Reins of the Astral Cloud Serpent"] = "Reins of the Astral Cloud Serpent"
--Translation missing 
L["Reins of the Azure Drake"] = "Reins of the Azure Drake"
--Translation missing 
L["Reins of the Black Primal Raptor"] = "Reins of the Black Primal Raptor"
--Translation missing 
L["Reins of the Blazing Drake"] = "Reins of the Blazing Drake"
--Translation missing 
L["Reins of the Blue Drake"] = "Reins of the Blue Drake"
--Translation missing 
L["Reins of the Blue Proto-Drake"] = "Reins of the Blue Proto-Drake"
--Translation missing 
L["Reins of the Bone-White Primal Raptor"] = "Reins of the Bone-White Primal Raptor"
--Translation missing 
L["Reins of the Cobalt Primordial Direhorn"] = "Reins of the Cobalt Primordial Direhorn"
--Translation missing 
L["Reins of the Crimson Water Strider"] = "Reins of the Crimson Water Strider"
--Translation missing 
L["Reins of the Drake of the North Wind"] = "Reins of the Drake of the North Wind"
--Translation missing 
L["Reins of the Drake of the South Wind"] = "Reins of the Drake of the South Wind"
--Translation missing 
L["Reins of the Grand Black War Mammoth"] = "Reins of the Grand Black War Mammoth"
--Translation missing 
L["Reins of the Green Primal Raptor"] = "Reins of the Green Primal Raptor"
--Translation missing 
L["Reins of the Green Proto-Drake"] = "Reins of the Green Proto-Drake"
--Translation missing 
L["Reins of the Grey Riding Camel"] = "Reins of the Grey Riding Camel"
--Translation missing 
L["Reins of the Heavenly Onyx Cloud Serpent"] = "Reins of the Heavenly Onyx Cloud Serpent"
--Translation missing 
L["Reins of the Infinite Timereaver"] = "Reins of the Infinite Timereaver"
--Translation missing 
L["Reins of the Jade Primordial Direhorn"] = "Reins of the Jade Primordial Direhorn"
--Translation missing 
L["Reins of the Onyxian Drake"] = "Reins of the Onyxian Drake"
--Translation missing 
L["Reins of the Raven Lord"] = "Reins of the Raven Lord"
--Translation missing 
L["Reins of the Slate Primordial Direhorn"] = "Reins of the Slate Primordial Direhorn"
--Translation missing 
L["Reins of the Thundering Cobalt Cloud Serpent"] = "Reins of the Thundering Cobalt Cloud Serpent"
--Translation missing 
L["Reins of the Thundering Onyx Cloud Serpent"] = "Reins of the Thundering Onyx Cloud Serpent"
--Translation missing 
L["Reins of the Vitreous Stone Drake"] = "Reins of the Vitreous Stone Drake"
--Translation missing 
L["Reins of the White Polar Bear"] = "Reins of the White Polar Bear"
--Translation missing 
L["Remains of a Blood Beast"] = "Remains of a Blood Beast"
L["Repeatable"] = "반복 가능"
L["Required for %s"] = "%s에 필요"
L["Requires a pool"] = "물고기 떼 필요"
L["Requires Pickpocketing"] = "훔치기 필요"
L["Rich Adamantite Deposit"] = "풍부한 아다만타이트 광맥"
L["Rich Blackrock Deposit"] = "풍부한 검은바위 광맥"
L["Rich Cobalt Deposit"] = "풍부한 코발트 광맥"
L["Rich Elementium Vein"] = "풍부한 엘레멘티움 광맥"
L["Rich Felslate Deposit"] = "풍부한 지옥판암 광맥"
L["Rich Ghost Iron Deposit"] = "풍부한 유령무쇠 광맥"
L["Rich Kyparite Deposit"] = "풍부한 키파라이트 광맥"
L["Rich Leystone Deposit"] = "풍부한 지맥석 광맥"
L["Rich Obsidium Deposit"] = "풍부한 흑요암 광맥"
L["Rich Pyrite Deposit"] = "풍부한 황철석 광맥"
L["Rich Saronite Deposit"] = "풍부한 사로나이트 광맥"
L["Rich Thorium Vein"] = "풍부한 토륨 광맥"
L["Rich Trillium Vein"] = "풍부한 트릴리움 광맥"
L["Rich True Iron Deposit"] = "풍부한 순철 광맥"
--Translation missing 
L["Riding Turtle"] = "Riding Turtle"
L["Right"] = "오른쪽"
L["Right-Aligned"] = "오른쪽-정렬"
L["Rime of the Time-Lost Mariner"] = "잃어버린 시간의 뱃사람 노래"
--Translation missing 
L["Rogue"] = "Rogue"
--Translation missing 
L["Rotten Helper Box"] = "Rotten Helper Box"
--Translation missing 
L["Ruby Droplet"] = "Ruby Droplet"
--Translation missing 
L["Rukdug"] = "Rukdug"
--Translation missing 
L["Runescale Koi School"] = "Runescale Koi School"
--Translation missing 
L["Sack of Spectral Spiders"] = "Sack of Spectral Spiders"
--Translation missing 
L["Safari Lounge Cushion"] = "Safari Lounge Cushion"
L["Sagefish School"] = "총명어 떼"
--Translation missing 
L["Sahn Tidehunter"] = "Sahn Tidehunter"
--Translation missing 
L["Salyin Battle Banner"] = "Salyin Battle Banner"
--Translation missing 
L["Salyin Warscout"] = "Salyin Warscout"
L["Saronite Deposit"] = "사로나이트 광맥"
--Translation missing 
L["Sassy Imp"] = "Sassy Imp"
--Translation missing 
L["Satyr Charm"] = "Satyr Charm"
--Translation missing 
L["Savage Cub"] = "Savage Cub"
L["Savage Piranha Pool"] = "야만적인 피라냐떼"
L["Scale"] = "크기"
L["Scenario instance"] = "시나리오 던전"
--Translation missing 
L["Scepter of Azj'Aqir"] = "Scepter of Azj'Aqir"
L["School of Darter"] = "황금 화살고기 떼"
L["School of Deviate Fish"] = "돌연변이 물고기 떼"
L["School of Tastyfish"] = "맛둥어 떼"
L["Schooner Wreckage"] = "범선 잔해"
L["Schooner Wreckage Pool"] = "범선 잔해"
--Translation missing 
L["Scorched Stone"] = "Scorched Stone"
--Translation missing 
L["Scraps"] = "Scraps"
--Translation missing 
L["Sea Calf"] = "Sea Calf"
--Translation missing 
L["Sea Pony"] = "Sea Pony"
L["Sea Scorpion School"] = "바다 전갈 떼"
--Translation missing 
L["Sea Turtle"] = "Sea Turtle"
--Translation missing 
L["Seaborne Spore"] = "Seaborne Spore"
L["Secondary tooltip display"] = "보조 툴팁 표시"
--Translation missing 
L["Servant of Demidos"] = "Servant of Demidos"
--Translation missing 
L["Servant's Bell"] = "Servant's Bell"
L["Session"] = "접속중"
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = "이 아이템을 얻으면 어떤 것을 나타낼지 업적 ID로 이것을 설정합니다. 이것은 늙은 재주꾼 또는 늙은 무쇠턱과 같이 어떤 것을 획득할 때 업적을 부여해야 할 것이나, 어떤 탈것 또는 애완동물의 수확이 없는 아이템을 위해 유용합니다. 탈것과 애완동물을 위해 이것을 공백으로 남겨둡니다. 업적 ID를 찾으려면 WowHead를 이용하십시오."
--Translation missing 
L["Shadowhide Pearltusk"] = "Shadowhide Pearltusk"
--Translation missing 
L["Shaman"] = "Shaman"
--Translation missing 
L["Shard of Supremus"] = "Shard of Supremus"
--Translation missing 
L["Sha-Touched Spinefish"] = "Sha-Touched Spinefish"
--Translation missing 
L["Shell of Tide-Calling"] = "Shell of Tide-Calling"
L["Shift-Click to link your progress to chat"] = "Shift-클릭으로 대화창에 진행 상황 링크"
L["Shift-Click to open options"] = "Shift-클릭으로 설정 열기"
L["Shipwreck Debris"] = "난파선 파편"
L["Show anchor"] = "고정핀 표시"
L["Show attempts in tooltips"] = "툴팁에 시도 횟수 표시"
L["Show auto refresh checkbox"] = "자동 새로고침 확인란 표시"
L["Show category icons"] = "범주 아이콘 표시"
L["Show Icon"] = "아이콘 표시"
L["Show Luckiness column"] = "행운 줄 표시"
L["Show minimap icon"] = "미니맵 아이콘 표시"
L["Show Text"] = "글자 표시"
L["Show Time column"] = "시간 줄 표시"
L["Show Zone column"] = "지역 줄 표시"
L["Silver Vein"] = "은 광맥"
--Translation missing 
L["Silver-Plated Turkey Shooter"] = "Silver-Plated Turkey Shooter"
L["Since last drop"] = "지난 번에 떨어진 이후"
--Translation missing 
L["Sira's Extra Cloak"] = "Sira's Extra Cloak"
--Translation missing 
L["Skrillix"] = "Skrillix"
--Translation missing 
L["Skull of a Frozen Whelp"] = "Skull of a Frozen Whelp"
--Translation missing 
L["Skunky Alemental"] = "Skunky Alemental"
--Translation missing 
L["Sky-Bo"] = "Sky-Bo"
--Translation missing 
L["Skyshard"] = "Skyshard"
--Translation missing 
L["Slithershock Elver"] = "Slithershock Elver"
L["Small Obsidian Chunk"] = "작은 흑요암 광맥"
L["Small Thorium Vein"] = "작은 토륨 광맥"
--Translation missing 
L["Smashum Grabb"] = "Smashum Grabb"
--Translation missing 
L["Smelly Gravestone"] = "Smelly Gravestone"
--Translation missing 
L["Smoky Direwolf"] = "Smoky Direwolf"
--Translation missing 
L["Smoldering Egg of Millagazor"] = "Smoldering Egg of Millagazor"
--Translation missing 
L["Snarly's Bucket"] = "Snarly's Bucket"
--Translation missing 
L["Snow Mound"] = "Snow Mound"
--Translation missing 
L["Snowman Kit"] = "Snowman Kit"
--Translation missing 
L["Snowy Panda"] = "Snowy Panda"
--Translation missing 
L["Solar Spirehawk"] = "Solar Spirehawk"
--Translation missing 
L["Son of Animus"] = "Son of Animus"
--Translation missing 
L["Son of Galleon's Saddle"] = "Son of Galleon's Saddle"
L["Sorting by category, then name"] = "범주별 이름 순으로 정렬"
L["Sorting by difficulty"] = "어려운 순으로 정렬"
L["Sorting by name"] = "이름 순으로 정렬"
L["Sorting by percent complete"] = "완료 확률 순으로 정렬"
--Translation missing 
L["Sorting by zone"] = "Sorting by zone"
L["Sparse Firefin Snapper School"] = "드문드문한 불지느러미퉁돔 떼"
L["Sparse Oily Blackmouth School"] = "드문드문한 기름기 많은 아귀 떼"
L["Sparse Schooner Wreckage"] = "드문드문한 범선 잔해"
--Translation missing 
L["Spawn of Horridon"] = "Spawn of Horridon"
L["Special case"] = "특별한 경우"
--Translation missing 
L["Spectral Bell"] = "Spectral Bell"
L["Spell ID"] = "주문 ID"
--Translation missing 
L["Spiky Collar"] = "Spiky Collar"
--Translation missing 
L["Spineclaw Crab"] = "Spineclaw Crab"
L["Spinefish School"] = "가시고기 떼"
L["Sporefish School"] = "포자물고기 떼"
--Translation missing 
L["Sprite Darter Egg"] = "Sprite Darter Egg"
L["Statistics"] = "통계"
L["Steam Pump Flotsam"] = "증기 양수기 부품"
--Translation missing 
L["Sting Ray Pup"] = "Sting Ray Pup"
L["Stonescale Eel Swarm"] = "돌비늘뱀장어 떼"
--Translation missing 
L["Stormforged Rune"] = "Stormforged Rune"
--Translation missing 
L["Strand Crawler"] = "Strand Crawler"
L["Strange Pool"] = true
--Translation missing 
L["Sultry Grimoire"] = "Sultry Grimoire"
--Translation missing 
L["Sun Sproutling"] = "Sun Sproutling"
--Translation missing 
L["Sunblade Rune of Activation"] = "Sunblade Rune of Activation"
--Translation missing 
L["Sunfire Kaliri"] = "Sunfire Kaliri"
--Translation missing 
L["Sunfur Panda"] = "Sunfur Panda"
--Translation missing 
L["Swarm of Panicked Paddlefish"] = "Swarm of Panicked Paddlefish"
--Translation missing 
L["Swift Brewfest Ram"] = "Swift Brewfest Ram"
--Translation missing 
L["Swift White Hawkstrider"] = "Swift White Hawkstrider"
--Translation missing 
L["Swift Zulian Panther"] = "Swift Zulian Panther"
--Translation missing 
L["Syd the Squid"] = "Syd the Squid"
--Translation missing 
L["Tainted Core"] = "Tainted Core"
--Translation missing 
L["Tainted Maulclaw"] = "Tainted Maulclaw"
L["Take screenshots"] = "스크린샷 찍기"
--Translation missing 
L["Tangled Mantis Shrimp Cluster"] = "Tangled Mantis Shrimp Cluster"
L["Teeming Firefin Snapper School"] = "우글거리는 불지느러미퉁돔 떼"
L["Teeming Floating Wreckage"] = "우글거리는 표류하는 잔해"
L["Teeming Oily Blackmouth School"] = "우글거리는 기름기 많은 아귀 떼"
--Translation missing 
L["Terrorfist"] = "Terrorfist"
L["Texture"] = "질감"
--Translation missing 
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = "The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."
L["The Burning Crusade"] = "불타는 성전"
--Translation missing 
L["The following %d item(s) have been selected to export:"] = "The following %d item(s) have been selected to export:"
L["The Heartbreaker"] = "실연제조기"
L["The Horseman's Reins"] = "저주받은 기사의 고삐"
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = "수집하길 원하는 아이템 ID입니다. Rarity는 당신의 진행으로 당신의 가방에 있는 이 아이템의 번호를 사용합니다. 아이템 ID를 조회하려면 WowHead 또는 이와 유사한 서비스를 이용하십시오. 이것은 유효한 숫자이어야 하며, 다른 아이템에서 사용할 수 없습니다."
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = "아이템 ID를 추적합니다. 이것은 당신의 인벤토리나 전리품 창에 표시되는 아이템입니다. 아이템 ID를 조회하려면 Wowhead 또는 이와 유사한 서비스를 이용하십시오. 이것은 유효한 숫자이어야 하며, 고유한 것이어야 합니다."
L["The name you entered is already being used by another item. Please enter a unique name."] = "당신이 입력한 이름은 이미 다른 아이템에서 사용하고 있습니다. 고유한 이름을 입력해 주세요."
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = "이 애완동물을 소환해서 생겨난 생물의 NPC ID입니다. 이것은 계정 전체의 애완동물 대전을 추적하는데 사용됩니다."
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = "그 아이템을 얻기 위해 데리고 갈 플레이어의 숫자입니다. 이것은 이 아이템을 획득할 확률을 낮춥니다."
--Translation missing 
L["The Pigskin"] = "The Pigskin"
--Translation missing 
L["The quest starter item for Reins of the Llothien Prowler"] = "The quest starter item for Reins of the Llothien Prowler"
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = "꺼져있는 Rarity 설정 모듈입니다. 접속 종료하고 애드온 메뉴에서 그것을 사용합니다."
--Translation missing 
L["The selected Rarity Item Pack string is invalid."] = "The selected Rarity Item Pack string is invalid."
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = "일단 한 번이라도 배운 아이템의 주문 ID입니다. 이것은 오직 탈것과 동료에만 적용되고, 아이템을 배운 후 마법책에 표시되는 주문입니다. 주문 ID를 조회하려면 Wowhead 또는 이와 유사한 서비스를 이용하십시오. 이것은 유효한 숫자이어야 하며, 고유한 것이어야 합니다."
L["The Warbringer will be riding the mount color he has a chance to drop."] = "전쟁인도자가 타고 있는 색상의 탈것을 떨어뜨릴 확률 높습니다."
L["There are more holiday items available, but Rarity only reminds you about the first two."] = "이것은 더 많은 축제 아이템에 사용할 수 있지만, Rarity는 처음에 두 번만 상기시켜줍니다."
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = "이것은 주요 Rarity 툴팁에 나타내는 아이템의 전환을 제어합니다. 아이템은 그것이 도입된 확장팩으로 분류됩니다(축제 아이템은 별도의 범주를 가짐). 이 체크박스를 해제하면 범주 내의 모든 아이템에 대한 추적을 해제하지는 않습니다; 다만 단순히 아이템의 수를 줄이기 위해 툴팁에서 아이템을 숨깁니다."
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = "이 가방은 다크문 섬에서 크리스토프 본피젤에게 애완동물 대전 일퀘를 완료하고 받는 보상입니다."
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = "이 가방은 다크문 섬에서 제레미 피셀에게 애완동물 대전 일퀘를 완료하고 받는 보상입니다."
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = "이 가방은 주둔지 침략에서 금메달 또는 백금메달의 승리할 때 받는 보상입니다."
L["This causes Rarity to put a blank line above its tooltip additions."] = "Rarity의 툴팁이 추가되면 그 위에 빈 줄을 넣습니다."
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = "이 아이템은 1/4 확률로 골가나르에서 떨어지며, 영원의 섬에 산란하는 희귀입니다. 1/250 확률로 영원의 섬에 침식된 절벽거인이 떨어뜨립니다."
L["This item is only available to Alliance players."] = "이 아이템은 얼라이언스 플레이어만 사용할 수 있습니다."
L["This item is only available to Horde players."] = "이 아이템은 호드 플레이어만 사용할 수 있습니다."
L["This mount is only obtainable by Alliance players"] = "이 탈것은 얼라이언스 플레이어만 획득할 수 있습니다."
L["This mount is only obtainable by Horde players"] = "이 탈것은 호드 플레이어만 획득할 수 있습니다."
--Translation missing 
L["This tab lets you import and export items into and out of your Custom tab."] = "This tab lets you import and export items into and out of your Custom tab."
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = "현재 교전 상대를 처치하면 플레이어에게 떨어지도록 허용됩니다."
L["Tiger Gourami School"] = "호랑이 구라미 떼"
--Translation missing 
L["Tiger Gourami Slush"] = "Tiger Gourami Slush"
L["Time"] = "시간"
L["Time spent farming"] = "파밍에 쓴 시간"
L["Timeless Chest"] = "영원의 상자"
L["Time-Locked Box"] = "시간으로 잠긴 상자"
L["Time-Lost Figurine"] = "잃어버린 시간의 조각상"
L["Timewalker 5-player instance"] = "시간여행 5인 던전"
L["Tin Vein"] = "주석 광맥"
L["Tiny Crimson Whelpling"] = "진홍빛 새끼용"
L["Tiny Emerald Whelpling"] = "작은 에메랄드 새끼용"
L["Tiny Fel Engine Key"] = "작은 지옥기계 열쇠"
L["Titanium Vein"] = "티타늄 광맥"
L[ [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=] ] = [=[새 아이템을 만들려면, 아이템에 대한 고유한 이름을 입력하고 확인을 누릅니다. 서버가 아이템 링크를 반환하지 않거나 아이템이 인식 불가인 경우, 이름이 사용됩니다.

여러분은 아이템을 생성한 후에는 이 이름을 변경할 수 없습니다, 신중하게 입력하십시오.]=]
--Translation missing 
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = "To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."
--Translation missing 
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = "To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."
L["Today"] = "오늘"
L["Toggles"] = "전환"
L["Tol'vir"] = "톨비르"
--Translation missing 
L["Tooltip can't be shown in combat"] = "Tooltip can't be shown in combat"
L["Toothy's Bucket"] = "덥석이의 물동이"
--Translation missing 
L["Torn Invitation"] = "Torn Invitation"
L["Total"] = "합계"
L["Total found"] = "총 발견"
L["Toxic Wasteling"] = "맹독 말랑이"
L["Toy or Item"] = "장난감 또는 아이템"
L["Toys & Items"] = "장난감 & 아이템"
L["Track this"] = "이것을 추적"
L["Trillium Vein"] = "트릴리움 광맥"
L["Troll"] = "트롤"
L["True Iron Deposit"] = "순철 광맥"
L["Truesilver Deposit"] = "진은 광맥"
L["Tundra Icehoof"] = "동토 얼음발굽"
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = "아이템을 얻기 위해 파티를 필요로하는 경우에 이것은 켜져 있지만, 모든 플레이어가 동일한 아이템 획득 확률을 얻습니다. 이것은 현재 축제 탈것의 일부에 경우에만 적용됩니다. 이것을 켜면, Rarity는 파티 크기에 따라 얻을 수 있는 확률을 낮추는 것을 중지합니다."
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = "Rarity를 위해 미니맵 아이콘을 켭니다. LDB 표시 애드온이 없을 경우, 이 설정을 사용합니다."
L["Type of item"] = "아이템의 종류"
--Translation missing 
L["Unable to retrieve item information from the server"] = "Unable to retrieve item information from the server"
L["Unavailable"] = "획득 불가"
L["Undefeated"] = "미 처치"
L["Unknown"] = "모름"
L["Unlucky"] = "불길"
L["unlucky"] = "불길"
L["Unscathed Egg"] = "온전한 알"
--Translation missing 
L["Unstable Powder Box"] = "Unstable Powder Box"
L["Unusual Compass"] = "진귀한 나침반"
L["Use your bonus roll for a chance at this item"] = "이 아이템에 기회를 위해 추가 주사위 사용"
L["Usually requires a group of around %d players"] = "보통 주위에 있는 %d명의 플레이어로 된 파티가 필요"
--Translation missing 
L["Valarjar Stormwing"] = "Valarjar Stormwing"
L["Vengeance"] = "복수"
L["Verbose"] = "자세히"
L["Vibrating Arcane Crystal"] = "떨리는 신비한 수정"
L["Vile Blood of Draenor"] = "드레노어의 더럽혀진 피"
L["Viscidus Globule"] = "비시두스의 수액방울"
L["Void Collar"] = "혼돈의 목줄"
L["Vrykul"] = "브리쿨"
--Translation missing 
L["Warlock"] = "Warlock"
L["Warlords of Draenor"] = "드레노어의 전쟁군주"
L["Warm Arcane Crystal"] = "따뜻한 신비한 수정"
L["Warning Sign"] = "경고 표지"
--Translation missing 
L["Warrior"] = "Warrior"
L["Warsong Direfang"] = "전쟁노래 광포송곳니 늑대"
L["Waterlogged Wreckage"] = true
L["Waterlogged Wreckage Pool"] = "물에 젖은 잔해"
L["Weebomination"] = "꼬마 누더기골렘"
L["Welcome to Rarity r%d. Your settings have been reset."] = "Rarity r%d에 오신 것을 환영합니다. 귀하의 설정이 초기화되었습니다."
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = "어떤 행운의 동전이 이 아이템에 대한 시도를 90초 내에 사용되면, 한 번 시도한 것으로 이 아이템에 대해 계산됩니다. 동전 주사위로 정당하게 획득한 아이템에 대해 이것을 허용했을 경우에만."
L["When enabled, Rarity tooltips will include how many attempts you've made."] = "허용되면, Rarity 툴팁에 얼마나 많은 횟수를 시도했는지 포함합니다."
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = "허용되면, Rarity는 파티 찾기의 검색 창에 자동 확인란을 추가합니다. 5초 마다 검색을 자동 새로고침을 활성화하려면, 이 확인락을 선택할 수 있습니다."
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = "허용되면, Rarity는 가능하면 게임 툴팁에 얻을 수 있는 아이템을 추가합니다."
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = "허용되면, Rarity는 파티 찾기에서 자동 새로고침의 검색 결과 하나 이상의 파티를 발견했을 때 소리를 재생합니다. 이 소리는 분 당 한 번 이상 재생할 수 없습니다."
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = "허용되면, Rarity는 어떤 일이 일어날 때 대화창에 디버그 프로필 메시지를 인쇄할 수 있습니다. 이것은 코드의 느린 부분을 알아내는데 사용됩니다."
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = "허용되면, 훔치기로만 획득할 수 있는 아이템입니다. 아이템에 비-도적은 불가능이라고 표시됩니다."
L["When on, items marked as Defeated will be hidden from the tooltip."] = "켜면, 처치로 확인된 아이템은 툴팁에서 숨깁니다."
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = "켜면, 얻을 수 없게 표시된 아이템은 툴팁에서 숨깁니다. 축제가 활성화되지 않은 경우, 이 방법으로 특정 축제가 필요로하는 아이템을 자동으로 숨깁니다."
--Translation missing 
L["When on, items that have no attempts yet will be hidden from the tooltip."] = "When on, items that have no attempts yet will be hidden from the tooltip."
--Translation missing 
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = "When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."
L[ [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=] ] = "켜면, Rarity는 축제 때 활성화되고 아이템이 미 처치로 설정되었을 경우, 당신이 놓친 농장 축제 아이템을 갈 생각이 나게합니다. (이것은 단지 축제 던전 또는 일일 퀘스트에서 발생한 아이템에 대해서 작동합니다.) 알림은 로그인하거나 UI를 재시작 할 때마다 발생하고, 축제 던전 또는 \\009퀘스트를 완료하면 하루 동안 중지됩니다."
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = "켜면, Rarity는 툴팁에 아이템이 속한 확장팩을 각 아이템의 옆에 아이콘으로 표시합니다."
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = "켜면, 아이템을 얻고 업적 알림 팝업이 나타날 때, Rarity가 스크린샷을 찍습니다."
L["When on, the Luckiness column will be shown in the main tooltip."] = "켜면, 기본 툴팁에 행운 열이 표시됩니다."
--Translation missing 
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = "When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."
L["When on, the Time column will be shown in the main tooltip."] = "켜면, 기본 툴팁에 시간 열이 표시됩니다."
L["When on, the Zone column will be shown in the main tooltip."] = "켜면, 기본 툴팁에 지역 열이 표시됩니다."
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = "켜면, 이 설정은 49분에 1 또는 그 이상으로 떨어뜨릴 확률이 있는 모든 아이템을 숨깁니다. 아이템은 단지 깨끗하게 유지하기 위해 툴팁에서 숨겨집니다. 이 방식으로 숨겨진 아이템은 여전히 평소처럼 추적됩니다."
--Translation missing 
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = "When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."
L["Whistle of Chromatic Bone"] = "오색 뼈 호루라기"
L["White Trillium Deposit"] = "하얀 트릴리움 광맥"
L["Width"] = "너비"
--Translation missing 
L["Wild Dreamrunner"] = "Wild Dreamrunner"
L["Wild Goretusk"] = "야생 핏빛엄니"
--Translation missing 
L["will be imported"] = "will be imported"
L["Will only drop for druids."] = "드루이드에게서만 떨어짐"
--Translation missing 
L["Wisp in a Bottle"] = "Wisp in a Bottle"
L["World Tooltip Options"] = "세계 툴팁 설정"
L["Worn Troll Dice"] = "낡은 트롤 주사위"
L["Wrath of the Lich King"] = "리치 왕의 분노"
--Translation missing 
L["Wriggling Darkness"] = "Wriggling Darkness"
L["Yesterday"] = "어제"
L["You already defeated %d of them."] = "그것들의 %d|1은;는; 이미 처치했습니다."
L["You already defeated all of them."] = "그것들은 모두 이미 처치했습니다."
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = "완전히 축제 알림을 끄거나 Rarity 설정 화면을 방문해 아이템 별로 켤 수 있습니다."
L["You entered a achievement ID that is already being used by another item."] = "이미 다른 아이템에서 사용중인 업적 ID를 입력했습니다."
L["You entered a creature ID that is already being used by another item."] = "이미 다른 아이템에서 사용중인 생물 ID를 입력했습니다."
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = "제한된 이름을 입력했습니다. 이 게임에서 나타나는 올바른 아이템 이름을 입력하십시오."
L["You entered a spell ID that is already being used by another item."] = "이미 다른 아이템에서 사용중인 주문 ID를 입력했습니다."
L["You entered an item ID that is already being used by another item."] = "이미 다른 아이템에서 사용중인 아이템 ID를 입력했습니다."
L["You entered an item ID that is already set as the collected item for something else."] = "다른 무언가로 수집된 아이템으로 이미 설정된 아이템 ID를 입력했습니다."
L["You must enter a creature ID."] = "생물 ID를 입력해야 합니다."
L["You must enter a number larger than 0."] = "0보다 큰 수를 입력해야 합니다."
L["You must enter a number larger than 1."] = "1보다 큰 수를 입력해야 합니다."
L["You must enter a number larger than or equal to 0."] = "0과 같거나 보다 큰 수를 입력해야 합니다."
L["You must enter a spell ID."] = "주문 ID를 입력해야 합니다."
L["You must enter a valid number."] = "유효한 숫자를 입력해야 합니다."
L["You must enter an amount."] = "수치를 입력해야 합니다."
L["You must enter an item ID."] = "아이템 ID를 입력해야 합니다."
L["You must enter at least one item ID."] = "적어도 하나의 아이템 ID를 입력해야 합니다."
L["You must enter at least one NPC ID."] = "적어도 하나의 MPC ID를 입력해야 합니다."
L["You must enter at least one Statistic ID."] = "적어도 하나의 통계 ID를 입력해야 합니다."
L["You must enter at least one zone."] = "적어도 하나의 지역을 입력해야 합니다."
--Translation missing 
L["Young Talbuk"] = "Young Talbuk"
--Translation missing 
L["Young Venomfang"] = "Young Venomfang"
--Translation missing 
L["Zandalari Anklerender"] = "Zandalari Anklerender"
--Translation missing 
L["Zandalari Footslasher"] = "Zandalari Footslasher"
--Translation missing 
L["Zandalari Kneebiter"] = "Zandalari Kneebiter"
--Translation missing 
L["Zandalari Toenibbler"] = "Zandalari Toenibbler"
--Translation missing 
L["Zangar Spore"] = "Zangar Spore"
--Translation missing 
L["Zhevra Lounge Cushion"] = "Zhevra Lounge Cushion"
--Translation missing 
L["Zomstrok"] = "Zomstrok"
L["Zone"] = "지역"
L["Zones"] = "지역"

end

L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "ruRU")
if L then
L[" (Group)"] = "(Группа)"
L["#%d: %d attempt (%.2f%%)"] = "#%d: %d попытка (%.2f%%)"
L["#%d: %d attempts (%.2f%%)"] = "#%d: %d попытки (%.2f%%)"
--Translation missing 
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = "%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"
L["%d |4zone:zones;"] = "%d |4зона:зоны:зон;"
L["%d attempt"] = "%d попытка"
L["%d attempt - %.2f%%"] = "%d попытка - %.2f%%"
L["%d attempts"] = "%d попытки"
L["%d attempts - %.2f%%"] = "%d попыток - %.2f%%"
L["%d collected - %.2f%%"] = "%d собрано - %.2f%%"
L["%s: %d attempt"] = "%s: %d попытка"
L["%s: %d attempt - %.2f%%"] = "%s: %d попытка - %.2f%%"
L["%s: %d attempt (%d total)"] = "%s: %d попытка (%d всего)"
L["%s: %d attempts"] = "%s: %d попыток"
L["%s: %d attempts - %.2f%%"] = "%s: %d попытки - %.2f%%"
L["%s: %d attempts (%d total)"] = "%s: %d попыток (%d всего)"
L["%s: %d collected"] = "%s: %d собрано"
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = "%s: 0/%d попытка на данный момент (%.2f%% - %s)"
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = "%s: 0/%d попыток на данный момент (%.2f%% - %s)"
--Translation missing 
L["%s: collection completed!"] = "%s: collection completed!"
L["%s: Found after %d attempts!"] = "%s: Найден с %d попытки!"
L["%s: Found on the first attempt!"] = "%s: Найден с первой попытки!"
L["(%d/%d attempts)"] = "(%d/%d попыток)"
L["(%d/%d collected)"] = "(собрано %d/%d)"
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = "(Предметы помеченные красный цветом не могут быть найдены на сервере и могут не существовать. Рассматривается возможность удаления.)"
L["(running in debug mode)"] = "(в режиме отладки)"
--Translation missing 
L["(Warning: item could not be retrieved from server)"] = "(Warning: item could not be retrieved from server)"
L["1 in %d chance"] = "Шанс 1 из %d"
L["10-player Heroic Raid instance (legacy content; not flexible)"] = "Героич. рейд (10 игроков) (устаревший контент; не гибкий)"
L["10-player Raid instance (legacy content; not flexible)"] = "Рейд (10 игроков) (устаревший контент; не гибкий)"
L["25-player Event scenario"] = "25-игроков Событие-сценарий"
L["25-player heroic"] = "25 игроков (героический)"
L["25-player Heroic Raid instance (legacy content; not flexible)"] = "Героич. рейд (25 игроков) (устаревший контент; не гибкий)"
L["25-player Raid instance (legacy content; not flexible)"] = "Рейд (25 игроков) (устаревший контент; не гибкий)"
L["40-player Event raid"] = "Событие-рейд 40-игроков"
L["40-player Raid instance (legacy content; not flexible)"] = "Рейд (40 игроков) (устаревший контент; не гибкий)"
L["5-player Event instance"] = "Событие-подземелье 5 игроков "
L["5-player Heroic instance"] = "Героич. подземелье (5 игроков)"
L["5-player instance"] = "Подземелье (5 игроков)"
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = "Список (разделяется запятыми) ID предметов из которых при открытии или использовании добывается данный предмет. Используйте WowHead или подобные сайты для поиска ID предметов."
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = "Список (разделяется запятыми) ID персонажей из которых добывается данный предмет. Используйте WowHead или подобные сайты для поиска ID персонажей."
--Translation missing 
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = "A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = "Список Statistic ID, разделенных запятой, который отслеживает количество убийств в процессе получения данного предмета."
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = "Список Statistic ID, разделенных запятой, который отслеживает количество убийств в процессе получения данного предмета. Эти ID будут добавлены все вместе. Используйте Wowhead или похожие сайты для поиска Statistic ID."
L[ [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=] ] = [=[Список областей или подзон, разделенный запятыми, где может быть найден данный предмет. Для областей вы можете ввести или ID карты (например, 811 - Вечноцветущий дол), или полное имя области. Для подзон вы должны ввести полное наименование подзоны.

Вводите названия областей в соответствии с языком, регистром и пунктуацией. Они могут быть введены или на английском или на языке клиента. Используйте WowHead или подобное для проверки веденных названий областей.

Обратите внимание: Перевод областей может быть некорректным. Для областей рекомендуется использовать ID карты вместо названия. Для подзон нужно ввести название. Если определение подзоны не работает, посетите страницу LibBabble-SubZone-3.0 на wowace.com и обновите перевод для вашего языка.]=]
--Translation missing 
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = "A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."
L["A holiday event is available today for %s! Go get it!"] = "Праздничное событие началось сегодня! Можно получить %s!"
L["Abundant Bloodsail Wreckage"] = "Крупные обломки кораблекрушения шайки Кровавого Паруса"
L["Abundant Firefin Snapper School"] = "Крупный косяк огнеперого луциана"
L["Abundant Oily Blackmouth School"] = "Крупный косяк масляного черноротика"
--Translation missing 
L["Abyss Worm"] = "Abyss Worm"
L["Abyssal Gulper School"] = "Косяк глубинного угря-мешкорота"
L["Adamantite Deposit"] = "Залежи адамантита"
L["Added %d |4waypoint:waypoints; to TomTom"] = "Добавлено %d |4направление:направления:направлений; в TomTom"
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = "Настраивает масштаб основной подсказки. Возымеет действие при следующем показе."
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = "После улучшения рыбацкой хижины в гарнизоне до 3 уровня, поймай 5 рыбешек, чтобы призвать Обитателя пещер, с которого может упасть этот маунт."
--Translation missing 
L["Ageless Bronze Drake"] = "Ageless Bronze Drake"
--Translation missing 
L["Ahune"] = "Ahune"
L["Ai-Li's Skymirror"] = "Небесное зеркало Ай-Ли"
--Translation missing 
L["Ai-Ran the Shifting Cloud"] = "Ai-Ran the Shifting Cloud"
--Translation missing 
L["Albino Buzzard"] = "Albino Buzzard"
L["Albino Cavefish School"] = "Косяк слепоглазок-альбиносов"
L["Albino Chimaeraling"] = "Химерка-альбинос"
L["Algaefin Rockfish School"] = "Косяк водорослевых скорпен"
L["All players can participate in killing this world boss once per week, regardless of faction"] = "Все игроки могут принять участие в убийстве этого босса раз в неделю, вне зависимости от фракции"
L["All raid formats except Raid Finder"] = "Любой формат, кроме поиска рейда"
L["Alliance only"] = "Альянс"
L["Already defeated"] = "Уже побеждено"
L["Already defeated for %s"] = "Уже побеждено для %s"
L["Already known"] = "Уже есть"
--Translation missing 
L["an item already exists by this name, so it will not be imported"] = "an item already exists by this name, so it will not be imported"
--Translation missing 
L["an item with the same Item ID already exists, so it will not be imported"] = "an item with the same Item ID already exists, so it will not be imported"
L["Ancient Mana"] = "Древняя мана"
L["and %d |4other zone:other zones;"] = "и %d |4другая зона:другие зоны:других зон;"
L["Announce"] = "Оповещать"
L["Announcements"] = "Оповещения"
--Translation missing 
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = "Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."
L["Anubisath Idol"] = "Фигурка анубисата"
L["Any difficulty"] = "Любая сложность"
L["Any raid size"] = "Любой размер рейдовой группы"
L["Any raid size or difficulty"] = "Любой размер и сложность рейда"
L["Appears in the Black Market"] = "Доступно на Черном Рынке"
--Translation missing 
L["Aqua Jewel"] = "Aqua Jewel"
L["Arakkoa"] = "Араккоа"
--Translation missing 
L["Arcano-Shower"] = "Arcano-Shower"
L["Archaeology race"] = "Раса в археологии"
L["Are you sure you want to delete this item?"] = "Вы уверены, что хотите удалить этот предмет?"
--Translation missing 
L["Are you sure you want to import the Rarity Item Pack you entered?"] = "Are you sure you want to import the Rarity Item Pack you entered?"
--Translation missing 
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = "Are you sure you want to turn off the Export toggle for all your Custom items?"
L["Armored Razorback"] = "Бронированный шипастый кабан"
L["Armored Razzashi Raptor"] = "Бронированный ящер Раззаши"
--Translation missing 
L["Ash-Covered Horn"] = "Ash-Covered Horn"
L["Ashes of Al'ar"] = "Пепел Алара"
L["Ashleaf Spriteling"] = "Малый дух ясеневого листа"
L["Attempts"] = "Попыток"
L["Auto"] = "Авто"
L["Available starting December 25th"] = "Доступно с 25 декабря"
L["Azure Crane Chick"] = "Птенец лазурного журавля"
L["Azure Whelpling"] = "Лазурный дракончик"
--Translation missing 
L["Battle Horn"] = "Battle Horn"
L["Battle Pet"] = "Боевой питомец"
L["Battle Pets"] = "Боевые питомцы"
L["Big Love Rocket"] = "Большая ракета любви"
L["Black Barracuda School"] = "Косяк черной барракуды"
L["Black Trillium Deposit"] = "Залежи чёрной триллиевой руды"
L["Blackbelly Mudfish School"] = "Косяк илистого чернобрюха"
L["Blackflame Daggers"] = "Кинжалы Черного Пламени"
L["Blackfuse Bombling"] = "Бомблинг Черноплавса"
--Translation missing 
L["Blackhoof"] = "Blackhoof"
L["Blackrock Deposit"] = "Залежи руды Черной горы"
L["Blackwater Whiptail School"] = "Косяк хлыстохвоста Черноводья"
L["Blackwing Banner"] = "Знамя Крыла Тьмы"
L["Blank line before tooltip additions"] = "Пустая строка перед данными в подсказках"
L["Blazing Rune"] = "Пылающая руна"
L["Bleakclaw"] = "Хмурокоготь"
--Translation missing 
L["Blessed Seed"] = "Blessed Seed"
--Translation missing 
L["Blight Boar Microphone"] = "Blight Boar Microphone"
L["Blighted Spore"] = "Спора порчи"
L["Blind Lake Sturgeon School"] = "Косяк слепого озерного осетра"
L["Bloodsail Wreckage"] = "Обломки кораблекрушения шайки Кровавого Паруса"
L["Bloodsail Wreckage Pool"] = "Обломки кораблекрушения Кровавого Паруса"
L["Bluefish School"] = "Косяк луфаря"
L["Bone Serpent"] = "Костяной змей"
L["Bonkers"] = "Сумасброд"
L["Borean Man O' War School"] = "Косяк борейского медузника"
--Translation missing 
L["Boss Name"] = "Boss Name"
--Translation missing 
L["Bottled Tornado"] = "Bottled Tornado"
L["Brackish Mixed School"] = "Косяк сквернохвоста"
L["Brew Frenzied Emperor Salmon"] = "Разъяренный хмелем императорский лосось"
L["Brilliant Phoenix Hawk Feather"] = "Сияющее перо ястрофеникса"
--Translation missing 
L["Brinedeep Bottom-Feeder"] = "Brinedeep Bottom-Feeder"
L["Bristling Hellboar"] = "Щетинистый зловепрь"
--Translation missing 
L["Bronze Proto-Whelp"] = "Bronze Proto-Whelp"
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = "Запущен \"Bunny Hunter\". Вы хотите перенести данные из \"Bunny Hunter\" в \"Rarity\"? Отключите \"Bunny Hunter\" или нажмите Да, если не хотите увидеть данный запрос снова."
--Translation missing 
L["Burgy Blackheart's Handsome Hat"] = "Burgy Blackheart's Handsome Hat"
--Translation missing 
L["Call of the Frozen Blade"] = "Call of the Frozen Blade"
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = "Может содержаться в Коробочке в виде сердца, получаемой за победу над фест. боссом во время Любовной лихорадки."
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = "Может содержаться в Сундуке сокровищ в форме бочонка, получаемом за победу над фест. боссом во время Хмельного фестиваля."
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = "Может содержаться в Заполненной добычей тыкве, получаемой за победу над фест. боссом во время Тыквовина."
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = "Может быть получено из Громыхающей железной клетки, имеющей шанс выпасть с любого из 4 защитников Цитадели Адского Пламени в Танаанских джунглях (Кулак Страха, Коготь Смерти, Отмщение или Пушка Смерти). Добычу можно получить раз в день. Rarity будет считать \"побежденным\" в день, когда убит хотя бы один из них."
L["Can be obtained with a bonus roll"] = "Может быть получено бонусным броском"
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = "Может выпасть из Оскверненных товаров для питомцев, получаемых за победы над пораженными Скверной легендарными питомцами в Танаанских Джунглях."
L["Captured Firefly"] = "Пойманный светляк"
L["Cat Carrier (Black Tabby)"] = "Кошачья клетка (серая полосатая кошка)"
L["Cataclysm"] = true
--Translation missing 
L["Cavern Moccasin"] = "Cavern Moccasin"
--Translation missing 
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = "Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"
--Translation missing 
L["Chain Pet Leash"] = "Chain Pet Leash"
L["Chalice of Secrets"] = "Таинственная чаша"
L["Challenge Mode instance"] = "Подземелье в режиме испытаний"
L["Chance"] = "Шанс"
L["Chance so far"] = "Шанс на данный момент"
L["Chaos Pup"] = "Волчонок Хаоса"
--Translation missing 
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = "Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."
L[ [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=] ] = [=[Отметить для автоматического обновления поиска каждые 5 секунд, пока окно открыто. Автообновление работает только если напечатан поисковый запрос, и не выбрана группа в списке.

Этот флажок создан Rarity. Его можно скрыть в настройках.]=]
--Translation missing 
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = "Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."
--Translation missing 
L["Christoph VonFeasel"] = "Christoph VonFeasel"
--Translation missing 
L["Chromie"] = "Chromie"
L["Chuck's Bucket"] = "Ведро Проглота"
L["Classic"] = true
--Translation missing 
L["Clear All Exports"] = "Clear All Exports"
L["Click to switch to this item"] = "Щелкните для переключения на этот предмет"
L["Click to toggle the progress bar"] = "Кликните для переключения панели"
L["Clockwork Rocket Bot"] = "Заводной ракетобот"
L["Close"] = "Закрыть"
--Translation missing 
L["Cloudwing Hippogryph"] = "Cloudwing Hippogryph"
L["Clutch of Ji-Kun"] = "Дитя Цзи-Кунь"
L["Cobalt Deposit"] = "Залежи кобальта"
L["Coin of Many Faces"] = "Многоликая монетка"
L["Collect %d %s"] = "Собрать %d %s"
L["Collected"] = "Собрано"
L["Collection Complete"] = "Окончание сбора"
L["Collection complete!"] = "Сбор окончен!"
L["Collection Size"] = "Кол-во собираемого"
L["Contained in bonus satchels"] = "Содержится в бонусной сумке"
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = "Нужно прокачать репутацию с Оракулами до почтения, купить Таинственное яйцо, которое через 3 дня превратится в Треснутое яйцо, в котором с 5% шансом содержится маунт."
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = "Содержится в Хильдских трофеях, получаемых за ежедневные задания Гретты Судьи в Деревне Бруннхильдар на Грозовой Гряде."
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = "Нужно прокачать репутацию с Племенем Бешеного Сердца до почтения, купить Кувшин гадости, который через 3 дня превратится в Кувшин перебродившей гадости, в котором может содержаться игрушка."
L["Content Category"] = "Категория контента"
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = "Контролирует с какой стороны появляется вторичная подсказка, при наведении мышью на предмет в основной. Если основная подсказка находится Справа, измени эту на Слева, и наоборот. Также можно полностью скрыть."
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = "Указывает вид оповещения. Минимальный показывает только количество попыток, нормальный - дополнительно указывает вероятность и избыточный добавляет ссылку на предмет."
L["Copper Vein"] = "Медная жила"
--Translation missing 
L[ [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=] ] = [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=]
L["Core of Hardened Ash"] = "Окаменевший вулканический пепел"
L["Corrupted Nest Guardian"] = "Оскверненный страж гнезда"
L["Corrupted Thundertail"] = "Оскверненный громохвост"
L["Crane Nest"] = "Журавлиное гнездо"
L["Crashin' Thrashin' Cannon Controller"] = "Пульт управления пушкой \"Бей-Молоти\""
L["Crashin' Thrashin' Flyer Controller"] = "Пульт управления бомбометателем \"Бей-Молоти\""
L["Crashin' Thrashin' Mortar Controller"] = "Пульт управления минометом \"Бей-Молоти\""
L["Crashin' Thrashin' Racer Controller"] = "Пульт управления болидом \"Бей-Молоти\""
L["Crashin' Thrashin' Roller Controller"] = "Пульт управления машинкой \"Бей-Молоти\""
L["Create a New Item"] = "Добавить новый предмет"
L["Create a new item to track"] = "Добавить слежение за новым предметом"
L["Creature ID"] = "ID существа"
L["Crowded Redbelly Mandarin"] = "Стайный краснобрюхий окунь"
--Translation missing 
L["Crysa"] = "Crysa"
L["Crystal of the Void"] = "Кристалл Пустоты"
L["Ctrl-Click to change sort order"] = "Ctrl-Click - изменить порядок сортировки"
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = "Ctrl-клик чтобы создать оставшиеся направления TomTom."
L["Ctrl-Click to create TomTom waypoint(s)."] = "Ctrl-клик чтобы создать направление(я) TomTom."
--Translation missing 
L["Cupri"] = "Cupri"
L["Curious Wyrmtongue Cache"] = "Необычный тайник змееуста"
--Translation missing 
L["Cursed Queenfish School"] = "Cursed Queenfish School"
L["Cursed Spirit"] = "Проклятый дух"
L["Custom"] = "Прочее"
L["Dandelion Frolicker"] = "Одуванчиковая резвунья"
L["Dark Gazer"] = "Темный взорень"
L["Dark Iron Deposit"] = "Залежи черного железа"
L["Dark Quivering Blob"] = "Темная дрожащая капля"
L["Dark Whelpling"] = "Маленький темный дракончик"
L["Darkmoon Eye"] = "Око Новолуния"
L["Data has been imported from Bunny Hunter"] = "Получены данные из Bunny Hunter"
L["Death Adder Hatchling"] = "Детеныш смертолаза"
L["Death Knight"] = "Рыцарь смерти"
L["Deathcharger's Reins"] = "Поводья коня смерти"
L["Deathtalon"] = "Коготь Смерти"
L["Debug mode"] = "Режим отладки"
L["Debug mode OFF"] = "Режим отладки ВЫКЛ"
L["Debug mode ON"] = "Режим отладки ВКЛ"
L["Decahedral Dwarven Dice"] = "Десятигранный игральный кубик дворфов"
L["Deep Sea Monsterbelly School"] = "Косяк глубоководного чертобрюха"
L["Deepsea Sagefish School"] = "Косяк глубоководного шалфокуня"
--Translation missing 
L["Defeat Detection"] = "Defeat Detection"
L["Defeated"] = "Повержен"
L["Defiled Earth"] = "Оскверненная земля"
L["Delete this item"] = "Удалить предмет"
L["Demon Hunter"] = "Охотник на демонов"
--Translation missing 
L["Demonic"] = "Demonic"
L["Determines how this item is obtained."] = "Указывает каким образом добывается предмет."
L["Determines what type of item this is."] = "Указывает тип предмета."
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = "Указывает, что предмет можно обнаружить только в лунках. Для работы данной функции необходимо, чтобы названия всех лунок были правильно переведены на язык клиента."
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = "Указывает будет ли включено отслеживание данного предмета. Отключенные предметы не отображаются в списках."
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = "Указывает хотите ли вы отслеживать находки данного предмета многократно. При включении данной настройки и нахождении предмета, Rarity через несколько секунд пометит его как ненайденный и продолжит подсчет попыток."
L[ [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=] ] = [=[Определяет, на какой сложности подземелья данный предмет может быть получен. Оставьте все отключенным, если сложность не важна.

Если вы указали Статический ID для этого предмета, сложность подземелья скорее всего не важна, т.к. современная статистика уже включает в себя сложность.

Можно выбрать несколько вариантов. ]=]
L["Determines which race includes this archaeology project."] = "Указывает археологическую расу находки."
L["Deviate Hatchling"] = "Загадочный детеныш"
L["Direflame"] = "Яростное пламя"
L["Direhorn Runt"] = "Крохотный дикорог"
--Translation missing 
L["Disable for classes"] = "Disable for classes"
L["Disgusting Oozeling"] = "Омерзительный слизнюченыш"
--Translation missing 
L["Displacer Meditation Stone"] = "Displacer Meditation Stone"
--Translation missing 
L["Distance"] = "Distance"
--Translation missing 
L["Don Carlos' Famous Hat"] = "Don Carlos' Famous Hat"
L["Doomroller"] = "Пушка Смерти"
L["Draenei"] = "Дренеи"
L["Draenor Clans"] = "Кланы Дренора"
L["Draenor Garrison"] = "Дренорский гарнизон"
L["Dragonfin Angelfish School"] = "Косяк дракоперой рыбы-ангела"
L["Drakum"] = "Дракум"
L["Dreadwalker"] = "Страхоступ"
L["Dripping Strider Egg"] = "Мокрое яйцо долгонога"
L["Droplet of Y'Shaarj"] = "Капля И'Шараджа"
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = "Выпадает с любых мобов в Вечноцветущем доле (кроме мелких). 10 штук можно объединить и пробить щит Алани, позволяя вступить с ним в бой, и гарантированно получить Поводья грозового рубинового облачного змея."
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = "Выпадает с динозавров на Острове Гигантов. Через 3 дня превратится в одного из трех Древних ящеров."
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = "Выпадает с Потревоженного стручлинга, который с некоторым шансом появляется при сборе трав на Дреноре."
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = "Выпадает с Элегона в Подземельях Могу'шан (любой размер рейдовой группы)"
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = "Выпадает с Горена-защитника, который с некоторым шансом появляется при сборе руды на Дреноре."
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = "Выпадает с Коралона Стража Огня, Эмалона Стража Бури, Аркавона Стража Камня и  Торавона Стража Льда в Склепе Аркавона (любой размер рейда)"
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = "Выпадает с Малигоса в Оке Вечности (любой размер рейдовой группы)"
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = "Выпадает с Ониксии в Логове Ониксии (любой размер рейдовой группы)"
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = "Выпадает с Безумия Смертокрыла в Душе Дракона (любой размер и сложность)"
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = "Выпадает с Безумия Смертокрыла в Душе Дракона (любой размер (героич.))"
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = "Выпадает с Ультраксиона в Душе Дракона (любой размер и сложность рейда)"
L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = "Выпадает с Йогг-Сарона в Ульдуаре (25 игроков) убитого без помощи хранителей"
L["Dropped from dinosaurs on Isle of Giants"] = "Падают с динозавров на Острове гигантов"
L["Dropped from monsters in Fang'rila"] = "Выпадает из мобов в Клыкоморье."
L["Drops from a boss requiring a group"] = "Добывается из группового босса"
L["Drops from any mob in a zone"] = "Добывается из любого моба в зоне"
L["Drops from NPC(s)"] = "Добывается из NPC"
--Translation missing 
L["Drudge Remains"] = "Drudge Remains"
L["Druid"] = "Друид"
L["Dungeon ID"] = "ID подземелья"
L["Dusty Clutch of Eggs"] = "Пыльная кладка яиц"
L["Dwarf"] = "Дворфы"
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = "Обменивается на 9999 Огромных костей динозавра у Ку'мы на Острове Гигантов. Огромные кости динозавра падают со всех динозавров и Зандаларских диномантов на острове."
L["Elementium Geode"] = "Элементиевая жеода"
L["Elementium Vein"] = "Элементиевая жила"
L["Emperor Salmon School"] = "Косяк императорского лосося"
L["Enable announcements"] = "Включить оповещения"
L["Enable Coins"] = "Амулеты"
L["Enable profiling"] = "Включить профилирование"
L["Enable tooltip additions"] = "Добавлять данные в подсказки"
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = "Включить оповещения при каждой попытке найти любой отслеживаемый предмет. Также возможно включить оповещения для каждого предмета отдельно."
L["Enables announcements whenever you complete a new attempt toward this item."] = "Включить оповещения при каждой попытке найти этот предмет."
L["Enter 1 or leave this blank to mark the item as soloable."] = "Введите 1 или оставьте пустым, чтобы пометить, что данный предмет можно получить соло."
L["Equal odds"] = "Равные шансы"
--Translation missing 
L["Error compressing item pack"] = "Error compressing item pack"
--Translation missing 
L["Error encoding item pack"] = "Error encoding item pack"
--Translation missing 
L["Error serializing item pack"] = "Error serializing item pack"
--Translation missing 
L["Essence of the Breeze"] = "Essence of the Breeze"
L["Eternal Kiln"] = "Вечный обжигающий огонь"
--Translation missing 
L["Eternal Warrior's Sigil"] = "Eternal Warrior's Sigil"
--Translation missing 
L["Everliving Spore"] = "Everliving Spore"
L["Every item ID must be a number greater than 0."] = "ID предмета должно быть числом больше 0."
L["Every NPC ID must be a number greater than 0."] = "ID НИПа должно быть числом больше 0."
L["Every Quest ID must be a number greater than 0."] = "ID задания должно быть числом больше 0."
L["Experiment 12-B"] = "Эксперимент 12-Б"
L["Export"] = "Экспорт"
--Translation missing 
L["Export Rarity Item Pack"] = "Export Rarity Item Pack"
--Translation missing 
L["Export this item"] = "Export this item"
--Translation missing 
L["Eye of Inquisition"] = "Eye of Inquisition"
--Translation missing 
L["Faintly Glowing Flagon of Mead"] = "Faintly Glowing Flagon of Mead"
L["Fandral's Seed Pouch"] = "Мешочек семян Фэндрала"
L["Fangtooth Herring School"] = "Косяк сельди-батиприона"
L["Farwater Conch"] = "Глубоководный моллюск"
L["Fat Sleeper School"] = "Косяк толстопузика"
--Translation missing 
L["Fathom Dweller"] = "Fathom Dweller"
L["Fathom Eel Swarm"] = "Стайка сажневого угря"
L["Feed text"] = "Тип сообщений"
L["Fel Iron Deposit"] = "Залежи оскверненного железа"
L["Felfly"] = "Скверномуха"
--Translation missing 
L["Felslate Deposit"] = "Felslate Deposit"
--Translation missing 
L["Felslate Seam"] = "Felslate Seam"
--Translation missing 
L["Felsteel Annihilator"] = "Felsteel Annihilator"
L["Felsworn Sentry"] = "Скверноподданный часовой"
L["Feltail School"] = "Косяк сквернохвоста"
--Translation missing 
L["Fever of Stormrays"] = "Fever of Stormrays"
L["Fiery Warhorse's Reins"] = "Поводья огненного боевого коня"
L["Fire Ammonite School"] = "Косяк огненного аммонита"
L["Firefin Snapper School"] = "Косяк огнеперого луциана"
L["Firewing"] = "Огнекрыл"
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = "Ловится повсюду на Дреноре (кроме гарнизона) с помощью Ната Пэгла"
L["Flametalon of Alysrazor"] = "Пламенное Крыло Алисразор"
L["Floating Debris"] = "Плавающий мусор"
L["Floating Debris Pool"] = "Обломки в воде"
L["Floating Shipwreck Debris"] = "Обломки кораблекрушения"
L["Floating Wreckage"] = "Плавающие обломки"
L["Floating Wreckage Pool"] = "Обломки в воде"
L["Font"] = "Шрифт"
L["Font Size"] = "Размер шрифта"
L["Foot Ball"] = "Футбольный мяч"
L["Fossil"] = "Окаменелости"
L["Fossilized Raptor"] = "Ископаемый ящер"
L["Found after %d attempts!"] = "Обнаружен после %d попыток!"
L["Found in: "] = "Найдено в:"
L["Found on your first attempt!"] = "Обнаружен с первой попытки!"
L["Fox Kit"] = "Лисенок"
L["Fragment of Anger"] = "Фрагмент Злобы"
L["Fragment of Desire"] = "Фрагмент Желания"
--Translation missing 
L["Fragment of Frozen Bone"] = "Fragment of Frozen Bone"
L["Fragment of Suffering"] = "Фрагмент Страдания"
L["Frenzyheart Brew"] = "Варево Бешеного Сердца"
L["Frightened Bush Chicken"] = "Испуганный цыпленок-бройлер"
L["Fuzzy Green Lounge Cushion"] = "Мягкая бархатистая зеленая подушка"
L["Gahz'rooki's Summoning Stone"] = "Камень призыва Газ'руки"
--Translation missing 
L["Gar'lok"] = "Gar'lok"
L["Garn Nighthowl"] = "Гарн Ночной Вой"
L["Garn Steelmaw"] = "Закованный в броню гарн"
L["Garrison Invasion Gold Victory"] = "Нападение на гарнизон - Золотой рейтинг"
L["Garrison Invasion Platinum Victory"] = "Нападение на гарнизон - Платиновый рейтинг"
L["Gastropod Shell"] = "Панцирь Брюхонога"
L["General"] = "Основные"
L["General Options"] = "Основные настройки"
L["Ghost Iron Deposit"] = "Залежи призрачного железа"
L["Giant Coldsnout"] = "Огромный хладнорылый вепрь"
L["Giant Mantis Shrimp Swarm"] = "Стая гигантских раков-богомолов"
L["Giant Sewer Rat"] = "Гигантская сточная крыса"
--Translation missing 
L["Giant Worm Egg"] = "Giant Worm Egg"
--Translation missing 
L["Gibblette the Cowardly"] = "Gibblette the Cowardly"
L["Glacial Salmon School"] = "Косяк ледникового лосося"
L["Glassfin Minnow School"] = "Косяк ледоспинки"
L["Glimmering Jewel Danio Pool"] = "Косяк сверкающего бриллиантового данио"
L["Glimmering Treasure Chest"] = "Сверкающий сундук с сокровищами"
L["Glittering Arcane Crystal"] = "Мерцающий магический кристалл"
--Translation missing 
L["Glittering Ball of Yarn"] = "Glittering Ball of Yarn"
L["Glowing Jade Lungfish"] = "Блестящая нефритовая двоякодышащая рыба"
L["Gluth's Bone"] = "Кость Глута"
L["Gold Vein"] = "Золотая жила"
L["Golden Carp School"] = "Косяк золотистого карпа"
L["Gondar"] = "Гондар"
L["Gooey Sha-ling"] = "Липкий ша-ненок"
--Translation missing 
L["Goren \"Log\" Roller"] = "Goren \"Log\" Roller"
L["Great Brewfest Kodo"] = "Большой кодо Хмельного фестиваля"
L["Greater Sagefish School"] = "Косяк большого шалфокуня"
--Translation missing 
L["Greatfather Winter's Tree"] = "Greatfather Winter's Tree"
L["Green Helper Box"] = "Коробочка с зеленым помощником"
L["Grotesque Statue"] = "Статуя Макабра"
L["Group Finder Options"] = "Настройки поиска группы"
L["Group size"] = "Размер группы"
L["Group(s) found!"] = "Группа(ы) найдена(ы)!"
--Translation missing 
L["Grow Up"] = "Grow Up"
L["Grumpling"] = "Ворчунишка"
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = "Гарантированно выпадает с Дормуса Погонщика верблюдов. Чтобы попасть к нему требуется найти редкую Странную фигурку верблюда в Ульдуме. Их сложно обнаружить, и при клике на них, есть шанс перенестись к Дормусу. Редкость вычисляется тем, сколько фигурок было найдено (при наведениии мыши на них)."
L["Gu'chi Swarmling"] = "Роевик Гу'чи"
--Translation missing 
L["Guk"] = "Guk"
L["Gulp Froglet"] = "Юная хваткая лягушка"
L["Gundrak Hatchling"] = "Детеныш Гундрака"
L["Half-Empty Food Container"] = "Полупустой ящик для еды"
--Translation missing 
L["Hardened Shell"] = "Hardened Shell"
L["Height"] = "Высота"
--Translation missing 
L["Helpful Wikky's Whistle"] = "Helpful Wikky's Whistle"
--Translation missing 
L["Here is a preview of what will (or won't) be imported:"] = "Here is a preview of what will (or won't) be imported:"
L["Heroic difficulty"] = "Героическая сложность"
L["Heroic Raid (10-30 players)"] = "Героич. рейд (10-30 игроков)"
L["Heroic Scenario instance"] = "Героич. сценарий"
L["Heroic, any raid size"] = "Любой размер рейда (героич.)"
L["Hidden"] = "Скрыто"
L["Hide defeated items"] = "Скрыть побежденных"
L["Hide high chance items"] = "Скрыть предметы с высоким шансом"
--Translation missing 
L["Hide items not in your zone"] = "Hide items not in your zone"
--Translation missing 
L["Hide items with no attempts"] = "Hide items with no attempts"
L["Hide unavailable items"] = "Скрыть недоступные предметы"
--Translation missing 
L["High Priest of Ordos"] = "High Priest of Ordos"
--Translation missing 
L["Highborne"] = "Highborne"
L["Highland Guppy School"] = "Косяк высокогорных гуппи"
L["Highland Mixed School"] = "Смешанный косяк нагорья"
--Translation missing 
L["Highmountain Elderhorn"] = "Highmountain Elderhorn"
--Translation missing 
L["Highmountain Salmon School"] = "Highmountain Salmon School"
--Translation missing 
L["Highmountain Tauren"] = "Highmountain Tauren"
L["Holiday"] = "Праздники"
L["Holiday reminders"] = "Напоминание о событии"
L["Hollow Reed"] = "Полый тростник"
L["Horde only"] = "Орда"
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = "Как часто можно обнаружить предмет, выражается в виде 1 из X, где X - число введенное тут."
L["How many attempts you've made so far."] = "Сколько попыток уже было сделано"
L["How many items you need to collect."] = "Сколько предметов необходимо собрать"
L["How many items you've collected so far."] = "Сколько предметов вы уже собрали"
L["Hozen Beach Ball"] = "Пляжный мяч хозенов"
L["Huge Obsidian Slab"] = "Громадный кусок обсидиана"
--Translation missing 
L["Hunter"] = "Hunter"
L["Hyjal Wisp"] = "Хиджальский огонек"
L["Ice Chip"] = "Осколочек льда"
L["Identify the Item"] = "Определите предмет"
L["Imbued Jade Fragment"] = "Осколок нефрита"
L["Imperial Manta Ray School"] = "Косяк императорского морского дьявола"
L["Imperial Moth"] = "Императорский мотылек"
--Translation missing 
L["Imperial Silkworm"] = "Imperial Silkworm"
--Translation missing 
L["Imp-Master Valessa"] = "Imp-Master Valessa"
--Translation missing 
L["Import"] = "Import"
--Translation missing 
L["Import Rarity Item Pack"] = "Import Rarity Item Pack"
--Translation missing 
L["Import/Export"] = "Import/Export"
--Translation missing 
L["imported successfully"] = "imported successfully"
L["Incendicite Mineral Vein"] = "Ароматитовая жила"
L["Indurium Mineral Vein"] = "Индарилиевая жила"
L["Install TomTom to enable waypoint creation."] = "Установите TomTom для создания направления."
L["Instance Difficulty"] = "Сложность подземелья"
L["Instant Arcane Sanctum Security Kit"] = "Набор безопасности мгновенного волшебного святилища"
L["Invincible's Reins"] = "Поводья Непобедимого"
L["Iron Deposit"] = "Залежи железа"
--Translation missing 
L["Ironbound Collar"] = "Ironbound Collar"
--Translation missing 
L["Ironhoof Destroyer"] = "Ironhoof Destroyer"
L["Item ID"] = "ID предмета"
L["Item ID to Collect"] = "ID предмета для собирания"
L["Items to Use"] = "Предметы для использования"
L["Jade Lungfish School"] = "Косяк нефритовой двоякодышащей рыбы"
L["Jadefire Spirit"] = "Дух нефритового пламени"
L["Jademist Dancer"] = "Танцор из нефритовых туманов"
L["Jawless Skulker School"] = "Косяк безротого скрытиуса"
--Translation missing 
L["Jeremy Feasel"] = "Jeremy Feasel"
L["Jewel Danio School"] = "Косяк бриллиантового данио"
L["Jewel of Maddening Whispers"] = "Самоцвет сводящего с ума шепота"
L["Ji-Kun Hatchling"] = "Птенец Цзи-Кунь"
L["Jingling Bell"] = "Звенящий колокольчик"
--Translation missing 
L["Kael'thas Sunstrider"] = "Kael'thas Sunstrider"
--Translation missing 
L["Kaldorei Light Globe"] = "Kaldorei Light Globe"
--Translation missing 
L["Kal'tik the Blight"] = "Kal'tik the Blight"
L["Kang's Bindstone"] = "Связующий камень Кана"
L["Khorium Vein"] = "Кориевая жила"
L["Kill Statistic IDs"] = "Statistic ID убийств"
--Translation missing 
L["Knockoff Blingtron"] = "Knockoff Blingtron"
L["Kor'kron Juggernaut"] = "Кор'кронский крушитель"
L["Kovok"] = "Ковок"
L["Krasarang Paddlefish School"] = "Косяк красарангского веслоноса"
L["Kyparite Deposit"] = "Залежи кипарита"
--Translation missing 
L["Land Shark"] = "Land Shark"
L["Large Obsidian Chunk"] = "Большая обсидиановая глыба"
L["Large Pool of Brew Frenzied Emperor Salmon"] = "Большой косяк разъяренного хмелем императорского лосося"
L["Large Pool of Crowded Redbelly Mandarin"] = "Большой косяк стайного краснобрюхого окуня"
L["Large Pool of Glimmering Jewel Danio Pool"] = "Большой косяк сверкающего бриллиантового данио"
L["Large Pool of Glowing Jade Lungfish"] = "Большой косяк блестящей нефритовой двоякодышащей рыбы"
L["Large Pool of Sha-Touched Spinefish"] = "Большой косяк пораженной ша иглоспинки"
L["Large Pool of Tiger Gourami Slush"] = "Большой косяк илистого тигрового гурами"
L["Large Swarm of Migrated Reef Octopus"] = "Большая стая мигрировавших рифовых осьминогов"
L["Large Swarm of Panicked Paddlefish"] = "Большой косяк испуганного веслоноса"
L["Large Tangled Mantis Shrimp Cluster"] = "Большая стая запутавшихся раков-богомолов"
L["Last Month"] = "За месяц"
L["Last Week"] = "За неделю"
L["Left"] = "Слева"
--Translation missing 
L["Legion"] = "Legion"
L["Lesser Bloodstone Deposit"] = "Малое месторождение кровавого камня"
L["Lesser Firefin Snapper School"] = "Малый косяк огнеперого луциана"
L["Lesser Floating Debris"] = "Малый плавающий мусор"
L["Lesser Oily Blackmouth School"] = "Малый косяк масляного черноротика"
L["Lesser Sagefish School"] = "Малый косяк шалфокуня"
L["Leviathan Egg"] = "Яйцо левиафана"
--Translation missing 
L["Ley Spider Eggs"] = "Ley Spider Eggs"
--Translation missing 
L["Leystone Deposit"] = "Leystone Deposit"
--Translation missing 
L["Leystone Seam"] = "Leystone Seam"
--Translation missing 
L["Leywoven Flying Carpet"] = "Leywoven Flying Carpet"
L["Life-Binder's Handmaiden"] = "Прислужница Хранительницы Жизни"
L["Likelihood"] = "Вероятность"
L["Lil' Bling"] = "Блескотрончик"
--Translation missing 
L["Living Infernal Core"] = "Living Infernal Core"
L["Living Sandling"] = "Живой песчаник"
L["Loaded (running in debug mode)"] = "Загружен (работает в режиме отладки)"
L["Loaded Gnomish Dice"] = "Шулерская игральная кость"
L["Loading"] = "Загружается"
L["Locked"] = "Зафиксировать"
L["Looking For Raid (10-30 players)"] = "Поиск рейда (10-30 игроков)"
L["Luckiness"] = "Удачливость"
L["Lucky"] = "Везунчик"
L["lucky"] = "везунчик"
L["Lucky if you obtain in %d or less"] = "Повезет, если получишь за %d попыток или меньше"
L["Lump of Coal"] = "Угольная глыба"
--Translation missing 
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = "Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."
--Translation missing 
L["Mage"] = "Mage"
--Translation missing 
L["Magnataur Hunting Horn"] = "Magnataur Hunting Horn"
--Translation missing 
L["Major Nanners"] = "Major Nanners"
L["Mantid"] = "Богомолы"
L["Mark of Flame"] = "Знак огня"
L["Method of obtaining"] = "Способ получения"
--Translation missing 
L["Midnight's Eternal Reins"] = "Midnight's Eternal Reins"
L["Mimiron's Head"] = "Голова Мимирона"
L["Minimal"] = "Минимальный"
L["Minion of Grumpus"] = "Прислужник Ворчуна"
L["MiniZep Controller"] = "Пульт управления мини-дирижаблем"
L["Mirecroak"] = "Топоквак"
L["Mists of Pandaria"] = true
L["Mithril Deposit"] = "Мифриловые залежи"
L["Mogu"] = "Могу"
L["Mojo"] = "Моджо"
--Translation missing 
L["Monk"] = "Monk"
L["Moon Moon"] = "Лун-Лун"
--Translation missing 
L["Moonfang"] = "Moonfang"
L["Moonfang Shroud"] = "Шлем Лунной волчицы"
L["Moonfang's Paw"] = "Лапа Лунной волчицы"
L["Moonglow Cuttlefish School"] = "Стая каракатиц лунного сияния"
--Translation missing 
L["Mossgill Perch School"] = "Mossgill Perch School"
L["Mount"] = "Средство передвижения"
L["Mountain Panda"] = "Горная панда"
L["Mountain Trout School"] = "Косяк горной форели"
L["Mounts"] = "Транспорт"
L["Mr. Grubbs"] = "Мистер Козявс"
L["Mr. Pinchy"] = "Мистер Пинчи"
L["Mr. Smite's Brass Compass"] = "Латунный компас мистера Каюка"
L["Muckbreaths's Bucket"] = "Ведро со смердыхом"
L["Muddy Churning Water"] = "Грязный водоворот"
L["Mudfish School"] = "Косяк ильной рыбы"
L["Musselback Sculpin School"] = "Косяк бычка-щитоспинки"
--Translation missing 
L["Muyani"] = "Muyani"
L["Mysterious Camel Figurine"] = "Странная фигурка верблюда"
L["Mythic 5-player instance"] = "Эпохальное 5-ппл подземелье"
L["Mythic difficulty"] = "Эпохальная сложность"
L["Mythic Raid (20 player)"] = "Эпохальный рейд (20 игроков)"
L["Nerubian"] = "Нерубы"
--Translation missing 
L["Nerubian Relic"] = "Nerubian Relic"
--Translation missing 
L["Nessos the Oracle"] = "Nessos the Oracle"
L["Nethercite Deposit"] = "Месторождение хаотита"
L["Netherfist"] = "Кулак Пустоты"
L["Netherspace Portal-Stone"] = "Камень портала в Пустомарь"
L["Nettlefish School"] = "Стайка медуз"
L["New item"] = "Новый предмет"
L["Night Elf"] = "Ночные эльфы"
L["Nightmare Bell"] = "Колокол кошмаров"
--Translation missing 
L["Nightmare Whelpling"] = "Nightmare Whelpling"
L["Nightshade Sproutling"] = "Росток Ночной Тени"
--Translation missing 
L[ [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=] ] = [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=]
L["None"] = "Нет"
L["None (not in an instance)"] = "Нет (не в подземелье)"
L["Normal"] = "Обычный"
L["Normal Raid (10-30 players)"] = "Обычный рейд (10-30 игроков)"
--Translation missing 
L["not imported"] = "not imported"
L["NPCs"] = "персонажи"
L["Obsidium Deposit"] = "Залежи обсидиана"
--Translation missing 
L["Obtained Achievement ID"] = "Obtained Achievement ID"
L["Obtained After %d Attempts"] = "Получен после %d попыток"
L["Obtained as a rare project for the Fossil branch of archaeology"] = "Собирается как редкий проект археологии (Окаменелости)"
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = "Собирается как очень редкий проект археологии (Тол'виры)"
L["Obtained as an archaeology project"] = "Получается через археологию"
L["Obtained by collecting a number of items"] = "Получается сбором определенного числа предметов"
L["Obtained by fishing"] = "Добывается с помощью рыбалки"
L["Obtained by fishing in any water in Ironforge"] = "Ловится в любом водоёме Стальгорна"
L["Obtained by fishing in any water in Orgrimmar"] = "Ловится в любом водоёме Оргриммара"
L["Obtained by fishing in pools located in Terrokar Forest"] = "Можно выловить из лунок в Лесу Тероккар"
L["Obtained by mining"] = "Добывается с помощью горного дела"
L["Obtained by mining Elementium Vein"] = "Добывается из элементиевых жил"
L["Obtained by opening Crane Nests on the Timeless Isle"] = "Добывается из журавлиных гнезд на Вневременном острове."
L["Obtained by opening Snow Mound in Frostfire Ridge"] = "Добывается из сугробов в зоне праздничных квестов на Хребте Ледяного Огня"
L["Obtained by opening Timeless Chests on the Timeless Isle"] = "Добывается из Вневременных сундуков на Вневременном острове."
L["Obtained by using an item or opening a container"] = "Получается через использование предмета или открытие сумки"
L["Obtained On Your First Attempt"] = "Получен с первой попытки!"
--Translation missing 
L["Obtained Quest ID"] = "Obtained Quest ID"
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = "Очень редко вылавливается из лунок в зонах любого дополнения (не Классики)"
L["Odd Polished Stone"] = "Странный отполированный камень"
L["Ogre"] = "Огры"
L["Oil Spill"] = "Нефтяное пятно"
L["Oily Abyssal Gulper School"] = "Косяк масляного глубинного угря-мешкорота"
L["Oily Blackmouth School"] = "Косяк масляного черноротика"
L["Oily Sea Scorpion School"] = "Косяк жирных морских скорпионов"
L["Old Crafty"] = "Старый Хитрюга"
L["Old Ironjaw"] = "Старый сталезуб"
--Translation missing 
L["Old Man Barlo"] = "Old Man Barlo"
L["Ominous Flame"] = "Зловещее пламя"
--Translation missing 
L["Ominous Pile of Snow"] = "Ominous Pile of Snow"
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = "Один из ID карт, который вы ввели (%s) неверный. Пожалуйста введите числа больше нуля."
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = "Одна из зон или под-зон которые вы добавили (%s) не найдена. Проверьте правильность написания названия на английском или русском языке."
--Translation missing 
L["Only announce when found"] = "Only announce when found"
L["Only Raid Finder difficulty"] = "Только в поиске рейда"
L["Ooze Covered Gold Vein"] = "Покрытая слизью золотая жила"
L["Ooze Covered Mithril Deposit"] = "Покрытые слизью мифриловые залежи"
L["Ooze Covered Rich Thorium Vein"] = "Покрытая слизью богатая ториевая жила"
L["Ooze Covered Silver Vein"] = "Покрытая слизью серебрянная жила"
L["Ooze Covered Thorium Vein"] = "Покрытая слизью ториевая жила"
L["Ooze Covered Truesilver Deposit"] = "Покрытые слизью залежи истинного серебра"
--Translation missing 
L["Options"] = "Options"
--Translation missing 
L["Orb of the Sin'dorei"] = "Orb of the Sin'dorei"
L["Orc"] = "Орки"
--Translation missing 
L["Orphaned Felbat"] = "Orphaned Felbat"
L["Other"] = "Другие"
L["Other Requirements"] = "Прочие требования"
--Translation missing 
L["Overcomplicated Controller"] = "Overcomplicated Controller"
--Translation missing 
L["Paladin"] = "Paladin"
L["Pandaren"] = "Пандарены"
L["Pandaren Firework Launcher"] = "Пандаренская пусковая установка для фейерверков"
L["Panflute of Pandaria"] = "Пандаренская флейта Пана"
L["Parrot Cage (Green Wing Macaw)"] = "Клетка с попугаем (зеленокрылый ара)"
L["Parrot Cage (Hyacinth Macaw)"] = "Клетка с попугаем (гиацинтовый ара)"
--Translation missing 
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = "Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."
L["Patch of Elemental Water"] = "Участок стихийной воды"
L["Periwinkle Calf"] = "Литториновый детеныш"
L["Phoenix Hatchling"] = "Птенец феникса"
L["Pineapple Lounge Cushion"] = "Ананасовая мягкая подушка"
L["Play a sound when groups are found"] = "Проиграть звук при нахождении группы"
L["Players have a personal loot chance to obtain this item."] = "У каждого игрока - личный шанс получения этого предмета."
L["Please enter a comma-separated list of item IDs."] = "Введите список ID предметов (разделяются запятыми)."
L["Please enter a comma-separated list of NPC IDs."] = "Введите список ID персонажей (разделяются запятыми)."
--Translation missing 
L["Please enter a comma-separated list of Quest IDs."] = "Please enter a comma-separated list of Quest IDs."
L["Please enter a comma-separated list of Statistic IDs."] = "Пожалуйста введите список Statistic ID, разделенных запятой."
L["Please enter a comma-separated list of zones."] = "Введите список ID зон (разделяются запятыми)."
L["Pool of Fire"] = "Лужа огня"
L["Porcupette"] = "Дикобразик"
--Translation missing 
L["Priest"] = "Priest"
L["Primal Egg"] = "Изначальное яйцо"
--Translation missing 
L["Primary tooltip hide delay"] = "Primary tooltip hide delay"
L["Primary tooltip scale"] = "Масштаб основной подсказки"
L["Profile modified, rebooting"] = "Профиль изменён, перезапускаемся"
L["Profiling OFF"] = "Профилирование Выкл."
L["Profiling ON"] = "Профилирование Вкл."
L["Progress"] = "Прогресс"
L["Progress Bar"] = "Строка прогресса"
L["Puddle Terror"] = "Кошмар из лужи"
--Translation missing 
L["Pugg"] = "Pugg"
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = "Покупается у З'тенги Ходока <Интендант охотников за саблеронами> в Клыкоморье В танаанских Джунглях. Коготь саблерона из племени Черного Клыка дропается со вмех мобов в зоне."
L["Pure Saronite Deposit"] = "Месторождение чистого саронита"
L["Pure Water"] = "Чистая вода"
--Translation missing 
L["Put \"Rarity:\" on a separate line"] = "Put \"Rarity:\" on a separate line"
--Translation missing 
L["Putricide's Alchemy Supplies"] = "Putricide's Alchemy Supplies"
L["Pygmy Direhorn"] = "Карликовый дикорог"
L["Pyrite Deposit"] = "Залежи колчедана"
--Translation missing 
L["Quest ID"] = "Quest ID"
L["Quivering Blob"] = "Дрожащая капля"
L["Raid Finder instance (legacy content; fixed at 25 players)"] = "Подземелье поиска рейда (устаревший контент; 25 игроков)"
L["Raid Finder or Flexible difficulty"] = "Поиск рейда или гибкий рейд"
L["Rarity has %d |4coordinate:coordinates; for this item."] = "У Rarity есть %d координат(ы) для этого предмета"
--Translation missing 
L["Rarity is loading..."] = "Rarity is loading..."
--Translation missing 
L["Rarity Item Pack String"] = "Rarity Item Pack String"
L["Rarity Tooltip Options"] = "Настройка подсказок Rarity"
L["Rarity: "] = "Редкость:"
L["Razzashi Hatchling"] = "Детеныш раззаши"
L["Red Goren Egg"] = "Красное горенское яйцо"
L["Red Helper Box"] = "Коробочка с красным помощником"
L["Red Qiraji Resonating Crystal"] = "Красный киражский резонирующий кристалл"
L["Redbelly Mandarin School"] = "Косяк краснобрюхой мандаринки"
--Translation missing 
L["Red-Hot Coal"] = "Red-Hot Coal"
L["Reef Octopus Swarm"] = "Стая рифовых осьминогов"
L["Reins of the Amber Primordial Direhorn"] = "Поводья янтарного доисторического дикорога"
L["Reins of the Astral Cloud Serpent"] = "Поводья астрального облачного змея"
L["Reins of the Azure Drake"] = "Поводья лазурного дракона"
L["Reins of the Black Primal Raptor"] = "Поводья черного древнего ящера"
L["Reins of the Blazing Drake"] = "Поводья пылающего дракона"
L["Reins of the Blue Drake"] = "Поводья синего дракона"
L["Reins of the Blue Proto-Drake"] = "Поводья синего протодракона"
L["Reins of the Bone-White Primal Raptor"] = "Поводья древнего ящера цвета кости"
L["Reins of the Cobalt Primordial Direhorn"] = "Поводья кобальтового доисторического дикорога"
L["Reins of the Crimson Water Strider"] = "Поводья багрового водного долгонога"
L["Reins of the Drake of the North Wind"] = "Поводья дракона северного ветра"
L["Reins of the Drake of the South Wind"] = "Поводья дракона южного ветра"
L["Reins of the Grand Black War Mammoth"] = "Поводья большого черного боевого мамонта"
L["Reins of the Green Primal Raptor"] = "Поводья зеленого древнего ящера"
L["Reins of the Green Proto-Drake"] = "Поводья зеленого протодракона"
L["Reins of the Grey Riding Camel"] = "Поводья серого ездового верблюда"
L["Reins of the Heavenly Onyx Cloud Serpent"] = "Поводья небесного ониксового облачного змея"
L["Reins of the Infinite Timereaver"] = "Поводья попирателя времен из рода Бесконечности"
L["Reins of the Jade Primordial Direhorn"] = "Поводья нефритового доисторического дикорога"
L["Reins of the Onyxian Drake"] = "Поводья дракона Ониксии"
L["Reins of the Raven Lord"] = "Поводья повелителя воронов"
L["Reins of the Slate Primordial Direhorn"] = "Поводья сланцевого доисторического дикорога"
L["Reins of the Thundering Cobalt Cloud Serpent"] = "Поводья грозового кобальтового облачного змея"
L["Reins of the Thundering Onyx Cloud Serpent"] = "Поводья грозового ониксового облачного змея"
L["Reins of the Vitreous Stone Drake"] = "Поводья камнешкурого дракона"
L["Reins of the White Polar Bear"] = "Поводья белого северного медведя"
--Translation missing 
L["Remains of a Blood Beast"] = "Remains of a Blood Beast"
L["Repeatable"] = "Повторяемый"
L["Required for %s"] = "Требуется для %s"
L["Requires a pool"] = "Требуется лунка"
L["Requires Pickpocketing"] = "Требуется умение \"Обшаривание карманов\""
L["Rich Adamantite Deposit"] = "Богатые залежи адамантита"
L["Rich Blackrock Deposit"] = "Богатые залежи руды Черной горы"
L["Rich Cobalt Deposit"] = "Богатые залежи кобальта"
L["Rich Elementium Vein"] = "Богатая элементиевая жила"
--Translation missing 
L["Rich Felslate Deposit"] = "Rich Felslate Deposit"
L["Rich Ghost Iron Deposit"] = "Богатые залежи призрачного железа"
L["Rich Kyparite Deposit"] = "Богатые залежи кипарита"
--Translation missing 
L["Rich Leystone Deposit"] = "Rich Leystone Deposit"
L["Rich Obsidium Deposit"] = "Богатые обсидиановые залежи"
L["Rich Pyrite Deposit"] = "Богатые залежи колчедана"
L["Rich Saronite Deposit"] = "Богатое месторождение саронита"
L["Rich Thorium Vein"] = "Богатая ториевая жила"
L["Rich Trillium Vein"] = "Богатая триллиевая жила"
L["Rich True Iron Deposit"] = "Богатые залежи истинного железа"
L["Riding Turtle"] = "Верховая черепаха"
L["Right"] = "Справа"
L["Right-Aligned"] = "По правому краю"
L["Rime of the Time-Lost Mariner"] = "Сказание о затерянном во времени мореходе"
--Translation missing 
L["Rogue"] = "Rogue"
L["Rotten Helper Box"] = "Коробочка с поганым маленьким помощником"
L["Ruby Droplet"] = "Рубиновая капля"
--Translation missing 
L["Rukdug"] = "Rukdug"
--Translation missing 
L["Runescale Koi School"] = "Runescale Koi School"
L["Sack of Spectral Spiders"] = "Мешок с призрачными пауками"
L["Safari Lounge Cushion"] = "Мягкая подушка в стиле сафари"
L["Sagefish School"] = "Косяк шалфокуня"
--Translation missing 
L["Sahn Tidehunter"] = "Sahn Tidehunter"
--Translation missing 
L["Salyin Battle Banner"] = "Salyin Battle Banner"
--Translation missing 
L["Salyin Warscout"] = "Salyin Warscout"
L["Saronite Deposit"] = "Месторождение саронита"
--Translation missing 
L["Sassy Imp"] = "Sassy Imp"
L["Satyr Charm"] = "Оберег сатира"
L["Savage Cub"] = "Дикий детеныш"
L["Savage Piranha Pool"] = "Пруд свирепых пираний"
L["Scale"] = "Масштаб"
L["Scenario instance"] = "Сценарий"
L["Scepter of Azj'Aqir"] = "Скипетр Аз'Акир"
L["School of Darter"] = "Косяк змеешейки"
L["School of Deviate Fish"] = "Косяк загадочной рыбы"
L["School of Tastyfish"] = "Косяк вкуснорыбы"
L["Schooner Wreckage"] = "Разбитая шхуна"
L["Schooner Wreckage Pool"] = "Разбитая шхуна"
L["Scorched Stone"] = "Опаленный камень"
--Translation missing 
L["Scraps"] = "Scraps"
--Translation missing 
L["Sea Calf"] = "Sea Calf"
L["Sea Pony"] = "Морской пони"
L["Sea Scorpion School"] = "Косяк морских скорпионов"
L["Sea Turtle"] = "Морская черепаха"
L["Seaborne Spore"] = "Пучинная спора"
L["Secondary tooltip display"] = "Отображение вторичной подсказки"
L["Servant of Demidos"] = "Прислужник Демида"
L["Servant's Bell"] = "Колокольчик слуги"
L["Session"] = "Сеанс"
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = "Установите ID достижения, которое определяет получение предмета, в это поле. Это удобно для предметов, которые не являются средствами передвижения или питомцами, но за них дается достижение, например, Старый Сталезуб или Старый Хитрюга. Оставьте пустым для средств передвижения и питомцев. Воспользуйтесь WowHead'ом для поиска ID достижений."
L["Shadowhide Pearltusk"] = "Темный жемчужношкурый элекк"
--Translation missing 
L["Shaman"] = "Shaman"
L["Shard of Supremus"] = "Осколок Супремуса"
L["Sha-Touched Spinefish"] = "Пораженная ша иглоспинка"
L["Shell of Tide-Calling"] = "Панцирь призыва приливной волны"
L["Shift-Click to link your progress to chat"] = "Shift-Click - скопировать прогресс в чат"
L["Shift-Click to open options"] = "Shift-Click - открыть настройки."
L["Shipwreck Debris"] = "Обломки кораблекрушения"
L["Show anchor"] = "Отображать заголовок"
L["Show attempts in tooltips"] = "Кол-во попыток в подсказках"
L["Show auto refresh checkbox"] = "Показ. флажок автообновления"
L["Show category icons"] = "Показ. иконки категорий"
L["Show Icon"] = "Отображать иконку"
L["Show Luckiness column"] = "Показ. колонку удачливости"
L["Show minimap icon"] = "Значок у миникарты"
L["Show Text"] = "Отображать текст"
L["Show Time column"] = "Показ. колонку времени"
L["Show Zone column"] = "Показ. колонку зоны"
L["Silver Vein"] = "Серебряная жила"
L["Silver-Plated Turkey Shooter"] = "Посеребренный индейкомет"
L["Since last drop"] = "С последней находки"
--Translation missing 
L["Sira's Extra Cloak"] = "Sira's Extra Cloak"
L["Skrillix"] = "Скрилликс"
--Translation missing 
L["Skull of a Frozen Whelp"] = "Skull of a Frozen Whelp"
L["Skunky Alemental"] = "Прокисший хмелементаль"
L["Sky-Bo"] = "Небесный бо"
L["Skyshard"] = "Осколок небес"
L["Slithershock Elver"] = "Искрящий угорь"
L["Small Obsidian Chunk"] = "Маленький кусочек обсидиана"
L["Small Thorium Vein"] = "Малая ториевая жила"
L["Smashum Grabb"] = "Шумм Хват"
L["Smelly Gravestone"] = "Вонючее надгробие"
L["Smoky Direwolf"] = "Дымчатый лютый волк"
L["Smoldering Egg of Millagazor"] = "Дымящееся яйцо Миллазор"
L["Snarly's Bucket"] = "Ведро Ворчуна"
L["Snow Mound"] = "Сугроб"
L["Snowman Kit"] = "Сделай сам: снеговик"
L["Snowy Panda"] = "Снежная панда"
L["Solar Spirehawk"] = "Солнечный ястреб пиков"
L["Son of Animus"] = "Порождение Анимуса"
L["Son of Galleon's Saddle"] = "Седло Сына Галеона"
L["Sorting by category, then name"] = "Сортировать по категории, затем по имени"
L["Sorting by difficulty"] = "Сортировка по сложности"
L["Sorting by name"] = "Сортировка по имени"
L["Sorting by percent complete"] = "Сортировка по % выполнения"
--Translation missing 
L["Sorting by zone"] = "Sorting by zone"
L["Sparse Firefin Snapper School"] = "Небольшой косяк огнеперого луциана"
L["Sparse Oily Blackmouth School"] = "Небольшой косяк масляного черноротика"
L["Sparse Schooner Wreckage"] = "Небольшая разбитая шхуна"
L["Spawn of Horridon"] = "Порождение Хорридона"
L["Special case"] = "Исключение"
L["Spectral Bell"] = "Призрачный колокольчик"
L["Spell ID"] = "ID заклинания"
L["Spiky Collar"] = "Шипастый ошейник"
L["Spineclaw Crab"] = "Краб-хребтохват"
L["Spinefish School"] = "Косяк иглоспинки"
L["Sporefish School"] = "Косяк спороуса"
L["Sprite Darter Egg"] = "Яйцо летучего хамелеона"
L["Statistics"] = "Статистика"
L["Steam Pump Flotsam"] = "Обломки парового насоса"
--Translation missing 
L["Sting Ray Pup"] = "Sting Ray Pup"
L["Stonescale Eel Swarm"] = "Стайка каменного угря"
--Translation missing 
L["Stormforged Rune"] = "Stormforged Rune"
L["Strand Crawler"] = "Прибрежный ползун"
L["Strange Pool"] = "Странный водоем"
L["Sultry Grimoire"] = "Гримуар распутства"
L["Sun Sproutling"] = "Солнечный росток"
L["Sunblade Rune of Activation"] = "Руна активации Солнечного Клинка"
L["Sunfire Kaliri"] = "Солнечно-огненный калири"
L["Sunfur Panda"] = "Солнечная панда"
L["Swarm of Panicked Paddlefish"] = "Косяк испуганноого веслоноса"
L["Swift Brewfest Ram"] = "Стремительный баран Хмельного фестиваля"
L["Swift White Hawkstrider"] = "Стремительный белый крылобег"
L["Swift Zulian Panther"] = "Стремительная зульская пантера"
L["Syd the Squid"] = "Кальмар Вольдемар"
L["Tainted Core"] = "Ядро порчи"
L["Tainted Maulclaw"] = "Нечистый острохват"
L["Take screenshots"] = "Делать снимки экрана"
L["Tangled Mantis Shrimp Cluster"] = "Стая запутавшихся раков-богомолов"
L["Teeming Firefin Snapper School"] = "Большой косяк огнеперого луциана"
L["Teeming Floating Wreckage"] = "Большие плавающие обломки"
L["Teeming Oily Blackmouth School"] = "Большой косяк масляного черноротика"
L["Terrorfist"] = "Кулак Страха"
L["Texture"] = "Текстура"
--Translation missing 
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = "The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."
L["The Burning Crusade"] = true
--Translation missing 
L["The following %d item(s) have been selected to export:"] = "The following %d item(s) have been selected to export:"
L["The Heartbreaker"] = "Сердцеед"
L["The Horseman's Reins"] = "Поводья скакуна Всадника без головы"
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = "ID предмета, который нужно собрать. Rarity использует количество данных предметов в ваших сумках как прогресс. Используйте WowHead или подобное. чтобы выяснить ID. ID должен быть корректным и не использоваться другими предметами."
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = "ID предмета. Определяет предмет, когда он находится в сумке или в окне добычи. Используйте WowHead или подобные сервисы для нахождения ID предметов. Номер должен быть правильным и уникальным."
L["The name you entered is already being used by another item. Please enter a unique name."] = "Введенное название уже используется другим предметом. Используйте уникальное название. "
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = "НПЦ ID существа, которое появляется, когда вы призываете данного питомца. Используется для отслеживания общих для аккаунта боевых питомцев."
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = "Количество игроков требуемое для получения данного предмета. Шанс на получение будет рассчитываться с понижающим коэффициентом."
L["The Pigskin"] = "Мяч из толстой кожи"
--Translation missing 
L["The quest starter item for Reins of the Llothien Prowler"] = "The quest starter item for Reins of the Llothien Prowler"
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = "Модуль настроек отключен. Выйдите из игрового мира и включите его в списке игровых модификаций."
--Translation missing 
L["The selected Rarity Item Pack string is invalid."] = "The selected Rarity Item Pack string is invalid."
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = "ID заклинания уже изученного предмета. Относится только к маунтам или питомцам, и является заклинанием появляющимся в вашей книге навыков после изучения предмета. Используйте WowHead или подобные сервисы для нахождения ID заклинаний предметов. Номер должен быть правильным и уникальным."
L["The Warbringer will be riding the mount color he has a chance to drop."] = "Завоеватель сидит верхом на дикороге того цвета, который может выпасть."
L["There are more holiday items available, but Rarity only reminds you about the first two."] = "Имеется больше праздничных предметов, но Rarity напоминает только о первых двух."
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = "Данные переключатели контролируют какие предметы отображаются на главной подсказке Rarity. Предметы разбиты на категории по дополнениям, в которых они были добавлены (хотя праздничные предметы имеют отдельную категорию). Отключение данных флажков не отключит слежение для каких-либо предметов внутри категории - это просто скроет предмет на подсказке, чтобы уменьшить количество отображаемых предметов."
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = "Сумка дается в награду за победу в битве питомцев над Кристофом фон Физелем на ярмарке Новолуния (ежедневно)."
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = "Сумка дается в награду за победу в битве питомцев над Джереми Фитилем на ярмарке Новолуния (ежедневно)."
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = "Сумка служит наградой за золотой или платиновый рейтинг при защите гарнизона."
L["This causes Rarity to put a blank line above its tooltip additions."] = "Rarity будет добавлять пустую строку перед своим текстом в подсказке."
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = "Этот предмет имеет 1 к 4 шанс выпадения из Голганарра, редкого моба на Вневременном острове.  И 1 к 250 - из Обветренного обитателя скал на Вневременном острове."
L["This item is only available to Alliance players."] = "Предмет доступен только для игроков Альянса."
L["This item is only available to Horde players."] = "Предмет доступен только для игроков Орды."
L["This mount is only obtainable by Alliance players"] = "Это ездовое животное доступно только Альянсу"
L["This mount is only obtainable by Horde players"] = "Это ездовое животное доступно только Орде"
--Translation missing 
L["This tab lets you import and export items into and out of your Custom tab."] = "This tab lets you import and export items into and out of your Custom tab."
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = "Гарантированно выпадал при убийстве босса в актуальное время"
L["Tiger Gourami School"] = "Косяк тигрового гурами"
L["Tiger Gourami Slush"] = "Илистый тигровый гурами"
L["Time"] = "Время"
L["Time spent farming"] = "Потрачено времени на поиски"
L["Timeless Chest"] = "Вневременной сундук"
L["Time-Locked Box"] = "Шкатулка Времени"
L["Time-Lost Figurine"] = "Статуэтка затерянного во времени"
L["Timewalker 5-player instance"] = "Путешествие во времени (5 человек)"
L["Tin Vein"] = "Оловянная жила"
L["Tiny Crimson Whelpling"] = "Маленький багровый дракончик"
L["Tiny Emerald Whelpling"] = "Маленький изумрудный дракончик"
L["Tiny Fel Engine Key"] = "Маленький ключ от двигателя Скверны"
L["Titanium Vein"] = "Залежи титана"
L[ [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=] ] = [=[Для добавления нового предмета, ведите уникальное название и нажмите OK. Это название будет использоваться, если сервер не обнаружит предмет или в нем будет ошибка.

Будьте внимательны, вы не сможете изменить название после добавления.]=]
--Translation missing 
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = "To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."
--Translation missing 
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = "To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."
L["Today"] = "Сегодня"
L["Toggles"] = "Переключатели"
L["Tol'vir"] = "Тол'вир"
--Translation missing 
L["Tooltip can't be shown in combat"] = "Tooltip can't be shown in combat"
L["Toothy's Bucket"] = "Ведро с Зубастиком"
--Translation missing 
L["Torn Invitation"] = "Torn Invitation"
L["Total"] = "Всего"
L["Total found"] = "Всего найдено"
L["Toxic Wasteling"] = "Токсичный выбросец"
L["Toy or Item"] = "Игрушка или предмет"
L["Toys & Items"] = "Игрушки и предметы"
L["Track this"] = "Отслеживать"
L["Trillium Vein"] = "Триллиевая жила"
L["Troll"] = "Тролли"
L["True Iron Deposit"] = "Залежи истинного железа"
L["Truesilver Deposit"] = "Залежи истинного серебра"
L["Tundra Icehoof"] = "Тундровый ледяной копытень"
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = "Включите, если для получения предмета требуется группа, но получает его каждый игрок в ней. В частности это относится к многим праздничным маунтам. После включения этой опции, Rarity перестаёт рассчитывать понижающий коэффициент для шанса получения предмета в группе."
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = "Включить значок около миникарты."
L["Type of item"] = "Тип предмета"
--Translation missing 
L["Unable to retrieve item information from the server"] = "Unable to retrieve item information from the server"
L["Unavailable"] = "Недоступно"
L["Undefeated"] = "Не повержен"
L["Unknown"] = "Неизвестно"
L["Unlucky"] = "Невезучий"
L["unlucky"] = "невезучий"
L["Unscathed Egg"] = "Неповрежденное яйцо"
--Translation missing 
L["Unstable Powder Box"] = "Unstable Powder Box"
L["Unusual Compass"] = "Необычный компас"
L["Use your bonus roll for a chance at this item"] = "Используй бонусный бросок, ради шанса получить этот предмет"
L["Usually requires a group of around %d players"] = "Обычно требуется группа из %d игроков"
--Translation missing 
L["Valarjar Stormwing"] = "Valarjar Stormwing"
L["Vengeance"] = "Отмщение"
L["Verbose"] = "Избыточный"
L["Vibrating Arcane Crystal"] = "Дрожащий магический кристалл"
L["Vile Blood of Draenor"] = "Порченная кровь Дренора"
L["Viscidus Globule"] = "Нечистая капля"
L["Void Collar"] = "Ошейник Бездны"
L["Vrykul"] = "Врайкулы"
--Translation missing 
L["Warlock"] = "Warlock"
L["Warlords of Draenor"] = true
L["Warm Arcane Crystal"] = "Теплый магический кристалл"
L["Warning Sign"] = "Предупредительный знак"
L["Warrior"] = "Воин"
L["Warsong Direfang"] = "Лютоклык клана Песни Войны"
L["Waterlogged Wreckage"] = "Плавающие обломки"
L["Waterlogged Wreckage Pool"] = "Плавающие обломки"
L["Weebomination"] = "Поганчик"
L["Welcome to Rarity r%d. Your settings have been reset."] = "Добро пожаловать в Rarity в.%d. Настройки сброшены."
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = "При использовании любого амулета удачи (монетки) в течение 90 секунд после попытки получить предмет, будет засчитана еще одна попытка. Включайте только для предметов, которые можно получить с помощью монетки"
L["When enabled, Rarity tooltips will include how many attempts you've made."] = "Когда включено, Rarity добавляет в подсказки кол-во сделанных попыток."
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = "Если вкл., Rarity добавит Авто флажок в окно Поиска группы. Отметка флажка включает обновление поиска каждые 5 секунд."
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = "Если включено, Rarity будет добавлять получаемые предметы к игровым подсказкам везде, где это возможно."
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = "Если вкл., Rarity проиграет звук, когда автообновление поиска найдет одну или более групп. Звук не будет проигрываться чаще чем раз в минуту."
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = "Если вкл., Rarity будет печатать в чат debug profiling сообщения, когда определенные события происходят. Используется для определения какая часть кода тормозит."
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = "Если вкл., предмет может быть получен только обшаривание карманов. Предмет будет отмечен Недоступным для не-разбойнков."
L["When on, items marked as Defeated will be hidden from the tooltip."] = "Когда вкл., предметы отмеченные Поверженными будут скрыты из подсказки."
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = "Предметы, помеченные как \"Недоступные\" не будут отображаться в подсказках. Таким образом, предметы, которые можно получить лишь во время праздника, не будут отображаться до тех пор, пока праздник не наступит."
--Translation missing 
L["When on, items that have no attempts yet will be hidden from the tooltip."] = "When on, items that have no attempts yet will be hidden from the tooltip."
--Translation missing 
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = "When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."
L[ [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=] ] = "Когда вкл., Rarity напомнит об отсутствующих праздничных предметах, пока событие активно, и предмет помечен как Не повержен. (Работает только для предметов получаемых в фест. подземельях и ежедневными заданиями.) Напоминание появляется при каждом входе или перезагрузке интерфейса."
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = "Когда вкл., у каждого предмета в подсказке Rarity будет показывать иконку, означающую к какому дополнению он относится."
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = "Rarity будет делать снимок экрана при появлении уведомления о том, что вы получили предмет."
L["When on, the Luckiness column will be shown in the main tooltip."] = "Когда вкл., колонка Удачливости показывается в основной подсказке."
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = "Когда включено, текст \"Rarity:\" будет добавляться в глобальные и предметные подсказки. "
L["When on, the Time column will be shown in the main tooltip."] = "Когда вкл. колонка Времени показывается в основной подсказке."
L["When on, the Zone column will be shown in the main tooltip."] = "Когда вкл. колонка Зоны показывается в основной подсказке."
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = "Когда включена, данная опция скрывает все предметы с шансом получения 1 из 49 или лучше. Предмет просто скрыт на подсказке, чтобы не загромождать ее. Предметы, скрытые таким образом, по прежнему отслеживаются как обычно."
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = "Длительность задержки перед автоматическим скрытием подсказки, после перемещения курсора мышки."
L["Whistle of Chromatic Bone"] = "Костяной свисток"
L["White Trillium Deposit"] = "Залежи белой триллиевой руды"
L["Width"] = "Ширина"
--Translation missing 
L["Wild Dreamrunner"] = "Wild Dreamrunner"
L["Wild Goretusk"] = "Дикий кровоклык"
L["will be imported"] = "будет импортировано"
L["Will only drop for druids."] = "Падает только друидам."
--Translation missing 
L["Wisp in a Bottle"] = "Wisp in a Bottle"
L["World Tooltip Options"] = "Глобальные настройки подсказки"
L["Worn Troll Dice"] = "Потертая тролльская игральная кость"
L["Wrath of the Lich King"] = true
L["Wriggling Darkness"] = "Извивающаяся тьма"
L["Yesterday"] = "Вчера"
L["You already defeated %d of them."] = "Ты уже победил %d из них."
L["You already defeated all of them."] = "Ты уже победил всех из них."
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = "Напоминание о событии можно выключить в настройках, как в целом, так и для отдельных предметов."
L["You entered a achievement ID that is already being used by another item."] = "Вы ввели ID достижения, которое уже используется другим предметом."
L["You entered a creature ID that is already being used by another item."] = "Вы ввели ID существа, которое уже используется другим предметом."
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = "Данное название уже зарезервировано. Введите правильное название, так как оно пишется в игре."
L["You entered a spell ID that is already being used by another item."] = "Вы ввели ID заклинания уже используемое другим предметом."
L["You entered an item ID that is already being used by another item."] = "Вы ввели ID предмета уже используемое другим предметом."
L["You entered an item ID that is already set as the collected item for something else."] = "Вы ввели ID предмета, который уже установлен в качестве отслеживаемого для чего-то другого."
L["You must enter a creature ID."] = "Вы должны ввести ID существа."
L["You must enter a number larger than 0."] = "Вы должны ввести число больше 0."
L["You must enter a number larger than 1."] = "Вы должны ввести число больше 1."
L["You must enter a number larger than or equal to 0."] = "Вы должны ввести число больше или равное 0."
L["You must enter a spell ID."] = "Введите ID заклинания."
L["You must enter a valid number."] = "Введите правильный номер."
L["You must enter an amount."] = "Введите количество."
L["You must enter an item ID."] = "Введите ID предмета."
L["You must enter at least one item ID."] = "Введите хотя бы один ID предмета."
L["You must enter at least one NPC ID."] = "Введите хотя бы один ID персонажа."
L["You must enter at least one Statistic ID."] = "Вы должны ввести хотя бы один Statistic ID."
L["You must enter at least one zone."] = "Добавьте хотя бы одну зону."
L["Young Talbuk"] = "Молодой талбук"
--Translation missing 
L["Young Venomfang"] = "Young Venomfang"
L["Zandalari Anklerender"] = "Зандаларский пяткогрыз"
L["Zandalari Footslasher"] = "Зандаларский пяткохлыстик"
L["Zandalari Kneebiter"] = "Зандаларский ногокус"
L["Zandalari Toenibbler"] = "Зандаларский пальцегрыз"
L["Zangar Spore"] = "Зангарская спора"
L["Zhevra Lounge Cushion"] = "Мягкая подушка из кожи жевры"
L["Zomstrok"] = "Зомстрок"
L["Zone"] = "Зона"
L["Zones"] = "Зоны"

end

L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "zhCN")
if L then
L[" (Group)"] = "(组)"
L["#%d: %d attempt (%.2f%%)"] = "#%d: 尝试 %d 次 (%.2f%%)"
L["#%d: %d attempts (%.2f%%)"] = "#%d: 尝试 %d 次 (%.2f%%)"
--Translation missing 
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = "%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"
--Translation missing 
L["%d |4zone:zones;"] = "%d |4zone:zones;"
L["%d attempt"] = "尝试 %d 次"
L["%d attempt - %.2f%%"] = "已尝试 %d - %.2f%%"
L["%d attempts"] = "尝试 %d 次"
L["%d attempts - %.2f%%"] = "已尝试 %d  - %.2f%%"
L["%d collected - %.2f%%"] = "%d 已收集 - %.2f%%"
L["%s: %d attempt"] = "%s: %d 尝试"
L["%s: %d attempt - %.2f%%"] = "%s: 尝试 %d - %.2f%%"
L["%s: %d attempt (%d total)"] = "%s: 已尝试 %d  (共 %d )"
L["%s: %d attempts"] = "%s: %d 尝试"
L["%s: %d attempts - %.2f%%"] = "%s: 尝试 %d 次 - %.2f%%"
L["%s: %d attempts (%d total)"] = "%s: 已尝试 %d (共 %d )"
L["%s: %d collected"] = "%s: %d 已收集"
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = "%s: 0/%d 尝试到目前为止 (%.2f%% - %s)"
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = "%s: 0/%d 尝试到目前为止 (%.2f%% - %s)"
L["%s: collection completed!"] = "%s: 收藏成功!"
--Translation missing 
L["%s: Found after %d attempts!"] = "%s: Found after %d attempts!"
--Translation missing 
L["%s: Found on the first attempt!"] = "%s: Found on the first attempt!"
L["(%d/%d attempts)"] = "（%d/%d 尝试）"
L["(%d/%d collected)"] = "(%d/%d 已收集)"
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = "(标红物品已不存在.建议删除.)"
L["(running in debug mode)"] = "(调试模式运行中)"
--Translation missing 
L["(Warning: item could not be retrieved from server)"] = "(Warning: item could not be retrieved from server)"
L["1 in %d chance"] = "1 比 %d 概率"
L["10-player Heroic Raid instance (legacy content; not flexible)"] = "10人英雄团队副本 (旧副本; 非弹性)"
L["10-player Raid instance (legacy content; not flexible)"] = "10人团队副本(旧副本; 非弹性)"
L["25-player Event scenario"] = "25人场景事件"
L["25-player heroic"] = "25人英雄"
L["25-player Heroic Raid instance (legacy content; not flexible)"] = "25人英雄团队副本 (旧副本; 非弹性)"
L["25-player Raid instance (legacy content; not flexible)"] = "25人团队副本 (旧副本; 非弹性)"
L["40-player Event raid"] = "40人副本事件"
L["40-player Raid instance (legacy content; not flexible)"] = "40人团队副本 (旧副本; 非弹性)"
L["5-player Event instance"] = "5人组队事件"
L["5-player Heroic instance"] = "5人英雄地下城"
L["5-player instance"] = "5人地下城"
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = "一个用逗号分隔的物品 ID 列表，当使用或打开后，可以查询这项物品。使用 WowHead 或类似的服务查找 ID。"
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = "一个使用逗号分隔的NPC ID的物品掉落列表。使用Wowhead或一个类似的服务来查找NPC IDs。"
--Translation missing 
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = "A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = "一个用来跟踪物品 ID 以用来统计杀敌数的逗号分隔的列表。"
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = "一个用来跟踪物品 ID 以用来统计杀敌数的逗号分隔的列表。这些统计数据将同时增加。使用 WowHead 或类似的服务来查找统计的 ID。"
L[ [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=] ] = [=[你可以在这项列表中找到用逗号分隔的地图或子地图。大地图的话，你可以输入地图ID（例如 811 是锦绣谷），或地区全称。子地图的话，您必须输入的子地图的全称。
输入地图名称时注意正确的拼写、大小写和标点符号。可以输入英语或你的客户端语言。使用 WowHead 或类似的服务来确保你正确完整的输入区域名称。
注意：地图名称翻译可能不正确。大地图的话，强烈建议输入地图的 ID 而不是名字。子地图，你必须输入地图名称。如果子地图检测不到，请访问 wowace.com 的 libbabble-subzone-3.0 library 网页上传你的语言的翻译。]=]
--Translation missing 
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = "A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."
L["A holiday event is available today for %s! Go get it!"] = "一个节日活动已经开始 %s ！去获得它！"
L["Abundant Bloodsail Wreckage"] = "大型的血帆残骸"
L["Abundant Firefin Snapper School"] = "大型的火鳞鳝鱼群"
L["Abundant Oily Blackmouth School"] = "大型的黑口鱼群"
L["Abyss Worm"] = "深渊蠕虫"
L["Abyssal Gulper School"] = "深渊大嘴鳗鱼群"
L["Adamantite Deposit"] = "精金矿脉"
L["Added %d |4waypoint:waypoints; to TomTom"] = "添加到 %d |4waypoint:waypoints; TomTom路点"
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = [=[缩放调整主要工具提示。这将在下一次的工具提示显示时生效。
]=]
--Translation missing 
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = "After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."
--Translation missing 
L["Ageless Bronze Drake"] = "Ageless Bronze Drake"
L["Ahune"] = "埃霍恩 <冰霜之王>"
L["Ai-Li's Skymirror"] = "艾利的天镜"
L["Ai-Ran the Shifting Cloud"] = "迅云艾然"
L["Albino Buzzard"] = "白化秃鹫"
L["Albino Cavefish School"] = "白色洞穴鱼群"
L["Albino Chimaeraling"] = "白化小奇美拉"
L["Algaefin Rockfish School"] = "藻鳍岩鱼群"
L["All players can participate in killing this world boss once per week, regardless of faction"] = "这个世界所有玩家每周都都可以击杀这个 boss 一次，无论阵营。"
L["All raid formats except Raid Finder"] = "随机团队除外"
L["Alliance only"] = "仅联盟"
L["Already defeated"] = "已击败"
L["Already defeated for %s"] = "已经击败 %s"
L["Already known"] = "已知"
--Translation missing 
L["an item already exists by this name, so it will not be imported"] = "an item already exists by this name, so it will not be imported"
--Translation missing 
L["an item with the same Item ID already exists, so it will not be imported"] = "an item with the same Item ID already exists, so it will not be imported"
L["Ancient Mana"] = "远古魔力"
--Translation missing 
L["and %d |4other zone:other zones;"] = "and %d |4other zone:other zones;"
L["Announce"] = "通报"
L["Announcements"] = "通报"
--Translation missing 
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = "Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."
L["Anubisath Idol"] = "阿努比萨斯人偶"
L["Any difficulty"] = "任意难度"
L["Any raid size"] = "任意团队人数"
L["Any raid size or difficulty"] = "任意人数任意难度团队副本"
L["Appears in the Black Market"] = "出现在黑市"
L["Aqua Jewel"] = "水润宝珠"
L["Arakkoa"] = "鸦人"
L["Arcano-Shower"] = "奥能花洒"
L["Archaeology race"] = "考古学种族"
L["Are you sure you want to delete this item?"] = "你确定你想要删除这个物品吗？"
--Translation missing 
L["Are you sure you want to import the Rarity Item Pack you entered?"] = "Are you sure you want to import the Rarity Item Pack you entered?"
--Translation missing 
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = "Are you sure you want to turn off the Export toggle for all your Custom items?"
L["Armored Razorback"] = "装甲刀脊野猪"
L["Armored Razzashi Raptor"] = "装甲拉扎什迅猛龙"
L["Ash-Covered Horn"] = "蒙尘号角"
L["Ashes of Al'ar"] = "奥的灰烬"
L["Ashleaf Spriteling"] = "灰叶小林精"
L["Attempts"] = "尝试"
L["Auto"] = "自动"
L["Available starting December 25th"] = "激活开始于 12月 25日"
L["Azure Crane Chick"] = "天青雏鹤"
L["Azure Whelpling"] = "蓝龙宝宝"
L["Battle Horn"] = [=[
战斗号角]=]
L["Battle Pet"] = "战斗宠物们"
L["Battle Pets"] = "战斗宠物"
L["Big Love Rocket"] = "爱情火箭"
L["Black Barracuda School"] = "黑梭鱼群"
L["Black Trillium Deposit"] = "黑色延极矿石"
L["Blackbelly Mudfish School"] = "黑腹泥鱼群"
L["Blackflame Daggers"] = "黑火匕首"
L["Blackfuse Bombling"] = "黑索小炸弹"
L["Blackhoof"] = "黑蹄"
L["Blackrock Deposit"] = "黑石矿脉"
L["Blackwater Whiptail School"] = "黑水鞭尾鱼群"
L["Blackwing Banner"] = "黑翼旗帜"
L["Blank line before tooltip additions"] = "在提示信息新增前空行"
L["Blazing Rune"] = "炽烧符文"
L["Bleakclaw"] = "荒爪"
L["Blessed Seed"] = "祝福之种"
L["Blight Boar Microphone"] = "凋零野猪话筒"
L["Blighted Spore"] = "枯萎孢子"
L["Blind Lake Sturgeon School"] = "盲眼湖鲟鱼群"
L["Bloodsail Wreckage"] = "血帆船只残骸"
L["Bloodsail Wreckage Pool"] = "Обломки кораблекрушения Кровавого Паруса"
L["Bluefish School"] = "蓝鱼群"
L["Bone Serpent"] = "骨蛇"
L["Bonkers"] = "疯癫猴"
L["Borean Man O' War School"] = "北风水母群"
L["Boss Name"] = "Boss名"
L["Bottled Tornado"] = "旋风之瓶"
L["Brackish Mixed School"] = "魔尾鱼群"
L["Brew Frenzied Emperor Salmon"] = "帝王鲑鱼群"
L["Brilliant Phoenix Hawk Feather"] = "灿烂的凤头隼羽毛"
L["Brinedeep Bottom-Feeder"] = "深海喂食者"
L["Bristling Hellboar"] = "钢鬃地狱野猪"
L["Bronze Proto-Whelp"] = "青铜始祖龙宝宝"
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = "Bunny Hunter 正在运行。你现在想要从Bunny Hunter 将数据导入Rarity吗？关闭Bunny Hunter 或如果你不想要再次提示请点击确定。"
L["Burgy Blackheart's Handsome Hat"] = "布尔吉·黑心的时装帽"
L["Call of the Frozen Blade"] = "冰封之刃的召唤"
--Translation missing 
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = "Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."
--Translation missing 
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = "Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."
--Translation missing 
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = "Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."
--Translation missing 
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = "Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."
L["Can be obtained with a bonus roll"] = "可以通过奖励硬币得到"
--Translation missing 
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = "Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."
L["Captured Firefly"] = "被捕获的萤火虫"
L["Cat Carrier (Black Tabby)"] = "猫笼（黑纹灰猫）"
L["Cataclysm"] = "大地的裂变"
L["Cavern Moccasin"] = "洞穴蝮蛇"
--Translation missing 
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = "Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"
--Translation missing 
L["Chain Pet Leash"] = "Chain Pet Leash"
L["Chalice of Secrets"] = "隐秘圣杯"
L["Challenge Mode instance"] = "挑战模式地下城"
L["Chance"] = "概率"
L["Chance so far"] = "目前概率"
L["Chaos Pup"] = "混沌幼崽"
--Translation missing 
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = "Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."
--Translation missing 
L[ [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=] ] = [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=]
--Translation missing 
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = "Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."
L["Christoph VonFeasel"] = "克里斯托弗·冯·费瑟尔 <驯宠宗师>"
L["Chromie"] = "克罗米"
L["Chuck's Bucket"] = "莫莫的小桶"
L["Classic"] = "早期版本"
--Translation missing 
L["Clear All Exports"] = "Clear All Exports"
L["Click to switch to this item"] = "点击以切换到此物品"
L["Click to toggle the progress bar"] = "点击切换进度条"
L["Clockwork Rocket Bot"] = "发条战士"
L["Close"] = "关闭"
L["Cloudwing Hippogryph"] = "云翼角鹰兽"
L["Clutch of Ji-Kun"] = "季鹍之嗣"
L["Cobalt Deposit"] = "钴矿脉"
L["Coin of Many Faces"] = "多面硬币"
L["Collect %d %s"] = "收集 %d %s"
L["Collected"] = "已收集"
L["Collection Complete"] = "收集完毕"
L["Collection complete!"] = "收集完毕！"
L["Collection Size"] = "收集大小"
L["Contained in bonus satchels"] = "由奖励包获得"
--Translation missing 
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = "Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."
--Translation missing 
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = "Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = "包含在酿好的恶心罐装酒中，由狂心氏族崇敬获得，由军需官处购买恶心罐装酒，并等待三天。"
L["Content Category"] = "内容类别"
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = "控制当鼠标悬停在一个物品出现的主要的工具提示的二次提示在哪一边。如果主要的工具提示是在屏幕的右边，改变这一到左。否则,选择右边。你也完全可以隐藏状态提示。"
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = "控制显示在 LDB 接口的 Rarity 文本类型。简单模式只显示尝试次数，普通模式增加显示可能的百分比，完整模式增加显示物品链接。"
L["Copper Vein"] = "铜矿"
--Translation missing 
L[ [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=] ] = [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=]
L["Core of Hardened Ash"] = "硬化岩灰核心"
L["Corrupted Nest Guardian"] = "腐化的巢穴守卫"
--Translation missing 
L["Corrupted Thundertail"] = "Corrupted Thundertail"
L["Crane Nest"] = "鹤巢"
L["Crashin' Thrashin' Cannon Controller"] = "癫狂火炮控制器"
L["Crashin' Thrashin' Flyer Controller"] = "癫狂飞行器遥控器"
L["Crashin' Thrashin' Mortar Controller"] = "癫狂迫击炮控制器"
L["Crashin' Thrashin' Racer Controller"] = "打架赛车控制器"
L["Crashin' Thrashin' Roller Controller"] = "癫狂刺轴战车控制器"
L["Create a New Item"] = "创建一个新物品"
L["Create a new item to track"] = "创建一个新物品以追踪"
L["Creature ID"] = "创造物 ID"
L["Crowded Redbelly Mandarin"] = "红腹鳜鱼群"
L["Crysa"] = "克丽萨"
L["Crystal of the Void"] = "虚空水晶"
L["Ctrl-Click to change sort order"] = "按住 Ctrl+点击 改变排列顺序"
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = "左键点击创建TomTom路点"
L["Ctrl-Click to create TomTom waypoint(s)."] = "点击创建TomTom路点"
--Translation missing 
L["Cupri"] = "Cupri"
--Translation missing 
L["Curious Wyrmtongue Cache"] = "Curious Wyrmtongue Cache"
--Translation missing 
L["Cursed Queenfish School"] = "Cursed Queenfish School"
--Translation missing 
L["Cursed Spirit"] = "Cursed Spirit"
L["Custom"] = "自定义"
L["Dandelion Frolicker"] = "菊苣嬉闹者"
--Translation missing 
L["Dark Gazer"] = "Dark Gazer"
L["Dark Iron Deposit"] = "黑铁矿脉"
L["Dark Quivering Blob"] = "黑色颤动水珠"
L["Dark Whelpling"] = "黑龙宝宝"
L["Darkmoon Eye"] = "暗月之眼"
L["Data has been imported from Bunny Hunter"] = "数据已通过 Bunny Hunter 导入"
L["Death Adder Hatchling"] = "致死小蝰蛇"
L["Death Knight"] = "死亡骑士"
L["Deathcharger's Reins"] = "死亡军马的缰绳"
L["Deathtalon"] = "死爪"
L["Debug mode"] = "调试模式"
L["Debug mode OFF"] = "调试模式*关闭*"
L["Debug mode ON"] = "调试模式*开启*"
L["Decahedral Dwarven Dice"] = "矮人的十面骰"
L["Deep Sea Monsterbelly School"] = "深海巨腹鱼群"
L["Deepsea Sagefish School"] = "深海鼠尾鱼群"
--Translation missing 
L["Defeat Detection"] = "Defeat Detection"
L["Defeated"] = "已击败"
--Translation missing 
L["Defiled Earth"] = "Defiled Earth"
L["Delete this item"] = "删除此物品"
--Translation missing 
L["Demon Hunter"] = "Demon Hunter"
--Translation missing 
L["Demonic"] = "Demonic"
L["Determines how this item is obtained."] = "检测此物品如何获得"
L["Determines what type of item this is."] = "检测此物品是什么类型"
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = "确定该物品是否只能从钓鱼中获得。为了使此选项工作，所有的钓鱼相关项目必须被翻译成你的客户端的语言。"
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = "确定是否同意追踪这个物品。物品无法出现在鼠标提示中。"
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = "确定您是否要反复使用这一物品。如果你打开该功能，找到该项，Rarity在几秒钟后会将物品标记为未发现。"
--Translation missing 
L[ [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=] ] = [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=]
L["Determines which race includes this archaeology project."] = "确定哪个种族含有这个考古学物品。"
L["Deviate Hatchling"] = "变异幼龙"
--Translation missing 
L["Direflame"] = "Direflame"
L["Direhorn Runt"] = "矮化恐角龙"
--Translation missing 
L["Disable for classes"] = "Disable for classes"
L["Disgusting Oozeling"] = "恶心的软泥怪"
--Translation missing 
L["Displacer Meditation Stone"] = "Displacer Meditation Stone"
L["Distance"] = "距离"
--Translation missing 
L["Don Carlos' Famous Hat"] = "Don Carlos' Famous Hat"
--Translation missing 
L["Doomroller"] = "Doomroller"
L["Draenei"] = "德莱尼"
L["Draenor Clans"] = "德拉诺种族"
L["Draenor Garrison"] = "德拉诺要塞"
L["Dragonfin Angelfish School"] = "龙鳞天使鱼群"
--Translation missing 
L["Drakum"] = "Drakum"
--Translation missing 
L["Dreadwalker"] = "Dreadwalker"
L["Dripping Strider Egg"] = "湿漉漉的阔步者之卵"
L["Droplet of Y'Shaarj"] = "亚煞极余孽"
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = "任意人数锦绣谷（未满级除外）。收集10块天之裂片合成天水晶，使用天水晶打败风暴后裔-阿拉尼掉落雷霆红玉云端翔龙缰绳"
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = "击败巨兽岛的恐龙获得蛋，3天后随机孵化成红、绿、黑色原始迅猛龙缰绳。"
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = "采集草药时有小几率取得。采集时有时会刷新被惊扰的魔荚人，也有几率掉落。"
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = "在魔古山宝库击败伊拉贡掉落（随机团队除外）"
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = "通过鬓蜥人保卫者掉落，在德拉诺采矿时也有几率开出。"
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = "在阿尔卡冯的宝库击败烈焰看守者科尔拉隆 ，风暴看守者埃玛尔隆，岩石看守者阿尔卡冯 ，和寒冰看守者图拉旺掉落（任意人数）"
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = "在永恒之眼击败玛里苟斯掉落（任意人数）"
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = "在奥妮克希亚的巢穴击败奥妮克希亚掉落（任意人数）"
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = "在巨龙之魂击败疯狂的死亡之翼掉落（任意难度，任意人数）"
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = "在巨龙之魂击败疯狂的死亡之翼掉落（英雄，任意人数）"
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = "在巨龙之魂击败奥卓克希昂掉落（任意难度，任意人数）"
L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = "奥杜尔（25人）的尤格-萨隆掉落，需要 0 灯"
L["Dropped from dinosaurs on Isle of Giants"] = "巨兽岛的恐龙掉落"
--Translation missing 
L["Dropped from monsters in Fang'rila"] = "Dropped from monsters in Fang'rila"
L["Drops from a boss requiring a group"] = "需要组队首领掉落"
L["Drops from any mob in a zone"] = "区域内任意怪物掉落"
L["Drops from NPC(s)"] = "NPC 掉落"
--Translation missing 
L["Drudge Remains"] = "Drudge Remains"
L["Druid"] = "德鲁伊"
L["Dungeon ID"] = "地下城ID"
L["Dusty Clutch of Eggs"] = "尘封的蛋簇"
L["Dwarf"] = "矮人"
--Translation missing 
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = "Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."
L["Elementium Geode"] = "源质晶簇"
L["Elementium Vein"] = "源质矿"
L["Emperor Salmon School"] = "帝王鲑鱼群"
L["Enable announcements"] = "启用通告"
L["Enable Coins"] = "允许投币"
L["Enable profiling"] = "允许分析"
L["Enable tooltip additions"] = "允许提示信息新增"
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = "启用通知，每当您完成任何 Rarity 追踪中的物品的一次新尝试。您也可以启用每件物品的通知，但这是个总开关。"
L["Enables announcements whenever you complete a new attempt toward this item."] = "启用通知，每当您完成此物品的一次新尝试。"
--Translation missing 
L["Enter 1 or leave this blank to mark the item as soloable."] = "Enter 1 or leave this blank to mark the item as soloable."
L["Equal odds"] = "平等几率"
--Translation missing 
L["Error compressing item pack"] = "Error compressing item pack"
--Translation missing 
L["Error encoding item pack"] = "Error encoding item pack"
--Translation missing 
L["Error serializing item pack"] = "Error serializing item pack"
--Translation missing 
L["Essence of the Breeze"] = "Essence of the Breeze"
L["Eternal Kiln"] = "永恒炭炉"
L["Eternal Warrior's Sigil"] = "不朽武士的印记"
--Translation missing 
L["Everliving Spore"] = "Everliving Spore"
L["Every item ID must be a number greater than 0."] = "每个物品的 ID 都必须大于 0"
L["Every NPC ID must be a number greater than 0."] = "每个NPC的 ID 都必须大于 0"
--Translation missing 
L["Every Quest ID must be a number greater than 0."] = "Every Quest ID must be a number greater than 0."
L["Experiment 12-B"] = "实验体12-B"
--Translation missing 
L["Export"] = "Export"
--Translation missing 
L["Export Rarity Item Pack"] = "Export Rarity Item Pack"
--Translation missing 
L["Export this item"] = "Export this item"
--Translation missing 
L["Eye of Inquisition"] = "Eye of Inquisition"
--Translation missing 
L["Faintly Glowing Flagon of Mead"] = "Faintly Glowing Flagon of Mead"
--Translation missing 
L["Fandral's Seed Pouch"] = "Fandral's Seed Pouch"
L["Fangtooth Herring School"] = "利齿青鱼群"
L["Farwater Conch"] = "远水海螺"
L["Fat Sleeper School"] = "塘鲈鱼群"
--Translation missing 
L["Fathom Dweller"] = "Fathom Dweller"
L["Fathom Eel Swarm"] = "深水鳗鱼群"
L["Feed text"] = "注入文本"
L["Fel Iron Deposit"] = "魔铁矿脉"
--Translation missing 
L["Felfly"] = "Felfly"
--Translation missing 
L["Felslate Deposit"] = "Felslate Deposit"
--Translation missing 
L["Felslate Seam"] = "Felslate Seam"
--Translation missing 
L["Felsteel Annihilator"] = "Felsteel Annihilator"
--Translation missing 
L["Felsworn Sentry"] = "Felsworn Sentry"
L["Feltail School"] = "斑点魔尾鱼群"
--Translation missing 
L["Fever of Stormrays"] = "Fever of Stormrays"
L["Fiery Warhorse's Reins"] = "炽热战马的缰绳"
L["Fire Ammonite School"] = "熔火鱿鱼群"
L["Firefin Snapper School"] = "火鳞鳝鱼群"
L["Firewing"] = "火翼"
--Translation missing 
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = "Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"
L["Flametalon of Alysrazor"] = "奥利瑟拉佐尔的烈焰之爪"
L["Floating Debris"] = "漂浮的碎片"
L["Floating Debris Pool"] = "Обломки в воде"
L["Floating Shipwreck Debris"] = "沉船残骸"
L["Floating Wreckage"] = "漂浮的残骸"
L["Floating Wreckage Pool"] = "漂浮的残骸之池"
L["Font"] = "字体"
L["Font Size"] = "字体大小"
L["Foot Ball"] = "足球"
L["Fossil"] = "化石"
L["Fossilized Raptor"] = "化石迅猛龙"
L["Found after %d attempts!"] = "在尝试 %d 次后找到！"
--Translation missing 
L["Found in: "] = "Found in: "
L["Found on your first attempt!"] = "第一次尝试便获得！"
L["Fox Kit"] = "幼狐"
--Translation missing 
L["Fragment of Anger"] = "Fragment of Anger"
--Translation missing 
L["Fragment of Desire"] = "Fragment of Desire"
--Translation missing 
L["Fragment of Frozen Bone"] = "Fragment of Frozen Bone"
--Translation missing 
L["Fragment of Suffering"] = "Fragment of Suffering"
L["Frenzyheart Brew"] = "狂心美酒"
L["Frightened Bush Chicken"] = "惊恐的灌木小鸡"
L["Fuzzy Green Lounge Cushion"] = "松软的绿色沙发垫"
--Translation missing 
L["Gahz'rooki's Summoning Stone"] = "Gahz'rooki's Summoning Stone"
--Translation missing 
L["Gar'lok"] = "Gar'lok"
L["Garn Nighthowl"] = "夜嚎铁颚狼"
L["Garn Steelmaw"] = "钢喉铁颚狼"
--Translation missing 
L["Garrison Invasion Gold Victory"] = "Garrison Invasion Gold Victory"
--Translation missing 
L["Garrison Invasion Platinum Victory"] = "Garrison Invasion Platinum Victory"
L["Gastropod Shell"] = "蜗牛壳"
L["General"] = "常规"
L["General Options"] = "通用选项"
L["Ghost Iron Deposit"] = "幽冥铁矿脉"
L["Giant Coldsnout"] = "巨型冻吻野猪"
L["Giant Mantis Shrimp Swarm"] = "巨型螳螂虾群"
L["Giant Sewer Rat"] = "巨型下水道老鼠"
--Translation missing 
L["Giant Worm Egg"] = "Giant Worm Egg"
--Translation missing 
L["Gibblette the Cowardly"] = "Gibblette the Cowardly"
L["Glacial Salmon School"] = "冰河鲑鱼群"
L["Glassfin Minnow School"] = "亮鳞鲤鱼群"
--Translation missing 
L["Glimmering Jewel Danio Pool"] = "Glimmering Jewel Danio Pool"
--Translation missing 
L["Glimmering Treasure Chest"] = "Glimmering Treasure Chest"
L["Glittering Arcane Crystal"] = "发光的魔力水晶"
L["Glittering Ball of Yarn"] = "发光的线团"
L["Glowing Jade Lungfish"] = "闪光翠绿肺鱼"
L["Gluth's Bone"] = "格拉斯之骨"
L["Gold Vein"] = "金矿石"
L["Golden Carp School"] = "金色鲤鱼群"
--Translation missing 
L["Gondar"] = "Gondar"
L["Gooey Sha-ling"] = "黏稠的小煞魔"
--Translation missing 
L["Goren \"Log\" Roller"] = "Goren \"Log\" Roller"
L["Great Brewfest Kodo"] = "大型美酒节科多兽"
L["Greater Sagefish School"] = "大型鼠尾鱼群"
--Translation missing 
L["Greatfather Winter's Tree"] = "Greatfather Winter's Tree"
L["Green Helper Box"] = "绿色助手盒"
--Translation missing 
L["Grotesque Statue"] = "Grotesque Statue"
--Translation missing 
L["Group Finder Options"] = "Group Finder Options"
L["Group size"] = "团体大小"
--Translation missing 
L["Group(s) found!"] = "Group(s) found!"
--Translation missing 
L["Grow Up"] = "Grow Up"
L["Grumpling"] = "格噜噜"
--Translation missing 
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = "Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."
L["Gu'chi Swarmling"] = "古赤的蚕宝宝"
--Translation missing 
L["Guk"] = "Guk"
L["Gulp Froglet"] = "幼年巨口蛙"
L["Gundrak Hatchling"] = "古达克幼龙"
L["Half-Empty Food Container"] = "半空的食品容器"
--Translation missing 
L["Hardened Shell"] = "Hardened Shell"
L["Height"] = "高度"
--Translation missing 
L["Helpful Wikky's Whistle"] = "Helpful Wikky's Whistle"
--Translation missing 
L["Here is a preview of what will (or won't) be imported:"] = "Here is a preview of what will (or won't) be imported:"
L["Heroic difficulty"] = "英雄难度"
L["Heroic Raid (10-30 players)"] = "英雄团队 (10-30玩家)"
L["Heroic Scenario instance"] = "英雄场景战役"
L["Heroic, any raid size"] = "史诗，任意团队人数"
L["Hidden"] = "隐藏"
L["Hide defeated items"] = "隐藏已击败的物品"
L["Hide high chance items"] = "隐藏高概率项目"
L["Hide items not in your zone"] = "隐藏不在当前区域的物品"
L["Hide items with no attempts"] = "隐藏未尝试物品"
L["Hide unavailable items"] = "隐藏不可用项目"
--Translation missing 
L["High Priest of Ordos"] = "High Priest of Ordos"
--Translation missing 
L["Highborne"] = "Highborne"
L["Highland Guppy School"] = "高地古比鱼群"
L["Highland Mixed School"] = "高地杂鱼群"
--Translation missing 
L["Highmountain Elderhorn"] = "Highmountain Elderhorn"
--Translation missing 
L["Highmountain Salmon School"] = "Highmountain Salmon School"
--Translation missing 
L["Highmountain Tauren"] = "Highmountain Tauren"
L["Holiday"] = "节日"
L["Holiday reminders"] = "节日提醒"
L["Hollow Reed"] = "空心芦苇"
L["Horde only"] = "仅部落"
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = "物品出现的可能性，显示为 X 分之1，其中 X 是您在此处输入的数字。"
L["How many attempts you've made so far."] = "你目前尝试过多少次"
L["How many items you need to collect."] = "你需要收集多少物品。"
L["How many items you've collected so far."] = "你曾经收集了多少物品。"
L["Hozen Beach Ball"] = "猢狲沙滩球"
L["Huge Obsidian Slab"] = "巨型黑曜石石板"
L["Hunter"] = "猎人"
L["Hyjal Wisp"] = "海加尔小精灵"
L["Ice Chip"] = "寒冰碎片"
L["Identify the Item"] = "鉴定物品"
L["Imbued Jade Fragment"] = "灌魔玉石碎片"
L["Imperial Manta Ray School"] = "帝王鳐鱼群"
L["Imperial Moth"] = "帝蚕蛾"
L["Imperial Silkworm"] = "帝蚕虫"
--Translation missing 
L["Imp-Master Valessa"] = "Imp-Master Valessa"
--Translation missing 
L["Import"] = "Import"
--Translation missing 
L["Import Rarity Item Pack"] = "Import Rarity Item Pack"
--Translation missing 
L["Import/Export"] = "Import/Export"
--Translation missing 
L["imported successfully"] = "imported successfully"
L["Incendicite Mineral Vein"] = "火岩矿脉"
L["Indurium Mineral Vein"] = "精铁矿脉"
--Translation missing 
L["Install TomTom to enable waypoint creation."] = "Install TomTom to enable waypoint creation."
L["Instance Difficulty"] = "副本难度"
L["Instant Arcane Sanctum Security Kit"] = "瞬发奥术圣殿安全包"
L["Invincible's Reins"] = "无敌的缰绳"
L["Iron Deposit"] = "铁矿石"
--Translation missing 
L["Ironbound Collar"] = "Ironbound Collar"
--Translation missing 
L["Ironhoof Destroyer"] = "Ironhoof Destroyer"
L["Item ID"] = "物品 ID"
L["Item ID to Collect"] = "项目 ID 收集"
L["Items to Use"] = "要使用的物品"
L["Jade Lungfish School"] = "翠绿肺鱼群"
L["Jadefire Spirit"] = "玉火焰灵"
L["Jademist Dancer"] = "翠雾舞者"
L["Jawless Skulker School"] = "无颚潜鱼群"
--Translation missing 
L["Jeremy Feasel"] = "Jeremy Feasel"
L["Jewel Danio School"] = "珍宝斑马鱼群"
L["Jewel of Maddening Whispers"] = "恼人低语宝石"
L["Ji-Kun Hatchling"] = "季鹍雏凤"
L["Jingling Bell"] = "圣诞铃铛"
--Translation missing 
L["Kael'thas Sunstrider"] = "Kael'thas Sunstrider"
L["Kaldorei Light Globe"] = "卡多雷光球"
L["Kal'tik the Blight"] = "凋零的卡尔提克"
L["Kang's Bindstone"] = "康的束缚石"
L["Khorium Vein"] = "氪金矿脉"
L["Kill Statistic IDs"] = "杀死统计  IDs"
L["Knockoff Blingtron"] = "冒牌布林顿"
L["Kor'kron Juggernaut"] = "库卡隆战蝎"
L["Kovok"] = "科沃克"
L["Krasarang Paddlefish School"] = "卡桑琅白鲟鱼群"
L["Kyparite Deposit"] = "凯帕琥珀矿脉"
--Translation missing 
L["Land Shark"] = "Land Shark"
L["Large Obsidian Chunk"] = "大型黑曜石碎块"
--Translation missing 
L["Large Pool of Brew Frenzied Emperor Salmon"] = "Large Pool of Brew Frenzied Emperor Salmon"
--Translation missing 
L["Large Pool of Crowded Redbelly Mandarin"] = "Large Pool of Crowded Redbelly Mandarin"
--Translation missing 
L["Large Pool of Glimmering Jewel Danio Pool"] = "Large Pool of Glimmering Jewel Danio Pool"
--Translation missing 
L["Large Pool of Glowing Jade Lungfish"] = "Large Pool of Glowing Jade Lungfish"
--Translation missing 
L["Large Pool of Sha-Touched Spinefish"] = "Large Pool of Sha-Touched Spinefish"
--Translation missing 
L["Large Pool of Tiger Gourami Slush"] = "Large Pool of Tiger Gourami Slush"
--Translation missing 
L["Large Swarm of Migrated Reef Octopus"] = "Large Swarm of Migrated Reef Octopus"
--Translation missing 
L["Large Swarm of Panicked Paddlefish"] = "Large Swarm of Panicked Paddlefish"
--Translation missing 
L["Large Tangled Mantis Shrimp Cluster"] = "Large Tangled Mantis Shrimp Cluster"
L["Last Month"] = "上个月"
L["Last Week"] = "上周"
L["Left"] = "左"
L["Legion"] = "军团"
L["Lesser Bloodstone Deposit"] = "次级血石矿脉"
L["Lesser Firefin Snapper School"] = "次级火鳞鳝鱼群"
L["Lesser Floating Debris"] = "次级漂浮的碎片"
L["Lesser Oily Blackmouth School"] = "次级黑口鱼群"
L["Lesser Sagefish School"] = "次级鼠尾鱼群"
--Translation missing 
L["Leviathan Egg"] = "Leviathan Egg"
--Translation missing 
L["Ley Spider Eggs"] = "Ley Spider Eggs"
--Translation missing 
L["Leystone Deposit"] = "Leystone Deposit"
--Translation missing 
L["Leystone Seam"] = "Leystone Seam"
--Translation missing 
L["Leywoven Flying Carpet"] = "Leywoven Flying Carpet"
L["Life-Binder's Handmaiden"] = "生命缚誓者的仆从"
L["Likelihood"] = "可能性"
L["Lil' Bling"] = "小布"
--Translation missing 
L["Living Infernal Core"] = "Living Infernal Core"
L["Living Sandling"] = "活化小沙粒"
L["Loaded (running in debug mode)"] = "已加载（调试模式正在运行）"
L["Loaded Gnomish Dice"] = "侏儒老千的骰子"
L["Loading"] = "正在加载"
L["Locked"] = "已锁定"
L["Looking For Raid (10-30 players)"] = "随机团队 (10-30玩家)"
L["Luckiness"] = "运气"
L["Lucky"] = "幸运"
L["lucky"] = "走运"
L["Lucky if you obtain in %d or less"] = "如果少于 %d 次就获得则走运"
L["Lump of Coal"] = "小煤头"
--Translation missing 
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = "Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."
L["Mage"] = "法师"
--Translation missing 
L["Magnataur Hunting Horn"] = "Magnataur Hunting Horn"
--Translation missing 
L["Major Nanners"] = "Major Nanners"
L["Mantid"] = "螳螂妖"
L["Mark of Flame"] = "烈焰印记"
L["Method of obtaining"] = "获取方法"
--Translation missing 
L["Midnight's Eternal Reins"] = "Midnight's Eternal Reins"
L["Mimiron's Head"] = "米米尔隆的头部"
L["Minimal"] = "最小"
L["Minion of Grumpus"] = "格噜普斯的爪牙"
L["MiniZep Controller"] = "迷你飞艇控制器"
--Translation missing 
L["Mirecroak"] = "Mirecroak"
L["Mists of Pandaria"] = "熊猫人之谜"
L["Mithril Deposit"] = "秘银矿脉"
L["Mogu"] = "魔古"
L["Mojo"] = "魔汁"
L["Monk"] = "武僧"
L["Moon Moon"] = "月月"
--Translation missing 
L["Moonfang"] = "Moonfang"
L["Moonfang Shroud"] = "月牙头饰"
L["Moonfang's Paw"] = "月牙的爪子"
L["Moonglow Cuttlefish School"] = "月光墨鱼群"
--Translation missing 
L["Mossgill Perch School"] = "Mossgill Perch School"
L["Mount"] = "坐骑"
L["Mountain Panda"] = "高山小熊猫"
L["Mountain Trout School"] = "高山鲑鱼群"
L["Mounts"] = "坐骑"
L["Mr. Grubbs"] = "胖虫先生"
L["Mr. Pinchy"] = "钳子先生"
L["Mr. Smite's Brass Compass"] = "重拳先生的铜罗盘"
L["Muckbreaths's Bucket"] = "毒皮的小桶"
L["Muddy Churning Water"] = "混浊的水"
L["Mudfish School"] = "泥鱼群"
L["Musselback Sculpin School"] = "蚌背鱼群"
--Translation missing 
L["Muyani"] = "Muyani"
L["Mysterious Camel Figurine"] = "神秘的骆驼雕像"
L["Mythic 5-player instance"] = "5人史诗副本"
L["Mythic difficulty"] = "史诗难度"
L["Mythic Raid (20 player)"] = "史诗团队 (10-30玩家)"
L["Nerubian"] = "蛛魔"
--Translation missing 
L["Nerubian Relic"] = "Nerubian Relic"
--Translation missing 
L["Nessos the Oracle"] = "Nessos the Oracle"
L["Nethercite Deposit"] = "虚空矿脉"
--Translation missing 
L["Netherfist"] = "Netherfist"
L["Netherspace Portal-Stone"] = "虚空传送石"
L["Nettlefish School"] = "水母鱼群"
L["New item"] = "新物品"
L["Night Elf"] = "暗夜精灵"
--Translation missing 
L["Nightmare Bell"] = "Nightmare Bell"
--Translation missing 
L["Nightmare Whelpling"] = "Nightmare Whelpling"
L["Nightshade Sproutling"] = "夜影幼苗"
--Translation missing 
L[ [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=] ] = [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=]
L["None"] = "无"
L["None (not in an instance)"] = "无(无需副本)"
L["Normal"] = "正常"
L["Normal Raid (10-30 players)"] = "普通团队 (10-30玩家)"
--Translation missing 
L["not imported"] = "not imported"
L["NPCs"] = true
L["Obsidium Deposit"] = "黑曜石碎块"
L["Obtained Achievement ID"] = "已获取成就ID"
L["Obtained After %d Attempts"] = "在尝试 %d 次后获得"
L["Obtained as a rare project for the Fossil branch of archaeology"] = "通过考古学上的稀有分支获得"
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = "通过非常稀有的托维尔考古分支获得"
L["Obtained as an archaeology project"] = "通过考古获得"
L["Obtained by collecting a number of items"] = "通过收集获得的物品"
L["Obtained by fishing"] = "由钓鱼获得"
L["Obtained by fishing in any water in Ironforge"] = "在铁炉堡任意水域钓鱼获得"
L["Obtained by fishing in any water in Orgrimmar"] = "在奥格瑞玛的任意水域钓鱼获得"
L["Obtained by fishing in pools located in Terrokar Forest"] = "在泰罗卡森林钓鱼获得"
L["Obtained by mining"] = "由采矿获得"
L["Obtained by mining Elementium Vein"] = "源质矿石制作"
L["Obtained by opening Crane Nests on the Timeless Isle"] = "在永恒岛开启鹤巢获得"
--Translation missing 
L["Obtained by opening Snow Mound in Frostfire Ridge"] = "Obtained by opening Snow Mound in Frostfire Ridge"
L["Obtained by opening Timeless Chests on the Timeless Isle"] = "在永恒岛开启永恒宝箱获得"
L["Obtained by using an item or opening a container"] = "通过使用物品或者打开容器获得"
L["Obtained On Your First Attempt"] = "在第一次尝试后获得"
L["Obtained Quest ID"] = "已获取任务ID"
--Translation missing 
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = "Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"
L["Odd Polished Stone"] = "古怪的抛光石"
L["Ogre"] = "食人魔"
L["Oil Spill"] = "油井"
L["Oily Abyssal Gulper School"] = "Косяк масляного глубинного угря-мешкорота"
L["Oily Blackmouth School"] = "黑口鱼群"
L["Oily Sea Scorpion School"] = "Косяк жирных морских скорпионов"
L["Old Crafty"] = "老滑头"
L["Old Ironjaw"] = "老铁腭"
--Translation missing 
L["Old Man Barlo"] = "Old Man Barlo"
L["Ominous Flame"] = "不祥焰灵"
--Translation missing 
L["Ominous Pile of Snow"] = "Ominous Pile of Snow"
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = "你输入的一个地图 ID(%s)不正确。请输入一个大于0的数字。"
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = "一个你输入(%s)的地区或分区未找到。检查输入是否正确，是否是美式英语或客户端本地语言。"
--Translation missing 
L["Only announce when found"] = "Only announce when found"
L["Only Raid Finder difficulty"] = "只有随机团队难度"
L["Ooze Covered Gold Vein"] = "软泥覆盖的金矿脉"
L["Ooze Covered Mithril Deposit"] = "软泥覆盖的秘银矿脉"
L["Ooze Covered Rich Thorium Vein"] = "软泥覆盖的富瑟银矿脉"
L["Ooze Covered Silver Vein"] = "软泥覆盖的银矿脉"
L["Ooze Covered Thorium Vein"] = "软泥覆盖的瑟银矿脉"
L["Ooze Covered Truesilver Deposit"] = "软泥覆盖的真银矿脉"
L["Options"] = "选项"
--Translation missing 
L["Orb of the Sin'dorei"] = "Orb of the Sin'dorei"
L["Orc"] = "兽人"
--Translation missing 
L["Orphaned Felbat"] = "Orphaned Felbat"
L["Other"] = "其它"
L["Other Requirements"] = "其他需求"
--Translation missing 
L["Overcomplicated Controller"] = "Overcomplicated Controller"
L["Paladin"] = " 圣骑士"
L["Pandaren"] = "熊猫人"
L["Pandaren Firework Launcher"] = "熊猫人焰火发射器"
L["Panflute of Pandaria"] = "潘达利亚排箫"
L["Parrot Cage (Green Wing Macaw)"] = "鹦鹉笼（绿翼鹦鹉）"
L["Parrot Cage (Hyacinth Macaw)"] = "鹦鹉笼（花羽鹦鹉）"
--Translation missing 
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = "Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."
L["Patch of Elemental Water"] = "元素之水"
--Translation missing 
L["Periwinkle Calf"] = "Periwinkle Calf"
L["Phoenix Hatchling"] = "凤凰宝宝"
L["Pineapple Lounge Cushion"] = "菠萝形沙发垫游戏中展示"
--Translation missing 
L["Play a sound when groups are found"] = "Play a sound when groups are found"
L["Players have a personal loot chance to obtain this item."] = "玩家有个人的拾取机率来获得此物品"
L["Please enter a comma-separated list of item IDs."] = "请输入一个物品的ID列表并使用逗号分隔。"
L["Please enter a comma-separated list of NPC IDs."] = "请输入一个NPC的ID列表并使用逗号分隔。"
--Translation missing 
L["Please enter a comma-separated list of Quest IDs."] = "Please enter a comma-separated list of Quest IDs."
L["Please enter a comma-separated list of Statistic IDs."] = "请输入一个用逗号分隔的统计 ID 列表。"
L["Please enter a comma-separated list of zones."] = "请输入一个地区列表并使用逗号分隔。"
L["Pool of Fire"] = "火池"
L["Porcupette"] = "豪猪仔"
L["Priest"] = "牧师"
L["Primal Egg"] = "原始恐龙蛋"
--Translation missing 
L["Primary tooltip hide delay"] = "Primary tooltip hide delay"
L["Primary tooltip scale"] = "Primary提示信息缩放"
L["Profile modified, rebooting"] = "配置已修改，正在重启"
L["Profiling OFF"] = "建立档案 关闭"
L["Profiling ON"] = "建立档案 开启"
L["Progress"] = "进程"
L["Progress Bar"] = "进度条"
L["Puddle Terror"] = "泥水恐魔"
--Translation missing 
L["Pugg"] = "Pugg"
--Translation missing 
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = "Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."
L["Pure Saronite Deposit"] = "纯净的萨隆邪铁矿脉"
L["Pure Water"] = "纯水"
--Translation missing 
L["Put \"Rarity:\" on a separate line"] = "Put \"Rarity:\" on a separate line"
--Translation missing 
L["Putricide's Alchemy Supplies"] = "Putricide's Alchemy Supplies"
L["Pygmy Direhorn"] = "迷你恐角龙"
L["Pyrite Deposit"] = "燃铁矿脉"
L["Quest ID"] = "任务ID"
L["Quivering Blob"] = "颤动水珠"
L["Raid Finder instance (legacy content; fixed at 25 players)"] = "团队查找随机副本 (旧副本; 最多25人)"
L["Raid Finder or Flexible difficulty"] = "随机团队或弹性副本难度"
--Translation missing 
L["Rarity has %d |4coordinate:coordinates; for this item."] = "Rarity has %d |4coordinate:coordinates; for this item."
L["Rarity is loading..."] = "正载入Rarity……"
--Translation missing 
L["Rarity Item Pack String"] = "Rarity Item Pack String"
L["Rarity Tooltip Options"] = " Rarity提示信息选项"
L["Rarity: "] = "Rarity："
L["Razzashi Hatchling"] = "拉扎什幼龙"
L["Red Goren Egg"] = "红色鬣蜥人蛋"
L["Red Helper Box"] = "红色助手盒"
L["Red Qiraji Resonating Crystal"] = "红色其拉共鸣水晶"
L["Redbelly Mandarin School"] = "红腹鳜鱼"
--Translation missing 
L["Red-Hot Coal"] = "Red-Hot Coal"
L["Reef Octopus Swarm"] = "八爪鱼群"
L["Reins of the Amber Primordial Direhorn"] = "珀光原始恐角龙缰绳"
L["Reins of the Astral Cloud Serpent"] = "星光云端翔龙缰绳"
L["Reins of the Azure Drake"] = "碧蓝幼龙的缰绳"
L["Reins of the Black Primal Raptor"] = "黑色原始迅猛龙缰绳"
L["Reins of the Blazing Drake"] = "炽炎幼龙的缰绳"
L["Reins of the Blue Drake"] = "蓝色幼龙的缰绳"
L["Reins of the Blue Proto-Drake"] = "蓝色始祖幼龙的缰绳"
L["Reins of the Bone-White Primal Raptor"] = "白色原始迅猛龙缰绳"
L["Reins of the Cobalt Primordial Direhorn"] = "冰蓝原始恐角龙缰绳"
L["Reins of the Crimson Water Strider"] = "猩红水黾缰绳"
L["Reins of the Drake of the North Wind"] = "北风幼龙缰绳"
L["Reins of the Drake of the South Wind"] = "南风幼龙缰绳"
L["Reins of the Grand Black War Mammoth"] = "重型黑色猛犸战象的缰绳"
L["Reins of the Green Primal Raptor"] = "绿色原始迅猛龙缰绳"
L["Reins of the Green Proto-Drake"] = "绿色始祖幼龙的缰绳"
L["Reins of the Grey Riding Camel"] = "灰色骑乘骆驼缰绳"
L["Reins of the Heavenly Onyx Cloud Serpent"] = "神圣玛瑙云端翔龙缰绳"
L["Reins of the Infinite Timereaver"] = "永恒时空撕裂者的缰绳"
L["Reins of the Jade Primordial Direhorn"] = "翡翠原始恐角龙缰绳"
L["Reins of the Onyxian Drake"] = "奥妮克希亚座龙缰绳"
L["Reins of the Raven Lord"] = "乌鸦之神的缰绳"
L["Reins of the Slate Primordial Direhorn"] = "岩灰原始恐角龙缰绳"
L["Reins of the Thundering Cobalt Cloud Serpent"] = "雷霆蓝晶云端翔龙缰绳"
L["Reins of the Thundering Onyx Cloud Serpent"] = "雷霆玛瑙云端翔龙缰绳"
L["Reins of the Vitreous Stone Drake"] = "琉璃石幼龙缰绳"
L["Reins of the White Polar Bear"] = "白色北极熊的缰绳"
--Translation missing 
L["Remains of a Blood Beast"] = "Remains of a Blood Beast"
L["Repeatable"] = "可重复"
L["Required for %s"] = "需要 %s"
L["Requires a pool"] = "需要一个共享"
L["Requires Pickpocketing"] = "需要偷窃"
L["Rich Adamantite Deposit"] = "富精金矿脉"
L["Rich Blackrock Deposit"] = "富黑石矿脉"
L["Rich Cobalt Deposit"] = "富钴矿脉"
L["Rich Elementium Vein"] = "富源质矿"
--Translation missing 
L["Rich Felslate Deposit"] = "Rich Felslate Deposit"
L["Rich Ghost Iron Deposit"] = "富幽冥铁矿脉"
L["Rich Kyparite Deposit"] = "富凯帕琥珀矿脉"
--Translation missing 
L["Rich Leystone Deposit"] = "Rich Leystone Deposit"
L["Rich Obsidium Deposit"] = "巨型黑曜石石板"
L["Rich Pyrite Deposit"] = "富燃铁矿脉"
L["Rich Saronite Deposit"] = "富萨隆邪铁矿脉"
L["Rich Thorium Vein"] = "富瑟银矿"
L["Rich Trillium Vein"] = "富延极矿脉"
L["Rich True Iron Deposit"] = "富真铁矿脉"
L["Riding Turtle"] = "乌龟坐骑"
L["Right"] = "右"
L["Right-Aligned"] = "右对齐"
L["Rime of the Time-Lost Mariner"] = "迷时水手结晶"
L["Rogue"] = "盗贼"
L["Rotten Helper Box"] = "腐化助手盒"
L["Ruby Droplet"] = "红玉小水滴"
--Translation missing 
L["Rukdug"] = "Rukdug"
--Translation missing 
L["Runescale Koi School"] = "Runescale Koi School"
L["Sack of Spectral Spiders"] = "一袋幽灵蜘蛛"
L["Safari Lounge Cushion"] = "迷彩沙发垫"
L["Sagefish School"] = "鼠尾鱼群"
--Translation missing 
L["Sahn Tidehunter"] = "Sahn Tidehunter"
--Translation missing 
L["Salyin Battle Banner"] = "Salyin Battle Banner"
--Translation missing 
L["Salyin Warscout"] = "Salyin Warscout"
L["Saronite Deposit"] = "萨隆邪铁矿脉"
--Translation missing 
L["Sassy Imp"] = "Sassy Imp"
L["Satyr Charm"] = "萨特护符"
L["Savage Cub"] = "凶蛮虎崽"
L["Savage Piranha Pool"] = "Пруд свирепых пираний"
L["Scale"] = "比例"
L["Scenario instance"] = "场景战役"
L["Scepter of Azj'Aqir"] = "阿兹亚基节杖"
L["School of Darter"] = "金镖鱼群"
L["School of Deviate Fish"] = "变异鱼群"
L["School of Tastyfish"] = "可口鱼"
L["Schooner Wreckage"] = "帆船残骸"
L["Schooner Wreckage Pool"] = "Разбитая шхуна"
L["Scorched Stone"] = "灼烧石"
--Translation missing 
L["Scraps"] = "Scraps"
--Translation missing 
L["Sea Calf"] = "Sea Calf"
L["Sea Pony"] = "小海马"
L["Sea Scorpion School"] = "Косяк морских скорпионов"
L["Sea Turtle"] = "海龟"
L["Seaborne Spore"] = "海生孢子"
L["Secondary tooltip display"] = "Secondary提示信息显示"
L["Servant of Demidos"] = "戴米多斯的仆从"
L["Servant's Bell"] = "仆从的摇铃"
L["Session"] = "进程"
--Translation missing 
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = "Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."
L["Shadowhide Pearltusk"] = "暗皮珠齿象"
L["Shaman"] = "萨满"
L["Shard of Supremus"] = "苏普雷姆斯残片"
L["Sha-Touched Spinefish"] = "霸王刺皮鱼"
L["Shell of Tide-Calling"] = "唤潮海贝"
L["Shift-Click to link your progress to chat"] = "按住 Shift+点击 发送到聊天框"
L["Shift-Click to open options"] = "按住 Shift+点击 打开设置"
L["Shipwreck Debris"] = "船只残骸"
L["Show anchor"] = "显示锚点"
L["Show attempts in tooltips"] = "在提示信息显示尝试次数"
--Translation missing 
L["Show auto refresh checkbox"] = "Show auto refresh checkbox"
L["Show category icons"] = "显示类别图标"
L["Show Icon"] = "显示图标"
--Translation missing 
L["Show Luckiness column"] = "Show Luckiness column"
L["Show minimap icon"] = "显示小地图图标"
L["Show Text"] = "显示文本"
--Translation missing 
L["Show Time column"] = "Show Time column"
--Translation missing 
L["Show Zone column"] = "Show Zone column"
L["Silver Vein"] = "银矿"
L["Silver-Plated Turkey Shooter"] = "镀银火鸡枪"
L["Since last drop"] = "自从上次掉落"
--Translation missing 
L["Sira's Extra Cloak"] = "Sira's Extra Cloak"
L["Skrillix"] = "斯格里克斯"
L["Skull of a Frozen Whelp"] = "冻死的雏龙颅骨"
L["Skunky Alemental"] = "酒灵臭臭"
L["Sky-Bo"] = "飞天切割者"
L["Skyshard"] = "天之裂片"
L["Slithershock Elver"] = "滑震幼鳗"
L["Small Obsidian Chunk"] = "小型黑曜石碎块"
L["Small Thorium Vein"] = "瑟银矿脉"
L["Smashum Grabb"] = "萨姆逊·强掠 <血环之拳>"
L["Smelly Gravestone"] = "腐臭墓碑"
L["Smoky Direwolf"] = "烟灰恐狼"
L["Smoldering Egg of Millagazor"] = "火鹰蛋"
L["Snarly's Bucket"] = "尼尼的小桶"
--Translation missing 
L["Snow Mound"] = "Snow Mound"
L["Snowman Kit"] = "雪孩子工具包"
L["Snowy Panda"] = "雪色小熊猫"
L["Solar Spirehawk"] = "日光峰林飞鹰"
L["Son of Animus"] = "意志之子"
L["Son of Galleon's Saddle"] = "炮舰之子鞍座"
L["Sorting by category, then name"] = "使用名称分类"
L["Sorting by difficulty"] = "根据难度排序"
L["Sorting by name"] = "根据名字排序"
L["Sorting by percent complete"] = "根据完成百分比排序"
L["Sorting by zone"] = "按区域搜索"
L["Sparse Firefin Snapper School"] = "稀疏的火鳞鳝鱼群"
L["Sparse Oily Blackmouth School"] = "稀疏的黑口鱼群"
L["Sparse Schooner Wreckage"] = "稀疏的帆船残骸"
L["Spawn of Horridon"] = "赫利东的子嗣"
L["Special case"] = "特别案例"
L["Spectral Bell"] = "幽灵铃铛"
L["Spell ID"] = "法术 ID"
L["Spiky Collar"] = "镶钉项圈"
L["Spineclaw Crab"] = "钳爪小螃蟹"
L["Spinefish School"] = "刺皮鱼"
L["Sporefish School"] = "孢子鱼群"
L["Sprite Darter Egg"] = "精龙的蛋"
L["Statistics"] = "统计"
L["Steam Pump Flotsam"] = "蒸汽泵废料"
L["Sting Ray Pup"] = "钉刺鳐鱼幼崽"
L["Stonescale Eel Swarm"] = "石鳞鳗群"
L["Stormforged Rune"] = "雷铸符文"
L["Strand Crawler"] = "沙滩蟹"
L["Strange Pool"] = "奇怪的水池"
L["Sultry Grimoire"] = "热辣魔典"
L["Sun Sproutling"] = "阳光幼苗"
L["Sunblade Rune of Activation"] = "微型炎刃防御者"
L["Sunfire Kaliri"] = "阳炎卡利鸟"
L["Sunfur Panda"] = "棕色小熊猫"
L["Swarm of Panicked Paddlefish"] = "一群恐慌的白鲟鱼"
L["Swift Brewfest Ram"] = "迅捷美酒节赛羊"
L["Swift White Hawkstrider"] = "迅捷白色陆行鸟"
L["Swift Zulian Panther"] = "迅捷祖立安黑豹"
L["Syd the Squid"] = "“乌贼”希德"
L["Tainted Core"] = "污染之核"
L["Tainted Maulclaw"] = "污秽巨螯蟹"
L["Take screenshots"] = "自动截图"
L["Tangled Mantis Shrimp Cluster"] = "一袋巨型螳螂虾"
L["Teeming Firefin Snapper School"] = "拥挤的火鳞鳝鱼群"
L["Teeming Floating Wreckage"] = "拥挤的漂浮残骸"
L["Teeming Oily Blackmouth School"] = "拥挤的黑口鱼群"
L["Terrorfist"] = "泰罗菲斯特 <考莫克之子>"
L["Texture"] = "纹理"
--Translation missing 
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = "The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."
L["The Burning Crusade"] = "燃烧的远征"
--Translation missing 
L["The following %d item(s) have been selected to export:"] = "The following %d item(s) have been selected to export:"
L["The Heartbreaker"] = "裂心者"
L["The Horseman's Reins"] = "无头骑士的缰绳"
--Translation missing 
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = "The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = "这个物品 ID 正在追踪。这个物品它出现在你的仓库或掉落窗口。使用 WowHead 或类似的服务查找物品 ID。这必须是一个有效数字并是唯一的。"
L["The name you entered is already being used by another item. Please enter a unique name."] = "你输入的名字已经被其他物品使用。请重新输入。"
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = "这记录你召唤宠物的 ID。这用于跟踪账号内的战斗宠物。"
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = "根据玩家人数获得物品。这会降低你获得这个物品的机会。"
L["The Pigskin"] = "橄榄球"
--Translation missing 
L["The quest starter item for Reins of the Llothien Prowler"] = "The quest starter item for Reins of the Llothien Prowler"
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = "Rarity Options 模块已被禁用。注销并在你的插件列表中启用它"
--Translation missing 
L["The selected Rarity Item Pack string is invalid."] = "The selected Rarity Item Pack string is invalid."
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = "这个技能 ID 你已经学过一次。这仅适用于坐骑和玩具，类似技能一样出现在你的玩具箱里。使用 WowHead 或类似的服务查找物品 ID。这必须是一个有效数字并是唯一的。"
--Translation missing 
L["The Warbringer will be riding the mount color he has a chance to drop."] = "The Warbringer will be riding the mount color he has a chance to drop."
L["There are more holiday items available, but Rarity only reminds you about the first two."] = "有太多节日物品生效了，但 Rarity 只提醒首先生效的 2 个。"
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = "这些控制选项出现在 Rarity 的主要提示上。他们介绍了物品如何分类（节日物品有一个单独的类别）。关闭这些复选框不会关闭跟踪中的任何物品类别；它只是隐藏的物品工具提示，以帮助你减少物品的数量。"
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = "这个奖励包由完成暗月马戏团的杰里米·费舍尔的日常宠物对战获得。"
--Translation missing 
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = "This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."
--Translation missing 
L["This causes Rarity to put a blank line above its tooltip additions."] = "This causes Rarity to put a blank line above its tooltip additions."
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = "这个物品有 4 分之 1的几率从高戈纳尔身上掉落，一个永恒岛的稀有精英。它也有 250 分之 1 的机会从永恒岛被侵蚀的崖居者身上掉落。"
L["This item is only available to Alliance players."] = "此物品只有联盟玩家可用。"
L["This item is only available to Horde players."] = "此物品只有部落玩家可用。"
L["This mount is only obtainable by Alliance players"] = "此坐骑只有联盟玩家可获得"
L["This mount is only obtainable by Horde players"] = "此坐骑只有部落玩家可获得"
--Translation missing 
L["This tab lets you import and export items into and out of your Custom tab."] = "This tab lets you import and export items into and out of your Custom tab."
--Translation missing 
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = "This was a guaranteed drop for players who defeated the encounter when it was current"
L["Tiger Gourami School"] = "虎皮丝足鱼群"
L["Tiger Gourami Slush"] = "虎皮丝足鱼群"
L["Time"] = "时间"
L["Time spent farming"] = "耗时采集"
L["Timeless Chest"] = "永恒宝箱"
L["Time-Locked Box"] = "锁时之盒"
L["Time-Lost Figurine"] = "迷失雕像"
L["Timewalker 5-player instance"] = "5人随机时空漫游地下城"
L["Tin Vein"] = "锡矿"
L["Tiny Crimson Whelpling"] = "红龙宝宝"
L["Tiny Emerald Whelpling"] = "绿龙宝宝"
L["Tiny Fel Engine Key"] = "迷你邪能钥匙"
L["Titanium Vein"] = "泰坦神铁矿脉"
L[ [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=] ] = "要创建一个新物品，输入一个物品的单独名称，并且点击OK。如果服务器没有回报此物品连结或是物品是无效的则名称已经被使用了。"
--Translation missing 
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = "To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."
--Translation missing 
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = "To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."
L["Today"] = "今天"
L["Toggles"] = "切换"
L["Tol'vir"] = "托维尔"
--Translation missing 
L["Tooltip can't be shown in combat"] = "Tooltip can't be shown in combat"
L["Toothy's Bucket"] = "牙牙的小桶"
L["Torn Invitation"] = "撕毁的请柬"
L["Total"] = "总计"
L["Total found"] = "总共找到"
L["Toxic Wasteling"] = "毒毒"
L["Toy or Item"] = "玩具和道具"
L["Toys & Items"] = "玩具和道具"
L["Track this"] = "追踪这个"
L["Trillium Vein"] = "延极矿脉"
L["Troll"] = "巨魔"
L["True Iron Deposit"] = "真铁矿脉"
L["Truesilver Deposit"] = "真银矿石"
L["Tundra Icehoof"] = "苔原冰蹄牛"
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = "打开，如果物品需要组队获得,但每个玩家有相同机会获得物品。目前只适用于某些节日坐骑。当你打开这个，Rarity 会停止降低你基于队伍人数来获得物品的机会。"
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = "打开小地图图标。如果你没有使用LDB隐藏插件请使用这个设置。"
L["Type of item"] = "物品类型"
--Translation missing 
L["Unable to retrieve item information from the server"] = "Unable to retrieve item information from the server"
L["Unavailable"] = "未获得"
L["Undefeated"] = "未曾击败"
L["Unknown"] = "未知"
L["Unlucky"] = "不走运"
L["unlucky"] = "不走运"
L["Unscathed Egg"] = "完好的蛋"
L["Unstable Powder Box"] = "不稳定的化妆盒"
L["Unusual Compass"] = "不寻常的指南针"
L["Use your bonus roll for a chance at this item"] = "使用你的奖励硬币来获取物品。"
L["Usually requires a group of around %d players"] = "通常需要一组大约 %d 玩家"
L["Valarjar Stormwing"] = "瓦拉加尔风暴之翼幼龙"
--Translation missing 
L["Vengeance"] = "Vengeance"
L["Verbose"] = "冗长"
L["Vibrating Arcane Crystal"] = "震荡的魔力水晶"
L["Vile Blood of Draenor"] = "德拉诺污血怪"
L["Viscidus Globule"] = "维希度斯小水滴"
L["Void Collar"] = "虚空项圈"
L["Vrykul"] = "维库"
L["Warlock"] = "术士"
L["Warlords of Draenor"] = "德拉诺之王"
L["Warm Arcane Crystal"] = "发热的魔力水晶"
L["Warning Sign"] = "警告标志"
L["Warrior"] = "战士"
L["Warsong Direfang"] = "战歌恐牙狼"
L["Waterlogged Wreckage"] = "浸水的残骸"
L["Waterlogged Wreckage Pool"] = "Плавающие обломки"
L["Weebomination"] = "迷你憎恶"
L["Welcome to Rarity r%d. Your settings have been reset."] = "欢迎使用 Rarity r%d. 您的设置已被重置。"
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = "当在90秒内为这个物品使用好运护符时，会计算为另一个尝试。只有使用硬币会获得的物品有效。"
L["When enabled, Rarity tooltips will include how many attempts you've made."] = "当启用时，Rartiy 的提示将包括你尝试的次数。"
--Translation missing 
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = "When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = "当激活时，不论是否可能，不论何时，Rarity将可获得的道具加入游戏提示"
--Translation missing 
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = "When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = "当激活时，某些事情发生时Rarity 将会在聊天窗口显示调试信息。这被用于探测某个模块代码缓慢。"
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = "当取消时，物品将会被标记为只能通过偷窃取得。这项物品将会被标记为非盗贼玩家无法取得。"
--Translation missing 
L["When on, items marked as Defeated will be hidden from the tooltip."] = "When on, items marked as Defeated will be hidden from the tooltip."
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = "当启用时，将隐藏物品提示。这样一来，只有在节日才能激活的物品将不会自动提示激活。"
--Translation missing 
L["When on, items that have no attempts yet will be hidden from the tooltip."] = "When on, items that have no attempts yet will be hidden from the tooltip."
--Translation missing 
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = "When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."
L[ [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=] ] = "当启用时，Rarity 会提醒你未曾获得的节日物品。（只工作在有节日地下城或日常时）。当你每次登陆或重载 UI 时提醒，当你完成节日地下城或完成节日日常之后会停止提醒。"
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = "当启用时，Rarity 将在每一个物品上显示图标。"
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = "当勾选时，你获得一个物品成就时 ，Rarity 将会自动截图。"
--Translation missing 
L["When on, the Luckiness column will be shown in the main tooltip."] = "When on, the Luckiness column will be shown in the main tooltip."
--Translation missing 
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = "When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."
--Translation missing 
L["When on, the Time column will be shown in the main tooltip."] = "When on, the Time column will be shown in the main tooltip."
--Translation missing 
L["When on, the Zone column will be shown in the main tooltip."] = "When on, the Zone column will be shown in the main tooltip."
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = "当勾选时，这个选项会隐藏任何掉落几率在 49 分之 1 以上的物品。为了保持它的干净，这项物品仅从隐藏鼠标提示隐藏。使用这种方式隐藏的话仍在跟踪的项目依旧正常"
--Translation missing 
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = "When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."
L["Whistle of Chromatic Bone"] = "彩色骨哨 "
L["White Trillium Deposit"] = "白色延极矿石"
L["Width"] = "宽度"
L["Wild Dreamrunner"] = "野生梦境角马"
L["Wild Goretusk"] = "野生血牙野猪"
--Translation missing 
L["will be imported"] = "will be imported"
L["Will only drop for druids."] = "只有德鲁伊会掉落"
L["Wisp in a Bottle"] = "瓶中的小精灵"
L["World Tooltip Options"] = "世界提示信息选项"
L["Worn Troll Dice"] = "用旧的巨魔骰子"
L["Wrath of the Lich King"] = "巫妖王之怒"
L["Wriggling Darkness"] = "蠕动暗影"
L["Yesterday"] = "昨天"
L["You already defeated %d of them."] = "你已经战胜了 %d 的他们"
--Translation missing 
L["You already defeated all of them."] = "You already defeated all of them."
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = "你可以关掉整个节日提醒或通过查看 Rarity 选项屏幕逐个查看物品。"
L["You entered a achievement ID that is already being used by another item."] = "你输入的成就 ID 已经被其他物品使用。"
L["You entered a creature ID that is already being used by another item."] = "你输入的 ID 已经被使用"
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = "你输入了一个预留的名称。请输入一个出现在游戏里的正确的道具名称"
L["You entered a spell ID that is already being used by another item."] = "你输入了一个已经被使用的技能 ID"
L["You entered an item ID that is already being used by another item."] = "你输入了一个已经被使用的道具 ID"
L["You entered an item ID that is already set as the collected item for something else."] = "您输入的 ID 是已经设置为别的物品收集项目的物品 ID。"
L["You must enter a creature ID."] = "你必须输入一个自定义 ID"
L["You must enter a number larger than 0."] = "你必须输入一个大于0的数字"
L["You must enter a number larger than 1."] = "你必须输入一个大于1的数字"
L["You must enter a number larger than or equal to 0."] = "你必须输入一个大于或等于0的数字"
L["You must enter a spell ID."] = "你必须输入法术ID。"
L["You must enter a valid number."] = "你必须输入一个有效的数字"
L["You must enter an amount."] = "你必须输入一个坐骑"
L["You must enter an item ID."] = "你必须输入物品ID。"
L["You must enter at least one item ID."] = "你必须输入至少一个物品ID。"
L["You must enter at least one NPC ID."] = "你必须输入至少一个 NPC ID。"
L["You must enter at least one Statistic ID."] = "你必须输入至少一项统计 ID"
L["You must enter at least one zone."] = "你必须输入至少一个地区"
L["Young Talbuk"] = "幼年塔布羊"
L["Young Venomfang"] = "幼年毒牙风蛇"
L["Zandalari Anklerender"] = "赞达拉撕踝者"
L["Zandalari Footslasher"] = "赞达拉裂足者"
L["Zandalari Kneebiter"] = "赞达拉袭胫者"
L["Zandalari Toenibbler"] = "赞达拉啮趾者"
L["Zangar Spore"] = "赞加孢子"
L["Zhevra Lounge Cushion"] = "斑马纹沙发垫"
L["Zomstrok"] = "僵尸龙虾人"
L["Zone"] = "区域"
L["Zones"] = "区域"

end

L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "zhTW")
if L then
L[" (Group)"] = " (團隊)"
L["#%d: %d attempt (%.2f%%)"] = "#%d: %d 嘗試 (%.2f%%)"
L["#%d: %d attempts (%.2f%%)"] = "#%d: %d 嘗試 (%.2f%%)"
--Translation missing 
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = "%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"
--Translation missing 
L["%d |4zone:zones;"] = "%d |4zone:zones;"
L["%d attempt"] = "%d 嘗試"
L["%d attempt - %.2f%%"] = "%d 嘗試 - %.2f%%"
L["%d attempts"] = "%d 嘗試"
L["%d attempts - %.2f%%"] = "%d 嘗試 - %.2f%%"
L["%d collected - %.2f%%"] = "%d 已收集 - %.2f%%"
L["%s: %d attempt"] = "%s: %d 嘗試"
L["%s: %d attempt - %.2f%%"] = "%s: %d 嘗試 - %.2f%%"
L["%s: %d attempt (%d total)"] = "%s: %d 嘗試 (%d 總計)"
L["%s: %d attempts"] = "%s: %d 嘗試"
L["%s: %d attempts - %.2f%%"] = "%s: %d 嘗試 - %.2f%%"
L["%s: %d attempts (%d total)"] = "%s: %d 嘗試 (%d 總計)"
L["%s: %d collected"] = "%s: %d 已收集"
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = "%s: 0/%d 到目前為止的嘗試 (%.2f%% - %s)"
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = "%s: 0/%d 到目前為止的嘗試 (%.2f%% - %s)"
--Translation missing 
L["%s: collection completed!"] = "%s: collection completed!"
--Translation missing 
L["%s: Found after %d attempts!"] = "%s: Found after %d attempts!"
--Translation missing 
L["%s: Found on the first attempt!"] = "%s: Found on the first attempt!"
L["(%d/%d attempts)"] = "(%d/%d 嘗試)"
L["(%d/%d collected)"] = "(%d/%d 已收集)"
--Translation missing 
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = "(Items listed in red could not be found on the server and may not exist. Consider removing them.)"
L["(running in debug mode)"] = "(正在執行除錯模式)"
--Translation missing 
L["(Warning: item could not be retrieved from server)"] = "(Warning: item could not be retrieved from server)"
L["1 in %d chance"] = "%d分之1的機率"
L["10-player Heroic Raid instance (legacy content; not flexible)"] = "10人英雄團隊副本(舊副本；非彈性)"
L["10-player Raid instance (legacy content; not flexible)"] = "10人團隊副本(舊副本；非彈性)"
--Translation missing 
L["25-player Event scenario"] = "25-player Event scenario"
L["25-player heroic"] = "25人英雄難度"
L["25-player Heroic Raid instance (legacy content; not flexible)"] = "25人英雄團隊副本(舊副本；非彈性)"
L["25-player Raid instance (legacy content; not flexible)"] = "25人團隊副本(舊副本；非彈性)"
--Translation missing 
L["40-player Event raid"] = "40-player Event raid"
L["40-player Raid instance (legacy content; not flexible)"] = "40人團隊副本(舊團隊；非彈性)"
--Translation missing 
L["5-player Event instance"] = "5-player Event instance"
L["5-player Heroic instance"] = "5人英雄副本"
L["5-player instance"] = "5人副本"
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = "一個此物品ID用逗號分隔的列表，當使用或開啟時，可以給與你此物品，使用WowHead或類似的服務以查詢物品的ID。"
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = "一個掉落此物品用逗號分隔的NPC的ID列表。使用WowHead或類似的服務以查詢NPC的ID。"
--Translation missing 
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = "A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."
--Translation missing 
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = "A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."
--Translation missing 
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = "A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."
--Translation missing 
L[ [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=] ] = [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=]
--Translation missing 
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = "A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."
--Translation missing 
L["A holiday event is available today for %s! Go get it!"] = "A holiday event is available today for %s! Go get it!"
L["Abundant Bloodsail Wreckage"] = "豐碩漂浮殘骸"
L["Abundant Firefin Snapper School"] = "豐碩火鰭鯛魚群"
L["Abundant Oily Blackmouth School"] = "豐碩黑口魚群"
--Translation missing 
L["Abyss Worm"] = "Abyss Worm"
L["Abyssal Gulper School"] = "深淵大嘴鰻群"
L["Adamantite Deposit"] = "堅鋼礦床"
--Translation missing 
L["Added %d |4waypoint:waypoints; to TomTom"] = "Added %d |4waypoint:waypoints; to TomTom"
--Translation missing 
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = "Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."
--Translation missing 
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = "After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."
--Translation missing 
L["Ageless Bronze Drake"] = "Ageless Bronze Drake"
--Translation missing 
L["Ahune"] = "Ahune"
--Translation missing 
L["Ai-Li's Skymirror"] = "Ai-Li's Skymirror"
--Translation missing 
L["Ai-Ran the Shifting Cloud"] = "Ai-Ran the Shifting Cloud"
--Translation missing 
L["Albino Buzzard"] = "Albino Buzzard"
L["Albino Cavefish School"] = "白化穴魚群"
--Translation missing 
L["Albino Chimaeraling"] = "Albino Chimaeraling"
L["Algaefin Rockfish School"] = "藻鰭岩魚群"
--Translation missing 
L["All players can participate in killing this world boss once per week, regardless of faction"] = "All players can participate in killing this world boss once per week, regardless of faction"
L["All raid formats except Raid Finder"] = "所有團隊規模難度除了隨機團隊"
L["Alliance only"] = "聯盟限定"
L["Already defeated"] = "已經擊倒"
L["Already defeated for %s"] = "已經擊倒 %s 次"
L["Already known"] = "已知"
--Translation missing 
L["an item already exists by this name, so it will not be imported"] = "an item already exists by this name, so it will not be imported"
--Translation missing 
L["an item with the same Item ID already exists, so it will not be imported"] = "an item with the same Item ID already exists, so it will not be imported"
--Translation missing 
L["Ancient Mana"] = "Ancient Mana"
--Translation missing 
L["and %d |4other zone:other zones;"] = "and %d |4other zone:other zones;"
L["Announce"] = "發佈"
L["Announcements"] = "通知"
--Translation missing 
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = "Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."
L["Anubisath Idol"] = "阿努比薩斯神像"
L["Any difficulty"] = "任何難度"
L["Any raid size"] = "任何團隊規模"
L["Any raid size or difficulty"] = "任何團隊規模或難度"
L["Appears in the Black Market"] = "出現在黑市"
--Translation missing 
L["Aqua Jewel"] = "Aqua Jewel"
--Translation missing 
L["Arakkoa"] = "Arakkoa"
--Translation missing 
L["Arcano-Shower"] = "Arcano-Shower"
L["Archaeology race"] = "考古學種族"
L["Are you sure you want to delete this item?"] = "您確定要刪除此物品？"
--Translation missing 
L["Are you sure you want to import the Rarity Item Pack you entered?"] = "Are you sure you want to import the Rarity Item Pack you entered?"
--Translation missing 
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = "Are you sure you want to turn off the Export toggle for all your Custom items?"
--Translation missing 
L["Armored Razorback"] = "Armored Razorback"
L["Armored Razzashi Raptor"] = "裝甲拉札希迅猛龍"
--Translation missing 
L["Ash-Covered Horn"] = "Ash-Covered Horn"
L["Ashes of Al'ar"] = "歐爾灰燼"
L["Ashleaf Spriteling"] = "小灰葉妖精"
L["Attempts"] = "嘗試"
--Translation missing 
L["Auto"] = "Auto"
--Translation missing 
L["Available starting December 25th"] = "Available starting December 25th"
L["Azure Crane Chick"] = "小蒼藍鶴"
L["Azure Whelpling"] = "藍龍寶寶"
--Translation missing 
L["Battle Horn"] = "Battle Horn"
--Translation missing 
L["Battle Pet"] = "Battle Pet"
--Translation missing 
L["Battle Pets"] = "Battle Pets"
L["Big Love Rocket"] = "大型愛心火箭"
--Translation missing 
L["Black Barracuda School"] = "Black Barracuda School"
L["Black Trillium Deposit"] = "黑延齡礦石"
L["Blackbelly Mudfish School"] = "黑肚泥鰍群"
--Translation missing 
L["Blackflame Daggers"] = "Blackflame Daggers"
L["Blackfuse Bombling"] = "黑引信小炸彈"
--Translation missing 
L["Blackhoof"] = "Blackhoof"
L["Blackrock Deposit"] = "黑石礦床"
L["Blackwater Whiptail School"] = "黑水鞭尾魚群"
L["Blackwing Banner"] = "黑翼旌旗"
L["Blank line before tooltip additions"] = "在額外工具提示前的空白行"
L["Blazing Rune"] = "熾熱符文"
--Translation missing 
L["Bleakclaw"] = "Bleakclaw"
--Translation missing 
L["Blessed Seed"] = "Blessed Seed"
--Translation missing 
L["Blight Boar Microphone"] = "Blight Boar Microphone"
L["Blighted Spore"] = "荒疫污染孢子"
L["Blind Lake Sturgeon School"] = "盲湖鱘魚群"
L["Bloodsail Wreckage"] = "血帆殘骸"
L["Bloodsail Wreckage Pool"] = "血帆殘骸"
L["Bluefish School"] = "藍魚群"
--Translation missing 
L["Bone Serpent"] = "Bone Serpent"
L["Bonkers"] = "嚎怪"
L["Borean Man O' War School"] = "北風水母群"
--Translation missing 
L["Boss Name"] = "Boss Name"
--Translation missing 
L["Bottled Tornado"] = "Bottled Tornado"
L["Brackish Mixed School"] = "魔尾魚群"
--Translation missing 
L["Brew Frenzied Emperor Salmon"] = "Brew Frenzied Emperor Salmon"
L["Brilliant Phoenix Hawk Feather"] = "斑斕的鳳鷹羽毛"
--Translation missing 
L["Brinedeep Bottom-Feeder"] = "Brinedeep Bottom-Feeder"
--Translation missing 
L["Bristling Hellboar"] = "Bristling Hellboar"
--Translation missing 
L["Bronze Proto-Whelp"] = "Bronze Proto-Whelp"
--Translation missing 
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = "Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."
--Translation missing 
L["Burgy Blackheart's Handsome Hat"] = "Burgy Blackheart's Handsome Hat"
--Translation missing 
L["Call of the Frozen Blade"] = "Call of the Frozen Blade"
--Translation missing 
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = "Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."
--Translation missing 
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = "Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."
--Translation missing 
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = "Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."
--Translation missing 
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = "Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."
L["Can be obtained with a bonus roll"] = "可以從加成骰獲得"
--Translation missing 
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = "Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."
L["Captured Firefly"] = "被捕的螢火蟲"
L["Cat Carrier (Black Tabby)"] = "貓籠(黑色虎斑)"
L["Cataclysm"] = "浩劫與重生"
--Translation missing 
L["Cavern Moccasin"] = "Cavern Moccasin"
--Translation missing 
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = "Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"
--Translation missing 
L["Chain Pet Leash"] = "Chain Pet Leash"
--Translation missing 
L["Chalice of Secrets"] = "Chalice of Secrets"
L["Challenge Mode instance"] = "挑戰模式副本"
L["Chance"] = "機率"
L["Chance so far"] = "到目前為止的機率"
--Translation missing 
L["Chaos Pup"] = "Chaos Pup"
--Translation missing 
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = "Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."
--Translation missing 
L[ [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=] ] = [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=]
--Translation missing 
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = "Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."
--Translation missing 
L["Christoph VonFeasel"] = "Christoph VonFeasel"
--Translation missing 
L["Chromie"] = "Chromie"
--Translation missing 
L["Chuck's Bucket"] = "Chuck's Bucket"
L["Classic"] = "原始的"
--Translation missing 
L["Clear All Exports"] = "Clear All Exports"
L["Click to switch to this item"] = "點擊以切換到此物品"
L["Click to toggle the progress bar"] = "點擊以切換到進度條"
--Translation missing 
L["Clockwork Rocket Bot"] = "Clockwork Rocket Bot"
--Translation missing 
L["Close"] = "Close"
--Translation missing 
L["Cloudwing Hippogryph"] = "Cloudwing Hippogryph"
L["Clutch of Ji-Kun"] = "稷坤之嗣"
L["Cobalt Deposit"] = "鈷藍礦床"
--Translation missing 
L["Coin of Many Faces"] = "Coin of Many Faces"
L["Collect %d %s"] = "收集 %d %s"
L["Collected"] = "已收集"
L["Collection Complete"] = "收集完畢"
L["Collection complete!"] = "收集完畢"
L["Collection Size"] = "收集大小"
L["Contained in bonus satchels"] = "由獎勵包獲得"
--Translation missing 
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = "Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."
--Translation missing 
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = "Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."
--Translation missing 
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = "Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."
L["Content Category"] = "內容類別"
--Translation missing 
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = "Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = "控制Rarity怎樣類型的文字要顯示在LDB上。最小可以就只顯示嘗試次數，一般會增加運氣機率與增加了詳細的物品連結。"
L["Copper Vein"] = "銅礦脈"
--Translation missing 
L[ [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=] ] = [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=]
L["Core of Hardened Ash"] = "硬化灰燼之核"
--Translation missing 
L["Corrupted Nest Guardian"] = "Corrupted Nest Guardian"
--Translation missing 
L["Corrupted Thundertail"] = "Corrupted Thundertail"
L["Crane Nest"] = "鶴巢"
--Translation missing 
L["Crashin' Thrashin' Cannon Controller"] = "Crashin' Thrashin' Cannon Controller"
--Translation missing 
L["Crashin' Thrashin' Flyer Controller"] = "Crashin' Thrashin' Flyer Controller"
--Translation missing 
L["Crashin' Thrashin' Mortar Controller"] = "Crashin' Thrashin' Mortar Controller"
--Translation missing 
L["Crashin' Thrashin' Racer Controller"] = "Crashin' Thrashin' Racer Controller"
--Translation missing 
L["Crashin' Thrashin' Roller Controller"] = "Crashin' Thrashin' Roller Controller"
L["Create a New Item"] = "建立一個新物品"
L["Create a new item to track"] = "建立一個新物品以追蹤"
L["Creature ID"] = "人物ID"
--Translation missing 
L["Crowded Redbelly Mandarin"] = "Crowded Redbelly Mandarin"
--Translation missing 
L["Crysa"] = "Crysa"
L["Crystal of the Void"] = "虛空水晶"
L["Ctrl-Click to change sort order"] = "Ctrl-點擊以改變排列順序"
--Translation missing 
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = "Ctrl-Click to create the remaining TomTom waypoint(s)."
--Translation missing 
L["Ctrl-Click to create TomTom waypoint(s)."] = "Ctrl-Click to create TomTom waypoint(s)."
--Translation missing 
L["Cupri"] = "Cupri"
--Translation missing 
L["Curious Wyrmtongue Cache"] = "Curious Wyrmtongue Cache"
--Translation missing 
L["Cursed Queenfish School"] = "Cursed Queenfish School"
--Translation missing 
L["Cursed Spirit"] = "Cursed Spirit"
L["Custom"] = "自定義"
L["Dandelion Frolicker"] = "蒲公英小妖"
--Translation missing 
L["Dark Gazer"] = "Dark Gazer"
L["Dark Iron Deposit"] = "黑鐵礦床"
L["Dark Quivering Blob"] = "黑暗顫動血泡"
L["Dark Whelpling"] = "暗龍寶寶"
L["Darkmoon Eye"] = "暗月之眼"
L["Data has been imported from Bunny Hunter"] = "數據已經從Bunny Hunter匯入"
L["Death Adder Hatchling"] = "死亡奎蛇寶寶"
--Translation missing 
L["Death Knight"] = "Death Knight"
L["Deathcharger's Reins"] = "死亡戰騎韁繩"
--Translation missing 
L["Deathtalon"] = "Deathtalon"
L["Debug mode"] = "除錯模式"
L["Debug mode OFF"] = "除錯模式OFF"
L["Debug mode ON"] = "除錯模式ON"
--Translation missing 
L["Decahedral Dwarven Dice"] = "Decahedral Dwarven Dice"
L["Deep Sea Monsterbelly School"] = "深海大肚魚群"
L["Deepsea Sagefish School"] = "深海鼠尾魚群"
--Translation missing 
L["Defeat Detection"] = "Defeat Detection"
L["Defeated"] = "擊倒"
--Translation missing 
L["Defiled Earth"] = "Defiled Earth"
L["Delete this item"] = "刪除此物品"
--Translation missing 
L["Demon Hunter"] = "Demon Hunter"
--Translation missing 
L["Demonic"] = "Demonic"
L["Determines how this item is obtained."] = "確定這個物品怎麼得到。"
L["Determines what type of item this is."] = "確定此物品的類型。"
--Translation missing 
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = "Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = "確定是否應該為這一物品啟用跟蹤。被禁用的物品不會出現在工具提示中。"
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = "確定您是否要反復農這一物品。如果你打開該功能，找到該項，Rarity在幾秒鐘後會將物品標記為未發現。"
--Translation missing 
L[ [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=] ] = [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=]
L["Determines which race includes this archaeology project."] = "確定哪種族包括這個考古學物品。"
L["Deviate Hatchling"] = "小變異迅猛龍"
--Translation missing 
L["Direflame"] = "Direflame"
L["Direhorn Runt"] = "小恐角龍"
--Translation missing 
L["Disable for classes"] = "Disable for classes"
L["Disgusting Oozeling"] = "噁心的小軟泥怪"
--Translation missing 
L["Displacer Meditation Stone"] = "Displacer Meditation Stone"
--Translation missing 
L["Distance"] = "Distance"
--Translation missing 
L["Don Carlos' Famous Hat"] = "Don Carlos' Famous Hat"
--Translation missing 
L["Doomroller"] = "Doomroller"
L["Draenei"] = "德萊尼"
L["Draenor Clans"] = "德拉諾氏族"
--Translation missing 
L["Draenor Garrison"] = "Draenor Garrison"
L["Dragonfin Angelfish School"] = "龍鱗天使魚群"
--Translation missing 
L["Drakum"] = "Drakum"
--Translation missing 
L["Dreadwalker"] = "Dreadwalker"
L["Dripping Strider Egg"] = "滴水的水黽卵"
L["Droplet of Y'Shaarj"] = "亞煞拉懼的殘靈"
--Translation missing 
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = "Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."
--Translation missing 
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = "Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."
--Translation missing 
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = "Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = "魔古山寶庫的艾拉貢掉落(所有團隊規模難度除了隨機團隊)"
--Translation missing 
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = "Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."
--Translation missing 
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = "Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = "永恆之眼的瑪里苟斯掉落(任何團隊規模)"
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = "奧克尼西亞巢穴的黑龍妹掉落(任何團隊規模)"
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = "巨龍之魂的尾王掉落(任何團隊規模或難度)"
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = "巨龍之魂的尾王掉落(英雄難度，任何團隊規模)"
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = "巨龍之魂的奧特拉賽恩掉落(任何團隊規模或難度)"
L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = "奧杜亞的尤格薩倫掉落(25人)需要0燈"
--Translation missing 
L["Dropped from dinosaurs on Isle of Giants"] = "Dropped from dinosaurs on Isle of Giants"
--Translation missing 
L["Dropped from monsters in Fang'rila"] = "Dropped from monsters in Fang'rila"
L["Drops from a boss requiring a group"] = "從需要組隊的首領掉落"
L["Drops from any mob in a zone"] = "從一個區域的怪物掉落"
L["Drops from NPC(s)"] = "從NPC掉落"
--Translation missing 
L["Drudge Remains"] = "Drudge Remains"
--Translation missing 
L["Druid"] = "Druid"
--Translation missing 
L["Dungeon ID"] = "Dungeon ID"
L["Dusty Clutch of Eggs"] = "一簇布滿灰塵的蛋"
L["Dwarf"] = "矮人"
--Translation missing 
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = "Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."
L["Elementium Geode"] = "源質晶簇"
L["Elementium Vein"] = "源質礦脈"
L["Emperor Salmon School"] = "帝王鮭魚群"
L["Enable announcements"] = "啟用通知"
L["Enable Coins"] = "啟用貨幣"
L["Enable profiling"] = "啟用分析"
L["Enable tooltip additions"] = "啟用額外工具提示"
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = "啟用通知，每當您完成一次新嘗試是任何Rarity追蹤中的。您也可以啟用每件物品的通知，但這是個總開關。"
L["Enables announcements whenever you complete a new attempt toward this item."] = "啟用通知，每當您完成此物品的一次新嘗試。"
--Translation missing 
L["Enter 1 or leave this blank to mark the item as soloable."] = "Enter 1 or leave this blank to mark the item as soloable."
L["Equal odds"] = "均等的機會"
--Translation missing 
L["Error compressing item pack"] = "Error compressing item pack"
--Translation missing 
L["Error encoding item pack"] = "Error encoding item pack"
--Translation missing 
L["Error serializing item pack"] = "Error serializing item pack"
--Translation missing 
L["Essence of the Breeze"] = "Essence of the Breeze"
--Translation missing 
L["Eternal Kiln"] = "Eternal Kiln"
--Translation missing 
L["Eternal Warrior's Sigil"] = "Eternal Warrior's Sigil"
--Translation missing 
L["Everliving Spore"] = "Everliving Spore"
L["Every item ID must be a number greater than 0."] = "每個物品的ID必須是大於0的數字。"
L["Every NPC ID must be a number greater than 0."] = "每個NPC的ID必須是大於0的數字。"
--Translation missing 
L["Every Quest ID must be a number greater than 0."] = "Every Quest ID must be a number greater than 0."
L["Experiment 12-B"] = "實驗體 12-B"
--Translation missing 
L["Export"] = "Export"
--Translation missing 
L["Export Rarity Item Pack"] = "Export Rarity Item Pack"
--Translation missing 
L["Export this item"] = "Export this item"
--Translation missing 
L["Eye of Inquisition"] = "Eye of Inquisition"
--Translation missing 
L["Faintly Glowing Flagon of Mead"] = "Faintly Glowing Flagon of Mead"
--Translation missing 
L["Fandral's Seed Pouch"] = "Fandral's Seed Pouch"
L["Fangtooth Herring School"] = "尖齒鯡魚群"
--Translation missing 
L["Farwater Conch"] = "Farwater Conch"
L["Fat Sleeper School"] = "胖睡魚魚群"
--Translation missing 
L["Fathom Dweller"] = "Fathom Dweller"
L["Fathom Eel Swarm"] = "澗鰻群"
L["Feed text"] = "顯示文字"
L["Fel Iron Deposit"] = "魔鐵礦床"
--Translation missing 
L["Felfly"] = "Felfly"
--Translation missing 
L["Felslate Deposit"] = "Felslate Deposit"
--Translation missing 
L["Felslate Seam"] = "Felslate Seam"
--Translation missing 
L["Felsteel Annihilator"] = "Felsteel Annihilator"
--Translation missing 
L["Felsworn Sentry"] = "Felsworn Sentry"
L["Feltail School"] = "魔尾魚群"
--Translation missing 
L["Fever of Stormrays"] = "Fever of Stormrays"
L["Fiery Warhorse's Reins"] = "熾炎戰馬韁繩"
L["Fire Ammonite School"] = "火焰菊石群"
L["Firefin Snapper School"] = "火鰭鯛魚群"
--Translation missing 
L["Firewing"] = "Firewing"
--Translation missing 
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = "Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"
L["Flametalon of Alysrazor"] = "艾里絲拉卓烈焰猛禽"
L["Floating Debris"] = "漂浮的碎片"
L["Floating Debris Pool"] = "漂浮的殘骸"
L["Floating Shipwreck Debris"] = "沈船殘骸"
L["Floating Wreckage"] = "漂浮殘骸"
L["Floating Wreckage Pool"] = "漂浮殘骸之池"
L["Font"] = "字型"
L["Font Size"] = "字型大小"
--Translation missing 
L["Foot Ball"] = "Foot Ball"
L["Fossil"] = "化石"
L["Fossilized Raptor"] = "化石迅猛龍"
L["Found after %d attempts!"] = "在%d次嘗試後找到！"
--Translation missing 
L["Found in: "] = "Found in: "
L["Found on your first attempt!"] = "在第一次嘗試就找到！"
L["Fox Kit"] = "沙狐"
--Translation missing 
L["Fragment of Anger"] = "Fragment of Anger"
--Translation missing 
L["Fragment of Desire"] = "Fragment of Desire"
--Translation missing 
L["Fragment of Frozen Bone"] = "Fragment of Frozen Bone"
--Translation missing 
L["Fragment of Suffering"] = "Fragment of Suffering"
--Translation missing 
L["Frenzyheart Brew"] = "Frenzyheart Brew"
--Translation missing 
L["Frightened Bush Chicken"] = "Frightened Bush Chicken"
--Translation missing 
L["Fuzzy Green Lounge Cushion"] = "Fuzzy Green Lounge Cushion"
--Translation missing 
L["Gahz'rooki's Summoning Stone"] = "Gahz'rooki's Summoning Stone"
--Translation missing 
L["Gar'lok"] = "Gar'lok"
--Translation missing 
L["Garn Nighthowl"] = "Garn Nighthowl"
--Translation missing 
L["Garn Steelmaw"] = "Garn Steelmaw"
--Translation missing 
L["Garrison Invasion Gold Victory"] = "Garrison Invasion Gold Victory"
--Translation missing 
L["Garrison Invasion Platinum Victory"] = "Garrison Invasion Platinum Victory"
--Translation missing 
L["Gastropod Shell"] = "Gastropod Shell"
L["General"] = "綜合"
--Translation missing 
L["General Options"] = "General Options"
L["Ghost Iron Deposit"] = "鬼鐵礦床"
--Translation missing 
L["Giant Coldsnout"] = "Giant Coldsnout"
L["Giant Mantis Shrimp Swarm"] = "巨型螳螂蝦群"
L["Giant Sewer Rat"] = "巨大下水道老鼠"
--Translation missing 
L["Giant Worm Egg"] = "Giant Worm Egg"
--Translation missing 
L["Gibblette the Cowardly"] = "Gibblette the Cowardly"
L["Glacial Salmon School"] = "冰川鮭魚群"
L["Glassfin Minnow School"] = "玻鰭小鯉魚群"
--Translation missing 
L["Glimmering Jewel Danio Pool"] = "Glimmering Jewel Danio Pool"
--Translation missing 
L["Glimmering Treasure Chest"] = "Glimmering Treasure Chest"
--Translation missing 
L["Glittering Arcane Crystal"] = "Glittering Arcane Crystal"
--Translation missing 
L["Glittering Ball of Yarn"] = "Glittering Ball of Yarn"
--Translation missing 
L["Glowing Jade Lungfish"] = "Glowing Jade Lungfish"
L["Gluth's Bone"] = "古魯斯的骨頭"
L["Gold Vein"] = "金礦脈"
L["Golden Carp School"] = "金鯉魚群"
--Translation missing 
L["Gondar"] = "Gondar"
L["Gooey Sha-ling"] = "黏稠的小煞靈"
--Translation missing 
L["Goren \"Log\" Roller"] = "Goren \"Log\" Roller"
L["Great Brewfest Kodo"] = "大型啤酒節科多獸"
L["Greater Sagefish School"] = "大型鼠尾魚群"
--Translation missing 
L["Greatfather Winter's Tree"] = "Greatfather Winter's Tree"
--Translation missing 
L["Green Helper Box"] = "Green Helper Box"
--Translation missing 
L["Grotesque Statue"] = "Grotesque Statue"
--Translation missing 
L["Group Finder Options"] = "Group Finder Options"
L["Group size"] = "團隊規模"
--Translation missing 
L["Group(s) found!"] = "Group(s) found!"
--Translation missing 
L["Grow Up"] = "Grow Up"
--Translation missing 
L["Grumpling"] = "Grumpling"
--Translation missing 
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = "Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."
L["Gu'chi Swarmling"] = "古奇的蟲群"
--Translation missing 
L["Guk"] = "Guk"
L["Gulp Froglet"] = "小咕嚕蛙"
L["Gundrak Hatchling"] = "小剛德拉克迅猛龍"
L["Half-Empty Food Container"] = "半滿的餐盒"
--Translation missing 
L["Hardened Shell"] = "Hardened Shell"
L["Height"] = "高度"
--Translation missing 
L["Helpful Wikky's Whistle"] = "Helpful Wikky's Whistle"
--Translation missing 
L["Here is a preview of what will (or won't) be imported:"] = "Here is a preview of what will (or won't) be imported:"
L["Heroic difficulty"] = "英雄難度"
L["Heroic Raid (10-30 players)"] = "英雄團隊(10-30人)"
L["Heroic Scenario instance"] = "英雄事件副本"
L["Heroic, any raid size"] = "英雄難度，任何團隊規模"
L["Hidden"] = "隱藏"
--Translation missing 
L["Hide defeated items"] = "Hide defeated items"
L["Hide high chance items"] = "隱藏高機率物品"
--Translation missing 
L["Hide items not in your zone"] = "Hide items not in your zone"
--Translation missing 
L["Hide items with no attempts"] = "Hide items with no attempts"
--Translation missing 
L["Hide unavailable items"] = "Hide unavailable items"
--Translation missing 
L["High Priest of Ordos"] = "High Priest of Ordos"
--Translation missing 
L["Highborne"] = "Highborne"
L["Highland Guppy School"] = "高地孔雀魚群"
L["Highland Mixed School"] = "高地綜合魚群"
--Translation missing 
L["Highmountain Elderhorn"] = "Highmountain Elderhorn"
--Translation missing 
L["Highmountain Salmon School"] = "Highmountain Salmon School"
--Translation missing 
L["Highmountain Tauren"] = "Highmountain Tauren"
L["Holiday"] = "假日"
--Translation missing 
L["Holiday reminders"] = "Holiday reminders"
L["Hollow Reed"] = "空心蘆葦"
L["Horde only"] = "部落限定"
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = "物品出現的可能性，表示為 X分之1，其中 X 是您在此處輸入的數字。"
L["How many attempts you've made so far."] = "到目前為止您做了多少次嘗試。"
--Translation missing 
L["How many items you need to collect."] = "How many items you need to collect."
--Translation missing 
L["How many items you've collected so far."] = "How many items you've collected so far."
--Translation missing 
L["Hozen Beach Ball"] = "Hozen Beach Ball"
L["Huge Obsidian Slab"] = "巨型黑曜石片"
--Translation missing 
L["Hunter"] = "Hunter"
--Translation missing 
L["Hyjal Wisp"] = "Hyjal Wisp"
L["Ice Chip"] = "冰屑"
L["Identify the Item"] = "辨識此物品"
L["Imbued Jade Fragment"] = "灌魔翠玉碎片"
L["Imperial Manta Ray School"] = "帝王韌皮魟魚群"
L["Imperial Moth"] = "帝王蛾"
--Translation missing 
L["Imperial Silkworm"] = "Imperial Silkworm"
--Translation missing 
L["Imp-Master Valessa"] = "Imp-Master Valessa"
--Translation missing 
L["Import"] = "Import"
--Translation missing 
L["Import Rarity Item Pack"] = "Import Rarity Item Pack"
--Translation missing 
L["Import/Export"] = "Import/Export"
--Translation missing 
L["imported successfully"] = "imported successfully"
L["Incendicite Mineral Vein"] = "火岩礦脈"
L["Indurium Mineral Vein"] = "精鐵礦脈"
--Translation missing 
L["Install TomTom to enable waypoint creation."] = "Install TomTom to enable waypoint creation."
L["Instance Difficulty"] = "副本難度"
L["Instant Arcane Sanctum Security Kit"] = "速成秘法聖所安全工具包"
L["Invincible's Reins"] = "無敵的韁繩"
L["Iron Deposit"] = "鐵礦床"
--Translation missing 
L["Ironbound Collar"] = "Ironbound Collar"
--Translation missing 
L["Ironhoof Destroyer"] = "Ironhoof Destroyer"
L["Item ID"] = "物品ID"
L["Item ID to Collect"] = "要收集的物品ID"
L["Items to Use"] = "使用的物品"
L["Jade Lungfish School"] = "翠玉龍魚群"
L["Jadefire Spirit"] = "碧火精靈"
L["Jademist Dancer"] = "碧霧舞者"
L["Jawless Skulker School"] = "無頷潛藏者魚群"
--Translation missing 
L["Jeremy Feasel"] = "Jeremy Feasel"
L["Jewel Danio School"] = "珠寶斑馬魚群"
L["Jewel of Maddening Whispers"] = "狂亂低語珠寶"
L["Ji-Kun Hatchling"] = "稷坤寶寶"
--Translation missing 
L["Jingling Bell"] = "Jingling Bell"
--Translation missing 
L["Kael'thas Sunstrider"] = "Kael'thas Sunstrider"
--Translation missing 
L["Kaldorei Light Globe"] = "Kaldorei Light Globe"
--Translation missing 
L["Kal'tik the Blight"] = "Kal'tik the Blight"
--Translation missing 
L["Kang's Bindstone"] = "Kang's Bindstone"
L["Khorium Vein"] = "克銀礦脈"
--Translation missing 
L["Kill Statistic IDs"] = "Kill Statistic IDs"
--Translation missing 
L["Knockoff Blingtron"] = "Knockoff Blingtron"
--Translation missing 
L["Kor'kron Juggernaut"] = "Kor'kron Juggernaut"
--Translation missing 
L["Kovok"] = "Kovok"
L["Krasarang Paddlefish School"] = "喀撒朗匙吻鱘魚群"
L["Kyparite Deposit"] = "奇帕利礦床"
--Translation missing 
L["Land Shark"] = "Land Shark"
L["Large Obsidian Chunk"] = "大黑曜石塊"
--Translation missing 
L["Large Pool of Brew Frenzied Emperor Salmon"] = "Large Pool of Brew Frenzied Emperor Salmon"
--Translation missing 
L["Large Pool of Crowded Redbelly Mandarin"] = "Large Pool of Crowded Redbelly Mandarin"
--Translation missing 
L["Large Pool of Glimmering Jewel Danio Pool"] = "Large Pool of Glimmering Jewel Danio Pool"
--Translation missing 
L["Large Pool of Glowing Jade Lungfish"] = "Large Pool of Glowing Jade Lungfish"
--Translation missing 
L["Large Pool of Sha-Touched Spinefish"] = "Large Pool of Sha-Touched Spinefish"
--Translation missing 
L["Large Pool of Tiger Gourami Slush"] = "Large Pool of Tiger Gourami Slush"
--Translation missing 
L["Large Swarm of Migrated Reef Octopus"] = "Large Swarm of Migrated Reef Octopus"
--Translation missing 
L["Large Swarm of Panicked Paddlefish"] = "Large Swarm of Panicked Paddlefish"
--Translation missing 
L["Large Tangled Mantis Shrimp Cluster"] = "Large Tangled Mantis Shrimp Cluster"
L["Last Month"] = "上個月"
L["Last Week"] = "上週"
L["Left"] = "左"
--Translation missing 
L["Legion"] = "Legion"
L["Lesser Bloodstone Deposit"] = "次級血石礦床"
L["Lesser Firefin Snapper School"] = "火鰭鯛魚群"
L["Lesser Floating Debris"] = "漂浮的碎片"
L["Lesser Oily Blackmouth School"] = "小型黑口魚群"
L["Lesser Sagefish School"] = "小型鼠尾魚群"
--Translation missing 
L["Leviathan Egg"] = "Leviathan Egg"
--Translation missing 
L["Ley Spider Eggs"] = "Ley Spider Eggs"
--Translation missing 
L["Leystone Deposit"] = "Leystone Deposit"
--Translation missing 
L["Leystone Seam"] = "Leystone Seam"
--Translation missing 
L["Leywoven Flying Carpet"] = "Leywoven Flying Carpet"
--Translation missing 
L["Life-Binder's Handmaiden"] = "Life-Binder's Handmaiden"
L["Likelihood"] = "機率"
L["Lil' Bling"] = "小布靈登"
--Translation missing 
L["Living Infernal Core"] = "Living Infernal Core"
L["Living Sandling"] = "活體小流沙"
L["Loaded (running in debug mode)"] = "已載入 (執行除錯模式)"
--Translation missing 
L["Loaded Gnomish Dice"] = "Loaded Gnomish Dice"
L["Loading"] = "載入中"
L["Locked"] = "已鎖定"
L["Looking For Raid (10-30 players)"] = "隨機團隊(10-30人)"
L["Luckiness"] = "運氣"
L["Lucky"] = "好運"
L["lucky"] = "好運"
L["Lucky if you obtain in %d or less"] = "如果你在%d次內獲得是好運的"
--Translation missing 
L["Lump of Coal"] = "Lump of Coal"
--Translation missing 
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = "Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."
--Translation missing 
L["Mage"] = "Mage"
--Translation missing 
L["Magnataur Hunting Horn"] = "Magnataur Hunting Horn"
--Translation missing 
L["Major Nanners"] = "Major Nanners"
L["Mantid"] = "螳螂人"
L["Mark of Flame"] = "烈焰印記"
L["Method of obtaining"] = "獲得方法"
--Translation missing 
L["Midnight's Eternal Reins"] = "Midnight's Eternal Reins"
L["Mimiron's Head"] = "彌米倫之首"
L["Minimal"] = "最小"
--Translation missing 
L["Minion of Grumpus"] = "Minion of Grumpus"
--Translation missing 
L["MiniZep Controller"] = "MiniZep Controller"
--Translation missing 
L["Mirecroak"] = "Mirecroak"
L["Mists of Pandaria"] = "潘達利亞之謎"
L["Mithril Deposit"] = "秘銀礦床"
L["Mogu"] = "魔古"
L["Mojo"] = "莫巧"
--Translation missing 
L["Monk"] = "Monk"
L["Moon Moon"] = "小月狼"
--Translation missing 
L["Moonfang"] = "Moonfang"
--Translation missing 
L["Moonfang Shroud"] = "Moonfang Shroud"
--Translation missing 
L["Moonfang's Paw"] = "Moonfang's Paw"
L["Moonglow Cuttlefish School"] = "月色墨魚群"
--Translation missing 
L["Mossgill Perch School"] = "Mossgill Perch School"
L["Mount"] = "坐騎"
L["Mountain Panda"] = "山地小熊貓"
L["Mountain Trout School"] = "山脈鱒魚群"
L["Mounts"] = "坐騎"
L["Mr. Grubbs"] = "格拉布斯先生"
L["Mr. Pinchy"] = "皮恩奇先生"
--Translation missing 
L["Mr. Smite's Brass Compass"] = "Mr. Smite's Brass Compass"
--Translation missing 
L["Muckbreaths's Bucket"] = "Muckbreaths's Bucket"
L["Muddy Churning Water"] = "混濁的水"
L["Mudfish School"] = "泥鰍群"
L["Musselback Sculpin School"] = "蚌脊魚群"
--Translation missing 
L["Muyani"] = "Muyani"
L["Mysterious Camel Figurine"] = "神秘駱駝刻像"
--Translation missing 
L["Mythic 5-player instance"] = "Mythic 5-player instance"
L["Mythic difficulty"] = "傳奇難度"
L["Mythic Raid (20 player)"] = "傳奇團隊(20人)"
L["Nerubian"] = "奈幽"
--Translation missing 
L["Nerubian Relic"] = "Nerubian Relic"
--Translation missing 
L["Nessos the Oracle"] = "Nessos the Oracle"
L["Nethercite Deposit"] = "虛空聚晶礦床"
--Translation missing 
L["Netherfist"] = "Netherfist"
L["Netherspace Portal-Stone"] = "虛空空間傳送石"
L["Nettlefish School"] = "蕁麻魚群"
L["New item"] = "新物品"
L["Night Elf"] = "夜精靈"
--Translation missing 
L["Nightmare Bell"] = "Nightmare Bell"
--Translation missing 
L["Nightmare Whelpling"] = "Nightmare Whelpling"
--Translation missing 
L["Nightshade Sproutling"] = "Nightshade Sproutling"
--Translation missing 
L[ [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=] ] = [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=]
--Translation missing 
L["None"] = "None"
L["None (not in an instance)"] = "無(不在副本)"
L["Normal"] = "一般"
L["Normal Raid (10-30 players)"] = "普通團隊(10-30人)"
--Translation missing 
L["not imported"] = "not imported"
--Translation missing 
L["NPCs"] = "NPCs"
L["Obsidium Deposit"] = "黑曜石塊"
--Translation missing 
L["Obtained Achievement ID"] = "Obtained Achievement ID"
L["Obtained After %d Attempts"] = "%d 次嘗試後獲得"
--Translation missing 
L["Obtained as a rare project for the Fossil branch of archaeology"] = "Obtained as a rare project for the Fossil branch of archaeology"
--Translation missing 
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = "Obtained as a very rare project for the Tol'vir branch of archaeology"
L["Obtained as an archaeology project"] = "透過考古學獲得"
L["Obtained by collecting a number of items"] = "收集一定數量的物品來獲得"
L["Obtained by fishing"] = "透過釣魚獲得"
--Translation missing 
L["Obtained by fishing in any water in Ironforge"] = "Obtained by fishing in any water in Ironforge"
--Translation missing 
L["Obtained by fishing in any water in Orgrimmar"] = "Obtained by fishing in any water in Orgrimmar"
--Translation missing 
L["Obtained by fishing in pools located in Terrokar Forest"] = "Obtained by fishing in pools located in Terrokar Forest"
L["Obtained by mining"] = "透過採礦獲得"
L["Obtained by mining Elementium Vein"] = "源質礦脈採礦獲得"
L["Obtained by opening Crane Nests on the Timeless Isle"] = "在永恆島開啟鶴巢獲得"
--Translation missing 
L["Obtained by opening Snow Mound in Frostfire Ridge"] = "Obtained by opening Snow Mound in Frostfire Ridge"
L["Obtained by opening Timeless Chests on the Timeless Isle"] = "在永恆島開啟永恆寶箱獲得"
L["Obtained by using an item or opening a container"] = "透過使用物品或打開容器獲得"
L["Obtained On Your First Attempt"] = "在你第一次嘗試就獲得"
--Translation missing 
L["Obtained Quest ID"] = "Obtained Quest ID"
--Translation missing 
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = "Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"
--Translation missing 
L["Odd Polished Stone"] = "Odd Polished Stone"
--Translation missing 
L["Ogre"] = "Ogre"
L["Oil Spill"] = "油井"
--Translation missing 
L["Oily Abyssal Gulper School"] = "Oily Abyssal Gulper School"
L["Oily Blackmouth School"] = "黑口魚群"
L["Oily Sea Scorpion School"] = "肥美的海蠍群"
--Translation missing 
L["Old Crafty"] = "Old Crafty"
--Translation missing 
L["Old Ironjaw"] = "Old Ironjaw"
--Translation missing 
L["Old Man Barlo"] = "Old Man Barlo"
L["Ominous Flame"] = "不祥之焰"
--Translation missing 
L["Ominous Pile of Snow"] = "Ominous Pile of Snow"
--Translation missing 
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = "One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."
--Translation missing 
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = "One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."
--Translation missing 
L["Only announce when found"] = "Only announce when found"
L["Only Raid Finder difficulty"] = "只有隨機團隊難度"
L["Ooze Covered Gold Vein"] = "軟泥覆蓋的金礦脈"
L["Ooze Covered Mithril Deposit"] = "軟泥覆蓋的秘銀礦床"
L["Ooze Covered Rich Thorium Vein"] = "軟泥覆蓋的富瑟銀礦脈"
L["Ooze Covered Silver Vein"] = "軟泥覆蓋的銀礦脈"
L["Ooze Covered Thorium Vein"] = "軟泥覆蓋的瑟銀礦脈"
L["Ooze Covered Truesilver Deposit"] = "軟泥覆蓋的真銀礦床"
--Translation missing 
L["Options"] = "Options"
--Translation missing 
L["Orb of the Sin'dorei"] = "Orb of the Sin'dorei"
L["Orc"] = "獸人"
--Translation missing 
L["Orphaned Felbat"] = "Orphaned Felbat"
L["Other"] = "其他"
L["Other Requirements"] = "其他需求"
--Translation missing 
L["Overcomplicated Controller"] = "Overcomplicated Controller"
--Translation missing 
L["Paladin"] = "Paladin"
L["Pandaren"] = "熊貓人"
--Translation missing 
L["Pandaren Firework Launcher"] = "Pandaren Firework Launcher"
--Translation missing 
L["Panflute of Pandaria"] = "Panflute of Pandaria"
L["Parrot Cage (Green Wing Macaw)"] = "鸚鵡籠(綠翼鸚鵡)"
L["Parrot Cage (Hyacinth Macaw)"] = "鸚鵡籠(藍紫金剛鸚鵡)"
--Translation missing 
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = "Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."
L["Patch of Elemental Water"] = "元素之水"
--Translation missing 
L["Periwinkle Calf"] = "Periwinkle Calf"
L["Phoenix Hatchling"] = "鳳凰寶寶"
--Translation missing 
L["Pineapple Lounge Cushion"] = "Pineapple Lounge Cushion"
--Translation missing 
L["Play a sound when groups are found"] = "Play a sound when groups are found"
L["Players have a personal loot chance to obtain this item."] = "玩家有個人的拾取機率來獲得此物品"
L["Please enter a comma-separated list of item IDs."] = "請輸入一個物品的ID列表並使用逗號分隔。"
L["Please enter a comma-separated list of NPC IDs."] = "請輸入一個NPC的ID列表並使用逗號分隔。"
--Translation missing 
L["Please enter a comma-separated list of Quest IDs."] = "Please enter a comma-separated list of Quest IDs."
--Translation missing 
L["Please enter a comma-separated list of Statistic IDs."] = "Please enter a comma-separated list of Statistic IDs."
L["Please enter a comma-separated list of zones."] = "請輸入一個使用逗號分隔的區域列表。"
L["Pool of Fire"] = "火池"
L["Porcupette"] = "刺蝟"
--Translation missing 
L["Priest"] = "Priest"
L["Primal Egg"] = "原生蛋"
--Translation missing 
L["Primary tooltip hide delay"] = "Primary tooltip hide delay"
--Translation missing 
L["Primary tooltip scale"] = "Primary tooltip scale"
L["Profile modified, rebooting"] = "配置已更改，重啟中"
L["Profiling OFF"] = "分析OFF"
L["Profiling ON"] = "分析ON"
L["Progress"] = "進度"
L["Progress Bar"] = "進度條"
--Translation missing 
L["Puddle Terror"] = "Puddle Terror"
--Translation missing 
L["Pugg"] = "Pugg"
--Translation missing 
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = "Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."
L["Pure Saronite Deposit"] = "純淨薩鋼礦床"
L["Pure Water"] = "純水"
--Translation missing 
L["Put \"Rarity:\" on a separate line"] = "Put \"Rarity:\" on a separate line"
--Translation missing 
L["Putricide's Alchemy Supplies"] = "Putricide's Alchemy Supplies"
L["Pygmy Direhorn"] = "侏儒恐角龍"
L["Pyrite Deposit"] = "黃鐵礦床"
--Translation missing 
L["Quest ID"] = "Quest ID"
L["Quivering Blob"] = "顫動血泡"
L["Raid Finder instance (legacy content; fixed at 25 players)"] = "隨機團隊副本(舊團隊；固定在25人)"
L["Raid Finder or Flexible difficulty"] = "隨機團隊或彈性難度"
--Translation missing 
L["Rarity has %d |4coordinate:coordinates; for this item."] = "Rarity has %d |4coordinate:coordinates; for this item."
--Translation missing 
L["Rarity is loading..."] = "Rarity is loading..."
--Translation missing 
L["Rarity Item Pack String"] = "Rarity Item Pack String"
--Translation missing 
L["Rarity Tooltip Options"] = "Rarity Tooltip Options"
--Translation missing 
L["Rarity: "] = "Rarity: "
L["Razzashi Hatchling"] = "小拉札希迅猛龍"
--Translation missing 
L["Red Goren Egg"] = "Red Goren Egg"
--Translation missing 
L["Red Helper Box"] = "Red Helper Box"
L["Red Qiraji Resonating Crystal"] = "紅色其拉共鳴水晶"
L["Redbelly Mandarin School"] = "紅肚桂花魚群"
--Translation missing 
L["Red-Hot Coal"] = "Red-Hot Coal"
L["Reef Octopus Swarm"] = "暗礁章魚群"
L["Reins of the Amber Primordial Direhorn"] = "琥珀原始恐角龍韁繩"
L["Reins of the Astral Cloud Serpent"] = "星界雲蛟韁繩"
L["Reins of the Azure Drake"] = "蒼藍龍韁繩"
L["Reins of the Black Primal Raptor"] = "黑色原始迅猛龍韁繩"
L["Reins of the Blazing Drake"] = "熾炎飛龍韁繩"
L["Reins of the Blue Drake"] = "藍龍韁繩"
L["Reins of the Blue Proto-Drake"] = "藍色元龍韁繩"
--Translation missing 
L["Reins of the Bone-White Primal Raptor"] = "Reins of the Bone-White Primal Raptor"
L["Reins of the Cobalt Primordial Direhorn"] = "鈷藍原始恐角龍韁繩"
--Translation missing 
L["Reins of the Crimson Water Strider"] = "Reins of the Crimson Water Strider"
L["Reins of the Drake of the North Wind"] = "北風之龍韁繩"
L["Reins of the Drake of the South Wind"] = "南風之龍韁繩"
L["Reins of the Grand Black War Mammoth"] = "巨大黑色戰爭長毛象韁繩"
L["Reins of the Green Primal Raptor"] = "綠色原始迅猛龍韁繩"
L["Reins of the Green Proto-Drake"] = "綠色元龍韁繩"
L["Reins of the Grey Riding Camel"] = "灰色騎乘駱駝韁繩"
L["Reins of the Heavenly Onyx Cloud Serpent"] = "瑪瑙穹天雲蛟韁繩"
--Translation missing 
L["Reins of the Infinite Timereaver"] = "Reins of the Infinite Timereaver"
L["Reins of the Jade Primordial Direhorn"] = "翠玉原始恐角龍韁繩"
L["Reins of the Onyxian Drake"] = "奧妮克希亞飛龍韁繩"
L["Reins of the Raven Lord"] = "烏鴉領主韁繩"
L["Reins of the Slate Primordial Direhorn"] = "石板原始恐角龍韁繩"
L["Reins of the Thundering Cobalt Cloud Serpent"] = "雷霆鈷藍雲蛟韁繩"
--Translation missing 
L["Reins of the Thundering Onyx Cloud Serpent"] = "Reins of the Thundering Onyx Cloud Serpent"
L["Reins of the Vitreous Stone Drake"] = "玻璃石龍韁繩"
L["Reins of the White Polar Bear"] = "白色北極熊韁繩"
--Translation missing 
L["Remains of a Blood Beast"] = "Remains of a Blood Beast"
L["Repeatable"] = "可重複"
L["Required for %s"] = "需要 %s"
L["Requires a pool"] = "需要一個池"
--Translation missing 
L["Requires Pickpocketing"] = "Requires Pickpocketing"
L["Rich Adamantite Deposit"] = "豐沃的堅鋼礦床"
L["Rich Blackrock Deposit"] = "豐沃的黑石礦床"
L["Rich Cobalt Deposit"] = "豐沃的鈷藍礦床"
L["Rich Elementium Vein"] = "豐沃的源質礦脈"
--Translation missing 
L["Rich Felslate Deposit"] = "Rich Felslate Deposit"
L["Rich Ghost Iron Deposit"] = "豐沃的鬼鐵礦脈"
L["Rich Kyparite Deposit"] = "豐沃的奇帕利礦床"
--Translation missing 
L["Rich Leystone Deposit"] = "Rich Leystone Deposit"
L["Rich Obsidium Deposit"] = "豐沃的黑曜石塊"
L["Rich Pyrite Deposit"] = "豐沃的黃鐵礦床"
L["Rich Saronite Deposit"] = "豐沃的薩鋼礦床"
L["Rich Thorium Vein"] = "富瑟銀礦脈"
L["Rich Trillium Vein"] = "豐沃的延齡礦脈"
L["Rich True Iron Deposit"] = "豐沃的真鐵礦床"
--Translation missing 
L["Riding Turtle"] = "Riding Turtle"
L["Right"] = "右"
L["Right-Aligned"] = "向右對齊"
--Translation missing 
L["Rime of the Time-Lost Mariner"] = "Rime of the Time-Lost Mariner"
--Translation missing 
L["Rogue"] = "Rogue"
--Translation missing 
L["Rotten Helper Box"] = "Rotten Helper Box"
L["Ruby Droplet"] = "小晶紅水靈"
--Translation missing 
L["Rukdug"] = "Rukdug"
--Translation missing 
L["Runescale Koi School"] = "Runescale Koi School"
--Translation missing 
L["Sack of Spectral Spiders"] = "Sack of Spectral Spiders"
--Translation missing 
L["Safari Lounge Cushion"] = "Safari Lounge Cushion"
L["Sagefish School"] = "鼠尾魚群"
--Translation missing 
L["Sahn Tidehunter"] = "Sahn Tidehunter"
--Translation missing 
L["Salyin Battle Banner"] = "Salyin Battle Banner"
--Translation missing 
L["Salyin Warscout"] = "Salyin Warscout"
L["Saronite Deposit"] = "薩鋼礦床"
--Translation missing 
L["Sassy Imp"] = "Sassy Imp"
L["Satyr Charm"] = "薩特符咒"
--Translation missing 
L["Savage Cub"] = "Savage Cub"
L["Savage Piranha Pool"] = "蠻荒食人魚池"
L["Scale"] = "比例"
L["Scenario instance"] = "事件副本"
L["Scepter of Azj'Aqir"] = "阿茲亞基權杖"
L["School of Darter"] = "淡水魚群"
L["School of Deviate Fish"] = "變異魚群"
L["School of Tastyfish"] = "可口魚群"
L["Schooner Wreckage"] = "漂浮的殘骸"
L["Schooner Wreckage Pool"] = "帆船殘骸區域"
L["Scorched Stone"] = "焦灼之石"
--Translation missing 
L["Scraps"] = "Scraps"
--Translation missing 
L["Sea Calf"] = "Sea Calf"
L["Sea Pony"] = "小海馬"
L["Sea Scorpion School"] = "海蠍群"
L["Sea Turtle"] = "海龜"
--Translation missing 
L["Seaborne Spore"] = "Seaborne Spore"
--Translation missing 
L["Secondary tooltip display"] = "Secondary tooltip display"
--Translation missing 
L["Servant of Demidos"] = "Servant of Demidos"
--Translation missing 
L["Servant's Bell"] = "Servant's Bell"
L["Session"] = "階段"
--Translation missing 
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = "Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."
--Translation missing 
L["Shadowhide Pearltusk"] = "Shadowhide Pearltusk"
--Translation missing 
L["Shaman"] = "Shaman"
--Translation missing 
L["Shard of Supremus"] = "Shard of Supremus"
--Translation missing 
L["Sha-Touched Spinefish"] = "Sha-Touched Spinefish"
L["Shell of Tide-Calling"] = "喚潮之殼"
L["Shift-Click to link your progress to chat"] = "Shift-點擊以輸出您的進度連結到聊天中"
L["Shift-Click to open options"] = "Shift-點擊以開啟選項"
L["Shipwreck Debris"] = "沉船殘骸"
L["Show anchor"] = "顯示描點"
L["Show attempts in tooltips"] = "在工具提示中顯示嘗試"
--Translation missing 
L["Show auto refresh checkbox"] = "Show auto refresh checkbox"
--Translation missing 
L["Show category icons"] = "Show category icons"
L["Show Icon"] = "顯示圖標"
--Translation missing 
L["Show Luckiness column"] = "Show Luckiness column"
L["Show minimap icon"] = "顯示小地圖圖示"
L["Show Text"] = "顯示文字"
--Translation missing 
L["Show Time column"] = "Show Time column"
--Translation missing 
L["Show Zone column"] = "Show Zone column"
L["Silver Vein"] = "銀礦脈"
--Translation missing 
L["Silver-Plated Turkey Shooter"] = "Silver-Plated Turkey Shooter"
L["Since last drop"] = "自從最後一次掉落"
--Translation missing 
L["Sira's Extra Cloak"] = "Sira's Extra Cloak"
--Translation missing 
L["Skrillix"] = "Skrillix"
--Translation missing 
L["Skull of a Frozen Whelp"] = "Skull of a Frozen Whelp"
L["Skunky Alemental"] = "惡臭酒元素"
--Translation missing 
L["Sky-Bo"] = "Sky-Bo"
L["Skyshard"] = "天裂片"
--Translation missing 
L["Slithershock Elver"] = "Slithershock Elver"
L["Small Obsidian Chunk"] = "小黑曜石塊"
L["Small Thorium Vein"] = "瑟銀礦脈"
--Translation missing 
L["Smashum Grabb"] = "Smashum Grabb"
--Translation missing 
L["Smelly Gravestone"] = "Smelly Gravestone"
--Translation missing 
L["Smoky Direwolf"] = "Smoky Direwolf"
L["Smoldering Egg of Millagazor"] = "密拉加卓的悶燃火鷹蛋"
--Translation missing 
L["Snarly's Bucket"] = "Snarly's Bucket"
--Translation missing 
L["Snow Mound"] = "Snow Mound"
--Translation missing 
L["Snowman Kit"] = "Snowman Kit"
L["Snowy Panda"] = "雪白小熊貓"
--Translation missing 
L["Solar Spirehawk"] = "Solar Spirehawk"
L["Son of Animus"] = "憎惡魔像之子"
L["Son of Galleon's Saddle"] = "「帆船」之子的鞍具"
--Translation missing 
L["Sorting by category, then name"] = "Sorting by category, then name"
L["Sorting by difficulty"] = "根據難度排序"
L["Sorting by name"] = "根據名稱排序"
L["Sorting by percent complete"] = "根據完成百分比排序"
--Translation missing 
L["Sorting by zone"] = "Sorting by zone"
L["Sparse Firefin Snapper School"] = "稀疏火鰭鯛魚群"
L["Sparse Oily Blackmouth School"] = "稀疏黑口魚群"
L["Sparse Schooner Wreckage"] = "稀疏漂浮的殘骸"
L["Spawn of Horridon"] = "哈里登的子嗣"
L["Special case"] = "特別案例"
--Translation missing 
L["Spectral Bell"] = "Spectral Bell"
L["Spell ID"] = "法術ID"
--Translation missing 
L["Spiky Collar"] = "Spiky Collar"
L["Spineclaw Crab"] = "虎鉗蟹"
L["Spinefish School"] = "棘魚群"
L["Sporefish School"] = "孢子魚群"
L["Sprite Darter Egg"] = "精龍的蛋"
L["Statistics"] = "統計"
L["Steam Pump Flotsam"] = "蒸汽幫浦漂浮殘骸"
--Translation missing 
L["Sting Ray Pup"] = "Sting Ray Pup"
L["Stonescale Eel Swarm"] = "石鱗鰻魚群"
--Translation missing 
L["Stormforged Rune"] = "Stormforged Rune"
L["Strand Crawler"] = "灘頭蟹"
L["Strange Pool"] = "奇怪的水池"
--Translation missing 
L["Sultry Grimoire"] = "Sultry Grimoire"
--Translation missing 
L["Sun Sproutling"] = "Sun Sproutling"
--Translation missing 
L["Sunblade Rune of Activation"] = "Sunblade Rune of Activation"
--Translation missing 
L["Sunfire Kaliri"] = "Sunfire Kaliri"
L["Sunfur Panda"] = "日毛小熊貓"
--Translation missing 
L["Swarm of Panicked Paddlefish"] = "Swarm of Panicked Paddlefish"
L["Swift Brewfest Ram"] = "迅捷啤酒節山羊"
L["Swift White Hawkstrider"] = "迅捷白色陸行鷹"
L["Swift Zulian Panther"] = "迅捷祖利安獵豹"
--Translation missing 
L["Syd the Squid"] = "Syd the Squid"
L["Tainted Core"] = "受污染的核心"
--Translation missing 
L["Tainted Maulclaw"] = "Tainted Maulclaw"
L["Take screenshots"] = "擷取螢幕擷圖"
--Translation missing 
L["Tangled Mantis Shrimp Cluster"] = "Tangled Mantis Shrimp Cluster"
L["Teeming Firefin Snapper School"] = "群聚火鰭鯛魚群"
L["Teeming Floating Wreckage"] = "群聚漂浮的殘骸"
L["Teeming Oily Blackmouth School"] = "群聚黑口魚群"
--Translation missing 
L["Terrorfist"] = "Terrorfist"
L["Texture"] = "材質"
--Translation missing 
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = "The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."
L["The Burning Crusade"] = "燃燒的遠征"
--Translation missing 
L["The following %d item(s) have been selected to export:"] = "The following %d item(s) have been selected to export:"
--Translation missing 
L["The Heartbreaker"] = "The Heartbreaker"
L["The Horseman's Reins"] = "無頭騎士韁繩"
--Translation missing 
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = "The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."
--Translation missing 
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = "The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."
L["The name you entered is already being used by another item. Please enter a unique name."] = "您輸入的名稱已經使用在別的物品，請輸入一個單獨的名稱。"
--Translation missing 
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = "The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."
--Translation missing 
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = "The number of players it takes to obtain the item. This will lower your chances of obtaining the item."
--Translation missing 
L["The Pigskin"] = "The Pigskin"
--Translation missing 
L["The quest starter item for Reins of the Llothien Prowler"] = "The quest starter item for Reins of the Llothien Prowler"
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = "Rarity選項模組已經關閉，從您的插件選單中啟用並且登出。"
--Translation missing 
L["The selected Rarity Item Pack string is invalid."] = "The selected Rarity Item Pack string is invalid."
--Translation missing 
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = "The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."
--Translation missing 
L["The Warbringer will be riding the mount color he has a chance to drop."] = "The Warbringer will be riding the mount color he has a chance to drop."
--Translation missing 
L["There are more holiday items available, but Rarity only reminds you about the first two."] = "There are more holiday items available, but Rarity only reminds you about the first two."
--Translation missing 
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = "These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = "This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."
--Translation missing 
L["This causes Rarity to put a blank line above its tooltip additions."] = "This causes Rarity to put a blank line above its tooltip additions."
--Translation missing 
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = "This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."
L["This item is only available to Alliance players."] = "此物品只有聯盟玩家可用。"
L["This item is only available to Horde players."] = "此物品只有部落玩家可用。"
L["This mount is only obtainable by Alliance players"] = "此坐騎只有聯盟玩家可獲得"
L["This mount is only obtainable by Horde players"] = "此坐騎只有部落玩家可獲得"
--Translation missing 
L["This tab lets you import and export items into and out of your Custom tab."] = "This tab lets you import and export items into and out of your Custom tab."
--Translation missing 
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = "This was a guaranteed drop for players who defeated the encounter when it was current"
L["Tiger Gourami School"] = "虎斑絲足魚群"
--Translation missing 
L["Tiger Gourami Slush"] = "Tiger Gourami Slush"
L["Time"] = "時間"
L["Time spent farming"] = "農花費時間"
L["Timeless Chest"] = "永恆寶箱"
--Translation missing 
L["Time-Locked Box"] = "Time-Locked Box"
--Translation missing 
L["Time-Lost Figurine"] = "Time-Lost Figurine"
--Translation missing 
L["Timewalker 5-player instance"] = "Timewalker 5-player instance"
L["Tin Vein"] = "錫礦脈"
L["Tiny Crimson Whelpling"] = "小紅龍寶寶"
L["Tiny Emerald Whelpling"] = "翡翠龍寶寶"
L["Tiny Fel Engine Key"] = "惡魔引擎鑰匙"
L["Titanium Vein"] = "泰坦鋼礦脈"
L[ [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=] ] = "要創建一個新物品，輸入一個物品的單獨名稱，並且點擊OK。如果伺服器沒有回報此物品連結或是物品是無效的則名稱已經被使用了。"
--Translation missing 
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = "To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."
--Translation missing 
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = "To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."
L["Today"] = "本日"
L["Toggles"] = "切換"
L["Tol'vir"] = "托維爾"
--Translation missing 
L["Tooltip can't be shown in combat"] = "Tooltip can't be shown in combat"
--Translation missing 
L["Toothy's Bucket"] = "Toothy's Bucket"
--Translation missing 
L["Torn Invitation"] = "Torn Invitation"
L["Total"] = "總計"
L["Total found"] = "總計發現"
L["Toxic Wasteling"] = "有毒小廢泥"
--Translation missing 
L["Toy or Item"] = "Toy or Item"
--Translation missing 
L["Toys & Items"] = "Toys & Items"
L["Track this"] = "追蹤這個"
L["Trillium Vein"] = "延齡礦脈"
L["Troll"] = "食人妖"
L["True Iron Deposit"] = "真鐵礦床"
L["Truesilver Deposit"] = "真銀礦床"
--Translation missing 
L["Tundra Icehoof"] = "Tundra Icehoof"
--Translation missing 
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = "Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = "啟用Rarity的小地圖圖標。如果您沒有LDB顯示插件可以使用此選項。"
L["Type of item"] = "物品類型"
--Translation missing 
L["Unable to retrieve item information from the server"] = "Unable to retrieve item information from the server"
L["Unavailable"] = "不可用"
L["Undefeated"] = "未擊倒"
L["Unknown"] = "未知"
L["Unlucky"] = "壞運"
L["unlucky"] = "壞運"
L["Unscathed Egg"] = "毫髮無傷的蛋"
--Translation missing 
L["Unstable Powder Box"] = "Unstable Powder Box"
--Translation missing 
L["Unusual Compass"] = "Unusual Compass"
--Translation missing 
L["Use your bonus roll for a chance at this item"] = "Use your bonus roll for a chance at this item"
L["Usually requires a group of around %d players"] = "通常需要%d位玩家的隊伍"
--Translation missing 
L["Valarjar Stormwing"] = "Valarjar Stormwing"
--Translation missing 
L["Vengeance"] = "Vengeance"
L["Verbose"] = "詳細的"
--Translation missing 
L["Vibrating Arcane Crystal"] = "Vibrating Arcane Crystal"
--Translation missing 
L["Vile Blood of Draenor"] = "Vile Blood of Draenor"
L["Viscidus Globule"] = "維希度斯淤泥怪"
--Translation missing 
L["Void Collar"] = "Void Collar"
L["Vrykul"] = "維酷"
--Translation missing 
L["Warlock"] = "Warlock"
L["Warlords of Draenor"] = "德拉諾之霸"
--Translation missing 
L["Warm Arcane Crystal"] = "Warm Arcane Crystal"
L["Warning Sign"] = "警告標誌 "
--Translation missing 
L["Warrior"] = "Warrior"
--Translation missing 
L["Warsong Direfang"] = "Warsong Direfang"
L["Waterlogged Wreckage"] = "浸水的殘骸"
L["Waterlogged Wreckage Pool"] = "浸水的殘骸"
--Translation missing 
L["Weebomination"] = "Weebomination"
L["Welcome to Rarity r%d. Your settings have been reset."] = "歡迎使用 Rarity r%d。 你的設定已被重置。"
--Translation missing 
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = "When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."
L["When enabled, Rarity tooltips will include how many attempts you've made."] = "如果啟用，提示中會包含你已經嘗試的次數。"
--Translation missing 
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = "When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."
--Translation missing 
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = "When enabled, Rarity will add obtainable items to game tooltips whenever possible."
--Translation missing 
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = "When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."
--Translation missing 
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = "When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."
--Translation missing 
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = "When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."
--Translation missing 
L["When on, items marked as Defeated will be hidden from the tooltip."] = "When on, items marked as Defeated will be hidden from the tooltip."
--Translation missing 
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = "When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."
--Translation missing 
L["When on, items that have no attempts yet will be hidden from the tooltip."] = "When on, items that have no attempts yet will be hidden from the tooltip."
--Translation missing 
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = "When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."
--Translation missing 
L[ [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=] ] = [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=]
--Translation missing 
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = "When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = "開啟時，當成就跳起指示您獲得一個物品，Rarity會擷取螢幕擷圖。"
--Translation missing 
L["When on, the Luckiness column will be shown in the main tooltip."] = "When on, the Luckiness column will be shown in the main tooltip."
--Translation missing 
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = "When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."
--Translation missing 
L["When on, the Time column will be shown in the main tooltip."] = "When on, the Time column will be shown in the main tooltip."
--Translation missing 
L["When on, the Zone column will be shown in the main tooltip."] = "When on, the Zone column will be shown in the main tooltip."
--Translation missing 
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = "When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."
--Translation missing 
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = "When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."
L["Whistle of Chromatic Bone"] = "炫彩骨頭之哨"
L["White Trillium Deposit"] = "白延齡礦石"
L["Width"] = "寬度"
--Translation missing 
L["Wild Dreamrunner"] = "Wild Dreamrunner"
--Translation missing 
L["Wild Goretusk"] = "Wild Goretusk"
--Translation missing 
L["will be imported"] = "will be imported"
--Translation missing 
L["Will only drop for druids."] = "Will only drop for druids."
--Translation missing 
L["Wisp in a Bottle"] = "Wisp in a Bottle"
--Translation missing 
L["World Tooltip Options"] = "World Tooltip Options"
--Translation missing 
L["Worn Troll Dice"] = "Worn Troll Dice"
L["Wrath of the Lich King"] = "巫妖王之怒"
--Translation missing 
L["Wriggling Darkness"] = "Wriggling Darkness"
L["Yesterday"] = "昨日"
--Translation missing 
L["You already defeated %d of them."] = "You already defeated %d of them."
--Translation missing 
L["You already defeated all of them."] = "You already defeated all of them."
--Translation missing 
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = "You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."
L["You entered a achievement ID that is already being used by another item."] = "您輸入的成就ID已被使用在其他物品。"
L["You entered a creature ID that is already being used by another item."] = "您輸入的生物ID已被使用在其他的物品。"
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = "你輸入了一個已被保留的名稱，請輸入在遊戲中出現的正確的物品名稱。"
L["You entered a spell ID that is already being used by another item."] = "您輸入的法術ID已被使用在其他物品。"
L["You entered an item ID that is already being used by another item."] = "您輸入的物品ID已被使用在其他物品。"
--Translation missing 
L["You entered an item ID that is already set as the collected item for something else."] = "You entered an item ID that is already set as the collected item for something else."
L["You must enter a creature ID."] = "您必須輸入一個人物ID"
L["You must enter a number larger than 0."] = "您必須輸入一個大於0的數字。"
L["You must enter a number larger than 1."] = "您必須輸入大於1的數字。"
L["You must enter a number larger than or equal to 0."] = "您必須輸入大於或等於0的數字。"
L["You must enter a spell ID."] = "你必須輸入一個法術ID"
L["You must enter a valid number."] = "您必須輸入一個正確的數字。"
L["You must enter an amount."] = "您必須輸入一個數量。"
L["You must enter an item ID."] = "你必須輸入一個物品ID"
L["You must enter at least one item ID."] = "你必須至少輸入一個物品ID。"
L["You must enter at least one NPC ID."] = "你必須至少輸入一個NPC ID。"
--Translation missing 
L["You must enter at least one Statistic ID."] = "You must enter at least one Statistic ID."
L["You must enter at least one zone."] = "你必須至少輸入一個區域"
--Translation missing 
L["Young Talbuk"] = "Young Talbuk"
--Translation missing 
L["Young Venomfang"] = "Young Venomfang"
--Translation missing 
L["Zandalari Anklerender"] = "Zandalari Anklerender"
--Translation missing 
L["Zandalari Footslasher"] = "Zandalari Footslasher"
--Translation missing 
L["Zandalari Kneebiter"] = "Zandalari Kneebiter"
--Translation missing 
L["Zandalari Toenibbler"] = "Zandalari Toenibbler"
--Translation missing 
L["Zangar Spore"] = "Zangar Spore"
--Translation missing 
L["Zhevra Lounge Cushion"] = "Zhevra Lounge Cushion"
--Translation missing 
L["Zomstrok"] = "Zomstrok"
--Translation missing 
L["Zone"] = "Zone"
L["Zones"] = "區域"

end

L = LibStub("AceLocale-3.0"):NewLocale("Rarity", "ptBR")
if L then
L[" (Group)"] = "(Grupo)"
L["#%d: %d attempt (%.2f%%)"] = "#%d: %d tentativa (%.2f%%)"
L["#%d: %d attempts (%.2f%%)"] = "#%d: %d tentativas (%.2f%%)"
--Translation missing 
L["%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"] = "%d |4waypoint:waypoints; |4is:are; located inside |4an instance:instances; and |4was:were; not added"
L["%d |4zone:zones;"] = "%d |4zonas:zonas;"
L["%d attempt"] = "%d tentativa"
L["%d attempt - %.2f%%"] = "%d tentativa - %.2f%%"
L["%d attempts"] = "%d tentativas"
L["%d attempts - %.2f%%"] = "%d tentativas - %.2f %%"
L["%d collected - %.2f%%"] = "%d coletado - %.2f%%"
L["%s: %d attempt"] = "%s: %d tentativa"
L["%s: %d attempt - %.2f%%"] = "%s: %d tentativa - %.2f%%"
L["%s: %d attempt (%d total)"] = "%s: %d tentativa (%d total)"
L["%s: %d attempts"] = "%s: %d tentativas"
L["%s: %d attempts - %.2f%%"] = "%s: %d tentativas - %.2f%%"
L["%s: %d attempts (%d total)"] = "%s: %d tentativas (%d total)"
L["%s: %d collected"] = "%s: %d coletado"
L["%s: 0/%d attempt so far (%.2f%% - %s)"] = "%s: 0/%d tentativa até agora (%.2f%% - %s)"
L["%s: 0/%d attempts so far (%.2f%% - %s)"] = "%s: 0/%d tentativas até agora (%.2f%% - %s)"
L["%s: collection completed!"] = "%s: coleção completada!"
L["%s: Found after %d attempts!"] = "%s: Encontrado depois de %d tentativas!"
L["%s: Found on the first attempt!"] = "%s: Encontrado na primeira tentativa!"
L["(%d/%d attempts)"] = "(%d/%d tentativas)"
L["(%d/%d collected)"] = "(%d/%d coletado)"
--Translation missing 
L["(Items listed in red could not be found on the server and may not exist. Consider removing them.)"] = "(Items listed in red could not be found on the server and may not exist. Consider removing them.)"
L["(running in debug mode)"] = "(executando no modo de depuração)"
--Translation missing 
L["(Warning: item could not be retrieved from server)"] = "(Warning: item could not be retrieved from server)"
L["1 in %d chance"] = "chance de 1 em %d"
--Translation missing 
L["10-player Heroic Raid instance (legacy content; not flexible)"] = "10-player Heroic Raid instance (legacy content; not flexible)"
--Translation missing 
L["10-player Raid instance (legacy content; not flexible)"] = "10-player Raid instance (legacy content; not flexible)"
--Translation missing 
L["25-player Event scenario"] = "25-player Event scenario"
L["25-player heroic"] = "25-jogadores heróico"
--Translation missing 
L["25-player Heroic Raid instance (legacy content; not flexible)"] = "25-player Heroic Raid instance (legacy content; not flexible)"
--Translation missing 
L["25-player Raid instance (legacy content; not flexible)"] = "25-player Raid instance (legacy content; not flexible)"
--Translation missing 
L["40-player Event raid"] = "40-player Event raid"
--Translation missing 
L["40-player Raid instance (legacy content; not flexible)"] = "40-player Raid instance (legacy content; not flexible)"
--Translation missing 
L["5-player Event instance"] = "5-player Event instance"
--Translation missing 
L["5-player Heroic instance"] = "5-player Heroic instance"
--Translation missing 
L["5-player instance"] = "5-player instance"
L["A comma-separated list of item IDs which, when used or opened, can give you this item. Use WowHead or a similar service to lookup item IDs."] = "Uma lista de IDs separados por vírgula de itens que, quando usados ou abertos, podem dar este item. Use o WowHead ou um serviço similar para procurar por IDs."
L["A comma-separated list of NPC IDs who drop this item. Use WowHead or a similar service to lookup NPC IDs."] = "Uma lista de IDs separados por vírgula de PNJs cujo saque pode conter este item. Use o WowHead ou um serviço similar para procurar por IDs de PNJs."
--Translation missing 
L["A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."] = "A comma-separated list of quest IDs. When these quest IDs are completed, the item is considered defeated."
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item."] = "Uma lista separada por vírgulas de IDs de Estatísticas que contam o número de mortes para obter este item."
L["A comma-separated list of Statistic IDs that track the number of kills toward obtaining this item. These statistics will be added together. Use WowHead or a similar service to locate statistic IDs."] = "Uma lista separada por vírgulas de IDs de Estatísticas que contam o número de mortes para obter este item. Estas estatísticas serão adicionadas juntas. Use o Wowhead ou um serviço similar para localizar IDs de estatísticas."
--Translation missing 
L[ [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=] ] = [=[A comma-separated list of the zones or sub-zones this item can be found in. For zones, you can enter either the Map ID (i.e. 811 is Vale of Eternal Blossoms), or the full name of the zone. For sub-zones, you must enter the full name of the sub-zone.

Enter zone names with proper spelling, capitalization, and punctuation. They can be entered either in US English or your client's local language. Use WowHead or a similar service to make sure you're entering the zone names perfectly.

PLEASE NOTE: Zone translations may not be correct. For zones, it is highly recommended that you use the Map ID instead of the name. For sub-zones, you must enter the name. If sub-zone detection isn't working for you, please visit the LibBabble-SubZone-3.0 library page on wowace.com and update the translations for your language.]=]
--Translation missing 
L["A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."] = "A dungeon ID which, when marked as completed by the game client, will cause this item to be considered Defeated. This is primarily used for holiday items which have unique dungeon IDs."
--Translation missing 
L["A holiday event is available today for %s! Go get it!"] = "A holiday event is available today for %s! Go get it!"
L["Abundant Bloodsail Wreckage"] = "Destroços Abundante dos Vela Sangrenta"
L["Abundant Firefin Snapper School"] = "Cardume Abundante de Pargo Pinafogo"
L["Abundant Oily Blackmouth School"] = "Cardume Abundante de Bocanera Oleoso"
--Translation missing 
L["Abyss Worm"] = "Abyss Worm"
L["Abyssal Gulper School"] = "Cardume de Boca-grandes Abissais"
L["Adamantite Deposit"] = "Depósito de Adamantita"
--Translation missing 
L["Added %d |4waypoint:waypoints; to TomTom"] = "Added %d |4waypoint:waypoints; to TomTom"
--Translation missing 
L["Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."] = "Adjusts the scale of the primary tooltip. This will take effect the next time the tooltip is shown."
--Translation missing 
L["After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."] = "After upgrading your garrison's Fishing Shack to level 3, fish up 5 minnows to summon a Cavedweller which can drop this mount."
--Translation missing 
L["Ageless Bronze Drake"] = "Ageless Bronze Drake"
--Translation missing 
L["Ahune"] = "Ahune"
--Translation missing 
L["Ai-Li's Skymirror"] = "Ai-Li's Skymirror"
--Translation missing 
L["Ai-Ran the Shifting Cloud"] = "Ai-Ran the Shifting Cloud"
--Translation missing 
L["Albino Buzzard"] = "Albino Buzzard"
L["Albino Cavefish School"] = "Cardume de Bagres-cegos Albinos"
--Translation missing 
L["Albino Chimaeraling"] = "Albino Chimaeraling"
L["Algaefin Rockfish School"] = "Cardume de Peixe-pedra Barbatalga"
--Translation missing 
L["All players can participate in killing this world boss once per week, regardless of faction"] = "All players can participate in killing this world boss once per week, regardless of faction"
--Translation missing 
L["All raid formats except Raid Finder"] = "All raid formats except Raid Finder"
L["Alliance only"] = "Apenas Aliança"
L["Already defeated"] = "Já derrotado"
L["Already defeated for %s"] = "Já derrotado para %s"
L["Already known"] = "Já se sabe"
--Translation missing 
L["an item already exists by this name, so it will not be imported"] = "an item already exists by this name, so it will not be imported"
--Translation missing 
L["an item with the same Item ID already exists, so it will not be imported"] = "an item with the same Item ID already exists, so it will not be imported"
L["Ancient Mana"] = "Mana Ancestral"
--Translation missing 
L["and %d |4other zone:other zones;"] = "and %d |4other zone:other zones;"
L["Announce"] = "Anunciar"
L["Announcements"] = "Anúncios"
--Translation missing 
L["Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."] = "Announcements will only be triggered when the item is found. When this is off, Rarity will announce every attempt and when the item is found."
L["Anubisath Idol"] = "Ídolo Anubisath"
--Translation missing 
L["Any difficulty"] = "Any difficulty"
--Translation missing 
L["Any raid size"] = "Any raid size"
--Translation missing 
L["Any raid size or difficulty"] = "Any raid size or difficulty"
--Translation missing 
L["Appears in the Black Market"] = "Appears in the Black Market"
--Translation missing 
L["Aqua Jewel"] = "Aqua Jewel"
--Translation missing 
L["Arakkoa"] = "Arakkoa"
--Translation missing 
L["Arcano-Shower"] = "Arcano-Shower"
L["Archaeology race"] = "Raça de arqueologia"
L["Are you sure you want to delete this item?"] = "Tem certeza de que deseja excluir este item?"
--Translation missing 
L["Are you sure you want to import the Rarity Item Pack you entered?"] = "Are you sure you want to import the Rarity Item Pack you entered?"
--Translation missing 
L["Are you sure you want to turn off the Export toggle for all your Custom items?"] = "Are you sure you want to turn off the Export toggle for all your Custom items?"
--Translation missing 
L["Armored Razorback"] = "Armored Razorback"
L["Armored Razzashi Raptor"] = "Raptor Razzashi Armadurado"
--Translation missing 
L["Ash-Covered Horn"] = "Ash-Covered Horn"
L["Ashes of Al'ar"] = "Cinzas de Al'ar"
L["Ashleaf Spriteling"] = "Duendezinho Folhacinza"
L["Attempts"] = "Tentativas"
--Translation missing 
L["Auto"] = "Auto"
--Translation missing 
L["Available starting December 25th"] = "Available starting December 25th"
L["Azure Crane Chick"] = "Filhote de Garça de Lazúli"
L["Azure Whelpling"] = "Dragonetinho Lazúli"
--Translation missing 
L["Battle Horn"] = "Battle Horn"
--Translation missing 
L["Battle Pet"] = "Battle Pet"
--Translation missing 
L["Battle Pets"] = "Battle Pets"
L["Big Love Rocket"] = "Foguetão do Amor"
--Translation missing 
L["Black Barracuda School"] = "Black Barracuda School"
L["Black Trillium Deposit"] = "Depósito de Trílio Negro"
L["Blackbelly Mudfish School"] = "Cardume de Muçuns-de-barriga-preta"
--Translation missing 
L["Blackflame Daggers"] = "Blackflame Daggers"
L["Blackfuse Bombling"] = "Bombinha Pavio Preto"
--Translation missing 
L["Blackhoof"] = "Blackhoof"
L["Blackrock Deposit"] = "Depósito de Rocha Negra"
L["Blackwater Whiptail School"] = "Cardume de Azorragues Aguanegra"
L["Blackwing Banner"] = "Estandarte Asa Negra"
--Translation missing 
L["Blank line before tooltip additions"] = "Blank line before tooltip additions"
L["Blazing Rune"] = "Runa Flamejante"
--Translation missing 
L["Bleakclaw"] = "Bleakclaw"
--Translation missing 
L["Blessed Seed"] = "Blessed Seed"
--Translation missing 
L["Blight Boar Microphone"] = "Blight Boar Microphone"
L["Blighted Spore"] = "Esporos Empesteados"
L["Blind Lake Sturgeon School"] = "Cardume de Esturjões Cegos do Lago"
L["Bloodsail Wreckage"] = "Destroços dos Vela Sangrenta"
L["Bloodsail Wreckage Pool"] = "Destroços dos Vela Sangrenta"
L["Bluefish School"] = "Cardume de Azulinhos"
--Translation missing 
L["Bone Serpent"] = "Bone Serpent"
L["Bonkers"] = "Pauladas"
L["Borean Man O' War School"] = "Cardume de Caravelas Boreanas"
--Translation missing 
L["Boss Name"] = "Boss Name"
--Translation missing 
L["Bottled Tornado"] = "Bottled Tornado"
L["Brackish Mixed School"] = "Cardume Misto Salobre"
--Translation missing 
L["Brew Frenzied Emperor Salmon"] = "Brew Frenzied Emperor Salmon"
L["Brilliant Phoenix Hawk Feather"] = "Pena Brilhante de Águia Fênix"
--Translation missing 
L["Brinedeep Bottom-Feeder"] = "Brinedeep Bottom-Feeder"
--Translation missing 
L["Bristling Hellboar"] = "Bristling Hellboar"
--Translation missing 
L["Bronze Proto-Whelp"] = "Bronze Proto-Whelp"
L["Bunny Hunter is running. Would you like Rarity to import data from Bunny Hunter now? Disable Bunny Hunter or click Yes if you don't want to be asked again."] = "Bunny Hunter está em execução. Você gostaria que o Rarity importasse os dados do Bunny Hunter agora? Desative o Bunny Hunter ou clique em Sim se você não quiser ser perguntado de novo."
--Translation missing 
L["Burgy Blackheart's Handsome Hat"] = "Burgy Blackheart's Handsome Hat"
--Translation missing 
L["Call of the Frozen Blade"] = "Call of the Frozen Blade"
--Translation missing 
L["Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."] = "Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."
--Translation missing 
L["Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."] = "Can be contained in Keg-Shaped Treasure Chest, rewarded for defeating the World Event Dungeon during Brewfest."
--Translation missing 
L["Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."] = "Can be contained in Loot-Filled Pumpkin, rewarded for defeating the World Event Dungeon during Hallow's End."
--Translation missing 
L["Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."] = "Can be obtained from Rattling Iron Cage, which has a chance to drop from any of the four champions of Hellfire Citadel in Tanaan Jungle (Terrorfist, Deathtalon, Vengeance, or Doomroller). Each of them can be looted once per day. Rarity will consider this mount \"defeated\" for the day when you kill any of the four."
--Translation missing 
L["Can be obtained with a bonus roll"] = "Can be obtained with a bonus roll"
--Translation missing 
L["Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."] = "Can drop from Fel-Touched Pet Supplies, which is obtained by defeating the Fel-corrupted legendary pets in Tanaan Jungle."
L["Captured Firefly"] = "Vaga-lume Capturado"
L["Cat Carrier (Black Tabby)"] = "Transportador de Gato (Tigrado Preto)"
L["Cataclysm"] = "Cataclismo"
--Translation missing 
L["Cavern Moccasin"] = "Cavern Moccasin"
--Translation missing 
L["Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"] = "Certain items, such as Illusions in your wardrobe, flag a completed Quest ID when you learn them. Rarity can automatically stop tracking this item if you enter that Quest ID here. (Only one ID, not a list.)"
--Translation missing 
L["Chain Pet Leash"] = "Chain Pet Leash"
--Translation missing 
L["Chalice of Secrets"] = "Chalice of Secrets"
--Translation missing 
L["Challenge Mode instance"] = "Challenge Mode instance"
L["Chance"] = true
L["Chance so far"] = "Chances até agora"
--Translation missing 
L["Chaos Pup"] = "Chaos Pup"
--Translation missing 
L["Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."] = "Check this for every Custom item you wish to export. Then click on the Import/Export tab and click the Export button. This checkbox will be disabled until enough information has been filled in below to make it a detectable item."
--Translation missing 
L[ [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=] ] = [=[Check this to automatically refresh your search every 5 seconds while this window is visible. Auto refresh only works if you've typed something in the search box, and if you haven't selected something in the list below.

This checkbox is provided by Rarity. You can hide the checkbox in Rarity options.]=]
--Translation missing 
L["Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."] = "Choose which classes this item should be disabled for. Checking a class below hides the item from the Rarity tooltip and prevents it from being tracked. You can still toggle Track This, but the item will not track for any classes specified here."
--Translation missing 
L["Christoph VonFeasel"] = "Christoph VonFeasel"
--Translation missing 
L["Chromie"] = "Chromie"
--Translation missing 
L["Chuck's Bucket"] = "Chuck's Bucket"
--Translation missing 
L["Classic"] = "Classic"
--Translation missing 
L["Clear All Exports"] = "Clear All Exports"
L["Click to switch to this item"] = "Clique para trocar para este item"
L["Click to toggle the progress bar"] = "Clique para alternar a barra de progresso"
--Translation missing 
L["Clockwork Rocket Bot"] = "Clockwork Rocket Bot"
--Translation missing 
L["Close"] = "Close"
--Translation missing 
L["Cloudwing Hippogryph"] = "Cloudwing Hippogryph"
L["Clutch of Ji-Kun"] = "Garra de Ji-Kun"
L["Cobalt Deposit"] = "Depósito de Cobalto"
--Translation missing 
L["Coin of Many Faces"] = "Coin of Many Faces"
L["Collect %d %s"] = "Coletar %d %s"
L["Collected"] = "Coletado"
L["Collection Complete"] = "Coleção completa"
L["Collection complete!"] = "Coleção completa!"
L["Collection Size"] = "Tamanho da coleção"
--Translation missing 
L["Contained in bonus satchels"] = "Contained in bonus satchels"
--Translation missing 
L["Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."] = "Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."
--Translation missing 
L["Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."] = "Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."
--Translation missing 
L["Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."] = "Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."
--Translation missing 
L["Content Category"] = "Content Category"
--Translation missing 
L["Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."] = "Controls on which side the secondary tooltip appears when you hover over an item in the main tooltip. If the main tooltip is on the right side of your screen, change this to Left. Otherwise, choose Right. You can also hide the status tooltip completely."
L["Controls what type of text is shown in Rarity's LDB feed. Minimal shows just the number of attempts. Normal adds the likelihood percent, and verbose adds the item link."] = "Controla que tipo de texto é mostrado no feed LDB do Rarity. O mínimo mostra apenas o número de tentativas. O normal adiciona a percentagem de probabilidade, e o Prolixo adiciona o link do item."
L["Copper Vein"] = "Veio de Cobre"
--Translation missing 
L[ [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=] ] = [=[Copy the generated Rarity Item Pack string below using Ctrl-C. You can then paste it elsewhere using Ctrl-V.

Feel free to comment on the Curse web site to share your Item Pack. Allara will promote the best ones to the main add-on page.]=]
L["Core of Hardened Ash"] = "Núcleo de Cinzas Endurecidas"
--Translation missing 
L["Corrupted Nest Guardian"] = "Corrupted Nest Guardian"
--Translation missing 
L["Corrupted Thundertail"] = "Corrupted Thundertail"
L["Crane Nest"] = "Ninho de Garça"
--Translation missing 
L["Crashin' Thrashin' Cannon Controller"] = "Crashin' Thrashin' Cannon Controller"
--Translation missing 
L["Crashin' Thrashin' Flyer Controller"] = "Crashin' Thrashin' Flyer Controller"
--Translation missing 
L["Crashin' Thrashin' Mortar Controller"] = "Crashin' Thrashin' Mortar Controller"
--Translation missing 
L["Crashin' Thrashin' Racer Controller"] = "Crashin' Thrashin' Racer Controller"
--Translation missing 
L["Crashin' Thrashin' Roller Controller"] = "Crashin' Thrashin' Roller Controller"
L["Create a New Item"] = "Criar um Novo Item"
L["Create a new item to track"] = "Criar um novo item para rastrear"
L["Creature ID"] = "ID da criatura"
--Translation missing 
L["Crowded Redbelly Mandarin"] = "Crowded Redbelly Mandarin"
--Translation missing 
L["Crysa"] = "Crysa"
L["Crystal of the Void"] = "Cristal do Caos"
L["Ctrl-Click to change sort order"] = "Ctrl-Clique para mudar a ordem de classificação"
--Translation missing 
L["Ctrl-Click to create the remaining TomTom waypoint(s)."] = "Ctrl-Click to create the remaining TomTom waypoint(s)."
--Translation missing 
L["Ctrl-Click to create TomTom waypoint(s)."] = "Ctrl-Click to create TomTom waypoint(s)."
--Translation missing 
L["Cupri"] = "Cupri"
L["Curious Wyrmtongue Cache"] = "Baú de Língua de Serpe Singular"
--Translation missing 
L["Cursed Queenfish School"] = "Cursed Queenfish School"
--Translation missing 
L["Cursed Spirit"] = "Cursed Spirit"
L["Custom"] = "Personalizado"
--Translation missing 
L["Dandelion Frolicker"] = "Dandelion Frolicker"
--Translation missing 
L["Dark Gazer"] = "Dark Gazer"
L["Dark Iron Deposit"] = "Depósito de Ferro Negro"
L["Dark Quivering Blob"] = "Bolha Escura Trêmula"
L["Dark Whelpling"] = "Dragonetinho Negro"
L["Darkmoon Eye"] = "Olho de Negraluna"
L["Data has been imported from Bunny Hunter"] = "Os dados foram importados do Bunny Hunter"
L["Death Adder Hatchling"] = "Pequena Áspide da Morte"
--Translation missing 
L["Death Knight"] = "Death Knight"
L["Deathcharger's Reins"] = "Rédeas do Corcel da Morte"
--Translation missing 
L["Deathtalon"] = "Deathtalon"
--Translation missing 
L["Debug mode"] = "Debug mode"
L["Debug mode OFF"] = "Modo de depuração DESLIGADO"
L["Debug mode ON"] = "Modo de depuração LIGADO"
--Translation missing 
L["Decahedral Dwarven Dice"] = "Decahedral Dwarven Dice"
L["Deep Sea Monsterbelly School"] = "Cardume de Pançudos do Mar Profundo"
L["Deepsea Sagefish School"] = "Cardume de Sabichões Abissais"
--Translation missing 
L["Defeat Detection"] = "Defeat Detection"
L["Defeated"] = "Derrotado"
--Translation missing 
L["Defiled Earth"] = "Defiled Earth"
L["Delete this item"] = "Excluir este item"
--Translation missing 
L["Demon Hunter"] = "Demon Hunter"
--Translation missing 
L["Demonic"] = "Demonic"
L["Determines how this item is obtained."] = "Determina como este item é obtido."
L["Determines what type of item this is."] = "Determina que tipo de item este é."
L["Determines whether the item can only be obtained from fishing in pools. In order for this option to work, the fishing pools must have all been translated into your client's language."] = "Determina se o item só pode ser obtido ao pescar em cardumes. Para que esta opção funcione, os cardumes devem estar traduzidos para o idioma do seu cliente."
L["Determines whether tracking should be enabled for this item. Items that are disabled will not appear in the tooltip."] = "Determina se o rastreamento deve ser ativado para este item. Itens que são desativados não aparecerão na dica de tela."
L["Determines whether you want to repeatedly farm this item. If you turn this on and find the item, Rarity will mark the item as un-found after a few seconds."] = "Determina se você quer \"farmar\" este item repetidamente. Se você ligar isto e encontrar o item, o Rarity marcará o item como \"não encontrado\" em alguns segundos."
--Translation missing 
L[ [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=] ] = [=[Determines which instance difficulties this item may be obtained in. Leave everything unchecked if the instance difficulty doesn't matter.

If you specified a Statistic ID for this item, the Instance Difficulty is probably meaningless, because all modern statistics already incorporate the difficulty.

You can check multiple items in this list at once.]=]
L["Determines which race includes this archaeology project."] = "Determina qual raça inclui este projeto de arqueologia."
L["Deviate Hatchling"] = "Filhote Anormal"
--Translation missing 
L["Direflame"] = "Direflame"
L["Direhorn Runt"] = "Escornante Nanico"
--Translation missing 
L["Disable for classes"] = "Disable for classes"
L["Disgusting Oozeling"] = "Gosmícula Nojenta"
--Translation missing 
L["Displacer Meditation Stone"] = "Displacer Meditation Stone"
--Translation missing 
L["Distance"] = "Distance"
--Translation missing 
L["Don Carlos' Famous Hat"] = "Don Carlos' Famous Hat"
--Translation missing 
L["Doomroller"] = "Doomroller"
L["Draenei"] = true
--Translation missing 
L["Draenor Clans"] = "Draenor Clans"
--Translation missing 
L["Draenor Garrison"] = "Draenor Garrison"
L["Dragonfin Angelfish School"] = "Cardume de Acarás-bandeira Pinadragos"
--Translation missing 
L["Drakum"] = "Drakum"
--Translation missing 
L["Dreadwalker"] = "Dreadwalker"
L["Dripping Strider Egg"] = "Ovo de Moa Pingante"
--Translation missing 
L["Droplet of Y'Shaarj"] = "Droplet of Y'Shaarj"
--Translation missing 
L["Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."] = "Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."
--Translation missing 
L["Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."] = "Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."
--Translation missing 
L["Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."] = "Dropped by Disturbed Podling, which has a chance to spawn when picking herbs in Draenor."
--Translation missing 
L["Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"] = "Dropped by Elegon in Mogu'shan Vaults (all raid formats except Raid Finder)"
--Translation missing 
L["Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."] = "Dropped by Goren Protector, which has a chance to spawn when mining ore in Draenor."
--Translation missing 
L["Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."] = "Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."
--Translation missing 
L["Dropped by Malygos in The Eye of Eternity (any raid size)"] = "Dropped by Malygos in The Eye of Eternity (any raid size)"
--Translation missing 
L["Dropped by Onyxia in Onyxia's Lair (any raid size)"] = "Dropped by Onyxia in Onyxia's Lair (any raid size)"
--Translation missing 
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"] = "Dropped by the Madness of Deathwing encounter in Dragon Soul (any raid size or difficulty)"
--Translation missing 
L["Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"] = "Dropped by the Madness of Deathwing encounter in Dragon Soul (heroic, any raid size)"
--Translation missing 
L["Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"] = "Dropped by Ultraxion in Dragon Soul (any raid size or difficulty)"
--Translation missing 
L["Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"] = "Dropped by Yogg-Saron in Ulduar (25-player) with no Keepers assisting"
--Translation missing 
L["Dropped from dinosaurs on Isle of Giants"] = "Dropped from dinosaurs on Isle of Giants"
--Translation missing 
L["Dropped from monsters in Fang'rila"] = "Dropped from monsters in Fang'rila"
L["Drops from a boss requiring a group"] = "Saqueado de um chefe, necessitando um grupo"
L["Drops from any mob in a zone"] = "Saqueado de qualquer mob em uma zona"
L["Drops from NPC(s)"] = "Saqueado de NPC(s)"
--Translation missing 
L["Drudge Remains"] = "Drudge Remains"
--Translation missing 
L["Druid"] = "Druid"
--Translation missing 
L["Dungeon ID"] = "Dungeon ID"
L["Dusty Clutch of Eggs"] = "Ninhada de Ovos Empoeirados"
L["Dwarf"] = "Anão"
--Translation missing 
L["Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."] = "Earned by giving 9999 Giant Dinosaur Bones to Ku'ma on Isle of Giants. Giant Dinosaur bones drop from all dinosaurs and Zandalari Dinomancers on Isle of Giants."
L["Elementium Geode"] = "Geodo de Elemêntio"
L["Elementium Vein"] = "Veio de Elemêntio"
L["Emperor Salmon School"] = "Cardume de Salmões Imperiais"
L["Enable announcements"] = "Ativar anúncios"
--Translation missing 
L["Enable Coins"] = "Enable Coins"
--Translation missing 
L["Enable profiling"] = "Enable profiling"
--Translation missing 
L["Enable tooltip additions"] = "Enable tooltip additions"
L["Enables announcements whenever you complete a new attempt toward anything Rarity is tracking. You can also enable announcements per-item, but this is the master switch."] = "Ativa anúncios para quando você completa uma nova tentativa de qualquer coisa que o Rarity esteja rastreando. Você pode também ativar anúncios por item, mas esta é a chave mestra."
L["Enables announcements whenever you complete a new attempt toward this item."] = "Ativa anúncios para quando você completa uma nova tentativa deste item."
--Translation missing 
L["Enter 1 or leave this blank to mark the item as soloable."] = "Enter 1 or leave this blank to mark the item as soloable."
L["Equal odds"] = "Chances iguais"
--Translation missing 
L["Error compressing item pack"] = "Error compressing item pack"
--Translation missing 
L["Error encoding item pack"] = "Error encoding item pack"
--Translation missing 
L["Error serializing item pack"] = "Error serializing item pack"
--Translation missing 
L["Essence of the Breeze"] = "Essence of the Breeze"
--Translation missing 
L["Eternal Kiln"] = "Eternal Kiln"
--Translation missing 
L["Eternal Warrior's Sigil"] = "Eternal Warrior's Sigil"
--Translation missing 
L["Everliving Spore"] = "Everliving Spore"
L["Every item ID must be a number greater than 0."] = "O ID do item deve ser maior que 0."
L["Every NPC ID must be a number greater than 0."] = "O ID do PNJ deve ser maior que 0."
--Translation missing 
L["Every Quest ID must be a number greater than 0."] = "Every Quest ID must be a number greater than 0."
L["Experiment 12-B"] = "Experimento 12-B"
--Translation missing 
L["Export"] = "Export"
--Translation missing 
L["Export Rarity Item Pack"] = "Export Rarity Item Pack"
--Translation missing 
L["Export this item"] = "Export this item"
--Translation missing 
L["Eye of Inquisition"] = "Eye of Inquisition"
--Translation missing 
L["Faintly Glowing Flagon of Mead"] = "Faintly Glowing Flagon of Mead"
--Translation missing 
L["Fandral's Seed Pouch"] = "Fandral's Seed Pouch"
L["Fangtooth Herring School"] = "Cardume de Arenques Presadentes"
--Translation missing 
L["Farwater Conch"] = "Farwater Conch"
L["Fat Sleeper School"] = "Cardume de Pestanas Gordos"
--Translation missing 
L["Fathom Dweller"] = "Fathom Dweller"
L["Fathom Eel Swarm"] = "Grande Cardume de Enguias de Profundeza"
L["Feed text"] = "Texto de Feed"
L["Fel Iron Deposit"] = "Depósito de Ferrovil"
--Translation missing 
L["Felfly"] = "Felfly"
--Translation missing 
L["Felslate Deposit"] = "Felslate Deposit"
--Translation missing 
L["Felslate Seam"] = "Felslate Seam"
--Translation missing 
L["Felsteel Annihilator"] = "Felsteel Annihilator"
--Translation missing 
L["Felsworn Sentry"] = "Felsworn Sentry"
L["Feltail School"] = "REMOVIDO NA PATCH 2.4"
--Translation missing 
L["Fever of Stormrays"] = "Fever of Stormrays"
L["Fiery Warhorse's Reins"] = "Rédeas do Cavalo de Guerra Fogoso"
L["Fire Ammonite School"] = "Cardume de Amonitas de Fogo"
L["Firefin Snapper School"] = "Cardume de Pargos Pinafogos"
--Translation missing 
L["Firewing"] = "Firewing"
--Translation missing 
L["Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"] = "Fished anywhere in Draenor (except your garrison) with the help of Nat Pagle"
L["Flametalon of Alysrazor"] = "Garrachama de Alysrazor"
L["Floating Debris"] = "Destroços Flutuantes"
L["Floating Debris Pool"] = "Destroços Flutuantes"
L["Floating Shipwreck Debris"] = "Destroços do Naufrágio"
L["Floating Wreckage"] = "Destroços Flutuantes"
L["Floating Wreckage Pool"] = "Destroços Flutuantes"
--Translation missing 
L["Font"] = "Font"
--Translation missing 
L["Font Size"] = "Font Size"
--Translation missing 
L["Foot Ball"] = "Foot Ball"
L["Fossil"] = "Fóssil"
L["Fossilized Raptor"] = "Raptor Fossilizado"
L["Found after %d attempts!"] = "Encontrado após %d tentativas!"
--Translation missing 
L["Found in: "] = "Found in: "
L["Found on your first attempt!"] = "Encontrado na sua primeira tentativa!"
L["Fox Kit"] = "Filhote de Raposa"
--Translation missing 
L["Fragment of Anger"] = "Fragment of Anger"
--Translation missing 
L["Fragment of Desire"] = "Fragment of Desire"
--Translation missing 
L["Fragment of Frozen Bone"] = "Fragment of Frozen Bone"
--Translation missing 
L["Fragment of Suffering"] = "Fragment of Suffering"
--Translation missing 
L["Frenzyheart Brew"] = "Frenzyheart Brew"
--Translation missing 
L["Frightened Bush Chicken"] = "Frightened Bush Chicken"
--Translation missing 
L["Fuzzy Green Lounge Cushion"] = "Fuzzy Green Lounge Cushion"
--Translation missing 
L["Gahz'rooki's Summoning Stone"] = "Gahz'rooki's Summoning Stone"
--Translation missing 
L["Gar'lok"] = "Gar'lok"
--Translation missing 
L["Garn Nighthowl"] = "Garn Nighthowl"
--Translation missing 
L["Garn Steelmaw"] = "Garn Steelmaw"
--Translation missing 
L["Garrison Invasion Gold Victory"] = "Garrison Invasion Gold Victory"
--Translation missing 
L["Garrison Invasion Platinum Victory"] = "Garrison Invasion Platinum Victory"
--Translation missing 
L["Gastropod Shell"] = "Gastropod Shell"
L["General"] = "Geral"
L["General Options"] = "Opções gerais"
L["Ghost Iron Deposit"] = "Depósito de Ferro Fantasma"
--Translation missing 
L["Giant Coldsnout"] = "Giant Coldsnout"
L["Giant Mantis Shrimp Swarm"] = "Enxame de Camarões-grilo Gigantes"
L["Giant Sewer Rat"] = "Rato Gigante de Esgoto"
--Translation missing 
L["Giant Worm Egg"] = "Giant Worm Egg"
--Translation missing 
L["Gibblette the Cowardly"] = "Gibblette the Cowardly"
L["Glacial Salmon School"] = "Cardume de Salmões Glaciais"
L["Glassfin Minnow School"] = "Cardume de Manjubinhas Galhavítreas"
--Translation missing 
L["Glimmering Jewel Danio Pool"] = "Glimmering Jewel Danio Pool"
L["Glimmering Treasure Chest"] = "Baú do Tesouro Luzente"
--Translation missing 
L["Glittering Arcane Crystal"] = "Glittering Arcane Crystal"
--Translation missing 
L["Glittering Ball of Yarn"] = "Glittering Ball of Yarn"
--Translation missing 
L["Glowing Jade Lungfish"] = "Glowing Jade Lungfish"
L["Gluth's Bone"] = "Osso de Gluth"
L["Gold Vein"] = "Veio de Ouro"
L["Golden Carp School"] = "Cardume de Carpas Douradas"
--Translation missing 
L["Gondar"] = "Gondar"
--Translation missing 
L["Gooey Sha-ling"] = "Gooey Sha-ling"
--Translation missing 
L["Goren \"Log\" Roller"] = "Goren \"Log\" Roller"
L["Great Brewfest Kodo"] = "Grande Kodo da CervaFest"
L["Greater Sagefish School"] = "Grande Cardume de Sabichões"
--Translation missing 
L["Greatfather Winter's Tree"] = "Greatfather Winter's Tree"
--Translation missing 
L["Green Helper Box"] = "Green Helper Box"
--Translation missing 
L["Grotesque Statue"] = "Grotesque Statue"
--Translation missing 
L["Group Finder Options"] = "Group Finder Options"
L["Group size"] = "Tamanho do grupo"
--Translation missing 
L["Group(s) found!"] = "Group(s) found!"
--Translation missing 
L["Grow Up"] = "Grow Up"
--Translation missing 
L["Grumpling"] = "Grumpling"
--Translation missing 
L["Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."] = "Guaranteed drop from Dormus the Camel-Hoarder. Accessing this encounter requires finding a rare Mysterious Camel Figurine in Uldum. These are difficult to spot and, when clicked, have a small chance to grant you access to the Dormus encounter. Rarity will count how many Figurines you've found if you mouseover them."
--Translation missing 
L["Gu'chi Swarmling"] = "Gu'chi Swarmling"
--Translation missing 
L["Guk"] = "Guk"
--Translation missing 
L["Gulp Froglet"] = "Gulp Froglet"
L["Gundrak Hatchling"] = "Filhote de Gundrak"
L["Half-Empty Food Container"] = "Recipiente de Comida Meio Vazio"
--Translation missing 
L["Hardened Shell"] = "Hardened Shell"
L["Height"] = "Altura"
--Translation missing 
L["Helpful Wikky's Whistle"] = "Helpful Wikky's Whistle"
--Translation missing 
L["Here is a preview of what will (or won't) be imported:"] = "Here is a preview of what will (or won't) be imported:"
--Translation missing 
L["Heroic difficulty"] = "Heroic difficulty"
--Translation missing 
L["Heroic Raid (10-30 players)"] = "Heroic Raid (10-30 players)"
--Translation missing 
L["Heroic Scenario instance"] = "Heroic Scenario instance"
--Translation missing 
L["Heroic, any raid size"] = "Heroic, any raid size"
L["Hidden"] = "Oculto"
--Translation missing 
L["Hide defeated items"] = "Hide defeated items"
--Translation missing 
L["Hide high chance items"] = "Hide high chance items"
--Translation missing 
L["Hide items not in your zone"] = "Hide items not in your zone"
--Translation missing 
L["Hide items with no attempts"] = "Hide items with no attempts"
L["Hide unavailable items"] = "Ocultar itens indisponíveis"
--Translation missing 
L["High Priest of Ordos"] = "High Priest of Ordos"
--Translation missing 
L["Highborne"] = "Highborne"
L["Highland Guppy School"] = "Cardume de Lebiste das Terras Altas"
L["Highland Mixed School"] = "Cardume Misto das Terras Altas"
--Translation missing 
L["Highmountain Elderhorn"] = "Highmountain Elderhorn"
--Translation missing 
L["Highmountain Salmon School"] = "Highmountain Salmon School"
--Translation missing 
L["Highmountain Tauren"] = "Highmountain Tauren"
L["Holiday"] = "Feriado"
L["Holiday reminders"] = "Lembretes de férias"
L["Hollow Reed"] = "Junco Oco"
L["Horde only"] = "Apenas Horda"
L["How likely the item is to appear, expressed as 1 in X, where X is the number you enter here."] = "A probabilidade do item de aparecer, expressado como 1 em X, sendo X o número que você insere aqui."
L["How many attempts you've made so far."] = "Quantas tentativas você fez até agora."
L["How many items you need to collect."] = "Quantos itens você precisa coletar."
L["How many items you've collected so far."] = "Quantos itens você coletou até agora."
--Translation missing 
L["Hozen Beach Ball"] = "Hozen Beach Ball"
L["Huge Obsidian Slab"] = "Grande Pilha de Obsidios"
--Translation missing 
L["Hunter"] = "Hunter"
--Translation missing 
L["Hyjal Wisp"] = "Hyjal Wisp"
L["Ice Chip"] = "Lasca de Gelo"
L["Identify the Item"] = "Identifique o Item"
L["Imbued Jade Fragment"] = "Fragmentos de Jade Imbuídos"
L["Imperial Manta Ray School"] = "Cardume de Arraias-jamanta Imperiais"
--Translation missing 
L["Imperial Moth"] = "Imperial Moth"
--Translation missing 
L["Imperial Silkworm"] = "Imperial Silkworm"
--Translation missing 
L["Imp-Master Valessa"] = "Imp-Master Valessa"
--Translation missing 
L["Import"] = "Import"
--Translation missing 
L["Import Rarity Item Pack"] = "Import Rarity Item Pack"
--Translation missing 
L["Import/Export"] = "Import/Export"
--Translation missing 
L["imported successfully"] = "imported successfully"
L["Incendicite Mineral Vein"] = "Veio de Incendicita"
L["Indurium Mineral Vein"] = "Mineral Indurio"
--Translation missing 
L["Install TomTom to enable waypoint creation."] = "Install TomTom to enable waypoint creation."
--Translation missing 
L["Instance Difficulty"] = "Instance Difficulty"
L["Instant Arcane Sanctum Security Kit"] = "Kit de Segurança Instantâneo do Sacrário Arcano"
L["Invincible's Reins"] = "Rédeas do Invencível"
L["Iron Deposit"] = "Depósito de Ferro"
--Translation missing 
L["Ironbound Collar"] = "Ironbound Collar"
--Translation missing 
L["Ironhoof Destroyer"] = "Ironhoof Destroyer"
L["Item ID"] = "ID do Item"
--Translation missing 
L["Item ID to Collect"] = "Item ID to Collect"
L["Items to Use"] = "Itens para Usar"
L["Jade Lungfish School"] = "Cardume de Piramboias de Jade"
--Translation missing 
L["Jadefire Spirit"] = "Jadefire Spirit"
--Translation missing 
L["Jademist Dancer"] = "Jademist Dancer"
L["Jawless Skulker School"] = "Cardume de Sorrateiros Sem-queixo"
--Translation missing 
L["Jeremy Feasel"] = "Jeremy Feasel"
L["Jewel Danio School"] = "Cardume de Peixes-zebra"
L["Jewel of Maddening Whispers"] = "Joia dos Sussurros Enlouquecedores"
L["Ji-Kun Hatchling"] = "Filhote de Ji-Kun"
--Translation missing 
L["Jingling Bell"] = "Jingling Bell"
--Translation missing 
L["Kael'thas Sunstrider"] = "Kael'thas Sunstrider"
--Translation missing 
L["Kaldorei Light Globe"] = "Kaldorei Light Globe"
--Translation missing 
L["Kal'tik the Blight"] = "Kal'tik the Blight"
--Translation missing 
L["Kang's Bindstone"] = "Kang's Bindstone"
L["Khorium Vein"] = "Veio de Kório"
L["Kill Statistic IDs"] = "IDs de Estatísticas de Mortes"
--Translation missing 
L["Knockoff Blingtron"] = "Knockoff Blingtron"
--Translation missing 
L["Kor'kron Juggernaut"] = "Kor'kron Juggernaut"
--Translation missing 
L["Kovok"] = "Kovok"
L["Krasarang Paddlefish School"] = "Cardume de Peixes-espátula de Krasarang"
L["Kyparite Deposit"] = "Depósito de Kyparita"
--Translation missing 
L["Land Shark"] = "Land Shark"
L["Large Obsidian Chunk"] = "Grande Estilhaço de Obisidiana"
--Translation missing 
L["Large Pool of Brew Frenzied Emperor Salmon"] = "Large Pool of Brew Frenzied Emperor Salmon"
--Translation missing 
L["Large Pool of Crowded Redbelly Mandarin"] = "Large Pool of Crowded Redbelly Mandarin"
--Translation missing 
L["Large Pool of Glimmering Jewel Danio Pool"] = "Large Pool of Glimmering Jewel Danio Pool"
--Translation missing 
L["Large Pool of Glowing Jade Lungfish"] = "Large Pool of Glowing Jade Lungfish"
--Translation missing 
L["Large Pool of Sha-Touched Spinefish"] = "Large Pool of Sha-Touched Spinefish"
--Translation missing 
L["Large Pool of Tiger Gourami Slush"] = "Large Pool of Tiger Gourami Slush"
--Translation missing 
L["Large Swarm of Migrated Reef Octopus"] = "Large Swarm of Migrated Reef Octopus"
--Translation missing 
L["Large Swarm of Panicked Paddlefish"] = "Large Swarm of Panicked Paddlefish"
--Translation missing 
L["Large Tangled Mantis Shrimp Cluster"] = "Large Tangled Mantis Shrimp Cluster"
L["Last Month"] = "Mês Passado"
L["Last Week"] = "Semana Passada"
L["Left"] = "Esquerda"
--Translation missing 
L["Legion"] = "Legion"
L["Lesser Bloodstone Deposit"] = "Depósito de Menor Plasma"
L["Lesser Firefin Snapper School"] = true
L["Lesser Floating Debris"] = true
L["Lesser Oily Blackmouth School"] = true
L["Lesser Sagefish School"] = true
--Translation missing 
L["Leviathan Egg"] = "Leviathan Egg"
--Translation missing 
L["Ley Spider Eggs"] = "Ley Spider Eggs"
--Translation missing 
L["Leystone Deposit"] = "Leystone Deposit"
--Translation missing 
L["Leystone Seam"] = "Leystone Seam"
--Translation missing 
L["Leywoven Flying Carpet"] = "Leywoven Flying Carpet"
--Translation missing 
L["Life-Binder's Handmaiden"] = "Life-Binder's Handmaiden"
L["Likelihood"] = "Probabilidade"
--Translation missing 
L["Lil' Bling"] = "Lil' Bling"
--Translation missing 
L["Living Infernal Core"] = "Living Infernal Core"
L["Living Sandling"] = "Arenídeo Vivo"
L["Loaded (running in debug mode)"] = "Carregado (executando em modo de depuração)"
--Translation missing 
L["Loaded Gnomish Dice"] = "Loaded Gnomish Dice"
L["Loading"] = "Carregando"
L["Locked"] = "Trancado"
--Translation missing 
L["Looking For Raid (10-30 players)"] = "Looking For Raid (10-30 players)"
L["Luckiness"] = "Sorte"
L["Lucky"] = "Sortudo"
L["lucky"] = "sortudo"
L["Lucky if you obtain in %d or less"] = "Sortudo se você obter em %d ou menos"
L["Lump of Coal"] = "Pedaço de Carvão"
--Translation missing 
L["Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."] = "Lunkers can be fished anywhere in Draenor (except in your garrison) after you've obtained a level 3 Fishing Shack and acquired Nat Pagle as a follower."
--Translation missing 
L["Mage"] = "Mage"
--Translation missing 
L["Magnataur Hunting Horn"] = "Magnataur Hunting Horn"
--Translation missing 
L["Major Nanners"] = "Major Nanners"
L["Mantid"] = "Mantídeo"
L["Mark of Flame"] = "Marca da Chama"
L["Method of obtaining"] = "Método de obtenção"
--Translation missing 
L["Midnight's Eternal Reins"] = "Midnight's Eternal Reins"
L["Mimiron's Head"] = "Cabeça de Mimiron"
L["Minimal"] = "Mínimo"
--Translation missing 
L["Minion of Grumpus"] = "Minion of Grumpus"
--Translation missing 
L["MiniZep Controller"] = "MiniZep Controller"
--Translation missing 
L["Mirecroak"] = "Mirecroak"
--Translation missing 
L["Mists of Pandaria"] = "Mists of Pandaria"
L["Mithril Deposit"] = "Depósito de Mithril"
L["Mogu"] = true
L["Mojo"] = true
--Translation missing 
L["Monk"] = "Monk"
--Translation missing 
L["Moon Moon"] = "Moon Moon"
--Translation missing 
L["Moonfang"] = "Moonfang"
--Translation missing 
L["Moonfang Shroud"] = "Moonfang Shroud"
--Translation missing 
L["Moonfang's Paw"] = "Moonfang's Paw"
L["Moonglow Cuttlefish School"] = "Cardume de Lulas Brilho-da-lua"
--Translation missing 
L["Mossgill Perch School"] = "Mossgill Perch School"
L["Mount"] = "Montaria"
L["Mountain Panda"] = "Panda da Montanha"
L["Mountain Trout School"] = "Cardume de Truta da Montanha"
L["Mounts"] = "Montarias"
L["Mr. Grubbs"] = "Sr. Fofinho"
L["Mr. Pinchy"] = "Sr. Belisco"
--Translation missing 
L["Mr. Smite's Brass Compass"] = "Mr. Smite's Brass Compass"
--Translation missing 
L["Muckbreaths's Bucket"] = "Muckbreaths's Bucket"
L["Muddy Churning Water"] = true
L["Mudfish School"] = "Cardume de Muçuns"
L["Musselback Sculpin School"] = "Cardume de Mangangás Berbidorsos"
--Translation missing 
L["Muyani"] = "Muyani"
L["Mysterious Camel Figurine"] = "Estatueta de Camelo Misteriosa"
--Translation missing 
L["Mythic 5-player instance"] = "Mythic 5-player instance"
--Translation missing 
L["Mythic difficulty"] = "Mythic difficulty"
--Translation missing 
L["Mythic Raid (20 player)"] = "Mythic Raid (20 player)"
L["Nerubian"] = "Nerubiano"
--Translation missing 
L["Nerubian Relic"] = "Nerubian Relic"
--Translation missing 
L["Nessos the Oracle"] = "Nessos the Oracle"
L["Nethercite Deposit"] = "Depósito de Etercita"
--Translation missing 
L["Netherfist"] = "Netherfist"
L["Netherspace Portal-Stone"] = "Pedra-Portal do Eterespaço"
L["Nettlefish School"] = "Cardume de Peixes-urtiga"
L["New item"] = "Novo item"
L["Night Elf"] = "Elfo Noturno"
--Translation missing 
L["Nightmare Bell"] = "Nightmare Bell"
--Translation missing 
L["Nightmare Whelpling"] = "Nightmare Whelpling"
--Translation missing 
L["Nightshade Sproutling"] = "Nightshade Sproutling"
--Translation missing 
L[ [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=] ] = [=[No items to display! Either you've obtained every item, or you have
one or more options turned on which hide things from the tooltip.]=]
--Translation missing 
L["None"] = "None"
--Translation missing 
L["None (not in an instance)"] = "None (not in an instance)"
L["Normal"] = true
--Translation missing 
L["Normal Raid (10-30 players)"] = "Normal Raid (10-30 players)"
--Translation missing 
L["not imported"] = "not imported"
L["NPCs"] = "PNJs"
L["Obsidium Deposit"] = "Depósito de Obsídio"
--Translation missing 
L["Obtained Achievement ID"] = "Obtained Achievement ID"
L["Obtained After %d Attempts"] = "Obtido(a) após %d Tentativas"
--Translation missing 
L["Obtained as a rare project for the Fossil branch of archaeology"] = "Obtained as a rare project for the Fossil branch of archaeology"
--Translation missing 
L["Obtained as a very rare project for the Tol'vir branch of archaeology"] = "Obtained as a very rare project for the Tol'vir branch of archaeology"
L["Obtained as an archaeology project"] = "Obtido como um projeto de arqueologia"
L["Obtained by collecting a number of items"] = "Obtido coletando uma quantidade de itens"
L["Obtained by fishing"] = "Obtido átraves de pesca"
--Translation missing 
L["Obtained by fishing in any water in Ironforge"] = "Obtained by fishing in any water in Ironforge"
--Translation missing 
L["Obtained by fishing in any water in Orgrimmar"] = "Obtained by fishing in any water in Orgrimmar"
--Translation missing 
L["Obtained by fishing in pools located in Terrokar Forest"] = "Obtained by fishing in pools located in Terrokar Forest"
L["Obtained by mining"] = "Obtido ao minerar"
L["Obtained by mining Elementium Vein"] = "Obtido ao minerar Veio de Elemêntio"
--Translation missing 
L["Obtained by opening Crane Nests on the Timeless Isle"] = "Obtained by opening Crane Nests on the Timeless Isle"
--Translation missing 
L["Obtained by opening Snow Mound in Frostfire Ridge"] = "Obtained by opening Snow Mound in Frostfire Ridge"
--Translation missing 
L["Obtained by opening Timeless Chests on the Timeless Isle"] = "Obtained by opening Timeless Chests on the Timeless Isle"
L["Obtained by using an item or opening a container"] = "Obtido ao usar um item ou abrir um contêiner"
L["Obtained On Your First Attempt"] = "Obtido(a) Na Sua Primeira Tentativa"
--Translation missing 
L["Obtained Quest ID"] = "Obtained Quest ID"
--Translation missing 
L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"] = "Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"
--Translation missing 
L["Odd Polished Stone"] = "Odd Polished Stone"
--Translation missing 
L["Ogre"] = "Ogre"
L["Oil Spill"] = "REMOVIDO NO CATACLISMO"
L["Oily Abyssal Gulper School"] = "Cardume de Boca-grandes Abissais Oleosos"
L["Oily Blackmouth School"] = "Cardume de Bocaneras Oleosos"
L["Oily Sea Scorpion School"] = "Cardume de Escorpiões do Mar Oleosos"
--Translation missing 
L["Old Crafty"] = "Old Crafty"
--Translation missing 
L["Old Ironjaw"] = "Old Ironjaw"
--Translation missing 
L["Old Man Barlo"] = "Old Man Barlo"
--Translation missing 
L["Ominous Flame"] = "Ominous Flame"
--Translation missing 
L["Ominous Pile of Snow"] = "Ominous Pile of Snow"
L["One of the Map IDs you entered (%s) is incorrect. Please enter numbers larger than zero."] = "Um dos IDs de mapa que você informou (%s) está incorreto. Por favor informe números maiores que zero."
L["One of the zones or sub-zones you entered (%s) cannot be found. Check that it is spelled correctly, and is either US English or your client's local language."] = "Uma das zonas ou sub-zonas que você inseriu (%s) não pôde ser encontrada. Verifique se foi escrita corretamente, e se está ou em inglês americano ou na língua local do seu cliente."
--Translation missing 
L["Only announce when found"] = "Only announce when found"
--Translation missing 
L["Only Raid Finder difficulty"] = "Only Raid Finder difficulty"
L["Ooze Covered Gold Vein"] = "Veio de Ouro Coberto de Gosma"
L["Ooze Covered Mithril Deposit"] = "Depósito de Mithril Coberto de Gosma"
L["Ooze Covered Rich Thorium Vein"] = "Veio de Tório Abundante Coberto de Gosma"
L["Ooze Covered Silver Vein"] = "Veio de Prata Coberto de Gosma"
L["Ooze Covered Thorium Vein"] = "Veio de Tório Coberto de Gosma"
L["Ooze Covered Truesilver Deposit"] = "Depósito de Veraprata Coberto de Gosma"
--Translation missing 
L["Options"] = "Options"
--Translation missing 
L["Orb of the Sin'dorei"] = "Orb of the Sin'dorei"
L["Orc"] = true
--Translation missing 
L["Orphaned Felbat"] = "Orphaned Felbat"
L["Other"] = "Outro"
L["Other Requirements"] = "Outros Requisitos"
--Translation missing 
L["Overcomplicated Controller"] = "Overcomplicated Controller"
--Translation missing 
L["Paladin"] = "Paladin"
L["Pandaren"] = true
--Translation missing 
L["Pandaren Firework Launcher"] = "Pandaren Firework Launcher"
--Translation missing 
L["Panflute of Pandaria"] = "Panflute of Pandaria"
L["Parrot Cage (Green Wing Macaw)"] = "Poleiro de Papagaio (Arara-da-asa-verde)"
L["Parrot Cage (Hyacinth Macaw)"] = "Poleiro de Papagaio (Arara-jacinto)"
--Translation missing 
L["Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."] = "Paste a Rarity Item Pack String here using Ctrl-V, then click the Import button."
L["Patch of Elemental Water"] = true
--Translation missing 
L["Periwinkle Calf"] = "Periwinkle Calf"
L["Phoenix Hatchling"] = "Filhote de Fênix"
--Translation missing 
L["Pineapple Lounge Cushion"] = "Pineapple Lounge Cushion"
--Translation missing 
L["Play a sound when groups are found"] = "Play a sound when groups are found"
--Translation missing 
L["Players have a personal loot chance to obtain this item."] = "Players have a personal loot chance to obtain this item."
L["Please enter a comma-separated list of item IDs."] = "Por favor, insira uma lista separada por vírgulas de IDs de itens."
L["Please enter a comma-separated list of NPC IDs."] = "Por favor, insira uma lista separada por vírgulas de IDs de PNJs."
--Translation missing 
L["Please enter a comma-separated list of Quest IDs."] = "Please enter a comma-separated list of Quest IDs."
L["Please enter a comma-separated list of Statistic IDs."] = "Por favor, insira uma lista separada por vírgulas de IDs de Estatísticas."
L["Please enter a comma-separated list of zones."] = "Por favor, insira uma lista separada por vírgulas de zonas."
L["Pool of Fire"] = "Lago de Fogo"
L["Porcupette"] = "Porquinho-espinho"
--Translation missing 
L["Priest"] = "Priest"
L["Primal Egg"] = "Ovo Primevo"
--Translation missing 
L["Primary tooltip hide delay"] = "Primary tooltip hide delay"
--Translation missing 
L["Primary tooltip scale"] = "Primary tooltip scale"
L["Profile modified, rebooting"] = "Perfil modificado, reiniciando"
--Translation missing 
L["Profiling OFF"] = "Profiling OFF"
--Translation missing 
L["Profiling ON"] = "Profiling ON"
L["Progress"] = "Progresso"
L["Progress Bar"] = "Barra de Progresso"
--Translation missing 
L["Puddle Terror"] = "Puddle Terror"
--Translation missing 
L["Pugg"] = "Pugg"
--Translation missing 
L["Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."] = "Purchased from Z'tenga the Walker <Saberstalker Quartermaster> in Fang'rila in Tanaan Jungle. Blackfang Claws drop from all monsters in Fang'rila."
L["Pure Saronite Deposit"] = "Depósito de Saronita Pura"
L["Pure Water"] = "Água Pura"
--Translation missing 
L["Put \"Rarity:\" on a separate line"] = "Put \"Rarity:\" on a separate line"
--Translation missing 
L["Putricide's Alchemy Supplies"] = "Putricide's Alchemy Supplies"
L["Pygmy Direhorn"] = "Escornante Pigmeu"
L["Pyrite Deposit"] = "Depósito de Pirita"
--Translation missing 
L["Quest ID"] = "Quest ID"
--Translation missing 
L["Quivering Blob"] = "Quivering Blob"
--Translation missing 
L["Raid Finder instance (legacy content; fixed at 25 players)"] = "Raid Finder instance (legacy content; fixed at 25 players)"
--Translation missing 
L["Raid Finder or Flexible difficulty"] = "Raid Finder or Flexible difficulty"
--Translation missing 
L["Rarity has %d |4coordinate:coordinates; for this item."] = "Rarity has %d |4coordinate:coordinates; for this item."
--Translation missing 
L["Rarity is loading..."] = "Rarity is loading..."
--Translation missing 
L["Rarity Item Pack String"] = "Rarity Item Pack String"
--Translation missing 
L["Rarity Tooltip Options"] = "Rarity Tooltip Options"
L["Rarity: "] = "Raridade:"
L["Razzashi Hatchling"] = "Filhote de Razzashi"
--Translation missing 
L["Red Goren Egg"] = "Red Goren Egg"
--Translation missing 
L["Red Helper Box"] = "Red Helper Box"
L["Red Qiraji Resonating Crystal"] = "Cristal Ressonante Qiraji Vermelho"
L["Redbelly Mandarin School"] = "Cardume de Mandarins Vermelhos"
--Translation missing 
L["Red-Hot Coal"] = "Red-Hot Coal"
L["Reef Octopus Swarm"] = "Agrupamento de Polvos dos Recifes"
L["Reins of the Amber Primordial Direhorn"] = "Rédeas do Escornante Âmbar Primordial"
L["Reins of the Astral Cloud Serpent"] = "Rédeas da Serpente das Nuvens Astral"
L["Reins of the Azure Drake"] = "Rédeas do Draco Lazúli"
L["Reins of the Black Primal Raptor"] = "Rédeas do Raptor Primevo Preto"
L["Reins of the Blazing Drake"] = "Rédeas do Draco Fulgurante"
L["Reins of the Blue Drake"] = "Rédeas do Draco Azul"
L["Reins of the Blue Proto-Drake"] = "Rédeas do Protodraco Azul"
--Translation missing 
L["Reins of the Bone-White Primal Raptor"] = "Reins of the Bone-White Primal Raptor"
L["Reins of the Cobalt Primordial Direhorn"] = "Rédeas do Escornante Primordial de Cobalto"
--Translation missing 
L["Reins of the Crimson Water Strider"] = "Reins of the Crimson Water Strider"
L["Reins of the Drake of the North Wind"] = "Rédeas do Draco do Vento Norte"
L["Reins of the Drake of the South Wind"] = "Rédeas do Draco do Vento Sul"
L["Reins of the Grand Black War Mammoth"] = "Rédeas do Grande Mamute de Guerra Preto"
L["Reins of the Green Primal Raptor"] = "Rédeas do Raptor Primevo Verde"
L["Reins of the Green Proto-Drake"] = "Rédeas do Protodraco Verde"
L["Reins of the Grey Riding Camel"] = "Rédeas do Camelo Cinza de Montaria"
L["Reins of the Heavenly Onyx Cloud Serpent"] = "Rédeas da Serpente das Nuvens de Ônix Celestial"
--Translation missing 
L["Reins of the Infinite Timereaver"] = "Reins of the Infinite Timereaver"
L["Reins of the Jade Primordial Direhorn"] = "Rédeas do Escornante Primordial de Jade"
L["Reins of the Onyxian Drake"] = "Rédeas do Draco Onyxiano"
L["Reins of the Raven Lord"] = "Rédeas do Senhor dos Corvos"
L["Reins of the Slate Primordial Direhorn"] = "Rédeas do Escornante Primordial de Ardósia"
L["Reins of the Thundering Cobalt Cloud Serpent"] = "Rédeas da Serpente das Nuvens Trovejante Cobalto"
--Translation missing 
L["Reins of the Thundering Onyx Cloud Serpent"] = "Reins of the Thundering Onyx Cloud Serpent"
L["Reins of the Vitreous Stone Drake"] = "Rédeas do Draco de Pedra Vítreo"
L["Reins of the White Polar Bear"] = "Rédeas do Urso Polar Branco"
--Translation missing 
L["Remains of a Blood Beast"] = "Remains of a Blood Beast"
L["Repeatable"] = "Repetível"
L["Required for %s"] = "Requerido para %s"
L["Requires a pool"] = "Requer um cardume"
--Translation missing 
L["Requires Pickpocketing"] = "Requires Pickpocketing"
L["Rich Adamantite Deposit"] = "Depósito de Adamantita Abundante"
L["Rich Blackrock Deposit"] = "Depósito Rico de Rocha Negra"
L["Rich Cobalt Deposit"] = "Depósito de Cobalto Abundante "
L["Rich Elementium Vein"] = "Veio de Elemêntio Abundante"
--Translation missing 
L["Rich Felslate Deposit"] = "Rich Felslate Deposit"
L["Rich Ghost Iron Deposit"] = "Depósito Repleto de Ferro Fantasma"
L["Rich Kyparite Deposit"] = "Depósito Rico em Kyparita"
--Translation missing 
L["Rich Leystone Deposit"] = "Rich Leystone Deposit"
L["Rich Obsidium Deposit"] = "Depósito de Obsídio Abundante"
L["Rich Pyrite Deposit"] = "Depósito de Pirita Abundante"
L["Rich Saronite Deposit"] = "Depósito de Saronita Abundante"
L["Rich Thorium Vein"] = "Veio de Tório Abundante"
L["Rich Trillium Vein"] = "Veio Repleto de Tríllio"
L["Rich True Iron Deposit"] = "Depósito Rico de Ferro Verdadeiro"
--Translation missing 
L["Riding Turtle"] = "Riding Turtle"
L["Right"] = "Direita"
L["Right-Aligned"] = "Alinhado à direita"
--Translation missing 
L["Rime of the Time-Lost Mariner"] = "Rime of the Time-Lost Mariner"
--Translation missing 
L["Rogue"] = "Rogue"
--Translation missing 
L["Rotten Helper Box"] = "Rotten Helper Box"
--Translation missing 
L["Ruby Droplet"] = "Ruby Droplet"
--Translation missing 
L["Rukdug"] = "Rukdug"
--Translation missing 
L["Runescale Koi School"] = "Runescale Koi School"
--Translation missing 
L["Sack of Spectral Spiders"] = "Sack of Spectral Spiders"
--Translation missing 
L["Safari Lounge Cushion"] = "Safari Lounge Cushion"
L["Sagefish School"] = "Cardume de Sabichões"
--Translation missing 
L["Sahn Tidehunter"] = "Sahn Tidehunter"
--Translation missing 
L["Salyin Battle Banner"] = "Salyin Battle Banner"
--Translation missing 
L["Salyin Warscout"] = "Salyin Warscout"
L["Saronite Deposit"] = "Depósito de Saronita"
--Translation missing 
L["Sassy Imp"] = "Sassy Imp"
L["Satyr Charm"] = "Amuleto do Sátiro"
--Translation missing 
L["Savage Cub"] = "Savage Cub"
L["Savage Piranha Pool"] = "Cardume de Piranha Selvagem"
L["Scale"] = "Tamanho"
--Translation missing 
L["Scenario instance"] = "Scenario instance"
L["Scepter of Azj'Aqir"] = "Cetro de Azj'Aqir"
L["School of Darter"] = "Cardume de Platis"
L["School of Deviate Fish"] = "Cardume de Peixes Anormais"
L["School of Tastyfish"] = "Cardume de Papa-Fina-Pintado"
L["Schooner Wreckage"] = "Schooner Antiga"
L["Schooner Wreckage Pool"] = "Destroços da Escuna"
L["Scorched Stone"] = "Pedra Calcinada"
--Translation missing 
L["Scraps"] = "Scraps"
--Translation missing 
L["Sea Calf"] = "Sea Calf"
L["Sea Pony"] = "Pônei-marinho"
L["Sea Scorpion School"] = "Cardume de Escorpiões do Mar"
L["Sea Turtle"] = "Tartaruga Marinha"
--Translation missing 
L["Seaborne Spore"] = "Seaborne Spore"
--Translation missing 
L["Secondary tooltip display"] = "Secondary tooltip display"
--Translation missing 
L["Servant of Demidos"] = "Servant of Demidos"
--Translation missing 
L["Servant's Bell"] = "Servant's Bell"
L["Session"] = "Sessão"
--Translation missing 
L["Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."] = "Set this to the achievement ID which indicates this item has been obtained. This is useful for items which do not yield mounts or pets, but which do grant an achievement when obtained, such as Old Crafty or Old Ironjaw. Leave this blank for mounts and pets. Use WowHead to find achievement IDs."
--Translation missing 
L["Shadowhide Pearltusk"] = "Shadowhide Pearltusk"
--Translation missing 
L["Shaman"] = "Shaman"
--Translation missing 
L["Shard of Supremus"] = "Shard of Supremus"
--Translation missing 
L["Sha-Touched Spinefish"] = "Sha-Touched Spinefish"
L["Shell of Tide-Calling"] = "Concha de Chamar Marés"
L["Shift-Click to link your progress to chat"] = "Shift-Clique para criar um link do seu progresso na conversa"
L["Shift-Click to open options"] = "Shift-Clique para abrir opções"
L["Shipwreck Debris"] = "Restos de Naufrágio"
L["Show anchor"] = "Mostrar âncora"
L["Show attempts in tooltips"] = "Mostrar tentativas nas dicas"
--Translation missing 
L["Show auto refresh checkbox"] = "Show auto refresh checkbox"
L["Show category icons"] = "Mostrar ícones de categorias"
L["Show Icon"] = "Mostrar ícone"
--Translation missing 
L["Show Luckiness column"] = "Show Luckiness column"
L["Show minimap icon"] = "Mostrar ícone no minimapa"
L["Show Text"] = "Mostrar texto"
--Translation missing 
L["Show Time column"] = "Show Time column"
--Translation missing 
L["Show Zone column"] = "Show Zone column"
L["Silver Vein"] = "Veio de Prata"
--Translation missing 
L["Silver-Plated Turkey Shooter"] = "Silver-Plated Turkey Shooter"
L["Since last drop"] = "Desde o último saque"
--Translation missing 
L["Sira's Extra Cloak"] = "Sira's Extra Cloak"
--Translation missing 
L["Skrillix"] = "Skrillix"
--Translation missing 
L["Skull of a Frozen Whelp"] = "Skull of a Frozen Whelp"
--Translation missing 
L["Skunky Alemental"] = "Skunky Alemental"
L["Sky-Bo"] = "Bô Celeste"
L["Skyshard"] = "Estilhaço do Céu"
--Translation missing 
L["Slithershock Elver"] = "Slithershock Elver"
L["Small Obsidian Chunk"] = "Pequeno Estilhaço de Obisidiana"
L["Small Thorium Vein"] = "Veio de Tório Pequeno"
--Translation missing 
L["Smashum Grabb"] = "Smashum Grabb"
--Translation missing 
L["Smelly Gravestone"] = "Smelly Gravestone"
--Translation missing 
L["Smoky Direwolf"] = "Smoky Direwolf"
L["Smoldering Egg of Millagazor"] = "Ovo Fumegante de Millagazor"
L["Snarly's Bucket"] = "Balde do Ruginho"
L["Snow Mound"] = "Monte de Neve"
--Translation missing 
L["Snowman Kit"] = "Snowman Kit"
L["Snowy Panda"] = "Panda Nevado"
L["Solar Spirehawk"] = "Falcão-agulha Solar"
L["Son of Animus"] = "Filho de Animus"
L["Son of Galleon's Saddle"] = "Sela do Filho de Gailleon"
L["Sorting by category, then name"] = "Ordenar por categoria, então nomeie"
L["Sorting by difficulty"] = "Classificando por dificuldade"
L["Sorting by name"] = "Classificando por nome"
L["Sorting by percent complete"] = "Classificando por porcentagem completa"
--Translation missing 
L["Sorting by zone"] = "Sorting by zone"
L["Sparse Firefin Snapper School"] = true
L["Sparse Oily Blackmouth School"] = true
L["Sparse Schooner Wreckage"] = true
L["Spawn of Horridon"] = "Rebento de Horridon"
L["Special case"] = "Caso Especial"
--Translation missing 
L["Spectral Bell"] = "Spectral Bell"
L["Spell ID"] = "ID do feitiço"
L["Spiky Collar"] = "Coleira Pontuda"
--Translation missing 
L["Spineclaw Crab"] = "Spineclaw Crab"
L["Spinefish School"] = "Cardume de Peixes-espinho"
L["Sporefish School"] = "Cardume de Esporosos"
L["Sprite Darter Egg"] = "Ovo de Dardejante"
L["Statistics"] = "Estatísticas"
L["Steam Pump Flotsam"] = "Destroços da Bomba de Vapor"
--Translation missing 
L["Sting Ray Pup"] = "Sting Ray Pup"
L["Stonescale Eel Swarm"] = "Grande Cardume de Enguias Petrescamas"
--Translation missing 
L["Stormforged Rune"] = "Stormforged Rune"
L["Strand Crawler"] = "Beiratisco"
L["Strange Pool"] = "Piscina Estranha"
--Translation missing 
L["Sultry Grimoire"] = "Sultry Grimoire"
L["Sun Sproutling"] = "Broto do Sol"
--Translation missing 
L["Sunblade Rune of Activation"] = "Sunblade Rune of Activation"
L["Sunfire Kaliri"] = "Kaliri do Fogo Solar"
L["Sunfur Panda"] = "Panda Pelossol"
--Translation missing 
L["Swarm of Panicked Paddlefish"] = "Swarm of Panicked Paddlefish"
L["Swift Brewfest Ram"] = "Carneiro da CervaFest Veloz"
L["Swift White Hawkstrider"] = "Falcostruz Branco Veloz"
L["Swift Zulian Panther"] = "Pantera Zulian Veloz"
--Translation missing 
L["Syd the Squid"] = "Syd the Squid"
L["Tainted Core"] = "Núcleo Maculado"
--Translation missing 
L["Tainted Maulclaw"] = "Tainted Maulclaw"
L["Take screenshots"] = "Capturar tela"
--Translation missing 
L["Tangled Mantis Shrimp Cluster"] = "Tangled Mantis Shrimp Cluster"
L["Teeming Firefin Snapper School"] = true
L["Teeming Floating Wreckage"] = true
L["Teeming Oily Blackmouth School"] = true
--Translation missing 
L["Terrorfist"] = "Terrorfist"
L["Texture"] = "Textura"
--Translation missing 
L["The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."] = "The boss name, in English (enUS), which appears in the instance lock inside the Raid Info panel. The name will be translated to your local language automatically using the LibBoss library (if detection fails, check that the translation exists in this library). IMPORTANT: This method of defeat detection only works when the boss exists in one place at a time. Certain bosses, such as Ragnaros and Kael'thas Sunstrider, exist in two instances at once. Those bosses can be used here, but killing them in either of their instances will result in this Defeat Detection triggering."
--Translation missing 
L["The Burning Crusade"] = "The Burning Crusade"
--Translation missing 
L["The following %d item(s) have been selected to export:"] = "The following %d item(s) have been selected to export:"
--Translation missing 
L["The Heartbreaker"] = "The Heartbreaker"
L["The Horseman's Reins"] = "As Rédeas do Cavaleiro"
--Translation missing 
L["The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."] = "The item ID that you need to collect. Rarity uses the number of this item that you have in your bags as your progress. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must not be used by another item."
L["The item ID to track. This is the item as it appears in your inventory or in a loot window. Use WowHead or a similar service to lookup item IDs. This must be a valid number and must be unique."] = "O ID do item para rastrear. Este é o item como ele aparece no seu inventário ou janela de saque. Use o WowHead ou um serviço similar para procurar por IDs de itens. Precisa ser um número válido e único."
L["The name you entered is already being used by another item. Please enter a unique name."] = "O nome que você inseriu já está sendo usado por outro item. Por favor, insira um nome único."
--Translation missing 
L["The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."] = "The NPC ID of the creature that is spawned when you summon this pet. This is used to track account-wide battle pets."
L["The number of players it takes to obtain the item. This will lower your chances of obtaining the item."] = "O número de jogadores que precisa para obter o item. Isto diminuirá suas chances de obtê-lo."
--Translation missing 
L["The Pigskin"] = "The Pigskin"
--Translation missing 
L["The quest starter item for Reins of the Llothien Prowler"] = "The quest starter item for Reins of the Llothien Prowler"
L["The Rarity Options module has been disabled. Log out and enable it from your add-ons menu."] = "O módulo Rarity Options foi desativado. Desconecte e ative-o do menu Add-ons."
--Translation missing 
L["The selected Rarity Item Pack string is invalid."] = "The selected Rarity Item Pack string is invalid."
L["The spell ID of the item once you've learned it. This applies only to mounts and companions, and is the spell as it appears in your spell book after learning the item. Use WowHead or a similar service to lookup spell IDs. This must be a valid number and must be unique."] = "O ID do feitiço do item quando você aprendê-lo. Isto se aplica somente a montarias e mascotes, e é o feitiço como ele aparece no seu grimório após aprender o item. Use o Wowhead ou um serviço similar para procurar por IDs de feitiços. É preciso que seja um número válido e único."
--Translation missing 
L["The Warbringer will be riding the mount color he has a chance to drop."] = "The Warbringer will be riding the mount color he has a chance to drop."
--Translation missing 
L["There are more holiday items available, but Rarity only reminds you about the first two."] = "There are more holiday items available, but Rarity only reminds you about the first two."
--Translation missing 
L["These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."] = "These toggles control which items appear in the main Rarity tooltip. Items are categorized by the expansion they were introduced in (although holiday items have a separate category). Turning off these checkboxes does not turn off tracking for any items within the category; it simply hides the item from the tooltip in order to help reduce the number of items in it."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Christoph VonFeasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."] = "This bag is rewarded for completing the pet battle daily offered by Jeremy Feasel at the Darkmoon Faire."
--Translation missing 
L["This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."] = "This bag is rewarded for earning a Gold or Platinum victory in a garrison invasion."
--Translation missing 
L["This causes Rarity to put a blank line above its tooltip additions."] = "This causes Rarity to put a blank line above its tooltip additions."
--Translation missing 
L["This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."] = "This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."
L["This item is only available to Alliance players."] = "Este item só está disponível para jogadores da Aliança"
L["This item is only available to Horde players."] = "Este item só está disponível para jogadores da Horda."
--Translation missing 
L["This mount is only obtainable by Alliance players"] = "This mount is only obtainable by Alliance players"
--Translation missing 
L["This mount is only obtainable by Horde players"] = "This mount is only obtainable by Horde players"
--Translation missing 
L["This tab lets you import and export items into and out of your Custom tab."] = "This tab lets you import and export items into and out of your Custom tab."
--Translation missing 
L["This was a guaranteed drop for players who defeated the encounter when it was current"] = "This was a guaranteed drop for players who defeated the encounter when it was current"
L["Tiger Gourami School"] = "Cardume de Gouramis-tigre"
--Translation missing 
L["Tiger Gourami Slush"] = "Tiger Gourami Slush"
L["Time"] = "Hora"
L["Time spent farming"] = "Tempo gasto \"farmando\""
--Translation missing 
L["Timeless Chest"] = "Timeless Chest"
--Translation missing 
L["Time-Locked Box"] = "Time-Locked Box"
--Translation missing 
L["Time-Lost Figurine"] = "Time-Lost Figurine"
--Translation missing 
L["Timewalker 5-player instance"] = "Timewalker 5-player instance"
L["Tin Vein"] = "Veio de Estanho"
L["Tiny Crimson Whelpling"] = "Dragonetinho Carmesim"
L["Tiny Emerald Whelpling"] = "Dragonetinho Esmeralda"
L["Tiny Fel Engine Key"] = "Chave do Aniquilador de Bolso"
L["Titanium Vein"] = "Veio de Titânico"
L[ [=[To create a new item, enter a unique name for the item, and click Okay. The name will be used if the server does not return the item link or if the item is invalid.

You can't change this name after you create the item, so choose it well.]=] ] = [=[Para criar um novo item, insira um nome único para o item, e clique em OK. O nome será usado se o servidor não retornar o link do item ou se o item for inválido.

Você não pode mudar este nome após ter criado o item, então escolha bem.]=]
--Translation missing 
L["To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."] = "To export a group of items, go through each item in your Custom tab and check or uncheck the Export checkbox. The checkbox will be disabled if you haven't yet filled out enough information for Rarity to detect the item. Once you've done that, return here and click the Export button. A Rarity Item Pack string will be generated that you can copy to the clipboard using Ctrl-C."
--Translation missing 
L["To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."] = "To import a group of items, paste a Rarity Item Pack string into the Import text box below and click the Import button. Rarity will tell you which items were imported (or which ones failed to import) in your chat window. You can find many Rarity Item Packs on the Curse web site, or elsewhere on the web."
L["Today"] = "Hoje"
L["Toggles"] = "Alterna"
L["Tol'vir"] = true
--Translation missing 
L["Tooltip can't be shown in combat"] = "Tooltip can't be shown in combat"
--Translation missing 
L["Toothy's Bucket"] = "Toothy's Bucket"
--Translation missing 
L["Torn Invitation"] = "Torn Invitation"
L["Total"] = true
L["Total found"] = "Total encontrado"
L["Toxic Wasteling"] = "Monturinho Tóxico"
--Translation missing 
L["Toy or Item"] = "Toy or Item"
--Translation missing 
L["Toys & Items"] = "Toys & Items"
L["Track this"] = "Rastrear isto"
L["Trillium Vein"] = "Veio de Tríllio"
L["Troll"] = true
L["True Iron Deposit"] = "Depósito de Ferro Verdadeiro"
L["Truesilver Deposit"] = "Depósito de Veraprata"
--Translation missing 
L["Tundra Icehoof"] = "Tundra Icehoof"
L["Turn this on if the item requires a group to obtain, but every player gets an equal chance to obtain the item. This currently only applies to some of the holiday mounts. When you turn this on, Rarity will stop lowering your chance to obtain based on the group size."] = "Ative isto se o item requer um grupo para ser obtido, mas cada jogador tem uma chance igual de obtê-lo. Isto apenas se aplica a algumas montarias de eventos mundiais. Quando você ativa esta opção, o Rarity vai parar de diminuir sua chance de obter um item baseado no tamanho do grupo."
L["Turns on a minimap icon for Rarity. Use this option if you don't have an LDB display add-on."] = "Ativa o ícone no minimapa para o Rarity. Use esta opção se você não tem um add-on LDB."
L["Type of item"] = "Tipo do item"
--Translation missing 
L["Unable to retrieve item information from the server"] = "Unable to retrieve item information from the server"
L["Unavailable"] = "Indisponível"
L["Undefeated"] = "Invicto"
L["Unknown"] = "Desconhecido"
L["Unlucky"] = "Sem sorte"
L["unlucky"] = "azarado"
L["Unscathed Egg"] = "Ovo Intacto"
--Translation missing 
L["Unstable Powder Box"] = "Unstable Powder Box"
--Translation missing 
L["Unusual Compass"] = "Unusual Compass"
--Translation missing 
L["Use your bonus roll for a chance at this item"] = "Use your bonus roll for a chance at this item"
L["Usually requires a group of around %d players"] = "Geralmente requer um grupo de cerca de %d jogadores"
--Translation missing 
L["Valarjar Stormwing"] = "Valarjar Stormwing"
--Translation missing 
L["Vengeance"] = "Vengeance"
L["Verbose"] = "Prolixo"
--Translation missing 
L["Vibrating Arcane Crystal"] = "Vibrating Arcane Crystal"
--Translation missing 
L["Vile Blood of Draenor"] = "Vile Blood of Draenor"
L["Viscidus Globule"] = "Glóbulo de Viscidus"
--Translation missing 
L["Void Collar"] = "Void Collar"
L["Vrykul"] = "Vraikal"
--Translation missing 
L["Warlock"] = "Warlock"
--Translation missing 
L["Warlords of Draenor"] = "Warlords of Draenor"
--Translation missing 
L["Warm Arcane Crystal"] = "Warm Arcane Crystal"
--Translation missing 
L["Warning Sign"] = "Warning Sign"
--Translation missing 
L["Warrior"] = "Warrior"
--Translation missing 
L["Warsong Direfang"] = "Warsong Direfang"
L["Waterlogged Wreckage"] = "Destroços Encharcados"
L["Waterlogged Wreckage Pool"] = "Destroços Encharcados"
L["Weebomination"] = "Abominaçãozinha"
L["Welcome to Rarity r%d. Your settings have been reset."] = "Bem-vindo(a) ao Rarity r%d. Suas configurações foram redefinidas."
--Translation missing 
L["When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."] = "When any good-luck coin is used within about 90 seconds of an attempt on this item, another attempt will be counted for this item. Only enable this for items which can legitimately be obtained from coin rolls."
--Translation missing 
L["When enabled, Rarity tooltips will include how many attempts you've made."] = "When enabled, Rarity tooltips will include how many attempts you've made."
--Translation missing 
L["When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."] = "When enabled, Rarity will add an Auto checkbox to the Group Finder's search window. You can check this checkbox to enable auto-refresh of your searches every 5 seconds."
--Translation missing 
L["When enabled, Rarity will add obtainable items to game tooltips whenever possible."] = "When enabled, Rarity will add obtainable items to game tooltips whenever possible."
--Translation missing 
L["When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."] = "When enabled, Rarity will play a sound when an auto-refresh search results in one or more groups found in the Group Finder. This sound cannot play more than once per minute."
--Translation missing 
L["When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."] = "When enabled, Rarity will print debug profiling messages to the chat window when certain things happen. This is used to determine which parts of the code are slow."
--Translation missing 
L["When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."] = "When enabled, the item can only be obtained by pickpocketing. The item will be marked Unavailable for non-rogues."
--Translation missing 
L["When on, items marked as Defeated will be hidden from the tooltip."] = "When on, items marked as Defeated will be hidden from the tooltip."
--Translation missing 
L["When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."] = "When on, items marked as Unavailable will be hidden from the tooltip. This way, items requiring a certain holiday will automatically be hidden when the holiday is not active."
--Translation missing 
L["When on, items that have no attempts yet will be hidden from the tooltip."] = "When on, items that have no attempts yet will be hidden from the tooltip."
--Translation missing 
L["When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."] = "When on, only items that can be obtained in your current zone will be shown in the tooltip. When this is on and you're in an instance, the instance difficulty is also checked to make sure it matches what the item supports."
--Translation missing 
L[ [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=] ] = [=[When on, Rarity will remind you to go farm holiday items you're missing if the holiday is active and the item is set as Undefeated. (This only works for items that originate from holiday dungeons or daily quests.) The reminder occurs each time you log in or reload your UI, and stops for the day once you defeat the holiday dungeon or complete the	quest.]=]
--Translation missing 
L["When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."] = "When on, Rarity will show an icon next to each item in the tooltip indicating which expansion the item belongs to."
--Translation missing 
L["When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."] = "When on, Rarity will take a screenshot when the achievement alert pops up indicating that you obtained an item."
--Translation missing 
L["When on, the Luckiness column will be shown in the main tooltip."] = "When on, the Luckiness column will be shown in the main tooltip."
--Translation missing 
L["When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."] = "When on, the text \"Rarity:\" will be put on its own line in world and item tooltips."
--Translation missing 
L["When on, the Time column will be shown in the main tooltip."] = "When on, the Time column will be shown in the main tooltip."
--Translation missing 
L["When on, the Zone column will be shown in the main tooltip."] = "When on, the Zone column will be shown in the main tooltip."
--Translation missing 
L["When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."] = "When on, this option hides any item with a drop chance of 1 in 49 or better. The item is merely hidden from the tooltip in order to keep it clean. Items hidden in this fashion are still tracked like normal."
--Translation missing 
L["When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."] = "When you move your mouse out of the Rarity tooltip, it will take this long before it automatically hides itself."
L["Whistle of Chromatic Bone"] = "Apito de Osso Cromático"
L["White Trillium Deposit"] = "Depósito de Trílio Branco"
L["Width"] = "Largura"
--Translation missing 
L["Wild Dreamrunner"] = "Wild Dreamrunner"
--Translation missing 
L["Wild Goretusk"] = "Wild Goretusk"
--Translation missing 
L["will be imported"] = "will be imported"
--Translation missing 
L["Will only drop for druids."] = "Will only drop for druids."
--Translation missing 
L["Wisp in a Bottle"] = "Wisp in a Bottle"
--Translation missing 
L["World Tooltip Options"] = "World Tooltip Options"
L["Worn Troll Dice"] = "Dado Troll Gasto"
--Translation missing 
L["Wrath of the Lich King"] = "Wrath of the Lich King"
--Translation missing 
L["Wriggling Darkness"] = "Wriggling Darkness"
L["Yesterday"] = "Ontem"
--Translation missing 
L["You already defeated %d of them."] = "You already defeated %d of them."
--Translation missing 
L["You already defeated all of them."] = "You already defeated all of them."
--Translation missing 
L["You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."] = "You can turn off holiday reminders as a whole or on an item-by-item basis by visiting the Rarity Options screen."
--Translation missing 
L["You entered a achievement ID that is already being used by another item."] = "You entered a achievement ID that is already being used by another item."
--Translation missing 
L["You entered a creature ID that is already being used by another item."] = "You entered a creature ID that is already being used by another item."
L["You entered a reserved name. Please enter the correct item name as it appears in game."] = "Você inseriu um nome reservado. Por favor, insira o nome correto do item como ele aparece no jogo."
L["You entered a spell ID that is already being used by another item."] = "Você inseriu um ID de feitiço que já está sendo usado por outro item."
L["You entered an item ID that is already being used by another item."] = "Você inseriu um ID de item que já está sendo usado por outro item."
--Translation missing 
L["You entered an item ID that is already set as the collected item for something else."] = "You entered an item ID that is already set as the collected item for something else."
L["You must enter a creature ID."] = "Você deve informar o ID da criatura"
L["You must enter a number larger than 0."] = "Você precisa inserir um número maior que 0."
L["You must enter a number larger than 1."] = "Você precisa inserir um número maior que 1."
L["You must enter a number larger than or equal to 0."] = "Você precisa inserir um número maior ou igual a 0."
L["You must enter a spell ID."] = "Você precisa inserir o ID de um feitiço."
L["You must enter a valid number."] = "Você precisa inserir um número válido."
L["You must enter an amount."] = "Você precisa inserir uma quantidade."
L["You must enter an item ID."] = "Você precisa inserir o ID de um item."
L["You must enter at least one item ID."] = "Você precisa inserir o ID de pelo menos um item."
L["You must enter at least one NPC ID."] = "Você precisa inserir o ID de pelo menos um PNJ."
L["You must enter at least one Statistic ID."] = "Você deve inserir pelo menos um ID de Estatística."
L["You must enter at least one zone."] = "Você precisa inserir pelo menos uma zona."
--Translation missing 
L["Young Talbuk"] = "Young Talbuk"
--Translation missing 
L["Young Venomfang"] = "Young Venomfang"
--Translation missing 
L["Zandalari Anklerender"] = "Zandalari Anklerender"
--Translation missing 
L["Zandalari Footslasher"] = "Zandalari Footslasher"
--Translation missing 
L["Zandalari Kneebiter"] = "Zandalari Kneebiter"
--Translation missing 
L["Zandalari Toenibbler"] = "Zandalari Toenibbler"
--Translation missing 
L["Zangar Spore"] = "Zangar Spore"
--Translation missing 
L["Zhevra Lounge Cushion"] = "Zhevra Lounge Cushion"
--Translation missing 
L["Zomstrok"] = "Zomstrok"
--Translation missing 
L["Zone"] = "Zone"
L["Zones"] = "Zonas"

end
