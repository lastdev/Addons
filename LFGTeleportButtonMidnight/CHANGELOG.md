# Changelog

All notable changes to this project will be documented in this file.

## [1.0.7] - 2026-01-13

- **New Feature:** Added "Host/Active Group Check". The button will now automatically appear if your group is listed in LFG for a supported dungeon (checks every 5 seconds), ensuring the host sees the button even without an invite notification.
- **Refactor:** Overhauled internal event handling system using a dispatch table pattern for better reliability and code maintenance.
- **Fix:** Fixed a bug where dungeon detection via Activity ID was failing due to a missing internal lookup table.
- **Improvement:** Optimized dungeon matching logic to remove redundant code.

## [1.0.6] - 2025-12-13

- Updated Interface version to `120001` for Midnight Beta 12.0.1 (build 64889).

## [1.0.5] - 2025-12-06

- Button auto-hides during combat and reappears after.
- Fixed "secret value" errors when checking spell cooldowns in combat.

## [1.0.4] - 2025-12-06

- Added M+ UI overlay buttons on dungeon icons in Challenges frame.
- Click dungeon icons to teleport directly from M+ UI.

## [1.0.3] - 2025-12-05

- Fixed bug where second invite overwrote first pending invite.
- Now supports multiple pending invites at once.
- Spell icon IDs now fetched from API.
- Cached Lua functions for performance.
- Removed unused code.
- Code cleanup.

## [1.0.2] - 2025-12-04

- Added a fallback check when `C_Spell.IsSpellKnownOrOverridesKnown` is missing on beta clients.

## [1.0.1] - 2025-11-28

- Refactored code to remove legacy API calls and simplified comments for better maintainability.

## [1.0.0] - 2025-11-24

### Added

- **Midnight Season 1 Support**: Added support for all 8 Season 1 dungeons:
  - Magisters' Terrace
  - Maisara Caverns
  - Nexus-Point Xenas
  - Windrunner Spire
  - Al'gethar Academy
  - Pit of Saron
  - Seat of the Triumvirate
  - Skyreach
- **New Spell IDs**: Updated with Challenge Mode Teleport spell IDs for 12.0.
- **New Icons**: Updated with specific dungeon icons.
- **Activity IDs**: Added Mythic Keystone Activity IDs for auto-detection.

### Changed

- **Target Version**: Updated Interface to `120000` (Midnight).
- **Addon Name**: Renamed to `LFGTeleportButtonMidnight`.
- **API**: Built on the modernized API foundation from `LFGTeleportButton` v1.2.0.
