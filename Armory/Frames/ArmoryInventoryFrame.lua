--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 499 2012-09-05T15:54:14Z
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

ARMORY_MAIL_CONTAINER = -3;
ARMORY_AUCTIONS_CONTAINER = -4;
ARMORY_NEUTRAL_AUCTIONS_CONTAINER = -5;
ARMORY_EQUIPMENT_CONTAINER = -6;
ARMORY_VOID_CONTAINER = -7;

ARMORY_CACHE_CONTAINER = "Cache";
ARMORY_VOID_STORAGE_MAX = 80;

ArmoryInventoryContainers = { 
    BACKPACK_CONTAINER, 1, 2, 3, 4, BANK_CONTAINER, 5, 6, 7, 8, 9, 10, 11, 
    ARMORY_VOID_CONTAINER,
    ARMORY_MAIL_CONTAINER, 
    ARMORY_AUCTIONS_CONTAINER, ARMORY_NEUTRAL_AUCTIONS_CONTAINER, 
    ARMORY_EQUIPMENT_CONTAINER
};

function ArmoryInventoryFrame_Toggle()
    if ( ArmoryInventoryFrame:IsShown() ) then
        HideUIPanel(ArmoryInventoryFrame);
    else
        ArmoryCloseChildWindows();
        ShowUIPanel(ArmoryInventoryFrame);
    end
end

function ArmoryInventoryFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("BAG_UPDATE");
    self:RegisterEvent("BANKFRAME_OPENED");
    self:RegisterEvent("BANKFRAME_CLOSED");
    self:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	self:RegisterEvent("MAIL_SHOW");
    self:RegisterEvent("MAIL_SEND_SUCCESS");
    self:RegisterEvent("MAIL_CLOSED");
    self:RegisterEvent("AUCTION_OWNED_LIST_UPDATE");
    self:RegisterEvent("VOID_STORAGE_CLOSE");

    SetPortraitToTexture("ArmoryInventoryFramePortrait", "Interface\\Buttons\\Button-Backpack-Up");
    
    -- Tab Handling code
    PanelTemplates_SetNumTabs(self, 2);
    PanelTemplates_SetTab(self, 1);

    hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", 
        function(self, button)
            local bag = self:GetParent():GetID();
            local slot = self:GetID();
            ArmoryInventoryFramePasteItem(button, GetContainerItemLink(bag, slot));
        end
    );
    hooksecurefunc("ChatFrame_OnHyperlinkShow", 
        function(self, link, text, button)
            ArmoryInventoryFramePasteItem(button, link);
        end
    );
end

function ArmoryInventoryFrame_OnEvent(self, event, ...)
    local arg1 = ...;
    local update = true;

    -- make sure no Blizz id will match (e.g. -4 was introduced for tokens bag)
    if ( arg1 and arg1 <= ARMORY_MAIL_CONTAINER ) then
        arg1 = arg1 * 100;
    end

    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        if ( Armory.forceScan or not Armory:ContainerExists(BACKPACK_CONTAINER, "player") ) then
            Armory:Execute(ArmoryInventoryFrame_UpdateContainer, BACKPACK_CONTAINER);
        end
        for i = 1, NUM_BAG_SLOTS do
            if ( Armory.forceScan or not Armory:ContainerExists(i, "player") ) then
                Armory:Execute(ArmoryInventoryFrame_UpdateContainer, i);
            end
        end
        return;
    elseif ( event == "BAG_UPDATE" and arg1 >= BACKPACK_CONTAINER and arg1 <= NUM_BAG_SLOTS ) then
        if ( self.mailOpen ) then
            Armory:Execute(ArmoryInventoryFrame_UpdateContainer(ARMORY_MAIL_CONTAINER));
        end
        Armory:Execute(ArmoryInventoryFrame_UpdateContainer, arg1);
        Armory:Execute(ArmoryGearSets_Update);
    elseif ( event == "BAG_UPDATE" and self.bankOpen ) then
        -- Must execute immediately
        ArmoryInventoryFrame_UpdateContainer(arg1);
    elseif ( event == "PLAYERBANKSLOTS_CHANGED" and arg1 <= NUM_BANKGENERIC_SLOTS ) then
        -- Must execute immediately
        ArmoryInventoryFrame_UpdateContainer(BANK_CONTAINER);
    elseif ( event == "BANKFRAME_OPENED" ) then
        self.bankOpen = true;
        -- Must execute immediately
        ArmoryInventoryFrame_UpdateContainer(BANK_CONTAINER);
        for i = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
            ArmoryInventoryFrame_UpdateContainer(i);
        end
    elseif ( event == "BANKFRAME_CLOSED" ) then
        self.bankOpen = false;
        return;
    elseif ( event == "MAIL_SHOW" ) then
        self.mailOpen = true;
        return;
    elseif ( event == "MAIL_SEND_SUCCESS" ) then
        update = Armory:AddMail();
    elseif ( event == "MAIL_CLOSED" ) then
        if ( self.mailOpen ) then
            self.mailOpen = false;
            
            -- Must execute immediately
            ArmoryInventoryFrame_UpdateContainer(ARMORY_MAIL_CONTAINER);
            if ( Armory:GetConfigMailCheckCount() and Armory:GetConfigExpirationDays() > 0 and not Armory:GetConfigMailHideCount() ) then
                local count = Armory:GetNumRemainingMailItems("player");
                if ( count > 0 ) then
                    Armory:PrintWarning(format(ARMORY_MAIL_COUNT_WARNING1, count));
                    Armory:PlayWarningSound();
                end
            end
         end
    elseif ( event == "AUCTION_OWNED_LIST_UPDATE" ) then
        -- Must execute immediately
        if ( GetAuctionHouseDepositRate() > 5 ) then
            ArmoryInventoryFrame_UpdateContainer(ARMORY_NEUTRAL_AUCTIONS_CONTAINER);
        else
            ArmoryInventoryFrame_UpdateContainer(ARMORY_AUCTIONS_CONTAINER);
        end
    elseif ( event == "VOID_STORAGE_CLOSE" ) then
        Armory:Execute(ArmoryInventoryFrame_UpdateContainer, ARMORY_VOID_CONTAINER);
    end
    
    ArmoryInventoryFrame_UpdateFrame(update);
end

function ArmoryInventoryFrame_UpdateFrame(update)
    if ( update and ArmoryInventoryFrame:IsShown() ) then
        Armory:ExecuteDelayed(1.5, ArmoryInventoryFrame_Update);
    end
end

function ArmoryInventoryFrame_UpdateContainer(id)
    Armory:SetContainer(id);
    Armory:ResetTooltipHook();
    Armory:Execute(ArmoryInventoryFrame_UpdateTooltips);
end

function ArmoryInventoryFrame_UpdateTooltips()
    Armory:RefreshTooltip(ItemRefTooltip);
    if ( Armory.MIT_tooltips ) then
        for _, tooltip in ipairs(Armory.MIT_tooltips) do
             Armory:RefreshTooltip(tooltip);
        end
    end
    if ( Armory.LW_tooltips ) then
        for _, tooltip in ipairs(Armory.LW_tooltips) do
            if ( tooltip:NumLines() > 1 ) then
                Armory:RefreshTooltip(tooltip);
            end
        end
    end
end

function ArmoryInventoryFrameButton_OnClick(self)
    local id = self:GetID();
    if ( ArmoryInventoryListViewFrame:IsShown() ) then
        if ( self.isCollapsed ) then
            Armory:ExpandInventoryHeader(id);
        else
            Armory:CollapseInventoryHeader(id);
        end
    else
        if ( self.isCollapsed ) then
            Armory:ExpandContainer(id);
        else
            Armory:CollapseContainer(id);
        end
    end
    ArmoryInventoryFrame_Update();
end

function ArmoryInventoryFrame_OnShow(self)
    if ( Armory:GetInventoryItemNameFilter() == "" ) then
        ArmoryInventoryFrameEditBox:SetText(SEARCH);
    else
        ArmoryInventoryFrameEditBox:SetText(Armory:GetInventoryItemNameFilter());
    end
    if ( Armory:GetInventoryListViewMode() ) then
        PanelTemplates_SetTab(self, 2);
    else
        PanelTemplates_SetTab(self, 1);
    end
    ArmoryInventoryFrame_Update();
end

function ArmoryInventoryFrame_Update()
    if ( Armory:GetInventoryListViewMode() ) then
        ArmoryInventoryIconViewFrame:Hide();
        if ( ArmoryInventoryListViewFrame:IsShown() ) then
            ArmoryInventoryListViewFrame_Update();
        else
            ArmoryInventoryListViewFrame:Show();
        end
    else
        ArmoryInventoryListViewFrame:Hide();
        if ( ArmoryInventoryIconViewFrame:IsShown() ) then
            ArmoryInventoryIconViewFrame_Update();
        else
            ArmoryInventoryIconViewFrame:Show();
        end
    end    
end

function ArmoryInventoryFrameTab_OnClick(self)
    ArmoryCloseDropDownMenus();
    PanelTemplates_SetTab(ArmoryInventoryFrame, self:GetID());
    ArmoryInventoryFrameEnableListView(self:GetID() == 2);
end

function ArmoryInventoryFrameEnableListView(checked)
    Armory:SetInventoryListViewMode(checked);
    ArmoryInventoryFrame_Update();
end

function ArmoryInventoryMoneyFrame_OnShow(self)
    MoneyFrame_Update("ArmoryInventoryMoneyFrame", Armory:GetMoney());
end

function ArmoryInventoryMoneyFrame_OnEnter(self)
    local currentRealm, currentCharacter = Armory:GetPaperDollLastViewed();
    local currentFaction = Armory:UnitFactionGroup("player");
    local money = 0;
    for _, character in ipairs(Armory:CharacterList(currentRealm)) do
        Armory:LoadProfile(currentRealm, character);
        if ( Armory:UnitFactionGroup("player") == currentFaction ) then
            money = money + Armory:GetMoney();
        end
    end
    Armory:LoadProfile(currentRealm, currentCharacter);
    
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:AddLine(format(ARMORY_MONEY_TOTAL, currentRealm, currentFaction), "", 1, 1, 1);
    SetTooltipMoney(GameTooltip, money);
    if ( self.showTooltip and self.staticMoney ~= money ) then
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine(currentCharacter..":", "", 1, 1, 1);
        SetTooltipMoney(GameTooltip, self.staticMoney);
    end
    GameTooltip:Show();
end

function ArmoryInventoryMoneyFrame_OnLeave(self)
    GameTooltip:Hide();
end

function ArmoryInventoryFilter_OnTextChanged(self)
    local text = self:GetText();
    local refresh;

    if ( text == SEARCH ) then
        refresh = Armory:SetInventoryItemNameFilter("");
    elseif ( text ~= "=" ) then
        refresh = Armory:SetInventoryItemNameFilter(text);
    end
    if ( refresh ) then
        ArmoryInventoryFrame_Update();
    end
end

function ArmoryInventoryFilterDropDown_OnLoad(self)
    ArmoryItemFilter_InitializeDropDown(self);
end

function ArmoryInventoryFilterDropDown_OnShow(self)
    ArmoryItemFilter_SelectDropDown(self, ArmoryInventoryFrame_Update);
end

function ArmoryInventoryFramePasteItem(button, link)
    if ( not ArmoryInventoryFrameEditBox:IsVisible() ) then
        return;
    elseif ( button == "LeftButton" and IsAltKeyDown() ) then
        local itemName = GetItemInfo(link);
        if ( itemName ) then
            ArmoryInventoryFrameEditBox:SetText(itemName);
        end
    end
end
