--if Prat.BN_CHAT then return end -- Removed in 3.3.5 

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

  local PRAT_MODULE = Prat:RequestModuleName("Buttons")

  if PRAT_MODULE == nil then
    return
  end

  local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")
  local PL = module.PL

  --[==[@debug@
  PL:AddLocale(PRAT_MODULE, "enUS", {
    ["Buttons"] = true,
    ["Chat window button options."] = true,
    ["chatmenu_name"] = "Show Chat Menu",
    ["chatmenu_desc"] = "Toggles chat menu on and off.",
    ["Show Arrows"] = true,
    ["Toggle showing chat arrows for each chat window."] = true,
    ["Show Chat%d Arrows"] = true,
    ["Toggles navigation arrows on and off."] = true,
    ["scrollReminder_name"] = "Show ScrollDown Reminder",
    ["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window.",
    ["Set Position"] = true,
    ["Sets position of chat menu and arrows for all chat windows."] = true,
    ["Default"] = true,
    ["Right, Inside Frame"] = true,
    ["Right, Outside Frame"] = true,
    ["alpha_name"] = "Set Alpha",
    ["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows.",
    ["showmenu_name"] = "Show Menu",
    ["showmenu_desc"] = "Show Chat Menu",
    ["showbnet_name"] = "Show Social Menu",
    ["showbnet_desc"] = "Show Social Menu",
    ["showminimize_name"] = "Show Minimize Button",
    ["showminimize_desc"] = "Show Minimize Button",
    ["showvoice_name"] = "Show Voice Buttons",
    ["showvoice_desc"] = "Show Voice Buttons",
    ["showchannel_name"] = "Show Channel Button",
    ["showchannel_desc"] = "Show Channel Button",
  })
  --@end-debug@]==]

  -- These Localizations are auto-generated. To help with localization
  -- please go to http://www.wowace.com/projects/prat-3-0/localization/


  --@non-debug@
do
    local L


L = {
	["Buttons"] = {
		["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows.",
		["alpha_name"] = "Set Alpha",
		["Buttons"] = true,
		["Chat window button options."] = true,
		["chatmenu_desc"] = "Toggles chat menu on and off.",
		["chatmenu_name"] = "Show Chat Menu",
		["Default"] = true,
		["Right, Inside Frame"] = true,
		["Right, Outside Frame"] = true,
		["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window.",
		["scrollReminder_name"] = "Show ScrollDown Reminder",
		["Set Position"] = true,
		["Sets position of chat menu and arrows for all chat windows."] = true,
		["Show Arrows"] = true,
		["Show Chat%d Arrows"] = true,
		["showbnet_desc"] = "Show Social Menu",
		["showbnet_name"] = "Show Social Menu",
		["showchannel_desc"] = "Show Channel Button",
		["showchannel_name"] = "Show Channel Button",
		["showmenu_desc"] = "Show Chat Menu",
		["showmenu_name"] = "Show Menu",
		["showminimize_desc"] = "Show Minimize Button",
		["showminimize_name"] = "Show Minimize Button",
		["showvoice_desc"] = "Show Voice Buttons",
		["showvoice_name"] = "Show Voice Buttons",
		["Toggle showing chat arrows for each chat window."] = true,
		["Toggles navigation arrows on and off."] = true,
	}
}

PL:AddLocale(PRAT_MODULE, "enUS", L)



L = {
	["Buttons"] = {
		--[[Translation missing --]]
		["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows.",
		--[[Translation missing --]]
		["alpha_name"] = "Set Alpha",
		--[[Translation missing --]]
		["Buttons"] = "Buttons",
		--[[Translation missing --]]
		["Chat window button options."] = "Chat window button options.",
		--[[Translation missing --]]
		["chatmenu_desc"] = "Toggles chat menu on and off.",
		--[[Translation missing --]]
		["chatmenu_name"] = "Show Chat Menu",
		--[[Translation missing --]]
		["Default"] = "Default",
		--[[Translation missing --]]
		["Right, Inside Frame"] = "Right, Inside Frame",
		--[[Translation missing --]]
		["Right, Outside Frame"] = "Right, Outside Frame",
		--[[Translation missing --]]
		["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window.",
		--[[Translation missing --]]
		["scrollReminder_name"] = "Show ScrollDown Reminder",
		--[[Translation missing --]]
		["Set Position"] = "Set Position",
		--[[Translation missing --]]
		["Sets position of chat menu and arrows for all chat windows."] = "Sets position of chat menu and arrows for all chat windows.",
		--[[Translation missing --]]
		["Show Arrows"] = "Show Arrows",
		--[[Translation missing --]]
		["Show Chat%d Arrows"] = "Show Chat%d Arrows",
		--[[Translation missing --]]
		["showbnet_desc"] = "Show Social Menu",
		--[[Translation missing --]]
		["showbnet_name"] = "Show Social Menu",
		--[[Translation missing --]]
		["showchannel_desc"] = "Show Channel Button",
		--[[Translation missing --]]
		["showchannel_name"] = "Show Channel Button",
		--[[Translation missing --]]
		["showmenu_desc"] = "Show Chat Menu",
		--[[Translation missing --]]
		["showmenu_name"] = "Show Menu",
		--[[Translation missing --]]
		["showminimize_desc"] = "Show Minimize Button",
		--[[Translation missing --]]
		["showminimize_name"] = "Show Minimize Button",
		--[[Translation missing --]]
		["showvoice_desc"] = "Show Voice Buttons",
		--[[Translation missing --]]
		["showvoice_name"] = "Show Voice Buttons",
		--[[Translation missing --]]
		["Toggle showing chat arrows for each chat window."] = "Toggle showing chat arrows for each chat window.",
		--[[Translation missing --]]
		["Toggles navigation arrows on and off."] = "Toggles navigation arrows on and off.",
	}
}

PL:AddLocale(PRAT_MODULE, "itIT", L)



L = {
	["Buttons"] = {
		--[[Translation missing --]]
		["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows.",
		--[[Translation missing --]]
		["alpha_name"] = "Set Alpha",
		--[[Translation missing --]]
		["Buttons"] = "Buttons",
		--[[Translation missing --]]
		["Chat window button options."] = "Chat window button options.",
		--[[Translation missing --]]
		["chatmenu_desc"] = "Toggles chat menu on and off.",
		--[[Translation missing --]]
		["chatmenu_name"] = "Show Chat Menu",
		--[[Translation missing --]]
		["Default"] = "Default",
		--[[Translation missing --]]
		["Right, Inside Frame"] = "Right, Inside Frame",
		--[[Translation missing --]]
		["Right, Outside Frame"] = "Right, Outside Frame",
		--[[Translation missing --]]
		["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window.",
		--[[Translation missing --]]
		["scrollReminder_name"] = "Show ScrollDown Reminder",
		--[[Translation missing --]]
		["Set Position"] = "Set Position",
		--[[Translation missing --]]
		["Sets position of chat menu and arrows for all chat windows."] = "Sets position of chat menu and arrows for all chat windows.",
		--[[Translation missing --]]
		["Show Arrows"] = "Show Arrows",
		--[[Translation missing --]]
		["Show Chat%d Arrows"] = "Show Chat%d Arrows",
		--[[Translation missing --]]
		["showbnet_desc"] = "Show Social Menu",
		--[[Translation missing --]]
		["showbnet_name"] = "Show Social Menu",
		--[[Translation missing --]]
		["showchannel_desc"] = "Show Channel Button",
		--[[Translation missing --]]
		["showchannel_name"] = "Show Channel Button",
		--[[Translation missing --]]
		["showmenu_desc"] = "Show Chat Menu",
		--[[Translation missing --]]
		["showmenu_name"] = "Show Menu",
		--[[Translation missing --]]
		["showminimize_desc"] = "Show Minimize Button",
		--[[Translation missing --]]
		["showminimize_name"] = "Show Minimize Button",
		--[[Translation missing --]]
		["showvoice_desc"] = "Show Voice Buttons",
		--[[Translation missing --]]
		["showvoice_name"] = "Show Voice Buttons",
		--[[Translation missing --]]
		["Toggle showing chat arrows for each chat window."] = "Toggle showing chat arrows for each chat window.",
		--[[Translation missing --]]
		["Toggles navigation arrows on and off."] = "Toggles navigation arrows on and off.",
	}
}

PL:AddLocale(PRAT_MODULE, "ptBR", L)



L = {
	["Buttons"] = {
		["alpha_desc"] = "D??finit la transparence du menu du chat et des fl??ches pour toutes les fen??tres de discussion.",
		["alpha_name"] = "D??finir la transparence",
		["Buttons"] = "Boutons",
		["Chat window button options."] = "Options des boutons de la fen??tre de discussion.",
		["chatmenu_desc"] = "Activer et d??sactiver le menu du tchat",
		["chatmenu_name"] = "Montrer le menu du chat",
		["Default"] = "D??faut",
		["Right, Inside Frame"] = "Droite, dans le cadre",
		["Right, Outside Frame"] = "Droite, en dehors du cadre",
		["scrollReminder_desc"] = "Montrer le bouton de rappel lorsque vous n'??tes pas ?? la fin de la fen??tre de discussion.",
		["scrollReminder_name"] = "Montrer le rappel",
		["Set Position"] = "D??finir la position",
		["Sets position of chat menu and arrows for all chat windows."] = "D??finir la position du menu et des fl??ches de toutes les fen??tres de discussion.",
		["Show Arrows"] = "Montrer les fl??ches",
		["Show Chat%d Arrows"] = "Afficher les boutons fl??ch??s du chat",
		["showbnet_desc"] = "Montrer le menu Social.",
		["showbnet_name"] = "Montrer le menu Social",
		--[[Translation missing --]]
		["showchannel_desc"] = "Show Channel Button",
		--[[Translation missing --]]
		["showchannel_name"] = "Show Channel Button",
		["showmenu_desc"] = "Montrer le menu de la fen??tre de discussion.",
		["showmenu_name"] = "Montrer le menu",
		["showminimize_desc"] = "Montrer le bouton pour minimiser la discussion.",
		["showminimize_name"] = "Montrer Minimiser",
		--[[Translation missing --]]
		["showvoice_desc"] = "Show Voice Buttons",
		--[[Translation missing --]]
		["showvoice_name"] = "Show Voice Buttons",
		["Toggle showing chat arrows for each chat window."] = "Activer l'affichage des fl??ches pour chaque fen??tre de discussion.",
		["Toggles navigation arrows on and off."] = "Activer et d??sactiver les fl??ches de navigations",
	}
}

PL:AddLocale(PRAT_MODULE, "frFR", L)



L = {
	["Buttons"] = {
		["alpha_desc"] = "Stellt die Transparenz der Chatmen??s und Navigationspfeile aller Chatfenster ein.",
		["alpha_name"] = "Transparenz einstellen",
		["Buttons"] = "Schaltfl??chen",
		["Chat window button options."] = "Optionen f??r Schaltfl??chen im Chatfenster.",
		["chatmenu_desc"] = "Schaltet das Chatmen?? ein/aus.",
		["chatmenu_name"] = "Chatmen?? anzeigen",
		["Default"] = "Standard",
		["Right, Inside Frame"] = "Rechts, innerhalb des Rahmens",
		["Right, Outside Frame"] = "Rechts, au??erhalb des Rahmens",
		["scrollReminder_desc"] = "Erinnerungsschaltfl??che anzeigen, wenn du nicht am unteren Rand eines Chat-Fensters bist.",
		["scrollReminder_name"] = "Runterscrollen-Erinnerung anzeigen",
		["Set Position"] = "Position einstellen",
		["Sets position of chat menu and arrows for all chat windows."] = "Stellt die Position des Chatmen??s und der Navigationspfeile f??r alle Chatfenster ein.",
		["Show Arrows"] = "Zeige die Navigationspfeile",
		["Show Chat%d Arrows"] = "Navigationspfeile im Chat%d anzeigen",
		["showbnet_desc"] = "Geselligkeitsmen?? anzeigen",
		["showbnet_name"] = "Geselligkeitsmen?? anzeigen",
		["showchannel_desc"] = "Kanalschaltfl??che anzeigen",
		["showchannel_name"] = "Kanalschaltfl??che anzeigen",
		["showmenu_desc"] = "Chatmen?? anzeigen",
		["showmenu_name"] = "Zeige das Men??",
		["showminimize_desc"] = "Minimiertaste anzeigen",
		["showminimize_name"] = "Minimiertaste anzeigen",
		["showvoice_desc"] = "Sprachschaltfl??chen anzeigen",
		["showvoice_name"] = "Sprachschaltfl??chen anzeigen",
		["Toggle showing chat arrows for each chat window."] = "Anzeige der Navigationspfeile f??r jedes Chatfenster ein- und ausschalten.",
		["Toggles navigation arrows on and off."] = "Schaltet die Anzeige der Navigationspfeile an und aus",
	}
}

PL:AddLocale(PRAT_MODULE, "deDE", L)



L = {
	["Buttons"] = {
		["alpha_desc"] = "?????? ???????????? ?????? ????????? ???????????? ???????????? ???????????????.",
		["alpha_name"] = "????????? ??????",
		["Buttons"] = "?????? [Buttons]",
		["Chat window button options."] = "????????? ?????? ??????",
		["chatmenu_desc"] = "?????? ????????? ?????? ?????????.",
		["chatmenu_name"] = "?????? ?????? ??????",
		["Default"] = "?????????",
		["Right, Inside Frame"] = "??????, ????????? ??????",
		["Right, Outside Frame"] = "??????, ????????? ?????????",
		["scrollReminder_desc"] = "???????????? ?????? ????????? ??? ??? ????????? ????????? ???????????????.",
		["scrollReminder_name"] = "??? ????????? ?????? ??????",
		["Set Position"] = "?????? ??????",
		["Sets position of chat menu and arrows for all chat windows."] = "???????????? ????????? ???????????? ????????? ???????????????.",
		["Show Arrows"] = "????????? ??????",
		["Show Chat%d Arrows"] = "?????????%d??? ????????? ?????????",
		["showbnet_desc"] = "???????????? ?????? ??????",
		["showbnet_name"] = "???????????? ?????? ??????",
		["showchannel_desc"] = "?????? ?????? ?????????",
		["showchannel_name"] = "?????? ?????? ?????????",
		["showmenu_desc"] = "?????? ?????? ??????",
		["showmenu_name"] = "?????? ??????",
		["showminimize_desc"] = "????????? ?????? ??????",
		["showminimize_name"] = "????????? ?????? ??????",
		["showvoice_desc"] = "?????? ?????? ??????",
		["showvoice_name"] = "?????? ?????? ??????",
		["Toggle showing chat arrows for each chat window."] = "??? ????????? ?????? ????????? ????????? ?????? ?????????.",
		["Toggles navigation arrows on and off."] = "?????? ???????????? ?????? ?????????.",
	}
}

PL:AddLocale(PRAT_MODULE, "koKR",  L)


L = {
	["Buttons"] = {
		--[[Translation missing --]]
		["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows.",
		--[[Translation missing --]]
		["alpha_name"] = "Set Alpha",
		--[[Translation missing --]]
		["Buttons"] = "Buttons",
		--[[Translation missing --]]
		["Chat window button options."] = "Chat window button options.",
		--[[Translation missing --]]
		["chatmenu_desc"] = "Toggles chat menu on and off.",
		--[[Translation missing --]]
		["chatmenu_name"] = "Show Chat Menu",
		--[[Translation missing --]]
		["Default"] = "Default",
		--[[Translation missing --]]
		["Right, Inside Frame"] = "Right, Inside Frame",
		--[[Translation missing --]]
		["Right, Outside Frame"] = "Right, Outside Frame",
		--[[Translation missing --]]
		["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window.",
		--[[Translation missing --]]
		["scrollReminder_name"] = "Show ScrollDown Reminder",
		--[[Translation missing --]]
		["Set Position"] = "Set Position",
		--[[Translation missing --]]
		["Sets position of chat menu and arrows for all chat windows."] = "Sets position of chat menu and arrows for all chat windows.",
		--[[Translation missing --]]
		["Show Arrows"] = "Show Arrows",
		--[[Translation missing --]]
		["Show Chat%d Arrows"] = "Show Chat%d Arrows",
		--[[Translation missing --]]
		["showbnet_desc"] = "Show Social Menu",
		--[[Translation missing --]]
		["showbnet_name"] = "Show Social Menu",
		--[[Translation missing --]]
		["showchannel_desc"] = "Show Channel Button",
		--[[Translation missing --]]
		["showchannel_name"] = "Show Channel Button",
		--[[Translation missing --]]
		["showmenu_desc"] = "Show Chat Menu",
		--[[Translation missing --]]
		["showmenu_name"] = "Show Menu",
		--[[Translation missing --]]
		["showminimize_desc"] = "Show Minimize Button",
		--[[Translation missing --]]
		["showminimize_name"] = "Show Minimize Button",
		--[[Translation missing --]]
		["showvoice_desc"] = "Show Voice Buttons",
		--[[Translation missing --]]
		["showvoice_name"] = "Show Voice Buttons",
		--[[Translation missing --]]
		["Toggle showing chat arrows for each chat window."] = "Toggle showing chat arrows for each chat window.",
		--[[Translation missing --]]
		["Toggles navigation arrows on and off."] = "Toggles navigation arrows on and off.",
	}
}

PL:AddLocale(PRAT_MODULE, "esMX",  L)


L = {
	["Buttons"] = {
		["alpha_desc"] = "?????????????????? ???????????????????????? ???????????? ???????? ?? ???????? ??????????????.",
		["alpha_name"] = "????????????????????????",
		["Buttons"] = "????????????",
		["Chat window button options."] = "?????????????????? ???????????? ???????? ????????.",
		["chatmenu_desc"] = "??????/???????? ???????????? ????????.",
		["chatmenu_name"] = "???????????????? ???????????? ????????",
		["Default"] = "???? ??????????????????",
		["Right, Inside Frame"] = "????????????, ???????????? ????????",
		["Right, Outside Frame"] = "????????????, ?????? ????????",
		["scrollReminder_desc"] = "??????/???????? ??????????????????, ???????????????????????????????? ?? ??????, ?????? ???????? ???????? ?????????? ???????????????????????? ????????.",
		["scrollReminder_name"] = "?????????????????? ?????????????????? ????????",
		["Set Position"] = "??????????????????",
		["Sets position of chat menu and arrows for all chat windows."] = "???????????????????? ?????????????????? ?????????????? ?? ???????????? ???????? ?????? ???????? ????????.",
		["Show Arrows"] = "???????????????????? ??????????????",
		["Show Chat%d Arrows"] = "???????????????????? ?????????????? %d ????????",
		["showbnet_desc"] = "???????????????? ???????? ??????????????",
		["showbnet_name"] = "???????????????? ???????? ??????????????",
		["showchannel_desc"] = "???????????????? ???????????? ???????????? ",
		["showchannel_name"] = "???????????????? ???????????? ???????????? ",
		["showmenu_desc"] = "???????????????????? ???????? ????????????",
		["showmenu_name"] = "???????????????????? ????????",
		["showminimize_desc"] = "???????????????? ???????????? ??????????????????????",
		["showminimize_name"] = "???????????????? ???????????? ??????????????????????",
		["showvoice_desc"] = "???????????????? ?????????????????? ????????????  ",
		["showvoice_name"] = "???????????????? ?????????????????? ????????????  ",
		["Toggle showing chat arrows for each chat window."] = "???????????????????? ?????????????? ?????? ?????????????? ???????? ????????.",
		["Toggles navigation arrows on and off."] = "??????/???????? ?????????????????????????? ??????????????.",
	}
}

PL:AddLocale(PRAT_MODULE, "ruRU",  L)


L = {
	["Buttons"] = {
		["alpha_desc"] = "?????????????????????????????????????????????????????????",
		["alpha_name"] = "???????????????",
		["Buttons"] = "??????",
		["Chat window button options."] = "????????????????????????",
		["chatmenu_desc"] = "?????????????????????",
		["chatmenu_name"] = "????????????_??????",
		["Default"] = "??????",
		["Right, Inside Frame"] = "???????????????",
		["Right, Outside Frame"] = "???????????????",
		["scrollReminder_desc"] = "????????????????????????????????????????????????",
		["scrollReminder_name"] = "????????????????????????",
		["Set Position"] = "????????????",
		["Sets position of chat menu and arrows for all chat windows."] = "??????????????????????????????????????????????????????",
		["Show Arrows"] = "????????????",
		["Show Chat%d Arrows"] = "????????????%d??????",
		["showbnet_desc"] = "??????????????????",
		["showbnet_name"] = "??????????????????",
		["showchannel_desc"] = "?????????????????? ",
		["showchannel_name"] = "?????????????????? ",
		["showmenu_desc"] = "??????????????????",
		["showmenu_name"] = "????????????",
		["showminimize_desc"] = "?????????????????????",
		["showminimize_name"] = "?????????????????????",
		["showvoice_desc"] = "?????????????????? ",
		["showvoice_name"] = "??????????????????",
		["Toggle showing chat arrows for each chat window."] = "?????????????????????????????????????????????",
		["Toggles navigation arrows on and off."] = "???????????????????????????",
	}
}

PL:AddLocale(PRAT_MODULE, "zhCN",  L)


L = {
	["Buttons"] = {
		["alpha_desc"] = "Establece la transparencia del menu del chat y de las flechas para todas las ventanas.",
		["alpha_name"] = "Establecer Transparencia",
		["Buttons"] = "Botones",
		["Chat window button options."] = "Opciones de los botones de la ventana del chat",
		["chatmenu_desc"] = "Alterna la activaci??n del men?? del chat.",
		["chatmenu_name"] = "Mostrar Men?? del Chat",
		["Default"] = "Predeterminado",
		["Right, Inside Frame"] = "Derecha, Dentro del Marco",
		["Right, Outside Frame"] = "Derecha, Fuera del Marco",
		["scrollReminder_desc"] = "Muestra el bot??n recordatorio cuando no se est?? en la parte inferior de la ventana de chat.",
		["scrollReminder_name"] = "Mostrar Recordatorio de Desplazamiento Abajo",
		["Set Position"] = "Establecer Posici??n",
		["Sets position of chat menu and arrows for all chat windows."] = "Establece la posici??n del men?? y de las flechas de todas las ventanas de chat.",
		["Show Arrows"] = "Mostar Flechas",
		["Show Chat%d Arrows"] = "Mostar Flechas del Chat %d",
		["showbnet_desc"] = "Muestra Bot??n Social",
		["showbnet_name"] = "Mostrar Bot??n Social",
		["showchannel_desc"] = "Muestra el bot??n de canales de chat",
		["showchannel_name"] = "Mostrar Bot??n de Canales",
		["showmenu_desc"] = "Muestra el bot??n de men?? del chat",
		["showmenu_name"] = "Mostrar Men??",
		["showminimize_desc"] = "Muestra el bot??n de minimizar",
		["showminimize_name"] = "Mostrar bot??n de minimizar",
		["showvoice_desc"] = "Muestra los botones de voz",
		["showvoice_name"] = "Mostrar botones de voz",
		["Toggle showing chat arrows for each chat window."] = "Alterna el mostrar las flechas para cada ventana de chat.",
		["Toggles navigation arrows on and off."] = "Alterna la activaci??n de las flechas de navegaci??n.",
	}
}

PL:AddLocale(PRAT_MODULE, "esES",  L)


L = {
	["Buttons"] = {
		["alpha_desc"] = "??????????????????????????????????????????????????????",
		["alpha_name"] = "???????????????",
		["Buttons"] = "??????",
		["Chat window button options."] = "???????????????????????????",
		["chatmenu_desc"] = "?????????????????????????????????",
		["chatmenu_name"] = "??????????????????",
		["Default"] = "?????????",
		["Right, Inside Frame"] = "?????????????????????",
		["Right, Outside Frame"] = "?????????????????????",
		["scrollReminder_desc"] = "????????????????????????????????????????????????",
		["scrollReminder_name"] = "????????????????????????????????????",
		["Set Position"] = "????????????",
		["Sets position of chat menu and arrows for all chat windows."] = "????????????????????????????????????????????????????????????",
		["Show Arrows"] = "????????????",
		["Show Chat%d Arrows"] = "???????????? %d ?????????",
		["showbnet_desc"] = "??????????????????",
		["showbnet_name"] = "??????????????????",
		--[[Translation missing --]]
		["showchannel_desc"] = "Show Channel Button",
		--[[Translation missing --]]
		["showchannel_name"] = "Show Channel Button",
		["showmenu_desc"] = "??????????????????",
		["showmenu_name"] = "????????????",
		["showminimize_desc"] = "?????????????????????",
		["showminimize_name"] = "?????????????????????",
		--[[Translation missing --]]
		["showvoice_desc"] = "Show Voice Buttons",
		--[[Translation missing --]]
		["showvoice_name"] = "Show Voice Buttons",
		["Toggle showing chat arrows for each chat window."] = "?????????????????????????????????????????????",
		["Toggles navigation arrows on and off."] = "??????/??????????????????",
	}
}

PL:AddLocale(PRAT_MODULE, "zhTW",  L)
end
--@end-non-debug@



  Prat:SetModuleDefaults(module.name, {
    profile = {
      on = true,
      scrollReminder = true,
      showButtons = true,
      showBnet = true,
      showMenu = true,
      showminimize = true,
      showvoice = true,
      showchannel = true,
    }
  })

  Prat:SetModuleOptions(module.name, {
    name = PL["Buttons"],
    desc = PL["Chat window button options."],
    type = "group",
    args = {
      showButtons = {
        name = PL["Show Arrows"],
        desc = PL["Toggle showing chat arrows for each chat window."],
        type = "toggle",
        order = 100
      },
      scrollReminder = {
        name = PL["scrollReminder_name"],
        desc = PL["scrollReminder_desc"],
        type = "toggle",
        order = 110
      },
      showBnet = {
        name = PL["showbnet_name"],
        desc = PL["showbnet_desc"],
        type = "toggle",
        order = 120
      },
      showMenu = {
        name = PL["showmenu_name"],
        desc = PL["showmenu_desc"],
        type = "toggle",
        order = 130
      },
      showminimize = {
        name = PL["showminimize_name"],
        desc = PL["showminimize_desc"],
        type = "toggle",
        order = 140
      },
      showvoice = {
        name = PL["showvoice_name"],
        desc = PL["showvoice_desc"],
        type = "toggle",
        order = 150,
      },
      showchannel = {
        name = PL["showchannel_name"],
        desc = PL["showchannel_desc"],
        type = "toggle",
        order = 160,
      }
    }
  })

  --[[------------------------------------------------
    Module Event Functions
  ------------------------------------------------]] --
  local fmt = _G.string.format

  function module:GetDescription()
    return PL["Chat window button options."]
  end

  local function hide(self)
    if not self.override then
      self:Hide()
    end
    self.override = nil
  end

  function module:OnModuleEnable()
    local buttons3 = Prat.Addon:GetModule("OriginalButtons", true)
    if buttons3 and buttons3:IsEnabled() then
      self.disabledB3 = true
      buttons3.db.profile.on = false
      buttons3:Disable()
      LibStub("AceConfigRegistry-3.0"):NotifyChange("Prat")
    end

    self:APLyAllSettings()

    Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE)

    self:SecureHook("FCF_SetButtonSide")
  end

  function module:APLyAllSettings()
    if not self.db.profile.showButtons then
      self:HideButtons()
    else
      self:ShowButtons()
    end

    self:UpdateMenuButtons()

    self:AdjustMinimizeButtons()

    self:UpdateVoiceButtons()

    self:UpdateChannelButton()

    self:AdjustButtonFrames(self.db.profile.showButtons)

    self:UpdateReminder()
  end

  function module:OnModuleDisable()
    self:DisableBottomButton()
    self:ShowButtons()

    Prat.UnregisterAllChatEvents(self)
  end

  function module:UpdateReminder()
    local v = self.db.profile.scrollReminder
    if v then
      module:EnableBottomButton()
    elseif self.buttonsEnabled then
      module:DisableBottomButton()
    end
  end

  function module:OnValueChanged(info, b)
    self:APLyAllSettings()
  end

  function module:UpdateMenuButtons()
    if QuickJoinToastButton then
      if self.db.profile.showBnet then
        QuickJoinToastButton:Show()
      else
        QuickJoinToastButton:Hide()
      end
    end

    if self.db.profile.showMenu then
      ChatFrameMenuButton:SetScript("OnShow", nil)
      ChatFrameMenuButton:Show()
    else
      ChatFrameMenuButton:SetScript("OnShow", hide)
      ChatFrameMenuButton:Hide()
    end
  end


  function module:UpdateVoiceButtons()
    if ChatFrameToggleVoiceDeafenButton and ChatFrameToggleVoiceMuteButton then
      if self.db.profile.showvoice then
        ChatFrameToggleVoiceDeafenButton:SetScript("OnShow", nil)
        ChatFrameToggleVoiceMuteButton:SetScript("OnShow", nil)

        if C_VoiceChat.IsLoggedIn() then
          ChatFrameToggleVoiceDeafenButton:Show()
          ChatFrameToggleVoiceMuteButton:Show()
        end
      else
        ChatFrameToggleVoiceDeafenButton:SetScript("OnShow", hide)
        ChatFrameToggleVoiceDeafenButton:Hide()

        ChatFrameToggleVoiceMuteButton:SetScript("OnShow", hide)
        ChatFrameToggleVoiceMuteButton:Hide()
      end
    end
  end

  function module:UpdateChannelButton()
    if self.db.profile.showchannel then
      ChatFrameChannelButton:SetScript("OnShow", nil)
      ChatFrameChannelButton:Show()
    else
      ChatFrameChannelButton:SetScript("OnShow", hide)
      ChatFrameChannelButton:Hide()
    end
  end

  function module:HideButtons()
    self:UpdateMenuButtons()

    local upButton, downButton, bottomButton, min

    for name, frame in pairs(Prat.Frames) do
      if Prat.IsClassic then
        upButton = _G[name .. "ButtonFrameUpButton"]
        upButton:SetScript("OnShow", hide)
        upButton:Hide()
        downButton = _G[name .. "ButtonFrameDownButton"]
        downButton:SetScript("OnShow", hide)
        downButton:Hide()
        bottomButton = _G[name .. "ButtonFrameBottomButton"]
        bottomButton:SetScript("OnShow", hide)
        bottomButton:Hide()
        bottomButton:SetParent(frame)

        bottomButton:SetScript("OnClick", function() frame:ScrollToBottom() end)
      end
      self:FCF_SetButtonSide(frame)
    end

    self:AdjustMinimizeButtons()
  end

  function module:AdjustButtonFrames(visible)
    for name, frame in pairs(Prat.Frames) do
      local f = _G[name .. "ButtonFrame"]

      if visible then
        f:SetScript("OnShow", nil)
        f:Show()
        f:SetWidth(29)
      else
        f:SetScript("OnShow", hide)
        f:Hide()
        f:SetWidth(0.1)
      end
    end
  end

  function module:AdjustMinimizeButtons()
    for name, frame in pairs(Prat.Frames) do
      local min = _G[name .. "ButtonFrameMinimizeButton"]

      if min then

        if self.db.profile.showminimize then
          min:ClearAllPoints()

          min:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 2, 2)
          --min:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -32, -4);

          min:SetParent(_G[frame:GetName() .. "Tab"])

          min:SetScript("OnShow",
            function(self)
              if frame.isDocked then
                self:Hide()
              end
            end)

          min:SetScript("OnClick",
            function(self)
              FCF_MinimizeFrame(frame, strupper(frame.buttonSide))
            end)

          min:Show()
        else
          min:SetScript("OnShow", hide)
          min:Hide()
        end
      end
    end
  end

  function module:ShowButtons()
    self:Unhook("FCF_SetButtonSide")
    self:UpdateMenuButtons()
    local upButton, downButton, bottomButton

    for name, frame in pairs(Prat.Frames) do
      if Prat.IsClassic then
        upButton = _G[name .. "ButtonFrameUpButton"]
        upButton:SetScript("OnShow", nil)
        upButton:Show()
        downButton = _G[name .. "ButtonFrameDownButton"]
        downButton:SetScript("OnShow", nil)
        downButton:Show()
        bottomButton = _G[name .. "ButtonFrameBottomButton"]
        bottomButton:SetScript("OnShow", nil)
        bottomButton:Show()
        bottomButton:SetParent(_G[name .. "ButtonFrame"])
      end

      --		frame.buttonSide = nil
      --		bottomButton:ClearAllPoints()
      --		bottomButton:SetPoint("BOTTOMRIGHT", _G[name.."ButtonFrame"], "BOTTOMLEFT", 2, 2)
      --		bottomButton:SetPoint("BOTTOMLEFT", _G[name.."ButtonFrame"], "BOTTOMLEFT", -32, -4);
      --FCF_UpdateButtonSide(frame)

      --bottomButton:SetScript("OnClick", function() frame:ScrollToBottom() end)

      self:FCF_SetButtonSide(frame)
    end

    self:AdjustMinimizeButtons()
  end

  --[[ - - ------------------------------------------------
    Core Functions
  --------------------------------------------- - ]] --
  function module:FCF_SetButtonSide(chatFrame, buttonSide)
    local f = _G[chatFrame:GetName() .. "ButtonFrameBottomButton"]
    local bf = _G[chatFrame:GetName() .. "ButtonFrame"]

    if Prat.IsClassic then
      if self.db.profile.showButtons then
        f:ClearAllPoints()
        f:SetPoint("BOTTOM", bf, "BOTTOM", 0, 0)
      else
        f:ClearAllPoints()
        f:SetPoint("BOTTOMRIGHT", chatFrame, "BOTTOMRIGHT", 2, 2)
      end
    end
  end


  function module:EnableBottomButton()
    if self.buttonsEnabled then return end
    self.buttonsEnabled = true
    for name, f in pairs(Prat.Frames) do
      self:SecureHook(f, "ScrollUp")
      self:SecureHook(f, "ScrollToTop", "ScrollUp")
      self:SecureHook(f, "PageUp", "ScrollUp")

      self:SecureHook(f, "ScrollDown")
      self:SecureHook(f, "ScrollToBottom", "ScrollDownForce")
      self:SecureHook(f, "PageDown", "ScrollDown")

      local button = _G[name .. "ButtonFrameBottomButton"]

      if button then
        if f:GetScrollOffset() ~= 0 then
          button.override = true
          button:Show()
        else
          button:Hide()
        end
      end
    end
  end

  function module:DisableBottomButton()
    if not self.buttonsEnabled then return end
    self.buttonsEnabled = false
    for name, f in pairs(Prat.Frames) do
      if f then
        self:Unhook(f, "ScrollUp")
        self:Unhook(f, "ScrollToTop")
        self:Unhook(f, "PageUp")
        self:Unhook(f, "ScrollDown")
        self:Unhook(f, "ScrollToBottom")
        self:Unhook(f, "PageDown")
        local button = _G[name .. "ButtonFrameBottomButton"]
        if button then button:Hide() end
      end
    end
  end

  function module:ScrollUp(frame)
    local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]
    if button then
      button.override = true
      button:Show()
    end
  end

  function module:ScrollDown(frame)
    if frame:GetScrollOffset() == 0 then
      local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]
      if button then
        button:Hide()
      end
    end
  end

  function module:ScrollDownForce(frame)
    local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]
    if button then
      button:Hide()
    end
  end

  --function module:AddMessage(frame, text, ...)
  function module:Prat_PostAddMessage(info, message, frame, event, text, r, g, b, id)
    local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]

    if not button then return end
    if frame:GetScrollOffset() > 0 then
      button.override = true
      button:Show()
    else
      button:Hide()
    end
  end


  return
end) -- Prat:AddModuleToLoad
