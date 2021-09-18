-- Copyright (c) 2016-2018, r. brian harrison.  All rights reserved.

local LIB_NAME = "InSeason-1.1"
assert(LibStub, string.format("%s requires %s", LIB_NAME, "LibStub"))

local InSeason = LibStub:NewLibrary(LIB_NAME, 1)
if not InSeason then return end

--function InSeason:OnEnable()
--    self:BuildHolidayCache()
--end

-- do a function with the calendar temporarily reset to this month
function InSeason:CalendarExcursion(fn, ...)
    local prevMonth = C_Calendar.GetMonthInfo()
    local retval = {fn(...)}
    C_Calendar.SetAbsMonth(prevMonth.month, prevMonth.year)
    return unpack(retval)
end

function InSeason:CacheValidation()
    local date = C_DateAndTime.GetCurrentCalendarTime()
    if self.currentMonth ~= date.month then
        -- the month changed while we were logged in (or we just logged in)
        self.currentMonth = date.month
        self.daysInMonth = nil
        self.holidayStart = nil
        self.holidayEnd = nil
    end
end

function InSeason:DaysInMonth(monthOffset)
    self:CacheValidation()
    if self.daysInMonth == nil then
        self.daysInMonth = {}
    end
    if self.daysInMonth[monthOffset] == nil then
        local month = C_Calendar.GetMonthInfo(monthOffset)
        self.daysInMonth[monthOffset] = month.numDays
    end
    return self.daysInMonth[monthOffset]
end

-- find start and end dates of holidays
function InSeason:BuildHolidayCache()
    self:CacheValidation()

    self.holidayStart = {}
    self.holidayEnd = {}
    self.daysInMonth = {}

    -- check 13 months
    for monthOffset = 0, 12 do
        local numDays = self:DaysInMonth(monthOffset)

        self:CalendarExcursion(function()
                C_Calendar.SetMonth(monthOffset)
                local ANEMIC_OFFSET = 0

                for day = 1, numDays do
                    for index = 1, C_Calendar.GetNumDayEvents(ANEMIC_OFFSET, day) do
                        local event = C_Calendar.GetDayEvent(ANEMIC_OFFSET, day, index)
                        local title = event.title
                        local sequenceType = event.sequenceType

                        if event.calendarType == "HOLIDAY" then
                            if sequenceType == "START" and self.holidayStart[title] == nil then
                                self.holidayStart[title] = {monthOffset, day, event.startTime.hour, event.startTime.minute}
                            elseif sequenceType == "END" and self.holidayEnd[title] == nil then
                                self.holidayEnd[title] = {monthOffset, day, event.endTime.hour, event.endTime.minute}
                            end
                        end
                    end
                end
        end)
    end
end

--[[
function InSeason:Dump()
    for title, details in pairs(self.holidayStart) do
        local days = self:TimeUntil(unpack(details))
        DEFAULT_CHAT_FRAME:AddMessage(string.format("  %s (in %d days)", title, days)
    end
end
]]--

function InSeason:TimeUntilHoliday(title, type)
    self:CacheValidation()

    if self.holidayStart == nil then
        self:BuildHolidayCache()
    end

    if self.holidayStart[title] == nil then
        --DEFAULT_CHAT_FRAME:AddMessage(string.format("don't know when next %s is", title))
        return nil
    end

    if type == "START" or type == nil then
        return InSeason:TimeUntil(unpack(self.holidayStart[title]))
    elseif type == "END" then
        return InSeason:TimeUntil(unpack(self.holidayEnd[title]))
    end
end

function InSeason:TimeUntil(monthOffset, day, hour, minute)
    self:CacheValidation()

    if monthOffset == nil then
        monthOffset = 0
    end
    if day == nil then
        day = 1
    end
    if hour == nil then
        hour = 0
    end
    if minute == nil then
        minute = 0
    end

    while monthOffset < 0 do
        day = day - self:DaysInMonth(monthOffset)
        monthOffset = monthOffset + 1
    end

    while monthOffset > 0 do
        day = day + self:DaysInMonth(monthOffset)
        monthOffset = monthOffset - 1
    end

    local date = C_DateAndTime.GetCurrentCalendarTime()
    local d = date.monthDay
    local h, m = GetGameTime()

    -- wrap around
    if minute < m then
        m = m - 60
        h = h + 1
    end
    if hour < h then
        h = h - 24
        d = d + 1
    end
    return day - d, hour - h, minute - m
end
