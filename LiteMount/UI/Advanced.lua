--[[----------------------------------------------------------------------------

  LiteMount/UI/Advanced.lua

  Options frame to plug in to the Blizzard interface menu.

  Copyright 2011-2020 Mike Battersby

----------------------------------------------------------------------------]]--

local L = LM_Localize

local function BindingText(n)
    return format('%s %s', KEY_BINDING, n)
end

StaticPopupDialogs["LM_OPTIONS_NEW_FLAG"] = {
    text = format("LiteMount : %s", L.LM_NEW_FLAG),
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = 1,
    maxLetters = 24,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hideOnEscape = 1,
    OnAccept = function (self)
            local text = self.editBox:GetText()
            if LM_Options:IsValidFlagName(text) then
                LM_Options:CreateFlag(text)
            end
        end,
    EditBoxOnEnterPressed = function (self)
            if self:GetParent().button1:IsEnabled() then
                StaticPopup_OnClick(self:GetParent(), 1)
            end
        end,
    EditBoxOnEscapePressed = function (self)
            self:GetParent():Hide()
        end,
    EditBoxOnTextChanged = function (self)
            local text = self:GetText()
            if LM_Options:IsValidFlagName(text) then
                self:GetParent().button1:Enable()
            else
                self:GetParent().button1:Disable()
            end
        end,
    OnShow = function (self)
        self.editBox:SetFocus()
    end,
    OnHide = function (self)
            LiteMountOptionsAdvanced_Update()
        end,
}

StaticPopupDialogs["LM_OPTIONS_DELETE_FLAG"] = {
    text = format("LiteMount : %s", L.LM_DELETE_FLAG),
    button1 = ACCEPT,
    button2 = CANCEL,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hideOnEscape = 1,
    OnAccept = function (self)
            LM_Options:DeleteFlag(self.data)
            LiteMountOptionsAdvanced_Update()
        end,
    OnShow = function (self)
            self.text:SetText(format("LiteMount : %s : %s", L.LM_DELETE_FLAG, self.data))
    end
}

StaticPopupDialogs["LM_OPTIONS_RENAME_FLAG"] = {
    text = format("LiteMount : %s", L.LM_RENAME_FLAG),
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = 1,
    maxLetters = 24,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hideOnEscape = 1,
    OnAccept = function (self)
            local text = self.editBox:GetText()
            if LM_Options:IsValidFlagName(text) then
                LM_Options:RenameFlag(self.data, text)
            end
        end,
    EditBoxOnEnterPressed = function (self)
            if self:GetParent().button1:IsEnabled() then
                StaticPopup_OnClick(self:GetParent(), 1)
            end
        end,
    EditBoxOnEscapePressed = function (self)
            self:GetParent():Hide()
        end,
    EditBoxOnTextChanged = function (self)
            local text = self:GetText()
            if LM_Options:IsValidFlagName(text) then
                self:GetParent().button1:Enable()
            else
                self:GetParent().button1:Disable()
            end
        end,
    OnShow = function (self)
            self.text:SetText(format("LiteMount : %s : %s", L.LM_RENAME_FLAG, self.data))
            self.editBox:SetFocus()
        end,
    OnHide = function (self)
            LiteMountOptionsAdvanced_Update()
        end,
}

function LiteMountOptionsFlagButton_OnEnter(self)
    if self.flag then
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
        if rawget(L, self.flag) == nil then
            GameTooltip:AddLine(self.flag)
        else
            GameTooltip:AddLine(format('%s (%s)', self.flag, L[self.flag]))
        end
        GameTooltip:Show()
    end
end

function LiteMountOptionsFlagButton_OnLeave(self)
    if GameTooltip:GetOwner() == self then
        GameTooltip:Hide()
    end
end

local function UpdateFlagScroll(self)
    local offset = HybridScrollFrame_GetOffset(self)
    local buttons = self.buttons

    local allFlags = LM_Options:GetAllFlags()
    local totalHeight = (#allFlags + 1) * buttons[1]:GetHeight()
    local displayedHeight = #buttons * buttons[1]:GetHeight()

    local showAddButton

    for i = 1, #buttons do
        button = buttons[i]
        index = offset + i
        if index <= #allFlags then
            local flagText = allFlags[index]
            if LM_Options:IsPrimaryFlag(allFlags[index]) then
                flagText = ITEM_QUALITY_COLORS[2].hex .. flagText .. FONT_COLOR_CODE_CLOSE
                button.DeleteButton:Hide()
            else
                button.DeleteButton:Show()
            end
            button.Text:SetFormattedText(flagText)
            button.Text:Show()
            button:Show()
            button.flag = allFlags[index]
        elseif index == #allFlags + 1 then
            button.Text:Hide()
            button.DeleteButton:Hide()
            button:Show()
            button.flag = nil
            self.AddFlagButton:SetParent(button)
            self.AddFlagButton:ClearAllPoints()
            self.AddFlagButton:SetPoint("CENTER")
            self.AddFlagButton:SetWidth(self:GetWidth())
            button.DeleteButton:Hide()
            showAddButton = true
        else
            button:Hide()
            button.DeleteButton:Hide()
            button.flag = nil
        end
    end

    self.AddFlagButton:SetShown(showAddButton)

    HybridScrollFrame_Update(self, totalHeight, displayedHeight)
end

function LiteMountOptionsAdvanced_Update(self)
    self = self or LiteMountOptionsAdvanced
    UpdateFlagScroll(self.FlagScroll)
end

function LiteMountOptionsAdvanced_OnSizeChanged(self)
    HybridScrollFrame_CreateButtons(self.FlagScroll, "LiteMountOptionsFlagButtonTemplate", 0, 0, "TOPLEFT", "TOPLEFT", 0, 0, "TOP", "BOTTOM")
    for _,b in ipairs(self.FlagScroll.buttons) do
        b:SetWidth(self.FlagScroll:GetWidth())
    end
end

function LiteMountOptionsAdvanced_OnLoad(self)
    self.name = ADVANCED_OPTIONS

    self.EditScroll.EditBox.ntabs = 4

    UIDropDownMenu_Initialize(self.BindingDropDown, LiteMountOptionsAdvancedBindingDropDown_Initialize)
    UIDropDownMenu_SetText(self.BindingDropDown, BindingText(1))

    self.FlagScroll.update = UpdateFlagScroll
    LiteMountOptionsAdvanced_OnSizeChanged(self)

    LiteMountOptionsPanel_OnLoad(self)
end

function LiteMountOptionsAdvanced_OnShow(self)
    LiteMountOptionsAdvanced_Update(self)
    LiteMountOptionsPanel_OnShow(self)
end

function LiteMountOptionsAdvancedRevert_OnShow(self)
    local parent = self:GetParent()
    local editBox = parent.EditScroll.EditBox
    editBox:SetAlpha(0.5)
    editBox:Disable()
    parent.DefaultButton:Disable()
    self:SetText(UNLOCK)
end

function LiteMountOptionsAdvancedRevert_OnClick(self)
    local parent = self:GetParent()
    local editBox = parent.EditScroll.EditBox
    if self:GetText() == UNLOCK then
        editBox:SetAlpha(1.0)
        editBox:Enable()
        parent.DefaultButton:Enable()
        self:SetText(REVERT)
    else
        LiteMountOptionsControl_Revert(editBox)
        LiteMountOptionsControl_Refresh(editBox)
    end
end

function LiteMountOptionsAdvancedBindingDropDown_Initialize(dropDown, level)
    local info = UIDropDownMenu_CreateInfo()
    local editBox = LiteMountOptionsAdvanced.EditScroll.EditBox
    if level == 1 then
        for i = 1,4 do
            info.text = BindingText(i)
            info.arg1 = i
            info.arg2 = BindingText(i)
            info.func = function (button, v, t)
                    LiteMountOptionsControl_SetTab(editBox, v)
                    UIDropDownMenu_SetText(dropDown, t)
                end
            info.checked = (editBox.tab == i)
            UIDropDownMenu_AddButton(info, level)
        end
    end
end
