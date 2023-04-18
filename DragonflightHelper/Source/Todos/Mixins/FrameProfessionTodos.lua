local KnowledgeCurrencies = DFH_Constants.KnowledgeCurrencies
local ProfessionQuests = DFH_Constants.ProfessionQuests

DFH_ProfessionContainerMixin = CreateFromMixins(DFH_TodoEventHandler, DFH_ProfessionLoader)

function DFH_ProfessionContainerMixin:OnLoad()
  if self.professionIndex == nil then
    DFH_Utilities.error("[DEBUG]", "Unable to create profession container; no profession index provided")
  end

  self.professionChildren = {
    self.Treatise, self.Gathering, self.WeeklyDrops, self.OpenWorldKnowledgeTreasures,
    self.WeeklyServices, self.ValdrakkenTrainers, self.WeeklyProfession, self.ProfessionMasters
  }

  for _, child in ipairs(self.professionChildren) do
    child.professionIndex = self.professionIndex
    child:AfterLayout(function()
      self:Update()
    end)
  end

  self.weeklyClickInitialized = false
  self.professionMasterClickInitialized = false
  self.knowledgeTreasuresClickInitialized = false
  self.firstCraftCounts = {}

  self:LoadProfessions()
end

function DFH_ProfessionContainerMixin:Update()
  if not self:hasProfession(self.professionIndex) then
    self.Title:SetTitle("Profession " .. self.professionIndex .. " not selected")
    return
  end

  self.profession = self.professionInfo[self.professionIndex]

  if not self.Treatise.initialized then
    self.Treatise:Init(self.profession)
  end

  if not self.weeklyClickInitialized then
    self.weeklyClickInitialized = true
    self.WeeklyDrops:SetClickCallback(function()
      self:WeeklyDropClick()
    end)
  end

  if not self.professionMasterClickInitialized then
    self.professionMasterClickInitialized = true
    self.ProfessionMasters:SetClickCallback(function()
      self:ProfessionMasterClick()
    end)
  end

  if not self.knowledgeTreasuresClickInitialized then
    self.knowledgeTreasuresClickInitialized = true
    self.OpenWorldKnowledgeTreasures:SetClickCallback(function()
      self:KnowledgeTreasureClick()
    end)
  end

  local frameHeight = self.Title:GetHeight()

  for _, child in ipairs(self.professionChildren) do
    if not child.collapsed then
      frameHeight = frameHeight + child:GetHeight()
    end
  end

  self.Title:SetTitle(self:getTitle())
  self:SetHeight(frameHeight)
end

function DFH_ProfessionContainerMixin:skillIsLevel25()
  -- TODO could add some messaging or hide/show based on availability
  return self.profession.skillLevel >= 25
end

function DFH_ProfessionContainerMixin:getTitle()
  -- local firstCraftDisplay = " [?]"
  local unspentPointDisplay = " (0)"

  -- if self.tradeSkillShowing then
  --   local profession = C_TradeSkillUI.GetChildProfessionInfos()[1]

  --   for _, recipeId in ipairs(C_TradeSkillUI.GetFilteredRecipeIDs()) do
  --     local recipe = C_TradeSkillUI.GetRecipeInfo(recipeId)
  --     self.firstCraftCounts[self.profession.skillId] = 0

  --     if C_TradeSkillUI.IsRecipeInSkillLine(recipeId, profession.professionID) and recipe.learned and recipe.firstCraft then
  --       self.firstCraftCounts[self.profession.skillId] = self.firstCraftCounts[self.profession.skillId] + 1
  --     end
  --   end

  --   firstCraftDisplay = " [" .. self.firstCraftCounts[self.profession.skillId] .. "]"
  -- end

  if KnowledgeCurrencies[self.profession.skillId] ~= nil then
    local unspentPoints = C_CurrencyInfo.GetCurrencyInfo(KnowledgeCurrencies[self.profession.skillId]).quantity

    if unspentPoints > 0 then
      unspentPointDisplay = " (" .. unspentPoints .. ")"
    end
  end

  return self.profession.name .. unspentPointDisplay
end

function DFH_ProfessionContainerMixin:WeeklyDropClick()
  if TomTom == nil then
    DFH_Utilities.error("TomTom required to use this functionality")
  end

  local skillEntry = ProfessionQuests.WeeklyDrops[self.profession.skillId]

  for i, entry in ipairs(skillEntry) do
    if not C_QuestLog.IsQuestFlaggedCompleted(entry.questId) then
      TomTom:AddWaypoint(entry.waypoint.map, entry.waypoint.x, entry.waypoint.y, entry.waypoint.options)
    end
  end
end

function DFH_ProfessionContainerMixin:ProfessionMasterClick()
  if TomTom == nil then
    DFH_Utilities.error("TomTom required to use this functionality")
  end

  local waypoint = ProfessionQuests.ProfessionMasters[self.profession.skillId][1].waypoint

  TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
end

function DFH_ProfessionContainerMixin:KnowledgeTreasureClick()
  if TomTom == nil then
    DFH_Utilities.error("TomTom required to use this functionality")
  end

  local entries = ProfessionQuests.OpenWorldKnowledgeTreasures[self.profession.skillId]

  for _, entry in ipairs(entries) do
    -- if entry.questId ~= 0 and not C_QuestLog.IsQuestFlaggedCompleted(entry.questId) then
    if not C_QuestLog.IsQuestFlaggedCompleted(entry.questId) then
      TomTom:AddWaypoint(entry.waypoint.map, entry.waypoint.x, entry.waypoint.y, entry.waypoint.options)
    end
  end
end
