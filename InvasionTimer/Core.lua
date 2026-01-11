---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
---@class InvasionTimerCore: Frame
local Core = CreateFrame('Frame')
IT.Core = Core

local LDB = LibStub('LibDataBroker-1.1')

-- Lua functions
local date, floor, format, ipairs, tinsert, unpack = date, floor, format, ipairs, tinsert, unpack

-- WoW API / Variables
local GetServerTime = GetServerTime

local UNKNOWN = UNKNOWN

local region = GetCVar('portal')
if not region or #region ~= 2 then
    local regionID = GetCurrentRegion()
    region = regionID and ({ 'US', 'KR', 'EU', 'TW', 'CN' })[regionID]
end
if region == 'CN' or region == 'TW' or region == 'KR' then
    region = 'CN'
elseif region == 'EU' then
    region = 'EU'
else
    region = 'US'
end

---@class TimeEventBaseTime
---@field US integer
---@field EU integer
---@field CN integer

---@class TimeEventEntry
---@field type "timeEvent"
---@field expansion number
---@field key string
---@field title string
---@field interval integer
---@field duration integer
---@field baseTime TimeEventBaseTime
---@field rotation integer[]?
---@field getCurrentNames nil | fun(): string[]
---@field getRotationName nil | fun(rotationID: integer): string

---@class CustomEntry
---@field type "custom"
---@field expansion number
---@field key string
---@field title string
---@field func fun(tooltip: GameTooltip)

---@alias DisplayEntry TimeEventEntry | CustomEntry

---@type DisplayEntry[]
local displayEntries = {}

---@param futureLength number
---@param entry TimeEventEntry
local function GetSequence(futureLength, entry)
    local baseTime = entry.baseTime[region]
    local interval = entry.interval
    local duration = entry.duration
    local rotation = entry.rotation

    local result = {}

    local currentTime = GetServerTime()
    local elapsed = (currentTime - baseTime) % interval
    local currentIndex
    if rotation then
        local count = #rotation
        local round = (floor((currentTime - baseTime) / interval) + 1) % count
        if round == 0 then round = count end

        currentIndex = round
    end

    if elapsed < duration then
        result[0] = { duration - elapsed, rotation and currentIndex and rotation[currentIndex] }
    end

    local nextTime = interval - elapsed + GetServerTime()
    for i = 1, futureLength do
        if currentIndex then
            currentIndex = (currentIndex + 1) % #rotation
            if currentIndex == 0 then currentIndex = #rotation end
        end

        result[i] = { nextTime, rotation and currentIndex and rotation[currentIndex] }
        nextTime = nextTime + interval
    end

    return result
end

---@param entry DisplayEntry
function Core:RegisterEntry(entry)
    tinsert(displayEntries, entry)
end

function Core:GetAllEntries()
    return displayEntries
end

function Core:GetDataFormat()
    if IT.db.settings.use12HourClock then
        if IT.db.settings.useDDMMFormat then
            return '%d/%m %I:%M %p'
        else
            return '%m/%d %I:%M %p'
        end
    else
        if IT.db.settings.useDDMMFormat then
            return '%d/%m %H:%M'
        else
            return '%m/%d %H:%M'
        end
    end
end

---@param tooltip GameTooltip
function Core:OnEnter(tooltip)
    local dataFormat = self:GetDataFormat()

    IT.WorldQuest:OnEnter(tooltip)

    for _, entry in ipairs(displayEntries) do
        local settingKey = entry.expansion .. '_' .. entry.key

        if IT.db.settings.displayEntry[settingKey] then
            tooltip:AddLine(entry.title)

            if entry.type == 'timeEvent' then
                local sequenceLength = 3
                local sequence = GetSequence(sequenceLength, entry)
                if sequence[0] then
                    local secondsLeft, rotationID = unpack(sequence[0])
                    local minutesLeft = secondsLeft / 60

                    if rotationID and entry.getRotationName then
                        local rotationName = entry.getRotationName(rotationID)
                        tooltip:AddDoubleLine(
                            L["Current"] .. ": " .. rotationName,
                            format("%dh %.2dm", minutesLeft / 60, minutesLeft % 60),
                            1, 1, 1, 0, 1, 0
                        )
                    elseif entry.getCurrentNames then
                        local currentName = entry.getCurrentNames()
                        local dateText = format("%dh %.2dm", minutesLeft / 60, minutesLeft % 60)

                        if #currentName == 0 then
                            tooltip:AddDoubleLine(
                                L["Current"] .. ": " .. UNKNOWN,
                                dateText,
                                1, 1, 1, 0, 1, 0
                            )
                        else
                            for _, name in ipairs(currentName) do
                                tooltip:AddDoubleLine(
                                    L["Current"] .. ": " .. name,
                                    dateText,
                                    1, 1, 1, 0, 1, 0
                                )
                            end
                        end
                    else
                        tooltip:AddDoubleLine(
                            L["Current"],
                            format("%dh %.2dm", minutesLeft / 60, minutesLeft % 60),
                            1, 1, 1, 0, 1, 0
                        )
                    end
                end

                for i = 1, sequenceLength do
                    local nextTime, rotationID = unpack(sequence[i])

                    if rotationID and entry.getRotationName then
                        local rotationName = entry.getRotationName(rotationID)
                        tooltip:AddDoubleLine(
                            L["Next"] .. ": " .. rotationName,
                            date(dataFormat, nextTime),
                            1, 1, 1, 1, 1, 1
                        )
                    else
                        tooltip:AddDoubleLine(
                            L["Next"],
                            date(dataFormat, nextTime),
                            1, 1, 1, 1, 1, 1
                        )
                    end
                end
            elseif entry.type == 'custom' then
                entry.func(tooltip)
            end
        end
    end
end

function Core:Initialize()
    LDB:NewDataObject("EventTimetable", {
        type = "data source",
        text = L["Event Timetable"],
        OnTooltipShow = function(tooltip)
            Core:OnEnter(tooltip)
        end,
    })
end
