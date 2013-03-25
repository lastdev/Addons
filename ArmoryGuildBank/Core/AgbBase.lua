--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 585 2013-03-02T14:19:03Z
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

if ( not AGB ) then
    AGB = {};
end

if ( not AgbDB ) then
    AgbDB = {};
end

local AGB = AGB;
local Armory = Armory;

function AGB:Db()
    local realm = GetRealmName();
    local guild = GetGuildInfo("player");
    local refresh = (self.realm ~= realm or self.guild ~= guild);

    if ( realm and guild ) then
        if ( not AgbDB[realm] ) then
            AgbDB[realm] = {};
            self.dbEntry = nil;
        end
        if ( not AgbDB[realm][guild] ) then
            AgbDB[realm][guild] = {};
            self.dbEntry = nil;
        end
        if ( refresh or not self.dbEntry ) then
            self.realm = realm;
            self.guild = guild;
            self.dbEntry = ArmoryDbEntry:new(AgbDB[realm][guild]);
        end
    end

    return self.dbEntry;
end

local Orig_ArmoryClearDb = Armory.ClearDb;
function Armory:ClearDb(what, arg1, arg2)
    local invalidCommand = Orig_ArmoryClearDb(self, what, arg1, arg2);
    local frame = ArmoryGuildBankFrame;

    if ( what ) then
        what = strlower(what);

        if ( frame:IsVisible() ) then
            ArmoryGuildBankFrame_Toggle();
        end

        if ( what == strlower(ARMORY_CMD_DELETE_ALL) ) then
            AGB:DeleteDb();
        elseif ( what == strlower(ARMORY_CMD_DELETE_REALM)  ) then
            if ( not arg1 or arg1 == "" ) then
                arg1 = AGB.realm;
            end
            AGB:DeleteDb(arg1);
        elseif ( what == strlower(ARMORY_CMD_DELETE_GUILD) ) then
            if ( not arg1 or arg1 == "" ) then
                arg1 = AGB.guild;
            end
            if ( not arg2 or arg2 == "" ) then
                arg2 = AGB.realm;
            end
            if ( AgbDB[arg2] and AgbDB[arg2][arg1] ) then
                AGB:DeleteDb(arg2, arg1);
                self:Print(format(ARMORY_CMD_DELETE_GUILD_MSG, arg1, arg2));
            else
                self:Print(format(ARMORY_CMD_DELETE_GUILD_NOT_FOUND, arg1, arg2));
            end
            invalidCommand = false;
        end
    end

    return invalidCommand;
end

function AGB:SelectDb(frame, realm, guild)
    if ( not frame.initialized ) then
        self.dbEntry = nil;
    end
    
    local dbEntry = self:Db();
    local refresh;

    if ( not realm ) then
        realm = frame.selectedRealm or self.realm;
    end

    if ( not guild ) then
        guild = frame.selectedGuild or self.guild;
        if ( not guild ) then
            local guilds = self:GuildList(realm);
            if ( #guilds > 0 ) then
                guild = guilds[1];
            else
                realm, guild = self:FirstGuild();
            end
        end
    end

    if ( realm and guild and AgbDB[realm] and AgbDB[realm][guild] ) then
        dbEntry = ArmoryDbEntry:new(AgbDB[realm][guild]);
        refresh = (frame.selectedRealm ~= realm or frame.selectedGuild ~= guild);

        frame.selectedRealm = realm;
        frame.selectedGuild = guild;
        frame.selectedDbEntry = dbEntry;
    end

    return dbEntry, refresh;
end

function AGB:DeleteDb(realm, guild)
    local frame = ArmoryGuildBankFrame;
    if ( not AgbDB ) then
        return;
    elseif ( realm and not AgbDB[realm] ) then
        return;
    elseif ( guild and not AgbDB[realm][guild] ) then
        return;
    end
    
    self.dbLocked = true;
    
    if ( realm ) then
        if ( guild ) then
            AgbDB[realm][guild] = nil;
        else
            AgbDB[realm] = nil;
        end
    else
        AgbDB = {};
    end
    
    if ( realm and realm ~= self.realm and table.getn(self:GuildList(realm)) == 0 ) then
        AgbDB[realm] = nil;
    end
    
    if ( not realm or (realm == frame.selectedRealm and guild == frame.selectedGuild) ) then
        frame.selectedRealm = nil;
        frame.selectedGuild = nil;
        frame.selectedDbEntry = nil;
    end
    
    if ( not realm or (realm == self.realm and guild == self.guild) ) then
        frame.initialized = false;
    end
    
    self:SelectDb(frame);
    
    self.dbLocked = false;
end

function AGB:RealmList()
    local list = {};

    if ( AgbDB ) then
        for realm in pairs(AgbDB) do
            table.insert(list, realm);
        end
        table.sort(list);    
    end

    return list;
end

function AGB:GuildList(realm)
    local list = {};

    if ( realm and AgbDB and AgbDB[realm] ) then 
        for guild in pairs(AgbDB[realm]) do
            table.insert(list, guild);
        end
        table.sort(list);
    end

    return list;
end

function AGB:FirstGuild()
    local realm = GetRealmName();

    for _, guild in ipairs(self:GuildList(realm)) do
        if ( AgbDB[realm] and AgbDB[realm][guild] ) then
            return realm, guild;
        end
    end

    for _, realm in ipairs(self:RealmList()) do
        for _, guild in ipairs(self:GuildList(realm)) do
            if ( AgbDB[realm] and AgbDB[realm][guild] ) then
                return realm, guild;
            end
        end
    end
end

function AGB:SetValue(key, ...)
    if ( not self.dbLocked ) then
        local dbEntry = self:Db();
        dbEntry:SetValue(key, ...);
    end
end

function AGB:SetSubValue(key, subkey, ...)
   if ( not self.dbLocked ) then
        local dbEntry = self:Db();
        dbEntry:SetValue(2, key, subkey, ...);
    end
end

function AGB:UpdateTabName(tab, name)
    self:SetSubValue("Tab"..tab, "Name", name);
end

function AGB:UpdateTabIcon(tab, texture)
    self:SetSubValue("Tab"..tab, "Icon", texture);
end

function AGB:UpdateTabItems(tab, items, slots, checksum, timestamp)
    self:SetSubValue("Tab"..tab, "Items", items);
    self:SetSubValue("Tab"..tab, "Slots", slots);
    self:SetSubValue("Tab"..tab, "Checksum", checksum);

    local plainItems = {};
    local plainItemString;
    for itemString, count in pairs(items) do
        plainItemString = self:GetPlainItemString(itemString);
        if ( itemString ~= plainItemString ) then
            if ( plainItems[plainItemString] ) then
                plainItems[plainItemString] = plainItems[plainItemString] + count;
            else
                plainItems[plainItemString] = count;
            end
        end
    end
    self:SetSubValue("Tab"..tab, "Plain", plainItems);

    self:UpdateTimestamp(timestamp, tab);
end

function AGB:DeleteTab(tab)
    self:SetValue("Tab"..tab, nil);
end

function AGB:UpdateGuildInfo()
    self:SetValue("Tabard", GetGuildTabardFileNames());
    self:SetValue("Faction", UnitFactionGroup("player"));
end

function AGB:UpdateMoney(money)
    self:SetValue("Money", money or GetGuildBankMoney());
end

function AGB:UpdateTimestamp(timestamp, tab)
    timestamp = self:CreateTimestamp(timestamp);
    
    if ( tab == nil ) then
        self:SetValue("Time", timestamp);
    else
        self:SetSubValue("Tab"..tab, "Time", timestamp);
    end
end

function AGB:CreateTimestamp(timestamp)
    if ( type(timestamp) == "string" ) then
        timestamp = tonumber(timestamp);
    end
    return Armory:MinutesTime(timestamp);
end

function AGB:GetValue(dbEntry, ...)
    return dbEntry:GetValue(...);
end

function AGB:GetTabValue(dbEntry, tab, ...)
    return dbEntry:GetValue("Tab"..tab, ...);
end

function AGB:TabExists(dbEntry, tab)
    return dbEntry:Contains("Tab"..tab);
end

function AGB:GetTimestamp(dbEntry)
    return self:GetValue(dbEntry, "Time");
end

function AGB:GetMoney(dbEntry)
    return self:GetValue(dbEntry, "Money");
end

function AGB:GetTabardFiles(dbEntry)
    return self:GetValue(dbEntry, "Tabard");
end

function AGB:GetFaction(dbEntry)
    return self:GetValue(dbEntry, "Faction");
end

function AGB:GetTabName(dbEntry, tab)
    return self:GetTabValue(dbEntry, tab, "Name");
end

function AGB:GetTabIcon(dbEntry, tab)
    return self:GetTabValue(dbEntry, tab, "Icon");
end

function AGB:GetTabItems(dbEntry, tab)
    return self:GetTabValue(dbEntry, tab, "Items"), self:GetTabValue(dbEntry, tab, "Plain");
end

function AGB:GetTabSlots(dbEntry, tab)
    return self:GetTabValue(dbEntry, tab, "Slots");
end

function AGB:GetTabTimestamp(dbEntry, tab)
    return self:GetTabValue(dbEntry, tab, "Time");
end

function AGB:GetTabChecksum(dbEntry, tab)
    return self:GetTabValue(dbEntry, tab, "Checksum");
end

function AGB:GetItemCount(dbEntry, tab, itemId)
    local items, plain = self:GetTabItems(dbEntry, tab);
    local count;
    if ( items ) then
        itemId = self:GetPlainItemString(itemId);
        if ( plain ) then
            count = plain[itemId];
        end
        if ( not count ) then
            if ( type(items[itemId]) == "table" ) then
                _, _, _, count = unpack(items[itemId]);
            else
                count = items[itemId];
            end
        end
    end
    return count;
end

function AGB:GetTabItemInfo(dbEntry, tab, itemId)
    local items = self:GetTabItems(dbEntry, tab);
    local name, link, texture, count, getItem;
    if ( items ) then
        getItem = type(items[itemId]) == "number";
        if ( not getItem ) then
            name, link, texture, count = unpack(items[itemId]);
            -- bug fix: name can still be empty when cache has been cleared ("|cffffffff|Hitem:22787:0:0:0:0:0:0:0:44|h[]|h|r")
            if ( (name or "") == "" ) then
                items[itemId] = count;
                getItem = true;
            end
        end
        if ( getItem ) then
            count = items[itemId];
            name, link, texture = self:GetItemInfo(itemId);
            if ( (name or "") ~= "" ) then
                items[itemId] = {name, link, texture, count};
            end
        end
    end
    return name, link, texture, count;
end

function AGB:GetTabSlotItem(dbEntry, tab, slot)
    local slots = self:GetTabSlots(dbEntry, tab);
    local key = tostring(slot);
    local itemId, count;
    if ( slots and slots[key] ) then
        itemId, count = strsplit(";", slots[key]);
        count = tonumber(count);
    end
    return itemId, count;
end

function AGB:GetTabSlotInfo(dbEntry, tab, slot)
    local itemId, count = self:GetTabSlotItem(dbEntry, tab, slot);
    local name, link, texture;
    if ( itemId ) then
        name, link, texture = self:GetTabItemInfo(dbEntry, tab, itemId);
    end
    return name, link, texture, count;
end

function AGB:GetItemInfo(itemString)
    local link;
    
    -- Caged pet
    local id, icon, name = itemString:match("(.+)|(.+)|(.+)");
    if ( name ) then
        return name, Armory:GetLink("battlepet", id, name), "Interface\\Icons\\"..icon;
    end

    -- phase 1: try to get the info from the game tooltip
    local tooltip = Armory:AllocateTooltip();
    Armory:SetHyperlink(tooltip, "item:"..itemString);
    name, link = tooltip:GetItem();
    Armory:ReleaseTooltip(tooltip);

    -- phase 2: try to get the name from game tooltip link 
    if ( link and (name or "") == "" ) then
        name = Armory:GetNameFromLink(link);
    end

    -- phase 3: try GetItemInfo 
    if ( not link and (name or "") == "" ) then
        name, link = _G.GetItemInfo(itemString:match("^([-%d]+)"));
    end

    -- almost the same for the icon
    texture = _G.GetItemIcon(link);
    if ( not texture ) then
        _, _, _, _, _, _, _, _, _, texture = _G.GetItemInfo(link);
    end

    return name, link, texture;
end

function AGB:GetPlainItemString(itemString)
    local itemId, suffixId = Armory:GetItemId("item:"..itemString);
    if ( not suffixId ) then
        return itemString;
    end
    -- itemId:enchantId:jewelId1:jewelId2:jewelId3:jewelId4:suffixId:uniqueId
    return itemId..":0:0:0:0:0:"..suffixId;
end

function AGB:SetFilter(frame, text)
    local refresh;
    text = Armory:NormalizeInventoryFilterText(text);
    if ( text ) then
        refresh = (frame.filter ~= text);
        frame.filter = text;
    end
    return refresh;
end

function AGB:UpdateItemLines(frame)
    local dbEntry = frame.selectedDbEntry;
    local include;
    
    if ( frame.itemLines ) then
        table.wipe(frame.itemLines);
    else
        frame.itemLines = {};
    end

    if ( dbEntry ) then
        local name, count, link, texture, timestamp;
        for i = 1, MAX_GUILDBANK_TABS do
            if ( self:TabExists(dbEntry, i) ) then
                name = self:GetTabName(dbEntry, i);
                if ( not name or name == "" ) then
                    name = string.format(GUILDBANK_TAB_NUMBER, i);
                else
                    name = string.format(GUILDBANK_TAB_NUMBER, i).." "..name;
                end
                name = name..", ";

                timestamp = self:GetTabTimestamp(dbEntry, i);
                if ( timestamp > 0 ) then
                    name = name..date("%x %H:%M", timestamp);
                else
                    name = name..UNKNOWN;
                end
                table.insert(frame.itemLines, {name, i});

                if ( not self:GetTabLineState(frame, i) ) then
                    local list = {};
                    local items = self:GetTabItems(dbEntry, i);
                    if ( items ) then
                        for itemId in pairs(items) do
                            name, link, texture, count = self:GetTabItemInfo(dbEntry, i, itemId);
                            if ( name and Armory:MatchInventoryItem(frame.filter or "", name, link, true) ) then
                                table.insert(list, {name, nil, count, texture, link});
                            end
                        end
                        table.sort(list, function(a, b) return a[1] < b[1]; end);
                    end

                    for _, v in ipairs(list) do
                        table.insert(frame.itemLines, v);
                    end
                end
            end
        end
    end
end

function AGB:GetTabLineState(frame, tab)
    local key = frame.selectedRealm .. frame.selectedGuild;
    if ( frame.collapsedTabs and frame.collapsedTabs[key] ) then
        return frame.collapsedTabs[key][tab];
    end
end

function AGB:SetTabLineState(frame, tab, isCollapsed)
    local key = frame.selectedRealm .. frame.selectedGuild;
    if ( not frame.collapsedTabs ) then
        frame.collapsedTabs = {};
    end
    if ( not frame.collapsedTabs[key] ) then
        frame.collapsedTabs[key] = {};
    end
    if ( tab == 9999 ) then
        for i = 1, MAX_GUILDBANK_TABS do
            frame.collapsedTabs[key][i] = isCollapsed;
        end
    else
        frame.collapsedTabs[key][tab] = isCollapsed;
    end
end

function AGB:IsOnline(member)
    local name;

    if ( IsInGuild() ) then
        GuildRoster();

        for i = 1, GetNumGuildMembers() do
            name = GetGuildRosterInfo(i);
            if ( member == name ) then
                return true;
            end
        end
    end
end

function AGB:Checksum(text)
    local a = 1;
    for i = 1, text:len(), 3 do
        a = (a * 8257 % 16777259) + text:byte(i) + ((text:byte(i + 1) or 1) * 127) + ((text:byte(i + 2) or 2) * 16383);
    end
    return string.format("%x", a % 16777213);
end

function AGB:PrintDebug(...)
    if ( self.debug ) then
        Armory:PrintDebug("AGB"..FONT_COLOR_CODE_CLOSE, ...);
    end
end

function AGB:Find(...)
    local frame = ArmoryGuildBankFrame;
    local currentRealm, currentGuild = frame.selectedRealm, frame.selectedGuild;
    local list = {};
    local dbEntry, container, items, name, link, itemCount;

    if ( AGB:GetConfigIncludeInFind() ) then
        for realm, guilds in pairs(AgbDB) do
            if ( Armory:GetConfigGlobalSearch() or realm == self.realm ) then
                for guild in pairs(guilds) do
                    dbEntry = self:SelectDb(frame, realm, guild);
                    for i = 1, MAX_GUILDBANK_TABS do
                        if ( self:TabExists(dbEntry, i) ) then
                            container = self:GetTabName(dbEntry, i);
                            items = self:GetTabItems(dbEntry, i);
                            if ( items ) then
                                for id in pairs(items) do
                                    name, link, _, itemCount = self:GetTabItemInfo(dbEntry, i, id);
                                    if ( Armory:GetConfigExtendedSearch() ) then
                                        text = Armory:GetTextFromLink(link);
                                    else
                                        text = name;
                                    end
                                    if ( Armory:FindTextParts(text, ...) ) then
                                        if ( itemCount > 1 ) then
                                            table.insert(list, {realm=realm, guild=guild, label=container, name=name, link=link, count=itemCount});
                                        else
                                            table.insert(list, {realm=realm, guild=guild, label=container, name=name, link=link});
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        self:SelectDb(frame, currentRealm, currentGuild);
    end
    
    return list;
end
