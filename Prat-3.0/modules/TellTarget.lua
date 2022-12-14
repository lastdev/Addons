---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2018  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to:
--
-- Free Software Foundation, Inc., 
-- 51 Franklin Street, Fifth Floor, 
-- Boston, MA  02110-1301, USA.
--
--
-------------------------------------------------------------------------------





Prat:AddModuleToLoad(function()

  local PRAT_MODULE = Prat:RequestModuleName("TellTarget")

  if PRAT_MODULE == nil then
    return
  end

  local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")

  local PL = module.PL

  --[==[@debug@
  PL:AddLocale(PRAT_MODULE, "enUS", {
    ["TellTarget"] = true,
    ["Adds telltarget slash command (/tt)."] = true,
    ["Target does not exist."] = true,
    ["Target is not a player."] = true,
    ["No target selected."] = true,
    ["NoTarget"] = true,
    ["/tt"] = true,
  })
  --@end-debug@]==]

  -- These Localizations are auto-generated. To help with localization
  -- please go to http://www.wowace.com/projects/prat-3-0/localization/
  --@non-debug@
 do
     local L

 
L = {
	["TellTarget"] = {
		["/tt"] = true,
		["Adds telltarget slash command (/tt)."] = true,
		["No target selected."] = true,
		["NoTarget"] = true,
		["Target does not exist."] = true,
		["Target is not a player."] = true,
		["TellTarget"] = true,
	}
}


   PL:AddLocale(PRAT_MODULE, "enUS",L)


 
L = {
	["TellTarget"] = {
		["/tt"] = true,
		["Adds telltarget slash command (/tt)."] = "Ajoute la commande telltarget (/tt) pour envoyer un message priv?? au joueur cibl??.",
		["No target selected."] = "Pas de cible s??lectionn??e.",
		["NoTarget"] = "PasDeCible",
		["Target does not exist."] = "La cible n'existe pas.",
		["Target is not a player."] = "La cible n'est pas un joueur.",
		["TellTarget"] = true,
	}
}


   PL:AddLocale(PRAT_MODULE, "frFR",L)


 
L = {
	["TellTarget"] = {
		["/tt"] = true,
		["Adds telltarget slash command (/tt)."] = "F??gt den Slash-Befehl Ziel Sagen (/tt) hinzu.",
		["No target selected."] = "Kein Ziel ausgew??hlt.",
		["NoTarget"] = "KeinZiel",
		["Target does not exist."] = "Ziel existiert nicht.",
		["Target is not a player."] = "Ziel ist kein Spieler.",
		["TellTarget"] = "Ziel Sagen",
	}
}


   PL:AddLocale(PRAT_MODULE, "deDE",L)


 
L = {
	["TellTarget"] = {
		["/tt"] = "/??????",
		["Adds telltarget slash command (/tt)."] = "???????????? ????????? ????????? ???????????? ??????????????? (/tt).",
		["No target selected."] = "????????? ???????????? ???????????????.",
		["NoTarget"] = "?????? ??????",
		["Target does not exist."] = "????????? ???????????? ????????????.",
		["Target is not a player."] = "????????? ??????????????? ????????????.",
		["TellTarget"] = "???????????? ?????????",
	}
}


   PL:AddLocale(PRAT_MODULE, "koKR",L)


 
L = {
	["TellTarget"] = {
		--[[Translation missing --]]
		["/tt"] = "/tt",
		--[[Translation missing --]]
		["Adds telltarget slash command (/tt)."] = "Adds telltarget slash command (/tt).",
		--[[Translation missing --]]
		["No target selected."] = "No target selected.",
		--[[Translation missing --]]
		["NoTarget"] = "NoTarget",
		--[[Translation missing --]]
		["Target does not exist."] = "Target does not exist.",
		--[[Translation missing --]]
		["Target is not a player."] = "Target is not a player.",
		--[[Translation missing --]]
		["TellTarget"] = "TellTarget",
	}
}


   PL:AddLocale(PRAT_MODULE, "esMX",L)


 
L = {
	["TellTarget"] = {
		["/tt"] = true,
		["Adds telltarget slash command (/tt)."] = "?????????????????? ????????-?????????????? '?????????????? ?? ????????' (/tt).",
		["No target selected."] = "?????? ?????????????????? ????????.",
		["NoTarget"] = "?????? ????????",
		["Target does not exist."] = "???????? ???? ????????????????????.",
		["Target is not a player."] = "?????????????????? ???????? ???? ???????????????? ??????????????.",
		["TellTarget"] = "?????????????? ????????",
	}
}


   PL:AddLocale(PRAT_MODULE, "ruRU",L)


 
L = {
	["TellTarget"] = {
		["/tt"] = true,
		["Adds telltarget slash command (/tt)."] = "??????????????????????????????(/tt).",
		["No target selected."] = "??????????????????",
		["NoTarget"] = "?????????",
		["Target does not exist."] = "???????????????",
		["Target is not a player."] = "????????????????????????",
		["TellTarget"] = "????????????",
	}
}


   PL:AddLocale(PRAT_MODULE, "zhCN",L)


 
L = {
	["TellTarget"] = {
		["/tt"] = true,
		["Adds telltarget slash command (/tt)."] = "A??ade comando decir a objetivo (/tt).",
		["No target selected."] = "Sin objetivo seleccionado.",
		["NoTarget"] = "SinObjetivo",
		["Target does not exist."] = "El Objetivo no existe.",
		["Target is not a player."] = "El Objetivo no es un jugador.",
		["TellTarget"] = "DecirObjetivo",
	}
}


   PL:AddLocale(PRAT_MODULE, "esES",L)


 
L = {
	["TellTarget"] = {
		["/tt"] = true,
		["Adds telltarget slash command (/tt)."] = "?????? telltarget ???????????????/tt???",
		["No target selected."] = "???????????????",
		["NoTarget"] = "????????????",
		["Target does not exist."] = "??????????????????",
		["Target is not a player."] = "?????????????????????",
		["TellTarget"] = true,
	}
}


   PL:AddLocale(PRAT_MODULE, "zhTW",L)


 end
 --@end-non-debug@

  -- create prat module

  Prat:SetModuleDefaults(module.name, {
    profile = {
      on = true,
    }
  })

  Prat:SetModuleOptions(module.name, {
    name = PL["TellTarget"],
    desc = PL["Adds telltarget slash command (/tt)."],
    type = "group",
    args = {
      info = {
        name = PL["Adds telltarget slash command (/tt)."],
        type = "description",
      }
    }
  })

  --[[------------------------------------------------
      Module Event Functions
  ------------------------------------------------]] --
  function module:OnModuleEnable()
    self:HookScript(ChatFrame1EditBox, "OnTextChanged")
  end

  function module:OnModuleDisable()
    self:UnhookAll()
  end

  --[[------------------------------------------------
      Core Functions
  ------------------------------------------------]] --

  function module:GetDescription()
    return PL["Adds telltarget slash command (/tt)."]
  end

  function module:OnTextChanged(editBox, ...)
    local command, msg = editBox:GetText():match("^(/%S+)%s(.*)$")
    if command == "/tt" or command == PL["/tt"] then
      self:SendTellToTarget(editBox.chatFrame, msg, editBox)
    end
    self.hooks[editBox].OnTextChanged(editBox, ...)
  end

  function module:SendTellToTarget(frame, text, editBox)
    if frame == nil then frame = DEFAULT_CHAT_FRAME end

    local unitname, realm, fullname
    if UnitIsPlayer("target") then
      unitname, realm = UnitName("target")
      if unitname then
        if realm and UnitRealmRelationship("target") ~= LE_REALM_RELATION_SAME then
          fullname = unitname .. "-" .. realm
        else
          fullname = unitname
        end
      end
    end

    local target = fullname and fullname:gsub(" ", "") or PL["NoTarget"]

    if editBox then
      editBox:SetAttribute("chatType", "WHISPER");
      editBox:SetAttribute("tellTarget", target);
      editBox:SetText(text)
      ChatEdit_UpdateHeader(editBox);
    else
      ChatFrame_SendTell(target, frame)
    end
  end

  local function TellTarget(msg)
    module:SendTellToTarget(SELECTED_CHAT_FRAME, msg)
  end

  return
end) -- Prat:AddModuleToLoad