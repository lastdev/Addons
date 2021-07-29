# Deadly Boss Mods Core

## [9.1.7](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/9.1.7) (2021-07-25)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/9.1.6...9.1.7) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Prep tag  
- Hard reset on GameTooltip points, to fix any potential "3rd parties" causing issues. (#629)  
- Added bridge cast bars  
- Apply short text to leap on Echelon to help truncate warnings/timers quite a bit  
    Disable bane taunt warning, it's misleading and doesn't fit all strats/situations. this is one of those things you don't automate.  
- Change how target count and cd count bars display so that they display the count next to spellname. reduces chance of the count being truncated and makes it more prominant in timers. It also makes it more uniform with warnings which already do count next to spell name. Don't worry this was done in a way that the arg order doesn't have to change nor does it break non updated locales. If you do localize though take note on syntax for flipping arg order in translated text from targetcount example.  
- Forgot to subtrack the 2.5 when adjusting to a new trigger. now it looks good  
- Actually show portal cast announce and time for more clarity of P2 end  
- Found an arrow spellid that has translations in database, applying it to shorten some warning/timer text  
    Reassigned some timer colors as well to differenciate some timers in p3 better  
- Move p2 start timers since the intermission fix only fixes when windrunner delays things, not when other spells delay things (several do)  
- Fix count not showing in non special warning merciless  
- Fix more dumb. Add notes so my peanut brain can stop breaking heroic  
- Update localization.cn.lua (#627)  
- Sigh  
- Fix me being stupid, actually that can't be fixed, but I can fix this  
- Some sylvanas adjustments/fixes  
- Port better world boss sync code from TBC, since apparently it's possible to now get bad syncs on retail. This is a more robust solution that has worked on TBC by explicitely specifiying which mods can send world boss syncs.  
- actually bump alpha revision this time  
