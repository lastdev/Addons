# <DBM> Dungeons (Dragonflight)

## [r41](https://github.com/DeadlyBossMods/DBM-Dungeons/tree/r41) (2022-09-17)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Dungeons/compare/r40...r41) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Dungeons/releases)

- Update Skylord Tovra to use new combat log event for breath. Also fixed missing engage timers for fight.  
- forgot legacy mod lack any kind of conventions  
- Update all mods in Iron docks to use the new combat log events.  
    This means many timers are now available that weren't as easy to do before.  
- Fixed 27 instances of dispel warnings using "Healer" classification instead of "RemoveMagic" for magic type debuffs  
    Fixed one case of a dispel warning not having voice pack support  
    Fixed two cases of spells having dispel warnings that aren't actually dispelable  
- Crawth and Doragosa drycodes  
- Update koKR (DF) (#62)  
- Forgot to comment unused  
- More renames and two boss drycodes for Algethar Academy  
- The non DF stuff wasn't supposed to push yet as I don't think those hotfixes are staged yet, but might as well fix bug and push rest anyways  
- Rename Algethar Academy  
- Push rest of Halls of Infusion, at least what's possible with undertuned heroic  
- Push first half of Halls of Infusion  
- Small pass on Nokgar to re-enable some timers off limited data that actually is in combat  log. But much can't be fixed without multiple transcriptor logs (or blizzard actually putting boss abilities into combat log)  
- Fixed add timer/alert not working on Curator  
    Fixed evocate timer for S4 on Curator  
- couple tweaks for latest build  
