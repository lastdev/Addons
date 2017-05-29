-- Copyright (c) 2016, r. brian harrison.  All rights reserved.

local LIB_NAME = "InSeason-1.0"
assert(LibStub, string.format("%s requires %s", LIB_NAME, "LibStub"))

local InSeason = LibStub:NewLibrary(LIB_NAME, 1)
if not InSeason then return end

--function InSeason:OnEnable()
--    self:BuildHolidayCache()
--end

-- do a function with the calendar temporarily reset to this month
function InSeason:CalendarExcursion(fn, ...)
    local prevMonth, prevYear = CalendarGetMonth()
    local _, month = CalendarGetDate()
    CalendarSetAbsMonth(month)
    local retval = {fn(...)}
    CalendarSetAbsMonth(prevMonth, prevYear)
    return unpack(retval)
end

function InSeason:CacheValidation()
    local _, currentMonth = CalendarGetDate()
    if self.currentMonth ~= currentMonth then
        -- the month changed while we were logged in (or we just logged in)
        self.currentMonth = currentMonth
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
        local days = self:CalendarExcursion(function()
                local _, _, days = CalendarGetMonth(monthOffset)
                return days
        end)
        self.daysInMonth[monthOffset] = days
    end
    return self.daysInMonth[monthOffset]
end

-- find start and end dates of holidays
function InSeason:BuildHolidayCache()
    self:CacheValidation()

    self.holidayStart = {}
    self.holidayEnd = {}
    self.daysInMonth = {}

    self:CalendarExcursion(function()
            -- check 13 months
            for monthOffset = 0, 12 do
                local _, _, numDays = CalendarGetMonth(0)
                self.daysInMonth[monthOffset] = numDays
                for day = 1, numDays do
                    for index = 1, CalendarGetNumDayEvents(0, day) do
                        local title, hour, minute, calendarType, sequenceType = CalendarGetDayEvent(0, day, index)
                        if calendarType == "HOLIDAY" then
                            if sequenceType == "START" and self.holidayStart[title] == nil then
                                self.holidayStart[title] = {monthOffset, day, hour, minute}
                            elseif sequenceType == "END" and self.holidayEnd[title] == nil then
                                self.holidayEnd[title] = {monthOffset, day, hour, minute}
                            end
                        end
                    end
                end
                CalendarSetMonth(1)
            end
    end)
end

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

    local _, _, d = CalendarGetDate()
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
