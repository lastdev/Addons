# <DBM Mod> Raids (WoTLK)

## [r325](https://github.com/DeadlyBossMods/DBM-WotLK/tree/r325) (2024-01-16)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-WotLK/compare/r324...r325) [Previous Releases](https://github.com/DeadlyBossMods/DBM-WotLK/releases)

- Bump tocs for 10.2.5  
- Update localization.cn.lua (#61)  
- fix typo  
- Fix variable names for options to actually match spell names  
    Attempt to detect corp on boss when player changes realms in stage 3 and issue an updated alert if one hasn't been issued within last 3 seconds  
- RS-Halion: modernize GUI + phase voices (#60)  
- Prettier Corpereality code  
    Don't run if content is trivial (ie a player will instantly 1-2 shot boss and get like 5 CLEU events for it all at once  
- RS-Halion: add Corporeality SA (#58)  
- add C\_UIWidgetManager  
- shorten twilight cutter cast time by .5  
- Fix twlight realm debuff Id (how did that get fucked up, i literally copy/pasted it from transcriptor)  
- Another Halion Update:  
     - Improve initial stage 2 timers on Halion for twilight realm by detecting when halions timers actually start (when tank engaged)  
     - Fixed a bug where too many timers were stopped on stage 2 start. Only Fiery Combustion stops, breath and meteor continue  
     - Fixed a bug where meteor timer is restarted on stage 3 start. Again, only Fiery Combustion resumes cause it was only one that stopped  
-  - Alternate Win detection for faction champions using mob death counting, Should hopefully fix #53  
     - Changed alert text for anger stacks on northrend bests, should resolve #51  
     - Various Timer adjustments. Closes #59  
- Updated Halion  
     - Fixed some timer bugs (mostly breaths)  
     - Vastly improved detectin of realm player is in, allowing to more appropriately filter warnings and use new timer fade tech for phase player isn't in  
     - Reduced reliance on Yells for detecting phase changes and meteor casts  
     - Reduced reliance on syncing since it's confirmed classic (like retail) now shows all combat log events for both phases (unlike OG wrath which only showed events for one you were in)  
     - Fixed phase 3 soon announced from UNIT\_HEALTH not scanning boss2  
- improve meteor warnings and clarity  
