local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

a.BCM = {}
local bcm = a.BCM

local GetSpellBonusDamage = GetSpellBonusDamage
local GetSpellCritChance = GetSpellCritChance
local UnitDebuff = UnitDebuff
local UnitIsUnit = UnitIsUnit
local UnitSpellHaste = UnitSpellHaste
local floor = floor
local pairs = pairs
local select = select

------------------------------------------------------------------ Calculations
local function countDebuff(name, delay)
	local duration = 0
	if delay then
		duration = c.GetBusyTime(true)
	end
	return s.MyDebuffDuration(c.GetID(name)) > duration
end

function bcm.PredictDamage(delay, debug)
	local perTick = 0
	if countDebuff("Ignite", delay) then
		perTick = select(
			15, 
			UnitDebuff("target", s.SpellName(c.GetID("Ignite")), nil, "PLAYER"))
		perTick = .2 * perTick
	end
	
	local numTicks = floor(.5 + 10 * (1 + UnitSpellHaste("player") / 100))
	local crit = (GetSpellCritChance(3) - 1.8) / 100
	local total = perTick * numTicks * (1.055 * crit + 1)
	
	if debug then
		c.Debug("Combustion", "Num Ticks:", numTicks)
		c.Debug("Combustion", "Current Crit:", crit)
		c.Debug("Combustion", "Estimate Per Tick:", perTick)
		c.Debug("Combustion", "Total Estimate:", total)
	end
	return total, perTick, numTicks, crit
end

-------------------------------------------------------------------- The Window
local window = CreateFrame("Frame", nil, UIParent)
window:SetFrameStrata("HIGH")
window:SetSize(90, 25)
window:EnableMouse(true)
window:SetMovable(true)
window:RegisterForDrag("LeftButton")
window:CreateTitleRegion():SetAllPoints(true)

local function createLine(anchor)
	local line = window:CreateFontString()
	line:SetPoint(anchor)
	line:SetSize(window:GetWidth(), window:GetHeight() / 2)
	line:SetJustifyH("LEFT")
	line:SetFont("Fonts\\FRIZQT__.TTF", 10) 
	line:SetTextColor(1, 1, 1)
	return line
end

local line1 = createLine("TOP")
local line2 = createLine("BOTTOM")

local function saveWindowPosition()
	local settings = CombustionMonitorSettings
	if settings == nil then
		settings = {}
		CombustionMonitorSettings = settings
	end
	settings.WindowPoints = {}
	for i = 1, window:GetNumPoints() do
		local point, relativeTo, relativePoint, xoffset, yoffset
			= window:GetPoint(i)
		settings.WindowPoints[i] = {
			point = point,
			relativePoint = relativePoint,
			xoffset = xoffset,
			yoffset = yoffset }
	end
end

local function positionWindow()
	local settings = CombustionMonitorSettings
	if settings == nil then
		window:SetPoint("CENTER")
	else
		for _, point in pairs(settings.WindowPoints) do
			window:SetPoint(
				point.point,
				nil,
				point.relativePoint,
				point.xoffset,
				point.yoffset)
		end
	end
end

function bcm.UpdateVisibility()
	local hide = s.TalentMastery() ~= 2
		or not c.GetOption("FlashFire")
		or not c.GetOption("CombustionMonitor")
		or not s.GetModuleFlashable(addonName)
		or (s.config.in_combat_only and not s.InCombat())
	local isShowing = window:IsShown()
	if hide and isShowing then
		window:Hide()
	elseif not hide and not isShowing then
		window:Show()
	end
end
s.AddSettingsListener(a.UpdateBCMVisibility)

u.RegisterSlashCommand("bcm", "reset", function()
	CombustionMonitorSettings = nil
	positionWindow()
end)

local function updateWindow()
	if not window:IsShown() then
		return
	end
	
	local damage, perTick, numTicks, crit
		= bcm.PredictDamage(false, false)
	line1:SetText(floor(crit * 1000 + .5) / 10 .. "%   x" .. numTicks)
	line2:SetText(
		floor(damage / 1000) .. "K" 
			.. " (" .. floor(perTick / 1000 + .5) .. "K)")
end

updateWindow()

------------------------------------------------------------------------ Events
local logHandlers = {}

function logHandlers.SPELL_PERIODIC_DAMAGE(spellID, ...)
	if spellID == c.GetID("Combustion DoT") then
		local tick = select(15, ...)
		c.Debug("Combustion", "Acutal Combustion tick:", tick)
	end
end

function logHandlers.SPELL_CAST_SUCCESS(spellID, ...)
	if spellID == c.GetID("Combustion") then
		bcm.PredictDamage(false, true)
	end
end

logHandlers.SPELL_AURA_APPLIED = updateWindow
logHandlers.SPELL_AURA_REMOVED = updateWindow
logHandlers.SPELL_AURA_APPLIED_DOSE = updateWindow
logHandlers.SPELL_AURA_REMOVED_DOSE = updateWindow
logHandlers.SPELL_AURA_REFRESH = updateWindow
logHandlers.SPELL_AURA_BROKEN = updateWindow
logHandlers.SPELL_AURA_BROKEN_SPELL = updateWindow

local eventHandlers = {}

function eventHandlers.ADDON_LOADED(addonName)
	if addonName == addonName then
		positionWindow()
	end
end

eventHandlers.PLAYER_LOGOUT = saveWindowPosition
eventHandlers.UNIT_SPELLCAST_START = updateWindow
eventHandlers.UNIT_SPELLCAST_STOP = updateWindow
eventHandlers.UNIT_SPELLCAST_SUCCEEDED = updateWindow

function eventHandlers.COMBAT_LOG_EVENT_UNFILTERED(...)
	local source = select(5, ...)
	if source == nil or not UnitIsUnit(source, "player") then
		return
	end
	
	local event = select(2, ...)
	if logHandlers[event] then
		logHandlers[event](select(12, ...), ...)
	end
end

u.RegisterEventHandler(eventHandlers)
