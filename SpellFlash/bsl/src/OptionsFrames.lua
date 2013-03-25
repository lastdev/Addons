local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "OptionsFrames", 2) then
	return
end

local s = SpellFlashAddon

local _G = _G
local LE_LFG_CATEGORY_LFD = LE_LFG_CATEGORY_LFD
local LE_LFG_CATEGORY_LFR = LE_LFG_CATEGORY_LFR
local LE_LFG_CATEGORY_RF = LE_LFG_CATEGORY_RF
local LE_LFG_CATEGORY_SCENARIO = LE_LFG_CATEGORY_SCENARIO
local CreateFrame = CreateFrame
local GetAddOnInfo = GetAddOnInfo
local GetLFGQueueStats = GetLFGQueueStats
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory
local UnitInRange = UnitInRange
local UnitIsUnit = UnitIsUnit
local pairs = pairs
local print = print
local select = select
local tonumber = tonumber
local tostring = tostring
local type = type

function c.SetOption(name, value)
	if c.A.Options[name] == nil then
		print("Invalid option name:", name)
	end
	if value == c.A.Options[name].Default then
		value = nil
	end
	u.GetOrMakeTable(s.config.MODULE, c.A.AddonName)[name] = value
end

function c.HasOption(name)
	return u.GetFromTable(s.config.MODULE, c.A.AddonName, name) ~= nil
end

function c.GetOption(name)
	if c.A.Options[name] == nil then
		print("Invalid option name:", name)
	end
	local value = u.GetFromTable(s.config.MODULE, c.A.AddonName, name)
	if value == nil then
		return c.A.Options[name].Default
	else
		return value
	end
end

function c.AddRotationSwitches()
	local options = u.GetOrMakeTable(c.A, "Options")
	for name, rotation in pairs(c.A.Rotations) do
		if rotation.Spec then
			options["Flash" .. name] = {
				Widget = "LeftCheckButton" .. rotation.Spec,
				Label = c.A.Localize["Flash " .. name],
				Default = true,
			}
		end
	end
end

function c.AddSoloSwitch()
	local maxSpec = 0
	for _, rotation in pairs(c.A.Rotations) do
		local spec = rotation.Spec
		if spec and spec > maxSpec then
			maxSpec = spec
		end
	end
	u.GetOrMakeTable(c.A, "Options").SoloMode = {
		Widget = "LeftCheckButton" .. (maxSpec + 2),
		Label = c.A.Localize["Solo Mode when not Grouped"],
		Default = true,
	}
end

function c.IsSolo(checkIfQueued)
	return not s.InRaidOrParty()
		and (not c.HasOption("SoloMode") or c.GetOption("SoloMode"))
		and not (checkIfQueued
			and (GetLFGQueueStats(LE_LFG_CATEGORY_LFD)
				or GetLFGQueueStats(LE_LFG_CATEGORY_LFR)
				or GetLFGQueueStats(LE_LFG_CATEGORY_RF)
				or GetLFGQueueStats(LE_LFG_CATEGORY_SCENARIO)))
end

function c.RegisterOptions()
	local a = c.A
	local addonName = a.AddonName
	local parent = addonName .. "_SpellFlashAddonOptionsFrame"
	local frame = CreateFrame(
		"Frame", parent, nil, "SpellFlashAddon_OptionsFrameTemplate2")
	for name, option in pairs(a.Options) do
		local widgetName = parent .. option.Widget
		local widget = _G[widgetName]
		local label = _G[widgetName .. "Text"]
		widget:Show()
		label:Show()
		if option.Type == "editbox" then
			widget:SetMaxLetters(tonumber(option.MaxCharacters) or 999)
			widget:SetNumeric(option.Numeric or false)
			_G[widgetName .. "TextLabel"]:SetText(option.Label or "")
		else
			label:SetText(option.Label or "")
		end
	end
	frame.parent = select(2, GetAddOnInfo("SpellFlash"))
	frame.name = select(2, GetAddOnInfo(addonName))
	InterfaceOptions_AddCategory(frame)
	s.RegisterModuleOptionsWindow(addonName, frame)
	
	frame.okay = function()
		c.Init(a)
		for name, option in pairs(a.Options) do
			local value
			local widget = _G[parent .. option.Widget]
			if option.Type == "editbox" then
				if option.Numeric then
					value = widget:GetNumber() or 0
				else
					value = widget:GetText() or ""
				end
			else
				value = not not widget:GetChecked()
			end
			c.SetOption(name, value)
		end
	end
	
	frame.refresh = function()
		c.Init(a)
		_G[parent .. "_SpellFlashing"]:SetChecked(
			not s.GetModuleConfig(a.AddonName, "spell_flashing_off"))
		for name, option in pairs(a.Options) do
			local value = c.GetOption(name)
			local widget = _G[parent .. option.Widget]
			if option.Type == "editbox" then
				if option.Numeric then
					widget:SetNumber(value)
				else
					widget:SetText(value)
				end
			else
				widget:SetChecked(value)
			end
		end
	end
	
	function frame.default()
		s.ClearAllModuleConfigs(a.AddonName)
	end
end
