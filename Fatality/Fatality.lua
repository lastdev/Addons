Fatality = CreateFrame("Frame")
Fatality.title = GetAddOnMetadata("Fatality", "Title")
Fatality.version = GetAddOnMetadata("Fatality", "Version")

local L = Fatality_Locales

local output1, output2
local count, event_history = 0, 0
local raid_output, party_output
local character, history, now
local instance, limit

local rt, rt_path = "{rt%d}", "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d.blp:0|t"
local rt_1, rt_mask, player_flag = COMBATLOG_OBJECT_RAIDTARGET1, COMBATLOG_OBJECT_RAIDTARGET_MASK, COMBATLOG_OBJECT_TYPE_PLAYER

local damage_events = { ["SPELL_DAMAGE"] = true, ["SPELL_PERIODIC_DAMAGE"] = true, ["RANGE_DAMAGE"] = true, ["DAMAGE_SPLIT"] = true, ["DAMAGE_SHIELD"] = true }
local miss_events = { ["SPELL_MISSED"] = true, ["SPELL_PERIODIC_MISSED"] = true, ["RANGE_MISSED"] = true, ["DAMAGE_SHIELD_MISSED"] = true }
local characters, extra, spirits = {}, {}, {}

local BUFFER = 2
local DEATH = GetSpellLink(41220)
local FEIGN = GetSpellInfo(5384)

-- Upvalues
local UnitInRaid, UnitInParty, UnitExists = UnitInRaid, UnitInParty, UnitExists
local UnitClass, UnitHealthMax, UnitBuff = UnitClass, UnitHealthMax, UnitBuff
local format, match, concat = string.format, string.match, table.concat
local GetTime, wipe, type, band = GetTime, wipe, type, bit.band

Fatality:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

local function printf(s,...)
	print("|cff39d7e5Fatality:|r " .. s:format(...))
end

local function strip(name)
	if not (UnitInParty(name) or UnitInRaid(name)) then return name end
	return match(name ,"[^-]*")
end

local function colour(name)
	if (instance == "raid" and output1 ~= "SELF") or (instance == "party" and output2 ~= "SELF") then
		return strip(name)
	elseif not UnitIsFriend("player", name) then
		return format("|cffff0000%s|r", strip(name))
	end
	local _, class = UnitClass(name)
	local c = _G["RAID_CLASS_COLORS"][class]
	return format("|cff%02x%02x%02x%s|r", c.r*255, c.g*255, c.b*255, strip(name))
end

local function icon(flag)
	if not FatalityDB.icons then return "" end
	local number, mask, mark
	if band(flag, rt_mask) ~= 0 then
		for i=1,8 do
			mask = rt_1 * (2 ^ (i - 1))
			mark = band(flag, mask) == mask
			if mark then number = i break end
		end
	end
	return number and (((instance == "raid" and output1 == "SELF") or (instance == "party" and output2 == "SELF")) and format(rt_path, number) or format(rt, number)) or ""
end

local function send(message)
	if instance == "raid" then
		if output1 == "SELF" then
			print(message)
		else
			if FatalityDB.promoted and not (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then return end
			SendChatMessage(message, output1, nil, raid_output)
		end
	elseif instance == "party" then
		if output2 == "SELF" then
			print(message)
		else
			SendChatMessage(message, output2, nil, party_output)
		end
	end
end

local function shorten(n)
	if not FatalityDB.short then return n end
	if type(n) ~= "number" then n = tonumber(n) end
	if n >= 10000000 then
		return format("%.1fM", n/1000000)
	elseif n >= 1000000 then
		return format("%.2fM", n/1000000)
	elseif n >= 100000 then
		return format("%.fk", n/1000)
	elseif n >= 1000 then
		return format("%.1fk", n/1000)
	else
		return n
	end
end

local function shuffle(t)
	for i=1,#t-1 do
		t[i].srcName = t[i+1].srcName
		t[i].srcRaidFlags = t[i+1].srcRaidFlags
		t[i].spellID = t[i+1].spellID
		t[i].environment = t[i+1].environment
		t[i].amount = t[i+1].amount
		t[i].overkill = t[i+1].overkill
		t[i].resist = t[i+1].resist
		t[i].absorb = t[i+1].absorb
		t[i].block = t[i+1].block
		t[i].crit = t[i+1].crit
		t[i].school = t[i+1].school
	end
end

function Fatality:HandleSpiritDeath(guid, name, flags)
	spirits[guid] = CreateFrame("frame")
	spirits[guid].elapsed = 0
	spirits[guid]:SetScript("OnUpdate", function(self, e)
		self.elapsed = self.elapsed + e
		if self.elapsed > 0.5 then
			self:SetScript("OnUpdate", nil)
			Fatality:ReportDeath(guid, name, flags)
		end
	end)
end

function Fatality:FormatOutput(guid)

	local c = characters[guid]
	
	local name = format("%s%s%s", icon(c.flags), colour(c.name), spirits[guid] and "*" or "")
	
	-- If the last damage event:
	--  (1) Contains no overkill
	--  (2) Is greater than BUFFER seconds before death
	-- Then assume the cause of death is Unknown
	if not c.time or (c[1].overkill < 0 and GetTime() - c.time > BUFFER) then
		return L.death:format(name, DEATH)
	end
	
	local source, info, full = "", "", ""
	
	for i=1,#c do
	
		local e = c[i]

		if self.db.source then
			source = e.srcName and format(" [%s%s]", icon(e.srcRaidFlags), colour(e.srcName)) or format(" [%s]", L.unknown)
		end

		local ability = e.spellID and GetSpellLink(e.spellID) or e.environment or L.damage_melee
		
		if e.amount > 0 then
			wipe(extra)
			
			local amount = self.db.overkill and e.amount - e.overkill or e.amount
			amount = (self.db.history == i and e.overkill < 0 and "~"..shorten(amount)) or shorten(amount)
			
			local school = self.db.school and e.spellID and format("%s ", CombatLog_String_SchoolString(e.school)) or ""
			
			if self.db.overkill and e.overkill > 0 then	extra[#extra + 1] = L.damage_overkill:format(shorten(e.overkill)) end
			if self.db.resist and e.resist > 0 then extra[#extra + 1] = L.damage_resist:format(shorten(e.resist)) end
			if self.db.absorb and e.absorb > 0 then extra[#extra + 1] = L.damage_absorb:format(shorten(e.absorb)) end
			if self.db.block and e.block > 0 then extra[#extra + 1] = L.damage_block:format(shorten(e.block)) end
			
			if not e.environment then
				-- SPELL_MISSED, SPELL_PERIODIC_MISSED, RANGE_MISSED, DAMAGE_SHIELD_MISSED
				-- SPELL_DAMAGE, SPELL_PERIODIC_DAMAGE, RANGE_DAMAGE, SWING_DAMAGE, DAMAGE_SHIELD, DAMAGE_SPLIT
				info = format("%s %s%s%s%s%s", amount, school, ability, #extra > 0 and format(" (%s)", concat(extra, ", ")) or "", e.crit and format(" %s", L.damage_critical) or "", source)
			else
				-- ENVIRONMENTAL_DAMAGE
				info = format("%s %s", amount, ability)
			end
		else
			-- SPELL_INSTAKILL
			info = ability
		end
		full = format("%s%s%s", full, info, c[i+1] and " + " or "")
	end
	
	local msg = L.death:format(name, full)
	if msg:len() > 255 and ((instance == "raid" and output1 ~= "SELF") or (instance == "party" and output2 ~= "SELF")) then
		printf(format(L.error_report, name))
		return
	end
	return msg
	
end

function Fatality:RecordDamage(srcName, srcRaidFlags, destGUID, destName, destRaidFlags, spellID, environment, amount, overkill, resist, absorb, block, crit, school)
	
	now = GetTime()
	
	character = self:SetCharacterTable(destGUID, destName, destRaidFlags)
	character.time = now
		
	if self.db.history == 1 then
		event_history = 1
	elseif #character < self.db.history then
		event_history = #character + 1
	else
		shuffle(character)
		event_history = self.db.history
	end
	
	if not character[event_history] then character[event_history] = {} end
	
	history = character[event_history]
	
	-- If there's been a recent (non-environmental) overkill event, ignore any folowing events for the next BUFFER seconds.
	-- This should prevent damage events which occur immediately after an overkill being erroneously reported as the killing blow.
	if event_history == 1 and overkill < 0 and not history.environment and history.overkill and history.overkill >= 0 and now - character.time < BUFFER then
		return
	end

	history.srcName = srcName
	history.srcRaidFlags = srcRaidFlags
	history.spellID = spellID
	history.environment = environment
	history.amount = amount
	history.overkill = overkill or -1
	history.resist = resist or 0
	history.absorb = absorb or 0
	history.block = block or 0
	history.crit = crit
	history.school = school
	
end

function Fatality:SetCharacterTable(destGUID, destName, destRaidFlags)
	if not characters[destGUID] then characters[destGUID] = {} end
	characters[destGUID].guid = destGUID
	characters[destGUID].name = destName
	characters[destGUID].flags = destRaidFlags
	return characters[destGUID]
end

function Fatality:UpdateTime(guid)
	if characters[guid] then characters[guid].time = GetTime() end
end

function Fatality:ReportDeath(guid, name, flags)
	if count < limit then
		local c = self:SetCharacterTable(guid, name, flags)
		local report = self:FormatOutput(guid)
		if report then
			send(report)
			count = count + 1
			wipe(c)
		end
	end
end

function Fatality:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
	
	if band(destFlags, player_flag) == 0 then return end
	
	if not (UnitInRaid(destName) or UnitInParty(destName)) then return end
	
	local spellID, amount, overkill, environment, crit, school, resist, block, absorb, miss
	
	if damage_events[event] then
		spellID, _, school, amount, overkill, _, resist, block, absorb, crit = ...
	elseif event == "SWING_DAMAGE" then
		amount, overkill, school, resist, block, absorb, crit = ...
	elseif event == "SPELL_INSTAKILL" then
		spellID = ...
		amount, overkill = -1, 0
	elseif event == "ENVIRONMENTAL_DAMAGE" then
		environment, amount, overkill, _, resist, block, absorb, crit = ...
	elseif event == "SPELL_HEAL" then
		spellID = ...
		if spellID == 27827 then self:HandleSpiritDeath(destGUID, destName, destRaidFlags) end
	elseif event == "UNIT_DIED" and not UnitBuff(destName, FEIGN) then
		if spirits[destGUID] then
			spirits[destGUID] = nil
			return
		end
		self:ReportDeath(destGUID, destName, destRaidFlags)
	end
	
	if amount then
		if amount >= self.db.threshold or amount == -1 then
			self:RecordDamage(srcName, srcRaidFlags, destGUID, destName, destRaidFlags, spellID, environment, amount, overkill, resist, absorb, block, crit, school)
		else
			self:UpdateTime(destGUID)
		end
	elseif spirits[destGUID] and miss_events[event] then
		spellID, _, school, miss, _, amount = ...
		if miss == "ABSORB" and amount >= self.db.threshold then
			self:RecordDamage(srcName, srcRaidFlags, destGUID, destName, destRaidFlags, spellID, nil, amount, amount - UnitHealth(destName), 0, 0, 0, nil, school)
		end
	end

end

function Fatality:ClearData()
	if not (InCombatLockdown() or UnitIsDeadOrGhost("player")) then
		count = 0
		wipe(spirits)
		wipe(characters)
	end
end

function Fatality:UpdateOutputSettings()
	output1 = self.db.output1
	output2 = self.db.output2
	if not IsInGroup(2) then
		if IsInRaid() then
			if output1 == "INSTANCE_CHAT" then output1 = "RAID" end
			if output2 == "INSTANCE_CHAT" then output2 = "RAID" end
		elseif IsInGroup(1) then
			if output1 == "INSTANCE_CHAT" then output1 = "PARTY" end
			if output2 == "INSTANCE_CHAT" then output2 = "PARTY" end
		end
	end
	raid_output  = (output1 == "CHANNEL" and GetChannelName(self.db.channel1)) or (output1 == "WHISPER" and self.db.whisper1)
	party_output = (output2 == "CHANNEL" and GetChannelName(self.db.channel2)) or (output2 == "WHISPER" and self.db.whisper2)
end

function Fatality:RegisterEvents()
	self:ClearData()
	self:UpdateOutputSettings()
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
end

function Fatality:UnregisterEvents()
	self:ClearData()
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
end

function Fatality:CheckEnable()
	if not FatalityStatusDB.enabled then
		self:UnregisterEvents()
		return
	end
	instance = select(2, IsInInstance())
	if (self.db.raid and instance == "raid") or (self.db.party and instance == "party") then
		if not self.db.lfr and instance == "raid" and IsPartyLFG() and IsInLFGDungeon() then
			self:UnregisterEvents()
			return
		end
		local _, _, difficulty = GetInstanceInfo()
		limit = (difficulty == 3 or difficulty == 5) and self.db.limit10 or self.db.limit25
		self:RegisterEvents()
	else
		self:UnregisterEvents()
	end
end

function Fatality:PLAYER_REGEN_DISABLED()
	self:ClearData()
end

function Fatality:PLAYER_ENTERING_WORLD()
	self:CheckEnable()
end

function Fatality:ZONE_CHANGED_NEW_AREA()
	self:CheckEnable()
end

function Fatality:CreateSlashCommands()
	SLASH_FATALITY1, SLASH_FATALITY2 = "/fatality", "/fat"
	SlashCmdList.FATALITY = function(cmd)
		cmd = cmd:gsub(" ", ""):lower()
		if cmd == "on" or cmd == "off" then
			FatalityStatusDB.enabled = cmd == "on"
			printf(cmd == "on" and L.addon_enabled or L.addon_disabled)
			if FatalityOptions then FatalityOptions.enableButton:SetChecked(FatalityStatusDB.enabled) end
			self:CheckEnable()
		else
			if not FatalityOptions then
				printf(L.error_options)
			else
				if FatalityOptions:IsShown() then
					FatalityOptions:Hide()
				else
					FatalityOptions:ShowOptions()
				end
			end
		end
	end
end

function Fatality:ADDON_LOADED(addon)

	if addon ~= "Fatality" then return end
	
	local defaults = {
		first = true,
		promoted = false,
		lfr = true,
		raid = true,
		party = true,
		overkill = true,
		resist = false,
		absorb = false,
		block = false,
		source = true,
		school = true,
		short = true,
		icons = true,
		limit10 = 5,
		limit25 = 10,
		output1 = "INSTANCE_CHAT",
		channel1 = L.config_channel_default,
		whisper1 = L.config_whisper_default,
		output2 = "INSTANCE_CHAT",		
		channel2 = L.config_channel_default,
		whisper2 = L.config_whisper_default,
		history = 1,
		threshold = 5000,
	}
	
	local global_defaults = {
		enabled = true,
	}
	
	FatalityDB = FatalityDB or {}
	for k,v in pairs(defaults) do
		if FatalityDB[k] == nil then
			FatalityDB[k] = v
		end
	end
	
	FatalityStatusDB = FatalityStatusDB or {}
	for k,v in pairs(global_defaults) do
		if FatalityStatusDB[k] == nil then
			FatalityStatusDB[k] = v
		end
	end
	
	self.db = FatalityDB
	
	self:CreateSlashCommands()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	
end

Fatality:RegisterEvent("ADDON_LOADED")