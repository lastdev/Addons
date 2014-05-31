--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 632 2014-04-19T09:31:41Z
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

ARMORY_SUMMARY_CURRENCIES_DISPLAYED = 7;
ARMORY_SUMMARY_CURRENCIES_HEIGHT = 16;

function ArmoryOptionsPanel_OnLoad(self)
    self.okay = self.okay or ArmoryOptionsPanel_Okay;
    self.cancel = self.cancel or ArmoryOptionsPanel_Cancel;
    self.default = self.default or ArmoryOptionsPanel_Default;
    self.refresh = self.refresh or ArmoryOptionsPanel_Refresh;

    InterfaceOptions_AddCategory(self);

    for i, control in next, self.controls do
        if ( control.text ) then
            _G[control:GetName() .. "Text"]:SetText(Armory:Proper(control.text));
        end
    end
end

function ArmoryOptionsPanel_Okay(self)
    for _, control in next, self.controls do
        if ( control.onOkay ) then
            control.onOkay(control);
        end
        control.init = nil;
    end
end

function ArmoryOptionsPanel_Cancel(self)
    for _, control in next, self.controls do
        if ( control.value ~= control.currValue ) then
            control:SetValue(control.currValue);
        end
        if ( control.currColor and control.colorSet ) then
            control.colorSet(GetTableColor(control.currColor));
        end
        if ( control.onCancel ) then
            control.onCancel(control);
        end
        control.init = nil;
    end
end

function ArmoryOptionsPanel_Default(self)
    for _, control in next, self.controls do
        if ( control:GetValue() ~= control.defaultValue ) then
            control:SetValue(control.defaultValue);
        end
        if ( control.colorGet and control.colorSet ) then
            control.colorSet(control.colorGet(true));
        end
    end
end

function ArmoryOptionsPanel_Refresh(self)
    for _, control in next, self.controls do
        if ( control.GetValue ) then
            if ( control.type == CONTROLTYPE_SLIDER ) then
                control.value = control.getFunc();
                control:SetValue(control.value);
            else
                control.value = control:GetValue();
            end

            if ( not control.init ) then
                control.currValue = control.value;
            end
            control.disabled = control.disabledFunc();
            if ( control.type == CONTROLTYPE_CHECKBOX ) then

                if ( not control.invert ) then
                    control:SetChecked(control.value);
                else
                    control:SetChecked(not control.value);
                end
    
                ArmoryOptionsPanel_RefreshDependentControls(control);

                if ( control.disabled ) then
                    BlizzardOptionsPanel_CheckButton_Disable(control);
                elseif ( not control.dependency ) then 
                    BlizzardOptionsPanel_CheckButton_Enable(control, 1);
                end

            elseif ( control.type == CONTROLTYPE_SLIDER ) then

                if ( control.disabled ) then
                    BlizzardOptionsPanel_Slider_Disable(control);
                else
                    BlizzardOptionsPanel_Slider_Enable(control);
                end

            end
            
            if ( control.colorGet ) then
                local frame = control:GetParent();
                local swatch = _G[frame:GetName().."ColorSwatch"];
                
                frame.r, frame.g, frame.b = control.colorGet();
                swatch:GetNormalTexture():SetVertexColor(control.colorGet());

                if ( not control.init ) then
                    control.currColor = {};
                    SetTableColor(control.currColor, control.colorGet());
                end
                
                if ( not control.dependency ) then
                    ArmoryOptionsPanel_EnableSwatch(swatch, not control.disabled);
                end
            end

            control.init = true;
        end
    end
end

function ArmoryOptionsPanel_CheckButton_OnClick(checkButton)
    local setting = false;
    if ( checkButton:GetChecked() ) then
        if ( not checkButton.invert ) then
            setting = true;
        end
    elseif ( checkButton.invert ) then
        setting = true;
    end 

    checkButton:SetValue(setting);

    ArmoryOptionsPanel_RefreshDependentControls(checkButton);
end

function ArmoryOptionsPanel_DefaultSearchTypeDropDown_OnEvent(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
        self.defaultValue = ARMORY_CMD_FIND_ITEM;
        self.oldValue = Armory:GetConfigDefaultSearch();
        self.value = self.oldValue or self.defaultValue;
        self.tooltip = ARMORY_CMD_SET_DEFAULTSEARCH_TOOLTIP;

        ArmoryDropDownMenu_SetWidth(self, 90);
        ArmoryDropDownMenu_Initialize(self, ArmoryOptionsPanel_DefaultSearchTypeDropDown_Initialize);
        ArmoryDropDownMenu_SetSelectedValue(self, self.value);

        self.SetValue = 
            function (self, value)
                self.value = value;
                ArmoryDropDownMenu_SetSelectedValue(self, value);
                Armory:SetConfigDefaultSearch(value);
            end
        self.GetValue =
            function (self)
                return ArmoryDropDownMenu_GetSelectedValue(self);
            end
        self.RefreshValue =
            function (self)
                ArmoryDropDownMenu_Initialize(self, ArmoryOptionsPanel_DefaultSearchTypeDropDown_Initialize);
                ArmoryDropDownMenu_SetSelectedValue(self, self.value);
            end

        ArmoryOptionsFindPanelDefaultSearchTypeDropDownLabel:SetText(Armory:Proper(ARMORY_CMD_SET_DEFAULTSEARCH_TEXT));

        self:UnregisterEvent(event);
    end
end

function ArmoryOptionsPanel_DefaultSearchTypeDropDown_OnClick(self)
	ArmoryOptionsFindPanelDefaultSearchTypeDropDown:SetValue(self.value);
end

function ArmoryOptionsPanel_DefaultSearchTypeDropDown_Initialize()
    ArmoryFindType_CreateButtons(ArmoryOptionsPanel_DefaultSearchTypeDropDown_OnClick);
end

function ArmoryOptionsPanel_WarningSoundDropDown_OnEvent(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
        self.defaultValue = "";
        self.oldValue = Armory:GetConfigWarningSound();
        self.value = self.oldValue or self.defaultValue;
        self.tooltip = ARMORY_CMD_SET_WARNINGSOUND_TOOLTIP;

        ArmoryDropDownMenu_SetWidth(self, 90);
        ArmoryDropDownMenu_Initialize(self, ArmoryOptionsPanel_WarningSoundDropDown_Initialize);
        ArmoryDropDownMenu_SetSelectedValue(self, self.value);

        self.SetValue = 
            function (self, value)
                self.value = value;
                ArmoryDropDownMenu_SetSelectedValue(self, value);
                Armory:SetConfigWarningSound(value);
                if ( value ~= "" ) then
                    PlaySound(value);
                end
            end
        self.GetValue =
            function (self)
                return ArmoryDropDownMenu_GetSelectedValue(self);
            end
        self.RefreshValue =
            function (self)
                ArmoryDropDownMenu_Initialize(self, ArmoryOptionsPanel_WarningSoundDropDown_Initialize);
                ArmoryDropDownMenu_SetSelectedValue(self, self.value);
            end

        ArmoryOptionsMiscPanelWarningSoundDropDownLabel:SetText(Armory:Proper(ARMORY_CMD_SET_WARNINGSOUND_TEXT));

        self:UnregisterEvent(event);
    end
end

function ArmoryOptionsPanel_WarningSoundDropDown_OnClick(self)
	ArmoryOptionsMiscPanelWarningSoundDropDown:SetValue(self.value);
end

function ArmoryOptionsPanel_WarningSoundDropDown_Initialize()
    local info = ArmoryDropDownMenu_CreateInfo();

    info.func = ArmoryOptionsPanel_WarningSoundDropDown_OnClick;
    info.owner = ARMORY_DROPDOWNMENU_OPEN_MENU;

    info.text = NONE;
    info.value = "";
    info.checked = nil;
    ArmoryDropDownMenu_AddButton(info);
   
    for k, v in ipairs(Armory.sounds) do
        info.text = SOUND_LABEL.." "..k;
        info.value = v;
        info.checked = nil;
        ArmoryDropDownMenu_AddButton(info);
    end
end

function ArmoryOptionsPanel_RegisterControl(control, parentFrame)
    local entry;

    if ( control.label ) then
        entry = Armory.options[control.label];

        if ( control.type == CONTROLTYPE_CHECKBOX ) then    

            control.text = _G[control.label.."_TEXT"];
            control.tooltipText = _G[control.label.."_TOOLTIP"];
            control.setFunc = entry.set;
            control.GetValue = entry.get;
            control.SetValue = function(self, value) self.value = value; if ( self.setFunc ) then self.setFunc(self.value) end end;

        elseif ( control.type == CONTROLTYPE_SLIDER ) then

            control.text = _G[control.label.."_TEXT"];
            control.tooltipText = _G[control.label.."_TOOLTIP"];
            control.setFunc = entry.set;
            control.getFunc = entry.get;
            control.minValue = entry.minValue;
            control.maxValue = entry.maxValue;
            control:SetMinMaxValues(entry.minValue, entry.maxValue);
            control:SetValueStep(entry.valueStep);
            control.SetDisplayValue = control.SetValue;
            control.SetValue = function(self, value) self:SetDisplayValue(value); self.value = value; self.setFunc(value); end;

        end

        control.defaultValue = control.defaultValue or entry.default;
        control.disabledFunc = entry.disabled or function() end;
    else
        control.disabledFunc = function() end;
    end
    
    local parent = control:GetParent();
    local swatch = _G[parent:GetName().."ColorSwatch"];
    if ( swatch ) then
        swatch.control = control;
    end

    parentFrame.controls = parentFrame.controls or {};
    table.insert(parentFrame.controls, control);    
end

function ArmoryOptionsPanel_SetupDependentControl(dependency, control, invert)
    if ( not dependency ) then
       return;
    end

    assert(control);

    control.dependentInvert = invert;
    control.dependency = dependency;

    dependency.dependentControls = dependency.dependentControls or {};
    table.insert(dependency.dependentControls, control);

    if ( control.type == CONTROLTYPE_SLIDER ) then
        control.Disable = BlizzardOptionsPanel_Slider_Disable;
        control.Enable = BlizzardOptionsPanel_Slider_Enable;
    elseif ( control.type == CONTROLTYPE_DROPDOWN ) then
        control.Disable = function (self) ArmoryDropDownMenu_DisableDropDown(self) end;
        control.Enable = function (self) ArmoryDropDownMenu_EnableDropDown(self) end;
    else
        control.oldDisable = control.Disable;
        control.oldEnable = control.Enable;
        control.Disable = function (self) self.oldDisable(self); _G[self:GetName().."Text"]:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b) end;
        control.Enable = function (self) self.oldEnable(self); _G[self:GetName().."Text"]:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b) end;
    end
end

function ArmoryOptionsPanel_RefreshDependentControls(checkButton)
    if ( checkButton.dependentControls ) then
        for _, control in next, checkButton.dependentControls do
            ArmoryOptionsPanel_EnableDependentControl(control, checkButton:GetChecked());
            if ( control.dependentControls ) then
                if ( not control:IsEnabled() ) then
                    for _, dependentControl in next, control.dependentControls do
                        dependentControl:Disable();
                    end
                else
                    ArmoryOptionsPanel_RefreshDependentControls(control);
                end
            end
        end
    end
end

function ArmoryOptionsPanel_EnableDependentControl(control, enable)
    if ( control.dependency.disabled ) then
        control:Disable();
    elseif ( enable ) then
        if ( control.dependentInvert ) then
            control:Disable();
        else
            control:Enable();
        end
    else
        if ( control.dependentInvert ) then
            control:Enable();
        else
            control:Disable();
        end
    end
    
    local parent = control:GetParent();
    local swatch = _G[parent:GetName().."ColorSwatch"];
    if ( swatch ) then
        ArmoryOptionsPanel_EnableSwatch(swatch, control:IsEnabled() == 1);
    end
end

function ArmoryOptionsPanel_EnableSwatch(swatch, enable)
    local parent = swatch:GetParent();
    if ( enable ) then
        swatch:Enable();
        _G[parent:GetName().."Text"]:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
    else
        swatch:Disable();
        _G[parent:GetName().."Text"]:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
    end
end

function ArmoryOptionsPanel_OpenColorPicker(self)
    ArmoryOptionsPanel.colorPicker = self;
    ArmoryOptionsPanel.colorGet = self.control.colorGet;
    ArmoryOptionsPanel.colorSet = self.control.colorSet;

    local frame = self:GetParent();
    local info = ArmoryDropDownMenu_CreateInfo();

    info.r, info.g, info.b = self.control.colorGet();
    info.swatchFunc = function() 
        ArmoryOptionsPanel.colorSet(ColorPickerFrame:GetColorRGB());
        ArmoryOptionsPanel.colorPicker:GetNormalTexture():SetVertexColor(ColorPickerFrame:GetColorRGB());
    end;
    info.cancelFunc = function()
        ArmoryOptionsPanel.colorSet(ColorPicker_GetPreviousValues());
        ArmoryOptionsPanel.colorPicker:GetNormalTexture():SetVertexColor(ColorPicker_GetPreviousValues());
    end;

    OpenColorPicker(info);
end

function ArmoryOptionsPanel_EnableCharacter(control)
    if ( control.value ~= control.currValue ) then
        if ( not control.value ) then
            Armory:DeleteProfile(Armory.playerRealm, Armory.player, true);
        end
        ReloadUI();
    end
end

function ArmoryOptionsPanel_ApplyEncoding(control)
    if ( control.value ~= control.currValue ) then
        Armory:ConvertDb();
    end
end

function ArmoryOptionsPanel_ApplyOverlay(control)
    if ( control.value ~= control.currValue and not CharacterFrame.Expanded ) then
        if ( control.value ) then
            ArmoryPaperDollOverlayFrame:Show();
        else
            ArmoryPaperDollOverlayFrame:Hide();
        end
        ArmoryPaperDollOverlayFrameCheckButton:SetChecked(control.value);
    end
end

function ArmoryOptionsPanel_ApplyMaziel(control)
    if ( control.value ~= control.currValue and ArmoryPaperDollOverlayFrame:IsVisible() ) then
        ArmoryPaperDollOverlayFrame:Hide();
        ArmoryPaperDollOverlayFrame:Show();
    end
end

function ArmoryOptionsPanel_ApplyCheckButton(control)
    if ( control.value ~= control.currValue ) then
        ArmoryPaperDollCheckButton_Enable(not control.value);
    end
end

function ArmoryOptionsPanel_SetChannel(value)
    local _, name = Armory:GetConfigChannelName();
    if ( name ~= value ) then
        ArmoryAddonMessageFrame_UpdateChannel(true);
    end
    Armory:SetConfigChannelName(value);
    ArmoryAddonMessageFrame_UpdateChannel();
end

local currencies = {};
local currencyInfo = {};
local function GetCurrencies()
	local getVirtualCurrencies = function()
		local name, isHeader;
		for i = 1, Armory:GetVirtualNumCurrencies() do
			name, isHeader = Armory:GetVirtualCurrencyInfo(i);
			if ( not isHeader and not currencyInfo[name] ) then
				table.insert(currencies, name);
				currencyInfo[name] = true;
			end
		end
	end;
	
	table.wipe(currencyInfo);
	
	if ( Armory:CurrencyEnabled() ) then
		local currentProfile = Armory:CurrentProfile();
		currencies = Armory:GetConfigSummaryCurrencies();
		for i = 1, #currencies do
			currencyInfo[currencies[i]] = true;
		end
		for _, profile in ipairs(Armory:Profiles()) do
			Armory:SelectProfile(profile);
			getVirtualCurrencies();
		end
		Armory:SelectProfile(currentProfile);
	else
		table.wipe(currencies);
		getVirtualCurrencies();
	end

	table.sort(currencies);
	
	return currencies;
end

function ArmoryOptionsSummaryPanel_OnShow(self)
    if ( not self.currencies ) then
        self.currencies = {};
        for name in pairs(Armory:GetConfigSummaryEnabledCurrencies()) do
            self.currencies[name] = true;
        end
    end
    ArmoryOptionsSummaryPanel_CurrencyContainer_Update();
end

function ArmoryOptionsSummaryPanel_GetCurrency(self)
    return ArmoryOptionsSummaryPanel.currencies[self.currency];
end

function ArmoryOptionsSummaryPanel_SetCurrency(self, enabled)
    ArmoryOptionsSummaryPanel.currencies[self.currency] = enabled or false;
end

function ArmoryOptionsSummaryPanel_Okay(self)
    for name in pairs(self.currencies) do
        Armory:SetConfigSummaryCurrencyEnabled(name, self.currencies[name]);
    end
end

function ArmoryOptionsSummaryPanel_Cancel(self)
    self.currencies = nil;
end

function ArmoryOptionsSummaryPanel_CurrencyContainer_Update()
	local scrollFrame = ArmoryOptionsSummaryPanelCurrencyContainerScrollFrame;
	local containerFrame = scrollFrame:GetParent();

	local currencies = GetCurrencies();
	local numCurrencies = #currencies;
    local showScrollBar = (numCurrencies > ARMORY_SUMMARY_CURRENCIES_DISPLAYED);
    local offset = FauxScrollFrame_GetOffset(scrollFrame);
    local button, index;
    local width = scrollFrame:GetWidth() - 16;
 
	for i = 1, ARMORY_SUMMARY_CURRENCIES_DISPLAYED do
		index = offset + i;
		
        button = _G[containerFrame:GetName().."Button"..i];
		
        if ( index > numCurrencies ) then
            button:Hide();
		else
			button.currency = currencies[index];
			button.Text:SetText(button.currency);

            -- If need scrollbar resize columns
            if ( showScrollBar ) then
                button.Text:SetWidth(width - 16);
            else
                button.Text:SetWidth(width);
            end

			button:Show();
		end
	end
	
	ArmoryOptionsPanel_Refresh(containerFrame:GetParent());

    -- ScrollFrame update
    FauxScrollFrame_Update(scrollFrame, numCurrencies, ARMORY_SUMMARY_CURRENCIES_DISPLAYED, ARMORY_SUMMARY_CURRENCIES_HEIGHT);
end

----------------------------------------------------------
-- Enable / disable modules
----------------------------------------------------------

local function SetInventory(on)
    if ( on ) then
        for i = 1, #ArmoryInventoryContainers do
            Armory:SetContainer(ArmoryInventoryContainers[i]);
        end
    else
        Armory:ClearInventory();
    end
end

local function SetQuestLog(on)
    if ( on ) then
        Armory:UpdateQuests();
    else
        Armory:ClearQuests();
        Armory:ClearQuestHistory();
    end
end

local function SetSpellBook(on)
    if ( on ) then
        Armory:SetSpells();
    else
        Armory:ClearSpells();
    end
end

local function SetSocial(on)
    if ( on ) then
        Armory:UpdateFriends();
        Armory:UpdateEvents();
    else
        Armory:ClearFriends();
        Armory:ClearEvents();
    end
end
        
local function SetPets(on)    
   if ( on ) then
        if ( HasPetUI() ) then
            ArmoryPetFrame_Update(1);
        end
    else
        Armory:ClearPets();
    end
end
            
local function SetTalents(on)
    if ( on ) then
        Armory:SetTalents();
        Armory:UpdateGlyphs();
    else
        Armory:ClearTalents();
        Armory:ClearGlyphs();
    end
end

local function SetPVP(on)
    --if ( on ) then
        --Armory:UpdateArenaTeams();
    --else
        --Armory:ClearArenaTeams();
    --end
end

local function SetReputation(on)            
    if ( on ) then
        Armory:UpdateFactions();
    else
        Armory:ClearFactions();
    end
end

local function SetRaid(on)
    if ( on ) then
        Armory:UpdateInstances();
        Armory:UpdateWorldBosses();
    else
        Armory:ClearInstances();
        Armory:ClearRaidFinder();
        Armory:ClearWorldBosses();
    end
end

local function SetCurrency(on)
    if ( on ) then
        Armory:UpdateCurrency();
    else
        Armory:ClearCurrency();
    end
end

local function SetBuffs(on)         
    if ( on ) then
        Armory:SetBuffs("player");
        if ( HasPetUI() ) then
            Armory:SetBuffs("pet");
        end
    else
        Armory:ClearBuffs();
    end
end

local function SetTradeSkills(on)
    if ( on ) then
        Armory:UpdateProfessions();
    else
        Armory:ClearTradeSkills();
    end
end

local function SetAchievements(on)
    if ( on ) then
        Armory:UpdateAchievements();
    else
        Armory:ClearAchievements();
        Armory:ClearStatistics();
    end
end

local function SetStatistics(on)
    if ( on ) then
        Armory:UpdateStatistics();
    else
        Armory:ClearStatistics();
    end
end
  
function ArmoryOptionsPanel_CheckModule(control, module)
    if ( control.value == control.currValue ) then
        return;
    
    elseif ( module == "Inventory" ) then
        SetInventory(control.value);

    elseif ( module == "QuestLog" ) then
        SetQuestLog(control.value);

    elseif ( module == "SpellBook" ) then
        SetSpellBook(control.value);

    elseif ( module == "TradeSkills" ) then
        SetTradeSkills(control.value);

    elseif ( module == "Social" ) then
        SetSocial(control.value);

    elseif ( module == "Pets" ) then
        SetPets(control.value);
            
    elseif ( module == "Talents" ) then
        SetTalents(control.value);

    elseif ( module == "PVP" ) then
        SetPVP(control.value);
            
    elseif ( module == "Reputation" ) then
        SetReputation(control.value);

    elseif ( module == "Raid" ) then
        SetRaid(control.value);
            
    elseif ( module == "Currency" ) then
        SetCurrency(control.value);
            
    elseif ( module == "Buffs" ) then
        SetBuffs(control.value);
    
    elseif ( module == "Achievements" ) then
        SetAchievements(control.value);
        
    elseif ( module == "Statistics" ) then
        SetStatistics(control.value);

    end
    
    if ( ArmoryFrame:IsVisible() ) then
        ArmoryCloseChildWindows();
        Armory:Toggle();
    end
    Armory:HideSummary(true); 
end
