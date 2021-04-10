--[[ See license.txt for license and copyright information ]]
local addonName, addon = ...

local HINT_ALL = { }

local defaultSavedVariables = {
	TomCats_Account = {
		preferences = {
			["TomCats-MinimapButton"] = {
				position = -2.888,
				hidden = false
			},
			MapOptions = {
				iconAnimationEnabled = true,
				iconScale = 1.0
			},
			betaEnabled = false
		},
		lastVersionSeen = "NONE",
		discoveriesVersion = "0",
		discoveriesResetCount = 0,
		discoveries = {
			vignettes = HINT_ALL,
			vignetteAtlases = HINT_ALL
		}
	},
	TomCats_Character = {
		loveisintheair = {
			preferences = HINT_ALL
		}
	}
}

local function OverlayVariables(template, overlay)
	local newVars = { }
	for k, v in pairs(template) do
		if (overlay[k] ~= nil and type(v) == type(overlay[k])) then
			if (type(v) == "table") then
				newVars[k] = (v == HINT_ALL) and overlay[k] or OverlayVariables(v, overlay[k])
			else
				newVars[k] = overlay[k]
			end
		else
			newVars[k] = (v == HINT_ALL) and { } or v
		end
	end
	return newVars
end

local function OnEvent(event, arg1)
	if (event == "ADDON_LOADED") then
		if (addonName == arg1) then
			for k, v in pairs(defaultSavedVariables) do
				_G[k] = OverlayVariables(v, _G[k] or { })
			end
			addon.UnregisterEvent("ADDON_LOADED", OnEvent)
		end
	end
end

addon.RegisterEvent("ADDON_LOADED", OnEvent)
