local addonName = "Altoholic"
local addon = _G[addonName]

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
	
	local CurMonthInfo = C_Calendar.GetMonthInfo()
	refDate.month, refDate.year, refMonthFirstDay = CurMonthInfo.month, CurMonthInfo.year, CurMonthInfo.firstWeekday
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

addon:Controller("AltoholicUI.CalendarEventList", {
	Update = function(frame)
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
	end,
	GetEventDateLineIndex = function(frame, year, month, day)
		local eventDate = format("%04d-%02d-%02d", year, month, day)
		for k, v in pairs(view) do
			if v.linetype == EVENT_DATE and v.eventDate == eventDate then
				-- if the date line is found, return its index
				return k
			end
		end
	end,
	SetEventLineOffset = function(frame, offset)
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
	end,
	GetEventIndex = function(frame, id)
		-- Get the index of the event that was associated to this entry in the EventList
		local event = view[id]
		if event and event.linetype == EVENT_INFO then
			return event.parentID
		end
	end,
})
