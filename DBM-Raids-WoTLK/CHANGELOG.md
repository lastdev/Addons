# <DBM Mod> Raids (WoTLK)

## [r319](https://github.com/DeadlyBossMods/DBM-WotLK/tree/r319) (2023-09-05)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-WotLK/compare/r318...r319) [Previous Releases](https://github.com/DeadlyBossMods/DBM-WotLK/releases)

- Toc Bumps for retail  
- Forgot to push this. Koralon bugfixes  
- fixed a bug where the blistering timer started where it shouldn't.  
- one of those changes were not intended  
- Made defile scan time out much slower if boss is still staring at tank. this will fix it announce tank for late target swaps, but also make it slower for warning the tank when it's actually on tank. it's not a great tradeoff but I feel announcing correct target is more important than speed. Very unideal situation  
- update (#45)  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- Shorten P2 timer for KT, across board in fact cause pretty sure it's just variable based on killing of final wave of adds fast enough.  
- Protect defile and trap target scans from failing if lich king casts another instant cast ability in same frame. Should hopefully solve remaining niche cases of detecting wrong target  
    Fixed a bug where target scan on iron council never worked in classic, because it was only scanning boss unit IDs and blizzard decided those shouldn't exist in ulduar because nochanges and they weren't added to ulduar until later.  
- Make shadowtrap scanner more robust by using filter tech to filter out plague target except only as a fallback. Should solve any inaccuracies for starting scanning sooner than other mods.  
- Make shadowtrap scanner more robust by using filter tech to filter out plague target except only as a fallback. Should solve any inaccuracies for starting scanning sooner than other mods.  
- Update koKR (WotLK) (#43)  
- Fixed 3 gtfos not using spell name to describe the spell  
- add missing french file, fixes https://github.com/DeadlyBossMods/DBM-WotLK/issues/42  
- remove deprecated code from thaddius  
- Disable icon restore code as it causes pcold icons to bug out if applied/removed occur close enough together.  
    Also don't remove icons at all by SPELL AURA REMOVED, and remove on combat end instead, matching BW behavior.  
- Revert "try a new way of doing pcold icons, and while at it, since a delay had to be added, re-add support for prioritizing those icons by raid roster index"  
- Revert "try a new way of doing pcold icons, and while at it, since a delay had to be added, re-add support for prioritizing those icons by raid roster index"  
- Revert "try a new way of doing pcold icons, and while at it, since a delay had to be added, re-add support for prioritizing those icons by raid roster index"  
- try a new way of doing pcold icons, and while at it, since a delay had to be added, re-add support for prioritizing those icons by raid roster index  
- try a new way of doing pcold icons, and while at it, since a delay had to be added, re-add support for prioritizing those icons by raid roster index  
- try a new way of doing pcold icons, and while at it, since a delay had to be added, re-add support for prioritizing those icons by raid roster index  
- Sync EOF fix.  
- Update localization.ru.lua (#41)  
- option text improvement  
- ICC Update again:  
     - Fixed some portal options not grouped with other portal options  
     - Blazing Skeleton and Gluttonous Abom timers now have weak aura keys  
- Tweak to grouping  
- More ICC work:  
     - Target switch alerts and timer now grouped up and weak aura keyed for Blood Prince Council  
     - Changed achievevment option to use achievement text instead of being grouped up with the mechanic involved, for clarity of option.  
     - Ooze spawn option now weak aura keyed on Rotface  
- Proper Fix sindragosa achievement check option grouping.  
- Another ICC prep update:  
     - Use cores new tech to assign custom weak aura keys to adds alerts and timers for deathwhisper and gunship battle, visible in GUI and everything.  
     - Sort trash mod to bottom like modern modules  
- Revert "fix achievement matching"  
- fix achievement matching  
- more fixes  
- Fix last, and rip nice commit message for classic repo  
- Sindragosa Update:  
     - Fixed a bug where announce icon on beacon didn't work if the raid leader wasn't elected as icon setter. Now raid leader can announce icon set even if someone else is actually setting the icons.  
     - Tweaked icon usage in stage 2 for magic debuff so it doesn't overwrite tomb icon and vica versa  
     - Added chat bubbles (with icons) for both applied and countdown for tomb targetting debuffs  
     - Changed clear icons on air phase to off by default  
    Festergut Update:  
     - Scrapped spore target announcing to chat option, since it's a bit over engineered for the mechanic  
- Update localization.cn.lua (#40)  
