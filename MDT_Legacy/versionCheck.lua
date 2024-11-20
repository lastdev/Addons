---@class MDT_Legacy
local addon = select(2, ...)

---@return boolean
function addon:GenericVersionCheck(addonName, oldestSupported)
  local currentVersionString = C_AddOns.GetAddOnMetadata(addonName, "Version")
  return addon:IsSemverSameOrHigher(currentVersionString, oldestSupported)
end

---Checks if the version of the addon is the same or higher than the provided version.
---Version format is semver but it can be any string that has numbers separated by dots.
---@param a string
---@param b string
function addon:IsSemverSameOrHigher(a, b)
  local aMajor, aMinor, aPatch, aBuild = string.match(a, "(%d+)%.*(%d*)%.*(%d*)%.*(%d*)")
  local bMajor, bMinor, bPatch, bBuild = string.match(b, "(%d+)%.*(%d*)%.*(%d*)%.*(%d*)")
  aMajor = aMajor and tonumber(aMajor) or 0
  aMinor = aMinor and tonumber(aMinor) or 0
  aPatch = aPatch and tonumber(aPatch) or 0
  aBuild = aBuild and tonumber(aBuild) or 0
  bMajor = bMajor and tonumber(bMajor) or 0
  bMinor = bMinor and tonumber(bMinor) or 0
  bPatch = bPatch and tonumber(bPatch) or 0
  bBuild = bBuild and tonumber(bBuild) or 0

  if aMajor > bMajor then
    return true
  end
  if aMajor < bMajor then
    return false
  end
  if aMinor > bMinor then
    return true
  end
  if aMinor < bMinor then
    return false
  end
  if aPatch > bPatch then
    return true
  end
  if aPatch < bPatch then
    return false
  end
  if aBuild > bBuild then
    return true
  end
  if aBuild < bBuild then
    return false
  end
  return true
end
