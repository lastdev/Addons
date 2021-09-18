# Deadly Boss Mods Core

## [9.1.13](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/9.1.13) (2021-09-14)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/9.1.12...9.1.13) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep tag  
- Fixed a bug where updateEnemyPower had a specific check in wrong place  
- Update zhTW (#664)  
- Update koKR (#663)  
- Fix missed line and add vibrate to special warning test buttons as well.  
- Fix vibration api so it works, also revert flash duration local change since vibration duration is fixed and can't actually be changed.  
- Fix incorrect autoplace flag, to prevent wasted cycles placing the option twice  
- Fixed typo and updated luacheck  
- Added controller support to special announce configuration and global disable configurations for patch 9.1.5. These options won't do anything on 9.1 or if not using a controller  
- Update koKR (#661)  
- Update zhTW (#660)  
- stray copy/paste  
- aggregate consumption and acid Expulsion alerts to a shared throttle and reduce number of similtanious dodge warnings on tradova. if you were told to watch step from things on ground within last 3 seconds, you don't need to be told again.  
- Adjust sin quake timing a little to not be as big of a pre warning., also gave it a throttle  
- Download infestor to a target warning, reducing special warning spam on Tredova slightly. Shouldn't get two special warnings for same mechanic if it just happens to be on you.  
- Add additional 2 sec aggregation to interrupt warnings to Tirna Scithe trash mod, to reduce chance of overlapping interrupt spam  
- Few timer tweaks/fixes, especially to LFR frost blast on stage 3 KelThuzad which seems to have been buffed since week one LFR  
- Update localization.cn.lua (#659)  
- Update zhTW (#658)  
- Update koKR (#657)  
- remove some stray bad copy/paste  
- Made it possible to select whether icon marking for bombs on guardian uses default dbm method of prioritizing melee over ranged, or default bigwigs method that just uses combat log order. Per usual, raid leaders option overrides rest of raid, unless RL isn't running DBM, then local user preference is used.  
- Forgot about that debug I added  
- Mob auto marking prototype bugfixes and improvements:  
     - Fixed a bug where if already marked filter was used, it did reverse of what it was supposed to do  
     - Swtiched logic of friendly target auto marking filtering to be more clear and concise as well as use a more trustworthy api that also just happens to have performance benefits since it's one already upvalued by core for other reasons  
     - Fixed a bug where the already marked fllter and icon elect overrides would fail too pass on beyond first scan cycle, causing these options to be near useless (I mean, marked filter was already useless but it was double useless, yay!).  
     - Improved debug to be more verbose for identifying areas auto marking fails as well as ensuring that when it fails, it logged by transcriptor even if user doesn't set debuglevel to 3  
- bump alpha  
