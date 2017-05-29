local _, class = UnitClass("player")
if class ~= "WARLOCK" then return end

local DS = LibStub("AceAddon-3.0"):NewAddon("Doom Shards", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("DoomShards")
local ACR = LibStub("AceConfigRegistry-3.0")


-------------------
-- Global Object --
-------------------
DoomShards = DS


---------------
-- Variables --
---------------
--[===[@alpha@
local isAlpha = true
--@end-alpha@]===]



-----------------------
-- Locking/unlocking --
-----------------------
do
  local function dragStop(self, moduleName)
    self:StopMovingOrSizing()
    self:SetUserPlaced(false)

    local _, anchorFrame, anchor, posX, posY = self:GetPoint()
    DS.db[moduleName].anchor = anchor
    DS.db[moduleName].anchorFrame = anchorFrame and anchorFrame:GetName() or "UIParent"
    DS.db[moduleName].posX = posX
    DS.db[moduleName].posY = posY

    ACR:NotifyChange("Doom Shards")
  end

  -- frame factory for all display modules' parent frames
  function DS:CreateParentFrame(name, moduleName)
    local frame = CreateFrame("frame", name, UIParent)
    frame:SetFrameStrata("LOW")
    frame:SetMovable(true)
    frame:SetUserPlaced(false)  -- necessary?
    frame.texture = frame:CreateTexture(nil, "BACKGROUND")
    frame.texture:SetPoint("BOTTOMLEFT", -1, -1)
    frame.texture:SetPoint("TOPRIGHT", 1, 1)
    frame.texture:SetTexture(0.38, 0.23, 0.51, 0.7)
    frame.texture:Hide()

    function frame:Unlock()
      self:Show()
      self.texture:Show()

      self:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:AddLine("Doom Shards", 0.51, 0.31, 0.67, 1, 1, 1)
        GameTooltip:AddLine(L["dragFrameTooltip"], 1, 1, 1, 1, 1, 1)
        GameTooltip:Show()
      end)

      self:SetScript("OnLeave", function(s)
        GameTooltip:Hide()
      end)

      self:SetScript("OnMouseDown", function(self, button)
        if button == "RightButton" then
          dragStop(self, moduleName)  -- in case user right clicks while dragging the frame
          DS:Lock()
        elseif button == "LeftButton" then
          self:StartMoving()
        end
      end)

      self:SetScript("OnMouseUp", function(self, button)
        dragStop(self, moduleName)
      end)

      self:SetScript("OnMouseWheel", function(self, delta)
        if IsShiftKeyDown() then
          DS.db[moduleName].posX = DS.db[moduleName].posX + delta
        else
          DS.db[moduleName].posY = DS.db[moduleName].posY + delta
        end
        self:SetPoint(DS.db[moduleName].anchor, DS.db[moduleName].posX, DS.db[moduleName].posY)
      end)
    end

    function frame:Lock()
      self.texture:Hide()
      self:EnableMouse(false)
      self:SetScript("OnEnter", nil)
      self:SetScript("OnLeave", nil)
      self:SetScript("OnMouseDown", nil)
      self:SetScript("OnMouseUp", nil)
      self:SetScript("OnMouseWheel", nil)
    end

    return frame
  end
end

function DS:Unlock()
  print(L["Doom Shards unlocked!"])
  self:EndTestMode()
  self.locked = false
  for name, module in self:IterateModules() do
    if self.db[name] and self.db[name].enable then
      if module.Unlock then module:Unlock() end
      if module.frame then module.frame:Unlock() end
    end
  end
  self:Build()
end

function DS:Lock()
  if not self.locked then print(L["Doom Shards locked!"]) end
  self.locked = true
  for name, module in self:IterateModules() do
    if self.db[name] and self.db[name].enable then
      if module.Lock then module:Lock() end
      if module.frame then module.frame:Lock() end
    end
  end
  self:SpecializationsCheck()  -- build displays  -- TODO: rebuild initialization flow
end


---------------
-- Debugging --
---------------
do
  local debugFrame

  function DS:Debug(message)
    if not self.db.debug then return end
    message = tostring(message)  -- in case message == nil and for contentation
    if debugFrame then
      debugFrame:AddMessage(message)
    end
    print("|cFF814eaaDoom Shards|r Debug: "..message)
  end

  -- client needs to get reloaded for this
  function DS:DebugCheckChatWindows()
    for i = 1, NUM_CHAT_WINDOWS do
      if GetChatWindowInfo(i) == "DS Debug" then
        debugFrame = _G["ChatFrame"..tostring(i)]
        return true
      end
    end
  end
end


--------------------
-- Initialization --
--------------------
function DS:ApplySettings()
  for name, module in self:IterateModules() do
    if self.db[name] and self.db[name].enable then
      module:Enable()
      if not DS.locked and module.frame then
        module.frame:Unlock()
      end
      if module.Build then
        module:Build()
      end
    else
      module:Disable()
      if module.frame then
        module.frame:Hide()
      end
    end
  end
end

function DS:OnInitialize()
  self.locked = true

  -- Database
  local OPT = LibStub("AceDBOptions-3.0")
  local DSDB = LibStub("AceDB-3.0"):New("DoomShardsDB", self.defaultSettings, true)
  DS.DSDB = DSDB

  -- Copy settings from old database (TODO: Deprecate in the future)
  if next(DSDB.global) ~= nil then
    for k, v in pairs(DSDB.global) do
      if type(v) == "table" then
        for k2, v2 in pairs(v) do
          DSDB.profile[k][k2] = v2
        end
      else
        DSDB.profile[k] = v
      end
      DSDB.global[k] = nil
    end
  end

  self.db = DSDB.profile

  -- Handle legacy options
  if self.db.specializations[30108] ~= nil then
    local oldUASetting = self.db.specializations[30108]
    self.db.specializations[233490] = oldUASetting
    self.db.specializations[233496] = oldUASetting
    self.db.specializations[233497] = oldUASetting
    self.db.specializations[233498] = oldUASetting
    self.db.specializations[233499] = oldUASetting
    self.db.specializations[30108] = nil
  end

  self:AddDisplayOptions("Profile",
    function()
      local options = OPT:GetOptionsTable(DSDB)
      options.order = 6
      return options
    end,
    {}
  )
  function self:ResetDB()
    DSDB:ResetDB()
    self.db = DSDB.profile
    ACR:NotifyChange("Doom Shards")
    self:Build()
    print(L["Doom Shards reset!"])
  end

  -- Dual Spec
  local LDS = LibStub("LibDualSpec-1.0")
  LDS:EnhanceDatabase(DSDB, "Doom Shards")
  LDS:EnhanceOptions(OPT:GetOptionsTable(DSDB), DSDB)

  DSDB.RegisterCallback(self, "OnProfileChanged", "ReloadSettings")
  DSDB.RegisterCallback(self, "OnProfileCopied", "ReloadSettings")
  DSDB.RegisterCallback(self, "OnProfileReset", "ReloadSettings")

  -- Debugging
  if not isAlpha then  -- Automatically reset debug values if version isn't alpha
    self.db.debug = false
    self.db.debugSA = false
  end
  local debugFrameExists = self:DebugCheckChatWindows()
  if self.db.debug then
    print("|cFF814eaaDoom Shards|r: debugging enabled")
    if not debugFrameExists then print("|cFF814eaaDoom Shards|r: Create chat window named \"DS Debug\" for separate output.") end
  end
  if self.db.debugSA then print("|cFF814eaaDoom Shards|r: debugging SATimers enabled") end

  self:RegisterEvent("PLAYER_ENTERING_WORLD")
  -- will fire once for every talent tier after player is in-game and ultimately initialize events and displays if player is Shadow
  self:RegisterEvent("PLAYER_TALENT_UPDATE", "SpecializationsCheck")
end

function DS:ReloadSettings()
  self.db = self.DSDB.profile
  self:Build()
end
