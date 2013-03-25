local addonName, vars = ...
local L = vars.L
local AceConfig = LibStub('AceConfigDialog-3.0')
local GI = LibStub("LibGroupInSpecT-1.0")

RaidBuffStatus = LibStub("AceAddon-3.0"):NewAddon("RaidBuffStatus", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0", "AceSerializer-3.0")
RBS_svnrev = {}
RBS_svnrev["Core.lua"] = select(3,string.find("$Revision: 614 $", ".* (.*) .*"))

local addon = RaidBuffStatus
RaidBuffStatus.L = L
RaidBuffStatus.GI = GI
RaidBuffStatus.bars = {}

local band = _G.bit.band

local buttons = {}
local optionsbuttons = {}
local optionsiconbuttons = {}
local incombat = false
local dashwasdisplayed = true
local tankList = '|'
local nextscan = 0
RaidBuffStatus.timer = false
local playerid = UnitGUID("player")
local playername = UnitName("player")
local playerclass = select(2,UnitClass("player"))
local xperltankrequest = false
local xperltankrequestt = 0
local nextfeastannounce = {}
local nextcauldronannounce = 0
local nexttableannounce = 0
local nextsoulannounce = 0
local nextrepairannounce = 0
local nextblingannounce = 0
local nextdurability = 0
local nextitemcheck = 0
local currentsheep = {}
local currentsheepspell = {}
local lasthealerdrinking = 0
RaidBuffStatus.lasttobuf = ""
RaidBuffStatus.version = ""
RaidBuffStatus.revision = ""
RaidBuffStatus.rbsversions = {}
local toldaboutnewversion = false
local toldaboutrbsuser = {}
RaidBuffStatus.durability = {}
RaidBuffStatus.broken = {}
RaidBuffStatus.itemcheck = {}
RaidBuffStatus.soulwelllastseen = 0
RaidBuffStatus.rezerrezee = {}
RaidBuffStatus.rezeetime = {}
RaidBuffStatus.lastweapcheck = {}

-- babblespell replacement using GetSpellInfo(key)
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

-- List originally copied from BigBrother addon (Thanks BB)
local ccspells = {
--	BS[118], -- Polymorph (needs workaround)
	BS[9484], -- Shackle Undead
	BS[2637], -- Hibernate
	BS[3355], -- Freezing Trap (Effect)
	BS[6770], -- Sap
	BS[20066], -- Repentance
--	BS[5782], -- Fear (needs workaround)
	BS[2094], -- Blind
	BS[51514], -- Hex
--	BS[61305], -- Polymorph (Black Cat) (needs workaround)
--	BS[28272], -- Polymorph (Pig) (needs workaround)
--	BS[28271], -- Polymorph (Turtle) (needs workaround)
--	BS[61721], -- Polymorph (Rabbit) (needs workaround)
--	BS[61780], -- Polymorph (Turkey) (needs workaround)
	BS[76780], -- Bind Elemental
	BS[6358], -- Seduction
	BS[115268], -- Mesmerize
--	BS[339], -- Entangling Roots (needs workaround)
	BS[1513], -- Scare Beast
	BS[10326], -- Turn Evil
	BS[19386], -- Wyvern Sting
	BS[115078], -- Paralysis (Monk)
}
local ccspellshash = {} -- much faster matching than a loop
for _, spell in ipairs(ccspells) do
	ccspellshash[spell] = true
end

local workaroundbugccspells = {
	BS[118], -- Polymorph
	BS[61305], -- Polymorph (Black Cat)
	BS[28272], -- Polymorph (Pig)
	BS[28271], -- Polymorph (Turtle)
	BS[61721], -- Polymorph (Rabbit)
	BS[61780], -- Polymorph (Turkey)
	BS[5782], -- Fear
	BS[339], -- Entangling Roots
}
local workaroundbugccspellshash = {}
for _, spell in ipairs(workaroundbugccspells) do
	workaroundbugccspellshash[spell] = true
end

local rezspells = {
	BS[20484], -- Rebirth (Druid brez)
	BS[61999], -- Raise Ally (DK)
	BS[20707], -- Soulstone (Warlock)
	BS[7328], -- Redemption (Paladin)
	BS[2006], -- Resurrection (Priest)
	BS[2008], -- Ancestral Spirit (Shaman)
	BS[50769], -- Revive (Druid)
	BS[115178], -- Resuscitate (Monk)
	BS[8342], -- Defibrillate (Goblin Jumper Cables)
	BS[22999], -- Defibrillate (Goblin Jumper Cables XL)
	BS[54732], -- Defribillate (Gnomish Army Knife)
	BS[83968], -- Mass Resurrection
}
local rezspellshash = {}
for _, spell in ipairs(rezspells) do
	rezspellshash[spell] = true
end
local rezclasses = { DRUID=true, PALADIN=true, PRIEST=true, SHAMAN=true, MONK=true }

local taunts = {
	-- Death Knights
	56222, -- Dark Command
--	49576, -- Death Grip
	51399, -- Death Grip (taunted)
	-- Warrior
	1161, -- Challenging Shout
	355, -- Taunt
	21008, -- Mocking Blow
	-- Druid
	5209, -- Challenging Roar
	6795, -- Growl
	-- Paladin
	31790, -- Righteous Defense
	62124, -- Hand of Reckoning
	-- Monk
	116189, -- Provoke 
	-- Hunter
	20736, -- Distracting Shot
}
local taunthash = {}
for _, spell in ipairs(taunts) do
	taunthash[spell] = true
end

local feastdata = {
	-- cata
	[57426] = { limit=50, }, -- Fish Feast
	[87643] = { limit=50, }, -- Broiled Dragon Feast
	[87915] = { limit=50, }, -- Goblin Barbecue Feast
	[87644] = { limit=50, }, -- Seafood Magnifique Feast

	-- mop
	[126503] = { limit=10, },   -- Banquet of the Brew
	[126504] = { limit=25, },   -- Great Banquet of the Brew
	[126492] = { limit=10, bonus="STRENGTH" },  -- Banquet of the Grill
	[126494] = { limit=25, bonus="STRENGTH" },  -- Great Banquet of the Grill
	[126501] = { limit=10, bonus="STAMINA" },   -- Banquet of the Oven
	[126502] = { limit=25, bonus="STAMINA" },   -- Great Banquet of the Oven
	[126497] = { limit=10, bonus="INTELLECT" }, -- Banquet of the Pot
	[126498] = { limit=25, bonus="INTELLECT" }, -- Great Banquet of the Pot
	[126499] = { limit=10, bonus="SPIRIT" },    -- Banquet of the Steamer
	[126500] = { limit=25, bonus="SPIRIT" },    -- Great Banquet of the Steamer
	[126495] = { limit=10, bonus="AGILITY" },   -- Banquet of the Wok
	[126496] = { limit=25, bonus="AGILITY" },   -- Great Banquet of the Wok
	[104958] = { limit=10, },   -- Pandaren Banquet
	[105193] = { limit=25, },   -- Great Pandaren Banquet
}
function RaidBuffStatus:UpdateFeastData()
  for id,info in pairs(feastdata) do
    if type(id) == "number" then
	info.name = BS[id]
	info.id = id
	feastdata[info.name] = info
    end
  end
  RaidBuffStatus.feastdata = feastdata
end
RaidBuffStatus:UpdateFeastData()

local function AddTTFeastBonus(self)
  local name, link = self:GetItem()
  --local id = name and link and link:match("\124Hitem:(\d+):")
  --id = id and tonumber(id)
  local info = name and feastdata[name]
  if info and info.bonus and RaidBuffStatus.db.profile.FeastTT then
    local btext = _G["ITEM_MOD_"..info.bonus.."_SHORT"]
    if btext then
      self:AddDoubleLine(name,L["Bonus"].." "..btext)   
      self:Show()
     end
  end
end

local classes = CLASS_SORT_ORDER

local raid = { }
RaidBuffStatus.raid = raid
raid.reset = function()
	raid.classes = raid.classes or {}
	for _,cl in ipairs(classes) do
	  raid.classes[cl] = raid.classes[cl] or {}
	  wipe(raid.classes[cl])
	end
	raid.ClassNumbers = raid.ClassNumbers or {}; wipe(raid.ClassNumbers)
	raid.BuffTimers = raid.BuffTimers or {}; wipe(raid.BuffTimers)
	raid.TankList = raid.TankList or {}; wipe(raid.TankList)
	raid.ManaList = raid.ManaList or {}; wipe(raid.ManaList)
	raid.DPSList = raid.DPSList or {}; wipe(raid.DPSList)
	raid.HealerList = raid.HealerList or {}; wipe(raid.HealerList)
	raid.guilds = raid.guilds or {}; wipe(raid.guilds)
	raid.LastDeath = raid.LastDeath or {}; wipe(raid.LastDeath)
	raid.israid = false
	raid.isparty = false
	raid.islfg = false
	raid.isbattle = false
	raid.readid = 0
	raid.size = 1
	raid.pug = false
	raid.leadername = ""
	for _,class in ipairs(classes) do
	  raid.ClassNumbers[class] = 0
	end
	if RaidBuffStatus.CleanLockSoulStone then
	   RaidBuffStatus:CleanLockSoulStone()
	end
end
RaidBuffStatus.raid = raid
raid.reset()

local unknownicon = "Interface\\Icons\\INV_Misc_QuestionMark"
local specicons = {
	UNKNOWN = unknownicon,
}

local classicons = {}
for _,cl in ipairs(classes) do
  local m = cl:gsub("^(.)(.+)$",function(p,s) return p..s:lower() end) -- mixed case
  m = m:gsub("knight","Knight")
  classicons[cl] = "Interface\\Icons\\ClassIcon_"..m
end
classicons.UNKNOWN = unknownicon

local role_tex_file = "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES"
local roleicons = {
	MeleeDPS =  "Interface\\Icons\\INV_Sword_04",
	RangedDPS = "Interface\\Icons\\ability_marksmanship",
	Tank =      { file = role_tex_file, coords = {0,19/64,22/64,41/64} },
	Healer =    { file = role_tex_file, coords = {20/64,39/64,1/64,20/64} },
	UNKNOWN =   unknownicon,
}

local tfi = {
	namewidth = 210,
	classwidth = 55,
	specwidth = 55,
	rolewidth = 55,
	specialisationswidth = 210,
	gap = 2,
	edge = 5,
	inset = 3,
	topedge = 45,
	rowheight = 17,
	rowgap = 0,
	maxrows = 40,
	okbuttonheight = 55,
	rowdata = {},
	rowframes = {},
	buttonsize = 15,
	sort = "role",
	sortorder = 1,
}
RaidBuffStatus.tfi = tfi
tfi.namex = tfi.edge
tfi.classx = tfi.namex + tfi.namewidth + tfi.gap
tfi.specx = tfi.classx + tfi.classwidth + tfi.gap
tfi.rolex = tfi.specx + tfi.specwidth + tfi.gap
tfi.specialisationsx = tfi.rolex + tfi.rolewidth + tfi.gap
tfi.framewidth = tfi.specialisationsx + tfi.specialisationswidth + tfi.edge
tfi.rowwidth = tfi.framewidth - tfi.edge - tfi.edge - tfi.inset - tfi.inset

-- diameter of the Minimap in game yards at
-- the various possible zoom levels
-- from Astrolabe
local MinimapSize = {
	indoor = {
		[0] = 300, -- scale -- this one is wrong but I don't know the correct value
		[1] = 240, -- 1.25
		[2] = 180, -- 5/3
		[3] = 120, -- 2.5
		[4] = 80,  -- 3.75
		[5] = 50,  -- 6
	},
	outdoor = {
		[0] = 466 + 2/3, -- scale
		[1] = 400,       -- 7/6
		[2] = 333 + 1/3, -- 1.4
		[3] = 266 + 2/6, -- 1.75
		[4] = 200,       -- 7/3
		[5] = 133 + 1/3, -- 3.5
	},
}

local report = {
	checking = {},
	RaidHealth = 100,
	RaidMana = 100,
	DPSMana = 100,
	HealerMana = 100,
	TankHealth = 100,
	Alive = 100,
	Dead = 0,
	TanksAlive = 100,
	HealersAlive = 100,
	HealersAliveCount = 0,
	HealersAliveCountNumber = 0,
	Range = 100,
	HealerManaIsDrinking = 0,
	HealerInRange = 0,
	raidhealthlist = {},
	raidmanalist = {},
	dpsmanalist = {},
	healermanalist = {},
	tankhealthlist = {},
	alivelist = {}, -- actually dead list
	tanksalivelist = {}, -- actually dead list
	healersalivelist = {}, -- actually dead list
	rangelist = {}, -- actually people out of range list
}
report.reset = function()
	for reportname,_ in pairs(report) do
		if type(report[reportname]) == "number" then
			report[reportname] = 0
		elseif type(report[reportname]) == "table" then
			wipe(report[reportname])
		end
	end
end
RaidBuffStatus.report = report

-- End of inits


function RaidBuffStatus:OnInitialize()
	RaidBuffStatus.profiledefaults = { profile = {
		options = {},
		TellWizard = true,
		ReportSelf = false,
		ReportChat = true,
		ReportOfficer = false,
		PrependRBS = false,
		ShowMany = true,
		WhisperMany = true,
		HowMany = 4,
		HowOften = 3,
		foodlevel = 250,
		OldFlasksElixirs = false,
		FeastTT = true,
		ShowGroupNumber = false,
--		ShowMissingBlessing = true,
		whisperonlyone = true,
		abouttorunout = 3,
		preferstaticbuff = true,
		LockWindow = false,
		IgnoreLastThreeGroups = false,
		DisableInCombat = true,
		HideInCombat = true,
		LeftClick = "enabledisable",
		RightClick = "buff",
		ControlLeftClick = "whisper",
		ControlRightClick = "none",
		ShiftLeftClick = "report",
		ShiftRightClick = "none",
		AltLeftClick = "buff",
		AltRightClick = "none",
		onlyusetanklist = false,
		tankwarn = false,
		bossonly = false,
		failselfimmune = true,
		failsoundimmune = true,
		failrwimmune = false,
		failraidimmune = true,
		failpartyimmune = false,
		failselfresist = true,
		failsoundresist = true,
		failrwresist = false,
		failraidresist = true,
		failpartyresist = false,
		otherfailself = true,
		otherfailsound = true,
		otherfailrw = false,
		otherfailraid = false,
		otherfailparty = false,
		ninjaself = true,
		ninjasound = true,
		ninjarw = false,
		ninjaraid = false,
		ninjaparty = false,
		tauntself = true,
		tauntsound = true,
		tauntrw = false,
		tauntraid = false,
		tauntparty = false,
		tauntmeself = true,
		tauntmesound = true,
		tauntmerw = false,
		tauntmeraid = false,
		tauntmeparty = false,
		nontanktauntself = true,
		nontanktauntsound = true,
		nontanktauntrw = false,
		nontanktauntraid = false,
		nontanktauntparty = false,
		ccwarn = true,
		cconlyme = false,
		ccwarntankself = false,
		ccwarntanksound = false,
		ccwarntankrw = false,
		ccwarntankraid = false,
		ccwarntankparty = false,
		ccwarnnontankself = true,
		ccwarnnontanksound = true,
		ccwarnnontankrw = false,
		ccwarnnontankraid = false,
		ccwarnnontankparty = false,
		misdirectionwarn = false,
		misdirectionself = true,
		misdirectionsound = true,
		deathwarn = true,
		tankdeathself = true,
		tankdeathsound = true,
		tankdeathrw = false,
		tankdeathraid = false,
		tankdeathparty = false,
		rangeddpsdeathself = true,
		rangeddpsdeathsound = true,
		rangeddpsdeathrw = false,
		rangeddpsdeathraid = false,
		rangeddpsdeathparty = false,
		meleedpsdeathself = true,
		meleedpsdeathsound = true,
		meleedpsdeathrw = false,
		meleedpsdeathraid = false,
		meleedpsdeathparty = false,
		healerdeathself = true,
		healerdeathsound = true,
		healerdeathrw = false,
		healerdeathraid = false,
		healerdeathparty = false,
		RaidHealth = false,
		TankHealth = true,
		RaidMana = false,
		HealerMana = true,
		healerdrinkingsound = false,
		DPSMana = true,
		Alive = false,
		Dead = false,
		TanksAlive = false,
		HealersAlive = false,
		Range = true,
		bgr = 0,
		bgg = 0,
		bgb = 0,
		bga = 0.85,
		bbr = 0,
		bbg = 0,
		bbb = 0,
		bba = 1,
		x = 0,
		y = 0,
		MiniMap = true,
		AutoShowDashParty = true,
		AutoShowDashRaid = true,
		AutoShowDashBattle = false,
		MiniMapAngle = random(0, 359),
		dashcols = 6,
		dashscale = 1.0,
		optionsscale = 1.0,
		ShortenNames = false,
		HighlightMyBuffs = true,
		movewithaltclick = false,
		hidebossrtrash = false,
		Debug = false,
		feasts = true,
		refreshmenttable = true,
		soulwell = true,
		repair = true,
		bling = true,
		antispam = true,
		nonleadspeak = false,
		feastautowhisper = true,
		cauldrons = true,
		cauldronsautowhisper = false,
		wellautowhisper = false,
		versionannounce = true,
		userannounce = false,
		guildmembers = false,
		friends = false,
		bnfriends = false,
		aiwguildmembers = false,
		aiwfriends = false,
		aiwbnfriends = false,
		cooldowns = {
			soulstone = {},
		},
		statusbarpositioning = "onedown",
		groupsortstyle = "three",
		buffsort = {},
	}}
	local BF = RaidBuffStatus.BF
	for buffcheck, _ in pairs(BF) do
		if BF[buffcheck].list then
			report[BF[buffcheck].list] = {} -- add empty list to report
		end
		if BF[buffcheck].default then  -- if default setting for buff check is enabled
			RaidBuffStatus.profiledefaults.profile[BF[buffcheck].check] = true
		else
			RaidBuffStatus.profiledefaults.profile[BF[buffcheck].check] = false
		end
		for _, defname in ipairs({"buff", "warning", "dash", "dashcombat", "boss", "trash"}) do
			if BF[buffcheck]["default" .. defname] then
				RaidBuffStatus.profiledefaults.profile[buffcheck .. defname] = true
			else
				RaidBuffStatus.profiledefaults.profile[buffcheck .. defname] = false
			end
		end
		RaidBuffStatus.profiledefaults.profile.buffsort[1] = "defaultorder"
		RaidBuffStatus.profiledefaults.profile.buffsort[2] = "defaultorder"
		RaidBuffStatus.profiledefaults.profile.buffsort[3] = "defaultorder"
		RaidBuffStatus.profiledefaults.profile.buffsort[4] = "defaultorder"
		RaidBuffStatus.profiledefaults.profile.buffsort[5] = "defaultorder"
	end
	RaidBuffStatusDefaultProfile = RaidBuffStatusDefaultProfile or {false, "Modders: In your SavedVars, replace the first argument of this table with the profile you want loaded by default, like 'Default'."}
	self.db = LibStub("AceDB-3.0"):New("RaidBuffStatusDB", RaidBuffStatus.profiledefaults, RaidBuffStatusDefaultProfile[1])
	RaidBuffStatus.optFrame = AceConfig:AddToBlizOptions("RaidBuffStatus", "RaidBuffStatus")
	self.configOptions.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	GI.RegisterCallback(self, "GroupInSpecT_Update")
--	RaidBuffStatus:Debug('Init, init?')
end

-- credit for original code goes to Peragor and GridLayoutPlus
function RaidBuffStatus:oRA_MainTankUpdate()
--	RaidBuffStatus:Debug('oRA_MainTankUpdate()')
	-- oRa2 and CT raid integration: get list of unitids for configured tanks
	local tankTable = nil
	tankList = '|'
	if oRA and oRA.maintanktable then
		tankTable = oRA.maintanktable
		RaidBuffStatus:Debug('Using ora')
	elseif XPerl_MainTanks then
		tankTable = {}
		for _,v in pairs(XPerl_MainTanks) do
			tankTable[v[2]] = v[2]
		end
		RaidBuffStatus:Debug('Using xperl')
	elseif CT_RA_MainTanks then
		tankTable = CT_RA_MainTanks
		RaidBuffStatus:Debug('Using ctra')
	end
	if tankTable then
		for key, val in pairs(tankTable) do
			local unit = RaidBuffStatus:GetUnitFromName(val)
			if unit then
				local unitid = unit.unitid
				if unitid and UnitExists(unitid) and UnitPlayerOrPetInRaid(unitid) then
					tankList = tankList .. val .. '|'
				end
			end
		end
	end
end

function RaidBuffStatus:ShowReportFrame()
	if (InCombatLockdown()) then
		return
	end
	ShowUIPanel(RBSFrame)
end

function RaidBuffStatus:HideReportFrame()
	if (InCombatLockdown()) then
		return
	end
	HideUIPanel(RBSFrame)
end

function RaidBuffStatus:ToggleOptionsFrame()
	if (InCombatLockdown()) then
		return
	end
	if RaidBuffStatus.optionsframe:IsVisible() then
		HideUIPanel(RBSOptionsFrame)
	else
		RaidBuffStatus:ShowOptionsFrame()
	end
end

function RaidBuffStatus:ShowOptionsFrame()
	RaidBuffStatus:UpdateOptionsButtons()
	ShowUIPanel(RBSOptionsFrame)
end

function RaidBuffStatus:ToggleTalentsFrame()
	if RaidBuffStatus.talentframe:IsVisible() then
		HideUIPanel(RBSTalentsFrame)
	else
		RaidBuffStatus:ShowTalentsFrame()
	end
end

function RaidBuffStatus:ShowTalentsFrame()
	RaidBuffStatus:UpdateTalentsFrame()
	ShowUIPanel(RBSTalentsFrame)
end

function RaidBuffStatus:UpdateMiniMapButton()
	if RaidBuffStatus.db.profile.MiniMap then
		RBSMinimapButton:UpdatePosition()
		RBSMinimapButton:Show()
	else
		RBSMinimapButton:Hide()
	end
end

function RaidBuffStatus:UpdateTalentsFrame()
	local height = tfi.topedge + (raid.size * (tfi.rowheight + tfi.rowgap)) + tfi.okbuttonheight
	RaidBuffStatus.talentframe:SetHeight(height)
	for i = 1, tfi.maxrows do
		tfi.rowframes[i].rowframe:Hide()
	end
	if not raid.israid and not raid.isparty then
		return
	end
	RaidBuffStatus:GetTalentRowData()
	RaidBuffStatus:SortTalentRowData(tfi.sort, tfi.sortorder)
	RaidBuffStatus:CopyTalentRowDataToRowFrames()
	for i = 1, raid.size do
		tfi.rowframes[i].rowframe:Show()
	end
end

local function sortby_name_localized(a,b)
  return a.name_localized < b.name_localized
end

function RaidBuffStatus:GetTalentRowData()
	tfi.rowdata = {}
	local majortmp = {}
	local minortmp = {}
	local row = 1
	for class,_ in pairs(raid.classes) do
		for name,_ in pairs(raid.classes[class]) do
			local unit = raid.classes[class][name]
			local role = ""
			local roleicon = roleicons.UNKNOWN
			if unit.istank then
				role = L["Tank"]
				roleicon = roleicons.Tank
			elseif unit.ishealer then
				role = L["Healer"]
				roleicon = roleicons.Healer
			elseif unit.ismeleedps then
				role = L["Melee DPS"]
				roleicon = roleicons.MeleeDPS
			elseif unit.israngeddps then
				role = L["Ranged DPS"]
				roleicon = roleicons.RangedDPS
			end
			tfi.rowdata[row] = {}
			tfi.rowdata[row].name = name
			tfi.rowdata[row].class = class
			tfi.rowdata[row].role = role
			tfi.rowdata[row].roleicon = roleicon
			tfi.rowdata[row].specialisations = {}
			tfi.rowdata[row].spec = unit.specname
			tfi.rowdata[row].specicon = unit.specicon
			if unit.talents and unit.tinfo and unit.tinfo.talents then
			  -- positions 1-6 are talents in descending tier order
			  for spellid, info in pairs(unit.tinfo.talents) do
			    local pos = 7-info.tier
			    tfi.rowdata[row].specialisations[pos] = info
			  end
			end
			-- position 7 is a spacer between talents and glyphs
			-- position 8-10 are major glyphs, 11-13 are minor glyphs
			wipe(majortmp)
			wipe(minortmp)
			if unit.talents and unit.tinfo and unit.tinfo.glyphs then
			  for spellid, info in pairs(unit.tinfo.glyphs) do
			    if info.glyph_type == GLYPH_TYPE_MAJOR then
			      table.insert(majortmp, info)
			    else
			      table.insert(minortmp, info)
			    end
			  end
			end
			table.sort(majortmp, sortby_name_localized)
			table.sort(minortmp, sortby_name_localized)
			for j = 1,3 do
			  tfi.rowdata[row].specialisations[7+j] = majortmp[j]
			  tfi.rowdata[row].specialisations[10+j] = minortmp[j]
			end
			row = row + 1
		end
	end
end

function RaidBuffStatus:SortTalentRowData(sort, sortorder)
	tfi.sort = sort
	tfi.sortorder = sortorder
	if sort == "name" then
		table.sort(tfi.rowdata, function (a,b)
			return (RaidBuffStatus:Compare(a.name, b.name, sortorder))
		end)
	elseif sort == "class" then
		table.sort(tfi.rowdata, function (a,b)
			if a.class == b.class then
				if a.specname == b.specname then
					return (RaidBuffStatus:Compare(a.name, b.name, sortorder))
				end
				return (RaidBuffStatus:Compare(a.specname, b.specname, sortorder))
			else
				return (RaidBuffStatus:Compare(a.class, b.class, sortorder))
			end
		end)
	elseif sort == "spec" then
		table.sort(tfi.rowdata, function (a,b)
			if a.specname == b.specname then
				return (RaidBuffStatus:Compare(a.class, b.class, sortorder))
			else
				return (RaidBuffStatus:Compare(a.specname, b.specname, sortorder))
			end
		end)
	elseif sort == "role" then
		table.sort(tfi.rowdata, function (a,b)
			if a.role == b.role then
				return (RaidBuffStatus:Compare(a.class, b.class, sortorder))
			else
				return (RaidBuffStatus:Compare(a.role, b.role, sortorder))
			end
		end)
	elseif sort == "specialisations" then
		table.sort(tfi.rowdata, function (a,b)
			if #a.specialisations == #b.specialisations then
				return (RaidBuffStatus:Compare(a.name, b.name, sortorder))
			end
			return (RaidBuffStatus:Compare(#a.specialisations, #b.specialisations, sortorder))
		end)
	end
end

function RaidBuffStatus:Compare(a, b, sortorder)
	if sortorder == 1 then
			return (a < b)
		else
			return (a > b)
	end
end

local function TalentButton_OnEnter(self)
     if self.spellid then
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetSpellByID(self.spellid)
	GameTooltip:Show()
     end
end
local function TalentButton_OnLeave(self)
     GameTooltip:Hide()
end

local function TalentButton_OnClick(self)
     if self.spellid then
        local link = GetSpellLink(self.spellid)
        if not link or #link == 0 then -- some glyphs cannot be linked as a spell
          return
          --local name = GetSpellInfo(self.spellid)
	  --link = "\124Hspell:"..self.spellid.."\124h["..(name or "unknown").."]\124h"
        end
        local activeEditBox = ChatEdit_GetActiveWindow();
        if activeEditBox then
           ChatEdit_InsertLink(link)
        else
          ChatFrame_OpenChat(link, DEFAULT_CHAT_FRAME)
        end
     end
end

function RaidBuffStatus:CopyTalentRowDataToRowFrames()
	for i, _ in ipairs(tfi.rowdata) do
		local class = tfi.rowdata[i].class
		local name = tfi.rowdata[i].name
		local role = tfi.rowdata[i].role
		local roleicon = tfi.rowdata[i].roleicon
		local r = RAID_CLASS_COLORS[class].r
		local g = RAID_CLASS_COLORS[class].g
		local b = RAID_CLASS_COLORS[class].b
		tfi.rowframes[i].name:SetText(name)
		tfi.rowframes[i].name:SetTextColor(r,g,b)
		tfi.rowframes[i].class:SetNormalTexture(classicons[class] or classicons.UNKNOWN)
		tfi.rowframes[i].class:SetScript("OnEnter", function() 
			RaidBuffStatus:Tooltip(tfi.rowframes[i].class, LOCALIZED_CLASS_NAMES_MALE[class], nil)
		end )
		tfi.rowframes[i].class:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
		local f = tfi.rowframes[i].role
		f.tex = f.tex or f:CreateTexture()
		f.tex:SetAllPoints()
		if type(roleicon) == "table" then
		  f.tex:SetTexture(roleicon.file)
		  f.tex:SetTexCoord(unpack(roleicon.coords))
		else
		  f.tex:SetTexture(roleicon)
		  f.tex:SetTexCoord(0,1,0,1)
		end
		f:SetNormalTexture(f.tex)
		f:SetScript("OnEnter", function() RaidBuffStatus:Tooltip(f, role, nil) end)
		f:SetScript("OnLeave", function() GameTooltip:Hide() end)
		if raid.classes[class][name].talents then
			local specname = raid.classes[class][name].specname
			local specicon = raid.classes[class][name].specicon
			tfi.rowframes[i].spec:SetScript("OnEnter", function()
				RaidBuffStatus:Tooltip(tfi.rowframes[i].spec, specname)
			end )
			tfi.rowframes[i].spec:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)
			tfi.rowframes[i].spec:SetNormalTexture(specicon or specicons.UNKNOWN)
		else
			tfi.rowframes[i].spec:SetNormalTexture(specicons.UNKNOWN)
			tfi.rowframes[i].spec:SetScript("OnEnter", function()
				RaidBuffStatus:Tooltip(tfi.rowframes[i].spec, "Unknown")
			end )
			tfi.rowframes[i].spec:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)
		end
		for j, v in ipairs (tfi.rowframes[i].specialisations) do
			v:Hide()
			v.spellid = nil
			local info = tfi.rowdata[i].specialisations[j]
			if info then
			        v.spellid = info.spell_id
				v:SetNormalTexture(info.icon)

				v:SetScript("OnEnter", TalentButton_OnEnter)
				v:SetScript("OnClick", TalentButton_OnClick)
				v:SetScript("OnLeave", TalentButton_OnLeave)
				v:Show()
			end
		end
	end
end

function RaidBuffStatus:DoReport(force)
	if force then
		nextdurability = 0
		nextitemcheck = 0
		wipe(RaidBuffStatus.lastweapcheck)
		for itemcheck, _ in pairs(RaidBuffStatus.itemcheck) do
			RaidBuffStatus.itemcheck[itemcheck].next = 0
		end
	else -- not forced
		if nextscan > GetTime() then
			return  -- ensure we don't get called many times a second
		end
		if incombat and RaidBuffStatus.db.profile.DisableInCombat then
			return  -- no buff checking in combat
		end
		if raid.isbattle and not RaidBuffStatus.frame:IsVisible() then
			return -- no buff checking in battlegrounds unless dashboard is shown
		end
	end
	nextscan = GetTime() + 1
	if xperltankrequest then
		if GetTime() > xperltankrequestt then
			RaidBuffStatus:oRA_MainTankUpdate()
			xperltankrequest = false
		end
	end
	RaidBuffStatus:CleanSheep()
	report:reset()
	RaidBuffStatus:ReadRaid()
	if (not raid.israid) and (not raid.isparty) and (not raid.isbattle) then
		RaidBuffStatus:UpdateButtons()
		return
	end
	RaidBuffStatus:CalculateReport()
	RaidBuffStatus:UpdateButtons()
	if RaidBuffStatus.talentframe:IsVisible() then
		RaidBuffStatus:UpdateTalentsFrame()
	end
	if RaidBuffStatus.tooltipupdate then
		RaidBuffStatus:tooltipupdate()
	end
	playerid = UnitGUID("player") -- this never changes but on logging in it may take time before it returns a value
	playername = UnitName("player") -- ditto
	playerclass = select(2,UnitClass("player")) -- ditto
	if not raid.isbattle and not incombat then
		if report.checking.durabilty and not _G.oRA3 and GetTime() > nextdurability then
			if #report.durabilitylist > 0 then
				nextdurability = GetTime() + 30 -- check more often if someone is broken
			else
				nextdurability = GetTime() + 60 * 5
			end
			RaidBuffStatus:SendAddonMessage("CTRA", "DURC")
		end
		if GetTime() > nextitemcheck  then
			for itemcheck, _ in pairs(RaidBuffStatus.itemcheck) do
				if report.checking[RaidBuffStatus.itemcheck[itemcheck].check] and GetTime() > RaidBuffStatus.itemcheck[itemcheck].next then
					nextitemcheck = GetTime() + 3
--					RaidBuffStatus:Debug("Item:" .. RaidBuffStatus.itemcheck[itemcheck].item)
					RaidBuffStatus:SendAddonMessage("CTRA", "ITMC " .. RaidBuffStatus.itemcheck[itemcheck].item)
					RaidBuffStatus:SendAddonMessage("oRA3", RaidBuffStatus:Serialize("InventoryCount", RaidBuffStatus.itemcheck[itemcheck].item))
					if #report[RaidBuffStatus.itemcheck[itemcheck].list] >= RaidBuffStatus.itemcheck[itemcheck].min then
						RaidBuffStatus.itemcheck[itemcheck].next = GetTime() + RaidBuffStatus.itemcheck[itemcheck].frequencymissing
					else
						RaidBuffStatus.itemcheck[itemcheck].next = GetTime() + RaidBuffStatus.itemcheck[itemcheck].frequency
					end
					break
				end
			end
		end
	end
end

function RaidBuffStatus:CalculateReport()
	local BF = RaidBuffStatus.BF
	-- PRE HERE
	for buffcheck, _ in pairs(BF) do
		if BF[buffcheck].pre then
			if RaidBuffStatus.db.profile[BF[buffcheck].check] then
				if (not incombat) or (incombat and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"]) then
					BF[buffcheck].pre(self, raid, report)
				end
			end
		end
	end

	-- MAIN HERE
	local thiszone = RaidBuffStatus:GetMyZone()
	local maxspecage = GetTime() - 60 * 2
	local healthcount = 0
	local health = 0
	local manacount = 0
	local mana = 0
	local tankhealthcount = 0
	local tankhealth = 0
	local healermanacount = 0
	local healermana = 0
	local healerdrinking = 0
	local healerinrange = 0
	local dpsmanacount = 0
	local dpsmana = 0
	local alivecount = 0
	local alive = 0
	local tanksalivecount = 0
	local tanksalive = 0
	local healersalivecount = 0
	local healersalive = 0
	local rangecount = 0
	local range = 0
	for class,_ in pairs(raid.classes) do
		for name,_ in pairs(raid.classes[class]) do
			local unit = raid.classes[class][name]
			if unit.online then
				local zonedin = true
				if raid.israid then
					if thiszone ~= unit.zone then
						zonedin = false
						if RaidBuffStatus.db.profile.checkzone then
							table.insert(report.zonelist, name)
						end
					end
				end

				for buffcheck, _ in pairs(BF) do
					if RaidBuffStatus.db.profile[BF[buffcheck].check] then
						if zonedin or BF[buffcheck].checkzonedout then
							if (not incombat) or (incombat and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"]) then
								if BF[buffcheck].main then
									BF[buffcheck].main(self, name, class, unit, raid, report)
								end
							end
						end
					end
				end
				if zonedin then
					alivecount = alivecount + 1
					if unit.isdead then
						report.alivelist[name] = L["Dead"]
						if unit.istank then
							report.tanksalivelist[name] = L["Dead"]
							tanksalivecount = tanksalivecount + 1
						elseif unit.ishealer then
							report.healersalivelist[name] = L["Dead"]
							healersalivecount = healersalivecount + 1
						end
					else
						alive = alive + 1
						local h = math.floor(UnitHealth(unit.unitid)/UnitHealthMax(unit.unitid)*100)
						local m = math.floor(UnitMana(unit.unitid)/UnitManaMax(unit.unitid)*100)
						health = health + h
						healthcount = healthcount + 1
						if h < 100 then
							report.raidhealthlist[name] = h
						end
						if unit.hasmana then
							mana = mana + m
							manacount = manacount + 1
							if m < 100 then
								report.raidmanalist[name] = m
							end
						end
						if unit.istank then
							tankhealth = tankhealth + h
							tankhealthcount = tankhealthcount + 1
							if h < 100 then
								report.tankhealthlist[name] = h
							end
							tanksalivecount = tanksalivecount + 1
							tanksalive = tanksalive + 1
						end
						if unit.ishealer then  -- all healers have mana
							healermana = healermana + m
							healermanacount = healermanacount + 1
							if m < 100 then
								if unit.hasbuff[BS[430]] and m < 95 then  -- Drink
									healerdrinking = healerdrinking + 1
									report.healermanalist[name .. "(" .. BS[14823] .. ")"] = m -- Drinking
								else
									report.healermanalist[name] = m
								end
							end
							healersalivecount = healersalivecount + 1
							healersalive = healersalive + 1
							if UnitInRange(unit.unitid) then
								healerinrange = healerinrange + 1
							end
						end
						if unit.hasmana and unit.isdps then
							dpsmana = dpsmana + m
							dpsmanacount = dpsmanacount + 1
							if m < 100 then
								report.dpsmanalist[name] = m
							end
						end
						rangecount = rangecount + 1
						if UnitInRange(unit.unitid) then
							range = range + 1
						else
							report.rangelist[name] = L["Out of range"]
						end
					end
				end
			else
				if RaidBuffStatus.db.profile.checkoffline then
					table.insert(report.offlinelist, name)  -- used by offline warning check
				end
			end
		end
	end

	if health < 1 then
		report.RaidHealth = 0
	else
		report.RaidHealth = math.floor(health / healthcount)
	end

	if manacount < 1 then
		report.RaidMana = L["n/a"]
	elseif mana < 1 then
		report.RaidMana = 0
	else
		report.RaidMana = math.floor(mana / manacount)
	end

	if tankhealthcount < 1 then
		report.TankHealth = L["n/a"]
	elseif tankhealth < 1 then
		report.TankHealth = 0
	else
		report.TankHealth = math.floor(tankhealth / tankhealthcount)
	end

	if healermanacount < 1 then
		report.HealerMana = L["n/a"]
	elseif healermana < 1 then
		report.HealerMana = 0
	else
		report.HealerMana = math.floor(healermana / healermanacount)
		if (report.HealerMana < 95 and healerdrinking > 0) or (report.HealerMana < 96 and healerdrinking > 1) or (report.HealerMana < 98 and healerdrinking > 2) then
			report.HealerManaIsDrinking = 1
		end
		report.HealerInRange = healerinrange
	end

	if dpsmanacount < 1 then
		report.DPSMana = L["n/a"]
	elseif dpsmana < 1 then
		report.DPSMana = 0
	else
		report.DPSMana = math.floor(dpsmana / dpsmanacount)
	end

	if alivecount < 1 then -- yes there may be no one in the raid for short time until they appear
		report.Alive = L["n/a"]
		report.AliveCount = ""
		report.Dead = 0
		report.DeadCount = 0
	else
		report.Alive = math.floor(alive / alivecount * 100)
		report.AliveCount = alivecount
		report.DeadCount = alivecount - alive
		report.Dead = math.floor(report.DeadCount / alivecount * 100)
	end
	
	if tanksalivecount < 1 then
		report.TanksAlive = L["n/a"]
		report.TanksAliveCount = ""
	else
		report.TanksAlive = math.floor(tanksalive / tanksalivecount * 100)
		report.TanksAliveCount = tanksalive
	end
	report.HealersAliveCountNumber = healersalivecount
	if healersalivecount < 1 then
		report.HealersAlive = L["n/a"]
		report.HealersAliveCount = ""
	else
		report.HealersAlive = math.floor(healersalive / healersalivecount * 100)
		report.HealersAliveCount = healersalivecount
	end
	if rangecount < 1 then
		report.Range = L["n/a"]
		report.RangeCount = ""
	else
		report.Range = math.floor(range / rangecount * 100)
		report.RangeCount = range
	end

	-- do timers
	local thetimenow = math.floor(GetTime())
	for buffcheck, _ in pairs(BF) do
		if BF[buffcheck].timer then
			if not raid.BuffTimers[buffcheck .. "timerlist"] then
				raid.BuffTimers[buffcheck .. "timerlist"] = {}
			end
			for _, v in ipairs(report[BF[buffcheck].list]) do  -- first add those on the list to the timer list if not there
				local missing = true
				for n, t in pairs(raid.BuffTimers[buffcheck .. "timerlist"]) do
					if v == n then
						missing = false
						break
					end
				end
				if missing then
					raid.BuffTimers[buffcheck .. "timerlist"][v] = thetimenow
				end
			end
			for n, t in pairs(raid.BuffTimers[buffcheck .. "timerlist"]) do -- now remove those who are no longer on the list
				local missing = true
				for _, v in ipairs(report[BF[buffcheck].list]) do
					if v == n then
						missing = false
						break
					end
				end
				if missing then
					raid.BuffTimers[buffcheck .. "timerlist"][n] = nil
				end
			end
		end
	end

	-- sort names
	for buffcheck, _ in pairs(BF) do
		if # report[BF[buffcheck].list] > 1 then
			table.sort(report[BF[buffcheck].list])
		end
	end

	-- POST HERE
	for buffcheck, _ in pairs(BF) do
		if BF[buffcheck].post then
			if RaidBuffStatus.db.profile[BF[buffcheck].check] and report.checking[buffcheck] then
				if (not incombat) or (incombat and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"]) then
					BF[buffcheck].post(self, raid, report)
				end
			end
		end
	end
end

function RaidBuffStatus:ReportToChat(boss, channel)
	local BF = RaidBuffStatus.BF
	local warnings = 0
	local buffs = 0
	local canspeak = UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or raid.pug
	if not canspeak and RaidBuffStatus.db.profile.ReportChat and raid.israid then
		RaidBuffStatus:OfficerWarning()
	end
	for buffcheck, _ in pairs(BF) do
		if # report[BF[buffcheck].list] > 0 then
			if (boss and RaidBuffStatus.db.profile[buffcheck .. "boss"]) or ((not boss) and RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
				if RaidBuffStatus.db.profile[buffcheck .. "warning"] then
					warnings = warnings + # report[BF[buffcheck].list]
				end
				if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
					buffs = buffs + # report[BF[buffcheck].list]
				end
			end
		end
	end
	if warnings > 0 then
		RaidBuffStatus:Say(L["Warnings: "] .. warnings, nil, true, channel)
		for buffcheck, _ in pairs(BF) do
			if # report[BF[buffcheck].list] > 0 then
				if (boss and RaidBuffStatus.db.profile[buffcheck .. "boss"] ) or ((not boss) and RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
					if RaidBuffStatus.db.profile[buffcheck .. "warning"] then
						if type(BF[buffcheck].chat) == "string" then
							if BF[buffcheck].timer then
								local timerlist = {}
								for _, n in ipairs(report[BF[buffcheck].list]) do
									if raid.BuffTimers[buffcheck .. "timerlist"][n] then
										table.insert(timerlist, n .. "(" .. RaidBuffStatus:TimeSince(raid.BuffTimers[buffcheck .. "timerlist"][n]) .. ")")
									else
										table.insert(timerlist, n)
									end
								end
								RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. table.concat(timerlist, ", "), nil, nil, channel)
							else
								if RaidBuffStatus.db.profile.ShowMany and BF[buffcheck].raidbuff and #report[BF[buffcheck].list] >= RaidBuffStatus.db.profile.HowMany then
									RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. L["MANY!"], nil, nil, channel)
								else
									RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. table.concat(report[BF[buffcheck].list], ", "), nil, nil, channel)
								end
							end
						elseif type(BF[buffcheck].chat) == "function" then
							BF[buffcheck].chat(report, raid, nil, channel)
						end
					end
				end
			end
		end
	end
	if buffs > 0 then
		if boss then
			RaidBuffStatus:Say(L["Missing buffs (Boss): "] .. buffs, nil, true, channel)
		else
			RaidBuffStatus:Say(L["Missing buffs (Trash): "] .. buffs, nil, true, channel)
		end
		for buffcheck, _ in pairs(BF) do
			if # report[BF[buffcheck].list] > 0 then
				if (boss and RaidBuffStatus.db.profile[buffcheck .. "boss"] ) or ((not boss) and RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
					if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
						if type(BF[buffcheck].chat) == "string" then
							if RaidBuffStatus.db.profile.ShowMany and BF[buffcheck].raidbuff and #report[BF[buffcheck].list] >= RaidBuffStatus.db.profile.HowMany then
								RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. L["MANY!"], nil, nil, channel)
							else
								RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. table.concat(report[BF[buffcheck].list], ", "), nil, nil, channel)
							end
						elseif type(BF[buffcheck].chat) == "function" then
							BF[buffcheck].chat(report, raid)
						end
					end
				end
			end
		end
	else
		if boss then
			RaidBuffStatus:Say(L["No buffs needed! (Boss)"], nil, true, channel)
		else
			RaidBuffStatus:Say(L["No buffs needed! (Trash)"], nil, true, channel)
		end
	end
end

function RaidBuffStatus:ReportToWhisper(boss)
	local BF = RaidBuffStatus.BF
	local prefix
	for buffcheck, _ in pairs(BF) do
		if # report[BF[buffcheck].list] > 0 then
			if (boss and RaidBuffStatus.db.profile[buffcheck .. "boss"]) or ((not boss) and RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
				if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
					prefix = L["Missing buff: "]
				else
					prefix = L["Warning: "]
				end
				RaidBuffStatus:WhisperBuff(BF[buffcheck], report, raid, prefix)
			end
		end
	end
end



function RaidBuffStatus:ReadRaid()
	raid.readid = raid.readid + 1
	wipe(raid.TankList)
	wipe(raid.ManaList)
	wipe(raid.DPSList)
	wipe(raid.HealerList)
	for _,class in ipairs(classes) do
		raid.ClassNumbers[class] = 0
	end
--	RaidBuffStatus:Debug("tankList:" .. tankList)
	local it = select(2, IsInInstance())
	raid.isbattle = (it == "pvp") or (it == "arena") or 
	                (GetRealZoneText() == L["Wintergrasp"]) or
	                (GetRealZoneText() == L["Tol Barad"])
	local groupnum = GetNumGroupMembers()
	raid.size = groupnum
	if groupnum == 0 then -- not grouped
		raid.reset()
		return
	elseif not IsInRaid() then -- party group
		raid.isparty = true
		raid.israid = false
		for i = 1, (groupnum-1) do
			RaidBuffStatus:ReadUnit("party" .. i, i)
		end
		RaidBuffStatus:ReadUnit("player", groupnum)
	else -- raid group
		if raid.isparty then -- Party has converted to Raid!
			if RaidBuffStatus.db.profile.AutoShowDashRaid then
				RaidBuffStatus:ShowReportFrame()
			end
			RaidBuffStatus:TriggerXPerlTankUpdate()
			raid.reset()
		end
		raid.isparty = false
		raid.israid = true

		for i = 1, groupnum do
			RaidBuffStatus:ReadUnit("raid" .. i, i)
		end
	end
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
	  raid.islfg = true
	end
	RaidBuffStatus:DeleteOldUnits()
	if raid.israid then
		local minguildies = 0.75 * groupnum
		raid.pug = true
		for _,v in pairs(raid.guilds) do
			if v > minguildies then
				raid.pug = false
				break
			end
		end
	end
end

local spec_role = {
  MAGE          = "RDPS",
  WARLOCK       = "RDPS",
  HUNTER        = "RDPS",
  ROGUE         = "MDPS",
  PRIEST        = { [1] = "HEALER", [2] = "HEALER", [3] = "RDPS" },
  DEATHKNIGHT   = { [1] = "TANK",   [2] = "MDPS", [3] = "MDPS" },
  PALADIN       = { [1] = "HEALER", [2] = "TANK",   [3] = "MDPS" },
  WARRIOR       = { [1] = "MDPS", [2] = "MDPS", [3] = "TANK" },
  SHAMAN        = { [1] = "RDPS", [2] = "MDPS", [3] = "HEALER" },
  DRUID         = { [1] = "RDPS", [2] = "MDPS", [3] = "TANK", [4] = "HEALER" },
  MONK          = { [1] = "TANK", [2] = "HEALER", [3] = "MDPS" },
}

-- raid = { classes = { CLASS = { NAME = { readid, unitid, guid, group, zone, online, isdead, istank, hasmana, isdps, ishealer, class, 
--                                         hasbuff = {}, talents (boolean), spec (index), specname (localized name), specicon, tinfo = (library info) 
function RaidBuffStatus:ReadUnit(unitid, unitindex)
	if not UnitExists(unitid) then
		return
	end
	local wellfed = GetSpellInfo(35272)-- Well Fed
	local name, realm = UnitName(unitid)
	local class = select(2, UnitClass(unitid))
	if name and name ~= UNKNOWNOBJECT and name ~= UKNOWNBEING and
	   class and raid.classes[class] then
		if realm and string.len(realm) > 0 then
			name = name .. "-" .. realm
		end
		local rank = 0
		local subgroup = 1
		local role = UnitGroupRolesAssigned(unitid)
		local zone = "UNKNOWN"
		local isML = false
		local istank = false
		local hasmana = false
		local isdps = false
		local ismeleedps = false
		local israngeddps = false
		local ishealer = false
		local spec = nil
		local guild = GetGuildInfo(unitid)
		if guild then
			if not raid.guilds[guild] then
				raid.guilds[guild] = 1
			else
				raid.guilds[guild] = raid.guilds[guild] + 1
			end
		end
		if UnitIsGroupLeader(unitid) then
			raid.leadername = name
		end
		if GetNumGroupMembers() > 0 then
		        local _,rrole
			_, rank, subgroup, _, _, _, zone, _, _, rrole, isML = GetRaidRosterInfo(unitindex)
			if (not role or role == "NONE") and 
			   (rrole == "MAINTANK" or string.find(tankList, '|' .. name .. '|')) then
			  role = "TANK"
			end
		end
		if RaidBuffStatus.db.profile.IgnoreLastThreeGroups then
			if subgroup > 5 and IsInInstance() then -- only ignore in instances, so 40-man world bosses work correctly
				raid.size = raid.size - 1
				return
			end
		end
		if raid.classes[class][name] == nil then
			raid.classes[class][name] = {}
		end
		raid.ClassNumbers[class] = raid.ClassNumbers[class] + 1
		local rcn = raid.classes[class][name]
		rcn.unitid = unitid
		rcn.guid = UnitGUID(unitid) or 0
		rcn.group = subgroup
		rcn.isdead = UnitIsDeadOrGhost(unitid) or false
		rcn.class = class
		rcn.level = UnitLevel(unitid)
		rcn.raceEn = select(2,UnitRace(unitid))
		rcn.online = UnitIsConnected(unitid)
		rcn.rank = rank
		rcn.guild = guild
		local hasbuff = rcn.hasbuff or {}
		rcn.hasbuff = hasbuff
		wipe(hasbuff)
		RaidBuffStatus:UpdateSpec(rcn)
		spec = raid.classes[class][name] and raid.classes[class][name].spec
		local mintimeleft = RaidBuffStatus.db.profile.abouttorunout * 60
		local thetime = GetTime()
		for b = 1, 32 do
			local buffName, _, _, _, _, duration, expirationTime, unitCaster = UnitBuff(unitid, b)
--			if duration and expirationTime then
--				RaidBuffStatus:Debug(buffName .. ":" .. duration .. ":" .. expirationTime .. ":")
--			end
			if duration and expirationTime and RaidBuffStatus.db.profile.checkabouttorunout and duration > mintimeleft and (expirationTime - thetime) < mintimeleft then
--				RaidBuffStatus:Debug(buffName .. ":" .. duration .. ":" .. expirationTime .. ":")
--				RaidBuffStatus:Debug("running out")
--				buffName = nil
			elseif buffName then
				if buffName == wellfed then
					RBSToolScanner:Reset()
					RBSToolScanner:SetUnitBuff(unitid, b)
					hasbuff["foodz"] = getglobal('RBSToolScannerTextLeft2'):GetText()
				end
				hasbuff[buffName] = {}
--				hasbuff[buffName].timeleft = expirationTime - thetime
				hasbuff[buffName].duration = duration
				if unitCaster then
--					if UnitIsUnit(unitCaster, "player") then
--						hasbuff[buffName].caster = "*" .. UnitName(unitCaster) .. "*"
--					else
						local castername = RaidBuffStatus:UnitNameRealm(unitCaster)
						if hasbuff[buffName].caster then  -- to handle when there are stacked buffs from more than one person e.g. Dark Intent
							if not hasbuff[buffName].casterlist then
								hasbuff[buffName].casterlist = {}
								table.insert(hasbuff[buffName].casterlist, hasbuff[buffName].caster)
							end
							table.insert(hasbuff[buffName].casterlist, castername)
						end
						hasbuff[buffName].caster = castername
--					end
				else
					hasbuff[buffName].caster = ""
				end
--				RaidBuffStatus:Debug(b .. buffName .. "duration:" .. duration .. " expire:" .. expirationTime .. " caster:" .. hasbuff[buffName].caster .. " timenow:" .. GetTime())
			else
				break
			end
		end
		local specrole = "NONE"
		if type(spec_role[class]) == "string" then
		  specrole = spec_role[class]
		elseif spec and spec > 0 then
		  specrole = spec_role[class][spec]
		end
		if class == "PALADIN" and specrole == "NONE" and hasbuff[BS[25780]] then -- Righteous Fury
		  specrole = "TANK"
                end
		if (not role or role == "NONE") then
		  if specrole == "MDPS" or specrole == "RDPS" then
		    role = "DAMAGER"
		  else
                    role = specrole
 		  end
		end
		if specrole == "MDPS" then
		  ismeleedps = true
		elseif specrole == "RDPS" then
		  israngeddps = true
		end
		if role == "DAMAGER" then
		  isdps = true
		elseif role == "TANK" then
		  istank = true
		elseif role == "HEALER" then
		  ishealer = true
		end

		if class == "PRIEST" or class == "PALADIN" or class == "MAGE" or class == "WARLOCK" or class == "SHAMAN" then
			hasmana = true
		elseif class == "DRUID" and (spec == 1 or spec == 4) then
			hasmana = true
		elseif class == "MONK" and spec == 2 then
			hasmana = true
		end

		if istank then
			table.insert(raid.TankList, name)
		end
		if hasmana then
			table.insert(raid.ManaList, name)
		end
		if isdps then
			table.insert(raid.DPSList, name)
		end
		if ishealer then
			table.insert(raid.HealerList, name)
		end
		
		rcn.readid = raid.readid
		rcn.zone = zone
		rcn.role = role
		rcn.istank = istank
		rcn.hasmana = hasmana
		rcn.isdps = isdps
		rcn.ismeleedps = ismeleedps
		rcn.israngeddps = israngeddps
		rcn.ishealer = ishealer
		rcn.realm = realm
		rcn.name = name
	end
end

function RaidBuffStatus:DeleteOldUnits()
	for class,_ in pairs(raid.classes) do
		for name,_ in pairs(raid.classes[class]) do
			if raid.classes[class][name].readid < raid.readid then
				raid.classes[class][name] = nil
			end
		end
	end
end

local linelimit = 150
function RaidBuffStatus:Say(msg, player, prepend, channel)
	if not msg then
		msg = "nil"
	end
	local canspeak = UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or raid.pug
	while #msg > 0 do
	  local str = msg
	  if #str > linelimit then
            local bpt = linelimit
            for i = linelimit, linelimit-30, -1 do -- look for break characters near the end
              if string.match(string.sub(str,i), "^[%p%s]") then
                bpt = i
                break
              end
            end
            msg = str:sub(bpt+1)
            str = str:sub(1,bpt)
          else
            msg = ""
	  end
	  if prepend or RaidBuffStatus.db.profile.PrependRBS then
		str = "RBS::"..str
	  end
	  if player then
		SendChatMessage(str, "WHISPER", nil, player)
	  elseif channel then
		SendChatMessage(str, channel)
   	  else
	        if RaidBuffStatus.db.profile.ReportChat and not raid.isbattle then
		    if raid.islfg then SendChatMessage(str, "INSTANCE_CHAT")
		    elseif raid.isparty then SendChatMessage(str, "PARTY")
		    elseif raid.israid and canspeak then SendChatMessage(str, "RAID") 
		    end
	        end
		if RaidBuffStatus.db.profile.ReportSelf then RaidBuffStatus:Print(str) end
		if RaidBuffStatus.db.profile.ReportOfficer then SendChatMessage(str, "officer") end
	  end
	end
end

function RaidBuffStatus:Debug(msg)
	if not RaidBuffStatus.db.profile.Debug then
		return
	end
	local str = "RBS::"
	for _,s in pairs({strsplit(" ", msg)}) do
		if #str + #s >= 250 then
			RaidBuffStatus:Print(str)
			str = "RBS::"
		end
		str = str .. " " .. s
	end
	RaidBuffStatus:Print(str)
end


function RaidBuffStatus:DicSize(dic) -- is there really no built-in function to do this??
	if not dic then
		return 0
	end
	local i = 0
	for _,_ in pairs(dic) do
		i = i + 1
	end
	return i
end

function RaidBuffStatus:OnProfileChanged()
	RaidBuffStatus:LoadFramePosition()
	RaidBuffStatus:AddBuffButtons()
	RaidBuffStatus:SetFrameColours()
end

function RaidBuffStatus:SetFrameColours()
	RaidBuffStatus.frame:SetBackdropBorderColor(RaidBuffStatus.db.profile.bbr, RaidBuffStatus.db.profile.bbg, RaidBuffStatus.db.profile.bbb, RaidBuffStatus.db.profile.bba)
	RaidBuffStatus.frame:SetBackdropColor(RaidBuffStatus.db.profile.bgr, RaidBuffStatus.db.profile.bgg, RaidBuffStatus.db.profile.bgb, RaidBuffStatus.db.profile.bga)
	RaidBuffStatus.talentframe:SetBackdropBorderColor(RaidBuffStatus.db.profile.bbr, RaidBuffStatus.db.profile.bbg, RaidBuffStatus.db.profile.bbb, RaidBuffStatus.db.profile.bba)
	RaidBuffStatus.talentframe:SetBackdropColor(RaidBuffStatus.db.profile.bgr, RaidBuffStatus.db.profile.bgg, RaidBuffStatus.db.profile.bgb, RaidBuffStatus.db.profile.bga)
	RaidBuffStatus.optionsframe:SetBackdropBorderColor(RaidBuffStatus.db.profile.bbr, RaidBuffStatus.db.profile.bbg, RaidBuffStatus.db.profile.bbb, RaidBuffStatus.db.profile.bba)
	RaidBuffStatus.optionsframe:SetBackdropColor(RaidBuffStatus.db.profile.bgr, RaidBuffStatus.db.profile.bgg, RaidBuffStatus.db.profile.bgb, RaidBuffStatus.db.profile.bga)
end

function RaidBuffStatus:SetupFrames()
	local frame, button, fs -- temps used below
	-- main frame
	frame = CreateFrame("Frame", "RBSFrame", UIParent)
	RaidBuffStatus.frame = frame
	frame:Hide()
	frame:EnableMouse(true)
	frame:SetFrameStrata("MEDIUM")
	frame:SetMovable(true)
	frame:SetToplevel(true)
	frame:SetWidth(128)
	frame:SetHeight(190)
	frame:SetScale(RaidBuffStatus.db.profile.dashscale)
	fs = frame:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	fs:SetText("RBS " .. RaidBuffStatus.version)
	fs:SetPoint("TOP",0,-5)
	fs:SetTextColor(.9,0,0)
	fs:Show()
	frame:SetBackdrop( { 
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	frame:ClearAllPoints()
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	frame:SetScript("OnMouseDown",function(self, button)
		if ( button == "LeftButton" ) then
			if not RaidBuffStatus.db.profile.LockWindow then
				if not RaidBuffStatus.db.profile.movewithaltclick or (RaidBuffStatus.db.profile.movewithaltclick and IsAltKeyDown()) then
					self:StartMoving()
				end
			end
		end
	end)
	frame:SetScript("OnMouseUp",function(self, button)
		if ( button == "LeftButton" ) then
			self:StopMovingOrSizing()
			RaidBuffStatus:SaveFramePosition()
		end
	end)
	frame:SetScript("OnHide",function(self) self:StopMovingOrSizing() end)
	frame:SetClampedToScreen(true)
	RaidBuffStatus:LoadFramePosition()

        
	button = CreateFrame("Button", "$parentBossButton", RaidBuffStatus.frame, "OptionsButtonTemplate")
	RaidBuffStatus.bossbutton = button
	button:SetText(L["Boss"])
	button:SetWidth(45)
	button:SetPoint("BOTTOMLEFT", RaidBuffStatus.frame, "BOTTOMLEFT", 7, 5)
	button:SetScript("OnClick", function()
		if RaidBuffStatus.db.profile.abouttorunoutdash then
			RaidBuffStatus.db.profile.checkabouttorunout = true
		end
		RaidBuffStatus:DoReport(true)
		RaidBuffStatus:UpdateButtons()
		if IsControlKeyDown() then
			RaidBuffStatus:ReportToWhisper(true)
		else
			if IsShiftKeyDown() then
				RaidBuffStatus:ReportToChat(true, "officer")
			else
				RaidBuffStatus:ReportToChat(true)
			end
		end
	end)
	button:Show()

	button = CreateFrame("Button", "$parentTrashButton", RaidBuffStatus.frame, "OptionsButtonTemplate")
	RaidBuffStatus.trashbutton = button
	button:SetText(L["Trash"])
	button:SetWidth(45)
	button:SetPoint("BOTTOMRIGHT", RaidBuffStatus.frame, "BOTTOMRIGHT", -7, 5)
	button:SetScript("OnClick", function()
		RaidBuffStatus.db.profile.checkabouttorunout = false
		RaidBuffStatus:DoReport(true)
		RaidBuffStatus:UpdateButtons()
		if IsControlKeyDown() then
			RaidBuffStatus:ReportToWhisper(false)
		else
			if IsShiftKeyDown() then
				RaidBuffStatus:ReportToChat(false, "officer")
			else
				RaidBuffStatus:ReportToChat(false)
			end
		end
	end)
	button:Show()

	button = CreateFrame("Button", "$parentReadyCheckButton", RaidBuffStatus.frame, "OptionsButtonTemplate")
	RaidBuffStatus.readybutton = button
	button:SetText(L["R"])
	button:SetWidth(22)
	button:SetPoint("BOTTOM", RaidBuffStatus.frame, "BOTTOM", 0, 5)
	button:SetScript("OnClick", function()
		if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then
			DoReadyCheck()
		else
			RaidBuffStatus:OfficerWarning()
		end
	end)
	button:Show()

	button = CreateFrame("Button", "$parentTalentsButton", RaidBuffStatus.frame, "SecureActionButtonTemplate")
	RaidBuffStatus.talentsbutton = button
	button:SetWidth(20)
	button:SetHeight(20)
	button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down") 
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	button:ClearAllPoints()
	button:SetPoint("TOPLEFT", RaidBuffStatus.frame, "TOPLEFT", 5, -5)
	button:SetScript("OnClick", function()
		RaidBuffStatus:ToggleTalentsFrame()
	end
	)
	button:Show()

	button = CreateFrame("Button", "$parentOptionsButton", RaidBuffStatus.frame, "SecureActionButtonTemplate")
	RaidBuffStatus.optionsbutton = button
	button:SetWidth(20)
	button:SetHeight(20)
	button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down") 
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	button:ClearAllPoints()
	button:SetPoint("TOPRIGHT", RaidBuffStatus.frame, "TOPRIGHT", -5, -5)
	button:SetScript("OnClick", function() RaidBuffStatus:ToggleOptionsFrame() end)
	button:Show()

	-- Dashboard scan button
	button = CreateFrame("Button", "$parentScanButton", RaidBuffStatus.frame, "OptionsButtonTemplate")
	RaidBuffStatus.scanbutton = button
	button:SetText(L["Scan"])
	button:SetWidth(55)
	button:SetHeight(15)
	button:SetPoint("TOP", RaidBuffStatus.frame, "TOP", 0, -18)
	button:SetScript("OnClick", function()
		RaidBuffStatus:DoReport(true)
		RaidBuffStatus:Debug("Scan button")
	end)
	button:Show()

	RaidBuffStatus:AddBuffButtons()

	-- talents window frame

	local talentframe = CreateFrame("Frame", "RBSTalentsFrame", UIParent, "DialogBoxFrame")
	RaidBuffStatus.talentframe = talentframe
	talentframe:Hide()
	talentframe:EnableMouse(true)
	talentframe:SetFrameStrata("MEDIUM")
	talentframe:SetMovable(true)
	talentframe:SetToplevel(true)
	talentframe:SetWidth(tfi.framewidth)
	talentframe:SetHeight(190)
	fs = talentframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	fs:SetText("RBS " .. RaidBuffStatus.version .. " - " .. L["Talent Specialisations"])
	fs:SetPoint("TOP",0,-5)
	fs:SetTextColor(1,1,1)
	fs:Show()
	talentframe:SetBackdrop( { 
		bgFile = "Interface\\Buttons\\WHITE8X8", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	talentframe:ClearAllPoints()
	talentframe:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	talentframe:SetScript("OnMouseDown",function(self, button)
		if ( button == "LeftButton" ) then
			if not RaidBuffStatus.db.profile.LockWindow then
				self:StartMoving()
			end
		end
	end)
	talentframe:SetScript("OnMouseUp",function(self, button)
		if ( button == "LeftButton" ) then
			self:StopMovingOrSizing()
			RaidBuffStatus:SaveFramePosition()
		end
	end)
	talentframe:SetScript("OnHide",function(self) self:StopMovingOrSizing() end)
        -- button: sort by name
	button = CreateFrame("Button", nil, talentframe, "OptionsButtonTemplate")
	button:SetText(L["Name"])
	button:SetWidth(tfi.namewidth)
	button:SetPoint("TOPLEFT", talentframe, "TOPLEFT", tfi.namex, -20)
	button:SetScript("OnClick", function()
		tfi.sort = "name"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
	button:Show()
        -- button: sort by class
	button = CreateFrame("Button", nil, talentframe, "OptionsButtonTemplate")
	button:SetText(L["Class"])
	button:SetWidth(tfi.classwidth)
	button:SetPoint("TOPLEFT", talentframe, "TOPLEFT", tfi.classx, -20)
	button:SetScript("OnClick", function()
		tfi.sort = "class"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
        -- button: sort by spec
	button:Show()
	button = CreateFrame("Button", nil, talentframe, "OptionsButtonTemplate")
	button:SetText(L["Spec"])
	button:SetWidth(tfi.specwidth)
	button:SetPoint("TOPLEFT", talentframe, "TOPLEFT", tfi.specx, -20)
	button:SetScript("OnClick", function()
		tfi.sort = "spec"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
	button:Show()
        -- button: sort by role
	button = CreateFrame("Button", nil, talentframe, "OptionsButtonTemplate")
	button:SetText(L["Role"])
	button:SetWidth(tfi.specwidth)
	button:SetPoint("TOPLEFT", talentframe, "TOPLEFT", tfi.rolex, -20)
	button:SetScript("OnClick", function()
		tfi.sort = "role"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
	button:Show()
        -- button: sort by talents
	button = CreateFrame("Button", nil, talentframe, "OptionsButtonTemplate")
	button:SetText(L["Specialisations"])
	button:SetWidth(tfi.specialisationswidth)
	button:SetPoint("TOPLEFT", talentframe, "TOPLEFT", tfi.specialisationsx, -20)
	button:SetScript("OnClick", function()
		tfi.sort = "specialisations"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
	button:Show()
        -- button: refresh
	button = CreateFrame("Button", nil, talentframe, "OptionsButtonTemplate")
	button:SetText(L["Refresh"])
	button:SetWidth(90)
	button:SetPoint("BOTTOMRIGHT", RaidBuffStatus.talentframe, "BOTTOMRIGHT", -5, 5)
	button:SetScript("OnClick", function() RaidBuffStatus:RefreshTalents() end)
	button:Show()

	rowy = 0 - tfi.topedge
	for i = 1, tfi.maxrows do
		tfi.rowframes[i] = {}
		local rowframe = CreateFrame("Frame", nil, talentframe)
		tfi.rowframes[i].rowframe = rowframe
		rowframe:SetWidth(tfi.rowwidth)
		rowframe:SetHeight(tfi.rowheight)
		rowframe:ClearAllPoints()
		rowframe:SetPoint("TOPLEFT", talentframe, "TOPLEFT", tfi.edge + tfi.inset, rowy)
		fs = rowframe:CreateFontString(nil,"ARTWORK","GameFontNormal")
		tfi.rowframes[i].name = fs
		fs:SetText("Must be in a party/raid")
		fs:SetPoint("TOPLEFT", rowframe, "TOPLEFT", 0, -2)
		fs:SetTextColor(.9,0,0)
		fs:Show()
		-- button: class
		button = CreateFrame("Button", nil, rowframe)
		tfi.rowframes[i].class = button
		button:SetWidth(tfi.buttonsize)
		button:SetHeight(tfi.buttonsize)
		button:SetNormalTexture("Interface\\Icons\\INV_ValentinesCandy")
		button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		button:SetPoint("TOPLEFT", rowframe, "TOPLEFT", tfi.classx + ((tfi.classwidth - 30) / 2), 0)
		button:Show()
		-- button: role
		button = CreateFrame("Button", nil, rowframe)
		tfi.rowframes[i].role = button
		button:SetWidth(tfi.buttonsize)
		button:SetHeight(tfi.buttonsize)
		button:SetNormalTexture("Interface\\Icons\\INV_ValentinesCandy")
		button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		button:SetPoint("TOPLEFT", rowframe, "TOPLEFT", tfi.rolex + ((tfi.rolewidth - 30) / 2), 0)
		button:Show()
		-- button: spec
		button = CreateFrame("Button", nil, rowframe)
		tfi.rowframes[i].spec = button
		button:SetWidth(tfi.buttonsize)
		button:SetHeight(tfi.buttonsize)
		button:SetNormalTexture("Interface\\Icons\\Ability_ThunderBolt")
		button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		button:SetPoint("TOPLEFT", rowframe, "TOPLEFT", tfi.specx + ((tfi.specwidth - 30) / 2), 0)
		button:Show()
		-- talent buttons, numbered ascending left-to-right, right-anchored
		tfi.rowframes[i].specialisations = {}
		for j = 13, 1, -1 do
			button = CreateFrame("Button", nil, rowframe)
			tfi.rowframes[i].specialisations[j] = button
			button:SetWidth(tfi.buttonsize)
			button:SetHeight(tfi.buttonsize)
			button:SetNormalTexture("Interface\\Icons\\Ability_ThunderBolt")
			button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
			if j == 13 then
			  button:SetPoint("TOPRIGHT", rowframe, "TOPRIGHT", 0 - tfi.inset, 0)
			else
			  button:SetPoint("TOPRIGHT", tfi.rowframes[i].specialisations[j + 1], "TOPLEFT", 0, 0)
			end
			button:Show()
		end
		rowy = rowy - tfi.rowheight - tfi.rowgap
	end


	-- options window frame
	local optionsframe = CreateFrame("Frame", "RBSOptionsFrame", UIParent, "DialogBoxFrame")
	RaidBuffStatus.optionsframe = optionsframe
	optionsframe:Hide()
	optionsframe:EnableMouse(true)
	optionsframe:SetFrameStrata("MEDIUM")
	optionsframe:SetMovable(true)
	optionsframe:SetToplevel(true)
	optionsframe:SetWidth(300)
	optionsframe:SetHeight(228)
	optionsframe:SetScale(RaidBuffStatus.db.profile.optionsscale)
	fs = optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	fs:SetText("RBS " .. RaidBuffStatus.version .. " - " .. L["Buff Options"])
	fs:SetPoint("TOP",0,-5)
	fs:SetTextColor(1,1,1)
	fs:Show()
	optionsframe:SetBackdrop( { 
		bgFile = "Interface\\Buttons\\WHITE8X8", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	optionsframe:ClearAllPoints()
	optionsframe:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	optionsframe:SetScript("OnMouseDown",function(self, button)
		if ( button == "LeftButton" ) then
			if not RaidBuffStatus.db.profile.LockWindow then
				self:StartMoving()
			end
		end
	end)
	optionsframe:SetScript("OnMouseUp",function(self, button)
		if ( button == "LeftButton" ) then
			self:StopMovingOrSizing()
			RaidBuffStatus:SaveFramePosition()
		end
	end)
	optionsframe:SetScript("OnHide",function(self) self:StopMovingOrSizing() end)

	fs = optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	fs:SetText(L["Is a warning"] .. ":")
	fs:SetPoint("TOPLEFT",10,-53)
	fs:SetTextColor(1,1,1)
	fs:Show()
	fs = optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	fs:SetText(L["Is a buff"] .. ":")
	fs:SetPoint("TOPLEFT",10,-73)
	fs:SetTextColor(1,1,1)
	fs:Show()
	fs = optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	fs:SetText(L["Show on dashboard"] .. ":")
	fs:SetPoint("TOPLEFT",10,-93)
	fs:SetTextColor(1,1,1)
	fs:Show()
	fs = optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	fs:SetText(L["Show/Report in combat"] .. ":")
	fs:SetPoint("TOPLEFT",10,-113)
	fs:SetTextColor(1,1,1)
	fs:Show()
	fs = optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	fs:SetText(L["Report on Trash"] .. ":")
	fs:SetPoint("TOPLEFT",10,-133)
	fs:SetTextColor(1,1,1)
	fs:Show()
	fs = optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	fs:SetText(L["Report on Boss"] .. ":")
	fs:SetPoint("TOPLEFT",10,-153)
	fs:SetTextColor(1,1,1)
	fs:Show()

	button = CreateFrame("Button", nil, optionsframe, "OptionsButtonTemplate")
	button:SetText(L["Buff Wizard"])
	button:SetPoint("BOTTOMLEFT", optionsframe, "BOTTOMLEFT", 10, 25)
	button:SetScript("OnClick", function() RaidBuffStatus:OpenBlizzAddonOptions() end)
	button:Show()

	local bufflist = {}
	local BF = RaidBuffStatus.BF
	for buffcheck, _ in pairs(BF) do
		table.insert(bufflist, buffcheck)
	end
	table.sort(bufflist, function (a,b) return BF[a].order > BF[b].order end)

	local saveradio = function (self)
		local name = self:GetName()
		RaidBuffStatus.db.profile[name] = self:GetChecked() and true or false
		local buffradio = false
		local isbuff = false
		if name:find("buff$") then
			buffradio = name:sub(1, name:find("buff$") - 1)
			isbuff = true
		elseif name:find("warning$") then
			buffradio = name:sub(1, name:find("warning$") - 1)
		end
		if buffradio then
			local value = true
			if RaidBuffStatus.db.profile[name] then
				value = false  -- if I am ticked then make the other unticked
			end
			if isbuff then
				RaidBuffStatus.db.profile[buffradio .. "warning"] = value
			else
				RaidBuffStatus.db.profile[buffradio .. "buff"] = value
			end
			RaidBuffStatus:UpdateOptionsButtons()
		end
		RaidBuffStatus:AddBuffButtons()
		RaidBuffStatus:UpdateButtons()
	end

	local currentx = 165
	for _, buffcheck in ipairs(bufflist) do
		RaidBuffStatus:AddOptionsBuffButton(buffcheck, currentx, -25, BF[buffcheck].icon, BF[buffcheck].tip)
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "warning", currentx, -50, saveradio, "Radio")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "buff", currentx, -70, saveradio, "Radio")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "dash", currentx, -90, saveradio, "Check")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "dashcombat", currentx, -110, saveradio, "Check")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "trash", currentx, -130, saveradio, "Check")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "boss", currentx, -150, saveradio, "Check")
		currentx = currentx + 22
	end
	optionsframe:SetWidth(currentx + 9)
	RaidBuffStatus:SetFrameColours()
end


function RaidBuffStatus:SaveFramePosition()
	RaidBuffStatus.db.profile.x = RaidBuffStatus.frame:GetLeft()
	RaidBuffStatus.db.profile.y = RaidBuffStatus.frame:GetTop()
end

function RaidBuffStatus:LoadFramePosition()
	RaidBuffStatus.frame:ClearAllPoints()
	if (RaidBuffStatus.db.profile.x ~= 0) or (RaidBuffStatus.db.profile.y ~= 0) then
		RaidBuffStatus.frame:SetPoint("TOPLEFT", UIParent,"BOTTOMLEFT", RaidBuffStatus.db.profile.x, RaidBuffStatus.db.profile.y)
	else
		RaidBuffStatus.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

function RaidBuffStatus:IconFix()
	RaidBuffStatus:Debug("icon fix")
	local BF = RaidBuffStatus.BF
	local needscallagain = false
	for buffcheck, _ in pairs(BF) do
		if BF[buffcheck].iconfix then
			if BF[buffcheck].iconfix(self) then
				needscallagain = true
			end
		end
	end
	for _, button in ipairs(optionsiconbuttons) do
		if BF[button:GetName()].iconfix then
			button:SetNormalTexture(BF[button:GetName()].icon)
		end
	end
	if needscallagain then
		RaidBuffStatus:Debug("scheduling another icon fix")
		RaidBuffStatus:ScheduleTimer(function()
			RaidBuffStatus:IconFix()
		end, 15)  -- try again in 15 secs
	else
		RaidBuffStatus:Debug("NOT scheduling another icon fix")
		RaidBuffStatus:AddBuffButtons()
	end
end

function RaidBuffStatus:AddBuffButtons()
	if (InCombatLockdown()) then
		return
	end
	RaidBuffStatus:HideAllBars()
	local warnings = {}
	local buffs = {}
	local bosses = {}
	for _, v in ipairs(buttons) do
		v.free = true
		v:Hide()
	end
	local BF = RaidBuffStatus.BF
	for buffcheck, _ in pairs(BF) do
		
		if not RaidBuffStatus.db.profile[buffcheck .. "dash"] and not RaidBuffStatus.db.profile[buffcheck .. "dashcombat"] and not RaidBuffStatus.db.profile[buffcheck .. "boss"] and not RaidBuffStatus.db.profile[buffcheck .. "trash"] then
			 RaidBuffStatus.db.profile[BF[buffcheck].check] = false -- if nothing using it then switch off
		end
		if not RaidBuffStatus.db.profile[buffcheck .. "dash"] and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"] then
			 RaidBuffStatus.db.profile[BF[buffcheck].check] = true
		end

		if  (not incombat and RaidBuffStatus.db.profile[buffcheck .. "dash"]) or (incombat and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"]) then
			if RaidBuffStatus.db.profile.groupsortstyle == "three" then
				if RaidBuffStatus.db.profile[buffcheck .. "boss"] and (not RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
					table.insert(bosses, buffcheck)
				else
					if RaidBuffStatus.db.profile[buffcheck .. "warning"] then
						table.insert(warnings, buffcheck)
					end
					if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
						table.insert(buffs, buffcheck)
					end
				end
			else
				if RaidBuffStatus.db.profile[buffcheck .. "boss"] or RaidBuffStatus.db.profile[buffcheck .. "warning"] or RaidBuffStatus.db.profile[buffcheck .. "buff"] then
					table.insert(warnings, buffcheck)
				end
			end
		end
		
	end
	RaidBuffStatus:SortButtons(bosses)
	RaidBuffStatus:SortButtons(buffs)
	RaidBuffStatus:SortButtons(warnings)
	local currenty
	if incombat or RaidBuffStatus.db.profile.hidebossrtrash then
		currenty = -14
	else
		currenty = 8
	end
	local maxcols = RaidBuffStatus.db.profile.dashcols
	local cols = { 10, 32, 54, 76, 98, 120, 142, 164, 186, 208, 230, 252, 274, 296, 318, 340, 362, 384, 402, 424, 446, 468, 490}
	if RaidBuffStatus.db.profile.statusbarpositioning == "bottom" then
		currenty = RaidBuffStatus:AddBars(currenty)
	end
	if # bosses > 0 then
		currenty = RaidBuffStatus:AddButtonType(bosses, maxcols, cols, currenty)
	end
	if RaidBuffStatus.db.profile.statusbarpositioning == "twodown" then
		currenty = RaidBuffStatus:AddBars(currenty)
	end
	if # buffs > 0 then
		currenty = RaidBuffStatus:AddButtonType(buffs, maxcols, cols, currenty)
	end
	if RaidBuffStatus.db.profile.statusbarpositioning == "onedown" then
		currenty = RaidBuffStatus:AddBars(currenty)
	end
	if # warnings > 0 then
		currenty = RaidBuffStatus:AddButtonType(warnings, maxcols, cols, currenty)
	end
	if RaidBuffStatus.db.profile.statusbarpositioning == "top" then
		currenty = RaidBuffStatus:AddBars(currenty) + 2
	end
	if incombat or RaidBuffStatus.db.profile.hidebossrtrash then
		RaidBuffStatus.bossbutton:Hide()
		RaidBuffStatus.trashbutton:Hide()
		RaidBuffStatus.readybutton:Hide()
		if incombat then
			RaidBuffStatus.talentsbutton:Hide()
			RaidBuffStatus.optionsbutton:Hide()
			RaidBuffStatus.scanbutton:Hide()
			currenty = currenty - 18
		end
	else
		RaidBuffStatus.bossbutton:Show()
		RaidBuffStatus.trashbutton:Show()
		RaidBuffStatus.readybutton:Show()
		RaidBuffStatus.talentsbutton:Show()
		RaidBuffStatus.optionsbutton:Show()
		RaidBuffStatus.scanbutton:Show()
	end
	RaidBuffStatus.frame:SetHeight(currenty + 50)
	RaidBuffStatus.frame:SetWidth(maxcols * 22 + 18)
	RaidBuffStatus:SetBarsWidth()
end

function RaidBuffStatus:AddButtonType(buttonlist, maxcols, cols, currenty)
	local BF = RaidBuffStatus.BF
	for i, v in ipairs(buttonlist) do
		local x = cols[((i - 1) % maxcols) + 1]
		local y = currenty + (22 * (math.ceil((# buttonlist)/maxcols) - math.floor((i - 1) / maxcols)))
		RaidBuffStatus:AddBuffButton(v, x, y, BF[v].icon, BF[v].update, BF[v].click, BF[v].tip)
	end
	return (currenty + 6 + 22 * math.ceil((# buttonlist)/maxcols))
end

function RaidBuffStatus:SortButtons(buttonlist)
	local BF = RaidBuffStatus.BF
	table.sort(buttonlist, function (a,b)
		for _, sortmethod in ipairs(RaidBuffStatus.db.profile.buffsort) do
			if sortmethod == "defaultorder" then
				return (BF[a].order > BF[b].order)
			elseif sortmethod == "raid" then
				if BF[a].raidwidebuff ~= BF[b].raidwidebuff then
					if BF[a].raidwidebuff and not BF[b].raidwidebuff then
						return true
					else
						return false
					end
				end
			elseif sortmethod == "consumables" then
				if BF[a].consumable ~= BF[b].consumable then
					if BF[a].consumable and not BF[b].consumable then
						return true
					else
						return false
					end
				end
			elseif sortmethod == "self" then
				if BF[a].selfonlybuff ~= BF[b].selfonlybuff then
					if BF[a].selfonlybuff and not BF[b].selfonlybuff then
						return true
					else
						return false
					end
				end
			elseif sortmethod == "other" then
				if BF[a].other ~= BF[b].other then
					if BF[a].other and not BF[b].other then
						return true
					else
						return false
					end
				end
			elseif sortmethod == "single" then
				if BF[a].singletarget ~= BF[b].singletarget then
					if BF[a].singletarget and not BF[b].singletarget then
						return true
					else
						return false
					end
				end
			elseif sortmethod == "class" then
				local adic = BF[a].class or {}
				local bdic = BF[b].class or {}
				local alist = {}
				local blist = {}
				for class, _ in pairs(adic) do
					table.insert(alist, class)
				end
				for class, _ in pairs(bdic) do
					table.insert(blist, class)
				end
				if #alist == 1 and (#blist < 1 or #blist > 1) then
					return true
				elseif #alist < 1 or #alist > 1 then
					return false
				end
				if alist[1] ~= blist[1] then
					return (alist[1] > blist[1])
				end
			elseif sortmethod == "my" then
				local aclasslist = BF[a].class or {}
				local bclasslist = BF[b].class or {}
				if aclasslist[playerclass] ~= bclasslist[playerclass] then
					if aclasslist[playerclass] and not bclasslist[playerclass] then
						return true
					else
						return false
					end
				end
			end
		end
		return (BF[a].order > BF[b].order)
	end)
end


function RaidBuffStatus:AddBuffButton(name, x, y, icon, update, click, tooltip)
	local button = nil
	for _, v in ipairs(buttons) do
		if v.free then
			button = v
			button.update = nil
			button:SetScript("PreClick", nil)
			button:SetScript("PostClick", nil)
			button:SetScript("OnEnter", nil)
			button:SetScript("OnLeave", nil)
			button:SetAttribute("type", nil)
			button:SetAttribute("spell", nil)
			button:SetAttribute("unit", nil)
			button:SetAttribute("name", nil)
			button:SetAttribute("item", nil)
			button.count:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			button.count:SetText("")
			break
		end
	end
	if not button then
		button = CreateFrame("Button", nil, RaidBuffStatus.frame, "SecureActionButtonTemplate")
		button:RegisterForClicks("LeftButtonUp","RightButtonUp")
		table.insert(buttons, button)
		button:Hide()
		button:SetWidth(20)
		button:SetHeight(20)
		button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		button:SetAlpha(1)
		local count = button:CreateFontString(nil, "ARTWORK","GameFontNormalSmall")
		button.count = count
		count:SetWidth(20)
		count:SetHeight(20)
		count:SetFont(count:GetFont(),11,"OUTLINE")
		count:SetPoint("CENTER", button, "CENTER", 0, 0)
		count:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		count:SetText("X")
		count:Show()
	end
	button.free = false
	button:SetNormalTexture(icon)
	button:SetPoint("BOTTOMLEFT", RaidBuffStatus.frame, "BOTTOMLEFT", x, y)
	if click then
		button:SetScript("PreClick", click)
	end
	if update then
		button.update = update
	end
	if tooltip then
		button:SetScript("OnEnter", function (self)
			tooltip(self)
			RaidBuffStatus.tooltipupdate = function ()
				tooltip(self)
			end
		end)
		button:SetScript("OnLeave", function()
			RaidBuffStatus.tooltipupdate = nil
			GameTooltip:Hide()
		end)
	end
	button:Show()
end

function RaidBuffStatus:AddOptionsBuffButton(name, x, y, icon, tooltip)
	local button = CreateFrame("Button", name, RaidBuffStatus.optionsframe, "SecureActionButtonTemplate")
	table.insert(optionsiconbuttons, button)
	button:Hide()
	button:SetWidth(20)
	button:SetHeight(20)
	button:SetNormalTexture(icon)
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	button:SetPoint("TOPLEFT", RaidBuffStatus.optionsframe, "TOPLEFT", x, y)
	if tooltip then
		button:SetScript("OnEnter", tooltip)
		button:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
	button:Show()
end

function RaidBuffStatus:AddOptionsBuffRadioButton(name, x, y, click, type)
	local button = CreateFrame("CheckButton", name, RaidBuffStatus.optionsframe, "UI" .. type .. "ButtonTemplate")
	table.insert(optionsbuttons, button)
	button:Hide()
	button:SetWidth(20)
	button:SetHeight(20)
	button:SetPoint("TOPLEFT", RaidBuffStatus.optionsframe, "TOPLEFT", x, y)
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	if click then
		button:SetScript("OnClick", click)
	end
	button:Show()
end



function RaidBuffStatus:ToggleCheck(...)
	if RaidBuffStatus.db.profile[...] then
		RaidBuffStatus.db.profile[...] = false
	else
		RaidBuffStatus.db.profile[...] = true
		RaidBuffStatus:DoReport()
	end
	RaidBuffStatus:UpdateButtons()
end


function RaidBuffStatus:UpdateButtons()
	for _,v in ipairs(buttons) do
		if not v.free then
			if v.update then
				v:update(v)
			end
		end
	end
	if RaidBuffStatus.db.profile.TanksAlive then
		RaidBuffStatus:SetPercent("TanksAlive", report.TanksAlive, report.TanksAliveCount)
	end
	if RaidBuffStatus.db.profile.HealersAlive then
		RaidBuffStatus:SetPercent("HealersAlive", report.HealersAlive, report.HealersAliveCount)
	end
	if RaidBuffStatus.db.profile.Range then
		RaidBuffStatus:SetPercent("Range", report.Range, report.RangeCount)
	end
	if RaidBuffStatus.db.profile.Alive then
		RaidBuffStatus:SetPercent("Alive", report.Alive, report.AliveCount)
	end
	if RaidBuffStatus.db.profile.Dead then
		RaidBuffStatus:SetPercent("Dead", report.Dead, report.DeadCount)
	end
	if RaidBuffStatus.db.profile.RaidHealth then
		RaidBuffStatus:SetPercent("RaidHealth", report.RaidHealth)
	end
	if RaidBuffStatus.db.profile.TankHealth then
		RaidBuffStatus:SetPercent("TankHealth", report.TankHealth)
	end
	if RaidBuffStatus.db.profile.RaidMana then
		RaidBuffStatus:SetPercent("RaidMana", report.RaidMana)
	end
	if RaidBuffStatus.db.profile.DPSMana then
		RaidBuffStatus:SetPercent("DPSMana", report.DPSMana)
	end
	if RaidBuffStatus.db.profile.HealerMana then
		RaidBuffStatus:SetPercent("HealerMana", report.HealerMana)
		if report.HealerManaIsDrinking > 0 and report.HealersAliveCountNumber > 0 then
			RaidBuffStatus.bars["HealerMana"].bartext:SetText(L["Healer drinking"])
			RaidBuffStatus.bars["HealerMana"].bartext:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
			if lasthealerdrinking < GetTime() then
				lasthealerdrinking = GetTime() + 60
				if RaidBuffStatus.db.profile.healerdrinkingsound then
					PlaySoundFile("Sound\\Creature\\MillhouseManastorm\\TEMPEST_Millhouse_Drinks01.ogg", "Master")
				end
			end
		elseif report.HealerInRange < 1 and report.HealersAliveCountNumber > 0 then
			RaidBuffStatus.bars["HealerMana"].bartext:SetText(L["No healer close"])
			RaidBuffStatus.bars["HealerMana"].bartext:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
		else
			RaidBuffStatus.bars["HealerMana"].bartext:SetText(L["Healer mana"])
			RaidBuffStatus.bars["HealerMana"].bartext:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			--RaidBuffStatus.bars["HealerMana"].bartext:SetShadowColor(0, 0, 0, 1)
		end
	end
end

function RaidBuffStatus:UpdateOptionsButtons()
	for _,v in ipairs(optionsbuttons) do
		v:SetChecked(RaidBuffStatus.db.profile[v:GetName()])
	end
end


function RaidBuffStatus:OnProfileEnable()
	RaidBuffStatus:LoadFramePosition()
	RaidBuffStatus:DoReport(true)
end

function RaidBuffStatus:JoinedPartyRaidChanged()
	local oldstatus = raid.isparty or raid.israid
	local oldbattle = raid.isbattle
	RaidBuffStatus:DoReport(true)
	if oldstatus then  -- was a raid or party last check
		if raid.isparty or raid.israid then -- still is a raid or party
			RaidBuffStatus:TriggerXPerlTankUpdate()
		else	-- no longer in raid or party
			RaidBuffStatus:HideReportFrame()
			if RaidBuffStatus.timer then
				RaidBuffStatus:CancelTimer(RaidBuffStatus.timer)
				RaidBuffStatus.timer = false
			end
		end
	else
		if raid.isparty or raid.israid then -- newly entered raid or party
			RaidBuffStatus:TriggerXPerlTankUpdate()
			RaidBuffStatus.timer = RaidBuffStatus:ScheduleRepeatingTimer(RaidBuffStatus.DoReport, RaidBuffStatus.db.profile.HowOften)
			RaidBuffStatus:SendVersion()
			if RaidBuffStatus.db.profile.TellWizard then
				RaidBuffStatus:PopUpWizard()
			end
		end
		if (raid.isparty and RaidBuffStatus.db.profile.AutoShowDashParty) or (raid.israid and RaidBuffStatus.db.profile.AutoShowDashRaid) then
			RaidBuffStatus:ShowReportFrame()
		end
	end
	if not oldbattle and raid.isbattle then -- just entered a pvp battle zone (not necessarily a raid/party transition, eg arenas)
		if RaidBuffStatus.db.profile.AutoShowDashBattle then
			RaidBuffStatus:ShowReportFrame()
		else
			RaidBuffStatus:HideReportFrame()
		end
	end
end


function RaidBuffStatus:OnEnable()
	local svnrev = 0
        RBS_svnrev["X-Build"] = select(3,string.find(GetAddOnMetadata("RaidBuffStatus", "X-Build") or "", "(%d+)"))
        RBS_svnrev["X-Revision"] = select(3,string.find(GetAddOnMetadata("RaidBuffStatus", "X-Revision") or "", "(%d+)"))
	for _,v in pairs(RBS_svnrev) do -- determine highest file revision
	  local nv = tonumber(v)
	  if nv and nv > svnrev then
	    svnrev = nv
	  end
	end
	RaidBuffStatus.revision = svnrev

        RBS_svnrev["X-Curse-Packaged-Version"] = GetAddOnMetadata("RaidBuffStatus", "X-Curse-Packaged-Version")
        RBS_svnrev["Version"] = GetAddOnMetadata("RaidBuffStatus", "Version")
	RaidBuffStatus.version = RBS_svnrev["X-Curse-Packaged-Version"] or RBS_svnrev["Version"] or "@"
	if string.find(RaidBuffStatus.version, "@") then -- dev copy uses "@.project-version.@"
           RaidBuffStatus.version = "r"..svnrev
	end
	
	RaidBuffStatus:SendVersion()
	RaidBuffStatus.versiontimer = RaidBuffStatus:ScheduleRepeatingTimer(RaidBuffStatus.SendVersion, 5 * 60)
	RaidBuffStatus:RegisterEvent("PLAYER_REGEN_ENABLED", "LeftCombat")
	if (InCombatLockdown()) then
		return
	end
	RaidBuffStatus:DelayedEnable()
end

function RaidBuffStatus:DelayedEnable()
	RaidBuffStatus.delayedenablecalled = true
	RaidBuffStatus:ValidateSpellIDs()
	RaidBuffStatus:SetupFrames()
	RaidBuffStatus:ScheduleTimer(function()
		RaidBuffStatus:IconFix()
	end, 15) -- to handle icons not being downloaded from the server yet HORRIBLE CODING!!
	RaidBuffStatus:ScheduleTimer(function()
		RaidBuffStatus:UpdateFeastData()
	end, 15) -- handle cache delay on feast spellnames
	RaidBuffStatus:JoinedPartyRaidChanged()
	RaidBuffStatus:UpdateMiniMapButton()
	RaidBuffStatus:RegisterEvent("GROUP_ROSTER_UPDATE", "JoinedPartyRaidChanged")
	RaidBuffStatus:RegisterEvent("PLAYER_ENTERING_WORLD", "JoinedPartyRaidChanged")
	RaidBuffStatus:RegisterEvent("PLAYER_REGEN_DISABLED", "EnteringCombat")
	RaidBuffStatus:RegisterEvent("PET_BATTLE_OPENING_START", "EnteringPetCombat")
	RaidBuffStatus:RegisterEvent("PET_BATTLE_CLOSE", "LeftPetCombat")
	RaidBuffStatus:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "COMBAT_LOG_EVENT_UNFILTERED")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_ADDON", "CHAT_MSG_ADDON")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_RAID_WARNING",	 	"CHAT_MSG_RAID_WARNING")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_PARTY", 			"CHAT_MSG_RAID_WARNING")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_PARTY_LEADER", 		"CHAT_MSG_RAID_WARNING")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_RAID", 			"CHAT_MSG_RAID_WARNING")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_RAID_LEADER", 		"CHAT_MSG_RAID_WARNING")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_INSTANCE_CHAT", 		"CHAT_MSG_RAID_WARNING")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER", 	"CHAT_MSG_RAID_WARNING")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_BN_WHISPER", "CHAT_MSG_BN_WHISPER")
	RaidBuffStatus:RegisterEvent("PARTY_INVITE_REQUEST", "PARTY_INVITE_REQUEST")
	if not _G.oRA3 then
		RaidBuffStatus:RegisterEvent("PLAYER_DEAD", "SendDurability")
		RaidBuffStatus:RegisterEvent("ZONE_CHANGED_NEW_AREA", "SendDurability")
		RaidBuffStatus:RegisterEvent("MERCHANT_CLOSED", "SendDurability")
	end
--	RaidBuffStatus:Debug('Enabled!')
	if oRA then
		RaidBuffStatus:Debug('Registering oRA tank event')
		RaidBuffStatus.oRAEvent:RegisterForTankEvent(function() RaidBuffStatus:oRA_MainTankUpdate() end)
	elseif XPerl_MainTanks then
		RaidBuffStatus:Debug('XPerl_MainTanks')
	elseif CT_RA_MainTanks then
		RaidBuffStatus:Debug('Registering CTRA event')
		hooksecurefunc("CT_RAOptions_UpdateMTs", function() RaidBuffStatus:oRA_MainTankUpdate() end)
	end
	RaidBuffStatus.Prefixes = {["RBS"]=1, ["oRA3"]=1, ["CTRA"]=1}
	for prefix,_ in pairs(RaidBuffStatus.Prefixes) do
	  RegisterAddonMessagePrefix(prefix)
	end
	hooksecurefunc(StaticPopupDialogs["RESURRECT"], "OnShow", function()
		RaidBuffStatus:SendRezMessage("RESSED")
	end)
	WorldMapFrame:Show()
	WorldMapFrame:Hide() 
        GameTooltip:HookScript("OnTooltipSetItem", AddTTFeastBonus)
        ItemRefTooltip:HookScript("OnTooltipSetItem", AddTTFeastBonus)
end

function RaidBuffStatus:OnDisable()
	RaidBuffStatus:Debug('Disabled!')
	RaidBuffStatus:UnregisterAllEvents()
	RaidBuffStatus.oRAEvent:UnRegisterForTankEvent()
end

function RaidBuffStatus:EnteringCombat(force)
	incombat = true
	if (InCombatLockdown()) then
		return
	end
	RaidBuffStatus.lasttobuf = ""
	if RaidBuffStatus.db.profile.HideInCombat or (force == true) then
		if RaidBuffStatus.frame:IsVisible() then
			dashwasdisplayed = true
			RaidBuffStatus:HideReportFrame()
		else
			dashwasdisplayed = false
		end
		return
	end
	RaidBuffStatus:AddBuffButtons()
	RaidBuffStatus:UpdateButtons()
end

function RaidBuffStatus:LeftCombat(force)
	if not RaidBuffStatus.delayedenablecalled then
		RaidBuffStatus:DelayedEnable()
	end
	incombat = false
	RaidBuffStatus:AddBuffButtons()
	RaidBuffStatus:UpdateButtons()
	if (force == true or RaidBuffStatus.db.profile.HideInCombat) and dashwasdisplayed then
		RaidBuffStatus:ShowReportFrame()	
	end
end

function RaidBuffStatus:EnteringPetCombat()
	RaidBuffStatus:EnteringCombat(true)
end
function RaidBuffStatus:LeftPetCombat()
	RaidBuffStatus:LeftCombat(true)
end

function RaidBuffStatus:Tooltip(self, title, list, tlist, blist, slist, pallyblessingsmessagelist, itemcountlist, unknownlist, kingsbuffer, mightbuffer, gotitlist, zonelist, itemlist)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(title,1,1,1,1,1)
	local str = ""
	if list then
		if #list > 0 then
			local thelisttouse = list
			local timerlist = {}
			if tlist then
				for _, n in ipairs(list) do
					if tlist[n] then
						table.insert(timerlist, n .. "(" .. RaidBuffStatus:TimeSince(tlist[n]) .. ")")
					else
						table.insert(timerlist, n)
					end
				end
				thelisttouse = timerlist
			end
			for _,s in pairs({strsplit(" ", table.concat(thelisttouse, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,nil,nil,nil,1)
		end
	end
	if blist then
		if #blist > 0 then
			str = L["Buffers: "]
			for _,s in pairs({strsplit(" ", table.concat(blist, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, 1)
		end
	end
	if kingsbuffer and kingsbuffer ~= "" then
		GameTooltip:AddLine(L["Buffing Kings:"] .. " " .. kingsbuffer, nil, nil, nil, 1)
	end
	if mightbuffer and mightbuffer ~= "" then
		GameTooltip:AddLine(L["Buffing Might:"] .. " " .. mightbuffer, nil, nil, nil, 1)
	end
	if gotitlist then
		if #gotitlist > 0 then
			str = L["Has buff: "]
			for _,s in pairs({strsplit(" ", table.concat(gotitlist, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,nil,nil,nil,1)
		else
			if RaidBuffStatus:DicSize(gotitlist) > 0 then
				GameTooltip:AddDoubleLine(L["Has buff: "], L["Cast by:"], nil, nil, nil, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
				for name, caster in pairs(gotitlist) do
					GameTooltip:AddDoubleLine(name, caster, nil, nil, nil, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
				end
			end
		end
	end
	if slist then
		if #slist > 0 then
			str = L["Slackers: "]
			for _,s in pairs({strsplit(" ", table.concat(slist, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1)
		end
	end
	if pallyblessingsmessagelist then
		for message,_ in pairs(pallyblessingsmessagelist) do
			GameTooltip:AddLine(message,GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, 1)
		end
	end
	if itemcountlist then
		if #itemcountlist > 0 then
			GameTooltip:AddLine(L["Item count: "], 1, 0, 1, 1)
			for _,s in pairs(itemcountlist) do
				GameTooltip:AddLine(s, 1, 0, 1, 1)
			end
		end
	end
	if unknownlist then
		if #unknownlist > 0 then
			str = L["Missing or not working oRA or RBS: "]
			for _,s in pairs({strsplit(" ", table.concat(unknownlist, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1)
		end
	end
	if zonelist then
--		if #zonelist > 5 then
--			GameTooltip:AddLine(table.concat(zonelist, ", "),nil,nil,nil,1)
--		else
			for _,name in pairs(zonelist) do
				local unit = RaidBuffStatus:GetUnitFromName(name)
				local zone = ""
				if unit and unit.zone then
					zone = unit.zone
				end
				GameTooltip:AddDoubleLine(name, zone,nil,nil,nil,1,0,0)
			end
--		end
	end
	if itemlist then
		for name, num in pairs(itemlist) do
			GameTooltip:AddDoubleLine(name, num, nil, nil, nil, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		end
	end
	GameTooltip:Show()
end

function RaidBuffStatus:DefaultButtonUpdate(self, thosemissing, profile, checking, morework)
	if profile == false then
		self.count:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		self.count:SetText("X")
		self:SetAlpha("0.5")
	else
		if checking then
			local r = NORMAL_FONT_COLOR.r
			local g = NORMAL_FONT_COLOR.g
			local b = NORMAL_FONT_COLOR.b
			if RaidBuffStatus.db.profile.HighlightMyBuffs then
				if #thosemissing > 0 then
					if morework and RaidBuffStatus:AmIListed(morework) then
						r = RED_FONT_COLOR.r
						g = RED_FONT_COLOR.g
						b = RED_FONT_COLOR.b
					elseif RaidBuffStatus:AmIListed(thosemissing) then
						r = 0
						g = 1
						b = 1
					end
				end
			end
			self.count:SetTextColor(r, g, b)
			self.count:SetText(#thosemissing)
			self:SetAlpha("1")
		else
			self.count:SetText("")
			self:SetAlpha("0.15")
		end
	end
end


function RaidBuffStatus:ButtonClick(self, button, down, buffcheck, cheapspell, nonselfbuff, bagitem, itemslot)
        RaidBuffStatus:Debug("button="..(button or "nil")..
	                     " buffcheck="..(buffcheck or "nil")..
	                     " cheapspell="..(cheapspell or "nil")..
	                     " nonselfbuff="..(nonselfbuff and "true" or "false")..
	                     " bagitem="..(bagitem or "nil")..
	                     " itemslot="..(itemslot or "nil"))
	local BF = RaidBuffStatus.BF
	local check = BF[buffcheck].check
	local prefix
	if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
		prefix = L["Missing buff: "]
	else
		prefix = L["Warning: "]
	end
	if RaidBuffStatus.db.profile[check] then
		local action = "none"
		if button == "LeftButton" then
			if IsAltKeyDown() then
				action = RaidBuffStatus.db.profile.AltLeftClick
			elseif IsShiftKeyDown() then
				action = RaidBuffStatus.db.profile.ShiftLeftClick
			elseif IsControlKeyDown() then
				action = RaidBuffStatus.db.profile.ControlLeftClick
			else
				action = RaidBuffStatus.db.profile.LeftClick
			end
		elseif button == "RightButton" then
			if IsAltKeyDown() then
				action = RaidBuffStatus.db.profile.AltRightClick
			elseif IsShiftKeyDown() then
				action = RaidBuffStatus.db.profile.ShiftRightClick
			elseif IsControlKeyDown() then
				action = RaidBuffStatus.db.profile.ControlRightClick
			else
				action = RaidBuffStatus.db.profile.RightClick
			end
		end
		if not InCombatLockdown() then
			self:SetAttribute("type", nil)
			self:SetAttribute("spell", nil)
			self:SetAttribute("unit", nil)
			self:SetScript("PostClick", nil)
			self:SetAttribute("item", nil)
		end
		if cheapspell and action == "buff" then
			RaidBuffStatus:DoReport()
			if not InCombatLockdown() and # report[BF[buffcheck].list] > 0 then
				self:SetAttribute("type", "spell")
				if nonselfbuff then
					if # report[BF[buffcheck].list] > 0 then
						local unitidtobuff, spelltobuff
						if BF[buffcheck].raidbuff then
							unitidtobuff, spelltobuff = RaidBuffStatus:RaidBuff(report[BF[buffcheck].list], cheapspell)
						elseif BF[buffcheck].partybuff then
							unitidtobuff, spelltobuff = RaidBuffStatus:PartyBuff(report[BF[buffcheck].list], cheapspell)
						elseif BF[buffcheck].singlebuff then
							unitidtobuff, spelltobuff = RaidBuffStatus:SingleBuff(report[BF[buffcheck].list], cheapspell)
						end
						self:SetAttribute("spell", spelltobuff)
						self:SetAttribute("unit", unitidtobuff)
						if unitidtobuff then  -- maybe none in range
							self:SetScript("PostClick", function(self)
								if rezspellshash[self:GetAttribute("spell")] then
									RaidBuffStatus:SendRezMessage("RES " .. UnitName(self:GetAttribute("unit")))
								end
								self:SetAttribute("type", nil)
								self:SetAttribute("spell", nil)
								self:SetAttribute("unit", nil)
								self:SetScript("PostClick", nil)
							end)
						end
					end
				else
					self:SetAttribute("spell", cheapspell)
					self:SetAttribute("target-slot", itemslot)
					self:SetAttribute("unit", "player") -- buff self to hit group, in case we're targetting a friendly NPC
					self:SetScript("PostClick", function(self)
						self:SetAttribute("spell", nil)
						self:SetAttribute("target-slot", nil)
					        self:SetAttribute("unit", nil)
						self:SetScript("PostClick", nil)
					end)					
				end
			end
		elseif bagitem and action == "buff" then
			RaidBuffStatus:DoReport()
			if not InCombatLockdown() and # report[BF[buffcheck].list] > 0 then
				for _, name in ipairs(report[BF[buffcheck].list]) do
					local unit = RaidBuffStatus:GetUnitFromName(name)
					if unit and unit.unitid and not unit.isdead and unit.online and UnitInRange(unit.unitid) then
						self:SetAttribute("type", "item")
						self:SetAttribute("item", bagitem)
						self:SetAttribute("target-slot", itemslot)
						self:SetScript("PostClick", function(self)
							self:SetAttribute("type", nil)
							self:SetAttribute("item", nil)
							self:SetAttribute("target-slot", nil)
							self:SetScript("PostClick", nil)
						end)
						break
					end
				end
			end
		elseif action == "report" then
			RaidBuffStatus:DoReport(true)
	                local canspeak = UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or raid.pug
			if not canspeak and RaidBuffStatus.db.profile.ReportChat and raid.israid then
				RaidBuffStatus:OfficerWarning()
			end
			if type(BF[buffcheck].chat) == "string" then
				if # report[BF[buffcheck].list] > 0 then
					if BF[buffcheck].timer then
						local timerlist = {}
						for _, n in ipairs(report[BF[buffcheck].list]) do
							if raid.BuffTimers[buffcheck .. "timerlist"][n] then
								table.insert(timerlist, n .. "(" .. RaidBuffStatus:TimeSince(raid.BuffTimers[buffcheck .. "timerlist"][n]) .. ")")
							else
								table.insert(timerlist, n)
							end
						end
						RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. table.concat(timerlist, ", "))
					else
						RaidBuffStatus:Say(prefix .. "<" .. BF[buffcheck].chat .. ">: " .. table.concat(report[BF[buffcheck].list], ", "))
					end
				end
			elseif type(BF[buffcheck].chat) == "function" then
				BF[buffcheck].chat(report, raid, prefix)
			end
		elseif action == "whisper" then
			RaidBuffStatus:DoReport(true)
			RaidBuffStatus:WhisperBuff(BF[buffcheck], report, raid, prefix)
			
		elseif action == "enabledisable" then
			RaidBuffStatus:ToggleCheck(check)
		end
	else
		RaidBuffStatus:ToggleCheck(check)
	end
end

function RaidBuffStatus:WhisperBuff(buff, report, raid, prefix)
	if buff.selfbuff then
		if type(buff.chat) == "string" then
			if # report[buff.list] > 0 then
				for _, v in ipairs(report[buff.list]) do
					local name = v
					if v:find("%(") then
						name = string.sub(v, 1, v:find("%(") - 1)
					end
					RaidBuffStatus:Say(prefix .. "<" .. buff.chat .. ">: " .. v, name)
				end
			end
		elseif type(buff.chat) == "function" then
			buff.chat(report, raid, prefix)
		end
	elseif buff.whispertobuff then
		if #report[buff.list] > 0 then
			buff.whispertobuff(report[buff.list], prefix, buff.buffinfo)
		end
	end
end

function RaidBuffStatus:SortNameBySuffix(thetable)
	table.sort(thetable, function (a,b)
		local grpa = select(3, a:find"(%d+)")
		local grpb = select(3, b:find"(%d+)")
		if grpa and grpb then
			if grpa == grpb then
				return a < b
			end
			return grpa < grpb
		else
			return a < b
		end
	end)
end

function RaidBuffStatus:TitleCaps(str)
	str = string.lower(str)
	return str:gsub("%a", string.upper, 1)
end

function RaidBuffStatus:TimeSince(thetimethen)
	local thedifference = math.floor(GetTime() - thetimethen)
	if thedifference < 60 then
		return (thedifference .. "s")
	end
	return (math.floor(thedifference / 60) .. "m" .. (thedifference % 60) .. "s")
end


function RaidBuffStatus:GetUnitFromName(whom)
	local p = whom:find("%(")
	if p then
		whom = string.sub(whom, 1, p - 1)
	end
	for class,cinfo in pairs(raid.classes) do
		local u = cinfo[whom]
		if u then return u end
	end
	return nil
end


function RaidBuffStatus:RaidBuff(list, cheapspell) -- raid-wide buffs
	local usable, nomana = IsUsableSpell(cheapspell)
	if not usable and not nomana then
		return nil
	end
	local pb = {}
	local outofrange
	local thiszone = RaidBuffStatus:GetMyZone()
	for _, v in ipairs(list) do
		local unit = RaidBuffStatus:GetUnitFromName(v)
		if unit and unit.unitid and (not unit.isdead or rezspellshash[cheapspell]) and unit.online and (not raid.israid or unit.zone == thiszone) then
			table.insert(pb, unit)
		end
	end
--	RaidBuffStatus:Debug("starting sort")
	table.sort(pb, function (a,b)
		if a == nil then
			RaidBuffStatus:Debug("sort failing - a is nil")
			return false
		end
		if b == nil then
			RaidBuffStatus:Debug("sort failing - b is nil")
			return true
		end
--		RaidBuffStatus:Debug("comparing:" .. a.name .. "(" .. a.class .. ") " .. b.name .. "(" .. b.class .. ")")
		if a.unitid == RaidBuffStatus.lasttobuf then
			return false
		end
		if b.unitid == RaidBuffStatus.lasttobuf then
			return true
		end
		local arezeetime = RaidBuffStatus.rezeetime[a.name] or 0
		local brezeetime = RaidBuffStatus.rezeetime[b.name] or 0
		if arezeetime ~= brezeetime then
			return arezeetime < brezeetime
		end
		local foundb = false
		for _, name in pairs(RaidBuffStatus.rezerrezee) do
			if name == a.name then
				return false
			end
			if name == b.name then
				foundb = true
			end
		end
		if foundb then
			return true
		end
		if rezclasses[a.class] and not rezclasses[b.class] then
			return true
		end
		if rezclasses[b.class] then
			return false
		end
		if raid.israid  then
			local myx, myy = GetPlayerMapPosition("player")
			local ax, ay = GetPlayerMapPosition(a.unitid)
			local bx, by = GetPlayerMapPosition(b.unitid)
			if (myx == 0 and myy == 0) or (ax == 0 and ay == 0) or (bx == 0 and by == 0) then
				return false
			end
			local adist = math.pow(myx-ax, 2) + math.pow(myy-ay, 2)
			local bdist = math.pow(myx-bx, 2) + math.pow(myy-by, 2)
--			RaidBuffStatus:Debug(a.name .. " " .. adist)
--			RaidBuffStatus:Debug(b.name .. " " .. bdist)
			return (bdist < adist)
		end
		return false
	end)
--	RaidBuffStatus:Debug("finished sort")
	for _, v in ipairs(pb) do
		if IsSpellInRange(cheapspell, v.unitid) == 1 or rezspellshash[cheapspell] then
			RaidBuffStatus.lasttobuf = v.unitid
--			if #pb >= RaidBuffStatus.db.profile.HowMany and reagentspell then
--				if RaidBuffStatus:GotReagent(reagent) then
--					return v.unitid, reagentspell
--				end
--			end
			return v.unitid, cheapspell
		end
		outofrange = RaidBuffStatus:UnitNameRealm(v.unitid)
	end
	if #pb == 0 then
		return nil
	end
	RaidBuffStatus:Print("RBS: " .. L["Out of range"] .. ": " .. outofrange)
	UIErrorsFrame:AddMessage("RBS: " .. L["Out of range"] .. ": " .. outofrange, 0, 1.0, 1.0, 1.0, 1)
	return nil
end

function RaidBuffStatus:PartyBuff(list, cheapspell) -- party-wide buffs
	local usable, nomana = IsUsableSpell(cheapspell)
	if not usable and not nomana then
		return nil
	end
	local pb = {{},{},{},{},{},{},{},{}}
	local outofrange
	for _, v in ipairs(list) do
		local unit = RaidBuffStatus:GetUnitFromName(v)
		if unit and unit.unitid and not unit.isdead and unit.online then
			table.insert(pb[unit.group], unit.unitid)
		end
	end
	table.sort(pb, function (a,b)
		return(#a > #b)
	end)
	for i,_ in ipairs(pb) do
		for _, v in ipairs(pb[i]) do
			if IsSpellInRange(cheapspell, v) == 1 then
--				if #pb[i] >= RaidBuffStatus.db.profile.HowMany then
--					if RaidBuffStatus:GotReagent(reagent) then
--						return v, reagentspell
--					end
--				end
--				return v, cheapspell
			end
			outofrange = v
		end
	end
	if #pb == 0 then
		return nil
	end
	RaidBuffStatus:Print("RBS: " .. L["Out of range"] .. ": " .. outofrange)
	UIErrorsFrame:AddMessage("RBS: " .. L["Out of range"] .. ": " .. outofrange, 0, 1.0, 1.0, 1.0, 1)
	return nil
end

function RaidBuffStatus:SingleBuff(list, cheapspell) -- single unit buffs
	local usable, nomana = IsUsableSpell(cheapspell)
	if not usable and not nomana then
		return nil
	end
	return RaidBuffStatus:RaidBuff(list, cheapspell)
end

function RaidBuffStatus:GotReagent(reagent)
	if reagent == nil then
		return true
	end
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local item = GetContainerItemLink(bag, slot);
			if item then
				if string.find(item, "[" .. reagent .. "]", 1, true) then
					return true
				end
			end
		end
	end
	return false
end

function RaidBuffStatus:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, subevent, hideCaster, 
	srcGUID, srcname, srcflags, srcRaidFlags, 
	dstGUID, dstname, dstflags, dstRaidFlags, 
	spellID, spellname, spellschool, extraspellID, extraspellname, extraspellschool, auratype)
	if not raid.israid and not raid.isparty then
		return
	end
	if not subevent then
		return
	end
	if (subevent == "UNIT_DIED" and band(dstflags,COMBATLOG_OBJECT_TYPE_PLAYER) > 0) or 
	   (spellID == 27827 and subevent == "SPELL_AURA_APPLIED") then -- Spirit of Redemption
		--RaidBuffStatus:Debug(subevent .. " someone died:" .. dstname)
		local unit = RaidBuffStatus:GetUnitFromName(dstname)
		if not unit then
			return
		end
		if subevent == "UNIT_DIED" and unit.spec == 2 then -- Holy
			RaidBuffStatus:Debug("was a priest with spirit of redemption")
			return
		end
		RaidBuffStatus:SomebodyDied(unit)
		return
	end
	if not spellID or not spellname then -- must come after UNIT_DIED, which has no spell
		return
	end
	if (spellID == 20707 or spellID == 6203) and 
	   (subevent == "SPELL_CAST_SUCCESS" or subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_AURA_REFRESH") then 
		RaidBuffStatus:LockSoulStone(srcname)
		RaidBuffStatus:Debug("Lock cast soulstone:" .. srcname .. " " .. subevent)
		return
	end
	if (spellID == 34477 or spellID == 57934) and
	   subevent == "SPELL_CAST_SUCCESS" and 
	   RaidBuffStatus.db.profile.misdirectionwarn and
	   RaidBuffStatus:IsInRaid(srcname) then
		RaidBuffStatus:MisdirectionEventLog(srcname, spellname, dstname)
		return
	end
	if not incombat then
			if not srcname or not RaidBuffStatus:IsInRaid(srcname) then
				return
			end
			if rezspellshash[spellname] then
				if subevent == "SPELL_CAST_START" then
					RaidBuffStatus:Debug(srcname .. " rezing someone")
				elseif subevent == "SPELL_CAST_FAILED" then
					RaidBuffStatus:Debug(srcname .. " rezing someone failed")
					RaidBuffStatus.rezerrezee[srcname] = nil
					if srcGUID == playerid then
						RaidBuffStatus:SendRezMessage("RESNO")
					end
				elseif subevent == "SPELL_CAST_SUCCESS" then
					RaidBuffStatus:Debug(srcname .. " rezing someone success")
					if RaidBuffStatus.rezerrezee[srcname] then
						RaidBuffStatus.rezeetime[RaidBuffStatus.rezerrezee[srcname]] = GetTime()
					end
					RaidBuffStatus.rezerrezee[srcname] = nil
					if srcGUID == playerid then
						RaidBuffStatus:SendRezMessage("RESNO")
					end
				end
				return
			else
				RaidBuffStatus.rezerrezee[srcname] = nil
			end
			if subevent == "SPELL_CAST_START" then
				if feastdata[spellID] then
					RaidBuffStatus:Announces("Feast", srcname, nil, spellID)
				elseif spellID == 92649 or spellID == 92712 then -- (Big) Cauldron of Battle
					RaidBuffStatus:Announces("Cauldron", srcname, nil, spellID)
				elseif spellID == 43987 then -- Ritual of Refreshment 
					RaidBuffStatus:Announces("Table", srcname, nil, spellID)
				elseif spellID == 29893 then -- Ritual of Souls 
					RaidBuffStatus:Announces("Soul", srcname, nil, spellID)
					RaidBuffStatus.soulwelllastseen = GetTime() + 120
				end
				return
			elseif subevent == "SPELL_CAST_SUCCESS" then
				if spellID == 67826 or spellID == 22700 or spellID == 44389 or spellID == 54711 then -- Jeeves, Field Repair Bot 74A, Field Repair Bot 110G, Scrapbot
					RaidBuffStatus:Announces("Repair", srcname, nil, spellID)
				elseif spellID == 126459 then
					RaidBuffStatus:Announces("Blingtron", srcname, nil, spellID)
				end
			end
	end
	if not dstflags or band(dstflags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 then
		return  -- the destination is a player and we only care about stuff to mobs
	end
	-- else do workaround for broken polymorph combat log
	if (subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_AURA_REMOVED") and 
	   workaroundbugccspellshash[spellname] and RaidBuffStatus.db.profile.ccwarn then
		if not srcname or not RaidBuffStatus:IsInRaid(srcname) then
			return
		end
		RaidBuffStatus:WorkAroundBugCCEvent(event, timestamp, subevent, 
			srcGUID, srcname, srcflags, srcRaidFlags, 
			dstGUID, dstname, dstflags, dstRaidFlags,
			spellID, spellname, spellschool, extraspellID, extraspellname)
	elseif dstGUID and currentsheep[dstGUID] and RaidBuffStatus.db.profile.ccwarn then
		RaidBuffStatus:Debug("was sheeped")
--		if not srcname or not RaidBuffStatus:IsInRaid(srcname) then
--			return
--		end
		if (GetTime() - currentsheep[dstGUID]) > 35 then
			currentsheep[dstGUID] = nil
			currentsheepspell[dstGUID] = nil
			return
		end
		if subevent:find("DAMAGE") then
			RaidBuffStatus:Debug("got dmg")
			if spellID == 339 then -- Entangling Roots do dmg but don't break
				RaidBuffStatus:Debug("but it was roots")
				return
			end
		else
			RaidBuffStatus:Debug("returning")
			return
		end
		-- Fake a CC break event.
		RaidBuffStatus:Debug("faking broken:" .. spellID .. " " .. spellname)
		if subevent == "SWING_DAMAGE" then
			spellname = L["Melee Swing"]
		end
		RaidBuffStatus:CCEventLog(event, timestamp, "SPELL_AURA_BROKEN_SPELL", 
			srcGUID, srcname, srcflags, srcRaidFlags, 
			dstGUID, dstname, dstflags, dstRaidFlags,
			currentsheepspell[dstGUID], BS[currentsheepspell[dstGUID]], spellschool, spellID, spellname)
		currentsheep[dstGUID] = nil
		currentsheepspell[dstGUID] = nil
	elseif taunthash[spellID] and (subevent == "SPELL_MISSED" or subevent == "SPELL_AURA_APPLIED") and 
	       RaidBuffStatus.db.profile.tankwarn then
		if not srcname or not RaidBuffStatus:IsInRaid(srcname) then
			return
		end
		RaidBuffStatus:TauntEventLog(event, timestamp, subevent, 
			srcGUID, srcname, srcflags, srcRaidFlags, 
			dstGUID, dstname, dstflags, dstRaidFlags,
			spellID, spellname, spellschool, extraspellID, extraspellname)
	elseif (subevent == "SPELL_AURA_BROKEN" or subevent == "SPELL_AURA_BROKEN_SPELL" ) and 
	       ccspellshash[spellname] and RaidBuffStatus.db.profile.ccwarn then
		if not srcname or not RaidBuffStatus:IsInRaid(srcname) then
			return
		end
		RaidBuffStatus:CCEventLog(event, timestamp, subevent, 
			srcGUID, srcname, srcflags, srcRaidFlags, 
			dstGUID, dstname, dstflags, dstRaidFlags,
			spellID, spellname, spellschool, extraspellID, extraspellname)
	end
end

function RaidBuffStatus:WorkAroundBugCCEvent(event, timestamp, subevent, 
	srcGUID, srcname, srcflags, srcRaidFlags, 
	dstGUID, dstname, dstflags, dstRaidFlags, 
	spellID, spellname, spellschool, extraspellID, extraspellname)
	if subevent == "SPELL_AURA_APPLIED" then
		currentsheep[dstGUID] = GetTime()
		currentsheepspell[dstGUID] = spellID
	else
		if currentsheep[dstGUID] and (GetTime() - currentsheep[dstGUID]) > 35 then -- likely just expired
			currentsheep[dstGUID] = nil
			currentsheepspell[dstGUID] = nil
		end
	end
end

function RaidBuffStatus:MisdirectionEventLog(srcname, spellname, dstname)
	if RaidBuffStatus.db.profile.misdirectionself then
		UIErrorsFrame:AddMessage(L["%s cast %s on %s"]:format(srcname, spellname, dstname), 0, 1.0, 1.0, 1.0, 1)
		RaidBuffStatus:Print(L["%s cast %s on %s"]:format(srcname, spellname, dstname))
	end
	if RaidBuffStatus.db.profile.misdirectionsound then
		PlaySoundFile("Sound\\Doodad\\ET_Cage_Close.wav", "Master")
	end
end


function RaidBuffStatus:CCEventLog(event, timestamp, subevent, 
	srcGUID, srcname, srcflags, srcRaidFlags, 
	dstGUID, dstname, dstflags, dstRaidFlags, 
	spellID, spellname, spellschool, extraspellID, extraspellname)
	if not spellID or not dstGUID or not srcname then
		return
	end
	if band(tonumber(dstGUID:sub(0,5), 16), 0x00f) ~= 0x003 then
		return  -- the destination is not a creature
	end
	if RaidBuffStatus.db.profile.cconlyme and not srcGUID == playerid then
		return
	end
	local unit = RaidBuffStatus:GetUnitFromName(srcname)
	if not unit then -- must be pet or someone outside the raid interferring
		unit = {}
	end
	local cctype = "ccwarnnontank"
	local prepend =  true
	if unit.istank then
		cctype = "ccwarntank"
		prepend = false
	end
	local dsticon = dstRaidFlags and RaidBuffStatus:GetIcon(dstRaidFlags) or ""
	if dsticon ~= "" then
		dsticon = "{rt" .. dsticon .. "}"
	end
	if subevent == "SPELL_AURA_BROKEN" then
		if prepend then
			RaidBuffStatus:CCBreakSay((L["Non-tank %s broke %s on %s%s%s"]):format(srcname, spellname, dsticon, dstname, dsticon), cctype)
		else
			RaidBuffStatus:CCBreakSay((L["%s broke %s on %s%s%s"]):format(srcname, spellname, dsticon, dstname, dsticon), cctype)
		end
		
	elseif subevent == "SPELL_AURA_BROKEN_SPELL" then
		if prepend then
			RaidBuffStatus:CCBreakSay((L["Non-tank %s broke %s on %s%s%s with %s"]):format(srcname, spellname, dsticon, dstname, dsticon, extraspellname), cctype)
		else
			RaidBuffStatus:CCBreakSay((L["%s broke %s on %s%s%s with %s"]):format(srcname, spellname, dsticon, dstname, dsticon, extraspellname), cctype)
		end
	end
end


function RaidBuffStatus:TauntEventLog(event, timestamp, subevent, 
	srcGUID, srcname, srcflags, srcRaidFlags, 
	dstGUID, dstname, dstflags, dstRaidFlags, 
	spellID, spellname, spellschool, misstype)
	if not taunthash[spellID] then
		return
	end
	local targetid = UnitGUID("target")
	local mytarget = true
	if dstGUID ~= targetid then
		if not RaidBuffStatus.db.profile.tauntmeself and not RaidBuffStatus.db.profile.tauntmesound and not RaidBuffStatus.db.profile.tauntmerw and not RaidBuffStatus.db.profile.tauntmeraid and not RaidBuffStatus.db.profile.tauntmeparty then
			return
		end
		if band(dstflags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 then
			return  -- the destination is not a creature
		end
		mytarget = false
	end
	local boss = false
	if UnitLevel("target") == -1 then
		boss = true
	end
	if RaidBuffStatus.db.profile.bossonly and not boss then
		return
	end
	local dsticon = dstRaidFlags and RaidBuffStatus:GetIcon(dstRaidFlags) or ""
	if dsticon ~= "" then
		dsticon = "{rt" .. dsticon .. "}"
	end
	local miss = ""
	if subevent == "SPELL_MISSED" then
		if misstype == "EVADE" or misstype == "IMMUNE" then
			miss = L["[IMMUNE]"]
		else
			miss = L["[RESIST]"]
		end
	end
	if srcGUID == playerid then
		if subevent ~= "SPELL_MISSED" then
			return
		end
		if misstype == "EVADE" or misstype == "IMMUNE" then
			if boss then
				RaidBuffStatus:TauntSay(miss .. " " .. L["%s FAILED TO TAUNT their boss target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "failedtauntimmune")
			else
				RaidBuffStatus:TauntSay(miss .. " " .. L["%s FAILED TO TAUNT their target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "failedtauntimmune")
			end
		else
			if boss then
				RaidBuffStatus:TauntSay(miss .. " " .. L["%s FAILED TO TAUNT their boss target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "failedtauntresist")
			else
				RaidBuffStatus:TauntSay(miss .. " " .. L["%s FAILED TO TAUNT their target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "failedtauntresist")
			end
		end
		return
	end
	if not mytarget then
		if subevent ~= "SPELL_AURA_APPLIED" then
			return -- only care about suceeding taunts to mobs targeting me
		end
		if UnitGUID(srcname .. "-target") == dstGUID and UnitGUID(srcname .. "-target-target") == playerid then
			if boss then
				RaidBuffStatus:TauntSay(L["%s taunted my boss mob (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "tauntme")
			else
				RaidBuffStatus:TauntSay(L["%s taunted my mob (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "tauntme")
			end
		end
		return
	end
	local ninja = false
	if UnitGUID("targettarget") == playerid then
		ninja = true
	end
	if subevent == "SPELL_AURA_APPLIED" then
		local unit = RaidBuffStatus:GetUnitFromName(srcname)
		if not unit then
			return
		end
		if unit.istank then
			if ninja then
				if boss then
					RaidBuffStatus:TauntSay(L["%s ninjaed my boss target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "ninjataunt")
				else
					RaidBuffStatus:TauntSay(L["%s ninjaed my target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "ninjataunt")
				end
			else
				if boss then
					RaidBuffStatus:TauntSay(L["%s taunted my boss target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "taunt")
				else
					RaidBuffStatus:TauntSay(L["%s taunted my target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "taunt")
				end
			end
		else
			if boss then
				RaidBuffStatus:TauntSay(L["NON-TANK %s taunted my boss target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "nontanktaunt")
			else
				RaidBuffStatus:TauntSay(L["NON-TANK %s taunted my target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "nontanktaunt")
			end
		end
	else
		if ninja then
			if boss then
				RaidBuffStatus:TauntSay(miss .. " " .. L["%s FAILED TO NINJA my boss target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "otherfail")
			else
				RaidBuffStatus:TauntSay(miss .. " " .. L["%s FAILED TO NINJA my target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "otherfail")
			end
		else
			if boss then
				RaidBuffStatus:TauntSay(miss .. " " .. L["%s FAILED TO TAUNT my boss target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "otherfail")
			else
				RaidBuffStatus:TauntSay(miss .. " " .. L["%s FAILED TO TAUNT my target (%s%s%s) with %s"]:format(srcname, dsticon, dstname, dsticon, spellname), "otherfail")
			end
		end
	end
end

local function EventReport(msg, dorw, doraid, doparty, doself)
  if doself then
    local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
    UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
    RaidBuffStatus:Print(fancyicon)
  end
  if raid.isbattle then return end
  local canspeak = UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")
  if dorw and raid.israid then
    if not canspeak then
       RaidBuffStatus:OfficerWarning()
    else
       SendChatMessage(msg, "RAID_WARNING")
    end
  end 
  if raid.islfg and (doraid or doparty) then
    SendChatMessage(msg, "INSTANCE_CHAT")
  elseif raid.israid and doraid then
    SendChatMessage(msg, "RAID")
  elseif raid.isparty and doparty then
    SendChatMessage(msg, "PARTY")
  end
end

function RaidBuffStatus:TauntSay(msg, typeoftaunt)
	local settings = RaidBuffStatus.db.profile
	if typeoftaunt == "taunt" then
		if settings.tauntsound then
			PlaySoundFile("Sound\\interface\\PickUp\\PickUpMetalSmall.wav", "Master")
		end
		EventReport(msg, settings.tauntrw, settings.tauntraid, settings.tauntparty, settings.tauntself)
	elseif typeoftaunt == "failedtauntimmune" then
		if settings.failsoundimmune then
			PlaySoundFile("Sound\\Spells\\SimonGame_Visual_GameFailedLarge.wav", "Master")
		end
		EventReport(msg, settings.failrwimmune, settings.failraidimmune, settings.failpartyimmune, settings.failselfimmune)
	elseif typeoftaunt == "failedtauntresist" then
		if settings.failsoundresist then
			PlaySoundFile("Sound\\Spells\\SimonGame_Visual_GameFailedSmall.wav", "Master")
		end
		EventReport(msg, settings.failrwresist, settings.failraidresist, settings.failpartyresist, settings.failselfresist)
	elseif typeoftaunt == "ninjataunt" then
		if settings.ninjasound then
			PlaySoundFile("Sound\\Doodad\\G_NecropolisWound.wav", "Master")
		end
		EventReport(msg, settings.ninjarw, settings.ninjaraid, settings.ninjaparty, settings.ninjaself)
	elseif typeoftaunt == "nontanktaunt" then
		if settings.nontanktauntsound then
			PlaySoundFile("Sound\\Creature\\Voljin\\VoljinAggro01.wav", "Master")
		end
		EventReport(msg, settings.nontanktauntrw, settings.nontanktauntraid, settings.nontanktauntparty, settings.nontanktauntself)
	elseif typeoftaunt == "otherfail" then
		if settings.otherfailsound then
			PlaySoundFile("Sound\\Doodad\\ZeppelinHeliumA.wav", "Master")
		end
		EventReport(msg, settings.otherfailrw, settings.otherfailraid, settings.otherfailparty, settings.otherfailself)
	elseif typeoftaunt == "tauntme" then
		if settings.tauntmesound then
			PlaySoundFile("Sound\\interface\\MagicClick.wav", "Master")
		end
		EventReport(msg, settings.tauntmerw, settings.tauntmeraid, settings.tauntmeparty, settings.tauntmeself)
	end
end


function RaidBuffStatus:CCBreakSay(msg, typeoftaunt)
	local settings = RaidBuffStatus.db.profile
	if typeoftaunt == "ccwarntank" then
		if settings.ccwarntanksound then
			PlaySoundFile("Sound\\Creature\\Ram\\RamPreAggro.wav", "Master")
		end
		EventReport(msg, settings.ccwarntankrw, settings.ccwarntankraid, settings.ccwarntankparty, settings.ccwarntankself)
	elseif typeoftaunt == "ccwarnnontank" then
		if settings.ccwarnnontanksound then
			PlaySoundFile("Sound\\Creature\\Sheep\\SheepDeath.wav", "Master")
		end
		EventReport(msg, settings.ccwarnnontankrw, settings.ccwarnnontankraid, settings.ccwarnnontankparty, settings.ccwarnnontankself)
	end
end

function RaidBuffStatus:MakeFancyIcon(msg)
	if not msg then
		msg = "nil"
	end
	while (msg:find("{rt(%d)}")) do
		local pos,_,num = msg:find("{rt(%d)}")
		local path = COMBATLOG_OBJECT_RAIDTARGET1 * (num ^ (num - 1))
		msg = msg:sub(1, pos - 1) .. "|Hicon:"..path..":dest|h|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..num..".blp:0|t|h" .. msg:sub(pos + 5)
	end
	return msg
end


function RaidBuffStatus:OfficerWarning()
	UIErrorsFrame:AddMessage("RBS: " .. L["You need to be leader or assistant to do this"], 0, 1.0, 1.0, 1.0, 1);
	RaidBuffStatus:Print(L["You need to be leader or assistant to do this"])
end

function RaidBuffStatus:TriggerXPerlTankUpdate()
	xperltankrequest = true
	xperltankrequestt = GetTime() + 5 -- wait for 5 seconds to allow message to be processed by other addons before reading tank list again
end

local listenchannels = { ["RAID"]=1, ["PARTY"]=1, ["INSTANCE_CHAT"]=1 }
function RaidBuffStatus:CHAT_MSG_ADDON(event, prefix, message, distribution, sender)
	if not prefix or not RaidBuffStatus.Prefixes[prefix] or not message or not distribution or not sender then
	  return
	end
	RaidBuffStatus:Debug(prefix .." message:" .. message .. " sender:" .. sender .. " distribution:" .. distribution)
	if prefix == "RBS" then
	  if strsub(message, 1, 4) == "VER " then
		local _, _, revision, version = string.find(message, "^VER (.*) (.*)")
		RaidBuffStatus.rbsversions[sender] = version .. " build-" .. revision
		if not toldaboutnewversion and RaidBuffStatus.db.profile.versionannounce and version and
		   tonumber(revision) and tonumber(revision) > RaidBuffStatus.revision then
			toldaboutnewversion = true
			local releasetype = ""
			if string.find(version, "^r") then
				releasetype = L["alpha"]
			elseif string.find(version, "beta") then
				releasetype = L["beta"]
			end
			RaidBuffStatus:Print(L["%s has a newer (%s) version of RBS (%s) than you (%s)"]:format(sender, releasetype, RaidBuffStatus.rbsversions[sender], RaidBuffStatus.version .. " build-" .. RaidBuffStatus.revision))
		end
		if not toldaboutrbsuser[sender] and RaidBuffStatus.db.profile.userannounce then
			toldaboutrbsuser[sender] = true
			RaidBuffStatus:Print(L["%s is running RBS %s"]:format(sender, RaidBuffStatus.rbsversions[sender]))
		end
	  end
	end
	if not listenchannels[distribution] then 
	  return
	end
	if prefix == "oRA3" and message:find("SDurability") then
		local _, min, broken = select(3, message:find("SDurability%^N(%d+)%^N(%d+)%^N(%d+)"))
		if min == nil then
			return
		end
		RaidBuffStatus.durability[sender] = 0 + min
		RaidBuffStatus.broken[sender] = broken
		RaidBuffStatus:Debug(prefix .." message:" .. message .. " sender:" .. sender)
		RaidBuffStatus:Debug("got one" .. min .. " " .. broken)
	elseif prefix == "CTRA" and message:find("^DURC") then
		RaidBuffStatus:Debug("Got DURC request")
		if nextdurability - GetTime() < 30 then
			nextdurability = GetTime() + 30  -- stops it calling again too often when another person or addon does a durability check
		end
		if not oRA then
			RaidBuffStatus:Debug("Sending DURC reply")
			RaidBuffStatus:SendDurability(nil, sender)
		end
	elseif prefix == "CTRA" and message:find("^DUR ") then
		local cur, max, broken, requestby = select(3, message:find("^DUR (%d+) (%d+) (%d+) ([^%s]+)$"))
		cur = tonumber(cur)
		max = tonumber(max)
		if cur and max and max > 0 and cur <= max and requestby then
			local p = math.floor(cur / max * 100)
			RaidBuffStatus.durability[sender] = p
			RaidBuffStatus.broken[sender] = broken
		end
		return
	elseif prefix == "CTRA" and message:find("^ITM ") then
		local numitems, itemname, requestby = message:match("^ITM ([-%d]+) (.+) ([^%s]+)$")
		RaidBuffStatus:UpdateInventory(sender, itemname, numitems)
	elseif prefix == "oRA3" and message:find("SInventoryItem") then
		local itemname, numitems = select(3, message:find("SInventoryItem%^S(.+)%^N(%d+)^"))
		RaidBuffStatus:UpdateInventory(sender, itemname, numitems)
	elseif prefix == "CTRA" and message:find("^ITMC ") then
		local itemname = select(3, message:find("^ITMC (.+)$"))
		if itemname then
			RaidBuffStatus:SendAddonMessage("CTRA", "ITM " .. GetItemCount(itemname) .. " " .. itemname .. " " .. sender)
		end
	elseif prefix == "oRA3" and message:find("SInventoryCount") then
		local itemname = select(3, message:find("SInventoryCount%^S(.+)%^"))
		if itemname then
			RaidBuffStatus:SendAddonMessage("oRA3", RaidBuffStatus:Serialize("InventoryItem", itemname, GetItemCount(itemname)))
		end
	elseif prefix == "CTRA" and message:find("CD 3 ") then
		RaidBuffStatus:Debug("Lock cast soulstone via ora2:" .. sender)
		RaidBuffStatus:LockSoulStone(sender)
		return
	elseif prefix == "oRA3" and message:find("Cooldown") then
		local spellid = select(3, message:find("Cooldown%^N(%d+)"))
		RaidBuffStatus:Debug("Got cool down:" .. sender .. " " .. spellid)
		spellid = 0 + spellid
		if spellid == 6203 or spellid == 20707 then
			RaidBuffStatus:Debug("Lock cast soulstone via ora3:" .. sender)
			RaidBuffStatus:LockSoulStone(sender)
		end
		return
	elseif XPerl_MainTanks and prefix == "CTRA" then
		if strsub(message, 1, 4) == "SET " or strsub(message, 1, 2) == "R " then
			RaidBuffStatus:Debug("triggered xperl tank update")
			RaidBuffStatus:TriggerXPerlTankUpdate()
		end
	elseif prefix == "CTRA" and message:find("RES") then
		RaidBuffStatus:Debug(prefix .." message:" .. message .. " sender:" .. sender)
		if message == "RESSED" then  -- got rez but not accepted yet
			RaidBuffStatus:Debug("RESSED from" .. sender)
			RaidBuffStatus.rezeetime[sender] = GetTime()
		elseif message == "NORESSED" then -- accepted, declined or timed out rez
			RaidBuffStatus:Debug("NORESSED from" .. sender)
			RaidBuffStatus.rezeetime[sender] = nil
		elseif message == "RESNO" then
			RaidBuffStatus:Debug("RESNO from" .. sender)
			-- do nothing - using combat log to guess if rez was successful instead
		elseif message:find("^RES ") then
			local _, _, rezee = message:find("^RES (.+)")
			if rezee and RaidBuffStatus:GetUnitFromName(rezee) then
				RaidBuffStatus.rezerrezee[sender] = rezee
			end
		end
	end
end

function RaidBuffStatus:SendVersion()
	if raid.isbattle then
		return
	end
	RaidBuffStatus:SendAddonMessage("RBS","VER " .. RaidBuffStatus.revision .. " " .. RaidBuffStatus.version, true)
end

function RaidBuffStatus:SendAddonMessage(prefix, msg, allowguild)
	if raid.islfg then
		SendAddonMessage(prefix, msg, "INSTANCE_CHAT")
	elseif raid.israid then
		SendAddonMessage(prefix, msg, "RAID")
	elseif raid.isparty then
		SendAddonMessage(prefix, msg, "PARTY")
	elseif allowguild and IsInGuild() then
		SendAddonMessage(prefix, msg, "GUILD")
	end
end

function RaidBuffStatus:CreateBar(currenty, name, text, r, g, b, a, tooltip, chat)
	if RaidBuffStatus.bars[name] then
		RaidBuffStatus.bars[name].barframe:SetPoint("BOTTOMLEFT", RaidBuffStatus.frame, "BOTTOMLEFT", 10, currenty)
		RaidBuffStatus.bars[name].barframe:Show()
		return
	end
	local barframe = CreateFrame("Button", nil, RaidBuffStatus.frame)
	barframe:SetHeight(10)
	barframe:SetPoint("BOTTOMLEFT", RaidBuffStatus.frame, "BOTTOMLEFT", 10, currenty)

	local bar = barframe:CreateTexture()
	bar:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	bar:SetPoint("TOPLEFT", barframe, "TOPLEFT", 0, 0)
	bar:SetHeight(10)
	bar:SetGradientAlpha("HORIZONTAL", r, g, b, a, 0.3, 0.3, 0.3, a)

	local bartext = barframe:CreateFontString(nil, "ARTWORK","GameFontNormalSmall")
	bartext:SetPoint("LEFT", barframe, "LEFT", 0, 1)
	bartext:SetFont(bartext:GetFont(), 9)
	bartext:SetShadowColor(0, 0, 0, 1)
	bartext:SetText(text)

	local barvalue = barframe:CreateFontString(nil, "ARTWORK","GameFontNormalSmall")
	barvalue:SetPoint("RIGHT", barframe, "RIGHT", 0, 1)
	barvalue:SetFont(barvalue:GetFont(), 8)
	barvalue:SetShadowColor(0, 0, 0, 1)
	barvalue:SetText("100%")

	local barvalueb = barframe:CreateFontString(nil, "ARTWORK","GameFontNormalSmall")
	barvalueb:SetPoint("RIGHT", barframe, "RIGHT", -35, 1)
	barvalueb:SetFont(barvalueb:GetFont(), 8)
	barvalueb:SetShadowColor(0, 0, 0, 1)
	barvalueb:SetText("")

	if tooltip then
		barframe:SetScript("OnEnter", function (self)
			tooltip(self)
			RaidBuffStatus.tooltipupdate = function ()
				tooltip(self)
			end
		end)
		barframe:SetScript("OnLeave", function()
			RaidBuffStatus.tooltipupdate = nil
			GameTooltip:Hide()
		end)
	end
	if chat then
		barframe:SetScript("OnClick", chat)
	end
	RaidBuffStatus.bars[name] = {}
	RaidBuffStatus.bars[name].barframe = barframe
	RaidBuffStatus.bars[name].bar = bar
	RaidBuffStatus.bars[name].bartext = bartext
	RaidBuffStatus.bars[name].barvalue = barvalue
	RaidBuffStatus.bars[name].barvalueb = barvalueb
end

function RaidBuffStatus:SetBarsWidth()
	local width = RaidBuffStatus.frame:GetWidth() - 20
	for _,v in pairs(RaidBuffStatus.bars) do
		v.barframe:SetWidth(width)
		v.bar:SetWidth(width)
	end
end

function RaidBuffStatus:SetPercent(name, percent, valueb)
	if not valueb then
		valueb = ""
	end
	local percentwidth
	if percent == L["n/a"] then
		percentwidth = 1
	elseif percent > 99 then
		percent = 100
		percentwidth = RaidBuffStatus.bars[name].barframe:GetWidth()
	elseif percent < 1 then
		percentwidth = 1
		percent = 0
	else
		percentwidth = RaidBuffStatus.bars[name].barframe:GetWidth() / 100 * percent
	end
	RaidBuffStatus.bars[name].bar:SetWidth(percentwidth)
	RaidBuffStatus.bars[name].barvalue:SetText(percent .. "%")
	RaidBuffStatus.bars[name].barvalueb:SetText(valueb)
end

function RaidBuffStatus:HideAllBars()
	for _,v in pairs(RaidBuffStatus.bars) do
		v.barframe:Hide()
	end
end

function RaidBuffStatus:BarTip(owner, title, list)
	GameTooltip:SetOwner(owner, "ANCHOR_LEFT")
	GameTooltip:SetText(title,1,1,1,1,1)
	if list then
		for name, percent in pairs(list) do
			local class = RaidBuffStatus:GetUnitFromName(name).class
			GameTooltip:AddDoubleLine(name, percent, RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
		end
	end
	GameTooltip:Show()
end

function RaidBuffStatus:BarChat(name, title)
	if not IsShiftKeyDown() or raid.isbattle then
		return
	end
	local percent = RaidBuffStatus.bars[name].barvalue:GetText()
	if not percent or string.len(percent) < 1 then
		return
	end
	local number = RaidBuffStatus.bars[name].barvalueb:GetText()
	local message = title .. ": " .. percent
	if number and string.len(number) > 0 then
		message = message .. " (" .. number .. ")"
	end
	RaidBuffStatus:Say(message)
end

function RaidBuffStatus:AmIListed(list)
	if not list then
		return
	end
	for _,v in ipairs(list) do
		local name = v
		if v:find("%(") then
			name = string.sub(v, 1, v:find("%(") - 1)
		end
		if name == playername then
			return true
		end
	end
	return false
end

function RaidBuffStatus:RefreshTalents()
	GI:Rescan()
	for class,_ in pairs(raid.classes) do
		for name,rcn in pairs(raid.classes[class]) do
			rcn.talents = nil
			rcn.specname = "UNKNOWN"
			rcn.specicon = "UNKNOWN"
		end
	end
	RaidBuffStatus:UpdateTalentsFrame()
end

function RaidBuffStatus:Announces(message, who, callback, spellID)
	if not message or not who then
		return
	end
	if raid.isbattle then
		RaidBuffStatus:Debug("battle")
		return
	end
	if not callback or callback ~= "callback" then -- delay to ensure single announce
	  RaidBuffStatus:ScheduleTimer(function()
	      RaidBuffStatus:Announces(message, who, "callback", spellID)
	    end, RaidBuffStatus:calcdelay())
          return
	end
	local isdead = UnitIsDeadOrGhost("player") or false

--	RaidBuffStatus:Debug(":" .. who .. ":" .. message .. ":")
	local msg = ""
        local canspeak = UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")
	if RaidBuffStatus.db.profile.feasts then
		if message == "Feast" then
			local sid = spellID or 0
			if GetTime() > (nextfeastannounce[sid] or 0) and RaidBuffStatus:GetUnitFromName(who) then
			        local finfo = feastdata[sid]
				local fname = (spellID and GetSpellLink(spellID)) or (finfo and finfo.name) or "Feast"
				msg = who .. " " .. (L["prepares a %s!"]):format(fname)
				if finfo and finfo.bonus then
				  local btext = _G["ITEM_MOD_"..finfo.bonus.."_SHORT"]
				  if btext then
				    msg = msg .. " ("..L["Bonus"].." "..btext..")" 
				  end
				end
				nextfeastannounce[sid] = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:Announces(message .. "Expiring", who, nil, spellID)
				end, 130)
			end
			RaidBuffStatus:PingMinimap(who)
			
		elseif message == "FeastExpiring" and not incombat and not isdead then
	        	local players = tonumber(RaidBuffStatus.report.AliveCount) or raid.size
			local finfo = spellID and feastdata[spellID]
			local feeds = (finfo and finfo.limit) or 40
			local fname = (spellID and GetSpellLink(spellID)) or (finfo and finfo.name) or "Feast"
			--print("RBS: FeastExpiring: players=",players," feeds=",feeds)
			if players > feeds then -- dont announce expiration if there's not enough for everyone
			  return
			end
			msg = (L["%s about to expire!"]):format(fname)
			if report.foodlist then
				if #report.foodlist == 0 then
				  	msg = nil -- all buffed
				elseif canspeak and RaidBuffStatus.db.profile.feastautowhisper then
					RaidBuffStatus:DoReport()
					if report.foodlist and #report.foodlist > 0 then
						for _,name in ipairs(report.foodlist) do
							RaidBuffStatus:Say("<" .. L["Not Well Fed"] .. ">: " .. name, name)
						end
					end
				end
			end
		end
	end
	if RaidBuffStatus.db.profile.cauldrons then
		if message == "Cauldron" then
			if GetTime() > nextcauldronannounce and RaidBuffStatus:GetUnitFromName(who) then
				local cname = (spellID and BS[spellID]) or "Cauldron"
				msg = who .. " " .. (L["prepares a %s!"]):format(cname)
				nextcauldronannounce = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:Announces(message .. "Expiring", who)
				end, 500)
			end
			RaidBuffStatus:PingMinimap(who)
		elseif message == "CauldronExpiring" and not incombat and not isdead then
			local cname = (spellID and BS[spellID]) or "Cauldron"
			msg = (L["%s about to expire!"]):format(cname)
			if report.flasklist then
				if #report.flasklist == 0 then
				  	msg = nil -- all buffed
				elseif canspeak and RaidBuffStatus.db.profile.cauldronautowhisper then
					RaidBuffStatus:DoReport()
					if report.flasklist and #report.flasklist > 0 then
						for _,name in ipairs(report.flasklist) do
							RaidBuffStatus:Say("<" .. L["Missing a Flask or two Elixirs"] .. ">: " .. name, name)
						end
					end
				end
			end
		end
	end
	if RaidBuffStatus.db.profile.refreshmenttable then
		if message == "Table" then
			if GetTime() > nexttableannounce and RaidBuffStatus:GetUnitFromName(who) then
				msg = who .. L[" has set us up a Refreshment Table"]
				nexttableannounce = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:Announces("TableExpiring", who)
				end, 130)
			end
			RaidBuffStatus:PingMinimap(who)
		elseif message == "TableExpiring" and not incombat and not isdead then
			msg = L["Refreshment Table about to expire!"]
		end
	end
	if RaidBuffStatus.db.profile.soulwell then
		if message == "Soul" then
			local unit = RaidBuffStatus:GetUnitFromName(who)
			if GetTime() > nextsoulannounce and unit then
				msg = who .. L[" has set us up a Soul Well"]
				nextsoulannounce = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:Announces("SoulExpiring", who)
				end, 90)
			end
			RaidBuffStatus:PingMinimap(who)
		elseif message == "SoulExpiring" and not incombat and not isdead then
			if report.healthstonelist then
				if #report.healthstonelist == 1 then
					msg = L["Soul Well about to expire!"] .. " " .. report.healthstonelist[1]
				elseif #report.healthstonelist > 1 then
					msg = L["Soul Well about to expire!"]
				end
				if canspeak and RaidBuffStatus.db.profile.wellautowhisper and #report.healthstonelist > 0 then
					RaidBuffStatus:DoReport()
					if report.healthstonelist and #report.healthstonelist > 0 then
						for _,name in ipairs(report.healthstonelist) do
							RaidBuffStatus:Say("<" .. L["Missing "] .. BS[6262] .. ">: " .. name, name)
						end
					end
				end
			else
				msg = L["Soul Well about to expire!"]
			end
		end
	end
	if RaidBuffStatus.db.profile.repair then
		if message == "Repair" then
			if GetTime() > nextrepairannounce and RaidBuffStatus:GetUnitFromName(who) then
				msg = who .. L[" has set us up a Repair Bot"]
				nextrepairannounce = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:Announces("RepairExpiring", who)
				end, 540)
			end
			RaidBuffStatus:PingMinimap(who)
		elseif message == "RepairExpiring" and not incombat and not isdead then
			if not raid.LastDeath[name] or (raid.LastDeath[name] and GetTime() - raid.LastDeath[name] > 540) then
				msg = L["Repair Bot about to expire!"]
			else
				RaidBuffStatus:Debug("Not announcing bot expire as bot person has died.")
			end
		end
	end
	if RaidBuffStatus.db.profile.bling then
		if message == "Blingtron" then
			if GetTime() > nextblingannounce and RaidBuffStatus:GetUnitFromName(who) then
				msg = who .. L[" has set us up a Blingtron"]
				nextblingannounce = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:Announces("BlingtronExpiring", who)
				end, 540)
			end
			RaidBuffStatus:PingMinimap(who)
		elseif message == "BlingtronExpiring" and not incombat and not isdead then
			msg = L["Blingtron about to expire!"]
		end
	end
	if not msg or msg == "" then
		return
	end

	UIErrorsFrame:AddMessage(msg, 0, 1.0, 1.0, 1.0, 1)
	--RaidBuffStatus:Print(msg)
	if not canspeak and not RaidBuffStatus.db.profile.nonleadspeak then
	   return 
	end
	if raid.islfg then
		SendChatMessage(msg, "INSTANCE_CHAT")
	elseif raid.isparty then
		SendChatMessage(msg, "PARTY")
	elseif canspeak then
		SendChatMessage(msg, "RAID_WARNING")
	else
		SendChatMessage(msg, "RAID")
	end
end

local feastpat = L["prepares a %s!"]:gsub("%%s","(.+)")
function RaidBuffStatus:CHAT_MSG_RAID_WARNING(event, message, who)
	if not message or not who then
		return
	end
	if message:find(L[" has set us up a Refreshment Table"]) then
		nexttableannounce = GetTime() + 15
	elseif message:find((L["prepares a %s!"]):format(BS[92649])) -- Cauldron of Battle
		or message:find((L["prepares a %s!"]):format(BS[92712])) then -- Big Cauldron of Battle
		nextcauldronannounce = GetTime() + 15
	elseif message:find(L[" has set us up a Soul Well"]) then
		nextsoulannounce = GetTime() + 15
	elseif message:find(L[" has set us up a Repair Bot"]) then
		RaidBuffStatus:Debug("Bot warning detected.")
		nextrepairannounce = GetTime() + 15
	elseif message:find(L[" has set us up a Blingtron"]) then
		RaidBuffStatus:Debug("Bling warning detected.")
		nextblingannounce = GetTime() + 15
	else
		local m = message:match(feastpat)
		if m then
		  m = m:match("\124h%[(.+)%]\124h") or m -- strip hyperlink goop
		  local id = feastdata[m] and feastdata[m].id
		  if not id then
		    for _,info in pairs(feastdata) do
		      if info.name and m:find(info.name) then
		        id = info.id
		        break
		      end
		    end
		  end
		  if id then
		    nextfeastannounce[id] = GetTime() + 15
		  end
		end
	end
end

local unitlist = {}
local function unitsort(u1, u2)
  if UnitIsGroupLeader(u1.unitid) or UnitIsGroupLeader(u2.unitid) then
  	return UnitIsGroupLeader(u1.unitid)
  elseif UnitIsGroupAssistant(u1.unitid) ~= UnitIsGroupAssistant(u2.unitid) then
  	return UnitIsGroupAssistant(u1.unitid)
  else
  	return u1.guid < u2.guid
  end
end
function RaidBuffStatus:calcdelay()
	if UnitIsGroupLeader("player") or not RaidBuffStatus.db.profile.antispam then
		return 0.5 -- don't wait when leader
	else
		wipe(unitlist)
		for class,_ in pairs(raid.classes) do
			for name,_ in pairs(raid.classes[class]) do
				table.insert(unitlist, raid.classes[class][name])
			end
		end
		table.sort(unitlist, unitsort)
		local pos = 40
		for i, u in ipairs(unitlist) do
			if u.guid == playerid then
				pos = i
				break
			end
		end
		return pos * 0.5 + 0.6
	end
end

function RaidBuffStatus:PingMinimap(whom)
	if not Minimap:IsVisible() then
		return
	end
	if whom == playername then
		Minimap:PingLocation(0,0) -- it's me
		return
	end
	local myx, myy = GetPlayerMapPosition("player")
	local hisx, hisy = GetPlayerMapPosition(whom)
	local hisx = 0.280537
	local hisy = 0.698122
	if (myx == 0 and myy == 0) or (hisx == 0 and hisy == 0) then
		return -- can't get coords
	end
	
	if true then
		return -- does not work yet..... so return
	end

	local zoneheight = 527.6066263822604 -- Blizz PLEASE provide an API for reading this!
	local zonewidth = 790.625237342102

	myy =  myy * zoneheight
	hisy = hisy * zoneheight
	myx = myx * zonewidth
	hisx = hisx * zonewidth

	local pingx = hisx - myx -- now distance in yards
	local pingy = hisy - myy

	local mapWidth = Minimap:GetWidth()
	local mapHeight = Minimap:GetHeight()
	local minimapZoom = Minimap:GetZoom()
	local mapDiameter;
	local minimapOutside
	if ( GetCVar("minimapZoom") == Minimap:GetZoom() ) then
		mapDiameter = MinimapSize.outdoor[minimapZoom]
	else
		mapDiameter = MinimapSize.indoor[minimapZoom]
	end
	local xscale = mapDiameter / mapWidth
	local yscale = mapDiameter / mapHeight

	if GetCVar("rotateMinimap") ~= "0" then
		RaidBuffStatus:Debug("rotated minimap")
		local minimapRotationOffset = GetPlayerFacing()
		local sinTheta = sin(minimapRotationOffset)
		local cosTheta = cos(minimapRotationOffset)
		local dx, dy = pingx, pingy
		pingx = (dx * cosTheta) - (dy * sinTheta)
		pingy = (dx * sinTheta) + (dy * cosTheta)
	end
	RaidBuffStatus:Debug("minimapZoom:" .. minimapZoom)
	RaidBuffStatus:Debug(pingx .. " " .. pingy)

	Minimap:PingLocation(pingx / xscale, -pingy / yscale)
end


function RaidBuffStatus:GetIcon(flag)
	local val = band(flag, COMBATLOG_OBJECT_RAIDTARGET_MASK)
	if val == 0 then
		return
	end
	local v = COMBATLOG_OBJECT_RAIDTARGET1
	for i = 1, 8 do
		if v == val then
			return i
		end
		v = v * 2
	end
	return nil
end

function RaidBuffStatus:SayMe(msg)
	RaidBuffStatus:Print(msg)
	UIErrorsFrame:AddMessage(msg, 0, 1.0, 1.0, 1.0, 1)
end

function RaidBuffStatus:SomebodyDied(unit)
	RaidBuffStatus:Debug("SomebodyDied")
	if raid.isbattle then
		return
	end
	local unitid = unit.unitid
	local name = unit.name
	raid.LastDeath[name] = GetTime()
	RaidBuffStatus.rezeetime[name] = nil
	if not RaidBuffStatus.db.profile.deathwarn then
		return
	end
	if unitid and not UnitIsFeignDeath(unitid) then
		if unit.istank then
--			RaidBuffStatus:Debug(L["Tank %s has died!"]:format(name), "tank")
			RaidBuffStatus:DeathSay(L["Tank %s has died!"]:format(name), "tank")
		elseif unit.ishealer then
--			RaidBuffStatus:Debug(L["Healer %s has died!"]:format(name), "healer")
			RaidBuffStatus:DeathSay(L["Healer %s has died!"]:format(name), "healer")
		elseif unit.ismeleedps then
--			RaidBuffStatus:Debug(L["Melee DPS %s has died!"]:format(name), "meleedps")
			RaidBuffStatus:DeathSay(L["Melee DPS %s has died!"]:format(name), "meleedps")
		elseif unit.israngeddps then
--			RaidBuffStatus:Debug(L["Ranged DPS %s has died!"]:format(name), "rangeddps")
			RaidBuffStatus:DeathSay(L["Ranged DPS %s has died!"]:format(name), "rangeddps")
		end
	end
end


function RaidBuffStatus:DeathSay(msg, typeofdeath)
	local settings = RaidBuffStatus.db.profile
	if typeofdeath == "tank" then
		if settings.tankdeathsound then
			PlaySoundFile("Sound\\interface\\igQuestFailed.wav", "Master")
		end
		EventReport(msg, settings.tankdeathrw, settings.tankdeathraid, settings.tankdeathparty, settings.tankdeathself)
	elseif typeofdeath == "healer" then
		if settings.healerdeathsound then
			PlaySoundFile("Sound\\Event Sounds\\Wisp\\WispPissed1.wav", "Master")
		end
		EventReport(msg, settings.healerdeathrw, settings.healerdeathraid, settings.healerdeathparty, settings.healerdeathself)
	elseif typeofdeath == "meleedps" then
		if settings.meleedpsdeathsound then
			PlaySoundFile("Sound\\interface\\iCreateCharacterA.wav", "Master")
		end
		EventReport(msg, settings.meleedpsdeathrw, settings.meleedpsdeathraid, settings.meleedpsdeathparty, settings.meleedpsdeathself)
	elseif typeofdeath == "rangeddps" then
		if settings.rangeddpsdeathsound then
			PlaySoundFile("Sound\\interface\\iCreateCharacterA.wav", "Master")
		end
		EventReport(msg, settings.rangeddpsdeathrw, settings.rangeddpsdeathraid, settings.rangeddpsdeathparty, settings.rangeddpsdeathself)
	end
end

function RaidBuffStatus:SelectSeal()
	if not raid.classes.PALADIN[playername] then
		return
	end
	if raid.classes.PALADIN[playername].spec == L["Holy"] then
		return BS[20165] -- Seal of Insight
	end
	return BS[31801] -- Seal of Truth
end

function RaidBuffStatus:GroupInSpecT_Update(e, guid, unit, info)
        local class = select(2, UnitClass(unit))
	local name = RaidBuffStatus:UnitNameRealm(unit)
	local rcn = class and name and raid.classes[class][name]
	if not rcn then return end
	rcn.tinfo = info
	RaidBuffStatus:UpdateSpec(rcn)
	if RaidBuffStatus.talentframe:IsVisible() then
		RaidBuffStatus:UpdateTalentsFrame()
	end
end

function RaidBuffStatus:UpdateSpec(rcn)
        local info = rcn.guid and GI:GetCachedInfo(rcn.guid)
	rcn.tinfo = info or rcn.tinfo
        local spec = rcn.tinfo and rcn.tinfo.spec_index
	if not spec or spec < 1 then
		rcn.talents = nil
		rcn.spec = 0
		rcn.specname = "UNKNOWN"
		rcn.specicon = "UNKNOWN"
	else
		rcn.spec = spec
		rcn.specname = rcn.tinfo.spec_name_localized or "UNKNOWN"
		rcn.specicon = rcn.tinfo.spec_icon or "UNKNOWN"
		rcn.talents = true
	end
end

function RaidBuffStatus:UseDrumsKings(raid)
	if not RaidBuffStatus.db.profile.checkdrumskings then
		return false
	end
	if raid.ClassNumbers.DRUID > 0 or raid.ClassNumbers.MONK > 0 then -- these classes always bring stats
		return false
	end
	if raid.ClassNumbers.PALADIN > 1 then -- two pallies, can get might and kings
		return false
	end
	if raid.ClassNumbers.PALADIN == 1 and raid.ClassNumbers.SHAMAN > 0 then -- shaman brings might, pally should buff kings
		return false
	end
	return true
end


function RaidBuffStatus:SetAllOptions(mode)
	local BF = RaidBuffStatus.BF
	for buffcheck, _ in pairs(BF) do
		for _, defname in ipairs({"buff", "warning", "dash", "dashcombat", "boss", "trash"}) do
			if BF[buffcheck]["default" .. defname] then
				RaidBuffStatus.db.profile[buffcheck .. defname] = true
			else
				RaidBuffStatus.db.profile[buffcheck .. defname] = false
			end
		end
		local enable = false
		if mode == "justmybuffs" then
			if BF[buffcheck].class and BF[buffcheck].class[playerclass] then
				enable = true
				RaidBuffStatus.db.profile[buffcheck .. "dash"] = true
				RaidBuffStatus.db.profile[buffcheck .. "boss"] = true
				RaidBuffStatus.db.profile[buffcheck .. "trash"] = true
			end
		elseif mode == "raidleader" then
			if BF[buffcheck].default then
				enable = true
			end
		elseif mode == "coreraidbuffs" then
			if BF[buffcheck].core then
				enable = true
				RaidBuffStatus.db.profile[buffcheck .. "dash"] = true
--				RaidBuffStatus.db.profile[buffcheck .. "boss"] = true
--				RaidBuffStatus.db.profile[buffcheck .. "trash"] = true
			end
		end
		if enable then
			RaidBuffStatus.db.profile[BF[buffcheck].check] = true
		else
			RaidBuffStatus.db.profile[BF[buffcheck].check] = false
			RaidBuffStatus.db.profile[buffcheck .. "dash"] = false
		end
	end
	if mode == "justmybuffs" then
		RaidBuffStatus.db.profile.hidebossrtrash = true
		RaidBuffStatus.db.profile.RaidHealth = false
		RaidBuffStatus.db.profile.TankHealth = false
		RaidBuffStatus.db.profile.RaidMana = false
		RaidBuffStatus.db.profile.HealerMana = false
		RaidBuffStatus.db.profile.DPSMana = false
		RaidBuffStatus.db.profile.Alive = false
		RaidBuffStatus.db.profile.Dead = false
		RaidBuffStatus.db.profile.TanksAlive = false
		RaidBuffStatus.db.profile.HealersAlive = false
		RaidBuffStatus.db.profile.Range = false
	elseif mode == "raidleader" then
		RaidBuffStatus.db.profile.hidebossrtrash = RaidBuffStatus.profiledefaults.profile.hidebossrtrash
		RaidBuffStatus.db.profile.RaidHealth = RaidBuffStatus.profiledefaults.profile.RaidHealth
		RaidBuffStatus.db.profile.TankHealth = RaidBuffStatus.profiledefaults.profile.TankHealth
		RaidBuffStatus.db.profile.RaidMana = RaidBuffStatus.profiledefaults.profile.RaidMana
		RaidBuffStatus.db.profile.HealerMana = RaidBuffStatus.profiledefaults.profile.HealerMana
		RaidBuffStatus.db.profile.DPSMana = RaidBuffStatus.profiledefaults.profile.DPSMana
		RaidBuffStatus.db.profile.Alive = RaidBuffStatus.profiledefaults.profile.Alive
		RaidBuffStatus.db.profile.Dead = RaidBuffStatus.profiledefaults.profile.Dead
		RaidBuffStatus.db.profile.TanksAlive = RaidBuffStatus.profiledefaults.profile.TanksAlive
		RaidBuffStatus.db.profile.HealersAlive = RaidBuffStatus.profiledefaults.profile.HealersAlive
		RaidBuffStatus.db.profile.Range = RaidBuffStatus.profiledefaults.profile.Range
	elseif mode == "coreraidbuffs" then
		RaidBuffStatus.db.profile.hidebossrtrash = false
		RaidBuffStatus.db.profile.RaidHealth = false
		RaidBuffStatus.db.profile.TankHealth = false
		RaidBuffStatus.db.profile.RaidMana = false
		RaidBuffStatus.db.profile.HealerMana = false
		RaidBuffStatus.db.profile.DPSMana = false
		RaidBuffStatus.db.profile.Alive = false
		RaidBuffStatus.db.profile.Dead = false
		RaidBuffStatus.db.profile.TanksAlive = false
		RaidBuffStatus.db.profile.HealersAlive = false
		RaidBuffStatus.db.profile.Range = false
	end
	RaidBuffStatus:AddBuffButtons()
	RaidBuffStatus:UpdateButtons()
	RaidBuffStatus:UpdateOptionsButtons()
end

function RaidBuffStatus:PopUpWizard()
	StaticPopupDialogs["RBS_WIZARD"] = {
		text = L["This is the first time RaidBuffStatus has been activated since installation or settings were reset. Would you like to visit the Buff Wizard to help you get RBS buffs configured? If you are a raid leader then you can click No as the defaults are already set up for you."],
		button1 = L["Buff Wizard"],
		button2 = L["No"],
		button3 = L["Remind me later"],
		OnAccept = function()
			RaidBuffStatus:OpenBlizzAddonOptions()
			RaidBuffStatus.db.profile.TellWizard = false
		end,
		OnCancel = function (_,reason)
			RaidBuffStatus.db.profile.TellWizard = false
		end,
		sound = "levelup2",
		timeout = 200,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3, -- reduce chance of taint
	}
	StaticPopup_Show("RBS_WIZARD")
end

function RaidBuffStatus:OpenBlizzAddonOptions()
--	if RaidBuffStatus.optionsframe:IsVisible() then
--		HideUIPanel(RBSOptionsFrame)
--	end
	InterfaceOptionsFrame_OpenToCategory("RaidBuffStatus")
end

function RaidBuffStatus:GetMyZone()
  -- GetRealZoneText() is *usually* what we want here, but in some cases (eg Wyrmrest Summit in Dragon Soul)
  -- it will return different values that GetRaidRosterInfo which we use for raid members
  local myunit = RaidBuffStatus:GetUnitFromName(playername)
  local zone = (myunit and myunit.zone) or GetRealZoneText()
  return zone 
end

function RaidBuffStatus:InMyZone(whom)
	if not raid.israid then
		return true
	end
	local thiszone = RaidBuffStatus:GetMyZone()
	local unit = RaidBuffStatus:GetUnitFromName(whom)
	if unit and unit.zone and thiszone == unit.zone then
		return true
	end
	return false
end

function RaidBuffStatus:UnitNameRealm(unitid)
	local name, realm = UnitName(unitid)
	if realm and string.len(realm) > 0 then
		return (name .. "-" .. realm)
	end
	return name
end

function RaidBuffStatus:LockSoulStone(lock)
	RaidBuffStatus.db.profile.cooldowns.soulstone[lock] = time() + (30 * 60) - 1
	RaidBuffStatus:CleanLockSoulStone()
end

function RaidBuffStatus:GetLockSoulStone(lock)
	return RaidBuffStatus.db.profile.cooldowns.soulstone[lock]
end

function RaidBuffStatus:CleanLockSoulStone()
        if not RaidBuffStatus.db.profile.cooldowns then return end
	local timenow = time()
	for lock,t in pairs(RaidBuffStatus.db.profile.cooldowns.soulstone) do
		if timenow > t then
			RaidBuffStatus.db.profile.cooldowns.soulstone[lock] = nil
		end
	end
end

--function RaidBuffStatus:GUIDToName(guid)
--	for class,_ in pairs(raid.classes) do
--		for name,rcn in pairs(raid.classes[class]) do
--			if guid == rcn.guid then
--				return name
--			end
--		end
--	end
--	return ""
--end

function RaidBuffStatus:SendRezMessage(message)
	if not raid.isbattle and not incombat then
		RaidBuffStatus:SendAddonMessage("CTRA", message)
		RaidBuffStatus:Debug("sending rez message: " .. message)
	else
		RaidBuffStatus:Debug("not sending rez message")
	end
end

function RaidBuffStatus:UnitIsMounted(unitid)
  if not unitid then 
    return false
  elseif UnitInVehicle(unitid) then
    return true
  elseif UnitIsUnit(unitid, "player") then 
		return IsMounted()
  else -- hard case, WTB IsMounted for non-player
  	for b = 1, 32 do
      local buffName, buffRank, buffIcon, _, _, 
            duration, expirationTime, unitCaster,
            _, _, buffSpellId = UnitAura(unitid, b, "HELPFUL|CANCELABLE")
      if buffIcon then
        buffIcon = string.lower(buffIcon)
      end
      if not buffName then
        return false
      elseif buffSpellId == 13159 or buffSpellId == 5118 then -- aspect of the pack/cheetah
        -- skip
      elseif (expirationTime == 0 and duration == 0 and 
          (not unitCaster or (unitCaster and UnitIsUnit(unitid, unitCaster))) and
         ((buffIcon and string.find(buffIcon, "ability_mount_")) or -- most mounts
          (buffIcon and string.find(buffIcon, "misc_foot_centaur")) or -- talbuks
          (buffIcon and string.find(buffIcon, "pet_netherray")) or -- netherrays
          (buffIcon and string.find(buffIcon, "misc_key_")) or -- chopper/hog
          (buffIcon and string.find(buffIcon, "inv_misc_qirajicrystal")) or -- AQ mount
          (buffIcon and string.find(buffIcon, "deathknight_summondeathcharger")) or -- deathchargers
          (buffIcon and string.find(buffIcon, "inv_belt_12")) or -- headless horseman mnt (many spellIds)
          buffSpellId == 61996 or -- blue dragonhawk
          buffSpellId == 5784  or -- felsteed
          buffSpellId == 34769 or -- warhorse
          buffSpellId == 64731 or -- sea turtle
          buffSpellId == 63796 or -- mimiron's head
          buffSpellId == 43688 or -- amani war bear
          buffSpellId == 71342 or -- love rocket
          buffSpellId == 30174 or -- riding turtle
          buffSpellId == 41252 or -- raven lord
          buffSpellId == 47977    -- magic broom
         )) then -- looks mounted   
        -- SendChatMessage(UnitName(unitid).." is mounted on "..buffName.."   "..buffIcon,"PARTY")
  	    return true
      end
    end
  end
end

function RaidBuffStatus:CHAT_MSG_BN_WHISPER(event, msg, sender,...)
  local pid = select(11,...)
  RaidBuffStatus:CHAT_MSG_WHISPER(event, msg, pid)
end  
function RaidBuffStatus:CanAutoInvite(whom)
	if RaidBuffStatus:IsInBGQueue() then
		RaidBuffStatus:Say(L["Sorry, I am queued for a battlefield."], whom, true)
		return false
	end
	local queued = nil
	for c,n in pairs(LFG_CATEGORY_NAMES) do
	  local s = select(3,GetLFGInfoServer(c))
	  if s then queued = n; break end
	end
	if queued then
		RaidBuffStatus:Say(L["Sorry, I am queued for"].." "..queued, whom, true)
		return false
	end
	return true
end

function RaidBuffStatus:CHAT_MSG_WHISPER(event, msg, whom)
	RaidBuffStatus:Debug(":" .. msg .. ":" .. whom .. ":")
	if msg:lower() ~= (L["invite"]):lower() or not whom then
		return
	end
	if not RaidBuffStatus:CanAutoInvite(whom) then return end
	if RaidBuffStatus.db.profile.aiwguildmembers and IsInGuild() then
		for i=1, GetNumGuildMembers() do
			name = GetGuildRosterInfo(i)
			if name == whom then
				RaidBuffStatus:SendInvite(whom)
				return
			end
		end
	end
	if RaidBuffStatus.db.profile.aiwfriends then
		for i=1, GetNumFriends() do
			name = GetFriendInfo(i)
			if name == whom then
				RaidBuffStatus:SendInvite(whom)
				return
			end
		end
	end
	if RaidBuffStatus.db.profile.aiwbnfriends and BNFeaturesEnabledAndConnected() then
		for i=1, BNGetNumFriends() do
			local pID,pName,battletag,isBT,toonname,_,client,isOnline = BNGetFriendInfo(i)
			if (client == "WoW" and isOnline) then
				if whom == toonname then
					RaidBuffStatus:SendInvite(whom)
					return
				elseif whom == pID then -- CHAT_MSG_BN_WHISPER
  		                        FriendsFrame_BattlenetInvite(nil, pID)
					return
				end
			end
		end
	end
end

function RaidBuffStatus:SendInvite(whom)
	if not ( UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or not (raid.isparty or raid.israid or raid.isbattle) ) then
		RaidBuffStatus:Say(L["You need to whisper the leader instead: "] .. raid.leadername, whom, true)
		return
	end
	local isIn, instanceType = IsInInstance()
	if isIn and instanceType == "party" and raid.size == 5 then
		RaidBuffStatus:Say(L["Sorry, the group is now full."], whom, true)
	elseif raid.isparty and raid.size == 5 then
		ConvertToRaid()
		RaidBuffStatus:ScheduleTimer(function()
			RaidBuffStatus:SendInvite(whom)
		end, 2)
	elseif raid.israid and raid.size == 40 then
			RaidBuffStatus:Say(L["Sorry, the group is now full."], whom, true)
	else
		InviteUnit(whom)
	end
end

function RaidBuffStatus:PARTY_INVITE_REQUEST(event, whom)
	if not whom then
		return
	end
	if RaidBuffStatus.db.profile.guildmembers and IsInGuild() then
		for i=1, GetNumGuildMembers() do
			name = GetGuildRosterInfo(i)
			if name == whom then
	                        if not RaidBuffStatus:CanAutoInvite(whom) then return end -- may send a whisper
				RaidBuffStatus:Print((L["Invite auto-accepted from guild member %s."]):format(whom))
				RaidBuffStatus:AcceptInvite()
				return
			end
		end
	end
	if RaidBuffStatus.db.profile.friends then
		for i=1, GetNumFriends() do
			name = GetFriendInfo(i)
			if name == whom then
	                        if not RaidBuffStatus:CanAutoInvite(whom) then return end -- may send a whisper
				RaidBuffStatus:Print((L["Invite auto-accepted from friend %s."]):format(whom))
				RaidBuffStatus:AcceptInvite()
				return
			end
		end
	end
	if RaidBuffStatus.db.profile.bnfriends and BNFeaturesEnabledAndConnected() then
		local myrealm = GetRealmName()
		for i=1, BNGetNumFriends() do
			local pID,_,_,_,_,_,client,isOnline = BNGetFriendInfo(i)
			if (client == "WoW" and isOnline) then
				local _,name,_,realm = BNGetToonInfo(pID)
				if name == whom then
	                                if not RaidBuffStatus:CanAutoInvite(whom) then return end -- may send a whisper
					RaidBuffStatus:Print((L["Invite auto-accepted from battle.net friend %s."]):format(whom))
					RaidBuffStatus:AcceptInvite()
					return
				end
			end
		end
	end
end

function RaidBuffStatus:AcceptInvite()
	for i=1, STATICPOPUP_NUMDIALOGS do
		local d = _G["StaticPopup"..i]
		if d:IsShown() and d.which == "PARTY_INVITE" then
		        _G["StaticPopup"..i.."Button1"]:Click()
			break
		end
	end
end

function RaidBuffStatus:IsInRaid(whom)
	if RaidBuffStatus:GetUnitFromName(whom) then
		--RaidBuffStatus:Debug("Is in raid:" .. whom)
		return true
	end
	--RaidBuffStatus:Debug("NOT in raid:" .. whom)
	return false
end

function RaidBuffStatus:PrintOption(info, option)
	if type(option) == "number" or type(option) == "boolean" then
		RaidBuffStatus:Print(info[2] .. ": " .. tostring(option))
	else
		RaidBuffStatus:Print(info[2] .. ": " .. option)
	end
end


function RaidBuffStatus:CleanSheep()
	for sheep,_ in pairs(currentsheep) do
		if (GetTime() - currentsheep[sheep]) > 35 then
			currentsheep[sheep] = nil
			currentsheepspell[sheep] = nil
		end
	end
end

function RaidBuffStatus:deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function RaidBuffStatus:SendDurability(event, sender)
	RaidBuffStatus:Debug("SendDurability")
	if not raid.israid then
		return
	end
	local cur, max, broken, vmin = 0, 0, 0, 100
	for i = 1, 18 do
		local imin, imax = GetInventoryItemDurability(i)
		if imin and imax then
			vmin = math.min(math.floor(imin / imax * 100), vmin)
			if imin == 0 then broken = broken + 1 end
			cur = cur + imin
			max = max + imax
		end
	end
	if sender then
		RaidBuffStatus:SendAddonMessage("CTRA", string.format("DUR %s %s %s %s", cur, max, broken, sender))
	else
		local perc = math.floor(cur / max * 100)
		RaidBuffStatus:SendAddonMessage("oRA3", RaidBuffStatus:Serialize("Durability", perc, vmin, broken))
	end
end

function RaidBuffStatus:UpdateInventory(sender, itemname, numitems)
	for itemcheck, _ in pairs(RaidBuffStatus.itemcheck) do
		if itemname == RaidBuffStatus.itemcheck[itemcheck].item then
			RaidBuffStatus.itemcheck[itemcheck].results[sender] = tonumber(numitems)
			if RaidBuffStatus.itemcheck[itemcheck].next - GetTime() < (RaidBuffStatus.itemcheck[itemcheck].frequencymissing - 15) then
				RaidBuffStatus.itemcheck[itemcheck].next = GetTime() + RaidBuffStatus.itemcheck[itemcheck].frequency
			end
			break
		end
	end
end

function RaidBuffStatus:AddBars(currenty)
	if RaidBuffStatus.db.profile.TanksAlive then
		RaidBuffStatus:CreateBar(currenty + 19, "TanksAlive", L["Tanks alive"], .3, .7, .7, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.TanksAlive.barframe, L["Dead tanks"], report.tanksalivelist) end, function() RaidBuffStatus:BarChat("TanksAlive", L["Tanks alive"]) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.HealersAlive then
		RaidBuffStatus:CreateBar(currenty + 19, "HealersAlive", L["Healers alive"], .9, .9, .9, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.HealersAlive.barframe, L["Dead healers"], report.healersalivelist) end, function() RaidBuffStatus:BarChat("HealersAlive", L["Healers alive"]) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.Alive then
		RaidBuffStatus:CreateBar(currenty + 19, "Alive", L["Alive"], .1, .2, .2, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.Alive.barframe, L["I see dead people"], report.alivelist) end, function() RaidBuffStatus:BarChat("Alive", L["Alive"]) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.Dead then
		RaidBuffStatus:CreateBar(currenty + 19, "Dead", L["Dead"], .1, .2, .2, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.Dead.barframe, L["I see dead people"], report.alivelist) end, function() RaidBuffStatus:BarChat("Dead", L["Dead"]) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.DPSMana then
		RaidBuffStatus:CreateBar(currenty + 19, "DPSMana", L["DPS mana"], RAID_CLASS_COLORS.WARLOCK.r, RAID_CLASS_COLORS.WARLOCK.g, RAID_CLASS_COLORS.WARLOCK.b, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.DPSMana.barframe, L["DPS mana"] .. " %", report.dpsmanalist) end, function() RaidBuffStatus:BarChat("DPSMana", L["DPS mana"]) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.HealerMana then
		RaidBuffStatus:CreateBar(currenty + 19, "HealerMana", L["Healer mana"], RAID_CLASS_COLORS.PALADIN.r, RAID_CLASS_COLORS.PALADIN.g, RAID_CLASS_COLORS.PALADIN.b, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.HealerMana.barframe, L["Healer mana"] .. " %", report.healermanalist) end, function() RaidBuffStatus:BarChat("HealerMana", L["Healer mana"]) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.RaidMana then
		RaidBuffStatus:CreateBar(currenty + 19, "RaidMana", L["Raid mana"], 0, 0, 1, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.RaidMana.barframe, L["Raid mana"] .. " %", report.raidmanalist) end, function() RaidBuffStatus:BarChat("RaidMana", L["Raid mana"]) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.TankHealth then
		RaidBuffStatus:CreateBar(currenty + 19, "TankHealth", L["Tank health"], RAID_CLASS_COLORS.WARRIOR.r, RAID_CLASS_COLORS.WARRIOR.g, RAID_CLASS_COLORS.WARRIOR.b, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.TankHealth.barframe, L["Tank health"] .. " %", report.tankhealthlist) end, function() RaidBuffStatus:BarChat("TankHealth", L["Tank health"]) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.RaidHealth then
		RaidBuffStatus:CreateBar(currenty + 19, "RaidHealth", L["Raid health"], 1, 0, 0, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.RaidHealth.barframe, L["Raid health"], report.raidhealthlist) end, function() RaidBuffStatus:BarChat("RaidHealth", L["Raid health"]) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.Range then
		RaidBuffStatus:CreateBar(currenty + 19, "Range", L["In range"], .5, .9, .5, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.Range.barframe, L["Out of range"], report.rangelist) end, function() RaidBuffStatus:BarChat("Range", L["In range"]) end)
		currenty = currenty + 11
	end
	return currenty
end

function RaidBuffStatus:IsInBGQueue()
	for i = 1, GetMaxBattlefieldID() do
		local status = GetBattlefieldStatus(i)
		if status == "queued" then
			return true
		end
	end
	return false
end
