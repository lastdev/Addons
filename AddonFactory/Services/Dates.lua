local MVC = LibStub("LibMVC-1.0")

MVC:Service("AddonFactory.Dates", function() 

	local weekdayNames = { WEEKDAY_SUNDAY, WEEKDAY_MONDAY, WEEKDAY_TUESDAY, WEEKDAY_WEDNESDAY, WEEKDAY_THURSDAY, WEEKDAY_FRIDAY, WEEKDAY_SATURDAY }

	local monthNames = {
		MONTH_JANUARY, MONTH_FEBRUARY, MONTH_MARCH, MONTH_APRIL, MONTH_MAY, MONTH_JUNE,
		MONTH_JULY, MONTH_AUGUST, MONTH_SEPTEMBER, MONTH_OCTOBER, MONTH_NOVEMBER, MONTH_DECEMBER
	}

	-- month names show up differently for full date displays in some languages
	local fullMonthNames = {
		FULLDATE_MONTH_JANUARY, FULLDATE_MONTH_FEBRUARY, FULLDATE_MONTH_MARCH, FULLDATE_MONTH_APRIL, FULLDATE_MONTH_MAY, FULLDATE_MONTH_JUNE,
		FULLDATE_MONTH_JULY, FULLDATE_MONTH_AUGUST, FULLDATE_MONTH_SEPTEMBER, FULLDATE_MONTH_OCTOBER, FULLDATE_MONTH_NOVEMBER, FULLDATE_MONTH_DECEMBER
	}
	
	-- 1 = Sunday, recreated locally to avoid the problem caused by the calendar addon not being loaded at startup.
	-- On an EU client, CALENDAR_FIRST_WEEKDAY = 1 when the game is loaded, but becomes 2 as soon as the calendar is launched.
	-- So default it to 1, and add an option to select Monday as 1st day of the week instead. If need be, use a slider.
	-- Although the calendar is LoD, avoid it.
	local calendarFirstWeekday = 1
	
	local dateTable = { day = 0, month = 0, year = 0 }

	local function GetDateString(year, month, day, dateFormat)
		dateTable.year = year
		dateTable.month = month
		dateTable.day = day
	
		return date(dateFormat, time(dateTable))
	end
	
	local function GetFullDateString(year, month, day)
		-- %A = day of the week
		-- %B = month
		-- %d for the day = "05", %e = "5"
		-- %Y = year
		return GetDateString(year, month, day, "%A, %B %e, %Y")
	end

	return {
		SetFirstDayOfWeek = function(day) calendarFirstWeekday = day end,
		GetFirstDayOfWeek = function(day) return calendarFirstWeekday end,
		
		GetWeekDayName = function(day) return weekdayNames[day] end,
		GetWeekDayShort = function(day) return string.sub(weekdayNames[day], 1, 3) end,
		GetMonthName = function(month) return monthNames[month] end,
		GetFullMonthName = function(month) return fullMonthNames[month] end,
		GetMaxDaysInMonth = function(day) return 42 end,	-- 6 weeks

		GetMonthInfo = function(month)
			local info = C_Calendar.GetMonthInfo(month)
			return info.month, info.year, info.numDays, info.firstWeekday
		end,
		
		GetWeekdayIndex = function(index)
			-- GetWeekdayIndex takes an index in the range [1, n] and maps it to a weekday starting
			-- at CALENDAR_FIRST_WEEKDAY. For example,
			-- CALENDAR_FIRST_WEEKDAY = 1 => [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY]
			-- CALENDAR_FIRST_WEEKDAY = 2 => [MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY]
			-- CALENDAR_FIRST_WEEKDAY = 6 => [FRIDAY, SATURDAY, SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY]
			
			-- the expanded form for the left input to mod() is:
			-- (index - 1) + (CALENDAR_FIRST_WEEKDAY - 1)
			-- why the - 1 and then + 1 before return? because lua has 1-based indexes! awesome!
			return mod(index - 2 + calendarFirstWeekday, 7) + 1
		end,
		
		-- Strings
		GetMonthYearString = function(month, year) return format("%s %s", monthNames[month], year) end,
		GetFullDate = GetFullDateString,
		GetFullDateFromString = function(dateString) 
			local year, month, day = dateString:match("(%d+)-(%d+)-(%d+)") 
			return GetFullDateString(tonumber(year), tonumber(month), tonumber(day))
		end,

}end)
