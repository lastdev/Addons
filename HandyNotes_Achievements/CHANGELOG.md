# Changelog

## [Unreleased]

## [v0.6.1]

### Changed
- updated LibQTip

## [v0.6.0]

### Added
- added Pest Control critters
- Sort by tracked achievements: when enabled, tracked achievements appear at top of tooltip

### Fixed
- found Westfall Field Photographer
- added some Tricks and Treats in Twilight Highlands

### Changed
- updated to AchievementLocations v0.6.0

## [v0.5.0]

### Added
- German localization [[@lulukmr](https://github.com/lulukmr)]

### Changed
- updated Ace3, LibStub, and LibQTip [[@JanGalek](https://github.com/JanGalek)]

## [v0.4.23]

### Added
- Russian localization [[@Makemeloco](https://github.com/Makemeloco)]

### Fixed
- updated for 8.1.0: fixed GetCurrentCalendarTime [[@JanGalek](https://github.com/JanGalek)]
- updated for 8.2.5: fixed IsQuestFlagCompleted [[@JanGalek](https://github.com/JanGalek)]

## [v0.4.22]

### Changed
- moved some bloody rares [[@ldeveber](https://github.com/ldeveber)]

## [v0.4.21]

### Removed
- MapMap/MapExcursion dead code [[@journeym](https://github.com/journeym)]

## [v0.4.20]

### Added
- Hellfire Citadel, Blackrock Foundry, Highmaul, Siege of Orgrimmar, Firelands, Spires of Arak, Scholomance
- Grizzly Hills PvP
- dungeon elders
- Old Ironjaw
- Invincible's Reigns
- Leeeeeeeeeeeeeroy!

### Changed
- updated to 8.0 Battle for Azeroth Calendar API [[@axnd3r](https://github.com/axnd3r), [@chelpixie](https://github.com/chelpixie), [@noadtome](https://github.com/noadtome)]
- nudged Field Photographer in Deadmines
- nudged Children's Week in Shattrath

### Fixed
- holiday calendar scanning range

## [v0.4.19]

### Added
- Children's Week tweaks
- Tranditional Chinese (zhTW) localization [gaspy10].  More translation help wanted.

## [v0.4.18]

### Fixed
- bugfix for adding mapFile column to rows [Bagmer] (or "why you don't work on new features in the same directory as you use for making unrelated updates".)

## [v0.4.17-1]

### Changed
- deduplicate imported libraries [DarkWanderer33]

## [v0.4.17]

### Changed
- trick WowAce to rebuild

## [v0.4.16]

### Changed
- trick WowAce to rebuild

## [v0.4.15]

### Added
- added other locales [pas06]
- added Medium Rare and Bloody Rare locations

### Changed
- renamed Winter Veil

### Fixed
- fixed bug for calendar limits

## [v0.4.14]

### Added
- added enUS locale

## [v0.4.13]

### Added
- added seasonal awareness
- added Brewfest (and its out-of-seasonal vendor)
- added MoP locations
- added Cataclysm, MoP, and Draenor exploration locations [check Vashjir]
- added capitol cooking & fishing locations
- added some Hallow's End, Midsummer locations

## [v0.4.12]

### Added
- added Stonecore

### Changed
- config panel setting persistence

## [v0.4.11]

### Added
- added config panel
- added Children's Week
- added Grim Batol

### Changed
- default to clean zones

## [v0.4.10]

### Added
- added reputations, some with locations
- match criterion column with criteriaDescription
- added Mogushan Palace, Stormstout Brewery
- added non-exalted reputations in tooltip
- added pet
- added reputation
- added old dungeons
- moved firelands portal
- added Ahn'kahet, Temple of Ahn'Qiraj, Azjol-Nerub, Blackfathom Deeps,
  Blackrock Depths, Blackrock Spire, Black Temple, blackwing Descent,
  Blackwing Lair, The Culling of Stratholme, Dire Maul, Dragon Soul,
  Drak'Tharon Keep, Firelands, Grim Batol, Gruul's Lair, Gundrak,
  Halls of Origination, Karazhan, Lost City of Tol'vir, Magtheridon's Lair,
  Maraudon, Molten Core, The Oculus, Razorfen Downs, Ruins of Ahn'QIraj,
  Scarlet Monastery, Shadowfang Keep, The Vortex Pinnacle, Sunwell Plateau,
  The Bastion of Twilight, The Eye of Eternity, The Nexus, The Obsidian Sanctum,
  The Stonecore, Sunken Temple, Throne of the Four Winds, Uldaman, Utgarde Keep,
  Utgarde Pinnacle, Vault of Archavon, Wailing Caverns, and Zul'Farrak. whew.
- added Naxxramas and Ulduar
- optionally disregard completion by alts
- added floor enforcement
- added click hack (reasonable suggestions welcome)
- scraping quest ids
- added ICC and this strange obsession with squirrels
- show completed effect
- proper event handlers have frame arg
- retain (not recompute) nodes

### Changed
- omit "other" faction
- shrink icon to reasonable size
- show incomplete criterialess
- coord centric design; relocate constants to library namespace
- criterion is now non-positional row property

### Fixed
- bugfix for empty tooltips

## [v0.4]

### Changed
- made a HandyNotes module, based on https://github.com/idiomatic/Achiever

## [v0.3]

### Removed
- we shall never speak of this version again

## [v0.2]

### Changed
- rewrote using coroutines and denormalized locations rows

## [v0.1]

### Changed
- prototype, directly using HereBeDragons
