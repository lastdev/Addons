local _, ns = ...

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.InterfaceOptionsAddOnSpecific()

	-- Insert additional options for the options panel here. Copy code blocks from Options_Common

-- ---------------------------------------------------------------------------------------------------------------------------------

	ns.optionsTextures = Settings.RegisterVerticalLayoutSubcategory( ns.optionsCategory, ( ns.colour.subH or ns.colour.achieveH )
		..ns.L[ "Textures" ] )

	-- Textures here are added onto the basic/standard textures that are already in ns.textures in Common.
	-- To add (remove) textures: Add an entry here and add the actual file in the texture code block in Data_xxx.

	local textureSet = { ns.colour.plaintext ..ns.L[ "Candy Swirl" ], ns.colour.plaintext ..ns.L[ "Pumpkin" ],
				ns.colour.plaintext ..ns.L[ "Evil Pumpkin" ], ns.colour.plaintext ..ns.L[ "Bat" ], ns.colour.plaintext
				..ns.L[ "Cat" ], ns.colour.plaintext ..ns.L[ "Ghost" ], ns.colour.plaintext ..ns.L[ "Witch" ],
				ns.colour.plaintext ..ns.L[ "Candy" ], ns.colour.plaintext ..ns.L[ "Spider" ], version=30202 }

	ns.optionsSeries[ 1 ] = textureSet
	ns.optionsSeries[ 2 ] = textureSet
	ns.optionsSeries[ 3 ] = textureSet
	ns.optionsSeries[ 4 ] = textureSet

	ns.SetupAddOnSpecificOptions()
	Settings.RegisterAddOnCategory( ns.optionsTextures )
end