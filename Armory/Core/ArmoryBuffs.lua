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
local container = "Buffs";

local continuousBuffs = {
    ["71041"] = true, -- Dungeon Deserter
    ["24755"] = true, -- Tricked or Treated
    ["26013"] = true, -- Deserter
    ["26218"] = true, -- Mistletoe
    ["26680"] = true, -- Adored
};

----------------------------------------------------------
-- Buffs Internals
----------------------------------------------------------

local function IsMatch(value, pattern)
    local single, multi = pattern:match("|4(.+):(.+);");
    if ( single ) then
        single = pattern:gsub("|4.+:.+;", single);
        multi = pattern:gsub("|4.+:.+;", multi);
        return value:find(multi) or value:find(single);
    end
    return value:find(pattern);
end

local daysPattern = SPELL_TIME_REMAINING_DAYS:gsub("%%d", "%%d+");
local hoursPattern = SPELL_TIME_REMAINING_HOURS:gsub("%%d", "%%d+");
local minPattern = SPELL_TIME_REMAINING_MIN:gsub("%%d", "%%d+");
local secPattern = SPELL_TIME_REMAINING_SEC:gsub("%%d", "%%d+");

local function SetBuff(dbEntry, unit, index, filter)
    local tooltipLines;
    
    if ( _G.UnitAura(unit, index, filter) ) then
        local tooltip = Armory:AllocateTooltip();
        tooltip:SetUnitAura(unit, index, filter);
        tooltipLines = Armory:Tooltip2Table(tooltip);
        Armory:ReleaseTooltip(tooltip);
    
        if ( #tooltipLines > 0 ) then
            local _, _, _, remaining = Armory:String2Text(tooltipLines[#tooltipLines]);
            if ( IsMatch(remaining, secPattern) or IsMatch(remaining, minPattern) or IsMatch(remaining, hoursPattern) or IsMatch(remaining, daysPattern) ) then
                table.remove(tooltipLines);
            end
        end

        dbEntry:SetValue(3, container, filter, "Aura"..index, _G.UnitAura(unit, index, filter));
        dbEntry:SetValue(3, container, filter, "Tooltip"..index, unpack(tooltipLines));
    else
        dbEntry:SetValue(3, container, filter, "Aura"..index, nil);
        dbEntry:SetValue(3, container, filter, "Tooltip"..index, nil);
    end
end

local function GetBuffValue(unit, filter, key)
    local dbEntry = Armory.selectedDbBaseEntry;

    if ( dbEntry and strlower(unit) == "pet" ) then
        if ( not Armory:PetExists(Armory:GetCurrentPet()) ) then
            return;
        end
        dbEntry = Armory:SelectPet(dbEntry, Armory:GetCurrentPet());
    end

    if ( dbEntry ) then
        return dbEntry:GetValue(container, filter, key);
    end
end

local function GetBuffTimeLeft(unit, index, filter)
    if ( unit ~= "player" ) then
        return;
    end

    local dbEntry = Armory.selectedDbBaseEntry;

    if ( dbEntry ) then
        local _, _, _, _, _, duration, expirationTime, _, _, _, spellId = dbEntry:GetValue(container, filter, "Aura"..index);
        local timeLeft;

        if ( duration and duration > 0 and expirationTime ) then
            if ( Armory:IsPlayerSelected() ) then
                timeLeft = expirationTime - GetTime();
            else
                local timestamp, uptime = dbEntry:GetValue(container, "Time");
                if ( not timestamp ) then
                    return;
                end
                
                timeLeft = expirationTime - uptime;

                if ( spellId and continuousBuffs[tostring(spellId)] ) then
                    timeLeft = timeLeft - (time() - timestamp);
                else
                    local _, logout = Armory:GetTimePlayed();
                    timeLeft = timeLeft - (logout - timestamp);
                end
            end
            timeLeft = max(timeLeft, 0);
        end
    
        return timeLeft;
    end
end


----------------------------------------------------------
-- Buffs Storage
----------------------------------------------------------

function Armory:ClearBuffs()
    self:ClearModuleData(container);
end

function Armory:SetBuffs(unit)
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end
    
    if ( strlower(unit) == "pet" ) then
        if ( not self:IsPersistentPet() ) then
            return;
        end
        dbEntry = self:SelectPet(dbEntry, self:GetPetName());
    end

    if ( not self:BuffsEnabled() ) then
        dbEntry:SetValue(container, nil);
        return;
    end
    
    if ( not self:IsLocked(container) ) then
        self:Lock(container);
        
        self:PrintDebug("UPDATE", container);
        
        dbEntry:SetValue(2, container, "Time", time(), GetTime());

        -- Handle Buffs
        for i = 1, ARMORY_BUFF_MAX_DISPLAY do
            SetBuff(dbEntry, unit, i, "HELPFUL");
        end

        -- Handle debuffs
        for i = 1, ARMORY_DEBUFF_MAX_DISPLAY do
            SetBuff(dbEntry, unit, i, "HARMFUL");
        end

        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

----------------------------------------------------------
-- Buffs Interface
----------------------------------------------------------

function Armory:GetBuff(unit, index, filter)
    if ( index ) then
        local timeLeft = GetBuffTimeLeft(unit, index, filter);
        if ( not timeLeft or timeLeft > 0 ) then
            return GetBuffValue(unit, filter, "Aura"..index);
        end
    end
end

local buffTooltip = {};
function Armory:GetBuffTooltip(unit, index, filter)
    if ( index ) then
        self:FillTable(buffTooltip, GetBuffValue(unit, filter, "Tooltip"..index));
        local timeLeft = GetBuffTimeLeft(unit, index, filter);
        if ( timeLeft and timeLeft > 0 ) then
            local r, g, b = GetTableColor(NORMAL_FONT_COLOR);
            if ( timeLeft >= 86400  ) then
		        table.insert(buffTooltip, self:Text2String(format(SPELL_TIME_REMAINING_DAYS, ceil(timeLeft / 86400)), r, g, b));
            elseif ( timeLeft >= 3600  ) then
		        table.insert(buffTooltip, self:Text2String(format(SPELL_TIME_REMAINING_HOURS, ceil(timeLeft / 3600)), r, g, b));
            elseif ( timeLeft >= 60  ) then
		        table.insert(buffTooltip, self:Text2String(format(SPELL_TIME_REMAINING_MIN, ceil(timeLeft / 60)), r, g, b));
		    else
		        table.insert(buffTooltip, self:Text2String(format(SPELL_TIME_REMAINING_SEC, timeLeft), r, g, b));
		    end
        end
        return buffTooltip;
    end
end
