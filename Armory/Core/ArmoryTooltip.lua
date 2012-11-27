--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 514 2012-09-09T21:26:36Z
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

local tooltipHooks = {};
local tooltipLines = {};

----------------------------------------------------------
-- Tooltip Enhancement
----------------------------------------------------------

local function AddSpacer(tooltip)
    local lastLine = _G[tooltip:GetName().."TextLeft"..tooltip:NumLines()];
    if ( lastLine and strtrim(lastLine:GetText() or "") ~= "" ) then
        tooltip:AddLine(" ");
    end
    return 1;
end

local function AddAltsText(tooltip, spaceAdded, list, text, r, g, b)
    if ( list and #list > 0 ) then
        spaceAdded = spaceAdded or AddSpacer(tooltip);
        for i = 1, #list do
            if ( i == 1 ) then
                tooltip:AddDoubleLine(text, list[i], r, g, b, r, g, b);
            else
                tooltip:AddDoubleLine(" ", list[i], r, g, b, r, g, b);
            end
        end
    end
    return spaceAdded;
end

local knownBy;

local minLevelPattern = ITEM_MIN_LEVEL:gsub("(%%d)", "(.+)");
local rankPattern = ITEM_MIN_SKILL:gsub("%d%$", ""):gsub("%%s", "(.+)"):gsub("%(%%d%)", "%%((%%d+)%%)");
local repPattern = ITEM_REQ_REPUTATION:gsub("%-", "%%-"):gsub("%%s", "(.+)");
local skillPattern = ITEM_REQ_SKILL:gsub("%d%$", ""):gsub("%%s", "(.+)");
local racesPattern = ITEM_RACES_ALLOWED:gsub("%%s", "(.+)");
local classesPattern = ITEM_CLASSES_ALLOWED:gsub("%%s", "(.+)");

local function GetRequirements(tooltip)
    local text, standing;
    local reqLevel, reqProfession, reqRank, reqReputation, reqStanding, reqSkill, reqRaces, reqClasses;

    for i = 2, tooltip:NumLines() do
        text = Armory:GetTooltipText(tooltip, i);
        if ( (text or "") ~= "" ) then
            if ( text:find(ITEM_SPELL_TRIGGER_ONUSE) ) then	
                break;
                
            elseif ( text:find(rankPattern) ) then
                reqProfession, reqRank = text:match(rankPattern);
            
            elseif ( text:find(repPattern) ) then 
                reqReputation, standing = text:match(repPattern);
                reqStanding = 9;
                for j = 1, 8 do
                    if ( standing == _G["FACTION_STANDING_LABEL"..j] or standing == _G["FACTION_STANDING_LABEL"..j.."_FEMALE"] ) then
                        reqStanding = j;
                        break;
                    end
                end

            elseif ( text:find(skillPattern) ) then
                text:gsub(skillPattern, function(a, b) reqSkill = a; end);

            elseif ( text:find(racesPattern) ) then
                reqRaces = text:match(racesPattern);

            elseif ( text:find(classesPattern) ) then
                reqClasses = text:match(classesPattern);
                
            elseif ( text:find(minLevelPattern) ) then
                reqLevel = text:match(minLevelPattern);

            end
        end
    end
    
    return tonumber(reqLevel), reqProfession, tonumber(reqRank), reqReputation, reqStanding, reqSkill, reqRaces, reqClasses;
end

local currentItem, gemInfo, crafters, itemCount, hasSkill, canLearn;
local function EnhanceItemTooltip(tooltip, id, link)
    local spaceAdded, name;
    
    if ( link ~= currentItem ) then
        gemInfo = nil;
        knownBy = nil;
        canLearn = nil;
        hasSkill = nil;
        crafters = nil;

        -- Need the fully qualified link
        name, link = tooltip:GetItem();

        local  _, currentItem, _, _, minLevel, itemType, itemSubType = GetItemInfo(id);
        local reqProfession, reqRank, reqReputation, reqStanding, reqSkill;

        if ( itemType == ARMORY_RECIPE ) then
            _, reqProfession, reqRank, reqReputation, reqStanding, reqSkill = GetRequirements(tooltip);
            knownBy, hasSkill, canLearn = Armory:GetRecipeAltInfo(name, link, reqProfession, reqRank, reqReputation, reqStanding, reqSkill);

        elseif ( itemType == ARMORY_GLYPH ) then
            knownBy, hasSkill, canLearn = Armory:GetGlyphAltInfo(name, itemSubType, minLevel);
            crafters = Armory:GetInscribers(name, itemSubType);
            
        elseif ( itemSubType ~= PET and itemSubType ~= MOUNT ) then
            if ( Armory:GetConfigShowGems() ) then
                local numGems;
                gemInfo, numGems = Armory:GetSocketInfo(link);
                if ( numGems == 0 ) then
                    gemInfo = nil;
                end
            end
            
            crafters = Armory:GetCrafters(id);
        end

        itemCount = Armory:GetItemCount(link);
    end

    if ( gemInfo ) then
        AddSpacer(tooltip);
        for _, socket in ipairs(gemInfo) do
            if ( socket.link ) then
                tooltip:AddLine(Armory:GetColorFromLink(socket.link)..socket.gem..FONT_COLOR_CODE_CLOSE.." : "..(socket.gemColor or UNKNOWN));
                tooltip:AddTexture(socket.texture);
            end
        end
        spaceAdded = spaceAdded or AddSpacer(tooltip);
    end

    if ( itemCount and #itemCount > 0 ) then
        spaceAdded = spaceAdded or AddSpacer(tooltip);
        local count, bagCount, bankCount, mailCount, auctionCount, equipCount, voidCount = 0, 0, 0, 0, 0, 0, 0;
        local details;
        local r, g, b = Armory:GetConfigItemCountColor();
        for k, v in ipairs(itemCount) do
            if ( not v.currency ) then
                count = count + v.count;
            end
            bagCount = bagCount + (v.bags or 0);
            bankCount = bankCount + (v.bank or 0);
            mailCount = mailCount + (v.mail or 0);
            auctionCount = auctionCount + (v.auction or 0);
            equipCount = equipCount + (v.equipped or 0);
            voidCount = voidCount + (v.void or 0);
            details = v.details or Armory:GetCountDetails(v.bags, v.bank, v.mail, v.auction, nil, nil, v.equipped, v.void);
            tooltip:AddDoubleLine(format("%s [%d]", v.name, v.count), details, r, g, b, r, g, b);
        end

        if ( Armory:HasInventory() and count > 0 and Armory:GetConfigShowItemCountTotals() ) then
            r, g, b = Armory:GetConfigItemCountTotalsColor();
            local guildCount = count - bagCount - bankCount - mailCount - auctionCount - equipCount - voidCount;
            details = Armory:GetCountDetails(bagCount, bankCount, mailCount, auctionCount, nil, guildCount, equipCount, voidCount);
            tooltip:AddDoubleLine(format(ARMORY_TOTAL, count), details, r, g, b, r, g, b);
        end
    end

    spaceAdded = AddAltsText(tooltip, spaceAdded, crafters, ARMORY_CRAFTABLE_BY, Armory:GetConfigCraftersColor());
    spaceAdded = AddAltsText(tooltip, spaceAdded, knownBy, USED, Armory:GetConfigKnownColor());
    spaceAdded = AddAltsText(tooltip, spaceAdded, hasSkill, ARMORY_WILL_LEARN, Armory:GetConfigHasSkillColor());
    spaceAdded = AddAltsText(tooltip, spaceAdded, canLearn, ARMORY_CAN_LEARN, Armory:GetConfigCanLearnColor());

    tooltip:Show();
end

local currentRecipe, reagents, reagentCount;
local function EnhanceRecipeTooltip(tooltip, id, link)
    local spaceAdded;
    
    if ( id ~= currentRecipe ) then
        currentRecipe = id;

        if ( tooltip ~= GameTooltip ) then
            knownBy = Armory:GetRecipeOwners(id);
        end

        reagentCount = nil;
        if ( Armory:HasInventory() and Armory:GetConfigShowItemCount() ) then
            reagents = Armory:GetReagentsFromTooltip(tooltip);
            if ( reagents ) then
                reagentCount = Armory:GetMultipleItemCount(reagents);
            end
        end
    end

    spaceAdded = AddAltsText(tooltip, spaceAdded, knownBy, USED, Armory:GetConfigKnownColor());

    if ( reagentCount and #reagentCount > 0 ) then
        local count, bags, bank, mail, auction, alts;
        local name, quantity, details;

        spaceAdded = spaceAdded or AddSpacer(tooltip);
        local r, g, b = Armory:GetConfigItemCountColor();
        for i = 1, #reagents do
            name, quantity = unpack(reagents[i]);
            count, bags, bank, mail, auction, alts = 0, 0, 0, 0, 0, 0;
            for _, v in ipairs(reagentCount[i]) do
                if ( v.mine ) then
                    bags = bags + (v.bags or 0);
                    bank = bank + (v.bank or 0);
                    mail = mail + (v.mail or 0);
                    auction = auction + (v.auction or 0);
                else
                    alts = alts + (v.bags or 0) + (v.bank or 0) + (v.mail or 0) + (v.auction or 0);
                end
                count = count + v.count;
            end
            details = Armory:GetCountDetails(bags, bank, mail, auction, alts, count - bags - bank - mail - auction - alts);
            tooltip:AddDoubleLine(name..format(" [%d/%d]", count, quantity), details, r, g, b, r, g, b);
        end
    end
    
    tooltip:Show();
end

local function EnhanceQuestTooltip(tooltip, id, link)
    if ( not (Armory:HasQuestLog() and Armory:GetConfigShowQuestAlts()) ) then
        return;
    end

    local currentProfile = Armory:CurrentProfile();

    table.wipe(tooltipLines);

    for _, character in ipairs(Armory:CharacterList(Armory.playerRealm)) do
        Armory:LoadProfile(Armory.playerRealm, character);

        if ( Armory:IsOnQuest(id) ) then
            table.insert(tooltipLines, character);
        end
    end
    Armory:SelectProfile(currentProfile);
    
    if ( #tooltipLines > 0 ) then
        AddSpacer(tooltip);
        local r, g, b = Armory:GetConfigQuestAltsColor();
        tooltip:AddLine(ARMORY_QUEST_TOOLTIP_LABEL);
        tooltip:AddLine(table.concat(tooltipLines, ", "), r, g, b, true);
        tooltip:Show();
    end
end

local function EnhanceGlyphTooltip(tooltip, id, link)
    local name = Armory:GetNameFromLink(link);
    if ( name ) then
        if ( tooltip ~= GameTooltip ) then
            local reqLevel, _, _, _, _, _, _, reqClass = GetRequirements(tooltip);
            crafters = Armory:GetInscribers(name, reqClass);
            knownBy, hasSkill, canLearn = Armory:GetGlyphAltInfo(name, reqClass, reqLevel);

            AddAltsText(tooltip, nil, crafters, ARMORY_CRAFTABLE_BY, Armory:GetConfigCraftersColor());
            AddAltsText(tooltip, nil, knownBy, USED, Armory:GetConfigKnownColor());
            AddAltsText(tooltip, nil, hasSkill, ARMORY_WILL_LEARN, Armory:GetConfigHasSkillColor());
            AddAltsText(tooltip, nil, canLearn, ARMORY_CAN_LEARN, Armory:GetConfigCanLearnColor());
        else
            crafters = Armory:GetInscribers(name, _G.UnitClass("player"));

            AddAltsText(tooltip, nil, crafters, ARMORY_CRAFTABLE_BY, Armory:GetConfigCraftersColor());
        end
        tooltip:Show();
    end
end

local function EnhanceCurrencyTooltip(tooltip, id, link)
    if ( not (Armory:HasCurrency() and Armory:GetConfigShowItemCount()) ) then
        return;
    end

    local currentProfile = Armory:CurrentProfile();
    local count;
    table.wipe(tooltipLines);

    for _, character in ipairs(Armory:CharacterList(Armory.playerRealm)) do
        Armory:LoadProfile(Armory.playerRealm, character);

        count = Armory:CountCurrency(link);
        if ( count > 0 ) then
            table.insert(tooltipLines, {name=character, count=count});
        end
    end
    Armory:SelectProfile(currentProfile);
    
    if ( #tooltipLines > 0 ) then
        AddSpacer(tooltip);
        local r, g, b = Armory:GetConfigItemCountColor();
        for _, v in ipairs(tooltipLines) do
            tooltip:AddLine(format("%s [%d]", v.name, v.count), r, g, b);
        end
        tooltip:Show();
    end
end

----------------------------------------------------------
-- Tooltip Internals
----------------------------------------------------------

local function ExecuteHook(tooltip, hook)
    local link = tooltip.alink;
    if ( link ) then
        local idType, id = Armory:GetLinkId(link);
        if ( hook.idType == idType and hook.id == id ) then
            return;
        end

        hook.idType = idType;
        hook.id = id;

        if ( hook.hooks[idType] and id ) then
            for _, v in ipairs(hook.hooks[idType]) do
                v[1](tooltip, id, link);
            end
        end
    end
end

local function RegisterTooltipHook(tooltip, idType, hook, reset)
    if ( not tooltip ) then
        return;
    elseif ( not tooltipHooks[tooltip] ) then
        tooltipHooks[tooltip] = {};
        tooltipHooks[tooltip].hooks = {};

        local dummyCurrencyLink = function(currencyName)
            return "|cffffffff|Hcurrency:0|h["..currencyName.."]|h|r";
        end;

        hooksecurefunc(tooltip, "SetCurrencyToken", function(self, index)
            local hook = tooltipHooks[self];
            if ( index and not self:GetItem() ) then
                local currencyName = _G.GetCurrencyListInfo(index);
                if ( currencyName ) then
                    self.alink = dummyCurrencyLink(currencyName);
                    ExecuteHook(self, hook);
                end
            end
        end);

        hooksecurefunc(tooltip, "SetQuestCurrency", function(self, type, index) 
            local hook = tooltipHooks[self];
            if ( index and not self:GetItem() ) then
                local currencyName = _G.GetQuestCurrencyInfo(type, index);
                if ( currencyName ) then
                    self.alink = dummyCurrencyLink(currencyName);
                    ExecuteHook(self, hook);
                end
            end
        end);

        hooksecurefunc(tooltip, "SetQuestLogCurrency", function(self, type, index)
            local hook = tooltipHooks[self];
            if ( index and not self:GetItem() ) then
                local currencyName = _G.GetQuestLogRewardCurrencyInfo(index);
                if ( currencyName ) then
                    self.alink = dummyCurrencyLink(currencyName);
                    ExecuteHook(self, hook);
                end
            end
        end);

        hooksecurefunc(tooltip, "SetTradeSkillItem", function(self, index)
            local hook = tooltipHooks[self];
            if ( index and not self:GetItem() ) then
                self.alink = _G.GetTradeSkillItemLink(index);
                ExecuteHook(self, hook);
            end
        end);
        
        hooksecurefunc(tooltip, "SetMerchantCostItem", function(self, index, item)
            local hook = tooltipHooks[self];
            if ( index and item ) then
                local _, _, link, currencyName = _G.GetMerchantItemCostItem(index, item);
                if ( link ) then
                    self.alink = link;
                    ExecuteHook(self, hook);
                elseif ( currencyName ) then
                    self.alink = dummyCurrencyLink(currencyName);
                    ExecuteHook(self, hook);
                end
            end
        end);

        hooksecurefunc(tooltip, "SetGlyphByID", function(self, id)
            local hook = tooltipHooks[self];
            if ( id ) then
                local button = GetMouseFocus();
                if ( button and button.glyphIndex ) then
                    self.alink = select(6, _G.GetGlyphInfo(button.glyphIndex));
                    ExecuteHook(self, hook);
                end
            end
        end);

        hooksecurefunc(tooltip, "SetHyperlink", function(self, link)
            local hook = tooltipHooks[self];
            self.alink = link;
            ExecuteHook(self, hook);
        end);
        
        tooltip:HookScript("OnTooltipSetItem", function(self)
            local hook = tooltipHooks[self];
            self.alink = select(2, self:GetItem());
            ExecuteHook(self, hook);
        end);

        tooltip:HookScript("OnTooltipCleared", function(self)
            local hook = tooltipHooks[self];
            local idType = hook.idType;

            if ( idType and hook.hooks[idType] ) then
                for _, v in ipairs(hook.hooks[idType]) do
                    if ( v[2] ) then
                        v[2](self);
                    end
                end
            end
            
            hook.idType = nil;
            hook.id = nil;
        end);
    end
    if ( not tooltipHooks[tooltip].hooks[idType] ) then
        tooltipHooks[tooltip].hooks[idType] = {};
    end
    table.insert(tooltipHooks[tooltip].hooks[idType], {hook, reset});
end

local function GetFontStringTextString(fontString)
    if ( fontString ) then
        local text = fontString:GetText();
        if ( text and strtrim(text) ~= "" ) then
            return Armory:Text2String(text, fontString:GetTextColor());
        end
    end
    return "";
end

----------------------------------------------------------
-- Tooltip Functions
----------------------------------------------------------

function Armory:RegisterTooltipHooks(tooltip)
    RegisterTooltipHook(tooltip, "item", EnhanceItemTooltip);
    RegisterTooltipHook(tooltip, "enchant", EnhanceRecipeTooltip);
    RegisterTooltipHook(tooltip, "quest", EnhanceQuestTooltip);
    RegisterTooltipHook(tooltip, "glyph", EnhanceGlyphTooltip);
    RegisterTooltipHook(tooltip, "currency", EnhanceCurrencyTooltip);
end

function Armory:ResetTooltipHook()
    currentItem = nil; 
    currentRecipe = nil;
end

function Armory:RefreshTooltip(tooltip)
   if ( tooltip and tooltip.alink and tooltip:IsShown() ) then
        tooltip:ClearLines();
        tooltip:SetHyperlink(tooltip.alink);
        tooltip:Show();
    end
end

function Armory:GetTooltipText(tooltip, index, side)
    local fontString = _G[tooltip:GetName().."Text"..(side or "Left")..(index or 1)];
    if ( fontString and fontString:IsShown() ) then
        return fontString:GetText();
    end
end

function Armory:IsValidTooltip(tooltip)
    local numLines = tooltip:NumLines();
    local text;

    if ( numLines == 0 ) then
        return false;
    end
    
    for i = 1, numLines  do
        text = self:GetTooltipText(tooltip, i);
        if ( text == RETRIEVING_ITEM_INFO ) then
            return false;
        end
    end

    return true;
end

local sides = {"Left", "Right"};
function Armory:Tooltip2String(tooltip, all)
    local result = "";
    local text;

    for i = 1, tooltip:NumLines() do
        for _, side in ipairs(sides) do
            text = self:GetTooltipText(tooltip, i, side);
            if ( text ) then
                result = result..text.."\n";
            end
            if ( not all ) then
                break;
            end
        end
    end

    return result;
end

function Armory:Tooltip2Table(tooltip, all)
    local name = tooltip:GetName();
    local lines = {};
    local textLeft, textRight, icon, relativeTo, line;

    for i = 1, tooltip:NumLines() do
        textLeft = _G[name.."TextLeft"..i];
        if ( textLeft and textLeft:IsShown() ) then
            lines[i] = GetFontStringTextString(textLeft);
        else
            lines[i] = "";
        end
        textRight = _G[name.."TextRight"..i];
        if ( textRight and textRight:IsShown() ) then
            lines[i] = lines[i]..ARMORY_TOOLTIP_COLUMN_SEPARATOR..GetFontStringTextString(textRight);
        end

        if ( not all and lines[i] == "" ) then
            table.remove(lines, i);
            break;
        end
    end

    for i = 1, 10 do
        icon = _G[name.."Texture"..i];
        if ( icon and icon:IsShown() ) then
            _, relativeTo = icon:GetPoint();
            line = tonumber(relativeTo:GetName():match("(%d+)$"));
            if ( line > 0 and line <= #lines ) then
                lines[line] = lines[line]..ARMORY_TOOLTIP_TEXTURE_SEPARATOR..icon:GetTexture();
            end
        else
            break;
        end
    end

    return lines;
end

function Armory:Table2Tooltip(tooltip, t, firstWrap)
    local line, texture, left, right, textLeft, textRight;
    local leftR, leftG, leftB, rightR, rightG, rightB;

    tooltip:ClearLines();
    for i = 1, #t do
        line, texture = strsplit(ARMORY_TOOLTIP_TEXTURE_SEPARATOR, t[i]);
        if ( line ) then
            left, right = strsplit(ARMORY_TOOLTIP_COLUMN_SEPARATOR, line);
            if ( left ) then
                leftR, leftG, leftB, textLeft = self:String2Text(left);
                if ( right ) then
                    rightR, rightG, rightB, textRight = self:String2Text(right);
                    tooltip:AddDoubleLine(textLeft, textRight, leftR, leftG, leftB, rightR, rightG, rightB);
                elseif ( (textLeft or "") == "" ) then
                    tooltip:AddLine(" ");
                else
                    tooltip:AddLine(textLeft, leftR, leftG, leftB, not texture and i >= (firstWrap or 3));
                end
            end
            if ( texture ) then
                tooltip:AddTexture(texture);
            end
        end
    end
end

function Armory:AllocateTooltip()
    local tooltip;
    if ( not self.dummyTips ) then
        self.dummyTips = {};
    end
    for i = 1, #self.dummyTips do
        tooltip = self.dummyTips[i];
        if ( not tooltip.allocated ) then
            tooltip.allocated = true;
            tooltip:ClearLines();
            for i = 1, 4 do
                _G[tooltip:GetName().."Texture"..i]:SetTexture("");
            end
            -- For some reason the owner might become nil
            tooltip:SetOwner(UIParent, "ANCHOR_NONE");
            return tooltip;
        end
    end
    tooltip = CreateFrame("GameTooltip", "ArmoryTooltip"..(#self.dummyTips + 1), UIParent, "GameTooltipTemplate")
    tooltip:SetOwner(UIParent, "ANCHOR_NONE");
    tooltip.allocated = true;
    table.insert(self.dummyTips, tooltip);

    return tooltip;
end

function Armory:ReleaseTooltip(tooltip)
    tooltip.allocated = false;
end

function Armory:TooltipAddHints(tooltip, ...)
    for i = 1, select("#", ...) do
        tooltip:AddLine(select(i, ...), GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, 1);
    end
end

local setPattern = EQUIPMENT_SETS:gsub("%%s", ".+");
local madeByPattern = ITEM_CREATED_BY:gsub("%%s", ".+");
local cdPattern = ITEM_COOLDOWN_TIME:gsub("%%s", ".+");

function Armory:GetTinkerFromTooltip(tooltip1, tooltip2)
    if ( (tooltip1:GetItem()) ~= (tooltip2:GetItem()) ) then
        return;
    end

    local tinker, anchor;
    
    local tooltip1Index = tooltip1:NumLines();
    local tooltip2Index = tooltip2:NumLines();
    local tooltip1Line = self:GetTooltipText(tooltip1, tooltip1Index);
    local tooltip2Line = self:GetTooltipText(tooltip2, tooltip2Index);

    while ( tooltip1Index > 1 ) do
        if ( tooltip1Line == RETRIEVING_ITEM_INFO or tooltip2Line == RETRIEVING_ITEM_INFO ) then
            return;
        elseif ( tooltip1Line:find(setPattern) or tooltip1Line:find(madeByPattern) or tooltip1Line:find(cdPattern) or tooltip1Line == ITEM_SOCKETABLE ) then
            tooltip1Index = tooltip1Index - 1;
        elseif ( tooltip1Line:find(ITEM_LEVEL) or tooltip1Line:find(ITEM_MIN_LEVEL) ) then
            break;
        elseif ( tooltip1Line == tooltip2Line ) then    
            tooltip1Index = tooltip1Index - 1;
            tooltip2Index = tooltip2Index - 1;
        else
            tinker = tooltip1Line;
            anchor = tooltip2Index;
            break;
        end
        tooltip1Line = self:GetTooltipText(tooltip1, tooltip1Index);
        tooltip2Line = self:GetTooltipText(tooltip2, tooltip2Index);
    end
    
    return tinker, anchor;
end

function Armory:GetRequirementsFromLink(link)
    local tooltip = self:AllocateTooltip();
    tooltip:SetHyperlink(link);
    local reqLevel, reqProfession, reqRank, reqReputation, reqStanding, reqSkill, reqRaces, reqClasses = GetRequirements(tooltip);
    self:ReleaseTooltip(tooltip);
    return reqLevel, reqProfession, reqRank, reqReputation, reqStanding, reqSkill, reqRaces, reqClasses;
end

function Armory:SetHyperlink(tooltip, link, tinker, anchor)
    if ( not (link and tooltip) ) then
        return;
    end
    ---- prevent feedback error on PTR
    --local GetMerchantItemLink_Orig = GetMerchantItemLink;
    --GetMerchantItemLink = function() end;
    tooltip:SetHyperlink(link);
    --GetMerchantItemLink = GetMerchantItemLink_Orig;
    
    if ( tinker ) then
        local tooltipLines = self:Tooltip2Table(tooltip, true);
        table.insert(tooltipLines, min(anchor, #tooltipLines) + 1, self:Text2String(tinker, GetTableColor(GREEN_FONT_COLOR)));
        self:Table2Tooltip(tooltip, tooltipLines);
        tooltip:Show();
    end
end

function Armory:AddEnhancedTip(frame, normalText, r, g, b, enhancedText, noNormalText)
    if ( self:GetConfigShowEnhancedTips() ) then
        GameTooltip_SetDefaultAnchor(GameTooltip, frame);
        if ( normalText ) then
            GameTooltip:SetText(normalText, r, g, b);
            GameTooltip:AddLine(enhancedText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
        else
            GameTooltip:SetText(enhancedText, r, g, b, 1, 1);
        end
        GameTooltip:Show();
    elseif ( not noNormalText ) then
        GameTooltip:SetOwner(frame, "ANCHOR_RIGHT");
        GameTooltip:SetText(normalText, r, g, b);
    end
end
