--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 513 2012-09-09T20:38:34Z
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

ARMORY_NUM_PET_SLOTS = 5;
ARMORY_NUM_PET_ABILITIES = 6;

StaticPopupDialogs["ARMORY_DELETE_PET"] = {
    text = ARMORY_DELETE_UNIT,
    button1 = YES,
    button2 = NO,
    OnAccept = function (self) Armory:DeletePet(Armory:GetCurrentPet()); end,
    OnCancel = function (self) Armory.selectedPet = ArmoryPetFrame.selectedPet; end,
    OnHide = function (self) ArmoryPetFrame_Update(1); end,
    timeout = 0,
    whileDead = 1,
    exclusive = 1,
    showAlert = 1,
    hideOnEscape = 1
};

local STRIPE_COLOR = {r=0.9, g=0.9, b=1};
local STATCATEGORY_PADDING = 4;

function ArmoryPetSlot_OnClick(self, button)
    local pets = Armory:GetPets();
    if ( pets[self:GetID()] ) then
        for i = 1, ARMORY_NUM_PET_SLOTS do
            _G["ArmoryPetFramePet"..i]:SetChecked(false);
        end
        
        self:SetChecked(true);
        Armory.selectedPet = pets[self:GetID()];

        if ( button == "RightButton" ) then
            StaticPopup_Show("ARMORY_DELETE_PET", Armory:GetCurrentPet());
        else
            ArmoryPetFrame_Update(1);
        end
    end
end

function ArmoryPetFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("PET_UI_UPDATE");
    self:RegisterEvent("PET_BAR_UPDATE");
    self:RegisterEvent("PET_UI_CLOSE");
    self:RegisterEvent("UNIT_PET");
    self:RegisterEvent("UNIT_MODEL_CHANGED");
    self:RegisterEvent("UNIT_LEVEL");
    self:RegisterEvent("UNIT_RESISTANCES");
    self:RegisterEvent("UNIT_STATS");
    self:RegisterEvent("UNIT_DAMAGE");
    self:RegisterEvent("UNIT_RANGEDDAMAGE");
    self:RegisterEvent("UNIT_ATTACK_SPEED");
    self:RegisterEvent("UNIT_ATTACK_POWER");
    self:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
    self:RegisterEvent("UNIT_DEFENSE");
    self:RegisterEvent("UNIT_ATTACK");
    self:RegisterEvent("PET_SPELL_POWER_UPDATE");

    ArmoryPetFrame_InitStatCategories();

    self.page = 1;
end

function ArmoryPetFrame_OnEvent(self, event, ...)
    local arg1 = ...;
    
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        if ( HasPetUI() ) then
            Armory:ExecuteConditional(ArmoryPetFrame_HasPetData, ArmoryPetFrame_Update);
        end
    elseif ( event == "PET_UI_UPDATE" or event == "PET_BAR_UPDATE" or (event == "UNIT_PET" and arg1 == "player") ) then
        ArmoryFrameTab_Update();
        Armory:ExecuteConditional(ArmoryPetFrame_HasPetData, ArmoryPetFrame_Update);
    elseif ( event == "PET_UI_CLOSE" ) then
        ArmoryFrameTab_Update();
    elseif( event == "PET_SPELL_POWER_UPDATE" ) then
        Armory:Execute(ArmoryPetFrame_UpdateStats);
    elseif ( arg1 == "pet" ) then
        Armory:Execute(ArmoryPetFrame_UpdateStats);
    end
end

function ArmoryPetFrame_HasPetData()
    local stat, effectiveStat = UnitStat("pet", 3);
    return stat and effectiveStat;
end

function ArmoryPetFrame_OnShow(self)
    Armory.selectedPet = Armory:UnitName("pet");
    ArmoryFrameInset:SetPoint("TOPLEFT", ArmoryFrame, "TOPLEFT", 4, -70);
    ArmoryFrameInset:SetPoint("BOTTOMRIGHT", ArmoryFrame, "BOTTOMRIGHT", -6, 114);
    ArmoryPetFrame_Update();
end

function ArmoryPetFrame_OnHide(self)
    ArmoryFrameInset:SetPoint("TOPLEFT", ArmoryFrame, "TOPLEFT", 4, -60);
    ArmoryFrameInset:SetPoint("BOTTOMRIGHT", ArmoryFrame, "BOTTOMRIGHT", -6, 4);
end

function ArmoryPetFrame_Update(petChanged)
    if ( (not Armory:PetsEnabled() or petChanged) and ArmorySpellBookFrame:IsShown() and ArmorySpellBookFrame.bookType == BOOKTYPE_PET ) then
        ArmorySpellBookFrame:Hide();
        ArmorySpellBookFrame:Show();
    end

    local currentPet = Armory:GetCurrentPet();
    if ( not Armory:PetsEnabled() or (currentPet == UNKNOWN and not Armory:HasPetUI()) ) then
        ArmoryFrameTab_Update(); 
        return;
    end

    local pets = Armory:GetPets();
    ArmoryPetFrame.maxPages = ceil(#pets / ARMORY_NUM_PET_SLOTS);

    local button, background, icon, index;
    for i = 1, ARMORY_NUM_PET_SLOTS do
        button = _G["ArmoryPetFramePet"..i];
        background = _G["ArmoryPetFramePet"..i.."Background"];
        index = (ArmoryPetFrame.page - 1) * ARMORY_NUM_PET_SLOTS + i;
        button:SetID(index);
        if ( index <= #pets ) then
            Armory.selectedPet = pets[index];
            local name, realName = Armory:UnitName("pet");
            if (realName and Armory.selectedPet == name ) then
                button.PetName:SetText(realName);
            else
                button.PetName:SetText(Armory.selectedPet);
            end
            background:SetVertexColor(1.0, 1.0, 1.0);
            button:Enable();
            icon = Armory:GetPetIcon();
            SetItemButtonTexture(button, icon);
            if ( icon ) then
                button.tooltip = button.PetName:GetText();
                button.tooltipSubtext = format(UNIT_TYPE_LEVEL_TEMPLATE, Armory:UnitLevel("pet"), Armory:UnitCreatureFamily("pet"));
                button.hint = ARMORY_DELETE_UNIT_HINT;
            else
                button.tooltip = nil;
                button.tooltipSubtext = "";
                button.hint = nil;
            end
            button:SetChecked(Armory.selectedPet == currentPet and icon);
        else
            button.PetName:SetText("");
            SetItemButtonTexture(button, "");
            background:SetVertexColor(1.0,0.1,0.1);
            button:SetChecked(false);
            button:Disable();
        end
    end
    Armory.selectedPet = currentPet;
    ArmoryPetFrame.selectedPet = currentPet;

    local _, canGainXP = Armory:HasPetUI();
    if ( canGainXP and Armory:GetPetFoodTypes() ) then
        ArmoryPetFrameDiet.tooltip = format(PET_DIET_TEMPLATE, BuildListString(Armory:GetPetFoodTypes()));
        ArmoryPetFrameDiet:Show();
    else
        ArmoryPetFrameDiet:Hide();
    end
        
    ArmoryPetFrame_SetSelectedPetInfo();
    ArmoryPetFrame_UpdateSpec();
    ArmoryPetFrame_UpdateStats();
    	
    -- Select correct page
    if ( ArmoryPetFrame.page == 1 ) then
        ArmoryPetFramePrevPageButton:Disable();
    else
        ArmoryPetFramePrevPageButton:Enable();
    end
    if ( ArmoryPetFrame.maxPages == 0 or ArmoryPetFrame.page == ArmoryPetFrame.maxPages ) then
        ArmoryPetFrameNextPageButton:Disable();
    else
        ArmoryPetFrameNextPageButton:Enable();
    end
    ArmoryPetFrameCurrentPage:SetFormattedText(MERCHANT_PAGE_NUMBER, ArmoryPetFrame.page, ArmoryPetFrame.maxPages);
end

function ArmoryPetFrame_SetSelectedPetInfo()
    local icon = Armory:GetPetIcon();
    local name = Armory.selectedPet;
    local level = Armory:UnitLevel("pet");
    local family = Armory:UnitCreatureFamily("pet");

	if ( family ) then
		ArmoryPetFrameTypeText:SetText(family);
	else
		ArmoryPetFrameTypeText:SetText("");
	end
	
	if ( level ) then
		ArmoryPetFrameLevelText:SetFormattedText(UNIT_LEVEL_TEMPLATE, level);
	else
		ArmoryPetFrameLevelText:SetText("");
	end
	
	if ( name ) then
	    local petName, realName = Armory:UnitName("pet");
	    if ( realName and petName == name ) then
		    ArmoryPetFrameNameText:SetText(realName);
		else
		    ArmoryPetFrameNameText:SetText(name);
		end
	else
		ArmoryPetFrameNameText:SetText("");
	end
	
	ArmoryPetFrameSelectedPetIcon:SetTexture(icon);
end

function ArmoryPetFrame_NextPage()
    local page = ArmoryPetFrame.page + 1;
    if ( page ~= ArmoryPetFrame.page and page > 0 and page <= ArmoryPetFrame.maxPages ) then
        ArmoryPetFrame.page = page;
        ArmoryPetFrame_Update(false);
    end
end

function ArmoryPetFrame_PrevPage()
    local page = ArmoryPetFrame.page - 1;
    if ( page ~= ArmoryPetFrame.page and page > 0 and page <= ArmoryPetFrame.maxPages ) then
        ArmoryPetFrame.page = page;
        ArmoryPetFrame_Update(false);
    end
end


----------------------------------------------------------
-- Stats Functions
----------------------------------------------------------

local StatCategoryFrames = {};

function ArmoryPetFrame_InitStatCategories()
    local order = PETPAPERDOLL_STATCATEGORY_DEFAULTORDER;
    	
	-- Initialize stat frames
	table.wipe(StatCategoryFrames);
	for index=1, #order do
		local frame = _G["ArmoryPetStatsPaneCategory"..index];
		assert(frame);
		table.insert(StatCategoryFrames, frame);
		frame.Category = order[index];
		frame:Show();
		
	    ArmoryPetFrame_ExpandStatCategory(frame);
	end
	
	-- Hide unused stat frames
	local index = #order + 1;
	while ( _G["ArmoryPetStatsPaneCategory"..index] ) do
		_G["ArmoryPetStatsPaneCategory"..index]:Hide();
		_G["ArmoryPetStatsPaneCategory"..index].Category = nil;
		index = index + 1;
	end
	
	ArmoryPetFrame_UpdateCategoryPositions();
end

function ArmoryPetFrame_UpdateCategoryPositions()
	local prevFrame = nil;
	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index];
		frame:ClearAllPoints();
	end
	
	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index];
		if (prevFrame) then
			frame:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT", 0, -STATCATEGORY_PADDING);
		else
			frame:SetPoint("TOPLEFT", 1, -STATCATEGORY_PADDING);
		end
		prevFrame = frame;
	end
end
	
function ArmoryPetFrame_CollapseStatCategory(categoryFrame)
	if ( not categoryFrame.collapsed ) then
		categoryFrame.collapsed = true;
		local index = 1;
		while (_G[categoryFrame:GetName().."Stat"..index]) do 
			_G[categoryFrame:GetName().."Stat"..index]:Hide();
			index = index + 1;
		end
		categoryFrame.CollapsedIcon:Show();
		categoryFrame.ExpandedIcon:Hide();
		categoryFrame:SetHeight(18);
		categoryFrame.BgMinimized:Show();
		categoryFrame.BgTop:Hide();
		categoryFrame.BgMiddle:Hide();
		categoryFrame.BgBottom:Hide();
	end
end

function ArmoryPetFrame_ExpandStatCategory(categoryFrame)
	if ( categoryFrame.collapsed ) then
		categoryFrame.collapsed = false;
		categoryFrame.CollapsedIcon:Hide();
		categoryFrame.ExpandedIcon:Show();
		ArmoryPetFrame_UpdateStatCategory(categoryFrame);
		categoryFrame.BgMinimized:Hide();
		categoryFrame.BgTop:Show();
		categoryFrame.BgMiddle:Show();
		categoryFrame.BgBottom:Show();
	end
end

function ArmoryPetFrame_UpdateStatCategory(categoryFrame)
	if ( not categoryFrame.Category ) then
		categoryFrame:Hide();
		return;
	end
	
	local categoryInfo = PAPERDOLL_STATCATEGORIES[categoryFrame.Category];
	
	categoryFrame.NameText:SetText(_G["STAT_CATEGORY_"..categoryFrame.Category]);
	
	if ( categoryFrame.collapsed ) then
		return;
	end
	
	local stat;
	local totalHeight = categoryFrame.NameText:GetHeight() + 10;
	local numVisible = 0;
	if ( categoryInfo ) then
		local prevStatFrame = nil;
		for index, stat in next, categoryInfo.stats do
			local statInfo = ARMORY_PAPERDOLL_STATINFO[stat];
			if ( statInfo ) then
				local statFrame = _G[categoryFrame:GetName().."Stat"..numVisible + 1];
				if ( not statFrame ) then
					statFrame = CreateFrame("Frame", categoryFrame:GetName().."Stat"..numVisible + 1, categoryFrame, "StatFrameTemplate");
					if ( prevStatFrame ) then
						statFrame:SetPoint("TOPLEFT", prevStatFrame, "BOTTOMLEFT", 0, 0);
						statFrame:SetPoint("TOPRIGHT", prevStatFrame, "BOTTOMRIGHT", 0, 0);
					end
				end
				statFrame:Show();
				-- Reset tooltip script in case it's been changed
				statFrame:SetScript("OnEnter", PaperDollStatTooltip);
				statFrame.tooltip = nil;
				statFrame.tooltip2 = nil;
				statFrame.UpdateTooltip = nil;
				statFrame:SetScript("OnUpdate", nil);
				statInfo.updateFunc(statFrame, "pet");
				if ( statFrame:IsShown() ) then
					numVisible = numVisible + 1;
					totalHeight = totalHeight + statFrame:GetHeight();
					prevStatFrame = statFrame;
					-- Update Tooltip
					if ( GameTooltip:GetOwner() == statFrame ) then
						statFrame:GetScript("OnEnter")(statFrame);
					end
				end
			end
		end
	end

	local i;
	for index = 1, numVisible do
		if ( index % 2 == 0 ) then
			local statFrame = _G[categoryFrame:GetName().."Stat"..index];
			if ( not statFrame.Bg ) then
				statFrame.Bg = statFrame:CreateTexture(statFrame:GetName().."Bg", "BACKGROUND");
				statFrame.Bg:SetPoint("LEFT", categoryFrame, "LEFT", 1, 0);
				statFrame.Bg:SetPoint("RIGHT", categoryFrame, "RIGHT", 0, 0);
				statFrame.Bg:SetPoint("TOP");
				statFrame.Bg:SetPoint("BOTTOM");
				statFrame.Bg:SetTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b);
				statFrame.Bg:SetAlpha(0.1);
			end
		end
	end
	
	-- Hide all other stats
	local index = numVisible + 1;
	while (_G[categoryFrame:GetName().."Stat"..index]) do 
		_G[categoryFrame:GetName().."Stat"..index]:Hide();
		index = index + 1;
	end
	
	-- Hack to fix category frames that only have 1 item in them
	if ( totalHeight < 44 ) then
		categoryFrame.BgBottom:SetHeight(totalHeight - 2);
	else
		categoryFrame.BgBottom:SetHeight(46);
	end
	
	categoryFrame:SetHeight(totalHeight);
end

function ArmoryPetFrame_UpdateStats()
	local index = 1;
	while( _G["ArmoryPetStatsPaneCategory"..index] ) do
		ArmoryPetFrame_UpdateStatCategory(_G["ArmoryPetStatsPaneCategory"..index]);
		index = index + 1;
	end
    ArmoryBuffFrame_Update("pet");
end


----------------------------------------------------------
-- Specialization Functions
----------------------------------------------------------

function ArmoryPetFrame_UpdateSpec()
    ArmoryPetSpecFrame:Hide();
    local spec = Armory:GetSpecialization(false, true);
    if ( spec ) then
		local _, name, description, icon = Armory:GetSpecializationInfo(spec, false, true);
		if ( name ) then
		    SetPortraitToTexture(ArmoryPetSpecFrame.specIcon, icon);
		    ArmoryPetSpecFrame.specName:SetText(name);
		    local role = Armory:GetSpecializationRole(spec, false, true);
		    ArmoryPetSpecFrame.roleIcon:SetTexCoord(GetTexCoordsForRole(role));
		    ArmoryPetSpecFrame.roleName:SetText(_G[role]);
		    local spells = Armory:GetPetSpecializationSpells(spec);
            if ( spells ) then
                for i = 1, ARMORY_NUM_PET_ABILITIES do
                    local button = _G["ArmoryPetAbility"..i];
                    if ( i <= #spells ) then
		                local _, icon = GetSpellTexture(spells[i]);
		                SetPortraitToTexture(button.icon, icon);
                        button.spellID = spells[i];
		                button.extraTooltip = nil;
		                local level = GetSpellLevelLearned(spells[i]);
		                if ( level and level > Armory:UnitLevel("player") ) then
			                button.extraTooltip =  format(SPELLBOOK_AVAILABLE_AT, level);
                		end
                        button:Show();
                    else
                        button.spellID = nil;
                        button:Hide();    
                    end
                end
                ArmoryPetSpecFrame:Show();
            end
        end
    end
end