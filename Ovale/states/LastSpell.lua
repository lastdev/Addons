local __exports = LibStub:NewLibrary("ovale/states/LastSpell", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__toolsPool = LibStub:GetLibrary("ovale/tools/Pool")
__imports.OvalePool = __imports.__toolsPool.OvalePool
local OvalePool = __imports.OvalePool
local pairs = pairs
local remove = table.remove
local insert = table.insert
__exports.createSpellCast = function()
    return {
        spellId = 0,
        stop = 0,
        start = 0,
        queued = 0,
        targetGuid = "unknown",
        targetName = "target",
        spellName = "Unknown spell"
    }
end
__exports.lastSpellCastPool = __imports.OvalePool("OvaleFuture_pool")
__exports.LastSpell = __class(nil, {
    lastInFlightSpell = function(self)
        local spellcast = nil
        if self.lastGCDSpellcast.success then
            spellcast = self.lastGCDSpellcast
        end
        for i = #self.queue, 1, -1 do
            local sc = self.queue[i]
            if sc.success then
                if spellcast == nil or spellcast.success == nil or spellcast.success < sc.success then
                    spellcast = sc
                end
                break
            end
        end
        return spellcast
    end,
    copySpellcastInfo = function(self, spellcast, dest)
        for _, mod in pairs(self.modules) do
            if mod.copySpellcastInfo then
                mod.copySpellcastInfo(spellcast, dest)
            end
        end
    end,
    saveSpellcastInfo = function(self, spellcast, atTime)
        for _, mod in pairs(self.modules) do
            if mod.saveSpellcastInfo then
                mod.saveSpellcastInfo(spellcast, atTime)
            end
        end
    end,
    registerSpellcastInfo = function(self, mod)
        insert(self.modules, mod)
    end,
    unregisterSpellcastInfo = function(self, mod)
        for i = #self.modules, 1, -1 do
            if self.modules[i] == mod then
                remove(self.modules, i)
            end
        end
    end,
    lastSpellSent = function(self)
        local spellcast = nil
        if self.lastGCDSpellcast.success then
            spellcast = self.lastGCDSpellcast
        end
        for i = #self.queue, 1, -1 do
            local sc = self.queue[i]
            if sc.success then
                if  not spellcast or (spellcast.success and spellcast.success < sc.success) or ( not spellcast.success and spellcast.queued and spellcast.queued < sc.success) then
                    spellcast = sc
                end
            elseif  not sc.start and  not sc.stop and sc.queued then
                if  not spellcast or (spellcast.success and spellcast.success < sc.queued) then
                    spellcast = sc
                elseif spellcast.queued and spellcast.queued < sc.queued then
                    spellcast = sc
                end
            end
        end
        return spellcast
    end,
    constructor = function(self)
        self.lastSpellcast = nil
        self.lastGCDSpellcast = __exports.createSpellCast()
        self.queue = {}
        self.modules = {}
    end
})
