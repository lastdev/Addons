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
    -- Halls of valor
    [704] = {
        [47516614] = {
            ["cont"] = false,
            ["icon"] = 12,
            ["title"] = L["HOV_percentage"],
            ["desc"] = "",
        },
    },
    [705] = {
        [51227199] = {
            ["cont"] = false,
            ["icon"] = 12,
            ["title"] = L["HOV_percentage"],
            ["desc"] = "",
        },
        [54698831] = {
            ["icon"] = 2,
            ["title"] = L["HOV_haldor"],
            ["cont"] = false,
            ["desc"] = L["HOV_haldor_desc"],
        },
        [48478382] = {
            ["icon"] = 4,
            ["title"] = L["HOV_tor"],
            ["cont"] = false,
            ["desc"] = L["HOV_tor_desc"],
        },
        [48598885] = {
            ["icon"] = 3,
            ["title"] = L["HOV_bjorn"],
            ["cont"] = false,
            ["desc"] = L["HOV_bjorn_desc"],
        },
        [54938347] = {
            ["icon"] = 1,
            ["title"] = L["HOV_ranulf"],
            ["cont"] = false,
            ["desc"] = L["HOV_ranulf_desc"],
        },
    },
    -- Agelthar academy
    [2097] = {
        [42856894] = {
            ["icon"] = 2,
            ["title"] = L["AA_bronze_drake"],
            ["cont"] = false,
            ["desc"] = L["AA_bronze_drake_desc"],
        },
        [49675936] = {
            ["icon"] = 7,
            ["title"] = L["AA_red_drake"],
            ["cont"] = false,
            ["desc"] = L["AA_red_drake_desc"],
        },
        [46565603] = {
            ["icon"] = 4,
            ["title"] = L["AA_green_drake"],
            ["cont"] = false,
            ["desc"] = L["AA_green_drake_desc"],
        },
        [41896051] = {
            ["icon"] = 6,
            ["title"] = L["AA_blue_drake"],
            ["cont"] = false,
            ["desc"] = L["AA_blue_drake_desc"],
        },
        [46567181] = {
            ["icon"] = 5,
            ["title"] = L["AA_black_drake"],
            ["cont"] = false,
            ["desc"] = L["AA_black_drake_desc"],
        },
    },
    -- Ruby Sanctum (upper)
    [2094] = {
        [39755387] = {
            ["cont"] = false,
            ["icon"] = 8,
            ["title"] = L["RS_thunderdragon"],
            ["desc"] = L["RS_thunderdragon_desc"],
        },
        [67006470] = {
            ["icon"] = 8,
            ["title"] = L["RS_firedragon"],
            ["cont"] = false,
            ["desc"] = L["RS_firedragon_desc"],
        },
    },
    -- Nokhud invasion
    [2093] = {
        [33764275] = {
            ["cont"] = false,
            ["icon"] = 12,
            ["title"] = L["NO_percentage"],
            ["desc"] = "",
        },
    },
    -- Court of stars
    [761] = {
        [53976105] = {
            ["cont"] = false,
            ["icon"] = 8,
            ["title"] = L["COS_percentage"],
            ["desc"] = "",
        },
    },
}
