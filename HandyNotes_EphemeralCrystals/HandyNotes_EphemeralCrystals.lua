local AddonName, ec = ...
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local EphemeralCrystals = LibStub("AceAddon-3.0"):NewAddon(AddonName, "AceEvent-3.0")
ec.EphemeralCrystals = EphemeralCrystals
local Icon = "Interface\\Addons\\HandyNotes_EphemeralCrystals\\Icon"
local crystals = {
    ["Azsuna"] = {
        [29903600] = { name="Ephemeral Crystal", zone="7334", note="in the corner crack between the hills on an island" },
        [35603780] = { name="Ephemeral Crystal", zone="7334", note="Next to tree - Llothien Highlands" },
        [38690931] = { name="Ephemeral Crystal", zone="7334", note="on green land next to bush" },
        [42661806] = { name="Ephemeral Crystal", zone="7334", note="inside Runa’s Hovel Cave on rock between spine and skull" },
        [45005360] = { name="Ephemeral Crystal", zone="7334", note="at the coast, inside the broken half of a ship (hard to see from almost every angle)" },
        [42206230] = { name="Ephemeral Crystal", zone="7334", note="on the hill near the Cove Skrog" },
        [54802800] = { name="Ephemeral Crystal", zone="7334", note="behind tree next to lake" },
        [54102760] = { name="Ephemeral Crystal", zone="7334", note="behind cement hut in bushes" },
        [54503350] = { name="Ephemeral Crystal", zone="7334", note="In lake next to basilisks" },
        [50002090] = { name="Ephemeral Crystal", zone="7334", note="Azurewing repose, in a cave, next to a wall" },
        [50003310] = { name="Ephemeral Crystal", zone="7334", note="Next to shells and hut in murloc area" },
        [61003000] = { name="Ephemeral Crystal", zone="7334", note="In a cave, on the rock to the right (near Kira Iresoul npc)" },
        [61903090] = { name="Ephemeral Crystal", zone="7334", note="behind tree" },
        [47106170] = { name="Ephemeral Crystal", zone="7334", note="Left from Oceanus cove, on a hill" },
        [47102580] = { name="Ephemeral Crystal", zone="7334", note="Next to the blue crystal lake where Senegos lies" },
        [53402790] = { name="Ephemeral Crystal", zone="7334" },
        [59703680] = { name="Ephemeral Crystal", zone="7334", note="on edge of hill" },
        [67003370] = { name="Ephemeral Crystal", zone="7334", note="On hill next to pillars" },
        [60002780] = { name="Ephemeral Crystal", zone="7334", note="behind tree" },
        [44105980] = { name="Ephemeral Crystal", zone="7334", note="on the tiny hill next to the ship" },
        [60105320] = { name="Ephemeral Crystal", zone="7334", note="next to a bunch of shadowfiends" },
        [45501720] = { name="Ephemeral Crystal", zone="7334", note="next to the lake, where lake turns to river" },
        [51006100] = { name="Ephemeral Crystal", zone="7334" },
        [51006500] = { name="Ephemeral Crystal", zone="7334", note="next to the tied rope around the poles" },
        [51805760] = { name="Ephemeral Crystal", zone="7334", note="Corner next to broken ship in Oceanus Cove" },
        [60004900] = { name="Ephemeral Crystal", zone="7334", note="bottom edge of the hill" },
        [60404670] = { name="Ephemeral Crystal", zone="7334", note="to the right of the blue teleporter cave" },
        [57502660] = { name="Ephemeral Crystal", zone="7334", note="next to the road? unconfirmed" },
        [47203300] = { name="Ephemeral Crystal", zone="7334", note="next to the river" },
        [37503290] = { name="Ephemeral Crystal", zone="7334", note="nor'danil wellspring - behind the wall next to bush and tree" },
        [36003600] = { name="Ephemeral Crystal", zone="7334", note="on cliff edge"},
        [34803530] = { name="Ephemeral Crystal", zone="7334", note="on cliff edge" },
        [29903600] = { name="Ephemeral Crystal", zone="7334" },
        [42200850] = { name="Ephemeral Crystal", zone="7334", note="on hillside" },
        [50502030] = { name="Ephemeral Crystal", zone="7334", note="Inside Layhallow (crystal) cave at 47.9, 24.8" },
        [52705790] = { name="Ephemeral Crystal", zone="7334", note="Up on hill around giants" },
        [52292524] = { name="Ephemeral Crystal", zone="7334", note="off road beside tree" },
        [53083603] = { name="Ephemeral Crystal", zone="7334" },
        [59084488] = { name="Ephemeral Crystal", zone="7334" },
        [34851714] = { name="Ephemeral Crystal", zone="7334" },
        [56004000] = { name="Ephemeral Crystal", zone="7334", note="in the lake under the bridge" },
        [67004600] = { name="Ephemeral Crystal", zone="7334", note="next to the log" },
        [67105200] = { name="Ephemeral Crystal", zone="7334", note="outside doorway to building - The Ruined Sanctum" },
        [48704850] = { name="Ephemeral Crystal", zone="7334" },
        [48004800] = { name="Ephemeral Crystal", zone="7334", note="next to the two neutral giants at the bottom of the valley" },
        [49000800] = { name="Ephemeral Crystal", zone="7334", note="on little rock inside Lair of the Deposed cave" },
        [50400780] = { name="Ephemeral Crystal", zone="7334" },
        [65494247] = { name="Ephemeral Crystal", zone="7334", note="next to water, near bridge"},
        [59373833] = { name="Ephemeral Crystal", zone="7334", note="behind naga tent" },
        [46954893] = { name="Ephemeral Crystal", zone="7334", note="near the eternal bride and groom behind a tree" },
        [45700920] = { name="Ephemeral Crystal", zone="7334" },
        [64003400] = { name="Ephemeral Crystal", zone="7334", note="at the crossroads, again very visible" },
        [64803790] = { name="Ephemeral Crystal", zone="7334" },
        [61103890] = { name="Ephemeral Crystal", zone="7334" },
        [52007100] = { name="Ephemeral Crystal", zone="7334", note="on a rock by the water? not confirmed where" },
        [62205470] = { name="Ephemeral Crystal", zone="7334", note="next to the tree" },
        [68002300] = { name="Ephemeral Crystal", zone="7334", note="north of the demon camp; very much visible from a great distance" },
        [35002200] = { name="Ephemeral Crystal", zone="7334", note="beachside near the water"},
        [58814502] = { name="Ephemeral Crystal", zone="7334", note="In cave at Ruins of Nar’thalas on rock between spine and skull (Commander Eksis mob in there)" },
        [57904260] = { name="Ephemeral Crystal", zone="7334" },
        [62535236] = { name="Ephemeral Crystal", zone="7334", note="on hill next to tree - Olivian Veil" },
        [52411344] = { name="Ephemeral Crystal", zone="7334", note="next to tree - Rhut'van Passage" },
        [40553629] = { name="Ephemeral Crystal", zone="7334", note="off road beside tree" },
        [50485699] = { name="Ephemeral Crystal", zone="7334", note="in the cave to the left, close to eternal bride and groom" },
        [62304050] = { name="Ephemeral Crystal", zone="7334", note="next to tent" },
        [58814502] = { name="Ephemeral Crystal", zone="7334", note="inside a cave very near the last crystal" },
    },
}

------------------------------------------------------------------------

local EphemeralCrystalsHandler = {}

function EphemeralCrystalsHandler:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	if self:GetCenter() > UIParent:GetCenter() then
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	mapFile = gsub(mapFile, "_terrain%d+$", "")
	local crystal = crystals[mapFile] and crystals[mapFile][coord]
	if crystal then
		tooltip:AddLine(crystal.name)
		if crystal.note then
			tooltip:AddLine(crystal.note, 1, 1, 1)
		end
		tooltip:Show()
	end
end

function EphemeralCrystalsHandler:OnLeave(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	tooltip:Hide()
end

------------------------------------------------------------------------

if TomTom then
	local function setWaypoint(mapFile, coord)
		local crystal = crystals[mapFile] and crystals[mapFile][coord]
		if not crystal then return end

		local waypoint = crystal.waypoint
		if waypoint and TomTom:IsValidWaypoint(waypoint) then
			return
		end

		local x, y = HandyNotes:getXY(coord)
		crystal.waypoint = TomTom:AddMFWaypoint(crystal.zone, nil, x, y, {
			title = crystal.name,
			cleardistance = 0,
			minimap = true,
			world = true
		})
	end

	local CURRENT_MAP, CURRENT_COORD

	local function setThisWaypoint()
		setWaypoint(CURRENT_MAP, CURRENT_COORD)
	end

	local function setAllZoneWaypoints()
		local coords = crystals[CURRENT_MAP]
		for coord, crystal in pairs(coords) do
			if crystal.name then
				setWaypoint(CURRENT_MAP, coord)
			end
		end
		TomTom:SetClosestWaypoint()
	end

	local function setAllWaypoints()
		for mapFile, coords in pairs(crystals) do
			for coord, crystal in pairs(coords) do
				if crystal.name then
					setWaypoint(mapFile, coord)
				end
			end
		end
		TomTom:SetClosestWaypoint()
	end

	function EphemeralCrystalsHandler:OnClick(button, down, mapFile, coord)
		if down or button ~= "RightButton" then
			return
		end
		mapFile = gsub(mapFile, "_terrain%d+$", "")
		if IsControlKeyDown() then
			CURRENT_MAP, CURRENT_COORD = mapFile, coord
		else
			setWaypoint(mapFile, coord)
		end
	end
end

------------------------------------------------------------------------

do
	local function iterator(crystals, prev)
		if not crystals then return end
		local coord, crystal = next(crystals, prev)
		while crystal do
			if crystal.name then
				-- coord, mapFile2, iconpath, scale, alpha, level2
				return coord, nil, Icon, ec.db.icon_scale, ec.db.icon_alpha
			end
			coord, crystal = next(crystals, coord)
		end
	end

	function EphemeralCrystalsHandler:GetNodes(mapFile, minimap, dungeonLevel)
		mapFile = gsub(mapFile, "_terrain%d+$", "")
		return iterator, crystals[mapFile]
	end
end

------------------------------------------------------------------------
-- Addon initialization, enabling and disabling

function EphemeralCrystals:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New(AddonName.."DB", ec.defaults)
    ec.db = self.db.profile
    ec.hidden = self.db.char.hidden
    HandyNotes:RegisterPluginDB(AddonName:gsub("HandyNotes_", ""), EphemeralCrystalsHandler, ec.options)
end

function EphemeralCrystals:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", AddonName:gsub("HandyNotes_", ""))
end

local Addon = CreateFrame("Frame")
Addon:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)