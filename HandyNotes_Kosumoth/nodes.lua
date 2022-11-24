local myname, ns = ...

ns.points = {
    --[[ structure:
    [mapFile] = { -- "_terrain1" etc will be stripped from attempts to fetch this
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
    [619] = { -- Broken Isles overview
        -- broken shore
        [49507310] = { quest=43733, hide_before=43732, poi=115, label="Orb 4", scale=0.8, },
        [50207160] = { quest=43761, hide_before=43760, poi=111, label="Orb 10", scale=0.8, },
        -- azsuna
        [31105470] = { quest=43730, hide_before=43728, poi=112, label="Orb 1", scale=0.8, },
        [37604760] = { quest=43734, hide_before=43733, poi=116, label="Orb 5", scale=0.8, },
        [36605190] = { quest=43737, hide_before=43736, poi=119, label="Orb 8", scale=0.8, },
        -- stormheim
        [53804290] = { quest=43731, hide_before=43730, poi=113, label="Orb 2", scale=0.8, },
        [67261490] = { quest=43735, hide_before=43734, poi=117, label="Orb 6", note="Underwater cave, near a shark", scale=0.8, },
        -- valsharah
        [31404110] = { quest=43732, hide_before=43731, poi=114, label="Orb 3", scale=0.8, },
        -- highmountain
        [49301530] = { quest=43736, hide_before=43735, poi=118, label="Orb 7", scale=0.8, },
        -- eye of azshara
        [49209070] = { quest=43760, hide_before=43737, poi=120, label="Orb 9", scale=0.8, },
    },
    [646] = { -- BrokenShore
        -- Drak'thul, talking to him first triggers 43715, subsequent dialogs trigger 43725, 43757, 43729, 43728, then we have to go away
        [37007100] = { quest=43715, npc=102695, label="Drak'thul", note="Talk to him first!" },
        [37017101] = { quest=43728, hide_before=43715, npc=102695, label="Drak'thul", note="Go get the Withered Relic, then talk to him again!" },
        [58545405] = { quest=43725, hide_before=43715, atlas="map-icon-SuramarDoor.tga", item=139783, label="Cave for Weathered Relic", }, -- questid is for talking to DT after you have it
        [29167857] = { quest=43733, hide_before=43732, poi=115, label="Orb 4", },
        [37057105] = { quest=43761, hide_before=43760, poi=111, label="Orb 10", },
    },
    [630] = { -- Azsuna
        [37963741] = { quest=43730, hide_before=43728, poi=112, label="Orb 1", },
        [59371313] = { quest=43734, hide_before=43733, poi=116, label="Orb 5", },
        [54022618] = { quest=43737, hide_before=43736, poi=119, label="Orb 8", },
    },
    [634] = { -- Stormheim
        [32927590] = { quest=43731, hide_before=43730, poi=113, label="Orb 2", },
        [76000300] = { quest=43735, hide_before=43734, poi=117, label="Orb 6", note="Swim north from here...", },
    },
    [680] = { -- Suramar
        [63603250] = { quest=43731, hide_before=43730, poi=113, label="Orb 2", },
    },
    [641] = { -- Val'sharah
        [41518118] = { quest=43732, hide_before=43731, poi=114, label="Orb 3", },
    },
    [650] = { -- Highmountain
        [55843847] = { quest=43736, hide_before=43735, poi=118, label="Orb 7", },
    },
    [790] = { -- Eye of Azshara
        [79528931] = { quest=43760, hide_before=43737, poi=120, label="Orb 9", },
        [46005200] = { quest=45479, hide_before=43761, npc=111573, label="Kosumoth", },
    },
}
