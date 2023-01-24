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
local GetQuestLogLeaderBoard = _G.GetQuestLogLeaderBoard
local GetAchievementCriteriaInfo = _G.GetAchievementCriteriaInfo
local GetAchievementInfo = _G.GetAchievementInfo
local IsControlKeyDown = _G.IsControlKeyDown
local LibStub = _G.LibStub
local next = _G.next
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local points = PetDailies.points

local All_Achieves = {}

Achieve = {}
function Achieve:new (a)
	a = a or {}
	setmetatable(a, self)
	self.__index = self
	return a
end

function Achieve:setID (id)
	self.id = id
	All_Achieves[id] = self
end

function Achieve:shouldShow ()
	return db[self.dbShow]
end

function Achieve:isComplete(questIndex)
	if (DEBUG) then print("Checking isComplete",self.id, questIndex) end
	if (All_Achieves[self.id].list) then
		for _,j in ipairs(All_Achieves[self.id].list) do
			local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
			if (not done) then return false end
		end
	else
		if (DEBUG) then print("Criteria",GetAchievementCriteriaInfo(self.id,questIndex)) end
		local _,_,done = GetAchievementCriteriaInfo(self.id,questIndex)
		return done
	end
	return false
end

local ADVENTURE = Achieve:new{dbShow = "adv"}
ADVENTURE:setID(9069)
local ARGUS = Achieve:new{dbShow = "arg"}
ARGUS:setID(12088)
local FAMILY = Achieve:new{dbShow = "family", list = {12089,12091,12092,12093,12094,12095,12096,12097,12098,12099 } }
FAMILY:setID(12100)
local BATTLER = Achieve:new{dbShow = "battler", list = {13270, 13271, 13272, 13273, 13274, 13275, 13277, 13278, 13280, 13281 }}
BATTLER:setID(13279)
local NUISANCES = Achieve:new{dbShow = "nuisances"}
NUISANCES:setID(13626)
local MINIONS = Achieve:new{dbShow = "minions"}
MINIONS:setID(13625)
local ABHORRENT = Achieve:new{dbShow = "abhor"}
ABHORRENT:setID(14881)
local EXORCIST = Achieve:new{dbShow = "exorcist", list = {14868, 14869, 14870, 14871, 14872, 14873, 14874, 14875, 14876, 14877 }}
EXORCIST:setID(14879)
local BATTLE_SL = Achieve:new{dbShow = "battle_sl"}
BATTLE_SL:setID(14625)
local BATTLER_DI = Achieve:new{dbShow = "battler_di", list = {16501, 16503, 16504, 16505, 16506, 16507, 16508, 16509, 16510, 16511 } }
BATTLER_DI:setID(16512)
local BATTLE_DI = Achieve:new{dbShow = "battle_di"}
BATTLE_DI:setID(16464)
function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			s = s .. '['..k..'] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end
local playerfaction = UnitFactionGroup("PLAYER")
local function showhorde()
    return playerfaction == "Horde"
end

local function showally()
    return playerfaction == "Alliance"
end


local function GetAchieveString(_, questIndex, achieve)
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
		if (All_Achieves[qID+0] and All_Achieves[qID+0].list and All_Achieves[qID+0]:shouldShow() ) then
			extra = GetAchieveString(qID,qSequence, All_Achieves[qID+0].list)
		end
		--if (IsBattler(qID + 0) and db.battler) then extra = GetAchieveString(qID,qSequence, BATTLERALL) end
		--if (IsFamily(qID + 0) and db.family) then extra = GetAchieveString(qID,qSequence, FAMILYALL) end
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
	for _,j in ipairs(extra) do
		tooltip:AddLine(j, 1,0,0)
	end

	if TomTom then
		tooltip:AddLine("Right-click to set a waypoint.", 1, 1, 1)
		tooltip:AddLine("Control-Right-click to set waypoints to every battle.", 1, 1, 1)
	end

	tooltip:Show()
end

local function IsLogged(questID, questIndex)

	if (questIndex > 0 and not All_Achieves[questID]) then
        if (C_QuestLog.GetLogIndexForQuestID(questID) and C_QuestLog.GetLogIndexForQuestID(questID) > 0) then return true
        else return false
        end
    else return true --shouldn't be logged so just say it is
    end
end

function PetDailies:IsComplete(questID, questIndex)
-- Returns false unless it's a world quest or logged quest and it's completed
	if (DEBUG) then print("Checking IsComplete", questID, questIndex) end
	if (questIndex > 0 and not All_Achieves[questID]) then
		if (DEBUG) then print("No Achieves entry") end

		if (IsLogged(questID, questIndex)) then
            local _,_,done = GetQuestLogLeaderBoard(questIndex,C_QuestLog.GetLogIndexForQuestID(questID))
            return done
        else return true
        end
	elseif All_Achieves[questID] then
		if (DEBUG) then print("There was an Achieves or the questIndex was 0") end
		return All_Achieves[questID]:isComplete(questIndex)
	else return C_QuestLog.IsQuestFlaggedCompleted(questID)
	end

end


local function IsCoin( coinReward )
    return (coinReward=="true")
end


local function MatchesFaction( faction )
    return ( (faction == "both") or (faction == "horde" and showhorde() or (faction == "alliance" and showally())) )
end

function PetDailies:ShouldBeShown( questStr )
    local questID, questIndex, _, _, coinReward, faction = questStr:match(point_format)
	questID = tonumber(questID)
	questIndex = tonumber(questIndex)
	if (DEBUG) then
		print("BEGIN QUEST INFO")
		print(questID, questIndex)
		print("logged", IsLogged(questID, questIndex))
		print("complete", db.completed or not PetDailies:IsComplete(questID, questIndex))
		print("achieve",not All_Achieves[questID] or All_Achieves[questID]:shouldShow())
		print("coins result",db.coins or coinReward == "false")
		print("together",
				IsLogged(questID, questIndex)
						and (db.completed or not PetDailies:IsComplete(questID, questIndex))
						and (not All_Achieves[questID] or All_Achieves[questID]:shouldShow())
						and (db.coins or coinReward == "false"))
	end
	-- Show if it doesn't need to be logged or is already in the log
	-- Show if you want to show completed or it's not complete
	-- Show if it's an achievement you want to show
	-- Show if you want to show coin rewards or it's not a coin reward
	-- Show if it's your faction

    return IsLogged(questID, questIndex) -- true if it doesn't need to be logged or it is still in log
        and (db.completed or not PetDailies:IsComplete(questID, questIndex)) -- true if you want to show complete or it's not complete
		and (not All_Achieves[questID] or All_Achieves[questID]:shouldShow()) -- true if you want to show this achieve
		--and (not IsAdventure(questID) or not IsAdventureComplete(questID, questIndex)) -- true if it isn't the Adventure achievement or it isn't completed for Adventure
		--and (not IsArgus(questID) or not IsArgusComplete(questID, questIndex)) -- true if it isn't the Argus achievement or it isn't completed for Argus
		--and (not IsMinions(questID) or not IsMinionsComplete(questID, questIndex)) -- true if it isn't the Minions achievement or it isn't completed for Minions
		--and (not IsNuisances(questID) or not IsNuisancesComplete(questID, questIndex)) -- true if it isn't the Nuisances achievement or it isn't completed for Nuisances
		--and (not IsBattler(questID) or not IsBattlerComplete(questID, questIndex)) -- true if it isn't the Family Battler achievement or it isn't completed for Battler
		and (db.coins or coinReward == "false") -- true if you want to show coins or it isn't a coin
        and (MatchesFaction(faction)) -- true if it is your faction or if it doesn't matter
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
			if ( coord and PetDailies:ShouldBeShown(questStr) ) then
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
		if (DEBUG) then print("Starting iter 1") end

		if not PetDailies.isEnabled then return nil end

		if (DEBUG) then print("Starting iter 2") end
		if not t then return nil end
		if (DEBUG) then print("Starting iter 3") end

		local state, value = next(t, prestate)
		if (DEBUG) then print("In first iter", state, value) end

		while state do -- have we reached the end of this zone?
			local _, _, _, iconstr, _ = value:match(point_format)
			local icon = "interface\\icons\\"..iconstr
			if PetDailies:ShouldBeShown(value) then
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
		local state, value, data

		while uiMapID do
			if (DEBUG) then print(uiMapID) end
			--cleanMapFile = gsub(mapFile, "_terrain%d+$", "")
			data = points[uiMapID]

			if data then -- only if there is data for this zone
				state, value = next(data, prestate)

				while state do -- have we reached the end of this zone?
					local _, _,_, iconstr, _ = value:match(point_format)
					local icon = "interface\\icons\\"..iconstr
					if (PetDailies:ShouldBeShown(value)) then
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

	function PetDailies:GetNodes2(uiMapID)
		local C = HandyNotes:GetContinentZoneList(uiMapID) -- Is this a continent?
		if (DEBUG) then print("Is continent?",C) end

		if C then
			local tbl = { C = C, Z = next(C) }
			return iterCont, tbl, nil
		else
			--mapFile = gsub(mapFile, "_terrain%d+$", "")
			if (DEBUG) then print("Points", uiMapID, points[uiMapID]) end
			if (DEBUG) then print("array is",dump(points)) end
			return iter, points[uiMapID], nil
		end
	end

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
		debug = {
			name = "List",
			desc = "Toggle List",
			type = "toggle",
			guiHidden = true,
		},
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
			arg = "battler",
			order = 4,
		},
		nuisances = {
			name = "Show Nautical Nuisances of Nazjatar",
			desc = "Show icons for pet tamers you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "nuisances",
			order = 5,
		},
		minions = {
			name = "Show Mighty Minions of Mechagon",
			desc = "Show icons for pet tamers you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "minions",
			order = 6,
		},
		abhorrent = {
			name = "Show Abhorrent Adversaries of the Afterlife",
			desc = "Show icons for afterlife atrocities you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "abhor",
			order = 7,
		},
		exorcists = {
			name = "Show Family Exorcist",
			desc = "Show icons for pet tamers you haven't defeated fully for this achievement.",
			type = "toggle",
			width = "full",
			arg = "exorcist",
			order = 8,
		},
		battle_sl = {
			name = "Show Battle in the Shadowlands",
			desc = "Show icons for pet world quests you haven't defeated fully for this achievement.",
			type = "toggle",
			width = "full",
			arg = "battle_sl",
			order = 9,
		},
		battle_di = {
			name = "Show Battle on the Dragon Isles",
			desc = "Show icons for pet world quests you haven't defeated fully for this achievement.",
			type = "toggle",
			width = "full",
			arg = "battle_di",
			order = 10,
		},
		family = {
			name = "Show Family Battler of the Dragon Isles",
			desc = "Show icons for pet tamers you haven't defeated fully for this achievement.",
			type = "toggle",
			width = "full",
			arg = "battler_di",
			order = 11,
		},
        desc = {
            name = "These settings control the look and feel of the icon.",
            type = "description",
            order = 12,
        },
		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "Change the size of the icons.",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 13,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "Change the transparency of the icons.",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 14 ,
		},
	},
}

-- initialise
function PetDailies:OnEnable()
	self.isEnabled = true
	HandyNotes:RegisterPluginDB("PetDailies", self, options)
	print("HandyNotes Pet Dailies Enabled")
	db = LibStub("AceDB-3.0"):New("HandyNotes_PetDailiesDB", defaults, "Default").profile
end

function PetDailies:Refresh(_, _)
	self:SendMessage("HandyNotes_NotifyUpdate", "PetDailies")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(PetDailies, "HandyNotes_PetDailies", "AceEvent-3.0")



--local function IsAdventureComplete(questID, questIndex)
--
--	if (IsAdventure( questID ) and db.adv) then
--		local _,_,done = GetAchievementCriteriaInfo(ADVENTURE,questIndex)
--		return done
--	else return true
--	end
--end
--local function IsArgusComplete(questID, questIndex)
--	if (IsArgus( questID ) and db.argus) then
--		local _,_,done = GetAchievementCriteriaInfo(ARGUS,questIndex)
--		return done
--	else return true
--	end
--end

--local function IsMinionsComplete(questID, questIndex)
--	if (IsMinions( questID ) and db.minions) then
--		local _,_,done = GetAchievementCriteriaInfo(MINIONS,questIndex)
--		return done
--	else return true
--	end
--end


--local function IsNuisancesComplete(questID, questIndex)
--	if (IsNuisances( questID ) and db.nuisances) then
--		local _,_,done = GetAchievementCriteriaInfo(NUISANCES,questIndex)
--		return done
--	else return true
--	end
--end
--
--local function IsAdventure( questID )
--	return (questID == ADVENTURE)
--end
--
--local function IsArgus( questID )
--	return (questID == ARGUS)
--end
--
--local function IsNuisances( questID )
--	return (questID == NUISANCES)
--end
--local function IsMinions( questID )
--	return (questID == MINIONS)
--end
--
--local function IsFamily( questID )
--	return (questID == FAMILY)
--end
--
--local function IsAbhorrent( questID )
--	return (questID == ABHORRENT)
--end
--local function IsBattle_SL( questID )
--	return (questID == BATTLE_SL)
--end
--local function IsBattle_DI( questID )
--	return (questID == BATTLE_DI)
--end
--local function IsBattler( questID )
--	return (questID == BATTLER)
--end

--function PetDailies:OnInitialize()
--	PetDailies.db = LibStub("AceDB-3.0"):New(addonName, defaults)
--	--local options = addon:myOptions()
--	LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, addonName)
--	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options, {"petdailies"})
----	optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, addonName)--, nil, "general")
----	optionsFrame.default = function()
----		for k,v in pairs(defaults.profile) do settings[k] = table_clone(v) end
----		addon:RefreshConfig()
----		if InterfaceOptionsFrame:IsShown() then
----			addon:Config(); addon:Config()
----		end
----	end
----	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(addon.db)
----	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, L["Profiles"], addonName, "profiles")
--
--	debug("OnInitialize")
--
----	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
----	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
----	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
----	self.db.RegisterCallback(self, "OnDatabaseReset", "RefreshConfig")
--end
--local show_each = {
--	ADVENTURE = db.adv,
--	ARGUS = db.arg,
--	MINIONS = db.minions,
--	NUISANCES = db.nuisances,
--	BATTLER = db.battler,
--	ABHORRENT = db.abhor,
--	BATTLE_SL = db.battle_sl,
--	BATTLE_DI = db.battle_di
--}
--local All_Achieves = {
--	ADVENTURE = true,
--	ARGUS = true,
--	FAMILY = true,
--	BATTLER = true,
--	NUISANCES = true,
--	MINIONS = true,
--	ABHORRENT = true,
--	EXORCIST = true,
--	BATTLE_SL = true,
--	BATTLER_DI = true,
--	BATTLE_DI = true
--}
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

--
--local function IsFamilyComplete(questID, questIndex)
--	if (IsFamily( questID ) and db.family) then
--		for _,j in ipairs(FAMILYALL) do
--			local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
--			if (not done) then return false end
--		end
--		return true
--	else return true
--	end
--end
--
--
--
--local function IsBattlerComplete(questID, questIndex)
--	if (IsBattler( questID ) and db.battler) then
--		for _,j in ipairs(BATTLERALL) do
--			local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
--			if (not done) then return false end
--		end
--		return true
--	else return true
--	end
--end

--local ADVENTURE = 9069
--local ARGUS = 12088
--local FAMILY = 12100
--local FAMILYALL = {12089,12091,12092,12093,12094,12095,12096,12097,12098,12099 }
--local BATTLER = 13279
--local BATTLERALL = {13270, 13271, 13272, 13273, 13274, 13275, 13277, 13278, 13280, 13281 }
--local NUISANCES = 13626
--local MINIONS = 13625
--local ABHORRENT = 14881
--local EXORCIST = 14879
--local EXORCIST_ALL = {14868, 14869, 14870, 14871, 14872, 14873, 14874, 14875, 14876, 14877 }
--local BATTLE_SL = 14625
--local BATTLER_DI = 16512
--local BATTLER_DI_ALL = {16501, 16502, 16504, 16505, 16506, 16507, 16508, 16509, 16510, 16511 }
--local BATTLE_DI = 16464


--local GetGameTime = _G.GetGameTime
--local GetQuestsCompleted = _G.GetQuestsCompleted
--local gsub = _G.string.gsub