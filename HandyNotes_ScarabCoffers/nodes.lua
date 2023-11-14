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
    [319] = { --AQ40
        [33904890] = {}, --Silithid Royalty
        [64202600] = {}, --Fankriss
        [58305000] = {}, --Princess Huhuran
        [47505510] = {}, --Princess Huhuran 2
        [56206570] = {}, --Twin Emperors
        [50607810] = {}, --Twin Emperors 2
        [51408340] = {}, --Twin Emperors 3
        [48108500] = {}, --Twin Emperors 4
        [47908120] = {}, --Twin Emperors 5
        [34208350] = {}, --Ouro
        [39106870] = {}, --Ouro 2
    },
    [247] = { --AQ20
        [59102840] = {}, --Kurinaxx
        [61205150] = {}, --General Rajaxx
        [72906610] = {}, --Buru the Gorger
        [57207890] = {}, --Ayamiss the Hunter
        [54908720] = {}, --Ayamiss the Hunter 2
        [34105330] = {}, --Moam
        [41604630] = {}, --Moam 2
        [41003250] = {}, --Moam 3
        [41007710] = {}, --Ossirian the Unscarred
    },
}
