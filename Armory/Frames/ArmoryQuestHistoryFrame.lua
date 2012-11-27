--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 494 2012-09-04T21:04:44Z
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

ARMORY_QUESTHISTORY_DISPLAYED = 22;
ARMORY_QUESTHISTORY_HEIGHT = 16;

function ArmoryQuestHistoryFrame_OnLoad(self)
    self:RegisterEvent("LFG_COMPLETION_REWARD");
    self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE");
    self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
end

function ArmoryQuestHistoryFrame_OnEvent(self, event, ...)
    if ( event == "LFG_COMPLETION_REWARD" ) then
        ArmoryQuestHistoryFrame_UpdateQuests("raid");
    elseif ( event == "UPDATE_BATTLEFIELD_SCORE" ) then
        if ( GetBattlefieldWinner() and not IsActiveBattlefieldArena() ) then
            ArmoryQuestHistoryFrame_UpdateQuests("battle");
        end
    elseif ( event == "UPDATE_BATTLEFIELD_STATUS" ) then
        Armory:SetRandomBattleground();
	end
end

function ArmoryQuestHistoryFrame_OnShow(self)
    FauxScrollFrame_SetOffset(ArmoryQuestHistoryScrollFrame, 0);
    ArmoryQuestHistoryScrollFrameScrollBar:SetMinMaxValues(0, 0); 
    ArmoryQuestHistoryScrollFrameScrollBar:SetValue(0);
    ArmoryQuestHistory_Update();
end

function ArmoryQuestHistoryFrame_UpdateQuests(type)
    Armory:UpdateQuestHistory(type);
    ArmoryQuestHistory_Update();
end

function ArmoryQuestHistoryTitleButton_OnClick(self, button)
    local id = self:GetID();
    if ( self.isCollapsed ) then
        Armory:ExpandQuestHistoryHeader(id);
    else
        Armory:CollapseQuestHistoryHeader(id);
    end
    ArmoryQuestHistory_Update();
end

function ArmoryQuestHistoryCollapseAllButton_OnClick(self)
    if ( self.collapsed ) then
        self.collapsed = nil;
        Armory:ExpandQuestHistoryHeader(0);
    else
        self.collapsed = 1;
        ArmoryQuestHistoryScrollFrameScrollBar:SetValue(0);
        Armory:CollapseQuestHistoryHeader(0);
    end
    ArmoryQuestHistory_Update();
end

function ArmoryQuestHistory_Update()
    if ( not ArmoryQuestHistoryFrame:IsShown() ) then
        return;
    end

    local numEntries = Armory:GetNumQuestHistoryEntries();
    local offset = FauxScrollFrame_GetOffset(ArmoryQuestHistoryScrollFrame);

    if ( numEntries == 0 ) then
        ArmoryQuestHistoryExpandButtonFrame:Hide();
    else
        ArmoryQuestHistoryExpandButtonFrame:Show();
    end
    
    if ( offset > numEntries ) then
        offset = 0;
        FauxScrollFrame_SetOffset(ArmoryQuestHistoryScrollFrame, offset);
    end

    -- ScrollFrame update
    FauxScrollFrame_Update(ArmoryQuestHistoryScrollFrame, numEntries, ARMORY_QUESTHISTORY_DISPLAYED, ARMORY_QUESTHISTORY_HEIGHT);

    local questIndex, questTitle, questTitleTag, questNormalText, questHighlight;
    local questTitleText, isHeader, isCollapsed, questTag, label;
    local color;

    for i = 1, ARMORY_QUESTHISTORY_DISPLAYED do
        questIndex = i + FauxScrollFrame_GetOffset(ArmoryQuestHistoryScrollFrame);
        questTitle = _G["ArmoryQuestHistoryTitle"..i];
        questTitleTag = _G["ArmoryQuestHistoryTitle"..i.."Tag"];
        questNormalText = _G["ArmoryQuestHistoryTitle"..i.."NormalText"];
        questHighlight = _G["ArmoryQuestHistoryTitle"..i.."Highlight"];
        if ( questIndex <= numEntries ) then
            questTitleText, isHeader, isCollapsed, questTag, label = Armory:GetQuestHistoryTitle(questIndex);

            -- Set button widths if scrollbar is shown or hidden
            if ( ArmoryQuestHistoryScrollFrame:IsShown() ) then
                questTitle:SetWidth(300);
            else
                questTitle:SetWidth(320);
            end
            questTitle:SetID(questIndex);
            questTitle.isCollapsed = isCollapsed;

            if ( isHeader ) then
                questTitle:SetText(questTitleText);
                if ( isCollapsed ) then
                    questTitle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
                else
                    questTitle:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
                end
                questHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
                questTitleTag:SetText("");
                questNormalText:SetWidth(275);
            else
                questTitle:SetText("  "..questTitleText);
                questTitleTag:SetText("("..questTag..")");
                -- Shrink text to accomdate quest tags without wrapping
                questNormalText:SetWidth(questTitle:GetWidth() - 35 - questTitleTag:GetWidth());
                questTitle:SetNormalTexture("");
                questHighlight:SetTexture("");
            end

            color = QuestDifficultyColors[label];
            questTitleTag:SetTextColor(color.r, color.g, color.b);
            questTitle:SetNormalFontObject(color.font);
            questTitle.r = color.r;
            questTitle.g = color.g;
            questTitle.b = color.b;

            questTitle:Show();
        else
            questTitle:Hide();
        end
    end

    -- Set the expand/collapse all button texture
    local numHeaders = 0;
    local notExpanded = 0;
    -- Somewhat redundant loop, but cleaner than the alternatives
    for i=1, numEntries, 1 do
        _, isHeader, isCollapsed = Armory:GetQuestHistoryTitle(i);
        if ( isHeader ) then
            numHeaders = numHeaders + 1;
            if ( isCollapsed ) then
                notExpanded = notExpanded + 1;
            end
        end
    end
    -- If all headers are not expanded then show collapse button, otherwise show the expand button
    if ( notExpanded ~= numHeaders ) then
        ArmoryQuestHistoryCollapseAllButton.collapsed = nil;
        ArmoryQuestHistoryCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
    else
        ArmoryQuestHistoryCollapseAllButton.collapsed = 1;
        ArmoryQuestHistoryCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
    end
end

----------------------------------------------------------
-- Hooks
----------------------------------------------------------

local Orig_GetQuestReward = GetQuestReward;
function GetQuestReward(...)
    pcall(ArmoryQuestHistoryFrame_UpdateQuests, "quest"); 
    return Orig_GetQuestReward(...);
end
