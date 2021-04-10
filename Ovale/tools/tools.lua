local __exports = LibStub:NewLibrary("ovale/tools/tools", 90048)
if not __exports then return end
local type = type
local pairs = pairs
local strjoin = strjoin
local tostring = tostring
local tostringall = tostringall
local wipe = wipe
local select = select
local kpairs = pairs
local ipairs = ipairs
local len = string.len
local find = string.find
local format = string.format
local gsub = string.gsub
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
__exports.isString = function(s)
    return type(s) == "string"
end
__exports.isNumber = function(s)
    return type(s) == "number"
end
__exports.isBoolean = function(s)
    return type(s) == "boolean"
end
__exports.isLuaArray = function(a)
    return type(a) == "table"
end
__exports.checkToken = function(type, token)
    return type[token]
end
__exports.oneTimeMessages = {}
__exports.makeString = function(s, ...)
    if s and len(s) > 0 then
        if ... and select("#", ...) > 0 then
            if find(s, "%%%.%d") or find(s, "%%[%w]") then
                s = format(s, tostringall(...))
            else
                s = strjoin(" ", s, tostringall(...))
            end
        else
            return s
        end
    else
        s = tostring(nil)
    end
    return s
end
__exports.printFormat = function(pattern, ...)
    local s = __exports.makeString(pattern, ...)
    DEFAULT_CHAT_FRAME:AddMessage(format("|cff33ff99Ovale|r: %s", s))
end
__exports.oneTimeMessage = function(pattern, ...)
    local s = __exports.makeString(pattern, ...)
    if  not __exports.oneTimeMessages[s] then
        __exports.oneTimeMessages[s] = true
    end
end
__exports.clearOneTimeMessages = function()
    wipe(__exports.oneTimeMessages)
end
__exports.printOneTimeMessages = function()
    for s in pairs(__exports.oneTimeMessages) do
        if __exports.oneTimeMessages[s] ~= "printed" then
            __exports.printFormat(s)
            __exports.oneTimeMessages[s] = "printed"
        end
    end
end
__exports.stringify = function(obj)
    if obj == nil then
        return "null"
    end
    if __exports.isString(obj) then
        return "\"" .. gsub(obj, "\"", "\\\"") .. "\""
    end
    if __exports.isNumber(obj) then
        return tostring(obj)
    end
    if __exports.isBoolean(obj) then
        return (obj and "true") or "false"
    end
    if obj[1] then
        local firstItem = true
        local serialized = "["
        for _, item in ipairs(obj) do
            if firstItem then
                firstItem = false
            else
                serialized = serialized .. ","
            end
            serialized = serialized .. __exports.stringify(item)
        end
        serialized = serialized .. "]"
        return serialized
    end
    local serialized = "{"
    local firstProp = true
    for k, v in kpairs(obj) do
        if v ~= nil then
            if firstProp then
                firstProp = false
            else
                serialized = serialized .. ","
            end
            serialized = serialized .. "\"" .. k .. "\": "
            serialized = serialized .. __exports.stringify(v)
        end
    end
    serialized = serialized .. "}"
    return serialized
end
