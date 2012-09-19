POJ_ACTIONBUTTONCOUNT  =  4
POJ_ACTIONBUTTONOFFSET = 34


function PoJ_ActionBar_TargetIdent_DropDown_Initialize()
  local info
  info = { text = POJ_STRING.ACTIONBAR.TARGETID .. ": " .. PoJ_GetTargetIdentifier("target", true), isTitle = 1, notCheckable = 1}
  UIDropDownMenu_AddButton(info)
  info = { text = POJ_STRING.ACTIONBAR.TARGETTOSELF, value = "self", notCheckable = 1, func = PoJ_ActionBar_TargetIdent_DropDown_OnClick }
  UIDropDownMenu_AddButton(info)
  local group = PoJ_GetGroupType()
  if group ~= "" then
    group = iif(group == "raid", POJ_STRING.ACTIONBAR.TARGETTORAID, POJ_STRING.ACTIONBAR.TARGETTOPARTY)
    info = { text = POJ_STRING.ACTIONBAR.TARGETTOPARTY, value = "group", notCheckable = 1, func = PoJ_ActionBar_TargetIdent_DropDown_OnClick }
    UIDropDownMenu_AddButton(info)
  end
  if IsInGuild() then
    info = { text = POJ_STRING.ACTIONBAR.TARGETTOGUILD, value = "guild", notCheckable = 1, func = PoJ_ActionBar_TargetIdent_DropDown_OnClick }
    UIDropDownMenu_AddButton(info)
  end
  PlaySound("igMainMenuOpen")
end


function PoJ_ActionBar_TargetIdent_DropDown_OnClick(self)
  if self.value == "group" then
    PoJ_DoAction("targetident", PoJ_GetGroupType())
  elseif self.value == "guild" then
    PoJ_DoAction("targetident", "guild")
  elseif self.value == "self" then
    PoJ_DoAction("targetident", "")
  end
end


function PoJ_ActionBar_SavePos()
  if PoJ_ActionBarFrame.drag then
    PoJ_Vars.ActionBar_x = PoJ_Round(PoJ_ActionBarFrame:GetLeft())
    PoJ_Vars.ActionBar_y = PoJ_Round(PoJ_ActionBarFrame:GetTop())
  end
end


function PoJ_ActionBar_Setup(incombat)
  local button, enabled, icon, tooltip
  
  incombat = incombat or InCombatLockdown()
  
  button = 1
  if PoJ_Vars.ActionBarIdent then
    PoJ.ActionButton[button] = {action = "targetident", enabled = true, icon = "Interface\\Icons\\Spell_Shadow_EvilEye", tooltip = {POJ_STRING.ACTIONBAR.TARGETID, POJ_STRING.ACTIONBAR.TARGETID_TIP}}
    button = button + 1
  end
  if PoJ_Vars.ActionBarDice then
    PoJ.ActionButton[button] = {action = "random", enabled = true, icon = "Interface\\Buttons\\UI-GroupLoot-Dice-Up", tooltip = {POJ_STRING.ACTIONBAR.DICE, POJ_STRING.ACTIONBAR.DICE_TIP}}
    button = button + 1
  end
  if PoJ_Vars.ActionBarNotes then
    PoJ.ActionButton[button] = {action = "notes", enabled = not incombat, icon = "Interface\\MailFrame\\Mail-Icon", tooltip = {POJ_STRING.ACTIONBAR.NOTES, POJ_STRING.ACTIONBAR.NOTES_TIP}}
    button = button + 1
  end
  for i = button, POJ_ACTIONBUTTONCOUNT do
    PoJ.ActionButton[i] = nil
  end
  
  for i = 1, POJ_ACTIONBUTTONCOUNT do
    button = _G["PoJ_ActionBar_Button" .. i]
    if PoJ.ActionButton[i] then
      icon = _G["PoJ_ActionBar_Button" .. i .. "Icon"]
      icon:SetTexture(PoJ.ActionButton[i].icon)
      if PoJ.ActionButton[i].enabled then
        button:Enable()
        icon:SetVertexColor(1, 1, 1)
      else
        button:Disable()
        icon:SetVertexColor(0.4, 0.4, 0.4)
      end
      if not incombat then
        if PoJ.ActionButton[i].spell then
          button:SetAttribute("type", "spell")
          button:SetAttribute("spell", PoJ.ActionButton[i].spell)
        else
          button:SetAttribute("type", nil)
          button:SetAttribute("spell", nil)
        end
      end
      icon:Show()
      button:Show()
    else
      button:Hide()
    end
  end
  
  PoJ_SetActionBarPos()
end


function PoJ_ActionBar_ShowTooltip(self)
  local tooltip = PoJ.ActionButton[self:GetID()].tooltip
  PoJ_ShowBottomtip(GameTooltip, tooltip[1], tooltip[2], tooltip[3])
end


function PoJ_ActionButton_OnLoad(self)
  self:RegisterForDrag("LeftButton")
  _G[self:GetName() .. "Icon"]:SetTexCoord(0.0625, 0.9375, 0.0625, 0.9375)
  self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
end


function PoJ_ActionButton_OnPostClick(self, button)
  local action = PoJ.ActionButton[self:GetID()].action
  self:SetChecked(nil)
end


function PoJ_ActionButton_OnPreClick(self, button)
  local action = PoJ.ActionButton[self:GetID()].action
  
  if action == "targetident" then
    if UnitExists("target") then
      if button == "RightButton" then
        ToggleDropDownMenu(1, nil, PoJ_ActionBar_TargetIdent_DropDown, "PoJ_ActionBarFrame")
      else
        PoJ_DoAction("targetident")
      end
    end
  else
    PoJ_DoAction(action)
  end
end


function PoJ_DoAction(action, var1)
  if type(action) == "number" and PoJ.ActionButton[action] then
    action = PoJ.ActionButton[action].action
  end
  if action == "notes" then
    PoJ_ToggleFrame(PoJ_Notes, true)
  elseif action == "random" then
    RandomRoll("1", "100")
  elseif action == "targetident" then
    local chat = ""
    if var1 then
      chat = var1
    else
      local group = PoJ_GetGroupType()
      if PoJ_Vars.ActionBarIdentRaid and group == "raid" or PoJ_Vars.ActionBarIdentPart and group == "party" then
        chat = group
      end
    end
    local message = PoJ_GetTargetIdentifier("target", chat == "")
    if message and message ~= "" then
      if chat == "" then
        PoJ_Comment(message, true)
      else
        SendChatMessage(">>> " .. message, chat)
      end
    end
  end
end


function PoJ_SetActionBarPos()
  if InCombatLockdown() then 
    return
  end
  local button, col, cols, row
  local colvisible = 0
  local rowvisible = 0
  PoJ_ActionBarFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", PoJ_Vars.ActionBar_x, PoJ_Vars.ActionBar_y)
  if PoJ_Vars.ActionBarRows == 1 then
    cols = 4
  elseif PoJ_Vars.ActionBarRows == 2 then
    cols = 2
  elseif PoJ_Vars.ActionBarRows == 4 then
    cols = 1
  end
  for i = 1, POJ_ACTIONBUTTONCOUNT do
    button = _G["PoJ_ActionBar_Button" .. i]
    col = mod(i - 1, cols) + 1
    row = (i - col) / cols + 1
    if i ~= 1 then
      button:SetPoint("TOPLEFT", "PoJ_ActionBar_Button1", "TOPLEFT", (col - 1) * POJ_ACTIONBUTTONOFFSET, (1 - row) * POJ_ACTIONBUTTONOFFSET)
    end
    if button:IsVisible() then
      colvisible = col
      rowvisible = row
    end
  end
  PoJ_ActionBarFrame:SetWidth (colvisible * POJ_ACTIONBUTTONOFFSET)
  PoJ_ActionBarFrame:SetHeight(rowvisible * POJ_ACTIONBUTTONOFFSET)
end


function PoJ_ShowActionBar()
  PoJ_ShowObject(PoJ_ActionBarFrame, PoJ_Vars.ActionBarShow)
end
