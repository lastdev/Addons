local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "SlashCommands", 6) then
	return
end

local GetCVar = GetCVar
local SetCVar = SetCVar
local print = print

local function regCommand(subCommand, func)
	u.RegisterSlashCommand("bsf", subCommand, func)
end

local function taggedPrint(tag, ...)
	print("|cFF00FFFF[" .. tag .. "]|r", ...)
end

local function libPrint(...)
	taggedPrint("Lib", ...)
end

---------------------------------------------------------------------- AoE Mode

-- This variable is considered a public API.  Keep it working.
c.AoE = false

function c.ToggleAoE()
	c.AoE = not c.AoE
	libPrint("AoE Mode:", c.AoE)
end

regCommand("aoe", c.ToggleAoE)

-------------------------------------------------------------- Debugging Output
c.ShouldPrint = { 
	["Debugging Info"] = false,
	["Cast Event"] = false,
	["Log Event"] = false,
}

function c.Debug(tag, ...)
	if c.ShouldPrint["Debugging Info"] and c.ShouldPrint[tag] ~= false then
		taggedPrint(tag, ...)
	end
end

function c.ToggleDebugging(tag)
	if tag == nil or tag == "" then
		tag = "Debugging Info"
	end
	c.ShouldPrint[tag] = c.ShouldPrint[tag] == false
	libPrint("Print " .. tag .. ":", c.ShouldPrint[tag])
end

function c.IsTagOn(tag)
	if tag == "Debugging Info" then
		return not not c.ShouldPrint[tag]
	else
		return c.ShouldPrint[tag] ~= false
	end
end

regCommand("debug", c.ToggleDebugging)

---------------------------------------------------------- Floating Combat Text
function c.ToggleFloatingCombatText()
	if GetCVar("CombatDamage") == "0" then
		SetCVar("CombatDamage", 1)
		SetCVar("enableCombatText", 1)
		SHOW_COMBAT_TEXT = "1"
		libPrint("Floating Combat Text on")
	else
		SetCVar("CombatDamage", 0)
		SetCVar("enableCombatText", 0)
		SHOW_COMBAT_TEXT = "0"
		libPrint("Floating Combat Text off")
	end
	if (CombatText_UpdateDisplayedMessages) then
		CombatText_UpdateDisplayedMessages() 
	end
end

regCommand("floatingcombattext", c.ToggleFloatingCombatText)
regCommand("fct", c.ToggleFloatingCombatText)

--------------------------------------------------------------- Bliz Highlights
function c.ToggleAlwaysShowBlizHighlights()
	c.AlwaysShowBlizHighlights = not c.AlwaysShowBlizHighlights
	libPrint("Use Blizzard Proc Animations:", c.AlwaysShowBlizHighlights)
end

regCommand("blizprocs", c.ToggleAlwaysShowBlizHighlights)

--------------------------------------------------------- Damage Mode in Groups

-- This function is considered a public API.  Keep it working.
function c.InDamageMode()
	return c.IsSolo() 
		and c.GetHealthPercent("player") > 50 
		or c.DamageModeInGroups
end

function c.ToggleDamageModeInGroups()
	c.DamageModeInGroups = not c.DamageModeInGroups
	libPrint("Damage Mode in Groups:", c.DamageModeInGroups)
end

regCommand("damage", c.ToggleDamageModeInGroups)
