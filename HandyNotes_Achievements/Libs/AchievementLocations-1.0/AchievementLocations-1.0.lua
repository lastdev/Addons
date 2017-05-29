-- Copyright (c) 2015-2016, r. brian harrison.  All rights reserved.

local LIB_NAME = "AchievementLocations-1.0"
assert(LibStub, string.format("%s requires %s", LIB_NAME, "LibStub"))

local q
AchievementLocations = LibStub:NewLibrary(LIB_NAME, 1)
if not AchievementLocations then return end


local EMPTY = {}


AchievementLocations.byMap = AchievementLocations.byMap or {}
AchievementLocations.byID = nil


function AchievementLocations:AddLocation(mapFile, achievementID, x, y, options)
    local row
    if type(mapFile) == "table" then
        row = mapFile
        mapFile = row[1]
    else
        -- deprecated
        row = {mapFile, achievementID, x, y}
        row.criterion = options.criterion
        row.quest = options.quest
        row.faction = options.faction
        row.floor = options.floor
        row.action = options.action
        row.item = options.item
        row.note = options.note
        row.side = options.side
    end

    local map = self.byMap[mapFile]
    if not map then
        map = {}
        self.byMap[mapFile] = map
    end
    table.insert(map, row)
    -- if inverted index was built, add to that too
    if self.byID ~= nil then
        self:AddByID(row)
    end
end


function AchievementLocations:AddByID(row)
    local id = row[2]
    local locations = self.byID[id]
    if not locations then
        locations = {}
        self.byID[id] = locations
    end
    table.insert(locations, row)
end


function AchievementLocations:Get(mapFile)
    return self.byMap[mapFile]
end


function AchievementLocations:GetAchievement(achievementID)
    -- lazily build an inverted index
    if self.byID == nil then
        self.byID = {}
        for mapFile, rows in pairs(self.byMap) do
            for _, row in ipairs(rows) do
                self:AddByID(row)
            end
        end
    end
    return self.byID[achievementID] or {}
end
