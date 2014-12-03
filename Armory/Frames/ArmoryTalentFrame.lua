--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 646 2014-10-13T22:12:03Z
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

ARMORY_MAX_TALENT_SPECTABS = 2;

function ArmoryTalentFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("PREVIEW_TALENT_POINTS_CHANGED");
	self:RegisterEvent("PREVIEW_TALENT_PRIMARY_TREE_CHANGED");
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("PET_SPECIALIZATION_CHANGED");
    self:RegisterEvent("GLYPH_ADDED");
    self:RegisterEvent("GLYPH_REMOVED");
    self:RegisterEvent("GLYPH_UPDATED");
    self:RegisterEvent("USE_GLYPH");
    self:RegisterEvent("PLAYER_LEVEL_UP");
    self.talentGroup = 1;
end

function ArmoryTalentFrame_OnEvent(self, event, unit)
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        self.talentGroup = Armory:GetActiveSpecGroup();
        Armory:Execute(ArmoryTalentFrame_UpdateSpecs);
        if ( Armory.forceScan or not Armory:TalentsExists() ) then
			Armory:Execute(ArmoryTalentFrame_UpdateTalents);
			Armory:Execute(ArmoryTalentFrame_UpdateGlyphs);
        end
    elseif ( event == "PREVIEW_TALENT_POINTS_CHANGED" or event == "PREVIEW_TALENT_PRIMARY_TREE_CHANGED" or event == "PLAYER_TALENT_UPDATE" ) then
		Armory:Execute(ArmoryTalentFrame_UpdateTalents);
    elseif ( event == "PET_SPECIALIZATION_CHANGED" ) then
        Armory:Execute(ArmoryTalentFrame_UpdateSpecs);
    else
		Armory:Execute(ArmoryTalentFrame_UpdateGlyphs);
    end
end

function ArmoryTalentFrame_UpdateSpecs()
    local _, isHunterPet = HasPetUI();
    Armory:SetSpecializations("player");
    if ( isHunterPet ) then
        Armory:SetSpecializations("pet");
    end
end

function ArmoryTalentFrame_UpdateTalents()
	Armory:SetTalents();
	ArmoryTalentFrame_UpdateFrame();
end

function ArmoryTalentFrame_UpdateGlyphs()
	Armory:UpdateGlyphs();
	ArmoryGlyphFrameGlyph_UpdateGlyphs(ArmoryTalentFrame.Glyphs);
end

function ArmoryTalentFrame_OnShow(self)
	--ButtonFrameTemplate_HideButtonBar(InspectFrame);
	Armory:SetTalents();
	Armory:UpdateGlyphs();
	
	local numTalentGroups = Armory:GetNumSpecGroups();
    local hasMultipleTalentGroups = numTalentGroups > 1;
    local tab, activeTab;
    self.talentGroup = Armory:GetActiveSpecGroup();
    for i = 1, ARMORY_MAX_TALENT_SPECTABS do
        tab = _G["ArmoryPlayerSpecTab" .. i];
        if ( i == self.talentGroup ) then
            activeTab = tab;
        end
        if ( hasMultipleTalentGroups and i <= numTalentGroups ) then
			local primaryTree = Armory:GetSpecialization(false, false, i) or 1;
			local _, _, _, iconTexture = Armory:GetSpecializationInfo(primaryTree, nil, nil, nil, Armory:UnitSex("player"));
            tab:GetNormalTexture():SetTexture(iconTexture);
            tab:Show();
        else
            tab:Hide();
        end
    end

    ArmoryPlayerSpecTab_OnClick(activeTab);
end

function ArmoryGlyphFrameGlyph_OnClear(self)
	ArmoryGlyphFrameGlyph_UpdateGlyphs(self.Glyphs, true);
	ArmoryTalentFrameSpec_OnClear(self.Spec);
	TalentFrame_Clear(self.Talents);
end

function ArmoryTalentFrame_Update()
    ArmoryTalentFrameSpec_OnShow(ArmoryTalentFrame.Spec);
    ArmoryTalentFrame_UpdateFrame();
    ArmoryGlyphFrameGlyph_UpdateGlyphs(ArmoryTalentFrame.Glyphs);
end

function ArmoryTalentFrame_UpdateFrame()
    local TalentFrame = ArmoryTalentFrame.Talents;

	-- have to disable stuff if not active talent group
	local disable = ( ArmoryTalentFrame.talentGroup ~= Armory:GetActiveSpecGroup() );
	if ( ArmoryTalentFrame.bg ~= nil ) then
		ArmoryTalentFrame.bg:SetDesaturated(disable);
	end

	local numTalentSelections = 0;
	for tier = 1, MAX_TALENT_TIERS do
		local talentRow = TalentFrame["tier"..tier];
		for column = 1, NUM_TALENT_COLUMNS do
			local talentID, name, iconTexture, selected, available = Armory:GetTalentInfo(tier, column, ArmoryTalentFrame.talentGroup);
			local button = talentRow["talent"..column];
			button.tier = tier;
			button.column = column;

			if ( button and name ) then
				button:SetID(talentID);

				SetItemButtonTexture(button, iconTexture);
				if ( button.name ~= nil ) then
					button.name:SetText(name);
				end

				if ( button.knownSelection ~= nil ) then
					if( selected ) then
						button.knownSelection:Show();
						button.knownSelection:SetDesaturated(disable);
					else
						button.knownSelection:Hide();
					end
				end

				if ( selected ) then
				    SetDesaturation(button.icon, disable);
				    button.border:Show();
				else
				    SetDesaturation(button.icon, true);
				    button.border:Hide();
			    end

	            button:Show();
	        elseif ( button ) then
	            button:Hide();
	        end
	    end
	end

    local numUnspentTalents = Armory:GetNumUnspentTalents();
    if ( not disable and numUnspentTalents > 0 ) then
        ArmoryTalentFrame.unspentText:SetFormattedText(PLAYER_UNSPENT_TALENT_POINTS, numUnspentTalents);
    else
        ArmoryTalentFrame.unspentText:SetText("");
    end
end

----------------------------------------------------------
-- SpecTab Button Functions
----------------------------------------------------------

function ArmoryPlayerSpecTab_OnClick(self)
    for i = 1, ARMORY_MAX_TALENT_SPECTABS do
        _G["ArmoryPlayerSpecTab" .. i]:SetChecked(false);
    end
    self:SetChecked(true);

    ArmoryTalentFrame.talentGroup = self:GetID();
    
    ArmoryTalentFrame_Update();
end

function ArmoryPlayerSpecTab_OnEnter(self)
    if ( self.tooltip ) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
      	if ( Armory:GetNumSpecGroups() <= 1) then
			-- set the tooltip to be the unit's name
            GameTooltip:AddLine(Armory:UnitName("player"), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		else
			-- set the tooltip to be the spec name
            GameTooltip:AddLine(self.tooltip);
            if ( self:GetID() == Armory:GetActiveSpecGroup(false) ) then
                -- add text to indicate that this spec is active
                GameTooltip:AddLine(TALENT_ACTIVE_SPEC_STATUS, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
            end
		end
        GameTooltip:Show();
    end
end


----------------------------------------------------------
-- Glyph Button Functions
----------------------------------------------------------

ARMORY_GLYPH_TYPE_INFO = {};
ARMORY_GLYPH_TYPE_INFO[GLYPH_TYPE_MAJOR] =  {
	ring = { size = 60, left = 0.00390625, right = 0.33203125, top = 0.27539063, bottom = 0.43945313 };
--	highlight = { size = 98, left = 0.54296875, right = 0.92578125, top = 0.00195313, bottom = 0.19335938 };
}
ARMORY_GLYPH_TYPE_INFO[GLYPH_TYPE_MINOR] =  {
	ring = { size = 46, left = 0.33984375, right = 0.60546875, top = 0.27539063, bottom = 0.40820313 };
--	highlight = { size = 82, left = 0.61328125, right = 0.93359375, top = 0.27539063, bottom = 0.43554688 };
}

function ArmoryGlyphFrameGlyph_OnLoad (self)
	self.glyphType = nil;
end

function ArmoryGlyphFrameGlyph_UpdateGlyphs(self, clearSlots)
	ArmoryGlyphFrameGlyph_UpdateSlot(self.Glyph1, clearSlots);
	ArmoryGlyphFrameGlyph_UpdateSlot(self.Glyph2, clearSlots);
	ArmoryGlyphFrameGlyph_UpdateSlot(self.Glyph3, clearSlots);
	ArmoryGlyphFrameGlyph_UpdateSlot(self.Glyph4, clearSlots);
	ArmoryGlyphFrameGlyph_UpdateSlot(self.Glyph5, clearSlots);
	ArmoryGlyphFrameGlyph_UpdateSlot(self.Glyph6, clearSlots);	
end

function ArmoryGlyphFrameGlyph_UpdateSlot(self, clear)
	local id = self:GetID();
	local enabled, glyphType, glyphTooltipIndex, glyphSpell, iconFilename = Armory:GetGlyphSocketInfo(id, ArmoryTalentFrame.talentGroup);
	if ( not enabled ) then
	    self:Hide();
	    return;
	end
	
	ArmoryGlyphFrameGlyph_SetGlyphType(self, glyphType);
	
    if ( not glyphSpell or (clear == true) ) then
		self.glyph:SetTexture("");
		self:Show();
	else
		self.glyph:Show();
		if ( iconFilename ) then
			SetPortraitToTexture(self.glyph, iconFilename);
		else
			self.glyph:SetTexture("Interface\\Spellbook\\UI-Glyph-Rune1");
		end
		SetDesaturation(self.glyph, ArmoryTalentFrame.talentGroup ~= Armory:GetActiveSpecGroup());
		self:Show();
	end
end

function ArmoryGlyphFrameGlyph_SetGlyphType(glyph, glyphType)
	local info = ARMORY_GLYPH_TYPE_INFO[glyphType];
	if ( info ) then
		glyph.glyphType = glyphType;
		
		glyph.ring:SetWidth(info.ring.size);
		glyph.ring:SetHeight(info.ring.size);
		glyph.ring:SetTexCoord(info.ring.left, info.ring.right, info.ring.top, info.ring.bottom);

		glyph.glyph:SetWidth(info.ring.size - 4);
		glyph.glyph:SetHeight(info.ring.size - 4);
		glyph.glyph:SetAlpha(0.75);
	end
end

function ArmoryGlyphFrameGlyph_OnClick(self)
    if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() ) then
        local link = Armory:GetGlyphLink(self:GetID(), ArmoryTalentFrame.talentGroup);
        if ( link ) then
	        ChatEdit_InsertLink(link);
        end
    end
end

function ArmoryGlyphFrameGlyph_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    Armory:SetGlyph(self:GetID(), ArmoryTalentFrame.talentGroup);
    GameTooltip:Show();
end

function ArmoryGlyphFrameGlyph_OnLeave(self)
    GameTooltip:Hide();
end


----------------------------------------------------------
-- Specialization Button Functions
----------------------------------------------------------

function ArmoryTalentFrameSpec_OnShow(self)
	local spec = Armory:GetSpecialization(false, false, ArmoryTalentFrame.talentGroup) or 1;

	if ( spec ~= nil and spec > 0 ) then
		local id, name, description, icon, background, role = Armory:GetSpecializationInfo(spec, nil, nil, nil, Armory:UnitSex("player"));
		if ( role ~= nil ) then
			self.specIcon:Show();
			SetPortraitToTexture(self.specIcon, icon);
			self.specName:SetText(name);
			self.roleIcon:Show();
			self.roleName:SetText(_G[role]);
			self.roleIcon:SetTexCoord(GetTexCoordsForRole(role));
			self.tooltip = description;
		end
	else
		ArmoryTalentFrameSpec_OnClear(self);
	end
end

function ArmoryTalentFrameSpec_OnClear(self)
	self.specName:SetText("");
	self.specIcon:Hide();
	self.roleName:SetText("");
	self.roleIcon:Hide();
end

function ArmoryTalentFrameSpec_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP");
	GameTooltip:AddLine(self.tooltip, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:SetMinimumWidth(300, true);
	GameTooltip:Show();
end

function ArmoryTalentFrameSpec_OnLeave(self)
	GameTooltip:SetMinimumWidth(0, 0);
	GameTooltip:Hide();
end


----------------------------------------------------------
-- Talent Button Functions
----------------------------------------------------------

function ArmoryTalentFrameTalents_OnShow(self)
	ArmoryTalentFrame_UpdateFrame();
end

function ArmoryTalentFrameTalent_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");	
	Armory:SetTalent(self:GetID());
end

function ArmoryTalentFrameTalent_OnClick(self)
	if ( IsModifiedClick("CHATLINK") ) then
		local link = GetTalentLink(self:GetID());
		if ( link ) then
			ChatEdit_InsertLink(link);
		end
	end
end
