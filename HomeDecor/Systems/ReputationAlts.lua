local ADDON, NS = ...

NS.Systems = NS.Systems or {}
NS.Systems.ReputationAlts = NS.Systems.ReputationAlts or {}
local RA = NS.Systems.ReputationAlts

local type = type
local pairs = pairs
local wipe = _G.wipe or function(t) for k in pairs(t) do t[k] = nil end end

local function Trim(s)
  if type(s) ~= "string" then return s end
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function GetCharacterKey()
  local name = UnitName and UnitName("player") or "Unknown"
  local realm = GetRealmName and GetRealmName() or "Unknown"
  return tostring(name) .. " - " .. tostring(realm)
end

local function GetAccountDB()
  local addon = NS.Addon
  if not addon or not addon.db then return nil end

  addon.db.global = addon.db.global or {}
  addon.db.global.repAlts = addon.db.global.repAlts or {
    byRep = {},
  }

  return addon.db.global.repAlts
end

local function ShouldTrackText(text)
  if type(text) ~= "string" then return false end
  local s = text:lower()
  if s == "" then return false end

  if s == "reputation required" then
    return false
  end

  if s:find("renown", 1, true) then
    return false
  end

  return true
end

local STANDING_RANK = {
  neutral = 1,
  friendly = 2,
  honored = 3,
  revered = 4,
  exalted = 5,
}

local function ParseFactionAndStanding(text)
  if type(text) ~= "string" then return nil, nil, 0 end
  local base, standing = text:match("^(.-)%s*%-%s*(%S+)$")
  base = Trim(base or "")
  local rank = STANDING_RANK[(standing and standing:lower()) or ""] or 0
  if base == "" then base = text end
  return base, standing, rank
end

function RA:Record(repText, met)
  if not ShouldTrackText(repText) then return end
  if met ~= true then return end

  local db = GetAccountDB()
  if not db then return end

  local byRep = db.byRep
  if type(byRep) ~= "table" then
    byRep = {}
    db.byRep = byRep
  end

  local key = tostring(repText)
  local baseName, _, rank = ParseFactionAndStanding(key)
  local charKey = GetCharacterKey()

  if rank > 0 then
    for existing, bucket in pairs(byRep) do
      local eBase, _, eRank = ParseFactionAndStanding(existing)
      if eBase == baseName then
        if eRank >= rank then
          if bucket[charKey] then
            return
          end
        else
          if bucket[charKey] then
            bucket[charKey] = nil
            local empty = true
            for _ in pairs(bucket) do
              empty = false
              break
            end
            if empty then
              byRep[existing] = nil
            end
          end
        end
      end
    end
  end

  local bucket = byRep[key]
  if type(bucket) ~= "table" then
    bucket = {}
    byRep[key] = bucket
  end

  if not bucket[charKey] then
    bucket[charKey] = true
  end
end

local function GetBucket(repText)
  local db = GetAccountDB()
  if not db then return nil end
  local byRep = db.byRep
  if type(byRep) ~= "table" then return nil end
  return byRep[repText]
end

function RA:GetPreferredCharacter(repText)
  if not ShouldTrackText(repText) then return nil end

  repText = tostring(repText or "")
  if repText == "" then return nil end

  local bucket = GetBucket(repText)
  if type(bucket) ~= "table" then return nil end

  local current = GetCharacterKey()
  if bucket[current] then
    return current
  end

  for charKey, has in pairs(bucket) do
    if has then
      return charKey
    end
  end

  return nil
end

function RA:GetAllCharacters(repText)
  local bucket = GetBucket(repText)
  if type(bucket) ~= "table" then return {} end

  local out, n = {}, 0
  for charKey, has in pairs(bucket) do
    if has then
      n = n + 1
      out[n] = charKey
    end
  end
  return out
end

function RA:CurrentCharacterHas(repText)
  local bucket = GetBucket(repText)
  if type(bucket) ~= "table" then return false end
  local current = GetCharacterKey()
  return bucket[current] and true or false
end

function RA:GetAnyOtherCharacter(repText)
  if not ShouldTrackText(repText) then return nil end

  repText = tostring(repText or "")
  if repText == "" then return nil end

  local bucket = GetBucket(repText)
  if type(bucket) ~= "table" then return nil end

  local current = GetCharacterKey()
  for charKey, has in pairs(bucket) do
    if has and charKey ~= current then
      return charKey
    end
  end

  return nil
end

local scanJob = nil

local function BuildScanList()
  local DI = NS.Systems and NS.Systems.DecorIndex
  if not DI then return {} end

  local list = {}

  for decorID, entry in pairs(DI) do
    if type(entry) == "table" then
      local it = entry.item
      local req = it and it.requirements
      if type(req) == "table" then
        local rep = req.rep or req.reputation
        if rep ~= nil then
          list[#list + 1] = it
        end
      end
    end
  end

  return list
end

local function ScanChunk()
  if not scanJob or not scanJob.running then return end

  local RepSys = NS.Systems and NS.Systems.Reputation
  if not RepSys or type(RepSys.GetRequirement) ~= "function" then
    scanJob.running = false
    return
  end

  local perTick = 10
  local i = 0

  while i < perTick and scanJob.index <= scanJob.count do
    local it = scanJob.list[scanJob.index]
    scanJob.index = scanJob.index + 1
    i = i + 1

    if type(it) == "table" then
      pcall(RepSys.GetRequirement, it)
    end
  end

  if scanJob.index > scanJob.count then
    scanJob.running = false
    return
  end

  if C_Timer and C_Timer.After then
    C_Timer.After(0.05, ScanChunk)
  end
end

function RA:WarmupCurrentCharacter()
  if scanJob and scanJob.running then return end

  local DI = NS.Systems and NS.Systems.DecorIndex
  if DI and type(DI.Build) == "function" then
    pcall(DI.Build, DI)
  end

  local list = BuildScanList()
  local count = #list
  if count == 0 then return end

  scanJob = scanJob or {}
  wipe(scanJob)
  scanJob.list = list
  scanJob.index = 1
  scanJob.count = count
  scanJob.running = true

  if C_Timer and C_Timer.After then
    C_Timer.After(1.0, ScanChunk)
  else
    ScanChunk()
  end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
  if RA and RA.WarmupCurrentCharacter then
    if C_Timer and C_Timer.After then
      C_Timer.After(3.0, function() RA:WarmupCurrentCharacter() end)
    else
      RA:WarmupCurrentCharacter()
    end
  end
end)

return RA

