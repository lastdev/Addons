local ConRO_Priest, ids = ...;

local defaults = {
	["Raid_Atonement_Threshold"] = 8,
}

ConROPriest = ConROPriest or defaults;

function ConRO_ShowAtonement()
	ConROButtonFrame:Show();
	ConRO_BurstButton:Hide();
	ConRO_FullButton:Hide();
	ConRO_AutoButton:Hide();
	ConRO_SingleButton:Hide();
	ConRO_AoEButton:Hide();
	ConRO_AtonementButton:Show();
	ConRO_RaidAtonementButton:Show();
end

function ConRO:CreateAtonementButton()
	local tbutton = CreateFrame("Button", 'ConRO_AtonementButton', ConROButtonFrame)
		tbutton:SetFrameStrata('MEDIUM');
		tbutton:SetFrameLevel('6')
		tbutton:SetPoint("TOPLEFT", "ConROButtonFrame", "TOPLEFT", 7, -7)
		tbutton:SetSize(40, 15)
		tbutton:Hide()
		tbutton:SetAlpha(1)
		
		tbutton:SetText("At: " .. ConRO:GroupBuffCount(ids.Disc_Buff.Atonement))
		tbutton:SetNormalFontObject("GameFontHighlightSmall")
		
		tbutton:SetScript("OnEnter", AtoneOnEnter)
		tbutton:SetScript("OnLeave", AtoneOnLeave)

	local ntex = tbutton:CreateTexture()
		ntex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonUp")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetVertexColor(0, 0, 0, 1)
		ntex:SetAllPoints()	
		tbutton:SetNormalTexture(ntex)
		
		tbutton:SetScript("OnMouseDown", function (self, tbutton, up)
			if ConRO.db.profile.unlockWindow then
				ConROButtonFrame:StartMoving();
				self.isMoving = true;
			end
		end)
		
		tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
			if ConRO.db.profile.unlockWindow then
				ConROButtonFrame:StopMovingOrSizing();
				self.isMoving = false;
			end
		end)
end

function ConRO:CreateRaidAtonementButton()
	local tbutton = CreateFrame("Button", 'ConRO_RaidAtonementButton', ConROButtonFrame)
		tbutton:SetFrameStrata('MEDIUM');
		tbutton:SetFrameLevel('6')
		tbutton:SetPoint("BOTTOMRIGHT", "ConROButtonFrame", "BOTTOMRIGHT", -7, 7)
		tbutton:SetSize(40, 15)
		tbutton:Hide()
		tbutton:SetAlpha(1)
		
		tbutton:SetText("Single")
		tbutton:SetNormalFontObject("GameFontHighlightSmall")
		
		tbutton:SetScript("OnEnter", AtoneOnEnter)
		tbutton:SetScript("OnLeave", AtoneOnLeave)
	
	local box1 = CreateFrame("EditBox", 'ConRO_AtonementBox', tbutton);	
		box1:SetPoint("BOTTOMRIGHT", "ConROButtonFrame", "BOTTOMRIGHT", -1, 7);
		box1:SetMultiLine(false);
		box1:SetFontObject(GameFontNormalSmall);
		box1:SetNumeric(true);
		box1:SetAutoFocus(false);
		box1:SetMaxLetters("2");
		box1:SetWidth(20);
		box1:SetHeight(15);
		box1:SetTextInsets(3, 0, 0, 0);
		box1:SetNumber(ConROPriest.Raid_Atonement_Threshold);

		box1:SetScript("OnEditFocusLost", 
			function()
				ConROPriest.Raid_Atonement_Threshold = ConRO_AtonementBox:GetNumber();
				box1:ClearFocus()
			end);
		box1:SetScript("OnEnterPressed", 
			function()
				ConROPriest.Raid_Atonement_Threshold = ConRO_AtonementBox:GetNumber();
				box1:ClearFocus()
			end);
		box1:SetScript("OnEscapePressed", 
			function()
				ConROPriest.Raid_Atonement_Threshold = ConRO_AtonementBox:GetNumber();
				box1:ClearFocus()
			end);
			
	local ntex = tbutton:CreateTexture()
		ntex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonUp")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetVertexColor(0, 0, 0, 1)
		ntex:SetAllPoints()	
		tbutton:SetNormalTexture(ntex)
		
		tbutton:SetScript("OnMouseDown", function (self, tbutton, up)
			if ConRO.db.profile.unlockWindow then
				ConROButtonFrame:StartMoving();
				self.isMoving = true;
			end
		end)
		
		tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
			if ConRO.db.profile.unlockWindow then
				ConROButtonFrame:StopMovingOrSizing();
				self.isMoving = false;
			end
		end)
end

function ConRO:Atonements(_Atonement_COUNT)
	ConRO_AtonementButton:SetText("At: " .. _Atonement_COUNT);
	if ConRO:InRaid() then
		ConRO_RaidAtonementButton:SetText("Raid:    ");
		ConRO_AtonementBox:Show();
	elseif ConRO:InParty() then
		ConRO_RaidAtonementButton:SetText("Party:    ");
		ConRO_AtonementBox:Show();
	elseif ConRO:IsSolo() then
		ConRO_RaidAtonementButton:SetText("Single");
		ConRO_AtonementBox:Hide();
	end
end

ConRO:CreateAtonementButton();
ConRO:CreateRaidAtonementButton();