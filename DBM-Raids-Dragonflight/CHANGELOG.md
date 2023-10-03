# <DBM Mod> Raids (DF)

## [10.1.28](https://github.com/DeadlyBossMods/DBM-Retail/tree/10.1.28) (2023-10-03)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/10.1.27...10.1.28) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- pre new tags  
- Update localization.ru.lua (#270)  
- Added cinematic messaging  
- Push mythic updates since they're BW public  
- Update Gnarlroot mythic marking code  
    Update Nymue non mythic code (mythic work still WIP, since not needed yet)  
- Retire Cinematic auto canceling. Blizzard decided to make this a protected function in a hotfix binary this week. While the actual cinematic skip still worked before execution tainted. It's not desirable to have users get action blocked errors on cinematics. Fixes https://github.com/DeadlyBossMods/DBM-Retail/issues/937  
- Mythic drycodes for Gnarlroot  
- Start mythic prep with Smolderon  
- one option key bugfix  
    added missing chat yells for coiling flames  
- Added some missing messages to Larodar  
- Update option keys for first 3 bosses for universal weak aura parity  
- Extended Laradar timers  
- Do tank claws same way BW does, to ensure parity between counts and weak aura usage  
    Fixed bug on Smolderon  
    Added unit target scan to volcoross  
- Remove polymorph initial applied yell  
    Fixed toxic javs yells showing on heroic, it's mythic only now  
    Some normal mode timer fixes for Igiria  
    Changed how moonkin and tree form ability timers work on tindral to better support users who might turn the actual form timers off  
    Turned fiery growth icon option to off by default.  
- Full larodar mod from drycode to completion on normal at least. subject to improvement with longer normal pulls, or heroic testing when it happens.  
- Forgot to set these to heroic values  
- Gnarlroot update from both heroic and normal testing  
- Change event for blinding rage interrupt since weakened defenses not always visible in combat log  
- UPdate tindral with the changed P1 timers for normal (heroic might be changed too but until confirmed normal and heroic will use different tables)  
- Fix typos  
- Igira fixes and updates, post testing  
- Update Nymue from testing  
- Tindral updated from test data  
- Fixed some bugs in council mod as well as follow same count increment rules as BW  
- Fix  
- Vocoross post testing update  
- Update localization.ru.lua (#936)  
- Somehow missed a lot of spellids  
- Push the Nymue drycode  
- One more fix, plus improve staging code  
- Forgot to uncomment a line  
- Tindral Sageswift drycode  
- Update localization.ru.lua (#269) Minor changes  
- Update localization.tw.lua (#935)  
- PUsh the volcoross drycode  
- Fixed issue wehre old ICC module could still be allowed to load and conflict with new unified module  
- tweak  
- Add post testing Smolderon and Council works  
- forgot pres  
- Fixed evoker specs not getting flagged with interrupt options on by default. spec roll now identifies when specced into interrupt spell  
- bump alpha  
