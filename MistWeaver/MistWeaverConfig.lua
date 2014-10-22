
-- saved data
MistWeaverData = {};

MistWeaverData.ACTIVE = true;
MistWeaverData.UNITWIDTH = 100;
MistWeaverData.UNITHEIGHT = 50;
MistWeaverData.OOC_ALPHA = 0.5;
MistWeaverData.UNITALPHA_DC = 0.5;
MistWeaverData.SPELL_ALPHA = 0.5;
MistWeaverData.RENEWINGMISTBAR_HEIGHT = 16;
MistWeaverData.COLORTYPE = 1;
MistWeaverData.SORTTYPE = 1;
MistWeaverData.ORIENTATION = 1;
MistWeaverData.UNITFRAME_GROUPSIZE = 5;

MistWeaverData.OUT_OF_RANGE = "You are out of range!";

MistWeaverData.HIGHLIGHT_COLOR = {r=0, g=1, b=0};
MistWeaverData.RENEWING_MIST_COLOR = {r=0, g=0.7, b=0.7};
MistWeaverData.SOOTHING_MIST_COLOR = {r=0.7, g=1, b=0.4};
MistWeaverData.ENVELOPING_MIST_COLOR = {r=1, g=0.7, b=0.4};

MistWeaverData.SHOW_IN_ALL_STANCES = false;
MistWeaverData.SHOW_SOLO = false;

MistWeaverData.SHOW_DEBUFFS = true;
MistWeaverData.SHOW_RAID_ICON = true;
MistWeaverData.SHOW_PVP_ICON = true;

MistWeaverData.RAID_EXTENSION_WIDTH = 27;
MistWeaverData.RAID_SHOW_DEBUFFS = true;

MistWeaverData.SHOW_TARGET_FRAME = false;
MistWeaverData.SHOW_FOCUS_FRAME = false;

MistWeaverData.SHOW_TARGET_FRAME_HEADER = true;
MistWeaverData.SHOW_FOCUS_FRAME_HEADER = true;

-- debuffs
MistWeaverIgnoreDebuffs = {};

-- saved profiles
MistWeaverProfiles = {};

local initialized = false;

local selectedIndex = nil;

local COLOR_TYPE = {
    MW_COLOR_TYPE_HEALTH,
    MW_COLOR_TYPE_CLASS,
}
local SORT_TYPE = {
    MW_SORT_TYPE_ID,
    MW_SORT_TYPE_GROUP,
    MW_SORT_TYPE_NAME,
    MW_SORT_TYPE_ROLE,
}
local ORIENTATION = {
    MW_UNIT_SELECT_VERTICAL,
    MW_UNIT_SELECT_HORIZONTAL,
}

-- Controls des Config UI
local controls = {};

function MwConfig_OnLoad(self)
    MwConfig_CreateUI(self);

    self:RegisterEvent("ADDON_LOADED");
    self:RegisterEvent("CVAR_UPDATE");
end

function MwConfig_OnEvent(self, event, ...)
    if (event == "CVAR_UPDATE") then
        local name, value = ...;
    --DEFAULT_CHAT_FRAME:AddMessage("CVAR_UPDATE   "..name.." = "..value, 1.0, 1.0, 1.0, 1, 10);
    end
    if (event == "ADDON_LOADED") then
        local addonName = ...;
        if (addonName == "MistWeaver") then
            MistWeaver_StartDelay(2, MwConfig_LoadDefaults);
        end
    end
end

function MwConfig_LoadDefaults()
    -- init tables
    MistWeaverData = MistWeaverData or {};
    MistWeaverProfiles = MistWeaverProfiles or {};
    MistWeaverIgnoreDebuffs = MistWeaverIgnoreDebuffs or {};

    -- load saved data
    MistWeaverData.ACTIVE = MwConfig_GetDefault(MistWeaverData.ACTIVE, true);
    MistWeaverData.UNITWIDTH = MwConfig_GetDefault(MistWeaverData.UNITWIDTH, 100);
    MistWeaverData.UNITHEIGHT = MwConfig_GetDefault(MistWeaverData.UNITHEIGHT, 50);
    MistWeaverData.OOC_ALPHA = MwConfig_GetDefault(MistWeaverData.OOC_ALPHA, 0.5);
    MistWeaverData.UNITALPHA_DC = MwConfig_GetDefault(MistWeaverData.UNITALPHA_DC, 0.5);
    MistWeaverData.SPELL_ALPHA = MwConfig_GetDefault(MistWeaverData.SPELL_ALPHA, 0.5);
    MistWeaverData.RENEWINGMISTBAR_HEIGHT = MwConfig_GetDefault(MistWeaverData.RENEWINGMISTBAR_HEIGHT, 16);
    MistWeaverData.COLORTYPE = MwConfig_GetDefault(MistWeaverData.COLORTYPE, 1);
    MistWeaverData.SORTTYPE = MwConfig_GetDefault(MistWeaverData.SORTTYPE, 1);
    MistWeaverData.ORIENTATION = MwConfig_GetDefault(MistWeaverData.ORIENTATION, 1);
    MistWeaverData.UNITFRAME_GROUPSIZE = MwConfig_GetDefault(MistWeaverData.UNITFRAME_GROUPSIZE, 5);
    MistWeaverData.OUT_OF_RANGE = MwConfig_GetDefault(MistWeaverData.OUT_OF_RANGE, "You are out of range!");
    MistWeaverData.HIGHLIGHT_COLOR = MwConfig_GetDefault(MistWeaverData.HIGHLIGHT_COLOR, {r=0, g=1, b=0});
    MistWeaverData.RENEWING_MIST_COLOR = MwConfig_GetDefault(MistWeaverData.RENEWING_MIST_COLOR, {r=0, g=0.7, b=0.7});
    MistWeaverData.SOOTHING_MIST_COLOR = MwConfig_GetDefault(MistWeaverData.SOOTHING_MIST_COLOR, {r=0.7, g=1, b=0.4});
    MistWeaverData.ENVELOPING_MIST_COLOR = MwConfig_GetDefault(MistWeaverData.ENVELOPING_MIST_COLOR, {r=1, g=0.7, b=0.4});
    MistWeaverData.SHOW_IN_ALL_STANCES = MwConfig_GetDefault(MistWeaverData.SHOW_IN_ALL_STANCES, false);
    MistWeaverData.SHOW_SOLO = MwConfig_GetDefault(MistWeaverData.SHOW_SOLO, false);
    MistWeaverData.SHOW_DEBUFFS = MwConfig_GetDefault(MistWeaverData.SHOW_DEBUFFS, true);
    MistWeaverData.SHOW_RAID_ICON = MwConfig_GetDefault(MistWeaverData.SHOW_RAID_ICON, true);
    MistWeaverData.SHOW_PVP_ICON = MwConfig_GetDefault(MistWeaverData.SHOW_PVP_ICON, true);

    MistWeaverData.RAID_EXTENSION_WIDTH = MwConfig_GetDefault(MistWeaverData.RAID_EXTENSION_WIDTH, 27);
    MistWeaverData.RAID_SHOW_DEBUFFS = MwConfig_GetDefault(MistWeaverData.RAID_SHOW_DEBUFFS, true);

    MistWeaverData.SHOW_TARGET_FRAME = MwConfig_GetDefault(MistWeaverData.SHOW_TARGET_FRAME, false);
    MistWeaverData.SHOW_FOCUS_FRAME = MwConfig_GetDefault(MistWeaverData.SHOW_FOCUS_FRAME, false);

    MistWeaverData.SHOW_TARGET_FRAME_HEADER = MwConfig_GetDefault(MistWeaverData.SHOW_TARGET_FRAME_HEADER, true);
    MistWeaverData.SHOW_FOCUS_FRAME_HEADER = MwConfig_GetDefault(MistWeaverData.SHOW_FOCUS_FRAME_HEADER, true);

    -- old versions
    if (MistWeaverData.IGNORE_DEBUFFS) then
        MistWeaverData.IGNORE_DEBUFFS = nil;
    end

    initialized = true;
end

function MwConfig_GetDefault(value, default)
    if (value ~= nil) then
        return value;
    end

    return default;
end

function MwConfig_RefreshUI()
    MwConfig_ToggleActiveCheckButton:SetChecked(MistWeaverData.ACTIVE);

    MwConfig_UnitFrameWidthSlider:SetValue(MistWeaverData.UNITWIDTH);
    _G[MwConfig_UnitFrameWidthSlider:GetName().."Value"]:SetText(format("%.0f", MistWeaverData.UNITWIDTH));

    MwConfig_UnitFrameHeightSlider:SetValue(MistWeaverData.UNITHEIGHT);
    _G[MwConfig_UnitFrameHeightSlider:GetName().."Value"]:SetText(format("%.0f", MistWeaverData.UNITHEIGHT));

    MwConfig_OOCAlphaSlider:SetValue(MistWeaverData.OOC_ALPHA);
    _G[MwConfig_OOCAlphaSlider:GetName().."Value"]:SetText(format("%.2f", MistWeaverData.OOC_ALPHA));

    MwConfig_UnitFrameAlphaSlider:SetValue(MistWeaverData.UNITALPHA_DC);
    _G[MwConfig_UnitFrameAlphaSlider:GetName().."Value"]:SetText(format("%.2f", MistWeaverData.UNITALPHA_DC));

    MwConfig_SpellAlphaSlider:SetValue(MistWeaverData.SPELL_ALPHA);
    _G[MwConfig_SpellAlphaSlider:GetName().."Value"]:SetText(format("%.2f", MistWeaverData.SPELL_ALPHA));

    MwConfig_RenewingMistBarHeightSlider:SetValue(MistWeaverData.RENEWINGMISTBAR_HEIGHT);
    _G[MwConfig_RenewingMistBarHeightSlider:GetName().."Value"]:SetText(format("%.0f", MistWeaverData.RENEWINGMISTBAR_HEIGHT));

    UIDropDownMenu_SetSelectedValue(MwConfig_ColorTypeDropDown, MistWeaverData.COLORTYPE);
    UIDropDownMenu_SetText(MwConfig_ColorTypeDropDown, COLOR_TYPE[MistWeaverData.COLORTYPE]);

    UIDropDownMenu_SetSelectedValue(MwConfig_SortTypeDropDown, MistWeaverData.SORTTYPE);
    UIDropDownMenu_SetText(MwConfig_SortTypeDropDown, SORT_TYPE[MistWeaverData.SORTTYPE]);

    UIDropDownMenu_SetSelectedValue(MwConfig_OrientationDropDown, MistWeaverData.ORIENTATION);
    UIDropDownMenu_SetText(MwConfig_OrientationDropDown, ORIENTATION[MistWeaverData.ORIENTATION]);

    MwConfig_UnitFrameGroupsizeSlider:SetValue(MistWeaverData.UNITFRAME_GROUPSIZE);
    _G[MwConfig_UnitFrameGroupsizeSlider:GetName().."Value"]:SetText(format("%.0f", MistWeaverData.UNITFRAME_GROUPSIZE));

    MwConfig_WhisperText:SetText(MistWeaverData.OUT_OF_RANGE);
    MwConfig_WhisperText:SetCursorPosition(0);

    MwConfig_ToggleShowInAllStancesCheckButton:SetChecked(MistWeaverData.SHOW_IN_ALL_STANCES);
    MwConfig_ToggleShowSoloCheckButton:SetChecked(MistWeaverData.SHOW_SOLO);
    MwConfig_ToggleShowDebuffsCheckButton:SetChecked(MistWeaverData.SHOW_DEBUFFS);
    MwConfig_ToggleShowRaidIconCheckButton:SetChecked(MistWeaverData.SHOW_RAID_ICON);
    MwConfig_ToggleShowPvpIconCheckButton:SetChecked(MistWeaverData.SHOW_PVP_ICON);

    MwConfig_RaidExtensionWidthSlider:SetValue(MistWeaverData.RAID_EXTENSION_WIDTH);
    _G[MwConfig_RaidExtensionWidthSlider:GetName().."Value"]:SetText(format("%.0f", MistWeaverData.RAID_EXTENSION_WIDTH));
    MwConfig_ToggleShowRaidDebuffsCheckButton:SetChecked(MistWeaverData.RAID_SHOW_DEBUFFS);

    MwConfig_ToggleShowTargetFrameCheckButton:SetChecked(MistWeaverData.SHOW_TARGET_FRAME);
    MwConfig_ToggleShowFocusFrameCheckButton:SetChecked(MistWeaverData.SHOW_FOCUS_FRAME);

    MwConfig_ToggleShowTargetFrameHeaderCheckButton:SetChecked(MistWeaverData.SHOW_TARGET_FRAME_HEADER);
    MwConfig_ToggleShowFocusFrameHeaderCheckButton:SetChecked(MistWeaverData.SHOW_FOCUS_FRAME_HEADER);

    MwConfigHighlightColor:SetBackdropColor(MistWeaverData.HIGHLIGHT_COLOR.r, MistWeaverData.HIGHLIGHT_COLOR.g, MistWeaverData.HIGHLIGHT_COLOR.b);
    MwConfigRenewingMistColor:SetBackdropColor(MistWeaverData.RENEWING_MIST_COLOR.r, MistWeaverData.RENEWING_MIST_COLOR.g, MistWeaverData.RENEWING_MIST_COLOR.b);
    MwConfigSoothingMistColor:SetBackdropColor(MistWeaverData.SOOTHING_MIST_COLOR.r, MistWeaverData.SOOTHING_MIST_COLOR.g, MistWeaverData.SOOTHING_MIST_COLOR.b);
    MwConfigEnvelopingMistColor:SetBackdropColor(MistWeaverData.ENVELOPING_MIST_COLOR.r, MistWeaverData.ENVELOPING_MIST_COLOR.g, MistWeaverData.ENVELOPING_MIST_COLOR.b);

    -- update main frame
    MistWeaver_UpdateActiveState();

    if (MistWeaver_IsActive()) then
        MistWeaver_UpdateUnitFrameSize();
        MistWeaver_RebindUnitFrames();
        MistWeaver_SetupUnitFramePositions();
    end

    MistWeaver_CheckTargetFrameVisibility();
    MistWeaver_CheckFocusFrameVisibility();

    MistWeaver_ResizeRaidExtension();

    MistWeaverDebuffs_OnUpdate();

    MistWeaver_LeaveCombat();
end

function MwConfig_CreateUI(self)

    -- Hauptfenster
    self.name = "MistWeaver";
    self.addonname = "MistWeaver";
    self.refresh = MwConfig_RefreshUI;
    InterfaceOptions_AddCategory(self);

    local author = GetAddOnMetadata(self.addonname, "Author");
    local version = GetAddOnMetadata(self.addonname, "Version");


    local title = self.addonname.." v"..version.." ("..author..")";

    local headline = self:CreateFontString(self:GetName().."Title", "ARTWORK", "MwConfigTitleTemplate");
    headline:SetText("|c333399ff"..title.."|r");
    headline:ClearAllPoints();
    headline:SetPoint("TOPLEFT", self, "TOPLEFT", 16, -16);

    local subtext = self:CreateFontString(self:GetName().."SubText", "ARTWORK", "MwConfigSubTextTemplate");
    subtext:SetText(MW_ADDON_INFO);
    subtext:ClearAllPoints();
    subtext:SetPoint("TOPLEFT", self, "TOPLEFT", 16, -48);
    subtext:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -16, -85);

    MwConfig_AddCheckButton(self, "MwConfig_ToggleActiveCheckButton",
        MW_ON, MwConfig_ToggleActive);

    MwConfig_AddCheckButton(self, "MwConfig_ToggleShowInAllStancesCheckButton",
        MW_SHOW_IN_ALL_STANCES, MwConfig_ToggleShowInAllStances);

    MwConfig_AddCheckButton(self, "MwConfig_ToggleShowSoloCheckButton",
        MW_SHOW_SOLO, MwConfig_ToggleShowSolo);

    MwConfig_AddSlider(self, "MwConfig_OOCAlphaSlider",
        MW_NOT_IN_COMBAT_ALPHA, 0.1, 1.0, 0.01, MwConfig_ChangeOOCAlpha);

    MwConfig_AddEditBox(self, "MwConfig_WhisperText",
        MW_OOR_TEXT, MwConfig_ChangeWhisperText, 250);

    MwConfig_AddLabel(self, "MwConfig_SaveChanges", SAVE_CHANGES..":", "");

    MwConfig_AddControl(self, MwConfigProfileFrame, 0);

    -- UnitFrames
    local unitFrames = CreateFrame("Frame", "MistWeaverUnitFramesConfig");
    unitFrames.name = MW_UNIT_FRAMES;
    unitFrames.parent = "MistWeaver";
    unitFrames.addonname = "MistWeaver";
    InterfaceOptions_AddCategory(unitFrames);

    headline = unitFrames:CreateFontString(unitFrames:GetName().."Title", "ARTWORK", "MwConfigTitleTemplate");
    headline:SetText("|c333399ff"..MW_UNIT_FRAMES.."|r");
    headline:ClearAllPoints();
    headline:SetPoint("TOPLEFT", unitFrames, "TOPLEFT", 16, -16);

    MwConfig_AddSlider(unitFrames, "MwConfig_UnitFrameWidthSlider",
        MW_UNIT_FRAME_WIDTH, 70, 200, 1, MwConfig_ChangeUnitFrameWidth);

    MwConfig_AddSlider(unitFrames, "MwConfig_UnitFrameHeightSlider",
        MW_UNIT_FRAME_HEIGHT, 50, 100, 1, MwConfig_ChangeUnitFrameHeight);

    MwConfig_AddSlider(unitFrames, "MwConfig_UnitFrameAlphaSlider",
        MW_UNIT_FRAME_ALPHA, 0.1, 0.9, 0.01, MwConfig_ChangeUnitFrameAlpha);

    MwConfig_AddSlider(unitFrames, "MwConfig_SpellAlphaSlider",
        MW_OTHER_MISTWEAVERS_ALPHA, 0.1, 0.9, 0.01, MwConfig_ChangeSpellAlpha);

    MwConfig_AddSlider(unitFrames, "MwConfig_RenewingMistBarHeightSlider",
        MW_RENEWING_MIST_BAR_HEIGHT, 10, 24, 1, MwConfig_ChangeRenewingMistBarHeight);

    MwConfig_AddCheckButton(unitFrames, "MwConfig_ToggleShowRaidIconCheckButton",
        MW_SHOW_RAID_ICON, MwConfig_ToggleShowRaidIcon);

    MwConfig_AddCheckButton(unitFrames, "MwConfig_ToggleShowPvpIconCheckButton",
        MW_SHOW_PVP_ICON, MwConfig_ToggleShowPvpIcon);

    MwConfig_AddDropDown(unitFrames, "MwConfig_SortTypeDropDown",
        MW_UNIT_SORT_TYPE, MwConfig_SortTypeDropDown_Initialize);

    MwConfig_AddDropDown(unitFrames, "MwConfig_OrientationDropDown",
        MW_UNIT_FRAME_ORIENTATION, MwConfig_OrientationDropDown_Initialize);

    MwConfig_AddSlider(unitFrames, "MwConfig_UnitFrameGroupsizeSlider",
        MW_GROUP_SIZE, 1, 40, 1, MwConfig_ChangeUnitFrameGroupsize);

    MwConfig_AddCheckButton(unitFrames, "MwConfig_ToggleShowTargetFrameCheckButton",
        MW_SHOW_TARGET_FRAME, MwConfig_ToggleShowTargetFrame);

    MwConfig_AddCheckButton(unitFrames, "MwConfig_ToggleShowTargetFrameHeaderCheckButton",
        MW_SHOW_TARGET_FRAME_HEADER, MwConfig_ToggleShowTargetFrameHeader, 18, 20);

    MwConfig_AddCheckButton(unitFrames, "MwConfig_ToggleShowFocusFrameCheckButton",
        MW_SHOW_FOCUS_FRAME, MwConfig_ToggleShowFocusFrame);

    MwConfig_AddCheckButton(unitFrames, "MwConfig_ToggleShowFocusFrameHeaderCheckButton",
        MW_SHOW_FOCUS_FRAME_HEADER, MwConfig_ToggleShowFocusFrameHeader, 18, 20);


    -- RaidFrames
    local raidFrames = CreateFrame("Frame", "MistWeaverRaidFramesConfig");
    raidFrames.name = RAIDOPTIONS_MENU;
    raidFrames.parent = "MistWeaver";
    raidFrames.addonname = "MistWeaver";
    InterfaceOptions_AddCategory(raidFrames);

    headline = raidFrames:CreateFontString(raidFrames:GetName().."Title", "ARTWORK", "MwConfigTitleTemplate");
    headline:SetText("|c333399ff"..RAIDOPTIONS_MENU.."|r");
    headline:ClearAllPoints();
    headline:SetPoint("TOPLEFT", raidFrames, "TOPLEFT", 16, -16);

    subtext = raidFrames:CreateFontString(raidFrames:GetName().."SubText", "ARTWORK", "MwConfigSubTextTemplate");
    subtext:SetText(MW_INFO_CHANGES_AFTER_RELOAD);
    subtext:ClearAllPoints();
    subtext:SetPoint("TOPLEFT", raidFrames, "TOPLEFT", 16, -48);
    subtext:SetPoint("BOTTOMRIGHT", raidFrames, "TOPRIGHT", -16, -85);

    MwConfig_AddSlider(raidFrames, "MwConfig_RaidExtensionWidthSlider",
        MW_RAID_EXTENSION_WIDTH, 20, 50, 1, MwConfig_ChangeRaidExtensionWidth);

    MwConfig_AddCheckButton(raidFrames, "MwConfig_ToggleShowRaidDebuffsCheckButton",
        MW_SHOW_DEBUFFS, MwConfig_ToggleShowRaidDebuffs);

    -- Colors
    local colors = CreateFrame("Frame", "MistWeaverColorConfig");
    colors.name = COLORS;
    colors.parent = "MistWeaver";
    colors.addonname = "MistWeaver";
    InterfaceOptions_AddCategory(colors);

    headline = colors:CreateFontString(colors:GetName().."Title", "ARTWORK", "MwConfigTitleTemplate");
    headline:SetText("|c333399ff"..COLORS.."|r");
    headline:ClearAllPoints();
    headline:SetPoint("TOPLEFT", colors, "TOPLEFT", 16, -16);

    MwConfig_AddColorChooser(colors, "MwConfigHighlightColor",
        MW_HIGHLIGHT_COLOR, MwConfig_SelectHighlightColor);

    MwConfig_AddColorChooser(colors, "MwConfigRenewingMistColor",
        MW_RENEWING_MIST_COLOR, MwConfig_SelectRenewingMistColor);

    MwConfig_AddColorChooser(colors, "MwConfigSoothingMistColor",
        MW_SOOTHING_MIST_COLOR, MwConfig_SelectSoothingMistColor);

    MwConfig_AddColorChooser(colors, "MwConfigEnvelopingMistColor",
        MW_ENVELOPING_MIST_COLOR, MwConfig_SelectEnvelopingMistColor);

    MwConfig_AddDropDown(colors, "MwConfig_ColorTypeDropDown",
        MW_UNIT_HEALTHBAR_COLOR, MwConfig_ColorTypeDropDown_Initialize);

    -- Debuffs
    local debuffs = CreateFrame("Frame", "MistWeaverDebuffConfig");
    debuffs.name = MW_DEBUFFS;
    debuffs.parent = "MistWeaver";
    debuffs.addonname = "MistWeaver";
    InterfaceOptions_AddCategory(debuffs);

    headline = debuffs:CreateFontString(debuffs:GetName().."Title", "ARTWORK", "MwConfigTitleTemplate");
    headline:SetText("|c333399ff"..MW_DEBUFFS.."|r");
    headline:ClearAllPoints();
    headline:SetPoint("TOPLEFT", debuffs, "TOPLEFT", 16, -16);

    local subtext = debuffs:CreateFontString(debuffs:GetName().."SubText", "ARTWORK", "MwConfigSubTextTemplate");
    subtext:SetText(MW_DEBUFF_INFO);
    subtext:ClearAllPoints();
    subtext:SetPoint("TOPLEFT", debuffs, "TOPLEFT", 16, -48);
    subtext:SetPoint("BOTTOMRIGHT", debuffs, "TOPRIGHT", -16, -85);

    MwConfig_AddCheckButton(debuffs, "MwConfig_ToggleShowDebuffsCheckButton",
        MW_SHOW_DEBUFFS, MwConfig_ToggleShowDebuffs);

    MwConfig_AddLabel(debuffs, "MwConfig_Debuffxxe", FILTER..":", "");

    MwConfig_AddEditBox(debuffs, "MwConfig_DebuffName", MW_DEBUFF_NAME, nil, 250);

    MwConfig_AddControl(debuffs, MistWeaverDebuffListFrame);

    local addButton = MwConfig_AddButton(nil, "MwConfig_AddDebuffButton", ADD, MistWeaverDebuffEntry_Add);
    local changeButton = MwConfig_AddButton(nil, "MwConfig_ChangeDebuffButton", SAVE, MistWeaverDebuffEntry_Change);

    addButton:SetParent(MistWeaverDebuffListFrame);
    changeButton:SetParent(MistWeaverDebuffListFrame);

    addButton:ClearAllPoints();
    addButton:SetPoint("TOPLEFT", MistWeaverDebuffListFrame, "TOPLEFT", 0, 0);
    changeButton:ClearAllPoints();
    changeButton:SetPoint("LEFT", addButton, "RIGHT", 0, 0);

    -- create scroll frame
    HybridScrollFrame_OnLoad(MistWeaverDebuffListFrame.scrollFrame);
    MistWeaverDebuffListFrame.scrollFrame.update = MistWeaverDebuffs_OnUpdate;
    HybridScrollFrame_CreateButtons(MistWeaverDebuffListFrame.scrollFrame, "MistWeaverDebuffEntryTemplate");

    MistWeaverDebuffListFrame.scrollFrame:SetFrameStrata("HIGH");

    local borderframe = _G["MistWeaverDebuffListFrameBorderFrame"];
    if (not borderframe) then
        borderframe = CreateFrame("Frame", "MistWeaverDebuffListFrameBorderFrame", MistWeaverDebuffListFrame.scrollFrame);
    end
    borderframe:SetPoint("TOPLEFT", -10, 5);
    borderframe:SetPoint("BOTTOMRIGHT", 25, -5);
    borderframe:SetFrameStrata("MEDIUM");

    borderframe:SetBackdrop( {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    });
    borderframe:SetBackdropColor(0.0, 0.0, 0.0, 1.0);

    MwConfig_CreateAboutUI(self);
end

function MwConfig_CreateAboutUI(self)
    -- About
    local mwAbout = CreateFrame("Frame", "MWAbout", self);
    mwAbout.name = INFO;
    mwAbout.parent = "MistWeaver";
    mwAbout.addonname = "MistWeaver";
    InterfaceOptions_AddCategory(mwAbout);

    local headline = mwAbout:CreateFontString(mwAbout:GetName().."Title", "ARTWORK", "MwConfigTitleTemplate");
    headline:SetText("|c333399ff"..INFO.."|r");
    headline:ClearAllPoints();
    headline:SetPoint("TOPLEFT", mwAbout, "TOPLEFT", 16, -16);

    MwConfig_AddLabel(mwAbout, "MwConfig_AboutAuthor", "Author", GetAddOnMetadata("MistWeaver", "Author"));
    MwConfig_AddLabel(mwAbout, "MwConfig_AboutVersion", "Version", GetAddOnMetadata("MistWeaver", "Version"));
    MwConfig_AddLabel(mwAbout, "MwConfig_AboutMemory", "Used Memory", string.format("%.2f kB", GetAddOnMemoryUsage("MistWeaver")));
    MwConfig_AddLabel(mwAbout, "MwConfig_AboutLocalization", "help translating:", "http://wow.curseforge.com/addons/mistweaver/localization/");

end

function MwConfig_AddControl(parent, control, xoffset, yoffset)
    if (not parent) then
        return control;
    end

    control:SetParent(parent);

    local liste = controls[parent:GetName()];
    if (not liste) then
        liste = {};
        controls[parent:GetName()] = liste;
    end

    local size = table.getn(liste);

    if (xoffset) then
        control.xoffset = xoffset;
    end

    local ref = parent;
    local relative = "TOPLEFT";
    local x = 15 + (xoffset or 0);
    local y = -80;

    if (size > 0) then
        ref = liste[size];
        relative = "BOTTOMLEFT";
        x = (xoffset or 0) - (ref.xoffset or 0);
        y = -10 - (yoffset or 0);
    end

    table.insert(liste, control);

    control:ClearAllPoints();
    control:SetPoint("TOPLEFT", ref, relative, x, y);

    return control;
end

function MwConfig_AddLabel(parent, name, labeltext, text)
    local label = parent:CreateFontString(name.."Label", "ARTWORK");
    label:SetFontObject(GameFontNormal);
    label:SetText("|cffffffff"..labeltext.."|r");

    local info = parent:CreateFontString(name.."Info", "ARTWORK");
    info:SetFontObject(GameFontNormal);
    info:SetText(text);
    info:ClearAllPoints();
    info:SetPoint("LEFT", label, "LEFT", 150, 0);

    return MwConfig_AddControl(parent, label);
end

function MwConfig_AddEditBox(parent, name, text, onTextChanged, width, xoffset)
    local editBox = CreateFrame("EditBox", name, parent, "MwConfigEditBoxTemplate");
    editBox.text:SetText(text);

    if (onTextChanged) then
        editBox:SetScript("OnTextChanged", onTextChanged);
    end

    if (width) then
        editBox:SetWidth(width);
    end

    return MwConfig_AddControl(parent, editBox, xoffset, 5);
end

function MwConfig_AddButton(parent, name, text, onClick, size, xoffset)
    local button = CreateFrame("Button", name, parent, "GameMenuButtonTemplate");
    button:SetText(text);

    button:SetScript("OnClick", onClick);

    if (not size) then
        size = 100;
    end

    button:SetWidth(size);

    return MwConfig_AddControl(parent, button, xoffset);
end

function MwConfig_AddCheckButton(parent, name, text, onClick, size, xoffset)
    local checkButton = CreateFrame("CheckButton", name, parent, "MwConfigCheckButtonTemplate");
    checkButton.text:SetText(text);

    checkButton:SetScript("OnClick", onClick);

    if (size) then
        checkButton:SetSize(size, size);
    end

    return MwConfig_AddControl(parent, checkButton, xoffset);
end

function MwConfig_AddSlider(parent, name, text, min, max, step, onValueChanged, xoffset)
    local slider = CreateFrame("Slider", name, parent, "MwConfigSliderTemplate");

    slider:SetScript("OnValueChanged", onValueChanged);

    slider:SetMinMaxValues(min, max);
    slider:SetValueStep(step);

    local label = _G[slider:GetName().."Text"];
    label:SetText(text);
    label:ClearAllPoints();
    label:SetPoint("LEFT", slider, "RIGHT", 15, 0);
    label:SetFontObject("GameFontNormal");

    local textLow = _G[slider:GetName().."Low"];
    local textHigh = _G[slider:GetName().."High"];
    textLow:SetText(min);
    textHigh:SetText(max);

    return MwConfig_AddControl(parent, slider, xoffset, 5);
end

function MwConfig_AddDropDown(parent, name, text, onInitialize, width, xoffset)
    local dropdown = CreateFrame("Frame", name, parent, "MwConfigDropDownMenuTemplate");

    dropdown.label:SetText(text);

    UIDropDownMenu_Initialize(dropdown, onInitialize);
    UIDropDownMenu_JustifyText(dropdown, "LEFT");

    if (width) then
        UIDropDownMenu_SetWidth(dropdown, width);
    end

    return MwConfig_AddControl(parent, dropdown, xoffset);
end

function MwConfig_AddColorChooser(parent, name, text, onMouseUp, xoffset)
    local frame = CreateFrame("Frame", name, parent, "MwConfigColorChooserTemplate");
    frame.text:SetText(text);

    frame:SetScript("OnMouseUp", onMouseUp);

    return MwConfig_AddControl(parent, frame, xoffset);
end

function MwConfig_SaveProfile()
    local name = MwConfigProfileFrame.name:GetText();

    if (not name or name == "") then
        return;
    end

    MistWeaverProfiles[name] = {};

    for key, data in pairs(MistWeaverData) do
        MistWeaverProfiles[name][key] = data;
    end
end

function MwConfig_LoadProfile()
    local selectedValue = UIDropDownMenu_GetSelectedValue(MwConfigProfileFrame.saved);
    MwConfig_LoadProfileWidthName(selectedValue);
end

function MwConfig_LoadProfileWidthName(name)

    if (not name or name == "") then
        return;
    end

    for key, data in pairs(MistWeaverProfiles[name]) do
        MistWeaverData[key] = data;
    end

    MwConfig_RefreshUI();
end

function MwConfig_DeleteProfile()
    local selectedValue = UIDropDownMenu_GetSelectedValue(MwConfigProfileFrame.saved);

    if (not selectedValue or selectedValue == "") then
        return;
    end

    local index = 1;
    for name, data in pairs(MistWeaverProfiles) do
        if (name == selectedValue) then
            UIDropDownMenu_SetSelectedValue(MwConfigProfileFrame.saved, nil);
            MwConfigProfileFrameSavedProfilesText:SetText("");
            MistWeaverProfiles[name] = nil;
            tremove(MistWeaverProfiles, index);
            break;
        end

        index = index + 1;
    end
end

function MwConfig_ReloadProfiles(self)
    for name, data in pairs(MistWeaverProfiles) do
        local info = UIDropDownMenu_CreateInfo();
        info.text = name;
        info.value = name;
        info.func = function()
            UIDropDownMenu_SetSelectedValue(MwConfigProfileFrame.saved, name);
        end
        UIDropDownMenu_AddButton(info);
    end
end

function MwConfig_ToggleActive()
    MistWeaverData.ACTIVE = not MistWeaverData.ACTIVE;

    MwConfig_RefreshUI();
end

function MwConfig_ToggleShowInAllStances()
    MistWeaverData.SHOW_IN_ALL_STANCES = not MistWeaverData.SHOW_IN_ALL_STANCES;

    MwConfig_RefreshUI();
end

function MwConfig_ToggleShowSolo()
    MistWeaverData.SHOW_SOLO = not MistWeaverData.SHOW_SOLO;

    MwConfig_RefreshUI();
end

function MwConfig_ToggleShowDebuffs()
    MistWeaverData.SHOW_DEBUFFS = not MistWeaverData.SHOW_DEBUFFS;

    if (not InCombatLockdown()) then
        MwConfig_RefreshUI();
    end
end

function MwConfig_ToggleShowRaidIcon()
    MistWeaverData.SHOW_RAID_ICON = not MistWeaverData.SHOW_RAID_ICON;

    MwConfig_RefreshUI();
end

function MwConfig_ToggleShowPvpIcon()
    MistWeaverData.SHOW_PVP_ICON = not MistWeaverData.SHOW_PVP_ICON;

    MwConfig_RefreshUI();
end

function MwConfig_ChangeRaidExtensionWidth(self)
    if (MistWeaverData.RAID_EXTENSION_WIDTH ~= self:GetValue()) then
        MistWeaverData.RAID_EXTENSION_WIDTH = self:GetValue();

        MwConfig_RefreshUI();
    end
end

function MwConfig_ToggleShowRaidDebuffs()
    MistWeaverData.RAID_SHOW_DEBUFFS = not MistWeaverData.RAID_SHOW_DEBUFFS;

    MwConfig_RefreshUI();
end

function MwConfig_ToggleShowTargetFrame()
    MistWeaverData.SHOW_TARGET_FRAME = not MistWeaverData.SHOW_TARGET_FRAME;

    MwConfig_RefreshUI();
end

function MwConfig_ToggleShowFocusFrame()
    MistWeaverData.SHOW_FOCUS_FRAME = not MistWeaverData.SHOW_FOCUS_FRAME;

    MwConfig_RefreshUI();
end

function MwConfig_ToggleShowTargetFrameHeader()
    MistWeaverData.SHOW_TARGET_FRAME_HEADER = not MistWeaverData.SHOW_TARGET_FRAME_HEADER;

    MwConfig_RefreshUI();
end

function MwConfig_ToggleShowFocusFrameHeader()
    MistWeaverData.SHOW_FOCUS_FRAME_HEADER = not MistWeaverData.SHOW_FOCUS_FRAME_HEADER;

    MwConfig_RefreshUI();
end

function MwConfig_ChangeUnitFrameWidth(self)
    if (MistWeaverData.UNITWIDTH ~= self:GetValue()) then
        MistWeaverData.UNITWIDTH = self:GetValue();

        MwConfig_RefreshUI();
    end
end

function MwConfig_ChangeUnitFrameHeight(self)

    if (MistWeaverData.UNITHEIGHT ~= self:GetValue()) then
        MistWeaverData.UNITHEIGHT = self:GetValue();

        MwConfig_RefreshUI();
    end
end

function MwConfig_ChangeRenewingMistBarHeight(self)

    if (MistWeaverData.RENEWINGMISTBAR_HEIGHT ~= self:GetValue()) then
        MistWeaverData.RENEWINGMISTBAR_HEIGHT = self:GetValue();

        MwConfig_RefreshUI();
    end
end

function MwConfig_ChangeUnitFrameGroupsize(self)

    if (MistWeaverData.UNITFRAME_GROUPSIZE ~= self:GetValue()) then
        MistWeaverData.UNITFRAME_GROUPSIZE = self:GetValue();

        MwConfig_RefreshUI();
    end
end

function MwConfig_ChangeOOCAlpha(self)

    if (MistWeaverData.OOC_ALPHA ~= self:GetValue()) then
        MistWeaverData.OOC_ALPHA = self:GetValue();

        MwConfig_RefreshUI();
    end
end

function MwConfig_ChangeUnitFrameAlpha(self)

    if (MistWeaverData.UNITALPHA_DC ~= self:GetValue()) then
        MistWeaverData.UNITALPHA_DC = self:GetValue();

        MwConfig_RefreshUI();
    end
end

function MwConfig_ChangeSpellAlpha(self)

    if (MistWeaverData.SPELL_ALPHA ~= self:GetValue()) then
        MistWeaverData.SPELL_ALPHA = self:GetValue();

        MwConfig_RefreshUI();
    end
end

function MwConfig_ColorTypeDropDown_Initialize(self)
    local selectedValue = UIDropDownMenu_GetSelectedValue(self);

    for i = 1, #COLOR_TYPE do
        local info = UIDropDownMenu_CreateInfo();
        info.text = COLOR_TYPE[i];
        info.value = i;
        info.func = function()
            MwConfig_ToggleColorType(i);
        end
        UIDropDownMenu_AddButton(info);
    end
end

function MwConfig_ToggleColorType(index)
    MistWeaverData.COLORTYPE = index;
    MwConfig_RefreshUI();
end

function MwConfig_SortTypeDropDown_Initialize(self)
    local selectedValue = UIDropDownMenu_GetSelectedValue(self);

    for i = 1, #SORT_TYPE do
        local info = UIDropDownMenu_CreateInfo();
        info.text = SORT_TYPE[i];
        info.value = i;
        info.func = function()
            MwConfig_ToggleSortType(i);
        end
        UIDropDownMenu_AddButton(info);
    end
end

function MwConfig_ToggleSortType(index)
    MistWeaverData.SORTTYPE = index;
    MwConfig_RefreshUI();
end

function MwConfig_OrientationDropDown_Initialize(self)
    local selectedValue = UIDropDownMenu_GetSelectedValue(self);

    for i = 1, #ORIENTATION do
        local info = UIDropDownMenu_CreateInfo();
        info.text = ORIENTATION[i];
        info.value = i;
        info.func = function()
            MwConfig_ToggleOrientation(i);
        end
        UIDropDownMenu_AddButton(info);
    end
end

function MwConfig_ToggleOrientation(index)
    MistWeaverData.ORIENTATION = index;
    MwConfig_RefreshUI();
end

function MwConfig_ChangeWhisperText(self)
    if (initialized) then
        MistWeaverData.OUT_OF_RANGE = self:GetText();
    end
end

function MwConfig_SelectHighlightColor()
    ColorPickerFrame.previousValues = {r = MistWeaverData.HIGHLIGHT_COLOR.r, g = MistWeaverData.HIGHLIGHT_COLOR.g, b = MistWeaverData.HIGHLIGHT_COLOR.b};
    ColorPickerFrame.func = MwConfig_SetHighlightColor;
    ColorPickerFrame.cancelFunc = MwConfig_CancelHighlightColor;
    ColorPickerFrame:SetColorRGB(MistWeaverData.HIGHLIGHT_COLOR.r, MistWeaverData.HIGHLIGHT_COLOR.g, MistWeaverData.HIGHLIGHT_COLOR.b);
    ShowUIPanel(ColorPickerFrame);
end

function MwConfig_SetHighlightColor()
    local r,g,b = ColorPickerFrame:GetColorRGB();
    MistWeaverData.HIGHLIGHT_COLOR.r = r;
    MistWeaverData.HIGHLIGHT_COLOR.g = g;
    MistWeaverData.HIGHLIGHT_COLOR.b = b;

    MwConfig_RefreshUI();
end

function MwConfig_CancelHighlightColor(prevValues)
    MistWeaverData.HIGHLIGHT_COLOR.r = prevValues.r;
    MistWeaverData.HIGHLIGHT_COLOR.g = prevValues.g;
    MistWeaverData.HIGHLIGHT_COLOR.b = prevValues.b;

    MwConfig_RefreshUI();
end

function MwConfig_SelectRenewingMistColor()
    ColorPickerFrame.previousValues = {r = MistWeaverData.RENEWING_MIST_COLOR.r, g = MistWeaverData.RENEWING_MIST_COLOR.g, b = MistWeaverData.RENEWING_MIST_COLOR.b};
    ColorPickerFrame.func = MwConfig_SetRenewingMistColor;
    ColorPickerFrame.cancelFunc = MwConfig_CancelRenewingMistColor;
    ColorPickerFrame:SetColorRGB(MistWeaverData.RENEWING_MIST_COLOR.r, MistWeaverData.RENEWING_MIST_COLOR.g, MistWeaverData.RENEWING_MIST_COLOR.b);
    ShowUIPanel(ColorPickerFrame);
end

function MwConfig_SetRenewingMistColor()
    local r,g,b = ColorPickerFrame:GetColorRGB();
    MistWeaverData.RENEWING_MIST_COLOR.r = r;
    MistWeaverData.RENEWING_MIST_COLOR.g = g;
    MistWeaverData.RENEWING_MIST_COLOR.b = b;

    MwConfig_RefreshUI();
end

function MwConfig_CancelRenewingMistColor(prevValues)
    MistWeaverData.RENEWING_MIST_COLOR.r = prevValues.r;
    MistWeaverData.RENEWING_MIST_COLOR.g = prevValues.g;
    MistWeaverData.RENEWING_MIST_COLOR.b = prevValues.b;

    MwConfig_RefreshUI();
end

function MwConfig_SelectSoothingMistColor()
    ColorPickerFrame.previousValues = {r = MistWeaverData.SOOTHING_MIST_COLOR.r, g = MistWeaverData.SOOTHING_MIST_COLOR.g, b = MistWeaverData.SOOTHING_MIST_COLOR.b};
    ColorPickerFrame.func = MwConfig_SetSoothingMistColor;
    ColorPickerFrame.cancelFunc = MwConfig_CancelSoothingMistColor;
    ColorPickerFrame:SetColorRGB(MistWeaverData.SOOTHING_MIST_COLOR.r, MistWeaverData.SOOTHING_MIST_COLOR.g, MistWeaverData.SOOTHING_MIST_COLOR.b);
    ShowUIPanel(ColorPickerFrame);
end

function MwConfig_SetSoothingMistColor()
    local r,g,b = ColorPickerFrame:GetColorRGB();
    MistWeaverData.SOOTHING_MIST_COLOR.r = r;
    MistWeaverData.SOOTHING_MIST_COLOR.g = g;
    MistWeaverData.SOOTHING_MIST_COLOR.b = b;

    MwConfig_RefreshUI();
end

function MwConfig_CancelSoothingMistColor(prevValues)
    MistWeaverData.SOOTHING_MIST_COLOR.r = prevValues.r;
    MistWeaverData.SOOTHING_MIST_COLOR.g = prevValues.g;
    MistWeaverData.SOOTHING_MIST_COLOR.b = prevValues.b;

    MwConfig_RefreshUI();
end

function MwConfig_SelectEnvelopingMistColor()
    ColorPickerFrame.previousValues = {r = MistWeaverData.ENVELOPING_MIST_COLOR.r, g = MistWeaverData.ENVELOPING_MIST_COLOR.g, b = MistWeaverData.ENVELOPING_MIST_COLOR.b};
    ColorPickerFrame.func = MwConfig_SetEnvelopingMistColor;
    ColorPickerFrame.cancelFunc = MwConfig_CancelEnvelopingMistColor;
    ColorPickerFrame:SetColorRGB(MistWeaverData.ENVELOPING_MIST_COLOR.r, MistWeaverData.ENVELOPING_MIST_COLOR.g, MistWeaverData.ENVELOPING_MIST_COLOR.b);
    ShowUIPanel(ColorPickerFrame);
end

function MwConfig_SetEnvelopingMistColor()
    local r,g,b = ColorPickerFrame:GetColorRGB();
    MistWeaverData.ENVELOPING_MIST_COLOR.r = r;
    MistWeaverData.ENVELOPING_MIST_COLOR.g = g;
    MistWeaverData.ENVELOPING_MIST_COLOR.b = b;

    MwConfig_RefreshUI();
end

function MwConfig_CancelEnvelopingMistColor(prevValues)
    MistWeaverData.ENVELOPING_MIST_COLOR.r = prevValues.r;
    MistWeaverData.ENVELOPING_MIST_COLOR.g = prevValues.g;
    MistWeaverData.ENVELOPING_MIST_COLOR.b = prevValues.b;

    MwConfig_RefreshUI();
end

function MistWeaverDebuffs_OnUpdate()
    MistWeaverDebuffConfigEntryHighlightFrame:Hide();

    local buttons = MistWeaverDebuffListFrame.scrollFrame.buttons;

    local numEntries = #MistWeaverIgnoreDebuffs;
    local numButtons = #buttons;

    local scrollOffset = HybridScrollFrame_GetOffset(MistWeaverDebuffListFrame.scrollFrame);
    local buttonHeight = buttons[1]:GetHeight();
    local displayedHeight = 0;

    local entry;
    local debuffName;

    for i=1, numButtons do

        local entryIndex = i + scrollOffset;
        entry = buttons[i];

        if ( entryIndex <= numEntries ) then
            debuffName = MistWeaverIgnoreDebuffs[entryIndex];

            entry:Show();
            entry.index = entryIndex;
            entry.deleteButton.index = entryIndex;

            -- button data
            entry:SetText(debuffName);

            -- this isn't a header, hide the header textures
            entry:SetNormalTexture("");
            entry:SetHighlightTexture("");

            if (entryIndex == selectedIndex) then
                -- reposition highlight frames
                MistWeaverDebuffConfigEntryHighlightFrame:SetParent(entry);
                MistWeaverDebuffConfigEntryHighlightFrame:SetPoint("TOPLEFT", entry, "TOPLEFT", 0, 0);
                MistWeaverDebuffConfigEntryHighlightFrame:SetPoint("BOTTOMRIGHT", entry, "BOTTOMRIGHT", 0, 0);
                MistWeaverDebuffConfigEntryHighlightFrame:Show();
            end
        else
            entry:Hide();
        end

        displayedHeight = displayedHeight + buttonHeight;
    end

    HybridScrollFrame_Update(MistWeaverDebuffListFrame.scrollFrame, numEntries * buttonHeight, displayedHeight);

    if (selectedIndex) then
        MwConfig_ChangeDebuffButton:Enable();
    else
        MwConfig_ChangeDebuffButton:Disable();
    end
end

function MistWeaverDebuffEntry_OnEnter(self)
--local data = debuffs[self.index];
end

function MistWeaverDebuffEntry_OnLeave(self)
--GameTooltip:FadeOut();
end

function MistWeaverDebuffEntry_OnClick(self, button, down)
    PlaySound("ACTIONBARBUTTONDOWN");
    selectedIndex = self.index;

    if (selectedIndex) then
        local name = MistWeaverIgnoreDebuffs[selectedIndex];
        if (name) then
            MwConfig_DebuffName:SetText(name);
        else
            selectedIndex = nil;
        end
    end

    MistWeaverDebuffs_OnUpdate();
end

function MistWeaverDebuffEntry_Add()
    local name = MwConfig_DebuffName:GetText();

    local foundIndex = MistWeaver_FindIgnoredDebuff(name);
    if (not foundIndex) then
        tinsert(MistWeaverIgnoreDebuffs, name);
    else
        selectedIndex = foundIndex;
    end

    MistWeaverDebuffs_OnUpdate();
end

function MistWeaverDebuffEntry_Change()
    if (selectedIndex) then
        MistWeaverIgnoreDebuffs[selectedIndex] = MwConfig_DebuffName:GetText();
    end

    MistWeaverDebuffs_OnUpdate();
end

function MistWeaverDebuffEntry_Delete(button)
    tremove(MistWeaverIgnoreDebuffs, button.index);
    selectedIndex = nil;
    MistWeaverDebuffs_OnUpdate();
end

function MistWeaver_FindIgnoredDebuff(name)
    for i, found in ipairs(MistWeaverIgnoreDebuffs) do
        if (name == found) then
            return i;
        end
    end

    return nil;
end

