-- MODULE FOR SEARCHING FRAME 
local var = hopAddon.var
local customOptions = hopAddon.optionsFrame.customSearchOptionsFrame

local searchUpdated = 2.5
local ResultFrames = {}
local SearchString = ""
local SearchKeywords = {}
local FilteredGroupsList = {}
local CustomSearchBlackList = {}

-- Holder
hopAddon.searchFrame = CreateFrame("Frame",nil,hopAddon)
hopAddon.searchFrame:SetSize(HOPADDON_WIDTH,HOPADDON_HEIGHT)
hopAddon.searchFrame:SetPoint("BOTTOM",0,0)

hopAddon.searchFrame.background = hopAddon.searchFrame:CreateTexture(nil,"BORDER")
hopAddon.searchFrame.background:SetSize(HOPADDON_WIDTH+106,HOPADDON_HEIGHT-10)
hopAddon.searchFrame.background:SetPoint("BOTTOM",1,5)
hopAddon.searchFrame.background:SetTexture("Interface\\Challenges\\challenges-besttime-bg")

-- Searching animation block
hopAddon.searchFrame.Waitdot2 = hopAddon.searchFrame:CreateTexture("Waitdot2","ARTWORK")
hopAddon.searchFrame.Waitdot2:SetPoint("BOTTOM",0,45)
hopAddon.searchFrame.Waitdot2:SetAtlas("groupfinder-waitdot",true)
hopAddon.searchFrame.Waitdot2:SetVertexColor(1,1,1,0)

hopAddon.searchFrame.Waitdot1 = hopAddon.searchFrame:CreateTexture("Waitdot2","ARTWORK")
hopAddon.searchFrame.Waitdot1:SetPoint("CENTER", "Waitdot2", -16,0)
hopAddon.searchFrame.Waitdot1:SetAtlas("groupfinder-waitdot",true)
hopAddon.searchFrame.Waitdot1:SetVertexColor(1,1,1,0)

hopAddon.searchFrame.Waitdot3 = hopAddon.searchFrame:CreateTexture("Waitdot2","ARTWORK")
hopAddon.searchFrame.Waitdot3:SetPoint("CENTER", "Waitdot2",16,0)
hopAddon.searchFrame.Waitdot3:SetAtlas("groupfinder-waitdot",true)
hopAddon.searchFrame.Waitdot3:SetVertexColor(1,1,1,0)

hopAddon.searchFrame.anim = hopAddon.searchFrame:CreateAnimationGroup("Searching")
hopAddon.searchFrame.anim:SetLooping("REPEAT")

SH_AddAlphaAnimation(hopAddon.searchFrame.anim,"Waitdot1",0.50,0.15,1,0,1)
SH_AddAlphaAnimation(hopAddon.searchFrame.anim,"Waitdot2",0.50,0.15,2,0,1)
SH_AddAlphaAnimation(hopAddon.searchFrame.anim,"Waitdot3",0.50,0.15,3,0,1)
SH_AddAlphaAnimation(hopAddon.searchFrame.anim,"Waitdot1",0.50,0.15,4,1,0)
SH_AddAlphaAnimation(hopAddon.searchFrame.anim,"Waitdot2",0.50,0.15,4,1,0)
SH_AddAlphaAnimation(hopAddon.searchFrame.anim,"Waitdot3",0.50,0.15,4,1,0)


-- Roles
local function CreateRoleBtn(point,x,y,role)
	local btn = CreateFrame("Button", role.."button", hopAddon.searchFrame)
	btn:SetSize(30,30)
	btn:SetPoint(point,x,y)
	btn.Icon = btn:CreateTexture("butOptionsTex","OVERLAY")
	btn.Icon:SetAllPoints(btn)
	btn.Icon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES")
	btn.Icon:SetTexCoord(GetTexCoordsForRole(role))
	btn.CheckButton = CreateFrame("CheckButton", role.."CheckBtn",btn,"ChatConfigCheckButtonTemplate")
	btn.CheckButton:SetHitRectInsets(20,20,20,20)
	btn.CheckButton:SetPoint("LEFT",-10,0)

	btn:SetScript("OnClick", function(self)
		if self.CheckButton:IsEnabled() then
			self.CheckButton:Click()
		end
	end)
	return btn
end

SHtankButton = CreateRoleBtn("TOP",-45,-16,"TANK")
SHhealerButton = CreateRoleBtn("TOP",0,-16,"HEALER")
SHdamagerButton = CreateRoleBtn("TOP",45,-16,"DAMAGER")

-- Dungeons drop list mush be shown only when dungeons selected
hopAddon.searchFrame.dungeonsDrop = CreateFrame("Frame", "dungeonsDrop", hopAddon.searchFrame, "UIDropDownMenuTemplate")
local dDrop = hopAddon.searchFrame.dungeonsDrop
dDrop:SetPoint("BOTTOM",0,35)
dDrop.activeValue = 0
dDrop:Hide()

-- Raids drop list must be shown only when raids selected
hopAddon.searchFrame.raidsDrop = CreateFrame("Frame", "raidsDrop", hopAddon.searchFrame, "UIDropDownMenuTemplate")
local rDrop = hopAddon.searchFrame.raidsDrop
rDrop:SetPoint("BOTTOM",0,35)
rDrop.activeValue = 0
rDrop:Hide()

-- Dropdown to select category to search in

hopAddon.searchFrame.dropDown = CreateFrame("Frame", "CategoryDrop", hopAddon.searchFrame, "UIDropDownMenuTemplate")
hopAddon.searchFrame.dropDown:SetPoint("BOTTOM",-10,8)
UIDropDownMenu_SetWidth(hopAddon.searchFrame.dropDown,180)
hopAddon.searchFrame.dropDown.text = hopAddon.searchFrame.dropDown:CreateFontString(nil, "OVERLAY", "GameFontNormal")
hopAddon.searchFrame.dropDown.text:SetSize(136,12)
hopAddon.searchFrame.dropDown.text:SetPoint("RIGHT",hopAddon.searchFrame.dropDown,"RIGHT",-42,3)
hopAddon.searchFrame.dropDown.text:SetJustifyH("RIGHT")

-- custom search dropdown init
local CategoryList = {}

hopAddon.searchFrame.dropDown.initialize = function(self, level)

    if not level then return end
    wipe(CategoryList)
    if level == 1 then
		local categories = C_LFGList.GetAvailableCategories();
		for i=1, #categories do
			local categoryID = categories[i];
			local name, separateRecommended, autoChoose, preferCurrentArea = C_LFGList.GetCategoryInfo(categoryID);

			CategoryList.text = name;
			CategoryList.value = categoryID;
			CategoryList.func = hopAddon.searchFrame.dropDown_OnClick;
			CategoryList.checked = self.activeValue == CategoryList.value;
			--CategoryList.tooltipTitle = "bla"
			--CategoryList.tooltipText = "blabla"
			--CategoryList.tooltipOnButton = 1
			UIDropDownMenu_AddButton(CategoryList, 1);
		end
	end
	
end

UIDropDownMenu_SetAnchor(hopAddon.searchFrame.dropDown,0,10,"TOPRIGHT",hopAddon.searchFrame.dropDown,"BOTTOMRIGHT")

-- Category filter options

hopAddon.searchFrame.holderCatFilters = CreateFrame("Button",nil,hopAddon.searchFrame)
local h = hopAddon.searchFrame.holderCatFilters
h:SetSize(210,90)
h:SetPoint("CENTER",-10,-5)
h:SetBackdrop({bgFile = "Interface\\FrameGeneral\\UI-Background-Rock", 
					edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
					tile = true, tileSize = 256, edgeSize = 24, 
					insets = { left = 4, right = 4, top = 4, bottom = 4 }});
h:SetFrameLevel(10)
h:Hide()

h.timeEdit = CreateFrame("EditBox","searchFrameTimeEdit",h,"InputBoxInstructionsTemplate")
h.timeEdit:SetSize(40,22)
h.timeEdit:SetPoint("TOPLEFT",140,-15)
h.timeEdit:SetAutoFocus(false)
h.timeEdit:SetNumeric(true)
h.timeEdit:SetMaxLetters(4)
h.timeEdit:SetText("90")
h.timeEdit:SetScript("OnEnterPressed",function(self)
	if h.timeEdit:GetText() == "" then
		h.timeEdit:SetText("90")
	end
	EditBox_ClearFocus(self)
end)
h.timeEdit:SetScript("OnEscapePressed",function(self)
	EditBox_ClearFocus(self)
end)
h.timeEdit:SetScript("OnDisable", function(self)
	self:SetTextColor(0.5,0.5,0.5,1)
end)
h.timeEdit:SetScript("OnEnable", function(self)
	self:SetTextColor(1,1,1,1)
end)
h.timeEdit:Disable()

h.timeCheck = CreateFrame("CheckButton","searchFrameTimeCheck",h,"ChatConfigCheckButtonTemplate")
h.timeCheck:SetPoint("TOPLEFT",15,-15)
h.timeCheck:SetHitRectInsets(0,-90,0,0)
getglobal(h.timeCheck:GetName() .. 'Text'):SetText(HOPADDON_TIMEOPTION)
h.timeCheck.tooltip = HOPADDON_TIMETOOLTIP
h.timeCheck:SetChecked(false)
h.timeCheck:SetScript("OnClick",function(self)
	if h.timeEdit:IsEnabled() then
		h.timeEdit:Disable()
	else
		h.timeEdit:Enable()
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)

h.ilvlEdit = CreateFrame("EditBox","searchFrameilvlEdit",h,"InputBoxInstructionsTemplate")
h.ilvlEdit:SetSize(40,22)
h.ilvlEdit:SetPoint("TOPLEFT",140,-35)
h.ilvlEdit:SetAutoFocus(false)
h.ilvlEdit:SetNumeric(true)
h.ilvlEdit:SetMaxLetters(3)
h.ilvlEdit:SetText("630")
h.ilvlEdit:SetScript("OnEnterPressed",function(self)
	if h.ilvlEdit:GetText() == "" then
		h.ilvlEdit:SetText("630")
	end
	EditBox_ClearFocus(self)
end)
h.ilvlEdit:SetScript("OnEscapePressed",function(self)
	EditBox_ClearFocus(self)
end)
h.ilvlEdit:SetScript("OnDisable", function(self)
	self:SetTextColor(0.5,0.5,0.5,1)
end)
h.ilvlEdit:SetScript("OnEnable", function(self)
	self:SetTextColor(1,1,1,1)
end)
h.ilvlEdit:Disable()

h.ilvlCheck = CreateFrame("CheckButton","searchFrameilvlCheck",h,"ChatConfigCheckButtonTemplate")
h.ilvlCheck:SetPoint("TOPLEFT",15,-35)
h.ilvlCheck:SetHitRectInsets(0,-90,0,0)
getglobal(h.ilvlCheck:GetName() .. 'Text'):SetText(HOPADDON_ITEMLEVEL)
h.ilvlCheck.tooltip = HOPADDON_ITEMLEVELTOOLTIP
h.ilvlCheck:SetChecked(false)
h.ilvlCheck:SetScript("OnClick",function(self)
	if h.ilvlEdit:IsEnabled() then
		h.ilvlEdit:Disable()
	else
		h.ilvlEdit:Enable()
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)

h.autoInvCheck = CreateFrame("CheckButton","searchFrameacceptCheck",h,"ChatConfigCheckButtonTemplate")
h.autoInvCheck:SetPoint("TOPLEFT",15,-55)
getglobal(h.autoInvCheck:GetName() .. 'Text'):SetText(HOPADDON_SEARCH_AUTOINVITE)
h.autoInvCheck.tooltip = HOPADDON_SEARCHAUTOINVITETOOLTIP
h.autoInvCheck:SetChecked(false)

hopAddon.searchFrame.buttonCatFilters = CreateFrame("Button","catFiltersBtn",hopAddon.searchFrame,"BrowserButtonTemplate")
local b = hopAddon.searchFrame.buttonCatFilters
b:SetSize(24,24)
b:SetPoint("RIGHT",hopAddon.searchFrame.dropDown,8,3)
b.Icon = b:CreateTexture("butOptionsTex","OVERLAY")
b.Icon:SetSize(14,14)
b.Icon:SetPoint("CENTER",0,0)
b.Icon:SetTexture("Interface\\Buttons\\UI-OptionsButton")
b.tooltip = HOPADDON_ADDITIONALFILTERS
-- override on enter, onhide event is inside template
b:SetScript("OnClick", function(self,button)
	if h:IsShown() then
		h:Hide()
	else
		h:Show()
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)

b:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, -25)
	GameTooltip:SetText(self.tooltip, 1, 1, 1, true)
	GameTooltip:Show()
end)

-- Search box
hopAddon.searchFrame.searchBox = CreateFrame("EditBox", "ServerHop_SearchBox", hopAddon.searchFrame, "SearchBoxTemplate")
hopAddon.searchFrame.searchBox:SetPoint("TOPLEFT", hopAddon, "BOTTOMLEFT", 10, 2)
hopAddon.searchFrame.searchBox:SetAutoFocus(false)
hopAddon.searchFrame.searchBox:EnableMouse(true)
hopAddon.searchFrame.searchBox:SetSize(HOPADDON_WIDTH-34, 24)
hopAddon.searchFrame.searchBox:SetMaxLetters(1023)

hopAddon.searchFrame.searchBox:SetScript("OnEditFocusGained", function(frame)
	hopAddon.searchFrame.SearchString = frame:GetText()
end)
hopAddon.searchFrame.searchBox:SetScript("OnEscapePressed", function(frame)
	frame:ClearFocus()
	frame:SetText(hopAddon.searchFrame.SearchString)
end)

-- search box clear button
hopAddon.searchFrame.searchBox.clearButton:Show()
hopAddon.searchFrame.searchBox.clearButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 0)
	GameTooltip:SetText(HOPADDON_CLEARSEARCH, 1, 1, 1, true)	
	GameTooltip:Show()
end)

hopAddon.searchFrame.searchBox.clearButton:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- search refresh button
hopAddon.searchFrame.refreshButton = CreateFrame("Button", "SH_SearchBtn", hopAddon.searchFrame,"BrowserButtonTemplate")
hopAddon.searchFrame.refreshButton:SetSize(25,25)
hopAddon.searchFrame.refreshButton:SetFrameLevel(5)
hopAddon.searchFrame.refreshButton:SetPoint("LEFT",hopAddon.searchFrame.searchBox,-7,0)
hopAddon.searchFrame.refreshButton.Icon = hopAddon.searchFrame.refreshButton:CreateTexture(nil,"OVERLAY")
hopAddon.searchFrame.refreshButton.Icon:SetSize(14,14)
hopAddon.searchFrame.refreshButton.Icon:SetPoint("CENTER",0,0)
hopAddon.searchFrame.refreshButton.Icon:SetTexture("Interface\\Buttons\\UI-RefreshButton")

hopAddon.searchFrame.refreshButton.anim = hopAddon.searchFrame.refreshButton:CreateAnimationGroup("SH_PressSearch")
hopAddon.searchFrame.refreshButton.anim:SetLooping("REPEAT")

SH_AddTranslationAnimation(hopAddon.searchFrame.refreshButton.anim,"SH_SearchBtn",0.15,0.15,1,0,4)
SH_AddTranslationAnimation(hopAddon.searchFrame.refreshButton.anim,"SH_SearchBtn",0,0.15,2,0,-4)
SH_AddScaleAnimation(hopAddon.searchFrame.refreshButton.anim,"SH_SearchBtn",0,0.15,3,1.2,1.2)
SH_AddScaleAnimation(hopAddon.searchFrame.refreshButton.anim,"SH_SearchBtn",0.15,0.15,4,0.83,0.83)

-- search results scroll
local function UpdateSearchFrame(frame,value)
	-- update left frames
	frame.result = FilteredGroupsList[value]
	
	local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(frame.result)
	
	-- party name
	frame.textName:SetText(name)
	
	-- autoinvite text color indication
	if autoinv then
		--frame:SetBackdropColor(0.07,0.24,0,1)
		frame:SetBackdropColor(0.30,0.6,0.28,1)
		--frame:SetBackdropColor(0.63,0.67,0.23,1)
	else
		frame:SetBackdropColor(0.18,0.16,0.11,1)
	end
	
	-- party members count
	frame.textCount:SetText(numMembers)
	
	-- party members icon
	frame.icon:SetVertexColor(1,1,1,1)				
	if (numBNetFriends > 0) then
		frame.icon:SetAtlas("groupfinder-icon-friend")		
	elseif (numCharFriends > 0) then
		frame.icon:SetAtlas("groupfinder-icon-friend")		
	elseif (numGuildMates > 0 ) then
		frame.icon:SetVertexColor(0,1,0,1)	
	else
		frame.icon:SetAtlas("groupfinder-waitdot")
	end
	
	-- frame backdrop
	frame.icon:Show()
	frame.iconRedx:Hide()
	frame.iconGreenChck:Hide()
	frame.spinner:Hide()
	local id, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(frame.result)

	if pendingStatus == "applied" or appStatus == "applied" then
		frame:SetBackdropColor(0.25,0.75,0.25,1)
		frame.icon:Hide()
		frame.spinner:Show()
		frame.spinner.Anim:Play()
	elseif pendingStatus == "invited" or appStatus == "invited" then
		frame:SetBackdropColor(0.25,0.75,0.25,1)
		frame.iconGreenChck:Show()
	elseif appStatus == "invitedeclined" or appStatus == "declined" or appStatus == "timedout" then
		frame.iconRedx:Show()
	end
	
end

----------------------------------------------------------------
local ROW_HEIGHT = 28   -- How tall is each row?
local MAX_ROWS = 5      -- How many rows can be shown at once?
----------------------------------------------------------------
-- Create the frame:
local scrolltooltip = 0

local scroll = CreateFrame("Frame", "SH_SearchResultsScroll", hopAddon.searchFrame)
hopAddon.searchFrame.scrollframe = scroll
scroll:SetPoint("TOP",hopAddon.searchFrame,"BOTTOM",0,-22)
scroll:SetSize(HOPADDON_WIDTH, (ROW_HEIGHT * MAX_ROWS))

scroll:EnableMouse(true)
scroll:SetMovable(true)
--[[scroll:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },
})]]

scroll:Hide()

-- results attached to search frame
local function ResultFrame_OnEnter(self)
	local resultID = self.result;
	scrolltooltip = self.index
	local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(resultID)
	local fullName, shortName, categoryID, groupID, iLevel, filters, minLevel, maxPlayers, displayType, orderIndex, useHonorLevel = C_LFGList.GetActivityInfo(activityID);
	local memberCounts = C_LFGList.GetSearchResultMemberCounts(resultID);
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, -40);
	GameTooltip:SetText(name);	
	GameTooltip:AddLine(fullName,1,1,1);
	if autoinv then
		GameTooltip:AddLine(HOPADDON_AUTOINVITE, 0.25, 0.75, 0.25, true)
	end	
	if ( comment ~= "" ) then
		GameTooltip:AddLine(string.format(LFG_LIST_COMMENT_FORMAT, comment), LFG_LIST_COMMENT_FONT_COLOR.r, LFG_LIST_COMMENT_FONT_COLOR.g, LFG_LIST_COMMENT_FONT_COLOR.b, true);
	end
	GameTooltip:AddLine(" ");
	if ( iLvl > 0 ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_ILVL, iLvl));
	end
	if ( voiceChat ~= "" ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_VOICE_CHAT, voiceChat), nil, nil, nil, true);
	end
	if ( iLvl > 0 or voiceChat ~= "" ) then
		GameTooltip:AddLine(" ");
	end

	if ( leaderName ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_LEADER, leaderName));
	end
	if ( age > 0 ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_AGE, SecondsToTime(age, false, false, 1, false)));
	end

	if ( leaderName or age > 0 ) then
		GameTooltip:AddLine(" ");
	end

	GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_MEMBERS, numMembers, memberCounts.TANK, memberCounts.HEALER, memberCounts.DAMAGER));

	if ( numBNetFriends + numCharFriends + numGuildMates > 0 ) then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(LFG_LIST_TOOLTIP_FRIENDS_IN_GROUP);
		GameTooltip:AddLine(LFGListSearchEntryUtil_GetFriendList(resultID), 1, 1, 1, true);
	end
	
	local completedEncounters = C_LFGList.GetSearchResultEncounterInfo(resultID);
	if ( completedEncounters and #completedEncounters > 0 ) then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(LFG_LIST_BOSSES_DEFEATED);
		for i=1, #completedEncounters do
			GameTooltip:AddLine(completedEncounters[i], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		end
	end
	
	local id, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(id);

	GameTooltip:AddLine(" ");
	
	if pendingStatus == "applied" or appStatus == "applied" then
		GameTooltip:AddDoubleLine(HOPADDON_CANCELAPP,HOPADDON_RMB,0.75, 0.25, 0);
	elseif pendingStatus == "invited" or appStatus == "invited" then
		GameTooltip:AddDoubleLine(HOPADDON_DECLINEAPP,HOPADDON_RMB,0.75, 0.25, 0);
	else
		GameTooltip:AddDoubleLine(HOPADDON_APPLY,HOPADDON_LMB,0.25, 0.75, 0.25);
		GameTooltip:AddDoubleLine(HOPADDON_BLACKLIST,HOPADDON_RMB,0.75, 0.25, 0);
	end

	GameTooltip:Show();
end

function scroll:Update()
	local maxValue = #FilteredGroupsList
	FauxScrollFrame_Update(self.scrollBar, maxValue, MAX_ROWS, ROW_HEIGHT)

	local offset = FauxScrollFrame_GetOffset(self.scrollBar)
	for i = 1, MAX_ROWS do
		local value = i + offset
		if value <= maxValue then
			local row = self.rows[i]
			UpdateSearchFrame(row,value)
			row:Show()
			if i == scrolltooltip then
				ResultFrame_OnEnter(row)
			end
		else
			self.rows[i]:Hide()
		end
	end
end

local bar = CreateFrame("ScrollFrame", "$parentScrollBar", scroll, "FauxScrollFrameTemplate")
bar:SetPoint("TOPLEFT", 0, -4)
bar:SetPoint("BOTTOMRIGHT", -25, 2)

bar:SetScript("OnVerticalScroll", function(self, offset)
	self.offset = math.floor(offset / ROW_HEIGHT + 0.5)

	scroll:Update()
end)

bar:SetScript("OnShow", function()
	scroll:Update()
end)

scroll.scrollBar = bar

local function MakeResultFrame(index)
	local frame = CreateFrame("Button",nil,scroll)
	frame:SetSize(220,ROW_HEIGHT)
	if index == 1 then
		--frame:SetPoint("TOPLEFT", hopAddon.searchFrame.searchBox, "BOTTOMLEFT",-4,0)
		frame:SetPoint("TOPLEFT",0,0)
	else
		frame:SetPoint("TOP", ResultFrames[index-1], "BOTTOM")	
	end

	frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
						tile = true, tileSize = 16, edgeSize = 16, 
						insets = { left = 2, right = 2, top = 2, bottom = 2 }});
	frame:SetBackdropColor(0,0,0,1);
	
	local highlightTexture = frame:CreateTexture()
	highlightTexture:SetPoint("TOPLEFT",-2,5)
	highlightTexture:SetPoint("BOTTOMRIGHT",2,-7)
	highlightTexture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
	frame:SetHighlightTexture(highlightTexture,"ADD")


	frame.iconRedx	= frame:CreateTexture(nil,"OVERLAY")
	frame.iconRedx:SetSize(20,20)
	frame.iconRedx:SetPoint("RIGHT", frame, "RIGHT", -8,0)
	frame.iconRedx:SetAtlas("groupfinder-icon-redx")

	frame.iconGreenChck	= frame:CreateTexture(nil,"OVERLAY")
	frame.iconGreenChck:SetSize(20,20)
	frame.iconGreenChck:SetPoint("RIGHT", frame, "RIGHT", -8,0)
	frame.iconGreenChck:SetAtlas("Tracker-Check")
	
	frame.spinner = CreateFrame("Frame",nil,frame,"LoadingSpinnerTemplate")
	frame.spinner:SetSize(40,40)
	frame.spinner:SetPoint("RIGHT", frame, "RIGHT", 0,0)
	
	frame.textCount = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.textCount:SetSize(18,16)
	frame.textCount:SetPoint("LEFT",frame,"LEFT",7,0)
	frame.textCount:SetJustifyH("CENTER")
	frame.textCount:SetText("")
	
	frame.icon	= frame:CreateTexture(nil,"OVERLAY")
	frame.icon:SetSize(16,16)
	frame.icon:SetPoint("LEFT", frame, 24,0)
	
	frame.textName = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.textName:SetSize(178,18)
	frame.textName:SetPoint("LEFT",frame.icon,"RIGHT",4,0)
	frame.textName:SetJustifyH("LEFT")
	frame.textName:SetText("")
	
	frame.result = 0
	frame.index = index
	
	frame:SetScript("OnEnter", ResultFrame_OnEnter)
	frame:SetScript("OnLeave", function(self) scrolltooltip = 0 GameTooltip:Hide() end);	
	frame:RegisterForClicks("AnyUp")
	frame:SetScript("OnClick", function(self,button,down)
	
		if button == "LeftButton" then
			local apps = C_LFGList.GetApplications();
			local total = 0
			for i=1, #apps do
				local id, appStatus, pendingStatus,appDuration = C_LFGList.GetApplicationInfo(apps[i]);
				if appDuration == 0 and pendingStatus == "applied" then
					-- phantom groups fix
					-- phantom groups have 0 duration and applied pending
				else
					if pendingStatus == "applied" or appStatus == "applied"
					or pendingStatus == "invited" or appStatus == "invited" then
						total = total + 1
					end
				end
			end
			
			local active, activityID, iLevel, honorLevel, name, comment, voiceChat, duration, autoAccept  = C_LFGList.GetActiveEntryInfo();	
			
			if total < 5 and ((not IsInGroup() and not IsInRaid()) or UnitIsGroupLeader('player')) and not name then
				PlaySound("igMainMenuOptionCheckBoxOn")
				local tank, heal, dd = C_LFGList.GetAvailableRoles()
				tank = tank and SHtankButton.CheckButton:GetChecked()
				heal = heal and SHhealerButton.CheckButton:GetChecked()
				dd = dd and SHdamagerButton.CheckButton:GetChecked()
				C_LFGList.ApplyToGroup(self.result, "", tank, heal, dd)

				table.remove(FilteredGroupsList,index)
				scroll:Update()
			else
				PlaySound("ui_garrison_architecttable_buildingplacementerror","Master")			
			end
		end
		
		if button == "RightButton" then
			local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(self.result)
			local id, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(self.result);
			
			if appStatus == "applied" or pendingStatus == "applied" then
				C_LFGList.CancelApplication(self.result)
			elseif pendingStatus == "invited" or appStatus == "invited" then
				LFGListInviteDialog.DeclineButton:Click()
			else
				local t={}
				t[name]=GetTime()-age
				--print("Blacklisted "..name)
				table.insert(CustomSearchBlackList,t)
				table.remove(FilteredGroupsList,index)
			end
			
			if IsShiftKeyDown() then
				table.insert(hopAddon.tables.LeadersBL,leaderName)
			end
			
			scroll:Update()
			PlaySound("igMainMenuOptionCheckBoxOn")
		end
	end)
	
	frame:Hide()
	ResultFrames[index]=frame
end

for i=1,MAX_ROWS do MakeResultFrame(i) end
scroll.rows = ResultFrames


-- Hyperlink for search results

local origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow

ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...
	if type(text) == "string" and text:match("sehopR") and not IsModifiedClick() then
		SH_ShowResultChatInfo(text)
	else
		return origChatFrame_OnHyperlinkShow(...)
	end
end

function SH_ShowResultChatInfo(text)
	local _,grname,grdesc,_ = strsplit("*",text)
	local header = string.match(text,'%[(.+)%]')
	
	ShowUIPanel(ItemRefTooltip)
	if (not ItemRefTooltip:IsVisible()) then
		ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
	end
	ItemRefTooltip:ClearLines()
	ItemRefTooltip:AddLine(header)
	ItemRefTooltip:AddLine(" ",1,1,1,1)
	ItemRefTooltip:AddLine(grname,1,1,1,1)
	if grdesc ~= "" then
		ItemRefTooltip:AddLine(grdesc,1,1,1,1)
	end
	ItemRefTooltip:Show()
end


-- MAIN FUNCTIONS --

local function SplitKeywords(keyword)
	SearchKeywords = {}
	for i in string.gmatch(keyword, "%S+") do
		if i ~= "-" then
			table.insert(SearchKeywords,i)
		end
	end
end

local function CustomSearch()
	hopAddon.searchFrame.scrollframe:Hide()
	
	local languages = C_LFGList.GetLanguageSearchFilter()
	C_LFGList.Search(hopAddon.searchFrame.dropDown.activeValue, "", 0, 0, languages)
end

local function FoundInDelisted(appID)
	local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(appID)
	local id, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(appID)
	
	-- if your selected group has the same leader as you - it's your group
	if C_LFGList.GetActiveEntryInfo() then
		local index = GetNumGroupMembers()
		local name = GetUnitName("player")
		
		if IsInRaid() then
			for i=1,index do
				if UnitIsGroupLeader("raid"..i) then
					name = GetUnitName("raid"..i,true)
					break
				end
			end
		else
			for i=1,4 do
				if UnitIsGroupLeader("party"..i) then
					name = GetUnitName("party"..i,true)
					break
				end
			end
		end

		if name == leaderName then return true end
	end
	
	if isDelisted or appStatus == "invitedeclined" or appStatus == "declined" or appStatus == "timedout"
	or appStatus == "cancelled" or pendingStatus == "cancelled" or appStatus == "failed" 
	then
		return true
	end
	
	return false
end

local function RemoveDelisted()
	local removed = false

	local i=#FilteredGroupsList
	while i > 0 do		
		if FoundInDelisted(FilteredGroupsList[i]) then
			table.remove(FilteredGroupsList,i)
			removed = true
		end
		i = i - 1
	end

	if removed then	scroll:Update() end
end

local function FoundInBlackList(caption,ctime)
	local epsilon = 2 -- blacklisting by name and creation time, time can give a small error
	
	for k,v in pairs(CustomSearchBlackList) do
		for key,value in pairs(v) do
			if key == caption then
				if (value <= GetTime()-ctime+epsilon) and (value >= GetTime()-ctime-epsilon) then
					--print("Blacklist match: "..key.." "..value)
					return true
				end
			end				
		end
		
	end

	return false
end

--[[
	Force launches when user changes filter
	Launches by searchresultrecieved event
]]

local function ResultMeetsFilters(appID,minusKeywords,plusKeywords,fullKeywords)
	local id, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(appID)
	local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(appID)
	
	--[[
			!!!GROUP INFO FILTERING!!!
	]]
	-- group is not delisted or player in that group
	if FoundInDelisted(appID) then return end
	-- it is a Server Hop hosted group
	if string.find(name,"[Server Hop]",1,true) then return end
	-- group leader is not in blacklist
	for i=1,#hopAddon.tables.LeadersBL do
		if leaderName == hopAddon.tables.LeadersBL[i] then return end
	end
	-- group is not in blacklist
	if FoundInBlackList(name,age) then return end
	
	-- time since created check
	if hopAddon.searchFrame.holderCatFilters.timeCheck:GetChecked() and age > tonumber(hopAddon.searchFrame.holderCatFilters.timeEdit:GetText()) then
		return
	end
	-- group must have higher ilevel than filter
	if hopAddon.searchFrame.holderCatFilters.ilvlCheck:GetChecked() and iLvl < tonumber(hopAddon.searchFrame.holderCatFilters.ilvlEdit:GetText()) then
		return
	end
	-- group must have autoinvite on
	if hopAddon.searchFrame.holderCatFilters.autoInvCheck:GetChecked() and not autoinv then
		return
	end
	
	-- if particular instance is selected in second dropdown, detect it
	local InstanceIdFilter = 0
	-- dungeon category
	if hopAddon.searchFrame.dropDown.activeValue == 2 then
		InstanceIdFilter = dDrop.activeValue

		-- check for roles here
		local memberCounts = C_LFGList.GetSearchResultMemberCounts(appID);
		if (SHtankButton.CheckButton:GetChecked() and memberCounts.TANK == 0)
		or (SHhealerButton.CheckButton:GetChecked() and memberCounts.HEALER == 0)
		or (SHdamagerButton.CheckButton:GetChecked() and memberCounts.DAMAGER < 3)
		then else return end

	-- raid category
	elseif hopAddon.searchFrame.dropDown.activeValue == 3 then
		InstanceIdFilter = rDrop.activeValue
	end

	-- if there's instance selected
	if InstanceIdFilter ~= 0 then
		-- then check if it meets activity of the group
		if activityID ~= InstanceIdFilter then return end
	end

	--[[	
			!!!FORM THAT SEARCHSTRING!!!
	]]
	
	-- add activityID name to searchstring for quests (dungeons and raids for rework)
	local actionName = ""
	if hopAddon.searchFrame.dropDown.activeValue == 1 
	--or hopAddon.searchFrame.dropDown.activeValue == 2 
	--or hopAddon.searchFrame.dropDown.activeValue == 3
	then
		-- for quests that's zone
		actionName = C_LFGList.GetActivityInfo(activityID)
	end
	
	-- this is the string we're searching in
	local app = actionName:lower().." "..name:lower().." "..comment:lower();
	
	--[[
			!!!WORD FILTERING!!!
	]]
	-- if there's "-keyword", remove it
	for k,word in pairs(minusKeywords) do
		if string.find(app,word,1,true) then
			return
		end
	end
	
	-- if there's nothing to search for, just add a group since it passed all filters
	if #plusKeywords == 0 and #fullKeywords == 0 then
		table.insert(FilteredGroupsList,id)
		return
	end
	
	-- if user entered any keywords, check them
	if #plusKeywords > 0 then
		for k,word in pairs(plusKeywords) do
			if string.find(app,word,1,true) then
				table.insert(FilteredGroupsList,id)
				return
			end
		end
	end
	
	if #fullKeywords > 0 then
		local wordlist = {}
		for word in app:gmatch("%S+") do
			table.insert(wordlist,word)
		end

		for k,keyword in pairs(fullKeywords) do
			for i,word in pairs(wordlist) do
				if word == keyword then
					table.insert(FilteredGroupsList,id)
					return
				end
			end
		end
	end
end

local function FilterCustomSearchResults()
	FilteredGroupsList = {}
	
	-- manage keywords once
	local minusKeywords = {}
	local plusKeywords = {}
	local fullKeywords = {}
	for k,word in pairs(SearchKeywords) do
		if string.sub(word,1,1)=="-" then
			table.insert(minusKeywords,string.sub(word,2))
		elseif string.sub(word,1,1)=="#" then
			table.insert(fullKeywords,string.sub(word,2))
		else
			table.insert(plusKeywords,word)
		end
	end
		
	local count, list = C_LFGList.GetSearchResults()
	if count > HOPADDON_MAX_RESULTS then count = HOPADDON_MAX_RESULTS end
	
	for i = 1,count do
		-- checking for overlapping bugs for each element
		if list[i] ~= nil then
			ResultMeetsFilters(list[i],minusKeywords,plusKeywords,fullKeywords)
		end
	end
	-- if there're groups that meet conditions, show them
	if #FilteredGroupsList > 0 then
		hopAddon.searchFrame.anim:Stop()
		
		hopAddon.searchFrame.scrollframe:Show()
		_G[hopAddon.searchFrame.searchBox:GetName().."SearchIcon"]:Hide()
	end

	scroll:Update()

end

function FinishCustomSearch()
	var.addonSearchRequest = false

	SearchKeywords = {}
	DoSearch = false
	FilteredGroupsList = {}
	CustomSearchBlackList = {}
	hopAddon.searchFrame.anim:Stop()
	hopAddon.searchFrame.scrollframe:Hide()
end



-- LATE FUNCTIONS --

function hopAddon.searchFrame.dropDown_OnClick(self, arg1, arg2, checked)
	local prevValue = hopAddon.searchFrame.dropDown.activeValue
	hopAddon.searchFrame.dropDown.activeValue = self.value;
	CloseDropDownMenus();

	if prevValue ~= self.value then
		dDrop:Hide()
		dDrop.activeValue = 0
		rDrop:Hide()
		rDrop.activeValue = 0
		if self.value == 2 then	dDrop:Show()
		elseif self.value == 3 then rDrop:Show()
		end
		
		hopAddon.searchFrame.dropDown.text:SetText(C_LFGList.GetCategoryInfo(self.value))

		hopAddon.searchFrame.scrollframe:Hide()	
	end
end

-- Groups dropdown list set up
function hopAddon.searchFrame.dungeonsDrop_OnClick(self,arg1,arg2,checked)
	dDrop.activeValue = self.value

	if self.value == 0 then
		UIDropDownMenu_SetText(dDrop,NONE)
	else
		UIDropDownMenu_SetText(dDrop,C_LFGList.GetActivityInfo(self.value))
	end
	CloseDropDownMenus()
	hopAddon_searchBox_OnEnter(hopAddon.searchFrame.searchBox)
end

local dDropList = {
	-- classic
	[18] = 0,[50] = 0,[51] = 0,[52] = 0,
	[53] = 0,[54] = 0,[55] = 0,[56] = 0,
	[57] = 0,[58] = 0,[59] = 0,[60] = 0,
	[61] = 0,[62] = 0,[63] = 0,[64] = 0,
	[65] = 0,[66] = 0,[77] = 0,[78] = 0,
	-- bc
	[67] = 1,[94] = 1,[68] = 1,[93] = 1,
	[69] = 1,[95] = 1,[70] = 1,[90] = 1,
	[71] = 1,[92] = 1,[72] = 1,[81] = 1,
	[73] = 1,[85] = 1,[74] = 1,[84] = 1,
	[75] = 1,[86] = 1,[76] = 1,[87] = 1,
	[79] = 1,[89] = 1,[80] = 1,[88] = 1,
	[81] = 1,[98] = 1,[82] = 1,[97] = 1,
	[83] = 1,[96] = 1,[99] = 1,[100] = 1,
	-- wotlk
	[101] = 2,[128] = 2,[102] = 2,[117] = 2,
	[103] = 2,[127] = 2,[104] = 2,[119] = 2,
	[105] = 2,[120] = 2,[106] = 2,[121] = 2,
	[107] = 2,[118] = 2,[108] = 2,[122] = 2,
	[109] = 2,[123] = 2,[110] = 2,[124] = 2,
	[111] = 2,[125] = 2,[112] = 2,[126] = 2,
	[113] = 2,[129] = 2,[114] = 2,[130] = 2,
	[115] = 2,[131] = 2,[116] = 2,[132] = 2,
	-- cata
	[133] = 3,[146] = 3,[134] = 3,[144] = 3,
	[135] = 3,[143] = 3,[136] = 3,[142] = 3,
	[137] = 3,[141] = 3,[138] = 3,[140] = 3,
	[139] = 3,[147] = 3,[148] = 3,[149] = 3,
	[150] = 3,[151] = 3,[152] = 3,[153] = 3,
	[154] = 3,
	-- pandaria
	[155] = 4,[163] = 4,[156] = 4,[164] = 4,
	[157] = 4,[165] = 4,[158] = 4,[166] = 4,
	[159] = 4,[171] = 4,[160] = 4,[167] = 4,
	[168] = 4,[169] = 4,[170] = 4,[363] = 4,
	[364] = 4,
	-- draenor
	[21] = 5,[29] = 5,[401] = 5,
	[22] = 5,[30] = 5,[402] = 5,
	[23] = 5,[31] = 5,[403] = 5,
	[24] = 5,[32] = 5,[404] = 5,
	[25] = 5,[33] = 5,[405] = 5,
	[26] = 5,[34] = 5,[406] = 5,
	[27] = 5,[35] = 5,[407] = 5,
	[28] = 5,[36] = 5,[408] = 5,
	[395] = 5,[396] = 5,

	-- Legion
	[425] = 100,[435] = 200,[445] = 300,[459]=400,
	[426] = 100,[436] = 200,[446] = 300,[460]=400,
	[427] = 100,[437] = 200,[447] = 300,[461]=400,
	[428] = 100,[438] = 200,[448] = 300,[462]=400,
	[429] = 100,[439] = 200,[449] = 300,[463]=400,
	[430] = 100,[440] = 200,[450] = 300,[464]=400,
	[431] = 100,[441] = 200,[451] = 300,[465]=400,
	[432] = 100,[442] = 200,[452] = 300,[466]=400,
	[433] = 100,[443] = 200,[453] = 300,[467]=400,
	[434] = 100,[444] = 200,[454] = 300,
							[455] = 300, -- karazhan	
				[470] = 200,			[471]=400,
				[472] = 200,			[473]=400,
				[474] = 200,[475] = 300,[476]=400,		
	[417] = 100,[418] = 200, -- random
}

function dDrop.initialize(self,level)
	local info = UIDropDownMenu_CreateInfo()

	if (not level or level == 1) then
		-- no filter
		info.text = NONE;
		info.value = 0;	
		info.func = hopAddon.searchFrame.dungeonsDrop_OnClick
		info.hasArrow = false;
		info.checked = false
		UIDropDownMenu_AddButton(info);
		-- old content
		info.text = HOPADDON_OLDCONTENT
		info.value = "1"
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- normal
		info.text = PLAYER_DIFFICULTY1
		info.value = 100
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)		
		-- heroic
		info.text = PLAYER_DIFFICULTY2
		info.value = 200
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		--[[ draenor challenge modes
		info.text = PLAYER_DIFFICULTY5
		info.value = 300
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		]]
		-- mythic
		info.text = PLAYER_DIFFICULTY6
		info.value = 300
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- mythic key
		info.text = GetItemInfo(138019)
		info.value = 400
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)	

	elseif (level == 2) then
		local groupAct = C_LFGList.GetAvailableActivities(2, nil, 0,"")
		
		-- creating expansions
		if UIDROPDOWNMENU_MENU_VALUE == "1" then
			for i=0,5 do
				info.text = _G["EXPANSION_NAME"..i]
				info.value = "2"..i
				info.func = nil
				info.hasArrow = true
				info.checked = false
				UIDropDownMenu_AddButton(info,level)
			end	
		end
		
		for i=1, #groupAct do
			local activityID = groupAct[i];
			local fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			
			local expac = dDropList[activityID]
			if expac then
				if UIDROPDOWNMENU_MENU_VALUE == expac then
				info.text = fullName
				info.value = activityID
				info.func = hopAddon.searchFrame.dungeonsDrop_OnClick
				info.hasArrow = false;
				info.checked = (self.activeValue == info.value)
				UIDropDownMenu_AddButton(info,level)
				end
			end

		end
	elseif (level == 3) then
		local groupAct = C_LFGList.GetAvailableActivities(2, nil, 0,"")
	
		for i=1, #groupAct do
			local activityID = groupAct[i];
			local fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			
			local expac = dDropList[activityID]
			if expac then
				if UIDROPDOWNMENU_MENU_VALUE == "2"..expac then
				info.text = fullName
				info.value = activityID
				info.func = hopAddon.searchFrame.dungeonsDrop_OnClick
				info.hasArrow = false;
				info.checked = (self.activeValue == info.value)
				UIDropDownMenu_AddButton(info,level)
				end
			end

		end	
	end
end

UIDropDownMenu_Initialize(dDrop, dDrop.initialize)
UIDropDownMenu_SetSelectedID(dDrop, 0)
UIDropDownMenu_SetText(dDrop,NONE)
UIDropDownMenu_SetWidth(dDrop,180)


-- Raids dropdown list set up
function hopAddon.searchFrame.raidsDrop_OnClick(self,arg1,arg2,checked)
	rDrop.activeValue = self.value

	if self.value == 0 then
		UIDropDownMenu_SetText(rDrop,NONE)
	else
		UIDropDownMenu_SetText(rDrop,C_LFGList.GetActivityInfo(self.value))
	end
	CloseDropDownMenus()
	hopAddon_searchBox_OnEnter(hopAddon.searchFrame.searchBox)
end

local rDropList = {
	-- classic
	[9] = 0,[293] = 0,[294] = 0,[295] = 0,
	-- bc
	[45] = 1,[296] = 1,[297] = 1,[298] = 1,
	[299] = 1,[300] = 1,[301] = 1,
	-- wotlk
	[43] = 2,[44] = 2,[46] = 2,[47] = 2,
	[48] = 2,[49] = 2,[302] = 2,[303] = 2,
	[304] = 2,[305] = 2,[306] = 2,[307] = 2,
	[308] = 2,[309] = 2,[310] = 2,[311] = 2,
	-- cata
	[313] = 3,[316] = 3,[317] = 3,[318] = 3,
	[319] = 3,[320] = 3,[321] = 3,[322] = 3,
	[323] = 3,[324] = 3,[325] = 3,[326] = 3,
	[327] = 3,[328] = 3,[329] = 3,[330] = 3,
	[331] = 3,[332] = 3,[333] = 3,[334] = 3,
	-- pandaria
	[397] = 4,
	[4] = 4,[41] = 4,[42] = 4,[335] = 4,
	[336] = 4,[337] = 4,[338] = 4,[339] = 4,
	[340] = 4,[341] = 4,[342] = 4,[343] = 4,
	[344] = 4,[345] = 4,[346] = 4,[347] = 4,
	[348] = 4,[349] = 4,[350] = 4,
	-- draenor
	[398] = 5,
	[37] = 5,[38] = 5,[39] = 5,
	[40] = 5,[399] = 5,[400] = 5,
	[409] = 5,[410] = 5,[412] = 5,
	-- legion
	[413] = 100, [414] = 100, [468] = 100, -- raid 1: emerald nightmare
	[456] = 200, [457] = 200,-- raid 7.1: helya
	[415] = 300, [416] = 300, -- raid 2: nighthold
	[478] = 400, [479] = 400 -- raid 3: tomb of sargeras
}


function rDrop.initialize(self,level)
	local info = UIDropDownMenu_CreateInfo()

	if (not level or level == 1) then
		-- no filter
		info.text = NONE;
		info.value = 0;	
		info.func = hopAddon.searchFrame.raidsDrop_OnClick
		info.hasArrow = false;
		info.checked = false
		UIDropDownMenu_AddButton(info);
		-- old content
		info.text = HOPADDON_OLDCONTENT
		info.value = "1"
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)

		-- outdoor bosses
		info.text = C_LFGList.GetActivityInfo(458)
		info.value = 458
		info.func = hopAddon.searchFrame.raidsDrop_OnClick
		info.hasArrow = false;
		info.checked = (self.activeValue == info.value)
		UIDropDownMenu_AddButton(info,level)

		-- nighmare raid
		info.text = GetMapNameByID(1094)
		info.value = 100
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- thorim raid
		info.text = GetMapNameByID(1114)
		info.value = 200
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)		
		-- elf raid
		info.text = GetMapNameByID(1088)
		info.value = 300
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- tomb of sargeras
		--[[
		info.text = GetMapNameByID(1147)
		info.value = 400
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		]]
	elseif (level == 2) then
		local raidAct = C_LFGList.GetAvailableActivities(3, nil, 0,"")
		
		-- creating expansions
		if UIDROPDOWNMENU_MENU_VALUE == "1" then
			for i=0,5 do
				info.text = _G["EXPANSION_NAME"..i]
				info.value = "3"..i
				info.func = nil
				info.hasArrow = true
				info.checked = false
				UIDropDownMenu_AddButton(info,level)
			end	
		end
		
		for i=1,#raidAct do
			local activityID = raidAct[i];
			local fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			
			local expac = rDropList[activityID]
			if expac then
				if UIDROPDOWNMENU_MENU_VALUE == expac then
					info.text = fullName
					info.value = activityID
					info.func = hopAddon.searchFrame.raidsDrop_OnClick
					info.hasArrow = false;
					info.checked = (self.activeValue == info.value)
					UIDropDownMenu_AddButton(info,level)
				end
			end
		end

	elseif (level == 3) then
		local raidAct = C_LFGList.GetAvailableActivities(3, nil, 0,"")
		-- low level raids
		for i=1, #raidAct do
			local activityID = raidAct[i];
			local fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			
			local expac = rDropList[activityID]
			if expac then
				if UIDROPDOWNMENU_MENU_VALUE == "3"..expac then
					info.text = fullName
					info.value = activityID
					info.func = hopAddon.searchFrame.raidsDrop_OnClick
					info.hasArrow = false;
					info.checked = (self.activeValue == info.value)
					UIDropDownMenu_AddButton(info,level)
				end
			end
		end
	end
end

UIDropDownMenu_Initialize(rDrop, rDrop.initialize)
UIDropDownMenu_SetSelectedID(rDrop, 0)
UIDropDownMenu_SetText(rDrop,NONE)
UIDropDownMenu_SetWidth(rDrop,180)


function hopAddon_searchBox_OnEnter(frame)
	frame:ClearFocus()
		
	SplitKeywords(frame:GetText():lower())
	if #SearchKeywords == 0 then
		hopAddon.searchFrame.searchBox.clearButton:Show()
	end
	
	-- first, check if we have available groups in current results
	FilterCustomSearchResults()
end

hopAddon.searchFrame.searchBox:SetScript("OnEnterPressed", hopAddon_searchBox_OnEnter)

hopAddon.searchFrame.searchBox.clearButton:SetScript("OnClick", function(btn)
	-- also clear field
	SearchBoxTemplateClearButton_OnClick(btn)
	hopAddon.searchFrame.SearchString = ""
	FinishCustomSearch()
	btn:Hide()
end)

hopAddon.searchFrame.refreshButton:SetScript("OnClick", function(self)
	CustomSearch()
	PlaySound("igMainMenuOptionCheckBoxOn")
end)


-- EVENT FUNCTIONS --

local function SearchFrame_EventSystem(self, event, ...)
	local arg1 = ...

	if event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" then
		searchUpdated = 0
		FilterCustomSearchResults()
	end
			
	if event == "LFG_LIST_SEARCH_RESULT_UPDATED" then
		if #FilteredGroupsList > 0 then
			RemoveDelisted()
		end
	end
	
	if event == "GROUP_ROSTER_UPDATE" then
		-- Stopping search in a group
		if var.addonSearchRequest then
			if customOptions.endlessCheckBox:GetChecked() then
				FinishCustomSearch()
			end
		end		
	end
	if event == "PLAYER_LEVEL_UP" then
		UIDropDownMenu_Initialize(rDrop, rDrop.initialize)
		UIDropDownMenu_Initialize(dDrop, dDrop.initialize)
	end
end

local backgroundScanner = CreateFrame("Frame")
--Events
backgroundScanner:SetScript("OnEvent", SearchFrame_EventSystem)
backgroundScanner:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
backgroundScanner:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
backgroundScanner:RegisterEvent("LFG_LIST_JOINED_GROUP")
backgroundScanner:RegisterEvent("GROUP_ROSTER_UPDATE")
backgroundScanner:RegisterEvent("PLAYER_LEVEL_UP")

local function OnUpdate(self,elapsed)
	searchUpdated = searchUpdated + elapsed
		
	-- HARDTESTED: blizzard allows to throw 2 search results per 5 seconds	
	-- for customSearch we just get results when they should be available
	if searchUpdated >= 2.5 and (#FilteredGroupsList == 0 or not hopAddon.searchFrame.scrollframe:IsShown()) then
		hopAddon.searchFrame.refreshButton.anim:Play()
	else
		hopAddon.searchFrame.refreshButton.anim:Stop()
	end
end

backgroundScanner:SetScript("OnUpdate",OnUpdate)