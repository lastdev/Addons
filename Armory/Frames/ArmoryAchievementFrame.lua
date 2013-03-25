--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 578 2013-01-15T22:05:28Z
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

ARMORY_NUM_ACHIEVEMENTS_DISPLAYED = 15;
ARMORY_ACHIEVEMENTFRAME_ACHIEVEMENTHEIGHT = 26;

function ArmoryAchievementFrame_Toggle()
    if ( ArmoryAchievementFrame:IsShown() ) then
        HideUIPanel(ArmoryAchievementFrame);
    else
        ArmoryCloseChildWindows();
        ShowUIPanel(ArmoryAchievementFrame);
    end
end

function ArmoryAchievementFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("ACHIEVEMENT_EARNED");

    SetPortraitToTexture("ArmoryAchievementFramePortrait", "Interface\\Icons\\Achievement_Level_10");
    
    -- Tab Handling code
    PanelTemplates_SetNumTabs(self, 2);
    PanelTemplates_SetTab(self, 1);
    ArmoryAchievementFrame_SelectSource(1);
end

function ArmoryAchievementFrame_OnEvent(self, event, ...)
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:RegisterEvent("CRITERIA_UPDATE");
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        if ( Armory.forceScan or not Armory:AchievementsExists() ) then
            ArmoryAchievementFrame_UpdateAchievements(true);
        end
    elseif ( event == "ACHIEVEMENT_EARNED" ) then
        local achievementID = ...;
        Armory:RemoveAchievement(achievementID);
    elseif ( event == "CRITERIA_UPDATE" ) then
        ArmoryAchievementFrame_UpdateAchievements();
    end
end

function ArmoryAchievementFrame_UpdateAchievements(force)
    Armory:Execute(Armory.UpdateAchievements, Armory, force);
    Armory:Execute(Armory.UpdateStatistics, Armory, force);
end

function ArmoryAchievementFrame_OnShow(self)
    if ( Armory:HasStatistics() ) then
        ArmoryAchievementFrameTab1:Show();
        ArmoryAchievementFrameTab2:Show();
    else
        ArmoryAchievementFrameTab1:Hide();
        ArmoryAchievementFrameTab2:Hide();
        ArmoryAchievementFrame_SelectSource(1);
    end
    if ( Armory:GetAchievementFilter() == "" ) then
        ArmoryAchievementFrameEditBox:SetText(SEARCH);
    else
        ArmoryAchievementFrameEditBox:SetText(Armory:GetAchievementFilter());
    end
    ArmoryAchievementFrame_Update();
end

function ArmoryAchievementFrame_SetRowType(achievementRow, rowType, hasQuantity)	--rowType is a binary table of type isHeader, isChild
	local achievementRowName = achievementRow:GetName()
	local achievementBar = _G[achievementRowName.."AchievementBar"];
	local achievementTitle = _G[achievementRowName.."AchievementName"];
	local achievementButton = _G[achievementRowName.."ExpandOrCollapseButton"];
	local achievementQuantity = _G[achievementRowName.."AchievementBarQuantity"];
	local achievementBackground = _G[achievementRowName.."Background"];
	local achievementLeftTexture = _G[achievementRowName.."AchievementBarLeftTexture"];
	local achievementRightTexture = _G[achievementRowName.."AchievementBarRightTexture"];
	achievementLeftTexture:SetWidth(62);
	achievementRightTexture:SetWidth(42);
	achievementBar:SetPoint("RIGHT", achievementRow, "RIGHT", 0, 0);
	if ( rowType == 0 ) then --Not header, not child
		achievementRow:SetPoint("LEFT", ArmoryAchievementFrame, "LEFT", 44, 0);
		achievementButton:Hide();
		achievementTitle:SetPoint("LEFT", achievementRow, "LEFT", 10, 0);
		achievementTitle:SetFontObject(GameFontHighlightSmall);
		achievementTitle:SetWidth(160);
		achievementBackground:Show();
		achievementLeftTexture:SetHeight(21);
		achievementRightTexture:SetHeight(21);
		achievementLeftTexture:SetTexCoord(0.7578125, 1.0, 0.0, 0.328125);
		achievementRightTexture:SetTexCoord(0.0, 0.1640625, 0.34375, 0.671875);
	elseif ( rowType == 1 ) then --Child, not header
		achievementRow:SetPoint("LEFT", ArmoryAchievementFrame, "LEFT", 62, 0);
		achievementButton:Hide()
		achievementTitle:SetPoint("LEFT", achievementRow, "LEFT", 10, 0);
		achievementTitle:SetFontObject(GameFontHighlightSmall);
		achievementTitle:SetWidth(150);
		achievementBackground:Show();
		achievementLeftTexture:SetHeight(21);
		achievementRightTexture:SetHeight(21);
		achievementLeftTexture:SetTexCoord(0.7578125, 1.0, 0.0, 0.328125);
		achievementRightTexture:SetTexCoord(0.0, 0.1640625, 0.34375, 0.671875);
	elseif ( rowType == 2 ) then	--Header, not child
		achievementRow:SetPoint("LEFT", ArmoryAchievementFrame, "LEFT", 20, 0);
		achievementButton:SetPoint("LEFT", achievementRow, "LEFT", 3, 0);
		achievementButton:Show();
		achievementTitle:SetPoint("LEFT",achievementButton,"RIGHT",10,0);
		achievementTitle:SetFontObject(GameFontNormalLeft);
		achievementTitle:SetWidth(145);
		achievementBackground:Hide()	
		achievementLeftTexture:SetHeight(15);
		achievementLeftTexture:SetWidth(60);
		achievementRightTexture:SetHeight(15);
		achievementRightTexture:SetWidth(39);
		achievementLeftTexture:SetTexCoord(0.765625, 1.0, 0.046875, 0.28125);
		achievementRightTexture:SetTexCoord(0.0, 0.15234375, 0.390625, 0.625);
		achievementLeftTexture:SetPoint("LEFT", achievementBar, "LEFT", -2, 0);
		achievementBar:SetPoint("RIGHT", achievementRow, "RIGHT", 2, 0);
	elseif ( rowType == 3 ) then --Header and child
		achievementRow:SetPoint("LEFT", ArmoryAchievementFrame, "LEFT", 39, 0);
		achievementButton:SetPoint("LEFT", achievementRow, "LEFT", 3, 0);	--Change this
		achievementButton:Show();
		achievementTitle:SetPoint("LEFT" ,achievementButton, "RIGHT", 10, 0);
		achievementTitle:SetFontObject(GameFontNormalLeft);
		achievementTitle:SetWidth(135);
		achievementBackground:Hide()
		achievementLeftTexture:SetHeight(15);
		achievementLeftTexture:SetWidth(60);
		achievementRightTexture:SetHeight(15);
		achievementRightTexture:SetWidth(39);
		achievementLeftTexture:SetTexCoord(0.765625, 1.0, 0.046875, 0.28125);
		achievementRightTexture:SetTexCoord(0.0, 0.15234375, 0.390625, 0.625);
		achievementLeftTexture:SetPoint("LEFT", achievementBar, "LEFT", -2, 0);
		achievementBar:SetPoint("RIGHT", achievementRow, "RIGHT", 2, 0);
	end
	
	if ( (hasQuantity) or (rowType == 0) or (rowType == 1)) then
		achievementQuantity:Show();
		achievementBar:Show();
	else
		achievementQuantity:Hide();
		achievementBar:Hide();
	end
end

function ArmoryAchievementFrame_Update()
    local numAchievements;
    local achievementIndex, achievementRow, achievementTitle, achievementQuantity, achievementBar, achievementButton, achievementLeftLine, achievementBottomLine, achievementBackground;
    local id, name, isHeader, isChild, collapsed, quantity;
    local rightBarTexture, hasQuantity;

    local previousBigTexture = ArmoryAchievementFrameTopTreeTexture;	--In case we have a line going off the panel to the top
    previousBigTexture:Hide();
    local previousBigTexture2 = ArmoryAchievementFrameTopTreeTexture2;
    previousBigTexture2:Hide();

    if ( ArmoryAchievementFrame.selected == "achievements" ) then
        numAchievements = Armory:GetNumAchievements();
    else
        numAchievements = Armory:GetNumStatistics();
    end
 
    if ( numAchievements == 0 ) then
        ArmoryAchievementCollapseAllButton:Disable();
    else
        ArmoryAchievementCollapseAllButton:Enable();
    end

    -- Update scroll frame
    if ( not FauxScrollFrame_Update(ArmoryAchievementListScrollFrame, numAchievements, ARMORY_NUM_ACHIEVEMENTS_DISPLAYED, ARMORY_ACHIEVEMENTFRAME_ACHIEVEMENTHEIGHT ) ) then
        ArmoryAchievementListScrollFrameScrollBar:SetValue(0);
    end
    local achievementOffset = FauxScrollFrame_GetOffset(ArmoryAchievementListScrollFrame);
    
	local offScreenFudgeFactor = 5;
	local previousBigTextureRows = 0;
	local previousBigTextureRows2 = 0;
    for i=1, ARMORY_NUM_ACHIEVEMENTS_DISPLAYED, 1 do
        achievementIndex = achievementOffset + i;
		achievementRow = _G["ArmoryAchievementBar"..i];
		achievementBar = _G["ArmoryAchievementBar"..i.."AchievementBar"];
		achievementTitle = _G["ArmoryAchievementBar"..i.."AchievementName"];
		achievementButton = _G["ArmoryAchievementBar"..i.."ExpandOrCollapseButton"];
		achievementLeftLine = _G["ArmoryAchievementBar"..i.."LeftLine"];
		achievementBottomLine = _G["ArmoryAchievementBar"..i.."BottomLine"];
		achievementQuantity = _G["ArmoryAchievementBar"..i.."AchievementBarQuantity"];
		achievementBackground = _G["ArmoryAchievementBar"..i.."Background"];
        if ( achievementIndex <= numAchievements ) then
            local reqQuantity, link;
            if ( ArmoryAchievementFrame.selected == "achievements" ) then
                id, name, isHeader, isChild, collapsed, quantity, reqQuantity, link = Armory:GetAchievementInfo(achievementIndex);
                hasQuantity = (quantity or 0) > 0;
            else
                id, name, isHeader, isChild, collapsed, quantity = Armory:GetStatisticInfo(achievementIndex);
                hasQuantity = not isHeader;
            end
            achievementTitle:SetText(name);
            achievementQuantity:SetText("");
            if ( collapsed ) then
                achievementButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
            else
                achievementButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
            end
            achievementRow.index = achievementIndex;
            achievementRow.isCollapsed = collapsed;
            achievementRow.achievementId = nil;
            achievementRow.tooltip = nil;
            achievementRow.quantity = nil;
            achievementRow.name = nil;
            achievementRow.desc = nil;
            achievementRow.link = link;
            
            if ( not isHeader and ArmoryAchievementFrame.selected == "achievements" ) then
                achievementRow.achievementId = id;
                achievementRow.name = name;
                achievementRow.desc = select(8, GetAchievementInfo(id));
            end
            
            if ( reqQuantity ) then
                if ( reqQuantity == 0 ) then
                    quantityString = "";
                else
                    quantityString = floor((quantity * 100) / reqQuantity).." %";
                end
                achievementRow.tooltip = HIGHLIGHT_FONT_COLOR_CODE..quantityString..FONT_COLOR_CODE_CLOSE;
                achievementRow.quantity = quantity.." / "..reqQuantity;
                achievementBar:SetMinMaxValues(0, reqQuantity);
                achievementBar:SetValue(quantity);
            else
                achievementBar:SetMinMaxValues(0, 1);
                achievementBar:SetValue(0);
                if ( quantity ) then
                    if ( quantity:find("%d+ %(.+%)") ) then
                        achievementRow.quantity, achievementRow.desc = quantity:match("(%d+) %((.+)%)");
                    else
                        achievementRow.quantity = quantity;
                    end
                    achievementRow.name = name;
                    achievementQuantity:SetText(achievementRow.quantity);
               end
            end
            achievementBar:SetStatusBarColor(.25, .25, .75);
            
            if ( isHeader and not isChild ) then
                achievementLeftLine:SetTexCoord(0, 0.25, 0, 2);
                achievementBottomLine:Hide();
                achievementLeftLine:Hide();
                if ( previousBigTextureRows == 0 ) then
                    previousBigTexture:Hide();
                end
                previousBigTexture = achievementBottomLine;
                previousBigTextureRows = 0;

            elseif ( isHeader and isChild ) then
                ArmoryAchievementBar_DrawHorizontalLine(achievementLeftLine, 11, achievementButton);
                if ( previousBigTexture2 and previousBigTextureRows2 == 0 ) then
                    previousBigTexture2:Hide();
                end
                achievementBottomLine:Hide();
                previousBigTexture2 = achievementBottomLine;
                previousBigTextureRows2 = 0;
                previousBigTextureRows = previousBigTextureRows+1;
                ArmoryAchievementBar_DrawVerticalLine(previousBigTexture, previousBigTextureRows);

            elseif ( isChild ) then
                ArmoryAchievementBar_DrawHorizontalLine(achievementLeftLine, 11, achievementBackground);
                achievementBottomLine:Hide();
                previousBigTextureRows = previousBigTextureRows+1;
                previousBigTextureRows2 = previousBigTextureRows2+1;
                ArmoryAchievementBar_DrawVerticalLine(previousBigTexture2, previousBigTextureRows2);

            else
                -- is immediately under a main category
                ArmoryAchievementBar_DrawHorizontalLine(achievementLeftLine, 13, achievementBackground);
                achievementBottomLine:Hide();
                previousBigTextureRows = previousBigTextureRows+1;
                ArmoryAchievementBar_DrawVerticalLine(previousBigTexture, previousBigTextureRows);

            end

            ArmoryAchievementFrame_SetRowType(achievementRow, ((isChild and 1 or 0) + (isHeader and 2 or 0)), hasQuantity);

            achievementRow:Show();

            if ( achievementIndex ~= ArmoryAchievementFrame.selectedAchievement ) then
                _G["ArmoryAchievementBar"..i.."AchievementBarHighlight1"]:Hide();
                _G["ArmoryAchievementBar"..i.."AchievementBarHighlight2"]:Hide();
            end
        else
            achievementRow:Hide();
        end
    end
	
    for i = (ARMORY_NUM_ACHIEVEMENTS_DISPLAYED + achievementOffset + 1), numAchievements, 1 do
        if ( ArmoryAchievementFrame.selected == "achievements" ) then
            _, name, isHeader, isChild = Armory:GetAchievementInfo(i);
        else
            _, name, isHeader, isChild = Armory:GetStatisticInfo(i);
        end
        if not name then break; end

        if ( isHeader and not isChild ) then
            break;
        elseif ( (isHeader and isChild) or not (isHeader or isChild) ) then
            ArmoryAchievementBar_DrawVerticalLine(previousBigTexture, previousBigTextureRows+1);
            break;
        elseif ( isChild ) then
            ArmoryAchievementBar_DrawVerticalLine(previousBigTexture2, previousBigTextureRows2+1);
            break;
        end
    end
    
    
    -- Set the expand/collapse all button texture
    local numHeaders = 0;
    local notExpanded = 0;
    -- Somewhat redundant loop, but cleaner than the alternatives
    for i = 1, numAchievements do
        if ( ArmoryAchievementFrame.selected == "achievements" ) then
            _, _, isHeader, _, collapsed = Armory:GetAchievementInfo(i);
        else
            _, _, isHeader, _, collapsed = Armory:GetStatisticInfo(i);
        end
        if ( isHeader ) then
            numHeaders = numHeaders + 1;
            if ( collapsed ) then
                notExpanded = notExpanded + 1;
            end
        end
    end
    -- If all headers are not expanded then show collapse button, otherwise show the expand button
    if ( notExpanded ~= numHeaders ) then
        ArmoryAchievementCollapseAllButton.isCollapsed = nil;
        ArmoryAchievementCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
    else
        ArmoryAchievementCollapseAllButton.isCollapsed = 1;
        ArmoryAchievementCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
    end

end

function ArmoryAchievementBar_DrawVerticalLine(texture, rows)
    -- Need to add this fudge factor because the lines are anchored to the top of the screen in this case, not another button
    local fudgeFactor = 0;
    if ( texture == ArmoryAchievementFrameTopTreeTexture or texture == ArmoryAchievementFrameTopTreeTexture2) then
        fudgeFactor = 5;
    end
    texture:SetHeight(rows * REPUTATIONFRAME_ROWSPACING - fudgeFactor);
    texture:SetTexCoord(0, 0.25, 0, texture:GetHeight()/2);
    texture:Show();
end

function ArmoryAchievementBar_DrawHorizontalLine(texture, width, anchorTo)
    ArmoryReputationBar_DrawHorizontalLine(texture, width, anchorTo);
end

function ArmoryAchievementBar_OnClick(self)
    if ( IsModifiedClick("CHATLINK") ) then
        local link = self.link;
        if ( not link and self.achievementId ) then
            link = GetAchievementLink(self.achievementId);
        end
        if ( link and ChatEdit_GetActiveWindow() ) then
            ChatEdit_InsertLink(link);
        end
    else
        ArmoryAchievementFrame.selectedAchievement = self.index;
    end
end

function ArmoryAchievementCollapseAllButton_OnClick(self)
    if (self.isCollapsed) then
        self.isCollapsed = nil;
        if ( ArmoryAchievementFrame.selected == "achievements" ) then
            Armory:ExpandAchievementHeader(0);
        else
            Armory:ExpandStatisticsHeader(0);
        end
    else
        self.isCollapsed = 1;
        ArmoryAchievementListScrollFrameScrollBar:SetValue(0);
        if ( ArmoryAchievementFrame.selected == "achievements" ) then
            Armory:CollapseAchievementHeader(0);
        else
            Armory:CollapseStatisticsHeader(0);
        end
    end
    ArmoryAchievementFrame_Update();
end

function ArmoryAchievementFrameTab_OnClick(self)
    PanelTemplates_SetTab(ArmoryAchievementFrame, self:GetID());
    ArmoryAchievementFrame_SelectSource(self:GetID());
    ArmoryAchievementFrame_Update();
end

function ArmoryAchievementFrame_SelectSource(id)
    if ( id == 1 ) then
        ArmoryAchievementFrame.selected = "achievements";
        ArmoryAchievementFrameTitleText:SetText(ACHIEVEMENTS);
    else
        ArmoryAchievementFrame.selected = "statistics";
        ArmoryAchievementFrameTitleText:SetText(STATISTICS);
    end
end

function ArmoryAchievementFilter_OnTextChanged(self)
    local text = self:GetText();
    local refresh;

    if ( text == SEARCH ) then
        refresh = Armory:SetAchievementFilter("");
    else
        refresh = Armory:SetAchievementFilter(text);
    end
    if ( refresh ) then
        Armory:ExpandAchievementHeader(0);
        Armory:ExpandStatisticsHeader(0);
        ArmoryAchievementFrame_Update();
    end
end
