-- Copyright (c) 2015-2016, r. brian harrison.  All rights reserved.

local LIB_NAME = "MapMap-1.0"
assert(LibStub, string.format("%s requires %s", LIB_NAME, "LibStub"))

local MapExcursion = LibStub("MapExcursion-1.0")
assert(MapExcursion, string.format("%s requires %s", LIB_NAME, "MapExcursion"))

local MapMap = LibStub:NewLibrary(LIB_NAME, 1)
if not MapMap then return end

local TERRAIN_MATCH = "_terrain%d+$"
local frame = CreateFrame("Frame", string.format("%s_Frame", LIB_NAME))
local function OnEvent(frame, event, ...)
    MapMap[event](MapMap, event, ...)
end
frame:SetScript("OnEvent", OnEvent)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

function MapMap:PLAYER_ENTERING_WORLD(event)
    frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    self:Survey()
end

function MapMap:Deterrain(mapFile)
    return mapFile:gsub(TERRAIN_MATCH, "")
end

function MapMap:Survey()
    self.mapFileToID = {}
    self.mapIDToFile = {}
    self.parent = {}
    MapExcursion:MapExcursion(function()
            for _, zoneID in ipairs(GetAreaMaps()) do
                if SetMapByID(zoneID) then
                    local mapFile = self:Deterrain(GetMapInfo())
                    self.mapFileToID[mapFile] = zoneID
                    self.mapIDToFile[zoneID] = mapFile
                    if ZoomOut() then
                        self.parent[mapFile] = {GetCurrentMapAreaID(), (GetMapInfo())}
                    end
                end
            end
    end)
end
