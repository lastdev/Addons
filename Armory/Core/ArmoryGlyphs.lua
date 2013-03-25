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

local Armory, _ = Armory;
local container = "Glyphs";

----------------------------------------------------------
-- Glyphs Storage
----------------------------------------------------------

function Armory:GlyphsExists()
    local dbEntry = self.playerDbBaseEntry;
    local activeTalentGroup = _G.GetActiveSpecGroup() or 1;
    return dbEntry and dbEntry:Contains(container, activeTalentGroup);
end

function Armory:ClearGlyphs()
    self:ClearModuleData(container);
end

local glyphCache = {};
local knownGlyphs = {};
function Armory:UpdateGlyphs()
    local dbEntry = self.playerDbBaseEntry;

    if ( not dbEntry ) then
        return;
    elseif ( not self:HasGlyphs() or _G.UnitLevel("player") < SHOW_INSCRIPTION_LEVEL ) then
        dbEntry:SetValue(container, nil);
        return;
    end
    
    if ( not self:IsLocked(container) ) then
        self:Lock(container);

        self:PrintDebug("UPDATE", container);

	    table.wipe(glyphCache);
	    table.wipe(knownGlyphs);
	    
	    self:SetClassValue("player", container, nil);
	    
   	    local numGlyphs = _G.GetNumGlyphs();
	    
	    for i = 1, numGlyphs do
	        local name, glyphType, isKnown, icon, glyphID, link = _G.GetGlyphInfo(i);
            if ( name ~= "header" and link ) then
                local key = self:GetGlyphKey(name);
                glyphCache[tostring(glyphID)] = key
                if ( isKnown ) then
                    table.insert(knownGlyphs, glyphID);
                end
                self:SetClassValue("player", 2, container, key, glyphType, icon, glyphID, link);
            end
	    end
	    dbEntry:SetValue(2, container, "Known", "|"..strjoin("|", unpack(knownGlyphs)).."|");
        
	    local numTalentGroups = _G.GetNumSpecGroups();
        local activeTalentGroup = _G.GetActiveSpecGroup() or 1;
        for talentGroup = 1, numTalentGroups do
            local oldNum = dbEntry:GetNumValues(container, talentGroup);
            local newNum = NUM_GLYPH_SLOTS;
            local update = (talentGroup == activeTalentGroup or not dbEntry:Contains(container, talentGroup));
            for i = 1, max(oldNum, newNum) do
                if ( i > newNum ) then
                    dbEntry:SetValue(3, container, talentGroup, i, nil);
                elseif ( update ) then
	                local enabled, glyphType, glyphTooltipIndex, glyphSpell, icon, glyphID = _G.GetGlyphSocketInfo(i, talentGroup);
	                local key = glyphCache[tostring(glyphID)];
                    dbEntry:SetValue(3, container, talentGroup, i, key, enabled, glyphType, glyphTooltipIndex, glyphSpell);
	            end
	        end
	    end

	    table.wipe(glyphCache);
	    table.wipe(knownGlyphs);
        
        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

local buzzWords;
local words = {};
function Armory:GetGlyphKey(name)
    if ( not buzzWords ) then
        buzzWords = "|"..strupper(ARMORY_GLYPH).."|";
        for word in ARMORY_BUZZ_WORDS:gmatch("%S+") do
            buzzWords = buzzWords..strupper(word).."|";
        end
    end

    table.wipe(words);
    for word in name:gmatch("%S+") do
        if ( not buzzWords:find("|"..strupper(word).."|") ) then
            table.insert(words, strupper(word));
        end
    end
    return strjoin("_", unpack(words));
end

----------------------------------------------------------
-- Glyphs Interface
----------------------------------------------------------

function Armory:GetGlyphSocketInfo(id, talentGroup)
	local dbEntry = self.selectedDbBaseEntry;
	if ( dbEntry ) then
        local key, enabled, glyphType, glyphTooltipIndex, glyphSpell = dbEntry:GetValue(container, talentGroup, id);
        local icon, glyphID;
        if ( key ) then
            _, icon, glyphID = self:GetClassValue("player", container, key);
        end

        return enabled, glyphType, glyphTooltipIndex, glyphSpell, icon, glyphID;
    end
end

function Armory:GetGlyphLink(id, talentGroup)
	local dbEntry = self.selectedDbBaseEntry;
	if ( dbEntry ) then
        local key = dbEntry:GetValue(container, talentGroup, id);
        local link;
        if ( key ) then
            _, _, _, link = self:GetClassValue("player", container, key);
        end
        return link;
    end
end

function Armory:GetGlyphInfoByName(name)
	local dbEntry = self.selectedDbBaseEntry;
	if ( dbEntry ) then
	    local knownGlyphs = dbEntry:GetValue(container, "Known");
	    if ( knownGlyphs ) then
	        local key = self:GetGlyphKey(name);
	        local glyphType, icon, glyphID, link = self:GetClassValue("player", container, key);
	        local isKnown;
	        if ( glyphID ) then
	            isKnown = knownGlyphs:find("|"..glyphID.."|") and true;
	        end
	        return isKnown, link, icon, glyphType, glyphID;
	    end
	end
end

----------------------------------------------------------
-- Find Methods
----------------------------------------------------------

function Armory:FindGlyphs(...)
    local dbEntry = self.selectedDbBaseEntry;
    local list = {};
    
    if ( dbEntry and self:UnitLevel("player") >= SHOW_INSCRIPTION_LEVEL ) then
        local glyphs = self:GetClassValue("player", container);
        if ( glyphs ) then
            local findUnknown = strlower(select(1, ...)) == strlower(UNKNOWN) or select(1, ...) == "?";
            local name, isKnown, link, text, found, crafters, label;
            for key in pairs(glyphs) do
                local glyphType, icon, glyphID, link = self:GetClassValue("player", container, key);
                name = self:GetNameFromLink(link);
                isKnown, link = self:GetGlyphInfoByName(name);
                if ( findUnknown ) then
                    found = not isKnown;
                else
                    if ( link and self:GetConfigExtendedSearch() ) then
                        text = self:GetTextFromLink(link);
                    else
                        text = name;
                    end
                    found = self:FindTextParts(text, ...);
                end
                if ( found ) then
                    if ( isKnown ) then
                        label = GLYPHS;
                        name = self:HexColor(self:GetConfigKnownColor())..name;
                    else
                        crafters = self:GetInscribers(name, self:UnitClass("player"));
                        if ( #crafters > 0 ) then
                            label = strjoin(", ", unpack(crafters));
                            name = self:HexColor(self:GetConfigCanLearnColor())..name;
                        else
                            label=OTHER;
                        end
                    end
                    table.insert(list, {label=label, name=name, link=link});
                end
            end
        end
    end
        
    return list;
end

local knownBy = {};
local function AddKnownBy(name)
    if ( Armory:GetConfigShowKnownBy() and name ~= Armory.player ) then
        table.insert(knownBy, name);
    end
end

local canLearn = {};
local function AddCanLearn(name)
    if ( Armory:GetConfigShowCanLearn() ) then
        table.insert(canLearn, name);
    end
end

local hasSkill = {};
local function AddHasSkill(name)
    if ( Armory:GetConfigShowHasSkill() ) then
        table.insert(hasSkill, name);
    end
end

function Armory:GetGlyphAltInfo(name, reqClass, reqLevel)
    table.wipe(knownBy);
    table.wipe(hasSkill);
    table.wipe(canLearn);

    if ( self:HasGlyphs() ) then
        local currentProfile = self:CurrentProfile();

        for _, character in ipairs(self:CharacterList(self.playerRealm)) do
            self:LoadProfile(self.playerRealm, character);
            
            local class = self:UnitClass("player");
            if ( reqClass == class ) then
                local dbEntry = self.selectedDbBaseEntry;
                local known = self:GetGlyphInfoByName(name);
                
                if ( known ) then
                    AddKnownBy(character);
                elseif ( reqLevel ) then
                    local learnable = self:UnitLevel("player") >= reqLevel;
                    local attainable = not learnable;
                    
                    if ( attainable ) then
                        AddHasSkill(character);
                    elseif ( learnable ) then
                        AddCanLearn(character);
                    end
                end
            end
        end
        self:SelectProfile(currentProfile);
    end

    return knownBy, hasSkill, canLearn;
end
