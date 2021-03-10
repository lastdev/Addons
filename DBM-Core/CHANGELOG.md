# Deadly Boss Mods Core

## [9.0.22](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/9.0.22) (2021-03-09)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/9.0.21...9.0.22) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Fixed a bug where AddMsg would fail to read chatframe setting when AddMsg is called by a mod and not core. Self would inherit the wrong parent.  
    bump version  
- TOC Bump  
- Disabled Xira's ability, per hottfixes  
- no changes, just removed obsolete comment  
- Added user request, dreadbindings in sanguine depths  
- restore backup method for volatile ejection, CLEU not consistent  
- went over cap, revert this  
- Fix typo  
- Fixes to last to actually do what was intended  
- Allow CreatePizzaTimer object to be called with "whisper" arg by external modders using function to unicast timers. Also allows DBM to accept pizza timers sent this way via whisper sync handler.  
- Update koKR (#518)  
- Missed some schedules  
- Save cpu on hungering destroyer by using new hotfixed events and no longer rely on cpu heavier spell\_damage and scheduling  
    Also moved volatile to combat log events so it no longer relies on victims running boss mods for them to get marked  
- Fix Lua exception (#517)  
    Bad table entry, reported by user :)  
- Clear paused status on a bar when :Start or :Stop is called on a timer object. Start should always clear previous status of timer.  
- Add new test condition  
- Update README.md  
- Update README.md  
- Forgot these  
- tiny bit of post tier cleanup  
- Fix  
- updated timer recovery to send paused bar status. This will fix a bug where a user reloading bars they think are "stuck" won't ACTUALLY break them for real when recovery gets them back.  
    Changed sync handler for it to avoid out of date syncs also messing it up that don't have paused status.  
- tweak last  
- Maybe this will fix bar errors. bar frame names will now generate unique integer EVERY SINGLE COMMIT. Shouldn't break DBMs bar handling but should make it an utter NIGHTMARE for anyone trying to modify them. Hate having to ruin 3rd party skinning like this, but if it's breaking DBM it has to come to a stop.  
- bump alpha  
