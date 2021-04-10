local __exports = LibStub:NewLibrary("ovale/Ovale", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __uiLocalization.l
local __tsaddon = LibStub:GetLibrary("tsaddon", true)
local NewAddon = __tsaddon.NewAddon
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local ipairs = ipairs
local wipe = wipe
local _G = _G
local UnitClass = UnitClass
local UnitGUID = UnitGUID
local huge = math.huge
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local clearOneTimeMessages = __toolstools.clearOneTimeMessages
local maxRefreshIntervals = 500
local refreshIntervals = {}
local refreshIndex = 1
local name = "Ovale"
local ovaleBase = NewAddon(name, aceEvent)
__exports.messagePrefix = name
__exports.OvaleClass = __class(ovaleBase, {
    constructor = function(self)
        self.playerClass = "WARRIOR"
        self.playerGUID = ""
        self.refreshNeeded = {}
        ovaleBase.constructor(self)
        _G["BINDING_HEADER_OVALE"] = "Ovale"
        local toggleCheckBox = l["check_box_tooltip"]
        _G["BINDING_NAME_OVALE_CHECKBOX0"] = toggleCheckBox .. "(1)"
        _G["BINDING_NAME_OVALE_CHECKBOX1"] = toggleCheckBox .. "(2)"
        _G["BINDING_NAME_OVALE_CHECKBOX2"] = toggleCheckBox .. "(3)"
        _G["BINDING_NAME_OVALE_CHECKBOX3"] = toggleCheckBox .. "(4)"
        _G["BINDING_NAME_OVALE_CHECKBOX4"] = toggleCheckBox .. "(5)"
    end,
    OnInitialize = function(self)
        self.playerGUID = UnitGUID("player") or "error"
        local _, classId = UnitClass("player")
        self.playerClass = classId or "WARRIOR"
        wipe(refreshIntervals)
        refreshIndex = 1
        clearOneTimeMessages()
    end,
    needRefresh = function(self)
        if self.playerGUID then
            self.refreshNeeded[self.playerGUID] = true
        end
    end,
    addRefreshInterval = function(self, milliseconds)
        if milliseconds < huge then
            refreshIntervals[refreshIndex] = milliseconds
            refreshIndex = (refreshIndex < maxRefreshIntervals and refreshIndex + 1) or 1
        end
    end,
    getRefreshIntervalStatistics = function(self)
        local sumRefresh, minRefresh, maxRefresh, count = 0, huge, 0, 0
        for _, v in ipairs(refreshIntervals) do
            if v > 0 then
                if minRefresh > v then
                    minRefresh = v
                end
                if maxRefresh < v then
                    maxRefresh = v
                end
                sumRefresh = sumRefresh + v
                count = count + 1
            end
        end
        local avgRefresh = (count > 0 and sumRefresh / count) or 0
        return avgRefresh, minRefresh, maxRefresh, count
    end,
    createModule = function(self, name, onInitialize, onRelease)
    end,
    createModule = function(self, name, onInitialize, onRelease, dep1)
    end,
    createModule = function(self, name, onInitialize, onRelease, dep1, dep2)
    end,
    createModule = function(self, name, onInitialize, onRelease, dep1, dep2, dep3)
    end,
    createModule = function(self, name, onInitialize, onRelease, dep1, dep2, dep3, dep4)
    end,
    createModule = function(self, name, onInitialize, onRelease, dep1, dep2, dep3, dep4)
        local ret = (self:NewModule(name, dep1, dep2, dep3, dep4))()
        ret.OnInitialize = onInitialize
        return ret
    end,
})
