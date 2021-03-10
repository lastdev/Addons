AAP.FP = {}
AAP.FP.Zonening = 0
local AAPLumberCheck = 0

function AAP.FP.TestDest()
	AAP.FP.TestDestFrame = CreateFrame("frame", "AAP.FP.TestDestFramez", UIParent)
	AAP.FP.TestDestFrame:SetWidth(200)
	AAP.FP.TestDestFrame:SetHeight(190)
	AAP.FP.TestDestFrame:SetMovable(true)
	AAP.FP.TestDestFrame:EnableMouse(true)
	AAP.FP.TestDestFrame:SetFrameStrata("LOW")
	AAP.FP.TestDestFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	--AAP.FP.TestDestFrame:SetBackdrop( { 
	--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
	--});
local t = AAP.FP.TestDestFrame:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.FP.TestDestFrame)
AAP.FP.TestDestFrame.texture = t

	AAP.FP.TestDestFrame:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			AAP.FP.TestDestFrame:StartMoving();
			AAP.FP.TestDestFrame.isMoving = true;
		end
	end)
	AAP.FP.TestDestFrame:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and AAP.FP.TestDestFrame.isMoving then
			AAP.FP.TestDestFrame:StopMovingOrSizing();
			AAP.FP.TestDestFrame.isMoving = false;
		end
	end)
	AAP.FP.TestDestFrame:SetScript("OnHide", function(self)
		if ( AAP.FP.TestDestFrame.isMoving ) then
			AAP.FP.TestDestFrame:StopMovingOrSizing();
			AAP.FP.TestDestFrame.isMoving = false;
		end
	end)
	local numbrs = 0
	for AAP_index,AAP_value in AAP.pairsByKeys(AAP.TDB["FPs"][AAP.Faction]) do
		numbrs = numbrs + 1
		AAP.FP.TestDestFrame["F"..numbrs] = CreateFrame("frame", "TestDestFrames"..numbrs, AAP.FP.TestDestFrame)
		AAP.FP.TestDestFrame["F"..numbrs]:SetWidth(130)
		AAP.FP.TestDestFrame["F"..numbrs]:SetHeight(20)
		--AAP.FP.TestDestFrame["F"..numbrs]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.FP.TestDestFrame["F"..numbrs]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.FP.TestDestFrame["F"..numbrs])
AAP.FP.TestDestFrame["F"..numbrs].texture = t

		AAP.FP.TestDestFrame["F"..numbrs]:SetMovable(true)
		AAP.FP.TestDestFrame["F"..numbrs]:EnableMouse(true)
		AAP.FP.TestDestFrame["F"..numbrs]:SetFrameStrata("LOW")
		AAP.FP.TestDestFrame["F"..numbrs]:SetPoint("TOPLEFT",AAP.FP.TestDestFrame,"TOPLEFT",5,-(numbrs*20-20))
		AAP.FP.TestDestFrame["F"..numbrs]:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				AAP.FP.TestDestClick(AAP_index)
			else
				AAP.FP.TestDestFrame:StartMoving();
				AAP.FP.TestDestFrame.isMoving = true;
			end
		end)
		AAP.FP.TestDestFrame["F"..numbrs]:SetScript("OnMouseUp", function(self, button)
			if AAP.FP.TestDestFrame.isMoving then
				AAP.FP.TestDestFrame:StopMovingOrSizing();
				AAP.FP.TestDestFrame.isMoving = false;
			end
		end)
		AAP.FP.TestDestFrame["F"..numbrs]:SetScript("OnHide", function(self)
			if ( AAP.FP.TestDestFrame.isMoving ) then
				AAP.FP.TestDestFrame:StopMovingOrSizing();
				AAP.FP.TestDestFrame.isMoving = false;
			end
		end)
		AAP.FP.TestDestFrame["F"..numbrs]["FS"..numbrs] = AAP.FP.TestDestFrame["F"..numbrs]:CreateFontString("TestDestFrameFS"..numbrs,"ARTWORK", "ChatFontNormal")
		AAP.FP.TestDestFrame["F"..numbrs]["FS"..numbrs]:SetPoint("TOPLEFT",AAP.FP.TestDestFrame["F"..numbrs],"TOPLEFT",5,0)
		AAP.FP.TestDestFrame["F"..numbrs]["FS"..numbrs]:SetWidth(120)
		AAP.FP.TestDestFrame["F"..numbrs]["FS"..numbrs]:SetHeight(20)
		AAP.FP.TestDestFrame["F"..numbrs]["FS"..numbrs]:SetJustifyH("LEFT")
		AAP.FP.TestDestFrame["F"..numbrs]["FS"..numbrs]:SetFontObject("GameFontNormal")
		local zename = C_Map.GetMapInfo(AAP_index)
		AAP.FP.TestDestFrame["F"..numbrs]["FS"..numbrs]:SetText(zename.name)
		AAP.FP.TestDestFrame["F"..numbrs]["FS"..numbrs]:SetTextColor(1, 1, 0)
	end
	numbrs = 0
	for CLi = 1, 50 do
		numbrs = numbrs + 1
		AAP.FP.TestDestFrame["F2"..numbrs] = CreateFrame("frame", "TestDestFrames2x"..numbrs, AAP.FP.TestDestFrame)
		AAP.FP.TestDestFrame["F2"..numbrs]:SetWidth(130)
		AAP.FP.TestDestFrame["F2"..numbrs]:SetHeight(20)
		--AAP.FP.TestDestFrame["F2"..numbrs]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.FP.TestDestFrame["F2"..numbrs]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.FP.TestDestFrame["F2"..numbrs])
AAP.FP.TestDestFrame["F2"..numbrs].texture = t

		AAP.FP.TestDestFrame["F2"..numbrs]:SetMovable(true)
		AAP.FP.TestDestFrame["F2"..numbrs]:EnableMouse(true)
		AAP.FP.TestDestFrame["F2"..numbrs]:SetFrameStrata("LOW")
		AAP.FP.TestDestFrame["F2"..numbrs]:SetPoint("TOPLEFT",AAP.FP.TestDestFrame,"TOPLEFT",140,-(numbrs*20-20))
		AAP.FP.TestDestFrame["F2"..numbrs]:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				AAP.FP.TestDestClick2(AAP.FP.TestDestFrame["F2"..CLi]["nr"])
			else
				AAP.FP.TestDestFrame:StartMoving();
				AAP.FP.TestDestFrame.isMoving = true;
			end
		end)
		AAP.FP.TestDestFrame["F2"..numbrs]:SetScript("OnMouseUp", function(self, button)
			if AAP.FP.TestDestFrame.isMoving then
				AAP.FP.TestDestFrame:StopMovingOrSizing();
				AAP.FP.TestDestFrame.isMoving = false;
			end
		end)
		AAP.FP.TestDestFrame["F2"..numbrs]:SetScript("OnHide", function(self)
			if ( AAP.FP.TestDestFrame.isMoving ) then
				AAP.FP.TestDestFrame:StopMovingOrSizing();
				AAP.FP.TestDestFrame.isMoving = false;
			end
		end)
		AAP.FP.TestDestFrame["F2"..numbrs]["FS"..numbrs] = AAP.FP.TestDestFrame["F2"..numbrs]:CreateFontString("TestDestFrameFS"..numbrs,"ARTWORK", "ChatFontNormal")
		AAP.FP.TestDestFrame["F2"..numbrs]["FS"..numbrs]:SetPoint("TOPLEFT",AAP.FP.TestDestFrame["F2"..numbrs],"TOPLEFT",5,0)
		AAP.FP.TestDestFrame["F2"..numbrs]["FS"..numbrs]:SetWidth(120)
		AAP.FP.TestDestFrame["F2"..numbrs]["FS"..numbrs]:SetHeight(20)
		AAP.FP.TestDestFrame["F2"..numbrs]["FS"..numbrs]:SetJustifyH("LEFT")
		AAP.FP.TestDestFrame["F2"..numbrs]["FS"..numbrs]:SetFontObject("GameFontNormal")
		AAP.FP.TestDestFrame["F2"..numbrs]["FS"..numbrs]:SetText("")
		AAP.FP.TestDestFrame["F2"..numbrs]["FS"..numbrs]:SetTextColor(1, 1, 0)
		AAP.FP.TestDestFrame["F2"..numbrs]:Hide()
	end
end
function AAP.FP.TestDestClick(Cont)
	for CLi = 1, 50 do
		AAP.FP.TestDestFrame["F2"..CLi]:Hide()
		AAP.FP.TestDestFrame["F2"..CLi]["FS"..CLi]:SetText("")
	end
	local numbrs = 0
	for AAP_index,AAP_value in AAP.pairsByKeys(AAP.TDB["FPs"][AAP.Faction][Cont]) do
		numbrs = numbrs + 1
		AAP.FP.TestDestFrame["F2"..numbrs]:Show()
		local zename = C_Map.GetMapInfo(AAP_index)
		AAP.FP.TestDestFrame["F2"..numbrs]["FS"..numbrs]:SetText(zename.name)
		AAP.FP.TestDestFrame["F2"..numbrs]["nr"] = AAP_index
	end
end
function AAP.FP.TestDestClick2(Zone)
	AAP.FP.GoToZone = Zone
	AAP.BookingList["GetMeToNextZone"] = 1
	for CLi = 1, 50 do
		AAP.FP.TestDestFrame["F2"..CLi]:Hide()
		AAP.FP.TestDestFrame["F2"..CLi]["FS"..CLi]:SetText("")
	end
end
function AAP.FP.ToyFPs()
	if (AAP1["Debug"]) then
		print("Function: AAP.FP.ToyFPs()")
	end
	if (AAP.Faction == "Alliance") then
		AAP.TDB["FPs"]["Horde"] = nil
		AAP.TDB["Ports"]["Horde"] = nil
	else
		AAP.TDB["FPs"]["Alliance"] = nil
		AAP.TDB["Ports"]["Alliance"] = nil
	end
	if (not AAP.FP.ToyFrame) then
		if (((PlayerHasToy(150745) or PlayerHasToy(150744)) and AAP.Faction == "Horde") or ((PlayerHasToy(150743) or PlayerHasToy(150746)) and AAP.Faction == "Alliance")) then
			AAP.FP.ToyFrame = CreateFrame("frame", "AAP_ToyFramez", UIParent)
			AAP.FP.ToyFrame:SetWidth(200)
			AAP.FP.ToyFrame:SetHeight(150)
			AAP.FP.ToyFrame:SetMovable(true)
			AAP.FP.ToyFrame:EnableMouse(true)
			AAP.FP.ToyFrame:SetFrameStrata("LOW")
			AAP.FP.ToyFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
			--AAP.FP.ToyFrame:SetBackdrop( { 
			--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
			--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
			--});
local t = AAP.FP.ToyFrame:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.FP.ToyFrame)
AAP.FP.ToyFrame.texture = t

			AAP.FP.ToyFrame:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					AAP.FP.ToyFrame:StartMoving();
					AAP.FP.ToyFrame.isMoving = true;
				end
			end)
			AAP.FP.ToyFrame:SetScript("OnMouseUp", function(self, button)
				if button == "LeftButton" and AAP.FP.ToyFrame.isMoving then
					AAP.FP.ToyFrame:StopMovingOrSizing();
					AAP.FP.ToyFrame.isMoving = false;
				end
			end)
			AAP.FP.ToyFrame:SetScript("OnHide", function(self)
				if ( AAP.FP.ToyFrame.isMoving ) then
					AAP.FP.ToyFrame:StopMovingOrSizing();
					AAP.FP.ToyFrame.isMoving = false;
				end
			end)
			AAP.FP.ToyFrame.FS1 = AAP.FP.ToyFrame:CreateFontString("AAPFPToyFrame","ARTWORK", "ChatFontNormal")
			AAP.FP.ToyFrame.FS1:SetParent(AAP.FP.ToyFrame)
			AAP.FP.ToyFrame.FS1:SetPoint("TOP",AAP.FP.ToyFrame,"TOP",0,0)
			AAP.FP.ToyFrame.FS1:SetWidth(300)
			AAP.FP.ToyFrame.FS1:SetHeight(38)
			AAP.FP.ToyFrame.FS1:SetJustifyH("TOP")
			AAP.FP.ToyFrame.FS1:SetFontObject("GameFontNormalLarge")
			AAP.FP.ToyFrame.FS1:SetText("Use Flightpath Toys")
			AAP.FP.ToyFrame.FS1:SetTextColor(1, 1, 0)
			if (AAP.Faction == "Horde") then
				if (PlayerHasToy(150745) and C_QuestLog.IsQuestFlaggedCompleted(47956) == false) then
					local itemID, toyName, icon, isFavorite, hasFanfare, itemQuality = C_ToyBox.GetToyInfo(150745)
					AAP.FP.ToyFrame.F1 = CreateFrame("Button", "AAPFPToyFrameF2", AAP.FP.ToyFrame, "SecureActionButtonTemplate")
					AAP.FP.ToyFrame.F1:SetPoint("LEFT", AAP.FP.ToyFrame, "LEFT", 15, 0)
					AAP.FP.ToyFrame.F1:SetWidth(80)
					AAP.FP.ToyFrame.F1:SetHeight(80)
					AAP.FP.ToyFrame.F1:SetText("")
					AAP.FP.ToyFrame.F1:SetParent(AAP.FP.ToyFrame)
					AAP.FP.ToyFrame.F1:SetNormalFontObject("GameFontNormal")
					AAP.FP.ToyFrame.F1ntex = AAP.FP.ToyFrame.F1:CreateTexture()
					AAP.FP.ToyFrame.F1ntex:SetTexture(icon)
					AAP.FP.ToyFrame.F1ntex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F1ntex:SetAllPoints()	
					AAP.FP.ToyFrame.F1:SetNormalTexture(AAP.FP.ToyFrame.F1ntex)
					AAP.FP.ToyFrame.F1htex = AAP.FP.ToyFrame.F1:CreateTexture()
					AAP.FP.ToyFrame.F1htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
					AAP.FP.ToyFrame.F1htex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F1htex:SetAllPoints()
					AAP.FP.ToyFrame.F1:SetHighlightTexture(AAP.FP.ToyFrame.F1htex)
					AAP.FP.ToyFrame.F1ptex = AAP.FP.ToyFrame.F1:CreateTexture()
					AAP.FP.ToyFrame.F1ptex:SetTexture(icon)
					AAP.FP.ToyFrame.F1ptex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F1ptex:SetAllPoints()
					AAP.FP.ToyFrame.F1:SetPushedTexture(AAP.FP.ToyFrame.F1ptex)
					AAP.FP.ToyFrame.F1:SetAttribute("type", "item");
					AAP.FP.ToyFrame.F1:SetAttribute("item", toyName);
				end
				if (PlayerHasToy(150744) and C_QuestLog.IsQuestFlaggedCompleted(47954) == false) then
					local itemID, toyName, icon, isFavorite, hasFanfare, itemQuality = C_ToyBox.GetToyInfo(150744)
					AAP.FP.ToyFrame.F2 = CreateFrame("Button", "AAPFPToyFrameF2", AAP.FP.ToyFrame, "SecureActionButtonTemplate")
					AAP.FP.ToyFrame.F2:SetPoint("RIGHT", AAP.FP.ToyFrame, "RIGHT", -15, 0)
					AAP.FP.ToyFrame.F2:SetWidth(80)
					AAP.FP.ToyFrame.F2:SetHeight(80)
					AAP.FP.ToyFrame.F2:SetText("")
					AAP.FP.ToyFrame.F2:SetParent(AAP.FP.ToyFrame)
					AAP.FP.ToyFrame.F2:SetNormalFontObject("GameFontNormal")
					AAP.FP.ToyFrame.F2ntex = AAP.FP.ToyFrame.F2:CreateTexture()
					AAP.FP.ToyFrame.F2ntex:SetTexture(icon)
					AAP.FP.ToyFrame.F2ntex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F2ntex:SetAllPoints()	
					AAP.FP.ToyFrame.F2:SetNormalTexture(AAP.FP.ToyFrame.F2ntex)
					AAP.FP.ToyFrame.F2htex = AAP.FP.ToyFrame.F2:CreateTexture()
					AAP.FP.ToyFrame.F2htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
					AAP.FP.ToyFrame.F2htex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F2htex:SetAllPoints()
					AAP.FP.ToyFrame.F2:SetHighlightTexture(AAP.FP.ToyFrame.F2htex)
					AAP.FP.ToyFrame.F2ptex = AAP.FP.ToyFrame.F2:CreateTexture()
					AAP.FP.ToyFrame.F2ptex:SetTexture(icon)
					AAP.FP.ToyFrame.F2ptex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F2ptex:SetAllPoints()
					AAP.FP.ToyFrame.F2:SetPushedTexture(AAP.FP.ToyFrame.F2ptex)
					AAP.FP.ToyFrame.F2:SetAttribute("type", "item");
					AAP.FP.ToyFrame.F2:SetAttribute("item", toyName);
				end
				if (C_QuestLog.IsQuestFlaggedCompleted(47954) and C_QuestLog.IsQuestFlaggedCompleted(47956)) then
					AAP.FP.ToyFrame:Hide()
				else
					C_Timer.After(5, AAP.FP.testClickedFPS)
				end
			elseif (AAP.Faction == "Alliance") then
				if (PlayerHasToy(150743) and C_QuestLog.IsQuestFlaggedCompleted(47954) == false) then
					local itemID, toyName, icon, isFavorite, hasFanfare, itemQuality = C_ToyBox.GetToyInfo(150743)
					AAP.FP.ToyFrame.F1 = CreateFrame("Button", "AAPFPToyFrameF2", AAP.FP.ToyFrame, "SecureActionButtonTemplate")
					AAP.FP.ToyFrame.F1:SetPoint("LEFT", AAP.FP.ToyFrame, "LEFT", 15, 0)
					AAP.FP.ToyFrame.F1:SetWidth(80)
					AAP.FP.ToyFrame.F1:SetHeight(80)
					AAP.FP.ToyFrame.F1:SetText("")
					AAP.FP.ToyFrame.F1:SetParent(AAP.FP.ToyFrame)
					AAP.FP.ToyFrame.F1:SetNormalFontObject("GameFontNormal")
					AAP.FP.ToyFrame.F1ntex = AAP.FP.ToyFrame.F1:CreateTexture()
					AAP.FP.ToyFrame.F1ntex:SetTexture(icon)
					AAP.FP.ToyFrame.F1ntex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F1ntex:SetAllPoints()	
					AAP.FP.ToyFrame.F1:SetNormalTexture(AAP.FP.ToyFrame.F1ntex)
					AAP.FP.ToyFrame.F1htex = AAP.FP.ToyFrame.F1:CreateTexture()
					AAP.FP.ToyFrame.F1htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
					AAP.FP.ToyFrame.F1htex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F1htex:SetAllPoints()
					AAP.FP.ToyFrame.F1:SetHighlightTexture(AAP.FP.ToyFrame.F1htex)
					AAP.FP.ToyFrame.F1ptex = AAP.FP.ToyFrame.F1:CreateTexture()
					AAP.FP.ToyFrame.F1ptex:SetTexture(icon)
					AAP.FP.ToyFrame.F1ptex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F1ptex:SetAllPoints()
					AAP.FP.ToyFrame.F1:SetPushedTexture(AAP.FP.ToyFrame.F1ptex)
					AAP.FP.ToyFrame.F1:SetAttribute("type", "item");
					AAP.FP.ToyFrame.F1:SetAttribute("item", toyName);
				end
				if (PlayerHasToy(150746) and C_QuestLog.IsQuestFlaggedCompleted(47956) == false) then
					local itemID, toyName, icon, isFavorite, hasFanfare, itemQuality = C_ToyBox.GetToyInfo(150746)
					AAP.FP.ToyFrame.F2 = CreateFrame("Button", "AAPFPToyFrameF2", AAP.FP.ToyFrame, "SecureActionButtonTemplate")
					AAP.FP.ToyFrame.F2:SetPoint("RIGHT", AAP.FP.ToyFrame, "RIGHT", -15, 0)
					AAP.FP.ToyFrame.F2:SetWidth(80)
					AAP.FP.ToyFrame.F2:SetHeight(80)
					AAP.FP.ToyFrame.F2:SetText("")
					AAP.FP.ToyFrame.F2:SetParent(AAP.FP.ToyFrame)
					AAP.FP.ToyFrame.F2:SetNormalFontObject("GameFontNormal")
					AAP.FP.ToyFrame.F2ntex = AAP.FP.ToyFrame.F2:CreateTexture()
					AAP.FP.ToyFrame.F2ntex:SetTexture(icon)
					AAP.FP.ToyFrame.F2ntex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F2ntex:SetAllPoints()	
					AAP.FP.ToyFrame.F2:SetNormalTexture(AAP.FP.ToyFrame.F2ntex)
					AAP.FP.ToyFrame.F2htex = AAP.FP.ToyFrame.F2:CreateTexture()
					AAP.FP.ToyFrame.F2htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
					AAP.FP.ToyFrame.F2htex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F2htex:SetAllPoints()
					AAP.FP.ToyFrame.F2:SetHighlightTexture(AAP.FP.ToyFrame.F2htex)
					AAP.FP.ToyFrame.F2ptex = AAP.FP.ToyFrame.F2:CreateTexture()
					AAP.FP.ToyFrame.F2ptex:SetTexture(icon)
					AAP.FP.ToyFrame.F2ptex:SetTexCoord(0, 0.625, 0, 0.6875)
					AAP.FP.ToyFrame.F2ptex:SetAllPoints()
					AAP.FP.ToyFrame.F2:SetPushedTexture(AAP.FP.ToyFrame.F2ptex)
					AAP.FP.ToyFrame.F2:SetAttribute("type", "item");
					AAP.FP.ToyFrame.F2:SetAttribute("item", toyName);
				end
				if (AAP.Faction == "Alliance" and (C_QuestLog.IsQuestFlaggedCompleted(47954) or PlayerHasToy(150743) == false) and (C_QuestLog.IsQuestFlaggedCompleted(47956) or PlayerHasToy(150746) == false)) then
					AAP.FP.ToyFrame:Hide()
				elseif (AAP.Faction == "Horde" and (C_QuestLog.IsQuestFlaggedCompleted(47954) or PlayerHasToy(150744) == false) and (C_QuestLog.IsQuestFlaggedCompleted(47956) or PlayerHasToy(150745) == false)) then
					AAP.FP.ToyFrame:Hide()
				else
					C_Timer.After(5, AAP.FP.testClickedFPS)
				end
			end
		end
	end
end
function AAP.FP.testClickedFPS()
	if (AAP1["Debug"]) then
		print("Function: AAP.FP.testClickedFPS()")
	end
	if (AAP.Faction == "Alliance" and (C_QuestLog.IsQuestFlaggedCompleted(47954) or PlayerHasToy(150743) == false) and (C_QuestLog.IsQuestFlaggedCompleted(47956) or PlayerHasToy(150746) == false)) then
		AAP.FP.ToyFrame:Hide()
	elseif (AAP.Faction == "Horde" and (C_QuestLog.IsQuestFlaggedCompleted(47954) or PlayerHasToy(150744) == false) and (C_QuestLog.IsQuestFlaggedCompleted(47956) or PlayerHasToy(150745) == false)) then
		AAP.FP.ToyFrame:Hide()
	else
		if (AAP.Faction == "Alliance") then
			if (C_QuestLog.IsQuestFlaggedCompleted(47956) and AAP.FP.ToyFrame.F2) then
				AAP.FP.ToyFrame.F2:Hide()
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(47954) and AAP.FP.ToyFrame.F1) then
				AAP.FP.ToyFrame.F1:Hide()
			end
		elseif (AAP.Faction == "Horde") then
			if (C_QuestLog.IsQuestFlaggedCompleted(47956) and AAP.FP.ToyFrame.F1) then
				AAP.FP.ToyFrame.F1:Hide()
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(47954) and AAP.FP.ToyFrame.F2) then
				AAP.FP.ToyFrame.F2:Hide()
			end
		end
		C_Timer.After(1, AAP.FP.testClickedFPS)
	end
end
function AAP.FP.test()
	if (AAP1["Debug"]) then
		print("Function: AAP.FP.test()")
	end
	if (not AAP_Transport["Ports"]) then
		AAP_Transport["Ports"] = {}
	end
	if (not AAP_Transport["Ports"][AAP.Faction]) then
		AAP_Transport["Ports"][AAP.Faction] = {}
	end
	if (not AAP_Transport["Ports"][AAP.Faction][AAP.getContinent()]) then
		AAP_Transport["Ports"][AAP.Faction][AAP.getContinent()] = {}
	end
	AAP_Transport["Ports"][AAP.Faction][AAP.getContinent()]["Port"] = {}
	local d_y, d_x = UnitPosition("player")
	d_y = floor((d_y * 10)+5) / 10
	d_x = floor((d_x * 10)+5) / 10
	AAP_Transport["Ports"][AAP.Faction][AAP.getContinent()]["Port"]["y"] = d_y
	AAP_Transport["Ports"][AAP.Faction][AAP.getContinent()]["Port"]["x"] = d_x
end
function AAP.FP.GetMeToNextZonetest()
	if (AAP1["Debug"]) then
		print("Function: AAP.FP.GetMeToNextZonetest()")
	end
	local AAPt_Zone2 = C_Map.GetBestMapForUnit("player")
	local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
	AAPt_Zone2 = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent, TOP_MOST)
	if (AAPt_Zone2 and AAPt_Zone2["mapID"]) then
		AAPt_Zone2 = AAPt_Zone2["mapID"]
	else
		AAPt_Zone2 = C_Map.GetBestMapForUnit("player")
	end
	if (AAPt_Zone2 == 1671) then
		AAPt_Zone2 = 1670
	elseif (AAPt_Zone == 578) then
		AAPt_Zone = 577
	elseif (AAP.ActiveMap == "A543-DesMephisto-Gorgrond" and AAPt_Zone == 535) then
		AAPt_Zone = 543
	elseif (AAPt_Zone == 1726 or AAPt_Zone == 1727  or AAPt_Zone == 1728) then
		AAPt_Zone = 1409
	end
end
function AAP.FP.GetCustomZone()
	local ZeMap = C_Map.GetBestMapForUnit("player")
	local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
	if (Enum and Enum.UIMapType and Enum.UIMapType.Continent and currentMapId) then
		ZeMap = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent+1, TOP_MOST)
	end
	if (ZeMap and ZeMap["mapID"]) then
		ZeMap = ZeMap["mapID"]
	else
		ZeMap = C_Map.GetBestMapForUnit("player")
	end
	local zenr = 0
	if (AAP_Custom and AAP_Custom[AAP.Name.."-"..AAP.Realm]) then
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP_Custom[AAP.Name.."-"..AAP.Realm]) do
			zenr = zenr + 1
		end
	end
	if (zenr == 0 and UnitFactionGroup("player") == "Alliance" and C_QuestLog.IsQuestFlaggedCompleted(59751) == false and (C_QuestLog.IsQuestFlaggedCompleted(60545) == true or C_QuestLog.IsOnQuest(60545) == true)) then
		return 84, "84-IntroQline"
	end
	if (zenr == 0 and UnitFactionGroup("player") == "Horde" and C_QuestLog.IsQuestFlaggedCompleted(59751) == false and (C_QuestLog.IsQuestFlaggedCompleted(61874) == true or C_QuestLog.IsOnQuest(61874) == true)) then
		return 85, "85-IntroQline"
	end
	if (zenr == 0 and not ZeMap and C_QuestLog.IsOnQuest(57159)) then
		return AAP.QuestStepListListingZone["Z-12-Revendreth-Story"], "1525-Z12-Revendreth-Story"
	end
	if (zenr == 0 and C_QuestLog.IsOnQuest(57876) and C_QuestLog.IsQuestFlaggedCompleted(57876) == false) then
		return AAP.QuestStepListListingZone["Z-14-Revendreth-Story"], "1525-Z14-Revendreth-Story"
	end
	if (zenr == 0 and AAP.Level > 49) then
		AAP.ProgressText = "Auto Path"
		AAP.ProgressShown = 0
		if (C_QuestLog.IsQuestFlaggedCompleted(58086) == false and (C_QuestLog.IsOnQuest(61874) == true or C_QuestLog.IsQuestFlaggedCompleted(61874) == true or C_QuestLog.IsOnQuest(59751) or C_QuestLog.IsQuestFlaggedCompleted(59751) == true)) then
			if (C_QuestLog.IsQuestFlaggedCompleted(59770) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-00-TheMaw-Story"], "1648-Z0-TheMaw-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(59773) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-01-Oribos-Story"], "1670-Z1-Oribos-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(60056) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-02-Bastion-Story"], "1533-Z2-Bastion-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(57386) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-03-Oribos-Story"], "1613-Z3-Oribos-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(59874) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-04-Maldraxxus-Story"], "1536-Z4-Maldraxxus-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(59897) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-05-Oribos-Story"], "1670-Z5-Oribos-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(62654) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-06-The Maw-Story"], "1543-Z6-TheMaw-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(59011) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-07-Oribos-Story"], "1670-Z7-Oribos-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(59206) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-08-Maldraxxus-Story"], "1536-Z8-Maldraxxus-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(60338) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-09-Oribos-Story"], "1670-Z9-Oribos-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(58724) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-10-Ardenweald-Story"], "1565-Z10-Ardenweald-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(57025) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-11-Oribos-Story"], "1671-Z11-Oribos-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(57689) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-12-Revendreth-Story"], "1525-Z12-Revendreth-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(57693) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-13-The Maw-Story"], "1543-Z13-TheMaw-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(57876) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-14-Revendreth-Story"], "1525-Z14-Revendreth-Story"
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(57878) == false) then
				AAP.ProgressShown = 1
				return AAP.QuestStepListListingZone["Z-15-Oribos-Story"], "1671-Z15-Oribos-Story"
			end
		elseif (C_QuestLog.IsOnQuest(61874) == true or C_QuestLog.IsQuestFlaggedCompleted(61874) == true) then

		else
			AAP.ProgressShown = 0
			return
		end
	elseif (zenr == 0) then
		AAP.ProgressText = "Auto Path"
		AAP.ProgressShown = 0
		if (ZeMap == 1409 or ZeMap == 1726 or ZeMap == 1727 or ZeMap == 1728) then
			if (IsAddOnLoaded("AAP-Shadowlands") == false) then
				local loaded, reason = LoadAddOn("AAP-Shadowlands")
				if (not loaded) then
					if (reason == "DISABLED") then
						print("AAP: AAP - Shadowlands is Disabled in your Addon-List!")
					end
				end
			end
		--	return AAP.QuestStepListListingZone["01-10 Exile's Reach"], "1409-Exile's Reach"
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(34398) == false and AAP.Faction == "Alliance") then
			AAP.ProgressShown = 1
			return AAP.QuestStepListListingZone["(1/7) 1-50 Stormwind"], "A84-DesMephisto-Stormwind-War"
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(35884) == false and AAP.Faction == "Alliance") then
			AAP.ProgressShown = 1
			return AAP.QuestStepListListingZone["(2/7) 1-50 Tanaan Jungle"], "A577-DesMephisto-TanaanJungle"
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(35556) == false and AAP.Faction == "Alliance") then
			AAP.ProgressShown = 1
			return AAP.QuestStepListListingZone["(3/7) 1-50 Shadowmoon"], "A539-DesMephisto-Shadowmoon1"
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(36937) == false and AAP.Faction == "Alliance") then
			AAP.ProgressShown = 1
			return AAP.QuestStepListListingZone["(4/7) 1-50 Gorgrond"], "A543-DesMephisto-Gorgrond"
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(34587) == false and AAP.Faction == "Alliance") then
			AAP.ProgressShown = 1
			return AAP.QuestStepListListingZone["(5/7) 1-50 Talador"], "A535-DesMephisto-Talador"
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(34624) == false and AAP.Faction == "Alliance") then
			AAP.ProgressShown = 1
			return AAP.QuestStepListListingZone["(6/7) 1-50 Shadowmoon"], "A539-DesMephisto-Shadowmoon2"
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(34707) == false and AAP.Faction == "Alliance") then
			AAP.ProgressShown = 1
			return AAP.QuestStepListListingZone["(7/7) 1-50 Talador"], "A535-DesMephisto-Talador2"
		end

	end
	if (zenr == 0 and C_QuestLog.IsQuestFlaggedCompleted(62023) == true and C_QuestLog.IsQuestFlaggedCompleted(57904) == false) then
		AAP.ProgressShown = 1
		return 1533, "1670-Kyrian"
	end
	if (zenr == 0 and C_QuestLog.IsQuestFlaggedCompleted(62019) == true and C_QuestLog.IsQuestFlaggedCompleted(58159) == false) then
		AAP.ProgressShown = 1
		return 1565, "1670-NightFae"
	end
	if (zenr == 0 and C_QuestLog.IsQuestFlaggedCompleted(62020) == true and C_QuestLog.IsQuestFlaggedCompleted(59320) == false) then
		AAP.ProgressShown = 1
		return 1525, "1670-Venthyr"
	end
	if (zenr == 0 and C_QuestLog.IsQuestFlaggedCompleted(62017) == true and C_QuestLog.IsQuestFlaggedCompleted(60049) == false) then
		AAP.ProgressShown = 1
		return 1536, "1670-Necrolords"
	end
	AAP.ProgressText = "Custom Path"
	if (not AAP_Custom) then
		return
	end
	if (AAP1["Debug"]) then
		print("Function: AAP.FP.GetCustomZone()")
	end
	for CLi = 1, 19 do
		if (AAP_Custom[AAP.Name.."-"..AAP.Realm] and AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi] and AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]]) then
			if (AAP.QuestStepListListingStartAreas["EasternKingdom"]) then
				for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListingStartAreas["EasternKingdom"]) do
					if (AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi] == AAP_value2) then
						AAP.ProgressShown = 1
						return AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]], AAP_index2
					end
				end
			end
			if (AAP.QuestStepListListingStartAreas["BrokenIsles"]) then
				for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListingStartAreas["BrokenIsles"]) do
					if (AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi] == AAP_value2) then
						AAP.ProgressShown = 1
						return AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]], AAP_index2
					end
				end
			end
			if (AAP.QuestStepListListingStartAreas["Kalimdor"]) then
				for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListingStartAreas["Kalimdor"]) do
					if (AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi] == AAP_value2) then
						AAP.ProgressShown = 1
						return AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]], AAP_index2
					end
				end
			end
			for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListing["EasternKingdom"]) do
				if (AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi] == AAP_value2) then
					AAP.ProgressShown = 1
					return AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]], AAP_index2
				end
			end
			for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListing["Kalimdor"]) do
				if (AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi] == AAP_value2) then
					AAP.ProgressShown = 1
					return AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]], AAP_index2
				end
			end
			for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListing["SpeedRun"]) do
				if (AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi] == AAP_value2) then
					AAP.ProgressShown = 1
					return AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]], AAP_index2
				end
			end
			for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListing["Shadowlands"]) do
				if (AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi] == AAP_value2) then
					AAP.ProgressShown = 1
					return AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]], AAP_index2
				end
			end
		end
	end
	AAP.ProgressText = nil
end
function AAP.FP.GetMeToNextZoneSpecialRe(AAPt_Zone)
	if (AAPLumberCheck == 0 and C_QuestLog.IsQuestFlaggedCompleted(35049)) then
		AAP.QuestStepList["A543-DesMephisto-Gorgrond"] = nil
		AAP.QuestStepList["A543-DesMephisto-Gorgrond"] = AAP.QuestStepList["A543-DesMephisto-Gorgrond-Lumbermill"]
		AAPLumberCheck = 1
	end
	if (AAPLumberCheck == 0 and C_QuestLog.IsQuestFlaggedCompleted(34992)) then
		AAP.QuestStepList["543-DesMephisto-Gorgrond-p1"] = nil
		AAP.QuestStepList["543-DesMephisto-Gorgrond-p1"] = AAP.QuestStepList["543-DesMephisto-Gorgrond-Lumbermill"]
		AAPLumberCheck = 1
	end

	if (((ZeMap == 1409 or ZeMap == 1726) or C_QuestLog.IsQuestFlaggedCompleted(55992) or C_QuestLog.IsQuestFlaggedCompleted(55991) or C_QuestLog.IsQuestFlaggedCompleted(59984) or C_QuestLog.IsQuestFlaggedCompleted(59985)) and AAP.Level < 15) then
		if (C_QuestLog.IsOnQuest(59583) == true) then
			C_QuestLog.SetSelectedQuest(59583)
			C_QuestLog.SetAbandonQuest()
			C_QuestLog.AbandonQuest()
		end
		if (C_QuestLog.IsOnQuest(60343) == true) then
			C_QuestLog.SetSelectedQuest(60343)
			C_QuestLog.SetAbandonQuest()
			C_QuestLog.AbandonQuest()
		end
		AAP.QuestStepList["A84-DesMephisto-Stormwind-War"] = AAP.QuestStepList["A84-DesMephisto-Stormwind-War2"]
	elseif (AAP.Level < 15) then
		AAP.QuestStepList["A84-DesMephisto-Stormwind-War"] = AAP.QuestStepList["A84-DesMephisto-Stormwind-War3"]
	end
	if (AAPt_Zone == 1671) then
		AAPt_Zone = 1670
	elseif (AAPt_Zone == 578) then
		AAPt_Zone = 577
	elseif (AAP.ActiveMap == "A535-DesMephisto-Talador2" and AAPt_Zone == 542) then
		AAPt_Zone = 535
	elseif (AAP.ActiveMap == "A84-DesMephisto-Stormwind-War" and AAPt_Zone == 17) then
		AAPt_Zone = 84
	elseif (AAP.ActiveMap == "A543-DesMephisto-Gorgrond" and AAPt_Zone == 535) then
		AAPt_Zone = 543
	elseif (AAP.ActiveMap == "A539-DesMephisto-Shadowmoon1" and (AAPt_Zone == 84 or AAPt_Zone == 543)) then
		AAPt_Zone = 539
	elseif (AAP.ActiveMap == "A539-DesMephisto-Shadowmoon2" and AAPt_Zone == 535) then
		AAPt_Zone = 539
	elseif (AAP.ActiveMap == "A535-DesMephisto-Talador" and AAPt_Zone == 539) then
		AAPt_Zone = 535
	elseif (AAPt_Zone == 1726 or AAPt_Zone == 1727 or AAPt_Zone == 1728) then
		AAPt_Zone = 1409
	end
	
	
	if (AAP.ActiveMap == "Shadowlands-StoryOnly-A" and ((AAPt_Zone == 84) or (AAPt_Zone == 1648) or (AAPt_Zone == 1670) or (AAPt_Zone == 1671) or (AAPt_Zone == 1533) or (AAPt_Zone == 1613) or (AAPt_Zone == 1536) or (AAPt_Zone == 1543) or (AAPt_Zone == 1565) or (AAPt_Zone == 1525))) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "Shadowlands-StoryOnly-H" and ((AAPt_Zone == 85) or (AAPt_Zone == 1648) or (AAPt_Zone == 1670) or (AAPt_Zone == 1671) or (AAPt_Zone == 1533) or (AAPt_Zone == 1613) or (AAPt_Zone == 1536) or (AAPt_Zone == 1543) or (AAPt_Zone == 1565) or (AAPt_Zone == 1525))) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "85-DesMephisto-Orgrimmar-p1" and AAPt_Zone == 17) then
		AAPt_Zone = 85
	end
	if (AAP.ActiveMap == "525-DesMephisto-FrostfireRidge-p1" and AAPt_Zone == 85) then
		AAPt_Zone = 525
	end
	if (AAP.ActiveMap == "525-DesMephisto-FrostfireRidge-p1" and AAPt_Zone == 543) then
		AAPt_Zone = 525
	end
	if (AAP.ActiveMap == "543-DesMephisto-Gorgrond-p1" and AAPt_Zone == 535) then
		AAPt_Zone = 543
	end
	if (AAP.ActiveMap == "535-DesMephisto-Talador-p1" and AAPt_Zone == 542) then
		AAPt_Zone = 535
	end
	if (AAP.ActiveMap == "550-DesMephisto-Nagrand" and AAPt_Zone == 535) then
		AAPt_Zone = 550
	end
	

	
	if (AAP.ActiveMap == "1409-Exile's Reach" and AAPt_Zone == 85) then
		AAPt_Zone = 1409
	end
	
	if (AAP.ActiveMap == "84-IntroQline" and AAPt_Zone == 118) then
		AAPt_Zone = 84
	end
	if (AAP.ActiveMap == "84-IntroQline" and AAPt_Zone == 1648) then
		AAPt_Zone = 84
	end
	if (AAP.ActiveMap == "85-IntroQline" and AAPt_Zone == 118) then
		AAPt_Zone = 85
	end
	if (AAP.ActiveMap == "85-IntroQline" and AAPt_Zone == 1648) then
		AAPt_Zone = 85
	end
	
	
	if (AAP.ActiveMap == "1533-Bastion-NonStoryMode-1" and AAPt_Zone == 1670) then
		AAPt_Zone = 1533
	end	
	if (AAP.ActiveMap == "1670-Z1-Oribos-Story" and AAPt_Zone == 1533) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1670-Z1-Oribos-Story" and AAPt_Zone == 1673) then
		AAPt_Zone = 1670
	end
	
	if (AAP.ActiveMap == "1533-Z2-Bastion-Story" and AAPt_Zone == 1670) then
		AAPt_Zone = 1533
	end
	if (AAP.ActiveMap == "1613-Z3-Oribos-Story" and AAPt_Zone == 1536) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1536-Z4-Maldraxxus-Story" and AAPt_Zone == 1670) then
		AAPt_Zone = 1536
	end
	if (AAP.ActiveMap == "1536-Z4-Maldraxxus-Story" and AAPt_Zone == 1691) then
		AAPt_Zone = 1536
	end
	if (AAP.ActiveMap == "1536-Z4-Maldraxxus-Story" and AAPt_Zone == 1671) then
		AAPt_Zone = 1536
	end
	if (AAP.ActiveMap == "1536-Z4-Maldraxxus-Story" and AAPt_Zone == 1550) then
		AAPt_Zone = 1536
	end
	if (AAP.ActiveMap == "1670-Z5-Oribos-Story" and AAPt_Zone == 1543) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1543-Z6-TheMaw-Story" and AAPt_Zone == 1670) then
		AAPt_Zone = 1543
	end
	if (AAP.ActiveMap == "1670-Z7-Oribos-Story" and AAPt_Zone == 1536) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1536-Z8-Maldraxxus-Story" and AAPt_Zone == 1670) then
		AAPt_Zone = 1536
	end
	if (AAP.ActiveMap == "1536-Z8-Maldraxxus-Story" and AAPt_Zone == 1550) then
		AAPt_Zone = 1536
	end
	if (AAP.ActiveMap == "1536-Z8-Maldraxxus-Story" and AAPt_Zone == 1671) then
		AAPt_Zone = 1536
	end
	if (AAP.ActiveMap == "1670-Z9-Oribos-Story" and AAPt_Zone == 1565) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1565-Z10-Ardenweald-Story" and AAPt_Zone == 1670) then
		AAPt_Zone = 1565
	end
	if (AAP.ActiveMap == "1565-Z10-Ardenweald-Story" and AAPt_Zone == 1824) then
		AAPt_Zone = 1565
	end
	if (AAP.ActiveMap == "1565-Z10-Ardenweald-Story" and AAPt_Zone == 1642) then
		AAPt_Zone = 1565
	end
	if (AAP.ActiveMap == "1565-Z10-Ardenweald-Story" and AAPt_Zone == 619) then
		AAPt_Zone = 1565
	end
	if (AAP.ActiveMap == "1671-Z11-Oribos-Story" and AAPt_Zone == 1525) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1525-Z12-Revendreth-Story" and AAPt_Zone == 1543) then
		AAPt_Zone = 1525
	end
	if (AAP.ActiveMap == "1543-Z13-TheMaw-Story" and AAPt_Zone == 1525) then
		AAPt_Zone = 1543
	end
	if (AAP.ActiveMap == "1543-Z13-TheMaw-Story" and AAPt_Zone == 1656) then
		AAPt_Zone = 1543
	end
	if (AAP.ActiveMap == "1525-Z14-Revendreth-Story" and AAPt_Zone == 1670) then
		AAPt_Zone = 1525
	end

	if (AAP.ActiveMap == "1670-Necrolords" and AAPt_Zone == 1670) then
		AAPt_Zone = 1536
	end
	if (AAP.ActiveMap == "1670-Venthyr" and AAPt_Zone == 1670) then
		AAPt_Zone = 1525
	end
	if (AAP.ActiveMap == "1670-NightFae" and AAPt_Zone == 1670) then
		AAPt_Zone = 1565
	end
	if (AAP.ActiveMap == "1670-Kyrian" and AAPt_Zone == 1670) then
		AAPt_Zone = 1533
	end
	
	if (AAP.ActiveMap == "1670-Z1-Oribos-StoryXBastion" and AAPt_Zone == 1533) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1670-Z1-Oribos-StoryXMaldraxxus" and AAPt_Zone == 1536) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1670-Z1-Oribos-StoryXArdenweald" and AAPt_Zone == 1565) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1670-Z1-Oribos-StoryXRevendreth" and AAPt_Zone == 1525) then
		AAPt_Zone = 1670
	end
	if (AAP.ActiveMap == "1525-Z12-Revendreth-Story" and AAPt_Zone == 1543) then
		AAPt_Zone = 1525
	end
	if (AAP.ActiveMap == "1543-Z13-TheMaw-Story" and (AAPt_Zone == 1762 or AAPt_Zone == 1656 or AAPt_Zone == 1525)) then
		AAPt_Zone = 1543
	end
	if (AAP.ActiveMap == "1670-Z1-Oribos-ZonePick" and (AAPt_Zone == 1762 or AAPt_Zone == 1656 or AAPt_Zone == 1525 or AAPt_Zone == 1543 or AAPt_Zone == 1565 or AAPt_Zone == 1533 or AAPt_Zone == 1536)) then
		AAPt_Zone = 1670
	end
	
	
	
	
	return AAPt_Zone
end
function AAP.FP.GetMeToNextZone()
	AAP.ZoneTransfer = 0
	if (AAP1["Debug"]) then
		print("Function: AAP.FP.GetMeToNextZone()")
	end
	local zeZ, Zname = AAP.FP.GetCustomZone()
	if (zeZ and Zname) then
		AAP.ActiveMap = Zname
		AAP.FP.GoToZone = zeZ
	end
	local AAPt_Zone = C_Map.GetBestMapForUnit("player")
	local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
	if (not currentMapId) then
		return
	end
	AAPt_Zone = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent+1, TOP_MOST)
	if (AAPt_Zone and AAPt_Zone["mapID"]) then
		AAPt_Zone = AAPt_Zone["mapID"]
	else
		AAPt_Zone = C_Map.GetBestMapForUnit("player")
	end
	AAPt_Zone = AAP.FP.GetMeToNextZoneSpecialRe(AAPt_Zone)
	for AAP_index,AAP_value in pairs(AAP.QuestStepListListing) do
		if (AAP.ActiveMap and AAP.QuestStepListListing[AAP_index][AAP.ActiveMap]) then
			local zerd = AAP.QuestStepListListing[AAP_index][AAP.ActiveMap]
			if (AAP.QuestStepListListingZone[zerd] and AAPt_Zone and AAP.QuestStepListListingZone[zerd] == AAPt_Zone) then
				AAP.FP.GoToZone = nil
				return
			end
		end
	end
	if (AAP.ActiveQuests and AAP.ActiveQuests[59974] and (AAP.ActiveMap == "A1670-Oribos (Maw-Maldraxxus)" or AAP.ActiveMap == "1670-Oribos (Maw-Maldraxxus)" or AAP.ActiveMap == "A1670-Z7-Oribos-Story" or AAP.ActiveMap == "1670-Z7-Oribos-Story")) then
		AAP.FP.GoToZone = nil
		return
	end
	if (AAP.ActiveMap == "84-IntroQline" and AAPt_Zone == 84) then
		AAP.FP.GoToZone = nil
		return
	end
	if (AAP.ActiveMap == "85-IntroQline" and AAPt_Zone == 85) then
		AAP.FP.GoToZone = nil
		return
	end
	if (AAP.ActiveQuests and AAP.ActiveQuests[32675] and AAPt_Zone == 84 and AAP.Faction == "Alliance") then
		AAP.ActiveMap = "A84-LearnFlying"
		AAP.FP.GoToZone = nil
		return
	end
	AAP.ZoneTransfer = 1
	AAP.BookingList["GetMeToNextZone2"] = 1
end
function AAP.FP.GetMeToNextZone2()
	if (AAP.FP.Zonening == 1) then
		return
	end
	if (not AAP.FP.GoToZone) then
		AAP.ZoneTransfer = 0
		return
	end
	if (AAP1["Debug"]) then
		print("Function: AAP.FP.GetMeToNextZone2()")
	end
	local LineNr = 0
	local AAPt_Zone = C_Map.GetBestMapForUnit("player")
	local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
	if (not currentMapId) then
		return
	end
	AAPt_Zone = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent+1, TOP_MOST)
	if (AAPt_Zone and AAPt_Zone["mapID"]) then
		AAPt_Zone = AAPt_Zone["mapID"]
	else
		AAPt_Zone = C_Map.GetBestMapForUnit("player")
	end
	AAPt_Zone = AAP.FP.GetMeToNextZoneSpecialRe(AAPt_Zone)
	local zeReal = C_Map.GetBestMapForUnit('player')
	local GoToZone = AAP.FP.GoToZone
	local CurContinent = AAP.getContinent()
	local Contin, gotoCont = AAP.FP.IsSameContinent(GoToZone)
	local mapzinfoz = C_Map.GetMapInfo(GoToZone)
	local mapzinfoz2 = C_Map.GetMapInfo(mapzinfoz.parentMapID)
	if (not mapzinfoz2) then
		return
	end
	LineNr = LineNr + 1
	local DestSet = 0
	local ShownLineNr = 0
	if (AAPt_Zone ~= GoToZone) then
		local CLi
		for CLi = 1, 10 do
			if (AAP.QuestList.QuestFrames[CLi]:IsShown()) then
				AAP.QuestList.QuestFrames[CLi]:Hide()
			end
			if (not InCombatLockdown()) then
				if (AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:IsShown()) then
					AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:Hide()
				end
				if (AAP.QuestList2["BF"..CLi]:IsShown() and AAP.SettingsOpen ~= 1) then
					AAP.QuestList2["BF"..CLi]:Hide()
				end
			end
		end
		if (AAP.Level > 35 and AAP.Level < 50) then
			if (AAP.ActiveMap and AAP.QuestStepListListing["Shadowlands"][AAP.ActiveMap]) then
				local OnTime = 0
				local ChrimeTimez = C_ChromieTime.GetChromieTimeExpansionOptions()
				for AAP_index,AAP_value in pairs(ChrimeTimez) do
					if (ChrimeTimez[AAP_index] and ChrimeTimez[AAP_index]["id"] and ChrimeTimez[AAP_index]["id"] == 9 and ChrimeTimez[AAP_index]["alreadyOn"] and ChrimeTimez[AAP_index]["alreadyOn"] == true) then
						OnTime = 1
					end
				end
				if (OnTime == 0) then
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** You are not in Chromie Time!")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					LineNr = LineNr + 1
				end
			end
		end
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Destination: "..mapzinfoz.name..", "..mapzinfoz2.name.." ("..GoToZone..")")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		DestSet = 1
	end
	if (((AAPt_Zone == 181) or (AAPt_Zone == 202) or (AAPt_Zone == 179)) and AAP.ActiveMap == "A179-Gilneas") then
		AAP.ZoneTransfer = 0
	elseif (((AAPt_Zone == 97) or (AAPt_Zone == 106)) and AAP.ActiveMap == "A106-BloodmystIsle") then
		AAP.ZoneTransfer = 0
	elseif (((AAPt_Zone == 69) or (AAPt_Zone == 64)) and AAP.ActiveMap == "A64-ThousandNeedles") then
		AAP.ZoneTransfer = 0
	elseif ((AAPt_Zone == 1536) and AAP.ActiveQuests and AAP.ActiveQuests["59974"]) then
		AAP.ZoneTransfer = 0
	elseif (((AAPt_Zone == 71) or (AAPt_Zone == 249)) and AAP.ActiveMap == "A71-Tanaris") then
		AAP.ZoneTransfer = 0
	elseif (AAP.ActiveMap == "A84-LearnFlying") then
		AAP.ZoneTransfer = 0
	elseif (zeReal == 427 and AAP.ActiveMap ~= "A27-ColdridgeValleyDwarf") then
		-- Coldridge Valley (Dwarf/gnum)
		ShownLineNr = ShownLineNr + 1
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Get To Cave")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.ArrowActive = 1
		AAP.ArrowActive_X = 117.2
		AAP.ArrowActive_Y = -6216.2
	elseif (zeReal == 28 and AAP.ActiveMap ~= "A27-ColdridgeValleyDwarf") then
		-- Coldridge Valley cave to Dun Morogh
		ShownLineNr = ShownLineNr + 1
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Exit To Cave")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.ArrowActive = 1
		AAP.ArrowActive_X = 48.9
		AAP.ArrowActive_Y = -6031.8
	elseif (zeReal == 971 and AAP.Level == 20) then
		-- Void Elf lvl20 StartZone
		ShownLineNr = ShownLineNr + 1
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Portal to Stormwind")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.ArrowActive = 1
		AAP.ArrowActive_X = 3331.6
		AAP.ArrowActive_Y = 2149.6
	elseif ((zeReal == 940 or zeReal == 941) and AAP.Level == 20) then
		-- Lightforged Draenei lvl20 StartZone
		ShownLineNr = ShownLineNr + 1
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Portal to Stormwind (down below)")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.ArrowActive = 1
		AAP.ArrowActive_X = 1469.5
		AAP.ArrowActive_Y = 499.6
	elseif (zeReal == 680 and AAP.Level == 20) then
		-- Nightborne lvl20 StartZone
		ShownLineNr = ShownLineNr + 1
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Portal to Orgrimmar")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.ArrowActive = 1
		AAP.ArrowActive_X = 3428.6
		AAP.ArrowActive_Y = 213.6
	elseif (zeReal == 652 and AAP.Level == 20) then
		-- Highmountain Tauren lvl20 StartZone
		ShownLineNr = ShownLineNr + 1
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Portal to Orgrimmar")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.ArrowActive = 1
		AAP.ArrowActive_X = 4415
		AAP.ArrowActive_Y = 4082.4
	elseif (zeReal == 1165 and AAP.Level == 20) then
		-- Zandalari Troll lvl20 StartZone
		ShownLineNr = ShownLineNr + 1
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Portal to Orgrimmar")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.ArrowActive = 1
		AAP.ArrowActive_X = 805.7
		AAP.ArrowActive_Y = -1085.1
	elseif (Contin == 0) then
		LineNr = AAP.FP.SwitchCont(CurContinent, gotoCont, GoToZone, ShownLineNr, LineNr)
	else
		if (AAPt_Zone == GoToZone) then
			AAP.FP.GoToZone = nil
			AAP.ZoneTransfer = 0
		else
			local togozo, ZefpID
			if (AAP.getContinent() and AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]) then
				togozo, ZefpID = AAP.FP.GetStarterZoneFP(GoToZone)
			end
			if (togozo ~= nil) then
				local ZeContz
				if (not AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]) then
					AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm] = {}
				end
				if (AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()] and AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]["Conts"] and AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]["Conts"][AAP.getContinent()]) then
					ZeContz = AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]["Conts"][AAP.getContinent()]
				else
					ZeContz = nil
				end
				if (not ZeContz) then
					local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Need to check FPs: "..Zefp)
						AAP.FP.QuedFP = togozo
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				else
					local zeFP = AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm][ZefpID]
					if (zeFP and zeFP == 1) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to "..togozo)
						AAP.FP.QuedFP = togozo
						AAP.QuestList.QuestFrames[LineNr]:Show()
						local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
						if (Zefp and ZeX and ZeY) then
							LineNr = LineNr + 1
							AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
							AAP.QuestList.QuestFrames[LineNr]:Show()
							AAP.ArrowActive = 1
							AAP.ArrowActive_X = ZeX
							AAP.ArrowActive_Y = ZeY
						end
					else
						local zdse, zX, zY = AAP.FP.CheckWheretoRun(GoToZone, AAPt_Zone)
						if (zdse) then
							ShownLineNr = ShownLineNr + 1
							LineNr = LineNr + 1
							local mapzinfozx = C_Map.GetMapInfo(zdse)
							AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: GoTo: "..mapzinfozx.name)
							AAP.QuestList.QuestFrames[LineNr]:Show()
							AAP.ArrowActive = 1
							AAP.ArrowActive_X = zX
							AAP.ArrowActive_Y = zY
						else
							ShownLineNr = ShownLineNr + 1
							LineNr = LineNr + 1
							AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Error: Route Not found for "..mapzinfoz.name.." ("..GoToZone..")")
							AAP.QuestList.QuestFrames[LineNr]:Show()
						end
					end
				end
			end
		end
	end
	if (AAP.ZoneTransfer == 1) then
		C_Timer.After(2, AAP.FP.GetMeToNextZone2)
	end
	if (DestSet == 1 and LineNr == 1 and AAP.SettingsOpen == 0) then
		AAP.ArrowActive = 0
		AAP.ArrowActive_X = 0
		AAP.ArrowActive_Y = 0
	end
end
function AAP.FP.CheckWheretoRun(GoToZone, AAPt_Zone)
	if (AAP.TDB["ZoneMoveOrder"][AAPt_Zone] and AAP.TDB["ZoneMoveOrder"][AAPt_Zone][GoToZone]) then
		local zdse = AAP.TDB["ZoneMoveOrder"][AAPt_Zone][GoToZone]
		if (AAP.TDB["ZoneEntry"][AAP.getContinent()] and AAP.TDB["ZoneEntry"][AAP.getContinent()][zdse]) then
			local closest = 9999
			local zeX = 0
			local zeY = 0
			local d_y, d_x = UnitPosition("player")
			for AAP_index,AAP_value in pairs(AAP.TDB["ZoneEntry"][AAP.getContinent()][zdse]) do
				local x = AAP.TDB["ZoneEntry"][AAP.getContinent()][zdse][AAP_index]["x"]
				local y = AAP.TDB["ZoneEntry"][AAP.getContinent()][zdse][AAP_index]["y"]
				local deltaX, deltaY = d_x - x, y - d_y
				local distance = (deltaX * deltaX + deltaY * deltaY)^0.5
				if (distance < closest) then
					closest = distance
					zeX = x
					zeY = y
				end
			end
			return AAP.TDB["ZoneMoveOrder"][AAPt_Zone][GoToZone], zeX, zeY
		end
	end
end
function AAP.FP.GetStarterZoneFP(GoToZone, DestCont)
	if (DestCont) then
		for AAP_index,AAP_value in pairs(AAP.TDB["FPs"][AAP.Faction][DestCont][GoToZone]) do
			if (AAP.TDB["FPs"][AAP.Faction][DestCont][GoToZone][AAP_index]["Starter"]) then
				local zclosestname
				if (AAP_Transport["FPs"] and AAP_Transport["FPs"][AAP.Faction] and AAP_Transport["FPs"][AAP.Faction][DestCont] and AAP_Transport["FPs"][AAP.Faction][DestCont]["fpn"] and AAP_Transport["FPs"][AAP.Faction][DestCont]["fpn"][AAP_index]) then
					zclosestname = AAP_Transport["FPs"][AAP.Faction][DestCont]["fpn"][AAP_index]
				else
					zclosestname = AAP.TDB["FPs"][AAP.Faction][DestCont][GoToZone][AAP_index]["name"]
				end
				return zclosestname, AAP_index
			end
		end
	elseif (GoToZone and AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()] and AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()][GoToZone]) then
		for AAP_index,AAP_value in pairs(AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()][GoToZone]) do
			if (AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()][GoToZone][AAP_index]["Starter"]) then
				local zclosestname
				if (AAP_Transport["FPs"] and AAP_Transport["FPs"][AAP.Faction] and AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()] and AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]["fpn"] and AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]["fpn"][AAP_index]) then
					zclosestname = AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]["fpn"][AAP_index]
				else
					zclosestname = AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()][GoToZone][AAP_index]["name"]
				end
				return zclosestname, AAP_index
			end
		end
	end

end
function AAP.FP.IsSameContinent(GoToZone)
	local CurContinent = AAP.getContinent()
	if (AAP.TDB["FPs"][AAP.Faction]) then
		for AAP_index,AAP_value in pairs(AAP.TDB["FPs"][AAP.Faction]) do
			for AAP_index2,AAP_value2 in pairs(AAP.TDB["FPs"][AAP.Faction][AAP_index]) do
				if (AAP_index2 == GoToZone) then
					if (CurContinent == AAP_index) then
						return 1, AAP_index
					else
						return 0, AAP_index
					end
				end
			end
		end
	end
	return "Continent not found"
end
function AAP.FP.SwitchCont(CurContinent, gotoCont, GoToZone, ShownLineNr, LineNr)
	local AAPt_Zone = C_Map.GetBestMapForUnit("player")
	local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
	AAPt_Zone = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent+1, TOP_MOST)
	if (AAPt_Zone and AAPt_Zone["mapID"]) then
		AAPt_Zone = AAPt_Zone["mapID"]
	else
		AAPt_Zone = C_Map.GetBestMapForUnit("player")
	end
	AAPt_Zone = AAP.FP.GetMeToNextZoneSpecialRe(AAPt_Zone)
	if (AAP.Faction == "Alliance") then
		if (CurContinent == 13) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Stormwind, Elwynn") then
				local d_y, d_x = UnitPosition("player")
				if (d_y < -8981.3 and d_x > 866.7) then
					if (gotoCont == 12) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Exodar portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Exodar"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Exodar"]["y"]
					elseif (gotoCont == 101) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Shattrath portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Shattrath"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Shattrath"]["y"]
					elseif (gotoCont == 113) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Dalaran, Crystalsong Forest Portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["DalaranLichKing"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["DalaranLichKing"]["y"]
					elseif (gotoCont == 424) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Jade Forest Portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["JadeForestMoP"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["JadeForestMoP"]["y"]
					elseif (gotoCont == 572) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Stormshield, Ashran Portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["StormshieldWoD"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["StormshieldWoD"]["y"]
					elseif (gotoCont == 619) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Azsuna Portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["AzsunaLegion"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["AzsunaLegion"]["y"]
					elseif (gotoCont == 875) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Boralus Portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["BoralusBFA"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["BoralusBFA"]["y"]
					elseif (gotoCont == 876) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Boralus Portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["BoralusBFA"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["BoralusBFA"]["y"]
					end
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Goto Portal Room")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["StormwindPortalRoom"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["StormwindPortalRoom"]["y"]
				end
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				local zclosestname
				if (AAP_Transport["FPs"] and AAP_Transport["FPs"][AAP.Faction] and AAP_Transport["FPs"][AAP.Faction][13] and AAP_Transport["FPs"][AAP.Faction][13]["fpn"] and AAP_Transport["FPs"][AAP.Faction][13]["fpn"][2]) then
					zclosestname = AAP_Transport["FPs"][AAP.Faction][13]["fpn"][2]
				else
					zclosestname = AAP.TDB["FPs"][AAP.Faction][13][84][2]["name"]
				end
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to "..zclosestname)
				AAP.FP.QuedFP = zclosestname
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 101) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Shattrath, Terokkar Forest") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Stormwind portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Shattrath, Terokkar Forest")
				AAP.FP.QuedFP = "Shattrath, Terokkar Forest"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 113) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Dalaran") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Stormwind portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Dalaran")
				AAP.FP.QuedFP = "Dalaran"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 1550) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Oribos") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Stormwind portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["y"]
			else
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (AAPt_Zone == 1536) then
					if (zdep == "Theater of Pain, Maldraxxus") then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Oribos portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["OribosInMaldraxxus"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["OribosInMaldraxxus"]["y"]
					else
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Theater of Pain, Maldraxxus")
						AAP.FP.QuedFP = "Theater of Pain, Maldraxxus"
						AAP.QuestList.QuestFrames[LineNr]:Show()
						local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
						if (Zefp) then
							LineNr = LineNr + 1
							AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
							AAP.QuestList.QuestFrames[LineNr]:Show()
							AAP.ArrowActive = 1
							AAP.ArrowActive_X = ZeX
							AAP.ArrowActive_Y = ZeY
						end
					end
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Oribos")
					AAP.FP.QuedFP = "Oribos"
					AAP.QuestList.QuestFrames[LineNr]:Show()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				end
			end
		elseif (CurContinent == 424) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Paw'Don Village, Jade Forest") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Stormwind portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Paw'Don Village, Jade Forest")
				AAP.FP.QuedFP = "Paw'Don Village, Jade Forest"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 572) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Stormshield (Alliance), Ashran") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Stormwind portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Stormshield (Alliance), Ashran")
				AAP.FP.QuedFP = "Stormshield (Alliance), Ashran"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 12) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "The Exodar") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Stormwind portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to The Exodar")
				AAP.FP.QuedFP = "The Exodar"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 619) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Dalaran") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Stormwind portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Dalaran")
				AAP.FP.QuedFP = "Dalaran"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 875) then
			local zdep = AAP.FP.ClosestFP()
			if (AAPt_Zone == 862) then
				if (zdep == "Xibala, Zuldazar") then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Talk to Daria Smithson")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Zuldazar"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Zuldazar"]["y"]
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Xibala, Zuldazar")
					AAP.FP.QuedFP = "Xibala, Zuldazar"
					AAP.QuestList.QuestFrames[LineNr]:Show()
					local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				end
			elseif (AAPt_Zone == 863) then
				if (zdep == "Fort Victory, Nazmir") then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Talk to Desha Stormwallow")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Nazmir"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Nazmir"]["y"]
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Fort Victory, Nazmir")
					AAP.FP.QuedFP = "Fort Victory, Nazmir"
					AAP.QuestList.QuestFrames[LineNr]:Show()
					local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				end
			elseif (AAPt_Zone == 864) then
				if (zdep == "Shatterstone Harbor, Vol'dun") then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Talk to Grand Admiral Jes-Tereth")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Vol'dun"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Vol'dun"]["y"]
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Shatterstone Harbor, Vol'dun")
					AAP.FP.QuedFP = "Shatterstone Harbor, Vol'dun"
					AAP.QuestList.QuestFrames[LineNr]:Show()
					local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				end
			end
		elseif (CurContinent == 876) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Tradewinds Market, Tiragarde Sound") then
				if (gotoCont == 875) then
					if (GoToZone == 862) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Sail to Zuldazar")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Zuldazar"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Zuldazar"]["y"]
					elseif (GoToZone == 863) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Sail to Nazmir")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Nazmir"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Nazmir"]["y"]
					elseif (GoToZone == 864) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Sail to Vol'dun")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Vol'dun"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Vol'dun"]["y"]
					end
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Stormwind portal")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Stormwind"]["y"]
				end
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Tradewinds Market, Tiragarde Sound")
				AAP.FP.QuedFP = "Tradewinds Market, Tiragarde Sound"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		end
	else
		if (CurContinent == 12) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Orgrimmar, Durotar") then
				if (gotoCont == 13) then
					if (GoToZone == 51 or GoToZone == 224 or GoToZone == 17 or GoToZone == 36) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Zeppelin to Grom'gol, Stranglethorn Vale")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["STVZep"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["STVZep"]["y"]
					else
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Undercity portal (by zeppelins)")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Undercity"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Undercity"]["y"]
					end
				elseif (gotoCont == 101) then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Shattrath portal")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Shattrath"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Shattrath"]["y"]
				elseif (gotoCont == 113) then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Dalaran, Crystalsong Forest Portal")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["DalaranLichKing"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["DalaranLichKing"]["y"]
				elseif (gotoCont == 424) then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Jade Forest Portal")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["JadeForest"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["JadeForest"]["y"]
				elseif (gotoCont == 572) then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Warspear, Ashran Portal")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["WarspearWoD"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["WarspearWoD"]["y"]
				elseif (gotoCont == 619) then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Azsuna Portal")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["AzsunaLegion"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["AzsunaLegion"]["y"]
				elseif (gotoCont == 875) then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Zuldazar Portal")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Zuldazar"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Zuldazar"]["y"]
				elseif (gotoCont == 876) then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Zuldazar Portal")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Zuldazar"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Zuldazar"]["y"]
				end
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Orgrimmar, Durotar")
				AAP.FP.QuedFP = "Orgrimmar, Durotar"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 1550) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Oribos") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Orgrimmar portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["y"]
			else
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (AAPt_Zone == 1536) then
					if (zdep == "Theater of Pain, Maldraxxus") then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Oribos portal")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["OribosInMaldraxxus"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["OribosInMaldraxxus"]["y"]
					else
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Theater of Pain, Maldraxxus")
						AAP.FP.QuedFP = "Theater of Pain, Maldraxxus"
						AAP.QuestList.QuestFrames[LineNr]:Show()
						local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
						if (Zefp) then
							LineNr = LineNr + 1
							AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
							AAP.QuestList.QuestFrames[LineNr]:Show()
							AAP.ArrowActive = 1
							AAP.ArrowActive_X = ZeX
							AAP.ArrowActive_Y = ZeY
						end
					end
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Oribos")
					AAP.FP.QuedFP = "Oribos"
					AAP.QuestList.QuestFrames[LineNr]:Show()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				end
			end
		elseif (CurContinent == 13) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Brill, Tirisfal Glades") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Orgrimmar Portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Brill, Tirisfal Glades")
				AAP.FP.QuedFP = "Brill, Tirisfal Glades"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 101) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Shattrath, Terokkar Forest") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Orgrimmar Portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Shattrath, Terokkar Forest")
				AAP.FP.QuedFP = "Shattrath, Terokkar Forest"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 113) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Dalaran") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Orgrimmar Portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Dalaran")
				AAP.FP.QuedFP = "Dalaran"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 424) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Honeydew Village, Jade Forest") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Orgrimmar Portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Honeydew Village, Jade Forest")
				AAP.FP.QuedFP = "Honeydew Village, Jade Forest"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 572) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Warspear, Ashran") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Orgrimmar Portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Warspear, Ashran")
				AAP.FP.QuedFP = "Warspear, Ashran"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 619) then
			local zdep = AAP.FP.ClosestFP()
			if (zdep == "Dalaran") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Orgrimmar Portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Dalaran")
				AAP.FP.QuedFP = "Dalaran"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 875) then
			local zdep = AAP.FP.ClosestFP()
			if (gotoCont == 876) then
				if (zdep == "Port of Zandalar, Zuldazar") then
					if (GoToZone == 896) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Sail to Drustvar")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Drustvar"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Drustvar"]["y"]
					elseif (GoToZone == 942) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Sail to Stormsong Valley")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["StormsongValley"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["StormsongValley"]["y"]
					elseif (GoToZone == 895) then
						ShownLineNr = ShownLineNr + 1
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Sail to Tiragarde Sound")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["TiragardeSound"]["x"]
						AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["TiragardeSound"]["y"]
					end
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Port of Zandalar, Zuldazar")
					AAP.FP.QuedFP = "Port of Zandalar, Zuldazar"
					AAP.QuestList.QuestFrames[LineNr]:Show()
					local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				end
			elseif (zdep == "The Great Seal") then
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Use Orgrimmar Portal")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.ArrowActive = 1
				AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["x"]
				AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["Orgrimmar"]["y"]
			else
				ShownLineNr = ShownLineNr + 1
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to The Great Seal")
				AAP.FP.QuedFP = "The Great Seal"
				AAP.QuestList.QuestFrames[LineNr]:Show()
				local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
				if (Zefp) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = ZeX
					AAP.ArrowActive_Y = ZeY
				end
			end
		elseif (CurContinent == 876) then
			local zdep = AAP.FP.ClosestFP()
			if (AAPt_Zone == 896) then
				if (zdep == "Anyport, Drustvar") then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Talk to Swellthrasher")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["DrustvarSail"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["DrustvarSail"]["y"]
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Anyport, Drustvar")
					AAP.FP.QuedFP = "Anyport, Drustvar"
					AAP.QuestList.QuestFrames[LineNr]:Show()
					local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				end
			elseif (AAPt_Zone == 942) then
				if (zdep == "Warfang Hold, Stormsong Valley") then
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Talk to Grok Seahandler")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["StormsongValleySail"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["StormsongValleySail"]["y"]
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Warfang Hold, Stormsong Valley")
					AAP.FP.QuedFP = "Warfang Hold, Stormsong Valley"
					AAP.QuestList.QuestFrames[LineNr]:Show()
					local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				end
			elseif (AAPt_Zone == 895) then
				if (zdep == "Plunder Harbor, Tiragarde Sound") then
					print("Talk to Erul Dawnbrook")
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Talk to Erul Dawnbrook")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.ArrowActive = 1
					AAP.ArrowActive_X = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["TiragardeSoundSail"]["x"]
					AAP.ArrowActive_Y = AAP.TDB["Ports"][AAP.Faction][AAP.getContinent()]["TiragardeSoundSail"]["y"]
				else
					ShownLineNr = ShownLineNr + 1
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..ShownLineNr.."]: Fly to Plunder Harbor, Tiragarde Sound")
					AAP.FP.QuedFP = "Plunder Harbor, Tiragarde Sound"
					AAP.QuestList.QuestFrames[LineNr]:Show()
					local Zefp, ZeX, ZeY = AAP.FP.ClosestFP()
					if (Zefp) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Closest FP: "..Zefp)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.ArrowActive = 1
						AAP.ArrowActive_X = ZeX
						AAP.ArrowActive_Y = ZeY
					end
				end
			end
		end
	end
	return LineNr
end
function AAP.FP.ClosestFP()
	if (AAP1["Debug"]) then
		print("Function: AAP.FP.ClosestFP()")
	end
	local testinstsance = UnitPosition("player")
	if (not testinstsance) then
		return
	end
	local AAPt_Zone = C_Map.GetBestMapForUnit("player")
	local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
	if (not currentMapId) then
		return
	end
	AAPt_Zone = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent+1, TOP_MOST)
	if (AAPt_Zone and AAPt_Zone["mapID"]) then
		AAPt_Zone = AAPt_Zone["mapID"]
	else
		AAPt_Zone = C_Map.GetBestMapForUnit("player")
	end
	AAPt_Zone = AAP.FP.GetMeToNextZoneSpecialRe(AAPt_Zone)
	if (AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()] and AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()][AAPt_Zone]) then
		local cloasest = 99999
		local closestname = "derp"
		local closestx = 0
		local closesty = 0
		local zclosestname
		for AAP_index,AAP_value in pairs(AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()][AAPt_Zone]) do
			local d_y, d_x = UnitPosition("player")
			x = AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()][AAPt_Zone][AAP_index]["x"]
			y = AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()][AAPt_Zone][AAP_index]["y"]
			if (AAP_Transport["FPs"] and AAP_Transport["FPs"][AAP.Faction] and AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()] and AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]["fpn"] and AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]["fpn"][AAP_index]) then
				zclosestname = AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]["fpn"][AAP_index]
			else
				zclosestname = AAP.TDB["FPs"][AAP.Faction][AAP.getContinent()][AAPt_Zone][AAP_index]["name"]
			end
			local deltaX, deltaY = d_x - x, y - d_y
			local distance = (deltaX * deltaX + deltaY * deltaY)^0.5
			if (cloasest > distance) then
				cloasest = distance
				closestname = zclosestname
				closestx = x
				closesty = y
			end
		end
		return closestname, closestx, closesty
	end
end

AAP_Transport_EventFrame = CreateFrame("Frame")
AAP_Transport_EventFrame:RegisterEvent ("TAXIMAP_OPENED")
AAP_Transport_EventFrame:RegisterEvent ("PLAYER_LEAVING_WORLD")
AAP_Transport_EventFrame:RegisterEvent ("PLAYER_ENTERING_WORLD")
AAP_Transport_EventFrame:SetScript("OnEvent", function(self, event, ...)
	if (event=="PLAYER_LEAVING_WORLD") then
		AAP.FP.Zonening = 1
	elseif (event=="PLAYER_ENTERING_WORLD") then
		AAP.FP.Zonening = 0
		if (AAP.ZoneTransfer == 1) then
			AAP.BookingList["GetMeToNextZone2"] = 1
		end
	elseif (event=="TAXIMAP_OPENED") then
		if (not AAP_Transport) then
			AAP_Transport = {}
		end
		if (not AAP_Transport["FPs"]) then
			AAP_Transport["FPs"] = {}
		end
		if (not AAP_Transport["FPs"][AAP.Faction]) then
			AAP_Transport["FPs"][AAP.Faction] = {}
		end
		if (not AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]) then
			AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()] = {}
		end
		if (not AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]) then
			AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm] = {}
		end
		local CLi
		if (not AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]["Conts"]) then
			AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]["Conts"] = {}
		end
		if (not AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]["fpn"]) then
			AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]["fpn"] = {}
		end
		AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]["Conts"][AAP.getContinent()] = 1
		local AAPt_Zone = C_Map.GetBestMapForUnit("player")
		local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
		if (not currentMapId) then
			return
		end
		AAPt_Zone = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent+1, TOP_MOST)
		if (AAPt_Zone and AAPt_Zone["mapID"]) then
			AAPt_Zone = AAPt_Zone["mapID"]
		else
			AAPt_Zone = C_Map.GetBestMapForUnit("player")
		end
		AAPt_Zone = AAP.FP.GetMeToNextZoneSpecialRe(AAPt_Zone)
		local ZeFPS = C_TaxiMap.GetAllTaxiNodes(AAPt_Zone)
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(ZeFPS) do
			local NodeIDZ = ZeFPS[AAP_index2]["nodeID"]
			local ZName = ZeFPS[AAP_index2]["name"]
			local ZState = ZeFPS[AAP_index2]["state"]
			AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]["fpn"][NodeIDZ] = ZName
			if (ZState == 0) then
				AAP.TaxiTimerCur = ZName
			end
			if (ZState == 2) then
				--AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm][NodeIDZ] = 0
			else
				AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm][NodeIDZ] = 1
			end
		end
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and not IsControlKeyDown() and AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoFlight"] == 1) then
			local TName = steps["Name"]
			local TContonent = AAP.getContinent()
			if (steps["UseFlightPath"]) then
				local zclosestname
				for AAP_index,AAP_value in pairs(AAP.TDB["FPs"][AAP.Faction][TContonent]) do
					for AAP_index2,AAP_value2 in pairs(AAP.TDB["FPs"][AAP.Faction][TContonent][AAP_index]) do
						if (AAP.TDB["FPs"][AAP.Faction][TContonent][AAP_index][AAP_index2]["name"] == TName) then
							
							if (AAP_Transport["FPs"] and AAP_Transport["FPs"][AAP.Faction] and AAP_Transport["FPs"][AAP.Faction][TContonent] and AAP_Transport["FPs"][AAP.Faction][TContonent]["fpn"] and AAP_Transport["FPs"][AAP.Faction][TContonent]["fpn"][AAP_index2]) then
								zclosestname = AAP_Transport["FPs"][AAP.Faction][TContonent]["fpn"][AAP_index2]
							else
								zclosestname = AAP.TDB["FPs"][AAP.Faction][TContonent][AAP_index][AAP_index2]["name"]
							end
							if (zclosestname) then
								AAP.FP.QuedFP = zclosestname
								break
							end
						end
					end
					if (zclosestname) then
						break
					end
				end
			end
		end
		
		if (AAP.FP.QuedFP and AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoFlight"] == 1) then
			local Nodetotake
			for CLi = 1, NumTaxiNodes() do
				if (TaxiNodeName(CLi) == AAP.FP.QuedFP) then
					if (steps and steps["UseFlightPath"] and TaxiNodeGetType(CLi) == "CURRENT") then
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["UpdateQuest"] = 1
						AAP.BookingList["PrintQStep"] = 1
					else
						Nodetotake = CLi
					end
					break
				end
			end
			if (Nodetotake) then
				TakeTaxiNode(Nodetotake)
				AAP.TimeFPs(AAP.TaxiTimerCur, AAP.FP.QuedFP)
				AAP.BookingList["TestTaxiFunc"] = 1
				AAP.FP.QuedFP = nil
				if (steps and steps["ETA"]) then
					AAP.AFK_Timer(steps["ETA"])
				end
			end
			if (UnitOnTaxi("player")) then
				AAP.FP.QuedFP = nil
			end
		end
	end
end)