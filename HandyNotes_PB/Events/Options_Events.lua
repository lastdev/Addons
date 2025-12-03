local _, ns = ...

-- Localisations
local GetAchievementInfo = GetAchievementInfo
local pairs = pairs

local function aoaList()

	if ( ns.aoa == nil ) or ( ns.version < 100000 ) then return "" end
	
	local returnList, returnStr, aName = {}, "";
	
	for k, v in pairs( ns.aoa ) do
		aName = select( 2, GetAchievementInfo( k ) )
		if returnList[ aName ] == nil then
			returnList[ aName ] = true
		end
	end
	
	for k, v in pairs( returnList ) do
		returnStr = ( returnStr == "" ) and ( "\n\n" ..ns.L[ "aoaList" ] ..k ) or ( returnStr ..", " ..k )
	end

	return returnStr
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function ns.InterfaceOptionsEvents()

	-- Insert additional options for the options panel here. Copy code blocks from options.lua

-- ---------------------------------------------------------------------------------------------------------------------------------

	ns.removeWhenCompleted = Settings.RegisterVerticalLayoutSubcategory( ns.optionsCategory,
		( ns.colour.achieveH or ns.colour.subH or ns.colour.highlight ) ..ns.L[ "Remove When Completed" ] )

	-- ns.questTypesDB and ns.achievementTypesDB are defined in Common_Events
		
	for i = 1, #ns.questTypesRequired do
		if ns.questTypesRequired[ i ] == true then
			local name = ns.colour.highlight ..ns.StringSubstitutions( ns.L[ ns.questTypesDB[ i ] ] )
			local variableKey = ns.questTypesDB[ i ]
			local variable = ns.db .."_" ..variableKey
			local tooltip = ns.colour.plaintext ..ns.StringSubstitutions( ns.L[ ns.questTypesDB[ i ] .."Desc" ] )
			local defaultValue = false
			local setting = Settings.RegisterAddOnSetting( ns.removeWhenCompleted, variable, variableKey, _G[ ns.db ],
						type( defaultValue ), name, defaultValue )			
			Settings.CreateCheckbox( ns.removeWhenCompleted, setting, tooltip )
		end	
	end

	for i = 1, #ns.achievementTypesRequired do
		if ns.achievementTypesRequired[ i ] == true then
			local name = ns.colour.highlight ..ns.StringSubstitutions( ns.L[ ns.achievementTypesDB[ i ] ] )
			local variableKey = ns.achievementTypesDB[ i ]
			local variable = ns.db .."_" ..variableKey
			local tooltip = ns.colour.plaintext ..ns.StringSubstitutions( ns.L[ ns.achievementTypesDB[ i ] .."Desc" ] )
							..( aoaList() )
			local defaultValue = false
			local setting = Settings.RegisterAddOnSetting( ns.removeWhenCompleted, variable, variableKey, _G[ ns.db ],
						type( defaultValue ), name, defaultValue )
			Settings.CreateCheckbox( ns.removeWhenCompleted, setting, tooltip )
		end	
	end		
end