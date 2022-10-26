# Raider.IO Mythic Plus, Raiding, and Recruitment

## [v202210252244](https://github.com/RaiderIO/raiderio-addon/tree/v202210252244) (2022-10-25)
[Full Changelog](https://github.com/RaiderIO/raiderio-addon/compare/v202210250600...v202210252244) [Previous Releases](https://github.com/RaiderIO/raiderio-addon/releases)

- [Raider.IO] Database Refresh  
- Merge pull request #223 from RaiderIO/feature/dragonflight-prepatch  
    Added support for Dragonflight  
- Added DF tooltip hook changes.  
- Adjusted the LFD frame magnifying glass icon and border feel to adapt for the DF texture changes.  
- Revert the DB changes we don't need to track those and clutter the pull request later.  
- The scrollbox OnUpdate event will occur after frames are populated. We use it to detect changes.  
- Removed the debug ordinal overrides.  
- Replaced old scroll button hook method with the new scroll box util system. Added backwards compatibility for 9.2.7 and the 10.0 pre-patch.  
- Recamping the scrollbox hooks to support 10.0 behavior.  
- - Request keystone data at player login.  
    - Once data is retrieved, attempt to override the player profile.  
- DF pre-patch based on dev branch  
