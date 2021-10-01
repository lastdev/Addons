local __exports = LibStub:NewLibrary("ovale/states/DemonHunterDemonic", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local aceEvent = __imports.aceEvent
local demonicTriggerId = {
    havoc = {
        [198013] = true
    },
    vengeance = {
        [212084] = true
    }
}
local metamorphosisId = {
    havoc = 191427,
    vengeance = 187827
}
__exports.OvaleDemonHunterDemonicClass = __class(nil, {
    constructor = function(self, aura, paperDoll, spellBook, ovale, debug)
        self.aura = aura
        self.paperDoll = paperDoll
        self.spellBook = spellBook
        self.ovale = ovale
        self.specialization = "havoc"
        self.hasDemonicTalent = false
        self.onEnable = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:RegisterMessage("Ovale_SpecializationChanged", self.onOvaleSpecializationChanged)
                local specialization = self.paperDoll:getSpecialization()
                self.onOvaleSpecializationChanged("onEnable", specialization, specialization)
            end
        end
        self.onDisable = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:UnregisterMessage("Ovale_SpecializationChanged")
                self.module:UnregisterMessage("Ovale_TalentsChanged")
                self.hasDemonicTalent = false
            end
        end
        self.onOvaleSpecializationChanged = function(event, newSpecialization, oldSpecialization)
            self.specialization = newSpecialization
            if newSpecialization == "havoc" or newSpecialization == "vengeance" then
                self.tracer:debug("Installing Demonic event handlers.")
                self.module:RegisterMessage("Ovale_TalentsChanged", self.onOvaleTalentsChanged)
                self.onOvaleTalentsChanged(event)
            else
                self.tracer:debug("Removing Demonic event handlers.")
                self.module:UnregisterMessage("Ovale_TalentsChanged")
                self.hasDemonicTalent = false
            end
        end
        self.onOvaleTalentsChanged = function(event)
            local hasDemonicTalent = self.hasDemonicTalent
            if self.specialization == "havoc" then
                self.hasDemonicTalent = self.spellBook:getTalentPoints(21900) > 0
            elseif self.specialization == "vengeance" then
                self.hasDemonicTalent = self.spellBook:getTalentPoints(22513) > 0
            else
                self.hasDemonicTalent = false
            end
            if hasDemonicTalent ~= self.hasDemonicTalent then
                if self.hasDemonicTalent then
                    self.tracer:debug("Gained Demonic talent.")
                else
                    self.tracer:debug("Lost Demonic talent.")
                end
            end
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, channel, spellcast)
            if self.hasDemonicTalent and demonicTriggerId[self.specialization][spellId] then
                local duration = 6 + ((channel and endCast - startCast) or 0)
                local atTime = (channel and startCast) or endCast
                self.triggerMetamorphosis(atTime, duration)
            end
        end
        self.triggerMetamorphosis = function(atTime, duration)
            local auraId = metamorphosisId[self.specialization]
            self.tracer:log("Triggering Demonic Metamorphosis (" .. auraId .. ").")
            self.aura:addAuraToGUID(self.ovale.playerGUID, auraId, self.ovale.playerGUID, "HELPFUL", nil, atTime, atTime + duration, atTime)
        end
        self.module = ovale:createModule("OvaleDemonHunterDemonic", self.onEnable, self.onDisable, aceEvent)
        self.tracer = debug:create(self.module:GetName())
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
    end,
    cleanState = function(self)
    end,
})
