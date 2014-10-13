local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"
local DARK_RED = "|cFFF00000"

-- *** Reputations ***
local CAT_GUILD = 6
local CAT_ALLINONE = CAT_GUILD + 1

local ICON_NOTREADY = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_READY = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"

local Factions = {
	-- Factions reference table, based on http://www.wowwiki.com/Factions
	{	-- [1]
		name = EXPANSION_NAME0,	-- "Classic"
		{	-- [1]
			name = FACTION_ALLIANCE,	-- 469
			{ name = GetFactionInfoByID(69), icon = "Achievement_Character_Nightelf_Female" },	-- "Darnassus"
			{ name = GetFactionInfoByID(930), icon = "Achievement_Character_Draenei_Male" },	--  name = "Exodar"
			{ name = GetFactionInfoByID(54), icon = "Achievement_Character_Gnome_Female" },	-- "Gnomeregan"
			{ name = GetFactionInfoByID(47), icon = "Achievement_Character_Dwarf_Male" },		-- "Ironforge"
			{ name = GetFactionInfoByID(72), icon = "Achievement_Character_Human_Male" },		-- "Stormwind"
			{ name = GetFactionInfoByID(1134), icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.625, right = 0.75, top = 0, bottom = 0.25 },	-- "Gilneas"
			{ name = GetFactionInfoByID(1353), icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.75, right = 0.875, top = 0, bottom = 0.25 },	-- "Tushui Pandaren"
			{ name = GetFactionInfoByID(469), icon = "INV_BannerPVP_02" },	-- "Alliance"
		},
		{	-- [2]
			name = FACTION_HORDE,
			{ name = GetFactionInfoByID(530), icon = "Achievement_Character_Troll_Male" },		-- "Darkspear Trolls"
			{ name = GetFactionInfoByID(76), icon = "Achievement_Character_Orc_Male" },		-- "Orgrimmar"
			{ name = GetFactionInfoByID(81), icon = "Achievement_Character_Tauren_Male" },		-- "Thunder Bluff"
			{ name = GetFactionInfoByID(68), icon = "Achievement_Character_Undead_Female" },		-- "Undercity"
			{ name = GetFactionInfoByID(911), icon = "Achievement_Character_Bloodelf_Male" },		-- "Silvermoon City"
			{ name = GetFactionInfoByID(1133), icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.625, right = 0.75, top = 0.25, bottom = 0.5 },	--  name = "Bilgewater Cartel"
			{ name = GetFactionInfoByID(1352), icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.75, right = 0.875, top = 0.25, bottom = 0.5 },	-- "Huojin Pandaren" 
			{ name = GetFactionInfoByID(67), icon = "INV_BannerPVP_01" },	-- "Horde" 
		},
		{	-- [3]
			name = L["Alliance Forces"],	-- 891
			{ name = GetFactionInfoByID(509), icon = "Achievement_BG_winAB" },	--  name = "The League of Arathor" 
			{ name = GetFactionInfoByID(890), icon = "Achievement_BG_captureflag_WSG" },	-- "Silverwing Sentinels" 
			{ name = GetFactionInfoByID(730), icon = "Achievement_BG_winAV" },		-- "Stormpike Guard"
		},
		{	-- [4]
			name = L["Horde Forces"],
			{ name = GetFactionInfoByID(510), icon = "Achievement_BG_winAB" },		-- "The Defilers" 
			{ name = GetFactionInfoByID(889), icon = "Achievement_BG_captureflag_WSG" },	-- "Warsong Outriders" 
			{ name = GetFactionInfoByID(729), icon = "Achievement_BG_winAV" },		-- "Frostwolf Clan" 
		},
		{	-- [5]
			name = L["Steamwheedle Cartel"],
			{ name = GetFactionInfoByID(21), icon = "Achievement_Zone_Stranglethorn_01" },		-- "Booty Bay" 
			{ name = GetFactionInfoByID(577), icon = "Achievement_Zone_Winterspring" },		-- "Everlook" 
			{ name = GetFactionInfoByID(369), icon = "Achievement_Zone_Tanaris_01" },		-- "Gadgetzan" 
			{ name = GetFactionInfoByID(470), icon = "Achievement_Zone_Barrens_01" },		-- "Ratchet" 
		},
		{	-- [6]
			name = OTHER,
			{ name = GetFactionInfoByID(529), icon = "INV_Jewelry_Talisman_07" },		-- "Argent Dawn" 
			{ name = GetFactionInfoByID(87), icon = "INV_Helmet_66" },		-- "Bloodsail Buccaneers" 
			{ name = GetFactionInfoByID(910), icon = "INV_Misc_Head_Dragon_Bronze" },		-- "Brood of Nozdormu" 
			{ name = GetFactionInfoByID(609), icon = "Achievement_Zone_Silithus_01" },		-- "Cenarion Circle" 
			{ name = GetFactionInfoByID(909), icon = "INV_Misc_Ticket_Darkmoon_01" },		-- "Darkmoon Faire" 
			{ name = GetFactionInfoByID(92), icon = "INV_Misc_Head_Centaur_01" },			-- "Gelkis Clan Centaur" 
			{ name = GetFactionInfoByID(749), icon = "Spell_Frost_SummonWaterElemental_2" },		-- "Hydraxian Waterlords" 
			{ name = GetFactionInfoByID(93), icon = "INV_Misc_Head_Centaur_01" },		-- "Magram Clan Centaur" 
			{ name = GetFactionInfoByID(349), icon = "INV_ThrowingKnife_04" },		-- "Ravenholdt" 
			{ name = GetFactionInfoByID(809), icon = "Achievement_Zone_Feralas" },		-- "Shen'dralar" 
			{ name = GetFactionInfoByID(70), icon = "INV_Misc_ArmorKit_03" },		-- "Syndicate" 
			{ name = GetFactionInfoByID(59), icon = "INV_Ingot_Thorium" },		-- "Thorium Brotherhood" 
			{ name = GetFactionInfoByID(576), icon = "Achievement_Reputation_timbermaw" },		-- "Timbermaw Hold" 
			{ name = GetFactionInfoByID(922), icon = "Achievement_Zone_Ghostlands" },		-- "Tranquillien" 
			{ name = GetFactionInfoByID(589), icon = "Ability_Mount_PinkTiger" },		-- "Wintersaber Trainers" 
			{ name = GetFactionInfoByID(270), icon = "INV_Bijou_Green" },		-- "Zandalar Tribe" 
		}
	},
	{	-- [2]
		name = EXPANSION_NAME1,	-- "The Burning Crusade"
		{	-- [1]
			name = GetRealZoneText(530),	-- Outland
			{ name = GetFactionInfoByID(1012), icon = "Achievement_Reputation_AshtongueDeathsworn" },	-- "Ashtongue Deathsworn" 
			{ name = GetFactionInfoByID(942), icon = "Achievement_Reputation_GuardiansofCenarius" },	-- "Cenarion Expedition" 
			{ name = GetFactionInfoByID(933), icon = "INV_Enchant_ShardPrismaticLarge" },		-- "The Consortium" 
			{ name = GetFactionInfoByID(946), icon = "Spell_Misc_HellifrePVPHonorHoldFavor" },	-- "Honor Hold" 
			{ name = GetFactionInfoByID(978), icon = "INV_Misc_Foot_Centaur" },		-- "Kurenai" 
			{ name = GetFactionInfoByID(941), icon = "Achievement_Zone_Nagrand_01" },	-- "The Mag'har" 
			{ name = GetFactionInfoByID(1015), icon = "Ability_Mount_NetherdrakePurple" },		-- "Netherwing" 
			{ name = GetFactionInfoByID(1038), icon = "Achievement_Reputation_Ogre" },		-- "Ogri'la" 
			{ name = GetFactionInfoByID(970), icon = "INV_Mushroom_11" },	-- "Sporeggar" 
			{ name = GetFactionInfoByID(947), icon = "Spell_Misc_HellifrePVPThrallmarFavor" },	-- "Thrallmar" 
		},
		{	-- [2]
			name = GetMapNameByID(481),	-- "Shattrath City"
			{ name = GetFactionInfoByID(1011), icon = "Achievement_Zone_Terrokar" },		-- "Lower City" 
			{ name = GetFactionInfoByID(1031), icon = "Ability_Hunter_Pet_NetherRay" },		-- "Sha'tari Skyguard" 
			{ name = GetFactionInfoByID(1077), icon = "INV_Shield_48" },		-- "Shattered Sun Offensive" 
			{ name = GetFactionInfoByID(932), icon = "Achievement_Character_Draenei_Female" },	-- "The Aldor" 
			{ name = GetFactionInfoByID(934), icon = "Achievement_Character_Bloodelf_Female" },		-- "The Scryers" 
			{ name = GetFactionInfoByID(935), icon = "Achievement_Zone_Netherstorm_01" },		-- "The Sha'tar" 
		},
		{	-- [3]
			name = OTHER,
			{ name = GetFactionInfoByID(989), icon = "Achievement_Zone_HillsbradFoothills" },		-- "Keepers of Time" 
			{ name = GetFactionInfoByID(990), icon = "INV_Enchant_DustIllusion" },	-- "The Scale of the Sands" 
			{ name = GetFactionInfoByID(967), icon = "Spell_Holy_MindSooth" },		-- "The Violet Eye" 
		}
	},
	{	-- [3]
		name = EXPANSION_NAME2,	-- "Wrath of the Lich King"
		{	-- [1]
			name = GetRealZoneText(571),	-- Northrend
			{ name = GetFactionInfoByID(1106), icon = "Achievement_Reputation_ArgentCrusader" },		-- "Argent Crusade"
			{ name = GetFactionInfoByID(1090), icon = "Achievement_Reputation_KirinTor" },		-- "Kirin Tor" 
			{ name = GetFactionInfoByID(1073), icon = "Achievement_Reputation_Tuskarr" },	-- "The Kalu'ak" 
			{ name = GetFactionInfoByID(1091), icon = "Achievement_Reputation_WyrmrestTemple" },		-- "The Wyrmrest Accord" 
			{ name = GetFactionInfoByID(1098), icon = "Achievement_Reputation_KnightsoftheEbonBlade" },	-- "Knights of the Ebon Blade" 
			{ name = GetFactionInfoByID(1119), icon = "Achievement_Boss_Hodir_01" },		-- "The Sons of Hodir" 
			{ name = GetFactionInfoByID(1156), icon = "Achievement_Reputation_ArgentCrusader" },		-- "The Ashen Verdict" 
		},
		{	-- [2]
			name = GetFactionInfoByID(1037), 	-- "Alliance Vanguard"
			{ name = GetFactionInfoByID(1037), icon = "Spell_Misc_HellifrePVPHonorHoldFavor" },	-- "Alliance Vanguard" 
			{ name = GetFactionInfoByID(1068), icon = "Achievement_Zone_HowlingFjord_02" },	-- "Explorers' League" 
			{ name = GetFactionInfoByID(1126), icon = "Achievement_Zone_StormPeaks_01" },		-- "The Frostborn" 
			{ name = GetFactionInfoByID(1094), icon = "Achievement_Zone_CrystalSong_01" },		-- "The Silver Covenant" 
			{ name = GetFactionInfoByID(1050), icon = "Achievement_Zone_BoreanTundra_01" },	-- "Valiance Expedition" 	
		},
		{	-- [3]
			name = GetFactionInfoByID(1052), 	-- "Horde Expedition"
			{ name = GetFactionInfoByID(1052), icon = "Spell_Misc_HellifrePVPThrallmarFavor" },		-- "Horde Expedition" 
			{ name = GetFactionInfoByID(1067), icon = "Achievement_Zone_HowlingFjord_02" },		-- "The Hand of Vengeance" 
			{ name = GetFactionInfoByID(1124), icon = "Achievement_Zone_CrystalSong_01" },			-- "The Sunreavers" 
			{ name = GetFactionInfoByID(1064), icon = "Achievement_Zone_BoreanTundra_02" },		-- "The Taunka" 
			{ name = GetFactionInfoByID(1085), icon = "Achievement_Zone_BoreanTundra_03" },		-- "Warsong Offensive" 
		},
		{	-- [4]
			name = GetMapNameByID(493),	-- "Sholazar Basin"
			{ name = GetFactionInfoByID(1104), icon = "Ability_Mount_WhiteDireWolf" },		-- "Frenzyheart Tribe" 
			{ name = GetFactionInfoByID(1105), icon = "Achievement_Reputation_MurlocOracle" },	-- "The Oracles" 
		},
	},
	{	-- [4]
		name = EXPANSION_NAME3,	-- "Cataclysm"
		{	-- [1]
			name = OTHER,
			{ name = GetFactionInfoByID(1158), icon = "Achievement_Zone_mount hyjal" },		-- "Guardians of Hyjal" 
			{ name = GetFactionInfoByID(1135), icon = "Spell_Nature_EarthElemental_Totem" },		-- "The Earthen Ring" 
			{ name = GetFactionInfoByID(1171), icon = "inv_misc_tabard_therazane" },		-- "Therazane" 
			{ name = GetFactionInfoByID(1174), icon = "inv_misc_tabard_wildhammerclan" },		-- "Wildhammer Clan" 
			{ name = GetFactionInfoByID(1173), icon = "inv_misc_tabard_tolvir" },		-- "Ramkahen" 
			{ name = GetFactionInfoByID(1177), icon = "inv_misc_tabard_baradinwardens" },		-- "Baradin's Wardens" 
			{ name = GetFactionInfoByID(1172), icon = "inv_misc_tabard_dragonmawclan" },		-- "Dragonmaw Clan" 
			{ name = GetFactionInfoByID(1178), icon = "inv_misc_tabard_hellscream" },		-- "Hellscream's Reach" 
			{ name = GetFactionInfoByID(1204), icon = "inv_neck_hyjaldaily_04" },		-- "Avengers of Hyjal" 
		}
	},
	{	-- [5]
		name = EXPANSION_NAME4,	-- "Mists of Pandaria"
		{	-- [1]
			name = GetFactionInfoByID(1302), 	-- "The Anglers"
			{ name = GetFactionInfoByID(1358), icon = "achievement_faction_anglers" },		-- "Nat Pagle" 
		},
		{	-- [2]
			name = GetFactionInfoByID(1272), 	-- "The Tillers"
			{ name = GetFactionInfoByID(1277), icon = "achievement_faction_tillers" },		-- "Chee Chee" 
			{ name = GetFactionInfoByID(1275), icon = "achievement_faction_tillers" },		-- "Ella" 
			{ name = GetFactionInfoByID(1283), icon = "achievement_faction_tillers" },		-- "Farmer Fung" 
			{ name = GetFactionInfoByID(1282), icon = "achievement_faction_tillers" },		-- "Fish Fellreed" 
			{ name = GetFactionInfoByID(1281), icon = "achievement_faction_tillers" },		-- "Gina Mudclaw" 
			{ name = GetFactionInfoByID(1279), icon = "achievement_faction_tillers" },		-- "Haohan Mudclaw" 
			{ name = GetFactionInfoByID(1273), icon = "achievement_faction_tillers" },		-- "Jogu the Drunk" 
			{ name = GetFactionInfoByID(1276), icon = "achievement_faction_tillers" },		-- "Old Hillpaw" 
			{ name = GetFactionInfoByID(1278), icon = "achievement_faction_tillers" },		-- "Sho" 
			{ name = GetFactionInfoByID(1280), icon = "achievement_faction_tillers" },		-- "Tina Mudclaw" 
		},
		{	-- [3]
			name = OTHER,
			{ name = GetFactionInfoByID(1375), icon = "achievement_general_hordeslayer" },		-- "Dominance Offensive" 
			{ name = GetFactionInfoByID(1228), icon = "inv_misc_fish_58" },		-- "Forest Hozen" 
			{ name = GetFactionInfoByID(1269), icon = "achievement_faction_goldenlotus" },		-- "Golden Lotus" 
			{ name = GetFactionInfoByID(1387), icon = "achievement_reputation_kirintor_offensive" },		-- "Kirin Tor Offensive" 
			{ name = GetFactionInfoByID(1376), icon = "achievement_general_allianceslayer" },		-- "Operation: Shieldwall" 
			{ name = GetFactionInfoByID(1271), icon = "achievement_faction_serpentriders" },		-- "Order of the Cloud Serpent" 
			{ name = GetFactionInfoByID(1242), icon = "inv_misc_fish_58" },		-- "Pearlfin Jinyu" 
			{ name = GetFactionInfoByID(1270), icon = "achievement_faction_shadopan" },		-- "Shado-Pan" 
			{ name = GetFactionInfoByID(1435), icon = "achievement_faction_shadopan" },		-- "Shado-Pan Assault" 
			{ name = GetFactionInfoByID(1216), icon = "inv_misc_book_07" },		-- "Shang Xi's Academy" 
			{ name = GetFactionInfoByID(1388), icon = "achievement_faction_sunreaveronslaught" },		-- "Sunreaver Onslaught" 
			{ name = GetFactionInfoByID(1302), icon = "achievement_faction_anglers" },		-- "The Anglers" 
			{ name = GetFactionInfoByID(1341), icon = "achievement_faction_celestials" },		-- "The August Celestials" 
			{ name = GetFactionInfoByID(1359), icon = "inv_misc_head_dragon_black" },		-- "The Black Prince" 
			{ name = GetFactionInfoByID(1351), icon = "inv_cask_02" },		-- "The Brewmasters" 
			{ name = GetFactionInfoByID(1337), icon = "achievement_faction_klaxxi" },		-- "The Klaxxi" 
			{ name = GetFactionInfoByID(1345), icon = "achievement_faction_lorewalkers" },		-- "The Lorewalkers" 
			{ name = GetFactionInfoByID(1272), icon = "achievement_faction_tillers" },		-- "The Tillers" 
			{ name = GetFactionInfoByID(1492), icon = "ability_monk_quipunch" },		-- "Emperor Shaohao"
		}
	},
	{	-- [6]
		name = GUILD,
		{	-- [1]
			name = GUILD,
		}
	},
}

local VertexColors = {
	[FACTION_STANDING_LABEL1] = { r = 0.4, g = 0.13, b = 0.13 },	-- hated
	[FACTION_STANDING_LABEL2] = { r = 0.5, g = 0.0, b = 0.0 },		-- hostile
	[FACTION_STANDING_LABEL3] = { r = 0.6, g = 0.4, b = 0.13 },		-- unfriendly
	[FACTION_STANDING_LABEL4] = { r = 0.6, g = 0.6, b = 0.0 },		-- neutral
	[FACTION_STANDING_LABEL5] = { r = 0.0, g = 0.6, b = 0.0 },		-- friendly
	[FACTION_STANDING_LABEL6] = { r = 0.0, g = 0.6, b = 0.6 },		-- honored
	[FACTION_STANDING_LABEL7] = { r = 0.9, g = 0.3, b = 0.9 },		-- revered
	[FACTION_STANDING_LABEL8] = { r = 1.0, g = 1.0, b = 1.0 },		-- exalted
}

local view
local isViewValid

local OPTION_XPACK = "UI.Tabs.Grids.Reputations.CurrentXPack"
local OPTION_FACTION = "UI.Tabs.Grids.Reputations.CurrentFactionGroup"

local currentFaction
local currentDDMText

local function BuildView()
	view = view or {}
	wipe(view)
	
	local currentXPack = addon:GetOption(OPTION_XPACK)
	local currentFactionGroup = addon:GetOption(OPTION_FACTION)

	if (currentXPack ~= CAT_ALLINONE) then
		for index, faction in ipairs(Factions[currentXPack][currentFactionGroup]) do
			table.insert(view, faction)	-- insert the table pointer
		end
	else	-- all in one, add all factions
		for xPackIndex, xpack in ipairs(Factions) do		-- all xpacks
			for factionGroupIndex, factionGroup in ipairs(xpack) do 	-- all faction groups
				for index, faction in ipairs(factionGroup) do
					table.insert(view, faction)	-- insert the table pointer
				end
			end
		end
		
		table.sort(view, function(a,b) 	-- sort all factions alphabetically
			return a.name < b.name
		end)
	end
	
	isViewValid = true
end

local function AddGuildsToFactionsTable(realm, account)
	-- get the guilds on this realm/account
	local guilds = {}
	for guildName, guild in pairs(DataStore:GetGuilds(realm, account)) do
		if DataStore:GetGuildFaction(guildName, realm, account) == FACTION_ALLIANCE then
			guilds[guildName] = "inv_misc_tournaments_banner_human"
		else
			guilds[guildName] = "inv_misc_tournaments_banner_orc"
		end
	end
	
	-- clean the Factions table
	for k, v in ipairs(Factions[CAT_GUILD][1]) do	-- ipairs ! only touch the array part, leave the hash untouched
		Factions[CAT_GUILD][1][k] = nil
	end
	
	-- add them to the Factions table
	for k, v in pairs(guilds) do
		table.insert(Factions[CAT_GUILD][1], { name = k, icon = v } )
	end
end

local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

local function OnFactionChange(self, xpackIndex, factionGroupIndex)
	CloseDropDownMenus()

	addon:SetOption(OPTION_XPACK, xpackIndex)
	addon:SetOption(OPTION_FACTION, factionGroupIndex)
		
	local factionGroup = Factions[xpackIndex][factionGroupIndex]
	currentDDMText = factionGroup.name
	addon.Tabs.Grids:SetViewDDMText(currentDDMText)
	
	isViewValid = nil
	addon.Tabs.Grids:Update()
end

local lastRealm, lastAccount

local function OnGuildSelected(self)
	CloseDropDownMenus()
	
	addon:SetOption(OPTION_XPACK, CAT_GUILD)
	addon:SetOption(OPTION_FACTION, 1)
	
	local realm, account = addon.Tabs.Grids:GetRealm()
	
	if not lastRealm or not lastAccount or lastRealm ~= realm or lastAccount ~= account then	-- realm/account changed ? rebuild view
		AddGuildsToFactionsTable(realm, account)
	end
	
	lastRealm = realm
	lastAccount = account
	currentDDMText = GUILD
	addon.Tabs.Grids:SetViewDDMText(currentDDMText)
	
	isViewValid = nil
	addon.Tabs.Grids:Update()
end

local function OnAllInOneSelected(self)
	addon:SetOption(OPTION_XPACK, CAT_ALLINONE)
	addon:SetOption(OPTION_FACTION, 1)
	
	currentDDMText = L["All-in-one"]
	addon.Tabs.Grids:SetViewDDMText(currentDDMText)
	isViewValid = nil
	addon.Tabs.Grids:Update()
	
end

local function DropDown_Initialize(self, level)
	if not level then return end

	local info = UIDropDownMenu_CreateInfo()
	
	local currentXPack = addon:GetOption(OPTION_XPACK)
	local currentFactionGroup = addon:GetOption(OPTION_FACTION)
	
	if level == 1 then
		for xpackIndex = 1, (CAT_GUILD - 1) do
			info.text = Factions[xpackIndex].name
			info.hasArrow = 1
			info.checked = (currentXPack == xpackIndex)
			info.value = xpackIndex
			UIDropDownMenu_AddButton(info, level)
		end
		
		-- Guild factions
		info.text = GUILD
		info.hasArrow = nil
		info.func = OnGuildSelected
		info.checked = (currentXPack == CAT_GUILD)
		UIDropDownMenu_AddButton(info, level)

		info.text = L["All-in-one"]
		info.hasArrow = nil
		info.func = OnAllInOneSelected
		info.checked = (currentXPack == CAT_ALLINONE)
		UIDropDownMenu_AddButton(info, level)
		
		DDM_AddCloseMenu()
	
	elseif level == 2 then
		for factionGroupIndex, factionGroup in ipairs(Factions[UIDROPDOWNMENU_MENU_VALUE]) do
			info.text = factionGroup.name
			info.func = OnFactionChange
			info.checked = ((currentXPack == UIDROPDOWNMENU_MENU_VALUE) and (currentFactionGroup == factionGroupIndex))
			info.arg1 = UIDROPDOWNMENU_MENU_VALUE
			info.arg2 = factionGroupIndex
			UIDropDownMenu_AddButton(info, level)
		end
	end
end

local function GetSuggestion(faction, bottom)
	if not addon.FactionLeveling then return end
	
	local factionTable = addon.FactionLeveling[faction]
	if not factionTable then return end
	
	local levels = {}
	for k, _ in pairs(factionTable) do		-- get the levels for which we have a suggestion for this faction
		table.insert(levels, k)
	end
	table.sort(levels)	-- sort them, otherwise there's a risk of returning a suggestion for the wrong level
	
	-- at this point, levels may look like : { 0, 9000, 42000 }
	
	for _, level in ipairs(levels) do
		if bottom < level then	-- the suggestions are sorted by level, so whenever we're below, return the text
			return format("%s:\n%s", format(L["Up to %s"], DataStore:GetReputationLevelText(level)), factionTable[level] )
		end
	end
end

local callbacks = {
	OnUpdate = function() 
			if not isViewValid then
				BuildView()
			end

			local currentXPack = addon:GetOption(OPTION_XPACK)
			local currentFactionGroup = addon:GetOption(OPTION_FACTION)
			
			if (currentXPack == CAT_GUILD) then
				addon.Tabs.Grids:SetStatus(GUILD)
			elseif (currentXPack == CAT_ALLINONE) then
				addon.Tabs.Grids:SetStatus(L["All-in-one"])
			else
				addon.Tabs.Grids:SetStatus(format("%s / %s", Factions[currentXPack].name, Factions[currentXPack][currentFactionGroup].name))
			end
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, entry, row, dataRowID)
			currentFaction = view[dataRowID]
			
			local rowName = entry .. row
			_G[rowName.."Name"]:SetText(WHITE .. currentFaction.name)
			_G[rowName.."Name"]:SetJustifyH("LEFT")
			_G[rowName.."Name"]:SetPoint("TOPLEFT", 15, 0)
		end,
	ColumnSetup = function(self, entry, row, column, dataRowID, character)
			local itemName = entry.. row .. "Item" .. column;
			local itemTexture = _G[itemName .. "_Background"]
			local itemButton = _G[itemName]
			local itemText = _G[itemName .. "Name"]
		
			local faction = currentFaction
			
			if faction.left then		-- if it's not a full texture, use tcoords
				itemTexture:SetTexture(faction.icon)
				itemTexture:SetTexCoord(faction.left, faction.right, faction.top, faction.bottom)
			else
				itemTexture:SetTexture("Interface\\Icons\\"..faction.icon)
				itemTexture:SetTexCoord(0, 1, 0, 1)
			end		
			
			itemText:SetFontObject("GameFontNormalSmall")
			itemText:SetJustifyH("CENTER")
			itemText:SetPoint("BOTTOMRIGHT", 5, 0)
			itemTexture:SetDesaturated(0)
			
			local status, _, _, rate = DataStore:GetReputationInfo(character, faction.name)
			if status and rate then 
				local text
				if status == FACTION_STANDING_LABEL8 then
					text = ICON_READY
				else
					itemTexture:SetDesaturated(1)
					itemText:SetFontObject("NumberFontNormalSmall")
					itemText:SetJustifyH("RIGHT")
					itemText:SetPoint("BOTTOMRIGHT", 0, 0)
					text = format("%2d", floor(rate)) .. "%"
				end

				local vc = VertexColors[status]
				itemTexture:SetVertexColor(vc.r, vc.g, vc.b);
				
				local color = WHITE
				if status == FACTION_STANDING_LABEL1 or status == FACTION_STANDING_LABEL2 then
					color = DARK_RED
				end

				itemButton.key = character
				itemButton:SetID(dataRowID)
				itemText:SetText(color..text)
			else
				itemTexture:SetVertexColor(0.3, 0.3, 0.3);	-- greyed out
				itemText:SetText(ICON_NOTREADY)
				itemButton:SetID(0)
				itemButton.key = nil
			end
		end,
		
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end

			local faction = view[ frame:GetID() ].name
			local status, currentLevel, maxLevel, rate = DataStore:GetReputationInfo(character, faction)
			if not status then return end
			
			AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
			AltoTooltip:ClearLines();
			AltoTooltip:AddLine(DataStore:GetColoredCharacterName(character) .. WHITE .. " @ " ..	TEAL .. faction,1,1,1);

			rate = format("%d", floor(rate)) .. "%"
			AltoTooltip:AddLine(format("%s: %d/%d (%s)", status, currentLevel, maxLevel, rate),1,1,1 )
						
			local bottom = DataStore:GetRawReputationInfo(character, faction)
			local suggestion = GetSuggestion(faction, bottom)
			if suggestion then
				AltoTooltip:AddLine(" ",1,1,1)
				AltoTooltip:AddLine("Suggestion: ",1,1,1)
				AltoTooltip:AddLine(TEAL .. suggestion,1,1,1)
			end
			
			AltoTooltip:AddLine(" ",1,1,1)
			AltoTooltip:AddLine(format("%s = %s", ICON_NOTREADY, UNKNOWN), 0.8, 0.13, 0.13)
			AltoTooltip:AddLine(FACTION_STANDING_LABEL1, 0.8, 0.13, 0.13)
			AltoTooltip:AddLine(FACTION_STANDING_LABEL2, 1.0, 0.0, 0.0)
			AltoTooltip:AddLine(FACTION_STANDING_LABEL3, 0.93, 0.4, 0.13)
			AltoTooltip:AddLine(FACTION_STANDING_LABEL4, 1.0, 1.0, 0.0)
			AltoTooltip:AddLine(FACTION_STANDING_LABEL5, 0.0, 1.0, 0.0)
			AltoTooltip:AddLine(FACTION_STANDING_LABEL6, 0.0, 1.0, 0.8)
			AltoTooltip:AddLine(FACTION_STANDING_LABEL7, 1.0, 0.4, 1.0)
			AltoTooltip:AddLine(format("%s = %s", ICON_READY, FACTION_STANDING_LABEL8), 1, 1, 1)
			
			AltoTooltip:AddLine(" ",1,1,1)
			AltoTooltip:AddLine(GREEN .. L["Shift+Left click to link"])
			AltoTooltip:Show()
			
		end,
	OnClick = function(frame, button)
			local character = frame.key
			if not character then return end

			local faction = view[ frame:GetParent():GetID() ].name
			local status, currentLevel, maxLevel, rate = DataStore:GetReputationInfo(character, faction)
			if not status then return end
			
			if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
				local chat = ChatEdit_GetLastActiveWindow()
				if chat:IsShown() then
					chat:Insert(format(L["%s is %s with %s (%d/%d)"], DataStore:GetCharacterName(character), status, faction, currentLevel, maxLevel))
				end
			end
		end,
	OnLeave = function(self)
			AltoTooltip:Hide() 
		end,
	InitViewDDM = function(frame, title) 
			frame:Show()
			title:Show()

			local currentXPack = addon:GetOption(OPTION_XPACK)
			local currentFactionGroup = addon:GetOption(OPTION_FACTION)
			
			if (currentXPack ~= CAT_ALLINONE) then
				currentDDMText = Factions[currentXPack][currentFactionGroup].name
			else
				currentDDMText = L["All-in-one"]
			end
			
			if (currentXPack == CAT_GUILD) then
				local realm, account = addon.Tabs.Grids:GetRealm()
				AddGuildsToFactionsTable(realm, account)
			end
			
			UIDropDownMenu_SetWidth(frame, 100) 
			UIDropDownMenu_SetButtonWidth(frame, 20)
			UIDropDownMenu_SetText(frame, currentDDMText)
			addon:DDM_Initialize(frame, DropDown_Initialize)
		end,
}

addon.Tabs.Grids:RegisterGrid(2, callbacks)
