-----------------------
-- Addon and Modules --
-----------------------
local DS = LibStub("AceAddon-3.0"):GetAddon("Doom Shards", true)
if not DS then return end
local CD = DS:GetModule("display")
if not CD then return end

local WA = DS:NewModule("weakauras", "AceEvent-3.0")


--------------
-- Upvalues --
--------------
local assert = assert
local type = type


---------
-- API --
---------
function DS:GetPrediction(position)
  local indicator = CD.indicators[position]
  if indicator then
    return indicator.tick, indicator.resourceChance
  end
end


---------------
-- Functions --
---------------
local function WeakAurasLoaded()
  local WeakAuras_ScanEvents = WeakAuras.ScanEvents
  function WA:DOOM_SHARDS_DISPLAY_UPDATE()
    WeakAuras_ScanEvents("DOOM_SHARDS_DISPLAY_UPDATE")
  end

  WA:RegisterMessage("DOOM_SHARDS_DISPLAY_UPDATE")
end

function WA:OnEnable()
  if IsAddOnLoaded("WeakAuras") then  -- optionalDeps produces bugs with some addons
    WeakAurasLoaded()
  else
    WA:RegisterEvent("ADDON_LOADED", function(_, name)
      if name == "WeakAuras" then
        WeakAurasLoaded()
      end
    end)
  end
end

function WA:OnDisable()
  self:UnregisterMessage("DOOM_SHARDS_DISPLAY_UPDATE")
end
