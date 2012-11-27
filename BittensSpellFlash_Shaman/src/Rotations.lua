local AddonName, a = ...
if a.BuildFail(50000) then return end

local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

a.Rotations = {}
a.SetSpamFunction(function()
    c.Flash(a)
end)

a.Rotations.Elemental = {
    Spec = 1,
    OffSwitch = "elemental_off",
    
    FlashInCombat = function()
        c.FlashAll(
        	"Elemental Mastery", 
            "Ascendance for Elemental",
            "Ancestral Swiftness",
        	"Wind Shear")
        c.PriorityFlash(
            "Fire Elemental Totem",
            "Unleash Elements for Elemental",
            "Lava Burst",
            "Flame Shock for Elemental",
        	"Elemental Blast",
            "Earth Shock for Fulmination",
            "Earth Elemental Totem",
            "Searing Totem for Elemental",
            "Lightning Bolt")
    end,
    
    FlashOutOfCombat = function()
        c.FlashAll("Thunderstorm")
    end,
    
    FlashAlways = function()
        c.FlashAll("Lightning Shield", "Flametongue Weapon")
    end,
}

a.Rotations.Enhancement = {
	Spec = 2,
	OffSwitch = "enhance_off",
    
    FlashInCombat = function()
    	if c.IsCasting("Lightning Bolt") 
    		and not c.HasBuff("Ancestral Swiftness") then
    		
    		a.Maelstrom = 0
    	else
	    	a.Maelstrom = c.GetBuffStack("Maelstrom Weapon")
    	end
    	
        c.FlashAll(
        	"Elemental Mastery", 
        	"Fire Elemental Totem",
        	"Ascendance", 
        	"Wind Shear")
        c.PriorityFlash(
        	"Searing Totem",
        	"Unleash Elements with Unleashed Fury",
        	"Elemental Blast",
            "Lightning Bolt at 5",
            "Stormstrike",
            "Flame Shock under Unleash Flame",
            "Lava Lash",
            "Flame Shock Overwrite under Unleash Flame",
            "Unleash Elements",
            "Lightning Bolt at 4",
            "Ancestral Swiftness under 2",
            "Lightning Bolt under Ancestral Swiftness",
            "Earth Shock",
            "Feral Spirit",
            "Earth Elemental Totem",
            "Lightning Bolt at 2")
    end,
    
    FlashAlways = function()
        c.FlashAll(
        	"Lightning Shield", "Windfury Weapon", "Flametongue Weapon Offhand")
    end,
}