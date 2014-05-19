--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 551 2012-11-11T13:24:10Z
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

ARMORY_MAX_CONTAINERS = 20;
ARMORY_MAX_CONTAINER_COLUMNS = 7;
ARMORY_MAX_CONTAINER_ITEMS = 80;
ARMORY_CONTAINER_OFFSET_X = 22;
ARMORY_CONTAINER_OFFSET_Y = -5;
ARMORY_CONTAINER_ROW_HEIGHT = 37;

ARMORY_VOID_CONTAINER_COLUMNS = 10;
ARMORY_VOID_CONTAINER_ROW_HEIGHT = 26;

function ArmoryInventoryIconViewFrame_OnLoad(self)
    ArmoryInventoryIconViewFrameScrollBarScrollDownButton:SetScript("OnClick", ArmoryInventoryIconViewFrameDownArrow_OnClick);
    ArmoryInventoryIconViewFrameScrollBar:SetValue(0);
    
    local numContainers = #ArmoryInventoryContainers;
    for i = 1, ARMORY_MAX_CONTAINERS do
        if ( i <= numContainers ) then
            _G["ArmoryInventoryContainer"..i.."Label"]:SetID(ArmoryInventoryContainers[i]);
            _G["ArmoryInventoryContainer"..i]:Show();
        else
            _G["ArmoryInventoryContainer"..i]:Hide();
        end
    end 
end

function ArmoryInventoryIconViewFrame_OnShow(self)
    ArmoryInventoryIconViewFrameLayoutCheckButton:SetChecked(Armory:GetInventoryBagLayout());
    ArmoryInventoryIconViewFrame_Update();
end

function ArmoryInventoryIconViewFrameDownArrow_OnClick(self)
    local parent = self:GetParent();
    parent:SetValue(parent:GetValue() + (parent:GetHeight() / 2));
end

function ArmoryInventoryContainerItemButton_OnEnter(self)
    local containerName = self:GetParent():GetName();
    local containerButton = _G[containerName.."Label"];
    local containerId = containerButton:GetID();
    local itemIndex = self:GetID();
    Armory:SetBagItem(containerId, itemIndex);
end

function ArmoryInventoryIconViewFrame_ShowContainer(containerFrame)
    local containerName = containerFrame:GetName();
    local label = _G[containerName.."Label"];
    local id = label:GetID();
    local containerTitle, numSlots, isCollapsed = Armory:GetInventoryContainerInfoEx(id);
    local columns, isPlusTwoBag;
    local buttonBaseName = containerName.."Item";
    local buttonTemplate = "ArmoryInventoryFrameItemButtonTemplate";
    local rowHeight = ARMORY_CONTAINER_ROW_HEIGHT;
    
    if ( Armory:GetInventoryBagLayout() and id >= BACKPACK_CONTAINER and id <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS ) then
        columns = NUM_CONTAINER_COLUMNS;
        isPlusTwoBag = (mod(numSlots, columns) == 2);
    elseif ( Armory:GetInventoryBagLayout() and id == ARMORY_VOID_CONTAINER ) then
        numSlots = ARMORY_VOID_STORAGE_MAX;
        columns = ARMORY_VOID_CONTAINER_COLUMNS;
        rowHeight = ARMORY_VOID_CONTAINER_ROW_HEIGHT;
        buttonBaseName = containerName.."VoidItem";
        buttonTemplate = "ArmoryInventoryFrameVoidItemButtonTemplate";
    else
        columns = ARMORY_MAX_CONTAINER_COLUMNS;
    end

  	if ( numSlots > ARMORY_MAX_CONTAINER_ITEMS ) then
		numSlots = ARMORY_MAX_CONTAINER_ITEMS;
		containerTitle = format("%s (%d+)", containerTitle, numSlots);
	end 

    label:SetText(containerTitle);

    if ( isCollapsed ) then
        label:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
    else
        label:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
    end
    label.isCollapsed = isCollapsed;

    local buttonName, itemButton, itemTexture;
    local rows = 0;
    local offset = 0;

    if ( isPlusTwoBag and not isCollapsed ) then
        for i = 1, 2 do
            itemButton = _G[buttonBaseName..i];
            if ( not itemButton ) then
                itemButton = CreateFrame("CheckButton", buttonBaseName..i, containerFrame, buttonTemplate);
            end
            if ( i == 1 ) then
                itemButton:SetPoint("TOPLEFT", containerName.."Label", "BOTTOMLEFT", ARMORY_CONTAINER_OFFSET_X, 0);
            else
                itemButton:SetPoint("TOPLEFT", buttonBaseName..(i - 1), "TOPRIGHT", 0, 0);
            end
            itemButton:Hide();
        end
        offset = 2;
        rows = 1;
    end
    
    local index, template;
    for i = 1, numSlots do
        index = offset + i;
        buttonName = buttonBaseName..index;
        itemButton = _G[buttonName];
        if ( not itemButton ) then
            itemButton = CreateFrame("CheckButton", buttonName, containerFrame, buttonTemplate);
        end
        itemButton:SetID(0);
        if ( not isCollapsed ) then
            -- Set first button
            if ( index == 1 ) then
                itemButton:SetPoint("TOPLEFT", containerName.."Label", "BOTTOMLEFT", ARMORY_CONTAINER_OFFSET_X, 0);
                rows = 1;
            else
                if ( mod((index - 1), columns) == 0 ) then
                    itemButton:SetPoint("TOPLEFT", buttonBaseName..(index - columns), "BOTTOMLEFT", 0, 0);
                    rows = rows + 1;
                else
                    itemButton:SetPoint("TOPLEFT", buttonBaseName..(index - 1), "TOPRIGHT", 0, 0);    
                end
            end

            itemButton.icon:SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled");
            itemButton.icon:SetTexCoord(0.140625, 0.84375, 0.140625, 0.84375);
            if ( buttonTemplate == "ArmoryInventoryFrameItemButtonTemplate" ) then
                SetItemButtonCount(itemButton, nil);
            end

            Armory:SetItemLink(itemButton, nil);
            itemButton.hasItem = nil;
            
            itemButton:Show();
        else
            itemButton:Hide();
        end
    end
   
    if ( id == ARMORY_VOID_CONTAINER ) then	
        -- Hide other button type
        for i = 1, ARMORY_MAX_CONTAINER_ITEMS do
            if ( Armory:GetInventoryBagLayout() ) then
                itemButton = _G[containerName.."Item"..i];
            else
                itemButton = _G[containerName.."VoidItem"..i];
            end
            if ( itemButton ) then
                itemButton:Hide();
            end
        end
    end

    for i = numSlots + 1, ARMORY_MAX_CONTAINER_ITEMS do
        index = offset + i;
        itemButton = _G[buttonBaseName..index];
        if ( itemButton ) then
            itemButton:Hide();
        end
    end
    
    if ( not isCollapsed ) then
        local texture, itemCount, quality, slotId;
        local name, link;
        for i = 1, numSlots do
            texture, itemCount, quality, _, _, _, slotId = Armory:GetInventoryContainerValue(id, i);
            if ( texture ) then
                if ( Armory:GetInventoryBagLayout() ) then
                    index = offset + (slotId or i);
                    if ( id == ARMORY_VOID_CONTAINER ) then
                        -- transpose
                        index = mod(index - 1, rows) * ARMORY_VOID_CONTAINER_COLUMNS + floor((index - 1) / rows) + 1;
                    end
                else
                    index = offset + i;
                end
                buttonName = buttonBaseName..index;
                
                itemButton = _G[buttonName];
                itemButton.icon:SetTexture(texture);
                itemButton.icon:SetTexCoord(0, 1, 0, 1);
                if ( itemCount and itemCount > 1 ) then
                    SetItemButtonCount(itemButton, itemCount);
                end
                
                link = Armory:GetContainerItemLink(id, i);
                name = Armory:GetNameFromLink(link);
                if ( not Armory:InventoryFilterActive() or (name and Armory:MatchInventoryItem(Armory:GetInventoryItemNameFilter(), name, link)) ) then
                    itemButton.searchOverlay:Hide();
                else
                    itemButton.searchOverlay:Show();
                end

                Armory:SetItemLink(itemButton, link);
                itemButton.hasItem = 1;
                itemButton:SetID(i);
            end
        end
    end
    
    containerFrame:SetHeight((rows * rowHeight) + label:GetHeight() - ARMORY_CONTAINER_OFFSET_Y);
    containerFrame:Show();
    ArmoryInventoryIconViewFrame_SetScroll();
end

function ArmoryInventoryIconViewFrame_CheckContainerSize(label, size)
	if ( size > ARMORY_MAX_CONTAINER_ITEMS ) then
		numSlots = ARMORY_MAX_CONTAINER_ITEMS;
		label = format("%s (%d+)", label, numSlots);
	end 
	return label, numSlots;
end

function ArmoryInventoryIconViewFrame_Update()
    local containerFrame, previousContainer, size, isCollapsed;

    ArmoryInventoryCollapseAllButton.isCollapsed = 1;
    ArmoryInventoryCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");

    for i = 1, #ArmoryInventoryContainers do
        containerFrame = _G["ArmoryInventoryContainer"..i];
        if ( containerFrame ) then
            _, size, isCollapsed = Armory:GetInventoryContainerInfo(ArmoryInventoryContainers[i]);

            if ( size and size > 0 ) then
                if ( not isCollapsed and ArmoryInventoryCollapseAllButton.isCollapsed ) then
                    ArmoryInventoryCollapseAllButton.isCollapsed = nil;
                    ArmoryInventoryCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
                end

                ArmoryInventoryIconViewFrame_ShowContainer(containerFrame);
                if ( previousContainer ) then
                    containerFrame:SetPoint("TOPLEFT", previousContainer, "BOTTOMLEFT", 0, 0);
                end
                previousContainer = containerFrame:GetName();
            else
                containerFrame:Hide();
            end
        end
    end
end

function ArmoryInventoryIconViewFrame_SetScroll()
    local frameHeight = ArmoryInventoryIconViewFrame:GetHeight();
    local containerFrame;

    for i = 1, #ArmoryInventoryContainers do
        containerFrame = _G["ArmoryInventoryContainer"..i];
        if ( containerFrame and containerFrame:IsShown() ) then
            frameHeight = frameHeight - containerFrame:GetHeight();
        end
    end

    -- Show or hide the scrollbar
    if ( frameHeight > 0 ) then
        ArmoryInventoryIconViewFrameScrollBar:Hide();
        ArmoryInventoryIconViewFrameScrollBarTop:Hide();
        ArmoryInventoryIconViewFrameScrollBarBottom:Hide();
    else
        ArmoryInventoryIconViewFrameScrollBar:Show();
        ArmoryInventoryIconViewFrameScrollBarTop:Show();
        ArmoryInventoryIconViewFrameScrollBarBottom:Show();
    end
end

function ArmoryInventoryIconViewBagLayout(checked)
    Armory:SetInventoryBagLayout(checked);
    ArmoryInventoryIconViewFrame_OnShow(ArmoryInventoryIconViewFrame);
end