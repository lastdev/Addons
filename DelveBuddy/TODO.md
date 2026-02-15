== DelveBuddy TODO ==

* Test wacky stuff in combat?
* Put in failsafe code for if doing stuff in delves when in combat?

=== Midnight ===
* On a L90 char right now, it shows *all* bountiful delves... TWW, and Midnight. Should probably only show the most relevant? Auto-detect?
* Maybe busted
  * Woldsoul memories - are those a thing at all in Midnight??
  * New Nemesis Lure item not working?
  * Fix LibQTip LUA error 
    * `HookScript is not allowed on LibQTip tooltips`
    * ([Titan/libs/Ace/LibQTip-1.0-49/LibQTip-1.0.lua]:706: in function 'HookScript'
    * [DelveBuddy/DataBroker.lua]:690: in function 'PopulateDelveSection')
* Need to re-test stuff for first Midnight delve season
  - Coffer Key Shards
  - Make shards no longer clickable? No longer items...
  - Coffer Keys (?)
  - Delver's Bounty (new?)
  - Nemesis lure (new?)
  - Keys/shards earned
  - Stashes looted
* Show new Delves
* Only show delves for L90 chars?
* Don't show TWW delves?

* Enhancement: allow enabling/disabling of specific columns?
* Bug: Should do warning checks periodically (and not on bag update)
* Enhancement: only show nemesis item if don't have bounty item or buff
* Bug: delver's bounty reminder happens on every inventory update (should just be 1 minute)
    * Would be good to refactor some of that stuff, too.
* Feature: reminder for Shrieking Quartz?
* Feature: show changelog on first login after update?
