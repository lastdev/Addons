-- Copyright 2016, r. brian harrison.  all rights reserved.

local ADDON_NAME = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
assert(AceLocale, string.format("%s requires %s", ADDON_NAME, "AceLocale-3.0"))

local L = AceLocale:NewLocale(ADDON_NAME, "frFR")
if not L then return end

-- import

-- L["%s requires %s"] = ""

-- config

L["Icon Scale"] = "Échelle des icônes"
L["The size of the icons."] = "La taille des icônes sur la map."
L["Icon Alpha"] = "Transparence des icônes"
L["The transparency of the icons."] = "La transparence des icônes sur la map."
L["Show Completed"] = "Montrer les complétés"
L["Show map pins for achievements you have completed."] = "Montrer les pins sur la map pour les haut faits que vous avez déjà complétés."
L["Consolidate Zone Pins"] = "Consolider par zone"
L["Show fewer map pins."] = "Afficher moins de pins sur la map en les regroupant par zone."
L["Just Mine"] = "Uniquement ce personnage"
L["Show more map pins by including achievements completed only by other characters."] = "Montrer plus de pins sur la map en affichant uniquement les haut faits réalisé par ce personnage."
L["Season Warning"] = "Avertissement de saison"
L["Days in advance to show pins for seasonal holiday achievements."] = "Nombre de jours en avance pour lesquels les pins de hauts fait saisonnaux seront affichés."
L["Sort by tracked"] = "Trié par suivis"
L["Sort achievements by tracked"] = "Trier les hauts faits par suivi."
