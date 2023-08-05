# Raider.IO Mythic Plus, Raiding, and Recruitment

## [v202308040600](https://github.com/RaiderIO/raiderio-addon/tree/v202308040600) (2023-08-04)
[Full Changelog](https://github.com/RaiderIO/raiderio-addon/compare/v202308030600...v202308040600) [Previous Releases](https://github.com/RaiderIO/raiderio-addon/releases)

- [Raider.IO] Database Refresh  
- localization tweak for replay system  
- Merge pull request #247 from RaiderIO/feature/replay-beta-adjustments  
    - Separated the replay frame locking and docking. This way you can Dock, or Undock and then Lock/Unlock.  
    - Changing replay will ask for confirmation if the run has been completed, since that will reset the live data.  
    - Fixed a situation where combat indicator got stuck even when boss was dead.  
    - Changed the replaySelection variable to match the same values as the replay `sources` values for convenience.  
    - Added dropdown code to the config frame for replay type preference.  
    - Changed `GetReplayForMapID` to prefer those replays that match the replay type preference.  
    - Changed the config frame to create itself on demand when the user needs to open it.  
- Changed the `replaySelection` variable to match the same values as the replay `sources` values for convenience.  
    Added dropdown code to the config frame for replay type preference.  
    Changed `GetReplayForMapID` to prefer those replays that match the replay type preference.  
    Changed the config frame to create itself on demand when the user needs to open it.  
- Fixed a situation where combat indicator got stuck even when boss was dead.  
- Separated the replay frame locking and docking. This way you can Dock, or Undock and then Lock/Unlock.  
    Changing replay will ask for confirmation if the run has been completed, since that will reset the live data.  
