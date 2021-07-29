local __exports = LibStub:NewLibrary("ovale/states/BaseState", 90103)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local GetTime = GetTime
__exports.BaseState = __class(nil, {
    initializeState = function(self)
    end,
    resetState = function(self)
        self.currentTime = GetTime()
        self.defaultTarget = "target"
    end,
    cleanState = function(self)
    end,
    constructor = function(self)
        self.defaultTarget = "target"
        self.currentTime = 0
    end
})
