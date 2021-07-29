local myname, ns = ...

ns.RegisterPoints(543, { -- Gorgrond
    -- treasures
    [39006810]={quest=36631, label="Sasha's Secret Stash", note="Random green + gold; top of the tower on a broken beam outside, you have to jump down"},
    [40007230]={quest=36170, loot={118715}, label="Femur of Improbability"},
    [40407660]={quest=36621, loot={118710}, currency=824, label="Explorer Canister"},
    [41705300]={quest=36506, loot={118702}, label="Brokor's Sack"},
    [41807810]={quest=36658, label="Evermorn Supply Cache", note="Green and gold; behind a hut"},
    [42408340]={quest=36625, label="Discarded Pack", note="Gold; under the roots"},
    [42604680]={quest=35056, currency=824, label="Horned Skull"},
    [43109290]={quest=34241, loot={118227}, label="Ockbar's Pack"},
    [43907050]={quest=36118, label="Pile of Rubble", note="Random green + gold; behind the ruined ogre statue head"},
    [43704240]={quest=36618, currency=824, label="Iron Supply Chest"},
    [44207420]={quest=35709, currency=824, label="Laughing Skull Cache", note="Up a tree"},
    [45004260]={quest=36634, loot={118713}, label="Sniper's Crossbow"},
    [45704970]={quest=36610, loot={118708}, label="Suntouched Spear"},
    [46105000]={quest=36651, currency=824, label="Harvestable Precious Crystal"},
    [46204290]={quest=36521, loot={118707}, label="Petrified Rylak Egg"},
    [48109340]={quest=36604, label="Stashed Emergency Rucksack"},
    [48904730]={quest=36203, loot={{118716, toy=true}}, label="Warm Goren Egg"},
    [49304360]={quest=36596, loot={107645}, currency=824, label="Weapons Cache"},
    [52506690]={quest=36509, loot={118717}, label="Odd Skull"},
    [53008000]={quest=34940, loot={118718}, label="Strange Looking Dagger", note="cave entrance at 51.3,77.6"},
    [53107440]={quest=36654, loot={118714}, label="Remains of Balik Orecrusher"},
    [57805600]={quest=36605, loot={118703}, label="Remains of Balldir Deeprock"},
    [59406370]={quest=36628, loot={118712}, label="Vindicator's Hammer", note="on a mushroom, climb up into Wildwood from 59.8,53.5 (yes, it's a long way), jump to the mushrooms at 61.9,60.0, and carry on across to the one with a nest on top"},
    [71906660]={quest=nil, currency=824, label="Sunken Treasure"},
}, {
    achievement=9728,
    hide_quest=36465,
})

ns.RegisterPoints(543, { -- Gorgrond
    [57006530]={quest=37249, loot={{118106, pet=1537}}, junk=true, label="Strange Spore", note="on mushrooms on the cliff"},
    -- followers
    [39703990]={quest=34463, follower=190, label="Mysterious Ring", note="collect all the Mysterious items across Draenor"}, -- Archmage Vargoth
    [44908690]={quest=36037, npc=83820, follower=193, note="He'll look hostile; fight the things that are attacking him"}, -- Tormmok
    [42809090]={quest=34279, npc=78030, follower=189, note="Follow the path up and fight him"}, -- Blook
})

ns.RegisterPoints(597, { -- Blackrock Foundry
    [59305720] = {quest=34405, loot={109118}, junk=true, label="Iron Horde Chest"},
})

-- Rares

ns.RegisterPoints(543, { -- Gorgrond
    [37608140]={quest=36600, npc=85970, loot={118231}}, -- Riptar
    [38206620]={quest=35910, npc=79629, loot={{118224, toy=true}}}, -- Stomper Kreego
    [40007900]={quest=35335, npc=82085, loot={{118222, toy=true}}}, -- Bashiok
    [40205960]={quest=36394, npc=80725, loot={{114227, toy=true}}}, -- Sulfurious
    [41804540]={quest=36391, npc=81038, loot={118230}}, -- Gelgor of the Blue Flame
    [44609220]={quest=36656, npc=86137, loot={118223}}, -- Sunclaw
    [46003360]={quest=37368, npc=86579, loot={119228}, achievement=9655}, -- Blademaster Ro'gor
    [46205080]={quest=36204, npc=80868, loot={118229}}, -- Glut
    [46804320]={quest=36186, npc=84431, loot={118210}}, -- Greldrok the Cunning
    [47002380]={quest=37365, npc=86577, loot={119229}, achievement=9655}, -- Horgg
    [47002580]={quest=37364, npc=86582, loot={119227}, achievement=9655}, -- Morgo Kain
    [47603060]={quest=37367, npc=86574, loot={119226}, achievement=9655}, -- Inventor Blammo
    [47804140]={quest=36393, npc=85264, loot={118211}}, -- Rolkor
    [48202100]={quest=37362, npc=86566, loot={119224}, achievement=9655}, -- Defector Dazgo
    [49003380]={quest=37363, npc=86562, loot={119230}, achievement=9655}, -- Maniacal Madgard
    [50002380]={quest=37366, npc=86571, loot={119225}, achievement=9655}, -- Durp the Hated
    [50605320]={quest=36178, npc=84406, loot={{118709, pet=1564}}}, -- Mandrakor
    [52207020]={quest=35908, npc=83522, loot={118209}}, -- Hive Queen Skrikka
    [52805360]={quest=37413, npc=78269, loot={119397}, currency=823}, -- Gnarljaw
    [53404460]={quest=35503, npc=82311, loot={118212}}, -- Char the Burning
    [53407820]={quest=34726, npc=76473, loot={118208}}, -- Mother Araneae
    [54207240]={quest=36837, npc=86520, loot={118228}}, -- Stompalupagus
    [55004660]={quest=37377, npc=88672, loot={119412}, achievement=9678, currency=823}, -- Hunter Bal'ra
    [57406860]={quest=36387, npc=85250, loot={{118221, toy=true}}}, -- Fossilwood the Petrified
    [72204080]={quest=37370, npc=82058, loot={119406}, achievement=9678, currency=823}, -- Depthroot
    [58006360]={quest=35153, npc=80785, loot={{113453, quest=35813}}}, -- Fungal Praetorian
    [58604120]={quest=37371, npc=86268, loot={119361}, achievement=9678, currency=823}, -- Alkali
    [59603180]={quest=37374, npc=88582, loot={119367}, achievement=9678, currency=823}, -- Swift Onyx Flayer
    [59604300]={quest=37375, npc=88583, loot={119414}, achievement=9678, currency=823}, -- Grove Warden Yal
    [61803930]={quest=37376, npc=88586, loot={119391}, achievement=9678, currency=823}, -- Mogamago
    [63803160]={quest=37372, npc=86266, loot={119395}, achievement=9678}, -- Venolasix
    [64006180]={quest=36794, npc=86410, loot={118213}}, -- Sylldross
    [72803580]={quest=37373, npc=88580, loot={119381}, achievement=9678}, -- Firestarter Grash
})
