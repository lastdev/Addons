ConRO.Spells = {};
ConRO.Keybinds = {};
ConRO.DefSpells = {};
ConRO.Flags = {};
ConRO.SpellsGlowing = {};
ConRO.DefGlowing = {};
ConRO.DamageFramePool = {};
ConRO.DamageFrames = {};
ConRO.DefenseFramePool = {};
ConRO.DefenseFrames = {};
ConRO.InterruptFramePool = {};
ConRO.InterruptFrames = {};
ConRO.CoolDownFramePool = {};
ConRO.CoolDownFrames = {};
ConRO.PurgableFramePool = {};
ConRO.PurgableFrames = {};
ConRO.RaidBuffsFramePool = {};
ConRO.RaidBuffsFrames = {};
ConRO.MovementFramePool = {};
ConRO.MovementFrames = {};
ConRO.TauntFramePool = {};
ConRO.TauntFrames = {};

function TTOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
	GameTooltip:SetText("ConRO Target Toggle")  -- This sets the top line of text, in gold.
	GameTooltip:AddLine('MACRO = "/ConROToggle"', 1, 1, 1, true)
	GameTooltip:AddLine(" ", 1, 1, 1, true)
	GameTooltip:AddLine("Auto", .2, 1, .2)
		GameTooltip:AddLine("Used for melee specs to auto detect the number of enemies in range. Must have nameplates turned on.", 1, 1, 1, true)	
	GameTooltip:AddLine("Single", 1, .2, .2)
		GameTooltip:AddLine("This will force single target rotation to focus and burn a target.", 1, 1, 1, true)
	GameTooltip:AddLine("AoE", 1, .2, .2)
		GameTooltip:AddLine("This will force AoE rotation for trash or Boss phases with frequent adds.", 1, 1, 1, true)
	GameTooltip:AddLine(" ", 1, 1, 1, true)
		GameTooltip:AddLine('"This can be toggled during combat as phases change."', 1, 1, 0, true)
	GameTooltip:Show()
end

function TTOnLeave(self)
	GameTooltip:Hide()
end

function ETOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
	GameTooltip:SetText("ConRO Rotation Toggle")  -- This sets the top line of text, in gold.
	GameTooltip:AddLine('MACRO = "/ConROBurstToggle"', 1, 1, 1, true)
	GameTooltip:AddLine(" ", 1, 1, 1, true)
	GameTooltip:AddLine("Burst Rotation", .2, 1, .2)
		GameTooltip:AddLine("This is for Boss fights where you want to decide when to use your cooldowns.", 1, 1, 1, true)
	GameTooltip:AddLine("Full Rotation", 1, .2, .2)
		GameTooltip:AddLine("Can be used for placing long cooldowns into the recommended rotation.", 1, 1, 1, true)
	GameTooltip:AddLine(" ", 1, 1, 1, true)
		GameTooltip:AddLine('"This can be toggled during combat as phases change."', 1, 1, 0, true)
	GameTooltip:Show()
end

function ETOnLeave(self)
	GameTooltip:Hide()
end

function TWOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
	GameTooltip:SetText("ConRO Window")  -- This sets the top line of text, in gold.
	GameTooltip:AddLine("", .2, 1, .2)
		GameTooltip:AddLine("This window displays the next suggested ability in your rotation.", 1, 1, 1, true)
	GameTooltip:Show()
end

function TWOnLeave(self)
	GameTooltip:Hide()
end

function TDWOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
	GameTooltip:SetText("ConRO Defense Window")  -- This sets the top line of text, in gold.
	GameTooltip:AddLine("", .2, 1, .2)
		GameTooltip:AddLine("This window displays the next suggested defense ability in your rotation.", 1, 1, 1, true)
	GameTooltip:Show()
end

function TDWOnLeave(self)
	GameTooltip:Hide()
end

function TIWOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
	GameTooltip:SetText("ConRO Interrupt Flash")  -- This sets the top line of text, in gold.
	GameTooltip:AddLine("", .2, 1, .2)
		GameTooltip:AddLine("This flash displays that you can interrupt.", 1, 1, 1, true)
	GameTooltip:Show()
	
	local color = ConRO.db.profile.interruptOverlayColor;
	ConROInterruptWindow:SetSize(ConRO.db.profile.flashIconSize * .75, ConRO.db.profile.flashIconSize * .75);
	ConROInterruptWindow.texture:SetVertexColor(color.r, color.g, color.b);	
end

function TIWOnLeave(self)
	GameTooltip:Hide()
	
	ConROInterruptWindow:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
	ConROInterruptWindow.texture:SetVertexColor(.1, .1, .1);		
end

function TPWOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
	GameTooltip:SetText("ConRO Purge Flash")  -- This sets the top line of text, in gold.
	GameTooltip:AddLine("", .2, 1, .2)
		GameTooltip:AddLine("This flash displays that you can purge.", 1, 1, 1, true)
	GameTooltip:Show()
	
	local color = ConRO.db.profile.purgeOverlayColor;
	ConROPurgeWindow:SetSize(ConRO.db.profile.flashIconSize * .75, ConRO.db.profile.flashIconSize * .75);
	ConROPurgeWindow.texture:SetVertexColor(color.r, color.g, color.b);		
end

function TPWOnLeave(self)
	GameTooltip:Hide()
	
	ConROPurgeWindow:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
	ConROPurgeWindow.texture:SetVertexColor(.1, .1, .1);	
end

function ConRO:DisplayToggleFrame()
	local _, Class = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROButtonFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	local vert = 2;
	local hori = 1;
		if ConRO.db.profile.toggleButtonOrientation == 1 then
			vert = 2;
			hori = 1;
		elseif ConRO.db.profile.toggleButtonOrientation == 2 then
			vert = 1;
			hori = 2;
		end
		
		frame:SetFrameStrata('LOW');
		frame:SetSize((40 * hori) + 14, (15 * vert) + 14)
		frame:SetScale(ConRO.db.profile.toggleButtonSize)
		frame:SetAlpha(1)
		
		frame:SetBackdrop( { 
			bgFile = "Interface\\CHATFRAME\\CHATFRAMEBACKGROUND", 
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 8,
			edgeSize = 20, 
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
			})
		frame:SetBackdropColor(0, 0, 0, .75)
		frame:SetBackdropBorderColor(Color.r, Color.g, Color.b, .75)
		
		frame:SetPoint("CENTER", 180, -20)
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)
		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart", function(self)
			if ConRO.db.profile.unlockWindow then
				frame:StartMoving()
			end
		end)
		frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
		frame:Show()
end

function ConRO:CreateAutoButton()
	local _, Class = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local tbutton = CreateFrame("Button", 'ConRO_AutoButton', UIParent)
		tbutton:SetFrameStrata('MEDIUM')
		tbutton:SetFrameLevel('6')
		tbutton:SetPoint("BOTTOMRIGHT", "ConROButtonFrame", "BOTTOMRIGHT", -7, 7)
		tbutton:SetSize(40, 15)
		tbutton:SetScale(ConRO.db.profile.toggleButtonSize)
		if ConRO:MeleeSpec() then
			tbutton:Show()
		else
			tbutton:Hide()
		end
		tbutton:SetAlpha(1)
		
		tbutton:SetText("Auto")
		tbutton:SetNormalFontObject("GameFontHighlightSmall")
		
		tbutton:SetScript("OnEnter", TTOnEnter)
		tbutton:SetScript("OnLeave", TTOnLeave)
		
	local ntex = tbutton:CreateTexture()
		ntex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonUp")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetVertexColor(Color.r, Color.g, Color.b, 1)
		ntex:SetAllPoints()	
		tbutton:SetNormalTexture(ntex)

	local htex = tbutton:CreateTexture()
		htex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonHighlight")
		htex:SetTexCoord(0, 0.625, 0, 0.6875)
		htex:SetAllPoints()
		tbutton:SetHighlightTexture(htex)

	local ptex = tbutton:CreateTexture()
		ptex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonDown")
		ptex:SetTexCoord(0, 0.625, 0, 0.6875)
		ptex:SetVertexColor(Color.r, Color.g, Color.b, 1)
		ptex:SetAllPoints()
		tbutton:SetPushedTexture(ptex)
		
		tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
				self:Hide();
				ConRO_SingleButton:Show();
				ConRO_AoEButton:Hide();
		end)
end

function ConRO:CreateSingleButton()
	local _, Class = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local tbutton = CreateFrame("Button", 'ConRO_SingleButton', UIParent)
		tbutton:SetFrameStrata('MEDIUM')
		tbutton:SetFrameLevel('6')
		tbutton:SetPoint("BOTTOMRIGHT", "ConROButtonFrame", "BOTTOMRIGHT", -7, 7)
		tbutton:SetSize(40, 15)
		tbutton:SetScale(ConRO.db.profile.toggleButtonSize)
		if ConRO:MeleeSpec() then
			tbutton:Hide()
		else
			tbutton:Show()
		end
		tbutton:SetAlpha(1)
		
		tbutton:SetText("Single")
		tbutton:SetNormalFontObject("GameFontHighlightSmall")
		
		tbutton:SetScript("OnEnter", TTOnEnter)
		tbutton:SetScript("OnLeave", TTOnLeave)
		
	local ntex = tbutton:CreateTexture()
		ntex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonUp")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetVertexColor(Color.r, Color.g, Color.b, 1)
		ntex:SetAllPoints()	
		tbutton:SetNormalTexture(ntex)

	local htex = tbutton:CreateTexture()
		htex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonHighlight")
		htex:SetTexCoord(0, 0.625, 0, 0.6875)
		htex:SetAllPoints()
		tbutton:SetHighlightTexture(htex)

	local ptex = tbutton:CreateTexture()
		ptex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonDown")
		ptex:SetTexCoord(0, 0.625, 0, 0.6875)
		ptex:SetVertexColor(Color.r, Color.g, Color.b, 1)
		ptex:SetAllPoints()
		tbutton:SetPushedTexture(ptex)
		
		tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
				self:Hide();
				ConRO_AoEButton:Show();
		end)
end

function ConRO:CreateAoEButton()
	local tbutton = CreateFrame("Button", 'ConRO_AoEButton', UIParent)
		tbutton:SetFrameStrata('MEDIUM');
		tbutton:SetFrameLevel('6')
		tbutton:SetPoint("BOTTOMRIGHT", "ConROButtonFrame", "BOTTOMRIGHT", -7, 7)
		tbutton:SetScale(ConRO.db.profile.toggleButtonSize)
		tbutton:SetSize(40, 15)
		tbutton:Hide()
		tbutton:SetAlpha(1)
		
		tbutton:SetText("AoE")
		tbutton:SetNormalFontObject("GameFontHighlightSmall")
		
		tbutton:SetScript("OnEnter", TTOnEnter)
		tbutton:SetScript("OnLeave", TTOnLeave)

	local ntex = tbutton:CreateTexture()
		ntex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonUp")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetVertexColor(.50, .50, .50, 1)
		ntex:SetAllPoints()	
		tbutton:SetNormalTexture(ntex)

	local htex = tbutton:CreateTexture()
		htex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonHighlight")
		htex:SetTexCoord(0, 0.625, 0, 0.6875)
		htex:SetAllPoints()
		tbutton:SetHighlightTexture(htex)

	local ptex = tbutton:CreateTexture()
		ptex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonDown")
		ptex:SetTexCoord(0, 0.625, 0, 0.6875)
		ptex:SetVertexColor(.50, .50, .50, 1)
		ptex:SetAllPoints()
		tbutton:SetPushedTexture(ptex)
		
		tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
			if ConRO:MeleeSpec() then
				ConRO_AutoButton:Show();
				ConRO_SingleButton:Hide();
				self:Hide();
			else
				ConRO_SingleButton:Show();
				self:Hide();
			end
		end)
end

function ConRO:CreateFullButton()
	local _, Class = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local tbutton = CreateFrame("Button", 'ConRO_FullButton', UIParent)
		tbutton:SetFrameStrata('MEDIUM');
		tbutton:SetFrameLevel('6')
		tbutton:SetPoint("TOPLEFT", "ConROButtonFrame", "TOPLEFT", 7, -7)
		tbutton:SetScale(ConRO.db.profile.toggleButtonSize)
		tbutton:SetSize(40, 15)
		tbutton:SetAlpha(1)
		tbutton:Show();
		
		tbutton:SetText("Full")
		tbutton:SetNormalFontObject("GameFontHighlightSmall")
		
		tbutton:SetScript("OnEnter", ETOnEnter)
		tbutton:SetScript("OnLeave", ETOnLeave)

	local ntex = tbutton:CreateTexture()
		ntex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonUp")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetVertexColor(Color.r, Color.g, Color.b, 1)
		ntex:SetAllPoints()	
		tbutton:SetNormalTexture(ntex)

	local htex = tbutton:CreateTexture()
		htex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonHighlight")
		htex:SetTexCoord(0, 0.625, 0, 0.6875)
		htex:SetAllPoints()
		tbutton:SetHighlightTexture(htex)

	local ptex = tbutton:CreateTexture()
		ptex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonDown")
		ptex:SetTexCoord(0, 0.625, 0, 0.6875)
		ptex:SetVertexColor(Color.r, Color.g, Color.b, 1)
		ptex:SetAllPoints()
		tbutton:SetPushedTexture(ptex)
		
		tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
				self:Hide();
				ConRO_BurstButton:Show();
		end)
end

function ConRO:CreateBurstButton()
	local tbutton = CreateFrame("Button", 'ConRO_BurstButton', UIParent)
		tbutton:SetFrameStrata('MEDIUM');
		tbutton:SetFrameLevel('6')
		tbutton:SetPoint("TOPLEFT", "ConROButtonFrame", "TOPLEFT", 7, -7)
		tbutton:SetScale(ConRO.db.profile.toggleButtonSize)
		tbutton:SetSize(40, 15)
		tbutton:SetAlpha(1)
		tbutton:Hide();

		tbutton:SetText("Burst")
		tbutton:SetNormalFontObject("GameFontHighlightSmall")
		
		tbutton:SetScript("OnEnter", ETOnEnter)
		tbutton:SetScript("OnLeave", ETOnLeave)

	local ntex = tbutton:CreateTexture()
		ntex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonUp")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetVertexColor(.50, .50, .50, 1)
		ntex:SetAllPoints()	
		tbutton:SetNormalTexture(ntex)

	local htex = tbutton:CreateTexture()
		htex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonHighlight")
		htex:SetTexCoord(0, 0.625, 0, 0.6875)
		htex:SetAllPoints()
		tbutton:SetHighlightTexture(htex)

	local ptex = tbutton:CreateTexture()
		ptex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonDown")
		ptex:SetTexCoord(0, 0.625, 0, 0.6875)
		ptex:SetVertexColor(.50, .50, .50, 1)
		ptex:SetAllPoints()
		tbutton:SetPushedTexture(ptex)
		
		tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
				self:Hide();
				ConRO_FullButton:Show();
		end)
end

function ConRO:CreateBlockBurstButton()
	local tbutton = CreateFrame("Button", 'ConRO_BlockBurstButton', UIParent)
		tbutton:SetFrameStrata('MEDIUM');
		tbutton:SetFrameLevel('6')
		tbutton:SetPoint("TOPLEFT", "ConROButtonFrame", "TOPLEFT", 7, -7)
		tbutton:SetScale(ConRO.db.profile.toggleButtonSize)
		tbutton:SetSize(40, 15)
		tbutton:Hide()
		tbutton:SetAlpha(1)
		
		tbutton:SetText("Just")
		tbutton:SetNormalFontObject("GameFontHighlightSmall")
		
		tbutton:SetScript("OnEnter", ETOnEnter)
		tbutton:SetScript("OnLeave", ETOnLeave)

	local ntex = tbutton:CreateTexture()
		ntex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonUp")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetVertexColor(0, 0, 0, 1)
		ntex:SetAllPoints()	
		tbutton:SetNormalTexture(ntex)
end

function ConRO:CreateBlockAoEButton()
	local tbutton = CreateFrame("Button", 'ConRO_BlockAoEButton', UIParent)
		tbutton:SetFrameStrata('MEDIUM');
		tbutton:SetFrameLevel('6')
		tbutton:SetPoint("BOTTOMRIGHT", "ConROButtonFrame", "BOTTOMRIGHT", -7, 7)
		tbutton:SetScale(ConRO.db.profile.toggleButtonSize)
		tbutton:SetSize(40, 15)
		tbutton:Hide()
		tbutton:SetAlpha(1)
		
		tbutton:SetText("Kill")
		tbutton:SetNormalFontObject("GameFontHighlightSmall")
		
		tbutton:SetScript("OnEnter", TTOnEnter)
		tbutton:SetScript("OnLeave", TTOnLeave)

	local ntex = tbutton:CreateTexture()
		ntex:SetTexture("Interface\\AddOns\\ConRO\\images\\buttonUp")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetVertexColor(0, 0, 0, 1)
		ntex:SetAllPoints()	
		tbutton:SetNormalTexture(ntex)
end

function ConRO:SlashUnlock()
	if not ConRO.db.profile.unlockWindow then
		ConRO.db.profile.unlockWindow = true;
	else
		ConRO.db.profile.unlockWindow = false;
	end
	
	ConROWindow:EnableMouse(ConRO.db.profile.unlockWindow);
	ConRODefenseWindow:EnableMouse(ConRO.db.profile.unlockWindow);
	ConROInterruptWindow:EnableMouse(ConRO.db.profile.unlockWindow);
	ConROPurgeWindow:EnableMouse(ConRO.db.profile.unlockWindow);
	ConROInterruptWindow:SetMovable(ConRO.db.profile.unlockWindow);
	ConROPurgeWindow:SetMovable(ConRO.db.profile.unlockWindow);
	if ConRO.db.profile.unlockWindow and ConRO.db.profile.enableInterruptWindow == true then
		ConROInterruptWindow:Show();				
	else
		ConROInterruptWindow:Hide();				
	end	
	if ConRO.db.profile.unlockWindow and ConRO.db.profile.enablePurgeWindow == true then
		ConROPurgeWindow:Show();					
	else
		ConROPurgeWindow:Hide();					
	end		
end

function ConRO:SlashToggle()
	if ConRO:MeleeSpec() then
		if ConRO_AutoButton:IsVisible() then
			ConRO_AutoButton:Hide();
			ConRO_SingleButton:Show();
			ConRO_AoEButton:Hide();
		elseif ConRO_SingleButton:IsVisible() then
			ConRO_AutoButton:Hide();
			ConRO_SingleButton:Hide();
			ConRO_AoEButton:Show();
		elseif ConRO_AoEButton:IsVisible() then
			ConRO_AutoButton:Show();
			ConRO_SingleButton:Hide();
			ConRO_AoEButton:Hide();
		end		
	else
		if ConRO_SingleButton:IsVisible() then
			ConRO_SingleButton:Hide();
			ConRO_AoEButton:Show();
		elseif ConRO_AoEButton:IsVisible() then
			ConRO_SingleButton:Show();
			ConRO_AoEButton:Hide();
		end
	end
end

function ConRO:SlashBurstToggle()
	if ConRO_BurstButton:IsVisible() then
		ConRO_BurstButton:Hide();
		ConRO_FullButton:Show();
	elseif ConRO_FullButton:IsVisible() then
		ConRO_FullButton:Hide();
		ConRO_BurstButton:Show();
	end
end

SLASH_CONROUNLOCK1 = '/ConROUL'
SLASH_CONRO1 = '/ConROtoggle'
SLASH_CONROB1 = '/ConROBurstToggle'
SlashCmdList["CONROUNLOCK"] = function() ConRO:SlashUnlock() end
SlashCmdList["CONRO"] = function() ConRO:SlashToggle() end -- Slash Command List
SlashCmdList["CONROB"] = function() ConRO:SlashBurstToggle() end -- Slash Command List

function ConRO:ToggleHealer()
	ConROButtonFrame:Hide();
	ConRO_AutoButton:Hide();
	ConRO_SingleButton:Hide();
	ConRO_AoEButton:Hide();
	ConRO_BurstButton:Hide();
	ConRO_FullButton:Hide();
	ConRO_BlockBurstButton:Hide();
	ConRO_BlockAoEButton:Hide();
end

function ConRO:ToggleDamage()
	ConROButtonFrame:Show();
	if ConRO:MeleeSpec() then
		ConRO_AutoButton:Show();
		ConRO_SingleButton:Hide();
		ConRO_AoEButton:Hide();
	else
		ConRO_AutoButton:Hide();
		ConRO_SingleButton:Show();
		ConRO_AoEButton:Hide();
	end
	if ConRO.db.profile.burstDefault then
		ConRO_FullButton:Hide();
		ConRO_BurstButton:Show();
	else
		ConRO_FullButton:Show();
		ConRO_BurstButton:Hide();
	end
	ConRO_BlockBurstButton:Hide();
	ConRO_BlockAoEButton:Hide();
end

function ConRO:BlockBurst()
	ConRO_BurstButton:Hide();
	ConRO_FullButton:Hide();
	ConRO_BlockBurstButton:Show();
end

function ConRO:BlockAoE()
	ConRO_AutoButton:Hide();
	ConRO_SingleButton:Hide();
	ConRO_AoEButton:Hide();
	ConRO_BlockAoEButton:Show();
end
	
function ConRO:DisplayWindowFrame()
	local frame = CreateFrame("Frame", "ConROWindow", UIParent);
		frame:SetMovable(true);
		frame:SetClampedToScreen(true);
		frame:RegisterForDrag("LeftButton");
		frame:SetScript("OnEnter", TWOnEnter);
		frame:SetScript("OnLeave", TWOnLeave);
		frame:SetScript("OnDragStart", function(self)
			if ConRO.db.profile.unlockWindow then
				frame:StartMoving()
			end
		end)
		frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
		frame:EnableMouse(ConRO.db.profile.unlockWindow);
		
		frame:SetPoint("CENTER", -200, 50);
		frame:SetSize(ConRO.db.profile.windowIconSize, ConRO.db.profile.windowIconSize);
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5');
		frame:SetAlpha(ConRO.db.profile.transparencyWindow);		
		if ConRO.db.profile.combatWindow or ConRO:HealSpec() then
			frame:Hide();
		elseif not ConRO.db.profile.enableWindow then
			frame:Hide();
		else
			frame:Show();
		end
	local t = frame.texture;
		if not t then
			t = frame:CreateTexture("ARTWORK");
			t:SetTexture('Interface\\AddOns\\ConRO\\images\\Bigskull');
			t:SetBlendMode('BLEND');
			frame.texture = t;
		end
		
		t:SetAllPoints(frame)

	local fontstring = frame.font;
		if not fontstring then
			fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			fontstring:SetText(" ");
			local _, Class = UnitClass("player");
			local Color = RAID_CLASS_COLORS[Class];
			fontstring:SetTextColor(Color.r, Color.g, Color.b, 1);
			fontstring:SetPoint('BOTTOM', frame, 'TOP', 0, 2);
			fontstring:SetWidth(ConRO.db.profile.windowIconSize / 1.25 + 30);
			fontstring:SetHeight(ConRO.db.profile.windowIconSize / 1.25);
			fontstring:SetJustifyV("BOTTOM");
			frame.font = fontstring;
		end
		
		if ConRO.db.profile.enableWindowSpellName then
			fontstring:Show();
		else 
			fontstring:Hide();
		end
	
	local fontkey = frame.fontkey;
		if not fontkey then
			fontkey = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			fontkey:SetText(" ");
			fontkey:SetPoint('TOP', frame, 'BOTTOM', 0, -2);
			fontkey:SetTextColor(1, 1, 1, 1);
			frame.fontkey = fontkey;
		end
		if ConRO.db.profile.enableWindowKeybinds or ConRO.db.profile.unlockWindow then
			fontkey:Show();
		else 
			fontkey:Hide();
		end
	
	local cd = CreateFrame("Cooldown", "ConROWindowCooldown", frame, "CooldownFrameTemplate")
		cd:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
		cd:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
		cd:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
		cd:RegisterEvent("UNIT_SPELLCAST_SENT");
		cd:RegisterEvent("UNIT_SPELLCAST_START");
		cd:RegisterEvent("UNIT_SPELLCAST_DELAYED");
		cd:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
        cd:RegisterEvent("UNIT_SPELLCAST_FAILED");
		cd:RegisterEvent("UNIT_SPELLCAST_START");
		cd:RegisterEvent("UNIT_SPELLCAST_STOP");
		
		cd:SetAllPoints(frame);
		cd:SetFrameStrata('MEDIUM');
		cd:SetFrameLevel('7');			
		if ConRO.db.profile.enableWindowCooldown then
			cd:SetScript("OnEvent",function(self)
				local gcdStart, gcdDuration = GetSpellCooldown(61304)
				local _, _, _, startTimeMS, endTimeMS = UnitCastingInfo('player');
				local _, _, _, startTimeMSchan, endTimeMSchan = UnitChannelInfo('player');
				if not (endTimeMS or endTimeMSchan) then
					cd:SetCooldown(gcdStart, gcdDuration)
				elseif endTimeMSchan then
					local chanStart  = startTimeMSchan / 1000;
					local chanDuration = endTimeMSchan/1000 - GetTime();
					cd:SetCooldown(chanStart, chanDuration)
				else
					local spStart  = startTimeMS / 1000;
					local spDuration = endTimeMS/1000 - GetTime();
					cd:SetCooldown(spStart, spDuration)			
				end
			end)
		end
end

function ConRO:DefenseWindowFrame()
	local frame = CreateFrame("Frame", "ConRODefenseWindow", UIParent);
		frame:SetMovable(true);
		frame:SetClampedToScreen(true);
		frame:RegisterForDrag("LeftButton");
		frame:SetScript("OnEnter", TDWOnEnter);
		frame:SetScript("OnLeave", TDWOnLeave);
		frame:SetScript("OnDragStart", function(self)
			if ConRO.db.profile.unlockWindow then
				frame:StartMoving()
			end
		end)
		frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
		frame:EnableMouse(ConRO.db.profile.unlockWindow);
		
		frame:SetPoint("CENTER", -280, 50);
		frame:SetSize(ConRO.db.profile.windowIconSize * .75, ConRO.db.profile.windowIconSize * .75);
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('4');
		frame:SetAlpha(ConRO.db.profile.transparencyWindow);
		if ConRO.db.profile.combatWindow then
			frame:Hide();
		elseif not ConRO.db.profile.enableDefenseWindow then
			frame:Hide();
		else
			frame:Show();
		end
		
	local t = frame.texture;
		if not t then
			t = frame:CreateTexture("ARTWORK")
			t:SetTexture('Interface\\AddOns\\ConRO\\images\\shield2');
			t:SetBlendMode('BLEND');
			local color = ConRO.db.profile.defenseOverlayColor;
			t:SetVertexColor(color.r, color.g, color.b);
			frame.texture = t;
		end
		
		t:SetAllPoints(frame)
	
	local fontstring = frame.font;
		if not fontstring then
			fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			fontstring:SetText(" ");
			local _, Class = UnitClass("player");
			local Color = RAID_CLASS_COLORS[Class];
			fontstring:SetTextColor(Color.r, Color.g, Color.b, 1);
			fontstring:SetPoint('BOTTOM', frame, 'TOP', 0, 2);
			fontstring:SetWidth(ConRO.db.profile.windowIconSize / 1.25 + 30);
			fontstring:SetHeight(ConRO.db.profile.windowIconSize / 1.25);
			fontstring:SetJustifyV("BOTTOM");
			frame.font = fontstring;
		end
		
		if ConRO.db.profile.enableWindowSpellName then
			fontstring:Show();
		else 
			fontstring:Hide();
		end

	local fontkey = frame.fontkey;
		if not fontkey then
			fontkey = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			fontkey:SetText(" ");
			fontkey:SetPoint('TOP', frame, 'BOTTOM', 0, -2);
			fontkey:SetTextColor(1, 1, 1, 1);
			frame.fontkey = fontkey;
		end
		if ConRO.db.profile.enableWindowKeybinds or ConRO.db.profile.unlockWindow then
			fontkey:Show();
		else 
			fontkey:Hide();
		end
	
	local cd = CreateFrame("Cooldown", "ConRODefWindowCooldown", frame, "CooldownFrameTemplate")
		cd:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
		cd:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
		cd:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
		cd:RegisterEvent("UNIT_SPELLCAST_SENT");
		cd:RegisterEvent("UNIT_SPELLCAST_START");
		cd:RegisterEvent("UNIT_SPELLCAST_DELAYED");
		cd:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
        cd:RegisterEvent("UNIT_SPELLCAST_FAILED");
		cd:RegisterEvent("UNIT_SPELLCAST_START");
		cd:RegisterEvent("UNIT_SPELLCAST_STOP");
		
		cd:SetAllPoints(frame);
		cd:SetFrameStrata('MEDIUM');
		cd:SetFrameLevel('7');			
		if ConRO.db.profile.enableWindowCooldown then
			cd:SetScript("OnEvent",function(self)
				local gcdStart, gcdDuration = GetSpellCooldown(61304)
				local _, _, _, startTimeMS, endTimeMS = UnitCastingInfo('player');
				local _, _, _, startTimeMSchan, endTimeMSchan = UnitChannelInfo('player');
				if not (endTimeMS or endTimeMSchan) then
					cd:SetCooldown(gcdStart, gcdDuration)
				elseif endTimeMSchan then
					local chanStart  = startTimeMSchan / 1000;
					local chanDuration = endTimeMSchan/1000 - GetTime();
					cd:SetCooldown(chanStart, chanDuration)
				else
					local spStart  = startTimeMS / 1000;
					local spDuration = endTimeMS/1000 - GetTime();
					cd:SetCooldown(spStart, spDuration)			
				end
			end)
		end		
end

function ConRO:InterruptWindowFrame()
	local frame = CreateFrame("Frame", "ConROInterruptWindow", UIParent);
		frame:SetMovable(true);
		frame:SetClampedToScreen(true);
		frame:RegisterForDrag("LeftButton");
		frame:SetScript("OnEnter", TIWOnEnter);
		frame:SetScript("OnLeave", TIWOnLeave);
		frame:SetScript("OnDragStart", function(self)
			if ConRO.db.profile.unlockWindow then
				frame:StartMoving()
			end
		end)
		frame:SetScript("OnDragStop", frame.StopMovingOrSizing)		
		frame:EnableMouse(ConRO.db.profile.unlockWindow);
		
		frame:SetPoint("RIGHT", "ConROWindow", "LEFT", -5, 0);
		frame:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5');
		if ConRO.db.profile.enableInterruptWindow == true and ConRO.db.profile.unlockWindow == true then
			frame:Show();
		else
			frame:Hide();
		end

	local t = frame.texture;
		if not t then
			t = frame:CreateTexture("ARTWORK")
			t:SetTexture('Interface\\AddOns\\ConRO\\images\\lightning-interrupt');
			t:SetBlendMode('BLEND');
			t:SetAlpha(ConRO.db.profile.transparencyWindow);
			t:SetVertexColor(.1, .1, .1);
			frame.texture = t;
		end
		
		t:SetAllPoints(frame)		
end

function ConRO:PurgeWindowFrame()
	local frame = CreateFrame("Frame", "ConROPurgeWindow", UIParent);
		frame:SetMovable(true);
		frame:SetClampedToScreen(true);
		frame:RegisterForDrag("LeftButton");
		frame:SetScript("OnEnter", TPWOnEnter);
		frame:SetScript("OnLeave", TPWOnLeave);
		frame:SetScript("OnDragStart", function(self)
			if ConRO.db.profile.unlockWindow then
				frame:StartMoving()
			end
		end)
		frame:SetScript("OnDragStop", frame.StopMovingOrSizing)		
		frame:EnableMouse(ConRO.db.profile.unlockWindow);
		
		frame:SetPoint("LEFT", "ConROWindow", "RIGHT", 5, 0);
		frame:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5');
		if ConRO.db.profile.enablePurgeWindow == true and ConRO.db.profile.unlockWindow == true then
			frame:Show();
		else
			frame:Hide();
		end

	local t = frame.texture;
		if not t then
			t = frame:CreateTexture("ARTWORK")
			t:SetTexture('Interface\\AddOns\\ConRO\\images\\magiccircle-purge');
			t:SetBlendMode('BLEND');
			t:SetAlpha(ConRO.db.profile.transparencyWindow);
			t:SetVertexColor(.1, .1, .1);
			frame.texture = t;
		end
		
		t:SetAllPoints(frame)		
end


function ConRO:FindKeybinding(id)
	local keybind;
	if self.Keybinds[id] ~= nil then
		for k, button in pairs(self.Keybinds[id]) do
			for i = 1, 12 do
				if button == 'ElvUI_Bar1Button' .. i then
					button = 'ACTIONBUTTON' .. i;
				elseif button == 'MultiBarBottomLeftButton' .. i or button == 'ElvUI_Bar3Button' .. i then
					button = 'MULTIACTIONBAR1BUTTON' .. i;
				elseif button == 'MultiBarBottomRightButton' .. i or button == 'ElvUI_Bar2Button' .. i then
					button = 'MULTIACTIONBAR2BUTTON' .. i;
				elseif button == 'MultiBarRightButton' .. i or button == 'ElvUI_Bar5Button' .. i then
					button = 'MULTIACTIONBAR3BUTTON' .. i;
				elseif button == 'MultiBarLeftButton' .. i or button == 'ElvUI_Bar4Button' .. i then
					button = 'MultiActionBar4Button' .. i;
				end
				
				keybind = GetBindingKey(button);				
			end
		end
	end

	return keybind;
end

function ConRO:CreateDamageOverlay(parent, id)
	local frame = tremove(self.DamageFramePool);
	if not frame then
		frame = CreateFrame('Frame', 'ConRO_DamageOverlay_' .. id, parent);
	end
	
	frame:SetParent(parent);
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('6');
	frame:SetPoint('CENTER', 0, 5);
	frame:SetWidth(parent:GetWidth() * 1.6);
	frame:SetHeight(parent:GetHeight() * 1.8);
	frame:SetScale(ConRO.db.profile.overlayScale);
	local alpha = 0;
	local alphaSet = ConRO.db.profile.damageOverlayAlpha;
		if alphaSet == true then
			alpha = 1;
		end
	frame:SetAlpha(alpha);
	
	local t = frame.texture;
	if not t then
		t = frame:CreateTexture('GlowDamageOverlay', 'OVERLAY');
		t:SetTexture('Interface\\AddOns\\ConRO\\images\\skull');
		t:SetBlendMode('ADD');
		frame.texture = t;
	end

	t:SetAllPoints(frame);
	local color = ConRO.db.profile.damageOverlayColor;
	t:SetVertexColor(color.r, color.g, color.b);
	t:SetAlpha(color.a);

	tinsert(self.DamageFrames, frame);
	return frame;
end

function ConRO:CreateDefenseOverlay(parent, id)
	local frame = tremove(self.DefenseFramePool);
	if not frame then
		frame = CreateFrame('Frame', 'ConRO_DefenseOverlay_' .. id, parent);
	end

	frame:SetParent(parent);
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('6')
	frame:SetPoint('CENTER', 0, 0);
	frame:SetWidth(parent:GetWidth() * 1.6);
	frame:SetHeight(parent:GetHeight() * 1.5);
	frame:SetScale(ConRO.db.profile.overlayScale)
	local alpha = 0;
	local alphaSet = ConRO.db.profile.defenseOverlayAlpha;
		if alphaSet == true then
			alpha = 1;
		end
	frame:SetAlpha(alpha);

	local t = frame.texture;
	if not t then
		t = frame:CreateTexture('GlowDefenseOverlay', 'OVERLAY');
		t:SetTexture('Interface\\AddOns\\ConRO\\images\\shield2');
		t:SetBlendMode('ADD');
		frame.texture = t;
	end

	t:SetAllPoints(frame);
	local color = ConRO.db.profile.defenseOverlayColor;
	t:SetVertexColor(color.r, color.g, color.b);
	t:SetAlpha(color.a);
	
	tinsert(self.DefenseFrames, frame);
	return frame;
end

function ConRO:CreateInterruptOverlay(parent, id)
	local frame = tremove(self.InterruptFramePool);
	if not frame then
		frame = CreateFrame('Frame', 'ConRO_InterruptOverlay_' .. id, parent);
	end

	frame:SetParent(parent);
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('6')
	frame:SetPoint('CENTER', 0, 0);
	frame:SetWidth(parent:GetWidth() * 1.8);
	frame:SetHeight(parent:GetHeight() * 1.8);
	frame:SetScale(ConRO.db.profile.overlayScale)
	local alpha = 0;
	local alphaSet = ConRO.db.profile.notifierOverlayAlpha;
		if alphaSet == true then
			alpha = 1;
		end
	frame:SetAlpha(alpha);

	local t = frame.texture;
	if not t then
		t = frame:CreateTexture('AbilityInterruptOverlay', 'OVERLAY');
		t:SetTexture('Interface\\AddOns\\ConRO\\images\\lightning');
		t:SetBlendMode('BLEND');
		frame.texture = t;
	end

	t:SetAllPoints(frame);
	local color = ConRO.db.profile.interruptOverlayColor;
	t:SetVertexColor(color.r, color.g, color.b);
	t:SetAlpha(color.a);
	
	tinsert(self.InterruptFrames, frame);
	return frame;
end

function ConRO:CreatePurgableOverlay(parent, id)
	local frame = tremove(self.PurgableFramePool);
	if not frame then
		frame = CreateFrame('Frame', 'ConRO_PurgableOverlay_' .. id, parent);
	end

	frame:SetParent(parent);
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('6')
	frame:SetPoint('CENTER', 0, 0);
	frame:SetWidth(parent:GetWidth() * 2);
	frame:SetHeight(parent:GetHeight() * 2);
	frame:SetScale(ConRO.db.profile.overlayScale)
	local alpha = 0;
	local alphaSet = ConRO.db.profile.notifierOverlayAlpha;
		if alphaSet == true then
			alpha = 1;
		end
	frame:SetAlpha(alpha);

	local t = frame.texture;
	if not t then
		t = frame:CreateTexture('AbilityPurgeOverlay', 'OVERLAY');
		t:SetTexture('Interface\\AddOns\\ConRO\\images\\magiccircle');
		t:SetBlendMode('BLEND');
		frame.texture = t;
	end

	t:SetAllPoints(frame);
	local color = ConRO.db.profile.purgeOverlayColor;
	t:SetVertexColor(color.r, color.g, color.b);
	t:SetAlpha(color.a);
	
	tinsert(self.PurgableFrames, frame);
	return frame;
end

function ConRO:CreateTauntOverlay(parent, id)
	local frame = tremove(self.TauntFramePool);
	if not frame then
		frame = CreateFrame('Frame', 'ConRO_TauntOverlay_' .. id, parent);
	end

	frame:SetParent(parent);
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('6')
	frame:SetPoint('CENTER', 0, 0);
	frame:SetWidth(parent:GetWidth() * 1.5);
	frame:SetHeight(parent:GetHeight() * 1.5);
	frame:SetScale(ConRO.db.profile.overlayScale)
	local alpha = 0;
	local alphaSet = ConRO.db.profile.defenseOverlayAlpha;
		if alphaSet == true then
			alpha = 1;
		end
	frame:SetAlpha(alpha);

	local t = frame.texture;
	if not t then
		t = frame:CreateTexture('AbilityTauntOverlay', 'OVERLAY');
		t:SetTexture('Interface\\AddOns\\ConRO\\images\\rage');
		t:SetBlendMode('BLEND');
		frame.texture = t;
	end

	t:SetAllPoints(frame);
	local color = ConRO.db.profile.tauntOverlayColor;
	t:SetVertexColor(color.r, color.g, color.b);
	t:SetAlpha(color.a);
	
	tinsert(self.TauntFrames, frame);
	return frame;
end

function ConRO:CreateRaidBuffsOverlay(parent, id)
	local frame = tremove(self.RaidBuffsFramePool);
	if not frame then
		frame = CreateFrame('Frame', 'ConRO_RaidBuffsOverlay_' .. id, parent);
	end

	frame:SetParent(parent);
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('6')
	frame:SetPoint('CENTER', 0, 0);
	frame:SetWidth(parent:GetWidth() * 1.5);
	frame:SetHeight(parent:GetHeight() * 1.65);
	frame:SetScale(ConRO.db.profile.overlayScale)
	local alpha = 0;
	local alphaSet = ConRO.db.profile.notifierOverlayAlpha;
		if alphaSet == true then
			alpha = 1;
		end
	frame:SetAlpha(alpha);

	local t = frame.texture;
	if not t then
		t = frame:CreateTexture('AbilityRaidBuffsOverlay', 'OVERLAY');
		t:SetTexture('Interface\\AddOns\\ConRO\\images\\plus');
		t:SetBlendMode('BLEND');
		frame.texture = t;
	end

	t:SetAllPoints(frame);
	local color = ConRO.db.profile.raidbuffsOverlayColor;
	t:SetVertexColor(color.r, color.g, color.b);
	t:SetAlpha(color.a);
	
	tinsert(self.RaidBuffsFrames, frame);
	return frame;
end

function ConRO:CreateMovementOverlay(parent, id)
	local frame = tremove(self.MovementFramePool);
	if not frame then
		frame = CreateFrame('Frame', 'ConRO_MovementOverlay_' .. id, parent);
	end

	frame:SetParent(parent);
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('6')
	frame:SetPoint('CENTER', 0, -3);
	frame:SetWidth(parent:GetWidth() * 1.65);
	frame:SetHeight(parent:GetHeight() * 1.85);
	frame:SetScale(ConRO.db.profile.overlayScale)
	local alpha = 0;
	local alphaSet = ConRO.db.profile.notifierOverlayAlpha;
		if alphaSet == true then
			alpha = 1;
		end
	frame:SetAlpha(alpha);

	local t = frame.texture;
	if not t then
		t = frame:CreateTexture('AbilityMovementOverlay', 'OVERLAY');
		t:SetTexture('Interface\\AddOns\\ConRO\\images\\arrow');
		t:SetBlendMode('BLEND');
		frame.texture = t;
	end

	t:SetAllPoints(frame);
	local color = ConRO.db.profile.movementOverlayColor;
	t:SetVertexColor(color.r, color.g, color.b);
	t:SetAlpha(color.a);
	
	tinsert(self.MovementFrames, frame);
	return frame;
end

function ConRO:CreateCoolDownOverlay(parent, id)
	local frame = tremove(self.CoolDownFramePool);
	if not frame then
		frame = CreateFrame('Frame', 'ConRO_CoolDownOverlay_' .. id, parent);
	end

	frame:SetParent(parent);
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('6')
	frame:SetPoint('CENTER', 0, 0);
	frame:SetWidth(parent:GetWidth() * 1.7);
	frame:SetHeight(parent:GetHeight() * 1.7);
	frame:SetScale(ConRO.db.profile.overlayScale)
	local alpha = 0;
	local alphaSet = ConRO.db.profile.damageOverlayAlpha;
		if alphaSet == true then
			alpha = 1;
		end
	frame:SetAlpha(alpha);

	local t = frame.texture;
	if not t then
		t = frame:CreateTexture('AbilityBurstOverlay', 'OVERLAY');
		t:SetTexture('Interface\\AddOns\\ConRO\\images\\starburst');
		t:SetBlendMode('ADD');
		frame.texture = t;
	end

	t:SetAllPoints(frame);
	local color = ConRO.db.profile.cooldownOverlayColor;
	t:SetVertexColor(color.r, color.g, color.b);
	t:SetAlpha(color.a);
	
	tinsert(self.CoolDownFrames, frame);
	return frame;
end

function ConRO:DestroyDamageOverlays()
	local frame;
	for key, frame in pairs(self.DamageFrames) do
		frame:GetParent().ConRODamageOverlays = nil;
		frame:ClearAllPoints();
		frame:Hide();
		frame:SetParent(UIParent);
		frame.width = nil;
		frame.height = nil;
		frame.alpha = nil;
	end
	for key, frame in pairs(self.DamageFrames) do
		tinsert(self.DamageFramePool, frame);
		self.DamageFrames[key] = nil;
	end
end

function ConRO:DestroyInterruptOverlays()
	local frame;
	for key, frame in pairs(self.InterruptFrames) do
		frame:GetParent().ConROInterruptOverlays = nil;
		frame:ClearAllPoints();
		frame:Hide();
		frame:SetParent(UIParent);
		frame.width = nil;
		frame.height = nil;
		frame.alpha = nil;
	end
	for key, frame in pairs(self.InterruptFrames) do
		tinsert(self.InterruptFramePool, frame);
		self.InterruptFrames[key] = nil;
	end
end

function ConRO:DestroyPurgableOverlays()
	local frame;
	for key, frame in pairs(self.PurgableFrames) do
		frame:GetParent().ConROPurgableOverlays = nil;
		frame:ClearAllPoints();
		frame:Hide();
		frame:SetParent(UIParent);
		frame.width = nil;
		frame.height = nil;
		frame.alpha = nil;
	end
	for key, frame in pairs(self.PurgableFrames) do
		tinsert(self.PurgableFramePool, frame);
		self.PurgableFrames[key] = nil;
	end
end

function ConRO:DestroyTauntOverlays()
	local frame;
	for key, frame in pairs(self.TauntFrames) do
		frame:GetParent().ConROTauntOverlays = nil;
		frame:ClearAllPoints();
		frame:Hide();
		frame:SetParent(UIParent);
		frame.width = nil;
		frame.height = nil;
		frame.alpha = nil;
	end
	for key, frame in pairs(self.TauntFrames) do
		tinsert(self.TauntFramePool, frame);
		self.TauntFrames[key] = nil;
	end
end

function ConRO:DestroyRaidBuffsOverlays()
	local frame;
	for key, frame in pairs(self.RaidBuffsFrames) do
		frame:GetParent().ConRORaidBuffsOverlays = nil;
		frame:ClearAllPoints();
		frame:Hide();
		frame:SetParent(UIParent);
		frame.width = nil;
		frame.height = nil;
		frame.alpha = nil;
	end
	for key, frame in pairs(self.RaidBuffsFrames) do
		tinsert(self.RaidBuffsFramePool, frame);
		self.RaidBuffsFrames[key] = nil;
	end
end

function ConRO:DestroyMovementOverlays()
	local frame;
	for key, frame in pairs(self.MovementFrames) do
		frame:GetParent().ConROMovementOverlays = nil;
		frame:ClearAllPoints();
		frame:Hide();
		frame:SetParent(UIParent);
		frame.width = nil;
		frame.height = nil;
		frame.alpha = nil;
	end
	for key, frame in pairs(self.MovementFrames) do
		tinsert(self.MovementFramePool, frame);
		self.MovementFrames[key] = nil;
	end
end

function ConRO:DestroyCoolDownOverlays()
	local frame;
	for key, frame in pairs(self.CoolDownFrames) do
		frame:GetParent().ConROCoolDownOverlays = nil;
		frame:ClearAllPoints();
		frame:Hide();
		frame:SetParent(UIParent);
		frame.width = nil;
		frame.height = nil;
		frame.alpha = nil;
	end
	for key, frame in pairs(self.CoolDownFrames) do
		tinsert(self.CoolDownFramePool, frame);
		self.CoolDownFrames[key] = nil;
	end
end

function ConRO:DestroyDefenseOverlays()
	local frame;
	for key, frame in pairs(self.DefenseFrames) do
		frame:GetParent().ConRODefenseOverlays = nil;
		frame:ClearAllPoints();
		frame:Hide();
		frame:SetParent(UIParent);
		frame.width = nil;
		frame.height = nil;
		frame.alpha = nil;
	end
	for key, frame in pairs(self.DefenseFrames) do
		tinsert(self.DefenseFramePool, frame);
		self.DefenseFrames[key] = nil;
	end
end

function ConRO:UpdateButtonGlow()
	local LAB;
	local LBG;
	local origShow;
	local noFunction = function() end;

	if IsAddOnLoaded('ElvUI') then
		LAB = LibStub:GetLibrary('LibActionButton-1.0-ElvUI');
		LBG = LibStub:GetLibrary('LibButtonGlow-1.0');
		origShow = LBG.ShowOverlayGlow;
	elseif IsAddOnLoaded('Bartender4') then
		LAB = LibStub:GetLibrary('LibActionButton-1.0');
	end

	if self.db.profile.disableButtonGlow then
		ActionBarActionEventsFrame:UnregisterEvent('SPELL_ACTIVATION_OVERLAY_GLOW_SHOW');
		if LAB then
			LAB.eventFrame:UnregisterEvent('SPELL_ACTIVATION_OVERLAY_GLOW_SHOW');
		end

		if LBG then
			LBG.ShowOverlayGlow = noFunction;
		end
	else
		ActionBarActionEventsFrame:RegisterEvent('SPELL_ACTIVATION_OVERLAY_GLOW_SHOW');
		if LAB then
			LAB.eventFrame:RegisterEvent('SPELL_ACTIVATION_OVERLAY_GLOW_SHOW');
		end

		if LBG then
			LBG.ShowOverlayGlow = origShow;
		end
	end
end

function ConRO:DamageGlow(button, id)
	if button.ConRODamageOverlays and button.ConRODamageOverlays[id] then
		button.ConRODamageOverlays[id]:Show();
	else
		if not button.ConRODamageOverlays then
			button.ConRODamageOverlays = {};
		end

		button.ConRODamageOverlays[id] = self:CreateDamageOverlay(button, id);
		button.ConRODamageOverlays[id]:Show();
	end
end

function ConRO:DefenseGlow(button, id)
	if button.ConRODefenseOverlays and button.ConRODefenseOverlays[id] then
		button.ConRODefenseOverlays[id]:Show();
	else
		if not button.ConRODefenseOverlays then
			button.ConRODefenseOverlays = {};
		end

		button.ConRODefenseOverlays[id] = self:CreateDefenseOverlay(button, id);
		button.ConRODefenseOverlays[id]:Show();
	end
end

function ConRO:InterruptGlow(button, id)
	if button.ConROInterruptOverlays and button.ConROInterruptOverlays[id] then
		button.ConROInterruptOverlays[id]:Show();
	else
		if not button.ConROInterruptOverlays then
			button.ConROInterruptOverlays = {};
		end

		button.ConROInterruptOverlays[id] = self:CreateInterruptOverlay(button, id);
		button.ConROInterruptOverlays[id]:Show();
	end
end

function ConRO:PurgableGlow(button, id)
	if button.ConROPurgableOverlays and button.ConROPurgableOverlays[id] then
		button.ConROPurgableOverlays[id]:Show();
	else
		if not button.ConROPurgableOverlays then
			button.ConROPurgableOverlays = {};
		end

		button.ConROPurgableOverlays[id] = self:CreatePurgableOverlay(button, id);
		button.ConROPurgableOverlays[id]:Show();
	end
end

function ConRO:TauntGlow(button, id)
	if button.ConROTauntOverlays and button.ConROTauntOverlays[id] then
		button.ConROTauntOverlays[id]:Show();
	else
		if not button.ConROTauntOverlays then
			button.ConROTauntOverlays = {};
		end

		button.ConROTauntOverlays[id] = self:CreateTauntOverlay(button, id);
		button.ConROTauntOverlays[id]:Show();
	end
end

function ConRO:RaidBuffsGlow(button, id)
	if button.ConRORaidBuffsOverlays and button.ConRORaidBuffsOverlays[id] then
		button.ConRORaidBuffsOverlays[id]:Show();
	else
		if not button.ConRORaidBuffsOverlays then
			button.ConRORaidBuffsOverlays = {};
		end

		button.ConRORaidBuffsOverlays[id] = self:CreateRaidBuffsOverlay(button, id);
		button.ConRORaidBuffsOverlays[id]:Show();
	end
end

function ConRO:MovementGlow(button, id)
	if button.ConROMovementOverlays and button.ConROMovementOverlays[id] then
		button.ConROMovementOverlays[id]:Show();
	else
		if not button.ConROMovementOverlays then
			button.ConROMovementOverlays = {};
		end

		button.ConROMovementOverlays[id] = self:CreateMovementOverlay(button, id);
		button.ConROMovementOverlays[id]:Show();
	end
end

function ConRO:CoolDownGlow(button, id)
	if button.ConROCoolDownOverlays and button.ConROCoolDownOverlays[id] then
		button.ConROCoolDownOverlays[id]:Show();
	else
		if not button.ConROCoolDownOverlays then
			button.ConROCoolDownOverlays = {};
		end

		button.ConROCoolDownOverlays[id] = self:CreateCoolDownOverlay(button, id);
		button.ConROCoolDownOverlays[id]:Show();
	end
end

function ConRO:HideDamageGlow(button, id)
	if button.ConRODamageOverlays and button.ConRODamageOverlays[id] then
		button.ConRODamageOverlays[id]:Hide();
	end
end

function ConRO:HideDefenseGlow(button, id)
	if button.ConRODefenseOverlays and button.ConRODefenseOverlays[id] then
		button.ConRODefenseOverlays[id]:Hide();
	end
end

function ConRO:HideCoolDownGlow(button, id)
	if button.ConROCoolDownOverlays and button.ConROCoolDownOverlays[id] then
		button.ConROCoolDownOverlays[id]:Hide();
	end
end

function ConRO:HideInterruptGlow(button, id)
	if button.ConROInterruptOverlays and button.ConROInterruptOverlays[id] then
		button.ConROInterruptOverlays[id]:Hide();
	end
end

function ConRO:HidePurgableGlow(button, id)
	if button.ConROPurgableOverlays and button.ConROPurgableOverlays[id] then
		button.ConROPurgableOverlays[id]:Hide();
	end
end

function ConRO:HideTauntGlow(button, id)
	if button.ConROTauntOverlays and button.ConROTauntOverlays[id] then
		button.ConROTauntOverlays[id]:Hide();
	end
end

function ConRO:HideRaidBuffsGlow(button, id)
	if button.ConRORaidBuffsOverlays and button.ConRORaidBuffsOverlays[id] then
		button.ConRORaidBuffsOverlays[id]:Hide();
	end
end

function ConRO:HideMovementGlow(button, id)
	if button.ConROMovementOverlays and button.ConROMovementOverlays[id] then
		button.ConROMovementOverlays[id]:Hide();
	end
end
	
function ConRO:UpdateRotation()	
	self = ConRO;
	
	self:FetchBlizzard();
	
	if IsAddOnLoaded('Bartender4') then
		self:FetchBartender4();
	end

	if IsAddOnLoaded('ButtonForge') then
		self:FetchButtonForge();
	end
	
	if IsAddOnLoaded('ElvUI') then
		self:FetchElvUI();
	end
	
	if IsAddOnLoaded('Dominos') then
		self:FetchDominos();
	end
	
    if IsAddOnLoaded('DiabolicUI') then
        self:FetchDiabolic();
    end
 
    if IsAddOnLoaded('AzeriteUI') then
        self:FetchAzeriteUI();
    end
end

function ConRO:AddButton(spellID, button, hotkey)
	if spellID then
		if self.Spells[spellID] == nil then
			self.Spells[spellID] = {};
		end
		tinsert(self.Spells[spellID], button);
		
		if self.Keybinds[spellID] == nil then
			self.Keybinds[spellID] = {};
		end

		tinsert(self.Keybinds[spellID], hotkey);
	end
end

function ConRO:AddStandardButton(button, hotkey)
	local type = button:GetAttribute('type');
	if type then
		local actionType = button:GetAttribute(type);
		local id;
		local spellId;

        if type == 'action' then
            local slot = button:GetAttribute('action');
            if not slot or slot == 0 then
                slot = button:GetPagedID();
            end
            if not slot or slot == 0 then
                slot = button:CalculateAction();
            end
 
            if HasAction(slot) then
                type, id = GetActionInfo(slot);
            else
                return;
            end
        end
 
        if type == 'macro' then
            spellId = GetMacroSpell(id);
            if not spellId then
                return;
            end
        elseif type == 'item' then
            spellId = id;
        elseif type == 'spell' then
            spellId = select(7, GetSpellInfo(id));
        end

		self:AddButton(spellId, button, hotkey);
	end
end

function ConRO:DefAddButton(spellID, button, hotkey)
	if spellID then
		if self.DefSpells[spellID] == nil then
			self.DefSpells[spellID] = {};
		end
		tinsert(self.DefSpells[spellID], button);
		
		if self.Keybinds[spellID] == nil then
			self.Keybinds[spellID] = {};
		end

		tinsert(self.Keybinds[spellID], hotkey);
	end
end

function ConRO:DefAddStandardButton(button, hotkey)
	local type = button:GetAttribute('type');
	if type then
		local actionType = button:GetAttribute(type);
		local id;
		local spellId;

        if type == 'action' then
            local slot = button:GetAttribute('action');
            if not slot or slot == 0 then
                slot = button:GetPagedID();
            end
            if not slot or slot == 0 then
                slot = button:CalculateAction();
            end
 
            if HasAction(slot) then
                type, id = GetActionInfo(slot);
            else
                return;
            end
        end
 
        if type == 'macro' then
            spellId = GetMacroSpell(id);
            if not spellId then
                return;
            end
        elseif type == 'item' then
            spellId = id;
        elseif type == 'spell' then
            spellId = select(7, GetSpellInfo(id));
        end

		self:DefAddButton(spellId, button, hotkey);
	end
end

function ConRO:Fetch()
	self = ConRO;
	if self.rotationEnabled then
		self:DisableRotationTimer();
	end
	self.Spell = nil;

	self:GlowClear();
	self.Spells = {};
	self.Keybinds = {};
	self.Flags = {};
	self.SpellsGlowing = {};
	
	self:FetchBlizzard();
	

	if IsAddOnLoaded('Bartender4') then
		self:FetchBartender4();
	end

	if IsAddOnLoaded('ButtonForge') then
		self:FetchButtonForge();
	end
	
	if IsAddOnLoaded('ElvUI') then
		self:FetchElvUI();
	end
	
	if IsAddOnLoaded('Dominos') then
		self:FetchDominos();
	end
	
    if IsAddOnLoaded('DiabolicUI') then
        self:FetchDiabolic();
    end
 
    if IsAddOnLoaded('AzeriteUI') then
        self:FetchAzeriteUI();
    end	

	if self.rotationEnabled then
		self:EnableRotationTimer();
		self:InvokeNextSpell();
	end
end

function ConRO:FetchDef()
	self = ConRO;
	if self.defenseEnabled then
		self:DisableDefenseTimer();
	end
	self.Def = nil;

	self:GlowClearDef();
	self.DefSpells = {};
	self.Flags = {};
	self.DefGlowing = {};
	
	self:DefFetchBlizzard();
		
	if IsAddOnLoaded('Bartender4') then
		self:DefFetchBartender4();
	end

	if IsAddOnLoaded('ButtonForge') then
		self:DefFetchButtonForge();
	end
	
	if IsAddOnLoaded('ElvUI') then
		self:DefFetchElvUI();
	end
	
	if IsAddOnLoaded('Dominos') then
		self:DefFetchDominos();
	end

	if IsAddOnLoaded('DiabolicUI') then
        self:DefFetchDiabolic();
    end
 
    if IsAddOnLoaded('AzeriteUI') then
        self:DefFetchAzeriteUI();
    end	
	
	if self.defenseEnabled then
		self:EnableDefenseTimer();
		self:InvokeNextDef();
	end
end

function ConRO:FetchBlizzard()
	local ActionBarsBlizzard = {'Action', 'MultiBarBottomLeft', 'MultiBarBottomRight', 'MultiBarRight', 'MultiBarLeft', 'Stance', 'PetAction'};
	for _, barName in pairs(ActionBarsBlizzard) do
		if barName == 'Stance' then
			local x = GetNumShapeshiftForms();
			for i = 1, x do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = 'SHAPESHIFTBUTTON' .. i;
				local spellID = select(4, GetShapeshiftFormInfo(i));
				self:AddButton(spellID, button, hotkey);
			end
		elseif barName == 'PetAction' then
			for i = 1, 10 do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = barName .. 'Button' .. i;
				local spellID = select(7, GetPetActionInfo(i));
				self:AddButton(spellID, button, hotkey);
			end	
		else
			for i = 1, 12 do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = barName .. 'Button' .. i;
				self:AddStandardButton(button, hotkey);
			end
		end
	end
end

function ConRO:DefFetchBlizzard()
	local ActionBarsBlizzard = {'Action', 'MultiBarBottomLeft', 'MultiBarBottomRight', 'MultiBarRight', 'MultiBarLeft', 'Stance', 'PetAction'};
	for _, barName in pairs(ActionBarsBlizzard) do
		if barName == 'Stance' then
			local x = GetNumShapeshiftForms();
			for i = 1, x do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = 'SHAPESHIFTBUTTON' .. i;
				local spellID = select(4, GetShapeshiftFormInfo(i));
				self:DefAddButton(spellID, button, hotkey);
			end
		elseif barName == 'PetAction' then
			for i = 1, 10 do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = barName .. 'Button' .. i;
				local spellID = select(7, GetPetActionInfo(i));
				self:DefAddButton(spellID, button, hotkey);
			end	
		else
			for i = 1, 12 do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = barName .. 'Button' .. i;
				self:DefAddStandardButton(button, hotkey);
			end
		end
	end
end


function ConRO:FetchDominos()
	for i = 1, 60 do
		local button = _G['DominosActionButton' .. i];
		if button then
			local slot = button:GetPagedID() or button:CalculateAction() or button:GetAttribute('action') or 0;
			if HasAction(slot) then
				local spellID, _;
				local actionType, id = GetActionInfo(slot);
				if actionType == 'macro' then id = GetMacroSpell(id) end
				if actionType == 'item' then
					spellID = id;
				elseif actionType == 'spell' or (actionType == 'macro' and id) then
					spellID = id;
				end
				if spellID then
					if self.Spells[spellID] == nil then
						self.Spells[spellID] = {};
					end

					tinsert(self.Spells[spellID], button);
					
					if self.Keybinds[spellID] == nil then
						self.Keybinds[spellID] = {};
					end
					
					tinsert(self.Keybinds[spellID], 'DominosActionButton' .. i);
										
				end
			end
		end
	end
end

function ConRO:DefFetchDominos()
	for i = 1, 60 do
		local button = _G['DominosActionButton' .. i];
		if button then
			local slot = button:GetPagedID() or button:CalculateAction() or button:GetAttribute('action') or 0;
			if HasAction(slot) then
				local spellID, _;
				local actionType, id = GetActionInfo(slot);
				if actionType == 'macro' then id = GetMacroSpell(id) end
				if actionType == 'item' then
					spellID = id;
				elseif actionType == 'spell' or (actionType == 'macro' and id) then
					spellID = id;
				end
				if spellID then
					if self.DefSpells[spellID] == nil then
						self.DefSpells[spellID] = {};
					end

					tinsert(self.DefSpells[spellID], button);
					
					if self.Keybinds[spellID] == nil then
						self.Keybinds[spellID] = {};
					end
					
					tinsert(self.Keybinds[spellID], 'DominosActionButton' .. i);
					
				end
			end
		end
	end
end

function ConRO:FetchButtonForge()
	local i = 1;
	while true do
		local button = _G['ButtonForge' .. i];
		if not button then
			break;
		end
		i = i + 1;

		local type = button:GetAttribute('type');
		if type then
			local actionType = button:GetAttribute(type);
			local id;
			local spellId;
			if type == 'macro' then
				local id = GetMacroSpell(actionType);
				if id then
					spellId = select(7, GetSpellInfo(id));
				end
			elseif type == 'item' then
				actionName = GetItemInfo(actionType);
			elseif type == 'spell' then
				spellId = select(7, GetSpellInfo(actionType));
			end
			if spellId then
				if self.Spells[spellId] == nil then
					self.Spells[spellId] = {};
				end

				tinsert(self.Spells[spellId], button);
				
				if self.Keybinds[spellId] == nil then
					self.Keybinds[spellId] = {};
				end
				
				tinsert(self.Keybinds[spellId], 'ButtonForge' .. i);
				 	
			end
		end
	end
end

function ConRO:DefFetchButtonForge()
	local i = 1;
	while true do
		local button = _G['ButtonForge' .. i];
		if not button then
			break;
		end
		i = i + 1;

		local type = button:GetAttribute('type');
		if type then
			local actionType = button:GetAttribute(type);
			local id;
			local spellId;
			if type == 'macro' then
				local id = GetMacroSpell(actionType);
				if id then
					spellId = select(7, GetSpellInfo(id));
				end
			elseif type == 'item' then
				actionName = GetItemInfo(actionType);
			elseif type == 'spell' then
				spellId = select(7, GetSpellInfo(actionType));
			end
			if spellId then
				if self.DefSpells[spellId] == nil then
					self.DefSpells[spellId] = {};
				end

				tinsert(self.DefSpells[spellId], button);
				
				if self.Keybinds[spellId] == nil then
					self.Keybinds[spellId] = {};
				end
				
				tinsert(self.Keybinds[spellId], 'ButtonForge' .. i);
				
			end
		end
	end
end

function ConRO:FetchElvUI()
	local ret = false;
	for x = 1, 10 do
		for i = 1, 12 do
			local button = _G['ElvUI_Bar' .. x .. 'Button' .. i];
			if button then
				local spellId = button:GetSpellId();
				if spellId then
					local actionName, _ = GetSpellInfo(spellId);
					if spellId then
						if self.Spells[spellId] == nil then
							self.Spells[spellId] = {};
						end
						ret = true;
						tinsert(self.Spells[spellId], button);
						
						if self.Keybinds[spellId] == nil then
							self.Keybinds[spellId] = {};
						end
						
						tinsert(self.Keybinds[spellId], 'ElvUI_Bar' .. x .. 'Button' .. i);
						 	
					end
				end
			end
		end
	end
	return ret;
end

function ConRO:DefFetchElvUI()
	local ret = false;
	for x = 1, 10 do
		for i = 1, 12 do
			local button = _G['ElvUI_Bar' .. x .. 'Button' .. i];
			if button then
				local spellId = button:GetSpellId();
				if spellId then
					local actionName, _ = GetSpellInfo(spellId);
					if spellId then
						if self.DefSpells[spellId] == nil then
							self.DefSpells[spellId] = {};
						end
						ret = true;
						tinsert(self.DefSpells[spellId], button);
						
						if self.Keybinds[spellId] == nil then
							self.Keybinds[spellId] = {};
						end
						
						tinsert(self.Keybinds[spellId], 'ElvUI_Bar' .. x .. 'Button' .. i);
						
					end
				end
			end
		end
	end
	return ret;
end

function ConRO:FetchBartender4()
	local ActionBarsBartender4 = {'BT4','BT4Stance', 'BT4Pet'};
	for _, barName in pairs(ActionBarsBartender4) do
		if barName == 'BT4Stance' then
			local x = GetNumShapeshiftForms();
			for i = 1, x do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = 'CLICK BT4StanceButton' .. i .. ':LeftButton';
				local spellID = select(4, GetShapeshiftFormInfo(i));
				self:AddButton(spellID, button, hotkey);
			end
		elseif barName == 'BT4Pet' then
			for i = 1, 10 do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = 'CLICK BT4PetButton' .. i .. ':LeftButton';
				local spellID = select(7, GetPetActionInfo(i));
				self:AddButton(spellID, button, hotkey);
			end	
		else
			for i = 1, 120 do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = 'CLICK BT4Button' .. i .. ':LeftButton';
				if button then
					self:AddStandardButton(button, hotkey);
				end
			end
		end
	end
end

function ConRO:DefFetchBartender4()
	local ActionBarsBartender4 = {'BT4','BT4Stance', 'BT4Pet'};
	for _, barName in pairs(ActionBarsBartender4) do
		if barName == 'BT4Stance' then
			local x = GetNumShapeshiftForms();
			for i = 1, x do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = 'CLICK BT4StanceButton' .. i .. ':LeftButton';
				local spellID = select(4, GetShapeshiftFormInfo(i));
				self:DefAddButton(spellID, button, hotkey);
			end
		elseif barName == 'BT4Pet' then
			for i = 1, 10 do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = 'CLICK BT4PetButton' .. i .. ':LeftButton';
				local spellID = select(7, GetPetActionInfo(i));
				self:DefAddButton(spellID, button, hotkey);
			end	
		else
			for i = 1, 120 do
				local button = _G[barName .. 'Button' .. i];
				local hotkey = 'CLICK BT4Button' .. i .. ':LeftButton';
				if button then
					self:DefAddStandardButton(button, hotkey);
				end
			end
		end
	end
end

function ConRO:FetchDiabolic()
    local ActionBarsDiabolic = {'EngineBar1', 'EngineBar2', 'EngineBar3', 'EngineBar4', 'EngineBar5'};
    for _, barName in pairs(ActionBarsDiabolic) do
        for i = 1, 12 do
            local button = _G[barName .. 'Button' .. i];
            if button then
                self:AddStandardButton(button);
            end
        end
    end
end

function ConRO:DefFetchDiabolic()
    local ActionBarsDiabolic = {'EngineBar1', 'EngineBar2', 'EngineBar3', 'EngineBar4', 'EngineBar5'};
    for _, barName in pairs(ActionBarsDiabolic) do
        for i = 1, 12 do
            local button = _G[barName .. 'Button' .. i];
            if button then
                self:AddStandardButton(button);
            end
        end
    end
end

function ConRO:FetchAzeriteUI()
    for i = 1, 24 do
        local button = _G['AzeriteUIActionButton' .. i];
        if button then
            self:AddStandardButton(button);
        end
    end
end

function ConRO:DefFetchAzeriteUI()
    for i = 1, 24 do
        local button = _G['AzeriteUIActionButton' .. i];
        if button then
            self:AddStandardButton(button);
        end
    end
end

function ConRO:Dump()
	local s = '';
	for k, v in pairs(self.Spells) do
		s = s .. ', ' .. k;
	end
	print(s);
end

function ConRO:FindSpell(spellID)
	return self.Spells[spellID];
end

function ConRO:AbilityBurstIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:CoolDownGlow(button, id);
		end
	end
end

function ConRO:AbilityInterruptIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:InterruptGlow(button, id);
		end
	end
end

function ConRO:AbilityPurgeIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:PurgableGlow(button, id);
		end
	end
end

function ConRO:AbilityTauntIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:TauntGlow(button, id);
		end
	end
end

function ConRO:AbilityRaidBuffsIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:RaidBuffsGlow(button, id);
		end
	end
end

function ConRO:AbilityMovementIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:MovementGlow(button, id);
		end
	end
end

function ConRO:ClearAbilityBurstIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:HideCoolDownGlow(button, id);
		end
	end
end

function ConRO:ClearAbilityInterruptIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:HideInterruptGlow(button, id);
		end
	end
end

function ConRO:ClearAbilityPurgeIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:HidePurgableGlow(button, id);
		end
	end
end

function ConRO:ClearAbilityTauntIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:HideTauntGlow(button, id);
		end
	end
end

function ConRO:ClearAbilityRaidBuffsIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:HideRaidBuffsGlow(button, id);
		end
	end
end

function ConRO:ClearAbilityMovementIndependent(spellID, id)
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:HideMovementGlow(button, id);
		end
	end
end

function ConRO:AbilityBurst(spell, condition)
	local incombat = UnitAffectingCombat('player');
	
	if self.Flags[spell] == nil then
		self.Flags[spell] = false;
	end
	if condition and not self.Flags[spell] then
		self.Flags[spell] = true;
		self:AbilityBurstIndependent(spell, spell);
	end
	if not condition and self.Flags[spell] then
		self.Flags[spell] = false;
		self:ClearAbilityBurstIndependent(spell, spell);
	end
end

function ConRO:AbilityInterrupt(spell, condition)
	if self.Flags[spell] == nil then
		self.Flags[spell] = false;
		self:ClearAbilityInterruptIndependent(spell, spell);		--Trying out 8.2.8
		ConROInterruptWindow:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
		ConROInterruptWindow.texture:SetVertexColor(.1, .1, .1);
		if UIFrameIsFlashing(ConROInterruptWindow) then
			UIFrameFlashStop(ConROInterruptWindow);
			if ConRO.db.profile.unlockWindow == true and ConRO.db.profile.enableInterruptWindow == true then
				ConROInterruptWindow:Show();				
			end	
		end			
	end
	if condition and not self.Flags[spell] then
	local color = ConRO.db.profile.interruptOverlayColor;
		self.Flags[spell] = true;
		self:AbilityInterruptIndependent(spell, spell);
		ConROInterruptWindow:SetSize(ConRO.db.profile.flashIconSize * .75, ConRO.db.profile.flashIconSize * .75);
		ConROInterruptWindow.texture:SetVertexColor(color.r, color.g, color.b);
		if not UIFrameIsFlashing(ConROInterruptWindow) and ConRO.db.profile.enableInterruptWindow then
			UIFrameFlash(ConROInterruptWindow, 0.25, 0.25, -1);
		end
	end
	if not condition and self.Flags[spell] then
		self.Flags[spell] = false;
		self:ClearAbilityInterruptIndependent(spell, spell);
		ConROInterruptWindow:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
		ConROInterruptWindow.texture:SetVertexColor(.1, .1, .1);
		if UIFrameIsFlashing(ConROInterruptWindow) then
			UIFrameFlashStop(ConROInterruptWindow);
			if ConRO.db.profile.unlockWindow == true and ConRO.db.profile.enableInterruptWindow == true then
				ConROInterruptWindow:Show();				
			end			
		end		
	end
end

function ConRO:AbilityPurge(spell, condition)
	if self.Flags[spell] == nil then
		self.Flags[spell] = false;
		self:ClearAbilityPurgeIndependent(spell, spell);		
		ConROPurgeWindow:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
		ConROPurgeWindow.texture:SetVertexColor(.1, .1, .1);
		if UIFrameIsFlashing(ConROPurgeWindow) then
			UIFrameFlashStop(ConROPurgeWindow);
			if ConRO.db.profile.unlockWindow == true and ConRO.db.profile.enablePurgeWindow == true then
				ConROPurgeWindow:Show();				
			end
		end			
	end
	if condition and not self.Flags[spell] then
	local color = ConRO.db.profile.purgeOverlayColor;	
		self.Flags[spell] = true;
		self:AbilityPurgeIndependent(spell, spell);
		ConROPurgeWindow:SetSize(ConRO.db.profile.flashIconSize * .75, ConRO.db.profile.flashIconSize * .75);
		ConROPurgeWindow.texture:SetVertexColor(color.r, color.g, color.b);
		if not UIFrameIsFlashing(ConROPurgeWindow) and ConRO.db.profile.enablePurgeWindow then
			UIFrameFlash(ConROPurgeWindow, 0.25, 0.25, -1);
		end		
	end
	if not condition and self.Flags[spell] then
		self.Flags[spell] = false;
		self:ClearAbilityPurgeIndependent(spell, spell);
		ConROPurgeWindow:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
		ConROPurgeWindow.texture:SetVertexColor(.1, .1, .1);
		if UIFrameIsFlashing(ConROPurgeWindow) then
			UIFrameFlashStop(ConROPurgeWindow);
			if ConRO.db.profile.unlockWindow == true and ConRO.db.profile.enablePurgeWindow == true then
				ConROPurgeWindow:Show();				
			end			
		end			
	end
end

function ConRO:AbilityTaunt(spell, condition)
	if self.Flags[spell] == nil then
		self.Flags[spell] = false;
	end
	if condition and not self.Flags[spell] then
		self.Flags[spell] = true;
		self:AbilityTauntIndependent(spell, spell);
	end
	if not condition and self.Flags[spell] then
		self.Flags[spell] = false;
		self:ClearAbilityTauntIndependent(spell, spell);
	end
end

function ConRO:AbilityRaidBuffs(spell, condition)
	if self.Flags[spell] == nil then
		self.Flags[spell] = false;
	end
	if condition and not self.Flags[spell] then
		self.Flags[spell] = true;
		self:AbilityRaidBuffsIndependent(spell, spell);
	end
	if not condition and self.Flags[spell] then
		self.Flags[spell] = false;
		self:ClearAbilityRaidBuffsIndependent(spell, spell);
	end
end

function ConRO:AbilityMovement(spell, condition)
	if self.Flags[spell] == nil then
		self.Flags[spell] = false;
	end
	if condition and not self.Flags[spell] then
		self.Flags[spell] = true;
		self:AbilityMovementIndependent(spell, spell);
	end
	if not condition and self.Flags[spell] then
		self.Flags[spell] = false;
		self:ClearAbilityMovementIndependent(spell, spell);
	end
end

function ConRO:GlowSpell(spellID)
	local spellName = GetSpellInfo(spellID);
	if self.Spells[spellID] ~= nil then
		for k, button in pairs(self.Spells[spellID]) do
			self:DamageGlow(button, 'next');
		end
		self.SpellsGlowing[spellID] = 1;
	else
		self:Print(self.Colors.Error .. 'Spell not found on action bars: ' .. ' ' .. spellName .. ' ' .. '(' .. spellID .. ')');
	end
end

function ConRO:GlowDef(spellID)
	local spellName = GetSpellInfo(spellID);
	if self.DefSpells[spellID] ~= nil then
		for k, button in pairs(self.DefSpells[spellID]) do
			self:DefenseGlow(button, 'nextdef');
		end
		self.DefGlowing[spellID] = 1;
	else
		self:Print(self.Colors.Error .. 'Spell not found on action bars: ' .. ' ' .. spellName .. ' ' .. '(' .. spellID .. ')');
	end
end

function ConRO:GlowNextSpell(spellID)
	self:GlowClear();
	self:GlowSpell(spellID);
end

function ConRO:GlowNextDef(spellID)
	self:GlowClearDef();
	self:GlowDef(spellID);
end

function ConRO:GlowClear()
	for spellID, v in pairs(self.SpellsGlowing) do
		if v == 1 then
			for k, button in pairs(self.Spells[spellID]) do
				self:HideDamageGlow(button, 'next');
			end
			self.SpellsGlowing[spellID] = 0;
		end
	end
end

function ConRO:GlowClearDef()
	for spellID, v in pairs(self.DefGlowing) do
		if v == 1 then
			for k, button in pairs(self.DefSpells[spellID]) do
				self:HideDefenseGlow(button, 'nextdef');
			end
			self.DefGlowing[spellID] = 0;
		end
	end
end

local function TTOnEnter(self)
  GameTooltip:SetOwner(self, "ConROButtonFrame")
  GameTooltip:SetText("tooltipTitle")  -- This sets the top line of text, in gold.
  GameTooltip:AddLine("This is the contents of my tooltip", 1, 1, 1)
  GameTooltip:Show()
end

local function TTOnLeave(self)
  GameTooltip:Hide()
end