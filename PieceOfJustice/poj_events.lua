PoJ_EH  = {}


function PoJ_RegisterEvents()
  PoJ:RegisterEvent("ADDON_ACTION_FORBIDDEN")
  PoJ:RegisterEvent("CHAT_MSG_ADDON")
  PoJ:RegisterEvent("CHAT_MSG_SYSTEM")
  PoJ:RegisterEvent("COMBAT_TEXT_UPDATE")
  PoJ:RegisterEvent("CONFIRM_BINDER")
  PoJ:RegisterEvent("FRIENDLIST_UPDATE")
  PoJ:RegisterEvent("LOOT_OPENED")
  PoJ:RegisterEvent("PARTY_LEADER_CHANGED")
  PoJ:RegisterEvent("PARTY_MEMBERS_CHANGED")
  PoJ:RegisterEvent("PLAYER_ALIVE")
  PoJ:RegisterEvent("PLAYER_CONTROL_GAINED")
  PoJ:RegisterEvent("PLAYER_DEAD")
  PoJ:RegisterEvent("PLAYER_ENTERING_WORLD")
  PoJ:RegisterEvent("PLAYER_REGEN_DISABLED")
  PoJ:RegisterEvent("PLAYER_REGEN_ENABLED")
  PoJ:RegisterEvent("PLAYER_TARGET_CHANGED")
  PoJ:RegisterEvent("PLAYER_UNGHOST")
  PoJ:RegisterEvent("RAID_ROSTER_UPDATE")
  PoJ:RegisterEvent("TRADE_SHOW")
  PoJ:RegisterEvent("UNIT_INVENTORY_CHANGED")
  PoJ:RegisterEvent("UNIT_AURA")
  PoJ:RegisterEvent("UNIT_LEVEL")
  PoJ:RegisterEvent("UNIT_SPELLCAST_FAILED")
  PoJ:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
  PoJ:RegisterEvent("UNIT_SPELLCAST_SENT")
  PoJ:RegisterEvent("UNIT_SPELLCAST_START")
  PoJ:RegisterEvent("UNIT_SPELLCAST_STOP")
  PoJ:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
  PoJ:RegisterEvent("WORLD_MAP_UPDATE")
  PoJ:RegisterEvent("ZONE_CHANGED_NEW_AREA")
end


function PoJ_OnEvent(self, event, ...)
  if PoJ_EH[event] then
    PoJ_EH[event](...)
  else
    local vararg = {...}
    local arg, out
    PoJ_Debug("PoJ - unhandled registered event: " .. event)
    for i = 1, #vararg do
      arg = vararg[i]
      if arg then
        if type(arg) == "string" then
          out = '"' .. arg .. '"'
        else
          out = tostring(arg)
        end
        PoJ_Debug("   - arg" .. i .. " = " .. out)
      else
        break
      end
    end
  end
end


function PoJ_EH.ADDON_ACTION_FORBIDDEN(addon, functioncall)
  PoJ_Debug("addon " .. addon .. " blocked - function call: " .. functioncall)
end


function PoJ_EH.ADDON_LOADED(addon)
  if addon == "Blizzard_CraftUI" then
    PoJ_SetHook_CraftFrame_SetSelection()
  elseif addon == "Blizzard_TradeSkillUI" then
    PoJ_SetHook_TradeSkillFrame_SetSelection()
  elseif addon == "XPerl_Player" then
    PoJ_Cooldown:ClearAllPoints()
    PoJ_Cooldown:SetPoint("BOTTOMLEFT", "XPerl_Player", "TOPLEFT", 5, -1)
  elseif addon == "XPerl_Target" then
    PoJ_TargetIcons:ClearAllPoints()
    PoJ_TargetIcons:SetPoint("BOTTOMLEFT", "XPerl_Target", "TOPLEFT", 6, -5)
    PoJ_UpdateTargetIcons()
  end
end


function PoJ_EH.CHAT_MSG_ADDON(prefix, message, type, sender)
  if prefix == PoJ.AddonComm then
    if PoJ_Vars.ShowAddonComm and sender ~= UnitName("player") then
      PoJ_Comment("|cffffff00[" .. type .. "." .. sender .. "] " .. message .. "|r", true)
    end
    if message == "!version" then
      PoJ_AddonMessage("version", "WHISPER", sender)
    elseif strsub(message, 1, 8) == "version=" then
      local newer
      local version, subversion = strmatch(message, "version=(%d+%.%d+%.%d+)(%a*)")
      if subverion == "" then
        if not PoJ_Vars.NewestVersion then
          newer = true
        elseif PoJ_VersionCompare(PoJ_Vars.NewestVersion, version) then
          newer = true
        elseif PoJ_VersionCompare(version, PoJ.Version) then
          PoJ_AddonMessage("version", "WHISPER", sender)
        end
        if newer then
          PoJ_Vars.NewestVersion = version
          PoJ_VersionCheck()
        end
      end
    end
  end
end


function PoJ_EH.CHAT_MSG_SYSTEM(content)
  if PoJ_Vars.PostHomeToParty and PoJ.BindToHome and content == format(ERR_DEATHBIND_SUCCESS_S, PoJ.BindToHome) then
    if PoJ_GetGroupType() == "party" then
      local subzone = GetSubZoneText()
      local realzone = GetRealZoneText()
      if subzone ~= PoJ.BindToHome and subzone ~= "" then
        if realzone == PoJ.BindToHome then
          PoJ.BindToHome = subzone
        else
          PoJ.BindToHome = PoJ.BindToHome .. ", " .. subzone
        end
      end
      if realzone ~= subzone then
        PoJ.BindToHome = PoJ.BindToHome .. ", " .. realzone
      end
      PoJ_SendToGroup(POJ_STRING.OUTPUT.HEARTHSTONESET .. ": " .. PoJ.BindToHome)
    end
    PoJ.BindToHome = nil
  end
end


function PoJ_EH.COMBAT_TEXT_UPDATE(type, name, amount)
  if PoJ_Vars.AutoFaction and type == "FACTION" and tonumber(amount) > 0 then
    local index = PoJ_GetFactionIndex(name)
    if index and index > 0 then
      SetWatchedFactionIndex(index)
    end
  end
end


function PoJ_EH.CONFIRM_BINDER(location)
  PoJ.BindToHome = location
end


function PoJ_EH.FRIENDLIST_UPDATE()
  if not PoJ.FriendsListed then
    PoJ.BNFriendCount = 0
    PoJ.BNFriendList = ""
    PoJ.FriendCount = 0
    PoJ.FriendList = ""
    for i = 1, BNGetNumFriends() do
      local _, name, battletag, isbattletag, charname, _, client, online, _, afk, dnd = BNGetFriendInfo(i)
      if online then
        PoJ.BNFriendCount = PoJ.BNFriendCount + 1
        if isbattletag then
          PoJ.BNFriendList = PoJ.BNFriendList .. ", " .. battletag
        else
          PoJ.BNFriendList = PoJ.BNFriendList .. ", " .. name
        end
        if afk then
          PoJ.BNFriendList = PoJ.BNFriendList .. " <AFK>"
        elseif dnd then
          PoJ.BNFriendList = PoJ.BNFriendList .. " <DND>"
        end
        if client == "WoW" then
          PoJ.BNFriendList = PoJ.BNFriendList .. " [" .. charname .. "]"
        elseif client == "D3" then
          PoJ.BNFriendList = PoJ.BNFriendList .. " [Diablo 3]"
        elseif client == "S2" then
          PoJ.BNFriendList = PoJ.BNFriendList .. " [StarCraft 2]"
        else
          PoJ.BNFriendList = PoJ.BNFriendList .. " [" .. client .. "]"
        end
      end
    end
    for i = 1, GetNumFriends() do
      local name, _, _, _, online, status = GetFriendInfo(i)
      if online then
        PoJ.FriendCount = PoJ.FriendCount + 1
        PoJ.FriendList = PoJ.FriendList .. ", " .. name .. iif(status == "", "", " " .. status)
      end
    end
    if PoJ.BNFriendCount ~= 0 then
      PoJ.BNFriendList = strsub(PoJ.BNFriendList, 3)
    end
    if PoJ.FriendCount ~= 0 then
      PoJ.FriendList = strsub(PoJ.FriendList, 3)
    end
    PoJ.FriendsOk = true
    PoJ_ShowFriendList()
  end
end


function PoJ_EH.GUILD_ROSTER_UPDATE()
  if not PoJ.FriendsListed and IsInGuild() then
    local _, name, online, status
    PoJ.GuildMemberCount = 0
    PoJ.GuildMemberList = ""
    local playername = UnitName("player")
    for i = 1, GetNumGuildMembers() do
      name, _, _, _, _, _, _, _, online, status = GetGuildRosterInfo(i)
      if online then
        PoJ.GuildMemberCount = PoJ.GuildMemberCount + 1
        if name ~= playername then
          if status == 0 then
            status = ""
          elseif status == 1 then
            status = CHAT_FLAG_AFK
          elseif status == 2 then
            status = CHAT_FLAG_DND
          else
            status = UNKNOWN
          end
          PoJ.GuildMemberList = PoJ.GuildMemberList .. ", " .. name .. status
        end
      end
    end
    if PoJ.GuildMemberCount > 1 then
      PoJ.GuildMemberList = strsub(PoJ.GuildMemberList, 3)
    end
    PoJ.GuildRosterOk = PoJ.GuildMemberCount > 0
    PoJ_ShowFriendList()
  end
end


function PoJ_EH.LOOT_OPENED()
  if PoJ.ClassString == "Rogue" and PoJ_CVars.PickPocketAutoLoot and PoJ.LastAction == GetSpellInfo(921) then
    local moneystring
    for i = 1, GetNumLootItems() do
      LootSlot(i)
    end
    PoJ.LastAction = nil
  end
end


function PoJ_EH.PARTY_LEADER_CHANGED()
  PoJ_UpdateTargetIcons()
end


function PoJ_EH.PARTY_MEMBERS_CHANGED()
  PoJ_CheckGroupType()
  PoJ_UpdateTargetIcons()
end


function PoJ_EH.PLAYER_ALIVE()
  PoJ_PlayerAlive()
end


function PoJ_EH.PLAYER_CONTROL_GAINED()
  if PoJ.AspectZonePause then
    PoJ_Timer_Add(GetTime() + 1, "AspectRemind", "FUNCTION", {func = PoJ_AspectRemind}, true)
  end
end


function PoJ_EH.PLAYER_DEAD()
  PoJ.AspectActive = nil
  PoJ.OnMount = nil
  PoJ.PlayerDead = true
end


function PoJ_EH.PLAYER_ENTERING_WORLD()
  PoJ_PlayerAlive()
end


function PoJ_EH.PLAYER_REGEN_DISABLED()
  PoJ_AspectRemind()
  PoJ_ActionBar_Setup(true)
end


function PoJ_EH.PLAYER_REGEN_ENABLED()
  PoJ_ActionBar_Setup()
  PoJ_SetMenuBarPos()
  for i = 1, 4 do
    PartyMemberFrame_UpdateMember(_G["PartyMemberFrame" .. i])
  end
end


function PoJ_EH.PLAYER_TARGET_CHANGED()
  PoJ_UpdateTargetClass()
  PoJ_UpdateTargetIcons()
end


function PoJ_EH.PLAYER_UNGHOST()
  PoJ_PlayerAlive()
end


function PoJ_EH.RAID_ROSTER_UPDATE()
  PoJ_CheckGroupType()
  if PoJ_Vars.ShowRaidGroup then
    PoJ_SetUnitName(PlayerName, "player")
    PoJ_SetUnitName(TargetFrameTextureFrameName, "target")
  end
  PoJ_SetPlayerNamesVisibility()
  PoJ_UpdateTargetIcons()
end


function PoJ_EH.SPELLS_CHANGED(reloaded)
  
  PoJ_LookForAvailableSpells()
  
  if not PoJ.SpellsLoaded then
    
    local settime = GetTime() + 3
    
    -- reminders
    PoJ_ItemRemind_CheckItems(true)
    PoJ_Timer_Add(settime, "AspectRemind", "FUNCTION", {func = PoJ_AspectRemind}, true)
    PoJ_Timer_Add(settime, "CraftRemind" , "FUNCTION", {func = PoJ_CraftRemind, params = {true}}, true)
    PoJ_Timer_Add(settime, "ItemRemind"  , "FUNCTION", {func = PoJ_ItemRemind  }, true)
    
    -- save spell load state
    PoJ.SpellsLoaded = true
    
  end
  
end


function PoJ_EH.TRADE_SHOW()
  if PoJ_Vars.ShowTradePlayer and UnitExists("NPC") then
    PoJ_Comment(POJ_STRING.OUTPUT.TRADESTART .. " " .. UnitName("NPC") .. " (Lv " .. UnitLevel("NPC") .. " " .. UnitRace("NPC") .. " " .. UnitClass("NPC") .. ")", true)
  end
end


function PoJ_EH.UNIT_AURA(unit)
  if unit == "player" and not UnitIsDeadOrGhost("player") then
    local itemreminddone
    local changed, state = PoJ_MountStateChanged()
    if changed and not state then
      if PoJ.AspectZonePause or PoJ.ClassString == "Hunter" then
        PoJ_AspectRemind()
      end
      if PoJ.ItemZonePause then
        PoJ_ItemRemind()
        itemreminddone = true
      end
    end
    if PoJ_Vars.RemindItems and not itemreminddone then
      for i, item in ipairs(PoJ.UseItems) do
        if PoJ.UseItems[i].active and not PoJ_ItemRemind_IsBuffActive(i) then
          PoJ_ItemRemind()
          break
        end
      end
    end
  end
end


function PoJ_EH.UNIT_INVENTORY_CHANGED(unit)
  if unit == "player" then
    PoJ_GemCounter_Update()
    PoJ_ItemRemind_CheckItems()
  end
end


function PoJ_EH.UNIT_LEVEL(unit)
  if string.match(unit, "party%d") then
    PoJ_SavePartyLevel(unit, true)
  end
end


function PoJ_EH.UNIT_SPELLCAST_FAILED(unit)
  if unit == "player" then
    PoJ.CurrentSpell       = nil
    PoJ.CurrentSpellTarget = nil
  end
end


function PoJ_EH.UNIT_SPELLCAST_INTERRUPTED(unit)
  if unit == "player" then
    PoJ.CurrentSpell       = nil
    PoJ.CurrentSpellTarget = nil
  end
end


function PoJ_EH.UNIT_SPELLCAST_SENT(unit, spell)
  if unit == "player" then
    PoJ.LastAction = spell
  end
end


function PoJ_EH.UNIT_SPELLCAST_START(unit, spell)
  if unit == "player" then
    PoJ.SpellInProgress = spell
    if PoJ.CurrentSpell ~= spell then
      PoJ.CurrentSpell = nil
      if PoJ.ClassString == "Warlock" and spell == PoJ.Soulstone then
        PoJ.CurrentSpellTarget = PoJ_GetSpellTargetName("player")
        PoJ.CurrentSpell       = iif(PoJ.CurrentSpellTarget, spell, nil)
      end
    end
  end
end


function PoJ_EH.UNIT_SPELLCAST_STOP(unit)
  if unit == "player" then
    PoJ.SpellInProgress = nil
    if PoJ.CurrentSpell and PoJ.ClassString == "Warlock" and PoJ.CurrentSpell == PoJ.Soulstone then
      PoJ_Timer_Add(GetTime() + 1, "SpellCompleted", "FUNCTION", {func = PoJ_SpellCompleted, params = {PoJ.CurrentSpell, PoJ.CurrentSpellTarget}})
    end
    PoJ.CurrentSpell       = nil
    PoJ.CurrentSpellTarget = nil
  end
end


function PoJ_EH.UPDATE_MOUSEOVER_UNIT()
  
  -- safe spell target
  if SpellIsTargeting() then
    PoJ.LastMouseOverSpellTarget = {
      name      = UnitName("mouseover"),
      isfriend  = UnitIsFriend("mouseover", "player"),
      isingroup = UnitInParty("mouseover"),
      isplayer  = UnitIsPlayer("mouseover"),
      isself    = UnitIsUnit("mouseover", "player")
    }
  else
    PoJ.LastMouseOverSpellTarget = nil
  end
  
end


function PoJ_EH.VARIABLES_LOADED()
  PoJ_Start()
end


function PoJ_EH.WORLD_MAP_UPDATE()
  PoJ_SavePartyLevels()
  PoJ_SetPlayerNamesVisibility()
end


function PoJ_EH.ZONE_CHANGED_NEW_AREA()
  PoJ_SetPlayerNamesVisibility()
  if PoJ.AspectZonePause then
    PoJ_AspectRemind()
  end
  if PoJ.ItemZonePause then
    PoJ_ItemRemind()
  end
end