local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetSpellLink = GetSpellLink
local GetTime = GetTime
local GetUnitName = GetUnitName
local SendChatMessage = SendChatMessage
local UnitExists = UnitExists
local UnitInRange = UnitInRange
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsUnit = UnitIsUnit
local select = select
local string = string

a.Rotations = {}

local oorTime = {}
local oorCount = {}
local announceTimes = {}
local lastRapture = 0
local shieldBurst = 0

local function healingNeeded()
	for unit in c.GetGroupMembers() do
		if s.HealthPercent(unit) < c.GetOption("HealPercent")
			and (UnitInRange(unit) or UnitIsUnit(unit, "player"))
			and not UnitIsDeadOrGhost(unit) then
			
			return true
		end
	end
end

local function getMessage(name)
	local message = c.GetOption("Announcement")
	if name then
		message = string.gsub(message, "<player>", name)
		message = string.gsub(message, "<Player>", name)
		message = string.gsub(message, "<is/are>", L["is"])
	else
		message = string.gsub(message, "<player>", L["you"])
		message = string.gsub(message, "<Player>", L["You"])
		message = string.gsub(message, "<is/are>", L["are"])
	end
	message = string.gsub(
		message, "<Atonement>", GetSpellLink(c.GetID("Atonement")))
	return message
end

local function announceFor(name)
	local now = GetTime()
	local last = announceTimes[name]
	if last ~= nil and now - last < 6 then
		return
	end
	
	if not c.GetOption("InParty") and s.InParty() then
		SendChatMessage(getMessage(name), "PARTY")
	end
	if c.GetOption("InSay") then
		SendChatMessage(getMessage(name))
	end
	if c.GetOption("InWhisper") then
		SendChatMessage(getMessage(), "WHISPER", nil, name)
	end
	announceTimes[name] = now
end

local function announceUnder(percentage)
	for unit in c.GetGroupMembers() do
		local p = s.HealthPercent(unit)
		local name = string.gsub(GetUnitName(unit, true), " ", "", 2)
		if p / 100 < percentage
			and UnitInRange(unit)
			and not UnitIsDeadOrGhost(unit) then
			
			c.Debug("Announce", name, p, "<", percentage)
			local count = oorCount[name]
			if count == nil then
				count = 1
			else
				count = count + 1
			end
			local now = GetTime()
			if count > 2 and now - oorTime[name] < 3 then
				announceFor(name)
			end
			oorCount[name] = count
			oorTime[name] = now
		else
			oorCount[name] = nil
		end
	end
end

a.Rotations.Atonement = {
	Spec = 1,
	
	FlashInCombat = function()
		local now = GetTime()
		if s.MyBuff(c.GetID("Power Word: Shield"), a.ShieldTarget) then
			shieldBurst = now
		end
		a.HealingNeeded = healingNeeded()
		a.Mana = 
			100 * c.GetPower(select(2, GetPowerRegen())) / s.MaxPower("player")
		
		local conserve = a.Mana < c.GetOption("ConservePercent")
		if conserve then
			if (now - lastRapture > 12 and now - shieldBurst > 2) then
				c.FlashAll("Power Word: Shield")
			end
		end
		c.FlashAll("Shadowfiend", "Mindbender")
		
		if not a.HealingNeeded 
			and a.Mana < c.GetOption("OnlyHealPercent") then
			
			c.PriorityFlash("Power Word: Solace")
			return
		end
		
		c.FlashAll("Power Infusion")
		if conserve then
c.Debug("Flash", a.Mana, a.HealingNeeded, "Conservative",
			c.PriorityFlash(
				"Power Word: Solace",
				"Penance",
				"Holy Fire",
				"Shadow Word: Death",
				"Smite Glyphed",
				"Shadow Word: Pain",
				"Smite")
)
		else
c.Debug("Flash", a.Mana, a.HealingNeeded, "All Out",
			c.PriorityFlash(
				"Shadow Word: Death",
				"Penance",
				"Shadow Word: Pain",
				"Power Word: Solace",
				"Holy Fire",
				"Smite")
)
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Power Word: Fortitude", "Inner Fire")
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Power Word: Shield") then
			a.ShieldTarget = info.Target
			c.Debug("Event", "PW:S on", a.ShieldTarget)
		end
	end,
	
	SpellHeal = function(spellID, target, amount)
		if not s.InRaid()
			and c.IdMatches(spellID, "Atonement", "Power Word: Solace Heal")
			and UnitExists(target) then
			
			announceUnder((s.Health(target) - amount) / s.MaxHealth(target))
		end
	end,
	
	Energized = function(spellID)
		if spellID == c.GetID("Rapture") then
			lastRapture = GetTime()
			shieldBurst = 0
			c.Debug("Event", "Rapture!")
		end
	end,
	
	LeftCombat = function()
		oorTime = {}
		oorCount = {}
		announceTimes = {}
		c.Debug("Event", "Clearing announcement history")
	end
}
