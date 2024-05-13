# DBM - Vanilla and Season of Discovery

## [r725](https://github.com/DeadlyBossMods/DBM-Vanilla/tree/r725) (2024-05-11)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Vanilla/compare/r723...r725) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Vanilla/releases)

- readd project IDs so it can actually package  
- Remove Burning Crusade mods (#147)  
- Split .pkgmeta by release type  
    This seems to be the only way to fully exclude a whole addon from  
    release builds.  
    https://github.com/BigWigsMods/packager/issues/165  
- Add test for Atal'arion mod  
- Add basic vscode config  
- Upgrade LuaLS and use multi-threaded checking  
- ST Trash: use different icon for ghosts  
    Similar skull/bones texture but slightly more visible than the previous  
    one when there are a lot of hunter frost traps on the ground.  
- Update koKR (BCVanilla) (#144)  
- Fixed bad arg position for option default on Chromaggus and Talon Guards  
    Fixed broken inline icon on Majordomo  
- ST: add trash mod that sets a nameplate timer for the ghosts  
