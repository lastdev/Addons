# [4.0.3](https://github.com/WeakAuras/WeakAuras2/tree/4.0.3) (2022-08-18)

[Full Changelog](https://github.com/WeakAuras/WeakAuras2/compare/4.0.2...4.0.3)

## Highlights

 - Group Leader load option
- Specialization filter for BT2, Health, Power triggers
- Lots of updates and feature additions for Wrath Classic
- Your usual amount of bug fixes 

## Commits

InfusOnWoW (11):

- Make setting distribute spaced with 0 "work"
- Document workaround with a link to WoWUIBugs
- BT2: Fix stale/wrong information in multi-tracking states
- PositionOptions: Hide AnchorPoint if a aura is in a dynamic group
- Provide Specialization filter for BT2, Health, Power triggers
- Fix typo
- Fix "Since apply/refresh" checks for Show on always auras
- Fix warnings for protected frames
- Fix invalid rects that cause Glows not being applied properly
- Add a debug log functionality for custom coded auras
- Add a "Group Leader" load option

Jason Herbert (1):

- Add rune type triggers for wrath

Stanzilla (4):

- TOC Bump for Patch 9.2.7
- Fix Wrath toc
- CI: Add Wrath package
- Add Wrath versions to TOC

asakawa (1):

- Add a framework for custom triggers to watch other triggers

emptyrivers (3):

- new feature string
- teach group options how to not Merge
- do more nil checks

hexaheart (1):

- Fix an error on SetTextureOrAtlas behavior

mrbuds (32):

- move encounter & zoneId list stuff from Prototypes.lua to a per extension Types_<version>.lua
- Wrath: Listen to event PLAYER_TALENT_UPDATE for talent & spell known load conditions & triggers, fixes #3729
- Switch to single build mode (#3722)
- Fix spell cooldown trigger: ignore rune cooldown, on wrath
- Death Knight wrath template update
- Update bug_report.yml
- Fix set parent to anchor when frame is an empty string
- Custom Option deleting entry of an array prompt a confirmation dialog
- Add "Cooldown > Hide Timer Text" condition on Icon region
- add "Set Parent to Anchor" option to dynamic group's grouped by frame
- use bcc's modelpath on wrath
- wrath templates (WIP)
- Fix (temporary?) for WeakAuras.IsCorrectVersion and wrongTargetMessage for wrath
- Reorganise version checks
- Restore vehicle load condition for wrath
- Make "Spell Known" load condition work with pet abilities
- Fix number formaters with custom code
- disable swing timer trigger for wrath
- Assigned Role load condition & trigger filter for wrath
- prepare wrath templates
- update encounter ids for wrath
- support 10 & 25 players heroic raids for instance_type load condition
- Fix version check for Wrath
- Faction Reputation trigger: handle paragons and improve friendship
- Fix aura trigger UI positioning for BCC & Classic
- Remove old newFeatureStrings from 2020-2021
- Position setting: use 9slice widget and moved some options
- Aura trigger: fix role option
- Threat Situation trigger: add unitexist check
- swing timer: reset ranged & melee swings on Feign Death
- TBC: fix "Instance Type", "Raid Role", "Group Leader" load conditions
- fix health trigger on classic era

