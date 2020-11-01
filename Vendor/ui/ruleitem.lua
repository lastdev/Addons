--[[===========================================================================
    | Copyright (c) 2018
    |
    | RuleItem:
    |
    ========================================================================--]]

local AddonName, Addon = ...
local L = Addon:GetLocale()

local Package = select(2, ...);
local RuleItem = {};

local NUMERIC_PARAM_TEMPLATE = "Vendor_Rule_Numeric_Param";
local PARAM_MARGIN_X = 6;

function RuleItem:ShowMoveButtons(show)
    local moveUp = self.moveUp;
    local moveDown = self.moveDown;
    if (show) then
        if (moveUp:IsEnabled()) then
            moveUp:Show();
        else
            moveUp:Hide();
        end

        if (moveDown:IsEnabled()) then
            moveDown:Show();
        else
            moveDown:Hide();
        end
    else
        moveUp:Hide();
        moveDown:Hide();
    end
end

function RuleItem:SetMove(canMoveUp, canMoveDown)
    local moveUp = self.moveUp;
    local moveDown = self.moveDown;

    if (canMoveUp) then
        moveUp:Enable();
    else
        moveUp:Disable();
    end

    if (canMoveDown) then
        moveDown:Enable();
    else
        moveDown:Disable();
    end
    self:ShowMoveButtons(self.selected);
end

function RuleItem:ShowDivider(show)
    if (show) then
         self.divider:Show();
    else
        self.divider:Hide();
    end
end

--[[============================================================================
    | RuleItem:CreateParameters
    |   Create the frames which represent the rule parameters.
    ==========================================================================]]
function RuleItem:CreateParameters(params)
    -- Create/Cleanup our frames.
    if (self.params) then
        for _, frame in ipairs(self.params) do
            frame:Hide();
            frame:SetParent(nil);
        end
    end

    -- Create the new frames.
    self.params = {};
    for _, param in ipairs(params) do
        -- if not validateRuleParam(param) then ... end
        if (string.upper(param.Type) == "NUMERIC") then
            local frame = CreateFrame("EditBox", nil, self, NUMERIC_PARAM_TEMPLATE);
            frame.label:SetText(param.Name or "<unnamed>");
            frame.paramKey = string.upper(param.Key);
            frame.paramType = "NUMERIC";
            frame:SetNumber(0);
            table.insert(self.params, frame);
        else
            Addon:DebugRules("The parameter type '%s' is not valid, skipping parameter '%s'", param.Type, param.Name);
        end
    end
end

--[[============================================================================
    | RuleItem:LayoutParameters:
    |   If we've got parameters then we need to give the layout, we have
    |   "hidden" item in the markup where we anchor them to, but we also
    |   need to move the text so it properly wraps when we've got a parameter
    ==========================================================================]]
function RuleItem:LayoutParameters()
    if (self.params and table.getn(self.params)) then
        local anchor;
        local width = 0;
        for _, frame in ipairs(self.params) do
            frame:ClearAllPoints();
            if (not anchor) then
                frame:SetPoint("BOTTOMRIGHT", self.paramArea, "BOTTOMRIGHT", 0, 0);
            else
                frame:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMLEFT", -PARAM_MARGIN_X, 0);
            end
            frame:Show();
            anchor = frame;
            width = (width + frame:GetWidth() + PARAM_MARGIN_X);
        end

        self.paramArea:SetWidth(width);
        self.text:SetPoint("BOTTOMRIGHT", self.paramArea, "BOTTOMLEFT", -PARAM_MARGIN_X, 0);
    else
        -- Make sure this is the same as the XML
        self.text:SetPoint("BOTTOMRIGHT", self.paramArea, "BOTTOMLEFT", 0, 0);
    end
end

--[[============================================================================
    | RuleItem:SetParamValue
    |   Given the name of a parameter, and it's value this will handle setting
    |   the value on the frame, the first frame with the name is the one
    |   that gets the value.
    ==========================================================================]]
function RuleItem:SetParamValue(name, value)
    if (self.params) then
        for _, frame in ipairs(self.params) do
            if (string.upper(name) == frame.paramKey) then
                if (frame.paramType == "NUMERIC") then
                    -- If we numeric then we know the value is an editbox
                    -- in numeric mode,  just call "SetNumber"
                    frame:SetNumber(value);
                end
            else
                Addon:DebugRules("The parameter type '%s' is unknown for '%s' - rule %s", frame.paramType, name, tostring(self.ruleId));
            end
        end
    end
end

--[[============================================================================
    | RuleItem:GetParamValue:
    |   Given a frame this retrieves the value.
    ==========================================================================]]
function RuleItem:GetParamValue(frame)
    if (frame.paramType == "NUMERIC") then
        return frame:GetNumber();
    else
        Addon:DebugRules("The frame has an invalid parameter type '%s'", frame.paramType);
    end
end

function RuleItem:SetRule(ruleDef)
    self.ruleId = ruleDef.Id;
    self.selected = false;

    self.name:SetText(ruleDef.Name);
    self.text:SetText(ruleDef.Description);

    self.moveUp.tooltip = L["CONFIG_DIALOG_MOVEUP_TOOLTIP"];
    self.moveDown.tooltip = L["CONFIG_DIALOG_MOVEDOWN_TOOLTIP"];
    self.migrationText:SetText(L["RULEITEM_MIGRATE_WARNING"])
    self:ShowMoveButtons(false);
    self.check:Hide();
    self.check:SetVertexColor(0, 1, 0, 1);

    local ruleManager = Addon:GetRuleManager();
    if (ruleManager and not ruleManager:CheckRuleHealth(ruleDef.Id)) then
        self.background:Show();
        self.background:SetColorTexture(ORANGE_FONT_COLOR.r, ORANGE_FONT_COLOR.g, ORANGE_FONT_COLOR.b, 0.25);
        self.unhealthy:Show();
        self.migration:Hide();
        self.migrationText:Hide();
        self.text:Show();
    elseif (ruleDef.needsMigration) then
        self.background:Show();
        self.background:SetColorTexture(YELLOW_FONT_COLOR.r, YELLOW_FONT_COLOR.g, YELLOW_FONT_COLOR.b, 0.05);
        self.unhealthy:Hide();
        self.migration:Show();
        self.migrationText:Show();
        self.text:Hide();
    else
        self.background:Hide();
        self.unhealthy:Hide();
        self.migration:Hide();
        self.migrationText:Hide();
        self.text:Show();
    end

    if (ruleDef.Custom) then
        self.custom:Show();
        self.extension:Hide();
    elseif (Addon.Rules.IsExtension(ruleDef)) then
        self.custom:Hide();
        self.extension:Show();
    else
        self.custom:Hide();
        self.extension:Hide();
    end

    if (ruleDef.Params) then
        self:CreateParameters(ruleDef.Params);
    end
    self:LayoutParameters();
end

function RuleItem:GetRuleId()
    return self.ruleId;
end

--[[============================================================================
    | RuleItem:SetConfig
    |   Set the configuration of this item.
    ==========================================================================]]
function RuleItem:SetConfig(config, index)
    if (config and (type(config) == "table")) then
        for paramName, paramValue in pairs(config) do
            if (string.lower(paramName) ~= "rule") then
                self:SetParamValue(paramName, paramValue);
            end
        end
    end

    self.configIndex = index;
    self:SetSelected(config ~= nil);

    if (config ~= nil and self.migrationText:IsShown()) then 
        self.background:SetColorTexture(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 0.1);
    end
end

--[[============================================================================
    | RuleItem:GetConfig
    |   Builds and retrieves the config entry for this rule, or return
    |   nil to indicate this rule isn't enabled.
    ==========================================================================]]
function RuleItem:GetConfig()
    if (not self.selected) then
        return nil;
    end

    -- If we've got no parameters then simply want to return the
    -- rule id, rather building a table.
    if (not self.params or (table.getn(self.params) == 0)) then
        return self:GetRuleId();
    end

    -- We've got parameters, so copy each one out into the
    -- the table we're going to return.
    local config = { rule = self:GetRuleId() };
    for _, frame in ipairs(self.params) do
        rawset(config, frame.paramKey, self:GetParamValue(frame));
    end

    return config;
end

function RuleItem:GetConfigIndex()
    return self.configIndex;
end

--[[============================================================================
    | RuleItem:SetSelected:
    |   Sets the selected  / enabled state of this item and updates all
    |   the UI to reflect that state.
    ==========================================================================]]
function RuleItem:SetSelected(selected)
    self.selected = selected;
    if (selected) then
        self.check:Show();
        self.selectedBackground:Show();
        self:ShowMoveButtons(true);
    else
        self.check:Hide();
        self.selectedBackground:Hide();
        self:ShowMoveButtons(false);
    end

    if (self.params) then
        for _, frame in ipairs(self.params) do
            if (selected) then
                frame:Enable();
            else
                frame:Disable();
            end
        end
    end

    if (self.migrationText:IsShown()) then 
        if (selected) then
            self.background:SetColorTexture(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 0.1);
        else
            self.background:SetColorTexture(YELLOW_FONT_COLOR.r, YELLOW_FONT_COLOR.g, YELLOW_FONT_COLOR.b, 0.05);
        end 
    end
end

function RuleItem:GetSelected()
    return self.selected;
end

function RuleItem:OnClick(button)
    if (button == "LeftButton") then
        self:SetSelected(not self.selected);
    elseif (button == "RightButton") then
        -- You can view "definition" of system rules, and extension rules
        -- you can edit custom rules.
        local ruleDef = self:GetModel();
        if (ruleDef) then
            VendorEditRuleDialog:EditRule(ruleDef, ruleDef.ReadOnly or not ruleDef.Custom);
        end
    end
end

--[[============================================================================
    | RuleItem:OnMouseEnter:
    |   Called when the user mouses over the item if our item text is truncated
    |   then we will show a tooltip for the item.
    ==========================================================================]]
function RuleItem:OnMouseEnter()
    if (self.text:IsTruncated()) then
        local nameColor = { self.name:GetTextColor() };
        local textColor = { self.text:GetTextColor() };
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
        GameTooltip:AddLine(self.name:GetText(), unpack(nameColor));
        GameTooltip:AddLine(self.text:GetText(), unpack(textColor));
        GameTooltip:Show();
    end
end

--[[============================================================================
    | RuleItem:OnMouseLeave:
    |   Called when the user mouses off the item
    ==========================================================================]]
function RuleItem:OnMouseLeave()
    if (GameTooltip:GetOwner() == self) then
        GameTooltip:Hide();
    end
end

Package.RuleItem = RuleItem;
