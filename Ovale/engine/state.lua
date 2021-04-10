local __exports = LibStub:NewLibrary("ovale/engine/state", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __toolsQueue = LibStub:GetLibrary("ovale/tools/Queue")
local OvaleQueue = __toolsQueue.OvaleQueue
__exports.States = __class(nil, {
    constructor = function(self, c)
        self.current = c()
        self.next = c()
    end,
    getState = function(self, atTime)
        if  not atTime then
            return self.current
        end
        return self.next
    end,
})
__exports.OvaleStateClass = __class(nil, {
    registerState = function(self, stateAddon)
        self.stateAddons:insert(stateAddon)
    end,
    unregisterState = function(self, stateAddon)
        local stateModules = OvaleQueue("OvaleState_stateModules")
        while self.stateAddons:size() > 0 do
            local addon = self.stateAddons:remove()
            if stateAddon ~= addon then
                stateModules:insert(addon)
            end
        end
        self.stateAddons = stateModules
        stateAddon:cleanState()
    end,
    initializeState = function(self)
        local iterator = self.stateAddons:iterator()
        while iterator:next() do
            iterator.value:initializeState()
        end
    end,
    resetState = function(self)
        local iterator = self.stateAddons:iterator()
        while iterator:next() do
            iterator.value:resetState()
        end
    end,
    applySpellStartCast = function(self, spellId, targetGUID, startCast, endCast, channel, spellcast)
        local iterator = self.stateAddons:iterator()
        while iterator:next() do
            if iterator.value.applySpellStartCast then
                iterator.value.applySpellStartCast(spellId, targetGUID, startCast, endCast, channel, spellcast)
            end
        end
    end,
    applySpellAfterCast = function(self, spellId, targetGUID, startCast, endCast, channel, spellcast)
        local iterator = self.stateAddons:iterator()
        while iterator:next() do
            if iterator.value.applySpellAfterCast then
                iterator.value.applySpellAfterCast(spellId, targetGUID, startCast, endCast, channel, spellcast)
            end
        end
    end,
    applySpellOnHit = function(self, spellId, targetGUID, startCast, endCast, channel, spellcast)
        local iterator = self.stateAddons:iterator()
        while iterator:next() do
            if iterator.value.applySpellOnHit then
                iterator.value.applySpellOnHit(spellId, targetGUID, startCast, endCast, channel, spellcast)
            end
        end
    end,
    constructor = function(self)
        self.stateAddons = OvaleQueue("OvaleState_stateAddons")
    end
})
