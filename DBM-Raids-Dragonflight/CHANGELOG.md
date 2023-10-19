# <DBM Mod> Raids (DF)

## [10.1.30](https://github.com/DeadlyBossMods/DBM-Retail/tree/10.1.30) (2023-10-19)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/10.1.29...10.1.30) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- prep new retail only tag to add support for 2023+ hollowed end  
- cleanup  
- Add remaining gossip IDs  
- Add some auto gossip options for headless horseman (WIP)  
- First horseman update with better timer support, since it seems fight is fully sequenced script  
- copy and paste is hard apparently  
- Push headless horseman rework update  
- Fix missing spellid  
- Prep laradar and nymue for retests and private aura changes  
- SOme more nymue changes for rework  
- actually just go all out hybrid it against any possible chance of failures  
- Actually do last an even better way, by just using DBMs internal zone/alive check function to still stay a precise as possible (so object type lives up to it's nature) and still warn with no delay once either max total or max viable are reached as early as possible  
- prevent precise object from breaking if less people are alive or present than the expected max by still using scheduling fallback  
- Add new combined object that allows using total count instead of scheduling for aggregating targets. many mods know the count, but use scheduling pointlessly and this can be done better going forward by using correct object based on condition.  
- bump alpha  
