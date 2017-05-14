local addonName, TimelessTreasures = ...
TimelessTreasures.points = {}
local L = TimelessTreasures.L

local default_icon = "Interface\\ICONS\\inv_misc_coin_01" -- (select(10, GetAchievementInfo(8729)))

local moss = L["Moss-Covered Chest"]
local sturdy = L["Sturdy Chest"]
local smoldering = L["Smoldering Chest"]
local skull = L["Skull-Covered Chest"]
local blazing = L["Blazing Chest"]

local criteriaIndex = {
	[moss] = 1,
	[sturdy] = 4,
	[smoldering] = 5,
	[skull] = 2,
	[blazing] = 3,
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

local points = TimelessTreasures.points

-- http://www.wowhead.com/achievement=8729/treasure-treasure-everywhere
-- mapFiles 5th or 1st return of GetMapInfo()
-- coord 1st and 2nd return of GetPlayerMapPosition("player") times 10,000
-- 0.12345678 and 0.87654321 -> [12348765]
points["TimelessIsle"] = {
	-- Moss-Covered Chests
	[22204930] = {type = moss, quest = 33175},
	[22246808] = {type = moss, quest = 33178},
	[22423535] = {type = moss, quest = 33174},
	[24623863] = {type = moss, quest = 33200, note = L["On a treestump"]},
	[24755301] = {type = moss, quest = 33176},
	[25522721] = {type = moss, quest = 33171},
	[25664584] = {type = moss, quest = 33177},
	[26016145] = {type = moss, quest = 33199, note = L["On a treestump"]},
	[26856875] = {type = moss, quest = 33179},
	[27363909] = {type = moss, quest = 33172},
	[29683174] = {type = moss, quest = 33202},
	[30603655] = {type = moss, quest = 33173, note = L["On a treestump"]},
	[31007633] = {type = moss, quest = 33180},
	[34858422] = {type = moss, quest = 33184},
	[35367642] = {type = moss, quest = 33181},
	[36703403] = {type = moss, quest = 33170},
	[38737159] = {type = moss, quest = 33182},
	[39797953] = {type = moss, quest = 33183},
	[43568404] = {type = moss, quest = 33185},
	[44136546] = {type = moss, quest = 33198, note = L["On a treestump"]},
	[46764678] = {type = moss, quest = 33187},
	[46955369] = {type = moss, quest = 33186},
	[49716572] = {type = moss, quest = 33195},
	[51174568] = {type = moss, quest = 33188},
	[52756286] = {type = moss, quest = 33197},
	[53097077] = {type = moss, quest = 33196},
	[55524434] = {type = moss, quest = 33189},
	[58015070] = {type = moss, quest = 33190},
	[59913132] = {type = moss, quest = 33201},
	[60176603] = {type = moss, quest = 33194},
	[61648849] = {type = moss, quest = 33227, note = L["In the shipwreck of Cpt. Zvezdan"]},
	[63815915] = {type = moss, quest = 33192},
	[64917559] = {type = moss, quest = 33193},
	[65634783] = {type = moss, quest = 33191},
	-- Sturdy Chests
	[26676495] = {type = sturdy, quest = 33205, note = L["On the top of the cliff. Use the Highwind Albatross"]},
	[28193521] = {type = sturdy, quest = 33204, note = L["On the top of the cliff. Use the Highwind Albatross"]},
	[59254946] = {type = sturdy, quest = 33207, note = L["Inside the Mysterious Den. Use one of objects from Legends of the Past"]},
	[64687047] = {type = sturdy, quest = 33206},
	-- Smoldering Chests
	[53987805] = {type = smoldering, quest = 33209},
	[69573289] = {type = smoldering, quest = 33208},
	-- Skull-Covered Chest
	[46703230] = {type = skull, quest = 33203, note = L["Inside Cavern of Lost Spirits (entrance at 43.2, 41.3)"]},
	-- Blazing Chest
	[47262682] = {type = blazing, quest = 33210},
}

points["CavernofLostSpirits"] = {
	-- Skull-Covered Chest
	[62903480] = {type = skull, quest = 33203},
}

local ColorGradient = function(a, b, r1, g1, b1, r2, g2, b2, r3, g3, b3)
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
local TrimIcon = function(icon)
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
function TimelessTreasures:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	local info = points[mapFile][coord]
	tooltip:SetText(info.type)
	if info.note then
		tooltip:AddLine(format("|cff00FF00%s|r %s", NOTE_COLON, info.note), 1, 1, 1, true)
	end
	local quantity, requiredQuantity = select(4, GetAchievementCriteriaInfo(8729, criteriaIndex[info.type]))
	local r, g, b = ColorGradient(quantity, requiredQuantity, 1, 0, 0, 1, 1, 0, 0, 1, 0)
	tooltip:AddLine(format("|cff00FF00%s:|r %d/%d", L["Completed"], quantity, requiredQuantity), r, g, b)
	tooltip:Show()
end

function TimelessTreasures:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local function CreateWaypoint(button, mapFile, coord)
	local x = floor(coord / 10000) / 10000 -- 0.xxx
	local y = (coord % 10000) / 10000

	-- TomTom's AddZWaypoint is currently buggy as it relies on Astrolabe's GetMapID which has wrong returns
	-- HandyNotes returns the correct mapID but it does not have floor information
	-- also HandyNotes does not return anything when using GetCZ("CavernofLostSpirits")
	TomTom:AddMFWaypoint(HandyNotes:GetMapFiletoMapID(mapFile), nil, x, y, {title = points[mapFile][coord].type})
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

	function TimelessTreasures:OnClick(button, down, mapFile, coord)
		if button == "RightButton" and not down then
			currentZone = mapFile
			currentCoord = coord

			ToggleDropDownMenu(1, nil, dropdown, self, 0, 0)
		end
	end
end

-- custom iterator we use to iterate over every node in a given zone
local function iter(t, prestate)
	if not t then return nil end

	local state, value = next(t, prestate)

	while state do -- have we reached the end of this zone?
		if value and (db.completed
			or ((value.type ~= moss or (value.type == moss and db.show_moss)) and not IsQuestFlaggedCompleted(value.quest))) then
			return state, nil, db.trim_icons and TrimIcon(value.icon or default_icon) or (value.icon or default_icon), db.icon_scale, db.icon_alpha
		end

		state, value = next(t, state) -- get next data
	end

	return nil, nil, nil, nil
end

function TimelessTreasures:GetNodes(mapFile)
	mapFile = gsub(mapFile, "_terrain%d+$", "")
	return iter, points[mapFile], nil
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
	for _, info in pairs(points["TimelessIsle"]) do
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
	points["CavernofLostSpirits"][62903480].icon = db.skull_icon
end


-- initialise
function TimelessTreasures:OnEnable()
	HandyNotes:RegisterPluginDB("TimelessTreasures", self, options)
	self:RegisterEvent("QUEST_LOG_UPDATE", "Refresh")

	db = LibStub("AceDB-3.0"):New("HandyNotes_TimelessTreasuresDB", defaults, true).profile

	self:SetIcons()
end

function TimelessTreasures:Refresh(...)
	self:SendMessage("HandyNotes_NotifyUpdate", "TimelessTreasures", ...)
end

-- activate
TimelessTreasures = LibStub("AceAddon-3.0"):NewAddon(TimelessTreasures, addonName, "AceEvent-3.0")
