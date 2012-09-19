-- UI FUNCTIONS --

function PoJ_CreateActionButtonLabel(button)
  local string
  if button then
    buttonname = button:GetName()
    stringname = buttonname .. "PojText"
    if not _G[stringname] then
      string = button:CreateFontString(stringname, "OVERLAY", "NumberFontNormal")
      string:SetPoint(_G[buttonname .. "Count"]:GetPoint(1))
      string:SetJustifyH("RIGHT")
      table.insert(PoJ.WoWActionButtons, button)
    end
  end
end


function PoJ_Drag_Start(object, condition)
  if condition then
    object.drag = true
    object:StartMoving()
  end
end


function PoJ_Drag_Stop(object)
  object.drag = nil
  object:StopMovingOrSizing()
end


function PoJ_EnableButton(button, enable)
  if enable then
    button:Enable()
  else
    button:Disable()
  end
end


function PoJ_GemCounter_Update()
  if PoJ_GemCounter:IsVisible() then
    local red, yellow, blue, mega = PoJ_GetGemColorCount()
    PoJ_GemCounter_RedCount:SetText(red)
    PoJ_GemCounter_YellowCount:SetText(yellow)
    PoJ_GemCounter_BlueCount:SetText(blue)
    PoJ_GemCounter_MegaCount:SetText(mega)
    local showmega = mega > 0
    local show = showmega or red > 0 or yellow > 0 or blue > 0
    PoJ_ShowObject(PoJ_GemCounter_Red, show)
    PoJ_ShowObject(PoJ_GemCounter_RedCount, show)
    PoJ_ShowObject(PoJ_GemCounter_Yellow, show)
    PoJ_ShowObject(PoJ_GemCounter_YellowCount, show)
    PoJ_ShowObject(PoJ_GemCounter_Blue, show)
    PoJ_ShowObject(PoJ_GemCounter_BlueCount, show)
    PoJ_ShowObject(PoJ_GemCounter_Mega, showmega)
    PoJ_ShowObject(PoJ_GemCounter_MegaCount, showmega)
  end
end


function PoJ_GetFaintColor(color)
  local faintcolor = {}
  faintcolor.r = 1 - (1 - color.r) / 2
  faintcolor.g = 1 - (1 - color.g) / 2
  faintcolor.b = 1 - (1 - color.b) / 2
  return faintcolor
end


function PoJ_GetResolution()
  local width, height = string.match(GetCVar("gxResolution"), "(%d+)x(%d+)")
  return {width = tonumber(width), height = tonumber(height)}
end


function PoJ_MinimapIcon_SetTooltip()
  PoJ_ShowTooltip(PoJ_Minimap_Icon, "Piece of Justice")
end


function PoJ_MinimapIcon_Update(self)
  if self.drag then
    local d_min = 77
    local m_x = -53
    local m_y = -56
    local scale = UIParent:GetScale()
    local x, y = GetCursorPosition()
    x = PoJ_Round(x / scale - Minimap:GetRight()) + 18
    y = PoJ_Round(y / scale - Minimap:GetTop()) + 14
    local vec_x = x - m_x
    local vec_y = y - m_y
    local d = sqrt(vec_x^2 + vec_y^2)
    if d <= d_min then
      local f = d_min / d
      x = PoJ_Round(m_x + vec_x * f)
      y = PoJ_Round(m_y + vec_y * f)
    end
    PoJ_SetMinimapIconPos(x, y)
  end
end


function PoJ_SetDoubleChatEditWidth()
  if PoJ_Vars.ChatDouble then
    ChatFrame1EditBox:SetPoint("TOPRIGHT", "UIParent", "RIGHT", -ChatFrame1:GetLeft(), 0)
  else
    ChatFrame1EditBox:SetPoint("TOPRIGHT", "ChatFrame1", "BOTTOMRIGHT", 5, -2)
  end
end


function PoJ_SetFontColor(fontstring, enable)
  if enable then
    fontstring:SetTextColor(1, 0.8, 0, 1)
  else
    fontstring:SetTextColor(0.5, 0.5, 0.5, 1)
  end
end


function PoJ_SetMinimapIconPos(x, y)
  PoJ_Vars.Minimap_x = x
  PoJ_Vars.Minimap_y = y
  PoJ_Minimap_Icon:SetPoint("TOPRIGHT", "Minimap", "TOPRIGHT", x, y)
end


function PoJ_SetStatusBarFont()
  local font, fontsize, fontsizepet
  if PoJ_Vars.StatusSmallFont then
    font = "Fonts\\ARIALN.TTF"
    fontsize = 10
    fontsizepet = 9
  else
    font = "Fonts\\FRIZQT__.TTF"
    fontsize = 14
    fontsizepet = 14
  end
  local fontflag = "outline"
  PlayerFrameHealthBarText:SetFont(font, fontsize, fontflag)
  PlayerFrameManaBarText:SetFont(font, fontsize, fontflag)
  PlayerFrameAlternateManaBarText:SetFont(font, fontsize, fontflag)
  TargetFrameTextureFrameHealthBarText:SetFont(font, fontsize, fontflag)
  TargetFrameTextureFrameManaBarText:SetFont(font, fontsize, fontflag)
  FocusFrameTextureFrameHealthBarText:SetFont(font, fontsize, fontflag)
  FocusFrameTextureFrameManaBarText:SetFont(font, fontsize, fontflag)
  for i = 1, 4 do
    _G["PartyMemberFrame" .. i .. "HealthBarText"]:SetFont(font, fontsize, fontflag)
    _G["PartyMemberFrame" .. i .. "ManaBarText"]:SetFont(font, fontsize, fontflag)
  end
  PetFrameHealthBarText:SetFont(font, fontsizepet, fontflag)
  PetFrameManaBarText:SetFont(font, fontsizepet, fontflag)
  PetFrameManaBarText:SetPoint("CENTER", "PetFrame", "TOPLEFT", 82, iif(PoJ_Vars.StatusSmallFont, -36, -38))
end


function PoJ_ShowBottomtip(tooltip, head, text, errortext)
  local parent = UIParent
  local show = false
  tooltip:ClearLines()
  tooltip:ClearAllPoints()
  if not parent or not parent:IsVisible() then
    parent = UIParent
  end
  GameTooltip_SetDefaultAnchor(tooltip, parent)
  if head and head ~= "" then
    tooltip:AddLine(head, 1, 1, 1, 1)
    show = true
  end
  if errortext and errortext ~= "" then
    tooltip:AddLine(errortext, 1, 0, 0, 1)
    show = true
  end
  if text and text ~= "" then
    tooltip:AddLine(text, 1, 0.82, 0, 1)
    show = true
  end
  if show then
    tooltip:Show()
  end
end


function PoJ_ShowGemCounter()
  PoJ_ShowObject(PoJ_GemCounter, PoJ_Vars.GemCounterShow)
end


function PoJ_ShowMenuDeco()
  PoJ_ShowObject(MainMenuBarLeftEndCap , not PoJ_Vars.NoMenuDeco)
  PoJ_ShowObject(MainMenuBarRightEndCap, not PoJ_Vars.NoMenuDeco)
end


function PoJ_ShowMinimapIcon()
  PoJ_ShowObject(PoJ_Minimap_Icon, PoJ_Vars.MinimapIcon)
end


function PoJ_ShowObject(object, show)
  if show then
    object:Show()
  else
    object:Hide()
  end
end


function PoJ_ShowTooltip(self, head, text)
  local objectname = self:GetName()
  GameTooltip:SetOwner(_G[objectname], "ANCHOR_TOP")
  GameTooltip:ClearLines()
  GameTooltip:ClearAllPoints()
  GameTooltip:SetPoint("TOPRIGHT", objectname, "BOTTOMRIGHT", -2, 2)
  if head and head ~= "" then
    GameTooltip:AddLine(head)
  end
  if text and text ~= "" then
    GameTooltip:AddLine(text, 1, 1, 1, 1)
  end
  GameTooltip:Show()
end


function PoJ_TargetIconButton_OnClick(self, button)
  local index = self:GetID()
  self:SetChecked(false)
  if GetRaidTargetIndex("target") == index then
    index = 0
  end
  SetRaidTarget("target", index)
end

function PoJ_TargetIconButton_OnLoad(self)
  local texture = _G[self:GetName() .. "Icon"]
  texture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
  SetRaidTargetIconTexture(texture, self:GetID())
  self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
end


function PoJ_ToggleFrame(frame, uiframe)
  if frame:IsVisible() then
    if uiframe and not InCombatLockdown() then
      HideUIPanel(frame)
    else
      frame:Hide()
    end
  elseif not InCombatLockdown() then
    if uiframe then
      ShowUIPanel(frame)
    else
      frame:Show()
    end
  end
end


function PoJ_UpdateAllActionButtons()
  for _, button in ipairs(PoJ.WoWActionButtons) do
    ActionButton_Update(button)
  end
end


function PoJ_UpdateActionButtonMacroName(button)
	local macroname = _G[button:GetName().."Name"]
  if macroname then
    if not PoJ_Vars.NoMacroNames and not IsConsumableAction(button.action) and not IsStackableAction(button.action) then
      macroname:SetText(GetActionText(button.action))
    else
      macroname:SetText("")
    end
  end
  PoJ_CreateActionButtonLabel(button)
end


function PoJ_UpdateStatusBars()
  TextStatusBar_UpdateTextString(PlayerFrameHealthBar)
  TextStatusBar_UpdateTextString(PlayerFrameManaBar)
  TextStatusBar_UpdateTextString(TargetFrameHealthBar)
  TextStatusBar_UpdateTextString(TargetFrameManaBar)
  TextStatusBar_UpdateTextString(FocusFrameHealthBar)
  TextStatusBar_UpdateTextString(FocusFrameManaBar)
end


function PoJ_UpdateTargetClass()
  PoJ_TargetClassName:Hide()
  if PoJ_Vars.PvPClasses and UnitExists("target") and UnitIsPlayer("target") and UnitIsEnemy("target", "player") then
    local locclass = UnitClass("target")
    for class, classname in pairs(POJ_STRING.CLASS) do
      if classname == locclass then
        local color = PoJ_GetFaintColor(RAID_CLASS_COLORS[class])
        PoJ_TargetClassNameText:SetText(locclass)
        PoJ_TargetClassNameText:SetTextColor(color.r, color.g, color.b)
        PoJ_TargetClassName:Show()
      end
    end
  end
end


function PoJ_UpdateTargetIcons()
  PoJ_ShowObject(PoJ_TargetIcons, PoJ_Vars.RaidIcons and UnitExists("target") and (UnitIsFriend("target", "player") or not UnitIsPlayer("target")) --[[and (PoJ_GetGroupType() == "party" or IsRaidLeader() or IsRaidOfficer())]])
end


function PoJ_UpdateWoWActionButtons()
  if PoJ_Vars.ButtonCooldownsShown or PoJ_Vars.ShowActionCD or PoJ_Vars.ShowActionOT or PoJ_Vars.ShowActionBD then
    local shown
    for _, button in ipairs(PoJ.WoWActionButtons) do
      shown = PoJ_WoWActionButtonUpdate(button) or shown
    end
    PoJ_Vars.ButtonCooldownsShown = shown
  end
end


function PoJ_WoWActionButtonUpdate(button)
  if button and button:IsVisible() then
    local hasCount = IsConsumableAction(button.action) or IsStackableAction(button.action)
    local maxtime = 0
    local maxtype
    local showtime, timetype
    if not hasCount and (PoJ_Vars.ShowActionCD or PoJ_Vars.ShowActionOT or PoJ_Vars.ShowActionBD) then
      local action = button.action
      if PoJ_Vars.ShowActionCD then
        local start, duration, enable = GetActionCooldown(action)
        if start > 0 and duration > 2 then
          showtime = PoJ_GetCooldownEndTime(start, duration) - GetTime()
          if showtime > 0 then
            maxtime = showtime
            maxtype = "cooldown"
          end
        end
      end
      if PoJ_Vars.ShowActionOT or PoJ_Vars.ShowActionBD then
        local _, casttime, duration, spellname
        local spelltype, spellid, subtype = GetActionInfo(action)
        showtime = nil
        if spelltype == BOOKTYPE_SPELL then
          spellname, _, _, _, _, _, casttime = GetSpellInfo(spellid)
        elseif spelltype == "macro" and spellid then
          local text = GetMacroBody(spellid)
          if text then
            text = strmatch(text, "#showtooltip +([^%c]+)%c")
            if text then
              spellname, _, _, _, _, _, casttime = GetSpellInfo(text)
            end
          end
        end
        if spellname then
          if PoJ_Vars.ShowActionOT and UnitCanAttack("player", "target") then
            local debuff = PoJ_GetDebuffName(spellname)
            showtime, duration = PoJ_GetDebuffTimeLeft("target", debuff, true)
            if showtime then
              if casttime < 0 then
                casttime = 0
              end
              showtime = showtime - casttime / 1000
              timetype = "debuff"
              if showtime > 0 and (not maxtype or showtime > maxtime) then
                maxtime = showtime
                maxtype = timetype
              end
            end
          end
          if PoJ_Vars.ShowActionBD and not (IsConsumableAction(action) or IsStackableAction(action)) then
            local unit = "player"
            if ActionHasRange(action) and UnitCanAssist("player", "target") then
              unit = "target"
            end
            local buff = PoJ_GetBuffName(spellname)
            showtime, duration = PoJ_GetBuffTimeLeft(unit, buff, true)
            if showtime and showtime > 0 then
              maxtime = showtime
              maxtype = "buff"
            end
          end
        end
      end
    end
    local showmacrodot = not maxtype and PoJ_Vars.NoMacroNames and not hasCount and GetActionText(button.action)
    local string = _G[button:GetName() .. "PojText"]
    if string then
      if maxtype then
        local color = PoJ.ActionbarTimeColors[maxtype]
        string:SetTextColor(color.r, color.g, color.b)
        string:SetText(PoJ_GetTimeString(maxtime, true))
        string:Show()
        return true
      elseif showmacrodot then
        string:SetTextColor(1, 1, 1)
        string:SetText(".")
        string:Show()
      else
        string:Hide()
      end
    end
  end
end


function PoJ_WoWAuraButtonUpdateDuration(button, seconds)
  if PoJ_Vars.BuffDuration and button.duration:IsVisible() then
    button.duration:SetFormattedText(PoJ_GetTimeString(seconds));
  end
end
