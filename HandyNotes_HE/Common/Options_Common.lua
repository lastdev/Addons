local _, ns = ...

local optionsStandard = { ns.colour.plaintext ..ns.L[ "Don't Show" ], ns.colour.plaintext ..ns.L[ "White" ], 
			ns.colour.plaintext ..ns.L[ "Purple" ], ns.colour.plaintext ..ns.L[ "Red" ], ns.colour.plaintext ..ns.L[ "Yellow" ],
			ns.colour.plaintext ..ns.L[ "Green" ], ns.colour.plaintext ..ns.L[ "Grey" ], ns.colour.plaintext ..ns.L[ "Mana Orb" ],
			ns.colour.plaintext ..ns.L[ "Phasing" ], ns.colour.plaintext ..ns.L[ "Raptor Egg" ],
			ns.colour.plaintext ..ns.L[ "Stars" ], ns.colour.plaintext ..ns.L[ "Cogwheel" ], ns.colour.plaintext ..ns.L[ "Frost" ],
			ns.colour.plaintext ..ns.L[ "Diamond" ], ns.colour.plaintext ..ns.L[ "Screw" ] }

ns.optionsSeries = {}

-- localisation
local find = string.find

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.OnSettingChanged( _, setting, value )
	-- setting is a table with a wealth of keys, including setting.variableKey
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.InterfaceOptions()

	-- Player settings will be referenced manually in game as _G[ ns.db ][ "Name of setting" / variableKey ]
	-- Reminder: Changing these settings directly via _G[ ns.db ][] is not part of the design and so is untested

	ns.optionsCategory = Settings.RegisterVerticalLayoutCategory( ns.colour.prefix ..ns.eventName )
	Settings.RegisterAddOnCategory( ns.optionsCategory )

	ns.optionsMainPanel = Settings.RegisterVerticalLayoutSubcategory( ns.optionsCategory, ( ns.colour.subH or ns.colour.achieveH )
		..ns.L[ "Options" ] )
	
	do
		local name = ns.colour.highlight ..ns.L[ "Map Pin Size" ]
		local variableKey = "IconScale"
		local variable = ns.db .."_" ..variableKey
		local tooltip = ns.colour.plaintext ..ns.StringSubstitutions( ns.L[ "The Map Pin Size" ] )
		local defaultValue = 5
		local setting = Settings.RegisterAddOnSetting( ns.optionsMainPanel, variable, variableKey, _G[ ns.db ],
					type( defaultValue ), name, defaultValue )
		local options = Settings.CreateSliderOptions( 1, 10, 0.1 )
		options:SetLabelFormatter( MinimalSliderWithSteppersMixin.Label.Right, function( value ) return ns.Round( value, 2 )
				.." scaling" end )
		Settings.CreateSlider( ns.optionsMainPanel, setting, options, tooltip )
	end
	do
		local name = ns.colour.highlight ..ns.L[ "Map Pin Alpha" ]
		local variableKey = "IconAlpha"
		local variable = ns.db .."_" ..variableKey
		local tooltip = ns.colour.plaintext ..ns.StringSubstitutions( ns.L[ "Alpha Description" ] )
		local defaultValue = 1
		local setting = Settings.RegisterAddOnSetting( ns.optionsMainPanel, variable, variableKey, _G[ ns.db ],
					type( defaultValue ), name, defaultValue )
		local options = Settings.CreateSliderOptions( 0, 1, 0.01 )
		options:SetLabelFormatter( MinimalSliderWithSteppersMixin.Label.Right, function( value ) return ns.Round( value, 2 )
				.." alpha" end );
		Settings.CreateSlider( ns.optionsMainPanel, setting, options, tooltip )
	end
	
	local options = { "ShowCoordinates", "ShowContinents", "ShowAzeroth", "ShowPins" }
	for i = 1, #options do
		do
			local name = ns.colour.highlight ..ns.L[ options[ i ] ]
			local variableKey = options[ i ]
			local variable = ns.db .."_" ..variableKey
			local tooltip = ns.colour.plaintext ..ns.StringSubstitutions( ns.L[ options[ i ] .."Desc" ] )
			local defaultValue = true
			local setting = Settings.RegisterAddOnSetting( ns.optionsMainPanel, variable, variableKey, _G[ ns.db ],
						type( defaultValue ), name, defaultValue )
			Settings.CreateCheckbox( ns.optionsMainPanel, setting, tooltip )
		end	
	end
end

function ns.SetupAddOnSpecificOptions()
	for i = 1, #ns.optionsSeriesDefaults do -- Setup in Data_xxx. Must exist even if {}. i = series
		do
			local name = ( ns.series[ i ].title == nil ) and ( ns.colour.highlight ..ns.L[ "Pin Texture" ] ) or
							( ( find( ns.series[ i ].title, "%%" ) == nil ) and ( ns.colour.highlight ..ns.series[ i ].title ) or							
							( ns.StringSubstitutions( ns.series[ i ].title ) ) )
			local variableKey = "iconSeries" ..i
			local variable = ns.db .."_" ..variableKey
			local defaultValue = ( ns.optionsSeriesDefaults[ i ] <= ( ns.texturesBaseTotal + 1 ) ) and
							( ns.optionsSeriesDefaults[ i ] + 1 ) or
							( ns.optionsSeriesDefaults[ i ] - ns.seriesMapping[ i ] + ns.texturesBaseTotal + 2 )
			local tooltip = ns.colour.plaintext ..ns.StringSubstitutions( ns.L[ "SelectionTexture" ] )
			local function GetOptions()
				local container = Settings.CreateControlTextContainer()
				for j = 1, #optionsStandard do
					container:Add( j, optionsStandard[ j ] )
				end
				for j = 1, #ns.optionsSeries[ i ] do -- Added to in Options_xxx if at all
					container:Add( #optionsStandard + j, ns.optionsSeries[ i ][ j ] )
				end
				return container:GetData()
			end
			local setting = Settings.RegisterAddOnSetting( ns.optionsTextures, variable, variableKey, _G[ ns.db ],
							type( defaultValue ), name, defaultValue )
			Settings.CreateDropdown( ns.optionsTextures, setting, GetOptions, tooltip )
		end		
	end
end