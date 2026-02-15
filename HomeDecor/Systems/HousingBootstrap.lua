local ADDON, NS = ...
NS.Systems = NS.Systems or {}

local HB = {}
NS.Systems.HousingBootstrap = HB

HB.ready = false
HB.searcher = nil
HB.retryTimer = nil
HB.timeoutTimer = nil
HB.tries = 0
HB.maxTries = 6

local function CancelTimers()
  if HB.retryTimer then HB.retryTimer:Cancel() HB.retryTimer = nil end
  if HB.timeoutTimer then HB.timeoutTimer:Cancel() HB.timeoutTimer = nil end
end

local function MarkReady()
  HB.ready = true
  CancelTimers()
end

local function TryWarmCatalog()
  if HB.ready then return end
  HB.tries = HB.tries + 1
  if HB.tries > HB.maxTries then return end

  if not (C_HousingCatalog and C_HousingCatalog.CreateCatalogSearcher) then
    HB.retryTimer = C_Timer.NewTimer(1.0, TryWarmCatalog)
    return
  end

  local searcher = C_HousingCatalog.CreateCatalogSearcher()
  if not searcher then
    HB.retryTimer = C_Timer.NewTimer(1.0, TryWarmCatalog)
    return
  end

  HB.searcher = searcher

  if searcher.SetOwnedOnly then searcher:SetOwnedOnly(false) end
  if searcher.SetCollected then searcher:SetCollected(true) end
  if searcher.SetUncollected then searcher:SetUncollected(true) end
  if searcher.SetAutoUpdateOnParamChanges then searcher:SetAutoUpdateOnParamChanges(false) end

  if searcher.SetResultsUpdatedCallback then
    searcher:SetResultsUpdatedCallback(function()
      MarkReady()
    end)
  end

  if searcher.RunSearch then
    searcher:RunSearch()
  end

  HB.timeoutTimer = C_Timer.NewTimer(5.0, function()
    if HB.ready then return end
    HB.searcher = nil
    HB.retryTimer = C_Timer.NewTimer(1.0, TryWarmCatalog)
  end)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(_, event)
  if HB.ready then return end
  C_Timer.After(0, TryWarmCatalog)
end)

return HB
