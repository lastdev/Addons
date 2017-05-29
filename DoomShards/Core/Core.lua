local DS = LibStub("AceAddon-3.0"):GetAddon("Doom Shards", true)
if not DS then return end
local L = LibStub("AceLocale-3.0"):GetLocale("DoomShards")


--------------
-- Upvalues --
--------------
local C_TimerAfter = C_Timer.After
local GetSpecializationInfo = GetSpecializationInfo
local GetTime = GetTime
local pairs = pairs
local strsplit = strsplit
local tonumber = tonumber
local type = type
local UnitCastingInfo = UnitCastingInfo
local UnitGUID = UnitGUID
local UnitPower = UnitPower


---------------
-- Constants --
---------------
local MAX_RESOURCE = 5
local PLAYER_GUID
local UNIT_POWER_TYPE = "SOUL_SHARDS"
local UNIT_POWER_ID = SPELL_POWER_SOUL_SHARDS


---------------
-- Variables --
---------------
local generating = 0
local nextCast
local resource = 0
local auras = {}
DS.auras = auras
local resourceGeneration
local trackedAuras


---------------
-- Functions --
---------------
function DS:Update(timeStamp)
  self.timeStamp = timeStamp or GetTime()
  self.resource = resource
  self.auras = auras
  self.generating = generating
  self.nextCast = nextCast

  self:SendMessage("DOOM_SHARDS_UPDATE")
end

-- resets all data
function DS:ResetCount()
  self:Update()
end

function DS:Apply(GUID, spellID)
  local aura = self:BuildAura(spellID, GUID)
  auras[GUID] = auras[GUID] or {}  -- TODO: Set automatically
  auras[GUID][spellID] = aura
  aura:Apply()
  self:Update()
end

function DS:Remove(GUID, spellID)
  if not spellID then
    local auras_GUID = auras[GUID]
    if auras_GUID then
      for _, aura in pairs(auras_GUID) do
        aura:OnRemove()
      end
    end
    auras[GUID] = nil
  else
    local auras_GUID = auras[GUID]
    if auras_GUID then
      local aura = auras_GUID[spellID]
      if aura then
        aura:OnRemove()
        auras_GUID[spellID] = nil
      end
    end
  end
  self:Update()
end

function DS:Refresh(GUID, spellID)
  auras[GUID][spellID]:Refresh()
  self:Update()
end

function DS:Tick(GUID, spellID)
  if auras[GUID] and auras[GUID][spellID] then
    auras[GUID][spellID]:Tick()
    self:Update()
  end
end

function DS:Missed(GUID, spellID)
  if auras[GUID] and auras[GUID][spellID] then
    auras[GUID][spellID]:Missed()
    self:Update()
  end
end

do
  local function spellGUIDToID(GUID)
    local _, _, _, _, ID = strsplit("-", GUID)
    return tonumber(ID)
  end

  function DS:Cast(spellGUID)
    if spellGUID then
      local generation = resourceGeneration[spellGUIDToID(spellGUID)]
      if generation then
        if type(generation) == "function" then
          generation = generation()
        end
        generating = generation
        local _, _, _, _, startTime, endTime = UnitCastingInfo("player")
        nextCast = GetTime() + (endTime - startTime) / 1000
        self:Update()
      end
    elseif not UnitCastingInfo("player") then  -- Command Demon fires SPELL_CAST_SUCCEEDED
      generating = 0
      nextCast = nil
      self:Update()
    end
  end
end


--------------------
-- Event Handling --
--------------------
function DS:COMBAT_LOG_EVENT_UNFILTERED(_, timeStamp, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, ...)
  if sourceGUID == PLAYER_GUID then
    local spellID = ...
    if trackedAuras[spellID] and sourceGUID == PLAYER_GUID and self.db.specializations[spellID] then
      local trackedAura = trackedAuras[spellID]
      if auras[destGUID] and auras[destGUID][spellID] and event == trackedAura.refreshEvent then
        self:Refresh(destGUID, spellID)
      elseif event == trackedAura.applyEvent then
        self:Apply(destGUID, spellID)
      elseif event == trackedAura.removeEvent then
        self:Remove(destGUID, spellID)
      elseif event == trackedAura.tickEvent then
        self:Tick(destGUID, spellID)
        if resource < MAX_RESOURCE then
          resource = resource + 1
          self:UNIT_POWER_FREQUENT("UNIT_POWER_FREQUENT", "player", "SOUL_SHARDS")  -- fail safe in case the corresponding UNIT_POWER_FREQUENT fires wonkily
        end
      elseif event == trackedAura.missedEvent then
        self:Missed(destGUID, spellID)
      end
    end
  end

  if event == "UNIT_DIED" or event == "UNIT_DESTROYED" or event == "PARTY_KILL" or event == "SPELL_INSTAKILL" then
    self:Remove(destGUID)
  end
end

function DS:PLAYER_REGEN_DISABLED()
  if not self.locked then
    self:Lock()
  end
  if self.testMode then
    self:EndTestMode()
  end
  self:Update()
end

function DS:PLAYER_REGEN_ENABLED()  -- player left combat or died
  self:EndTestMode()
  if UnitIsDead("player") then
    self:ResetCount()
  else
    self:Update()
  end
end

function DS:UNIT_POWER_FREQUENT(_, unitID, power)
  if not (unitID == "player" and power == UNIT_POWER_TYPE) then return end
  resource = UnitPower("player", UNIT_POWER_ID)
  DS:Update()
end

function DS:UNIT_SPELLCAST_INTERRUPTED(_, unitID, _, _, spellGUID)
  if unitID == "player"  then
    self:Cast(false)
  end
end

function DS:UNIT_SPELLCAST_START(_, unitID, _, _, spellGUID)
  if unitID == "player"  then
    self:Cast(spellGUID)
  end
end

function DS:UNIT_SPELLCAST_STOP(_, unitID, _, _, spellGUID)
  if unitID == "player"  then
    self:Cast(false)
  end
end

function DS:UNIT_SPELLCAST_SUCCEEDED(_, unitID, _, _, spellGUID)
  if unitID == "player"  then
    self:Cast(false)
  end
end

function DS:PLAYER_ENTERING_WORLD()
  PLAYER_GUID = UnitGUID("player")
  resource = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
  self:ResetCount()
end


--------------------
-- Cleanup Ticker --
--------------------
do
  local CLEANUP_TOLERANCE = 1
  local CLEANUP_INTERVAL = 1

  local function cleanUp()
    local timeStamp = GetTime() - CLEANUP_TOLERANCE
    for GUID, tbl in pairs(auras) do
      for spellID, aura in pairs(tbl) do
        if aura.expiration < timeStamp then
          DS:Remove(GUID, spellID)
          DS:Update()
        end
      end
    end
    C_TimerAfter(CLEANUP_INTERVAL, cleanUp)
  end
  DS.CleanUp = cleanUp
  cleanUp()
end


-----------------------
-- Handling Settings --
-----------------------
do
  do
    DS.specializationID = nil
    function DS:SpecializationsCheck()
      local specialization = GetSpecialization()
      if specialization then
        local newSpecID = GetSpecializationInfo(specialization)
        if newSpecID and newSpecID ~= self.specializationID then
          self.specializationID = newSpecID
          self:Build()
          self:Update()
        end
      end
    end
  end

  function DS:Build()
    self:EndTestMode()
    self:ApplySettings()

    resource = UnitPower("player", UNIT_POWER_ID)

    local specSettings = DS.specSettings[DS.specializationID]
    resourceGeneration = specSettings.resourceGeneration
    trackedAuras = specSettings.trackedAuras

    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

    self:RegisterEvent("UNIT_POWER_FREQUENT")
    self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    self:RegisterEvent("UNIT_SPELLCAST_START")
    self:RegisterEvent("UNIT_SPELLCAST_STOP")
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

    if UnitAffectingCombat("player") then
      self:PLAYER_REGEN_DISABLED()

    elseif self.locked and not self.testMode then
      self:PLAYER_REGEN_ENABLED()

    end

  end
end


---------------
-- Test Mode --
---------------
do
  local testFrame = CreateFrame("frame")

  local resourceTicker
  local TestGUID = "Test Mode"
  local applyInterval = 10

  local function SATickerFunc()
    local timeStamp = GetTime()
    DS:Apply(TestGUID, -1)
    C_TimerAfter(applyInterval + 0.2, function() DS:Remove("Test Mode") end)
  end

  function DS:TestMode()
    if self.testMode then
      self:EndTestMode()
    else
      if UnitAffectingCombat("player") then return end
      if not self.locked then self:Lock() end
      self:PLAYER_REGEN_DISABLED()
      self.specializationID = -1

      for name, module in self:IterateModules() do
        if self.db[name] and self.db[name].enable then
          if module.frame then module.frame:Show() end
        end
        self:Update()
      end

      resourceTicker = C_Timer.NewTicker(1, function()
        resource = resource < MAX_RESOURCE and resource + 1 or 0
        DS:Update()
      end)

      SATickerFunc()
      SATicker = C_Timer.NewTicker(applyInterval+1, SATickerFunc)

      self.testMode = true
      print(L["Starting Test Mode"])
    end
  end

  function DS:EndTestMode()
    if self.testMode then
      self.testMode = false
      if resourceTicker then
        resourceTicker:Cancel()
        resourceTicker = nil
      end
      if SATicker then
        SATicker:Cancel()
        SATicker = nil
      end
      self:Remove("Test Mode")
      self:ResetCount()
      self:SpecializationsCheck()
      resource = UnitPower("player", UNIT_POWER_ID)
      self:Lock()
      if not UnitAffectingCombat("player") then
        self:PLAYER_REGEN_ENABLED()
      end
      print(L["Cancelled Test Mode"])
    end
  end

  testFrame:RegisterEvent("PLAYER_REGEN_DISABLED", DS.EndTestMode)
end
