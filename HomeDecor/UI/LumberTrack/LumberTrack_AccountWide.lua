local ADDON, NS = ...
NS.UI = NS.UI or {}

local AW = {}
NS.UI.LumberTrackAccountWide = AW

local warbandDataLoaded = false

function AW:SetWarbandDataLoaded()
  warbandDataLoaded = true
end

local function GetCharacterKey()
  local name = UnitName("player") or "Unknown"
  local realm = GetRealmName() or "Unknown"
  return name .. " - " .. realm
end

local function GetAccountDB()
  local addon = NS.Addon
  if not addon or not addon.db then return nil end

  if not addon.db.global then
    addon.db.global = {}
  end
  
  if not addon.db.global.lumberTrackAccount then
    addon.db.global.lumberTrackAccount = {
      characterData = {},
      accountWide = false,
    }
  end
  
  return addon.db.global.lumberTrackAccount
end

function AW:GetCharacterKey()
  return GetCharacterKey()
end

function AW:IsEnabled()
  local db = GetAccountDB()
  return db and db.accountWide or false
end

function AW:SetEnabled(enabled)
  local db = GetAccountDB()
  if db then
    db.accountWide = enabled and true or false
  end
end

function AW:SaveCharacterLumber(counts)
  if not counts then return end

  local db = GetAccountDB()
  if not db then return end

  local charKey = GetCharacterKey()
  if not db.characterData[charKey] then
    db.characterData[charKey] = {}
  end

  for itemID, count in pairs(counts) do
    db.characterData[charKey][itemID] = tonumber(count) or 0
  end

  for itemID, count in pairs(db.characterData[charKey]) do
    if count <= 0 then
      db.characterData[charKey][itemID] = nil
    end
  end
end

function AW:SaveCharacterBankLumber(lumberIDs)
  if not lumberIDs or not C_Item or not C_Item.GetItemCount then return end

  local db = GetAccountDB()
  if not db then return end

  if not db.bankData then db.bankData = {} end

  local charKey = GetCharacterKey()
  if not db.bankData[charKey] then
    db.bankData[charKey] = {}
  end

  for itemID in pairs(lumberIDs) do
    local bagsOnly    = C_Item.GetItemCount(itemID, false, false, false, false) or 0
    local withBank    = C_Item.GetItemCount(itemID, true,  false, true,  false) or 0
    local bankAmt     = withBank - bagsOnly
    if bankAmt > 0 then
      db.bankData[charKey][itemID] = bankAmt
    else
      db.bankData[charKey][itemID] = nil
    end
  end

  for itemID in pairs(db.bankData[charKey]) do
    if not lumberIDs[itemID] then
      db.bankData[charKey][itemID] = nil
    end
  end
end

function AW:GetWarbandCountForItem(itemID)
  if not itemID then return 0 end
  local live = 0
  if C_Item and C_Item.GetItemCount then
    local totalWithWarband    = C_Item.GetItemCount(itemID, true, false, true, true)  or 0
    local totalWithoutWarband = C_Item.GetItemCount(itemID, true, false, true, false) or 0
    live = totalWithWarband - totalWithoutWarband
    if live < 0 then live = 0 end
  end
  if live > 0 then
    return live
  end
  if warbandDataLoaded then
    return 0
  end
  local db = GetAccountDB()
  local saved = db and db.warbandCounts and (tonumber(db.warbandCounts[itemID]) or 0) or 0
  return saved
end

function AW:ScanWarbandBank(lumberIDs)
  local counts = {}
  local db = GetAccountDB()

  local allIDs = {}
  for itemID in pairs(lumberIDs or {}) do
    allIDs[itemID] = true
  end
  for _, charCounts in pairs(db and db.characterData or {}) do
    for itemID in pairs(charCounts) do allIDs[itemID] = true end
  end
  for _, bankCounts in pairs(db and db.bankData or {}) do
    for itemID in pairs(bankCounts) do allIDs[itemID] = true end
  end

  for itemID in pairs(allIDs) do
    local amt = self:GetWarbandCountForItem(itemID)
    if amt > 0 then
      counts[itemID] = amt
    end
  end
  return counts
end

function AW:GetWarbandCounts()
  local db = GetAccountDB()
  if not db then return {} end
  return db.warbandCounts or {}
end

function AW:SaveWarbandCounts(counts)
  local db = GetAccountDB()
  if not db then return end
  db.warbandCounts = counts or {}
end

function AW:GetAggregatedCounts()
  local db = GetAccountDB()
  if not db or not self:IsEnabled() then return nil end

  local aggregated = {}

  for charKey, charCounts in pairs(db.characterData or {}) do
    for itemID, count in pairs(charCounts) do
      aggregated[itemID] = (aggregated[itemID] or 0) + (tonumber(count) or 0)
    end
  end

  for charKey, bankCounts in pairs(db.bankData or {}) do
    for itemID, count in pairs(bankCounts) do
      aggregated[itemID] = (aggregated[itemID] or 0) + (tonumber(count) or 0)
    end
  end

  if C_Item and C_Item.GetItemCount then
    local allIDs = {}
    for itemID in pairs(aggregated) do allIDs[itemID] = true end
    for _, bankCounts in pairs(db.bankData or {}) do
      for itemID in pairs(bankCounts) do allIDs[itemID] = true end
    end
    for itemID in pairs(db.warbandCounts or {}) do allIDs[itemID] = true end
    for itemID in pairs(allIDs) do
      local amt = self:GetWarbandCountForItem(itemID)
      if amt > 0 then
        aggregated[itemID] = (aggregated[itemID] or 0) + amt
      end
    end
  end

  return aggregated
end

function AW:GetTotalCount(counts)
  if not self:IsEnabled() then
    local total = 0
    for id, count in pairs(counts or {}) do
      total = total + (tonumber(count) or 0)
    end
    return total
  end

  local aggregated = self:GetAggregatedCounts()
  if not aggregated then return 0 end

  local total = 0
  for id, count in pairs(aggregated) do
    total = total + (tonumber(count) or 0)
  end
  return total
end

function AW:GetCharacterBreakdown(itemID)
  local db = GetAccountDB()
  if not db or not itemID then return {} end

  local breakdown = {}

  for charKey, charCounts in pairs(db.characterData or {}) do
    local count = tonumber(charCounts[itemID]) or 0
    if count > 0 then
      breakdown[#breakdown + 1] = {
        label = charKey,
        count = count,
        sort  = 1,
      }
    end
  end

  for charKey, bankCounts in pairs(db.bankData or {}) do
    local count = tonumber(bankCounts[itemID]) or 0
    if count > 0 then
      breakdown[#breakdown + 1] = {
        label = charKey .. " (Bank)",
        count = count,
        sort  = 2,
      }
    end
  end

  local warbandAmt = self:GetWarbandCountForItem(itemID)
  if warbandAmt > 0 then
    breakdown[#breakdown + 1] = {
      label    = "Warband Bank",
      count    = warbandAmt,
      sort     = 3,
      warband  = true,
    }
  end

  table.sort(breakdown, function(a, b)
    if a.sort ~= b.sort then return a.sort < b.sort end
    if a.count ~= b.count then return a.count > b.count end
    return a.label < b.label
  end)

  return breakdown
end

function AW:GetCurrentCharacterCount(itemID)
  local db = GetAccountDB()
  if not db or not itemID then return 0 end
  
  local charKey = GetCharacterKey()
  local charData = db.characterData[charKey]
  
  if not charData then return 0 end
  return tonumber(charData[itemID]) or 0
end

function AW:CleanupOldData(maxCharacters)
  maxCharacters = maxCharacters or 50
  local db = GetAccountDB()
  if not db then return end
  
  local charCount = 0
  for k in pairs(db.characterData or {}) do
    charCount = charCount + 1
  end

  if charCount <= maxCharacters then return end

  local currentKey = GetCharacterKey()
  local toRemove = {}

  for charKey in pairs(db.characterData) do
    if charKey ~= currentKey then
      toRemove[#toRemove + 1] = charKey
    end
  end

  local removeCount = charCount - maxCharacters
  for i = 1, math.min(removeCount, #toRemove) do
    db.characterData[toRemove[i]] = nil
  end
end

return AW
