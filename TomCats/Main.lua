local addonName, addon = ...;
local _G = _G
local bit = bit
local coroutine = coroutine
local error = error
local getmetatable = getmetatable
local ipairs = ipairs
local math = math
local next = next
local pairs = pairs
local rawset = rawset
local select = select
local setmetatable = setmetatable
local string = string
local table = table
local time = time
local tonumber = tonumber
local type = type
local unpack = unpack
local C_ChatInfo = C_ChatInfo
local CreateFrame = CreateFrame
local CreateFromMixins = CreateFromMixins
local GetAddOnEnableState= GetAddOnEnableState
local GetAddOnInfo = GetAddOnInfo
local GetAddOnMetadata = GetAddOnMetadata
local GetChannelName = GetChannelName
local GetFramerate = GetFramerate
local GetLocale = GetLocale
local GetNumAddOns = GetNumAddOns
local GetRealmName = GetRealmName
local GetUnitName = GetUnitName
local IsAddOnLoaded = IsAddOnLoaded
local IsLoggedIn = IsLoggedIn
local LibStub = LibStub
local Minimap = Minimap
local MinimapCluster = MinimapCluster
local MinimapZoneTextButton = MinimapZoneTextButton
local Mixin = Mixin
local UnitName = UnitName
local UnitFullName = UnitFullName
TomCats = { };
local TomCats = TomCats
function TomCats.NextCharmFrameLevel()
	TOMCATS_LIBS_ICON_LASTFRAMELEVEL = (TOMCATS_LIBS_ICON_LASTFRAMELEVEL or 7) + 3
	return TOMCATS_LIBS_ICON_LASTFRAMELEVEL;
end
local Events = { }
addon.events = Events
do
	local eventListeners = { }
	local eventFrame = CreateFrame("Frame")
	local eventHandler
	local onUpdate
	local validateRegisterUnregisterInput
	function Events.registerEvent(event, listener)
		validateRegisterUnregisterInput(event, listener)
		eventListeners[event] = eventListeners[event] or {}
		for i = 1, #eventListeners[event] do
			if (eventListeners[event][i] == listener) then
				error(tostring(listener) .. " already associated with " .. event, 2)
			end
		end
		table.insert(eventListeners[event], listener)
		if (#eventListeners[event] == 1) then
			if (event == "ON_UPDATE") then
				eventFrame:SetScript("OnUpdate", onUpdate)
			else
				eventFrame:RegisterEvent(event)
			end
		end
	end
	function Events.unregisterEvent(event, listener)
		validateRegisterUnregisterInput(event, listener)
		if (eventListeners[event]) then
			for i = 1, #eventListeners[event] do
				if (eventListeners[event][i] == listener) then
					table.remove(eventListeners[event], i)
					if (#eventListeners[event] == 0) then
						if (event == "ON_UPDATE") then
							eventFrame:SetScript("OnUpdate", nil)
						else
							eventFrame:UnregisterEvent(event)
						end
					end
					break
				end
			end
		end
	end
	function eventHandler(_, event, ...)
		local eventListenersQueue = Mixin({}, eventListeners[event])
		if (eventListenersQueue) then
			for i = 1, #eventListenersQueue do
				if (type(eventListenersQueue[i]) == "table") then
					if (eventListenersQueue[i][event] and (type(eventListenersQueue[i][event]) == "function")) then
						eventListenersQueue[i][event](eventListenersQueue[i], event, ...)
					else
						error("cannot find a function named " .. event .. " in table " .. tostring(eventListenersQueue[i]))
					end
				elseif (type(eventListenersQueue[i]) == "function") then
					eventListenersQueue[i](eventListenersQueue[i], event, ...)
				else
					error("cannot relay the event for " .. event)
				end
			end
		end
	end
	function onUpdate()
		eventHandler(nil, "ON_UPDATE")
	end
	function validateRegisterUnregisterInput(event, listener)
		if ((not event) or (type(event) ~= "string")) then
			error("Event must be specified", 3)
		end
		if ((not listener) or (type(listener) ~= "table" and type(listener) ~= "function")) then
			error("Listener must be specified", 3)
		end
	end
	eventFrame:SetScript("OnEvent", eventHandler)
end
do
	local setupCharacterFullName
	function setupCharacterFullName()
		if (IsLoggedIn()) then
			addon.events.unregisterEvent("ADDON_LOADED", setupCharacterFullName)
			addon.events.unregisterEvent("PLAYER_LOGIN", setupCharacterFullName)
			local name, realm = UnitFullName("player")
			addon.currentCharacterFullName = name .. "-" .. realm
		end
	end
	addon.events.registerEvent("ADDON_LOADED", setupCharacterFullName)
	addon.events.registerEvent("PLAYER_LOGIN", setupCharacterFullName)
end
local SavedVariables = { }
addon.savedVariables = SavedVariables;
do
	local function ADDON_LOADED(_, _, addonName1)
		if (addonName == addonName1) then
			_G["TomCats_Character"] = _G["TomCats_Character"] or { }
			SavedVariables.character = _G["TomCats_Character"]
			_G["TomCats_Account"] = _G["TomCats_Account"] or { }
			SavedVariables.account = _G["TomCats_Account"]
			SavedVariables.character.preferences = SavedVariables.character.preferences or { }
			SavedVariables.account.preferences = SavedVariables.account.preferences or { }
			Events.unregisterEvent("ADDON_LOADED", ADDON_LOADED)
		end
	end
	addon.events.registerEvent("ADDON_LOADED", ADDON_LOADED)
end
local Charms = { }
addon.charms = Charms
do
	local seqNum = 1
	local handleSexyMap
	local handleSlideBar
	function Charms.Create(buttonInfo)
		if (MinimapZoneTextButton and MinimapZoneTextButton:GetParent() == MinimapCluster) then
			MinimapZoneTextButton:SetParent(Minimap)
		end
		local name = buttonInfo.name
		if (not name) then
			name = addonName .. "MinimapButton" .. seqNum
			seqNum = seqNum + 1
		end
		local frame = CreateFrame("Button", name, Minimap, "TomCatsMinimapButtonTemplate")
		frame:SetFrameLevel(TomCats.NextCharmFrameLevel())
		if (buttonInfo.backgroundColor) then
			local background = frame.background
			background:SetDrawLayer("BACKGROUND", 1)
			background:SetTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMaskSmall")
			background:SetWidth(25)
			background:SetHeight(25)
			background:SetVertexColor(unpack(buttonInfo.backgroundColor))
			frame.backgroundColor = buttonInfo.backgroundColor
		end
		frame.title = buttonInfo.title or name
		if (buttonInfo.iconTexture) then
			frame.icon:SetTexture(buttonInfo.iconTexture)
		end
		if (buttonInfo.name) then
			local scope = SavedVariables["account"].preferences
			if (scope[name]) then
				frame:SetPreferences(scope[name])
			else
				scope[name] = frame:GetPreferences()
			end
		end
		if (buttonInfo.handler_onclick) then
			frame:SetHandler("OnClick", buttonInfo.handler_onclick)
		end
		if not buttonInfo.ignoreSlideBar then
			handleSlideBar(frame)
		end
		if not buttonInfo.ignoreSexyMap then
			handleSexyMap(frame)
		end
		return frame
	end
	-- Begin SexyMap Compatibility --
	local sexyMapPresent = select(4, GetAddOnInfo("SexyMap"))
	local sexyMapQueue = {}
	function handleSexyMap(button, event)
		if (not sexyMapPresent) then
			return
		end
		if (IsAddOnLoaded("SexyMap")) then
			if (event) then
				addon.events.unregisterEvent("ADDON_LOADED", handleSexyMap)
			else
				table.insert(sexyMapQueue, button)
			end
			for _, btn in ipairs(sexyMapQueue) do
				local ldbiMock = CreateFromMixins(btn)
				setmetatable(ldbiMock, getmetatable(btn))
				function ldbiMock:GetName()
					return "LibDBIcon10_" .. btn.title
				end
				function ldbiMock:SetScript()
				end
				function ldbiMock:SetPoint()
				end
				function ldbiMock:SetAllPoints()
				end
				function ldbiMock:ClearAllPoints()
				end
				_G["LibDBIcon10_" .. btn.title] = ldbiMock
				table.insert(LibStub["libs"]["LibDBIcon-1.0"].objects, ldbiMock)
				LibStub["libs"]["LibDBIcon-1.0"].callbacks:Fire("LibDBIcon_IconCreated", ldbiMock, btn.title)
			end
		end
		if (not event) then
			table.insert(sexyMapQueue, button)
			return
		end
	end
	if (sexyMapPresent and (not IsAddOnLoaded("SexyMap"))) then
		addon.events.registerEvent("ADDON_LOADED", handleSexyMap)
	end
	-- End SexyMap Compatibility --
	-- Begin SlideBar Compatibility --
	local slideBarPresent = select(4, GetAddOnInfo("SlideBar"))
	local slideBarQueue = {}
	function handleSlideBar(button, event)
		if (not slideBarPresent) then
			return
		end
		if (LibStub and LibStub.libs and LibStub.libs.SlideBar) then
			if (event) then
				addon.events.unregisterEvent("ADDON_LOADED", handleSlideBar)
			else
				table.insert(slideBarQueue, button)
			end
			for _, btn in ipairs(slideBarQueue) do
				local newButton = LibStub.libs.SlideBar.AddButton(
						btn.title, btn.icon:GetTexture(), nil, btn:GetName() .. "SlideBar", true,
						{ OnClick = btn:GetScript("OnClick") }
				)
				local oldOnEnter = newButton:GetScript("OnEnter")
				newButton:SetScript("OnEnter", function(this)
					if (oldOnEnter) then
						oldOnEnter(this)
					end
					if (btn.tooltip) then
						btn.tooltip.Show(this)
					end
				end)
				local oldOnLeave = newButton:GetScript("OnLeave")
				newButton:SetScript("OnLeave", function(this)
					if (oldOnLeave) then
						oldOnLeave(this)
					end
					if (btn.tooltip) then
						btn.tooltip.Hide(this)
					end
				end)
				-- todo: force background color to work in the interface config panel
				if (btn.backgroundColor) then
					newButton.icon:SetDrawLayer("ARTWORK", 1)
					local bg = _G[btn:GetName() .. "SlideBar"]:CreateTexture("", "BACKGROUND")
					bg:SetDrawLayer("BACKGROUND", 1)
					bg:SetTexture("Interface\\AddOns\\TomCats\\images\\00019")
					bg:SetPoint("TOPLEFT", newButton, "TOPLEFT", 0, 0)
					bg:SetWidth(30)
					bg:SetHeight(30)
					bg:SetVertexColor(unpack(btn.backgroundColor))
				end
			end
			slideBarQueue = {}
			return
		end
		if (not event) then
			table.insert(slideBarQueue, button)
		end
	end
	if (slideBarPresent and (not (LibStub and LibStub.libs and LibStub.libs.SlideBar))) then
		addon.events.registerEvent("ADDON_LOADED", handleSlideBar)
	end
	-- End SlideBar Compatibility --
end
TomCatsCharmsMixin = { }
do
	function TomCatsCharmsMixin:OnLoad()
		local name = self:GetName()
		local preferences = {}
		local handlers = {}
		local isDragging
		local tooltipIsShowing
		local function ButtonDown()
			_G[name .. "Icon"]:SetPoint("TOPLEFT", self, "TOPLEFT", 8, -8)
			_G[name .. "IconOverlay"]:Show()
		end
		local function ButtonUp()
			_G[name .. "Icon"]:SetPoint("TOPLEFT", self, "TOPLEFT", 6, -6)
			_G[name .. "IconOverlay"]:Hide()
		end
		local function OnMouseDown()
			ButtonDown()
		end
		local function OnMouseUp()
			ButtonUp()
		end
		local function OnClick()
			if (handlers.OnClick) then
				handlers.OnClick(self)
			end
		end
		local function OnEnter()
			if (self.tooltip and (not isDragging)) then
				self.tooltip.Show(self)
				tooltipIsShowing = true
			end
		end
		local function OnLeave()
			if (self.tooltip) then
				self.tooltip.Hide()
				tooltipIsShowing = false
			end
		end
		function self:GetPreferences()
			if (not preferences.position) then
				local _, _, _, Bx, By = self:GetPoint()
				local Ax, Ay = Minimap:GetCenter()
				preferences.position = math.atan2(By - Ay, Bx - Ax)
			end
			return preferences
		end
		function self:SetPreferences(savedPreferences)
			if (savedPreferences) then
				if (savedPreferences.position and type(savedPreferences.position) == "number") then
					preferences = savedPreferences
				end
				if (savedPreferences.hidden) then
					self:Hide()
				end
			end
		end
		function self:SetHandler(handlerType, handler)
			handlers[handlerType] = handler
		end
		self:SetScript("OnMouseDown", OnMouseDown)
		self:SetScript("OnMouseUp", OnMouseUp)
		self:SetScript("OnClick", OnClick)
		self:SetScript("OnEnter", OnEnter)
		self:SetScript("OnLeave", OnLeave)
	end
end
local Locales = { }
addon.locales = Locales
do
	local isTranslatedLookup = { }
	local isDefaultLanguage = true
	setmetatable(Locales, {
		__index = function(_, key)
			return key
		end
	})
	function Locales.AddLocaleLookup(locale, lookup)
		if (locale == "enUS") then
			Mixin(Locales, lookup)
		elseif (GetLocale() == locale) then
			isDefaultLanguage = false
			for key in pairs(lookup) do
				isTranslatedLookup[key] = true
			end
			Mixin(Locales, lookup)
		end
	end
	function Locales.IsTranslationNeeded(key)
		if isDefaultLanguage then
			return false
		end
		return not (isTranslatedLookup[key] or false)
	end
end
local Data = { }
addon.data = Data
do
	local recordMetatable = {
		__index    = function(tbl, key)
			return tbl.record[tbl.parent.columnNames[key]]
		end,
		__newindex = function(tbl, key, value)
			if (not tbl.parent.columnNames[key]) then
				tbl.parent.columnCount = tbl.parent.columnCount + 1
				tbl.parent.columnNames[key] = tbl.parent.columnCount
			end
			if (tbl.record[tbl.parent.columnNames[key]] ~= value) then
				rawset(tbl.record, tbl.parent.columnNames[key], value)
				if (tbl.parent.afterUpdateCallbacks and tbl.parent.afterUpdateCallbacks[key]) then
					tbl.parent.afterUpdateCallbacks[key](tbl)
				end
			end
		end
	}
	local tableMixin = {
		SetAfterUpdate = function(self, columnName, callback)
			if (not self.afterUpdateCallbacks) then
				rawset(self, "afterUpdateCallbacks", {})
			end
			self.afterUpdateCallbacks[columnName] = callback
		end
	}
	local tableMetatable = {
		__index = function(self, key)
			return self.records[key]
		end
	}
	function Data.loadData(name, columnNames, records)
		local table = CreateFromMixins(tableMixin)
		table.columnNames = {}
		table.columnCount = #columnNames
		for i = 1, #columnNames, 1 do
			table.columnNames[columnNames[i]] = i
		end
		table.records = {}
		for i = 1, #records, 1 do
			local record = { }
			record.parent = table
			record.record = records[i]
			setmetatable(record, recordMetatable)
			table.records[records[i][1]] = record
		end
		setmetatable(table, tableMetatable)
		Data[name] = table
	end
	function Data.flatten(record)
		local result = {}
		for k, v in pairs(record.parent.columnNames) do
			result[v] = record[k]
		end
		return unpack(result)
	end
end
local BackgroundProcessing = { }
do
	local queue = { }
	function BackgroundProcessing.addToQueue(func, ...)
		local params = { ... }
		local co = coroutine.create(function()
			func(unpack(params))
		end)
		table.insert(queue, co)
	end
	local function ON_UPDATE()
		local co = queue[1]
		if (co) then
			if (coroutine.status(co) == "dead") then
				table.remove(queue, 1)
			else
				coroutine.resume(co)
			end
		end
	end
	addon.events.registerEvent("ON_UPDATE",ON_UPDATE)
end
local Bit32S = { }
do
	local arshift = bit.arshift
	local band = bit.band
	local bnot = bit.bnot
	local bor = bit.bor
	local bxor = bit.bxor
	local lshift = bit.lshift
	local rshift = bit.rshift
	local s32
	function Bit32S.bor(val1, val2)
		return s32(bor(val1, val2))
	end
	function Bit32S.rshift(val, bits)
		return s32(rshift(val, bits))
	end
	function Bit32S.arshift(val, bits)
		return s32(arshift(val, bits))
	end
	function Bit32S.lshift(val, bits)
		return s32(lshift(val, bits))
	end
	function Bit32S.band(val1, val2)
		return s32(band(val1, val2))
	end
	function Bit32S.bnot(val1)
		return s32(bnot(val1))
	end
	function Bit32S.bxor(val1, val2)
		return s32(bxor(val1, val2))
	end
	function Bit32S.s32(val)
		if val > 2147483647 then
			return val - 4294967296
		end
		if val < -2147483648 then
			return val + 4294967296
		end
		return val
	end
	s32 = Bit32S.s32
end
local Sha256 = { }
do
	local arshift = Bit32S.arshift
	local band = Bit32S.band
	local bnot = Bit32S.bnot
	local bor = Bit32S.bor
	local bxor = Bit32S.bxor
	local lshift = Bit32S.lshift
	local min = math.min
	local rshift = Bit32S.rshift
	local s32 = Bit32S.s32
	local strbyte = string.byte
	local strformat = string.format
	local strsub = string.sub
	local function zeroFill(amt)
		local r = {}
		for i = 1, amt do
			r[i] = 0
		end
		return unpack(r)
	end
	local padding = { -128, zeroFill(135) }
	local ROUND_CONSTS = {
		1116352408, 1899447441, -1245643825, -373957723, 961987163, 1508970993, -1841331548, -1424204075,
		-670586216, 310598401, 607225278, 1426881987, 1925078388, -2132889090, -1680079193, -1046744716,
		-459576895, -272742522, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986,
		-1740746414, -1473132947, -1341970488, -1084653625, -958395405, -710438585, 113926993, 338241895,
		666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, -2117940946, -1838011259,
		-1564481375, -1474664885, -1035236496, -949202525, -778901479, -694614492, -200395387, 275423344,
		430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779,
		1955562222, 2024104815, -2067236844, -1933114872, -1866530822, -1538233109, -1090935817, -965641998,
	}
	local INITIAL_STATE = {
		coeff1         = 1779033703,
		coeff2         = -1150833019,
		coeff3         = 1013904242,
		coeff4         = -1521486534,
		coeff5         = 1359893119,
		coeff6         = -1694144372,
		coeff7         = 528734635,
		coeff8         = 1541459225,
		bufOfs         = 0,
		bytesProcessed = 0
	}
	local function s8(number)
		if number > 128 then
			return number - 256
		end
		return number
	end
	local function toHex(number)
		local hex = strformat("%08X", number)
		return strsub(hex, 8 - #hex)
	end
	local function copy(src, srcPos, dest, destPos, len)
		for i = 0, len - 1 do
			dest[destPos + i] = src[srcPos + i]
		end
	end
	local executions = 0;
	local function getIntFromByteArray(buffer, offset)
		return bor(bor(bor(lshift(band(buffer[offset], 255), 24), lshift(band(buffer[offset + 1], 255), 16)),
				lshift(band(buffer[offset + 2], 255), 8)), (band(buffer[offset + 3], 255)))
	end
	local function i2b4(src, dst, offset)
		dst[offset] = s8(band(arshift(src, 24), 255))
		dst[offset + 1] = s8(band(arshift(src, 16), 255))
		dst[offset + 2] = s8(band(arshift(src, 8), 255))
		dst[offset + 3] = s8(band(src, 255))
	end
	local function compress(buffer, offset, state)
		executions = executions + 1;
		local tmp = { }
		for idx = 1, 16 do
			tmp[idx] = getIntFromByteArray(buffer, offset)
			offset = offset + 4
		end
		for idx = 17, 64 do
			tmp[idx] = s32(s32((bxor(bxor(bor(rshift(tmp[idx - 2], 17), lshift(tmp[idx - 2], 15)),
					bor(rshift(tmp[idx - 2], 19), lshift(tmp[idx - 2], 13))), rshift(tmp[idx - 2],
					10))) + tmp[idx - 7]) + s32((bxor(bxor(bor(rshift(tmp[idx - 15],
					7),
					lshift(tmp[idx - 15],
							25)),
					bor(rshift(tmp[idx - 15],
							18),
							lshift(tmp[idx - 15],
									14))),
					rshift(tmp[idx - 15],
							3))) + tmp[idx - 16]))
		end
		local coeff1 = state.coeff1
		local coeff2 = state.coeff2
		local coeff3 = state.coeff3
		local coeff4 = state.coeff4
		local coeff5 = state.coeff5
		local coeff6 = state.coeff6
		local coeff7 = state.coeff7
		local coeff8 = state.coeff8
		for idx = 1, 64 do
			local sum1 = s32(s32(coeff8 + (bxor(bxor((bor(rshift(coeff5, 6), lshift(coeff5, 26))),
					bor(rshift(coeff5, 11), lshift(coeff5, 21))),
					bor(rshift(coeff5, 25), lshift(coeff5, 7))))) + s32(bxor(band(coeff5,
					coeff6),
					band(bnot(coeff5),
							coeff7)) + ROUND_CONSTS[idx]) + tmp[idx])
			local sum2 = s32((bxor(bxor(bor(rshift(coeff1, 2), lshift(coeff1, 30)),
					bor(rshift(coeff1, 13), lshift(coeff1, 19))),
					bor(rshift(coeff1, 22), lshift(coeff1, 10)))) + (bxor(bxor(band(coeff1, coeff2),
					band(coeff1, coeff3)),
					band(coeff2, coeff3))))
			coeff8 = coeff7
			coeff7 = coeff6
			coeff6 = coeff5
			coeff5 = s32(coeff4 + sum1)
			coeff4 = coeff3
			coeff3 = coeff2
			coeff2 = coeff1
			coeff1 = s32(sum1 + sum2)
		end
		state.coeff1 = s32(state.coeff1 + coeff1)
		state.coeff2 = s32(state.coeff2 + coeff2)
		state.coeff3 = s32(state.coeff3 + coeff3)
		state.coeff4 = s32(state.coeff4 + coeff4)
		state.coeff5 = s32(state.coeff5 + coeff5)
		state.coeff6 = s32(state.coeff6 + coeff6)
		state.coeff7 = s32(state.coeff7 + coeff7)
		state.coeff8 = s32(state.coeff8 + coeff8)
	end
	local function process(data, len, state)
		local dataPos = 1
		if state.bufOfs ~= 0 then
			local size = min(len, 64 - state.bufOfs)
			copy(data, dataPos, state.buffer, state.bufOfs + 1, size)
			state.bufOfs = state.bufOfs + size
			dataPos = dataPos + size
			len = len - size
			if state.bufOfs >= 64 then
				compress(state.buffer, 1, state)
			end
		end
		if len >= 64 then
			local total = dataPos + len
			while dataPos <= total - 64 do
				compress(data, dataPos, state)
				dataPos = dataPos + 64
			end
			len = total - dataPos
		end
		if len > 0 then
			copy(data, dataPos, state.buffer, 1, len)
			state.bufOfs = len
		end
	end
	function Sha256.encode(message)
		local state = CreateFromMixins(INITIAL_STATE)
		state.buffer = { zeroFill(64) }
		local messageBytes = { }
		for idx = 1, #message, 1000 do
			local tmp = { strbyte(message, idx, idx + 1000) }
			for i = 1, #tmp do
				messageBytes[idx + i - 1] = tmp[i]
			end
		end
		process(messageBytes, #messageBytes, state)
		state.bytesProcessed = state.bytesProcessed + #messageBytes
		local var1 = lshift(state.bytesProcessed, 3)
		local var2 = band(state.bytesProcessed, 63)
		local var3 = (var2 < 56) and (56 - var2) or (120 - var2)
		process(padding, var3, state)
		i2b4(0, state.buffer, 57)
		i2b4(var1, state.buffer, 61)
		compress(state.buffer, 1, state)
		local var0 = { state.coeff1, state.coeff2, state.coeff3, state.coeff4, state.coeff5, state.coeff6, state.coeff7, state.coeff8 }
		return toHex(var0[1]) .. toHex(var0[2]) .. toHex(var0[3]) .. toHex(var0[4]) .. toHex(var0[5])
	end
end
local ArrayMath = { }
do
	local corunning = coroutine.running
	local coyield = coroutine.yield
	local max = math.max
	local floor = math.floor
	local strupper = string.upper
	local pool = { };
	local bnExpModThreshTable = { 25, 81, 241, 673, 1793, 2147483647 };
	bnExpModThreshTable[0] = 7;
	local yield, compare, getLowestSetBit, getLeadingZeroCount, normalize, rightShift, leftShift, mulsub,
	primitiveRightShift, primitiveLeftShift, getInt, setInt, add, subtract, copyAndShift,
	numberOfLeadingZeros, mod, divadd, unsignedIntCompare, divWord, multiply, multiplyToLen,
	bitLengthForInt, modPow, montgomeryMultiply, montgomerySquare, montReduce,
	intArrayCmpToLen, subN, mulAddOne, addToArray, implMulAdd, addOne, modInverse, asInt,
	getIntFrom, arraycopy, acquire, createArrayNumberFromHex, multiplyTruncInts, createIntArrayNumber,
	createArrayNumber, copyArrayNumber, releaseArr, rescale, rescale2, resize, asShort
	local arshift = Bit32S.arshift
	local band = Bit32S.band
	local bnot = Bit32S.bnot
	local bor = Bit32S.bor
	local bxor = Bit32S.bxor
	local lshift = Bit32S.lshift
	local rshift = Bit32S.rshift
	local tblinsert = table.insert
	local tblremove = table.remove
	local yieldcount = 0
	local frames = 0
	local frameRateGoal
	local maxYieldSkips = 5000
	DEBUGYIELDS = 0
	yield = function()
		if (corunning()) then
			if (not frameRateGoal) then
				frameRateGoal = GetFramerate()
			end
			yieldcount = yieldcount + 1
			DEBUGYIELDS = DEBUGYIELDS + 1
			if (yieldcount >= maxYieldSkips) then
				yieldcount = 0
				frames = frames + 1
				if (frames >= 30) then
					frames = 0
					local currentFrameRate = GetFramerate();
					if (currentFrameRate < frameRateGoal) then
						maxYieldSkips = max(maxYieldSkips * 0.8, 2000)
					else
						frameRateGoal = currentFrameRate
						maxYieldSkips = maxYieldSkips * 1.05
					end
				end
				coyield()
			end
		end
	end
	compare = function(n1, n2)
		yield();
		if (n1.len < n2.len) then
			return -1;
		end
		if (n1.len > n2.len) then
			return 1;
		end
		local idx = 0;
		while (idx < n1.len) do
			local x1 = asInt(n1.arr[idx]);
			local x2 = asInt(n2.arr[idx]);
			if (x1 < x2) then
				return -1;
			end
			if (x1 > x2) then
				return 1;
			end
			idx = idx + 1;
		end
		return 0;
	end
	getLowestSetBit = function(n)
		yield();
		local idx = n.len - 1;
		while (idx > 0) do
			if (n.arr[idx] ~= 0) then
				break ;
			end
			idx = idx - 1;
		end
		local b1 = lshift(n.len - 1 - idx, 4);
		local b2 = band(n.arr[idx], 65535);
		return b1 + getLeadingZeroCount(band(bnot(b2), b2 - 1));
	end
	getLeadingZeroCount = function(x)
		yield();
		if (x <= 0) then
			return band(x, 16);
		else
			local b = 1;
			if (x > 256) then
				b = b + 8;
				x = rshift(x, 8);
			end
			if (x > 16) then
				b = b + 4;
				x = rshift(x, 4);
			end
			if (x > 4) then
				b = b + 2;
				x = rshift(x, 2);
			end
			return b + rshift(x, 1);
		end
	end
	normalize = function(n)
		yield();
		if (n.len % 2 == 1) then
			rescale(n, 0, 1, n.len + 1);
		end
		if (n.len == 0 or n.arr[0] ~= 0 or n.arr[1] ~= 0) then
			return ;
		end
		local idx = 0;
		local len1 = n.len;
		repeat
			idx = idx + 2;
		until (not (idx + 1 < len1 and n.arr[idx] == 0 and n.arr[idx + 1] == 0))
		local len2 = len1 - idx;
		local offs = len2 == 0 and 0 or idx;
		if (len1 ~= len2 or offs ~= 0) then
			rescale(n, offs, 0, len2);
		end
	end
	rightShift = function(n, b1)
		yield();
		local b2 = band(b1, 31);
		local b3 = bitLengthForInt(bor(band(n.arr[1], 65535), lshift(n.arr[0], 16)));
		if (b2 >= b3) then
			primitiveLeftShift(n, 32 - b2);
			rescale(n, 0, 0, n.len - 2);
		else
			primitiveRightShift(n, b2);
		end
	end
	leftShift = function(n, b)
		yield();
		if (n.len == 0) then
			return ;
		end
		local b2 = band(b, 15);
		if (b <= 0) then
			primitiveLeftShift(n, b2);
		end
		rescale(n, 0, 0, n.len + rshift(b, 4) + 2);
		primitiveRightShift(n, 32 - b2);
	end
	mulsub = function(n1, n2, x, len, off)
		yield();
		x = band(x, 65535);
		local c = 0;
		off = off + len;
		local idx = len - 1;
		while (idx >= 0) do
			local prod = asInt(n2.arr[idx]) * x + c;
			local diff = n1.arr[off] - prod;
			n1.arr[off] = asShort(diff);
			off = off - 1;
			c = rshift(prod, 16) + ((band(diff, 65535) > (band((bnot(prod)),
					65535))) and 1 or 0);
			idx = idx - 1;
		end
		return asShort(c);
	end
	primitiveRightShift = function(n, b)
		yield();
		if (b > 16) then
			local s = rshift(b, 4);
			rescale2(n, 0, s, n.len, n.len - s);
			b = b % 16;
		end
		local n2 = 16 - b;
		local x1 = n.arr[n.len - 1];
		local idx = n.len - 1;
		while (idx > 0) do
			local x2 = x1;
			x1 = n.arr[idx - 1];
			n.arr[idx] = asShort(bor(lshift(band(x1, 65535), n2),
					(rshift(band(x2, 65535), b))));
			idx = idx - 1
		end
		n.arr[0] = asShort(rshift(band(n.arr[0], 65535), b));
	end
	primitiveLeftShift = function(n, b)
		yield();
		local len = rshift(n.len, 1);
		if (len == 0 or b == 0) then
			return ;
		end
		local b2 = 32 - b;
		local x1 = getInt(n, 0);
		local idx = 0;
		while (idx < len - 1) do
			local x2 = x1;
			x1 = getInt(n, idx + 1);
			setInt(n, idx, bor(lshift(x2, b), rshift(x1, b2)));
			idx = idx + 1;
		end
		setInt(n, len - 1, lshift(getInt(n, len - 1), b));
	end
	getInt = function(n, idx)
		yield();
		return bor(band(n.arr[idx * 2 + 1], 65535), lshift(n.arr[idx * 2], 16));
	end
	setInt = function(n, idx, x)
		yield();
		n.arr[idx * 2] = asShort(rshift(x, 16));
		n.arr[idx * 2 + 1] = asShort(x);
	end
	add = function(n1, n2)
		yield();
		local idx1 = n1.len;
		local idx2 = n2.len;
		local len = max(idx1, idx2);
		local n3 = createArrayNumber(len);
		local idx3 = len - 1;
		local sum;
		local carry = 0;
		while (idx1 > 0 and idx2 > 0) do
			idx1 = idx1 - 1;
			idx2 = idx2 - 1;
			sum = asInt(n1.arr[idx1]) + asInt(n2.arr[idx2]) + carry;
			n3.arr[idx3] = asShort(sum);
			idx3 = idx3 - 1;
			carry = rshift(sum, 16);
		end
		while (idx1 > 0) do
			idx1 = idx1 - 1;
			sum = asInt(n1.arr[idx1]) + carry;
			n3.arr[idx3] = asShort(sum);
			idx3 = idx3 - 1;
			carry = rshift(sum, 16);
		end
		while (idx2 > 0) do
			idx2 = idx2 - 1;
			sum = asInt(n2.arr[idx2]) + carry;
			n3.arr[idx3] = asShort(sum);
			idx3 = idx3 - 1;
			carry = rshift(sum, 16);
		end
		if (carry > 0) then
			rescale(n3, 0, 2, n3.len + 2);
			n3.arr[1] = 1;
		end
		n3.sign = n1.sign;
		return n3;
	end
	subtract = function(n1, n2)
		yield();
		local n3 = n1;
		local sign = compare(n1, n2);
		if (sign < 0) then
			local tmp = n3;
			n3 = n2;
			n2 = tmp;
		end
		local idx2 = n2.len;
		local idx3 = n3.len;
		local n4 = createArrayNumber(idx3);
		local diff = 0;
		local idx4 = n4.len - 1;
		while (idx2 > 0) do
			idx3 = idx3 - 1;
			idx2 = idx2 - 1;
			diff = asInt(n3.arr[idx3]) - band(n2.arr[idx2], 65535) + arshift(diff, 16);
			n4.arr[idx4] = asShort(diff);
			idx4 = idx4 - 1;
		end
		while (idx3 > 0) do
			idx3 = idx3 - 1;
			diff = asInt(n3.arr[idx3]) + arshift(diff, 16);
			n4.arr[idx4] = asShort(diff);
			idx4 = idx4 - 1;
		end
		n4.sign = n1.sign * sign;
		normalize(n4);
		return n4;
	end
	copyAndShift = function(n1, len, n2, idx2, b1)
		yield();
		local idx1 = 0
		local b2 = 16 - b1;
		local x1 = n1.arr[idx1];
		local idx3 = 0;
		while (idx3 < len - 1) do
			local x2 = x1;
			idx1 = idx1 + 1;
			x1 = n1.arr[idx1];
			n2.arr[idx2 + idx3] = asShort(bor(lshift(x2, b1), lshift(x1, b2)));
			idx3 = idx3 + 1;
		end
		n2.arr[idx2 + len - 1] = asShort(lshift(x1, b1));
	end
	numberOfLeadingZeros = function(x)
		yield();
		if (x <= 0) then
			return x == 0 and 16 or 0;
		end
		local b = 15;
		if (x >= 256) then
			b = b - 8;
			x = asShort(rshift(x, 8));
		end
		if (x >= 16) then
			b = b - 4;
			x = asShort(rshift(x, 4));
		end
		if (x >= 4) then
			b = b - 2;
			x = asShort(rshift(x, 2));
		end
		return b - rshift(x, 1);
	end
	mod = function(n1, n2)
		yield();
		local len3;
		local b1 = numberOfLeadingZeros(n2.arr[0]);
		local n4;
		local n5;
		if (b1 > 0) then
			n4 = createArrayNumber(n2.len);
			copyAndShift(n2, n2.len, n4, 0, b1);
			if (numberOfLeadingZeros(n1.arr[0]) >= b1) then
				n5 = createArrayNumber((n1.len + 1));
				len3 = n1.len;
				copyAndShift(n1, n1.len, n5, 1, b1);
			else
				n5 = createArrayNumber((n1.len + 2));
				len3 = n1.len + 1;
				local idx1 = 0;
				local x1 = 0;
				local b2 = 16 - b1;
				local idx2 = 1;
				while (idx2 < n1.len + 1) do
					local x2 = x1;
					x1 = n1.arr[idx1];
					n5.arr[idx2] = asShort(bxor(lshift(x2, b1), rshift(x1, b2)));
					idx2 = idx2 + 1;
					idx1 = idx1 + 1;
				end
				n5.arr[n1.len + 1] = asShort(lshift(x1, b1));
			end
		else
			n4 = n2;
			n5 = createArrayNumber((n1.len + 1));
			arraycopy(n1.arr, 0, n5.arr, 1, n1.len);
			len3 = n1.len;
		end
		len3 = len3 - n2.len + 1;
		local n5offset = 0;
		n5.arr[0] = 0;
		local x1 = asInt(n4.arr[0]);
		local x7 = n4.arr[1];
		local idx1 = 0;
		while (idx1 < len3 - 1) do
			local x2;
			local x3;
			local t = false;
			local x4 = n5.arr[idx1 + n5offset];
			local x5 = asShort(x4 + 32768);
			local x6 = n5.arr[idx1 + 1 + n5offset];
			if (x4 == n4.arr[0]) then
				x2 = -1;
				x3 = asShort(x4 + x6);
				t = asShort((x3 + 32768)) < x5;
			else
				local x8 = bor(lshift(x4, 16), band(x6, 65535));
				if (x8 >= 0) then
					x2 = asShort(floor(x8 / x1));
					x3 = asShort((x8 - (x2 * x1)));
				else
					local tmp = divWord(x8, n4.arr[0]);
					x2 = asShort(tmp);
					x3 = asShort(rshift(tmp, 16));
				end
			end
			if (x2 ~= 0) then
				if (not t) then
					local x9 = asInt(n5.arr[idx1 + 2 + n5offset]);
					local x10 = bor(lshift(band(x3, 65535), 16), x9);
					local x11 = band(x7, 65535) * band(x2, 65535);
					if (unsignedIntCompare(x11, x10)) then
						x2 = asShort(x2 - 1);
						x3 = asShort(x3 + x1);
						if (band(x3, 65535) >= x1) then
							x11 = x11 - band(x7, 65535);
							x10 = bor(lshift(band(x3, 65535), 16), x9);
							if (unsignedIntCompare(x11, x10)) then
								x2 = asShort(x2 - 1);
							end
						end
					end
				end
				n5.arr[idx1 + n5offset] = 0;
				local c = mulsub(n5, n4, x2, n2.len, idx1 + n5offset);
				if (asShort((c + 32768)) > x5) then
					divadd(n4, n5, idx1 + 1 + n5offset);
				end
			end
			idx1 = idx1 + 1;
		end
		local x9;
		local x10;
		local t = false;
		local x11 = n5.arr[len3 - 1 + n5offset];
		local x12 = asShort(x11 + 32768);
		local x13 = n5.arr[len3 + n5offset];
		if (x11 == n4.arr[0]) then
			x9 = -1;
			x10 = asShort(x11 + x13);
			t = asShort((x10 + 32768)) < x12;
		else
			local x14 = bor(lshift((x11), 16), band(x13, 65535));
			if (x14 >= 0) then
				x9 = asShort(floor(x14 / x1));
				x10 = asShort((x14 - (x9 * x1)));
			else
				local tmp = divWord(x14, n4.arr[0]);
				x9 = asShort(tmp);
				x10 = asShort(rshift(tmp, 16));
			end
		end
		if (x9 ~= 0) then
			if (not t) then
				local x14 = asInt(n5.arr[len3 + 1 + n5offset]);
				local x15 = bor(lshift(band(x10, 65535), 16), x14);
				local x16 = band(x7, 65535) * band(x9, 65535);
				if (unsignedIntCompare(x16, x15)) then
					x9 = asShort(x9 - 1);
					x10 = asShort(x10 + x1);
					if (band(x10, 65535) >= x1) then
						x16 = x16 - band(x7, 65535);
						x15 = bor(lshift(band(x10, 65535), 16), x14);
						if (unsignedIntCompare(x16, x15)) then
							x9 = asShort((x9 - 1));
						end
					end
				end
			end
			local c;
			n5.arr[len3 - 1 + n5offset] = 0;
			c = mulsub(n5, n4, x9, n2.len, len3 - 1 + n5offset);
			if (asShort((c + 32768)) > x12) then
				divadd(n4, n5, len3 - 1 + 1 + n5offset);
			end
		end
		if (b1 > 0) then
			rightShift(n5, b1);
		end
		normalize(n5);
		return n5;
	end
	divadd = function(n1, n2, off)
		yield();
		local c = 0;
		local idx = n1.len - 1;
		while (idx >= 0) do
			local x = asInt(n1.arr[idx]) + band(n2.arr[idx + off], 65535) + c;
			n2.arr[idx + off] = asShort(x);
			c = rshift(x, 16);
			idx = idx - 1;
		end
	end
	unsignedIntCompare = function(x1, x2)
		yield();
		return (x1 + -2147483648) > (x2 - -2147483648);
	end
	divWord = function(x1, x2)
		yield();
		local x3 = band(x2, 65535);
		local x4;
		local x5;
		x5 = floor(rshift(x1, 1) / rshift(x3, 1));
		x4 = x1 - multiplyTruncInts(x5, x3);
		while (x4 < 0) do
			x4 = x4 + x3;
			x5 = x5 - 1;
		end
		return bor(lshift(x4, 16), band(x5, 65535));
	end
	multiply = function(n1, n2)
		yield();
		local len1 = (n1.len + (n1.len % 2)) / 2;
		local len2 = (n2.len + (n2.len % 2)) / 2;
		local x1 = n1.sign == n2.sign and 1 or -1;
		local n3 = multiplyToLen(n1, len1, n2, len2);
		local vlen = n3.len;
		local keep = 0;
		while (keep < vlen and n3.arr[keep] == 0) do
			keep = keep + 1;
		end
		if (keep % 2 ~= 0) then
			keep = keep - 1;
		end
		if (keep ~= 0) then
			rescale(n3, keep, 0, vlen - keep);
		end
		n3.sign = n3.len == 0 and 0 or x1;
		return n3;
	end
	multiplyToLen = function(n1, len1, n2, len2)
		yield();
		len1 = len1 * 2;
		len2 = len2 * 2;
		local n3 = createArrayNumber((len1 + len2));
		local c = 0;
		local idx1 = len2 - 1;
		local idx2 = len2 + len1 - 1;
		while (idx1 >= 0) do
			local product = asInt(n2.arr[idx1]) * band(n1.arr[len1 - 1], 65535) + c;
			n3.arr[idx2] = asShort(product);
			c = rshift(product, 16);
			idx1 = idx1 - 1;
			idx2 = idx2 - 1;
		end
		n3.arr[len1 - 1] = asShort(c);
		idx1 = len1 - 2;
		while (idx1 >= 0) do
			c = 0;
			idx2 = len2 - 1;
			local idx3 = len2 + idx1;
			while (idx2 >= 0) do
				local product = asInt(n2.arr[idx2]) * band(n1.arr[idx1], 65535) + band(n3.arr[idx3],
						65535) + c;
				n3.arr[idx3] = asShort(product);
				c = rshift(product, 16);
				idx2 = idx2 - 1;
				idx3 = idx3 - 1;
			end
			n3.arr[idx1] = asShort(c);
			idx1 = idx1 - 1;
		end
		return n3;
	end
	bitLengthForInt = function(x)
		yield();
		if (x <= 0) then
			return 32 - (x == 0 and 32 or 0);
		end
		local b = 31;
		if (x >= 65536) then
			b = b - 16;
			x = rshift(x, 16);
		end
		if (x >= 256) then
			b = b - 8;
			x = rshift(x, 8);
		end
		if (x >= 16) then
			b = b - 4;
			x = rshift(x, 4);
		end
		if (x >= 4) then
			b = b - 2;
			x = rshift(x, 2);
		end
		return 32 - (b - rshift(x, 1));
	end
	modPow = function(n1, n2, n3)
		yield();
		local t = (n2.sign < 0);
		local disposables = { };
		local n4;
		if (n1.sign < 0 or compare(n1, n3) >= 0) then
			n4 = mod(n1, n3);
			tblinsert(disposables, n4);
		else
			n4 = n1;
		end
		local b1 = 0;
		local b2 = ((n2.len / 2 - 1) * 32) + bitLengthForInt(getIntFrom(n2, 0));
		while (b2 > bnExpModThreshTable[b1]) do
			b1 = b1 + 1;
		end
		local x1 = lshift(1, b1);
		local x2 = getIntFrom(n3, n3.len / 2 - 1);
		local x3 = multiplyTruncInts(x2, (2 - multiplyTruncInts(x2, x2)));
		x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
		x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
		x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
		x3 = -multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
		local n6 = createArrayNumber((n3.len + n4.len));
		tblinsert(disposables, n6);
		arraycopy(n4.arr, 0, n6.arr, 0, n4.len);
		local idx1 = n4.len;
		while (idx1 < n6.len) do
			n6.arr[idx1] = 0;
			idx1 = idx1 + 1;
		end
		primitiveLeftShift(n6, band(n3.len * 16, 31));
		local a = { };
		a[0] = mod(n6, n3);
		local n7 = montgomerySquare(a[0], n3, n3.len / 2, x3);
		tblinsert(disposables, n7);
		local n8 = createArrayNumber(n3.len);
		arraycopy(n7.arr, 0, n8.arr, 0, n3.len);
		idx1 = 1;
		while (idx1 < x1) do
			a[idx1] = montgomeryMultiply(n8, a[idx1 - 1], n3, n3.len / 2, x3);
			idx1 = idx1 + 1;
		end
		releaseArr(n8);
		local b3 = lshift(1, (band((b2 - 1), 31)));
		local x4 = 0;
		local len1 = n2.len / 2;
		idx1 = 0;
		local idx2 = 0;
		while (idx2 <= b1) do
			x4 = bor(lshift(x4, 1), ((band(getIntFrom(n2, idx1), b3) ~= 0) and 1 or 0));
			b3 = rshift(b3, 1);
			idx2 = idx2 + 1;
		end
		b2 = b2 - 1;
		local t1 = true;
		local x5 = b2 - b1;
		while (band(x4, 1) == 0) do
			x4 = rshift(x4, 1);
			x5 = x5 + 1;
		end
		local n9 = a[rshift(x4, 1)];
		x4 = 0;
		if (x5 == b2) then
			t1 = false;
		end
		while (b2 ~= 0) do
			b2 = b2 - 1;
			x4 = lshift(x4, 1);
			if (len1 ~= 0) then
				x4 = bor(x4, (band(getIntFrom(n2, idx1), b3) ~= 0) and 1 or 0);
				b3 = rshift(b3, 1);
				if (b3 == 0) then
					idx1 = idx1 + 1;
					b3 = lshift(1, 31);
					len1 = len1 - 1;
				end
			end
			if (band(x4, x1) ~= 0) then
				x5 = b2 - b1;
				while (band(x4, 1) == 0) do
					x4 = rshift(x4, 1);
					x5 = x5 + 1;
				end
				n9 = a[rshift(x4, 1)];
				x4 = 0;
			end
			if (b2 == x5) then
				if (t1) then
					n7 = n9;
					t1 = false;
				else
					n7 = montgomeryMultiply(n7, n9, n3, n3.len / 2, x3);
					tblinsert(disposables, n7);
				end
			end
			if (b2 ~= 0 and (not t1)) then
				n7 = montgomerySquare(n7, n3, n3.len / 2, x3);
				tblinsert(disposables, n7);
			end
		end
		rescale2(n7, 0, n3.len, n3.len * 2, n3.len);
		montReduce(n7, n3, n3.len, x3);
		rescale(n7, 0, 0, n7.len / 2);
		if (t) then
			n7 = modInverse(n7, n3);
		end
		for n = 1, #disposables do
			if (disposables[n] ~= n7) then
				releaseArr(disposables[n]);
			end
		end
		for n = 0, #a do
			if (a[n] ~= n7) then
				releaseArr(a[n]);
			end
		end
		return n7;
	end
	montgomeryMultiply = function(n1, n2, n3, len, x)
		yield();
		local n4 = multiplyToLen(n1, len, n2, len);
		montReduce(n4, n3, len * 2, x);
		return n4;
	end
	montgomerySquare = function(n1, n2, len1, x1)
		yield();
		local n3 = createArrayNumber(len1 * 4);
		local x2 = 0;
		local idx1 = 0;
		local idx2 = 0;
		while (idx1 < len1) do
			local n4 = createArrayNumber(2);
			n4.arr[0] = n1.arr[idx1 * 2];
			n4.arr[1] = n1.arr[idx1 * 2 + 1];
			local n5 = multiply(n4, n4);
			releaseArr(n4);
			if (n5.len < 4) then
				rescale(n5, 0, 4 - n5.len, 4);
			end
			local idx3 = n5.len - 4;
			n3.arr[idx2 * 2] = asShort((lshift(x2, 15) + rshift(asInt(n5.arr[idx3]), 1)));
			n3.arr[idx2 * 2 + 1] = asShort((lshift(asInt(n5.arr[idx3]),
					15) + rshift(band(n5.arr[idx3 + 1], 65535),
					1)));
			idx2 = idx2 + 1;
			n3.arr[idx2 * 2] = asShort((lshift(asInt(n5.arr[idx3 + 1]),
					15) + rshift(band(n5.arr[idx3 + 2], 65535), 1)));
			n3.arr[idx2 * 2 + 1] = asShort((lshift(asInt(n5.arr[idx3 + 2]),
					15) + rshift(band(n5.arr[idx3 + 3], 65535),
					1)));
			idx2 = idx2 + 1;
			x2 = band(n5.arr[idx3 + 3], 1);
			releaseArr(n5);
			idx1 = idx1 + 1;
		end
		idx1 = len1;
		local off = 1;
		while (idx1 > 0) do
			addOne(n3, off - 1, idx1, implMulAdd(n3, n1, off, idx1 - 1, getIntFrom(n1, idx1 - 1)));
			idx1 = idx1 - 1;
			off = off + 2;
		end
		primitiveLeftShift(n3, 1);
		n3.arr[(len1 * 4) - 1] = asShort((n3.arr[(len1 * 4) - 1] + band(n1.arr[(len1 * 2) - 1], 1)));
		montReduce(n3, n2, len1 * 2, x1);
		return n3;
	end
	montReduce = function(n1, n2, len, x1)
		yield();
		local c = 0;
		local idx = len;
		local off = 0;
		repeat
			local x2 = n1.arr[n1.len - 1 - off];
			c = c + mulAddOne(n1, n2, off, len, multiplyTruncInts(x1, x2), off, len);
			off = off + 1;
			idx = idx - 1;
		until (not (idx > 0));
		while (c > 0) do
			c = c + subN(n1, n2, len);
		end
		while (intArrayCmpToLen(n1, n2, len) >= 0) do
			subN(n1, n2, len);
		end
	end
	intArrayCmpToLen = function(n1, n2, len)
		yield();
		local idx = 0;
		while (idx < len) do
			local x1 = band(rshift(getIntFrom(n1, idx), 16), 65535);
			local x2 = band(rshift(getIntFrom(n2, idx), 16), 65535);
			if (x1 < x2) then
				return -1;
			end
			if (x1 > x2) then
				return 1;
			end
			x1 = band(getIntFrom(n1, idx), 65535);
			x2 = band(getIntFrom(n2, idx), 65535);
			if (x1 < x2) then
				return -1;
			end
			if (x1 > x2) then
				return 1;
			end
			idx = idx + 1;
		end
		return 0;
	end
	subN = function(n1, n2, len)
		yield();
		local x = 0;
		len = len - 1;
		while (len >= 0) do
			x = asInt(n1.arr[len]) - band(n2.arr[len], 65535) + arshift(x, 16);
			n1.arr[len] = asShort(x);
			len = len - 1;
		end
		return asShort(arshift(x, 16));
	end
	mulAddOne = function(n1, n2, off1, len1, x1, off2, len2)
		yield();
		x1 = band(x1, 65535);
		local c = 0;
		off1 = n1.len - off1 - 1;
		local idx = len1 - 1;
		while (idx >= 0) do
			local x2 = asInt(n2.arr[idx]) * x1 + band(n1.arr[off1], 65535) + c;
			n1.arr[off1] = asShort(x2);
			off1 = off1 - 1;
			c = rshift(x2, 16);
			idx = idx - 1;
		end
		off2 = n1.len - 1 - len2 - off2;
		local x2 = asInt(n1.arr[off2]) + band(c, 65535);
		n1.arr[off2] = asShort(x2);
		if (rshift(x2, 16) == 0) then
			return 0;
		end
		while (len2 >= 1) do
			len2 = len2 - 1;
			off2 = off2 - 1;
			if (off2 < 0) then
				return 1;
			else
				n1.arr[off2] = asShort((n1.arr[off2] + 1));
				if (n1.arr[off2] ~= 0) then
					return 0;
				end
			end
		end
		return 1;
	end
	addToArray = function(a, off, x1)
		yield();
		for idx = off, #a do
			local x2 = band((a[idx] + band(x1, 65535)), 65535);
			x1 = rshift((a[idx] + x1), 16);
			a[idx] = x2;
		end
	end
	implMulAdd = function(n1, n2, idx2, len, x1)
		yield();
		local x2 = 0;
		local x3 = 0;
		local x4 = band(rshift(x1, 16), 65535);
		local x5 = band(x1, 65535);
		idx2 = n1.len / 2 - idx2 - 1;
		local a = { };
		local idx = len - 1;
		while (idx >= 0) do
			local x7 = asInt(n2.arr[idx * 2]);
			local x8 = asInt(n2.arr[idx * 2 + 1]);
			local x9 = asInt(n1.arr[idx2 * 2]);
			local x10 = asInt(n1.arr[idx2 * 2 + 1]);
			a[0] = 0;
			a[1] = 0;
			a[2] = 0;
			a[3] = 0;
			addToArray(a, 2, x7 * x4);
			addToArray(a, 1, x7 * x5);
			addToArray(a, 1, x8 * x4);
			addToArray(a, 1, x2);
			addToArray(a, 1, x9);
			addToArray(a, 0, x8 * x5);
			addToArray(a, 0, x3);
			addToArray(a, 0, x10);
			x2 = a[3];
			x3 = a[2];
			n1.arr[idx2 * 2] = a[1];
			n1.arr[idx2 * 2 + 1] = a[0];
			idx2 = idx2 - 1;
			idx = idx - 1;
		end
		return (x2 * 65536) + x3;
	end
	addOne = function(n1, idx, len, c)
		yield();
		idx = n1.len / 2 - 1 - len - idx;
		local a = { 0, 0, 0 };
		a[0] = 0;
		addToArray(a, 0, getIntFrom(n1, idx));
		addToArray(a, 0, c);
		n1.arr[idx * 2] = asShort(a[1]);
		n1.arr[idx * 2 + 1] = asShort(a[0]);
		if (a[2] == 0 and a[3] == 0) then
			return ;
		end
		while (len >= -1) do
			len = len - 1;
			idx = idx - 1;
			if (idx < 0) then
				return ;
			else
				local x = getIntFrom(n1, idx) + 1;
				n1.arr[idx * 2] = asShort(rshift(x, 16));
				n1.arr[idx * 2 + 1] = asShort(x);
				if (getIntFrom(n1, idx) ~= 0) then
					return ;
				end
			end
		end
	end
	modInverse = function(n1, n2)
		yield();
		local n3 = copyArrayNumber(n2);
		local n8 = n1;
		local n4 = createArrayNumber(2);
		n4.arr[0] = 0;
		n4.arr[1] = 1;
		local n5 = createArrayNumber(0);
		local x1 = 0;
		if ((n8.len / 2 == 0) or (band(getIntFrom(n8, n8.len / 2 - 1), 1) == 0)) then
			x1 = getLowestSetBit(n8);
			rightShift(n8, x1);
			leftShift(n5, x1);
		end
		while (not ((n8.len / 2 == 1) and (getIntFrom(n8, 0) == 1))) do
			if (compare(n8, n3) < 0) then
				local n6 = n8;
				n8 = n3;
				n3 = n6;
				n6 = n5;
				n5 = n4;
				n4 = n6;
			end
			if (band(bxor(getIntFrom(n8, n8.len / 2 - 1), getIntFrom(n3, n3.len / 2 - 1)), 3) == 0) then
				local disp1 = n8;
				n8 = subtract(disp1, n3);
				if (disp1 ~= n1) then
					releaseArr(disp1);
				end
				if (n4.sign == n5.sign) then
					local disp = n4;
					n4 = subtract(disp, n5);
					releaseArr(disp);
				else
					local disp = n4;
					n4 = add(disp, n5);
					releaseArr(disp);
				end
			else
				local disp1 = n8;
				n8 = add(disp1, n3);
				if (disp1 ~= n1) then
					releaseArr(disp1);
				end
				if (n4.sign == n5.sign) then
					local disp = n4;
					n4 = add(disp, n5);
					releaseArr(disp);
				else
					local disp = n4;
					n4 = subtract(n4, n5);
					releaseArr(disp);
				end
			end
			local x2 = getLowestSetBit(n8);
			rightShift(n8, x2);
			leftShift(n5, x2);
			normalize(n5);
			x1 = x1 + x2;
		end
		if (n3 ~= n1) then
			releaseArr(n3);
		end
		if (n8 ~= n1) then
			releaseArr(n8);
		end
		releaseArr(n5);
		while (n4.sign < 0) do
			local disp = n4;
			n4 = subtract(disp, n2);
			releaseArr(disp);
		end
		local x2 = getIntFrom(n2, n2.len / 2 - 1);
		local x3 = multiplyTruncInts(x2, (2 - multiplyTruncInts(x2, x2)));
		x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
		x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
		x3 = -multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
		local idx = 0;
		local x4 = rshift(x1, 5);
		while (idx < x4) do
			local x5 = multiplyTruncInts(x3, getIntFrom(n4, n4.len / 2 - 1));
			local n6 = createArrayNumber(2);
			n6.arr[0] = asShort(rshift(x5, 16));
			n6.arr[1] = asShort(x5);
			local disp1 = n4;
			local disp2 = multiply(n2, n6);
			releaseArr(n6);
			n4 = add(disp1, disp2);
			releaseArr(disp1);
			releaseArr(disp2);
			local len = n4.len / 2 - 1;
			if (n4.len / 2 ~= len) then
				resize(n4, len);
			end
			idx = idx + 1;
		end
		local b = band(x1, 31);
		if (b ~= 0) then
			x4 = band(multiplyTruncInts(x3, getIntFrom(n4, n4.len / 2 - 1)), (lshift(1, b) - 1));
			local n6 = createArrayNumber(2);
			n6.arr[0] = asShort(rshift(x4, 16));
			n6.arr[1] = asShort(x4);
			local n7 = multiply(n2, n6);
			releaseArr(n6);
			local disp = n4;
			n4 = add(disp, n7);
			releaseArr(disp);
			releaseArr(n7);
			rightShift(n4, b);
		end
		return n4;
	end
	asInt = function(s)
		yield();
		return band(s, 65535);
	end
	getIntFrom = function(n, idx)
		yield();
		return asInt(n.arr[idx * 2 + 1]) + (lshift(n.arr[idx * 2], 16));
	end
	arraycopy = function(a1, off1, a2, off2, len)
		yield();
		for idx = 0, len do
			a2[idx + off2] = a1[idx + off1];
		end
	end
	acquire = function()
		yield();
		if (#pool == 0) then
			local a = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
			a[0] = 0;
			return a;
		else
			return tblremove(pool);
		end
	end
	createArrayNumberFromHex = function(val)
		yield();
		local n = { };
		val = strupper(val);
		local cursor = 0;
		while (cursor < #val and val:sub(cursor + 1, cursor + 1) == '0') do
			cursor = cursor + 1;
		end
		while ((#val - cursor) % 8 ~= 0) do
			cursor = cursor - 1;
		end
		while (cursor < 0) do
			val = "0" .. val;
			cursor = cursor + 1;
		end
		local numDigits = #val - cursor;
		local numWords = floor(numDigits / 4) + (numDigits % 4 == 0 and 0 or 1);
		n.arr = acquire();
		n.len = numWords;
		n.sign = 1;
		local groupLen = numDigits % 4;
		if (groupLen == 0) then
			groupLen = 4;
		end
		local idx = 0;
		while (idx < numWords) do
			local val1 = val:sub(cursor + 1, cursor + groupLen);
			cursor = cursor + groupLen;
			local i = tonumber(val1, 16);
			if (i > 32767) then
				i = i - 65536;
			end
			n.arr[idx] = asShort(i);
			groupLen = 4;
			idx = idx + 1;
		end
		return n;
	end
	multiplyTruncInts = function(x1, x2)
		yield();
		local n1 = createIntArrayNumber(x1);
		local n2 = createIntArrayNumber(x2);
		local n3 = multiply(n1, n2);
		if (n3.len == 0) then
			return 0;
		end
		local x3 = getIntFrom(n3, (n3.len / 2) - 1);
		releaseArr(n1);
		releaseArr(n2);
		releaseArr(n3);
		return x3;
	end
	createIntArrayNumber = function(x)
		yield();
		local n2 = { };
		n2.arr = acquire();
		n2.len = 2;
		local x1 = asShort(band((rshift(x, 16)), 65535));
		local x2 = asShort(band(x, 65535));
		if (x1 == 0) then
			n2.sign = 0;
		elseif (x1 > 0) then
			n2.sign = 1;
		else
			n2.sign = -1;
		end
		n2.arr[0] = x1;
		n2.arr[1] = x2;
		return n2;
	end
	createArrayNumber = function(len)
		yield();
		local n = { }
		n.arr = acquire();
		n.len = len;
		n.sign = 1;
		return n;
	end
	copyArrayNumber = function(n1)
		yield();
		local n = { };
		n.arr = acquire();
		arraycopy(n1.arr, 0, n.arr, 0, n1.len);
		n.len = n1.len;
		n.sign = n1.sign;
		return n;
	end
	releaseArr = function(n)
		yield();
		tblinsert(pool, n.arr);
		n.arr = nil;
	end
	rescale = function(n, off1, off2, len1)
		yield();
		local len2 = len1;
		if (len2 > n.len - off1) then
			len2 = n.len - off1;
		end
		rescale2(n, off1, off2, len1, len2);
	end
	rescale2 = function(n, off1, off2, len1, len2)
		yield();
		local newArr = acquire();
		arraycopy(n.arr, off1, newArr, off2, len2);
		for idx = 0, off2 - 1 do
			newArr[idx] = 0;
		end
		for idx = off2 + len2, len1 - 1 do
			newArr[idx] = 0;
		end
		releaseArr(n);
		n.arr = newArr;
		n.len = len1;
	end
	resize = function(n, len)
		yield();
		len = len * 2;
		if (len > n.len) then
			len = n.len;
		end
		for idx = n.len, len - 1 do
			n.arr[idx] = 0;
		end
		n.len = len;
	end
	asShort = function(x)
		yield();
		x = band(x, 65535)
		if (x > 32767) then
			x = x - 65536;
		end
		return x;
	end
	ArrayMath.ZERO = createArrayNumber(0);
	ArrayMath.createArrayNumberFromHex = createArrayNumberFromHex;
	ArrayMath.compare = compare;
	ArrayMath.modInverse = modInverse;
	ArrayMath.multiply = multiply;
	ArrayMath.mod = mod;
	ArrayMath.releaseArr = releaseArr;
	ArrayMath.modPow = modPow;
end
local DSA = { }
do
	local verifySignature, getArrayNumber, getArrayNumberForMessage
	getArrayNumber = function(key)
		local num = ArrayMath.createArrayNumberFromHex(key);
		return num;
	end
	getArrayNumberForMessage = function(message)
		local encoded = Sha256.encode(message);
		local num = ArrayMath.createArrayNumberFromHex(encoded);
		return num
	end
	verifySignature = function(message, signature, publicKey, callback)
		local r = getArrayNumber(signature.r);
		local s = getArrayNumber(signature.s);
		local p = getArrayNumber(publicKey.p);
		local q = getArrayNumber(publicKey.q);
		local g = getArrayNumber(publicKey.g);
		local y = getArrayNumber(publicKey.y);
		local hm = getArrayNumberForMessage(message);
		local result = false;
		if (ArrayMath.compare(ArrayMath.ZERO, r) < 0 and ArrayMath.compare(r,
				q) < 0 and ArrayMath.compare(ArrayMath.ZERO,
				s) < 0 and ArrayMath.compare(s,
				q) < 0) then
			local w = ArrayMath.modInverse(s, q);
			local hmw = ArrayMath.multiply(hm, w);
			local u1 = ArrayMath.mod(hmw, q);
			ArrayMath.releaseArr(hmw);
			local rw = ArrayMath.multiply(r, w);
			ArrayMath.releaseArr(w);
			local u2 = ArrayMath.mod(rw, q);
			ArrayMath.releaseArr(rw);
			local gu1 = ArrayMath.modPow(g, u1, p);
			ArrayMath.releaseArr(u1);
			local yu2 = ArrayMath.modPow(y, u2, p);
			ArrayMath.releaseArr(u2);
			local gu1yu2 = ArrayMath.multiply(gu1, yu2);
			ArrayMath.releaseArr(gu1);
			ArrayMath.releaseArr(yu2);
			local gu1yu2p = ArrayMath.mod(gu1yu2, p);
			ArrayMath.releaseArr(gu1yu2);
			local v = ArrayMath.mod(gu1yu2p, q);
			ArrayMath.releaseArr(gu1yu2p);
			result = ArrayMath.compare(v, r) == 0;
			ArrayMath.releaseArr(v);
		end
		if (callback) then
			callback(result)
		end
		return result;
	end
	DSA.verifySignature = verifySignature;
end
local Base64 = { }
do
	local concat = table.concat;
	local b = string.byte;
	local tblinsert = table.insert
	local strchar = string.char
	local arshift = Bit32S.arshift
	local band = Bit32S.band
	local bor = Bit32S.bor
	local lshift = Bit32S.lshift
	local rshift = Bit32S.rshift
	local floor = math.floor
	local function length(str)
		return #str;
	end
	local base64LU = {
		65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81,
		82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103,
		104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116,
		117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 56,
		57, 43, 47
	};
	local function toBase64(idx)
		return base64LU[idx + 1];
	end
	local base64RLU = {
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57,
		58, 59, 60, 61, -1, -1, -1, -2, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8,
		9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1,
		-1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1
	};
	local function fromBase64(idx)
		return base64RLU[idx + 1];
	end
	local function append(tbl, val)
		tblinsert(tbl, strchar(val));
	end
	function Base64.encode(src)
		local dst = { };
		local n1 = 0;
		local n2 = length(src) - length(src) % 3;
		local n3 = 0;
		while (n1 < n2) do
			local n4 = n1;
			while (n4 < n2) do
				local bits = bor(bor(lshift(b(src, n4 + 1), 16), lshift(b(src, n4 + 2), 8)),
						b(src, n4 + 3));
				n4 = n4 + 3;
				append(dst, toBase64(band(rshift(bits, 18), 63)));
				append(dst, toBase64(band(rshift(bits, 12), 63)));
				append(dst, toBase64(band(rshift(bits, 6), 63)));
				append(dst, toBase64(band(bits, 63)));
			end
			local n5 = floor((n2 - n1) / 3) * 4;
			n3 = n3 + n5;
			n1 = n2;
		end
		if (n1 < length(src)) then
			local n4 = b(src, n1 + 1);
			n1 = n1 + 1;
			append(dst, toBase64(arshift(n4, 2)));
			if (n1 == length(src)) then
				append(dst, toBase64(band(lshift(n4, 4), 63)));
				append(dst, 61);
			else
				local n5 = b(src, n1 + 1);
				append(dst, toBase64(bor(band(lshift(n4, 4), 63), arshift(n5, 4))));
				append(dst, toBase64(band(lshift(n5, 2), 63)));
			end
			append(dst, 61);
		end
		return concat(dst);
	end
	function Base64.decode(src)
		local dst = { };
		pcall(function()
			local n1 = 0;
			local n2 = 0;
			local n3 = 18;
			while (n1 < length(src)) do
				if ((n3 == 18) and (n1 + 4 < length(src))) then
					local n4 = n1 + band((length(src) - n1), 12);
					while (n1 < n4) do
						local b1 = fromBase64(b(src, n1 + 1));
						local b2 = fromBase64(b(src, n1 + 2));
						local b3 = fromBase64(b(src, n1 + 3));
						local b4 = fromBase64(b(src, n1 + 4));
						if ((b1 < 0) or (b2 < 0) or (b3 < 0) or (b4 < 0)) then
							break ;
						end
						n1 = n1 + 4;
						local n5 = bor(bor(lshift(b1, 18), lshift(b2, 12)),
								bor(lshift(b3, 6), b4));
						append(dst, band(arshift(n5, 16), 255));
						append(dst, band(arshift(n5, 8), 255));
						append(dst, band(n5, 255));
					end
					if (n1 >= length(src)) then
						break ;
					end
				end
				n1 = n1 + 1;
				local n4 = b(src, n1);
				if (n4 == 61) then
					break ;
				end
				n4 = fromBase64(n4);
				n2 = bor(n2, lshift(n4, n3));
				n3 = n3 - 6;
				if (n3 < 0) then
					append(dst, band(arshift(n2, 16), 255));
					append(dst, band(arshift(n2, 8), 255));
					append(dst, band(n2, 255));
					n3 = 18;
					n2 = 0;
				end
			end
			if (n3 == 6) then
				append(dst, band(arshift(n2, 16), 255));
			elseif (n3 == 0) then
				append(dst, band(arshift(n2, 16), 255));
				append(dst, band(arshift(n2, 8), 255));
			end
		end)
		return concat(dst);
	end
end
local String = { }
addon.string = String
do
	local strformat = string.format
	local strgmatch = string.gmatch
	local strbyte = string.byte
	local tblconcat = table.concat
	local tblinsert = table.insert
	function String.split(str, regex)
		local t = {}
		for part in strgmatch(str, regex) do
			tblinsert(t, part)
		end
		return t
	end
	function String.toHex(str)
		local t = { }
		for i = 1, #str do
			tblinsert(t, strformat("%02x", strbyte(str, i)));
		end
		return tblconcat(t);
	end
end
local StringBuilder = { }
do
	local tblconcat = table.concat
	local tblinsert = table.insert
	function StringBuilder.new()
		return CreateFromMixins(StringBuilder);
	end
	function StringBuilder:append(val)
		tblinsert(self, val);
		return self;
	end
	function StringBuilder:toString()
		return tblconcat(self);
	end
end
addon.data.loadData("TomCatsComponents",
           { "ID", "Name", "Title", "Retail Compatible", "Classic Compatible" },
           {
               { 1, "TomCats", "TomCat's Tours (Core)", true, true },
               { 2, "TomCats-Complete", "Complete", true, false },
               { 3, "TomCats-ArathiHighlandsRares", "Rares of Arathi Highlands", true, false },
               { 4, "TomCats-DarkshoreRares", "Rares of Darkshore", true, false },
               { 5, "TomCats-Mechagon", "Mechagon", true, false },
               { 6, "TomCats-Nazjatar", "Nazjatar", true, false },
               { 7, "TomCats-Nzoth", "Rares of N'zoth", true, false },
               { 8, "TomCats-WarfrontsCommandCenter", "Warfronts Command Center", true, false },
               { 9, "Coordinates", "Coordinates", true, true },
               { 10, "TomCats-ChildrensWeek", "Children's Week", true, false },
               { 11, "TomCats-HallowsEnd", "Hallow's End", true, false },
               { 12, "TomCats-Hivemind", "The Hivemind", true, false },
               { 13, "TomCats-LoveIsInTheAir", "Love is in the Air", true, false },
               { 14, "TomCats-LunarFestival", "Lunar Festival", true, false },
               { 15, "TomCats-Noblegarden", "Noblegarden", true, false },
           }
)
local TomCatsPublicKey = {
	p = String.toHex(Base64.decode("/X9TgR11EilS30qcLuzk5/YRt1I870QAwx4/gLZRJmlFXUAiUftZPY1Y+r/F9bow9subVWzXgTuAHTRv8mZgt2uZUKWkn5/oBHsQIsJPu6nX/rfGG/g7V+fGqKYVDwT7g/bTxR7DAjVUE1oWkTL2dfOuK2HXKu/yIgMZndFIAcc=")),
	q = String.toHex(Base64.decode("l2BQjxUjC8yykrmCouuEC/BYHPU=")),
	g = String.toHex(Base64.decode("9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSo=")),
	y = String.toHex(Base64.decode("cpzBEYJpD5KWcxkYtd3a4eHsPqyGFLzG8s65YioZpy1XxQ2Nl8WgAvW8N/ltbqarEIXITotc9P250uEmcJTlei5xw1rPCoX5TnoblTNcF2Hmup4q806lzSysJwQS5CKLLAJjuejkT2POJpDcz5Zfg++u6kjgDJocqDokqGOlVFc=")),
}
if (TomCats and TomCats.ReconcileVersionInfo) then
	TomCats.ReconcileVersionInfo({
		messageID = 1583846119,
		encoded = "XZGZYJf9Ec1k5QWPQ1TfBuQne+MQgCQKV56imu0rBrcJwkc7x8rIMl5nkucBAQUAAgEEAwMBBAYEAQQIBQEEBgYBBAYHAQQXCAECCAkCBgAKAQADCwEDBAwAAQYNAQASDgEAGg8BAAQ="
	})
end
local MESSAGE_TYPE = {
	OFFER   = 1,
	DECLINE = 2,
	ACCEPT  = 3,
	DATA = 4,
}
local MESSAGE_SUBTYPE = {
	VERSIONINFO = 1
}
local MessageRouter = { }
do
	local messageHandlers = { }
	for _, messageType in pairs(MESSAGE_TYPE) do
		messageHandlers[messageType] = { }
	end
	local function RouteMessage(_, _, prefix, text, channel, sender, target, zoneChannelID, localID, name, instanceID)
		if (sender == addon.currentCharacterFullName or prefix ~= "TomCats") then return end
		local messageType = string.byte(text)
		local messageTypeHandler = messageHandlers[messageType]
		if (messageTypeHandler) then
			local messageSubType = string.byte(text,2)
			local messageSubTypeHandler = messageTypeHandler[messageSubType]
			if (messageSubTypeHandler) then
				messageSubTypeHandler(string.sub(text,3), channel, sender, target, zoneChannelID, localID, name, instanceID)
			end
		end
	end
	function MessageRouter.RegisterHandler(messageType, messageSubType, func)
		local messageTypeHandler = messageHandlers[messageType]
		if (messageTypeHandler) then
			messageTypeHandler[messageSubType] = func
		end
	end
	function MessageRouter.UnregisterHandler(messageType, messageSubType)
		local messageTypeHandler = messageHandlers[messageType]
		if (messageTypeHandler) then
			messageTypeHandler[messageSubType] = nil
		end
	end
	addon.events.registerEvent("CHAT_MSG_ADDON", RouteMessage);
	C_ChatInfo.RegisterAddonMessagePrefix("TomCats");
end
local VersionInfo = { };
do
	local ADDON_LOADED
	local addonChannelName
	local INCOMPLETE, PAUSED, COMPLETE = 0, 1, 2
	local channelSync = INCOMPLETE
	local channelSyncCoroutine
	local lshift = Bit32S.lshift
	local ignored = { }
	local lastBroadcastVersionInfo
	local syncLog = { }
	VersionInfo.messageID = tonumber("1583846119")
	VersionInfo.encoded = "XZGZYJf9Ec1k5QWPQ1TfBuQne+MQgCQKV56imu0rBrcJwkc7x8rIMl5nkucBAQUAAgEEAwMBBAYEAQQIBQEEBgYBBAYHAQQXCAECCAkCBgAKAQADCwEDBAwAAQYNAQASDgEAGg8BAAQ="
	local function BroadcastVersionInfo()
		local channelID = GetChannelName(addonChannelName)
		if (channelID) then
			C_ChatInfo.SendAddonMessage("TomCats",
					string.char(MESSAGE_TYPE.DATA) .. string.char(MESSAGE_SUBTYPE.VERSIONINFO) .. VersionInfo.encoded,
					"CHANNEL",
					channelID)
		end
	end
	local function IsRebroadcastNeeded(versionInfo)
		for _, logItem in ipairs(syncLog) do
			if (versionInfo.messageID > logItem.negotiatedVersion
					and versionInfo.time < logItem.time
					and versionInfo.messageID >= lastBroadcastVersionInfo.messageID
					and logItem.time > lastBroadcastVersionInfo.time) then
				return true
			end
		end
		return false
	end
	function TomCats.ReconcileVersionInfo(versionInfo)
		if ((not VersionInfo.messageID) or (versionInfo.messageID > VersionInfo.messageID)) then
			VersionInfo.messageID = versionInfo.messageID
			VersionInfo.encoded = versionInfo.encoded
			if (IsAddOnLoaded("TomCats")) then
				addon.savedVariables.account.versionInfo = {
					messageID = VersionInfo.messageID,
					encoded = VersionInfo.encoded
				}
			end
		end
	end
	local function DecodeVersionInfo(versionInfo)
		if (type(versionInfo) == "string" ) then
			versionInfo = {
				encoded = versionInfo
			}
		end
		local decoded = Base64.decode(versionInfo.encoded)
		if (not versionInfo.signature) then
			versionInfo.signature = {
				r = String.toHex(string.sub(decoded,1,20)),
				s = String.toHex(string.sub(decoded, 21,40))
			}
		end
		if (not versionInfo.messageID) then
			versionInfo.messageID = lshift(string.byte(decoded, 41), 24) + lshift(string.byte(decoded,
					42), 16) + lshift(string.byte(decoded, 43),
					8) + string.byte(decoded, 44)
		end
		if (not versionInfo.message) then
			versionInfo.message = string.sub(decoded, 41)
		end
		versionInfo.time = time()
		return versionInfo
	end
	local numEntries = GetNumAddOns();
	for i = 1, numEntries do
		local messageID = GetAddOnMetadata(i, "X-TomCats-VersionMessageID")
		if (messageID) then
			local versionInfo = GetAddOnMetadata(i, "X-TomCats-VersionMessage")
			TomCats.ReconcileVersionInfo({
				messageID = tonumber(messageID),
				encoded = versionInfo
			})
		end
	end
	MessageRouter.RegisterHandler(MESSAGE_TYPE.OFFER, MESSAGE_SUBTYPE.VERSIONINFO,
		function(...)
			local text = select(1, ...)
			local sender = select(3, ...)
			local offeredVersion = tonumber(text) or 0
			local negotiatedVersion
			if (offeredVersion == VersionInfo.messageID) then
				C_ChatInfo.SendAddonMessage("TomCats",
						string.char(MESSAGE_TYPE.DECLINE) .. string.char(MESSAGE_SUBTYPE.VERSIONINFO), "WHISPER",
						sender .. "---");
				negotiatedVersion = VersionInfo.messageID
			elseif (offeredVersion > VersionInfo.messageID) then
				C_ChatInfo.SendAddonMessage("TomCats",
						string.char(MESSAGE_TYPE.ACCEPT) .. string.char(MESSAGE_SUBTYPE.VERSIONINFO), "WHISPER",
						sender .. "---");
				negotiatedVersion = offeredVersion
			else
				C_ChatInfo.SendAddonMessage("TomCats",
						string.char(MESSAGE_TYPE.DATA) .. string.char(MESSAGE_SUBTYPE.VERSIONINFO) .. VersionInfo.encoded,
						"WHISPER",
						sender .. "---");
				negotiatedVersion = VersionInfo.messageID
			end
			table.insert(syncLog, { messageID = negotiatedVersion, time = time() })
		end
	)
	MessageRouter.RegisterHandler(MESSAGE_TYPE.DECLINE, MESSAGE_SUBTYPE.VERSIONINFO,
			function(_, channel)
				if (channel == "WHISPER") then
					channelSync = COMPLETE
				end
			end
	)
	MessageRouter.RegisterHandler(MESSAGE_TYPE.ACCEPT, MESSAGE_SUBTYPE.VERSIONINFO,
			function(_, channel)
				if (channel == "WHISPER") then
					channelSync = COMPLETE
					BroadcastVersionInfo()
				end
			end
	)
	MessageRouter.RegisterHandler(MESSAGE_TYPE.DATA, MESSAGE_SUBTYPE.VERSIONINFO,
			function(text, channel, sender)
				if (ignored[sender]) then
					return
				end
				local versionInfo = DecodeVersionInfo(text)
				if (channel == "WHISPER") then
					channelSync = PAUSED
				end
				if (channel == "CHANNEL") then
					lastBroadcastVersionInfo = versionInfo
				end
				BackgroundProcessing.addToQueue(function()
					if (ignored[sender]) then
						return
					end
					if (channel == "WHISPER") then
						channelSync = PAUSED
					end
					if (versionInfo.messageID > VersionInfo.messageID) then
						local verified = DSA.verifySignature(versionInfo.message, versionInfo.signature, TomCatsPublicKey)
						if (verified) then
							TomCats.ReconcileVersionInfo(versionInfo)
							if (channel == "WHISPER") then
								channelSync = COMPLETE
								coroutine.resume(channelSyncCoroutine)
							end
							if (IsRebroadcastNeeded(versionInfo)) then
								BroadcastVersionInfo()
							end
						else
							ignored[sender] = true
							if (channel == "WHISPER") then
								channelSync = INCOMPLETE
								if (channelSyncCoroutine) then
									coroutine.resume(channelSyncCoroutine)
								end
							end
						end
					else
						if (channel == "WHISPER") then
							channelSync = COMPLETE
							if (channelSyncCoroutine) then
								coroutine.resume(channelSyncCoroutine)
							end
						end
					end
				end)
			end
	)
	function VersionInfo.ReconcileForChannel(_addonChannelName, usernames)
		channelSyncCoroutine = coroutine.create(function()
			addonChannelName = _addonChannelName
			channelSync = INCOMPLETE
			while (channelSync < COMPLETE) do
				if (#usernames == 0) then
					channelSync = COMPLETE
				else
					local username = table.remove(usernames, math.random(#usernames));
					if (username ~= addon.currentCharacterFullName) then
						C_ChatInfo.SendAddonMessage("TomCats",
								string.char(MESSAGE_TYPE.OFFER) .. string.char(MESSAGE_SUBTYPE.VERSIONINFO) .. VersionInfo.messageID,
								"WHISPER", username .. "---");
						C_Timer.NewTimer(2, function()
							if (channelSync == INCOMPLETE) then
								coroutine.resume(channelSyncCoroutine)
							end
						end)
						coroutine.yield()
					end
				end
			end
		end)
		coroutine.resume(channelSyncCoroutine)
	end
	function ADDON_LOADED(_, _, name)
		if (name == "TomCats") then
			if (addon.savedVariables.account.versionInfo) then
				TomCats.ReconcileVersionInfo(addon.savedVariables.account.versionInfo)
			end
			addon.events.unregisterEvent("ADDON_LOADED", ADDON_LOADED)
		end
	end
	addon.events.registerEvent("ADDON_LOADED", ADDON_LOADED)
end
do
	local CleanAddonChannels
	local GetAddonChannelDisplayIndex
	local GetAddonChannelUsernames
	local Initialize
	local JoinAddonChannel
	local PauseForFrame
	local ADDON_LOADED
	local addonChannelBaseName = "TomCats"
	local addonChannelName = addonChannelBaseName
	function CleanAddonChannels()
		local thread = coroutine.running()
		if (not EnumerateServerChannels()) then
			local WaitForChannels
			WaitForChannels = function()
				if (EnumerateServerChannels()) then
					addon.events.unregisterEvent("ON_UPDATE", WaitForChannels)
					coroutine.resume(thread)
				end
			end
			addon.events.registerEvent("ON_UPDATE", WaitForChannels)
			coroutine.yield()
		end
		local channels = { }
		local channelList = { GetChannelList() }
		local matchPattern = "^" .. string.upper(addonChannelBaseName)
		for i = 1, #channelList, 3 do
			local channelName = string.upper(channelList[i + 1])
			if (string.match(channelName, matchPattern)) then
				LeaveChannelByName(channelName)
				channels[channelName] = true
			end
		end
		local function RemoveChannel(_, _, text, _, _, _, _, _, _, _, channelBaseName)
			if (text == "YOU_LEFT") then
				channels[string.upper(channelBaseName)] = nil
				coroutine.resume(thread)
			end
		end
		addon.events.registerEvent("CHAT_MSG_CHANNEL_NOTICE", RemoveChannel)
		while (next(channels) ~= nil) do
			coroutine.yield()
		end
		addon.events.unregisterEvent("CHAT_MSG_CHANNEL_NOTICE", RemoveChannel)
		local function HasChannel()
			channelList = { GetChannelList() }
			for i = 1, #channelList, 3 do
				if (string.match(string.upper(channelList[i+1]), matchPattern)) then
					return true
				end
			end
			return false
		end
		while(HasChannel()) do
			PauseForFrame()
		end
		channelList = { GetChannelList() }
		for i = 1, #channelList / 3 do
			local offset = ((i - 1) * 3) + 1
			if (channelList[offset] ~= i) then
				C_ChatInfo.SwapChatChannelsByChannelIndex(i, channelList[offset])
			end
		end
	end
	function GetAddonChannelDisplayIndex()
		local count = GetNumDisplayChannels()
		local displayIndex
		for i = count, 1, -1 do
			local channelName = GetChannelDisplayInfo(i)
			if (channelName == addonChannelName) then
				displayIndex = i
				return i
			end
		end
	end
	function GetAddonChannelUsernames()
		local thread = coroutine.running()
		local displayIndex = GetAddonChannelDisplayIndex()
		local selectedDisplayChannel = GetSelectedDisplayChannel()
		if ((not selectedDisplayChannel) or (selectedDisplayChannel ~= displayIndex)) then
			local ChannelRosterUpdate
			ChannelRosterUpdate = function(_, _, channelDisplayIndex)
				if (displayIndex == channelDisplayIndex) then
					addon.events.unregisterEvent("CHANNEL_ROSTER_UPDATE", ChannelRosterUpdate)
					coroutine.resume(thread)
				end
			end
			addon.events.registerEvent("CHANNEL_ROSTER_UPDATE", ChannelRosterUpdate)
			SetSelectedDisplayChannel(displayIndex)
			coroutine.yield()
		end
		local addonChannelUsernames = { }
		local index = 1
		local username
		repeat
			username = C_ChatInfo.GetChannelRosterInfo(displayIndex, index)
			if (username) then
				addonChannelUsernames[index] = username
			end
			index = index + 1
		until (not username)
		return addonChannelUsernames
	end
	function Initialize()
		C_ChatInfo.RegisterAddonMessagePrefix("TomCats")
		coroutine.wrap(function()
			CleanAddonChannels()
			if (JoinAddonChannel()) then
				VersionInfo.ReconcileForChannel(addonChannelName, GetAddonChannelUsernames())
				--todo: Inform user if they cannot join the addon channel
			end
		end)()
	end
	function JoinAddonChannel()
		local channelList = { GetChannelList() }
		if (#channelList == MAX_WOW_CHAT_CHANNELS * 3) then
			return false
		end
		local thread = coroutine.running()
		UIParent:UnregisterEvent("CHANNEL_PASSWORD_REQUEST")
		local addonChannelAltNum = -1
		local joined = false
		local function ConfirmChannelJoined(...)
			local channelBaseName = select(11, ...)
			if (channelBaseName == addonChannelName) then
				local text = select(3, ...)
				if (text == "WRONG_PASSWORD") then
					addonChannelAltNum = addonChannelAltNum + 1
					addonChannelName = addonChannelBaseName .. addonChannelAltNum
					coroutine.resume(thread)
				elseif (text == "YOU_CHANGED") then
					joined = true
					UIParent:RegisterEvent("CHANNEL_PASSWORD_REQUEST")
					coroutine.resume(thread)
				end
			end
		end
		addon.events.registerEvent("CHAT_MSG_CHANNEL_NOTICE", ConfirmChannelJoined)
		while (not joined) do
			PauseForFrame()
			JoinTemporaryChannel(addonChannelName)
			coroutine.yield()
		end
		addon.events.unregisterEvent("CHAT_MSG_CHANNEL_NOTICE", ConfirmChannelJoined)
		return true
	end
	function PauseForFrame()
		local thread = coroutine.running()
		local OnUpdate
		OnUpdate = function()
			addon.events.unregisterEvent("ON_UPDATE", OnUpdate)
			coroutine.resume(thread)
		end
		addon.events.registerEvent("ON_UPDATE", OnUpdate)
		coroutine.yield()
	end
	function ADDON_LOADED(_, _, name)
		if (name == "TomCats") then
			addon.events.unregisterEvent("ADDON_LOADED", ADDON_LOADED)
			Initialize()
		end
	end
	addon.events.registerEvent("ADDON_LOADED", ADDON_LOADED)
	local function FilterTomCatsMessages(...)
		local channelBaseName = select(11, ...)
		if (channelBaseName == addonChannelName) then return true end
		return
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", FilterTomCatsMessages)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE_USER", FilterTomCatsMessages)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", FilterTomCatsMessages)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", FilterTomCatsMessages)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", FilterTomCatsMessages)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", FilterTomCatsMessages)
	local function FilterPlayerNotFoundMessages(_, _, text)
		return string.match(text,"[-][-][-]") ~= nil;
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", FilterPlayerNotFoundMessages);
	local ChatEdit_UpdateHeader_Orig = ChatEdit_UpdateHeader
	local ChatFrameEditBoxInfo = { }
	local function ChatEdit_UpdateHeader(editBox)
		local channelTarget = editBox:GetAttribute("channelTarget")
		local channelTargetNum = tonumber(channelTarget)
		local id = GetChannelName(addonChannelName)
		local name = editBox:GetName()
		if (channelTargetNum and id and channelTargetNum == id) then
			local editBoxInfo = ChatFrameEditBoxInfo[name]
			if (not editBoxInfo) then
				editBoxInfo = {	chatType = "SAY" }
				ChatFrameEditBoxInfo[name] = editBoxInfo
			end
			editBox:SetAttribute("channelTarget", editBoxInfo.channelTarget)
			editBox:SetAttribute("chatType", editBoxInfo.chatType)
			ChatEdit_UpdateHeader_Orig(editBox)
		else
			ChatFrameEditBoxInfo[name] = {
				channelTarget = channelTarget,
				chatType = editBox:GetAttribute("chatType")
			}
		end
	end
	hooksecurefunc("ChatEdit_UpdateHeader", ChatEdit_UpdateHeader);
end
