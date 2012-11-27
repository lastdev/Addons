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
local container = "Quests";

local selectedQuestLine = 0;
local questLogFilter = "";

----------------------------------------------------------
-- Quests Internals
----------------------------------------------------------

local questLines = {};
local dirty = true;
local owner = "";

local function GetQuestLines()
    local dbEntry = Armory.selectedDbBaseEntry;

    table.wipe(questLines);
    
    if ( dbEntry ) then
        local count = dbEntry:GetNumValues(container);
        local collapsed = false;
        local hasItems = (questLogFilter == "");
        local include, text, numItems;
        
        for i = 1, count do
            local name, _, _, _, isHeader, _, _, _, questID = dbEntry:GetValue(container, i, "Info");
            local isCollapsed = Armory:GetHeaderLineState(container, name);
            if ( isHeader ) then
                table.insert(questLines, i);
                collapsed = isCollapsed;
            elseif ( not collapsed ) then
                if ( questLogFilter == "" ) then
                    include = true;
                else
                    local id = tostring(questID);
                    text = name.."\t"..dbEntry:GetValue(container, id, "Text");
                    numItems = dbEntry:GetNumValues(container, id, "LeaderBoards");
                    for index = 1, numItems do
                        text = text.."\t"..(dbEntry:GetValue(container, id, "LeaderBoards", index) or "");
                    end
                    numItems = dbEntry:GetNumValues(container, id, "Rewards");
                    for index = 1, numItems do
                        text = text.."\t"..(dbEntry:GetValue(container, id, "Rewards", index) or "");
                    end
                    _, name = dbEntry:GetValue(container, id, "RewardSpell");
                    if ( name ) then
                        text = text.."\t"..name;
                    end
                    include = string.find(strlower(text), strlower(questLogFilter), 1, true);
                end
                if ( include ) then
                    hasItems = true;
                    table.insert(questLines, i);
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

local function GetQuestLineValue(index, key, subkey)
    local dbEntry = Armory.selectedDbBaseEntry;
    local numLines = Armory:GetNumQuestLogEntries();
    if ( dbEntry and index > 0 and index <= numLines ) then
        local _, _, _, _, _, _, _, _, questID = dbEntry:GetValue(container, questLines[index], "Info");
        if ( subkey ) then
            return dbEntry:GetValue(container, tostring(questID), key, subkey);
        elseif ( key ) then
            return dbEntry:GetValue(container, tostring(questID), key);
        else
            return dbEntry:GetValue(container, questLines[index], "Info");
        end
    end
end

local function UpdateQuestHeaderState(index, isCollapsed)
    local dbEntry = Armory.selectedDbBaseEntry;

    if ( dbEntry ) then
        if ( index == 0 ) then
            for i = 1, dbEntry:GetNumValues(container) do
                local name, _, _, _, isHeader = dbEntry:GetValue(container, i, "Info");
                if ( isHeader ) then
                    Armory:SetHeaderLineState(container, name, isCollapsed);
                end
            end
        else
            local numLines = Armory:GetNumQuestLogEntries();
            if ( index > 0 and index <= numLines ) then
                local name = dbEntry:GetValue(container, questLines[index], "Info");
                Armory:SetHeaderLineState(container, name, isCollapsed);
            end
        end
    end
    
    dirty = true;
end

----------------------------------------------------------
-- Quests Storage
----------------------------------------------------------

function Armory:QuestsExists()
    local dbEntry = self.playerDbBaseEntry;
    return dbEntry and dbEntry:Contains(container);
end

function Armory:ClearQuests()
    self:ClearModuleData(container);
    dirty = true;
end

local retries = 0;
function Armory:UpdateQuests()
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end

    if ( not self:IsLocked(container) ) then
        if ( self.ignoreQuestUpdate ) then
            self.ignoreQuestUpdate = false;
            return;
        end
        
        self:Lock(container);

        self:PrintDebug("UPDATE", container);

        if ( self:HasQuestLog() ) then
            local success, dataMissing;
        
            local _, numQuests = _G.GetNumQuestLogEntries();
            local currentQuest = _G.GetQuestLogSelection();

            -- store the complete (expanded) list
            local funcNumLines = _G.GetNumQuestLogEntries;
            local funcGetLineInfo = _G.GetQuestLogTitle;
            local funcGetLineState = function(index)
                local _, _, _, _, isHeader, isCollapsed = _G.GetQuestLogTitle(index);
                return isHeader, not isCollapsed;
            end;
            local funcExpand = _G.ExpandQuestHeader;
            local funcCollapse = _G.CollapseQuestHeader;
            local funcSelect = function(index)
                _G.SelectQuestLogEntry(index);
                ProcessQuestLogRewardFactions();
            end;
            local funcAdditionalInfo = function(index)
                local link = _G.GetQuestLink(index);
                local _, id = self:GetLinkId(link);
                local info = dbEntry:SelectContainer(container, id);
                info.Link = link;
                info.Text = _G.GetQuestLogQuestText();
                if ( _G.IsCurrentQuestFailed() ) then
                    info.Failed = _G.IsCurrentQuestFailed();
                end
                if ( _G.GetQuestLogTimeLeft() ) then
                    info.TimeLeft = dbEntry.Save(_G.GetQuestLogTimeLeft(), time()); 
                end
                if ( _G.GetQuestLogRequiredMoney() > 0 ) then
                    info.RequiredMoney = _G.GetQuestLogRequiredMoney();
                end
                if ( _G.GetQuestLogRewardMoney() > 0 ) then
                    info.RewardMoney = _G.GetQuestLogRewardMoney();
                end
                if ( _G.GetQuestLogRewardSpell() ) then
                    info.RewardSpell = dbEntry.Save(_G.GetQuestLogRewardSpell());
                end
                if ( _G.GetQuestLogRewardTalents() > 0 ) then
                    info.RewardTalents = _G.GetQuestLogRewardTalents();
                end
                if ( _G.GetQuestLogRewardXP() > 0 ) then
                    info.RewardXP = _G.GetQuestLogRewardXP();
                end
                if ( _G.GetQuestLogRewardSkillPoints() ) then
                    info.RewardSkillPoints = dbEntry.Save(_G.GetQuestLogRewardSkillPoints());
                end
                if ( _G.GetQuestLogSpellLink() ) then
                    info.SpellLink = _G.GetQuestLogSpellLink();
                end
                if ( _G.GetQuestLogRewardTitle() ) then
                    info.RewardTitle = _G.GetQuestLogRewardTitle();
                end
                if ( _G.GetQuestLogGroupNum() > 0 ) then
                    info.GroupNum = _G.GetQuestLogGroupNum();
                end
                if ( _G.GetQuestLogCriteriaSpell() ) then
                    info.CriteriaSpell = dbEntry.Save(_G.GetQuestLogCriteriaSpell());
                end
                if ( _G.GetNumQuestLeaderBoards() > 0 ) then
                    info.LeaderBoards = {};
                    for i = 1, _G.GetNumQuestLeaderBoards() do
                        info.LeaderBoards[i] = dbEntry.Save(_G.GetQuestLogLeaderBoard(i));
                    end
                end
                if ( _G.GetNumQuestLogRewards() > 0 ) then
                    info.Rewards = {};
                    for i = 1, _G.GetNumQuestLogRewards() do
                        local name, texture, numItems, quality, isUsable = _G.GetQuestLogRewardInfo(i);
                        link = _G.GetQuestLogItemLink("reward", i);
                        info.Rewards[i] = dbEntry.Save(name, texture, numItems, quality, isUsable, link);
                        if ( not link ) then
                            dataMissing = true;
                        end
                    end
                end
                if ( _G.GetNumQuestLogChoices() > 0 ) then
                    info.Choices = {};
                    for i = 1, _G.GetNumQuestLogChoices() do
                        local name, texture, numItems, quality, isUsable = _G.GetQuestLogChoiceInfo(i);
                        link = _G.GetQuestLogItemLink("choice", i);
                        info.Choices[i] = dbEntry.Save(name, texture, numItems, quality, isUsable, link);
                        if ( not link ) then
                            dataMissing = true;
                        end
                    end
                end
                if ( _G.GetNumQuestLogRewardCurrencies() > 0 ) then
                    info.Currencies = {};
                    for i = 1, _G.GetNumQuestLogRewardCurrencies() do
                        info.Currencies[i] = dbEntry.Save(_G.GetQuestLogRewardCurrencyInfo(i));
                    end
                end
                if ( _G.GetNumQuestLogRewardFactions() > 0 ) then
                    info.Factions = {};
                    for i = 1, _G.GetNumQuestLogRewardFactions() do
                        info.Factions[i] = dbEntry.Save(_G.GetQuestLogRewardFactionInfo(i));
                    end
                end
                return id;
            end;
            
            -- LightHeaded hooks SelectQuestLogEntry
            local stubbed;
            if ( LightHeaded ) then
                stubbed = LightHeaded.GetCurrentQID;
                LightHeaded.GetCurrentQID = function() return nil; end;
            end
            
            dbEntry:ClearContainer(container);
           
            if ( retries < 3 ) then
                -- if expand/collapse has been called a QUEST_LOG_UPDATE event will be fired immediately after the scan has been completed
                success, self.ignoreQuestUpdate = dbEntry:SetExpandableListValues(container, funcNumLines, funcGetLineState, funcGetLineInfo, funcExpand, funcCollapse, funcAdditionalInfo, funcSelect);
                if ( dataMissing or not success ) then
                    retries = retries + 1;
                    self:PrintDebug("Update failed; executing again...", retries);
                    self:Execute(function () Armory:UpdateQuests() end);
                else
                    retries = 0;
                end
            else
                retries = 0;
            end

            dbEntry:SetValue(2, container, "NumQuests", numQuests);

            _G.SelectQuestLogEntry(currentQuest);
            
            if ( stubbed ) then
                LightHeaded.GetCurrentQID = stubbed;
            end
        else
            dbEntry:SetValue(container, nil);
        end

        dirty = dirty or self:IsPlayerSelected();
        
        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

----------------------------------------------------------
-- Quests Interface
----------------------------------------------------------

function Armory:GetQuestLogIndexByName(name)
    local dbEntry = self.playerDbBaseEntry;
    if ( dbEntry and name ) then
        local count = dbEntry:GetNumValues(container);
        for i = 1, count do
            if ( strtrim(name) == dbEntry:GetValue(container, i, "Info") ) then
                return i;
            end
        end
    end
end

function Armory:GetQuestHeader(index)
    local dbEntry = self.playerDbBaseEntry;
    if ( dbEntry ) then
        for i = index, 1, -1 do
            local title, _, _, _, isHeader = dbEntry:GetValue(container, i, "Info");
            if ( isHeader ) then
                return title;
            end
        end
    end
    return UNKNOWN;
end

function Armory:IsOnQuest(id)
    local dbEntry = self.selectedDbBaseEntry;
    return dbEntry and dbEntry:Contains(container, id);
end

function Armory:GetNumQuestLogEntries()
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetQuestLines();
    end
    local dbEntry = self.selectedDbBaseEntry;
    local numQuests = (dbEntry and dbEntry:GetValue(container, "NumQuests")) or 0;
    return #questLines, numQuests;
end

function Armory:GetQuestLogTitle(index)
    local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, startEvent, displayQuestID = GetQuestLineValue(index);
    isCollapsed = self:GetHeaderLineState(container, title);
    return title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, displayQuestID;
end

function Armory:ExpandQuestHeader(index)
    UpdateQuestHeaderState(index, false);
end

function Armory:CollapseQuestHeader(index)
    UpdateQuestHeaderState(index, true);
end

function Armory:GetQuestLink(index)
    return GetQuestLineValue(index, "Link");
end

function Armory:GetQuestLogSelection()
    return selectedQuestLine;
end

function Armory:SelectQuestLogEntry(index)
    selectedQuestLine = index;
end

function Armory:IsCurrentQuestFailed()
    return GetQuestLineValue(selectedQuestLine, "Failed");
end

function Armory:GetQuestLogQuestText()
    return GetQuestLineValue(selectedQuestLine, "Text");
end

function Armory:GetQuestLogTimeLeft()
    local timeLeft, timestamp = GetQuestLineValue(selectedQuestLine, "TimeLeft");

    if ( timeLeft ) then
        timeLeft = timeLeft - (time() - timestamp);
        if ( timeLeft < 0 ) then
            timeLeft = 0;
        end
    end
    return timeLeft;
end

function Armory:GetQuestLogRequiredMoney()
    return GetQuestLineValue(selectedQuestLine, "RequiredMoney") or 0;
end

function Armory:GetQuestLogRewardMoney()
    return GetQuestLineValue(selectedQuestLine, "RewardMoney") or 0;
end

function Armory:GetQuestLogRewardSpell()
    return GetQuestLineValue(selectedQuestLine, "RewardSpell");
end

function Armory:GetQuestLogRewardTalents()
    return GetQuestLineValue(selectedQuestLine, "RewardTalents") or 0;
end

function Armory:GetQuestLogRewardXP()
    return GetQuestLineValue(selectedQuestLine, "RewardXP") or 0;
end

function Armory:GetQuestLogRewardSkillPoints()
    return GetQuestLineValue(selectedQuestLine, "RewardSkillPoints");
end

function Armory:GetQuestLogRewardTitle()
    return GetQuestLineValue(selectedQuestLine, "RewardTitle");
end

function Armory:GetQuestLogSpellLink()
    return GetQuestLineValue(selectedQuestLine, "SpellLink");
end

function Armory:GetQuestLogGroupNum()
    return GetQuestLineValue(selectedQuestLine, "GroupNum") or 0;
end

function Armory:GetQuestLogCriteriaSpell()
    return GetQuestLineValue(selectedQuestLine, "CriteriaSpell");
end

function Armory:GetNumQuestLeaderBoards()
    local leaderBoards = GetQuestLineValue(selectedQuestLine, "LeaderBoards");
    if ( leaderBoards ) then
        return #leaderBoards;
    end
    return 0;
end

function Armory:GetQuestLogLeaderBoard(id)
    return GetQuestLineValue(selectedQuestLine, "LeaderBoards", id);
end

function Armory:GetNumQuestLogRewards()
    local rewards = GetQuestLineValue(selectedQuestLine, "Rewards");
    if ( rewards ) then
        return #rewards;
    end
    return 0;
end

function Armory:GetQuestLogRewardInfo(id)
    return GetQuestLineValue(selectedQuestLine, "Rewards", id);
end

function Armory:GetNumQuestLogChoices()
    local choices = GetQuestLineValue(selectedQuestLine, "Choices");
    if ( choices ) then
        return #choices;
    end
    return 0;
end

function Armory:GetQuestLogChoiceInfo(id)
    return GetQuestLineValue(selectedQuestLine, "Choices", id);
end

function Armory:GetNumQuestLogRewardCurrencies()
    local currencies = GetQuestLineValue(selectedQuestLine, "Currencies");
    if ( currencies ) then
        return #currencies;
    end
    return 0;
end

function Armory:GetQuestLogRewardCurrencyInfo(id)
    return GetQuestLineValue(selectedQuestLine, "Currencies", id);
end

function Armory:GetNumQuestLogRewardFactions()
    local factions = GetQuestLineValue(selectedQuestLine, "Factions");
    if ( factions ) then
        return #factions;
    end
    return 0;
end

function Armory:GetQuestLogRewardFactionInfo(id)
    return GetQuestLineValue(selectedQuestLine, "Factions", id);
end

function Armory:GetQuestLogItemLink(itemType, id)
    local link;
    if ( itemType == "reward" ) then
        _, _, _, _, _, link = self:GetQuestLogRewardInfo(id);
    elseif ( itemType == "choice" ) then
        _, _, _, _, _, link = self:GetQuestLogChoiceInfo(id);
    end
    return link;
end

function Armory:SetQuestLogFilter(text)
    local refresh = (questLogFilter ~= text);
    questLogFilter = text;
    return refresh;
end

function Armory:GetQuestLogFilter()
    return questLogFilter;
end

----------------------------------------------------------
-- Find Methods
----------------------------------------------------------

function Armory:FindQuest(...)
    local dbEntry = self.selectedDbBaseEntry;
    local list = {};

    if ( dbEntry ) then
        local numEntries = dbEntry:GetNumValues(container);
        if ( numEntries ) then
            local name, level, isHeader, link, text, questID;
            for index = 1, numEntries do
                name, level, _, _, isHeader, _, _, _, questID = dbEntry:GetValue(container, index, "Info");
                if ( not isHeader ) then
                    link = dbEntry:GetValue(container, tostring(questID), "Link");
                    if ( self:GetConfigExtendedSearch() ) then
                        text = self:GetTextFromLink(link);
                    else
                        text = name;
                    end
                    if ( self:FindTextParts(text, ...) ) then
                        name = self:HexColor(ArmoryGetDifficultyColor(level))..name..FONT_COLOR_CODE_CLOSE;
                        table.insert(list, {label=QUEST_LOG, name=name, link=link});
                    end
                end
            end
        end
    end
    
    return list;
end

function Armory:FindQuestItem(itemList, ...)
    local dbEntry = self.selectedDbBaseEntry;
    local list = itemList or {};
    
    if ( dbEntry ) then
        local numEntries = dbEntry:GetNumValues(container);
        if ( numEntries ) then
            local questLogTitleText, level, isHeader;
            local text, label, name, link, id;

            for index = 1, numEntries do
                questLogTitleText, level, _, _, isHeader, _, _, _, questID = dbEntry:GetValue(container, index, "Info");
                if ( not isHeader ) then
                    id = tostring(questID);
                    label = ARMORY_CMD_FIND_QUEST_REWARD.." "..self:HexColor(ArmoryGetDifficultyColor(level))..questLogTitleText..FONT_COLOR_CODE_CLOSE;
                    for _, key in ipairs({"Choices", "Rewards"}) do
                        for i = 1, dbEntry:GetNumValues(container, id, key) do
                            name, _, _, _, _, link = dbEntry:GetValue(container, id, key, i);
                            if ( self:GetConfigExtendedSearch() ) then
                                text = self:GetTextFromLink(link);
                            else
                                text = name;
                            end
                            if ( self:FindTextParts(text, ...) ) then
                                table.insert(list, {label=label, name=name, link=link});
                            end
                        end
                    end
                end
            end
        end
    end
    
    return list;
end

function Armory:FindQuestSpell(spellList, ...)
    local dbEntry = self.selectedDbBaseEntry;
    local list = spellList or {};

    if ( dbEntry ) then
        local numEntries = dbEntry:GetNumValues(container);
        if ( numEntries ) then
            local questLogTitleText, level, isHeader;
            local text, label, name, link, id;

            for index = 1, numEntries do
                questLogTitleText, level, _, _, isHeader, _, _, _, questID = dbEntry:GetValue(container, index, "Info");
                if ( not isHeader ) then
                    id = tostring(questID);
                    if ( dbEntry:GetValue(container, id, "RewardSpell") ) then
                        _, name = dbEntry:GetValue(container, id, "RewardSpell");
                        link = dbEntry:GetValue(container, id, "SpellLink");
                        if ( self:GetConfigExtendedSearch() ) then
                            text = self:GetTextFromLink(link);
                        else
                            text = name;
                        end
                        if ( self:FindTextParts(text, ...) ) then
                            label = ARMORY_CMD_FIND_QUEST_REWARD.." "..self:HexColor(ArmoryGetDifficultyColor(level))..questLogTitleText..FONT_COLOR_CODE_CLOSE;
                            table.insert(list, {label=label, name=name, link=link});
                        end
                    end
                end
            end
        end
    end
    
    return list;
end