local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local _G = _G
local pairs = pairs

BINDING_HEADER_BITTENS_SPELLFLASH = L["Bitten's SpellFlash"]
BINDING_NAME_BITTENS_SPELLFLASH_AOE = L["Toggle AoE Mode"]
BINDING_NAME_BITTENS_SPELLFLASH_DEBUGGING = L["Print Debugging Info"]
BINDING_NAME_BITTENS_SPELLFLASH_FLOATING_TEXT = L["Toggle Floating Combat Text"]
BINDING_NAME_BITTENS_SPELLFLASH_DAMAGE_MODE = L["Toggle Damage Mode in Groups"]

a.AddonName = addonName
a.Options = {
	Flash = {
		Widget = "LeftCheckButton1",
		Label = L["Print Flash Tag"],
		Default = true,
	},
	Event = {
		Widget = "LeftCheckButton2",
		Label = L["Print Event Tag"],
		Default = true,
	},
	
	["Cast Event"] = {
		Widget = "RightCheckButton1",
		Label = L["Print Cast Event Tag"],
		Default = false,
	},
	["Log Event"] = {
		Widget = "RightCheckButton2",
		Label = L["Print Log Event Tag"],
		Default = false,
	},
	
	BlizHighlights = {
		Widget = "LeftCheckButton7",
		Label = L["Use Blizzard Proc Animation"],
		Default = false,
	},
}

local parent = addonName .. "_SpellFlashAddonOptionsFrame"

local function synchronizeMain()
	local desired = not not _G[parent.."_SpellFlashing"]:GetChecked()
	local current = c.IsTagOn("Debugging Info")
	if desired ~= current then
		c.ToggleDebugging("Debugging Info")
	end
end

local function synchronize(name)
	if name == "BlizHighlights" then
		if not c.GetOption("BlizHighlights") 
			~= not c.AlwaysShowBlizHighlights then
			
			c.ToggleAlwaysShowBlizHighlights()
		end
		return
	end
	
	local desired = c.GetOption(name)
	local current = c.IsTagOn(name)
	if desired ~= current then
		c.ToggleDebugging(name)
	end
end

local frame = CreateFrame(
	"Frame", parent, nil, "SpellFlashAddon_OptionsFrameTemplate2")
frame.parent = select(2, GetAddOnInfo("SpellFlash"))
frame.name = L["Bitten's Debugging Options"]
_G[parent .. "TitleString"]:SetText(
	frame.name .. " " .. GetAddOnMetadata(addonName, "Version"))
_G[parent .. "_SpellFlashingText"]:SetText(L["Print Debugging Info"])
c.Init(a)
for name, option in pairs(a.Options) do
	local widgetName = parent .. option.Widget
	local label = _G[widgetName .. "Text"]
	_G[widgetName]:Show()
	label:Show()
	label:SetText(option.Label)
	synchronize(name)
end
c.Init(nil)
InterfaceOptions_AddCategory(frame)

frame.okay = function()
	synchronizeMain()
	
	c.Init(a)
	for name, option in pairs(a.Options) do
		c.SetOption(name, not not _G[parent .. option.Widget]:GetChecked())
		synchronize(name)
	end
	c.Init(nil)
end

frame.refresh = function()
	_G[parent .. "_SpellFlashing"]:SetChecked(c.ShouldPrint["Debugging Info"])
	
	c.Init(a)
	for name, option in pairs(a.Options) do
		_G[parent .. option.Widget]:SetChecked(c.GetOption(name))
	end
	c.Init(nil)
end

frame.default = function()
	c.ShouldPrint["Debugging Info"] = false
	synchronizeMain()
	
	s.ClearAllModuleConfigs(addonName)
	c.Init(a)
	for name, _ in pairs(a.Options) do
		synchronize(name)
	end
	c.Init(nil)
end
