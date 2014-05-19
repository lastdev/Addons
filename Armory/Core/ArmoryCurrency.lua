--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 629 2014-04-09T09:00:00Z
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
local container = "Currency";

----------------------------------------------------------
-- Currency Internals
----------------------------------------------------------

local currencyLines = {};
local dirty = true;
local owner = "";

local CONTENT_REWARDS = { HONOR_CURRENCY, CONQUEST_CURRENCY, JUSTICE_CURRENCY, VALOR_CURRENCY };

local function GetCurrencyLines()
    local dbEntry = Armory.selectedDbBaseEntry;

    table.wipe(currencyLines);
    
    if ( dbEntry ) then
        local count = dbEntry:GetNumValues(container);
        local expanded = true;
        
        for i = 1, count do
            local name, isHeader = dbEntry:GetValue(container, i);
            if ( isHeader ) then
                table.insert(currencyLines, i);
                expanded = not Armory:GetHeaderLineState(container, name);
            elseif ( expanded ) then
                table.insert(currencyLines, i);
            end
        end
    end

    dirty = false;
    owner = Armory:SelectedCharacter();

    return currencyLines;
end

local function GetCurrencyLineValue(index, key, subkey)
    local numLines = Armory:GetCurrencyListSize();
    if ( index > 0 and index <= numLines ) then
        local dbEntry = Armory.selectedDbBaseEntry;
        if ( dbEntry ) then
            if ( subkey ) then
                return dbEntry:GetValue(container, currencyLines[index], key, subkey);
            elseif ( key ) then
                return dbEntry:GetValue(container, currencyLines[index], key);
            else
                return dbEntry:GetValue(container, currencyLines[index]);
            end
        end
    end
end

local function UpdateCurrencyHeaderState(index, isCollapsed)
    local dbEntry = Armory.selectedDbBaseEntry;
    
    if ( dbEntry ) then
        if ( index == 0 ) then
            for i = 1, dbEntry:GetNumValues(container) do
                local name, isHeader = dbEntry:GetValue(container, i);
                if ( isHeader ) then
                    Armory:SetHeaderLineState(container, name, isCollapsed);
                end
            end
        else
            local numLines = Armory:GetCurrencyListSize();
            if ( index > 0 and index <= numLines ) then
                local name = dbEntry:GetValue(container, currencyLines[index]);
                Armory:SetHeaderLineState(container, name, isCollapsed);
            end
        end
    end

    dirty = true;
end

----------------------------------------------------------
-- Currency Storage
----------------------------------------------------------

function Armory:CurrencyExists()
    local dbEntry = self.playerDbBaseEntry;
    return dbEntry and dbEntry:Contains(container);
end

function Armory:ClearCurrency()
    self:ClearModuleData(container);
    dirty = true;
end

local retries = 0;
function Armory:UpdateCurrency()
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end
    
    -- force update of currencies used in the summary
    for i = 1, #CONTENT_REWARDS do
		self:GetCurrencyInfo(CONTENT_REWARDS[i]);
    end
    
    if ( not self:CurrencyEnabled() ) then
        dbEntry:SetValue(container, nil);
        return;
    end

    if ( not self:IsLocked(container) ) then
        self:Lock(container);

        self:PrintDebug("UPDATE", container);

        -- store the complete (expanded) list
        local funcNumLines = _G.GetCurrencyListSize;
        local funcGetLineInfo = function(index)
            local name, isHeader, isExpanded, isUnused, isWatched, count, icon = _G.GetCurrencyListInfo(index);
            local link;
            if ( not isHeader ) then
                link = _G.GetCurrencyListLink(index);
            end
            return name, isHeader, isExpanded, isUnused, isWatched, count, icon, link;
        end;
        local funcGetLineState = function(index)
            local _, isHeader, isExpanded = _G.GetCurrencyListInfo(index);
            return isHeader, isExpanded;
        end;
        local funcExpand = function(index) _G.ExpandCurrencyList(index, 1); end;
        local funcCollapse = function(index) _G.ExpandCurrencyList(index, 0); end;

        if ( retries < 3 and not dbEntry:SetExpandableListValues(container, funcNumLines, funcGetLineState, funcGetLineInfo, funcExpand, funcCollapse) ) then
            retries = retries + 1;
            self:PrintDebug("Update failed; executing again...", retries);
            self:Execute(function () Armory:UpdateCurrency() end);
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
-- Currency Interface
----------------------------------------------------------

function Armory:HasCurrency()
    return self:CurrencyEnabled() and self:GetCurrencyListSize() > 0;
end

function Armory:GetCurrencyListSize()
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetCurrencyLines();
    end
    return #currencyLines;
end

function Armory:GetCurrencyListInfo(index)
    local dbEntry = self.selectedDbBaseEntry;
    local numLines = self:GetCurrencyListSize();
    if ( dbEntry and index > 0 and index <= numLines ) then
        local name, isHeader, isExpanded, isUnused, isWatched, count, icon, link = dbEntry:GetValue(container, currencyLines[index]);
        isExpanded = not Armory:GetHeaderLineState(container, name);
        return name, isHeader, isExpanded, isUnused, isWatched, count, icon, link; 
    end
end

function Armory:ExpandCurrencyList(index, expand)
    UpdateCurrencyHeaderState(index, expand ~= 1);
end

function Armory:SetCurrencyToken(index)
    local link = select(8, self:GetCurrencyListInfo(index));
    if ( type(link) == "string" ) then
        self:SetHyperlink(GameTooltip, link);
        GameTooltip:Show();
    end
end

function Armory:CountCurrency(link)
    local dbEntry = self.selectedDbBaseEntry;
    local currency = link and link:match("currency:(%d+)");
    if ( dbEntry and currency ) then
        local name;
        -- manually created link contains 'currency:0'
        if ( link:find("|H") ) then
            name = self:GetNameFromLink(link);
        else
            name = _G.GetCurrencyInfo(currency);
        end
        for i = 1, dbEntry:GetNumValues(container) do
            local currencyName, isHeader, _, _, _, count, icon = dbEntry:GetValue(container, i);
            local isPVPCurrency = icon and icon:find("PVPCurrency");
            if ( currencyName and not isHeader and not isPVPCurrency and strtrim(currencyName) == strtrim(name) ) then
                return count;
            end
        end
    end
    return 0;
end

function Armory:IsContentReward(name)
	for i = 1, #CONTENT_REWARDS do
		if ( name == (_G.GetCurrencyInfo(CONTENT_REWARDS[i])) ) then
			return true;
		end
	end
	return false;
end

function Armory:GetVirtualNumCurrencies()
	if ( self:CurrencyEnabled() ) then
		local dbEntry = self.selectedDbBaseEntry;
		return dbEntry and dbEntry:GetNumValues(container) or 0;
	else
		return #CONTENT_REWARDS;
	end
end

function Armory:GetVirtualCurrencyInfo(index, contentReward)
    local name, isHeader, count, icon, earnedThisWeek, earnablePerWeek;
	
	if ( not contentReward and self:CurrencyEnabled() ) then
		local dbEntry = self.selectedDbBaseEntry;
        if ( dbEntry ) then
			name, isHeader, _, _, _, count, icon = dbEntry:GetValue(container, index);
			for i = 1, #CONTENT_REWARDS do
				if ( name == (_G.GetCurrencyInfo(CONTENT_REWARDS[i])) ) then
					return self:GetVirtualCurrencyInfo(i, true);
				end
			end
		end
	else
		name, count, icon, earnedThisWeek, earnablePerWeek = self:GetCurrencyInfo(CONTENT_REWARDS[index]);
		if ( earnablePerWeek and CONTENT_REWARDS[index] == VALOR_CURRENCY ) then
			earnablePerWeek = floor(earnablePerWeek / 100);
		end
	end

	return name, isHeader, count, icon, earnedThisWeek, earnablePerWeek;
end