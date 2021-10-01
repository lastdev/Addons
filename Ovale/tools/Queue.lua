local __exports = LibStub:NewLibrary("ovale/tools/Queue", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local ipairs = ipairs
local DequeBackToFrontIterator = __class(nil, {
    constructor = function(self, deque)
        self.deque = deque
        self.index = 0
        self.remaining = 0
        self.index = deque.indexAfter(deque.last)
        self.remaining = deque.length
    end,
    next = function(self)
        if self.deque.length == 0 then
            return false
        end
        self.index = self.deque.indexBefore(self.index)
        self.value = self.deque.buffer[self.index]
        self.remaining = self.remaining - 1
        return self.remaining >= 0
    end,
    replace = function(self, value)
        self.deque.buffer[self.index] = value
        self.value = value
    end,
})
local DequeFrontToBackIterator = __class(nil, {
    constructor = function(self, deque)
        self.deque = deque
        self.index = 0
        self.remaining = 0
        self.index = deque.indexBefore(deque.first)
        self.remaining = deque.length
    end,
    next = function(self)
        if self.deque.length == 0 then
            return false
        end
        self.index = self.deque.indexAfter(self.index)
        self.value = self.deque.buffer[self.index]
        self.remaining = self.remaining - 1
        return self.remaining >= 0
    end,
    replace = function(self, value)
        self.deque.buffer[self.index] = value
        self.value = value
    end,
})
__exports.Deque = __class(nil, {
    constructor = function(self, capacity, fixed)
        self.capacity = 0
        self.canGrow = true
        self.buffer = {}
        self.first = 0
        self.last = 0
        self.length = 0
        self.indexAfter = function(index)
            return (index < self.capacity and index + 1) or 1
        end
        self.indexBefore = function(index)
            return (index > 1 and index - 1) or self.capacity
        end
        self.capacity = (capacity and capacity > 0 and capacity) or 1
        self.canGrow = fixed == nil or  not fixed
    end,
    isEmpty = function(self)
        return self.length == 0
    end,
    isFull = function(self)
        return  not self.canGrow and self.length == self.capacity
    end,
    front = function(self)
        return (self.length > 0 and self.buffer[self.first]) or nil
    end,
    back = function(self)
        return (self.length > 0 and self.buffer[self.last]) or nil
    end,
    clear = function(self)
        self.first = 0
        self.last = 0
        self.length = 0
    end,
    backToFrontIterator = function(self)
        return DequeBackToFrontIterator(self)
    end,
    frontToBackIterator = function(self)
        return DequeFrontToBackIterator(self)
    end,
    fromArray = function(self, t)
        local length = #t
        if length > 0 then
            local buffer = self.buffer
            for i, value in ipairs(t) do
                buffer[i] = value
            end
            if self.capacity < length then
                self.capacity = length
            end
            self.first = 1
            self.last = length
            self.length = length
        else
            self.first = 0
            self.last = 0
            self.length = 0
        end
    end,
    asArray = function(self, reverse)
        local t = {}
        local index = 1
        local iterator = (reverse == true and self:backToFrontIterator()) or self:frontToBackIterator()
        while iterator:next() do
            t[index] = iterator.value
            index = index + 1
        end
        return t
    end,
    indexOf = function(self, value, from)
        local buffer = self.buffer
        local capacity = self.capacity
        local index = from or 1
        local mappedIndex = self.first + index - 1
        local remaining = self.length - index + 1
        while remaining > 0 do
            if buffer[mappedIndex] == value then
                return index
            end
            index = index + 1
            mappedIndex = (mappedIndex < capacity and mappedIndex + 1) or 1
            remaining = remaining - 1
        end
        return 0
    end,
    at = function(self, index)
        if 1 <= index and index <= self.length then
            index = self.first + index - 1
            if index > self.capacity then
                index = index - self.capacity
            end
            return self.buffer[index]
        end
        return nil
    end,
    removeAt = function(self, index)
        if index == 1 then
            self:shift()
        elseif index == self.length then
            self:pop()
        elseif 1 < index and index < self.length then
            local buffer = self.buffer
            local first = self.first
            local last = self.last
            local length = self.length
            local mappedIndex = first + index - 1
            if last > first then
                if index - 1 > length - index then
                    local i = mappedIndex
                    while i < last do
                        buffer[i] = buffer[i + 1]
                        i = i + 1
                    end
                    buffer[last] = nil
                    self.last = self.last - 1
                else
                    local i = mappedIndex
                    while i > first do
                        buffer[i] = buffer[i - 1]
                        i = i - 1
                    end
                    buffer[first] = nil
                    self.first = self.first + 1
                end
            else
                if mappedIndex > self.capacity then
                    local i = mappedIndex - self.capacity
                    while i < last do
                        buffer[i] = buffer[i + 1]
                        i = i + 1
                    end
                    buffer[last] = nil
                    self.last = self.last - 1
                else
                    local i = mappedIndex
                    while i > first do
                        buffer[i] = buffer[i - 1]
                        i = i - 1
                    end
                    buffer[first] = nil
                    self.first = self.first + 1
                end
            end
            self.length = self.length - 1
        end
    end,
    replaceAt = function(self, index, value)
        if 1 <= index and index <= self.length then
            index = self.first + index - 1
            if index > self.capacity then
                index = index - self.capacity
            end
            self.buffer[index] = value
        end
    end,
    grow = function(self, capacity)
        capacity = capacity or 2 * self.capacity
        if capacity > self.capacity and self.last < self.first then
            local shift = capacity - self.capacity
            local buffer = self.buffer
            local first = self.first
            local i = self.capacity
            while i >= first do
                buffer[i + shift] = buffer[i]
                buffer[i] = nil
                i = i - 1
            end
            self.first = self.first + shift
        end
        self.capacity = capacity
    end,
    push = function(self, value)
        if self.length == 0 then
            self.length = 1
            self.first = 1
            self.last = 1
            self.buffer[1] = value
        else
            if self.length < self.capacity then
                self.length = self.length + 1
            elseif self.canGrow then
                self:grow()
                self.length = self.length + 1
            else
                self.first = self.indexAfter(self.first)
            end
            self.last = self.indexAfter(self.last)
            self.buffer[self.last] = value
        end
    end,
    pop = function(self)
        if self.length > 0 then
            local value = self.buffer[self.last]
            if self.length == 1 then
                self.length = 0
                self.first = 0
                self.last = 0
            else
                self.length = self.length - 1
                self.last = self.indexBefore(self.last)
            end
            return value
        end
        return nil
    end,
    unshift = function(self, value)
        if self.length == 0 then
            self.length = 1
            self.first = 1
            self.last = 1
            self.buffer[1] = value
        else
            if self.length < self.capacity then
                self.length = self.length + 1
            elseif self.canGrow then
                self:grow()
                self.length = self.length + 1
            else
                self.last = self.indexBefore(self.last)
            end
            self.first = self.indexBefore(self.first)
            self.buffer[self.first] = value
        end
    end,
    shift = function(self)
        if self.length > 0 then
            local value = self.buffer[self.first]
            if self.length == 1 then
                self.length = 0
                self.first = 0
                self.last = 0
            else
                self.first = self.indexAfter(self.first)
                self.length = self.length - 1
            end
            return value
        end
        return nil
    end,
})
__exports.Queue = __class(__exports.Deque, {
    iterator = function(self)
        return self:frontToBackIterator()
    end,
})
__exports.Stack = __class(__exports.Deque, {
    top = function(self)
        return __exports.Deque.constructor:back()
    end,
    iterator = function(self)
        return self:backToFrontIterator()
    end,
})
