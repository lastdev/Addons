---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local Core = IT.Core

Core:RegisterEntry({
    type = 'timeEvent',
    expansion = 9,
    key = 'Siege',
    title = L["Siege on Dragonbane Keep"],
    interval = 7200,
    duration = 3600,
    baseTime = {
        US = 1670320800, -- 2022-12-06 02:00 UTC-8
        EU = 1670320800, -- 2022-12-06 10:00 UTC+0
        CN = 1670144400, -- 2022-12-04 17:00 UTC+8
    },
})
