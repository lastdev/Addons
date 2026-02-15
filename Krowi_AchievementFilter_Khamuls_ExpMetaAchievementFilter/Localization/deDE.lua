local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "deDE")

if not L then return end

-- Globals
L["Khamuls Collections for Krowi's Achievement Filter"] = "Khamuls Sammlungen for Krowi's Achievement Filter"
L["Khamul's Meta-Expansion Achievement List"] = "Khamul's Meta-Reittier Sammlung"
L["Khamul's House Decor Achievement List"] = "Khamul's Dekorationen Sammlung"
L["Khamul's Campsite Achievement List"] = "Khamul's Lagerplätze Sammlung"
L["Khamul's Battle Pet Achievement List"] = "Khamul's Haustier Sammlung"

-- Special categories
L["Cross-Expansion"] = "Erweiterungsübergreifend"

-- Missing category titles
L["Hard"] = "Schwer"
L["Nightmare"] = "Albtraum"

-- Tooltips
L["Tt_ACM_15035"] = "Nur 4 erforderlich, um die Meta-Errungenschaft abzuschließen"
L["Tt_UseMetaAchievementPlugin"] = "Verwende \"Khamul's Meta-Mount Sammlung\" Kategorie, um eine detailierte Übersicht für \"{1}\" zu erhalten."

-- Messages
L["Krowi's Achievement Filter Addon not loaded!"] = "Krowi's Achievement Filter Addon nicht geladen!"

-- Options
L["Show List for Expansion Meta Achievements"] = "Die Meta-Reittier-Sammlung anzeigen"
L["If enabled, a list with all achievements required for expansion meta achievements will be shown"] = "Wenn diese Option aktiviert ist, wird eine Sammlung mit allen Erfolgen angezeigt, die für die Meta-Reittier-Erfolge der Erweiterungen erforderlich sind."
L["Show List for Achievements with decors as reward"] = "Sammlung für Erfolge mit Dekorationen als Belohnung anzeigen"
L["If enabled, a list with all achievements, which have a decor as reward, will be shown"] = "Wenn diese Option aktiviert ist, wird eine Sammlung aller Erfolge angezeigt, für die eine Dekoration als Belohnung vergeben wird."
L["Show List for Achievements with warband campsites as reward"] = "Sammlung für Erfolge mit Kriegsbanden-Lagerplätzen als Belohnung anzeigen"
L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"] = "Wenn diese Option aktiviert ist, wird eine Sammlung aller Erfolge angezeigt, für die ein Kriegertábor als Belohnung vergeben wird."
L["Show List for Achievements with battle pets as reward"] = "Sammlung für Erfolge mit Haustieren als Belohnung anzeigen"
L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"] = "Wenn diese Option aktiviert ist, wird eine Sammlung mit allen Erfolgen angezeigt, für die ein Haustier als Belohnung vergeben wird."
L["Krowi AchievementFilter status: "] = "Krowi AchievementFilter Status: "
L["detected"] = "gefunden"
L["not detected"] = "not gefunden"
L["Decor Collection Settings"] = "Einstellungen für die Dekorationssammlung"
L["Meta-Mount Collection Settings"] = "Einstellungen für die Meta-Reittier-Sammlung"
L["Campsite Collection Settings"] = "Einstellungen für die Lagerplätze Sammlung"
L["Pet Collection Settings"] = "Einstellungen für die Haustier Sammlung"
L["Flatten collection structure"] = "Kategoriestruktur vereinfachen"
L["The collections depth will be flatten and all achievements will be displayed in the expansions category"] = "Die Kategorie zeigt Erfolge direkt in der Erweiterungskategorie an."
L["Include Child Achievements"] = "Zeige untergeordnete Errungenschaften an"
L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."] = "Wenn eine Errungenschaft andere Errungenschaften als Voraussetzung hat, werden diese in einer zusätzlichen Kategorie angezeigt."
L["Changing any option on this page, requires a reload to take affect."] = "Jede Änderung einer Option auf dieser Seite, benötigt einen reload."
L["Include Battle-Pet related rewards"] = "Zeige Erfolge mit Kampfhaustier zugehörigen Belohnungen"
L["This will include Achievements with Pet-Battle rewards like daily quests unlock, costumes and toys"] = "Mit dieser Option werden Erfolge mit Haustier relevanten Belohnungen wie Kostüme, Spielzeuge und andere Freischaltungen."