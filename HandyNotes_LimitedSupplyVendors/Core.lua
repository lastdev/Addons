-- declaration
local _, LimitedSupplyVendors = ...
LimitedSupplyVendors.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }

local continents = {
	[12]  = true,  -- Kalimdor
	[13]  = true,  -- Eastern Kingdoms
	[101] = true,  -- Outland
	[113] = true,  -- Northrend
	[424] = true,  -- Pandaria
	[572] = true,  -- Draenor
	[619] = true,  -- Broken Isles
	[875] = true,  -- Zandalar
	[876] = true,  -- Kul Tiras
	[1645] = true, -- Torghast
	[1647] = true, -- The Shadowlands
	[2046] = true, -- Zereth Mortis
	[2057] = true, -- The Dragon Isles
}


-- upvalues
local _G = getfenv(0)

local C_Timer_NewTicker = _G.C_Timer.NewTicker
local C_Calendar = _G.C_Calendar
local GameTooltip = _G.GameTooltip
local GetFactionInfoByID = _G.GetFactionInfoByID
local GetGameTime = _G.GetGameTime
local gsub = _G.string.gsub
local IsControlKeyDown = _G.IsControlKeyDown
local IsShiftKeyDown = _G.IsShiftKeyDown
local LibStub = _G.LibStub
local next = _G.next
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local points = LimitedSupplyVendors.points


-- plugin handler for HandyNotes
function LimitedSupplyVendors:OnEnter(mapFile, coord)
	local point = points[mapFile] and points[mapFile][coord]
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	

	tooltip:ClearLines()
	
	if points[mapFile][coord] then
		tooltip:AddLine(points[mapFile][coord].name .. "\n" .. points[mapFile][coord].info )
		-------------------

		--loop items and prices here.
		--tooltip:AddLine(points[mapFile][coord].name .. "\n")
		--for k,v in pairs(points[mapFile][coord].items) do 
		--	local name, link , quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(v)
		--	tooltip:AddLine(link .. "\r")
		--end
		
		
		
	end

	if TomTom then
		tooltip:AddLine("\r\nRight-click to set a waypoint.", 1, 1, 1)
		tooltip:AddLine("Control-Right-click to set waypoints to every limited supply vendor recipe.", 1, 1, 1)
	end

	-- Being Reworked to work better.
	--tooltip:AddLine("Middle-click to link recipes the NPC sells to chat.", 1, 1, 1)


	tooltip:Show()

end


function LimitedSupplyVendors:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end


local function createWaypoint(mapID, coord)
	local x, y = HandyNotes:getXY(coord)
	local point = points[mapID] and points[mapID][coord]
	TomTom:AddWaypoint(mapID, x, y, { title = "Limited Supply Vendors \r\n[" .. points[mapID][coord].name .. "]\r\n" .. points[mapID][coord].info  , persistent = nil, minimap = true, world = true })
end

local function createAllWaypoints()
	for mapID, coords in next, points do
		for coord, questID in next, coords do
		
			--Utilize for hiding icons from vendors you have purchased from this session.
			--if coord and (db.completed or not completedQuests[questID]) then
			if coord then
				createWaypoint(mapID, coord)
			end
		end
	end
	TomTom:SetClosestWaypoint()
end

function LimitedSupplyVendors:OnClick(button, down, mapFile, coord)
	if TomTom and button == "RightButton" and not down then
		if IsControlKeyDown() then
			createAllWaypoints()
		else	
			createWaypoint(mapFile, coord)
		end

	elseif TomTom and button == "MiddleButton" and not down then
		--Wont display when a green waypoint is on the item.
		--Wont display when first clicked because null?
		
		print("This NPC Sells")
		print("--------------")
		local point = points[mapFile] and points[mapFile][coord]
		if not point then return end
		if coord == points[mapFile][coord].coords then
			for k,v in pairs(points[mapFile][coord].items) do 
				local name, link , quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(v)
				print(link)
			end
		end
		print("--------------")
		
	end
end



do
	-- custom iterator we use to iterate over every node in a given zone
	local function iterator(t, prev)
		if not LimitedSupplyVendors.isEnabled then return end
		if not t then return end
		local coord, v = next(t, prev)
		while coord do
			--if v and (db.completed or not completedQuests[v]) then -- Quest Check?
			if v then
				return coord, nil, v.icon , db.icon_scale, db.icon_alpha
			end
			coord, v = next(t, coord)
		end
	end

	function LimitedSupplyVendors:GetNodes2(mapID, minimap)
		return iterator, points[mapID]
	end
end




-- config
local options = {
	type = "group",
	name = "Limited Supply Vendors",
	desc = "Limited Supply Vendor Recipes and Locations.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		LimitedSupplyVendors:Refresh()
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon.",
			type = "description",
			order = 1,
		},
		--completed = {
		--	name = "Show completed",
		--	desc = "Show icons for candy buckets you have already visited.",
		--	type = "toggle",
		--	width = "full",
		--	arg = "completed",
		--	order = 2,
		--},
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
--local setEnabled = true
LimitedSupplyVendors.isEnabled = true
--completedQuests = GetQuestsCompleted(completedQuests)

--Used for checking on a certain calendar event
--[[
	local function CheckEventActive()
	local date = C_Calendar.GetDate()
	
	local month, day, year = date.month, date.monthDay, date.year

	local monthInfo = C_Calendar.GetMonthInfo()
	local curMonth, curYear = monthInfo.month, monthInfo.year

	local monthOffset = -12 * (curYear - year) + month - curMonth
	local numEvents = C_Calendar.GetNumDayEvents(monthOffset, day)

	for i=1, numEvents do
		local event = C_Calendar.GetDayEvent(monthOffset, day, i)

		if event.iconTexture == 235460 or event.iconTexture == 235461 or event.iconTexture == 235462 then
			if event.sequenceType == "ONGOING" then
				setEnabled = true
			else
				local hour = GetGameTime()

				if event.sequenceType == "END" and hour <= event.endTime.hour or event.sequenceType == "START" and hour >= event.startTime.hour then
					setEnabled = true
				else
					setEnabled = true
				end
			end
		end
	end


	if setEnabled and not LimitedSupplyVendors.isEnabled then
		--completedQuests = GetQuestsCompleted(completedQuests)

		LimitedSupplyVendors.isEnabled = true
		LimitedSupplyVendors:Refresh()
		LimitedSupplyVendors:RegisterEvent("QUEST_TURNED_IN", "Refresh")

		HandyNotes:Print("The Hallow's End celebrations have begun!  Locations of candy buckets are now marked on your map.")
	elseif not setEnabled and LimitedSupplyVendors.isEnabled then
		LimitedSupplyVendors.isEnabled = true
		LimitedSupplyVendors:Refresh()
		LimitedSupplyVendors:UnregisterAllEvents()

		HandyNotes:Print("The Hallow's End celebrations have ended.  See you next year!")
	end
	
end
]]--

-- initialise
function LimitedSupplyVendors:OnEnable()
	self.isEnabled = true

	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then
		HandyNotes:Print("Your installed copy of HandyNotes is out of date and the Limited Supply Vendors plug-in will not work correctly.  Please update HandyNotes to version 1.5.0 or newer.")
		return
	end

	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID)
		for _, map in next, children do
			local coords = points[map.mapID]
			if coords then
				for coord, criteria in next, coords do
					local mx, my = HandyNotes:getXY(coord)
					local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
					if cx and cy then
						points[continentMapID] = points[continentMapID] or {}
						points[continentMapID][HandyNotes:getCoord(cx, cy)] = criteria
					end
				end
			end
		end
	end

	--local date = C_Calendar.GetDate()
	--C_Calendar.SetAbsMonth(date.month, date.year)
	--C_Timer_NewTicker(15, CheckEventActive)
	
	HandyNotes:RegisterPluginDB("LimitedSupplyVendors", self, options)

	db = LibStub("AceDB-3.0"):New("HandyNotes_LimitedSupplyVendorsDB", defaults, "Default").profile
end

function LimitedSupplyVendors:Refresh(_, questID)
	--if questID then completedQuests[questID] = true end
	self:SendMessage("HandyNotes_NotifyUpdate", "LimitedSupplyVendors")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(LimitedSupplyVendors, "HandyNotes_LimitedSupplyVendors", "AceEvent-3.0")
