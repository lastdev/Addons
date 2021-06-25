# SavedInstances

## [9.0.8](https://github.com/SavedInstances/SavedInstances/tree/9.0.8) (2021-04-28)
[Full Changelog](https://github.com/SavedInstances/SavedInstances/compare/9.0.7...9.0.8) [Previous Releases](https://github.com/SavedInstances/SavedInstances/releases)

- Progress: fixes #505  
- Currency: rework season related currency  
    * check useTotalEarnedForMaxQty for using totalEarned  
    * stop fetching info from tooltip  
    * (all currency) get description from API to avoid misleading info  
- #501: adding relatedQuest to data structure  
- rudimentary support for world quest weekly (#501)  
- core: prevent update Covenant on logout  
- misc: fix luacheck  
- core: add Covenant  
    closes #482  
- Quest: update Ve'nari Weekly  
- calling: fixes #490  
- currency: add totalEarned for earn-capped currency  
