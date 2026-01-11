---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local Core = IT.Core

-- Lua functions
local date, floor, format, ipairs = date, floor, format, ipairs

-- WoW API / Variables
local C_ContributionCollector_GetContributionAppearance = C_ContributionCollector.GetContributionAppearance
local C_ContributionCollector_GetName = C_ContributionCollector.GetName
local C_ContributionCollector_GetState = C_ContributionCollector.GetState
local GetServerTime = GetServerTime

local SecondsToTime = SecondsToTime

local warfronts = {
    -- Arathi Highlands
    {
        Alliance = 116,
        Horde = 11,
    },
    -- Darkshores
    {
        Alliance = 117,
        Horde = 118,
    },
}

local faction = UnitFactionGroup('player')
local oppositeFaction = faction == 'Alliance' and 'Horde' or 'Alliance'

Core:RegisterEntry({
    type = 'custom',
    expansion = 7,
    key = 'Warfront',
    title = L["Warfront"],
    func = function(tooltip)
        for _, warfront in ipairs(warfronts) do
            local contributionID = warfront[faction]
            local contributionName = C_ContributionCollector_GetName(contributionID)
            local state, stateAmount, timeOfNextStateChange = C_ContributionCollector_GetState(contributionID)
            local stateName = C_ContributionCollector_GetContributionAppearance(contributionID, state or 0).stateName
            if state == 4 then
                -- captured
                state, stateAmount, timeOfNextStateChange = C_ContributionCollector_GetState(warfront[oppositeFaction])
                stateName = format("%s (%s)", stateName, C_ContributionCollector_GetContributionAppearance(contributionID, state or 0).stateName)
            end
            if state == 2 and timeOfNextStateChange then
                -- attacking
                -- rest time available
                tooltip:AddDoubleLine(contributionName, SecondsToTime(timeOfNextStateChange - GetServerTime()), 1, 210 / 255, 0, 1, 1, 1)
                tooltip:AddDoubleLine(stateName, date("%m/%d %H:%M", timeOfNextStateChange), 1, 1, 1, 1, 1, 1)
            elseif state == 2 then
                -- rest time not available
                local expectTime = 7 * 24 * 60 * 60 -- 7 days
                tooltip:AddDoubleLine(contributionName, "100%", 1, 210 / 255, 0, 1, 1, 1)
                tooltip:AddDoubleLine(stateName, date("~ %m/%d %H:00", expectTime + GetServerTime()), 1, 1, 1, 1, 1, 1)
            elseif stateAmount then
                -- contributing
                -- contribute amount available
                local expectTime = (1 - stateAmount) * 7 * 24 * 60 * 60 -- 7 days
                local hour = expectTime / 60 / 60
                local day = floor(hour / 24)
                hour = hour - day * 24

                local expectTimeText
                if day > 0 then
                    expectTimeText = format("%d 天 %d 小时", day, hour)
                else
                    expectTimeText = format("%d 小时", hour)
                end

                tooltip:AddDoubleLine(contributionName, format("%.2f%% (%s)", stateAmount * 100, expectTimeText), 1, 210 / 255, 0, 1, 1, 1)
                tooltip:AddDoubleLine(stateName, date("~ %m/%d %H:00", expectTime + GetServerTime()), 1, 1, 1, 1, 1, 1)
            else
                -- contribute amount not available
                tooltip:AddDoubleLine(contributionName, stateName, 1, 210 / 255, 0, 1, 1, 1)
            end
        end
    end,
})
