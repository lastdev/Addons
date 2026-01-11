---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local Core = IT.Core

Core:RegisterEntry({
    type = 'timeEvent',
    expansion = 9,
    key = 'Feast',
    title = L["Community Feast"],
    interval = 5400,
    duration = 900,
    baseTime = {
        US = 1678698000, -- 2023-03-13 01:00 UTC-8
        EU = 1678696200, -- 2023-03-13 08:30 UTC+0
        CN = 1678608000, -- 2023-03-12 16:00 UTC+8
    },
})
