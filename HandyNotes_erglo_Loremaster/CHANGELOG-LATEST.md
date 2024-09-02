## [0.9.0-beta+110002] - 2024-08-28

### Added

* The War Within: added `Loremaster of Khaz Algar` data.
* Quest Type Tags: added optional transparency for trivial quest types.
* Quest Type Tags: added support for Covenant Calling quests.
* Quest Type Tags: added `custom optional tags` for storyline and account-wide completed quests.

### Changed

* Data: updated World Map pin hovering update behavior.
* Quest Type Tags: combined trivial quest tag with primary quest type tag, unless there is no primary type.
* Quest Type Tags: combined timed recurring quest types with daily and weekly tags, since the duration is already shown.
* Quest Type Tags: updated the internal `quest type tagging system`.
* Tooltip: updated colors for active quest title and tag line text to match the default tooltip.
* Tooltip: added `timer to quest offer tooltips` for auto-updating the tooltip content.
* Tooltip: the tooltip no longer changes the game's tooltip by hooking into it, instead it appears below the quest icon tooltip.
* Tooltip: completely rebuild the `tooltip hooking and anchoring system`.
* Updated TOC file version to `WoW 11.0.2`.

### Removed

* Settings: this options has been removed. The storyline tooltip can no longer be selected as shown separately since it is now already separated from the game's default tooltip.

### Fixed

* Notifications: sometimes campaign chapter IDs and storyline IDs are not identical which led to not counting saved active lore quests correctly or not being recognized at all.
* Tooltip: sometimes campaign chapter IDs and storyline IDs are not identical which led to not indicating to the current campaign chapter correctly.
* Tooltip: fixed UI scaling of the questline tooltip.

