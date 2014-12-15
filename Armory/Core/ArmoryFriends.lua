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
local container = "Friends";

----------------------------------------------------------
-- Friends Storage
----------------------------------------------------------

local classes = {};

function Armory:ClearFriends()
    self:ClearModuleData(container);
end

function Armory:UpdateFriends()
    local dbEntry = self.playerDbBaseEntry;
    local name, class, note;
    local ignores;
    if ( not dbEntry ) then
        return;
    elseif ( not self:HasSocial() ) then
        dbEntry:SetValue(container, nil);
        return;
    end

    if ( not self:IsLocked(container) ) then
        self:Lock(container);

        self:PrintDebug("UPDATE", container);
        
        local oldFriends = dbEntry:GetNumValues(container);
        local newFriends = _G.GetNumFriends();

        local oldIgnores = dbEntry:GetNumValues(container, "Ignores");
        local newIgnores = _G.GetNumIgnores();
        
        if ( newFriends + newIgnores == 0 ) then
            dbEntry:SetValue(container, nil);
        else
            dbEntry:SelectContainer(container);
            if ( newFriends > 0 ) then
                -- Preserve known classes
                for index = 1, oldFriends do 
                    name, class = dbEntry:GetValue(container, index);
                    if ( name and class ~= UNKNOWN ) then
                        classes[name] = class;
                    end
                end
            end
            
            for index = 1, max(oldFriends, newFriends) do
                if ( index > newFriends ) then
                    dbEntry:SetValue(2, container, index, nil);
                else
                    name, _, class, _, _, _, note = _G.GetFriendInfo(index);
                    if ( name ) then
                        if ( class == UNKNOWN and classes[name] ) then
                            class = classes[name];
                        end
                    end
                    dbEntry:SetValue(2, container, index, name or UNKNOWN, class, note);
                end
            end
            
            if ( newIgnores == 0 ) then
                dbEntry:SetValue(2, container, "Ignores", nil);
            else
                ignores = dbEntry:SelectContainer(container, "Ignores");
                for index = 1,  max(oldIgnores, newIgnores) do
                    if ( index > newIgnores ) then
                        ignores[index] = nil;
                    else
                        ignores[index] = _G.GetIgnoreName(index) or UNKNOWN;
                    end
                end
            end
        end

        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

----------------------------------------------------------
-- Friends Interface
----------------------------------------------------------

function Armory:GetNumFriends()
    local dbEntry = self.selectedDbBaseEntry;
    return (dbEntry and dbEntry:GetNumValues(container)) or 0;
end

function Armory:GetFriendInfo(index)
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry ) then
        return dbEntry:GetValue(container, index);
    end
end

function Armory:GetNumIgnores()
    local dbEntry = self.selectedDbBaseEntry;
    return (dbEntry and dbEntry:GetNumValues(container, "Ignores")) or 0;
end

function Armory:GetIgnoreName(index)
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry ) then
        local ignores = dbEntry:GetValue(container, "Ignores");
        if ( ignores ) then
            return ignores[index];
        end
    end
    return "";
end