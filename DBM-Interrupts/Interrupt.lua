local mod = DBM:NewMod("Displays the CDs of interrupts to you (and your raid in some configurations).", "DBM-Interrupts")
mod:SetRevision("Revision 10.13.2023")
mod:RegisterEvents("SPELL_CAST_SUCCESS")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

function mod:SPELL_CAST_SUCCESS(args)
    Spells = {
        MindFreeze={      "MdFreeze",   47528,   15},
        Strangulate={     "Strangle",   47476,   60},
        SkullBash={       "SkullBash",  106839,  15},
        SolarBeam={       "SolarBeam",  78675,   60},
        CounterShot={     "CounterSh",  147362,  24},
        Muzzle={          "Muzzle",     187707,  15},
        SilencingShot={   "SilenceSh",  34490,   24},
        CounterSpell={    "CounterSp",  2139,    24},
        AvengersShield={  "AvengerSd",  31935,   15},
        Quell={           "Quell",      351338,  40},
        Rebuke={          "Rebuke",     96231,   15},
        Silence={         "Silence",    15487,   45},
        WindShear={       "WindShear",  57994,   12},
        SpellLock={       "SpellLock",  19647,   24},
        OpticalBlast={    "OptlBlast",  115782,  24},
        Pummel={          "Pummel",     6552,    15},
        SpearHandStrike={ "SHStrike",   116705,  15},
        Disrupt={         "Disrupt",    183752,  15},
    }

    local key, value, Name, ID_no_taint, Duration, _, SpellIcon

    for key, value in pairs(Spells) do
        Name            = Spells[key][1]
        ID_no_taint     = Spells[key][2]
        Duration        = Spells[key][3]
        _, _, SpellIcon = GetSpellInfo(args.spellId)

        if args.spellId == ID_no_taint then
            DBT:CreateBar(Duration, Name..":"..args.sourceName, SpellIcon)
            end
        end
	end