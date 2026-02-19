local ADDON, NS = ...

NS.Systems = NS.Systems or {}
NS.Systems.QuestsAlts = NS.Systems.QuestsAlts or {}
local QA = NS.Systems.QuestsAlts

local type = type
local pairs = pairs
local wipe = _G.wipe or function(t) for k in pairs(t) do t[k] = nil end end
local tonumber = tonumber
local C_QuestLog = C_QuestLog

local function GetCharacterKey()
  local name = UnitName and UnitName("player") or "Unknown"
  local realm = GetRealmName and GetRealmName() or "Unknown"
  return tostring(name) .. " - " .. tostring(realm)
end

local function GetAccountDB()
  local addon = NS.Addon
  if not addon or not addon.db then return nil end

  addon.db.global = addon.db.global or {}
  addon.db.global.questAlts = addon.db.global.questAlts or {
    byQuest = {},
  }

  return addon.db.global.questAlts
end

function QA:Record(questID, isCompleted)
  questID = tonumber(questID)
  if not questID then return end
  if isCompleted ~= true then return end

  local db = GetAccountDB()
  if not db then return end

  local byQuest = db.byQuest
  if type(byQuest) ~= "table" then
    byQuest = {}
    db.byQuest = byQuest
  end

  local charKey = GetCharacterKey()
  local bucket = byQuest[questID]
  if type(bucket) ~= "table" then
    bucket = {}
    byQuest[questID] = bucket
  end

  if not bucket[charKey] then
    bucket[charKey] = true
  end
end

local function GetBucket(questID)
  questID = tonumber(questID)
  if not questID then return nil end

  local db = GetAccountDB()
  if not db then return nil end
  local byQuest = db.byQuest
  if type(byQuest) ~= "table" then return nil end
  return byQuest[questID]
end

function QA:GetPreferredCharacter(questID)
  questID = tonumber(questID)
  if not questID then return nil end

  local bucket = GetBucket(questID)
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

function QA:GetAllCharacters(questID)
  local bucket = GetBucket(questID)
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

function QA:CurrentCharacterHas(questID)
  local bucket = GetBucket(questID)
  if type(bucket) ~= "table" then return false end
  local current = GetCharacterKey()
  return bucket[current] and true or false
end

function QA:AnyCharacterHas(questID)
  local bucket = GetBucket(questID)
  if type(bucket) ~= "table" then return false end
  
  for charKey, has in pairs(bucket) do
    if has then
      return true
    end
  end
  
  return false
end

function QA:GetAnyOtherCharacter(questID)
  questID = tonumber(questID)
  if not questID then return nil end

  local bucket = GetBucket(questID)
  if type(bucket) ~= "table" then return nil end

  local current = GetCharacterKey()
  for charKey, has in pairs(bucket) do
    if has and charKey ~= current then
      return charKey
    end
  end

  return nil
end

function QA:IsQuestComplete(questID)
  questID = tonumber(questID)
  if not questID then return false end
  
  if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
    return C_QuestLog.IsQuestFlaggedCompleted(questID)
  end
  
  return false
end

local scanJob = nil

local function BuildScanList()
  local DI = NS.Systems and NS.Systems.DecorIndex
  if not DI then return {} end

  local list = {}
  local seen = {}

  for decorID, entry in pairs(DI) do
    if type(entry) == "table" then
      local it = entry.item
      local req = it and it.requirements
      if type(req) == "table" then
        local quest = req.quest
        if type(quest) == "table" and quest.id then
          local qid = tonumber(quest.id)
          if qid and not seen[qid] then
            seen[qid] = true
            list[#list + 1] = qid
          end
        end
      end
    end
  end

  return list
end

local function ScanChunk()
  if not scanJob or not scanJob.running then return end

  if not C_QuestLog or not C_QuestLog.IsQuestFlaggedCompleted then
    scanJob.running = false
    return
  end

  local perTick = 20
  local i = 0

  while i < perTick and scanJob.index <= scanJob.count do
    local questID = scanJob.list[scanJob.index]
    scanJob.index = scanJob.index + 1
    i = i + 1

    if questID then
      local ok, isComplete = pcall(C_QuestLog.IsQuestFlaggedCompleted, questID)
      if ok and isComplete then
        QA:Record(questID, true)
      end
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

function QA:WarmupCurrentCharacter()
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
f:RegisterEvent("QUEST_TURNED_IN")
f:SetScript("OnEvent", function(self, event, ...)
  if event == "PLAYER_ENTERING_WORLD" then
    if QA and QA.WarmupCurrentCharacter then
      if C_Timer and C_Timer.After then
        C_Timer.After(3.0, function() QA:WarmupCurrentCharacter() end)
      else
        QA:WarmupCurrentCharacter()
      end
    end
  elseif event == "QUEST_TURNED_IN" then
    local questID = ...
    if questID and QA and QA.Record then
      QA:Record(questID, true)
    end
  end
end)

return QA