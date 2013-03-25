local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "Events", 4) then
	return
end

local s = SpellFlashAddon

local GetActionInfo = GetActionInfo
local GetMacroSpell = GetMacroSpell
local GetNetStats = GetNetStats
local GetTime = GetTime
local UnitIsUnit = UnitIsUnit
local math = math
local next = next
local pairs = pairs
local print = print
local select = select
local tinsert = tinsert
local type = type
local wipe = wipe

local managedDots = { }
local registeredAddons = { }
local currentSpells = { }
--[[
	Name = "Localized Spell Name",
	Target = "Unit ID",
	ID = spellID, -- nil until CAST
	Status = "Queued/Casting/Channeling/Interrupted",
	Cost = Mana/Focus/etc cost, -- nil until CAST
	GCDStart = GetTime(),
	CastStart = GetTime(),
--]]

--local aoeDetectors = {}
--local aoeTime = 0
--local aoeSpell = 0
--local aoeCount = 0

-------------------------------------------------------------- Public Functions
c.LastGCD = 1.5

function c.RegisterForEvents()
	registeredAddons[c.A] = true
end

function c.ManageDotRefresh(name, unhastedTick, baseName)
	if baseName == nil then
		baseName = name
	end
	local spellID = c.GetID(baseName)
	if not managedDots[spellID] then
		managedDots[spellID] = {}
	end
	managedDots[spellID][c.GetSpell(name)] = unhastedTick
end

function c.GetCastingInfo()
	for _, info in pairs(currentSpells) do
		if info.Status == "Casting" or info.Status == "Channeling" then
			return info
		end
	end
end

function c.GetQueuedInfo()
	for _, info in pairs(currentSpells) do
		if info.Status == "Queued" then
			return info
		end
	end
end

local function nameMatches(info, name)
	return s.SpellName(c.GetID(name), true) == info.Name
end

function c.InfoMatches(info, ...)
	if info ~= nil then
		for i = 1, select("#", ...) do
			local name = select(i, ...)
			if type(name) == "table" then
				for _, name in pairs(name) do
					if nameMatches(info, name) then
						return true
					end
				end
			elseif nameMatches(info, name) then
				return true
			end
		end
	end
end

function c.IsQueued(...)
	for _, info in pairs(currentSpells) do
		if info.Status == "Queued" and c.InfoMatches(info, ...) then
			return true
		end
	end
end

function c.IsCasting(...)
	for _, info in pairs(currentSpells) do
		if c.InfoMatches(info, ...) then
			return true
		end
	end
end

--function c.RegisterAoEDetector(name)
--	aoeDetectors[c.GetID(name)] = true
--end

------------------------------------------------------------------ Travel Times
local metaTravelInfo = { }
local inFlight = { }
--[[
	[spellID][target] = { GetTime()* }
]]--
local pendingAura = { }
local pastTravelInfo = { }
--[[
	spellID = {
		LaunchTime = GetTime(),
		TravelTime = __,
	}
]]--

local travelEnders = {
	SPELL_DAMAGE = true,
	SPELL_MISSED = true,
-- These cause problem w/ spells that both deal damage and apply an aura, if
-- two are in the air (because then the first one lands, but consumes both
-- launches, and ends up w/ a ridiculously small travel time).
	SPELL_AURA_APPLIED = true,
	SPELL_AURA_REFRESH = true,
	SPELL_AURA_APPLIED_DOSE = true,
}

local function getTrimmed(table, max, spellID, target, magically)
	if magically then
		table = u.GetOrMakeTable(table, spellID, target)
	else
		table = u.GetFromTable(table, spellID, target)
		if table == nil then
			return nil
		end
	end
	
	local now = GetTime()
	for key, launch in pairs(table) do
		if now - launch > max then
			table[key] = nil
		end
	end
	return table
end

local function getTrimmedLaunches(spellID, target, magically)
	return getTrimmed(inFlight, 3, spellID, target, magically)
end

local function getTrimmedLandings(spellID, target, magically)
	return getTrimmed(pendingAura, 1, spellID, target, magically)
end

local function removeOldest(table, spellID, target)
	if table == nil then
		return nil
	end
	
	local min = nil
	local minKey = nil
	for key, launch in pairs(table) do
		if min == nil or launch < min then
			min = launch
			minKey = key
		end
	end
	if minKey then
		table[minKey] = nil
	end
	return min
end

local function startTravelTime(spellID, target)
	if target == nil then
		return
	end
	
--c.Debug("startTravelTime", s.SpellName(spellID), spellID, target, GetTime())
	tinsert(getTrimmedLaunches(spellID, target, true), GetTime())
end

local function runOnRelatedIDs(spellID, action)
	if action(spellID) then
		return true
	end
	
	local appliers = u.GetFromTable(c, "A", "AurasToSpells", "spellID")
	if appliers == nil then
		return false
	end
	
	for applierID, _ in pairs(appliers) do
		if action(applierID) then
			return true
		end
	end
	return false
end

local function endTravelTime(spellID, target, pendAura)
	if target == nil then
		return false
	end
	
--c.Debug("endTravelTime", s.SpellName(spellID), spellID, target, GetTime())
	return runOnRelatedIDs(spellID, function(spellID)
		local oldest = removeOldest(getTrimmedLaunches(spellID, target))
		if oldest == nil then
			return false
		end
		
		local now = GetTime()
		local travelInfo = u.GetOrMakeTable(pastTravelInfo, spellID)
		travelInfo.LaunchTime = oldest
		travelInfo.TravelTime = now - oldest
--c.Debug("endTravelTime", "   ", travelInfo.TravelTime, s.SpellName(spellID))
		
		if pendAura then
			tinsert(getTrimmedLandings(spellID, target, true), now)
		end
		return true
	end)
end

local function endAuraDelay(spellID, target)
	if target == nil then
		return
	end
	
--c.Debug("endAuraDelay", s.SpellName(spellID), spellID, target, GetTime())
	if endTravelTime(spellID, target, false) then
--c.Debug("endAuraDelay", "    ended travel", s.SpellName(spellID))
		return
	end
	
	runOnRelatedIDs(spellID, function(spellID)
		local oldest = removeOldest(getTrimmedLandings(spellID, target))
--if oldest then
--c.Debug("endAuraDelay", "   ", GetTime() - oldest, s.SpellName(spellID))
--else
--c.Debug("endAuraDelay", "    nothin", s.SpellName(spellID))
--end
		return oldest
	end)
end

local function estimateTravelTime(name)
	local metaInfo = metaTravelInfo[name]
	local lastTravel = metaInfo.Estimate
	local lastLaunch = 0
	local spellID = c.GetID(name)
	for _, id in pairs(metaInfo.IDs) do
		local pastInfo = pastTravelInfo[id]
		if pastInfo and pastInfo.LaunchTime > lastLaunch then
			lastLaunch = pastInfo.LaunchTime
			lastTravel = pastInfo.TravelTime
		end 
	end
	return lastTravel
end

local function incrementIfLanding(
	count, startDelay, endDelay, castDelay, travelTime)
	
	if castDelay == nil then
		return count
	end
	
	local landDelay = castDelay + travelTime
	if startDelay <= landDelay and landDelay < endDelay then
		return count + 1
	else
		return count
	end
end

function c.AssociateTravelTimes(estimate, ...)
	local info = {
		Estimate = estimate,
		IDs = c.GetIDs(...)
	}
	for i = 1, select("#", ...) do
		metaTravelInfo[select(i, ...)] = info
	end
end

function c.IsCastingOrInAir(name)
	if c.IsCasting(name) then
		return true
	end
	
	local spellID = c.GetID(name)
	if inFlight[spellID] then
		for target, _ in pairs(inFlight[spellID]) do
			if next(getTrimmedLaunches(spellID, target)) then
				return true
			end
		end
	end
end

function c.IsAuraPendingFor(name)
	if c.IsCastingOrInAir(name) then
		return true
	end
	
	local spellID = c.GetID(name)
	if pendingAura[spellID] then
		for target, _ in pairs(pendingAura[spellID]) do
			if next(getTrimmedLandings(spellID, target)) then
				return true
			end
		end
	end
end

function c.CountLandings(name, startDelay, endDelay, countNextCast)
--c.Debug("Lib", name)
	local count = 0
	local travel = estimateTravelTime(name)
	
	-- in the air
	local now = GetTime()
	local spellID = c.GetID(name)
	if inFlight[spellID] then
		for target, _ in pairs(inFlight[spellID]) do
			for _, launch in pairs(getTrimmedLaunches(spellID, target)) do
--c.Debug("CountLandings", name, "in air lands in", launch - now + travel, launch - now, travel)
				count = incrementIfLanding(
					count,
					startDelay,
					endDelay,
					launch - now,
					travel)
			end
		end
	end
	
	-- currently casting
	local castTime = c.GetCastTime(spellID)
	for _, info in pairs(currentSpells) do
		if c.InfoMatches(info, name) then
--c.Debug("CountLandings", name, "casting lands in", info.CastStart + castTime - now + travel)
			count = incrementIfLanding(
				count,
				startDelay,
				endDelay,
				info.CastStart + castTime - now,
				travel)
		end
	end
	
	-- will have time to cast
	if countNextCast then
--c.Debug("CountLandings", name, "next lands in", info.CastStart + castTime - now + travel)
		count = incrementIfLanding(
			count,
			startDelay,
			endDelay,
			c.GetBusyTime() + castTime,
			travel)
	end
	
	return count
end

function c.ShouldCastToRefresh(
	spellName, debuffName, earlyRefresh, willApplyDebuff, ...)
	
	if willApplyDebuff and c.IsAuraPendingFor(spellName) then
		return false
	end
	
	local duration = s.MyDebuffDuration(c.GetID(debuffName))
	if c.CountLandings(spellName, -3, duration) > 0 then
		return false
	end
	
	for i = 1, select("#", ...) do
		if c.CountLandings(select(i, ...), -3, duration) > 0 then
			return false
		end
	end
	
	local landing =
		c.GetBusyTime()
			+ c.GetCastTime(spellName)
			+ estimateTravelTime(spellName)
	return landing > duration - earlyRefresh + .1
		and (willApplyDebuff or landing < duration - .1)
end

----------------------------------------------------------------- Overlay Glows
local overlays = {}
local labButtons
local labScriptFrame

local function showOverlay(button)
	if not c.DisableProcHighlights then
		return
	end
	
	-- Hide the super-flashy Blizzard overlay
	if button.overlay then
		button.overlay:Hide()
	end
	
	if s.config.disable_default_proc_highlighting then
		return
	end
	
	-- And show a more subtle outline instead
	local overlay = overlays[button]
	if overlay == nil then
		local w, h = button:GetSize()
		overlay = button:CreateTexture(nil, 'OVERLAY')
		overlay:SetTexture('Interface\\Buttons\\UI-ActionButton-Border')
		overlay:SetBlendMode('ADD')
		overlay:SetSize(2.2 * w, 2.2 * h)
		overlay:SetPoint("CENTER", button)
		overlay:SetVertexColor(1, 0, 0)
		overlays[button] = overlay
	end
	overlay:Show()
end

local function hideOverlay(button)
	local overlay = overlays[button]
	if overlay then
		overlay:Hide()
	end
end

local function hookLAB(buttons)
	labButtons = buttons
	if labScriptFrame then
		labScriptFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
		labScriptFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
	else
		labScriptFrame = CreateFrame("frame")
		labScriptFrame:SetScript("OnEvent", function(self, event, spellId)
			if c.DisableProcHighlights then
				for button in next, buttons do
					if button:GetSpellId() == spellId and button.overlay then
						if event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" then
							showOverlay(button)
						else
							hideOverlay(button)
						end
					end
				end
			end
		end)
	end
	labScriptFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
	labScriptFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

local function doGlowHook(action, button)
	action(button)
end

hooksecurefunc("ActionButton_ShowOverlayGlow", function(button)
	showOverlay(button)
end)

hooksecurefunc("ActionButton_HideOverlayGlow", function(button)
	hideOverlay(button)
end)

------------------------------------------------------- Internal Event Handling
local frame = CreateFrame("frame")
frame:RegisterEvent("UNIT_SPELLCAST_SENT")
frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
frame:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
frame:RegisterEvent("UNIT_SPELLCAST_START")
--frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
--frame:RegisterEvent("UNIT_SPELLCAST_STOP")
frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("ADDON_LOADED")

local function fireEvent(functionName, ...)
	for a, _ in pairs(registeredAddons) do
		c.Init(a)
		local rotation = c.GetCurrentRotation()
		if rotation ~= nil and rotation[functionName] ~= nil then
			rotation[functionName](...)
		end
	end
end

local function handleLogEvent(...)
	local source = select(5, ...)
	if source == nil or not UnitIsUnit(source, "player") then
		return
	end
--c.Debug("Lib", ...)
	
	local event = select(2, ...)
	local targetID = select(8, ...)
	local target = select(9, ...)
	local spellID = select(12, ...)
	if spellID == nil then
		return
	end
	
	c.Debug("Log Event", event, target, spellID)
	if event == "SPELL_CAST_SUCCESS" then
		startTravelTime(spellID, target)
	elseif event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" then
		if event == "SPELL_DAMAGE" then
			endTravelTime(spellID, target, true)
		end
		
		local critical = select(21, ...)
--		if aoeDetectors[spellID] then
--			if GetTime() ~= aoeTime or spellID ~= aoeSpell then
--				aoeTime = GetTime()
--				aoeSpell = spellID
--				aoeCount = 0
--			end
--			aoeCount = aoeCount + 1
--		end
--c.Debug("Lib AoE", GetTime(), event, target, spellID)
		fireEvent(
			"SpellDamage",
			spellID,
			target,
			targetID,
			critical,
			event == "SPELL_PERIODIC_DAMAGE")
	elseif event == "SPELL_MISSED" then
		endTravelTime(spellID, target, false)
		fireEvent("SpellMissed", spellID, target, targetID)
	elseif event == "SPELL_AURA_APPLIED"
		or event == "SPELL_AURA_REFRESH"
		or event == "SPELL_AURA_APPLIED_DOSE" then
		
		endAuraDelay(spellID, target)
		fireEvent("AuraApplied", spellID, target, targetID)
	elseif event == "SPELL_AURA_REMOVED"
		or event == "SPELL_AURA_REMOVED_DOSE" then
	
		fireEvent("AuraRemoved", spellID, target, targetID)
	elseif event == "SPELL_HEAL" or event == "SPELL_PERIODIC_HEAL" then
		local amount = select(15, ...)
		local overheal = select(16, ...)
		fireEvent("SpellHeal", spellID, target, amount)
	elseif event == "SPELL_ENERGIZE" then
		local amount = select(15, ...)
		fireEvent("Energized", spellID, amount)
	end
end

local function printCurrentSpells()
	local list = ""
	for id, info in pairs(currentSpells) do
		c.Debug("Cast Event", "   ", id, info.Name,
			"Target:", info.Target,
			"ID:", info.ID or "?",
			"Status:", info.Status)
	end
end

s.AddSettingsListener(
	function()
		c.DisableProcHighlights = false
	end
)

local lastInfo
frame:SetScript("OnEvent", 
	function(self, event, ...)
		if event == "ADDON_LOADED" then
			local labButtons = u.GetFromTable(
				LibStub, "libs", "LibActionButton-1.0", "activeButtons")
			if labButtons then
				hookLAB(labButtons)
			end
			return
		end

		local gcd, totalGcd = s.GlobalCooldown()
		if totalGcd and totalGcd > 0 then
			c.LastGCD = totalGcd
		end
		 
		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			handleLogEvent(...)
			return
		end
		
		if event == "PLAYER_REGEN_ENABLED" then
			wipe(inFlight)
			wipe(pendingAura)
			wipe(pastTravelInfo)
			fireEvent("LeftCombat")
			return
		end
		
		local unitID = select(1, ...)
		local spell = select(2, ...)
		if unitID ~= "player" then
			return
		end
		
		c.Debug("Cast Event", event, spell)
		--c.Debug("Cast Event", event, ...)
		local info
		if event == "UNIT_SPELLCAST_SENT" then
			local target = select(4, ...)
			local lineID = select(5, ...)
			local gcdStart = GetTime() + s.GetCasting(nil, "player")
			local lag = select(3, GetNetStats()) / 1000
			info = {
				LineID = lineID,
				Name = spell,
				Target = target,
				Status = "Queued",
				GCDStart = gcdStart,
				CastStart = math.max(gcdStart, GetTime() + 2 * lag),
			}
			currentSpells[lineID] = info
			fireEvent("CastQueued", info)
			printCurrentSpells()
			return
		end
		
		local lineID = select(4, ...)
		local spellID = select(5, ...)
		info = currentSpells[lineID]
		if info == nil then
			if lastInfo ~= nil and lineID == lastInfo.LineID then
				info = lastInfo
			elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
				info = c.GetCastingInfo()
				if info == nil then
					c.Debug("Cast Event", "    no record of spell", lineID)
					printCurrentSpells()
					return
				end
				
				lineID = info.LineID
			else
				c.Debug("Cast Event", "    no record of spell", lineID)
				printCurrentSpells()
				return
			end 
		end
		lastInfo = info
		info.ID = spellID
		
--c.Debug("Cast Event", event, spell, spellID, lineID)
		if event == "UNIT_SPELLCAST_START" then
			info.Status = "Casting"
			info.Cost = s.SpellCost(info.Name)
			fireEvent("CastStarted", info)
			
		elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
			if info.Status ~= "Channeling" then
				if managedDots[info.ID] then
					for z, unhasted in pairs(managedDots[info.ID]) do
						local tick = c.GetHastedTime(unhasted)
						z.EarlyRefresh = tick
						c.Debug("Library", info.Name, "ticks every", tick)
					end
				end
				if s.Channeling(info.Name, "player") then
					-- If you re-start a channel of the same spell, there is 
					-- no event to clear the old channel out. Do that here.
					for id, cs in pairs(currentSpells) do
						if cs.Status == "Channeling" then
							currentSpells[id] = nil
						end
					end
					info.Status = "Channeling"
					info.Cost = s.SpellCost(info.Name)
					fireEvent("CastStarted", info)
				else
					fireEvent("CastSucceeded", info)
					currentSpells[lineID] = nil
				end
			end
			
		elseif event == "UNIT_SPELLCAST_FAILED"
			or event == "UNIT_SPELLCAST_FAILED_QUIET" then
			
			if info.Status == "Casting" then
				fireEvent(
					"CastFailed", info, event == "UNIT_SPELLCAST_FAILED_QUIET")
			end
			currentSpells[lineID] = nil
			
		elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
			if info.Status == "Interrupted" then
				fireEvent("CastFailed", info)
				currentSpells[lineID] = nil
			else
				info.Status = "Interrupted"
			end
		
		elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
			fireEvent("CastSucceeded", info)
			currentSpells[lineID] = nil
			
		else
			print(event, "unhandled")
		end
		
		printCurrentSpells()
	end
)
