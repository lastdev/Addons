local addonName, ns = ...

local Addon = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then
	return
end

local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes", false)
local HBD = LibStub("HereBeDragons-2.0")

local Locations = ns.Locations

local function Debug(...)
	if addonName == "HandyNotes_BrewfestDev" then
		print("|cnRED_FONT_COLOR:HandyNotes_Brewfest|r:", ...)
	end
end

local Icon = { icon = 132622 }

local BarTabQuest = { questID = 76531 }

function BarTabQuest:GetName()
	if self.questName == nil then
		self.questName = C_QuestLog.GetTitleForQuestID(self.questID)
	end

	return self.questName or LFG_LIST_LOADING
end

local function GetCalendarEventByID(eventID, month, day, calendarType)
	local now = C_DateAndTime.GetCurrentCalendarTime()

	calendarType = calendarType or "HOLIDAY"

	for i = 1, C_Calendar.GetNumDayEvents(now.month - month, day) do
		local event = C_Calendar.GetDayEvent(0, day, i)
		if event.calendarType == calendarType and event.eventID == eventID then
			return event
		end
	end
end

local BrewfestEvent = {}

function BrewfestEvent:UpdateAddonOptions(options)
	local attempts = 30

	self.timer = C_Timer.NewTicker(2, function()
		local event = GetCalendarEventByID(372, 9, 25)

		Debug("Options Updating Attempt:", attempts, event)

		if event and not self.timer:IsCancelled() then
			self.timer:Cancel()

			options.name = event.title
		end

		attempts = attempts - 1
	end, attempts)
end

--- @class Brewfest_Node
--- @field x number
--- @field y number
--- @field name string
--- @field quest number
--- @field mapID number

--- @type table<number, Brewfest_Node[]> # [uiMapID] = list of Locations
Addon.nodes = {}

function Addon:OnInitialize()
	local defaults = {
		profile = {
			iconScale = 1.2,
			iconAlpha = 0.9,
			showCompleted = false,
		},
	}
	self.db = LibStub("AceDB-3.0"):New("HandyNotes_BrewfestDB", defaults, true).profile

	if C_AddOns.IsAddOnLoaded("TomTom") then
		self.isTomTomLoaded = true
	end

	local increment = CreateCounter(1)
	local options = {
		type = "group",
		name = "Brewfest", -- Localized by BrewfestEvent:UpdateAddonOptions()
		desc = "Locations of Bar Tab Barrels on Dragon Isles and Khaz Algar",
		get = function(info)
			return self.db[info[#info]]
		end,
		set = function(info, v)
			self.db[info[#info]] = v
			self:Refresh()
		end,
		args = {
			desc = {
				name = L["These settings control the look and feel of the HandyNotes icons."],
				type = "description",
				order = increment(),
			},
			iconScale = {
				type = "range",
				name = L["Icon Scale"],
				desc = L["The scale of the icons"],
				min = 0.25,
				max = 3,
				step = 0.01,
				order = increment(),
			},
			iconAlpha = {
				type = "range",
				name = L["Icon Alpha"],
				desc = L["The alpha transparency of the icons"],
				min = 0,
				max = 1,
				step = 0.01,
				order = increment(),
			},
			showCompleted = {
				type = "toggle",
				name = TRACKER_FILTER_COMPLETED_QUESTS,
				desc = TOOLTIP_TRACKER_FILTER_COMPLETED_QUESTS,
				order = increment(),
				width = "full",
			},
		},
	}
	HandyNotes:RegisterPluginDB(addonName, self, options)
	BrewfestEvent:UpdateAddonOptions(options)

	self:RegisterEvent("QUEST_TURNED_IN", function()
		C_Timer.After(1, GenerateClosure(self.Refresh, self))
	end)
end

local function iter(t, previousIndex)
	if not t then
		return nil
	end
	local index, value = next(t, previousIndex)
	while index and value do
		--- @type Brewfest_Node
		local node = value

		-- Check if quest is completed and hide option is enabled
		if not Addon.db.showCompleted and C_QuestLog.IsQuestFlaggedCompleted(node.quest) then
			return iter(t, index)
		end

		return index, nil, Icon, Addon.db.iconScale, Addon.db.iconAlpha
	end
end

function Addon:GetNodes2(uiMapId, isMinimapUpdate)
	if not self.nodes[uiMapId] then
		local mapID = uiMapId

		self.nodes[mapID] = {}
		for _, location in ipairs(Locations) do
			local x, y = HBD:TranslateZoneCoordinates(location.x / 100, location.y / 100, location.mapID, mapID)
			if x and y then
				local coord = HandyNotes:getCoord(x, y)

				self.nodes[mapID][coord] = {
					name = location.name,
					quest = location.quest,
					mapID = mapID,
					x = x,
					y = y,
				}
			end
		end
	end

	if next(self.nodes[uiMapId]) == nil then
		return function() end
	end

	return iter, self.nodes[uiMapId], nil
end

function Addon.OnClick(mapPin, button, down, mapFile, coord)
	if not down then
		return
	end

	local node = Addon.nodes[mapFile][coord]
	if not node then
		return
	end

	if IsAltKeyDown() and Addon.isTomTomLoaded then
		TomTom:AddWaypoint(mapFile, node.x, node.y, {
			title = BarTabQuest:GetName(),
			from = addonName,
			persistent = nil,
			minimap = true,
			world = true,
		})
	end
end

function Addon.OnEnter(mapPin, mapFile, coord)
	local node = Addon.nodes[mapFile][coord]
	if not node then
		return
	end

	if mapPin:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(mapPin, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(mapPin, "ANCHOR_RIGHT")
	end

	GameTooltip:SetText(BarTabQuest:GetName())

	if C_QuestLog.IsQuestFlaggedCompleted(node.quest) then
		GameTooltip:AddLine(QUEST_COMPLETE, 0, 1, 0)
	else
		GameTooltip:AddLine(AVAILABLE_QUEST, 1, 1, 1)
	end

	if Addon.isTomTomLoaded then
		GameTooltip:AddLine(" ")
		GameTooltip_AddInstructionLine(GameTooltip, "Alt+|A:NPE_LeftClick:16:16|a: " .. L["Add this location to TomTom waypoints"])
	end

	GameTooltip_AddQuestRewardsToTooltip(GameTooltip, node.quest, TOOLTIP_QUEST_REWARDS_STYLE_DEFAULT)
	GameTooltip:Show()
end

function Addon:OnLeave()
	GameTooltip:Hide()
end

function Addon:Refresh()
	HandyNotes:SendMessage("HandyNotes_NotifyUpdate", addonName)
end
