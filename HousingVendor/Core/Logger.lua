-- Logger
-- Centralizes chat output so the addon can run quietly by default.

local ADDON_NAME, ns = ...

local Log = {}
Log.__index = Log

local PREFIX_INFO = "|cFF8A7FD4HousingVendor:|r "
local PREFIX_WARN = "|cFFF2CC8FHousingVendor:|r "
local PREFIX_ERROR = "|cFFE63946HousingVendor:|r "

local function GetChatMode()
    -- "minimal" (default): only errors
    -- "normal": warnings + errors
    -- "debug": info + warnings + errors
    local db = _G.HousingDB
    local mode = db and db.settings and db.settings.chatMode or nil
    if mode == "debug" or mode == "normal" or mode == "minimal" then
        return mode
    end
    return "minimal"
end

local function CanPrintInfo()
    return GetChatMode() == "debug"
end

local function CanPrintWarn()
    local mode = GetChatMode()
    return mode == "debug" or mode == "normal"
end

function Log:Info(msg)
    if CanPrintInfo() then
        print(PREFIX_INFO .. tostring(msg or ""))
    end
end

function Log:Warn(msg)
    if CanPrintWarn() then
        print(PREFIX_WARN .. tostring(msg or ""))
    end
end

function Log:Error(msg)
    print(PREFIX_ERROR .. tostring(msg or ""))
end

-- Expose globally for modules that don't share a namespace table.
_G.HousingVendorLog = Log
ns.Log = Log

