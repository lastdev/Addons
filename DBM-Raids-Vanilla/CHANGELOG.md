# DBM - Vanilla and Season of Discovery

## [r772](https://github.com/DeadlyBossMods/DBM-Vanilla/tree/r772) (2024-12-19)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Vanilla/compare/r771...r772) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Vanilla/releases)

- LuaLS: Fix global definitions  
- Lucifron: Use new targeted AntiSpam tracker  
- CThun: Keep dead stomach tentacles in the info frame, add test for stomach player tracking  
    To avoid confusion if only one is shown when the other is already dead  
- Dev: Update LuaLS/wowAPI config name for auto-globals  
- Viscidus: Update test golden after Core fix to correctly unregister short term events  
    Some warnings in these logs were actually triggered by the ThreeBugs mod which had a short term event registered that didn't unregister  
- Tests: Add trash mobs to known "interfering" mods for all AQ tests  
- AQ40 Trash: Add test data  
- AQ Trash: Improve tracking trash mobs and add test tracing  
    Dead mobs will no longer be re-added if they have spells that hit after they die (e.g., shadow storm bolts). Also fixes health tracking if you have multiple mobs with the same name and no raid target icons set  
- Tests: Add polyfill for new Core feature "TestTrace"  
- AQ: Fix placeholder icons on some warnings  
- Update localization.mx.lua (#283)  
- Update localization.es.lua (#284)  
- Update localization.br.lua (#285)  
- Update localization.fr.lua (#286)  
- Update koKR (#287)  
- Update localization.ru.lua (#288)  
- Revert "roll back to 22.04 to restore svn functionality"  
- make it clearer than never can be localized  
- roll back to 22.04 to restore svn functionality  
