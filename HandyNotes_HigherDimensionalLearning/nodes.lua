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
    [630] = {
        [68115116] = { achievement=11175, criteria=32196, day=0, atlas="minortalents-icon-book", }, -- ch 1, Sunday
        [55257153] = { achievement=11175, criteria=32197, day=1, note="On top of the tower, have fun with that", atlas="minortalents-icon-book", }, -- ch 2, Monday
        [33371118] = { achievement=11175, criteria=32198, day=2, atlas="minortalents-icon-book", }, -- ch 3, Tuesday
        [58351229] = { achievement=11175, criteria=32199, day=3, note="Portal @ 58.72, 14.17", atlas="minortalents-icon-book", }, -- ch 4, Wednesday
        [53142199] = { achievement=11175, criteria=32200, day=4, note="Path @ 52.00, 17.63", atlas="minortalents-icon-book", }, -- ch 5, Thursday
        [61114626] = { achievement=11175, criteria=32201, day=5, atlas="minortalents-icon-book", }, -- ch 6, Friday
        [55674820] = { achievement=11175, criteria=32202, day=6, note="On top of the tower, have fun with that", atlas="minortalents-icon-book", }, -- ch 7, Saturday
    },
}
