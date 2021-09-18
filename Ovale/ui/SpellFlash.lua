local __exports = LibStub:NewLibrary("ovale/ui/SpellFlash", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__Localization = LibStub:GetLibrary("ovale/ui/Localization")
__imports.l = __imports.__Localization.l
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__lib_button_glow10 = LibStub:GetLibrary("LibButtonGlow-1.0", true)
__imports.HideOverlayGlow = __imports.__lib_button_glow10.HideOverlayGlow
__imports.ShowOverlayGlow = __imports.__lib_button_glow10.ShowOverlayGlow
local l = __imports.l
local aceEvent = __imports.aceEvent
local GetTime = GetTime
local UnitHasVehicleUI = UnitHasVehicleUI
local UnitExists = UnitExists
local UnitIsDead = UnitIsDead
local UnitCanAttack = UnitCanAttack
local HideOverlayGlow = __imports.HideOverlayGlow
local ShowOverlayGlow = __imports.ShowOverlayGlow
local colorMain = {
    r = nil,
    g = nil,
    b = nil
}
local colorShortCd = {
    r = nil,
    g = nil,
    b = nil
}
local colorCd = {
    r = nil,
    g = nil,
    b = nil
}
local colorInterrupt = {
    r = nil,
    g = nil,
    b = nil
}
__exports.OvaleSpellFlashClass = __class(nil, {
    constructor = function(self, ovaleOptions, ovale, combat, actionBar)
        self.ovaleOptions = ovaleOptions
        self.combat = combat
        self.actionBar = actionBar
        self.previousFrame = {}
        self.handleInitialize = function()
            self.module:RegisterMessage("Ovale_OptionChanged", self.handleOptionChanged)
            self.handleOptionChanged()
        end
        self.handleDisable = function()
            self.module:UnregisterMessage("Ovale_OptionChanged")
        end
        self.handleOptionChanged = function()
            local db = self.ovaleOptions.db.profile.apparence.spellFlash
            colorMain.r = db.colors.colorMain.r
            colorMain.g = db.colors.colorMain.g
            colorMain.b = db.colors.colorMain.b
            colorCd.r = db.colors.colorCd.r
            colorCd.g = db.colors.colorCd.g
            colorCd.b = db.colors.colorCd.b
            colorShortCd.r = db.colors.colorShortCd.r
            colorShortCd.g = db.colors.colorShortCd.g
            colorShortCd.b = db.colors.colorShortCd.b
            colorInterrupt.r = db.colors.colorInterrupt.r
            colorInterrupt.g = db.colors.colorInterrupt.g
            colorInterrupt.b = db.colors.colorInterrupt.b
        end
        self.module = ovale:createModule("OvaleSpellFlash", self.handleInitialize, self.handleDisable, aceEvent)
        self.ovaleOptions.apparence.args.spellFlash = self:getSpellFlashOptions()
    end,
    getSpellFlashOptions = function(self)
        return {
            type = "group",
            name = "SpellFlash",
            get = function(info)
                return self.ovaleOptions.db.profile.apparence.spellFlash[info[#info]]
            end,
            set = function(info, value)
                self.ovaleOptions.db.profile.apparence.spellFlash[info[#info]] = value
                self.module:SendMessage("Ovale_OptionChanged")
            end,
            args = {
                enabled = {
                    order = 10,
                    type = "toggle",
                    name = l["enabled"],
                    desc = l["flash_spells_help"],
                    width = "full"
                },
                inCombat = {
                    order = 10,
                    type = "toggle",
                    name = l["combat_only"],
                    disabled = function()
                        return  not self.ovaleOptions.db.profile.apparence.spellFlash.enabled
                    end
                },
                hasTarget = {
                    order = 20,
                    type = "toggle",
                    name = l["if_target"],
                    disabled = function()
                        return  not self.ovaleOptions.db.profile.apparence.spellFlash.enabled
                    end
                },
                hasHostileTarget = {
                    order = 30,
                    type = "toggle",
                    name = l["hide_if_dead_or_friendly_target"],
                    disabled = function()
                        return  not self.ovaleOptions.db.profile.apparence.spellFlash.enabled
                    end
                },
                hideInVehicle = {
                    order = 40,
                    type = "toggle",
                    name = l["hide_in_vehicles"],
                    disabled = function()
                        return  not self.ovaleOptions.db.profile.apparence.spellFlash.enabled
                    end
                },
                threshold = {
                    order = 70,
                    type = "range",
                    name = l["flash_threshold"],
                    desc = l["flash_time"],
                    min = 0,
                    max = 1000,
                    step = 1,
                    bigStep = 50,
                    disabled = function()
                        return  not self.ovaleOptions.db.profile.apparence.spellFlash.enabled
                    end
                }
            }
        }
    end,
    isSpellFlashEnabled = function(self)
        local enabled = true
        local db = self.ovaleOptions.db.profile.apparence.spellFlash
        if enabled and  not db.enabled then
            enabled = false
        end
        if enabled and db.inCombat and  not self.combat:isInCombat(nil) then
            enabled = false
        end
        if enabled and db.hideInVehicle and UnitHasVehicleUI("player") then
            enabled = false
        end
        if enabled and db.hasTarget and  not UnitExists("target") then
            enabled = false
        end
        if enabled and db.hasHostileTarget and (UnitIsDead("target") or  not UnitCanAttack("player", "target")) then
            enabled = false
        end
        return enabled
    end,
    hideFlash = function(self, index)
        if self.previousFrame[index] then
            HideOverlayGlow(self.previousFrame[index])
            self.previousFrame[index] = nil
        end
    end,
    flash = function(self, iconFlash, iconHelp, element, start, index)
        local db = self.ovaleOptions.db.profile.apparence.spellFlash
        local now = GetTime()
        if self:isSpellFlashEnabled() and start and start - now <= db.threshold / 1000 then
            if element.type == "action" and element.actionSlot then
                local frame = self.actionBar:getFrame(element.actionSlot)
                if self.previousFrame[index] ~= frame then
                    if self.previousFrame[index] then
                        HideOverlayGlow(self.previousFrame[index])
                    end
                    if frame then
                        ShowOverlayGlow(frame)
                    end
                    self.previousFrame[index] = frame
                end
            end
        end
    end,
})
