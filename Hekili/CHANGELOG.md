# Hekili

## [v10.0.2-2.0.16a](https://github.com/Hekili/hekili/tree/v10.0.2-2.0.16a) (2023-01-23)
[Full Changelog](https://github.com/Hekili/hekili/compare/v10.0.2-2.0.16...v10.0.2-2.0.16a) [Previous Releases](https://github.com/Hekili/hekili/releases)

- Devastation priority optimization.  
- Don't break recommendations early for empowered spells (#2286)  
- Merge branch 'dragonflight' of https://github.com/Hekili/hekili into dragonflight  
- Don't resummon Sayaad with Grimoire of Sacrifice up (#2315)  
- Merge pull request #2298 from yurikenus/dragonflight  
- Don't expire targets during an empowered channel.  
- Retribution: Use finishers when Seraphim and Final Reckoning are desynced, maybe.  
- Merge branch 'dragonflight' of https://github.com/yurikenus/hekili into dragonflight  
- Intimidating Shout ID changes based on Menace talent; move to Interrupts toggle.  
- Updated EvokerPreservation.lua  
    - File metadata: Updated Date at top of file  
    - Emerald Blossom: Updated ability cooldown which was erroneously 30s instead of 0s.  
    - Essence Burst: Readded aura for Essence Burst (Preservation's talent buff for this is a different spell ID than Devastation).  
    - Disintegrate: Commented out the Disintegrate section under RegisterResource(Enum.PowerType.Mana), which had been copied from Devastation originally, as it causes issues in-game (Bugsack triggers issues related to referencing Mana here and in State.lua). Instead added a small power gain under the Devastate ability itself (with Energy Loop talented), matching implementation in other class lua files. Very open to better ways to model this, as the mana gain seems to be per-tick rather than all-at-once at start of cast, but I thought matching the implementation seen elsewhere would be a good fix for now.  
    - Temporal Compression: added stacks of this buff under all bronze spells (when talented) for better APL prediction.  
    - Tier Set 4pc: added Lifespark buff and Living Flame stack removal.  
    - Removed extra Handler function in Cauterizing Flame  
    - Added charge to Reversion based on Punctuality talent  
    - Added Dream Breath HoT and duration based on empower level.  
    - Added aura IDs for the Echo versions of Reversion and Dream Breath HoTs.  
- Revert manic\_grieftouch cooldown adjustment.  
