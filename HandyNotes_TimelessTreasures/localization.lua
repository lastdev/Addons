local _, ns = ...

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

local localization = {}
localization.deDE = {
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
}

localization.esES = {
	ADDON_NAME = "HandyNotes - Tesoros intemporales",
	NAME = "Tesoros intemporales",
	-- chests
	["Moss-Covered Chest"] = "Cofre cubierto de musgo",
	["Sturdy Chest"] = "Cofre robusto",
	["Smoldering Chest"] = "Cofre humeante",
	["Skull-Covered Chest"] = "Cofre adornado de calaveras",
	["Blazing Chest"] = "Cofre llameante",
	-- notes
	["On a treestump"] = "En el tocón ",
	["In the shipwreck of Cpt. Zvezdan"] = "En el naufragio del Capitán Zvezdan",
	["On the top of the cliff. Use the Highwind Albatross"] = "En la cima de la montaña. Usa el Albatros Vientofuerte",
	["Inside the Mysterious Den. Use one of objects from Legends of the Past"] = "Dentro de Guarida Misteriosa. Utiliza uno de los objetos de \"Leyendas del pasado\" para entrar.", -- Needs review
	["Inside Cavern of Lost Spirits (entrance at 43.2, 41.3)"] = "Dentro de la Caverna de los Espíritus Perdidos (entrada en 43.2, 41.3)",
	-- tooltip
	["Completed"] = "Completado",
	-- buttons
	["Create waypoint"] = "Crear waypoint",
	-- options
	["Timeless Treasures locations."] = "Ubicación de los tesoros intemporales",
	["These settings control the visibility of the icons."] = "Estos ajustes controlan la visibilidad de los iconos.\n\n",
	["Show completed"] = "Mostrar completados",
	["Show icons for treasures you have already got."] = "Mostrar los iconos de los tesoros ya conseguidos",
	["Show Moss-Covered Chests"] = "Mostrar Cofres cubiertos de musgo",
	["Show not completed Moss-Covered Chests"] = "Mostrar Cofres cubiertos de musgo sin abrir",
	["Remove Icon Border"] = "Eliminar bordes del icono",
	["Icon Scale"] = "Escala de icono",
	["Change the size of the icons."] = "Cambiar el tamaño de los iconos.",
	["Icon Alpha"] = "Icono Alpha",
	["Change the transparency of the icons."] = "Cambiar la transparencia de los iconos",
	["These settings control the look of the icons."] = "\n\nEstos ajustes controlan el aspecto de los iconos.\n\n",
	["Change Icon"] = "Introduzca la ruta completa de la textura\nejem. |cffFFFF00Interface\\ICONS\\inv_box_01|r",
}

localization.esMX = localization.esES

do
	for locale, tbl in pairs(localization) do
		locale = setmetatable(tbl, {__index = default})
	end
end

ns.L = localization[GetLocale()] or default
