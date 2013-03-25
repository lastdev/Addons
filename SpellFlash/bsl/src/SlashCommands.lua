local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "SlashCommands", 1) then
	return
end

local GetCVar = GetCVar
local SetCVar = SetCVar
local print = print

local function regCommand(subCommand, func)
	u.RegisterSlashCommand("bsf", subCommand, func)
end

local function taggedPrint(tag, ...)
	print("|cFF00FFFF["..tag.."]|r", ...)
end

---------------------------------------------------------------------- AoE Mode
c.AoE = false

function c.ToggleAoE()
	if c.AoE then
		c.AoE = false
	    taggedPrint("Lib", "AoE mode off")
	else
    	c.AoE = true
    	taggedPrint("Lib", "AoE mode on")
    end
end

regCommand("aoe", c.ToggleAoE)

-------------------------------------------------------------- Debugging Output
c.Debugging = false

function c.Debug(tag, ...)
	if c.Debugging then
		taggedPrint(tag, ...)
	end
end

function c.ToggleDebugging()
	if c.Debugging then
		c.Debug("Lib", "Debugging off")
		c.Debugging = false
	else
		c.Debugging = true
		c.Debug("Lib", "Debugging on")
	end
end

regCommand("debug", c.ToggleDebugging)

---------------------------------------------------------- Floating Combat Text
function c.ToggleFloatingCombatText()
	if GetCVar("CombatDamage") == "0" then
		SetCVar("CombatDamage", 1)
		SetCVar("enableCombatText", 1)
		taggedPrint("Lib", "Floating Combat Text on")
	else
		SetCVar("CombatDamage", 0)
		SetCVar("enableCombatText", 0)
		taggedPrint("Lib", "Floating Combat Text off")
	end
end

regCommand("floatingcombattext", c.ToggleFloatingCombatText)
regCommand("fct", c.ToggleFloatingCombatText)
