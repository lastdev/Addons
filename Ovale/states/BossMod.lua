local __exports = LibStub:NewLibrary("ovale/states/BossMod", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local UnitExists = UnitExists
local UnitClassification = UnitClassification
local _G = _G
local hooksecurefunc = hooksecurefunc
local bigWigsLoader = _G["BigWigsLoader"]
local dbmClass = _G["DBM"]
__exports.OvaleBossModClass = __class(nil, {
    constructor = function(self, ovale, ovaleDebug, combat)
        self.combat = combat
        self.engagedDBM = nil
        self.engagedBigWigs = nil
        self.handleInitialize = function()
            if dbmClass then
                self.tracer:debug("DBM is loaded")
                hooksecurefunc(dbmClass, "StartCombat", function(dbm, mod, delay, event, ...)
                    if event ~= "TIMER_RECOVERY" then
                        self.engagedDBM = mod
                    end
                end)
                hooksecurefunc(dbmClass, "EndCombat", function(dbm, mod)
                    self.engagedDBM = nil
                end)
            end
            if bigWigsLoader then
                self.tracer:debug("BigWigs is loaded")
                bigWigsLoader.RegisterMessage(self, "BigWigs_OnBossEngage", function(_, mod, diff)
                    self.engagedBigWigs = mod
                end)
                bigWigsLoader.RegisterMessage(self, "BigWigs_OnBossDisable", function(_, mod)
                    self.engagedBigWigs = nil
                end)
            end
        end
        self.module = ovale:createModule("BossMod", self.handleInitialize, self.handleDisable)
        self.tracer = ovaleDebug:create(self.module:GetName())
    end,
    handleDisable = function(self)
    end,
    isBossEngaged = function(self, atTime)
        if  not self.combat:isInCombat(atTime) then
            return false
        end
        local dbmEngaged = dbmClass ~= nil and self.engagedDBM ~= nil and self.engagedDBM.inCombat
        local bigWigsEngaged = bigWigsLoader ~= nil and self.engagedBigWigs ~= nil and self.engagedBigWigs.isEngaged
        local neitherEngaged = dbmClass == nil and bigWigsLoader == nil and self:scanTargets()
        if dbmEngaged then
            self.tracer:debug("DBM Engaged: [name=%s]", self.engagedDBM.localization.general.name)
        end
        if bigWigsEngaged then
            self.tracer:debug("BigWigs Engaged: [name=%s]", self.engagedBigWigs.displayName)
        end
        return dbmEngaged or bigWigsEngaged or neitherEngaged
    end,
    scanTargets = function(self)
        local bossEngaged = false
        if UnitExists("target") then
            bossEngaged = UnitClassification("target") == "worldboss" or false
        end
        return bossEngaged
    end,
})
