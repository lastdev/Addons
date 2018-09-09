local myname, ns = ...

local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_BfA-Achievments")

local AZERITE = 1553
local CHEST = 'Treasure Chest'
local CHEST_SM = 'Small Treasure Chest'
local CHEST_GLIM = 'Glimmering Treasure Chest'
local path = function(achievementID, criteriaIndex, label, questid, atlas, note, scale)
    label = label or L["Entrance"]
    atlas = atlas or "map-icon-SuramarDoor.tga" -- 'PortalPurple'
    return {
        quest = questid,
        achievement = achievementID,
        criteria = criteriaIndex,
        label = label,
        atlas = atlas,
        path = true,
        scale = scale,
        note = note,
    }
end
ns.path = path

ns.map_spellids = {
    -- [862] = 0, -- Zuldazar
    -- [863] = 0, -- Nazmir
    -- [864] = 0, -- Vol'dun
    -- [895] = 0, -- Tiragarde Sound
    -- [896] = 0, -- Drustvar
    -- [942] = 0, -- Stormsong Valley
}

ns.points = {
    --[[ structure:
    [uiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            currency=[id], -- currencyid
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
            hide_before=[id], -- hide if quest not completed
        },
    },
    --]]
    [862] = { -- Zuldazar
    [51692825] = {achievement=13036, criteria=41566, note= L["next to the river"],},
    [75506760] = {achievement=13036, criteria=41567, note= L["between the roots"],},
    [48545460] = {achievement=13036, criteria=41569, note= L["at the destroyed pillar"]},
    [49004129] = {achievement=13036, criteria=41572, note= L["above, at the pond on the big stone"],},
    [48203980] = path(13036, 41572),
    [43757672] = {achievement=13036, criteria=41573, note= L["in the eye of the skeleton, outside"],},
    [47842884] = {achievement=13036, criteria=41576, note= L["on the wall, behind the torch"],},        
    [67281762] = {achievement=13036, criteria=41577, note= L["Above, to the right of the small staircase"],},
    },

    [1165] = { -- Dazar'alor
    [53230940] = {achievement=13036, criteria=41581, note= L["Behind the NPC in the Corner"]},
    },

    [863] = { -- Nazmir
    [56355736] = {achievement=13024, criteria=41860, note= L["Inside a building ruins near the mountain"],},
    [43354811] = {achievement=13024, criteria=41861, note= L["Next to broken pillar as you enter the ruins"],},
    [51278510] = {achievement=13024, criteria=41862, note= L["Island between Nazmir and Zuldazar zones"],},
    [42555710] = {achievement=13024, criteria=42116, note= L["Near Kel'vax Deathwalker rare"],},
    [39123865] = {achievement=13036, criteria=41565, note= L["at the destroyed pillar on the left"],},
    [39575467] = {achievement=13036, criteria=41568, note= L["Scroll on the altar"],},
    [58924865] = {achievement=13036, criteria=41571, note= L["at the destroyed wall"],},
    [72850760] = {achievement=13036, criteria=41579, note= L["under water, at the bottom, at the destroyed pillar"],},
    [65505090] = {label= L["Lost Spawn of Krag'wa #1"], quest=53418, achievement=13028, note= L["in an underwater cave"],},
    [65705000] = path(13028, 0, L["cave entrance for #1"], 53418),
    [69605860] = {label= L["Lost Spawn of Krag'wa #2"],quest=53417, achievement=13028, note= L["in an underwater cave"],},
    [69105790] = path(13028, 0, L["cave entrance for #2"], 53417),
    [56106490] = {label= L["Lost Spawn of Krag'wa #3"], quest=53419, achievement=13028, note= L["between the huge roots"],},
    [44609280] = {label= L["Lost Spawn of Krag'wa #4"], quest=53422, achievement=13028, note= L["in cave"],},
    [45409130] = path(13028, 0, L["cave entrance for #4"], 53422),
    [28908320] = {label= L["Lost Spawn of Krag'wa #5"], quest=53423 ,achievement=13028, note= L["in cave"],},
    [28308190] = path(13028, 0, L["cave entrance for #5"], 53423),
    [27408170] = path(13028, 0, L["way up to the cave #5"], 53423),
    [24209160] = {label= L["Lost Spawn of Krag'wa #6"], quest=53424, achievement=13028, note= L["sits up between trees"],},
    [21706930] = {label= L["Lost Spawn of Krag'wa #7"], quest=53425, achievement=13028, note= L["sits near the bridge behind the big tree"],},
    [34106180] = {label= L["Lost Spawn of Krag'wa #8"], quest=53421, achievement=13028, note= L["in cave"],},
    [33506160] = path(13028, 0, L["cave entrance for #8"], 53421),
    [25604060] = {label= L["Lost Spawn of Krag'wa #9"], quest=53426, achievement=13028, note= L["sits behind a curtain of scrub"],},
    [52804290] = {label= L["Lost Spawn of Krag'wa #10"], quest=53420, achievement=13028, note= L["sits in a ruin"],},
    },

    [864] = { -- Vol'dun
    [38037097] = {achievement=13018, criteria=41363,}, -- tested
    [32126908] = {achievement=13018, criteria=41361,}, -- tested
    [47906249] = {achievement=13018, criteria=41360,}, -- tested
    [45786358] = {achievement=13018, criteria=41560, note= L["along the pyramid edge"],}, -- Rickety Plank #4
    [54902136] = {achievement=13018, criteria=41362, note= L["on top of the slither snake"],}, -- Rickety Plank #5       
    [54703160] = path(13018, 41562),
    [42226211] = {achievement=13036, criteria=41564, note= L["in the pond"],},
    [27706212] = {achievement=13036, criteria=41570, note= L["next to the withered tree"],},
    [49572457] = {achievement=13036, criteria=41574, note= L["Scroll next to the altar, behind the mobs"],},
    },

    [895] = { -- Tiragarde Sound
    },
    
    [896] = { -- Drustvar
    [37126380] = {achievement=13064, criteria=41436, note= L["at the bottom of the upper waterfall"],},
    [27354833] = {achievement=13064, criteria=41438, note= L["under water"],},
    [27605760] = {achievement=13064, criteria=41441, note= L["under water at the foot of the small waterfall"],},
    [19065787] = {achievement=13064, criteria=41443, note= L["behind the scrub"],},
    [56558583] = {achievement=13064, criteria=41446, note= L["on the mountain, a bit difficult to find the way up (see path)"],},
    [62706970] = path(13064, 41446, L["Path to The Flayed Man: Start"]),
    [60107130] = path(13064, 41446, L["Path to The Flayed Man: Step 1"]),
    [58507420] = path(13064, 41446, L["Path to The Flayed Man: Step 2"]),
    [60307950] = path(13064, 41446, L["Path to The Flayed Man: Step 3"]),
    [57708100] = path(13064, 41446, L["Path to The Flayed Man: Step 4"]),
    [56608480] = path(13064, 41446, L["Path to The Flayed Man: End, jump down carefully"], 0),
    [50777371] = {achievement=13064, criteria=41437, note= L["under the leaning tree"],},
    [59396668] = {achievement=13064, criteria=41439, note= L["at the destroyed wall"],},
    [50144232] = {achievement=13064, criteria=41442, note= L["at the destroyed wall"],},
    [46453723] = {achievement=13064, criteria=41445, note= L["at the destroyed wall"],},
    [44584566] = {achievement=13064, criteria=41449, note= L["in a cave, at the very back of the wall"],},
    [46304510] = path(13064, 41449, L["Path to Protectors of the Forest: cave entrance"]),
    },
    
    [942] = { -- Stormsong Valley
    },    
}