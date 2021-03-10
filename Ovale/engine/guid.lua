local __exports = LibStub:NewLibrary("ovale/engine/guid", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local floor = math.floor
local ipairs = ipairs
local setmetatable = setmetatable
local type = type
local unpack = unpack
local insert = table.insert
local remove = table.remove
local GetTime = GetTime
local UnitGUID = UnitGUID
local UnitName = UnitName
local __condition = LibStub:GetLibrary("ovale/engine/condition")
local returnConstant = __condition.returnConstant
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isString = __toolstools.isString
local petUnits = {}
do
    petUnits["player"] = "pet"
    for i = 1, 5, 1 do
        petUnits["arena" .. i] = "arenapet" .. i
    end
    for i = 1, 4, 1 do
        petUnits["party" .. i] = "partypet" .. i
    end
    for i = 1, 40, 1 do
        petUnits["raid" .. i] = "raidpet" .. i
    end
    setmetatable(petUnits, {
        __index = function(t, unitId)
            return unitId .. "pet"
        end

    })
end
local unitAuraUnits = {}
do
    insert(unitAuraUnits, "player")
    insert(unitAuraUnits, "pet")
    insert(unitAuraUnits, "vehicle")
    insert(unitAuraUnits, "target")
    insert(unitAuraUnits, "focus")
    for i = 1, 40, 1 do
        local unitId = "raid" .. i
        insert(unitAuraUnits, unitId)
        insert(unitAuraUnits, petUnits[unitId])
    end
    for i = 1, 4, 1 do
        local unitId = "party" .. i
        insert(unitAuraUnits, unitId)
        insert(unitAuraUnits, petUnits[unitId])
    end
    for i = 1, 4, 1 do
        insert(unitAuraUnits, "boss" .. i)
    end
    for i = 1, 5, 1 do
        local unitId = "arena" .. i
        insert(unitAuraUnits, unitId)
        insert(unitAuraUnits, petUnits[unitId])
    end
    insert(unitAuraUnits, "npc")
end
local unitAuraUnit = {}
for i, unitId in ipairs(unitAuraUnits) do
    unitAuraUnit[unitId] = i
end
setmetatable(unitAuraUnit, {
    __index = function(t, unitId)
        return #unitAuraUnits + 1
    end

})
local function compareDefault(a, b)
    return a < b
end
local function isCompareFunction(a)
    return type(a) == "function"
end
local function binaryInsert(t, value, unique, compare)
    if isCompareFunction(unique) then
        unique, compare = false, unique
    end
    compare = compare or compareDefault
    local low, high = 1, #t
    while low <= high do
        local mid = floor((low + high) / 2)
        if compare(value, t[mid]) then
            high = mid - 1
        elseif  not unique or compare(t[mid], value) then
            low = mid + 1
        else
            return mid
        end
    end
    insert(t, low, value)
    return low
end
local function binarySearch(t, value, compare)
    compare = compare or compareDefault
    local low, high = 1, #t
    while low <= high do
        local mid = floor((low + high) / 2)
        if compare(value, t[mid]) then
            high = mid - 1
        elseif compare(t[mid], value) then
            low = mid + 1
        else
            return mid
        end
    end
    return nil
end
local function binaryRemove(t, value, compare)
    local index = binarySearch(t, value, compare)
    if index then
        remove(t, index)
    end
    return index
end
local compareUnit = function(a, b)
    return unitAuraUnit[a] < unitAuraUnit[b]
end

__exports.Guids = __class(nil, {
    constructor = function(self, ovale, ovaleDebug, condition)
        self.ovale = ovale
        self.unitGUID = {}
        self.guidUnit = {}
        self.unitName = {}
        self.nameUnit = {}
        self.guidName = {}
        self.nameGUID = {}
        self.petGUID = {}
        self.unitAuraUnits = unitAuraUnit
        self.getGuid = function(_, namedParameters)
            local target = (isString(namedParameters.target) and namedParameters.target) or "target"
            return returnConstant(self:getUnitGUID(target))
        end
        self.getTargetGuid = function(_, namedParameters)
            local target = (isString(namedParameters.target) and namedParameters.target) or "target"
            return returnConstant(self:getUnitGUID(target .. "target"))
        end
        self.handleInitialize = function()
            self.module:RegisterEvent("ARENA_OPPONENT_UPDATE", self.handleArenaOpponentUpdated)
            self.module:RegisterEvent("GROUP_ROSTER_UPDATE", self.handleGroupRosterUpdated)
            self.module:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", self.handleInstanceEncounterEngageUnit)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", function(event)
                return self:updateAllUnits()
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
            if eventType ~= "cleared" or self.unitGUID[unitId] then
                self.tracer:debug(event, unitId, eventType)
                self:updateUnitWithTarget(unitId)
            end
        end
        self.handleGroupRosterUpdated = function(event)
            self.tracer:debug(event)
            self:updateAllUnits()
            self.module:SendMessage("Ovale_GroupChanged")
        end
        self.handleInstanceEncounterEngageUnit = function(event)
            self.tracer:debug(event)
            for i = 1, 4, 1 do
                self:updateUnitWithTarget("boss" .. i)
            end
        end
        self.handlePlayerFocusChanged = function(event)
            self.tracer:debug(event)
            self:updateUnitWithTarget("focus")
        end
        self.handlePlayerTargetChanged = function(event, cause)
            self.tracer:debug(event, cause)
            self:updateUnit("target")
        end
        self.handleUnitNameUpdate = function(event, unitId)
            self.tracer:debug(event, unitId)
            self:updateUnit(unitId)
        end
        self.handleUnitPet = function(event, unitId)
            self.tracer:debug(event, unitId)
            local pet = petUnits[unitId]
            self:updateUnitWithTarget(pet)
            if unitId == "player" then
                local guid = self:getUnitGUID("pet")
                if guid then
                    self.petGUID[guid] = GetTime()
                end
                self.module:SendMessage("Ovale_PetChanged", guid)
            end
            self.module:SendMessage("Ovale_GroupChanged")
        end
        self.handleUnitTarget = function(event, unitId)
            if unitId ~= "player" then
                self.tracer:debug(event, unitId)
                local target = unitId .. "target"
                self:updateUnit(target)
            end
        end
        self.module = ovale:createModule("OvaleGUID", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
        condition:registerCondition("guid", false, self.getGuid)
        condition:registerCondition("targetguid", false, self.getTargetGuid)
    end,
    updateAllUnits = function(self)
        for _, unitId in ipairs(unitAuraUnits) do
            self:updateUnitWithTarget(unitId)
        end
    end,
    updateUnit = function(self, unitId)
        local guid = UnitGUID(unitId)
        local name = UnitName(unitId)
        local previousGUID = self.unitGUID[unitId]
        local previousName = self.unitName[unitId]
        if  not guid or guid ~= previousGUID then
            self.unitGUID[unitId] = nil
            if previousGUID then
                if self.guidUnit[previousGUID] then
                    binaryRemove(self.guidUnit[previousGUID], unitId, compareUnit)
                end
                self.ovale.refreshNeeded[previousGUID] = true
            end
        end
        if  not name or name ~= previousName then
            self.unitName[unitId] = nil
            if previousName and self.nameUnit[previousName] then
                binaryRemove(self.nameUnit[previousName], unitId, compareUnit)
            end
        end
        if guid and guid == previousGUID and name and name ~= previousName then
            self.guidName[guid] = nil
            if previousName and self.nameGUID[previousName] then
                binaryRemove(self.nameGUID[previousName], guid, compareUnit)
            end
        end
        if guid and guid ~= previousGUID then
            self.unitGUID[unitId] = guid
            do
                local list = self.guidUnit[guid] or {}
                binaryInsert(list, unitId, true, compareUnit)
                self.guidUnit[guid] = list
            end
            self.tracer:debug("'%s' is '%s'.", unitId, guid)
            self.ovale.refreshNeeded[guid] = true
        end
        if name and name ~= previousName then
            self.unitName[unitId] = name
            do
                local list = self.nameUnit[name] or {}
                binaryInsert(list, unitId, true, compareUnit)
                self.nameUnit[name] = list
            end
            self.tracer:debug("'%s' is '%s'.", unitId, name)
        end
        if guid and name then
            local previousNameFromGUID = self.guidName[guid]
            self.guidName[guid] = name
            if name ~= previousNameFromGUID then
                local list = self.nameGUID[name] or {}
                binaryInsert(list, guid, true)
                self.nameGUID[name] = list
                if guid == previousGUID then
                    self.tracer:debug("'%s' changed names to '%s'.", guid, name)
                else
                    self.tracer:debug("'%s' is '%s'.", guid, name)
                end
            end
        end
        if guid and guid ~= previousGUID then
            self.module:SendMessage("Ovale_UnitChanged", unitId, guid)
        end
    end,
    updateUnitWithTarget = function(self, unitId)
        self:updateUnit(unitId)
        self:updateUnit(unitId .. "target")
    end,
    isPlayerPet = function(self, guid)
        local atTime = self.petGUID[guid]
        return  not  not atTime, atTime
    end,
    getUnitGUID = function(self, unitId)
        return self.unitGUID[unitId] or UnitGUID(unitId)
    end,
    getUnitByGuid = function(self, guid)
        if guid and self.guidUnit[guid] then
            return unpack(self.guidUnit[guid])
        end
        return nil
    end,
    getUnitName = function(self, unitId)
        if unitId then
            return self.unitName[unitId] or UnitName(unitId)
        end
        return nil
    end,
    getUnitByName = function(self, name)
        if name and self.nameUnit[name] then
            return unpack(self.nameUnit[name])
        end
        return nil
    end,
    getNameByGuid = function(self, guid)
        if guid then
            return self.guidName[guid]
        end
        return nil
    end,
    getGuidByName = function(self, name)
        if name and self.nameGUID[name] then
            return unpack(self.nameGUID[name])
        end
        return 
    end,
})
