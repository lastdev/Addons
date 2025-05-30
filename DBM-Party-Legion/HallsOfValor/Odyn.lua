local mod	= DBM:NewMod(1489, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250307060117")
mod:SetCreatureID(95676)
mod:SetEncounterID(1809)
mod:SetHotfixNoticeRev(20230306000000)
mod:SetMinSyncRevision(20221228000000)
mod.sendMainBossGUID = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198072 198263 198077 198750",
	"SPELL_CAST_SUCCESS 197961",
	"SPELL_AURA_APPLIED 197963 197964 197965 197966 197967",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)
mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

--http://legion.wowhead.com/icons/name:boss_odunrunes_
--["198263-Radiant Tempest"] = "pull:8.0, 72.0, 40.0", huh?
--[[
(ability.id = 198072 or ability.id = 198263 or ability.id = 198077) and type = "begincast"
 or ability.id = 197961 and type = "cast"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
 or ability.id = 198750 and type = "begincast"
--]]
--TODO, does boss still have old random tempest timers system from legion or are 10.0.2 changes universal?
local warnSpear						= mod:NewSpellAnnounce(198072, 2)--Target not available so no target warning.

local specWarnTempest				= mod:NewSpecialWarningRunCount(198263, nil, nil, nil, 4, 2)
local specWarnShatterSpears			= mod:NewSpecialWarningDodge(198077, nil, nil, nil, 2, 2)
local specWarnRunicBrand			= mod:NewSpecialWarningMoveTo(197961, nil, nil, nil, 2, 6)
local specWarnAdd					= mod:NewSpecialWarningSwitch(201221, "-Healer", nil, nil, 1, 2)
local specWarnSurge					= mod:NewSpecialWarningInterrupt(198750, "HasInterrupt", nil, nil, 1, 2)

local timerRP						= mod:NewCombatTimer(28.5)
--local timerSpearCD					= mod:NewCDTimer(8, 198077, nil, nil, nil, 3)--More data needed
local timerTempestCD				= mod:NewCDCountTimer(56, 198263, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--More data needed
local timerShatterSpearsCD			= mod:NewCDTimer(56, 198077, nil, nil, nil, 2)
local timerRunicBrandCD				= mod:NewCDCountTimer(56, 197961, nil, nil, nil, 3)
local timerAddCD					= mod:NewCDTimer(54, 201221, nil, nil, nil, 1, 201215)--54-58

mod:AddDropdownOption("RuneBehavior", {"Icon", "Entrance", "Minimap", "Generic"}, "Generic", "misc", nil, 197961)

--Boss has (at least) three timer modes, cannot determine which one on pull so on fly figuring out is used
local oldTempestTimers = {
	[1] = {8, 56, 72},
	[2] = {16, 48, 64},--If such a beast exists, it'll look like this based on theory. This sequence is COPMLETE guesswork
	[3] = {24, 40, 56},
	[4] = {32, 32, 48},--32 and 48 are guessed based on theory
}
--local oldbrandTimers = {44, 56}
mod.vb.temptestMode = 1
mod.vb.tempestCount = 0
mod.vb.brandCount = 0

--Should run at 10, 18, 26, and 34
--[[
local function tempestDelayed(self)
	if self.vb.tempestCount == 0 then
		DBM:AddMsg(L.tempestModeMessage:format(self.vb.temptestMode))
		self.vb.temptestMode = self.vb.temptestMode + 1
		self:Schedule(8, tempestDelayed, self)
		timerTempestCD:Start(6, 1)
	else
		return
	end
end
--]]

function mod:OnCombatStart(delay)
	self.vb.temptestMode = 1
	self.vb.tempestCount = 0
	self.vb.brandCount = 0
--	timerSpearCD:Start(-delay)
	timerTempestCD:Start(24-delay, 1)
--	self:Schedule(10, tempestDelayed, self, 1)
	timerShatterSpearsCD:Start(40-delay)
	timerRunicBrandCD:Start(45.9-delay, 1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198072 then
		warnSpear:Show()
	elseif spellId == 198263 then
		self.vb.tempestCount = self.vb.tempestCount + 1
		specWarnTempest:Show(self.vb.tempestCount)
		specWarnTempest:Play("runout")
		timerTempestCD:Start(55, self.vb.tempestCount+1)
--		timerSpearCD:Start(12)
--		local timers = tempestTimers[self.vb.temptestMode]
--		if timers then
--			local nextCast = self.vb.tempestCount+1
--			if timers[nextCast] then
--				timerTempestCD:Start(timers[nextCast], nextCast)
--			end
--		end
	elseif spellId == 198077 then
		specWarnShatterSpears:Show()
		specWarnShatterSpears:Play("watchorb")
		timerShatterSpearsCD:Start()
	elseif spellId == 198750 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSurge:Show(args.sourceName)
		specWarnSurge:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 197961 then
		self.vb.brandCount = self.vb.brandCount + 1
--		timerSpearCD:Start(18)
		local nextCount = self.vb.brandCount+1
--		local timer = brandTimers[nextCount]
--		if timer and timer > 0 then
			timerRunicBrandCD:Start(nil, nextCount)
--		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197963 and args:IsPlayer() then--Purple K (NE)
		specWarnRunicBrand:Show("|TInterface\\Icons\\Boss_OdunRunes_Purple.blp:12:12|tNE|TInterface\\Icons\\Boss_OdunRunes_Purple.blp:12:12|t")
		if self.Options.RuneBehavior == "Entrance" then
			specWarnRunicBrand:Play("frontleft")
		elseif self.Options.RuneBehavior == "Icon" then
			specWarnRunicBrand:Play("mm3")--Purple Diamond
		elseif self.Options.RuneBehavior == "Minimap" then
			specWarnRunicBrand:Play("frontright")
		else
			specWarnRunicBrand:Play("targetyou")
		end
	elseif spellId == 197964 and args:IsPlayer() then--Orange N (SE)
		specWarnRunicBrand:Show("|TInterface\\Icons\\Boss_OdunRunes_Orange.blp:12:12|tSE|TInterface\\Icons\\Boss_OdunRunes_Orange.blp:12:12|t")
		if self.Options.RuneBehavior == "Entrance" then
			specWarnRunicBrand:Play("backleft")
		elseif self.Options.RuneBehavior == "Icon" then
			specWarnRunicBrand:Play("mm2")--Orange Circle
		elseif self.Options.RuneBehavior == "Minimap" then
			specWarnRunicBrand:Play("backright")
		else
			specWarnRunicBrand:Play("targetyou")
		end
	elseif spellId == 197965 and args:IsPlayer() then--Yellow H (SW)
		specWarnRunicBrand:Show("|TInterface\\Icons\\Boss_OdunRunes_Yellow.blp:12:12|tSW|TInterface\\Icons\\Boss_OdunRunes_Yellow.blp:12:12|t")
		if self.Options.RuneBehavior == "Entrance" then
			specWarnRunicBrand:Play("backright")
		elseif self.Options.RuneBehavior == "Icon" then
			specWarnRunicBrand:Play("mm1")--Yellow Star
		elseif self.Options.RuneBehavior == "Minimap" then
			specWarnRunicBrand:Play("backleft")
		else
			specWarnRunicBrand:Play("targetyou")
		end
	elseif spellId == 197966 and args:IsPlayer() then--Blue fishies (NW)
		specWarnRunicBrand:Show("|TInterface\\Icons\\Boss_OdunRunes_Blue.blp:12:12|tNW|TInterface\\Icons\\Boss_OdunRunes_Blue.blp:12:12|t")
		if self.Options.RuneBehavior == "Entrance" then
			specWarnRunicBrand:Play("frontright")
		elseif self.Options.RuneBehavior == "Icon" then
			specWarnRunicBrand:Play("mm6")--Blue Square
		elseif self.Options.RuneBehavior == "Minimap" then
			specWarnRunicBrand:Play("frontleft")
		else
			specWarnRunicBrand:Play("targetyou")
		end
	elseif spellId == 197967 and args:IsPlayer() then--Green box (N)
		specWarnRunicBrand:Show("|TInterface\\Icons\\Boss_OdunRunes_Green.blp:12:12|tN|TInterface\\Icons\\Boss_OdunRunes_Green.blp:12:12|t")
		if self.Options.RuneBehavior == "Entrance" then
			specWarnRunicBrand:Play("frontcenter")
		elseif self.Options.RuneBehavior == "Icon" then
			specWarnRunicBrand:Play("mm4")--Green Triangle
		elseif self.Options.RuneBehavior == "Minimap" then
			specWarnRunicBrand:Play("frontcenter")
		else
			specWarnRunicBrand:Play("targetyou")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 198396 then
		warnSpear:Show()
	elseif spellId == 201221 then--Summon Stormforged
		specWarnAdd:Show()
		specWarnAdd:Play("killmob")
		timerAddCD:Start()
	end
end

--"<1368.18 21:44:20> [CHAT_MSG_MONSTER_YELL] Most impressive! I never thought I would meet anyone who could match the Valarjar's strength... and yet here you stand.#Odyn###Odyn##0#0##0#1600#nil#0#false#false#false#false", -- [6314]
--About 3 seconds to trigger gossip, since RP is for when gossip becomes available
--"<1399.95 21:44:52> [DBM_Debug] StartCombat called by : ENCOUNTER_START. LastInstanceMapID is 1477#nil", -- [6329]
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.OdynRP or msg:find(L.OdynRP)) then
		self:SendSync("OdynRP")--Syncing to help unlocalized clients
	end
end

function mod:OnSync(msg, targetname)
	if msg == "OdynRP" and self:AntiSpam(10, 2) then
		timerRP:Start()
	end
end
