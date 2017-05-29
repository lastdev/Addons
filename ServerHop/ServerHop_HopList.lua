-- MODULE FOR VIEWING HOSTED GROUP IN A LIST --

hopAddon.hopList = CreateFrame("Button","SH_HopListMainFrame",UIParent,"UIPanelDialogTemplate")
hopAddon.hopList:SetPoint("CENTER",0,0)
hopAddon.hopList:SetSize(490,400)
hopAddon.hopList:SetMovable(true)
hopAddon.hopList:EnableMouse(true)
hopAddon.hopList:RegisterForDrag("LeftButton")
hopAddon.hopList:SetScript("OnDragStart", hopAddon.hopList.StartMoving)
hopAddon.hopList:SetScript("OnDragStop", hopAddon.hopList.StopMovingOrSizing)
hopAddon.hopList:Hide()

local frame = hopAddon.hopList

-- refresh button
hopAddon.hopList.refreshButton = CreateFrame("Button", nil, hopAddon.hopList,"BrowserButtonTemplate")
hopAddon.hopList.refreshButton:SetSize(25,25)
hopAddon.hopList.refreshButton:SetFrameLevel(5)
hopAddon.hopList.refreshButton:SetPoint("TOPLEFT",hopAddon.hopList,5,-3)
hopAddon.hopList.refreshButton.Icon = hopAddon.hopList.refreshButton:CreateTexture(nil,"OVERLAY")
hopAddon.hopList.refreshButton.Icon:SetSize(14,14)
hopAddon.hopList.refreshButton.Icon:SetPoint("CENTER",0,0)
hopAddon.hopList.refreshButton.Icon:SetTexture("Interface\\Buttons\\UI-RefreshButton")

function SH_HostSearch()
	local lang={}
	for k,v in pairs(C_LFGList.GetAvailableLanguageSearchFilter()) do lang[v]=true end
	C_LFGList.Search(10, "", 0, 0, lang)
end

hopAddon.hopList.refreshButton:SetScript("OnClick",function (self)
	SH_HostSearch()
end)

frame.OnlyMyZoneCheck = CreateFrame("CheckButton","SH_OnlyMyZoneCheck",frame,"ChatConfigCheckButtonTemplate")
frame.OnlyMyZoneCheck:SetPoint("TOP",15,-3)
local a1,fr,a2,x,y = getglobal(frame.OnlyMyZoneCheck:GetName() .. 'Text'):GetPoint()
getglobal(frame.OnlyMyZoneCheck:GetName() .. 'Text'):ClearAllPoints()
getglobal(frame.OnlyMyZoneCheck:GetName() .. 'Text'):SetPoint(a1,fr,a2,x,0)
getglobal(frame.OnlyMyZoneCheck:GetName() .. 'Text'):SetText(HOPADDON_ONLYMYZONE_CHECK)

--hostOptions.showAlertsZone.tooltip = HOPADDON_AUTOINVITE_TOOLTIP
frame.OnlyMyZoneCheck:SetChecked(false)



frame.textStats = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
frame.textStats:SetSize(120,18)
frame.textStats:SetPoint("TOPRIGHT",-30,-7)
frame.textStats:SetJustifyH("RIGHT")
frame.textStats:SetText("")

-- scroll field

hopAddon.hopList.scrollframe = CreateFrame("ScrollFrame", "SH_HopListScroll", hopAddon.hopList, "UIPanelScrollFrameTemplate");
hopAddon.hopList.scrollframe:SetPoint("TOPLEFT",hopAddon.hopList,0,-29)
hopAddon.hopList.scrollframe:SetSize(480,360)
local scrollbarName = hopAddon.hopList.scrollframe:GetName()

hopAddon.hopList.scrollframe.scrollchild = CreateFrame("Frame")
hopAddon.hopList.scrollframe.scrollchild:SetSize(hopAddon.hopList.scrollframe:GetWidth(), hopAddon.hopList.scrollframe:GetHeight());

hopAddon.hopList.scrollframe:SetScrollChild(hopAddon.hopList.scrollframe.scrollchild);

hopAddon.hopList.scrollframe.scrollupbutton = _G[scrollbarName.."ScrollBarScrollUpButton"];
hopAddon.hopList.scrollframe.scrollupbutton:ClearAllPoints();
hopAddon.hopList.scrollframe.scrollupbutton:SetPoint("TOPRIGHT", hopAddon.hopList.scrollframe, "TOPRIGHT", 0, 0);

hopAddon.hopList.scrollframe.scrolldownbutton = _G[scrollbarName.."ScrollBarScrollDownButton"];
hopAddon.hopList.scrollframe.scrolldownbutton:ClearAllPoints();
hopAddon.hopList.scrollframe.scrolldownbutton:SetPoint("BOTTOMRIGHT", hopAddon.hopList.scrollframe, "BOTTOMRIGHT", 0, -3);

hopAddon.hopList.scrollframe.scrollbar = _G[scrollbarName.."ScrollBar"];
hopAddon.hopList.scrollframe.scrollbar:ClearAllPoints();
hopAddon.hopList.scrollframe.scrollbar:SetPoint("TOP", hopAddon.hopList.scrollframe.scrollupbutton, "BOTTOM", 0, 4);
hopAddon.hopList.scrollframe.scrollbar:SetPoint("BOTTOM", hopAddon.hopList.scrollframe.scrolldownbutton, "TOP", 0, -4);


local headerFrames = {}
local HEADER_HEIGHT = 28
local resultFrames = {}
local resultFramesById = {}
local RESULT_HEIGHT = 28

local filteredGroupList = {}
local zoneList = {}

local visitedList = {}
local toVisit = ""

local function MakeHeaderFrame()
	local frame = CreateFrame("Button",nil,hopAddon.hopList.scrollframe.scrollchild)
	frame:SetSize(470,HEADER_HEIGHT)
	frame:SetPoint("TOPLEFT",0,0)

	frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
						tile = true, tileSize = 16, edgeSize = 16, 
						insets = { left = 2, right = 2, top = 2, bottom = 2 }});
	frame:SetBackdropColor(0,0,0,1);
	
	frame.textHeader = frame:CreateFontString(nil, "OVERLAY", "QuestTitleFontBlackShadow")
	frame.textHeader:SetPoint("LEFT",20,0)
	frame.textHeader:SetJustifyH("LEFT")
	frame.textHeader:SetText("Zone Sample")
	
	frame.zone = 0
	
	frame:SetScript("OnClick", function()
		if frame.zone ~= -1 then
			for i,z in ipairs(zoneList) do
				if z[frame.zone] ~= nil then
					zoneList[i][frame.zone] = not zoneList[i][frame.zone]
					break
				end
			end

			hopAddon.hopList:RecreateList()
		end
	end)
	
	frame:Hide()
	
	table.insert(headerFrames,frame)
	return frame
end

local function ResultFrame_OnEnter(self)
	local resultID = self.result;
	local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(resultID)
	local memberCounts = C_LFGList.GetSearchResultMemberCounts(resultID);
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, -40);
	
	if self.isLFG then
		local fullName, shortName, categoryID, groupID, iLevel, filters, minLevel, maxPlayers, displayType, orderIndex, useHonorLevel = C_LFGList.GetActivityInfo(activityID);
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
	else
		GameTooltip:SetText(name);

		if autoinv then
			GameTooltip:AddLine(HOPADDON_AUTOINVITE, 0.25, 0.75, 0.25, true)
		end	
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


	local id, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(resultID);
	if pendingStatus == "applied" or appStatus == "applied" then
		-- cancel application
	elseif pendingStatus == "invited" or appStatus == "invited" then
		-- decline invite
	else
		GameTooltip:AddLine(" ");
		GameTooltip:AddDoubleLine(HOPADDON_APPLY,HOPADDON_LMB,0.25, 0.75, 0.25);
	end

	GameTooltip:Show();
end

local function MakeResultFrame()

	local frame = CreateFrame("Button",nil,hopAddon.hopList.scrollframe.scrollchild)
	frame:SetSize(430,RESULT_HEIGHT)
	frame:SetPoint("TOPLEFT",0,0)

	frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = "", 
						tile = true, tileSize = 16, edgeSize = 16, 
						insets = { left = 2, right = 2, top = 2, bottom = 2 }});
	frame:SetBackdropColor(0,0,0,1);

	frame.grayMask = CreateFrame("Button",nil,frame)
	frame.grayMask:SetAllPoints(frame)
	frame.grayMask:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = "", 
						tile = true, tileSize = 16, edgeSize = 16, 
						insets = { left = 2, right = 2, top = 2, bottom = 2 }});
	frame.grayMask:SetBackdropColor(0,0,0,0.8);
	frame.grayMask:Hide()
	
	local highlightTexture = frame:CreateTexture()
	highlightTexture:SetPoint("TOPLEFT",-2,5)
	highlightTexture:SetPoint("BOTTOMRIGHT",2,-7)
	highlightTexture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
	frame:SetHighlightTexture(highlightTexture,"ADD")

	frame.iconRedx	= frame:CreateTexture(nil,"OVERLAY")
	frame.iconRedx:SetSize(20,20)
	frame.iconRedx:SetPoint("RIGHT", frame, "RIGHT", -8,0)
	frame.iconRedx:SetAtlas("groupfinder-icon-redx")
	frame.iconRedx:Hide()

	frame.iconGreenChck	= frame:CreateTexture(nil,"OVERLAY")
	frame.iconGreenChck:SetSize(20,20)
	frame.iconGreenChck:SetPoint("RIGHT", frame, "RIGHT", -8,0)
	frame.iconGreenChck:SetAtlas("Tracker-Check")
	frame.iconGreenChck:Hide()

	frame.spinner = CreateFrame("Frame",nil,frame,"LoadingSpinnerTemplate")
	frame.spinner:SetSize(RESULT_HEIGHT+8,RESULT_HEIGHT+8)
	frame.spinner:SetPoint("RIGHT", frame, "RIGHT", 0,0)
	frame.spinner:Hide()
	frame.spinner:SetHitRectInsets(8, 8, 8, 8)

	frame.btnClose = CreateFrame("Button",nil,frame,"UIMenuButtonStretchTemplate")
	frame.btnClose:SetSize(RESULT_HEIGHT-4,RESULT_HEIGHT-4)
	frame.btnClose:SetPoint("RIGHT",frame,-8,0)
	frame.btnClose:SetFrameLevel(10)

	frame.btnClose:Hide()
	frame.btnClose.Icon	= frame.btnClose:CreateTexture(nil,"ARTWORK")
	frame.btnClose.Icon:SetSize(24,24)
	frame.btnClose.Icon:SetPoint("CENTER", 0,0)
	frame.btnClose.Icon:SetAtlas("groupfinder-icon-redx",true)

	frame.spinner:SetScript("OnEnter", function (self,motion)
		if motion then
			frame.btnClose:Show()
		end
	end)
	frame.btnClose:SetScript("OnLeave", function (self,motion)
		self:Hide()
	end)
	frame.btnClose:SetScript("OnClick", function (self,btn,down)
		local id, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(frame.result);

		if appStatus == "applied" or pendingStatus == "applied" then
			C_LFGList.CancelApplication(frame.result)
		elseif pendingStatus == "invited" or appStatus == "invited" then
			LFGListInviteDialog.DeclineButton:Click()
		end

		frame.grayMask:Show()
		self:Hide()
		frame.spinner:Hide()
	end)

		
	frame.textTime = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.textTime:SetSize(30,16)
	frame.textTime:SetPoint("LEFT",frame,"LEFT",7,0)
	frame.textTime:SetJustifyH("CENTER")
	frame.textTime:SetText("")
		
	frame.textRealm = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.textRealm:SetSize(120,18)
	frame.textRealm:SetPoint("LEFT",frame.textTime,"RIGHT",4,0)
	frame.textRealm:SetJustifyH("LEFT")
	frame.textRealm:SetText("")

	frame.textCount = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.textCount:SetSize(18,16)
	frame.textCount:SetPoint("LEFT",frame.textRealm,"RIGHT",7,0)
	frame.textCount:SetJustifyH("RIGHT")
	frame.textCount:SetText("")

	frame.icon = frame:CreateTexture(nil,"OVERLAY")
	frame.icon:SetSize(16,16)
	frame.icon:SetPoint("RIGHT", frame.textCount, 16,0)
	frame.icon:SetAtlas("groupfinder-waitdot")

	frame.textName = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.textName:SetSize(178,18)
	frame.textName:SetPoint("LEFT",frame.icon,"RIGHT",4,0)
	frame.textName:SetJustifyH("LEFT")
	frame.textName:SetText("")

	
	frame.result = 0
	frame.isLFG = true
	
	frame:SetScript("OnEnter", ResultFrame_OnEnter)
	frame:SetScript("OnLeave", function(self) GameTooltip:Hide() end);	
	--frame:RegisterForClicks("AnyUp")
	frame:SetScript("OnClick", function(self,button,down)
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
			--[[
			tank = tank and customOptions.tankCheckButton:GetChecked()
			heal = heal and customOptions.healCheckButton:GetChecked()
			dd = dd and customOptions.dpsCheckButton:GetChecked()
			]]
			C_LFGList.ApplyToGroup(self.result, "", tank, heal, dd)
			local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(self.result)
			toVisit = leaderName
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			PlaySound("ui_garrison_architecttable_buildingplacementerror","Master")			
		end
	end)

	frame:Hide()

	table.insert(resultFrames,frame)
	return frame

end

local function FindSpareHeader(num)
	if num > #headerFrames then
		return MakeHeaderFrame()
	else
		return headerFrames[num]
	end
end

local function FindSpareResult(num)
	if num > #resultFrames then
		return MakeResultFrame()
	else
		return resultFrames[num]
	end
end

local function PopulateHeader(frame,coord,zoneID)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT",10,coord)
	frame.zone = zoneID
	if zoneID == -1 then
		frame.textHeader:SetText(SERVERHOP_OTHERGROUPS)
	elseif zoneID == 1 then
		frame.textHeader:SetText(UNKNOWN)
	else
		frame.textHeader:SetText(C_LFGList.GetActivityInfo(zoneID))
	end
	frame:Show()
end

local function PopulateResult(frame,coord,resultID,isLFG)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT",30,coord)
	local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(resultID)

	local id, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(resultID);
	
	if appDuration == 0 and pendingStatus == "applied" then
			-- phantom groups fix
			-- phantom groups have 0 duration and applied pending				
	else
		if pendingStatus == "applied" or appStatus == "applied" then
			frame.spinner:Show()
			frame.spinner.Anim:Play()
		elseif pendingStatus == "invited" or appStatus == "invited" then
			frame.iconGreenChck:Show()
			frame.spinner:Hide()
			frame.btnClose:Hide()
			frame.grayMask:Show()
		elseif appStatus == "invitedeclined" or appStatus == "declined" or appStatus == "timedout" then
			frame.iconRedx:Show()
			frame.spinner:Hide()
			frame.btnClose:Hide()
			frame.iconGreenChck:Hide()
			frame.grayMask:Show()
		end		
	end

	local fullname = leaderName or "???-???"
    local pname, realm = strsplit(_G.REALM_SEPARATORS, fullname)

    if visitedList[realm] then
    	local time = GetTime() - visitedList[realm]
    	local hours = math.floor(time / 3600)
		local minutes = math.floor(time / 60);

    	frame.textTime:SetText(hours..":"..minutes)
    end

	frame.textCount:SetText(numMembers)
	if autoinv then frame:SetBackdropColor(0.30,0.6,0.28,1) end
	

	--SOMETIMES REALMS IS NIL, CHECK WHY
	if realm == nil then realm = "???" end
	local pvpFlag = ""
	if hopAddon.var.pvpList[realm] == true then pvpFlag = "(PVP)" end
	frame.textRealm:SetText(pvpFlag..realm)

	if isLFG then
		frame.textName:SetText(name)
	else
		local precomment,tag,zonetext,groupsize = strsplit("/",comment)
		local str = PARTY if groupsize == "2" then str = RAID end
		frame.textName:SetText(str)
	end

	if isDelisted then
		frame.grayMask:Show()
	end

    frame.isLFG = isLFG
    frame.result = resultID

	resultFramesById[resultID] = frame
	frame:Show()
end

local function UpdateResult(frame)
	local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(frame.result)
	local id, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(frame.result);
	
	if appDuration == 0 and pendingStatus == "applied" then
			-- phantom groups fix
			-- phantom groups have 0 duration and applied pending				
	else
		if pendingStatus == "applied" or appStatus == "applied" then
			frame.spinner:Show()
			frame.spinner.Anim:Play()
		elseif pendingStatus == "invited" or appStatus == "invited" then
			frame.iconGreenChck:Show()
			frame.spinner:Hide()
			frame.btnClose:Hide()
			frame.grayMask:Show()
		elseif appStatus == "invitedeclined" or appStatus == "declined" or appStatus == "timedout" then
			frame.iconRedx:Show()
			frame.spinner:Hide()
			frame.btnClose:Hide()
			frame.iconGreenChck:Hide()
			frame.grayMask:Show()
		end		
	end

	local fullname = leaderName or "???-???"
    local pname, realm = strsplit(_G.REALM_SEPARATORS, fullname)

    if visitedList[realm] then
    	local time = GetTime() - visitedList[realm]
    	local hours = math.floor(time / 3600)
		local minutes = math.floor(time / 60);

    	frame.textTime:SetText(hours..":"..minutes)
    end


	frame.textCount:SetText(numMembers)
	if autoinv then frame:SetBackdropColor(0.30,0.6,0.28,1) else
		frame:SetBackdropColor(0,0,0,1)
	end

	--SOMETIMES REALMS IS NIL, CHECK WHY
	if realm == nil then realm = "???" end
	local pvpFlag = ""
	if hopAddon.var.pvpList[realm] == true then pvpFlag = "(PVP)" end
	frame.textRealm:SetText(pvpFlag..realm)

	if frame.isLFG then
		frame.textName:SetText(name)
	else
		if comment then
			local precomment,tag,zonetext,groupsize = strsplit("/",comment)
			local str = PARTY if groupsize == "2" then str = RAID end
			frame.textName:SetText(str)
		end
	end

	if isDelisted then
		frame.grayMask:Show()
	end
end

local function ResetResult(frame)

	frame.textTime:SetText("")
	frame.textName:SetText("")
	frame:SetBackdropColor(0,0,0,1)
	frame.spinner:Hide()
	frame.btnClose:Hide()
	frame.iconGreenChck:Hide()
	frame.iconRedx:Hide()
	frame.grayMask:Hide()
	frame:Hide()

end

function hopAddon.hopList:RecreateList()
	for i=1,#headerFrames do headerFrames[i]:Hide() end
	for i=1,#resultFrames do ResetResult(resultFrames[i]) end
	resultFramesById = {}

	--create a copy of a list
	--we will delete made groups from the copied list
	local temp = {}
	for k,v in pairs(filteredGroupList) do
		table.insert(temp,v)
	end

	-- sort groups for each zone
	local groupsForZone = {}
	-- delete all hosted groups from temp
	local toDelete = {}

	for i,z in ipairs(zoneList) do
		local zone = 0
		for k,v in pairs(z) do
			zone = k
		end
		-- list of groups for this zone id
		local groupsinthis = {}

		for key,value in ipairs(filteredGroupList) do
			local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(value)
			if comment ~= nil then
				local precomment,tag,zonetext,groupsize = strsplit("/",comment)
				if tag == "SH" and (groupsize == "1" or groupsize == "2") then
					local zoneID = tonumber(zonetext)

					if zoneID == zone then
						table.insert(groupsinthis,id)
						table.insert(toDelete,key)
					end
				end
			end
		end
		groupsForZone[zone] = groupsinthis
	end

	-- sort deleting results from min to max
	table.sort(toDelete)
	-- now just delete them
	local deletes = 0
	for i,v in ipairs(toDelete) do
		table.remove(temp,v-deletes)
		deletes = deletes + 1
	end

	-- filter zonelist here so that unknown zones will be last
	for i,z in ipairs(zoneList) do
		if z[1] ~= nil then
			local inf = z[1]
			table.remove(zoneList,i)
			local t = {}
			t[1] = inf
			table.insert(zoneList,t)
			break
		end
	end
	-- filter zonelist here so that your zone'll be the first (if you're in unknown, then it'll move it back on top)
	local curZone = hopAddon:GetMyZoneID()
	for i,z in ipairs(zoneList) do
		if z[curZone] ~= nil then
			table.remove(zoneList,i)
			local z = {}
			z[curZone] = true
			table.insert(zoneList,1,z)
			break
		end
	end
	local bufZoneList = zoneList
	if hopAddon.hopList.OnlyMyZoneCheck:GetChecked() then
		local t = {}
		table.insert(t,zoneList[1])
		bufZoneList = t
	end

	-- now build the list by the zone-filtered list
	local ycoord = 0
	local i = 0 -- header count
	local j = 0 -- result count

	-- create headers and rezults for all non-empty hosted zones
	for iter,z in ipairs(bufZoneList) do
		local zone = 0
		for k,v in pairs(z) do
			zone = k
		end

		if #groupsForZone[zone] > 0 then
			i = i+1
			local header = FindSpareHeader(i)
			PopulateHeader(header,ycoord,zone)
			ycoord = ycoord - HEADER_HEIGHT

			if z[zone] then
				for key,value in ipairs(groupsForZone[zone]) do
					j = j+1
					local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(value)
					PopulateResult(FindSpareResult(j),ycoord,value,false)
					ycoord = ycoord - RESULT_HEIGHT
				end
			else
				header.textHeader:SetText(header.textHeader:GetText().." ("..#groupsForZone[zone]..")")
			end
		end
	end

	-- show stats on top of the frame
	local count,resTable = C_LFGList.GetSearchResults()
	hopAddon.hopList.textStats:SetText(j.."/"..count)

	-- second, create header and rows for non-hosted groups
	if #temp > 0 then
		local header = FindSpareHeader(i+1)
		PopulateHeader(header,ycoord,-1)
		ycoord = ycoord - HEADER_HEIGHT
		for k,v in ipairs(temp) do
			j=j+1
			PopulateResult(FindSpareResult(j),ycoord,v,true)
			ycoord = ycoord - RESULT_HEIGHT
		end
		header.textHeader:SetText(header.textHeader:GetText().." ("..#temp..")")
	end
end

local function FilterResults()
	local count,resTable = C_LFGList.GetSearchResults()

	local buf = {}
	for i,v in ipairs(resTable) do
		table.insert(buf,v)
	end

	local fullParties = {}
	local deletes = 0
	for i,v in ipairs(buf) do
		local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(v)

		-- remove all groups from our realm
		local fullname = leaderName or "???-???"
		local pname, realm = strsplit(_G.REALM_SEPARATORS, fullname)
		realm = realm or GetRealmName();

		if realm == GetRealmName() then
			table.remove(resTable,i-deletes)
			deletes = deletes + 1
		else

			-- remove full parties to a separate list
			if numMembers == 5 or numMembers == 40 then
				table.insert(fullParties,v)
				table.remove(resTable,i-deletes)
				deletes = deletes + 1
			end

			-- also populate zonelist
			local precomment,tag,zonetext,groupsize = strsplit("/",comment)
			if tag == "SH" and (groupsize == "1" or groupsize == "2") then
				zoneID = tonumber(zonetext)
				-- make sure to add only existing zones, nonexistent are marked as 1
				local fullName, shortName, categoryID, groupID, iLevel, filters, minLevel, maxPlayers, displayType, orderIndex, useHonorLevel = C_LFGList.GetActivityInfo(zoneID);
				if not fullName then zoneID = 1 end
				-- add a zone to the list if it's the new one we've met
				local contains = false
				for i,z in ipairs(zoneList) do
					if z[zoneID] ~= nil then
						contains = true
						break
					end
				end

				if not contains then
					local z = {}
					z[zoneID] = true
					table.insert(zoneList,z)
				end
			end
		end
	end

	-- sort non full parties by size
	table.sort(resTable,function(id1,id2)
		local pcount1 = select(14,C_LFGList.GetSearchResultInfo(id1))
		local pcount2 = select(14,C_LFGList.GetSearchResultInfo(id2))
		return pcount1 < pcount2
	end)

	-- sort for auto in available parties
	local nonfullAuto = {}
	local nonfullNonAuto = {}
	for i,v in pairs(resTable) do
		local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(v)
		if autoinv then
			table.insert(nonfullAuto,v)
		else
			table.insert(nonfullNonAuto,v)
		end
	end

	-- sort for auto in full parties
	local fullAuto = {}
	local fullNonAuto = {}
	for i,v in pairs(fullParties) do
		local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(v)
		if autoinv then
			table.insert(fullAuto,v)
		else
			table.insert(fullNonAuto,v)
		end
	end

	-- create sorted by autoinvite and size list
	filteredGroupList = {}
	for k,v in pairs(nonfullAuto) do
		table.insert(filteredGroupList,v)
	end
	for k,v in pairs(nonfullNonAuto) do
		table.insert(filteredGroupList,v)
	end
	for k,v in pairs(fullAuto) do
		table.insert(filteredGroupList,v)
	end
	for k,v in pairs(fullNonAuto) do
		table.insert(filteredGroupList,v)
	end


	hopAddon.hopList:RecreateList()
end

hopAddon.hopList.OnlyMyZoneCheck:SetScript("OnClick", function(self)
	hopAddon.hopList:RecreateList()
	PlaySound("igMainMenuOptionCheckBoxOn")
end)


local function OnEvent(self,event,arg1,...)
	if event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" then
		-- filter results here
		FilterResults()
	end
	
	if event == "LFG_LIST_SEARCH_RESULT_UPDATED" then
		local id = arg1
		-- check if there's a frame for an id, since we ignore some id's (from our realms for example)
		if resultFramesById[id] then
			UpdateResult(resultFramesById[id])
		end

	end

	if event == "ADDON_LOADED" and arg1 == "ServerHop" then
		FilterResults()
	end

	if event == "GROUP_ROSTER_UPDATE" then

		local index = GetNumGroupMembers()
		local name, server
		local fullname
		
		if IsInRaid() then
			for i=1,index do
				if UnitIsGroupLeader("raid"..i) then
					fullname = GetUnitName("raid"..i,true)
					name,server = UnitName("raid"..i)
					break
				end
			end
		else
			for i=1,4 do
				if UnitIsGroupLeader("party"..i) then
					fullname = GetUnitName("party"..i,true)
					name,server = UnitName("party"..i)
					break
				end
			end
		end
		
		if fullname == toVisit then
			visitedList[server] = GetTime()
			toVisit = "nan"
		end

	end
end

hopAddon.hopList:SetScript("OnEvent",OnEvent)
hopAddon.hopList:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
hopAddon.hopList:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
hopAddon.hopList:RegisterEvent("ADDON_LOADED")
hopAddon.hopList:RegisterEvent("GROUP_ROSTER_UPDATE")

-- Attaching to the HostFrame module --
hopAddon.hostFrame.openList = CreateFrame("Button",nil,hopAddon.hostFrame,"UIGoldBorderButtonTemplate")
hopAddon.hostFrame.openList:SetSize(100,30)
hopAddon.hostFrame.openList:SetPoint("BOTTOMLEFT",16,10)
hopAddon.hostFrame.openList:SetText(SERVERHOP_OPENHOPLIST)
hopAddon.hostFrame.openList:SetScript("OnClick",function(self)
	hopAddon.hopList:Show()
end)