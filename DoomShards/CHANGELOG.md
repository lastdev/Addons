## [v24] - 2017-02-01
### Changed
- Changed Demonology's reference spell for low remaining time to Hand of Gul'dan (was Shadow Bolt)

### Fixed
- Tick prediction for Chronomatic Anomaly should now work properly

## [v23] - 2017-01-13
### Fixed
- Implemented 17 s Doom fallback duration when using Impending Doom (recent 7.1.5 hotfix)

## [v22] - 2017-01-11
### Fixed
- Changed Shadowburn shard generation on kill to 1 (7.1.5 changes)
- Set Seed of Corruption cost to 1 Soul Shard (7.1.5 changes)
- Set Hood of Eternal Agony's tick rate modifier to 10% (7.1.5 changes)

## [v21] - 2016-10-25
### Fixed
- Incorporate 7.1's mechanical change to Unstable Affliction

## [v19] - 2016-10-15
### Fixed
- Fixed bug where shard animation could get stuck on 100% alpha
- Fixed error when logging in/reloading while in combat

## [v18] - 2016-09-01
### Changed
- Replaced "Always Show Borders" option with option to show background for depleted Soul Shards along with option to change this background's color; set color alpha to 0 for the old behavior

## [v17] - 2016-08-24
### Added
- Added WeakAuras example
- Added Unstable Affliction tracking
- Added support for Hood of Eternal Disdain

### Fixed
- Fix when tick misses due to e.g. immunity
- Fixed a bug where refreshing Doom with a partial tick remaining overwrote this tick
- Fixed wrong Shard chance calculation for additional Doom ticks
- Fixed bug where Agony resource chance wasn't properly calculated

## [v16] - 2016-08-13
### Fixed
- All Soul Shards indicators now properly hide when disabled while being shown
- Shadowburn indicator no longer gets removed when refreshed too often (#2)

## [v15] - 2016-08-11
### Fixed
- Fixed a bug occuring when multidotting with Agony (#1)

## [v14] - 2016-08-10
### Added
- Added option to enable/disable Soul Shards bars
- Added WeakAuras interface once again
- Added profile export and import

### Changed
- Changed some of the options GUI layout
- Changed text indicator for low remaining time to use filler spell according to spec

### Removed
- Removed scale option

### Fixed
- Fixed animation on shard gain not showing most of the time
- Fixed partial Doom ticks showing when "Consolidate ticks" is selected
- Fixed notification showing twice after ending test mode
