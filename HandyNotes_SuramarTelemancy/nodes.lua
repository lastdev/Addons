local myname, ns = ...

local L = LibStub("AceLocale-3.0"):GetLocale(myname, false)

--[[ structure:
    [mapFil00] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
        },
    },
--]]
ns.points = {
    ["Suramar"] = {
        [36204710] = { quest=40956, label=L["Ruins of Elune'eth"], hide_before=40956, }, -- Ruins of Elune'eth, storyline: Survey Says...
        [22903580] = { quest=42230, label=L["Falanaar"], hide_before=42228, }, -- Falanaar, storyline: Valewalker's Burden, hidden until Hidden City
        [47508200] = { quest=42487, label=L["Waning Crescent"], hide_after=43569, hide_before=42486, }, --Waning Crescent, storyline: Friends on the Outside, hidden until Little One Lost, hidden after Arluin's Request
        [64006040] = { quest=44084, label=L["Twilight Vineyards"], hide_before=42838, }, -- Twilight Vineyards, storyline: Vengeance for Margaux, hidden until Reversal
        [52007800] = { quest=42889, label=L["Evermoon Terrace"], hide_before=43569, }, -- Evermoon Terrace, storyline: The Way Back Home, hidden until 38694
        [54496943] = { quest=44740, label=L["Astravar Harbor"], hide_before=44738, }, -- Astravar Harbor, storyline: Staging Point, hidden until Full Might of the Elves
        -- These ones are general-access after Ruins is opened:
        [30801090] = { quest=43808, label=L["Moon Guard Stronghold"], hide_before=40956, }, -- Moon Guard Stronghold
        [42203540] = { quest=43809, label=L["Tel'anor"], hide_before=40956, }, -- Tel'anor
        [43406070] = { quest=43813, label=L["Sanctum of Order"], hide_before=40956, }, -- Sanctum of Order
        [43607910] = { quest=43811, label=L["Lunastre Estate"], hide_before=40956, }, -- Lunastre Estate
        [35808210] = { quest=41575, label=L["Felsoul Hold"], hide_before=40956, }, -- Felsoul Hold
        -- entrances
        [27802230] = { quest=43808, entrance=true, label=L["Moon Guard (entrance)"], hide_before=40956, }, -- Moon Guard (entrance)
        [42606170] = { quest=43813, entrance=true, label=L["Sanctum of Order (entrance)"], hide_before=40956, }, -- Sanctum of Order (entrance)
    },
    ["FalanaarTunnels"] = { -- Fal'adore
        [40901350] = { quest=42230, label=L["Falanaar"], level=32, hide_before=42228 }, -- Falanaar
    },
    ["SuramarLegionScar"] = { -- The Fel Breach
        [53403680] = { quest=41575, label=L["Felsoul Hold"], hide_before=40956 }, -- Felsoul Hold
    },
}
