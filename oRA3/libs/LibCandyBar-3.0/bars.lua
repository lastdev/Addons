--- **LibCandyBar-3.0** provides elegant timerbars with icons for use in addons.
-- It is based of the original ideas of the CandyBar and CandyBar-2.0 library.
-- In contrary to the earlier libraries LibCandyBar-3.0 provides you with a timerbar object with a simple API.
--
-- Creating a new timerbar using the ':New' function will return a new timerbar object. This timerbar object inherits all of the barPrototype functions listed here. \\
--
-- @usage
-- local candy = LibStub("LibCandyBar-3.0")
-- local texture = "Interface\\AddOns\\MyAddOn\\statusbar"
-- local mybar = candy:New(texture, 100, 16)
-- mybar:SetLabel("Yay!")
-- mybar:SetDuration(60)
-- mybar:Start()
-- @class file
-- @name LibCandyBar-3.0

local major = "LibCandyBar-3.0"
local minor = tonumber(("$Rev: 51 $"):match("(%d+)")) or 1
if not LibStub then error("LibCandyBar-3.0 requires LibStub.") end
local cbh = LibStub:GetLibrary("CallbackHandler-1.0")
if not cbh then error("LibCandyBar-3.0 requires CallbackHandler-1.0") end
local lib, old = LibStub:NewLibrary(major, minor)
if not lib then return end
lib.callbacks = lib.callbacks or cbh:New(lib)
local cb = lib.callbacks
-- ninjaed from LibBars-1.0
lib.dummyFrame = lib.dummyFrame or CreateFrame("Frame")
lib.barFrameMT = lib.barFrameMT or {__index = lib.dummyFrame}
lib.barPrototype = lib.barPrototype or setmetatable({}, lib.barFrameMT)
lib.barPrototype_mt = lib.barPrototype_mt or {__index = lib.barPrototype}
lib.availableBars = lib.availableBars or {}

local bar = {}
local barPrototype = lib.barPrototype
local barPrototype_meta = lib.barPrototype_mt
local availableBars = lib.availableBars
local GetTime = GetTime
local floor = floor
local next = next

local scripts = {
	"OnUpdate",
	"OnDragStart", "OnDragStop",
	"OnEnter", "OnLeave",
	"OnHide", "OnShow",
	"OnMouseDown", "OnMouseUp", "OnMouseWheel",
	"OnSizeChanged", "OnEvent"
}
local _fontName, _fontSize = GameFontHighlightSmallOutline:GetFont()
local function stopBar(bar)
	bar.anim:Stop()
	if bar.data then wipe(bar.data) end
	if bar.funcs then wipe(bar.funcs) end
	bar.running = nil
	bar:Hide()
end
local function resetBar(bar)
	bar.flip = nil
	bar.showTime = true
	for i, script in next, scripts do
		bar:SetScript(script, nil)
	end

	bar.candyBarBar:GetStatusBarTexture():SetHorizTile(false)
	bar.candyBarBackground:SetVertexColor(0.5, 0.5, 0.5, 0.3)
	bar:ClearAllPoints()
	bar:SetWidth(bar.width)
	bar:SetHeight(bar.height)
	bar:SetMovable(1)
	bar:SetScale(1)
	bar:SetAlpha(1)
	bar.candyBarLabel:SetTextColor(1,1,1,1)
	bar.candyBarLabel:SetJustifyH("CENTER")
	bar.candyBarLabel:SetJustifyV("MIDDLE")
	bar.candyBarLabel:SetFont(_fontName, _fontSize)
	bar.candyBarLabel:SetFontObject("GameFontHighlightSmallOutline")

	bar.candyBarDuration:SetTextColor(1,1,1,1)
	bar.candyBarDuration:SetJustifyH("CENTER")
	bar.candyBarDuration:SetJustifyV("MIDDLE")
	bar.candyBarDuration:SetFont(_fontName, _fontSize)
	bar.candyBarDuration:SetFontObject("GameFontHighlightSmallOutline")
end

local tformat1 = "%s%d:%02d"
local tformat2 = "%s%.1f"
local tformat3 = "%s%.0f"
local function barUpdate(anim)
	local self = anim.parent
	local t = GetTime()
	if t >= self.exp then
		self:Stop()
	else
		local time = self.exp - t
		self.remaining = time

		if self.fill then
			self.candyBarBar:SetValue(t)
		else
			self.candyBarBar:SetValue(time)
		end

		if time > 3599.9 then -- > 1 hour
			local h = floor(time/3600)
			local m = time - (h*3600)
			self.candyBarDuration:SetFormattedText(tformat1, self.isApproximate, h, m)
		elseif time > 59.9 then -- 1 minute to 1 hour
			local m = floor(time/60)
			local s = time - (m*60)
			self.candyBarDuration:SetFormattedText(tformat1, self.isApproximate, m, s)
		elseif time < 10 then -- 0 to 10 seconds
			self.candyBarDuration:SetFormattedText(tformat2, self.isApproximate, time)
		else -- 10 seconds to one minute
			self.candyBarDuration:SetFormattedText(tformat3, self.isApproximate, time)
		end

		if self.funcs then
			for i, v in next, self.funcs do v(self) end
		end
	end
end

-- ------------------------------------------------------------------------------
-- Bar functions
--

local function restyleBar(self)
	if not self.running then return end
	-- In the past we used a :GetTexture check here, but as of WoW v5 it randomly returns nil, so use our own variable.
	if self.candyBarIconFrame.icon then
		self.candyBarBar:SetPoint("TOPLEFT", self.candyBarIconFrame, "TOPRIGHT")
		self.candyBarBar:SetPoint("BOTTOMLEFT", self.candyBarIconFrame, "BOTTOMRIGHT")
		self.candyBarIconFrame:SetWidth(self.height)
		self.candyBarIconFrame:Show()
	else
		self.candyBarBar:SetPoint("TOPLEFT", self)
		self.candyBarBar:SetPoint("BOTTOMLEFT", self)
		self.candyBarIconFrame:Hide()
	end
	if self.candyBarLabel:GetText() then self.candyBarLabel:Show()
	else self.candyBarLabel:Hide() end
	if self.showTime then
		self.candyBarDuration:Show()
	else
		self.candyBarDuration:Hide()
	end
end

--- Set whether the bar should drain (default) or fill up.
-- @param fill Boolean true/false
function barPrototype:SetFill(fill)
	if self.running then error("Can't set the fill/drain behavior on a running bar.") end
	self.fill = fill
end
--- Adds a function to the timerbar. The function will run every update and will receive the bar as a parameter.
-- @param func Function to run every update.
-- @usage
-- -- The example below will print the time remaining to the chatframe every update. Yes, that's a whole lot of spam
-- mybar:AddUpdateFunction( function(bar) print(bar.remaining) end )
function barPrototype:AddUpdateFunction(func) if not self.funcs then self.funcs = {} end; tinsert(self.funcs, func) end
--- Sets user data in the timerbar object.
-- @param key Key to use for the data storage.
-- @param data Data to store.
function barPrototype:Set(key, data) if not self.data then self.data = {} end; self.data[key] = data end
--- Retrieves user data from the timerbar object.
-- @param key Key to retrieve
function barPrototype:Get(key) return self.data and self.data[key] end
--- Sets the color of the bar.
-- This is basically a wrapper to SetStatusBarColor.
-- @paramsig r, g, b, a
-- @param r Red component (0-1)
-- @param g Green component (0-1)
-- @param b Blue component (0-1)
-- @param a Alpha (0-1)
function barPrototype:SetColor(...) self.candyBarBar:SetStatusBarColor(...) end
--- Sets the texture of the bar.
-- This should only be needed on running bars that get changed on the fly.
-- @param texture Path to the bar texture.
function barPrototype:SetTexture(texture)
	self.candyBarBar:SetStatusBarTexture(texture)
	self.candyBarBar:GetStatusBarTexture():SetHorizTile(false)
	self.candyBarBackground:SetTexture(texture)
end
--- Sets the label on the bar.
-- @param text Label text.
function barPrototype:SetLabel(text) self.candyBarLabel:SetText(text); restyleBar(self) end
--- Sets the icon next to the bar.
-- @param icon Path to the icon texture or nil to not display an icon.
function barPrototype:SetIcon(icon) self.candyBarIconFrame:SetTexture(icon); self.candyBarIconFrame.icon = icon; restyleBar(self) end
--- Sets wether or not the time indicator on the right of the bar should be shown.
-- Time is shown by default.
-- @param bool true to show the time, false/nil to hide the time.
function barPrototype:SetTimeVisibility(bool) self.showTime = bool; restyleBar(self) end
--- Sets the duration of the bar.
-- This can also be used while the bar is running to adjust the time remaining, within the bounds of the original duration.
-- @param duration Duration of the bar in seconds.
function barPrototype:SetDuration(duration, isApprox) self.remaining = duration; self.isApproximate = isApprox and "~" or "" end
--- Shows the bar and starts it.
function barPrototype:Start()
	self.running = true
	restyleBar(self)
	if self.fill then
		local t = GetTime()
		self.candyBarBar:SetMinMaxValues(t, t + self.remaining)
	else
		self.candyBarBar:SetMinMaxValues(0, self.remaining)
	end
	self.exp = GetTime() + self.remaining
	self.anim:SetScript("OnLoop", barUpdate)
	self.anim:Play()
	self:Show()
end
--- Stops the bar.
-- This will stop the bar, fire the LibCandyBar_Stop callback, and recycle the bar into the candybar pool.
-- Note: make sure you remove all references to the bar in your addon upon receiving the LibCandyBar_Stop callback.
-- @usage
-- -- The example below shows the use of the LibCandyBar_Stop callback by printing the contents of the label in the chatframe
-- local function barstopped( callback, bar )
--   print( bar.candybarLabel:GetText(), "stopped")
-- end
-- LibStub("LibCandyBar-3.0"):RegisterCallback(myaddonobject, "LibCandyBar_Stop", barstopped)
function barPrototype:Stop()
	cb:Fire("LibCandyBar_Stop", self)
	stopBar(self)
	availableBars[#availableBars + 1] = self
end

-- ------------------------------------------------------------------------------
-- Library functions
--

local function setValue(self, value)
	local min, max = self:GetMinMaxValues()
	self:GetStatusBarTexture():SetTexCoord(0, (value - min) / (max - min), 0, 1)
end

--- Creates a new timerbar object and returns it. Don't forget to set the duration, label and :Start the timer bar after you get a hold of it!
-- @paramsig texture, width, height
-- @param texture Path to the texture used for the bar.
-- @param width Width of the bar.
-- @param height Height of the bar.
-- @usage
-- mybar = LibStub("LibCandyBar-3.0"):New("Interface\\AddOns\\MyAddOn\\media\\statusbar", 100, 16)
function lib:New(texture, width, height)
	local bar = tremove(availableBars)
	if not bar then
		local frame = CreateFrame("Frame", nil, UIParent)
		--frame:SetFrameStrata("DIALOG")
		bar = setmetatable(frame, barPrototype_meta)
		local icon = bar:CreateTexture(nil, "LOW")
		icon:SetPoint("TOPLEFT")
		icon:SetPoint("BOTTOMLEFT")
		icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		bar.candyBarIconFrame = icon
		local statusbar = CreateFrame("StatusBar", nil, bar)
		statusbar:SetPoint("TOPRIGHT")
		statusbar:SetPoint("BOTTOMRIGHT")
		hooksecurefunc(statusbar, "SetValue", setValue)
		bar.candyBarBar = statusbar
		local bg = statusbar:CreateTexture(nil, "BACKGROUND")
		bg:SetAllPoints()
		bar.candyBarBackground = bg
		local duration = statusbar:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")
		duration:SetPoint("RIGHT", statusbar, "RIGHT", -2, 0)
		bar.candyBarDuration = duration
		local name = statusbar:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")
		name:SetPoint("LEFT", statusbar, "LEFT", 2, 0)
		name:SetPoint("RIGHT", statusbar, "RIGHT", -2, 0)
		bar.candyBarLabel = name
	else
		bar:SetLabel(nil)
		bar:SetIcon(nil)
		bar:SetDuration(nil)
	end

	if not bar.anim then
		bar.anim = bar:CreateAnimationGroup()
		bar.anim:SetLooping("REPEAT")
		bar.anim.parent = bar
		local update = bar.anim:CreateAnimation()
		update:SetOrder(1)
		update:SetDuration(0.04)
	end

	bar.candyBarBar:SetStatusBarTexture(texture)
	bar.candyBarBackground:SetTexture(texture)
	bar.width = width
	bar.height = height
	resetBar(bar)
	return bar
end

