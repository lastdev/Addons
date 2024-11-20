---@class MDT_Legacy
local addon = select(2, ...)
local MDT = MDT

if not addon:GenericVersionCheck("MythicDungeonTools", "5.1.0") then
  return
end

function addon:OnInitialize()
  local L = MDT.L

  tinsert(MDT.seasonList, L["Legion"])
  tinsert(MDT.dungeonSelectionToIndex, { 103, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 })
  tinsert(MDT.seasonList, L["BFA"])
  tinsert(MDT.dungeonSelectionToIndex, { 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 })
  tinsert(MDT.seasonList, L["Shadowlands"])
  tinsert(MDT.dungeonSelectionToIndex, { 29, 30, 31, 32, 33, 34, 35, 36, 37, 38 })
  tinsert(MDT.seasonList, L["Shadowlands Season 4"])
  tinsert(MDT.dungeonSelectionToIndex, { 40, 41, 37, 38, 25, 26, 9, 10 })
  tinsert(MDT.seasonList, L["Dragonflight Season 1"])
  tinsert(MDT.dungeonSelectionToIndex, { 42, 43, 44, 45, 6, 3, 46, 47 })
  tinsert(MDT.seasonList, L["Dragonflight Season 2"])
  tinsert(MDT.dungeonSelectionToIndex, { 49, 48, 51, 50, 8, 16, 22, 77 })
  tinsert(MDT.seasonList, L["Dragonflight Season 3"])
  tinsert(MDT.dungeonSelectionToIndex, { 100, 101, 102, 103, 15, 104, 4, 105 })
  tinsert(MDT.seasonList, L["Dragonflight Season 4"])
  tinsert(MDT.dungeonSelectionToIndex, { 42, 43, 44, 45, 49, 48, 51, 50 })
end

MDT:RegisterModule("MDT Legacy", addon)
