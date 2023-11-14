# <DBM Mod> Raids (WoTLK)

## [r321](https://github.com/DeadlyBossMods/DBM-WotLK/tree/r321) (2023-11-07)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-WotLK/compare/r320...r321) [Previous Releases](https://github.com/DeadlyBossMods/DBM-WotLK/releases)

- Bump tocs  
- throttle shadow prison  
- throttle shadow. prison  
- also disavble green ooze soak warnings if you're gas variable on heroic.  
- also disavble green ooze soak warnings if you're gas variable on heroic.  
- fix option name  
- Tweak defaults on putricicde to reduce spam based on common strats, plague just gets dumped in melee and allowed to bounce around. Although DBM has a throttle for target warning, it's still annoying so now off by default  
    In addition, volatile ooze adhesive "help soak" alert is also off by default to reduce the screen flashing when green ooze is out. Target announce will still be present but the "help soak" and flash is gone by default now.  
- Remove support for shield health tracking in wrath classic, since API for getting amount doesn't exist there. To re-add it would require knowing all 4 OG values and that's not something I have off hand.  
- change blood prince council to use 13 instead of 12 since 12 isn't valid in classic but 13 is. according to https://www.wowhead.com/spell=72037/shock-vortex it should have been 13 all along anyways  
- Fix gui display issue with festergut  
- Change infest to healer only by default and add voice pack support that's more healer centric  
- fix a bug that caused defensive alert to warn all tanks and not just the correct tank on Faerlina  
- Forgot to push this, increase range of rangecheck on festergut from 8 to 10 to give a little buffer for the movement vile gas causes  
- sync  
- Fix kinetic bomb announce and timer in classic because it too fell victim of "nochanges" and intentional regression of api.  
    Added count to the objects while at it  
