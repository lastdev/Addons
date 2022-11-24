local myname, ns = ...

-- See: https://www.wowhead.com/item=129929/ever-shifting-mirror

local TIME_LOST = 194812

-- we don't normally refresh on spells/auras, but it's fairly necessary for this
-- TODO: upstream this? it's useful for anything with a AuraActive/Inactive condition, it'd just need a system of registration...
local GetPlayerAuraBySpellID = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID or _G.GetPlayerAuraBySpellID
local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(self, event, _, _, spellID)
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        if spellID == TIME_LOST then
            ns.HL:Refresh()
            self:RegisterUnitEvent("UNIT_AURA", "player")
        end
    elseif event == "UNIT_AURA" then
        if not GetPlayerAuraBySpellID(TIME_LOST) then
            ns.HL:Refresh()
            frame:UnregisterEvent("UNIT_AURA")
        end
    end
end)
frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")

local mirror = {
    active=ns.conditions.AuraActive(TIME_LOST), -- time-lost mirror aura
    requires=ns.conditions.Toy(129929),
    spell=TIME_LOST,
    atlas="MagePortalAlliance", -- legioninvasion-map-icon-portal-large?
    scale=1.2,
    group="evershiftingmirror",
    OnClick=function(point, button, uiMapID, coord)
        if not point.link then return end
        -- escape the current click-hander because Blizzard data providers get in the way
        C_Timer.After(0, function()
            if WorldMapFrame.HandleUserActionOpenSelf then
                OpenWorldMap(point.link[1])
            else
                -- Classic
                if not WorldMapFrame:IsVisible() then
                    ToggleWorldMap()
                end
                WorldMapFrame:SetMapID(point.link[1])
            end
        end)
    end,
    parent=true,
}

ns.suppressoverlay[101] = true -- outland
ns.suppressoverlay[100] = true
ns.suppressoverlay[102] = true
ns.suppressoverlay[104] = true
ns.suppressoverlay[105] = true
ns.suppressoverlay[107] = true
ns.suppressoverlay[108] = true

ns.RegisterPoints(100, {
    [54974889]={label="Magtheridon's Lair -> Hellfire Citadel", link={534, 49575070}},
    [64072175]={label="Throne of Kil'jaeden -> Throne of Kil'jaeden", link={534, 56322684}},
    [80405160]={label="Dark Portal -> Dark Portal", link={534, 70315451}},
}, mirror)
ns.RegisterPoints(102, {
    [49195538]={label="Twinspire Ruins -> North-East Nagrand Coast", link={550, 81130898}},
    [68208847]={label="Entrance to Nagrand -> Nagrand Border", link={550, 88352284}},
    [82616614]={label="Zangarmarsh Border -> Path of Glory", link={535, 68400932}},
}, mirror)
ns.RegisterPoints(104, {
    [27123336]={label="Legion Hold -> Moonflower Valley", link={539, 32312876}},
    [61544606]={label="The Warden's Cage -> Path of Light", link={539, 60004838}},
}, mirror)
ns.RegisterPoints(105, {
    [39657740]={label="Bloodmaul Ravine -> Gormaul Tower", link={525, 37506070}},
    [46416405]={label="Bloodmaul Ravine -> Burning Glacier", link={525, 21814530}},
    [59137171]={label="Razor Ridge -> Razor Bloom", link={543, 49407367}},
    [66212635]={label="Gruul's Lair -> Blackrock Foundry", link={543, 50823142}},
}, mirror)
ns.RegisterPoints(107, {
    [41285903]={label="Oshugun Spirit Fields -> Oshugun Spirit Woods", link={550, 50325722}},
    [60382556]={label="Throne of the Elements -> Throne of the Elements", link={550, 71402192}},
}, mirror)
ns.RegisterPoints(108, {
    [35271252]={label="Shattrath -> Shattrath", link={535, 50403517}},
    [45364754]={label="Bone Wastes -> Deathweb Hollow", link={535, 57848052}},
    [70787587]={label="Skettis -> Talador Border", link={542, 47391246}},
}, mirror)
ns.RegisterPoints(525, {
    [21814530]={label="Burning Glacier -> Bloodmaul Ravine", link={105, 46416405}},
    [37506070]={label="Gormaul Tower -> Bloodmaul Ravine", link={105, 39657740}},
}, mirror)
ns.RegisterPoints(534, {
    [49575070]={label="Hellfire Citadel -> Magtheridon's Lair", link={100, 54974889}},
    [56322684]={label="Throne of Kil'jaeden -> Throne of Kil'jaeden", link={100, 64072175}},
    [70315451]={label="Dark Portal -> Dark Portal", link={100, 80405160}},
}, mirror)
ns.RegisterPoints(535, {
    [50403517]={label="Shattrath -> Shattrath", link={108, 35271252}},
    [57848052]={label="Deathweb Hollow -> Bone Wastes", link={108, 45364754}},
    [68400932]={label="Path of Glory -> Zangarmarsh Border", link={102, 82616614}},
}, mirror)
ns.RegisterPoints(539, {
    [32312876]={label="Moonflower Valley -> Legion Hold", link={104, 27123336}},
    [60004838]={label="Path of Light -> The Warden's Cage", link={104, 61544606}},
}, mirror)
ns.RegisterPoints(542, {
    [47391246]={label="Talador Border -> Skettis", link={108, 70787587}},
}, mirror)
ns.RegisterPoints(543, {
    [49407367]={label="Razor Bloom -> Razor Ridge", link={105, 59137171}},
    [50823142]={label="Blackrock Foundry -> Gruul's Lair", link={105, 66212635}},
}, mirror)
ns.RegisterPoints(550, {
    [50325722]={label="Oshugun Spirit Woods -> Oshugun Spirit Fields", link={107, 41285903}},
    [71402192]={label="Throne of the Elements -> Throne of the Elements", link={107, 60382556}},
    [81130898]={label="North-East Nagrand Coast -> Twinspire Ruins", link={102, 49195538}},
    [88352284]={label="Nagrand Border -> Entrance to Nagrand", link={102, 68208847}},
}, mirror)
