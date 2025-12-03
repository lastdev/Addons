local _, ns = ...

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.InterfaceOptionsAddOnSpecific()

	-- Insert additional options for the options panel here. Copy code blocks from options.lua

-- ---------------------------------------------------------------------------------------------------------------------------------

	ns.optionsTextures = Settings.RegisterVerticalLayoutSubcategory( ns.optionsCategory, ( ns.colour.subH or ns.colour.achieveH )
		..ns.L[ "Textures" ] )

	-- Textures here are added onto the basic/standard textures that are already in ns.textures in Common.

	local textureSet = { ns.colour.plaintext ..ns.L[ "Cornucopia" ], ns.colour.plaintext ..ns.L[ "Empty Cornucopia" ],
				ns.colour.plaintext ..ns.L[ "Turkey 1" ], ns.colour.plaintext ..ns.L[ "Turkey 2" ], ns.colour.plaintext
				..ns.L[ "Turkey 3" ], ns.colour.plaintext ..ns.L[ "Pumpkin Pie" ], ns.colour.plaintext ..ns.L[ "Pilgrim's Paunch" ],
				ns.colour.plaintext ..ns.L[ "Pilgrim Hat" ] .." - " ..ns.L[ "Black" ] .." / " ..ns.L[ "Original" ],
				ns.colour.plaintext ..ns.L[ "Pilgrim Hat" ] .." - " ..ns.L[ "Green" ], ns.colour.plaintext ..ns.L[ "Pilgrim Hat" ]
				.." - " ..ns.L[ "Magenta" ], ns.colour.plaintext ..ns.L[ "Pilgrim Hat" ] .." - " ..ns.L[ "Yellow" ], version=30202 }

	ns.optionsSeries[ 1 ] = textureSet
	ns.optionsSeries[ 2 ] = textureSet
	ns.optionsSeries[ 3 ] = textureSet
	ns.optionsSeries[ 4 ] = textureSet
	ns.optionsSeries[ 5 ] = textureSet

	ns.SetupAddOnSpecificOptions()
	Settings.RegisterAddOnCategory( ns.optionsTextures )
end