--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 525 2012-09-20T09:02:14Z
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
local container = "RaidFinder";

----------------------------------------------------------
-- Raid Finder Internals
----------------------------------------------------------

local dungeonLines = {};
local dirty = true;
local owner = "";

local function GetDungeonLines()
    local dbEntry = Armory.selectedDbBaseEntry;
    
    table.wipe(dungeonLines);

    if ( dbEntry ) then
        for index = 1, GetNumRFDungeons() do
            local dungeonID = GetRFDungeonInfo(index);
            if ( dbEntry:Contains(container, "Killed"..dungeonID) ) then
                local _, dungeonReset, timestamp = dbEntry:GetValue(container, "Info"..dungeonID);
                if ( dungeonReset and dungeonReset + (timestamp or 0) > time() ) then
                    table.insert(dungeonLines, dungeonID);
                end
            end
        end
    end

    dirty = false;
    owner = Armory:SelectedCharacter();

    return dungeonLines;
end

----------------------------------------------------------
-- Raid Finder Storage
----------------------------------------------------------

function Armory:ClearRaidFinder()
    self:ClearModuleData(container);
    dirty = true;
end

function Armory:SaveRaidFinderInfo(dungeonName, dungeonID, dungeonReset, difficultyIndex, maxPlayers, difficultyName)
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
        
        dbEntry:SelectContainer(container);
        dbEntry:SetValue(2, container, "Info"..dungeonID, dungeonName, dungeonReset, time(), difficultyIndex, maxPlayers, difficultyName);
        
        dirty = dirty or self:IsPlayerSelected();
        
        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
    
    self:UpdateRaidFinderInfo();
end

function Armory:UpdateRaidFinderInfo()
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
    
        for index = 1, GetNumRFDungeons() do
            local dungeonID = GetRFDungeonInfo(index);
            if ( dbEntry:Contains(container, "Info"..dungeonID) ) then
                local numEncounters, numCompleted = GetLFGDungeonNumEncounters(dungeonID);
                if ( numCompleted > 0 ) then
                    local killed = {};
                    for i = 1, numEncounters do
                        local bossName, _, isKilled = GetLFGDungeonEncounterInfo(dungeonID, i);
                        if ( isKilled ) then
                            table.insert(killed, bossName);
                        end
                    end
                    dbEntry:SetValue(2, container, "Killed"..dungeonID, killed);
                else
                    dbEntry:SetValue(2, container, "Killed"..dungeonID, nil);
                end
                
                dirty = dirty or self:IsPlayerSelected();
            end
        end
         
        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

function Armory:UpdateRaidFinderInProgress()
    return self:IsLocked(container);
end

----------------------------------------------------------
-- Raid Finder Interface
----------------------------------------------------------

function Armory:GetNumRaidFinderDungeons()
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetDungeonLines();
    end
    return #dungeonLines;
end

function Armory:GetRaidFinderInfo(dungeonID)
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry ) then
        local dungeonName, dungeonReset, timestamp, difficultyIndex, maxPlayers, difficultyName = dbEntry:GetValue(container, "Info"..dungeonID);
        local killed = dbEntry:GetValue(container, "Killed"..dungeonID);
        local locked = true;

        -- For now overwrite '25 Player' with 'Raid Finder'
        difficultyName = PLAYER_DIFFICULTY3;

        if ( dungeonReset ) then
            dungeonReset = dungeonReset - (time() - timestamp);
            if ( dungeonReset <= 0 ) then
                dungeonReset = 0;
                locked = false;
            end
        end

        if ( not difficultyName and difficultyIndex > 1 ) then
            difficultyName = format(DUNGEON_NAME_WITH_DIFFICULTY, dungeonName, _G["DUNGEON_DIFFICULTY"..difficultyIndex]);
        end

        return dungeonName, dungeonID, dungeonReset, difficultyIndex, locked, maxPlayers or 0, difficultyName or "", killed;
    end
end

function Armory:GetRaidFinderLineId(index)
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetDungeonLines();
    end
    return dungeonLines[index];
end
