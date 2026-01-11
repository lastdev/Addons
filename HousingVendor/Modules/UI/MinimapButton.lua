-- Minimap Button
local ADDON_NAME, ns = ...
local L = ns.L

local HousingMinimapButton = {}
HousingMinimapButton.__index = HousingMinimapButton

-- Default settings
local defaultSettings = {
  minimapButton = {
    hide = false,
    position = {
      minimapPos = 225,
    },
  },
}

-- Initialize saved variables
function HousingMinimapButton:InitializeSettings()
  if not HousingDB then
    HousingDB = {}
  end
  
  if not HousingDB.minimapButton then
    HousingDB.minimapButton = defaultSettings.minimapButton
  end
  
  if not HousingDB.minimapButton.position then
    HousingDB.minimapButton.position = defaultSettings.minimapButton.position
  end
end

-- Create the minimap button
function HousingMinimapButton:CreateButton()
  -- Initialize settings first
  self:InitializeSettings()

  -- Create the button frame
  local button = CreateFrame("Button", "HousingMinimapButton", Minimap)
  button:SetSize(31, 31)
  button:SetFrameStrata("MEDIUM")
  button:SetFrameLevel(8)
  button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
  
  -- Button textures
  local overlay = button:CreateTexture(nil, "OVERLAY")
  overlay:SetSize(53, 53)
  overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
  overlay:SetPoint("TOPLEFT")
  
  local icon = button:CreateTexture(nil, "BACKGROUND")
  icon:SetSize(20, 20)
  icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
  icon:SetPoint("TOPLEFT", 7, -5)
  
  -- Set button position
  -- Convert angle from degrees to radians for math.cos/math.sin
  local angleRad = math.rad(HousingDB.minimapButton.position.minimapPos)
  button:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 52 - (math.cos(angleRad) * 80), (math.sin(angleRad) * 80) - 52)
  
  -- Make it draggable
  button:EnableMouse(true)
  button:SetMovable(true)
  button:RegisterForDrag("LeftButton")
  button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  
  button:SetScript("OnDragStart", function(self)
    self:StartMoving()
  end)
  
  button:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    
    -- Save new position
    local centerX, centerY = Minimap:GetCenter()
    local x, y = self:GetCenter()
    local angle = math.deg(math.atan2(y - centerY, x - centerX))
    if angle < 0 then
      angle = angle + 360
    end
    
    HousingDB.minimapButton.position.minimapPos = angle
  end)
  
  -- Handle clicks:
  --  - Left click: open main UI
  --  - Right click: show zone popup for current zone
  button:SetScript("OnClick", function(self, mouseButton)
    if mouseButton == "RightButton" then
      if not HousingOutstandingItemsUI or not HousingOutstandingItemsUI.TogglePopup then
        print("|cFFFF4040HousingVendor:|r OutstandingItemsUI module not available")
        return
      end
      HousingOutstandingItemsUI:TogglePopup()
      return
    end

    -- Default: Load data addon and open main UI
    if HousingDataLoader then
      HousingDataLoader:EnsureDataLoaded(function()
        if HousingUINew and HousingUINew.Toggle then
          HousingUINew:Toggle()
        else
          print("HousingVendor UI not available")
        end
      end)
    else
      print("HousingVendor DataLoader not available")
    end
  end)

  -- Set up tooltip
  button:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText(L["MINIMAP_TOOLTIP"] or "HousingVendor", 1, 1, 1)
    GameTooltip:AddLine(L["MINIMAP_TOOLTIP_LEFTCLICK"] or "Left-click: open main window", nil, nil, nil, true)
    GameTooltip:AddLine(L["MINIMAP_TOOLTIP_RIGHTCLICK"] or "Right-click: zone popup", nil, nil, nil, true)
    GameTooltip:AddLine(L["MINIMAP_TOOLTIP_DRAG"] or "Drag: move button", nil, nil, nil, true)
    GameTooltip:Show()
  end)
  
  button:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)
  
  self.button = button
  
  -- Update visibility
  self:UpdateButtonVisibility()
end

-- Update button position (called when minimap size changes)
function HousingMinimapButton:UpdateButtonPosition()
  if self.button then
    -- Convert angle from degrees to radians for math.cos/math.sin
    local angleRad = math.rad(HousingDB.minimapButton.position.minimapPos)
    self.button:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 52 - (math.cos(angleRad) * 80), (math.sin(angleRad) * 80) - 52)
  end
end

-- Update button visibility based on settings
function HousingMinimapButton:UpdateButtonVisibility()
  if self.button then
    if HousingDB.minimapButton.hide then
      self.button:Hide()
    else
      self.button:Show()
    end
  end
end


-- Toggle button visibility
function HousingMinimapButton:ToggleButton()
  HousingDB.minimapButton.hide = not HousingDB.minimapButton.hide
  self:UpdateButtonVisibility()
end

-- Show the button
function HousingMinimapButton:ShowButton()
  HousingDB.minimapButton.hide = false
  self:UpdateButtonVisibility()
end

-- Hide the button
function HousingMinimapButton:HideButton()
  HousingDB.minimapButton.hide = true
  self:UpdateButtonVisibility()
end

-- Make HousingMinimapButton globally available as HousingMinimap
_G["HousingMinimap"] = HousingMinimapButton

-- Create the button when the addon loads
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
  if addonName == "HousingVendor" then
    HousingMinimapButton:CreateButton()
    self:UnregisterEvent("ADDON_LOADED")
  end
end)
