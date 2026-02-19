local ADDON, NS = ...

NS.UI = NS.UI or {}

local MapPopup = NS.UI.MapPopup or {}
NS.UI.MapPopup = MapPopup

local function GetUI()
  return NS.UI.MapPopupUI
end

local function GetRender()
  return NS.UI.MapPopupRender
end

local function GetMapPopupDB()
  local addon = NS.Addon
  local profile = addon and addon.db and addon.db.profile
  if not profile then return nil end

  local mapPopup = profile.mapPopup
  if type(mapPopup) ~= "table" then
    mapPopup = {}
    profile.mapPopup = mapPopup
  end

  return mapPopup
end

function MapPopup:Show(vendorID, vendorData)
  if not self.frame then
    self:Create()
  end

  local frame = self.frame
  if not frame then 
    print("HomeDecor: Failed to create MapPopup frame")
    return 
  end

  if vendorID then
    self.currentVendors = {{ id = vendorID, data = vendorData }}
    
    local Render = GetRender()
    if Render and Render.SetTitle then
      Render:SetTitle(frame, vendorID)
    end
  end

  local Render = GetRender()
  if Render and Render.ScheduleRefresh then
    Render:ScheduleRefresh(self, frame)
  end

  frame:Show()
  frame:Raise()
end

function MapPopup:ShowMultiple(vendors)
  if not self.frame then
    self:Create()
  end

  self.currentVendors = vendors or {}
  
  local frame = self.frame
  if not frame then 
    print("HomeDecor: Failed to create MapPopup frame")
    return 
  end
  
  local Render = GetRender()
  if Render and Render.SetMultipleTitle then
    Render:SetMultipleTitle(frame, vendors)
  end

  if Render and Render.ScheduleRefresh then
    Render:ScheduleRefresh(self, frame)
  end

  frame:Show()
  frame:Raise()
end

function MapPopup:Refresh()
  local Render = GetRender()
  if not Render or not Render.RefreshContent then return end
  Render:RefreshContent(self, self.frame, self.currentVendors)
end

function MapPopup:Hide()
  if self.frame then
    self.frame:Hide()
  end
end

function MapPopup:Create()
  if self.frame then return end
  
  local UI = GetUI()
  if not (UI and UI.CreateFrame) then 
    print("HomeDecor: MapPopupUI not available")
    return 
  end

  local frame = UI:CreateFrame()
  self.frame = frame

  local Render = GetRender()
  if Render and Render.Attach then
    Render:Attach(self, frame)
  end

  local database = GetMapPopupDB()
  if database then
    frame.openVendors = {}
    frame.needsRefresh = false
    frame.refreshScheduled = false
  end
end

function MapPopup.RefreshTooltip()
  if _G.GameTooltip and _G.GameTooltip:IsShown() then
    local owner = _G.GameTooltip:GetOwner()
    if owner and owner.GetScript then
      local script = owner:GetScript("OnEnter")
      if script then
        script(owner)
      end
    end
  end
end

return MapPopup
