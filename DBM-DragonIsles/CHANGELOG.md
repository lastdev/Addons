# <DBM> World Bosses (Dragonflight)

## [10.0.19](https://github.com/DeadlyBossMods/DBM-Retail/tree/10.0.19) (2023-01-10)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/10.0.16...10.0.19) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- prep for 4th dbm release today for retail for more bug fix pushes  
- Fix heroic meteor axes timer, Closes #850  
- Fix more thundering bugs  
- Bump alpha  
- prep new retail tag to fix regression  
- remove some left over debug code  
- Fix regression with the yell code on thundering  
- bump alphas  
- prep new tags  
- Update localization.ru.lua (#173)  
- Update localization.cn.lua (#849)  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- luacheck  
- uncomment these timers for now.  
- Enable countdown by default for thundering timers, reset option so defaults reset. (Sorry for those who might have customized color or countdown voice previously as this will do a one time reset on it)  
    Code cleanup and fix on thundering expiring  
- Make the countdown on thundering red numbers not white, following conventions taht these are group up spells, not spread spells  
- Add common local  
- tweak chat yells again for thundering to say "Clear" when removed  
- Fix errors  
- Further improved thundering code to cancel yells if 4/5 are dispelled and alert remaining player it's over  
- Rework thundering yells to give countedown with icon, from 5 seconds down  
- Add redundant disabled checked, because users aren't seeing the first one.  
- Fix event for sundering crash on Basrikron  
- Fix rain of destruction event for Bazual  
- Add basic Strunraan mod finally  
- Fix deep freeze event, which is not in combat log  
- tweak chilling blast to say spread instead of run out. need to be more consistent about this distinction. run out should be used for like "get this way the hell out of raid" versus spread which is just "you can stay in but spread out"  
- Bump alpha  
