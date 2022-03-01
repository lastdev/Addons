# <DBM> Dungeons (BC)

## [r32](https://github.com/DeadlyBossMods/DBM-Dungeons/tree/r32) (2022-02-22)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Dungeons/compare/r31...r32) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Dungeons/releases)

- bump toc files  
- Just kidding, that stuff is done too since most of it was already done, just needed a few touchups  
- Todays pass on dungeon mods bring WoTLK dungeons complian with latest gui.  
    TODO, these mods need more modern updates like voice pack support and color bar by type.  
- Wod dungeon pass to improve GUI options  
- missed one deletion  
- Big Mop Dungeon Update:  
     - Added Voice pack support to all MoP dungeons that didn't have it  
     - Updated timer bars for all mop bars that didn't have "color by type" assigned  
     - Fixed a few target warnings in all mop dungeons to not be filtered if they were only warning for spell  
     - Removed redundant warnings that didn't need to exist to reduce overall feeling of spam in mop dungeons  
     - Interrupt and dispel warnings should now go through dispel or interrupt filter object in DBM core like modern mods do for all mop dungeons  
     - Some target timers were deleted that felt like they weren't really needed.  
- Added voice pack support and color by type suport to more of the mop dungeons (still some not done yet)  
    Small tweaks to option GUI formatting too  
- Full pass on Bfa dungeons to improve their appearance on new GUI  
- Fix all cases of duplicate spell entries in legion dungeons  
- Fix #37  
- Fixed every reported timer from #35  
- Fixed 3 direct calls to SetRaidTarget to properly use SetIcon and honor global disable  
- change voice pack files in 8 files  
- Repair improper event usage on Krikthir. Closes #36  
- Disable ES on Hadronox since it fires badly  
    Also added sync protection against bad ES from all 3 dungeon bosses in wrath using ES disable  
- Fixed a missed locale  
