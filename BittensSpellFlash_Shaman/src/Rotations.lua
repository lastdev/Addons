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
        c.FlashAll("Elemental Mastery", "Wind Shear")
        c.PriorityFlash(
        	"Elemental Blast",
            "Fire Elemental Totem",
            "Ancestral Swiftness",
            "Unleash Elements",
            "Lava Burst",
            "Flame Shock",
            "Earth Shock for Fulmination",
            "Earth Elemental Totem",
            "Searing Totem",
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
    	a.Maelstrom = c.GetBuffStack("Maelstrom Weapon")
    	if c.IsCasting("Lightning Bolt") 
    		and not c.HasBuff("Ancestral Swiftness") then
    		
    		a.Maelstrom = 0
    	end
    	
        c.FlashAll("Elemental Mastery", "Fire Elemental Totem", "Wind Shear")
        c.PriorityFlash(
        	"Searing Totem",
            "Lightning Bolt at 5",
            "Stormstrike",
            "Lava Lash",
            "Unleash Elements",
            "Lightning Bolt at 4",
            "Ancestral Swiftness under 3",
            "Lightning Bolt under Ancestral Swiftness",
            "Flame Shock under Unleash Flame",
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