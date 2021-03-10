local function AAP_CreateQuestList()
	if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"]) then
		AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"] = GetScreenWidth() / 2.5
	end
	if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"]) then
		AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"] = -(GetScreenHeight() / 4)
	end
	if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["MiniMapBlobAlpha"]) then
		AAP1[AAP.Realm][AAP.Name]["Settings"]["MiniMapBlobAlpha"] = 1
	end
	if (not AAP.PartyList) then
		AAP.PartyList = {}
	end
	AAP.PartyList.PartyFrame = CreateFrame("frame", "AAP_PartyListFrame1", UIParent)
	AAP.PartyList.PartyFrame:SetWidth(1)
	AAP.PartyList.PartyFrame:SetHeight(1)
	AAP.PartyList.PartyFrame:SetMovable(true)
	AAP.PartyList.PartyFrame:EnableMouse(true)
	AAP.PartyList.PartyFrame:SetFrameStrata("LOW")
	AAP.PartyList.PartyFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"])


	AAP.PartyList.PartyFrames = {}
	AAP.PartyList.PartyFrames2 = {}
	AAP.PartyList.PartyFramesFS1 = {}
	AAP.PartyList.PartyFramesFS2 = {}
	local CLi
	for CLi = 1, 5 do
		AAP.PartyList.PartyFrames[CLi] = CreateFrame("frame", "CLQaaListF"..CLi, AAP.PartyList.PartyFrame)
		AAP.PartyList.PartyFrames[CLi]:SetWidth(120)

		AAP.PartyList.PartyFrames[CLi]:SetHeight(25)
		AAP.PartyList.PartyFrames[CLi]:SetPoint("BOTTOMLEFT", AAP.PartyList.PartyFrame, "BOTTOMLEFT",40,-((25*CLi)-25))
		AAP.PartyList.PartyFrames[CLi]:Hide()
		--AAP.PartyList.PartyFrames[CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.PartyList.PartyFrames[CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.PartyList.PartyFrames[CLi])
AAP.PartyList.PartyFrames[CLi].texture = t




		AAP.PartyList.PartyFrames[CLi]:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" and AAP1[AAP.Realm][AAP.Name]["Settings"]["Lock"] == 0 then
				AAP.PartyList.PartyFrame:StartMoving();
				AAP.PartyList.PartyFrame.isMoving = true;
			end
		end)
		AAP.PartyList.PartyFrames[CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" and AAP.PartyList.PartyFrame.isMoving then
				AAP.PartyList.PartyFrame:StopMovingOrSizing();
				AAP.PartyList.PartyFrame.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"] = AAP.PartyList.PartyFrame:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"] = AAP.PartyList.PartyFrame:GetTop() - GetScreenHeight()
				--AAP.PartyList.PartyFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"])
			end
		end)
		AAP.PartyList.PartyFrames[CLi]:SetScript("OnHide", function(self)
			if ( AAP.PartyList.PartyFrame.isMoving ) then
				AAP.PartyList.PartyFrame:StopMovingOrSizing();
				AAP.PartyList.PartyFrame.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"] = AAP.PartyList.PartyFrame:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"] = AAP.PartyList.PartyFrame:GetTop() - GetScreenHeight()
				--AAP.PartyList.PartyFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"])
			end
		end)
		
		AAP.PartyList.PartyFramesFS1[CLi] = AAP.PartyList.PartyFrames[CLi]:CreateFontString("CLQaasFS1","ARTWORK", "ChatFontNormal")
		AAP.PartyList.PartyFramesFS1[CLi]:SetParent(AAP.PartyList.PartyFrames[CLi])
		AAP.PartyList.PartyFramesFS1[CLi]:SetPoint("LEFT",AAP.PartyList.PartyFrames[CLi],"LEFT",5,0)
		AAP.PartyList.PartyFramesFS1[CLi]:SetWidth(300)
		AAP.PartyList.PartyFramesFS1[CLi]:SetHeight(38)
		AAP.PartyList.PartyFramesFS1[CLi]:SetJustifyH("LEFT")
		AAP.PartyList.PartyFramesFS1[CLi]:SetFontObject("GameFontNormalLarge")
		AAP.PartyList.PartyFramesFS1[CLi]:SetText("Name")
		AAP.PartyList.PartyFramesFS1[CLi]:SetTextColor(1, 1, 0)


		AAP.PartyList.PartyFrames2[CLi] = CreateFrame("frame", "CLQaListF"..CLi, AAP.PartyList.PartyFrame)
		AAP.PartyList.PartyFrames2[CLi]:SetWidth(40)

		AAP.PartyList.PartyFrames2[CLi]:SetHeight(25)
		AAP.PartyList.PartyFrames2[CLi]:SetPoint("BOTTOMLEFT", AAP.PartyList.PartyFrame, "BOTTOMLEFT",0,-((25*CLi)-25))
		AAP.PartyList.PartyFrames2[CLi]:Hide()
		--AAP.PartyList.PartyFrames2[CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.PartyList.PartyFrames2[CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.PartyList.PartyFrames2[CLi])
AAP.PartyList.PartyFrames2[CLi].texture = t

		AAP.PartyList.PartyFrames2[CLi]:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" and AAP1[AAP.Realm][AAP.Name]["Settings"]["Lock"] == 0 then
				AAP.PartyList.PartyFrame:StartMoving();
				AAP.PartyList.PartyFrame.isMoving = true;
			end
		end)
		AAP.PartyList.PartyFrames2[CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" and AAP.PartyList.PartyFrame.isMoving then
				AAP.PartyList.PartyFrame:StopMovingOrSizing();
				AAP.PartyList.PartyFrame.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"] = AAP.PartyList.PartyFrame:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"] = AAP.PartyList.PartyFrame:GetTop() - GetScreenHeight()
				AAP.PartyList.PartyFrame:ClearAllPoints()
				AAP.PartyList.PartyFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"])
			end
		end)
		AAP.PartyList.PartyFrames2[CLi]:SetScript("OnHide", function(self)
			if ( AAP.PartyList.PartyFrame.isMoving ) then
				AAP.PartyList.PartyFrame:StopMovingOrSizing();
				AAP.PartyList.PartyFrame.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"] = AAP.PartyList.PartyFrame:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"] = AAP.PartyList.PartyFrame:GetTop() - GetScreenHeight()
				AAP.PartyList.PartyFrame:ClearAllPoints()
				AAP.PartyList.PartyFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["Partyleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["Partytop"])
			end
		end)

		AAP.PartyList.PartyFramesFS2[CLi] = AAP.PartyList.PartyFrames2[CLi]:CreateFontString("CLQaasFS1","ARTWORK", "ChatFontNormal")
		AAP.PartyList.PartyFramesFS2[CLi]:SetParent(AAP.PartyList.PartyFrames[CLi])
		AAP.PartyList.PartyFramesFS2[CLi]:SetPoint("CENTER",AAP.PartyList.PartyFrames2[CLi],"CENTER",0,0)
		AAP.PartyList.PartyFramesFS2[CLi]:SetWidth(40)
		AAP.PartyList.PartyFramesFS2[CLi]:SetHeight(38)
		AAP.PartyList.PartyFramesFS2[CLi]:SetJustifyH("CENTER")
		AAP.PartyList.PartyFramesFS2[CLi]:SetFontObject("GameFontNormalLarge")
		AAP.PartyList.PartyFramesFS2[CLi]:SetText("123")
		AAP.PartyList.PartyFramesFS2[CLi]:SetTextColor(1, 1, 0)


	end
	AAP.QuestList.SugQuestFrame = {}
	AAP.QuestList.SugQuestFrame = CreateFrame("frame", "AAP_SugQuestFrameFrame", UIParent)
	AAP.QuestList.SugQuestFrame:SetWidth(300)
	AAP.QuestList.SugQuestFrame:SetHeight(150)
	AAP.QuestList.SugQuestFrame:SetMovable(true)
	AAP.QuestList.SugQuestFrame:EnableMouse(true)
	AAP.QuestList.SugQuestFrame:SetFrameStrata("LOW")
	AAP.QuestList.SugQuestFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["Sugleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["Sugtop"])
	--AAP.QuestList.SugQuestFrame:SetBackdrop( { 
	--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
	--});
local t = AAP.QuestList.SugQuestFrame:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.QuestList.SugQuestFrame)
AAP.QuestList.SugQuestFrame.texture = t

	AAP.QuestList.SugQuestFrame:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			AAP.QuestList.SugQuestFrame:StartMoving();
			AAP.QuestList.SugQuestFrame.isMoving = true;
		end
	end)
	AAP.QuestList.SugQuestFrame:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and AAP.QuestList.SugQuestFrame.isMoving then
			AAP.QuestList.SugQuestFrame:StopMovingOrSizing();
			AAP.QuestList.SugQuestFrame.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["Sugleft"] = AAP.QuestList.SugQuestFrame:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["Sugtop"] = AAP.QuestList.SugQuestFrame:GetTop() - GetScreenHeight()
			AAP.QuestList.SugQuestFrame:ClearAllPoints()
			AAP.QuestList.SugQuestFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["Sugleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["Sugtop"])
		end
	end)
	AAP.QuestList.SugQuestFrame:SetScript("OnHide", function(self)
		if ( AAP.QuestList.SugQuestFrame.isMoving ) then
			AAP.QuestList.SugQuestFrame:StopMovingOrSizing();
			AAP.QuestList.SugQuestFrame.isMoving = false;
		end
	end)
	AAP.QuestList.SugQuestFrame:Hide()

	AAP.QuestList.SugQuestFrameFS1 = AAP.QuestList.SugQuestFrame:CreateFontString("CLQaaFS1","ARTWORK", "ChatFontNormal")
	AAP.QuestList.SugQuestFrameFS1:SetParent(AAP.QuestList.SugQuestFrame)
	AAP.QuestList.SugQuestFrameFS1:SetPoint("TOPLEFT",AAP.QuestList.SugQuestFrame,"TOPLEFT",0,0)
	AAP.QuestList.SugQuestFrameFS1:SetWidth(300)
	AAP.QuestList.SugQuestFrameFS1:SetHeight(38)
	AAP.QuestList.SugQuestFrameFS1:SetJustifyH("CENTER")
	AAP.QuestList.SugQuestFrameFS1:SetFontObject("GameFontNormalLarge")
	AAP.QuestList.SugQuestFrameFS1:SetText("Quests Text")
	AAP.QuestList.SugQuestFrameFS1:SetTextColor(1, 1, 0)
	AAP.QuestList.SugQuestFrameFS2 = AAP.QuestList.SugQuestFrame:CreateFontString("CLQaaFS2","ARTWORK", "ChatFontNormal")
	AAP.QuestList.SugQuestFrameFS2:SetParent(AAP.QuestList.SugQuestFrame)
	AAP.QuestList.SugQuestFrameFS2:SetPoint("TOPLEFT",AAP.QuestList.SugQuestFrame,"TOPLEFT",0,-30)
	AAP.QuestList.SugQuestFrameFS2:SetWidth(300)
	AAP.QuestList.SugQuestFrameFS2:SetHeight(38)
	AAP.QuestList.SugQuestFrameFS2:SetJustifyH("CENTER")
	AAP.QuestList.SugQuestFrameFS2:SetFontObject("GameFontNormalLarge")
	AAP.QuestList.SugQuestFrameFS2:SetText(AAP_Locals["Suggested Players"]..": ")
	AAP.QuestList.SugQuestFrameFS2:SetTextColor(1, 1, 0)

	AAP.QuestList.SugQuestFrame["Button1"] = CreateFrame("Button", "AAP_SBX1", UIParent, "SecureActionButtonTemplate")
	AAP.QuestList.SugQuestFrame["Button1"]:SetPoint("BOTTOMLEFT",AAP.QuestList.SugQuestFrame,"BOTTOMLEFT",15,5)
	AAP.QuestList.SugQuestFrame["Button1"]:SetWidth(110)
	AAP.QuestList.SugQuestFrame["Button1"]:SetHeight(30)
	AAP.QuestList.SugQuestFrame["Button1"]:SetText(AAP_Locals["Accept Quest"])
	AAP.QuestList.SugQuestFrame["Button1"]:SetParent(AAP.QuestList.SugQuestFrame)
	AAP.QuestList.SugQuestFrame.Button1:SetNormalFontObject("GameFontNormal")
	AAP.QuestList.SugQuestFrame.Button1ntex = AAP.QuestList.SugQuestFrame.Button1:CreateTexture()
	AAP.QuestList.SugQuestFrame.Button1ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
	AAP.QuestList.SugQuestFrame.Button1ntex:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.QuestList.SugQuestFrame.Button1ntex:SetAllPoints()	
	AAP.QuestList.SugQuestFrame.Button1:SetNormalTexture(AAP.QuestList.SugQuestFrame.Button1ntex)
	AAP.QuestList.SugQuestFrame.Button1htex = AAP.QuestList.SugQuestFrame.Button1:CreateTexture()
	AAP.QuestList.SugQuestFrame.Button1htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	AAP.QuestList.SugQuestFrame.Button1htex:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.QuestList.SugQuestFrame.Button1htex:SetAllPoints()
	AAP.QuestList.SugQuestFrame.Button1:SetHighlightTexture(AAP.QuestList.SugQuestFrame.Button1htex)
	AAP.QuestList.SugQuestFrame.Button1ptex = AAP.QuestList.SugQuestFrame.Button1:CreateTexture()
	AAP.QuestList.SugQuestFrame.Button1ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
	AAP.QuestList.SugQuestFrame.Button1ptex:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.QuestList.SugQuestFrame.Button1ptex:SetAllPoints()
	AAP.QuestList.SugQuestFrame.Button1:SetPushedTexture(AAP.QuestList.SugQuestFrame.Button1ptex)
	AAP.QuestList.SugQuestFrame["Button1"]:SetScript("OnClick", function(self, arg1)
		AAP.QAskPopWantedAsk("yes")
	end)
	AAP.QuestList.SugQuestFrame["Button2"] = CreateFrame("Button", "AAP_SBX2", UIParent, "SecureActionButtonTemplate")
	AAP.QuestList.SugQuestFrame["Button2"]:SetPoint("BOTTOMRIGHT",AAP.QuestList.SugQuestFrame,"BOTTOMRIGHT",-15,5)
	AAP.QuestList.SugQuestFrame["Button2"]:SetWidth(110)
	AAP.QuestList.SugQuestFrame["Button2"]:SetHeight(30)
	AAP.QuestList.SugQuestFrame["Button2"]:SetText(AAP_Locals["Decline Quest"])
	AAP.QuestList.SugQuestFrame["Button2"]:SetParent(AAP.QuestList.SugQuestFrame)
	AAP.QuestList.SugQuestFrame.Button2:SetNormalFontObject("GameFontNormal")
	AAP.QuestList.SugQuestFrame.Button2ntex = AAP.QuestList.SugQuestFrame.Button2:CreateTexture()
	AAP.QuestList.SugQuestFrame.Button2ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
	AAP.QuestList.SugQuestFrame.Button2ntex:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.QuestList.SugQuestFrame.Button2ntex:SetAllPoints()	
	AAP.QuestList.SugQuestFrame.Button2:SetNormalTexture(AAP.QuestList.SugQuestFrame.Button2ntex)
	AAP.QuestList.SugQuestFrame.Button2htex = AAP.QuestList.SugQuestFrame.Button2:CreateTexture()
	AAP.QuestList.SugQuestFrame.Button2htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	AAP.QuestList.SugQuestFrame.Button2htex:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.QuestList.SugQuestFrame.Button2htex:SetAllPoints()
	AAP.QuestList.SugQuestFrame.Button2:SetHighlightTexture(AAP.QuestList.SugQuestFrame.Button2htex)
	AAP.QuestList.SugQuestFrame.Button2ptex = AAP.QuestList.SugQuestFrame.Button2:CreateTexture()
	AAP.QuestList.SugQuestFrame.Button2ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
	AAP.QuestList.SugQuestFrame.Button2ptex:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.QuestList.SugQuestFrame.Button2ptex:SetAllPoints()
	AAP.QuestList.SugQuestFrame.Button2:SetPushedTexture(AAP.QuestList.SugQuestFrame.Button2ptex)
	AAP.QuestList.SugQuestFrame["Button2"]:SetScript("OnClick", function(self, arg1)
		AAP.QAskPopWantedAsk("no")
	end)
	AAP.QuestList.Greetings = CreateFrame("frame", "AAP_GreetingsFrame", UIParent)
	AAP.QuestList.Greetings:SetWidth(330)
	AAP.QuestList.Greetings:SetHeight(200)
	AAP.QuestList.Greetings:SetMovable(true)
	AAP.QuestList.Greetings:EnableMouse(true)
	AAP.QuestList.Greetings:SetFrameStrata("LOW")
	AAP.QuestList.Greetings:SetPoint("LEFT", UIParent, "LEFT", 300, 0)
	--AAP.QuestList.Greetings:SetBackdrop( { 
	--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
	--});
local t = AAP.QuestList.Greetings:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.QuestList.Greetings)
AAP.QuestList.Greetings.texture = t

	AAP.QuestList.Greetings:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			AAP.QuestList.Greetings:StartMoving();
			AAP.QuestList.Greetings.isMoving = true;
		end
	end)
	AAP.QuestList.Greetings:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and AAP.QuestList.Greetings.isMoving then
			AAP.QuestList.Greetings:StopMovingOrSizing();
			AAP.QuestList.Greetings.isMoving = false;
		end
	end)
	AAP.QuestList.Greetings:SetScript("OnHide", function(self)
		if ( AAP.QuestList.Greetings.isMoving ) then
			AAP.QuestList.Greetings:StopMovingOrSizing();
			AAP.QuestList.Greetings.isMoving = false;
		end
	end)
	AAP.QuestList.Greetings2FS1 = AAP.QuestList.Greetings:CreateFontString("AAPGreetingsFS1","ARTWORK", "ChatFontNormal")
	AAP.QuestList.Greetings2FS1:SetParent(AAP.QuestList.Greetings)
	AAP.QuestList.Greetings2FS1:SetPoint("TOP",AAP.QuestList.Greetings,"TOP",0,0)
	AAP.QuestList.Greetings2FS1:SetWidth(300)
	AAP.QuestList.Greetings2FS1:SetHeight(38)
	AAP.QuestList.Greetings2FS1:SetJustifyH("LEFT")
	AAP.QuestList.Greetings2FS1:SetFontObject("GameFontNormal")
	AAP.QuestList.Greetings2FS1:SetText("Welcome to Azeroth Auto Pilot")
	AAP.QuestList.Greetings2FS1:SetTextColor(1, 1, 0)

	AAP.QuestList.Greetings2FS221 = AAP.QuestList.Greetings:CreateFontString("AAPGreetingsFS221","ARTWORK", "ChatFontNormal")
	AAP.QuestList.Greetings2FS221:SetParent(AAP.QuestList.Greetings)
	AAP.QuestList.Greetings2FS221:SetPoint("TOP",AAP.QuestList.Greetings,"TOP",0,-8)
	AAP.QuestList.Greetings2FS221:SetWidth(290)
	AAP.QuestList.Greetings2FS221:SetHeight(72)
	AAP.QuestList.Greetings2FS221:SetJustifyH("LEFT")
	AAP.QuestList.Greetings2FS221:SetFontObject("GameFontNormal")
	AAP.QuestList.Greetings2FS221:SetText("Require 5+ Goblin Glider kits.")
	AAP.QuestList.Greetings2FS221:SetTextColor(1, 1, 0)

	AAP.QuestList.Greetings2FS2 = AAP.QuestList.Greetings:CreateFontString("AAPGreetingsFS2","ARTWORK", "ChatFontNormal")
	AAP.QuestList.Greetings2FS2:SetParent(AAP.QuestList.Greetings)
	AAP.QuestList.Greetings2FS2:SetPoint("TOP",AAP.QuestList.Greetings,"TOP",0,-38)
	AAP.QuestList.Greetings2FS2:SetWidth(290)
	AAP.QuestList.Greetings2FS2:SetHeight(72)
	AAP.QuestList.Greetings2FS2:SetJustifyH("LEFT")
	AAP.QuestList.Greetings2FS2:SetFontObject("GameFontNormal")
	AAP.QuestList.Greetings2FS2:SetText("Special thanks to BrutallStatic for helping with 50-60, catch him at:")
	AAP.QuestList.Greetings2FS2:SetTextColor(1, 1, 0)

	AAP.QuestList.Greetings2EB1 = CreateFrame("EditBox", "AAPGreetEBox", AAP.QuestList.Greetings, "InputBoxTemplate")
	AAP.QuestList.Greetings2EB1:SetSize(200, 20)
	AAP.QuestList.Greetings2EB1:SetPoint("TOP",AAP.QuestList.Greetings,"TOP",0,-88)
	AAP.QuestList.Greetings2EB1:SetAutoFocus(false)
	AAP.QuestList.Greetings2EB1:SetText("www.twitch.tv/brutallstatic")
	AAP.QuestList.Greetings2EB1:SetCursorPosition(0)
	
	AAP.QuestList.Greetings2FS3 = AAP.QuestList.Greetings:CreateFontString("AAPGreetingsFS3","ARTWORK", "ChatFontNormal")
	AAP.QuestList.Greetings2FS3:SetParent(AAP.QuestList.Greetings)
	AAP.QuestList.Greetings2FS3:SetPoint("TOP",AAP.QuestList.Greetings,"TOP",0,-98)
	AAP.QuestList.Greetings2FS3:SetWidth(290)
	AAP.QuestList.Greetings2FS3:SetHeight(72)
	AAP.QuestList.Greetings2FS3:SetJustifyH("LEFT")
	AAP.QuestList.Greetings2FS3:SetFontObject("GameFontNormal")
	AAP.QuestList.Greetings2FS3:SetText("Special thanks to DesMephisto for helping with route for 1-50, catch him at:")
	AAP.QuestList.Greetings2FS3:SetTextColor(1, 1, 0)

	AAP.QuestList.Greetings2EB2 = CreateFrame("EditBox", "AAPGreetEBox2", AAP.QuestList.Greetings, "InputBoxTemplate")
	AAP.QuestList.Greetings2EB2:SetSize(200, 20)
	AAP.QuestList.Greetings2EB2:SetPoint("TOP",AAP.QuestList.Greetings,"TOP",0,-148)
	AAP.QuestList.Greetings2EB2:SetAutoFocus(false)
	AAP.QuestList.Greetings2EB2:SetText("www.twitch.tv/desmephisto")

	AAP.QuestList.GreetingsHideB = CreateFrame("Button", "AAP_GreetingsHideB", AAP.QuestList.Greetings, "SecureActionButtonTemplate")
	AAP.QuestList.GreetingsHideB:SetPoint("BOTTOMRIGHT",AAP.QuestList.Greetings,"BOTTOMRIGHT",-15,5)
	AAP.QuestList.GreetingsHideB:SetWidth(90)
	AAP.QuestList.GreetingsHideB:SetHeight(22)
	AAP.QuestList.GreetingsHideB:SetText("Close")
	AAP.QuestList.GreetingsHideB:SetParent(AAP.QuestList.Greetings)
	AAP.QuestList.GreetingsHideB:SetNormalFontObject("GameFontNormalLarge")
	AAP.QuestList.GreetingsHideBntex = AAP.QuestList.GreetingsHideB:CreateTexture()
	AAP.QuestList.GreetingsHideBntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
	AAP.QuestList.GreetingsHideBntex:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.QuestList.GreetingsHideBntex:SetAllPoints()	
	AAP.QuestList.GreetingsHideB:SetNormalTexture(AAP.QuestList.GreetingsHideBntex)
	AAP.QuestList.GreetingsHideBhtex = AAP.QuestList.GreetingsHideB:CreateTexture()
	AAP.QuestList.GreetingsHideBhtex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	AAP.QuestList.GreetingsHideBhtex:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.QuestList.GreetingsHideBhtex:SetAllPoints()
	AAP.QuestList.GreetingsHideB:SetHighlightTexture(AAP.QuestList.GreetingsHideBhtex)
	AAP.QuestList.GreetingsHideBptex = AAP.QuestList.GreetingsHideB:CreateTexture()
	AAP.QuestList.GreetingsHideBptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
	AAP.QuestList.GreetingsHideBptex:SetTexCoord(0, 0.625, 0, 0.6875)
	AAP.QuestList.GreetingsHideBptex:SetAllPoints()
	AAP.QuestList.GreetingsHideB:SetPushedTexture(AAP.QuestList.GreetingsHideBptex)
	AAP.QuestList.GreetingsHideB:SetScript("OnClick", function(self, arg1)
		AAP1[AAP.Realm][AAP.Name]["Settings"]["Greetings2"] = 1
		AAP.QuestList.Greetings:Hide()
	end)
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["Greetings2"] == 1) then
		AAP.QuestList.Greetings:Hide()
	end
	
	
	AAP.QuestList.MainFrame = CreateFrame("frame", "AAP_QuestFrame", UIParent)
	AAP.QuestList.MainFrame:SetWidth(1)
	AAP.QuestList.MainFrame:SetHeight(1)
	AAP.QuestList.MainFrame:SetMovable(true)
	AAP.QuestList.MainFrame:EnableMouse(true)
	AAP.QuestList.MainFrame:SetFrameStrata("MEDIUM")
	AAP.QuestList.MainFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
	AAP.QuestList.ListFrame = CreateFrame("frame", "AAP_QuestFrameList", UIParent)
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] > 6) then
		AAP1[AAP.Realm][AAP.Name]["Settings"]["left"] = 150
		AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] = -150
		AAP.QuestList.MainFrame:ClearAllPoints()
		AAP.QuestList.MainFrame:SetPoint("TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
		print("AAP: QuestList Out of screen, resetting!")
	end
	AAP.QuestList.ListFrame:SetWidth(1)
	AAP.QuestList.ListFrame:SetHeight(1)
	AAP.QuestList.ListFrame:SetFrameStrata("MEDIUM")
	AAP.QuestList.ListFrame:SetPoint("TOPLEFT", AAP.QuestList.MainFrame, "TOPLEFT",0,0)
	AAP.QuestList.ListFrame:SetMovable(true)
	AAP.QuestList.ListFrame:EnableMouse(true)
	AAP.QuestList.ListFrame:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" and not AAP.QuestList.MainFrame.isMoving and AAP1[AAP.Realm][AAP.Name]["Settings"]["Lock"] == 0 then
			AAP.QuestList.MainFrame:StartMoving();
			AAP.QuestList.MainFrame.isMoving = true;
		end
	end)
	AAP.QuestList.ListFrame:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and AAP.QuestList.MainFrame.isMoving then
			AAP.QuestList.MainFrame:StopMovingOrSizing();
			AAP.QuestList.MainFrame.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["left"] = AAP.QuestList.MainFrame:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] = AAP.QuestList.MainFrame:GetTop() - GetScreenHeight()
			AAP.QuestList.MainFrame:ClearAllPoints()
			AAP.QuestList.MainFrame:SetPoint("TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] > 6) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["left"] = 150
				AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] = -150
				AAP.QuestList.MainFrame:ClearAllPoints()
				AAP.QuestList.MainFrame:SetPoint("TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
				print("AAP: QuestList Out of screen, resetting!")
			end
			AAP_CombatTestVar = 1
		end
	end)
	AAP.QuestList.ListFrame:SetScript("OnHide", function(self)
		if ( AAP.QuestList.MainFrame.isMoving ) then
			AAP.QuestList.MainFrame:StopMovingOrSizing();
			AAP.QuestList.MainFrame.isMoving = false;
		end
	end)


	AAP.QuestList20 = CreateFrame("frame", "AAP_QuestFrame20", UIParent)
	AAP.QuestList20:SetWidth(1)
	AAP.QuestList20:SetHeight(1)
	AAP.QuestList20:SetFrameStrata("MEDIUM")
	AAP.QuestList20:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])

	AAP.QuestList21 = CreateFrame("frame", "AAP_QuestFrame21", UIParent)
	AAP.QuestList21:SetWidth(1)
	AAP.QuestList21:SetHeight(1)
	AAP.QuestList21:SetFrameStrata("MEDIUM")
	AAP.QuestList21:SetPoint("TOPLEFT", AAP.QuestList20, "TOPLEFT",0,0)

	AAP.QuestList.ButtonParent = CreateFrame("frame", "CLQListFddd", UIParent)
	AAP.QuestList.ButtonParent:SetScale(AAP1[AAP.Realm][AAP.Name]["Settings"]["Scale"])
	AAP.QuestList.QuestFrames = {}
	AAP.QuestList2 = {}

	AAP.QuestList.QuestFrames["MyProgress"] = CreateFrame("frame", "CLQListMyProgress", AAP.QuestList.ListFrame)
	AAP.QuestList.QuestFrames["MyProgress"]:SetWidth(150)
	AAP.QuestList.QuestFrames["MyProgress"]:SetHeight(22)
	AAP.QuestList.QuestFrames["MyProgress"]:SetPoint("BOTTOMLEFT", AAP.QuestList.ListFrame, "BOTTOMLEFT",0,0)
	--AAP.QuestList.QuestFrames["MyProgress"]:SetBackdrop( { 
	--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
	--});
local t = AAP.QuestList.QuestFrames["MyProgress"]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.QuestList.QuestFrames["MyProgress"])
AAP.QuestList.QuestFrames["MyProgress"].texture = t

	AAP.QuestList.QuestFrames["MyProgress"]:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" and not AAP.QuestList.MainFrame.isMoving and AAP1[AAP.Realm][AAP.Name]["Settings"]["Lock"] == 0 then
			AAP.QuestList.MainFrame:StartMoving();
			AAP.QuestList.MainFrame.isMoving = true;
		end
	end)
	AAP.QuestList.QuestFrames["MyProgress"]:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and AAP.QuestList.MainFrame.isMoving then
			AAP.QuestList.MainFrame:StopMovingOrSizing();
			AAP.QuestList.MainFrame.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["left"] = AAP.QuestList.MainFrame:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] = AAP.QuestList.MainFrame:GetTop() - GetScreenHeight()
			AAP.QuestList.MainFrame:ClearAllPoints()
			AAP.QuestList.MainFrame:SetPoint("TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] > 6) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["left"] = 150
				AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] = -150
				AAP.QuestList.MainFrame:ClearAllPoints()
				AAP.QuestList.MainFrame:SetPoint("TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
				print("AAP: QuestList Out of screen, resetting!")
			end
			AAP_CombatTestVar = 1
		end
	end)
	AAP.QuestList.QuestFrames["MyProgress"]:SetScript("OnHide", function(self)
		if ( AAP.QuestList.MainFrame.isMoving ) then
			AAP.QuestList.MainFrame:StopMovingOrSizing();
			AAP.QuestList.MainFrame.isMoving = false;
		end
	end)
	
	
	AAP.QuestList.QuestFrames["MyProgressFS"] = AAP.QuestList.ListFrame:CreateFontString("CLQFSProgR","ARTWORK", "ChatFontNormal")
	AAP.QuestList.QuestFrames["MyProgressFS"]:SetParent(AAP.QuestList.QuestFrames["MyProgress"])
	AAP.QuestList.QuestFrames["MyProgressFS"]:SetPoint("BOTTOMLEFT",AAP.QuestList.QuestFrames["MyProgress"],"BOTTOMLEFT",0,2)
	AAP.QuestList.QuestFrames["MyProgressFS"]:SetWidth(150)
	AAP.QuestList.QuestFrames["MyProgressFS"]:SetHeight(18)
	AAP.QuestList.QuestFrames["MyProgressFS"]:SetJustifyH("CENTER")
	AAP.QuestList.QuestFrames["MyProgressFS"]:SetFontObject("GameFontNormalSmall")
	AAP.QuestList.QuestFrames["MyProgressFS"]:SetText("")
	AAP.QuestList.QuestFrames["MyProgressFS"]:SetTextColor(1, 1, 0)
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 0) then
		AAP.QuestList.QuestFrames["MyProgress"]:Hide()
	end
	local CLi
	for CLi = 1, 20 do
	
		AAP["Icons"][CLi] = CreateFrame("Frame",nil,UIParent)
		AAP["Icons"][CLi]:SetFrameStrata("HIGH")
		AAP["Icons"][CLi]:SetWidth(5)
		AAP["Icons"][CLi]:SetHeight(5)
		local t = 	AAP["Icons"][CLi]:CreateTexture(nil,"HIGH")
		t:SetTexture("Interface\\Addons\\AAP-Core\\Img\\Icon.blp")
		t:SetAllPoints(AAP["Icons"][CLi])
		AAP["Icons"][CLi].texture = t
		AAP["Icons"][CLi]:SetPoint("CENTER",0,0)
		AAP["Icons"][CLi]:Hide()
		AAP["Icons"][CLi].P = 0
		AAP["Icons"][CLi].A = 0
		AAP["Icons"][CLi].D = 0
		AAP["Icons"][CLi].texture:SetAlpha(AAP1[AAP.Realm][AAP.Name]["Settings"]["MiniMapBlobAlpha"])

		AAP["MapIcons"][CLi] = CreateFrame("Frame",nil,UIParent)
		AAP["MapIcons"][CLi]:SetFrameStrata("HIGH")
		AAP["MapIcons"][CLi]:SetWidth(5)
		AAP["MapIcons"][CLi]:SetHeight(5)
		local t = 	AAP["MapIcons"][CLi]:CreateTexture(nil,"HIGH")
		t:SetTexture("Interface\\Addons\\AAP-Core\\Img\\Icon.blp")
		t:SetAllPoints(AAP["MapIcons"][CLi])
		AAP["MapIcons"][CLi].texture = t
		AAP["MapIcons"][CLi]:SetPoint("CENTER",0,0)
		AAP["MapIcons"][CLi]:Hide()
		AAP["MapIcons"][CLi].P = 0
		AAP["MapIcons"][CLi].A = 0
		AAP["MapIcons"][CLi].D = 0
		
		AAP.QuestList.QuestFrames[CLi] = CreateFrame("frame", "CLQListF"..CLi, AAP.QuestList.ListFrame)
		AAP.QuestList.QuestFrames[CLi]:SetWidth(410)

		AAP.QuestList.QuestFrames[CLi]:SetHeight(38)
		AAP.QuestList.QuestFrames[CLi]:SetPoint("BOTTOMLEFT", AAP.QuestList.ListFrame, "BOTTOMLEFT",0,-((CLi * 38)+CLi))
		--AAP.QuestList.QuestFrames[CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.QuestList.QuestFrames[CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.QuestList.QuestFrames[CLi])
AAP.QuestList.QuestFrames[CLi].texture = t

		AAP.QuestList.QuestFrames[CLi]:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" and not AAP.QuestList.MainFrame.isMoving and AAP1[AAP.Realm][AAP.Name]["Settings"]["Lock"] == 0 then
				AAP.QuestList.MainFrame:StartMoving();
				AAP.QuestList.MainFrame.isMoving = true;
			end
		end)
		AAP.QuestList.QuestFrames[CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" and AAP.QuestList.MainFrame.isMoving then
				AAP.QuestList.MainFrame:StopMovingOrSizing();
				AAP.QuestList.MainFrame.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["left"] = AAP.QuestList.MainFrame:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] = AAP.QuestList.MainFrame:GetTop() - GetScreenHeight()
				AAP.QuestList.MainFrame:ClearAllPoints()
				AAP.QuestList.MainFrame:SetPoint("TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] > 6) then
					AAP1[AAP.Realm][AAP.Name]["Settings"]["left"] = 150
					AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] = -150
					AAP.QuestList.MainFrame:ClearAllPoints()
					AAP.QuestList.MainFrame:SetPoint("TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
					print("AAP: QuestList Out of screen, resetting!")
				end
				AAP_CombatTestVar = 1
			end
		end)
		AAP.QuestList.QuestFrames[CLi]:SetScript("OnHide", function(self)
			if ( AAP.QuestList.MainFrame.isMoving ) then
				AAP.QuestList.MainFrame:StopMovingOrSizing();
				AAP.QuestList.MainFrame.isMoving = false;
			end
		end)
		AAP.QuestList.QuestFrames[CLi]:Hide()
		AAP.QuestList.QuestFrames["FS"..CLi] = AAP.QuestList.ListFrame:CreateFontString("CLQFS"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.QuestList.QuestFrames["FS"..CLi]:SetParent(AAP.QuestList.QuestFrames[CLi])
		AAP.QuestList.QuestFrames["FS"..CLi]:SetPoint("TOPLEFT",AAP.QuestList.QuestFrames[CLi],"TOPLEFT",5,0)
		AAP.QuestList.QuestFrames["FS"..CLi]:SetWidth(800)
		AAP.QuestList.QuestFrames["FS"..CLi]:SetHeight(38)
		AAP.QuestList.QuestFrames["FS"..CLi]:SetJustifyH("LEFT")
		AAP.QuestList.QuestFrames["FS"..CLi]:SetFontObject("GameFontNormalLarge")
		AAP.QuestList.QuestFrames["FS"..CLi]:SetText("")
		AAP.QuestList.QuestFrames["FS"..CLi]:SetTextColor(1, 1, 0)

		AAP.QuestList.QuestFrames["FS"..CLi]["BQid"] = 0
		AAP.QuestList.QuestFrames["FS"..CLi]["Button"] = CreateFrame("Button", "AAP_SkipActiveButton"..CLi, AAP.QuestList.QuestFrames[CLi])
		AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:SetWidth(43)
		AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:SetHeight(17)
		AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:SetPoint("RIGHT", AAP.QuestList.QuestFrames[CLi], "RIGHT", -4, 0)
		AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:SetScript("OnMouseDown", function(self, button)
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			if (AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
				local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
				if (steps and steps["UseDalaHS"]) then
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["PrintQStep"] = 1
					AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:Hide()
				else
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["PrintQStep"] = 1
					AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:Hide()
				end
			end
		end)
		--AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:SetBackdrop( { 
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.QuestList.QuestFrames["FS"..CLi]["Button"])
AAP.QuestList.QuestFrames["FS"..CLi]["Button"].texture = t

		AAP.QuestList.QuestFrames["FS"..CLi]["Fontstring1"] = AAP.ArrowFrame:CreateFontString("CLSettingsFS2212","ARTWORK", "ChatFontNormal")
		AAP.QuestList.QuestFrames["FS"..CLi]["Fontstring1"]:SetParent(AAP.QuestList.QuestFrames["FS"..CLi]["Button"])
		AAP.QuestList.QuestFrames["FS"..CLi]["Fontstring1"]:SetPoint("CENTER", AAP.QuestList.QuestFrames["FS"..CLi]["Button"], "CENTER", 0, 0)
		AAP.QuestList.QuestFrames["FS"..CLi]["Fontstring1"]:SetWidth(43)
		AAP.QuestList.QuestFrames["FS"..CLi]["Fontstring1"]:SetHeight(14)
		AAP.QuestList.QuestFrames["FS"..CLi]["Fontstring1"]:SetFontObject("GameFontNormalLarge")
		AAP.QuestList.QuestFrames["FS"..CLi]["Fontstring1"]:SetText("Skip")
		AAP.QuestList.QuestFrames["FS"..CLi]["Fontstring1"]:SetTextColor(1, 1, 0)
		AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:Hide()


		AAP.QuestList2["BF"..CLi] = CreateFrame("frame", "CLQListF2z"..CLi, AAP.QuestList21)
		AAP.QuestList2["BF"..CLi]:SetWidth(410)
		AAP.QuestList2["BF"..CLi]:SetHeight(38)
		AAP.QuestList2["BF"..CLi]:SetPoint("BOTTOMLEFT", AAP.QuestList21, "BOTTOMLEFT",0,0)

		AAP.QuestList2["BF"..CLi]:Hide()
		AAP.QuestList2["BF"..CLi]:SetParent(AAP.QuestList.ButtonParent)
		AAP.QuestList2["BF"..CLi]["AAP_Button"] = CreateFrame("Button", "AAP_SBX"..CLi, AAP.QuestList2["BF"..CLi], "SecureActionButtonTemplate")
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetWidth(38)
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetHeight(38)
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetText("X")
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetPoint("LEFT",AAP.QuestList2["BF"..CLi],"RIGHT",0,0)
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetNormalFontObject("GameFontNormalLarge")
		AAP.QuestList2["BF"..CLi]["AAP_Buttonntex"] = AAP.QuestList2["BF"..CLi]["AAP_Button"]:CreateTexture()
		AAP.QuestList2["BF"..CLi]["AAP_Buttonntex"]:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
		AAP.QuestList2["BF"..CLi]["AAP_Buttonntex"]:SetTexCoord(0, 0.625, 0, 0.6875)
		AAP.QuestList2["BF"..CLi]["AAP_Buttonntex"]:SetAllPoints()	
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetNormalTexture("Interface/Buttons/UI-Panel-Button-Highlight")
		AAP.QuestList2["BF"..CLi]["AAP_Buttonhtex"] = AAP.QuestList2["BF"..CLi]["AAP_Button"]:CreateTexture()
		AAP.QuestList2["BF"..CLi]["AAP_Buttonhtex"]:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
		AAP.QuestList2["BF"..CLi]["AAP_Buttonhtex"]:SetTexCoord(0, 0.625, 0, 0.6875)
		AAP.QuestList2["BF"..CLi]["AAP_Buttonhtex"]:SetAllPoints()
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetHighlightTexture(AAP.QuestList2["BF"..CLi]["AAP_Buttonhtex"])
		AAP.QuestList2["BF"..CLi]["AAP_Buttonptex"] = AAP.QuestList2["BF"..CLi]["AAP_Button"]:CreateTexture()
		AAP.QuestList2["BF"..CLi]["AAP_Buttonptex"]:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
		AAP.QuestList2["BF"..CLi]["AAP_Buttonptex"]:SetTexCoord(0, 0.625, 0, 0.6875)
		AAP.QuestList2["BF"..CLi]["AAP_Buttonptex"]:SetAllPoints()
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetPushedTexture(AAP.QuestList2["BF"..CLi]["AAP_Buttonptex"])
		AAP.QuestList2["BF"..CLi]["AAP_ButtonCD"] = CreateFrame("Cooldown", "AAP_Cooldown"..CLi, AAP.QuestList2["BF"..CLi]["AAP_Button"], "CooldownFrameTemplate")
		AAP.QuestList2["BF"..CLi]["AAP_ButtonCD"]:SetAllPoints()



	end
	
	

	AAP.QuestList.SweatOfOurBrowBuffFrame = CreateFrame("frame", "AAP_SugQuestFrameFramebufffra", UIParent)
	AAP.QuestList.SweatOfOurBrowBuffFrame:SetWidth(230)
	AAP.QuestList.SweatOfOurBrowBuffFrame:SetHeight(110)
	AAP.QuestList.SweatOfOurBrowBuffFrame:SetMovable(true)
	AAP.QuestList.SweatOfOurBrowBuffFrame:EnableMouse(true)
	AAP.QuestList.SweatOfOurBrowBuffFrame:SetFrameStrata("LOW")
	AAP.QuestList.SweatOfOurBrowBuffFrame:SetPoint("TOPLEFT", UIParent, 300, -300)
	--AAP.QuestList.SweatOfOurBrowBuffFrame:SetBackdrop( { 
	--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
	--});
	AAP.QuestList.SweatOfOurBrowBuffFrame:Hide()
local t = AAP.QuestList.SweatOfOurBrowBuffFrame:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.QuestList.SweatOfOurBrowBuffFrame)
AAP.QuestList.SweatOfOurBrowBuffFrame.texture = t

	AAP.QuestList.SweatOfOurBrowBuffFrame:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			AAP.QuestList.SweatOfOurBrowBuffFrame:StartMoving();
			AAP.QuestList.SweatOfOurBrowBuffFrame.isMoving = true;
		end
	end)
	AAP.QuestList.SweatOfOurBrowBuffFrame:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and AAP.QuestList.SweatOfOurBrowBuffFrame.isMoving then
			AAP.QuestList.SweatOfOurBrowBuffFrame:StopMovingOrSizing();
			AAP.QuestList.SweatOfOurBrowBuffFrame.isMoving = false;
		end
	end)
	AAP.QuestList.SweatOfOurBrowBuffFrame:SetScript("OnHide", function(self)
		if ( AAP.QuestList.SweatOfOurBrowBuffFrame.isMoving ) then
			AAP.QuestList.SweatOfOurBrowBuffFrame:StopMovingOrSizing();
			AAP.QuestList.SweatOfOurBrowBuffFrame.isMoving = false;
		end
	end)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS1 = AAP.QuestList.SweatOfOurBrowBuffFrame:CreateFontString("AAP_QuestList_SweatOfOurBrowBuffFrame_FS1","ARTWORK", "ChatFontNormal")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS1:SetParent(AAP.QuestList.SweatOfOurBrowBuffFrame)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS1:SetPoint("TOPLEFT",AAP.QuestList.SweatOfOurBrowBuffFrame,"TOPLEFT",5,0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS1:SetWidth(300)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS1:SetHeight(38)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS1:SetJustifyH("LEFT")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS1:SetFontObject("GameFontNormal")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS1:SetText("Needed buffs for Disarming Traps:")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS1:SetTextColor(1, 1, 0)


	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps = CreateFrame("frame", "AAP_SugQuestFrameFramebufffraTraps", AAP.QuestList.SweatOfOurBrowBuffFrame)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps:SetWidth(220)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps:SetHeight(18)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps:SetMovable(true)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps:EnableMouse(true)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps:SetFrameStrata("LOW")
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps:SetPoint("TOPLEFT",AAP.QuestList.SweatOfOurBrowBuffFrame,"TOPLEFT",2,-40)
local t = AAP.QuestList.SweatOfOurBrowBuffFrame.Traps:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\Buttons\\WHITE8X8")
t:SetAllPoints(AAP.QuestList.SweatOfOurBrowBuffFrame.Traps)
t:SetColorTexture(0.5,0.1,0.1,1)
AAP.QuestList.SweatOfOurBrowBuffFrame.Traps.texture = t


	AAP.QuestList.SweatOfOurBrowBuffFrame.FS2 = AAP.QuestList.SweatOfOurBrowBuffFrame:CreateFontString("AAP_QuestList_SweatOfOurBrowBuffFrame_FS2","ARTWORK", "ChatFontNormal")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS2:SetParent(AAP.QuestList.SweatOfOurBrowBuffFrame.Traps)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS2:SetPoint("LEFT",AAP.QuestList.SweatOfOurBrowBuffFrame.Traps,"LEFT",5,0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS2:SetWidth(300)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS2:SetHeight(38)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS2:SetJustifyH("LEFT")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS2:SetFontObject("GameFontNormalSmall")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS2:SetText("Soulweb Trap")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS2:SetTextColor(1, 1, 0)
	
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS21 = AAP.QuestList.SweatOfOurBrowBuffFrame:CreateFontString("AAP_QuestList_SweatOfOurBrowBuffFrame_FS21","ARTWORK", "ChatFontNormal")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS21:SetParent(AAP.QuestList.SweatOfOurBrowBuffFrame.Traps)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS21:SetPoint("LEFT",AAP.QuestList.SweatOfOurBrowBuffFrame.Traps,"LEFT",85,0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS21:SetWidth(300)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS21:SetHeight(38)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS21:SetJustifyH("LEFT")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS21:SetFontObject("GameFontNormalSmall")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS21:SetText("Freshleaf buff")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS21:SetTextColor(1, 1, 0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2 = CreateFrame("frame", "AAP_SugQuestFrameFramebufffraTraps2", AAP.QuestList.SweatOfOurBrowBuffFrame)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2:SetWidth(220)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2:SetHeight(18)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2:SetMovable(true)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2:EnableMouse(true)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2:SetPoint("TOPLEFT",AAP.QuestList.SweatOfOurBrowBuffFrame,"TOPLEFT",2,-60)
local t = AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\Buttons\\WHITE8X8")
t:SetAllPoints(AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2)
t:SetColorTexture(0.5,0.1,0.1,1)
AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2.texture = t
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS3 = AAP.QuestList.SweatOfOurBrowBuffFrame:CreateFontString("AAP_QuestList_SweatOfOurBrowBuffFrame_FS3","ARTWORK", "ChatFontNormal")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS3:SetParent(AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS3:SetPoint("LEFT",AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2,"LEFT",5,0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS3:SetWidth(300)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS3:SetHeight(38)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS3:SetJustifyH("LEFT")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS3:SetFontObject("GameFontNormalSmall")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS3:SetText("Harp Trap")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS3:SetTextColor(1, 1, 0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS31 = AAP.QuestList.SweatOfOurBrowBuffFrame:CreateFontString("AAP_QuestList_SweatOfOurBrowBuffFrame_FS31","ARTWORK", "ChatFontNormal")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS31:SetParent(AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS31:SetPoint("LEFT",AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2,"LEFT",85,0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS31:SetWidth(300)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS31:SetHeight(38)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS31:SetJustifyH("LEFT")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS31:SetFontObject("GameFontNormalSmall")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS31:SetText("Gossamer Thread buff")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS31:SetTextColor(1, 1, 0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3 = CreateFrame("frame", "AAP_SugQuestFrameFramebufffraTraps3", AAP.QuestList.SweatOfOurBrowBuffFrame)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3:SetWidth(220)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3:SetHeight(18)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3:SetMovable(true)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3:EnableMouse(true)
	AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3:SetPoint("TOPLEFT",AAP.QuestList.SweatOfOurBrowBuffFrame,"TOPLEFT",2,-80)
local t = AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\Buttons\\WHITE8X8")
t:SetAllPoints(AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3)
t:SetColorTexture(0.5,0.1,0.1,1)
AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3.texture = t
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS4 = AAP.QuestList.SweatOfOurBrowBuffFrame:CreateFontString("AAP_QuestList_SweatOfOurBrowBuffFrame_FS4","ARTWORK", "ChatFontNormal")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS4:SetParent(AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS4:SetPoint("LEFT",AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3,"LEFT",5,0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS4:SetWidth(300)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS4:SetHeight(38)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS4:SetJustifyH("LEFT")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS4:SetFontObject("GameFontNormalSmall")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS4:SetText("Basket Trap")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS4:SetTextColor(1, 1, 0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS41 = AAP.QuestList.SweatOfOurBrowBuffFrame:CreateFontString("AAP_QuestList_SweatOfOurBrowBuffFrame_FS41","ARTWORK", "ChatFontNormal")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS41:SetParent(AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS41:SetPoint("LEFT",AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3,"LEFT",85,0)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS41:SetWidth(300)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS41:SetHeight(38)
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS41:SetJustifyH("LEFT")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS41:SetFontObject("GameFontNormalSmall")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS41:SetText("Shummerdust pile buff")
	AAP.QuestList.SweatOfOurBrowBuffFrame.FS41:SetTextColor(1, 1, 0)
	
end

AAP.QuestListEventFrame = CreateFrame("Frame")
AAP.QuestListEventFrame:RegisterEvent ("ADDON_LOADED")
AAP.QuestListEventFrame:SetScript("OnEvent", function(self, event, ...)
	if (event=="ADDON_LOADED") then
		local arg1, arg2, arg3, arg4, arg5 = ...;
		if (arg1 == "AAP-Core") then
			AAP_CreateQuestList()
			AAP.QuestListLoadin = 1
		end
	end
end)