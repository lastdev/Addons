--[[----------------------------------------------------------------------------

  LiteMount/UI/Advanced.lua

  Options frame to plug in to the Blizzard interface menu.

  Copyright 2011 Mike Battersby

----------------------------------------------------------------------------]]--

local _, LM = ...

local L = LM.Localize

local function BindingText(n)
    return format('%s %s', KEY_BINDING, n)
end

--[[------------------------------------------------------------------------]]--

LiteMountAdvancedUnlockButtonMixin = {}

function LiteMountAdvancedUnlockButtonMixin:OnShow()
    local parent = self:GetParent()
    local editBox = parent.EditScroll.EditBox
    editBox:SetAlpha(0.5)
    editBox:Disable()
    parent.DefaultsButton:Disable()
    self:SetFrameLevel(parent.RevertButton:GetFrameLevel() + 1)
end

function LiteMountAdvancedUnlockButtonMixin:OnClick()
    local parent = self:GetParent()
    local editBox = parent.EditScroll.EditBox
    editBox:SetAlpha(1.0)
    editBox:Enable()
    parent.DefaultsButton:Enable()
    self:Hide()
end

--[[------------------------------------------------------------------------]]--

local function BindingGenerator(owner, rootDescription)
    local editBox = LiteMountAdvancedPanel.EditScroll.EditBox
    local IsSelected = function (v) return editBox.tab == v end
    local SetSelected = function (v) LiteMountOptionsControl_SetTab(editBox, v) end
    for i = 1, 4 do
        rootDescription:CreateRadio(BindingText(i), IsSelected, SetSelected, i)
    end
end

--[[------------------------------------------------------------------------]]--

LiteMountAdvancedEditScrollMixin = {}

function LiteMountAdvancedEditScrollMixin:OnLoad()
    self.scrollBarHideable = 1
    self.ScrollBar:Hide()
end

function LiteMountAdvancedEditScrollMixin:OnShow()
    self.EditBox:SetWidth(self:GetWidth() - 18)
end

--[[------------------------------------------------------------------------]]--

LiteMountAdvancedEditBoxMixin = {}

function LiteMountAdvancedEditBoxMixin:CheckCompileErrors()
    local parent = self:GetParent()
    local ruleset = LM.RuleSet:Compile(self:GetText())
    if ruleset.errors then
        -- It's possible we should just show the first one
        local errs = LM.tMap(ruleset.errors, function (info) return info.err end)
        local msg = table.concat(errs, "\n")
        parent.ErrorMessage:SetText(msg)
        parent.ErrorMessage:Show()
        return false
    else
        parent.ErrorMessage:Hide()
        return true
    end
end

function LiteMountAdvancedEditBoxMixin:SetOption(v, i)
    if self:CheckCompileErrors() then
        LM.Options:SetButtonRuleSet(i, v)
    end
end

function LiteMountAdvancedEditBoxMixin:GetOption(i)
    return LM.Options:GetButtonRuleSet(i)
end

function LiteMountAdvancedEditBoxMixin:GetOptionDefault()
    return LM.Options:GetButtonRuleSet('__default__')
end

function LiteMountAdvancedEditBoxMixin:OnLoad()
    self.ntabs = 4
end

--[[------------------------------------------------------------------------]]--

LiteMountAdvancedPanelMixin = {}

function LiteMountAdvancedPanelMixin:OnLoad()
    self.name = ADVANCED_OPTIONS
    self.BindingDropDown:SetupMenu(BindingGenerator)
    LiteMountOptionsPanel_RegisterControl(self.EditScroll.EditBox, self)
    LiteMountOptionsPanel_OnLoad(self)
end

function LiteMountAdvancedPanelMixin:OnShow()
    self.EditScroll.EditBox:CheckCompileErrors()
    self.UnlockButton:Show()
end
