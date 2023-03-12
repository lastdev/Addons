-- [[ Namespaces ]] --
local _, addon = ...;
addon.GUI.Calendar.Frame = {};
local frame = addon.GUI.Calendar.Frame;

-- Data taken from Blizzard_Calendar.lua and changed the names, line 156
local darkFlagPrevMonth = 0x0001;
local darkFlagNextMonth = 0x0002;
local darkFlagCorner = 0x0004;
local darkFlagSideLeft = 0x0008;
local darkFlagSideRight = 0x0010;
local darkFlagSideTop = 0x0020;
local darkFlagSideBottom = 0x0040;
local darkFlagPrevMonthTop = darkFlagPrevMonth + darkFlagSideTop;
local darkFlagPrevMonthTopLeft = darkFlagPrevMonthTop + darkFlagSideLeft;
local darkFlagPrevMonthTopRight = darkFlagPrevMonthTop + darkFlagSideRight;
local darkFlagPrevMonthTopLeftRight = darkFlagPrevMonthTopLeft + darkFlagSideRight;
local darkFlagNextMonthTop = darkFlagNextMonth + darkFlagSideTop;
local darkFlagNextMonthTopLeft = darkFlagNextMonthTop + darkFlagSideLeft;
local darkFlagNextMonthTopRight = darkFlagNextMonthTop + darkFlagSideRight;
local darkFlagNextMonthCorner = darkFlagNextMonth + darkFlagCorner;
local darkFlagNextMonthCornerTop = darkFlagNextMonthCorner + darkFlagSideTop;
local darkFlagNextMonthCornerRight = darkFlagNextMonthCorner + darkFlagSideRight;
local darkFlagNextMonthCornerTopLeft = darkFlagNextMonthCornerTop + darkFlagSideLeft;
local darkFlagNextMonthCornerTopLeftRight = darkFlagNextMonthCornerTopLeft + darkFlagSideRight;
local darkFlagPrevMonthBottom = darkFlagPrevMonth + darkFlagSideBottom;
local darkFlagPrevMonthBottomLeft = darkFlagPrevMonthBottom + darkFlagSideLeft;
local darkFlagPrevMonthBottomRight = darkFlagPrevMonthBottom + darkFlagSideRight;
local darkFlagPrevMonthBottomLeftRight = darkFlagPrevMonthBottomLeft + darkFlagSideRight;
local darkFlagNextMonthBottom = darkFlagNextMonth + darkFlagSideBottom;
local darkFlagNextMonthBottomLeft = darkFlagNextMonthBottom + darkFlagSideLeft;
local darkFlagNextMonthBottomRight = darkFlagNextMonthBottom + darkFlagSideRight;
local darkFlagNextMonthBottomLeftRight = darkFlagNextMonthBottomLeft + darkFlagSideRight;
local darkFlagNextMonthLeftRight = darkFlagNextMonth + darkFlagSideLeft + darkFlagSideRight;
local darkFlagNextMonthLeft = darkFlagNextMonth + darkFlagSideLeft;
local darkFlagNextMonthRight = darkFlagNextMonth + darkFlagSideRight;
local darkDayTopTexCoords = {
	[darkFlagPrevMonthTop] = {left = 90 / 512, right = 180 / 512, top = 0.0, bottom = 45 / 256},
	[darkFlagPrevMonthTopLeft] = {left = 0.0, right = 90 / 512, top = 0.0, bottom = 45 / 256 - 0.001},
	[darkFlagPrevMonthTopRight] = {left = 90 / 512, right = 0.0, top = 0.0, bottom = 45 / 256 - 0.001},
	[darkFlagPrevMonthTopLeftRight] = {left = 0.0, right = 90 / 512, top = 180 / 256, bottom = 225 / 256 - 0.001},
	[darkFlagNextMonth] = {left = 90 / 512, right = 180 / 512, top = 45 / 256, bottom = 90 / 256},
	[darkFlagNextMonthLeft] = {left = 90 / 512, right = 0.0, top = 90 / 256, bottom = 135 / 256},
	[darkFlagNextMonthRight] = {left = 0.0, right = 90 / 512, top = 90 / 256, bottom = 135 / 256 - 0.001},
	[darkFlagNextMonthTop] = {left = 90 / 512, right = 180 / 512, top = 0.0, bottom = 45 / 256},
	[darkFlagNextMonthTopLeft] = {left = 0.0, right = 90 / 512, top = 0.0, bottom = 45 / 256 - 0.001},
	[darkFlagNextMonthTopRight] = {left = 90 / 512, right = 0.0, top = 0.0, bottom = 45 / 256 - 0.001},
	[darkFlagNextMonthCorner] = {left = 90 / 512, right = 180 / 512 - 0.001, top = 135 / 256, bottom = 180 / 256},
	[darkFlagNextMonthCornerTop] = {left = 0.0, right = 90 / 512, top = 135 / 256, bottom = 180 / 256 - 0.001},
	[darkFlagNextMonthCornerRight] = {left = 180 / 512, right = 270 / 512 - 0.001, top = 45 / 256, bottom = 90 / 256 - 0.001},
	[darkFlagNextMonthCornerTopLeft] = {left = 0.0, right = 90 / 512, top = 45 / 256, bottom = 90 / 256},
	[darkFlagNextMonthCornerTopLeftRight] = {left = 180 / 512, right = 90 / 512, top = 225 / 256, bottom = 180 / 256}
};
local darkDayBottomTexCoords = {
	[darkFlagPrevMonthBottom] = {left = 90 / 512, right = 180 / 512, top = 45 / 256, bottom = 0.0},
	[darkFlagPrevMonthBottomLeft] = {left = 0.0, right = 90 / 512, top = 45 / 256 - 0.001, bottom = 0.0},
	[darkFlagPrevMonthBottomRight] = {left = 90 / 512, right = 0.0, top = 90 / 256, bottom = 45 / 256},
	[darkFlagPrevMonthBottomLeftRight] = {left = 90 / 512, right = 180 / 512, top = 180 / 256, bottom = 225 / 256},
	[darkFlagNextMonth] = {left = 90 / 512, right = 180 / 512, top = 45 / 256, bottom = 90 / 256},
	[darkFlagNextMonthLeft] = {left = 90 / 512, right = 0.0, top = 90 / 256, bottom = 135 / 256},
	[darkFlagNextMonthRight] = {left = 0.0, right = 90 / 512, top = 90 / 256, bottom = 135 / 256},
	[darkFlagNextMonthBottom] = {left = 90 / 512, right = 180 / 512, top = 45 / 256, bottom = 0.0},
	[darkFlagNextMonthBottomLeft] = {left = 0.0, right = 90 / 512, top = 45 / 256 - 0.001, bottom = 0.0},
	[darkFlagNextMonthBottomRight] = {left = 90 / 512, right = 0.0, top = 45 / 256 - 0.001, bottom = 0.0},
	[darkFlagNextMonthBottomLeftRight] = {left = 0.0, right = 90 / 512, top = 225 / 256, bottom = 180 / 256},
	[darkFlagNextMonthLeftRight] = {left = 180 / 512, right = 270 / 512 - 0.001, top = 0.0, bottom = 45 / 256}
};
local monthNames = {
    addon.L["January"],
    addon.L["February"],
    addon.L["March"],
    addon.L["April"],
    addon.L["May"],
    addon.L["June"],
    addon.L["July"],
    addon.L["August"],
    addon.L["September"],
    addon.L["October"],
    addon.L["November"],
    addon.L["December"]
};

local maxDaysPerMonth = 42; -- 6 weeks

function frame:Load()
	local frame2 = CreateFrame("Frame", "KrowiAF_AchievementCalendarFrame", UIParent, "KrowiAF_CalendarFrame_Template");
	frame2.ResetPosition = self.ResetPosition;
	addon.GUI.SetFrameToLastPosition(frame2, "Calendar");

	addon.GUI.Calendar.Frame = frame2; -- Overwrite with the actual frame since all functions are injected to it
end

function frame:ResetPosition()
    KrowiAF_SavedData.RememberLastPosition = KrowiAF_SavedData.RememberLastPosition or {};
    KrowiAF_SavedData.RememberLastPosition["Calendar"] = {
        X = 150,
        Y = -80
    };
	addon.GUI.SetFrameToLastPosition(self, "Calendar");
end

function KrowiAF_CalendarFrameTodayFrame_OnUpdate(self, elapsed)
	self.timer = self.timer - elapsed;
	if self.timer < 0 then
		self.timer = self.fadeTime;
		if self.fadein then
			self.fadein = false;
		else
			self.fadein = true;
		end
	else
		if self.fadein then
			self.Glow:SetAlpha(1 - (self.timer / self.fadeTime));
		else
			self.Glow:SetAlpha(self.timer / self.fadeTime);
		end
	end
end

function KrowiAF_CalendarFramePrevMonthButton_OnClick()
	PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN);
	C_CalendarSetMonth(-1);
	addon.GUI.Calendar.Frame:Update();
end

function KrowiAF_CalendarFrameNextMonthButton_OnClick()
	PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN);
	C_CalendarSetMonth(1);
	addon.GUI.Calendar.Frame:Update();
end

function KrowiAF_CalendarFrameCloseButton_OnKeyDown(self, key)
    if key == GetBindingKey("TOGGLEGAMEMENU") then
		if self:GetParent():IsShown() and not addon.GUI.Calendar.SideFrame:IsShown() then
			-- self:Click(self);
            self:GetParent():Hide();
			self:SetPropagateKeyboardInput(false);
			return;
		end
	end
	self:SetPropagateKeyboardInput(true);
end

function KrowiAF_CalendarFrame_OnLoad(self)
	C_CalendarResetAbsMonth();

	self.DayButtons = {};

	local name = self:GetName()
	for i = 1, maxDaysPerMonth do
		self.DayButtons[i] = CreateFrame("Button", name .. "DayButton" .. i, self, "KrowiAF_CalendarDayButton_Template");
		self.DayButtons[i]:PostLoad(self.DayButtons, i);
	end

	self.selectedMonth = nil;
	self.selectedDay = nil;
	self.selectedYear = nil;
	self.ViewedMonth = nil;
	self.ViewedYear = nil;
end

local firstTimeOpen = true;
function KrowiAF_CalendarFrame_OnShow(self)
	self:RegisterEvent("ACHIEVEMENT_EARNED");
	if (not self.LockMonth and not addon.Options.db.Calendar.LockMonth) or firstTimeOpen then
		local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime();
		C_CalendarSetAbsMonth(currentCalendarTime.month, currentCalendarTime.year);
		self:Update();
		firstTimeOpen = nil;
	end
	self.LockMonth = nil;
	PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN);
end

function KrowiAF_CalendarFrame_OnHide(self)
	self:UnregisterEvent("ACHIEVEMENT_EARNED");
	PlaySound(SOUNDKIT.IG_SPELLBOOK_CLOSE);
end

local function AddAchievementToButton(dayButton, achievementId, icon, points)
	dayButton.Achievements = dayButton.Achievements or {};
	dayButton.Points = dayButton.Points + points;
	tinsert(dayButton.Achievements, achievementId);
	local achievementButtons = dayButton.AchievementButtons;
	local numAchievements = #dayButton.Achievements;
	local achievementButton;
	if numAchievements <= 4 then
		achievementButton = achievementButtons[numAchievements];
		achievementButton.Texture:SetTexture(icon);
		achievementButton:Show();
	else
		dayButton.More:Show();
	end
end

local function GetSecondsSince(dayButton)
    return time{year = dayButton.Year, month = dayButton.Month, day = dayButton.Day};
end

function KrowiAF_CalendarFrame_OnEvent(self, event, ...)
	if event ~= "ACHIEVEMENT_EARNED" then
		return;
	end
	-- local achievementId = ...;
	-- local id, _, points, _, month, day, year = addon.GetAchievementInfo(achievementId);
	-- if not id then
	-- 	return;
	-- end
	-- if self.ViewedYear ~= 2000 + year or self.ViewedMonth ~= month then
	-- 	return;
	-- end

    -- local firstDate = GetSecondsSince(self.DayButtons[1]);
	-- local date = time{
    --     year = 2000 + year,
    --     month = month,
    --     day = day
    -- };
	-- local dayButtonIndex = floor((date - firstDate) / 86400 + 1); -- 86400 seconds in a day, floor to take changes in DST which would result in x.xx
	-- local dayButton = self.DayButtons[dayButtonIndex];
	-- AddAchievementToButton(dayButton, achievementId, icon, points);
	-- if not dayButton.Dark then
	-- 	self.NumAchievements = self.NumAchievements + 1;
	-- 	self.TotalPoints = self.TotalPoints + points;
	-- end
	-- self:SetAchievementsAndPoints(self.NumAchievements, self.TotalPoints);
	-- if self.SelectedDayButton then
	-- 	self.SelectedDayButton:Deselect();
	-- 	self.SelectedDayButton = nil;
	-- 	self.SelectedDay = nil;
	-- 	self.SelectedMonth = nil;
	-- 	self.SelectedYear = nil;
	-- 	self.WeekdaySelectedTexture:Hide();
	-- 	addon.GUI.Calendar.SideFrame:Hide();
	-- end
	addon.DelayFunction("KrowiAF_CalendarFrame_OnEvent", 1, function()
		self:Update();
		if self.SelectedDayButton then
			self:SetSelectedDay(self.SelectedDayButton, true, true);
		end
	end);
end

function KrowiAF_CalendarFrame_OnMouseWheel(self, value)
	if value > 0 then
		if addon.GUI.Calendar.Frame.PrevMonthButton:IsEnabled() then
			KrowiAF_CalendarFramePrevMonthButton_OnClick();
		end
	else
		if addon.GUI.Calendar.Frame.NextMonthButton:IsEnabled() then
			KrowiAF_CalendarFrameNextMonthButton_OnClick();
		end
	end
end

KrowiAF_CalendarFrameMixin = {};

local function GetWeekdayIndex(index)
	return mod(index - 2 + addon.Options.db.Calendar.FirstWeekDay, 7) + 1;
end

local function GetDayOfWeek(index)
	return mod(index - 1, 7) + 1;
end

local function GetMonthInfo(offset)
	local monthInfo = C_CalendarGetMonthInfo(offset);
	return monthInfo.month, monthInfo.year, monthInfo.numDays, monthInfo.firstWeekday;
end

function KrowiAF_CalendarFrameMixin:UpdateTitle()
	self.MonthName:SetText(monthNames[self.ViewedMonth]);
	self.YearName:SetText(self.ViewedYear);
end

function KrowiAF_CalendarFrameMixin:UpdatePrevNextMonthButtons()
	local date = C_Calendar.GetMinDate();
	local testMonth = date.month;
	local testYear = date.year;
	self.PrevMonthButton:Enable();
	if self.ViewedYear <= testYear and self.ViewedMonth <= testMonth then
		self.PrevMonthButton:Disable();
	end

	date = C_Calendar.GetMaxCreateDate();
	testMonth = date.month;
	testYear = date.year;
	self.NextMonthButton:Enable();
	if self.ViewedYear >= testYear and self.ViewedMonth >= testMonth then
		self.NextMonthButton:Disable();
	end
end

function KrowiAF_CalendarFrameMixin:UpdateWeekDays()
	for i = 1, 7 do
		local weekday = GetWeekdayIndex(i);
		self.WeekDayNames[i]:SetText(CALENDAR_WEEKDAY_NAMES[weekday]);
	end
end

function KrowiAF_CalendarFrameMixin:HideAttributes()
	self.TodayFrame:Hide();
	self.WeekdaySelectedTexture:Hide();
	self.LastDayDarkTexture:Hide();
end

function KrowiAF_CalendarFrameMixin:SetSelectedDay(dayButton, keepSelected, forceReloadAchievements)
	local prevSelectedDayButton = self.SelectedDayButton;
	if prevSelectedDayButton and not keepSelected then -- and prevSelectedDayButton ~= dayButton
		prevSelectedDayButton:Deselect();
	end

	local weekdaySelectedTexture = self.WeekdaySelectedTexture;
	if (dayButton.Achievements and prevSelectedDayButton ~= dayButton) or keepSelected then
		self.SelectedDayButton = dayButton;
		self.SelectedDay = dayButton.Day;
		self.SelectedMonth = dayButton.Month;
		self.SelectedYear = dayButton.Year;
		local weekdayBackground = self.WeekDayBackgrounds[GetDayOfWeek(dayButton:GetID())];
		weekdaySelectedTexture:ClearAllPoints();
		weekdaySelectedTexture:SetPoint("CENTER", weekdayBackground, "CENTER");
		weekdaySelectedTexture:Show();
		self:SetHighlightedDay(dayButton, not keepSelected or forceReloadAchievements);
	else
		self.SelectedDayButton = nil;
		self.SelectedDay = nil;
		self.SelectedMonth = nil;
		self.SelectedYear = nil;
		dayButton:Deselect();
		weekdaySelectedTexture:Hide();
		if addon.GUI.Calendar.SideFrame:IsShown() then
			addon.GUI.Calendar.SideFrame:Hide();
		end
	end
end

function KrowiAF_CalendarFrameMixin:SetHighlightedDay(dayButton, overRuleLock)
	if self.SelectedDayButton and not overRuleLock then -- Acts as a lock to keep the side frame open when a day is selected
		return;
	end
	self.HighlightedDayButton = dayButton;
	self.HighlightedDay = dayButton and dayButton.Day;
	self.HighlightedMonth = dayButton and dayButton.Month;
	self.HighlightedYear = dayButton and dayButton.Year;
	self.HighlightedAchievements = dayButton and dayButton.Achievements;
	self.HighlightedPoints = dayButton and dayButton.Points;
	if self.HighlightedAchievements then
		if addon.GUI.Calendar.SideFrame:IsShown() then
			addon.GUI.Calendar.SideFrame:Hide();
		end
		addon.GUI.Calendar.SideFrame:Show();
	else
		addon.GUI.Calendar.SideFrame:Hide();
	end
end

function KrowiAF_CalendarFrameMixin:SetToday(dayButton)
	local todayFrame = self.TodayFrame;
	todayFrame:SetParent(dayButton);
	todayFrame:ClearAllPoints();
	todayFrame:SetPoint("CENTER", dayButton, "CENTER");
	todayFrame:Show();
	local darkFrame = dayButton.DarkFrame;
	todayFrame:SetFrameLevel(darkFrame:GetFrameLevel() + 1);
end

function KrowiAF_CalendarFrameMixin:UpdateDay(index, day, month, year, isSelected, isToday, darkTopFlags, darkBottomFlags)
	local button = self.DayButtons[index];
	local dateLabel = button.DateFrame.Date;
	local darkFrame = button.DarkFrame;
	local darkTop = darkFrame.Top;
	local darkBottom = darkFrame.Bottom;

	button:Clear();

	dateLabel:SetText(day);
	button.Day = day;
	button.Month = month;
	button.Year = year;

	button.Dark = darkTopFlags and darkBottomFlags;
	if button.Dark then
		local tcoords = darkDayTopTexCoords[darkTopFlags];
		darkTop:SetTexCoord(tcoords.left, tcoords.right, tcoords.top, tcoords.bottom);
		tcoords = darkDayBottomTexCoords[darkBottomFlags];
		darkBottom:SetTexCoord(tcoords.left, tcoords.right, tcoords.top, tcoords.bottom);
		darkFrame:Show();
	else
		darkFrame:Hide();
	end

	if isSelected then
		button:Select();
		self:SetSelectedDay(button, true);
	end

	if isToday then
		self:SetToday(button);
	end
end

function KrowiAF_CalendarFrameMixin:SetLastDay(dayButton)
	self.LastDayDarkTexture:SetParent(dayButton);
	self.LastDayDarkTexture:ClearAllPoints();
	self.LastDayDarkTexture:SetPoint("BOTTOMRIGHT", dayButton, "BOTTOMRIGHT");
	self.LastDayDarkTexture:Show();
end

function KrowiAF_CalendarFrameMixin:SetPrevMonthDays(prevMonth, prevYear, prevNumDays, firstWeekday, selectedDay, selectedMonth, selectedYear, presentDay, presentMonth, presentYear, buttonIndex)
	local viewablePrevMonthDays = mod(firstWeekday - addon.Options.db.Calendar.FirstWeekDay - 1 + 7, 7);
	local day = prevNumDays - viewablePrevMonthDays;
	local isSelectedMonth = selectedMonth == prevMonth and selectedYear == prevYear;
	local isThisMonth = presentMonth == prevMonth and presentYear == prevYear;
	local darkTopFlags, darkBottomFlags;
	local isSelectedDay, isToday;
	while GetWeekdayIndex(buttonIndex) ~= firstWeekday do
		darkTopFlags = darkFlagPrevMonth + darkFlagSideTop;
		darkBottomFlags = darkFlagPrevMonth + darkFlagSideBottom;
		if buttonIndex == 1 then
			darkTopFlags = darkTopFlags + darkFlagSideLeft;
			darkBottomFlags = darkBottomFlags + darkFlagSideLeft;
		end
		if buttonIndex == firstWeekday - 1 then
			darkTopFlags = darkTopFlags + darkFlagSideRight;
			darkBottomFlags = darkBottomFlags + darkFlagSideRight;
		end

		isSelectedDay = isSelectedMonth and selectedDay == day;
		isToday = isThisMonth and presentDay == day;

		self:UpdateDay(buttonIndex, day, prevMonth, prevYear, isSelectedDay, isToday, darkTopFlags, darkBottomFlags);

		day = day + 1;
		buttonIndex = buttonIndex + 1;
	end

	return buttonIndex;
end

function KrowiAF_CalendarFrameMixin:SetMonthDays(month, year, numDays, selectedDay, selectedMonth, selectedYear, presentDay, presentMonth, presentYear, buttonIndex)
	local day = 1;
	local isSelectedMonth = selectedMonth == month and selectedYear == year;
	local isThisMonth = presentMonth == month and presentYear == year;
	local isSelectedDay, isToday;
	while day <= numDays do
		isSelectedDay = isSelectedMonth and selectedDay == day;
		isToday = isThisMonth and presentDay == day;

		self:UpdateDay(buttonIndex, day, month, year, isSelectedDay, isToday);

		day = day + 1;
		buttonIndex = buttonIndex + 1;
	end
	if buttonIndex < 36 and mod(buttonIndex - 1, 7) ~= 0 then
		self:SetLastDay(self.DayButtons[buttonIndex - 1]);
	end

	return buttonIndex;
end

function KrowiAF_CalendarFrameMixin:SetNextMonthDays(nextMonth, nextYear, selectedDay, selectedMonth, selectedYear, presentDay, presentMonth, presentYear, buttonIndex)
	local day = 1;
	local isSelectedMonth = selectedMonth == nextMonth and selectedYear == nextYear;
	local isThisMonth = presentMonth == nextMonth and presentYear == nextYear;
	local dayOfWeek;
	local checkCorners = mod(buttonIndex, 7) ~= 1;	-- last day of the viewed month is not the last day of the week
	local darkTopFlags, darkBottomFlags;
	local isSelectedDay, isToday;
	while buttonIndex <= maxDaysPerMonth do
		darkTopFlags = darkFlagNextMonth;
		darkBottomFlags = darkFlagNextMonth;
		-- left darkness
		dayOfWeek = GetDayOfWeek(buttonIndex);
		if dayOfWeek == 1 or day == 1 then
			darkTopFlags = darkTopFlags + darkFlagSideLeft;
			darkBottomFlags = darkBottomFlags + darkFlagSideLeft;
		end
		-- right darkness
		if dayOfWeek == 7 then
			darkTopFlags = darkTopFlags + darkFlagSideRight;
			darkBottomFlags = darkBottomFlags + darkFlagSideRight;
		end
		-- top darkness
		if not self.DayButtons[buttonIndex - 7].Dark then
			-- this day last week was not dark
			darkTopFlags = darkTopFlags + darkFlagSideTop;
		end
		-- bottom darkness
		if not self.DayButtons[buttonIndex + 7] then
			-- this day next week does not exist
			darkBottomFlags = darkBottomFlags + darkFlagSideBottom;
		end
		-- corner stuff
		if checkCorners and (day == 1 or day == 7 or day == 8) then
			darkTopFlags = darkTopFlags + darkFlagCorner;
		end

		isSelectedDay = isSelectedMonth and selectedDay == day;
		isToday = isThisMonth and presentDay == day;

		self:UpdateDay(buttonIndex, day, nextMonth, nextYear, isSelectedDay, isToday, darkTopFlags, darkBottomFlags);

		day = day + 1;
		buttonIndex = buttonIndex + 1;
	end
end

function KrowiAF_CalendarFrameMixin:Update()
	local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime();
	local presentDay = currentCalendarTime.monthDay;
	local presentMonth = currentCalendarTime.month;
	local presentYear = currentCalendarTime.year;

	local prevMonth, prevYear, prevNumDays = GetMonthInfo(-1);
	local month, year, numDays, firstWeekday = GetMonthInfo();
	local nextMonth, nextYear = GetMonthInfo(1);

	self.ViewedMonth = month;
	self.ViewedYear = year;

	local selectedDay = self.SelectedDay;
	local selectedMonth = self.SelectedMonth;
	local selectedYear = self.SelectedYear;

	self:UpdateTitle();
	self:UpdatePrevNextMonthButtons();
	self:UpdateWeekDays();
	self:HideAttributes();

	local buttonIndex = 1;
	buttonIndex = self:SetPrevMonthDays(prevMonth, prevYear, prevNumDays, firstWeekday, selectedDay, selectedMonth, selectedYear, presentDay, presentMonth, presentYear, buttonIndex);
	buttonIndex = self:SetMonthDays(month, year, numDays, selectedDay, selectedMonth, selectedYear, presentDay, presentMonth, presentYear, buttonIndex);
	self:SetNextMonthDays(nextMonth, nextYear, selectedDay, selectedMonth, selectedYear, presentDay, presentMonth, presentYear, buttonIndex);

    self:AddAchievementsToDays();
end

function KrowiAF_CalendarFrameMixin:GetEarnedAchievementsInRange()
    local firstDate = GetSecondsSince(self.DayButtons[1]);
    local lastDate = GetSecondsSince(self.DayButtons[maxDaysPerMonth]);

    local achievementIds = {};
    for achievementId, date in next, KrowiAF_SavedData.Characters[UnitGUID("player")].CompletedAchievements do
        if date >= firstDate and date <= lastDate then
            tinsert(achievementIds, achievementId);
        end
    end
    return achievementIds;
end

function KrowiAF_CalendarFrameMixin:SetAchievementsAndPoints(numAchievements, points)
	self.MonthAchievementsAndPoints:SetText(tostring(numAchievements) .. " " .. addon.L["Achievements"] .. " (" .. tostring(points) .. " " .. addon.L["Points"] .. ")");
end

function KrowiAF_CalendarFrameMixin:AddAchievementsToDays()
    local achievementIds = self:GetEarnedAchievementsInRange();
    local firstDate = GetSecondsSince(self.DayButtons[1]);
	self.NumAchievements, self.TotalPoints = 0, 0;
	local points, icon;
	local date, dayButtonIndex, dayButton;
    for _, achievementId in next, achievementIds do
        _, _, points, _, _, _, _, _, _, icon = addon.GetAchievementInfo(achievementId);
        date = KrowiAF_SavedData.Characters[UnitGUID("player")].CompletedAchievements[achievementId];
        dayButtonIndex = floor((date - firstDate) / 86400 + 1); -- 86400 seconds in a day, floor to take changes in DST which would result in x.xx
		dayButton = self.DayButtons[dayButtonIndex];
        AddAchievementToButton(dayButton, achievementId, icon, points);
		if not dayButton.Dark then
			self.NumAchievements = self.NumAchievements + 1;
			self.TotalPoints = self.TotalPoints + points;
		end
    end
	self:SetAchievementsAndPoints(self.NumAchievements, self.TotalPoints);
end