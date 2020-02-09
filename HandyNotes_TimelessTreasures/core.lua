local addonName, TimelessTreasures = ...
local points = TimelessTreasures.points
local L = TimelessTreasures.L

local default_icon = 133784 -- (select(10, GetAchievementInfo(8729)))

local moss       = L["Moss-Covered Chest"]
local sturdy     = L["Sturdy Chest"]
local smoldering = L["Smoldering Chest"]
local skull      = L["Skull-Covered Chest"]
local blazing    = L["Blazing Chest"]

local criteriaIndex = {
	[moss]       = 1,
	[sturdy]     = 4,
	[smoldering] = 5,
	[skull]      = 2,
	[blazing]    = 3,
}

-- our db and defaults
local db
local defaults = {
	profile = {
		completed = false,
		icon_scale = 1.0,
		icon_alpha = 1.0,
		show_moss = true,
		moss_icon = default_icon,
		sturdy_icon = default_icon,
		smoldering_icon = default_icon,
		skull_icon = default_icon,
		blazing_icon = default_icon,
		trim_icons = false,
	}
}

local function ColorGradient(a, b, r1, g1, b1, r2, g2, b2, r3, g3, b3)
	if a <= 0 or b == 0 then
		return r1, g1, b1
	elseif a >= b then
		return r3, g3, b3
	else
		local segment, relperc = math.modf((a / b) * 2)
		r1, g1, b1, r2, g2, b2 = select(segment * 3 + 1, r1, g1, b1, r2, g2, b2, r3, g3, b3)
		return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
	end
end

local trimmedIcons = {}
local function TrimIcon(icon)
	if not trimmedIcons[icon] then
		trimmedIcons[icon] = {
			icon = icon,
            tCoordLeft = 0.1,
            tCoordRight = 0.9,
            tCoordTop = 0.1,
            tCoordBottom = 0.9,
		}
	end

	return trimmedIcons[icon]
end

-- HandyNotes handlers
function TimelessTreasures:OnEnter(uiMapID, coord)
	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local info = points[uiMapID][coord]

	GameTooltip:SetText(info.type)

	if info.note then
		GameTooltip:AddLine(format("|cff00FF00%s|r %s", NOTE_COLON, info.note), 1, 1, 1, true)
	end

	local _, _, _, quantity, requiredQuantity = GetAchievementCriteriaInfo(8729, criteriaIndex[info.type])
	local r, g, b = ColorGradient(quantity, requiredQuantity, 1, 0, 0, 1, 1, 0, 0, 1, 0)
	GameTooltip:AddLine(format("|cff00FF00%s:|r %d/%d", L["Completed"], quantity, requiredQuantity), r, g, b)
	GameTooltip:Show()
end

function TimelessTreasures:OnLeave()
	GameTooltip:Hide()
end

local function CreateWaypoint(button, uiMapID, coord)
	local x, y = HandyNotes:getXY(coord);

	TomTom:AddWaypoint(uiMapID, x, y, {title = points[uiMapID][coord].type})
end

do
	-- context menu generator
	local info = {}
	local currentZone, currentCoord

	local function Close() CloseDropDownMenus() end

	local function GenerateMenu(button, level)
		if not level then return end

		table.wipe(info)

		if level == 1 then
			-- create the title of the menu
			info.isTitle = 1
			info.text = L.ADDON_NAME
			info.notCheckable = 1

			UIDropDownMenu_AddButton(info, level)

			if TomTom then
				-- waypoint menu item
				info.disabled = nil
				info.isTitle = nil
				info.notCheckable = nil
				info.text = L["Create waypoint"]
				info.icon = nil
				info.func = CreateWaypoint
				info.arg1 = currentZone
				info.arg2 = currentCoord

				UIDropDownMenu_AddButton(info, level)
			end

			-- close menu item
			info.disabled = nil
			info.isTitle = nil
			info.notCheckable = 1
			info.text = CLOSE
			info.icon = nil
			info.func = Close
			info.arg1 = nil
			info.arg2 = nil
			UIDropDownMenu_AddButton(info, level)
		end
	end

	local dropdown = CreateFrame("Frame")
	dropdown.displayMode = "MENU"
	dropdown.initialize = GenerateMenu

	function TimelessTreasures:OnClick(button, down, uiMapID, coord)
		if button == "RightButton" and not down then
			currentZone = uiMapID
			currentCoord = coord

			ToggleDropDownMenu(1, nil, dropdown, self, 0, 0)
		end
	end
end

local function iter(zone, prestate)
	if not zone then return end

	local coords, info = next(zone, prestate)

	while coords do
		if info and (db.completed or
			((info.type ~= moss or (db.show_moss and info.type == moss)) and not IsQuestFlaggedCompleted(info.quest))
		) then
			local icon = info.icon or default_icon
			return
				coords,
				nil,
				db.trim_icons and TrimIcon(icon) or icon,
				db.icon_scale,
				db.icon_alpha
		end

		coords, info = next(zone, coords)
	end
end

function TimelessTreasures:GetNodes2(uiMapID)
	return iter, points[uiMapID]
end


-- config
local options = {
	type = "group",
	name = L.NAME,
	desc = L["Timeless Treasures locations."],
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		TimelessTreasures:Refresh()
	end,
	args = {
		desc_1 = {
			type = "description",
			name = L["These settings control the visibility of the icons."],
			fontSize = "medium",
			order = 1,
		},
		completed = {
			type = "toggle",
			name = L["Show completed"],
			desc = L["Show icons for treasures you have already got."],
			arg = "completed",
			width = "full",
			order = 2,
		},
		show_moss = {
			type = "toggle",
			name = L["Show Moss-Covered Chests"],
			desc = L["Show not completed Moss-Covered Chests"],
			arg = "show_moss",
			width = "full",
			order = 3,
		},
		desc_2 = {
			type = "description",
			name = L["These settings control the look of the icons."],
			fontSize = "medium",
			order = 14,
		},
		trim_icons = {
			type = "toggle",
			name = L["Remove Icon Border"],
			width = "full",
			order = 15,
		},
		icon_scale = {
			type = "range",
			name = L["Icon Scale"],
			desc = L["Change the size of the icons."],
			min = 0.3, max = 2, step = 0.1,
			arg = "icon_scale",
			order = 16,
		},
		icon_alpha = {
			type = "range",
			name = L["Icon Alpha"],
			desc = L["Change the transparency of the icons."],
			min = 0, max = 1, step = 0.1,
			arg = "icon_alpha",
			order = 16,
		},
		moss_icon = {
			type = "input",
			name = moss,
			desc = L["Change Icon"],
			set = function(info, value)
				db.moss_icon = value
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			get = function(info) return db.moss_icon end,
			order = 20,
		},
		moss_icon_reset = {
			type = "execute",
			name = RESET,
			desc = moss,
			func = function()
				db.moss_icon = default_icon
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			order = 21,
		},
		sturdy_icon = {
			type = "input",
			name = sturdy,
			desc = L["Change Icon"],
			set = function(info, value)
				db.sturdy_icon = value
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			get = function(info) return db.sturdy_icon end,
			order = 22,
		},
		sturdy_icon_reset = {
			type = "execute",
			name = RESET,
			desc = smoldering,
			func = function()
				db.sturdy_icon = default_icon
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			order = 23,
		},
		smoldering_icon = {
			type = "input",
			name = smoldering,
			desc = L["Change Icon"],
			set = function(info, value)
				db.smoldering_icon = value
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			get = function(info) return db.smoldering_icon end,
			order = 24,
		},
		smoldering_icon_reset = {
			type = "execute",
			name = RESET,
			desc = smoldering,
			func = function()
				db.smoldering_icon = default_icon
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			order = 25,
		},
		skull_icon = {
			type = "input",
			name = skull,
			desc = L["Change Icon"],
			set = function(info, value)
				db.skull_icon = value
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			get = function(info) return db.skull_icon end,
			order = 26,
		},
		skull_icon_reset = {
			type = "execute",
			name = RESET,
			desc = skull,
			func = function()
				db.skull_icon = default_icon
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			order = 27,
		},
		blazing_icon = {
			type = "input",
			name = blazing,
			desc = L["Change Icon"],
			set = function(info, value)
				db.blazing_icon = value
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			get = function(info) return db.blazing_icon end,
			order = 28,
		},
		blazing_icon_reset = {
			type = "execute",
			name = RESET,
			desc = blazing,
			func = function()
				db.blazing_icon = default_icon
				TimelessTreasures:SetIcons()
				TimelessTreasures:Refresh()
			end,
			order = 29,
		},
	},
}

function TimelessTreasures:SetIcons()
	for _, data in next, points do
		for _, info in next, data do
			local type = info.type
			if type == moss then
				info.icon = db.moss_icon
			elseif type == sturdy then
				info.icon = db.sturdy_icon
			elseif type == smoldering then
				info.icon = db.smoldering_icon
			elseif type == skull then
				info.icon = db.skull_icon
			else
				info.icon = db.blazing_icon
			end
		end
	end
end


-- initialise
function TimelessTreasures:OnEnable()
	HandyNotes:RegisterPluginDB('TimelessTreasures', self, options)
	self:RegisterEvent('QUEST_LOG_UPDATE', 'Refresh')

	db = LibStub('AceDB-3.0'):New('HandyNotes_TimelessTreasuresDB', defaults, true).profile

	self:SetIcons()
end

function TimelessTreasures:Refresh(...)
	self:SendMessage('HandyNotes_NotifyUpdate', 'TimelessTreasures', ...)
end

-- activate
TimelessTreasures = LibStub('AceAddon-3.0'):NewAddon(TimelessTreasures, addonName, 'AceEvent-3.0')
