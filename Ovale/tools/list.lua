local __exports = LibStub:NewLibrary("ovale/tools/list", 90112)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local ipairs = ipairs
local ListBackToFrontIterator = __class(nil, {
    constructor = function(self, list)
        self.remaining = 0
        self.node = list.head
        self.remaining = list.length
    end,
    next = function(self)
        if self.node and self.remaining > 0 then
            self.node = self.node.prev
            self.value = self.node.value
            self.remaining = self.remaining - 1
            return self.remaining >= 0
        end
        return false
    end,
    replace = function(self, value)
        if self.node then
            self.node.value = value
            self.value = value
        end
    end,
})
local ListFrontToBackIterator = __class(nil, {
    constructor = function(self, list)
        self.remaining = 0
        self.node = (list.head and list.head.prev) or nil
        self.remaining = list.length
    end,
    next = function(self)
        if self.node and self.remaining > 0 then
            self.node = self.node.next
            self.value = self.node.value
            self.remaining = self.remaining - 1
            return self.remaining >= 0
        end
        return false
    end,
    replace = function(self, value)
        if self.node then
            self.node.value = value
            self.value = value
        end
    end,
})
__exports.ListNode = __class(nil, {
    constructor = function(self, value)
        self.value = value
        self.next = self
        self.prev = self
    end,
})
__exports.List = __class(nil, {
    constructor = function(self)
        self.length = 0
        self.head = nil
    end,
    isEmpty = function(self)
        return self.length == 0
    end,
    front = function(self)
        return (self.head and self.head.value) or nil
    end,
    back = function(self)
        return (self.head and self.head.prev.value) or nil
    end,
    clear = function(self)
        self.head = nil
        self.length = 0
    end,
    backToFrontIterator = function(self)
        return ListBackToFrontIterator(self)
    end,
    frontToBackIterator = function(self)
        return ListFrontToBackIterator(self)
    end,
    fromArray = function(self, t)
        for _, value in ipairs(t) do
            self:push(value)
        end
    end,
    asArray = function(self, reverse)
        local t = {}
        local iterator = (reverse == true and self:backToFrontIterator()) or self:frontToBackIterator()
        do
            local i = 1
            while iterator:next() do
                t[i] = iterator.value
                i = i + 1
            end
        end
        return t
    end,
    nodeOf = function(self, value)
        local node = self.head
        local index = 1
        if node then
            do
                local remains = self.length
                while remains > 0 do
                    if node.value == value then
                        return node, index
                    end
                    node = node.next
                    index = index + 1
                    remains = remains - 1
                end
            end
        end
        return nil, nil
    end,
    nodeAt = function(self, index)
        local length = self.length
        if length > 0 then
            while index > length do
                index = index - length
            end
            while index < 1 do
                index = index + length
            end
            if self.head then
                local node = self.head
                if index <= length - index then
                    do
                        local remains = index - 1
                        while remains > 0 do
                            node = node.next
                            remains = remains - 1
                        end
                    end
                else
                    do
                        local remains = length - index + 1
                        while remains > 0 do
                            node = node.prev
                            remains = remains - 1
                        end
                    end
                end
                return node
            end
        end
        return nil
    end,
    insertAfter = function(self, node, value)
        if node then
            local head = self.head
            self.head = node.next
            self:unshift(value)
            self.head = head
        end
    end,
    insertBefore = function(self, node, value)
        if node then
            local head = self.head
            if node == head then
                self:unshift(value)
            else
                self.head = node
                self:push(value)
                self.head = head
            end
        end
    end,
    remove = function(self, node)
        if node then
            local head = self.head
            self.head = node.next
            self:pop()
            if self.head and head ~= node then
                self.head = head
            end
        end
    end,
    indexOf = function(self, value)
        local _, index = self:nodeOf(value)
        return index or 0
    end,
    at = function(self, index)
        local node = self:nodeAt(index)
        return (node and node.value) or nil
    end,
    insertAt = function(self, index, value)
        local node = self:nodeAt(index)
        if node then
            self:insertBefore(node, value)
        end
    end,
    removeAt = function(self, index)
        local node = self:nodeAt(index)
        if node then
            self:remove(node)
            return node.value
        end
        return nil
    end,
    replaceAt = function(self, index, value)
        local node = self:nodeAt(index)
        if node then
            node.value = value
        end
    end,
    push = function(self, value)
        local node = __exports.ListNode(value)
        if  not self.head then
            self.head = node
        else
            node.next = self.head
            node.prev = self.head.prev
            self.head.prev.next = node
            self.head.prev = node
        end
        self.length = self.length + 1
        return node
    end,
    pop = function(self)
        if self.head then
            local node = self.head.prev
            local value = node.value
            if node == self.head then
                self.head = nil
                self.length = 0
            else
                node.prev.next = self.head
                self.head.prev = node.prev
                self.length = self.length - 1
            end
            return value
        end
        return nil
    end,
    unshift = function(self, value)
        self:push(value)
        if self.head then
            self.head = self.head.prev
        end
        return self.head
    end,
    shift = function(self)
        local value = self:front()
        if self.head then
            self:remove(self.head)
        end
        return value
    end,
})
