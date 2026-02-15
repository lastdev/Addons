# SmartBuff Retail

## [38.110226a](https://github.com/Softrix/SmartBuff-Retail/tree/38.110226a) (2026-02-11)
[Full Changelog](https://github.com/Softrix/SmartBuff-Retail/compare/v1...38.110226a) [Previous Releases](https://github.com/Softrix/SmartBuff-Retail/releases)

- Combat Safety! (#83)  
    keeping another protected function from combat  
- Fix chained buffs and add rogue/warrior updates (#82)  
    ## Chained buffs  
    - They work again now!  
    ## Rogue  
    - Assassination rogues can use 4 poisons with Dragon-Tempered Blades talent  
    ## Warrior  
    - Add Berserker Stance  
- Async buff init & midnight combat fixes (#81)  
    * Implement comprehensive buff caching system with event-driven updates  
    ## Caching Infrastructure  
    - Add persistent caching for items/spells in SmartBuffItemSpellCache  
    - Add per-character valid spells cache (SmartBuffValidSpells)  
    - Add cache synchronization with expected data tracking  
    - Add cache invalidation on version mismatch  
    ## Event-Driven Updates  
    - Handle ITEM\_DATA\_LOAD\_RESULT and SPELL\_DATA\_LOAD\_RESULT events  
    - Update static buff tables when data loads asynchronously  
    - Accept partial data following AllTheThings pattern  
    ## Toy Management  
    - Cache all toys in S.Toybox for faster initialization  
    - Fix toy matching to handle placeholder itemLinks  
    - Update toy cache when itemLinks become available  
    ## Spell Validation  
    - Filter invalid/uncastable spells using spellbook checks  
    - Track valid spells per character in SavedVariables  
    - Add isSpellbookSpell parameter to differentiate class vs item spells  
    ## Debug Tools  
    - Add /sb cache command for cache statistics  
    - Add SMARTBUFF\_PrintCacheStats() helper function  
    * Perf/memory: O(1) DATA\_LOAD\_RESULT lookups, ToyboxByID, throttle OnUpdate, compact toy cache, rebuild only on cache update  
    - Add itemIDToVarName/spellIDToVarName for O(1) var lookup in DATA\_LOAD\_RESULT handlers  
    - Add ToyboxByID index for O(1) toy lookup in FindItem; optimize LoadToys cache restore  
    - Throttle OnUpdate 0.2s->0.5s; guard debug path when Debug off  
    - Store toy cache as [toyID]=icon; support legacy load  
    - Schedule full buff rebuild only when DATA\_LOAD\_RESULT actually updated cache  
    * Extract cache helpers to SmartBuff.cache.lua  
    ## Cache refactor  
    - Add SmartBuff.cache.lua with load/save/sync/invalidate and PrintCacheStats helpers  
    - Remove cache function definitions from SmartBuff.lua (call into cache.lua)  
    - Update SmartBuff.toc: add SmartBuff.cache.lua after globals, document load order  
    ## Buffs.lua readability  
    - Add section headers (Globals and constants, Helper functions, Init: item list, Init: spell IDs, Init: per-class buff list)  
    - Add one-line comments above each helper (GetItems, getSpellBookItemByName, ValidateSpellData/ValidateItemData, GetSpellInfoIfNeeded, GetSpellInfoDirectIfNeeded, GetItemInfoIfNeeded, InsertItem, AddItem, SMARTBUFF\_LoadToys)  
    * Adding summon water elemental for mage.  
    * nit  
    * harded incombat group buff checking to only react when values are non-secret (out of combat)  
    * Defensive handling for combat secret values and API types  
    Guard aura name in UnitBuffByBuffName and UnitAuraBySpellName (nil/secret for other units).  
    Guard spell/item cooldown: check cooldown table and use tonumber(cds/cd) or 0 in SMARTBUFF\_BuffUnit and SMARTBUFF\_doCast.  
    Normalize returned duration/expirationTime and all timeleft - GetTime() uses with tonumber(...) or 0.  
    Guard debuff icon in SMARTBUFF\_IsDebuffTexture before string.find.  
    * few more passes of defences  
    * some more hardening and workarounds for edge cases.  
    * Fixing reset all  
    * let's not do global on reset  
    * preparing for release  
    * nit  
    * fixing couple of edge cases with data reset and  
    * don't rebind keys in combat.  
    * oops forgot to update the reminder  
    * Fix buff food display  
    Move cache resets into dedicated helper functions  
    Some additional housekeeping  
    * adding type and safe validation checks for all the saved variables so that if they're not... 'right' they will get fixed up before proceeding.  
    * updating changelong  
    * prismatic barrier for mages  
    * further optiomizations:  
    slow down set buffs pending to once every half second  
    Lets just not react to toys\_updated event in case we're causing it. This may fix edgecase performane issue  
    * buff state init is consistent (enabled/disabled)  
    * attempt number 2 at keep buff state after relogin, now with more changes  
    * alrighty, finally looks like buffinit is fixed  
    * fixing occasional nil error n find aura by name.  
    * release prep  
    * Fixing or at least clarifying in combat notifications and buff logic  
    proper conjure refreshment spell for retail  
    * Fix weapon buffs not filtering out when they don't exist.  
    * nil edge case.  
    * Add cruft removal to saved buffs to avoid ambiguity and hopefully fix 'enabled disabled' inconsistency forever.  
    * Display items as items  
    Don't over-stress cleanup  
    * Use canonical item:ID keys, dedupe potions/flasks, show names in UI, refresh options on data load  
    - Store item:ID in cBuffs/Order; normalize and dedupe on init  
    - Resolve item:ID to display name in splash, chat, options; redraw options list after SetBuffs when open  
    - Init: BuildItemTables then InitSpellList; SavedVariables guards; delayed retry for flasks/toys  
    * maybe finally no dupes?!  
    * adding guard for initial loop state to keep on trying till it's healthy.  
    * release prep  
    * Updating Shaman Buffs that changed in 12.0  
    * Internal version bump  
    * init even when version upgrade  
    * moving newer toys up the list to maybe init them faster. Honestly i should make toys... toys...  
    * Adding deadly poison for rogues  
    * reset toybox to default filters to be able to index toys.  