-- Created by cigamit
-- Modified by Impala

-----------------------------------------------------------------------------------------------------------------------
--[ init functions ]
local ScrollingTable = LibStub("ScrollingTable")

-----------------------------------------------------------------------------------------------------------------------
--[ saved vars ]
 MountainOOptions = {
	tcg = true,
	}


-----------------------------------------------------------------------------------------------------------------------
--[ local vars ]

local MountainO =
{

}

local version = 2.0



	--[[--------------------------------------------------------------------------------
	Mount Data
	- spellID  - (number)  spellID of the mount
	- itemID   - (number)  itemID which trains a mount or nil
	- level    - (number)  level at which the mount can be learned/purchased
	- skill    - (number)  skill level at which the mount can be learned/used
	- faction  - (string)  FACTION_ALLIANCE, FACTION_HORDE or nil
TODO	- race     - (string)  race where the mount can be purchased from
	- class    - (string)  atm "WARLOCK", "PALADIN", "DEATHKNIGHT" or nil
	- isFlying - (boolean) true or nil
	- isGround - (boolean) true or nil
	- speed    - (number)  speed in percent, nil if scaling
	- aq40     - (boolean) true or nil
	(see also http://www.wowwiki.com/Mount)
	(see also http://www.wowhead.com/?spells=-5)
	--------------------------------------------------------------------------------]]--
local	mountData = {

		-- class mounts (Warlock)
		{spellID=5784, itemID=nil, level=20, skill=75, class="WARLOCK", isGround=true, speed=60, from="Warlock Mount"}, -- Felsteed
		{spellID=23161, itemID=nil, level=60, skill=150, class="WARLOCK", isGround=true, speed=100, from="Warlock Mount"}, -- Dreadsteed
		-- class mounts (Paladin)
		{spellID=13819, itemID=nil, level=20, skill=75, faction=FACTION_ALLIANCE, class="PALADIN", isGround=true, speed=60, from="Paladin Mount"}, -- Warhorse (Human, Dwarf, Draenei)
		{spellID=23214, itemID=nil, level=60, skill=150, faction=FACTION_ALLIANCE, class="PALADIN", isGround=true, speed=100, from="Paladin Mount"}, -- Charger (Human, Dwarf, Draenei)
		{spellID=34769, itemID=nil, level=20, skill=75, faction=FACTION_HORDE, class="PALADIN", isGround=true, speed=60, from="Paladin Mount"}, -- Warhorse (Blood Elf)
		{spellID=34767, itemID=nil, level=60, skill=150, faction=FACTION_HORDE, class="PALADIN", isGround=true, speed=100, from="Paladin Mount"}, -- Charger (Blood Elf)
		{spellID=66906, itemID=47179, level=40, skill=150, class="PALADIN", isGround=true, speed=100, from="Argent Tournaments - Paladin Mount"}, -- Argent Charger
		{spellID=73629, itemID=nil, level=20, skill=75, class="PALADIN", faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Paladin Draenei Mount"}, -- Exarch's Elekk
		{spellID=73630, itemID=nil, level=40, skill=125, class="PALADIN", faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Paladin Draenei Mount"}, -- Great Exarch's Elekk

		-- class mounts (Death Knight)
		{spellID=48778, itemID=nil, level=55, skill=75, class="DEATHKNIGHT", isGround=true, speed=60, from="Deathknight Mount"}, -- Deathcharger
		{spellID=54729, itemID=40775, level=70, skill=225, class="DEATHKNIGHT", isFlying=true, isScaling=true, from="Deathknight Mount"}, -- Winged Steed of the Ebon Blade

		-- ground mounts (Stormwind)
		{spellID=458, race=nil, itemID=5656, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Stormwind (Exalted)"}, -- Brown Horse
		{spellID=470, race=nil, itemID=2411, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Stormwind (Exalted)"}, -- Black Stallion
		{spellID=472, race=nil, itemID=2414, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Stormwind (Exalted)"}, -- Pinto
		{spellID=6648, race=nil, itemID=5655, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Stormwind (Exalted)"}, -- Chestnut Mare
		{spellID=23229, race=nil, itemID=18777, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Stormwind (Exalted)"}, -- Swift Brown Steed
		{spellID=23227, race=nil, itemID=18776, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Stormwind (Exalted)"}, -- Swift Palomino
		{spellID=23228, race=nil, itemID=18778, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Stormwind (Exalted)"}, -- Swift White Steed

		-- ground mounts (Darnassus)
		{spellID=10789, race=nil, itemID=8632, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Darnassus (Exalted)"}, -- Spotted Frostsaber
		{spellID=8394, race=nil, itemID=8631, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Darnassus (Exalted)"}, -- Striped Frostsaber
		{spellID=66847, race=nil, itemID=47100, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Darnassus (Exalted)"}, -- Striped Dawnsaber
		{spellID=10793, race=nil, itemID=8629, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Darnassus (Exalted)"}, -- Striped Nightsaber
		{spellID=23221, race=nil, itemID=18766, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Darnassus (Exalted)"}, -- Swift Frostsaber
		{spellID=23219, race=nil, itemID=18767, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Darnassus (Exalted)"}, -- wift Mistsaber
		{spellID=23338, race=nil, itemID=18902, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Darnassus (Exalted)"}, -- Swift Stormsaber

		-- ground mounts (Ironforge)
		{spellID=6777, race=nil, itemID=5864, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Ironforge (Exalted)"}, -- Gray Ram
		{spellID=6898, race=nil, itemID=5873, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Ironforge (Exalted)"}, -- White Ram
		{spellID=6899, race=nil, itemID=5872, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Ironforge (Exalted)"}, -- Brown Ram
		{spellID=23238, race=nil, itemID=18786, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Ironforge (Exalted)"}, -- Swift Brown Ram
		{spellID=23239, race=nil, itemID=18787, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Ironforge (Exalted)"}, -- Swift Gray Ram
		{spellID=23240, race=nil, itemID=18785, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Ironforge (Exalted)"}, -- Swift White Ram

		-- ground mounts (Gnomeregan)
		{spellID=10969, race=nil, itemID=8595, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Ironforge (Exalted)"}, -- Blue Mechanostrider
		{spellID=17453, race=nil, itemID=13321, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from=""}, -- Green Mechanostrider
		{spellID=10873, race=nil, itemID=8563, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from=""}, -- Red Mechanostrider
		{spellID=17454, race=nil, itemID=13322, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from=""}, -- Unpainted Mechanostrider
		{spellID=23225, race=nil, itemID=18772, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from=""}, -- Swift Green Mechanostrider
		{spellID=23223, race=nil, itemID=18773, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from=""}, -- Swift White Mechanostrider
		{spellID=23222, race=nil, itemID=18774, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from=""}, -- Swift Yellow Mechanostrider

		-- ground mounts (Exodar)
		{spellID=34406, race=nil, itemID=28481, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Gnomeregan (Exalted)"}, -- Brown Elekk
		{spellID=35710, race=nil, itemID=29744, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Gnomeregan (Exalted)"}, -- Gray Elekk
		{spellID=35711, race=nil, itemID=29743, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Gnomeregan (Exalted)"}, -- Purple Elekk
		{spellID=35713, race=nil, itemID=29745, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Gnomeregan (Exalted)"}, -- Great Blue Elekk
		{spellID=35712, race=nil, itemID=29746, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Gnomeregan (Exalted)"}, -- Great Green Elekk
		{spellID=35714, race=nil, itemID=29747, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Gnomeregan (Exalted)"}, -- Great Purple Elekk

		-- ground mounts (Silvermoon)
		{spellID=35022, race=nil, itemID=29221, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Silvermoon (Exalted)"}, -- Black Hawkstrider
		{spellID=35020, race=nil, itemID=29220, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Silvermoon (Exalted)"}, -- Blue Hawkstrider
		{spellID=35018, race=nil, itemID=29222, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Silvermoon (Exalted)"}, -- Purple Hawkstrider
		{spellID=34795, race=nil, itemID=28927, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Silvermoon (Exalted)"}, -- Red Hawkstrider
		{spellID=35025, race=nil, itemID=29223, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Silvermoon (Exalted)"}, -- Swift Green Hawkstrider
		{spellID=33660, race=nil, itemID=28936, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Silvermoon (Exalted)"}, -- Swift Pink Hawkstrider
		{spellID=35027, race=nil, itemID=29224, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Silvermoon (Exalted)"}, -- Swift Purple Hawkstrider

		-- ground mounts (Darkspear Trolls)
		{spellID=8395, race=nil, itemID=8588, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Darkspear Trolls (Exalted)"}, -- Emerald Raptor
		{spellID=10796, race=nil, itemID=8591, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Darkspear Trolls (Exalted)"}, -- Turquoise Raptor
		{spellID=10799, race=nil, itemID=8592, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Darkspear Trolls (Exalted)"}, -- Violet Raptor
		{spellID=23241, race=nil, itemID=18788, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Darkspear Trolls (Exalted)"}, -- Swift Blue Raptor
		{spellID=23242, race=nil, itemID=18789, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Darkspear Trolls (Exalted)"}, -- Swift Olive Raptor
		{spellID=23243, race=nil, itemID=18790, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Darkspear Trolls (Exalted)"}, -- Swift Orange Raptor

		-- ground mounts (Orgrimmar)
		{spellID=6654, race=nil, itemID=5668, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Orgrimmar (Exalted)"}, -- Brown Wolf
		{spellID=6653, race=nil, itemID=5665, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Orgrimmar (Exalted)"}, -- Dire Wolf
		{spellID=580, race=nil, itemID=1132, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Orgrimmar (Exalted)"}, -- Timber Wolf
		{spellID=64658, race=nil, itemID=46099, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Orgrimmar (Exalted)"}, -- Black Wolf
		{spellID=23250, race=nil, itemID=18796, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Orgrimmar (Exalted)"}, -- Swift Brown Wolf
		{spellID=23252, race=nil, itemID=18798, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Orgrimmar (Exalted)"}, -- Swift Gray Wolf
		{spellID=23251, race=nil, itemID=18797, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Orgrimmar (Exalted)"}, -- Swift Timber Wolf

		-- ground mounts (Thunder Bluff)
		{spellID=18990, race=nil, itemID=15290, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Thunder Bluff (Exalted)"}, -- Brown Kodo
		{spellID=18989, race=nil, itemID=15277, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Thunder Bluff (Exalted)"}, -- Gray Kodo
		{spellID=64657, race=nil, itemID=46100, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Thunder Bluff (Exalted)"}, -- White Kodo
		{spellID=23249, race=nil, itemID=18794, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Thunder Bluff (Exalted)"}, -- Great Brown Kodo
		{spellID=23248, race=nil, itemID=18795, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Thunder Bluff (Exalted)"}, -- Great Gray Kodo
		{spellID=23247, race=nil, itemID=18793, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Thunder Bluff (Exalted)"}, -- Great White Kodo

		-- ground mounts (Undercity)
		{spellID=17464, race=nil, itemID=13333, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Undercity (Exalted)"}, -- Brown Skeletal Horse
		{spellID=17462, race=nil, itemID=13331, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Undercity (Exalted)"}, -- Red Skeletal Horse
		{spellID=17463, race=nil, itemID=13332, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=60, from="Undercity (Exalted)"}, -- Blue Skeletal Horse
		{spellID=64977, race=nil, itemID=46308, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=100, from="Undercity (Exalted)"}, -- Black Skeletal Warhorse
		{spellID=17465, race=nil, itemID=13334, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Undercity (Exalted)"}, -- Green Skeletal Warhorse
		{spellID=23246, race=nil, itemID=18791, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Undercity (Exalted)"}, -- Purple Skeletal Warhorse
		{spellID=66846, race=nil, itemID=47101, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Undercity (Exalted)"}, -- ochre skeletal warhorse

		-- ground mounts (Exalted: Kurenai)
		{spellID=34896, itemID=29227, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Kurenai (Exalted)"}, -- Cobalt War Talbuk
		{spellID=34898, itemID=29229, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Kurenai (Exalted)"}, -- Silver War Talbuk
		{spellID=34899, itemID=29230, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Kurenai (Exalted)"}, -- Tan War Talbuk
		{spellID=34897, itemID=29231, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Kurenai (Exalted)"}, -- White War Talbuk
		{spellID=39315, itemID=31830, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Kurenai (Exalted)"}, -- Cobalt Riding Talbuk
		{spellID=39317, itemID=31832, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Kurenai (Exalted)"}, -- Silver Riding Talbuk
		{spellID=39318, itemID=31834, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Kurenai (Exalted)"}, -- Tan Riding Talbuk
		{spellID=39319, itemID=31836, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Kurenai (Exalted)"}, -- White Riding Talbuk

		-- ground mounts (Exalted: The Mag'har)
		{spellID=34896, itemID=29102, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Mag'har (Exalted)"}, -- Cobalt War Talbuk
		{spellID=34898, itemID=29104, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Mag'har (Exalted)"}, -- Silver War Talbuk
		{spellID=34899, itemID=29105, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Mag'har (Exalted)"}, -- Tan War Talbuk
		{spellID=34897, itemID=29103, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Mag'har (Exalted)"}, -- White War Talbuk
		{spellID=39315, itemID=31829, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Mag'har (Exalted)"}, -- Cobalt Riding Talbuk
		{spellID=39317, itemID=31831, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Mag'har (Exalted)"}, -- Silver Riding Talbuk
		{spellID=39318, itemID=31833, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Mag'har (Exalted)"}, -- Tan Riding Talbuk
		{spellID=39319, itemID=31835, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Mag'har (Exalted)"}, -- White Riding Talbuk

		-- ground mounts (Exalted: Wintersaber Trainers)
		{spellID=17229, itemID=13086, level=60, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Wintersaber Trainers (Exalted)"}, -- Winterspring Frostsaber

		-- ground mounts (Horde - Quest)
		{spellID=64659, itemID=46102, level=40, skill=75, faction=FACTION_HORDE, isGround=true, speed=100, from="Quest (They Grow Up So Fast)"}, -- Venomhide Ravasaur

		-- ground mounts (Exalted: The Sons of Hodir)
		{spellID=59799, itemID=43958, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="The Sons of Hodir (Revered)"}, -- Ice Mammoth
		{spellID=59797, itemID=44080, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Sons of Hodir (Revered)"}, -- Ice Mammoth
		{spellID=61470, itemID=43961, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="The Sons of Hodir (Exalted)"}, -- Grand Ice Mammoth
		{spellID=61469, itemID=44086, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="The Sons of Hodir (Exalted)"}, -- Grand Ice Mammoth

		-- ground mounts (no longer attainable)
		{spellID=17461, race=nil, itemID=13328, level=20, skill=75, faction=FACTION_ALLIANCE, isGround=true, speed=60, from="Unobtainable", obtainable=false}, -- Black Ram
		{spellID=23338, race=nil, itemID=18902, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Unobtainable", obtainable=false}, -- Ancient Frostsaber
		{spellID=23338, race=nil, itemID=18902, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Unobtainable", obtainable=false}, -- Black Nightsaber
		-- 16081 horde

		-- ground mounts (trading cards - classic)
		{spellID=30174, itemID=23720, level=60, skill=150, isGround=true, speed=100, tcg=true, from="WoW Trading Card Game"}, -- Riding Turtle
		-- ground mounts (trading cards - burning crusade)
		{spellID=42776, itemID=33224, level=20, skill=75, isGround=true, speed=60, tcg=true, from="WoW Trading Card Game"}, -- Spectral Tiger
		{spellID=51412, itemID=38576, level=60, skill=150, isGround=true, speed=100, tcg=true, from="WoW Trading Card Game"}, -- Big Battle Bear
		{spellID=42777, itemID=33225, level=60, skill=150, isGround=true, speed=100, tcg=true, from="WoW Trading Card Game"}, -- Swift Spectral Tiger

		-- ground mounts (rare - classic)
		{spellID=26656, itemID=21176, level=60, skill=150, isGround=true, speed=100, from="Unobtainable: AQ40 opening", obtainable=false}, -- Black Qiraji Battle Tank (AQ40 opening quest)
		{spellID=17481, itemID=13335, level=60, skill=150, isGround=true, speed=100, from="Stratholme"}, -- Deathcharger's Reins (Stratholme)
		{spellID=24242, itemID=19872, level=60, skill=150, isGround=true, speed=100, from="Zul'Gurub"}, -- Swift Razzashi Raptor (Zul'Gurub)
		{spellID=24252, itemID=19902, level=60, skill=150, isGround=true, speed=100, from="Zul'Gurub"}, -- Swift Zulian Tiger (Zul'Gurub)
		-- ground mounts (rare - burning crusade)
		{spellID=58983, itemID=43599, level=20, skill=75, isGround=true, speed=60, from="BlizzCon 2008", obtainable=false}, -- Big Blizzard Bear (BlizzCon 2008)
		{spellID=46628, itemID=35513, level=60, skill=150, isGround=true, speed=100, from="Magister's Terrace (Heroic)"}, -- Swift White Hawkstrider (Magister's Terrace - Heroic)
		{spellID=43688, itemID=33809, level=70, skill=150, isGround=true, speed=100, from="Unobtainable - Zul'Aman", obtainable=false}, -- Amani War Bear (Zul'Aman)
		{spellID=36702, itemID=30480, level=70, skill=150, isGround=true, speed=100, from="Karazhan (Attumen)"}, -- Fiery Warhorse (Karazhan)
		{spellID=41252, itemID=32768, level=70, skill=150, isGround=true, speed=100, from="Sethekk Halls (Raven Lord)"}, -- Raven Lord (Sethekk Halls)
		{spellID=49322, itemID=37719, level=70, skill=150, isGround=true, speed=100, from="Recruit-a-Friend", obtainable=false}, -- Swift Zhevra (Recruit-a-Friend)
		{spellID=75973, itemID=54860, level=60, skill=225, isFlying=true, speed=280, from="Recruit-a-Friend", obtainable=false}, -- X-53 Touring Rocket

		-- ground mounts (rare - lich king)
		{spellID=54753, itemID=43962, level=60, skill=150, isGround=true, speed=100, from="Storm Peaks Daily Quest"}, -- White Polar Bear (Quest - Hyldnir Spoils)

		-- ground mounts (pvp - classic)
		{spellID=22719, itemID=29465, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="PVP - Honor"}, -- Black Battlestrider
		{spellID=22720, itemID=29467, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="PVP - Honor"}, -- Black War Ram
		{spellID=22717, itemID=29468, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="PVP - Honor"}, -- Black War Steed Bridle
		{spellID=22723, itemID=29471, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="PVP - Honor"}, -- Black War Tiger
		{spellID=23510, itemID=19030, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="PVP - Honor"}, -- Stormpike Battle Charger
		{spellID=22718, itemID=29466, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="PVP - Honor"}, -- Black War Kodo
		{spellID=22724, itemID=29469, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="PVP - Honor"}, -- Black War Wolf
		{spellID=22722, itemID=29470, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="PVP - Honor"}, -- Red Skeletal Warhorse
		{spellID=22721, itemID=29472, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="PVP - Honor"}, -- Black War Raptor
		{spellID=23509, itemID=19029, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="PVP - Honor"}, -- Frostwolf Howler
		-- ground mounts (pvp - burning crusade)
		{spellID=48027, itemID=35906, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="PVP - Honor"}, -- Black War Elekk
		{spellID=35028, itemID=34129, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="PVP - Honor"}, -- Swift Warstrider
		{spellID=39316, itemID=28915, level=60, skill=150, isGround=true, speed=100, from="Nagrand - Halla"}, -- Dark Riding Talbuk
		{spellID=34790, itemID=29228, level=60, skill=150, isGround=true, speed=100, from="Nagrand - Halla"}, -- Dark War Talbuk
		-- ground mounts (pvp - lich king)
		{spellID=59785, itemID=43956, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="PVP - Wintergrasp"}, -- Black War Mammoth
		{spellID=59788, itemID=44077, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="PVP - Wintergrasp"}, -- Black War Mammoth

		-- ground mounts (AQ40)
		{spellID=25953, level=60, skill=75, itemID=21218, isGround=true, speed=100, aq40=true, from="AQ40 (Trash Drop)"}, -- Blue Qiraji Battle Tank
		{spellID=26054, level=60, skill=75, itemID=21321, isGround=true, speed=100, aq40=true, from="AQ40 (Trash Drop)"}, -- Red Qiraji Battle Tank
		{spellID=26056, level=60, skill=75, itemID=21323, isGround=true, speed=100, aq40=true, from="AQ40 (Trash Drop)"}, -- Green Qiraji Battle Tank
		{spellID=26055, level=60, skill=75, itemID=21324, isGround=true, speed=100, aq40=true, from="AQ40 (Trash Drop)"}, -- Yellow Qiraji Battle Tank

		-- ground mounts (events - burning crusade)
		{spellID=43899, itemID=33976, level=20, skill=75, isGround=true, speed=60, from="Unobtainable, Brewfest (2007)", obtainable=false}, -- Brewfest Ram
		{spellID=49379, itemID=37828, level=60, skill=150, isGround=true, speed=100, from="Holiday Event: Brewfest"}, -- Great Brewfest Kodo
		{spellID=43900, itemID=33977, level=60, skill=150, isGround=true, speed=100, from="Holiday Event: Brewfest"}, -- Swift Brewfest Ram

		-- ground mounts (buyable - lich king)
		{spellID=60114, itemID=44225, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Gold - Dalaran"}, -- Armored Brown Bear
		{spellID=60116, itemID=44226, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Gold - Dalaran"}, -- Armored Brown Bear
		{spellID=59791, itemID=44230, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Badges - Dalaran"}, -- Wooly Mammoth
		{spellID=59793, itemID=44231, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Gold - Dalaran"}, -- Wooly Mammoth
		{spellID=61425, itemID=44235, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Gold - Dalaran"}, -- Traveler's Tundra Mammoth
		{spellID=61447, itemID=44234, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Gold - Dalaran"}, -- Traveler's Tundra Mammoth

		-- ground mounts (archievements - lich king)
		{spellID=60118, itemID=44223, level=60, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="For The Alliance!"}, -- Black War Bear (For The Alliance!)
		{spellID=60119, itemID=44224, level=60, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="For The Horde!"}, -- Black War Bear (For The Horde!)

		-- ground mounts (craftet - lich king)
		{spellID=60424, itemID=44413, level=80, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Engineering (BOE)"}, -- Mekgineer's Chopper (Engineering)
		{spellID=55531, itemID=41508, level=80, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Engineering (BOE)"}, -- Mechano-hog (Engineering)

		-- flying mounts (alliance)
		{spellID=32239, race=nil, itemID=25471, level=70, skill=225, faction=FACTION_ALLIANCE, isFlying=true, speed=60, from="Alliance mount (Dalaran - 50g)"}, -- Ebon Gryphon
		{spellID=32235, race=nil, itemID=25470, level=70, skill=225, faction=FACTION_ALLIANCE, isFlying=true, speed=60, from="Alliance mount (Dalaran - 50g)"}, -- Golden Gryphon
		{spellID=32240, race=nil, itemID=25472, level=70, skill=225, faction=FACTION_ALLIANCE, isFlying=true, speed=60, from="Alliance mount (Dalaran - 50g)"}, -- Snowy Gryphon
		{spellID=32242, race=nil, itemID=25473, level=70, skill=300, faction=FACTION_ALLIANCE, isFlying=true, speed=280, from="Alliance mount (Dalaran - 100g)"}, -- Swift Blue Gryphon
		{spellID=32290, race=nil, itemID=25528, level=70, skill=300, faction=FACTION_ALLIANCE, isFlying=true, speed=280, from="Alliance mount (Dalaran - 100g)"}, -- Swift Green Gryphon
		{spellID=32292, race=nil, itemID=25529, level=70, skill=300, faction=FACTION_ALLIANCE, isFlying=true, speed=280, from="Alliance mount (Dalaran - 100g)"}, -- Swift Purple Gryphon
		{spellID=32289, race=nil, itemID=25527, level=70, skill=300, faction=FACTION_ALLIANCE, isFlying=true, speed=280, from="Alliance mount (Dalaran - 100g)"}, -- Swift Red Gryphon

		-- flying mounts (horde)
		{spellID=32244, race=nil, itemID=25475, level=70, skill=225, faction=FACTION_HORDE, isFlying=true, speed=60, from="Horde Mount - (Dalaran - 50g)"}, -- Blue Wind Rider
		{spellID=32245, race=nil, itemID=25476, level=70, skill=225, faction=FACTION_HORDE, isFlying=true, speed=60, from="Horde Mount - (Dalaran - 50g)"}, -- Green Wind Rider
		{spellID=32243, race=nil, itemID=25474, level=70, skill=225, faction=FACTION_HORDE, isFlying=true, speed=60, from="Horde Mount - (Dalaran - 50g)"}, -- Tawny Wind Rider
		{spellID=32295, race=nil, itemID=25531, level=70, skill=300, faction=FACTION_HORDE, isFlying=true, speed=280, from="Horde Mount - (Dalaran - 100g)"}, -- Swift Green Wind Rider
		{spellID=32297, race=nil, itemID=25533, level=70, skill=300, faction=FACTION_HORDE, isFlying=true, speed=280, from="Horde Mount - (Dalaran - 100g)"}, -- Swift Purple Wind Rider
		{spellID=32246, race=nil, itemID=25477, level=70, skill=300, faction=FACTION_HORDE, isFlying=true, speed=280, from="Horde Mount - (Dalaran - 100g)"}, -- Swift Red Wind Rider
		{spellID=32296, race=nil, itemID=25532, level=70, skill=300, faction=FACTION_HORDE, isFlying=true, speed=280, from="Horde Mount - (Dalaran - 100g)"}, -- Swift Yellow Wind Rider

		-- flying mounts (Exalted: Netherwing)
		{spellID=41514, itemID=32858, level=70, skill=300, isFlying=true, speed=280, from="Netherwing (Exalted)"}, -- Azure Netherwing Drake
		{spellID=41515, itemID=32859, level=70, skill=300, isFlying=true, speed=280, from="Netherwing (Exalted)"}, -- Cobalt Netherwing Drake
		{spellID=41513, itemID=32857, level=70, skill=300, isFlying=true, speed=280, from="Netherwing (Exalted)"}, -- Onyx Netherwing Drake
		{spellID=41516, itemID=32860, level=70, skill=300, isFlying=true, speed=280, from="Netherwing (Exalted)"}, -- Purple Netherwing Drake
		{spellID=41517, itemID=32861, level=70, skill=300, isFlying=true, speed=280, from="Netherwing (Exalted)"}, -- Veridian Netherwing Drake
		{spellID=41518, itemID=32862, level=70, skill=300, isFlying=true, speed=280, from="Netherwing (Exalted)"}, -- Violet Netherwing Drake

		-- flying mounts (Exalted: Sha'tari Skyguard)
		{spellID=39803, itemID=32319, level=70, skill=300, isFlying=true, speed=280, from="Sha'tari Skyguard (Exalted)"}, -- Blue Riding Nether Ray
		{spellID=39798, itemID=32314, level=70, skill=300, isFlying=true, speed=280, from="Sha'tari Skyguard (Exalted)"}, -- Green Riding Nether Ray
		{spellID=39800, itemID=32317, level=70, skill=300, isFlying=true, speed=280, from="Sha'tari Skyguard (Exalted)"}, -- Red Riding Nether Ray
		{spellID=39801, itemID=32316, level=70, skill=300, isFlying=true, speed=280, from="Sha'tari Skyguard (Exalted)"}, -- Purple Riding Nether Ray
		{spellID=39802, itemID=32318, level=70, skill=300, isFlying=true, speed=280, from="Sha'tari Skyguard (Exalted)"}, -- Silver Riding Nether Ray

		-- flying mounts (Exalted: Cenarion Expedition)
		{spellID=43927, itemID=33999, level=70, skill=300, isFlying=true, speed=280, from="Cenarion Expedition (Exalted)"}, -- Cenarion War Hippogryph

		-- flying mounts (Exalted: The Wyrmrest Accord)
		{spellID=59570, itemID=43955, level=70, skill=300, isFlying=true, speed=280, from="Wyrmrest Accord (Exalted)"}, -- Red Drake

		-- flying mounts (pvp - burning crusade - arena)
		{spellID=37015, itemID=30609, level=70, skill=300, isFlying=true, speed=310, obtainable=false, from="Arena - BC"}, -- Swift Nether Drake
		{spellID=44744, itemID=34092, level=70, skill=300, isFlying=true, speed=310, obtainable=false, from="Arena - BC"}, -- Merciless Nether Drake
		{spellID=49193, itemID=37676, level=70, skill=300, isFlying=true, speed=310, obtainable=false, from="Arena - BC"}, -- Vengeful Nether Drake
		{spellID=58615, itemID=43516, level=70, skill=300, isFlying=true, speed=310, obtainable=false, from="Arena - BC"}, -- Brutal Nether Drake

		-- flying mounts (crafted - burning crusade)
		{spellID=44153, itemID=34060, level=70, skill=225, isFlying=true, speed=60, tradeskill="Engineering", from="Engineering (350)"}, -- Flying Machine (Engineering 350)
		{spellID=44151, itemID=34061, level=70, skill=300, isFlying=true, speed=280, tradeskill="Engineering", from="Engineering (375)"}, -- Turbo-Charged Flying Machine (Engineering 375)
		-- flying mounts (crafted - lich king)
		{spellID=61309, itemID=44558, level=70, skill=300, isFlying=true, speed=280, tradeskill="Tailoring", from="Tailoring (425)"}, -- Magnificent Flying Carpet (Tailoring 425)
		{spellID=61442, itemID=44555, level=70, skill=300, isFlying=true, speed=280, tradeskill="Tailoring", from="Tailoring (450)", obtainable=false}, -- Swift Mooncloth Carpet (Tailoring 450)
		{spellID=61446, itemID=44556, level=70, skill=300, isFlying=true, speed=280, tradeskill="Tailoring", from="Tailoring (450)", obtainable=false}, -- Swift Spellfire Carpet (Tailoring 450)
		{spellID=75596, itemID=54797, level=70, skill=300, isFlying=true, speed=280, tradeskill="Tailoring", from="Tailoring (450)"}, -- Frosty Flying Carpet
		{spellID=61451, itemID=44554, level=70, skill=225, isFlying=true, speed=60, tradeskill="Tailoring", from="Tailoring (410)"}, -- Flying Carpet (Tailoring 410)
--		{spellID=nil, itemID=39303, level=70, skill=300, isFlying=true, speed=280, tradeskill="Tailoring", from="Tailoring (420)"}, -- Swift Flying Carpet (Tailoring 420)
--		{spellID=nil, itemID=44557, level=70, skill=300, isFlying=true, speed=280, tradeskill="Tailoring", from="Tailoring (450)"}, -- Swift Ebonweave Carpet (Tailoring 450)

		-- flying mounts (rare - burning crusade)
		{spellID=40192, itemID=32458, level=70, skill=300, isFlying=true, speed=310, from="Tempest Keep"}, -- Ashes of Al'ar (Tempest Keep)

		-- flying mounts (rare - lich king)
		{spellID=59569, itemID=43951, level=70, skill=300, isFlying=true, speed=280, from="Stratholme"}, -- Bronze Drake (Stratholme - heroic)
		{spellID=59650, itemID=43986, level=70, skill=300, isFlying=true, speed=280, from="Sartharion 10 OS3D"}, -- Black Drake (10-man Sartharion)
		{spellID=59571, itemID=43954, level=70, skill=300, isFlying=true, speed=280, from="Sartharion 25 OS3D"}, -- Twilight Drake (25-man Sartharion)
		{spellID=59568, itemID=43953, level=70, skill=300, isFlying=true, speed=280, from="Oculus (Heroic) via Random Dungeon Finder"}, -- Blue Drake (Heroic Oculus)
		{spellID=59567, itemID=43952, level=70, skill=300, isFlying=true, speed=280, from="Malygos 10/25"}, -- Azure Drake (10/25-man Malygos)
		{spellID=59996, itemID=44151, level=80, skill=300, isFlying=true, speed=280, from="Utgarde Pinnacle (Heroic)"}, -- Blue Proto-Drake (Utgarde Pinnacle - heroic)
		{spellID=61294, itemID=44707, level=80, skill=300, isFlying=true, speed=280, from="Oracles - Mysterious Egg (Revered)"}, -- Green Proto-Drake (Mysterious Egg)
		{spellID=60002, itemID=44168, level=80, skill=300, isFlying=true, speed=280, from="Rare Spawn - Stormpeaks"}, -- Time-Lost Proto-Drake (sturmgipfel)
		{spellID=69395, itemID=49636, level=70, skill=300, isFlying=true, speed=310, from="Onyxia 10/25"}, -- Onyxian Drake
		{spellID=63796, itemID=45693, level=70, skill=300, isFlying=true, speed=310, from="Ulduar - Yogg-Saron 25 (0 Keepers)"}, -- Mimiron's Head
		{spellID=68056, itemID=49046, level=40, skill=150, faction=FACTION_HORDE, speed=100, from="Heroic TOC 10 (Tribute to Insanity)"}, -- Swift Horde Wolf
		{spellID=68057, itemID=49044, level=40, skill=150, faction=FACTION_ALLIANCE, speed=100, from="Heroic TOC 10 (Tribute to Insanity)"}, -- Swift Alliance Steed

		-- flying mounts (trading cards - burning crusade)
		{spellID=46197, itemID=35225, level=70, skill=225, isFlying=true, speed=60, tcg=true, from="WoW Trading Card Game"}, -- X-51 Nether-Rocket
		{spellID=46199, itemID=35226, level=70, skill=300, isFlying=true, speed=280, tcg=true, from="WoW Trading Card Game"}, -- X-51 Nether-Rocket X-TREME

		-- flying mounts (buyable - lich king)
		{spellID=61229, itemID=44689, level=70, skill=300, faction=FACTION_ALLIANCE, isFlying=true, speed=100, from="Gold - Dalaran"}, -- Armored Snowy Gryphon
		{spellID=61230, itemID=44690, level=70, skill=300, faction=FACTION_HORDE, isFlying=true, speed=100, from="Gold - Dalaran"}, -- Armored Blue Wind Rider

		-- flying mounts (archievements - lich king)
		{spellID=59976, itemID=nil, level=70, skill=300, isFlying=true, speed=280, from="Achievement: Heroic: Glory of the Raider", obtainable=false}, -- Black Proto-Drake (Heroic: Glory of the Raider)
		{spellID=60021, itemID=44175, level=70, skill=300, isFlying=true, speed=310, from="Achievement: Glory of the Raider", obtainable=false}, -- Plagued Proto-Drake (Glory of the Raider)
		{spellID=59961, itemID=44160, level=70, skill=300, isFlying=true, speed=280, from="Achievement: Glory of the Hero"}, -- Red Proto-Drake (Glory of the Hero)
		{spellID=63963, itemID=45802, level=70, skill=300, isFlying=true, speed=310, from="Achievement: Glory of the Ulduar Raider (10)"}, -- Rusted Proto-Drake
		{spellID=63956, itemID=45801, level=70, skill=300, isFlying=true, speed=310, from="Achievement: Glory of the Ulduar Raider (25)"}, -- Ironbound Proto-Drake
		{spellID=72808, itemID=51954, level=70, skill=300, isFlying=true, speed=310, from="Achievement: Glory of the Icecrown Raider (10)"}, -- Bloodbathed Frostbrood Vanquisher
		{spellID=72807, itemID=51955, level=70, skill=300, isFlying=true, speed=310, from="Achievement: Glory of the Icecrown Raider (25)"}, -- Icebound Frostbrood Vanquisher
		{spellID=60024, itemID=nil, level=70, skill=300, isFlying=true, speed=310, from="Achievement: What A Long, Strange Trip It's Been"}, -- Violet Proto-Drake (What A Long, Strange Trip It's Been)
		{spellID=60025, itemID=44178, level=70, skill=300, isFlying=true, speed=280, from="Achievement: Leading the Cavalry"}, -- Albino Drake (Leading the Cavalry)
		{spellID=61996, itemID=44843, level=70, skill=300, faction=FACTION_ALLIANCE, isFlying=true, speed=280, from="Achievement: Mountain o' Mounts"}, -- Blue Dragonhawk
		{spellID=61997, itemID=44842, level=70, skill=300, faction=FACTION_HORDE, isFlying=true, speed=280, from="Achievement: Mountain o' Mounts"}, -- Red Dragonhawk

		-- scaling mounts (events - burning crusade)
--		{spellID=nil, itemID=37011, level=20, skill=75, isScaling=true, isGround=true, isFlying=true, from="Holiday Event: Hallow's End"}, -- Magic Broom
		{spellID=48025, itemID=37012, level=60, skill=75, isScaling=true, isGround=true, isFlying=true, from="Holiday Event: Hallow's End"}, -- Headless Horseman's Mount

		-- Argent Tournaments
		{spellID=63844, itemID=45725, level=70, skill=300, faction=FACTION_ALLIANCE, isFlying=true, speed=280, from="Argent Tournaments"}, -- Argent Hippogryph
		{spellID=67466, itemID=47180, level=40, skill=150, isGround=true, speed=100, from="Argent Tournaments"}, -- Argent Warhorse

		{spellID=65637, itemID=46745, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, isFlying=false, from="Argent Tournaments - Exodar"}, -- Great Red Elekk
		{spellID=65640, itemID=46752, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, isFlying=false, from="Argent Tournaments - Stormwind"}, -- Swift Gray Steed
		{spellID=65643, itemID=46748, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, isFlying=false, from="Argent Tournaments - Ironforge"}, -- Swift Violet Ram
		{spellID=65638, itemID=46744, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, isFlying=false, from="Argent Tournaments - Darnassus"}, -- Swift Moonsaber
		{spellID=65642, itemID=46747, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Argent Tournaments - Gnomeregan"}, -- Turbostrider
		{spellID=66087, itemID=46813, level=70, skill=300, faction=FACTION_ALLIANCE, isFlying=true, speed=280, from="Argent Tournaments - Silver Covenant (Exalted)"}, -- Silver Covenant Hippogryph
		{spellID=66090, itemID=46815, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Argent Tournaments - Silver Covenant (Exalted)"}, -- Quel'dorei Steed
		{spellID=63639, itemID=45590, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Argent Tournaments - Exodar"}, -- Exodar Elekk
		{spellID=63637, itemID=45591, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Argent Tournaments - Darnassus"}, -- Darnassian Nightsaber
		{spellID=63232, itemID=45125, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Argent Tournaments - Stormwind"}, -- Stormwind Steed
		{spellID=63636, itemID=45586, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Argent Tournaments - Ironforge"}, -- Ironforge Ram
		{spellID=63638, itemID=45589, level=40, skill=150, faction=FACTION_ALLIANCE, isGround=true, speed=100, from="Argent Tournaments - Gnomeregan"}, -- Gnomeregan Mechanostrider

		{spellID=66088, itemID=46814, level=70, skill=300, faction=FACTION_HORDE, isFlying=true, speed=280, from="Argent Tournaments - Sunreavers"}, -- Sunreaver Dragonhawk
		{spellID=65644, itemID=46743, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Sen'jin"}, -- Swift Purple Raptor
		{spellID=65645, itemID=46746, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Undercity"}, -- White Skeletal Warhorse
		{spellID=65646, itemID=46749, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Orgrimmar"}, -- Swift Burgundy Wolf
		{spellID=65639, itemID=46751, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Silvermoon"}, -- Swift Red Hawkstrider
		{spellID=66091, itemID=46816, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Sunreavers"}, -- Sunreaver Hawkstrider
		{spellID=65641, itemID=46750, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Thunder Bluff"}, -- Great Golden Kodo

		{spellID=63635, itemID=45593, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Darkspear"}, -- Darkspear Raptor
		{spellID=63640, itemID=45595, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Orgrimmar"}, -- Orgrimmar Wolf
		{spellID=63642, itemID=45596, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Silvermoon"}, -- Silvermoon Hawkstrider
		{spellID=63643, itemID=45597, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Undercity"}, -- Forsaken Warhorse
		{spellID=63641, itemID=45592, level=40, skill=150, faction=FACTION_HORDE, isGround=true, speed=100, from="Argent Tournaments - Thunder Bluff"}, -- Thunder Bluff Kodo



		-- Fishing
		{spellID=64731, itemID=46109, level=60, skill=75, isGround=true, speed=20, from="Fishing - Northern Pools"}, -- Sea Turtle

		-- WOW Store
		{spellID=75614, itemID=54811, level=20, skill=75, isScaling=true, isGround=true, isFlying=true, speed=280, from="Wow Online Store ($25)"}, -- Celestial Steed
		{spellID=98727, itemID=69846, level=20, skill=75, isScaling=true, isGround=true, isFlying=true, speed=280, from="Wow Online Store ($25)"}, -- Winged Guardian

		-- Cataclysm
		{spellID=88742, itemID=63040, level=70, skill=300, isFlying=true, speed=280, from="The Vortex Pinnacle"}, -- Reins of the Drake of the North Wind (The Vortex Pinnacle)
		{spellID=88746, itemID=63043, level=70, skill=300, isFlying=true, speed=280, from="The Stonecore"}, -- Reins of the Vitreous Stone Drake (The Stonecore)
		{spellID=84751, itemID=60954, level=40, skill=150, isGround=true, speed=100, from="Archaeology - Fossil"}, -- Fossilized Raptor
		{spellID=92155, itemID=64883, level=40, skill=150, isGround=true, speed=100, from="Archaeology - Tol'vir"}, -- Ultramarine Qiraji Battle Tank
		{spellID=88748, itemID=63044, level=40, skill=150, isGround=true, speed=100, from="Ramkahen (Exalted)"}, -- Brown Riding Camel
		{spellID=88749, itemID=63045, level=40, skill=150, isGround=true, speed=100, from="Ramkahen (Exalted)"}, -- Tan Riding Camel
		{spellID=93644, itemID=67107, level=20, skill=75, faction=FACTION_HORDE, isGround=true, speed=100, from="Guild Level 25"}, -- Kor'kron Annihilator
		{spellID=87091, race=nil, itemID=62462, level=40, skill=75, faction=FACTION_HORDE, isGround=true, speed=100, from="Bilgewater Cartel (Exalted)"}, -- Goblin Turbo-Trike
		{spellID=87090, race=nil, itemID=62461, level=40, skill=75, faction=FACTION_HORDE, isGround=true, speed=100, from="Bilgewater Cartel (Exalted)"}, -- Goblin Trike
		{spellID=75207, itemID=54465, level=40, skill=150, isGround=true, speed=450, from="Quest - The Abyssal Ride"}, -- Abyssal Seahorse
		{spellID=88718, itemID=63042, level=70, skill=300, isFlying=true, speed=280, from="Rare Spawn - Aenoaxx - Deepholm"}, -- Phosphorescent Stone Drake
		{spellID=88741, itemID=65356, level=70, skill=300, isFlying=true, faction=FACTION_HORDE, speed=280, from="Hellscream's Reach (Exalted) - 200 Tol Barad Commendations"}, -- Drake of the West Wind
		{spellID=92232, itemID=64999, level=70, skill=300, isGround=true, faction=FACTION_HORDE, speed=100, from="Hellscream's Reach (Exalted) - 165 Tol Barad Commendations"}, -- Spectral Wolf
		{spellID=92231, itemID=64998, level=70, skill=300, isGround=true, faction=FACTION_ALLIANCE, speed=100, from="Baradin's Wardens (Exalted) - 165 Tol Barad Commendations"}, -- Spectral Steed
		{spellID=88741, itemID=63039, level=70, skill=300, isFlying=true, faction=FACTION_ALLIANCE, speed=280, from="Baradin's Wardens (Exalted) - 200 Tol Barad Commendations"}, -- Drake of the West Wind
		{spellID=88331, itemID=62900, level=70, skill=300, isFlying=true, speed=280, from="Achievement: Glory of the Cataclysm Hero"}, -- Volcanic Stone Drake (Glory of the Cataclysm Hero)
		{spellID=88750, itemID=63046, level=40, skill=150, isGround=true, speed=100, from="Rare Spawn - Mysterious Camel Figurine"}, -- Grey Riding Camel
		{spellID=88990, itemID=63125, level=70, skill=300, isFlying=true, speed=280, from="Achievement: Guild Glory of the Cataclysm Raider"}, -- Dark Phoenix (Guild Glory of the Cataclysm Raider)
		{spellID=93326, itemID=65891, level=85, skill=225, isFlying=true, speed=280, tradeskill="Alchemy", from="Alchemy (525) - Rare recipe"}, -- Sandstone Drake (Alchemy 525)
		{spellID=88335, itemID=62901, level=70, skill=300, isFlying=true, speed=280, from="Achievement: Glory of the Cataclysm Raider"}, -- Drake of the East Wind (Glory of the Cataclysm Raider)
		{spellID=71342, itemID=63040, level=20, skill=75, isFlying=true, speed=280, from="Heart Shaped Box - Love is in the Air"}, -- Big Love Rocket (Love is in the Air)

		{spellID=88335, itemID=62901, level=70, skill=300, isFlying=true, speed=280, from="Achievement: Glory of the Cataclysm Raider"}, -- Drake of the East Wind (Glory of the Cataclysm Raider)
		{spellID=90621, itemID=62298, level=20, skill=75,  isGround=true, speed=100, faction=FACTION_ALLIANCE, from="Alliance Guild Reputation"}, -- Golden King
		{spellID=93644, itemID=67107, level=20, skill=75,  isGround=true, speed=100, faction=FACTION_HORDE, from="Horde Guild Reputation"}, -- Kor'kron Annihilator

		{spellID=97359, itemID=69213, level=70, skill=300, isFlying=true, speed=280, from="Quests - The Molten Front Offensive"}, -- Flameward Hippogryph

		-- Patch 4.3
		{spellID=107842, itemID=69213, level=85, skill=300, isFlying=true, speed=280, from="Madness of Deathwing - Normal Mode"}, -- Blazing Drake
		{spellID=107845, itemID=77069, level=85, skill=300, isFlying=true, speed=280, from="Madness of Deathwing - Heroic Mode"}, -- Life-Binder's Handmaiden
		{spellID=103081, itemID=103081, level=20, skill=75, isGround=true, speed=100, from="Darkmoon Faire - Darkmoon Prize Ticket x 180"}, -- Darkmoon Dancing Bear
		{spellID=102346, itemID=72140, level=20, skill=75, isGround=true, speed=100, from="Darkmoon Faire - Darkmoon Prize Ticket x 180"}, -- Swift Forest Strider
		{spellID=101821, itemID=71954, level=70, skill=300, isFlying=true, speed=280, from="Season 10 Gladiator Mount Reward"}, -- Ruthless Gladiator's Twilight Drake
		{spellID=103195, itemID=73838, level=20, skill=75, isGround=true, speed=60, faction=FACTION_ALLIANCE, from="Worgen or Exalted Gilneas Reputation"}, -- Mountain Horse
		{spellID=103196, itemID=73839, level=40, skill=150, isGround=true, speed=100, faction=FACTION_ALLIANCE, from="Worgen or Exalted Gilneas Reputation"}, -- Swift Mountain Horse
		{spellID=107203, itemID=76755, level=20, skill=75, isFlying=true, isGround=true, speed=280, from="WoW/Diablo 3 Annual Pass"}, -- Tyrael's Charger
		{spellID=101573, itemID=71718, level=20, skill=75, isGround=true, speed=100, tcg=true, from="WoW TCG - Throne of the Tides"}, -- Swift Shorestrider
		{spellID=102514, itemID=72582, level=20, skill=75, isFlying=true, speed=280, tcg=true, from="WoW TCG - Crown of Heaven"}, -- Corrupted Hippogryph
		{spellID=102488, itemID=72575, level=20, skill=75, isGround=true, speed=100, tcg=true, from="WoW TCG - Tomb of the Forgotten"}, -- White Riding Camel
		{spellID=110039, itemID=78919, level=85, skill=300, isFlying=true, speed=280, from="Deathwing 10/25 (non-LFR)"}, -- Experiment 12-B
		{spellID=110051, itemID=78924, level=85, skill=300, isFlying=true, speed=280, from="Wow Online Store ($25)"}, -- Heart of the Aspects
		{spellID=107516, itemID=76889, level=70, skill=300, isFlying=true, speed=280, faction=FACTION_ALLIANCE, from="Scroll of Resurrection Reward"}, -- Spectral Gryphon
		{spellID=107517, itemID=76902, level=70, skill=300, isFlying=true, speed=280, faction=FACTION_HORDE, from="Scroll of Resurrection Reward"}, -- Spectral Wind Rider
		{spellID=102350, itemID=72146, level=20, skill=75, isGround=true, speed=100, from="Love is in the Air - Love Token x 270"}, -- Swift Lovebird
		{spellID=102349, itemID=72145, level=20, skill=75, isGround=true, speed=100, from="Holiday Event: Noblegarden (Brightly Colored Egg)"}, -- Swift Springstrider
		{spellID=107844, itemID=77068, level=85, skill=300, isFlying=true, speed=280, from="Glory of the Dragon Soul Raider"}, -- Reins of the Twilight Harbinger

		-- Patch 4.3.2
		{spellID=113120, itemID=79771, level=20, skill=75, isFlying=true, speed=280, tcg=true, from="WoW TCG - War of the Ancients"}, -- Feldrake

		-- Patch 4.3.4
		{spellID=121820, itemID=83086, level=20, skill=75, isFlying=true, speed=280, from="Recruit-a-Friend"}, -- Obsidian Nightwing

		-- Patch 5.0.4
		{spellID=127180, itemID=87785, level=90, skill=150, isGround=true, speed=100, from="Reins of the Albino Riding Crane (???)"}, -- Albino Riding Crane
		{spellID=123886, itemID=85262, level=70, skill=150, isGround=true, speed=100, from="Klaxxi (Exalted)"}, -- Amber Scorpion
		{spellID=132117, itemID=90710, level=90, skill=300, isFlying=true, speed=280, from="Achievement - Challenge Conqueror: Silver"}, -- Ashen Pandaren Phoenix
		{spellID=127170, itemID=87777, level=90, skill=300, isFlying=true, speed=280, from="Mogu'shan Vaults 10/25  (non-LFR)"}, -- Astral Cloud Serpent
		{spellID=123992, itemID=85430, level=90, skill=300, isFlying=true, speed=280, from="Order of the Cloud Serpent (Exalted)"}, -- Azure Cloud Serpent
		{spellID=127174, itemID=87781, level=90, skill=150, isGround=true, speed=100, from="Golden Lotus (Exalted)"}, -- Azure Riding Crane
		{spellID=118089, itemID=81354, level=90, skill=150, isGround=true, speed=100, from="Nat Pagle (Exalted)"}, -- Azure Water Strider
		{spellID=127286, itemID=87795, level=20, skill=75, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Black Dragon Turtle
		{spellID=130138, itemID=89391, level=85, skill=150, isGround=true, speed=100, from="The Tillers (Exalted)"}, -- Black Riding Goat

		{spellID=127220, itemID=87789, level=85, skill=150, isGround=true, speed=100, from="Kun-Lai Summit - 3.000 Gold"}, -- Blonde Riding Yak
		{spellID=127287, itemID=87796, level=20, skill=75, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Blue Dragon Turtle
		{spellID=129934, itemID=89307, level=90, skill=150, isGround=true, speed=100, from="Shado-Pan (Exalted)"}, -- Blue Shado-Pan Riding Tiger
		{spellID=127288, itemID=87797, level=20, skill=75, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Brown Dragon Turtle
		{spellID=130086, itemID=89362, level=85, skill=150, isGround=true, speed=100, from="The Tillers (Exalted)"}, -- Brown Riding Goat

		{spellID=124550, itemID=85785, level=90, skill=300, isFlying=true, speed=280, from="Season 11 Gladiator Mount Reward"}, -- Cataclysmic Gladiators Twilight Drake
		{spellID=127156, itemID=87769, level=90, skill=300, isFlying=true, speed=280, from="Glory of the Pandaria Hero"}, -- Crimson Cloud Serpent
		{spellID=129552, itemID=89154, level=90, skill=300, isFlying=true, speed=280, from="Achievement - Challenge Conqueror: Silver"}, -- Crimson Pandaren Phoenix
		{spellID=123160, itemID=84728, level=90, skill=150, isGround=true, speed=100, from="Reins of the Crimson Riding Crane (???)"}, -- Crimson Riding Crane

		{spellID=126507, itemID=87250, level=20, skill=75, isFlying=true, speed=280, from="Engineering (600)"}, -- Depleted-Kyparium Rocket
		{spellID=132118, itemID=90711, level=90, skill=300, isFlying=true, speed=280, from="Achievement - Challenge Conqueror: Silver"}, -- Emerald Pandaren Phoenix
		{spellID=126508, itemID=87251, level=20, skill=75, isFlying=true, speed=280, from="Engineering (600)"}, -- Geosynchronous World Spinner
		{spellID=123993, itemID=85429, level=90, skill=300, isFlying=true, speed=280, from="Order of the Cloud Serpent (Exalted)"}, -- Golden Cloud Serpent
		{spellID=127176, itemID=87782, level=90, skill=150, isGround=true, speed=100, from="Golden Lotus (Exalted)"}, -- Golden Riding Crane
		{spellID=127278, itemID=87794, level=90, skill=300, isFlying=true, speed=280, from="The Anglers (Exalted) - currently unavailable"}, -- Golden Water Strider
		{spellID=122708, itemID=84101, level=85, skill=150, isGround=true, speed=100, from="Kun-Lai Summit - 120.000 Gold"}, -- Grand Expedition Yak
		{spellID=127295, itemID=87802, level=20, skill=150, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Great Black Dragon Turtle
		{spellID=127302, itemID=87803, level=20, skill=150, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Great Blue Dragon Turtle
		{spellID=127308, itemID=87804, level=20, skill=150, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Great Brown Dragon Turtle
		{spellID=127293, itemID=87801, level=20, skill=150, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Great Green Dragon Turtle
		{spellID=127310, itemID=87805, level=20, skill=150, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Great Purple Dragon Turtle
		{spellID=120822, itemID=82811, level=20, skill=150, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Great Red Dragon Turtle
		{spellID=120395, itemID=82765, level=20, skill=75, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Green Dragon Turtle
		{spellID=129932, itemID=89305, level=90, skill=150, isGround=true, speed=100, from="Shado-Pan (Exalted)"}, -- Green Shado-Pan Riding Tiger
		{spellID=127216, itemID=87788, level=85, skill=150, isGround=true, speed=100, from="Kun-Lai Summit - 3.000 Gold"}, -- Grey Riding Yak

		{spellID=127161, itemID=87773, level=90, skill=300, isFlying=true, speed=280, from="Achievement - Glory of the Pandaria Raider"}, -- Heavenly Crimson Cloud Serpent
		{spellID=127158, itemID=87771, level=90, skill=300, isFlying=true, speed=280, from="Sha of Anger (Rare Drop)"}, -- Heavenly Onyx Cloud Serpent
		{spellID=124659, itemID=85870, level=20, skill=75, isFlying=true, speed=280, from="Mists of Pandaria Collectors Edition"}, -- Imperial Quilen
		{spellID=113199, itemID=79802, level=90, skill=300, isFlying=true, speed=280, from="Order of the Cloud Serpent (Exalted)"}, -- Jade Cloud Serpent
		{spellID=121837, itemID=83088, level=40, skill=150, isFlying=true, speed=280, from="Jewelcrafting (600)"}, -- Jade Panther

		{spellID=120043, itemID=82453, level=40, skill=150, isFlying=true, speed=280, from="Jewelcrafting (600)"}, -- Jeweled Onyx Panther

		{spellID=127154, itemID=87768, level=90, skill=300, isFlying=true, speed=280, from="Quest: Surprise Attack (Exalted with Shado-Pan)"}, -- Onyx Cloud Serpent

		{spellID=130985, itemID=89785, level=70, skill=300, isFlying=true, speed=280, faction=FACTION_ALLIANCE, from="Achievement - Pandaren Ambassador"}, -- Pandaren Kite
		{spellID=118737, itemID=81559, level=70, skill=300, isFlying=true, speed=280, faction=FACTION_HORDE, from="Achievement - Pandaren Ambassador"}, -- Pandaren Kite
		{spellID=127289, itemID=87799, level=20, skill=75, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Purple Dragon Turtle
		{spellID=127290, itemID=87800, level=20, skill=75, isGround=true, speed=100, from="Tushui Pandaren (Exalted or Pandaren Racial)"}, -- Red Dragon Turtle
		{spellID=130092, itemID=89363, level=90, skill=300, isFlying=true, speed=280, from="The Lorewalkers (Exalted)"}, -- Red Flying Cloud
		{spellID=129935, itemID=89306, level=90, skill=150, isGround=true, speed=100, from="Shado-Pan (Exalted)"}, -- Red Shado-Pan Riding Tiger
		{spellID=127177, itemID=87783, level=90, skill=150, isGround=true, speed=100, from="Golden Lotus (Exalted)"}, -- Regal Riding Crane
		{spellID=121838, itemID=83087, level=40, skill=150, isFlying=true, speed=280, from="Jewelcrafting (600)"}, -- Ruby Panther
		{spellID=121836, itemID=83090, level=40, skill=150, isFlying=true, speed=280, from="Jewelcrafting (600)"}, -- Sapphire Panther
		{spellID=130965, itemID=89783, level=85, skill=150, isGround=true, speed=100, from="Drop - Galleon"}, -- Son of Galleon
		{spellID=121839, itemID=83089, level=40, skill=150, isFlying=true, speed=280, from="Jewelcrafting (600)"}, -- Sunstone Panther
		{spellID=129918, itemID=89304, level=90, skill=300, isFlying=true, speed=280, from="The August Celestials (Exalted)"}, -- Thundering August Cloud Serpent
		{spellID=124408, itemID=85666, level=85, skill=300, isFlying=true, speed=280, from="Achievement - Guild Glory of the Pandaria Raider"}, -- Thundering Jade Cloud Serpent
		{spellID=132036, itemID=90655, level=90, skill=300, isFlying=true, speed=280, from="Drop - Alani (The August Celestials Exalted)"}, -- Thundering Ruby Cloud Serpent
		{spellID=132119, itemID=90712, level=90, skill=300, isFlying=true, speed=280, from="Achievement - Challenge Conqueror: Silver"}, -- Violet Pandaren Phoenix
		{spellID=130137, itemID=89390, level=85, skill=150, isGround=true, speed=100, from="The Tillers (Exalted)"}, -- White Riding Goat

		-- Patch 5.1.0
		{spellID=135416, itemID=93168, level=80, skill=300, isFlying=true, speed=280, faction=FACTION_ALLIANCE, from="Operation: Shildwall (Exalted)"}, -- Grand Armored Gryphon
		{spellID=135418, itemID=93169, level=80, skill=300, isFlying=true, speed=280, faction=FACTION_HORDE, from="Dominance Offensive (Exalted)"}, -- Grand Armored Wyvern
		{spellID=136163, itemID=93385, level=80, skill=300, isFlying=true, speed=280, faction=FACTION_ALLIANCE, from="Quest: The Silence (Pandaren Campaign)"}, -- Grand Gryphon
		{spellID=136164, itemID=93386, level=80, skill=300, isFlying=true, speed=280, faction=FACTION_HORDE, from="Quest: Breath of Darkest Shadow (Pandaren Campaign)"}, -- Grand Wyvern
		{spellID=133023, itemID=91802, level=70, skill=300, isFlying=true, speed=280, from="Achievement - We're Going to Need More Saddles"}, -- Jade Pandaren Kite
		{spellID=134573, itemID=92724, level=20, skill=75, isFlying=true, speed=280, from="Wow Online Store ($25)"}, -- Swift Windsteed

		-- Missing
		{spellID=61465, itemID=43959, level=40, skill=150, isGround=true, speed=100, faction=FACTION_ALLIANCE, from="Vault of Archavon"}, -- Grand Black War Mammoth
		{spellID=61467, itemID=44083, level=40, skill=150, isGround=true, speed=100, faction=FACTION_HORDE, from="Vault of Archavon"}, -- Grand Black War Mammoth
		{spellID=98204, itemID=69747, level=85, skill=150, isGround=true, speed=100, from="Zul'Aman (Cataclysm) Timerun"}, -- Amani Battle Bear
		{spellID=96499, itemID=68824, level=40, skill=150, isGround=true, speed=100, from="Drop - High Priestess Kilnara (Zul'Gurub)"}, -- Swift Zulian Panther
		{spellID=96491, itemID=68823, level=40, skill=150, isGround=true, speed=100, from="Drop - Broodlord Mandokir (Zul'Gurub)"}, -- Swift Razzashi Raptor
	}


-----------------------------------------------------------------------------------------------------------------------
--[ local functions ]

function MountainO:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end


local function Print(...)
	local text = ""
	text = "|cff33ff99".."Mnto".."|r: "

	for i=1, select("#", ...) do
		text = text .. tostring(select( i, ...)) .." "
	end
	DEFAULT_CHAT_FRAME:AddMessage(text)
end


local function tsize(t)
	if not t then return end
	local size
	for k,v in pairs(t) do
		size = (size or 0) + 1
	end
	return size
end


function MountainO:unregisterEvents()
	this:UnregisterEvent("VARIABLES_LOADED")
end

function MountainOHandleEvent(self, event, ...)
	if (event == "VARIABLES_LOADED") then
		MountainO:registerChatCommand({"/mnto"})
	end
end

function MountainO:registerChatCommand(command)
	for i, c in ipairs(command) do
		_G["SLASH_MountainO"..i] = c
	end

	SlashCmdList["MountainO"] = function(msg)
		MountainO:slashCommandHandler(msg)
	end
end

function MountainO:slashCommandHandler(msg)
	if(msg) then
		msg = strlower(msg)
	else
		msg = ""
	end

	local _, _, command, args = string.find(msg, "(%w+)%s?(.*)")
	if (not command) then
		 MountainO:PrintMissing()
	elseif (command == "help" or command == "Version") then
		Print("MountainOMounts v"..version.." by Cigamit - Proudmoore")
		Print("  /mnto          To display missing mounts")
		Print("  /mnto tcg    To disable showing tcg / cash mounts")
	elseif (command == "tcg") then
		if (MountainOOptions.tcg == true) then
			MountainOOptions.tcg = false
			Print("Disabling display of Trading Card Game / Cash Mounts")
		else
			MountainOOptions.tcg = true
			Print("Enabling display of Trading Card Game / Cash Mounts")
		end
	end
end


function MountainO:CheckTradeSkill(skill)
	return 1
	--for skillIndex = 1, GetNumSkillLines() do
	--	local skillName = GetSkillLineInfo(skillIndex)
	--	if (skillName == skill) then
	--		return 1
	--	end
	--end
	--return 0
end


function MountainO:PrintMissing()
	countAll = tsize(mountData)
	local mymounts = self:GetPlayerMounts()
	local missing = {}

	local _, playerClass = UnitClass("player")
	local _, playerRace = UnitRace("player")

	local isHorde = (playerRace == "Orc" or playerRace == "Troll" or playerRace == "Tauren" or playerRace == "Scourge" or playerRace == "BloodElf")
	local isAlliance = not isHorde

	Print("Total Mounts in DB: " .. countAll)
	Print("My Mounts: " .. tsize(mymounts))
	if (countAll) then
		for _,mount in pairs(mountData) do
			if (not mount.faction) or ((isHorde == (mount.faction ~= FACTION_ALLIANCE)) and (isAlliance == (mount.faction ~= FACTION_HORDE))) then
				-- only process classless or class==playerclass
				if (not mount.class or (mount.class == playerClass))  then
					if (mount.tradeskill == nil or self:CheckTradeSkill(mount.tradeskill) == 1) then
						if (mount.obtainable == nil or mount.obtainable ~= false) then
							if (mount.tcg == nil or MountainOOptions.tcg == true) then
								local found = false
								if tsize(mymounts) then
									for spell, slot in pairs(mymounts) do
										if (mount.spellID == spell) then
											found = true
										end
									end
								end
								if (not found) then
									table.insert(missing, mount)
								end
							end
						end
					end
				end
			end
		end
	else
		Print("Unable to load mount data")
	end
	cmissing = tsize(missing)
	Print("Missing " .. cmissing .. " mounts")
	if (cmissing) then
		for _, mount in pairs (missing) do
			--Print("Missing ".. '|cff71d5ff|Hspell:'..mount.spellID..'|h['..GetSpellInfo(mount.spellID)..']|h|r'..' - '..mount.from)
		end
	end

	local ScrollingTable = LibStub("ScrollingTable");
	local cols = {
		{
			["name"] = "Mount",
		 	["width"] = 200,
			["sort"] = "dsc",
		}, -- [1]
		{
			["name"] = "From",
			["width"] = 300,
		}, -- [2]
		{
			["name"] = "Type",
			["width"] = 50,
		}, -- [3]
	};


	local st = ScrollingTable:CreateST(cols, 20);

	st:RegisterEvents({
		["OnClick"] = function (rowFrame, cellFrame, data, cols, row, realrow, column, scrollingTable, button, ...)
			if (button == "RightButton") then
				st:Hide()
			end
		end,
	});

	local data = {}
	for row = 1, cmissing do
		if not data[row] then
			data[row] = {};
		end
		data[row].cols = {};
		local flying = ""
		if (missing[row].isFlying == true) then
			flying = "Flying"
		else
			flying = "Ground"
		end
		local name = GetSpellInfo(missing[row].spellID);
		if (name == null) then
			name = "(Unavailable)";
		end
		data[row].cols[1] = { ["value"] = name };
		data[row].cols[2] = { ["value"] = missing[row].from };
		data[row].cols[3] = { ["value"] = flying };
	end

--	data[5].cols[1].color = { ["r"] = 0.5, ["g"] = 1.0, ["b"] = 0.5, ["a"] = 1.0 };
--	data[5].color = { ["r"] = 1.0, ["g"] = 0.5, ["b"] = 0.5, ["a"] = 1.0 };

	st:SetData(data);
	st:SortData();
end

function MountainO:GetPlayerMounts()
	local foundMounts = {}
	-- get all player mounts
	for slot=1, GetNumCompanions("MOUNT") do
		local _,_,spellID = GetCompanionInfo("MOUNT", slot)
		if spellID then
			foundMounts[spellID] = slot
		end
	end
	-- filter and report unknown mounts
	if tsize(foundMounts) then
		-- filter unknown
		for spellID,_ in pairs(foundMounts) do
			local found = false
			for _,mount in pairs(mountData) do
				if mount.spellID == spellID then
					found = true
				end
			end
			if (not found) then
				foundMounts[spellID] = nil
				Print('Unknown Mount('..spellID..'): |cff71d5ff|Hspell:'..spellID..'|h['..GetSpellInfo(spellID)..']|h|r')
			end
		end
	end
	-- return all found (and known) mount spells
	return foundMounts
end


local frame = CreateFrame("Frame");
frame:RegisterEvent("VARIABLES_LOADED")
frame:SetScript("OnEvent", MountainOHandleEvent)
































