# <DBM> World Bosses (Dragonflight)

## [10.0.32](https://github.com/DeadlyBossMods/DBM-Retail/tree/10.0.32) (2023-03-09)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/10.0.31...10.0.32) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- prep new tag  
- fix order of operations problem from last commit. can't use DBM global in spec role cause spec role has to load before DBM  
- fully rebuild specrole table on spec changes to resolve issue where the table generated at login is out of date with talent swaps  
- test worked, so remove debug checks and allow this to now work with 3rd and first party nameplate code  
- apply several minor adjustments to sennafrth  
- Support 3rd party nameplates for sanguine now that trash mod had been reworked to have a clean way to register/unregister 3rd party nameplate events. for testing, this will be limited to debug mode  
- Fixed bug that caused auto gossip not to work by index onn 10.0.5, since code path assumed 10.0.7  
- bump alphas  
