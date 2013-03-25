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
local container = "Achievements";

local achievementFilter = "";

----------------------------------------------------------
-- Achievement Internals
----------------------------------------------------------

local categories;
local function GetAchievementCategories()
    if ( not categories ) then
        categories = {};
        
        local list = _G.GetCategoryList();
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

local achievementLines = {};
local dirty = true;
local owner = "";
local achievements = {};
local counts = {};

local function GetAchievementLines()
    local dbEntry = Armory.selectedDbBaseEntry;

    table.wipe(achievements);
    table.wipe(achievementLines);
    
    if ( dbEntry and dbEntry:Contains(container) ) then
        for _, category in ipairs(GetAchievementCategories()) do
            achievements[tostring(category.id)] = {};
        end

        for id in pairs(dbEntry:GetValue(container)) do
            local index = dbEntry:GetValue(container, id);
            local category = _G.GetAchievementCategory(id);
            if ( index and category ) then
                table.insert(achievements[tostring(category)], {id=id, order=index});
            end
        end
        
        for _, achievement in pairs(achievements) do
            table.sort(achievement, function(a, b) return a.order < b.order end);
        end
        
        local numAchievements;
        table.wipe(counts);
        for _, category in ipairs(GetAchievementCategories()) do
            numAchievements = table.getn(achievements[tostring(category.id)]);
            counts[tostring(category.id)] = (counts[tostring(category.id)] or 0) + numAchievements;
            if ( category.parent ) then
                counts[tostring(category.parent)] = (counts[tostring(category.parent)] or 0) + numAchievements;
            end
        end
     
        local collapsed = false;
        local childCollapsed = false;
        local name, include;
        for _, category in ipairs(GetAchievementCategories()) do
            if ( counts[tostring(category.id)] > 0 ) then
                name = _G.GetCategoryInfo(category.id);
                if ( category.parent ) then
                    if ( not collapsed ) then
                        table.insert(achievementLines, {name=name, id=category.id, isHeader=true, isChild=true, collapsed=category.collapsed});
                    end
                    childCollapsed = collapsed or category.collapsed;
                else
                    table.insert(achievementLines, {name=name, id=category.id, isHeader=true, collapsed=category.collapsed});
                    collapsed = category.collapsed;
                    childCollapsed = false;
                end
                if ( not (collapsed or childCollapsed) ) then
                    for _, achievement in ipairs(achievements[tostring(category.id)]) do
                        _, name = _G.GetAchievementInfo(achievement.id);
                        if ( achievementFilter == "" ) then
                            include = true;
                        else
                            include = string.find(strlower(name), strlower(achievementFilter), 1, true);
                        end
                        if ( include ) then
                            table.insert(achievementLines, {name=name, id=achievement.id});
                        end
                    end
                end
            end
        end
    end
    
    dirty = false;
    owner = Armory:SelectedCharacter();
    
    return achievementLines;
end

local function SetAchievementHeaderState(index, collapsed)
    local line = achievementLines[index];

    for _, category in ipairs(GetAchievementCategories()) do
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
-- Achievement Storage
----------------------------------------------------------

local updater = ArmoryBackgroundUpdater:new();
local dbCache = ArmoryDbEntry:new({});
local containerDirty;

function Armory:AchievementsExists()
    local dbEntry = self.playerDbBaseEntry;
    return dbEntry and dbEntry:Contains(container);
end

function Armory:ClearAchievements()
    self:ClearModuleData(container);
    dirty = true;
end

function Armory:UpdateAchievements(force)
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    elseif ( not self:HasAchievements() ) then
        dbEntry:SetValue(container, nil);
        return;
    end

    dirty = dirty or self:IsPlayerSelected();

    if ( not self:IsLocked(container) ) then
        self:Lock(container);
        
        self:PrintDebug("UPDATE", container);

        if ( force ) then
            dbEntry:ClearContainer(container);
            for _, category in ipairs(GetAchievementCategories()) do
                for i = 1, _G.GetCategoryNumAchievements(category.id) do
                    self:UpdateAchievement(category.id, i);
                end
            end
            self:Unlock(container);
        else
            updater:Start(
                function(updater)
                    local start = time();
                    containerDirty = false;
                    for _, category in ipairs(GetAchievementCategories()) do
                        for i = 1, _G.GetCategoryNumAchievements(category.id) do
                            self:UpdateAchievement(category.id, i, dbCache);
                            updater:Suspend();
                        end
                    end
                    
                    dbEntry:ClearContainer(container);
                    self:CopyTable(dbCache.db, dbEntry.db);
                    dbCache:ClearContainer(container);
                    
                    self:PrintDebug(container, "updated in", time() - start, "s.");
                    self:Unlock(container);
                    
                    if ( containerDirty ) then
                        self:ExecuteDelayed(30, self.UpdateAchievements, self, nil);
                    end
                end
            );
        end
    else
        containerDirty = true;
        self:PrintDebug("LOCKED", container);
    end
end

function Armory:UpdateAchievement(achievementId, index, dbEntry)
    if ( not self:HasAchievements() ) then
        return;
    elseif ( not dbEntry ) then
        dbEntry = self.playerDbBaseEntry;
        if ( not dbEntry ) then
            return;
        end
    end

    local id, _, _, completed, _, _, _, _, flags = _G.GetAchievementInfo(achievementId, index);
    if ( not id ) then
        return;
    elseif ( bit.band(flags, ACHIEVEMENT_FLAGS_ACCOUNT) == ACHIEVEMENT_FLAGS_ACCOUNT ) then
        return;
    end

    local key = tostring(id);
    local quantity = 0;
    local totalQuantity = 0;
    local started, isMoney;

    if ( not completed ) then
        for i = 1, _G.GetAchievementNumCriteria(id) do
            local _, criteriaType, completed, quantityNumber, reqQuantity, _, flags, _, quantityString = _G.GetAchievementCriteriaInfo(id, i);
            if ( criteriaType ~= CRITERIA_TYPE_ACHIEVEMENT ) then            
                if ( bit.band(flags, EVALUATION_TREE_FLAG_PROGRESS_BAR) == EVALUATION_TREE_FLAG_PROGRESS_BAR ) then
                    if ( quantityString and quantityString:find("Gold") ) then
                        quantityNumber = floor(quantityNumber / 10000);
                        reqQuantity = floor(reqQuantity / 10000);
                    end
                    totalQuantity = totalQuantity + reqQuantity;
                    quantity = quantity + quantityNumber;
                    if ( quantityNumber > 0 ) then
                        started = true;
                    end
                elseif ( completed ) then
                    totalQuantity = totalQuantity + 1;
                    quantity = quantity + 1;
                    started = true;
                else
                    totalQuantity = totalQuantity + 1;
                end
            end
        end
    end
    
    if ( started ) then
        dbEntry:SetValue(2, container, key, index, quantity, totalQuantity, _G.GetAchievementLink(id));
    end
end

function Armory:RemoveAchievement(achievementId)
    local key = tostring(achievementId);
    local currentProfile = self:CurrentProfile();
    for _, profile in ipairs(self:Profiles()) do
        self:SelectProfile(profile):SetValue(2, container, key, nil);
    end
    self:SelectProfile(currentProfile);
    dirty = true;
end


----------------------------------------------------------
-- Achievement Interface
----------------------------------------------------------

function Armory:GetNumAchievements()
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetAchievementLines();
    end
    return #achievementLines;
end

function Armory:GetAchievementInfo(index)
    local numLines = self:GetNumAchievements();
    if ( index > 0 and index <= numLines ) then
        local line = achievementLines[index];
        local quantity, reqQuantity, link = self:GetAchievement(line.id);
        return line.id, line.name, line.isHeader, line.isChild, line.collapsed, quantity, reqQuantity, link;
    end
end

function Armory:ExpandAchievementHeader(index)
    SetAchievementHeaderState(index, false);
end

function Armory:CollapseAchievementHeader(index)
    SetAchievementHeaderState(index, true);
end

function Armory:SetAchievementFilter(text)
    local refresh = (achievementFilter ~= text);
    achievementFilter = text;
    return refresh;
end

function Armory:GetAchievementFilter()
    return achievementFilter;
end

function Armory:GetAchievement(id)
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry ) then
        local _, quantity, reqQuantity, link = dbEntry:GetValue(container, tostring(id));
        return quantity, reqQuantity, link;
    end
end


----------------------------------------------------------
-- Find Methods
----------------------------------------------------------

--[[  
function Armory:FindAchievement(...)
    local dbEntry = self.selectedDbBaseEntry;
    local list = {};

    if ( dbEntry ) then
        local achievements = dbEntry:GetValue(container);
        if ( achievements ) then
            local link, name, text;
            for id in pairs(achievements) do
                _, link = dbEntry:GetValue(container, id);
                name = self:GetNameFromLink(link);
                if ( self:GetConfigExtendedSearch() ) then
                    text = self:GetTextFromLink(link);
                else
                    text = name;
                end
                if ( self:FindTextParts(text, ...) ) then
                    table.insert(list, {label=ACHIEVEMENTS, name=name, link=link});
                end
            end
        end
    end
    
    return list;
end
--]]
