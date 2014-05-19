local _, class = UnitClass("player")
if class ~= "MONK" then
	return
end

local addonName, a = ...
local L = a.Localize
local u = BittensGlobalTables.GetTable("BittensUtilities")

local GetSpecialization = GetSpecialization
local GetTime = GetTime
local IsAltKeyDown = IsAltKeyDown
local PlaySoundFile = PlaySoundFile
local UnitAura = UnitAura
local UnitDebuff = UnitDebuff
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsUnit = UnitIsUnit
local UnitStagger = UnitStagger
local math = math
local select = select
local string = string
local tonumber = tonumber
local tostring = tostring

local color
local show = false
local HIDE = 0
local SHOW = 1
local TOGGLE = 2
local SPECIALIZATION = 3
local STAGGER = 124255
local STAGGER_DEBUFFS = {
	[124275] = true, -- Light
	[124274] = true, -- Moderate
	[124273] = true, -- Heavy
}

local StaggerMeterMainFrame
local StaggerMeterMaxPctFrame
local StaggerMeterCurrentPctFrame
local StaggerMeterTextFrame
local StaggerFrameIcon

local function getStaggerAmount()
	for i = 1, 40 do
		local _, _, _, _, _, _, _, _, _, _, spellID, _, _, _, amount = 
			UnitDebuff("player", i)
		if STAGGER_DEBUFFS[spellID] then
			return amount
		end
	end
	return 0
end

local function setBackdrop(frame, backdrop, tile, bigger)
	local size = bigger and 16 or 4
	local inset = bigger and 4 or .5
	frame:SetBackdrop({ 
		bgFile = backdrop,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = tile, 
		tileSize = size, 
		edgeSize = size, 
		insets = { left = inset, right = inset, top = inset, bottom = inset } 
	})
end

--[[-------------------------------------]]
--[[									 ]]
--[[ SM_DisplayText --					 ]]
--[[	displays the damage and percents ]]
--[[									 ]]
--[[-------------------------------------]]

local function appendText(
	text, flag, numerator, denominator, significantDigits, label)
	
	if not a.GetOption(flag) then
		return text
	end
	
	if text:len() > 0 then
		text = text .. ", "
	end
	local number
	if denominator == 0 then
		number = 0
	else
		number = numerator / denominator
	end
	return text .. u.ToCondensedString(number, significantDigits) .. label
end

function a.SM_DisplayText(perSec, total, currentHealth, maxHealth)
-- 	print("SM_DisplayText", perSec, total, currentHealth, maxHealth)
	if currentHealth == 0 then currentHealth = 1 end
	if maxHealth == 0 then maxHealth = 1 end
	local text = ""
	text = appendText(
		text, "DisplayTotalDamage", total, 1, 2, 
		" " .. L["d"])
	text = appendText(
		text, "DisplayDPS", perSec, 1, 2, 
		" " .. L["d/s"])
	text = appendText(
		text, "DisplayPercentOfCurrent", 100 * total, currentHealth, 2, 
		"% " .. L["h"])
	text = appendText(
		text, "DisplayDPSPercentOfCurrent", 100 * perSec, currentHealth, 2, 
		"% " .. L["h/s"])
	text = appendText(
		text, "DisplayPercentOfMax", 100 * total, maxHealth, 2, 
		"% " .. L["mh"])
	text = appendText(
		text, "DisplayDPSPercentOfMax", 100 * perSec, maxHealth, 2, 
		"% " .. L["mh/s"])
	text = appendText(
		text, "DisplaySecondsRemaining", total, perSec, 1, 
		L["s"])
	StaggerMeterTextFrame:SetText(text)
end


--[[---------------------------------------]]
--[[									   ]]
--[[ updateIcon --					       ]]
--[[	Sets the color of the Stagger icon ]]
--[[									   ]]
--[[---------------------------------------]]
function a.PlaySound(sound)
	if sound ~= "None" then
		PlaySoundFile(
			"Interface\\AddOns\\StaggerMeter\\sounds\\" .. sound .. ".mp3", 
			"MASTER")
	end
end

local function updateIcon(newColor, sound)
	if newColor == color then
		return
	end
	
	-- play a sound if appropriate
	a.PlaySound(sound)
	
	-- change the icon itself
	color = newColor
	if newColor == "yellow" then
		newColor = "" --yellow does not appear in the yellow icon name
	else
		newColor = "_"..color
	end
	setBackdrop(StaggerFrameIcon, 
		"Interface/ICONS/Priest_icon_Chakra" .. newColor, false)
end


--[[------------------------------------]]
--[[									]]
--[[ SM_ShowHide(toggle) --			 ]]
--[[	Show Meter when Tanking. Hide   ]]
--[[	When Not. Toggle will turn on   ]]
--[[	if off and off if on.		   ]]
--[[	0 = Hide						]]
--[[	1 = Show						]]
--[[	2 = Toggle						]]
--[[	3 = Specialization-based		]]
--[[									]]
--[[------------------------------------]]
function a.SM_ShowHide(hideShowToggle)
	if hideShowToggle == TOGGLE then
		show = not show
	elseif hideShowToggle == SPECIALIZATION then
		show = GetSpecialization() == 1
			and (not a.GetOption("HideWhenNotStaggering") 
				or getStaggerAmount() > 0)
	elseif hideShowToggle == SHOW then
		show = true
	elseif hideShowToggle == HIDE then
		show = false
	end
	
	if show then
		StaggerMeterTextFrame:Show()
		StaggerFrameIcon:Show()
		if a.GetOption("MeterWidth") > 20 then
			StaggerMeterMainFrame:Show()
			StaggerMeterMaxPctFrame:Show()
			StaggerMeterCurrentPctFrame:Show()
		end
	else
		StaggerMeterMainFrame:Hide()
		StaggerMeterMaxPctFrame:Hide()
		StaggerMeterCurrentPctFrame:Hide()
		StaggerMeterTextFrame:Hide()
		StaggerFrameIcon:Hide()
	end
end


--[[------------------------------------]]
--[[									]]
--[[ ClearMeter --						]]
--[[	Clears the meter				]]
--[[									]]
--[[------------------------------------]]
local function clearMeter()
	if a.GetOption("HideWhenNotStaggering") then
		a.SM_ShowHide(HIDE)
	end
	a.SM_DisplayText(0, 0, 0, 0)
	setBackdrop(StaggerFrameIcon, 
		"Interface/ICONS/Priest_icon_Chakra_green", false)
	
	local height = a.GetOption("MeterHeight") - 4
	StaggerMeterCurrentPctFrame:SetSize(1, height)
	StaggerMeterMaxPctFrame:SetSize(1, height)
end


--[[------------------------------------]]
--[[									]]
--[[ updateMeter --					 	]]
--[[	Determines amount of damage		]]
--[[	being staggered and updates		]]
--[[	the meter and icon				]]
--[[									]]
--[[------------------------------------]]
local function fillMeter(frame, percent)
	frame:SetWidth(math.min(percent, 1) * (a.GetOption("MeterWidth") - 8))
end

local function updateMeter()
	local perSec = getStaggerAmount()
	if perSec == 0 then
--~ 		print("Not staggering. Clearing meter")
		clearMeter()
		return
	end

	-- Text
	local health = UnitHealth("player")
	local maxHealth = UnitHealthMax("player")
	local total = UnitStagger("player")
	if total == 0 and perSec > 0 then
		total = perSec * 10
	end
	a.SM_DisplayText(perSec, total, health, maxHealth)
	
	-- Icon
	local numerator = 
		a.GetOption("TurnOnPeriod") == "total" and total or perSec
	local denominator = 
		a.GetOption("TurnOnPercentOf") == "max" and maxHealth or health
	local percent = numerator / denominator * 100
	if percent < a.GetOption("TurnYellow") then
		updateIcon("green", "None")
	elseif percent < a.GetOption("TurnRed") then
		updateIcon("yellow", a.GetOption("YellowSound"))
	else
		updateIcon("red", a.GetOption("RedSound"))
	end
	
	-- Meter
	local numerator = a.GetOption("MeterFill") == "dps" and perSec or total
	fillMeter(StaggerMeterCurrentPctFrame, numerator / health)
	fillMeter(StaggerMeterMaxPctFrame, numerator / maxHealth)

	if a.GetOption("HideWhenNotStaggering") then
		a.SM_ShowHide(SHOW)
	end
end


--[[-------------------]]
--[[				   ]]
--[[ SM_PositionFrames ]]
--[[				   ]]
--[[-------------------]]
function a.SM_PositionFrames()
	local width = a.GetOption("MeterWidth")
	local height = a.GetOption("MeterHeight")
	local movable = not a.GetOption("MeterLock")
	local clickable = a.GetOption("RightClick")
	
	StaggerFrameIcon:SetSize(height, height)
	StaggerFrameIcon:EnableMouse(movable or clickable)
	StaggerFrameIcon:RegisterForDrag(movable and "LeftButton")
	
	StaggerMeterTextFrame:ClearAllPoints()
	if width < 20 then
		StaggerMeterMainFrame:Hide()
		StaggerMeterCurrentPctFrame:Hide()
		StaggerMeterMaxPctFrame:Hide()
		StaggerMeterTextFrame:SetParent(StaggerFrameIcon)
		StaggerMeterTextFrame:SetPoint("BOTTOM", 0, -10)
	else
		StaggerMeterMainFrame:Show()
		StaggerMeterTextFrame:Show()
		StaggerMeterCurrentPctFrame:Show()
		StaggerMeterMaxPctFrame:Show()
		StaggerMeterMainFrame:SetSize(width, height)
		StaggerMeterTextFrame:SetParent(StaggerMeterMainFrame)
		StaggerMeterTextFrame:SetPoint("CENTER", 0, 0)
	end
	updateMeter()
end


--[[---------------]]
--[[			   ]]
--[[ SET UP FRAMES ]]
--[[			   ]]
--[[---------------]]
local function createBar(r, g, b)
	local frame = CreateFrame("Frame", nil, StaggerMeterMainFrame)
	setBackdrop(frame, "Interface/ChatFrame/ChatFrameBackground", true)
	frame:SetBackdropBorderColor(0, 0, 0, 0)
	frame:SetBackdropColor(r, g, b, 1)
	frame:SetPoint("TOPLEFT", 4, -2)
	frame:SetPoint("BOTTOM", 0, 2)
	
	local texture = frame:CreateTexture(nil, "BORDER")
	texture:SetAllPoints(frame)
	texture:SetTexture(0, 1, 0, 1)
	texture:SetGradientAlpha("Vertical", 0, 0, 0, 1, 0, 0, 0, 0.2)
	
	return frame
end

local function initFrames()
	StaggerFrameIcon = CreateFrame("Frame", "StaggerFrameIcon", UIParent)
	setBackdrop(StaggerFrameIcon, "Interface/ICONS/Priest_icon_Chakra_green")
	StaggerFrameIcon:SetPoint("CENTER")
	StaggerFrameIcon:SetMovable(true)
	StaggerFrameIcon:SetScript("OnDragStart", function(self)
		if IsAltKeyDown() then
			self:StartMoving()
		end
	end)
	StaggerFrameIcon:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)
	StaggerFrameIcon:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" and a.GetOption("RightClick") then
			a.ToggleOptions()
		end
	end)
		
	StaggerMeterMainFrame = CreateFrame("Frame", nil, StaggerFrameIcon)
	setBackdrop(StaggerMeterMainFrame, 
		"Interface/Tooltips/UI-Tooltip-Background", true, true)
	StaggerMeterMainFrame:SetBackdropColor(0, 1, 0, 0.1)
	StaggerMeterMainFrame:SetPoint("LEFT", StaggerFrameIcon, "RIGHT", 2, 0)
	StaggerMeterCurrentPctFrame = createBar(1, 0, 0)
	StaggerMeterMaxPctFrame = createBar(0, 0, 1)

	if a.GetOption("MeterWidth") < 20 then
		StaggerMeterTextFrame = CreateFrame("Button", nil, StaggerFrameIcon)
	else
		StaggerMeterTextFrame = CreateFrame("Button", nil, StaggerMeterMainFrame)
	end
	setBackdrop(StaggerMeterTextFrame,
		"Interface/ChatFrame/ChatFrameBackground", true)
	StaggerMeterTextFrame:SetSize(1, 1)
 	StaggerMeterTextFrame:SetBackdropColor(0, 0, 0, 0)
 	StaggerMeterTextFrame:SetBackdropBorderColor(0, 0, 0, 0)
	StaggerMeterTextFrame:SetNormalFontObject("GameFontWhite");
	a.SM_DisplayText(0, 0, 0, 0)
	StaggerMeterTextFrame:Disable()

 	StaggerMeterTextFrame:SetFrameLevel(4)
	StaggerMeterMainFrame:SetFrameLevel(3)
	StaggerMeterMaxPctFrame:SetFrameLevel(2)
	StaggerMeterCurrentPctFrame:SetFrameLevel(1)
end

---------------------------------------------------------------- Slash Commands
u.RegisterSlashCommand({ "staggermeter", "sm", "StaggerMeter" }, nil, function()
	a.SM_ShowHide(TOGGLE)
end)

------------------------------------------------------------------------ Events
local handlers = { }

function handlers.MY_ADDON_LOADED()
	initFrames()
	a.InitializeOptions()
end

function handlers.PLAYER_ENTERING_WORLD()
	a.SM_ShowHide(SPECIALIZATION)
end

function handlers.ACTIVE_TALENT_GROUP_CHANGED()
	a.SM_ShowHide(SPECIALIZATION)
end

function handlers.COMBAT_LOG_EVENT_UNFILTERED(...)
	if show == false and a.GetOption("HideWhenNotStaggering") == false then 
		return 
	end
	
	local destName = select(9, ...)
	if destName and UnitIsUnit(destName, "player") then
		local event = select(2, ...)
		local spellId = select(12, ...)
		if (event:sub(1, 10) == "SPELL_AURA" and STAGGER_DEBUFFS[spellId])
			or (event == "SPELL_PERIODIC_DAMAGE" and spellId == STAGGER) then
			
			updateMeter()
		end
	end
end

handlers.PLAYER_DEAD = clearMeter

u.RegisterEventHandler(handlers, addonName)
