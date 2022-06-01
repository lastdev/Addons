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
        [57401340] = { label="Mage Portal", quest="42696"},
    },
    ["Highmountain"] = {
        [31406380] = { label="Mage Portal", quest="42696"},
    },
    ["Valsharah"] = {
        [51205610] = { label="Mage Portal", quest="42696"},
    },
    ["Stormheim"] = {
        [31306050] = { label="Mage Portal", quest="42696"},
    },
    ["Suramar"] = {
        [32405040] = { label="Mage Portal", quest="42696"},
    },
}
-- icon = "Interface\\Icons\\Spell_Arcane_PortalDalaran"
