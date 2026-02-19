local ADDON, NS = ...

NS.UI = NS.UI or {}
NS.UI.Tooltips = NS.UI.Tooltips or {}
local TT = NS.UI.Tooltips

local tonumber, tostring, type, pairs, ipairs = tonumber, tostring, type, pairs, ipairs
local pcall = pcall

local function canAccess(v)
  if v == nil then return false end
  if issecretvalue and issecretvalue(v) then return false end
  if canaccessvalue and not canaccessvalue(v) then return false end
  return true
end

local function own(frame)
  GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
  GameTooltip:ClearLines()
end

local function hide()
  GameTooltip:Hide()
end

local function label(text)
  if text then GameTooltip:AddLine(text, 0.6, 0.8, 1) end
end

local function kv(k, v)
  if v and v ~= "" then
    GameTooltip:AddDoubleLine(k, tostring(v), 0.8, 0.8, 0.8, 0.8, 0.8, 0.8)
  end
end

local function actionLine(text)
  if text then GameTooltip:AddLine(text, 0.8, 0.8, 0.8) end
end

local function showItem(itemID)
  itemID = tonumber(itemID)
  if not itemID then return false end
  GameTooltip:SetHyperlink("item:" .. itemID)
  return true
end

local function showAchievement(id)
  id = tonumber(id)
  if not id or not GetAchievementLink then return false end
  local link = GetAchievementLink(id)
  if not link then return false end
  GameTooltip:SetHyperlink(link)
  return true
end

local function showQuest(id)
  id = tonumber(id)
  if not id then return false end
  GameTooltip:SetHyperlink("quest:" .. id)
  return true
end

local function showSpell(spellID)
  spellID = tonumber(spellID)
  if not spellID then return false end
  GameTooltip:SetSpellByID(spellID)
  return true
end

local function factionFor(data)
  local f = (data.source and data.source.faction) or data.faction
  if not f then return nil end
  if type(f) == "table" then
    local a, h = false, false
    for _, v in pairs(f) do
      if v == "Alliance" then a = true elseif v == "Horde" then h = true end
    end
    if a and h then return "Both" end
    if a then return "Alliance" end
    if h then return "Horde" end
    return nil
  end
  if f == "Alliance" or f == "Horde" or f == "Neutral" or f == "Both" then return f end
  return tostring(f)
end

local function vendorNameZone(data)
  if data._navVendor then
    return data._navVendor.title, data._navVendor.zone
  end
  local s = data.source or {}
  return s.vendor or s.vendorName or s.npc, s.zone or data.zone
end

local function dropNPCs(data)
  local out, seen = {}, {}
  local s = data.source or {}

  local ds = data._dropSources
  if type(ds) == "table" then
    for _, src in ipairs(ds) do
      local name = src and (src.npc or src.name)
      if name and not seen[name] then
        seen[name] = true
        out[#out + 1] = name
      end
    end
  end

  local mobSet = s.mobSet
  local mobSets = s._mobSets
  if mobSet and type(mobSets) == "table" and type(mobSets[mobSet]) == "table" then
    for _, mob in pairs(mobSets[mobSet]) do
      local name = mob and mob.name
      if name and not seen[name] then
        seen[name] = true
        out[#out + 1] = name
      end
    end
  end

  if type(s.mobs) == "table" then
    for _, mob in pairs(s.mobs) do
      local name = mob and mob.name
      if name and not seen[name] then
        seen[name] = true
        out[#out + 1] = name
      end
    end
  end

  if #out == 0 and s.npc then
    out[1] = s.npc
  end

  if #out == 0 then return nil end
  table.sort(out)
  return out
end

local function professionSpellID(data)
  local s = data.source or {}
  return tonumber(s.spellID) or tonumber(s.skillID) or tonumber(s.recipeID) or tonumber(s.id)
      or tonumber(data.spellID) or tonumber(data.skillID) or tonumber(data.recipeID) or tonumber(data.id)
end

local VENDOR_CLASS_LABEL = {
  [103693] = "Hunter",
  [105986] = "Rogue",
  [112318] = "Shaman",
  [112323] = "Druid",
  [93550] = "Death Knight",
  [100196] = "Paladin",
  [112338] = "Monk",
  [112392] = "Warrior",
  [112401] = "Priest",
  [112407] = "Demon Hunter",
  [112434] = "Warlock",
  [112440] = "Mage",
}

local CLASS_COLORS = {
  ["Death Knight"] = { r = 0.77, g = 0.12, b = 0.23 },
  ["Demon Hunter"] = { r = 0.64, g = 0.19, b = 0.79 },
  ["Druid"] = { r = 1.00, g = 0.49, b = 0.04 },
  ["Hunter"] = { r = 0.67, g = 0.83, b = 0.45 },
  ["Mage"] = { r = 0.25, g = 0.78, b = 0.92 },
  ["Monk"] = { r = 0.00, g = 1.00, b = 0.59 },
  ["Paladin"] = { r = 0.96, g = 0.55, b = 0.73 },
  ["Priest"] = { r = 1.00, g = 1.00, b = 1.00 },
  ["Rogue"] = { r = 1.00, g = 0.96, b = 0.41 },
  ["Shaman"] = { r = 0.00, g = 0.44, b = 0.87 },
  ["Warlock"] = { r = 0.53, g = 0.53, b = 0.93 },
  ["Warrior"] = { r = 0.78, g = 0.61, b = 0.43 },
}

local function GetClassLabel(data)
  if not data then return nil end
  local vid = data.npcID
  if not vid and data.source then vid = data.source.npcID or data.source.id end
  if not vid and data.vendor and data.vendor.source then vid = data.vendor.source.id end
  if not vid and data._navVendor and data._navVendor.source then vid = data._navVendor.source.id end
  vid = tonumber(vid)
  return vid and VENDOR_CLASS_LABEL[vid] or nil
end

local function IsDyeable(data)
  if not data then return false end
  
  local Util = NS.UI and NS.UI.Util
  if Util and Util.IsDyeable then
    return Util.IsDyeable(data)
  end
  
  local decorID = data.decorID or data.id or (data.source and (data.source.id or data.source.decorID))
  if not decorID then return false end
  
  local info
  if _G.C_HousingCatalog and _G.C_HousingCatalog.GetCatalogEntryInfo then
    local ok, res = pcall(_G.C_HousingCatalog.GetCatalogEntryInfo, decorID)
    if ok then info = res end
  end
  
  if type(info) == "table" then
    return (info.canCustomize == true) or (info.isCustomizable == true) or (info.customizable == true)
  elseif data.canCustomize ~= nil then
    return data.canCustomize == true
  elseif data.dyeable ~= nil then
    return data.dyeable == true
  end
  
  return false
end

local function addCommonKeys(data, includeVendor)
  local s = data.source or {}
  if includeVendor then
    local n, z = vendorNameZone(data)
    kv("Vendor", n)
    kv("Zone", z)
  else
    kv("Zone", s.zone or data.zone)
  end

  local faction = factionFor(data)
  if faction then
    local factionText = faction
    if faction == "Alliance" then
      factionText = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16:16|t " .. faction
    elseif faction == "Horde" then
      factionText = "|TInterface\\FriendsFrame\\PlusManz-Horde:16:16|t " .. faction
    elseif faction == "Both" then
      factionText = "|TInterface\\FriendsFrame\\PlusManz-Alliance:16:16|t |TInterface\\FriendsFrame\\PlusManz-Horde:16:16|t Both"
    end
    kv("Faction", factionText)
  end

  do
    local RepAlts = NS.Systems and NS.Systems.ReputationAlts
    local View = NS.UI and NS.UI.Viewer
    local Req = View and View.Requirements
    if RepAlts and RepAlts.GetAnyOtherCharacter and RepAlts.CurrentCharacterHas and Req and Req.GetRepRequirement then
      local repReq = Req.GetRepRequirement(data)
      if repReq and repReq.text then
        local hasOnCurrent = RepAlts:CurrentCharacterHas(repReq.text)
        if not hasOnCurrent then
          local who = RepAlts:GetAnyOtherCharacter(repReq.text)
          if who then
            GameTooltip:AddLine("|TInterface\\Icons\\Achievement_Reputation_01:16:16:0:0:64:64:4:60:4:60|t |cffffe000Rep alt:|r |cffffff80" .. tostring(who) .. "|r")
          end
        end
      end
    end
  end
  
  do
    local QuestsAlts = NS.Systems and NS.Systems.QuestsAlts
    local View = NS.UI and NS.UI.Viewer
    local Req = View and View.Requirements
    if QuestsAlts and QuestsAlts.GetAnyOtherCharacter and QuestsAlts.CurrentCharacterHas and Req and Req.GetQuestRequirement then
      local questReq = Req.GetQuestRequirement(data)
      if questReq and questReq.questID then
        local hasOnCurrent = QuestsAlts:CurrentCharacterHas(questReq.questID)
        if not hasOnCurrent then
          local who = QuestsAlts:GetAnyOtherCharacter(questReq.questID)
          if who then
            GameTooltip:AddLine("|TInterface\\Icons\\INV_Misc_Book_11:16:16:0:0:64:64:4:60:4:60|t |cffffe000Quest alt:|r |cffffff80" .. tostring(who) .. "|r")
          end
        end
      end
    end
  end
  
  local classLabel = GetClassLabel(data)
  if classLabel then
    local classColor = CLASS_COLORS[classLabel]
    if classColor then
      GameTooltip:AddDoubleLine("Requires", classLabel, 0.8, 0.8, 0.8, classColor.r, classColor.g, classColor.b)
    else
      kv("Requires", classLabel)
    end
  end
  
  if IsDyeable(data) then
    GameTooltip:AddLine("Dyeable", 0.4, 0.8, 1)
  end
end

local function questTitleWarn()
  local titleObj = _G.GameTooltipTextLeft1
  local qt = titleObj and titleObj.GetText and titleObj:GetText()
  if qt and qt:lower():find("decor treasure hunt", 1, true) then
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("There are many versions of the Decor Treasure Hunt quest.", 1, 0.2, 0.2, true)
    GameTooltip:AddLine("Use Ctrl+Click to open the correct WoWHead link.", 1, 0.2, 0.2, true)
  end
end

function TT:Attach(frame, data)
  if not frame or not data then return end
  frame:EnableMouse(true)
  frame._hdTTData = data

  if frame.__hdTTScripts then return end
  frame.__hdTTScripts = true

  frame:SetScript("OnEnter", function()
    local d = frame._hdTTData
    if not d then return end
    own(frame)

    local s = d.source or {}
    local t = s.type

    if d.type == "vendor" and d.items then
      GameTooltip:AddLine(d.title or "Vendor", 1, 1, 1)
      GameTooltip:AddLine(" ")
      actionLine("Left Click: Expand/Collapse")
      actionLine("Right Click: Vendor Location")
      actionLine("Alt + Click: Wowhead Link")
      kv("Zone", d.zone)
      kv("Faction", factionFor(d))
      GameTooltip:Show()
      return
    end

    if t == "vendor" then
      if showItem(d.id or s.itemID) then
        label("[Vendor Item]")
        GameTooltip:AddLine(" ")
        actionLine("Left Click: View Item")
        actionLine("Right Click: Vendor Location")
        
        local hasAchReq = false
        if d.requirements and d.requirements.achievement and d.requirements.achievement.id then
          hasAchReq = true
          actionLine("Ctrl + Click: View Achievement")
        end
        
        actionLine("Alt + Click: Wowhead Link")
        addCommonKeys(d, true)
        GameTooltip:Show()
        return
      end
    elseif t == "drop" then
      showItem(s.itemID or d.id)
      label("[Drop]")
      GameTooltip:AddLine(" ")
      actionLine("Left Click: View Item")

      if d.requirements and d.requirements.achievement and d.requirements.achievement.id then
        actionLine("Ctrl + Click: View Achievement")
      end
      
      actionLine("Alt + Click: Wowhead Link")

      local list = dropNPCs(d)
      if list then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Drops From:", 0.9, 0.9, 0.9)
        for _, n in ipairs(list) do
          GameTooltip:AddLine("* " .. n, 1, 0.82, 0)
        end
      end

      addCommonKeys(d, false)
      GameTooltip:Show()
      return
    elseif t == "pvp" then
      showItem(s.itemID or d.id)
      label("[PvP]")
      GameTooltip:AddLine(" ")
      actionLine("Left Click: View Item")
      actionLine("Right Click: Vendor Location")

      if d.requirements and d.requirements.achievement and d.requirements.achievement.id then
        actionLine("Ctrl + Click: View Achievement")
      end
      
      actionLine("Alt + Click: Wowhead Link")
      addCommonKeys(d, true)
      GameTooltip:Show()
      return
    elseif t == "profession" then
      local sid = professionSpellID(d)
      if showSpell(sid) then
        label("[Profession]")
        GameTooltip:AddLine(" ")
        actionLine("Left Click: View Item")

        if d.requirements and d.requirements.achievement and d.requirements.achievement.id then
          actionLine("Ctrl + Click: View Achievement")
        end
        
        actionLine("Alt + Click: Wowhead Link")
        kv("Faction", factionFor(d))
        GameTooltip:Show()
        return
      end
      if showItem(s.itemID or d.id or s.id) then
        label("[Profession]")
        GameTooltip:AddLine(" ")
        actionLine("Left Click: View Item")

        if d.requirements and d.requirements.achievement and d.requirements.achievement.id then
          actionLine("Ctrl + Click: View Achievement")
        end
        
        actionLine("Alt + Click: Wowhead Link")
        kv("Faction", factionFor(d))
        GameTooltip:Show()
        return
      end
    elseif t == "achievement" and s.id then
      if showAchievement(s.id) then
        label("[Achievement]")
        GameTooltip:AddLine(" ")
        actionLine("Left Click: View Item")
        actionLine("Right Click: Vendor Location")
        actionLine("Ctrl + Click: View Achievement")
        actionLine("Alt + Click: Wowhead Link")
        addCommonKeys(d, true)
        GameTooltip:Show()
        return
      end
    elseif t == "quest" and s.id then
      if showQuest(s.id) then
        label("[Quest]")
        GameTooltip:AddLine(" ")
        actionLine("Left Click: View Item")
        actionLine("Right Click: Vendor Location")
        actionLine("Alt + Click: Wowhead Link")
        questTitleWarn()
        addCommonKeys(d, true)
        GameTooltip:Show()
        return
      end
    end

    if d.title then GameTooltip:AddLine(d.title, 1, 1, 1) end
    addCommonKeys(d, false)
    GameTooltip:Show()
  end)

  frame:SetScript("OnLeave", hide)
end

function TT:ShowRequirement(owner, req)
  if not owner or not req then return end
  GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
  GameTooltip:ClearLines()

  if req.kind == "achievement" and req.id and showAchievement(req.id) then
    label("[Achievement]")
    GameTooltip:AddLine(" ")
    actionLine("Click: Wowhead Link")
    GameTooltip:Show()
    return
  end

  if req.kind == "quest" and req.id and showQuest(req.id) then
    label("[Quest]")
    GameTooltip:AddLine(" ")
    actionLine("Click: Wowhead Link")
    GameTooltip:Show()
  end
end

local function hasDecor(decorID)
  local C = NS.Systems and NS.Systems.Collection
  decorID = tonumber(decorID)
  if not C or not decorID then return false end

  local f = C.IsDecorCollected
  if type(f) == "function" then
    local ok, res = pcall(f, C, decorID)
    if ok then return res and true or false end
    ok, res = pcall(f, decorID)
    if ok then return res and true or false end
  end

  local g = C.IsCollected
  if type(g) == "function" then
    local ok, res = pcall(g, C, { decorID = decorID })
    if ok then return res and true or false end
    ok, res = pcall(g, { decorID = decorID })
    if ok then return res and true or false end
  end

  return false
end

local DecorNameCache = {}
local function decorName(decorID)
  decorID = tonumber(decorID)
  if not decorID then return nil end
  local cached = DecorNameCache[decorID]
  if cached ~= nil then return cached or nil end

  local HC = C_HousingCatalog
  if HC and HC.GetCatalogEntryInfoByRecordID then
    local ok, info = pcall(HC.GetCatalogEntryInfoByRecordID, 1, decorID, true)
    local n = ok and info and info.name
    if type(n) == "string" and n ~= "" then
      DecorNameCache[decorID] = n
      return n
    end
  end

  DecorNameCache[decorID] = false
  return nil
end

function TT.AppendNpcMouseover(tooltip, npcID)
  local DI = NS.Systems and NS.Systems.DecorIndex
  npcID = tonumber(npcID)
  if not DI or not npcID then return end
  local byNPC = DI.byNPC
  if type(byNPC) ~= "table" then return end
  local list = byNPC[npcID]
  if type(list) ~= "table" or #list == 0 then return end

  local owned, total = 0, #list
  for i = 1, total do
    if hasDecor(list[i]) then owned = owned + 1 end
  end

  local missing = total - owned
  tooltip:AddLine(" ")
  tooltip:AddLine("HomeDecor", 1, 0.82, 0)
  tooltip:AddDoubleLine("Collected", owned .. " / " .. total, 1, 1, 1, 1, 1, 1)

  if not IsShiftKeyDown() then
    if missing > 0 then
      tooltip:AddLine("Hold Shift: show missing", 0.8, 0.8, 0.8)
    else
      tooltip:AddLine("All collected", 0.3, 1, 0.3)
    end
    return
  end

  local shown = 0
  for i = 1, total do
    local decorID = list[i]
    if not hasDecor(decorID) then
      tooltip:AddLine(decorName(decorID) or ("Decor " .. tostring(decorID)), 1, 0.2, 0.2)
      shown = shown + 1
      if shown >= 25 then
        local left = missing - shown
        if left > 0 then tooltip:AddLine("+" .. left .. " more...", 0.8, 0.8, 0.8) end
        break
      end
    end
  end
end

local function handleNpcTooltip(tooltip)
  if not tooltip or tooltip:IsForbidden() then return end
  local _, unit = tooltip:GetUnit()
  if not canAccess(unit) then return end
  local ok, exists = pcall(UnitExists, unit)
  if not ok or not exists then return end
  local ok2, guid = pcall(UnitGUID, unit)
  if not ok2 or not canAccess(guid) then return end
  local ok3, npcID = pcall(function() return tonumber((select(6, strsplit("-", guid)))) end)
  if not ok3 or not npcID then return end
  TT.AppendNpcMouseover(tooltip, npcID)
end

if TooltipDataProcessor and Enum and Enum.TooltipDataType and TooltipDataProcessor.AddTooltipPostCall then
  TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, handleNpcTooltip)
elseif GameTooltip then
  GameTooltip:HookScript("OnShow", handleNpcTooltip)
end

local mod = CreateFrame("Frame")
mod:RegisterEvent("MODIFIER_STATE_CHANGED")
mod:SetScript("OnEvent", function()
  if not GameTooltip or not GameTooltip.IsShown or not GameTooltip:IsShown() then return end
  local _, unit = GameTooltip.GetUnit and GameTooltip:GetUnit()
  if unit then
    pcall(GameTooltip.SetUnit, GameTooltip, unit)
  elseif UnitExists and UnitExists("mouseover") then
    pcall(GameTooltip.SetUnit, GameTooltip, "mouseover")
  end
end)

return TT