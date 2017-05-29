local DS = LibStub("AceAddon-3.0"):GetAddon("Doom Shards", true)
if not DS then return end


--------------
-- Upvalues --
--------------
local GetActiveSpecGroup = GetActiveSpecGroup
local GetHaste = GetHaste
local GetSpecialization = GetSpecialization
local GetSpellCritChance = GetSpellCritChance
local GetSpellInfo = GetSpellInfo
local GetTalentInfo = GetTalentInfo
local ipairs = ipairs
local IsEquippedItem = IsEquippedItem
local IsInGroup = IsInGroup
local IsInRaid = IsInRaid
local pairs = pairs
local rawget = rawget
local rawset = rawset
local setmetatable = setmetatable
local sqrt = sqrt
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff
local UnitGUID = UnitGUID


---------------
-- Constants --
---------------
local MAX_BOSS_FRAMES = 5
local MAX_NAMEPLATES_TO_CHECK = 20
local MAX_PARTY_SIZE = 5
local MAX_RAID_SIZE = 40
local PANDEMIC_RANGE = 0.3


-------------
-- Utility --
-------------
local function getHasteMod()
  return 1 + GetHaste() / 100
end
DS.GetHasteMod = getHasteMod

local function buildUnhastedIntervalFunc(base)
  return function(aura)
    return base * DS.globalTimeMod
  end
end
DS.BuildUnhastedIntervalFunc = buildUnhastedIntervalFunc

local function buildHastedIntervalFunc(base)
  return function(aura)
    return base / getHasteMod() * DS.globalTimeMod
  end
end
DS.BuildHastedIntervalFunc = buildHastedIntervalFunc

local function buildUnitIDTable(str1, maxNum, str2)
  local tbl = {}
  for i = 1, maxNum do
    tbl[i] = str1..tostring(i)..(str2 or "")
  end
  return tbl
end
DS.BuildUnitIDTable = buildUnitIDTable

local function pandemicFunc(self)
  return PANDEMIC_RANGE * self.duration
end
DS.PandemicFunc = pandemicFunc


-------------------
-- Lookup Tables --
-------------------
local bossTable = buildUnitIDTable("boss", MAX_BOSS_FRAMES)
local nameplateTable = buildUnitIDTable("nameplate", MAX_NAMEPLATES_TO_CHECK)
local partyTable = buildUnitIDTable("party", MAX_PARTY_SIZE, "target")
local raidTable = buildUnitIDTable("raid", MAX_RAID_SIZE, "target")

local specSettings = {}
DS.specSettings = specSettings

local trackedAurasMetaTable = {}
trackedAurasMetaTable.__index = function(tbl, k)
  local func = rawget(tbl, k.."Func")
  return func and func(tbl) or nil
end

local auraMetaTable = {}  -- Aura prototypes


-------------------------------
-- Aura Methods and Handling --
-------------------------------
local dummyFunc = function()
end

local function iterateTickMethod(self, timeStamp)
  if timeStamp then
    local expiration = self.expiration
    local iteratedTick = timeStamp + self.tickLength
    local isLastTick = iteratedTick >= expiration
    return isLastTick and expiration or iteratedTick, self.resourceChance, isLastTick
  else
    local isLastTick = self.nextTick >= self.expiration
    return isLastTick and self.expiration or self.nextTick, self.resourceChance, isLastTick
  end
end

local function auraUnitDebuff(unit, auraName)
  local _, _, _, _, _, _, expires, _, _, _, _, _, _, _, _, timeMod = UnitDebuff(unit, auraName, nil, "PLAYER")
  return expires, timeMod
end

local function iterateUnitTable(aura, unitTable, GUID)
  for _, unit in ipairs(nameplateTable) do
    if UnitGUID(unit) == GUID then
      local expires, timeMod = auraUnitDebuff(unit, aura.name)
      return expires, timeMod
    end
  end
end

local function calculateExpiration(aura)
  local timestamp = GetTime()
  if aura.expiration then
    local belowPandemic = aura.expiration + aura.duration
    local overPandemic = timestamp + aura.duration + aura.pandemic
    return belowPandemic < overPandemic and belowPandemic or overPandemic
  else
    return timestamp + aura.duration
  end
end
DS.CalculateExpiration = calculateExpiration

DS.globalTimeMod = 1
local function setExpiration(aura)
  local GUID = aura.GUID
  local expires
  local timeMod

  if UnitGUID("target") == GUID then  -- Implies UnitExists
    expires, timeMod = auraUnitDebuff("target", aura.name)
  else
    expires, timeMod = iterateUnitTable(aura, nameplateTable, GUID)
    if not expires then
      if IsInRaid() then
        expires, timeMod = iterateUnitTable(aura, raidTable, GUID)
      elseif IsInGroup() then
        expires, timeMod = iterateUnitTable(aura, partyTable, GUID)
      end
    end
  end

  if aura.nameIsShared then  -- In case of multiple spells with the same name
    aura.expiration = calculateExpiration(aura)
  else
    aura.expiration = expires or calculateExpiration(aura)
  end
  DS.globalTimeMod = timeMod or 1

end
DS.SetExpiration = setExpiration

local function calculateNextTick(aura)
  local fullNextTick = GetTime() + aura.tickLength
  aura.nextTick = fullNextTick < aura.expiration and fullNextTick or aura.expiration
end
DS.CalculateNextTick = calculateNextTick

local function applyMethod(self)
  setExpiration(self)
  if self.hasInitialTick then
    self:Tick()
  else
    calculateNextTick(self)
  end
  self:OnApply()
end

local function refreshMethod(self)
  setExpiration(self)
  self:OnRefresh()
end

local function tickMethod(self)
  calculateNextTick(self)
  self:OnTick()
end

local function missedMethod(self)
  calculateNextTick(self)
  self:OnMissed()
end

function DS:AddSpecSettings(specID, resourceGeneration, trackedAuras, specHandling)
  local settings = {}
  specSettings[specID] = settings
  settings.resourceGeneration = resourceGeneration
  settings.trackedAuras = trackedAuras
  settings.specHandling = specHandling

  auraMetaTable[specID] = {}
  for k, v in pairs(trackedAuras) do
    setmetatable(v, trackedAurasMetaTable)

    -- Properties
    v.id = k
    v.name = GetSpellInfo(k)
    v.hasInitialTick = v.hasInitialTick == nil and true or v.hasInitialTick
    v.nameIsShared = v.nameIsShared or false  -- In case name is not unique for e.g. UnitDebuff
    v.applyEvent = v.applyEvent or "SPELL_AURA_APPLIED"
    v.refreshEvent = v.refreshEvent or "SPELL_AURA_REFRESH"
    v.removeEvent = v.removeEvent or "SPELL_AURA_REMOVED"
    v.tickEvent = v.tickEvent or "SPELL_PERIODIC_DAMAGE"
    v.missedEvent = v.missedEvent or "SPELL_PERIODIC_MISSED"

    -- Methods
    v.Apply = v.Apply or applyMethod
    v.Tick = v.Tick or tickMethod
    v.Refresh = v.Refresh or refreshMethod
    v.IterateTick = v.IterateTick or iterateTickMethod
    v.Missed = v.Missed or missedMethod
    v.OnApply = v.OnApply or dummyFunc
    v.OnTick = v.OnTick or dummyFunc
    v.OnRefresh = v.OnRefresh or dummyFunc
    v.OnRemove = v.OnRemove or dummyFunc
    v.OnMissed = v.OnMissed or dummyFunc

    auraMetaTable[specID][k] = {__index = v}
  end
end

function DS:BuildAura(spellID, GUID)
  local aura = {}
  setmetatable(aura, auraMetaTable[self.specializationID][spellID])
  aura.GUID = GUID

  return aura
end
