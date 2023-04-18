DFH_TodoUpdate = CreateFromMixins(DFH_GenericUpdate)

local WeeklyQuests = {
  ["Aiding the Accord"] = {
    completionCount = 1,
    { questId = 70750 }, { questId = 72068 }, { questId = 72374 }, { questId = 72373 }, { questId = 72375 },
  },
  ["Revival Catalyst"] = { { questId = 72528 } },
  ["Iskaara Tuskarr Feast"] = { { questId = 70893 } },
  ["Siege on Dragonbane Keep"] = {
    title = "Siege on Dragonbane Keep",
    { questId = 70866 } },
  ["Grand Hunts"] = {
    title = "Grand Hunts",
    { questId = 70906 }, { questId = 71136 }, { questId = 71137 } },
  ["Trial of Flood"] = {
    title = "Trial of Flood - Raging Torrent",
    { questId = 71033 } },
  ["Trial of Elements"] = {
    title = "Trial of Elements - Therrocite",
    { questId = 71995 } },
  ["World Bosses"] = {
    title = "World Bosses", completionCount = 1,
    { questId = 69927 }, { questId = 69928 }, { questId = 69929 }, { questId = 69930 } }
}

function DFH_TodoUpdate:Update()
  if self.weeklyIndex == nil then
    DFH_Utilities.error("[INCORRECT USAGE]", "DFH_TodoUpdate: A weeklyIndex must be provided")
    self:SetTitle("Unknown weekly")
    self:SetForegroundColor(0, 0, 0, 0)
    return
  end

  local entries = WeeklyQuests[self.weeklyIndex]

  if entries == nil then
    self:SetTitle("No entries found for " .. self.weeklyIndex)
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(0, 0, 0, 0)
    return
  end

  DFH_GenericUpdate.update(self, entries)
end
