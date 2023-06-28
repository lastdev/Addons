# <DBM> World Bosses (Dragonflight)

## [10.1.13](https://github.com/DeadlyBossMods/DBM-Retail/tree/10.1.13) (2023-06-27)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/10.1.12...10.1.13) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- prep tags to fix LFR scalecomander on retail and fix lua errors in announce objects on wrath classic  
- Revert \"Send fake BigWigs messages to WeakAuras BW triggers (#238)\" This reverts commit c2b863f2fc1fb563026c268f271863e98aee88a3.  
- note  
- in super off chance someone ran any of alphas that set this to true dy default early on  
- Send fake BigWigs messages to WeakAuras BW triggers (#238)  
- Fix bad table copies in profile/skin management (#239)  
- Fix missed unrevert (#909)  
- only run the latest afflicted code so that's what's actually getting tested  
- fix the fix  
- fix bug where table wasn't cleared if removetime canceled a timer outright  
- Revert another breaking change (#237)  
- Store spell ID in legacy/localized NewAnnounce and NewSpecialWarning too (#236)  
- Fix nil errors  
- Fix https://github.com/DeadlyBossMods/DBM-Unified/issues/234 (#235)  
- bump wrath version  
- tweaks for DMF culling  
- Merge DMF mods into world events  
- fix comment  
- Update Sarkareth for LFR  
- wrath toc bumps  
- Revert breaking changes in vault (#908)  
- Keep non breaking changes  
- Revert "Change about half the option key spellids for all bosses in Aberrus to improve WA compatability with weak auras. This unfortunately this will have side effect of resetting half of everyones timer/alert/icon/etc options so you'll need to check if all those things you disabled (or enabled) are still that way. This is something could have been avoided with better conventions between boss mods and hopefully that can happen, but even if it doesn't it's something I'll account for in compat checks going forward."  
- Send journal option keys in same format as BW, to once again work towards compatible unified weak aura callbacks  
- Add nameplate aura CDs support to kurog for adds  
    Changed a few option keys for better unified WA compat  
- Change about half the option key spellids for all bosses in Aberrus to improve WA compatability with weak auras. This unfortunately this will have side effect of resetting half of everyones timer/alert/icon/etc options so you'll need to check if all those things you disabled (or enabled) are still that way. This is something could have been avoided with better conventions between boss mods and hopefully that can happen, but even if it doesn't it's something I'll account for in compat checks going forward.  
- Store spellid in the Legacy/localized NewTimer object so it gets passed to callback handler/WAs when it's available  
- Fixed a bug where the notes count feature didn't work with newer count objects Added count to announce and timer callbacks to massively improve weak aura support by allowing it to be possible to parse out the count of an alert without scanning message text. Now you'll be able to go \"spellid = n and count = n\" in a future weak aura addon update.  
- No code changes...just fixes a triggering comment 😂  
- Update localization.ru.lua (#232)  
- Some tweaks to staging for better weak aura compatability  
- mod prio editing  
- last update to banned lis (until 11.0), because ALL old content is now fully culled/merged  
- update core for bfa culling  
- Shadowlands culling prep  
- Improve Getstage api to allow requester to verify encounter Id of return,  
- Merge branch 'master' of https://github.com/DeadlyBossMods/DBM-Retail  
- strip out experiment since that's not the way  
- Fix SoO stats names after merge.  
- Update banned mods for MoP culling  
- some prep work  
- another tweak for WA string matching.  
- Change object to match string expectation  
- Change string matching for volcanic heart to use "bombs" so weak auras scanning message text is cross compatible with BW  
- Once and for all just hard code both versions of timers that can happen for stage 3 darkness on echo of neltharian. Now it'll show timer for the cast that is skipped 95% of time, but if it doesn't happen (and most of the time it won't), it'll auto schedule timer for 2nd cast.  
    Also fixed some LFR timers on echo  
- Core: fix wrong math on enrage timer prototype (#228)  
- Prevent timer updates from double-starting timers (#230)  
- slight timer tweaks  
- Fix some missed SKID -> FDID changes (#229)  
- bump alphas  
