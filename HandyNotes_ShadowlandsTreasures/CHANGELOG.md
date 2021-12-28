# Changelog

## Changed in v33

* Added a lot of nodes to groups for easier hiding of clutter: Fractured Faerie Tales, Playful Vulpin, Shard Labor, Wardrobe Makeover, Harvester of Sorrow, Spectral Keys, Stolen Anima Vessels, Rift Hidden Caches, and various transportation hints

## Changed in v32

* Updated for 9.1.5 (no real API changes)
* New Maw teleporters added
* Cloudwalker's Coffer in Bastion was missing loot
* Mastercraft Gravewalker in Korthia got a mountid finally
* Explain how to get Tahonta in Maldraxxus
* Better-explain the Shimmermist Runner in Ardenweald
* Better hiding of the Cache of the Moon tools during various stages of that quest
* Improve the location for the Wild Worldcracker - show it at the end of Popo's patrol, not the beginning
* Improved display for Zovaal's vault

## Changed in v31

* Korthia: include Invasive Mawshrooms and Nests of Unusual Materials
* Maldraxxus: say whether the arena mount has been attempted today
* Listen to the CRITERIA_UPDATE event again, as it seems to no longer be spammed constantly, which should make things like the Spectral Key get removed from your minimap more promptly

## Changed in v30

* Maw Kyrian Assault: added the Sinfall Screecher pet
* A Sly Fox will now show on the minimap as well as the world map
* Xyraxz and Yarxhov will be labeled as such, rather than as the relics they're guarding
* Observer Yorik's quest id has been updated
* A new Maelie location has been added
* Maelie's progress will show better when you're at 6/6 and haven't turned in the quest to get the mount yet
* Removed the Glimmerfly Cocoon toy finally, it's definitely not dropping

## Changed in v29

* Maw Night Fae Assault: include the Jailer's Personal Stash achievement
* Maw Necrolord Assault: include the second Stolen Anima Vessel
* Better explanation in the tooltip for things which are hidden in the rift
* New feature: some points are in "groups", so you can now use the menu or right-clicking to hide all the points of that type. E.g. all the Korthia daily mounts, mawsworn chests, etc
* Missing Maw rares: Deomen the Vortex, Guard Orguluus
* Minor missing loot in Riftbound Caches

## Changed in v28

* You can now share a point to chat by shift-clicking a point or selecting it from the right-click menu (thanks, answering so many Maelie questions)
* Covenant-gated points will now show as inactive rather than hidden, as you can generally participate and get loot if a covenant-member triggers them
* Korthia now includes Mawsworn Caches
* A Sly Fox is shown during the Maw Kyrian assaults
* The Night Fae assault stolen anima vessels now have questids
* The Skittering Broodmother in the Maw has moved
* Added another Maelie location
* Added another spectral key location
* Missing Maw mob: Traitor Balthier
* Added some missing loot from the Inquisitors in Revendreth

## Changed in v27

* Added rares in Maw: Blinding Shadow, Fallen Charger
* Mine new loot; lots added to the Maw rares

## Changed in v26

* Nilganihmaht
    * Better explain the Domination chest
    * Show some of the quartered ancient ring pieces during the Necrolord assault
    * Flag Torglluun as being in the rift
* Show you how many razorwing eggs you've looted so far today (of the two you can get)

## Changed in v25

* Fix an error when trying to show loot for Ylava in the Maw (`C_Item.RequestLoadItemDataByID`)
* Add some missing loot, and a missing Helgarde Supply Cache

## Changed in v24

* Added to the Maw:
    * Nilganihmaht mount (apart from the necrolord assault bits)
    * Stolen Anima Vessels
    * Rift Hidden Caches
    * Zovaal's Vault
* Added Riftbound caches and Rift portals to Korthia
* Explain Consumption's mechanic so you can maybe actually get loot from it

## Changed in v23

* Notes for transporters and waystone in Korthia
* Add the new 9.1 treasures that're actually in the Maw
* Add the various mounts via daily actions in Korthia
* Improved ability to show progress in tooltips
* Add some missing items from the Blackhound Cache in Maldraxxus

## Changed in v22

* Updated for 9.1
* Korthia rares and treasures
* Maw got animaflow teleporter waypoints

## Changed in v21

* Updated for 9.0.5
* All the Blanchy steps now
* Many improvements to Bastion
* Much new loot pulled in from wowhead

## Changed in v20

* Add the inquisitors for It's Always Sinny In Revendreth
* Pull in datamined loot from [SilverDragon](https://www.curseforge.com/wow/addons/silver-dragon), because I might as well share data I've acquired with myself...
* Better type labels for items in tooltips
* Count transmog for completion purposes. This will only consider items for which your current character could learn the appearance
* Various improved descriptions
* Show where to get Handful of Oats for Blanchy in Westfall

## Changed in v19

* Support items with associated quests for completion purposes
* In tooltips, show a check/cross next to collectable items so it's easier to tell whether you've got them

## Changed in v18

* Maldraxxus: improve Sorrowbane description further; added some missing loot to Gieger
* Ardenweald: confirmed that Macabre doesn't require the dance-loop any more, updated notes
* "Path" nodes were sometimes not showing the correct icon

## Changed in v17

* Fix anchoring for tooltips on minimap icons
* Minor treasure updates in Maldraxxus and Bastion

## Changed in v16

* Add achievements:
    * Bat!
    * What We Ride In The Shadows
    * Wardrobe Makeover
* Properly explain acquiring Sorrowbane
* Show when loot is covenant-specific
* Fix Dead Blanchy's position, show where you are in the questline in its note
* Change how the tooltip anchors, so it's less likely to be in the way; there's an option for the old behavior if you prefer it

## Changed in v15

* Many Ardenweald improvements, but mostly to the Night Mare questline

## Changed in v14

* Routes on the map will highlight when you mouse over the relevant point
* The Maw now has a marker for the Waystone
* Bastion achievement What is that Melody? now included
* Various Bastion cleanups and some notes on Anima Shard locations
* Revendreth: explain the Forgotten Angler's Rod, since you may have to re-phase for it

## Changed in v13

* Can now show paths on the map; use this for the carriage routes in Revendreth and to link the teleporters in the Maw
* Some treasures don't count as "done" until you've used an item collected from them or completed a quest they start. These will now be hidden while you're carrying that item / are on that quest
    * I probably haven't flagged all of these ones yet
* Updates to Ardenweald's initial leveling portion
* Small updates to Maldraxxus
* Small updates to Revendreth
* Maw now has some lore nodes

## Changed in v12

* Add config to let achievement status override quest status. Enabling this will stop the daily rares from showing after you've killed them once.
* Add config to let account-knowable loot (mounts, toys, pets) which is known count as "found". This is enabled by default.

## Changed in v11

* Add a toggle so you can turn that world map button off if you don't want it
* Tweaked the default icon scale to be slightly smaller
* Improved Ardenweald, mostly so that icons for sub-objectives are easier to pick out from the main treasures
* More Maw loot has shown up

## Changed in v10

* Add a button to the world map for easy config access

## Changed in v9

* Better display for quests in tooltips
* Updated loot and notes for all zones

## Changed in v8

* Improved the data for Bastion and Maldraxxus
* Better display when treasures aren't currently available, though data is very incomplete as to which ones do (because it's difficult to tell without visiting them all... and it might turn out to *really* be "are you in any covenant?" and I need 
to get a leveling character to the right point to test this)
    * By default unavailable mobs/treasures will still show up, but tinted red. If this is very annoying, there's a setting for it in the options

## Changed in v7

* Add Chaotic Riftstones to the Maw
* Fix check that was stopping collected jellycats from being hidden before you'd completed the entire Nine Afterlives achievement

## Changed in v6

* Add achievement: Nine Afterlives (the jellycats)
* Flag Bastion Abandoned Stockpile as being max-level, and highlight its entrance.
* Fix the Larion Tamer's Harness location and loot
* Explain the Corrupted Clawguard better
* Make path-to-treasure nodes display on the minimap automatically
* Cache loot when opening the zone map, so there's less "loading..."
* Change the default point icon to the blizzard default chest vignette icon (which looks way better than it did in the last expansion)
* Add some config for setting a default icon, if you'd prefer something different

## Changed in v5

* Update loot and some spawn locations

## Changed in v4

* Fix an error in the Maw if you were using item icons
* Basilofos seems to not have that toy now we're out of beta
* Change some mount drops in Maldraxxus

## Changed in v3

* Rares for all zones
* Add config for hiding specific achievements
* Fix the check that should have been hiding the Anima Shards in Bastion before you're 60

## Changed in v2

* Filled out questids for per-character completion
* A lot more information about Blanchy
* The Shard Labor achievement in Bastion

## Changed in v1

* Created with the achievement-related treasures
