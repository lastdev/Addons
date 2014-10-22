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

local _;

ArmoryDbEntry = {};
ArmoryDbEntry.__index = ArmoryDbEntry;

----------------------------------------------------------
-- Constructor
----------------------------------------------------------

function ArmoryDbEntry:new(db)
    local self = {};
    setmetatable(self, ArmoryDbEntry);
    if ( db.db and db.orig ) then
        self.db = db.db;
        self.orig = db.orig;
    else
        self.db = db;
        self.orig = db;
    end
    return self;
end

----------------------------------------------------------
-- Methods
----------------------------------------------------------

function ArmoryDbEntry:Contains(...)
    return self:SelectValue(...) ~= nil;
end

----------------------------------------------------------

function ArmoryDbEntry:Clear(key)
    local db = self.db;

    if ( key ~= nil ) then
        if ( type(db[key]) == "table" ) then
            db = db[key];
        else
            db[key] = nil;
            return;
        end
    end

    table.wipe(db);
end

function ArmoryDbEntry:ClearContainer(key)
    local db = self.db;

    if ( type(db[key]) == "table" ) then
        table.wipe(db[key]);
    else
        db[key] = {};
    end
end

function ArmoryDbEntry:SelectContainer(...)
    local db = self.db;
    local created, key;

    for i = 1, select("#", ...) do
        key = select(i, ...);
        if ( db[key] == nil ) then
            db[key] = {};
            created = true;
        end
        db = db[key];
    end

    return db, created;
end

function ArmoryDbEntry:SelectValue(...)
    local db = self.db;
    local key;
    if ( select("#", ...) > 0 ) then
        for i = 1, select("#", ...) do
            key = select(i, ...);
            if ( key == nil or db[key] == nil ) then
                return;
            end
            db = db[key];
        end
        return db;
    end
end
----------------------------------------------------------

function ArmoryDbEntry:SetPosition(...)
    local oldPosition = self.db;
    local newEntry = false;
    local key;

    for i = 1, select("#", ...) do
        key = select(i, ...);
        _, newEntry = self:SelectContainer(key);
        self.db = self.db[key];
    end

    return oldPosition, newEntry;
end

function ArmoryDbEntry:ResetPosition(position)
    if ( not position ) then
        self.db = self.orig;
    else
        self.db = position;
    end
end

----------------------------------------------------------

local function GetParams(i, j, ...)
    if ( j == nil ) then
        return select(i, ...);
    else
        local value = select(i, ...);
        if ( i < j ) then
            return value, GetParams(i + 1, j, ...);
        else
            return value;
        end
    end
end

function ArmoryDbEntry:SetValue(key, ...)
    local db = self.db;
    if ( type(key) == "number" ) then
        local offset = key + 1;
        if ( key > 1 ) then
            db = self:SelectContainer(GetParams(1, key - 1, ...));
        end
        key = select(key, ...);
        db[key] = self.Save(GetParams(offset, nil, ...));
    else
        db[key] = self.Save(...);
    end
end

function ArmoryDbEntry:GetValue(...)
    local value = self:SelectValue(...);
    if ( value ~= nil ) then
        return self.Load(value);
    end
end

function ArmoryDbEntry:GetNumValues(...)
    local value = self:SelectValue(...);
    if ( value ) then
        return self.NumValues(value);
    else
        return 0;
    end
end

----------------------------------------------------------

function ArmoryDbEntry:SetExpandableListValues(key, funcNumLines, funcGetLineState, funcGetLineInfo, funcExpand, funcCollapse, funcAdditionalInfo, funcSelect)
    local collapsedHeaders;
    local failed, isCollapsed;

    if ( funcExpand and funcCollapse ) then
        collapsedHeaders = {};
        for i = funcNumLines(), 1, -1 do
            local isHeader, isExpanded = funcGetLineState(i);
            if ( isHeader and not isExpanded ) then
                table.insert(collapsedHeaders, i);
                funcExpand(i);
            end
        end
    end

    local container = self:SelectContainer(key);
    local oldNumLines = #container;
    local newNumLines = funcNumLines();
    local values;
    for i = 1, max(oldNumLines, newNumLines) do
        if ( i > newNumLines ) then
            container[i] = nil;
        elseif ( funcAdditionalInfo ) then
            values = self:SelectContainer(key, i);
            if ( funcGetLineInfo(i) ) then
                values.Info = self.Save(funcGetLineInfo(i));
                if ( funcGetLineState(i) ) then
                    values.Data = nil;
                else
                    if ( funcSelect ) then
                        funcSelect(i);
                    end
                    values.Data = self.Save(funcAdditionalInfo(i));
                end
            else
                failed = true;
            end
        elseif ( funcGetLineInfo(i) ) then
            container[i] = self.Save(funcGetLineInfo(i));
        else
            failed = true;
        end
    end

    if ( collapsedHeaders and #collapsedHeaders > 0 ) then
        table.sort(collapsedHeaders);
        for _, i in pairs(collapsedHeaders) do
            funcCollapse(i);
        end
        isCollapsed = true;
    end
    
    return (not failed), isCollapsed;
end

----------------------------------------------------------
-- Static methods
----------------------------------------------------------

function ArmoryDbEntry.Save(...)
    local n = select("#", ...);
    if ( n == 0 ) then
        return nil;
    elseif ( type(select(1, ...)) == "table" ) then
        if ( next(select(1, ...)) ) then
            return ...;
        else
            return nil;
        end
    elseif ( Armory:GetConfigUseEncoding() ) then
        return ArmoryDbEntry.Encode(...);
    elseif ( n == 1 ) then
        return ...;
    elseif ( n > 1 ) then
        local t = { count=n };
        for i = 1, n do
            t[tostring(i)] = select(i, ...);
        end
        return t;
    end
end

function ArmoryDbEntry.Load(t, i)
    if ( ArmoryDbEntry.IsNativeTable(t) ) then
        i = i or 1;
        if ( i <= t.count ) then
            return t[tostring(i)], ArmoryDbEntry.Load(t, i + 1);
        end
    elseif ( ArmoryDbEntry.IsBinary(t) ) then
        return ArmoryDbEntry.Decode(t);
    else
        return t;
    end
end

function ArmoryDbEntry.NumValues(t)
    if ( type(t) == "table" ) then
        if ( t.count == nil ) then
            return #t;
        else
            return t.count;
        end
    elseif ( t ) then
        return 1;
    else
        return 0;
    end
end

function ArmoryDbEntry.IsNativeTable(t)
    return ( type(t) == "table" and t.count ~= nil );
end

function ArmoryDbEntry.IsBinary(v)
    return ( type(v) == "string" and #v > 0 and v:byte(1) <= 8 );
end

----------------------------------------------------------
-- Encoding methods
----------------------------------------------------------

local TYPE_NULL = 0x00;
local TYPE_STR = 0x01;
local TYPE_BIGSTR = 0x02;
local TYPE_INT = 0x03;
local TYPE_REAL = 0x04;
local TYPE_TRUE = 0x05;
local TYPE_FALSE = 0x06;
local TYPE_ICON = 0x07;
local TYPE_LINK = 0x08;

local LINK_ITEM = 0x10;
local LINK_ACHIEVEMENT = 0x20;
local LINK_TALENT = 0x30;
local LINK_SPELL = 0x40;
local LINK_TRADE = 0x50;
local LINK_ENCHANT = 0x60;
local LINK_QUEST = 0x70;
local LINK_GLYPH = 0x80;
local LINK_BATTLEPET = 0x90;

local band = bit.band;
local char = string.char;
local floor = math.floor;

local function Int2Bytes(value)
    local len = 0;
    local endValue = value < 0 and -1 or 0;
    local endSign = band(endValue, 128);
    local bytes = "";
    local byte, sbyte;

    -- Use a 2's complement representation in the fewest number of octets possible.
    while ( len == 0 or value ~= endValue or band(sbyte, 128) ~= endSign ) do
        byte = band(value, 255);
        if ( byte > 127 ) then
            sbyte = byte - 256;
        else
            sbyte = byte;
        end
        bytes = char(byte)..bytes;
        value = floor(value / 256);
        len = len + 1;
    end

    return bytes, len;
end

local function Bytes2Int(bytes)
    local byte = bytes:byte(1);
    local value = band(byte, 128) ~= 0 and -1 or 0;

    value = value * 256 + byte;
    for i = 2, #bytes do
        byte = bytes:byte(i);
        value = value * 256 + byte;
    end

    return value;
end

local function Real2Int(value)
    local scale = 0;
    repeat
        value = value * 10;
        scale = scale + 1;
    until ( value == floor(value) )

    if ( scale <= 4 ) then
        value = value * 10 ^ (4 - scale);
        scale = 0x01;
    elseif ( scale <= 8 ) then
        value = value * 10 ^ (8 - scale);
        scale = 0x02;
    elseif ( scale <= 16 ) then
        value = value * 10 ^ (16 - scale);
        scale = 0x04;
    elseif ( scale <= 24 ) then
        value = value * 10 ^ (24 - scale);
        scale = 0x05;
    else
        value = value * 10 ^ (31 - scale);
        scale = 0x08;
    end
    return floor(value), scale;
end

local function Int2Real(value, scale)
    if ( scale == 0x01 ) then
        return value / 10 ^ 4;
    elseif ( scale == 0x02 ) then
        return value / 10 ^ 8;
    elseif ( scale == 0x04 ) then
        return value / 10 ^ 16;
    elseif ( scale == 0x05 ) then
        return value / 10 ^ 24;
    else
        return value / 10 ^ 31;
    end
end

local function EncodeValue(value)
    local len;
    if ( value == nil or type(value) == "function" ) then
        return char(TYPE_NULL);
    elseif ( type(value) == "number" ) then
        if ( value == floor(value) ) then
            value, len = Int2Bytes(value);
            return char(TYPE_INT, len) .. value;
        else
            local scale;
            value, scale = Real2Int(value);
            value, len = Int2Bytes(value);
            len = scale * 16 + len;
            return char(TYPE_REAL, len) .. value;
        end
    elseif ( type(value) == "boolean" ) then
        if ( value ) then
            return char(TYPE_TRUE);
        else
            return char(TYPE_FALSE);
        end
    elseif ( type(value) == "string" ) then
        if ( strupper(value):match("^INTERFACE\\ICONS") ) then
            value = strupper(value):match("^INTERFACE\\ICONS\\(.+)");
            len = #value;
            return char(TYPE_ICON, len) .. value;
        elseif ( value:match("|H.-|h") ) then
            local color, kind, id, name = Armory:GetLinkInfo(value);
            if ( color and kind and id and name ) then
                local quality = 0;
                local linkType;
                if ( kind == "item" ) then
                    quality = Armory:GetQualityFromColor(color);
                    linkType = LINK_ITEM;
                elseif ( kind == "achievement" ) then
                    linkType = LINK_ACHIEVEMENT;
                elseif ( kind == "talent" ) then
                    linkType = LINK_TALENT;
                elseif ( kind == "spell" ) then
                    linkType = LINK_SPELL;
                elseif ( kind == "trade" ) then
                    linkType = LINK_TRADE;
                elseif ( kind == "enchant" ) then
                    linkType = LINK_ENCHANT;
                elseif ( kind == "quest" ) then
                    linkType = LINK_QUEST;
                elseif ( kind == "glyph" ) then
                    linkType = LINK_GLYPH;
                elseif ( kind == "battlepet" ) then
                    linkType = LINK_BATTLEPET;
                end
                if ( linkType and quality > -1 ) then
                    value = id .. "\001" .. name;
                    len = #value + 1;
                    return char(TYPE_LINK, len, linkType + quality) .. value;
                end
            end
        end
        len = #value;
        if ( len > 255 ) then
            return char(TYPE_BIGSTR, band(len, 255), floor(len / 256)) .. value;
        else
            return char(TYPE_STR, len) .. value;
        end
    end
    error("Encode: unsupported type: " .. type(value));
end

local function DecodeValue(bytes)
    local id = bytes:byte(1);
    local value, offset;
    if ( id == TYPE_NULL ) then
        offset = 2;
        value = nil;
    elseif ( id == TYPE_INT ) then
        offset = bytes:byte(2) + 3;
        value = Bytes2Int(bytes:sub(3, offset - 1));
    elseif ( id == TYPE_REAL ) then
        local scale = floor(bytes:byte(2) / 16)
        offset = band(bytes:byte(2), 15) + 3;
        value = Bytes2Int(bytes:sub(3, offset - 1));
        value = Int2Real(value, scale);
    elseif ( id == TYPE_TRUE ) then
        value = true;
        offset = 2;
    elseif ( id == TYPE_FALSE ) then
        value = false;
        offset = 2;
    elseif ( id == TYPE_ICON ) then
        offset = bytes:byte(2) + 3;
        value = "Interface\\Icons\\" .. bytes:sub(3, offset - 1);
    elseif ( id == TYPE_LINK ) then
        offset = bytes:byte(2) + 3;
        local linkType = band(bytes:byte(3), 240);
        local quality = band(bytes:byte(3), 15);
        local id, name = strsplit("\001", bytes:sub(4, offset - 1));
        if ( linkType == LINK_ITEM ) then
            value = Armory:GetLink("item", id, name, quality);
        elseif ( linkType == LINK_ACHIEVEMENT ) then
            value = Armory:GetLink("achievement", id, name);
        elseif ( linkType == LINK_TALENT ) then
            value = Armory:GetLink("talent", id, name);
        elseif ( linkType == LINK_SPELL ) then
            value = Armory:GetLink("spell", id, name);
        elseif ( linkType == LINK_TRADE ) then
            value = Armory:GetLink("trade", id, name);
        elseif ( linkType == LINK_ENCHANT ) then
            value = Armory:GetLink("enchant", id, name);
        elseif ( linkType == LINK_QUEST ) then
            value = Armory:GetLink("quest", id, name);
        elseif ( linkType == LINK_GLYPH ) then
            value = Armory:GetLink("glyph", id, name);
        elseif ( linkType == LINK_BATTLEPET ) then
            value = Armory:GetLink("battlepet", id, name);
        end
    elseif ( id == TYPE_STR ) then
        offset = bytes:byte(2) + 3;
        if ( offset == 3 ) then
            value = "";
        else
            value = bytes:sub(3, offset - 1);
        end
    elseif ( id == TYPE_BIGSTR ) then
        offset = bytes:byte(2) + bytes:byte(3) * 256 + 4;
        value = bytes:sub(4, offset - 1);
    else
        error("Decode: unsupported type: " .. id);
    end
    if ( #bytes - offset + 1 > 0 ) then
        return value, bytes:sub(offset);
    end
    return value;
end

function ArmoryDbEntry.Encode(...)
    local numValues = select("#", ...);
    local arg1 = ...;
    local value;
    if ( numValues > 1 or (arg1 ~= nil and type(arg1) ~= "function") ) then
        value = "";
        for i = 1, numValues do
            value = value .. EncodeValue(select(i, ...));
        end
    end
    return value;
end

function ArmoryDbEntry.Decode(bytes)
    local value, remainder = DecodeValue(bytes);
    if ( remainder ) then
        return value, ArmoryDbEntry.Decode(remainder);
    else
        return value;
    end
end
