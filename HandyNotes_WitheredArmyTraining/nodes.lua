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
    [692] = { -- upper level
        [29804260]={ quest=43149, item=139010, label="Treasure Chest", note="+25% HP. Requires 5 withered.", },
        [30007000]={ quest=43146, item=140451, label="Glimmering Treasure Chest", note="Withered Mana-Rager. Requires 10 withered.", },
        [38805350]={ quest=43140, item=140778, label="Treasure Chest", note="Bank in Shal'aran. Under stairs. Requires 5 withered.", },
        [40801350]={ quest=43071, item=139011, label="Glimmering Treasure Chest", note="Withered Berserker. Requires 10 withered.", },
        [75902840]={ quest=43120, item=139018, label="Treasure Chest", note="Withered more efficiently focus their attacks. Requires 5 withered.", },
    },
    [693] = { -- lower level
        [32506440]={ quest=43145, item=140450, label="Glimmering Treasure Chest", note="Withered Berserker. Requires 10 withered.", },
        [36603240]={ quest=43135, item=139028, label="Glimmering Treasure Chest", note="Withered Starcaller. Requires 10 withered.", },
        [44205350]={ quest=43134, item=139027, label="Glimmering Treasure Chest", note="Withered Spellseer. Requires 10 withered.", },
        [45704610]={ quest=43143, item=141313, label="Treasure Chest", note="Artifact power. Requires 5 withered.", },
        [48707980]={ quest=43141, item=136914, label="Treasure Chest", note="Pet. Requires 5 withered.", },
        [51802930]={ quest=43111, item=139017, label="Treasure Chest", note="Reduces fear rate. Requires 5 withered.", },
        [60507310]={ quest=43148, item=140448, label="Treasure Chest", note="+25% damage. Requires 5 withered.", },
        [62206200]={ quest=43128, item=139019, label="Glimmering Treasure Chest", note="Withered Mana-Rager. Requires 10 withered.", },
        [62409010]={ quest=43142, item=141314, label="Treasure Chest", note="Artifact power. Requires 5 withered.", },
        [67305140]={ quest=43144, item=141296, label="Treasure Chest", note="Toy. Requires 5 withered.", },
    }
}
