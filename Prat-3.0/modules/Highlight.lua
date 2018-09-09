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
    local function dbg(...) end

    --[===[@debug@
    function dbg(...) Prat:PrintLiteral(...) end

    --@end-debug@]===]

    local PRAT_MODULE = Prat:RequestModuleName("Highlight")

    if PRAT_MODULE == nil then
        return
    end

    local module = Prat:NewModule(PRAT_MODULE)

    -- define localized strings
    local PL = module.PL


    Prat:SetModuleDefaults(module.name, {
        profile = {
            on = true,
            player = true,
            guild = true
        }
    })

    --[===[@debug@
    PL:AddLocale(PRAT_MODULE, "enUS", {
        ["module_name"] = "Highlight",
        ["module_desc"] = "Highlight your own name, and various other text",
    } )
    --@end-debug@]===]

    -- These Localizations are auto-generated. To help with localization
    -- please go to http://www.wowace.com/projects/prat-3-0/localization/


    --@non-debug@
  do
      local L

  L=
{
	["Achievements"] = {
		["completed"] = "Completed %s",
		["customGrats_defualt"] = "Grats %s",
		["customGrats_desc"] = "Use a custom grats message instead of a random one",
		["customGrats_name"] = "Use Custom Grats Message",
		["customGratsText_desc"] = "Custom grats message. Type any text you wish for your grats message, if you want to include the player's name use '%s' as a placeholder",
		["customGratsText_name"] = "Grats Message",
		["dontShowAchievements_desc"] = "Hide all achievement messages",
		["dontShowAchievements_name"] = "Don't show achievements",
		["grats_donthave_1"] = "Grats %s",
		["grats_donthave_10"] = "I can't wait to get that one %s",
		["grats_donthave_2"] = "Gz %s, I still need that",
		["grats_donthave_3"] = "I want that one %s, grats!",
		["grats_donthave_4"] = "Wow %s that's great",
		["grats_donthave_5"] = "I'm jealous %s, grats!",
		["grats_donthave_6"] = "I have been working on that for ages %s",
		["grats_donthave_7"] = "Still need that one %s, grats!",
		["grats_donthave_8"] = "WTB your achievment %s",
		["grats_donthave_9"] = "Looking forward to that one myself %s, good job!",
		["grats_have_1"] = "Grats %s",
		["grats_have_10"] = "Good work %s, now we both have it",
		["grats_have_2"] = "Gz %s, I have that one too",
		["grats_have_3"] = "Wow %s that's great",
		["grats_have_4"] = "Welcome to the club %s",
		["grats_have_5"] = "I can still rememeber getting that one %s",
		["grats_have_6"] = "That one is a rite of passge %s",
		["grats_have_7"] = "I worked on that for ages %s, grats!",
		["grats_have_8"] = "I remember doing that, %s, grats!",
		["grats_have_9"] = "Nicely done %s",
		["grats_link"] = "say grats",
		["module_desc"] = "Achievment related customizations",
		["module_name"] = "Achievements",
		["showCompletedDate_desc"] = "Show the date you completed the acheievment next to the link",
		["showCompletedDate_name"] = "Show completed date",
		["showGratsLink_desc"] = "Show a clickable link which sends a grats message",
		["showGratsLink_name"] = "Show grats link",
	}
}
  PL:AddLocale(PRAT_MODULE, "enUS", L)


  L=
{
	["Achievements"] = {
		--[[Translation missing --]]
		--[[ ["completed"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_defualt"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_link"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_name"] = "",--]] 
	}
}
  PL:AddLocale(PRAT_MODULE, "itIT", L)


  L=
{
	["Achievements"] = {
		--[[Translation missing --]]
		--[[ ["completed"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_defualt"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		["grats_donthave_1"] = "Parabéns %s",
		["grats_donthave_10"] = "Não vejo a hora de ter esse, %s",
		["grats_donthave_2"] = "Boa %s, eu ainda preciso desse",
		["grats_donthave_3"] = "Eu também quero esse, %s. Parabéns!",
		["grats_donthave_4"] = "Nossa %s, brilhante",
		--[[Translation missing --]]
		--[[ ["grats_donthave_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_link"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_name"] = "",--]] 
	}
}
  PL:AddLocale(PRAT_MODULE, "ptBR", L)


  L=
{
	["Achievements"] = {
		--[[Translation missing --]]
		--[[ ["completed"] = "",--]] 
		["customGrats_defualt"] = "GG %s !",
		["customGrats_desc"] = "Utiliser un message personnalisé à la place d'un message aléatoire ",
		["customGrats_name"] = "Utiliser un message personnalisé de félicitations",
		["customGratsText_desc"] = "Message de félicitations personnalisé. Tapez n'importe quel texte, vous pouvez ajouter le nom du joueur avec la variable '%s'",
		["customGratsText_name"] = "Message de gratification",
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		["grats_donthave_1"] = "Félicitations %s !",
		["grats_donthave_10"] = "Il faut aussi que je fasse ce haut fait %s",
		["grats_donthave_2"] = "GG %s, je ne l'ai pas encore fini celui là",
		["grats_donthave_3"] = "Il faut aussi que je le fasse celui là %s, gg !",
		["grats_donthave_4"] = "Bien joué %s",
		["grats_donthave_5"] = "Je suis trop jaloux %s, gg !  :)",
		["grats_donthave_6"] = "Ça fait un baille que je tente de l'avoir celui là %s ^^",
		["grats_donthave_7"] = "Il me manque toujours celui là %s, gg !",
		["grats_donthave_8"] = "Tu ne veux pas aussi me le faire %s ? xD",
		["grats_donthave_9"] = "Vivement que je le fasse aussi %s, bien joué !",
		["grats_have_1"] = "Félicitations %s",
		["grats_have_10"] = "Bien joué %s, maintenant on l'a tous les deux :)",
		["grats_have_2"] = "GG %s, je l'ai aussi validé",
		["grats_have_3"] = "Waw %s, c'est bien joué !",
		["grats_have_4"] = "Bienvenue au club %s",
		["grats_have_5"] = "Je me souviens encore de la fois où j'ai réalisé ce HF %s",
		["grats_have_6"] = "Celui là est un incontournable %s",
		["grats_have_7"] = "Ça fait un baille que je bosse sur celui là %s, gg !",
		["grats_have_8"] = "Je me souviens encore de la fois où je l'ai réalisé, %s, gg !",
		["grats_have_9"] = "Bien joué %s",
		["grats_link"] = "dire gg",
		--[[Translation missing --]]
		--[[ ["module_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_name"] = "",--]] 
		["showGratsLink_desc"] = "Montrer un lien clicable qui envoie des messages de félicitations",
		["showGratsLink_name"] = "Montrer un lien de félicitations",
	}
}
  PL:AddLocale(PRAT_MODULE, "frFR", L)


  L=
{
	["Achievements"] = {
		["completed"] = "Abgeschlossen %s",
		["customGrats_defualt"] = "Grats %s",
		["customGrats_desc"] = "Benutze eine eigene Glückwunsch-Nachricht anstatt einer zufälligen",
		["customGrats_name"] = "Benutze eine eigene Glückwunsch-Nachricht",
		["customGratsText_desc"] = "Eigene Glückwunsch-Nachricht. Du kannst hier einen beliebigen Text für Glückwunsch-Nachrichten eingeben. Möchtest du den Spielernamen einschließen benutze `%s` als Platzhalter. ",
		["customGratsText_name"] = "Glückwunsch-Nachricht",
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		["grats_donthave_1"] = "Grats %s",
		["grats_donthave_10"] = "Den hätt ich auch gerne %s",
		["grats_donthave_2"] = "Gz %s! Den brauche ich auch noch",
		["grats_donthave_3"] = "Den will ich auch %s, grats!",
		["grats_donthave_4"] = "Wow %s der ist super!",
		--[[Translation missing --]]
		--[[ ["grats_donthave_5"] = "",--]] 
		["grats_donthave_6"] = "Gz %s, an dem arbeite ich seid Jahren",
		["grats_donthave_7"] = "Den brauch ich immer noch %s, grats!",
		--[[Translation missing --]]
		--[[ ["grats_donthave_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_link"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_name"] = "",--]] 
	}
}
  PL:AddLocale(PRAT_MODULE, "deDE", L)


  L=
{
	["Achievements"] = {
		--[[Translation missing --]]
		--[[ ["completed"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_defualt"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_link"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_name"] = "",--]] 
	}
}
  PL:AddLocale(PRAT_MODULE, "koKR",  L)

  L=
{
	["Achievements"] = {
		--[[Translation missing --]]
		--[[ ["completed"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_defualt"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_link"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_name"] = "",--]] 
	}
}
  PL:AddLocale(PRAT_MODULE, "esMX",  L)

  L=
{
	["Achievements"] = {
		["completed"] = "сделано ",
		["customGrats_defualt"] = "Поздравляю %s",
		["customGrats_desc"] = "Использовать персональное сообщение вместо рандомного",
		["customGrats_name"] = "Использовать своё ПОЗДРАВИТЕЛЬНОЕ сообщение",
		["customGratsText_desc"] = "Стандартное ГРАЦ сообщение. Напишите свой текст ГРАЦ сообщения. Если хотите включить имя игрока в сообщение - то добавьте %s",
		["customGratsText_name"] = "Поздравительное сообщение",
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		["grats_donthave_1"] = "Поздравляю %s",
		["grats_donthave_10"] = "Я не могу дождаться, когда тоже получу его %s",
		["grats_donthave_2"] = "Гц %s, мне всё ещё нужно это достижение",
		["grats_donthave_3"] = "Я тоже его хочу %s, гц!",
		["grats_donthave_4"] = "Ого %s, гц!",
		["grats_donthave_5"] = "Как же я завидую %s, гц!",
		["grats_donthave_6"] = "Я столько лет работаю над ним %s, гц!",
		["grats_donthave_7"] = "Мне всё ещё нужно это достижение %s, гц!",
		["grats_donthave_8"] = "Жду ещё достижений %s, гц!",
		["grats_donthave_9"] = "С нетерпением хочу получить такую же %s, гц!",
		["grats_have_1"] = "Гц %s",
		["grats_have_10"] = "Отличная работа %s, теперь у нас обоих есть это достижение",
		["grats_have_2"] = "Гц %s, я такую уже сделал",
		["grats_have_3"] = "Вау %s, зачётно!",
		["grats_have_4"] = "Да светится сие достижение на глубине твоего моря ачив %s",
		["grats_have_5"] = "Не могу забыть, как трудно получал её %s",
		["grats_have_6"] = "%s, сделал дело - гуляй смело!",
		["grats_have_7"] = "Я столько лет трудился над ним %s, гц!",
		["grats_have_8"] = "Я помню, как это делалось,% s, Грац!",
		["grats_have_9"] = "Красиво сделано",
		["grats_link"] = "GRATS",
		["module_desc"] = "Индивидуальные настройки, связанные с достижениями",
		["module_name"] = "Достижения",
		["showCompletedDate_desc"] = "Показывать дату, когда вы сделали достижение, рядом с ссылкой",
		["showCompletedDate_name"] = "Показывать дату завершения",
		["showGratsLink_desc"] = "Показывать ссылку GRATS для поздравления",
		["showGratsLink_name"] = "Показывать GRATS ссылку",
	}
}
  PL:AddLocale(PRAT_MODULE, "ruRU",  L)

  L=
{
	["Achievements"] = {
		--[[Translation missing --]]
		--[[ ["completed"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_defualt"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_link"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_name"] = "",--]] 
	}
}
  PL:AddLocale(PRAT_MODULE, "zhCN",  L)

  L=
{
	["Achievements"] = {
		["completed"] = "Completado %s",
		["customGrats_defualt"] = "Felicidades %s",
		["customGrats_desc"] = "Usar un mensaje de felicitación personalizado en lugar de uno aleatorio",
		["customGrats_name"] = "Mensaje de felicitación personalizado",
		["customGratsText_desc"] = "Mensaje de felicitación personalizado. Escriba el mensaje de felicitación que usted desee, si quiere incluir el nombre del jugador use '%s' como indicador",
		["customGratsText_name"] = "Mensaje de felicitación",
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		["grats_donthave_1"] = "Felicidades %s",
		["grats_donthave_10"] = "No puedo esperar a obtener ese %s",
		["grats_donthave_2"] = "Felicidades %s, yo aún necesito ese",
		--[[Translation missing --]]
		--[[ ["grats_donthave_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_9"] = "",--]] 
		["grats_link"] = "Felicitar",
		["module_desc"] = "Ajustes relacionados a logros",
		["module_name"] = "Logros",
		["showCompletedDate_desc"] = "Muestra la fecha en la que se completo el logro luego del enlace",
		["showCompletedDate_name"] = "Mostrar fecha de finalización",
		["showGratsLink_desc"] = "Muestra a enlace clickable para enviar un mensaje de felicitación",
		["showGratsLink_name"] = "Mostrar enlace de felicitación",
	}
}
  PL:AddLocale(PRAT_MODULE, "esES",  L)

  L=
{
	["Achievements"] = {
		--[[Translation missing --]]
		--[[ ["completed"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_defualt"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGrats_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["customGratsText_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["dontShowAchievements_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_donthave_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_1"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_10"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_2"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_3"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_4"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_5"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_6"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_7"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_8"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_have_9"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["grats_link"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["module_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showCompletedDate_name"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_desc"] = "",--]] 
		--[[Translation missing --]]
		--[[ ["showGratsLink_name"] = "",--]] 
	}
}
  PL:AddLocale(PRAT_MODULE, "zhTW",  L)
  end
  --@end-non-debug@



    --    Prat:SetModuleOptions(module.name, {})


    local CLR = Prat.CLR
    local function guildBracket(text)
        return CLR:Colorize("ffffff", text)
    end
    local function guildText(text)
        return CLR:Colorize("00ff00", text)
    end


    local function highlightPlayer(text)
        if module.db.profile.player then
            return CLR:Colorize("00ff00", text)
        end
    end

    local function highlightGuild(text)
        if module.db.profile.guild then
            return Prat:RegisterMatch(guildBracket("<")..guildText(text)..guildBracket(">"))
        end
    end

    Prat:SetModulePatterns(module, {
        { pattern = Prat.GetNamePattern(UnitName("player")), matchfunc = highlightPlayer, priority = 100 },
        { pattern = "<(.+)>", matchfunc = highlightGuild, priority = 100 },
    })
end)
