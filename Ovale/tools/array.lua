local __exports = LibStub:NewLibrary("ovale/tools/array", 90108)
if not __exports then return end
local floor = math.floor
local insert = table.insert
local remove = table.remove
local function lessThanDefault(a, b)
    return a < b
end
local function equal(a, b, lessThan)
    return  not lessThan(a, b) and  not lessThan(b, a)
end
local function binarySearchRight(t, value, lessThan)
    lessThan = lessThan or lessThanDefault
    local low, high = 1, #t
    while low <= high do
        local mid = low + floor((high - low) / 2)
        if lessThan(value, t[mid]) then
            high = mid - 1
        else
            low = mid + 1
        end
    end
    return low
end
__exports.binarySearch = function(t, value, lessThan)
    lessThan = lessThan or lessThanDefault
    local index = binarySearchRight(t, value, lessThan)
    if index > 1 and equal(t[index - 1], value, lessThan) then
        return index - 1
    end
    return nil
end
__exports.binaryRemove = function(t, value, lessThan)
    lessThan = lessThan or lessThanDefault
    local index = binarySearchRight(t, value, lessThan)
    while index > 1 and equal(t[index - 1], value, lessThan) do
        remove(t, index - 1)
        index = index - 1
    end
end
__exports.binaryInsert = function(t, value, lessThan)
    lessThan = lessThan or lessThanDefault
    local index = binarySearchRight(t, value, lessThan)
    insert(t, index, value)
end
__exports.binaryInsertUnique = function(t, value, lessThan)
    lessThan = lessThan or lessThanDefault
    local index = binarySearchRight(t, value, lessThan)
    if index == 1 or  not equal(t[index - 1], value, lessThan) then
        insert(t, index, value)
    end
end
