# <DBM> World Bosses (Dragonflight)

## [10.0.35](https://github.com/DeadlyBossMods/DBM-Retail/tree/10.0.35) (2023-04-11)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/10.0.34...10.0.35) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- Prep new tags  
- Update Memorex for normal mode and fix small bug on heroic til i figure out what to do with maws cast inconsistency  
- fix error  
- Fix count not showing in teleport timer on razageth after first one  
- Fix corruption timer on last  
- Fix missing spelllId  
- Fixup neltharion off mythic, with working P3 stuff, but heroic stuff dicey since unknown what's changed since that buggy test  
- UnitPower, UnitPoweer, same thing.  
- Fix errors  
- Update Rashok for normal mode  
- Forgotten experiment updates, needs more review though cause it's a buggy fight.  
- Fix last with a kinda hacky behavior for accuracy for now until conditionals more known  
- Enable experimental entanglled affix timer  
- create new group combat object for cleaner affix features in M+  
- Mythic Rashok update  
- Add infoframe option for overcharged stacks on Rashok  
- Icons: fix icon target announce (#206) SetIconByTable and SetIconBySortedTable was bumping icon index before firing the returnFunc, causing all icon announces to be shifted by one index.  
- Push post testing Assault of Zaqali update  
- Fix typo  
- Amalgamation Mythic update  
- preliminary mythic tweaks to rahsok and chamber  
    Also removed all the class call things from neltharion  
- Revert Rashok back to detecting searing slam debuff since it's unhidden again.  
    Fuly updated The Forgotten Experiments, post heroic testing  
- Add gossip show debug to core  
- Update zhCN (#880)  
- Update koKR (#205)  
- Update localization.ru.lua (#203)  
- missed spellId  
- Push Zaqali drycode ahead of this weeks testing  
- Mythic testing update for Zskarn  
    Bugfix on Forgotten Experiments  
- Fix last, and add to luacheck.  
- Update rashok with new object in anticipation of detection nerfs  
- Missed an object  
- Add new alert type for incoming debuffs, basically a pre warning for incoming private aura debuffs since the actual warning for those won't be possible. This is basically a pre warning to look out.  
- switch these events back to debug for now  
- Drycode new season 2 affixes  
- removed 1 too many spelids  
- Push P1 and P2 of neltharion at least. P3 will come later when p2 isn't broken during testing.  
- Post testing Memorex update  
- Fix rushing shadows lua error and event ID  
- Tweak tank swaps ands fix a bug where KR locale was overriding english  
- Forgot a change  
- Added detection of molten spittle target debuffs to Magmorax  
- Fix forgotten experiments for mythic, mutilate doesn't expire there so icon strat doesn't quite work for yells/etc  
- bump alpha  
