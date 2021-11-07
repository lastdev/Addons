local __exports = LibStub:NewLibrary("ovale/engine/lexer", 90112)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__toolsQueue = LibStub:GetLibrary("ovale/tools/Queue")
__imports.Queue = __imports.__toolsQueue.Queue
local Queue = __imports.Queue
local ipairs = ipairs
local kpairs = pairs
local wrap = coroutine.wrap
local find = string.find
local sub = string.sub
__exports.OvaleLexer = __class(nil, {
    constructor = function(self, name, stream, matches, filter)
        self.name = name
        self.typeQueue = __imports.Queue()
        self.tokenQueue = __imports.Queue()
        self.endOfStream = nil
        self.finished = false
        self.iterator = self:scan(stream, matches, filter)
    end,
    scan = function(self, s, matches, filter)
        local me = self
        local lex = function()
            if s == "" then
                return 
            end
            local sz = #s
            local idx = 1
            while true do
                for _, m in ipairs(matches) do
                    local pat = m[1]
                    local fun = m[2]
                    local i1, i2 = find(s, pat, idx)
                    if i1 then
                        local tok = sub(s, i1, i2)
                        idx = i2 + 1
                        if  not filter or (fun ~= filter.comments and fun ~= filter.space) then
                            me.finished = idx > sz
                            local res1, res2 = fun(tok)
                            coroutine.yield(res1, res2)
                        end
                        break
                    end
                end
            end
        end

        return wrap(lex)
    end,
    release = function(self)
        for key in kpairs(self) do
            self[key] = nil
        end
    end,
    consume = function(self, index)
        index = index or 1
        local tokenType, token
        while index > 0 and self.typeQueue.length > 0 do
            tokenType = self.typeQueue:shift()
            token = self.tokenQueue:shift()
            if  not tokenType then
                break
            end
            index = index - 1
        end
        while index > 0 do
            tokenType, token = self.iterator()
            if  not tokenType then
                break
            end
            index = index - 1
        end
        return tokenType, token
    end,
    peek = function(self, index)
        index = index or 1
        local tokenType, token
        while index > self.typeQueue.length do
            if self.endOfStream then
                break
            else
                tokenType, token = self.iterator()
                if  not tokenType or  not token then
                    self.endOfStream = true
                    break
                end
                self.typeQueue:push(tokenType)
                self.tokenQueue:push(token)
            end
        end
        if index <= self.typeQueue.length then
            tokenType = self.typeQueue:at(index)
            token = self.tokenQueue:at(index)
        end
        return tokenType, token
    end,
})
