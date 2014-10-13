--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 578 2013-01-15T22:05:28Z
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
local container = "Statistics";

----------------------------------------------------------
-- Statistics Internals
----------------------------------------------------------

local categories;
local function GetStatisticCategories()
    if ( not categories ) then
        categories = {};
        
        local list = _G.GetStatisticsCategoryList();
        local parent;
    
        for _, id in ipairs(list) do
            _, parent = _G.GetCategoryInfo(id);
            if ( parent == -1 ) then
                table.insert(categories, { id=id });
            end
        end

        for i = #list, 1, -1 do 
            _, parent = _G.GetCategoryInfo(list[i]);
            for j, category in ipairs(categories) do
                if ( category.id == parent ) then
                    table.insert(categories, j+1, { id=list[i], parent=category.id });
                end
            end
        end
    end
    return categories;
end

local statisticLines = {};
local dirty = true;
local owner = "";
local statistics = {};
local counts = {};

local function GetStatisticLines()
    local dbEntry = Armory.selectedDbBaseEntry;

    table.wipe(statistics);
    table.wipe(statisticLines);
    
    if ( dbEntry and dbEntry:Contains(container) ) then
        for _, category in ipairs(GetStatisticCategories()) do
            statistics[tostring(category.id)] = {};
        end

        local index, quantity, category;
        for id in pairs(dbEntry:GetValue(container)) do
            index, quantity = dbEntry:GetValue(container, id);
            category = _G.GetAchievementCategory(id);
            if ( index and category ) then
                table.insert(statistics[tostring(category)], {id=id, order=index, quantity=quantity});
            end
        end
        
        for _, statistic in pairs(statistics) do
            table.sort(statistic, function(a, b) return a.order < b.order end);
        end
        
        local numStatistics;
        table.wipe(counts);
        for _, category in ipairs(GetStatisticCategories()) do
            numStatistics = table.getn(statistics[tostring(category.id)]);
            counts[tostring(category.id)] = (counts[tostring(category.id)] or 0) + numStatistics;
            if ( category.parent ) then
                counts[tostring(category.parent)] = (counts[tostring(category.parent)] or 0) + numStatistics;
            end
        end
     
        local collapsed = false;
        local childCollapsed = false;
        local name, include;
        for _, category in ipairs(GetStatisticCategories()) do
            if ( counts[tostring(category.id)] > 0 ) then
                name = _G.GetCategoryInfo(category.id);
                if ( category.parent ) then
                    if ( not collapsed ) then
                        table.insert(statisticLines, {name=name, id=category.id, isHeader=true, isChild=true, collapsed=category.collapsed});
                    end
                    childCollapsed = collapsed or category.collapsed;
                else
                    table.insert(statisticLines, {name=name, id=category.id, isHeader=true, collapsed=category.collapsed});
                    collapsed = category.collapsed;
                    childCollapsed = false;
                end
                if ( not (collapsed or childCollapsed) ) then
                    for _, statistic in ipairs(statistics[tostring(category.id)]) do
                        _, name = _G.GetAchievementInfo(statistic.id);
                        if ( Armory:GetAchievementFilter() == "" ) then
                            include = true;
                        else
                            include = string.find(strlower(name), strlower(Armory:GetAchievementFilter()), 1, true);
                        end
                        if ( include ) then
                            table.insert(statisticLines, {name=name, id=statistic.id, quantity=statistic.quantity});
                        end
                    end
                end
            end
        end
    end
    
    dirty = false;
    owner = Armory:SelectedCharacter();
    
    return statisticLines;
end

local function SetStatisticsHeaderState(index, collapsed)
    local line = statisticLines[index];

    for _, category in ipairs(GetStatisticCategories()) do
        if ( index == 0 ) then
            category.collapsed = collapsed;
        elseif ( category.id == line.id ) then
            category.collapsed = collapsed;
            break;
        end
    end

    dirty = true;
end

----------------------------------------------------------
-- Statistics Storage
----------------------------------------------------------

local updater = ArmoryBackgroundUpdater:new();
local dbCache = ArmoryDbEntry:new({});
local containerDirty;

function Armory:ClearStatistics()
    self:ClearModuleData(container);
    dirty = true;
end

function Armory:UpdateStatistics(force)
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    elseif ( not (self:HasAchievements() and self:HasStatistics()) ) then
        dbEntry:SetValue(container, nil);
        return;
    end
    
    dirty = dirty or self:IsPlayerSelected();

    if ( not self:IsLocked(container) ) then
        self:Lock(container);
        
        self:PrintDebug("UPDATE", container);

        if ( force ) then
            local id, quantity;
            dbEntry:ClearContainer(container);
            for _, category in ipairs(GetStatisticCategories()) do
                for i = 1, _G.GetCategoryNumAchievements(category.id) do
                    id = _G.GetAchievementInfo(category.id, i);
                    if ( id ) then
                        quantity = _G.GetStatistic(id);
                        if ( quantity and quantity ~= "--" ) then
                            dbEntry:SetValue(2, container, tostring(id), i, quantity);
                        end
                    end
                end
            end
            self:Unlock(container);
        else
            updater:Start(
                function(updater)
                    local id, quantity;
                    local start = time();
                    containerDirty = false;
                    for _, category in ipairs(GetStatisticCategories()) do
                        for i = 1, _G.GetCategoryNumAchievements(category.id) do
                            id = _G.GetAchievementInfo(category.id, i);
                            quantity = id and _G.GetStatistic(id);
                            if ( quantity and quantity ~= "--" ) then
                                dbCache:SetValue(2, container, tostring(id), i, quantity);
                            end
                            updater:Suspend();
                        end
                    end

                    dbEntry:ClearContainer(container);
                    self:CopyTable(dbCache.db, dbEntry.db);
                    dbCache:ClearContainer(container);   

                    self:PrintDebug(container, "updated in", time() - start, "s.");
                    self:Unlock(container);

                    if ( containerDirty ) then
                        self:ExecuteDelayed(30, self.UpdateStatistics, self, nil);
                    end
                end
            );
        end
    else
        containerDirty = true;
        self:PrintDebug("LOCKED", container);
    end
end

----------------------------------------------------------
-- Statistics Interface
----------------------------------------------------------

function Armory:ExpandStatisticsHeader(index)
    SetStatisticsHeaderState(index, false);
end

function Armory:CollapseStatisticsHeader(index)
    SetStatisticsHeaderState(index, true);
end

function Armory:GetNumStatistics()
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetStatisticLines();
    end
    return #statisticLines;
end

function Armory:GetStatisticInfo(index)
    local numLines = self:GetNumStatistics();
    if ( index > 0 and index <= numLines ) then
        local line = statisticLines[index];
        return line.id, line.name, line.isHeader, line.isChild, line.collapsed, line.quantity;
    end
end

function Armory:GetStatistic(id)
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry ) then
        local _, quantity = dbEntry:GetValue(container, tostring(id));
        return quantity or "--";
    end
end
