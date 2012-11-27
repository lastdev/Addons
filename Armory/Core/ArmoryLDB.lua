--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 523 2012-09-16T22:59:10Z
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
        
Armory.LDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Armory", 
    { type = "data source", 
      icon = "Interface\\CharacterFrame\\TemporaryPortrait", 
      text = UNKNOWN,
      label = ARMORY_TITLE
     }
);

local function GetAnchor(frame)
    local x, y = frame:GetCenter();
    local hAnchor, vAnchor;
    if ( x < UIParent:GetWidth() * 1/3 ) then
        hAnchor = "LEFT";
    elseif ( x > UIParent:GetWidth() * 2/3 ) then
        hAnchor = "RIGHT";
    else
        hAnchor = "";
    end
    if ( y > UIParent:GetHeight() / 2 ) then
        vAnchor = "TOP";
    else
        vAnchor = "BOTTOM";
    end
    return vAnchor..hAnchor, frame, (vAnchor == "TOP" and "BOTTOM" or "TOP")..hAnchor;
end

function Armory.LDB:OnClick(button)
    GameTooltip:Hide();
    Armory:HideSummary();
    if ( button == "LeftButton" ) then
        Armory:Toggle();
    elseif ( button == "RightButton" ) then
        ArmoryToggleDropDownMenu(1, nil, Armory.menu, self, 0, 0);
    end
end

function Armory.LDB:OnTooltipShow()
    if ( not ArmoryDropDownList1:IsVisible() ) then
        local realm, character = Armory:GetPaperDollLastViewed();
        if ( Armory.summary and Armory.summary:IsShown() ) then
           self:SetFrameLevel(Armory.summary:GetFrameLevel() + 2);
        end
        
        local color;
        if ( realm == Armory.playerRealm and character == Armory.player and not Armory:GetConfigCharacterEnabled() ) then
            color = RED_FONT_COLOR;
        else
            color = HIGHLIGHT_FONT_COLOR;
        end

        self:AddLine(ARMORY_TITLE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
        self:AddDoubleLine(ARMORY_TOOLTIP1, character, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, color.r, color.g, color.b);
        self:AddDoubleLine(ARMORY_TOOLTIP2, realm, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, color.r, color.g, color.b);
        
        if ( table.getn(Armory:SelectableProfiles()) > 0 ) then
            Armory:TooltipAddHints(self, ARMORY_TOOLTIP_HINT1, ARMORY_TOOLTIP_HINT2);
        else
            Armory:TooltipAddHints(self, ARMORY_TOOLTIP_HINT2);
        end

        if ( not (Armory.summary and Armory.summary:IsShown()) ) then
            if ( Armory.LDB.anchorFrame == nil ) then
                Armory.LDB.anchorFrame = CreateFrame("Frame");
            end
            Armory.LDB.anchorFrame:SetParent(self:GetOwner());
            Armory.LDB.anchorFrame:SetAllPoints(self:GetOwner());
            
            Armory.summaryEnabled = true;
            Armory:ShowSummary(Armory.LDB.anchorFrame);
        end
    end  
end

function Armory.LDB:OnEnter()
    if ( not ArmoryDropDownList1:IsVisible() ) then
        GameTooltip:SetOwner(self, "ANCHOR_NONE");
        GameTooltip:SetPoint(GetAnchor(self));
        GameTooltip:ClearLines();

        Armory.LDB.OnTooltipShow(GameTooltip);
        
        GameTooltip:Show();
    end
end

function Armory.LDB:OnLeave()
    Armory.summaryEnabled = false;
    GameTooltip:Hide();
end