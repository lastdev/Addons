local addonName, addon = ...
local TCL = addon.TomCatsLibs
-- TODO: Add icons to the WorldMapFrame
-- TODO: Add icons to the BattleFieldMapFrame
-- TODO: Add icons to the FlightMapFrame
-- TODO: Add automatic routing
-- TODO: Draw route on the map
-- TODO: Add coins owned indicator + coins remaining to loot
-- TODO: Coins remaining indicator on the maps
-- TODO: Add holiday items available for purchase window
-- TODO: Add shortcut to achievements or achievements remaining tab
-- TODO: Allow automatic use/destruction of holiday 'junk' items
-- TODO: TomCats-Arrows to close in on target
-- TODO: Integrate with map's built-in tracker
-- TODO: Handle zone phase detection and advice
local allowedMaps = {
    WorldMapFrame = true,
    BattlefieldMapFrame = true,
    FlightMapFrame = true
}
local function AddDataProviderToMap(map)
    if (allowedMaps[map:GetName()]) then
        map:AddDataProvider(CreateFromMixins(TomCatsLunarFestivalDataProviderMixin))
    end
end
local function ADDON_LOADED(_, event, ...)
    local var1 = select(1, ...)
    if (var1 == addon.name) then
        AddDataProviderToMap(WorldMapFrame)
        hooksecurefunc(MapCanvasMixin, "OnLoad", AddDataProviderToMap)
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
    end
end
local function zoneTweak(_, event, ...)
    if (BattlefieldMapFrame) then
        BattlefieldMapFrame:OnEvent("ZONE_CHANGED_NEW_AREA")
    end
end
local function zoneTweakRecheck()
    if (BattlefieldMapFrame) then
        local mapID1 = MapUtil.GetDisplayableMapForPlayer()
        local mapID2 = BattlefieldMapFrame:GetMapID()
        if (mapID1 ~= mapID2) then BattlefieldMapFrame:OnEvent("ZONE_CHANGED_NEW_AREA") end
        C_Timer.After(1, zoneTweakRecheck)
    else
        C_Timer.After(5, zoneTweakRecheck)
    end
end
TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)
TCL.Events.RegisterEvent("ZONE_CHANGED", zoneTweak)
TCL.Events.RegisterEvent("ZONE_CHANGED_INDOORS", zoneTweak)
TCL.Events.RegisterEvent("NEW_WMO_CHUNK", zoneTweak)
zoneTweakRecheck()
if (TomCats and TomCats.Register) then
    TomCats:Register(
        {
            name = "Lunar Festival",
            version = "1.0.25"
        }
    )
end
