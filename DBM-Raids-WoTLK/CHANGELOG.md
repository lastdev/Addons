# <DBM Mod> Raids (WoTLK)

## [r320](https://github.com/DeadlyBossMods/DBM-WotLK/tree/r320) (2023-10-14)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-WotLK/compare/r319...r320) [Previous Releases](https://github.com/DeadlyBossMods/DBM-WotLK/releases)

- re-enable 10 man goo timer, it was right, note wa wrong  
- Scope ooze spawn to only show if you are tank, or are the one spawning it to further reduce rotface spam  
    Turned radiating ooze alert off by default to further reduce rotface spam  
    reverted change on sticky, it still should be on for tank, but with other changes in this push should feel better  
- more antispam tweaks for rotface  
- Fixed a bug that caused sindragosa and valithria to not show heroic kill stats in GUI  
- use modern conventions and make spore use yell and not say, and add spore fading countdown  
- Rotface update  
     - significantly reduce alert spam on rotface by fixing a bug where vile gas alert showed multiple times and added throttle to sticky ooze alert and made it tank only by default.  
     - Also made sticky ooze timer a nameplate only timer that'll use plater now (and in future built in DBM features)  
     - also fixed a bug that caused vile gas timer to keep restarting.  
- alliance rp also longer by 3 seconds on classic  
- tweak option default on wounding strike and fix it showing double messages if two adds strike same target in same global  
- Improve ICC trash module voice pack support  
    fixed a bug that could cause slow icon clear on trash module, but also make icon option off by default too  
    also fixed stop casting warning on marrowgar trash to only be on for actual casters by default  
- adjust horde combat start timer for deathbringer to be slower than retail by 2.5 seconds.  
- adjust up sindragosa stack anounce from 4 to 5  
- also improve gunship battle win detection on classic  
- Fix malleable goo cast detection on festergut because of "nochanges"  
- Minor antispam fix for rotface  
- bump wrath toc  
- Also reset icons on new impales, no reason to keep descending icon for brand new sets. make it consistently always start at skull for new impales going out  
- Also reset icons on new impales, no reason to keep descending icon for brand new sets. make it consistently always start at skull for new impales going out  
- Changed to use 7 icons on LordMarrowgar instead of 8, leaving star fr… (#50)  
    Co-authored-by: David Groves <git@fibrecat.org>  
- Stage change tweaks for ICC to better improve WA stuff and fit retail conventions  
- All icon options are now off by default for blood queen, with a force option default reset. In modern era on this fight, these particular mechanics don't need icons, positional stuff does like bites  
- Middling concession on LK defile on tank scan that gets best of fix while still not hindering tank with slower warnings  
- Update DBM-Raids-WoTLK.toc (#47)  
