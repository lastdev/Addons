local addonName = "Altoholic"
local addon = _G[addonName]

local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicCalendar", { "AltoholicUI.Events", "AddonFactory.Dates", function(Events, Dates)

	local warningTypes = {
		L["Profession Cooldowns"],
		L["Dungeon Resets"],
		L["Calendar Events"],
		L["Item Timers"]
	}

	local function IsNumberInString(number, str)
		-- ex: with str = "15,10,3" returns true if value is in this string
		for v in str:gmatch("(%d+)") do
			if tonumber(v) == number then
				return true
			end
		end
	end
	
	local function ToggleWarningThreshold(self)
		local id = self.arg1
		local warnings = Altoholic_Calendar_Options[format("WarningType%d", id)]		-- Gets something like "15,5,1"

		local checkedValues = AddonFactory:GetTable()
		
		for v in warnings:gmatch("(%d+)") do
			v = tonumber(v)
			if v ~= self.value then		-- add all values except the one that was clicked
				table.insert(checkedValues, v)
			end
		end
		
		if not IsNumberInString(self.value, warnings) then		-- if number is not yet in the string, save it (we're checking it, otherwise we're unchecking)
			table.insert(checkedValues, self.value)
		end
		
		Altoholic_Calendar_Options[format("WarningType%d", id)] = table.concat(checkedValues, ",")		-- Sets something like "15,5,10,1"
		AddonFactory:ReleaseTable(checkedValues)
	end

	local function WarningType_Initialize(self)
		local info = self:CreateInfo()
		local id = self:GetID()
		local warnings = Altoholic_Calendar_Options[format("WarningType%d", id)]		-- Gets something like "15,5,1"
		
		for _, threshold in pairs(Events.GetTimerThresholds()) do
			info.text = format(D_MINUTES, threshold)
			info.value = threshold
			info.func = ToggleWarningThreshold
			info.checked = IsNumberInString(threshold, warnings)
			info.arg1 = id		-- save the id of the current option
			
			self:AddButtonInfo(info, 1)
		end
	end

	return {
		__Parent = AltoholicFrame.TabOptions,
	
		OnBind = function(frame, parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(4, frame)

			local colors = AddonFactory.Colors
			
			-- Setup localization & clear localized value after use (no longer needed)
			frame.Title:SetText(format("%s%s", colors.white, L["Calendar Options"]))
			frame.WeekStartsOnMonday.Text:SetText(L["Week starts on Monday"])

			L["Calendar Options"] = nil
			L["Week starts on Monday"] = nil
			L["Warn %d minutes before an event starts"] = nil
			
			-- Setup the drop down menus
			for i = 1, 4 do 
				local f = frame[format("WarningType%d", i)]
				
				f:SetMenuWidth(160) 
				f:SetButtonWidth(20) 
				f:SetText(warningTypes[i])
				f:Initialize(WarningType_Initialize)
			end
			L["Profession Cooldowns"] = nil
			L["Dungeon Resets"] = nil
			L["Calendar Events"] = nil
			L["Item Timers"] = nil
			warningTypes = nil
			
		end,
		Update = function(frame, isResizing)
			frame.WeekStartsOnMonday:SetChecked(Altoholic_Calendar_Options["WeekStartsOnMonday"])
			frame.UseDialogBoxForWarnings:SetChecked(Altoholic_Calendar_Options["UseDialogBoxForWarnings"])
			frame.WarningsEnabled:SetChecked(Altoholic_Calendar_Options["WarningsEnabled"])
			
			frame:Show()
		end,
		
		ToggleWeekStart = function(frame, isChecked)
			if isChecked then 
				Altoholic_Calendar_Options["WeekStartsOnMonday"] = true
				Dates.SetFirstDayOfWeek(2)
			else
				Altoholic_Calendar_Options["WeekStartsOnMonday"] = false
				Dates.SetFirstDayOfWeek(1)
			end
						
			if C_AddOns.IsAddOnLoaded("Altoholic_Agenda") then
				--Altoholic.Calendar:Update()
			end
		end,
	}
end})
