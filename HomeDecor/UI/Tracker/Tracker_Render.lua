local _, NS = ...
NS.UI = NS.UI or {}

local Tracker = NS.UI.Tracker or {}
NS.UI.Tracker = Tracker

local Render = NS.UI.TrackerRender or {}
NS.UI.TrackerRender = Render
Tracker.Render = Render

local Rows = NS.UI.TrackerRows
local U = NS.UI.TrackerUtil
local IA = NS.UI.ItemInteractions
local Map = NS.Systems and NS.Systems.MapTracker
local DecorCounts = NS.Systems and NS.Systems.DecorCounts
local Collection = NS.Systems and NS.Systems.Collection
local HousingBootstrap = NS.Systems and NS.Systems.HousingBootstrap
local Viewer = NS.UI and NS.UI.Viewer
local C_Timer = _G.C_Timer

local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local GetTime = _G.GetTime
local pcall = _G.pcall

local NPCNames = NS.Systems and NS.Systems.NPCNames

local function CleanVendorTitle(s)
  if type(s) ~= "string" then return nil end
  s = s:gsub("^%s+", ""):gsub("%s+$", "")
  if s == "" then return nil end
  if s:match("^%d+$") then return nil end
  return s
end

local function ResolveVendorTitle(vendor, frame)
  if type(vendor) ~= "table" then return nil end

  local t = CleanVendorTitle(vendor.title)
  if t then return t end

  local src = vendor.source or {}
  local id = tonumber((src and src.id) or vendor.npcID or vendor.id)
  if not id then return nil end

  local Data = Viewer and Viewer.Data
  if Data and Data.ResolveVendorTitle then
    t = CleanVendorTitle(Data.ResolveVendorTitle(vendor))
    if t then return t end
  end

  if NPCNames and NPCNames.Get then
    local name = NPCNames.Get(id, function()
      if frame and frame.RequestRefresh and frame.IsShown and frame:IsShown() and not frame._collapsed then
        frame:RequestRefresh("vendorname")
      end
    end)
    name = CleanVendorTitle(name)
    if name then return name end
  end

  return nil
end

local wipe = _G.wipe or function(t) for k in pairs(t) do t[k] = nil end end
local max = math.max

local function GetZone()
  if Map and Map.GetCurrentZone then
    local name, mapID = Map:GetCurrentZone()
    if name or mapID then
      return name or ((GetRealZoneText and GetRealZoneText()) or ""), mapID
    end
  end
  return (GetRealZoneText and GetRealZoneText()) or "", nil
end

local function VendorKey(v)
  if type(v) ~= "table" then return "vendor:0" end
  local src = v.source
  return "vendor:" .. tostring((src and src.id) or v.npcID or v.id or "")
    .. ":" .. tostring(v.worldmap or (src and src.worldmap) or "")
    .. ":" .. tostring(v.title or "")
end

local function IsValid(it)
  if type(it) ~= "table" then return false end
  local did = tonumber(it.decorID)
  local iid = tonumber((it.source and it.source.itemID) or it.itemID or it.id)
  if did == 0 or iid == 0 then return false end
  if did and did < 0 then return false end
  if iid and iid < 0 then return false end
  if (did and did > 0) then return true end
  local title = it.title
  if type(title) ~= "string" then return false end
  return title:gsub("%s+", "") ~= ""
end

local function FetchZoneVendors()
  if not (Map and Map.GetVendorsForCurrentZone) then
    return {}
  end

  local prof = NS.Addon and NS.Addon.db and NS.Addon.db.profile
  local ui = prof and prof.ui
  local prevCat, prevSearch
  if ui then
    prevCat, prevSearch = ui.activeCategory, ui.search
    ui.activeCategory, ui.search = nil, ""
  end

  local vendors = Map:GetVendorsForCurrentZone() or {}

  if ui then
    ui.activeCategory, ui.search = prevCat, prevSearch
  end

  if type(vendors) == "table" and #vendors == 0 then
    local flat
    for _, set in pairs(vendors) do
      if type(set) == "table" then
        for _, v in ipairs(set) do
          flat = flat or {}
          flat[#flat + 1] = v
        end
      end
    end
    if flat and #flat > 0 then
      vendors = flat
    end
  end

  return vendors
end

local function _trimTitle(s)
  if type(s) ~= "string" then return nil end
  s = s:gsub("^%s+", ""):gsub("%s+$", "")
  if s == "" then return nil end
  if s:match("^%d+$") then return nil end
  return s
end

local function SetArrow(tex, open)
  if tex and tex.SetRotation then
    tex:SetRotation(open and -1.5708 or 0)
  end
end

local function ItemFaction(it)
  local f = it and (it.faction or (it.source and it.source.faction))
  if f == "Alliance" or f == "Horde" then
    return f
  end
end

function Render:Attach(_, ctx)
  local frame = ctx.frame
  local trackCB = ctx.trackCB
  local overall = ctx.overallRow
  local content = ctx.content

  Rows:InitPools(frame, content)

  if NPCNames and NPCNames.RegisterListener and not frame._npcNamesListenerInstalled then
    frame._npcNamesListenerInstalled = true
    NPCNames.RegisterListener(function(_, name)
      if not name or name == "" then return end
      if frame and frame.RequestRefresh and frame.IsShown and frame:IsShown() and not frame._collapsed then
        frame:RequestRefresh("vendorname")
      end
    end)
  end

  local GetDecorIcon = U and U.GetDecorIcon
  local GetDecorName = U and U.GetDecorName
  local IsCollected = U and U.IsCollectedSafe
  local GetReqLines = U and U.GetAQAndRepLines

  frame._collectedCache = frame._collectedCache or {}
  frame._scratchVisible = frame._scratchVisible or {}
  frame._openVendors = frame._openVendors or {}

  if not frame.__hdCollectionListener then
    frame.__hdCollectionListener = true
    local queued = false
    local function request(reason)
      if queued then return end
      queued = true
      if C_Timer and C_Timer.After then
        C_Timer.After(0, function()
          queued = false
          if frame and frame.RequestRefresh then
            frame:RequestRefresh(reason or "collection")
          end
        end)
      else
        queued = false
        if frame and frame.RequestRefresh then
          frame:RequestRefresh(reason or "collection")
        end
      end
    end

    if Collection and Collection.RegisterListener then
      Collection:RegisterListener(function()
        request("collection")
      end)
    else
      local ef = CreateFrame("Frame")
      ef:RegisterEvent("HOUSING_STORAGE_UPDATED")
      ef:RegisterEvent("HOUSING_STORAGE_ENTRY_UPDATED")
      ef:RegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")
      ef:SetScript("OnEvent", function()
        request("housing")
      end)
      frame.__hdCollectionEventFrame = ef
    end

    if HousingBootstrap and HousingBootstrap.ready == false then
      local function poll()
        if not frame then return end
        if HousingBootstrap.ready then
          request("catalog_ready")
          return
        end
        if C_Timer and C_Timer.After then
          C_Timer.After(0.5, poll)
        end
      end
      poll()
    end
  end

  function frame:Refresh()
    local tracking = trackCB:GetChecked() and true or false
    local zoneName, zoneMapID = tracking and GetZone() or ((GetRealZoneText and GetRealZoneText()) or ""), nil

    frame._lastZoneName, frame._lastZoneMapID = zoneName, zoneMapID
    overall.zone:SetText(zoneName or "")

    if zoneName ~= frame._shownZoneName then
      frame._shownZoneName = zoneName
      Rows:StopPulse(overall.zone)
    end

    if frame._collapsed then return end

    Rows:ReleaseAll(frame)
    if frame._SyncContentWidth then
      frame:_SyncContentWidth()
    end

    local vendors = tracking and FetchZoneVendors() or {}
    local cAll, tAll = 0, 0

    overall.count:SetText("")
    if overall.bar then
      overall.bar:Hide()
    end

    local collectedCache = frame._collectedCache
    wipe(collectedCache)

    local visible = frame._scratchVisible
    local y = 0

    for _, v in ipairs(vendors) do
      local items = (type(v) == "table" and type(v.items) == "table") and v.items or nil
      if items then
        wipe(visible)
        local cV, tV = 0, 0

        for _, it in ipairs(items) do
          if IsValid(it) then
            local did = it.decorID or it.id or tostring(it)
            local collected = collectedCache[did]
            if collected == nil then
              collected = IsCollected and IsCollected(it) or false
              collectedCache[did] = collected
            end
            if not (frame._hideCompleted and collected) then
              tV = tV + 1
              if collected then
                cV = cV + 1
              end
              visible[#visible + 1] = it
            end
          end
        end

        if tV > 0 then
          local vKey = VendorKey(v)
          local open = (frame._openVendors[vKey] == true)

          cAll = cAll + cV
          tAll = tAll + tV

          local vr = Rows:Acquire(frame, "vendor")
          vr:SetPoint("TOPLEFT", 0, -y)
          vr:SetPoint("TOPRIGHT", 0, -y)
          do
            local title = ResolveVendorTitle(v, frame)
            if not title then
              local src = v.source or {}
              local id = tonumber(src.id or v.npcID or v.id)
              title = (id and ("Vendor " .. tostring(id))) or "Vendor"
            else
              v.title = title
            end
            vr.label:SetText(title)
          end
          vr.count:SetText(cV .. " / " .. tV)
          if vr.bar then
            vr.bar:SetProgress(cV, tV)
            vr.bar:Show()
          end
          SetArrow(vr.arrow, open)

          vr._owner, vr._vKey = frame, vKey
          if not vr.__hdVendorClick then
            vr.__hdVendorClick = true
            vr:SetScript("OnClick", function(self)
              local owner, key = self._owner, self._vKey
              if not owner or not key then return end
              owner._openVendors[key] = not (owner._openVendors[key] == true)
              owner:RequestRefresh("toggle")
            end)
          end

          y = y + (vr:GetHeight() or 34) + 8

          if open then
            for i = 1, #visible do
              local it = visible[i]
              local did = it.decorID or it.id or tostring(it)
              local collected = collectedCache[did]

              local ir = Rows:Acquire(frame, "item")
              ir:SetPoint("TOPLEFT", 0, -y)
              ir:SetPoint("TOPRIGHT", 0, -y)

              local title = it.title
              if (not title or title == "") and GetDecorName and it.decorID then
                title = GetDecorName(it.decorID)
              end
              if not title or title == "" then
                title = "Decor " .. tostring(it.decorID or "")
              end
              ir.title:SetText(title)

              if ir.icon then
                ir.icon:SetTexture((GetDecorIcon and GetDecorIcon(it.decorID)) or "Interface\\Icons\\INV_Misc_QuestionMark")
              end

              if collected then
                ir.check:Show()
              else
                ir.check:Hide()
              end

              if ir.owned and DecorCounts then
                local itemID = tonumber((it.source and it.source.itemID) or it.itemID or it.id)
                local totalOwned = 0
                if itemID and itemID > 0 then
                  totalOwned = (DecorCounts.GetBreakdownByItem and select(1, DecorCounts:GetBreakdownByItem(itemID))) or 0
                end
                if totalOwned and totalOwned > 0 then
                  ir.owned:SetText(tostring(totalOwned))
                  ir.owned:Show()
                else
                  ir.owned:Hide()
                end
              elseif ir.owned then
                ir.owned:Hide()
              end

              local aq, rep = nil, nil
              if GetReqLines then
                aq, rep = GetReqLines(it)
              end
              if aq then
                ir.reqAQ:SetText(aq)
                ir.reqAQ:Show()
              else
                ir.reqAQ:Hide()
              end
              if rep then
                ir.reqRep:SetText(rep)
                ir.reqRep:Show()
              else
                ir.reqRep:Hide()
              end

              local fac = ItemFaction(it)
              if fac == "Alliance" then
                ir.faction:SetTexture(ir._texAlliance)
                ir.faction:Show()
              elseif fac == "Horde" then
                ir.faction:SetTexture(ir._texHorde)
                ir.faction:Show()
              else
                ir.faction:Hide()
              end

              if IA and IA.Bind then
                IA:Bind(ir, it, it._navVendor or it.vendor or v)
              end

              y = y + (ir:GetHeight() or 54) + 8
            end
          end
        end
      end
    end

    overall.count:SetText(tAll > 0 and (cAll .. " / " .. tAll) or "")
    if overall.bar and tAll > 0 then
      overall.bar:SetProgress(cAll, tAll)
      overall.bar:Show()
    elseif overall.bar then
      overall.bar:Hide()
    end

    content:SetHeight(max(1, y))
    if frame._SyncBarsToWidth then
      frame:_SyncBarsToWidth()
    end
    if frame._ApplyPanelsAlpha then
      frame:_ApplyPanelsAlpha(frame._bgAlpha, false)
    end
  end

  trackCB:SetScript("OnClick", function()
    local checked = trackCB:GetChecked() and true or false
    local db = ctx.GetDB and ctx.GetDB() or nil
    if db then
      db.trackZone = checked
    end
    if Map and Map.Enable then
      Map:Enable(checked)
    end
    frame:RequestRefresh("trackzone")
  end)
end

return Render