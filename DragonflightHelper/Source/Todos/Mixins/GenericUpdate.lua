DFH_GenericUpdate = {}

function DFH_GenericUpdate:update(entries, optionalTitle)
  local completed = 0
  local completionCount = entries.completionCount
  local isOnQuest = false
  local onQuestId = 0

  if completionCount == nil then
    completionCount = #entries
  end

  for _, entry in ipairs(entries) do
    if C_QuestLog.IsOnQuest(entry.questId) then
      isOnQuest = true
      onQuestId = entry.questId
    end

    if C_QuestLog.IsQuestFlaggedCompleted(entry.questId) then
      completed = completed + 1
    end
  end

  -- it seems like completing any Aiding the Accord quest marks all Aiding the Accord quests as completed?
  if completed > (completionCount or #entries) then
    completed = completionCount
  end

  self:SetMinMaxValues(0, completionCount)

  if isOnQuest then
    local onQuestColor = FACTION_BAR_COLORS[4]
    self:SetBackgroundColor(onQuestColor.r, onQuestColor.g, onQuestColor.b, 0.2)

    self:SetEnterCallback(function()
      self:ShowQuestTooltip(onQuestId)
    end)
    self:SetLeaveCallback(function()
      GameTooltip:Hide()
    end)
  end

  if entries.title ~= nil then
    self:SetTitle(entries.title)
  elseif optionalTitle ~= nil then
    self:SetTitle(optionalTitle)
  else
    self:SetTitle(C_QuestLog.GetTitleForQuestID(entries[1].questId))
  end

  self:SetDescription(completed .. " / " .. completionCount)
  self:SetValue(completed)
end

function DFH_GenericUpdate:ShowQuestTooltip(questId)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT");

  local title = C_TaskQuest.GetQuestInfoByQuestID(questId)
  local objectives = C_QuestLog.GetQuestObjectives(questId)

  GameTooltip_SetTitle(GameTooltip, "You are on this quest", HIGHLIGHT_FONT_COLOR)
  GameTooltip_AddBlankLineToTooltip(GameTooltip)

  GameTooltip_AddHighlightLine(GameTooltip, title)

  for _, objective in ipairs(objectives) do
    GameTooltip_AddNormalLine(GameTooltip, objective.text)
  end

  GameTooltip:Show()
end
