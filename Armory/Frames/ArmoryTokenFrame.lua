--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 509 2012-09-09T18:07:22Z
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

function ArmoryTokenButton_OnLoad(self)
    local name = self:GetName();
    self.count = _G[name.."Count"];
    self.name = _G[name.."Name"];
    self.icon = _G[name.."Icon"];
    self.check = _G[name.."Check"];
    self.expandIcon = _G[name.."ExpandIcon"];
    self.categoryLeft = _G[name.."CategoryLeft"];
    self.categoryRight = _G[name.."CategoryRight"];
    self.highlight = _G[name.."Highlight"];
    self.stripe = _G[name.."Stripe"];
end

function ArmoryTokenButton_OnClick(self)
    if ( self.isHeader ) then
        if ( self.isExpanded ) then
            Armory:ExpandCurrencyList(self.index, 0);
        else
            Armory:ExpandCurrencyList(self.index, 1);
        end
    elseif ( IsModifiedClick("CHATLINK") and self.LinkButton.link ) then
        HandleModifiedItemClick(self.LinkButton.link);
    end
    ArmoryTokenFrame_Update();
end

function ArmoryTokenFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE");

    ArmoryTokenFrameContainerScrollBar.Show = 
        function (self)
            ArmoryTokenFrameContainer:SetWidth(299);
            for _, button in next, _G["ArmoryTokenFrameContainer"].buttons do
                button:SetWidth(295);
            end
            getmetatable(self).__index.Show(self);
        end;

    ArmoryTokenFrameContainerScrollBar.Hide = 
        function (self)
            ArmoryTokenFrameContainer:SetWidth(313);
            for _, button in next, ArmoryTokenFrameContainer.buttons do
                button:SetWidth(313);
            end
            getmetatable(self).__index.Hide(self);
        end;
        
    ArmoryTokenFrameContainer.update = ArmoryTokenFrame_Update;
    HybridScrollFrame_CreateButtons(ArmoryTokenFrameContainer, "ArmoryTokenButtonTemplate", 0, -2, "TOPLEFT", "TOPLEFT", 0, -TOKEN_BUTTON_OFFSET);
    local buttons = ArmoryTokenFrameContainer.buttons;
    local numButtons = #buttons;
    for i=1, numButtons do
        if ( mod(i, 2) == 1 ) then
            buttons[i].stripe:Hide();
        end
    end
end

function ArmoryTokenFrame_OnEvent(self, event, ...)
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        if ( Armory.forceScan or not Armory:CurrencyExists() ) then
            Armory:Execute(ArmoryTokenFrame_UpdateCurrency);
        end
    else
        Armory:Execute(ArmoryTokenFrame_UpdateCurrency);
    end
end

function ArmoryTokenFrame_OnShow(self)
    ArmoryTokenFrame_Update();
end

function ArmoryTokenFrame_Update()

    -- Setup the buttons
    local scrollFrame = ArmoryTokenFrameContainer;
    local offset = HybridScrollFrame_GetOffset(scrollFrame);
    local buttons = scrollFrame.buttons;
    local numButtons = #buttons;
    local numTokenTypes = Armory:GetCurrencyListSize();
    local name, isHeader, isExpanded, isUnused, isWatched, count, icon, link;
    local button, index;
    for i=1, numButtons do
        index = offset+i;
        name, isHeader, isExpanded, isUnused, isWatched, count, icon, link = Armory:GetCurrencyListInfo(index);
        button = buttons[i];
        button.check:Hide();
        if ( not name or name == "" ) then
            button:Hide();
        else
            if ( isHeader ) then
                button.categoryLeft:Show();
                button.categoryRight:Show();
				button.categoryMiddle:Show();
                button.expandIcon:Show();
                button.count:SetText("");
                button.icon:SetTexture("");
                if ( isExpanded ) then
                    button.expandIcon:SetTexCoord(0.5625, 1, 0, 0.4375);
                else
                    button.expandIcon:SetTexCoord(0, 0.4375, 0, 0.4375);
                end
                button.highlight:SetTexture("Interface\\TokenFrame\\UI-TokenFrame-CategoryButton");
                button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 3, -2);
                button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -3, 2);
				button.name:SetText(name);
				button.name:SetFontObject("GameFontNormal");
				button.name:SetPoint("LEFT", 22, 0);
				button.LinkButton:Hide();
            else
                button.categoryLeft:Hide();
                button.categoryRight:Hide();
				button.categoryMiddle:Hide();
                button.expandIcon:Hide();
                button.count:SetText(count);
                button.icon:SetTexture(icon);
                if ( isWatched ) then
                    button.check:Show();
                end
                button.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
                button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0);
                button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0);
                --Gray out the text if the count is 0
                if ( count == 0 ) then
                    button.count:SetFontObject("GameFontDisable");
                    button.name:SetFontObject("GameFontDisable");
                else
                    button.count:SetFontObject("GameFontHighlight");
                    button.name:SetFontObject("GameFontHighlight");
                end
				button.name:SetText(name);
				button.name:SetPoint("LEFT", 11, 0);
				button.LinkButton:Show();
            end
            --Manage highlight
            if ( name == ArmoryTokenFrame.selectedToken ) then
                ArmoryTokenFrame.selectedID = index;
                button:LockHighlight();
            else
                button:UnlockHighlight();
            end

            button.index = index;
            button.isHeader = isHeader;
            button.isExpanded = isExpanded;
            button.isUnused = isUnused;
            button.isWatched = isWatched;
            button.LinkButton.link = link;
            button:Show();
        end
    end
    local totalHeight = numTokenTypes * (button:GetHeight()+TOKEN_BUTTON_OFFSET);
    local displayedHeight = #buttons * (button:GetHeight()+TOKEN_BUTTON_OFFSET);

    HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);
end

function ArmoryTokenFrame_UpdateCurrency()
    Armory:UpdateCurrency();
    ArmoryTokenFrame_Update();
end
