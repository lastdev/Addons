local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

--- Table containing all addon runtime variables.
---@class Variables
---@field delvesData table<integer, DelveData[]> Table containing all Delves' runtime data (refer to [DelveData](lua://DelveData)).
---@field maxLevelReached boolean Whether player has reached max level of the current expansion.
---@field keysCollected integer Number of [Restored Coffer Keys](https://www.wowhead.com/currency=3028/restored-coffer-key) player has got from Caches this week.
---@field shardsCollected integer Number of [Coffer Key Shards](https://www.wowhead.com/item=245653/coffer-key-shard) player has got from Caches this week.
---@field tomTomAvailable boolean Whether TomTom addon is loaded.
---@field mpeAvailable boolean Whether MapPinEnhanced addon is loaded.
---@field isPTR boolean A flag used to check client version: Mainline or PTR.
local Variables = {
    delvesData = {},
    maxLevelReached = false,
    keysCollected = 0,
    shardsCollected = 0,
    tomTomAvailable = false,
    mpeAvailable = false,
    isPTR = (select(4, GetBuildInfo())) >= 120000
}
DelveCompanion.Variables = Variables
