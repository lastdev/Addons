= DelveBuddy Changelog =

== 2.0.6 ==
Misc:
* Updated TOC for 12.0.1

== 2.0.5 ==
Fixes:
* Re-added missing Vault 3 column

== 2.0.4 ==
Enhancements:
* Added "iLvl" column to show current average equipped item level, so you know who needs to do more delves. :)

== 2.0.3 ==
Fixes:
* Removed accidental logging code on login (whoopsie!)

== 2.0.2 ==
Enhancements:
* Show a warning if your companion doesn't have a role set.

Fixes:
* Fixed a bug that caused some delves to display in the wrong zone
* Fixed a bug that caused vault reward iLvls to not be displayed correctly

Misc:
* Changed how bountiful delves are detected, which should ease finding new delves in future seasons

== 2.0.1 ==
Fixes:
* Fixed issue which caused DelveBuddy to not display if you had vault rewards earned using an older version of DelveBuddy. You will temporarily see "?" as the Vault reward iLvl for characters which haven't been logged in recently. Logging those characters will fix the issue, and correct iLvls will be displayed again.

== 2.0.0 ==
Enhancements:
* Updated for Midnight pre-patch 12.0.0 (with TWW Season 3 delves).

Misc:
* Rebuilt delve detection, reward classification, and other areas of the addon to be more data-driven. Everything looks and acts exactly as before, but with these changes it will be much easier to update when Midnight Delve Season 1 starts in March. 

== 1.3.6 ==
Fixes:
* Fix timerunning character detection

== 1.3.5 ==
Enhancements:
* Don't show delves or collect data for timerunning characters

== 1.3.4 ==
Enhancements:
* Added Delver's Bounty to the Delves tooltip (when you have one, and are in a bountiful delve)

== 1.3.3 ==
Enhancements:
* Added tooltips to Delve-O-Bot, Shrieking Quartz (thanks, BelegCufea!)

Other:
* Updated interface version for 11.2.5

== 1.3.2 ==
Enhancements:
* Added Delve-O-Bot 7001 to the Delves tooltip (thanks, BelegCufea!)
* Added Shrieking Quartz item to the Delves tooltip (thanks, BelegCufea!)

== 1.3.1 ==
Enhancements:
* Clicking the Coffer Key Shards owned cell for the current character uses the shards (to make a coffer key)

== 1.3 ==
Enhancements:
* Added tracking of Coffer Key Shards owned.
* Added better waypoint setting for Delves and Wordsoul Memories (thanks, BelegCufea!)
* Enhanced Vault display, color coded by tier (thanks, BelegCufea!)

Fixes:
* Show the Delve and Worldsoul tooltips _above_ the character tip when LDB display or minimap is set to the bottom of the screen. This should prevent those tips being truncated or off-screen.
* Fixed a bug that caused tooltips to go all wonky if the scale was set to anything other than 100%. Whoops!
* Reworked tooltip show/hide code (yet again), to hopefully make it more reliable and resilient.

== 1.2.5 ==
Fixes:
* More robust gilded stash count retrieval. You should see much fewer instances where stash count is unknown.
* More robust detectino of being in a delve, and whether the delve is complete. This should fix any remaining issues where Delver's Bounty reminder doesn't work properly.

Misc:
* Added "debuginfo" slash command to help with debugging stuff.

== 1.2.4 ==
Enhancements:
* Show the current delve story variant when hovering over a delve.

== 1.2.3 ==
Fixes:
* Made tooltip show/hide more reliable and resilient.

== 1.2.2 ==
Fixes:
* Fixed a bug that completely broke tooltips for some users due to bad tooltipScale.

== 1.2.1 ==
Fixes:
* Now correctly draws Radiant Echoes count in green if you have 5 or more.

== 1.2 ==
Enhancements:
* Show minimap tooltips on click, rather than mouseover. This avoid unintentinoally showing them, and just feels nicer.
* Add options to disable Coffer Key and/or Delver's Bounty reminders.
* Added option to control tooltip scale, to make it smaller or larger.
* Added tooltips to many of the options menu items, to better explain what they do.
* Added slash commands to control various options.

Fixes:
* Fixed a bug that caused a weird extra menu in Options.

Other:
* Moved Debug Logging options under an Advanced menu.

== 1.1.1 ==
Enhancements:
* Show Restored Coffer Key count on delves tooltip
* Show Radiant Echoes count in green if it's 5 or more

== 1.1 ==
Enhancements:
* Added TomTom waypoint option. Use Blizzard, TomTom, or both for setting waypoints.

== 1.0.5 ==
Enhancements:
* Dismiss tooltips when clicking value, delve, or memory

Fixes:
* Make tooltip dismissal less fiddly

Other:
* Consolidate waypoint code

== 1.0.4 ==
Fixes:
* Fixed a bug that caused Delver's Bounty to not be correctly recognized.

== 1.0.3 ==
Fixes:
* Fixed a bug which caused clicking the Vault 3 cell to not open the vault.


== 1.0.2 ==
Enhancements:
* Added tracking of weekly Coffer Key Shards earned
* Added Radiant Echo count to Worldsoul Memories tooltip

Fixes:
* Fixed Restored Coffer Keys earned count tracking

== 1.0.1 ==
Fixes:
* Fixed formatting bug when the number of stashes is unknown

== 1.0 ==
Official 1.0 release!

* Updated for 11.2 and Season 3
* Added tooltip showing current Worldsoul Memories

== 0.3 ==
* Fix reporting of iLvls of vault rewards


== 0.2 ==
Changes for 11.2, and misc enhancements:

* Update iLvls for season 3
* Show a message when no bountiful delves available
* Clicking a vault cell opens the vault window
* Misc code cleanup

== 0.1 ==
Initial Release