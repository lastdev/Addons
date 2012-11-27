--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 473 2012-02-27T00:29:03Z
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

local AGB = AGB;
local Armory = Armory;

ARMORY_GUILDBANK_MESSAGE_TYPE = { BANK_SYNC_PUSH = "BSP", BANK_SYNC_REQUEST = "BSR" };

ARMORY_GUILDBANK_SYNC_TABLE = {};
ARMORY_GUILDBANK_SYNC_DELAY_MIN = 60;
ARMORY_GUILDBANK_SYNC_DELAY_MAX = 180;

ARMORY_GUILDBANK_QUEUE = {};
ARMORY_GUILDBANK_QUEUE_WAIT_TIME = 10;

ARMORY_GUILDBANK_PUSH_DELAY = 10;

ARMORY_GUILDBANK_PROTOCOL_VERSION = "6";

function AGB:Push()
    Armory:ExecuteDelayed(ARMORY_GUILDBANK_PUSH_DELAY, self.InfoPusher);
end

function AGB.InfoPusher()
    AGB:PushInfo();
end

function AGB:PushInfo()
    local dbEntry = self:Db();

    if ( not Armory:HasDataSharing() ) then
        self:PrintDebug("Sharing disabled");
        return;

    elseif ( dbEntry and ArmoryAddonMessageFrame_CanSend(true) ) then
        local money = self:GetMoney(dbEntry);
        local tabs = {};
        local name, timestamp, checksum;

        for i = 1, MAX_GUILDBANK_TABS do
            name = self:GetTabName(dbEntry, i);
            if ( name ) then
                name = self:Checksum(name);
                if ( self:GetTabSlots(dbEntry, i) ) then
                    timestamp = self:GetTabTimestamp(dbEntry, i);
                    checksum  = self:GetTabChecksum(dbEntry, i);
                else
                    timestamp = 0;
                    checksum = "";
                    self:PrintDebug("Lost my data of tab", name, "somehow, will request for new data");
                end
                table.insert(tabs, strjoin(ARMORY_LOOKUP_CONTENT_SEPARATOR, i, name, timestamp, checksum));
            end
        end

        timestamp = self:GetTimestamp(dbEntry);

        if ( timestamp ) then
            local id = ARMORY_GUILDBANK_MESSAGE_TYPE.BANK_SYNC_PUSH;
            local version = ARMORY_GUILDBANK_PROTOCOL_VERSION;
            local message = strjoin(ARMORY_LOOKUP_SEPARATOR, money, table.concat(tabs, ARMORY_LOOKUP_FIELD_SEPARATOR), timestamp, time());

            self:PrintDebug("Pushing", #tabs, "tab(s)");
            ArmoryAddonMessageFrame_Send(id, version, ArmoryAddonMessageFrame_Compress(message), "GUILD", -1);

            self.pushed = ArmoryAddonMessageFrame_GetModule(id).msgno;
        end
    end
end

function AGB:PushReceived(version, message, msgNumber, sender)
    local dbEntry = self:Db();
    
    if ( not self.pushed ) then
        return;
    elseif ( sender == UnitName("player") ) then
        self:PrintDebug("Push echo received of message #", msgNumber, "(waiting for #", self.pushed..")");
        self.serverLag = (msgNumber < self.pushed);

    elseif ( self.serverLag ) then
        self:PrintDebug("Ignore push from", sender, "because I'm not sync with server message queue");

    elseif ( version ~= ARMORY_GUILDBANK_PROTOCOL_VERSION ) then
        self:PrintDebug("Ignore push from", sender, "wrong protocol version", version);

    elseif ( dbEntry ) then
        local money, tabs, timestamp, remoteTime = strsplit(ARMORY_LOOKUP_SEPARATOR, ArmoryAddonMessageFrame_Decompress(message));
        local offset = self:CreateTimestamp() - self:CreateTimestamp(remoteTime);
        local dbTime = self:GetTimestamp(dbEntry) or 0;
        
        self:PrintDebug("Push received from", sender, "time offset", offset);

        -- sanity check
        if ( dbTime > time() ) then
            self:PrintDebug("Wrong db time, clearing time");
            self:UpdateTimestamp(0);
            dbTime = 0;
        end

        -- if general info is newer, just save it
        timestamp = tonumber(timestamp) + offset;
        if ( timestamp > time() ) then
            self:PrintDebug("Time in message " .. date("%x %H:%M", timestamp) .. " in future; ignoring update");
        elseif ( timestamp > dbTime ) then
            self:PrintDebug("Updating money", money, "timestamp", date("%x %H:%M", timestamp) );
            self:UpdateMoney(tonumber(money));
            self:UpdateTimestamp(timestamp);
        end

        -- get a list of outdated tabs
        local outdatedTabs = {};
        local tab, hash, checksum, name;
        local dbHash;
        local push;
        for _, tabInfo in ipairs(Armory:StringSplit(ARMORY_LOOKUP_FIELD_SEPARATOR, tabs)) do
            tab, hash, timestamp, checksum = strsplit(ARMORY_LOOKUP_CONTENT_SEPARATOR, tabInfo);
            if ( timestamp ) then
                timestamp = tonumber(timestamp) + offset;

                if ( ARMORY_GUILDBANK_QUEUE[tab] ) then
                    dbTime, dbHash = unpack(ARMORY_GUILDBANK_QUEUE[tab]);
                    self:PrintDebug("Using timestamp and hash from queue for tab", tab);
                elseif ( self:GetTabSlots(dbEntry, tab) ) then
                    dbTime = self:GetTabTimestamp(dbEntry, tab);
                    dbHash = self:GetTabChecksum(dbEntry, tab);
                elseif ( self:GetTabName(dbEntry, tab) ) then
                    dbTime = 0;
                    dbHash = "";
                    self:PrintDebug("Items of tab", tab, "not found, trying to mark it as outdated");
                else
                    dbTime = nil;
                    dbHash = nil;
                end

                if ( dbTime ) then
                    if ( dbTime > time() ) then
                        self:PrintDebug("Wrong db time, clearing time for tab", tab);
                        self:UpdateTimestamp(0, tab);
                    
                    elseif ( timestamp > time() ) then
                        self:PrintDebug("Time in message " .. date("%x %H:%M", timestamp) .. " in future; ignoring update for tab", tab);

                    elseif ( timestamp > dbTime ) then
                        name = self:GetTabName(dbEntry, tab) or "";
                        if ( self:Checksum(name) ~= hash ) then
                            self:PrintDebug("Wrong hash", hash, ", deleting tab", tab, name);
                            self:DeleteTab(tab);
                            ArmoryGuildBankFrame_Refresh();
                            ArmoryInventoryGuildBankFrame_Refresh();

                        elseif ( dbHash ~= checksum ) then
                            self:PrintDebug("Items of tab", tab, "are outdated, will request update");
                            self.awaitingUpdate = true;
                            table.insert(outdatedTabs, {tab, name, timestamp, checksum});

                        else
                            self:PrintDebug("Adjust time of tab", tab);
                            self:UpdateTimestamp(timestamp, tab);

                        end

                    elseif ( dbTime > timestamp ) then
                        self:PrintDebug("My tab", tab, "is newer than", date("%x %H:%M", timestamp), ", will push if no outdated" );
                        push = true;
                        
                    end 
                end
            end
        end

        if ( #outdatedTabs > 0 ) then
            if ( not self.syncLock ) then

                -- keep the sync info for some random period of time before asking for an update
                local sync = ARMORY_GUILDBANK_SYNC_TABLE;
                for i = 1, #outdatedTabs do
                    tab, name, timestamp, checksum = unpack(outdatedTabs[i]);
                    if ( not sync[tab] ) then
                        sync[tab] = {};
                    end
                    if ( (not sync[tab].timestamp) or timestamp > sync[tab].timestamp ) then
                        self:PrintDebug("Adding tab", tab, "to sync table, timestamp", date("%x %H:%M", tonumber(timestamp)), "member to query", sender );
                        sync[tab].name = name;
                        sync[tab].timestamp = timestamp;
                        sync[tab].checksum = checksum;
                        sync[tab].members = {{sender, version}};

                    elseif ( sync[tab].timestamp == timestamp ) then
                        local found;
                        for _, memberInfo in ipairs(sync[tab].members) do
                            if ( memberInfo[1] == sender ) then
                                found = true;
                                break;
                            end
                        end

                        if ( not found ) then
                            self:PrintDebug("Adding", sender, "to members to query for tab", tab);
                            table.insert(sync[tab].members, {sender, version});
                        else
                            self:PrintDebug(sender, "has already been added to be queried for tab", tab);
                        end
                    end
                end

                -- note: will not overwrite if one is scheduled already
                local delay = random(ARMORY_GUILDBANK_SYNC_DELAY_MIN, ARMORY_GUILDBANK_SYNC_DELAY_MAX);
                self:PrintDebug("Processing sync table in", delay, "seconds (only first scheduled call will be invoked)");
                Armory:ExecuteDelayed(delay, self.Synchronizer);
            else
                self:PrintDebug("Ignore, sync table locked");
            end

        elseif ( self.awaitingUpdate ) then
            self:PrintDebug("Ignore, waiting to get updated myself");

        elseif ( push ) then
            -- join the broadcast to spread the load if we are current
            self:Push();

        else
            self:PrintDebug("Ignore, I have neither outdated nor newer tabs or no tabs at all");

        end
    end
end

function AGB.Synchronizer()
    AGB:ProcessSyncTable();
end

function AGB:ProcessSyncTable()
    if ( not ArmoryAddonMessageFrame_CanSend(true) ) then
        return;
    end

    self:PrintDebug("Processing sync table..." );

    local members = {};
    local target, index, tabInfo, version;

    self.syncLock = true;

    ARMORY_GUILDBANK_QUEUE = {};

    -- find random targets to whisper for an update
    for tab, info in pairs(ARMORY_GUILDBANK_SYNC_TABLE) do
        tabInfo = strjoin(ARMORY_LOOKUP_FIELD_SEPARATOR, tab, info.name);
        repeat
            index = random(1, #info.members);
            target, version = unpack(info.members[index]);
            table.remove(info.members, index);
            self:PrintDebug("Selected", target, "for tab", tab);

            if ( not self:IsOnline(target) ) then
                self:PrintDebug(target, " is offline");
                target = nil;
            end
        until ( target or #info.members == 0 )

        if ( target ) then
            if ( members[target] ) then
                table.insert(members[target].tabs, tabInfo);
            else
                members[target] = {version=version, tabs={tabInfo}};
            end

            ARMORY_GUILDBANK_QUEUE[tab] = {info.timestamp, info.checksum};
        end

        ARMORY_GUILDBANK_SYNC_TABLE[tab] = nil;
    end

    self.syncLock = false;

    local sent;
    for target, info in pairs(members) do
        local id = ARMORY_GUILDBANK_MESSAGE_TYPE.BANK_SYNC_REQUEST;
        local version = info.version;
        local message = table.concat(info.tabs, ARMORY_LOOKUP_SEPARATOR);
        
        self:PrintDebug("Sending request to", target, "for tab(s)", table.concat(info.tabs, " "):gsub("%c", " "));
        ArmoryAddonMessageFrame_CreateRequest(id, version, message, "TARGET:"..target);
        sent = true;
    end

    self.awaitingUpdate = sent;
end

function AGB:ProcessSyncRequest(version, message, msgNumber, sender)
    local dbEntry = self:Db();

    if ( version ~= ARMORY_GUILDBANK_PROTOCOL_VERSION ) then
        Armory:PrintCommunication(string.format(ARMORY_LOOKUP_IGNORED, ARMORY_IGNORE_REASON_VERSION));

    elseif ( dbEntry ) then
        local tabs = Armory:StringSplit(ARMORY_LOOKUP_SEPARATOR, message);
        local list = {};

        self:PrintDebug("Request received from", sender);

        for i = 1, #tabs do
            local tab, name = strsplit(ARMORY_LOOKUP_FIELD_SEPARATOR, tabs[i]);
            local slots = self:GetTabSlots(dbEntry, tab);
            if ( slots and self:GetTabName(dbEntry, tab) == name ) then
                local timestamp = self:GetTabTimestamp(dbEntry, tab);
                local checksum = self:GetTabChecksum(dbEntry, tab);

                self:PrintDebug("Getting items for tab", tab, "timestamp", date("%x %H:%M", timestamp), "checksum", checksum);

                local items = {};
                for slot in pairs(slots) do
                    local itemId, count = self:GetTabSlotItem(dbEntry, tab, slot);
                    if ( items[itemId] ) then
                        items[itemId] = items[itemId]..";"..slot;
                    else
                        items[itemId] = slot;
                    end
                    if ( count > 1 ) then
                        items[itemId] = items[itemId]..":"..count;
                    end
                end
                
                local values = {};
                for itemId in pairs(items) do
                    table.insert(values, itemId.."="..items[itemId]);
                end

                table.insert(list, strjoin(ARMORY_LOOKUP_FIELD_SEPARATOR, tab, timestamp, checksum, table.concat(values, ARMORY_LOOKUP_CONTENT_SEPARATOR))); 

                Armory:PrintCommunication(string.format(ARMORY_LOOKUP_REQUEST_DETAIL, GUILDBANK_TAB_COLON.." "..tab));
            else
                self:PrintDebug("Ignore, requested tab", name, "not found or doesn't contain requested data");
            end
        end

        if ( #list > 0 ) then
            local id = ARMORY_GUILDBANK_MESSAGE_TYPE.BANK_SYNC_REQUEST;
            local message = time()..ARMORY_LOOKUP_SEPARATOR..table.concat(list, ARMORY_LOOKUP_SEPARATOR);

            ArmoryAddonMessageFrame_Send(id, version, ArmoryAddonMessageFrame_Compress(message), "TARGET:"..sender, 0);
            Armory:PrintCommunication(string.format(ARMORY_LOOKUP_RESPONSE_SENT, sender));
        end
    end
end

function AGB:CheckResponse()
    -- requests can be sent to multiple members, so wait for more replies
    if ( ArmoryAddonMessageFrame_GetModule(ARMORY_GUILDBANK_MESSAGE_TYPE.BANK_SYNC_REQUEST).numReplies > 0 ) then
        -- note: does nothing if already scheduled for execution
        Armory:ExecuteDelayed(ARMORY_GUILDBANK_QUEUE_WAIT_TIME, self.ResponseProcessor);
    end
end

function AGB.ResponseProcessor()
    AGB:ProcessResponse();
end

function AGB:ProcessResponse()
    local module = ArmoryAddonMessageFrame_GetModule(ARMORY_GUILDBANK_MESSAGE_TYPE.BANK_SYNC_REQUEST);
    local dbEntry = self:Db();
    local tabs, timestamp, checksum, values, itemId, info, count, slotInfo, slot, total;
    local remoteTime, offset;
    local updated;

    self:PrintDebug("Processing responses");

    for sender, reply in pairs(module.replies) do
        if ( reply.version == ARMORY_GUILDBANK_PROTOCOL_VERSION ) then
            tabs = Armory:StringSplit(ARMORY_LOOKUP_SEPARATOR, ArmoryAddonMessageFrame_Decompress(reply.message));

            remoteTime = tonumber(tabs[1]);
            table.remove(tabs, 1);

            offset = self:CreateTimestamp(reply.timestamp or remoteTime) - self:CreateTimestamp(remoteTime);
         
            self:PrintDebug("Processing", #tabs, "tab(s) from", sender);

            for i = 1, #tabs do
                tab, timestamp, checksum, values = strsplit(ARMORY_LOOKUP_FIELD_SEPARATOR, tabs[i]);
                timestamp = tonumber(timestamp) + offset;

                if ( self:GetTabName(dbEntry, tab) ) then
                    values = Armory:StringSplit(ARMORY_LOOKUP_CONTENT_SEPARATOR, values);

                    self:PrintDebug("Processing values for tab", tab);

                    local items = {};
                    local slots = {};
                    for _, value in ipairs(values) do
                        itemId, info = strsplit("=", value);
                        slotInfo = Armory:StringSplit(";", info);
                        total = 0;
                        for _, v in ipairs(slotInfo) do
                            slot, count = strsplit(":", v);
                            slots[slot] = itemId..";"..(count or 1);
                            total = total + (count or 1);
                        end
                        items[itemId] = total;
                    end

                    self:UpdateTabItems(tab, items, slots, checksum, timestamp);
                    updated = true;
                else
                    self:PrintDebug("Ignore, tab", tab, "has been deleted");
                end
            end
        else
            self:PrintDebug("Wrong protocol version", reply.version);
        end
        ArmoryAddonMessageFrame_RemoveReply(module, sender);
    end

    ARMORY_GUILDBANK_QUEUE = {};

    self.awaitingUpdate = false;

    if ( updated ) then
        ArmoryGuildBankFrame_Refresh();
        ArmoryInventoryGuildBankFrame_Refresh();
        
        self:Push();
    end
end

function AGB:ProcessRequest(id, version, message, msgNumber, sender, channel)
    if ( id == ARMORY_GUILDBANK_MESSAGE_TYPE.BANK_SYNC_PUSH ) then
        self:PushReceived(version, message, msgNumber, sender);

    elseif ( id == ARMORY_GUILDBANK_MESSAGE_TYPE.BANK_SYNC_REQUEST ) then
        self:ProcessSyncRequest(version, message, msgNumber, sender);

    end
end

function AGB:RemoveFromQueue(tab)
    if ( not self.syncLock ) then
        ARMORY_GUILDBANK_QUEUE[tab] = nil;
        ARMORY_GUILDBANK_SYNC_TABLE[tab] = nil;
    end
end
