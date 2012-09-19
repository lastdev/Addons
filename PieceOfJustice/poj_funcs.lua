function PoJ_AddonMessage(pojtype, msgtype, target)
  if pojtype and msgtype then
    local text
    msgtype = strupper(msgtype)
    if pojtype == "version" then
      text = "version=" .. PoJ.Version
    elseif strsub(pojtype, 1, 1) == "!" then
      text = pojtype
    end
    if text then
      SendAddonMessage(PoJ.AddonComm, text, msgtype, target)
      if PoJ_Vars.ShowAddonComm then
        local to = ""
        if msgtype == "WHISPER" then
          to =  "-->" .. target
        end
        PoJ_Comment("|cffffff00[" .. msgtype .. "." .. UnitName("player") .. to .. "] " .. text .. "|r", true)
      end
    end
  end
end


function PoJ_AspectRemind()
  if not UnitIsDeadOrGhost("player") then
    if PoJ.OnMount or UnitOnTaxi("player") or PoJ_InCity() then
      PoJ.AspectZonePause = true
    else
      PoJ.AspectZonePause = nil
      if PoJ_CVars.AspectActivation and PoJ.HasAspectSkills and not PoJ_IsAspectActive() then
        local text
        if PoJ.OnMount then
          PoJ.AspectZonePause = true
        else
          PoJ_Remind(POJ_STRING.OUTPUT.ASPECTREMIND)
          if PoJ_Vars.RemindRepeat then
            PoJ_Timer_Add(GetTime() + 60 * PoJ_Vars.RemindRepeatTime, "AspectRemind", "FUNCTION", {func = PoJ_AspectRemind}, true)
          end
        end
      end
    end
  end
end


function PoJ_CheckGroupType()
  grouptype = PoJ_GetGroupType()
  if grouptype ~= PoJ_LastGroupType then
    if grouptype ~= "" then
      PoJ_AddonMessage("version", grouptype)
    end
    PoJ_LastGroupType = grouptype
  end
end


function PoJ_CraftRemind(startup)
  local charname = UnitName("player")
  local doremind
  local locale = GetLocale()
  local min_i, min_time
  local now = time()
  local realm = GetRealmName()
  local text
  for i, cd in ipairs(PoJ_Vars.SkillCooldowns) do
    if cd.remind and cd.locale == locale then
      if cd.endtime == 0 then
        doremind = startup and cd.charname == charname
      elseif cd.endtime <= now then
        cd.endtime = 0
        doremind = true
      elseif not min_i or min_time > cd.endtime then
        min_i = i
        min_time = cd.endtime
        doremind = false
      end
      if doremind then
        text = cd.charname
        if cd.realm ~= realm then
          text = text .. " (" .. cd.realm .. ")"
        end
        text = text .. " - " .. cd.skill .. ": |cff00ff00" .. POJ_STRING.OUTPUT.READY .. "|r"
        PoJ_Remind(text)
      end
    end
  end
  if min_i then
    PoJ_Timer_Add(GetTime() + min_time - now + 3, "CraftRemind", "FUNCTION", {func = PoJ_CraftRemind}, true)
  end
end


function PoJ_FriendStartup()
  if (PoJ_Vars.ShowOnlineBattleNet or PoJ_Vars.ShowOnlineFriends) and BNGetNumFriends() == 0 and GetNumFriends() == 0 then
    ShowFriends()
  else
    PoJ.FriendsOk = true
    PoJ_ShowFriendList()
  end
end


function PoJ_GetBuffDescription(index)
  PoJ_ShowBottomtip(PoJ_Tooltip)
  PoJ_Tooltip:SetPlayerBuff(index)
  local line2 = PoJ_TooltipTextLeft2:GetText()
  PoJ_Tooltip:Hide()
  return line2
end


function PoJ_GetBuffName(spellname)
  for _, spellbuff in pairs(PoJ.BuffNames) do
    if spellbuff.spell == spellname then
      return spellbuff.buff
    end
  end
  return spellname
end


function PoJ_GetBuffTimeLeft(unit, buff, mineonly)
  if UnitExists(unit) then
    local _, buffunit, duration, expiration, name
    for i = 1, 40 do
      name, _, _, _, _, duration, expiration, buffunit = UnitBuff(unit, i)
      if not name then
        break
      elseif name == buff then
        if mineonly and buffunit ~= "player" then
          break
        end
        return expiration - GetTime(), duration
      end
    end
  end
  return nil
end


function PoJ_GetCooldownEndTime(start, duration)
  if start > 0 then
    if start > GetTime() then
      start = start - 4293329 -- don't ask! ... really... don't even think about asking...
    end
    return start + duration
  end
end


function PoJ_GetCVarFlag(cvar)
  if GetCVar(cvar) == "1" then
    return true
  end
  return nil
end


function PoJ_GetDebuffName(spellname)
  for _, spelldebuff in pairs(PoJ.DebuffNames) do
    if spelldebuff.spell == spellname then
      return spelldebuff.debuff
    end
  end
  return spellname
end


function PoJ_GetDebuffTimeLeft(unit, debuff, mineonly)
  if UnitExists(unit) then
    local _, buffunit, duration, expiration, name
    for i = 1, 40 do
      name, _, _, _, _, duration, expiration, buffunit = UnitDebuff(unit, i)
      if not name then
        break
      elseif name == debuff then
        if mineonly and buffunit ~= "player" then
          break
        end
        return expiration - GetTime(), duration
      end
    end
  end
  return nil
end


function PoJ_GetFactionColor(unit, faint)
  if UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
    return 0.5, 0.5, 0.5;
  else
    local r, g, b = UnitSelectionColor(unit);
    if faint then
      r = 1 - (1 - r) / 2
      g = 1 - (1 - g) / 2
      b = 1 - (1 - b) / 2
    end
    return r, g, b
  end
end


function PoJ_GetFactionIndex(factionname)
  if factionname ~= GUILD then
    for i = 1, GetNumFactions() do
      if GetFactionInfo(i) == factionname then
        if IsFactionInactive(i) then
          break
        end
        return i
      end
    end
  end
end


function PoJ_GetGemColorCount()
  local _, found, gemlink, itemlink, line
  local blue = 0
  local mega = 0
  local meta = 0
  local red = 0
  local yellow = 0
  for i = 1, 18 do
    itemlink = GetInventoryItemLink("player", i)
    if itemlink then
      for j = 1, 3 do
        _, gemlink = GetItemGem(itemlink, j)
        if gemlink then
          PoJ_ShowBottomtip(PoJ_Tooltip)
          PoJ_Tooltip:SetHyperlink(gemlink)
          found = nil
          for l = 1, PoJ_Tooltip:NumLines() do
            line = _G["PoJ_TooltipTextLeft" .. l]:GetText()
            if line then
              if strfind(line, POJ_STRING.GEMDESCRIPTION.MEGA) then
                mega = mega + 1
              end
              if strfind(line, POJ_STRING.GEMDESCRIPTION.RED) or strfind(line, POJ_STRING.GEMDESCRIPTION.PURPLE1) or strfind(line, POJ_STRING.GEMDESCRIPTION.PURPLE2) or strfind(line, POJ_STRING.GEMDESCRIPTION.ORANGE1) or strfind(line, POJ_STRING.GEMDESCRIPTION.ORANGE2) or strfind(line, POJ_STRING.GEMDESCRIPTION.PRISMATIC) or strfind(line, POJ_STRING.GEMDESCRIPTION.PRISMATIC2) then
                red = red + 1
                found = true
              end
              if strfind(line, POJ_STRING.GEMDESCRIPTION.YELLOW) or strfind(line, POJ_STRING.GEMDESCRIPTION.ORANGE1) or strfind(line, POJ_STRING.GEMDESCRIPTION.ORANGE2) or strfind(line, POJ_STRING.GEMDESCRIPTION.GREEN1) or strfind(line, POJ_STRING.GEMDESCRIPTION.GREEN2) or strfind(line, POJ_STRING.GEMDESCRIPTION.PRISMATIC) or strfind(line, POJ_STRING.GEMDESCRIPTION.PRISMATIC2) then
                yellow = yellow + 1
                found = true
              end
              if strfind(line, POJ_STRING.GEMDESCRIPTION.BLUE) or strfind(line, POJ_STRING.GEMDESCRIPTION.PURPLE1) or strfind(line, POJ_STRING.GEMDESCRIPTION.PURPLE2) or strfind(line, POJ_STRING.GEMDESCRIPTION.GREEN1) or strfind(line, POJ_STRING.GEMDESCRIPTION.GREEN2) or strfind(line, POJ_STRING.GEMDESCRIPTION.PRISMATIC) or strfind(line, POJ_STRING.GEMDESCRIPTION.PRISMATIC2) then
                blue = blue + 1
                found = true
              end
              if strfind(line, POJ_STRING.GEMDESCRIPTION.META) then
                meta = meta + 1
                found = true
              end
            end
            if found then
              break
            end
          end
          PoJ_Tooltip:Hide()
        end
      end
    end
  end
  return red, yellow, blue, mega
end


function PoJ_GetGroupType()
  local grouptype
  if UnitInBattleground("player") then
    grouptype = "battleground"
  elseif UnitInRaid("player") then
    grouptype = "raid"
  elseif UnitInParty("player") then
    grouptype = "party"
  else
    grouptype = ""
  end
  return grouptype
end


function PoJ_GetItemInfoFromLink(itemlink)
  if itemlink then
    local itemid, itemname = strmatch(itemlink, "|Hitem:(%d+):%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+|h%[(.+)%]|h|r")
    return tonumber(itemid), itemname
  end
  return nil, nil
end


function PoJ_GetPetActionIndex(name)
  for i = 1, NUM_PET_ACTION_SLOTS do
    if GetPetActionInfo(i) == name then
      return i
    end
  end
end


function PoJ_GetSpellTargetName(type)
  if type == "player" then
    if UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("target", "player") then
      return UnitName("target")
    elseif PoJ.LastMouseOverSpellTarget and PoJ.LastMouseOverSpellTarget.isplayer and PoJ.LastMouseOverSpellTarget.isfriend then
      return PoJ.LastMouseOverSpellTarget.name
    else
      return UnitName("player")
    end
  end
end


function PoJ_GetTalentRankBySpellID(spellid)
  local spellname = GetSpellInfo(spellid)
  for tab = 1, GetNumTalentTabs() do
    for i = 1, GetNumTalents(tab) do
      local name, _, _, _, rank = GetTalentInfo(tab, i)
      if name == spellname then
        return rank
      end
    end
  end
  return -1
end


function PoJ_GetTargetIdentifier(unit, usecolor)
  local targetstring = ""
  
  if UnitExists(unit) then
    
    -- use colors?
    local colorend  = iif(usecolor, "|r", "")
    
    -- level
    local level = UnitLevel(unit)
    if level == -1 then
      level = "??[" .. UnitLevel("player") + 10 .. "+]"
    end
    
    -- color to print name (green, yellow, red)
    local namecolor = ""
    if usecolor then
      local color = {}
      color.r, color.g, color.b = PoJ_GetFactionColor(unit, true)
      namecolor = "|c" .. PoJ_ColorString(color)
    end
    
    -- type and name
    local creaturefamily = UnitCreatureFamily(unit)
    local namestring     = UnitName(unit)
    local typestring
    local unitclass      = ""
    local unitplayer     = UnitIsPlayer(unit)
    local unittag        = PoJ_GetUnitTag(unit)
    if unittag then
      namestring = namestring .. " <" .. unittag .. ">"
    end
    if unitplayer then
      local rank = UnitPVPRank(unit)
      if rank ~= 0 then
        namestring = "[" .. rank - 4 .. "] " .. UnitPVPName(unit)
      end
      if level == "??[" .. MAX_PLAYER_LEVEL .. "+]" then
        level = MAX_PLAYER_LEVEL
      end
      typestring = UnitRace(unit) .. " (" .. POJ_STRING.MOB.PLAYER .. ")"
      unitclass  = " " .. UnitClass(unit)
    elseif UnitPlayerControlled(unit) then
      if creaturefamily then
        typestring = POJ_STRING.MOB.PET .. " (" .. creaturefamily .. ")"
      elseif level == 1 then
        typestring = POJ_STRING.MOB.MINIPET
      else
        typestring = POJ_STRING.MOB.TOTEM
      end
    elseif UnitFactionGroup(unit) then
      typestring = POJ_STRING.MOB.NPC
      unitclass  = " " .. UnitClass(unit)
    else
      typestring = UnitCreatureType(unit)
      unitclass  = " " .. POJ_STRING.MOB.MOB
      if creaturefamily then
        typestring = typestring .. " (" .. creaturefamily .. ")"
      end
    end
    
    -- classification
    local mobrank = UnitClassification(unit)
    if mobrank == "normal" then
      mobrank = ""
    elseif mobrank == "champion" then
      mobrank = " (" .. POJ_STRING.MOB.CHAMPION .. ")"
    elseif mobrank == "elite" then
      mobrank = " (" .. POJ_STRING.MOB.ELITE .. ")"
    elseif mobrank == "rare" then
      mobrank = " (" .. POJ_STRING.MOB.RARE .. ")"
    elseif mobrank == "rareelite" then
      mobrank = " (" .. POJ_STRING.MOB.RAREELITE .. ")"
    elseif mobrank == "worldboss" then
      mobrank = " (" .. POJ_STRING.MOB.BOSS .. ")"
      if strsub(level, 1, 2) == "??" then
        level = "??"
      end
    else
      mobrank = " (" .. mobrank .. ")"
    end
    
    -- additional remarks
    local remarks = ""
    if UnitIsDeadOrGhost(unit) then
      remarks = remarks .. ", " .. POJ_STRING.MOB.DEAD
    elseif UnitAffectingCombat(unit) then
      remarks = remarks .. ", " .. POJ_STRING.MOB.INFIGHT
    end
    if remarks ~= "" then
      remarks = " [" .. strsub(remarks, 3) .. "]"
    end
    
    -- put everything together
    targetstring = namecolor .. namestring .. colorend
    if typestring then
      if unitplayer and not UnitIsConnected(unit) then
        unitclass = unitclass .. " (offline)"
      else
        unitclass = " Lv " .. level .. unitclass
      end
      targetstring = targetstring .. ", " .. tostring(typestring) .. "," .. unitclass .. mobrank .. remarks
    end
    
  end
  
  return targetstring
end


function PoJ_GetUnitTag(unit)
  if UnitExists(unit) then
    PoJ_ShowBottomtip(PoJ_Tooltip)
    PoJ_Tooltip:SetUnit(unit)
    local line2 = PoJ_TooltipTextLeft2:GetText()
    PoJ_Tooltip:Hide()
    if not strfind(line2, POJ_STRING.WOW.UNITLEVEL .. " [%?%d]+") then
      return line2
    end
  end
end


function PoJ_GuildStartup()
  if IsInGuild() then
    PoJ_AddonMessage("version", "guild")
    if PoJ_Vars.ShowOnlineGuild and GetNumGuildMembers() == 0 then
      GuildRoster()
      return
    end
  end
  PoJ.GuildRosterOk = true
  PoJ_ShowFriendList()
end


function PoJ_InCity()
  local realzone = GetRealZoneText()
  for _, city in pairs(POJ_STRING.WOW.CITYNAMES) do
    if realzone == city then
      return true
    end
  end
  for _, instance in pairs(POJ_STRING.WOW.CITYINSTANCE) do
    if realzone == instance then
      return true
    end
  end
end


function PoJ_IsAspectActive()
  local aspectactive
  if PoJ.ClassString == "Hunter" then
    local index = GetShapeshiftForm()
    if index ~= 0 then
      local _, aspectname = GetShapeshiftFormInfo(index)
      for i, aspect in ipairs(PoJ.AspectSkills) do
        if aspect.spell == aspectname then
          return true
        end
      end
    end
  end
  return nil
end


function PoJ_IsInGroup(playername)
  return UnitInParty(playername) or UnitInRaid(playername) or UnitInBattleground(playername)
end


function PoJ_IsInGuild(playername)
  if IsInGuild() then
    for i = 1, GetNumGuildMembers() do
      if GetGuildRosterInfo(i) == playername then
        return true
      end
    end
  end
  return nil
end


function PoJ_IsFriend(playername)
  for i = 1, GetNumFriends() do
    if GetFriendInfo(i) == playername then
      return true
    end
  end
  return nil
end


function PoJ_ItemRemind()
  if PoJ_Vars.RemindItems and PoJ.HasUseItemsEquipped and not UnitIsDeadOrGhost("player") then
    if PoJ.OnMount or UnitOnTaxi("player") or PoJ_InCity() then
      PoJ.ItemZonePause = true
    else
      PoJ.ItemZonePause = nil
      local systime = GetTime()
      if not PoJ.LastItemRemind or systime - PoJ.LastItemRemind > 5 then
        local repeatremind
        for i, item in ipairs(PoJ.UseItems) do
          if item.currentslot and not item.cooldown and not PoJ_ItemRemind_IsBuffActive(i) then
            link = GetInventoryItemLink("player", item.currentslot)
            if link then
              PoJ_Remind(POJ_STRING.OUTPUT.ITEMREMIND .. ": " .. link)
              repeatremind = repeatremind or PoJ_Vars.RemindRepeat
            end
          end
        end
        if repeatremind then
          PoJ_Timer_Add(systime + 60 * PoJ_Vars.RemindRepeatTime, "ItemRemind", "FUNCTION", {func = PoJ_ItemRemind}, true)
        end
        PoJ.LastItemRemind = systime
      end
    end
  end
end


function PoJ_ItemRemind_CheckItems(force)
  if force or arg1 == "player" then
    local duration, link, start
    PoJ.HasUseItemsEquipped = nil
    for i, item in ipairs(PoJ.UseItems) do
      item.currentslot = nil
      for j, slot in ipairs(item.slots) do
        link = GetInventoryItemLink("player", slot)
        if link and strfind(link, "|Hitem:" .. item.itemid .. ":") then
          item.currentslot = slot
          item.name = strsub(link, strfind(link, "[", 1, true) + 1, strfind(link, "]", 1, true) - 1)
          start, duration = GetInventoryItemCooldown("player", slot)
          if start == 0 then
            item.cooldown = nil
          elseif not item.cooldown then
            PoJ_Timer_Add(start + duration + 1, "ItemRemindCooldown" .. i, "FUNCTION", {func = PoJ_ItemRemind_Ready, params = {i}})
            item.cooldown = true
          end
          PoJ.HasUseItemsEquipped = true
          break
        end
      end
    end
  end
end


function PoJ_ItemRemind_IsBuffActive(itemindex)
  if PoJ.UseItems[itemindex].bufftexture then
    local _, name, texture
    PoJ.UseItems[itemindex].active = nil
    for i = 1, 40 do
      name, _, texture = UnitBuff("player", i, 1)
      if not name then
        break
      elseif name == PoJ.UseItems[itemindex].name and texture == PoJ.UseItems[itemindex].bufftexture then
        PoJ.UseItems[itemindex].active = true
        return true
      end
    end
  end
  return nil
end


function PoJ_ItemRemind_Ready(itemindex)
  PoJ.UseItems[itemindex].cooldown = nil
  PoJ_ItemRemind()
end


function PoJ_LookForAvailableSpells()
  local j, spellid, spellname
  
  PoJ.HasAspectSkills = nil
  
  local _, _, first, count = GetSpellTabInfo(2) -- 2 = active spec
  last = first + count - 1
  
  for index = first, last do
    
    -- hunter aspects
    if PoJ.AspectSkills and #PoJ.AspectSkills > 0 then
      spellname = GetSpellBookItemName(index, BOOKTYPE_SPELL)
      for i, aspect in ipairs(PoJ.AspectSkills) do
        if aspect.spell == spellname then
          PoJ.HasAspectSkills = true
          break
        end
      end
    end
    
    -- other predefined spells
    if PoJ.Spells and #PoJ.Spells > 0 then
      _, spellid = GetSpellBookItemInfo(index, BOOKTYPE_SPELL)
      for _, spell in pairs(PoJ.Spells) do
        if spell.spellid == spellid then
          spell.index = index
        end
      end
    end
    
  end
  
end


function PoJ_ModifyTimeStamp()
  if CHAT_TIMESTAMP_FORMAT then
    if PoJ_Vars.ChatTimeStamp and CHAT_TIMESTAMP_FORMAT then
      if strsub(CHAT_TIMESTAMP_FORMAT, -1, -1) ~= " "  then
        CHAT_TIMESTAMP_FORMAT = CHAT_TIMESTAMP_FORMAT .. " "
      end
    else
      if strsub(CHAT_TIMESTAMP_FORMAT, -1, -1) == " "  then
        CHAT_TIMESTAMP_FORMAT = strsub(CHAT_TIMESTAMP_FORMAT, 1, -2)
      end
    end
  end
end


function PoJ_MountStateChanged()
  local onmount = IsMounted()
  local changed = iif(onmount == PoJ.OnMount, nil, true)
  PoJ.OnMount = onmount
  return changed, onmount
end


function PoJ_PlayerAlive()
  if PoJ.PlayerDead and not UnitIsDeadOrGhost("player") then
    local systime = GetTime()
    if PoJ.LastPlayerAlive == nil or systime > PoJ.LastPlayerAlive + 30 then
      PoJ_AspectRemind()
    end
    PoJ.PlayerDead = nil
    PoJ.LastPlayerAlive = systime
  end
end


function PoJ_SaveCraftCooldown(craftskill, headername, skillname, seconds)
  if not seconds then
    seconds = 0
  end
  local charname = UnitName("player")
  local cd, deleted
  local endtime = time() + PoJ_Round(seconds)
  local found
  local insertpos = 1
  local ready = seconds == 0
  local realm = GetRealmName()
  local setremind
  if craftskill == POJ_STRING.SKILL.ALCHEMY and headername ~= META_GEM then
    if strmatch(skillname, POJ_STRING.SKILL.ALCHEMY_TRANSMUTE .. ":") then
      if ready then -- avoid overwriting with not shared cooldowns
        return
      end
      skillname = POJ_STRING.SKILL.ALCHEMY_TRANSMUTE
    end
  elseif craftskill == POJ_STRING.SKILL.ENCHANTING then
    if strmatch(strlower(skillname), strlower(POJ_STRING.SKILL.ENCHANTING_SPHERE)) then
      if ready then -- avoid overwriting with not shared cooldowns
        return
      end
      skillname = POJ_STRING.SKILL.ENCHANTING_SPHERE
    end
  end
  for i = #PoJ_Vars.SkillCooldowns, 1, -1 do
    cd = PoJ_Vars.SkillCooldowns[i]
    if cd.realm == realm and cd.charname == charname and cd.skill == skillname then
      setremind = cd.remind
      if ready then
        endtime = 0
      end
      table.remove(PoJ_Vars.SkillCooldowns, i)
      if found then
        insertpos = insertpos - 1
      end
      deleted = true
    elseif not found and cd.endtime <= endtime then
      insertpos = i + 1
      found = true
    end
  end
  if not ready or deleted then -- avoid getting crafts without cooldowns into the list
    table.insert(PoJ_Vars.SkillCooldowns, insertpos, {realm = realm, charname = charname, skill = skillname, locale = GetLocale(), endtime = endtime, remind = setremind})
  end
end


function PoJ_SavePartyLevel(unit, upped)
  local name = UnitName(unit)
  if name and not strfind(name, " ", 1) then
    local level    = UnitLevel(unit)
    local oldlevel = PoJ.PartyLvl[name]
    if level ~= oldlevel then
      PoJ.PartyLvl[name] = level
      if upped and oldlevel == level - 1 then
        if PoJ_Vars.GratsOnLevelUp then
          if UnitIsVisible(unit) then
            PoJ_Comment(format(POJ_STRING.OUTPUT.LEVELUPGRATS, name, level))
            DoEmote(EMOTE26_TOKEN, name)
          else
            PoJ_Comment(format(POJ_STRING.OUTPUT.LEVELUPTOOFAR, name, level))
          end
        elseif PoJ_Vars.ShowLevelUps then
          PoJ_Comment(format(POJ_STRING.OUTPUT.LEVELUP, name, level), true)
        end
      end
    end
  end
end


function PoJ_SavePartyLevels()
  if PoJ_GetGroupType() == "party" then
    local unit
    for i = 1, 4 do
      unit = "party" .. i
      if UnitExists(unit) then
        PoJ_SavePartyLevel(unit)
      end
    end
  end
end


function PoJ_SendToGroup(text)
  PoJ_Debug("send to group: " .. text)
  local group = PoJ_GetGroupType()
  if group ~= "" then
    SendChatMessage(">>> " .. text, group)
  end
end


function PoJ_SetChatChannelJoins(startup)
  local i = 1
  while _G["ChatFrame" .. i] do
    frame = _G["ChatFrame" .. i]
    if PoJ_Vars.HideChannelJoins then
      frame:UnregisterEvent("CHAT_MSG_CHANNEL_JOIN" )
      frame:UnregisterEvent("CHAT_MSG_CHANNEL_LEAVE")
    elseif not startup then
      frame:RegisterEvent("CHAT_MSG_CHANNEL_JOIN" )
      frame:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE")
    end
    i = i + 1
  end
end


function PoJ_SetErrorSuppressions()
  for i = 1, #PoJ.ErrorSuppression do
    setglobal(PoJ.ErrorSuppression[i].name, iif(PoJ_Option_GetValue(true, "ErrSupp_" .. PoJ.ErrorSuppression[i].name), "", PoJ.ErrorSuppression[i].text))
  end
end


function PoJ_SetPlayerNamesVisibility(changed)
  if PoJ.SpellsLoaded and PoJ_Vars.PlayerNames and not PoJ.CurrentlySettingPlayerNamesVisibility then
    local index
    PoJ.CurrentlySettingPlayerNamesVisibility = true
    if not UIParent:IsVisible() then
      index = "NoUI"
    elseif PoJ_InCity() then
      index = "City"
    elseif UnitInBattleground("player") then
      index = "BG"
    elseif IsInInstance() then
      index = "Inst"
      if UnitInRaid("player") then
        local players = GetNumGroupMembers()
        if players > 10 then
          index = "In40"
        elseif players > 5 then
          index = "In10"
        end
      end
    elseif UnitInRaid("player") then
      index = "Raid"
    else
      index = "Norm"
    end
    PoJ_PlayerNames_SetColors(index)
    PoJ.CurrentlySettingPlayerNamesVisibility = nil
    if changed or index ~= PoJ.LastPlayerNameIndex then
      pcall(SetCVar, "UnitNamePlayerPVPTitle"       , iif(PoJ_Vars.PlayerNamesShow.Rank[index] , "1", "0"))
      pcall(SetCVar, "UnitNamePlayerGuild"          , iif(PoJ_Vars.PlayerNamesShow.Guild[index], "1", "0"))
      pcall(SetCVar, "UnitNameGuildTitle"           , iif(PoJ_Vars.PlayerNamesShow.GTit[index] , "1", "0"))
      pcall(SetCVar, "UnitNameOwn"                  , iif(PoJ_Vars.PlayerNamesShow.Self[index] , "1", "0"))
      pcall(SetCVar, "UnitNameFriendlyPlayerName"   , iif(PoJ_Vars.PlayerNamesShow.PlayF[index], "1", "0"))
      pcall(SetCVar, "UnitNameEnemyPlayerName"      , iif(PoJ_Vars.PlayerNamesShow.PlayE[index], "1", "0"))
      pcall(SetCVar, "UnitNameFriendlyPetName"      , iif(PoJ_Vars.PlayerNamesShow.PetsF[index], "1", "0"))
      pcall(SetCVar, "UnitNameEnemyPetName"         , iif(PoJ_Vars.PlayerNamesShow.PetsE[index], "1", "0"))
      pcall(SetCVar, "UnitNameFriendlyGuardianName" , iif(PoJ_Vars.PlayerNamesShow.GuarF[index], "1", "0"))
      pcall(SetCVar, "UnitNameEnemyGuardianName"    , iif(PoJ_Vars.PlayerNamesShow.GuarE[index], "1", "0"))
      pcall(SetCVar, "UnitNameFriendlyTotemName"    , iif(PoJ_Vars.PlayerNamesShow.TotF[index] , "1", "0"))
      pcall(SetCVar, "UnitNameEnemyTotemName"       , iif(PoJ_Vars.PlayerNamesShow.TotE[index] , "1", "0"))
      pcall(SetCVar, "UnitNameNonCombatCreatureName", iif(PoJ_Vars.PlayerNamesShow.Comp[index] , "1", "0"))
      pcall(SetCVar, "UnitNameNPC"                  , iif(PoJ_Vars.PlayerNamesShow.NPCs[index] , "1", "0"))
      PoJ.LastPlayerNameIndex = index
    end
  end
end


function PoJ_SetRemindInterval(self)
  local minutes = self:GetNumber()
  if minutes ~= 0 then
    PoJ_Vars.RemindRepeatTime = minutes
  else
    self:SetNumber(PoJ_Vars.RemindRepeatTime)
  end
end


function PoJ_SetTargetNameColors()
  local r, g, b
  if PoJ_Vars.TargetColors then
    r, g, b = PoJ_GetFactionColor("targettarget", true)
  else
    r, g, b = NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b
  end
  TargetFrameToTTextureFrameName:SetTextColor(r, g, b)
  FocusFrameToTTextureFrameName:SetTextColor(r, g, b)
  if IsAddOnLoaded("PieceOfUnity") then
    PoU_SetTargetNameColors(r, g, b)
  end
end


function PoJ_SetUnitName(fontstring, unit)
  if UnitExists(unit) and (unit == "player" or unit == "target" and UnitIsPlayer("target") and UnitIsFriend("target", "player")) then
    local name = UnitName(unit)
    if PoJ_Vars.ShowRaidGroup then
      local membername, rank, subgroup
      for i = 1, GetNumGroupMembers() do
        membername, rank, subgroup = GetRaidRosterInfo(i)
        if membername == name then
          name = name .. " [" .. subgroup .. "]"
          break
        end
      end
    end
    fontstring:SetText(name)
  end
end


function PoJ_ShowFriendList()
  if not PoJ.FriendsListed and PoJ.FriendsOk and PoJ.GuildRosterOk then
    if PoJ_Vars.ShowOnlineBattleNet and PoJ.BNFriendCount then
      if PoJ.BNFriendCount == 0 then
        PoJ_Comment(POJ_STRING.OUTPUT.ONLINENOBNFRIENDS, true)
      else
        PoJ_Comment(POJ_STRING.OUTPUT.ONLINEBNFRIENDS .. " (" .. PoJ.BNFriendCount .."):", true)
        PoJ_Write(PoJ.BNFriendList)
      end
    end
    if PoJ_Vars.ShowOnlineFriends and PoJ.FriendCount then
      if PoJ.FriendCount == 0 then
        PoJ_Comment(POJ_STRING.OUTPUT.ONLINENOFRIENDS, true)
      else
        PoJ_Comment(POJ_STRING.OUTPUT.ONLINEFRIENDS .. " (" .. PoJ.FriendCount .."):", true)
        PoJ_Write(PoJ.FriendList)
      end
    end
    if PoJ_Vars.ShowOnlineGuild and PoJ.GuildMemberCount then
      if PoJ.GuildMemberCount == 1 then
        PoJ_Comment(POJ_STRING.OUTPUT.ONLINENOGUILD, true)
      else
        PoJ_Comment(POJ_STRING.OUTPUT.ONLINEGUILD .. " (" .. PoJ.GuildMemberCount - 1 .."):", true)
        PoJ_Write(PoJ.GuildMemberList)
      end
    end
    PoJ.FriendsListed = true
    PoJ:UnregisterEvent("FRIENDLIST_UPDATE")
    PoJ:UnregisterEvent("GUILD_ROSTER_UPDATE")
  end
end


function PoJ_SpellCompleted(spell, target)
  if PoJ.ClassString == "Warlock" and spell == PoJ.Soulstone and PoJ_CVars.ShowSoulStoneMessage and target ~= UnitName("player") then
    PoJ_SendToGroup(format(POJ_STRING.OUTPUT.SOULSTONESET, target))
  end
end


function PoJ_SpellCooldown(spell)
  if PoJ.Spells[spell] then
    local show, spelltime
    if PoJ.Spells[spell].index then
      local start, duration, enable = GetSpellCooldown(PoJ.Spells[spell].index, BOOKTYPE_SPELL)
      local now = time()
      local systime = GetTime()
      if start > 0 and duration > 300 and start <= systime then
        spelltime = start + duration - systime
        show = PoJ_CVars["Show" .. spell .. "Cooldown"] and spelltime > 0
      end
    end
    if show then
      PoJ_CooldownTexture:SetTexture(GetSpellTexture(PoJ.Spells[spell].index, BOOKTYPE_SPELL))
      PoJ_CooldownLabel:SetText(PoJ_GetTimeString(spelltime))
      PoJ_Cooldown:Show() 
    else
      PoJ_Cooldown:Hide() 
    end
  end
end
