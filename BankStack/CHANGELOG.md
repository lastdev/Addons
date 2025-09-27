# BankStack

## [v2025.6](https://github.com/kemayo/wow-bankstack/tree/v2025.6) (2025-08-09)
[Full Changelog](https://github.com/kemayo/wow-bankstack/compare/v2025.4.2...v2025.6) [Previous Releases](https://github.com/kemayo/wow-bankstack/releases)

- Option to take over the blizzard sort buttons  
    Rearrange config to support this a bit better  
    In classic, this just controls whether we add buttons at all  
- Move verbosity control to the advanced section of config  
- Only make the bank\_without\_reagents group if the reagent bank exists  
- Only make the account group if the account bank exists  
- Rewrite lots of bag index code to clean out some compatibility cruft  
    This will also fix sorting the first bag in the bank in Classic.  
- Remove 11.1.7 and 3.4.4 from the TOC  
- Remove database migration code from 2009  
- Clear out some of the no-longer-needed classic compatibility cruft  
