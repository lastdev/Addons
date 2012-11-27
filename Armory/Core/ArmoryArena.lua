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
local container = "ArenaTeams";

----------------------------------------------------------
-- Arena Teams Storage
----------------------------------------------------------

function Armory:ClearArenaTeams()
    self:ClearModuleData(container);
    dirty = true;
end

function Armory:UpdateArenaTeams()
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end
    
    if ( not self:PVPEnabled() ) then
        dbEntry:SetValue(container, nil);
        return;
    end

    if ( not self:IsLocked(container) ) then
        self:Lock(container);
        
        for id = 1, MAX_ARENA_TEAMS do
            dbEntry:SetValue(2, container, id, _G.GetArenaTeam(id));
            
            local oldNum = dbEntry:GetNumValues(container, id, "Members");
            local newNum = 0;
            if ( _G.GetArenaTeam(id) ) then
                _G.ArenaTeamRoster(id);
                newNum = _G.GetNumArenaTeamMembers(id, 1);
                for i = 1, newNum do
                    dbEntry:SetValue(4, container, id, "Members", i, _G.GetArenaTeamRosterInfo(id, i));
                end
            end
            for i = newNum + 1, oldNum do
                dbEntry:SetValue(4, container, id, "Members", i, nil);
            end
        end

        self:PrintDebug("UPDATE", container);
        
        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

----------------------------------------------------------
-- Arena Teams Interface
----------------------------------------------------------

function Armory:GetArenaTeam(id)
    local dbEntry = Armory.selectedDbBaseEntry;
    if ( dbEntry ) then
        return dbEntry:GetValue(container, id);
    end
end

function Armory:GetNumArenaTeamMembers(id, showOffline)
    local dbEntry = Armory.selectedDbBaseEntry;
    return (dbEntry and dbEntry:GetNumValues(container, id, "Members")) or 0;
end

function Armory:GetArenaTeamRosterInfo(id, index)
    local dbEntry = Armory.selectedDbBaseEntry;
    if ( dbEntry ) then
        return dbEntry:GetValue(container, id, "Members", index);
    end
end
