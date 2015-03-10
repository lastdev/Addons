
------------------------------------------
--  This addon was heavily inspired by  --
--    HandyNotes_Lorewalkers            --
--    HandyNotes_LostAndFound           --
--  by Kemayo                           --
------------------------------------------


-- declaration
local _, LunarFestival = ...
LunarFestival.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }


-- upvalues
local _G = getfenv(0)

local C_Timer_NewTicker = _G.C_Timer.NewTicker
local CalendarGetDate = _G.CalendarGetDate
local CalendarGetDayEvent = _G.CalendarGetDayEvent
local CalendarGetMonth = _G.CalendarGetMonth
local CalendarGetNumDayEvents = _G.CalendarGetNumDayEvents
local CalendarSetAbsMonth = _G.CalendarSetAbsMonth
local CloseDropDownMenus = _G.CloseDropDownMenus
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = _G.GetAchievementCriteriaInfo
local GetGameTime = _G.GetGameTime
local GetQuestsCompleted = _G.GetQuestsCompleted
local gsub = _G.string.gsub
local LibStub = _G.LibStub
local next = _G.next
local pairs = _G.pairs
local ToggleDropDownMenu = _G.ToggleDropDownMenu
local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip

local Astrolabe = DongleStub("Astrolabe-1.0")
local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local completedQuests = {}
local points = LunarFestival.points


-- plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	mapFile = gsub(mapFile, "_terrain%d+$", "")

	local point = points[mapFile] and points[mapFile][coord]

	if point == "Zidormi" then
		return point
	else
		return GetAchievementCriteriaInfo(point[2], point[3])
	end
end

function LunarFestival:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local nameOfElder = infoFromCoord(mapFile, coord)

	tooltip:SetText(nameOfElder)

	if nameOfElder == "Zidormi" then
		tooltip:AddLine("Talk to the Time Keeper to change the zone's phase if you can't find the Elder.", 1, 1, 1)
	end

	tooltip:Show()
end

function LunarFestival:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local function createWaypoint(_, mapFile, coord)
	local x, y = HandyNotes:getXY(coord)
	local m = HandyNotes:GetMapFiletoMapID(mapFile)

	local nameOfElder = infoFromCoord(mapFile, coord)

	TomTom:AddMFWaypoint(m, nil, x, y, { title = nameOfElder })
end

do
	-- context menu generator
	local info = {}
	local currentZone, currentCoord, nameOfElder

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
			info.text = nameOfElder
			info.notCheckable = 1

			UIDropDownMenu_AddButton(info, level)

			if TomTom then
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

	local dropdown = CreateFrame("Frame", "HandyNotes_LunarFestivalDropdownMenu")
	dropdown.displayMode = "MENU"
	dropdown.initialize = generateMenu

	function LunarFestival:OnClick(button, down, mapFile, coord)
		if button == "RightButton" and not down then
			currentZone = mapFile
			currentCoord = coord

			nameOfElder = infoFromCoord(mapFile, coord)

			ToggleDropDownMenu(1, nil, dropdown, self, 0, 0)
		end
	end
end

do
	local continentMapFile = {
		["Kalimdor"]              = {__index = Astrolabe.ContinentList[1]},
		["Azeroth"]               = {__index = Astrolabe.ContinentList[2]}, -- Eastern Kingdoms
		["Expansion01"]           = {__index = Astrolabe.ContinentList[3]}, -- Outland
		["Northrend"]             = {__index = Astrolabe.ContinentList[4]},
		["TheMaelstromContinent"] = {__index = Astrolabe.ContinentList[5]},
		["Vashjir"]               = {[0] = 613, 614, 615, 610},
		["Pandaria"]              = {__index = Astrolabe.ContinentList[6]},
		["Draenor"]               = {__index = Astrolabe.ContinentList[7]},
	}

	for k, v in pairs(continentMapFile) do
		setmetatable(v, v)
	end

	-- custom iterator we use to iterate over every node in a given zone
	local function iter(t, prestate)
		if not LunarFestival.isEnabled then return nil end
		if not t then return nil end

		local state, value = next(t, prestate)

		while state do -- have we reached the end of this zone?
			if value == "Zidormi" then
				return state, nil, "interface\\icons\\spell_holy_borrowedtime", db.icon_scale, db.icon_alpha
			elseif (db.completed or not completedQuests[value[1]]) then
				return state, nil, "interface\\icons\\inv_misc_elvencoins", db.icon_scale, db.icon_alpha
			end

			state, value = next(t, state) -- get next data
		end

		return nil, nil, nil, nil
	end

	local function iterCont(t, prestate)
		if not LunarFestival.isEnabled then return nil end
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
					elseif (db.completed or not completedQuests[value[1]]) then
						return state, mapFile, "interface\\icons\\inv_misc_elvencoins", db.icon_scale, db.icon_alpha
					end

					state, value = next(data, state) -- get next data
				end
			end

			-- get next zone
			zone = zone + 1
			t.Z = zone
			mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
			prestate = nil
		end
	end

	function LunarFestival:GetNodes(mapFile)
		local C = continentMapFile[mapFile] -- is this a continent?

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
	name = "Lunar Festival",
	desc = "Lunar Festival elder NPC locations.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		LunarFestival:Refresh()
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon.",
			type = "description",
			order = 1,
		},
		completed = {
			name = "Show completed",
			desc = "Show icons for elder NPCs you have already visited.",
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
	local _, month, day, year = CalendarGetDate()
	local curMonth, curYear = CalendarGetMonth()
	local monthOffset = -12 * (curYear - year) + month - curMonth
	local numEvents = CalendarGetNumDayEvents(monthOffset, day)

	for i=1, numEvents do
		local _, eventHour, _, eventType, state, _, texture = CalendarGetDayEvent(monthOffset, day, i)

		if texture == "Calendar_LunarFestival" then
			if state == "ONGOING" then
				setEnabled = true
			else
				local hour = GetGameTime()

				if state == "END" and hour <= eventHour or state == "START" and hour >= eventHour then
					setEnabled = true
				else
					setEnabled = false
				end
			end
		end
	end

	if setEnabled and not LunarFestival.isEnabled then
		LunarFestival.isEnabled = true
		LunarFestival:Refresh()
		LunarFestival:RegisterEvent("QUEST_TURNED_IN", "Refresh")

		HandyNotes:Print("The Lunar Festival has begun!  Locations of Elder NPCs are now marked on your map.")
	elseif not setEnabled and LunarFestival.isEnabled then
		LunarFestival.isEnabled = false
		LunarFestival:Refresh()
		LunarFestival:UnregisterAllEvents()

		HandyNotes:Print("The Lunar Festival has ended.  See you next year!")
	end
end


-- initialise
function LunarFestival:OnEnable()
	self.isEnabled = false

	local _, month, _, year = CalendarGetDate()
	CalendarSetAbsMonth(month, year)

	C_Timer_NewTicker(15, CheckEventActive)
	HandyNotes:RegisterPluginDB("LunarFestival", self, options)

	completedQuests = GetQuestsCompleted(completedQuests)
	db = LibStub("AceDB-3.0"):New("HandyNotes_LunarFestivalDB", defaults, "Default").profile
end

function LunarFestival:Refresh(_, questID)
	if questID then completedQuests[questID] = true end
	self:SendMessage("HandyNotes_NotifyUpdate", "LunarFestival")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(LunarFestival, "HandyNotes_LunarFestival", "AceEvent-3.0")
