local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

--- Utility class for printing debug information.
---@class Logger
---@field logsEnabled boolean Top-level toggle to control logging
local Logger = {
    logsEnabled = true
}
DelveCompanion.Logger = Logger

--- Log a formatted string to the console if logging is enabled.
--- Acts as a wrapper around `print(string.format(...))`.
---@param stringText string The format string. Supports placeholders like %s, %d, etc.
---@param ... any Arguments to be substituted into the format string.
function Logger.Log(stringText, ...)
    if not Logger.logsEnabled then
        return
    end

    print(string.format(stringText, ...))
end

--- Log the contents of a table as key-value pairs.
--- Only top-level entries are shown; nested tables and functions are not recursively expanded.
---@param tbl table The table to log.
function Logger.LogTable(tbl)
    if type(tbl) ~= "table" then
        return
    end

    for key, value in pairs(tbl) do
        Logger.Log("Key: %s | Value: %s", key, tostring(value))
    end
end
