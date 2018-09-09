
------------------------------------------
--  This addon was heavily inspired by  --
--    HandyNotes_Lorewalkers            --
--    HandyNotes_LostAndFound           --
--  by Kemayo                           --
------------------------------------------


-- declaration
local _, SummerFestival = ...
SummerFestival.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }


-- upvalues
local _G = getfenv(0)

local C_Timer_NewTicker = _G.C_Timer.NewTicker
local C_Calendar = _G.C_Calendar
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = _G.GetAchievementCriteriaInfo
local GetGameTime = _G.GetGameTime
local GetQuestsCompleted = _G.GetQuestsCompleted
local gsub = _G.string.gsub
local IsControlKeyDown = _G.IsControlKeyDown
local LibStub = _G.LibStub
local next = _G.next
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local completedQuests = {}
local points = SummerFestival.points


-- plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	mapFile = gsub(mapFile, "_terrain%d+$", "")

	local point = points[mapFile] and points[mapFile][coord]

	if point == "Zidormi" then
		return point
	else
		local mode = point:match("%d+:(.*)")

		if mode == "H" then -- honour the flame
			return "Honour the Flame"
		elseif mode == "D" then -- desecrate this fire
			return "Desecrate this Fire"
		elseif mode == "C" then -- stealing the enemy's flame
			return "Capture the Capital City's Flame"
		end
	end
end

function SummerFestival:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local text = infoFromCoord(mapFile, coord)

	tooltip:SetText(text)

	if text == "Zidormi" then
		tooltip:AddLine("Talk to the Time Keeper to travel back in time if you can't find the bonfire.", 1, 1, 1)
	end

	if TomTom then
		tooltip:AddLine("Right-click to set a waypoint.", 1, 1, 1)
		tooltip:AddLine("Control-Right-click to set waypoints to every bonfire.", 1, 1, 1)
	end

	tooltip:Show()
end

function SummerFestival:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end


local function createWaypoint(mapFile, coord)
	local x, y = HandyNotes:getXY(coord)
	local m = HandyNotes:GetMapFiletoMapID(mapFile)

	local text = infoFromCoord(mapFile, coord)

	TomTom:AddMFWaypoint(m, nil, x, y, { title = text })
	TomTom:SetClosestWaypoint()
end

local function createAllWaypoints()
	local questID, mode

	for mapFile, coords in next, points do
		for coord, value in next, coords do
			questID, mode = value:match("(%d+):(.*)")

			if coord and (db.completed or not completedQuests[tonumber(questID)]) then
				createWaypoint(mapFile, coord)
			end
		end
	end
end

function SummerFestival:OnClick(button, down, mapFile, coord)
	if TomTom and button == "RightButton" and not down then
		if IsControlKeyDown() then
			createAllWaypoints()
		else
			createWaypoint(mapFile, coord)
		end
	end
end


do
	-- custom iterator we use to iterate over every node in a given zone
	local function iter(t, prestate)
		if not SummerFestival.isEnabled then return nil end
		if not t then return nil end

		local state, value = next(t, prestate)

		while state do -- have we reached the end of this zone?
			if value == "Zidormi" then
				return state, mapFile, "interface\\icons\\spell_holy_borrowedtime", db.icon_scale, db.icon_alpha
			else
				local questID, mode = value:match("(%d+):(.*)")
				local icon

				if mode == "H" then -- honour the flame
					icon = "interface\\icons\\inv_summerfest_firespirit"
				elseif mode == "D" then -- desecrate this fire
					icon = "interface\\icons\\spell_fire_masterofelements"
				elseif mode == "C" then -- stealing the enemy's flame
					icon = "interface\\icons\\spell_fire_flameshock"
				end

				if (db.completed or not completedQuests[tonumber(questID)]) then
					return state, mapFile, icon, db.icon_scale, db.icon_alpha
				end
			end

			state, value = next(t, state) -- get next data
		end

		return nil, nil, nil, nil
	end

	local function iterCont(t, prestate)
		if not SummerFestival.isEnabled then return nil end
		if not t then return nil end

		local zone = t.Z
		local mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
		local state, value, data, cleanMapFile

		while mapFile do
			cleanMapFile = gsub(mapFile, "_terrain%d+$", "")
			data = points[cleanMapFile]

			if data then -- only if there is data for this zone
				state, value = next(data, prestate)

				while state do -- have we reached the end of this zone?
					if value == "Zidormi" then
						return state, mapFile, "interface\\icons\\spell_holy_borrowedtime", db.icon_scale, db.icon_alpha
					else
						local questID, mode = value:match("(%d+):(.*)")
						local icon

						if mode == "H" then -- honour the flame
							icon = "interface\\icons\\inv_summerfest_firespirit"
						elseif mode == "D" then -- desecrate this fire
							icon = "interface\\icons\\spell_fire_masterofelements"
						elseif mode == "C" then -- stealing the enemy's flame
							icon = "interface\\icons\\spell_fire_flameshock"
						end

						if (db.completed or not completedQuests[tonumber(questID)]) then
							return state, mapFile, icon, db.icon_scale, db.icon_alpha
						end
					end

					state, value = next(data, state) -- get next data
				end
			end

			-- get next zone
			zone = next(t.C, zone)
			t.Z = zone
			mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
			prestate = nil
		end
	end

	function SummerFestival:GetNodes(mapFile)
		local C = HandyNotes:GetContinentZoneList(mapFile) -- Is this a continent?

		if C then
			local tbl = { C = C, Z = next(C) }
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
	name = "Midsummer Festival",
	desc = "Midsummer Fesitval bonfire locations.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		SummerFestival:Refresh()
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon.",
			type = "description",
			order = 1,
		},
		completed = {
			name = "Show completed",
			desc = "Show icons for bonfires you have already visited.",
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


-- check
local setEnabled = false
local function CheckEventActive()
	local date = C_Calendar.GetDate()
	local month, day, year = date.month, date.monthDay, date.year

	local monthInfo = C_Calendar.GetMonthInfo()
	local curMonth, curYear = monthInfo.month, monthInfo.year

	local monthOffset = -12 * (curYear - year) + month - curMonth
	local numEvents = C_Calendar.GetNumDayEvents(monthOffset, day)

	for i=1, numEvents do
		local event = C_Calendar.GetDayEvent(monthOffset, day, i)

		if event.iconTexture == 235472 or event.iconTexture == 235473 or event.iconTexture == 235474 then
			if event.sequenceType == "ONGOING" then
				setEnabled = true
			else
				local hour = GetGameTime()

				if event.sequenceType == "END" and hour <= event.endTime.hour or event.sequenceType == "START" and hour >= event.startTime.hour then
					setEnabled = true
				else
					setEnabled = false
				end
			end
		end
	end

	if setEnabled and not SummerFestival.isEnabled then
		completedQuests = GetQuestsCompleted(completedQuests)

		SummerFestival.isEnabled = true
		SummerFestival:Refresh()
		SummerFestival:RegisterEvent("QUEST_TURNED_IN", "Refresh")

		HandyNotes:Print("The Midsummer Fire Festival has begun!  Locations of bonfires are now marked on your map.")
	elseif not setEnabled and SummerFestival.isEnabled then
		SummerFestival.isEnabled = false
		SummerFestival:Refresh()
		SummerFestival:UnregisterAllEvents()

		HandyNotes:Print("The Midsummer Fire Festival has ended.  See you next year!")
	end
end


-- initialise
function SummerFestival:OnEnable()
	self.isEnabled = false

	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then
		HandyNotes:Print("Your installed copy of HandyNotes is out of date and the Summer Festival plug-in will not work correctly.  Please update HandyNotes to version 1.5.0 or newer.")
		return
	end

	local date = C_Calendar.GetDate()
	C_Calendar.SetAbsMonth(date.month, date.year)

	C_Timer_NewTicker(15, CheckEventActive)
	HandyNotes:RegisterPluginDB("SummerFestival", self, options)

	db = LibStub("AceDB-3.0"):New("HandyNotes_SummerFestivalDB", defaults, "Default").profile
end

function SummerFestival:Refresh(_, questID)
	if questID then completedQuests[questID] = true end
	self:SendMessage("HandyNotes_NotifyUpdate", "SummerFestival")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(SummerFestival, "HandyNotes_SummerFestival", "AceEvent-3.0")
