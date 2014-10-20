--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 592 2013-05-21T13:24:07Z
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
local container = "GearSets";

----------------------------------------------------------
-- Gear Set Internals
----------------------------------------------------------

local function GetEquipmentSetIndex(name)
    for i = 1, Armory:GetNumEquipmentSets() do
        if ( Armory:GetEquipmentSetInfo(i) == name ) then
            return i;
        end
    end
    return -1;
end

----------------------------------------------------------
-- Gear Set Storage
----------------------------------------------------------

function Armory:UpdateGearSets()
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end
    
    if ( not self:IsLocked(container) ) then
        self:Lock(container);

        self:PrintDebug("UPDATE", container);
        
        local oldNum = dbEntry:GetNumValues(container);
        local newNum = _G.GetNumEquipmentSets();
        
        if ( newNum == 0 ) then
            dbEntry:SetValue(container, nil);
        else
            local name;
            for i = 1, max(oldNum, newNum) do
                if ( i > newNum ) then
                    dbEntry:SetValue(2, container, i, nil);
                else
                    name = _G.GetEquipmentSetInfo(i);
                    dbEntry:SetValue(2, container, i, _G.GetEquipmentSetInfo(i));
                    dbEntry:SetValue(3, container, i, "Items", unpack(_G.GetEquipmentSetItemIDs(name) or {}));
                    dbEntry:SetValue(3, container, i, "Locations", unpack(_G.GetEquipmentSetLocations(name) or {}));
                end
            end
        end

        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

----------------------------------------------------------
-- Gear Set Interface
----------------------------------------------------------

function Armory:GetNumEquipmentSets()
    local dbEntry = self.selectedDbBaseEntry;
    return (dbEntry and dbEntry:GetNumValues(container)) or 0;
end

function Armory:GetEquipmentSetInfo(id)
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry ) then
        if ( type(id) == "string" ) then
            id = GetEquipmentSetIndex(id);
        end
        return dbEntry:GetValue(container, id);
    end
end

function Armory:GetEquipmentSetItemIDs(id, t)
    local dbEntry = self.selectedDbBaseEntry;
    local result = t or {};
    if ( dbEntry ) then
        if ( type(id) == "string" ) then
            id = GetEquipmentSetIndex(id);
        end
        self:FillTable(result, dbEntry:GetValue(container, id, "Items"));
    end
    return result;
end

function Armory:GetEquipmentSetLocations(id, t)
    local dbEntry = self.selectedDbBaseEntry;
    local result = t or {};
    if ( dbEntry ) then
        if ( type(id) == "string" ) then
            id = GetEquipmentSetIndex(id);
        end
        self:FillTable(result, dbEntry:GetValue(container, id, "Locations"));
    end
    return result;
end

local gearSets = {};
local gearSetItems = {};
function Armory:AddEquipmentSet(tooltip)
    if ( not self:GetConfigShowGearSets() ) then
        return;
    end

    local numSets = self:GetNumEquipmentSets();
    if ( numSets > 0 ) then
        local _, link = tooltip:GetItem();
        if ( link and IsEquippableItem(link) ) then
            local _, _, _, _, _, _, _, _, equipLoc = GetItemInfo(link);
            if ( equipLoc ~= "" ) then
                local itemId = self:GetItemId(link);
                local name;
                table.wipe(gearSets);
                for id = 1, numSets do
                    name = self:GetEquipmentSetInfo(id);
                    self:GetEquipmentSetItemIDs(id, gearSetItems);
                    for i = EQUIPPED_FIRST, EQUIPPED_LAST do
                        if ( gearSetItems[i] == tonumber(itemId) ) then
                            table.insert(gearSets, name);
                            break;
                        end  
                    end
                end
                if ( #gearSets > 0 ) then
                    tooltip:AddLine(format(EQUIPMENT_SETS, table.concat(gearSets, ", ")), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
                    tooltip:Show();
                end
            end
        end
    end
end