local addonName, T = ...
local EV, L, W, C = T.Evie, T.L, T.WrappedAPI, C_Garrison
local GarrisonLandingPageMinimapButton = ExpansionLandingPageMinimapButton

if (GARRISON_LANDING_COVIEW_PATCH_VERSION or 0) < 5 then
	GARRISON_LANDING_COVIEW_PATCH_VERSION = 5
	hooksecurefunc("ShowGarrisonLandingPage", function(pg)
		if GARRISON_LANDING_COVIEW_PATCH_VERSION ~= 5 or not GarrisonLandingPage then
			return
		end
		pg = (pg or C_Garrison.GetLandingPageGarrisonType() or 0)
		if pg ~= 111 and GarrisonLandingPage.SoulbindPanel then
			GarrisonLandingPage.FollowerTab.autoSpellPool:ReleaseAll()
			GarrisonLandingPage.FollowerTab.autoCombatStatsPool:ReleaseAll()
			GarrisonLandingPage.FollowerTab.AbilitiesFrame:Layout()
			GarrisonLandingPage.FollowerTab.CovenantFollowerPortraitFrame:Hide()
		end
		if pg > 2 and GarrisonThreatCountersFrame then
			GarrisonThreatCountersFrame:Hide()
		end
		if pg > 3 then
			GarrisonLandingPage.FollowerTab.NumFollowers:SetText("")
		end
		if GarrisonLandingPageReport.Sections then
			GarrisonLandingPageReport.Sections:SetShown(pg == 111)
		end
	end)
end

local function CallOwner(f, ...)
	return f(...)
end
local function RegisterCallback_OnInitializedFrame(box, f)
	box:RegisterCallback("OnInitializedFrame", CallOwner, f)
	if box:IsVisible() then
		box:ForEachFrame(f)
	end
	if type(box:GetParent().buttonInitializer) == "function" then
		-- GarrisonFollowerList:UpdateData, hiss.
		hooksecurefunc(box:GetParent(), "buttonInitializer", f)
	end
end

local function ShowReportMissionExpirationTime(b, item)
	if GarrisonLandingPage.garrTypeID ~= 9 then return end
	if b and item and item.offerTimeRemaining and item.offerEndTime then
		if item.offerEndTime - 8640000 <= GetTime() then
			b.MissionType:SetFormattedText("%s |cffa0a0a0(%s %s)|r",
				item.durationSeconds >= GARRISON_LONG_MISSION_TIME and (GARRISON_LONG_MISSION_TIME_FORMAT):format(item.duration) or item.duration,
				L"Expires in:", item.offerTimeRemaining)
		end
	end
end
function EV:I_LOAD_MAINUI()
	RegisterCallback_OnInitializedFrame(GarrisonLandingPageReportList.ScrollBox, ShowReportMissionExpirationTime)
end

local function Tooltip_AddGarrisonStatus(self, mt, prefixLine)
	local am, nextExpire = C.GetAvailableMissions(mt) or {}
	local im, inProgressCount, nextComplete = C.GetInProgressMissions(mt) or {}, 0
	local cm = C.GetCompleteMissions(mt) or {}
	
	if prefixLine and (#am + #im + #cm) > 0 then
		self:AddLine(prefixLine)
	end
	
	for i=1,#am do
		local et = am[i].offerEndTime
		nextExpire = nextExpire and et and nextExpire > et and nextExpire or et or nextExpire
	end
	if #am > 0 then
		local tl = nextExpire and "|A:worldquest-icon-clock:16:17:0:0|a" .. W.GetLazyTimeStringFromSeconds(nextExpire - GetTime(), false) or ""
		self:AddDoubleLine((L"%d |4mission:missions; available"):format(#am), tl, 1,1,1, 0.85, 0.35,0)
	end

	for i=1, #im do
		local e = im[i]
		if e.timeLeftSeconds > 0 then
			inProgressCount, nextComplete = inProgressCount + 1, nextComplete and nextComplete <= e.timeLeftSeconds and nextComplete or e.timeLeftSeconds
		end
	end
	if inProgressCount > 0 then
		local tl = nextComplete and "|A:GarrMission_MissionTooltipAway:14:14:-1.5:0|a" .. W.GetLazyTimeStringFromSeconds(nextComplete, true) or ""
		self:AddDoubleLine((L"%d |4mission:missions; in progress"):format(inProgressCount), tl, 0.65, 0.65, 0.65, 0.45, 0.65, 0.85)
	end

	if #cm > 0 then
		self:AddLine((L"%d |4mission:missions; complete"):format(#cm), 0.25,0.8,0.25)
	end
	self:Show()
end
local function Tooltip_OnSetUnit(self, tooltipData)
	local guid = tooltipData and tooltipData.type == Enum.TooltipDataType.Unit and tooltipData.guid
	local cid = guid and guid:match("^Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)")
	if cid == "138704" or cid == "138706" then
		return Tooltip_AddGarrisonStatus(self, 22)
	end
end
local function Tooltip_OnLandingEnter(self)
	if GameTooltip:IsOwned(self) and C.GetLandingPageGarrisonType() == 9 then
		Tooltip_AddGarrisonStatus(GameTooltip, 22, " ")
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("TOPRIGHT", self, "TOPLEFT", -2, 2)
	end
end

local function EasyMenu_Initialize(_, level, menuList)
	for i=1, #menuList do
		local value = menuList[i]
		if value.text then
			value.index = i
			UIDropDownMenu_AddButton(value, level)
		end
	end
end
local function EasyMenu(menuList, menuFrame, anchor, x, y, displayMode, autoHideDelay)
	if displayMode == "MENU" then
		menuFrame.displayMode = displayMode
	end
	UIDropDownMenu_Initialize(menuFrame, EasyMenu_Initialize, displayMode, nil, menuList)
	ToggleDropDownMenu(1, nil, menuFrame, anchor, x, y, menuList, nil, autoHideDelay)
end

local function hookLandingMenu()
	if GarrisonLandingPageMinimapButton.altMenuManager == nil then
		GarrisonLandingPageMinimapButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		GarrisonLandingPageMinimapButton.altMenuManager = addonName
	else
		return
	end
	local followerTabNames = {[2]=GARRISON_FOLLOWERS, [3]=FOLLOWERLIST_LABEL_CHAMPIONS, [9]=FOLLOWERLIST_LABEL_CHAMPIONS, [111]=COVENANT_MISSIONS_FOLLOWERS}
	local function ShowLanding(_, page)
		HideUIPanel(GarrisonLandingPage)
		ShowGarrisonLandingPage(page)
		local fn = followerTabNames[page or C.GetLandingPageGarrisonType()]
		if fn then
			GarrisonLandingPage.FollowerList.LandingPageHeader:SetText(fn)
			GarrisonLandingPageTab2:SetText(fn)
		end
		if ExpansionLandingPage and ExpansionLandingPage:IsVisible() then
			HideUIPanel(ExpansionLandingPage)
		end
	end
	local function IsLandingPageVisible()
		return GarrisonLandingPage and GarrisonLandingPage:IsVisible()
	end
	local function GetExpansionLandingPage()
		return ExpansionLandingPage and ExpansionLandingPage.replacementLandingPage or PlumberExpansionLandingPage or ExpansionLandingPage or nil
	end
	local function IsExpansionPageVisible()
		local ExpansionLandingPage = GetExpansionLandingPage()
		return ExpansionLandingPage and ExpansionLandingPage:IsVisible()
	end
	local landingChoiceMenu, landingChoices
	GarrisonLandingPageMinimapButton:HookScript("PreClick", function(self, b)
		if self.altMenuManager ~= addonName then
			return
		end
		self.landingVisiblePriorToClick = IsLandingPageVisible() and GarrisonLandingPage and GarrisonLandingPage.garrTypeID
		self.expansionPageVisiblePriorToClick = IsExpansionPageVisible()
		if b == "RightButton" then
			local soundOK, soundID = PlaySound(SOUNDKIT.UI_GARRISON_GARRISON_REPORT_OPEN)
			self.startSoundID = soundOK and soundID
		end
	end)
	GarrisonLandingPageMinimapButton:HookScript("OnClick", function(self, b)
		if self.altMenuManager ~= addonName then
			return
		elseif b == "LeftButton" then
			local goalLanding = IsLandingPageVisible() and not (IsExpansionPageVisible() or self.expansionPageVisiblePriorToClick) and C.GetLandingPageGarrisonType()
			if goalLanding and GarrisonLandingPage.garrTypeID ~= goalLanding then
				ShowLanding(nil, goalLanding)
			end
			return
		elseif b == "RightButton" then
			if (C.GetLandingPageGarrisonType() or 0) > 3 then
				if self.landingVisiblePriorToClick then
					ShowLanding(nil, self.landingVisiblePriorToClick)
				elseif GarrisonLandingPage and GarrisonLandingPage:IsVisible() then
					if type(GarrisonLandingPage.OnInstantHide) == "function" then
						securecall(GarrisonLandingPage.OnInstantHide, GarrisonLandingPage)
					end
					HideUIPanel(GarrisonLandingPage)
				end
				local ExpansionLandingPage = GetExpansionLandingPage()
				if ExpansionLandingPage and ExpansionLandingPage:IsVisible() and not self.expansionPageVisiblePriorToClick then
					if type(ExpansionLandingPage.OnInstantHide) == "function" then
						securecall(ExpansionLandingPage.OnInstantHide, ExpansionLandingPage)
					end
					HideUIPanel(ExpansionLandingPage)
				end
				if self.startSoundID then
					local startID, soundOK, soundID, _ = self.startSoundID, PlaySound(SOUNDKIT.UI_GARRISON_GARRISON_REPORT_OPEN)
					StopSound(startID)
					_, self.startSoundID = soundOK and soundID and StopSound(soundID), nil
					local endID = soundOK and soundID and soundID > startID and (soundID - startID) < 10 and soundID or startID
					for i=startID+1, endID-1 do
						StopSound(i)
					end
				end
				if not landingChoiceMenu then
					landingChoiceMenu = CreateFrame("Frame", "WPLandingChoicesDrop", UIParent, "UIDropDownMenuTemplate")
				end
				landingChoices = wipe(landingChoices or {})
				landingChoices[#landingChoices+1] = C.GetNumFollowers(1) > 0 and {text=GARRISON_LANDING_PAGE_TITLE, func=ShowLanding, arg1=2, notCheckable=true} or nil
				landingChoices[#landingChoices+1] = C.GetNumFollowers(4) > 0 and {text=ORDER_HALL_LANDING_PAGE_TITLE, func=ShowLanding, arg1=3, notCheckable=true} or nil
				landingChoices[#landingChoices+1] = C.GetNumFollowers(22) > 0 and {text=WAR_CAMPAIGN, func=ShowLanding, arg1=9, notCheckable=true} or nil
				landingChoices[#landingChoices+1] = C.GetNumFollowers(123) > 0 and {text=GARRISON_TYPE_9_0_LANDING_PAGE_TITLE, func=ShowLanding, arg1=111, notCheckable=true} or nil
				GameTooltip:Hide()
				EasyMenu(landingChoices, landingChoiceMenu, "cursor", 0, 0, "MENU", 4)
				DropDownList1:ClearAllPoints()
				local x, y = self:GetCenter()
				local w, h = UIParent:GetSize()
				local u, r = y*2 > h, x*2 > w
				local p1 = (u and "TOP" or "BOTTOM") .. (r and "RIGHT" or "LEFT")
				local p2 = (u and "TOP" or "BOTTOM") .. (r and "LEFT" or "RIGHT")
				DropDownList1:SetPoint(p1, self, p2, r and 10 or -10, u and -8 or 8)
			elseif GarrisonLandingPage and GarrisonLandingPage.garrTypeID == 3 then
				ShowLanding(nil, 2)
			end
		end
		self.startSoundID = nil
	end)
end
function EV:I_LOAD_HOOKS()
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, Tooltip_OnSetUnit)
	GarrisonLandingPageMinimapButton:HookScript("OnEnter", Tooltip_OnLandingEnter)
	hookLandingMenu()
end