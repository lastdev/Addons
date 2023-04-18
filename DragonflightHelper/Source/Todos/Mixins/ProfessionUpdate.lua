local ProfessionQuests = DFH_Constants.ProfessionQuests

DFH_TreatiseUpdater = {}

function DFH_TreatiseUpdater:Init(profession)
  self.initialized = true
  self.profession = profession
  self.collapsed = false

  if self.profession == nil or self.profession.skillId == nil then
    self.completed = true
    return
  else
    self.completed = false
    self.treatiseQuestId = ProfessionQuests.Treatise[self.profession.skillId][1].questId

    if C_QuestLog.IsQuestFlaggedCompleted(self.treatiseQuestId) then
      self.completed = true
    end
  end

  if not self.completed then
    self.timer = C_Timer.NewTicker(3, function() self:Check() end)
  end
end

function DFH_TreatiseUpdater:Check()
  self.completed = C_QuestLog.IsQuestFlaggedCompleted(self.treatiseQuestId)

  if self.completed then
    self.timer:Cancel()
    self:Update()
  end
end

DFH_ProfessionUpdate = CreateFromMixins(DFH_GenericUpdate)

function DFH_ProfessionUpdate:AfterLayout(fn)
  self.afterLayout = fn
end

function DFH_ProfessionUpdate:CollapseFrame()
  self:Hide()
  self:SetHeight(1)

  -- This should be "TOPLEFT"
  local point, relativeTo, relativePoint = self:GetPoint()
  self:SetPoint(point, relativeTo, relativePoint, 0, 1)
  self.collapsed = true

  if self.afterLayout ~= nil then
    self.afterLayout()
  end
end

function DFH_ProfessionUpdate:Update()
  if self.professionIndex == nil then
    DFH_Utilities.error("[INCORRECT USAGE]", "DFH_ProfessionUpdate: A professionIndex must be provided")
    self:SetTitle("Unknown profession")
    return
  end

  if not self:hasProfession(self.professionIndex) then
    self:SetTitle("No profession selected")
    return
  end

  if self.questTypeKey == nil then
    DFH_Utilities.error("[INCORRECT USAGE]",
      "DFH_ProfessionUpdate: A questTypeKey object must be initialized")
    self:SetForegroundColor(0, 0, 0, 0)
    return
  end

  if self:CheckForCollapsedFrames() then
    return
  end

  local questTypeEntry = ProfessionQuests[self.questTypeKey]
  local entry = questTypeEntry[self:getId(self.professionIndex)]

  if entry ~= nil then
    self.items = {}

    for _, questEntry in ipairs(entry) do
      if questEntry.item ~= nil then
        tinsert(self.items, questEntry.item)
      end
    end

    if #self.items > 0 then
      self:SetEnterCallback(function()
        self:ShowItemsTooltip(entry, questTypeEntry)
      end)

      self:SetLeaveCallback(function()
        GameTooltip:Hide()
      end)
    end
  end

  DFH_GenericUpdate.update(self, entry, questTypeEntry.title)
end

function DFH_ProfessionUpdate:CheckForCollapsedFrames()
  -- This really needs to be moved out so I can just turn off these checks
  -- for one time knowledge point items per toon once they are all completed
  -- Until that day:
  if ProfessionQuests[self.questTypeKey] == nil then
    self:CollapseFrame()
    return true
  end

  if ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)] == nil then
    self:CollapseFrame()
    return true
  end

  if self.questTypeKey == "ProfessionMasters" and C_QuestLog.IsQuestFlaggedCompleted(ProfessionQuests.ProfessionMasters[self:getId(self.professionIndex)][1].questId) then
    self:CollapseFrame()
    return true
  end

  if self.questTypeKey == "OpenWorldKnowledgeTreasures" and ProfessionQuests.OpenWorldKnowledgeTreasures[self:getId(self.professionIndex)] ~= nil then
    local completed = 0
    local quests = ProfessionQuests.OpenWorldKnowledgeTreasures[self:getId(self.professionIndex)]

    for _, entry in ipairs(quests) do
      if C_QuestLog.IsQuestFlaggedCompleted(entry.questId) then
        completed = completed + 1
      end
    end

    if completed == #quests then
      self:CollapseFrame()
      return true
    end
  end

  return false
end

function DFH_ProfessionUpdate:ShowItemsTooltip(entry, questTypeEntry)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

  GameTooltip_SetTitle(GameTooltip,
    (questTypeEntry.title or entry.title or "") .. " (" .. self:getName(self.professionIndex) .. ")",
    HIGHLIGHT_FONT_COLOR)

  if self.questTypeKey == "WeeklyDrops" then
    GameTooltip_AddNormalLine(GameTooltip, "Click for TomTom waypoint")
  end

  GameTooltip_AddBlankLineToTooltip(GameTooltip)

  if entry.description ~= nil then
    GameTooltip_AddHighlightLine(
      GameTooltip,
      questTypeEntry.description
    )
    GameTooltip_AddBlankLineToTooltip(GameTooltip)
  end

  local completed = 0

  for index, questEntry in ipairs(entry) do
    if not C_QuestLog.IsQuestFlaggedCompleted(questEntry.questId) then
      local item = Item:CreateFromItemID(questEntry.item)

      item:ContinueOnItemLoad(function()
        local itemName = item:GetItemName();

        GameTooltip:AddLine(
          CreateSimpleTextureMarkup(item:GetItemIcon(), 25, 25) .. "  " .. itemName
        )
      end)
    else
      completed = completed + 1
    end
  end

  if completed == #entry then
    GameTooltip_AddHighlightLine(GameTooltip, "All items found this week")
  end

  GameTooltip:Show()
end
