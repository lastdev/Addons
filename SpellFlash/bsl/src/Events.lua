local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "Events", 1) then
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
local type = type

local managedDots = {}
local registeredAddons = {}
local currentSpells = {}
--[[
local template = {
	Name = "Localized Spell Name",
	Target = "Unit ID",
	ID = spellID, -- nil until CAST
	Status = "Queued/Casting/Channeling/Interrupted",
	Cost = "Mana/Focus/etc cost", -- nil until CAST
	GCDStart = GetTime(),
	CastStart = GetTime(),
}
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
	else
		labScriptFrame = CreateFrame("frame")
		labScriptFrame:SetScript("OnEvent", function(self, event, spellId)
			if c.DisableProcHighlights then
				for button in next, buttons do
					if button:GetSpellId() == spellId and button.overlay then
						button.overlay:Hide()
					end
				end
			end
		end)
	end
	labScriptFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
end

local function doGlowHook(action, button)
	action(button)
	if labButtons and button.action then
		local type, spellId = GetActionInfo(button.action)
		if type == "macro" then
			spellId = select(3, GetMacroSpell(spellId))
		end
		for button in next, labButtons do
			if button:GetSpellId() == spellId then
				action(button)
			end
		end
	end
end

hooksecurefunc("ActionButton_ShowOverlayGlow", function(button)
	doGlowHook(showOverlay, button)
end)

hooksecurefunc("ActionButton_HideOverlayGlow", function(button)
	doGlowHook(hideOverlay, button)
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
--c.Debug("Lib", event, target, spellID, spellSchool)
	if event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" then
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
		fireEvent("SpellMissed", spellID, target, targetID)
	elseif event == "SPELL_AURA_APPLIED"
		or event == "SPELL_AURA_REFRESH"
		or event == "SPELL_AURA_APPLIED_DOSE" then
		
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
		c.Debug("Lib", " ", id, info.Name,
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
			fireEvent("LeftCombat")
			return
		end
		
		local unitID = select(1, ...)
		local spell = select(2, ...)
		if unitID ~= "player" then
			return
		end
		
--c.Debug("Lib", event, spell)
--c.Debug("Lib", event, ...)
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
--printCurrentSpells()
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
--c.Debug("Lib", "  no record of spell", lineID)
--printCurrentSpells()
					return
				end
				
				lineID = info.LineID
			else
--c.Debug("Lib", "  no record of spell", lineID)
--printCurrentSpells()
				return
			end 
		end
		lastInfo = info
		info.ID = spellID
		
--c.Debug("Lib", event, spell, spellID, lineID)
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
--printCurrentSpells()
	end
)
