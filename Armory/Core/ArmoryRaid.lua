--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 627 2014-04-08T08:27:25Z
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
local container = "Instances";

----------------------------------------------------------
-- Raid Info Internals
----------------------------------------------------------

local instanceLines = {};
local expiredLines = {};
local dirty = true;
local owner = "";

local function GetInstanceLines()
    local count = Armory:GetNumSavedInstances();

    table.wipe(instanceLines);
    table.wipe(expiredLines);
    
    for i = 1, count do
        _, _, _, _, locked, extended = Armory:GetSavedInstanceInfo(i);
        if ( extended or locked ) then
            table.insert(instanceLines, i);
        else
            table.insert(expiredLines, i);
        end
    end
    for i = 1, #expiredLines do
        table.insert(instanceLines, expiredLines[i]);
    end
    table.wipe(expiredLines);
    
    dirty = false;
    owner = Armory:SelectedCharacter();

    return instanceLines;
end

----------------------------------------------------------
-- Raid Info Storage
----------------------------------------------------------

function Armory:ClearInstances()
    self:ClearModuleData(container);
    dirty = true;
end

function Armory:UpdateInstances()
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    elseif ( not self:RaidEnabled() ) then
        dbEntry:SetValue(container, nil);
        return;
    end
    
    if ( not self:IsLocked(container) ) then
        self:Lock(container);

        self:PrintDebug("UPDATE", container);

        local oldNum = dbEntry:GetValue(container, "NumInstances") or 0;
        local newNum = _G.GetNumSavedInstances();
        
        if ( newNum == 0 ) then
            dbEntry:SetValue(container, nil);
        else
            dbEntry:SelectContainer(container);
            dbEntry:SetValue(2, container, "NumInstances", newNum);
            dbEntry:SetValue(2, container, "TimeStamp", time());
            for i = 1, max(oldNum, newNum) do
                if ( i > newNum ) then
                    dbEntry:SetValue(2, container, "Instance"..i, nil);
                    dbEntry:SetValue(2, container, "Tooltip"..i, nil);
                else
                    local tooltipLines;
                    local tooltip = self:AllocateTooltip();
                    tooltip:SetInstanceLockEncountersComplete(i);
                    tooltipLines = Armory:Tooltip2Table(tooltip);
                    self:ReleaseTooltip(tooltip);
    
                    dbEntry:SetValue(2, container, "Instance"..i, _G.GetSavedInstanceInfo(i));
                    dbEntry:SetValue(2, container, "Tooltip"..i, unpack(tooltipLines));
                end
            end
        end
        
        dirty = dirty or self:IsPlayerSelected();
        
        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

function Armory:UpdateInstancesInProgress()
    return self:IsLocked(container);
end

----------------------------------------------------------
-- Raid Info Interface
----------------------------------------------------------

function Armory:GetNumSavedInstances()
    local dbEntry = self.selectedDbBaseEntry;
    return (dbEntry and dbEntry:GetValue(container, "NumInstances")) or 0;
end

function Armory:GetSavedInstanceInfo(id)
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry ) then
        local timestamp = dbEntry:GetValue(container, "TimeStamp");
        local instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName = dbEntry:GetValue(container, "Instance"..id);

        if ( instanceReset ) then
            instanceReset = instanceReset - (time() - timestamp);
            if ( instanceReset <= 0 ) then
                instanceReset = 0;
                locked = false;
                extended = false;
            end
        end
        
        if ( not difficultyName and instanceDifficulty > 1 ) then
            difficultyName = format(DUNGEON_NAME_WITH_DIFFICULTY, instanceName, _G["DUNGEON_DIFFICULTY"..instanceDifficulty]);
        end

        return instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig or time(), isRaid, maxPlayers or 0, difficultyName or "";
    end
end

function Armory:GetInstanceLineId(index)
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetInstanceLines();
    end
    return instanceLines[index];
end

local instanceTooltip = {};
function Armory:GetInstanceTooltip(index)
    local dbEntry = self.selectedDbBaseEntry;
    if ( index and dbEntry ) then
        local id = self:GetInstanceLineId(index);
        if ( id and dbEntry:Contains(container, "Tooltip"..id) ) then
            self:FillTable(instanceTooltip, dbEntry:GetValue(container, "Tooltip"..id));
            return instanceTooltip;
        end
    end
end

