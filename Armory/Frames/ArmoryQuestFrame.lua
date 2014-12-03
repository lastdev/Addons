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

function ArmoryQuestFrame_Toggle()
    if ( ArmoryQuestFrame:IsShown() ) then
        HideUIPanel(ArmoryQuestFrame);
    else
        ArmoryCloseChildWindows();
        ShowUIPanel(ArmoryQuestFrame);
    end
end

function ArmoryQuestFrame_OnLoad(self)
    -- Tab Handling code
    PanelTemplates_SetNumTabs(self, 2);
    PanelTemplates_SetTab(self, 1);
    self.selected = "current";
end

function ArmoryQuestFrame_OnShow(self)
    PlaySound("igQuestLogOpen");
    if ( Armory:GetQuestLogFilter() == "" ) then
        ArmoryQuestFrameEditBox:SetText(SEARCH);
    else
        ArmoryQuestFrameEditBox:SetText(Armory:GetQuestLogFilter());
    end
    if ( Armory:GetNumQuestHistoryEntries() == 0 ) then
        ArmoryQuestFrameTab_OnClick(ArmoryQuestFrameTab1);
        ArmoryQuestFrameTab1:Hide();
        ArmoryQuestFrameTab2:Hide();
    else
        ArmoryQuestFrameTab1:Show();
        ArmoryQuestFrameTab2:Show();
        if ( self.selected == "current" ) then
            ArmoryQuestFrame_SelectSource(1);
        else
            ArmoryQuestFrame_SelectSource(2);
        end
    end
end

function ArmoryQuestFrame_OnHide(self)
    PlaySound("igQuestLogClose");
end

function ArmoryQuestFrameEditBox_OnTextChanged(self)
    local text = self:GetText();
    local refresh;

    if ( text == SEARCH ) then
        refresh = Armory:SetQuestLogFilter("");
    else
        refresh = Armory:SetQuestLogFilter(text);
    end
    if ( refresh ) then
        Armory:ExpandQuestHeader(0);
        Armory:ExpandQuestHistoryHeader(0);
        Armory:SelectQuestLogEntry(0);
        ArmoryQuest_Update();
    end
end

function ArmoryQuest_Update()
    if ( ArmoryQuestFrame.selected == "history" ) then
        ArmoryQuestHistory_Update();
    else
        ArmoryQuestLog_Update();
    end
end

function ArmoryQuestFrameTab_OnClick(self)
    PanelTemplates_SetTab(ArmoryQuestFrame, self:GetID());
    ArmoryQuestFrame_SelectSource(self:GetID());
end

function ArmoryQuestFrame_SelectSource(id)
    if ( id == 1 ) then
        ArmoryQuestFrame.selected = "current";
        ArmoryQuestLogFrame:Show();
        ArmoryQuestHistoryFrame:Hide();
    else
        ArmoryQuestFrame.selected = "history";
        ArmoryQuestLogFrame:Hide();
        ArmoryQuestHistoryFrame:Show();
    end
end

-- Used for quests and enemy coloration
function ArmoryGetDifficultyColor(level)
    local levelDiff = level - Armory:UnitLevel("player");
    local color
    if ( levelDiff >= 5 ) then
        color = QuestDifficultyColors["impossible"];
    elseif ( levelDiff >= 3 ) then
        color = QuestDifficultyColors["verydifficult"];
    elseif ( levelDiff >= -2 ) then
        color = QuestDifficultyColors["difficult"];
    elseif ( -levelDiff <= GetQuestGreenRange() ) then
        color = QuestDifficultyColors["standard"];
    else
        color = QuestDifficultyColors["trivial"];
    end
    return color;
end
