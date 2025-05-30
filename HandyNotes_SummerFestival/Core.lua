
------------------------------------------
--  This addon was heavily inspired by  --
--    HandyNotes_Lorewalkers            --
--    HandyNotes_LostAndFound           --
--  by Kemayo                           --
------------------------------------------


-- declaration
local addOnName, SummerFestival = ...
SummerFestival.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }

local isClassic = WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC

local continents = isClassic and {
	[113]  = true, -- Northrend
	[203]  = true, -- Vashj'ir
	[224]  = true, -- Stranglethorn Vale
	[947]  = true, -- Azeroth
	[1414] = true, -- Kalimdor
	[1415] = true, -- Eastern Kingdoms
	[1945] = true, -- Outland
} or {
	[12]   = true, -- Kalimdor
	[13]   = true, -- Eastern Kingdoms
	[101]  = true, -- Outland
	[113]  = true, -- Northrend
	[203]  = true, -- Vashj'ir
	[224]  = true, -- Stranglethorn Vale
	[424]  = true, -- Pandaria
	[572]  = true, -- Draenor
	[619]  = true, -- Broken Isles
	[875]  = true, -- Zandalar
	[876]  = true, -- Kul Tiras
	[947]  = true, -- Azeroth
	[1978] = true, -- Dragon Isles
	[2025] = true, -- Thaldraszus
}

local notes = {
	-- Arathi
	["11732"] = "Speak to Zidormi at the south of the zone to gain access to this bonfire.",
	["11764"] = "Speak to Zidormi at the south of the zone to gain access to this bonfire.",
	["11804"] = "Speak to Zidormi at the south of the zone to gain access to this bonfire.",
	["11840"] = "Speak to Zidormi at the south of the zone to gain access to this bonfire.",

	-- Blasted Lands
	["11737"] = "Speak to Zidormi at the north of the zone to gain access to this bonfire.",
	["11808"] = "Speak to Zidormi at the north of the zone to gain access to this bonfire.",
	["28917"] = "Speak to Zidormi at the north of the zone to gain access to this bonfire.",
	["28930"] = "Speak to Zidormi at the north of the zone to gain access to this bonfire.",

	-- Darkshore
	["11740"] = "Speak to Zidormi in Darkshore to gain access to Lor'danel.",
	["11811"] = "Speak to Zidormi in Darkshore to gain access to Lor'danel.",

	-- Silithus
	["11760"] = "Speak to Zidormi at the north-east of the zone to gain access to this bonfire.",
	["11800"] = "Speak to Zidormi at the north-east of the zone to gain access to this bonfire.",
	["11831"] = "Speak to Zidormi at the north-east of the zone to gain access to this bonfire.",
	["11836"] = "Speak to Zidormi at the north-east of the zone to gain access to this bonfire.",

	-- Teldrassil
	["9332"]  = "Speak to Zidormi in Darkshore to gain access to Darnassus.",
	["11753"] = "Speak to Zidormi in Darkshore to gain access to Teldrassil.",
	["11824"] = "Speak to Zidormi in Darkshore to gain access to Teldrassil.",

	-- Tirisfal Glades
	["9326"]  = "Speak to Zidormi near Balnir Farmstead to gain access to The Undercity.\nAlliance players may need to complete the Return To Lordaeron storyline in Oribos in order for Zidormi to appear.",
	["11786"] = "Speak to Zidormi near Balnir Farmstead to gain access to Brill.\nAlliance players may need to complete the Return To Lordaeron storyline in Oribos in order for Zidormi to appear.",
	["11862"] = "Speak to Zidormi near Balnir Farmstead to gain access to Brill.\nAlliance players may need to complete the Return To Lordaeron storyline in Oribos in order for Zidormi to appear.",

	-- Vashj'ir
	["29031"] = "In an underwater cave. Swim downwards towards the bubbles or use the seahorse taxi service.",

	-- Uldum
	["28948"] = "Speak to Zidormi in Ramkahen to gain access to this bonfire.",
	["28950"] = "Speak to Zidormi in Ramkahen to gain access to this bonfire.",
}


-- upvalues
local C_Calendar = _G.C_Calendar
local C_DateAndTime = _G.C_DateAndTime
local C_Map = _G.C_Map
local GetAllCompletedQuestIDs = _G.C_QuestLog.GetAllCompletedQuestIDs
local GetQuestsCompleted = _G.GetQuestsCompleted
local C_Timer_After = _G.C_Timer.After
local GameTooltip = _G.GameTooltip
local IsControlKeyDown = _G.IsControlKeyDown
local UIParent = _G.UIParent

local LibStub = _G.LibStub
local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local completedQuests = {}
local points = SummerFestival.points


-- plugin handler for HandyNotes
function SummerFestival:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local point = points[mapFile] and points[mapFile][coord]
	local text
	local questID, mode = point:match("(%d+):(.*)")

	if mode == "H" then text = "Honor the Flame"
	elseif mode == "D" then text = "Desecrate this Fire!"
	elseif mode == "C" then text = "Steal the City's Flame" end

	GameTooltip:SetText(text)

	if notes[questID] then
		GameTooltip:AddLine(notes[questID])
		GameTooltip:AddLine(" ")
	end

	if TomTom then
		GameTooltip:AddLine("Right-click to set a waypoint.", 1, 1, 1)
		GameTooltip:AddLine("Control-Right-click to set waypoints to every bonfire.", 1, 1, 1)
	end

	GameTooltip:Show()
end

function SummerFestival:OnLeave()
	GameTooltip:Hide()
end


local function createWaypoint(mapFile, coord)
	local x, y = HandyNotes:getXY(coord)
	local point = points[mapFile] and points[mapFile][coord]
	local _, mode = point:match("(%d+):(.*)")
	local text

	if mode == "H" then text = "Honor the Flame"
	elseif mode == "D" then text = "Desecrate this Fire!"
	elseif mode == "C" then text = "Steal the City's Flame" end

	TomTom:AddWaypoint(mapFile, x, y, { title = text, from = addOnName, persistent = false, minimap = true, world = true })
end

local function createAllWaypoints()
	for mapFile, coords in next, points do
		if not continents[mapFile] then
			for coord, value in next, coords do
				local questID = value:match("(%d+):(.*)")

				if coord and (db.completed or not completedQuests[tonumber(questID)]) then
					createWaypoint(mapFile, coord)
				end
			end
		end
	end

	TomTom:SetClosestWaypoint()
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
	local function iterator(t, prev)
		if not SummerFestival.isEnabled then return end
		if not t then return end

		local coord, value = next(t, prev)
		while coord do
			local questID, mode = value:match("(%d+):(.*)")
			local icon

			if mode == "H" then -- honour the flame
				icon = "interface\\icons\\inv_summerfest_firespirit"
			elseif mode == "D" then -- desecrate this fire
				icon = "interface\\icons\\spell_fire_masterofelements"
			elseif mode == "C" then -- stealing the enemy's flame
				icon = "interface\\icons\\spell_fire_flameshock"
			end

			if value and (db.completed or not completedQuests[tonumber(questID)]) then
				return coord, nil, icon, db.icon_scale, db.icon_alpha
			end

			coord, value = next(t, coord)
		end
	end

	function SummerFestival:GetNodes2(mapID)
		return iterator, points[mapID]
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
	local calendar = C_DateAndTime.GetCurrentCalendarTime()
	local month, day, year = calendar.month, calendar.monthDay, calendar.year
	local hour, minute = calendar.hour, calendar.minute

	local monthInfo = C_Calendar.GetMonthInfo()
	local curMonth, curYear = monthInfo.month, monthInfo.year

	local monthOffset = -12 * (curYear - year) + month - curMonth
	local numEvents = C_Calendar.GetNumDayEvents(monthOffset, day)

	for i=1, numEvents do
		local event = C_Calendar.GetDayEvent(monthOffset, day, i)

		if event.iconTexture == 235472 or event.iconTexture == 235473 or event.iconTexture == 235474 then
			setEnabled = event.sequenceType == "ONGOING" -- or event.sequenceType == "INFO"

			if event.sequenceType == "START" then
				setEnabled = hour >= event.startTime.hour and (hour > event.startTime.hour or minute >= event.startTime.minute)
			elseif event.sequenceType == "END" then
				setEnabled = hour <= event.endTime.hour and (hour < event.endTime.hour or minute <= event.endTime.minute)
			end
		end
	end

	if setEnabled and not SummerFestival.isEnabled then
		if isClassic then
			completedQuests = GetQuestsCompleted(completedQuests)
		else
			for _, id in ipairs(GetAllCompletedQuestIDs()) do
				completedQuests[id] = true
			end
		end

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

local function RepeatingCheck()
	CheckEventActive()
	C_Timer_After(60, RepeatingCheck)
end


-- initialise
function SummerFestival:OnEnable()
	self.isEnabled = false

	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then
		HandyNotes:Print("Your installed copy of HandyNotes is out of date and the Summer Festival plug-in will not work correctly.  Please update HandyNotes to version 1.5.0 or newer.")
		return
	end

	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		if not children then HandyNotes:Print("Map ID " .. continentMapID .. " has invalid data.  Please inform the author of HandyNotes_SummerFestival.  (WoW Project ID " .. WOW_PROJECT_ID .. ")")
		else
			for _, map in next, children do
				local coords = points[map.mapID]
				if coords then
					for coord, criteria in next, coords do
						local mx, my = HandyNotes:getXY(coord)
						local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID, false)
						if cx and cy then
							points[continentMapID] = points[continentMapID] or {}
							points[continentMapID][HandyNotes:getCoord(cx, cy)] = criteria
						end
					end
				end
			end
		end
	end

	local calendar = C_DateAndTime.GetCurrentCalendarTime()
	C_Calendar.SetAbsMonth(calendar.month, calendar.year)
	CheckEventActive()

	HandyNotes:RegisterPluginDB("SummerFestival", self, options)
	db = LibStub("AceDB-3.0"):New("HandyNotes_SummerFestivalDB", defaults, "Default").profile

	self:RegisterEvent("CALENDAR_UPDATE_EVENT", CheckEventActive)
	self:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST", CheckEventActive)
	self:RegisterEvent("ZONE_CHANGED", CheckEventActive)

	C_Timer_After(60, RepeatingCheck)
end

function SummerFestival:Refresh(_, questID)
	if questID then completedQuests[questID] = true end
	self:SendMessage("HandyNotes_NotifyUpdate", "SummerFestival")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(SummerFestival, addOnName, "AceEvent-3.0")
