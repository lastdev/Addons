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
    ["Azsuna"] = {
        [68115116] = { achievement=11175, criteria=32196, atlas="minortalents-icon-book", }, -- ch 1
        [55257153] = { achievement=11175, criteria=32197, note="On top of the tower, have fun with that", atlas="minortalents-icon-book", }, -- ch 2
        [33371118] = { achievement=11175, criteria=32198, atlas="minortalents-icon-book", }, -- ch 3
        [58351229] = { achievement=11175, criteria=32199, note="Portal @ 58.72, 14.17", atlas="minortalents-icon-book", }, -- ch 4
        [53142199] = { achievement=11175, criteria=32200, note="Path @ 52.00, 17.63", atlas="minortalents-icon-book", }, -- ch 5
        [61114626] = { achievement=11175, criteria=32201, atlas="minortalents-icon-book", }, -- ch 6
        [55674820] = { achievement=11175, criteria=32202, note="On top of the tower, have fun with that", atlas="minortalents-icon-book", }, -- ch 7
    },
}
