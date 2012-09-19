function PoJ_SetHooks()
  PoJ_SetHook_ActionButton_Update()
  PoJ_SetHook_AuraButton_UpdateDuration()
  PoJ_SetHook_CancelUnitBuff()
  PoJ_SetHook_ContainerFrame_UpdateCooldown()
  PoJ_SetHook_ERRORMESSAGE()
  PoJ_SetHook_InterfaceOptionsSocialPanelTimestamps_SetValue()
  PoJ_SetHook_MainMenuBar_SetPoint()
  PoJ_SetHook_PlayerFrame_UpdateGroupIndicator()
  PoJ_SetHook_QuestInfo_Display()
  PoJ_SetHook_QuestLog_Update()
  PoJ_SetHook_StaticPopup_Show()
  PoJ_SetHook_ToggleFrame()
  PoJ_SetHook_UIParent_ShowHide()
  PoJ_SetHook_UnitFrame_Update()
  PoJ_SetHook_TextStatusBar_UpdateTextString()
  PoJ_SetHook_WorldMap_ToggleSize()
end


function PoJ_SetHook_ActionButton_Update()
  hooksecurefunc(
    "ActionButton_Update",
    PoJ_UpdateActionButtonMacroName
  )
end


function PoJ_SetHook_AuraButton_UpdateDuration()
  hooksecurefunc(
    "AuraButton_UpdateDuration",
    PoJ_WoWAuraButtonUpdateDuration
  )
end


function PoJ_SetHook_CancelUnitBuff()
  hooksecurefunc(
    "CancelUnitBuff",
    function(unit, index, mine)
      if unit == "player" then
        PoJ.LastCancelledBuffName = UnitBuff("player", index, mine)
        PoJ.LastCancelledBuffTime = GetTime()
      end
    end
  )
end


function PoJ_SetHook_ContainerFrame_UpdateCooldown()
  hooksecurefunc(
    "ContainerFrame_UpdateCooldown",
    function(container, button)
      local link = GetContainerItemLink(container, button:GetID())
      local itemid, name = PoJ_GetItemInfoFromLink(link)
      if itemid then
        local cooldown, duration, enable, start
        local systime = GetTime()
        for _, id in ipairs(PoJ.SkillCooldownItems) do
          if id == itemid then
            start, duration, enable = GetItemCooldown(id)
            if start <= systime then
              if start > 0 then
                cooldown = PoJ_GetCooldownEndTime(start, duration) - systime
              else
                cooldown = nil
              end
              PoJ_SaveCraftCooldown(nil, nil, name, cooldown)
            end
          end
        end
      end
    end
  )
end


function PoJ_SetHook_ERRORMESSAGE()
  local _ERRORMESSAGE_default = geterrorhandler()
  
  function PoJ_ErrorHandler(message)
    if PoJ_Vars.ErrorsToChat then
      local now = time()
      if message ~= PoJ.LastScriptError or message == PoJ.LastScriptError and now > PoJ.LastScriptErrorTime + 10 then
        PoJ_Write("|cffff0000" .. message .. "|r")
        PoJ.LastScriptErrorTime = now
      end
      PoJ.LastScriptError = message
    else
      _ERRORMESSAGE_default(message)
    end
  end
  
  seterrorhandler(PoJ_ErrorHandler)
end


function PoJ_SetHook_InterfaceOptionsSocialPanelTimestamps_SetValue()
  hooksecurefunc(
    InterfaceOptionsSocialPanelTimestamps,
    "SetValue",
    function(value)
      PoJ_ModifyTimeStamp()
    end
  )
end


function PoJ_SetHook_MainMenuBar_SetPoint()
  hooksecurefunc(
    MainMenuBar,
    "SetPoint",
    function(anchor, frame, relative, x, y)
      if PoJ.SettingMainMenuBarPosition ~= true then
        if InCombatLockdown() == nil then
          PoJ_SetMenuBarPos()
        end
      end
    end
  )
end


function PoJ_SetHook_PlayerFrame_UpdateGroupIndicator()
  local PlayerFrame_UpdateGroupIndicator_default = PlayerFrame_UpdateGroupIndicator
  
  function PlayerFrame_UpdateGroupIndicator()
    if PoJ_Vars.ShowRaidGroup or not UnitInRaid("player") then
      if PlayerFrameGroupIndicator:IsShown() then
        PlayerFrameGroupIndicator:Hide()
      end
    else
      PlayerFrame_UpdateGroupIndicator_default()
    end
  end
  
end


function PoJ_SetHook_QuestInfo_Display()
  hooksecurefunc(
    "QuestInfo_Display",
    function()
      if not InCombatLockdown() and PoJ_Vars.SelectMaxPrice and not QuestInfoFrame.questLog and QuestInfoRewardsFrame:IsVisible() then
        local maxPrice = 0
        local maxPriceIndex = 0
        for i = 1, GetNumQuestChoices() do
          item = GetQuestItemLink("choice", i)
          if item then
            local _, _, _, _, _, _, _, _, _, _, price = GetItemInfo(item)
            if price > maxPrice then
              maxPrice = price
              maxPriceIndex = i
            end
          else
            break
          end
        end
        if maxPriceIndex > 0 then
          QuestInfoItem_OnClick(_G["QuestInfoItem" .. maxPriceIndex])
        end
      end
    end
  )
end


function PoJ_SetHook_QuestLog_Update()
  hooksecurefunc(
    "QuestLog_UpdateQuestCount",
    function()
      if InCombatLockdown() == nil and PoJ_Vars.QuestLevels and PoJ.ENABLE_COLORBLIND_MODE == nil then
         PoJ.ENABLE_COLORBLIND_MODE = ENABLE_COLORBLIND_MODE
         ENABLE_COLORBLIND_MODE = "1"
      end
    end
  )
  
  hooksecurefunc(
    "QuestLogControlPanel_UpdateState",
    function()
      if InCombatLockdown() == nil and PoJ_Vars.QuestLevels and PoJ.ENABLE_COLORBLIND_MODE then
         ENABLE_COLORBLIND_MODE = PoJ.ENABLE_COLORBLIND_MODE
         PoJ.ENABLE_COLORBLIND_MODE = nil
      end
    end
  )
end


function PoJ_SetHook_StaticPopup_Show()
  hooksecurefunc(
    "StaticPopup_Show",
    function(which, text_arg1, text_arg2, data)
      if which == "ADDON_ACTION_FORBIDDEN" or which == "HELP_TICKET_QUEUE_DISABLED" or which == "MACRO_ACTION_FORBIDDEN" then
        if PoJ_Vars.ErrorsToChat then
          PoJ_Write("|cffff0000" .. format(StaticPopupDialogs[which].text, text_arg1, text_arg2) .. "|r")
          StaticPopup_Hide(which)
        end
      elseif which == "DUEL_REQUESTED" then
        if PoJ_CVars.DuelIgnore and not (PoJ_CVars.DuelFriends and PoJ_IsFriend(arg1) or PoJ_CVars.DuelGroup and PoJ_IsInGroup(arg1) or PoJ_CVars.DuelGuild and PoJ_IsInGuild(arg1)) then
          StaticPopup_Hide(which)
          CancelDuel()
          PoJ_Comment(format(POJ_STRING.OUTPUT.DUELREJECT, text_arg1))
        end
      end
    end
  )
end


function PoJ_SetHook_ToggleFrame()
  hooksecurefunc(
    "ToggleFrame",
    function(frame)
      if frame == WorldMapFrame and not WorldMapFrame:IsVisible() then
        PoJ_SetPlayerNamesVisibility()
      end
    end
  )
end


function PoJ_SetHook_TradeSkillFrame_SetSelection()
  hooksecurefunc(
    "TradeSkillFrame_SetSelection",
    function(id)
      if id then
        local skillName, skillType = GetTradeSkillInfo(id)
        if skillType and skillType ~= "header" then
          local headerName
          for i = id - 1, 1, -1 do
            headerName, skillType = GetTradeSkillInfo(i)
            if skillType == "header" then
              break
            end
          end
          PoJ_SaveCraftCooldown(GetTradeSkillLine(), headerName, skillName, GetTradeSkillCooldown(id))
        end
      end
    end
  )
end


function PoJ_SetHook_UIParent_ShowHide()
  hooksecurefunc(UIParent, "Hide", PoJ_SetPlayerNamesVisibility)
  hooksecurefunc(UIParent, "Show", PoJ_SetPlayerNamesVisibility)
end


function PoJ_SetHook_UnitFrame_Update()
  hooksecurefunc(
    "UnitFrame_Update",
    function(self)
      PoJ_SetUnitName(self.name, self.unit)
    end
  )
end


function PoJ_SetHook_TextStatusBar_UpdateTextString()
  hooksecurefunc(
    "TextStatusBar_UpdateTextString",
    function(textStatusBar)
      if PoJ_Vars.StatusShowAll and (textStatusBar == PlayerFrameHealthBar or textStatusBar == PlayerFrameManaBar or textStatusBar == TargetFrameHealthBar or textStatusBar == TargetFrameManaBar or textStatusBar == FocusFrameHealthBar or textStatusBar == FocusFrameManaBar) and textStatusBar:IsShown() and not textStatusBar.isZero then
        local textString = textStatusBar.TextString
        if textString and textString:IsShown() then
          local value = textStatusBar:GetValue()
          local _, valueMax = textStatusBar:GetMinMaxValues()
          local percent = tostring(PoJ_Round((value / valueMax) * 100)) .. "%"
          if textStatusBar.capNumericDisplay then
            value = PoJ_FormatNumber(value)
            valueMax = PoJ_FormatNumber(valueMax)
          end
          value = value .. " / " .. valueMax .. "   " .. percent
          if textStatusBar.prefix and (textStatusBar.alwaysPrefix or not textStatusBar.cvar and GetCVar(textStatusBar.cvar) == "1" and textStatusBar.textLockable) then
            value = textStatusBar.prefix .. " " .. value
          end
          textString:SetText(value);
        end
      end
    end
  )
end


function PoJ_SetHook_WorldMap_ToggleSize()
  hooksecurefunc("WorldMap_ToggleSizeDown", PoJ_UpdateCoordPositions)
  hooksecurefunc("WorldMap_ToggleSizeUp", PoJ_UpdateCoordPositions)
end
