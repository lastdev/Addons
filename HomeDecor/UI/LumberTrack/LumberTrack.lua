local ADDON, NS = ...
NS.UI = NS.UI or {}

local LumberTrack = {}
NS.UI.LumberTrack = LumberTrack

local Utils = NS.LT.Utils

local DEFAULT_LUMBER = {
  [245586] = true, [242691] = true, [251762] = true, [251764] = true, [251763] = true,
  [251766] = true, [251767] = true, [251768] = true, [251772] = true, [251773] = true,
  [256963] = true, [248012] = true
}

local sharedCtx = nil

local function GetDB()
  return Utils.GetDB()
end

local function InitializeDefaults(db)
  db.lumberIDs = db.lumberIDs or {}
  for id in pairs(DEFAULT_LUMBER) do
    db.lumberIDs[id] = true
  end

  if db.showIcons == nil then db.showIcons = true end
  if db.goal == nil then db.goal = 1000 end
  if db.alpha == nil then db.alpha = 0.7 end
  if db.compactMode == nil then db.compactMode = false end
end

function LumberTrack:Create()
  if sharedCtx then return end 
  
  local db = GetDB()
  InitializeDefaults(db)

  local Render = NS.UI.LumberTrackRender
  sharedCtx = Render:Init({ 
    GetDB = GetDB,
    lumberIDs = db.lumberIDs or {},
    compactMode = db.compactMode and true or false
  }) or { 
    GetDB = GetDB,
    lumberIDs = db.lumberIDs or {},
    compactMode = db.compactMode and true or false
  }

  local LumberList = NS.UI.LumberTrackLumberList
  if LumberList then LumberList:Create(sharedCtx) end
  
  local FarmingStats = NS.UI.LumberTrackFarmingStats
  if FarmingStats then FarmingStats:Create(sharedCtx) end

  local Events = NS.UI.LumberTrackEvents
  if Events then
    sharedCtx.eventFrame = CreateFrame("Frame")
    sharedCtx.frame = sharedCtx.eventFrame
    Events:Attach(self, sharedCtx)
  end
  
  if Render then Render:Refresh(sharedCtx) end

  if db.lumberListOpen and LumberList then LumberList:Show() end
  if db.farmingStatsOpen and FarmingStats then FarmingStats:Show() end
end

function LumberTrack:Toggle()
  if not sharedCtx then self:Create() end
  local LumberList = NS.UI.LumberTrackLumberList
  if LumberList then LumberList:Toggle() end
end

function LumberTrack:ToggleLumberList()
  if not sharedCtx then self:Create() end
  local LumberList = NS.UI.LumberTrackLumberList
  if LumberList then LumberList:Toggle() end
end

function LumberTrack:ToggleFarmingStats()
  if not sharedCtx then self:Create() end
  local FarmingStats = NS.UI.LumberTrackFarmingStats
  if FarmingStats then FarmingStats:Toggle() end
end

return LumberTrack