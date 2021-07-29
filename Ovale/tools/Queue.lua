local __exports = LibStub:NewLibrary("ovale/tools/Queue", 90103)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local format = string.format
local BackToFrontIterator = __class(nil, {
    constructor = function(self, invariant, control)
        self.invariant = invariant
        self.control = control
    end,
    next = function(self)
        self.control = self.control - 1
        self.value = self.invariant[self.control]
        return self.control >= self.invariant.first
    end,
})
local FrontToBackIterator = __class(nil, {
    constructor = function(self, invariant, control)
        self.invariant = invariant
        self.control = control
    end,
    next = function(self)
        self.control = self.control + 1
        self.value = self.invariant[self.control]
        return self.control <= self.invariant.last
    end,
})
__exports.OvaleDequeue = __class(nil, {
    constructor = function(self, name)
        self.name = name
        self.first = 0
        self.last = -1
    end,
    insertFront = function(self, element)
        local first = self.first - 1
        self.first = first
        self[first] = element
    end,
    insertBack = function(self, element)
        local last = self.last + 1
        self.last = last
        self[last] = element
    end,
    removeFront = function(self)
        local first = self.first
        local element = self[first]
        if element then
            self[first] = nil
            self.first = first + 1
        end
        return element
    end,
    removeBack = function(self)
        local last = self.last
        local element = self[last]
        if element then
            self[last] = nil
            self.last = last - 1
        end
        return element
    end,
    at = function(self, index)
        if index > self:size() then
            return 
        end
        return self[self.first + index - 1]
    end,
    front = function(self)
        return self[self.first]
    end,
    back = function(self)
        return self[self.last]
    end,
    backToFrontIterator = function(self)
        return BackToFrontIterator(self, self.last + 1)
    end,
    frontToBackIterator = function(self)
        return FrontToBackIterator(self, self.first - 1)
    end,
    reset = function(self)
        local iterator = self:backToFrontIterator()
        while iterator:next() do
            self[iterator.control] = nil
        end
        self.first = 0
        self.last = -1
    end,
    size = function(self)
        return self.last - self.first + 1
    end,
    debuggingInfo = function(self)
        return format("Queue %s has %d item(s), first=%d, last=%d.", self.name, self:size(), self.first, self.last)
    end,
})
__exports.OvaleQueue = __class(__exports.OvaleDequeue, {
    insert = function(self, value)
        self:insertBack(value)
    end,
    remove = function(self)
        return self:removeFront()
    end,
    iterator = function(self)
        return self:frontToBackIterator()
    end,
})
__exports.OvaleStack = __class(__exports.OvaleDequeue, {
    push = function(self, value)
        self:insertBack(value)
    end,
    pop = function(self)
        return self:removeBack()
    end,
    top = function(self)
        return self:back()
    end,
})
