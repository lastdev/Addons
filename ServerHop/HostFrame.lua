-- MODULE FOR HOSTING FRAME --
local hostOptions = hopAddon.optionsFrame.hostOptionsFrame

-- Holder frame
hopAddon.hostFrame = CreateFrame("Frame",nil,hopAddon)
local hostFrame = hopAddon.hostFrame

hopAddon.hostFrame:SetSize(HOPADDON_WIDTH,HOPADDON_HEIGHT)
hopAddon.hostFrame:SetPoint("BOTTOM",0,0)
hopAddon.hostFrame.lastUpdate = 0
hopAddon.hostFrame.queueUpdate = 0
hopAddon.hostFrame:Hide()

hopAddon.hostFrame.background = hopAddon.hostFrame:CreateTexture(nil,"BORDER")
hopAddon.hostFrame.background:SetSize(HOPADDON_WIDTH+106,HOPADDON_HEIGHT-10)
hopAddon.hostFrame.background:SetPoint("BOTTOM",1,5)
hopAddon.hostFrame.background:SetTexture("Interface\\Challenges\\challenges-besttime-bg")

hopAddon.hostFrame.stringRealm = hopAddon.hostFrame:CreateFontString("realmname", "OVERLAY", "QuestFont_Shadow_Huge")
hopAddon.hostFrame.stringRealm:SetPoint("BOTTOM",0,72)
hopAddon.hostFrame.stringRealm:SetTextColor(1, 0.914, 0.682, 1)
hopAddon.hostFrame.stringRealm:SetText(GetRealmName())

-- Host button is attached in hoplist module


-- BLOCK FOR GROUP HOSTING --
local disconnectedList = {}

local lastUp = 0
local updateInterval = 5
local lastTimeSuggestedZone = {}

lastTimeSolo = GetTime()
-- list of options in droplist
local droptable = {
	PARTY,
	RAID,
}

hopAddon.var.hostApp = {}
hopAddon.var.hostApp.activityID = 361
hopAddon.var.hostApp.iLevel = 0
hopAddon.var.hostApp.honorLevel = 0
hopAddon.var.hostApp.name = "unknown zone"
hopAddon.var.hostApp.comment = hopAddon.var.defaultComment
hopAddon.var.hostApp.voiceChat = ""
hopAddon.var.hostApp.autoAccept = true


-- Create host button
hopAddon.hostFrame.buttonHost = CreateFrame("Button",nil,hopAddon.hostFrame,"UIGoldBorderButtonTemplate")
hopAddon.hostFrame.buttonHost:SetSize(130,24)
hopAddon.hostFrame.buttonHost:SetPoint("RIGHT", -17,0)
hopAddon.hostFrame.buttonHost:SetText(SERVERHOP_GROUPHOSTING)
hopAddon.hostFrame.buttonHost.errorText = SERVERHOP_MUSTBESOLOORGR
hopAddon.hostFrame.buttonHost:SetMotionScriptsWhileDisabled(true)
hopAddon.hostFrame.buttonHost:SetScript("OnEnter", function(self)
	if not self:IsEnabled() then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.errorText, nil, nil, nil, nil, true)
		GameTooltip:Show()
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(SERVERHOP_HOSTINGINFO1)
		GameTooltip:AddLine(SERVERHOP_HOSTINGINFO2,1,1,1,true)
		GameTooltip:Show()
	end

end)
hopAddon.hostFrame.buttonHost:SetScript("OnLeave", GameTooltip_Hide)
-- disable host button if we're in group when logged in
if (IsInGroup() or IsInRaid()) and not UnitIsGroupLeader("player") then
	hopAddon.hostFrame.buttonHost:Disable()
end

-- dropdown next to host button
local frame = hopAddon.hostFrame
frame.sizeDrop = CreateFrame("Frame", "SH_HostingGroupDrop", frame, "UIDropDownMenuTemplate")
local drop = frame.sizeDrop
drop:SetPoint("RIGHT",frame.buttonHost,"LEFT",10,-2)
drop.Text:SetPoint("LEFT",drop,"LEFT",0,2)
drop.Text:SetPoint("RIGHT",drop,"RIGHT",-38,2)

local function DropOnClick(self)
	local id = self:GetID()
	if id == UIDropDownMenu_GetSelectedID(drop) then return end
	
	UIDropDownMenu_SetSelectedID(drop,id)

	-- also change party size
	if hopAddon.var.hosting and UnitIsGroupLeader("player") then
		if id == 1 then
			if GetNumGroupMembers() > 5 then
				C_LFGList.RemoveListing()
				SendAddonMessage(HOPADDON_PREFIX,"REMOVE_LISTING","RAID")
				LeaveParty()
			else
				ConvertToParty()
				hopAddon.var.hostApp:SetName(hopAddon:GetMyZoneID())
				C_LFGList.UpdateListing(hopAddon.var.hostApp.activityID,hopAddon.var.hostApp.name,hopAddon.var.hostApp.iLevel,hopAddon.var.hostApp.honorLevel,hopAddon.var.hostApp.voiceChat,hopAddon.var.hostApp.comment,hopAddon.var.hostApp.autoAccept)				
			end
		elseif id == 2 then
			ConvertToRaid()
			hopAddon.var.hostApp:SetName(hopAddon:GetMyZoneID())
			C_LFGList.UpdateListing(hopAddon.var.hostApp.activityID,hopAddon.var.hostApp.name,hopAddon.var.hostApp.iLevel,hopAddon.var.hostApp.honorLevel,hopAddon.var.hostApp.voiceChat,hopAddon.var.hostApp.comment,hopAddon.var.hostApp.autoAccept)
		end
	end
end

drop.initialize = function(self,level)
	if not level then return end
	local info = UIDropDownMenu_CreateInfo()
	for k,v in pairs(droptable) do
		info = UIDropDownMenu_CreateInfo()
		info.text = v
		info.value = v
		info.func = DropOnClick
		UIDropDownMenu_AddButton(info,level)
	end
end
UIDropDownMenu_Initialize(drop, drop.initialize)
UIDropDownMenu_SetSelectedID(drop, 1)
UIDropDownMenu_SetText(drop,droptable[1])
UIDropDownMenu_SetWidth(drop,54)

-- holder for info when hosting
hopAddon.hostFrame.hostingGroupFrame = CreateFrame("Frame",nil,hopAddon.hostFrame)
local frame = hopAddon.hostFrame.hostingGroupFrame
frame:SetSize(300,40)
frame:SetPoint("RIGHT",0,0)
frame:Hide()

frame.buttonStop = CreateFrame("Button", nil, frame, "UIMenuButtonStretchTemplate")
frame.buttonStop:SetSize(24,24)
frame.buttonStop:SetPoint("RIGHT",-18,0)
frame.buttonStop.iconRedx = frame.buttonStop:CreateTexture(nil,"OVERLAY")
frame.buttonStop.iconRedx:SetSize(20,20)
frame.buttonStop.iconRedx:SetPoint("CENTER",0,0)
frame.buttonStop.iconRedx:SetAtlas("groupfinder-icon-redx",true)
frame.buttonStop:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight" , "ADD")
--frame.buttonStop.tooltipText = "kek"

frame.Waitdot3 = frame:CreateTexture("SH_GC_Waitdot3","ARTWORK")
frame.Waitdot3:SetPoint("CENTER",52,0)
frame.Waitdot3:SetAtlas("groupfinder-waitdot",true)
frame.Waitdot3:SetVertexColor(1,1,1,0)

frame.Waitdot2 = frame:CreateTexture("SH_GC_Waitdot2","ARTWORK")
frame.Waitdot2:SetPoint("CENTER", "SH_GC_Waitdot3", -16,0)
frame.Waitdot2:SetAtlas("groupfinder-waitdot",true)
frame.Waitdot2:SetVertexColor(1,1,1,0)

frame.Waitdot1 = frame:CreateTexture("SH_GC_Waitdot1","ARTWORK")
frame.Waitdot1:SetPoint("CENTER", "SH_GC_Waitdot2", -16,0)
frame.Waitdot1:SetAtlas("groupfinder-waitdot",true)
frame.Waitdot1:SetVertexColor(1,1,1,0)

frame.Waitdot4 = frame:CreateTexture("SH_GC_Waitdot4","ARTWORK")
frame.Waitdot4:SetPoint("CENTER", "SH_GC_Waitdot3",16,0)
frame.Waitdot4:SetAtlas("groupfinder-waitdot",true)
frame.Waitdot4:SetVertexColor(1,1,1,0)

frame.Waitdot5 = frame:CreateTexture("SH_GC_Waitdot5","ARTWORK")
frame.Waitdot5:SetPoint("CENTER", "SH_GC_Waitdot4",16,0)
frame.Waitdot5:SetAtlas("groupfinder-waitdot",true)
frame.Waitdot5:SetVertexColor(1,1,1,0)

frame.anim = frame:CreateAnimationGroup("Hosting")
frame.anim:SetLooping("REPEAT")

-- show one-by-one
SH_AddAlphaAnimation(frame.anim,"Waitdot1",0.50,0.15,1,0,1)
SH_AddAlphaAnimation(frame.anim,"Waitdot2",0.50,0.15,2,0,1)
SH_AddAlphaAnimation(frame.anim,"Waitdot3",0.50,0.15,3,0,1)
SH_AddAlphaAnimation(frame.anim,"Waitdot4",0.50,0.15,4,0,1)
SH_AddAlphaAnimation(frame.anim,"Waitdot5",0.50,0.15,5,0,1)
-- hide simultaneously
SH_AddAlphaAnimation(frame.anim,"Waitdot1",0.50,0.15,6,1,0)
SH_AddAlphaAnimation(frame.anim,"Waitdot2",0.50,0.15,6,1,0)
SH_AddAlphaAnimation(frame.anim,"Waitdot3",0.50,0.15,6,1,0)
SH_AddAlphaAnimation(frame.anim,"Waitdot4",0.50,0.15,6,1,0)
SH_AddAlphaAnimation(frame.anim,"Waitdot5",0.50,0.15,6,1,0)

frame:SetScript("OnShow",function(self)
	self.anim:Play()
end)

local oldeyefunc = QueueStatusMinimapButton:GetScript("OnShow")


local function StopHosting()
	hopAddon.var.hosting = false
	QueueStatusMinimapButton:SetScript("OnShow", oldeyefunc)
	frame.anim:Stop()
	hopAddon.minimap.objects["ServerHop"].anim:Stop()
	frame:Hide()
	hopAddon.hostFrame.buttonHost:Show()
	hopAddon.hostFrame.buttonHost:Enable()
	hopAddon.buttonNewEntry:Show()
	hopAddon.hostFrame.stringRealm:SetText(GetRealmName())
end

frame.buttonStop:SetScript("OnClick", function()
	StopHosting()
	C_LFGList.RemoveListing()
	SendAddonMessage(HOPADDON_PREFIX,"REMOVE_LISTING","RAID")
	if not IsInInstance() then
		LeaveParty()
	end
end)

local function buttonHostOnClick(self)
	hopAddon.buttonNewEntry:Hide()
	hopAddon.hopStatus:Hide()
	self:Hide()
	
	local id = UIDropDownMenu_GetSelectedID(hopAddon.hostFrame.sizeDrop)
	if id == 1 then
		if GetNumGroupMembers() > 5 then
			C_LFGList.RemoveListing()
			LeaveParty()
		else
			ConvertToParty()
			hopAddon.var.hostApp:SetName(hopAddon:GetMyZoneID())
			C_LFGList.UpdateListing(hopAddon.var.hostApp.activityID,hopAddon.var.hostApp.name,hopAddon.var.hostApp.iLevel,hopAddon.var.hostApp.honorLevel,hopAddon.var.hostApp.voiceChat,hopAddon.var.hostApp.comment,hopAddon.var.hostApp.autoAccept)				
		end
	elseif id == 2 then
		ConvertToRaid()
		hopAddon.var.hostApp:SetName(hopAddon:GetMyZoneID())
		C_LFGList.UpdateListing(hopAddon.var.hostApp.activityID,hopAddon.var.hostApp.name,hopAddon.var.hostApp.iLevel,hopAddon.var.hostApp.honorLevel,hopAddon.var.hostApp.voiceChat,hopAddon.var.hostApp.comment,hopAddon.var.hostApp.autoAccept)
	end

	frame:Show()
	hopAddon.minimap.objects["ServerHop"].anim:Play()
	-- disabling LFG eye
	oldeyefunc = QueueStatusMinimapButton:GetScript("OnShow")
	QueueStatusMinimapButton:SetScript("OnShow", function(self) self:Hide() end)
	
	hopAddon.var.hosting = true
	hopAddon.hostFrame.stringRealm:SetText(SERVERHOP_YOUREHOSTING)	
	lastUp = updateInterval
	PlaySound("igMainMenuOptionCheckBoxOn")		
end

hopAddon.hostFrame.buttonHost:SetScript("OnClick", buttonHostOnClick)

function hopAddon.var.hostApp:SetName(zoneID)
	local name = "[Server Hop] "..GetZoneText()

	while strlenutf8(name) > 31 do
		name = string.sub(name,1,string.len(name)-1)
	end
	hopAddon.var.hostApp.name = name

	-- 0 for unknown
	hopAddon.var.hostApp.comment = hopAddon.var.defaultComment .. "/SH/" .. zoneID .. "/" .. UIDropDownMenu_GetSelectedID(hopAddon.hostFrame.sizeDrop)

end

local function GroupHosting()
	if IsInInstance() or UnitOnTaxi("player") or hopAddon.var.currentZone == 1 then return end

	if not C_LFGList.GetActiveEntryInfo() then
		C_LFGList.CreateListing(hopAddon.var.hostApp.activityID,hopAddon.var.hostApp.name,hopAddon.var.hostApp.iLevel,hopAddon.var.hostApp.honorLevel,hopAddon.var.hostApp.voiceChat,hopAddon.var.hostApp.comment,hopAddon.var.hostApp.autoAccept)
	else
		C_LFGList.UpdateListing(hopAddon.var.hostApp.activityID,hopAddon.var.hostApp.name,hopAddon.var.hostApp.iLevel,hopAddon.var.hostApp.honorLevel,hopAddon.var.hostApp.voiceChat,hopAddon.var.hostApp.comment,hopAddon.var.hostApp.autoAccept)				
	end
	lastUp = 0
end

StaticPopupDialogs["HOST_A_GROUP_ZONE"] = {
	text = SERVERHOP_HOST_A_GROUP_ZONE,
	button1 = SERVERHOP_GROUPHOSTING,
	button2 = DECLINE,
	OnAccept = function(self, data)
		hopAddon.hostFrame.buttonHost:Click()
	end,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1,
	showAlert = 1
};

StaticPopupDialogs["HOST_A_GROUP_TIME"] = {
	text = SERVERHOP_HOST_A_GROUP_TIME,
	button1 = SERVERHOP_GROUPHOSTING,
	button2 = DECLINE,
	sound = "igPlayerInvite",
	OnAccept = function(self)
		hopAddon.hostFrame.buttonHost:Click()
	end,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1,
	showAlert = 1
}


local origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow

ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...
	if type(text) == "string" and text:match("sehopH") and not IsModifiedClick() then
		buttonHostOnClick(hopAddon.hostFrame.buttonHost)
	else
		return origChatFrame_OnHyperlinkShow(...)
	end
end

local function Hosting_OnZoneEvent(newZone)
	hopAddon.var.currentZone = newZone
	hopAddon.hopList:RecreateList()
	hopAddon.var.hostApp:SetName(hopAddon:GetMyZoneID())

	if hopAddon.var.hosting then
		local active, activityID, iLevel, honorLevel, name, comment, voiceChat, duration, autoAccept = C_LFGList.GetActiveEntryInfo();	
		if UnitIsGroupLeader("player") and hopAddon.var.currentZone == 1 then
			SendAddonMessage(HOPADDON_PREFIX,"NEW_ZONE","RAID")
			C_LFGList.RemoveListing()
			if not IsInInstance() then
				LeaveParty()
			end
		end
	else
		if hostOptions.showAlertsZone:GetChecked() and not(IsInGroup() or IsInRaid()) and hopAddon.var.currentZone ~= 1
		and (lastTimeSuggestedZone[hopAddon.var.currentZone] == nil or GetTime() - lastTimeSuggestedZone[hopAddon.var.currentZone] > 600) then
			if UIDropDownMenu_GetSelectedID(hopAddon.optionsFrame.hostOptionsFrame.hostAlertsDrop) == 3 then
				StaticPopup_Show("HOST_A_GROUP_ZONE")
				lastTimeSuggestedZone[hopAddon.var.currentZone] = GetTime()
			elseif UIDropDownMenu_GetSelectedID(hopAddon.optionsFrame.hostOptionsFrame.hostAlertsDrop) == 2 then
				hopAddon:Log(HOPADDON_HOSTMODE,SERVERHOP_HOST_A_GROUP_ZONE.." \124cff71d5ff\124HsehopH:123\124h["..SERVERHOP_GROUPHOSTING.."]\124h\124r\n")
				lastTimeSuggestedZone[hopAddon.var.currentZone] = GetTime()
			end
		end
	end
end

local function GroupCreationEvents(self, event, ...)

	if event == "LFG_LIST_ACTIVE_ENTRY_UPDATE" then
		if hopAddon.var.hosting then
			local active, activityID, iLevel, honorLevel, name, comment, voiceChat, duration, autoAccept = C_LFGList.GetActiveEntryInfo();	
			-- update autoinvite if we're hosting
			if active and not autoAccept then
				C_LFGList.UpdateListing(hopAddon.var.hostApp.activityID,hopAddon.var.hostApp.name,hopAddon.var.hostApp.iLevel,hopAddon.var.hostApp.honorLevel,hopAddon.var.hostApp.voiceChat,hopAddon.var.hostApp.comment,hopAddon.var.hostApp.autoAccept)			
			end
		end
	end

	-- check if we're in order hall
	if event == "UNIT_AURA" then
		if C_Garrison.IsPlayerInGarrison(LE_GARRISON_TYPE_7_0) or C_Garrison.IsPlayerInGarrison(LE_GARRISON_TYPE_6_0) then
			hopAddon.var.inOrderHall = true
			StaticPopup_Hide("HOST_A_GROUP_ZONE")
			StaticPopup_Hide("HOST_A_GROUP_TIME")
			Hosting_OnZoneEvent(1)
		elseif hopAddon.var.inOrderHall then
			hopAddon.var.inOrderHall = false
			Hosting_OnZoneEvent(hopAddon:GetMyZoneID())
		end
	end

	if event == "ZONE_CHANGED_NEW_AREA" or event == "ZONE_CHANGED" then
		local newZone = hopAddon:GetMyZoneID()

		if newZone == 1 then StaticPopup_Hide("HOST_A_GROUP_ZONE") StaticPopup_Hide("HOST_A_GROUP_TIME") end
		if newZone == hopAddon.var.currentZone then return end

		Hosting_OnZoneEvent(newZone)
	end

	if event == "CHAT_MSG_ADDON" then
		local prefix, message,channel,sender = ...
		
		local pname, realm = strsplit(_G.REALM_SEPARATORS, sender)
		if pname == GetUnitName("player") then return end
		
		if message == "NEW_ZONE" then
			--hopAddon:Log("Hosting","Host moved to a new zone. Group was delisted.")
		end
		if message == "CHANGED_LEADER" then
			--hopAddon:Log("Hosting","Host gave leadership to another person.")
			if C_LFGList.GetActiveEntryInfo() and UnitIsGroupLeader("player") then
				C_LFGList.RemoveListing()
				SendAddonMessage(HOPADDON_PREFIX,"REMOVE_LISTING","RAID")
			end
		end
		if message == "REMOVE_LISTING" then
			--hopAddon:Log("Hosting","Hosted group was removed.")
		end
	end
	
	if event == "GROUP_ROSTER_UPDATE" then
		-- if we're not a leader
		if (IsInGroup() or IsInRaid()) and not UnitIsGroupLeader("player") then
			-- if player was hosting and decided to give his leadership away - host no more
			if hopAddon.var.hosting then
				StopHosting()
				SendAddonMessage(HOPADDON_PREFIX,"CHANGED_LEADER","RAID")
			end

			-- block host button since you're in a group
			hopAddon.hostFrame.buttonHost:Disable()

		else
			hopAddon.hostFrame.buttonHost:Enable()
			lastTimeSolo = GetTime()
			-- reset it here, so when player leaves party on his own, he can react
			lastUp = 0
		end
		
		-- if we're a leader
		if UnitIsGroupLeader("player") then
			-- if I'm hosting, correct group info
			if hopAddon.var.hosting then
				if not IsInRaid() and UIDropDownMenu_GetSelectedID(hopAddon.hostFrame.sizeDrop) == 2 then
					ConvertToRaid()
					hopAddon.var.hostApp:SetName(hopAddon:GetMyZoneID())
					C_LFGList.UpdateListing(hopAddon.var.hostApp.activityID,hopAddon.var.hostApp.name,hopAddon.var.hostApp.iLevel,hopAddon.var.hostApp.honorLevel,hopAddon.var.hostApp.voiceChat,hopAddon.var.hostApp.comment,hopAddon.var.hostApp.autoAccept)
				end
				if IsInRaid() and UIDropDownMenu_GetSelectedID(hopAddon.hostFrame.sizeDrop) == 1 then
					ConvertToParty()
					hopAddon.var.hostApp:SetName(hopAddon:GetMyZoneID())
					C_LFGList.UpdateListing(hopAddon.var.hostApp.activityID,hopAddon.var.hostApp.name,hopAddon.var.hostApp.iLevel,hopAddon.var.hostApp.honorLevel,hopAddon.var.hostApp.voiceChat,hopAddon.var.hostApp.comment,hopAddon.var.hostApp.autoAccept)
				end
			-- if I'm not, we should remove hosted listing
			else
				-- check for an app
				local active, activityID, iLevel, honorLevel, name, comment, voiceChat, duration, autoAccept  = C_LFGList.GetActiveEntryInfo();	
				if active then
					local precomment,tag,zonetext,groupsize = strsplit("/",comment)
					-- check if it's a SH hosted app
					if precomment == hopAddon.var.defaultComment then
						C_LFGList.RemoveListing()
						SendAddonMessage(HOPADDON_PREFIX,"REMOVE_LISTING","RAID")
					end
				end
			end

		end
	end

	if event == "UNIT_CONNECTION" then
		local unitID,hasConnected = ...

		-- if just disconnected, put it on the list
		if not hasConnected then
			disconnectedList[unitID] = GetTime()
		-- if connected
		else
			-- if he's on the list, delete him from the list
			if disconnectedList[unitID] then
				local i = 0
				for k,v in pairs(disconnectedList) do
					i = i+1
					if unitID == k then
						table.remove(disconnectedList,i)
						break
					end
				end
			end
		end
	end
end

local function OnUpdate(self,elapsed)
	-- search updating should be counting all the time, resetting it on search results
	lastUp = lastUp + elapsed

	if lastUp > updateInterval then
		if hopAddon.var.hosting then
			-- lastup updates in grouphosting
			GroupHosting()
			-- also remove all disconnected players
			for k,v in pairs(disconnectedList) do
				if v and GetTime() - v > 120 then
					UninviteUnit(k)
					disconnectedList[k] = nil
				end
			end
		else
			if GetTime() - lastTimeSolo > 1200 then
				if hostOptions.showAlertsTime:GetChecked() and not(IsInGroup() or IsInRaid()) and hopAddon:GetMyZoneID() ~= 1 then
					if UIDropDownMenu_GetSelectedID(hopAddon.optionsFrame.hostOptionsFrame.hostAlertsDrop) == 3 then
						StaticPopup_Show("HOST_A_GROUP_TIME")
					elseif UIDropDownMenu_GetSelectedID(hopAddon.optionsFrame.hostOptionsFrame.hostAlertsDrop) == 2 then
						hopAddon:Log(HOPADDON_HOSTMODE,SERVERHOP_HOST_A_GROUP_TIME.." \124cff71d5ff\124HsehopH:123\124h["..SERVERHOP_GROUPHOSTING.."]\124h\124r\n")
					end
				end
				lastTimeSolo = GetTime()
			end	
		end

		lastUp = 0	
	end
end
local groupEventFrame = CreateFrame("Frame")
--groupEventFrame:SetScript("OnUpdate",OnUpdate)
--groupEventFrame:SetScript("OnEvent", GroupCreationEvents)
groupEventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
groupEventFrame:RegisterEvent("ZONE_CHANGED")
groupEventFrame:RegisterUnitEvent("UNIT_AURA","player")
groupEventFrame:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
groupEventFrame:RegisterEvent("CHAT_MSG_ADDON")
groupEventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
groupEventFrame:RegisterEvent("UNIT_CONNECTION")


-- HOOK LFGLIST FRAME SO IT WON'T ASK YOU TO CONVERT TO RAID ANYMORE
local origLFGListFrame_OnEvent = LFGListFrame_OnEvent

LFGListFrame_OnEvent = function(...)
	local self, event  = ...
	
	if (event == "LFG_LIST_APPLICANT_LIST_UPDATED") and hopAddon.var.hosting then
		self.stopAssistPings = true;
	end

	return origLFGListFrame_OnEvent(...)
end