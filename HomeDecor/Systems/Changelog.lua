local ADDON, NS = ...

NS.Systems = NS.Systems or {}
NS.Systems.Changelog = NS.Systems.Changelog or {}
local CLog = NS.Systems.Changelog

CLog.CURRENT_VERSION = C_AddOns.GetAddOnMetadata(ADDON, "Version") or ""

local function Ensure()
  if not NS.db or not NS.db.profile then return nil end
  local p = NS.db.profile
  p.changelog = p.changelog or {}
  if p.changelog.autoOpen == nil then p.changelog.autoOpen = true end
  if p.changelog.lastSeenVersion == nil then p.changelog.lastSeenVersion = "" end
  return p.changelog
end

function CLog:IsAutoOpenEnabled()
  local s = Ensure()
  if not s then return true end
  return s.autoOpen and true or false
end

function CLog:SetAutoOpen(v)
  local s = Ensure()
  if s then s.autoOpen = v and true or false end
end

function CLog:IsNewVersion()
  local s = Ensure()
  if not s or not s.autoOpen then return false end
  return s.lastSeenVersion ~= self.CURRENT_VERSION
end

function CLog:MarkSeen()
  local s = Ensure()
  if s then s.lastSeenVersion = self.CURRENT_VERSION end
end

function CLog:GetText()
  return _G.HomeDecor_Changelog or ""
end

function CLog:TryAutoPopup()
  if not self:IsNewVersion() then return end
  if NS.UI and NS.UI.ShowChangelogPopup then
    NS.UI:ShowChangelogPopup(false)
  end
end