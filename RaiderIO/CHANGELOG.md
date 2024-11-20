# Raider.IO Mythic Plus, Raiding, and Recruitment

## [v202411180600](https://github.com/RaiderIO/raiderio-addon/tree/v202411180600) (2024-11-18)
[Full Changelog](https://github.com/RaiderIO/raiderio-addon/compare/v202411170600...v202411180600) [Previous Releases](https://github.com/RaiderIO/raiderio-addon/releases)

- [Raider.IO] Database Refresh  
- [Raider.IO] Classic Database Refresh  
- Vlad's Fixes for Main Raid Progress (#303)  
    - Moved `tier` into the `RaidProgressGroup` and made it available in `RaidProgressGroup`.  
    - Adjusted `SummarizeRaidProgress` so that `appendBossInfo` also takes the `tier` and simply stores it in the data it creates.  
    - Created `IsRaidGroupBestMainProgress` that helps evaluate if the given `raidGroup` is for a main, and that it has more progress than the other available data.  
    - Adjusted `AppendRaidProgressToTooltip` to use this new function, and added an additional condition to evaluate if this raid group should be shown. It will be yes for any mains with more progress than what the current character has available.  
    Co-authored-by: Alex Pedersen <vladix@gmail.com>  