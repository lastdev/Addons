--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 572 2013-01-04T15:34:54Z
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

local AGB = AGB;
local Armory = Armory;

function ArmoryInventoryGuildBankFrame_OnLoad(self)
    PanelTemplates_SetNumTabs(ArmoryInventoryFrame, 3);
    PanelTemplates_UpdateTabs(ArmoryInventoryFrame);
    self.collapsedTabs = {};
end

function ArmoryInventoryGuildBankFrameTab_OnClick(self)
    ArmoryCloseDropDownMenus();
    PanelTemplates_SetTab(ArmoryInventoryFrame, self:GetID());
    ArmoryInventoryIconViewFrame:Hide();
    ArmoryInventoryListViewFrame:Hide();
    ArmoryInventoryGuildBankFrame:Show();
end

function ArmoryInventoryGuildBankFrame_OnShow(self)
    local profile = Armory:CurrentProfile();
    local dbEntry = AGB:SelectDb(self, profile.realm, Armory:GetGuildInfo("player"));

    FauxScrollFrame_SetOffset(ArmoryInventoryGuildBankScrollFrame, 0);
    ArmoryInventoryGuildBankScrollFrameScrollBar:SetMinMaxValues(0, 0); 
    ArmoryInventoryGuildBankScrollFrameScrollBar:SetValue(0);

    MoneyFrame_Update("ArmoryInventoryMoneyFrame", dbEntry and AGB:GetMoney(dbEntry) or 0);
    ArmoryInventoryGuildBankFrame_Update();
end

function ArmoryInventoryGuildBankFrame_OnHide(self)
    ArmoryInventoryMoneyFrame_OnShow(ArmoryInventoryMoneyFrame);
end

function ArmoryInventoryGuildBankFrame_Update()
    local frame = ArmoryInventoryGuildBankFrame;
    local isCollapsed;

    AGB:SetFilter(frame, Armory:GetInventoryItemNameFilter());
    AGB:UpdateItemLines(frame);

    local numLines = #frame.itemLines;
    local offset = FauxScrollFrame_GetOffset(ArmoryInventoryGuildBankScrollFrame);

    if ( numLines == 0 ) then
        local msg = ARMORY_GUILDBANK_NO_DATA;
        if ( frame.selectedRealm == AGB.realm and frame.selectedGuild == AGB.guild ) then
            msg = msg.."\n\n"..ARMORY_GUILDBANK_NO_TABS;
        end
        ArmoryInventoryGuildBankFrameMessage:SetText(msg);
        ArmoryInventoryGuildBankFrameMessage:Show();
        ArmoryInventoryCollapseAllButton:Disable();
    else
        ArmoryInventoryGuildBankFrameMessage:Hide();
        ArmoryInventoryCollapseAllButton:Enable();
    end

    if ( offset > numLines ) then
        offset = 0;
        FauxScrollFrame_SetOffset(ArmoryInventoryGuildBankScrollFrame, offset);
    end

    -- ScrollFrame update
    FauxScrollFrame_Update(ArmoryInventoryGuildBankScrollFrame, numLines, ARMORY_INVENTORY_LINES_DISPLAYED, ARMORY_INVENTORY_HEIGHT);

    for i = 1, ARMORY_INVENTORY_LINES_DISPLAYED do
        local lineIndex = i + offset;
        local lineButton = _G["ArmoryInventoryGuildBankLine"..i];
        local lineButtonText = _G["ArmoryInventoryGuildBankLine"..i.."Text"];
        local lineButtonHighlight = _G["ArmoryInventoryGuildBankLine"..i.."Highlight"];
        local lineButtonTexture = _G["ArmoryInventoryGuildBankLine"..i.."NormalTexture"];

        if ( lineIndex <= numLines ) then
            -- Set button widths if scrollbar is shown or hidden
            if ( ArmoryInventoryGuildBankScrollFrame:IsShown() ) then
                lineButtonText:SetWidth(265);
            else
                lineButtonText:SetWidth(285);
            end

            local name, tab, count, texture, link = unpack(frame.itemLines[lineIndex]);
            local color;

            lineButton.link = link;

            if ( tab ) then
                lineButton:SetID(tab);
                lineButton.isCollapsed = AGB:GetTabLineState(frame, tab);
                if ( lineButton.isCollapsed ) then
                    lineButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
                else
                    lineButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
                end
                lineButtonHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
                lineButtonTexture:SetPoint("TOPLEFT", lineButton, "TOPLEFT", 3, 0);
                lineButtonText:SetPoint("TOPLEFT", lineButton, "TOPLEFT", 21, 0);
                lineButton:UnlockHighlight();
            else
                lineButton:SetID(0);
                if ( texture ) then
                    lineButton:SetNormalTexture(texture);
                else
                    lineButton:SetNormalTexture("");
                end
                lineButtonHighlight:SetTexture("");
                lineButtonTexture:SetPoint("TOPLEFT", lineButton, "TOPLEFT", 21, 0);
                lineButtonText:SetPoint("TOPLEFT", lineButton, "TOPLEFT", 40, 0);
                if ( link ) then
                    color = link:match("^(|c%x+)|H");
                end
                name = (color or HIGHLIGHT_FONT_COLOR_CODE)..name..FONT_COLOR_CODE_CLOSE.." x "..count;
            end
            lineButton:SetText(name);
            lineButton:Show();
        else
            lineButton:Hide();
        end
    end
    
    -- Set the expand/collapse all button texture
    local numHeaders = 0;
    local notExpanded = 0;
    for i = 1, numLines do
        local _, tab = unpack(frame.itemLines[i]);
        if ( tab ) then
            numHeaders = numHeaders + 1;
            if ( AGB:GetTabLineState(frame, tab) ) then
                notExpanded = notExpanded + 1;
            end
        end
    end
    -- If all headers are not expanded then show collapse button, otherwise show the expand button
    if ( notExpanded ~= numHeaders ) then
        ArmoryInventoryCollapseAllButton.isCollapsed = nil;
        ArmoryInventoryCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
    else
        ArmoryInventoryCollapseAllButton.isCollapsed = 1;
        ArmoryInventoryCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
    end
end

function ArmoryInventoryGuildBankFrame_Refresh()
    local frame = ArmoryInventoryGuildBankFrame;
    if ( frame.selectedRealm == AGB.realm and frame.selectedGuild == AGB.guild ) then
        if ( ArmoryInventoryGuildBankFrame:IsShown() ) then
            ArmoryInventoryGuildBankFrame_Update();
        end
    end
end

----------------------------------------------------------
-- Inventory hooks
----------------------------------------------------------

local Orig_ArmoryInventoryFrame_OnShow = ArmoryInventoryFrame_OnShow;
function ArmoryInventoryFrame_OnShow(...)
    local guild = Armory:GetGuildInfo("player");
    local selected;

    if ( guild and AGB:GetConfigIntegrate() ) then
        ArmoryInventoryFrameTab3:Show();
        selected = PanelTemplates_GetSelectedTab(ArmoryInventoryFrame) == 3;
    else
        ArmoryInventoryGuildBankFrame:Hide();
        ArmoryInventoryFrameTab3:Hide();
        selected = false;
    end
    
    if ( selected ) then
        PanelTemplates_SetTab(ArmoryInventoryFrame, 3);
        ArmoryInventoryGuildBankFrame:Show();
    else
        ArmoryInventoryGuildBankFrame:Hide();
        Orig_ArmoryInventoryFrame_OnShow(...);
    end
end

local Orig_ArmoryInventoryFrame_Update = ArmoryInventoryFrame_Update;
function ArmoryInventoryFrame_Update(...)
    if ( PanelTemplates_GetSelectedTab(ArmoryInventoryFrame) == 3 ) then
        ArmoryInventoryGuildBankFrame_Update();
    else
        Orig_ArmoryInventoryFrame_Update(...);
    end
end

local Orig_ArmoryInventoryMoneyFrame_OnEnter = ArmoryInventoryMoneyFrame_OnEnter;
function ArmoryInventoryMoneyFrame_OnEnter(...)
    if ( PanelTemplates_GetSelectedTab(ArmoryInventoryFrame) ~= 3 ) then
        Orig_ArmoryInventoryMoneyFrame_OnEnter(...);
    end
end

local Orig_ArmoryInventoryFrameTab_OnClick = ArmoryInventoryFrameTab_OnClick;
function ArmoryInventoryFrameTab_OnClick(...)
    ArmoryInventoryGuildBankFrame:Hide();
    Orig_ArmoryInventoryFrameTab_OnClick(...);
end

local Orig_ArmoryInventoryFrameButton_OnClick = ArmoryInventoryFrameButton_OnClick;
function ArmoryInventoryFrameButton_OnClick(self, ...)
    if ( PanelTemplates_GetSelectedTab(ArmoryInventoryFrame) == 3 ) then
        local tab = self:GetID();
        if ( tab > 0 ) then
            AGB:SetTabLineState(ArmoryInventoryGuildBankFrame, tab, not self.isCollapsed);
            ArmoryInventoryGuildBankFrame_Update();
        end
    else
        Orig_ArmoryInventoryFrameButton_OnClick(self, ...);    
    end
end
