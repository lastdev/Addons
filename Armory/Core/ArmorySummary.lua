--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 631 2014-04-12T14:56:13Z
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
    SummaryHideDetail();

	local money = {};
    local addToTotal = function (realmInfo)
		local realm = realmInfo.Name;
		local total = realmInfo[characterInfo.Faction] or 0;
		if ( total > 0 ) then
			if ( not money[realm] ) then
				money[realm] = 0;
			end
			money[realm] = money[realm] + total;
		end
    end;

	if ( characterInfo.RealmInfo.Connected ) then
		for realmInfo in pairs(characterInfo.RealmInfo.Connected) do
			addToTotal(realmInfo);
		end
	else
		addToTotal(characterInfo.RealmInfo);
	end
    
    local total = money[characterInfo.RealmInfo.Name] or 0;
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:SetFrameLevel(self:GetFrameLevel() + 1);
    GameTooltip:AddLine(format(ARMORY_MONEY_TOTAL, characterInfo.RealmInfo.Name, characterInfo.Faction), "", 1, 1, 1);
    SetTooltipMoney(GameTooltip, total, "TOOLTIP");

    local multiRealm;
    for realm, realmTotal in pairs(money) do
		if ( realm ~= characterInfo.RealmInfo.Name ) then
			GameTooltip:AddLine(format(ARMORY_MONEY_TOTAL, realm, characterInfo.Faction), "", 1, 1, 1);
			SetTooltipMoney(GameTooltip, realmTotal);
			total = total + realmTotal;
			multiRealm = true;
		end
    end
    if ( multiRealm ) then
		GameTooltip:AddLine(format(ARMORY_MONEY_TOTAL, "-", characterInfo.Faction), "", 1, 1, 1);
		SetTooltipMoney(GameTooltip, total);
    end

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
    local headerFont = Armory.summary:GetHeaderFont();
    headerFont:SetTextColor(GetTableColor(NORMAL_FONT_COLOR));

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
    myColumn = column; index, column = tooltip:SetCell(index, myColumn, ARMORY_MAIL_LAST_VISIT, headerFont, "LEFT", 2);
    myColumn = column; index, column = tooltip:SetCell(index, myColumn, lastVisit, headerFont, "RIGHT");
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
            myColumn = column; index, column = tooltip:SetCell(index, myColumn, INBOX, headerFont, "LEFT", 2);
            myColumn = column; index, column = tooltip:SetCell(index, myColumn, ARMORY_EXPIRATION_LABEL, headerFont, "RIGHT");
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

local function OnRaidInfoEnter(self, characterInfo)
    if ( table.getn(characterInfo.RaidInfo) == 0 ) then
        return;
    end

    local tooltip = Armory.qtip:Acquire("ArmorySummaryRaidInfoTooltip", 2);
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
    for _, raidInfo in ipairs(characterInfo.RaidInfo) do
        index, column = tooltip:AddLine();
        myColumn = column; index, column = tooltip:SetCell(index, myColumn, NORMAL_FONT_COLOR_CODE..raidInfo.Name..FONT_COLOR_CODE_CLOSE.."\n  "..raidInfo.Difficulty);
        myColumn = column; index, column = tooltip:SetCell(index, myColumn, raidInfo.Reset.."\n ");
        if ( raidInfo.Killed ) then
			index, column = tooltip:AddLine();
            myColumn = column; index, column = tooltip:SetCell(index, myColumn, "  "..RED_FONT_COLOR_CODE..strjoin(", ", unpack(raidInfo.Killed))..FONT_COLOR_CODE_CLOSE, nil, "LEFT", 2);
        end
        tooltip:AddSeparator(2);
    end

    tooltip:UpdateScrolling(512);
    tooltip:Show();
        
    SummaryAutoHide(tooltip);
    tooltip.OnRelease = function() tooltip:SetScale(1); SummaryAutoHide() end;
end

local questHeaderState = {};
local function DisplayQuests(tooltip, characterInfo)
    local iconProvider = Armory.qtipIconProvider;
    local index, column, myColumn;
    local headerFont = tooltip:GetHeaderFont();
    headerFont:SetTextColor(GetTableColor(NORMAL_FONT_COLOR));

    tooltip:Clear();

    index, column = tooltip:AddLine();
    myColumn = column; index, column = tooltip:SetCell(index, myColumn, characterInfo.Name, GameTooltipHeaderText, "LEFT", 4);

    tooltip:AddSeparator(2);

    local currentProfile = Armory:CurrentProfile();
	Armory:LoadProfile(characterInfo.RealmInfo.Name, characterInfo.Name);

	local numEntries;
	local questTitleText, level, questTag, isHeader, isCollapsed, isComplete, isDaily, label;
	local color;

 	if ( characterInfo.NumQuests > 0 ) then
        index, column = tooltip:AddLine();

        myColumn = column; index, column = tooltip:SetCell(index, myColumn, format("Interface\\Buttons\\UI-%sButton-Up", questHeaderState.Quests and "Plus" or "Minus"), iconProvider); 
        tooltip:SetCellScript(index, myColumn, "OnMouseDown", function (self) 
			questHeaderState.Quests = not questHeaderState.Quests; 
			DisplayQuests(tooltip, characterInfo); 
		end);

        myColumn = column; index, column = tooltip:SetCell(index, myColumn, CURRENT_QUESTS, headerFont, "LEFT", 3); 
        
        if ( not questHeaderState.Quests ) then
			numEntries = Armory:GetNumQuestLogEntries();
			for i = 1, numEntries do
				questTitleText, level, questTag, _, isHeader, isCollapsed, isComplete, isDaily = Armory:GetQuestLogTitle(i);

				index, column = tooltip:AddLine("");

				if ( isHeader ) then
					myColumn = column; index, column = tooltip:SetCell(index, myColumn, format("Interface\\Buttons\\UI-%sButton-Up", isCollapsed and "Plus" or "Minus"), iconProvider); 
					tooltip:SetCellScript(index, myColumn, "OnMouseDown", function (self, id) 
					    local currentProfile = Armory:CurrentProfile();
						Armory:LoadProfile(characterInfo.RealmInfo.Name, characterInfo.Name);
						
						local isCollapsed = select(6, Armory:GetQuestLogTitle(id));
						if ( isCollapsed ) then
							Armory:ExpandQuestHeader(id);
						else
							Armory:CollapseQuestHeader(id);
						end
						ArmoryQuest_Update();
						Armory:SelectProfile(currentProfile);
						
						DisplayQuests(tooltip, characterInfo);
					end, i);
					
					color = QuestDifficultyColors["header"];
				else
					myColumn = column; index, column = tooltip:SetCell(index, myColumn, "");
					
					color = ArmoryGetDifficultyColor(level);
				end
				color = Armory:HexColor(color);
				
				myColumn = column; index, column = tooltip:SetCell(index, myColumn, color..questTitleText..FONT_COLOR_CODE_CLOSE); 
				myColumn = column; index, column = tooltip:SetCell(index, myColumn, isHeader and "" or color..(ArmoryQuestLog_GetQuestTag(questTag, isComplete, isDaily) or "")..FONT_COLOR_CODE_CLOSE); 
			end
		end
	end

 	if ( characterInfo.NumQuestHistoryEntries > 0 ) then
        index, column = tooltip:AddLine();

        myColumn = column; index, column = tooltip:SetCell(index, myColumn, format("Interface\\Buttons\\UI-%sButton-Up", questHeaderState.QuestHistory and "Plus" or "Minus"), iconProvider); 
        tooltip:SetCellScript(index, myColumn, "OnMouseDown", function (self) 
			questHeaderState.QuestHistory = not questHeaderState.QuestHistory; 
			DisplayQuests(tooltip, characterInfo); 
		end);

        myColumn = column; index, column = tooltip:SetCell(index, myColumn, format("%s / %s", DAILY, CALENDAR_REPEAT_WEEKLY), headerFont, "LEFT", 3); 

        if ( not questHeaderState.QuestHistory ) then
			numEntries = Armory:GetNumQuestHistoryEntries();
			for i = 1, numEntries do
				questTitleText, isHeader, isCollapsed, questTag, label = Armory:GetQuestHistoryTitle(i);
				color = QuestDifficultyColors[label];
								
				index, column = tooltip:AddLine("");

				if ( isHeader ) then
					myColumn = column; index, column = tooltip:SetCell(index, myColumn, format("Interface\\Buttons\\UI-%sButton-Up", isCollapsed and "Plus" or "Minus"), iconProvider); 
					tooltip:SetCellScript(index, myColumn, "OnMouseDown", function (self, id) 
					    local currentProfile = Armory:CurrentProfile();
						Armory:LoadProfile(characterInfo.RealmInfo.Name, characterInfo.Name);
						
						local isCollapsed = select(3, Armory:GetQuestHistoryTitle(id));
						if ( isCollapsed ) then
							Armory:ExpandQuestHistoryHeader(id);
						else
							Armory:CollapseQuestHistoryHeader(id);
						end
						ArmoryQuest_Update();
						Armory:SelectProfile(currentProfile);
						
						DisplayQuests(tooltip, characterInfo);
					end, i);
				else
					myColumn = column; index, column = tooltip:SetCell(index, myColumn, "");
				end
				
				color = Armory:HexColor(color);
				myColumn = column; index, column = tooltip:SetCell(index, myColumn, color..questTitleText..FONT_COLOR_CODE_CLOSE); 
				myColumn = column; index, column = tooltip:SetCell(index, myColumn, isHeader and "" or color..questTag..FONT_COLOR_CODE_CLOSE); 
			end
		end
	end
	
	Armory:SelectProfile(currentProfile);
end

local function OnQuestsEnter(self, characterInfo)
    if ( characterInfo.NumQuests == 0 and characterInfo.NumQuestHistoryEntries == 0 ) then
        return;
    end

    local tooltip = Armory.qtip:Acquire("ArmorySummaryQuestsTooltip", 4);

    SummaryHideDetail(tooltip);

    tooltip:SetScale(Armory:GetConfigFrameScale());
    tooltip:SetFrameLevel(self:GetFrameLevel() + 1);
    tooltip:EnableMouse(true);
    tooltip:SetAutoHideDelay(0.5, self);
	
	-- force left anchoring because of collapsable headers
    --SetAnchor(tooltip, self, 16);
	tooltip:ClearAllPoints();
	tooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 16, 0);
	tooltip:SetClampedToScreen(true); -- doesn't work with UpdateScrolling...

	table.wipe(questHeaderState);

 	if ( characterInfo.NumQuests > 0 ) then
		if ( Armory:SetQuestLogFilter("") ) then
			ArmoryQuest_Update();
		end
		questHeaderState.Quests = characterInfo.NumQuestHistoryEntries > 0;
	end

	DisplayQuests(tooltip, characterInfo);

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

local function OnSkillClick(self, profile, button)
    if ( profile and profile.skill ) then
		OnCharacterClick(self, profile, "LeftButton");
        Armory:SetSelectedProfession(profile.skill);
        ArmoryTradeSkillFrame_Show();
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

    elseif ( columnName ) then 
        sorter = function(a, b) 
			local ac = a.CurrencyInfo[columnName] and a.CurrencyInfo[columnName].Count or 0;
			local bc = b.CurrencyInfo[columnName] and b.CurrencyInfo[columnName].Count or 0;
			if ( summary.initial ) then 
                return ac > bc; 
            else 
                return ac < bc; 
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
    local factionGroup;

    table.wipe(summary);
    
	summary.Currencies = self:GetConfigSummaryEnabledCurrencies();

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
				local name, isHeader, count, icon, earnedThisWeek, earnablePerWeek;
				local currencyInfo = {};
				for i = 1, self:GetVirtualNumCurrencies() do
					name, isHeader, count, icon, earnedThisWeek, earnablePerWeek = self:GetVirtualCurrencyInfo(i);
					if ( not isHeader and summary.Currencies[name]  ) then
						if ( icon and type(summary.Currencies[name]) ~= "string" ) then
							summary.Currencies[name] = icon;
						end
						currencyInfo[name] = {
							Count = count,
							Earned = earnedThisWeek,
							Cap = earnablePerWeek
						};
					end
				end
				characterInfo.CurrencyInfo = currencyInfo;
            end
			if ( self:GetConfigSummaryRaidInfo() and self:RaidEnabled() ) then
			    local savedDungeons = self:GetNumRaidFinderDungeons();
				local savedInstances = self:GetNumSavedInstances();
				local savedWorldBosses = self:GetNumSavedWorldBosses();
				local raidInfo = {};
				local id, index;
				local instanceName, instanceID, instanceReset, locked, extended, difficultyName, killed;
				local count = 0;
				for i = 1, savedDungeons + savedInstances + savedWorldBosses do
					index = i;
					if ( index <= savedDungeons ) then
						id = self:GetRaidFinderLineId(index);
						instanceName, _, instanceReset, _, locked, _, difficultyName, killed = self:GetRaidFinderInfo(id);
						extended = nil;
					elseif ( index <= savedDungeons + savedInstances ) then
						index = index - savedDungeons;
						id = self:GetInstanceLineId(index);
						instanceName, _, instanceReset, _, locked, extended, _, _, _, difficultyName = self:GetSavedInstanceInfo(id);
						killed = nil;
					elseif ( index <= savedDungeons + savedInstances + savedWorldBosses ) then
						index = index - savedDungeons - savedInstances;
						id = self:GetWorldBossLineId(index);
						instanceName, instanceID, instanceReset = self:GetSavedWorldBossInfo(id);
						locked = true;
						extended = nil;
						difficultyName = RAID_INFO_WORLD_BOSS;
						killed = nil;
					end
					if ( extended or locked ) then
						instanceReset = SecondsToTime(instanceReset, true, nil, 3);
						count = count + 1;
					else
						instanceReset = format("|cff808080%s|r", RAID_INSTANCE_EXPIRES_EXPIRED);
						instanceName = format("|cff808080%s|r", instanceName);
					end
					table.insert(raidInfo, {
						Name = instanceName,
						Difficulty = difficultyName,
						Reset = instanceReset,
						Killed = killed
					});
				end
				characterInfo.RaidInfo = raidInfo;
				characterInfo.RaidInfoDisplay = #raidInfo > 0 and (count == #raidInfo and count or count.."/"..#raidInfo) or "";
			end
            if ( self:GetConfigSummaryQuest() and self:HasQuestLog() ) then
                characterInfo.NumQuests = select(2, self:GetNumQuestLogEntries()) or 0;
                characterInfo.NumQuestHistoryEntries = select(2, self:GetNumQuestHistoryEntries()) or 0;
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
                    elseif ( text == "" and numItems > 0 ) then
						text = "0";
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

	local connectedRealms = {};
	for i = 1, #summary do
		if ( self:IsConnectedRealm(summary[i].Name) ) then
			connectedRealms[summary[i]] = i;
			summary[i].Connected = connectedRealms;
		end
	end
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
			columns = columns + select(2, self:GetConfigSummaryEnabledCurrencies());
        end
		if ( self:GetConfigSummaryRaidInfo() and self:RaidEnabled() ) then
            columns = columns + 1;
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

    local headerFont = self.summary:GetHeaderFont();
    headerFont:SetTextColor(GetTableColor(NORMAL_FONT_COLOR));

    local index, column = self.summary:AddHeader();
    local myColumn;

    myColumn = column; index, column = self.summary:SetCell(index, myColumn, "Interface\\Addons\\Armory\\Artwork\\" .. (self.summary.locked and "Unpin" or "Pin"), iconProvider);
    self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, (self.summary.locked and UNLOCK or LOCK) ); 
    self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
    self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnLockClick);

    myColumn = column; index, column = self.summary:SetCell(index, myColumn, NAME, headerFont, "LEFT", 2);
    self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "name");

    if ( self:GetConfigSummaryClass() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, CLASS, headerFont);
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "class");
    end
    if ( self:GetConfigSummaryLevel() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, LEVEL_ABBR, headerFont, "RIGHT");    
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "level");
    end
    if ( self:GetConfigSummaryItemLevel() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, ITEM_LEVEL_ABBR, headerFont, "CENTER");    
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "ilvl");
    end
    if ( self:GetConfigSummaryZone() ) then
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, ZONE, headerFont);
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "zone");
    end
    if ( self:GetConfigSummaryXP() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, XP, headerFont, "CENTER");
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "xp");
    end
    if ( self:GetConfigSummaryPlayed() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, PLAYED, headerFont, "CENTER");    
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "played");
    end
    if ( self:GetConfigSummaryOnline() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, LASTONLINE, headerFont, "RIGHT");
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "online");
    end
    if ( self:GetConfigSummaryMoney() ) then   
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, MONEY, headerFont, "CENTER");
        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, "money");
    end
    if ( self:GetConfigSummaryCurrency() ) then  
		for name, icon in pairs(summary.Currencies) do
            myColumn = column; index, column = self.summary:SetCell(index, myColumn, type(icon) == "string" and icon or "Interface\\Icons\\INV_Misc_QuestionMark", iconProvider);
            self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, name); 
            self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
            self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnColumnHeaderClick, name);
		end
    end
    if ( self:GetConfigSummaryRaidInfo() and self:RaidEnabled() ) then
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, "Interface\\PVPFrame\\Icon-Combat", iconProvider);
        self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, RAID_INFO); 
        self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
    end
    if ( self:GetConfigSummaryQuest() and self:HasQuestLog() ) then
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, "Interface\\GossipFrame\\AvailableQuestIcon", iconProvider);
        self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, QUESTS_LABEL); 
        self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
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
        myColumn = column; index, column = self.summary:SetCell(index, myColumn, TRADESKILLS, headerFont, "CENTER", 5);
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
					local currencyInfo;
					for name in pairs(summary.Currencies) do
						currencyInfo = characterInfo.CurrencyInfo[name];
						if ( currencyInfo ) then
							myColumn = column; index, column = self.summary:SetCell(index, myColumn, currencyInfo.Count > 0 and currencyInfo.Count or "", nil, "RIGHT");
							if ( currencyInfo.Cap ) then
								self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, {name, format(CURRENCY_WEEKLY_CAP, "", currencyInfo.Earned, currencyInfo.Cap)} ); 
								self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
							end
						else
							myColumn = column; index, column = self.summary:SetCell(index, myColumn, "");
						end
					end
                end
                if ( self:GetConfigSummaryRaidInfo() and self:RaidEnabled() ) then
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, characterInfo.RaidInfoDisplay, nil, "CENTER");
                    self.summary:SetCellScript(index, myColumn, "OnEnter", OnRaidInfoEnter, characterInfo);
                end
                if ( self:GetConfigSummaryQuest() and self:HasQuestLog() ) then
                    myColumn = column; index, column = self.summary:SetCell(index, myColumn, (characterInfo.NumQuests > 0 and characterInfo.NumQuests or "")..(characterInfo.NumQuestHistoryEntries > 0 and "/"..characterInfo.NumQuestHistoryEntries or ""), nil, "CENTER");
                    self.summary:SetCellScript(index, myColumn, "OnEnter", OnQuestsEnter, characterInfo);
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
                        self.summary:SetCellScript(index, myColumn, "OnEnter", CellShowTooltip, {character, skillInfo.Tooltip, ARMORY_OPEN_HINT}); 
                        self.summary:SetCellScript(index, myColumn, "OnLeave", CellHideTooltip); 
                        self.summary:SetCellScript(index, myColumn, "OnMouseDown", OnSkillClick, {realm=realm, character=character, skill=skillInfo.Name});
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

function Armory:HideSummary(force)
	if ( force ) then
		self.summary.locked = false;
	end
    if ( self.summary and not self.summary.locked ) then
        self.summary:SetScale(1);
        self.qtip:Release(self.summary);
        table.wipe(summary);
        self.summary = nil;
    end
end
