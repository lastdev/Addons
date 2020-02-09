
------------------------------------------
--  This addon was heavily inspired by  --
--    HandyNotes_SummerFestival         --
--  by Ethan Centaurai                  --
------------------------------------------


-- declaration
local _, PetDailies = ...
PetDailies.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }
local DEBUG = false

-- upvalues
local _G = getfenv(0)
--quest #, optional achievement progress index, text, icon
local point_format = "(%d+)\.([0-9]+):(.+):(.+):(.+):(.*)";

local GameTooltip = _G.GameTooltip
local GetQuestLogIndexByID = _G.GetQuestLogIndexByID
local GetQuestLogLeaderBoard = _G.GetQuestLogLeaderBoard
local IsQuestFlaggedCompleted = _G.IsQuestFlaggedCompleted
local GetAchievementCriteriaInfo = _G.GetAchievementCriteriaInfo
local GetAchievementInfo = _G.GetAchievementInfo
--local GetGameTime = _G.GetGameTime
--local GetQuestsCompleted = _G.GetQuestsCompleted
local gsub = _G.string.gsub
local IsControlKeyDown = _G.IsControlKeyDown
local LibStub = _G.LibStub
local next = _G.next
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local points = PetDailies.points
local ADVENTURE = 9069
local ARGUS = 12088
local FAMILY = 12100
local FAMILYALL = {12089,12091,12092,12093,12094,12095,12096,12097,12098,12099 }
local BATTLER = 13279
local BATTLERALL = {13270, 13271, 13272, 13273, 13274, 13275, 13277, 13278, 13280, 13281}

local playerfaction = UnitFactionGroup("PLAYER")
local function showhorde()
    return playerfaction == "Horde"
end

local function showally()
    return playerfaction == "Alliance"
end



---- check
--local setEnabled = false
--local function CheckEventActive()
--	local _, month, day, year = CalendarGetDate()
--	local curMonth, curYear = CalendarGetMonth()
--	local monthOffset = -12 * (curYear - year) + month - curMonth
--	local numEvents = CalendarGetNumDayEvents(monthOffset, day)
--
--	for i=1, numEvents do
--		local _, eventHour, _, eventType, state, _, texture = CalendarGetDayEvent(monthOffset, day, i)
--
--		if texture == 235548 or texture == 235447 or texture == 235446 then
--			if state == "ONGOING" then
--				setEnabled = true
--			else
--				local hour = GetGameTime()
--
--				if state == "END" and hour <= eventHour or state == "START" and hour >= eventHour then
--					setEnabled = true
--				else
--					setEnabled = false
--				end
--			end
--		end
--	end
--end


local function IsAdventure( questID )
	return (questID == ADVENTURE)
end

local function IsArgus( questID )
	return (questID == ARGUS)
end

local function IsFamily( questID )
	return (questID == FAMILY)
end

local function IsBattler( questID )
	return (questID == BATTLER)
end


local function GetAchieveString(questID, questIndex, achieve)
	local extra = {}
	for _,j in ipairs(achieve) do
		local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
		if (not done) then
			_,txt = GetAchievementInfo(j)
			table.insert(extra, txt)
		end
	end
	return extra
end

-- plugin handler for HandyNotes
local function infoFromCoord(uiMapID, coord)
	--mapFile = gsub(mapFile, "_terrain%d+$", "")
	local point = points[uiMapID] and points[uiMapID][coord]
	local extra = {}
	local nametag = ""

	if (point) then
		local qID,qSequence,tag,_,_ = point:match(point_format)
		nametag = tag
		if (IsBattler(qID + 0) and db.battler) then extra = GetAchieveString(qID,qSequence, BATTLERALL) end
		if (IsFamily(qID + 0) and db.family) then extra = GetAchieveString(qID,qSequence, FAMILYALL) end
	else
		nametag = "No info"
	end
	return nametag, extra
end

function PetDailies:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local text, extra = infoFromCoord(mapFile, coord)
	tooltip:SetText(text, 0,1,0)
	for i,j in ipairs(extra) do
		tooltip:AddLine(j, 1,0,0)
	end

	if TomTom then
		tooltip:AddLine("Right-click to set a waypoint.", 1, 1, 1)
		tooltip:AddLine("Control-Right-click to set waypoints to every battle.", 1, 1, 1)
	end

	tooltip:Show()
end

local function IsLogged(questID, questIndex)
    if (questIndex > 0 and not IsAdventure(questID) and not IsFamily(questID) and not IsBattler(questID)
			and not IsArgus(questID)) then
        if (GetQuestLogIndexByID(questID) > 0) then return true
        else return false
        end
    else return true --shouldn't be logged so just say it is
    end
end

local function IsComplete(questID, questIndex)

	if (questIndex > 0 and not IsAdventure(questID) and not IsFamily(questID) and not IsBattler(questID)
			and not IsArgus(questID)) then
		if (IsLogged(questID, questIndex)) then
            local _,_,done = GetQuestLogLeaderBoard(questIndex,GetQuestLogIndexByID(questID))
            return done
        else return true
        end
	elseif (IsAdventure(questID) or IsFamily(questID) or IsArgus(questID)) or IsBattler(questID) then return false
	else return IsQuestFlaggedCompleted(questID)
	end

end


local function IsAdventureComplete(questID, questIndex)

	if (IsAdventure( questID ) and db.adv) then
		local _,_,done = GetAchievementCriteriaInfo(ADVENTURE,questIndex)
		return done
	else return true
	end
end

local function IsFamilyComplete(questID, questIndex)
	if (IsFamily( questID ) and db.family) then
		for _,j in ipairs(FAMILYALL) do
			local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
			if (not done) then return false end
		end
		return true
	else return true
	end
end

local function IsArgusComplete(questID, questIndex)
	if (IsArgus( questID ) and db.argus) then
		local _,_,done = GetAchievementCriteriaInfo(ARGUS,questIndex)
		return done
	else return true
	end
end

local function IsBattlerComplete(questID, questIndex)
	if (DEBUG) then
		print("In Battler")
		print(questID .. " "..questIndex)
	end
	if (IsBattler( questID ) and db.battler) then
		for _,j in ipairs(BATTLERALL) do
			local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
			if (not done) then return false end
		end
		return true
	else return true
	end
end

local function IsCoin( coinReward )
    return (coinReward=="true")
end


local function MatchesFaction( faction )
    return ( (faction == "both") or (faction == "horde" and showhorde() or (faction == "alliance" and showally())) )
end

local function ShouldBeShown( questStr )
    local questID, questIndex, _, _, coinReward, faction = questStr:match(point_format)
	questID = tonumber(questID)
	questIndex = tonumber(questIndex)
	if (DEBUG) then
		print(questStr)
		if (IsLogged(questID, questIndex)) then print("TRUE Is Logged") else print("FALSE Isn't Logged") end
		if (db.completed) then print("TRUE DB Complete") else print("FALSE DB Complete, but") end
		if (not IsComplete(questID, questIndex)) then print("TRUE Isnt complete") else print("FALSE Is complete") end
		if (not IsAdventure(questID)) then print("TRUE Isn't adventure") else print("FALSE Is adventure, but") end
		if (not IsAdventureComplete(questID, questIndex)) then print("TRUE Isn't complete adv") else print("FALSE Is complete adv") end
		if (not IsArgus(questID)) then print("TRUE Isn't argus") else print("FALSE Is argus, but") end
		if (not IsArgusComplete(questID, questIndex)) then print("TRUE Isn't complete argus"..questID.."."..questIndex) else print("FALSE Is complete argus") end
		if (not IsFamily(questID)) then print("TRUE Isn't family") else print("FALSE Is family, but") end
		if (not IsFamilyComplete(questID, questIndex)) then print("TRUE Isn't complete family") else print("FALSE Is complete family") end
		if (db.coins) then print("TRUE DB Coins") else print("FALSE DB Coins, but") end
		if (not IsCoin(coinReward))  then print("TRUE Isnt Coin") else print("FALSE Is COin") end
		if (MatchesFaction(faction)) then print("TRUE IS OK Faction") else print("FALSE ISNT OK Faction") end
	end

    return IsLogged(questID, questIndex) -- true if it doesn't need to be logged or it is still in log
        and (db.completed or not IsComplete(questID, questIndex) -- true if you want to show complete or it's not complete
		and (not IsAdventure(questID) or not IsAdventureComplete(questID, questIndex)) -- true if it isn't the Adventure achievement or it isn't completed for Adventure
		and (not IsArgus(questID) or not IsArgusComplete(questID, questIndex)) -- true if it isn't the Adventure achievement or it isn't completed for Adventure
		and (not IsFamily(questID) or not IsFamilyComplete(questID, questIndex)) -- true if it isn't the Adventure achievement or it isn't completed for Adventure
		and (not IsBattler(questID) or not IsBattlerComplete(questID, questIndex)) -- true if it isn't the Family Battler achievement or it isn't completed for Battler
		and (db.coins or not IsCoin(coinReward)) -- true if you want to show coins or it isn't a coin
        and (MatchesFaction(faction))) -- true if it is your faction or if it doesn't matter
    end

function PetDailies:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local function createWaypoint(uiMapID, coord)
	local x, y = HandyNotes:getXY(coord)
	--local m = HandyNotes:GetMapFiletoMapID(mapFile)
	local text = infoFromCoord(uiMapID, coord)

	TomTom:AddWaypoint(uiMapID, x, y, { title = text })
	--TomTom:SetClosestWaypoint()
end

local function createAllWaypoints()
	for mapFile, coords in next, points do
		for coord, questStr in next, coords do
			if ( coord and ShouldBeShown(questStr) ) then
				createWaypoint(mapFile, coord)
			end
		end
	end
end

function PetDailies:OnClick(button, down, uMapID, coord)
	if TomTom and button == "RightButton" and not down then
		if IsControlKeyDown() then
			createAllWaypoints()
		else
			createWaypoint(uMapID, coord)
		end
	end
end

do
	local function iter(t, prestate)

		if not PetDailies.isEnabled then return nil end

		if not t then return nil end

		local state, value = next(t, prestate)

		while state do -- have we reached the end of this zone?
			local _, _, _, iconstr, _ = value:match(point_format)
			local icon = "interface\\icons\\"..iconstr
			if ShouldBeShown(value) then
				if (DEBUG) then print(mapfile) end
				return state, mapFile, icon, db.icon_scale, db.icon_alpha
			end

			state, value = next(t, state) -- get next data
		end

		return nil, nil, nil, nil
	end

	local function iterCont(t, prestate)
		if not PetDailies.isEnabled then return nil end
		if not t then return nil end

		local zone = t.Z
		local uiMapID = t.C[zone]
		--local mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
		local state, value, data, cleanMapFile

		while uiMapID do
			--cleanMapFile = gsub(mapFile, "_terrain%d+$", "")
			data = points[uiMapID]

			if data then -- only if there is data for this zone
				state, value = next(data, prestate)

				while state do -- have we reached the end of this zone?
					local _, _,_, iconstr, _ = value:match(point_format)
					local icon = "interface\\icons\\"..iconstr
					if (ShouldBeShown(value)) then
						if (DEBUG) then print(mapfile) end
						return state, uiMapID, icon, db.icon_scale, db.icon_alpha
					end

					state, value = next(data, state) -- get next data
				end
			end

			-- get next zone
			zone = next(t.C, zone)
			t.Z = zone
			uiMapID = t.C[zone]
			prestate = nil
		end
	end

	function PetDailies:GetNodes2(uiMapID, miniMap)
		local C = HandyNotes:GetContinentZoneList(uiMapID) -- Is this a continent?
		if C then
			local tbl = { C = C, Z = next(C) }
			return iterCont, tbl, nil
		else
			--mapFile = gsub(mapFile, "_terrain%d+$", "")
			return iter, points[uiMapID], nil
		end
	end
--	function PetDailies:GetNodes(mapFile)
--		print(mapFile)
--		local C = HandyNotes:GetContinentZoneList(mapFile) -- Is this a continent?
--
--		if C then
--			local tbl = { C = C, Z = next(C) }
--			return iterCont, tbl, nil
--		else
--			mapFile = gsub(mapFile, "_terrain%d+$", "")
--			return iter, points[mapFile], nil
--		end
--	end
end


-- config
local options = {
	type = "group",
	name = "Battle Pet Dailies",
	desc = "Battle Pet Daily locations.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		PetDailies:Refresh()
	end,
	args = {

		completed = {
			name = "Show completed",
			desc = "Show icons for pets you have defeated today.",
			type = "toggle",
			width = "full",
			arg = "completed",
			order = 1,
		},
		coins = {
			name = "Show coin rewards also",
			desc = "Show icons for pet tamers that only give coin rewards.",
			type = "toggle",
			width = "full",
			arg = "coins",
			order = 2,
		},
		adv = {
			name = "Show An Awfully Big Adventure",
			desc = "Show icons for pet tamers you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "adv",
			order = 3,
		},
		argus = {
			name = "Show Anomalous Animals of Argus",
			desc = "Show icons for pet tamers you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "argus",
			order = 3,
		},
		family = {
			name = "Show Family Fighter",
			desc = "Show icons for pet tamers you haven't defeated fully for this achievement.",
			type = "toggle",
			width = "full",
			arg = "family",
			order = 3,
		},
		battler = {
			name = "Show Family Battler",
			desc = "Show icons for pet tamers you haven't defeated fully for this achievement.",
			type = "toggle",
			width = "full",
			arg = "family",
			order = 4,
		},
        desc = {
            name = "These settings control the look and feel of the icon.",
            type = "description",
            order = 5,
        },		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "Change the size of the icons.",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 6,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "Change the transparency of the icons.",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 7,
		},
	},
}

-- initialise
function PetDailies:OnEnable()
	self.isEnabled = true

--	local HereBeDragons = LibStub("HereBeDragons-1.0", true)
--	if not HereBeDragons then
--		HandyNotes:Print("Your installed copy of HandyNotes is out of date and the Pet Dailies plug-in will not work correctly.  Please update HandyNotes to version 1.4.0 or newer.")
--		return
--	end

--	local _, month, _, year = CalendarGetDate()
--	CalendarSetAbsMonth(month, year)

	HandyNotes:RegisterPluginDB("PetDailies", self, options)

	db = LibStub("AceDB-3.0"):New("HandyNotes_PetDailiesDB", defaults, "Default").profile
end

function PetDailies:Refresh(_, _)
	self:SendMessage("HandyNotes_NotifyUpdate", "PetDailies")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(PetDailies, "HandyNotes_PetDailies", "AceEvent-3.0")
