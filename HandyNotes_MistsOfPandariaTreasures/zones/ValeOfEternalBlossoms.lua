local myname, ns = ...

-- no treasures

ns.RegisterPoints(390, { -- Vale of Eternal Blossoms
    [42406900] = { -- Ai-Ran the Shifting Cloud
        quest=nil,
        criteria=21089,
        npc=50822,
        loot={
            {86590,toy=true,}, -- Essence of the Breeze
        },
    },
    [14005820] = { -- Kal'tik the Blight
        quest=nil,
        criteria=21068,
        npc=50749,
        loot={
            -- 86579, -- Bottled Tornado (pre-toy version)
            {134023,toy=true,}, -- Bottled Tornado
        },
    },
    [15003540] = { -- Kang the Soul Thief
        quest=nil,
        criteria=21075,
        npc=50349,
        loot={
            {86571,toy=true,}, -- Kang's Bindstone
        },
    },
    [30409140] = { -- Major Nanners
        quest=nil,
        criteria=21054,
        npc=50840,
        loot={
            {86594,toy=true,}, -- Helpful Wikky's Whistle
        },
    },
    [35205980] = { -- Moldo One-Eye +2
        quest=nil,
        criteria=21096,
        npc=50806,
        loot={
            {86586,toy=true,}, -- Panflute of Pandaria
        },
    },
    [69203020] = { -- Sahn Tidehunter
        quest=nil,
        criteria=21061,
        npc=50780,
        loot={
            {86582,toy=true,}, -- Aqua Jewel
        },
    },
    [39602460] = { -- Urgolax
        quest=nil,
        criteria=21082,
        npc=50359,
        loot={
            {86575,toy=true,}, -- Chalice of Secrets
        },
    },
    [87204420] = { -- Yorik Sharpeye
        quest=nil,
        criteria=21103,
        npc=50336,
        loot={
            {86568,toy=true,}, -- Mr. Smite's Brass Compass
        },
    },
}, {
    achievement=7439, -- Glorious!
})

ns.RegisterPoints(390, { -- Vale of Eternal Blossoms
    [34608940] = { -- Aetha
        quest=nil,
        criteria=20521,
        npc=58778,
    },
    [16404780] = { -- Bai-Jin the Butcher
        quest=nil,
        criteria=20530,
        npc=58949,
    },
    [28404300] = { -- Baolai the Immolator
        quest=nil,
        criteria=20524,
        npc=63695,
    },
    [24602670] = ns.path{ -- Bloodtip, Huo-Shang, Gaohun the Soul-Severer
        quest=nil,
        label="{zone:395}",
        criteria={20526, 20525, 20529},
        -- npc={58474, 62881, 63691},
    },
    [45805900] = { -- Cracklefang
        quest=nil,
        criteria=20517,
        npc=58768,
    },
    [26405040] = { -- General Temuja +2
        quest=nil,
        criteria=20519,
        npc=63101,
    },
    [27001340] = { -- Gochao the Ironfist
        quest=nil,
        criteria=20528,
        npc=62880,
        path=28001530,
        note="Inside a blocked cave",
    },
    [6205780] = { -- Kri'chon
        quest=nil,
        criteria=20531,
        npc=63978,
    },
    [66203900] = { -- Quid
        quest=nil,
        criteria=20522,
        npc=58771,
    },
    [30407800] = { -- Shadowmaster Sydow
        quest=nil,
        criteria=20520,
        npc=63240,
    },
    [47406620] = { -- Spirit of Lao-Fe
        quest=nil,
        criteria=20523,
        npc=58817,
    },
    [34405140] = { -- Vicejaw
        quest=nil,
        criteria=20518,
        npc=58769,
    },
    [7803380] = { -- Vyraxxis
        quest=nil,
        criteria=20532,
        npc=63977,
    },
    [45347624] = { -- Wulon
        quest=nil,
        criteria=20527,
        npc=63510,
        path=40807720,
    },
}, {
    achievement=7317, -- One Many Army
})
ns.RegisterPoints(395, {-- Guo-Lai Halls
    [64041911] = { -- Huo-Shuang
        quest=nil,
        criteria=20529,
        npc=63691,
        note="Inside the Guo-Lai Halls"
    },
    [75804758] = { -- Bloodtip
        quest=nil,
        criteria=20526,
        npc=58474,
        vignette=33,
    },
    [53395910] = { -- Gaohun the Soul-Severer
        quest=nil,
        criteria=20525,
        npc=62881,
    },
})

ns.RegisterPoints(390, { -- Vale of Eternal Blossoms
    [16603400] = { -- Alani +38
        quest=nil,
        npc=64403,
        loot={
            {90655,mount=517,boe=true,}, -- Reins of the Thundering Ruby Cloud Serpent
        },
    },
})
