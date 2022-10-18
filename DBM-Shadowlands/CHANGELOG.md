# <DBM> World Bosses (Shadowlands)

## [9.2.37](https://github.com/DeadlyBossMods/DBM-Retail/tree/9.2.37) (2022-10-18)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/9.2.36...9.2.37) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- Update localization.ru.lua (#157)  
- Update koKR (#159)  
- prep new tags  
- kurog tweaks  
- Fixed bug on axe announce that'd cause it to only show if you had assist. Can't reply on marker callback for that.  
- Couple more bugfixes  
- More normal mode timers from public logs that went up to 7 minutes  (https://www.warcraftlogs.com/reports/t63nmYLz7jgxVfKG#fight=24&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20373059%20or%20ability.id%20%3D%20372322%20or%20ability.id%20%3D%20372056%20or%20ability.id%20%3D%20372027%20or%20ability.id%20%3D%20372279%20or%20ability.id%20%3D%20374038)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20386440%20or%20ability.id%20%3D%20386375%20or%20ability.id%20%3D%20386370%20or%20ability.id%20%3D%20386289)%20and%20type%20%3D%20%22applybuff%22%20%20or%20ability.id%20%3D%20371624%20and%20type%20%3D%20%22applydebuff%22&view=events)  
    Also fixed two count warnings.  
- throttle sticky webbing  
- Fix the fix to the fixes  
- fix the fixes  
- Fixes  
- Oh i thought i pushed this, damnit. Push experimental altar stuff  
- Add additional sorting methods for the auto sorted icon feature  
- Fix an extremely niche lua error with evokers that have no spec (api bug, they always have a spec)  
- Minor dungeon affixes fixes  
- Update koKR (#158)  
- Normal console update  
- No molten spikes on normal, rest seems fine  
- Fix erupting bedrock alert not working on normal mode  
    More work done for easy mode spell mapping  
    Need transcriptor log to see the now working stage 3 timers, since using WCL to fix this is a bit difficult when Damage and Avoid scripts cast same spell on normal :D  
- simplify terros, it's same on mythic heroic and normal, at this point assume this encounter designer didn't hate boss mod authors and made it easy for us :D  
- Dathia normal mode update  
- really don't like working on this boss  
- First pass on normal Sennarth.  
- Several fixes/updates to broodkeeper from normal testing  
- Push senarth mythic. like 20 groups killed that on testing.  
    Should also fix stage 2 detection for normal mode testing.  
- Dathea fixes from public mythic logs  
- Aggressive timer and warning aggregation to reduce timer and alert spam on mythc  
    Moved adds warning and timers to adds objects  
- new core object  
- more silly bug fixes  
- Shorten yell text for conductive mark  
- Fix  cyclone timer bug  
- Fixup the first boss with updates for the new/changed mechanics.  
- Fix yell text for rifts  
- Fixed bug with sennarth chat bubbles  
- Quick cleanup  
- Fix Eranog with latest build plus mythic prep  
- bump alpha  
- prep new wrath tag to get more features/fixes out  
- go nuclear on trying to work around blizzard sarth bug  
- here too  
- Fix bad arg order in new guild sync code  
- Actually fix stage 2 start/timers on Sennarth, also fixed big add detection  
- fix staging on sennarth  
- Update koKR (#156)  
- Update koKR (Retail) (#811)  
- Update localization.ru.lua (#155)  
- Update zhTW (#154)  
- Guild combat messages upgraded! - Group leader will now be included in all guild raid messages to make it easy to tell which guild group message is about for guilds that have multiple teams (Note: All localisations need to be updated and message will display in english until each language is submitted) - Wrath classic will now show raid difficulty in guild messages. This was incorrectly turned off for all classic flavors (including wrath). It'll now execute retails code path that displays raid difficulty.  
- Push finished council mod  
- Update Sennarth from heroic testing, it's still kinda WIP because I'd like to see some combat log events get added that can better narrow down more precise timer resets/transitions, but this will be passable for now.  
    Some bug fixes/updates for mythic terros as well  
- Fix some obvious bugs, most test analysis will fix more  
- Fixed wrong object type  
- Remove yells for now  
- Bump alphas  
