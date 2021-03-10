local __exports = LibStub:NewLibrary("tslib", 10301)
if not __exports then return end
local setmetatable = setmetatable
__exports.newClass = function(base, prototype)
    local c = prototype
    if base then
        if  not base.constructor then
            base.constructor = function()
            end
        end
    else
        if  not c.constructor then
            c.constructor = function()
            end
        end
    end
    c.__index = c
    setmetatable(c, {
        __call = function(cls, ...)
            local self = (setmetatable({}, cls))
            self:constructor(...)
            return self
        end,
        __index = base
    })
    return c
end
local nilWrap = {}
local falseWrap = {}
__exports.ternaryWrap = function(value)
    return ((value == nil and nilWrap) or (value == false and falseWrap) or value)
end
__exports.ternaryUnwrap = function(value)
    if value == nilWrap then
        return nil
    elseif value == falseWrap then
        return false
    else
        return value
    end
end
