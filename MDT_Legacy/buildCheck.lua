---@class MDT_Legacy
local addon = select(2, ...)

function addon:IsRetail()
  local gameVersion = select(4, GetBuildInfo())
  return gameVersion >= 110000
end

function addon:IsMop()
  local gameVersion = select(4, GetBuildInfo())
  return gameVersion >= 50000 and gameVersion < 60000
end
