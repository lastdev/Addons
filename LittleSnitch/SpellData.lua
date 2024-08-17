-- All SpellIDs go here
local addonName, vars = ...
vars.spellData = {}

vars.spellData.ccspells = {
	118, -- Polymorph Sheep
	61721, -- Polymorph Rabbit
	61305, -- Polymorph Black Cat
	28271, -- Polymorph Turtle
	28272, -- Polymorph Pig
	61780, -- Polymorph Turkey
    126819, -- Polymorph Porcupine
    161353, -- Polymorph Polar Bear Cub
    161354, -- Polymorph Monkey
    277787, -- Polymorph Baby Direhorn
    391622, -- Polymorph Duck
	9484, -- Shackle Undead
	3355, -- Freezing Trap (Effect)
	6770, -- Sap
	20066, -- Repentance
	5782, -- Fear
	2094, -- Blind
	51514, -- Hex
	19386, -- Wyvern Sting
	710, -- Banish
	10326, -- Turn Evil
	6358, -- Seduction
	115268, -- Mesmerize
	339, -- Entangling Roots
	115078, -- Paralysis (Monk)
	122224, -- Impaling Spear (HoF: Wind Lord Mel'jarak)
	122220, -- Impaling Spear (HoF: Wind Lord Mel'jarak)
	217832, -- Imprison (Demon Hunter)
 	82691, -- Ring of Frost
}

-- Debuffs that can be applied to a cc target without breaking it
vars.spellData.ccsafeauras = {
	5484,  -- Howl of Terror
	3600,  -- Earthbind totem
	31589, -- Slow
	1160, -- Demo Shout
	5246, -- Intimidating Shout
	12323, -- Piercing Howl
	8122, -- Psychic Scream
	15487, -- Silence
	13810, -- Ice trap
	-- 56845, -- Glyph of Freezing Trap
	5116, -- Concussive Shot
	853, -- Hammer of Justice
	408, -- Kidney Shot
	2094, -- Blind
	1833, -- Cheap Shot
	77606, -- Dark Simulacrum
	47476, -- Strangulate
}

vars.spellData.brezSpells = {
	20484, -- Rebirth (Druid)
	20608, -- Reincarnation (Shaman) -- no combat log event?
	20707, -- Soulstone Applied (Warlock) - There is no combat log event for using a soulstone :-(
	95750, -- Soulstone Resurrection (Warlock) - this is the SPELL_RESURRECT
	61999, -- Raise Ally (DK)
	391054, -- Intercession (Paladin)
	385403, -- Arclight Vital Correctors (Engineer)
}

vars.spellData.rezSpells = {
	7328,   -- Redemption (Paladin)
	2008,   -- Ancestral Spirit (Shaman)
	50769,  -- Revive (Druid)
	2006,   -- Resurrection (Priest)
	115178, -- Resuscitate (Monk)
	361227, -- Return (Evoker)
	54732,  -- Defibrillate (Engineer)
	-- 83968, -- Mass Resurrection
	212036, -- Mass Resurrection (Holy, Discipline Priest)
	212040, -- Revitalize (Restoration Druid)
	212051, -- Reawaken (Mistweaver Monk)
	212056, -- Absolution (Holy Paladin)
	212048, -- Ancestral Vision (Restoration Shaman)
	361178, -- Mass Return (Preservation Evoker)
}

vars.spellData.misdirectSpells = {
	34477, -- Misdirection (Hunter)
	57934, -- Tricks of the Trade (Rogue)
	-- 110588, -- Tricks of the Trade (Rogue) -- Old
}

vars.spellData.tauntSpells = {
	355,   -- Taunt (Warrior)
	-- 21008, -- Mocking Blow (Warrior)
	62124, -- Hand of Reckoning (Paladin)
	6795,  -- Growl (Druid)
	56222, -- Dark Command (Death Knight)
	49576, -- Death Grip (Death Knight)
	20736, -- Distracting Shot (Hunter)
	116189, -- Provoke (Monk)
	17735, -- Suffering (Warlock Voidwalker)
	171014, -- Seethe (Warlock Abyssal)
	2649,  -- Growl (Hunter Pet)
	-- 53477, -- Taunt (Hunter Pet)
	185245, -- Torment (Demon Hunter)
}

vars.spellData.aoetauntSpells = {
	-- 1161,  -- Challenging Shout (Warrior)
	-- 31789, -- Righteous Defense (Paladin)
	-- 5209,  -- Challenging Roar (Druid)
	82407, -- Painful Shock (Engineering Malfunction)
	36213, -- Angered Earth (Shaman Earth Elemental), unfortunately no visible debuff
	-- 59671, -- Challenging Howl (Warlock)  3.x
}

vars.spellData.deathgrip = 49576