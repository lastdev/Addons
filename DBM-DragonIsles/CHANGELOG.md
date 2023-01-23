# <DBM> World Bosses (Dragonflight)

## [10.0.21](https://github.com/DeadlyBossMods/DBM-Retail/tree/10.0.21) (2023-01-22)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/10.0.20...10.0.21) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- version bump with no update notification nag. this update is mainly for M+ pushers to get latest fixes now instead of waiting for tuesdays actually mandatory patch update version.  
- fix sennarth staging  
- run custom actions on retail repo  
- lower antispam on thundering just in case  
- Add ability to force internal handling of nameplate auras when using them on trash modules  
- Add sanguine nameplates Icons (on by default for tanks) to make it easier to see when mobs are gaining heal from sanguine for M+ Affixes. Note, because of nature of 3rd party addon callbacks requiring registering and unregistering events on boss engage, doing this ona trash module can't use 3rd party mods, this particular nameplate aura will use only internal handling.  
- attempt to fix cases the unscheduling for thundering yells fails, by resetting theh slate on any new thundering  
- Filter guild combat messages if you're in that group and inside instance. It should only show if outside (bench group) or not part of group.  
- bump alpha  
- Prep new wrath classic tag to give wrath players another round of Ulduar fixes  
- bump alpha  
- prep new wrath tag  
- Don't schedule reinforcement timer twice on pull, fixes double countedown bug on broodkeeper  
- Fix bad option default  
- bump alpha  
- Guess a new wrath release happening after all. Fix typo in toc and prep new tag Closes https://github.com/DeadlyBossMods/DBM-WoTLKC/issues/12  
- remove hacky object replacement solution and just use a fallback icon if there is no icon setter  
- Fix minor bug where alerts on kurog in options weren't flagged as mythic only alerts in GUI  
- Fix cosmetic warning about  duplicate spellid usage  
- bump alpha  
