# Prat 3.0

## [3.9.77](https://github.com/Legacy-of-Sylvanaar/prat-3-0/tree/3.9.77) (2025-12-08)
[Full Changelog](https://github.com/Legacy-of-Sylvanaar/prat-3-0/compare/3.9.76...3.9.77) [Previous Releases](https://github.com/Legacy-of-Sylvanaar/prat-3-0/releases)

- Apply message event filters  
    This fixes WeakAuras and MDT linking (plus any other addon that does event filters)  
- Unhook retail patch for aliases on modue unload.  
- TellTarget module rewrite/cleanup  
- Alias module rewrite - Fixes #252  
    - Cleanup all code  
    - Make sure it's supporting 11.2.7  
    - Much cleaner  
- Execute TellTarget in a secure wrap for SecureCmdList. Fixes #241  
- Handle edgecase of errorcount being nil and re-running. Fixes #239  
- Replace plusmouse funding with QartemisT, as per request by plusmouse.  
- EditBox fixes for 11.2.7  
- Handle edge case where size might not be defined  
