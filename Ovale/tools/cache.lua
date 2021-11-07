local __exports = LibStub:NewLibrary("ovale/tools/cache", 90112)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__list = LibStub:GetLibrary("ovale/tools/list")
__imports.List = __imports.__list.List
local List = __imports.List
local Cache = __class(nil, {
    constructor = function(self, size)
        self.size = size
        self.nodeByValue = {}
        self.list = __imports.List()
    end,
    isFull = function(self)
        return self.list.length >= self.size
    end,
    newest = function(self)
        return self.list:back()
    end,
    oldest = function(self)
        return self.list:front()
    end,
    asArray = function(self)
        return self.list:asArray()
    end,
    evict = function(self)
        return self.list:shift()
    end,
    put = function(self, value)
        self:remove(value)
        local evicted = (self:isFull() and self:evict()) or nil
        local key = value
        self.nodeByValue[key] = self.list:push(value)
        return evicted
    end,
    remove = function(self, value)
        local key = value
        local node = self.nodeByValue[key]
        if node then
            self.list:remove(node)
        end
    end,
})
__exports.LRUCache = __class(Cache, {
    evict = function(self)
        return self.list:shift()
    end,
})
__exports.MRUCache = __class(Cache, {
    evict = function(self)
        return self.list:pop()
    end,
})
