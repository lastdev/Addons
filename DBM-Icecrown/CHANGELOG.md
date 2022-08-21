# <DBM> Icecrown Citadel

## [r308](https://github.com/DeadlyBossMods/DBM-WotLK/tree/r308) (2022-08-16)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-WotLK/compare/r307...r308) [Previous Releases](https://github.com/DeadlyBossMods/DBM-WotLK/releases)

- TOC bumps  
- adjust KT active timer  
- Fix sapheron GTFO  
- kill off roar completely, it's not in wrath naxx.  
- slighty adjust spore timers  
- Add polarity shift yell to thaddius  
- kill gluths fear timer, it's not useful  
- Prevent shadron, Tenebron, and Vesperon from engaging if sartharian is already engaged  
- Try drakes a diff way  
- also check string and Id for good measure, cover all bases. Classic likes using old or different tech  
- Fix thaddius again, this time considering that classic decided to put count somewhere else instead of using retail placement. Same issue as black temple (which is handled by core infoframe)  
- Remove the bad classic synced code for a mechanic that doesn't exist in wrath version. restore original wrath code  
- Actually thaddius still won't work that way, have to just not use cores wrapper for this  
- Fixed bug taht caused sarth drake detection not to work with modern unitdebuff checking in core  
    Fixed bug taht caused thaddius charge detection not to work because the code wasn't using up to date UnitDebuff code (that requires spell name or Id, not index)  
    Remove decimate timer on gluth  
    Fixed fissure warning on KT to actually have target name  
- Fix missing target scan object on anub when features were synced over from classic  
- Revert "Remove unnessesary check. it's an oncombatstart function, which means it only fires on boss engage, which is only possible in right zone"  
- Remove unnessesary check. it's an oncombatstart function, which means it only fires on boss engage, which is only possible in right zone  
- Set wrath classic stats type on ulduar  
- Trigger WOTLKC builds on commit  
- Fixed a bug where malygos syncs would be recieved by players in group (but not in raid)  
    Updated Malygos, Noth, and Faerlina mods to account for fact boss unitIds don't exist in wrath classic  
    Fixed a bug on Faerlina where frenzy message would show twice  
- Uniforn tocs to all use same format instead of some being one way and some being another.  
- Support wrath interfaces  
- fixed bad option spellid  
- Fixed bad option default on Sartharion  
    Fixed bad spell grouping on Halion  
    Updated some objects in Vault of Archivon to use latest objects  
    Fixed some groupings in Vault of Archavon  
- fix tab spacing from some code pulled out of archive  
- Significnt pass on Ulduar Resolving following:  
     - Fixed several spells not grouped up correctly  
     - Fixed several spells having wrong spellid assigned to them (messing up timers, alerts and option text)  
     - Tweaked some No Filter rules for some target warnings  
     - Re-introduced 10 man timers for certain encounters on classic difficulty that have different timings versus retail (which uses 25 man timers across the board)  
     - Rolled achievement timer options back to original Ids when mods are not loading on retail  
     - Made Options for Iron council look neater  
     - Fixed bug where combat detection on mimiron was busted do to bad overwrite of RegisterCombat  
     - Added distance filtering to Thorim using modern prototype so that alerts for tunnel or arena group aren't shown to the alternate group  
- Fix #16  
- Second ToC pass, clarifying some option text and improving group by spell slightly  
- Another pass on ICC with improvement to option groupings and text descriptions  
- update lua check to make wrath happy  
- Classic wrath Naxx bugfixes/improvements  
- minor code tweaks to naxx and malygos  
- missed a line deletion  
- ICC Update  
     - Modernized a lot of code and api usage  
     - Fixed a few bugs spotted  
     - Updated several things to use more modern features  
     - Changed several icons used to prefer lower index over higher index. Modern mods favor lower index so skull and X aren't used if they don't have to be (thus allowing raid leaders to actually use them for marking kill targets). legacy mods tended to favor using those icons and it just doesn't align with current mod design.  
     - Changed a few target warnings to be non filtered target warnings if warning was deemed important and if it didn't have a special announce (ie it was the only warning for that spell).  
- Fix option type  
- Fix option  
- Change bool -> icon option  
- Malygos touchup  
- Did a pass on Trial of Crusader raid modules, modernizing the code and features  
- Modernize Obsidian and ruby sanctum mods with newest objects and features and code cleanup  
- Fixed a bug where the sarth fail feature would attempt to announce to group if you were not in one.  
    Also fixed a bug where it'd try to announce to raid if you were in a small party insteead.  
