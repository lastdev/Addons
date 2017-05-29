local addonName, vars = ...
local L = vars.L
local addon = RaidBuffStatus
local report = addon.report
local raid = addon.raid
RBS_svnrev["Buffs.lua"] = select(3,string.find("$Revision: 725 $", ".* (.*) .*"))

local profile
function addon:UpdateProfileBuffs()
	profile = addon.db.profile
end

local BSmeta = {}
local BS = setmetatable({}, BSmeta)
local BSI = setmetatable({}, BSmeta)
BSmeta.__index = function(self, key)
	local name, _, icon
	if type(key) == "number" then
		name, _, icon = GetSpellInfo(key)
	else
		geterrorhandler()(("Unknown spell key %q"):format(key))
	end
	if name then
		BS[key] = name
		BS[name] = name
		BSI[key] = icon
		BSI[name] = icon
	else
		BS[key] = false
		BSI[key] = false
		geterrorhandler()(("Unknown spell info key %q"):format(key))
	end
	return self[key]
end

local function SpellName(spellID)
	local name = GetSpellInfo(spellID)
	return name
end

local ITmeta = {}
local ITN = setmetatable({}, ITmeta)
local ITT = setmetatable({}, ITmeta)
ITN.unknown = L["Please relog or reload UI to update the item cache."]
ITT.unknown = "Interface\\Icons\\INV_Misc_QuestionMark"
ITmeta.__index = function(self, key)
	local name, _, icon
	if type(key) == "number" then
		name, _, _, _, _, _, _, _, _, icon = GetItemInfo(key)
		if not name then
			GameTooltip:SetHyperlink("item:"..key..":0:0:0:0:0:0:0")  -- force server to send item info
			GameTooltip:ClearLines();
			name, _, _, _, _, _, _, _, _, icon = GetItemInfo(key)  -- info might not be in the cache yet but worth trying again
		end
	else
		geterrorhandler()(("Unknown item key %q"):format(key))
	end
	if name then
		ITN[key] = name
		ITN[name] = name
		ITT[key] = icon
		ITT[name] = icon
		return self[key]
	end
	return self.unknown
end

local tbcflasks = {
	SpellName(17626), -- Flask of the Titans
	SpellName(17627), -- [Flask of] Distilled Wisdom
	SpellName(17628), -- [Flask of] Supreme Power
	SpellName(17629), -- [Flask of] Chromatic Resistance
	SpellName(28518), -- Flask of Fortification
	SpellName(28519), -- Flask of Mighty Restoration
	SpellName(28520), -- Flask of Relentless Assault
	SpellName(28521), -- Flask of Blinding Light
	SpellName(28540), -- Flask of Pure Death
	SpellName(33053), -- Mr. Pinchy's Blessing
	SpellName(42735), -- [Flask of] Chromatic Wonder
	SpellName(40567), -- Unstable Flask of the Bandit
	SpellName(40568), -- Unstable Flask of the Elder
	SpellName(40572), -- Unstable Flask of the Beast
	SpellName(40573), -- Unstable Flask of the Physician
	SpellName(40575), -- Unstable Flask of the Soldier
	SpellName(40576), -- Unstable Flask of the Sorcerer
	SpellName(41608), -- Relentless Assault of Shattrath
	SpellName(41609), -- Fortification of Shattrath
	SpellName(41610), -- Mighty Restoration of Shattrath
	SpellName(41611), -- Supreme Power of Shattrath
	SpellName(46837), -- Pure Death of Shattrath
	SpellName(46839), -- Blinding Light of Shattrath
	SpellName(67019), -- Flask of the North (WotLK 3.2)
	SpellName(62380), -- Lesser Flask of Resistance  -- pathetic flask
}

local wotlkflasks = {
	SpellName(53755), -- Flask of the Frost Wyrm
	SpellName(53758), -- Flask of Stoneblood
	SpellName(54212), -- Flask of Pure Mojo
	SpellName(53760), -- Flask of Endless Rage
	SpellName(79639), -- Enhanced Agility  - Cata but not as good as other flasks.  Like Flask of the North.
	SpellName(79640), -- Enhanced Intellect  - Cata but not as good as other flasks.  Like Flask of the North.
	SpellName(79638), -- Enhanced Strength  - Cata but not as good as other flasks.  Like Flask of the North.

}

local cataflasks = {
	SpellName(79469), -- Flask of Steelskin
	SpellName(79470), -- Flask of the Draconic Mind
	SpellName(79471), -- Flask of the Winds
	SpellName(79472), -- Flask of Titanic Strength
	SpellName(94160), -- Flask of Flowing Water
}

local mopflasks = {
	SpellName(105689), -- Flask of Spring Blossoms
	SpellName(105691), -- Flask of the Warm Sun
	SpellName(105693), -- Flask of Falling Leaves
	SpellName(105694), -- Flask of the Earth
	SpellName(105696), -- Flask of Winter\'s Bite
	SpellName(105617), -- Alchemist's Flask
	SpellName(127230), -- Crystal of Insanity
} 

local wodflasks = {
        SpellName(156064), -- Flask of Greater Draenic Agility
        SpellName(156084), -- Flask of Greater Draenic Stamina
        SpellName(156079), -- Flask of Greater Draenic Intellect
        SpellName(156080), -- Flask of Greater Draenic Strength
        SpellName(156073), -- Draenic Agility Flask
        SpellName(156077), -- Draenic Stamina Flask
        SpellName(156070), -- Draenic Intellect Flask
        SpellName(156071), -- Draenic Strength Flask
	SpellName(176151), -- Whispers of Insanity
}

local augmentrunes = {
        SpellName(175439), -- Stout Augment Rune
        SpellName(175457), -- Focus Augment Rune
        SpellName(175456), -- Hyper Augment Rune
}

local tbcbelixirs = {
	SpellName(11390),-- Arcane Elixir
	SpellName(17538),-- Elixir of the Mongoose
	SpellName(17539),-- Greater Arcane Elixir
	SpellName(28490),-- Major Strength
	SpellName(28491),-- Healing Power
	SpellName(28493),-- Major Frost Power
	SpellName(54494),-- Major Agility
	SpellName(28501),-- Major Firepower
	SpellName(28503),-- Major Shadow Power
	SpellName(38954),-- Fel Strength Elixir
	SpellName(33720),-- Onslaught Elixir
	SpellName(54452),-- Adept's Elixir
	SpellName(33726),-- Elixir of Mastery
	SpellName(26276),-- Elixir of Greater Firepower
	SpellName(45373),-- Bloodberry - only works on Sunwell Plateau
	SpellName(48100),-- Intellect - from scroll (not TBC but less good than WotLK elixirs)
	SpellName(58449),-- Strength - from scroll (not TBC but less good than WotLK elixirs)
	SpellName(48104),-- Spirit - from scroll (not TBC but less good than WotLK elixirs)
	SpellName(58451),-- Agility - from scroll (not TBC but less good than WotLK elixirs)
	
}
local tbcgelixirs = {
	SpellName(11348),-- Greater Armor/Elixir of Superior Defense
	SpellName(11396),-- Greater Intellect
	SpellName(24363),-- Mana Regeneration/Mageblood Potion
	SpellName(28502),-- Major Armor/Elixir of Major Defense
	SpellName(28509),-- Greater Mana Regeneration/Elixir of Major Mageblood
	SpellName(28514),-- Empowerment
	SpellName(29626),-- Earthen Elixir
	SpellName(39625),-- Elixir of Major Fortitude
	SpellName(39627),-- Elixir of Draenic Wisdom
	SpellName(39628),-- Elixir of Ironskin
	SpellName(58453),-- Armor - from scroll (not TBC but less good than WotLK elixirs)
	SpellName(48102),-- Stamina - from scroll (not TBC but less good than WotLK elixirs)
}

local wotlkbelixirs = {
	SpellName(28497), -- Mighty Agility
	SpellName(53748), -- Mighty Strength
	SpellName(53749), -- Guru's Elixir
	SpellName(33721), -- Spellpower Elixir
	SpellName(53746), -- Wrath Elixir
	SpellName(60345), -- Armor Piercing
	SpellName(60340), -- Accuracy
	SpellName(60344), -- Expertise
	SpellName(60341), -- Deadly Strikes
	SpellName(60346), -- Lightning Speed
}
local wotlkgelixirs = {
	SpellName(60347), -- Mighty Thoughts
	SpellName(53751), -- Mighty Fortitude
	SpellName(53747), -- Elixir of Spirit
	SpellName(60343), -- Mighty Defense
	SpellName(53763), -- Elixir of Protection
	SpellName(53764), -- Mighty Mageblood
}

local catabelixirs = {
	SpellName(79477), -- Elixir of the Cobra
	SpellName(79481), -- Elixir of Impossible Accuracy
	SpellName(79632), -- Elixir of Mighty Speed
	SpellName(79635), -- Elixir of the Master
	SpellName(79468), -- Ghost Elixir
	SpellName(79474), -- Elixir of the Naga
}

local catagelixirs = {
	SpellName(79480), -- Elixir of Deep Earth
	SpellName(79631), -- Prismatic Elixir
}

local mopbelixirs = {
	SpellName(105682), -- Mad Hozen Elixir
	SpellName(105683), -- Elixir of Weaponry
	SpellName(105684), -- Elixir of the Rapids
	SpellName(105685), -- Elixir of Peace
	SpellName(105686), -- Elixir of Perfection
	SpellName(105688), -- Monk\'s Elixir
}

local mopgelixirs = {
	SpellName(105681), -- Mantid Elixir
	SpellName(105687), -- Elixir of Mirrors
}

-- all old flixirs
local oldflasks = {}
local oldbelixirs = {}
local oldgelixirs = {}
for _,t in pairs({tbcflasks,wotlkflasks,cataflasks,mopflasks}) do
   for _,v in ipairs (t) do
	table.insert(oldflasks,v)
   end
end
for _,t in pairs({tbcbelixirs,wotlkbelixirs,catabelixirs,mopbelixirs}) do
   for _,v in ipairs (t) do
	table.insert(oldbelixirs,v)
   end
end
for _,t in pairs({tbcgelixirs,wotlkgelixirs,catagelixirs,mopgelixirs}) do
   for _,v in ipairs (t) do
	table.insert(oldgelixirs,v)
   end
end

-- last expansion flixirs
local lastflasks   = mopflasks
local lastbelixirs = mopbelixirs
local lastgelixirs = mopgelixirs

-- current expansion flixirs
local currflasks   = wodflasks
local currbelixirs = {}
local currgelixirs = {}

addon.allflixirs = {}
for _,t in pairs({oldflasks,oldbelixirs,oldgelixirs,currflasks,currbelixirs,currgelixirs}) do
  for _,v in ipairs (t) do
  	addon.allflixirs[v] = true
  end
end

local allclasses = {}
for _,c in pairs(CLASS_SORT_ORDER) do
  allclasses[c] = true
end

local foods = {
	SpellName(35272), -- Well Fed
}

local allfoods = {
	SpellName(35272), -- Well Fed
	SpellName(44106), -- "Well Fed" from Brewfest
	SpellName(43730), -- Electrified
	SpellName(43722), -- Enlightened
	SpellName(25661), -- Increased Stamina
	SpellName(25804), -- Rumsey Rum Black Label
}

local fortitude = {
	SpellName(21562),	-- Power Word: Fortitude
	SpellName(166928),	-- Blood Pact
	SpellName(469), 	-- Commanding Shout
	SpellName(90364),	-- Silithid, Qiraji Fortitude
	SpellName(50256),	-- Bear, Invigorating Roar
	SpellName(160014),	-- Goat, Sturdiness
	SpellName(160003),	-- Rylak, Savage Vigor
	SpellName(160199),	-- Lone Wolf: Fortitude of the Bear
}

local statbuff = {
	SpellName(20217),	-- Blessing of Kings
	SpellName(1126),	-- Mark of the Wild
	SpellName(116781),	-- Legacy of the White Tiger
	SpellName(115921),	-- Legacy of the Emperor
	SpellName(90363),	-- Shale Spider, Embrace of the Shale Spider
	SpellName(159988),	-- Dog, Bark of the Wild
	SpellName(160017),	-- Gorilla, Blessing of Kongs
	SpellName(160077),	-- Worm, Strength of the Earth
	SpellName(160206),	-- Lone Wolf: Power of the Primates
}

local masterybuff = { 
	SpellName(19740),	-- Blessing of Might
	SpellName(155522),	-- Power of the Grave
	SpellName(116956),	-- Grace of Air
	SpellName(24907),	-- Moonkin Aura
	SpellName(93435),	-- Cat, Roar of Courage
	SpellName(128997),	-- Spirit Beast, Spirit Beast Blessing
	SpellName(160073),	-- Tallstrider, Plainswalking
	SpellName(160039),	-- Hydra, Keen Senses
	SpellName(160198),	-- Lone Wolf: Grace of the Cat
} 

local critbuff = {
	SpellName(116781),	-- Legacy of the White Tiger
	SpellName(17007),	-- Leader of the Pack
	SpellName(1459),	-- Arcane Brilliance
	SpellName(61316),	-- Dalaran Brilliance
	SpellName(24604),	-- Wolf, Furious Howl
	SpellName(90309),	-- Devilsaur, Terrifying Roar
	SpellName(126373),	-- Quilen, Fearless Roar
	SpellName(126309),	-- Water Strider, Still Water
	SpellName(90363),	-- Shale Spider, Embrace of the Shale Spider
	SpellName(160052),	-- Raptor, Strength of the Pack
	SpellName(128997),	-- Spirit Beast, Spirit Beast Blessing
	SpellName(160200),      -- Lone Wolf: Ferocity of the Raptor
}

local hastebuff = {
	SpellName(55610),	-- Unholy Aura
	SpellName(116956),	-- Grace of Air
	SpellName(49868),	-- Mind Quickening
	SpellName(113742),	-- Swiftblade's Cunning
	SpellName(135678),	-- Sporebat, Energizing Spores
	SpellName(128432),	-- Hyena, Cackling Howl
	SpellName(160074),	-- Wasp, Speed of the Swarm
	SpellName(160003),	-- Rylak, Savage Vigor
	SpellName(160203),	-- Lone Wolf: Haste of the Hyena
}

local msbuff = { -- multistrike
	SpellName(166916),	-- Windflurry
	SpellName(49868),	-- Mind Quickening
	SpellName(113742),	-- Swiftblade's Cunning
	SpellName(109773),	-- Dark Intent
	SpellName(50519),	-- Bat, Sonic Focus
	SpellName(159736), 	-- Chimaera, Duality
	SpellName(57386),	-- Clefthoof, Wild Strength
	SpellName(58604),	-- Core Hound, Double Bite
	SpellName(34889),	-- Dragonhawk, Spry Attacks
	SpellName(24844),	-- Wind Serpent, Breath of the Winds
	SpellName(172968),	-- Lone Wolf: Quickness of the Dragonhawk
}

local vsbuff = { -- versatility
	SpellName(167187),	-- Sanctity Aura
	SpellName(167188),	-- Inspiring Presence
	SpellName(55610),	-- Unholy Aura
	SpellName(1126),	-- Mark of the Wild
	SpellName(159735),	-- Bird of Prey, Tenacity
	SpellName(35290),	-- Boar, Indomitable
	SpellName(57386),	-- Clefthoof, Wild Strength
	SpellName(160045),	-- Porcupine, Defensive Quills
	SpellName(50518),	-- Ravager, Chitinous Armor
	SpellName(160077),	-- Worm, Strength of the Earth
	SpellName(173035),	-- Stag, Grace
	SpellName(172967),	-- Lone Wolf: Versatility of the Ravager
}

local spbuff = { 
	SpellName(1459),	-- Arcane Brilliance
	SpellName(61316),	-- Dalaran Brilliance
	SpellName(109773),	-- Dark Intent
	SpellName(126309),	-- Water Strider, Still Water
	SpellName(90364),	-- Silithid, Qiraji Fortitude
	SpellName(128433),	-- Serpent, Serpent's Cunning
	SpellName(160205),	-- Lone Wolf: Wisdom of the Serpent
}

local apbuff = {
	SpellName(19506),	-- Trueshot Aura
	SpellName(6673),	-- Battle Shout
	SpellName(57330),	-- Horn of Winter
}

local cheetah_spellid = 5118 	-- Aspect of the Cheetah
local cheetah_glyphid = 119462 	-- glyph of Aspect of the Cheetah
local badaspects = {
	SpellName(cheetah_spellid),
	SpellName(13159), -- Aspect of the Pack
}

local blood_presence = SpellName(48263) -- Blood Presence
local dkpresences = {
	blood_presence,   -- Blood Presence
	SpellName(48266), -- Frost Presence
	SpellName(48265), -- Unholy Presence
}

local defensive_stance = SpellName(71)
local warrstances = {
	defensive_stance,
	SpellName(2457), -- Battle Stance
	SpellName(156291), -- Gladiator Stance (prot only)
}

local scrollofagility = {
	BS[8115], -- Agility
}
scrollofagility.name = BS[8115] -- Agility
scrollofagility.shortname = L["Agil"]

local scrollofstrength = {
	BS[8118], -- Strength
}
scrollofstrength.name = BS[8118] -- Strength
scrollofstrength.shortname = L["Str"]

local scrollofintellect = {
	BS[8096], -- Intellect
}
scrollofintellect.name = BS[8096] -- Intellect
scrollofintellect.shortname = L["Int"]

local scrollofprotection = {
	BS[42206], -- Protection
}
scrollofprotection.name = BS[42206] -- Protection
scrollofprotection.shortname = L["Prot"]

local roguewepbuffs = {
	BS[2818],  	-- Deadly Poison
	BS[157584], 	-- Instant Poison (Combat only, replaces Deadly)
	BS[8679],  	-- Wound Poison
	--[[ -- Non-lethal poisons: (don't check)
	BS[3409],  	-- Crippling Poison
	BS[108211],  	-- Leeching Poison
	--]]
}

local function initreporttable(tablename)
  report[tablename] = report[tablename] or {}
  wipe(report[tablename])
end

local function getbuffinfo(buffinfo_or_checkname)
  local r = buffinfo_or_checkname
  if r and type(r) == "string" then
    local check = addon.BF[r]
    if not check then
      geterrorhandler()("Bad checkname specified for buffinfo: "..r)
    end
    r = check.buffinfo
  end
  if not r then
     geterrorhandler()("missing buffinfo")
  end
  return r
end

local function player_spell(buffinfo)
  local _, class = UnitClass("player")
  for _,info in ipairs(getbuffinfo(buffinfo)) do
    if info[1] == class then
       return BS[info[2]]
    end
  end
  return nil
end

local function unithasbuff(unit, bufflist, staticfavored)
  for _, v in pairs(bufflist) do
    local b = unit.hasbuff[v]
    if b then
      if staticfavored and profile.preferstaticbuff and -- looking for a static buff
         UnitIsVisible(unit.unitid) then -- duration is only available when unit is visible
         if b.duration and b.duration > 5*60 then -- this is the static buff
	   return v,b
	 end
      else
        return v,b
      end
    end
  end
  return nil
end

-- generic buffinfo struct: 1=CLASSNAME, 2=spellid, 3=priority, 4=spec, 5=conflicting_spellid

local wsptmp = {}
local _generic_buffer_cache = {}
local function generic_buffers(buffinfo)
  local ret = _generic_buffer_cache[buffinfo] or {}
  _generic_buffer_cache[buffinfo] = ret
  wipe(ret)
  for _,info in ipairs(getbuffinfo(buffinfo)) do
    for name,unit in pairs(raid.classes[info[1]]) do
       if (info[4] == nil) or (info[4] == unit.spec) then  -- spec-specific buff
         table.insert(ret, name)
       end
    end
  end
  return ret
end

local function generic_whispertobuff(reportl, prefix, buffinfo, buffers, buffname)
  local targets
  if profile.WhisperMany and #reportl >= profile.HowMany then
    targets = L["MANY!"]
  else
    targets = table.concat(reportl, ", ")
  end

  if buffers then
    for _, name in ipairs(buffers) do
      local unit = addon:GetUnitFromName(name)
      if unit and addon:InMyZone(unit.name) and unit.online and not unit.isdead then
         addon:Say(prefix .. "<" .. buffname .. ">: " .. targets, unit.name)
         if profile.whisperonlyone then
            return
         end
      end
    end
    return
  end

  local priority 
  for _,info in ipairs(getbuffinfo(buffinfo)) do -- for each class
    local bname = (buffname or BS[info[2]])
    local cbuff = info[5] and BS[info[5]]
    if priority and (info[3] ~= priority) then
        return -- already whispered a higher priority class
    end
    wipe(wsptmp)
    for name,unit in pairs(raid.classes[info[1]]) do  -- foreach unit of that class
    --for name,unit in bi_pairs(raid.classes[info[1]], info[2], info[5]) do  -- foreach unit of that class, sorted by autoguess best buff candidate
        if addon:InMyZone(name) and unit.online and not unit.isdead 
	   and ((info[4] == nil) or (info[4] == unit.spec)) then
	   local code = 5
	   if unit.hasbuff[bname] and unit.hasbuff[bname].caster == name then
	      code = 1 -- already self-buffed, top priority
	   elseif cbuff and unit.hasbuff[cbuff] and unit.hasbuff[cbuff].caster == name then -- self buffed with conflicting
	      code = 9
	   end
	   table.insert(wsptmp, code.."#"..name)
	end
    end
    table.sort(wsptmp)
    for _,codedname in ipairs(wsptmp) do
    	   local _,name = strsplit("#",codedname)
           addon:Say(prefix .. "<" .. bname .. ">: " .. targets, name)
           if profile.whisperonlyone then
              return
           else
              priority = info[3]
           end
    end
  end
end

function addon:ValidateSpellIDs()
  for checkname, info in pairs(addon.BF) do
    local buffinfo = info.buffinfo
    if buffinfo then
      for _, info in ipairs(buffinfo) do
        if not info[1] or not allclasses[info[1]] or 
	   (info[3] and type(info[3]) ~= "number") then
	  geterrorhandler()("bad buffinfo entry in check: "..checkname)
	end
	local spell = BS[info[2]] -- this throws error if spellid is bad
      end
    end
  end
end

local BF = {
	pvp = {											-- button name
		order = 1000,
		list = "pvplist",								-- list name
		check = "checkpvp",								-- check name
		default = false,									-- default state enabled
		defaultbuff = false,								-- default state report as buff missing
		defaultwarning = true,								-- default state report as warning
		defaultdash = false,								-- default state show on dash
		defaultdashcombat = false,							-- default state show on dash when in combat
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = true,								-- check when unit is not in this zone
		selfbuff = true,								-- is it a buff the player themselves can fix
		timer = true,									-- rbs will count how many minutes this buff has been missing/active
		chat = L["PVP On"],								-- chat report
		pre = nil,
		main = function(self, name, class, unit, raid, report)				-- called in main loop
			if UnitIsPVP(unit.unitid) then
				table.insert(report.pvplist, name)
			end
		end,
		post = nil,									-- called after main loop
		icon = "Interface\\Icons\\INV_BannerPVP_02",					-- icon
		update = function(self)								-- icon text
			addon:DefaultButtonUpdate(self, report.pvplist, profile.checkpvp, true, report.pvplist)
		end,
		click = function(self, button, down)						-- button click
			addon:ButtonClick(self, button, down, "pvp")
		end,
		tip = function(self)								-- tool tip
			addon:Tooltip(self, L["PVP is On"], report.pvplist, raid.BuffTimers.pvptimerlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
		other = true,
	},

	health = {
		order = 970,
		list = "healthlist",
		check = "checkhealth",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = true,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = allclasses,
		chat = L["Health less than 80%"],
		main = function(self, name, class, unit, raid, report)
			if not unit.isdead then
				if UnitHealth(unit.unitid)/UnitHealthMax(unit.unitid) < 0.8 then
					table.insert(report.healthlist, name)
				end
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_131",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.healthlist, profile.checkhealth, true, report.healthlist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "health")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Player has health less than 80%"], report.healthlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
		other = true,
	},

	mana = {
		order = 960,
		list = "manalist",
		check = "checkmana",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = true,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { PRIEST = true, DRUID = true, PALADIN = true, MAGE = true, WARLOCK = true, SHAMAN = true, MONK = true },
		chat = L["Mana less than 80%"],
		main = function(self, name, class, unit, raid, report)
			if unit.isdead then return end
			if not unit.hasmana then return end
			if UnitMana(unit.unitid)/UnitManaMax(unit.unitid) < 0.8 then
				table.insert(report.manalist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_137",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.manalist, profile.checkmana, true, report.manalist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "mana")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Player has mana less than 80%"], report.manalist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
		other = true,
	},
	zone = {
		order = 950,
		list = "zonelist",
		check = "checkzone",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true, -- actually has no effect
		selfbuff = false,
		timer = false,
		core = true,
		chat = L["Different Zone"],
		main = nil, -- done by main code
		post = nil,
		icon = "Interface\\Icons\\INV_Misc_QuestionMark",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.zonelist, profile.checkzone, true)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "zone")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Player is in a different zone"], 
			              nil, nil, nil, nil, 
				      (#report.zonelist > 0) and not InCombatLockdown() and L["Right-click to target"], 
				      nil, nil, nil, report.zonelist)
		end,
		whispertobuff = function(reportl, prefix)
			if not raid.leader or #reportl < 1 then
				return
			end
			if profile.WhisperMany and #reportl >= profile.HowMany then
				addon:Say(prefix .. "<" .. addon.BF.zone.chat .. ">: " .. L["MANY!"], raid.leader)
			else
				addon:Say(prefix .. "<" .. addon.BF.zone.chat .. ">: " .. table.concat(reportl, ", "), raid.leader)
			end
		end,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
		other = true,
	},

	offline = {
		order = 940,
		list = "offlinelist",
		check = "checkoffline",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = true,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true, -- actualy has no effect
		selfbuff = false,
		timer = true,
		core = true,
		chat = L["Offline"],
		main = nil, -- done by main code
		post = nil,
		icon = "Interface\\Icons\\INV_Gizmo_FelStabilizer",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.offlinelist, profile.checkoffline, true, nil)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "offline")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Player is Offline"], report.offlinelist, raid.BuffTimers.offlinetimerlist)
		end,
		whispertobuff = function(reportl, prefix)
			if not raid.leader or #reportl < 1 then
				return
			end
			if profile.WhisperMany and #reportl >= profile.HowMany then
				addon:Say(prefix .. "<" .. addon.BF.offline.chat .. ">: " .. L["MANY!"], raid.leader)
			else
				addon:Say(prefix .. "<" .. addon.BF.offline.chat .. ">: " .. table.concat(reportl, ", "), raid.leader)
			end
		end,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
		other = true,
	},

	afk = {
		order = 930,
		list = "afklist",
		check = "checkafk",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true,
		selfbuff = true,
		timer = true,
		chat = L["AFK"],
		main = function(self, name, class, unit, raid, report)
			if UnitIsAFK(unit.unitid) then
				table.insert(report.afklist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\Trade_Fishing",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.afklist, profile.checkafk, true, report.afklist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "afk")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Player is AFK"], report.afklist, raid.BuffTimers.afktimerlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
		other = true,
	},

	dead = {
		order = 920,
		list = "deadlist",
		check = "checkdead",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = true,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true,
		selfbuff = false,
		timer = true,
		core = true,
		class = allclasses,
		buffinfo = { { "PRIEST", 2006 }, { "DRUID", 50769 }, { "PALADIN", 7328 }, { "SHAMAN", 2008 }, { "MONK", 115178 } },
		chat = L["Dead"],
		main = function(self, name, class, unit, raid, report)
			if unit.isdead then
				table.insert(report.deadlist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\Spell_Holy_SenseUndead",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.deadlist, profile.checkdead, true, generic_buffers("dead"))
		end,
		click = function(self, button, down)
			local rezspell
			if not InCombatLockdown() then
			  rezspell = player_spell("dead") or BS[83968] -- mass resurrection
			end
			addon:ButtonClick(self, button, down, "dead", rezspell, true)
		end,
		tip = function(self)
			addon:Tooltip(self, L["Player is Dead"], report.deadlist, raid.BuffTimers.deadtimerlist, generic_buffers("dead"))
		end,
		singlebuff = true,
		partybuff = false,
		raidbuff = false,
		whispertobuff = function (reportl, prefix) generic_whispertobuff(reportl, prefix, "dead", nil, L["Dead"]) end,
		other = true,
	},
	durability = {
		order = 910,
		list = "durabilitylist",
		check = "checkdurability",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true,
		selfbuff = true,
		timer = false,
		chat = L["Low durability"],
		main = function(self, name, class, unit, raid, report)
			if not raid.israid or raid.isbattle then
				return
			end
			report.checking.durabilty = true
			local broken = addon.broken[name]
			if broken ~= nil and broken ~= "0" then
				table.insert(report.durabilitylist, name .. "(0)")
			else
				local dura = addon.durability[name]
				if dura ~= nil and dura < 36 then
					table.insert(report.durabilitylist, name .. "(" .. dura .. ")")
				end
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Chest_Cloth_61",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.durabilitylist, profile.checkdurability, report.checking.durabilty or false, report.durabilitylist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "durability")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Low durability (35% or less)"], report.durabilitylist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
		other = true,
	},

	cheetahpack = {
		order = 900,
		list = "cheetahpacklist",
		check = "checkcheetahpack",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		selfonlybuff = true,
		timer = false,
		class = { HUNTER = true, },
		chat = L["Aspect Cheetah/Pack On"],
		main = function(self, name, class, unit, raid, report)
			if class == "HUNTER" then
				report.checking.cheetahpack = true
				for _, v in ipairs(badaspects) do
					if unit.hasbuff[v] 
					   and not (
					     v == SpellName(cheetah_spellid)
					     and (not unit.talents or 
					          unit.tinfo.glyphs[cheetah_glyphid]) -- negates the daze
					   ) then
						local caster = unit.hasbuff[v].caster
						if not caster or #caster == 0 then
						   caster = name -- caster is nil when out of range
						end
						-- only report each caster once
						report.cheetahpacklist[caster] = caster.."("..v..")"
					end
				end
			end
		end,
		post = function(self, raid, report)
		        local l = report.cheetahpacklist
			local gotone = true
			while gotone do
			  gotone = false
		          for k,v in pairs(l) do -- convert to numeric list for sorting
			    if type(k) ~= "number" then
			      l[k] = nil
			      table.insert(l,v) 
			      gotone = true
			      break
			    end
			  end
			end
			table.sort(l)
		end,
		icon = BSI[5118], -- Aspect of the Cheetah
		update = function(self)
			addon:DefaultButtonUpdate(self, report.cheetahpacklist, profile.checkcheetahpack, report.checking.cheetahpack or false, report.cheetahpacklist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "cheetahpack")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Aspect of the Cheetah or Pack is on"], report.cheetahpacklist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	oldflixir = {
		order = 895,
		list = "oldflixirlist",
		check = "checkoldflixir",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		chat = L["Flasked or Elixired but slacking"],
		main = nil, -- set in flask check
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_91",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.oldflixirlist, profile.checkoldflixir, true, report.oldflixirlist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "oldflixir")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Flasked or Elixired but slacking"], report.oldflixirlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
		consumable = true,
	},

	slackingfood = {
		order = 894,
		list = "slackingfoodlist",
		check = "checkslackingfood",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		chat = L["Well Fed but slacking"],
		main = nil, -- handled in food check
		post = nil,
		icon = "Interface\\Icons\\INV_Misc_Food_67",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.slackingfoodlist, profile.checkslackingfood, true, report.slackingfoodlist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "slackingfood")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Well Fed but slacking"], report.slackingfoodlist)
		end,
		partybuff = nil,
		consumable = true,
	},

	righteousfury = {
		order = 310,
		list = "righteousfurylist",
		check = "checkrighteousfury",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		selfonlybuff = true,
		timer = false,
		class = { PALADIN = true, },
		chat = BS[25780], -- Righteous Fury
		main = function(self, name, class, unit, raid, report)
			if class == "PALADIN" and raid.classes.PALADIN[name].spec == 2 then
					report.checking.righteousfury = true
					if not unit.hasbuff[BS[25780]] then -- Righteous Fury
						table.insert(report.righteousfurylist, name)
					end
			end
		end,
		post = nil,
		icon = BSI[25780], -- Righteous Fury
		update = function(self)
			addon:DefaultButtonUpdate(self, report.righteousfurylist, profile.checkrighteousfury, report.checking.righteousfury or false, report.righteousfurylist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "righteousfury", BS[25780]) -- Righteous Fury
		end,
		tip = function(self)
			addon:Tooltip(self, L["Protection Paladin with no Righteous Fury"], report.righteousfurylist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},


	earthshield = {
		order = 365,
		list = "earthshieldslackers",
		check = "checkearthshield",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		class = { SHAMAN = true, },
--		chat = BS[974],  -- Earth Shield
		chat = function(report, raid, prefix, channel)
			prefix = prefix or ""
			if report.checking.earthshield then
				if # report.earthshieldslackers > 0 then
					addon:Say(prefix .. "<" .. L["Missing "] .. BS[974] .. ">: " .. table.concat(report.tanksneedingearthshield, ", "), nil, nil, channel)  -- Earth Shield
					addon:Say(L["Slackers: "] .. table.concat(report.earthshieldslackers, ", "))
				end
			end
		end,
		pre = function(self, raid, report)
			initreporttable("tanksneedingearthshield")
			initreporttable("tanksgotearthshield")
			initreporttable("shamanwithearthshield")
			initreporttable("haveearthshield")
			initreporttable("earthshieldslackers")
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.SHAMAN < 1 then
				return
			end
			if class == "SHAMAN" then
				if raid.classes.SHAMAN[name].spec == 3 then
					table.insert(report.shamanwithearthshield, name)
				end
			end
			local hasbuff = unit.hasbuff[BS[974]] -- Earth Shield
			if hasbuff then
				report.haveearthshield[name] = hasbuff.caster
			end
			if unit.istank or
			       GetPartyAssignment("MAINTANK",unit.unitid) then -- allow earthshield on non-traditional tanks
					report.checking.earthshield = true
					if hasbuff then
						table.insert(report.tanksgotearthshield, name)
					else
						table.insert(report.tanksneedingearthshield, name)
					end
			end
		end,
		post = function(self, raid, report)
			local numberneeded = #report.tanksneedingearthshield
			local numberavailable = #report.shamanwithearthshield - #report.tanksgotearthshield
			if #report.tanksneedingearthshield > 0 and #report.shamanwithearthshield > 0 then
				report.checking.earthshield = true
			end
			if numberneeded > 0 and numberavailable > 0 then
				for _, name in ipairs(report.shamanwithearthshield) do
					local found = false
					for _, caster in pairs(report.haveearthshield) do
						if caster == name then
							found = true
							break
						end
					end
					if not found then
						table.insert(report.earthshieldslackers, name)
					end
				end
			else
				wipe(report.tanksneedingearthshield)
			end
		end,
		icon = BSI[974],  -- Earth Shield
		update = function(self)
			addon:DefaultButtonUpdate(self, report.tanksneedingearthshield, profile.checkearthshield, report.checking.earthshield or false, addon.BF.earthshield:buffers())
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "earthshield", BS[974], true)  -- Earth Shield
		end,
		tip = function(self)
			addon:Tooltip(self, L["Tank missing Earth Shield"], report.tanksneedingearthshield, nil, addon.BF.earthshield:buffers(), report.earthshieldslackers, nil, nil, nil, report.haveearthshield)
		end,
		singlebuff = true,
		partybuff = false,
		raidbuff = false,
		whispertobuff = function(reportl, prefix)
			for _,name in pairs(report.earthshieldslackers) do
				addon:Say(prefix .. "<" .. L["Missing "] .. BS[974] .. ">: " .. table.concat(report.tanksneedingearthshield, ", "), name)  -- Earth Shield
			end
		end,
		buffers = function()
			local theshamans = {}
			for name,rcn in pairs(raid.classes.SHAMAN) do
				if rcn.spec == 3 then
					table.insert(theshamans, name)
				end
			end
			return theshamans
		end,
		singletarget = true,
	},

	soulstone = {
		order = 860,
		list = "nosoulstonelist",
		check = "checksoulstone",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = false,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = true,
		selfbuff = false,
		timer = false,
		class = { WARLOCK = true, },
		chat = function(report, raid, prefix, channel)
			prefix = prefix or ""
			if report.checking.soulstone then
				if # report.soulstonelist < 1 and addon.BF.soulstone:lockwithnocd() then
					addon:Say(prefix .. "<" .. L["No Soulstone detected"] .. ">", nil, nil, channel)
				end
			end
		end,
		pre = function(self, raid, report)
			initreporttable("soulstonelist")
			initreporttable("havesoulstonelist")
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.WARLOCK > 0 then
				report.checking.soulstone = true
				if unit.hasbuff[BS[20707]] then -- Soulstone Resurrection
					table.insert(report.soulstonelist, name)
					report.havesoulstonelist[name] = unit.hasbuff[BS[20707]].caster -- Soulstone Resurrection
				end
			end
		end,
		post = function(self, raid, report)
			if # report.soulstonelist < 1 and addon.BF.soulstone:lockwithnocd() then
				table.insert(report.nosoulstonelist, "raid")
			end
		end,
		icon = "Interface\\Icons\\Spell_Shadow_SoulGem",
		update = function(self)
			if profile.checksoulstone then
				if report.checking.soulstone then
					self:SetAlpha(1)
					if # report.soulstonelist > 0 or not addon.BF.soulstone:lockwithnocd() then
						self.count:SetText("0")
					else
						self.count:SetText("1")
					end
				else
					self:SetAlpha(0.15)
					self.count:SetText("")
				end
			else
				self:SetAlpha(0.5)
				self.count:SetText("X")
			end
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "soulstone")
		end,
		tip = function(self)
			if not report.soulstonelist then  -- fixes error when tip being called from option window when not in a party/raid
				addon:Tooltip(self, BS[20707])
			else
				if #report.soulstonelist < 1 then
					addon:Tooltip(self, BS[20707], {L["No Soulstone detected"]}, nil, addon.BF.soulstone:buffers())
				else
					addon:Tooltip(self, BS[20707], nil, nil, addon.BF.soulstone:buffers(), nil, nil, nil, nil, report.havesoulstonelist)
				end
			end
		end,
		partybuff = nil,
		whispertobuff = function(reportl, prefix)
			local lock = addon.BF.soulstone:lockwithnocd()
			if lock then
				addon:Say(prefix .. "<" .. L["No Soulstone detected"] .. ">", lock)
			end
		end,
		buffers = function()
			local thelocks = {}
			local thetime = time()
			for name,_ in pairs(raid.classes.WARLOCK) do
				if addon:GetLockSoulStone(name) then
--					addon:Debug(name .. " is on ss cd")
					local thedifference = addon:GetLockSoulStone(name) - thetime
					if thedifference > 0 then
						name = name .. "(" ..  math.floor(thedifference / 60) .. "m" .. (thedifference % 60) .. "s)"
					end
				end
				table.insert(thelocks, name)
			end
			return thelocks
		end,
		lockwithnocd = function()
			for name,_ in pairs(raid.classes.WARLOCK) do
				if not addon:GetLockSoulStone(name) or (addon:GetLockSoulStone(name) and time() > addon:GetLockSoulStone(name)) then
					return name
				end
			end
			return nil
		end,
		singletarget = true,
	},

	healthstone = {
		order = 850,
		list = "healthstonelist",
		check = "checkhealthstone",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = ITN[5512], -- Healthstone
		itemcheck = {
			item = "5512", -- Healthstone
			min = 1,
			frequency = 60 * 3,
			frequencymissing = 30,
		},
		pre = function(self, raid, report)
			if raid.ClassNumbers.WARLOCK < 1 or not raid.israid or raid.isbattle then
				return
			end
			initreporttable("healthstonelistunknown")
			initreporttable("healthstonelistgotone")
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.WARLOCK < 1 or not raid.israid or raid.isbattle then
				return
			end
			report.checking.healthstone = true
			local stones = addon:ItemQuery("healthstone", name)
			if stones == nil then
				table.insert(report.healthstonelistunknown, name)
			elseif stones < addon.itemcheck.healthstone.min then
				table.insert(report.healthstonelist, name)
			else
				table.insert(report.healthstonelistgotone, name)
			end
		end,
		icon = BSI[34130], -- Healthstone
		update = function(self)
			addon:DefaultButtonUpdate(self, report.healthstonelist, profile.checkhealthstone, report.checking.healthstone or false, addon.BF.healthstone:buffers())
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "healthstone")
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.healthstonelist, nil, addon.BF.healthstone:buffers(), nil, nil, nil, report.healthstonelistunknown, report.healthstonelistgotone) -- Healthstone
		end,
		partybuff = nil,
		whispertobuff = function(reportl, prefix)
			if addon.soulwelllastseen > GetTime() then -- whisper the slackers instead of the locks as a soul well is up
				if #reportl > 0 then
					for _, v in ipairs(reportl) do
						addon:Say(prefix .. "<" .. L["Missing "] .. ITN[5512] .. ">: " .. v, v) -- Healthstone
					end
				end
			else
				local thelocks = addon.BF.healthstone:buffers()
				for _,name in pairs(thelocks) do
					if profile.WhisperMany and #reportl >= profile.HowMany then
						addon:Say(prefix .. "<" .. L["Missing "] .. ITN[5512] .. ">: " .. L["MANY!"], name) -- Healthstone
					else
						addon:Say(prefix .. "<" .. L["Missing "] .. ITN[5512] .. ">: " .. table.concat(reportl, ", "), name) -- Healthstone
					end
				end
			end
		end,
		buffers = function()
			local thelocks = {}
			for name,rcn in pairs(raid.classes.WARLOCK) do
				table.insert(thelocks, name)
			end
			return thelocks
		end,
		consumable = true,
	},

	flaskofbattle = {
		order = 840,
		list = "flaskofbattlelist",
		check = "checkflaskofbattle",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = false,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = nil,
		itemcheck = {
			item = "65455", -- Flask of Battle
			min = 0,
			frequency = 60 * 3,
			frequencymissing = 60 * 3,
		},
		pre = function(self, raid, report)
			if not raid.israid then
				return
			end
			initreporttable("flaskofbattlelistunknown")
			initreporttable("flaskofbattlelistgotone")
		end,
		main = function(self, name, class, unit, raid, report)
			if not raid.israid then
				return
			end
			report.checking.flaskofbattle = true
			local flasks = addon:ItemQuery("flaskofbattle", name)
			if flasks == nil then
				table.insert(report.flaskofbattlelistunknown, name)
			elseif flasks >= 1 then
				report.flaskofbattlelistgotone[name] = flasks
			end
		end,
		icon = ITT[65455], -- Flask of Battle
		iconfix = function(self) -- to handle when server is slow to get the icon
			if addon.BF.flaskofbattle.icon == "Interface\\Icons\\INV_Misc_QuestionMark" then
				addon.BF.flaskofbattle.icon = ITT[65455] -- Flask of Battle
				if addon.BF.flaskofbattle.icon == "Interface\\Icons\\INV_Misc_QuestionMark" then
					return true
				end
			end
			return false
		end,
		update = function(self)
			addon:DefaultButtonUpdate(self, report.flaskofbattlelist, profile.checkflaskofbattle, report.checking.flaskofbattle or false)
			if self.count:GetText() ~= "X" then
				self.count:SetText("")
			end
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "flaskofbattle")
		end,
		tip = function(self)
			addon:Tooltip(self, ITN[65455] .. L[" in their bags"], nil, nil, nil, nil, nil, nil, report.flaskofbattlelistunknown, nil, nil, report.flaskofbattlelistgotone) -- Flask of Battle
		end,
		partybuff = nil,
		whispertobuff = nil,
		buffers = nil,
		consumable = true,
	},

	food = {
		order = 500,
		list = "foodlist",
		check = "checkfood",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		core = true,
		class = allclasses,
		chat = BS[35272], -- Well Fed
		main = function(self, name, class, unit, raid, report)
			local missingbuff = true
			local level = unit.foodlevel
			local label = name
			if level then
			   if level >= profile.foodlevel then
			      missingbuff = false
			   elseif unit.foodtext then
			      label = name.."("..unit.foodtext..")"
			   end
			end
                        
			if missingbuff and unit.eating and profile.ignoreeating then
				missingbuff = false -- assume they are eating acceptable food
			end

			if missingbuff then
				for _, v in ipairs(foods) do
					if unit.hasbuff[v] then
			                        table.insert(report.slackingfoodlist, label)
						break
					end
				end
			end

			if missingbuff then
				if unit.eating then
					name = name.."("..L["Eating"]..")"
					report.foodlist.notes = true
				end
				table.insert(report.foodlist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Misc_Food_74",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.foodlist, profile.checkfood, true, report.foodlist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "food")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Not Well Fed"], report.foodlist)
		end,
		partybuff = nil,
		consumable = true,
	},
	
	flask = {
		order = 490,
		list = "flasklist",
		check = "checkflaskir",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		core = true,
		class = allclasses,
		chat = L["Flask or two Elixirs"],
		pre = function(self, raid, report)
			initreporttable("belixirlist")
			initreporttable("gelixirlist")
		end,
		main = function(self, name, class, unit, raid, report)
			report.checking.flaskir = true

			local level = unit.flixirlevel
			if not level then -- no flask or elixir
				table.insert(report.flasklist, name) 
			elseif level < profile.flixirlevel then -- slacking flixir
				local label = name
				if unit.flixirtext then
					label = label.."("..unit.flixirtext..")"
				end
				table.insert(report.oldflixirlist, label)
				table.insert(report.flasklist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_119",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.flasklist, profile.checkflaskir, true, report.flasklist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "flask")
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.flasklist)
		end,
		partybuff = nil,
		consumable = true,
	},
--[[
	belixir = {
		order = 480,
		list = "belixirlist",
		check = "checkflaskir",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		core = true,
		class = allclasses,
		chat = L["Battle Elixir"],
		pre = nil,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_111",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.belixirlist, profile.checkflaskir, true, report.belixirlist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "flask")
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.belixirlist)
		end,
		partybuff = nil,
		consumable = true,
	},
	
	gelixir = {
		order = 470,
		list = "gelixirlist",
		check = "checkflaskir",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		core = true,
		class = allclasses,
		chat = L["Guardian Elixir"],
		pre = nil,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_158",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.gelixirlist, profile.checkflaskir, true, report.gelixirlist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "flask")
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.gelixirlist)
		end,
		partybuff = nil,
		consumable = true,
	},
--]]

	wepbuff = {
		order = 410,
		list = "wepbufflist",
		check = "checkwepbuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { ROGUE = true },
		chat = L["Weapon buff"],
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if class == "ROGUE" then
                                report.checking.wepbuff = true
                                if not unithasbuff(unit, roguewepbuffs) then
                                        table.insert(report.wepbufflist, name)
                                end
				return
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_101",
		update = function(self)
			addon:DefaultButtonUpdate(self, report.wepbufflist, profile.checkwepbuff, report.checking.wepbuff or false, report.wepbufflist)
		end,
		click = function(self, button, down)
			local class = select(2, UnitClass("player"))
			local buffspell = nil
			local itemslot = nil
			if class == "ROGUE" then
			  buffspell = BS[2823]
			end
			addon:ButtonClick(self, button, down, "wepbuff", buffspell, nil, nil, itemslot)
                end,
		tip = function(self)
			addon:Tooltip(self, nil, report.wepbufflist)
		end,
		partybuff = nil,
		consumable = true,
	},

	spbuff = {
		order = 416,
		list = "spbufflist",
		check = "checkspbuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		class = { MAGE = true, WARLOCK = true },
		chat = STAT_SPELLPOWER, -- "Spell Power"
		pre = nil,
		buffinfo = { { "MAGE", 1459 }, { "WARLOCK", 109773 } },
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.MAGE > 0 or  raid.ClassNumbers.WARLOCK > 0 then
				report.checking.spbuff = true
				if class ~= "ROGUE" and class ~= "WARRIOR" and class ~= "DEATHKNIGHT" and class ~= "HUNTER" then
					if not unithasbuff(unit, spbuff, true) then
						table.insert(report.spbufflist, name)
					end
				end
			end
		end,
		post = function(self, raid, report)
			table.sort(report.spbufflist)
		end,
		icon = BSI[109773], -- Dark Intent
		update = function(self)
			addon:DefaultButtonUpdate(self, report.spbufflist, profile.checkspbuff, report.checking.spbuff or false, generic_buffers("spbuff"))
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "spbuff", player_spell("spbuff"))
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.spbufflist, nil, generic_buffers("spbuff"))
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = generic_whispertobuff,
	},

	statbuff = {
		order = 450,
		list = "statbufflist",
		check = "checkstatbuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		class = { DRUID = true, PALADIN = true, MONK = true },
		buffinfo = { { "DRUID", 1126, 1 }, 
		             { "MONK", 116781, 1, 1 }, { "MONK", 116781, 1, 3 }, -- Legacy of the White Tiger, Brewmaster/Windwalker
			     { "MONK", 115921, 2, 2 },  -- Legacy of the Emperor, Mistweaver Only
			     { "PALADIN", 20217, 2, nil, 19740 } },
		chat = RAID_BUFF_1, -- "Stats"
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.DRUID > 0 or 
			   raid.ClassNumbers.MONK > 0 or
			   raid.ClassNumbers.PALADIN > 0 then
				report.checking.statbuff = true
				if not unithasbuff(unit, statbuff) then
					table.insert(report.statbufflist, name)
				end
			end
		end,
		post = function(self, raid, report)
			table.sort(report.statbufflist)
		end,
		icon = BSI[1126], -- Mark of the Wild
		update = function(self)
			addon:DefaultButtonUpdate(self, report.statbufflist, profile.checkstatbuff, report.checking.statbuff or false, generic_buffers("statbuff"))
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "statbuff", player_spell("statbuff"))
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.statbufflist, nil, generic_buffers("statbuff"))
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = generic_whispertobuff,
	},
	
	masterybuff = {
		order = 435,
		list = "masterybufflist",
		check = "checkmasterybuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		class = { PALADIN = true },
		buffinfo = { { "PALADIN", 19740, 1, nil, 20217 } },
		chat = STAT_MASTERY, -- "Mastery" 
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PALADIN > 1 or
                           (raid.ClassNumbers.PALADIN == 1 and
                            (raid.ClassNumbers.DRUID > 0 or raid.ClassNumbers.MONK > 0))
                        then
				report.checking.masterybuff = true
				if not unithasbuff(unit, masterybuff, true) then
					table.insert(report.masterybufflist, name)
				end
			end
		end,
		post = function(self, raid, report)
			table.sort(report.masterybufflist)
		end,
		icon = BSI[19740], -- Blessing of Might
		update = function(self)
			addon:DefaultButtonUpdate(self, report.masterybufflist, profile.checkmasterybuff, report.checking.masterybuff or false, generic_buffers("masterybuff"))
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "masterybuff", player_spell("masterybuff"))
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.masterybufflist, nil, generic_buffers("masterybuff"))
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = generic_whispertobuff,
	},
	
	fortitude = {
		order = 440,
		list = "fortitudelist",
		check = "checkfortitude",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		core = true,
		class = { PRIEST = true, WARRIOR = true },
		buffinfo = { { "PRIEST", 21562, 1 }, { "WARRIOR", 469, 2, nil, 6673 }},
		chat = RAID_BUFF_2, -- "Stamina"
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PRIEST > 0 or
			   raid.ClassNumbers.WARRIOR > 0 then
				report.checking.fortitude = true
				if not unithasbuff(unit, fortitude, true) then
					table.insert(report.fortitudelist, name)
				end
			end
		end,
		post = function(self, raid, report)
			table.sort(report.fortitudelist)
		end,
		icon = BSI[21562], -- Prayer of Fortitude
		update = function(self)
			addon:DefaultButtonUpdate(self, report.fortitudelist, profile.checkfortitude, report.checking.fortitude or false, generic_buffers("fortitude"))
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "fortitude", player_spell("fortitude"))
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.fortitudelist, nil, generic_buffers("fortitude")) -- Prayer of Fortitude
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = generic_whispertobuff,
	},

	critbuff = {
		order = 434,
		list = "critbufflist",
		check = "checkcritbuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		buffinfo = { { "MAGE", 1459 }, 
		             { "MONK", 116781, nil, 1 }, { "MONK", 116781, nil, 3 }, -- Legacy of the White Tiger, Brewmaster/Windwalker
			   },
		class = { MAGE = true, MONK = true },
		chat = STAT_CRITICAL_STRIKE, -- "Critical Strike"
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if report.checking.critbuff == nil then -- only scan once per report
			  local buffers = generic_buffers("critbuff")
			  report.checking.critbuff = ((next(buffers) and true) or false)
			end
			if report.checking.critbuff then
				if not unithasbuff(unit, critbuff, true) then
					table.insert(report.critbufflist, name)
				end
			end
		end,
		post = function(self, raid, report)
			table.sort(report.critbufflist)
		end,
		icon = BSI[116781], -- Legacy of the White Tiger
		update = function(self)
			addon:DefaultButtonUpdate(self, report.critbufflist, profile.checkcritbuff, report.checking.critbuff or false, generic_buffers("critbuff"))
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "critbuff", player_spell("critbuff"))
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.critbufflist, nil, generic_buffers("critbuff"))
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = generic_whispertobuff,
	},

	apbuff = {
		order = 415,
		list = "apbufflist",
		check = "checkapbuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		buffinfo = { { "DEATHKNIGHT", 57330, 1 }, 
		             { "WARRIOR", 6673, 2, nil, 469 }, 
			   },
		class = { DEATHKNIGHT = true, WARRIOR = true },
		chat = STAT_ATTACK_POWER,      -- "Attack Power"
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.DEATHKNIGHT > 0 or  
			   raid.ClassNumbers.WARRIOR > 1 or -- can have both shouts
			   (raid.ClassNumbers.WARRIOR == 1 and -- commanding shout not needed
			    (raid.ClassNumbers.PRIEST > 0) or (raid.ClassNumbers.WARLOCK > 0))
			   then
				report.checking.apbuff = true
				if class ~= "PRIEST" and class ~= "MAGE" and class ~= "WARLOCK" then
					if not unithasbuff(unit, apbuff, true) then
						table.insert(report.apbufflist, name)
					end
				end
			end
		end,
		post = function(self, raid, report)
			table.sort(report.apbufflist)
		end,
		icon = BSI[57330], -- Horn of Winter
		update = function(self)
			addon:DefaultButtonUpdate(self, report.apbufflist, profile.checkapbuff, report.checking.apbuff or false, generic_buffers("apbuff"))
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "apbuff", player_spell("apbuff"))
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.apbufflist, nil, generic_buffers("apbuff"))
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = generic_whispertobuff,
	},

	msbuff = { -- multistrike
		order = 432,
		list = "msbufflist",
		check = "checkmsbuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		buffinfo = { { "WARLOCK", 109773 }, },
		class = { WARLOCK = true },
		chat = STAT_MULTISTRIKE,       -- "Multistrike"
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.WARLOCK > 0 then
				report.checking.msbuff = true
				if not unithasbuff(unit, msbuff, true) then
					table.insert(report.msbufflist, name)
				end
			end
		end,
		post = function(self, raid, report)
			table.sort(report.msbufflist)
		end,
		icon = BSI[166916], -- Windflurry
		update = function(self)
			addon:DefaultButtonUpdate(self, report.msbufflist, profile.checkmsbuff, report.checking.msbuff or false, generic_buffers("msbuff"))
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "msbuff", player_spell("msbuff"))
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.msbufflist, nil, generic_buffers("msbuff"))
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = generic_whispertobuff,
	},

	vsbuff = { -- versatility
		order = 431,
		list = "vsbufflist",
		check = "checkvsbuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		buffinfo = { { "DRUID", 1126 }, },
		class = { DRUID = true },
		chat = STAT_VERSATILITY,       -- "Versatility"
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.DRUID > 0 then
				report.checking.vsbuff = true
				if not unithasbuff(unit, vsbuff, true) then
					table.insert(report.vsbufflist, name)
				end
			end
		end,
		post = function(self, raid, report)
			table.sort(report.vsbufflist)
		end,
		icon = BSI[167187], -- Sanctity Aura
		update = function(self)
			addon:DefaultButtonUpdate(self, report.vsbufflist, profile.checkvsbuff, report.checking.vsbuff or false, generic_buffers("vsbuff"))
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "vsbuff", player_spell("vsbuff"))
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.vsbufflist, nil, generic_buffers("vsbuff"))
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = generic_whispertobuff,
	},

	augmentrunes = {
		order = 460,
		list = "augmentruneslist",
		check = "checkaugmentrunes",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		core = true,
		class = allclasses,
		chat = L["Augment Rune"],
		main = function(self, name, class, unit, raid, report)
			report.checking.augmentrunes = true
			local missing = true
			for _,f in pairs(augmentrunes) do
			  if unit.hasbuff[f] then
			    missing = false
			    break
			  end
			end
			if missing then
				table.insert(report.augmentruneslist, name)
			end
		end,
		post = nil,
		icon = BSI[175457],
		update = function(self)
			addon:DefaultButtonUpdate(self, report.augmentruneslist, profile.checkaugmentrunes, true, report.augmentruneslist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "augmentrunes")
		end,
		tip = function(self)
			addon:Tooltip(self, L["Augment Rune"], report.augmentruneslist)
		end,
		partybuff = nil,
		consumable = true,
	},

	runescrollfortitude = {
		order = 445,
		list = "runescrollfortitudelist",
		check = "checkrunescrollfortitude",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		core = true,
		chat = ITN[49632],
		iconfix = function(self) -- to handle when server is slow to get the icon
			if addon.BF.runescrollfortitude.icon == "Interface\\Icons\\INV_Misc_QuestionMark" then
				addon.BF.runescrollfortitude.icon = ITT[79257] -- Runescroll of Fortitude
				if addon.BF.runescrollfortitude.icon == "Interface\\Icons\\INV_Misc_QuestionMark" then
					return true
				end
			end
			return false
		end,
		itemcheck = {
			item = "79257", -- Runescroll of Fortitude
			min = 0,
			frequency = 60 * 5,
			frequencymissing = 60 * 5,
		},
		pre = function(self, raid, report)
			if raid.ClassNumbers.PRIEST > 0 or 
			   raid.ClassNumbers.WARLOCK > 0 or 
			   not raid.israid or raid.isbattle then
				return
			end
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PRIEST > 0 or
			   raid.ClassNumbers.WARLOCK > 0 
			   then
				return
			end
			report.checking.runescrollfortitude = true
			local missing = true
			for _,f in pairs(fortitude) do
			  if unit.hasbuff[f] then
			    missing = false
			    break
			  end
			end
			if unit.hasbuff[BS[111922]] or    -- Fortitude III
			   unit.hasbuff[BS[86507]]  or    -- Fortitude II
			   unit.hasbuff[BS[69377]]  then  -- Fortitude I
		 	  missing = false 
			end
			if missing then
				table.insert(report.runescrollfortitudelist, name)
			end
		end,
		post = nil,
		icon = ITT[79257], -- Runescroll of Fortitude
		update = function(self)
			addon:DefaultButtonUpdate(self, report.runescrollfortitudelist, profile.checkrunescrollfortitude, report.checking.runescrollfortitude or false, addon.BF.runescrollfortitude:buffers())
		end,
		click = function(self, button, down)
			local scroll = ITN[79257] -- Runescroll of Fortitude III
			if not addon:GotReagent(scroll) then -- use the best available
			  scroll = ITN[62251] -- Runescroll of Fortitude II
			end
			if not addon:GotReagent(scroll) then -- use the best available
			  scroll = ITN[49632] -- Runescroll of Fortitude
			end
			addon:ButtonClick(self, button, down, "runescrollfortitude", nil, nil, scroll)
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.runescrollfortitudelist, nil, addon.BF.runescrollfortitude:buffers())
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = function(reportl, prefix)
			local thebuffers = addon.BF.runescrollfortitude:buffers()
			if thebuffers then
			   generic_whispertobuff(reportl, prefix, nil, thebuffers, ITN[49632])
			end
		end,
		buffers = function()
			local thebuffers = {}
			for _,rc in pairs(raid.classes) do
				for name,_ in pairs(rc) do
					local items = addon:ItemQuery("runescrollfortitude", name) or 0
					if items > 0 then
						table.insert(thebuffers, name .. "(" .. items .. ")")
					end
				end
			end
			return thebuffers
		end,
		consumable = true,
	},

	levitate = {
		order = 320,
		list = "levitatelist",
		check = "checklevitate",
		default = false,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = false,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		buffinfo = { { "PRIEST", 1706, 1 }, { "MAGE", 130, 2 } },
		class = { PRIEST = true, MAGE = true },
		chat = BS[1706], -- Levitate
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PRIEST > 0 or raid.ClassNumbers.MAGE > 0 then
				report.checking.levitate = true
				if not unit.hasbuff[BS[1706]] and not unit.hasbuff[BS[130]] then
					table.insert(report.levitatelist, name)
				end
			end
		end,
		post = function(self, raid, report)
			table.sort(report.levitatelist)
		end,
		icon = BSI[1706], -- Levitate
		update = function(self)
			addon:DefaultButtonUpdate(self, report.levitatelist, profile.checklevitate, report.checking.levitate or false, generic_buffers("levitate"))
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "levitate", player_spell("levitate"), true)
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.levitatelist, nil, generic_buffers("levitate"))
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = generic_whispertobuff,
		singletarget = true,
	},

	dkpresence = {
		order = 395,
		list = "dkpresencelist",
		check = "checkdkpresence",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		selfonlybuff = true,
		timer = false,
		class = { DEATHKNIGHT = true, },
		chat = L["Death Knight Presence"],
		main = function(self, name, class, unit, raid, report)
			if class ~= "DEATHKNIGHT" then
				return
			end
			report.checking.dkpresence = true
			local presence = unithasbuff(unit, dkpresences)
			if not presence then
				table.insert(report.dkpresencelist, name)
			elseif (unit.istank and presence ~= blood_presence) or
			       (not unit.istank and presence == blood_presence) then
				table.insert(report.dkpresencelist, name.."("..presence..")")
			end
		end,
		post = nil,
		icon = BSI[48266], -- Blood presence
		update = function(self)
			addon:DefaultButtonUpdate(self, report.dkpresencelist, profile.checkdkpresence, report.checking.dkpresence or false, report.dkpresencelist)
		end,
		click = function(self, button, down)
                        local name = UnitName("player")
                        local spec = raid.classes.DEATHKNIGHT[name] and raid.classes.DEATHKNIGHT[name].spec
			addon:ButtonClick(self, button, down, "dkpresence", spec and dkpresences[spec])
		end,
		tip = function(self)
			addon:Tooltip(self, L["Death Knight Presence"], report.dkpresencelist)
		end,
		partybuff = nil,
	},

	warrstance = {
		order = 394,
		list = "warrstancelist",
		check = "checkwarrstance",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		selfonlybuff = true,
		timer = false,
		class = { WARRIOR = true, },
		chat = L["Warrior Stance"],
		main = function(self, name, class, unit, raid, report)
			if class ~= "WARRIOR" then
				return
			end
			report.checking.warrstance = true
			local stance = unithasbuff(unit, warrstances)
			if not stance then
				table.insert(report.warrstancelist, name)
			elseif (unit.istank and stance ~= defensive_stance) or
			       (not unit.istank and stance == defensive_stance) then
				table.insert(report.warrstancelist, name.."("..stance..")")
			end
		end,
		post = nil,
		icon = BSI[2457], -- Battle Stance
		update = function(self)
			addon:DefaultButtonUpdate(self, report.warrstancelist, profile.checkwarrstance, report.checking.warrstance or false, report.warrstancelist)
		end,
		click = function(self, button, down)
                        local name = UnitName("player")
                        local unit = raid.classes.WARRIOR[name]
			addon:ButtonClick(self, button, down, "warrstance", unit and unit.istank and warrstances[1] or warrstances[2])
		end,
		tip = function(self)
			addon:Tooltip(self, L["Warrior Stance"], report.warrstancelist)
		end,
		partybuff = nil,
	},


	beacon = {
		order = 393,
		list = "beaconlist",
		check = "checkbeacon",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		selfonlybuff = true,
		timer = false,
		class = { PALADIN = true, },
		beaconspells = { 53563, 156910 },
		chat = BS[53563].."/"..BS[156910], -- Beacon of light/beacon of faith
		pre = function(self, raid, report)
			initreporttable("gavebeacon")
			report.gavebeacon.invert_table = true
			report.hpallys = wipe(report.hpallys or {})
    			for name,unit in pairs(raid.classes.PALADIN) do
			  if unit.spec == 1 then -- holy
			    if unit.talents and unit.tinfo and unit.tinfo.talents 
			       and unit.tinfo.talents[21668] -- beacon of faith talentid
			      then
			      report.hpallys[name] = 2 -- has both beacons
			    else -- no talent or missing info, assume light only
			      report.hpallys[name] = 1 
			    end
			  end
			end
			report.beaconunknown1 = 0
			report.beaconunknown2 = 0
			if next(report.hpallys) then
				report.checking.beacon = true
			end
		end,
		recordcaster = function(bidx, caster, name)
			-- bidx is the beacon index: 1 = light, 2 = faith
			if not caster or #caster == 0 then
				local unknownctr = "beaconunknown"..bidx
				report[unknownctr] = (report[unknownctr] or 0) + 1
				caster = "?"..report[unknownctr]
			end
			caster = caster .. string.rep(" ",bidx-1) -- append whitespace for uniqueness
			report.gavebeacon[caster] = name
		end,
		main = function(self, name, class, unit, raid, report)
			-- beacon is particularly gross becuse one unit can have multiple beacons
			-- also when targets are ranged/phased we can't tell who cast their beacon buff
		    for bidx, spellid in ipairs(addon.BF.beacon.beaconspells) do
			local hasbuff = unit.hasbuff[BS[spellid]]
			if hasbuff then
			   if hasbuff.casterlist then
				for _,caster in pairs(hasbuff.casterlist) do
					addon.BF.beacon.recordcaster(bidx, caster, name)
				end
			   else
				addon.BF.beacon.recordcaster(bidx, hasbuff.caster, name)
			   end
			end
		    end
		end,
		post = function(self, raid, report)
			report.beaconmissing1 = 0
			report.beaconmissing2 = 0
			for caster, cnt in pairs(report.hpallys) do -- pass 1: see how many are missing
			  for bidx=1,cnt do
			    if not report.gavebeacon[caster..string.rep(" ",bidx-1)] then
			      local missingctr = "beaconmissing"..bidx
			      report[missingctr] = report[missingctr] + 1
			      report["beaconmissingcaster"..bidx] = caster
			    end
			  end
			end
			for bidx=1,2 do -- pass 2: build the slacker list
			  if report["beaconmissing"..bidx] == report["beaconunknown"..bidx] then -- we see the right number of beacons
			    if report["beaconmissing"..bidx] == 1 then -- fixup report list if we can
				local bogusentry = "?1"..string.rep(" ",bidx-1)
				report.gavebeacon[report["beaconmissingcaster"..bidx]] = report.gavebeacon[bogusentry]
				report.gavebeacon[bogusentry] = nil
			    end
			  else
			    for caster, cnt in pairs(report.hpallys) do 
			      if cnt >= bidx and not report.gavebeacon[caster..string.rep(" ",bidx-1)] then
				table.insert(report.beaconlist, caster)
				report.hpallys[caster] = 0 -- prevent duplicates in list
			      end
			    end
			  end
			end
		end,
		icon = BSI[53563], -- Beacon of light
		update = function(self)
			addon:DefaultButtonUpdate(self, report.beaconlist, profile.checkbeacon, report.checking.beacon or false, report.beaconlist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "beacon")
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.beaconlist, 
						nil, nil, nil, nil, nil, nil,
						report.gavebeacon)
		end,
		partybuff = nil,
	},

	shadowform = {
		order = 387,
		list = "shadowformlist",
		check = "checkshadowform",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		selfonlybuff = true,
		timer = false,
		class = { PRIEST = true, },
		chat = BS[15473], -- Shadowform
		main = function(self, name, class, unit, raid, report)
			if class == "PRIEST" then
				if raid.classes.PRIEST[name].spec == 3 then -- Shadowform
					report.checking.shadowform = true
					if not unit.hasbuff[BS[15473]] then -- Shadowform
						table.insert(report.shadowformlist, name)
					end
				end
			end
		end,
		post = nil,
		icon = BSI[15473], -- Shadowform
		update = function(self)
			addon:DefaultButtonUpdate(self, report.shadowformlist, profile.checkshadowform, report.checking.shadowform or false, report.shadowformlist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "shadowform", BS[15473]) -- Shadowform
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.shadowformlist)
		end,
		partybuff = nil,
	},

	boneshield = {
		order = 385,
		list = "boneshieldlist",
		check = "checkboneshield",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		selfonlybuff = true,
		timer = false,
		class = { DEATHKNIGHT = true, },
		chat = BS[49222], -- Bone Shield
		main = function(self, name, class, unit, raid, report)
			if class == "DEATHKNIGHT" then
				if raid.classes.DEATHKNIGHT[name].spec == 1 then
					report.checking.boneshield = true
					if not unit.hasbuff[BS[49222]] then -- Bone Shield
						table.insert(report.boneshieldlist, name)
					end
				end
			end
		end,
		post = nil,
		icon = BSI[49222], -- Bone Shield
		update = function(self)
			addon:DefaultButtonUpdate(self, report.boneshieldlist, profile.checkboneshield, report.checking.boneshield or false, report.boneshieldlist)
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "boneshield", BS[49222]) -- Bone Shield
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.boneshieldlist) -- Bone Shield
		end,
		partybuff = nil,
	},

	shamanshield = {
		order = 355,
		list = "shamanshieldlist",
		check = "checkshamanshield",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { SHAMAN = true, },
		chat = BS[52127] .. "/" .. BS[324], -- Water Shield/Lightning Shield
		main = function(self, name, class, unit, raid, report)
			if class ~= "SHAMAN" then
				return
			end
			report.checking.shamanshield = true

			local missing = true
			if unit.hasbuff[BS[52127]] then -- Water Shield
				missing = false
			elseif unit.hasbuff[BS[324]] then -- Lightning Shield
				missing = false
			end
			if missing then
				table.insert(report.shamanshieldlist, name)
			end
		end,
		post = nil,
		icon = BSI[52127], -- Water Shield 
		update = function(self)
			addon:DefaultButtonUpdate(self, report.shamanshieldlist, profile.checkshamanshield, report.checking.shamanshield or false, report.shamanshieldlist)
		end,
		click = function(self, button, down)
			local buffspell
			local name = UnitName("player")
			local spec = raid.classes.SHAMAN[name] and raid.classes.SHAMAN[name].spec
			if spec == 1 or spec == 2 then
			  buffspell = 324 -- Lightning Shield
			elseif spec == 3 then
			  buffspell = 52127 -- Water Shield
			end
			addon:ButtonClick(self, button, down, "shamanshield", buffspell)
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.shamanshieldlist)
		end,
		partybuff = nil,
		singletarget = true,
	},

	drumskings = {
		order = 455,
		list = "drumskingslist",
		check = "checkdrumskings",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		core = true,
		chat = BS[69378], -- Blessing of Forgotten Kings
		iconfix = function(self)  -- to handle when server is slow to get the icon
			if addon.BF.drumskings.icon == "Interface\\Icons\\INV_Misc_QuestionMark" then
				addon.BF.drumskings.icon = ITT[49633] -- Drums of Forgotten Kings
				if addon.BF.drumskings.icon == "Interface\\Icons\\INV_Misc_QuestionMark" then
					return true
				end
			end
			return false
		end,
		itemcheck = {
			item = "49633", -- Drums of Forgotten Kings
			min = 0,
			frequency = 60 * 5,
			frequencymissing = 60 * 5,
		},
		pre = function(self, raid, report)
			if not addon:UseDrumsKings(raid) or raid.isbattle then
				return
			end
		end,
		main = function(self, name, class, unit, raid, report)
			if not addon:UseDrumsKings(raid) then
				return
			end
			report.checking.drumskings = true
			if not unit.hasbuff[BS[69378]] and not unithasbuff(unit, statbuff) then -- forgotten kings
				table.insert(report.drumskingslist, name)
			end
		end,
		post = nil,
		icon = ITT[49633], -- Drums of Forgotten Kings
		update = function(self)
			addon:DefaultButtonUpdate(self, report.drumskingslist, profile.checkdrumskings, report.checking.drumskings or false, addon.BF.drumskings:buffers())
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "drumskings", nil, nil, ITN[49633]) -- Drums of Forgotten Kings
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.drumskingslist, nil, addon.BF.drumskings:buffers())
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		raidwidebuff = true,
		whispertobuff = function(reportl, prefix)
			local thebuffers = addon.BF.drumskings:buffers()
			if thebuffers then
			   generic_whispertobuff(reportl, prefix, nil, thebuffers, BS[69378])
			end
		end,
		buffers = function()
			local thebuffers = {}
			for _,rc in pairs(raid.classes) do
				for name,_ in pairs(rc) do
					local items = addon:ItemQuery("drumskings", name) or 0
					if items > 0 then
						table.insert(thebuffers, name .. "(" .. items .. ")")
					end
				end
			end
			return thebuffers
		end,
		consumable = true,
	},

	checkpet = {
		order = 330,
		list = "petlist",
		check = "checkpet",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		selfonlybuff = true,
		timer = false,
		class = { WARLOCK = true, HUNTER = true, DEATHKNIGHT = true, MAGE = true, },
		chat = BS[883]:gsub("%s*%d+$",""), -- Call Pet
		main = function(self, name, class, unit, raid, report)
			local needspet = false
			local haspet = false
			if class == "HUNTER" then
				needspet = not unit.hasbuff[BS[155228]] -- Lone Wolf
			elseif class == "WARLOCK" then
				needspet = not unit.hasbuff[BS[108503]] -- Grimoire of Sacrifice
			elseif class == "DEATHKNIGHT" then
				if raid.classes.DEATHKNIGHT[name].spec == 3 then -- unholy
					needspet = true
				else
					needspet = false
				end
			elseif class == "MAGE" then
				if raid.classes.MAGE[name].spec == 3 then -- frost
					needspet = true
				else
					needspet = false
				end			
			else
				needspet = false
			end
			 
			if needspet and UnitIsVisible(unit.unitid) then
				if UnitIsUnit(unit.unitid, "player") then 
					haspet = SecureCmdOptionParse("[target=pet,dead] false; [mounted] true ; [nopet] false; true")
					haspet = (haspet == "true")
				else -- non-player
					if UnitExists(unit.unitid.."pet") then -- pet visible
						haspet = true
					elseif GetUnitSpeed(unit.unitid) > 10 or  -- mounted and moving, so cannot check (pets dont exist when mounted)
						UnitInVehicle(unit.unitid) then -- in vehicle (actually multi-passenger mnt), same thing
						haspet = true	
					elseif not IsOutdoors() then -- cannot be mounted in my zone, pet is missing
						haspet = false 
					else -- outside not moving, check for a mounted buff
						haspet = addon:UnitIsMounted(unit.unitid)
					end
				end
				report.checking.pet = true
				if not haspet then 
					table.insert(report.petlist, name)
				end
			end
			-- print(name.." needs:"..(needspet == true and "true" or "false").." has:"..(haspet == true and "true" or "false"))
		end,
		post = nil,
		icon = BSI[883], -- Call Pet
		update = function(self)
			addon:DefaultButtonUpdate(self, report.petlist, profile.checkpet, report.checking.pet or false, report.petlist)
		end,
		click = function(self, button, down)
			local class = select(2, UnitClass("player"))
			local summonspell = nil
			if class == "HUNTER" then
			  --  SecureCmdOptionParse("[target=pet,dead] Revive Pet; [nopet] Call Pet; Mend Pet")
				summonspell = SecureCmdOptionParse("[target=pet,dead] 982; [nopet] 883; 48990")
				summonspell = tonumber(summonspell)
				summonspell = BS[summonspell] 
			elseif class == "WARLOCK" then
				local spec = raid.classes.WARLOCK[UnitName("player")].spec
				if spec == 2 then -- Demo
					summonspell = BS[30146] -- Summon Felguard
				elseif spec == 3 then -- Destro
					summonspell = BS[688] -- Summon Imp
				elseif spec == 1 then -- Affliction
					summonspell = BS[691] -- Summon Felhunter
	      			else -- shrug?
					summonspell = BS[712] -- Summon Succubus	      
				end	        
			elseif class == "DEATHKNIGHT" then
				summonspell = BS[46584] -- Raise Dead
			elseif class == "MAGE" then
				summonspell = BS[31687] -- summon water elemental
			end
			addon:ButtonClick(self, button, down, "checkpet", summonspell) 
		end,
		tip = function(self)
			addon:Tooltip(self, nil, report.petlist)
		end,
		partybuff = nil,
	},

	abouttorunout = {
		order = 100,
		list = "none",
		check = "checkabouttorunout",
		default = false,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = nil,
		pre = function(self, raid, report)
			if profile.abouttorunout > 0 and profile.checkabouttorunout then
				report.checking.abouttorunout = true
			end
		end,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\Ability_Mage_Timewarp",
		update = function(self)
			addon:DefaultButtonUpdate(self, {}, profile.checkabouttorunout, report.checking.abouttorunout or false)
			if self.count:GetText() ~= "X" then
				self.count:SetText("")
			end
		end,
		click = function(self, button, down)
			addon:ButtonClick(self, button, down, "abouttorunout")
		end,
		tip = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(L["Min remaining buff duration"],1,1,1)
			GameTooltip:AddLine((L["%s minutes"]):format(profile.abouttorunout),nil,nil,nil)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L["Minimum remaining buff duration in minutes. Buffs with less than this will be considered as missing.  This option only takes affect when the corresponding 'buff' button is enabled on the dashboard."],nil,nil,nil, 1)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L["To set this option go to the addon configuration.  This button is automatically enabled when the Boss button is pressed and automatically disabled when the Trash button is pressed.  To permanently disable, choose 0 seconds as the min remaining buff duration."],nil,nil,nil,1)
			GameTooltip:Show()
		end,
		partybuff = nil,
		other = true,
	},

	tanklist = {
		order = 20,
		list = "none",
		check = "checktanklist",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = false,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = nil,
		pre = nil,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\Ability_Defend",
		update = function(self)
			self.count:SetText("")
			if #raid.TankList > 0 then
				self:SetAlpha("1")
			else
				self:SetAlpha("0.15")
			end
		end,
		click = nil,
		tip = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(L["RBS Tank List"],1,1,1)
			for _,v in ipairs(raid.TankList) do
				local class = "WARRIOR"
				local unit = addon:GetUnitFromName(v)
				if unit then
					class = unit.class
				end
				GameTooltip:AddLine(v,RAID_CLASS_COLORS[class].r,RAID_CLASS_COLORS[class].g,RAID_CLASS_COLORS[class].b,nil)
			end
			GameTooltip:Show()
		end,
		partybuff = nil,
		other = true,
	},
	help20090704 = {
		order = 10,
		list = "none",
		check = "checkhelp20090704",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = nil,
		pre = nil,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\Mail_GMIcon",
		update = function(self)
			self.count:SetText("")
		end,
		click = nil,
		tip = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(L["RBS Dashboard Help"],1,1,1)
			GameTooltip:AddLine(L["Click buffs to disable and enable."],nil,nil,nil)
			GameTooltip:AddLine(L["Shift-Click buffs to report on only that buff."],nil,nil,nil)
			GameTooltip:AddLine(L["Ctrl-Click buffs to whisper those who need to buff."],nil,nil,nil)
			GameTooltip:AddLine(L["Alt-Click on a self buff will renew that buff."],nil,nil,nil)
			GameTooltip:AddLine(L["Alt-Click on a party buff will cast on someone missing that buff."],nil,nil,nil)
			GameTooltip:AddLine(" ",nil,nil,nil)
			GameTooltip:AddLine(L["Remove this button from this dashboard in the buff options window."],nil,nil,nil)
			GameTooltip:AddLine(" ",nil,nil,nil)
			GameTooltip:AddLine(L["The above default button actions can be reconfigured."],nil,nil,nil)
			GameTooltip:AddLine(L["Press Escape -> Interface -> AddOns -> RaidBuffStatus for more options."],nil,nil,nil)
			GameTooltip:AddLine(" ",nil,nil,nil)
			GameTooltip:AddLine(L["Ctrl-Click Boss or Trash to whisper all those who need to buff."],nil,nil,nil)
			GameTooltip:Show()
		end,
		partybuff = nil,
		other = true,
	},
}

addon.BF = BF
