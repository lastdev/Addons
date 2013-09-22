TimelessIsle_RareElites = LibStub("AceAddon-3.0"):NewAddon("TimelessIsle_RareElites", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end

--TimelessIsle_RareElites = HandyNotes:NewModule("TimelessIsle_RareElites", "AceConsole-3.0", "AceEvent-3.0")
local db
local iconDefault = "Interface\\AddOns\\HandyNotes_TimelessIsle_RareElites\\Artwork\\0skull.tga"

TimelessIsle_RareElites.nodes = { }
local nodes = TimelessIsle_RareElites.nodes

nodes["TimelessIsle"] = { }

nodes["TimelessIsle"][35005200] = { "35170", "Emeral Gander - Ironfur Steelhorn - Imperial Python", "spawns at various locations around the Celestial Court." }
nodes["TimelessIsle"][24805500] = { "35171", "Great Turtle Furyshell", "patrols among the turtles on the western shore of the island." }
nodes["TimelessIsle"][38007500] = { "35172", "Gu'chi the Swarmbringer", "spawns around Old Pi'Jiu." }
nodes["TimelessIsle"][47008700] = { "35173", "Zesqua", "spawns off the coast of Pi'Jiu, slightly to the east." }
nodes["TimelessIsle"][37557731] = { "35174", "Zhu-Gon the Sour", "spawns after completing the Skunky Beer mini-event at the same location." }
nodes["TimelessIsle"][34088384] = { "35175", "Karkanos", "is summoned by talking to Fin Longpaw" }
nodes["TimelessIsle"][25063598] = { "35176", "Chelon", "spawns after you inspect the shell" }
nodes["TimelessIsle"][59004880] = { "35177", "Spelurk", "can be summoned by breaking the cave-in of the Mysterious Den. You can break the cave-in by using the new action button you get from finding and opening the objects of Timeless Legends Icon Timeless Legends. Alternatively, a Mage with Blink Icon Blink can teleport to the other side of the wall and use the hammer inside the cave to destroy the wall." }
nodes["TimelessIsle"][43896989] = { "35178", "Cranegnasher", "needs to be summoned. You will find the corpse of a dead Fishgorged Crane. Inspecting the corpse indicates that these cranes are the favorite food of a creature. This means that you need to kite a live Fishgorged Crane onto the corpse to summon Cranegnasher (you will find these ads just south of the corpse)." }
nodes["TimelessIsle"][54094240] = { "35179", "Rattleskew", "spawns in Tsavoka's Den" }
nodes["TimelessIsle"][50008700] = { "35180", "Monstrous Spineclaw", "patrols underwater, off the southern coast of the island." }
nodes["TimelessIsle"][44003900] = { "35181", "Spirit of Jadefire ", "spawns inside the Caverns of Lost Spirits in the recess on the right, almost facing Zarhym." }
nodes["TimelessIsle"][67004300] = { "35182", "Leafmender", "spawns in the Blazing Way, around the tree" }
nodes["TimelessIsle"][65006500] = { "35183", "Bufo", "spawns in the area filled with Gulp Frogs" }
nodes["TimelessIsle"][64002700] = { "35204", "Garnia", "spawns in the Red Lake." } 
nodes["TimelessIsle"][54094240] = { "35205", "Tsavo'ka", "spawns in Tsavoka's Den" }
nodes["TimelessIsle"][71588185] = { "35207", "Stinkbraid", "spawns on the deck of the pirate ship." }
nodes["TimelessIsle"][46003100] = { "35208", "Rock Moss", "spawns at the bottom of the Cavern of Lost Spirits." }
nodes["TimelessIsle"][57007200] = { "35209", "Watcher Osu", "spawns in the Firewalker Ruins." }
nodes["TimelessIsle"][52008100] = { "35210", "Jakur of Ordon", "Jakur of Ordon" }
nodes["TimelessIsle"][63006500] = { "35211", "Champion of the Black Flame", "are three adds that patrol between the two bridges of the Blazing Way." } 
nodes["TimelessIsle"][53005200] = { "35212", "Cinderfall", "spawns on the broken bridge." } 
nodes["TimelessIsle"][43002500] = { "35213", "Urdur the Cauterizer", "spawns on the broken bridge." }
nodes["TimelessIsle"][44003400] = { "35214", "Flintlord Gairan", "spawns at various locations around the Ordon Sanctuary." } 
nodes["TimelessIsle"][69004100] = { "35215", "Huolon", "flies around the Blazing Way and the Firewalker Ruins." } 
nodes["TimelessIsle"][62506350] = { "35216", "Golganarr", "Around here" } 
--nodes["TimelessIsle"][59903130] = { "35217", "Evermaw", "" } 
nodes["TimelessIsle"][28802450] = { "35218", "Dread Ship Vazuvius", "It needs to be summoned at the nearby beach with the Mist-Filled Spirit Lantern Icon Mist-Filled Spirit Lantern that drops from Evermaw." } 
nodes["TimelessIsle"][34403250] = { "35219", "Archiereus of Flame", "spawns inside the Ordon Sanctuary, so players who do not have the legendary cloak will need to use a Scroll of Challenge Icon Scroll of Challenge at the Challenger's Stone" } 

--[[ function TimelessIsle_RareElites:OnEnable()
end

function TimelessIsle_RareElites:OnDisable()
end ]]--

--local handler = {}
do
	local function iter(t, prestate)
		if not t then return nil end
		local state, value = next(t, prestate)
		while state do
			    -- questid, chest type, quest name, icon
			    if (value[1] and (not IsQuestFlaggedCompleted(value[1]) or db.alwaysshow)) then
				 --print(state)
				 local icon = value[4] or iconDefault
				 return state, nil, icon, db.icon_scale, db.icon_alpha
				end
			state, value = next(t, state)
		end
	end
	function TimelessIsle_RareElites:GetNodes(mapFile, isMinimapUpdate, dungeonLevel)
		return iter, nodes[mapFile], nil
	end
end

function TimelessIsle_RareElites:OnEnter(mapFile, coord) -- Copied from handynotes
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

function TimelessIsle_RareElites:OnLeave(mapFile, coord)
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local options = {
 type = "group",
 name = "TimelessIsle_RareElites",
 desc = "Locations of RareElites on Timeless Isle.",
 get = function(info) return db[info.arg] end,
 set = function(info, v) db[info.arg] = v; TimelessIsle_RareElites:Refresh() end,
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
--  alwaysshow = {
--   type = "toggle",
--   name = "Show All Chests",
--   desc = "Always show every Elite regardless of looted status",
--   arg = "alwaysshow",
--   order = 2,
--  },
 },
}

function TimelessIsle_RareElites:OnInitialize()
 local defaults = {
  profile = {
   icon_scale = 1.0,
   icon_alpha = 1.0,
   alwaysshow = false,
  },
 }

 db = LibStub("AceDB-3.0"):New("TimelessIsle_RareElitessDB", defaults, true).profile
 HandyNotes:RegisterPluginDB("TimelessIsle_RareElites", self, options)
 --self:RegisterEvent("WORLD_MAP_UPDATE", "Refresh")
 --self:RegisterEvent("LOOT_CLOSED", "Refresh")
 self:RegisterBucketEvent({ "WORLD_MAP_UPDATE", "LOOT_CLOSED" }, 2, "Refresh")
end

function TimelessIsle_RareElites:Refresh()
 self:SendMessage("HandyNotes_NotifyUpdate", "TimelessIsle_RareElites")
end