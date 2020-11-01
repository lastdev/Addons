if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then return end

local addonName = ... ---@type string @The name of the addon.
local ns = select(2, ...) ---@type ns @The addon namespace.
local L = ns.L

local arshift = bit.arshift
local band = bit.band
local bnot = bit.bnot
local bor = bit.bor
local bxor = bit.bxor
local lshift = bit.lshift
local mod = bit.mod
local rshift = bit.rshift

-- constants.lua (ns)
-- dependencies: none
do

    ---@class ns
    ---@field public Print function @Prints yellow text to the default chat frame. Behaves otherwise same way as AddMessage does
    ---@field public EXPANSION number @The currently accessible expansion to the playerbase
    ---@field public MAX_LEVEL number @The currently accessible expansion max level to the playerbase
    ---@field public REGION_TO_LTD string[] @Region ID to LTD conversion table
    ---@field public FACTION_TO_ID number[] @Faction group string to ID conversion table
    ---@field public PLAYER_REGION string @"us","kr","eu","tw","cn"
    ---@field public PLAYER_REGION_ID number @1 (us), 2 (kr), 3 (eu), 4 (tw), 5 (cn)
    ---@field public PLAYER_FACTION number @1 (alliance), 2 (horde), 3 (neutral)
    ---@field public PLAYER_FACTION_TEXT string @"Alliance", "Horde", "Neutral"
    ---@field public PLAYER_NAME string @The name of the player character
    ---@field public PLAYER_REALM string @The realm of the player character
    ---@field public PLAYER_REALM_SLUG string @The realm slug of the player character
    ---@field public OUTDATED_CUTOFF number @Seconds before we start looking at the data as out-of-date
    ---@field public OUTDATED_BLOCK_CUTOFF number @Seconds before we block future score showing
    ---@field public PROVIDER_DATA_TYPE number[] @Data Type enum
    ---@field public LOOKUP_MAX_SIZE number @The maximum index we can use in a table before we start to get errors
    ---@field public CURRENT_SEASON number @The current mythic keystone season
    ---@field public HEADLINE_MODE table<string, number> @Enum over headline modes
    ---@field public ROLE_ICONS RoleIcons @Collection of roles and their icons
    ---@field public KEYSTONE_LEVEL_PATTERN table<number, string> @Table over patterns matching keystone levels in strings
    ---@field public KEYSTONE_LEVEL_TO_SCORE table<number, number> @Table over keystone levels and the base score for that level
    ---@field public RAID_DIFFICULTY table<number, RaidDifficulty> @Table of 1=normal, 2=heroic, 3=mythic difficulties and their names and colors

    ns.Print = function(text, r, g, b, ...)
        r, g, b = r or 1, g or 1, b or 0
        DEFAULT_CHAT_FRAME:AddMessage(tostring(text), r, g, b, ...)
    end

    ns.EXPANSION = GetExpansionLevel()
    ns.MAX_LEVEL = GetMaxLevelForExpansionLevel(ns.EXPANSION)
    ns.REGION_TO_LTD = {"us", "kr", "eu", "tw", "cn"}
    ns.FACTION_TO_ID = {Alliance = 1, Horde = 2, Neutral = 3}
    ns.PLAYER_REGION = nil
    ns.PLAYER_REGION_ID = nil
    ns.PLAYER_FACTION = nil
    ns.PLAYER_FACTION_TEXT = nil
    ns.OUTDATED_CUTOFF = 86400 * 3 -- number of seconds before we start warning about stale data (warning the user should update their addon)
    ns.OUTDATED_BLOCK_CUTOFF = 86400 * 7 -- number of seconds before we hide the data (block showing score as its most likely inaccurate)
    ns.PROVIDER_DATA_TYPE = {MythicKeystone = 1, Raid = 2, PvP = 3}
    ns.LOOKUP_MAX_SIZE = floor(2^18-1)
    ns.CURRENT_SEASON = 4 -- TODO: dynamic?
    ns.RAIDERIO_ADDON_DOWNLOAD_URL = "https://rio.gg/addon"

    ns.HEADLINE_MODE = {
        CURRENT_SEASON = 0,
        BEST_SEASON = 1,
        BEST_RUN = 2
    }

    ---@class RoleIcon
    ---@field full string @The full icon in "|T|t" syntax
    ---@field partial string @The partial icon in "|T|t" syntax

    ---@class RoleIcons
    ---@field public dps RoleIcon
    ---@field public healer RoleIcon
    ---@field public tank RoleIcon

    ns.ROLE_ICONS = {
        dps = {
            full = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:0:18:0:18|t",
            partial = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:0:18:36:54|t"
        },
        healer = {
            full = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:19:37:0:18|t",
            partial = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:19:37:36:54|t"
        },
        tank = {
            full = "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:38:56:0:18|t",
            partial	= "|TInterface\\AddOns\\RaiderIO\\icons\\roles:14:14:0:0:64:64:38:56:36:54|t"
        }
    }

    ns.KEYSTONE_LEVEL_PATTERN = {
        "(%d+)%+",
        "%+%s*(%d+)",
        "(%d+)%s*%+",
        "(%d+)"
    }

    ns.KEYSTONE_LEVEL_TO_SCORE = {
        [2] = 20,
        [3] = 30,
        [4] = 40,
        [5] = 50,
        [6] = 60,
        [7] = 70,
        [8] = 80,
        [9] = 90,
        [10] = 100,
        [11] = 110,
        [12] = 121,
        [13] = 133,
        [14] = 146,
        [15] = 161,
        [16] = 177,
        [17] = 195,
        [18] = 214,
        [19] = 236,
        [20] = 259,
        [21] = 285,
        [22] = 314,
        [23] = 345,
        [24] = 380,
        [25] = 418,
        [26] = 459,
        [27] = 505,
        [28] = 556,
        [29] = 612,
        [30] = 673
    }

    ---@class RaidDifficultyColor[]
    ---@field public pos1 number @red (0-1.0) - this table can be unpacked to get r, g, b
    ---@field public pos2 number @green (0-1.0) - this table can be unpacked to get r, g, b
    ---@field public pos3 number @blue (0-1.0) - this table can be unpacked to get r, g, b
    ---@field public hex string @hex (000000-ffffff) - this table can be unpacked to get r, g, b

    ---@class RaidDifficulty
    ---@field public suffix string
    ---@field public name string
    ---@field public color RaidDifficultyColor

    ns.RAID_DIFFICULTY = {
        [1] = {
            suffix = L.RAID_DIFFICULTY_SUFFIX_NORMAL,
            name = L.RAID_DIFFICULTY_NAME_NORMAL,
            color = { 0.12, 1.00, 0.00, hex = "1eff00" }
        },
        [2] = {
            suffix = L.RAID_DIFFICULTY_SUFFIX_HEROIC,
            name = L.RAID_DIFFICULTY_NAME_HEROIC,
            color = { 0.00, 0.44, 0.87, hex = "0070dd" }
        },
        [3] = {
            suffix = L.RAID_DIFFICULTY_SUFFIX_MYTHIC,
            name = L.RAID_DIFFICULTY_NAME_MYTHIC,
            color = { 0.64, 0.21, 0.93, hex = "a335ee" }
        }
    }

end

-- data.lua (ns)
-- dependencies: constants
do

    ---@class CharacterProfile
    ---@field public name string
    ---@field public realm string
    ---@field public faction string @"alliance", "horde"
    ---@field public race number
    ---@field public class number

    ---@class CharacterMythicKeystoneRun
    ---@field public zone_id number
    ---@field public level number
    ---@field public upgrades number
    ---@field public fraction number
    ---@field public score number
    ---@field public url string

    ---@class CharacterCollection
    ---@field public profile CharacterProfile
    ---@field public mythic_keystone CharacterCollectionKeystones

    ---@class CharacterCollectionKeystones
    ---@field public all CharacterCollectionKeystoneProfile

    ---@class CharacterCollectionKeystoneProfile
    ---@field public score number
    ---@field public best CharacterMythicKeystoneRun
    ---@field public runs CharacterMythicKeystoneRun[]

    ---@return Character<string, CharacterCollection>
    function ns:GetClientData()
        return ns.CLIENT_CHARACTERS
    end

    ---@class ScoreColor
    ---@field public score number
    ---@field public color number[]

    ---@return ScoreColorCollection<number, ScoreColor>
    function ns:GetClientColorData()
        return ns.CLIENT_COLORS
    end

    ---@class GuildProfile
    ---@field public name string
    ---@field public realm string
    ---@field public faction string @"alliance", "horde"

    ---@class GuildMythicKeystoneRunMember
    ---@field public name string
    ---@field public role string @"tank", "heal", "dps"
    ---@field public class_id number

    ---@class GuildMythicKeystoneRun
    ---@field public zone_id number
    ---@field public level number
    ---@field public upgrades number
    ---@field public fraction number
    ---@field public clear_time string
    ---@field public party GuildMythicKeystoneRunMember[]

    ---@class GuildCollection
    ---@field public profile GuildProfile
    ---@field public season_best GuildMythicKeystoneRun[]
    ---@field public weekly_best GuildMythicKeystoneRun[]

    ---@return Guild<string, GuildCollection>
    function ns:GetClientGuildData()
        return ns.GUILD_BEST_DATA
    end

    ---@class Dungeon
    ---@field public id number
    ---@field public keystone_instance number
    ---@field public instance_map_id number
    ---@field public lfd_activity_ids number[]
    ---@field public name string
    ---@field public shortName string
    ---@field public shortNameLocale string @Assigned dynamically based on the user preference regarding the short dungeon names.
    ---@field public index number @Assigned dynamically based on the index of the dungeon in the table.

    ---@type Dungeon[]
    local DUNGEONS = ns.DUNGEONS or ns.dungeons -- DEPRECATED: ns.dungeons

    for i = 1, #DUNGEONS do
        local dungeon = DUNGEONS[i] ---@type Dungeon
        dungeon.index = i
    end

    ---@return Dungeon[]
    function ns:GetDungeonData()
        return DUNGEONS
    end

    ---@return RealmCollection<string, string>
    function ns:GetRealmData()
        return ns.REALMS or ns.realmSlugs -- DEPRECATED: ns.realmSlugs
    end

    ---@return RegionCollection<number, number>
    function ns:GetRegionData()
        return ns.REGIONS or ns.regionIDs -- DEPRECATED: ns.regionIDs
    end

    ---@return ScoreStatsCollection<number, number>
    function ns:GetScoreStatsData()
        return ns.SCORE_STATS or ns.scoreLevelStats -- DEPRECATED: ns.scoreLevelStats
    end

    ---@return ScoreColorCollection<number, ScoreColor>
    function ns:GetScoreTiersData()
        return ns.SCORE_TIERS or ns.scoreTiers -- DEPRECATED: ns.scoreTiers
    end

    ---@class ScoreTierSimple
    ---@field public score number
    ---@field public quality number

    ---@return ScoreTiersSimpleCollection<number, ScoreTierSimple>
    function ns:GetScoreTiersSimpleData()
        return ns.SCORE_TIERS_SIMPLE or ns.scoreTiersSimple -- DEPRECATED: ns.scoreTiersSimple
    end

    ---@return ScoreColorCollection<number, ScoreColor>
    function ns:GetScoreTiersPrevData()
        return ns.SCORE_TIERS_PREV or ns.previousScoreTiers -- DEPRECATED ns.previousScoreTiers
    end

    ---@return ScoreTiersSimpleCollection<number, ScoreTierSimple>
    function ns:GetScoreTiersSimplePrevData()
        return ns.SCORE_TIERS_SIMPLE_PREV or ns.previousScoreTiersSimple -- DEPRECATED: ns.previousScoreTiersSimple
    end

end

-- module.lua (ns)
-- dependencies: none
do

    ---@type Module<string, Module>
    local modules = {}
    local moduleIndex = 0

    ---@class Module
    -- private properties for internal use only
    ---@field private id string @Required and unique string to identify the module.
    ---@field private index number @Automatically assigned a number based on the creation order.
    ---@field private loaded boolean @Flag indicates if the module is loaded.
    ---@field private enabled boolean @Flag indicates if the module is enabled.
    ---@field private dependencies string[] @List over dependencies before we can Load the module.
    -- private functions that should never be called
    ---@field private SetLoaded function @Internal function should not be called manually.
    ---@field private Load function @Internal function should not be called manually.
    ---@field private SetEnabled function @Internal function should not be called manually.
    -- protected functions that can be called but should never be overridden
    ---@field protected IsLoaded function @Internal function, can be called but do not override.
    ---@field protected IsEnabled function @Internal function, can be called but do not override.
    ---@field protected Enable function @Internal function, can be called but do not override.
    ---@field protected Disable function @Internal function, can be called but do not override.
    ---@field protected SetDependencies function @Internal function, can be called but do not override.
    ---@field protected HasDependencies function @Internal function, can be called but do not override.
    ---@field protected GetDependencies function @Internal function, can be called but do not override. Returns a table using the same order as the dependencies table. Returns the modules or nil depending if they are available or not.
    -- public functions that can be overridden
    ---@field public CanLoad function @If it returns true the module will be loaded, otherwise postponed for later. Override to define your modules load criteria that have to be met before loading.
    ---@field public OnLoad function @Once the module loads this function is executed. Use this to setup further logic for your module. The args provided are the module references as described in the dependencies table.
    ---@field public OnEnable function @This function is executed when the module is set to enabled state. Use this to setup and prepare.
    ---@field public OnDisable function @This function is executed when the module is set to disabled state. Use this for cleanup purposes.

    ---@type Module
    local module = {}

    ---@return nil
    function module:SetLoaded(state)
        self.loaded = state
    end

    ---@return boolean
    function module:Load()
        if not self:CanLoad() then
            return false
        end
        self:SetLoaded(true)
        self:OnLoad(unpack(self:GetDependencies()))
        return true
    end

    ---@return nil
    function module:SetEnabled(state)
        self.enabled = state
    end

    ---@return boolean
    function module:IsLoaded()
        return self.loaded
    end

    ---@return boolean
    function module:IsEnabled()
        return self.enabled
    end

    ---@return boolean
    function module:Enable()
        if self:IsEnabled() then
            return false
        end
        self:SetEnabled(true)
        self:OnEnable()
        return true
    end

    ---@return boolean
    function module:Disable()
        if not self:IsEnabled() then
            return false
        end
        self:SetEnabled(false)
        self:OnDisable()
        return true
    end

    ---@return nil
    function module:SetDependencies(dependencies)
        self.dependencies = dependencies
    end

    ---@return boolean
    function module:HasDependencies()
        if type(self.dependencies) == "string" then
            local m = modules[self.dependencies]
            return m and m:IsLoaded()
        end
        if type(self.dependencies) == "table" then
            for _, id in ipairs(self.dependencies) do
                local m = modules[id]
                if not m or not m:IsLoaded() then
                    return false
                end
            end
        end
        return true
    end

    ---@return Module[]
    function module:GetDependencies()
        local temp = {}
        local index = 0
        if type(self.dependencies) == "string" then
            index = index + 1
            temp[index] = modules[self.dependencies]
        end
        if type(self.dependencies) == "table" then
            for _, id in ipairs(self.dependencies) do
                index = index + 1
                temp[index] = modules[id]
            end
        end
        return temp
    end

    ---@return boolean
    function module:CanLoad()
        return not self:IsLoaded()
    end

    ---@vararg Module
    ---@return nil
    function module:OnLoad(...)
        self:Enable()
    end

    ---@return nil
    function module:OnEnable()
    end

    ---@return nil
    function module:OnDisable()
    end

    ---@param id string @Unique module ID reference.
    ---@param data Module @Optional table with properties to copy into the newly created module.
    function ns:NewModule(id, data)
        assert(type(id) == "string", "Raider.IO Module expects NewModule(id[, data]) where id is a string, data is optional table.")
        assert(not modules[id], "Raider.IO Module expects NewModule(id[, data]) where id is a string, that is unique and not already taken.")
        ---@type Module
        local m = {}
        for k, v in pairs(module) do
            m[k] = v
        end
        moduleIndex = moduleIndex + 1
        m.index = moduleIndex
        m.id = id
        m:SetLoaded(false)
        m:SetEnabled(false)
        m:SetDependencies()
        if type(data) == "table" then
            for k, v in pairs(data) do
                m[k] = v
            end
        end
        modules[id] = m
        return m
    end

    ---@param a Module
    ---@param b Module
    local function SortModules(a, b)
        return a.index < b.index
    end

    ---@return Module[]
    function ns:GetModules()
        local ordered = {}
        local index = 0
        for _, module in pairs(modules) do
            index = index + 1
            ordered[index] = module
        end
        table.sort(ordered, SortModules)
        return ordered
    end

    ---@param id string @Unique module ID reference.
    ---@param silent boolean @Ommit to throw if module doesn't exists.
    function ns:GetModule(id, silent)
        assert(type(id) == "string", "Raider.IO Module expects GetModule(id) where id is a string.")
        for _, module in pairs(modules) do
            if module.id == id then
                return module
            end
        end
        assert(silent, "Raider.IO Module expects GetModule(id) where id is a string, and the module must exists, or the silent param must be set to avoid this throw.")
    end

end

-- callback.lua
-- dependencies: module
do

    ---@class CallbackModule : Module
    local callback = ns:NewModule("Callback") ---@type CallbackModule

    local callbacks = {}
    local callbackOnce = {}

    local handler = CreateFrame("Frame")

    handler:SetScript("OnEvent", function(handler, event, ...)
        if event == "COMBAT_LOG_EVENT_UNFILTERED" or event == "COMBAT_LOG_EVENT" then
            callback:SendEvent(event, CombatLogGetCurrentEventInfo())
        else
            callback:SendEvent(event, ...)
        end
    end)

    ---@param callbackFunc function
    function callback:RegisterEvent(callbackFunc, ...)
        assert(type(callbackFunc) == "function", "Raider.IO Callback expects RegisterEvent(callback[, ...events])")
        local events = {...}
        for _, event in ipairs(events) do
            if not callbacks[event] then
                callbacks[event] = {}
            end
            table.insert(callbacks[event], callbackFunc)
            pcall(handler.RegisterEvent, handler, event)
        end
    end

    ---@param callbackFunc function
    ---@param event string
    function callback:RegisterUnitEvent(callbackFunc, event, ...)
        assert(type(callbackFunc) == "function" and type(event) == "string", "Raider.IO Callback expects RegisterUnitEvent(callback, event, ...units)")
        if not callbacks[event] then
            callbacks[event] = {}
        end
        table.insert(callbacks[event], callbackFunc)
        handler:RegisterUnitEvent(event, ...)
    end

    function callback:UnregisterEvent(callbackFunc, ...)
        assert(type(callbackFunc) == "function", "Raider.IO Callback expects UnregisterEvent(callback, ...events)")
        local events = {...}
        callbackOnce[callbackFunc] = nil
        for _, event in ipairs(events) do
            local eventCallbacks = callbacks[event]
            for i = #eventCallbacks, 1, -1 do
                local eventCallback = eventCallbacks[i]
                if eventCallback == callbackFunc then
                    table.remove(eventCallbacks, i)
                end
            end
            if not eventCallbacks[1] then
                handler:UnregisterEvent(event)
            end
        end
    end

    ---@param callbackFunc function
    function callback:UnregisterCallback(callbackFunc)
        assert(type(callbackFunc) == "function", "Raider.IO Callback expects UnregisterCallback(callback)")
        for event, _ in pairs(callbacks) do
            self:UnregisterEvent(callbackFunc, event)
        end
    end

    ---@param event string
    function callback:SendEvent(event, ...)
        assert(type(event) == "string", "Raider.IO Callback expects SendEvent(event[, ...args])")
        local eventCallbacks = callbacks[event]
        if not eventCallbacks then
            return
        end
        -- execute in correct sequence but note if any are to be removed later
        local remove
        for i = 1, #eventCallbacks do
            local callbackFunc = eventCallbacks[i]
            callbackFunc(event, ...)
            if callbackOnce[callbackFunc] then
                callbackOnce[callbackFunc] = nil
                if not remove then
                    remove = {}
                end
                table.insert(remove, i)
            end
        end
        -- if we have callbacks to remove iterate backwards and remove those indices
        if remove then
            for i = #remove, 1, -1 do
                table.remove(eventCallbacks, remove[i])
            end
        end
    end

    ---@param callbackFunc function
    function callback:RegisterEventOnce(callbackFunc, ...)
        assert(type(callbackFunc) == "function", "Raider.IO Callback expects RegisterEventOnce(callback[, ...events])")
        callbackOnce[callbackFunc] = true
        callback:RegisterEvent(callbackFunc, ...)
    end

end

-- config.lua
-- dependencies: module, callback
do

    ---@class ConfigModule : Module
    ---@field public SavedVariablesLoaded boolean This is etonce the SV are loaded to indicate we are ready to read from the settings table.
    local config = ns:NewModule("Config") ---@type ConfigModule
    local callback = ns:GetModule("Callback") ---@type CallbackModule

    -- fallback saved variables
    local fallbackConfig = {
        enableUnitTooltips = true,
        enableLFGTooltips = true,
        enableFriendsTooltips = true,
        enableLFGDropdown = true,
        enableWhoTooltips = true,
        enableWhoMessages = true,
        enableGuildTooltips = true,
        enableKeystoneTooltips = true,
        mplusHeadlineMode = 1,
        useEnglishAbbreviations = false,
        showMainsScore = true,
        showMainBestScore = true,
        showDropDownCopyURL = true,
        showSimpleScoreColors = false,
        showScoreInCombat = true,
        showScoreModifier = false, -- NEW in 9.0
        disableScoreColors = false,
        enableClientEnhancements = true,
        showClientGuildBest = true,
        displayWeeklyGuildBest = false,
        showRaiderIOProfile = true,
        hidePersonalRaiderIOProfile = false,
        showRaidEncountersInProfile = true,
        enableProfileModifier = true,
        inverseProfileModifier = false,
        positionProfileAuto = true,
        lockProfile = false,
        showRoleIcons = true,
        profilePoint = { point = nil, x = 0, y = 0 },
        debugMode = false
    }

    -- fallback metatable looks up missing keys into the fallback config table
    local fallbackMetatable = {
        __index = function(_, key)
            return fallbackConfig[key]
        end
    }

    -- the global saved variables table used when setting up fresh installations
    RaiderIO_Config = setmetatable({}, fallbackMetatable)

    local function OnPlayerLogin()
        if type(RaiderIO_Config) ~= "table" then
            RaiderIO_Config = {}
        end
        setmetatable(RaiderIO_Config, fallbackMetatable)
        config:Enable()
        if config:Get("debugMode") then
            ns.Print(format(L.WARNING_DEBUG_MODE_ENABLE, addonName))
        end
        callback:SendEvent("RAIDERIO_CONFIG_READY")
    end

    function config:CanLoad()
        return not self:IsLoaded() and self.SavedVariablesLoaded
    end

    function config:OnLoad()
        callback:RegisterEventOnce(OnPlayerLogin, "RAIDERIO_PLAYER_LOGIN")
    end

    function config:Set(key, val)
        assert(self:IsEnabled(), "Raider.IO Config expects Set(key, val) to only be used after the addon saved variables have been loaded.")
        RaiderIO_Config[key] = val
    end

    function config:Get(key, fallback)
        assert(self:IsEnabled(), "Raider.IO Config expects Get(key[, fallback]) to only be used after the addon saved variables have been loaded.")
        local val = RaiderIO_Config[key]
        if val == nil then
            return fallback
        end
        return val
    end

end

-- util.lua
-- dependencies: module, config
do

    ---@class UtilModule : Module
    local util = ns:NewModule("Util") ---@type UtilModule
    local callback =  ns:GetModule("Callback") ---@type CallbackModule
    local config = ns:GetModule("Config") ---@type ConfigModule

    local DUNGEONS = ns:GetDungeonData()
    local SORTED_DUNGEONS = {} ---@type Dungeon[]
    do
        for i = 1, #DUNGEONS do
            SORTED_DUNGEONS[i] = DUNGEONS[i]
        end
    end

    -- update the dungeon properties for shortNameLocale at the appropriate events
    local function OnSettingsChanged()
        if not config:IsEnabled() then
            return
        end
        local useEnglishAbbreviations = config:Get("useEnglishAbbreviations")
        for i = 1, #DUNGEONS do
            local dungeon = DUNGEONS[i]
            if useEnglishAbbreviations then
                dungeon.shortNameLocale = dungeon.shortName
            else
                dungeon.shortNameLocale = L["DUNGEON_SHORT_NAME_" .. dungeon.shortName] or dungeon.shortName
            end
        end
        table.sort(SORTED_DUNGEONS, function(a, b)
            return a.shortNameLocale < b.shortNameLocale
        end)
    end
    callback:RegisterEvent(OnSettingsChanged, "RAIDERIO_CONFIG_READY")
    callback:RegisterEvent(OnSettingsChanged, "RAIDERIO_SETTINGS_SAVED")

    ---@return Dungeon[]
    function util:GetSortedDungeons()
        return SORTED_DUNGEONS
    end

    ---@return Dungeon|nil
    function util:GetDungeonByIndex(index)
        return DUNGEONS[index]
    end

    ---@return Dungeon|nil
    function util:GetDungeonByLFDActivityID(id)
        for i = 1, #DUNGEONS do
            local dungeon = DUNGEONS[i]
            for j = 1, #dungeon.lfd_activity_ids do
                local activityID = dungeon.lfd_activity_ids[j]
                if activityID == id then
                    return dungeon
                end
            end
        end
    end

    ---@return Dungeon|nil
    function util:GetDungeonByKeyValue(key, value)
        for i = 1, #DUNGEONS do
            local dungeon = DUNGEONS[i]
            if dungeon[key] == value then
                return dungeon
            end
        end
    end

    ---@return Dungeon|nil
    function util:GetDungeonByID(id)
        return util:GetDungeonByKeyValue("id", id)
    end

    ---@return Dungeon|nil
    function util:GetDungeonByInstanceMapID(id)
        return util:GetDungeonByKeyValue("instance_map_id", id)
    end

    ---@return Dungeon|nil
    function util:GetDungeonByKeystoneID(id)
        return util:GetDungeonByKeyValue("keystone_instance", id)
    end

    ---@return Dungeon|nil
    function util:GetDungeonByName(name)
        return util:GetDungeonByKeyValue("name", name)
    end

    ---@return Dungeon|nil
    function util:GetDungeonByShortName(name)
        return util:GetDungeonByKeyValue("shortName", name) or util:GetDungeonByKeyValue("shortNameLocale", name)
    end

    ---@param object Widget @Any interface widget object that supports the methods GetScript.
    ---@param handler string @The script handler like OnEnter, OnClick, etc.
    ---@return boolean|nil @If successfully executed returns true, otherwise false if nothing has been called. nil if the widget had no handler to execute.
    function util:ExecuteWidgetHandler(object, handler, ...)
        if type(object) ~= "table" or type(object.GetScript) ~= "function" then
            return false
        end
        local func = object:GetScript(handler)
        if type(func) ~= "function" then
            return
        end
        if not pcall(func, object, ...) then
            return false
        end
        return true
    end

    ---@param object Widget @Any interface widget object that supports the methods GetOwner.
    ---@param owner Widget @Any interface widget object.
    ---@param anchor string @`ANCHOR_TOPLEFT`, `ANCHOR_NONE`, `ANCHOR_CURSOR`, etc.
    ---@param offsetX number @Optional offset X for some of the anchors.
    ---@param offsetY number @Optional offset Y for some of the anchors.
    ---@return boolean, boolean @If owner was set arg1 is true. If owner was updated arg2 is true. Otherwise both will be set to face to indicate we did not update the Owner of the widget.
    function util:SetOwnerSafely(object, owner, anchor, offsetX, offsetY)
        if type(object) ~= "table" or type(object.GetOwner) ~= "function" then
            return
        end
        local currentOwner = object:GetOwner()
        if not currentOwner then
            object:SetOwner(owner, anchor, offsetX, offsetY)
            return true
        end
        offsetX, offsetY = offsetX or 0, offsetY or 0
        local currentAnchor, currentOffsetX, currentOffsetY = object:GetAnchorType()
        currentOffsetX, currentOffsetY = currentOffsetX or 0, currentOffsetY or 0
        if currentAnchor ~= anchor or (currentOffsetX ~= offsetX and abs(currentOffsetX - offsetX) > 0.01) or (currentOffsetY ~= offsetY and abs(currentOffsetY - offsetY) > 0.01) then
            object:SetOwner(owner, anchor, offsetX, offsetY)
            return true
        end
        return false, true
    end

    ---@param text string @The format string like "Greetings %s! How are you?"
    ---@return string @Returns a pattern like "Greetings (.-)%! How are you%?"
    function util:FormatToPattern(text)
        if type(text) ~= "string" then
            return
        end
        text = text:gsub("%%", "%%%%")
        text = text:gsub("%.", "%%%.")
        text = text:gsub("%?", "%%%?")
        text = text:gsub("%+", "%%%+")
        text = text:gsub("%-", "%%%-")
        text = text:gsub("%(", "%%%(")
        text = text:gsub("%)", "%%%)")
        text = text:gsub("%[", "%%%[")
        text = text:gsub("%]", "%%%]")
        text = text:gsub("%%%%s", "(.-)")
        text = text:gsub("%%%%d", "(%%d+)")
        text = text:gsub("%%%%%%[%d%.%,]+f", "([%%d%%.%%,]+)")
        return text
    end

    ---@param ts number @A time() number
    ---@return number @seconds difference between time and utc
    function util:GetTimeZoneOffset(ts)
        local utc = date("!*t", ts)
        local loc = date("*t", ts)
        loc.isdst = false
        return difftime(time(loc), time(utc))
    end

    ---@param dateString string @A date like "2017-06-03T00:41:07Z"
    ---@return number @A time() number
    function util:GetTimeFromDateString(dateString)
        local year, month, day, hours, minutes, seconds = dateString:match("^(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+).*Z$")
        return time({ year = year, month = month, day = day, hour = hours, min = minutes, sec = seconds })
    end

    local REGION = ns:GetRegionData()

    ---@return any, number @arg1 can be nil (no data), false (server is unknown), string (the ltd). arg2 can be nil (no data), or region ID.
    function util:GetRegion()
        local guid = UnitGUID("player")
        if not guid then
            return
        end
        local serverId = tonumber(strmatch(guid, "^Player%-(%d+)") or 0) or 0
        local regionId = REGION[serverId]
        if not regionId then
            regionId = GetCurrentRegion()
            ns.Print(format(L.UNKNOWN_SERVER_FOUND, addonName, guid or "N/A", GetNormalizedRealmName() or "N/A"))
        end
        if not regionId then
            return false
        end
        local ltd = ns.REGION_TO_LTD[regionId]
        if not ltd then
            return false, regionId
        end
        return ltd, regionId
    end

    ---@return number, string @arg1 is the faction ID or nil if no faction is appropriate. arg2 is the faction localized text for display purposes.
    function util:GetFaction(unit)
        if not unit or not UnitExists(unit) or not UnitIsPlayer(unit) then
            return
        end
        local faction, localizedFaction = UnitFactionGroup(unit)
        if not faction then
            return
        end
        return ns.FACTION_TO_ID[faction], localizedFaction
    end

    local CLIENT_RACE_TO_FACTION_ID = {}

    do
        for i = 1, 100 do
            local raceInfo = C_CreatureInfo.GetRaceInfo(i)
            if raceInfo and raceInfo.clientFileString ~= "Pandaren" then -- this is ambiguous so we better not assume
                local factionInfo = C_CreatureInfo.GetFactionInfo(raceInfo.raceID)
                if factionInfo then
                    CLIENT_RACE_TO_FACTION_ID[raceInfo.clientFileString] = ns.FACTION_TO_ID[factionInfo.groupTag]
                end
            end
        end
    end

    ---@return number, string @arg1 is the faction ID or nil if no faction is appropriate
    function util:GetFactionFromRace(race, fallback)
        return CLIENT_RACE_TO_FACTION_ID[race] or fallback
    end

    local REALMS = ns:GetRealmData()

    function util:GetRealmSlug(realm, fallback)
        local realmSlug = REALMS[realm]
        if fallback == true then
            return realmSlug or realm
        elseif fallback then
            return realmSlug or fallback
        end
        return realmSlug
    end

    local UNIT_TOKENS = {
        mouseover = true,
        player = true,
        target = true,
        focus = true,
        pet = true,
        vehicle = true,
    }

    do
        for i = 1, 40 do
            UNIT_TOKENS["raid" .. i] = true
            UNIT_TOKENS["raidpet" .. i] = true
            UNIT_TOKENS["nameplate" .. i] = true
        end

        for i = 1, 4 do
            UNIT_TOKENS["party" .. i] = true
            UNIT_TOKENS["partypet" .. i] = true
        end

        for i = 1, 5 do
            UNIT_TOKENS["arena" .. i] = true
            UNIT_TOKENS["arenapet" .. i] = true
        end

        for i = 1, MAX_BOSS_FRAMES do
            UNIT_TOKENS["boss" .. i] = true
        end

        for k, _ in pairs(UNIT_TOKENS) do
            UNIT_TOKENS[k .. "target"] = true
        end
    end

    ---@return boolean @If the unit provided is a unit token this returns true, otherwise false
    function util:IsUnitToken(unit)
        return type(unit) == "string" and UNIT_TOKENS[unit]
    end

    ---@param arg1 string @"unit", "name", or "name-realm"
    ---@param arg2 string @"realm" or nil
    ---@return boolean, boolean, boolean @If the args used in the call makes it out to be a proper unit, arg1 is true and only then is arg2 true if unit exists and arg3 is true if unit is a player.
    function util:IsUnit(arg1, arg2)
        if not arg2 and type(arg1) == "string" and arg1:find("-", nil, true) then
            arg2 = true
        end
        local isUnit = not arg2 or util:IsUnitToken(arg1)
        return isUnit, isUnit and UnitExists(arg1), isUnit and UnitIsPlayer(arg1)
    end

    ---@param arg1 string @"unit", "name", or "name-realm"
    ---@param arg2 string @"realm" or nil
    ---@return string, string, string @name, realm, unit
    function util:GetNameRealm(arg1, arg2)
        local unit, name, realm
        local _, unitExists, unitIsPlayer = util:IsUnit(arg1, arg2)
        if unitExists then
            unit = arg1
            if unitIsPlayer then
                name, realm = UnitName(arg1)
                realm = realm and realm ~= "" and realm or GetNormalizedRealmName()
            end
            return name, realm, unit
        end
        if type(arg1) == "string" then
            if arg1:find("-", nil, true) then
                name, realm = ("-"):split(arg1)
            else
                name = arg1 -- assume this is the name
            end
            if not realm or realm == "" then
                if type(arg2) == "string" and arg2 ~= "" then
                    realm = arg2
                else
                    realm = GetNormalizedRealmName() -- assume they are on our realm
                end
            end
        end
        return name, realm, unit
    end

    ---@param level number @The level to test
    ---@param fallback boolean @If level isn't provided, we'll fallback to this boolean
    function util:IsMaxLevel(level, fallback)
        if level and type(level) == "number" then
            return level >= ns.MAX_LEVEL
        end
        return fallback
    end

    ---@param unit string
    ---@param fallback boolean @If unit isn't valid (doesn't exists or not a player), we'll fallback to this number
    function util:IsUnitMaxLevel(unit, fallback)
        if unit and UnitExists(unit) and UnitIsPlayer(unit) then
            return util:IsMaxLevel(UnitLevel(unit), fallback)
        end
        return fallback
    end

    ---@param arg1 string @"unit", "name", or "name-realm"
    ---@param arg2 string @"realm" or nil
    ---@param region string @Optional "us","kr","eu","tw","cn"
    ---@return boolean
    function util:IsUnitPlayer(arg1, arg2, region)
        local name, realm = util:GetNameRealm(arg1, arg2)
        return name == ns.PLAYER_NAME and realm == ns.PLAYER_REALM and (not region or region == ns.PLAYER_REGION)
    end

    ---@param bnetIDAccount number @BNet Account ID
    ---@param getAllChars boolean @true = table, false = character as varargs
    ---@return any @Returns either a table with all characters, or the specific character varargs with name, faction and level.
    function util:GetNameRealmForBNetFriend(bnetIDAccount, getAllChars)
        local index = BNGetFriendIndex(bnetIDAccount)
        if not index then
            return
        end
        local collection = {}
        local collectionIndex = 0
        for i = 1, C_BattleNet.GetFriendNumGameAccounts(index), 1 do
            local accountInfo = C_BattleNet.GetFriendGameAccountInfo(index, i)
            if accountInfo and accountInfo.clientProgram == BNET_CLIENT_WOW and (not accountInfo.wowProjectID or accountInfo.wowProjectID ~= WOW_PROJECT_CLASSIC) then
                if accountInfo.realmName then
                    accountInfo.characterName = accountInfo.characterName .. "-" .. accountInfo.realmName:gsub("%s+", "")
                end
                collectionIndex = collectionIndex + 1
                collection[collectionIndex] = {accountInfo.characterName, ns.FACTION_TO_ID[accountInfo.factionName], tonumber(accountInfo.characterLevel)}
            end
        end
        if not getAllChars then
            for i = 1, collectionIndex do
                local profile = collection[collectionIndex]
                local name, faction, level = profile[1], profile[2], profile[3]
                if util:IsMaxLevel(level) then
                    return name, faction, level
                end
            end
            return
        end
        return collection
    end

    ---@param playerLink string @The player link can be any valid clickable chat link for messaging
    ---@return string, string @Returns the name and realm, or nil for both if invalid
    function util:GetNameRealmFromPlayerLink(playerLink)
        local linkString, linkText = LinkUtil.SplitLink(playerLink)
        local linkType, linkData = ExtractLinkData(linkString)
        if linkType == "player" then
            return util:GetNameRealm(linkData)
        elseif linkType == "BNplayer" then
            local _, bnetIDAccount = strsplit(":", linkData)
            if bnetIDAccount then
                bnetIDAccount = tonumber(bnetIDAccount)
            end
            if bnetIDAccount then
                local fullName, _, level = util:GetNameRealmForBNetFriend(bnetIDAccount)
                local name, realm = util:GetNameRealm(fullName)
                return name, realm, level
            end
        end
    end

    ---@param text string @The text that might contain the keystone level
    ---@param fallback number @The fallback value in case we can't read the keystone level
    ---@return number|nil @The keystone level we think is detected or nil if we don't know
    function util:GetKeystoneLevelFromText(text, fallback)
        if type(text) ~= "string" then
            return
        end
        for _, pattern in ipairs(ns.KEYSTONE_LEVEL_PATTERN) do
            local level = text:match(pattern)
            if level then
                level = tonumber(level)
                if level and level > 0 and level < 100 then
                    return level
                end
            end
        end
        return fallback
    end

    ---@class LFDStatusResult
    ---@field dungeon Dungeon
    ---@field resultID number

    ---@class LFDStatus
    ---@field dungeon Dungeon
    ---@field hosting boolean
    ---@field queued boolean
    ---@field self LFDStatusResult[] @The LFDStatus itself is also a iterable table with the LFDStatusResult entries.

    ---@return LFDStatus
    function util:GetLFDStatus()
        ---@type LFDStatus
        local temp = { dungeon = nil, hosting = false, queued = false }
        local index = 0
        local activityInfo = C_LFGList.GetActiveEntryInfo()
        if activityInfo and activityInfo.activityID then
            temp.dungeon = util:GetDungeonByLFDActivityID(activityInfo.activityID)
            temp.hosting = true
        end
        local applications = C_LFGList.GetApplications()
        for _, resultID in ipairs(applications) do
            local searchResultInfo = C_LFGList.GetSearchResultInfo(resultID)
            if searchResultInfo and searchResultInfo.activityID and not searchResultInfo.isDelisted then
                local dungeon = util:GetDungeonByLFDActivityID(searchResultInfo.activityID)
                if dungeon then
                    local _, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(resultID)
                    if not pendingStatus and (appStatus == "applied" or appStatus == "invited") then
                        temp.dungeon = dungeon
                        temp.queued = true
                        index = index + 1
                        temp[index] = {
                            dungeon = dungeon,
                            resultID = resultID
                        }
                    end
                end
            end
        end
        if temp.dungeon or temp[1] then
            return temp
        end
    end

    ---@return Dungeon
    function util:GetInstanceStatus()
        local _, instanceType, _, _, _, _, _, instanceMapID = GetInstanceInfo()
        if instanceType ~= "party" then
            return
        end
        return util:GetDungeonByInstanceMapID(instanceMapID)
    end

    function util:GetLFDStatusForCurrentActivity(activityID)
        ---@type Dungeon
        local focusDungeon
        local activityDungeon = activityID and util:GetDungeonByLFDActivityID(activityID)
        if activityDungeon then
            focusDungeon = activityDungeon
        end
        if not focusDungeon then
            local lfd = util:GetLFDStatus()
            if lfd then
                focusDungeon = lfd.dungeon
            end
        end
        if not focusDungeon then
            local instanceDungeon = util:GetInstanceStatus()
            if instanceDungeon then
                focusDungeon = instanceDungeon
            end
        end
        return focusDungeon
    end

    local SCORE_TIER = ns:GetScoreTiersData()
    local SCORE_TIER_SIMPLE = ns:GetScoreTiersSimpleData()
    local SCORE_TIER_PREV = ns:GetScoreTiersPrevData()
    local SCORE_TIER_PREV_SIMPLE = ns:GetScoreTiersSimplePrevData()
    local SCORE_STATS = ns:GetScoreStatsData()

    ---@param score number @the score amount we wish to get a color for.
    ---@param isPreviousSeason boolean @true to show colors based on the previous season color scheme, otherwise false to use this seasons color scheme.
    ---@return number, number, number @r, g, b
    function util:GetScoreColor(score, isPreviousSeason)
        -- if no or empty score or the settings do not let us color scores return white color
        if not config:IsEnabled() or not score or score == 0 or config:Get("disableScoreColors") then
            return 1, 1, 1
        end
        -- pick the current or previous season color data
        local colors = isPreviousSeason and SCORE_TIER_PREV or SCORE_TIER
        local colorsSimple = isPreviousSeason and SCORE_TIER_PREV_SIMPLE or SCORE_TIER_SIMPLE
        -- if simple colors are enabled we use the simple color table
        if config:Get("showSimpleScoreColors") then
            local quality = 1
            for i = 1, #colorsSimple do
                local tier = colorsSimple[i]
                if score >= tier.score then
                    quality = tier.quality
                    break
                end
            end
            local r, g, b = GetItemQualityColor(quality)
            return r, g, b
        end
        -- otherwise we use regular color table
        for i = 1, #colors do
            local tier = colors[i]
            if score >= tier.score then
                return tier.color[1], tier.color[2], tier.color[3]
            end
        end
        -- fallback to gray color if nothing else returned anything
        return 0.62, 0.62, 0.62
    end

    ---@param chests number @the amount of chests/upgrades at the end of the keystone run. returns a string containing stars representing each chest/upgrade.
    function util:GetNumChests(chests)
        local stars = ""
        if chests < 1 then
            return stars
        end
        for i = 1, chests do
            stars = stars .. "+"
        end
        return "|cffffcf40" .. stars .. "|r"
    end

    ---@param chests number @the amount of chests/upgrades at the end of the keystone run. returns the color representing the depletion or timed result.
    function util:GetKeystoneChestColor(chests)
        if not chests or chests < 1 then
            return 0.62, 0.62, 0.62
        end
        return 1, 1, 1
    end

    ---@param level number @The keystone level.
    function util:GetKeystoneAverageScoreForLevel(level)
        return SCORE_STATS[level]
    end

end

-- json.lua
-- dependencies: module, callback, util
do

    ---@class JSONModule : Module
    local json = ns:NewModule("JSON") ---@type JSONModule
    local callback = ns:GetModule("Callback") ---@type CallbackModule
    local util = ns:GetModule("Util") ---@type UtilModule

    local function IsArray(o)
        if not o[1] then
            return false
        end
        local i
        for k = 1, #o do
            local v = o[k]
            if type(k) ~= "number" then
                return false
            end
            if i and i ~= k - 1 then
                return false
            end
            i = k
        end
        return true
    end

    local function IsMap(o)
        return not not (not IsArray(o) and next(o))
    end

    local TableToJSON

    local function WrapValue(o)
        local t = type(o)
        local s = ""
        if t == "nil" then
            s = "null"
        elseif t == "number" then
            s = o
        elseif t == "boolean" then
            s = o and "true" or "false"
        elseif t == "table" then
            s = TableToJSON(o)
        else
            s = "\"" .. tostring(o) .. "\""
        end
        return s
    end

    function TableToJSON(o)
        if type(o) == "table" then
            local s = ""
            if IsMap(o) then
                s = s .. "{"
                for k, v in pairs(o) do
                    s = s .. "\"" .. tostring(k) .. "\":" .. WrapValue(v) .. ","
                end
                if s:sub(-1) == "," then
                    s = s:sub(1, -2)
                end
                s = s .. "}"
            else
                s = s .. "["
                for i = 1, #o do
                    local v = o[i]
                    s = s .. WrapValue(v) .. ","
                end
                if s:sub(-1) == "," then
                    s = s:sub(1, -2)
                end
                s = s .. "]"
            end
            return s
        end
        return o
    end

    local exportButton
    local exportPopup = {
        id = "RAIDERIO_EXPORTJSON_DIALOG",
        text = L.EXPORTJSON_COPY_TEXT,
        button2 = CLOSE,
        hasEditBox = true,
        hasWideEditBox = true,
        editBoxWidth = 350,
        preferredIndex = 3,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnShow = function() json:OpenCopyDialog() end,
        OnHide = function() json:CloseCopyDialog() end,
        OnAccept = nil,
        OnCancel = nil,
        EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end
    }

    local RoleNameToBit = {
        TANK = 4,
        HEALER = 2,
        DAMAGER = 1,
        NONE = 0
    }

    local function GetUnitRole(unit)
        local role = UnitGroupRolesAssigned(unit)
        return role and RoleNameToBit[role] or RoleNameToBit.NONE
    end

    local function GetQueuedRole(tank, heal, dps)
        local role1 = tank and "TANK" or (heal and "HEALER" or (dps and "DAMAGER"))
        local role2 = (tank and heal and "HEALER") or ((tank or heal) and dps and "DAMAGER")
        local role3 = tank and heal and dps and "DAMAGER"
        local role = RoleNameToBit.NONE
        if role1 == "TANK" or role2 == "TANK" or role3 == "TANK" then
            if band(role, RoleNameToBit.TANK) ~= RoleNameToBit.TANK then
                role = bor(role, RoleNameToBit.TANK)
            end
        end
        if role1 == "HEALER" or role2 == "HEALER" or role3 == "HEALER" then
            if band(role, RoleNameToBit.HEALER) ~= RoleNameToBit.HEALER then
                role = bor(role, RoleNameToBit.HEALER)
            end
        end
        if role1 == "DAMAGER" or role2 == "DAMAGER" or role3 == "DAMAGER" then
            if band(role, RoleNameToBit.DAMAGER) ~= RoleNameToBit.DAMAGER then
                role = bor(role, RoleNameToBit.DAMAGER)
            end
        end
        return role
    end

    local function GetGroupData(unitPrefix, startIndex, endIndex)
        local group = {}
        local index = 0
        for i = startIndex, endIndex do
            local unit = i == 0 and "player" or unitPrefix .. i
            if util:IsUnitMaxLevel(unit) then
                local name, realm = util:GetNameRealm(unit)
                if name then
                    index = index + 1
                    group[index] = format("%d-%s-%s", GetUnitRole(unit), name, util:GetRealmSlug(realm, true))
                end
            end
        end
        if index > 0 then
            return group
        end
    end

    local function GetApplicantsData()
        local group = {}
        local index = 0
        local applicants = C_LFGList.GetApplicants()
        for i = 1, #applicants do
            local applicantInfo = C_LFGList.GetApplicantInfo(applicants[i])
            local applicantGroup
            for j = 1, applicantInfo.numMembers do
                local fullName, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage, assignedRole, relationship = C_LFGList.GetApplicantMemberInfo(applicantInfo.applicantID, j)
                local name, realm = util:GetNameRealm(fullName)
                if name then
                    local role = GetQueuedRole(tank, healer, damage)
                    if not applicantGroup then
                        applicantGroup = {}
                    end
                    applicantGroup[#applicantGroup + 1] = format("%d-%s-%s", role, name, util:GetRealmSlug(realm, true))
                end
            end
            if applicantGroup then
                index = index + 1
                if applicantGroup[2] then
                    group[index] = applicantGroup
                else
                    group[index] = applicantGroup[1]
                end
            end
        end
        if index > 0 then
            return group
        end
    end

    local function GetJSON()
        local data = {
            activity = 0,
            region = ns.PLAYER_REGION
        }
        local unitPrefix
        local startIndex = 1
        local endIndex = GetNumGroupMembers()
        if IsInRaid() then
            unitPrefix = "raid"
        elseif IsInGroup() then
            unitPrefix = "party"
            startIndex = 0
            endIndex = endIndex - 1 
        end
        if unitPrefix then
            data.group = GetGroupData(unitPrefix, startIndex, endIndex)
        end
        local entry = C_LFGList.GetActiveEntryInfo()
        if entry and entry.activityID then
            data.activity = entry.activityID
            data.queue = GetApplicantsData()
        end
        return TableToJSON(data)
    end

    local function CanShowCopyDialog()
        local hasGroupMembers = (IsInRaid() or IsInGroup()) and GetNumGroupMembers() > 1
        local entry = C_LFGList.GetActiveEntryInfo()
        local _, numApplicants = C_LFGList.GetNumApplications()
        return not not (hasGroupMembers or entry or numApplicants > 0)
    end

    local function UpdateCopyDialog()
        local canShow = CanShowCopyDialog()
        exportButton:SetShown(canShow)
        if not canShow then
            json:CloseCopyDialog()
            return false
        end
        local frameName, frame = StaticPopup_Visible(exportPopup.id)
        if not frame then
            return false
        end
        local editBox = _G[frameName .. "WideEditBox"] or _G[frameName .. "EditBox"]
        frame:SetWidth(420)
        editBox:SetText(canShow and GetJSON() or "")
        editBox:SetFocus()
        editBox:HighlightText(false)
        local button = _G[frameName .. "Button2"]
        button:ClearAllPoints()
        button:SetWidth(200)
        button:SetPoint("CENTER", editBox, "CENTER", 0, -30)
        return true
    end

    local function CreateExportButton()
        local button = CreateFrame("Button", addonName .. "_ExportButton", _G.LFGListFrame)
        button:SetPoint("BOTTOMRIGHT", button:GetParent(), "BOTTOM", 4, 6)
        button:SetSize(16, 16)
        -- script handlers
        button:SetScript("OnEnter", function() button.Border:SetVertexColor(1, 1, 1) end)
        button:SetScript("OnLeave", function() button.Border:SetVertexColor(.8, .8, .8) end)
        button:SetScript("OnClick", function() json:ToggleCopyDialog() end)
        -- icon
        do
            button.Icon = button:CreateTexture(nil, "ARTWORK")
            button.Icon:SetAllPoints()
            button.Icon:SetMask("Interface\\Minimap\\UI-Minimap-Background")
            button.Icon:SetTexture("Interface\\Minimap\\Tracking\\None")
        end
        -- border
        do
            button.Border = button:CreateTexture(nil, "BACKGROUND")
            button.Border:SetPoint("TOPLEFT", -2, 2)
            button.Border:SetSize(36, 36)
            button.Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
            button.Border:SetVertexColor(.8, .8, .8)
        end
        -- return button widget
        return button
    end

    local function PreparePopup(popup)
        if type(popup.text) == "function" then
            popup.text = popup.text()
        end
        return popup
    end

    function json:CanLoad()
        return not exportButton and _G.LFGListFrame
    end

    function json:OnLoad()
        self:Enable()
        exportButton = CreateExportButton()
        StaticPopupDialogs[exportPopup.id] = PreparePopup(exportPopup)
        callback:RegisterEvent(UpdateCopyDialog, "GROUP_ROSTER_UPDATE", "LFG_LIST_ACTIVE_ENTRY_UPDATE", "LFG_LIST_APPLICANT_LIST_UPDATED", "LFG_LIST_APPLICANT_UPDATED", "PLAYER_ENTERING_WORLD", "PLAYER_ROLES_ASSIGNED", "PLAYER_SPECIALIZATION_CHANGED")
    end

    function json:TableToJSON(data)
        return TableToJSON(data)
    end

    function json:ToggleCopyDialog()
        if not self:IsEnabled() then
            return
        end
        if not StaticPopup_Visible(exportPopup.id) then
            json:OpenCopyDialog()
        else
            json:CloseCopyDialog()
        end
    end

    function json:OpenCopyDialog()
        if not self:IsEnabled() then
            return
        end
        local _, frame = StaticPopup_Visible(exportPopup.id)
        if frame then
            UpdateCopyDialog()
            return
        end
        frame = StaticPopup_Show(exportPopup.id)
    end

    function json:CloseCopyDialog()
        if not self:IsEnabled() then
            return
        end
        local _, frame = StaticPopup_Visible(exportPopup.id)
        if not frame then
            return
        end
        StaticPopup_Hide(exportPopup.id)
    end

end

-- dropdown.lua
-- dependencies: module, config, util + LibDropDownExtension
do

    ---@class DropDownModule : Module
    local dropdown = ns:NewModule("DropDown") ---@type DropDownModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule

    local copyUrlPopup = {
        id = "RAIDERIO_COPY_URL",
        text = "%s",
        button2 = CLOSE,
        hasEditBox = true,
        hasWideEditBox = true,
        editBoxWidth = 350,
        preferredIndex = 3,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnShow = function(self)
            self:SetWidth(420)
            local editBox = _G[self:GetName() .. "WideEditBox"] or _G[self:GetName() .. "EditBox"]
            editBox:SetText(self.text.text_arg2)
            editBox:SetFocus()
            editBox:HighlightText(false)
            local button = _G[self:GetName() .. "Button2"]
            button:ClearAllPoints()
            button:SetWidth(200)
            button:SetPoint("CENTER", editBox, "CENTER", 0, -30)
        end,
        EditBoxOnEscapePressed = function(self)
            self:GetParent():Hide()
        end,
        OnHide = nil,
        OnAccept = nil,
        OnCancel = nil
    }

    local validTypes = {
        ARENAENEMY = true,
        BN_FRIEND = true,
        CHAT_ROSTER = true,
        COMMUNITIES_GUILD_MEMBER = true,
        COMMUNITIES_WOW_MEMBER = true,
        FOCUS = true,
        FRIEND = true,
        GUILD = true,
        GUILD_OFFLINE = true,
        PARTY = true,
        PLAYER = true,
        RAID = true,
        RAID_PLAYER = true,
        SELF = true,
        TARGET = true,
        WORLD_STATE_SCORE = true
    }

    -- if the dropdown is a valid type of dropdown then we mark it as acceptable to check for a unit on it
    local function IsValidDropDown(bdropdown)
        return (bdropdown == LFGListFrameDropDown and config:Get("enableLFGDropdown")) or (type(bdropdown.which) == "string" and validTypes[bdropdown.which])
    end

    -- get name and realm from dropdown or nil if it's not applicable
    local function GetNameRealmForDropDown(bdropdown)
        local unit = bdropdown.unit
        local bnetIDAccount = bdropdown.bnetIDAccount
        local menuList = bdropdown.menuList
        local quickJoinMember = bdropdown.quickJoinMember
        local quickJoinButton = bdropdown.quickJoinButton
        local clubMemberInfo = bdropdown.clubMemberInfo
        local tempName, tempRealm = bdropdown.name, bdropdown.server
        local name, realm, level
        -- unit
        if not name and UnitExists(unit) then
            if UnitIsPlayer(unit) then
                name, realm = util:GetNameRealm(unit)
                level = UnitLevel(unit)
            end
            -- if it's not a player it's pointless to check further
            return name, realm, level
        end
        -- bnet friend
        if not name and bnetIDAccount then
            local fullName, _, charLevel = util:GetNameRealmForBNetFriend(bnetIDAccount)
            if fullName then
                name, realm = util:GetNameRealm(fullName)
                level = charLevel
            end
            -- if it's a bnet friend we assume if eligible the name and realm is set, otherwise we assume it's not eligible for a url
            return name, realm, level
        end
        -- lfd
        if not name and menuList then
            for i = 1, #menuList do
                local whisperButton = menuList[i]
                if whisperButton and (whisperButton.text == _G.WHISPER_LEADER or whisperButton.text == _G.WHISPER) then
                    name, realm = util:GetNameRealm(whisperButton.arg1)
                    break
                end
            end
        end
        -- quick join
        if not name and (quickJoinMember or quickJoinButton) then
            local memberInfo = quickJoinMember or quickJoinButton.Members[1]
            if memberInfo.playerLink then
                name, realm, level = util:GetNameRealmFromPlayerLink(memberInfo.playerLink)
            end
        end
        -- dropdown by name and realm
        if not name and tempName then
            name, realm = util:GetNameRealm(tempName, tempRealm)
            if clubMemberInfo and clubMemberInfo.level and (clubMemberInfo.clubType == Enum.ClubType.Guild or clubMemberInfo.clubType == Enum.ClubType.Character) then
                level = clubMemberInfo.level
            end
        end
        -- if we don't got both we return nothing
        if not name or not realm then
            return
        end
        return name, realm, level
    end

    -- converts the name and realm into a copyable link
    local function ShowCopyDialog(name, realm)
        local realmSlug = util:GetRealmSlug(realm, true)
        local url = format("https://raider.io/characters/%s/%s/%s?utm_source=addon", ns.PLAYER_REGION, realmSlug, name)
        if IsModifiedClick("CHATLINK") then
            local editBox = ChatFrame_OpenChat(url, DEFAULT_CHAT_FRAME)
            editBox:HighlightText()
        else
            StaticPopup_Show(copyUrlPopup.id, format("%s (%s)", name, realm), url)
        end
    end

    -- tracks the currently active dropdown name and realm for lookup
    local selectedName, selectedRealm, selectedLevel

    ---@type CustomDropDownOption[]
    local unitOptions

    ---@param options CustomDropDownOption[]
    local function OnToggle(bdropdown, event, options, level, data)
        if event == "OnShow" then
            if not config:Get("showDropDownCopyURL") then
                return
            end
            if not IsValidDropDown(bdropdown) then
                return
            end
            selectedName, selectedRealm, selectedLevel = GetNameRealmForDropDown(bdropdown)
            if not selectedName or not util:IsMaxLevel(selectedLevel, true) then
                return
            end
            if not options[1] then
                for i = 1, #unitOptions do
                    options[i] = unitOptions[i]
                end
                return true
            end
        elseif event == "OnHide" then
            if options[1] then
                for i = #options, 1, -1 do
                    options[i] = nil
                end
                return true
            end
        end
    end

    ---@type LibDropDownExtension
    local LibDropDownExtension = LibStub and LibStub:GetLibrary("LibDropDownExtension-1.0", true)

    function dropdown:CanLoad()
        return LibDropDownExtension
    end

    function dropdown:OnLoad()
        self:Enable()
        unitOptions = {
            {
                text = L.COPY_RAIDERIO_PROFILE_URL,
                func = function()
                    ShowCopyDialog(selectedName, selectedRealm)
                end
            }
        }
        LibDropDownExtension:RegisterEvent("OnShow OnHide", OnToggle, 1, dropdown)
        StaticPopupDialogs[copyUrlPopup.id] = copyUrlPopup
    end

end

-- provider.lua
-- dependencies: module, callback, config, util
do

    ---@class ProviderModule : Module
    local provider = ns:NewModule("Provider") ---@type ProviderModule
    local callback = ns:GetModule("Callback") ---@type CallbackModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule

    ---@class Raid
    ---@field public name string
    ---@field public shortName string
    ---@field public bossCount number

    ---@class DataProviderMythicKeystone
    ---@field public currentSeasonId number
    ---@field public numCharacters number
    ---@field public recordSizeInBytes number
    ---@field public encodingOrder number[]

    -- hack to implement both keystone and raid classes on the dataprovider below so we do this weird inheritance
    ---@class DataProviderRaid : DataProviderMythicKeystone
    ---@field public currentRaid Raid
    ---@field public previousRaid Raid

    ---@class DataProvider : DataProviderRaid
    ---@field public name string
    ---@field public data number @1 (mythic_keystone), 2 (raid), 3 (pvp)
    ---@field public region string @"eu", "kr", "tw", "us"
    ---@field public faction number @1 (alliance), 2 (horde)
    ---@field public date string @"2017-06-03T00:41:07Z"
    ---@field public db1 table
    ---@field public lookup1 table
    ---@field public db2 table
    ---@field public lookup2 table
    ---@field public queued boolean @Added dynamically in AddProvider - true when added, later set to false once past the queue check
    ---@field public desynced boolean @Added dynamically in AddProvider - nil or true if provider tables are desynced
    ---@field public outdated number @Added dynamically in AddProvider - nil or number of seconds past our time()
    ---@field public blocked number @Added dynamically in AddProvider - nil or number of seconds past our time()
    ---@field public blockedPurged boolean @Added dynamically in AddProvider - if true it means the provider is just an empty shell without any data

    ---@type DataProvider[]
    local providers = {}

    local function CheckQueuedProviders()
        local desynced
        local outdated
        local blocked
        for i = #providers, 1, -1 do
            local provider = providers[i]
            if provider.queued then
                provider.queued = false
                if provider.desynced then
                    desynced = true
                end
                if provider.blocked then
                    blocked = true
                elseif provider.outdated then
                    outdated = outdated and max(outdated, provider.outdated) or provider.outdated
                end
                if not config:Get("debugMode") then
                    if provider.region ~= ns.PLAYER_REGION then
                        DisableAddOn(provider.name)
                        table.wipe(provider)
                        table.remove(providers, i)
                    elseif provider.blocked and provider.data == ns.PROVIDER_DATA_TYPE.MythicKeystone and false then -- TODO: do not purge the data just keep it labeled as blocked this way we can always lookup the players own data and still show the warning that its expired
                        provider.blockedPurged = true
                        if provider.db1 then table.wipe(provider.db1) end
                        if provider.db2 then table.wipe(provider.db2) end
                        if provider.lookup1 then table.wipe(provider.lookup1) end
                        if provider.lookup2 then table.wipe(provider.lookup2) end
                    end
                end
            end
        end
        if desynced then
            ns.Print(format(L.OUT_OF_SYNC_DATABASE_S, addonName))
        elseif blocked or outdated then
            ns.Print(format(L.OUTDATED_EXPIRED_ALERT, addonName, ns.RAIDERIO_ADDON_DOWNLOAD_URL))
        elseif not providers[1] then
            ns.Print(format(L.PROVIDER_NOT_LOADED, addonName, ns.PLAYER_FACTION_TEXT))
        end
    end

    local function OnPlayerLogin()
        CheckQueuedProviders()
        provider:Enable()
    end

    function provider:OnLoad()
        callback:RegisterEventOnce(OnPlayerLogin, "RAIDERIO_PLAYER_LOGIN")
    end

    function provider:GetProviders()
        return providers
    end

    function provider:GetProviderByType(providerDataType)
        for i = 1, #providers do
            local provider = providers[i]
            if provider.data == providerDataType then
                return provider
            end
        end
    end

    function provider:GetProvidersDates()
        local keystoneDate, raidDate, pvpDate
        for i = 1, #providers do
            local provider = providers[i]
            if provider.data == ns.PROVIDER_DATA_TYPE.MythicKeystone then
                if not keystoneDate or keystoneDate < provider.date then
                    keystoneDate = provider.date
                end
            elseif provider.data == ns.PROVIDER_DATA_TYPE.Raid then
                if not raidDate or raidDate < provider.date then
                    raidDate = provider.date
                end
            elseif provider.data == ns.PROVIDER_DATA_TYPE.PvP then
                if not pvpDate or pvpDate < provider.date then
                    pvpDate = provider.date
                end
            end
        end
        return keystoneDate, raidDate, pvpDate
    end

    ---@param dateString string @The date string from the provider
    ---@return number, boolean @arg1 is seconds difference between now and the date in the provider. arg2 is true if we should block from showing data from this provider
    local function GetOutdatedAndBlockState(dateString)
        local dateAsTime = util:GetTimeFromDateString(dateString)
        local tzOffset = util:GetTimeZoneOffset(dateAsTime)
        local timeDiff = time() - dateAsTime - tzOffset
        if timeDiff > ns.OUTDATED_CUTOFF then
            if timeDiff > ns.OUTDATED_BLOCK_CUTOFF then
                return timeDiff - ns.OUTDATED_BLOCK_CUTOFF, timeDiff > ns.OUTDATED_BLOCK_CUTOFF
            end
            return timeDiff - ns.OUTDATED_CUTOFF
        end
    end

    local function GetExistingProvider(dataType, region, faction)
        for i = 1, #providers do
            local provider = providers[i]
            if provider.data == dataType and provider.region == region and provider.faction == faction then
                return provider
            end
        end
    end

    ---@param data DataProvider
    function provider:AddProvider(data)
        -- we only add providers until we enter the world, then we stop accepting additional providers as we are considered done loading
        if self:IsEnabled() then
            return false
        end
        -- sanity check that the data structure is as we expect it to be
        assert(type(data) == "table", "Raider.IO Provider expects Add(data) where data is a table.")
        assert(type(data.name) == "string" and type(data.data) == "number" and type(data.region) == "string" and type(data.faction) == "number" and type(data.date) == "string", "Raider.IO Provider expects AddProvider(data) where data is a table and has the appropriate structure expected of a data provider.")
        -- expand with additional information
        data.outdated, data.blocked = GetOutdatedAndBlockState(data.date)
        data.queued = true
        -- find existing provider table and expand it, otherwise insert new table
        local provider = GetExistingProvider(data.data, data.region, data.faction)
        if provider then
            if provider.date ~= data.date then
                provider.desynced = true
            end
            for k, v in pairs(data) do
                provider[k] = provider[k] or v
            end
            table.wipe(data)
        else
            table.insert(providers, data)
        end
        -- we successfully added the new provider
        return true
    end

    local function BinarySearchGetIndexFromName(data, name, startIndex, endIndex)
        local minIndex = startIndex
        local maxIndex = endIndex
        local mid, current

        while minIndex <= maxIndex do
            mid = floor((maxIndex + minIndex) / 2)
            current = data[mid]
            if current == name then
                return mid
            elseif current < name then
                minIndex = mid + 1
            else
                maxIndex = mid - 1
            end
        end
    end

    -- TODO: can this be part of the provider? we can see if we can make a more dynamic system
    local ENCODER_MYTHICPLUS_FIELDS = {
        CURRENT_SCORE       = 1,  -- current season score
        CURRENT_ROLES       = 2,  -- current season roles
        PREVIOUS_SCORE      = 3,  -- previous season score
        PREVIOUS_ROLES      = 4,  -- previous season roles
        MAIN_CURRENT_SCORE  = 5,  -- main's current season score
        MAIN_CURRENT_ROLES  = 6,  -- main's current season roles
        MAIN_PREVIOUS_SCORE = 7,  -- main's previous season score
        MAIN_PREVIOUS_ROLES = 8,  -- main's previous season roles
        DUNGEON_RUN_COUNTS  = 9,  -- number of runs this season for 5+, 10+, 15+, and 20+
        DUNGEON_LEVELS      = 10, -- dungeon levels and stars for each dungeon completed
        DUNGEON_BEST_INDEX  = 11  -- best dungeon index
    }

    ---@param provider DataProvider
    ---@return table, number, string
    local function SearchForBucketByName(provider, lookup, data, name, realm)
        local realmData = data[realm]
        if not realmData then
            return
        end
        local nameIndex = BinarySearchGetIndexFromName(realmData, name, 2, #realmData)
        if not nameIndex then
            return
        end
        local bucket, baseOffset, guid
        if provider.data == ns.PROVIDER_DATA_TYPE.MythicKeystone then
            local bucketID = 1
            bucket = lookup[bucketID]
            baseOffset = 1 + realmData[1] + (nameIndex - 2) * provider.recordSizeInBytes
            guid = provider.data .. ":" .. provider.region .. ":" .. provider.faction .. ":" .. bucketID .. ":" .. baseOffset
        elseif provider.data == ns.PROVIDER_DATA_TYPE.Raid then
            local numFieldsPerCharacter = 2
            local lookupMaxSize = floor(ns.LOOKUP_MAX_SIZE / numFieldsPerCharacter) * numFieldsPerCharacter
            local bucketOffset = realmData[1] + (nameIndex - 2) * numFieldsPerCharacter
            local bucketID = 1 + floor(bucketOffset / lookupMaxSize)
            bucket = lookup[bucketID]
            baseOffset = 1 + bucketOffset - (bucketID - 1) * lookupMaxSize
            guid = provider.data .. ":" .. provider.region .. ":" .. provider.faction .. ":" .. bucketID .. ":" .. baseOffset
        elseif provider.data == ns.PROVIDER_DATA_TYPE.PvP then
            -- TODO
        end
        return bucket, baseOffset, guid, name, realm
    end

    local function ReadBitsFromString(data, offset, length)
        local value = 0
        local readOffset = 0
        local firstByteShift = offset % 8
        local bytesToRead = ceil((length + firstByteShift) / 8)
        while readOffset < length do
            local byte = strbyte(data, 1 + floor((offset + readOffset) / 8))
            local bitsRead = 0
            if readOffset == 0 then
                if bytesToRead == 1 then
                    local availableBits = length - readOffset
                    value = band(rshift(byte, firstByteShift), ((lshift(1, availableBits)) - 1))
                    bitsRead = length
                else
                    value = rshift(byte, firstByteShift)
                    bitsRead = 8 - firstByteShift
                end
            else
                local availableBits = length - readOffset
                if availableBits < 8 then
                    value = value + lshift(band(byte, (lshift(1, availableBits) - 1)), readOffset)
                    bitsRead = bitsRead + availableBits
                else
                    value = value + lshift(byte, readOffset)
                    bitsRead = bitsRead + min(8, length)
                end
            end
            readOffset = readOffset + bitsRead
        end
        return value, offset + readOffset
    end

    local function DecodeBits6(value)
        if value < 10 then
            return value
        end
        return 10 + (value - 10) * 5
    end

    local function DecodeBits7(value)
        if value < 20 then
            return value
        end
        return 20 + (value - 20) * 4
    end

    local function Split64BitNumber(dword)
        local lo = band(dword, 0xfffffffff)
        return lo, (dword - lo) / 0x100000000
    end

    local function ReadBits(lo, hi, offset, bits)
        if offset < 32 and (offset + bits) > 32 then
            local mask = lshift(1, (offset + bits) - 32) - 1
            local p1 = rshift(lo, offset)
            local p2 = lshift(band(hi, mask), 32 - offset)
            return p1 + p2, offset + bits
        end
        local mask = lshift(1, bits) - 1
        if offset < 32 then
            return band(rshift(lo, offset), mask), offset + bits
        end
        return band(rshift(hi, offset - 32), mask), offset + bits
    end

    local DECODE_BITS_2_TABLE = { 0, 1, 2, 5 }

    local function DecodeBits2(value)
        return DECODE_BITS_2_TABLE[1 + value] or 0
    end

    -- TODO: can this be part of the provider? we can see if we can make a more dynamic system
    ---@class OrderedRolesItem
    ---@field public pos1 string @"tank","healer","dps"
    ---@field public pos2 string @"full","partial"
    local ORDERED_ROLES = {
        { },
        { {"dps","full"}, },
        { {"dps","full"}, {"healer","full"}, },
        { {"dps","full"}, {"healer","full"}, {"tank","full"}, },
        { {"dps","full"}, {"healer","full"}, {"tank","partial"}, },
        { {"dps","full"}, {"healer","partial"}, },
        { {"dps","full"}, {"healer","partial"}, {"tank","full"}, },
        { {"dps","full"}, {"healer","partial"}, {"tank","partial"}, },
        { {"dps","full"}, {"tank","full"}, },
        { {"dps","full"}, {"tank","full"}, {"healer","full"}, },
        { {"dps","full"}, {"tank","full"}, {"healer","partial"}, },
        { {"dps","full"}, {"tank","partial"}, },
        { {"dps","full"}, {"tank","partial"}, {"healer","full"}, },
        { {"dps","full"}, {"tank","partial"}, {"healer","partial"}, },
        { {"dps","partial"}, },
        { {"dps","partial"}, {"healer","full"}, },
        { {"dps","partial"}, {"healer","full"}, {"tank","full"}, },
        { {"dps","partial"}, {"healer","full"}, {"tank","partial"}, },
        { {"dps","partial"}, {"healer","partial"}, },
        { {"dps","partial"}, {"healer","partial"}, {"tank","full"}, },
        { {"dps","partial"}, {"healer","partial"}, {"tank","partial"}, },
        { {"dps","partial"}, {"tank","full"}, },
        { {"dps","partial"}, {"tank","full"}, {"healer","full"}, },
        { {"dps","partial"}, {"tank","full"}, {"healer","partial"}, },
        { {"dps","partial"}, {"tank","partial"}, },
        { {"dps","partial"}, {"tank","partial"}, {"healer","full"}, },
        { {"dps","partial"}, {"tank","partial"}, {"healer","partial"}, },
        { {"healer","full"}, },
        { {"healer","full"}, {"dps","full"}, },
        { {"healer","full"}, {"dps","full"}, {"tank","full"}, },
        { {"healer","full"}, {"dps","full"}, {"tank","partial"}, },
        { {"healer","full"}, {"dps","partial"}, },
        { {"healer","full"}, {"dps","partial"}, {"tank","full"}, },
        { {"healer","full"}, {"dps","partial"}, {"tank","partial"}, },
        { {"healer","full"}, {"tank","full"}, },
        { {"healer","full"}, {"tank","full"}, {"dps","full"}, },
        { {"healer","full"}, {"tank","full"}, {"dps","partial"}, },
        { {"healer","full"}, {"tank","partial"}, },
        { {"healer","full"}, {"tank","partial"}, {"dps","full"}, },
        { {"healer","full"}, {"tank","partial"}, {"dps","partial"}, },
        { {"healer","partial"}, },
        { {"healer","partial"}, {"dps","full"}, },
        { {"healer","partial"}, {"dps","full"}, {"tank","full"}, },
        { {"healer","partial"}, {"dps","full"}, {"tank","partial"}, },
        { {"healer","partial"}, {"dps","partial"}, },
        { {"healer","partial"}, {"dps","partial"}, {"tank","full"}, },
        { {"healer","partial"}, {"dps","partial"}, {"tank","partial"}, },
        { {"healer","partial"}, {"tank","full"}, },
        { {"healer","partial"}, {"tank","full"}, {"dps","full"}, },
        { {"healer","partial"}, {"tank","full"}, {"dps","partial"}, },
        { {"healer","partial"}, {"tank","partial"}, },
        { {"healer","partial"}, {"tank","partial"}, {"dps","full"}, },
        { {"healer","partial"}, {"tank","partial"}, {"dps","partial"}, },
        { {"tank","full"}, },
        { {"tank","full"}, {"dps","full"}, },
        { {"tank","full"}, {"dps","full"}, {"healer","full"}, },
        { {"tank","full"}, {"dps","full"}, {"healer","partial"}, },
        { {"tank","full"}, {"dps","partial"}, },
        { {"tank","full"}, {"dps","partial"}, {"healer","full"}, },
        { {"tank","full"}, {"dps","partial"}, {"healer","partial"}, },
        { {"tank","full"}, {"healer","full"}, },
        { {"tank","full"}, {"healer","full"}, {"dps","full"}, },
        { {"tank","full"}, {"healer","full"}, {"dps","partial"}, },
        { {"tank","full"}, {"healer","partial"}, },
        { {"tank","full"}, {"healer","partial"}, {"dps","full"}, },
        { {"tank","full"}, {"healer","partial"}, {"dps","partial"}, },
        { {"tank","partial"}, },
        { {"tank","partial"}, {"dps","full"}, },
        { {"tank","partial"}, {"dps","full"}, {"healer","full"}, },
        { {"tank","partial"}, {"dps","full"}, {"healer","partial"}, },
        { {"tank","partial"}, {"dps","partial"}, },
        { {"tank","partial"}, {"dps","partial"}, {"healer","full"}, },
        { {"tank","partial"}, {"dps","partial"}, {"healer","partial"}, },
        { {"tank","partial"}, {"healer","full"}, },
        { {"tank","partial"}, {"healer","full"}, {"dps","full"}, },
        { {"tank","partial"}, {"healer","full"}, {"dps","partial"}, },
        { {"tank","partial"}, {"healer","partial"}, },
        { {"tank","partial"}, {"healer","partial"}, {"dps","full"}, },
        { {"tank","partial"}, {"healer","partial"}, {"dps","partial"}, },
    }

    ---@class DataProviderMythicKeystoneScore
    ---@field public season number @The previous season number, otherwise nil if current season
    ---@field public score number @The score amount
    ---@field public roles OrderedRolesItem[] @table of roles associated with the score

    ---@class DataProviderMythicKeystoneProfile
    ---@field public outdated number|nil @number or nil
    ---@field public hasRenderableData boolean @True if we have any actual data to render in the tooltip without the profile appearing incomplete or empty.
    ---@field public blocked number|nil @number or nil
    ---@field public blockedPurged boolean|nil @True if the provider has been blocked and purged
    ---@field public softBlocked number|nil @number or nil - Only defined when the profile looked up is the players own profile
    ---@field public isEnhanced boolean|nil @true if client enhanced data (fractionalTime and .dungeonTimes are 1 for timed and 3 for depleted, but when enhanced it's the actual time fraction)
    ---@field public currentScore number
    ---@field public currentRoleOrdinalIndex number
    ---@field public previousScore number
    ---@field public previousScoreSeason number
    ---@field public previousRoleOrdinalIndex number
    ---@field public mainCurrentScore number
    ---@field public mainCurrentRoleOrdinalIndex number
    ---@field public mainPreviousScore number
    ---@field public mainPreviousScoreSeason number
    ---@field public mainPreviousRoleOrdinalIndex number
    ---@field public keystoneFivePlus number
    ---@field public keystoneTenPlus number
    ---@field public keystoneFifteenPlus number
    ---@field public keystoneTwentyPlus number
    ---@field public dungeons number[]
    ---@field public dungeonUpgrades number[]
    ---@field public dungeonTimes number[]
    ---@field public maxDungeonIndex number
    ---@field public maxDungeonLevel number
    ---@field public maxDungeon Dungeon
    ---@field public sortedDungeons SortedDungeon[]
    ---@field public sortedMilestones SortedMilestone[]
    ---@field public mplusCurrent DataProviderMythicKeystoneScore
    ---@field public mplusPrevious DataProviderMythicKeystoneScore
    ---@field public mplusMainCurrent DataProviderMythicKeystoneScore
    ---@field public mplusMainPrevious DataProviderMythicKeystoneScore

    ---@class SortedDungeon
    ---@field public dungeon Dungeon
    ---@field public level number
    ---@field public chests number
    ---@field public fractionalTime number If we have client data `isEnhanced` is set and the values are then `0.0` to `1.0` is within the timer, anything above is depleted over the timer. If `isEnhanced` is false then this value is 0 to 3 where 3 is depleted, and the rest is in time.

    ---@class SortedMilestone
    ---@field public level number
    ---@field public label string
    ---@field public text string

    local CLIENT_CHARACTERS = ns:GetClientData()
    local DUNGEONS = ns:GetDungeonData()

    ---@param results DataProviderMythicKeystoneProfile
    local function ApplyClientDataToMythicKeystoneData(results, name, realm)
        if not CLIENT_CHARACTERS or not config:Get("enableClientEnhancements") then
            return
        end
        local nameAndRealm = name .. "-" .. realm
        local clientData = CLIENT_CHARACTERS[nameAndRealm]
        if not clientData then
            return
        end
        local keystoneData = clientData.mythic_keystone
        results.isEnhanced = true
        results.currentScore = keystoneData.all.score
        local maxDungeonIndex = 0
        local maxDungeonTime = 999
        local maxDungeonLevel = 0
        local maxDungeonUpgrades = 0
        for i = 1, #keystoneData.all.runs do
            local run = keystoneData.all.runs[i]
            results.dungeons[i] = run.level
            results.dungeonUpgrades[i] = run.upgrades
            results.dungeonTimes[i] = run.fraction
            if run.level > maxDungeonLevel or (run.level == maxDungeonLevel and run.fraction < maxDungeonTime) then
                maxDungeonIndex = i
                maxDungeonTime = run.fraction
                maxDungeonLevel = run.level
                maxDungeonUpgrades = run.upgrades
            end
        end
        if maxDungeonIndex > 0 then
            results.maxDungeon = DUNGEONS[maxDungeonIndex]
            results.maxDungeonLevel = maxDungeonLevel
            results.maxDungeonUpgrades = maxDungeonUpgrades
        end
    end

    ---@param a SortedDungeon
    ---@param b SortedDungeon
    local function SortDungeons(a, b)
        local al, bl = a.level, b.level
        if al == bl then
            local at, bt = a.fractionalTime, b.fractionalTime
            if at == bt then
                return a.dungeon.shortNameLocale < b.dungeon.shortNameLocale
            end
            return at < bt
        end
        return al > bl
    end

    local function UnpackMythicKeystoneData(bucket, baseOffset, encodingOrder, providerOutdated, providerBlocked, name, realm, region)
        ---@type DataProviderMythicKeystoneProfile
        local results = { outdated = providerOutdated, hasRenderableData = false }
        if providerBlocked then
            if name and util:IsUnitPlayer(name, realm, region) then
                results.softBlocked = providerBlocked
            else
                results.blocked = providerBlocked
                return results
            end
        end
        local bitOffset = (baseOffset - 1) * 8
        local value
        for encoderIndex = 1, #encodingOrder do
            local field = encodingOrder[encoderIndex]
            if field == ENCODER_MYTHICPLUS_FIELDS.CURRENT_SCORE then
                results.currentScore, bitOffset = ReadBitsFromString(bucket, bitOffset, 14)
                results.hasRenderableData = results.hasRenderableData or results.currentScore > 0
            elseif field == ENCODER_MYTHICPLUS_FIELDS.CURRENT_ROLES then
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 7)
                results.currentRoleOrdinalIndex = 1 + value -- indexes are one-based
            elseif field == ENCODER_MYTHICPLUS_FIELDS.PREVIOUS_SCORE then
                results.previousScore, bitOffset = ReadBitsFromString(bucket, bitOffset, 13)
                results.previousScoreSeason, bitOffset = ReadBitsFromString(bucket, bitOffset, 2)
                results.hasRenderableData = results.hasRenderableData or results.previousScore > 0
            elseif field == ENCODER_MYTHICPLUS_FIELDS.PREVIOUS_ROLES then
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 7)
                results.previousRoleOrdinalIndex = 1 + value -- indexes are one-based
            elseif field == ENCODER_MYTHICPLUS_FIELDS.MAIN_CURRENT_SCORE then
                results.mainCurrentScore, bitOffset = ReadBitsFromString(bucket, bitOffset, 13)
                results.hasRenderableData = results.hasRenderableData or results.mainCurrentScore > 0
            elseif field == ENCODER_MYTHICPLUS_FIELDS.MAIN_CURRENT_ROLES then
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 7)
                results.mainCurrentRoleOrdinalIndex = 1 + value -- indexes are one-based
            elseif field == ENCODER_MYTHICPLUS_FIELDS.MAIN_PREVIOUS_SCORE then
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 10)
                results.mainPreviousScore = 10 * value
                results.mainPreviousScoreSeason, bitOffset = ReadBitsFromString(bucket, bitOffset, 2)
                results.hasRenderableData = results.hasRenderableData or results.mainPreviousScore > 0
            elseif field == ENCODER_MYTHICPLUS_FIELDS.MAIN_PREVIOUS_ROLES then
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 7)
                results.mainPreviousRoleOrdinalIndex = 1 + value -- indexes are one-based
            elseif field == ENCODER_MYTHICPLUS_FIELDS.DUNGEON_RUN_COUNTS then
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 6)
                results.keystoneFivePlus = DecodeBits6(value)
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 6)
                results.keystoneTenPlus = DecodeBits6(value)
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 6 or 7) -- TODO: enable once the new feature `show-more-15s` is live
                results.keystoneFifteenPlus = (DecodeBits6 or DecodeBits7)(value) -- TODO: enable once the new feature `show-more-15s` is live
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 6)
                results.keystoneTwentyPlus = DecodeBits6(value)
                results.hasRenderableData = results.hasRenderableData or results.keystoneFivePlus > 0 or results.keystoneTenPlus > 0 or results.keystoneFifteenPlus > 0 or results.keystoneTwentyPlus > 0
            elseif field == ENCODER_MYTHICPLUS_FIELDS.DUNGEON_LEVELS then
                results.dungeons = {}
                results.dungeonUpgrades = {}
                results.dungeonTimes = {}
                for i = 1, #DUNGEONS do
                    results.dungeons[i], bitOffset = ReadBitsFromString(bucket, bitOffset, 5)
                    results.dungeonUpgrades[i], bitOffset = ReadBitsFromString(bucket, bitOffset, 2)
                    results.dungeonTimes[i] = 3 - results.dungeonUpgrades[i]
                    results.hasRenderableData = results.hasRenderableData or results.dungeons[i] > 0
                end
            elseif field == ENCODER_MYTHICPLUS_FIELDS.DUNGEON_BEST_INDEX then
                value, bitOffset = ReadBitsFromString(bucket, bitOffset, 4)
                results.maxDungeonIndex = 1 + value
            end
        end
        if results.maxDungeonIndex > #results.dungeons then
            results.maxDungeonIndex = 1
        end
        results.maxDungeonLevel = results.dungeons[results.maxDungeonIndex]
        results.maxDungeon = DUNGEONS[results.maxDungeonIndex]
        ApplyClientDataToMythicKeystoneData(results, name, realm)
        results.sortedMilestones = {}
        if results.keystoneTwentyPlus > 0 then
            results.sortedMilestones[#results.sortedMilestones + 1] = {
                level = 20,
                label = L.TIMED_20_RUNS,
                text = results.keystoneTwentyPlus .. (results.keystoneTwentyPlus > 10 and "+" or "")
            }
        end
        if results.keystoneFifteenPlus > 0 then
            results.sortedMilestones[#results.sortedMilestones + 1] = {
                level = 15,
                label = L.TIMED_15_RUNS,
                text = results.keystoneFifteenPlus .. (results.keystoneFifteenPlus > 10 and "+" or "")
            }
        end
        if results.keystoneTenPlus > 0 then
            results.sortedMilestones[#results.sortedMilestones + 1] = {
                level = 10,
                label = L.TIMED_10_RUNS,
                text = results.keystoneTenPlus .. (results.keystoneTenPlus > 10 and "+" or "")
            }
        end
        if results.keystoneFivePlus > 0 then
            results.sortedMilestones[#results.sortedMilestones + 1] = {
                level = 5,
                label = L.TIMED_5_RUNS,
                text = results.keystoneFivePlus .. (results.keystoneFivePlus > 10 and "+" or "")
            }
        end
        results.mplusCurrent = {
            score = results.currentScore,
            roles = ORDERED_ROLES[results.currentRoleOrdinalIndex] or ORDERED_ROLES[1]
        }
        results.mplusPrevious = {
            season = results.previousScoreSeason + 1,
            score = results.previousScore,
            roles = ORDERED_ROLES[results.previousRoleOrdinalIndex] or ORDERED_ROLES[1]
        }
        results.mplusMainCurrent = {
            score = results.mainCurrentScore,
            roles = ORDERED_ROLES[results.mainCurrentRoleOrdinalIndex] or ORDERED_ROLES[1]
        }
        results.mplusMainPrevious = {
            season = results.mainPreviousScoreSeason + 1,
            score = results.mainPreviousScore,
            roles = ORDERED_ROLES[results.mainPreviousRoleOrdinalIndex] or ORDERED_ROLES[1]
        }
        results.sortedDungeons = {}
        for i = 1, #DUNGEONS do
            local dungeon = DUNGEONS[i]
            results.sortedDungeons[i] = {
                dungeon = dungeon,
                level = results.dungeons[i],
                chests = results.dungeonUpgrades[dungeon.index],
                fractionalTime = results.dungeonTimes[dungeon.index]
            }
        end
        table.sort(results.sortedDungeons, SortDungeons)
        return results
    end

    ---@class DataProviderRaidProgress
    ---@field public progressCount number
    ---@field public difficulty number
    ---@field public killsPerBoss number[]
    ---@field public raid Raid

    ---@class DataProviderRaidProfile
    ---@field public outdated number|nil @number or nil
    ---@field public hasRenderableData boolean @True if we have any actual data to render in the tooltip without the profile appearing incomplete or empty.
    ---@field public progress DataProviderRaidProgress[]
    ---@field public mainProgress DataProviderRaidProgress[]
    ---@field public previousProgress DataProviderRaidProgress[]
    ---@field public sortedProgress SortedRaidProgress[]

    ---@class SortedRaidProgress
    ---@field public obsolete boolean If this evaluates truthy we hide it unless tooltip is expanded on purpose.
    ---@field public tier number Weighted number based on current or previous raid, difficulty and boss kill count.
    ---@field public isProgress boolean
    ---@field public isProgressPrev boolean
    ---@field public isMainProgress boolean
    ---@field public progress DataProviderRaidProgress

    ---@param a SortedRaidProgress
    ---@param b SortedRaidProgress
    local function SortRaidProgress(a, b)
        return a.tier < b.tier
    end

    ---@param a SortedRaidProgress
    ---@param b SortedRaidProgress
    local function SortRaidProgressMainLast(a, b)
        if a.isMainProgress == b.isMainProgress then
            return a.tier < b.tier
        end
        return not a.isMainProgress and b.isMainProgress
    end

    ---@param provider DataProvider
    local function UnpackRaidData(bucket, baseOffset, provider)
        local data1 = bucket[baseOffset]
        local data2 = bucket[baseOffset + 1]
        ---@type DataProviderRaidProfile
        local results = {
            outdated = provider.outdated,
            progress = {},
            previousProgress = nil,
            mainProgress = nil,
            sortedProgress = {},
            hasRenderableData = false
        }
        local value
        do
            local lo, hi = Split64BitNumber(data1)
            local offset = 0
            ---@type DataProviderRaidProgress
            local prog
            for bucketIndex = 1, 2 do
                prog = { raid = provider.currentRaid, progressCount = 0 }
                prog.difficulty, offset = ReadBits(lo, hi, offset, 2)
                prog.killsPerBoss = {}
                for i = 1, provider.currentRaid.bossCount do
                    value, offset = ReadBits(lo, hi, offset, 2)
                    prog.killsPerBoss[i] = DecodeBits2(value)
                    if prog.killsPerBoss[i] > 0 then
                        prog.progressCount = prog.progressCount + 1
                    end
                end
                if prog.progressCount > 0 then
                    results.progress[#results.progress + 1] = prog
                end
            end
        end
        do
            local lo, hi = Split64BitNumber(data2)
            local offset = 0
            ---@type DataProviderRaidProgress
            local prog
            do
                prog = { raid = provider.currentRaid, progressCount = 0 }
                prog.difficulty, offset = ReadBits(lo, hi, offset, 2)
                prog.killsPerBoss = {}
                for i = 1, provider.currentRaid.bossCount do
                    value, offset = ReadBits(lo, hi, offset, 2)
                    prog.killsPerBoss[i] = DecodeBits2(value)
                    if prog.killsPerBoss[i] > 0 then
                        prog.progressCount = prog.progressCount + 1
                    end
                end
                if prog.difficulty ~= 0 and prog.progressCount > 0 then
                    results.progress[#results.progress + 1] = prog
                end
            end
            for i = 1, 2 do
                prog = { raid = provider.previousRaid }
                prog.difficulty, offset = ReadBits(lo, hi, offset, 2)
                prog.progressCount, offset = ReadBits(lo, hi, offset, 4)
                if prog.progressCount > 0 then
                    if not results.previousProgress then
                        results.previousProgress = {}
                    end
                    results.previousProgress[#results.previousProgress + 1] = prog
                end
            end
            for i = 1, 2 do
                prog = { raid = provider.currentRaid }
                prog.difficulty, offset = ReadBits(lo, hi, offset, 2)
                prog.progressCount, offset = ReadBits(lo, hi, offset, 4)
                if prog.progressCount > 0 then
                    if not results.mainProgress then
                        results.mainProgress = {}
                    end
                    results.mainProgress[#results.mainProgress + 1] = prog
                end
            end
        end
        if results.progress then
            for i = 1, #results.progress do
                local prog = results.progress[i]
                results.sortedProgress[#results.sortedProgress + 1] = {
                    tier = 1000 +  (3 - prog.difficulty) * 100 + (99 - prog.progressCount),
                    progress = prog,
                    isProgress = true
                }
            end
        end
        if results.mainProgress then
            for i = 1, #results.mainProgress do
                local prog = results.mainProgress[i]
                results.sortedProgress[#results.sortedProgress + 1] = {
                    tier = 1000 + (3 - prog.difficulty) * 100 + (99 - prog.progressCount),
                    progress = prog,
                    isMainProgress = true
                }
            end
        end
        if results.previousProgress then
            for i = 1, #results.previousProgress do
                local prog = results.previousProgress[i]
                results.sortedProgress[#results.sortedProgress + 1] = {
                    tier = 2000 + (3 - prog.difficulty) * 100 + (99 - prog.progressCount),
                    progress = prog,
                    isProgressPrev = true
                }
            end
        end
        table.sort(results.sortedProgress, SortRaidProgress)
        for i = 2, #results.sortedProgress do
            local prog = results.sortedProgress[i]
            local prevProg = results.sortedProgress[i - 1]
            if prevProg.obsolete then
                prog.obsolete = true
            elseif prog.progress.raid == prevProg.progress.raid then
                if prevProg.progress.difficulty >= prog.progress.difficulty and prevProg.progress.progressCount >= prog.progress.progressCount then
                    prog.obsolete = true
                end
            elseif prog.tier > prevProg.tier then
                if prevProg.progress.progressCount > 0 then
                    prog.obsolete = true
                end
            end
        end
        table.sort(results.sortedProgress, SortRaidProgressMainLast)
        if results.sortedProgress[1] then
            results.sortedProgress[1].obsolete = false
        end
        for i = 1, #results.sortedProgress do
            local prog = results.sortedProgress[i]
            if not prog.obsolete and prog.progress.progressCount > 0 then
                results.hasRenderableData = true
                break
            end
        end
        return results
    end

    ---@class DataProviderPvpProfile
    ---@field public outdated number|nil @number or nil
    ---@field public hasRenderableData boolean @True if we have any actual data to render in the tooltip without the profile appearing incomplete or empty.

    ---@param provider DataProvider
    local function UnpackPvpData(bucket, baseOffset, provider)
        ---@type DataProviderPvpProfile
        local results = { outdated = provider.outdated, hasRenderableData = false }
        -- TODO: NYI
        return results
    end

    ---@class DataProviderCharacterProfile
    ---@field public success boolean
    ---@field public guid string @Unique string `region faction realm name`
    ---@field public name string
    ---@field public realm string
    ---@field public faction number
    ---@field public region string
    ---@field public mythicKeystoneProfile DataProviderMythicKeystoneProfile
    ---@field public raidProfile DataProviderRaidProfile
    ---@field public pvpProfile DataProviderPvpProfile

    -- cache mythic keystone profiles for re-use after first query
    ---@type DataProviderMythicKeystoneProfile[]
    local mythicKeystoneProfileCache = {}

    -- cache raid profiles for re-use after first query
    ---@type DataProviderRaidProfile[]
    local raidProfileCache = {}

    -- cache pvp profiles for re-use after first query
    ---@type DataProviderPvpProfile[]
    local pvpProfileCache = {}

    -- cache profiles for re-use after first query
    ---@type DataProviderCharacterProfile[]
    local profileCache = {}

    ---@param provider DataProvider
    local function GetMythicKeystoneProfile(provider, ...)
        if provider.blockedPurged then
            local _, _, name, realm = ...
            local guid = provider.data .. ":" .. provider.region .. ":" .. provider.faction .. ":-1:-1:blockedPurged"
            local cache = mythicKeystoneProfileCache[guid]
            if cache then
                return cache
            end
            local profile = UnpackMythicKeystoneData(nil, nil, nil, true, true, name, realm, provider.region)
            profile.blockedPurged = true
            mythicKeystoneProfileCache[guid] = profile
            return profile
        end
        local bucket, baseOffset, guid, name, realm = SearchForBucketByName(provider, ...)
        if not bucket then
            return
        end
        local cache = mythicKeystoneProfileCache[guid]
        if cache then
            return cache
        end
        local profile = UnpackMythicKeystoneData(bucket, baseOffset, provider.encodingOrder, provider.outdated, provider.blocked, name, realm, provider.region)
        mythicKeystoneProfileCache[guid] = profile
        return profile
    end

    ---@param provider DataProvider
    local function GetRaidProfile(provider, ...)
        local bucket, baseOffset, guid = SearchForBucketByName(provider, ...)
        if not bucket then
            return
        end
        local cache = raidProfileCache[guid]
        if cache then
            return cache
        end
        local profile = UnpackRaidData(bucket, baseOffset, provider)
        raidProfileCache[guid] = profile
        return profile
    end

    local function GetPvpProfile(provider, ...)
        local bucket, baseOffset, guid = SearchForBucketByName(provider, ...)
        if not bucket then
            return
        end
        local cache = pvpProfileCache[guid]
        if cache then
            return cache
        end
        local profile = UnpackPvpData(bucket, baseOffset, provider)
        pvpProfileCache[guid] = profile
        return profile
    end

    ---@param name string
    ---@param realm string
    ---@param faction number
    ---@param region string @Optional, will use players own region if ommited. Include to avoid ambiguity during debug mode.
    ---@return DataProviderCharacterProfile @Return value is nil if not found
    function provider:GetProfile(name, realm, faction, region)
        if type(name) ~= "string" or type(realm) ~= "string" or type(faction) ~= "number" then
            return
        end
        region = region or ns.PLAYER_REGION
        local guid = region .. " " .. faction .. " " .. realm .. " " .. name
        local cache = profileCache[guid]
        if cache then
            if not cache.success then
                return
            end
            return cache
        end
        local mythicKeystoneProfile ---@type DataProviderMythicKeystoneProfile
        local raidProfile ---@type DataProviderRaidProfile
        local pvpProfile ---@type DataProviderPvpProfile
        for i = 1, #providers do
            local provider = providers[i]
            if provider.faction == faction and provider.region == region then
                local lookup = provider["lookup" .. faction]
                local data = provider["db" .. faction]
                if lookup and data then
                    if provider.data == ns.PROVIDER_DATA_TYPE.MythicKeystone then
                        if provider.blockedPurged then
                            local tempMythicKeystoneProfile = GetMythicKeystoneProfile(provider, lookup, data, name, realm)
                            if tempMythicKeystoneProfile and (not mythicKeystoneProfile or mythicKeystoneProfile.blockedPurged) then
                                mythicKeystoneProfile = tempMythicKeystoneProfile
                            end
                        elseif not mythicKeystoneProfile then
                            mythicKeystoneProfile = GetMythicKeystoneProfile(provider, lookup, data, name, realm)
                        end
                    elseif provider.data == ns.PROVIDER_DATA_TYPE.Raid then
                        if not raidProfile then
                            raidProfile = GetRaidProfile(provider, lookup, data, name, realm)
                        end
                    elseif provider.data == ns.PROVIDER_DATA_TYPE.PvP then
                        if not pvpProfile then
                            pvpProfile = GetPvpProfile(provider, lookup, data, name, realm)
                        end
                    end
                    if mythicKeystoneProfile and raidProfile and pvpProfile then
                        break
                    end
                end
            end
        end
        if mythicKeystoneProfile and (not mythicKeystoneProfile.hasRenderableData and mythicKeystoneProfile.blocked) and not raidProfile and not pvpProfile then -- TODO: if we don't use blockedPurged functionality we have to then purge when the data is blocked and no rendering is available instead of checking the blockedPurged property
            mythicKeystoneProfile = nil
        end
        cache = {
            success = (mythicKeystoneProfile or raidProfile or pvpProfile) and true or false,
            guid = guid,
            name = name,
            realm = realm,
            faction = faction,
            region = region,
            mythicKeystoneProfile = mythicKeystoneProfile,
            raidProfile = raidProfile,
            pvpProfile = pvpProfile
        }
        profileCache[guid] = cache
        if not cache.success then
            _G.RaiderIO_MissingCharacters[format("%s-%s-%s", ns.PLAYER_REGION, name, util:GetRealmSlug(realm, true))] = true
            return
        end
        return cache
    end

    local function OnPlayerEnteringWorld()
        table.wipe(mythicKeystoneProfileCache)
        table.wipe(raidProfileCache)
        table.wipe(pvpProfileCache)
        table.wipe(profileCache)
    end

    callback:RegisterEvent(OnPlayerEnteringWorld, "PLAYER_ENTERING_WORLD")

end

-- loader.lua (internal)
-- dependencies: module, callback, config, util, provider
do

    local callback = ns:GetModule("Callback") ---@type CallbackModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local provider = ns:GetModule("Provider") ---@type ProviderModule

    local loadingAgainSoon
    local LoadModules

    function LoadModules()
        local modules = ns:GetModules()
        local numLoaded = 0
        local numPending = 0
        for _, module in ipairs(modules) do
            if not module:IsLoaded() and module:CanLoad() then
                if module:HasDependencies() then
                    numLoaded = numLoaded + 1
                    module:Load()
                else
                    numPending = numPending + 1
                end
            end
        end
        if not loadingAgainSoon and numLoaded > 0 and numPending > 0 then
            loadingAgainSoon = true
            C_Timer.After(1, function()
                loadingAgainSoon = false
                LoadModules()
            end)
        end
    end

    local function OnPlayerLogin()
        ns.PLAYER_REGION, ns.PLAYER_REGION_ID = util:GetRegion()
        ns.PLAYER_FACTION, ns.PLAYER_FACTION_TEXT = util:GetFaction("player")
        ns.PLAYER_NAME, ns.PLAYER_REALM = util:GetNameRealm("player")
        ns.PLAYER_REALM_SLUG = util:GetRealmSlug(ns.PLAYER_REALM)
        _G.RaiderIO_LastCharacter = format("%s-%s-%s", ns.PLAYER_REGION, ns.PLAYER_NAME, ns.PLAYER_REALM_SLUG or ns.PLAYER_REALM)
        _G.RaiderIO_MissingCharacters = {}
        callback:SendEvent("RAIDERIO_PLAYER_LOGIN")
        LoadModules()
    end

    local function OnAddOnLoaded(_, name)
        if name == addonName then
            config.SavedVariablesLoaded = true
        end
        LoadModules()
        if name == addonName then
            if not IsLoggedIn() then
                callback:RegisterEventOnce(OnPlayerLogin, "PLAYER_LOGIN")
            else
                OnPlayerLogin()
            end
        end
    end

    callback:RegisterEvent(OnAddOnLoaded, "ADDON_LOADED")

end

-- render.lua
-- dependencies: module, callback, config, util, provider
do

    ---@class RenderModule : Module
    local render = ns:NewModule("Render") ---@type RenderModule
    local callback = ns:GetModule("Callback") ---@type CallbackModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local provider = ns:GetModule("Provider") ---@type ProviderModule

    ---@return string, string, string, number, number @Always call as `render.GetQuery(...)`. Returns the following args: unit, name, realm, faction, options, args
    function render.GetQuery(...)
        local arg1, arg2, arg3, arg4, arg5, arg6 = ...
        local name, realm, unit = util:GetNameRealm(arg1, arg2)
        local faction, options, args, region
        if not faction and type(arg2) == "number" then
            if arg2 < 4 then
                faction = arg2
            end
        end
        if not faction and type(arg3) == "number" then
            if arg3 < 4 then
                faction = arg3
            end
        end
        if not options and type(arg2) == "number" then
            if arg2 > 3 then
                options = arg2
            end
        end
        if not options and type(arg3) == "number" then
            if arg3 > 3 then
                options = arg3
            end
        end
        if not options and type(arg4) == "number" then
            if arg4 > 3 then
                options = arg4
            end
        end
        if not args and type(arg2) == "table" then
            args = arg2
        end
        if not args and type(arg3) == "table" then
            args = arg3
        end
        if not args and type(arg4) == "table" then
            args = arg4
        end
        if not args and type(arg5) == "table" then
            args = arg5
        end
        if not region and type(arg3) == "string" then
            region = arg3
        end
        if not region and type(arg4) == "string" then
            region = arg4
        end
        if not region and type(arg5) == "string" then
            region = arg5
        end
        if not region and type(arg6) == "string" then
            region = arg6
        end
        return unit, name, realm, faction, options, args, region
    end

    render.Flags = {
        -- modifier states
        MOD = 4,
        MOD_STICKY = 8,
        -- data types to include
        MYTHIC_KEYSTONE = 16,
        RAID = 32,
        -- tooltip types
        UNIT_TOOLTIP = 64,
        PROFILE_TOOLTIP = 128,
        KEYSTONE_TOOLTIP = 256,
        -- additional visual tweaks
        SHOW_PADDING = 512,
        SHOW_HEADER = 1024,
        SHOW_FOOTER = 2048,
        SHOW_NAME = 4096,
        SHOW_LFD = 8192,
        -- ignore modifier state logic processing
        IGNORE_MOD = 16384
    }

    ---@class RenderPreset
    ---@field public Unit function @for use when drawing unit tooltip. automatically evaluates the modifier flag.
    ---@field public Profile function @for use when drawing a complete profile tooltip. automatically evaluates the modifier flag.
    ---@field public Keystone function @for use when drawing a keystone tooltip. automatically evaluates the modifier flag.
    ---@field public UnitNoPadding function @same as Unit, but also removes the padding flag.
    ---@field public UnitSmartPadding function @same as Unit, but if arg1 is set, padding flag is added, otherwise removed.

    ---@type RenderPreset
    render.Preset = {
        Unit = bor(render.Flags.MYTHIC_KEYSTONE, render.Flags.RAID, render.Flags.UNIT_TOOLTIP, render.Flags.SHOW_PADDING, render.Flags.SHOW_HEADER, render.Flags.SHOW_FOOTER, render.Flags.SHOW_LFD),
        Profile = bor(render.Flags.MYTHIC_KEYSTONE, render.Flags.RAID, render.Flags.PROFILE_TOOLTIP, render.Flags.MOD_STICKY, render.Flags.SHOW_PADDING, render.Flags.SHOW_HEADER, render.Flags.SHOW_FOOTER, render.Flags.SHOW_NAME, render.Flags.SHOW_LFD),
        Keystone = bor(render.Flags.MYTHIC_KEYSTONE, render.Flags.KEYSTONE_TOOLTIP, render.Flags.SHOW_PADDING, render.Flags.SHOW_HEADER, render.Flags.SHOW_LFD),
    }

    render.Preset.UnitNoPadding = bxor(render.Preset.Unit, render.Flags.SHOW_PADDING)

    local function IsModifierKeyDownOrAlwaysExtend()
        return IsModifierKeyDown() or config:Get("alwaysExtendTooltip")
    end

    for k, v in pairs(render.Preset) do
        render.Preset[k] = function(additional)
            local IsModKeyDown = IsModifierKeyDown
            if k == "Unit" or k == "UnitNoPadding" then
                IsModKeyDown = IsModifierKeyDownOrAlwaysExtend
            end
            if type(additional) == "number" then
                if additional < 0 then
                    additional = bxor(v, -additional)
                end
                return bor(v, additional, IsModKeyDown() and render.Flags.MOD or 0)
            end
            return bor(v, IsModKeyDown() and render.Flags.MOD or 0)
        end
    end

    render.Preset.UnitSmartPadding = function(ownerExisted)
        return bxor(render.Preset.Unit(), not ownerExisted and render.Flags.SHOW_PADDING or 0)
    end

    local StateType = {
        Profile = 1,
        Keystone = 2
    }

    ---@class TooltipState
    ---@field public type table<string, number>
    ---@field public unit string
    ---@field public name string
    ---@field public realm string
    ---@field public faction number @1 (alliance), 2 (horde), 3 (neutral)
    ---@field public region string @"us","kr","eu","tw","cn"
    ---@field public options number @render.Flags

    ---@type TooltipStates<table, TooltipState>
    local tooltipStates = {}

    function render:GetTooltipState(tooltip)
        ---@type TooltipState
        local state = tooltipStates[tooltip]
        if not state then
            state = {}
            tooltipStates[tooltip] = state
        end
        return state
    end

    ---@return boolean @Returns true if the tooltip was successfully updated with data, otherwise false if we couldn't.
    function render:ShowProfile(tooltip, ...)
        local state = render:GetTooltipState(tooltip)
        state.type = StateType.Profile
        local unit, name, realm, faction, options, args, region = render.GetQuery(...)
        state.unit, state.name, state.realm, state.faction, state.options, state.args, state.region = unit, name, realm, faction, options, args, region
        state.faction = state.faction or util:GetFaction(state.unit)
        state.options = state.options or render.Preset.Unit()
        state.args = state.args or args
        state.region = state.region or ns.PLAYER_REGION
        state.success = render:UpdateTooltip(tooltip, state)
        tooltip:Show()
        return state.success
    end

    ---@class KeystoneInfo
    ---@field public link string @Required as we need to know how to re-draw the tooltip when needed using the proper link
    ---@field public item number @itemID or keystoneID from the link itself
    ---@field public instance number @instanceID
    ---@field public level number @level 2 and higher
    ---@field public affix1 number @optional affix ID
    ---@field public affix2 number @optional affix ID
    ---@field public affix3 number @optional affix ID
    ---@field public affix4 number @optional affix ID

    ---@param keystone KeystoneInfo
    ---@return boolean @Returns true if the tooltip was successfully updated with data, otherwise false if we couldn't.
    function render:ShowKeystone(tooltip, keystone)
        local state = render:GetTooltipState(tooltip)
        state.type = StateType.Keystone
        state.unit, state.name, state.realm, state.faction, state.options = nil
        state.args = state.args or keystone
        state.options = render.Preset.Keystone()
        state.success = render:UpdateTooltip(tooltip, state)
        tooltip:Show()
        return state.success
    end

    function render:ClearTooltip(tooltip)
        local state = render:GetTooltipState(tooltip)
        table.wipe(state)
    end

    function render:HideTooltip(tooltip)
        render:ClearTooltip(tooltip)
        tooltip:Hide()
    end

    local function Has(flag, mask)
        return band(flag, mask) == mask
    end

    local EASTER_EGG = {
        ["eu"] = {
            ["Ravencrest"] = {
                ["Voidzone"] = "Raider.IO AddOn Author"
            },
            ["Ysondre"] = {
                ["Isakem"] = "Raider.IO Contributor"
            }
        },
        ["us"] = {
            ["Skullcrusher"] = {
                ["Aspyrox"] = "Raider.IO Creator",
                ["Ulsoga"] = "Raider.IO Creator",
				["Mccaffrey"] = "Killing Keys Since 1977!",
				["Oscassey"] = "Master of dis guys"
			},
            ["Thrall"] = {
                ["Firstclass"] = "Author of mythicpl.us"
            },
            ["Tichondrius"] = {
                ["Johnsamdi"] = "Raider.IO Developer"
            }
        }
    }

    local DUNGEONS = ns:GetDungeonData()

    local function GetSeasonLabel(label, season)
        return format(label, format(L["SEASON_LABEL_" .. season], season))
    end

    ---@param data DataProviderMythicKeystoneScore
    local function GetScoreText(data, isApproximated)
        local score = (isApproximated and "±" or "") .. data.score
        if not config:Get("showRoleIcons") then
            return score
        end
        local icons = {}
        for i = 1, #data.roles do
            local role = data.roles[i]
            local k, v = role[1], role[2]
            icons[i] = ns.ROLE_ICONS[k][v]
        end
        return table.concat(icons, "") .. " " .. score
    end

    ---@class BestRun
    ---@field public dungeon Dungeon|nil
    ---@field public level number
    ---@field public text string|nil

    ---@param keystoneProfile DataProviderMythicKeystoneProfile
    ---@param state TooltipState
    ---@return boolean|nil @Returns true if this is a header and it has added data to the tooltip, otherwise false, or nil if it's not a header request.
    local function AppendBestRunToTooltip(tooltip, keystoneProfile, state, isHeader)
        local options = state.options
        local showLFD = Has(options, render.Flags.SHOW_LFD)
        local best = { dungeon = nil, level = 0, text = nil } ---@type BestRun @best dungeon
        local overallBest = { dungeon = keystoneProfile.maxDungeon, level = keystoneProfile.maxDungeonLevel, text = nil } ---@type BestRun @overall best
        if showLFD then
            local focusDungeon = util:GetLFDStatusForCurrentActivity(state.args and state.args.activityID)
            if focusDungeon then
                best.dungeon = focusDungeon
                best.level = keystoneProfile.dungeons[focusDungeon.index]
            end
        end
        if best.dungeon and (not best.level or best.level < 1) then
            best.level = keystoneProfile.dungeons[best.dungeon.index] or 0
        end
        if not best.dungeon or (best.level and best.level < 1) then
            best.dungeon, best.level = nil, 0
        end
        local hasHeaderData = false
        if overallBest.level > 0 and (not best.dungeon or best.dungeon ~= overallBest.dungeon) then
            local label, r, g, b
            if isHeader then
                hasHeaderData = true
                label, r, g, b = L.RAIDERIO_BEST_RUN, 1, 0.85, 0
            else
                label, r, g, b = L.BEST_RUN, 1, 1, 1
            end
            tooltip:AddDoubleLine(label, util:GetNumChests(keystoneProfile.dungeonUpgrades[overallBest.dungeon.index]) .. "|cffffffff" .. overallBest.level .. "|r " .. overallBest.dungeon.shortNameLocale, r, g, b, util:GetScoreColor(keystoneProfile.mplusCurrent.score))
        end
        if best.dungeon and best.level > 0 then
            local label, r, g, b = L.BEST_FOR_DUNGEON, 1, 1, 1
            hasHeaderData = isHeader
            if best.dungeon == keystoneProfile.maxDungeon then
                if isHeader then
                    label, r, g, b = L.RAIDERIO_BEST_RUN, 1, 0.85, 0
                else
                    label, r, g, b = L.BEST_FOR_DUNGEON, 0, 1, 0
                end
            end
            tooltip:AddDoubleLine(label, util:GetNumChests(keystoneProfile.dungeonUpgrades[best.dungeon.index]) .. "|cffffffff" .. best.level .. "|r " .. best.dungeon.shortNameLocale, r, g, b, util:GetScoreColor(keystoneProfile.mplusCurrent.score))
        end
        if isHeader then
            return hasHeaderData
        end
    end

    ---@class PartyMember
    ---@field public unit string
    ---@field public level number
    ---@field public name string
    ---@field public chests number

    ---@param a PartyMember
    ---@param b PartyMember
    local function SortGroupMembers(a, b)
        if a.level == b.level then
            return a.name < b.name
        end
        return a.level > b.level
    end

    ---@param keystone KeystoneInfo
    ---@param dungeon Dungeon
    local function AppendGroupLevelsToTooltip(tooltip, keystone, dungeon)
        local numMembers = GetNumGroupMembers()
        if numMembers > 5 then
            return
        end
        ---@type PartyMember[]
        local members = {}
        local index = 0
        for i = 0, numMembers do
            local unit = i == 0 and "player" or "party" .. i
            local name, realm = util:GetNameRealm(unit)
            local profile = provider:GetProfile(name, realm, ns.PLAYER_FACTION)
            if profile and profile.mythicKeystoneProfile and not profile.mythicKeystoneProfile.blocked then
                local level = profile.mythicKeystoneProfile.dungeons[dungeon.index]
                if level > 0 then
                    index = index + 1
                    members[index] = { unit = unit, level = level, name = UnitName(unit), chests = profile.mythicKeystoneProfile.dungeonUpgrades[dungeon.index] }
                end
            end
        end
        if index > 1 then
            table.sort(members, SortGroupMembers)
        end
        for i = 1, index do
            local member = members[i]
            tooltip:AddDoubleLine(UnitName(member.unit), util:GetNumChests(member.chests) .. member.level .. " " .. dungeon.shortNameLocale, 1, 1, 1, util:GetKeystoneChestColor(member.chests))
        end
    end

    ---@param state TooltipState
    function render:UpdateTooltip(tooltip, state)
        -- we will in most cases always pass the state but if we don't we will retrieve it
        if not state then
            state = render:GetTooltipState(tooltip)
        end
        -- we are looking up a specific player
        if state.type == StateType.Profile then
            local profile = provider:GetProfile(state.name, state.realm, state.faction, state.region)
            if profile then
                local keystoneProfile = profile.mythicKeystoneProfile
                local raidProfile = profile.raidProfile
                local pvpProfile = profile.pvpProfile
                local isKeystoneBlockShown = keystoneProfile and keystoneProfile.hasRenderableData and not keystoneProfile.blocked
                local isBlocked = keystoneProfile and (keystoneProfile.blocked or keystoneProfile.softBlocked)
                local isOutdated = keystoneProfile and keystoneProfile.outdated
                local isExtendedProfile = Has(state.options, render.Flags.PROFILE_TOOLTIP)
                local showRaidEncounters = config:Get("showRaidEncountersInProfile")
                local isRaidBlockShown = raidProfile and raidProfile.hasRenderableData and (not isExtendedProfile or showRaidEncounters)
                local isPvpBlockShown = pvpProfile and pvpProfile.hasRenderableData
                local isAnyBlockShown = isKeystoneBlockShown or isRaidBlockShown or isPvpBlockShown
                local isUnitTooltip = Has(state.options, render.Flags.UNIT_TOOLTIP)
                local hasMod = Has(state.options, render.Flags.MOD)
                local hasModSticky = Has(state.options, render.Flags.MOD_STICKY)
                local showHeader = Has(state.options, render.Flags.SHOW_HEADER)
                local showFooter = Has(state.options, render.Flags.SHOW_FOOTER)
                local showPadding = Has(state.options, render.Flags.SHOW_PADDING)
                local showName = Has(state.options, render.Flags.SHOW_NAME)
                local showLFD = Has(state.options, render.Flags.SHOW_LFD)
                local showTopLine = isAnyBlockShown or isBlocked or isOutdated
                local showTopLinePadding = showTopLine and not isUnitTooltip and isExtendedProfile and showPadding
                if showTopLine then
                    if isUnitTooltip then
                        if showPadding then
                            tooltip:AddLine(" ")
                        end
                        if showName then
                            tooltip:AddLine(format("%s (%s)", profile.name, profile.realm), 1, 1, 1)
                        end
                    elseif isExtendedProfile then
                        if showName then
                            tooltip:AddLine(format("%s (%s)", profile.name, profile.realm), 1, 1, 1)
                        end
                        if showPadding then
                            tooltip:AddLine(" ")
                        end
                    end
                end
                if isKeystoneBlockShown then
                    local headlineMode = config:Get("mplusHeadlineMode")
                    if showHeader then
                        if headlineMode == ns.HEADLINE_MODE.BEST_SEASON then
                            if keystoneProfile.mplusPrevious.score > keystoneProfile.mplusCurrent.score then
                                tooltip:AddDoubleLine(GetSeasonLabel(L.RAIDERIO_MP_BEST_SCORE, keystoneProfile.mplusPrevious.season), GetScoreText(keystoneProfile.mplusPrevious, true), 1, 0.85, 0, util:GetScoreColor(keystoneProfile.mplusPrevious.score, true))
                                if keystoneProfile.mplusCurrent.score > 0 then
                                    tooltip:AddDoubleLine(GetSeasonLabel(L.CURRENT_SCORE, ns.CURRENT_SEASON), GetScoreText(keystoneProfile.mplusCurrent), 1, 1, 1, util:GetScoreColor(keystoneProfile.mplusCurrent.score))
                                end
                            else
                                tooltip:AddDoubleLine(GetSeasonLabel(L.RAIDERIO_MP_SCORE, ns.CURRENT_SEASON), GetScoreText(keystoneProfile.mplusCurrent), 1, 0.85, 0, util:GetScoreColor(keystoneProfile.mplusCurrent.score))
                            end
                        elseif headlineMode == ns.HEADLINE_MODE.BEST_RUN then
                            local r, g, b = 1, 0.85, 0
                            if AppendBestRunToTooltip(tooltip, keystoneProfile, state, true) then
                                r, g, b = 1, 1, 1
                            end
                            if keystoneProfile.mplusCurrent.score > 0 then
                                tooltip:AddDoubleLine(GetSeasonLabel(L.CURRENT_SCORE, ns.CURRENT_SEASON), GetScoreText(keystoneProfile.mplusCurrent), r, g, b, util:GetScoreColor(keystoneProfile.mplusCurrent.score))
                            end
                            if keystoneProfile.mplusPrevious.score > keystoneProfile.mplusCurrent.score then
                                tooltip:AddDoubleLine(GetSeasonLabel(L.PREVIOUS_SCORE, keystoneProfile.mplusPrevious.season), GetScoreText(keystoneProfile.mplusPrevious, true), r, g, b, util:GetScoreColor(keystoneProfile.mplusPrevious.score, true))
                            end
                        else -- if headlineMode == ns.HEADLINE_MODE.CURRENT_SEASON then
                            tooltip:AddDoubleLine(GetSeasonLabel(L.RAIDERIO_MP_SCORE, ns.CURRENT_SEASON), GetScoreText(keystoneProfile.mplusCurrent), 1, 0.85, 0, util:GetScoreColor(keystoneProfile.mplusCurrent.score))
                            if keystoneProfile.mplusPrevious.score > keystoneProfile.mplusCurrent.score then
                                tooltip:AddDoubleLine(GetSeasonLabel(L.PREVIOUS_SCORE, keystoneProfile.mplusPrevious.season), GetScoreText(keystoneProfile.mplusPrevious, true), 1, 1, 1, util:GetScoreColor(keystoneProfile.mplusPrevious.score, true))
                            end
                        end
                    end
                    if config:Get("showMainsScore") then
                        if not config:Get("showMainBestScore") then
                            if keystoneProfile.mplusMainCurrent.score > keystoneProfile.mplusCurrent.score then
                                tooltip:AddDoubleLine(L.MAINS_SCORE, GetScoreText(keystoneProfile.mplusMainCurrent), 1, 1, 1, util:GetScoreColor(keystoneProfile.mplusMainCurrent.score))
                            end
                        elseif keystoneProfile.mplusMainCurrent.score > keystoneProfile.mplusCurrent.score or keystoneProfile.mplusMainPrevious.score > keystoneProfile.mplusCurrent.score then
                            if keystoneProfile.mplusMainCurrent.score < keystoneProfile.mplusMainPrevious.score then
                                tooltip:AddDoubleLine(GetSeasonLabel(L.MAINS_BEST_SCORE_BEST_SEASON, keystoneProfile.mplusMainPrevious.season), GetScoreText(keystoneProfile.mplusMainPrevious, true), 1, 1, 1, util:GetScoreColor(keystoneProfile.mplusMainPrevious.score, true))
                            elseif keystoneProfile.mplusMainCurrent.score > 0 or hasMod or hasModSticky then
                                tooltip:AddDoubleLine(L.CURRENT_MAINS_SCORE, GetScoreText(keystoneProfile.mplusMainCurrent), 1, 1, 1, util:GetScoreColor(keystoneProfile.mplusMainCurrent.score))
                            end
                        end
                    end
                    do
                        AppendBestRunToTooltip(tooltip, keystoneProfile, state)
                    end
                    for i = 1, #keystoneProfile.sortedMilestones do
                        if i >= 2 and (not hasMod and not hasModSticky) then
                            break
                        end
                        local sortedMilestone = keystoneProfile.sortedMilestones[i]
                        tooltip:AddDoubleLine(sortedMilestone.label, sortedMilestone.text, 1, 1, 1, 1, 1, 1)
                    end
                    if isExtendedProfile and (hasMod or hasModSticky) then
                        local hasBestDungeons = false
                        for i = 1, #keystoneProfile.sortedDungeons do
                            local sortedDungeon = keystoneProfile.sortedDungeons[i]
                            if sortedDungeon.level > 0 then
                                hasBestDungeons = true
                                break
                            end
                        end
                        if hasBestDungeons then
                            if showHeader then
                                if showPadding then
                                    tooltip:AddLine(" ")
                                end
                                tooltip:AddLine(L.PROFILE_BEST_RUNS, 1, 0.85, 0)
                            end
                            local focusDungeon = showLFD and util:GetLFDStatusForCurrentActivity(state.args and state.args.activityID)
                            for i = 1, #keystoneProfile.sortedDungeons do
                                local sortedDungeon = keystoneProfile.sortedDungeons[i]
                                local r, g, b = 1, 1, 1
                                if sortedDungeon.dungeon == focusDungeon then
                                    r, g, b = 0, 1, 0
                                end
                                if sortedDungeon.level > 0 then
                                    tooltip:AddDoubleLine(sortedDungeon.dungeon.shortNameLocale, util:GetNumChests(sortedDungeon.chests) .. sortedDungeon.level, r, g, b, util:GetKeystoneChestColor(sortedDungeon.chests))
                                else
                                    tooltip:AddDoubleLine(sortedDungeon.dungeon.shortNameLocale, "-", r, g, b, 0.5, 0.5, 0.5)
                                end
                            end
                        end
                    end
                end
                if isRaidBlockShown then
                    if showPadding and isKeystoneBlockShown then
                        tooltip:AddLine(" ")
                    end
                    if showHeader then
                        if isExtendedProfile then
                            if showRaidEncounters then
                                tooltip:AddLine(L.RAID_ENCOUNTERS_DEFEATED_TITLE, 1, 0.85, 0)
                            end
                        else
                            tooltip:AddLine(L.RAIDING_DATA_HEADER, 1, 0.85, 0)
                        end
                    end
                    if isExtendedProfile then
                        if showRaidEncounters then
                            local raidProvider = provider:GetProviderByType(ns.PROVIDER_DATA_TYPE.Raid)
                            for i = 1, raidProvider.currentRaid.bossCount do
                                local progressFound = false
                                for j = 1, #raidProfile.progress do
                                    local progress = raidProfile.progress[j]
                                    local bossKills = progress.killsPerBoss[i]
                                    if bossKills > 0 then
                                        progressFound = true
                                        local difficulty = ns.RAID_DIFFICULTY[progress.difficulty]
                                        tooltip:AddDoubleLine(format("|cff%s%s|r %s", difficulty.color.hex, difficulty.suffix, L[format("RAID_BOSS_%s_%d", raidProvider.currentRaid.shortName, i)]), bossKills, 1, 1, 1, 1, 1, 1)
                                    end
                                    if progressFound then
                                        break
                                    end
                                end
                                if not progressFound then
                                    tooltip:AddDoubleLine(L[format("RAID_BOSS_%s_%d", raidProvider.currentRaid.shortName, i)], "-", 0.5, 0.5, 0.5, 0.5, 0.5, 0.5)
                                end
                            end
                        end
                    else
                        for i = 1, #raidProfile.sortedProgress do
                            local sortedProgress = raidProfile.sortedProgress[i]
                            local prog = sortedProgress.progress
                            if ((showRaidEncounters and (hasMod or hasModSticky)) or not sortedProgress.obsolete) and (not sortedProgress.isMainProgress or config:Get("showMainsScore")) then
                                local raidDiff = ns.RAID_DIFFICULTY[prog.difficulty]
                                if sortedProgress.isMainProgress then
                                    tooltip:AddDoubleLine(L.MAINS_RAID_PROGRESS, format("|cff%s%s|r %d/%d", raidDiff.color.hex, raidDiff.suffix, prog.progressCount, prog.raid.bossCount), 1, 1, 1, 1, 1, 1)
                                else
                                    tooltip:AddDoubleLine(format("%s %s", prog.raid.shortName, raidDiff.name), format("|cff%s%s|r %d/%d", raidDiff.color.hex, raidDiff.suffix, prog.progressCount, prog.raid.bossCount), 1, 1, 1, 1, 1, 1)
                                end
                            end
                        end
                    end
                end
                if isPvpBlockShown then
                    if showPadding and (isKeystoneBlockShown or isRaidBlockShown) then
                        tooltip:AddLine(" ")
                    end
                    if showHeader then
                        tooltip:AddLine(L.PVP_DATA_HEADER, 1, 0.85, 0)
                    end
                    -- TODO: NYI
                end
                if showFooter then
                    local easterEgg = EASTER_EGG[ns.PLAYER_REGION]
                    if easterEgg then
                        easterEgg = easterEgg[profile.realm]
                        if easterEgg then
                            easterEgg = easterEgg[profile.name]
                        end
                    end
                    if showPadding and (not showTopLinePadding or isAnyBlockShown) and (isBlocked or isOutdated or easterEgg) then
                        tooltip:AddLine(" ")
                    end
                    if isBlocked then
                        tooltip:AddLine(L.OUTDATED_EXPIRED_TITLE, 1, 0.85, 0)
                        tooltip:AddLine(format(L.OUTDATED_DOWNLOAD_LINK, ns.RAIDERIO_ADDON_DOWNLOAD_URL), 1, 1, 1)
                        if showPadding and easterEgg then
                            tooltip:AddLine(" ")
                        end
                    elseif isOutdated then
                        local secondsRemainingUntilBlocked = ns.OUTDATED_BLOCK_CUTOFF - isOutdated - ns.OUTDATED_CUTOFF
                        local numDays = floor(secondsRemainingUntilBlocked / 86400 + 0.5)
                        local numHours = floor(secondsRemainingUntilBlocked / 3600 + 0.5)
                        local numMinutes = floor(secondsRemainingUntilBlocked / 60 + 0.5)
                        if numDays >= 2 then
                            tooltip:AddLine(format(L.OUTDATED_EXPIRES_IN_DAYS, numDays), 1, 0.85, 0)
                        elseif numHours > 1 then
                            tooltip:AddLine(format(L.OUTDATED_EXPIRES_IN_HOURS, numHours), 1, 0.85, 0)
                        elseif numMinutes > 0 then
                            tooltip:AddLine(format(L.OUTDATED_EXPIRES_IN_MINUTES, numMinutes), 1, 0.85, 0)
                        else
                            tooltip:AddLine(L.OUTDATED_EXPIRED_TITLE, 1, 0.85, 0)
                        end
                        tooltip:AddLine(format(L.OUTDATED_DOWNLOAD_LINK, ns.RAIDERIO_ADDON_DOWNLOAD_URL), 1, 1, 1)
                        if showPadding and easterEgg then
                            tooltip:AddLine(" ")
                        end
                    end
                    if easterEgg then
                        tooltip:AddLine(easterEgg, 0.9, 0.8, 0.5)
                    end
                end
                -- profile added to tooltip successfully
                return true
            end
        end
        -- we are display keystone information
        if state.type == StateType.Keystone then
            ---@type KeystoneInfo
            local keystone = state.args
            if keystone and keystone.link then
                local baseScore = ns.KEYSTONE_LEVEL_TO_SCORE[keystone.level]
                if baseScore then
                    tooltip:AddLine(" ")
                    tooltip:AddDoubleLine(L.RAIDERIO_MP_BASE_SCORE, baseScore, 1, 0.85, 0, 1, 1, 1)
                    local avgScore = util:GetKeystoneAverageScoreForLevel(keystone.level)
                    if avgScore and config:Get("showAverageScore") then
                        tooltip:AddDoubleLine(format(L.RAIDERIO_AVERAGE_PLAYER_SCORE, keystone.level), avgScore, 1, 1, 1, util:GetScoreColor(avgScore))
                    end
                    if keystone.instance then
                        local dungeon = util:GetDungeonByKeystoneID(keystone.instance)
                        if dungeon then
                            AppendGroupLevelsToTooltip(tooltip, keystone, dungeon)
                        end
                    end
                    -- keystone information added to tooltip successfully
                    return true
                end
            end
        end
        -- we couldn't add a profile to the tooltip
        return false
    end

    ---@param state TooltipState
    local function UpdateTooltip(tooltip, state)
        -- if unit simply refresh the unit and the original hook will force update the tooltip with the desired behavior
        local _, tooltipUnit = tooltip:GetUnit()
        if tooltipUnit then
            tooltip:SetUnit(tooltipUnit)
            return
        end
        -- backup the state and update the modifier state in the options flag
        local stateType, unit, name, realm, faction, options, args, region = state.type, state.unit, state.name, state.realm, state.faction, state.options, state.args, state.region
        if IsModifierKeyDown() then
            options = bor(options, render.Flags.MOD)
        else
            options = bxor(options, render.Flags.MOD)
        end
        -- get the current tooltip owner, position and anchor
        local o1, o2, o3, o4 = tooltip:GetOwner()
        local p1, p2, p3, p4, p5 = tooltip:GetPoint(1)
        local a1, a2, a3 = tooltip:GetAnchorType()
        -- if the owner exists, and has a OnEnter function we simply call that again to force the tooltip to reload and our original hook will update the tooltip with the desired behavior
        if o1 then
            local oe = o1:GetScript("OnEnter")
            if oe then
                tooltip:Hide()
                pcall(oe, o1)
                return
            end
        end
        -- if the owner is the UIParent we must beware as it might be the fading out unit tooltips that linger, we do not wish to update these as we do not have a valid unit anymore for reference so we just don't do anything instead
        if o1 == UIParent then
            return
        end
        -- if we get this far, we know it's not a unit, not a owner with a OnEnter, and it's not a parent of UIParent, so we clear the tooltip, then re-apply the owner, position and anchor, and force it to draw the profile once more on the tooltip
        tooltip:Hide()
        if o1 then
            o2 = a1
            if p4 then
                o3 = p4
            end
            if p5 then
                o4 = p5
            end
            tooltip:SetOwner(o1, o2, o3, o4)
        end
        if p1 then
            tooltip:SetPoint(p1, p2, p3, p4, p5)
        end
        if not o1 and a1 then
            tooltip:SetAnchorType(a1, a2, a3)
        end
        -- based on the type, call the appropriate function, and in worst case scenario we hide the tooltip
        if stateType == StateType.Profile then
            if UnitExists(unit) then
                render:ShowProfile(tooltip, unit, faction, options, args, region)
            else
                render:ShowProfile(tooltip, name, realm, faction, options, args, region)
            end
        elseif stateType == StateType.Keystone then
            tooltip:SetHyperlink(args.link)
        else
            tooltip:Hide()
        end
    end

    local function OnModifierStateChanged()
        for tooltip, state in pairs(tooltipStates) do
            -- we only want to update tooltips that have a valid state (i.e. in use and visible)
            if state.success and tooltip:IsShown() then
                UpdateTooltip(tooltip, state)
            end
        end
    end

    callback:RegisterEvent(OnModifierStateChanged, "MODIFIER_STATE_CHANGED")

end

-- public.lua (global)
-- dependencies: module, util, provider, render
do

    local util = ns:GetModule("Util") ---@type UtilModule
    local provider = ns:GetModule("Provider") ---@type ProviderModule
    local render = ns:GetModule("Render") ---@type RenderModule

    -- TODO: we have a long road a head of us... debugstack(0)
    local function IsSafeCall()
        return true
    end

    local unsafe = false

    local function IsSafe()
        if unsafe then
            return false
        end
        if not IsSafeCall() then
            unsafe = true
            ns.Print("Error: Another AddOn has modified Raider.IO and is most likely forcing it to return invalid data. Please disable other addons until this message disappears.")
            return false
        end
        return true
    end

    local pristine = {
        AddProvider = function(...)
            return provider:AddProvider(...)
        end,
        GetProfile = function(arg1, arg2, arg3, ...)
            local name, realm, faction = arg1, arg2, arg3
            local _, _, unitIsPlayer = util:IsUnit(arg1, arg2)
            if unitIsPlayer then
                name, realm = util:GetNameRealm(arg1)
                faction = util:GetFaction(arg1)
            elseif type(arg1) == "string" then
                if arg1:find("-", nil, true) then
                    name, realm = util:GetNameRealm(arg1)
                    faction = arg2
                    return provider:GetProfile(name, realm, faction, arg3, ...)
                else
                    name, realm = util:GetNameRealm(arg1, arg2)
                end
            end
            return provider:GetProfile(name, realm, faction, ...)
        end,
        ShowProfile = function(tooltip, ...)
            if type(tooltip) ~= "table" or type(tooltip.GetObjectType) ~= "function" or tooltip:GetObjectType() ~= "GameTooltip" then
                return
            end
            return render:ShowProfile(tooltip, ...)
        end,
        GetScoreColor = function(score, ...)
            if type(score) ~= "number" then
                score = 0
            end
            return util:GetScoreColor(score, ...)
        end,
        GetScoreForKeystone = function(level)
            if not level then return end
            local base = ns.KEYSTONE_LEVEL_TO_SCORE[level]
            local average = util:GetKeystoneAverageScoreForLevel(level)
            return base, average
        end
    }

    local private = {
        AddProvider = function(...)
            if not IsSafe() then
                return
            end
            return pristine.AddProvider(...)
        end,
        GetProfile = function(...)
            if not IsSafe() then
                return
            end
            return pristine.GetProfile(...)
        end,
        ShowProfile = function(...)
            if not IsSafe() then
                return
            end
            return pristine.ShowProfile(...)
        end,
        GetScoreColor = function(...)
            if not IsSafe() then
                return
            end
            return pristine.GetScoreColor(...)
        end,
        GetScoreForKeystone = function(...)
            if not IsSafe() then
                return
            end
            return pristine.GetScoreForKeystone(...)
        end,
        -- DEPRECATED: these are here just to help mitigate the transition but do avoid using these as they will probably go away during Shadowlands
        ProfileOutput = setmetatable({}, { __index = function() return 0 end }), -- returns 0 for any query
        TooltipProfileOutput = setmetatable({}, { __index = function() return 0 end }), -- returns 0 for any query
        DataProvider = setmetatable({}, { __index = function() return 0 end }), -- returns 0 for any query
        HasPlayerProfile = function(...) return _G.RaiderIO.GetProfile(...) end, -- passes the request to the GetProfile API (if its there then it exists)
        GetPlayerProfile = function(mask, ...) return _G.RaiderIO.GetProfile(...) end, -- skips the mask and passes the rest to the GetProfile API
        ShowTooltip = function(tooltip, mask, ...) return _G.RaiderIO.ShowProfile(tooltip, ...) end, -- skips the mask and passes the rest to the ShowProfile API
        GetRaidDifficultyColor = function(difficulty) local rd = ns.RAID_DIFFICULTY[difficulty] local t if rd then t = { rd.color[1], rd.color[2], rd.color[3], rd.color.hex } end return t end, -- returns the color table for the queried raid difficulty
        GetScore = function() end, -- deprecated early BfA so we just return nothing
    }

    ---@class RaiderIOInterface
    ---@field public AddProvider function @For internal RaiderIO use only. Please do not call this function.
    ---@field public GetProfile function @Returns a table containing the characters profile and data from the different data providers like mythic keystones, raiding and pvp. Usage: `RaiderIO.GetProfile(name, realm, faction[, region])` or `RaiderIO.GetProfile(unit)`
    ---@field public ShowProfile function @Returns true or false depending if the profile could be drawn on the provided tooltip. `RaiderIO.ShowProfile(tooltip, name, realm, faction[, region])` or `RaiderIO.ShowProfile(tooltip, unit, faction[, region])`
    ---@field public GetScoreColor function @Returns the color (r, g, b) for a given score. `RaiderIO.GetScoreColor(score[, isPreviousSeason])`

    ---@type RaiderIOInterface
    _G.RaiderIO = setmetatable({}, {
        __metatable = false,
        __newindex = function()
        end,
        __index = function(self, key)
            return private[key]
        end,
        __call = function(self, key, ...)
            local func = pristine[key]
            if not func then
                return
            end
            return func(...)
        end
    })

end

-- gametooltip.lua
-- dependencies: module, config, util, render
do

    local tooltip = ns:NewModule("GameTooltip") ---@type GameTooltipModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local render = ns:GetModule("Render") ---@type RenderModule

    local function OnTooltipSetUnit(self)
        if not tooltip:IsEnabled() or not config:Get("enableUnitTooltips") then
            return
        end
        if (config:Get("showScoreModifier") and not IsModifierKeyDown()) or (not config:Get("showScoreModifier") and not config:Get("showScoreInCombat") and InCombatLockdown()) then
            return
        end
        local _, unit = self:GetUnit()
        if not unit or not UnitIsPlayer(unit) then
            return
        end
        if util:IsUnitMaxLevel(unit) then
            render:ShowProfile(self, unit)
        end
    end

    local function OnTooltipCleared(self)
        render:ClearTooltip(self)
    end

    local function OnHide(self)
        render:HideTooltip(self)
    end

    function tooltip:CanLoad()
        return config:IsEnabled()
    end

    function tooltip:OnLoad()
        self:Enable()
        GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
        GameTooltip:HookScript("OnTooltipCleared", OnTooltipCleared)
        GameTooltip:HookScript("OnHide", OnHide)
    end

end

-- friendtooltip.lua
-- dependencies: module, config, util, render
do

    local tooltip = ns:NewModule("FriendTooltip") ---@type FriendTooltipModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local render = ns:GetModule("Render") ---@type RenderModule

    local function FriendsTooltip_Show(self)
        if not tooltip:IsEnabled() or not config:Get("enableFriendsTooltips") then
            return
        end
        local button = self.button
        local fullName, faction, level
        if button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
            local bnetIDAccountInfo = C_BattleNet.GetFriendAccountInfo(button.id)
            if bnetIDAccountInfo then
                fullName, faction, level = util:GetNameRealmForBNetFriend(bnetIDAccountInfo.bnetAccountID)
            end
        elseif button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
            local friendInfo = C_FriendList.GetFriendInfoByIndex(button.id)
            if friendInfo then
                fullName, level = friendInfo.name, friendInfo.level
                faction = ns.PLAYER_FACTION
            end
        end
        if not fullName or not util:IsMaxLevel(level) then
            return
        end
        local ownerSet, ownerExisted = util:SetOwnerSafely(GameTooltip, FriendsTooltip, "ANCHOR_BOTTOMRIGHT", -FriendsTooltip:GetWidth(), -4)
        if render:ShowProfile(GameTooltip, fullName, faction, render.Preset.UnitSmartPadding(ownerExisted)) then
            return
        end
        if ownerSet then
            GameTooltip:Hide()
        end
    end

    local function FriendsTooltip_Hide()
        if not tooltip:IsEnabled() or not config:Get("enableFriendsTooltips") then
            return
        end
        GameTooltip:Hide()
    end

    function tooltip:OnLoad()
        self:Enable()
        hooksecurefunc(FriendsTooltip, "Show", FriendsTooltip_Show)
        hooksecurefunc(FriendsTooltip, "Hide", FriendsTooltip_Hide)
    end

end

-- whotooltip.lua
-- dependencies: module, config, util, render
do

    ---@class WhoTooltipModule : Module
    local tooltip = ns:NewModule("WhoTooltip") ---@type WhoTooltipModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local render = ns:GetModule("Render") ---@type RenderModule

    local function OnEnter(self)
        if not self.index or not config:Get("enableWhoTooltips") then
            return
        end
        local info = C_FriendList.GetWhoInfo(self.index)
        if not info or not info.fullName or not util:IsMaxLevel(info.level) then
            return
        end
        local ownerSet, ownerExisted = util:SetOwnerSafely(GameTooltip, self, "ANCHOR_LEFT")
        if render:ShowProfile(GameTooltip, info.fullName, ns.PLAYER_FACTION, render.Preset.UnitSmartPadding(ownerExisted)) then
            return
        end
        if ownerSet then
            GameTooltip:Hide()
        end
    end

    local function OnLeave(self)
        if not self.index or not config:Get("enableWhoTooltips") then
            return
        end
        GameTooltip:Hide()
    end

    local function OnScroll()
        if not config:Get("enableWhoTooltips") then
            return
        end
        GameTooltip:Hide()
        util:ExecuteWidgetHandler(GetMouseFocus(), "OnEnter")
    end

    function tooltip:OnLoad()
        self:Enable()
        for _, button in pairs(WhoListScrollFrame.buttons) do
            button:HookScript("OnEnter", OnEnter)
            button:HookScript("OnLeave", OnLeave)
        end
        hooksecurefunc(WhoListScrollFrame, "update", OnScroll)
    end

end

-- whochatframe.lua
-- dependencies: module, config, util, provider
do

    ---@class WhoChatFrameModule : Module
    local chatframe = ns:NewModule("WhoChatFrame") ---@type WhoChatFrameModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local provider = ns:GetModule("Provider") ---@type ProviderModule

    local RAIDERIO_MP_SCORE = L.RAIDERIO_MP_SCORE:gsub("%.", "|cffffffff|r.") -- TODO: make it part of the locale file like L.RAIDERIO_MP_SCORE_WHOCHAT

    local FORMAT_GUILD = "^" .. util:FormatToPattern(WHO_LIST_GUILD_FORMAT) .. "$"
    local FORMAT = "^" .. util:FormatToPattern(WHO_LIST_FORMAT) .. "$"

    ---@param profile DataProviderCharacterProfile
    local function GetScore(profile)
        local keystoneProfile = profile.mythicKeystoneProfile
        if not keystoneProfile or keystoneProfile.blocked then
            return
        end
        local currentScore = keystoneProfile.mplusCurrent.score
        local mainCurrentScore = keystoneProfile.mplusMainCurrent.score
        local text
        if currentScore > 0 then
            text = RAIDERIO_MP_SCORE .. ": " .. currentScore .. ". "
        end
        if mainCurrentScore > currentScore and config:Get("showMainsScore") then
            text = (text or "") .. "(" .. L.MAINS_SCORE .. ": " .. mainCurrentScore .. "). "
        end
        return text
    end

    local function EventFilter(self, event, text, ...)
        if event ~= "CHAT_MSG_SYSTEM" or not config:Get("enableWhoMessages") then
            return false
        end
        local nameLink, name, level, race, class, guild, zone = text:match(FORMAT_GUILD)
        if not nameLink then
            return false
        end
        if not zone then
            guild = nil
            nameLink, name, level, race, class, zone = text:match(FORMAT)
        end
        if not nameLink or not level or not util:IsMaxLevel(tonumber(level)) then
            return false
        end
        local name, realm = util:GetNameRealm(nameLink)
        local profile = provider:GetProfile(name, realm, ns.PLAYER_FACTION)
        if not profile or not profile.mythicKeystoneProfile or profile.mythicKeystoneProfile.blocked then
            return false
        end
        local score = GetScore(profile)
        if not score then
            return false
        end
        return false, text .. " - " .. score, ...
    end

    function chatframe:CanLoad()
        return config:IsEnabled()
    end

    function chatframe:OnLoad()
        self:Enable()
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", EventFilter)
    end

end

-- fanfare.lua
-- dependencies: module, config, util, provider
do

    ---@class FanfareModule : Module
    local fanfare = ns:NewModule("Fanfare") ---@type FanfareModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local provider = ns:GetModule("Provider") ---@type ProviderModule

    local KEYSTONE_DATE

    local function GetGroupMembers()
        ---@type DataProviderCharacterProfile[]
        local profiles = {}
        local index = 0
        local fromIndex, toIndex = IsInRaid() and 1 or 0, GetNumGroupMembers()
        for i = fromIndex, toIndex do
            local unit = i == 0 and "player" or (IsInRaid() and "raid" or "party") .. i
            if UnitExists(unit) then
                local name, realm = util:GetNameRealm(unit)
                if name then
                    index = index + 1
                    profiles[index] = provider:GetProfile(name, realm, ns.PLAYER_FACTION) or false
                end
            end
        end
        return profiles
    end

    ---@class DungeonDifference
    ---@field public member DataProviderCharacterProfile
    ---@field public confidence number @The confidence score for this prediction. 1 = guaranteed, 2 = possibly (should check website), 3 = must check website
    ---@field public levelDiff number @The difference between current and the latest run
    ---@field public fractionalTimeDiff number @The difference between current and the latest run
    ---@field public isUpgrade boolean @If this diff is an improvement in score

    ---@param level1 number
    ---@param level2 number
    ---@param fractionalTime1 number
    ---@param fractionalTime2 number
    ---@return number, number, number, number @`arg1 = 1=left/2=right`, `arg2 = level`, `arg3 = fractionalTime`, `arg4 = confidence`
    local function CompareLevelAndFractionalTime(level1, level2, fractionalTime1, fractionalTime2)
        if not level1 or not fractionalTime1 then
            return 2, level2, fractionalTime2, 3
        elseif not level2 or not fractionalTime2 then
            return 1, level1, fractionalTime1, 3
        elseif (level1 == level2 and fractionalTime1 < fractionalTime2) or (level1 > level2 and fractionalTime1 <= (1 + (level1 - level2) * 0.1)) then
            return 1, level1, fractionalTime1, level1 == level2 and 1 or 2
        end
        return 2, level2, fractionalTime2, level1 == level2 and 1 or 2
    end

    ---@param run SortedDungeon
    ---@param currentRun SortedDungeon
    local function GetDungeonUpgrade(run, currentRun)
        if not run or not currentRun then
            return
        end
        local side, _, _, confidence = CompareLevelAndFractionalTime(run.level, currentRun.level, run.fractionalTime, currentRun.fractionalTime)
        ---@type DungeonDifference
        local diff = {}
        diff.confidence = confidence
        diff.levelDiff = 0
        diff.fractionalTimeDiff = 0
        if side == 1 then
            diff.levelDiff = currentRun.level - run.level
            diff.fractionalTimeDiff = currentRun.fractionalTime - run.fractionalTime
        end
        diff.isUpgrade = diff.levelDiff > 0 or (diff.levelDiff == 0 and diff.fractionalTimeDiff < 0)
        return diff
    end

    ---@param run1 SortedDungeon
    ---@param diff1 DungeonDifference
    ---@param run2 SortedDungeon
    ---@param diff2 DungeonDifference
    ---@return SortedDungeon, DungeonDifference
    local function CompareDungeonUpgrades(run1, diff1, run2, diff2)
        if not run2 then
            return run1, diff1
        elseif not run1 then
            return run2, diff2
        end
        local side = CompareLevelAndFractionalTime(run1.level, run2.level, run1.fractionalTime, run2.fractionalTime)
        if side == 1 then
            return run1, diff1
        end
        return run2, diff2
    end

    ---@param member DataProviderCharacterProfile
    ---@param dungeon Dungeon
    local function GetSortedDungeonForMember(member, dungeon)
        for i = 1, #member.mythicKeystoneProfile.sortedDungeons do
            local sortedDungeon = member.mythicKeystoneProfile.sortedDungeons[i]
            if sortedDungeon.dungeon == dungeon then
                if sortedDungeon.level > 0 then
                    return sortedDungeon
                end
                return
            end
        end
    end

    ---@param member DataProviderCharacterProfile
    ---@param currentRun SortedDungeon
    ---@return SortedDungeon, DungeonDifference @`arg1 = isUpgrade`, `arg2 = SortedDungeon`, `arg3 = DungeonDifference`
    local function GetCachedRunAndUpgrade(member, currentRun)
        local cachedRuns = _G.RaiderIO_CachedRuns
        if not cachedRuns then
            cachedRuns = {}
            _G.RaiderIO_CachedRuns = cachedRuns
        end
        if not cachedRuns.date then
            cachedRuns.date = KEYSTONE_DATE
        end
        if KEYSTONE_DATE > cachedRuns.date then
            table.wipe(cachedRuns)
        end
        local memberCachedRuns = cachedRuns[member.guid]
        if not memberCachedRuns then
            memberCachedRuns = {}
            cachedRuns[member.guid] = memberCachedRuns
        end
        local dbRun = GetSortedDungeonForMember(member, currentRun.dungeon)
        local dbRunUpgrade = GetDungeonUpgrade(dbRun, currentRun)
        local cacheRun = memberCachedRuns[currentRun.dungeon.index] ---@type SortedDungeon
        local cacheUpgrade = GetDungeonUpgrade(cacheRun, currentRun)
        local bestRun, bestUpgrade = CompareDungeonUpgrades(dbRun, dbRunUpgrade, cacheRun, cacheUpgrade)
        local bestIsCurrentRun
        if not bestRun then
            bestIsCurrentRun = true
            bestRun = CopyTable(currentRun)
            bestUpgrade = {}
        elseif bestRun == dbRun then
            bestRun = CopyTable(dbRun)
        end
        memberCachedRuns[currentRun.dungeon.index] = bestRun
        local side = CompareLevelAndFractionalTime(bestRun.level, currentRun.level, bestRun.fractionalTime, currentRun.fractionalTime)
        if bestIsCurrentRun or side == 2 then
            bestUpgrade.confidence = 1
            if bestIsCurrentRun then
                bestUpgrade.levelDiff = currentRun.level
                bestUpgrade.fractionalTimeDiff = -currentRun.fractionalTime
            else
                bestUpgrade.levelDiff = currentRun.level - bestRun.level
                bestUpgrade.fractionalTimeDiff = currentRun.fractionalTime - bestRun.fractionalTime
            end
            bestUpgrade.isUpgrade = bestIsCurrentRun or bestUpgrade.levelDiff > 0 or (bestUpgrade.levelDiff == 0 and bestUpgrade.fractionalTimeDiff < 0)
            bestRun.chests = currentRun.chests
            bestRun.level = currentRun.level
            bestRun.fractionalTime = currentRun.fractionalTime
        end
        return bestRun, bestUpgrade
    end

    ---@param members DataProviderCharacterProfile[] @Table of group member profiles
    ---@param currentRun SortedDungeon
    local function GetDungeonUpgrades(members, currentRun)
        ---@type DungeonDifference[]
        local upgrades = {}
        local index = 0
        local hasAnyUpgrades
        for i = 1, #members do
            local member = members[i]
            if member and member.mythicKeystoneProfile and not member.mythicKeystoneProfile.blocked then
                local run, upgrade = GetCachedRunAndUpgrade(member, currentRun)
                hasAnyUpgrades = hasAnyUpgrades or upgrade.isUpgrade
                upgrade.member = member
                index = index + 1
                upgrades[index] = upgrade
            end
        end
        return upgrades, hasAnyUpgrades
    end

    local LEVEL_UP_EFFECT = {
        yellow = 166464, -- spells/levelup/levelup.m2 (yellow)
        green = 166698, -- spells/reputationlevelup.m2 (green)
        red = 240947, -- spells/levelup_red.m2 (red)
        blue = 340883, -- spells/levelup_blue.m2 (blue)
        x = -18,
        y = 0,
        z = -10,
        facing = 0,
        duration = 1.5
    }

    local function DecorationFrame_OnShow(self)
        self:SetAlpha(0)
        self.AnimIn:Play()
        if self.model then
            self.Sparks:Show()
            self.Sparks:SetModel(self.model)
        end
    end

    local function DecorationFrame_OnHide(self)
        self.AnimIn:Stop()
        self.Sparks:Hide()
    end

    local function DecorationFrame_AnimIn_Sparks_OnFinished(self)
        self.frame.Sparks:Hide()
    end

    local PERCENTILE_LOWEST = 0.01 -- 0.01%
    local PERCENTILE_LOWEST_DECIMAL = PERCENTILE_LOWEST/100 -- % to decimal

    ---@param upgrade DungeonDifference
    local function DecorationFrame_SetUp(self, upgrade)
        if upgrade.isUpgrade then
            if not upgrade.confidence or upgrade.confidence > 1 then
                self.model = LEVEL_UP_EFFECT.yellow
                self.Texture:SetAtlas("loottoast-arrow-orange")
            else
                self.model = LEVEL_UP_EFFECT.green
                self.Texture:SetAtlas("loottoast-arrow-green")
            end
            if upgrade.levelDiff and upgrade.levelDiff > 0 then
                self.Text:SetText(upgrade.levelDiff .. (upgrade.levelDiff > 1 and " levels" or " level") .. " higher") -- TODO: locale
            elseif upgrade.fractionalTimeDiff and upgrade.fractionalTimeDiff < 0 then
                local p = floor(upgrade.fractionalTimeDiff * -10000) / 100
                if p > 0 then
                    self.Text:SetText(p .. "% faster") -- TODO: locale
                else
                    self.Text:SetText("~" .. PERCENTILE_LOWEST .. "% faster") -- TODO: locale
                end
            else
                self.Text:SetText()
            end
        else
            self.model = nil
            self.Texture:SetTexture()
            if upgrade.levelDiff and upgrade.levelDiff < 0 then
                self.Text:SetText((-upgrade.levelDiff) .. (upgrade.levelDiff > 1 and " levels" or " level") .. " lower") -- TODO: locale
            elseif upgrade.levelDiff == 0 and upgrade.fractionalTimeDiff and upgrade.fractionalTimeDiff > 0 then
                local p = floor(upgrade.fractionalTimeDiff * 10000) / 100
                if p > 0 then
                    self.Text:SetText(p .. "% slower") -- TODO: locale
                else
                    self.Text:SetText("~" .. PERCENTILE_LOWEST .. "% slower") -- TODO: locale
                end
            elseif upgrade.levelDiff == 0 and upgrade.fractionalTimeDiff and upgrade.fractionalTimeDiff <= PERCENTILE_LOWEST_DECIMAL then
                self.Text:SetText("No change") -- TODO: locale
            else
                self.Text:SetText()
            end
        end
    end

    local function CreateDecorationFrame()
        local frame = CreateFrame("Frame")
        frame:Hide()
        frame:SetScript("OnShow", DecorationFrame_OnShow)
        frame:SetScript("OnHide", DecorationFrame_OnHide)
        frame.SetUp = DecorationFrame_SetUp
        do
            frame.Texture = frame:CreateTexture(nil, "ARTWORK")
            frame.Texture:SetPoint("CENTER")
            frame.Texture:SetSize(32, 32)
            frame.Texture:SetTexture()
        end
        do
            frame.Text = frame:CreateFontString(nil, "ARTWORK", "ChatFontNormal")
            frame.Text:SetAllPoints()
            frame.Text:SetJustifyH("CENTER")
            frame.Text:SetJustifyV("MIDDLE")
            frame.Text:SetText()
        end
        do
            frame.Sparks = CreateFrame("PlayerModel", nil, frame)
            frame.Sparks:Hide()
            frame.Sparks:SetAllPoints()
            frame.Sparks:SetModel(LEVEL_UP_EFFECT.yellow)
            frame.Sparks:SetPortraitZoom(1)
            frame.Sparks:ClearTransform()
            frame.Sparks:SetPosition(LEVEL_UP_EFFECT.x, LEVEL_UP_EFFECT.y, LEVEL_UP_EFFECT.z)
            frame.Sparks:SetFacing(LEVEL_UP_EFFECT.facing)
        end
        do
            frame.AnimIn = frame:CreateAnimationGroup()
            frame.AnimIn:SetToFinalAlpha(true)
            local alpha = frame.AnimIn:CreateAnimation("Alpha")
            alpha:SetOrder(1)
            alpha:SetStartDelay(0.2)
            alpha:SetDuration(0.25)
            alpha:SetFromAlpha(0)
            alpha:SetToAlpha(1)
            local scale = frame.AnimIn:CreateAnimation("Scale")
            scale:SetOrder(1)
            scale:SetStartDelay(0.2)
            scale:SetDuration(0.25)
            scale:SetFromScale(5, 5)
            scale:SetToScale(1, 1)
            local sparks = frame.AnimIn:CreateAnimation("Scale")
            sparks:SetOrder(1)
            sparks:SetStartDelay(0)
            sparks:SetDuration(LEVEL_UP_EFFECT.duration)
            sparks:SetFromScale(1, 1)
            sparks:SetToScale(1, 1)
            sparks.frame = frame
            sparks:SetScript("OnFinished", DecorationFrame_AnimIn_Sparks_OnFinished)
        end
        return frame
    end

    local frameHooks = {}
    local frames = {}

    local function OnFrameHidden()
        for _, frame in pairs(frames) do
            frame:Hide()
        end
    end

    ---@param upgrade DungeonDifference
    local function DecoratePartyMember(partyMember, upgrade)
        if not partyMember then
            return
        end
        local frame = frames[partyMember]
        if not frame then
            frame = CreateDecorationFrame()
            frame:SetParent(partyMember)
            frame:SetAllPoints()
            frames[partyMember] = frame
        end
        frame:SetUp(upgrade)
        frame:Show()
    end

    ---@param upgrade DungeonDifference
    local function ShowUpgrade(frame, upgrade)
        local sortedUnitTokens = frame:GetSortedPartyMembers()
        for i = 1, #sortedUnitTokens do
            local unit = sortedUnitTokens[i]
            local name, realm = util:GetNameRealm(unit)
            if name and name == upgrade.member.name and realm == upgrade.member.realm then
                DecoratePartyMember(frame.PartyMembers[i], upgrade)
                break
            end
        end
    end

    ---@param dungeon Dungeon
    local function GetCurrentRun(dungeon, level, fractionalTime, keystoneUpgradeLevels)
        ---@type SortedDungeon
        local run = {}
        run.chests = keystoneUpgradeLevels
        run.dungeon = dungeon
        run.fractionalTime = fractionalTime
        run.level = level
        return run
    end

    ---@class ChallengeModeCompleteBannerData
    ---@field public mapID number @Keystone instance ID
    ---@field public level number @Keystone level
    ---@field public time number @Run duration in seconds
    ---@field public onTime boolean @true if on time, otherwise false if depleted
    ---@field public keystoneUpgradeLevels number @The amount of chests/level upgrades

    ---@param bannerData ChallengeModeCompleteBannerData
    local function OnChallengeModeCompleteBannerPlay(frame, bannerData)
        if not KEYSTONE_DATE or not bannerData or not bannerData.mapID or not bannerData.time or not bannerData.level then
            return
        end
        if not fanfare:IsEnabled() then
            return
        end
        local dungeon = util:GetDungeonByKeystoneID(bannerData.mapID)
        if not dungeon then
            return
        end
        local _, _, timeLimit = C_ChallengeMode.GetMapUIInfo(bannerData.mapID)
        if not timeLimit or timeLimit == 0 then
            return
        end
        local fractionalTime = bannerData.time/timeLimit
        local members = GetGroupMembers()
        local currentRun = GetCurrentRun(dungeon, bannerData.level, fractionalTime, bannerData.keystoneUpgradeLevels or 0)
        local upgrades, hasAnyUpgrades = GetDungeonUpgrades(members, currentRun)
        if not frameHooks[frame] then
            frameHooks[frame] = true
            frame:HookScript("OnHide", OnFrameHidden)
        end
        for i = 1, #upgrades do
            ShowUpgrade(frame, upgrades[i])
        end
    end

    local function CheckCachedData()
        local cachedRuns = _G.RaiderIO_CachedRuns
        if not cachedRuns then
            return
        end
        if KEYSTONE_DATE and cachedRuns.date and KEYSTONE_DATE > cachedRuns.date then
            table.wipe(cachedRuns)
            return
        end
        local dungeons = ns:GetDungeonData()
        for _, memberCachedRuns in pairs(cachedRuns) do
            if type(memberCachedRuns) == "table" then
                for i = 1, #dungeons do
                    ---@type SortedDungeon
                    local cachedRun = memberCachedRuns[i]
                    if cachedRun then
                        cachedRun.dungeon = dungeons[i]
                    end
                end
            end
        end
    end

    function fanfare:CanLoad()
        return config:IsEnabled() and _G.ChallengeModeCompleteBanner and config:Get("debugMode") -- TODO: do not load this module by default (it's not yet tested well enough) but we do load it if debug mode is enabled
    end

    function fanfare:OnLoad()
        self:Enable()
        KEYSTONE_DATE = provider:GetProvidersDates()
        CheckCachedData()
        hooksecurefunc(_G.ChallengeModeCompleteBanner, "PlayBanner", OnChallengeModeCompleteBannerPlay)
    end

    -- DEBUG: force show the end screen for UR+15 (1950 is the timer)
    -- /run wipe(RaiderIO_CachedRuns)
    -- /run C_ChallengeMode.GetCompletionInfo=function()return 251, 15, 1950, true, 1, false end
    -- /run for _,f in ipairs({GetFramesRegisteredForEvent("CHALLENGE_MODE_COMPLETED")})do f:GetScript("OnEvent")(f,"CHALLENGE_MODE_COMPLETED")end

end

-- profile.lua
-- dependencies: module, callback, config, render
do

    ---@class ProfileModule : Module
    local profile = ns:NewModule("Profile") ---@type ProfileModule
    local callback = ns:GetModule("Callback") ---@type CallbackModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local render = ns:GetModule("Render") ---@type RenderModule

    local function IsFrame(widget)
        return type(widget) == "table" and type(widget.GetObjectType) == "function"
    end

    local FALLBACK_ANCHOR = _G.PVEFrame
    local FALLBACK_ANCHOR_STRATA = "LOW"
    local FALLBACK_FRAME = _G.UIParent
    local FALLBACK_FRAME_STRATA = "LOW"

    local tooltip

    ---@param isDraggable boolean
    ---@return boolean @true if frame is draggable, otherwise false.
    local function SetDraggable(isDraggable)
        tooltip:EnableMouse(isDraggable)
        tooltip:SetMovable(isDraggable)
        return isDraggable
    end

    ---@param anchorFrame table @The widget to anchor
    ---@param frameStrata string @The frame strata "LOW", "HIGH", "DIALOG", etc.
    ---@return table, string @Returns the used frame and strata after logical checks have been performed on the provided frame and strata values.
    local function SetAnchor(anchorFrame, frameStrata)
        anchorFrame = IsFrame(anchorFrame) and anchorFrame or FALLBACK_ANCHOR
        local frame = anchorFrame or FALLBACK_ANCHOR
        local strata = frameStrata or FALLBACK_ANCHOR_STRATA
        tooltip:SetParent(frame)
        tooltip:SetOwner(anchorFrame, "ANCHOR_NONE")
        tooltip:ClearAllPoints()
        tooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, 0)
        tooltip:SetFrameStrata(frameStrata or FALLBACK_ANCHOR_STRATA)
        return frame, strata
    end

    ---@return table, string @Returns the used frame and strata after logical checks have been performed on the provided frame and strata values.
    local function SetUserAnchor()
        local profilePoint = config:Get("profilePoint") ---@type ConfigProfilePoint
        tooltip:SetParent(FALLBACK_FRAME)
        tooltip:SetOwner(FALLBACK_FRAME, "ANCHOR_NONE")
        tooltip:ClearAllPoints()
        local p = profilePoint.point or "CENTER"
        local x = profilePoint.x or 0
        local y = profilePoint.y or 0
        tooltip:SetPoint(p, FALLBACK_FRAME, p, x, y)
        tooltip:SetFrameStrata(FALLBACK_FRAME_STRATA)
        return FALLBACK_FRAME, FALLBACK_FRAME_STRATA
    end

    ---@return boolean, table, string @arg1 returns true if position is automatic, otherwise false. `arg2+` are the same as returned from `SetAnchor` or `SetUserAnchor`.
    local function UpdatePosition()
        SetDraggable(not config:Get("positionProfileAuto") and not config:Get("lockProfile"))
        if config:Get("positionProfileAuto") then
            return true, SetAnchor(FALLBACK_ANCHOR, FALLBACK_ANCHOR_STRATA)
        else
            return false, SetUserAnchor()
        end
    end

    local function Tooltip_OnShow()
        if GameTooltip_SetBackdropStyle then
            GameTooltip_SetBackdropStyle(tooltip, GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT)
        end
    end

    local function Tooltip_OnDragStart()
        tooltip:StartMoving()
    end

    local function Tooltip_OnDragStop()
        tooltip:StopMovingOrSizing()
        local point, _, _, x, y = tooltip:GetPoint() -- TODO: improve this to store a corner so that when the tip is resized the corner is the anchor point and not the center as that makes it very wobbly and unpleasant to look at
        local profilePoint = config:Get("profilePoint") ---@type ConfigProfilePoint
        config:Set("profilePoint", profilePoint)
        profilePoint.point, profilePoint.x, profilePoint.y = point, x, y
    end

    local function CreateTooltip()
        local tooltip = CreateFrame("GameTooltip", addonName .. "ProfileTooltip", UIParent, "GameTooltipTemplate")
        tooltip:SetClampedToScreen(true)
        tooltip:RegisterForDrag("LeftButton")
        tooltip:SetScript("OnShow", Tooltip_OnShow)
        tooltip:SetScript("OnDragStart", Tooltip_OnDragStart)
        tooltip:SetScript("OnDragStop", Tooltip_OnDragStop)
        return tooltip
    end

    local function PVEFrame_OnShow()
        if not PVEFrame:IsShown() or not config:Get("showRaiderIOProfile") then
            return
        end
        profile:ShowProfile(false, "player", ns.PLAYER_FACTION)
    end

    local function PVEFrame_OnHide()
        profile:HideProfile()
    end

    local function OnSettingsSaved()
        if not profile:IsEnabled() then
            return
        end
        UpdatePosition()
        profile:HideProfile()
    end

    function profile:CanLoad()
        return not tooltip and config:IsEnabled() and _G.PVEFrame
    end

    function profile:OnLoad()
        self:Enable()
        tooltip = CreateTooltip()
        PVEFrame:HookScript("OnShow", PVEFrame_OnShow)
        PVEFrame:HookScript("OnHide", PVEFrame_OnHide)
        UpdatePosition()
        callback:RegisterEvent(OnSettingsSaved, "RAIDERIO_SETTINGS_SAVED")
    end

    ---@return boolean, boolean @arg1 is true if the toggle was successfull, otherwise false if we can't toggle right now. arg2 is set to true if the frame is now draggable, otherwise false for locked.
    function profile:ToggleDrag()
        if not profile:IsEnabled() then
            return false
        end
        if config:Get("positionProfileAuto") then
            ns.Print(L.WARNING_LOCK_POSITION_FRAME_AUTO)
            return false
        end
        local isLocking = not config:Get("lockProfile")
        config:Set("lockProfile", isLocking)
        if isLocking then
            ns.Print(L.LOCKING_PROFILE_FRAME)
        else
            ns.Print(L.UNLOCKING_PROFILE_FRAME)
        end
        return true, SetDraggable(not isLocking)
    end

    local function IsPlayer(unit, name, realm, region)
        if unit and UnitExists(unit) then
            return UnitIsUnit(unit, "player")
        end
        return name == ns.PLAYER_NAME and realm == ns.PLAYER_REALM and (not region or region == ns.PLAYER_REGION)
    end

    ---@return boolean
    function profile:ShowProfile(anchor, ...)
        if not profile:IsEnabled() or not config:Get("showRaiderIOProfile") then
            return
        end
        local unit, name, realm, faction, options, args, region = render.GetQuery(...)
        options = options or render.Preset.Profile()
        local positionProfileAuto = UpdatePosition()
        if positionProfileAuto and IsFrame(anchor) then
            SetAnchor(anchor, anchor:GetFrameStrata())
        end
        local isPlayer = IsPlayer(unit, name, realm, region)
        if not isPlayer and config:Get("enableProfileModifier") and band(options, render.Flags.IGNORE_MOD) ~= render.Flags.IGNORE_MOD then
            if config:Get("inverseProfileModifier") == (config:Get("alwaysExtendTooltip") or band(options, render.Flags.MOD) == render.Flags.MOD) then
                unit, name, realm, faction = "player", nil, nil, ns.PLAYER_FACTION
            end
        end
        local success
        if not isPlayer or not config:Get("hidePersonalRaiderIOProfile") then
            if unit and UnitExists(unit) then
                success = render:ShowProfile(tooltip, unit, faction, options, args, region)
            else
                success = render:ShowProfile(tooltip, name, realm, faction, options, args, region)
            end
        end
        if not success then
            profile:HideProfile()
        end
        return success
    end

    function profile:HideProfile()
        if not profile:IsEnabled() then
            return
        end
        render:HideTooltip(tooltip)
    end

end

-- lfgtooltip.lua
-- dependencies: module, config, util, render, profile
do

    ---@class LfgTooltipModule : Module
    local tooltip = ns:NewModule("LfgTooltip") ---@type LfgTooltipModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local render = ns:GetModule("Render") ---@type RenderModule
    local profile = ns:GetModule("Profile") ---@type ProfileModule

    ---@class LfgResult
    ---@field public activityID number|nil
    ---@field public leaderName string
    ---@field public keystoneLevel number

    ---@type LfgResult
    local currentResult = {}

    local hooked = {}
    local OnEnter
    local OnLeave

    local function SetSearchEntry(tooltip, resultID, autoAcceptOption)
        if not config:Get("enableLFGTooltips") then
            return
        end
        local entry = C_LFGList.GetSearchResultInfo(resultID)
        if not entry or not entry.leaderName then
            table.wipe(currentResult)
            return
        end
        currentResult.activityID = entry.activityID
        currentResult.leaderName = entry.leaderName
        currentResult.keystoneLevel = util:GetKeystoneLevelFromText(entry.title) or util:GetKeystoneLevelFromText(entry.description) or 0
        render:ShowProfile(tooltip, currentResult.leaderName, ns.PLAYER_FACTION, render.Preset.Unit(render.Flags.MOD_STICKY), currentResult)
        profile:ShowProfile(tooltip, currentResult.leaderName, ns.PLAYER_FACTION, currentResult)
    end

    local function HookApplicantButtons(buttons)
        for _, button in pairs(buttons) do
            if not hooked[button] then
                hooked[button] = true
                button:HookScript("OnEnter", OnEnter)
                button:HookScript("OnLeave", OnLeave)
            end
        end
    end

    local function ShowApplicantProfile(parent, applicantID, memberIdx)
        local fullName = C_LFGList.GetApplicantMemberInfo(applicantID, memberIdx)
        if not fullName then
            return false
        end
        local ownerSet, ownerExisted = util:SetOwnerSafely(GameTooltip, parent, "ANCHOR_NONE", 0, 0)
        if render:ShowProfile(GameTooltip, fullName, ns.PLAYER_FACTION, render.Preset.Unit(render.Flags.MOD_STICKY), currentResult) then
            return true, fullName
        end
        if ownerSet then
            GameTooltip:Hide()
        end
        return false
    end

    function OnEnter(self)
        local entry = C_LFGList.GetActiveEntryInfo()
        if entry then
            currentResult.activityID = entry.activityID
        end
        if not currentResult.activityID or not config:Get("enableLFGTooltips") then
            return
        end
        if self.applicantID and self.Members then
            HookApplicantButtons(self.Members)
        elseif self.memberIdx then
            local shown, fullName = ShowApplicantProfile(self, self:GetParent().applicantID, self.memberIdx)
            if shown then
                profile:ShowProfile(GameTooltip, fullName, ns.PLAYER_FACTION, currentResult)
            else
                profile:ShowProfile(false, "player", ns.PLAYER_FACTION, currentResult)
            end
        end
    end

    function OnLeave(self)
        GameTooltip:Hide()
        profile:ShowProfile(false, "player", ns.PLAYER_FACTION)
    end

    function tooltip:CanLoad()
        return profile:IsEnabled() and _G.LFGListSearchPanelScrollFrameButton1 and _G.LFGListApplicationViewerScrollFrameButton1
    end

    function tooltip:OnLoad()
        self:Enable()
        -- the player looking at groups
        hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", SetSearchEntry)
        for i = 1, 10 do
            local button = _G["LFGListSearchPanelScrollFrameButton" .. i]
            button:HookScript("OnLeave", OnLeave)
        end
        -- the player hosting a group looking at applicants
        for i = 1, 14 do
            local button = _G["LFGListApplicationViewerScrollFrameButton" .. i]
            button:HookScript("OnEnter", OnEnter)
            button:HookScript("OnLeave", OnLeave)
        end
        -- remove the shroud and allow hovering over people even when not the group leader
        do
            local f = _G.LFGListFrame.ApplicationViewer.UnempoweredCover
            f:EnableMouse(false)
            f:EnableMouseWheel(false)
            f:SetToplevel(false)
        end
    end

end

-- guildtooltip.lua
-- dependencies: module, config, util, render
do

    ---@class GuildTooltipModule : Module
    local tooltip = ns:NewModule("GuildTooltip") ---@type GuildTooltipModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local render = ns:GetModule("Render") ---@type RenderModule

    local function OnEnter(self)
        if not self.guildIndex or not config:Get("enableGuildTooltips") then
            return
        end
        local fullName, _, _, level = GetGuildRosterInfo(self.guildIndex)
        if not fullName or not util:IsMaxLevel(level) then
            return
        end
        local ownerSet, ownerExisted = util:SetOwnerSafely(GameTooltip, self, "ANCHOR_TOPLEFT", 0, 0)
        if render:ShowProfile(GameTooltip, fullName, ns.PLAYER_FACTION, render.Preset.UnitSmartPadding(ownerExisted)) then
            return
        end
        if ownerSet then
            GameTooltip:Hide()
        end
    end

    local function OnLeave(self)
        if not self.guildIndex or not config:Get("enableGuildTooltips") then
            return
        end
        GameTooltip:Hide()
    end

    local function OnScroll()
        if not config:Get("enableGuildTooltips") then
            return
        end
        GameTooltip:Hide()
        util:ExecuteWidgetHandler(GetMouseFocus(), "OnEnter")
    end

    function tooltip:CanLoad()
        return _G.GuildFrame
    end

    function tooltip:OnLoad()
        self:Enable()
        for i = 1, #GuildRosterContainer.buttons do
            local button = GuildRosterContainer.buttons[i]
            button:HookScript("OnEnter", OnEnter)
            button:HookScript("OnLeave", OnLeave)
        end
        hooksecurefunc(GuildRosterContainer, "update", OnScroll)
    end

end

-- communitytooltip.lua
-- dependencies: module, config, util, render
do

    ---@class CommunityTooltipModule : Module
    local tooltip = ns:NewModule("CommunityTooltip") ---@type CommunityTooltipModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local render = ns:GetModule("Render") ---@type RenderModule

    local hooked = {}
    local completed

    local function OnEnter(self)
        if not config:Get("enableGuildTooltips") then
            return
        end
        local clubType
        local nameAndRealm
        local level
        local faction = ns.PLAYER_FACTION
        if type(self.GetMemberInfo) == "function" then
            local info = self:GetMemberInfo()
            clubType = info.clubType
            nameAndRealm = info.name
            level = info.level
        elseif type(self.cardInfo) == "table" then
            nameAndRealm = util:GetNameRealm(self.cardInfo.guildLeader)
        else
            return
        end
        if type(self.GetLastPosterGUID) == "function" then
            local playerGUID = self:GetLastPosterGUID()
            if playerGUID then
                local _, _, _, race = GetPlayerInfoByGUID(playerGUID)
                if race then
                    faction = util:GetFactionFromRace(race, faction)
                end
            end
        end
        if (clubType and clubType ~= Enum.ClubType.Guild and clubType ~= Enum.ClubType.Character) or not nameAndRealm or not util:IsMaxLevel(level, true) then
            return
        end
        local ownerSet, ownerExisted = util:SetOwnerSafely(GameTooltip, self, "ANCHOR_LEFT", 0, 0)
        if render:ShowProfile(GameTooltip, nameAndRealm, faction, render.Preset.UnitSmartPadding(ownerExisted)) then
            return
        end
        if ownerSet then
            GameTooltip:Hide()
        end
    end

    local function OnLeave(self)
        if not config:Get("enableGuildTooltips") then
            return
        end
        GameTooltip:Hide()
    end

    local function SmartHookButtons(buttons)
        if not buttons then
            return
        end
        local numButtons = 0
        for _, button in pairs(buttons) do
            numButtons = numButtons + 1
            if not hooked[button] then
                hooked[button] = true
                button:HookScript("OnEnter", OnEnter)
                button:HookScript("OnLeave", OnLeave)
                if type(button.OnEnter) == "function" then hooksecurefunc(button, "OnEnter", OnEnter) end
                if type(button.OnLeave) == "function" then hooksecurefunc(button, "OnLeave", OnLeave) end
            end
        end
        return numButtons > 0
    end

    local function OnRefreshApplyHooks()
        if completed then
            return
        end
        SmartHookButtons(_G.CommunitiesFrame.MemberList.ListScrollFrame.buttons)
        SmartHookButtons(_G.ClubFinderGuildFinderFrame.CommunityCards.ListScrollFrame.buttons)
        SmartHookButtons(_G.ClubFinderGuildFinderFrame.PendingCommunityCards.ListScrollFrame.buttons)
        SmartHookButtons(_G.ClubFinderGuildFinderFrame.GuildCards.Cards)
        SmartHookButtons(_G.ClubFinderGuildFinderFrame.PendingGuildCards.Cards)
        SmartHookButtons(_G.ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ListScrollFrame.buttons)
        SmartHookButtons(_G.ClubFinderCommunityAndGuildFinderFrame.PendingCommunityCards.ListScrollFrame.buttons)
        SmartHookButtons(_G.ClubFinderCommunityAndGuildFinderFrame.GuildCards.Cards)
        SmartHookButtons(_G.ClubFinderCommunityAndGuildFinderFrame.PendingGuildCards.Cards)
        return true
    end

    local function OnScroll()
        if not config:Get("enableGuildTooltips") then
            return
        end
        GameTooltip:Hide()
        util:ExecuteWidgetHandler(GetMouseFocus(), "OnEnter")
    end

    function tooltip:CanLoad()
        return _G.CommunitiesFrame and _G.ClubFinderGuildFinderFrame and _G.ClubFinderCommunityAndGuildFinderFrame
    end

    function tooltip:OnLoad()
        self:Enable()
        hooksecurefunc(_G.CommunitiesFrame.MemberList, "RefreshLayout", OnRefreshApplyHooks)
        hooksecurefunc(_G.CommunitiesFrame.MemberList, "Update", OnScroll)
        hooksecurefunc(_G.ClubFinderGuildFinderFrame.CommunityCards, "RefreshLayout", OnRefreshApplyHooks)
        hooksecurefunc(_G.ClubFinderGuildFinderFrame.CommunityCards.ListScrollFrame, "update", OnScroll)
        hooksecurefunc(_G.ClubFinderGuildFinderFrame.PendingCommunityCards, "RefreshLayout", OnRefreshApplyHooks)
        hooksecurefunc(_G.ClubFinderGuildFinderFrame.PendingCommunityCards.ListScrollFrame, "update", OnScroll)
        hooksecurefunc(_G.ClubFinderGuildFinderFrame.GuildCards, "RefreshLayout", OnRefreshApplyHooks)
        hooksecurefunc(_G.ClubFinderGuildFinderFrame.PendingGuildCards, "RefreshLayout", OnRefreshApplyHooks)
        hooksecurefunc(_G.ClubFinderCommunityAndGuildFinderFrame.CommunityCards, "RefreshLayout", OnRefreshApplyHooks)
        hooksecurefunc(_G.ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ListScrollFrame, "update", OnScroll)
        hooksecurefunc(_G.ClubFinderCommunityAndGuildFinderFrame.PendingCommunityCards, "RefreshLayout", OnRefreshApplyHooks)
        hooksecurefunc(_G.ClubFinderCommunityAndGuildFinderFrame.PendingCommunityCards.ListScrollFrame, "update", OnScroll)
        hooksecurefunc(_G.ClubFinderCommunityAndGuildFinderFrame.GuildCards, "RefreshLayout", OnRefreshApplyHooks)
        hooksecurefunc(_G.ClubFinderCommunityAndGuildFinderFrame.PendingGuildCards, "RefreshLayout", OnRefreshApplyHooks)
    end

end

-- keystonetooltip.lua
-- dependencies: module, config, util, render
do

    ---@class KeystoneTooltipModule : Module
    local tooltip = ns:NewModule("KeystoneTooltip") ---@type KeystoneTooltipModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local render = ns:GetModule("Render") ---@type RenderModule

    -- TODO: the item pattern might not detect all the stuff, need to revise the pattern for it as it might have changed in 8.3.0. also any new API maybe to get info from a keystone link?
    local KEYSTONE_PATTERNS = {
        "keystone:(%d+):(.-):(.-):(.-):(.-):(.-)",
        "item:(158923):.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:(.-):(.-):(.-):(.-):(.-):(.-)"
    }

    ---@type table<table, KeystoneInfo>
    local currentKeystone = {}

    local function GetKeystoneInfo(link)
        for i = 1, #KEYSTONE_PATTERNS do
            local pattern = KEYSTONE_PATTERNS[i]
            local item, instance, level, affix1, affix2, affix3, affix4 = link:match(pattern)
            if item and instance and level then
                item, instance, level, affix1, affix2, affix3, affix4 = tonumber(item), tonumber(instance), tonumber(level), tonumber(affix1), tonumber(affix2), tonumber(affix3), tonumber(affix4)
                if item and instance and level then
                    return item, instance, level, affix1, affix2, affix3, affix4
                end
            end
        end
    end

    ---@param keystone KeystoneInfo
    local function UpdateKeystoneInfo(keystone, link)
        keystone.link = link
        keystone.item, keystone.instance, keystone.level, keystone.affix1, keystone.affix2, keystone.affix3, keystone.affix4 = GetKeystoneInfo(link)
        return keystone.link and keystone.level
    end

    local function OnTooltipSetItem(self)
        if not config:Get("enableKeystoneTooltips") then
            return
        end
        local _, link = self:GetItem()
        if not link or type(link) ~= "string" then
            return
        end
        local keystone = currentKeystone[self]
        if not keystone then
            keystone = {}
            currentKeystone[self] = keystone
        end
        if not UpdateKeystoneInfo(keystone, link) then
            return
        end
        render:ShowKeystone(self, keystone)
    end

    local function OnTooltipCleared(self)
        render:ClearTooltip(self)
    end

    local function OnHide(self)
        render:HideTooltip(self)
    end

    function tooltip:OnLoad()
        self:Enable()
        GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
        GameTooltip:HookScript("OnTooltipCleared", OnTooltipCleared)
        GameTooltip:HookScript("OnHide", OnHide)
        ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
        ItemRefTooltip:HookScript("OnTooltipCleared", OnTooltipCleared)
        ItemRefTooltip:HookScript("OnHide", OnHide)
    end

end

-- guildweekly.lua
-- dependencies: module, callback, config, util, render
do

    ---@class GuildWeeklyModule : Module
    local guildweekly = ns:NewModule("GuildWeekly") ---@type GuildWeeklyModule
    local callback = ns:GetModule("Callback") ---@type CallbackModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local util = ns:GetModule("Util") ---@type UtilModule
    local render = ns:GetModule("Render") ---@type RenderModule

    local CLASS_FILENAME_TO_ID = {
        WARRIOR = 1,
        PALADIN = 2,
        HUNTER = 3,
        ROGUE = 4,
        PRIEST = 5,
        DEATHKNIGHT = 6,
        SHAMAN = 7,
        MAGE = 8,
        WARLOCK = 9,
        MONK = 10,
        DRUID = 11,
        DEMONHUNTER = 12
    }

    local function ConvertRunData(runInfo)
        local dungeon = util:GetDungeonByKeystoneID(runInfo.mapChallengeModeID)
        local runData = {
            zone_id = dungeon and dungeon.id or 0,
            level = runInfo.keystoneLevel or 0,
            upgrades = 0,
            party = {},
        }
        for i = 1, #runInfo.members do
            local member = runInfo.members[i]
            runData.party[i] = {
                name = member.name,
                class_id = CLASS_FILENAME_TO_ID[member.classFileName] or 0
            }
        end
        return runData
    end

    local function GetGuildScoreboard()
        local scoreboard = C_ChallengeMode.GetGuildLeaders()
        local data = {}
        for i = 1, #scoreboard do
            data[#data + 1] = ConvertRunData(scoreboard[i])
        end
        return { weekly_best = data }
    end

    local function GetGuildFullName(unit)
        local guildName, _, _, guildRealm = GetGuildInfo(unit)
        if not guildName then
            return
        end
        if not guildRealm then
            _, guildRealm = util:GetNameRealm(unit)
        end
        return guildName .. "-" .. guildRealm
    end

    ---@class GuildWeeklyFrameMixin
    ---@field public offset number @The scroll offset.
    ---@field public Refresh function @Refreshes the frame with new data.
    ---@field public SetUp function @Prepares the frame by loading it with data from our guild.
    ---@field public Reset function @Resets the frame back to empty.
    ---@field public SwitchBestRun function @Toggles between this week and overall for the season.
    ---@field public OnMouseWheel function @When scrolled list goes up or down.

    ---@class GuildWeeklyRunMixin
    ---@field public SetUp function @Sets up the run using the provided info.

    ---@class GuildWeeklyBestNoRun
    ---@field public Text FontString

    ---@class GuildWeeklyRun : GuildWeeklyRunMixin
    ---@field public CharacterName FontString
    ---@field public Level FontString

    ---@class GuildWeeklyFrame : GuildWeeklyFrameMixin
    ---@field public maxVisible number
    ---@field public Title FontString
    ---@field public SubTitle FontString
    ---@field public GuildBestNoRun GuildWeeklyBestNoRun
    ---@field public SwitchGuildBest CheckButton
    ---@field public GuildBests GuildWeeklyRun[]

    ---@type GuildWeeklyFrame
    local frame

    ---@type GuildWeeklyRunMixin
    local GuildWeeklyRunMixin = {}

    ---@param runInfo GuildMythicKeystoneRun
    ---@return boolean @true if successfull, otherwise false if we can't display this run
    function GuildWeeklyRunMixin:SetUp(runInfo)
        self.runInfo = runInfo
        if not runInfo then
            return
        end
        runInfo.dungeon = runInfo.dungeon or util:GetDungeonByID(runInfo.zone_id)
        if not runInfo.dungeon then
            return
        end
        runInfo.dungeonName = C_ChallengeMode.GetMapUIInfo(runInfo.dungeon.keystone_instance) or runInfo.dungeon.name
        self.CharacterName:SetText(runInfo.dungeonName)
        self.Level:SetText(util:GetNumChests(runInfo.upgrades) .. runInfo.level)
        if runInfo.clear_time and runInfo.upgrades == 0 then
            self.Level:SetTextColor(0.62, 0.62, 0.62)
        else
            self.Level:SetTextColor(1, 1, 1)
        end
        self:Show()
    end

    local function RunFrame_OnEnter(self)
        local runInfo = self.runInfo ---@type GuildMythicKeystoneRun
        if not runInfo then
            return
        end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(runInfo.dungeonName, 1, 1, 1)
        local chestsText = ""
        if runInfo.upgrades > 0 then
            chestsText = " (" .. util:GetNumChests(runInfo.upgrades) .. ")"
        end
        GameTooltip:AddLine(MYTHIC_PLUS_POWER_LEVEL:format(runInfo.level) .. chestsText, 1, 1, 1)
        if runInfo.clear_time then
            GameTooltip:AddLine(runInfo.clear_time, 1, 1, 1)
        end
        if runInfo.party then
            GameTooltip:AddLine(" ")
            for _, member in ipairs(runInfo.party) do
                local classInfo = C_CreatureInfo.GetClassInfo(member.class_id)
                local color = (classInfo and RAID_CLASS_COLORS[classInfo.classFile]) or NORMAL_FONT_COLOR
                local texture
                if member.role == "tank" or member.role == "TANK" then
                    texture = CreateAtlasMarkup("roleicon-tiny-tank")
                elseif member.role == "dps" or member.role == "DAMAGER" then
                    texture = CreateAtlasMarkup("roleicon-tiny-dps")
                elseif member.role == "healer" or member.role == "HEALER" then
                    texture = CreateAtlasMarkup("roleicon-tiny-healer")
                end
                if texture then
                    GameTooltip:AddLine(MYTHIC_PLUS_LEADER_BOARD_NAME_ICON:format(texture, member.name), color.r, color.g, color.b)
                else
                    GameTooltip:AddLine(member.name, color.r, color.g, color.b)
                end
            end
        end
        GameTooltip:Show()
    end

    local function CreateRunFrame()
        ---@type GuildWeeklyRun
        local frame = CreateFrame("Frame")
        -- inherit from the mixin
        for k, v in pairs(GuildWeeklyRunMixin) do
            frame[k] = v
        end
        -- character name
        do
            frame.CharacterName = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny2")
            frame.CharacterName:SetJustifyH("LEFT")
            frame.CharacterName:SetSize(70, 13)
            frame.CharacterName:SetPoint("LEFT")
            frame.CharacterName:SetTextColor(1, 1, 1)
        end
        -- keystone level
        do
            frame.Level = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny2")
            frame.Level:SetJustifyH("RIGHT")
            frame.Level:SetSize(25, 13)
            frame.Level:SetPoint("RIGHT")
            frame.Level:SetTextColor(1, 1, 1)
        end
        -- the look and feel, anchoring and final touches
        do
            frame:SetSize(95, 13)
            frame:SetScript("OnEnter", RunFrame_OnEnter)
            frame:SetScript("OnLeave", GameTooltip_Hide)
        end
        -- finalize and return the frame
        return frame
    end

    ---@type GuildWeeklyFrameMixin
    local GuildWeeklyFrameMixin = {}

    function GuildWeeklyFrameMixin:Refresh()
        local guildName = GetGuildFullName("player")
        if not guildName then
            self:Hide()
            self:Reset()
            return
        end
        self:Show()
        self:SetUp(guildName)
    end

    function GuildWeeklyFrameMixin:SetUp(guildName)
        self:Reset()

        local guildsData = ns:GetClientGuildData()
        local guildData = guildsData and guildsData[guildName] ---@type GuildCollection

        local keyBest = "season_best"
        local title = L.GUILD_BEST_SEASON
        local blizzScoreboard

        if not guildData or config:Get("displayWeeklyGuildBest") then
            if not guildData then
                blizzScoreboard = true
                guildData = GetGuildScoreboard()
            end
            keyBest = "weekly_best"
            title = L.GUILD_BEST_WEEKLY
        end

        self.SubTitle:SetText(title)
        self.SwitchGuildBest:SetShown(guildData and not blizzScoreboard)

        local switchShown = self.SwitchGuildBest:IsShown()
        local switchHeight = self.SwitchGuildBest:GetHeight()
        local switchRealHeight = switchShown and switchHeight or 0
        local currentRuns = guildData and guildData[keyBest] ---@type GuildMythicKeystoneRun[]

        if not currentRuns or not currentRuns[1] then
            self.GuildBestNoRun:Show()
            self:SetHeight(35 + 15 + switchRealHeight)
            return
        end

        local numRuns = #currentRuns

        if numRuns <= self.maxVisible then
            self.offset = 0
        end

        local numVisibleRuns = min(numRuns, self.maxVisible)

        for i = 1, numVisibleRuns do
            self.GuildBests[i]:SetUp(currentRuns[i + self.offset])
        end
    
        if self:IsMouseOver() then
            local focus = GetMouseFocus()
            if focus and focus ~= GameTooltip:GetOwner() then
                util:ExecuteWidgetHandler(focus, "OnEnter")
            end
        end
    
        self:SetHeight(35 + (numVisibleRuns > 0 and numVisibleRuns * self.GuildBests[1]:GetHeight() or 0) + switchRealHeight)
    
        return numRuns, numVisibleRuns
    end

    function GuildWeeklyFrameMixin:Reset()
        self.offset = 0
        self.GuildBestNoRun:Hide()
        self.GuildBestNoRun.Text:SetText(L.NO_GUILD_RECORD)
        for _, frame in ipairs(self.GuildBests) do
            frame:Hide()
            frame:SetUp()
        end
    end

    function GuildWeeklyFrameMixin:SwitchBestRun()
        local displayWeeklyGuildBest = not config:Get("displayWeeklyGuildBest")
        config:Set("displayWeeklyGuildBest", displayWeeklyGuildBest)
        self:Refresh()
    end

    local function GuildWeeklyFrame_OnMouseWheel(self, delta)
        self.offset = max(0, min(self.maxVisible, delta > 0 and -1 or 1))
        self:Refresh()
    end

    local function GuildWeeklyFrameSwitch_OnShow(self)
        self:SetChecked(config:Get("displayWeeklyGuildBest"))
    end

    local function GuildWeeklyFrameSwitch_OnClick(self)
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        self:GetParent():SwitchBestRun()
    end

    local function CreateGuildWeeklyFrame()
        ---@type GuildWeeklyFrame
        local frame = CreateFrame("Frame", nil, ChallengesFrame, BackdropTemplateMixin and "BackdropTemplate")
        frame.maxVisible = 5
        -- inherit from the mixin
        for k, v in pairs(GuildWeeklyFrameMixin) do
            frame[k] = v
        end
        -- title
        do
            frame.Title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny2")
            frame.Title:SetJustifyH("CENTER")
            frame.Title:SetPoint("TOPLEFT", 10, -8)
            frame.Title:SetTextColor(1, 0.85, 0)
            frame.Title:SetShadowColor(0, 0, 0)
            frame.Title:SetShadowOffset(1, -1)
            frame.Title:SetText(L.GUILD_BEST_TITLE)
        end
        -- sub title
        do
            frame.SubTitle = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny2")
            frame.SubTitle:SetJustifyH("CENTER")
            frame.SubTitle:SetPoint("TOPLEFT", 10, -18)
            frame.SubTitle:SetTextColor(1, 0.85, 0, 0.8)
            frame.SubTitle:SetShadowColor(0, 0, 0)
            frame.SubTitle:SetShadowOffset(1, -1)
        end
        -- no runs available overlay
        do
            frame.GuildBestNoRun = CreateFrame("Frame", nil, frame)
            frame.GuildBestNoRun:SetSize(95, 13)
            frame.GuildBestNoRun:SetPoint("TOPLEFT", frame.Title, "BOTTOMLEFT", 0, -14)
            frame.GuildBestNoRun.Text = frame.GuildBestNoRun:CreateFontString(nil, "ARTWORK", "GameFontNormalTiny2")
            frame.GuildBestNoRun.Text:SetJustifyH("LEFT")
            frame.GuildBestNoRun.Text:SetSize(150, 0)
            frame.GuildBestNoRun.Text:SetPoint("LEFT")
            frame.GuildBestNoRun.Text:SetTextColor(1, 1, 1)
        end
        -- toggle between weekly and season best
        do
            frame.SwitchGuildBest = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
            frame.SwitchGuildBest:SetSize(15, 15)
            frame.SwitchGuildBest:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 8, 5)
            frame.SwitchGuildBest:SetScript("OnShow", GuildWeeklyFrameSwitch_OnShow)
            frame.SwitchGuildBest:SetScript("OnClick", GuildWeeklyFrameSwitch_OnClick)
            frame.SwitchGuildBest.text:SetFontObject("GameFontNormalTiny2")
            frame.SwitchGuildBest.text:SetJustifyH("LEFT")
            frame.SwitchGuildBest.text:SetPoint("LEFT", 15, 0)
            frame.SwitchGuildBest.text:SetText(L.CHECKBOX_DISPLAY_WEEKLY)
        end
        -- create the guild best run frames
        do
            ---@type GuildWeeklyRun[]
            frame.GuildBests = {}
            for i = 1, 20 do
                local runFrame = CreateRunFrame()
                runFrame:SetParent(frame)
                if i == 1 then
                    runFrame:SetPoint("TOPLEFT", frame.Title, "BOTTOMLEFT", 0, -13)
                else
                    local prevRun = frame.GuildBests[i - 1]
                    runFrame:SetPoint("TOP", prevRun, "BOTTOM")
                end
                frame.GuildBests[i] = runFrame
            end
        end
        -- the look and feel, anchoring and final touches
        do
            -- look and feel
            frame:SetScale(1.2)
            frame:SetFrameStrata("HIGH")
            frame:SetSize(115, 115)
            if frame.SetBackdrop then
                frame:SetBackdrop(BACKDROP_TOOLTIP_16_16_5555 or GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT)
                frame:SetBackdropBorderColor(1, 1, 1, 1)
                frame:SetBackdropColor(0, 0, 0, 0.6)
            end
            -- update anchor
            frame:ClearAllPoints()
            if IsAddOnLoaded("AngryKeystones") then
                frame:SetPoint("TOPRIGHT", ChallengesFrame, "TOPRIGHT", -6, -22)
            else
                frame:SetPoint("BOTTOMLEFT", ChallengesFrame.DungeonIcons[1], "TOPLEFT", 2, 12)
            end
            -- mousewheel scrolling
            frame:EnableMouseWheel(true)
            frame:SetScript("OnMouseWheel", GuildWeeklyFrame_OnMouseWheel)
        end
        -- finalize and return the frame
        frame:Reset()
        return frame
    end

    local function UpdateShown()
        if config:Get("showClientGuildBest") then
            frame:Refresh()
        else
            frame:Hide()
        end
    end

    function guildweekly:CanLoad()
        return not frame and config:IsEnabled() and _G.PVEFrame and _G.ChallengesFrame
    end

    function guildweekly:OnLoad()
        self:Enable()
        frame = CreateGuildWeeklyFrame()
        UpdateShown()
        callback:RegisterEvent(UpdateShown, "RAIDERIO_SETTINGS_SAVED")
        PVEFrame:HookScript("OnShow", UpdateShown)
        ChallengesFrame:HookScript("OnShow", UpdateShown)
        callback:RegisterEvent(UpdateShown, "CHALLENGE_MODE_LEADERS_UPDATE")
    end

end

-- search.lua
-- dependencies: module, config, provider, render, profile
do

    ---@class SearchModule : Module
    local search = ns:NewModule("Search") ---@type SearchModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local provider = ns:GetModule("Provider") ---@type ProviderModule
    local render = ns:GetModule("Render") ---@type RenderModule
    local profile = ns:GetModule("Profile") ---@type ProfileModule

    local function SortByName(a, b)
        return a.name < b.name
    end

    local PROVIDERS = provider:GetProviders()
    local REGIONS

    local function GetCachedRegions()
        if REGIONS then
            return REGIONS
        end
        REGIONS = {}
        local unique = {}
        for _, dataProvider in ipairs(PROVIDERS) do
            local regionName = dataProvider.region
            if not unique[regionName] then
                unique[regionName] = true
                REGIONS[#REGIONS + 1] = {
                    name = regionName,
                    priority = 7
                }
            end
        end
        table.sort(REGIONS, SortByName)
        return REGIONS
    end

    local function GetRegions(text, maxResults, cursorPosition)
        text = text:lower()
        local regions = GetCachedRegions()
        local temp = {}
        local unique = {}
        local count = 0
        for _, region in ipairs(regions) do
            if count >= maxResults then
                break
            end
            local regionName = region.name
            if not unique[regionName] and regionName:find(text, nil, true) == 1 then
                unique[regionName] = true
                count = count + 1
                temp[count] = {
                    name = regionName,
                    priority = 7
                }
            end
        end
        table.wipe(unique)
        return temp
    end

    local searchFrame
    local searchRegionBox
    local searchRealmBox
    local searchNameBox
    local searchTooltip

    local function GetRegionName()
        return (searchRegionBox:GetText() and searchRegionBox:GetText() ~= "") and searchRegionBox:GetText() or ns.PLAYER_REGION
    end

    local function GetRegionProviders()
        local regionName = GetRegionName()
        local temp ---@type DataProvider[]
        for i = 1, #PROVIDERS do
            local dataProvider = PROVIDERS[i]
            if dataProvider.region == regionName then
                if not temp then temp = {} end
                temp[#temp + 1] = dataProvider
            end
        end
        return temp
    end

    local function GetRealms(text, maxResults, cursorPosition)
        local providers = GetRegionProviders()
        if not providers then
            return
        end
        text = text:lower()
        local temp = {}
        local count = 0
        local unique = {}
        local data
        local kl
        for x = 1, #providers do
            if count >= maxResults then
                break
            end
            local dataProvider = providers[x]
            for i = 1, 2 do
                if count >= maxResults then
                    break
                end
                data = dataProvider["db" .. i]
                if data then
                    for k, _ in pairs(data) do
                        if count >= maxResults then
                            break
                        end
                        kl = k:lower()
                        if not unique[kl] and kl:find(text, nil, true) == 1 then
                            unique[kl] = true
                            count = count + 1
                            temp[count] = {
                                name = k,
                                priority = 7
                            }
                        end
                    end
                end
            end
        end
        table.wipe(unique)
        table.sort(temp, SortByName)
        return temp
    end

    local function GetNames(text, maxResults, cursorPosition)
        local providers = GetRegionProviders()
        if not providers then
            return
        end
        text = text:lower()
        local realm = searchRealmBox:GetText()
        if not realm or strlenutf8(realm) < 1 then return end
        local temp = {}
        local rcount = 0
        local data
        local count
        local name
        local namel
        local unique = {}
        for x = 1, #providers do
            if rcount >= maxResults then
                break
            end
            local dataProvider = providers[x]
            for i = 1, 2 do
                if rcount >= maxResults then
                    break
                end
                data = dataProvider["db" .. i]
                if data then
                    data = data[realm]
                    if data then
                        count = #data
                        for j = 2, count do
                            if rcount >= maxResults then
                                break
                            end
                            name = data[j]
                            namel = name:lower()
                            if not unique[namel] and namel:find(text, nil, true) == 1 then
                                rcount = rcount + 1
                                unique[namel] = true
                                temp[rcount] = {
                                    name = name,
                                    priority = 7
                                }
                            end
                        end
                    end
                end
            end
        end
        table.sort(temp, SortByName)
        return temp
    end

    local function CreateEditBox()
        local f = CreateFrame("EditBox", nil, UIParent, "AutoCompleteEditBoxTemplate")
        -- autocomplete
        f.autoComplete = AutoCompleteBox
        f.autoCompleteParams = { include = AUTOCOMPLETE_FLAG_ALL, exclude = AUTOCOMPLETE_FLAG_NONE }
        -- onload
        f:SetFontObject("ChatFontNormal")
        f:SetSize(256, 32)
        f:SetAutoFocus(false)
        f:SetAltArrowKeyMode(true)
        f:SetHistoryLines(32)
        f:SetMaxLetters(32)
        f:SetMaxBytes(256)
        -- background
        f.texLeft = f:CreateTexture(nil, "BACKGROUND")
        f.texLeft:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left2")
        f.texLeft:SetSize(32, 32)
        f.texLeft:SetPoint("LEFT", -16, 0)
        f.texRight = f:CreateTexture(nil, "BACKGROUND")
        f.texRight:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right2")
        f.texRight:SetSize(32, 32)
        f.texRight:SetPoint("RIGHT", 16, 0)
        f.texMid = f:CreateTexture(nil, "BACKGROUND")
        f.texMid:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Mid2", true)
        f.texMid:SetSize(0, 32)
        f.texMid:SetPoint("TOPLEFT", f.texLeft, "TOPRIGHT", 0, 0)
        f.texMid:SetPoint("TOPRIGHT", f.texRight, "TOPLEFT", 0, 0)
        -- border
        f.texFocusLeft = f:CreateTexture(nil, "BORDER")
        f.texFocusLeft:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorderFocus-Left")
        f.texFocusLeft:SetSize(32, 32)
        f.texFocusLeft:SetPoint("LEFT", -16, 0)
        f.texFocusRight = f:CreateTexture(nil, "BORDER")
        f.texFocusRight:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorderFocus-Right")
        f.texFocusRight:SetSize(32, 32)
        f.texFocusRight:SetPoint("RIGHT", 16, 0)
        f.texFocusMid = f:CreateTexture(nil, "BORDER")
        f.texFocusMid:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorderFocus-Mid", true)
        f.texFocusMid:SetSize(0, 32)
        f.texFocusMid:SetPoint("TOPLEFT", f.texFocusLeft, "TOPRIGHT", 0, 0)
        f.texFocusMid:SetPoint("TOPRIGHT", f.texFocusRight, "TOPLEFT", 0, 0)
        return f
    end

    local function CreateTooltip()
        return CreateFrame("GameTooltip", addonName .. "_SearchTooltip", UIParent, "GameTooltipTemplate")
    end

    local function CreateSearchFrame()
        GetCachedRegions() -- cache the regions from the loaded providers

        local regionBox = CreateEditBox()
        local realmBox = CreateEditBox()
        local nameBox = CreateEditBox()
        local t = CreateTooltip()

        regionBox.autoCompleteFunction = GetRegions
        regionBox:SetText(ns.PLAYER_REGION)
        realmBox.autoCompleteFunction = GetRealms
        nameBox.autoCompleteFunction = GetNames

        local Frame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
        do
            Frame:Hide()
            Frame:EnableMouse(true)
            Frame:SetFrameStrata("DIALOG")
            Frame:SetToplevel(true)
            Frame:SetSize(310, config:Get("debugMode") and 115 or 100)
            Frame:SetPoint("CENTER")
            if Frame.SetBackdrop then
                Frame:SetBackdrop(BACKDROP_TOOLTIP_16_16_5555 or GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT)
                Frame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR:GetRGB())
                Frame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR:GetRGB())
                Frame:SetBackdropColor(0, 0, 0, 1) -- TODO: ?
            end
            Frame.header = Frame:CreateFontString(nil, nil, "ChatFontNormal")
            Frame.header:SetPoint("TOPLEFT", 16, -12)
            Frame.header:SetText("Enter realm and character name:")
            Frame:SetMovable(true)
            Frame:RegisterForDrag("LeftButton")
            Frame:SetClampedToScreen(true)
            Frame:SetScript("OnDragStart", function() Frame:StartMoving() end)
            Frame:SetScript("OnDragStop", function() Frame:StopMovingOrSizing() end)
            Frame:SetScript("OnShow", function() search:ShowProfile(regionBox:GetText(), nil, realmBox:GetText(), nameBox:GetText()) end)
            Frame:SetScript("OnHide", function() search:ShowProfile() end)
        end

        local activeBoxes = {}
        if config:Get("debugMode") then
            regionBox:SetParent(Frame)
            table.insert(activeBoxes, regionBox)
        end
        realmBox:SetParent(Frame)
        nameBox:SetParent(Frame)
        table.insert(activeBoxes, realmBox)
        table.insert(activeBoxes, nameBox)

        for i = 1, #activeBoxes do
            local box = activeBoxes[i]
            local prevBox = activeBoxes[i - 1]
            if prevBox then
                box:SetPoint("TOPLEFT", prevBox, "BOTTOMLEFT", 0, 11)
            else
                box:SetPoint("TOPLEFT", Frame.header, "BOTTOMLEFT", 10, -5)
            end
        end

        local function OnTabPressed(self)
            if self.autoComplete:IsShown() then
                return
            end
            self:ClearFocus()
            for i = 1, #activeBoxes do
                local box = activeBoxes[i]
                if box == self then
                    local nextBox = activeBoxes[i + 1]
                    if not nextBox then
                        nextBox = activeBoxes[1]
                    end
                    nextBox:SetFocus()
                    nextBox:HighlightText()
                    break
                end
            end
        end

        local function OnEditFocusLost(self)
            self:HighlightText(0, 0)
        end

        local function OnEnterPressed(self)
            for i = 1, #activeBoxes do
                local box = activeBoxes[i]
                if box == self then
                    local nextBox = activeBoxes[i + 1]
                    if nextBox then
                        self:ClearFocus()
                        nextBox:SetFocus()
                        nextBox:HighlightText()
                    else
                        self:ClearFocus()
                        self:HighlightText(0, 0)
                    end
                    break
                end
            end
            search:ShowProfile(regionBox:GetText(), nil, realmBox:GetText(), nameBox:GetText())
        end

        local function OnEscapePressed(self)
            self:ClearFocus()
        end

        local function OnTextChanged(self, userInput)
            if not userInput then return end
            local text = self:GetText()
            if text:len() > 0 then
                AutoCompleteEditBox_SetAutoCompleteSource(self, self.autoCompleteFunction)
                AutoComplete_Update(self, text, #text)
            end
        end

        for i = 1, #activeBoxes do
            local box = activeBoxes[i]
            box:HookScript("OnTabPressed", OnTabPressed)
            box:HookScript("OnEditFocusLost", OnEditFocusLost)
            box:HookScript("OnEnterPressed", OnEnterPressed)
            box:HookScript("OnEscapePressed", OnEscapePressed)
            box:HookScript("OnTextChanged", OnTextChanged)
        end

        return Frame, regionBox, realmBox, nameBox, t
    end

    function search:CanLoad()
        return not searchFrame and profile:IsLoaded()
    end

    function search:OnLoad()
        self:Enable()
        searchFrame, searchRegionBox, searchRealmBox, searchNameBox, searchTooltip = CreateSearchFrame()
    end

    function search:ShowProfile(region, faction, realm, name)
        if not self:IsEnabled() then
            return
        end
        if not region or not realm or not name or strlenutf8(realm) < 1 or strlenutf8(name) < 1 then
            searchTooltip:Hide()
            profile:HideProfile()
            return
        end
        searchTooltip:SetParent(searchFrame)
        searchTooltip:SetOwner(searchFrame, "ANCHOR_BOTTOM", 0, -8)
        local startIndex, stopIndex = 1, 3
        if faction then
            startIndex, stopIndex = faction, faction
        end
        local playerProfile
        local shown
        for i = startIndex, stopIndex do
            playerProfile = provider:GetProfile(name, realm, i, region)
            if playerProfile and playerProfile.success then
                faction = i
                shown = render:ShowProfile(searchTooltip, name, realm, faction, bor(render.Preset.UnitNoPadding(), render.Flags.MOD_STICKY), region)
                if shown then
                    break
                end
            end
            playerProfile = nil
        end
        if not shown then
            render:ShowProfile(searchTooltip)
            searchTooltip:SetParent(searchFrame)
            searchTooltip:SetOwner(searchFrame, "ANCHOR_BOTTOM", 0, -8)
            searchTooltip:AddLine(ERR_FRIEND_NOT_FOUND, 1, 1, 1)
            searchTooltip:Show()
        end
        if shown then
            profile:ShowProfile(searchFrame, name, realm, faction, render.Preset.Profile(render.Flags.IGNORE_MOD), region)
        else
            profile:HideProfile()
        end
    end

    function search:Search(query)
        if not self:IsEnabled() then
            return
        end
        local pattern = config:Get("debugMode") and "^(%S+)%s*(%S*)%s*(%S*)$" or "^(%S+)%s*(%S*)$"
        local arg1, arg2, arg3 = query:match(pattern)
        arg1, arg2, arg3 = (arg1 or ""):trim(), (arg2 or ""):trim(), (arg3 or ""):trim()
        arg2 = arg2 ~= "" and arg2 or GetNormalizedRealmName()
        arg3 = arg3 ~= "" and arg3 or ns.PLAYER_REGION
        local arg3q = GetRegions(arg3, 1)
        if arg3q and arg3q[1] and arg3q[1].name then
            arg3 = arg3q[1].name
        end
        searchRegionBox:SetText(arg3)
        local arg2q = GetRealms(arg2, 1)
        if arg2q and arg2q[1] and arg2q[1].name then
            arg2 = arg2q[1].name
        end
        searchRealmBox:SetText(arg2)
        local arg1q = GetNames(arg1, 1)
        if arg1q and arg1q[1] and arg1q[1].name then
            arg1 = arg1q[1].name
        end
        searchNameBox:SetText(arg1)
        return search:ShowProfile(arg3, nil, arg2, arg1)
    end

    function search:Toggle()
        if not self:IsEnabled() then
            return
        end
        if searchFrame:IsShown() then
            search:Hide()
        else
            search:Show()
        end
    end

    function search:Show()
        if not self:IsEnabled() then
            return
        end
        searchFrame:Show()
    end

    function search:Hide()
        if not self:IsEnabled() then
            return
        end
        searchFrame:Hide()
    end

end

-- settings.lua
-- dependencies: module, callback, json, config, profile, search
do

    ---@class SettingsModule : Module
    local settings = ns:NewModule("Settings") ---@type SettingsModule
    local callback = ns:GetModule("Callback") ---@type CallbackModule
    local json = ns:GetModule("JSON") ---@type JSONModule
    local config = ns:GetModule("Config") ---@type ConfigModule
    local profile = ns:GetModule("Profile") ---@type ProfileModule
    local search = ns:GetModule("Search") ---@type SearchModule

    local settingsFrame
    local reloadPopup = {
        id = "RAIDERIO_RELOADUI_CONFIRM",
        text = L.CHANGES_REQUIRES_UI_RELOAD,
        button1 = L.RELOAD_NOW,
        button2 = L.RELOAD_LATER,
        hasEditBox = false,
        preferredIndex = 3,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnShow = nil,
        OnHide = nil,
        OnAccept = ReloadUI,
        OnCancel = nil
    }
    local debugPopup = {
        id = "RAIDERIO_DEBUG_CONFIRM",
        text = function() return config:Get("debugMode") and L.DISABLE_DEBUG_MODE_RELOAD or L.ENABLE_DEBUG_MODE_RELOAD end,
        button1 = L.CONFIRM,
        button2 = L.CANCEL,
        hasEditBox = false,
        preferredIndex = 3,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnShow = nil,
        OnHide = nil,
        OnAccept = function ()
            config:Set("debugMode", not config:Get("debugMode"))
            ReloadUI()
        end,
        OnCancel = nil
    }

    local function CreateOptions()
        local configParentFrame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
        configParentFrame:SetSize(400, 600)
        configParentFrame:SetPoint("CENTER")

        local configHeaderFrame = CreateFrame("Frame", nil, configParentFrame)
        configHeaderFrame:SetPoint("TOPLEFT", 00, -30)
        configHeaderFrame:SetPoint("TOPRIGHT", 00, 30)
        configHeaderFrame:SetHeight(40)

        local configScrollFrame = CreateFrame("ScrollFrame", nil, configParentFrame)
        configScrollFrame:SetPoint("TOPLEFT", configHeaderFrame, "BOTTOMLEFT")
        configScrollFrame:SetPoint("TOPRIGHT", configHeaderFrame, "BOTTOMRIGHT")
        configScrollFrame:SetHeight(475)
        configScrollFrame:EnableMouseWheel(true)
        configScrollFrame:SetClampedToScreen(true)
        configScrollFrame:SetClipsChildren(true)

        local configButtonFrame = CreateFrame("Frame", nil, configParentFrame)
        configButtonFrame:SetPoint("TOPLEFT", configScrollFrame, "BOTTOMLEFT", 0, -10)
        configButtonFrame:SetPoint("TOPRIGHT", configScrollFrame, "BOTTOMRIGHT")
        configButtonFrame:SetHeight(50)

        local configSliderFrame = CreateFrame("Slider", nil, configScrollFrame, "UIPanelScrollBarTemplate")
        configSliderFrame:SetPoint("TOPLEFT", configScrollFrame, "TOPRIGHT", -35, -18)
        configSliderFrame:SetPoint("BOTTOMLEFT", configScrollFrame, "BOTTOMRIGHT", -35, 18)
        configSliderFrame:SetMinMaxValues(1, 1)
        configSliderFrame:SetValueStep(1)
        configSliderFrame.scrollStep = 1
        configSliderFrame:SetValue(0)
        configSliderFrame:SetWidth(16)
        configSliderFrame:SetScript("OnValueChanged", function (self, value)
            self:GetParent():SetVerticalScroll(value)
        end)

        configScrollFrame:HookScript("OnMouseWheel", function(self, delta)
            local currentValue = configSliderFrame:GetValue()
            local changes = -delta * 20
            configSliderFrame:SetValue(currentValue + changes)
        end)

        local configFrame = CreateFrame("Frame", nil, configScrollFrame)
        configFrame:SetSize(400, 600) -- resized to proper value below
        configParentFrame.scrollframe = configScrollFrame
        configParentFrame.scrollbar = configSliderFrame
        configScrollFrame.content = configFrame
        configScrollFrame:SetScrollChild(configFrame)
        configParentFrame:Hide()

        local configOptions

        local function WidgetHelp_OnEnter(self)
            if not self.tooltip then
                return
            end
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:AddLine(self.tooltip, 1, 1, 1, true)
            GameTooltip:Show()
        end

        local function WidgetButton_OnEnter(self)
            if self.SetBackdrop then
                self:SetBackdropColor(0.3, 0.3, 0.3, 1)
                self:SetBackdropBorderColor(1, 1, 1, 1)
            end
        end

        local function WidgetButton_OnLeave(self)
            if self.SetBackdrop then
                self:SetBackdropColor(0, 0, 0, 1)
                self:SetBackdropBorderColor(1, 1, 1, 0.3)
            end
        end

        local function Close_OnClick()
            configParentFrame:SetShown(not configParentFrame:IsShown())
        end

        local function Save_OnClick()
            Close_OnClick()
            local reload
            for i = 1, #configOptions.modules do
                local f = configOptions.modules[i]
                local checked1 = f.checkButton:GetChecked()
                local checked2 = f.checkButton2:GetChecked()
                local loaded1 = IsAddOnLoaded(f.addon1)
                local loaded2 = IsAddOnLoaded(f.addon2)
                if checked1 then
                    if not loaded1 then
                        reload = 1
                        EnableAddOn(f.addon1)
                    end
                elseif loaded1 then
                    reload = 1
                    DisableAddOn(f.addon1)
                end
                if checked2 then
                    if not loaded2 then
                        reload = 1
                        EnableAddOn(f.addon2)
                    end
                elseif loaded2 then
                    reload = 1
                    DisableAddOn(f.addon2)
                end
            end
            for i = 1, #configOptions.options do
                local f = configOptions.options[i]
                local checked = f.checkButton:GetChecked()
                local enabled = config:Get(f.cvar)
                config:Set(f.cvar, not not checked)
                if ((not enabled and checked) or (enabled and not checked)) then
                    if f.needReload then
                        reload = 1
                    end
                    if f.callback then
                        f.callback()
                    end
                end
            end
            for cvar in pairs(configOptions.radios) do
                local radios = configOptions.radios[cvar]
                for i = 1, #radios do
                    local f = radios[i]
                    local checked = f.checkButton:GetChecked()
                    local currentValue = config:Get(f.cvar)

                    if checked then
                        config:Set(f.cvar, f.valueRadio)

                        if currentValue ~= f.valueRadio and f.needReload then
                            reload = 1
                        end
                    end
                end
            end
            if reload then
                StaticPopup_Show(reloadPopup.id)
            end
            callback:SendEvent("RAIDERIO_SETTINGS_SAVED")
        end

        configOptions = {
            modules = {},
            options = {},
            radios = {},
            backdrop = { -- TODO: 9.0
                bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
                edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
                insets = { left = 4, right = 4, top = 4, bottom = 4 }
            }
        }

        function configOptions.Update(self)
            for i = 1, #self.modules do
                local f = self.modules[i]
                f.checkButton:SetChecked(IsAddOnLoaded(f.addon1))
                f.checkButton2:SetChecked(IsAddOnLoaded(f.addon2))
            end
            for i = 1, #self.options do
                local f = self.options[i]
                f.checkButton:SetChecked(config:Get(f.cvar) ~= false)
            end
            for cvar in pairs(self.radios) do
                local radios = configOptions.radios[cvar]
                for i = 1, #radios do
                    local f = radios[i]
                    f.checkButton:SetChecked(f.valueRadio == config:Get(f.cvar))
                end
            end
        end

        function configOptions.CreateWidget(self, widgetType, height, parentFrame)
            local widget = CreateFrame(widgetType, nil, parentFrame or configFrame, BackdropTemplateMixin and "BackdropTemplate")

            if self.lastWidget then
                widget:SetPoint("TOPLEFT", self.lastWidget, "BOTTOMLEFT", 0, -24)
                widget:SetPoint("BOTTOMRIGHT", self.lastWidget, "BOTTOMRIGHT", 0, -4)
            else
                widget:SetPoint("TOPLEFT", parentFrame or configFrame, "TOPLEFT", 16, 0)
                widget:SetPoint("BOTTOMRIGHT", parentFrame or configFrame, "TOPRIGHT", -40, -16)
            end

            widget.bg = widget:CreateTexture()
            widget.bg:SetAllPoints()
            widget.bg:SetColorTexture(0, 0, 0, 0.5)

            widget.text = widget:CreateFontString(nil, nil, "GameFontNormal")
            widget.text:SetPoint("LEFT", 8, 0)
            widget.text:SetPoint("RIGHT", -8, 0)
            widget.text:SetJustifyH("LEFT")

            widget.checkButton = CreateFrame("CheckButton", "$parentCheckButton1", widget, "UICheckButtonTemplate")
            widget.checkButton:Hide()
            widget.checkButton:SetPoint("RIGHT", -4, 0)
            widget.checkButton:SetScale(0.7)

            widget.checkButton2 = CreateFrame("CheckButton", "$parentCheckButton2", widget, "UICheckButtonTemplate")
            widget.checkButton2:Hide()
            widget.checkButton2:SetPoint("RIGHT", widget.checkButton, "LEFT", -4, 0)
            widget.checkButton2:SetScale(0.7)

            widget.help = CreateFrame("Frame", nil, widget)
            widget.help:Hide()
            widget.help:SetPoint("LEFT", widget.checkButton, "LEFT", -20, 0)
            widget.help:SetSize(16, 16)
            widget.help:SetScale(0.9)
            widget.help.icon = widget.help:CreateTexture()
            widget.help.icon:SetAllPoints()
            widget.help.icon:SetTexture("Interface\\GossipFrame\\DailyActiveQuestIcon")

            widget.help:SetScript("OnEnter", WidgetHelp_OnEnter)
            widget.help:SetScript("OnLeave", GameTooltip_Hide)

            if widgetType == "Button" then
                widget.bg:Hide()
                widget.text:SetTextColor(1, 1, 1)
                if widget.SetBackdrop then
                    widget:SetBackdrop(self.backdrop)
                    widget:SetBackdropColor(0, 0, 0, 1)
                    widget:SetBackdropBorderColor(1, 1, 1, 0.3)
                end
                widget:SetScript("OnEnter", WidgetButton_OnEnter)
                widget:SetScript("OnLeave", WidgetButton_OnLeave)
            end

            if not parentFrame then
                self.lastWidget = widget
            end

            return widget
        end

        function configOptions.CreatePadding(self)
            local frame = self:CreateWidget("Frame")
            local _, lastWidget = frame:GetPoint(1)
            frame:ClearAllPoints()
            frame:SetPoint("TOPLEFT", lastWidget, "BOTTOMLEFT", 0, -14)
            frame:SetPoint("BOTTOMRIGHT", lastWidget, "BOTTOMRIGHT", 0, -4)
            frame.bg:Hide()
            return frame
        end

        function configOptions.CreateHeadline(self, text, parentFrame)
            local frame = self:CreateWidget("Frame", nil, parentFrame)
            frame.bg:Hide()
            frame.text:SetText(text)
            return frame
        end

        function configOptions.CreateModuleToggle(self, name, addon1, addon2)
            local frame = self:CreateWidget("Frame")
            frame.text:SetText(name)
            frame.addon2 = addon1
            frame.addon1 = addon2
            frame.checkButton:Show()
            frame.checkButton2:Show()
            self.modules[#self.modules + 1] = frame
            return frame
        end

        function configOptions.CreateToggle(self, label, description, cvar, configOptions)
            local frame = self:CreateWidget("Frame")
            frame.text:SetText(label)
            frame.tooltip = description
            frame.cvar = cvar
            frame.needReload = (configOptions and configOptions.needReload) or false
            frame.callback = (configOptions and configOptions.callback) or nil
            frame.help.tooltip = description
            frame.help:Show()
            frame.checkButton:Show()

            return frame
        end

        function configOptions.CreateOptionToggle(self, label, description, cvar, configOptions)
            local frame = self:CreateToggle(label, description, cvar, configOptions)
            self.options[#self.options + 1] = frame
            return frame
        end

        function configOptions.CreateRadioToggle(self, label, description, cvar, value, configOptions)
            local frame = self:CreateToggle(label, description, cvar, configOptions)

            frame.valueRadio = value

            if self.radios[cvar] == nil then
                self.radios[cvar] = {}
            end

            self.radios[cvar][#self.radios[cvar] +1] = frame

            frame.checkButton:SetScript("OnClick", function ()
                -- Disable unchecking radio (to avoid having nothing chosen)
                if not frame.checkButton:GetChecked() then
                    frame.checkButton:SetChecked(true)
                end
                -- Uncheck every other radio for same cvar
                for i = 1, #self.radios[cvar] do
                    local f = self.radios[cvar][i]
                    if f.valueRadio ~= frame.valueRadio then
                        f.checkButton:SetChecked(false)
                    end
                end
            end)
        end

        -- customize the look and feel
        do
            local function ConfigFrame_OnShow(self)
                if not InCombatLockdown() then
                    if InterfaceOptionsFrame:IsShown() then
                        InterfaceOptionsFrame_Show()
                    end
                    HideUIPanel(GameMenuFrame)
                end
                configOptions:Update()
            end

            local function ConfigFrame_OnDragStart(self)
                self:StartMoving()
            end

            local function ConfigFrame_OnDragStop(self)
                self:StopMovingOrSizing()
            end

            local function ConfigFrame_OnEvent(self, event)
                if event == "PLAYER_REGEN_ENABLED" then
                    if self.combatHidden then
                        self.combatHidden = nil
                        self:Show()
                    end
                elseif event == "PLAYER_REGEN_DISABLED" then
                    if self:IsShown() then
                        self.combatHidden = true
                        self:Hide()
                    end
                end
            end

            configParentFrame:SetFrameStrata("DIALOG")
            configParentFrame:SetFrameLevel(255)

            configParentFrame:EnableMouse(true)
            configParentFrame:SetClampedToScreen(true)
            configParentFrame:SetDontSavePosition(true)
            configParentFrame:SetMovable(true)
            configParentFrame:RegisterForDrag("LeftButton")

            if configParentFrame.SetBackdrop then
                configParentFrame:SetBackdrop(configOptions.backdrop)
                configParentFrame:SetBackdropColor(0, 0, 0, 0.8)
                configParentFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8)
            end

            configParentFrame:SetScript("OnShow", ConfigFrame_OnShow)
            configParentFrame:SetScript("OnDragStart", ConfigFrame_OnDragStart)
            configParentFrame:SetScript("OnDragStop", ConfigFrame_OnDragStop)
            configParentFrame:SetScript("OnEvent", ConfigFrame_OnEvent)

            configParentFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
            configParentFrame:RegisterEvent("PLAYER_REGEN_DISABLED")

            -- add widgets
            local header = configOptions:CreateHeadline(L.RAIDERIO_MYTHIC_OPTIONS .. "\nVersion: " .. tostring(GetAddOnMetadata(addonName, "Version")), configHeaderFrame)
            header.text:SetFont(header.text:GetFont(), 16, "OUTLINE")

            configOptions:CreateHeadline(L.CHOOSE_HEADLINE_HEADER)
            configOptions:CreateRadioToggle(L.SHOW_BEST_SEASON, L.SHOW_BEST_SEASON_DESC, "mplusHeadlineMode", 1)
            configOptions:CreateRadioToggle(L.SHOW_CURRENT_SEASON, L.SHOW_CURRENT_SEASON_DESC, "mplusHeadlineMode", 0)
            configOptions:CreateRadioToggle(L.SHOW_BEST_RUN, L.SHOW_BEST_RUN_DESC, "mplusHeadlineMode", 2)

            configOptions:CreatePadding()
            configOptions:CreateHeadline(L.GENERAL_TOOLTIP_OPTIONS)
            configOptions:CreateOptionToggle(L.SHOW_MAINS_SCORE, L.SHOW_MAINS_SCORE_DESC, "showMainsScore")
            configOptions:CreateOptionToggle(L.SHOW_BEST_MAINS_SCORE, L.SHOW_BEST_MAINS_SCORE_DESC, "showMainBestScore")
            configOptions:CreateOptionToggle(L.SHOW_ROLE_ICONS, L.SHOW_ROLE_ICONS_DESC, "showRoleIcons")
            configOptions:CreateOptionToggle(L.ENABLE_SIMPLE_SCORE_COLORS, L.ENABLE_SIMPLE_SCORE_COLORS_DESC, "showSimpleScoreColors")
            configOptions:CreateOptionToggle(L.ENABLE_NO_SCORE_COLORS, L.ENABLE_NO_SCORE_COLORS_DESC, "disableScoreColors")
            configOptions:CreateOptionToggle(L.SHOW_KEYSTONE_INFO, L.SHOW_KEYSTONE_INFO_DESC, "enableKeystoneTooltips")
            configOptions:CreateOptionToggle(L.SHOW_AVERAGE_PLAYER_SCORE_INFO, L.SHOW_AVERAGE_PLAYER_SCORE_INFO_DESC, "showAverageScore")
            configOptions:CreateOptionToggle(L.SHOW_SCORE_IN_COMBAT, L.SHOW_SCORE_IN_COMBAT_DESC, "showScoreInCombat")
            configOptions:CreateOptionToggle(L.SHOW_SCORE_WITH_MODIFIER, L.SHOW_SCORE_WITH_MODIFIER_DESC, "showScoreModifier")
            configOptions:CreateOptionToggle(L.USE_ENGLISH_ABBREVIATION, L.USE_ENGLISH_ABBREVIATION_DESC, "useEnglishAbbreviations")

            configOptions:CreatePadding()
            configOptions:CreateHeadline(L.CONFIG_WHERE_TO_SHOW_TOOLTIPS)
            configOptions:CreateOptionToggle(L.SHOW_ON_PLAYER_UNITS, L.SHOW_ON_PLAYER_UNITS_DESC, "enableUnitTooltips")
            configOptions:CreateOptionToggle(L.SHOW_IN_LFD, L.SHOW_IN_LFD_DESC, "enableLFGTooltips")
            configOptions:CreateOptionToggle(L.SHOW_IN_FRIENDS, L.SHOW_IN_FRIENDS_DESC, "enableFriendsTooltips")
            configOptions:CreateOptionToggle(L.SHOW_ON_GUILD_ROSTER, L.SHOW_ON_GUILD_ROSTER_DESC, "enableGuildTooltips")
            configOptions:CreateOptionToggle(L.SHOW_IN_WHO_UI, L.SHOW_IN_WHO_UI_DESC, "enableWhoTooltips")
            configOptions:CreateOptionToggle(L.SHOW_IN_SLASH_WHO_RESULTS, L.SHOW_IN_SLASH_WHO_RESULTS_DESC, "enableWhoMessages")

            configOptions:CreatePadding()
            configOptions:CreateHeadline(L.TOOLTIP_PROFILE)
            configOptions:CreateOptionToggle(L.SHOW_RAIDERIO_PROFILE, L.SHOW_RAIDERIO_PROFILE_DESC, "showRaiderIOProfile")
            configOptions:CreateOptionToggle(L.HIDE_OWN_PROFILE, L.HIDE_OWN_PROFILE_DESC, "hidePersonalRaiderIOProfile")
            configOptions:CreateOptionToggle(L.SHOW_RAID_ENCOUNTERS_IN_PROFILE, L.SHOW_RAID_ENCOUNTERS_IN_PROFILE_DESC, "showRaidEncountersInProfile")
            configOptions:CreateOptionToggle(L.SHOW_LEADER_PROFILE, L.SHOW_LEADER_PROFILE_DESC, "enableProfileModifier")
            configOptions:CreateOptionToggle(L.INVERSE_PROFILE_MODIFIER, L.INVERSE_PROFILE_MODIFIER_DESC, "inverseProfileModifier")
            configOptions:CreateOptionToggle(L.ENABLE_AUTO_FRAME_POSITION, L.ENABLE_AUTO_FRAME_POSITION_DESC, "positionProfileAuto")
            configOptions:CreateOptionToggle(L.ENABLE_LOCK_PROFILE_FRAME, L.ENABLE_LOCK_PROFILE_FRAME_DESC, "lockProfile")

            configOptions:CreatePadding()
            configOptions:CreateHeadline(L.RAIDERIO_CLIENT_CUSTOMIZATION)
            configOptions:CreateOptionToggle(L.ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS, L.ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS_DESC, "enableClientEnhancements", { needReload = true })
            configOptions:CreateOptionToggle(L.SHOW_CLIENT_GUILD_BEST, L.SHOW_CLIENT_GUILD_BEST_DESC, "showClientGuildBest")

            configOptions:CreatePadding()
            configOptions:CreateHeadline(L.COPY_RAIDERIO_PROFILE_URL)
            configOptions:CreateOptionToggle(L.ALLOW_ON_PLAYER_UNITS, L.ALLOW_ON_PLAYER_UNITS_DESC, "showDropDownCopyURL")
            configOptions:CreateOptionToggle(L.ALLOW_IN_LFD, L.ALLOW_IN_LFD_DESC, "enableLFGDropdown")

            local factionHeaderModules = {}
            configOptions:CreatePadding()
            configOptions:CreateHeadline(L.MYTHIC_PLUS_DB_MODULES)
            factionHeaderModules[#factionHeaderModules + 1] = configOptions:CreateModuleToggle(L.MODULE_AMERICAS, "RaiderIO_DB_US_A", "RaiderIO_DB_US_H")
            configOptions:CreateModuleToggle(L.MODULE_EUROPE, "RaiderIO_DB_EU_A", "RaiderIO_DB_EU_H")
            configOptions:CreateModuleToggle(L.MODULE_KOREA, "RaiderIO_DB_KR_A", "RaiderIO_DB_KR_H")
            configOptions:CreateModuleToggle(L.MODULE_TAIWAN, "RaiderIO_DB_TW_A", "RaiderIO_DB_TW_H")

            configOptions:CreatePadding()
            configOptions:CreateHeadline(L.RAIDING_DB_MODULES)
            factionHeaderModules[#factionHeaderModules + 1] = configOptions:CreateModuleToggle(L.MODULE_AMERICAS, "RaiderIO_DB_US_A_R", "RaiderIO_DB_US_H_R")
            configOptions:CreateModuleToggle(L.MODULE_EUROPE, "RaiderIO_DB_EU_A_R", "RaiderIO_DB_EU_H_R")
            configOptions:CreateModuleToggle(L.MODULE_KOREA, "RaiderIO_DB_KR_A_R", "RaiderIO_DB_KR_H_R")
            configOptions:CreateModuleToggle(L.MODULE_TAIWAN, "RaiderIO_DB_TW_A_R", "RaiderIO_DB_TW_H_R")

            -- add save button and cancel buttons
            local buttons = configOptions:CreateWidget("Frame", 4, configButtonFrame)
            buttons:ClearAllPoints()
            buttons:SetPoint("TOPLEFT", configButtonFrame, "TOPLEFT", 16, 0)
            buttons:SetPoint("BOTTOMRIGHT", configButtonFrame, "TOPRIGHT", -16, -10)
            buttons:Hide()
            local save = configOptions:CreateWidget("Button", 4, configButtonFrame)
            local cancel = configOptions:CreateWidget("Button", 4, configButtonFrame)
            save:ClearAllPoints()
            save:SetPoint("LEFT", buttons, "LEFT", 0, -12)
            save:SetSize(96, 28)
            save.text:SetText(SAVE)
            save.text:SetJustifyH("CENTER")
            save:SetScript("OnClick", Save_OnClick)
            cancel:ClearAllPoints()
            cancel:SetPoint("RIGHT", buttons, "RIGHT", 0, -12)
            cancel:SetSize(96, 28)
            cancel.text:SetText(CANCEL)
            cancel.text:SetJustifyH("CENTER")
            cancel:SetScript("OnClick", Close_OnClick)

            -- adjust frame height dynamically
            local children = {configFrame:GetChildren()}
            local height = 70
            for i = 1, #children do
                height = height + children[i]:GetHeight() + 2
            end

            configSliderFrame:SetMinMaxValues(1, height - 440)
            configFrame:SetHeight(height)

            -- adjust frame width dynamically (add padding based on the largest option label string)
            local maxWidth = 0
            for i = 1, #configOptions.options do
                local option = configOptions.options[i]
                if option.text and option.text:GetObjectType() == "FontString" then
                    maxWidth = max(maxWidth, option.text:GetStringWidth())
                end
            end
            configFrame:SetWidth(160 + maxWidth)
            configParentFrame:SetWidth(160 + maxWidth)

            -- add faction headers over the first module
            for i = 1, #factionHeaderModules do
                local module = factionHeaderModules[i]
                local af = configOptions:CreateHeadline("|TInterface\\Icons\\inv_bannerpvp_02:0:0:0:0:16:16:4:12:4:12|t")
                af:ClearAllPoints()
                af:SetPoint("BOTTOM", module.checkButton2, "TOP", 2, -5)
                af:SetSize(32, 32)

                local hf = configOptions:CreateHeadline("|TInterface\\Icons\\inv_bannerpvp_01:0:0:0:0:16:16:4:12:4:12|t")
                hf:ClearAllPoints()
                hf:SetPoint("BOTTOM", module.checkButton, "TOP", 2, -5)
                hf:SetSize(32, 32)
            end
        end

        return configParentFrame
    end

    local function SmartLoad()
        if settingsFrame then
            return true
        end
        if not settings:CanLoad() then
            return false
        end
        settings:OnLoad()
        return true
    end

    local function CreateInterfacePanel()
        local function Button_OnClick()
            if not InCombatLockdown() then
                if not SmartLoad() then
                    return
                end
                settingsFrame:SetShown(not settingsFrame:IsShown())
            end
        end

        local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
        panel.name = addonName
        panel:Hide()

        local button = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
        button:SetText(L.OPEN_CONFIG)
        button:SetWidth(button:GetTextWidth() + 18)
        button:SetPoint("TOPLEFT", 16, -16)
        button:SetScript("OnClick", Button_OnClick)

        InterfaceOptions_AddCategory(panel, true)
    end

    local function CreateSlashCommand()
        _G["SLASH_" .. addonName .. "1"] = "/raiderio"
        _G["SLASH_" .. addonName .. "2"] = "/rio"

        local function handler(text)
            if not SmartLoad() then
                return
            end

            if type(text) == "string" then

                if text:find("[Ll][Oo][Cc][Kk]") then
                    profile:ToggleDrag()
                    return
                end

                if text:find("[Dd][Ee][Bb][Uu][Gg]") then
                    StaticPopup_Show(debugPopup.id)
                    return
                end

                if text:find("[Gg][Rr][Oo][Uu][Pp]") then
                    json:OpenCopyDialog()
                    return
                end

                local searchQuery = text:match("[Ss][Ee][Aa][Rr][Cc][Hh]%s*(.-)$")
                if searchQuery then
                    if strlenutf8(searchQuery) > 0 then
                        search:Show()
                        search:Search(searchQuery)
                    else
                        search:Toggle()
                    end
                    return
                end

            end

            -- resume regular routine
            if not InCombatLockdown() then
                settingsFrame:SetShown(not settingsFrame:IsShown())
            end
        end

        SlashCmdList[addonName] = handler
    end

    local function PreparePopup(popup)
        if type(popup.text) == "function" then
            popup.text = popup.text()
        end
        return popup
    end

    local function OnConfigReady()
        settings:Enable()
        settingsFrame = CreateOptions()
        StaticPopupDialogs[reloadPopup.id] = PreparePopup(reloadPopup)
        StaticPopupDialogs[debugPopup.id] = PreparePopup(debugPopup)
    end

    function settings:OnLoad()
        callback:RegisterEvent(OnConfigReady, "RAIDERIO_CONFIG_READY")
    end

    function settings:Show()
        if not self:IsEnabled() then
            return
        end
        settingsFrame:Show()
    end

    function settings:Hide()
        if not self:IsEnabled() then
            return
        end
        settingsFrame:Hide()
    end

    -- always have the interface panel and slash commands available
    CreateInterfacePanel()
    CreateSlashCommand()

end
