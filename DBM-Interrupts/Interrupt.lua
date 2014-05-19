local mod = DBM:NewMod("Interrupt Cooldowns", "DBM-Interrupts")
mod:SetRevision("Revision 5.4.3")

mod:RegisterEvents("SPELL_CAST_SUCCESS")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 47476 then --DK Strangulate
		DBM:CreatePizzaTimer(60," Strangle"..args.sourceName)
		end
	if args.spellId == 47528 then --DK Mind Freeze
		DBM:CreatePizzaTimer(15," MFreeze"..args.sourceName)
		end
	if args.spellId == 106839 then --Druid Skull Bash
		DBM:CreatePizzaTimer(15," SBash"..args.sourceName)
		end
	if args.spellId == 147362 then --Hunter Counter Shot
		DBM:CreatePizzaTimer(24," CShot"..args.sourceName)
		end
	if args.spellId == 34490 then --Hunter Silencing Shot
		DBM:CreatePizzaTimer(24," SShot"..args.sourceName)
		end
	if args.spellId == 2139 then --Mage Counter Spell
		DBM:CreatePizzaTimer(24," CSpell"..args.sourceName)
		end
	if args.spellId == 116705 then --Monk Spear Hand Strike
		DBM:CreatePizzaTimer(15," SHStrike"..args.sourceName)
		end
	if args.spellId == 1766 then --Rogue Kick
		DBM:CreatePizzaTimer(15," Kick"..args.sourceName)
		end
	if args.spellId == 57994 then --Shaman Wind Shear
		DBM:CreatePizzaTimer(12," WShear"..args.sourceName)
		end
	if args.spellId == 19647 then --Felhunter Spell Lock
		DBM:CreatePizzaTimer(24," SLock"..args.sourceName)
		end
	if args.spellId == 6552 then --Warrior Pummel
		DBM:CreatePizzaTimer(15," Pummel"..args.sourceName)
		end
	end