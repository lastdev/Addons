--[[

	This Frame UI code is heavily based on "SimpleTankFrames" by Rabbit
	http://www.wowace.com/addons/simpletankframes/

--]]

local addon = CreateFrame("Frame")
addon.name = "SimpleTankFrames"

assert(_G.UnifiedTankFrames, "UnifiedTankFrames not found!")
local UnifiedTankFrames = _G.UnifiedTankFrames
UnifiedTankFrames.frames = addon

local pName = UnitName("player")
local db = nil
local allFrames = {}

addon.config = {
	lock = {name = "Lock Position", default = false, func = function(s,v) if not InCombatLockdown() then addon.mover:EnableDrag(not v) end end},
	lockAlt = {name = "Always allow to move frames with ALT-key pressed", default = false, tooltip="When enabled, you can always move the frames with ALT-key pressed, even if they are locked, by dragging the (hidden) title right top of the tank frames."},
	showHp = {name = "Show Hitpoint Percentage"..RED_FONT_COLOR_CODE.." (Needs Reload!)"..FONT_COLOR_CODE_CLOSE, default = true},
	bar = {name = "Texture", default = "Interface\\AddOns\\UnifiedTankFrames\\Textures\\statusbar"},
	scale = {name = "Scale", default = .85, min = 0, max = 2, step = .05, func = function() if not InCombatLockdown() then local m = addon.mover m:SetScale(db.scale) local s = m:GetEffectiveScale() m:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", db.x / s, db.y / s)end end},
	highlight = {name = "Highlight Your Target"..RED_FONT_COLOR_CODE.." (Needs Reload!)"..FONT_COLOR_CODE_CLOSE, default = true},
	target = {name = "Show Target"..RED_FONT_COLOR_CODE.." (Needs Reload!)"..FONT_COLOR_CODE_CLOSE, default = true},
	tot = {name = "Show Target of Target"..RED_FONT_COLOR_CODE.." (Needs Reload!)"..FONT_COLOR_CODE_CLOSE, default = false},
	alpha = {name = "Alpha", default = 1, min = 0, max = 1, step = .05, func = function() if not InCombatLockdown() then addon.mover:SetAlpha(db.alpha) end end},
	growup = {name = "Grow Up"..RED_FONT_COLOR_CODE.." (Needs Reload!)"..FONT_COLOR_CODE_CLOSE, default = false},
	width = {name = "Frame Width"..RED_FONT_COLOR_CODE.." (Needs Reload!)"..FONT_COLOR_CODE_CLOSE, default = 120, min = 50, max = 200, step = 1},
	len = {name = "Maximum Name Length"..RED_FONT_COLOR_CODE.." (Needs Reload!)"..FONT_COLOR_CODE_CLOSE, default = 12, min = 2, max = 20, step = 1},
	flip = {name = "Place Targets to the Left Side of the Tanks"..RED_FONT_COLOR_CODE.." (Needs Reload!)"..FONT_COLOR_CODE_CLOSE, default = false},
}

local backdrop = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16}
local function initCommon(frame)
	frame:SetBackdrop(backdrop)
	frame:SetBackdropColor(0, 0, 0, .5)
	frame:SetWidth(db.width)
	frame:SetHeight(22)

	local bar = CreateFrame("StatusBar", nil, frame)
	bar:SetPoint("TOPLEFT", 4, -3)
	bar:SetPoint("BOTTOMRIGHT", -4, 3)
	bar:SetStatusBarTexture(db.bar)
	frame.hp = bar

	local tx = bar:CreateTexture(nil, "BORDER")
	tx:SetTexture(db.bar)
	tx:SetVertexColor(.5, .5, .5, .5)
	tx:SetAllPoints(bar)
	frame.bg = tx

	if db.showHp then
		local value = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		value:SetJustifyH("RIGHT")
		value:SetPoint("TOPRIGHT", -2, -1)
		value:SetPoint("BOTTOMRIGHT", -2, 1)
		value:SetFormattedText("%d%%", 100)
		frame.value = value
	end

	local icon = bar:CreateTexture(nil, "OVERLAY")
	icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	icon:SetWidth(14)
	icon:SetPoint("TOPLEFT", 2, -1)
	icon:SetPoint("BOTTOMLEFT", 2, 1)
	frame.icon = icon
	
	local name = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	--name:SetPoint("TOPLEFT", icon, "TOPRIGHT", 2, -1)
	name:SetPoint("TOPLEFT", 18, -1)
	name:SetPoint("BOTTOMLEFT", 18, 1)
	name:SetJustifyH("LEFT")
	if frame.value then
		name:SetPoint("RIGHT", frame.value, "LEFT", 2, 0)
	else
		name:SetPoint("RIGHT", 2, 0)
	end
	frame.name = name
end

local function icon(self, unit)
	local unit = unit or self.unit
	if not unit then return end
	local index = GetRaidTargetIndex(unit)
	if index then
		SetRaidTargetIconTexture(self.icon, index)
		self.icon:Show()
	else
		self.icon:Hide()
	end
end

local colors = { disconnected = {.6, .6, .6}, class = {}, reaction = {} }
for class, color in next, RAID_CLASS_COLORS do colors.class[class] = {color.r, color.g, color.b} end
for class, color in next, FACTION_BAR_COLORS do colors.reaction[class] = {color.r, color.g, color.b} end
local function hp(self, unit)
	if self.unit ~= unit then return end
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	self.hp:SetMinMaxValues(0, max)
	local t = nil
	if not UnitIsConnected(unit) then
		self.hp:SetValue(max)
		self.hp:SetAlpha(0.5)
		if self.value then self.value:SetText() end
		t = colors.disconnected
	else
		self.hp:SetAlpha(1)
		self.hp:SetValue(min)
		if self.value then
			local percent = max == 0 and 0 or math.floor(min / max * 100 + 0.5)
			self.value:SetFormattedText("%d%%", percent)
		end
		if UnitIsPlayer(unit) then
			t = colors.class[(select(2, UnitClass(unit)))]
		elseif UnitReaction(unit, "player") then
			t = colors.reaction[UnitReaction(unit, "player")]
		end
	end
	if not t then return end
	self.hp:SetStatusBarColor(unpack(t))
end

local function name(self, unit)
	if self.unit ~= unit then return end
	local n = UnitName(unit)
	self.unitName = n
	self.name:SetText(#n > db.len and n:sub(1, db.len) or n)
end

local function fullUpdate(self)
	local unit = self.unit
	if not UnitExists(unit) then return end
	hp(self, unit)
	name(self, unit)
	icon(self, unit)
end

local eventFuncs = {
	PLAYER_ENTERING_WORLD = fullUpdate,
	UNIT_CONNECTION = fullUpdate,
	UNIT_NAME_UPDATE = name,
	UNIT_MAXHEALTH = hp,
	UNIT_HEALTH = hp,
	RAID_TARGET_UPDATE = icon,
}
local function onEvent(self, event, unit) if eventFuncs[event] then eventFuncs[event](self, unit, event) end end

local function attributeChanged(self, name, value)
	if name ~= "unit" or not value then return end
	if self.unit and self.unit == value and UnitName(value) == self.unitName then return end
	
	if db.target then
		local target = SecureButton_GetModifiedUnit(self.target)
		self.target.unit = target
		fullUpdate(self.target)
	end

	if db.tot then
		local tot = SecureButton_GetModifiedUnit(self.tot)
		self.tot.unit = tot
		fullUpdate(self.tot)
	end

	self.unit = SecureButton_GetModifiedUnit(self)
	fullUpdate(self)
end

local function onUpdate(self, elapsed)
	if not self.unit then return end
	self.timer = self.timer + elapsed
	if self.timer >= 0.3 then -- Health updates only happen every 0.3sec I think
		fullUpdate(self)
		self.timer = 0
	end
end

local function onEnter(self)
	local unit = SecureButton_GetModifiedUnit(self)
	if unit then
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetUnit(unit)
	end
	fullUpdate(self)
end

local function Tank_DropDown_Initialize(self, level)
	if self.unit then
		local name = nil
		local unit = self.unit
		local id = UnitInRaid(unit)
		if id then
			menu = "RAID_PLAYER"
		elseif UnitIsUnit(unit, "player") then
			menu = "SELF"
		elseif UnitInParty(unit) then
			menu = "PARTY"
		else
			menu = "PLAYER"
		end
		UnitPopup_ShowMenu(self, menu, unit, name, id)
	end
end

local function initializer(self, frame, ...)
	local tank = _G[frame]
	local target = tank:GetChildren()
	local tot = target:GetChildren()

	initCommon(tank)

	tank:RegisterEvent("UNIT_MAXHEALTH")
	tank:RegisterEvent("UNIT_HEALTH")
	tank:RegisterEvent("RAID_TARGET_UPDATE")
	tank:RegisterEvent("UNIT_NAME_UPDATE")
	tank:RegisterEvent("UNIT_CONNECTION")
	tank:SetScript("OnEvent", onEvent)
	tank:SetScript("OnAttributeChanged", attributeChanged)
	tank:SetScript("OnEnter", function(s) onEnter(s) end)
	tank:SetScript("OnLeave", function() GameTooltip:Hide() end)
	local dropdown = CreateFrame("Frame", frame.."DropDown", UIParent, "UIDropDownMenuTemplate")
	UIDropDownMenu_Initialize(dropdown, Tank_DropDown_Initialize, "MENU")
	tank:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	
	tank.showmenu  = function(self, unit)
		local dropDown = _G[self:GetName().."DropDown"]
		dropDown.unit = unit
		ToggleDropDownMenu(1, nil, dropDown, self, 0, 0)
	end

	allFrames[#allFrames + 1] = tank

	if db.target then
		RegisterUnitWatch(target)
		tank.target = target
		initCommon(target)
		target.timer = 0
		target:SetScript("OnUpdate", onUpdate)
		target:SetScript("OnEnter", function(s) onEnter(s) end)
		target:SetScript("OnLeave", function() GameTooltip:Hide() end)
		allFrames[#allFrames + 1] = target
	end

	if db.target and db.tot then
		RegisterUnitWatch(tot)
		tank.tot = tot
		initCommon(tot)
		tot.timer = 0
		tot:SetScript("OnUpdate", onUpdate)
		tot:SetScript("OnEnter", function(s) onEnter(s) end)
		tot:SetScript("OnLeave", function() GameTooltip:Hide() end)
		allFrames[#allFrames + 1] = tot
	end
end

local init = [[
	local header = self:GetParent()
	header:CallMethod("initializer", self:GetName())
	
	local clique = self:GetParent():GetFrameRef("clickcast_header")
	if clique then
		clique:SetAttribute("clickcast_button", self)
		clique:RunAttribute("clickcast_register")
	end
]]

addon.mover = nil
addon.header = nil

local function createFrames()
	local mover = CreateFrame("Frame", "UnifiedTankFramesMover", UIParent, "SecureFrameTemplate")
	mover:SetFrameStrata("LOW")
	mover:SetWidth(150)
	mover:SetHeight(13)
	mover:SetScale(db.scale)
	mover:SetAlpha(db.alpha)
	mover:EnableMouse(true)
	mover:SetMovable(true)
	mover:RegisterForDrag("LeftButton")
	mover.ShouldAllowDrag = function()
		if db.lock then
			if db.lockAlt then
				return IsAltKeyDown() and not InCombatLockdown()
			else
				return false
			end
		else
			return true
		end
	end
	mover:SetScript("OnDragStart", function(self)
		if not mover.ShouldAllowDrag() then return end
		self:SetFrameStrata("DIALOG")
		self:StartMoving()
	end)
	mover:SetScript("OnDragStop", function(self)
		if not mover.ShouldAllowDrag() then return end
		self:SetFrameStrata("LOW")
		self:StopMovingOrSizing()
		local s = self:GetEffectiveScale()
		db.x = self:GetLeft() * s
		db.y = self:GetTop() * s
	end)
	local text = mover:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	text:SetText("UnifiedTanks")
	text:SetAllPoints(mover)
	mover.text = text
	mover.EnableDrag = function(self, enabled)
		if enabled then
			self.text:SetText("UnifiedTanks")
		else
			self.text:SetText("")
		end
	end
	mover:EnableDrag(not db.lock)
	if db.x and db.y then
		local s = mover:GetEffectiveScale()
		mover:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", db.x / s, db.y / s)
	else
		mover:SetPoint("CENTER")
	end
	mover:Hide()
	addon.mover = mover

	header = CreateFrame("Frame", "UnifiedTankFramesHeader", mover, "SecureGroupHeaderTemplate")
	if db.flip then
		header:SetAttribute("template", "UnifiedTankFramesLeftTemplate,UnifiedTankFramesClickCastUnitTemplate")
	else
		header:SetAttribute("template", "UnifiedTankFramesTemplate,UnifiedTankFramesClickCastUnitTemplate")
	end
	SecureHandler_OnLoad(header)
	if ClickCastHeader then
		header:SetFrameRef("clickcast_header", ClickCastHeader)
	end
	if db.growup then
		header:SetPoint("BOTTOM", mover, "TOP")
		header:SetAttribute("point", "TOP")
		header:SetAttribute("yOffset", -1)
	else
		header:SetPoint("TOP", mover, "BOTTOM")
		header:SetAttribute("point", "BOTTOM")
		header:SetAttribute("yOffset", 1)
	end
	header:SetAttribute("showRaid", true)
	header:SetAttribute("showParty", true)
	header:SetAttribute("showSolo", true)
	header:SetAttribute("showPlayer", true)
	--header:SetAttribute("sortDir", "ASC")
	--header:SetAttribute("sortMethod", "NAME")
	header:SetAttribute("initial-unitWatch", true)
	header:SetAttribute("nameList", "")
	header.initializer = initializer
	header:SetAttribute("initialConfigFunction", init)
	header:Show()
	addon.header = header
end

local function updateTargetHighlight()
	for i, frame in next, allFrames do
		if frame.unit and UnitIsUnit(frame.unit, "target") then
			frame:SetBackdropColor(1, .84, 0, 1)
		else
			frame:SetBackdropColor(0, 0, 0, .5)
		end
	end
end

local function updateTanks(event, tanks)
	if addon.mover:IsShown() and #tanks == 0 then
		addon.mover:Hide()
	elseif not addon.mover:IsShown() and #tanks > 0 then
		addon.mover:Show()
	end
	if db.highlight then
		local playerIsTank = nil
		for i, tank in next, tanks do
			if tank == pName then
				playerIsTank = true
				break
			end
		end
		if playerIsTank then
			addon:UnregisterEvent("UNIT_TARGET")
			addon:SetScript("OnUpdate", updateTargetHighlight)
		else
			addon:RegisterEvent("UNIT_TARGET")
			addon:SetScript("OnUpdate", nil)
		end
	end
	header:SetAttribute("nameList", table.concat(tanks, ","))
end

addon:SetScript("OnEvent", function(self, event, addonName)
	if event == "UNIT_TARGET" then
		updateTargetHighlight()
	end
end)

function addon:ShowInRaid(show)
	self.header:SetAttribute("showRaid", show)	
end

function addon:ShowInParty(show)
	self.header:SetAttribute("showParty", show)	
end

function addon:InitFrames(config)
	if config then
		db = config
	else
		db = {}
	end
	for k, v in pairs(self.config) do
		if type(db[k]) == "nil" then
			db[k] = v.default
		end
	end
	config = db

	createFrames()
	self.TankUpdate = function(self, tanks)
		local mts = {}
		for i,t in pairs(tanks) do
			if type(t) == "table" then
				table.insert(mts, t.name)
			end
		end
		updateTanks(nil, mts)
	end
	
	return config
end
