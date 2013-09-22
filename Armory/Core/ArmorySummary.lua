--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 590 2013-03-11T20:16:07Z
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

local expiredMail;
local summary = {};

local VALOR_TIER1_LFG_ID = 301;

local function SummaryAutoHide(parent)
    if ( Armory.summary.locked ) then
        Armory.summary:SetAutoHideDelay(nil);
    else
        Armory.summary:SetAutoHideDelay(0.5, parent or Armory.summary.parent);
    end
end

local function SummaryHideDetail(currentTooltip)
    for key, tooltip in Armory.qtip:IterateTooltips() do
        if ( #key > 13 and key:sub(1, 13) == "ArmorySummary" and (not currentTooltip or currentTooltip:GetName() ~= key) ) then
            tooltip:Hide();
        end
    end
end

local function SetAnchor(tooltip, frame, hOffset, vOffset)
    local x, y = frame:GetCenter();
    local hAnchor, vAnchor;
    if ( x < UIParent:GetWidth() / 2 ) then
        hAnchor = "LEFT";
    else
        hAnchor = "RIGHT";
        hOffset = -(hOffset or 0);
    end
    if ( y > UIParent:GetHeight() / 2 ) then
        vAnchor = "TOP";
    else
        vAnchor = "BOTTOM";
        vOffset = -(vOffset or 0);
    end
    tooltip:ClearAllPoints();
	tooltip:SetClampedToScreen(true);
	tooltip:SetPoint(vAnchor..hAnchor, frame, (vAnchor == "TOP" and "BOTTOM" or "TOP")..hAnchor, (hOffset or 0), (vOffset or 0));
end

local function GetCoinText(amount)
	local goldString, silverString, copperString;
	local truncated;
	-- Breakdown the money into denominations
	local gold = floor(amount / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local goldDisplay = BreakUpLargeNumbers(gold);
	local silver = floor((amount - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(amount, COPPER_PER_SILVER);

    if ( gold > 0 ) then
        goldString = format("|cffffffff%s|r|cffffd700%s|r", goldDisplay, GOLD_AMOUNT_SYMBOL);
    else
        goldString = "";
    end
    if ( amount >= COPPER_PER_SILVER ) then
        silverString = format("|cffffffff%d|r|cffc7c7cf%s|r", silver, SILVER_AMOUNT_SYMBOL);
    else
        silverString = "";
    end
    copperString = format("|cffffffff%d|r|cffeda55f%s|r", copper, COPPER_AMOUNT_SYMBOL);
    
    local moneyString = "";
  	local separator = "";	
	if ( gold > 0 ) then
		moneyString = goldString;
		separator = " ";
	end
	if ( gold < 1000 ) then
	    if ( silver > 0 ) then
		    moneyString = moneyString..separator..silverString;
		    separator = " ";
	    end
	    if ( copper > 0 or moneyString == "" ) then
		    moneyString = moneyString..separator..copperString;
	    end
    else
        truncated = true;
    end
    	
    return moneyString, truncated;
end

local function GetShortDate(value)
    if ( ARMORY_SHORTDATE_FORMAT ~= "ARMORY_SHORTDATE_FORMAT" ) then
        return date(ARMORY_SHORTDATE_FORMAT, value);
    end
    
    local dummy = time({year=3, month=2, day=1});
    local first = tonumber(date("%x", dummy):match("^(%d+)"));
    local day = date("%d", value):gsub("^0*", "");
    local month = date("%b", value);
    local year = "'"..date("%y", value);

    if ( first == 2 ) then
        return month.." "..day.." "..year;
    end
    return day.." "..month.." "..year;
end

local function OnLockClick(self, arg, button)
    if ( button == "LeftButton" ) then
        Armory.summary.locked = not Armory.summary.locked;
        SummaryAutoHide();
        Armory:DisplaySummary();
    end
end

local function OnRealmClick(self, realm)
    local collapsed = Armory:RealmState();
    if ( collapsed[realm] ) then
        collapsed[realm] = nil;
    else
        collapsed[realm] = 1;
    end
    Armory:DisplaySummary();
end

local function OnCharacterClick(self, profile, button)
    if ( button == "RightButton" ) then
        if ( not Armory:IsPlayerSelected(profile) ) then
            local dialog = ArmoryStaticPopup_Show("ARMORY_DELETE_CHARACTER", profile.character);
            dialog.data = profile;
            Armory:HideSummary();
        end
    else
        Armory:HideSummary();
        ArmoryFrameSelectCharacter(profile);
        if ( not ArmoryFrame:IsShown() and not Armory.summary ) then
            Armory:Toggle();
        end
    end
end

local function CellShowTooltip(self, text)
    SummaryHideDetail();
    GameTooltip:SetClampedToScreen(true);
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, -10);
    GameTooltip:SetFrameLevel(self:GetFrameLevel() + 1);
    if ( type(text) == "table" ) then
        GameTooltip:SetText(text[1], 1.0, 1.0, 1.0);
        GameTooltip:AddLine(text[2]);
        Armory:TooltipAddHints(GameTooltip, select(3, unpack(text)));
    elseif ( text:find("|H") ) then
        Armory:SetHyperlink(GameTooltip, text);
    else
        GameTooltip:SetText(text);
    end
    GameTooltip:Show();
end

local function CellHideTooltip(self)
    GameTooltip:Hide();
end

local function OnMoneyEnter(self, characterInfo)
    local total = characterInfo.RealmInfo[characterInfo.Faction];
    
    SummaryHideDetail();
    
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:SetFrameLevel(self:GetFrameLevel() + 1);
    GameTooltip:AddLine(format(ARMORY_MONEY_TOTAL, characterInfo.RealmInfo.Name, characterInfo.Faction), "", 1, 1, 1);
    SetTooltipMoney(GameTooltip, total);
    if ( characterInfo.MoneyTruncated and characterInfo.Money ~= total ) then
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine(characterInfo.Name..":", "", 1, 1, 1);
        SetTooltipMoney(GameTooltip, characterInfo.Money);
    end
    GameTooltip:Show();
end

local function OnXPEnter(self, tooltipText)
    SummaryHideDetail();
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:SetFrameLevel(self:GetFrameLevel() + 1);
    GameTooltip:AddLine(tooltipText, "", 1, 1, 1);
    Armory:TooltipAddHints(GameTooltip, ARMORY_LINK_HINT);
    GameTooltip:Show();
end

local function OnXPClick(self, text, button)
    if ( text and button == "LeftButton" and IsShiftKeyDown() ) then
        if ( not ChatEdit_InsertLink(text) ) then
            ChatFrame_OpenChat(text);
        end
    end
end

local function OnExpiredEnter(self, characterInfo)
    local tooltip = Armory.qtip:Acquire("ArmorySummaryExpiredTooltip", 3);
    local iconProvider = Armory.qtipIconProvider;
    local index, column, myColumn;
    local lastVisit, name;
    local font = Armory.summary:GetHeaderFont();
    font:SetTextColor(GetTableColor(NORMAL_FONT_COLOR));

    SummaryHideDetail(tooltip);

    tooltip:Clear();
    tooltip:SetScale(Armory:GetConfigFrameScale());
    tooltip:SetFrameLevel(self:GetFrameLevel() + 1);
    tooltip:EnableMouse(true);
    tooltip:SetAutoHideDelay(0.5, self);
    SetAnchor(tooltip, self, 16);

    index, column = tooltip:AddLine();
    myColumn = column; index, column = tooltip:SetCell(index, myColumn, characterInfo.Name, GameTooltipHeaderText, "LEFT", 2);
    
    if ( characterInfo.Expired.MailCount == -1 ) then
        lastVisit = RED_FONT_COLOR_CODE..NEVER..FONT_COLOR_CODE_CLOSE;
    else
        lastVisit = GetShortDate(characterInfo.Expired.LastVisit);
        if ( floor(time() / (24 * 60 * 60)) - floor(characterInfo.Expired.LastVisit / (24 * 60 * 60)) >= 30 - Armory:GetConfigExpirationDays() ) then
           lastVisit = RED_FONT_COLOR_CODE..lastVisit..FONT_COLOR_CODE_CLOSE;
        end
    end
    index, column = tooltip:AddLine();
    myColumn = column; index, column = tooltip:SetCell(index, myColumn, ARMORY_MAIL_LAST_VISIT, font, "LEFT", 2);
    myColumn = column; index, column = tooltip:SetCell(index, myColumn, lastVisit, font, "RIGHT");
    if ( characterInfo.Expired.MailCount > -1 ) then
        index, column = tooltip:AddLine();
        myColumn = column; index, column = tooltip:SetCell(index, myColumn, ARMORY_MAIL_ITEM_COUNT, nil, "LEFT", 2);
        myColumn = column; index, column = tooltip:SetCell(index, myColumn, characterInfo.Expired.MailCount, nil, "RIGHT");
        if ( characterInfo.Expired.Remaining > 0 ) then    
            index, column = tooltip:AddLine();
            myColumn = column; index, column = tooltip:SetCell(index, myColumn, ARMORY_MAIL_REMAINING, nil, "LEFT", 2);
            myColumn = column; index, column = tooltip:SetCell(index, myColumn, RED_FONT_COLOR_CODE..characterInfo.Expired.Remaining..FONT_COLOR_CODE_CLOSE, nil, "RIGHT");
        end
        if ( characterInfo.Expired.Items ) then    
            index, column = tooltip:AddLine();
            index, column = tooltip:AddHeader();
            myColumn = column; index, column = tooltip:SetCell(index, myColumn, INBOX, font, "LEFT", 2);
            myColumn = column; index, column = tooltip:SetCell(index, myColumn, ARMORY_EXPIRATION_LABEL, font, "RIGHT");
            tooltip:AddSeparator();

            for _, item in ipairs(characterInfo.Expired.Items) do
                name = Armory:GetColorFromLink(item.link)..item.name..FONT_COLOR_CODE_CLOSE.." ["..item.count.."]";
                if ( item.ignored ) then
                    name = name..NORMAL_FONT_COLOR_CODE.." ("..IGNORED..")"..FONT_COLOR_CODE_CLOSE;
                end
                index, column = tooltip:AddLine();
                myColumn = column; index, column = tooltip:SetCell(index, myColumn, GetItemIcon(item.link), iconProvider);
                myColumn = column; index, column = tooltip:SetCell(index, myColumn, name);
                myColumn = column; index, column = tooltip:SetCell(index, myColumn, item.left, nil, "RIGHT");
            end
        end
    end
    
    tooltip:UpdateScrolling(512);
    tooltip:Show();
        
    SummaryAutoHide(tooltip);
    tooltip.OnRelease = function() tooltip:SetScale(1); SummaryAutoHide() end;
end

local function OnEventsEnter(self, characterInfo)
    if ( characterInfo.NumEvents == 0 ) then
        return;
    end

    local tooltip = Armory.qtip:Acquire("ArmorySummaryEventsTooltip", 2);
    local index, column, myColumn;

    SummaryHideDetail(tooltip);
    
    tooltip:Clear();
    tooltip:SetScale(Armory:GetConfigFrameScale());
    tooltip:SetFrameLevel(self:GetFrameLevel() + 1);
    tooltip:EnableMouse(true);
    tooltip:SetAutoHideDelay(0.5, self);
    SetAnchor(tooltip, self, 16);
    
    index, column = tooltip:AddLine();
    myColumn = column; index, column = tooltip:SetCell(index, myColumn, characterInfo.Name, GameTooltipHeaderText, "LEFT", 2);

    tooltip:AddSeparator(2);
    for _, eventInfo in ipairs(characterInfo.Events) do
        index, column = tooltip:AddLine();
        myColumn = column; index, column = tooltip:SetCell(index, myColumn, eventInfo.Title.." "..NORMAL_FONT_COLOR_CODE..eventInfo.Type..FONT_COLOR_CODE_CLOSE.."\n"..eventInfo.Date);
        myColumn = column; index, column = tooltip:SetCell(index, myColumn, eventInfo.Status.."\n"..NORMAL_FONT_COLOR_CODE..eventInfo.Text..FONT_COLOR_CODE_CLOSE);
        tooltip:AddSeparator(2);
    end

    tooltip:UpdateScrolling(512);
    tooltip:Show();
        
    SummaryAutoHide(tooltip);
    tooltip.OnRelease = function() tooltip:SetScale(1); SummaryAutoHide() end;
end

local function OnSkillClick(self, link)
    if ( link ) then
        if ( IsShiftKeyDown() ) then
            if ( not ChatEdit_InsertLink(link) ) then
                ChatFrame_OpenChat(link);
            end
        else
            Armory:OpenProfession(link);
            Armory:HideSummary();
        end
    end
end

local function SortSummary(sortColumn)
    local columnName = sortColumn or "name";
    local sorter;
    
    if ( summary.lastSort == columnName ) then
        summary.initial = not summary.initial;
    else
        summary.initial = true;
    end
    summary.lastSort = columnName;

    if ( columnName == "name" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.Name < b.Name; 
            else 
                return a.Name > b.Name; 
            end 
        end;
        table.sort(summary, sorter);
    elseif ( columnName == "class" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.Class < b.Class; 
            else 
                return a.Class > b.Class; 
            end 
        end;
    elseif ( columnName == "level" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.Level > b.Level; 
            else 
                return a.Level < b.Level; 
            end 
        end;
    elseif ( columnName == "ilvl" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.ItemLevel > b.ItemLevel; 
            else 
                return a.ItemLevel < b.ItemLevel; 
            end 
        end;
    elseif ( columnName == "zone" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.Zone < b.Zone; 
            else 
                return a.Zone > b.Zone; 
            end 
        end;
    elseif ( columnName == "xp" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.XP > b.XP; 
            else 
                return a.XP < b.XP; 
            end 
        end;
    elseif ( columnName == "played" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.TimePlayed > b.TimePlayed; 
            else 
                return a.TimePlayed < b.TimePlayed; 
            end 
        end;
    elseif ( columnName == "online" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.LastPlayed > b.LastPlayed; 
            else 
                return a.LastPlayed < b.LastPlayed; 
            end 
        end;
    elseif ( columnName == "money" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.Money > b.Money; 
            else 
                return a.Money < b.Money; 
            end 
        end;
    elseif ( columnName == "honor" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.Honor > b.Honor; 
            else 
                return a.Honor < b.Honor; 
            end 
        end;
    elseif ( columnName == "conquest" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.Conquest > b.Conquest; 
            else 
                return a.Conquest < b.Conquest; 
            end 
        end;
    elseif ( columnName == "justice" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.Justice > b.Justice; 
            else 
                return a.Justice < b.Justice; 
            end 
        end;
    elseif ( columnName == "valor" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.Valor > b.Valor; 
            else 
                return a.Valor < b.Valor; 
            end 
        end;
    elseif ( columnName == "quest" ) then
        sorter = function(a, b) 
            if ( summary.initial ) then 
                return a.NumQuests > b.NumQuests; 
            else 
                return a.NumQuests < b.NumQuests; 
            end 
        end;
    end

    if ( sorter ) then
        for _, realmInfo in ipairs(summary) do
            table.sort(realmInfo.Characters, sorter);
        end
    end
end

local function OnColumnHeaderClick(self, name)
    SortSummary(name);
    Armory:DisplaySummary(); 
end

function Armory:BuildSummary()
    local realms = self:RealmList();
    local currentProfile = self:CurrentProfile();
    local unknown = GRAY_FONT_COLOR_CODE..UNKNOWN..FONT_COLOR_CODE_CLOSE;
    local unit = "player";
    local realmInfo, characterInfo;
    local currencyName, currencyAmount, currencyIcon; 
    local factionGroup;

    table.wipe(summary);

    for _, realm in ipairs(realms) do
        realmInfo = { Name=realm, Characters={} };
        table.insert(summary, realmInfo);

        for _, character in ipairs(self:CharacterList(realm)) do
            self:SelectProfile({realm=realm, character=character});
            
            characterInfo = { Name=character, RealmInfo=realmInfo };
            table.insert(realmInfo.Characters, characterInfo);
            
            characterInfo.Faction = self:UnitFactionGroup(unit);
            if ( characterInfo.Faction ) then
                if ( not realmInfo[characterInfo.Faction] ) then
                    realmInfo[characterInfo.Faction] = self:GetMoney();
                else
                    realmInfo[characterInfo.Faction] = realmInfo[characterInfo.Faction] + self:GetMoney();
                end
            end
            
            if ( self:GetConfigSummaryClass() ) then   
                local class, classEn = self:UnitClass(unit);
                characterInfo.Class = class; 
                characterInfo.ClassDisplay = "|c"..self:ClassColor(classEn, true)..class..FONT_COLOR_CODE_CLOSE;
            end
            if ( self:GetConfigSummaryLevel() ) then   
                characterInfo.Level = self:UnitLevel(unit);
            end
            if ( self:GetConfigSummaryItemLevel() ) then 
                local avgItemLevel, avgItemLevelEquipped = self:GetAverageItemLevel();
                local itemLevel = "";
                characterInfo.ItemLevel = avgItemLevel or 0;
                if ( avgItemLevel ) then
                    avgItemLevel = floor(avgItemLevel);
                    itemLevel = avgItemLevel;
                    if ( avgItemLevelEquipped ) then
                        avgItemLevelEquipped = floor(avgItemLevelEquipped);
                        if ( avgItemLevel ~= avgItemLevelEquipped ) then
                            itemLevel = avgItemLevelEquipped .. "/" .. avgItemLevel;
                        end
                    end
                end
                characterInfo.ItemLevelDisplay = itemLevel;
            end
            if ( self:GetConfigSummaryZone() ) then   
                characterInfo.Zone = self:GetZoneText();
                characterInfo.SubZone = self:GetSubZoneText(); 
            end
            if ( self:GetConfigSummaryXP() ) then
                local xpText, tooltipText, chatText = self:GetXP();
                characterInfo.XP = 0;
                if ( self:UnitLevel(unit) ~= MAX_PLAYER_LEVEL ) then
                    local currXP = self:UnitXP(unit);
                    local nextXP = self:UnitXPMax(unit);
                    if ( (nextXP or 0) > 0 ) then
                        characterInfo.XP = currXP / nextXP;
                    end
                end
                characterInfo.XPDisplay = xpText or NOT_APPLICABLE;
                characterInfo.XPChat = chatText;
                if ( tooltipText ) then
                    local xp = format("%d / %d", self:UnitXP(unit), self:UnitXPMax(unit));
                    characterInfo.XPTooltip = xp.."\n"..tooltipText;
                end
            end
            if ( self:GetConfigSummaryPlayed() ) then 
                characterInfo.TimePlayed = self:GetTimePlayed() or 0;
                characterInfo.TimePlayedDisplay = (characterInfo.TimePlayed > 0 and SecondsToTime(characterInfo.TimePlayed, true)) or unknown;
            end
            if ( self:GetConfigSummaryOnline() ) then   
                characterInfo.LastPlayed = select(2, self:GetTimePlayed()) or 0;
                characterInfo.LastPlayedDisplay = (characterInfo.LastPlayed > 0 and GetShortDate(characterInfo.LastPlayed)) or unknown;
            end
            if ( self:GetConfigSummaryMoney() ) then
                characterInfo.Money = self:GetMoney();
                characterInfo.MoneyDisplay, characterInfo.MoneyTruncated = GetCoinText(characterInfo.Money);
            end
            if ( self:GetConfigSummaryCurrency() ) then
                currencyName, currencyAmount, currencyIcon = self:GetCurrencyInfo(HONOR_CURRENCY);
                characterInfo.Honor = currencyAmount or 0;
                if ( characterInfo.Honor > 0 ) then
                    summary.Honor = {
                        Name = currencyName or "Honor Points",
                        Icon = currencyIcon or "Interface\\Icons\\INV_Misc_QuestionMark"
                    };
                end
                local earnedThisWeek, earnablePerWeek;
                currencyName, currencyAmount, currencyIcon, earnedThisWeek, earnablePerWeek = self:GetCurrencyInfo(CONQUEST_CURRENCY);
                characterInfo.Conquest = currencyAmount or 0;
                if ( characterInfo.Conquest > 0 ) then
                    summary.Conquest = {
                        Name = currencyName or "Conquest Points",
                        Icon = currencyIcon or "Interface\\Icons\\INV_Misc_QuestionMark"
                    };
                    if ( earnablePerWeek ) then
                        characterInfo.ConquestEarned = earnedThisWeek;
                        characterInfo.ConquestCap = earnablePerWeek;
                    end
                end
                currencyName, currencyAmount, currencyIcon = self:GetCurrencyInfo(JUSTICE_CURRENCY);
                characterInfo.Justice = currencyAmount or 0;
                if ( characterInfo.Justice > 0 ) then
                    summary.Justice = {
                        Name = currencyName or "Justice Points",
                        Icon = currencyIcon or "Interface\\Icons\\INV_Misc_QuestionMark"
                    };
                end
                currencyName, currencyAmount, currencyIcon, earnedThisWeek, earnablePerWeek = self:GetCurrencyInfo(VALOR_CURRENCY);
                characterInfo.Valor = currencyAmount or 0;
                if ( characterInfo.Valor > 0 ) then
                    summary.Valor = {
                        Name = currencyName or "Valor Points",
                        Icon = currencyIcon or "Interface\\Icons\\INV_Misc_QuestionMark"
                    };
                    if ( earnablePerWeek ) then
                        characterInfo.ValorEarned = earnedThisWeek;
                        characterInfo.ValorCap = floor(earnablePerWeek / 100);
                    end
                end
            end
            if ( self:GetConfigSummaryQuest() and self:HasQuestLog() ) then
                characterInfo.NumQuests = select(2, self:GetNumQuestLogEntries()) or 0;
            end
            if ( self:GetConfigSummaryExpiration() and self:GetConfigExpirationDays() > 0 and self:HasInventory() ) then
                local hasMail = self:ContainerExists(ARMORY_MAIL_CONTAINER);
                local text = "";
                local count = 0;
                local numItems = -1;
                local expired, timestamp;
                if ( hasMail ) then
                    for profile, items in pairs(expiredMail) do
                        if ( realm == profile.realm and character == profile.character ) then
                            expired = items;
                            break;
                        end
                    end
                    if ( expired ) then
                        count = 0;
                        for _, item in ipairs(expired) do
                            if ( not item.ignored ) then
                                count = count + 1;
                            end
                        end
                        text = count.."/"..#expired;
                    end
                    _, numItems, _, timestamp = self:GetInventoryContainerInfo(ARMORY_MAIL_CONTAINER);
                    count = self:GetNumRemainingMailItems();
                    if ( count > 0 or floor(time() / (24 * 60 * 60)) - floor(timestamp / (24 * 60 * 60)) >= 30 - self:GetConfigExpirationDays() ) then
                        text = text..RED_FONT_COLOR_CODE.."!"..FONT_COLOR_CODE_CLOSE;
                    end
                else
                    text = RED_FONT_COLOR_CODE.."!"..FONT_COLOR_CODE_CLOSE;
                end
                characterInfo.Expired = {
                    Remaining = count,
                    Items = expired,
                    LastVisit = timestamp,
                    MailCount = numItems
                };
                characterInfo.ExpiredDisplay = text;
            end
            if ( self:GetConfigSummaryEvents() and self:HasSocial() ) then
                local numEvents = self:GetNumEvents();
                local eventTime, isOldEvent, title, status, calendarType, typeName, text, fullDate;
                local events = {};
                for i = 1, numEvents do
                    eventTime, isOldEvent, title, status, calendarType, typeName, text = ArmoryEventsList_GetEventDetail(i);
                    if ( not isOldEvent ) then
                        if ( not self:GetConfigUseEventLocalTime() ) then
                            eventTime = self:GetLocalTimeAsServerTime(eventTime);
                        end   
                        eventTime = date("*t", eventTime);
                        fullDate = format(FULLDATE, self:GetFullDate(eventTime));
                        fullDate = format(FULLDATE_AND_TIME, fullDate, GameTime_GetFormattedTime(eventTime.hour, eventTime.min, true));
                        table.insert(events, {
                            Date = fullDate, 
                            Title = title, 
                            Status = status or "", 
                            Type = typeName or "",
                            Text = text or ""
                        });
                    end
                end
                characterInfo.Events = events;
                characterInfo.NumEvents = #events;
            end
            if ( self:GetConfigSummaryTradeSkills() and self:HasTradeSkills() ) then
                local currentProfession = self:GetSelectedProfession();
                local rank, maxRank, link;
                local skills = {};
                for _, name in ipairs(self:GetProfessionNames()) do
                    if ( self:HasTradeSkillLines(name) ) then
                        self:SetSelectedProfession(name);
                        _, rank, maxRank = self:GetTradeSkillLine();
                        if ( rank ) then
                            table.insert(skills, {
                                Name = name,
                                Link = self:GetTradeSkillListLink(), 
                                Icon = self:GetProfessionTexture(name), 
                                Tooltip = format("%s (%d/%d)", name, rank, maxRank)
                            });
                        end
                    end
                end
                table.sort(skills, function(a, b) return a.Name < b.Name end);
                characterInfo.TradeSkills = skills;
                self:SetSelectedProfession(currentProfession);
            end
        end
    end
    self:SelectProfile(currentProfile);
end

function Armory:ShowSummary(parent)
    if ( self:GetConfigShowSummary() and table.getn(self:SelectableProfiles()) > 0 ) then
        local command = ArmoryCommand:new(Armory.InitializeSummary, self, parent);
        command:SetDelay(self:GetConfigSummaryDelay());
        command:Enforce();
        Armory.commandHandler:AddCommand(command);
    end
end

function Armory:InitializeSummary(parent)
    if ( self.summaryEnabled and not ((self.summary and self.summary:IsShown()) or ArmoryDropDownList1:IsVisible()) ) then
        local columns = 3;
         
        if ( self:HasInventory() ) then
            _, expiredMail = self:CheckMailItems(2);
        end
       
        self:BuildSummary();
        
        if ( self:GetConfigSummaryClass() ) then   
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryLevel() ) then   
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryItemLevel() ) then   
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryZone() ) then
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryXP() ) then   
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryPlayed() ) then   
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryOnline() ) then   
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryMoney() ) then   
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryCurrency() ) then 
            if ( summary.Honor ) then  
                columns = columns + 1;
            end
            if ( summary.Conquest ) then  
                columns = columns + 1;
            end
            if ( summary.Justice ) then  
                columns = columns + 1;
            end
            if ( summary.Valor ) then  
                columns = columns + 1;
            end
        end
        if ( self:GetConfigSummaryQuest() and self:HasQuestLog() ) then
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryExpiration() and self:GetConfigExpirationDays() > 0 and self:HasInventory() ) then
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryEvents() and self:HasSocial() ) then
            columns = columns + 1;
        end
        if ( self:GetConfigSummaryTradeSkills() and self:HasTradeSkills() ) then  
            columns = columns + 5;
        end

        self.summary = self.qtip:Acquire("ArmorySummary", columns);
        self.summary:SetScale(Armory:GetConfigFrameScale());
        self.summary:SmartAnchorTo(parent);
        self.summary.parent = parent;

        self.summary:SetScript("OnMouseDown", function (self, button)
            if ( self.locked and button == "RightButton" ) then
                self:SetMovable(true);
                self:StartMoving();
                self.isMoving = true;
            end
        end);
        self.summary:SetScript("OnMouseUp", function (self, button)
            if ( self.isMoving ) then
              self:StopMovingOrSizing();
              self:SetMovable(false);
              self.isMoving = false;
            end
        end);
        
        self:DisplaySummary();
    end    
end

function Armory:DisplaySummary()
    if ( not summary ) then
        self:BuildSummary();
    end

    local currentProfile = self:CurrentProfile();
    local collapsed = Armory:RealmState();

    local iconProvider = self.qtipIconProvider;
    GameTooltip:Hide();
    self.summary:Clear();

    local font = self.summary:GetHeaderFont();
    font:SetTextColor(GetTableColor(NORMAL_FONT_COLOR));

    local index, column = self.summary:AddHeader();
    local myColumn;

    myColumn = column; index, column = self.summary:SetCell(index, myColumn, "Interface\\Addons\\Armory\\Artwork\\" .. (self.summary.locked and "Unpin" or "Pin"), iconProvider);
    self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, (self.summary.locked and UNLOCK or LOCK) ); 
    self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
    self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnLockClick);

    myColumn = column; index, column = self.summary:SetCell(index, myColumn, NAME, font, "LEFT", 2);
    self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "name");

    if ( self:GetConfigSummaryClass() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, CLASS, font);
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "class");
    end
    if ( self:GetConfigSummaryLevel() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, LEVEL_ABBR, font, "RIGHT");    
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "level");
    end
    if ( self:GetConfigSummaryItemLevel() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, ITEM_LEVEL_ABBR, font, "CENTER");    
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "ilvl");
    end
    if ( self:GetConfigSummaryZone() ) then
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, ZONE, font);
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "zone");
    end
    if ( self:GetConfigSummaryXP() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, XP, font, "CENTER");
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "xp");
    end
    if ( self:GetConfigSummaryPlayed() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, PLAYED, font, "CENTER");    
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "played");
    end
    if ( self:GetConfigSummaryOnline() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, LASTONLINE, font, "RIGHT");
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "online");
    end
    if ( self:GetConfigSummaryMoney() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, MONEY, font, "CENTER");
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "money");
    end
    if ( self:GetConfigSummaryCurrency() ) then  
        if ( summary.Honor ) then 
            myColumn = column; index, column = self.summary:SetCell(index, myColumn, summary.Honor.Icon, iconProvider);
            self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, summary.Honor.Name); 
            self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
            self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "honor");
        end
        if ( summary.Conquest ) then 
            myColumn = column; index, column = self.summary:SetCell(index, myColumn, summary.Conquest.Icon, iconProvider);
            self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, summary.Conquest.Name); 
            self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
            self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "conquest");
        end
        if ( summary.Justice ) then 
            myColumn = column; index, column = self.summary:SetCell(index, myColumn, summary.Justice.Icon, iconProvider);
            self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, summary.Justice.Name); 
            self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
            self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "justice");
        end
        if ( summary.Valor ) then 
            myColumn = column; index, column = self.summary:SetCell(index, myColumn, summary.Valor.Icon, iconProvider);
            self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, summary.Valor.Name); 
            self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
            self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "valor");
        end
    end
    if ( self:GetConfigSummaryQuest() and self:HasQuestLog() ) then
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, "Interface\\GossipFrame\\AvailableQuestIcon", iconProvider);
        self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, QUESTS_LABEL); 
        self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "quest");
    end
    if ( self:GetConfigSummaryExpiration() and self:GetConfigExpirationDays() > 0 and self:HasInventory() ) then
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, "Interface\\Icons\\INV_Letter_15", iconProvider);
        self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, ARMORY_EXPIRATION_TITLE); 
        self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
    end
    if ( self:GetConfigSummaryEvents() and self:HasSocial() ) then
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, "Interface\\Calendar\\EventNotification", iconProvider);
        self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, EVENTS_LABEL); 
        self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
    end
    if ( self:GetConfigSummaryTradeSkills() and self:HasTradeSkills() ) then  
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, TRADESKILLS, font, "CENTER", 5);
    end

    self.summary:AddSeparator();

    for _, realmInfo in ipairs(summary) do
        local realm = realmInfo.Name;
        
        index, column = self.summary:AddLine();

        myColumn = column; 
        if ( #summary > 1 ) then
            index, column = self.summary:SetCell(index, myColumn, format("Interface\\Buttons\\UI-%sButton-Up", collapsed[realm] and "Plus" or "Minus"), iconProvider); 
            self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnRealmClick, realm);
        else
            index, column = self.summary:SetCell(index, myColumn, "");
        end

        myColumn = column; index, column = self.summary:SetCell(index, myColumn, realm, nil, "LEFT", 2); 

        for _, characterInfo in ipairs(realmInfo.Characters) do
            local character = characterInfo.Name;

            if ( not collapsed[realm] ) then
                checked = (realm == currentProfile.realm and character == currentProfile.character);
                
                index, column = self.summary:AddLine();

                myColumn = column; 
                if ( checked ) then
                    index, column = self.summary:SetCell(index, myColumn, "Interface\\Buttons\\UI-CheckBox-Check", iconProvider);
                else
                    index, column = self.summary:SetCell(index, myColumn, "");
                end
                
                myColumn = column; 
                if ( characterInfo.Faction and characterInfo.Faction ~= "Neutral") then
                    index, column = self.summary:SetCell(index, myColumn, "Interface\\TargetingFrame\\UI-PVP-"..characterInfo.Faction, iconProvider);
                else
                    index, column = self.summary:SetCell(index, myColumn, "");
                end
                myColumn = column; index, column = self.summary:SetCell(index, myColumn, NORMAL_FONT_COLOR_CODE..character..FONT_COLOR_CODE_CLOSE);
                if ( realm == self.playerRealm and character == self.player ) then
                    self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, {character, realm, ARMORY_SELECT_UNIT_HINT} ); 
                else
                    self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, {character, realm, ARMORY_SELECT_UNIT_HINT, ARMORY_DELETE_UNIT_HINT} ); 
                end
                self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
                self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnCharacterClick, {realm=realm, character=character});

                if ( self:GetConfigSummaryClass() ) then   
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.ClassDisplay);
                end
                if ( self:GetConfigSummaryLevel() ) then   
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.Level, nil, "CENTER");
                end
                if ( self:GetConfigSummaryItemLevel() ) then 
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.ItemLevelDisplay, nil, "CENTER");
                end
                if ( self:GetConfigSummaryZone() ) then   
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.Zone);
                    self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, {characterInfo.Zone, characterInfo.SubZone} ); 
                    self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
                end
                if ( self:GetConfigSummaryXP() ) then
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.XPDisplay, nil, "CENTER");
                    if ( characterInfo.XPTooltip ) then
                        self.summary:SetCellScript(index, myColumn, "OnEnter", OnXPEnter, characterInfo.XPTooltip);
                        self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip);
                    end
                    self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnXPClick, characterInfo.XPChat); 
                end
                if ( self:GetConfigSummaryPlayed() ) then   
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.TimePlayedDisplay, nil, "CENTER");
                end
                if ( self:GetConfigSummaryOnline() ) then   
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.LastPlayedDisplay, nil, "CENTER");
                end
                if ( self:GetConfigSummaryMoney() ) then
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.MoneyDisplay, nil, "RIGHT");
                    if ( characterInfo.Faction ) then
                        self.summary:SetCellScript(index, myColumn, "OnEnter", OnMoneyEnter, characterInfo);
                        self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
                    end
                end
                if ( self:GetConfigSummaryCurrency() ) then
                    if ( summary.Honor ) then 
                        myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.Honor > 0 and characterInfo.Honor or "", nil, "RIGHT");
                    end
                    if ( summary.Conquest ) then 
                        myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.Conquest > 0 and characterInfo.Conquest or "", nil, "RIGHT");
                        if ( characterInfo.ConquestCap ) then
                            self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, {summary.Conquest.Name, format(CURRENCY_WEEKLY_CAP, "", characterInfo.ConquestEarned, characterInfo.ConquestCap)} ); 
                            self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
                        end
                    end
                    if ( summary.Justice ) then 
                        myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.Justice > 0 and characterInfo.Justice or "", nil, "RIGHT");
                    end
                    if ( summary.Valor ) then 
                        myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.Valor > 0 and characterInfo.Valor or "", nil, "RIGHT");
                        if ( characterInfo.ValorCap ) then
                            self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, {summary.Valor.Name, format(CURRENCY_WEEKLY_CAP, "", characterInfo.ValorEarned, characterInfo.ValorCap)} ); 
                            self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
                        end
                    end
                end
                if ( self:GetConfigSummaryQuest() and self:HasQuestLog() ) then
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.NumQuests > 0 and characterInfo.NumQuests or "", nil, "CENTER");
                end
                if ( self:GetConfigSummaryExpiration() and self:GetConfigExpirationDays() > 0 and self:HasInventory() ) then
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.ExpiredDisplay, nil, "CENTER");
                    self.summary:SetCellScript(index, myColumn, "OnEnter", OnExpiredEnter, characterInfo);
                end
                if ( self:GetConfigSummaryEvents() and self:HasSocial() ) then
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.NumEvents > 0 and characterInfo.NumEvents or "", nil, "CENTER");
                    self.summary:SetCellScript(index, myColumn, "OnEnter", OnEventsEnter, characterInfo);
                end
                if ( self:GetConfigSummaryTradeSkills() and self:HasTradeSkills() ) then
                    for _, skillInfo in ipairs(characterInfo.TradeSkills) do
                        myColumn = column; index, column = self.summary:SetCell(index, myColumn, skillInfo.Icon, iconProvider);
                        if ( realm == self.playerRealm ) then
                            self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, {character, skillInfo.Tooltip, ARMORY_OPEN_HINT, ARMORY_LINK_HINT}); 
                            self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnSkillClick, skillInfo.Link);
                        else
                            self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, {character, skillInfo.Tooltip}); 
                        end
                        self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
                    end
                end
            end
        end
    end

    self.summary:UpdateScrolling(512);
    self.summary:Show();
    
    SummaryAutoHide();
end

function Armory:UpdateSummary()
    self:BuildSummary();
    self:DisplaySummary();
end

function Armory:HideSummary()
    if ( self.summary and not self.summary.locked ) then
        self.summary:SetScale(1);
        self.qtip:Release(self.summary);
        table.wipe(summary);
        self.summary = nil;
    end
end
