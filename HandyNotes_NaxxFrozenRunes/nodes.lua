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
    [163] = { -- spider wing
        [29613882] = {}, --Anub'Rekhan 1
        [44994012] = {}, --Faerlina 1
        [61175212] = {}, --Faerlina 2
        [40512519] = {}, --Maexxna 1
        [72440914] = {}, --Maexxna 2
        [48371912] = {}, --Maexxna 2
    },
    [165] = { -- plague wing
        [35116180] = {}, --Noth 1
        [48324084] = {}, --Heigan 1
        [51284073] = {}, --Heigan 2
        [78452442] = {}, --Loatheb 1
        [72962405] = {}, --Loatheb 2
        [68003513] = {}, --Loatheb 3
        [63376800] = {}, --Loatheb 4
        [37156460] = {}, --Loatheb 5
    },
    [164] = { -- military wing
        [45064486] = {}, --Razuvious 1
        [62394854] = {}, --gothik 1
        [38545816] = {}, --horseman 1
        [31094766] = {}, --horseman 2
        [31284542] = {}, --horseman 3
        [33251960] = {}, --horseman 4
        [30526496] = {}, --horseman 5
        [32488555] = {}, --horseman 6
    },
    [162] = { -- construct wing
        [38467457] = {}, --Patchwerk 1
        [69575415] = {}, --Grobbulus 1
        [63473747] = {}, --Grobbulus 2
        [51263872] = {}, --Gluth 1
        [36493930] = {}, --Thaddius 1
        [33796155] = {}, --Thaddius 2
        [49691923] = {}, --Thaddius 3
        [58862572] = {}, --Thaddius 4
        [23721398] = {}, --Thaddius 5
    },
    
}
