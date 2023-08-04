# Details! Damage Meter

## [Details.20230731.11774.155](https://github.com/Tercioo/Details-Damage-Meter/tree/Details.20230731.11774.155) (2023-07-31)
[Full Changelog](https://github.com/Tercioo/Details-Damage-Meter/compare/Details.20230730.11773.155...Details.20230731.11774.155) 

- Version Bump  
- Merge pull request #575 from Flamanis/Combine-non-combat-starting-spell-lists  
    Use single table for spell lookup when avoiding starting combat  
- Merge pull request #581 from Flamanis/Flamanis-patch-1  
    Add nil check for Time Type in startup  
- Add nil check for Time Type in startup  
- Use single table for spell lookup when avoiding starting combat  
    This is to avoid triggers like SPELL\_PERIODIC\_MISSED triggering a combat when an absorb happens.  
