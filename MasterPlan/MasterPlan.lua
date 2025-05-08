local addonName, T = ...
if T.Mark ~= 50 then
	local m = T.Mark == nil and "You must restart World of Warcraft after installing this update." or ADDON_INCOMPATIBLE
	if type(T.L) == "table" and type(T.L[m]) == "string" then m = T.L[m] end
	return print("|cffffffff[Master Plan]: |cffff8000" .. m)
end

local L = newproxy(true) do
	local LL = type(T.L) == "table" and T.L or {}
	getmetatable(L).__call = function(_, k)
		return LL[k] or k
	end
	T.L = L
end

local EV, G, addonLoadOK, conf, aconf = T.Evie, T.Garrison, nil, setmetatable({}, {__index={
	availableMissionSort="reward",
	sortFollowers=true,
	riskReward=1,
	xpCapGrace=2000,
	goldRewardThreshold=100e4,
	levelDecay=0.9,
	currencyWasteThreshold=0.20,
	legendStep=0,
	timeHorizon=0,
	timeHorizonMin=300,
	crateLevelGrace=25,
	interestMask=0, interestStack=1,
	ship1=100, ship2=90, ship3=80, ship4=50,
	moC=0, moE=0, moV=0, moN=0, goldCollected=0, goldCollectedS=0,
	extPriorityKey='',
	allowShipXP=true,
	ignore={},
	rIgnore={},
}})
T.config, aconf = conf, MasterPlanA.data

local priv, pub = {}, setmetatable({}, {__index={GarrisonAPI=G}})
local missionPriorityCB, numPriorityCB, defaultPriorityCB = {}, 0, nil

function EV:ADDON_LOADED(addon)
	if addon ~= addonName then
		return
	end
	
	local pc
	if type(MasterPlanPC) == "table" then
		pc = MasterPlanPC
	else
		pc = {}
	end
	
	for k,v in pairs(pc) do
		local tv = type(v)
		if k == "ignore" and tv == "table" then
			for k,v in pairs(v) do
				conf.ignore[k] = v
			end
		elseif k == "rIgnore" and tv == "table" then
			local gt = MasterPlanAG.IgnoreRewards
			for k,v in pairs(v) do
				if type(k) == "string" and type(v) == "boolean" and (gt[k] ~= v) then
					conf.rIgnore[k] = v
				end
			end
		elseif k ~= "complete" and tv == type(conf[k]) then
			conf[k] = v
		elseif k == "extPriorityKey" and v == false then
			conf[k] = v
		end
	end
	T._SetMissionSeenTable(pc.complete)
	conf.version = C_AddOns.GetAddOnMetadata(addonName, "Version")
	addonLoadOK, MasterPlanPC = true
	EV("MP_SETTINGS_CHANGED")
	
	return "remove"
end
function EV:PLAYER_LOGOUT()
	if addonLoadOK then
		MasterPlanPC, conf.ignore, conf.rIgnore = conf, next(conf.ignore) and conf.ignore, next(conf.rIgnore) and conf.rIgnore
		conf.complete = securecall(T._GetMissionSeenTable)
	end
end
do -- Completion stats
	local sc = {}
	function EV:MP_MARK_MISSION_COMPLETE(mid)
		local m = C_Garrison.GetBasicMissionInfo(mid)
		if m then
			sc[mid] = m
			G.ExtendMissionInfoWithParty(m)
		end
	end
	function EV:GARRISON_MISSION_COMPLETE_RESPONSE(mid, cc, ok)
		local mi = cc and sc[mid]
		if not mi then return end
		local msc = mi.successChance
		if msc and (0 < msc or ok) and (msc < 100 or not ok) then
			local sp = msc / 100
			conf.moC, conf.moE, conf.moV, conf.moN = conf.moC + (ok and 1 or 0), conf.moE + sp, conf.moV + sp*(1-sp), conf.moN + 1
		end
		if ok and mi.rewards then
			for k,r in pairs(mi.rewards) do
				if r.currencyID == 0 then
					local q = floor(r.quantity * G.GetRewardMultiplier(mi, r.currencyID))
					conf.goldCollected, conf.goldCollectedS = conf.goldCollected + q, conf.goldCollectedS + (mi.followerTypeID == 2 and q or 0)
				end
			end
		end
		sc[mid] = nil
	end
	function EV:MP_RELEASE_CACHES()
		sc = {}
	end
end

function EV:GARRISON_RECRUITMENT_NPC_OPENED()
	if C_Garrison.CanGenerateRecruits() then
		aconf.recruitTime = GetServerTime()-604801
	else
		local dt = type(aconf.recruitTime) == "number" and GetServerTime() - aconf.recruitTime or 604801
		if dt > 604800 then
			aconf.recruitTime = GetServerTime()
		end
	end
end
function EV:GARRISON_RECRUITMENT_FOLLOWERS_GENERATED()
	aconf.recruitTime = GetServerTime()
end

function pub:GetSortFollowers()
	return conf.sortFollowers
end
function pub:SetSortFollowers(sort)
	assert(type(sort) == "boolean", 'Syntax: MasterPlan:SetSortFollowers(sort)')
	conf.sortFollowers = sort
	EV("MP_SETTINGS_CHANGED", "sortFollowers")
end

function pub:SetMissionOrder(order)
	assert(type(order) == "string", 'Syntax: MasterPlan:SetMissionOrder("order")')
	conf.availableMissionSort = order
	EV("MP_SETTINGS_CHANGED", "availableMissionSort")
end
function pub:GetMissionOrder()
	return conf.availableMissionSort
end
function pub:SetTimeHorizon(sec)
	assert(type(sec) == "number" and sec >= 0, 'Syntax: MasterPlan:SetTimeHorizon(sec)')
	conf.timeHorizon = sec
	EV("MP_SETTINGS_CHANGED", "timeHorizon")
end
function pub:RegisterMissionPriorityCallback(key, name, callback)
	if missionPriorityCB[key] ~= nil then
		return error('RegisterMissionPriorityCallback: specified key already registered', 2)
	elseif type(key) ~= 'string' or key == '' or type(name) ~= 'string' or type(callback) ~= 'function' then
		return error('Syntax: MasterPlan:RegisterPriorityCallback("key", "name", callback)', 2)
	end
	missionPriorityCB[key], numPriorityCB, defaultPriorityCB = {name, callback}, numPriorityCB + 1, defaultPriorityCB == nil and key
	if numPriorityCB < 3 or key == conf.extPriorityKey then
		EV("MP_SETTINGS_CHANGED", "extPriorityKey")
	end
end
function priv:SetMissionPriorityCallback(k)
	assert(k == false or type(k) == 'string', 'Syntax: MasterPlan:SetMissionPriorityCallback("key")')
	conf.extPriorityKey = k
	EV("MP_SETTINGS_CHANGED", "extPriorityKey")
end
function priv:GetMissionPriority(mid)
	local pk = conf.extPriorityKey
	local cbInfo = missionPriorityCB[pk] or missionPriorityCB[pk and defaultPriorityCB]
	local p = cbInfo and securecall(cbInfo[2], mid)
	return type(p) == "number" and (p <= -1023 and -1023 or p >= 1023 and 1023 or p > -1023 and p < 1023 and p or 0)/1024 or 0
end
function priv:GetNumMissionPriorityOptions()
	return numPriorityCB
end
function priv:IsActiveMissionPriorityCallback(k)
	local pk = conf.extPriorityKey
	return not not (k == pk or pk and k ~= false and defaultPriorityCB or k == false and missionPriorityCB[pk] == nil and not defaultPriorityCB)
end
function pub:AllMissionPriorityCallbacks(k)
	local k, info = next(missionPriorityCB, k)
	if k then
		return k, info[1], priv:IsActiveMissionPriorityCallback(k)
	end
end

function pub:IsFollowerIgnored(fid)
	return not not conf.ignore[fid]
end
function pub:SetFollowerIgnored(fid, ignore)
	assert(type(fid) == "string", 'Syntax: MasterPlan:SetFollowerIgnored("followerID", ignore)')
	conf.ignore[fid] = ignore and 1 or nil
end

function pub:IsRewardIgnored(key)
	local me = conf.rIgnore[key]
	if me == nil then
		return MasterPlanAG.IgnoreRewards[key]
	end
	return me
end
function pub:SetRewardIgnore(key, val, isForAll)
	assert(type(key) == "string" and type(val or false) == "boolean" and type(isForAll or false) == "boolean")
	if isForAll then
		MasterPlanAG.IgnoreRewards[key], conf.rIgnore[key] = val
	else
		conf.rIgnore[key] = val
	end
	EV("MP_SETTINGS_CHANGED", "missionIgnore", key)
end
function priv:IsMissionIgnored(minfo)
	assert(type(minfo) == "table" and type(minfo.missionID) == "number", 'Syntax: isIgnored = MasterPlan:IsMissionIgnored(missionInfoTable)')
	local byMid = pub:IsRewardIgnored("m:" .. minfo.missionID)
	if byMid ~= nil then
		return byMid
	elseif type(minfo.rewards) ~= "table" then
		return nil
	end
	local xpType, hasIgnore = minfo.level == T.FOLLOWER_LEVEL_CAP and "f:xp10" or (type(minfo.level) == "number" and minfo.level < (T.FOLLOWER_LEVEL_BASE+5) and "f:xp90") or "f:xp95", nil
	for k,v in pairs(minfo.rewards) do
		if v.currencyID then
			k = pub:IsRewardIgnored("c:" .. v.currencyID)
		elseif v.itemID then
			k = pub:IsRewardIgnored("i:" .. v.itemID)
		elseif v.followerXP then
			k = pub:IsRewardIgnored(xpType)
		else
			v = nil
		end
		if not v then
		elseif k ~= true then
			return false -- Not quite the right answer for the tri-state.
		else
			hasIgnore = true
		end
	end
	return hasIgnore
end

priv.GetSortFollowers = pub.GetSortFollowers
priv.IsRewardIgnored = pub.IsRewardIgnored
priv.AllMissionPriorityCallbacks = pub.AllMissionPriorityCallbacks

MasterPlan, T.PlanCore = pub, priv