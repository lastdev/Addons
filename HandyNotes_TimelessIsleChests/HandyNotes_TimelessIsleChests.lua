TimelessIsleChest = LibStub("AceAddon-3.0"):NewAddon("TimelessIsleChest", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_RareElites")

--TimelessIsleChest = HandyNotes:NewModule("TimelessIsleChest", "AceConsole-3.0", "AceEvent-3.0")
--local db
local iconDefault = "Interface\\Icons\\TRADE_ARCHAEOLOGY_CHESTOFTINYGLASSANIMALS"
local iconRareElite = "Interface\\AddOns\\HandyNotes_TimelessIsleChests\\Artwork\\0skull.tga"

TimelessIsleChest.nodes = { }
local nodes = TimelessIsleChest.nodes
--nodes["Pandaria"] = { }

function TimelessIsleChest:AddNodes()
	table.wipe(nodes)
	nodes["TimelessIsle"] = { }
	nodes["CavernofLostSpirits"] = { }
	nodes["TimelessIsle"][36703410] = { "33170", "Moss-Covered Chest", "One-Time Chest 000" }
	nodes["TimelessIsle"][25502720] = { "33171", "Moss-Covered Chest", "One-Time Chest 001" }
	nodes["TimelessIsle"][27403910] = { "33172", "Moss-Covered Chest", "One-Time Chest 002" }
	nodes["TimelessIsle"][30703650] = { "33173", "Moss-Covered Chest", "One-Time Chest 003" }
	nodes["TimelessIsle"][22403540] = { "33174", "Moss-Covered Chest", "One-Time Chest 004" }
	nodes["TimelessIsle"][22104930] = { "33175", "Moss-Covered Chest", "One-Time Chest 005" }
	nodes["TimelessIsle"][24805300] = { "33176", "Moss-Covered Chest", "One-Time Chest 006" }
	nodes["TimelessIsle"][25704580] = { "33177", "Moss-Covered Chest", "One-Time Chest 007" }
	nodes["TimelessIsle"][22306810] = { "33178", "Moss-Covered Chest", "One-Time Chest 008" }
	nodes["TimelessIsle"][26806870] = { "33179", "Moss-Covered Chest", "One-Time Chest 009" }
	nodes["TimelessIsle"][31007630] = { "33180", "Moss-Covered Chest", "One-Time Chest 010" }
	nodes["TimelessIsle"][35307640] = { "33181", "Moss-Covered Chest", "One-Time Chest 011" }
	nodes["TimelessIsle"][38707160] = { "33182", "Moss-Covered Chest", "One-Time Chest 012" }
	nodes["TimelessIsle"][39807950] = { "33183", "Moss-Covered Chest", "One-Time Chest 013" }
	nodes["TimelessIsle"][34808420] = { "33184", "Moss-Covered Chest", "One-Time Chest 014" }
	nodes["TimelessIsle"][43608410] = { "33185", "Moss-Covered Chest", "One-Time Chest 015" }
	nodes["TimelessIsle"][47005370] = { "33186", "Moss-Covered Chest", "One-Time Chest 016" }
	nodes["TimelessIsle"][46704670] = { "33187", "Moss-Covered Chest", "One-Time Chest 017" }
	nodes["TimelessIsle"][51204570] = { "33188", "Moss-Covered Chest", "One-Time Chest 018" }
	nodes["TimelessIsle"][55504430] = { "33189", "Moss-Covered Chest", "One-Time Chest 019" }
	nodes["TimelessIsle"][58005070] = { "33190", "Moss-Covered Chest", "One-Time Chest 020" }
	nodes["TimelessIsle"][65704780] = { "33191", "Moss-Covered Chest", "One-Time Chest 021" }
	nodes["TimelessIsle"][63805920] = { "33192", "Moss-Covered Chest", "One-Time Chest 022" }
	nodes["TimelessIsle"][64907560] = { "33193", "Moss-Covered Chest", "One-Time Chest 023" }
	nodes["TimelessIsle"][60206600] = { "33194", "Moss-Covered Chest", "One-Time Chest 024" }
	nodes["TimelessIsle"][49706570] = { "33195", "Moss-Covered Chest", "One-Time Chest 025" }
	nodes["TimelessIsle"][53107080] = { "33196", "Moss-Covered Chest", "One-Time Chest 026" }
	nodes["TimelessIsle"][52706270] = { "33197", "Moss-Covered Chest", "One-Time Chest 027" }
	nodes["TimelessIsle"][61708850] = { "33227", "Moss-Covered Chest", "One-Time Chest 028" }
	nodes["TimelessIsle"][44206530] = { "33198", "Moss-Covered Chest", "One-Time Chest - Stump Center" }
	nodes["TimelessIsle"][26006140] = { "33199", "Moss-Covered Chest", "One-Time Chest - Stump SW Shore" }
	nodes["TimelessIsle"][24603850] = { "33200", "Moss-Covered Chest", "One-Time Chest - Stump West" }
	nodes["TimelessIsle"][29703180] = { "33202", "Moss-Covered Chest", "One-Time Chest - Steam Shore" }
	--nodes["TimelessIsle"][29703180] = { "33201", "Moss-Covered Chest", "One-Time Chest - Ordo Lake Lower" }
	nodes["TimelessIsle"][28203520] = { "33204", "Sturdy Chest", "One-Time Chest - Carry Bird 2" } -- Swapped questid's with carry bird 2
	nodes["TimelessIsle"][26806490] = { "33205", "Sturdy Chest", "One-Time Chest - Carry Bird 1" }
	nodes["TimelessIsle"][64607040] = { "33206", "Sturdy Chest", "One-Time Chest - Gulp Frogs" }
	nodes["TimelessIsle"][59204950] = { "33207", "Sturdy Chest", "One-Time Chest - Hammer Cavern" }
	nodes["TimelessIsle"][69503290] = { "33208", "Smoldering Chest", "One-Time Chest - Ordo Chest 000" }
	nodes["TimelessIsle"][54007820] = { "33209", "Smoldering Chest", "One-Time Chest - Ordo Chest 001" }
	nodes["TimelessIsle"][47602760] = { "33210", "Blazing Chest", "One-Time Chest - Blazing Chest" }

	nodes["TimelessIsle"][59903130] = { "33201", "Moss-Covered Chest", "One-Time Chest - Ordo Lake Lower" }  -- Needed Correction

	nodes["TimelessIsle"][46703230] = { "33203", "Skull-Covered Chest", "One-Time Chest - Cavern of Lost Spirits\nLocated inside the cave below" }
	nodes["CavernofLostSpirits"][62903480] = { "33203", "Skull-Covered Chest", "One-Time Chest - Cavern of Lost Spirits" }
	--nodes["Pandaria"][62903480] = { "33203", "Skull-Covered Chest", "One-Time Chest - Cavern of Lost Spirits" }


	-- Extreme Treasure Hunter
	nodes["TimelessIsle"][51607460] = { "32969", "Gleaming Treasure Chest", "Pillar Jumping\nStart Here", "Interface\\Addons\\HandyNotes_TimelessIsleChests\\Artwork\\chest_normal_daily.tga" } --Old start 51507360
	nodes["TimelessIsle"][49706940] = { "32969", "Gleaming Treasure Chest", "Pillar Jumping\n|cffffff00[Extreme Treasure Hunter]|r", "Interface\\Addons\\HandyNotes_TimelessIsleChests\\Artwork\\chest_normal_daily_end.tga" }

	nodes["TimelessIsle"][60204590] = { "32968", "Rope-Bound Treasure Chest", "Rope Walking\nStart Here", "Interface\\Addons\\HandyNotes_TimelessIsleChests\\Artwork\\chest_normal_daily.tga" }
	nodes["TimelessIsle"][53904720] = { "32968", "Rope-Bound Treasure Chest", "Rope Walking\n|cffffff00[Extreme Treasure Hunter]|r", "Interface\\Addons\\HandyNotes_TimelessIsleChests\\Artwork\\chest_normal_daily_end.tga" }

	nodes["TimelessIsle"][58506010] = { "32971", "Mist-Covered Treasure Chest", "Feather Falling\n|cffffff00[Extreme Treasure Hunter]|r\nClick on Gleaming Crane Statue\nRequires Gleaming Treasure Chest and Rope-Bound Treasure Chest to be looted first", "Interface\\Addons\\HandyNotes_TimelessIsleChests\\Artwork\\chest_normal_daily_end.tga" }

	-- Where There's Pirates, There's Booty
	nodes["TimelessIsle"][40409300] = { "32957", "Sunken Treasure", "|cffffff00[Where There's Pirates, There's Booty]|r\nKill nearby elites for the key", "Interface\\Addons\\HandyNotes_TimelessIsleChests\\Artwork\\chest_normal_daily_end.tga" }

	nodes["TimelessIsle"][16905710] = { "32956", "Blackguard's Jetsam", "Cave Entrance", "Interface\\Addons\\HandyNotes_TimelessIsleChests\\Artwork\\chest_normal_daily.tga" }
	nodes["TimelessIsle"][22705890] = { "32956", "Blackguard's Jetsam", "|cffffff00[Where There's Pirates, There's Booty]|r\nChest in cave", "Interface\\Addons\\HandyNotes_TimelessIsleChests\\Artwork\\chest_normal_daily_end.tga" }

	nodes["TimelessIsle"][70608090] = { "32970", "Gleaming Treasure Satchel", "|cffffff00[Where There's Pirates, There's Booty]|r\nIf you need help, check the comments on Wowhead.com", "Interface\\Addons\\HandyNotes_TimelessIsleChests\\Artwork\\chest_normal_daily_end.tga" }


	-- Data from RareElites
	if (self.db.profile.rareelites) then
	nodes["TimelessIsle"][35005200] = { "35170", L.EmeralGander.." \124cff1eff00\124Hitem:104287:0:0:0:0:0:0:0:0:0:0\124h["..L.EmeralGanderDrop.."]\124h\124r\n"..L.IronfurSteelhorn.." \124cff1eff00\124Hitem:89770:0:0:0:0:0:0:0:0:0:0\124h["..L.IronfurSteelhornDrop.."]\124h\124r\n"..L.ImperialPython.." \124cff0070dd\124Hitem:104161:0:0:0:0:0:0:0:0\124h["..L.ImperialPythonDrop.."]\124h\124r\n", L.EmeralGanderInfo, iconRareElite }
	nodes["TimelessIsle"][24805500] = { "35171", L.GreatTurtleFuryshell.." \124cff0070dd\124Hitem:86584:0:0:0:0:0:0:0:0:0:0\124h["..L.GreatTurtleFuryshellDrop.."]\124h\124r\n", L.GreatTurtleFuryshellInfo, iconRareElite }
	nodes["TimelessIsle"][38007500] = { "35172", L.GuchiSwarmbringer.." \124cff0070dd\124Hitem:104291:0:0:0:0:0:0:0:0:0:0\124h["..L.GuchiSwarmbringerDrop.."]\124h\124r\n", L.GuchiSwarmbringerInfo, iconRareElite }
	nodes["TimelessIsle"][47008700] = { "35173", L.Zesqua.." \124cff0070dd\124Hitem:104303:0:0:0:0:0:0:0:0:0:0\124h["..L.ZesquaDrop.."]\124h\124r\n", L.ZesquaInfo, iconRareElite }
	nodes["TimelessIsle"][37557731] = { "35174", L.ZhuGonSour.." \124cff0070dd\124Hitem:104167:0:0:0:0:0:0:0:0:0:0\124h["..L.ZhuGonSourDrop.."]\124h\124r\n", L.ZhuGonSourInfo, iconRareElite }
	nodes["TimelessIsle"][34088384] = { "35175", L.Karkanos.." \124cffffffff\124Hitem:104035:0:0:0:0:0:0:0:0:0:0\124h["..L.KarkanosDrop.."]\124h\124r\n", L.KarkanosInfo, iconRareElite }
	nodes["TimelessIsle"][25063598] = { "35176", L.Chelon.." \124cff0070dd\124Hitem:86584:0:0:0:0:0:0:0:0:0:0\124h["..L.ChelonDrop.."]\124h\124r\n", L.ChelonInfo, iconRareElite }
	nodes["TimelessIsle"][59004880] = { "35177", L.Spelurk.." \124cff1eff00\124Hitem:104320:0:0:0:0:0:0:0:0:0:0\124h["..L.SpelurkDrop.."]\124h\124r\n", L.SpelurkInfo, iconRareElite }
	nodes["TimelessIsle"][43896989] = { "35178", L.Cranegnasher.." \124cff0070dd\124Hitem:104268:0:0:0:0:0:0:0:0:0:0\124h["..L.CranegnasherDrop.."]\124h\124r\n", L.CranegnasherInfo, iconRareElite }
	nodes["TimelessIsle"][54094240] = { "35179", L.Rattleskew.." \124cffa335ee\124Hitem:104321:0:0:0:0:0:0:0:0:0:0\124h["..L.RattleskewDrop.."]\124h\124r\n", L.RattleskewInfo, iconRareElite }
	nodes["TimelessIsle"][50008700] = { "35180", L.MonstrousSpineclaw.." \124cff0070dd\124Hitem:104168:0:0:0:0:0:0:0:0:0:0\124h["..L.MonstrousSpineclawDrop.."]\124h\124r\n", L.MonstrousSpineclawInfo, iconRareElite }
	nodes["TimelessIsle"][44003900] = { "35181", L.SpiritJadefire.." \124cff0070dd\124Hitem:104258:0:0:0:0:0:0:0:0:0:0\124h["..L.SpiritJadefireDrop.."]\124h\124r\n \124cff0070dd\124Hitem:104307:0:0:0:0:0:0:0:0:0:0\124h["..L.SpiritJadefireDrop2.."]\124h\124r\n", L.SpiritJadefireInfo, iconRareElite }
	nodes["TimelessIsle"][67004300] = { "35182", L.Leafmender.." \124cff0070dd\124Hitem:104156:0:0:0:0:0:0:0:0:0:0\124h["..L.LeafmenderDrop.."]\124h\124r\n", L.LeafmenderInfo, iconRareElite }
	nodes["TimelessIsle"][65006500] = { "35183", L.Bufo.." \124cff0070dd\124Hitem:104169:0:0:0:0:0:0:0:0:0:0\124h["..L.BufoDrop.."]\124h\124r\n", L.BufoInfo, iconRareElite }
	nodes["TimelessIsle"][64002700] = { "35204", L.Garnia.." \124cff0070dd\124Hitem:104159:0:0:0:0:0:0:0:0\124h["..L.GarniaDrop.."]\124h\124r\n", L.GarniaInfo, iconRareElite } 
	nodes["TimelessIsle"][54094240] = { "35205", L.Tsavoka.." \124cff0070dd\124Hitem:104268:0:0:0:0:0:0:0:0:0:0\124h["..L.TsavokaDrop.."]\124h\124r\n", L.TsavokaInfo, iconRareElite }
	nodes["TimelessIsle"][71588185] = { "35207", L.Stinkbraid, L.StinkbraidInfo, iconRareElite }
	nodes["TimelessIsle"][46003100] = { "35208", L.RockMoss.." \124cff0070dd\124Hitem:104313:0:0:0:0:0:0:0:0:0:0\124h["..L.RockMossDrop.."]\124h\124r\n", L.RockMossInfo, iconRareElite }
	nodes["TimelessIsle"][57007200] = { "35209", L.WatcherOsu.." \124cff0070dd\124Hitem:104305:0:0:0:0:0:0:0:0\124h["..L.WatcherOsuDrop.."]\124h\124r\n", L.WatcherOsuInfo, iconRareElite }
	nodes["TimelessIsle"][52008100] = { "35210", L.JakurOrdon.." \124cff0070dd\124Hitem:104331:0:0:0:0:0:0:0:0:0:0\124h["..L.JakurOrdonDrop.."]\124h\124r\n", L.JakurOrdonInfo, iconRareElite }
	nodes["TimelessIsle"][66204050] = { "35211", L.ChampionBlackFlame.." \124cff0070dd\124Hitem:104302:0:0:0:0:0:0:0:0\124h["..L.ChampionBlackFlameDrop.."]\124h\124r\n \124cff0070dd\124Hitem:87219:0:0:0:0:0:0:0:0:0:0\124h["..L.ChampionBlackFlameDrop2.."]\124h\124r\n", L.ChampionBlackFlameInfo, iconRareElite } 
	nodes["TimelessIsle"][53005200] = { "35212", L.Cinderfall.." \124cff0070dd\124Hitem:104299:0:0:0:0:0:0:0:0:0:0\124h["..L.CinderfallDrop.."]\124h\124r\n", L.CinderfallInfo, iconRareElite } 
	nodes["TimelessIsle"][43002500] = { "35213", L.UrdurCauterizer.." \124cff0070dd\124Hitem:104306:0:0:0:0:0:0:0:0:0:0\124h["..L.UrdurCauterizerDrop.."]\124h\124r\n", L.UrdurCauterizerInfo, iconRareElite }
	nodes["TimelessIsle"][44003400] = { "35214", L.FlintlordGairan.." \124cffa335ee\124Hitem:104298:0:0:0:0:0:0:0:0\124h["..L.FlintlordGairanDrop.."]\124h\124r\n", L.FlintlordGairanInfo, iconRareElite } 
	nodes["TimelessIsle"][64106390] = { "35215", L.Huolon.." \124cffa335ee\124Hitem:104269:0:0:0:0:0:0:0:0:0:0\124h["..L.HuolonDrop.."]\124h\124r\n", L.HuolonInfo, iconRareElite } 
	nodes["TimelessIsle"][62506350] = { "35216", L.Golganarr.." \124cff0070dd\124Hitem:104262:0:0:0:0:0:0:0:0:0:0\124h["..L.GolganarrDrop.."]\124h\124r\n \124cff0070dd\124Hitem:104263:0:0:0:0:0:0:0:0:0:0\124h["..L.GolganarrDrop2.."]\124h\124r\n", L.GolganarrInfo, iconRareElite } 
	nodes["TimelessIsle"][19005800] = { "35217", L.Evermaw.." \124cffffffff\124Hitem:104115:0:0:0:0:0:0:0:0\124h["..L.EvermawDrop.."]\124h\124r\n", L.EvermawInfo, iconRareElite } 
	nodes["TimelessIsle"][28802450] = { "35218", L.DreadShipVazuvius.." \124cff0070dd\124Hitem:104294:0:0:0:0:0:0:0:0\124h["..L.DreadShipVazuviusDrop.."]\124h\124r\n", L.DreadShipVazuviusInfo, iconRareElite } 
	nodes["TimelessIsle"][34403250] = { "35219", L.ArchiereusFlame.."\124cff0070dd\124Hitem:86574:0:0:0:0:0:0:0:0:0:0\124h["..L.ArchiereusFlameDrop.."]\124h\124r\n", L.ArchiereusFlameInfo, iconRareElite } 
	nodes["TimelessIsle"][61008860] = { "35219", L.Rattleskew.."\n\124cffa335ee\124Hitem:104321:0:0:0:0:0:0:0:0:0:0\124h["..L.RattleskewDrop.."]\124h\124r\n\124cff1eff00\124Hitem:104219:0:0:0:0:0:0:0:0:0:0\124h["..L.RattleskewDrop2.."]\124h\124r\n", L.RattleskewInfo, iconRareElite } 
	end
end

function TimelessIsleChest:OnEnter(mapFile, coord) -- Copied from handynotes
    if (not nodes[mapFile][coord]) then return end
	
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	tooltip:SetText(nodes[mapFile][coord][2])
	if (nodes[mapFile][coord][3] ~= nil) then
	 tooltip:AddLine(nodes[mapFile][coord][3], nil, nil, nil, true)
	end
	tooltip:Show()
end

function TimelessIsleChest:OnLeave(mapFile, coord)
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local options = {
 type = "group",
 name = "TimelessIsleChest",
 desc = "Locations of treasure chests on Timeless Isle.",
 get = function(info) return TimelessIsleChest.db.profile[info.arg] end,
 set = function(info, v) TimelessIsleChest.db.profile[info.arg] = v; TimelessIsleChest:AddNodes(); TimelessIsleChest:Refresh() end,
 args = {
  desc = {
   name = "These settings control the look and feel of the icon.",
   type = "description",
   order = 0,
  },
  icon_scale = {
   type = "range",
   name = "Icon Scale",
   desc = "The scale of the icons",
   min = 0.25, max = 2, step = 0.01,
   arg = "icon_scale",
   order = 10,
  },
  icon_alpha = {
   type = "range",
   name = "Icon Alpha",
   desc = "The alpha transparency of the icons",
   min = 0, max = 1, step = 0.01,
   arg = "icon_alpha",
   order = 20,
  },
  alwaysshow = {
   type = "toggle",
   name = "Show All Chests",
   desc = "Always show every chest regardless of looted status",
   arg = "alwaysshow",
   order = 2,
  },
  rareelites = {
	type = "toggle",
	name = "Show RareElites",
	desc = "Show nodes from RareElites addon",
	arg = "rareelites",
	order = 2.01,
  },
  save = {
   type = "toggle",
   name = "Save to SavedVariables",
   arg = "save",
  },
 },
}

function TimelessIsleChest:OnInitialize()
 local defaults = {
  profile = {
   icon_scale = 1.0,
   icon_alpha = 1.0,
   alwaysshow = false,
   rareelites = false,
   save = true,
  },
 }

 self.db = LibStub("AceDB-3.0"):New("TimelessIsleChestsDB", defaults, true)
 self:RegisterEvent("PLAYER_ENTERING_WORLD", "WorldEnter")
 self:AddNodes()
end

function TimelessIsleChest:WorldEnter()
 self:UnregisterEvent("PLAYER_ENTERING_WORLD")

 --self:RegisterEvent("WORLD_MAP_UPDATE", "Refresh")
 --self:RegisterEvent("LOOT_CLOSED", "Refresh")

 --self:Refresh()
 self:ScheduleTimer("RegisterWithHandyNotes", 10)
end

function TimelessIsleChest:RegisterWithHandyNotes()
do
	local function iter(t, prestate)
		if not t then return nil end
		local state, value = next(t, prestate)
		while state do
			    -- questid, chest type, quest name, icon
			    if (value[1] and not TimelessIsleChest:HasBeenLooted(value)) then
				 --print(state)
				 local icon = value[4] or iconDefault
				 return state, nil, icon, TimelessIsleChest.db.profile.icon_scale, TimelessIsleChest.db.profile.icon_alpha
				end
			state, value = next(t, state)
		end
	end
	function TimelessIsleChest:GetNodes(mapFile, isMinimapUpdate, dungeonLevel)
	    if (mapFile == "CavernofLostSpirits" and isMinimapUpdate) then return iter, nodes["Hack"], nil end
		return iter, nodes[mapFile], nil
	end
end
 HandyNotes:RegisterPluginDB("TimelessIsleChest", self, options)
 self:RegisterBucketEvent({ "LOOT_CLOSED" }, 2, "Refresh")
 self:Refresh()
end
 

function TimelessIsleChest:Refresh()
 if (not self.db.profile.save) then
  table.wipe(self.db.char)
 end
 self:SendMessage("HandyNotes_NotifyUpdate", "TimelessIsleChest")
end

function TimelessIsleChest:HasBeenLooted(value)
 if (self.db.profile.alwaysshow) then return false end
 
 if (self.db.char[value[1]] and self.db.profile.save) then return true end
 
 if (C_QuestLog.IsQuestFlaggedCompleted(value[1])) then
  if (self.db.profile.save and not value[4]) then  -- Save the chest but not if it's a daily
   self.db.char[value[1]] = true;
  end
  
  return true
 end
  
 return false
end
