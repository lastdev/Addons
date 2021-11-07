local __exports = LibStub:NewLibrary("ovale/states/Cooldown", 90112)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginestate = LibStub:GetLibrary("ovale/engine/state")
__imports.States = __imports.__enginestate.States
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
local aceEvent = __imports.aceEvent
local next = next
local pairs = pairs
local kpairs = pairs
local GetSpellCooldown = GetSpellCooldown
local GetTime = GetTime
local GetSpellCharges = GetSpellCharges
local States = __imports.States
local isNumber = __imports.isNumber
local globalCooldown = 61304
local cooldownThreshold = 0.1
local baseGcds = {
    ["DEATHKNIGHT"] = {
        [1] = 1.5,
        [2] = "base"
    },
    ["DEMONHUNTER"] = {
        [1] = 1.5,
        [2] = "base"
    },
    ["DRUID"] = {
        [1] = 1.5,
        [2] = "spell"
    },
    ["HUNTER"] = {
        [1] = 1.5,
        [2] = "base"
    },
    ["MAGE"] = {
        [1] = 1.5,
        [2] = "spell"
    },
    ["MONK"] = {
        [1] = 1,
        [2] = "none"
    },
    ["PALADIN"] = {
        [1] = 1.5,
        [2] = "spell"
    },
    ["PRIEST"] = {
        [1] = 1.5,
        [2] = "spell"
    },
    ["ROGUE"] = {
        [1] = 1,
        [2] = "none"
    },
    ["SHAMAN"] = {
        [1] = 1.5,
        [2] = "spell"
    },
    ["WARLOCK"] = {
        [1] = 1.5,
        [2] = "spell"
    },
    ["WARRIOR"] = {
        [1] = 1.5,
        [2] = "base"
    }
}
__exports.CooldownData = __class(nil, {
    constructor = function(self)
        self.cd = {}
    end
})
__exports.OvaleCooldownClass = __class(States, {
    constructor = function(self, ovalePaperDoll, ovaleData, lastSpell, ovale, ovaleDebug)
        self.ovalePaperDoll = ovalePaperDoll
        self.ovaleData = ovaleData
        self.lastSpell = lastSpell
        self.ovale = ovale
        self.serial = 0
        self.sharedCooldown = {}
        self.gcd = {
            serial = 0,
            start = 0,
            duration = 0
        }
        self.handleInitialize = function()
            self.module:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", self.update)
            self.module:RegisterEvent("BAG_UPDATE_COOLDOWN", self.update)
            self.module:RegisterEvent("PET_BAR_UPDATE_COOLDOWN", self.update)
            self.module:RegisterEvent("SPELL_UPDATE_CHARGES", self.update)
            self.module:RegisterEvent("SPELL_UPDATE_USABLE", self.update)
            self.module:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", self.update)
            self.module:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", self.update)
            self.module:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", self.handleUnitSpellCastInterrupted)
            self.module:RegisterEvent("UNIT_SPELLCAST_START", self.update)
            self.module:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", self.update)
            self.module:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN", self.update)
            self.lastSpell:registerSpellcastInfo(self)
        end
        self.handleDisable = function()
            self.lastSpell:unregisterSpellcastInfo(self)
            self.module:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
            self.module:UnregisterEvent("BAG_UPDATE_COOLDOWN")
            self.module:UnregisterEvent("PET_BAR_UPDATE_COOLDOWN")
            self.module:UnregisterEvent("SPELL_UPDATE_CHARGES")
            self.module:UnregisterEvent("SPELL_UPDATE_USABLE")
            self.module:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
            self.module:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
            self.module:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
            self.module:UnregisterEvent("UNIT_SPELLCAST_START")
            self.module:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
            self.module:UnregisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
        end
        self.handleUnitSpellCastInterrupted = function(event, unit)
            if unit == "player" or unit == "pet" then
                self.update(event, unit)
                self.tracer:debug("Resetting global cooldown.")
                local cd = self.gcd
                cd.start = 0
                cd.duration = 0
            end
        end
        self.update = function(event, unit)
            if  not unit or unit == "player" or unit == "pet" then
                self.serial = self.serial + 1
                self.ovale:needRefresh()
                self.tracer:debug(event, self.serial)
            end
        end
        self.copySpellcastInfo = function(spellcast, dest)
            if spellcast.offgcd then
                dest.offgcd = spellcast.offgcd
            end
        end
        self.saveSpellcastInfo = function(spellcast, atTime)
            local spellId = spellcast.spellId
            if spellId then
                local gcd = self.ovaleData:getSpellInfoProperty(spellId, spellcast.start, "gcd", spellcast.targetGuid)
                if gcd and gcd == 0 then
                    spellcast.offgcd = true
                end
            end
        end
        self.applySpellStartCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            if isChanneled then
                self:applyCooldown(spellId, targetGUID, startCast)
            end
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            if  not isChanneled then
                self:applyCooldown(spellId, targetGUID, endCast)
            end
        end
        States.constructor(self, __exports.CooldownData)
        self.module = ovale:createModule("OvaleCooldown", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create("OvaleCooldown")
    end,
    resetSharedCooldowns = function(self)
        for _, spellTable in pairs(self.sharedCooldown) do
            for spellId in pairs(spellTable) do
                spellTable[spellId] = nil
            end
        end
    end,
    isSharedCooldown = function(self, name)
        local spellTable = self.sharedCooldown[name]
        return spellTable and next(spellTable) ~= nil
    end,
    addSharedCooldown = function(self, name, spellId)
        self.sharedCooldown[name] = self.sharedCooldown[name] or {}
        self.sharedCooldown[name][spellId] = true
    end,
    getGlobalCooldown = function(self, now)
        local cd = self.gcd
        if  not cd.start or  not cd.serial or cd.serial < self.serial then
            now = now or GetTime()
            if now >= cd.start + cd.duration then
                cd.start, cd.duration = GetSpellCooldown(globalCooldown)
            end
        end
        return cd.start, cd.duration
    end,
    getSpellCooldown = function(self, spellId, atTime)
        if atTime then
            local cd = self:getCD(spellId, atTime)
            return cd.start, cd.duration, cd.enable
        end
        local cdStart, cdDuration, cdEnable = 0, 0, true
        if self.sharedCooldown[spellId] then
            for id in pairs(self.sharedCooldown[spellId]) do
                local start, duration, enable = self:getSpellCooldown(id, atTime)
                if start then
                    cdStart, cdDuration, cdEnable = start, duration, enable
                    break
                end
            end
        else
            local start, duration, enable = GetSpellCooldown(spellId)
            self.tracer:log("Call GetSpellCooldown which returned %f, %f, %d", start, duration, enable)
            if start ~= nil and start > 0 then
                local gcdStart, gcdDuration = self:getGlobalCooldown()
                self.tracer:log("GlobalCooldown is %d, %d", gcdStart, gcdDuration)
                if start + duration > gcdStart + gcdDuration then
                    cdStart, cdDuration, cdEnable = start, duration, enable
                else
                    cdStart = start + duration
                    cdDuration = 0
                    cdEnable = enable
                end
            else
                cdStart, cdDuration, cdEnable = start or 0, duration or 0, enable
            end
        end
        return cdStart - cooldownThreshold, cdDuration, cdEnable
    end,
    getBaseGCD = function(self)
        local gcd, haste
        local baseGCD = baseGcds[self.ovale.playerClass]
        if baseGCD then
            gcd, haste = baseGCD[1], baseGCD[2]
        else
            gcd, haste = 1.5, "spell"
        end
        return gcd, haste
    end,
    getCD = function(self, spellId, atTime)
        local cdName = spellId
        local si = self.ovaleData.spellInfo[spellId]
        if si and si.shared_cd then
            cdName = si.shared_cd
        end
        if  not self.next.cd[cdName] then
            self.next.cd[cdName] = {
                start = 0,
                duration = 0,
                enable = false,
                chargeDuration = 0,
                chargeStart = 0,
                charges = 0,
                maxCharges = 0
            }
        end
        local cd = self.next.cd[cdName]
        if  not cd.start or  not cd.serial or cd.serial < self.serial then
            self.tracer:log("Didn't find an existing cd in next, look for one in current")
            local start, duration, enable = self:getSpellCooldown(spellId, nil)
            if si and si.forcecd then
                start, duration = self:getSpellCooldown(si.forcecd, nil)
            end
            self.tracer:log("It returned %f, %f", start, duration)
            cd.serial = self.serial
            cd.start = start - cooldownThreshold
            cd.duration = duration
            cd.enable = enable
            if isNumber(spellId) then
                local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(spellId)
                if charges then
                    cd.charges = charges
                    cd.maxCharges = maxCharges
                    cd.chargeStart = chargeStart
                    cd.chargeDuration = chargeDuration
                end
            end
        end
        local now = atTime
        if cd.start then
            if cd.start + cd.duration <= now then
                self.tracer:log("Spell cooldown is in the past")
                cd.start = 0
                cd.duration = 0
            end
        end
        if cd.charges then
            local charges = cd.charges
            local maxCharges = cd.maxCharges
            local chargeStart = cd.chargeStart
            local chargeDuration = cd.chargeDuration
            while chargeStart + chargeDuration <= now and charges < maxCharges do
                chargeStart = chargeStart + chargeDuration
                charges = charges + 1
            end
            cd.charges = charges
            cd.chargeStart = chargeStart
        end
        self.tracer:log("Cooldown of spell %d is %f + %f", spellId, cd.start, cd.duration)
        return cd
    end,
    getSpellCooldownDuration = function(self, spellId, atTime, targetGUID)
        local start, duration = self:getSpellCooldown(spellId, atTime)
        if duration > 0 and start + duration > atTime then
            self.tracer:log("Spell %d is on cooldown for %fs starting at %s.", spellId, duration, start)
        else
            duration = self.ovaleData:getSpellInfoPropertyNumber(spellId, atTime, "cd", targetGUID)
            if duration ~= nil then
                if duration < 0 then
                    duration = 0
                end
            else
                duration = 0
            end
            self.tracer:log("Spell %d has a base cooldown of %fs.", spellId, duration)
            if duration > 0 then
                local haste = self.ovaleData:getSpellInfoProperty(spellId, atTime, "cd_haste", targetGUID)
                if haste then
                    local multiplier = self.ovalePaperDoll:getBaseHasteMultiplier(atTime)
                    duration = duration / multiplier
                end
            end
        end
        return duration
    end,
    getSpellCharges = function(self, spellId, atTime)
        local cd = self:getCD(spellId, atTime)
        local charges = cd.charges
        local maxCharges = cd.maxCharges
        local chargeStart = cd.chargeStart
        local chargeDuration = cd.chargeDuration
        if charges then
            while chargeStart + chargeDuration <= atTime and charges < maxCharges do
                chargeStart = chargeStart + chargeDuration
                charges = charges + 1
            end
        end
        return charges, maxCharges, chargeStart, chargeDuration
    end,
    initializeState = function(self)
        self.next.cd = {}
    end,
    resetState = function(self)
        for _, cd in pairs(self.next.cd) do
            cd.serial = nil
        end
    end,
    cleanState = function(self)
        for spellId, cd in pairs(self.next.cd) do
            for k in kpairs(cd) do
                cd[k] = nil
            end
            self.next.cd[spellId] = nil
        end
    end,
    applyCooldown = function(self, spellId, targetGUID, atTime)
        local cd = self:getCD(spellId, atTime)
        local duration = self:getSpellCooldownDuration(spellId, atTime, targetGUID)
        if duration == 0 then
            cd.start = 0
            cd.duration = 0
            cd.enable = true
        else
            cd.start = atTime
            cd.duration = duration
            cd.enable = true
        end
        if cd.charges and cd.charges > 0 then
            cd.chargeStart = cd.start
            cd.charges = cd.charges - 1
            if cd.charges == 0 then
                cd.duration = cd.chargeDuration
            end
        end
        self.tracer:log("Spell %d cooldown info: start=%f, duration=%f, charges=%s", spellId, cd.start, cd.duration, cd.charges or "(nil)")
    end,
    debugCooldown = function(self)
        for spellId, cd in pairs(self.next.cd) do
            if cd.start then
                if cd.charges then
                    self.tracer:print("Spell %s cooldown: start=%f, duration=%f, charges=%d, maxCharges=%d, chargeStart=%f, chargeDuration=%f", spellId, cd.start, cd.duration, cd.charges, cd.maxCharges, cd.chargeStart, cd.chargeDuration)
                else
                    self.tracer:print("Spell %s cooldown: start=%f, duration=%f", spellId, cd.start, cd.duration)
                end
            end
        end
    end,
})
