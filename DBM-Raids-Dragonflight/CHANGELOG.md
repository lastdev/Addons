# <DBM Mod> Raids (DF)

## [10.2.9](https://github.com/DeadlyBossMods/DBM-Retail/tree/10.2.9) (2023-12-03)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/10.2.8...10.2.9) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- prep new retail tag  
- Disable Surging growth alerts and timer in LFR, since it's based on applied (due to blizzard hating combat log) and in LFR this is not a reliable metric like at all  
- Update koKR (Retail) (#963)  
- Fix last  
- Rework timers to correctly support LFR version of Council of Dreams  
- sync naming  
- bump alpha  
- prep new tag for classic era/SoD  
- comment this code on retail for now  
- Prep classic era tag  
- Remove bad language on dispel alerts. most dispels aren't spellstealable and it's misleading  
- Support Season of Discovery instance difficulty Ids  
- revert nymue using boss distance checks for now. no ETA on change is known  
- fix jump announce  
- set EnableMouse on parent frame, to allow clickthrough.  
- Revert CheckBossDistance check to using Item apis on bosses again, with blizzard reverting nerf on hostile targets for this purpose. (range check still dead, distance on players still forbidden). This is just a concession blizzard agreed was a reasonable one.  
- Switch nymue back to distance calculation usage on bosses for filtering  
- actually make sure unit is the boss  
- fixes  
- Finally add Aurostor mod  
- again trying to fix special CD checking logic, cause it appears code was still just returning false 100% of time even when special was literally 40 seconds away.  
- tweak fyrakk and igira tank swaps to not swap unnessesarily early  
- Since it's early tier, will be updating the version check more often for checking if other raiders mods are out of date.  
- Fix barreling charge to use YELL and following conventions  
- More taunt tech improvements to smolderon  
- timer tweaks  
- Further refine tanking on smolderon to help movements  
    Fixed tank swap alerts on council to be more correct and less spammy  
    Also added a special alert to dodge charge if you already have trampled for all players  
- fix smolderon tanking stuff  
- small nitpick, make corrupt appear in stage 1.5 list  
- bump alpha  
