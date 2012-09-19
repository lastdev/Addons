function PoJ_ActivateTab(self)
  PlaySound("igCharacterInfoTab")
  _G["PoJ_OptionsTab" .. PoJ_Options.selectedTab].frame:Hide()
  self.frame:Show()
  PanelTemplates_Tab_OnClick(self, PoJ_Options)
end


function PoJ_CraftList_DropDown_Initialize(self)
  if PoJ_Vars.SkillCooldowns then
    local info
    info = { text = PoJ_Vars.SkillCooldowns[self.index].charname .. " - " .. PoJ_Vars.SkillCooldowns[self.index].skill, isTitle = 1, notCheckable = 1}
    UIDropDownMenu_AddButton(info)
    info = { text = POJ_STRING.WOW.DELETE, value = "delete", arg1 = self.index, notCheckable = 1, func = PoJ_CraftList_DropDown_OnClick }
    UIDropDownMenu_AddButton(info)
    PlaySound("igMainMenuOpen")
  end
end


function PoJ_CraftList_DropDown_OnClick(self)
  if self.value == "delete" then
    table.remove(PoJ_Vars.SkillCooldowns, self.arg1)
  end
end


function PoJ_CraftList_OnLoad(self)
  PoJ_OptionFrame_OnLoad(self)
  local buttonname
  local columnwidths = {}
  FauxScrollFrame_SetOffset(PoJ_CraftListScrollFrame, 0)
  PoJ_UpdateFrame_Prepare(self, 1)
  for j = 1, 5 do
    columnwidths[j] = _G["PoJ_CraftList_Header" .. j]:GetWidth() - 2
  end
  for i = 1, 20 do
    buttonname = "PoJ_CraftListButton" .. i
    for j = 1, 5 do
      _G[buttonname .. "_Column" .. j]:SetWidth(columnwidths[j])
    end
  end
end


function PoJ_CraftList_OnUpdate(self, elapsed)
  self.LastUpdate = self.LastUpdate + elapsed
  if self.LastUpdate > self.UpdateRate then
    PoJ_CraftList_Update()
  end
end


function PoJ_CraftList_SetRemind(index, setremind)
  index = index + FauxScrollFrame_GetOffset(PoJ_CraftListScrollFrame)
  if setremind then
    setremind = true
  end
  PoJ_Vars.SkillCooldowns[index].remind = setremind
end


function PoJ_CraftList_Sort(a, b)
  if a.endtime < b.endtime then
    return true
  elseif a.endtime == b.endtime then
    if a.realm < b.realm then
      return true
    elseif a.realm == b.realm then
      if a.charname < b.charname then
        return true
      elseif a.charname == b.charname then
        return a.skill < b.skill
      end
    end
  end
end


function PoJ_CraftList_Update()
  local button, buttonname, cdcharname, cdrealm, endtime, fontstring, index, samechar
  local charname = UnitName("player")
  local cooldowncount = #PoJ_Vars.SkillCooldowns
  local now = time()
  local offset = FauxScrollFrame_GetOffset(PoJ_CraftListScrollFrame)
  local realm = GetRealmName()
  local showscrollbar = cooldowncount > 20
  for i = 1, 20 do
    buttonname = "PoJ_CraftListButton" .. i
    button = _G[buttonname]
    index = offset + i
    if index > cooldowncount then
      button.index = nil
      button:Hide()
    else
      button.index = index
      cdrealm = PoJ_Vars.SkillCooldowns[index].realm
      fontstring = _G[buttonname .. "_Column1"]
      if cdrealm == realm then
        fontstring:SetTextColor(1, 1, 1)
      else
        fontstring:SetTextColor(0.5, 0.5, 0.5)
      end
      fontstring:SetText(cdrealm)
      cdcharname = PoJ_Vars.SkillCooldowns[index].charname
      fontstring = _G[buttonname .. "_Column2"]
      samechar = cdcharname == charname and cdrealm == realm
      if samechar then
        fontstring:SetTextColor(1, 1, 1)
      else
        fontstring:SetTextColor(0.5, 0.5, 0.5)
      end
      fontstring:SetText(cdcharname)
      fontstring = _G[buttonname .. "_Column3"]
      if samechar then
        fontstring:SetTextColor(1, 1, 1)
      else
        fontstring:SetTextColor(0.5, 0.5, 0.5)
      end
      fontstring:SetText(PoJ_Vars.SkillCooldowns[index].skill)
      _G[buttonname .. "_Column4_Check"]:SetChecked(PoJ_Vars.SkillCooldowns[index].remind)
      endtime = PoJ_Vars.SkillCooldowns[index].endtime
      fontstring = _G[buttonname .. "_Column5"]
      if endtime == 0 then
        fontstring:SetTextColor(0, 1, 0)
        fontstring:SetText(POJ_STRING.OUTPUT.READY)
      elseif endtime > now + 3600 then
        fontstring:SetTextColor(1, 0, 0)
        fontstring:SetText(SecondsToTime(endtime - now))
      elseif endtime > now then
        fontstring:SetTextColor(1, 1, 0)
        fontstring:SetText(SecondsToTime(endtime - now))
      else
        fontstring:SetText()
      end
      button:Show()
    end
  end
  FauxScrollFrame_Update(PoJ_CraftListScrollFrame, cooldowncount, 20, 16)
end


function PoJ_CraftListButton_OnClick(self, button)
  if button == "RightButton" then
    ToggleDropDownMenu(1, nil, PoJ_CraftList_DropDown, self)
  end
end


function PoJ_CraftListHeader_OnLoad(self)
  local id = self:GetID()
  if id == 1 then
    self:SetText(POJ_STRING.CRAFTLIST.REALM)
    --self.sortType = "realm"
    PoJ_CraftListHeader_SetWidth(self, 150)
  elseif id == 2 then
    self:SetText(POJ_STRING.CRAFTLIST.CHARNAME)
    --self.sortType = "char"
    PoJ_CraftListHeader_SetWidth(self, 85)
  elseif id == 3 then
    self:SetText(POJ_STRING.CRAFTLIST.SKILL)
    --self.sortType = "skill"
    PoJ_CraftListHeader_SetWidth(self, 120)
  elseif id == 4 then
    self:SetText(POJ_STRING.OUTPUT.REMIND)
    --self.sortType = "remind"
    PoJ_CraftListHeader_SetWidth(self, 80)
  elseif id == 5 then
    self:SetText(POJ_STRING.CRAFTLIST.COOLDOWN)
    --self.sortType = "cooldown"
    PoJ_CraftListHeader_SetWidth(self, 100)
  end
end


function PoJ_CraftListHeader_SetWidth(frame, width)
	frame:SetWidth(width)
	_G[frame:GetName() .. "Middle"]:SetWidth(width - 9)
end


function PoJ_ErrorSuppressionCheckBox_GetIndex(name)
  local n = string.match(name, "PoJ_CharOpt_ErrorSuppression_Check_Error(%w+)")
  return tonumber(n)
end


function PoJ_ErrorSuppressionCheckBox_OnClick(self)
  PoJ_Option_SetValue(self, iif(self:GetChecked(), true, nil), "ErrSupp_" .. PoJ.ErrorSuppression[PoJ_ErrorSuppressionCheckBox_GetIndex(self:GetName())].name)
  PoJ_SetErrorSuppressions()
end


function PoJ_ErrorSuppressionCheckBox_OnLoad(self)
  local name = self:GetName()
  n = PoJ_ErrorSuppressionCheckBox_GetIndex(name)
  if PoJ.ErrorSuppression[n] then
    local label = _G[name .. "_Label"]
    label:SetText(n)
    label:SetText('"' .. PoJ.ErrorSuppression[n].text .. '"')
    self:Show()
  end
  self.ischaropt = true
end


function PoJ_ErrorSuppressionCheckBox_OnShow(self)
  self:SetChecked(PoJ_Option_GetValue(true, "ErrSupp_" .. PoJ.ErrorSuppression[PoJ_ErrorSuppressionCheckBox_GetIndex(self:GetName())].name))
end


function PoJ_Option_GetValue(ischaropt, ...)
  local opt = iif(ischaropt, PoJ_CVars, PoJ_Vars)
  local vararg = {...}
  for i = 1, #vararg do
    if opt[vararg[i]] == nil then
      return nil
    end
    opt = opt[vararg[i]]
    if i == #vararg then
      return opt
    elseif type(opt) ~= "table" then
      return nil
    end
  end
  return nil
end


function PoJ_Option_SetValue(ischaropt, value, ...)
  local opt = iif(ischaropt, PoJ_CVars, PoJ_Vars)
  local vararg = {...}
  for i = 1, #vararg do
    if i == #vararg then
      opt[vararg[i]] = value
      return true
    else
      if opt[vararg[i]] == nil then
        opt[vararg[i]] = {}
      end
      opt = opt[vararg[i]]
      if type(opt) ~= "table" then
        return false
      end
    end
  end
end


function PoJ_OptionCheckBox_Enable(button, enable)
  local label = _G[button:GetName() .. "_Label"]
  PoJ_EnableButton(button, enable)
  if label then
    PoJ_OptionLabel_Enable(label, enable)
  end
end


function PoJ_OptionCheckBox_EnableSlaves(button)
  local doenable = button:IsEnabled() == 1 and button:GetChecked()
  for _, slave in ipairs(button.slaves) do
    if slave:IsObjectType("CheckButton") then
      PoJ_OptionCheckBox_Enable(slave, doenable)
    elseif slave:IsObjectType("FontString") then
      PoJ_OptionLabel_Enable(slave, doenable)
    end
    if slave.slaves then
      PoJ_OptionCheckBox_EnableSlaves(slave)
    end
  end
end


function PoJ_OptionCheckBox_GetIndex(name, toupper)
  local a, b = string.match(name, "PoJ_(%w+)[_%w]*_Check_(%w+)")
  if toupper then
    a, b = strupper(a), strupper(b)
  end
  return a, b
end


function PoJ_OptionCheckBox_OnClick(self)
  local _, a = PoJ_OptionCheckBox_GetIndex(self:GetName())
  PoJ_Option_SetValue(self.ischaropt, iif(self:GetChecked(), true, nil), a)
  if self.slaves then
    PoJ_OptionCheckBox_EnableSlaves(self)
  end
  if self.func then
    self.func(PoJ_GetTableItemList(self.funcparams))
    if self.func2 then
      self.func2(PoJ_GetTableItemList(self.func2params))
    end
  end
end


function PoJ_OptionCheckBox_OnEnter(self)
  local name = self:GetName()
  local a, b = PoJ_OptionCheckBox_GetIndex(name, true)
  if b then
    b = b .. "_TIP"
  end
  if a and b and POJ_STRING[a] and POJ_STRING[a][b] then
    PoJ_ShowOptionTooltip(self, POJ_STRING[a][b])
  else
    GameTooltip:Hide()
  end
end


function PoJ_OptionCheckBox_OnLoad(self)
  local name = self:GetName()
  local a, b = PoJ_OptionCheckBox_GetIndex(name, true)
  if a then
    if b and POJ_STRING[a] and POJ_STRING[a][b] then
      _G[name .. "_Label"]:SetText(POJ_STRING[a][b])
    else
      _G[name .. "_Label"]:SetText(a .. ", " .. b)
    end
    if a == "CHAROPT" then
      self.ischaropt = true
    end
  end
end


function PoJ_OptionCheckBox_OnShow(self)
  local _, a = PoJ_OptionCheckBox_GetIndex(self:GetName())
  self:SetChecked(PoJ_Option_GetValue(self.ischaropt, a))
  if self.condition then
    PoJ_OptionCheckBox_Enable(self, PoJ_Eval(self.condition))
  end
  if self.slaves then
    PoJ_OptionCheckBox_EnableSlaves(self)
  end
end


function PoJ_OptionFrame_OnLoad(self)
  local name = self:GetName()
  local title = strmatch(name, "PoJ_(%w+)")
  _G[name .. "_Title"]:SetText(POJ_STRING.OPTION[strupper(title)])
  PoJ_Version:SetText("v " .. PoJ.Version)
  self:Hide()
end


function PoJ_OptionFrameBox_OnLoad(self)
  local name = self:GetName()
  local a, b = strmatch(name, "PoJ_(%w+)_(%w+)")
  local string = _G[name .. "_Title"]
  if string then
    a, b = strupper(a), strupper(b) .. "_TITLE"
    if a and b and POJ_STRING[a] and POJ_STRING[a][b] then
      string:SetText(POJ_STRING[a][b])
    else
      string:SetText("[" .. name .. "]")
    end
  end
  self:SetBackdropBorderColor(0.4, 0.4, 0.4)
  self:SetBackdropColor(0.15, 0.15, 0.15)
end


function PoJ_OptionLabel_Enable(label, enable)
  if enable then
    label:SetTextColor(1, 0.82, 0)
  else
    label:SetTextColor(0.5, 0.5, 0.5)
  end
end


function PoJ_OptionRadioButton_GetIndex(name, toupper)
  local a, b, c = string.match(name, "PoJ_(%w+)[_%w]*_Option_(%w+)_(%w+)")
  if toupper then
    a, b, c = strupper(a), strupper(b), strupper(c)
  end
  return a, b, c
end


function PoJ_OptionRadioButton_OnClick(self)
  local _, a, b = PoJ_OptionRadioButton_GetIndex(self:GetName())
  if not self:GetChecked() then
    self:SetChecked(true)
  end
  PoJ_Option_SetValue(self.ischaropt, self:GetID(), a)
  for index, button in pairs(self:GetParent().radiogroups[a]) do
    if index ~= b then
      button:SetChecked(nil)
    end
  end
  if self.func then
    self.func(PoJ_GetTableItemList(self.funcparams))
  end
end


function PoJ_OptionRadioButton_OnEnter(self)
  local name = self:GetName()
  local a, b, c = PoJ_OptionRadioButton_GetIndex(name, true)
  c = c .. "_TIP"
  if a and b and c and POJ_STRING[a] and POJ_STRING[a][b] and POJ_STRING[a][b][c] then
    PoJ_ShowOptionTooltip(self, POJ_STRING[a][b][c])
  else
    GameTooltip:Hide()
  end
end


function PoJ_OptionRadioButton_OnLoad(self)
  local name = self:GetName()
  _G[name .. "_DisabledCheckedTexture"]:SetDesaturated(1)
  local a, b, c = PoJ_OptionRadioButton_GetIndex(name, true)
  if a then
    if b and c and POJ_STRING[a] and POJ_STRING[a][b] and POJ_STRING[a][b][c] then
      _G[name .. "_Label"]:SetText(POJ_STRING[a][b][c])
    else
      _G[name .. "_Label"]:SetText("label not found: " .. a .. ", " .. b .. ", " .. c)
    end
    if a == "CHAROPT" then
      self.ischaropt = true
    end
  end
  
  local _
  local parent = self:GetParent()
  _, b, c = PoJ_OptionRadioButton_GetIndex(name)
  if b and c then
    if not parent.radiogroups then
      parent.radiogroups = {}
    end
    if not parent.radiogroups[b] then
      parent.radiogroups[b] = {}
    end
    parent.radiogroups[b][c] = self
  end
end


function PoJ_OptionRadioButton_OnShow(self)
  local _, a, _ = PoJ_OptionRadioButton_GetIndex(self:GetName())
  if PoJ_Option_GetValue(self.ischaropt, a) == tonumber(self:GetID()) then
    self:SetChecked(true)
  end
end


function PoJ_Options_OnLoad(self)
  local c
  
  PoJ_UpdateFrame_Prepare(PoJ_Options)
  PanelTemplates_SetNumTabs(self, 6)
  PanelTemplates_SetTab(self, 1)
  PoJ_OptionsTab1.frame = PoJ_WoWUIOpt
  PoJ_OptionsTab2.frame = PoJ_PoJUIOpt
  PoJ_OptionsTab3.frame = PoJ_Messages
  PoJ_OptionsTab4.frame = PoJ_WorldOpt
  PoJ_OptionsTab5.frame = PoJ_CharOpt
  PoJ_OptionsTab6.frame = PoJ_Craft
  PoJ_OptionsTab1:SetText(POJ_STRING.OPTION.WOWUIOPT_TAB)
  PoJ_OptionsTab2:SetText(POJ_STRING.OPTION.POJUIOPT_TAB)
  PoJ_OptionsTab3:SetText(POJ_STRING.OPTION.MESSAGES_TAB)
  PoJ_OptionsTab4:SetText(POJ_STRING.OPTION.WORLDOPT_TAB)
  PoJ_OptionsTab5:SetText(POJ_STRING.OPTION.CHAROPT_TAB)
  PoJ_OptionsTab6:SetText(POJ_STRING.OPTION.CRAFT_TAB)
  PoJ_OptionsTab1.frame:Show()
  
  PoJ_WoWUIOpt_Targets_Check_StatusSmallFont.func   = PoJ_SetStatusBarFont
  PoJ_WoWUIOpt_Targets_Check_StatusShowAll.func     = PoJ_UpdateStatusBars
  PoJ_WoWUIOpt_Targets_Check_TargetColors.func      = PoJ_SetTargetNameColors
  PoJ_WoWUIOpt_QuestLog_Check_QuestLevels.func      = QuestLog_Update
  PoJ_WoWUIOpt_Chat_Check_ChatDouble.func           = PoJ_SetDoubleChatEditWidth
  PoJ_WoWUIOpt_Chat_Check_ChatTimeStamp.func        = PoJ_ModifyTimeStamp
  PoJ_WoWUIOpt_Chat_Check_HideChannelJoins.func     = PoJ_SetChatChannelJoins
  PoJ_WoWUIOpt_Raid_Check_ShowRaidGroup.func        = PoJ_ShowRaidGroup
  PoJ_WoWUIOpt_Menubar_Check_NoMenuDeco.func        = PoJ_ShowMenuDeco
  PoJ_WoWUIOpt_Menubar_Check_NoMacroNames.func      = PoJ_UpdateAllActionButtons
  PoJ_WoWUIOpt_Menubar_Label_ShowAction:SetText(POJ_STRING.WOWUIOPT.SHOWACTION .. ":")
  c = PoJ.ActionbarTimeColors.cooldown
  PoJ_WoWUIOpt_Menubar_Check_ShowActionCD_Label:SetTextColor(c.r, c.g, c.b)
  c = PoJ.ActionbarTimeColors.debuff
  PoJ_WoWUIOpt_Menubar_Check_ShowActionOT_Label:SetTextColor(c.r, c.g, c.b)
  c = PoJ.ActionbarTimeColors.buff
  PoJ_WoWUIOpt_Menubar_Check_ShowActionBD_Label:SetTextColor(c.r, c.g, c.b)
  
  PoJ_PoJUIOpt_Minimap_Check_MinimapIcon.func     = PoJ_ShowMinimapIcon
  PoJ_PoJUIOpt_ActionBar_Check_ActionBarShow.func = PoJ_ShowActionBar
  PoJ_PoJUIOpt_ActionBar_Check_ActionBarShow.slaves = {
    PoJ_PoJUIOpt_ActionBar_Option_ActionBarRows_1,
    PoJ_PoJUIOpt_ActionBar_Option_ActionBarRows_2,
    PoJ_PoJUIOpt_ActionBar_Option_ActionBarRows_4,
    PoJ_PoJUIOpt_ActionBar_Check_ActionBarIdent,
    PoJ_PoJUIOpt_ActionBar_Check_ActionBarDice,
    PoJ_PoJUIOpt_ActionBar_Check_ActionBarNotes,
  }
  PoJ_PoJUIOpt_ActionBar_Option_ActionBarRows_1.func = PoJ_SetActionBarPos
  PoJ_PoJUIOpt_ActionBar_Option_ActionBarRows_2.func = PoJ_SetActionBarPos
  PoJ_PoJUIOpt_ActionBar_Option_ActionBarRows_4.func = PoJ_SetActionBarPos
  PoJ_PoJUIOpt_ActionBar_Check_ActionBarIdent.func   = PoJ_ActionBar_Setup
  PoJ_PoJUIOpt_ActionBar_Check_ActionBarIdent.slaves = {
    PoJ_PoJUIOpt_ActionBar_Check_ActionBarIdentPart,
    PoJ_PoJUIOpt_ActionBar_Check_ActionBarIdentRaid,
  }
  PoJ_PoJUIOpt_ActionBar_Check_ActionBarDice.func   = PoJ_ActionBar_Setup
  PoJ_PoJUIOpt_ActionBar_Check_ActionBarNotes.func  = PoJ_ActionBar_Setup
  PoJ_PoJUIOpt_Gems_Check_GemCounterShow.func       = PoJ_ShowGemCounter
  PoJ_PoJUIOpt_Coord_Check_CoordShow.func           = PoJ_ShowCoords
  PoJ_PoJUIOpt_Coord_Check_CoordShowMap.func        = PoJ_ShowCoords_Map
  PoJ_PoJUIOpt_PvE_Check_RaidIcons.func             = PoJ_UpdateTargetIcons
  PoJ_PoJUIOpt_PvP_Check_PvPClasses.func            = PoJ_UpdateTargetClass
  
  PoJ_Messages_Remind_Edit_RemindInterval_LeftText:SetText(POJ_STRING.MESSAGES.REMINDINTERVAL_LEFT)
  PoJ_Messages_Remind_Edit_RemindInterval_RightText:SetText(POJ_STRING.OUTPUT.MINUTES)
  PoJ_Messages_General_Check_ShowLevelUps.slaves = {PoJ_Messages_General_Check_GratsOnLevelUp}
  PoJ_Messages_Remind_Check_RemindItems.func     = PoJ_ItemRemind
  
  PoJ_CharOpt_Char_Check_DuelIgnore.slaves = {
    PoJ_CharOpt_Char_Check_DuelFriends,
    PoJ_CharOpt_Char_Check_DuelGuild,
    PoJ_CharOpt_Char_Check_DuelGroup,
  }
  PoJ_CharOpt_Hunter_Check_AspectActivation.text = "ASPECTACTIVATION"
  PoJ_CharOpt_Hunter_Check_AspectActivation_Label:SetText(POJ_STRING.CHAROPT.ASPECTACTIVATION)
  
  local height = 20 * #PoJ.ErrorSuppression + 50
  PoJ_CharOpt_ErrorSuppression:SetHeight(height)
  local frame = _G["PoJ_CharOpt_" .. PoJ.ClassString]
  if frame then
    PoJ_CharOpt_ErrorSuppression:SetWidth(PoJ_CharOpt_ErrorSuppression:GetWidth() - frame:GetWidth() - 3)
    frame:SetHeight(height)
    frame:Show()
  end
  
  PoJ.OptionsLoaded = true
  
end


function PoJ_Options_OnUpdate(self, elapsed)
  PoJ_UpdateFrame_Update(self, elapsed, PoJ_Clock, PoJ_GetGameTimeString)
end


function PoJ_OptionSlider_OnLoad(self)
  local name = self:GetName()
  local a = strupper(string.match(name, "PoJ_Slider_(%w+)"))
  if a then
    if POJ_STRING.SLIDER[a] then
      _G[name .. "Text"]:SetText(POJ_STRING.SLIDER[a])
    end
    if POJ_STRING.SLIDER[a .. "_HIGH"] then
      _G[name .. "High"]:SetText(POJ_STRING.SLIDER[a .. "_HIGH"])
    end
    if POJ_STRING.SLIDER[a .. "_LOW"] then
      _G[name .. "Low"]:SetText(POJ_STRING.SLIDER[a .. "_LOW"])
    end
  end
end


function PoJ_PlayerNames_OnClick(self)
  local a, b = string.match(self:GetName(), "PoJ_WorldOpt_PlayerNames_Check_(%w+)_(%w+)")
  PoJ_Option_SetValue(nil, iif(self:GetChecked(), true, nil), "PlayerNamesShow", a, b)
  PoJ_SetPlayerNamesVisibility(true)
end


function PoJ_PlayerNames_OnLoad(self)
  local obj
  local master = PoJ_WorldOpt_PlayerNames_Check_PlayerNames
  PoJ_OptionFrameBox_OnLoad(self)
  self.wholabels = {"Rank", "Guild", "Self", "Play", "Pets", "Guar", "Tot", "Comp", "NPCs"}
  self.who = {"Rank", "Guild", "GTit", "Self", "PlayF", "PlayE", "PetsF", "PetsE", "GuarF", "GuarE", "TotF", "TotE", "Comp", "NPCs"}
  self.where = {"City", "Inst", "In10", "In40", "Raid", "BG", "NoUI", "Norm"}
  master.func = PoJ_SetPlayerNamesVisibility
  master.funcparams = {true}
  master.slaves = {}
  for _, c in ipairs(self.wholabels) do
    obj = _G["PoJ_WorldOpt_PlayerNames_" .. c]
    obj:SetText(POJ_STRING.WORLDOPT["PLAYERNAMES_" .. strupper(c)])
    table.insert(master.slaves, obj)
  end
  for _, d in ipairs(self.where) do
    obj = _G["PoJ_WorldOpt_PlayerNames_" .. d]
    obj:SetText(POJ_STRING.WORLDOPT["PLAYERNAMES_" .. strupper(d)])
    table.insert(master.slaves, obj)
  end
  for _, c in ipairs(self.who) do
    for _, d in ipairs(self.where) do
      table.insert(master.slaves, _G["PoJ_WorldOpt_PlayerNames_Check_" .. c .. "_" .. d])
    end
  end
end


function PoJ_PlayerNames_OnShow(self)
  for _, c in ipairs(self.who) do
    for _, d in ipairs(self.where) do
      _G["PoJ_WorldOpt_PlayerNames_Check_" .. c .. "_" .. d]:SetChecked(PoJ_Option_GetValue(nil, "PlayerNamesShow", c, d))
    end
  end
  PoJ_SetPlayerNamesVisibility()
end


function PoJ_PlayerNames_SetColors(index)
  for _, d in ipairs(PoJ_WorldOpt_PlayerNames.where) do
    if d == index then
      _G["PoJ_WorldOpt_PlayerNames_" .. d]:SetTextColor(0.7, 0.85, 1)
    else
      _G["PoJ_WorldOpt_PlayerNames_" .. d]:SetTextColor(1, 0.82, 0)
    end
  end
end


function PoJ_SetMenuBarPos(x)
  if x then
    PoJ_Vars.MenuBarPos = x
  end
  PoJ.SettingMainMenuBarPosition = true
  MainMenuBar:SetPoint("BOTTOM", "UIParent", "BOTTOM", PoJ_Vars.MenuBarPos, 0)
  PoJ.SettingMainMenuBarPosition = nil
end


function PoJ_SetupSlider(slider, minvalue, maxvalue, step, value)
  slider:SetMinMaxValues(minvalue, maxvalue)
  slider:SetValueStep(step)
  slider:SetValue(value)
end


function PoJ_ShowOptionTooltip(self, tooltip)
  if tooltip then
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(tooltip)
  else
    GameTooltip:Hide()
  end
end


function PoJ_ShowRaidGroup()
  PoJ_SetUnitName(PlayerName, "player")
  PoJ_SetUnitName(TargetFrameTextureFrameName, "target")
  PlayerFrame_UpdateGroupIndicator()
end
