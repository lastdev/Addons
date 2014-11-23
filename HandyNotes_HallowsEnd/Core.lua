
------------------------------------------
--  This addon was heavily inspired by  --
--    HandyNotes_Lorewalkers            --
--    HandyNotes_LostAndFound           --
--  by Kemayo                           --
------------------------------------------


-- declaration
local ID, HallowsEnd = ...
HallowsEnd.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }


-- upvalues
local _G = getfenv(0)

local CloseDropDownMenus = _G.CloseDropDownMenus
local GameTooltip = _G.GameTooltip
local gsub = _G.string.gsub
local IsQuestFlaggedCompleted = _G.IsQuestFlaggedCompleted
local LibStub = _G.LibStub
local next = _G.next
local pairs = _G.pairs
local ToggleDropDownMenu = _G.ToggleDropDownMenu
local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip

local Astrolabe = DongleStub("Astrolabe-1.0")
local Cartographer_Waypoints = _G.Cartographer_Waypoints
local HandyNotes = _G.HandyNotes
local NotePoint = _G.NotePoint
local TomTom = _G.TomTom

local points = HallowsEnd.points


-- plugin handler for HandyNotes
function HallowsEnd:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	tooltip:SetText("Candy Bucket")
	tooltip:Show()
end

function HallowsEnd:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local function createWaypoint(_, mapFile, coord)
	local x, y = HandyNotes:getXY(coord)

	if TomTom then
		local m = GetCurrentMapAreaID()

		TomTom:AddMFWaypoint(m, nil, x, y, { title = "Candy Bucket" })
--		TomTom:AddZWaypoint(c, z, x * 100, y * 100, "Candy Bucket")
	elseif Cartographer_Waypoints then
		local c, z = HandyNotes:GetCZ(mapFile)
		local zone = HandyNotes:GetCZToZone(c, z)

		Cartographer_Waypoints:AddWaypoint( NotePoint:new(zone, x, y, "Candy Bucket") )
	end
end

do
	-- context menu generator
	local info = {}
	local currentZone, currentCoord

	local function close()
		-- we need to do this to avoid "for initial value must be a number" errors
		CloseDropDownMenus()
	end

	local function generateMenu(button, level)
		if not level then return end

		for k in pairs(info) do info[k] = nil end

		if level == 1 then
			-- create the title of the menu
			info.isTitle = 1
			info.text = "Candy Bucket"
			info.notCheckable = 1

			UIDropDownMenu_AddButton(info, level)

			if TomTom or Cartographer_Waypoints then
				-- waypoint menu item
				info.notCheckable = nil
				info.disabled = nil
				info.isTitle = nil
				info.icon = nil
				info.text = "Create waypoint"
				info.func = createWaypoint
				info.arg1 = currentZone
				info.arg2 = currentCoord

				UIDropDownMenu_AddButton(info, level)
			end

			-- close menu item
			info.text = "Close"
			info.func = close
			info.arg1 = nil
			info.arg2 = nil
			info.icon = nil
			info.isTitle = nil
			info.disabled = nil
			info.notCheckable = 1

			UIDropDownMenu_AddButton(info, level)
		end
	end

	local dropdown = CreateFrame("Frame", "HandyNotes_HallowsEndDropdownMenu")
	dropdown.displayMode = "MENU"
	dropdown.initialize = generateMenu

	function HallowsEnd:OnClick(button, down, mapFile, coord)
		if button == "RightButton" and not down then
			currentZone = mapFile
			currentCoord = coord

			ToggleDropDownMenu(1, nil, dropdown, self, 0, 0)
		end
	end
end

do
	local continentMapFile = {
		["Kalimdor"]              = {__index = Astrolabe.ContinentList[1]},
		["Azeroth"]               = {__index = Astrolabe.ContinentList[2]},
		["Expansion01"]           = {__index = Astrolabe.ContinentList[3]},
		["Northrend"]             = {__index = Astrolabe.ContinentList[4]},
		["TheMaelstromContinent"] = {__index = Astrolabe.ContinentList[5]},
		["Vashjir"]               = {[0] = 613, 614, 615, 610},
		["Pandaria"]              = {__index = Astrolabe.ContinentList[6]},
	}

	for k, v in pairs(continentMapFile) do
		setmetatable(v, v)
	end

	-- custom iterator we use to iterate over every node in a given zone
	local function iter(t, prestate)
		if not t then return nil end

		local state, value = next(t, prestate)

		while state do -- have we reached the end of this zone?
			if value and (db.completed or not IsQuestFlaggedCompleted(value)) then
				return state, nil, "interface\\icons\\achievement_halloween_candy_01", db.icon_scale, db.icon_alpha
			end

			state, value = next(t, state) -- get next data
		end

		return nil, nil, nil, nil
	end

	local function iterCont(t, prestate)
		if not t then return nil end

		local zone = t.Z
		local mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
		local cleanMapFile = gsub(mapFile, "_terrain%d+$", "")
		local data = points[cleanMapFile]
		local state, value

		while mapFile do
			if data then -- only if there is data for this zone
				state, value = next(data, prestate)

				while state do -- have we reached the end of this zone?
					if value and (db.completed or not IsQuestFlaggedCompleted(value)) then -- show on continent?
						return state, mapFile, "interface\\icons\\achievement_halloween_candy_01", db.icon_scale, db.icon_alpha
					end

					state, value = next(data, state) -- get next data
				end
			end

			-- get next zone
			zone = zone + 1
			t.Z = zone
			mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
			cleanMapFile = gsub(mapFile or "", "_terrain%d+$", "")
			data = points[cleanMapFile]
			prestate = nil
		end
	end

	function HallowsEnd:GetNodes(mapFile)
		local C = continentMapFile[mapFile] -- Is this a continent?

		if C then
			local tbl = { C = C, Z = 0 }
			return iterCont, tbl, nil
		else
			mapFile = gsub(mapFile, "_terrain%d+$", "")
			return iter, points[mapFile], nil
		end
	end
end


-- config
local options = {
	type = "group",
	name = "Hallow's End",
	desc = "Hallow's End candy bucket locations.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		HallowsEnd:Refresh()
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon.",
			type = "description",
			order = 1,
		},
		completed = {
			name = "Show completed",
			desc = "Show icons for candy buckets you have already visited.",
			type = "toggle",
			width = "full",
			arg = "completed",
			order = 2,
		},
		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "Change the size of the icons.",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 3,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "Change the transparency of the icons.",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 4,
		},
	},
}


-- initialise
function HallowsEnd:OnEnable()
	local _, month, day = CalendarGetDate()

	if ( month == 10 and day >= 18 ) or ( month == 11 and day == 1 ) then
		HandyNotes:RegisterPluginDB("HallowsEnd", self, options)
		self:RegisterEvent("QUEST_TURNED_IN", "Refresh") -- args: questID, unknown, zero

		db = LibStub("AceDB-3.0"):New("HandyNotes_HallowsEndDB", defaults, "Default").profile
	else
		self:Disable()
	end
end

function HallowsEnd:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "HallowsEnd")
end


-- activate
HallowsEnd = LibStub("AceAddon-3.0"):NewAddon(HallowsEnd, ID, "AceEvent-3.0")
