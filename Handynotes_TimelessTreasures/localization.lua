local addonName, ns = ...

local default = {
	ADDON_NAME = "HandyNotes - Timeless Treasures",
	NAME = "Timeless Treasures",
	-- chests
	["Moss-Covered Chest"] = "Moss-Covered Chest",
	["Sturdy Chest"] = "Sturdy Chest",
	["Smoldering Chest"] = "Smoldering Chest",
	["Skull-Covered Chest"] = "Skull-Covered Chest",
	["Blazing Chest"] = "Blazing Chest",
	-- notes
	["On a treestump"] = "On a treestump",
	["In the shipwreck of Cpt. Zvezdan"] = "In the shipwreck of Cpt. Zvezdan",
	["On the top of the cliff. Use the Highwind Albatross"] = "On the top of the cliff. Use the Highwind Albatross",
	["Inside the Mysterious Den. Use one of objects from Legends of the Past"] = "Inside the Mysterious Den. Use one of objects from \"Legends of the Past\" to enter.",
	["Inside Cavern of Lost Spirits (entrance at 43.2, 41.3)"] = "Inside Cavern of Lost Spirits (entrance at 43.2, 41.3)",
	-- tooltip
	["Completed"] = "Completed",
	-- buttons
	["Create waypoint"] = "Create waypoint",
	-- options
	["Timeless Treasures locations."] = "Locations of the chests for \"Treasure, Treasure Everywhere\".",
	["These settings control the visibility of the icons."] = "These settings control the visibility of the icons.\n\n",
	["Show completed"] = "Show completed",
	["Show icons for treasures you have already got."] = "Show icons for chests you have already opened.",
	["Show Moss-Covered Chests"] = "Show Moss-Covered Chests",
	["Show not completed Moss-Covered Chests"] = "Show not completed Moss-Covered Chests",
	["Remove Icon Border"] = "Remove Icon Border",
	["Icon Scale"] = "Icon Scale",
	["Change the size of the icons."] = "Change the size of the icons.",
	["Icon Alpha"] = "Icon Alpha",
	["Change the transparency of the icons."] = "Change the transparency of the icons.",
	["These settings control the look of the icons."] = "\n\nThese settings control the look of the icons.\n\n",
	["Change Icon"] = "Enter the full texture path \ni.e. |cffFFFF00Interface\\ICONS\\inv_box_01|r",
}

local localization = {
	["deDE"] = {
		-- chests
		["Moss-Covered Chest"] = "Moosüberwucherte Truhe",
		["Sturdy Chest"] = "Robuste Truhe",
		["Smoldering Chest"] = "Schwelende Truhe",
		["Skull-Covered Chest"] = "Totenkopftruhe",
		["Blazing Chest"] = "Lodernde Truhe",
		-- notes
		["On a treestump"] = "Auf dem Baumstrunk",
		["In the shipwreck of Cpt. Zvezdan"] = "Im Wrack von Kpt. Zvezdan's Schiff",
		["On the top of the cliff. Use the Highwind Albatross"] = "Auf der Klippenspitze. Benutze den Böenalbatros.",
		["Inside the Mysterious Den. Use one of objects from Legends of the Past"] = "In der Geheimnisvolle Höhle. Benutze einen der Gegenstände für \"Legende vergangener Zeiten\" um reinzukommen.",
		["Inside Cavern of Lost Spirits (entrance at 43.2, 41.3)"] = "in der Höhle der Verlorenen Geister (Eingang am 43.2, 41.3)",
		-- tooltip
		["Completed"] = "Abgeschlossen",
		-- buttons
		["Create waypoint"] = "Wegpunkt erstellen",
		-- options
		["Timeless Treasures locations."] = "Orte der Truhen für \"Meine Schätze!\".",
		["These settings control the visibility of the icons."] = "Diese Einstellungen bestimmen die Sichtbarkeit der Symbole.\n\n",
		["Show completed"] = "Abgeschlossene anzeigen",
		["Show icons for treasures you have already got."] = "Zeigt die Truhen an, die bereits aufgemacht worden sind.",
		["Show Moss-Covered Chests"] = "Mossüberwucherte Truhen anzeigen",
		["Show not completed Moss-Covered Chests"] = "Zeigt noch nicht gefundene mossüberwucherte Truhen an",
		["Remove Icon Border"] = "Symbolumrahmung entfernen",
		["Icon Scale"] = "Symbolgröße",
		["Change the size of the icons."] = "Ändert die Symbolgröße.",
		["Icon Alpha"] = "Symboltransparenz",
		["Change the transparency of the icons."] = "Ändert die Symboltransparenz.",
		["These settings control the look of the icons."] = "\n\nDiese Einstellungen bestimmen das Aussehen der Symbole.\n\n",
		["Change Icon"] = "Gebt den vollständigen Pfad für die Textur an \nz.B. |cffFFFF00Interface\\ICONS\\inv_box_01|r",
	},
}

do
	for locale, tbl in pairs(localization) do
		locale = setmetatable(tbl, {__index = default})
	end
end


ns.L = localization[GetLocale()] or default