PoJ_Vars  = {}  -- list of variables saved between sessions
PoJ_CVars = {}  -- list of variables saved between sessions per character


function PoJ_OnLoad()
  PoJ.ActionButton     = {}
  PoJ.AddonComm        = "Piece of Justice"
  PoJ.BuffNames        = {}
  PoJ.DebuffNames      = {}
  PoJ.LastText         = ""
  PoJ.LastUpdate       = 0
  PoJ.PartyLvl         = {}
  PoJ.Spells           = {}
  PoJ.TimerQueue       = {}
  PoJ.UpdateRate       = 0.25
  PoJ.URL              = "http://www.piece-of-justice.net/"
  PoJ.Version          = "1.16.2"
  PoJ.WoWActionButtons = {}
  
  -- define locale string constants
  local locale = GetLocale()
  if locale == "deDE" then
    PoJ_DefineStringConstants_de()
  elseif locale == "enGB" or  locale == "enUS" then
    PoJ_DefineStringConstants_en()
  else
    PoJ_Write("Sorry, your locale version (" .. locale .. ") is not supported by Piece of Justice", false)
    DisableAddOn("Piece of Justice")
    return
  end
  
  -- set player class
  local _, charclass = UnitClass("player")
  PoJ.ClassString = strsub(charclass, 1, 1) .. strlower(strsub(charclass, 2))
  
  -- define lists
  PoJ_DefineLists()
  
  -- set class specific options
  if PoJ_DefineClassConstants[PoJ.ClassString] then
    PoJ_DefineClassConstants[PoJ.ClassString]()
  end
  
  -- register events to wait for at startup
  PoJ:RegisterEvent("ADDON_LOADED")
  PoJ:RegisterEvent("GUILD_ROSTER_UPDATE")
  PoJ:RegisterEvent("SPELLS_CHANGED")
  PoJ:RegisterEvent("VARIABLES_LOADED")
  
  -- register slash command
  SlashCmdList["PieceOfJustice"] = PoJ_SlashCommandHandler
  SLASH_PieceOfJustice1 = "/poj"
end


function PoJ_OnUpdate(elapsed)
  
  PoJ_Timer_Check()
  
  PoJ.LastUpdate = PoJ.LastUpdate + elapsed
  if PoJ.LastUpdate > PoJ.UpdateRate then
    if PoJ.SpellsLoaded and PoJ.LastActionBarLock ~= LOCK_ACTIONBAR then
      if LOCK_ACTIONBAR == "0" then
        MainMenuBarPageNumber:SetTextColor(1, 0, 0)
      elseif LOCK_ACTIONBAR == "1" then
        MainMenuBarPageNumber:SetTextColor(1, 0.82, 0)
      end
      PoJ.LastActionBarLock = LOCK_ACTIONBAR
    end
    if PoJ.ClassString == "Shaman" then
      PoJ_SpellCooldown("Reincarnation")
    end
    PoJ_UpdateWoWActionButtons()
  end
end


function PoJ_SlashCommandHandler(command)
  if command == "" then
    PoJ_ToggleFrame(PoJ_Options)
  else
    local arg = {}
    for word in string.gmatch(command, "[^%s]+") do
      table.insert(arg, word)
    end
    local args = #arg
    local cmd = strlower(arg[1])
    if cmd == "help" then
      for _, helpline in ipairs(POJ_STRING.HELP) do
        PoJ_Comment(helpline, true)
      end
    elseif cmd == "achiev" then
      if args > 1 then
        local achievementlink = GetAchievementLink(arg[2])
        if achievementlink then
          PoJ_Comment(achievementlink, true)
        else
          PoJ_Comment(POJ_STRING.OUTPUT.ACHIEVEMENTNOTFOUND, true)
        end
      end
    elseif cmd == "item" then
      if args > 1 then
        local _, itemlink = GetItemInfo(arg[2])
        if itemlink then
          PoJ_Comment(itemlink, true)
        else
          PoJ_Comment(POJ_STRING.OUTPUT.ITEMNOTFOUND, true)
        end
      end
    elseif cmd == "timer" then
      if args > 2 then
        local minutes = tonumber(arg[2])
        local text = table.concat(arg, " ", 3)
        local timerid = 1
        local timername = "TextRemind" .. timerid
        while PoJ_Timer_Exists(timername) do
          timerid = timerid + 1
          timername = "TextRemind" .. timerid
        end
        PoJ_Timer_Add(GetTime() + 60 * minutes, timername, "FUNCTION", {func = PoJ_Remind, params = {text}})
        PoJ_Comment(POJ_STRING.OUTPUT.TIMERSET .. " - " .. minutes .. " " .. POJ_STRING.OUTPUT.MINUTES .. ": " .. text, true)
      end
    end
  end
end


function PoJ_Start()
  if not PoJ.Started then
    PoJ.Started = true
  
    -- hook functions of the WoW UI
    PoJ_SetHooks()
    
    -- define PoJ variables
    PoJ_DefineVars()
    
    -- register events
    PoJ_RegisterEvents()
    
    -- do startup stuff
    PoJ_ActionBar_Setup()
    PoJ_ModifyTimeStamp()
    PoJ_SetActionBarPos()
    PoJ_SetChatChannelJoins(true)
    PoJ_SetDoubleChatEditWidth()
    PoJ_SetErrorSuppressions()
    PoJ_SetMenuBarPos()
    PoJ_SetStatusBarFont()
    PoJ_SetTargetNameColors()
    PoJ_ShowActionBar()
    PoJ_ShowCoords()
    PoJ_ShowCoords_Map()
    PoJ_ShowGemCounter()
    PoJ_ShowMenuDeco()
    PoJ_ShowMinimapIcon()
    PoJ_ShowRaidGroup()
    
    -- sort skill cooldown table
    table.sort(PoJ_Vars.SkillCooldowns, PoJ_CraftList_Sort)
    
    -- save party levels if already in party (e.g. after disconnection)
    if UnitInRaid("player") == nil and UnitInParty("player") then
      for i = 1, GetNumGroupMembers() - 1 do
        PoJ_SavePartyLevel("party" .. i, false)
      end
    end
    
    PoJ_Timer_Add(GetTime() + 1, "StartDelayed", "FUNCTION", { func = PoJ_StartDelayed })
  end
end


function PoJ_StartDelayed()
  PoJ_FriendStartup()
  PoJ_GuildStartup()
  PoJ_SetPlayerNamesVisibility()
  PoJ_VersionCheck()
end


PoJ_DefineClassConstants = {}


function PoJ_DefineClassConstants.Deathknight()
  PoJ.DebuffNames = {
    {spell = GetSpellInfo(45477), debuff = GetSpellInfo(55095)}, -- Eisige Berührung => Frostfieber
    {spell = GetSpellInfo(45462), debuff = GetSpellInfo(55078)}, -- Seuchenstoß      => Blutseuche
  }
end


function PoJ_DefineClassConstants.Hunter()
  PoJ.AspectSkills = {
    { spell = GetSpellInfo(13165) }, -- Aspekt des Falken
    { spell = GetSpellInfo(82661) }, -- Aspekt des Fuchses
  }
end


function PoJ_DefineClassConstants.Shaman()
  PoJ.Spells.Reincarnation = { spellid = 20608 }
end


function PoJ_DefineClassConstants.Warlock()
  PoJ.Soulstone = GetSpellInfo(20707)
end


function PoJ_DefineLists()
  PoJ.ActionbarTimeColors = {
    buff     = {r = 0.6, g = 0.6, b = 1  },
    cooldown = {r = 1  , g = 0.6, b = 0.6},
    debuff   = {r = 0.4, g = 1  , b = 0.4},
  }
  
  PoJ.ErrorSuppression = {
    { name = "ERR_ITEM_COOLDOWN", text = ERR_ITEM_COOLDOWN },
    { name = "ERR_ABILITY_COOLDOWN", text = ERR_ABILITY_COOLDOWN },
  }
  
  if PoJ.ClassString == "Deathknight" then
    PoJ.ErrorSuppression[3] = { name = "ERR_SPELL_COOLDOWN"            , text = ERR_SPELL_COOLDOWN             }
    PoJ.ErrorSuppression[4] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[5] = { name = "ERR_OUT_OF_RUNES"              , text = ERR_OUT_OF_RUNES               }
    PoJ.ErrorSuppression[6] = { name = "ERR_OUT_OF_RUNIC_POWER"        , text = ERR_OUT_OF_RUNIC_POWER         }
  elseif PoJ.ClassString == "Druid" then
    PoJ.ErrorSuppression[3] = { name = "ERR_SPELL_COOLDOWN"            , text = ERR_SPELL_COOLDOWN             }
    PoJ.ErrorSuppression[4] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[5] = { name = "ERR_OUT_OF_MANA"               , text = ERR_OUT_OF_MANA                }
    PoJ.ErrorSuppression[6] = { name = "ERR_OUT_OF_ENERGY"             , text = ERR_OUT_OF_ENERGY              }
    PoJ.ErrorSuppression[7] = { name = "ERR_OUT_OF_RAGE"               , text = ERR_OUT_OF_RAGE                }
    PoJ.ErrorSuppression[8] = { name = "ERR_OUT_OF_BALANCE_POSITIVE"   , text = ERR_OUT_OF_BALANCE_POSITIVE    }
    PoJ.ErrorSuppression[9] = { name = "ERR_OUT_OF_BALANCE_NEGATIVE"   , text = ERR_OUT_OF_BALANCE_NEGATIVE    }
  elseif PoJ.ClassString == "Hunter" then
    PoJ.ErrorSuppression[3] = { name = "ERR_SPELL_COOLDOWN"            , text = ERR_SPELL_COOLDOWN             }
    PoJ.ErrorSuppression[4] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[5] = { name = "ERR_OUT_OF_FOCUS"              , text = ERR_OUT_OF_FOCUS               }
  elseif PoJ.ClassString == "Mage" then
    PoJ.ErrorSuppression[3] = { name = "ERR_SPELL_COOLDOWN"            , text = ERR_SPELL_COOLDOWN             }
    PoJ.ErrorSuppression[4] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[5] = { name = "ERR_OUT_OF_MANA"               , text = ERR_OUT_OF_MANA                }
  elseif PoJ.ClassString == "Monk" then
    PoJ.ErrorSuppression[3] = { name = "ERR_SPELL_COOLDOWN"            , text = ERR_SPELL_COOLDOWN             }
    PoJ.ErrorSuppression[4] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[5] = { name = "ERR_OUT_OF_MANA"               , text = ERR_OUT_OF_MANA                }
    PoJ.ErrorSuppression[6] = { name = "ERR_OUT_OF_ENERGY"             , text = ERR_OUT_OF_ENERGY              }
    PoJ.ErrorSuppression[7] = { name = "ERR_OUT_OF_LIGHT_FORCE"        , text = ERR_OUT_OF_LIGHT_FORCE         }
  elseif PoJ.ClassString == "Paladin" then
    PoJ.ErrorSuppression[3] = { name = "ERR_SPELL_COOLDOWN"            , text = ERR_SPELL_COOLDOWN             }
    PoJ.ErrorSuppression[4] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[5] = { name = "ERR_OUT_OF_MANA"               , text = ERR_OUT_OF_MANA                }
    PoJ.ErrorSuppression[6] = { name = "ERR_OUT_OF_HOLY_POWER"         , text = ERR_OUT_OF_HOLY_POWER          }
  elseif PoJ.ClassString == "Priest" then
    PoJ.ErrorSuppression[3] = { name = "ERR_SPELL_COOLDOWN"            , text = ERR_SPELL_COOLDOWN             }
    PoJ.ErrorSuppression[4] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[5] = { name = "ERR_OUT_OF_MANA"               , text = ERR_OUT_OF_MANA                }
    PoJ.ErrorSuppression[6] = { name = "ERR_OUT_OF_SHADOW_ORBS"        , text = ERR_OUT_OF_SHADOW_ORBS         }
  elseif PoJ.ClassString == "Rogue" then
    PoJ.ErrorSuppression[3] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[4] = { name = "ERR_OUT_OF_ENERGY"             , text = ERR_OUT_OF_ENERGY              }
  elseif PoJ.ClassString == "Shaman" then
    PoJ.ErrorSuppression[3] = { name = "ERR_SPELL_COOLDOWN"            , text = ERR_SPELL_COOLDOWN             }
    PoJ.ErrorSuppression[4] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[5] = { name = "ERR_OUT_OF_MANA"               , text = ERR_OUT_OF_MANA                }
  elseif PoJ.ClassString == "Warlock" then
    PoJ.ErrorSuppression[3] = { name = "ERR_SPELL_COOLDOWN"            , text = ERR_SPELL_COOLDOWN             }
    PoJ.ErrorSuppression[4] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[5] = { name = "ERR_OUT_OF_MANA"               , text = ERR_OUT_OF_MANA                }
    PoJ.ErrorSuppression[6] = { name = "ERR_OUT_OF_SOUL_SHARDS"        , text = ERR_OUT_OF_SOUL_SHARDS         }
    PoJ.ErrorSuppression[7] = { name = "ERR_OUT_OF_BURNING_EMBERS"     , text = ERR_OUT_OF_BURNING_EMBERS      }
    PoJ.ErrorSuppression[8] = { name = "ERR_OUT_OF_DEMONIC_FURY"       , text = ERR_OUT_OF_DEMONIC_FURY        }
  elseif PoJ.ClassString == "Warrior" then
    PoJ.ErrorSuppression[3] = { name = "SPELL_FAILED_SPELL_IN_PROGRESS", text = SPELL_FAILED_SPELL_IN_PROGRESS }
    PoJ.ErrorSuppression[4] = { name = "ERR_OUT_OF_RAGE"               , text = ERR_OUT_OF_RAGE                }
  end
  
  PoJ.SkillCooldownItems = {
    15846, -- Salt Shaker
  }
  
  PoJ.UseItems = {
    {itemid = 13143, slots = {11, 12}, bufftexture = "Interface\\Icons\\INV_Misc_Head_Dragon_01"   }, -- Mark of the Dragon Lord
    {itemid = 13937, slots = {16    }, bufftexture = "Interface\\Icons\\Spell_Totem_WardOfDraining"}, -- Headmaster's Charge
  }
end


function PoJ_DefineVars()
  PoJ.PlayerDead = UnitIsDeadOrGhost("player")
  
  if PoJ_Vars.ActionBar_x == nil then
    PoJ_Vars.ActionBar_x = 5
  end
  if PoJ_Vars.ActionBar_y == nil then
    PoJ_Vars.ActionBar_y = 300
  end
  if PoJ_Vars.ActionBarRows == nil then
    PoJ_Vars.ActionBarRows = 1
  end
  
  if PoJ.ClassString == "Hunter" and PoJ_CVars.AuraActivation then
    PoJ_CVars.AspectActivation = true
  end
  
  if PoJ_Vars.MenuBarPos == nil then
    PoJ_Vars.MenuBarPos = 0
  end
  
  if PoJ_Vars.Minimap_x == nil then
    PoJ_Vars.Minimap_x = 16
  end
  if PoJ_Vars.Minimap_y == nil then
    PoJ_Vars.Minimap_y = -121
  end
  PoJ_SetMinimapIconPos(PoJ_Vars.Minimap_x, PoJ_Vars.Minimap_y)
  
  if not PoJ_Vars.Notes then
    PoJ_Vars.Notes = {}
  end
  
  if PoJ_Vars.RemindRepeatTime == nil then
    PoJ_Vars.RemindRepeatTime = 3
  end
  
  if PoJ_Vars.ShowComments == nil then
    PoJ_Vars.ShowComments = true
  end
  
  if not PoJ_Vars.SkillCooldowns then
    PoJ_Vars.SkillCooldowns = {}
  end
  
  if not PoJ_CVars.Notes then
    PoJ_CVars.Notes = {}
  end
  
  PoJ_DefineVars_Convert()
  PoJ_Timer_Add(GetTime() + 3, "DefineVars_CVars" , "FUNCTION", {func = PoJ_DefineVars_CVars})
end


function PoJ_DefineVars_Convert()
  -- delete old settings
  PoJ_Vars.ChatTranslation = nil
  PoJ_Vars.FastTrade = nil
  PoJ_Vars.SpamFilter = nil
  PoJ_Vars.StatusBarShow = nil
  PoJ_Vars.StatusModify = nil
  PoJ_Vars.StatusTarget = nil
  PoJ_Vars.TargetParty = nil
  PoJ_Vars.TargetPet = nil
  PoJ_CVars.ActionBarManastone = nil
  PoJ_CVars.AspectAutoCancel = nil
  PoJ_CVars.AuraActivation = nil
  PoJ_CVars.AuraActivation2 = nil
  PoJ_CVars.CancelSalvation = nil
  PoJ_CVars.RadarActivation = nil
  PoJ_CVars.ShowSummonFailure = nil
  PoJ_CVars.ShowSummonMessage = nil
  PoJ_CVars.ShowSummonSuccess = nil
  PoJ_CVars.ShowSoulStoneCooldown = nil
  PoJ_CVars.ShowSoulStoneNotice = nil
  PoJ_CVars.tracking = nil
end


function PoJ_DefineVars_CVars()
  local value
  if PoJ_Vars.PlayerNamesShow == nil then
    PoJ_Vars.PlayerNamesShow = {}
  end
  if PoJ_Vars.PlayerNamesShow.Comp == nil then
    value = PoJ_GetCVarFlag("UnitNameNonCombatCreatureName")
    PoJ_Vars.PlayerNamesShow.Comp = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
  end
  if PoJ_Vars.PlayerNamesShow.Guild == nil then
    value = PoJ_GetCVarFlag("UnitNamePlayerGuild")
    PoJ_Vars.PlayerNamesShow.Guild = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
  end
  if PoJ_Vars.PlayerNamesShow.GTit == nil then
    value = PoJ_GetCVarFlag("UnitNameGuildTitle")
    PoJ_Vars.PlayerNamesShow.GTit = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
  end
  if PoJ_Vars.PlayerNamesShow.NPCs == nil then
    value = PoJ_GetCVarFlag("UnitNameNPC")
    PoJ_Vars.PlayerNamesShow.NPCs = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
  end
  if PoJ_Vars.PlayerNamesShow.PetsE == nil then
    value = PoJ_GetCVarFlag("UnitNameEnemyPetName")
    PoJ_Vars.PlayerNamesShow.PetsE = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
    value = PoJ_GetCVarFlag("UnitNameFriendlyPetName")
    PoJ_Vars.PlayerNamesShow.PetsF = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
  end
  if PoJ_Vars.PlayerNamesShow.PlayE == nil then
    value = PoJ_GetCVarFlag("UnitNameEnemyPlayerName")
    PoJ_Vars.PlayerNamesShow.PlayE = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
    value = PoJ_GetCVarFlag("UnitNameFriendlyPlayerName")
    PoJ_Vars.PlayerNamesShow.PlayF = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
  end
  if PoJ_Vars.PlayerNamesShow.Rank == nil then
    value = PoJ_GetCVarFlag("UnitNamePlayerPVPTitle")
    PoJ_Vars.PlayerNamesShow.Rank = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
  end
  if PoJ_Vars.PlayerNamesShow.Self == nil then
    value = PoJ_GetCVarFlag("UnitNameOwn")
    PoJ_Vars.PlayerNamesShow.Self = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
  end
  -- add new vars for patch 4.0
  if PoJ_Vars.PlayerNamesShow.GuarE == nil then
    if PoJ_Vars.PlayerNamesShow.CreaE then
      PoJ_Vars.PlayerNamesShow.GuarE = PoJ_Vars.PlayerNamesShow.CreaE
      PoJ_Vars.PlayerNamesShow.GuarF = PoJ_Vars.PlayerNamesShow.CreaF
      PoJ_Vars.PlayerNamesShow.TotE = PoJ_Vars.PlayerNamesShow.CreaE
      PoJ_Vars.PlayerNamesShow.TotF = PoJ_Vars.PlayerNamesShow.CreaF
      PoJ_Vars.PlayerNamesShow.CreaE = nil
      PoJ_Vars.PlayerNamesShow.CreaF = nil
    else
      value = PoJ_GetCVarFlag("UnitNameEnemyGuardianName")
      PoJ_Vars.PlayerNamesShow.GuarE = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
      value = PoJ_GetCVarFlag("UnitNameFriendlyGuardianName")
      PoJ_Vars.PlayerNamesShow.GuarF = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
      value = PoJ_GetCVarFlag("UnitNameEnemyTotemName")
      PoJ_Vars.PlayerNamesShow.TotE = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
      value = PoJ_GetCVarFlag("UnitNameFriendlyTotemName")
      PoJ_Vars.PlayerNamesShow.TotF = {Norm = value, City = value, Inst = value, In10 = value, In40 = value, Raid = value, BG = value, NoUI = value}
    end
  end
end
