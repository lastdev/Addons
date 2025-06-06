local mod	= DBM:NewMod("DSTrash", "DBM-Raids-Cata", 1, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241115112135")
mod:SetModelID(39378)
mod:SetZone(967)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 107597",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED_UNFILTERED"
)

local warnBoulder			= mod:NewTargetAnnounce(107597, 3)--This is morchok entryway trash that throws rocks at random poeple.
local warnDrakesLeft		= mod:NewAnnounce("DrakesLeft", 2, 61248)

local specWarnBoulder		= mod:NewSpecialWarningMoveAway(107597, nil, nil, nil, 1, 2)
local yellBoulder			= mod:NewYell(107597)
local specWarnFlames		= mod:NewSpecialWarningGTFO(105579, nil, nil, nil, 1, 8)

local timerDrakes			= mod:NewTimer(253, "TimerDrakes", 61248, nil, nil, 6)
local timerRoleplay			= mod:NewTimer(45.5, "timerRoleplay", "237538", nil, nil, 6)
--Leave this timer for now, I think this is the same.
--it still seems timed, just ends earlier if you kill 15 drakes.
--No one knew it ended at 24 drakes before hotfix because timer always expired before any raid hit 24, so we often just saw the hard capped event limit.
--I suspect some shitty LFR group is still gonna hit timer limit before 15 drakes, so we'll see

local drakeRunning = false
local drakesCount = mod:IsRetail() and 5 or 15
local drakeguid = {}
local drakeEscape = DBM:GetSpellName(109904)

---@param self DBMMod
---@param GUID string
local function drakeDied(self, GUID)
	if not drakeguid[GUID] then
		drakeguid[GUID] = true
		drakesCount = drakesCount - 1
		if drakesCount >= 0 then
			warnDrakesLeft:Show(drakesCount)
		end
		if drakesCount == 0 then
			self:SendSync("SkyrimEnded")
		end
	end
end

function mod:BoulderTarget(targetname, uId)
	if targetname and self:AntiSpam(1, targetname) then--Anti spam using targetname as an identifier, will prevent same target being announced double/tripple but NOT prevent multiple targets being announced at once :)
		if targetname == UnitName("player") then
			if self:AntiSpam(3, 1) then
				specWarnBoulder:Show()
				yellBoulder:Yell()
			end
		else
			warnBoulder:Show(targetname)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 107597 then -- Spell cast 3 sec. Seems to location sets before cast completion. I tested 2.5 and good worked.
		self:ScheduleMethod(0.5, "BossTargetScanner", args.sourceGUID, "BoulderTarget", 0.1, 9)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName, _, _, overkill)
	if spellId == 105579 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnFlames:Show(spellName)
		specWarnFlames:Play("watchfeet")
	elseif (overkill or 0) > 0 then -- prevent to waste cpu. only pharse cid when event have overkill parameter.
		local cid = self:GetCIDFromGUID(destGUID)
		if (cid == 56249 or cid == 56250 or cid == 56251 or cid == 56252 or cid == 57281 or cid == 57795) then--Hack for mobs that don't fire UNIT_DIED event.
			drakeDied(self, destGUID)
		end
	end
end
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE

function mod:SPELL_MISSED(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 105579 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnFlames:Show(spellName)
		specWarnFlames:Play("watchfeet")
	end
end

--Very shitty performance way of doing it, but it's only way that works. they have about a 1/3 chance to NOT fire UNIT_DIED, sigh. But they do always fire an overkill. Confirmed in my logs.
function mod:SWING_DAMAGE(_, _, _, _, destGUID, _, _, _, _, overkill)
	if (overkill or 0) > 0 then -- prevent to waste cpu. only pharse cid when event have overkill parameter.
		local cid = self:GetCIDFromGUID(destGUID)
		if (cid == 56249 or cid == 56250 or cid == 56251 or cid == 56252 or cid == 57281 or cid == 57795) then--Hack for mobs that don't fire UNIT_DIED event.
			drakeDied(self, destGUID)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56249 or cid == 56250 or cid == 56251 or cid == 56252 or cid == 57281 or cid == 57795 then
		drakeDied(self, args.destGUID)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.firstRP or msg:find(L.firstRP) then
		self:SendSync("FirstRP")
		--"<72.3 19:45:35> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#It is good to see you again, Alexstrasza. I have been busy in my absence.#Deathwing###Omegal##0#0##0#175#nil#0#false#false", -- [18]
		--"<104.6 19:46:08> [UNIT_SPELLCAST_SUCCEEDED] Thrall [[target:Ward of Earth::0:108161]]", -- [26]
	elseif msg == L.UltraxionTrash or msg:find(L.UltraxionTrash) then
		self:SendSync("SecondRP")
	elseif msg == L.UltraxionTrashEnded or msg:find(L.UltraxionTrashEnded) then
		self:SendSync("SkyrimEnded")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED_UNFILTERED(uId, _, spellId)
	if spellId == 108161 then--Thrall starting drake event, comes later then yell but is only event that triggers after a wipe to this trash.
		self:SendSync("Skyrim")
	elseif spellId == 109904 then
		self:SendSync("SkyrimEnded")
	--"<1.5 19:44:24> [UNIT_SPELLCAST_SUCCEEDED] Kalecgos [[target:Dialogue::0:109644]]", -- [1]
	--"<1.7 19:44:25> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#Praise the Titans, they have returned!#Ysera the Awakened###Ysera the Awakened##0#0##0#165#nil#0#false#false", -- [2]
	--"<42.4 19:45:05> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#Speak to me when you are ready to begin.#Thrall###Thrall##0#0##0#171#nil#0#false#false", -- [15]
	elseif spellId == 109644 then--First RP after Eye of Eternity
		self:SendSync("FirstRP")
	end
end

function mod:OnSync(msg, GUID)
	if msg == "Skyrim" then
		if not drakeRunning then
			self:RegisterShortTermEvents(
				"SPELL_DAMAGE",
				"SPELL_MISSED",
				"SWING_DAMAGE",
				"SPELL_PERIODIC_DAMAGE",
				"RANGE_DAMAGE",
				"UNIT_DIED"
			)
			drakeRunning = true
		end
		table.wipe(drakeguid)
		drakesCount = self:IsRetail() and 5 or 15
		timerDrakes:Start(231, drakeEscape)
	elseif msg == "SkyrimEnded" then
		drakeRunning = false
		self:UnregisterShortTermEvents()
		timerDrakes:Cancel()
	elseif msg == "FirstRP" then
		timerRoleplay:Start()
	elseif msg == "SecondRP" then
		timerRoleplay:Start(32)
		if not drakeRunning then
			self:RegisterShortTermEvents(
				"SPELL_DAMAGE",
				"SPELL_MISSED",
				"SWING_DAMAGE",
				"SPELL_PERIODIC_DAMAGE",
				"RANGE_DAMAGE",
				"UNIT_DIED"
			)
			drakeRunning = true
		end
		table.wipe(drakeguid)
		drakesCount = self:IsRetail() and 5 or 15--Reset drakes here still in case no one running current dbm is targeting thrall
		timerDrakes:Start(253, drakeEscape)--^^
		--timer still remains even combat starts. so, cancels manually. (Probably for someone who wasn't present for first drake dying.
	end
end
