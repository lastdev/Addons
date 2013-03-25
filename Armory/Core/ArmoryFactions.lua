--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 565 2012-11-28T10:03:52Z
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
local container = "Factions";

----------------------------------------------------------
-- Factions Internals
----------------------------------------------------------

local factionLines = {};
local dirty = true;
local owner = "";

local function GetFactionLines()
    local dbEntry = Armory.selectedDbBaseEntry;

    table.wipe(factionLines);
    
    if ( dbEntry ) then
        local count = dbEntry:GetNumValues(container);
        local collapsed = false;
        local childCollapsed = false;

        for i = 1, count do
            local name, _, _, _, _, _, _, _, isHeader, _, _, _, isChild = dbEntry:GetValue(container, i);
            local isCollapsed = Armory:GetHeaderLineState(container, name);
            if ( isHeader and not isChild ) then
                table.insert(factionLines, i);
                collapsed = isCollapsed;
                childCollapsed = false;
            elseif ( isHeader and isChild ) then
                if ( not collapsed ) then
                    table.insert(factionLines, i);
                end
                childCollapsed = collapsed or isCollapsed;
            elseif ( not (collapsed or childCollapsed) ) then
                table.insert(factionLines, i);
            end
        end
    end
    
    dirty = false;
    owner = Armory:SelectedCharacter();
    
    return factionLines;
end

local function UpdateFactionHeaderState(index, isCollapsed)
    local dbEntry = Armory.selectedDbBaseEntry;

    if ( dbEntry ) then
        if ( index == 0 ) then
            for i = 1, dbEntry:GetNumValues(container) do
                local name, _, _, _, _, _, _, _, isHeader = dbEntry:GetValue(container, i);
                if ( isHeader ) then
                    Armory:SetHeaderLineState(container, name, isCollapsed);
                end
            end
        else
            local numLines = Armory:GetNumFactions();
            if ( index > 0 and index <= numLines ) then
                local name = dbEntry:GetValue(container, factionLines[index]);
                Armory:SetHeaderLineState(container, name, isCollapsed);
            end
        end
    end
    
    dirty = true;
end

----------------------------------------------------------
-- Factions Storage
----------------------------------------------------------

function Armory:FactionsExists()
    local dbEntry = self.playerDbBaseEntry;
    return dbEntry and dbEntry:Contains(container);
end

function Armory:ClearFactions()
    self:ClearModuleData(container);
    dirty = true;
end

local retries = 0;
function Armory:UpdateFactions()
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    elseif ( not self:ReputationEnabled() ) then
        dbEntry:SetValue(container, nil);
        return;
    end
    
    if ( not self:IsLocked(container) ) then
        self:Lock(container);

        self:PrintDebug("UPDATE", container);

        -- store the complete (expanded) list
        local funcNumLines = _G.GetNumFactions;
        local funcGetLineInfo = function(index)
            local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID = _G.GetFactionInfo(index);
            local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID);
            if ( friendID ~= nil ) then
                description = friendTextLevel;
				if ( nextFriendThreshold ) then
					barMin, barMax, barValue = friendThreshold, nextFriendThreshold, friendRep;
				else
					-- max rank, make it look like a full bar
					barMin, barMax, barValue = 0, 1, 1;
				end
				standingID = 5;
            else
                description = nil;
            end
            return name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild;
        end;
        local funcGetLineState = function(index)
            local _, _, _, _, _, _, _, _, isHeader, isCollapsed = _G.GetFactionInfo(index);
            return isHeader, not isCollapsed;
        end;
        local funcExpand = _G.ExpandFactionHeader;
        local funcCollapse = _G.CollapseFactionHeader;

        if ( retries < 3 and not dbEntry:SetExpandableListValues(container, funcNumLines, funcGetLineState, funcGetLineInfo, funcExpand, funcCollapse) ) then
            retries = retries + 1;
            self:PrintDebug("Update failed; executing again...", retries);
            self:Execute(function () Armory:UpdateFactions() end);
        else
            retries = 0;
        end

        dirty = dirty or self:IsPlayerSelected();
        
        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

----------------------------------------------------------
-- Factions Interface
----------------------------------------------------------

function Armory:HasReputation()
    return self:ReputationEnabled() and self:GetNumFactions() > 0;
end

function Armory:GetNumFactions()
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetFactionLines();
    end
    return #factionLines;
end

function Armory:GetFactionInfo(index)
    local dbEntry = self.selectedDbBaseEntry;
    local numLines = self:GetNumFactions();
    if ( dbEntry and index > 0 and index <= numLines ) then
        local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = dbEntry:GetValue(container, factionLines[index]);
        isCollapsed = self:GetHeaderLineState(container, name);
        return name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild;
    end
end

function Armory:ExpandFactionHeader(index)
    UpdateFactionHeaderState(index, false);
end

function Armory:CollapseFactionHeader(index)
    UpdateFactionHeaderState(index, true);
end

function Armory:GetFactionStanding(factionName)
    local dbEntry = self.selectedDbBaseEntry;
    
    if ( dbEntry ) then
        local count = dbEntry:GetNumValues(container);
        for i = 1, count do
            local name, _, standingID = dbEntry:GetValue(container, i);
            if ( name == factionName ) then
                return standingID, GetText("FACTION_STANDING_LABEL"..standingID, self:UnitSex("player"));
            end
        end
    end
    return 0, UNKNOWN;
end