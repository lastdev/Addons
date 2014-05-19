local _, class = UnitClass("player")
if class ~= "MONK" then
	return
end

local addonName, a = ...
local L = a.Localize
local u = BittensGlobalTables.GetTable("BittensUtilities")

local _G = _G
local GetSpellInfo = GetSpellInfo
local ipairs = ipairs
local pairs = pairs
local math = math
local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton
local UIDropDownMenu_CreateInfo = UIDropDownMenu_CreateInfo
local UIDropDownMenu_SetText = UIDropDownMenu_SetText

-------------------------------------------------------------------- Main Panel
local mainPanel = u.CreateOptionsPanel(addonName)
local x, y = 16, -16
y = mainPanel.AddGroup(addonName, { 
	4, u.CreateLabel(
		L["Note: To move the meter, hold Alt then drag the icon."], 
		"GameFontGreen"),
	8, u.CreateSliderOption(
		"MeterWidth", L["Meter Width"] .. ": %s", 500, 0, 600, 400), 
	2, u.CreateSliderOption(
		"MeterHeight", L["Meter Height"] .. ": %s", 24, 24, 100, 400), 
	8, u.CreateCheckBoxOption(
		"HideWhenNotStaggering", 
		L["Hide StaggerMeter when not Staggering Damage"], 
		false), 
	u.CreateCheckBoxOption(
		"MeterLock", L["Lock StaggerMeter's Position"], false),
	u.CreateCheckBoxOption(
		"RightClick", L["Right Click Icon to Show Options"], true),
	8, L["Fill Meters Based On"], 
	2, u.CreateDropdownOption(
		"MeterFill", "damage", 200,
		{ Value = "damage", Text = L["Total Damage"] },
		{ Value = "dps", Text = L["Damage Per Second"] }), 
}, x, y)

local function addSoundOption(color, staggerId)
	local staggerName = GetSpellInfo(staggerId)
	y = mainPanel.AddGroup(nil, {
		4, L["Sound Played When Icon Turns %s"]:format(L[color]), 
		2, u.CreateLabel(
			L["Icon color may or may not coincide with %s. See Icon Color Setup."]
				:format(staggerName), 
			"GameFontRedSmall"), 
		2, u.CreateDropdownOption(
			color .. "Sound", "None", 100, 
			{ Value = "None", Text = L["None"] }, 
			{ Value = "Boiling", Text = L["Boiling"] }, 
			{ Value = "Laser", Text = L["Laser"] }), 
	}, x, y)
end
addSoundOption("Yellow", 124274)
addSoundOption("Red", 124273)

function mainPanel.apply(eventSource, value)
	local SPECIALIZATION = 3
	a.SM_PositionFrames()
	a.SM_ShowHide(SPECIALIZATION)
	if eventSource == "YellowSound" or eventSource == "RedSound" then
		a.PlaySound(value)
	end
end

------------------------------------------------------------ Display Text Panel
local displayPanel = u.CreateOptionsPanel(L["Display Text"], mainPanel)
displayPanel.AddGroup(L["Display Text"], { 
		2, 
		u.CreateCheckBoxOption(
			"DisplayTotalDamage", 
			L["Total Damage"] .. " (" .. L["d"] .. ")",
			true),
		u.CreateCheckBoxOption(
			"DisplayDPS", 
			L["Damage Per Second"] .. " (" .. L["d/s"] .. ")",
			false),
		u.CreateCheckBoxOption(
			"DisplayPercentOfCurrent", 
			L["Percentage of Current Health"] .. " (%" .. L["h"] .. ")",
			true),
		u.CreateCheckBoxOption(
			"DisplayDPSPercentOfCurrent", 
			L["Percentage of Current Health Per Second"] 
				.. " (%" .. L["h/s"] .. ")",
			false),
		u.CreateCheckBoxOption(
			"DisplayPercentOfMax", 
			L["Percentage of Max Health"] .. " (%" .. L["mh"] .. ")",
			false),
		u.CreateCheckBoxOption(
			"DisplayDPSPercentOfMax", 
			L["Percentage of Max Health Per Second"] 
				.. " (%" .. L["mh/s"] .. ")",
			false),
		u.CreateCheckBoxOption(
			"DisplaySecondsRemaining", 
			L["Seconds Remaining"] .. " (" .. L["s"] .. ")",
			false),
	}, 
	16, -16)

function displayPanel.apply()
	a.SM_DisplayText(0, 0, 0, 0)
end

-------------------------------------------------------------- Icon Color Setup
local iconPanel = u.CreateOptionsPanel(L["Icon Color Setup"], mainPanel)

local presets = {
	{
		Text = L["Blizzard's Configuration"],
		Settings = {
			TurnOnPercentOf = "max",
			TurnOnPeriod = "second",
			TurnYellow = 3, 
			TurnRed = 6,
		},
	},
	{
		Text = L["StaggerMeter's Configuration"],
		Settings = {
			TurnOnPercentOf = "current",
			TurnOnPeriod = "total",
			TurnYellow = 20, 
			TurnRed = 40,
		}
	},
}

local function presetMatches(preset)
	for k, v in u.Pairs(preset.Settings) do
		if v ~= iconPanel.GetValue(k) then
			return false
		end
	end
	return true
end

local widgetName = iconPanel.WidgetBaseName .. "IconPreset"
local presetDrop = CreateFrame(
	"Frame", widgetName, iconPanel, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(presetDrop, 200)
UIDropDownMenu_SetButtonWidth(presetDrop, 200)
UIDropDownMenu_JustifyText(presetDrop, "LEFT")
UIDropDownMenu_Initialize(presetDrop, function()
	for _, preset in ipairs(presets) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = preset.Text
		info.checked = presetMatches(preset)
		info.func = function()
			for k, v in pairs(preset.Settings) do
				iconPanel.Settings[k] = v
			end
			iconPanel.apply()
			iconPanel.refresh()
		end
		UIDropDownMenu_AddButton(info)
	end
end)

iconPanel.AddGroup(L["Icon Color Setup"], { 
		8, L["Select Preset"],
		2, presetDrop,
		4, L["Set Values Based on % of"],
		2, u.CreateDropdownOption(
			"TurnOnPercentOf", 
			"max", 
			200, 
			{ Value = "max", Text = L["Maximum Health"] }, 
			{ Value = "current", Text = L["Current Health"] }), 
		4, L["Set Values Based on Damage Staggered"], 
		2, u.CreateDropdownOption(
			"TurnOnPeriod", 
			"second", 
			200, 
			{ Value = "second", Text = L["Per Second"] }, 
			{ Value = "total", Text = L["Total"] }), 
		8, u.CreateSliderOption(
			"TurnYellow", L["Geen to Yellow at"] .. " %s%%", 3, 0, 100, 400), 
		2, u.CreateSliderOption(
			"TurnRed", L["Yellow to Red at"] .. " %s%%", 6, 0, 100, 400), 
	}, 
	16, -16)

function iconPanel.apply(eventSource, value)
	if eventSource == "TurnYellow" then
		if value >= iconPanel.GetValue("TurnRed") then
			iconPanel.Settings.TurnRed = value + 1
			iconPanel.refresh()
		end
	elseif eventSource == "TurnRed" then
		if value <= iconPanel.GetValue("TurnYellow") then
			iconPanel.Settings.TurnYellow = value - 1
			iconPanel.refresh()
		end
	end
	
	for preset in u.Values(presets) do
		if presetMatches(preset) then
			UIDropDownMenu_SetText(presetDrop, preset.Text)
			return
		end
	end
	UIDropDownMenu_SetText(presetDrop, L["Custom Configuration"])
end

-------------------------------------------------------- Backward Compatibility
local settings

local function transferSettings(...)
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		local oldName = "SMDS_" .. name
		local oldValue = _G[oldName]
		if oldValue ~= nil then
			settings[name] = oldValue
			_G[oldName] = nil
		end
	end
end

local function backwardCompatibility()
	settings = u.GetOrMakeTable(_G, "StaggerMeterSettings")
	
	-- main panel
	transferSettings(
		"MeterWidth",
		"MeterHeight",
		"HideWhenNotStaggering",
		"YellowSound",
		"RedSound") 
	if SMDS_MeterFillByDamage ~= nil then
		settings.MeterFill = SMDS_MeterFillByDamage and "damage" or "dps"
		SMDS_MeterFillByDamage = nil
	end
	
	-- display panel
	transferSettings(
		"DisplayTotalDamage", 
		"DisplayDPS", 
		"DisplayPercentOfCurrent", 
		"DisplayDPSPercentOfCurrent", 
		"DisplayPercentOfMax", 
		"DisplayDPSPercentOfMax", 
		"DisplaySecondsRemaining")
	
	-- icon panel
	transferSettings("TurnYellow", "TurnRed")
	if SMDS_CurrentHealth ~= nil then
		settings.TurnOnPercentOf = SMDS_CurrentHealth and "current" or "max"
		SMDS_CurrentHealth = nil
	end
	if SMDS_HealthCompounded ~= nil then
		settings.TurnOnPeriod = SMDS_HealthCompounded and "total" or "second"
		SMDS_HealthCompounded = nil
	end
	SMDS_StaggerColorScheme = nil
end

-------------------------------------------------------------- Public Interface
function a.GetOption(name)
	return mainPanel.GetValue(name)
end

function a.InitializeOptions()
	backwardCompatibility()
	mainPanel.Initialize("StaggerMeterSettings")
	displayPanel.Initialize()
end

function a.ToggleOptions()
	u.ToggleOptionsPanel(mainPanel)
end
