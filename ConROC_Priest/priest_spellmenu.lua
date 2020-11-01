local ConROC_Priest, ids = ...;

local lastFrame = 0;
local lastPoison = 0;
local lastDebuff = 0;
local lastBuff = 0;

local plvl = UnitLevel('player');

local defaults = {
	["ConROC_SM_Role_Caster"] = true,

	["ConROC_Caster_Debuff_ShadowWordPain"] = true,
	["ConROC_Caster_Debuff_HexofWeakness"] = true,
	["ConROC_Caster_Debuff_MindFlay"] = true,
	["ConROC_Caster_Debuff_HolyFire"] = true,
	["ConROC_Caster_Debuff_VampiricEmbrace"] = true,
	["ConROC_Caster_Buff_PowerWordFortitude"] = true,
	["ConROC_Caster_Buff_TouchofWeakness"] = true,
	["ConROC_Caster_Buff_ShadowProtection"] = true,
	["ConROC_Caster_Buff_DivineSpirit"] = true,	
}

ConROCPriestSpells = ConROCPriestSpells or defaults;

function ConROC:SpellmenuClass()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCSpellmenuClass", ConROCSpellmenuFrame2)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 30)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCSpellmenuFrame_Title", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)
		
	--Caster
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Role_Caster", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
			radio1:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -10);
			radio1:SetChecked(ConROCPriestSpells.ConROC_SM_Role_Caster);
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Role_Caster:SetChecked(true);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCPriestSpells.ConROC_SM_Role_Caster = ConROC_SM_Role_Caster:GetChecked();
					ConROCPriestSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio1text:SetText("Caster");
			radio1text:SetPoint("BOTTOM", radio1, "TOP", 0, 3);
		
	--PvP
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Role_PvP", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
			radio4:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -15, -10);
			radio4:SetChecked(ConROCPriestSpells.ConROC_SM_Role_PvP);
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Role_Caster:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(true);
					ConROCPriestSpells.ConROC_SM_Role_Caster = ConROC_SM_Role_Caster:GetChecked();
					ConROCPriestSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio4text:SetText("PvP");					
			radio4text:SetPoint("BOTTOM", radio4, "TOP", 0, 3);
			

		frame:Hide()
		lastFrame = frame;
	
	ConROC:CheckHeader1();
	ConROC:CheckHeader2();
	ConROC:CheckHeader3();
end

function ConROC:CheckHeader1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader1", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 1)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontDemons = frame:CreateFontString("ConROC_Spellmenu_CheckHeader1", "ARTWORK", "GameFontGreenSmall");
			fontDemons:SetText("Debuffs");
			fontDemons:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame1_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontDemons, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCCheckFrame1:Show();
					ConROC_CheckFrame1_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame1_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontDemons, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCCheckFrame1:Hide();
					ConROC_CheckFrame1_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:CheckFrame1();
end

function ConROC:CheckFrame1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame1", ConROCCheckHeader1)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCCheckHeader1", "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastDebuff = frame;
		lastFrame = frame;
		
	--Shadow Word: Pain
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.Shad_Ability.ShadowWordPainRank1); 
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Debuff_ShadowWordPain", frame, "UICheckButtonTemplate");
		local check1text = check1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check1:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_ShadowWordPain);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_ShadowWordPain);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Debuff_ShadowWordPain = ConROC_SM_Debuff_ShadowWordPain:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Debuff_ShadowWordPain = ConROC_SM_Debuff_ShadowWordPain:GetChecked();
					end
				end);
			check1text:SetText(c1tspellName);
			check1text:SetScale(2);
		local c1t = check1.texture;
			if not c1t then
				c1t = check1:CreateTexture('CheckFrame1_check1_Texture', 'ARTWORK');
				c1t:SetTexture(c1tspell);
				c1t:SetBlendMode('BLEND');
				check1.texture = c1t;
			end			
			c1t:SetScale(0.4);
			c1t:SetPoint("LEFT", check1, "RIGHT", 8, 0);
			check1text:SetPoint('LEFT', c1t, 'RIGHT', 5, 0);
			
		lastDebuff = check1;
		lastFrame = check1;

	--Hex of Weakness
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.Shad_Ability.HexofWeaknessRank1); 
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Debuff_HexofWeakness", frame, "UICheckButtonTemplate");
		local check2text = check2:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check2:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_HexofWeakness);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_HexofWeakness);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Debuff_HexofWeakness = ConROC_SM_Debuff_HexofWeakness:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Debuff_HexofWeakness = ConROC_SM_Debuff_HexofWeakness:GetChecked();
					end
				end);
			check2text:SetText(c2tspellName);	
			check2text:SetScale(2);
		local c2t = check2.texture;
			if not c2t then
				c2t = check2:CreateTexture('CheckFrame1_check2_Texture', 'ARTWORK');
				c2t:SetTexture(c2tspell);
				c2t:SetBlendMode('BLEND');
				check2.texture = c2t;
			end			
			c2t:SetScale(0.4);
			c2t:SetPoint("LEFT", check2, "RIGHT", 8, 0);
			check2text:SetPoint('LEFT', c2t, 'RIGHT', 5, 0);
			
		lastDebuff = check2;
		lastFrame = check2;

	--Holy Fire
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.Holy_Ability.HolyFireRank1); 
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Debuff_HolyFire", frame, "UICheckButtonTemplate");
		local check3text = check3:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check3:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_HolyFire);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_HolyFire);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Debuff_HolyFire = ConROC_SM_Debuff_HolyFire:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Debuff_HolyFire = ConROC_SM_Debuff_HolyFire:GetChecked();
					end
				end);
			check3text:SetText(c3tspellName);
			check3text:SetScale(2);
		local c3t = check3.texture;
			if not c3t then
				c3t = check3:CreateTexture('CheckFrame1_check3_Texture', 'ARTWORK');
				c3t:SetTexture(c3tspell);
				c3t:SetBlendMode('BLEND');
				check3.texture = c3t;
			end			
			c3t:SetScale(0.4);
			c3t:SetPoint("LEFT", check3, "RIGHT", 8, 0);
			check3text:SetPoint('LEFT', c3t, 'RIGHT', 5, 0);
			
		lastDebuff = check3;
		lastFrame = check3;

	--Mind Flay
		local c4tspellName, _, c4tspell = GetSpellInfo(ids.Shad_Ability.MindFlayRank1); 
		local check4 = CreateFrame("CheckButton", "ConROC_SM_Debuff_MindFlay", frame, "UICheckButtonTemplate");
		local check4text = check4:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check4:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			check4:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check4:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_MindFlay);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check4:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_MindFlay);
			end
			check4:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Debuff_MindFlay = ConROC_SM_Debuff_MindFlay:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Debuff_MindFlay = ConROC_SM_Debuff_MindFlay:GetChecked();
					end
				end);
			check4text:SetText(c4tspellName);	
			check4text:SetScale(2);
		local c4t = check4.texture;
			if not c4t then
				c4t = check4:CreateTexture('CheckFrame1_check4_Texture', 'ARTWORK');
				c4t:SetTexture(c4tspell);
				c4t:SetBlendMode('BLEND');
				check4.texture = c4t;
			end			
			c4t:SetScale(0.4);
			c4t:SetPoint("LEFT", check4, "RIGHT", 8, 0);
			check4text:SetPoint('LEFT', c4t, 'RIGHT', 5, 0);
			
		lastDebuff = check4;
		lastFrame = check4;
		
	--Vampiric Embrace
		local c5tspellName, _, c5tspell = GetSpellInfo(ids.Shad_Ability.VampiricEmbrace); 
		local check5 = CreateFrame("CheckButton", "ConROC_SM_Debuff_VampiricEmbrace", frame, "UICheckButtonTemplate");
		local check5text = check5:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check5:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			check5:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check5:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_VampiricEmbrace);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check5:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_VampiricEmbrace);
			end
			check5:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Debuff_VampiricEmbrace = ConROC_SM_Debuff_VampiricEmbrace:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Debuff_VampiricEmbrace = ConROC_SM_Debuff_VampiricEmbrace:GetChecked();
					end
				end);
			check5text:SetText(c5tspellName);
			check5text:SetScale(2);
		local c5t = check5.texture;
			if not c5t then
				c5t = check5:CreateTexture('CheckFrame1_check5_Texture', 'ARTWORK');
				c5t:SetTexture(c5tspell);
				c5t:SetBlendMode('BLEND');
				check5.texture = c5t;
			end			
			c5t:SetScale(0.4);
			c5t:SetPoint("LEFT", check5, "RIGHT", 8, 0);
			check5text:SetPoint('LEFT', c5t, 'RIGHT', 5, 0);
			
		lastDebuff = check5;
		lastFrame = check5;
		
		frame:Show()
end

function ConROC:CheckHeader2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader2", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 1)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontDemons = frame:CreateFontString("ConROC_Spellmenu_CheckHeader2", "ARTWORK", "GameFontGreenSmall");
			fontDemons:SetText("Buffs");
			fontDemons:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame2_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontDemons, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCCheckFrame2:Show();
					ConROC_CheckFrame2_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame2_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontDemons, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCCheckFrame2:Hide();
					ConROC_CheckFrame2_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:CheckFrame2();
end

function ConROC:CheckFrame2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame2", ConROCCheckHeader2)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCCheckHeader2", "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastBuff = frame;
		lastFrame = frame;
		
	--Power Word: Fortitude
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.Disc_Ability.PowerWordFortitudeRank1); 
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Buff_PowerWordFortitude", frame, "UICheckButtonTemplate");
		local check1text = check1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame2, "BOTTOM", -150, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check1:SetChecked(ConROCPriestSpells.ConROC_Caster_Buff_PowerWordFortitude);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCPriestSpells.ConROC_PvP_Buff_PowerWordFortitude);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Buff_PowerWordFortitude = ConROC_SM_Buff_PowerWordFortitude:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Buff_PowerWordFortitude = ConROC_SM_Buff_PowerWordFortitude:GetChecked();
					end
				end);
			check1text:SetText(c1tspellName);
			check1text:SetScale(2);
		local c1t = check1.texture;
			if not c1t then
				c1t = check1:CreateTexture('CheckFrame2_check1_Texture', 'ARTWORK');
				c1t:SetTexture(c1tspell);
				c1t:SetBlendMode('BLEND');
				check1.texture = c1t;
			end			
			c1t:SetScale(0.4);
			c1t:SetPoint("LEFT", check1, "RIGHT", 8, 0);
			check1text:SetPoint('LEFT', c1t, 'RIGHT', 5, 0);
			
		lastBuff = check1;
		lastFrame = check1;

	--Touch of Weakness
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.Shad_Ability.TouchofWeaknessRank1); 
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Buff_TouchofWeakness", frame, "UICheckButtonTemplate");
		local check2text = check2:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", lastBuff, "BOTTOM", 0, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check2:SetChecked(ConROCPriestSpells.ConROC_Caster_Buff_TouchofWeakness);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCPriestSpells.ConROC_PvP_Buff_TouchofWeakness);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Buff_TouchofWeakness = ConROC_SM_Buff_TouchofWeakness:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Buff_TouchofWeakness = ConROC_SM_Buff_TouchofWeakness:GetChecked();
					end
				end);
			check2text:SetText(c2tspellName);
			check2text:SetScale(2);
		local c2t = check2.texture;
			if not c2t then
				c2t = check2:CreateTexture('CheckFrame2_check2_Texture', 'ARTWORK');
				c2t:SetTexture(c2tspell);
				c2t:SetBlendMode('BLEND');
				check2.texture = c2t;
			end			
			c2t:SetScale(0.4);
			c2t:SetPoint("LEFT", check2, "RIGHT", 8, 0);
			check2text:SetPoint('LEFT', c2t, 'RIGHT', 5, 0);
			
		lastBuff = check2;
		lastFrame = check2;

	--Shadow Protection
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.Shad_Ability.ShadowProtectionRank1); 
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Buff_ShadowProtection", frame, "UICheckButtonTemplate");
		local check3text = check3:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOP", lastBuff, "BOTTOM", 0, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check3:SetChecked(ConROCPriestSpells.ConROC_Caster_Buff_ShadowProtection);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCPriestSpells.ConROC_PvP_Buff_ShadowProtection);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Buff_ShadowProtection = ConROC_SM_Buff_ShadowProtection:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Buff_ShadowProtection = ConROC_SM_Buff_ShadowProtection:GetChecked();
					end
				end);
			check3text:SetText(c3tspellName);
			check3text:SetScale(2);
		local c3t = check3.texture;
			if not c3t then
				c3t = check3:CreateTexture('CheckFrame2_check3_Texture', 'ARTWORK');
				c3t:SetTexture(c3tspell);
				c3t:SetBlendMode('BLEND');
				check3.texture = c3t;
			end			
			c3t:SetScale(0.4);
			c3t:SetPoint("LEFT", check3, "RIGHT", 8, 0);
			check3text:SetPoint('LEFT', c3t, 'RIGHT', 5, 0);
			
		lastBuff = check3;
		lastFrame = check3;

	--Divine Spirit
		local c4tspellName, _, c4tspell = GetSpellInfo(ids.Disc_Ability.DivineSpiritRank1); 
		local check4 = CreateFrame("CheckButton", "ConROC_SM_Buff_DivineSpirit", frame, "UICheckButtonTemplate");
		local check4text = check4:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check4:SetPoint("TOP", lastBuff, "BOTTOM", 0, 0);
			check4:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check4:SetChecked(ConROCPriestSpells.ConROC_Caster_Buff_DivineSpirit);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check4:SetChecked(ConROCPriestSpells.ConROC_PvP_Buff_DivineSpirit);
			end
			check4:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Buff_DivineSpirit = ConROC_SM_Buff_DivineSpirit:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Buff_DivineSpirit = ConROC_SM_Buff_DivineSpirit:GetChecked();
					end
				end);
			check4text:SetText(c4tspellName);
			check4text:SetScale(2);
		local c4t = check4.texture;
			if not c4t then
				c4t = check4:CreateTexture('CheckFrame2_check4_Texture', 'ARTWORK');
				c4t:SetTexture(c4tspell);
				c4t:SetBlendMode('BLEND');
				check4.texture = c4t;
			end			
			c4t:SetScale(0.4);
			c4t:SetPoint("LEFT", check4, "RIGHT", 8, 0);
			check4text:SetPoint('LEFT', c4t, 'RIGHT', 5, 0);
			
		lastBuff = check4;
		lastFrame = check4;
		
		frame:Show()
end

function ConROC:CheckHeader3()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader3", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontDemons = frame:CreateFontString("ConROC_Spellmenu_CheckHeader3", "ARTWORK", "GameFontGreenSmall");
			fontDemons:SetText("Options");
			fontDemons:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame3_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontDemons, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCCheckFrame3:Show();
					ConROC_CheckFrame3_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame3_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontDemons, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCCheckFrame3:Hide();
					ConROC_CheckFrame3_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:CheckFrame3();
end

function ConROC:CheckFrame3()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame3", ConROCCheckHeader3)
		
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('5')
	frame:SetSize(180, 5)
	frame:SetAlpha(1)
	
	frame:SetPoint("TOP", "ConROCCheckHeader3", "BOTTOM", 0, 0)
	frame:SetMovable(false)
	frame:EnableMouse(true)
	frame:SetClampedToScreen(true)

	lastOption = frame;
	lastFrame = frame;
		
	--Use Wand
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Option_UseWand", frame, "UICheckButtonTemplate");
		local check1text = check1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame3, "BOTTOM", -150, 0);			
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check1:SetChecked(ConROCPriestSpells.ConROC_Caster_Option_UseWand);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCPriestSpells.ConROC_PvP_Option_UseWand);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCPriestSpells.ConROC_Caster_Option_UseWand = ConROC_SM_Option_UseWand:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPriestSpells.ConROC_PvP_Option_UseWand = ConROC_SM_Option_UseWand:GetChecked();
					end
				end);
			check1text:SetText("Use Wand");
			check1text:SetScale(2);
			check1text:SetPoint("LEFT", check1, "RIGHT", 20, 0);
			
		lastOption = check1;
		lastFrame = check1;
		
		frame:Show()
end

function ConROC:SpellMenuUpdate()
	lastFrame = ConROCSpellmenuClass;
	
	if ConROCCheckFrame1 ~= nil then
		lastDebuff = ConROCCheckFrame1;
		
	--Debuff
		if plvl >= 4 and IsSpellKnown(ids.Shad_Ability.ShadowWordPainRank1) then 
			ConROC_SM_Debuff_ShadowWordPain:Show();
			lastDebuff = ConROC_SM_Debuff_ShadowWordPain;
		else
			ConROC_SM_Debuff_ShadowWordPain:Hide();
		end
		
		if plvl >= 10 and IsSpellKnown(ids.Shad_Ability.HexofWeaknessRank1) then 
			ConROC_SM_Debuff_HexofWeakness:Show();
			ConROC_SM_Debuff_HexofWeakness:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);			
			lastDebuff = ConROC_SM_Debuff_HexofWeakness;
		else
			ConROC_SM_Debuff_HexofWeakness:Hide();
		end

		if plvl >= 20 and IsSpellKnown(ids.Shad_Ability.MindFlayRank1) then 
			ConROC_SM_Debuff_MindFlay:Show(); 
			ConROC_SM_Debuff_MindFlay:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			lastDebuff = ConROC_SM_Debuff_MindFlay;
		else
			ConROC_SM_Debuff_MindFlay:Hide();
		end
		
		if plvl >= 20 and IsSpellKnown(ids.Holy_Ability.HolyFireRank1) then 
			ConROC_SM_Debuff_HolyFire:Show(); 
			ConROC_SM_Debuff_HolyFire:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			lastDebuff = ConROC_SM_Debuff_HolyFire;
		else
			ConROC_SM_Debuff_HolyFire:Hide();
		end

		if plvl >= 30 and IsSpellKnown(ids.Shad_Ability.VampiricEmbrace) then 
			ConROC_SM_Debuff_VampiricEmbrace:Show(); 
			ConROC_SM_Debuff_VampiricEmbrace:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			lastDebuff = ConROC_SM_Debuff_VampiricEmbrace;
		else
			ConROC_SM_Debuff_VampiricEmbrace:Hide();
		end
		
		if lastDebuff == ConROCCheckFrame1 then
			ConROCCheckHeader1:Hide();
			ConROCCheckFrame1:Hide();
		end
		
		if ConROCCheckFrame1:IsVisible() then
			lastFrame = lastDebuff;
		else
			lastFrame = ConROCCheckHeader1;
		end		
	end
	
	if ConROCCheckFrame2 ~= nil then
		if lastFrame == lastDebuff then
			ConROCCheckHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastBuff = ConROCCheckFrame2;
		
	--Buff
		if plvl >= 1 and IsSpellKnown(ids.Disc_Ability.PowerWordFortitudeRank1) then 
			ConROC_SM_Buff_PowerWordFortitude:Show();
			lastBuff = ConROC_SM_Buff_PowerWordFortitude;
		else
			ConROC_SM_Buff_PowerWordFortitude:Hide();
		end
		
		if plvl >= 10 and IsSpellKnown(ids.Shad_Ability.TouchofWeaknessRank1) then 
			ConROC_SM_Buff_TouchofWeakness:Show();
			ConROC_SM_Buff_TouchofWeakness:SetPoint("TOP", lastBuff, "BOTTOM", 0, 0);			
			lastBuff = ConROC_SM_Buff_TouchofWeakness;
		else
			ConROC_SM_Buff_TouchofWeakness:Hide();
		end

		if plvl >= 30 and IsSpellKnown(ids.Shad_Ability.ShadowProtectionRank1) then 
			ConROC_SM_Buff_ShadowProtection:Show(); 
			ConROC_SM_Buff_ShadowProtection:SetPoint("TOP", lastBuff, "BOTTOM", 0, 0);
			lastBuff = ConROC_SM_Buff_ShadowProtection;
		else
			ConROC_SM_Buff_ShadowProtection:Hide();
		end
		
		if plvl >= 30 and IsSpellKnown(ids.Disc_Ability.DivineSpiritRank1) then 
			ConROC_SM_Buff_DivineSpirit:Show(); 
			ConROC_SM_Buff_DivineSpirit:SetPoint("TOP", lastBuff, "BOTTOM", 0, 0);
			lastBuff = ConROC_SM_Buff_DivineSpirit;
		else
			ConROC_SM_Buff_DivineSpirit:Hide();
		end		

		if lastBuff == ConROCCheckFrame2 then
			ConROCCheckHeader2:Hide();
			ConROCCheckFrame2:Hide();
		end
		
		if ConROCCheckFrame2:IsVisible() then
			lastFrame = lastBuff;
		else
			lastFrame = ConROCCheckHeader2;
		end		
	end
	
	if ConROCCheckFrame3 ~= nil then
		if lastFrame == lastDebuff or lastFrame == lastBuff then
			ConROCCheckHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastOption = ConROCCheckFrame3;
		
	--Options
		if plvl >= 1 and HasWandEquipped() then
			ConROC_SM_Option_UseWand:Show();
			lastOption = ConROC_SM_Option_UseWand;
		else
			ConROC_SM_Option_UseWand:Hide();
		end

		if lastOption == ConROCCheckFrame3 then
			ConROCCheckHeader3:Hide();
			ConROCCheckFrame3:Hide();
		end
		
		if ConROCCheckFrame3:IsVisible() then
			lastFrame = lastOption;
		else
			lastFrame = ConROCCheckHeader3;
		end
	end
end

function ConROC:RoleProfile()
	if ConROC:CheckBox(ConROC_SM_Role_Caster) then
		ConROC_SM_Debuff_ShadowWordPain:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_ShadowWordPain);
		ConROC_SM_Debuff_HexofWeakness:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_HexofWeakness);
		ConROC_SM_Debuff_MindFlay:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_MindFlay);
		ConROC_SM_Debuff_HolyFire:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_HolyFire);
		ConROC_SM_Debuff_VampiricEmbrace:SetChecked(ConROCPriestSpells.ConROC_Caster_Debuff_VampiricEmbrace);
		
		ConROC_SM_Buff_PowerWordFortitude:SetChecked(ConROCPriestSpells.ConROC_Caster_Buff_PowerWordFortitude);
		ConROC_SM_Buff_TouchofWeakness:SetChecked(ConROCPriestSpells.ConROC_Caster_Buff_TouchofWeakness);
		ConROC_SM_Buff_ShadowProtection:SetChecked(ConROCPriestSpells.ConROC_Caster_Buff_ShadowProtection);
		ConROC_SM_Buff_DivineSpirit:SetChecked(ConROCPriestSpells.ConROC_Caster_Buff_DivineSpirit);
		
		ConROC_SM_Option_UseWand:SetChecked(ConROCPriestSpells.ConROC_Caster_Option_UseWand);
		
	elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
		ConROC_SM_Debuff_ShadowWordPain:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_ShadowWordPain);
		ConROC_SM_Debuff_HexofWeakness:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_HexofWeakness);
		ConROC_SM_Debuff_MindFlay:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_MindFlay);
		ConROC_SM_Debuff_HolyFire:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_HolyFire);
		ConROC_SM_Debuff_VampiricEmbrace:SetChecked(ConROCPriestSpells.ConROC_PvP_Debuff_VampiricEmbrace);
		
		ConROC_SM_Buff_PowerWordFortitude:SetChecked(ConROCPriestSpells.ConROC_PvP_Buff_PowerWordFortitude);
		ConROC_SM_Buff_TouchofWeakness:SetChecked(ConROCPriestSpells.ConROC_PvP_Buff_TouchofWeakness);
		ConROC_SM_Buff_ShadowProtection:SetChecked(ConROCPriestSpells.ConROC_PvP_Buff_ShadowProtection);
		ConROC_SM_Buff_DivineSpirit:SetChecked(ConROCPriestSpells.ConROC_PvP_Buff_DivineSpirit);
		
		ConROC_SM_Option_UseWand:SetChecked(ConROCPriestSpells.ConROC_PvP_Option_UseWand);
	end
end