-- declaration
local _, Valdrakken = ...
Valdrakken.points = {}

-- db and defaults
local db
local defaults = { profile = { icon_scale = 1.4, icon_alpha = 0.8, icon_style = 1, toggle_vendors = true, toggle_profs = true, toggle_amens = true, toggle_rp = false} }

local notes = {
	["1"] = "Soragosa",
	["2"] = "Threadfinder Pax\nThreadfinder Fulafong",
	["3"] = "Giera",
	["4"] = "Hideshaper Koruz\nRalathor the Rugged",
	["5"] = "Rostrum of Transformation",
	["6"] = "Lithragosa\n(multi-person dragonriding)",
	["7"] = "Expordira\nImporigo",
	["8"] = "Sekita the Burrower",
	["9"] = "Metalshaper Kuroko",
	["10"] = "Weaponsmith Koref\nProvisioner Thom\nArmorsmith Terisk",
	["11"] = "Clinkyclick Shatterboom",
	["12"] = "Erugosa",
	["13"] = "Toklo",
	["14"] = "Talendara",
	["15"] = "Conflago",
	["16"] = "Scaravelle",
	["17"] = "Tuluradormi",
	["18"] = "Vekkalis\nNumernormi\nAeoreon",
	["19"] = "Visage of True Self",
	["20"] = "Jyhanna",
	["21"] = "Tithris",
	["22"] = "Orgrimmar / Stormwind",
	["23"] = "Rethelshi\nMythressa",
	["24"] = "Agrikus",
	["25"] = "Kaestrasz",
	["26"] = "Warpweaver Dayelis\nVaultkeeper Aleer",
	["27"] = "Mairadormi",
	["28"] = "Lysindra",
	["29"] = "Tethalash",
	["30"] = "Gardener Cereus",
	["31"] = "Groundskeeper Kama",
	["32"] = "Unatos",
	["33"] = "Kritha\nEmote '/bow' at the Odd Statue in the Roasted Ram to teleport into the hidden room.",
	["34"] = "Sorotis",
	["35"] = "Malicia\nFieldmaster Emberath\nInside Gladiator's Refuge.",
	["36"] = "Inside Gladiator's Refuge.",
	["37"] = "Aluri",

	--rp
	["38"] = "No NPCs\nHas a bed & some ground pillows",
	["39"] = "Tea Testing Emporium\nHas some seats",
	["40"] = "Cascade's Edge Vista\nHas benches & seats",
	["41"] = "Fallingwater Overlook\nSpeak to Cadrestrasz to buy a VIP Pass\nHas consumable teas & foods",
	["42"] = "The Petitioner's Concourse\nNo NPCs\nHas seats",
	["43"] = "The Petitioner's Concourse\nOpen empty area",
	["44"] = "Below Valdrakken, entrance in Thaldraszus",
	["45"] = "Little Scales Daycare\nHas a bunch of cute whelps and a few places to sit",
	["46"] = "Some interactible NPCs",
	["47"] = "Weyrnrest\nSome interactible NPCs\n2 beds & some seats",
	["48"] = "Mage Building\nNo NPCs\nHas 1 seat",
	["49"] = "The Sapphire Enclave Vista\nSmall ledge with benches",
	["50"] = "Azure Archives Annex\nSome interactible NPCs\nPettable cat\nTower Teleport rune outside",
	["51"] = "Sabigosa's House\nSome interactible NPCs\nHas seats",
	["52"] = "The Literary Vista\nMany NPCs",
	["53"] = "Empty Restaurant\nNo NPCs\nHas seats",
	["54"] = "Arguing Gardener's Building",
	["55"] = "The Ruby Enclave Vista\nSome NPCs\nHas benches",
	["56"] = "The Ruby Feast\nMany NPCs\nInteractible foods",
	["57"] = "Titanic Watcher Island\nLake area with ducks&fish",
	["58"] = "Picnic Area\nNo NPCs",
	["59"] = "Mage Building\n1 NPC\nHas 2 seats",
	["60"] = "No NPCs\nHas bed & seat",
	["61"] = "The Emerald Enclave Vista\nOpen empty area",
	["62"] = "Wistera's Dreamroom\nSome NPCs",
	["63"] = "The Bronze Enclave Vista\nOpen area",
	["64"] = "Rathos's House\n1 NPC\nHas bed",
	["65"] = "No NPCs\nHas a bed & some seats",
	["66"] = "The Emerald Enclave Vista\nSome NPCs\nHas benches",
	["67"] = "Dragon Runestones Vista",
	["68"] = "Gardens of Unity Vista\nHas some NPCs and places to explore",
	["69"] = "Serene Dreams Spa Cliffside\nHas NPCs\nLower surrounding area has hostiles", --nice
	["70"] = "Serene Dreams Spa Floating Island\nRequires flight\nHas NPCs\nLower surrounding area has hostiles",
	["71"] = "The Roasted Ram\nHas some NPCs\nHas a few beds & seats and a second floor\nA secret area can be accessed by performing '/bow' at the Odd Statue",

}

-- upvalues
local GameTooltip = _G.GameTooltip
local UIParent = _G.UIParent

local LibStub = _G.LibStub
local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local points = Valdrakken.points

-- plugin handler for HandyNotes
function Valdrakken:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local point = points[mapFile] and points[mapFile][coord]
	local text
	local ID, mode = point:match("(%d+):(.*)")

		if mode == "renown" then
			text = "Renown Vendor"
		elseif mode == "petbattle" then
			text = "Pet Charms"
		elseif mode == "primalist" then
			text = "Primal Research"
		elseif mode == "mounts" then
			text = "Quartermaster"
		elseif mode == "pvp" then
			text = "PvP Vendors"
		elseif mode == "enchanting" then
			text = "Enchanting Trainer"
		elseif mode == "tailoring" then
			text = "Tailoring Trainer"
		elseif mode == "leatherworking" then
			text = "Leatherworking Trainer\nSkinning Trainer"
		elseif mode == "mining" then
			text = "Mining Trainer"
		elseif mode == "blacksmith" then
			text = "Blacksmithing Trainer"
		elseif mode == "engineer" then
			text = "Engineering Trainer"
		elseif mode == "cooking" then
			text = "Cooking Trainer"
		elseif mode == "fishing" then
			text = "Fishing Trainer"
		elseif mode == "inscription" then
			text = "Inscription Trainer"
		elseif mode == "alchemy" then
			text = "Alchemy Trainer"
		elseif mode == "jewelcraft" then
			text = "Jewelcrafting Trainer"
		elseif mode == "herb" then
			text = "Herbalism Trainer"
		elseif mode == "dragonriding" then
			text = "Dragonriding"
		elseif mode == "auction" then
			text = "Auction House"
		elseif mode == "craftorder" then
			text = "Crafting Orders"
		elseif mode == "banking" then
			text = "Bank\nGuild Vault\nGreat Vault"
		elseif mode == "barber" then
			text = "Barber"
		elseif mode == "inn" then
			text = "Innkeeper"
		elseif mode == "portal" then
			text = "Portal Room"
		elseif mode == "stables" then
			text = "Stable Master"
		elseif mode == "transmog" then
			text = "Transmogrifier\nVoid Storage"
		elseif mode == "dummy" then
			text = "Training Dummies"
		elseif mode == "taxi" then
			text = "Flight Master"
		elseif mode == "building" then
			text = "Building"
		elseif mode == "vista" then
			text = "Vista"
		elseif mode == "bmah" then
			text = "Black Market Auction House"
		end

	GameTooltip:SetText(text)

	if notes[ID] then
		GameTooltip:AddLine(notes[ID])
	end

	if TomTom then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Right-click to set a waypoint.", 1, 1, 1)
	end

	GameTooltip:Show()
end

function Valdrakken:OnLeave()
	GameTooltip:Hide()
end

local function createWaypoint(mapFile, coord)
	local x, y = HandyNotes:getXY(coord)
	local point = points[mapFile] and points[mapFile][coord]

	TomTom:AddWaypoint(mapFile, x, y, { title = "Valdrakken Point", persistent = nil, minimap = true, world = true })
end

function Valdrakken:OnClick(button, down, mapFile, coord)
	if TomTom and button == "RightButton" and not down then
		createWaypoint(mapFile, coord)
	end
end

do
	local function iterator(t, prev)
		if not Valdrakken.isEnabled then return end
		if not t then return end

		local coord, value = next(t, prev)
		while coord do
			local ID, mode = value:match("(%d+):(.*)")
			local icon
			Valdrakken.Style()

			if mode == "renown" then
				icon = icons.buy
			elseif mode == "petbattle" then
				icon = icons.petbattle
			elseif mode == "primalist" then
				icon = icons.buy
			elseif mode == "mounts" then
				icon = icons.buy
			elseif mode == "pvp" then
				icon = icons.pvp
			elseif mode == "enchanting" then
				icon = icons.enchant
			elseif mode == "tailoring" then
				icon = icons.tailor
			elseif mode == "leatherworking" then
				icon = icons.leatherwork
			elseif mode == "mining" then
				icon = icons.mining
			elseif mode == "blacksmith" then
				icon = icons.blacksmith
			elseif mode == "engineer" then
				icon = icons.engineer
			elseif mode == "cooking" then
				icon = icons.cooking
			elseif mode == "fishing" then
				icon = icons.fishing
			elseif mode == "inscription" then
				icon = icons.scribe
			elseif mode == "alchemy" then
				icon = icons.alchemy
			elseif mode == "jewelcraft" then
				icon = icons.jewel
			elseif mode == "herb" then
				icon = icons.herb
			elseif mode == "dragonriding" then
				icon = icons.dragon
			elseif mode == "auction" then
				icon = icons.auction
			elseif mode == "craftorder" then
				icon = icons.workorder
			elseif mode == "banking" then
				icon = icons.bank
			elseif mode == "barber" then
				icon = icons.barber
			elseif mode == "inn" then
				icon = icons.inn
			elseif mode == "portal" then
				icon = icons.portal
			elseif mode == "stables" then
				icon = icons.stables
			elseif mode == "transmog" then
				icon = icons.transmog
			elseif mode == "dummy" then
				icon = icons.dummy
			elseif mode == "taxi" then
				icon = icons.taxi
			elseif mode == "building" then
				icon = icons.building
			elseif mode == "vista" then
				icon = icons.vista
			elseif mode == "bmah" then
				icon = icons.auction
			end

			if value then
				return coord, nil, icon, db.icon_scale, db.icon_alpha
			end

			coord, value = next(t, coord)
		end
	end

	function Valdrakken:GetNodes2(mapID)
		Valdrakken.NodeToggle()
		return iterator, points[mapID]
	end
end

function Valdrakken.NodeToggle()
	if db.toggle_vendors == true then
		for i, v in pairs(Valdrakken.vendors) do
			points[2112][i] = v
		end
	elseif db.toggle_vendors == false then
		for i,_ in pairs(Valdrakken.vendors) do
			points[2112][i]=nil
		end
	end
	if db.toggle_profs == true then
		for i, v in pairs(Valdrakken.professions) do
			points[2112][i] = v
		end
	elseif db.toggle_profs == false then
		for i,_ in pairs(Valdrakken.professions) do
			points[2112][i]=nil
		end
	end
	if db.toggle_amens == true then
		for i, v in pairs(Valdrakken.amenities) do
			points[2112][i] = v
		end
	elseif db.toggle_amens == false then
		for i,_ in pairs(Valdrakken.amenities) do
			points[2112][i]=nil
		end
	end
	if db.toggle_rp == true then
		for i, v in pairs(Valdrakken.roleplay) do
			points[2112][i] = v
		end
	elseif db.toggle_rp == false then
		for i,_ in pairs(Valdrakken.roleplay) do
			points[2112][i]=nil
		end
	end
	if db.toggle_rp == true then
		for i, v in pairs(Valdrakken.roleplay2) do
			points[2025][i] = v
		end
	elseif db.toggle_rp == false then
		for i,_ in pairs(Valdrakken.roleplay2) do
			points[2025][i]=nil
		end
	end
end

function Valdrakken.Style()
	if db.icon_style == 1 then
		icons = Valdrakken.circle
	elseif db.icon_style == 2 then
		icons = Valdrakken.outline
	elseif db.icon_style == 3 then
		icons = Valdrakken.noborder
	elseif db.icon_style == 4 then
		icons = Valdrakken.square
	elseif db.icon_style == 5 then
		icons = Valdrakken.newprof_circle
	elseif db.icon_style == 6 then
		icons = Valdrakken.newprof_outline
	elseif db.icon_style == 7 then
		icons = Valdrakken.newprof_noborder
	elseif db.icon_style == 8 then
		icons = Valdrakken.newprof_square
	end
end


-- config
local options = {
	type = "group",
	name = "Valdrakken",
	desc = "Valdrakken locations.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		Valdrakken:Refresh()
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon.",
			type = "description",
			order = 1,
		},
		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "Change the size of the icons.",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 2,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "Change the transparency of the icons.",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 3,
		},
		icon_style = {
			type = "range",
			name = "Icon Style",
			desc = "Change the style of the icons.",
			min = 1, max = 8, step = 1,
			arg = "icon_style",
			order = 4,
		},
		toggle_vendors = {
			name = "Show Vendors",
			desc = "Show icons for vendors.",
			type = "toggle",
			width = "full",
			arg = "toggle_vendors",
			order = 5,
		},
		toggle_profs = {
			name = "Show Profession",
			desc = "Show icons for profession trainers.",
			type = "toggle",
			width = "full",
			arg = "toggle_profs",
			order = 6,
		},
		toggle_amens = {
			name = "Show Amenities",
			desc = "Show icons for amenities.",
			type = "toggle",
			width = "full",
			arg = "toggle_amens",
			order = 7,
		},
		toggle_rp = {
			name = "Show RP Spots",
			desc = "Show icons for vistas, buildings, and sightseeing areas.",
			type = "toggle",
			width = "full",
			arg = "toggle_rp",
			order = 7,
		},
	},
}


-- initialise
function Valdrakken:OnEnable()
	self.isEnabled = true

	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then
		HandyNotes:Print("Your installed copy of HandyNotes is out of date and Valdrakken plug-in will not work correctly.  Please update HandyNotes to version 1.5.0 or newer.")
		return
	end

	HandyNotes:RegisterPluginDB("Valdrakken", self, options)
	db = LibStub("AceDB-3.0"):New("HandyNotes_ValdrakkenDB", defaults, "Default").profile
end

function Valdrakken:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "Valdrakken")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(Valdrakken, "HandyNotes_Valdrakken", "AceEvent-3.0")