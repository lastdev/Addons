# SavedInstances

## [9.2.1](https://github.com/SavedInstances/SavedInstances/tree/9.2.1) (2022-02-28)
[Full Changelog](https://github.com/SavedInstances/SavedInstances/commits/9.2.1) [Previous Releases](https://github.com/SavedInstances/SavedInstances/releases)

- fix: use GetSavedInstanceInfo to track previous expansion LFRs  
    basically revert 62ecf70 and 205643a, with tweaks for distinguishing LFR from normal  
    workaround for GetLFGDungeonNumEncounters and GetLFGDungeonEncounterInfo stops working  
