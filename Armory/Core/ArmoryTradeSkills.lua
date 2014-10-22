--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 652 2014-10-19T10:25:00Z
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
local container = "Professions";
local itemContainer = "SkillLines";
local recipeContainer = "Recipes";
local reagentContainer = "Reagents";

local selectedSkill;
local selectedSkillLine = 1;

local tradeSkillSubClassFilter = {};
local tradeSkillInvSlotFilter = {};
local tradeSkillFilter = "";
local tradeSkillMinLevel = 0;
local tradeSkillMaxLevel = 0;

local invSlots = {};
local subClasses = {};

local tradeIcons = {};
tradeIcons[ARMORY_TRADE_ALCHEMY] = "Trade_Alchemy";
tradeIcons[ARMORY_TRADE_BLACKSMITHING] = "Trade_BlackSmithing";
tradeIcons[ARMORY_TRADE_COOKING] = "INV_Misc_Food_15";
tradeIcons[ARMORY_TRADE_ENCHANTING] = "Trade_Engraving";
tradeIcons[ARMORY_TRADE_ENGINEERING] = "Trade_Engineering";
tradeIcons[ARMORY_TRADE_FIRST_AID] = "Spell_Holy_SealOfSacrifice";
tradeIcons[ARMORY_TRADE_FISHING] = "Trade_Fishing";
tradeIcons[ARMORY_TRADE_HERBALISM] = "Trade_Herbalism";
tradeIcons[ARMORY_TRADE_JEWELCRAFTING] = "INV_Misc_Gem_01";
tradeIcons[ARMORY_TRADE_LEATHERWORKING] = "Trade_LeatherWorking";
tradeIcons[ARMORY_TRADE_MINING] = "Trade_Mining";
tradeIcons[ARMORY_TRADE_POISONS] = "Trade_BrewPoison";
tradeIcons[ARMORY_TRADE_SKINNING] = "INV_Weapon_ShortBlade_01";
tradeIcons[ARMORY_TRADE_TAILORING] = "Trade_Tailoring";
tradeIcons[ARMORY_TRADE_INSCRIPTION] = "INV_Inscription_Tradeskill01";

----------------------------------------------------------
-- TradeSkills Internals
----------------------------------------------------------

local function FixGetTradeSkillReagentItemLink(id, index)
    local link = _G.GetTradeSkillReagentItemLink(id, index);
    -- PTR 5.2: GetTradeSkillReagentItemLink returns nil
    if ( not link ) then
        local tooltip = Armory:AllocateTooltip();
        tooltip:SetTradeSkillItem(id, index);
        _, link = tooltip:GetItem();
        Armory:ReleaseTooltip(tooltip);
    end
    return link;
end

local professionLines = {};
local dirty = true;
local owner = "";

local function GetRecipeValue(id, ...)
    return Armory:GetSharedValue(container, recipeContainer, id, ...);
end

local function GetNumReagents(id)
    return Armory:GetSharedNumValues(container, recipeContainer, id, "Reagents");
end

local function GetReagentInfo(id, index)
    local recipeID, count = GetRecipeValue(id, "Reagents", index);
    local name, texture, link = Armory:GetSharedValue(container, reagentContainer, recipeID);
    return name, texture, count, link;
end

local function IsRecipe(skillType)
    return skillType and skillType ~= "header" and skillType ~= "subheader";
end

local function IsSameRecipe(skillName, recipeName)
    skillName = strlower(strtrim(skillName));
    recipeName = strlower(strtrim(recipeName));
    return skillName:sub(1, strlen(recipeName)) == recipeName;
end

local function SelectProfession(baseEntry, name)
    local dbEntry = ArmoryDbEntry:new(baseEntry);
    dbEntry:SetPosition(container, name);
    return dbEntry;
end

local function GetProfessionNumValues(dbEntry)
    local numLines = dbEntry:GetNumValues(itemContainer);
    local _, skillType = dbEntry:GetValue(itemContainer, 1, "Info");
    local extended = not IsRecipe(skillType);
    return numLines, extended;
end

local groups = {};
local invSlot = {};
local function GetProfessionLines()
    local dbEntry = Armory.selectedDbBaseEntry;
    local group = { index=0, expanded=true, included=true, items={} };
    local numReagents, oldPosition, names, isIncluded, itemMinLevel;
    local numLines, extended;
    local name, id, skillType, isExpanded;
    local subgroup;

    table.wipe(professionLines);

    if ( dbEntry and dbEntry:Contains(container, selectedSkill, itemContainer) ) then
        dbEntry = SelectProfession(dbEntry, selectedSkill)

        numLines, extended = GetProfessionNumValues(dbEntry);
        if ( numLines > 0 ) then
            table.wipe(groups);
             
            -- apply filters
            for i = 1, numLines do
                name, skillType = dbEntry:GetValue(itemContainer, i, "Info");
                id = dbEntry:GetValue(itemContainer, i, "Data");
                isExpanded = not Armory:GetHeaderLineState(itemContainer..selectedSkill, name);
                if ( skillType == "header" ) then
                    if ( tradeSkillSubClassFilter ) then
                        isIncluded = tradeSkillSubClassFilter[name..(#groups + 1)];
                    else
                        isIncluded = true;
                    end
                    group = { index=i, expanded=isExpanded, included=isIncluded, items={} };
                    subgroup = nil;
                    table.insert(groups, group);
                elseif ( group.included ) then
                    if ( skillType == "subheader" ) then
                        subgroup = { index=i, expanded=isExpanded, items={} };
                        table.insert(group.items, subgroup);
                    else
                        numReagents = GetNumReagents(id);
                        names = name or "";
                        for index = 1, numReagents do
                            names = names.."\t"..(GetReagentInfo(id, index) or "");
                        end

                        Armory:FillTable(invSlot, GetRecipeValue(id, "InvSlot"));
                        if ( extended and tradeSkillInvSlotFilter ) then
                            isIncluded = false;
                            for _, slot in ipairs(invSlot) do
                                if ( tradeSkillInvSlotFilter[slot] ) then
                                    isIncluded = true;
                                    break;
                                end
                            end
                        else
                            isIncluded = true;
                        end
                        if ( isIncluded and tradeSkillMinLevel > 0 and tradeSkillMaxLevel > 0 ) then
                            _, _, _, _, itemMinLevel = _G.GetItemInfo(GetRecipeValue(id, "ItemLink"));
                            isIncluded = itemMinLevel and itemMinLevel >= tradeSkillMinLevel and itemMinLevel <= tradeSkillMaxLevel;
                        elseif ( isIncluded and not name or (tradeSkillFilter ~= "" and not string.find(strlower(names), strlower(tradeSkillFilter), 1, true)) ) then
                            isIncluded = false;
                        end
                        if ( isIncluded ) then
                            if ( subgroup ) then
                                table.insert(subgroup.items, {index=i, name=name});
                            else
                                table.insert(group.items, {index=i, name=name});
                            end
                        end
                    end
                end
            end

            -- build the list
            if ( #groups == 0 ) then
                if ( not extended ) then
                    table.sort(group.items, function(a, b) return a.name < b.name; end);
                end
                for _, v in ipairs(group.items) do
                    table.insert(professionLines, v.index);
                end
            else
                local hasFilter = Armory:HasTradeSkillFilter();
                for i = 1, #groups do
                    if ( groups[i].included and (table.getn(groups[i].items) > 0 or not hasFilter) ) then
                        table.insert(professionLines, groups[i].index);
                        if ( groups[i].expanded ) then
                            for _, item in ipairs(groups[i].items) do
                                table.insert(professionLines, item.index);
                                if ( item.items and item.expanded ) then
                                    for _, subitem in ipairs(item.items) do
                                        table.insert(professionLines, subitem.index);
                                    end
                                end
                            end
                        end
                    end
                end
            end
            table.wipe(groups);
        end
    end

    dirty = false;
    owner = Armory:SelectedCharacter();
    
    return professionLines;
end

local function UpdateTradeSkillHeaderState(index, isCollapsed)
    local dbEntry = SelectProfession(Armory.selectedDbBaseEntry, selectedSkill);
    if ( dbEntry ) then
        if ( index == 0 ) then
            for i = 1, dbEntry:GetNumValues(itemContainer) do
                local name, skillType = dbEntry:GetValue(itemContainer, i, "Info");
                if ( not IsRecipe(skillType) ) then
                    Armory:SetHeaderLineState(itemContainer..selectedSkill, name, isCollapsed);
                end
            end
        else
            local numLines = Armory:GetNumTradeSkills();
            if ( index > 0 and index <= numLines ) then
                local name = dbEntry:GetValue(itemContainer, professionLines[index], "Info");
                Armory:SetHeaderLineState(itemContainer..selectedSkill, name, isCollapsed);
            end
        end
    end
    dirty = true;
end

local function ClearProfessions()
    local dbEntry = Armory.playerDbBaseEntry;
    if ( dbEntry ) then
        dbEntry:SetValue(container, nil);
        -- recollect minimal required profession data
        Armory:UpdateProfessions();
    end
end

local function SetProfessionValue(name, key, ...)
    local dbEntry = Armory.playerDbBaseEntry;
    if ( dbEntry and name ~= "UNKNOWN" ) then
        dbEntry:SetValue(3, container, name, key, ...);
    end
end

local professionNames = {};
local function SetProfessions(...)
    local dbEntry = Armory.playerDbBaseEntry;
    if ( not dbEntry ) then
        return;
    end

    table.wipe(professionNames);
    
    if ( dbEntry ) then
        for i = 1, select("#", ...) do
            local id = select(i, ...);
            if ( id ) then
                local name, texture, rank, maxRank, numSpells, offset, _, modifier = _G.GetProfessionInfo(id);
                local additive;
                if ( name ) then
                    if ( i <= 2 and numSpells == 2 and not _G.IsPassiveSpell(offset + 2, BOOKTYPE_PROFESSION) ) then
                        local spellName, subSpellName = _G.GetSpellBookItemName(offset + 2, BOOKTYPE_PROFESSION);
                        if ( (subSpellName or "") == "" ) then
                            additive = spellName;
                        end
                    end
                    dbEntry:SetValue(2, container, tostring(i), name, additive);
                    
                    SetProfessionValue(name, "Rank", rank, maxRank, modifier);
                    SetProfessionValue(name, "Texture", texture);

                    professionNames[name] = 1;
                end
            else
                dbEntry:SetValue(2, container, tostring(i), nil);
            end
        end

        -- check if the stored trade skills are still valid    
        local professions = dbEntry:GetValue(container);
        for name in pairs(professions) do
            if ( not tonumber(name) and not professionNames[name] ) then
                Armory:PrintDebug("DELETE profession", name);
                dbEntry:SetValue(2, container, name, nil);
            end
        end
    end
end

local function IsProfession(name, ...)
    local id, profession;
    for i = 1, select("#", ...) do
        id = select(i, ...);
        if ( id ) then
            profession = GetProfessionInfo(id);
            if ( name == profession ) then
                return true;
            end
        end
    end
end

local function IsTradeSkill(name)
    return name and IsProfession(name, _G.GetProfessions());
end

local function GetProfessionValue(key)
    local dbEntry = Armory.selectedDbBaseEntry;
    if ( dbEntry and dbEntry:Contains(container, selectedSkill, key) ) then
        return dbEntry:GetValue(container, selectedSkill, key);
    end
end

local function GetProfessionLineValue(index)
    local dbEntry = Armory.selectedDbBaseEntry;
    local numLines = Armory:GetNumTradeSkills();
    if ( dbEntry and index > 0 and index <= numLines ) then
        local id = dbEntry:GetValue(container, selectedSkill, itemContainer, professionLines[index], "Data");
        local cooldown, isDayCooldown, timestamp, charges, maxCharges = dbEntry:GetValue(container, selectedSkill, itemContainer, professionLines[index], "Cooldown")
        if ( cooldown ) then
            cooldown = cooldown - (time() - timestamp);
            if ( cooldown <= 0 ) then
                cooldown = nil;
                isDayCooldown = nil;
            end
        end
        return id, cooldown, isDayCooldown, charges, maxCharges, dbEntry:GetValue(container, selectedSkill, itemContainer, professionLines[index], "Info");
    end
end

local function PreserveTradeSkillsState()
    -- When TradeSkillFrame is opened only sub class and slot filters are reset but preserve them just in case
    local editBox = TradeSkillFrameSearchBox;
    local state = { subClassFilter=-1, invSlotFilter=-1, index=_G.GetTradeSkillSelectionIndex(), collapsed={} };
    local skillType, isExpanded;
    
    if ( TradeSkillFrame.filterTbl ) then
        state.makeable = TradeSkillFrame.filterTbl.hasMaterials;
        state.skillups = TradeSkillFrame.filterTbl.hasSkillUp;
        state.subClassFilter = TradeSkillFrame.filterTbl.subClassValue;
	    state.invSlotFilter = TradeSkillFrame.filterTbl.slotValue;
    end
    if ( editBox ) then
        state.text, state.minLevel, state.maxLevel = Armory:GetTradeSkillItemFilter(editBox:GetText());
    end
    if ( (state.minLevel or 0) ~= 0 or (state.maxLevel or 0) ~= 0 ) then
        _G.SetTradeSkillItemLevelFilter(0, 0);
    end
    if ( state.text and state.text ~= "" ) then
        _G.SetTradeSkillItemNameFilter(nil);
    end
    if ( state.subClassFilter > 0 ) then
        -- subclass category index is not stored but for now this isn't a problem because it gets reset on show anyway
        _G.SetTradeSkillCategoryFilter(-1, nil);
    end
    if ( state.invSlotFilter > 0 ) then
        _G.SetTradeSkillInvSlotFilter(-1, 1, 1);
    end
    if ( state.makeable ) then
        _G.TradeSkillOnlyShowMakeable(nil);
    end
    if ( state.skillups ) then
        _G.TradeSkillOnlyShowSkillUps(nil);
    end
    
    local isCollaped;
    for i = _G.GetNumTradeSkills(), 1, -1 do
        _, skillType, _, isExpanded = _G.GetTradeSkillInfo(i);
        if ( not (IsRecipe(skillType) or isExpanded) ) then
            table.insert(state.collapsed, i);
            isCollaped = true;
        end
    end
    if ( isCollaped ) then
        _G.ExpandTradeSkillSubClass(0);
    end

    return state;
end

local function RestoreTradeSkillsState(state)
    table.sort(state.collapsed);
    for _, i in pairs(state.collapsed) do
        _G.CollapseTradeSkillSubClass(i);
    end

    if ( (state.minLevel or 0) ~= 0 or (state.maxLevel or 0) ~= 0 ) then
        _G.SetTradeSkillItemLevelFilter(state.minLevel, state.maxLevel);
    end
    if ( state.text and state.text ~= "" ) then
        _G.SetTradeSkillItemNameFilter(state.text);
    end
    if ( state.makeable ) then
        _G.TradeSkillOnlyShowMakeable(state.makeable);
    end
    if ( state.skillups ) then
        _G.TradeSkillOnlyShowSkillUps(state.skillups);
    end
    
    -- just in case...
    if ( state.subClassFilter > 0 ) then
        -- subclass category index is not stored but for now this isn't a problem because it gets reset on show anyway
        _G.SetTradeSkillCategoryFilter(state.subClassFilter, nil);
    end
    if ( state.invSlotFilter > 0 ) then
        _G.SetTradeSkillInvSlotFilter(state.invSlotFilter, 1, 1);
    end

    _G.SelectTradeSkill(state.index);
end


----------------------------------------------------------
-- TradeSkills Item Caching
----------------------------------------------------------

local function SetItemCache(dbEntry, profession, link)
    if ( Armory:GetConfigShowCrafters() and not Armory:GetConfigUseEncoding() ) then
        local itemId = Armory:GetItemId(link);
        if ( itemId ) then
            if ( profession ) then
                dbEntry:SetValue(4, container, profession, ARMORY_CACHE_CONTAINER, itemId, 1);
            else
                dbEntry:SetValue(2, ARMORY_CACHE_CONTAINER, itemId, 1);
            end
        end
    end
end

local function ItemIsCached(dbEntry, profession, itemId)
    if ( itemId ) then
        return dbEntry:Contains(container, profession, ARMORY_CACHE_CONTAINER, itemId);
    end
    return false;
end

local function ClearItemCache(dbEntry)
    dbEntry:SetValue(ARMORY_CACHE_CONTAINER, nil);
end

local function ItemCacheExists(dbEntry, profession)
    return dbEntry:Contains(container, profession, ARMORY_CACHE_CONTAINER);
end

----------------------------------------------------------
-- TradeSkills Storage
----------------------------------------------------------

function Armory:ProfessionsExists()
    local dbEntry = self.playerDbBaseEntry;
    return dbEntry and dbEntry:Contains(container);
end

function Armory:UpdateProfessions()
    SetProfessions(_G.GetProfessions());
end

function Armory:ClearTradeSkills()
    self:ClearModuleData(container);
    -- recollect minimal required profession data
    self:UpdateProfessions();
    dirty = true;
end

local function StoreTradeSkillInfo(dbEntry, skillIndex, index)
    local success = true;
    local link = _G.GetTradeSkillRecipeLink(skillIndex);
    local _, id = Armory:GetLinkId(link);
    local recipe = Armory.sharedDbEntry:SelectContainer(container, recipeContainer, id);
    local reagents = Armory.sharedDbEntry:SelectContainer(container, reagentContainer);

    recipe.RecipeLink = link;
    recipe.Description = _G.GetTradeSkillDescription(skillIndex);
    recipe.Icon = _G.GetTradeSkillIcon(skillIndex);
    recipe.Tools = Armory:BuildColoredListString(_G.GetTradeSkillTools(skillIndex));
    recipe.NumMade = dbEntry.Save(_G.GetTradeSkillNumMade(skillIndex));
    if ( _G.GetTradeSkillItemLink(skillIndex) ) then
        recipe.ItemLink = _G.GetTradeSkillItemLink(skillIndex);
    else
        success = false;
    end
    
    if ( _G.GetTradeSkillNumReagents(skillIndex) > 0 ) then
        recipe.Reagents = {};
        for i = 1, _G.GetTradeSkillNumReagents(skillIndex) do
            local reagentName, reagentTexture, reagentCount, playerReagentCount = _G.GetTradeSkillReagentInfo(skillIndex, i);
            link = FixGetTradeSkillReagentItemLink(skillIndex, i);
            if ( link ) then
                local _, id = Armory:GetLinkId(link);
                reagents[id] = dbEntry.Save(reagentName, reagentTexture, link);
                recipe.Reagents[i] = dbEntry.Save(id, reagentCount);
            else
                success = false;
            end
        end
    end

    local cooldown, isDayCooldown, charges, maxCharges = _G.GetTradeSkillCooldown(skillIndex);

    -- HACK: when a cd is activated it will return 00:00, but after a relog it suddenly becomes 03:00
    -- Note: GetServerTime() precision is minutes
    if ( cooldown and isDayCooldown and date("*t", Armory:GetServerTime() + cooldown + 60).hour == 0 ) then
        cooldown = _G.GetQuestResetTime();
    end
    
    if ( (cooldown and cooldown > 0) or (maxCharges and maxCharges > 0) ) then
        dbEntry:SetValue(3, itemContainer, index, "Cooldown", cooldown, isDayCooldown, time(), charges, maxCharges);
    else
        dbEntry:SetValue(3, itemContainer, index, "Cooldown", nil);
    end

    SetItemCache(dbEntry, nil, recipe.ItemLink);
       
    return success, id, recipe, cooldown, recipe;
end

local invSlotTypes = {};
local function UpdateTradeSkillExtended(dbEntry)
    local name, hasCooldown;
    local dataMissing;
    
    -- retrieve slot types (would be to time consuming if put in funcAdditionalInfo)
    Armory:FillTable(invSlots, _G.GetTradeSkillSubClassFilteredSlots(0));
    table.wipe(invSlotTypes);
    for i = 1, #invSlots do
        _G.SetTradeSkillInvSlotFilter(i, 1, 1);
        for id = 1, _G.GetNumTradeSkills() do
            name = _G.GetTradeSkillInfo(id);
            if ( invSlotTypes[name] ) then
                table.insert(invSlotTypes[name], invSlots[i]);
            else
                invSlotTypes[name] = {invSlots[i]};
            end
        end
    end
    _G.SetTradeSkillInvSlotFilter(0, 1, 1);

    local funcNumLines = _G.GetNumTradeSkills;
    local funcGetLineInfo = _G.GetTradeSkillInfo;
    local funcGetLineState = function(index)
        local _, skillType, _, isExpanded = _G.GetTradeSkillInfo(index);
        local isHeader = not IsRecipe(skillType);
        return isHeader, isExpanded;
    end;
    local funcAdditionalInfo = function(index)
        local name = _G.GetTradeSkillInfo(index);
        local success, id, recipe, cooldown = StoreTradeSkillInfo(dbEntry, index, index);
        dataMissing = not success;
        if ( cooldown ) then
            hasCooldown = true;
        end
        if ( invSlotTypes[name] ) then
            recipe.InvSlot = dbEntry.Save(unpack(invSlotTypes[name]));
        end
        return id;
    end
    
    ClearItemCache(dbEntry);

    -- store the complete (expanded) list
    local success = dbEntry:SetExpandableListValues(itemContainer, funcNumLines, funcGetLineState, funcGetLineInfo, nil, nil, funcAdditionalInfo);
    
    table.wipe(invSlotTypes);

    return (success and not dataMissing), hasCooldown;
end

local function UpdateTradeSkillSimple(dbEntry)
    local skillName, skillType, hasCooldown, itemLink;
    local skillIndex = 1;
    local index = 1;
    local failed;

    dbEntry:ClearContainer(itemContainer);

    ClearItemCache(dbEntry);

    repeat
        skillName, skillType = _G.GetTradeSkillInfo(skillIndex);

        if ( skillName and IsRecipe(skillType) ) then
            local success, id, recipe, cooldown = StoreTradeSkillInfo(dbEntry, skillIndex, index);
            failed = failed or not success;

            dbEntry:SetValue(3, itemContainer, index, "Info", _G.GetTradeSkillInfo(skillIndex));
            dbEntry:SetValue(3, itemContainer, index, "Data", id);
            
            if ( cooldown ) then
                hasCooldown = true;
            end
            index = index + 1;
       end
       skillIndex = skillIndex + 1;
    until ( not skillName )
    
    return (not failed), hasCooldown;
end

function Armory:PullTradeSkillItems()
    if ( self:HasTradeSkills() ) then
        local skillName, skillType, numReagents;
        local index = 1;
        repeat
            skillName, skillType = _G.GetTradeSkillInfo(index);
            if ( skillName and IsRecipe(skillType) ) then
                _G.GetTradeSkillItemLink(index);
                numReagents = _G.GetTradeSkillNumReagents(index);
                for i = 1, numReagents do
                    FixGetTradeSkillReagentItemLink(index, i);
                end
            end
            index = index + 1;
        until ( not skillName )
    end
end

function Armory:UpdateTradeSkill()
    local name, rank, maxRank;
    local modeChanged, hasCooldown;
    local abort, warned;
    
    if ( not self.playerDbBaseEntry ) then
        return;
    elseif ( not self:HasTradeSkills() ) then
        ClearProfessions();
        return;
    end

    name, rank, maxRank, modifier = _G.GetTradeSkillLine();

    if ( name and name ~= "UNKNOWN" ) then
        if ( not IsTradeSkill(name) ) then
            self:PrintDebug(name, "is not a profession");

        elseif ( not self:IsLocked(itemContainer) ) then
            self:Lock(itemContainer);

            self:PrintDebug("UPDATE", name);
            
            SetProfessionValue(name, "Rank", rank, maxRank, modifier);
            if ( self:GetConfigExtendedTradeSkills() ) then
                if ( _G.GetTradeSkillSubClasses() and _G.GetTradeSkillSubClassFilteredSlots(0) ) then
                    SetProfessionValue(name, "SubClasses", _G.GetTradeSkillSubClasses());
                    SetProfessionValue(name, "InvSlots", _G.GetTradeSkillSubClassFilteredSlots(0));
                else
                    abort = true;
                end
            else
                SetProfessionValue(name, "SubClasses", nil);
                SetProfessionValue(name, "InvSlots", nil);
            end

            if ( not abort ) then
                local dbEntry = SelectProfession(self.playerDbBaseEntry, name);
                local _, extended = GetProfessionNumValues(dbEntry);
                local success;

                if ( self:GetConfigExtendedTradeSkills() ) then
                    local state = PreserveTradeSkillsState();
                    if ( _G.GetNumTradeSkills() == 0 ) then
                        extended = true;
                    else
                        success, hasCooldown = UpdateTradeSkillExtended(dbEntry);
                    end
                    RestoreTradeSkillsState(state);
                    modeChanged = not extended;
                else
                    success, hasCooldown = UpdateTradeSkillSimple(dbEntry);
                    modeChanged = extended;
                end
                
                if ( not success ) then
                    self:PrintWarning(ARMORY_TRADE_UPDATE_FAILED);
                    warned = true;
                end
            else
                self:PrintDebug("ABORT UPDATE", name);
            end

            self:Unlock(itemContainer);
        else
            self:PrintDebug("LOCKED", name);
        end
    elseif ( Armory:GetConfigExtendedTradeSkills() ) then
        self:PrintWarning(ARMORY_TRADE_UPDATE_WARNING);
        warned = true;
    end
    
    if ( warned ) then
        self:PlayWarningSound();
    end

    return name, modeChanged, hasCooldown;
end

----------------------------------------------------------
-- TradeSkills Hooks
----------------------------------------------------------

hooksecurefunc("SetTradeSkillItemNameFilter", function(text)
    if ( not Armory:IsLocked(itemContainer) ) then
        tradeSkillItemNameFilter = text;
    end
end);

----------------------------------------------------------
-- TradeSkills Interface
----------------------------------------------------------

function Armory:HasTradeSkillLines(name)
    local dbEntry = self.selectedDbBaseEntry;
    return dbEntry and dbEntry:GetValue(container, name, itemContainer) ~= nil;
end

function Armory:SetSelectedProfession(name)
    selectedSkill = name;
    dirty = true;
end

function Armory:GetSelectedProfession()
    return selectedSkill;
end

function Armory:GetProfessionTexture(name)
    local dbEntry = self.selectedDbBaseEntry;
    local texture;

    if ( dbEntry and dbEntry:Contains(container, name, "Texture") ) then
        texture = SelectProfession(dbEntry, name):GetValue("Texture");
    end

    -- Note: Sometimes the name cannot be found because it differs from the spellbook (e.g. "Mining" vs "Smelting")
    if ( not texture ) then
        if ( tradeIcons[name] ) then
            texture = "Interface\\Icons\\"..tradeIcons[name];
        else
            texture = "Interface\\Icons\\INV_Misc_QuestionMark";
        end
    end

    return texture;
end

local professionNames = {};
function Armory:GetProfessionNames()
    local dbEntry = self.selectedDbBaseEntry;

    table.wipe(professionNames);
    
    if ( dbEntry ) then
        local data = dbEntry:GetValue(container);
        if ( data ) then
            for name, _ in pairs(data) do
                if ( not tonumber(name) ) then
                    table.insert(professionNames, name);
                end
            end
            table.sort(professionNames);
        end
    end
    
    return professionNames;
end

function Armory:GetNumTradeSkills()
    local dbEntry = self.selectedDbBaseEntry;
    local numSkills, extended, skillType;
    if ( dirty or not self:IsSelectedCharacter(owner) ) then
        GetProfessionLines();
    end
    numSkills = #professionLines;
    if ( numSkills == 0 ) then
        extended = false; --self:GetConfigExtendedTradeSkills();
    elseif ( dbEntry ) then
        _, skillType = dbEntry:GetValue(container, selectedSkill, itemContainer, professionLines[1], "Info");
        extended = not IsRecipe(skillType);
    end
    return numSkills, extended;
end

function Armory:GetTradeSkillInfo(index)
    local _, _, _, _, _, skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps, indentLevel, showProgressBar, currentRank, maxRank, startingRank, displayAsUnavailable, unavailableString = GetProfessionLineValue(index);
    isExpanded = not self:GetHeaderLineState(itemContainer..selectedSkill, skillName); 
    return skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps, indentLevel, showProgressBar, currentRank, maxRank, startingRank, displayAsUnavailable, unavailableString;
end

function Armory:ExpandTradeSkillSubClass(index)
    UpdateTradeSkillHeaderState(index, false);
end

function Armory:CollapseTradeSkillSubClass(index)
    UpdateTradeSkillHeaderState(index, true);
end

function Armory:SetTradeSkillInvSlotFilter(index, onOff, exclusive)
    self:FillTable(invSlots, self:GetTradeSkillInvSlots());
    if ( (index or 0) == 0 ) then
        table.wipe(tradeSkillInvSlotFilter);
        for i = 1, #invSlots do
            tradeSkillInvSlotFilter[invSlots[i]] = onOff;
        end
    elseif ( exclusive ) then
        for i = 1, #invSlots do
            if ( i == index ) then
                tradeSkillInvSlotFilter[invSlots[i]] = onOff;
            else
                tradeSkillInvSlotFilter[invSlots[i]] = not onOff;
            end
        end
    else
        tradeSkillInvSlotFilter[invSlots[index]] = onOff;
    end

    self:ExpandTradeSkillSubClass(0);
end

function Armory:GetTradeSkillInvSlotFilter(index)
    local checked = true;
    self:FillTable(invSlots, self:GetTradeSkillInvSlots());
    if ( (index or 0) == 0 ) then
        for i = 1, #invSlots do
            if ( not tradeSkillInvSlotFilter[invSlots[i]] ) then
                checked = false;
                break;
            end
        end
    else
        checked = tradeSkillInvSlotFilter[invSlots[index]];
    end

    return checked;
end

function Armory:SetTradeSkillSubClassFilter(index, onOff, exclusive)
    local subClasses = self:GetUniqueTradeSkillSubClasses();

    if ( (index or 0) == 0 ) then
        table.wipe(tradeSkillSubClassFilter);
        for i = 1, #subClasses do
            tradeSkillSubClassFilter[subClasses[i]] = onOff;
        end
    elseif ( exclusive ) then
        for i = 1, #subClasses do
            if ( i == index ) then
                tradeSkillSubClassFilter[subClasses[i]] = onOff;
            else
                tradeSkillSubClassFilter[subClasses[i]] = not onOff;
            end
        end
    else
        tradeSkillSubClassFilter[subClasses[index]] = onOff;
    end

    self:ExpandTradeSkillSubClass(0);
end

function Armory:GetTradeSkillSubClassFilter(index)
    local subClasses = self:GetUniqueTradeSkillSubClasses();
    local checked = true;

    if ( (index or 0) == 0 ) then
        for i = 1, #subClasses do
            if ( not tradeSkillSubClassFilter[subClasses[i]] ) then
                checked = false;
                break;
            end
        end
    else
        checked = tradeSkillSubClassFilter[subClasses[index]];
    end

    return checked;
end

function Armory:SetTradeSkillItemNameFilter(text)
    local refresh = (tradeSkillFilter ~= text);
    tradeSkillFilter = text;
    if ( refresh ) then
        dirty = true;
    end
    return refresh;
end

function Armory:GetTradeSkillItemNameFilter()
    return tradeSkillFilter;
end

function Armory:SetTradeSkillItemLevelFilter(minLevel, maxLevel)
    local refresh = (tradeSkillMinLevel ~= minLevel or tradeSkillMaxLevel ~= maxLevel);
    tradeSkillMinLevel = max(0, minLevel);
    tradeSkillMaxLevel = max(0, maxLevel);
    if ( refresh ) then
        dirty = true;
    end
    return refresh;
end

function Armory:GetTradeSkillItemLevelFilter()
    return tradeSkillMinLevel, tradeSkillMaxLevel;
end

function Armory:GetTradeSkillItemFilter(text)
    if ( not text ) then
        text = tradeSkillItemNameFilter or "";
    end
    if ( text == SEARCH ) then
        text = "";
    end
    
    local minLevel, maxLevel;
    local approxLevel = strmatch(text, "^~(%d+)");
    if ( approxLevel ) then
        minLevel = approxLevel - 2;
        maxLevel = approxLevel + 2;
    else
        minLevel, maxLevel = strmatch(text, "^(%d+)%s*-*%s*(%d*)$");
    end
    if ( minLevel ) then
        if ( maxLevel == "" or maxLevel < minLevel ) then
            maxLevel = minLevel;
        end
        text = "";
    else
        minLevel = 0;
        maxLevel = 0;
    end

    return text, minLevel, maxLevel;
end

function Armory:HasTradeSkillFilter()
    if ( not self:GetTradeSkillSubClassFilter(0) ) then
        return true;
    elseif ( not self:GetTradeSkillInvSlotFilter(0) ) then
        return true;
    elseif ( tradeSkillMinLevel > 0 and tradeSkillMaxLevel > 0 ) then
        return true;
    elseif ( tradeSkillFilter ~= "" ) then
        return true;
    end
    return false;
end

function Armory:SelectTradeSkill(index)
    selectedSkillLine = index;
end

function Armory:GetTradeSkillSelectionIndex()
    return selectedSkillLine;
end

function Armory:GetTradeSkillLine()
    if ( selectedSkill ) then
        local rank, maxRank, modifier = GetProfessionValue("Rank");
        return selectedSkill, rank, maxRank, (modifier or 0);
    else
        return "UNKNOWN", 0, 0, 0;
    end
end

function Armory:GetFirstTradeSkill()
    local numLines = self:GetNumTradeSkills();
    for i = 1, numLines do
        local _, skillType = self:GetTradeSkillInfo(i);
        if ( IsRecipe(skillType) ) then
            return i;
        end
    end
    return 0;
end

function Armory:GetUniqueTradeSkillSubClasses()
    self:FillUnbrokenTable(subClasses, self:GetTradeSkillSubClasses());

    -- Create unique list
    for i = 1, #subClasses do
        subClasses[i] = subClasses[i]..i;
    end

    return subClasses;    
end

function Armory:GetTradeSkillSubClasses()
    return GetProfessionValue("SubClasses");
end

function Armory:GetTradeSkillInvSlots()
    return GetProfessionValue("InvSlots");
end

function Armory:GetTradeSkillDescription(index)
    local id = GetProfessionLineValue(index);
    return GetRecipeValue(id, "Description");
end

function Armory:GetTradeSkillCooldown(index)
    local _, cooldown, isDayCooldown, charges, maxCharges = GetProfessionLineValue(index);
    return cooldown, isDayCooldown, charges or 0, maxCharges or 0;
end

function Armory:GetTradeSkillIcon(index)
    local id = GetProfessionLineValue(index);
    return GetRecipeValue(id, "Icon") or nil;
end

function Armory:GetTradeSkillNumMade(index)
    local id = GetProfessionLineValue(index);
    local minMade, maxMade = GetRecipeValue(id, "NumMade");
    minMade = minMade or 0;
    maxMade = maxMade or 0;
    return minMade, maxMade;
end

function Armory:GetTradeSkillNumReagents(index)
    local id = GetProfessionLineValue(index);
    return GetNumReagents(id);
end

function Armory:GetTradeSkillTools(index)
    local id = GetProfessionLineValue(index);
    return GetRecipeValue(id, "Tools") or "";
end

function Armory:GetTradeSkillItemLink(index)
    local id = GetProfessionLineValue(index);
    return GetRecipeValue(id, "ItemLink");
end

function Armory:GetTradeSkillRecipeLink(index)
    local id = GetProfessionLineValue(index);
    return GetRecipeValue(id, "RecipeLink");
end

function Armory:GetTradeSkillReagentInfo(index, id)
    return GetReagentInfo(GetProfessionLineValue(index), id);
end

function Armory:GetTradeSkillReagentItemLink(index, id)
    local _, _, _, link = self:GetTradeSkillReagentInfo(index, id);
    return link;
end

local primarySkills = {};
function Armory:GetPrimaryTradeSkills()
    local dbEntry = self.selectedDbBaseEntry;
    local skillName, skillRank, skillMaxRank, skillModifier;

    table.wipe(primarySkills);

    if ( dbEntry ) then
        for i = 1, 2 do
            skillName = dbEntry:GetValue(container, tostring(i));
            if ( skillName ) then
                skillRank, skillMaxRank, skillModifier = dbEntry:GetValue(container, skillName, "Rank");
                table.insert(primarySkills, {skillName, skillRank, skillMaxRank});
            end
        end
    end
            
    return primarySkills;
end

function Armory:GetTradeSkillRank(profession)
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry ) then
        local rank, maxRank = dbEntry:GetValue(container, profession, "Rank");
        return rank, maxRank;
    end
end

----------------------------------------------------------
-- Find Methods
----------------------------------------------------------

function Armory:FindSkill(itemList, ...)
    local dbEntry = self.selectedDbBaseEntry;
    local list = itemList or {};

    if ( dbEntry ) then
        -- need low-level access because of all the possible active filters
        local professions = dbEntry:GetValue(container);
        if ( professions ) then
            local text, link, skillName, skillType, id;
            for name in pairs(professions) do
                for i = 1, dbEntry:GetNumValues(container, name, itemContainer) do
                    skillName, skillType = dbEntry:GetValue(container, name, itemContainer, i, "Info");
                    if ( IsRecipe(skillType) ) then
                        id = dbEntry:GetValue(container, name, itemContainer, i, "Data");
                        if ( itemList ) then
                            link = GetRecipeValue(id, "ItemLink");
                        else
                            link = GetRecipeValue(id, "RecipeLink");
                        end
                        if ( self:GetConfigExtendedSearch() ) then
                            text = self:GetTextFromLink(link);
                        else
                            text = skillName;
                        end
                        if ( self:FindTextParts(text, ...) ) then
                            table.insert(list, {label=name, name=skillName, link=link});
                        end
                    end
                end
            end
        end
    end

    return list;
end

local recipeOwners = {};
function Armory:GetRecipeOwners(id)
    table.wipe(recipeOwners);

    if ( self:HasTradeSkills() and self:GetConfigShowKnownBy() ) then
        local currentProfile = self:CurrentProfile();

        for _, profile in ipairs(self:GetConnectedProfiles()) do
            self:SelectProfile(profile);

            local dbEntry = self.selectedDbBaseEntry;
            if ( dbEntry:Contains(container) ) then
                local data = dbEntry:SelectContainer(container);
                for profession in pairs(data) do
                    if ( dbEntry:Contains(container, profession, id) ) then
                        table.insert(recipeOwners, self:GetQualifiedCharacterName(profile, true));
                        break;
                    end
                end
            end
        end
        self:SelectProfile(currentProfile);
    end

    return recipeOwners;
end

local function AddKnownBy(profile)
    if ( Armory:GetConfigShowKnownBy() and not Armory:IsPlayerSelected(profile) ) then
        table.insert(recipeOwners, Armory:GetQualifiedCharacterName(profile, true));
    end
end

local recipeCanLearn = {};
local function AddCanLearn(name)
    if ( Armory:GetConfigShowCanLearn() ) then
        table.insert(recipeCanLearn, name);
    end
end

local recipeHasSkill = {};
local function AddHasSkill(name)
    if ( Armory:GetConfigShowHasSkill() ) then
        table.insert(recipeHasSkill, name);
    end
end

function Armory:GetRecipeAltInfo(name, link, profession, reqRank, reqReputation, reqStanding, reqSkill)
    table.wipe(recipeOwners);
    table.wipe(recipeHasSkill);
    table.wipe(recipeCanLearn);

	if ( name and name ~= "" and self:HasTradeSkills() and (self:GetConfigShowKnownBy() or self:GetConfigShowHasSkill() or self:GetConfigShowCanLearn()) ) then
        local currentProfile = self:CurrentProfile();
        local skillName, skillType, dbEntry, character;

        for _, profile in ipairs(self:GetConnectedProfiles()) do
            self:SelectProfile(profile);

            dbEntry = self.selectedDbBaseEntry;

            local known;
            for i = 1, dbEntry:GetNumValues(container, profession, itemContainer) do
                skillName, skillType = dbEntry:GetValue(container, profession, itemContainer, i, "Info");
                if ( IsRecipe(skillType) and IsSameRecipe(skillName, name) ) then
                    known = true;
                    AddKnownBy(profile);
                    break;
                end
            end

            if ( not known and dbEntry:Contains(container, profession) and (self:GetConfigShowHasSkill() or self:GetConfigShowCanLearn()) ) then
				local character = self:GetQualifiedCharacterName(profile, true);
                local skillName, subSkillName, standingID, standing;
                local rank = dbEntry:GetValue(container, profession, "Rank");
                local learnable = reqRank <= rank;
                local attainable = not learnable;
                local unknown = false;

                if ( reqSkill or reqReputation ) then
                    local isValid = reqSkill == nil;
                    if ( reqSkill ) then
                        for i = 1, 6 do
                            skillName, subSkillName = dbEntry:GetValue(container, tostring(i));
                            if ( skillName == profession ) then
                                isValid = reqSkill == skillName or reqSkill == subSkillName;
                                break;
                            end
                        end
                    end
                    if ( not isValid ) then
                        learnable = false;
                        attainable = false;
                    elseif ( reqReputation ) then
                        if ( not self:HasReputation() ) then
                            unknown = true;
                        else
                            standingID, standing = self:GetFactionStanding(reqReputation);
                            if ( learnable ) then
                                learnable = reqStanding <= standingID;
                                attainable = not learnable;
                            end
                        end
                    end
                end

                if ( unknown ) then
                    AddCanLearn(character.." (?)");
                elseif ( attainable ) then
                    character = character.." ("..rank;
                    if ( reqReputation ) then
                        character = character.."/"..standing;
                    end
                    character = character..")";
                    AddHasSkill(character);
                elseif ( learnable ) then
                    AddCanLearn(character);
                end
            end
        end
        self:SelectProfile(currentProfile);
    end

    return recipeOwners, recipeHasSkill, recipeCanLearn;
end

local gemResearch = {
    ["131593"] = true, -- blue
    ["131686"] = true, -- red
    ["131688"] = true, -- green
    ["131690"] = true, -- orange
    ["131691"] = true, -- purple
    ["131695"] = true, -- yellow
};
local cooldowns = {};
function Armory:GetTradeSkillCooldowns(dbEntry)
    table.wipe(cooldowns);

    if ( dbEntry and self:HasTradeSkills() ) then
        local professions = dbEntry:GetValue(container);
        if ( professions ) then
            local cooldown, isDayCooldown, timestamp, skillName, data;
            for profession in pairs(professions) do
                for i = 1, dbEntry:GetNumValues(container, profession, itemContainer) do
                    cooldown, isDayCooldown, timestamp = dbEntry:GetValue(container, profession, itemContainer, i, "Cooldown");
                    if ( cooldown ) then
                        cooldown = self:MinutesTime(cooldown + timestamp, true);
                        if ( cooldown > time() ) then
                            data = dbEntry:GetValue(container, profession, itemContainer, i, "Data");
                            if ( gemResearch[data] ) then
                                skillName = ARMORY_PANDARIA_GEM_RESEARCH;
                            else
                                skillName = dbEntry:GetValue(container, profession, itemContainer, i, "Info");
                                if ( skillName:find(ARMORY_TRANSMUTE) ) then
                                    skillName = ARMORY_TRANSMUTE;
                                end
                            end
                            table.insert(cooldowns, {skill=skillName, time=cooldown});
                        end
                    end
                end
            end
        end
    end

    return cooldowns;
end

function Armory:CheckTradeSkillCooldowns()
    local currentProfile = self:CurrentProfile();
    local cooldowns, cooldown;
    local total = 0;
    for _, profile in ipairs(self:Profiles()) do
        self:SelectProfile(profile);
        cooldowns = self:GetTradeSkillCooldowns(self.selectedDbBaseEntry);
        for _, v in ipairs(cooldowns) do
            cooldown = SecondsToTime(v.time - time(), true, true);
            self:PrintTitle(format("%s (%s@%s) %s %s", v.skill, profile.character, profile.realm, COOLDOWN_REMAINING, cooldown));
            total = total + 1;
        end
    end
    self:SelectProfile(currentProfile);
    if ( total == 0 ) then
        self:PrintRed(ARMORY_CHECK_CD_NONE);
    end
end

local crafters = {};
function Armory:GetCrafters(itemId)
    table.wipe(crafters);

    if ( itemId and self:HasTradeSkills() and self:GetConfigShowCrafters() ) then
        local currentProfile = self:CurrentProfile();
        local dbEntry, buildCache, found, id, link;
        local character;

        for _, profile in ipairs(self:GetConnectedProfiles()) do
            self:SelectProfile(profile);

            dbEntry = self.selectedDbBaseEntry;
            if ( dbEntry:Contains(container) ) then
				character = self:GetQualifiedCharacterName(profile, true);
                found = false;

                for profession in pairs(dbEntry:GetValue(container)) do
                    if ( not ItemCacheExists(dbEntry, profession) ) then
                        for i = 1, dbEntry:GetNumValues(container, profession, itemContainer) do
                            id = dbEntry:GetValue(container, profession, itemContainer, i, "Data");
                            link = GetRecipeValue(id, "ItemLink");
                            SetItemCache(dbEntry, profession, link);
                            if ( itemId == self:GetItemId(link) ) then
                                table.insert(crafters, character);
                                if ( self:GetConfigUseEncoding() ) then
                                    found = true;
                                    break;
                                end
                            end
                        end
                        if ( found ) then
                            break;
                        end
                    elseif ( ItemIsCached(dbEntry, profession, itemId) ) then
                        table.insert(crafters, character);
                    end
                end
            end
        end
        self:SelectProfile(currentProfile);
    end

    return crafters;
end

function Armory:GetInscribers(glyphName, class)
    table.wipe(crafters);

    if ( glyphName and class and self:HasTradeSkills() and self:GetConfigShowCrafters() ) then
        local currentProfile = self:CurrentProfile();
        local profession = ARMORY_TRADE_INSCRIPTION;
        local key = self:GetGlyphKey(glyphName);
        local dbEntry, id, link, name;
        local character;

        for _, profile in ipairs(self:GetConnectedProfiles()) do
            self:SelectProfile(profile);

            dbEntry = self.selectedDbBaseEntry;
            if ( dbEntry:Contains(container, profession) ) then
                for i = 1, dbEntry:GetNumValues(container, profession, itemContainer) do
                    name = dbEntry:GetValue(container, profession, itemContainer, i, "Info");
                    if ( self:GetGlyphKey(name) == key ) then
                        id = dbEntry:GetValue(container, profession, itemContainer, i, "Data");
                        link = GetRecipeValue(id, "ItemLink");
                        if ( link ) then
                            local _, _, _, _, _, _, _, reqClass = self:GetRequirementsFromLink(link);
		                    character = self:GetQualifiedCharacterName(profile, true);
                            if ( not reqClass ) then
                                table.insert(crafters, character.."(?)");
                                break;
                            elseif ( class == reqClass ) then
                                table.insert(crafters, character);
                                break;
                            end
                        end
                    end
                end
            end
        end
        self:SelectProfile(currentProfile);
    end

    return crafters;
end

----------------------------------------------------------
-- API Methods
----------------------------------------------------------

local registeredAddOns = {};
function Armory:RegisterTradeSkillAddOn(addOnName, unregisterUpdateEvents, registerUpdateEvents)
    assert(type(addOnName) == "string", "Bad argument #1 to 'RegisterTradeSkillAddOn' (string expected)");
    assert(type(unregisterUpdateEvents) == "function", "Bad argument #2 to 'RegisterTradeSkillAddOn' (function expected)");
    assert(type(registerUpdateEvents) == "function", "Bad argument #3 to 'RegisterTradeSkillAddOn' (function expected)");
    if ( not registeredAddOns[addOnName] ) then
        registeredAddOns[addOnName] = {};
    end
    registeredAddOns[addOnName].unregisterUpdateEvents = unregisterUpdateEvents;
    registeredAddOns[addOnName].registerUpdateEvents = registerUpdateEvents;
end

function Armory:UnregisterTradeSkillUpdateEvents()
    for _, addOn in pairs(registeredAddOns) do
        pcall(addOn.unregisterUpdateEvents);
    end
end

function Armory:RegisterTradeSkillUpdateEvents()
    for _, addOn in pairs(registeredAddOns) do
        pcall(addOn.registerUpdateEvents);
    end
end