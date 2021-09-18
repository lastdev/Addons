local __exports = LibStub:NewLibrary("ovale/engine/guid", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__toolsarray = LibStub:GetLibrary("ovale/tools/array")
__imports.binaryInsertUnique = __imports.__toolsarray.binaryInsertUnique
__imports.binaryRemove = __imports.__toolsarray.binaryRemove
__imports.__toolscache = LibStub:GetLibrary("ovale/tools/cache")
__imports.LRUCache = __imports.__toolscache.LRUCache
local aceEvent = __imports.aceEvent
local ipairs = ipairs
local pairs = pairs
local unpack = unpack
local concat = table.concat
local insert = table.insert
local sort = table.sort
local GetUnitName = GetUnitName
local UnitGUID = UnitGUID
local UnitIsUnit = UnitIsUnit
local binaryInsertUnique = __imports.binaryInsertUnique
local binaryRemove = __imports.binaryRemove
local LRUCache = __imports.LRUCache
local function dumpMapping(t, output)
    for key, array in pairs(t) do
        local size = #array
        if size > 1 then
            insert(output, "    " .. key .. ": {")
            for _, value in ipairs(array) do
                insert(output, "        " .. value .. ",")
            end
            insert(output, [[    },]])
        elseif size == 1 then
            insert(output, "    " .. key .. ": " .. array[1] .. ",")
        end
    end
end
__exports.Guids = __class(nil, {
    constructor = function(self, ovale, debug)
        self.ovale = ovale
        self.guidByUnit = {}
        self.unitByGUID = {}
        self.nameByUnit = {}
        self.unitByName = {}
        self.nameByGUID = {}
        self.guidByName = {}
        self.ownerGUIDByGUID = {}
        self.childUnitByUnit = {}
        self.petUnitByUnit = {}
        self.eventfulUnits = {}
        self.unitPriority = {}
        self.unitAuraUnits = {}
        self.petGUID = {}
        self.debugGUIDs = {
            type = "group",
            name = "GUID",
            args = {
                guid = {
                    type = "input",
                    name = "GUID",
                    multiline = 25,
                    width = "full",
                    get = function()
                        local output = {}
                        insert(output, "Unit by GUID = {")
                        dumpMapping(self.unitByGUID, output)
                        insert(output, "}\n")
                        insert(output, "Unit by Name = {")
                        dumpMapping(self.unitByName, output)
                        insert(output, "}\n")
                        insert(output, "GUID by Name = {")
                        dumpMapping(self.guidByName, output)
                        insert(output, "}\n")
                        insert(output, "Unused GUIDs = {")
                        local guids = self.unusedGUIDCache:asArray()
                        sort(guids)
                        for _, guid in ipairs(guids) do
                            insert(output, "    " .. guid)
                        end
                        insert(output, "}")
                        return concat(output, "\n")
                    end
                }
            }
        }
        self.handleInitialize = function()
            self.module:RegisterEvent("ARENA_OPPONENT_UPDATE", self.handleArenaOpponentUpdated)
            self.module:RegisterEvent("GROUP_ROSTER_UPDATE", self.handleGroupRosterUpdated)
            self.module:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", self.handleInstanceEncounterEngageUnit)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", function(event)
                return self.updateAllUnits()
            end)
            self.module:RegisterEvent("PLAYER_FOCUS_CHANGED", self.handlePlayerFocusChanged)
            self.module:RegisterEvent("PLAYER_TARGET_CHANGED", self.handlePlayerTargetChanged)
            self.module:RegisterEvent("UNIT_NAME_UPDATE", self.handleUnitNameUpdate)
            self.module:RegisterEvent("UNIT_PET", self.handleUnitPet)
            self.module:RegisterEvent("UNIT_TARGET", self.handleUnitTarget)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("ARENA_OPPONENT_UPDATE")
            self.module:UnregisterEvent("GROUP_ROSTER_UPDATE")
            self.module:UnregisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("PLAYER_FOCUS_CHANGED")
            self.module:UnregisterEvent("PLAYER_TARGET_CHANGED")
            self.module:UnregisterEvent("UNIT_NAME_UPDATE")
            self.module:UnregisterEvent("UNIT_PET")
            self.module:UnregisterEvent("UNIT_TARGET")
        end
        self.handleArenaOpponentUpdated = function(event, unitId, eventType)
            if eventType ~= "cleared" or self.guidByUnit[unitId] then
                self.tracer:debug(event, unitId, eventType)
                self.updateUnitWithTarget(unitId)
            end
        end
        self.handleGroupRosterUpdated = function(event)
            self.tracer:debug(event)
            self.updateAllUnits()
            self.module:SendMessage("Ovale_GroupChanged")
        end
        self.handleInstanceEncounterEngageUnit = function(event)
            self.tracer:debug(event)
            for i = 1, 5, 1 do
                self.updateUnitWithTarget("boss" .. i)
            end
        end
        self.handlePlayerFocusChanged = function(event)
            self.tracer:debug(event)
            self.updateUnitWithTarget("focus")
        end
        self.handlePlayerTargetChanged = function(event, cause)
            self.tracer:debug(event, cause)
            self.updateUnit("target")
        end
        self.handleUnitNameUpdate = function(event, unitId)
            self.tracer:debug(event, unitId)
            self.updateUnit(unitId)
        end
        self.handleUnitPet = function(event, unit)
            self.tracer:debug(event, unit)
            local petUnit = self.getPetUnitByUnit(unit)
            self.addChildUnit(unit, petUnit)
            self.updateUnitWithTarget(petUnit)
            local petGUID = self.guidByUnit[petUnit]
            if petGUID then
                local guid = self.guidByUnit[unit]
                self.tracer:debug("Ovale_PetChanged", guid, unit, petGUID, petUnit)
                self.mapOwnerGUIDToGUID(guid, petGUID)
                self.module:SendMessage("Ovale_PetChanged", guid, unit, petGUID, petUnit)
            end
            self.module:SendMessage("Ovale_GroupChanged")
        end
        self.handleUnitTarget = function(event, unit)
            if unit ~= "player" and  not UnitIsUnit(unit, "player") then
                self.tracer:debug(event, unit)
                local targetUnit = self.getTargetUnitByUnit(unit)
                self.addChildUnit(unit, targetUnit)
                self.updateUnit(targetUnit)
            end
        end
        self.updateAllUnits = function()
            for _, unitId in ipairs(self.eventfulUnits) do
                self.updateUnitWithTarget(unitId)
            end
        end
        self.getOwnerGUIDByGUID = function(guid)
            return self.ownerGUIDByGUID[guid]
        end
        self.getPetUnitByUnit = function(unit)
            return self.petUnitByUnit[unit] or unit .. "pet"
        end
        self.getTargetUnitByUnit = function(unit)
            return (unit == "player" and "target") or unit .. "target"
        end
        self.addChildUnit = function(unit, childUnit)
            local t = self.childUnitByUnit[unit] or {}
            if  not t[childUnit] then
                t[childUnit] = true
                self.childUnitByUnit[unit] = t
            end
        end
        self.getUnitPriority = function(unit)
            local t = self.unitPriority
            local priority = t[unit]
            if  not priority then
                priority = #t + 1
                t[unit] = priority
            end
            return priority
        end
        self.compareUnit = function(a, b)
            return self.getUnitPriority(a) < self.getUnitPriority(b)
        end
        self.mapOwnerGUIDToGUID = function(ownerGUID, guid)
            self.ownerGUIDByGUID[guid] = ownerGUID
            if ownerGUID == self.ovale.playerGUID then
                self.petGUID[guid] = true
            end
        end
        self.mapNameToUnit = function(name, unit)
            self.nameByUnit[unit] = name
            local t = self.unitByName[name] or {}
            binaryInsertUnique(t, unit, self.compareUnit)
            self.unitByName[name] = t
        end
        self.unmapNameToUnit = function(name, unit)
            self.nameByUnit[unit] = nil
            local t = self.unitByName[name] or {}
            if t then
                binaryRemove(t, unit, self.compareUnit)
                if #t == 0 then
                    self.unitByName[name] = nil
                end
            end
        end
        self.mapNameToGUID = function(name, guid)
            self.nameByGUID[guid] = name
            local t = self.guidByName[name] or {}
            binaryInsertUnique(t, guid)
            self.guidByName[name] = t
        end
        self.unmapNameToGUID = function(name, guid)
            self.nameByGUID[guid] = nil
            local t = self.guidByName[name] or {}
            if t then
                binaryRemove(t, guid)
                if #t == 0 then
                    self.guidByName[name] = nil
                end
            end
        end
        self.mapGUIDToUnit = function(guid, unit)
            self.guidByUnit[unit] = guid
            local t = self.unitByGUID[guid] or {}
            binaryInsertUnique(t, unit, self.compareUnit)
            self.unitByGUID[guid] = t
            self.unusedGUIDCache:remove(guid)
        end
        self.unmapGUIDToUnit = function(guid, unit)
            self.guidByUnit[unit] = nil
            local t = self.unitByGUID[guid] or {}
            if t then
                binaryRemove(t, unit, self.compareUnit)
                if #t == 0 then
                    self.unitByGUID[unit] = nil
                    local evictedGUID = self.unusedGUIDCache:put(guid)
                    if evictedGUID then
                        local name = self.nameByGUID[evictedGUID]
                        if name then
                            self.unmapNameToGUID(name, evictedGUID)
                        end
                        self.ownerGUIDByGUID[evictedGUID] = nil
                        self.petGUID[evictedGUID] = nil
                        self.module:SendMessage("Ovale_UnusedGUID", evictedGUID)
                    end
                end
            end
        end
        self.unmapUnit = function(unit)
            local children = self.childUnitByUnit[unit]
            if children then
                for childUnit in pairs(children) do
                    children[childUnit] = nil
                    self.unmapUnit(childUnit)
                end
            end
            local guid = self.guidByUnit[unit]
            if guid then
                self.unmapGUIDToUnit(guid, unit)
            end
            local name = self.nameByUnit[unit]
            if name then
                self.unmapNameToUnit(name, unit)
            end
        end
        self.updateUnit = function(unit, guid, changed)
            guid = guid or UnitGUID(unit)
            local name = GetUnitName(unit, true)
            if guid and name then
                local updated = false
                local oldGUID = self.guidByUnit[unit]
                local oldName = self.nameByUnit[unit]
                if guid ~= oldGUID then
                    if oldGUID then
                        self.unmapGUIDToUnit(oldGUID, unit)
                    end
                    self.tracer:debug("'" .. unit .. "' is '" .. guid .. "'")
                    self.mapGUIDToUnit(guid, unit)
                    updated = true
                    self.ovale.refreshNeeded[guid] = true
                end
                if name ~= oldName then
                    if oldName then
                        self.unmapNameToUnit(oldName, unit)
                        if guid == oldGUID then
                            self.unmapNameToGUID(oldName, guid)
                        end
                    end
                    self.tracer:debug("'" .. unit .. "' is '" .. name .. "'")
                    self.mapNameToUnit(name, unit)
                    updated = true
                end
                if updated then
                    local nameByGUID = self.nameByGUID[guid]
                    if  not nameByGUID then
                        self.tracer:debug("'" .. guid .. "' is '" .. name .. "'")
                        self.mapNameToGUID(name, guid)
                    elseif name ~= nameByGUID then
                        self.tracer:debug("'" .. guid .. "' changed names to '" .. name .. "'")
                        self.mapNameToGUID(name, guid)
                    end
                    if changed then
                        changed[guid] = unit
                    else
                        self.tracer:debug("Ovale_UnitChanged", unit, guid, name)
                        self.module:SendMessage("Ovale_UnitChanged", unit, guid, name)
                    end
                end
            else
                self.unmapUnit(unit)
            end
        end
        self.updateUnitWithTarget = function(unit, guid, changed)
            self.updateUnit(unit, guid, changed)
            local targetUnit = self.getTargetUnitByUnit(unit)
            local targetGUID = self:getUnitGUID(targetUnit)
            if targetGUID then
                self.addChildUnit(unit, targetUnit)
                self.updateUnit(targetUnit, targetGUID, changed)
            end
        end
        debug.defaultOptions.args["guid"] = self.debugGUIDs
        self.module = ovale:createModule("OvaleGUID", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = debug:create(self.module:GetName())
        self.unusedGUIDCache = __imports.LRUCache(100)
        self.petUnitByUnit["player"] = "pet"
        insert(self.eventfulUnits, "player")
        insert(self.eventfulUnits, "vehicle")
        insert(self.eventfulUnits, "pet")
        for i = 1, 40, 1 do
            local unit = "raid" .. i
            local petUnit = "raidpet" .. i
            self.petUnitByUnit[unit] = petUnit
            insert(self.eventfulUnits, unit)
            insert(self.eventfulUnits, petUnit)
        end
        for i = 1, 4, 1 do
            local unit = "party" .. i
            local petUnit = "partypet" .. i
            self.petUnitByUnit[unit] = petUnit
            insert(self.eventfulUnits, unit)
            insert(self.eventfulUnits, petUnit)
        end
        for i = 1, 3, 1 do
            local unit = "arena" .. i
            local petUnit = "arenapet" .. i
            self.petUnitByUnit[unit] = petUnit
            insert(self.eventfulUnits, unit)
            insert(self.eventfulUnits, petUnit)
        end
        for i = 1, 5, 1 do
            insert(self.eventfulUnits, [[boss{i}]])
        end
        insert(self.eventfulUnits, "target")
        insert(self.eventfulUnits, "focus")
        for priority, unit in ipairs(self.eventfulUnits) do
            self.unitAuraUnits[unit] = true
            self.unitPriority[unit] = priority
        end
    end,
    getUnitGUID = function(self, unitId)
        return self.guidByUnit[unitId] or UnitGUID(unitId)
    end,
    getUnitByGUID = function(self, guid)
        if guid and self.unitByGUID[guid] then
            return unpack(self.unitByGUID[guid])
        end
        return nil
    end,
    getUnitName = function(self, unitId)
        if unitId then
            return self.nameByUnit[unitId] or GetUnitName(unitId, true)
        end
        return nil
    end,
    getUnitByName = function(self, name)
        if name and self.unitByName[name] then
            return unpack(self.unitByName[name])
        end
        return nil
    end,
    getNameByGUID = function(self, guid)
        if guid then
            return self.nameByGUID[guid]
        end
        return nil
    end,
    getGUIDByName = function(self, name)
        if name and self.guidByName[name] then
            return unpack(self.guidByName[name])
        end
        return 
    end,
})
