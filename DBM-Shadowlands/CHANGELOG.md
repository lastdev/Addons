# <DBM> World Bosses (Shadowlands)

## [9.1.26](https://github.com/DeadlyBossMods/DBM-Retail/tree/9.1.26) (2022-01-27)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/9.1.25...9.1.26) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- - Make default voice pack options VEM instead of none. - Removed the reminder messages for having a voice pack installed but disabled (since it'll be expected that not everyone wants to use them and it's no longer something users install themselves) - Disabled the reminder message for having a voice pack selected in options that's disabled, if the selected pack is VEM. We want users who disable the module instead of the menu to also be viable path to disabling VEM. Likewise, if users re-enable vem, for the most part it'll just start working again since we didn't tell them to go into GUI and change it to none.  
- Ignore DBM-VPVEM/README.md explicitically  
- Move the VEM directory even more, it's nested.  
- Move VEM into folder correctly.  
- Add VEM external dependency  
- Update localization.ru.lua (#49) Added and translated missing phrases.  
- Typo fix  
- Enable commented GroupSpells now that a NOOP exists, and add NewOptions flag if you're on the gui branch of unified  
- fix two invalid voice sounds  
- cleanup a comment  
- missed that  
- Chains of Domination update:  
     - Fixed two mods that had invalid spellIds for options/warning text and caused completely wrong spell to be shown  
     - Added user requested feature to Tarragrue to have cast bar for each of the 3 casts of Hungering Mists.  
     - Tweaked spellIds for a few other objects to match across objects for better bundling.  
     - Cleaned up some unused stuff  
- Update koKR (#48)  
- forgot to set defaults table.  
- create a controller wrapper vibrate function and throttle it to once per 2 seconds to prevent multiple calls to api happening within a fixed period of time, hopefully avoid api breaking and blizzard vibrating forever.  
- Maybe this will work  
- Code review:  
    Fixed two timer types on anduin not being correctly set off AI timers after they were completed  
    Changed march of the damned from special announce to regular one since it's every 7.5 seconds on anduin  
    Fixed inconsistent short name text for tears on xymox so they are all "wormhole" and not half "wormhole" and half "tear"  
- Adjust two LFR timers on sylvanas, Closes #718  
- Fix guardian for mythic and normal, at least to best of ability, it was bugged on mythic and never cast one of his abilities  
- hal timer tweaks  
- Fix glyph of relocation timer  
- Updated anduin to support normal mode timers  
    In addition, updated mythic and heroic timers through extrapolation  
- oops  
- actually this particular one should still be on for healers  
- niche infoframes are now off by default in sepulcher. Niche being ones that give information only a handful need to know (like raid managers) or if they present something that's already fairly obvious like boss energy.  
- Repair xymox so it now detects the undocumente stage 4 timer reset  
- bump classic alpha cycle  
- prep new classic release  
- luacheck for last  
- add search tags  
- Update jailer to reflect that intermission was deleted from fight  
- Update localization.ru.lua (#44)  
- Fix Luacheck  
- Update anduin and hal from mythic testing  
- Wicked Star changes  
     - Raid icon settingn for it removed.  
     - Target announce now aggregates each set  
     - Yells now assign star, circle, diamond to all people in each set for SAY messages  
     - Target timer is now off by default.  
- Create localization.tw.lua (#717)  
- Update zhTW (#47)  
- Update koKR (#46)  
- Update koKR (#716)  
- uniform some options text  
    cleaned unused  
- Add RL setting delay to anduin to match other mods and ensure it works better  
    Also removed print message from pantheon, no one really wants to see that every pull. it should work seemlessly not noisily  
- Ooh, forgot the getremaining call  
- fixed bugs with crushing timer on Hal and added extended icon support for crushing debuffs  
- Tweak icons used in say messages on mythic Hal to more cosely match the glyph symbols they represent  
- clarify help message  
- small tweak to march ai timer for. mythic testing on anduin  
- Update Halondrus for mythic testing using latest journal spells  
- Bar desaturating was turning bars white  
- More robust checks for timer tables to ensure phase isn't nil, to prevent mid fight lua errors during timer recovery, if a user reloads ui in middle of fight.  
- apparently fated conjunction timer has been spamming lua errors, sincce 9.1 launched, and no one reported it, until today. Turns out, another difficulty did use one of those ??? spellids and passed it off to table, which was expecting 350421 and only 350421, causing a lua error when it didn't match (and it doesn't, in LFR)  
- Account for fact that M+ can now be in form of under leveled timewalking content...that isn't flagged as timewalking content (because it's index 8). Should no longer treat legion timewalking M+ as trivial content.  
- prep next cycle  
