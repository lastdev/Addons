DFH_ProfessionLoader = {}

function DFH_ProfessionLoader:LoadProfessions()
  if self.professionsInitialized then
    -- already loaded; singleton would be nice here
    return
  end
  -- I tried watching the PLAYER_ALIVE event but it wasnt working,
  -- so fuck it:
  self.ticker = C_Timer.NewTicker(1, function()
    self:CheckForProfessions()
  end)
end

function DFH_ProfessionLoader:CheckForProfessions()
  local firstProfession, secondProfession = GetProfessions()

  if firstProfession ~= nil or secondProfession ~= nil then
    self.ticker:Cancel()
    self:InitializeProfessions()
  else
    return
  end
end

function DFH_ProfessionLoader:InitializeProfessions()
  if self.Update == nil then
    DFH_Utilities.error("[DEBUG]", "DFH_ProfessionLoader: No Update method found for this entry")
    return
  end

  local firstProfession, secondProfession = GetProfessions()

  self.professionInfo = {}
  self:initializeProfession(firstProfession, 1)
  self:initializeProfession(secondProfession, 2)

  self:Update()
end

function DFH_ProfessionLoader:initializeProfession(professionIdentifier, index)
  if professionIdentifier == nil then
    self.professionInfo[index] = {
      name = "No profession " .. index,
      initialized = true,
      skillId = 0,
      rank = 0
    }

    return
  end

  local name, texture, rank, maxRank, numSpells, spellOffset, skillLine, rankModifier, specializationIndex, specializationOffset, skillLineName =
      GetProfessionInfo(professionIdentifier);

  self.professionInfo[index] = {
    name = name,
    initialized = true,
    skillId = skillLine,
    skillLevel = rank,
  }
end

function DFH_ProfessionLoader:hasProfession(professionIndex)
  return self.professionInfo ~= nil and self.professionInfo[professionIndex] ~= nil and
      self.professionInfo[professionIndex].initialized
end

function DFH_ProfessionLoader:getName(professionIndex)
  if self.professionInfo == nil or self.professionInfo[professionIndex] == nil or not
      self.professionInfo[professionIndex].initialized then
    return ""
  end

  return self.professionInfo[professionIndex].name
end

function DFH_ProfessionLoader:getId(professionIndex)
  if self.professionInfo == nil or self.professionInfo[professionIndex] == nil or not
      self.professionInfo[professionIndex].skillId then
    return nil
  end

  return self.professionInfo[professionIndex].skillId
end
