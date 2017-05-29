local DS = LibStub("AceAddon-3.0"):GetAddon("Doom Shards", true)
if not DS then return end

local WS = DS:NewModule("warningSound", "AceEvent-3.0")  -- can't use sound since it's a legacy option :/
local LSM = LibStub("LibSharedMedia-3.0")


--------------
-- Upvalues --
--------------
local GetTime = GetTime
local pairs = pairs
local PlaySoundFile = PlaySoundFile


------------
-- Frames --
------------
local WSFrame = DS:CreateParentFrame("DS Sound Display", "sound")  -- only used for OnUpdate
WSFrame:Hide()


---------------
-- Variables --
---------------
local db
local counter = 0
local isOverOrbThreshold  -- boolean to play sound
local soundFile
local soundInterval
local timeFrame


--------------
-- API Call --
--------------
function DoomShards:SetSound(bool)
  if bool then
    if UnitAffectingCombat("player") then WSFrame:Show() end
  else
    WSFrame:Hide()
  end
end


---------------
-- Functions --
---------------
do
  local previousOrbs = 0

  function WS:DOOM_SHARDS_UPDATE()
    local updatedOrbs = DS.resource

    if updatedOrbs < previousOrbs then counter = 0 end

    previousOrbs = updatedOrbs

    local expectedShards = 0
    local timeStamp = GetTime() + timeFrame
    for GUID, tbl in pairs(DS.auras) do
      local i = 0
      for spellID, aura in pairs(tbl) do
        local tick, resourceChance, isLastTick
        repeat
          tick, resourceChance, isLastTick = aura:IterateTick(tick)
          if tick < timeStamp then
            expectedShards = expectedShards + resourceChance
            i = i + 1
          end
        until isLastTick or tick > timeStamp or i > 100
      end
    end

    isOverOrbThreshold = (updatedOrbs >= 3) and (updatedOrbs + expectedShards) >= 5
  end
end

WSFrame:SetScript("OnUpdate", function(frame, elapsed)
  counter = counter - elapsed
  if counter <= 0 and isOverOrbThreshold then
    PlaySoundFile(soundFile, "Master")
    counter = soundInterval
  end
end)

function WS:PLAYER_REGEN_DISABLED()
  local _, instanceType = GetInstanceInfo()
  if instanceType == "party" and not IsInInstance() then instanceType = "none" end  -- fix for Garrisons
  if db.instances[instanceType] then WSFrame:Show() end
end

function WS:PLAYER_REGEN_ENABLED()
  WSFrame:Hide()
end

function WS:Build()
  db = DS.db.warningSound
  soundFile = LSM:Fetch("sound", DS.db.warningSound.soundHandle)
  soundInterval = DS.db.warningSound.soundInterval
  timeFrame = db.timeFrame

  if UnitAffectingCombat("player") then
    self:PLAYER_REGEN_DISABLED()
  end
end

function WS:OnEnable()
  self:RegisterMessage("DOOM_SHARDS_UPDATE")
  self:RegisterEvent("PLAYER_REGEN_DISABLED")
  self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function WS:OnDisable()
  WSFrame:Hide()
  self:UnregisterMessage("DOOM_SHARDS_UPDATE")
  self:UnregisterEvent("PLAYER_REGEN_DISABLED")
  self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end
