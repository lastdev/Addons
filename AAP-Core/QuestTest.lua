AAP.Test = {}
local MainQuest = 0
local SubQuestId = 0
local SubQuestName = 0
local ScrollMod = 0
local MapIconOrder = {}
local MapIconUpdateStep = 0
local MapRects = {};
local TempVec2D = CreateVector2D(0,0);
local function GetPlayerMapPos(MapID, dx, dy)
    local R,P,_ = MapRects[MapID],TempVec2D;
    if not R then
        R = {};
        _, R[1] = C_Map.GetWorldPosFromMapPos(MapID,CreateVector2D(0,0));
        _, R[2] = C_Map.GetWorldPosFromMapPos(MapID,CreateVector2D(1,1));
        R[2]:Subtract(R[1]);
        MapRects[MapID] = R;
    end
	if (dx) then
		P.x, P.y = dx, dy
	else
		P.x, P.y = UnitPosition('Player');
	end
    P:Subtract(R[1]);
    return (1/R[2].y)*P.y, (1/R[2].x)*P.x;
end
function AAP.Testa()
	AAPHFiller2 = nil
	AAPHFiller2 = {}
	AAPHFiller2["LeaveQuests"] = {}
	AAPHFiller2["LeaveQuests"]["LeaveQuests"] = {}
	AAPHFiller2["LeaveQuests"]["LeaveQuests"]["LeaveQuests"] = {}
	for AAP_index,AAP_value in pairs(AAP.QuestStepList["A198-80-93"]) do
		if (AAP.QuestStepList["A198-80-93"][AAP_index] and AAP.QuestStepList["A198-80-93"][AAP_index]["PickUp"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepList["A198-80-93"][AAP_index]["PickUp"]) do
				tinsert(AAPHFiller2["LeaveQuests"]["LeaveQuests"]["LeaveQuests"], AAP_value2)
			end
		end
	end
	for AAP_index,AAP_value in pairs(AAP.QuestStepList["A371-80-93"]) do
		if (AAP.QuestStepList["A371-80-93"][AAP_index] and AAP.QuestStepList["A371-80-93"][AAP_index]["PickUp"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepList["A371-80-93"][AAP_index]["PickUp"]) do
				tinsert(AAPHFiller2["LeaveQuests"]["LeaveQuests"]["LeaveQuests"], AAP_value2)
			end
		end
	end
	for AAP_index,AAP_value in pairs(AAP.QuestStepList["A379-80-93"]) do
		if (AAP.QuestStepList["A379-80-93"][AAP_index] and AAP.QuestStepList["A379-80-93"][AAP_index]["PickUp"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepList["A379-80-93"][AAP_index]["PickUp"]) do
				tinsert(AAPHFiller2["LeaveQuests"]["LeaveQuests"]["LeaveQuests"], AAP_value2)
			end
		end
	end
	for AAP_index,AAP_value in pairs(AAP.QuestStepList["A388-80-93"]) do
		if (AAP.QuestStepList["A388-80-93"][AAP_index] and AAP.QuestStepList["A388-80-93"][AAP_index]["PickUp"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepList["A388-80-93"][AAP_index]["PickUp"]) do
				tinsert(AAPHFiller2["LeaveQuests"]["LeaveQuests"]["LeaveQuests"], AAP_value2)
			end
		end
	end
end
function AAP.ZoneQuestOrderList()
	if (AAP1["Debug"]) then
		print("Function: AAP.ZoneQuestOrderList()")
	end
	AAP.ZoneQuestOrder = CreateFrame("frame", "AAPQOrderList", UIParent)
	AAP.ZoneQuestOrder:SetWidth(231)
	AAP.ZoneQuestOrder:SetHeight(440)
	AAP.ZoneQuestOrder:SetPoint("CENTER", UIParent, "CENTER",0,0)
	AAP.ZoneQuestOrder:SetMovable(true)
	AAP.ZoneQuestOrder:EnableMouse(true)
	
	AAP.ZoneQuestOrder.ZoneName = CreateFrame("frame", "AAP_ZoneQuestOrder_ZoneName", AAP.ZoneQuestOrder)
	AAP.ZoneQuestOrder.ZoneName:SetWidth(100)
	AAP.ZoneQuestOrder.ZoneName:SetHeight(16)
	AAP.ZoneQuestOrder.ZoneName:SetPoint("BOTTOM", AAP.ZoneQuestOrder, "TOP",0,0)
	--AAP.ZoneQuestOrder.ZoneName:SetBackdrop( { 
	--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
	--});
local t = AAP.ZoneQuestOrder.ZoneName:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.ZoneQuestOrder.ZoneName)
AAP.ZoneQuestOrder.ZoneName.texture = t

	AAP.ZoneQuestOrder.ZoneName:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			AAP.ZoneQuestOrder:StartMoving();
			AAP.ZoneQuestOrder.isMoving = true;
		end
	end)
	AAP.ZoneQuestOrder.ZoneName:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			AAP.ZoneQuestOrder:StopMovingOrSizing();
			AAP.ZoneQuestOrder.isMoving = false;
		end
	end)
	AAP.ZoneQuestOrder.ZoneName:SetScript("OnHide", function(self)
		if ( AAP.ZoneQuestOrder.isMoving ) then
			AAP.ZoneQuestOrder:StopMovingOrSizing();
			AAP.ZoneQuestOrder.isMoving = false;
		end
	end)
	AAP.ZoneQuestOrder.ZoneName.FS = AAP.ZoneQuestOrder.ZoneName:CreateFontString("AAP_ZoneOrder_lvl60_next1_FS","ARTWORK", "ChatFontNormal")
	AAP.ZoneQuestOrder.ZoneName.FS:SetParent(AAP.ZoneQuestOrder.ZoneName)
	AAP.ZoneQuestOrder.ZoneName.FS:SetPoint("CENTER",AAP.ZoneQuestOrder.ZoneName,"CENTER",1,0)
	AAP.ZoneQuestOrder.ZoneName.FS:SetWidth(100)
	AAP.ZoneQuestOrder.ZoneName.FS:SetHeight(16)
	AAP.ZoneQuestOrder.ZoneName.FS:SetJustifyH("CENTER")
	AAP.ZoneQuestOrder.ZoneName.FS:SetFontObject("GameFontNormalSmall")
	AAP.ZoneQuestOrder.ZoneName.FS:SetText("Zone")
	AAP.ZoneQuestOrder.ZoneName.FS:SetTextColor(1, 1, 0)
		
	AAP.ZoneQuestOrder["AAP_Button"] = CreateFrame("Button", "AAP_SBXOZ", AAP.ZoneQuestOrder, AAP.ZoneQuestOrder)
	AAP.ZoneQuestOrder["AAP_Button"]:SetWidth(15)
	AAP.ZoneQuestOrder["AAP_Button"]:SetHeight(15)
	AAP.ZoneQuestOrder["AAP_Button"]:SetText("X")
	AAP.ZoneQuestOrder["AAP_Button"]:SetFrameStrata("MEDIUM")
	AAP.ZoneQuestOrder["AAP_Button"]:SetPoint("TOPRIGHT",AAP.ZoneQuestOrder,"TOPRIGHT",5,5)
	AAP.ZoneQuestOrder["AAP_Button"]:SetNormalFontObject("GameFontNormalLarge")
	AAP.ZoneQuestOrder["AAP_Buttonntex"] = AAP.ZoneQuestOrder["AAP_Button"]:CreateTexture()
	AAP.ZoneQuestOrder["AAP_Buttonntex"]:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	AAP.ZoneQuestOrder["AAP_Buttonntex"]:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.ZoneQuestOrder["AAP_Buttonntex"]:SetAllPoints()	
	AAP.ZoneQuestOrder["AAP_Button"]:SetNormalTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	AAP.ZoneQuestOrder["AAP_Buttonhtex"] = AAP.ZoneQuestOrder["AAP_Button"]:CreateTexture()
	AAP.ZoneQuestOrder["AAP_Buttonhtex"]:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	AAP.ZoneQuestOrder["AAP_Buttonhtex"]:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.ZoneQuestOrder["AAP_Buttonhtex"]:SetAllPoints()
	AAP.ZoneQuestOrder["AAP_Button"]:SetHighlightTexture(AAP.ZoneQuestOrder["AAP_Buttonhtex"])
	AAP.ZoneQuestOrder["AAP_Buttonptex"] = AAP.ZoneQuestOrder["AAP_Button"]:CreateTexture()
	AAP.ZoneQuestOrder["AAP_Buttonptex"]:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	AAP.ZoneQuestOrder["AAP_Buttonptex"]:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.ZoneQuestOrder["AAP_Buttonptex"]:SetAllPoints()
	AAP.ZoneQuestOrder["AAP_Button"]:SetPushedTexture(AAP.ZoneQuestOrder["AAP_Buttonptex"])
	AAP.ZoneQuestOrder["AAP_Button"]:SetScript("OnClick", function(self, arg1)
		AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQuestListOrder"] = 0
		AAP.ZoneQuestOrder:Hide()
		AAP.OptionsFrame.QorderListzCheckButton:SetChecked(false)
	end)
	--AAP.ZoneQuestOrder:SetBackdrop( { 
	--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
	--});
local t = AAP.ZoneQuestOrder:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.ZoneQuestOrder)
AAP.ZoneQuestOrder.texture = t

	AAP.ZoneQuestOrder:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			AAP.ZoneQuestOrder:StartMoving();
			AAP.ZoneQuestOrder.isMoving = true;
		end
	end)
	AAP.ZoneQuestOrder:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			AAP.ZoneQuestOrder:StopMovingOrSizing();
			AAP.ZoneQuestOrder.isMoving = false;
		end
	end)
	AAP.ZoneQuestOrder:SetScript("OnHide", function(self)
		if ( AAP.ZoneQuestOrder.isMoving ) then
			AAP.ZoneQuestOrder:StopMovingOrSizing();
			AAP.ZoneQuestOrder.isMoving = false;
		end
	end)
	AAP.ZoneQuestOrder:SetScript("OnMouseWheel", function(self, arg1)
		if (arg1 == 1) then
			if (ScrollMod ~= 0) then
			ScrollMod = ScrollMod - 1
			AAP.UpdateZoneQuestOrderList(ScrollMod)
			end
		else
			ScrollMod = ScrollMod + 1
			AAP.UpdateZoneQuestOrderList(ScrollMod)
		end
	end)
	AAP.ZoneQuestOrder["Current"] = CreateFrame("frame", "AAP_ZoneQuestOrderCurrent", AAP.ZoneQuestOrder)
	AAP.ZoneQuestOrder["Current"]:SetWidth(25)
	AAP.ZoneQuestOrder["Current"]:SetHeight(16)
	AAP.ZoneQuestOrder["Current"]:SetPoint("RIGHT", AAP.ZoneQuestOrder, "LEFT",0,0)
	--AAP.ZoneQuestOrder["Current"]:SetBackdrop( { 
	--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
	--});
local t = AAP.ZoneQuestOrder["Current"]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.ZoneQuestOrder["Current"])
AAP.ZoneQuestOrder["Current"].texture = t

	AAP.ZoneQuestOrder["Current"]["FS"] = AAP.ZoneQuestOrder["Current"]:CreateFontString("AAPZoneQuestOrderFSCurrent","ARTWORK", "ChatFontNormal")
	AAP.ZoneQuestOrder["Current"]["FS"]:SetParent(AAP.ZoneQuestOrder["Current"])
	AAP.ZoneQuestOrder["Current"]["FS"]:SetPoint("CENTER",AAP.ZoneQuestOrder["Current"],"CENTER",1,0)
	AAP.ZoneQuestOrder["Current"]["FS"]:SetWidth(25)
	AAP.ZoneQuestOrder["Current"]["FS"]:SetHeight(16)
	AAP.ZoneQuestOrder["Current"]["FS"]:SetJustifyH("CENTER")
	AAP.ZoneQuestOrder["Current"]["FS"]:SetFontObject("GameFontNormalSmall")
	AAP.ZoneQuestOrder["Current"]["FS"]:SetText(">>>")
	AAP.ZoneQuestOrder["Current"]["FS"]:SetTextColor(1, 1, 0)
	AAP.ZoneQuestOrder["Current"]:Hide()
	AAP.ZoneQuestOrder["FS"] = {}
	AAP.ZoneQuestOrder["FS2"] = {}
	AAP.ZoneQuestOrder["Order1"] = {}
	AAP.ZoneQuestOrder["Order1iD"] = {}
	AAP.ZoneQuestOrder["Order1iDFS"] = {}
	AAP.ZoneQuestOrder["OrderName"] = {}
	AAP.ZoneQuestOrder["OrderNameFS"] = {}
end
function AAP.AddQuestOrderFrame(CLi)
		CLPos = CLi * 16
		AAP.ZoneQuestOrder[CLi] = CreateFrame("frame", "AAP_ZoneQuestOrder"..CLi, AAP.ZoneQuestOrder)
		AAP.ZoneQuestOrder[CLi]:SetWidth(25)
		AAP.ZoneQuestOrder[CLi]:SetHeight(16)
		AAP.ZoneQuestOrder[CLi]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",5,-((CLPos)-11))
		--AAP.ZoneQuestOrder[CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.ZoneQuestOrder[CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.ZoneQuestOrder[CLi])
AAP.ZoneQuestOrder[CLi].texture = t

		AAP.ZoneQuestOrder[CLi]:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				AAP.ZoneQuestOrder:StartMoving();
				AAP.ZoneQuestOrder.isMoving = true;
			end
		end)
		AAP.ZoneQuestOrder[CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" then
				AAP.ZoneQuestOrder:StopMovingOrSizing();
				AAP.ZoneQuestOrder.isMoving = false;
			end
		end)
		AAP.ZoneQuestOrder[CLi]:SetScript("OnHide", function(self)
			if ( AAP.ZoneQuestOrder.isMoving ) then
				AAP.ZoneQuestOrder:StopMovingOrSizing();
				AAP.ZoneQuestOrder.isMoving = false;
			end
		end)
		AAP.ZoneQuestOrder[CLi]:SetScript("OnMouseWheel", function(self, arg1)
			if (arg1 == 1) then
				if (ScrollMod ~= 0) then
					ScrollMod = ScrollMod - 1
					AAP.UpdateZoneQuestOrderList(ScrollMod)
				end
			else
				ScrollMod = ScrollMod + 1
				AAP.UpdateZoneQuestOrderList(ScrollMod)
			end
		end)
		AAP.ZoneQuestOrder["FS"][CLi] = AAP.ZoneQuestOrder[CLi]:CreateFontString("AAPZoneQuestOrderFS"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.ZoneQuestOrder["FS"][CLi]:SetParent(AAP.ZoneQuestOrder[CLi])
		AAP.ZoneQuestOrder["FS"][CLi]:SetPoint("CENTER",AAP.ZoneQuestOrder[CLi],"CENTER",1,0)
		AAP.ZoneQuestOrder["FS"][CLi]:SetWidth(25)
		AAP.ZoneQuestOrder["FS"][CLi]:SetHeight(16)
		AAP.ZoneQuestOrder["FS"][CLi]:SetJustifyH("CENTER")
		AAP.ZoneQuestOrder["FS"][CLi]:SetFontObject("GameFontNormalSmall")
		AAP.ZoneQuestOrder["FS"][CLi]:SetText(CLi)
		AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 1, 0)

		
		AAP.ZoneQuestOrder["Order1"][CLi] = CreateFrame("frame", "AAP_ZoneQuestOrder2A"..CLi, AAP.ZoneQuestOrder)
		AAP.ZoneQuestOrder["Order1"][CLi]:SetWidth(100)
		AAP.ZoneQuestOrder["Order1"][CLi]:SetHeight(16)
		AAP.ZoneQuestOrder["Order1"][CLi]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",32,-((CLPos)-11))
		--AAP.ZoneQuestOrder["Order1"][CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.ZoneQuestOrder["Order1"][CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.ZoneQuestOrder["Order1"][CLi])
AAP.ZoneQuestOrder["Order1"][CLi].texture = t

		AAP.ZoneQuestOrder["Order1"][CLi]:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				AAP.ZoneQuestOrder:StartMoving();
				AAP.ZoneQuestOrder.isMoving = true;
			end
		end)
		AAP.ZoneQuestOrder["Order1"][CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" then
				AAP.ZoneQuestOrder:StopMovingOrSizing();
				AAP.ZoneQuestOrder.isMoving = false;
			end
		end)
		AAP.ZoneQuestOrder["Order1"][CLi]:SetScript("OnHide", function(self)
			if ( AAP.ZoneQuestOrder.isMoving ) then
				AAP.ZoneQuestOrder:StopMovingOrSizing();
				AAP.ZoneQuestOrder.isMoving = false;
			end
		end)
		AAP.ZoneQuestOrder["Order1"][CLi]:SetScript("OnMouseWheel", function(self, arg1)
			if (arg1 == 1) then
				if (ScrollMod ~= 0) then
					ScrollMod = ScrollMod - 1
					AAP.UpdateZoneQuestOrderList(ScrollMod)
				end
			else
				ScrollMod = ScrollMod + 1
				AAP.UpdateZoneQuestOrderList(ScrollMod)
			end
		end)
		AAP.ZoneQuestOrder["FS2"][CLi] = AAP.ZoneQuestOrder["Order1"][CLi]:CreateFontString("AAPZoneQuestOrderFS2A"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.ZoneQuestOrder["FS2"][CLi]:SetParent(AAP.ZoneQuestOrder["Order1"][CLi])
		AAP.ZoneQuestOrder["FS2"][CLi]:SetPoint("LEFT",AAP.ZoneQuestOrder["Order1"][CLi],"LEFT",5,0)
		AAP.ZoneQuestOrder["FS2"][CLi]:SetWidth(150)
		AAP.ZoneQuestOrder["FS2"][CLi]:SetHeight(16)
		AAP.ZoneQuestOrder["FS2"][CLi]:SetJustifyH("LEFT")
		AAP.ZoneQuestOrder["FS2"][CLi]:SetFontObject("GameFontNormalSmall")
		AAP.ZoneQuestOrder["FS2"][CLi]:SetText("")
		AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 1, 0)
end
function AAP.AddQuestIdFrame(CLi)
		CLPos = CLi * 16 + 16
	
		AAP.ZoneQuestOrder["Order1iD"][CLi] = CreateFrame("frame", "AAP_ZoneQuestOrder2AID"..CLi, AAP.ZoneQuestOrder)
		AAP.ZoneQuestOrder["Order1iD"][CLi]:SetWidth(50)
		AAP.ZoneQuestOrder["Order1iD"][CLi]:SetHeight(16)
		AAP.ZoneQuestOrder["Order1iD"][CLi]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",65,-((CLPos)-11))
		--AAP.ZoneQuestOrder["Order1iD"][CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.ZoneQuestOrder["Order1iD"][CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.ZoneQuestOrder["Order1iD"][CLi])
AAP.ZoneQuestOrder["Order1iD"][CLi].texture = t

		AAP.ZoneQuestOrder["Order1iD"][CLi]:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				AAP.ZoneQuestOrder:StartMoving();
				AAP.ZoneQuestOrder.isMoving = true;
			end
		end)
		AAP.ZoneQuestOrder["Order1iD"][CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" then
				AAP.ZoneQuestOrder:StopMovingOrSizing();
				AAP.ZoneQuestOrder.isMoving = false;
			end
		end)
		AAP.ZoneQuestOrder["Order1iD"][CLi]:SetScript("OnHide", function(self)
			if ( AAP.ZoneQuestOrder.isMoving ) then
				AAP.ZoneQuestOrder:StopMovingOrSizing();
				AAP.ZoneQuestOrder.isMoving = false;
			end
		end)
		AAP.ZoneQuestOrder["Order1iD"][CLi]:SetScript("OnMouseWheel", function(self, arg1)
			if (arg1 == 1) then
				if (ScrollMod ~= 0) then
					ScrollMod = ScrollMod - 1
					AAP.UpdateZoneQuestOrderList(ScrollMod)
				end
			else
				ScrollMod = ScrollMod + 1
				AAP.UpdateZoneQuestOrderList(ScrollMod)
			end
		end)
		AAP.ZoneQuestOrder["Order1iDFS"][CLi] = AAP.ZoneQuestOrder["Order1iD"][CLi]:CreateFontString("AAPZoneQuestOrderFS2AID"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.ZoneQuestOrder["Order1iDFS"][CLi]:SetParent(AAP.ZoneQuestOrder["Order1iD"][CLi])
		AAP.ZoneQuestOrder["Order1iDFS"][CLi]:SetPoint("LEFT",AAP.ZoneQuestOrder["Order1iD"][CLi],"LEFT",5,0)
		AAP.ZoneQuestOrder["Order1iDFS"][CLi]:SetWidth(50)
		AAP.ZoneQuestOrder["Order1iDFS"][CLi]:SetHeight(16)
		AAP.ZoneQuestOrder["Order1iDFS"][CLi]:SetJustifyH("LEFT")
		AAP.ZoneQuestOrder["Order1iDFS"][CLi]:SetFontObject("GameFontNormalSmall")
		AAP.ZoneQuestOrder["Order1iDFS"][CLi]:SetText("")
		AAP.ZoneQuestOrder["Order1iDFS"][CLi]:SetTextColor(1, 1, 0)
end
function AAP.AddQuestNameFrame(CLi)
		CLPos = CLi * 16 + 16
	
		AAP.ZoneQuestOrder["OrderName"][CLi] = CreateFrame("frame", "AAP_ZoneQuestOrder2NameD"..CLi, AAP.ZoneQuestOrder)
		AAP.ZoneQuestOrder["OrderName"][CLi]:SetWidth(50)
		AAP.ZoneQuestOrder["OrderName"][CLi]:SetHeight(16)
		AAP.ZoneQuestOrder["OrderName"][CLi]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((CLPos)-11))
		--AAP.ZoneQuestOrder["OrderName"][CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.ZoneQuestOrder["OrderName"][CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.ZoneQuestOrder["OrderName"][CLi])
AAP.ZoneQuestOrder["OrderName"][CLi].texture = t

		AAP.ZoneQuestOrder["OrderName"][CLi]:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				AAP.ZoneQuestOrder:StartMoving();
				AAP.ZoneQuestOrder.isMoving = true;
			end
		end)
		AAP.ZoneQuestOrder["OrderName"][CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" then
				AAP.ZoneQuestOrder:StopMovingOrSizing();
				AAP.ZoneQuestOrder.isMoving = false;
			end
		end)
		AAP.ZoneQuestOrder["OrderName"][CLi]:SetScript("OnHide", function(self)
			if ( AAP.ZoneQuestOrder.isMoving ) then
				AAP.ZoneQuestOrder:StopMovingOrSizing();
				AAP.ZoneQuestOrder.isMoving = false;
			end
		end)
		AAP.ZoneQuestOrder["OrderName"][CLi]:SetScript("OnMouseWheel", function(self, arg1)
			if (arg1 == 1) then
				if (ScrollMod ~= 0) then
					ScrollMod = ScrollMod - 1
					AAP.UpdateZoneQuestOrderList(ScrollMod)
				end
			else
				ScrollMod = ScrollMod + 1
				AAP.UpdateZoneQuestOrderList(ScrollMod)
			end
		end)
		AAP.ZoneQuestOrder["OrderNameFS"][CLi] = AAP.ZoneQuestOrder["OrderName"][CLi]:CreateFontString("AAPZoneQuestOrderFS2NameD"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.ZoneQuestOrder["OrderNameFS"][CLi]:SetParent(AAP.ZoneQuestOrder["OrderName"][CLi])
		AAP.ZoneQuestOrder["OrderNameFS"][CLi]:SetPoint("LEFT",AAP.ZoneQuestOrder["OrderName"][CLi],"LEFT",5,0)
		AAP.ZoneQuestOrder["OrderNameFS"][CLi]:SetWidth(50)
		AAP.ZoneQuestOrder["OrderNameFS"][CLi]:SetHeight(16)
		AAP.ZoneQuestOrder["OrderNameFS"][CLi]:SetJustifyH("LEFT")
		AAP.ZoneQuestOrder["OrderNameFS"][CLi]:SetFontObject("GameFontNormalSmall")
		AAP.ZoneQuestOrder["OrderNameFS"][CLi]:SetText("")
		AAP.ZoneQuestOrder["OrderNameFS"][CLi]:SetTextColor(1, 1, 0)
end
function AAP.UpdateZoneQuestOrderList(AAPmod)
	if (AAP1["Debug"]) then
		print("Function: AAP.UpdateZoneQuestOrderList()")
	end
	if (not AAPQuestNames) then
		AAPQuestNames = {}
	end
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	local steps
	if (CurStep and AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
		steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
	end
	AAP.ZoneQuestOrder["Current"]:Hide()
	if (steps) then
		if (not AAPmod) then
			AAPmod = 0
		end
		if (MainQuest > 0) then
			local CLii
			for CLii = 1, MainQuest do
				AAP.ZoneQuestOrder[CLii]:Hide()
				AAP.ZoneQuestOrder["Order1"][CLii]:Hide()
				AAP.ZoneQuestOrder["FS"][CLii]:SetTextColor(1, 1, 0)
				AAP.ZoneQuestOrder["FS2"][CLii]:SetTextColor(1, 1, 0)
			end
		end
		if (SubQuestId > 0) then
			local CLii
			for CLii = 1, SubQuestId do
				AAP.ZoneQuestOrder["Order1iD"][CLii]:Hide()
			end
		end
		if (SubQuestName > 0) then
			local CLii
			for CLii = 1, SubQuestName do
				AAP.ZoneQuestOrder["OrderName"][CLii]:Hide()
			end
		end
		MainQuest = 0
		SubQuestId = 0
		SubQuestName = 0
		local CLi
		local Pos = 0
		if (AAPmod == "LoadIn") then
			if (CurStep > 5) then
				AAPmod = CurStep - 5
				ScrollMod = AAPmod
			else
				AAPmod = 0
			end
		end
		for CLi = 1, 27 do
			local CCLi = CLi + AAPmod
			MainQuest = MainQuest + 1
			if (not AAP.ZoneQuestOrder[MainQuest]) then
				AAP.AddQuestOrderFrame(MainQuest)
			end
			if (Pos > 26) then
				break
			end
			Pos = Pos + 1
			AAP.ZoneQuestOrder[CLi]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",5,-((16*Pos)-11))
			AAP.ZoneQuestOrder["Order1"][CLi]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",32,-((16*Pos)-11))
			if (AAP.QuestStepList[AAP.ActiveMap][CCLi]) then
				AAP.ZoneQuestOrder["FS"][CLi]:SetText(CCLi)
				if (CurStep == CCLi) then
					AAP.ZoneQuestOrder["Current"]:SetPoint("RIGHT", AAP.ZoneQuestOrder[CLi], "LEFT",0,0)
					AAP.ZoneQuestOrder["Current"]:Show()
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["PickUp"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Pick Up Quest")
					IdList = AAP.QuestStepList[AAP.ActiveMap][CCLi]["PickUp"]
					local NrLeft = 0
					local Flagged = 0
					local Total = 0
					local NrLeft2 = 0
					local Flagged2 = 0
					local Total2 = 0
					for h=1, getn(IdList) do
						local theqid = IdList[h]
						Total = Total + 1
						if (not AAP.ActiveQuests[theqid]) then
							NrLeft = NrLeft + 1
						end
						if (C_QuestLog.IsQuestFlaggedCompleted(theqid) or AAP.ActiveQuests[theqid] or AAP.BreadCrumSkips[theqid]) then
							Flagged = Flagged + 1
						end
					end
					if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["PickUp2"]) then
						IdList2 = AAP.QuestStepList[AAP.ActiveMap][CCLi]["PickUp2"]
						for h=1, getn(IdList2) do
							local theqid = IdList2[h]
							Total2 = Total2 + 1
							if (not AAP.ActiveQuests[theqid]) then
								NrLeft2 = NrLeft2 + 1
							end
							if (C_QuestLog.IsQuestFlaggedCompleted(theqid) or AAP.ActiveQuests[theqid] or AAP.BreadCrumSkips[theqid]) then
								Flagged2 = Flagged2 + 1
							end
						end
					end
					if (Total == Flagged) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					elseif (steps["PickUp2"] and Total2 == Flagged2) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
						for h=1, getn(IdList) do
							local theqid = IdList[h]
							if (Pos > 26) then
								break
							end
							if (C_QuestLog.IsQuestFlaggedCompleted(theqid) or AAP.ActiveQuests[theqid]) then
							else
								SubQuestId = SubQuestId + 1
								if (not AAP.ZoneQuestOrder["Order1iD"][SubQuestId]) then
									AAP.AddQuestIdFrame(SubQuestId)
								end
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetText(theqid)
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetTextColor(1, 1, 0)
								Pos = Pos + 1
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",65,-((16*Pos)-11))
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:Show()
								if (AAPQuestNames[theqid] and AAPQuestNames[theqid] ~= 1) then
									SubQuestName = SubQuestName + 1
									if (not AAP.ZoneQuestOrder["OrderName"][SubQuestName]) then
										AAP.AddQuestNameFrame(SubQuestName)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									else
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									end
								end
							end
						end
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["Qpart"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Do Quest Part")
					IdList = AAP.QuestStepList[AAP.ActiveMap][CCLi]["Qpart"]
					local Flagged = 0
					local Total = 0
					for AAP_index,AAP_value in pairs(IdList) do
						for AAP_index2,AAP_value2 in pairs(AAP_value) do
							Total = Total + 1
							local qid = AAP_index.."-"..AAP_index2
							if (C_QuestLog.IsQuestFlaggedCompleted(AAP_index) or ((UnitLevel("player") == 120) and AAP_BonusObj and AAP_BonusObj[AAP_index]) or AAP1[AAP.Realm][AAP.Name]["BonusSkips"][AAP_index]) then
								Flagged = Flagged + 1
							elseif (AAP.ActiveQuests[qid] and AAP.ActiveQuests[qid] == "C") then
								Flagged = Flagged + 1
							elseif (AAP.ActiveQuests[qid]) then
								AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
								AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
								local theqid = AAP_index
								if (Pos > 26) then
									break
								end
								SubQuestId = SubQuestId + 1
								if (not AAP.ZoneQuestOrder["Order1iD"][SubQuestId]) then
									AAP.AddQuestIdFrame(SubQuestId)
								end
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetText(theqid)
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetTextColor(1, 1, 0)
								Pos = Pos + 1
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",65,-((16*Pos)-11))
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:Show()
								if (AAPQuestNames[theqid] and AAPQuestNames[theqid] ~= 1) then
									SubQuestName = SubQuestName + 1
									if (not AAP.ZoneQuestOrder["OrderName"][SubQuestName]) then
										AAP.AddQuestNameFrame(SubQuestName)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									else
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									end
								end
							elseif (not AAP.ActiveQuests[AAP_index]) then
								AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
								AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
								local theqid = AAP_index
								if (Pos > 26) then
									break
								end
								SubQuestId = SubQuestId + 1
								if (not AAP.ZoneQuestOrder["Order1iD"][SubQuestId]) then
									AAP.AddQuestIdFrame(SubQuestId)
								end
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetText(theqid)
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetTextColor(1, 1, 0)
								Pos = Pos + 1
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",65,-((16*Pos)-11))
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:Show()
								if (AAPQuestNames[theqid] and AAPQuestNames[theqid] ~= 1) then
									SubQuestName = SubQuestName + 1
									if (not AAP.ZoneQuestOrder["OrderName"][SubQuestName]) then
										AAP.AddQuestNameFrame(SubQuestName)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									else
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									end
								end
							end
						end
					end
					if (Flagged == Total and Flagged > 0) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["Done"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Hand In Quest")
					IdList = AAP.QuestStepList[AAP.ActiveMap][CCLi]["Done"]
					local NrLeft = 0
					local Flagged = 0
					local Total = 0
					for h=1, getn(IdList) do
						Total = Total + 1
						local theqid = IdList[h]
						if (AAP.ActiveQuests[theqid]) then
							NrLeft = NrLeft + 1
						end
						if (C_QuestLog.IsQuestFlaggedCompleted(theqid) or AAP.BreadCrumSkips[theqid]) then
							Flagged = Flagged + 1
						end
					end
					if (Total == Flagged) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
						for h=1, getn(IdList) do
							local theqid = IdList[h]
							if (Pos > 26) then
								break
							end
							SubQuestId = SubQuestId + 1
							if (not AAP.ZoneQuestOrder["Order1iD"][SubQuestId]) then
								AAP.AddQuestIdFrame(SubQuestId)
							end
							AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetText(theqid)
							AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetTextColor(1, 1, 0)
							Pos = Pos + 1
							AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",65,-((16*Pos)-11))
							AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:Show()
							if (AAPQuestNames[theqid] and AAPQuestNames[theqid] ~= 1) then
								SubQuestName = SubQuestName + 1
								if (not AAP.ZoneQuestOrder["OrderName"][SubQuestName]) then
									AAP.AddQuestNameFrame(SubQuestName)
									AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
									AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
									AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
									AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
									AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
									AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
									AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
								else
									AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
									AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
									AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
									AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
									AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
									AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
									AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
								end
							end
						end
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["CRange"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Run to Waypoint")
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP.QuestStepList[AAP.ActiveMap][CCLi]["CRange"]) or CurStep > CCLi) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["UseDalaHS"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Use Dalaran HS")
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP.QuestStepList[AAP.ActiveMap][CCLi]["UseDalaHS"]) or CurStep > CCLi) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["DalaranToOgri"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Use Orgrimmar Portal")
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["PahonixMadeMe"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Train Riding")
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["UseGarrisonHS"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Use GarrisonHS")
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["ZonePick"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Pick Zone")
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["QpartPart"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Do Quest Part")
					IdList = AAP.QuestStepList[AAP.ActiveMap][CCLi]["QpartPart"]
					local Flagged = 0
					local Total = 0
					for AAP_index,AAP_value in pairs(IdList) do
						for AAP_index2,AAP_value2 in pairs(AAP_value) do
							Total = Total + 1
							if (C_QuestLog.IsQuestFlaggedCompleted(AAP_index)) then
								Flagged = Flagged + 1
							end
							local qid = AAP_index.."-"..AAP_index2
							if (AAP.ActiveQuests[qid] and AAP.ActiveQuests[qid] == "C") then
								Flagged = Flagged + 1
							elseif (AAP.ActiveQuests[qid]) then
								AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
								AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
								local theqid = AAP_index
								if (Pos > 26) then
									break
								end
								SubQuestId = SubQuestId + 1
								if (not AAP.ZoneQuestOrder["Order1iD"][SubQuestId]) then
									AAP.AddQuestIdFrame(SubQuestId)
								end
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetText(theqid)
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetTextColor(1, 1, 0)
								Pos = Pos + 1
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",65,-((16*Pos)-11))
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:Show()
								if (AAPQuestNames[theqid] and AAPQuestNames[theqid] ~= 1) then
									SubQuestName = SubQuestName + 1
									if (not AAP.ZoneQuestOrder["OrderName"][SubQuestName]) then
										AAP.AddQuestNameFrame(SubQuestName)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									else
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									end
								end
							elseif (not AAP.ActiveQuests[AAP_index]) then
								AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
								AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
								local theqid = AAP_index
								if (Pos > 26) then
									break
								end
								SubQuestId = SubQuestId + 1
								if (not AAP.ZoneQuestOrder["Order1iD"][SubQuestId]) then
									AAP.AddQuestIdFrame(SubQuestId)
								end
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetText(theqid)
								AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetTextColor(1, 1, 0)
								Pos = Pos + 1
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",65,-((16*Pos)-11))
								AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:Show()
								if (AAPQuestNames[theqid] and AAPQuestNames[theqid] ~= 1) then
									SubQuestName = SubQuestName + 1
									if (not AAP.ZoneQuestOrder["OrderName"][SubQuestName]) then
										AAP.AddQuestNameFrame(SubQuestName)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									else
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
									end
								end
							end
						end
					end
					if (Flagged == Total) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["DropQuest"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Quest Drop")
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP.QuestStepList[AAP.ActiveMap][CCLi]["DropQuest"]) or AAP.ActiveQuests[AAP.QuestStepList[AAP.ActiveMap][CCLi]["DropQuest"]]) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
					end

				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["SetHS"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Set Hearthstone")
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP.QuestStepList[AAP.ActiveMap][CCLi]["SetHS"]) or CurStep > CCLi) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["UseHS"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Use Hearthstone")
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP.QuestStepList[AAP.ActiveMap][CCLi]["UseHS"]) or CurStep > CCLi) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["ZoneDoneSave"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Route Completed")
					AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
					AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["GetFP"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Get Flightpath")
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP.QuestStepList[AAP.ActiveMap][CCLi]["GetFP"]) or CurStep > CCLi) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["UseFlightPath"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Use Flightpath")
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP.QuestStepList[AAP.ActiveMap][CCLi]["UseFlightPath"]) or CurStep > CCLi) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["QaskPopup"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Ask for group quest")
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP.QuestStepList[AAP.ActiveMap][CCLi]["QaskPopup"]) or CurStep > CCLi) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
						local theqid = AAP.QuestStepList[AAP.ActiveMap][CCLi]["QaskPopup"]
						if (Pos > 26) then
							break
						end
						SubQuestId = SubQuestId + 1
						if (not AAP.ZoneQuestOrder["Order1iD"][SubQuestId]) then
							AAP.AddQuestIdFrame(SubQuestId)
						end
						AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetText(theqid)
						AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetTextColor(1, 1, 0)
						Pos = Pos + 1
						AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",65,-((16*Pos)-11))
						AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:Show()
						if (AAPQuestNames[theqid] and AAPQuestNames[theqid] ~= 1) then
							SubQuestName = SubQuestName + 1
							if (not AAP.ZoneQuestOrder["OrderName"][SubQuestName]) then
								AAP.AddQuestNameFrame(SubQuestName)
								AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
								AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
								AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
								AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
								AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
								AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
							else
								AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
								AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
								AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
								AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
										AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
								AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
								AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
							end
						end
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["Treasure"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Get Treasure")
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP.QuestStepList[AAP.ActiveMap][CCLi]["Treasure"])) then
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(0, 1, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(0, 1, 0)
					else
						AAP.ZoneQuestOrder["FS"][CLi]:SetTextColor(1, 0, 0)
						AAP.ZoneQuestOrder["FS2"][CLi]:SetTextColor(1, 0, 0)
					end
					
					local theqid = AAP.QuestStepList[AAP.ActiveMap][CCLi]["Treasure"]
					SubQuestId = SubQuestId + 1
					if (not AAP.ZoneQuestOrder["Order1iD"][SubQuestId]) then
						AAP.AddQuestIdFrame(SubQuestId)
					end
					AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetText(theqid)
					AAP.ZoneQuestOrder["Order1iDFS"][SubQuestId]:SetTextColor(1, 1, 0)
					Pos = Pos + 1
					AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",65,-((16*Pos)-11))
					AAP.ZoneQuestOrder["Order1iD"][SubQuestId]:Show()
					if (AAPQuestNames[theqid] and AAPQuestNames[theqid] ~= 1) then
						SubQuestName = SubQuestName + 1
						if (not AAP.ZoneQuestOrder["OrderName"][SubQuestName]) then
							AAP.AddQuestNameFrame(SubQuestName)
							AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
							AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
							AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
							AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
							AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
							AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
							AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
						else
							AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetPoint("TOPLEFT", AAP.ZoneQuestOrder, "TOPLEFT",120,-((16*Pos)-11))
							AAP.ZoneQuestOrder["OrderName"][SubQuestName]:Show()
							AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetText(AAPQuestNames[theqid])
							AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(250)
							AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
							AAP.ZoneQuestOrder["OrderName"][SubQuestName]:SetWidth(AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:GetStringWidth()+10)
							AAP.ZoneQuestOrder["OrderNameFS"][SubQuestName]:SetTextColor(1, 1, 0)
						end
					end
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["ZoneDone"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Zone Done")
				end
				if (AAP.QuestStepList[AAP.ActiveMap][CCLi]["WarMode"]) then
					AAP.ZoneQuestOrder["FS2"][CLi]:SetText("Auto Enable Warmode")
				end
				AAP.ZoneQuestOrder[CLi]:Show()
				AAP.ZoneQuestOrder["Order1"][CLi]:Show()
			end
		end
	else
		if (MainQuest > 0) then
			local CLii
			for CLii = 1, MainQuest do
				AAP.ZoneQuestOrder[CLii]:Hide()
				AAP.ZoneQuestOrder["Order1"][CLii]:Hide()
				AAP.ZoneQuestOrder["FS"][CLii]:SetTextColor(1, 1, 0)
				AAP.ZoneQuestOrder["FS2"][CLii]:SetTextColor(1, 1, 0)
			end
		end
		if (SubQuestId > 0) then
			local CLii
			for CLii = 1, SubQuestId do
				AAP.ZoneQuestOrder["Order1iD"][CLii]:Hide()
			end
		end
		if (SubQuestName > 0) then
			local CLii
			for CLii = 1, SubQuestName do
				AAP.ZoneQuestOrder["OrderName"][CLii]:Hide()
			end
		end
	end
end
function AAP.MakeMapOrderIcons(IdZs)
	AAP["MapZoneIcons"][IdZs] = CreateFrame("Frame",nil,UIParent)
	AAP["MapZoneIcons"][IdZs]:SetFrameStrata("MEDIUM")
	AAP["MapZoneIcons"][IdZs]:SetWidth(20)
	AAP["MapZoneIcons"][IdZs]:SetHeight(20)
	AAP["MapZoneIcons"][IdZs]:SetScale(0.6)
	local t = 	AAP["MapZoneIcons"][IdZs]:CreateTexture(nil,"HIGH")
	t:SetTexture("Interface\\Addons\\AAP-Core\\Img\\Icon.blp")
	t:SetAllPoints(AAP["MapZoneIcons"][IdZs])
	--AAP["MapZoneIcons"][IdZs]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	AAP["MapZoneIcons"]["FS"..IdZs] = AAP["MapZoneIcons"][IdZs]:CreateFontString("AAPMapIconFS"..IdZs,"ARTWORK", "ChatFontNormal")
	AAP["MapZoneIcons"]["FS"..IdZs]:SetParent(AAP["MapZoneIcons"][IdZs])
	AAP["MapZoneIcons"]["FS"..IdZs]:SetPoint("CENTER",AAP["MapZoneIcons"][IdZs],"CENTER",0,0)
	AAP["MapZoneIcons"]["FS"..IdZs]:SetWidth(30)
	AAP["MapZoneIcons"]["FS"..IdZs]:SetHeight(25)
	AAP["MapZoneIcons"]["FS"..IdZs]:SetJustifyH("CENTER")
	AAP["MapZoneIcons"]["FS"..IdZs]:SetFontObject("GameFontNormalSmall")
	AAP["MapZoneIcons"]["FS"..IdZs]:SetText(IdZs)
	AAP["MapZoneIcons"]["FS"..IdZs]:SetTextColor(1, 1, 1)
	AAP["MapZoneIconsRed"][IdZs] = CreateFrame("Frame",nil,UIParent)
	AAP["MapZoneIconsRed"][IdZs]:SetFrameStrata("MEDIUM")
	AAP["MapZoneIconsRed"][IdZs]:SetWidth(20)
	AAP["MapZoneIconsRed"][IdZs]:SetHeight(20)
	AAP["MapZoneIconsRed"][IdZs]:SetScale(0.6)
	local t = 	AAP["MapZoneIconsRed"][IdZs]:CreateTexture(nil,"HIGH")
	t:SetTexture("Interface\\Addons\\AAP-Core\\Img\\RedIcon.tga")
	t:SetAllPoints(AAP["MapZoneIconsRed"][IdZs])
	--AAP["MapZoneIconsRed"][IdZs]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	AAP["MapZoneIconsRed"]["FS"..IdZs] = AAP["MapZoneIconsRed"][IdZs]:CreateFontString("AAPMapIconFS"..IdZs,"ARTWORK", "ChatFontNormal")
	AAP["MapZoneIconsRed"]["FS"..IdZs]:SetParent(AAP["MapZoneIconsRed"][IdZs])
	AAP["MapZoneIconsRed"]["FS"..IdZs]:SetPoint("CENTER",AAP["MapZoneIconsRed"][IdZs],"CENTER",0,0)
	AAP["MapZoneIconsRed"]["FS"..IdZs]:SetWidth(30)
	AAP["MapZoneIconsRed"]["FS"..IdZs]:SetHeight(25)
	AAP["MapZoneIconsRed"]["FS"..IdZs]:SetJustifyH("CENTER")
	AAP["MapZoneIconsRed"]["FS"..IdZs]:SetFontObject("GameFontNormalSmall")
	AAP["MapZoneIconsRed"]["FS"..IdZs]:SetText(IdZs)
	AAP["MapZoneIconsRed"]["FS"..IdZs]:SetTextColor(1, 1, 1)
end
function AAP.MapOrderNumbers()
	AAP.HBDP:RemoveAllWorldMapIcons("AAPMapOrder")
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	if (AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and CurStep) then
		local znr = 0
		local SetMapIDs = WorldMapFrame:GetMapID()
		if (SetMapIDs == nil) then
			SetMapIDs = C_Map.GetBestMapForUnit("player")
		end
		for AAP_index,AAP_value in pairs(AAP.QuestStepList[AAP.ActiveMap]) do
			znr = znr + 1
			if (AAP.QuestStepList[AAP.ActiveMap][znr] and AAP.QuestStepList[AAP.ActiveMap][znr]["TT"] and CurStep < znr and CurStep > (znr-11)) then
				if (not AAP["MapZoneIcons"][znr]) then
					AAP.MakeMapOrderIcons(znr)
				end
				if (not AAP.QuestStepList[AAP.ActiveMap][znr]["CRange"]) then
					ix, iy = GetPlayerMapPos(SetMapIDs, AAP.QuestStepList[AAP.ActiveMap][znr]["TT"]["y"],AAP.QuestStepList[AAP.ActiveMap][znr]["TT"]["x"])
					if (CurStep < znr) then
						AAP.HBDP:AddWorldMapIconMap("AAPMapOrder", AAP["MapZoneIconsRed"][znr], SetMapIDs, ix, iy, HBD_PINS_WORLDMAP_SHOW_PARENT)
					else
						AAP.HBDP:AddWorldMapIconMap("AAPMapOrder", AAP["MapZoneIcons"][znr], SetMapIDs, ix, iy, HBD_PINS_WORLDMAP_SHOW_PARENT)
					end
				end
			end
		end
	end
end

AAP_QH_EventFrame = CreateFrame("Frame")
AAP_QH_EventFrame:RegisterEvent ("QUEST_LOG_UPDATE")
AAP_QH_EventFrame:SetScript("OnEvent", function(self, event, ...)
	if (event=="QUEST_LOG_UPDATE") then
		if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowMap10s"] and AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowMap10s"] == 1 and WorldMapFrame:IsShown() and AAP.ActiveMap and AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]) then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			if (CurStep and MapIconUpdateStep ~= CurStep and CurStep > 1) then
				AAP.MapOrderNumbers()
			end
		end
	end
end)