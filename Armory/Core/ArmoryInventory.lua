--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 604 2013-12-08T18:35:45Z
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
local container = "Inventory";

local inventoryFilter = "";
local inventoryState = {};

local mailTo = "";
local mailItems = {};

----------------------------------------------------------
-- Inventory Internals
----------------------------------------------------------

local function InventoryContainerName(id)
    return "Container" .. id;
end

local function GetInventoryStateKey(line)
    local name, id, _, _, _, _, _, realm, character = unpack(line);
    if ( id ) then
        return (name or UNKNOWN)..(realm or "")..(character or "")..id;
    end
end

local inventoryLines = {};
local inventoryList = {};
local itemLines = {};
local dirty = true;
local owner = "";

local function GetInventoryLines()
    local id, header, group;
    local link, name, numSlots, itemCount, itemId, isCollapsed, containerName;
    local currentProfile = Armory:CurrentProfile();
    local numRealms = table.getn(Armory:RealmList());

    table.wipe(inventoryLines);
    table.wipe(inventoryList);

    if ( Armory.inventorySearchAll ) then
        for _, realm in ipairs(Armory:RealmList()) do
            for _, character in ipairs(Armory:CharacterList(realm)) do
                table.insert(inventoryList, {realm=realm, character=character});
            end
        end
    else
        table.insert(inventoryList, currentProfile);
    end

    for _, profile in ipairs(inventoryList) do
        Armory:SelectProfile(profile);

        if ( Armory.inventorySearchAll ) then
            if ( numRealms > 1 ) then
                group = {profile.character.." ("..profile.realm..")", nil, 0};
            else
                group = {profile.character, nil, 0};
            end
        end

        for i = 1, #ArmoryInventoryContainers do
            id = ArmoryInventoryContainers[i];
            name, numSlots, isCollapsed, containerName = Armory:GetInventoryContainerInfoEx(id);
            header = {name, id, numSlots, isCollapsed, true, nil, nil, profile.realm, profile.character, 0, containerName};
            if ( numSlots and numSlots > 0 ) then
                table.wipe(itemLines);
                for index = 1, numSlots do
                    link = Armory:GetContainerItemLink(id, index);
                    name = Armory:GetNameFromLink(link);
                    if ( name and Armory:MatchInventoryItem(inventoryFilter, name, link, true) ) then
                        _, itemCount = Armory:GetContainerItemInfo(id, index);
                        table.insert(itemLines, {name, id, itemCount, nil, nil, index, link, profile.realm, profile.character});
                    else
                        -- free slot
                        header[10] = header[10] + 1;
                    end
                end
                if ( #itemLines == 0 and not Armory:InventoryFilterActive() ) then
                    table.insert(itemLines, {EMPTY, id, 0, nil, nil, 0, nil, profile.realm, profile.character});
                end
                if ( #itemLines > 0 ) then
                    if ( group ) then
                        table.insert(inventoryLines, group);
                        group = nil;
                    end
                    table.insert(inventoryLines, header);
                    -- if inventory of all characters is viewed the states are kept in a separate state table
                    if ( Armory.inventorySearchAll ) then
                        isCollapsed = inventoryState[GetInventoryStateKey(header)];
                    end
                    if ( not isCollapsed ) then
                        table.sort(itemLines, function(a, b) return a[1] < b[1] end);
                        for _, v in ipairs(itemLines) do
                            table.insert(inventoryLines, v);
                        end
                    end
                end
            end
        end
    end

    Armory:SelectProfile(currentProfile);

    dirty = false;
    owner = Armory:SelectedCharacter();

    return inventoryLines;
end

local function UpdateContainerState(id, isCollapsed)
    local dbEntry = Armory.selectedDbBaseEntry;

    if ( dbEntry ) then
        if ( id == 9999 ) then
            for _, id in ipairs(ArmoryInventoryContainers) do
                UpdateContainerState(id, isCollapsed)
            end
        else
            local itemContainer = InventoryContainerName(id);
            if ( id == ARMORY_EQUIPMENT_CONTAINER or dbEntry:Contains(container, itemContainer) ) then
                Armory:SetHeaderLineState(container, itemContainer, isCollapsed);
            end
        end
    end
end

local function UpdateInventoryState(id, state)
    if ( not Armory.inventorySearchAll ) then
        if ( id == 9999 ) then
            for i = 1, #inventoryLines do
                UpdateInventoryState(i, state);
            end
        else
            local _, containerId, _, _, isHeader = Armory:GetInventoryLineInfo(id);
            if ( isHeader ) then
                UpdateContainerState(containerId, state);
            end
        end
    elseif ( id == 9999 ) then
        if ( state ) then
            for i = 1, #inventoryLines do
                UpdateInventoryState(i, state);
            end
        else
            table.wipe(inventoryState);
        end
    elseif ( id > 0 and id <= #inventoryLines ) then
        local key = GetInventoryStateKey(inventoryLines[id]);
        local isHeader = inventoryLines[id][5];
        if ( key ) then
            if ( state and isHeader ) then
                inventoryState[key] = 1;
            else
                inventoryState[key] = nil;
            end
        end
    end
end

local function ArtifactIsHeirloomColor()
    local _, _, _, artifactColor = GetItemQualityColor(6);
    local _, _, _, heirloomColor = GetItemQualityColor(7);
    return (artifactColor == heirloomColor);
end

----------------------------------------------------------
-- Inventory Caching
----------------------------------------------------------

local function SetItemCache(itemContainer, link, count, unit)
    if ( Armory:GetConfigShowItemCount() and not Armory:GetConfigUseEncoding() ) then
        local dbEntry = Armory.selectedDbBaseEntry;
        if ( unit == "player" ) then
            dbEntry = Armory.playerDbBaseEntry;
        end
        
        local itemId = Armory:GetUniqueItemId(link);
        if ( dbEntry and itemId ) then
            if ( dbEntry:Contains(container, itemContainer, ARMORY_CACHE_CONTAINER, itemId) ) then
                local cache = dbEntry:GetValue(container, itemContainer, ARMORY_CACHE_CONTAINER);
                cache[itemId] = cache[itemId] + count;
            else
                dbEntry:SetValue(4, container, itemContainer, ARMORY_CACHE_CONTAINER, itemId, count);
            end
        end
    end
end

local function GetCachedItemCount(itemContainer, itemString)
    local dbEntry = Armory.selectedDbBaseEntry;
    if ( dbEntry and itemString ) then
        local itemId = Armory:GetUniqueItemId("item:"..itemString);
        return dbEntry:GetValue(container, itemContainer, ARMORY_CACHE_CONTAINER, itemId) or 0;
    end
    return 0;
end

local function ClearItemCache(itemContainer, unit)
    local dbEntry = Armory.selectedDbBaseEntry;
    if ( unit == "player" ) then
        dbEntry = Armory.playerDbBaseEntry;
    end
    if ( dbEntry ) then
        dbEntry:SetValue(3, container, itemContainer, ARMORY_CACHE_CONTAINER, nil);
    end
end

local function ItemCacheExists(itemContainer)
    local dbEntry = Armory.selectedDbBaseEntry;
    return dbEntry and dbEntry:Contains(container, itemContainer, ARMORY_CACHE_CONTAINER);
end

----------------------------------------------------------
-- Inventory Storage
----------------------------------------------------------

local function SetInventoryValue(dbEntry, itemContainer, index, texture, count, quality, link, expires, equipable, slotId, ignorable, tinker, anchor, timestamp)
    dbEntry:SetValue(3, container, itemContainer, index, texture, count, quality, link, expires, equipable, slotId, ignorable, tinker, anchor, timestamp);
end

local function GetInventoryValue(dbEntry, itemContainer, index)
    return dbEntry:GetValue(container, itemContainer, index);
end

local function ClearInventoryValue(dbEntry, itemContainer, index)
    dbEntry:SetValue(3, container, itemContainer, index, nil);
end

local function SetContainerInfo(dbEntry, itemContainer, name, numSlots, bagSlots, remaining, timestamp)
    dbEntry:SetValue(3, container, itemContainer, "Info", name, numSlots, bagSlots, remaining, timestamp or time());
end

local function GetContainerInfo(dbEntry, itemContainer)
    return dbEntry:GetValue(container, itemContainer, "Info");
end

local function SetSlotInfo(id, index, texture, count, quality, link, expires, equipable, slotId, ignorable)
    local dbEntry = Armory.playerDbBaseEntry;
    local itemContainer = InventoryContainerName(id);
    if ( not dbEntry ) then
        return;
    end
    
    local tinker, anchor;
    if ( link and id >= BANK_CONTAINER and id <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS and IsEquippableItem(link) ) then
        local tooltip1 = Armory:AllocateTooltip();
        local tooltip2 = Armory:AllocateTooltip();
        if ( id == BANK_CONTAINER ) then
            tooltip1:SetInventoryItem("player", BANK_CONTAINER_INVENTORY_OFFSET + slotId);
        else
            tooltip1:SetBagItem(id, slotId);
        end
        tooltip2:SetHyperlink(link);
        tinker, anchor = Armory:GetTinkerFromTooltip(tooltip1, tooltip2);
        Armory:ReleaseTooltip(tooltip2);
        Armory:ReleaseTooltip(tooltip1);
    end

    SetInventoryValue(dbEntry, itemContainer, index, texture, count, quality, link, expires, equipable, slotId, ignorable, tinker, anchor);
end

local function ClearSlotInfo(itemContainer, index)
    local dbEntry = Armory.playerDbBaseEntry;
    if ( dbEntry ) then
        ClearInventoryValue(dbEntry, itemContainer, index);
    end
end

function Armory:ContainerExists(id, unit)
    local dbEntry = self.selectedDbBaseEntry;
    if ( unit == "player" ) then
        dbEntry = self.playerDbBaseEntry;
    end
    
    local itemContainer = InventoryContainerName(id);
    if ( dbEntry ) then
        return dbEntry:Contains(container, itemContainer);
    end
end

function Armory:ClearInventory()
    self:ClearModuleData(container);
    dirty = true;
end

function Armory:SetContainer(id)
    local itemContainer = InventoryContainerName(id);
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end
    
    -- Make sure money gets updated
    self:GetMoney();

    dirty = dirty or self:IsPlayerSelected();

    if ( not self:HasInventory() ) then
        dbEntry:SetValue(container, nil);
        return;
    end
    
    -- signal some update triggers
    local name, numSlots = self:GetInventoryContainerInfo(id, "player");
    local link, texture;
    if ( id > BACKPACK_CONTAINER and id <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS ) then
        -- if stored within container, see below
        local bagSlot = _G.ContainerIDToInventoryID(id);
        link = self:GetInventoryItemLink("player", bagSlot);
        texture = self:GetInventoryItemTexture("player", bagSlot);
    end
    
    if ( not self:IsLocked(itemContainer) ) then
        self:Lock(itemContainer);

        self:PrintDebug("UPDATE", itemContainer);

        local _, oldNum = GetContainerInfo(dbEntry, itemContainer);
        
        local daysLeft, timeLeft, count, quality, remaining;
        local nextSlot = 1;

        ClearItemCache(itemContainer, "player");
        
        if ( id == ARMORY_MAIL_CONTAINER ) then
            local sender, itemCount;
            numSlots, count = _G.GetInboxNumItems();
            if ( count > numSlots ) then
                remaining = count - numSlots;
            end

            local warned;
            for index = 1, numSlots do
                _, _, sender, _, _, _, daysLeft, itemCount = _G.GetInboxHeaderInfo(index);
                if ( itemCount ) then
                    local ignorable;
                    if ( not sender ) then
                        if ( not warned ) then
                            self:PrintWarning(ARMORY_MAIL_COUNT_WARNING3);
                            warned = true;
                        end
                    elseif ( not _G.InboxItemCanDelete(index) ) then
                        -- original message from player (can be cross faction for account bound items)
                        for _, profile in ipairs(self:Profiles()) do
                            if ( self:IsMyMail(sender, profile) ) then
                                ignorable = true;
                                break;
                            end
                        end
                    end
                    for i = 1, ATTACHMENTS_MAX_RECEIVE do
                        _, texture, count, quality = _G.GetInboxItem(index, i);
                        if ( texture ) then
                            link = _G.GetInboxItemLink(index, i);
                            SetSlotInfo(id, nextSlot, texture, count, quality, link, daysLeft, self:CanEquip(link), nil, ignorable);
                            SetItemCache(itemContainer, link, count, "player");
                            nextSlot = nextSlot + 1;
                        end
                    end
                end
            end
            
            if ( warned ) then
                self:PlayWarningSound();
            end

        elseif ( id == ARMORY_AUCTIONS_CONTAINER or id == ARMORY_NEUTRAL_AUCTIONS_CONTAINER ) then
            local saleStatus;
            for i = 1, _G.GetNumAuctionItems("owner") do
                _, texture, count, quality, _, _, _, _, _, _, _, _, _, _, _, saleStatus = _G.GetAuctionItemInfo("owner", i);
                if ( texture and saleStatus ~= 1 ) then
                    link = _G.GetAuctionItemLink("owner", i);
                    timeLeft = _G.GetAuctionItemTimeLeft("owner", i);
                    SetSlotInfo(id, nextSlot, texture, count, quality, link, timeLeft);
                    SetItemCache(itemContainer, link, count, "player");
                    nextSlot = nextSlot + 1;
                end
            end

        elseif ( id == ARMORY_VOID_CONTAINER ) then
            local itemID;
            for i = 1, ARMORY_VOID_STORAGE_MAX do
                itemID, texture = _G.GetVoidItemInfo(i);
                if ( texture ) then
		            _, link, quality = _G.GetItemInfo(itemID);
                    SetSlotInfo(id, nextSlot, texture, 1, quality, link, nil, self:CanEquip(link), i);
                    nextSlot = nextSlot + 1;
                end
            end
            
        else
            for i = 1, _G.GetContainerNumSlots(id) do
                texture, count, _, quality = _G.GetContainerItemInfo(id, i);
                if ( texture ) then
                    link = _G.GetContainerItemLink(id, i);
                    SetSlotInfo(id, nextSlot, texture, count, quality, link, nil, self:CanEquip(link), i);
                    SetItemCache(itemContainer, link, count, "player");
                    nextSlot = nextSlot + 1;
                end
            end
            
        end
        
        for index = nextSlot, (oldNum or 0) do 
            ClearSlotInfo(itemContainer, index);
        end

        local bagSlots;
        if ( id == BANK_CONTAINER ) then
            numSlots = NUM_BANKGENERIC_SLOTS;
            bagSlots, remaining = _G.GetNumBankSlots();
        elseif ( id > ARMORY_MAIL_CONTAINER ) then
            numSlots = _G.GetContainerNumSlots(id);
            name = _G.GetBagName(id);
        else
            numSlots = nextSlot - 1;
        end
        
        --link = nil;
        --texture = nil;
        --if ( id > BACKPACK_CONTAINER and id <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS ) then
            --local bagSlot = _G.ContainerIDToInventoryID(id);
            --link = _G.GetInventoryItemLink("player", bagSlot);
            --texture = _G.GetInventoryItemTexture("player", bagSlot);
        --end
        
        --SetContainerInfo(dbEntry, itemContainer, name, numSlots, bagSlots, remaining, time(), link, texture);
        
        SetContainerInfo(dbEntry, itemContainer, name, numSlots, bagSlots, remaining, time());

        self:Unlock(itemContainer);
    else
        self:PrintDebug("LOCKED", itemContainer);
    end
end

function Armory:SetMailSent(name)
    mailTo = strtrim(name);
    table.wipe(mailItems);
    
    local link, texture, count, quality;
    local tooltip;
    for i = 1, ATTACHMENTS_MAX_SEND do
        _, texture, count, quality = _G.GetSendMailItem(i);
        if ( texture ) then
            tooltip = Armory:AllocateTooltip();
            tooltip:SetSendMailItem(i);
            _, link = tooltip:GetItem();
            Armory:ReleaseTooltip(tooltip);

            local itemInfo = {};
            itemInfo.Texture = texture;
            itemInfo.Count = count;
            itemInfo.Quality = quality;
            itemInfo.Link = link;
            itemInfo.Ignorable = true;
            table.insert(mailItems, itemInfo);
        end
    end
end

function Armory:SetMailReturned(id)
	local _, _, sender, _, _, _, _, itemCount = _G.GetInboxHeaderInfo(id);

    mailTo = sender or "";
    table.wipe(mailItems);

    local texture, count, quality;
    if ( itemCount ) then
        for i = 1, ATTACHMENTS_MAX_RECEIVE do
            _, texture, count, quality = _G.GetInboxItem(id, i);
            if ( texture ) then
                local itemInfo = {};
                itemInfo.Texture = texture;
                itemInfo.Count = count;
                itemInfo.Quality = quality;
                itemInfo.Link = _G.GetInboxItemLink(id, i);
                table.insert(mailItems, itemInfo);
            end
        end
        ArmoryInventoryFrame_UpdateFrame(Armory:AddMail()); 
    end
end

function Armory:IsMyMail(address, profile)
	local character, realm;
	local pos = address:find("%-");
	if ( pos ) then
		character = address:sub(1, pos - 1);
		realm = self:GetPostalRealmName(address:sub(pos + 1));
	else
		character = address;
		realm = self.playerRealm;
	end
	return strlower(profile.realm .. profile.character) == strlower(realm .. character);
end

function Armory:AddMail()
    local id = ARMORY_MAIL_CONTAINER;
    local numItems = #mailItems;

    if ( self:HasInventory() and mailTo ~= "" and numItems > 0 ) then
        local currentProfile = self:CurrentProfile();
        local itemContainer = InventoryContainerName(id);
        local dbEntry, name, numSlots, bagSlots, remaining, timestamp, index, itemInfo;
        for _, profile in ipairs(self:Profiles()) do
            -- mail can be cross faction (account bound items)
            if ( self:IsMyMail(mailTo, profile) ) then
                self:SelectProfile(profile);

                dbEntry = self.selectedDbBaseEntry;
                name, numSlots, bagSlots, remaining, timestamp = GetContainerInfo(dbEntry, itemContainer);
                index = (numSlots or 0);
                
                SetContainerInfo(dbEntry, itemContainer, name, index + numItems, bagSlots, remaining, timestamp);
 
                for i = 1, numItems do
                    itemInfo = mailItems[i];
                    index = index + 1;

                    SetInventoryValue(dbEntry, itemContainer, index, itemInfo.Texture, itemInfo.Count, itemInfo.Quality, itemInfo.Link, 30, self:CanEquip(itemInfo.Link), nil, itemInfo.Ignorable, _, _, time());

                    SetItemCache(itemContainer, itemInfo.Link, itemInfo.Count);
                end
                
                dirty = dirty or self:IsPlayerSelected();
                break;
            end
        end
        self:SelectProfile(currentProfile);
    end
    
    mailTo = "";
        
    return dirty;
end

function Armory:UpdateInventoryEquippable()
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end
    
    local id, itemContainer, numSlots;
    local texture, count, quality, link, expires, equipable, slotId, ignorable, tinker, anchor, timestamp;
    for i = 1, #ArmoryInventoryContainers do
        id = ArmoryInventoryContainers[i];
        if ( id > ARMORY_AUCTIONS_CONTAINER ) then
            itemContainer = InventoryContainerName(id);
            if ( not self:IsLocked(itemContainer) ) then
                self:Lock(itemContainer);

                self:PrintDebug("UPDATE (equip)", itemContainer);
                
                _, numSlots = GetContainerInfo(dbEntry, itemContainer);
                if ( numSlots ) then
                    for index = 1, numSlots do
                        texture, count, quality, link, expires, equipable, slotId, ignorable, tinker, anchor, timestamp = GetInventoryValue(dbEntry, itemContainer, index);
                        if ( not equipable and link ) then
                            equipable = self:CanEquip(link);
                            SetInventoryValue(dbEntry, itemContainer, index, texture, count, quality, link, expires, equipable, slotId, ignorable, tinker, anchor, timestamp);
                        end
                    end
                end
                
                self:Unlock(itemContainer);
            else
                self:PrintDebug("LOCKED (equip)", itemContainer);
            end
        end
    end
end

local auctionItems = {};
function Armory:RemoveOldAuctions()
    if ( self:HasInventory() ) then
        local currentProfile = self:CurrentProfile();
        local name, numSlots, bagSlots, remaining, timestamp;

        for _, profile in ipairs(self:Profiles()) do
            self:SelectProfile(profile);
            mailTo = profile.character;
            table.wipe(mailItems);

            for _, id in ipairs( { ARMORY_AUCTIONS_CONTAINER, ARMORY_NEUTRAL_AUCTIONS_CONTAINER } ) do
                local dbEntry = self.selectedDbBaseEntry;
                local itemContainer = InventoryContainerName(id);

                name, numSlots, bagSlots, remaining, timestamp = GetContainerInfo(dbEntry, itemContainer);
                if ( numSlots and numSlots > 0 ) then
                    table.wipe(auctionItems);
                    for i = 1, numSlots do
                        local itemInfo = {};
                        itemInfo.Texture, itemInfo.Count, itemInfo.Quality, itemInfo.Link, itemInfo.Expires, _, _, _, _, _, itemInfo.timestamp = GetInventoryValue(dbEntry, itemContainer, i);
                        if ( time() - (itemInfo.timestamp or timestamp or time()) <= 48 * 60 * 60 ) then
                            table.insert(auctionItems, itemInfo);
                        else
                            table.insert(mailItems, itemInfo);
                        end
                    end
                    
                    local newNum = #auctionItems;
                    if ( newNum ~= numSlots ) then
                        ClearItemCache(itemContainer);
                        
                        SetContainerInfo(dbEntry, itemContainer, name, newNum, bagSlots, remaining, timestamp);
                        for i = 1, max(newNum, numSlots) do
                            if ( i > newNum ) then
                                ClearInventoryValue(dbEntry, itemContainer, i);
                            else
                                local itemInfo = auctionItems[i];
                                SetInventoryValue(dbEntry, itemContainer, i, itemInfo.Texture, itemInfo.Count, itemInfo.Quality, itemInfo.Link, itemInfo.Expires, nil, nil, nil, nil, nil, itemInfo.timestamp);
                                SetItemCache(itemContainer, itemInfo.Link, itemInfo.Count);
                            end
                        end
                    end
                end
            end
            self:AddMail();
            self:SelectProfile(currentProfile);
        end
    end
end

----------------------------------------------------------
-- Inventory Hooks
----------------------------------------------------------

local Orig_SendMail = SendMail;
function SendMail(name, ...)
    pcall(Armory.SetMailSent, Armory, name);
    return Orig_SendMail(name, ...);
end

local Orig_ReturnInboxItem = ReturnInboxItem;
function ReturnInboxItem(id, ...) 
    pcall(Armory.SetMailReturned, Armory, id); 
    return Orig_ReturnInboxItem(id, ...);
end

----------------------------------------------------------
-- Inventory Interface
----------------------------------------------------------

function Armory:GetInventoryContainerInfo(id, unit)
    local dbEntry = self.selectedDbBaseEntry;
    if ( unit and unit == "player" ) then
        dbEntry = self.playerDbBaseEntry;
    end

    local itemContainer = InventoryContainerName(id);
    local isCollapsed = self:GetHeaderLineState(container, itemContainer);
    local name, numSlots, timestamp;
    if ( id == ARMORY_EQUIPMENT_CONTAINER ) then
        name = ARMORY_EQUIPMENT;
        numSlots = EQUIPPED_LAST;
    elseif ( dbEntry ) then
        name, numSlots, _, _, timestamp = GetContainerInfo(dbEntry, itemContainer);
    end

    return name, numSlots or 0, isCollapsed, timestamp or time();
end

function Armory:GetInventoryContainerInfoEx(id, unit)
    local containerName, numSlots, isCollapsed = self:GetInventoryContainerInfo(id, unit);
    local name;

    if ( id == BANK_CONTAINER ) then
        name = ARMORY_BANK_CONTAINER_NAME;
    elseif ( id == ARMORY_MAIL_CONTAINER ) then
        name = INBOX;
    elseif ( id == ARMORY_AUCTIONS_CONTAINER ) then
        name = AUCTIONS;
    elseif ( id == ARMORY_NEUTRAL_AUCTIONS_CONTAINER ) then
        name = format(COLORBLIND_NAMEWRAPPER_NEUTRAL, AUCTIONS);
    elseif ( id == ARMORY_EQUIPMENT_CONTAINER ) then
        name = ARMORY_EQUIPPED;
    elseif ( id == ARMORY_VOID_CONTAINER ) then
        name = VOID_STORAGE;
    elseif ( containerName ) then
        local prefix = "";
        if ( id > NUM_BAG_SLOTS ) then
            prefix = ARMORY_BANK_CONTAINER_NAME.." #"..(id - NUM_BAG_SLOTS).." - ";
        elseif ( id > 0 ) then
            prefix = "#"..id.." - ";
        end
        name = prefix..format(CONTAINER_SLOTS, numSlots, containerName);
    else
		name = UNKNOWN;
    end

    return name, numSlots, isCollapsed, containerName;
end

function Armory:GetInventoryContainerValue(id, index, unit)
    local dbEntry = self.selectedDbBaseEntry;
    if ( unit and unit == "player" ) then
        dbEntry = self.playerDbBaseEntry;
    end
    
    if ( dbEntry ) then
        local itemContainer = InventoryContainerName(id);
        if ( id == ARMORY_EQUIPMENT_CONTAINER ) then
            local texture = dbEntry:GetValue("InventoryItemTexture"..index);
            local quality = dbEntry:GetValue("InventoryItemQuality"..index);
            local link = dbEntry:GetValue("InventoryItemLink"..index);
            return texture, 1, quality, link;
        elseif ( type(index) == "number" ) then
            return GetInventoryValue(dbEntry, itemContainer, index);
        else
            return GetContainerInfo(dbEntry, itemContainer);
        end
    end
end

function Armory:GetBagName(id)
    return ( self:GetInventoryContainerInfo(id) );
end

function Armory:GetNumBankSlots()
   local _, _, numSlots, full = self:GetInventoryContainerValue(BANK_CONTAINER);
   return numSlots, full;
end

function Armory:GetNumRemainingMailItems(unit)
    local _, _, _, remaining = self:GetInventoryContainerValue(ARMORY_MAIL_CONTAINER, nil, unit);
    return remaining or 0;
end

function Armory:GetContainerNumSlots(id)
    local _, numSlots = self:GetInventoryContainerInfo(id);
    return numSlots or 0;
end

function Armory:GetContainerItemInfo(id, index)
    -- GetContainerItemInfo returns: texture, itemCount, locked, quality, readable
    local texture, count, quality = self:GetInventoryContainerValue(id, index);
    return texture, count, nil, quality, nil;
end

function Armory:GetContainerItemLink(id, index)
    local _, _, _, link, _, _, _, _, tinker, anchor = self:GetInventoryContainerValue(id, index);
    return link, tinker, anchor;
end

function Armory:GetContainerItemExpiration(id, index)
    local dbEntry = self.selectedDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end
    
    local itemContainer = InventoryContainerName(id);
    local _, _, _, _, expires, _, _, ignorable, _, _, timestamp = GetInventoryValue(dbEntry, itemContainer, index);
    if ( not timestamp ) then
        _, _, _, _, timestamp = GetContainerInfo(dbEntry, itemContainer);
    end
    local remaining = time() - timestamp;
    if ( id == ARMORY_MAIL_CONTAINER and expires ) then
        expires = expires - remaining / (24 * 60 * 60);
    end
    return expires, ignorable, remaining;
end

function Armory:GetContainerItemCanEquip(id, index)
    local _, _, _, _, _, _, equipable = self:GetInventoryContainerValue(id, index);
    return equipable;
end

function Armory:GetNumInventoryLines()
    if ( ArmoryItemFilter_IsUpdated() or dirty or not self:IsSelectedCharacter(owner) ) then
        GetInventoryLines();
    end
    return #inventoryLines;
end

function Armory:GetInventoryLineInfo(index)
    local numLines = self:GetNumInventoryLines();
    if ( index > 0 and index <= numLines ) then
        return unpack(inventoryLines[index]);
    end
end

function Armory:GetInventoryLineState(id)
    local isCollapsed;
    if ( self.inventorySearchAll ) then
        local key = GetInventoryStateKey(inventoryLines[id]);
        if ( key ) then
            isCollapsed = inventoryState[key];
        end
    else
        _, _, _, isCollapsed = Armory:GetInventoryLineInfo(id);
    end
    return isCollapsed;
end

function Armory:ExpandContainer(id)
    UpdateContainerState(id, false);
    dirty = true;
end

function Armory:CollapseContainer(id)
    UpdateContainerState(id, true);
    dirty = true;
end

function Armory:ExpandInventoryHeader(id)
    UpdateInventoryState(id, false);
    dirty = true;
end

function Armory:CollapseInventoryHeader(id)
    UpdateInventoryState(id, true);
    dirty = true;
end

function Armory:InventoryFilterActive()
    return (inventoryFilter ~= "" or ArmoryItemFilter_IsEnabled());
end

function Armory:MatchInventoryItem(filter, name, link, emptyMatch)
    local match;
    
    if ( filter == "" ) then
        match = ArmoryItemFilter(link);
        if ( not emptyMatch ) then
            match = match and ArmoryItemFilter_IsEnabled();
        end
    else
        if ( string.match(filter, "^=%d$") ) then
            local quality = tonumber(strsub(filter, 2));
            local _, _, itemRarity = GetItemInfo(link);
            if ( itemRarity ) then
                match = (itemRarity == quality);
            elseif ( quality == 7 and ArtifactIsHeirloomColor() ) then
                match = (self:GetQualityFromLink(link) == 6);
            else
                match = (self:GetQualityFromLink(link) == quality);
            end
        else
            match = string.find(strlower(name), strlower(filter), 1, true);
        end
        match = match and ArmoryItemFilter(link);
    end
    return match;
end

function Armory:NormalizeInventoryFilterText(text)
    if ( strsub(text, 1, 1) == "=" ) then
        text = strlower(strsub(text, 2));
        if ( not tonumber(text) ) then
            for i = 0, 7 do
                if ( text == strlower(_G["ITEM_QUALITY"..i.."_DESC"]) ) then
                    text = tostring(i);
                    break;
                end
            end
        end
        if ( not text:match("[0-7]") ) then
            return;
        end
        text = "="..text;
    end
    return text;
end

function Armory:SetInventoryItemNameFilter(text)
    local refresh;
    text = self:NormalizeInventoryFilterText(text);
    if ( text ) then
        refresh = (inventoryFilter ~= text);
        inventoryFilter = text;
        if ( refresh ) then
            dirty = true;
            table.wipe(inventoryState);
        end
    end
    return refresh;
end

function Armory:GetInventoryItemNameFilter()
    return inventoryFilter;
end

function Armory:SetInventorySearchAllFilter(searchAll)
    local refresh = (self.inventorySearchAll ~= searchAll);
    self.inventorySearchAll = searchAll;
    if ( refresh ) then
        dirty = true;
        table.wipe(inventoryState);
    end
    return refresh;
end

function Armory:GetInventorySearchAllFilter()
    return self.inventorySearchAll;
end

local scanItem = {};
function Armory:ScanInventory(link, bagsOnly)
    local count, bagCount, bankCount, mailCount, auctionCount, voidCount = 0, 0, 0, 0, 0, 0;
    local perSlotCount, result;
    if ( link ) then
        scanItem[1] = link;
        result = self:ScanInventoryItems(scanItem, bagsOnly)[1];
        count = result.count;
        bagCount = result.bags;
        bankCount = result.bank;
        mailCount = result.mail;
        auctionCount = result.auction;
        voidCount = result.void;
        perSlotCount = result.perSlot;
    end
    return count, bagCount, bankCount, mailCount, auctionCount, voidCount, perSlotCount;
end

local scanResult = {};
function Armory:ScanInventoryItems(items, bagsOnly)
    local result = scanResult;
    local id, itemCount, name, link, itemString;
    local itemContainer;
    local buildCache;
    
    local saveResult = function(result, id, count)
        if ( count == 0 ) then
            return;
        
        elseif ( self:GetConfigShowItemCountPerSlot() ) then
            if ( not result.perSlot ) then
                result.perSlot = {
                    bags = {},
                    bank = {}
                };
            end
            local perSlot, where;
            if ( id >= BACKPACK_CONTAINER and id <= NUM_BAG_SLOTS ) then
                perSlot = result.perSlot.bags;
                where = tostring(id);
            elseif ( id == BANK_CONTAINER ) then
                perSlot = result.perSlot.bank;
                where = "0";
            elseif ( id > NUM_BAG_SLOTS and id <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS ) then
                perSlot = result.perSlot.bank;
                where = tostring(id - NUM_BAG_SLOTS);
            end
            if ( perSlot ) then
                perSlot[where] = (perSlot[where] or 0) + count;
            end
        end

        if ( id == ARMORY_MAIL_CONTAINER ) then
            result.mail = result.mail + count;
        elseif ( id >= BACKPACK_CONTAINER and id <= NUM_BAG_SLOTS ) then
            result.bags = result.bags + count;
        elseif ( id == BANK_CONTAINER or (id > NUM_BAG_SLOTS and id <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) ) then
            result.bank = result.bank + count;
        elseif ( id == ARMORY_AUCTIONS_CONTAINER or id == ARMORY_NEUTRAL_AUCTIONS_CONTAINER ) then
            result.auction = result.auction + count;
        elseif ( id == ARMORY_VOID_CONTAINER ) then
            result.void = result.void + count;
        end
        result.count = result.count + count;
    end; 

    table.wipe(result);
    
    for k, item in ipairs(items) do
        if ( type(item) == "table" ) then
            name = unpack(item);
            itemString = self:GetCachedItemString(name);
        elseif ( item:find("|H") ) then
            name = self:GetNameFromLink(item);
            itemString = self:GetItemString(item);
            self:CheckUnknownCacheItems(name, itemString);
        else
            name = item;
            itemString = self:GetCachedItemString(name);
        end
        result[k] = { name=name or UNKNOWN, item=itemString, count=0, bags=0, bank=0, mail=0, auction=0, void=0 };

        for i = 1, #ArmoryInventoryContainers do
            id = ArmoryInventoryContainers[i];
            if ( (bagsOnly and id >= BACKPACK_CONTAINER and id <= NUM_BAG_SLOTS) or (not bagsOnly and not self:IsDummyContainer(id)) ) then 
                itemContainer = InventoryContainerName(id);
                if ( result[k].item and ItemCacheExists(itemContainer) ) then
                    itemCount = GetCachedItemCount(itemContainer, result[k].item);
                    saveResult(result[k], id, itemCount);
                else
                    buildCache = not ItemCacheExists(itemContainer);
                    for index = 1, self:GetContainerNumSlots(id) do
                        link = self:GetContainerItemLink(id, index);
                        name = self:GetNameFromLink(link);
                        _, itemCount = self:GetContainerItemInfo(id, index);
                        if ( name and itemCount ) then
                            if ( buildCache ) then
                                SetItemCache(itemContainer, link, itemCount);
                            end
                            if ( strtrim(name) == strtrim(result[k].name) ) then
                                saveResult(result[k], id, itemCount);
                                if ( not result[k].item ) then
                                    result[k].item = self:SetCachedItemString(name, link);
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return result;
end

function Armory:GetEquipCount(link)
    local itemId = self:GetUniqueItemId(link);
    local count = 0;
    
    for slot = EQUIPPED_FIRST, EQUIPPED_LAST do 
        link = self:GetInventoryItemLink("player", slot);
        if ( self:GetUniqueItemId(link) == itemId ) then
            count = count + 1;
        end
    end
    
    return count;
end

function Armory:IsDummyContainer(id)
    return id == ARMORY_EQUIPMENT_CONTAINER;
end

----------------------------------------------------------
-- Find Methods
----------------------------------------------------------

function Armory:FindInventory(...)
    local currentProfile = self:CurrentProfile();
    local id, numSlots, link, tinker, anchor, name, itemId, text, itemCount;
    local list = {};
    local items = {};
    
    for _, profile in ipairs(self:Profiles()) do
        if ( self:GetConfigGlobalSearch() or self:IsConnectedRealm(profile.realm) ) then
            self:SelectProfile(profile);

            for i = 1, #ArmoryInventoryContainers do
                id = ArmoryInventoryContainers[i];
                _, numSlots = self:GetInventoryContainerInfoEx(id);
                if ( (numSlots or 0) > 0 ) then
                    for index = 1, numSlots do
                        link, tinker, anchor = self:GetContainerItemLink(id, index);
                        itemId = self:GetUniqueItemId(link);
                        if ( self:GetConfigExtendedSearch() ) then
                            text = self:GetTextFromLink(link, tinker);
                        else
                            text = self:GetNameFromLink(link);
                        end
                        if ( itemId and self:FindTextParts(text, ...) ) then
                            _, itemCount = self:GetContainerItemInfo(id, index);
                            if ( items[itemId] ) then
                                items[itemId].count = items[itemId].count + itemCount;
                            else
                                items[itemId] = {link=link, tinker=tinker, anchor=anchor, count=itemCount, bags=0, bank=0, mail=0, alts=0, equipped=0, void=0};
                            end
                            if ( self:IsPlayerSelected() ) then
                                if ( id == ARMORY_MAIL_CONTAINER ) then
                                    items[itemId].mail = items[itemId].mail + itemCount;
                                elseif ( id >= BACKPACK_CONTAINER and id <= NUM_BAG_SLOTS ) then
                                    items[itemId].bags = items[itemId].bags + itemCount;
                                elseif ( id == BANK_CONTAINER or (id > NUM_BAG_SLOTS and id <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) ) then
                                    items[itemId].bank = items[itemId].bank + itemCount;
                                elseif ( id == ARMORY_EQUIPMENT_CONTAINER ) then
                                    items[itemId].equipped = items[itemId].equipped + itemCount;
                                elseif ( id == ARMORY_VOID_CONTAINER ) then
                                    items[itemId].void = items[itemId].void + itemCount;
                                end
                            else
                                items[itemId].alts = items[itemId].alts + itemCount;
                            end
                        end
                    end
                end
            end
        end
        self:SelectProfile(currentProfile);
    end

    local name;
    for _, info in pairs(items) do
        text = self:GetCountDetails(info.bags, info.bank, info.mail, nil, info.alts, nil, info.equipped, info.void);
        name = self:GetNameFromLink(info.link);
        table.insert(list, {label="", name=name, extra=text, link=info.link, tinker=info.tinker, anchor=info.anchor, count=info.count});
    end
    sort(list, function(a, b) return a.name < b.name; end);

    for _, line in ipairs(list) do
        self:PrintSearchResult("", line);
    end

    return #list;
end

function Armory:FindInventoryItem(itemList, ...)
    local id, container, numSlots, items, link, tinker, anchor, name, itemCount, text;
    local list = itemList or {};

    for i = 1, #ArmoryInventoryContainers do
        id = ArmoryInventoryContainers[i];
        container, numSlots = self:GetInventoryContainerInfoEx(id);
        if ( (numSlots or 0) > 0 ) then
            for index = 1, numSlots do
                link, tinker, anchor = self:GetContainerItemLink(id, index);
                name = self:GetNameFromLink(link);
                if ( self:GetConfigExtendedSearch() ) then
                    text = self:GetTextFromLink(link, tinker);
                else
                    text = name;
                end
                if ( self:FindTextParts(text, ...) ) then
                    _, itemCount = self:GetContainerItemInfo(id, index);
                    if ( itemCount > 1 ) then
                        table.insert(list, {label=container, name=name, link=link, tinker=tinker, anchor=anchor, count=itemCount});
                    else
                        table.insert(list, {label=container, name=name, link=link, tinker=tinker, anchor=anchor});
                    end
                end
            end
        end
        
        if ( id > BACKPACK_CONTAINER and id <= NUM_BAG_SLOTS ) then
            link = self:GetInventoryItemLink("player", ContainerIDToInventoryID(id));
        elseif ( id > NUM_BAG_SLOTS and id <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS ) then
            link = self:GetContainerItemLink(BANK_CONTAINER, NUM_BANKGENERIC_SLOTS + id - NUM_BAG_SLOTS);
        else
            link = nil;
        end
        if ( link ) then
            if ( self:GetConfigExtendedSearch() ) then
                text = self:GetTextFromLink(link);
            else
                text = self:GetNameFromLink(link);
            end
            if ( self:FindTextParts(text, ...) ) then
                table.insert(list, {label=ARMORY_EQUIPPED, name=container, link=link})
            end
        end
    end

    return list;
end

local knownBy = {};
local function AddKnownBy(name)
    if ( Armory:GetConfigShowKnownBy() and name ~= Armory.player ) then
        table.insert(knownBy, name);
    end
end

local canLearn = {};
local function AddCanLearn(name)
    if ( Armory:GetConfigShowCanLearn() ) then
        table.insert(canLearn, name);
    end
end

local hasSkill = {};
local function AddHasSkill(name)
    if ( Armory:GetConfigShowHasSkill() ) then
        table.insert(hasSkill, name);
    end
end
