--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 585 2013-03-02T14:19:03Z
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

ARMORY_NUM_FACTIONS_DISPLAYED = 15;
ARMORY_REPUTATIONFRAME_FACTIONHEIGHT = 26;

function ArmoryReputationFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("UPDATE_FACTION");
end

function ArmoryReputationFrame_OnEvent(self, event, ...)
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        if ( Armory.forceScan or not Armory:FactionsExists() ) then
            Armory:Execute(ArmoryReputationFrame_UpdateFactions);
        end
    else
        Armory:Execute(ArmoryReputationFrame_UpdateFactions);
    end
end

function ArmoryReputationFrame_OnShow(self)
    ArmoryReputationFrame_Update();
end

function ArmoryReputationFrame_UpdateFactions()
    -- UpdateFactions will trigger UPDATE_FACTION
    ArmoryReputationFrame:UnregisterEvent("UPDATE_FACTION");
    Armory:UpdateFactions();
    ArmoryReputationFrame:RegisterEvent("UPDATE_FACTION");
    if ( ArmoryReputationFrame:IsShown() ) then
        ArmoryReputationFrame_Update();
    end
end

function ArmoryReputationFrame_UpdateHeader(show)
    if ( show ) then
        ArmoryReputationFrameFactionLabel:Show();
        ArmoryReputationFrameStandingLabel:Show();
    else
        ArmoryReputationFrameFactionLabel:Hide();
        ArmoryReputationFrameStandingLabel:Hide();
    end
end

function ArmoryReputationFrame_SetRowType(factionRow, rowType, hasRep)    --rowType is a binary table of type isHeader, isChild
    local factionRowName = factionRow:GetName()
    local factionBar = _G[factionRowName.."ReputationBar"];
    local factionTitle = _G[factionRowName.."FactionName"];
    local factionButton = _G[factionRowName.."ExpandOrCollapseButton"];
    local factionStanding = _G[factionRowName.."ReputationBarFactionStanding"];
    local factionBackground = _G[factionRowName.."Background"];
    local factionLeftTexture = _G[factionRowName.."ReputationBarLeftTexture"];
    local factionRightTexture = _G[factionRowName.."ReputationBarRightTexture"];
    factionLeftTexture:SetWidth(62);
    factionRightTexture:SetWidth(42);
    factionBar:SetPoint("RIGHT", factionRow, "RIGHT", 0, 0);
    if ( rowType == 0 ) then --Not header, not child
        factionRow:SetPoint("LEFT", ArmoryReputationFrame, "LEFT", 34, 0);
        factionButton:Hide();
        factionTitle:SetPoint("LEFT", factionRow, "LEFT", 10, 0);
        factionTitle:SetFontObject(GameFontHighlightSmall);
        factionTitle:SetWidth(160);
        factionBackground:Show();
        factionLeftTexture:SetHeight(21);
        factionRightTexture:SetHeight(21);
        factionLeftTexture:SetTexCoord(0.7578125, 1.0, 0.0, 0.328125);
        factionRightTexture:SetTexCoord(0.0, 0.1640625, 0.34375, 0.671875);
        factionBar:SetWidth(101);
    elseif ( rowType == 1 ) then --Child, not header
        factionRow:SetPoint("LEFT", ArmoryReputationFrame, "LEFT", 52, 0);
        factionButton:Hide()
        factionTitle:SetPoint("LEFT", factionRow, "LEFT", 10, 0);
        factionTitle:SetFontObject(GameFontHighlightSmall);
        factionTitle:SetWidth(150);
        factionBackground:Show();
        factionLeftTexture:SetHeight(21);
        factionRightTexture:SetHeight(21);
        factionLeftTexture:SetTexCoord(0.7578125, 1.0, 0.0, 0.328125);
        factionRightTexture:SetTexCoord(0.0, 0.1640625, 0.34375, 0.671875);
        factionBar:SetWidth(101);
    elseif ( rowType == 2 ) then    --Header, not child
        factionRow:SetPoint("LEFT", ArmoryReputationFrame, "LEFT", 10, 0);
        factionButton:SetPoint("LEFT", factionRow, "LEFT", 3, 0);
        factionButton:Show();
        factionTitle:SetPoint("LEFT",factionButton,"RIGHT",10,0);
        factionTitle:SetFontObject(GameFontNormalLeft);
        factionTitle:SetWidth(145);
        factionBackground:Hide()    
        factionLeftTexture:SetHeight(15);
        factionLeftTexture:SetWidth(60);
        factionRightTexture:SetHeight(15);
        factionRightTexture:SetWidth(39);
        factionLeftTexture:SetTexCoord(0.765625, 1.0, 0.046875, 0.28125);
        factionRightTexture:SetTexCoord(0.0, 0.15234375, 0.390625, 0.625);
        factionBar:SetWidth(99);
    elseif ( rowType == 3 ) then --Header and child
        factionRow:SetPoint("LEFT", ArmoryReputationFrame, "LEFT", 29, 0);
        factionButton:SetPoint("LEFT", factionRow, "LEFT", 3, 0);
        factionButton:Show();
        factionTitle:SetPoint("LEFT" ,factionButton, "RIGHT", 10, 0);
        factionTitle:SetFontObject(GameFontNormalLeft);
        factionTitle:SetWidth(135);
        factionBackground:Hide()
        factionLeftTexture:SetHeight(15);
        factionLeftTexture:SetWidth(60);
        factionRightTexture:SetHeight(15);
        factionRightTexture:SetWidth(39);
        factionLeftTexture:SetTexCoord(0.765625, 1.0, 0.046875, 0.28125);
        factionRightTexture:SetTexCoord(0.0, 0.15234375, 0.390625, 0.625);
        factionBar:SetWidth(99);
    end
    
    if ( (hasRep) or (rowType == 0) or (rowType == 1)) then
        factionStanding:Show();
        factionBar:Show();
        factionBar:GetParent().hasRep = true;
    else
        factionStanding:Hide();
        factionBar:Hide();
        factionBar:GetParent().hasRep = false;
    end
end

function ArmoryReputationFrame_Update()
    local numFactions = Armory:GetNumFactions();
    local factionIndex, factionRow, factionTitle, factionStanding, factionBar, factionButton, factionLeftLine, factionBottomLine, factionBackground;
    local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild;
    local atWarIndicator, rightBarTexture;

    local previousBigTexture = ArmoryReputationFrameTopTreeTexture;    --In case we have a line going off the panel to the top
    previousBigTexture:Hide();
    local previousBigTexture2 = ArmoryReputationFrameTopTreeTexture2;
    previousBigTexture2:Hide();

    -- Update scroll frame
    if ( not FauxScrollFrame_Update(ArmoryReputationListScrollFrame, numFactions, ARMORY_NUM_FACTIONS_DISPLAYED, ARMORY_REPUTATIONFRAME_FACTIONHEIGHT ) ) then
        ArmoryReputationListScrollFrameScrollBar:SetValue(0);
    end
    local factionOffset = FauxScrollFrame_GetOffset(ArmoryReputationListScrollFrame);

    local gender = Armory:UnitSex("player");

    local offScreenFudgeFactor = 5;
    local previousBigTextureRows = 0;
    local previousBigTextureRows2 = 0;
    for i = 1, ARMORY_NUM_FACTIONS_DISPLAYED do
        factionIndex = factionOffset + i;
        factionRow = _G["ArmoryReputationBar"..i];
        factionBar = _G["ArmoryReputationBar"..i.."ReputationBar"];
        factionTitle = _G["ArmoryReputationBar"..i.."FactionName"];
        factionButton = _G["ArmoryReputationBar"..i.."ExpandOrCollapseButton"];
        factionLeftLine = _G["ArmoryReputationBar"..i.."LeftLine"];
        factionBottomLine = _G["ArmoryReputationBar"..i.."BottomLine"];
        factionStanding = _G["ArmoryReputationBar"..i.."ReputationBarFactionStanding"];
        factionBackground = _G["ArmoryReputationBar"..i.."Background"];
        if ( factionIndex <= numFactions ) then
            name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = Armory:GetFactionInfo(factionIndex);
            factionTitle:SetText(name);
            if ( isCollapsed ) then
                factionButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
            else
                factionButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
            end
            factionRow.index = factionIndex;
            factionRow.isCollapsed = isCollapsed;
            
            local factionStandingtext;
            local isCappedFriendship;
            -- description contains friendship
            if ( description ) then
                factionStandingtext = description;
                isCappedFriendship = (barValue == barMax);
            else
                factionStandingtext = GetText("FACTION_STANDING_LABEL"..standingID, gender);
            end
            factionStanding:SetText(factionStandingtext);

            -- Normalize values
            barMax = barMax - barMin;
            barValue = barValue - barMin;
            barMin = 0;

            factionRow.standingText = factionStandingtext;
            if ( isCappedFriendship ) then
                factionRow.tooltip = nil;
            else
                factionRow.tooltip = HIGHLIGHT_FONT_COLOR_CODE.." "..barValue.." / "..barMax..FONT_COLOR_CODE_CLOSE;
            end
            factionBar:SetMinMaxValues(0, barMax);
            factionBar:SetValue(barValue);
            local color = FACTION_BAR_COLORS[standingID];
            factionBar:SetStatusBarColor(color.r, color.g, color.b);

            if ( isHeader and not isChild ) then
                factionLeftLine:SetTexCoord(0, 0.25, 0, 2);
                factionBottomLine:Hide();
                factionLeftLine:Hide();
                if ( previousBigTextureRows == 0 ) then
                    previousBigTexture:Hide();
                end
                previousBigTexture = factionBottomLine;
                previousBigTextureRows = 0;

            elseif ( isHeader and isChild ) then
                ArmoryReputationBar_DrawHorizontalLine(factionLeftLine, 11, factionButton);
                if ( previousBigTexture2 and previousBigTextureRows2 == 0 ) then
                    previousBigTexture2:Hide();
                end
                factionBottomLine:Hide();
                previousBigTexture2 = factionBottomLine;
                previousBigTextureRows2 = 0;
                previousBigTextureRows = previousBigTextureRows+1;
                ArmoryReputationBar_DrawVerticalLine(previousBigTexture, previousBigTextureRows);

            elseif ( isChild ) then
                ArmoryReputationBar_DrawHorizontalLine(factionLeftLine, 11, factionBackground);
                factionBottomLine:Hide();
                previousBigTextureRows = previousBigTextureRows+1;
                previousBigTextureRows2 = previousBigTextureRows2+1;
                ArmoryReputationBar_DrawVerticalLine(previousBigTexture2, previousBigTextureRows2);

            else
                -- is immediately under a main category
                ArmoryReputationBar_DrawHorizontalLine(factionLeftLine, 13, factionBackground);
                factionBottomLine:Hide();
                previousBigTextureRows = previousBigTextureRows+1;
                ArmoryReputationBar_DrawVerticalLine(previousBigTexture, previousBigTextureRows);

            end

            ArmoryReputationFrame_SetRowType(factionRow, ((isChild and 1 or 0) + (isHeader and 2 or 0)), hasRep);

            factionRow:Show();

            -- Update details if this is the selected faction
            if ( atWarWith ) then
                _G["ArmoryReputationBar"..i.."ReputationBarAtWarHighlight1"]:Show();
                _G["ArmoryReputationBar"..i.."ReputationBarAtWarHighlight2"]:Show();
            else
                _G["ArmoryReputationBar"..i.."ReputationBarAtWarHighlight1"]:Hide();
                _G["ArmoryReputationBar"..i.."ReputationBarAtWarHighlight2"]:Hide();
            end
            if ( factionIndex ~= ArmoryReputationFrame.selectedFaction ) then
                _G["ArmoryReputationBar"..i.."ReputationBarHighlight1"]:Hide();
                _G["ArmoryReputationBar"..i.."ReputationBarHighlight2"]:Hide();
            end
        else
            factionRow:Hide();
        end
    end
    
    for i = (ARMORY_NUM_FACTIONS_DISPLAYED + factionOffset + 1), numFactions, 1 do
        local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild  = Armory:GetFactionInfo(i);
        if not name then break; end

        if ( isHeader and not isChild ) then
            break;
        elseif ( (isHeader and isChild) or not(isHeader or isChild) ) then
            ArmoryReputationBar_DrawVerticalLine(previousBigTexture, previousBigTextureRows+1);
            break;
        elseif ( isChild ) then
            ArmoryReputationBar_DrawVerticalLine(previousBigTexture2, previousBigTextureRows2+1);
            break;
        end
    end
end

function ArmoryReputationBar_DrawVerticalLine(texture, rows)
    -- Need to add this fudge factor because the lines are anchored to the top of the screen in this case, not another button
    local fudgeFactor = 0;
    if ( texture == ArmoryReputationFrameTopTreeTexture or texture == ArmoryReputationFrameTopTreeTexture2) then
        fudgeFactor = 5;
    end
    texture:SetHeight(rows*REPUTATIONFRAME_ROWSPACING-fudgeFactor);
    texture:SetTexCoord(0, 0.25, 0, texture:GetHeight()/2);
    texture:Show();
end

function ArmoryReputationBar_DrawHorizontalLine(texture, width, anchorTo)
  	texture:SetPoint("RIGHT", anchorTo, "LEFT", 3, 0);
	texture:SetWidth(width);
	texture:SetTexCoord(0, width/2, 0, 0.25);
	texture:Show();
end

function ArmoryReputationBar_OnClick(self)
    if ( IsModifiedClick("CHATLINK") ) then
        if ( self.hasRep ) then
            local name, standing, standingID, barMin, barMax, barValue = Armory:GetFactionInfo(self.index);
            if ( not standing ) then
                standing = GetText("FACTION_STANDING_LABEL"..standingID, Armory:UnitSex("player"));
            end
            local text = format(ARMORY_REPUTATION_SUMMARY, name, standing, barValue - barMin, barMax - barMin, barMax - barValue);
            if ( not ChatEdit_InsertLink(text) ) then
                ChatFrame_OpenChat(text);
            end
        end
    end
end
