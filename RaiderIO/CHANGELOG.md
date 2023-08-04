# Raider.IO Mythic Plus, Raiding, and Recruitment

## [v202308010600](https://github.com/RaiderIO/raiderio-addon/tree/v202308010600) (2023-08-01)
[Full Changelog](https://github.com/RaiderIO/raiderio-addon/compare/v202307310600...v202308010600) [Previous Releases](https://github.com/RaiderIO/raiderio-addon/releases)

- [Raider.IO] Database Refresh  
- Merge pull request #246 from RaiderIO/feature/keystone-traces-v2  
    Mythic+ Replay System  
- Merge branch 'develop' into feature/keystone-traces-v2  
- Added `lockReplay` and `replayPoint` properties to the config table.  
    The replay frame can be locked and unlocked through the cogwheel in the corner.  
    When locked it will attach itself to the objective frame and act as clickthrough to not interfere with gameplay.  
    When locked it will become draggable and can be placed anywhere on screen and this position will be remembered.  
    Clamped the replay timer to the total timer so we don't go over the actual replay total time, this way the timer text is properly colored red when we didn't beat the replay timer.  
- Removed unused argument from `SetUITrash` and `SetUIDeaths` functions.  
    Ensured we store `replayCompletedTimer` the same way we do the other ms to seconds conversion timers by using `ConvertMillisecondsToSeconds`.  
    Updated SetUITimer so that it considers `replayCompletedTimer` if it exists when doing the coloring of the timer text so it doesn't get confused with the replay end time from the replay data.  
- I swear this is the last logic change for dungeon time mode calculations, finally this should match the desired behavior.  
- Should finally have fixed the dungeon time mode issue where the colors were wrong, by properly substracting the live boss kill timer from the replay timer to get the differential, if negative it is used to color the text red, otherwise green.  
    Replay debug will update the UI a couple of additional times to ensure it is properly updated. It's a bit janky since we are kind of overriding the actual data with fake data, but it works for testing purposes.  
- Moved the AutoScalingFontStringMixin code into its own `SetupAutoScalingFontStringMixin` that both sets up the mixin on the desired (one or many) FontString widgets, but also sets the default value on the `minLineHeight` property so that it scales down really large text as well to fit in the frame (as a side effect, but it is a desired one).  
- Added `AutoScalingFontStringMixin` to the replay FontString objects to ensure the text doesn't truncate in the replay UI.  
    Added panic hook so that Escape also stops frame dragging. This works for the profile tooltip anchor frame, replay frame, search frame, RWF frame, and config frame.  
- Merge branch 'feature/keystone-traces-v2' of https://github.com/RaiderIO/raiderio-addon into feature/keystone-traces-v2  
- `SecondsToTimeTextCompared` should properly compare both delta to see which one is ahead or not.  
    Calculating the `comparisonDelta` will properly avoid pre-calculations, as this caused the coloring step to fail and always show red text. Now, it will compare both this and the `delta` and color the text accordingly.  
    Removed all `debugMode` specific code, and instead added two simple `StartDebug` and `StopDebug` methods on the frame that can be used with debug enabled, to fake play and complete a run, just to see how the UI works. It's not 1:1 to reality and it's a bit janky due to the fact it doesn't have live API data to feed it, but it's a good enough approximation for testing some stuff.  
- Merge branch develop into feature/keystone-traces-v2  
- updated replay description  
- Added optional timer argument for the boss frame update, so when we want to force it to show the completed state using that timer for the boss calculations.  
- Swapped comparison delta for DUNGEON timer mode so that the color should now be correct.  
    Added helper method `UpdateAsCompleted` for when a keystone is completed, to help force-update the replay side with the correct "end of run" data.  
- If we leave and re-enter a new dungeon the staging will keep the old live data, so we do this to ensure it's cleared and doesn't interfere and look strange.  
- Added replay option to set timing method for the splits.  
    Default timing is BOSS combat duration comparisons, the other one is based on the defeat timer relative to dungeon time.  
    Fixed issue where route swap and combat indicator overlapped, the priority is to show combat indicator first, then route swap icon so they don't overlap.  
    Changed a lot on how the sorting of the UI works and how the encounter detection works, so it needs a bit more testing due to these changes.  
- Due to the changes to replay bosses containing a encounter table, we ensure to copy that as well for the public API.  
- Attempt to fix issue with race conditions where the old objective tracker data would pollute the new tracker.  
    Avoiding this by encapsulating the live boss replay table so that when `encounter` is being requested, it will fetch the up-to-date encounter table for the boss.  
    This ensures the UI properly updates with the valid boss information.  
    Tried to mitigate nil issues by fallback to index if order is not set. Usually both are equal, except if the route doesn't follow the boss order, then the order is used to sort, and it should be present unless something is wrong.  
    Added back more missing isDirty check situations.  
- Renamed styles to "Standard" and "Compact"  
    Added `order` property that we use to help with boss sorting.  
    Fixed an issue with encounter tracking, moved encounter data in a `encounter` property on the boss.  
    We still ensure to sort the live bosses based on the replay, but as soon there is a kill we move the live boss on top, and if it doesn't align with the replay we show the route swap icon.  
    Fixed bug with boss combat detecting for live bosses.  
- Moved the public API block to the bottom as it potentially relies on other modules, but no one should reply on this block.  
    Made MODERN default style for replays instead of the compact version.  
    Commented out "MDI" style so it doesn't appear among the choices for style. Might work on it and bring it back at a later date.  
    Updated the replay public API so that it creates and updates a separate set of tables containing the summary data, and added extra replay data like run url, clear time, dungeon id, enemy forces, short name and name, for extra information. Otherwise it is a table copy so that only external addons will potentially break if user starts editing the contents.  
- default replay style to MODERN and hide MDI style from replay list  
