-- Saved Variables and Configuration

-- Debug mode flag (set to true for debugging, false for production)
local DEBUG_MODE = false

-- Default database structure
_G["HousingDBDefaults"] = {
  minimapButton = {
    hide = false,
    position = {
      minimapPos = 225,
    },
  },
  settings = {
    showCollected = false,
    usePortalNavigation = true,
    showOutstandingPopup = true,
    autoFilterByZone = false,
  },
  uiScale = 1.0,
}

-- Debug print function (only prints if DEBUG_MODE is true)
function _G.HousingDebugPrint(...)
  if DEBUG_MODE then
    print("[Housing]", ...)
  end
end

-- Configuration file