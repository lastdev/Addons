local __exports = LibStub:NewLibrary("ovale/tools/TimeSpan", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local select = select
local wipe = wipe
local format = string.format
local concat = table.concat
local insert = table.insert
local remove = table.remove
local huge = math.huge
local infinity = huge
local timeSpanPool = {}
local poolSize = 0
local poolUnused = 0
local compareIntervals = function(startA, endA, startB, endB)
    if startA == startB and endA == endB then
        return 0
    elseif startA < startB and endA >= startB and endA <= endB then
        return -1
    elseif startB < startA and endB >= startA and endB <= endA then
        return 1
    elseif (startA == startB and endA > endB) or (startA < startB and endA == endB) or (startA < startB and endA > endB) then
        return -2
    elseif (startB == startA and endB > endA) or (startB < startA and endB == endA) or (startB < startA and endB > endA) then
        return 2
    elseif endA <= startB then
        return -3
    elseif endB <= startA then
        return 3
    end
    return 99
end

__exports.newTimeSpan = function()
    local obj = remove(timeSpanPool)
    if obj then
        poolUnused = poolUnused - 1
    else
        obj = __exports.OvaleTimeSpan()
        poolSize = poolSize + 1
    end
    return obj
end
__exports.newFromArgs = function(...)
    return __exports.newTimeSpan():copy(...)
end
__exports.newTimeSpanFromArray = function(a)
    if a then
        return __exports.newTimeSpan():copyFromArray(a)
    else
        return __exports.newTimeSpan()
    end
end
__exports.releaseTimeSpans = function(...)
    local argc = select("#", ...)
    for i = 1, argc, 1 do
        local a = select(i, ...)
        wipe(a)
        insert(timeSpanPool, a)
    end
    poolUnused = poolUnused + argc
end
__exports.getPoolInfo = function()
    return poolSize, poolUnused
end
__exports.OvaleTimeSpan = __class(nil, {
    release = function(self)
        wipe(self)
        insert(timeSpanPool, self)
        poolUnused = poolUnused + 1
    end,
    __tostring = function(self)
        if #self == 0 then
            return "empty set"
        else
            return format("(%s)", concat(self, ", "))
        end
    end,
    toString = function(self)
        return self:__tostring()
    end,
    copyFromArray = function(self, a)
        local count = #a
        for i = 1, count, 1 do
            self[i] = a[i]
        end
        local length = #self
        for i = count + 1, length, 1 do
            self[i] = nil
        end
        return self
    end,
    copy = function(self, ...)
        local count = select("#", ...)
        for i = 1, count, 1 do
            self[i] = select(i, ...)
        end
        local length = #self
        for i = count + 1, length, 1 do
            self[i] = nil
        end
        return self
    end,
    isEmpty = function(self)
        return #self == 0
    end,
    isUniverse = function(self)
        return self[1] == 0 and self[2] == infinity
    end,
    equals = function(self, b)
        local a = self
        local countA = #a
        local countB = (b and #b) or 0
        if countA ~= countB then
            return false
        end
        for k = 1, countA, 1 do
            if a[k] ~= b[k] then
                return false
            end
        end
        return true
    end,
    hasTime = function(self, atTime)
        local a = self
        for i = 1, #a, 2 do
            if a[i] <= atTime and atTime < a[i + 1] then
                return true
            end
        end
        return false
    end,
    nextTime = function(self, atTime)
        local a = self
        for i = 1, #a, 2 do
            if atTime < a[i] then
                return a[i]
            elseif a[i] <= atTime and atTime <= a[i + 1] then
                return atTime
            end
        end
    end,
    measure = function(self)
        local a = self
        local measure = 0
        for i = 1, #a, 2 do
            measure = measure + (a[i + 1] - a[i])
        end
        return measure
    end,
    complement = function(self, result)
        local a = self
        local countA = #a
        if countA == 0 then
            if result then
                result:copyFromArray(__exports.universe)
            else
                result = __exports.newTimeSpanFromArray(__exports.universe)
            end
        else
            result = result or __exports.newTimeSpan()
            local countResult = 0
            local i, k = 1, 1
            if a[i] == 0 then
                i = i + 1
            else
                result[k] = 0
                countResult = k
                k = k + 1
            end
            while i < countA do
                result[k] = a[i]
                countResult = k
                i, k = i + 1, k + 1
            end
            if a[i] < infinity then
                result[k], result[k + 1] = a[i], infinity
                countResult = k + 1
            end
            for j = countResult + 1, #result, 1 do
                result[j] = nil
            end
        end
        return result
    end,
    intersectInterval = function(self, startB, endB, result)
        local a = self
        local countA = #a
        result = result or __exports.newTimeSpan()
        if countA > 0 then
            local countResult = 0
            local i, k = 1, 1
            while true do
                if i > countA then
                    break
                end
                local startA, endA = a[i], a[i + 1]
                local compare = compareIntervals(startA, endA, startB, endB)
                if compare == 0 then
                    result[k], result[k + 1] = startA, endA
                    countResult = k + 1
                    break
                elseif compare == -1 then
                    if endA > startB then
                        result[k], result[k + 1] = startB, endA
                        countResult = k + 1
                        i, k = i + 2, k + 2
                    else
                        i = i + 2
                    end
                elseif compare == 1 then
                    if endB > startA then
                        result[k], result[k + 1] = startA, endB
                        countResult = k + 1
                    end
                    break
                elseif compare == -2 then
                    result[k], result[k + 1] = startB, endB
                    countResult = k + 1
                    break
                elseif compare == 2 then
                    result[k], result[k + 1] = startA, endA
                    countResult = k + 1
                    i, k = i + 2, k + 2
                elseif compare == -3 then
                    i = i + 2
                elseif compare == 3 then
                    break
                end
            end
            for n = countResult + 1, #result, 1 do
                result[n] = nil
            end
        end
        return result
    end,
    intersect = function(self, b, result)
        local a = self
        local countA = #a
        local countB = (b and #b) or 0
        result = result or __exports.newTimeSpan()
        local countResult = 0
        if countA > 0 and countB > 0 then
            local i, j, k = 1, 1, 1
            while true do
                if i > countA or j > countB then
                    break
                end
                local startA, endA = a[i], a[i + 1]
                local startB, endB = b[j], b[j + 1]
                local compare = compareIntervals(startA, endA, startB, endB)
                if compare == 0 then
                    result[k], result[k + 1] = startA, endA
                    countResult = k + 1
                    i, j, k = i + 2, j + 2, k + 2
                elseif compare == -1 then
                    if endA > startB then
                        result[k], result[k + 1] = startB, endA
                        countResult = k + 1
                        i, k = i + 2, k + 2
                    else
                        i = i + 2
                    end
                elseif compare == 1 then
                    if endB > startA then
                        result[k], result[k + 1] = startA, endB
                        countResult = k + 1
                        j, k = j + 2, k + 2
                    else
                        j = j + 2
                    end
                elseif compare == -2 then
                    result[k], result[k + 1] = startB, endB
                    countResult = k + 1
                    j, k = j + 2, k + 2
                elseif compare == 2 then
                    result[k], result[k + 1] = startA, endA
                    countResult = k + 1
                    i, k = i + 2, k + 2
                elseif compare == -3 then
                    i = i + 2
                elseif compare == 3 then
                    j = j + 2
                else
                    i = i + 2
                    j = j + 2
                end
            end
        end
        for n = countResult + 1, #result, 1 do
            result[n] = nil
        end
        return result
    end,
    union = function(self, b, result)
        local a = self
        local countA = #a
        local countB = (b and #b) or 0
        if countA == 0 then
            if b then
                if result then
                    result:copyFromArray(b)
                else
                    result = __exports.newTimeSpanFromArray(b)
                end
            else
                result = __exports.emptySet
            end
        elseif countB == 0 then
            if result then
                result:copyFromArray(a)
            else
                result = __exports.newTimeSpanFromArray(a)
            end
        else
            result = result or __exports.newTimeSpan()
            local countResult = 0
            local i, j, k = 1, 1, 1
            local startTemp, endTemp = a[i], a[i + 1]
            local holdingA = true
            local scanningA = false
            while true do
                local startA, endA, startB, endB
                if i > countA and j > countB then
                    result[k], result[k + 1] = startTemp, endTemp
                    countResult = k + 1
                    k = k + 2
                    break
                end
                if scanningA and i > countA then
                    holdingA =  not holdingA
                    scanningA =  not scanningA
                else
                    startA, endA = a[i], a[i + 1]
                end
                if  not scanningA and j > countB then
                    holdingA =  not holdingA
                    scanningA =  not scanningA
                else
                    startB, endB = b[j], b[j + 1]
                end
                local startCurrent = (scanningA and startA) or startB or 0
                local endCurrent = (scanningA and endA) or endB or 0
                local compare = compareIntervals(startTemp, endTemp, startCurrent, endCurrent)
                if compare == 0 then
                    if scanningA then
                        i = i + 2
                    else
                        j = j + 2
                    end
                elseif compare == -2 then
                    if scanningA then
                        i = i + 2
                    else
                        j = j + 2
                    end
                elseif compare == -1 then
                    endTemp = endCurrent
                    if scanningA then
                        i = i + 2
                    else
                        j = j + 2
                    end
                elseif compare == 1 then
                    startTemp = startCurrent
                    if scanningA then
                        i = i + 2
                    else
                        j = j + 2
                    end
                elseif compare == 2 then
                    startTemp, endTemp = startCurrent, endCurrent
                    holdingA =  not holdingA
                    scanningA =  not scanningA
                    if scanningA then
                        i = i + 2
                    else
                        j = j + 2
                    end
                elseif compare == -3 then
                    if holdingA == scanningA then
                        result[k], result[k + 1] = startTemp, endTemp
                        countResult = k + 1
                        startTemp, endTemp = startCurrent, endCurrent
                        scanningA =  not scanningA
                        k = k + 2
                    else
                        scanningA =  not scanningA
                        if scanningA then
                            i = i + 2
                        else
                            j = j + 2
                        end
                    end
                elseif compare == 3 then
                    startTemp, endTemp = startCurrent, endCurrent
                    holdingA =  not holdingA
                    scanningA =  not scanningA
                else
                    i = i + 2
                    j = j + 2
                end
            end
            for n = countResult + 1, #result, 1 do
                result[n] = nil
            end
        end
        return result
    end,
})
__exports.universe = __exports.newFromArgs(0, infinity)
__exports.emptySet = __exports.newTimeSpan()
