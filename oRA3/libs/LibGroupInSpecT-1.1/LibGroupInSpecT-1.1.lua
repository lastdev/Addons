-- vim: ts=2 sw=2 ai et fenc=utf8

--[[
-- These events can be registered for using the regular CallbackHandler ways.
--
-- "GroupInSpecT_Update", guid, unit, info
-- "GroupInSpecT_Remove, guid
-- "GroupInSpecT_InspectReady", guid, unit
--
-- Where <info> is a table containing some or all of the following:
--   .guid
--   .name
--   .realm
--   .race
--   .race_localized
--   .class
--   .class_localized
--   .class_id
--   .gender -- 2 = male, 3 = female
--   .global_spec_id
--   .spec_index
--   .spec_name_localized
--   .spec_description
--   .spec_icon
--   .spec_background
--   .spec_role
--   .spec_role_detailed
--   .spec_group -- active spec group (1/2/nil)
--   .talents = {
--     [<talent_id>] = {
--       .rank
--       .max_ranks
--       .name_localized
--       .icon
--       .node_id
--       .talent_id
--       .spell_id
--     }
--     ...
--   }
--   .pvp_talents = {
--     [<talent_id>] = {
--       .name_localized
--       .icon
--       .talent_id
--       .spell_id
--     }
--     ...
--   }
--   .lku -- last known unit id
--   .not_visible
--
-- Functions for external use:
--
--   lib:Rescan (guid or nil)
--     Force a rescan of the given group member GUID, or of all current group members if nil.
--
--   lib:QueuedInspections ()
--     Returns an array of GUIDs of outstanding inspects.
--
--   lib:StaleInspections ()
--     Returns an array of GUIDs for which the data has become stale and is
--     awaiting an update (no action required, the refresh happens internally).
--     Due to Blizzard exposing no events on (re/un)talent, there will be
--     frequent marking of inspect data as being stale.
--
--   lib:GetCachedInfo (guid)
--     Returns the cached info for the given GUID, if available, nil otherwise.
--     Information is cached for current group members only.
--
--   lib:GroupUnits ()
--     Returns an array with the set of unit ids for the current group.
--]]

local MAJOR, MINOR = "LibGroupInSpecT-1.1", 97

if not LibStub then error(MAJOR.." requires LibStub") end
local lib = LibStub:NewLibrary (MAJOR, MINOR)
if not lib then return end

lib.events = lib.events or LibStub ("CallbackHandler-1.0"):New (lib)
if not lib.events then error(MAJOR.." requires CallbackHandler") end


local UPDATE_EVENT = "GroupInSpecT_Update"
local REMOVE_EVENT = "GroupInSpecT_Remove"
local INSPECT_READY_EVENT = "GroupInSpecT_InspectReady"
local QUEUE_EVENT = "GroupInSpecT_QueueChanged"

local COMMS_PREFIX = "LGIST11"
local COMMS_FMT = "3"
local COMMS_DELIM = "\a"

local INSPECT_DELAY = 1.5
local INSPECT_TIMEOUT = 10 -- If we get no notification within 10s, give up on unit

local MAX_ATTEMPTS = 2

--[==[@debug@
lib.debug = false
local function debug (...)
  if lib.debug then  -- allow programmatic override of debug output by client addons
    print (...)
  end
end
--@end-debug@]==]

function lib.events:OnUsed(target, eventname)
  if eventname == INSPECT_READY_EVENT then
    target.inspect_ready_used = true
  end
end

function lib.events:OnUnused(target, eventname)
  if eventname == INSPECT_READY_EVENT then
    target.inspect_ready_used = nil
  end
end

-- Frame for events
local frame = _G[MAJOR .. "_Frame"] or CreateFrame ("Frame", MAJOR .. "_Frame")
lib.frame = frame
frame:Hide()
frame:UnregisterAllEvents ()
frame:RegisterEvent ("PLAYER_LOGIN")
frame:RegisterEvent ("PLAYER_LOGOUT")
if not frame.OnEvent then
  frame.OnEvent = function(this, event, ...)
    local eventhandler = lib[event]
    return eventhandler and eventhandler (lib, ...)
  end
  frame:SetScript ("OnEvent", frame.OnEvent)
end


-- Hide our run-state in an easy-to-dump object
lib.state = {
  mainq = {}, staleq = {}, -- inspect queues
  t = 0,
  last_inspect = 0,
  current_guid = nil,
  throttle = 0,
  tt = 0,
  debounce_send_update = 0,
}
lib.cache = {}
lib.static_cache = {}


-- Note: if we cache NotifyInspect, we have to hook before we cache it!
if not lib.hooked then
  hooksecurefunc("NotifyInspect", function (...) return lib:NotifyInspect (...) end)
  lib.hooked = true
end
function lib:NotifyInspect(unit)
  self.state.last_inspect = GetTime()
end

-- luacheck: globals InspectFrame NotifyInspect
-- Get local handles on the key API functions
local CanInspect                      = _G.CanInspect
local ClearInspectPlayer              = _G.ClearInspectPlayer
local GetClassInfo                    = _G.GetClassInfo
local GetNumSubgroupMembers           = _G.GetNumSubgroupMembers
local GetNumSpecializationsForClassID = _G.GetNumSpecializationsForClassID
local GetPlayerInfoByGUID             = _G.GetPlayerInfoByGUID
local GetInspectSelectedPvpTalent     = _G.C_SpecializationInfo.GetInspectSelectedPvpTalent
local GetInspectSpecialization        = _G.GetInspectSpecialization
local GetSpecialization               = _G.GetSpecialization
local GetSpecializationInfo           = _G.GetSpecializationInfo
local GetSpecializationInfoForClassID = _G.GetSpecializationInfoForClassID
local GetSpecializationRoleByID       = _G.GetSpecializationRoleByID
local GetPvpTalentInfoByID            = _G.GetPvpTalentInfoByID
local GetPvpTalentSlotInfo            = _G.C_SpecializationInfo.GetPvpTalentSlotInfo
local IsInRaid                        = _G.IsInRaid
-- local NotifyInspect                = _G.NotifyInspect -- Don't cache, as to avoid missing future hooks
local GetNumClasses                   = _G.GetNumClasses
local UnitExists                      = _G.UnitExists
local UnitGUID                        = _G.UnitGUID
local UnitInParty                     = _G.UnitInParty
local UnitInRaid                      = _G.UnitInRaid
local UnitIsConnected                 = _G.UnitIsConnected
local UnitIsPlayer                    = _G.UnitIsPlayer
local UnitIsUnit                      = _G.UnitIsUnit
local UnitName                        = _G.UnitName
local UnitTokenFromGUID               = _G.UnitTokenFromGUID
local SendAddonMessage                = _G.C_ChatInfo.SendAddonMessage
local RegisterAddonMessagePrefix      = _G.C_ChatInfo.RegisterAddonMessagePrefix
local C_ClassTalents                  = _G.C_ClassTalents
local C_Traits                        = _G.C_Traits

local NUM_PVP_TALENT_SLOTS            = 3

local global_spec_id_roles_detailed = {
  -- Death Knight
  [250] = "tank", -- Blood
  [251] = "melee", -- Frost
  [252] = "melee", -- Unholy
  -- Demon Hunter
  [577] = "melee", -- Havoc
  [581] = "tank", -- Vengeance
  -- Druid
  [102] = "ranged", -- Balance
  [103] = "melee", -- Feral
  [104] = "tank", -- Guardian
  [105] = "healer", -- Restoration
  -- Evoker
  [1467] = "ranged", -- Devastation
  [1468] = "healer", -- Preservation
  -- Hunter
  [253] = "ranged", -- Beast Mastery
  [254] = "ranged", -- Marksmanship
  [255] = "melee", -- Survival
  -- Mage
  [62] = "ranged", -- Arcane
  [63] = "ranged", -- Fire
  [64] = "ranged", -- Frost
  -- Monk
  [268] = "tank", -- Brewmaster
  [269] = "melee", -- Windwalker
  [270] = "healer", -- Mistweaver
  -- Paladin
  [65] = "healer", -- Holy
  [66] = "tank", -- Protection
  [70] = "melee", -- Retribution
  -- Priest
  [256] = "healer", -- Discipline
  [257] = "healer", -- Holy
  [258] = "ranged", -- Shadow
  -- Rogue
  [259] = "melee", -- Assassination
  [260] = "melee", -- Combat
  [261] = "melee", -- Subtlety
  -- Shaman
  [262] = "ranged", -- Elemental
  [263] = "melee", -- Enhancement
  [264] = "healer", -- Restoration
  -- Warlock
  [265] = "ranged", -- Affliction
  [266] = "ranged", -- Demonology
  [267] = "ranged", -- Destruction
  -- Warrior
  [71] = "melee", -- Arms
  [72] = "melee", -- Fury
  [73] = "tank", -- Protection
}

local class_fixed_roles = {
  HUNTER = "DAMAGER",
  MAGE = "DAMAGER",
  ROGUE = "DAMAGER",
  WARLOCK = "DAMAGER",
}

local class_fixed_roles_detailed = {
  MAGE = "ranged",
  ROGUE = "melee",
  WARLOCK = "ranged",
}

-- Inspects only work after being fully logged in, so track that
function lib:PLAYER_LOGIN ()
  self.state.logged_in = true

  self:CacheGameData ()

  frame:RegisterEvent ("INSPECT_READY")
  frame:RegisterEvent ("GROUP_ROSTER_UPDATE")
  frame:RegisterEvent ("PLAYER_ENTERING_WORLD")
  frame:RegisterEvent ("UNIT_LEVEL")
  frame:RegisterEvent ("PLAYER_TALENT_UPDATE")
  frame:RegisterEvent ("PLAYER_SPECIALIZATION_CHANGED")
  frame:RegisterEvent ("UNIT_SPELLCAST_SUCCEEDED")
  frame:RegisterEvent ("UNIT_NAME_UPDATE")
  frame:RegisterEvent ("UNIT_AURA")
  frame:RegisterEvent ("CHAT_MSG_ADDON")
  RegisterAddonMessagePrefix (COMMS_PREFIX)

  local guid = UnitGUID ("player")
  local info = self:BuildInfo ("player")
  self.events:Fire (UPDATE_EVENT, guid, "player", info)
end

function lib:PLAYER_LOGOUT ()
  self.state.logged_in = false
end


-- Simple timer
do
  lib.state.t = 0
  if not frame.OnUpdate then -- ticket #4 if the OnUpdate code every changes we should stop borrowing the existing handler
    frame.OnUpdate = function(this, elapsed)
      lib.state.t = lib.state.t + elapsed
      lib.state.tt = lib.state.tt + elapsed
      if lib.state.t > INSPECT_DELAY then
        lib:ProcessQueues ()
        lib.state.t = 0
      end
      -- Unthrottle, essentially allowing 1 msg every 3 seconds, but with substantial burst capacity
      if lib.state.tt > 3 and lib.state.throttle > 0 then
        lib.state.throttle = lib.state.throttle - 1
        lib.state.tt = 0
      end
      if lib.state.debounce_send_update > 0 then
        local debounce = lib.state.debounce_send_update - elapsed
        lib.state.debounce_send_update = debounce
        if debounce <= 0 then lib:SendLatestSpecData () end
      end
    end
    frame:SetScript("OnUpdate", frame.OnUpdate) -- this is good regardless of the handler check above because otherwise a new anonymous function is created every time the OnUpdate code runs
  end
end


-- Internal library functions

-- Caches to deal with API shortcomings as well as performance
lib.static_cache.global_specs = {}           -- [gspec]         -> { .idx, .name_localized, .description, .icon, .background, .role }
lib.static_cache.class_to_class_id = {}      -- [CLASS]         -> class_id

-- The talents cache can no longer be pre-fetched on login, but is now constructed class-by-class as we inspect people.
-- This probably means we want to only ever access it through the GetCachedTalentInfoByID() helper function below.
lib.static_cache.talents = {}                -- [talent_id]      -> { .spell_id, .talent_id, .name_localized, .icon, .max_ranks, .rank }
lib.static_cache.pvp_talents = {}            -- [talent_id]      -> { .spell_id, .talent_id, .name_localized, .icon }

function lib:GetCachedTalentInfoByID(talent_id, config_id)
  if not talent_id then return nil end
  local talents = self.static_cache.talents
  local talent = talents[talent_id]
  if not talent then
    local entry = C_Traits.GetEntryInfo(config_id or -3, talent_id)
    if not entry then
      --[==[@debug@
      debug("GetCachedTalentInfoByID(" .. tostring(talent_id) .. "," .. tostring(config_id) .. ") returned nil") --@end-debug@]==]
      return nil
    end
    if entry.definitionID then
      local definition = C_Traits.GetDefinitionInfo(entry.definitionID)
      talent = {
        talent_id = talent_id,
        spell_id = definition.spellID,
        name_localized = TalentUtil.GetTalentNameFromInfo(definition),
        icon = TalentButtonUtil.CalculateIconTexture(definition, definition.spellID),
        max_ranks = entry.maxRanks,
      }
      -- talents[talent_id] = talent -- don't actually cache.
    end
  end
  return talent
end

function lib:GetCachedPvpTalentInfoByID (talent_id)
  if not talent_id then return nil end
  local pvp_talents = self.static_cache.pvp_talents
  local talent = pvp_talents[talent_id]
  if not talent then
    local _, name, icon, _, _, spell_id = GetPvpTalentInfoByID (talent_id)
    if not name then
      --[==[@debug@
      debug ("GetCachedPvpTalentInfo("..tostring(talent_id)..") returned nil") --@end-debug@]==]
      return nil
    end

    talent = {
      talent_id = talent_id,
      spell_id = spell_id,
      name_localized = name,
      icon = icon,
    }
    -- pvp_talents[talent_id] = talent -- don't actually cache.
  end
  return talent
end

function lib:CacheGameData ()
  local gspecs = self.static_cache.global_specs
  gspecs[0] = {} -- Handle no-specialization case
  for class_id = 1, GetNumClasses () do
    for idx = 1, GetNumSpecializationsForClassID (class_id) do
      local gspec_id, name, description, icon, background = GetSpecializationInfoForClassID (class_id, idx)
      gspecs[gspec_id] = {}
      local gspec = gspecs[gspec_id]
      gspec.idx = idx
      gspec.name_localized = name
      gspec.description = description
      gspec.icon = icon
      gspec.background = background
      gspec.role = GetSpecializationRoleByID (gspec_id)
    end

    local _, class = GetClassInfo (class_id)
    self.static_cache.class_to_class_id[class] = class_id
  end
end


function lib:GuidToUnit (guid)
  local info = self.cache[guid]
  if info and info.lku and UnitGUID(info.lku) == guid then
    return info.lku
  end

  local unit = UnitTokenFromGUID(guid)
  if info then
    info.lku = unit
  end
  return unit
end


function lib:Query (unit)
  if not UnitIsPlayer (unit) then return end -- NPC

  if UnitIsUnit (unit, "player") then
    self.events:Fire (UPDATE_EVENT, UnitGUID("player"), "player", self:BuildInfo ("player"))
    return
  end

  local mainq, staleq = self.state.mainq, self.state.staleq

  local guid = UnitGUID (unit)
  if not mainq[guid] then
    mainq[guid] = 1
    staleq[guid] = nil
    self.frame:Show () -- Start timer if not already running
    self.events:Fire (QUEUE_EVENT)
  end
end


function lib:Refresh (unit)
  local guid = UnitGUID (unit)
  if not guid then return end
  --[==[@debug@
  debug ("Refreshing "..unit) --@end-debug@]==]
  if not self.state.mainq[guid] then
    self.state.staleq[guid] = 1
    self.frame:Show ()
    self.events:Fire (QUEUE_EVENT)
  end
end


function lib:ProcessQueues ()
  if not self.state.logged_in then return end
  if InCombatLockdown () then return end -- Never inspect while in combat
  if UnitIsDead ("player") then return end -- You can't inspect while dead, so don't even try
  if InspectFrame and InspectFrame:IsShown () then return end -- Don't mess with the UI's inspections

  local mainq = self.state.mainq
  local staleq = self.state.staleq

  if not next (mainq) and next(staleq) then
    --[==[@debug@
    debug ("Main queue empty, swapping main and stale queues") --@end-debug@]==]
    self.state.mainq, self.state.staleq = self.state.staleq, self.state.mainq
    mainq, staleq = staleq, mainq
  end

  if (self.state.last_inspect + INSPECT_TIMEOUT) < GetTime () then
    -- If there was an inspect going, it's timed out, so either retry or move it to stale queue
    local guid = self.state.current_guid
    if guid then
      --[==[@debug@
      debug ("Inspect timed out for "..guid) --@end-debug@]==]

      local count = mainq and mainq[guid] or (MAX_ATTEMPTS + 1)
      if not self:GuidToUnit (guid) then
        --[==[@debug@
        debug ("No longer applicable, removing from queues") --@end-debug@]==]
        mainq[guid], staleq[guid] = nil, nil
      elseif count > MAX_ATTEMPTS then
        --[==[@debug@
        debug ("Excessive retries, moving to stale queue") --@end-debug@]==]
        mainq[guid], staleq[guid] = nil, 1
      else
        mainq[guid] = count + 1
      end
      self.state.current_guid = nil
    end
  end

  if self.state.current_guid then return end -- Still waiting on our inspect data

  for guid,count in pairs (mainq) do
    local unit = self:GuidToUnit (guid)
    if not unit then
      --[==[@debug@
      debug ("No longer applicable, removing from queues") --@end-debug@]==]
      mainq[guid], staleq[guid] = nil, nil
    elseif not CanInspect (unit) or not UnitIsConnected (unit) then
      --[==[@debug@
      debug ("Cannot inspect "..unit..", aka "..(UnitName(unit) or "nil")..", moving to stale queue") --@end-debug@]==]
      mainq[guid], staleq[guid] = nil, 1
    else
      --[==[@debug@
      debug ("Inspecting "..unit..", aka "..(UnitName(unit) or "nil")) --@end-debug@]==]
      mainq[guid] = count + 1
      self.state.current_guid = guid
      NotifyInspect (unit)
      break
    end
  end

  if not next (mainq) and not next (staleq) and self.state.throttle == 0 and self.state.debounce_send_update <= 0 then
    frame:Hide() -- Cancel timer, nothing queued and no unthrottling to be done
  end
  self.events:Fire (QUEUE_EVENT)
end


function lib:UpdatePlayerInfo (guid, unit, info)
  info.class_localized, info.class, info.race_localized, info.race, info.gender, info.name, info.realm = GetPlayerInfoByGUID (guid)
  local class = info.class
  if info.realm == "" then info.realm = nil end
  info.class_id = self.static_cache.class_to_class_id[class]
  if not info.spec_role then info.spec_role = class_fixed_roles[class] end
  if not info.spec_role_detailed then info.spec_role_detailed = class_fixed_roles_detailed[class] end
  info.lku = unit
end


function lib:BuildInfo (unit)
  local guid = UnitGUID (unit)
  if not guid then return end

  local cache = self.cache
  local info = cache[guid] or {}
  cache[guid] = info
  info.guid = guid

  self:UpdatePlayerInfo (guid, unit, info)
  -- On a cold login, GetPlayerInfoByGUID() doesn't seem to be usable, so mark as stale
  local class = info.class
  if not class and not self.state.mainq[guid] then
    self.state.staleq[guid] = 1
    self.frame:Show ()
    self.events:Fire (QUEUE_EVENT)
  end

  local is_inspect = not UnitIsUnit (unit, "player")

  local gspec_id
  if is_inspect then
    gspec_id = GetInspectSpecialization(unit)
  else
    local spec = GetSpecialization()
    gspec_id = spec and GetSpecializationInfo(spec)
  end

  local gspecs = self.static_cache.global_specs
  if not gspecs[gspec_id] then -- not a valid spec_id
    info.global_spec_id = nil
  else
    info.global_spec_id = gspec_id
    local spec_info = gspecs[gspec_id]
    info.spec_index          = spec_info.idx
    info.spec_name_localized = spec_info.name_localized
    info.spec_description    = spec_info.description
    info.spec_icon           = spec_info.icon
    info.spec_background     = spec_info.background
    info.spec_role           = spec_info.role
    info.spec_role_detailed  = global_spec_id_roles_detailed[gspec_id]
  end

  if not info.spec_role then info.spec_role = class and class_fixed_roles[class] end
  if not info.spec_role_detailed then info.spec_role_detailed = class and class_fixed_roles_detailed[class] end

  info.talents = info.talents or {}
  info.pvp_talents = info.pvp_talents or {}

  -- Only scan talents when we have player data
  if info.spec_index then
    info.spec_group = GetActiveSpecGroup (is_inspect)

    wipe (info.talents)
    local config_id = is_inspect and -1 or C_ClassTalents.GetActiveConfigID()
    if not config_id and gspec_id then
      local config_list = C_ClassTalents.GetConfigIDsBySpecID(gspec_id)
      config_id = config_list[1]
    end
    local config = config_id and C_Traits.GetConfigInfo(config_id)
    if config then
      local tree_id = config.treeIDs[1]
      local node_list = C_Traits.GetTreeNodes(tree_id)
      for _, node_id in ipairs(node_list) do
        local node = C_Traits.GetNodeInfo(config_id, node_id)
        local is_node_granted = node.activeRank - node.ranksPurchased > 0
        local is_node_purchased = node.ranksPurchased > 0
        if (is_node_granted or is_node_purchased) and (not node.subTreeID or node.subTreeActive) then
          local entry_id = node.activeEntry.entryID
          local talent = self:GetCachedTalentInfoByID(entry_id, config_id)
          if talent then
            talent.rank = is_node_granted and node.maxRanks or node.ranksPurchased
            talent.node_id = node_id
            info.talents[entry_id] = talent
          end
        end
      end
    end

    wipe (info.pvp_talents)
    if is_inspect then
      for index = 1, NUM_PVP_TALENT_SLOTS do
        local talent_id = GetInspectSelectedPvpTalent (unit, index)
        if talent_id then
          info.pvp_talents[talent_id] = self:GetCachedPvpTalentInfoByID (talent_id)
        end
      end
    else
      -- C_SpecializationInfo.GetAllSelectedPvpTalentIDs will sometimes return a lot of extra talents
      for index = 1, NUM_PVP_TALENT_SLOTS do
        local slot_info = GetPvpTalentSlotInfo (index)
        local talent_id = slot_info and slot_info.selectedTalentID
        if talent_id then
          info.pvp_talents[talent_id] = self:GetCachedPvpTalentInfoByID (talent_id)
        end
      end
    end
  end

  info.glyphs = info.glyphs or {} -- kept for addons that still refer to this

  if is_inspect and not UnitIsVisible (unit) and UnitIsConnected (unit) then info.not_visible = true end

  return info
end


function lib:INSPECT_READY (guid)
  local unit = self:GuidToUnit (guid)
  local finalize = false
  if unit then
    if guid == self.state.current_guid then
      self.state.current_guid = nil -- Got what we asked for
      finalize = true
      --[==[@debug@
      debug ("Got inspection data for requested guid "..guid) --@end-debug@]==]
    end

    local mainq, staleq = self.state.mainq, self.state.staleq
    mainq[guid], staleq[guid] = nil, nil

    local gspec_id = GetInspectSpecialization (unit)
    if not self.static_cache.global_specs[gspec_id] then -- Bah, got garbage, flag as stale and try again
      staleq[guid] = 1
      return
    end

    self.events:Fire (UPDATE_EVENT, guid, unit, self:BuildInfo (unit))
    self.events:Fire (INSPECT_READY_EVENT, guid, unit)
  end
  if finalize then
    ClearInspectPlayer ()
  end
  self.events:Fire (QUEUE_EVENT)
end


function lib:PLAYER_ENTERING_WORLD ()
  self.state.debounce_send_update = 2.5 -- delay comm update after loading
  if self.commScope == "INSTANCE_CHAT" then
    -- Handle moving directly from one LFG to another
    self.commScope = nil
    self:UpdateCommScope ()
  end
end


-- Group handling parts

local members = {}
function lib:GROUP_ROSTER_UPDATE ()
  local group = self.cache
  local units = self:GroupUnits ()
  -- Find new members
  for i,unit in ipairs (self:GroupUnits ()) do
    local guid = UnitGUID (unit)
    if guid then
      members[guid] = true
      if not group[guid] then
        self:Query (unit)
        -- Update with what we have so far (guid, unit, name/class/race?)
        self.events:Fire (UPDATE_EVENT, guid, unit, self:BuildInfo (unit))
      end
    end
  end
  -- Find removed members
  for guid in pairs (group) do
    if not members[guid] then
      group[guid] = nil
      self.events:Fire (REMOVE_EVENT, guid, nil)
    end
  end
  wipe (members)
  self:UpdateCommScope ()
end


function lib:DoPlayerUpdate ()
  self:Query ("player")
  self.state.debounce_send_update = 2.5 -- Hold off 2.5sec before sending update
  self.frame:Show ()
end

-- LibStub("LibGroupInSpecT-1.1"):SendLatestSpecData()
function lib:SendLatestSpecData ()
  local scope = self.commScope
  if not scope then return end

  local guid = UnitGUID ("player")
  local info = self.cache[guid]
  if not info then return end

  -- fmt, guid, global_spec_id, talents, pvptalent1 -> NUM_PVP_TALENT_SLOTS
  local datastr = strjoin(COMMS_DELIM, COMMS_FMT, guid, info.global_spec_id or 0)

  local talents = ""
  local config_id = C_ClassTalents.GetActiveConfigID()
  if not config_id and info.global_spec_id then
    local config_list = C_ClassTalents.GetConfigIDsBySpecID(info.global_spec_id)
    config_id = config_list[1]
  end
  if config_id then
    talents = C_Traits.GenerateImportString(config_id) or ""
  end
  datastr = datastr..COMMS_DELIM..talents

  local talentCount = 1
  for k in pairs(info.pvp_talents) do
    datastr = datastr..COMMS_DELIM..k
    talentCount = talentCount + 1
  end
  for i = talentCount, NUM_PVP_TALENT_SLOTS do
    datastr = datastr..COMMS_DELIM..0
  end

  --[==[@debug@
  debug ("Sending LGIST update to "..scope) --@end-debug@]==]
  SendAddonMessage(COMMS_PREFIX, datastr, scope)
end


function lib:UpdateCommScope ()
  local scope = (IsInGroup (LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or (IsInRaid () and "RAID") or (IsInGroup (LE_PARTY_CATEGORY_HOME) and "PARTY")
  if self.commScope ~= scope then
    self.commScope = scope
    self:DoPlayerUpdate ()
  end
end


-- Indicies for various parts of the split data msg
local msg_idx = {}
msg_idx.fmt             = 1
msg_idx.guid            = msg_idx.fmt + 1
msg_idx.global_spec_id  = msg_idx.guid + 1
msg_idx.talents         = msg_idx.global_spec_id + 1
msg_idx.pvp_talents     = msg_idx.talents + 1
msg_idx.end_pvp_talents = msg_idx.pvp_talents + NUM_PVP_TALENT_SLOTS - 1


local function decode_talent_string(import_string, talents_table)
  if not import_string or import_string == "" then
    return false
  end

  -- Serialization Version 2
  local import_stream = ExportUtil.MakeImportDataStream(import_string)

  local header_bit_width = 8 + 16 + 128 -- version + spec_id + tree_hash
  if import_stream:GetNumberOfBits() < header_bit_width then
    return false
  end

  local serialization_version = import_stream:ExtractValue(8)
  if serialization_version ~= 2 then -- bump to match C_Traits.GetLoadoutSerializationVersion()
    return false
  end

  local spec_id = import_stream:ExtractValue(16)
  import_stream:ExtractValue(128) -- tree_hash (16 * 8)

  local config_id = -3 -- VIEW_TRAIT_CONFIG_ID
  local tree_id = C_ClassTalents.GetTraitTreeForSpec(spec_id)
  for _, node_id in ipairs(C_Traits.GetTreeNodes(tree_id)) do
    if import_stream:ExtractValue(1) == 1 then -- isNodeSelected
      local is_node_purchased = import_stream:ExtractValue(1) == 1
      -- local is_node_granted = not is_node_purchased

      local node = C_Traits.GetNodeInfo(config_id, node_id)
      if not node then
        --[==[@debug@
        debug(_G.ERROR_COLOR:WrapTextInColorCode(("Error decoding talents (config:%s, tree:%s, node:%s)"):format(tostringall(config_id, tree_id, node_id)))) --@end-debug@]==]
        wipe(talents_table)
        return false
      end
      local entry_id = node.activeEntry and node.activeEntry.entryID
      local rank = node.maxRanks -- is_node_granted and 1 or node.maxRanks

      if is_node_purchased then
        if import_stream:ExtractValue(1) == 1 then -- isPartiallyRankedValue
          rank = import_stream:ExtractValue(6) -- bitWidthRanksPurchased
        end
        if import_stream:ExtractValue(1) == 1 then -- isChoiceNode
          local choice_node_index = import_stream:ExtractValue(2) + 1 -- stored as zero-index
          entry_id = node.entryIDs[choice_node_index]
        end
        if not entry_id then
          entry_id = node.entryIDs[1]
        end
      end

      local talent = lib:GetCachedTalentInfoByID(entry_id)
      if talent then
        talent.rank = rank
        talents_table[entry_id] = talent
      end
    end
  end

  return true
end


function lib:CHAT_MSG_ADDON (prefix, datastr, scope, sender)
  if prefix ~= COMMS_PREFIX or scope ~= self.commScope then return end
  sender = Ambiguate(sender, "none")

  --[==[@debug@
  debug(("Incoming LGIST update from %s/%s: %s"):format(tostringall(scope, sender, datastr:gsub(COMMS_DELIM, "#")))) --@end-debug@]==]

  local fmt = strsplit(COMMS_DELIM, datastr, 1)
  if fmt ~= COMMS_FMT then return end -- Unknown format, ignore

  local data = { strsplit(COMMS_DELIM, datastr) }

  local guid = data[msg_idx.guid]
  if UnitGUID(sender) ~= guid then return end

  local info = self.cache[guid]
  if not info then return end

  local unit = self:GuidToUnit (guid)
  if not unit then return end
  if UnitIsUnit (unit, "player") then return end -- we're already up-to-date, comment out for solo debugging

  self.state.throttle = self.state.throttle + 1
  self.frame:Show () -- Ensure we're unthrottling
  if self.state.throttle > 40 then return end -- If we ever hit this, someone's being "funny"

  info.class_localized, info.class, info.race_localized, info.race, info.gender, info.name, info.realm = GetPlayerInfoByGUID (guid)
  if info.realm and info.realm == "" then info.realm = nil end
  info.class_id = self.static_cache.class_to_class_id[info.class]

  local gspecs = self.static_cache.global_specs
  local gspec_id = tonumber(data[msg_idx.global_spec_id])
  if not gspecs[gspec_id] then return end -- Malformed message, avoid throwing errors by using this nil

  info.global_spec_id      = gspec_id
  info.spec_index          = gspecs[gspec_id].idx
  info.spec_name_localized = gspecs[gspec_id].name_localized
  info.spec_description    = gspecs[gspec_id].description
  info.spec_icon           = gspecs[gspec_id].icon
  info.spec_background     = gspecs[gspec_id].background
  info.spec_role           = gspecs[gspec_id].role
  info.spec_role_detailed  = global_spec_id_roles_detailed[gspec_id]

  local need_inspect = nil -- shouldn't be needed, but just in case

  info.talents = wipe(info.talents or {})
  if not decode_talent_string(data[msg_idx.talents], info.talents) then
    need_inspect = 1
  end

  info.pvp_talents = wipe(info.pvp_talents or {})
  for i = msg_idx.pvp_talents, msg_idx.end_pvp_talents do
    local talent_id = tonumber(data[i]) or 0
    if talent_id > 0 then
      local talent = self:GetCachedPvpTalentInfoByID(talent_id)
      if talent then
        info.pvp_talents[talent_id] = talent
      else
        need_inspect = 1
      end
    end
  end

  local mainq, staleq = self.state.mainq, self.state.staleq
  local want_inspect = not need_inspect and self.inspect_ready_used and (mainq[guid] or staleq[guid]) and 1 or nil
  mainq[guid], staleq[guid] = need_inspect, want_inspect
  if need_inspect or want_inspect then self.frame:Show () end

  --[==[@debug@
  debug ("Firing LGIST update event for unit "..unit..", GUID "..guid..", inspect "..tostring(not not need_inspect)) --@end-debug@]==]
  self.events:Fire (UPDATE_EVENT, guid, unit, info)
  self.events:Fire (QUEUE_EVENT)
end


function lib:UNIT_LEVEL (unit)
  if UnitInRaid (unit) or UnitInParty (unit) then
    self:Refresh (unit)
  end
  if UnitIsUnit (unit, "player") then
    self:DoPlayerUpdate ()
  end
end


function lib:PLAYER_TALENT_UPDATE ()
  self:DoPlayerUpdate ()
end


function lib:PLAYER_SPECIALIZATION_CHANGED (unit)
--  This event seems to fire a lot, and for no particular reason *sigh*
--  if UnitInRaid (unit) or UnitInParty (unit) then
--    self:Refresh (unit)
--  end
  if unit and UnitIsUnit (unit, "player") then
    self:DoPlayerUpdate ()
  end
end


function lib:UNIT_NAME_UPDATE (unit)
  local group = self.cache
  local guid = UnitGUID (unit)
  local info = guid and group[guid]
  if info then
    self:UpdatePlayerInfo (guid, unit, info)
    if info.name ~= UNKNOWN then
      self.events:Fire (UPDATE_EVENT, guid, unit, info)
    end
  end
end


-- Always get a UNIT_AURA when a unit's UnitIsVisible() changes
function lib:UNIT_AURA (unit)
  local group = self.cache
  local guid = UnitGUID (unit)
  local info = guid and group[guid]
  if info then
    if not UnitIsUnit (unit, "player") then
      if UnitIsVisible (unit) then
        if info.not_visible then
          info.not_visible = nil
          --[==[@debug@
          debug (unit..", aka "..(UnitName(unit) or "nil")..", is now visible") --@end-debug@]==]
          if not self.state.mainq[guid] then
            self.state.staleq[guid] = 1
            self.frame:Show ()
            self.events:Fire (QUEUE_EVENT)
          end
        end
      elseif UnitIsConnected (unit) then
        --[==[@debug@
        if not info.not_visible then
          debug (unit..", aka "..(UnitName(unit) or "nil")..", is no longer visible")
        end
        --@end-debug@]==]
        info.not_visible = true
      end
    end
  end
end


function lib:UNIT_SPELLCAST_SUCCEEDED (unit, _, spell_id)
  if spell_id == 200749 then -- Activating Specialization
    self:Query (unit) -- Definitely changed, so high prio refresh
  end
end


-- External library functions

function lib:QueuedInspections ()
  local q = {}
  for guid in pairs (self.state.mainq) do
    table.insert (q, guid)
  end
  return q
end


function lib:StaleInspections ()
  local q = {}
  for guid in pairs (self.state.staleq) do
    table.insert (q, guid)
  end
  return q
end


function lib:IsInspectQueued (guid)
  return guid and ((self.state.mainq[guid] or self.state.staleq[guid]) and true)
end


function lib:GetCachedInfo (guid)
  local group = self.cache
  return guid and group[guid]
end


function lib:Rescan (guid)
  local mainq, staleq = self.state.mainq, self.state.staleq
  if guid then
    local unit = self:GuidToUnit (guid)
    if unit then
      if UnitIsUnit (unit, "player") then
        self.events:Fire (UPDATE_EVENT, guid, "player", self:BuildInfo ("player"))
      elseif not mainq[guid] then
        staleq[guid] = 1
      end
    end
  else
    for i,unit in ipairs (self:GroupUnits ()) do
      if UnitExists (unit) then
        if UnitIsUnit (unit, "player") then
          self.events:Fire (UPDATE_EVENT, UnitGUID("player"), "player", self:BuildInfo ("player"))
        else
          guid = UnitGUID (unit)
          if guid and not mainq[guid] then
            staleq[guid] = 1
          end
        end
      end
    end
  end
  self.frame:Show () -- Start timer if not already running

  -- Evict any stale entries
  self:GROUP_ROSTER_UPDATE ()
  self.events:Fire (QUEUE_EVENT)
end


local unitstrings = {
  raid = { "player" }, -- This seems to be needed under certain circumstances. Odd.
  party = { "player" }, -- Player not part of partyN
  player = { "player" }
}
for i = 1,40 do table.insert (unitstrings.raid, "raid"..i) end
for i = 1,4  do table.insert (unitstrings.party, "party"..i) end


-- Returns an array with the set of unit ids for the current group
function lib:GroupUnits ()
  local units
  if IsInRaid () then
    units = unitstrings.raid
  elseif GetNumSubgroupMembers () > 0 then
    units = unitstrings.party
  else
    units = unitstrings.player
  end
  return units
end


-- If demand-loaded, we need to synthesize a login event
if IsLoggedIn () then lib:PLAYER_LOGIN () end
