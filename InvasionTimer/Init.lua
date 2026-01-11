---@type string, table
local addon, Engine = ...
---@class InvasionTimer: Frame
---@field db InvasionTimerDB
---@field Core InvasionTimerCore
---@field WorldQuest InvasionTimerWorldQuest
---@field Config InvasionTimerConfig
local IT = CreateFrame('Frame')

-- Lua functions
local _G = _G
local format, rawget = format, rawget

-- WoW API / Variables

-- GLOBALS: InvasionTimerDB

---@class InvasionTimerDBSettings
---@field displayEntry table<string, boolean>
---@field use12HourClock boolean
---@field useDDMMFormat boolean

---@class InvasionTimerDB
---@field dbVersion number
---@field settings InvasionTimerDBSettings

local L = {}
setmetatable(L, {
    __index = function(t, s) return rawget(t, s) or s end,
})

Engine[1] = IT
Engine[2] = L
_G[addon] = Engine

function IT:Print(...)
    _G.DEFAULT_CHAT_FRAME:AddMessage("Invasion Timer: " .. format(...))
end

IT:RegisterEvent('PLAYER_LOGIN')
IT:SetScript('OnEvent', function()
    IT:UnregisterEvent('PLAYER_LOGIN')

    if not InvasionTimerDB then
        InvasionTimerDB = {
            dbVersion = 1,
            settings = {
                displayEntry = {},
            },
        }
    end

    IT.db = InvasionTimerDB

    IT.Core:Initialize()
    IT.Config:Initialize()
end)
