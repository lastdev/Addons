local addonName = ...
local CS = CreateFrame("Frame")
local Settings = {}

local internal = {
	uldumMapID = 249,
	realFigurineID = 50409, -- 50409 is the real figurine
	fakeFigurineID = 50410, -- 50410 is the fake figurine
	nameplate = nil,
	previousNameplate = nil,
	recentSpawnID = nil,
	recentlyClicked = nil,
	recentlyDisplayedEntry = nil,
	recentlyDisplayed = nil,
	previousWarmodeValue = nil,
	cacheShowFriends = nil,
	cacheShowAll = nil,
	cacheShowFriendlyNPCs = nil,
	nameplateEvents = {
		"NAME_PLATE_UNIT_ADDED",
		"NAME_PLATE_UNIT_REMOVED"
	},
	events = {
		"ADDON_LOADED",
		"PLAYER_LOGIN",
		"PLAYER_LOGOUT",
		"ZONE_CHANGED_NEW_AREA",
		"PLAYER_FLAGS_CHANGED"
	},
	exportText = "",
}


local timeFormatter = CreateFromMixins(SecondsFormatterMixin);
timeFormatter:Init(1, SecondsFormatter.Abbreviation.Truncate);

hooksecurefunc(C_CVar, "SetCVar", function(cvar, value)
	if internal.cvarsChanged then return end
	if cvar == "nameplateShowFriends" then
		internal.cacheShowFriends = value
	elseif cvar == "nameplateShowAll" then
		internal.cacheShowAll = value
	elseif cvar == "nameplateShowFriendlyNPCs" then
		internal.cacheShowFriendlyNPCs = value
	end
end)

local function AddMessage(...) _G.DEFAULT_CHAT_FRAME:AddMessage(strjoin(" ", tostringall(...))) end
local function RegisterEvents(frame, e) for i=1, #e do frame:RegisterEvent(e[i]) end end
local function UnregisterEvents(frame, e) for i=1, #e do frame:UnregisterEvent(e[i]) end end

local function getSortedKeys(tbl)
	local keys = {}
	for key in pairs(tbl) do table.insert(keys, key) end
	if #keys > 1 then
		table.sort(keys, function(a, b) return a > b end)
	end
    local index = 0
	local function iter()
		index = index + 1
		return keys[index], tbl[keys[index]]
	end
    return iter
end

local AlertFrame = CreateFrame("Button", "CamelSpotterAlertFrame", UIParent, "BackdropTemplate")
function AlertFrame:Create()
	if self.Text then return end

	self:RegisterEvent("DISPLAY_SIZE_CHANGED")
	self:RegisterEvent("UI_SCALE_CHANGED")
	self:RegisterForClicks("LeftButtonDown", "RightButtonUp")
	self:SetFlattensRenderLayers(true)
	PixelUtil.SetPoint(self, "CENTER", UIParent, "CENTER", 0, 200)
	self:SetMovable(true)
	self:SetClampedToScreen(true)
	self:RegisterForDrag("LeftButton")
	self:SetScript("OnDragStart", self.StartMoving)
	self:SetScript("OnDragStop", self.StopMovingOrSizing)
	--self:SetClipsChildren(true)
	CS:AddAnimation(self, true)
	local UpdateBorders = function()
		local size = 768.0/(select(2, GetPhysicalScreenSize()) * self:GetEffectiveScale())
		if not self.bg then
			self.bg = self:CreateTexture(nil, "BACKGROUND", nil, 0)
			self.bg:SetAllPoints()
			self.t = self:CreateTexture(nil, "BORDER")
			self.b = self:CreateTexture(nil, "BORDER")
			self.l = self:CreateTexture(nil, "BORDER")
			self.r = self:CreateTexture(nil, "BORDER")
		end

		PixelUtil.SetPoint(self.t, "BOTTOMLEFT", self, "TOPLEFT", -size, -1, 1)
		PixelUtil.SetPoint(self.t, "BOTTOMRIGHT", self, "TOPRIGHT", size, 0, 0)
		PixelUtil.SetHeight(self.t, size)

		PixelUtil.SetPoint(self.b, "TOPLEFT", self, "BOTTOMLEFT", -size, 1, -1)
		PixelUtil.SetPoint(self.b, "TOPRIGHT", self, "BOTTOMRIGHT", size, 0, 0)
		PixelUtil.SetHeight(self.b, size)

		PixelUtil.SetPoint(self.l, "TOPRIGHT", self, "TOPLEFT", 1, 0, 0)
		PixelUtil.SetPoint(self.l, "BOTTOMRIGHT", self, "BOTTOMRIGHT", -1, -1, 1)
		PixelUtil.SetWidth(self.l, size)

		PixelUtil.SetPoint(self.r, "TOPLEFT", self, "TOPRIGHT", -1, 0, 0)
		PixelUtil.SetPoint(self.r, "BOTTOMLEFT", self, "BOTTOMRIGHT", 1, 1, -1)
		PixelUtil.SetWidth(self.r, size)
	end

	UpdateBorders()

	self:SetScript("OnEvent", function()
		UpdateBorders()
	end)

	self:SetScript("OnShow", function()
		UpdateBorders()
	end)

	self:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			self.animationGroup.Hide:Play()
		else
			self.clickAnimation:Play()
		end
	end)

    self.tooltip = "|T1065418:16:16:0:0:2048:1024:2009:2041:35:67|tLeft-click to drag and move.\n|T1065418:16:16:0:0:2048:1024:2009:2041:69:101|tRight-click to close."
	self:SetScript("OnEnter", function(self)
		if self.tooltip then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -4)
			GameTooltip:SetText(self.tooltip, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, 1, true)
			GameTooltip:Show()
		end
	end)

	self:SetScript("OnLeave", GameTooltip_Hide)
	self.Text = self:CreateFontString(nil, nil, "GameFontHighlightLarge")
	self.Text:SetPoint("CENTER", self, "CENTER")
	self.Text:SetDrawLayer("ARTWORK", 8)

	self.clickAnimation = self:CreateAnimationGroup()
	local alpha = self.clickAnimation:CreateAnimation("Alpha")
	alpha:SetFromAlpha(0)
	alpha:SetToAlpha(1)
	alpha:SetDuration(0.3)
	alpha:SetScript("OnUpdate", function(self)
		local p = self:GetSmoothProgress()
		self:SetSmoothProgress(p^(p * 2))
    end)

	self:Hide()
end

function AlertFrame:SetColors(bgcolor, bordercolor)
	self.bg:SetColorTexture(unpack(bgcolor))
	self.t:SetColorTexture(unpack(bordercolor))
	self.b:SetColorTexture(unpack(bordercolor))
	self.l:SetColorTexture(unpack(bordercolor))
	self.r:SetColorTexture(unpack(bordercolor))
end

function CS:ResetCVars()
	internal.cvarsChanged = true
	C_CVar.SetCVar("nameplateShowFriends", internal.cacheShowFriends)
	C_CVar.SetCVar("nameplateShowAll", internal.cacheShowAll)
	C_CVar.SetCVar("nameplateShowFriendlyNPCs", internal.cacheShowFriendlyNPCs)
	C_Timer.After(1, function() internal.cvarsChanged = false end)
end

function CS:SetCVars()
	if not internal.recentlyDisplayedEntry then
		internal.recentlyDisplayedEntry = true
		local displayText = "Camel Spotter"
		local link = LinkUtil.FormatLink("addon", displayText, "CamelSpotter", "help")
		AddMessage(format("|cffEEE4AE%s:|r %s", link, "Friendly nameplates have been activated for this zone."))
		if TomTom then
			displayText = "[Click Here]"
			link = LinkUtil.FormatLink("addon", displayText, "CamelSpotter", "setloc")
			AddMessage(format("|cffEEE4AE%s:|r |cff85DBF3%s|r %s", "Camel Spotter", link, "for TomTom waypoints."))
		end
		C_Timer.After(60, function() internal.recentlyDisplayedEntry = false end)
	end
	internal.cvarsChanged = true
	C_CVar.SetCVar("nameplateShowAll", "1")
	C_CVar.SetCVar("nameplateShowFriends", "1")
	C_CVar.SetCVar("nameplateShowFriendlyNPCs", "1")
	C_Timer.After(1, function() internal.cvarsChanged = false end)
end

function CS:DBMigration()
	if not Settings.DBVersion then
		local temp = {}
		for realmName, serverInfo in pairs(Settings.Servers) do
			temp[realmName] = {}
			for _, info in ipairs(serverInfo) do
				local mode, x, y, spawnTime, real = strsplit(":", info.info)
				real = real == "true" and true or false
				if real then
					temp[realmName][tonumber(spawnTime)] = { time = info.t, mode = tonumber(mode), x = tonumber(x), y = tonumber(y), real = real }
				else
					temp[realmName][tonumber(spawnTime)] = { time = info.t, mode = tonumber(mode), x = tonumber(x), y = tonumber(y)}
				end
			end
		end
		Settings.Servers = temp

		Settings.DBVersion = 1
	end
end

function CS:IsMapUldum()
	return C_Map.GetBestMapForUnit("player") == internal.uldumMapID
end

function CS:GetWarmodeAndTimewalkingText()
	local warmodeText = ""
	local timewalkingText = ""

	if C_PvP.IsWarModeDesired() then
		warmodeText = "WM On"
	else
		warmodeText = "WM Off"
	end

	if C_PlayerInfo.IsPlayerInChromieTime() then
		timewalkingText = "CT "
	end

	return warmodeText, timewalkingText
end

function CS:BetterTime()
	return string.gsub(BetterDate(CHAT_TIMESTAMP_FORMAT or '%H:%M', time()), "(.-) $", "%1")
end

---@return number
function CS:GetMode()
	local warmodeNum = C_PvP.IsWarModeDesired() and 2 or 1
	local mode = C_PlayerInfo.IsPlayerInChromieTime() and warmodeNum+2 or warmodeNum
	return mode
end

function CS:ReportLastSeen()
	if internal.recentlyDisplayed then return end
	C_Timer.After(30, function() internal.recentlyDisplayed = false end)
	local realmName = GetNormalizedRealmName()
	if not Settings.Servers[realmName] then return end
	local mode = self:GetMode()
	for _, info in getSortedKeys(Settings.Servers[realmName]) do
		if info.mode == mode then
			local time = GetServerTime() - info.time
			local warmodeText, timewalkingText = self:GetWarmodeAndTimewalkingText()
			AddMessage(string.format("|cffEEE4AE%s:|r %s|cff37DB33 %s|r |cff37DB33(%s%s)|r", "Camel Spotter", "Mysterious Camel Figurine last seen:", timeFormatter:Format(time, false, false), timewalkingText, warmodeText))
			internal.recentlyDisplayed = true
			break;
		end
	end
end

function CS:RecordLastSeen(unitID, spawnTime)
	local realmName = GetNormalizedRealmName()
	local mode = self:GetMode()
	Settings.Servers[realmName] = Settings.Servers[realmName] or {}
	local playerPosition = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player")
	if playerPosition then
		local x = string.format("%.2f", playerPosition.x * 100)
		local y = string.format("%.2f", playerPosition.y * 100)
		local real = unitID == internal.realFigurineID and true or false
		if real then
			Settings.Servers[realmName][spawnTime] = { time = GetServerTime(), mode = mode, x = x, y = y, real = real }
		else
			Settings.Servers[realmName][spawnTime] = { time = GetServerTime(), mode = mode, x = x, y = y }
		end
	end
end

function CS:Announce(unitID, spawnTime)
	local warmodeText, timewalkingText = self:GetWarmodeAndTimewalkingText()
	local playerPosition = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player")
	local positionText = string.format("(%.2f, %.2f)", playerPosition.x*100, playerPosition.y*100)
	local realmName = GetRealmName()
	if unitID == internal.realFigurineID then
		PlaySound(63971, "Master")
		PlaySound(71678, "Master")
		local text = string.format("|cff3DD341%s|r |cffFFDD00%s", "Real Camel Figurine", self:BetterTime())
		AddMessage("|cffEEE4AECamel Spotter:|r", text.."|r ".. positionText)

		local buttonText = string.format("%s\n\n%s %s%s|r", text, realmName, timewalkingText, warmodeText)
		AlertFrame.Text:SetText(buttonText)
		local width = Round(AlertFrame.Text:GetStringWidth()) or 180
		PixelUtil.SetSize(AlertFrame, (width + 16), 62)
		AlertFrame.Text:SetTextColor(0, 200, 0, 1)

		local bgcolor = { 0, 0.2, 0, 0.8 }
		local bordercolor = { 0, 0.7, 0, 1 }
		AlertFrame:SetColors(bgcolor, bordercolor)
		AlertFrame.highlight:SetVertexColor(0, 0.7, 0, 0.2)
		AlertFrame.animationGroup.Highlight:Play()
		AlertFrame.animationGroup.Transition:Play()
		AlertFrame:Show()
	elseif unitID == internal.fakeFigurineID then
		--PlaySound(3175, "Master")
		--PlaySound(89712, "Master")
        PlaySoundFile([[Interface\AddOns\CamelSpotter\Media\Dust.ogg]], "Master")
		local text = string.format("|cffF72D55%s|r |cffFFDD00%s", "Fake Camel Figurine", self:BetterTime())
		AddMessage("|cffEEE4AECamel Spotter:|r", text.."|r ".. positionText)

		local buttonText = string.format("%s\n\n%s %s%s|r", text, realmName, timewalkingText, warmodeText)
		AlertFrame.Text:SetText(buttonText)
		local width = Round(AlertFrame.Text:GetStringWidth()) or 180
		PixelUtil.SetSize(AlertFrame, (width + 16), 64)
		AlertFrame.Text:SetTextColor(200, 0, 0, 1)

		local bgcolor = { 0.2, 0, 0, 0.8 }
		local bordercolor = { 0.7, 0, 0, 1 }
		AlertFrame:SetColors(bgcolor, bordercolor)
		AlertFrame.highlight:SetVertexColor(0.7, 0, 0, 0.2)
		AlertFrame.animationGroup.Highlight:Play()
		AlertFrame.animationGroup.Transition:Play()
		AlertFrame:Show()
	end
	local formattedTime = timeFormatter:Format(GetServerTime() - spawnTime, false, true)
	formattedTime = formattedTime == "" and SECONDS_ABBR:format(0) or formattedTime
	AddMessage(string.format("|cffEEE4AE%s|r %s %s %s", "Camel Spotter:", "Figurine has been up for", formattedTime, date("(%H:%M %d.%m)", spawnTime)))

	if Settings.ScreenshotEnabled then
		C_Timer.After(0.5, function() Screenshot() end)
	end
end

--#region Overlay
do
	local Overlay = {}
	Overlay.modelId = 948186
	Overlay.model = CreateFrame('PlayerModel', nil, WorldFrame)
	Overlay.model:SetModel(Overlay.modelId)
	Overlay.model:SetSize(80, 80)

	Overlay.fadeIn = Overlay.model:CreateAnimationGroup()
	Overlay.fadeIn:SetToFinalAlpha(true)
	local fadeIn = Overlay.fadeIn:CreateAnimation("Alpha")
	fadeIn:SetFromAlpha(0)
	fadeIn:SetToAlpha(1)
	fadeIn:SetDuration(0.2)

	internal.Overlay = Overlay
end

function CS:ShowOverlay(nameplate)
	if nameplate and internal.previousNameplate ~= nameplate then
		local model = internal.Overlay.model
		model:ClearAllPoints()
		model:SetPoint("BOTTOM", nameplate, "TOP", 0, -10)
		model:SetModel(internal.Overlay.modelId)
		model:Show()
		internal.Overlay.fadeIn:Play()
	end
end

function CS:HideOverlay()
	internal.previousNameplate = nil
	internal.Overlay.model:Hide()
end

function CS:UpdateOverlay(unit)
	if unit then
		internal.nameplate = C_NamePlate.GetNamePlateForUnit(unit)
		if internal.nameplate then
			self:ShowOverlay(internal.nameplate)
			internal.previousNameplate = internal.nameplate
		end
	end
end
--#endregion

function CS:GetUnitInfo(unit)
	local guid = UnitGUID(unit or "none")
	if not guid then return end
	local unitType, _, _, _, _, unitID, spawnUID  = strsplit("-", guid)
	if not spawnUID then return 0, 0 end
    if not unitType == "Creature" then return 0, 0 end
	return tonumber(unitID), spawnUID
end

function CS:GetSpawnTime(spawnUID)
	local time = GetServerTime()
	local spawnTime  = (time - (time % 2^23)) + bit.band(tonumber(spawnUID:sub(5), 16), 0x7fffff)
	if spawnTime > time then
		spawnTime = spawnTime - ((2^23) - 1);
	end

	return spawnTime
end

function CS:OnNameplateAdded(unit)
	if not unit then return end
	local unitID, spawnUID = self:GetUnitInfo(unit)
	if unitID == internal.realFigurineID or unitID == internal.fakeFigurineID then
		self:UpdateOverlay(unit)
		if spawnUID == internal.recentSpawnID then return end
		internal.recentSpawnID = spawnUID
		local spawnTime = self:GetSpawnTime(spawnUID)
		self:RecordLastSeen(unitID, spawnTime)
		self:Announce(unitID, spawnTime)
	end
end

function CS:OnNameplateRemoved(unit)
	local unitID = self:GetUnitInfo(unit)
	if unitID == internal.realFigurineID or unitID == internal.fakeFigurineID then
		self:HideOverlay()
	end
end

function CS:OnZoneChanged()
	if not internal.nameplateEventsRegistered and self:IsMapUldum() then
		AlertFrame:Create()
		self:SetCVars()
		self:ReportLastSeen()
		RegisterEvents(self, internal.nameplateEvents)
		internal.nameplateEventsRegistered = true
	elseif internal.nameplateEventsRegistered then
		self:ResetCVars()
		UnregisterEvents(self, internal.nameplateEvents)
		internal.nameplateEventsRegistered = false
	end
end

function CS:OnPlayerLogin()
	internal.cacheShowFriends = C_CVar.GetCVar("nameplateShowFriends")
	internal.cacheShowAll = C_CVar.GetCVar("nameplateShowAll")
	internal.cacheShowFriendlyNPCs = C_CVar.GetCVar("nameplateShowFriendlyNPCs")
	if not internal.nameplateEventsRegistered and self:IsMapUldum() then
		AlertFrame:Create()
		self:SetCVars()
		self:ReportLastSeen()
		RegisterEvents(self, internal.nameplateEvents)
		internal.nameplateEventsRegistered = true
	end

	internal.previousWarmodeValue = C_PvP.IsWarModeDesired()
end

function CS:OnEvent(e, ...)
	if e == "ADDON_LOADED" and addonName == ... then
		CamelSpotterDB = CamelSpotterDB or {}
		Settings = CamelSpotterDB
		Settings.WMON = nil
		Settings.WMOFF = nil
		Settings.Servers = Settings.Servers or {}
		self:DBMigration()
	elseif e == "PLAYER_LOGIN" then
		self:OnPlayerLogin()
	elseif e == "NAME_PLATE_UNIT_ADDED" then
		self:OnNameplateAdded(...)
	elseif e == "NAME_PLATE_UNIT_REMOVED" then
		self:OnNameplateRemoved(...)
	elseif e == "ZONE_CHANGED_NEW_AREA" then
		self:OnZoneChanged()
	elseif e == "PLAYER_FLAGS_CHANGED" then
		if (C_PvP.IsWarModeDesired() ~= internal.previousWarmodeValue) then
			internal.previousWarmodeValue = C_PvP.IsWarModeDesired()
			if not self:IsMapUldum() then return end
			self:ReportLastSeen()
			internal.recentSpawnID = nil
		end
	elseif e == "PLAYER_LOGOUT" then
		self:ResetCVars()
	end
end

local LOCATIONS = {
	{50.47,31.54},{52.23,28.04},{45.24,16.04},{34.32,19.63},{34.38,21.27},{33.68,25.38},{33.23,28.09},{29.90,24.90},{29.85,20.45},{31.96,45.29},{32.73,47.63},{25.40,51.07},{24.44,59.96},{22.09,64.06},{25.59,65.89},{26.27,65.09},{28.51,63.74},{30.42,62.67},{30.61,60.50},{33.08,60.13},{33.20,62.83},{30.99,66.37},{30.98,67.52},{31.50,69.26},{33.21,72.04},{33.27,67.78},{37.13,64.08},{38.28,60.70},{38.49,54.93},{40.84,49.75},{39.97,45.00},{40.10,43.40},{40.16,38.41},{46.25,44.58},{48.17,46.40},{51.80,49.34},{51.03,50.80},{50.48,50.65},{51.47,51.16},{52.14,51.21},{51.92,70.81},{50.42,72.22},{50.24,73.67},{49.13,75.91},{47.28,76.69},{51.14,79.79},{73.44,73.61},{69.87,58.13},{72.02,43.88},{64.66,30.27}
}

function CS:SetWaypoints()
	local currentUIMapID = C_Map.GetBestMapForUnit("player")
	local mapInfo = C_Map.GetMapInfo(internal.uldumMapID)
	local icon = "Interface\\AddOns\\CamelSpotter\\Media\\Icon"
	local icon_size = 12
	if TomTom then
		for _,v in pairs(LOCATIONS) do
			TomTom:AddWaypoint(internal.uldumMapID, v[1]/100, v[2]/100, {
				title = "|cffFFDD00Mysterious Camel Figurine|r\n|cffEEE4AECamel Spotter|r",
				minimap_icon = icon,
				minimap_icon_size = icon_size,
				worldmap_icon = icon,
				worldmap_icon_size = icon_size
			})
		end
		AddMessage(format("|cffEEE4AE%s:|r %s %s.", "Camel Spotter", "Waypoints added to", mapInfo.name))
		if currentUIMapID == internal.uldumMapID then
			TomTom:SetClosestWaypoint()
		end
		local displayText = "[Set Closest Waypoint when needed]"
		local link = LinkUtil.FormatLink("addon", displayText, "CamelSpotter", "closest")
		AddMessage(format("|cffEEE4AE%s:|r |cff85DBF3%s|r", "Camel Spotter", link))
	else
		AddMessage(format("|cffEEE4AE%s:|r |cff85DBF3%s|r", "Camel Spotter", "You need TomTom for this feature."))
	end
end

function CS:CreateExportDialog()
	local frame = CreateFrame("frame", nil, UIParent)
	frame:SetClipsChildren(true)
	frame:Hide()
	CS.ExportDialog = frame
	frame.background = frame:CreateTexture()
	frame.background:SetAllPoints()
	frame.background:SetColorTexture(0.05,0.05,0.05,0.9)
	frame.Text = frame:CreateFontString(nil, nil, "GameFontNormalMed1")
	frame.Text:SetPoint("CENTER", frame, "TOP", 0, -20)
	frame.Text:SetText("Export as CSV, CTRL+C to copy")
	frame:EnableMouse(true)
	frame:SetSize(400,200)
	frame:SetPoint("CENTER", 0 , 0)
	--frame:SetMovable(false)
	frame.EditBox = CreateFrame("EditBox", nil, frame)
	local offset = 40
	frame.EditBox:SetPoint("TOPLEFT",0,-offset)
	frame.EditBox:SetMultiLine(true)
	frame.EditBox:SetFontObject(ChatFontSmall)
	frame.EditBox:SetWidth(frame:GetWidth()-8)
	frame.EditBox:SetHeight(frame:GetHeight()-offset)
	frame.EditBox:SetAutoFocus(false)
	frame.EditBox:SetScript("OnEscapePressed", function() CS.ExportDialog.EditBox:HighlightText(0,0);CS.ExportDialog.animationGroup.Hide:Play() end)
	frame.EditBox:SetScript("OnEditFocusLost", function() CS.ExportDialog.EditBox:HighlightText(0,0);CS.ExportDialog.animationGroup.Hide:Play() end)
	frame.EditBox:SetScript("OnTextChanged", function(self) self:SetText(internal.exportText) self:HighlightText() end)
	local animationGroup = self:AddAnimation(frame)
	animationGroup.Transition.Translation:SetScript("OnFinished", function()
		CS.ExportDialog.EditBox:HighlightText()
		CS.ExportDialog.EditBox:SetFocus()
	end)
end

function CS:AddAnimation(frame, addHighlight)
	frame.animationGroup = frame.animationGroup or {}
	if addHighlight then
		local hl_frame = CreateFrame("Button", nil, frame)
		hl_frame:EnableMouse(false)
		hl_frame:SetAllPoints()
		frame:SetClipsChildren(true)
		local highlight = frame:CreateTexture(nil)
		highlight:SetAtlas("ChallengeMode-SoftYellowGlow")
		highlight:SetDesaturated(true)
		highlight:SetSize(400,400)
		highlight:SetVertexColor(1,1,1,1)
		highlight:SetBlendMode("ADD")
		highlight:SetPoint("CENTER", frame, "BOTTOM", 0,0)
		highlight:SetDrawLayer("ARTWORK", -1)
		frame.highlight = highlight
		frame.animationGroup.Highlight = highlight:CreateAnimationGroup()
		frame.animationGroup.Highlight:SetLooping("BOUNCE")
		frame.animationGroup.Highlight.Alpha = frame.animationGroup.Highlight:CreateAnimation('Alpha')
		local alpha = frame.animationGroup.Highlight.Alpha
		alpha:SetStartDelay(1)
		alpha:SetFromAlpha(0.2)
		alpha:SetToAlpha(0.7)
		alpha:SetDuration(2)
	end

	do
		frame.animationGroup.Transition = frame:CreateAnimationGroup()
		frame.animationGroup.Transition:SetToFinalAlpha(true)
		frame.animationGroup.Transition.Alpha = frame.animationGroup.Transition:CreateAnimation('Alpha')
		frame.animationGroup.Transition.Scale = frame.animationGroup.Transition:CreateAnimation('scale')
		frame.animationGroup.Transition.Translation = frame.animationGroup.Transition:CreateAnimation('Translation')
		frame.animationGroup.Transition.Translation2 = frame.animationGroup.Transition:CreateAnimation('Translation')
		local alpha = frame.animationGroup.Transition.Alpha
		local scale = frame.animationGroup.Transition.Scale
		local translation = frame.animationGroup.Transition.Translation
		local translation2 = frame.animationGroup.Transition.Translation2
		alpha:SetFromAlpha(0)
		alpha:SetToAlpha(0.9)
		alpha:SetDuration(0.30)
		alpha:SetSmoothing("IN_OUT")
		scale:SetScaleFrom(0,0)
		scale:SetScaleTo(1,1)
		scale:SetDuration(0.10)
		translation:SetDuration(0.18)
		translation:SetOffset(0,10)
		translation2:SetDuration(0.08)
		translation2:SetOffset(0,-10)
		translation2:SetStartDelay(0.01)
	end

	do
		frame.animationGroup.Hide = frame:CreateAnimationGroup()
		frame.animationGroup.Hide:SetToFinalAlpha(true)
		frame.animationGroup.Hide.Alpha = frame.animationGroup.Hide:CreateAnimation('Alpha')
		local alpha = frame.animationGroup.Hide.Alpha
		alpha:SetFromAlpha(1)
		alpha:SetToAlpha(0)
		alpha:SetDuration(0.25)
		alpha:SetSmoothing("OUT")
		alpha:SetScript("OnFinished", function(self) self:GetParent():GetParent():Hide() end)
	end

	return frame.animationGroup
end

function CS:ShowExport()
	local format = "%H:%M, %d.%m.%y"
	internal.exportText = "Server;Found Time;Spawn Time;Mode;Position;Genuine\n"

	for serverName in pairs(Settings.Servers) do
		for spawnTime, info in getSortedKeys(Settings.Servers[serverName]) do
			local real = info.real and "Yes" or ""
			local modeText
			local mode = info.mode
			if mode == 1 then
				modeText = "WM Off"
			elseif mode == 2 then
				modeText = "WM On"
			elseif mode == 3 then
				modeText = "CT WM Off"
			elseif mode == 4 then
				modeText = "CT WM On"
			end
			internal.exportText = internal.exportText .. strjoin(";", tostringall(serverName, date(format, info.time), date(format, spawnTime), modeText, info.x..", "..info.y, real)) .. "\n"
		end
	end

	-- remove \n from last line
	internal.exportText = internal.exportText:sub(1, -2)
	if not self.ExportDialog then
		self:CreateExportDialog()
	end
	self.ExportDialog.EditBox:SetText(internal.exportText)
	self.ExportDialog.EditBox:SetHighlightColor(1,0.86,0.43,0.5)
	self.ExportDialog:Show()
	self.ExportDialog.animationGroup.Transition:Play()
end

function CS:Help(msg)
	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
	if cmd then
		cmd = cmd:lower()
	end
	if args then
		args = args:lower()
	end
	if not cmd or cmd == "" or cmd == "help" then
		AddMessage("|cffEEE4AECamel Spotter: /cs /camelspotter|r")
		AddMessage("   Add TomTom Waypoints - /cs way")
		AddMessage("   Export History as CSV - /cs export")
		AddMessage("   Toggle Auto Screenshot - /cs screenshot (Default: Disabled)")
	elseif cmd == "way" then
		self:SetWaypoints()
	elseif cmd == "screenshot" then
		if not Settings.ScreenshotEnabled then
			AddMessage("|cffEEE4AECamel Spotter:|r |cff37DB33Automatically take a screenshot enabled.")
		else
			AddMessage("|cffEEE4AECamel Spotter:|r |cffB6B6B6Automatically take a screenshot disabled.")
		end
		Settings.ScreenshotEnabled = not Settings.ScreenshotEnabled
	elseif cmd == "export" then
		self:ShowExport()
	end
end

SLASH_CAMELSPOTTER1, SLASH_CAMELSPOTTER2 = '/cs', '/camelspotter'
SlashCmdList["CAMELSPOTTER"] = function(...)
	CS:Help(...)
end

function CS:HandleClick(link)
	local linkType, linkData = LinkUtil.SplitLinkData(link);
	if linkType and linkType == "addon" then
		local addon, type = strsplit(":", linkData)
		if addon ~= "CamelSpotter" then return end
		if type == "setloc" then
			if not internal.recentlyClicked then
				internal.recentlyClicked = true
				C_Timer.After(5, function() internal.recentlyClicked = false end)
				CS:SetWaypoints()
			end
		elseif type == "help" then
			CS:Help("help")
		elseif type == "closest" then
			TomTom:SetClosestWaypoint()
		end
	end
end

EventRegistry:RegisterCallback("SetItemRef", CS.HandleClick, CS)
CS:SetScript("OnEvent", CS.OnEvent)
RegisterEvents(CS, internal.events)