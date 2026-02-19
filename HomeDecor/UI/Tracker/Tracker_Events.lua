local ADDON, NS = ...
NS.UI = NS.UI or {}

local Events = NS.UI.TrackerEvents or {}
NS.UI.TrackerEvents = Events

local MapTracker = NS.Systems and NS.Systems.MapTracker
local U = NS.UI.TrackerUtil

local function Clamp(v, a, b)
  return (U and U.Clamp and U.Clamp(v, a, b)) or (v < a and a or (v > b and b or v))
end

function Events:Attach(Tracker, ctx)
    local f = ctx.frame
    local cb = ctx.trackCB
    local settings = ctx.settings
    local GetDB = ctx.GetDB

    if MapTracker and MapTracker.RegisterCallback then
        f._mtKey = "HomeDecorTrackerUI"
        MapTracker:RegisterCallback(f._mtKey, function(sender, name, mapID)
            if not f or not f.IsShown or not f:IsShown() then return end
            if not cb:GetChecked() then return end
            if mapID and mapID == f._lastZoneMapID then return end
            if (not mapID) and name and name ~= "" and name == f._lastZoneName then return end
            
            f._zoneJustChanged = true
            f._lastZoneName, f._lastZoneMapID = name, mapID
            
            if not f._collapsed then f:RequestRefresh("zone") end
        end)
    end

    f:SetScript("OnShow", function()
        local db = GetDB and GetDB()
        if cb and db then cb:SetChecked(db.trackZone ~= false) end
        local a = (db and db.alpha)
        if a == nil then a = 1 end
        local hc  = (db and db.hideCompleted)        and true or false
        local hcv = (db and db.hideCompletedVendors) and true or false

        f._hideCompleted        = hc
        f._hideCompletedVendors = hcv
        settings.hideCB:SetChecked(hc)

        if f._ApplyPanelsAlpha then f._ApplyPanelsAlpha(a, false) end
        settings.slider:SetValue(Clamp(tonumber(a) or 1, 0, 1))

        if cb:GetChecked() and MapTracker and MapTracker.Enable then
            MapTracker:Enable(true)
            if MapTracker.GetCurrentZone then
                local name, mapID = MapTracker:GetCurrentZone()
                if (not name or name == "") and GetRealZoneText then name = GetRealZoneText() or "" end
                
                if name ~= f._lastZoneName then
                    f._zoneJustChanged = true
                end
                
                f._lastZoneName, f._lastZoneMapID = name, mapID
            end
        end

        if not f._collapsed then
            f:RequestRefresh("show")
        end
    end)
end

return Events