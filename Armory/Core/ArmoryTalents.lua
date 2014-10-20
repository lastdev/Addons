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
local container = "Talents";

----------------------------------------------------------
-- Talents Storage
----------------------------------------------------------

function Armory:TalentsExists()
    local dbEntry = self.playerDbBaseEntry;
    local activeTalentGroup = _G.GetActiveSpecGroup() or 1;
    return dbEntry and dbEntry:Contains(container, activeTalentGroup);
end

function Armory:ClearTalents()
    self:ClearModuleData(container);
end

function Armory:SetTalents()
    local dbEntry = self.playerDbBaseEntry;
    
    if ( not dbEntry ) then
        return;
    elseif ( not self:TalentsEnabled() or _G.UnitLevel("player") < SHOW_TALENT_LEVEL ) then
        dbEntry:SetValue(container, nil);
        return;
    end
    
    if ( not self:IsLocked(container) ) then
        self:Lock(container);

        self:PrintDebug("UPDATE", container);
    
        local oldNum = self:GetClassNumValues("player", container);
	    local newNum = _G.GetNumTalents();
	    local numTalentGroups = _G.GetNumSpecGroups();
        local activeTalentGroup = _G.GetActiveSpecGroup() or 1;

        for talentGroup = 1, numTalentGroups do
            local update = (talentGroup == activeTalentGroup or not dbEntry:Contains(container, talentGroup));
            for i = 1, max(oldNum, newNum) do
                if ( i > newNum ) then
                    self:SetClassValue("player", 2, container, i, nil);
                    dbEntry:SetValue(3, container, talentGroup, i, nil);
                elseif ( update ) then
	                local name, iconTexture, tier, column, selected, available = _G.GetTalentInfo(i, false, talentGroup);
	                local link = _G.GetTalentLink(i, false, talentGroup);

                    if ( talentGroup == 1 ) then
	                    self:SetClassValue("player", 2, container, i, name, iconTexture, tier, column, link);
	                end
	                dbEntry:SetValue(3, container, talentGroup, i, selected, available);
	            end
	        end
	    end
	    
        dbEntry:SetValue(3, container, activeTalentGroup, "Unspent", _G.GetNumUnspentTalents());
        
        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

----------------------------------------------------------
-- Talents Interface
----------------------------------------------------------

function Armory:HasTalents()
	return self:TalentsEnabled() and self:GetNumSpecGroups() > 0;
end

function Armory:GetSelectedTalentGroup()
    return ArmoryTalentFrame.talentGroup or self:GetActiveSpecGroup();
end

function Armory:GetNumUnspentTalents(talentGroup)
	local dbEntry = self.selectedDbBaseEntry;
	return (dbEntry and dbEntry:GetValue(container, (talentGroup or self:GetSelectedTalentGroup()), "Unspent")) or 0;
end

function Armory:GetNumSpecGroups(inspect)
    local dbEntry = self.selectedDbBaseEntry;
    return (dbEntry and dbEntry:GetNumValues(container)) or 0;
end

function Armory:GetNumTalents(inspect)
    return self:GetClassNumValues("player", container);
end

function Armory:GetTalentInfo(index, inspect, talentGroup)
	local dbEntry = self.selectedDbBaseEntry;
	if ( dbEntry ) then
	    local name, iconTexture, tier, column = self:GetClassValue("player", container, index);
	    local selected, available = dbEntry:GetValue(container, talentGroup, index);
	    return name, iconTexture, tier, column, selected, available;
	end
end

function Armory:GetTalentLink(index, inspect, talentGroup)
	local _, _, _, _, link = self:GetClassValue("player", container, index);
	return link;
end

