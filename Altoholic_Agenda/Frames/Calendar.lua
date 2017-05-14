local addonName = "Altoholic"
local addon = _G[addonName]

-- *** EventList ***

local view
local isViewValid
local EVENT_DATE = 1
local EVENT_INFO = 2

local function BuildView()
	view = view or {}
	wipe(view)
	
	--[[
		the following list of events : 10/05, 10/05, 12/05, 14/05, 14/05
		turns into this view : 
			"10/05"
			event 1
			event 2
			"12/05"
			event 1
			"14/05"
			event 1
			event 2
	--]]
	
	addon.Events:BuildList()
	
	local eventDate = ""
	for k, v in pairs(addon.Events:GetList()) do
		if eventDate ~= v.eventDate then
			table.insert(view, { linetype = EVENT_DATE, eventDate = v.eventDate })
			eventDate = v.eventDate
		end
		table.insert(view, { linetype = EVENT_INFO, parentID = k })
	end
	
	isViewValid = true
end

local function GetDay(fullday)
	-- full day = a date as YYYY-MM-DD
	-- this function is actually different than the one in Blizzard_Calendar.lua, since weekday can't necessarily be determined from a UI button
	local refDate = {}		-- let's use the 1st of current month as reference date
	local refMonthFirstDay
	local _
	
	refDate.month, refDate.year, _, refMonthFirstDay = CalendarGetMonth()
	refDate.day = 1

	local t = {}
	local year, month, day = strsplit("-", fullday)
	t.year = tonumber(year)
	t.month = tonumber(month)
	t.day = tonumber(day)

	local numDays = floor(difftime(time(t), time(refDate)) / 86400)
	local weekday = mod(refMonthFirstDay + numDays, 7)
	
	-- at this point, weekday might be negative or 0, simply add 7 to keep it in the proper range
	weekday = (weekday <= 0) and (weekday+7) or weekday
	
	return t.year, t.month, t.day, weekday
end

local function _GetEventDateLineIndex(frame, year, month, day)
	local eventDate = format("%04d-%02d-%02d", year, month, day)
	for k, v in pairs(view) do
		if v.linetype == EVENT_DATE and v.eventDate == eventDate then
			-- if the date line is found, return its index
			return k
		end
	end
end

local function _SetEventLineOffset(frame, offset)
	local scrollFrame = frame.ScrollFrame
	local numRows = scrollFrame.numRows

	-- if the view has less entries than can be displayed, don't change the offset
	if #view <= numRows then return end

	if offset <= 0 then
		offset = 0
	elseif offset > (#view - numRows) then
		offset = (#view - numRows)
	end
	
	local scrollFrame = frame.GetParent()
	scrollFrame:SetOffset(offset)
	scrollFrame.ScrollBar:SetValue(offset * 18)
end

local function _GetEventIndex(frame, id)
	-- Get the index of the event that was associated to this entry in the EventList
	local event = view[id]
	if event and event.linetype == EVENT_INFO then
		return event.parentID
	end
end

local function _UpdateEventList(frame)
	if not isViewValid then
		BuildView()
	end

	local calendar = frame:GetParent()

	local scrollFrame = frame.ScrollFrame
	local numRows = scrollFrame.numRows
	local offset = scrollFrame:GetOffset()

	for rowIndex = 1, numRows do
		local rowFrame = scrollFrame:GetRow(rowIndex)
		local line = rowIndex + offset
		
		if line <= #view then
			local s = view[line]

			if s.linetype == EVENT_DATE then
				local year, month, day, weekday = GetDay(s.eventDate)
				rowFrame:SetDate(calendar:GetFullDate(weekday, month, day, year))
			elseif s.linetype == EVENT_INFO then
				rowFrame:SetInfo(addon.Events:GetInfo(s.parentID))
			end

			rowFrame:SetID(line)
			rowFrame:Show()
		else
			rowFrame:Hide()
		end
	end

	scrollFrame:Update(#view)
end

addon:RegisterClassExtensions("AltoCalendarEventList", {
	Update = _UpdateEventList,
	GetEventDateLineIndex = _GetEventDateLineIndex,
	SetEventLineOffset = _SetEventLineOffset,
	GetEventIndex = _GetEventIndex,
})


-- *** Calendar ***

local CALENDAR_WEEKDAY_NORMALIZED_TEX_LEFT	= 0.0
local CALENDAR_WEEKDAY_NORMALIZED_TEX_TOP		= 180 / 256
local CALENDAR_WEEKDAY_NORMALIZED_TEX_WIDTH	= 90 / 256 - 0.001		-- fudge factor to prevent texture seams
local CALENDAR_WEEKDAY_NORMALIZED_TEX_HEIGHT	= 28 / 256 - 0.001		-- fudge factor to prevent texture seams

local CALENDAR_MAX_DAYS_PER_MONTH			= 42	-- 6 weeks
local CALENDAR_MONTH_NAMES = { CalendarGetMonthNames() }
local CALENDAR_WEEKDAY_NAMES = { CalendarGetWeekdayNames() }

local CALENDAR_FULLDATE_MONTH_NAMES = {
	-- month names show up differently for full date displays in some languages
	FULLDATE_MONTH_JANUARY,
	FULLDATE_MONTH_FEBRUARY,
	FULLDATE_MONTH_MARCH,
	FULLDATE_MONTH_APRIL,
	FULLDATE_MONTH_MAY,
	FULLDATE_MONTH_JUNE,
	FULLDATE_MONTH_JULY,
	FULLDATE_MONTH_AUGUST,
	FULLDATE_MONTH_SEPTEMBER,
	FULLDATE_MONTH_OCTOBER,
	FULLDATE_MONTH_NOVEMBER,
	FULLDATE_MONTH_DECEMBER,
};

local function _Init(frame)
	-- by default, the week starts on Sunday, adjust first day of the week if necessary
	if addon:GetOption("UI.Calendar.WeekStartsOnMonday") then
		addon:SetFirstDayOfWeek(2)
	end
	
	local band = bit.band
	
	-- initialize weekdays
	for i = 1, 7 do
		local bg =  frame["Weekday"..i.."Background"]
		local left = (band(i, 1) * CALENDAR_WEEKDAY_NORMALIZED_TEX_WIDTH) + CALENDAR_WEEKDAY_NORMALIZED_TEX_LEFT		-- mod(index, 2) * width
		local right = left + CALENDAR_WEEKDAY_NORMALIZED_TEX_WIDTH
		local top = CALENDAR_WEEKDAY_NORMALIZED_TEX_TOP
		local bottom = top + CALENDAR_WEEKDAY_NORMALIZED_TEX_HEIGHT
		bg:SetTexCoord(left, right, top, bottom)
		bg:Show()
	end
	
	for i = 1, 42 do
		frame["Day"..i]:Init()
	end
end

local function _GetWeekdayIndex(frame, index)
	-- GetWeekdayIndex takes an index in the range [1, n] and maps it to a weekday starting
	-- at CALENDAR_FIRST_WEEKDAY. For example,
	-- CALENDAR_FIRST_WEEKDAY = 1 => [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY]
	-- CALENDAR_FIRST_WEEKDAY = 2 => [MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY]
	-- CALENDAR_FIRST_WEEKDAY = 6 => [FRIDAY, SATURDAY, SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY]
	
	-- the expanded form for the left input to mod() is:
	-- (index - 1) + (CALENDAR_FIRST_WEEKDAY - 1)
	-- why the - 1 and then + 1 before return? because lua has 1-based indexes! awesome!
	return mod(index - 2 + addon:GetFirstDayOfWeek(), 7) + 1
end

local function _GetFullDate(frame, weekday, month, day, year)
	local weekdayName = CALENDAR_WEEKDAY_NAMES[weekday]
	local monthName = CALENDAR_FULLDATE_MONTH_NAMES[month]
	
	return weekdayName, monthName, day, year, month
end

local function _InvalidateView(frame)
	isViewValid = nil
	if frame:IsVisible() then
		frame:Update()
	end
end

local function _Update(frame)
	-- taken from CalendarFrame_Update() in Blizzard_Calendar.lua, adjusted for my needs.
	
	local presentWeekday, presentMonth, presentDay, presentYear = CalendarGetDate()
	local prevMonth, prevYear, prevNumDays = CalendarGetMonth(-1)
	local nextMonth, nextYear, nextNumDays = CalendarGetMonth(1)
	local month, year, numDays, firstWeekday = CalendarGetMonth()

	-- set title
	frame.MonthYear:SetText(format("%s %s", CALENDAR_MONTH_NAMES[month], year))
	
	-- initialize weekdays
	for i = 1, 7 do
		frame["Weekday"..i.."Name"]:SetText(string.sub(CALENDAR_WEEKDAY_NAMES[frame:GetWeekdayIndex(i)], 1, 3))
	end

	local buttonIndex = 1
	local isDarkened = true
	local day

	-- set the previous month's days before the first day of the week
	local viewablePrevMonthDays = mod((firstWeekday - addon:GetFirstDayOfWeek() - 1) + 7, 7)
	day = prevNumDays - viewablePrevMonthDays

	while ( frame:GetWeekdayIndex(buttonIndex) ~= firstWeekday ) do
		frame["Day"..buttonIndex]:Update(day, prevMonth, prevYear, isDarkened)
		day = day + 1
		buttonIndex = buttonIndex + 1
	end

	-- set the days of this month
	day = 1
	isDarkened = false
	while ( day <= numDays ) do
		frame["Day"..buttonIndex]:Update(day, month, year, isDarkened)
		day = day + 1
		buttonIndex = buttonIndex + 1
	end
	
	-- set the first days of the next month
	day = 1
	isDarkened = true
	while ( buttonIndex <= CALENDAR_MAX_DAYS_PER_MONTH ) do
		frame["Day"..buttonIndex]:Update(day, nextMonth, nextYear, isDarkened)

		day = day + 1
		buttonIndex = buttonIndex + 1
	end

	frame.EventList:Update()
	frame:Show()
end

addon:RegisterClassExtensions("AltoCalendar", {
	Init = _Init,
	Update = _Update,
	InvalidateView = _InvalidateView,
	GetWeekdayIndex = _GetWeekdayIndex,
	GetFullDate = _GetFullDate,
})
