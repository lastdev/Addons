local myname, ns = ...

ns.SetupMapOverlay = nil

ns.hiddenConfig = {
    groupsHidden = true,
}

ns.defaultsOverride = {
    show_on_minimap = true,
}

local ANYWHERE = "Anywhere in this zone"

-- Secret Fish of Mechagon

local goggles = {
    achievement=13489,
    atlas="worldquest-icon-fishing",
    loot={167698}, -- Secret Fish Goggles
}
ns.RegisterPoints(946, { -- World
    [53004750] = goggles,
})
ns.RegisterPoints(947, { -- Azeroth
    [68004660] = goggles,
})
ns.RegisterPoints(876, { -- Kul Tiras
    [16903000] = goggles,
})
if not IsAddOnLoaded("HandyNotes_BattleForAzerothTreasures") then
    ns.RegisterPoints(1462, { -- Mechagon
        [35004650] = { -- Bolted Steelhead, Energized Lighting Cod, Solarsprocket Barbel
            criteria={44738, 44744, 44745},
            loot={{167655,quest=55305},{167661,quest=55311},{167662,quest=55312}},
            note="These can be fished anywhere on the coast",
        },
        [76704920] = {criteria=44737,loot={{167654,quest=55299}}}, -- Bottom Feeding Stinkfish
        [55803190] = {criteria=44739,loot={{167656,quest=55306}}}, -- Pond Hopping Springfish
        [59102280] = {criteria=44740,loot={{167657,quest=55307}}}, -- Shadowy Cave Eel
        [26107570] = {criteria=44741,loot={{167658,quest=55308}}}, -- Mechanical Blowfish
        [83707300] = {criteria=44742,loot={{167659,quest=55309}}}, -- Spitting Clownfish
        [65505220] = {criteria=44743,loot={{167660,quest=55310}}}, -- Sludge-fouled Carp
        [47403600] = {criteria=44746,loot={{167663,quest=55313}}}, -- Tasty Steelfin
    }, {
        achievement=13489,
        atlas="worldquest-icon-fishing",
        minimap=true,
        inbag=167698,
    })
end

-- Secret Fish and Where to Find Them
local secret = ns.nodeMaker{
    achievement=13502,
    requires=ns.conditions.Item(167698), -- Secret Fish Goggles
    atlas="worldquest-icon-fishing",
}

ns.RegisterPoints(946, { -- World
    -- Shadowlands: Deadeye Wally, Quiet Floater, Spiritual Salmon, Veiled Ghost
    [24002460] = secret{criteria={44826, 44821, 44819, 44825}, note="Can also find these while dead anywhere else"},
    -- Azeroth
    [51103730] = secret{criteria={44822, 44815, 45952, 44817, 45754, 45755, 44828, 44809, 44820, 44818, 44816, 44803, 44807, 44804, 44814, 45953}},
})
ns.RegisterPoints(947, { -- Azeroth
    -- Pandaria
    [40707160] = secret{criteria=44822}, -- Thunderous Flounder
    [52708060] = secret{criteria=44815}, -- Jade Story
    [46607630] = secret{criteria=45952}, -- Thin Air Flounder
    -- Kul Tiras
    [71104920] = secret{criteria={44817, 45754, 45755, 44828, 44809}}, -- Mechanized Mackerel, Green Roughy, Displaced Scrapfin, Tortollan Tank Dweller, Drowned Goldfish
    -- Zandalar
    [54006050] = secret{criteria=44820}, -- Rotted Blood Cod
    -- Nazjatar
    [62905680] = secret{criteria=44818}, -- Queen's Delight
    -- Broken Isles
    [58304150] = secret{criteria={44816, 44803, 44807}}, -- Kirin Tor Clown, Ancient Mana Fin, Dead Fel Bone
    -- Northrend
    [49401070] = secret{criteria=44816}, -- Kirin Tor Clown
    [56101990] = secret{criteria=44804}, -- Barbed Fjord Fin
    -- Eastern Kingdoms
    [80005220] = secret{criteria=44814}, -- Prisoner Fish
    -- Kalimdor
    [20804340] = secret{criteria=45953}, -- Well Lurker
})

ns.RegisterPoints(875, { -- Zandalar
    [59603140] = secret{criteria=44820}, -- Rotted Blood Cod
    [86901420] = secret{criteria=44818, note=ANYWHERE}, -- Queen's Delight
})
ns.RegisterPoints(863, { -- Nazmir
    [54405780] = secret{criteria=44820, note="In Zal'Amak"}, -- Rotted Blood Cod (Zal'Amak)
})
ns.RegisterPoints(876, { -- Kul Tiras
    [16903001] = secret{ -- Mechagon: Mechanized Mackerel, Green Roughy, Displaced Scrapfin:
        criteria={44817, 45754, 45755},
        note="Anywhere, but:\n{item:169884:Green Roughy} requires {spell:294250:Painted Green}\n{item:169870:Displaced Scrapfin} requires {spell:299894:Time Displacement}",
    },
    [25506770] = secret{criteria=44828, note="Under Anyport"}, -- Tortollan Tank Dweller
    [47803220] = secret{criteria=44809}, -- Drowned Goldfish
    [86901420] = secret{criteria=44818, note=ANYWHERE}, -- Queen's Delight (Nazjatar)
})
ns.RegisterPoints(896, { -- Drustvar
    [18934239] = secret{criteria=44828, note="In the underwater bar"}, -- Tortollan Tank Dweller
})
ns.RegisterPoints(942, { -- Stormsong Valley
    [38905550] = secret{criteria=44809, note="In the drained areas"}, -- Drowned Goldfish
})

ns.RegisterPoints(619, { -- Broken Isles
    [45506810] = secret{criteria=44816, note="In Dalaran, here or in Northrend"}, -- Kirin Tor Clown
    [50205140] = secret{criteria=44803}, -- Ancient Mana Fin (Suramar)
    [88002330] = secret{criteria=44807, note=ANYWHERE}, -- Dead Fel Bone (Argus)
})
ns.RegisterPoints(680, { -- Suramar
    [55107650] = secret{criteria=44803, note="Anywhere in the harbor"}, -- Ancient Mana Fin
})

ns.RegisterPoints(424, { -- Pandaria
    [20801340] = secret{criteria=44822, note=ANYWHERE}, -- Thunderous Flounder (Isle of Thunder)
    [65504640] = secret{criteria=44815, note=ANYWHERE}, -- Jade Story (Jade Forest)
    [43703590] = secret{criteria=45952}, -- Thin Air Flounder (Kun-Lai)
})
ns.RegisterPoints(379, { -- Kun-Lai Summit
    [44005200] = secret{criteria=45952}, -- Thin Air Flounder
})

ns.RegisterPoints(113, { -- Northrend
    [47004040] = secret{criteria=44816, note="In Dalaran, here or in the Broken Isles"}, -- Kirin Tor Clown (Dalaran)
    [73507440] = secret{criteria=44804, note=ANYWHERE}, -- Barbed Fjord Fin
})
ns.RegisterPoints(127, { -- Crystalsong Forest
    [27403990] = secret{criteria=44816, note="In Dalaran, here or in the Broken Isles"}, -- Kirin Tor Clown (Dalaran)
})

ns.RegisterPoints(12, { -- Kalimdor
    [53502870] = secret{criteria=45953}, -- Well Lurker
})
ns.RegisterPoints(198, { -- Mount Hyjal
    [60702580] = secret{criteria=45953, note="In the lake under Nordrassil"}, -- Well Lurker
})

ns.RegisterPoints(13, { -- Eastern Kingdoms
    [35804960] = secret{criteria=44814, note="Tol Barad, on the PvP island"}, -- Prisoner Fish
})

--[[
-- These are mostly left in in case I need the itemids later:

--Kul Tiras
[] = secret{criteria=44828, loot={167724}}, -- Tortollan Tank Dweller
[] = secret{criteria=44809, loot={167709}}, -- Drowned Goldfish

--Mechagon
[] = secret{criteria=44817, loot={167705}}, -- Mechanized Mackerel
[] = secret{criteria=45754, loot={169884}}, -- Green Roughy
[] = secret{criteria=45755, loot={169870}}, -- Displaced Scrapfin

--Zandalar
[] = secret{criteria=44820, loot={167712}}, -- Rotted Blood Cod

--Nazjatar
[] = secret{criteria=44818, loot={167728}}, -- Queen's Delight

--Broken Isles
[] = secret{criteria=44816, loot={167707}}, -- Kirin Tor Clown
[] = secret{criteria=44803, loot={167708}}, -- Ancient Mana Fin
[] = secret{criteria=44807, loot={167711}}, -- Dead Fel Bone

--Pandaria
[] = secret{criteria=44815, loot={167706}}, -- Jade Story Fish
[] = secret{criteria=44822, loot={167723}}, -- Thunderous Flounder
[] = secret{criteria=45952, loot={169897}}, -- Thin Air Flounder

--Northrend
[] = secret{criteria=44804, loot={167710}}, -- Barbed Fjord Fin

--Classic
[] = secret{criteria=44814, loot={167722}}, -- Prisoner Fish
[] = secret{criteria=45953, loot={169898}}, -- Well Lurker

-- Anywhere
[] = secret{criteria=44805, loot={167717}}, -- Camouflaged Snark
[] = secret{criteria=44808, loot={167729}}, -- Deceptive Maw
[] = secret{criteria=44812, loot={167730}}, -- Inconspicuous Catfish
[] = secret{criteria=44824, loot={167716}}, -- Unseen Mimmic
[] = secret{criteria=44827, loot={167720}}, -- Very Tiny Whale
[] = secret{criteria=44806, loot={167718}}, -- Collectable Saltfin
[] = secret{criteria=44823, loot={167714}}, -- Travelling Goby
[] = secret{criteria=44813, loot={167721}}, -- Invisible Smelt

-- Anywhere, at night
[] = secret{criteria=44810, loot={167715}}, -- Elusive Moonfish

-- Anywhere, at day
[] = secret{criteria=44811, loot={167719}}, -- Golden Sunsoaker

-- While dead / in shadowlands
[] = secret{criteria=44821, loot={167727}}, -- Deadeye Wally
[] = secret{criteria=44819, loot={167726}}, -- Quiet Floater
[] = secret{criteria=44825, loot={167725}}, -- Spiritual Salmon
[] = secret{criteria=44826, loot={167713}}, -- Veiled Ghost
--]]