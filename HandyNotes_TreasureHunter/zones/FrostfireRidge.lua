local myname, ns = ...

ns.RegisterPoints(525, { -- FrostfireRidge
    -- garrison
    [16104980]={ quest=33942, label="Supply Dump", currency=824, },
    [21605070]={ quest=34931, label="Pale Loot Sack", currency=824, },
    [24001300]={ quest=34647, label="Snow-Covered Strongbox", currency=824, },
    [34202350]={ quest=32803, label="Thunderlord Cache", currency=824, },
    [37205920]={ quest=34967, label="Raided Loot", currency=824, },
    [43705550]={ quest=34841, label="Forgotten Supplies", currency=824, },
    [51002280]={ quest=34521, label="Glowing Obsidian Shard", currency=824, note="May be missing?", },
    [56707180]={ quest=36863, label="Iron Horde Munitions", currency=824, },
    [64702570]={ quest=33946, label="Survivalist's Cache", currency=824, },
    [66702640]={ quest=33948, label="Goren Leftovers", currency=824, },
    [68204580]={ quest=33947, label="Grimfrost Treasure", currency=824, },
    [69006910]={ quest=33017, label="Iron Horde Supplies", currency=824, },
    [74505620]={ quest=34937, label="Lady Sena's Other Materials Stash", currency=824, faction="Horde", },
    -- treasures
    [09804540]={ quest=34641, loot={111407}, label="Sealed Jug", },
    [19201200]={ quest=34642, loot={111408}, label="Lucky Coin", },
    [21900960]={ quest=33926, loot={108739}, label="Lagoon Pool", toy=true, },
    [23102500]={ quest=33916, loot={108735}, label="Arena Master's War Horn", toy=true, },
    [24202720]={ quest=33501, loot={63293}, label="Spectator's Chest", note="booze, jump from the tower, entrance @ 25,30", },
    [24204860]={ quest=34507, loot={110689}, label="Frozen Frostwolf Axe", note="cave at 25,51", },
    [25502040]={ quest=34648, loot={111415}, label="Gnawed Bone", },
    [27604280]={ quest=33500, loot={43696}, label="Slave's Stash", note="booze", },
    [30305120]={ quest=33438, loot={107662}, label="Time-Warped Tower", note="loot all the frozen ogres", }, -- note: other ogres are 33497, 33439, and 33440
    [38403780]={ quest=33502, loot={112087}, label="Obsidian Petroglyph", },
    [39701710]={ quest=33532, loot={120945}, currency=823, note="In the tower, behind some rocks", }, -- Cragmaul Cache
    [40902010]={ quest=34473, loot={110536}, label="Envoy's Satchel", },
    [42401970]={ quest=34520, loot={120341}, label="Burning Pearl", },
    [42703170]={ quest=33940, loot={112187}, label="Crag-Leaper's Cache", },
    [54803540]={ quest=33525, loot={107273}, note="Combine with Frostwolf First-Fang @ 63,48", }, -- Young Orc Traveler
    [57105210]={ quest=34476, loot={111554}, label="Frozen Orc Skeleton", },
    [61804250]={ quest=33511, npc=72156, loot={112110}, note="Interrupt the ritual, then feed him ogres", },
    [63401480]={ quest=33525, loot={107272}, npc=75081, note="Combine with Snow Hare's Foot @ 54,35", }, -- Young Orc Woman
    [64406580]={ quest=33505, loot={117564}, label="Wiggling Egg", note="rylak nests on the roof", pet=true, },
    -- bladespire...
    [26503640]={ quest=35367, label="Gorr'thogg's Personal Reserve", currency=824, },
    [26703940]={ quest=35370, loot={113189}, label="Doorog's Secret Stash", },
    [26603520]={ quest=35347, currency=824, label="Ogre Booty", },
    [27173763]={ quest=35373, label="Ogre Booty", note="Gold", },
    [27283876]={ quest=35570, label="Ogre Booty", note="Gold", },
    [27603382]={ quest=35371, label="Ogre Booty", note="Gold", },
    [28093409]={ quest=35567, currency=824, label="Ogre Booty", },
    [28093409]={ quest=35568, currency=824, label="Ogre Booty", },
    [28093409]={ quest=35569, currency=824, label="Ogre Booty", },
    [28293440]={ quest=35368, label="Ogre Booty", note="Gold", },
    [28293440]={ quest=35369, label="Ogre Booty", note="Gold", },
}, {
    achievement=9728,
    hide_quest=34557,
})
-- All these Bladespire ones are available for Alliance, but Horde have to complete Moving In (33657) first
ns.RegisterPoints(526, { -- Turgall's Den: Bladespire Citadel
    [44806480]={ quest=35570, label="Ogre Booty", note="Gold", },
    [48506720]={ quest=35369, label="Ogre Booty", note="Gold; up some crates", },
    [53702880]={ quest=35368, label="Ogre Booty", note="Gold; up some crates", },
}, {
    achievement=9728,
    hide_quest=34557,
})
ns.RegisterPoints(527, { -- Turgall's Den: Bladespite Courtyard
    [36502900]={ quest=35347, currency=824, label="Ogre Booty", },
    [37806900]={ quest=35370, loot={113189}, label="Doorog's Secret Stash", note="second floor, outside", },
    [46401640]={ quest=35371, label="Ogre Booty", note="Gold; up some crates; may hit an invisible ceiling, it's reachable if you work at it", },
    [51101770]={ quest=35567, currency=824, label="Ogre Booty", },
    [52605300]={ quest=35373, label="Ogre Booty", note="Gold; up some crates", },
    [70806800]={ quest=35569, currency=824, label="Ogre Booty", note="In the vault", },
    [76606330]={ quest=35568, currency=824, label="Ogre Booty", note="In the vault", },
}, {
    achievement=9728,
    hide_quest=34557,
})
ns.RegisterPoints(528, { -- Turgall's Den: Bladespite Throne
    [31706640]={ quest=35367, loot={113108}, label="Gorr'thogg's Personal Reserve", },
}, {
    achievement=9728,
    hide_quest=34557,
})

ns.RegisterPoints(525, { -- FrostfireRidge
    -- followers
    [39602800]={ quest=34733, follower=32, note="Rescue Dagg from the other cage first, then find him outside your garrison", }, -- Dagg
    [68001900]={ quest=34464, follower=190, label="Mysterious Boots", note="collect all the Mysterious items across Draenor", }, -- Archmage Vargoth
    [65906080]={ quest=34733, follower=32, note="Rescue Dagg from the cage, then go to his other location", }, -- Dagg
})

-- Rares

ns.RegisterPoints(525, { -- FrostfireRidge
    [67407820]={ quest=34477, loot={112086}, npc=78621, }, -- Cyclonic Fury
    [41206820]={ quest=34843, loot={111953}, npc=80242, }, -- Chillfang
    [28206620]={ quest=34470, loot={111666}, npc=78606, }, -- Pale Fishmonger
    [38606300]={ quest=34865, loot={112077}, npc=80312, }, -- Grutush the Pillager
    [50405240]={ quest=34825, loot={111948}, npc=80190, }, -- Gruuk
    [76406340]={ quest=34132, loot={112094}, npc=77526, }, -- Scout Goreseeker
    [25405500]={ quest=34129, loot={112066}, npc=77513, }, -- Coldstomp the Griever
    [27405000]={ quest=34497, loot={111476}, npc=78867, toy=true, }, -- Breathless
    [40404700]={ quest=33014, loot={111490}, npc=72294, }, -- Cindermaw
    [66403140]={ quest=33843, loot={111533}, npc=74613, }, -- Broodmother Reeg'ak
    [36803400]={ quest=33938, loot={111576}, npc=76918, }, -- Primalist Mur'og
    [26803160]={ quest=34133, loot={111475}, npc=77527, }, -- The Beater
    [40402780]={ quest=34559, loot={111477}, npc=79145, }, -- Yaga the Scarred
    [61602640]={ quest=34708, loot={112078}, npc=79678, }, -- Jehil the Climber
    [34002320]={ quest=32941, loot={101436}, npc=71721, currency=824, }, -- Canyon Icemother
    [54602220]={ quest=32918, loot={111530}, npc=71665, }, -- Giant-Slayer Kul
    [58603420]={ quest=34130, npc=78151, currency=824, }, -- Huntmaster Kuang
    [54606940]={ quest=34131, loot={111484}, npc=76914, }, -- Coldtusk
    [71404680]={ quest=33504, loot={107661}, npc=74971, }, -- Firefury Giant
    [47005520]={ quest=34839, loot={111955}, npc=80235, }, -- Gurun
    [50201860]={ quest=33531, loot={112096}, npc=75120, note="...and a peeled banana", }, -- Clumsy Cragmaul Brute
    [85005220]={ quest=37556, npc=87600, currency=823, }, -- Jaluk the Pacifist
    [88605740]={ quest=37525, loot={119365}, npc=84378, }, -- Ak'ox the Slaughterer
    [86604880]={ quest=37401, loot={119359}, npc=84392, }, -- Ragore Driftstalker
    [86605180]={ quest=37403, loot={119374}, npc=84376, }, -- Earthshaker Holar
    [83604720]={ quest=37402, loot={119366}, npc=87622, }, -- Ogom the Mangler
    [87004640]={ quest=37404, loot={119372}, npc=84374, }, -- Kaga the Ironbender
    [70002700]={ quest=37381, loot={119376}, npc=87351, }, -- Mother of Goren
    [72203300]={ quest=34361, loot={111534}, npc=78265, }, -- The Bone Crawler
    [68801940]={ quest=37382, loot={119415}, npc=87348, }, -- Hoarfrost
    [72203600]={ quest=37380, loot={119349,119180}, npc=87352, toy=true, note="Flees" }, -- Gibblette the Cowardly
    [70003600]={ quest=33562, loot={111545}, npc=72364, currency=824, }, -- Gorg'ak the Lava Guzzler
    [70603900]={ quest=37379, loot={119416}, npc=87356, currency=823, }, -- Vrok the Ancient
    [72402420]={ quest=37378, loot={119416}, npc=87357, currency=823, }, -- Valkor
    [43600940]={ quest=37384, loot={119163,119379}, toy=true, npc=82618, }, -- Tor'goroth
    [38201600]={ quest=37383, loot={119399}, npc=82620, }, -- Son of Goramal
    [45001500]={ quest=37385, loot={119362}, npc=82617, }, -- Slogtusk the Corpse-Eater
    [48202340]={ quest=37386, loot={119390}, npc=82616, }, -- Jabberjaw
    [43002100]={ quest=37387, loot={119356}, npc=82614, }, -- Moltnoma
    [40601240]={ quest=34522, npc=79104, currency=823, }, -- Ug'lok the Frozen
    [62604220]={ quest=nil, npc=72156, loot={112110}, note="Don't kill it, feed the ogres to it; it'll spit up an object to loot", }, -- Borrok the Devourer
    [13805140]={ npc=81001, loot={116794},}, -- Nok-Karosh
    -- probably never went live:
    -- [84404880]={ quest=nil, npc=84384, note=UNKNOWN, }, -- Taskmaster Kullah
    -- [72203000]={ quest=nil, npc=87349, note=UNKNOWN }, -- Gomtar the Agile
})
