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

  local PRAT_MODULE = Prat:RequestModuleName("History")

  if PRAT_MODULE == nil then
    return
  end

  local module = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")

  local PL = module.PL

  --[==[@debug@
  PL:AddLocale(PRAT_MODULE, "enUS", {
    ["History"] = true,
    ["Chat history options."] = true,
    ["Set Chat Lines"] = true,
    ["Set the number of lines of chat history for each window."] = true,
    ["Set Command History"] = true,
    ["Maximum number of lines of command history to save."] = true,
    ["Save Command History"] = true,
    ["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = true,
    ["Scrollback"] = true,
    ["Store the chat lines between sessions"] = true,
    ["Scrollback Options"] = true,
    ["Command History Options"] = true,
    divider = "========== End of Scrollback ==========",
    scrollbackduration_name = "Scrollback Duration",
    scrollbackduration_desc = "How many hours to keep the saved messages.",
    ["Colors the GMOTD label"] = true,
    ["Color GMOTD"] = true,
    delaygmotd_name = "Delay GMOTD",
    delaygmotd_desc = "Delay GMOTD until after all the startup spam",
    bnet_removed = "<BNET REMOVED>",
    removespam_name = "Remove Spam",
    removespam_desc = "Remove addon spam messages when restoring the chat history"
  })
  --@end-debug@]==]

  -- These Localizations are auto-generated. To help with localization
  -- please go to http://www.wowace.com/projects/prat-3-0/localization/
  --@non-debug@
 do
     local L


L = {
	["History"] = {
		["bnet_removed"] = "<BNET REMOVED>",
		["Chat history options."] = true,
		["Color GMOTD"] = true,
		["Colors the GMOTD label"] = true,
		["Command History Options"] = true,
		["delaygmotd_desc"] = "Delay GMOTD until after all the startup spam",
		["delaygmotd_name"] = "Delay GMOTD",
		["divider"] = "========== End of Scrollback ==========",
		["History"] = true,
		["Maximum number of lines of command history to save."] = true,
		["removespam_desc"] = "Remove addon spam messages when restoring the chat history",
		["removespam_name"] = "Remove Spam",
		["Save Command History"] = true,
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = true,
		["Scrollback"] = true,
		["Scrollback Options"] = true,
		["scrollbackduration_desc"] = "How many hours to keep the saved messages.",
		["scrollbackduration_name"] = "Scrollback Duration",
		["scrollbacklen_desc"] = "Number of chatlines to save in the scrollback buffer.",
		["scrollbacklen_name"] = "Scrollback Length",
		["Set Chat Lines"] = true,
		["Set Command History"] = true,
		["Set the number of lines of chat history for each window."] = true,
		["storage_char"] = "Character",
		["storage_desc"] = "Which location should the history be saved to.",
		["storage_name"] = "Save To",
		["storage_server"] = "Server",
		["Store the chat lines between sessions"] = true,
	}
}


   PL:AddLocale(PRAT_MODULE, "enUS",L)


L = {
	["History"] = {
		--[[Translation missing --]]
		["bnet_removed"] = "<BNET REMOVED>",
		["Chat history options."] = "Option de l'historique.",
		--[[Translation missing --]]
		["Color GMOTD"] = "Color GMOTD",
		--[[Translation missing --]]
		["Colors the GMOTD label"] = "Colors the GMOTD label",
		--[[Translation missing --]]
		["Command History Options"] = "Command History Options",
		["delaygmotd_desc"] = "Afficher le message du jour de la guilde apr??s tous les autres messages lors de la connexion.",
		--[[Translation missing --]]
		["delaygmotd_name"] = "Delay GMOTD",
		["divider"] = "========== Fin de l'historique ==========",
		["History"] = "Historique",
		["Maximum number of lines of command history to save."] = "Nombre maximum de lignes de commande ?? sauvegarder dans l'historique.",
		--[[Translation missing --]]
		["removespam_desc"] = "Remove addon spam messages when restoring the chat history",
		--[[Translation missing --]]
		["removespam_name"] = "Remove Spam",
		["Save Command History"] = "Historique de commandes",
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Sauvegarde l'historique des commandes entre les sessions (?? utiliser avec alt+haut ou juste haut)",
		--[[Translation missing --]]
		["Scrollback"] = "Scrollback",
		--[[Translation missing --]]
		["Scrollback Options"] = "Scrollback Options",
		--[[Translation missing --]]
		["scrollbackduration_desc"] = "How many hours to keep the saved messages.",
		--[[Translation missing --]]
		["scrollbackduration_name"] = "Scrollback Duration",
		["scrollbacklen_desc"] = "Nombre de lignes de discussions ?? sauvegarder dans l'historique.",
		["scrollbacklen_name"] = "Taille de l'historique",
		["Set Chat Lines"] = "Historique de discussions",
		["Set Command History"] = "Historique de commandes",
		["Set the number of lines of chat history for each window."] = "D??finit le nombre de lignes dans l'historique pour chaque fen??tre.",
		--[[Translation missing --]]
		["storage_char"] = "Character",
		--[[Translation missing --]]
		["storage_desc"] = "Which location should the history be saved to.",
		--[[Translation missing --]]
		["storage_name"] = "Save To",
		--[[Translation missing --]]
		["storage_server"] = "Server",
		["Store the chat lines between sessions"] = "Sauvegarder l'historique des discussions entre les sessions.",
	}
}


   PL:AddLocale(PRAT_MODULE, "frFR",L)


L = {
	["History"] = {
		["bnet_removed"] = "<BNET ENTFERNT>",
		["Chat history options."] = "Optionen zum Chatverlauf.",
		["Color GMOTD"] = "Farbe der Gildennachricht des Tages",
		["Colors the GMOTD label"] = "F??rbt die Gildennachricht des Tages-Beschriftung",
		["Command History Options"] = "Befehlsverlaufsoptionen",
		["delaygmotd_desc"] = "GMOTD verz??gern, bis die Ausgabe aller Mitteilungen nach dem Einloggen vollendet ist.",
		["delaygmotd_name"] = "GMOTD verz??gern",
		["divider"] = "========== Ende des Zur??ckbl??ttern ==========",
		["History"] = "Verlauf",
		["Maximum number of lines of command history to save."] = "Maximal zu speichernde Zeilenanzahl des Befehlsverlaufs.",
		["removespam_desc"] = "Entfernt Addon Spam-Nachrichten, wenn du den Chat-Verlauf wiederherstellst",
		["removespam_name"] = "Spam entfernen",
		["Save Command History"] = "Befehlsverlauf speichern",
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Speichert Befehlsverlauf zwischen Sitzungen (um mit Alt + \"Pfeil nach oben\" oder nur \"Pfeil nach oben\" verwendet zu werden).",
		["Scrollback"] = "Zur??ckbl??ttern",
		["Scrollback Options"] = "Optionen f??r das Zur??ckbl??ttern",
		["scrollbackduration_desc"] = "Wie viele Stunden, um die gespeicherten Nachrichten zu speichern.",
		["scrollbackduration_name"] = "Dauer vom Zur??ckbl??ttern",
		["scrollbacklen_desc"] = "Anzahl der Chat-Zeilen, die im Zur??ckbl??ttern Puffer gespeichert werden sollen.",
		["scrollbacklen_name"] = "L??nge vom Zur??ckbl??ttern",
		["Set Chat Lines"] = "Chatzeilen einstellen",
		["Set Command History"] = "Befehlsverlauf einstellen",
		["Set the number of lines of chat history for each window."] = "Die Zeilenanzahl des Chatverlaufs f??r jedes Fenster einstellen.",
		["storage_char"] = "Charakter",
		["storage_desc"] = "An welchem Ort soll der Verlauf gespeichert werden?",
		["storage_name"] = "Speichern unter",
		["storage_server"] = "Server",
		["Store the chat lines between sessions"] = "Speichert die Chat-Zeilen zwischen den Sitzungen",
	}
}


   PL:AddLocale(PRAT_MODULE, "deDE",L)


L = {
	["History"] = {
		["bnet_removed"] = "<????????? ?????????>",
		["Chat history options."] = "?????? ?????? ???????????????.",
		["Color GMOTD"] = "????????? ?????? ???????????? ???????????????",
		["Colors the GMOTD label"] = "????????? ?????? ????????? ????????? ???????????????",
		["Command History Options"] = "????????? ?????? ??????",
		["delaygmotd_desc"] = "?????? ?????? ????????? ?????? ???????????? ????????? ?????? ????????? ???????????????",
		["delaygmotd_name"] = "????????? ?????? ????????? ??????",
		["divider"] = "========== ?????? ?????? ????????? ??? ==========",
		["History"] = "?????? [History]",
		["Maximum number of lines of command history to save."] = "????????? ????????? ????????? ?????? ???????????????.",
		["removespam_desc"] = "?????? ????????? ?????? ??? ??? ????????? ?????? ????????? ??????",
		["removespam_name"] = "?????? ??????",
		["Save Command History"] = "????????? ?????? ??????",
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "?????? ??? ????????? ????????? ??????????????? (Alt+??? ???????????? ??? ???????????? ????????????)",
		["Scrollback"] = "????????????",
		["Scrollback Options"] = "???????????? ??????",
		["scrollbackduration_desc"] = "????????? ???????????? ????????? ??????.",
		["scrollbackduration_name"] = "???????????? ??????",
		["scrollbacklen_desc"] = "???????????? ???????????? ????????? ?????? ?????? ???????????????.",
		["scrollbacklen_name"] = "???????????? ??????",
		["Set Chat Lines"] = "?????? ?????? ??????",
		["Set Command History"] = "????????? ?????? ??????",
		["Set the number of lines of chat history for each window."] = "??? ????????? ?????? ?????? ????????? ?????? ????????? ???????????????.",
		["storage_char"] = "?????????",
		["storage_desc"] = "????????? ????????? ??????",
		["storage_name"] = "??????",
		["storage_server"] = "??????",
		["Store the chat lines between sessions"] = "?????? ??? ?????? ?????? ????????????",
	}
}


   PL:AddLocale(PRAT_MODULE, "koKR",L)


L = {
	["History"] = {
		--[[Translation missing --]]
		["bnet_removed"] = "<BNET REMOVED>",
		--[[Translation missing --]]
		["Chat history options."] = "Chat history options.",
		--[[Translation missing --]]
		["Color GMOTD"] = "Color GMOTD",
		--[[Translation missing --]]
		["Colors the GMOTD label"] = "Colors the GMOTD label",
		--[[Translation missing --]]
		["Command History Options"] = "Command History Options",
		--[[Translation missing --]]
		["delaygmotd_desc"] = "Delay GMOTD until after all the startup spam",
		--[[Translation missing --]]
		["delaygmotd_name"] = "Delay GMOTD",
		--[[Translation missing --]]
		["divider"] = "========== End of Scrollback ==========",
		--[[Translation missing --]]
		["History"] = "History",
		--[[Translation missing --]]
		["Maximum number of lines of command history to save."] = "Maximum number of lines of command history to save.",
		--[[Translation missing --]]
		["removespam_desc"] = "Remove addon spam messages when restoring the chat history",
		--[[Translation missing --]]
		["removespam_name"] = "Remove Spam",
		--[[Translation missing --]]
		["Save Command History"] = "Save Command History",
		--[[Translation missing --]]
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Saves command history between sessions (for use with alt+up arrow or just the up arrow)",
		--[[Translation missing --]]
		["Scrollback"] = "Scrollback",
		--[[Translation missing --]]
		["Scrollback Options"] = "Scrollback Options",
		--[[Translation missing --]]
		["scrollbackduration_desc"] = "How many hours to keep the saved messages.",
		--[[Translation missing --]]
		["scrollbackduration_name"] = "Scrollback Duration",
		--[[Translation missing --]]
		["scrollbacklen_desc"] = "Number of chatlines to save in the scrollback buffer.",
		--[[Translation missing --]]
		["scrollbacklen_name"] = "Scrollback Length",
		--[[Translation missing --]]
		["Set Chat Lines"] = "Set Chat Lines",
		--[[Translation missing --]]
		["Set Command History"] = "Set Command History",
		--[[Translation missing --]]
		["Set the number of lines of chat history for each window."] = "Set the number of lines of chat history for each window.",
		--[[Translation missing --]]
		["storage_char"] = "Character",
		--[[Translation missing --]]
		["storage_desc"] = "Which location should the history be saved to.",
		--[[Translation missing --]]
		["storage_name"] = "Save To",
		--[[Translation missing --]]
		["storage_server"] = "Server",
		--[[Translation missing --]]
		["Store the chat lines between sessions"] = "Store the chat lines between sessions",
	}
}


   PL:AddLocale(PRAT_MODULE, "esMX",L)


L = {
	["History"] = {
		["bnet_removed"] = "<BNET ????????????>",
		["Chat history options."] = "?????????????????? ?????????????? ????????.",
		["Color GMOTD"] = "????????  GMOTD",
		["Colors the GMOTD label"] = "?????????? ???????????????? ??????",
		["Command History Options"] = "?????????????????? ?????????????? ????????????",
		["delaygmotd_desc"] = "?????????????????????? ?????????????????????? ?????? ???????????? ???? ?????????????????? ?????????? ?????? ?????????? ?? ????????",
		["delaygmotd_name"] = "???????????????? GMOTD",
		["divider"] = "========== ?????????? ?????????????? ?????????????????? ==========",
		["History"] = "??????????????",
		["Maximum number of lines of command history to save."] = "???????????????????????? ?????????? ?????????? ?????????????????????? ?? ?????????????? ????????????.",
		["removespam_desc"] = "?????????????? ????????-?????????????????? ???????????? ?????? ???????????????????????????? ?????????????? ????????",
		["removespam_name"] = "?????????????? ????????",
		["Save Command History"] = "?????????????????? ?????????????? ????????????",
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "?????????????????? ?????????????? ???????????? ?????????? ???????????????? (?????? ?????????????????????????? ?????????????????????? alt+ ?????????????? ?????????? ?????? ???????????? ?????????????? ??????????)",
		["Scrollback"] = "?????????????? ??????????????????",
		["Scrollback Options"] = "?????????????? ??????????",
		["scrollbackduration_desc"] = "?????????????? ?????????? ?????????????? ?????????????????????? ??????????????????.",
		["scrollbackduration_name"] = "???????????????????????? ??????????????????",
		["scrollbacklen_desc"] = "???????????????????? ?????????? ????????, ?????????????? ???????? ?????????????????? ?? ???????????? ?????????????? ??????????????????.",
		["scrollbacklen_name"] = "?????????? ?????????????? ??????????????????",
		["Set Chat Lines"] = "???????????? ?????????? ?????????? ????????",
		["Set Command History"] = "?????????????? ????????????",
		["Set the number of lines of chat history for each window."] = "???????????????????? ?????????? ?????????? ?????????????? ???????? ?????? ???????? ???????? ????????.",
		["storage_char"] = "????????????????",
		["storage_desc"] = "?? ?????????? ?????????? ?????????????? ?????????????????? ??????????????.",
		["storage_name"] = "?????????????????? ??",
		["storage_server"] = "???????????? ",
		["Store the chat lines between sessions"] = "?????????????????? ???????????? ???????? ?????????? ????????????????",
	}
}


   PL:AddLocale(PRAT_MODULE, "ruRU",L)


L = {
	["History"] = {
		--[[Translation missing --]]
		["bnet_removed"] = "<BNET REMOVED>",
		["Chat history options."] = "????????????????????????",
		["Color GMOTD"] = "????????????????????????",
		["Colors the GMOTD label"] = "?????????????????????????????????",
		--[[Translation missing --]]
		["Command History Options"] = "Command History Options",
		["delaygmotd_desc"] = "??????????????????????????????????????????????????????????????????",
		["delaygmotd_name"] = "?????? GMOTD",
		["divider"] = "========== ???????????? ==========",
		["History"] = "????????????",
		["Maximum number of lines of command history to save."] = "??????????????????????????????",
		--[[Translation missing --]]
		["removespam_desc"] = "Remove addon spam messages when restoring the chat history",
		--[[Translation missing --]]
		["removespam_name"] = "Remove Spam",
		["Save Command History"] = "??????????????????",
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "???????????????????????????????????????(??????alt+??????????????????????????????)",
		["Scrollback"] = "??????",
		["Scrollback Options"] = "????????????",
		--[[Translation missing --]]
		["scrollbackduration_desc"] = "How many hours to keep the saved messages.",
		--[[Translation missing --]]
		["scrollbackduration_name"] = "Scrollback Duration",
		["scrollbacklen_desc"] = "??????????????????????????????",
		["scrollbacklen_name"] = "????????????",
		["Set Chat Lines"] = "???????????????",
		["Set Command History"] = "??????????????????",
		["Set the number of lines of chat history for each window."] = "???????????????????????????????????????????????????",
		--[[Translation missing --]]
		["storage_char"] = "Character",
		--[[Translation missing --]]
		["storage_desc"] = "Which location should the history be saved to.",
		--[[Translation missing --]]
		["storage_name"] = "Save To",
		--[[Translation missing --]]
		["storage_server"] = "Server",
		["Store the chat lines between sessions"] = "?????????????????????????????????",
	}
}


   PL:AddLocale(PRAT_MODULE, "zhCN",L)


L = {
	["History"] = {
		--[[Translation missing --]]
		["bnet_removed"] = "<BNET REMOVED>",
		["Chat history options."] = "Opciones del historial del chat.",
		--[[Translation missing --]]
		["Color GMOTD"] = "Color GMOTD",
		--[[Translation missing --]]
		["Colors the GMOTD label"] = "Colors the GMOTD label",
		--[[Translation missing --]]
		["Command History Options"] = "Command History Options",
		--[[Translation missing --]]
		["delaygmotd_desc"] = "Delay GMOTD until after all the startup spam",
		--[[Translation missing --]]
		["delaygmotd_name"] = "Delay GMOTD",
		["divider"] = "========== Fin del Registro ==========",
		["History"] = "Historial",
		["Maximum number of lines of command history to save."] = "M??ximo n??mero de l??neas a guardar por el comando historial.",
		--[[Translation missing --]]
		["removespam_desc"] = "Remove addon spam messages when restoring the chat history",
		--[[Translation missing --]]
		["removespam_name"] = "Remove Spam",
		["Save Command History"] = "Comando Guardar Historial",
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Guarda el historial de comandos entre sesiones (para utilizar con alt+flecha arriba o s??lo la flecha arriba)",
		--[[Translation missing --]]
		["Scrollback"] = "Scrollback",
		--[[Translation missing --]]
		["Scrollback Options"] = "Scrollback Options",
		--[[Translation missing --]]
		["scrollbackduration_desc"] = "How many hours to keep the saved messages.",
		--[[Translation missing --]]
		["scrollbackduration_name"] = "Scrollback Duration",
		--[[Translation missing --]]
		["scrollbacklen_desc"] = "Number of chatlines to save in the scrollback buffer.",
		--[[Translation missing --]]
		["scrollbacklen_name"] = "Scrollback Length",
		["Set Chat Lines"] = "Establecer L??neas de Chat",
		["Set Command History"] = "Establecer Historial de Comandos",
		["Set the number of lines of chat history for each window."] = "Establece el n??mero de l??neas del historial de chat para cada ventana.",
		--[[Translation missing --]]
		["storage_char"] = "Character",
		--[[Translation missing --]]
		["storage_desc"] = "Which location should the history be saved to.",
		--[[Translation missing --]]
		["storage_name"] = "Save To",
		--[[Translation missing --]]
		["storage_server"] = "Server",
		--[[Translation missing --]]
		["Store the chat lines between sessions"] = "Store the chat lines between sessions",
	}
}


   PL:AddLocale(PRAT_MODULE, "esES",L)


L = {
	["History"] = {
		--[[Translation missing --]]
		["bnet_removed"] = "<BNET REMOVED>",
		["Chat history options."] = "?????????????????????",
		["Color GMOTD"] = "?????? GMOTD",
		["Colors the GMOTD label"] = "?????? GMOTD ??????",
		--[[Translation missing --]]
		["Command History Options"] = "Command History Options",
		--[[Translation missing --]]
		["delaygmotd_desc"] = "Delay GMOTD until after all the startup spam",
		["delaygmotd_name"] = "?????? GMOTD",
		["divider"] = "========== ???????????? ==========",
		["History"] = "????????????",
		["Maximum number of lines of command history to save."] = "????????????????????????????????????",
		--[[Translation missing --]]
		["removespam_desc"] = "Remove addon spam messages when restoring the chat history",
		--[[Translation missing --]]
		["removespam_name"] = "Remove Spam",
		["Save Command History"] = "??????????????????",
		--[[Translation missing --]]
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Saves command history between sessions (for use with alt+up arrow or just the up arrow)",
		["Scrollback"] = "??????",
		["Scrollback Options"] = "????????????",
		--[[Translation missing --]]
		["scrollbackduration_desc"] = "How many hours to keep the saved messages.",
		--[[Translation missing --]]
		["scrollbackduration_name"] = "Scrollback Duration",
		--[[Translation missing --]]
		["scrollbacklen_desc"] = "Number of chatlines to save in the scrollback buffer.",
		["scrollbacklen_name"] = "????????????",
		["Set Chat Lines"] = "??????????????????",
		["Set Command History"] = "??????????????????",
		["Set the number of lines of chat history for each window."] = "??????????????????????????????????????????",
		--[[Translation missing --]]
		["storage_char"] = "Character",
		--[[Translation missing --]]
		["storage_desc"] = "Which location should the history be saved to.",
		--[[Translation missing --]]
		["storage_name"] = "Save To",
		--[[Translation missing --]]
		["storage_server"] = "Server",
		--[[Translation missing --]]
		["Store the chat lines between sessions"] = "Store the chat lines between sessions",
	}
}


   PL:AddLocale(PRAT_MODULE, "zhTW",L)
 end
 --@end-non-debug@

  Prat:SetModuleDefaults(module.name, {
    profile = {
      on = true,
      chatlinesframes = {},
      chatlines = 384,
      maxlines = 50,
      scrollbackduration = 24,
      savehistory = false,
      scrollback = true,
      removespam = true,
      colorgmotd = true,
      delaygmotd = true,
    }
  })

  module.pluginopts = {}

  Prat:SetModuleOptions(module.name, {
    name = PL["History"],
    desc = PL["Chat history options."],
    type = "group",
    plugins = module.pluginopts,
    args = {
      chatlinesframes = {
        name = PL["Set Chat Lines"],
        desc = PL["Set the number of lines of chat history for each window."],
        type = "multiselect",
        values = Prat.HookedFrameList,
        get = "GetSubValue",
        set = "SetSubValue"
      },
      chatlines = {
        name = PL["Set Chat Lines"],
        desc = PL["Set the number of lines of chat history for each window."],
        type = "range",
        order = 120,
        min = 300,
        max = 5000,
        step = 10,
        bigStep = 50,
      },
      cmdhistheader = {
        name = PL["Command History Options"],
        type = "header",
        order = 130,
      },
      maxlines = {
        name = PL["Set Command History"],
        desc = PL["Maximum number of lines of command history to save."],
        type = "range",
        order = 132,
        min = 0,
        max = 500,
        step = 10,
        bigStep = 50,
        disabled = function() return not module.db.profile.savehistory end
      },
      savehistory = {
        name = PL["Save Command History"],
        desc = PL["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"],
        type = "toggle",
        order = 131,
      },
--      colorgmotd = {
--        name = PL["Color GMOTD"],
--        desc = PL["Colors the GMOTD label"],
--        type = "toggle",
--        order = 150,
--      },
--      delaygmotd = {
--        name = PL.delaygmotd_name,
--        desc = PL.delaygmotd_desc,
--        type = "toggle",
--        order = 151
--      }
    }
  })


  local function applyEditBox(func)
    for i = 1, NUM_CHAT_WINDOWS do
      local f = _G["ChatFrame" .. i .. "EditBox"]
      func(f)
    end
  end

  --[[------------------------------------------------
      Module Event Functions
  ------------------------------------------------]] --

  -- things to do when the module is enabled
  function module:OnModuleEnable()


    Prat3CharDB = Prat3CharDB or {}
    Prat3CharDB.history = Prat3CharDB.history or {}
    Prat3CharDB.history.cmdhistory = Prat3CharDB.history.cmdhistory or {}


    --                if self.db.profile.cmdhistory then
    --                    Prat3CharDB.history.cmdhistory = self.db.profile.cmdhistory
    --                    self.db.profile.cmdhistory = nil
    --                end



    for i, v in ipairs(Prat3CharDB.history.cmdhistory) do
      if (type(v) == "string" and v:sub(1, 9) ~= "ChatFrame") then
        Prat3CharDB.history.cmdhistory[i] = nil
      end
    end

    applyEditBox(function(edit)
      local name = edit:GetName()
      Prat3CharDB.history.cmdhistory[name] = Prat3CharDB.history.cmdhistory[name] or {}
    end)


    self:ConfigureAllChatFrames()


    for k in pairs(Prat3CharDB.history.cmdhistory) do
      local edit = _G[k]
      if (edit) then
        self:SecureHook(edit, "AddHistoryLine")
        if self.db.profile.savehistory then
          self:addSavedHistory(edit)
        end
        self:SecureHook(edit, "ClearHistory")
      end
    end


    -- Clean out any old data
    if self.db.profile.cmdhistory then
      self.db.profile.cmdhistory = nil
    end



--    if IsInGuild() then
--      self.frame = self.frame or CreateFrame("Frame")
--
--      if self.db.profile.delaygmotd then
--        self:DelayGMOTD(self.frame)
--      end
--
--      if self.db.profile.colorgmotd then
--        local a, b = strsplit(":", GUILD_MOTD_TEMPLATE)
--        if a and b then
--          GUILD_MOTD_TEMPLATE = "|cffffffff" .. a .. "|r:" .. b
--        end
--      end
--    end
  end


  function module:GetDescription()
    return PL["Chat history options."]
  end

  -- things to do when the module is enabled
  function module:OnModuleDisable()
    self:ConfigureAllChatFrames(384)
  end

  function module:ConfigureAllChatFrames(lines)
    local lines = lines or self.db.profile.chatlines

    for k, v in pairs(self.db.profile.chatlinesframes) do
      self:SetHistory(_G[k], lines)
    end

    for k in pairs(Prat3CharDB.history.cmdhistory) do
      local edit = _G[k]
      if (edit) then
        if self.db.profile.savehistory then
          edit.history_lines = Prat3CharDB.history.cmdhistory[k]
        else
          edit.history_lines = {}
        end
        edit.history_index = 0
      end
    end
  end

  function module:OnSubvalueChanged()
    self:ConfigureAllChatFrames()
  end

  function module:OnValueChanged()
    self:ConfigureAllChatFrames()
  end


--  function module:DelayGMOTD(frame)
--    local delay = 2.5
--    local maxtime = 60
--    ChatFrame1:UnregisterEvent("GUILD_MOTD")
--    frame:SetScript("OnUpdate", function(this, expired)
--      delay = delay - expired
--      if delay < 0 then
--        local msg = GetGuildRosterMOTD()
--        if maxtime < 0 or (msg and msg:len() > 0) then
--          ChatFrame1:RegisterEvent("GUILD_MOTD")
--
--          for _, f in pairs(Prat.Frames) do
--            if f:IsEventRegistered("GUILD_MOTD") then
--              ChatFrame_SystemEventHandler(f, "GUILD_MOTD", msg)
--            end
--          end
--          this:Hide()
--        else
--          delay = 2.5
--          maxtime = maxtime - 2.5
--        end
--      end
--    end)
--  end


  --[[------------------------------------------------
      Core Functions
  ------------------------------------------------]] --
  function module:SetHistory(f, lines)
    if f == nil then return end

    f:SetMaxLines(lines)
  end

  function module:addSavedHistory(editBox)
    local editBox = editBox or ChatFrame1EditBox
    local cmdhistory = Prat3CharDB.history.cmdhistory[editBox:GetName()] or {}
    local cmdindex = #cmdhistory

    -- where there"s a while, there"s a way
    while cmdindex > 0 do
      editBox:AddHistoryLine(cmdhistory[cmdindex])
      cmdindex = cmdindex - 1
      -- way
    end
  end

  function module:saveLine(text, editBox)
    if not text or (text == "") then
      return false
    end

    local maxlines = self.db.profile.maxlines
    local cmdhistory = editBox.history_lines or {}

    if cmdhistory[1] == text then return end
    
    table.insert(cmdhistory, 1, text)

    local cmdcount = #cmdhistory - maxlines
    while cmdcount > 0 do
      table.remove(cmdhistory)
      cmdcount = cmdcount - 1
    end
  end

  function module:ClearHistory(editBox)
    editBox = editBox or ChatFrame1EditBox

    local cmdhistory = editBox.history_lines or {}
    local cmdcount = #cmdhistory
    while cmdcount > 0 do
      table.remove(cmdhistory)
      cmdcount = cmdcount - 1
    end
  end

  function module:AddHistoryLine(editBox)
    editBox = editBox or ChatFrame1EditBox

    -- following code mostly ripped off from Blizzard, but at least I understand it now
    local text = ""
    local type = editBox:GetAttribute("chatType")
    local header = _G["SLASH_" .. type .. "1"]

    if (header) then
      text = header
    end

    if (type == "WHISPER") then
      text = text .. " " .. editBox:GetAttribute("tellTarget")
    elseif (type == "CHANNEL") then
      text = "/" .. editBox:GetAttribute("channelTarget")
    end

    local editBoxText = editBox:GetText();
    if (strlen(editBoxText) > 0 and not IsSecureCmd(editBoxText:match("^/[%a%d_]+") or "")) then
      text = (header and (text .. " ") or "") .. editBoxText;
      self:saveLine(text, editBox)
    end
  end


  return
end) -- Prat:AddModuleToLoad