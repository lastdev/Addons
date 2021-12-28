# <DBM> World Bosses (Shadowlands)

## [9.1.23](https://github.com/DeadlyBossMods/DBM-Retail/tree/9.1.23) (2021-12-15)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/9.1.22...9.1.23) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- Prep new releases  
- updates to 4 bosses being tested this week based on latest journal.  
- Update and Fix zhCN (#30)  
- Forgot GetStage api  
- rename variable because it makes it clearier this way  
- Internally track how many times SetStage has been called by any given mod and keep track of total, as well as include it in callback. This will allow niche weak aura creation that needs these specific totals to function versus journal phasing numbers.  
- Painsmith intermissions are now assigned 1.5 and 2.5 for greater distinction via callbacks  
- More import fixes;  
    - If sound is a number, its a built in sound too, so skip check  
    - Fixed missing locale for missing voice pack import  
- Proper validation matching at start of string.  
- Ignore built in sounds in DBM:ValidateSound  
- Update localization.tw.lua (#29)  
- Update koKR (#28)  
- Update koKR (#701)  
- FInish the Lihuvim mod, post testing.  
- Fix warnDegenerate typo  
- Fix warnDegenerate local typo  
- Update localization.tw.lua (#27)  
- Option locale somehow got duplicated?  
- Add new desaturation option for bars;  
    - This allows grayscaling non-huge bars, making them appear less important  
    - Feature request ;p  
- Minor timer adjustments. Closes #700  
- Push finished Xymox  
- Improve mod debugging/transcriptor logging by adding stage changes to logging  
- quick fix to filter system shock on non tanks  
- Fix bad copy paste  
- Unify language and termonology on announce and special announce option descriptions  
- Changed sylvanas and anduin mods to use by phase category sorting and headers for much cleaner option navigation for these long multi phase fights  
- Added Lihuvin drycode that's iffy at best...Journal is a hot mess so no promises mod won't be same.  
- Fix a line that got moved somehow (accidental drag?)  
- Fixed bug with sepulcher trash mod being assigned to incorrect parent mod  
    Improved jailer mod considerbly by making options panel for it a hell of a lot more readable and organized.  
- In some cases, especially for end bosses, it may be preferred to disable the auto sorting of announce objects and instead manually sort it at mod level by boss stage. This adds support for core for a single mod to override behaviors easily  
- Fix numpty  
- More spacer shortcuts  
- Fix error in last  
- Some tweaks/updates to Xymox mod before testing  
- Unify whispers to use chatPrefixShort  
- bump alphas for next dev cycle  
