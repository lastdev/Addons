local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "frFR")

if not L then return end

-- translated using chatgpt

-- Globals
L["Khamuls Collections for Krowi's Achievement Filter"] = "Collections de Khamul pour le filtre de hauts faits de Krowi"
L["Khamul's Meta-Expansion Achievement List"] = "Collection de méta-montures de Khamul"
L["Khamul's House Decor Achievement List"] = "Collection de décorations de Khamul"
L["Khamul's Campsite Achievement List"] = "Collection de campements de Khamul"
L["Khamul's Battle Pet Achievement List"] = "Collection de mascottes de combat de Khamul"

-- Special categories
L["Cross-Expansion"] = "Inter-extensions"

-- Missing category titles
L["Hard"] = "Difficile"
L["Nightmare"] = "Cauchemar"

-- Tooltips
L["Tt_ACM_15035"] = "Seulement 4 sont nécessaires pour terminer le méta-haut fait"
L["Tt_UseMetaAchievementPlugin"] = "Utilisez la catégorie « Collection de méta-montures de Khamul » pour obtenir une vue détaillée de « {1} »."

-- Messages
L["Krowi's Achievement Filter Addon not loaded!"] = "L’addon Filtre de hauts faits de Krowi n’est pas chargé !"

-- Options
L["Show List for Expansion Meta Achievements"] = "Afficher la collection de méta-montures"
L["If enabled, a list with all achievements required for expansion meta achievements will be shown"] = "Si activé, une collection avec tous les hauts faits requis pour les méta-hauts faits d’extension sera affichée."
L["Show List for Achievements with decors as reward"] = "Afficher la collection des hauts faits avec des décorations en récompense"
L["If enabled, a list with all achievements, which have a decor as reward, will be shown"] = "Si activé, une collection de tous les hauts faits offrant une décoration en récompense sera affichée."
L["Show List for Achievements with warband campsites as reward"] = "Afficher la collection des hauts faits avec des campements de bande de guerre en récompense"
L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"] = "Si activé, une collection de tous les hauts faits offrant un campement de bande de guerre en récompense sera affichée."
L["Show List for Achievements with battle pets as reward"] = "Afficher la collection des hauts faits avec des mascottes de combat en récompense"
L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"] = "Si activé, une collection de tous les hauts faits offrant une mascotte de combat en récompense sera affichée."
L["Krowi AchievementFilter status: "] = "Statut de Krowi AchievementFilter : "
L["detected"] = "détecté"
L["not detected"] = "non détecté"
L["Decor Collection Settings"] = "Paramètres de la collection de décorations"
L["Meta-Mount Collection Settings"] = "Paramètres de la collection de méta-montures"
L["Campsite Collection Settings"] = "Paramètres de la collection de campements"
L["Pet Collection Settings"] = "Paramètres de la collection de mascottes"
L["Flatten collection structure"] = "Aplatir la structure de la collection"
L["The collections depth will be flatten and all achievements will be displayed in the expansions category"] = "La profondeur de la collection sera aplatie et tous les hauts faits seront affichés dans la catégorie de l’extension."
L["Include Child Achievements"] = "Inclure les hauts faits dépendants"
L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."] = "Si un haut fait a d’autres hauts faits comme prérequis, ils seront affichés dans une catégorie supplémentaire."
L["Changing any option on this page, requires a reload to take affect."] = "Modifier une option sur cette page nécessite un rechargement de l’interface pour prendre effet."
L["Include Battle-Pet related rewards"] = "Inclure les récompenses liées aux mascottes de combat"
L["This will include Achievements with Pet-Battle rewards like daily quests unlock, costumes and toys"] = "Cela inclura les hauts faits avec des récompenses de combats de mascottes, comme le déblocage de quêtes journalières, des costumes et des jouets"