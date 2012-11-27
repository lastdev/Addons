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
local container = "QuestHistory";

local groupByDate;

----------------------------------------------------------
-- QuestHistory Internals
----------------------------------------------------------

local function IsRecentQuest(dbEntry, title)
    local _, timestamp = dbEntry:GetValue(container, title);
    return time() - timestamp < 7 * 24*60*60;
end

local groups = {};
local historyLines = {};
local questLines = {};
local dirty = true;
local owner = "";

local function GetQuestLines()
    local dbEntry = Armory.selectedDbBaseEntry;

    table.wipe(questLines);

    if ( dbEntry and dbEntry:Contains(container) ) then
        local questLogFilter = Armory:GetQuestLogFilter();
        local history = dbEntry:SelectContainer(container);
        local collapsed = false;
        local hasItems = (questLogFilter == "");
        local include;

        table.wipe(groups);        
        table.wipe(historyLines);

        local header, timestamp, isWeekly, tag;
        local _, month, day, year = CalendarGetDate();
        local today = Armory:GetLocalTimeAsServerTime(Armory:MakeDate(day, month, year));
        local weekday, hour, minute;
        local questDate, questTime, days, key;
        for title in pairs(history) do
            if ( IsRecentQuest(dbEntry, title) ) then
                header, timestamp, isWeekly = dbEntry:GetValue(container, title);
                weekday, _, day, year, month, hour, minute = Armory:GetFullDate(Armory:GetLocalTimeAsServerTime(timestamp));
                questDate = Armory:GetLocalTimeAsServerTime(Armory:MakeDate(day, month, year));
                questTime = GameTime_GetFormattedTime(hour, minute, true);
                days = floor(today / 24*60*60) - floor(questDate / 24*60*60);
                if ( days == 0 ) then
                    tag = HONOR_TODAY;
                elseif ( days == 1 ) then
                    tag = HONOR_YESTERDAY;
                else
                    tag = weekday;
                end
                if ( groupByDate ) then
                    title = format("%s - %s", header, title);
                    header = tag;
                    key = tostring(questDate);
                    tag = questTime;
                else
                    key = header;
                    tag = tag..", "..questTime;
                end
                if ( not historyLines[key] ) then
                    historyLines[key] = {};
                    table.insert(groups, key);
                end
                table.insert(historyLines[key], {title=title, header=header, tag=tag, trivial=(not isWeekly and days > 0), time=timestamp});
            end
        end
        
        if ( groupByDate ) then
            table.sort(groups, function(a, b) return a > b end);
        else
            table.sort(groups);
        end
        for _, key in ipairs(groups) do
            header = historyLines[key][1].header;
            table.insert(questLines, header);
            if ( not Armory:GetHeaderLineState(container, header) ) then
                table.sort(historyLines[key], function(a, b) return a.time > b.time end);
                for _, v in ipairs(historyLines[key]) do
                    if ( questLogFilter == "" ) then
                        include = true;
                    else
                        include = string.find(strlower(v.title), strlower(questLogFilter), 1, true);
                    end
                    if ( include ) then
                        hasItems = true;
                        table.insert(questLines, v);
                    end
                end
            end
        end
        
        if ( not hasItems ) then
            table.wipe(questLines);
        end
    end
    
    dirty = false;
    owner = Armory:SelectedCharacter();
    
    return questLines;        
end

local function UpdateQuestHeaderState(index, isCollapsed)
    if ( index == 0 ) then
        for _, v in ipairs(questLines) do
            if ( type(v) == "string" ) then
                Armory:SetHeaderLineState(container, v, isCollapsed);
            end
        end
    else
        if ( type(questLines[index]) == "string" ) then
            Armory:SetHeaderLineState(container, questLines[index], isCollapsed);
        end
    end
    
    dirty = true;
end

----------------------------------------------------------
-- QuestHistory Storage
----------------------------------------------------------

local randomBG;

local function SaveHistoryEntry(title, header, isWeekly)
    local dbEntry = Armory.playerDbBaseEntry;
    if ( dbEntry and title ) then
        dbEntry:SetValue(2, container, title, header, time(), isWeekly);
    end
end

function Armory:SetRandomBattleground()
    for i = 1, GetMaxBattlefieldID() do
        local status, name = GetBattlefieldStatus(i);
        if ( name == RANDOM_BATTLEGROUND ) then
            -- status will be "none" if BG or queue is left
            randomBG = (status == "confirm");
            break;
        end
    end
end

function Armory:ClearQuestHistory()
    self:ClearModuleData(container);
    dirty = true;
end

function Armory:UpdateQuestHistory(historyType)
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end
    
    if ( self:HasQuestLog() ) then
        local title, header, isWeekly;
        if ( historyType == "quest" ) then
            local index;
            if ( QuestIsWeekly() ) then
                isWeekly = 1;
            elseif ( not QuestIsDaily() ) then
                return;
            end
            title = GetTitleText();
            index = self:GetQuestLogIndexByName(title);
            header = self:GetQuestHeader(index - 1);
            SaveHistoryEntry(title, header, isWeekly);
            
        elseif ( historyType == "raid" ) then
            local name, typeID = GetLFGCompletionReward();
            title = name;
            if ( typeID == TYPEID_HEROIC_DIFFICULTY ) then
                header = LFG_TYPE_HEROIC_DUNGEON;
            else
                header = LFG_TYPE_RANDOM_DUNGEON;
            end
            SaveHistoryEntry(title, header);
            
        elseif ( historyType == "battle" ) then
            local winner = GetBattlefieldWinner();
            local faction = UnitFactionGroup("player");
            if ( faction == "Horde" and winner ~= 0 ) then
                return;
            elseif ( faction == "Alliance" and winner ~= 1 ) then
                return;
            elseif ( faction == "Neutral" ) then
				return;
            end
            for i = 1, GetMaxBattlefieldID() do
                local status, name = GetBattlefieldStatus(i);
                if ( status == "active" ) then
                    title = name;
                    break;
                end
            end
            if ( title ) then
                if ( randomBG ) then
                    SaveHistoryEntry(title, BATTLEGROUND);
                end
                for i = 1, GetNumBattlegroundTypes() do
                    local name, _, isHoliday = GetBattlegroundInfo(i);
                    if ( name == title and isHoliday ) then
                        SaveHistoryEntry(BATTLEGROUND_HOLIDAY, BATTLEGROUND);
                        break;
                    end
                end
            end

        end
        
        self:PrintDebug("UPDATE", container);
        
        local history = dbEntry:SelectContainer(container);
        for title in pairs(history) do
            if ( not IsRecentQuest(dbEntry, title) ) then
                dbEntry:SetValue(2, container, title, nil);
            end
        end
    else
        dbEntry:SetValue(container, nil);
    end
    
    dirty = dirty or self:IsPlayerSelected();
end

----------------------------------------------------------
-- QuestHistory Interface
----------------------------------------------------------

function Armory:GetNumQuestHistoryEntries()
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetQuestLines();
    end
    return #questLines;
end

function Armory:GetQuestHistoryTitle(index)
    local value = questLines[index];
    local isHeader = type(value) == "string";
    local title = UNKNOWN;
    local tag = "";
    local label = "difficult";
    local isCollapsed;
    if ( isHeader ) then
        title = value;
        isCollapsed = self:GetHeaderLineState(container, value);
        label = "header";
    elseif ( type(value) == "table" ) then
        title = value.title;
        tag = value.tag;
        if ( value.trivial ) then
            label = "trivial";
        end
    end
    return title, isHeader, isCollapsed, tag, label;
end

function Armory:ExpandQuestHistoryHeader(index)
    UpdateQuestHeaderState(index, false);
end

function Armory:CollapseQuestHistoryHeader(index)
    UpdateQuestHeaderState(index, true);
end

function Armory:SetQuestHistoryGroupByDate(checked)
    groupByDate = checked;
    dirty = true;
end