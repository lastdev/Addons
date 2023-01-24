
local _, PetDailies = ...
local points = PetDailies.points
local addonName = "PetDailies"  -- this is standalone
local addon = LibStub("AceAddon-3.0"):GetAddon(addonName)


local ADVENTURE = "9069"
local ARGUS = "12088"
local FAMILY = "12100"
local BATTLER = "13279"
local NUISANCES = "13626"
local MINIONS = "13625"
local ABHORRENT = "14881"
local EXORCIST = "14879"
local BATTLE_SL = "14625"
local BATTLER_DI = "16512"
local BATTLE_DI = "16464"

--To find map id for points[mmm] = /run print(C_Map.GetBestMapForUnit("player"))

--Format: [xxxxyyyy] = "qqqqq.q:tooltip:icon:coin reward:horde or alliance or both"
--xxxx is the x waypoint coordinate as in 33.50
--yyyy is the y waypoint coordinate as in 33.50
--qqqqq.q is the quest id where the decimal portion is the series number if the quest must be in the quest log
-- -- (Beasts of Fable Books)
--------------
-- Tanaan --
--------------
--Tanaan Jungle
points[534] = {
	[26143160] = "39157.0:Felsworn Sentry:inv_misc_bag_33:false:both",
	[15744444] = "39168.0:Bleakclaw:inv_misc_bag_33:false:both",
	[75453736] = "39173.0:Defiled Earth:inv_misc_bag_33:false:both",
	[57733734] = "39165.0:Direflame:inv_misc_bag_33:false:both",
	[54072983] = "39167.0:Dark Gazer:inv_misc_bag_33:false:both",
	[48073302] = "39172.0:Skrillix (Cave):inv_misc_bag_33:false:both",
	[48373547] = "39171.0:Netherfist:inv_misc_bag_33:false:both",
	[31373806] = "39162.0:Cursed Spirit:inv_misc_bag_33:false:both",
	[42237179] = "39166.0:Mirecroak:inv_misc_bag_33:false:both",
	[25047621] = "39161.0:Chaos Pup:inv_misc_bag_33:false:both",
	[44034572] = "39169.0:Vile Blood:inv_misc_bag_33:false:both",
	[43378444] = "39164.0:Tainted Mudclaw:inv_misc_bag_33:false:both",
	[53016521] = "39160.0:Corrupted Thundertail:inv_misc_bag_33:false:both",
	[55908076] = "39163.0:Felfly:inv_misc_bag_33:false:both",
	[47335278] = "39170.0:Dreadwalker:inv_misc_bag_33:false:both"
}

--------------
-- Pandaria --
--------------
--Dreadwastes
points[422] = {
	[26185027] = "32869.1:Gorespine:inv_misc_bag_cenarionherbbag:false:both",
	[26185028] = "32603.2:Gorespine:inv_misc_bag_cenarionherbbag:false:both",
	[61208760] = "32439.0:Flowing Pandaren Spirit:inv_pet_pandarenelemental:false:both",
	[61208761] = ADVENTURE..".15:Flowing Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[55003740] = "31957.0:Grand Master Shu:inv_misc_bag_cenarionherbbag:false:both",
	[55003741] = ADVENTURE..".41:Wastewalker Shu:inv_tailoring_elekkplushie:false:both",
}
--Krasarang
points[418] = {
	[37133351] = "32868.3:Skitterer Xia:inv_misc_bag_cenarionherbbag:false:both",
	[37133352] = "32603.10:Skitterer Xia:inv_misc_bag_cenarionherbbag:false:both",
	[65094274] = "31954.0:Grand Master Mo'ruk:inv_misc_bag_cenarionherbbag:false:both",
	[65094275] = ADVENTURE..".24:Mo'ruk:inv_tailoring_elekkplushie:false:both",
}
--KunLaiSummit
points[379] = {
	[35185617] = "32604.2:Kafi:inv_misc_bag_cenarionherbbag:false:both",
	[67878469] = "32604.3:Dos'Ryga:inv_misc_bag_cenarionherbbag:false:both",
	[35185618] = "32603.7:Kafi:inv_misc_bag_cenarionherbbag:false:both",
	[67878470] = "32603.8:Dos'Ryga:inv_misc_bag_cenarionherbbag:false:both",
	[64809360] = "32441.0:Thundering Pandaren Spirit:inv_pet_pandarenelemental_earth:false:both",
	[64809361] = ADVENTURE..".39:Thundering Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[35807361] = "31956.0:Grand Master Yon:inv_misc_bag_cenarionherbbag:false:both",
	[35807360] = ADVENTURE..".11:Courageous Yon:inv_tailoring_elekkplushie:false:both",
}
--TheJadeForest
points[371] = {
	[48427096] = "32604.1:Ka'wi the Gorger:inv_misc_bag_cenarionherbbag:false:both",
	[57042912] = "32604.4:Nitun:inv_misc_bag_cenarionherbbag:false:both",
	[48427097] = "32603.1:Ka'wi the Gorger:inv_misc_bag_cenarionherbbag:false:both",
	[57042913] = "32603.9:Nitun:inv_misc_bag_cenarionherbbag:false:both",
	[28803600] = "32440.0:Whispering Pandaren Spirit:inv_pet_pandarenelemental_air:false:both",
	[28803601] = ADVENTURE..".42:Whispering Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[48005400] = "31953.0:Grand Master Hyuna:inv_misc_bag_cenarionherbbag:false:both",
	[48005401] = ADVENTURE..".19:Hyuna of the Shrines:inv_tailoring_elekkplushie:false:both",
}
--TownlongSteppes
points[388] = {
	[72267978] = "32869.3:Ti'un the Wanderer:inv_misc_bag_cenarionherbbag:false:both",
	[72267979] = "32603.9:Ti'un the Wanderer:inv_misc_bag_cenarionherbbag:false:both",
	[57004220] = "32434.0:Burning Pandaren Spirit:inv_pet_pandarenelemental_fire:false:both",
	[57004221] = ADVENTURE..".8:Burning Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[36205220] = "31991.0:Grand Master Zusshi:inv_misc_bag_cenarionherbbag:false:both",
	[36205221] = ADVENTURE..".32:Seeker Zusshi:inv_tailoring_elekkplushie:false:both",
}
--Vale of Eternal Blossoms
points[390] = {
	[11007100] = "32869.2:No-No:inv_misc_bag_cenarionherbbag:false:both",
	[11007101] = "32603.3:No-No:inv_misc_bag_cenarionherbbag:false:both",
	[31207420] = "31958.0:Grand Master Aki:inv_misc_bag_cenarionherbbag:false:both",
	[31207421] = ADVENTURE..".1:Aki the Chosen:inv_tailoring_elekkplushie:false:both",
}
--ValleyoftheFourWinds88
points[376] = {
	[25297854] = "32868.1:Greyhoof:inv_misc_bag_cenarionherbbag:false:both",
	[40544367] = "32868.2:Lucky Yi:inv_misc_bag_cenarionherbbag:false:both",
	[25297855] = "32603.4:Greyhoof:inv_misc_bag_cenarionherbbag:false:both",
	[40544368] = "32603.5:Lucky Yi:inv_misc_bag_cenarionherbbag:false:both",
	[46004360] = "31955.0:Grand Master Nishi:inv_misc_bag_cenarionherbbag:false:both",
	[46004361] = ADVENTURE..".14:Farmer Nishi:inv_tailoring_elekkplushie:false:both",
}

--Other Bags
--Winterspring
points[83] = {
	[65606440] =	"31909.0:Stone Cold Trixxy:inv_misc_bag_cenarionherbbag:false:both",
	[65606441] =	ADVENTURE..".34:Stone Cold Trixxy:inv_tailoring_elekkplushie:false:both",
}
--Uldum
points[249] = {
	[56604180] =	"31971.0:Obalis:inv_misc_bag_cenarionherbbag:false:both",
	[56604181] =	ADVENTURE..".29:Obalis:inv_tailoring_elekkplushie:false:both",
}
--IcecrownGlacier
points[118] = {
	[77401960] =	"31935.0:Major Payne:inv_misc_bag_cenarionherbbag:false:both",
	[77401961] =	ADVENTURE..".23:Major Payne:inv_tailoring_elekkplushie:false:both",
}
--ShadowmoonValley
points[539] = {
	[30404180] =	"31926.0:Blood Master Antari:inv_misc_bag_cenarionherbbag:false:both",
	[30404181] =	ADVENTURE..".5:Bloodknight Antari:inv_tailoring_elekkplushie:false:both",
}
--DeadwindPass
points[42] = {
	[40207640] =	"31916.0:Lydia Accoste:inv_misc_bag_cenarionherbbag:false:both",
	[40207641] =	ADVENTURE..".22:Lydia Accoste:inv_tailoring_elekkplushie:false:both",
}
--TimelessIsle
points[554] = {
	[34805960] =	"33137.0:Celestial Tournament:inv_misc_trinketpanda_07:false:both",
	[34805964] =	ADVENTURE..".4:Blingtron 4000:inv_tailoring_elekkplushie:false:both",
	[34805969] =	ADVENTURE..".9:Chen Stormstout:inv_tailoring_elekkplushie:false:both",
	[34805963] =	ADVENTURE..".13:Dr. Ion Goldbloom:inv_tailoring_elekkplushie:false:both",
	[34805961] =	ADVENTURE..".21:Lorewalker Cho:inv_tailoring_elekkplushie:false:both",
	[34805962] =	ADVENTURE..".33:Shademaster Kiryn:inv_tailoring_elekkplushie:false:both",
	[34805965] =	ADVENTURE..".35:Sully \"The Pickle\" McLeary:inv_tailoring_elekkplushie:false:both",
	[34805967] =	ADVENTURE..".37:Taran Zhu:inv_tailoring_elekkplushie:false:both",
	[34805966] =	ADVENTURE..".43:Wise Mari:inv_tailoring_elekkplushie:false:both",
	[34805968] =	ADVENTURE..".44:Wrathion:inv_tailoring_elekkplushie:false:both",
}
--CelestialChallenge
points[571] = {
	[40005640] =	ADVENTURE..".4:Blingtron 4000:inv_tailoring_elekkplushie:false:both",
	[40405660] =	ADVENTURE..".9:Chen Stormstout:inv_tailoring_elekkplushie:false:both",
	[40205620] =	ADVENTURE..".13:Dr. Ion Goldbloom:inv_tailoring_elekkplushie:false:both",
	[40005260] =	ADVENTURE..".21:Lorewalker Cho:inv_tailoring_elekkplushie:false:both",
	[37805720] =	ADVENTURE..".33:Shademaster Kiryn:inv_tailoring_elekkplushie:false:both",
	[37805721] =	ADVENTURE..".35:Sully \"The Pickle\" McLeary:inv_tailoring_elekkplushie:false:both",
	[40005261] =	ADVENTURE..".37:Taran Zhu:inv_tailoring_elekkplushie:false:both",
	[40005262] =	ADVENTURE..".43:Wise Mari:inv_tailoring_elekkplushie:false:both",
	[37805722] =	ADVENTURE..".44:Wrathion:inv_tailoring_elekkplushie:false:both"
}
--Northern Barrens
points[10] = {
	[38806820] =    "45539.0:Wailing Caverns Dungeon:inv_misc_bag_bigbagofenchantments:false:both",
	[63603580] = 	"45083.0:Crysa:inv_misc_bag_12:false:both",
	[58605300] = 	"31819.0:Dagra the Fierce:inv_misc_coin_01:true:horde",
}
--Westfall
points[52] = {
	[41407120] = 	"46292.0:Pet Challenge Deadmines:timelesscoin-bloody:false:both",
	--starting Alliance only coin rewards
	[60801860] = 	"31780.0:Old MacDonald:inv_misc_coin_01:true:alliance",
}
--Elwynn Forest
points[37] = {
	[41608360] = 	"31693.0:Julia Stevens:inv_misc_coin_02:true:alliance",
}
--Redridge Mountains
points[49] = {
	[33205260] = 	"31781.0:Lindsay:inv_misc_coin_01:true:alliance",
}
--Duskwood
points[47] = {
	[19804480] = 	"31850.0:Eric Davidson:inv_misc_coin_01:true:alliance",
}
--Northern Stranglethorn
points[50] = {
	[46004040] = 	"31852.0:Steven Lisbane:inv_misc_coin_01:true:alliance",
}
--TheCapeOfStranglethorn
points[210] = {
	[51407320] = 	"31851.0:Bill Buckler:inv_misc_coin_01:true:alliance",
}
--Hinterlands
points[26] = {
	[62805460] = 	"31910.0:David Kosse:inv_misc_coin_01:true:alliance",
}
--EasternPlaguelands
points[23] = {
	[67005240] = 	"31911.0:Deiza Plaguehorn:inv_misc_coin_01:true:alliance",
}
--Dun Morogh
points[30] = {
	[31407160] = 	"54186.0:Pet Challenge Gnomeregan:inv_misc_enggizmos_35:false:both"
}
points[27] = {
	[30003500] = 	"54186.0:Pet Challenge Gnomeregan:inv_misc_enggizmos_35:false:both"
}
--Searing Gorge
points[32] = {
	[35402780] = 	"31912.0:Kortas Darkhammer:inv_misc_coin_01:true:alliance",
}
--SwampOfSorrows
points[51] = {
	[76604140] = 	"31913.0:Everessa:inv_misc_coin_01:true:alliance",
}
--Burning Steppes
points[36] = {
	[25604760] = 	"31914.0:Durin Darkhammer:inv_misc_coin_01:true:alliance",
}

--Starting Horde only coin rewards
--Durotar
points[1] = {
	[43802880] = 	"31818.0:Zunta:inv_misc_coin_02:true:horde",
}
--Ashenvale
points[63] = {
	[20202960] = 	"31854.0:Analynn:inv_misc_coin_01:true:horde",
}
--Stonetalon
points[65] = {
	[59607160] = 	"31862.0:Zonya the Sadist:inv_misc_coin_01:true:horde",
}
--Desolace
points[66] = {
	[57204580] = 	"31872.0:Merda Stronghoof:inv_misc_coin_01:true:horde",
}
--SouthernBarrens
points[199] = {
	[39607920] = 	"31904.0:Cassandra Kaboom:inv_misc_coin_01:true:horde",
}
--Feralas
points[69] = {
	[59604960] = 	"31871.0:Traitor Gluk:inv_misc_coin_01:true:horde",
}
--Dustwallow
points[70] = {
	[53807480] = 	"31905.0:Grazzle the Great:inv_misc_coin_01:true:horde",
}
--ThousandNeedles
points[64] = {
	[31803280] = 	"31906.0:Kela Grimtotem:inv_misc_coin_01:true:horde",
}
--Felwood
points[77] = {
	[40005660] = 	"31907.0:Zoltan:inv_misc_coin_01:true:horde",
}
--Moonglade
points[80] = {
	[46006040] = 	"31908.0:Elena Flutterfly:inv_misc_coin_01:true:horde",
}
--Starting coin rewards for both
--Hellfire
points[100] = {
	[64404920] = 	"31922.0:Nicki Tinytech:inv_misc_coin_01:true:both",
	[64404921] =	ADVENTURE..".28:Nicki Tinytech:inv_tailoring_elekkplushie:false:both",
}
--Zangarmarsh
points[102] = {
	[17205040] = 	"31923.0:Ras'an:inv_misc_coin_01:true:both",
	[17205041] =	ADVENTURE..".31:Ras'an:inv_tailoring_elekkplushie:false:both",
}
--Nagrand
points[107] = {
	[61004940] = 	"31924.0:Narrok:inv_misc_coin_01:true:both",
	[61004941] =	ADVENTURE..".26:Narrok:inv_tailoring_elekkplushie:false:both",
}
--ShattrathCity
points[111] = {
	[59007000] = 	"31925.0:Morulu The Elder:inv_misc_coin_01:true:both",
	[59007001] =	ADVENTURE..".25:Morulu the Elder:inv_tailoring_elekkplushie:false:both",
}
--Deepholm
points[207] = {
	[49805700] = 	"31973.0:Bordin Steadyfist:inv_misc_coin_01:true:both",
	[49805701] =	ADVENTURE..".6:Bordin Steadyfist:inv_tailoring_elekkplushie:false:both",
}
--Hyjal
points[198] = {
	[61403280] = 	"31972.0:Brok:inv_misc_coin_01:true:both",
	[61403281] =	ADVENTURE..".7:Brok:inv_tailoring_elekkplushie:false:both",
}
--TwilightHighlands
points[241] = {
	[56605680] = 	"31974.0:Goz Banefury:inv_misc_coin_01:true:both",
	[56605681] =	ADVENTURE..".17:Goz Banefury:inv_tailoring_elekkplushie:false:both",
}
--HowlingFjord
points[117] = {
	[28603380] = 	"31931.0:Beegle Blastfuse:inv_misc_coin_01:true:both",
	[28603381] =	ADVENTURE..".3:Beegle Blastfuse:inv_tailoring_elekkplushie:false:both",
}
--ZulDrak
points[121] = {
	[13206680] = 	"31934.0:Gutretch:inv_misc_coin_01:true:both",
	[13206681] =	ADVENTURE..".18:Gutretch:inv_tailoring_elekkplushie:false:both",
}
--CrystalsongForest
points[127] = {
	[50205900] = 	"31932.0:Nearly Headless Jacob:inv_misc_coin_01:true:both",
	[50205901] =	ADVENTURE..".27:Nearly Headless Jacob:inv_tailoring_elekkplushie:false:both",
}
--Dragonblight
points[115] = {
	[59007700] = 	"31933.0:Okrut Dragonwaste:inv_misc_coin_01:true:both",
	[59007701] =	ADVENTURE..".30:Okrut Dragonwaste:inv_tailoring_elekkplushie:false:both",
}
--Tokens
points[539] = {
	[50003120] =	"37203.0:Ashlei:achievement_guildperk_honorablemention:false:both",
	[50003121] =	ADVENTURE..".2:Ashlei:inv_tailoring_elekkplushie:false:both",

}
--SpiresOfArak
points[542] = {
	[46204540] =	"37207.0:Vesharr:achievement_guildperk_honorablemention:false:both",
	[46204541] =	ADVENTURE..".40:Vesharr:inv_tailoring_elekkplushie:false:both",
}
--Talador
points[535] = {
	[49008040] =	"37208.0:Taralune:achievement_guildperk_honorablemention:false:both",
	[49008041] =	ADVENTURE..".36:Taralune:inv_tailoring_elekkplushie:false:both",
}
--NagrandDraenor
points[550] = {
	[56200980] =	"37206.0:Tarr the Terrible:achievement_guildperk_honorablemention:false:both",
	[56200981] =	ADVENTURE..".38:Tarr the Terrible:inv_tailoring_elekkplushie:false:both",
}
--FrostfireRidge88
points[525] = {
	[68606460] =	"37205.0:Gargra:achievement_guildperk_honorablemention:false:both",
	[68606461] =	ADVENTURE..".16:Gargra:inv_tailoring_elekkplushie:false:both",
}
--Gorgrond
points[543] = {
	[51007060] =	"37201.0:Cymre Brightblade:achievement_guildperk_honorablemention:false:both",
	[51007061] =	ADVENTURE..".12:Cymre Brightblade:inv_tailoring_elekkplushie:false:both",
}
--Garrison Alliance
points[579] = {
	[28803920] = "36483.0:Battle Pet Roundup:achievement_guildperk_honorablemention:false:both",
	[29904040] = "38299.0:Erris the Collector:inv_misc_bag_22:false:both",
}
--Frostwall
points[590] = {
	[32404240] = "36483.0:Battle Pet Roundup:achievement_guildperk_honorablemention:false:horde",
	[33604240] = "38299.0:Kura Thunderhoof:inv_misc_bag_22:false:horde",
}
--Azsuna
points[630] = {
	[49504530] = "40310.0:Shipwrecked Captive (Sternfathom's Journal):achievement_guildperk_honorablemention:false:both",
}
--DarkmoonFaireIsland
points[407] = {
	[47206260] ="32175.0:Jeremy Feasel:Inv_misc_bag_felclothbag:false:both",
	[47206261] =ADVENTURE..".20:Jeremy Feasel:inv_tailoring_elekkplushie:false:both",
	[47406220] = "36471.0:Christoph VonFeasel:inv_misc_bag_31:false:both",
	[47406221] = ADVENTURE..".10:Christoph VonFeasel:inv_tailoring_elekkplushie:false:both",
}
--Krokuun
points[830] = {
	[66807270] = ARGUS..".1:Ruinhoof:icon_podlinggold:false:both",
	[66807271] = FAMILY..".1:Ruinhoof:inv_argustalbukmount_felred:false:both",
	[51506380] = ARGUS..".2:Foulclaw:icon_podlinggold:false:both",
	[51506381] = FAMILY..".2:Foulclaw:inv_argustalbukmount_felred:false:both",
	[43005200] = ARGUS..".3:Baneglow:icon_podlinggold:false:both",
	[43005201] = FAMILY..".3:Baneglow:inv_argustalbukmount_felred:false:both",
	[58003000] = ARGUS..".4:Retch:icon_podlinggold:false:both",
	[58053001] = FAMILY..".4:Retch:inv_argustalbukmount_felred:false:both",
	[30005850] = ARGUS..".5:Deathscreech:icon_podlinggold:false:both",
	[30005851] = FAMILY..".5:Deathscreech:inv_argustalbukmount_felred:false:both",
	[40006600] = ARGUS..".6:Gnasher:icon_podlinggold:false:both",
	[40006601] = FAMILY..".6:Gnasher:inv_argustalbukmount_felred:false:both"
}
--Antoran Wastes
points[885] = {
	[51604140] = ARGUS..".13:Watcher:icon_podlinggold:false:both",
	[51604141] = FAMILY..".13:Watcher:inv_argustalbukmount_felred:false:both",
	[56605430] = ARGUS..".14:Bloat:icon_podlinggold:false:both",
	[56605431] = FAMILY..".14:Bloat:inv_argustalbukmount_felred:false:both",
	[56102870] = ARGUS..".15:Earseeker:icon_podlinggold:false:both",
	[56102871] = FAMILY..".15:Earseeker:inv_argustalbukmount_felred:false:both",
	[64006590] = ARGUS..".16:Pilfer:icon_podlinggold:false:both",
	[64006591] = FAMILY..".16:Pilfer:inv_argustalbukmount_felred:false:both",
	[76607410] = ARGUS..".17:Minixis:icon_podlinggold:false:both",
	[76607411] = FAMILY..".17:Minixis:inv_argustalbukmount_felred:false:both",
	[59904030] = ARGUS..".18:One-of-Many:icon_podlinggold:false:both",
	[59904031] = FAMILY..".18:One-of-Many:inv_argustalbukmount_felred:false:both"
}
--ArgusMacAree
points[882] = {
	[67604390] = ARGUS..".7:Bucky:icon_podlinggold:false:both",
	[67604391] = FAMILY..".7:Bucky:inv_argustalbukmount_felred:false:both",
	[69705190] = ARGUS..".8:Snozz:icon_podlinggold:false:both",
	[69705191] = FAMILY..".8:Snozz:inv_argustalbukmount_felred:false:both",
	[60007110] = ARGUS..".9:Gloamwing:icon_podlinggold:false:both",
	[60007111] = FAMILY..".9:Gloamwing:inv_argustalbukmount_felred:false:both",
	[36005410] = ARGUS..".10:Shadeflicker:icon_podlinggold:false:both",
	[36005411] = FAMILY..".10:Shadeflicker:inv_argustalbukmount_felred:false:both",
	[31903120] = ARGUS..".11:Corrupted Blood of Argus:icon_podlinggold:false:both",
	[31903121] = FAMILY..".11:Corrupted Blood of Argus:inv_argustalbukmount_felred:false:both",
	[74703620] = ARGUS..".12:Mar'cuus:icon_podlinggold:false:both",
	[74703621] = FAMILY..".12:Mar'cuus:inv_argustalbukmount_felred:false:both"
}
--Drustvar
points[896] = {
	[21406640] = BATTLER..".1:Captain Hermes:inv_komododragon_gilaorange:false:both",
	[63605960] = BATTLER..".3:Dilbert McClint:inv_komododragon_gilaorange:false:both",
	[38203860] = BATTLER..".4:Fizzie Sparkwhistle:inv_komododragon_gilaorange:false:both",
	[61001760] = BATTLER..".5:Michael Skarn:inv_komododragon_gilaorange:false:both",
}
--Stromsong Valley
points[942] = {
	[77202900] = BATTLER..".7:Leana Darkwind:inv_komododragon_gilaorange:false:both",
	[36603360] = BATTLER..".2:Eddie Fixit:inv_komododragon_gilaorange:false:both",
	[65005080] = BATTLER..".6:Ellie Vern:inv_komododragon_gilaorange:false:both",
}
--Tiragarde Sound
points[895] = {
	[86203860] = BATTLER..".8:Kwint:inv_komododragon_gilaorange:false:both",
	[59603320] = BATTLER..".9:Delia Hanako:inv_komododragon_gilaorange:false:both",
	[67601280] = BATTLER..".10:Burly:inv_komododragon_gilaorange:false:both",
}
--Zuldazar
points[862] = {
	[70602960] = BATTLER..".17:Karaga:inv_komododragon_gilaorange:false:both",
	[48403500] = BATTLER..".18:Talia Sparkbrow:inv_komododragon_gilaorange:false:both",
	[50602400] = BATTLER..".19:Zujal:inv_komododragon_gilaorange:false:both",
}
--Nazmir
points[863] = {
	[72804860] = BATTLER..".11:Lozu:inv_komododragon_gilaorange:false:both",
	[43003880] = BATTLER..".13:Korval Darkbeard:inv_komododragon_gilaorange:false:both",
	[36005460] = BATTLER..".12:Grady Prett:inv_komododragon_gilaorange:false:both",
}
--Vol'dun
points[864] = {
	[26605480] = BATTLER..".15:Sizzik:inv_komododragon_gilaorange:false:both",
	[45004640] = BATTLER..".16:Kusa:inv_komododragon_gilaorange:false:both",
	[57004900] = BATTLER..".14:Keeyo:inv_komododragon_gilaorange:false:both",
}

--Nazjatar
points[1355]= {
	[34702740] = NUISANCES..".1:Prince Wiggletail:inv_seasnail_bluepink:false:both",
	[71905110] = NUISANCES..".2:Chomp:inv_seasnail_bluepink:false:both",
	[58304810] = NUISANCES..".3:Silence:inv_seasnail_bluepink:false:both",
	[42201400] = NUISANCES..".4:Shadowspike Lurker:inv_seasnail_bluepink:false:both",
	[50605030] = NUISANCES..".5:Pearlhusk Crawler:inv_seasnail_bluepink:false:both",
	[51307500] = NUISANCES..".6:Elderspawn of Nalaada:inv_seasnail_bluepink:false:both",
	[29604970] = NUISANCES..".7:Ravenous Scalespawn:inv_seasnail_bluepink:false:both",
	[56400810] = NUISANCES..".8:Mindshackle:inv_seasnail_bluepink:false:both",
	[46602800] = NUISANCES..".9:Kelpstone:inv_seasnail_bluepink:false:both",
	[37501670] = NUISANCES..".10:Voltgorger:inv_seasnail_bluepink:false:both",
	[59102660] = NUISANCES..".11:Frenzied Knifefang:inv_seasnail_bluepink:false:both",
	[28102670] = NUISANCES..".12:Giant Opaline Conch:inv_seasnail_bluepink:false:both"
}

--Mechagon
points[1462] = {
	[64706460] = MINIONS..".1:Gnomefeaster:inv_mechanicalprairiedog_black:false:both",
	[60704650] = MINIONS..".2:Sputtertube:inv_mechanicalprairiedog_black:false:both",
	[60605690] = MINIONS..".3:Goldenbot XD:inv_mechanicalprairiedog_black:false:both",
	[59205090] = MINIONS..".4:Creakclank:inv_mechanicalprairiedog_black:false:both",
	[65405770] = MINIONS..".5:CK-9:inv_mechanicalprairiedog_black:false:both",
	[51104540] = MINIONS..".6:Unit 35:inv_mechanicalprairiedog_black:false:both",
	[39504010] = MINIONS..".7:Unit 6:inv_mechanicalprairiedog_black:false:both",
	[72107290] = MINIONS..".8:Unit 17:inv_mechanicalprairiedog_black:false:both"
}
--Revendreth
points[1525] = {
	[26606200] = ABHORRENT .. ".3:Chittermaw:inv_pet_batpetrevendreth_red:false:both",
	[25602360] = ABHORRENT .. ".5:Sewer Creeper:inv_pet_batpetrevendreth_red:false:both",
	[53004160] = ABHORRENT .. ".6:The Countess:inv_pet_batpetrevendreth_red:false:both",
	[40005260] = EXORCIST .. ".1:Sylla:ability_mount_pandaranmountpurple:false:both",
	[67606600] = EXORCIST .. ".2:Eyegor:ability_mount_pandaranmountpurple:false:both",
	[61204100] = EXORCIST .. ".3:Addius the Tormenter:ability_mount_pandaranmountpurple:false:both",
	[61204101] = BATTLE_SL..".5:Addius the Tormentor:inv_pet_achievement_pandaria:false:both",
	[67606601] = BATTLE_SL..".6:Eyegor:inv_pet_achievement_pandaria:false:both",
	[40005261] = BATTLE_SL..".7:Sylla:inv_pet_achievement_pandaria:false:both",
}
--Maldraxxus
points[1536] = {
	[61807880] = ABHORRENT .. ".8:Gelatinous:inv_pet_batpetrevendreth_red:false:both",
	[26602680] = ABHORRENT ..".10:Glurp:inv_pet_batpetrevendreth_red:false:both",
	[34005520] = EXORCIST .. ".4:Rotgut:ability_mount_pandaranmountpurple:false:both",
	[63204680] = EXORCIST .. ".5:Dundley Stickyfingers:ability_mount_pandaranmountpurple:false:both",
	[46805000] = EXORCIST .. ".6:Caregiver Maximillian:ability_mount_pandaranmountpurple:false:both",
	[25203800] = BATTLE_SL..".8:Scorch:inv_pet_achievement_pandaria:false:both",
	[54002800] = BATTLE_SL..".9:Gorgemouth:inv_pet_achievement_pandaria:false:both",
	[63204681] = BATTLE_SL..".10:Dundley Stickyfingers:inv_pet_achievement_pandaria:false:both",
	[34005521] = BATTLE_SL..".11:Rotgut XD:inv_pet_achievement_pandaria:false:both",
	[46805001] = BATTLE_SL..".12:Caregiver Maximillian:inv_pet_achievement_pandaria:false:both",
}
--Bastion
points[1533] = {
	[52607420] = ABHORRENT .. ".1:Crystalsnap:inv_pet_batpetrevendreth_red:false:both",
	[25803080] = ABHORRENT .. ".7:Digallo:inv_pet_batpetrevendreth_red:false:both",
	[46604940] = ABHORRENT .. ".9:Kostos:inv_pet_batpetrevendreth_red:false:both",
	[51403820] = EXORCIST .. ".7:Zolla:ability_mount_pandaranmountpurple:false:both",
	[54605600] = EXORCIST .. ".8:Thenia:ability_mount_pandaranmountpurple:false:both",
	[34806280] = EXORCIST .. ".9:Stratios:ability_mount_pandaranmountpurple:false:both",
	[54605601] = BATTLE_SL..".13:Thenia:inv_pet_achievement_pandaria:false:both",
	[51403821] = BATTLE_SL..".14:Zolla:inv_pet_achievement_pandaria:false:both",
	[34806281] = BATTLE_SL..".15:Stratios:inv_pet_achievement_pandaria:false:both",
	[36603180] = BATTLE_SL..".16:Jawbone:inv_pet_achievement_pandaria:false:both"
}
--Ardenweald
points[1565] = {
	[34204460] = ABHORRENT .. ".2:Briarpaw:inv_pet_batpetrevendreth_red:false:both",
	[26606200] = ABHORRENT .. ".3:Chittermaw:inv_pet_batpetrevendreth_red:false:both",
	[49804160] = ABHORRENT .. ".4:Mistwing:inv_pet_batpetrevendreth_red:false:both",
	[58205680] = EXORCIST ..".10:Glitterdust:ability_mount_pandaranmountpurple:false:both",
	[51204400] = EXORCIST ..".11:Faryl:ability_mount_pandaranmountpurple:false:both",
	[40202880] = BATTLE_SL..".1:Rascal:inv_pet_achievement_pandaria:false:both",
	[51204401] = BATTLE_SL..".2:Faryl:inv_pet_achievement_pandaria:false:both",
	[40006440] = BATTLE_SL..".3:Nightfang:inv_pet_achievement_pandaria:false:both",
	[58205681] = BATTLE_SL..".4:Glitterdust:inv_pet_achievement_pandaria:false:both",
}
--The Azure Span
points[2024] = {
	[41005940] = BATTLER_DI .. ".1:Arcantus:inv_icon_feather02d:false:both",
	[13804980] = BATTLER_DI .. ".5:Patchu:inv_icon_feather02d:false:both",
	[41005941] = BATTLE_DI .. ".2:Arcantus:inv_pet_achievement_pandaria:false:both",
	[13804981] = BATTLE_DI .. ".4:Patchu:inv_pet_achievement_pandaria:false:both"
}
--Thaldraszus
points[2025] = {
	[39407340] = BATTLER_DI .. ".3:Enyobon:inv_icon_feather02d:false:both",
	[56204920] = BATTLER_DI .. ".6:Setimothes:inv_icon_feather02d:false:both",
	[39407341] = BATTLE_DI .. ".5:Enyobon:inv_pet_achievement_pandaria:false:both",
	[56204921] = BATTLE_DI .. ".8:Setimothes:inv_pet_achievement_pandaria:false:both",
}
--Ohn'ahran Plains
points[2023] = {
	[24404220] = BATTLER_DI .. ".7:Stormamu:inv_icon_feather02d:false:both",
	[62004160] = BATTLER_DI .. ".2:Bakhushek:inv_icon_feather02d:false:both",
	[24404221] = BATTLE_DI .. ".1:Stormamu:inv_pet_achievement_pandaria:false:both",
	[62004161] = BATTLE_DI .. ".7:Bakhushek:inv_pet_achievement_pandaria:false:both",
}
--The Waking Shores
points[2022] = {
	[38808320] = BATTLER_DI .. ".4:Haniko:inv_icon_feather02d:false:both",
	[26009240] = BATTLER_DI .. ".8:Swog:inv_icon_feather02d:false:both",
	[38808321] = BATTLE_DI .. ".6:Haniko:inv_pet_achievement_pandaria:false:both",
	[26009241] = BATTLE_DI .. ".3:Swog:inv_pet_achievement_pandaria:false:both"
}
addon.points = points