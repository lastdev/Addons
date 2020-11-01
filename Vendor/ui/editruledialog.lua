local AddonName, Addon = ...
local L = Addon:GetLocale()
local Config = Addon:GetConfig()

local Package = select(2, ...);

local SCROLL_PADDING_X = 4;
local SCROLL_PADDING_Y = 17;
local SCROLL_BUTTON_PADDING = 4;
local ITEM_INFO_HTML_BODY_FMT = "<!DOCTYPE html><html><body><h1>%s</h1>%s</body></html>";
local ITEM_HTML_FMT = "<p>%s == %s%s%s</p>";
local NIL_ITEM_STRING = GRAY_FONT_COLOR_CODE .. "nil" .. FONT_COLOR_CODE_CLOSE;
local MATCHES_HTML_START = "<!DOCTYPE html><html><body>";
local MATCHES_HTML_END = "</body></html>";
local MATCHES_LINK_FMT1 = "<p>%s</p>";
local MODE_READONLY = 1;
local MODE_EDIT = 2;
local VALIDATE_THRESHOLD = 0.60;

local ITEMINFO_ID = 1;
local MATCHES_ID = 2;
local HELP_ID = 3;

local EditRule = {};

local RuleManager = Addon.RuleManager;
--Addon.EditRuleDialog = {};

Addon.EditTemplate = {}
local EditTemplate = Addon.EditTemplate;

Addon.Utils = Addon.Utils or {};
Addon.Utils.StringBuilder = {};
function Addon.Utils.StringBuilder:Create()
    local instance = { buffer = {} };
    setmetatable(instance, self);
    self.__index = self;
    return instance;
end

function Addon.Utils.StringBuilder:Add(str)
    local buffer = rawget(self, "buffer");
    table.insert(buffer, tostring(str));
    for i=table.getn(buffer)-1,1,-1 do
        if (string.len(buffer[i]) > string.len(buffer[i+1])) then
            break;
        end
        buffer[i] = (buffer[i] .. table.remove(buffer));
    end
end

function Addon.Utils.StringBuilder:AddFormatted(str, ...)
    self:Add(string.format(str, ...));
end

function Addon.Utils.StringBuilder:Get()
    return table.concat(rawget(self, "buffer"));
end

local function spairs(t, order)
    local keys = {};
    for key in pairs(t) do
        table.insert(keys, key);
    end
    table.sort(keys)

    local iter = 0
    return function()
        iter = iter + 1
        return keys[iter], t[keys[iter]];
    end
end


-- Move to rulehelp.lua
Addon.RuleDocumentation =
{
    CreateHeader = function(name, item, ext, isfunc)
        local postfix = "";
        if (ext) then
            postfix = string.format(" %s[Extension]%s", ORANGE_FONT_COLOR_CODE, FONT_COLOR_CODE_CLOSE);
        end

        local fmt = "<h1>%s%s%s%s%s</h1>"
        if isfunc then
           fmt = "<h1>%s%s(%s)%s%s</h1>"
        end

        local args = ""
        if (type(item) == "table") then
            if (item.Args) then
                args = item.Args
            end
        end

        return string.format(fmt, BATTLENET_FONT_COLOR_CODE, name, args, FONT_COLOR_CODE_CLOSE, postfix);
     end,

    CreateValues = function(item)
        if ((type(item) == "table") and item.Map) then
            local temp = {}
            for val, _ in pairs(item.Map) do
                table.insert(temp, string.format("\"%s\"", val))
            end
            return "<br/><h2>Possible Values:</h2><p>" .. table.concat(temp, ", ") .. "</p>";
        end
        return ""
    end,

    CreateContent = function(item)
        if (type(item) == "string") then
            return "<p>" .. item .. "</p>";
        elseif (type(item) == "table") then
            if (item.Html) then
                return item.Html;
            elseif (item.Text) then
                return "<p>" .. item.Text .. "</p>";
            end
        end
        return "";
    end,

    CreateSingleItem = function(name, item, ext, isfunc)
        return  Addon.RuleDocumentation.CreateHeader(name, item, ext, isfunc) ..
                Addon.RuleDocumentation.CreateContent(item) ..
                Addon.RuleDocumentation.CreateValues(item);

    end,

    Create = function()
        -- Create our singleton cache
        if (not Addon.RuleDocumentation.__docs) then
            local docs = {};
            for cat, section in pairs(Addon.ScriptReference) do
                for name, content in pairs(section) do
                    docs[string.lower(name)] = Addon.RuleDocumentation.CreateSingleItem(name, content, false, cat == "Functions");
                end
            end

            -- Document extension functons.
            if (Package.Extensions) then
                for name,help in pairs(Package.Extensions:GetFunctionDocs()) do
                    docs[string.lower(name)] = Addon.RuleDocumentation.CreateSingleItem(name, help, true, true);
                end
            end

            Addon.RuleDocumentation.__docs = docs;
        end
        return Addon.RuleDocumentation.__docs;
    end,

    --*****************************************************************************
    -- Get a list of documentation which matches the specified filter, if the
    -- filter empty/nil this returns the entire documentation
    --*****************************************************************************
    Filter = function(filter)
        -- Did the caller want everything?
        local docs = Addon.RuleDocumentation.Create()
        if ((not filter) or (string.len(filter) == 0) or (filter == "")) then
            return docs
        end

        -- Apply our filters
        local fltr = string.lower(filter)
        local results = {}
        for name, content in pairs(docs) do
            if (string.find(name, fltr)) then
                results[name] = content
            end
        end

        return results
    end
}

Addon.ScrollFrame =
{
    OnLoad = function(self)
        ScrollFrame_OnLoad(self);
        local scrollbar = _G[self:GetName() .. "ScrollBar"]

        local offsetY = self.scrollBarOffsetY or 0
	    _G[scrollbar:GetName().."ScrollDownButton"]:SetPoint("TOP", scrollbar, "BOTTOM", 0, SCROLL_BUTTON_PADDING);
	    _G[scrollbar:GetName().."ScrollUpButton"]:SetPoint("BOTTOM", scrollbar, "TOP", 0, -SCROLL_BUTTON_PADDING);
	    scrollbar:ClearAllPoints()
	    scrollbar:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -SCROLL_PADDING_X, SCROLL_PADDING_Y - offsetY - 2)
	    scrollbar:SetPoint("TOPRIGHT", self, "TOPRIGHT", -SCROLL_PADDING_X, -SCROLL_PADDING_Y + offsetY)
        if (self.scrollbarBack) then
	        self.scrollbarBack:SetAllPoints(scrollbar);
            self.scrollbarBack:Hide()
            scrollbar.scrollbarBack = self.scrollbarBack
        end

       self.scrollBarHideable = 1;
       self.scrollbar = scrollbar;
       scrollbar:Hide();

        scrollbar.Show = function(self)
                local frame = self:GetParent();
                local width = (frame:GetWidth() - self:GetWidth() - SCROLL_PADDING_X);
                frame.content:SetWidth(width);
                frame:GetScrollChild():SetWidth(width);
                if (self.scrollbarBack) then
                    self.scrollbarBack:Show();
                end
                getmetatable(self).__index.Show(self);
            end

        scrollbar.Hide = function(self)
                local frame = self:GetParent();
                local width = frame:GetWidth()
                frame:GetScrollChild():SetWidth(width);
                frame.content:SetWidth(width);
                if (self.scrollbarBack) then
                    self.scrollbarBack:Hide();
                end
                getmetatable(self).__index.Hide(self);
            end
    end,
}

Addon.EditRuleDialog =
{
    OnLoad = function(self)
        Mixin(self, Addon.EditRuleDialog);
        SetPortraitToTexture(self.portrait, "Interface\\Spellbook\\Spellbook-Icon");
        self:SetClampedToScreen(true)

        -- Setup Edit Rule
        Mixin(self.editRule, EditRule):Setup();
        local function update()
            self:UpdateButtonState();
        end;

        self.editRule.OnRuleChanged:Add(update);
        self.editRule.OnScriptValidated:Add(update);

        -- Initialize the tabs
        self.helpButton.text:SetText(L.EDITRULE_HELP_TAB_NAME);
        self.infoButton.text:SetText(L.EDITRULE_ITEMINFO_TAB_NAME);
        self.itemInfoPanel.topText:SetText(L.EDITRULE_ITEMINFO_TAB_TEXT);
        self.matchesButton.text:SetText(L.EDITRULE_MATCHES_TAB_NAME);
        self.matchesPanel.topText:SetText(L.EDITRULE_MATCHES_TAB_TEXT);

        -- Set the mode
        self:SetMode(MODE_EDIT);
    end,

    OnScriptTextLoad = function(self, scrollFrame)
        local scrollbar = _G[scrollFrame:GetName().."ScrollBar"]
	    _G[scrollbar:GetName().."ScrollDownButton"]:SetPoint("TOP", scrollbar, "BOTTOM", 0, SCROLL_BUTTON_PADDING);
	    _G[scrollbar:GetName().."ScrollUpButton"]:SetPoint("BOTTOM", scrollbar, "TOP", 0, -SCROLL_BUTTON_PADDING);
	    scrollbar:ClearAllPoints()
	    scrollbar:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", -SCROLL_PADDING_X, SCROLL_PADDING_Y)
	    scrollbar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", -SCROLL_PADDING_X, -SCROLL_PADDING_Y + 1)
	    scrollFrame.scrollbarBack:SetAllPoints(scrollbar)

       scrollFrame.scrollBarHideable = 1;
       scrollFrame.scrollbar = scrollbar;
       scrollFrame.scrollbarBack:Hide();
       scrollbar:Hide();

        scrollbar.Show = function(self)
                local width = (scrollFrame:GetWidth() - self:GetWidth() - SCROLL_PADDING_X);
                scrollFrame.content:SetWidth(width);
                scrollFrame:GetScrollChild():SetWidth(width);
                scrollFrame.scrollbarBack:Show();
                getmetatable(self).__index.Show(self);
            end

        scrollbar.Hide = function(self)
                local width = scrollFrame:GetWidth();
                scrollFrame:GetScrollChild():SetWidth(width);
                scrollFrame.content:SetWidth(width);
                scrollFrame.scrollbarBack:Hide();
                getmetatable(self).__index.Hide(self);
            end
    end,

    OnHelpPaneLoad = function(self)
        self.filterLabel:SetText(L.EDITRULE_FILTER_LABEL);
        Addon.EditRuleDialog.SetEditHelpText(self.filter, L.EDITRULE_FILTER_HELPTEXT)
    end,

    --*****************************************************************************
    -- Called when we need to update our help content this will apply the filter
    -- then generate HTML for the content of the control
    --*****************************************************************************
    UpdateReference = function(helpPane)
        local docs  = Addon.RuleDocumentation.Filter(helpPane.filter:GetText());
        local temp = {}

        -- Sort/Build temporary array that we can concat.
        for _, content in spairs(docs) do
            table.insert(temp, content)
        end

        -- Put the text into the body
        local html = "<html><body>" .. table.concat(temp, "<br/>") .. "</body></html>"
        helpPane.reference.scrollFrame.content:SetText(html)
    end,

    --*****************************************************************************
    -- Called when our "filter" focus state changes, we want to show/hide our
    -- help text if we've got content.
    --*****************************************************************************
    OnEditFocusChange = function(self, gained)
        local helpText = self.helpText or self:GetParent().helpText;
        if (helpText) then
            if (gained) then
                helpText:Hide()
            else
                local text = self:GetText()
                if (not text or (text == "") or (string.len(text) == 0)) then
                    helpText:Show()
                else
                    helpText:Hide();
                end
            end
        end
    end,

    OnEditDisable = function(self)
        local textColor = self.disabledColor;
        if (textColor) then
            self:SetTextColor(textColor.r, textColor.g, textColor.b);
        end
    end,

    OnEditEnable = function(self)
        local textColor = self.normalColor;
        if (textColor) then
            self:SetTextColor(textColor.r, textColor.g, textColor.b);
        end
    end,

    SetEditLabel = function(self, text)
        if (self.label) then
            self.label:SetText(text);
        end
    end,

    SetEditHelpText = function(self, text)
        if (self.helpText) then
            self.helpText:SetText(text);
        end
    end,

    OnEditLoad = function(self)
        self.SetLabel = Addon.EditRuleDialog.SetEditLable;
        self.SetHelpText = Addon.EditRuleDialog.SetEditHelpText;
        Addon.EditRuleDialog.OnEditEnable(self);
    end,
};

local EditRuleDialog = Addon.EditRuleDialog;

function EditRuleDialog:UpdateItemProperties()
    if (not CursorHasItem()) then
        return;
    end

    local _, _, link = GetCursorInfo();


    -- get cursor item location
    local location = C_Cursor.GetCursorItem()
    if not location or not location:IsBagAndSlot() then return end
    local bag, slot = location:GetBagAndSlot()
    ClearCursor();

    local function htmlEncode(str)
        return str:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
    end

    local itemProps = Addon:GetItemProperties(bag, slot);
    local props = {}
    if (itemProps) then
        for name, value in spairs(itemProps) do
            if ((type(name) == "string") and
                ((type(value) ~= "table") and (type(value) ~= "function"))) then
                local valStr = tostring(value);
                if (type(value) == "string") then
                    valStr = string.format("\"%s\"", value);
                else
                    if ((value == nil) or (valStr == "") or (string.len(valStr) == 0)) then
                        valStr = NIL_ITEM_STRING;
                    end
                end

                table.insert(props, string.format(ITEM_HTML_FMT, name, GREEN_FONT_COLOR_CODE, htmlEncode(valStr), FONT_COLOR_CODE_CLOSE));
            end
        end

        self.itemInfoPanel.propHtml.scrollFrame.content:SetText(string.format(ITEM_INFO_HTML_BODY_FMT, link, table.concat(props)));
    end
end

-- Helper function which searches the config for the parameters for this rule,
-- if none is found then this will return nil.
local function findRuleParams(ruleDef)
    for _, config in ipairs(Config:GetRulesConfig(ruleDef.Type)) do
        if ((type(config) == "table") and config.rule) then
            if (string.lower(config.rule) == string.lower(ruleDef.Id)) then
                return config;
            end
        end
    end
end

--[[===========================================================================
    | Called to handle updating the matches panel, this is called whenever
    | the panel is shown, or the rule has been updated.
    ===========================================================================--]]
function EditRuleDialog:UpdateMatches()
    local ruleDef = self.ruleDef;
    local matchContent = self.matchesPanel.propMatches.scrollFrame.content;
    local hasMatches = false;

    Addon:Debug("Building matches for rule '%s'", ruleDef.Id);
    if ((self.mode == MODE_READONLY) or self.editRule:IsScriptValid()) then
        local params = nil;
        local _, _, _, script = self.editRule:GetValues();

        if (self.mode == MODE_READONLY) then
            script = ruleDef.Script;
            params = findRuleParams(ruleDef);
        end

        local matches = Addon:GetMatchesForRule(self.rulesEngine, ruleDef.Id, script, params);
        if (matches) then
            local sb = Addon.Utils.StringBuilder:Create();
            sb:Add(MATCHES_HTML_START);
            sb:AddFormatted(L["EDITRULE_MATCHES_HEADER_FMT"], #matches);

            for _, link in ipairs(matches) do
                hasMatches = true;
                sb:AddFormatted(MATCHES_LINK_FMT1, link);
            end

            sb:Add(MATCHES_HTML_END);
            matchContent:SetText(sb:Get());
        end
    end

    if (not hasMatches) then
       matchContent:SetText(MATCHES_HTML_START .. L["EDITRULE_NO_MATCHES"] .. MATCHES_HTML_END);
    end
end

--[[===========================================================================
    | Toggle the layout of the dialog to either the read-only or edit layout
    ===========================================================================--]]
function EditRuleDialog:SetMode(mode, infoId)
    self.mode = mode;
    self.editRule:ShowStatus();
    if (mode == MODE_READONLY) then
        self.TitleText:SetText(L["VIEWRULE_CAPTION"]);
        self.editRule:SetReadOnly(true);
        self.save:Disable();
        self:SetInfoContent(MATCHES_ID);
    else
        self.TitleText:SetText(L.EDITRULE_CAPTION);
        self.editRule:SetReadOnly(false);
        self:SetInfoContent(infoId or MATCHES_ID);
    end
end

--[[===========================================================================
    | Called when the text of the rule edit field has changed, this will queue
    | a timer to delay evaluation until the user has stopped typing. If the
    | dialog is not currently in editing mode then we simply bail out.
    ===========================================================================--]]
function EditRuleDialog:UpdateButtonState()
    -- If we are not read-only then need to determine if
    -- can enable/disable the save button
    if (self.mode ~= MODE_READONLY) then
        local _, name, description, script = self.editRule:GetValues();
        local canSave = true;

        if (not self.editRule:IsScriptValid()) then
            canSave = false;
            Addon:Debug("EditRule - Cannot save rule due to an invalid script");
        end

        if (canSave and (string.len(name) == 0)) then
            canSave = false;
            Addon:Debug("EditRule - Cannot save rule due to and invalid name");
        end

        if (canSave and (string.len(description) == 0)) then
            canSave = false;
            Addon:Debug("EditRule - Cannot save rule due an invalid description");
        end

        if (canSave or self.ruleDef.needsMigration) then
            self.save:Enable();
        else
            self.save:Disable();
        end
    else
        self.save:Disable();
    end

    -- If we are read-only or the save button is enabled then update
    -- matches for the current rule
    self:UpdateMatches(self);
end


--[[===========================================================================
    | Called when the user clicks OKAY, this will create  a new custom
    | rule definition and place it into the saved variable.
    ===========================================================================--]]
function EditRuleDialog.HandleOk(self)
    if (not self.readOnly) then
        Addon:Debug("Creating new custom rule definition");
        local rtype, name, description, script = self.editRule:GetValues();
        local newRuleDef =
        {
            Id = self.ruleDef.Id,
            Type = rtype,
            Name = name,
            Description = description,
            Script = script,
			SupportsClassic = Addon.IsClassic,
        };

        Vendor.Rules.UpdateDefinition(newRuleDef);
    end
end

function EditRuleDialog:SetInfoContent(id)
    assert(#self.infoPanels == #self.infoButtons);
    local grayFont = GRAY_FONT_COLOR;
    local activeFont = NORMAL_FONT_COLOR;

    for i=1,#self.infoPanels do
        local panel = self.infoPanels[i];
        local button = self.infoButtons[i];

        if (panel:GetID() == id) then
            panel:SetAllPoints(self.infoArea);
            panel:Show();
        else
            panel:Hide();
        end

        if (button:GetID() == id) then
            button.text:SetTextColor(activeFont.r, activeFont.g, activeFont.b);
            button.icon:SetAlpha(1.0);
        else
            button.text:SetTextColor(grayFont.r, grayFont.g, grayFont.b);
            button.icon:SetAlpha(0.5);
        end
    end
end

-- Verifies we've got a cached rules engine
function EditRuleDialog:EnsureRulesEngine()
    if (not self.rulesEngine) then
        self.rulesEngine = Addon:CreateRulesEngine(false);
    end
end

--*****************************************************************************
-- Create a new rule (Generates a unique new id for it) and then opens the
-- dialog to the rule (read only is considered false)
--*****************************************************************************
function EditRuleDialog:CreateRule()
    self:EditRule({ Id = string.lower(RuleManager.CreateCustomRuleId()), Type = Addon.c_RuleType_Sell, SupportsClassic = Addon.IsClassic }, false, HELP_ID)
end

--*****************************************************************************
-- Called when our "filter" focus state changes, we want to show/hide our
-- help text if we've got content.
--*****************************************************************************
function EditRuleDialog:EditRule(ruleDef, readOnly, infoPanelId)
    -- Save the parameters we need.
    self:EnsureRulesEngine();
    self.ruleDef = ruleDef;
    self.readOnly = readOnly or false;

    -- Set the name / description / script
    self.editRule:SetValues(
        ruleDef.Type or Addon.c_RuleType_Sell,
        ruleDef.Name, ruleDef.Description,
        ruleDef.ScriptText or ruleDef.Script,
        ruleDef.Id);

    -- If the rule came from an extension setup the widget.
    self.editRule:SetExtension(ruleDef.Extension);
    local health = false;

    -- If we're read-only disable all the fields.
    if (readOnly) then
        self:SetMode(MODE_READONLY);
        if (self:CheckRuleHealth(ruleDef)) then
            self.editRule:ShowStatus();
            health = true;
        end
    else
        self:SetMode(MODE_EDIT, infoPanelId);
        if (self:CheckRuleHealth(ruleDef)) then
            self.editRule:IsScriptValid(true);
            health = true;
        end
    end

    -- Check if this rule needs migration.
    if (ruleDef.needsMigration and health) then
        self.editRule:ShowStatus("MIGRATE");
    end

    self:UpdateButtonState();
    self:Show();
end

function EditRuleDialog:CheckRuleHealth(ruleDef)
    if (ruleDef and ruleDef.Script) then
        local _, _, status, _, message = Addon:GetRuleStatus(ruleDef.Id);
        if (status == "ERROR" and message) then
            self.editRule:ShowStatus("UNHEALTHY", message);
            return false;
        end
    end
    return true;
end

function EditRuleDialog:OnShow()
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
    self:EnsureRulesEngine();
    Addon:LoadAllBagItemLinks()
end

function EditRuleDialog:OnHide()
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE);
    self.rulesEngine = nil;
end

-- Move this to it's own place (file)

function EditRule:SetupRuleType()
    Package.InitializeRadioButton(self.sellRule, Addon.c_RuleType_Sell, L["EDITRULE_SELLRULE_LABEL"], L["EDITRULE_SELLRULE_TEXT"]);
    Package.InitializeRadioButton(self.keepRule, Addon.c_RuleType_Keep, L["EDITRULE_KEEPRULE_LABEL"], L["EDITRULE_KEEPRULE_TEXT"]);
    Package.InitializeRadioButton(self.scrapRule, Addon.c_RuleType_Scrap, L["EDITRULE_SCRAPRULE_LABEL"], L["EDITRULE_SCRAPRULE_TEXT"]);
    self.sellRule:SetSelected(Addon.c_RuleType_SellRule);
end

function EditRule:Setup()
    -- Create our events
    self.OnScriptValidated = Package.CreateEvent("EditRule::OnScriptValidated");
    self.OnRuleChanged = Package.CreateEvent("EditRule::OnRuleChanged");

    -- Setup our edit fields.
    Addon.EditRuleDialog.SetEditLabel(self.name, L.EDITRULE_NAME_LABEL);
    Addon.EditRuleDialog.SetEditHelpText(self.name, L.EDITRULE_NAME_HELPTEXT);
    Addon.EditRuleDialog.SetEditLabel(self.script, L.EDITRULE_SCRIPT_LABEL);
    Addon.EditRuleDialog.SetEditHelpText(self.script, L.EDITRULE_SCRIPT_HELPTEXT);
    Addon.EditRuleDialog.SetEditLabel(self.description, L.EDITRULE_DESCR_LABEL);
    Addon.EditRuleDialog.SetEditHelpText(self.description, L.EDITRULE_DESCR_HELPTEXT);
    self:SetupRuleType();

    -- Setup status areas
    self.okStatus.title:SetText(L["EDITRULE_OK_TEXT"]);
    self.okStatus.text:SetText(L["EDITRULE_RULEOK_TEXT"]);
    self.errorStatus.title:SetText(L["EDITRULE_ERROR_RULE"]);
    self.unhealthyStatus.title:SetText(L["EDITRULE_UNHEALTHY_RULE"]);
    self.migrateStatus.title:SetText(L["EDITRULE_MIGRATE_RULE_TITLE"]);
    self.migrateStatus.text:SetText(L["EDITRULE_MIGRATE_RULE_TEXT"]);
    self.extension:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
    self.extension:Hide();

    -- Setup callbacks from our edit field
    local function onChange(which, user)
        if (user) then
            self:onEditChanged(which);
        end
    end;

    self.script.content:SetScript("OnTextChanged", onChange);
    self.description.content:SetScript("OnTextChanged", onChange);
    self.name:SetScript("OnTextChanged", onChange);

    -- Create our tab-group so we can handle tabbing
    self.tabgroup = CreateTabGroup(self.name, self.description.content,
        self.script.content, self.sellRule, self.keepRule);
end

function EditRule:Cleanup()
    if (self.delayTimer) then
        self.delayTimer:Cancel();
        self.delayTimer = nil;
    end

    if (self.scriptTimer) then
        self.scriptTimer:Cancel();
        self.scriptTimer = nil;
    end
end

-- Called when tab is pressed in one of our sub-controls. Does not work on Classic
function EditRule:OnTabPressed()
    --@retail@
    self.tabgroup:OnTabPressed();
    --@end-retail@
end

function EditRule:GetValues()
    local rtype = self.sellRule:GetSelected() or Addon.c_RuleType_Sell;
    local name = self.name:GetText() or "";
    local description = self.description.content:GetText() or "";
    local script = self.script.content:GetText() or "";
    return rtype, name, description, script;
end

function EditRule:SetExtension(ext)
    if (ext and (type(ext) == "table")) then
        self.extension:Show();
        self.extension:SetFormattedText(L["EDITRULE_RULE_SOURCE_FMT"], ext.Name);
    else
        self.extension:Hide();
    end
end

function EditRule:SetValues(rtype, name, description, script, id)
    self._inSetValues = true;

    local edit = self.name;
    edit:SetText(name or "");
    Vendor.EditRuleDialog.OnEditFocusChange(edit);

    edit = self.description.content;
    edit:SetText(description or "");
    Vendor.EditRuleDialog.OnEditFocusChange(edit);

    edit = self.script.content;
    edit:SetText(script or "");
    Vendor.EditRuleDialog.OnEditFocusChange(edit);

    self.sellRule:SetSelected(rtype);

    self._inSetValues = false;
end

function EditRule:ShowStatus(status, text)
    self.okStatus:Hide();
    self.unhealthyStatus:Hide();
    self.errorStatus:Hide();
    self.migrateStatus:Hide();

    if (status == "OK") then
        self.okStatus:Show();
    elseif (status == "ERROR") then
        self.errorStatus.text:SetText(L["EDITRULE_SCRIPT_ERROR"] .. text);
        self.errorStatus:Show();
    elseif (status == "UNHEALTHY") then
        self.unhealthyStatus.text:SetText(text);
        self.unhealthyStatus:Show();
    elseif (status == "MIGRATE") then
        self.migrateStatus:Show();
    end
end

function EditRule:SetReadOnly(readonly)
    if (readonly) then
        self.name:Disable();
        self.script.content:Disable();
        self.description.content:Disable();
        self.sellRule:Disable();
        self.keepRule:Disable();
        self.scrapRule:Disable();
    else
        self.name:Enable();
        self.script.content:Enable();
        self.description.content:Enable();
        self.sellRule:Enable();
        self.keepRule:Enable();
        self.scrapRule:Enable();
    end
end

--[[===========================================================================
    | IsScriptValid:
    |   This is called to check our script for validation, this will check
    |   or cached values, or if specified by the caller will force
    |   a validate now.
    =======================================================================--]]
function EditRule:IsScriptValid(force)
    if (force) then
        self:OnValidateScript(true);
    end

    return self.scriptIsValid;
end

--[[===========================================================================
    | Called when both the script, and our timer has fired. This is a helper
    | to user which validates the script is OK, if we find an error, we show
    | and error widget (with the message).
    ===========================================================================--]]
function EditRule:OnValidateScript(force)
    local last = self._lastEdit;
    local now = GetTime();

    if (force or (not last) or ((now - last > VALIDATE_THRESHOLD))) then
        self.scriptIsValid = false;
        if (self.scriptTimer) then
            self.scriptTimer:Cancel();
            self.scriptTimer = nil;
        end

        local script = self.script.content:GetText();
        if (script and string.len(script) ~= 0) then
            Addon:Debug("Validating script: %s", script);
            local valid, message = Addon:ValidateRuleAgainstBags(self:GetParent().rulesEngine, script);
            if (not valid) then
                self:ShowStatus("ERROR", message);
                Addon:Debug("Script failed to validate: %s", message);
            else
                self:ShowStatus("OK");
                self.scriptIsValid = true;
                Addon:Debug("Validated script successfully");
            end

        else
            Addon:Debug("There was not script to validate");
            self:ShowStatus();
        end

        self.OnScriptValidated(self.scriptIsValid);
        self._lastEdit = 0;
    end
end

-- Small helper function which is called when something other than the script changes, we delay
-- this so that we don't constantly do work while the user is typing.
function EditRule:OnDelayChange()
    if ((GetTime() - self._lastChange) > VALIDATE_THRESHOLD) then
        if (self.changeDelay) then
            self.changeDelay:Cancel();
            self.changeDelay = nil;
        end
        self._lastChange = 0;
        self.OnRuleChanged();
    end
end

-- Private function we subscribe to our three edit boxes for modification callbacks
function EditRule:onEditChanged(which)
    if (self._inSetValues) then
        return;
    end

    if (which == self.script.content) then
        -- The script changed, so we want to fire script validation which will
        -- fire script validation vs. rule changed.
        self._lastEdit = GetTime();
        self.scriptIsValid = false;
        if (not self.scriptTimer) then
            self.scriptTimer = C_Timer.NewTicker(VALIDATE_THRESHOLD / 2, function() self:OnValidateScript() end);
        end
    else
        -- Queue up a timer to delay the change for a few milliseconds.
        self._lastChange = GetTime();
        if (not self.changeDelay) then
            self.changeDelay = C_Timer.NewTicker(VALIDATE_THRESHOLD / 2, function() self:OnDelayChange() end);
        end
    end
end

-- Export to Public
Addon.Public.EditRuleDialog = Addon.EditRuleDialog
Addon.Public.ScrollFrame = Addon.ScrollFrame
Addon.Public.RuleDocumentation = Addon.RuleDocumentation
