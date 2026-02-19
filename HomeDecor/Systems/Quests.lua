local _, NS = ...

NS.Systems = NS.Systems or {}
NS.Systems.Quests = NS.Systems.Quests or {}
local Q = NS.Systems.Quests

local tonumber, tostring, type, pcall = tonumber, tostring, type, pcall
local C_QuestLog = C_QuestLog

local function recordQuestAlt(questID, isComplete)
  local QuestsAlts = NS.Systems and NS.Systems.QuestsAlts
  if not QuestsAlts or not QuestsAlts.Record then return end
  if not questID or isComplete ~= true then return end
  pcall(QuestsAlts.Record, QuestsAlts, questID, true)
end

function Q.GetRequirement(it)
  if not it then return nil end

  local req = it.requirements
  if not req then
    local DI = NS.Systems and NS.Systems.DecorIndex
    if DI and it.decorID then
      local e = DI[it.decorID]
      local item = e and e.item
      req = item and item.requirements or nil
    end
  end
  if not req then return nil end

  local quest = req.quest
  if not quest then return nil end

  if type(quest) == "table" then
    local questID = tonumber(quest.id)
    if not questID then
      return { text = "Quest required", questID = nil, met = false }
    end

    local isComplete = false
    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
      local ok, result = pcall(C_QuestLog.IsQuestFlaggedCompleted, questID)
      if ok then
        isComplete = result
      end
    end

    if isComplete then
      recordQuestAlt(questID, true)
    end

    local questName = quest.name or quest.title
    if not questName and C_QuestLog and C_QuestLog.GetQuestInfo then
      local ok, info = pcall(C_QuestLog.GetQuestInfo, questID)
      if ok and info then
        questName = info.title or info.name
      end
    end

    local displayText
    if questName then
      displayText = questName
    else
      displayText = "Quest #" .. tostring(questID)
    end

    return {
      text = displayText,
      questID = questID,
      met = isComplete
    }
  end

  if type(quest) == "number" then
    local questID = tonumber(quest)
    if not questID then
      return { text = "Quest required", questID = nil, met = false }
    end

    local isComplete = false
    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
      local ok, result = pcall(C_QuestLog.IsQuestFlaggedCompleted, questID)
      if ok then
        isComplete = result
      end
    end

    if isComplete then
      recordQuestAlt(questID, true)
    end

    return {
      text = "Quest #" .. tostring(questID),
      questID = questID,
      met = isComplete
    }
  end

  if type(quest) == "string" then
    return { text = quest, questID = nil, met = false }
  end

  return { text = "Quest required", questID = nil, met = false }
end

function Q.IsQuestComplete(questID)
  questID = tonumber(questID)
  if not questID then return false end
  
  if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
    local ok, result = pcall(C_QuestLog.IsQuestFlaggedCompleted, questID)
    return ok and result or false
  end
  
  return false
end

function Q.GetQuestInfo(questID)
  questID = tonumber(questID)
  if not questID then return nil end
  
  if C_QuestLog and C_QuestLog.GetQuestInfo then
    local ok, info = pcall(C_QuestLog.GetQuestInfo, questID)
    if ok and info then
      return info
    end
  end
  
  return nil
end

return Q