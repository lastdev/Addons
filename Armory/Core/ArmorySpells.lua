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
local container = "Spells";

----------------------------------------------------------
-- Spells Internals
----------------------------------------------------------

local function GetSubSpellName(id, bookType)
    local spellName, subSpellName = _G.GetSpellBookItemName(id, bookType);
	if ( subSpellName == "" ) then
	    local isPassive = _G.IsPassiveSpell(id, bookType);
    	local specs = { _G.GetSpecsForSpell(id, bookType) };
	    local specName = table.concat(specs, PLAYER_LIST_DELIMITER);
		if ( specName and specName ~= "" ) then
			if ( isPassive ) then
				subSpellName = specName .. ", " .. SPELL_PASSIVE_SECOND;
			else
				subSpellName = specName;
			end
		elseif ( _G.IsTalentSpell(id, bookType) ) then
			if ( isPassive ) then
				subSpellName = TALENT_PASSIVE;
			else
				subSpellName = TALENT;
			end
		elseif ( isPassive ) then
			subSpellName = SPELL_PASSIVE;
		end
	end
    if ( subSpellName ~= "" ) then
        return subSpellName;
    end
end 

local function IsSpecializationSpell(spellID, specSpells)
    for i = 1, #specSpells, 2 do
        if ( spellID == specSpells[i] ) then
            return true;
        end
    end
    return false;
end

local function SaveSpellBook(dbEntry, oldNum, newNum, bookType)
    local family, isHunterPet, spec, specSpells;
    
    if ( bookType == BOOKTYPE_PET ) then
        family = _G.UnitCreatureFamily("pet");
        _, isHunterPet = _G.HasPetUI();
        if ( isHunterPet ) then
            spec = _G.GetSpecialization(false, true);
            specSpells = { _G.GetSpecializationSpells(spec, nil, true) };
        end
    end
    
    for i = 1, max(oldNum, newNum) do
        if ( i > newNum ) then
            dbEntry:SetValue(2, container, i, nil);
        else
            local slotType, spellID = _G.GetSpellBookItemInfo(i, bookType);
            local subSpellName = GetSubSpellName(i, bookType);
            local spellName, texture, link, level;
            
            if ( bookType == BOOKTYPE_PET ) then
                if ( slotType == "PETACTION" ) then
                    spellName = _G.GetSpellBookItemName(i, bookType);
                    texture = _G.GetSpellBookItemTexture(i, bookType);
                    Armory:SetSharedValue(2, slotType, spellName, subSpellName, texture);
                elseif ( spec and specSpells and IsSpecializationSpell(spellID, specSpells) ) then
                    Armory:SetClassValue("pet", 3, container, spec, tostring(spellID), subSpellName or "");
                elseif ( family ) then
                    Armory:SetClassValue("player", 3, container, family, tostring(spellID), subSpellName or "");
                end
            else
                if ( slotType == "FLYOUT" ) then
                    spellID = nil;
                    spellName = _G.GetSpellBookItemName(i, bookType);
                    texture = _G.GetSpellBookItemTexture(i, bookType);
                    link = _G.GetSpellLink(i, bookType);
                    level = _G.GetSpellAvailableLevel(i, bookType);
                end
                dbEntry:SetValue(2, container, i, spellID, subSpellName, slotType, spellName, texture, link, level);
            end
        end
    end
end

local petSpells = {};
local spellsFamily;
local petSpec;
local hasSpecSpells;
local function GetPetSpells(specialization)
    local _, isHunterPet = Armory:HasPetUI();
    local family = Armory:UnitCreatureFamily("pet");
    local spec;
    if ( isHunterPet ) then
        spec = specialization or Armory:GetSpecialization(false, true);
    end

    if ( not family ) then
        table.wipe(petSpells);
    
    elseif ( spellsFamily ~= family or petSpec ~= spec ) then
        local spells, spellName;

        table.wipe(petSpells);

        spells = Armory:GetSharedValue("PETACTION");
        if ( spells ) then
            for spellName, data in pairs(spells) do
                local subSpellName, texture = ArmoryDbEntry.Load(data);
                table.insert(petSpells, { name=spellName, subName=subSpellName, icon=texture, isAction=true });
            end
        end
        
        hasSpecSpells = false;
        if ( spec ) then
            spells = Armory:GetClassValue("pet", container, spec);
            if ( spells ) then
                for spellID in pairs(spells) do
                    local subSpellName = Armory:GetClassValue("pet", container, spec, spellID);
                    spellName = _G.GetSpellInfo(spellID);
                    table.insert(petSpells, { spellID=spellID, name=spellName, subName=subSpellName });
                end
                hasSpecSpells = true;
            end
        end

        spells = Armory:GetClassValue("player", container, family);
        if ( spells ) then
            for spellID in pairs(spells) do
                local subSpellName = Armory:GetClassValue("player", container, family, spellID);
                spellName = _G.GetSpellInfo(spellID);
                table.insert(petSpells, { spellID=spellID, name=spellName, subName=subSpellName });
            end
        end
       
        table.sort(petSpells, function(a, b) return a.name < b.name end);
    end

    spellsFamily = family;
    petSpec = spec;
    
    return petSpells, hasSpecSpells;
end

local petTabs = {};
local function GetPetTabs()
    local numTalentGroups = Armory:GetNumSpecGroups();
    local activeTalentGroup = Armory:GetActiveSpecGroup();
    
    table.wipe(petTabs);
 
    for talentGroup = 1, numTalentGroups do
        local spec = Armory:GetSpecialization(false, true, talentGroup);
        if ( spec ) then
            local _, name, _, texture = Armory:GetSpecializationInfo(spec, false, true);
            if ( name ) then
                local spells, hasSpecSpells = GetPetSpells(spec);
                local offSpecID;
                if ( hasSpecSpells ) then
                    if ( talentGroup == activeTalentGroup ) then
                        offSpecID = 0;
                    else
                        offSpecID = spec;
                    end
                    table.insert(petTabs, { name=name, icon=texture, offSpec=offSpecID });
                end
            end
        end
    end

    if ( #petTabs > 1 ) then
        table.sort(petTabs, function(a, b) return a.offSpec < b.offSpec end);
    end
    
    return petTabs;
end

local function GetSpellBookInfo(id, bookType, specialization)
    local dbEntry = Armory.selectedDbBaseEntry;
    if ( dbEntry ) then
        local spellID, subSpellName, slotType, spellName, texture, link, level;
        if ( bookType == BOOKTYPE_PET ) then
            local spell = GetPetSpells(specialization)[id];
            if ( spell ) then
                spellID = spell.spellID;
                spellName = spell.name;
                subSpellName = spell.subName;
                slotType = spell.isAction and "PETACTION" or "SPELL";
                texture = spell.icon;
            end 
        else
            spellID, subSpellName, slotType, spellName, texture, link, level = dbEntry:GetValue(container, id);
        end
        return spellID, subSpellName, slotType, spellName, texture, link, level;
    end
end

----------------------------------------------------------
-- Spells Storage
----------------------------------------------------------

function Armory:SpellsExists()
    local dbEntry = self.playerDbBaseEntry;
    return dbEntry and dbEntry:Contains(container);
end

function Armory:ClearSpells()
    self:ClearModuleData(container);
    self:SetSharedValue("PETACTION", nil);
end

function Armory:SetSpells()
    local dbEntry = self.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end

    if ( not self:IsLocked(container) ) then
        self:Lock(container);

        self:PrintDebug("UPDATE", container);

        if ( not self:HasSpellBook() ) then
            dbEntry:SetValue(container, nil);
        else
            local oldTabs = dbEntry:GetNumValues(container, "Tabs");
            local newTabs = _G.GetNumSpellTabs();
            for i = 1, max(oldTabs, newTabs) do
                if ( i > newTabs ) then
                    dbEntry:SetValue(3, container, "Tabs", i, nil);
                else
                    dbEntry:SetValue(3, container, "Tabs", i, _G.GetSpellTabInfo(i));
                end
            end

            local _, _, offset, numSpells = _G.GetSpellTabInfo(newTabs);
            local oldNum = dbEntry:GetNumValues(container);
            local newNum = (offset or 0) + (numSpells or 0);

            SaveSpellBook(dbEntry, oldNum, newNum, BOOKTYPE_SPELL);
        end

        if ( self:IsPersistentPet() ) then
            dbEntry = self:SelectPet(dbEntry, self:GetPetName());
            if ( not self:HasSpellBook() or not _G.PetHasSpellbook() ) then
                dbEntry:SetValue(container, nil);
            else
                local oldNum = dbEntry:GetNumValues(container);
                local newNum = _G.HasPetSpells() or 0;
                SaveSpellBook(dbEntry, oldNum, newNum, BOOKTYPE_PET);
            end
        end             

        self:Unlock(container);
    else
        self:PrintDebug("LOCKED", container);
    end
end

----------------------------------------------------------
-- Spells Interface
----------------------------------------------------------

function Armory:PetHasSpellbook(specialization)
    local spells = GetPetSpells(specialization);
    return #spells > 0; 
end

function Armory:HasPetSpells(specialization)
    local spells = GetPetSpells(specialization);
    return #spells, "PET"; 
end

function Armory:GetNumSpellTabs(bookType)
    if ( bookType == BOOKTYPE_PET ) then
        local tabs = GetPetTabs();
        return #tabs;
    end
    local dbEntry = self.selectedDbBaseEntry;
    return dbEntry and dbEntry:GetNumValues(container, "Tabs");
end

function Armory:GetSpellAutocast(id, bookType, specialization)
    local spellID, _, slotType = GetSpellBookInfo(id, bookType, specialization);
    if ( spellID ) then
        return _G.GetSpellAutocast(spellID);
    end
end

function Armory:GetSpellAvailableLevel(id, bookType, specialization)
    local spellID, _, _, _, _, _, level = GetSpellBookInfo(id, bookType, specialization);
    if ( level ) then
        return level;
    elseif ( spellID ) then
        return _G.GetSpellLevelLearned(spellID);
    end
end

function Armory:GetSpellBookItemName(id, bookType, specialization)
    local spellID, subSpellName, _, spellName = GetSpellBookInfo(id, bookType, specialization);
    if ( not spellName ) then
        if ( spellID and subSpellName ) then
            spellName = _G.GetSpellInfo(spellID);
        elseif ( spellID ) then
            spellName, subSpellName = _G.GetSpellInfo(spellID);
        end
    end
    return spellName, subSpellName or "";
end

function Armory:GetSpellBookItemInfo(id, bookType, specialization)
    local spellID, _, slotType = GetSpellBookInfo(id, bookType, specialization);
    if ( spellID ) then
        return slotType, spellID;
    end
end

function Armory:GetSpellLink(id, bookType, specialization)
    local spellID, _, _, _, _, link = GetSpellBookInfo(id, bookType, specialization);
    if ( link ) then
        return link;
    elseif ( spellID ) then
        return _G.GetSpellLink(spellID);
    end
end

function Armory:GetSpellTabInfo(spellTab, bookType)
    if ( bookType == BOOKTYPE_PET ) then
        local name, texture, offSpecID;
        local tabs = GetPetTabs();
        if ( spellTab <= #tabs ) then
            name = tabs[spellTab].name;
            texture = tabs[spellTab].icon;
            offSpecID = tabs[spellTab].offSpec;
        end
        return name, texture, 0, 0, nil, offSpecID;
    end
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry ) then
        return dbEntry:GetValue(container, "Tabs", spellTab);
    end
end

function Armory:GetSpellBookItemTexture(id, bookType, specialization)
    local spellID, _, _, _, texture = GetSpellBookInfo(id, bookType, specialization);
    if ( texture ) then
        return texture;
    elseif ( spellID ) then
        return _G.GetSpellTexture(spellID);
    end
end

function Armory:IsPassiveSpell(id, bookType, specialization)
    local spellID, _, slotType = GetSpellBookInfo(id, bookType, specialization);
    if ( spellID ) then
        return _G.IsPassiveSpell(spellID);
    end
end

local specSpells = {};
function Armory:GetPetSpecializationSpells(spec)
    local spells = self:GetClassValue("pet", container, (spec or self:GetSpecialization(false, true) or 1));
    table.wipe(specSpells);
    if ( spells ) then
        for spellID in pairs(spells) do
            table.insert(specSpells, spellID);
        end
    end
    return specSpells;
end

----------------------------------------------------------
-- Find Methods
----------------------------------------------------------

function Armory:FindSpell(spellList, ...)
    local list = spellList or {};

    local numSkillLineTabs = self:GetNumSpellTabs();
    local tabName, spellName, subSpellName, offset, numSpells, link, text;
    if ( numSkillLineTabs ) then
        for i = 1, numSkillLineTabs do
            tabName, _, offset, numSpells = self:GetSpellTabInfo(i);
            for j = 1, numSpells do
                spellName, subSpellName = self:GetSpellBookItemName(j + offset, BOOKTYPE_SPELL);
                link = self:GetSpellLink(j + offset, BOOKTYPE_SPELL);
                if ( self:GetConfigExtendedSearch() ) then
                    text = self:GetTextFromLink(link);
                else
                    text = spellName;
                end
                if ( self:FindTextParts(text, ...) ) then
                    if ( subSpellName and subSpellName ~= "" ) then
                        table.insert(list, {label=SPELLBOOK.." "..tabName, name=spellName, link=link, extra=subSpellName});
                    else
                        table.insert(list, {label=SPELLBOOK.." "..tabName, name=spellName, link=link});
                    end
                end
            end
        end
    end

    local pets = self:GetPets();
    local currentPet = self.selectedPet;
    for i = 1, #pets do
        self.selectedPet = pets[i];
        local numPetSpells = self:HasPetSpells() or 0;
        for id = 1, numPetSpells do
            spellName, subSpellName = self:GetSpellBookItemName(id, BOOKTYPE_PET);
            link = self:GetSpellLink(id, BOOKTYPE_PET);
            if ( self:GetConfigExtendedSearch() ) then
                text = self:GetTextFromLink(link);
            else
                text = spellName;
            end
            if ( self:FindTextParts(text, ...) ) then
                if ( subSpellName and subSpellName ~= "" ) then
                    table.insert(list, {label=SPELLBOOK.." "..self.selectedPet, name=spellName, link=link, extra=subSpellName});
                else
                    table.insert(list, {label=SPELLBOOK.." "..self.selectedPet, name=spellName, link=link});
                end
            end
        end
    end
    self.selectedPet = currentPet;
    
    return list;
end