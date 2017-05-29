-- Copyright (c) 2015-2016, r. brian harrison.  All rights reserved.

local LIB_NAME = "MapExcursion-1.0"
assert(LibStub, string.format("%s requires %s", LIB_NAME, "LibStub"))

local MapExcursion = LibStub:NewLibrary(LIB_NAME, 1)
if not MapExcursion then return end

function MapExcursion:MapExcursion(fn, ...)
    local registry = {GetFramesRegisteredForEvent("WORLD_MAP_UPDATE")}
    for _, frame in ipairs(registry) do
        frame:UnregisterEvent("WORLD_MAP_UPDATE")
    end

    local previousContinent
    local previousMapID = GetCurrentMapAreaID()
    local previousLevel = GetCurrentMapDungeonLevel()
    if not previousMapID or previousMapID < 0 or previousMapID == 751 then
        previousContinent = GetCurrentMapContinent()
        previousMapID = nil
        previousMapLevel = nil
    end

    local retval = {fn(...)}

    if previousContinent then
        SetMapZoom(previousContinent)
    end
    if previousMapID then
        SetMapByID(previousMapID)
    end
    if previousLevel then
        SetDungeonMapLevel(previousLevel)
    end

    for _, frame in ipairs(registry) do
        frame:RegisterEvent("WORLD_MAP_UPDATE")
    end

    return unpack(retval)
end
