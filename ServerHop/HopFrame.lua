-- MODULE FOR HOPPING FRAME --

-- Holder frame
hopAddon.hopFrame = CreateFrame("Frame",nil,hopAddon)
local hopFrame = hopAddon.hopFrame

HOPADDON_QUEUE_INTERVAL = 5
local SEARCH_INTERVAL = 2.5
-----------
hopFrame.firstTime = true
hopFrame.hopRequest = false
local BlackList = {} -- list of pairs {realm name = time last visited}
local HopList= {} -- sorted list of groups available for server hopping
local lastUpdate = 0 -- update timer
local lastServer = nil -- last server you've hopped to


local hopSearch = false -- should addon queue hopSearch
local queue = false -- should addon queue for groups
local backSearch = false -- start searching for a last server you've hopped on

local searchCategoryCount = 0 -- change category if addon can't find something new

hopAddon.hopFrame:SetSize(HOPADDON_WIDTH,HOPADDON_HEIGHT)
hopAddon.hopFrame:SetPoint("BOTTOM",0,0)
hopAddon.hopFrame.lastUpdate = 0
hopAddon.hopFrame.queueUpdate = 0
hopAddon.hopFrame:Hide()

hopAddon.hopFrame.background = hopAddon.hopFrame:CreateTexture(nil,"BORDER")
hopAddon.hopFrame.background:SetSize(HOPADDON_WIDTH+106,HOPADDON_HEIGHT-10)
hopAddon.hopFrame.background:SetPoint("BOTTOM",1,5)
hopAddon.hopFrame.background:SetTexture("Interface\\Challenges\\challenges-besttime-bg")

hopAddon.hopFrame.stringRealm = hopAddon.hopFrame:CreateFontString("realmname", "OVERLAY", "QuestFont_Shadow_Huge")
hopAddon.hopFrame.stringRealm:SetPoint("BOTTOM",0,72)
hopAddon.hopFrame.stringRealm:SetTextColor(1, 0.914, 0.682, 1)
hopAddon.hopFrame.stringRealm:SetText(GetRealmName())

-- list of options 
hopAddon.hopFrame.pvpDrop = CreateFrame("Frame", "hopFramepvpDrop", hopAddon.hopFrame, "UIDropDownMenuTemplate")
local pvpD = hopAddon.hopFrame.pvpDrop
pvpD:SetPoint("BOTTOMLEFT",0,35)
function hopAddon.hopFrame.pvpDrop_OnClick(self)
	UIDropDownMenu_SetSelectedID(pvpD, self:GetID())
end
-- list of options in droplist
hopAddon_serverTypeDropTable = {
	COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP,
	COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE,
	ALL
}
pvpD.initialize = function(self,level)
	if not level then return end
	local info = UIDropDownMenu_CreateInfo()
	for k,v in pairs(hopAddon_serverTypeDropTable) do
		info = UIDropDownMenu_CreateInfo()
		info.text = v
		info.value = v
		info.func = hopAddon.hopFrame.pvpDrop_OnClick
		UIDropDownMenu_AddButton(info,level)
	end
end
UIDropDownMenu_Initialize(pvpD, pvpD.initialize)
UIDropDownMenu_SetSelectedID(pvpD, 3)
UIDropDownMenu_SetText(pvpD,ALL)
UIDropDownMenu_SetWidth(pvpD,70)

-- Dropdown to select party size to hop in
hopAddon.hopFrame.dropDown = CreateFrame("Frame", "CountDrop", hopAddon.hopFrame, "UIDropDownMenuTemplate")
hopAddon.hopFrame.dropDown:SetPoint("BOTTOMRIGHT",0,35)
function hopAddon.hopFrame.dropDown_OnClick(self)
	UIDropDownMenu_SetSelectedID(hopAddon.hopFrame.dropDown, self:GetID())
end
-- list of options in droplist
local groupSizeList = {
	PARTY.." 1-4",
	RAID.." 6-40",
	HOPADDON_ANYSIZE
}
hopAddon.hopFrame.dropDown.initialize = function(self,level)
	if not level then return end
	local info = UIDropDownMenu_CreateInfo()
	for k,v in pairs(groupSizeList) do
		info = UIDropDownMenu_CreateInfo()
		info.text = v
		info.value = v
		info.func = hopAddon.hopFrame.dropDown_OnClick
		UIDropDownMenu_AddButton(info,level)
	end
end
UIDropDownMenu_Initialize(hopAddon.hopFrame.dropDown, hopAddon.hopFrame.dropDown.initialize)
UIDropDownMenu_SetSelectedID(hopAddon.hopFrame.dropDown, 3)
UIDropDownMenu_SetText(hopAddon.hopFrame.dropDown,HOPADDON_ANYSIZE)
UIDropDownMenu_SetWidth(hopAddon.hopFrame.dropDown,100)
UIDropDownMenu_SetAnchor(hopAddon.hopFrame.dropDown,0,10,"TOPRIGHT",hopAddon.hopFrame.dropDown,"BOTTOMRIGHT")

-- Button to reset blacklist

hopAddon.hopFrame.buttonResetBL = CreateFrame("Button","sh_clearblbut",hopAddon.hopFrame,"BrowserButtonTemplate")
hopAddon.hopFrame.buttonResetBL:SetSize(25,25)
hopAddon.hopFrame.buttonResetBL:SetPoint("BOTTOM",8,14)
hopAddon.hopFrame.buttonResetBL.Icon = hopAddon.hopFrame.buttonResetBL:CreateTexture("changemodebuttex","OVERLAY")
hopAddon.hopFrame.buttonResetBL.Icon:SetSize(14,12)
hopAddon.hopFrame.buttonResetBL.Icon:SetPoint("CENTER",0,0)
hopAddon.hopFrame.buttonResetBL.Icon:SetTexture("Interface\\Buttons\\UI-RefreshButton")

-- Button to hop to the next realm 
hopAddon.hopFrame.buttonHop = CreateFrame("Button",nil,hopAddon.hopFrame,"UIGoldBorderButtonTemplate")
hopAddon.hopFrame.buttonHop:SetSize(85,24)
hopAddon.hopFrame.buttonHop:SetPoint("BOTTOM",60,15)
hopAddon.hopFrame.buttonHop:SetText(SEARCH)
--[[ HOST GROUPS DIDN'T WORK
hopAddon.hopFrame.buttonHop:SetScript("OnEnter",function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
	GameTooltip:SetText(SERVERHOP_HOPNOWORK01)
	GameTooltip:AddLine(SERVERHOP_HOPNOWORK02,1,1,1,true)
	GameTooltip:Show()
end)
hopAddon.hopFrame.buttonHop:SetScript("OnLeave",function(self)
	GameTooltip:Hide()
end)
]]

--[[
hopAddon.hopFrame.buttonHop.spinner = CreateFrame("Frame",nil,hopAddon.hopFrame.buttonHop,"LoadingSpinnerTemplate")
hopAddon.hopFrame.buttonHop.spinner:SetSize(80,80)
hopAddon.hopFrame.buttonHop.spinner:SetPoint("CENTER", 0,0)
hopAddon.hopFrame.buttonHop.spinner.Anim:Play()
]]

-- Button to hop to the last blacklisted realm
--[[hopAddon.hopFrame.buttonHopBack = CreateFrame("Button",nil,hopAddon.hopFrame,"UIGoldBorderButtonTemplate")
hopAddon.hopFrame.buttonHopBack:SetSize(100,24)
hopAddon.hopFrame.buttonHopBack:SetPoint("BOTTOM",-55,15)
hopAddon.hopFrame.buttonHopBack:SetText(HOPADDON_LASTBUTTON)
hopAddon.hopFrame.buttonHopBack:Disable()
]]


hopAddon.hopFrame.description = CreateFrame("EditBox", nil, hopAddon.hopFrame, "LFGListEditBoxTemplate")
hopAddon.hopFrame.description:SetPoint("BOTTOM",-55,15)
hopAddon.hopFrame.description:SetSize(100,24)
hopAddon.hopFrame.description:SetMaxLetters(255)
hopAddon.hopFrame.description.Instructions:SetText(LFG_LIST_DETAILS)


-- rewriting hyperlink function to react on serverhop links
local origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow

ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...
	if type(text) == "string" and text:match("sehopS") and not IsModifiedClick() then
		SH_ShowServerChatInfo(text)
	else
		return origChatFrame_OnHyperlinkShow(...)
	end
end

function SH_ShowServerChatInfo(text)
	local _,grname,grdesc,_ = strsplit("*",text)
	local realmName = string.match(text,'%[(.+)%]')
	
	ShowUIPanel(ItemRefTooltip)
	if (not ItemRefTooltip:IsVisible()) then
		ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
	end
	ItemRefTooltip:ClearLines()
	ItemRefTooltip:AddLine("\124cff71d5ff"..realmName.."\124r",1,1,1,1)
	ItemRefTooltip:AddLine(" ",1,1,1,1)
	ItemRefTooltip:AddLine("\124cff"..grname.."\124r",1,1,1,1)
	if grdesc ~= "" then
		ItemRefTooltip:AddLine(grdesc,1,1,1,1)
	end
	ItemRefTooltip:Show()
end



-- MAIN FUNCTIONS --



 function PlayerRealm(fullname)
    fullname = fullname or "???-???"
    local name, realm = strsplit(_G.REALM_SEPARATORS, fullname)
    realm = realm or GetRealmName();
    return realm;
end

local function ClearBlackList()
	BlackList = {}
	hopAddon.optionsFrame.hopSearchOptionsFrame.blacklistString:SetText(HOPADDON_INBLACKLIST.." |cFFFFFFFF0|r")

end

function LeaveAndBlackList()
	local index = GetNumGroupMembers()
	local name, server
	local fullname
	
	if IsInRaid() then
		for i=1,index do
			if UnitIsGroupLeader("raid"..i) then
				fullname = GetUnitName("raid"..i,true)
				name,server = UnitName("raid"..i)
				-- why the hell does it return server as "" on other people, but on you returns nil???
				if server == "" or server == nil then
					server = GetRealmName()
				end
				BlackList[server]=GetTime()
				break
			end
		end
	else
		for i=1,4 do
			if UnitIsGroupLeader("party"..i) then
				fullname = GetUnitName("party"..i,true)
				name,server = UnitName("party"..i)
				if server == "" then
					server = GetRealmName()
				end
				BlackList[server]=GetTime()
				break
			end
		end
	end
	
	if server ~= GetRealmName() then
		lastServer = server
	end

	local blackCount = 0
	for k,v in pairs(BlackList) do
		if GetTime()-v < hopAddon.optionsFrame.hopSearchOptionsFrame.sliderBLTime:GetValue() then
			blackCount = blackCount + 1
		end
	end
	hopAddon.optionsFrame.hopSearchOptionsFrame.blacklistString:SetText(HOPADDON_INBLACKLIST.." |cFFFFFFFF"..blackCount.."|r")
	
	if IsShiftKeyDown() then
		table.insert(hopAddon.tables.LeadersBL,fullname)
	end
	
	LeaveParty()
	hopFrame.buttonHop:SetText(HOPADDON_HOPPING)
end

local function FilterHopSearchGroups()
	HopList = {}
	local count, slist = C_LFGList.GetSearchResults()
	if count > HOPADDON_MAX_RESULTS then count = HOPADDON_MAX_RESULTS end
	
	-- SORT BY ZONE
	list = {}
	for i=1,#slist do
		local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(slist[i])
		
		if activityID == hopAddon:GetMyZoneID() or string.find(name,GetZoneText()) or string.find(comment,GetZoneText()) or string.find(comment,hopAddon:GetMyZoneID()) then
			table.insert(list,id)
		end
	end

	table.sort(list,function(id1,id2)
		local pcount1 = select(14,C_LFGList.GetSearchResultInfo(id1))
		local pcount2 = select(14,C_LFGList.GetSearchResultInfo(id2))
		return pcount1 < pcount2
	end)

--	print(#list.." groups found.")
	if (backSearch) then
		for i = 1,#list do
			local id, _, _, _, _, _, _, _, _, _, _, _, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(list[i])
			local realm = PlayerRealm(leaderName)

			if leaderName ~= nil and lastServer == realm then
				if UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 1 then
					if numMembers < 5 then
						table.insert(HopList, id)
					end
				elseif UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 2 then
					if numMembers >= 6 and numMembers < 40 then
						table.insert(HopList, id)
					end
				else
					table.insert(HopList, id)
				end				
			end
		end			
	else
	-- forward search
		local unfiltered = {}
		
		-- Adding all available groups that don't match blacklist
		for i = 1,#list do
			local id, _, _, comment, _, _, _, _, _, _, _, _, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(list[i])
			local realm = PlayerRealm(leaderName)
			
			local leaderClear = true
			for i=1,#hopAddon.tables.LeadersBL do
				if leaderName == hopAddon.tables.LeadersBL[i] then
					leaderClear = false
					break
				end
			end			
			
			if leaderName ~= nil and realm ~= GetRealmName() and leaderClear
			and (BlackList[realm] == nil or (GetTime()-BlackList[realm] > hopAddon.optionsFrame.hopSearchOptionsFrame.sliderBLTime:GetValue())) 
			and numMembers ~= 5 and numMembers ~= 40 then
				if (UIDropDownMenu_GetSelectedID(pvpD) == 1 and hopAddon.var.pvpList[realm] == true) or
				(UIDropDownMenu_GetSelectedID(pvpD) == 2 and hopAddon.var.pvpList[realm] == nil) or
				(UIDropDownMenu_GetSelectedID(pvpD) == 3) then
					if hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:GetChecked() then
						-- if putting all groups filter autoivite on top
						if UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 1 then
							if numMembers < 5 then
								unfiltered[id] = autoinv
							end
						elseif UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 2 then
							if numMembers >= 6 and numMembers < 40 then
								unfiltered[id] = autoinv
							end
						else
							unfiltered[id] = autoinv
						end
					elseif autoinv then
						-- if putting only autoinvite then don't need to sort
						if UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 1 then
							if numMembers < 5 then
								table.insert(HopList,id)
							end
						elseif UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 2 then
							if numMembers >= 6 and numMembers < 40 then
								table.insert(HopList,id)
							end
						else
							table.insert(HopList,id)
						end
					end
					--print("Игрок: "..fullname.." Сервер: "..realm)
				end
			end		
		end
		
		
		if hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:GetChecked() then
			-- checking unfiltered for autoinvite, putting them on top first
			for id,auto in pairs(unfiltered) do
				if auto then table.insert(HopList,id) end
			end
			-- then putting simple invites
			for id,auto in pairs(unfiltered) do
				if not auto then table.insert(HopList,id) end
			end
		end
	end
	-- queue if found any
	if #HopList > 0 then
		hopAddon.hopFrame.queueUpdate = HOPADDON_QUEUE_INTERVAL
		searchCategoryCount = 0
		hopFrame.buttonHop:SetText(HOPADDON_HOPPING)
	else -- search more if couldn't find any
		hopAddon.hopFrame.buttonHop:SetText(SEARCH)
	end
end

local function buttonHop_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, -40);

	if #HopList > 0 then
		local resultID = HopList[1]
		local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(resultID)
		local fullName, shortName, categoryID, groupID, iLevel, filters, minLevel, maxPlayers, displayType, orderIndex, useHonorLevel = C_LFGList.GetActivityInfo(activityID);
		local memberCounts = C_LFGList.GetSearchResultMemberCounts(resultID);
		GameTooltip:SetText(name);	
		GameTooltip:AddLine(fullName,1,1,1);
		if autoinv then
			GameTooltip:AddLine(HOPADDON_AUTOINVITE, 0.25, 0.75, 0.25, true)
		end	
		if ( comment ~= "" ) then
			GameTooltip:AddLine(string.format(LFG_LIST_COMMENT_FORMAT, comment), LFG_LIST_COMMENT_FONT_COLOR.r, LFG_LIST_COMMENT_FONT_COLOR.g, LFG_LIST_COMMENT_FONT_COLOR.b, true);
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
	else
		GameTooltip:SetText(SEARCH)
	end

	GameTooltip:Show();
end

hopAddon.hopFrame.buttonHop:SetScript("OnEnter", buttonHop_OnEnter)
hopAddon.hopFrame.buttonHop:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local function FullScaleSearch(selection, str, filter1, filter2)
	--print("Called search")
	local lang={}
	for k,v in pairs(C_LFGList.GetAvailableLanguageSearchFilter()) do lang[v]=true end
	C_LFGList.Search(selection, str, filter1, filter2, lang)
end

function SH_RefreshResults()
	HopList = {}
	local category = 1
	if searchCategoryCount == 2 then
		category = 6
		searchCategoryCount = 0
	else
		searchCategoryCount = searchCategoryCount + 1
	end
	FullScaleSearch(category,"",0,0)
end

local function SH_HopAction()
	local summ = 0

	local apps = C_LFGList.GetApplications()
	for i=1,#apps do
		local id, appStatus, pendingStatus,appDuration = C_LFGList.GetApplicationInfo(apps[i]);
		local duration = 0;
		if appDuration and appDuration > 0 then
			duration = appDuration;
		end
		if appStatus == "applied" or pendingStatus == "applied" then
			if duration < 290 then
				C_LFGList.CancelApplication(apps[i])
				return
			end
			summ = summ + 1
		elseif pendingStatus == "invited" or appStatus == "invited" then
			summ = summ + 1
		end
	end
	
	if summ == 5 then return end

	local tank, heal, dd = C_LFGList.GetAvailableRoles()
	C_LFGList.ApplyToGroup(HopList[1], "", tank, heal, dd)
	table.remove(HopList,1)
end

-- hop forward button
function ServerHop_HopForward()
	if #HopList < 5 then
		SH_RefreshResults()
	elseif IsInGroup() or IsInRaid() then
		LeaveAndBlackList()
	else
		SH_HopAction()
	end
end

hopAddon.hopFrame.buttonHop:SetScript("OnClick", function(btn)
	ServerHop_HopForward()
	buttonHop_OnEnter(btn)
end)




--[[function ServerHop_HopBack()
	if lastServer ~= nil then
		hopFrame.buttonHop:Disable()
		hopFrame.buttonHopBack:Disable()
		hopFrame.buttonHop:SetText(HOPADDON_HOPPING)

		LeaveParty()
		
		hopFrame.hopRequest = true
		backSearch = true
		
		-- make sure to get a search from category 6
		if hopFrame.firstTime then
			hopFrame.lastUpdate = SEARCH_INTERVAL
			hopAddon.hopFrame.buttonHop:SetText(HOPADDON_SEARCHING)
			hopSearch = true
		else
			FilterHopSearchGroups()
		end
	end
end

hopAddon.hopFrame.buttonHopBack:SetScript("OnClick", function(btn)
	ServerHop_HopBack()
end)
]]

hopAddon.hopFrame.buttonResetBL:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, 0)
	GameTooltip:SetText(HOPADDON_CLEARBL, 1, 1, 1, true)
	
	local i = 0
	for k,v in pairs(BlackList) do
		if GetTime()-v < hopAddon.optionsFrame.hopSearchOptionsFrame.sliderBLTime:GetValue() then
			if i < 5 then
				GameTooltip:AddLine(k)
			end
			i = i+1
		end
	end
	
	if i>5 then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(string.format(HOPADDON_MORE_IN_BL,(i-5)));	
	end
	
	GameTooltip:Show()

end)
hopAddon.hopFrame.buttonResetBL:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)
StaticPopupDialogs["HOPADDON_CLEARBL_DIAG"] = {
  text = HOPADDON_CLEARBL_QUESTION,
  button1 = YES,
  button2 = NO,
  OnAccept = function()
      ClearBlackList()
  end,
  sound = "levelup2",
  whileDead = true,
  hideOnEscape = true,
}

hopAddon.hopFrame.buttonResetBL:SetScript("OnClick", function(self,btn)
	StaticPopup_Show("HOPADDON_CLEARBL_DIAG")
end)


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

	local i=#HopList
	while i > 0 do		
		if FoundInDelisted(HopList[i]) then
			table.remove(HopList,i)
			removed = true
		end
		i = i - 1
	end

	if removed then FilterHopSearchGroups() end
end

local function HopFrame_EventSystem(self, event, ...)
	local arg1 = ...

	if event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" then
		-- even if user refreshed this list without addon, we should remember the time
		FilterHopSearchGroups()
	end
	
	if event == "LFG_LIST_SEARCH_RESULT_UPDATED" then
		if #HopList > 0 then
			RemoveDelisted()
		end
	end

	if event == "GROUP_ROSTER_UPDATE" then
	-- Checking Server Name
		local index = GetNumGroupMembers()
		local name = nil
		local server = nil
		
		if IsInRaid() then
			for i=1,index do
				if UnitIsGroupLeader("raid"..i) then
					name,server = UnitName("raid"..i)
					break
				end
			end
		elseif IsInGroup() then
			for i=1,4 do
				if UnitIsGroupLeader("party"..i) then
					name,server = UnitName("party"..i)
					break
				end
			end
		end
		
		if server == nil or server == "" then
			server = GetRealmName()
		end
		hopAddon.hopFrame.stringRealm:SetText(server)
	
	end
	if event == "LFG_LIST_JOINED_GROUP" then
		-- finish search here if it was done by other non serverhop means
		-- send chat notification about hopping
		if (hopAddon.optionsFrame.globalOptionsFrame.chatNotifButton:GetChecked()) then

			local id, _, name, comment, _, _, _, _, _, _, _, _, leaderName, _, autoinv = C_LFGList.GetSearchResultInfo(arg1)
			local realm = PlayerRealm(leaderName)
			local ncolor = "ffd517"
			if autoinv then ncolor = "3caa3c" end
			print("[Server Hop] ["..TRANSFER.."]: \124cff71d5ff\124HsehopS:*"..ncolor..name.."*"..comment.."*\124h["..realm.."]\124h\124r.");
		end

		hopFrame.buttonHop:SetText(PARTY_LEAVE)
	end


end

hopAddon.hopFrame:SetScript("OnEvent", HopFrame_EventSystem)
hopAddon.hopFrame:RegisterEvent("LFG_LIST_SEARCH_FAILED")
hopAddon.hopFrame:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
hopAddon.hopFrame:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
hopAddon.hopFrame:RegisterEvent("LFG_LIST_JOINED_GROUP")
hopAddon.hopFrame:RegisterEvent("GROUP_ROSTER_UPDATE")

local hoppingEventFrame = CreateFrame("Frame")
hoppingEventFrame:SetScript("OnUpdate",OnUpdate)

hopAddon.optionsFrame.hopSearchOptionsFrame.buttonClearBL:SetScript("OnClick", function(btn)
	ClearBlackList()
end)