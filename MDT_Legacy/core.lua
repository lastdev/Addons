---@class MDT_Legacy
local addon = select(2, ...)
local MDT = MDT

if not addon:GenericVersionCheck("MythicDungeonTools", "5.6.0") then
  return
end

function addon:OnInitialize()
  local L = MDT.L
  if addon:IsRetail() then
    tinsert(MDT.seasonList, L["The War Within Season 3"])
    tinsert(MDT.dungeonSelectionToIndex, { 123, 30, 37, 38, 113, 111, 115, 119 })
    tinsert(MDT.seasonList, L["The War Within Season 2"])
    tinsert(MDT.dungeonSelectionToIndex, { 115, 116, 117, 118, 119, 120, 121, 122 })
    tinsert(MDT.seasonList, L["The War Within Season 1"])
    tinsert(MDT.dungeonSelectionToIndex, { 31, 35, 19, 110, 111, 112, 113, 114 })
    tinsert(MDT.seasonList, L["Dragonflight Season 4"])
    tinsert(MDT.dungeonSelectionToIndex, { 45, 44, 48, 49, 43, 50, 42, 51 })
    tinsert(MDT.seasonList, L["Dragonflight Season 3"])
    tinsert(MDT.dungeonSelectionToIndex, { 15, 103, 104, 4, 100, 101, 105, 102 })
    tinsert(MDT.seasonList, L["Dragonflight Season 2"])
    tinsert(MDT.dungeonSelectionToIndex, { 48, 49, 16, 50, 8, 22, 51, 77 })
    tinsert(MDT.seasonList, L["Dragonflight Season 1"])
    tinsert(MDT.dungeonSelectionToIndex, { 45, 44, 3, 6, 47, 43, 42, 46 })
    tinsert(MDT.seasonList, L["Shadowlands Season 4"])
    tinsert(MDT.dungeonSelectionToIndex, { 40, 38, 25, 122, 41, 9, 10, 37 })
    tinsert(MDT.seasonList, L["Shadowlands"])
    tinsert(MDT.dungeonSelectionToIndex, { 29, 38, 30, 35, 31, 32, 33, 34, 37, 121 })
    tinsert(MDT.seasonList, L["BFA"])
    tinsert(MDT.dungeonSelectionToIndex, { 15, 16, 17, 120, 18, 19, 20, 23, 22, 102, 25, 122 })
    tinsert(MDT.seasonList, L["Legion"])
    tinsert(MDT.dungeonSelectionToIndex, { 12, 103, 2, 3, 4, 5, 6, 9, 7, 8, 11, 10, 13 })
  end
end

MDT:RegisterModule("MDT Legacy", addon)
