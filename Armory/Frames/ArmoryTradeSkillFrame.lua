--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 529 2012-09-24T21:39:27Z
    URL: http://www.wow-neighbours.com

    License:
        This program is free software; you can redistribute it and/or
        modify it under the terms of the GNU General Public License
        as published by the Free Software Foundation; either version 2
        of the License, or (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program(see GPL.txt); if not, write to the Free Software
        Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

    Note:
        This AddOn's source code is specifically designed to work with
        World of Warcraft's interpreted AddOn system.
        You have an implicit licence to use this AddOn with these facilities
        since that is it's designated purpose as per:
        http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]] 

local Armory, _ = Armory;

ARMORY_TRADE_SKILLS_DISPLAYED = 9;
ARMORY_MAX_TRADE_SKILL_REAGENTS = 8;
ARMORY_TRADE_SKILL_HEIGHT = 16;
ARMORY_TRADE_SKILL_TEXT_WIDTH = 270;
ARMORY_TRADE_SKILL_SKILLUP_TEXT_WIDTH = 30;
ARMORY_SUB_SKILL_BAR_WIDTH = 60;

ArmoryTradeSkillTypeColor = {};
ArmoryTradeSkillTypeColor["optimal"]   = { r = 1.00, g = 0.50, b = 0.25, font = GameFontNormalLeftOrange };
ArmoryTradeSkillTypeColor["medium"]    = { r = 1.00, g = 1.00, b = 0.00, font = GameFontNormalLeftYellow };
ArmoryTradeSkillTypeColor["easy"]      = { r = 0.25, g = 0.75, b = 0.25, font = GameFontNormalLeftLightGreen };
ArmoryTradeSkillTypeColor["trivial"]   = { r = 0.50, g = 0.50, b = 0.50, font = GameFontNormalLeftGrey };
ArmoryTradeSkillTypeColor["header"]    = { r = 1.00, g = 0.82, b = 0,    font = GameFontNormalLeft };
ArmoryTradeSkillTypeColor["subheader"] = { r = 1.00, g = 0.82, b = 0,    font = GameFontNormalLeft };

function ArmoryTradeSkillFrame_OnLoad(self)
    self:RegisterEvent("TRADE_SKILL_SHOW");
    self:RegisterEvent("TRADE_SKILL_CLOSE");
    self:RegisterEvent("TRADE_SKILL_UPDATE");
    
    Armory:RegisterTradeSkillAddOn("Armory", 
        function() ArmoryTradeSkillFrame:UnregisterEvent("TRADE_SKILL_UPDATE"); end, 
        function() ArmoryTradeSkillFrame:RegisterEvent("TRADE_SKILL_UPDATE"); end 
    );
end

function ArmoryTradeSkillFrameButton_OnEnter(self)
	self.count:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	self.skillup.icon:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	self.skillup.countText:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	
	self.text:SetFontObject(GameFontHighlightLeft);
	self.text:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	if ( self.SubSkillRankBar.currentRank and self.SubSkillRankBar.maxRank) then
		self.SubSkillRankBar.Rank:SetText(self.SubSkillRankBar.currentRank.."/"..self.SubSkillRankBar.maxRank);
	end
end

function ArmoryTradeSkillFrameButton_OnLeave(self)
	if ( not self.isHighlighted ) then
		self.count:SetVertexColor(self.r, self.g, self.b);
		self.skillup.icon:SetVertexColor(self.r, self.g, self.b);
		self.skillup.countText:SetVertexColor(self.r, self.g, self.b);
		
		self.text:SetFontObject(self.font);
		self.text:SetVertexColor(self.r, self.g, self.b);
		self.SubSkillRankBar.Rank:SetText("");
	end
end

function ArmoryTradeSkillFrame_OnEvent(self, event, ...)
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "TRADE_SKILL_SHOW" ) then
        self.isOpen = true;
        Armory:PullTradeSkillItems();
    elseif ( event == "TRADE_SKILL_CLOSE" ) then
        self.isOpen = false;
    elseif ( not Armory:GetConfigExtendedTradeSkills() ) then
        Armory:Execute(ArmoryTradeSkill_Update);
    end
end

local Orig_CloseTradeSkill = CloseTradeSkill;
function CloseTradeSkill()
    if ( ArmoryTradeSkillFrame.closing ) then
        return;
    end

    ArmoryTradeSkillFrame.closing = true;
    
    if ( Armory:GetConfigExtendedTradeSkills() ) then
        ArmoryTradeSkill_Update();
    end

    Orig_CloseTradeSkill();

    ArmoryTradeSkillFrame.closing = false;
    ArmoryTradeSkillFrame.isOpen = false;
end

function ArmoryTradeSkill_Update()
    local currentSkill, modeChanged, hasCooldown;

    if ( ArmoryTradeSkillFrame.isOpen and not (IsTradeSkillLinked() or IsTradeSkillGuild()) ) then
        Armory:UnregisterTradeSkillUpdateEvents();
        currentSkill, modeChanged, hasCooldown = Armory:UpdateTradeSkill();
        Armory:RegisterTradeSkillUpdateEvents();

        if ( Armory.character == Armory.player ) then
            if ( ArmoryTradeSkillFrame.skillName == currentSkill and ArmoryTradeSkillFrame:IsShown() ) then
                if ( modeChanged ) then
                    ArmoryTradeSkillFrame_Show();
                else
                    ArmoryTradeSkillFrame_SetSelection(Armory:GetTradeSkillSelectionIndex());
                    ArmoryTradeSkillFrame_Update();
                end
            end
            ArmoryFrame_UpdateLineTabs();
        end

        if ( hasCooldown and Armory:GetConfigEnableCooldownEvents() ) then
            Armory:Execute(ArmorySocialFrame_UpdateEvents);
        end
    end
end

function ArmoryTradeSkillFrame_Show()
    if ( not ArmoryTradeSkillFrame.skillName or ArmoryTradeSkillFrame.skillName ~= Armory:GetTradeSkillLine() ) then
        ArmoryTradeSkillFrame.skillName = Armory:GetTradeSkillLine();
        ArmoryTradeSkillFrame.reset = true;
    else
        ArmoryTradeSkillFrame.reset = false;
    end

    if ( ArmoryTradeSkillFrame.reset ) then
        Armory:SetTradeSkillItemLevelFilter(0, 0);
        Armory:SetTradeSkillItemNameFilter("");
        ArmoryTradeSkillFrameEditBox:SetText(SEARCH);
    elseif ( Armory:GetTradeSkillItemNameFilter() == "" ) then
        local minLevel, maxLevel = Armory:GetTradeSkillItemLevelFilter();
        if ( minLevel and minLevel > 0 ) then
            if ( minLevel == maxLevel ) then
                ArmoryTradeSkillFrameEditBox:SetText(minLevel);
            elseif ( minLevel + 2 == maxLevel - 2 ) then
                ArmoryTradeSkillFrameEditBox:SetText("~"..(minLevel + 2));
            else
                ArmoryTradeSkillFrameEditBox:SetText(minLevel.."-"..maxLevel);
            end
            Armory:SetTradeSkillItemLevelFilter(minLevel, maxLevel);
        else
            ArmoryTradeSkillFrameEditBox:SetText(SEARCH);
        end
    else
        ArmoryTradeSkillFrameEditBox:SetText(Armory:GetTradeSkillItemNameFilter());
    end
    Armory:SetTradeSkillSubClassFilter(0, 1, 1);
    Armory:SetTradeSkillInvSlotFilter(0, 1, 1);

    local _, extended = Armory:GetNumTradeSkills();
    if ( extended ) then
        ArmoryTradeSkillFrameTopLeftTexture:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft");
        ArmoryTradeSkillFrameTopRightTexture:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight");
        ArmoryTradeSkillExpandButtonFrame:Show();

        ArmoryDropDownMenu_Initialize(ArmoryTradeSkillSubClassDropDown, ArmoryTradeSkillSubClassDropDown_Initialize);
        ArmoryDropDownMenu_SetWidth(ArmoryTradeSkillSubClassDropDown, 120);
        ArmoryDropDownMenu_SetSelectedID(ArmoryTradeSkillSubClassDropDown, 1);
        ArmoryTradeSkillSubClassDropDown:Show();

        ArmoryDropDownMenu_Initialize(ArmoryTradeSkillInvSlotDropDown, ArmoryTradeSkillInvSlotDropDown_Initialize);
        ArmoryDropDownMenu_SetWidth(ArmoryTradeSkillInvSlotDropDown, 120);
        ArmoryDropDownMenu_SetSelectedID(ArmoryTradeSkillInvSlotDropDown, 1);
        ArmoryTradeSkillInvSlotDropDown:Show();
        
        ARMORY_TRADE_SKILLS_DISPLAYED = 8;
        ArmoryTradeSkillSkill9:Hide();
        ArmoryTradeSkillSkill1:SetPoint("TOPLEFT", "ArmoryTradeSkillFrame", "TOPLEFT", 22, -96);
        ArmoryTradeSkillListScrollFrame:SetHeight(130);
        ArmoryTradeSkillListScrollFrame:SetPoint("TOPRIGHT", "ArmoryTradeSkillFrame", "TOPRIGHT", -67, -96);
    else
        ArmoryTradeSkillFrameTopLeftTexture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");
        ArmoryTradeSkillFrameTopRightTexture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");
        ArmoryTradeSkillExpandButtonFrame:Hide();
        ArmoryTradeSkillSubClassDropDown:Hide();
        ArmoryTradeSkillInvSlotDropDown:Hide();
        
        ARMORY_TRADE_SKILLS_DISPLAYED = 9;
        ArmoryTradeSkillSkill1:SetPoint("TOPLEFT", "ArmoryTradeSkillFrame", "TOPLEFT", 22, -80);
        ArmoryTradeSkillListScrollFrame:SetHeight(146);
        ArmoryTradeSkillListScrollFrame:SetPoint("TOPRIGHT", "ArmoryTradeSkillFrame", "TOPRIGHT", -67, -80);
    end
    
    ArmoryCloseChildWindows();
    ShowUIPanel(ArmoryTradeSkillFrame);
    ArmoryTradeSkillFrame_SetSelection(Armory:GetFirstTradeSkill());

    FauxScrollFrame_SetOffset(ArmoryTradeSkillListScrollFrame, 0);
    ArmoryTradeSkillListScrollFrameScrollBar.doNotHide = true; 
    ArmoryTradeSkillListScrollFrameScrollBar:SetMinMaxValues(0, 0); 
    ArmoryTradeSkillListScrollFrameScrollBar:SetValue(0);

    if ( Armory:GetPaperDollLastViewed() == Armory.playerRealm ) then
        ArmoryTradeSkillLinkButton:Show();
    else
        ArmoryTradeSkillLinkButton:Hide();
    end

    ArmoryTradeSkillFrame_Update();

    ArmoryCloseDropDownMenus();
end

function ArmoryTradeSkillFrame_Hide()
    HideUIPanel(ArmoryTradeSkillFrame);
end

local scanned = {};
local function GetNumAvailable(id)
    local numAvailable = 0;
    table.wipe(scanned);
    if ( Armory:HasInventory() ) then
        for i = 1, Armory:GetTradeSkillNumReagents(id) do
            local reagentLink = Armory:GetTradeSkillReagentItemLink(id, i);
            if ( reagentLink ) then
                local _, _, reagentCount = Armory:GetTradeSkillReagentInfo(id, i);
                if ( reagentCount and reagentCount > 0 ) then
                    table.insert(scanned, floor(Armory:ScanInventory(reagentLink, true) / reagentCount));
                end
            end
        end
        if ( #scanned > 0 ) then
            numAvailable = scanned[1];
            for i = 2, #scanned do
                if ( scanned[i] < numAvailable ) then
                    numAvailable = scanned[i];
                end
            end
        end
    end
    table.wipe(scanned);
    return numAvailable;
end

function ArmoryTradeSkillFrame_Update()
    local numTradeSkills = Armory:GetNumTradeSkills();
    local skillOffset = FauxScrollFrame_GetOffset(ArmoryTradeSkillListScrollFrame);
    local name, rank, maxRank, modifier = Armory:GetTradeSkillLine();

    -- If no tradeskills
    if ( numTradeSkills == 0 ) then
        ArmoryTradeSkillFrameTitleText:SetFormattedText(TRADE_SKILL_TITLE, name);
        ArmoryTradeSkillSkillName:Hide();
        ArmoryTradeSkillSkillIcon:Hide();
        ArmoryTradeSkillRequirementLabel:Hide();
        ArmoryTradeSkillRequirementText:SetText("");
        ArmoryTradeSkillCollapseAllButton:Disable();
        for i=1, ARMORY_MAX_TRADE_SKILL_REAGENTS, 1 do
            _G["ArmoryTradeSkillReagent"..i]:Hide();
        end
    else
        ArmoryTradeSkillSkillName:Show();
        ArmoryTradeSkillSkillIcon:Show();
        ArmoryTradeSkillCollapseAllButton:Enable();
    end

    ArmoryTradeSkillFrameEditBox:Show();

    -- ScrollFrame update
    FauxScrollFrame_Update(ArmoryTradeSkillListScrollFrame, numTradeSkills, ARMORY_TRADE_SKILLS_DISPLAYED, ARMORY_TRADE_SKILL_HEIGHT, nil, nil, nil, ArmoryTradeSkillHighlightFrame, 293, 316 );

    ArmoryTradeSkillHighlightFrame:Hide();
    local skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps, indentLevel, showProgressBar, currentRank, maxRank, startingRank;
    local skillIndex, skillButton, skillButtonText, skillButtonCount, skillButtonNumSkillUps, skillButtonNumSkillUpsIcon, skillButtonNumSkillUpsText, skillButtonSubSkillRankBar;
    local nameWidth, countWidth, usedWidth;

   	local skillNamePrefix = " ";

    for i=1, ARMORY_TRADE_SKILLS_DISPLAYED, 1 do
        skillIndex = i + skillOffset;
        skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps, indentLevel, showProgressBar, currentRank, maxRank, startingRank = Armory:GetTradeSkillInfo(skillIndex);

        skillButton = _G["ArmoryTradeSkillSkill"..i];
        skillButtonText = _G["ArmoryTradeSkillSkill"..i.."Text"];
        skillButtonCount = _G["ArmoryTradeSkillSkill"..i.."Count"];
		skillButtonNumSkillUps = _G["ArmoryTradeSkillSkill"..i.."NumSkillUps"];
		skillButtonNumSkillUpsText = _G["ArmoryTradeSkillSkill"..i.."NumSkillUpsText"];
		skillButtonNumSkillUpsIcon = _G["ArmoryTradeSkillSkill"..i.."NumSkillUpsIcon"];
		skillButtonSubSkillRankBar = _G["ArmoryTradeSkillSkill"..i.."SubSkillRankBar"];
        if ( skillIndex <= numTradeSkills ) then    
            --turn on the multiskill icon
            if ( (numSkillUps or 0) > 1 and skillType == "optimal" ) then
                skillButtonNumSkillUps:Show();
                skillButtonNumSkillUpsIcon:Show();
                skillButtonNumSkillUps:SetText(numSkillUps);
                usedWidth = ARMORY_TRADE_SKILL_SKILLUP_TEXT_WIDTH;
            else 
                skillButtonNumSkillUps:Hide();
                skillButtonNumSkillUpsIcon:Hide();
                usedWidth = 0;		
            end

            local color = ArmoryTradeSkillTypeColor[skillType];
            if ( color ) then
                skillButton:SetNormalFontObject(color.font);
				skillButtonText:SetVertexColor(color.r, color.g, color.b);
                skillButtonCount:SetVertexColor(color.r, color.g, color.b);
                skillButton.r = color.r;
                skillButton.g = color.g;
                skillButton.b = color.b;
                skillButton.font = color.font;
                skillButtonNumSkillUpsText:SetVertexColor(color.r, color.g, color.b);
                skillButtonNumSkillUpsIcon:SetVertexColor(color.r, color.g, color.b);
            end
            
			if ( ENABLE_COLORBLIND_MODE == "1" ) then
				skillNamePrefix = TradeSkillTypePrefix[skillType] or " ";
			end
			
			local textWidth = ARMORY_TRADE_SKILL_TEXT_WIDTH;
			if ( indentLevel ~= 0 ) then
				textWidth = ARMORY_TRADE_SKILL_TEXT_WIDTH - 20;
				skillButton:GetNormalTexture():SetPoint("LEFT", 23, 0);
				skillButton:GetDisabledTexture():SetPoint("LEFT", 23, 0);
				skillButton:GetHighlightTexture():SetPoint("LEFT", 23, 0);
			else
				skillButton:GetNormalTexture():SetPoint("LEFT", 3, 0);
				skillButton:GetDisabledTexture():SetPoint("LEFT", 3, 0);
				skillButton:GetHighlightTexture():SetPoint("LEFT", 3, 0);
			end

            skillButton:SetID(skillIndex);
            skillButton:Show();
            
			skillButtonSubSkillRankBar:Hide();

            -- Handle headers
            if ( skillType == "header" or skillType == "subheader" ) then
				--probably only want to show progress bar for categories (headers)
				if ( showProgressBar ) then
					skillButtonSubSkillRankBar:Show();
					skillButtonSubSkillRankBar:SetMinMaxValues(startingRank, maxRank);
					skillButtonSubSkillRankBar:SetValue(currentRank);
					skillButtonSubSkillRankBar.currentRank = currentRank;
					skillButtonSubSkillRankBar.maxRank = maxRank;
					textWidth = textWidth - ARMORY_SUB_SKILL_BAR_WIDTH;
				end

                skillButton:SetText(skillName);
                skillButtonText:SetWidth(textWidth);
                skillButtonCount:SetText("");
                if ( isExpanded ) then
                    skillButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
                else
                    skillButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
                end
                _G["ArmoryTradeSkillSkill"..i.."Highlight"]:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
                _G["ArmoryTradeSkillSkill"..i]:UnlockHighlight();
            elseif ( not skillName ) then
                return;
            else
                skillButton:SetNormalTexture("");
                _G["ArmoryTradeSkillSkill"..i.."Highlight"]:SetTexture("");

                numAvailable = GetNumAvailable(skillIndex);
                if ( numAvailable <= 0 ) then
                    skillButton:SetText(skillNamePrefix..skillName);
                    skillButtonText:SetWidth(textWidth);
                    skillButtonCount:SetText("");
                else
                    skillName = skillNamePrefix..skillName;
                    skillButtonCount:SetText("["..numAvailable.."]");
                    ArmoryTradeSkillFrameDummyString:SetText(skillName);
                    nameWidth = ArmoryTradeSkillFrameDummyString:GetWidth();
                    countWidth = skillButtonCount:GetWidth();
                    skillButtonText:SetText(skillName);
                    if ( nameWidth + 2 + countWidth > textWidth - usedWidth ) then
                        skillButtonText:SetWidth(textWidth - 2 - countWidth - usedWidth);
                    else
                        skillButtonText:SetWidth(0);
                    end
                end

                -- Place the highlight and lock the highlight state
                if ( Armory:GetTradeSkillSelectionIndex() == skillIndex ) then
                    ArmoryTradeSkillHighlightFrame:SetPoint("TOPLEFT", "ArmoryTradeSkillSkill"..i, "TOPLEFT", 0, 0);
                    ArmoryTradeSkillHighlightFrame:Show();
                    skillButtonText:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
                    skillButtonCount:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

                    skillButtonNumSkillUpsText:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
                    skillButtonNumSkillUpsIcon:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
                    skillButton:LockHighlight();
                    skillButton.isHighlighted = true;
                else
                    skillButton:UnlockHighlight();
                    skillButton.isHighlighted = false;
                end
            end

        else
            skillButton:Hide();
        end
    end

    -- Set the expand/collapse all button texture
    local numHeaders = 0;
    local notExpanded = 0;
    for i=1, numTradeSkills, 1 do
        local skillName, skillType, numAvailable, isExpanded, altVerb = Armory:GetTradeSkillInfo(i);
        if ( skillName and (skillType == "header" or skillType == "subheader") ) then
            numHeaders = numHeaders + 1;
            if ( not isExpanded ) then
                notExpanded = notExpanded + 1;
            end
        end
    end
    -- If all headers are not expanded then show collapse button, otherwise show the expand button
    if ( notExpanded ~= numHeaders ) then
        ArmoryTradeSkillCollapseAllButton.isCollapsed = nil;
        ArmoryTradeSkillCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
    else
        ArmoryTradeSkillCollapseAllButton.isCollapsed = 1;
        ArmoryTradeSkillCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
    end

    -- If has headers show the expand all button
    if ( numHeaders > 0 ) then
        -- If has headers then move all the names to the right
        for i=1, ARMORY_TRADE_SKILLS_DISPLAYED, 1 do
            _G["ArmoryTradeSkillSkill"..i.."Text"]:SetPoint("TOPLEFT", "ArmoryTradeSkillSkill"..i, "TOPLEFT", 21, 0);
        end
        ArmoryTradeSkillExpandButtonFrame:Show();
    else
        -- If no headers then move all the names to the left
        for i=1, ARMORY_TRADE_SKILLS_DISPLAYED, 1 do
            _G["ArmoryTradeSkillSkill"..i.."Text"]:SetPoint("TOPLEFT", "ArmoryTradeSkillSkill"..i, "TOPLEFT", 3, 0);
        end
        ArmoryTradeSkillExpandButtonFrame:Hide();
    end
end

function ArmoryTradeSkillFrame_SetSelection(id)
    local skillName, skillType, numAvailable, isExpanded, altVerb = Armory:GetTradeSkillInfo(id);
    ArmoryTradeSkillHighlightFrame:Show();
    if ( skillType == "header" or skillType == "subheader" ) then
        ArmoryTradeSkillHighlightFrame:Hide();
        if ( isExpanded ) then
            Armory:CollapseTradeSkillSubClass(id);
        else
            Armory:ExpandTradeSkillSubClass(id);
        end
        return;
    end
    ArmoryTradeSkillFrame.selectedSkill = id;
    Armory:SelectTradeSkill(id);
    if ( Armory:GetTradeSkillSelectionIndex() > Armory:GetNumTradeSkills() ) then
        return;
    end

	ArmoryTradeSkillSkillName:SetText(skillName);
	local cooldown, isDayCooldown = Armory:GetTradeSkillCooldown(id);

	if ( not cooldown ) then
		ArmoryTradeSkillSkillCooldown:SetText("");
	elseif ( not isDayCooldown ) then
		ArmoryTradeSkillSkillCooldown:SetText(COOLDOWN_REMAINING.." "..SecondsToTime(cooldown));
	elseif ( cooldown > 60 * 60 * 24 ) then	--Cooldown is greater than 1 day.
		ArmoryTradeSkillSkillCooldown:SetText(COOLDOWN_REMAINING.." "..SecondsToTime(cooldown, true, false, 1, true));
	else
		ArmoryTradeSkillSkillCooldown:SetText(COOLDOWN_EXPIRES_AT_MIDNIGHT);
	end

    ArmoryTradeSkillSkillIcon:SetNormalTexture(Armory:GetTradeSkillIcon(id));
    Armory:SetItemLink(ArmoryTradeSkillSkillIcon, itemLink);

    local minMade, maxMade = Armory:GetTradeSkillNumMade(id);
    if ( maxMade > 1 ) then
        if ( minMade == maxMade ) then
            ArmoryTradeSkillSkillIconCount:SetText(minMade);
        else
            ArmoryTradeSkillSkillIconCount:SetText(minMade.."-"..maxMade);
        end
        if ( ArmoryTradeSkillSkillIconCount:GetWidth() > 39 ) then
            ArmoryTradeSkillSkillIconCount:SetText("~"..floor((minMade + maxMade) / 2));
        end
    else
        ArmoryTradeSkillSkillIconCount:SetText("");
    end
    
    -- Reagents
    local numReagents = Armory:GetTradeSkillNumReagents(id);
    if ( numReagents > 0 ) then
        ArmoryTradeSkillReagentLabel:Show();
    else
        ArmoryTradeSkillReagentLabel:Hide();
    end
    for i = 1, numReagents, 1 do
        local reagentName, reagentTexture, reagentCount, playerReagentCount = Armory:GetTradeSkillReagentInfo(id, i);
        local reagent = _G["ArmoryTradeSkillReagent"..i]
        local name = _G["ArmoryTradeSkillReagent"..i.."Name"];
        local count = _G["ArmoryTradeSkillReagent"..i.."Count"];
        if ( not reagentName or not reagentTexture ) then
            reagent:Hide();
        else
            reagent:Show();
            SetItemButtonTexture(reagent, reagentTexture);
            name:SetText(reagentName);
            Armory:SetItemLink(reagent, Armory:GetTradeSkillReagentItemLink(id, i));

            if ( Armory:HasInventory() ) then
                -- use count from inventory
                playerReagentCount = Armory:ScanInventory(reagent.link, true);

                -- Grayout items
                if ( playerReagentCount < reagentCount ) then
                    SetItemButtonTextureVertexColor(reagent, 0.5, 0.5, 0.5);
                    name:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
                else
                    SetItemButtonTextureVertexColor(reagent, 1.0, 1.0, 1.0);
                    name:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
                end
                if ( playerReagentCount >= 100 ) then
                    playerReagentCount = "*";
                end
                count:SetText(playerReagentCount.." /"..reagentCount);
            else
                count:SetText(reagentCount.." ");
            end
        end
    end
    -- Place reagent label
    local reagentToAnchorTo = numReagents;
    if ( (numReagents > 0) and (mod(numReagents, 2) == 0) ) then
        reagentToAnchorTo = reagentToAnchorTo - 1;
    end

    for i = numReagents + 1, ARMORY_MAX_TRADE_SKILL_REAGENTS, 1 do
        _G["ArmoryTradeSkillReagent"..i]:Hide();
    end

    local spellFocus = Armory:GetTradeSkillTools(id);
    if ( spellFocus and spellFocus ~= "" ) then
        ArmoryTradeSkillRequirementLabel:Show();
        ArmoryTradeSkillRequirementText:SetText(spellFocus);
    else
        ArmoryTradeSkillRequirementLabel:Hide();
        ArmoryTradeSkillRequirementText:SetText("");
    end
    
    if ( Armory:GetTradeSkillDescription(id) ) then
        ArmoryTradeSkillDescription:SetText(Armory:GetTradeSkillDescription(id))
        ArmoryTradeSkillReagentLabel:SetPoint("TOPLEFT", "ArmoryTradeSkillDescription", "BOTTOMLEFT", 0, -10);
    else
        ArmoryTradeSkillDescription:SetText(" ");
        ArmoryTradeSkillReagentLabel:SetPoint("TOPLEFT", "ArmoryTradeSkillDescription", "TOPLEFT", 0, 0);
    end

    -- General Info
    local skillLineName, skillLineRank, skillLineMaxRank, skillLineModifier = Armory:GetTradeSkillLine();
    local color = ArmoryTradeSkillTypeColor[skillType];

    ArmoryTradeSkillFrameTitleText:SetFormattedText(TRADE_SKILL_TITLE, skillLineName);
    -- Set statusbar info
    ArmoryTradeSkillRankFrame:SetStatusBarColor(0.0, 0.0, 1.0, 0.5);
    ArmoryTradeSkillRankFrameBackground:SetVertexColor(0.0, 0.0, 0.75, 0.5);
    ArmoryTradeSkillRankFrame:SetMinMaxValues(0, skillLineMaxRank);
    ArmoryTradeSkillRankFrame:SetValue(skillLineRank);
    if ( skillLineModifier > 0 ) then
        ArmoryTradeSkillRankFrameSkillRank:SetFormattedText(TRADESKILL_RANK_WITH_MODIFIER, skillLineRank, skillLineModifier, skillLineMaxRank);
    else
        ArmoryTradeSkillRankFrameSkillRank:SetFormattedText(TRADESKILL_RANK, skillLineRank, skillLineMaxRank);
    end
    
    if ( color ) then
        ArmoryTradeSkillHighlight:SetVertexColor(color.r, color.g, color.b);
    end

    if ( IsAddOnLoaded("GFW_ReagentCost") ) then
        local itemLink = Armory:GetTradeSkillItemLink(id);
        if ( not (itemLink and FRC_Config.Enabled and FRC_PriceSource) ) then
            return;
        end
        local enchantLink = itemLink:match("(enchant:%d+)");
        local itemID = itemLink:match("item:(%d+)");
        local identifier;
        if ( itemID ) then
            itemID = tonumber(itemID);
            identifier = itemID;
        elseif ( enchantLink ) then
            identifier = enchantLink;
        else
            return;
        end

        local materialsTotal, confidenceScore = FRC_MaterialsCost(skillLineName, identifier);
        local costText = GFWUtils.LtY("(Total cost: ");
        if ( materialsTotal == nil ) then
            if ( not IsAddOnLoaded(FRC_PriceSource) ) then
                costText = costText .. GFWUtils.Gray("["..FRC_PriceSource.." not loaded]");
            else
                costText = costText .. GFWUtils.Gray("Unknown [insufficient data]");
            end
        else
            costText = costText .. GFWUtils.TextGSC(materialsTotal) ..GFWUtils.Gray(" Confidence: "..confidenceScore.."%");
        end
        costText = costText ..GFWUtils.LtY(")");

        ArmoryTradeSkillReagentLabel:SetText(SPELL_REAGENTS.." "..costText);
        ArmoryTradeSkillReagentLabel:Show();
    end
end

function ArmoryTradeSkillSkillButton_OnClick(self, button)
    if ( button == "LeftButton" ) then
        ArmoryTradeSkillFrame_SetSelection(self:GetID());
        ArmoryTradeSkillFrame_Update();
    end
end

function ArmoryTradeSkillCollapseAllButton_OnClick(self)
    if ( self.isCollapsed ) then
        self.isCollapsed = nil;
        Armory:ExpandTradeSkillSubClass(0);
    else
        self.isCollapsed = 1;
        ArmoryTradeSkillListScrollFrameScrollBar:SetValue(0);
        Armory:CollapseTradeSkillSubClass(0);
    end
    ArmoryTradeSkillFrame_SetSelection(Armory:GetFirstTradeSkill());
    ArmoryTradeSkillFrame_Update();    
end

function ArmoryTradeSkillSubClassDropDown_Initialize()
    local subClasses = Armory:GetUniqueTradeSkillSubClasses();
    local selectedID = ArmoryDropDownMenu_GetSelectedID(ArmoryTradeSkillSubClassDropDown);
    local allChecked = Armory:GetTradeSkillSubClassFilter(0);

    -- the first button in the list is going to be an "all subclasses" button
    local info = ArmoryDropDownMenu_CreateInfo();
    info.text = ALL_SUBCLASSES;
    info.func = ArmoryTradeSkillSubClassDropDownButton_OnClick;
    -- select this button if nothing else was selected
    info.checked = allChecked and (selectedID == nil or selectedID == 1);
    ArmoryDropDownMenu_AddButton(info);
    if ( info.checked ) then
        ArmoryDropDownMenu_SetText(ArmoryTradeSkillSubClassDropDown, ALL_SUBCLASSES);
    end

    local checked;
    for i = 1, #subClasses do
        info.text = subClasses[i]:match("^(.-)%d+$");
        -- if there are no filters then don't check any individual subclasses
        if ( allChecked ) then
            checked = nil;
        else
            checked = Armory:GetTradeSkillSubClassFilter(i);
            if ( checked ) then
                ArmoryDropDownMenu_SetText(ArmoryTradeSkillSubClassDropDown, info.text);
            end
        end
        info.func = ArmoryTradeSkillSubClassDropDownButton_OnClick;
        info.checked = checked;
        ArmoryDropDownMenu_AddButton(info);
    end
end

function ArmoryTradeSkillInvSlotDropDown_Initialize()
    ArmoryTradeSkillFilterFrame_LoadInvSlots(Armory:GetTradeSkillInvSlots());
end

function ArmoryTradeSkillFilterFrame_LoadInvSlots(...)
    local selectedID = ArmoryDropDownMenu_GetSelectedID(ArmoryTradeSkillInvSlotDropDown);
    local allChecked = Armory:GetTradeSkillInvSlotFilter(0);
    local info = ArmoryDropDownMenu_CreateInfo();
    local filterCount = select("#", ...);
    info.text = ALL_INVENTORY_SLOTS;
    info.func = ArmoryTradeSkillInvSlotDropDownButton_OnClick;
    info.checked = allChecked and (selectedID == nil or selectedID == 1);
    ArmoryDropDownMenu_AddButton(info);
    local checked;

    for i=1, filterCount, 1 do
        if ( allChecked ) then
            checked = nil;
        else
            checked = Armory:GetTradeSkillInvSlotFilter(i);
            if ( checked ) then
                ArmoryDropDownMenu_SetText(ArmoryTradeSkillInvSlotDropDown, select(i, ...));
            end
        end
        info.text = select(i, ...);
        info.func = ArmoryTradeSkillInvSlotDropDownButton_OnClick;
        info.checked = checked;
        ArmoryDropDownMenu_AddButton(info);
    end
end

function ArmoryTradeSkillFilterFrame_InvSlotName(...)
    for i=1, select("#", ...), 1 do
        if ( Armory:GetTradeSkillInvSlotFilter(i) ) then
            return select(i, ...);
        end
    end
end

function ArmoryTradeSkillSubClassDropDownButton_OnClick(self)
    ArmoryDropDownMenu_SetSelectedID(ArmoryTradeSkillSubClassDropDown, self:GetID());
    Armory:SetTradeSkillSubClassFilter(self:GetID() - 1, 1, 1);
    if ( self:GetID() ~= 1 ) then
        if ( ArmoryTradeSkillFilterFrame_InvSlotName(Armory:GetTradeSkillInvSlots()) ~= ArmoryTradeSkillInvSlotDropDown.selected ) then
            Armory:SetTradeSkillInvSlotFilter(0, 1, 1);
            ArmoryDropDownMenu_SetSelectedID(ArmoryTradeSkillInvSlotDropDown, 1);
            ArmoryDropDownMenu_SetText(ArmoryTradeSkillInvSlotDropDown, ALL_INVENTORY_SLOTS);
        end
    end
    ArmoryTradeSkillListScrollFrameScrollBar:SetValue(0);
    FauxScrollFrame_SetOffset(ArmoryTradeSkillListScrollFrame, 0);
    ArmoryTradeSkillFrame_SetSelection(Armory:GetFirstTradeSkill());
    ArmoryTradeSkillFrame_Update();
end

function ArmoryTradeSkillInvSlotDropDownButton_OnClick(self)
    ArmoryDropDownMenu_SetSelectedID(ArmoryTradeSkillInvSlotDropDown, self:GetID());
    Armory:SetTradeSkillInvSlotFilter(self:GetID() - 1, 1, 1);
    ArmoryTradeSkillInvSlotDropDown.selected = ArmoryTradeSkillFilterFrame_InvSlotName(Armory:GetTradeSkillInvSlots());
    ArmoryTradeSkillListScrollFrameScrollBar:SetValue(0);
    FauxScrollFrame_SetOffset(ArmoryTradeSkillListScrollFrame, 0);
    ArmoryTradeSkillFrame_SetSelection(Armory:GetFirstTradeSkill());
    ArmoryTradeSkillFrame_Update();
end

function ArmoryTradeSkillItem_OnEnter(self)
    if ( ArmoryTradeSkillFrame.selectedSkill ~= 0 ) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        Armory:SetTradeSkillItem(ArmoryTradeSkillFrame.selectedSkill);
    end
end

function ArmoryTradeSkillFilter_OnTextChanged(self)
    local text, minLevel, maxLevel = Armory:GetTradeSkillItemFilter(self:GetText());
    local refresh1 = Armory:SetTradeSkillItemNameFilter(text);
    local refresh2 = Armory:SetTradeSkillItemLevelFilter(minLevel, maxLevel);

    if ( refresh1 or refresh2 ) then
        ArmoryTradeSkillListScrollFrameScrollBar:SetValue(0);
        FauxScrollFrame_SetOffset(ArmoryTradeSkillListScrollFrame, 0);
        ArmoryTradeSkillFrame_SetSelection(Armory:GetFirstTradeSkill());
        ArmoryTradeSkillFrame_Update();
    end
end