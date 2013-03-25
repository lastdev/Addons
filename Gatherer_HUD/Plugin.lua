--[[
	Gatherer Addon for World of Warcraft(tm).
	HUD Plugin Module
	Version: 3.1.11 (<%codename%>)
	Revision: $Id: Plugin.lua 977 2012-09-04 01:03:44Z Esamynn $

	License:
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program(see GPL.txt); if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn\'s source code is specifically designed to work with
		World of Warcraft\'s interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it\'s designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]


local plugin = Gatherer_HUD

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local function getDefault(setting)
	if (setting == "plugin.gatherer_hud.radius")            then return 500                  end
	if (setting == "plugin.gatherer_hud.iconsize")          then return 40                   end
	if (setting == "plugin.gatherer_hud.offset.horizontal") then return 0                    end
	if (setting == "plugin.gatherer_hud.offset.vertical")   then return -200                 end
	if (setting == "plugin.gatherer_hud.alpha")             then return 70                   end
	if (setting == "plugin.gatherer_hud.strata")            then return 1                    end
	if (setting == "plugin.gatherer_hud.yards")             then return 1200                 end
	if (setting == "plugin.gatherer_hud.fade")              then return 45                   end
	if (setting == "plugin.gatherer_hud.angle")             then return 40                   end
	if (setting == "plugin.gatherer_hud.perspective")       then return 10                   end
	if (setting == "plugin.gatherer_hud.heat.enable")       then return true                 end
	if (setting == "plugin.gatherer_hud.heat.cooldown")     then return 600                  end
	if (setting == "plugin.gatherer_hud.heat.size")         then return 120                  end
	if (setting == "plugin.gatherer_hud.heat.alpha")        then return 25                   end
	if (setting == "plugin.gatherer_hud.base.enable")       then return false                end
	if (setting == "plugin.gatherer_hud.base.alpha")        then return 50                   end
	if (setting == "plugin.gatherer_hud.hide.combat")       then return true                 end
	if (setting == "plugin.gatherer_hud.hide.target")       then return true                 end
	if (setting == "plugin.gatherer_hud.hide.flying")       then return false                end
	if (setting == "plugin.gatherer_hud.hide.inside")       then return true                 end
	if (setting == "plugin.gatherer_hud.hide.mounted")      then return false                end
	if (setting == "plugin.gatherer_hud.hide.walking")      then return false                end
	if (setting == "plugin.gatherer_hud.hide.resting")      then return true                 end
	if (setting == "plugin.gatherer_hud.hide.stealth")      then return true                 end
	if (setting == "plugin.gatherer_hud.hide.swimming")     then return false                end
	if (setting == "plugin.gatherer_hud.base.color")        then return "0.0, 0.0, 0.0, 0.5" end
	if (setting == "plugin.gatherer_hud.center.color")      then return "1.0, 1.0, 1.0, 0.4" end
	if (setting == "plugin.gatherer_hud.heat.color")        then return "1.0, 0.3, 0.0, 0.7" end
	if (setting == "plugin.gatherer_hud.party.color")       then return "0.2, 0.2, 1.0, 0.7" end
	if (setting == "plugin.gatherer_hud.party.enable")      then return false                end
	if (setting == "plugin.gatherer_hud.party.size")        then return 40                   end
	if (setting == "plugin.gatherer_hud.base.enable")       then return false                end
	if (setting == "plugin.gatherer_hud.center.enable")     then return true                 end
	if (setting == "plugin.gatherer_hud.min_fullframerate") then return 100                  end

end

local function makeConfigTab( gui )
	local tabName = GetAddOnMetadata("Gatherer_HUD", "X-Gatherer-Plugin-Name")
	
	local _, id = gui:GetTabByName(tabName, "PLUGINS")
	gui:MakeScrollable(id)
	gui:AddControl(id, "Note",       0, 1, 565, 30, _tr("HUD_CONFIG_USAGE_NOTE"))
	
	gui:AddControl(id, "Subhead",    0,    _trL("HUD_CONFIG_DISPLAY_LABEL"))
	gui:AddControl(id, "Selectbox",  0, 2, {
		{1, _trL("STRATA_BACKGROUND")},
		{2, _trL("STRATA_LOW")},
		{3, _trL("STRATA_MEDIUM")},
		{4, _trL("STRATA_HIGH")}
	}, "plugin.gatherer_hud.strata", _trL("HUD_CONFIG_STRATA_LABEL"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.radius", 25, 800, 25, _trL("HUD_CONFIG_plugin.gatherer_hud.radius"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.iconsize", 5, 80, 1, _trL("HUD_CONFIG_plugin.gatherer_hud.iconsize"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.offset.horizontal", -800, 800, 10, _trL("HUD_CONFIG_plugin.gatherer_hud.offset.horizontal"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.offset.vertical", -800, 800, 10, _trL("HUD_CONFIG_plugin.gatherer_hud.offset.vertical"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.alpha", 1, 100, 1, _trL("HUD_CONFIG_plugin.gatherer_hud.alpha"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.yards", 100, 2000, 100, _trL("HUD_CONFIG_plugin.gatherer_hud.yards"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.fade", 1, 100, 1, _trL("HUD_CONFIG_plugin.gatherer_hud.fade"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.angle", 1, 90, 1, _trL("HUD_CONFIG_plugin.gatherer_hud.angle"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.perspective", 2, 10, 0.1, _trL("HUD_CONFIG_plugin.gatherer_hud.perspective"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.min_fullframerate", 0, 100, 1, _trL("HUD_CONFIG_plugin.gatherer_hud.min_fullframerate"))
	
	gui:AddControl(id, "Subhead",    0,    _trL("HUD_CONFIG_HIDING_LABEL"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.combat", _trL("HUD_CONFIG_plugin.gatherer_hud.hide.combat"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.target", _trL("HUD_CONFIG_plugin.gatherer_hud.hide.target"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.flying", _trL("HUD_CONFIG_plugin.gatherer_hud.hide.flying"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.inside", _trL("HUD_CONFIG_plugin.gatherer_hud.hide.inside"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.mounted", _trL("HUD_CONFIG_plugin.gatherer_hud.hide.mounted"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.walking", _trL("HUD_CONFIG_plugin.gatherer_hud.hide.walking"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.resting", _trL("HUD_CONFIG_plugin.gatherer_hud.hide.resting"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.stealth", _trL("HUD_CONFIG_plugin.gatherer_hud.hide.stealth"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.swimming", _trL("HUD_CONFIG_plugin.gatherer_hud.hide.swimming"))
	
	gui:AddControl(id, "Subhead",    0,    _trL("HUD_CONFIG_VISIBILITY_LABEL"))
	gui:AddControl(id, "Checkbox",   0, 2, "plugin.gatherer_hud.base.enable", _trL("HUD_CONFIG_plugin.gatherer_hud.base.enable"))
	gui:AddControl(id, "ColorSelectAlpha", 0, 3, "plugin.gatherer_hud.base.color", _trL("HUD_CONFIG_plugin.gatherer_hud.base.color"))
	gui:AddControl(id, "Checkbox",   0, 2, "plugin.gatherer_hud.center.enable", _trL("HUD_CONFIG_plugin.gatherer_hud.center.enable"))
	gui:AddControl(id, "ColorSelectAlpha", 0, 3, "plugin.gatherer_hud.center.color", _trL("HUD_CONFIG_plugin.gatherer_hud.center.color"))
	gui:AddControl(id, "Checkbox",   0, 2, "plugin.gatherer_hud.heat.enable", _trL("HUD_CONFIG_plugin.gatherer_hud.heat.enable"))
	gui:AddControl(id, "ColorSelectAlpha", 0, 3, "plugin.gatherer_hud.heat.color", _trL("HUD_CONFIG_plugin.gatherer_hud.heat.color"))
	gui:AddControl(id, "Checkbox",   0, 2, "plugin.gatherer_hud.party.enable", _trL("HUD_CONFIG_plugin.gatherer_hud.party.enable"))
	gui:AddControl(id, "ColorSelectAlpha", 0, 3, "plugin.gatherer_hud.party.color", _trL("HUD_CONFIG_plugin.gatherer_hud.party.color"))
	gui:AddControl(id, "WideSlider", 0, 3, "plugin.gatherer_hud.party.size", 5, 80, 1, _trL("HUD_CONFIG_plugin.gatherer_hud.party.size"))
	gui:AddControl(id, "Subhead",    0,    _trL("HUD_CONFIG_HEAT_TRACKING_LABEL"))
	gui:AddControl(id, "WideSlider", 0, 3, "plugin.gatherer_hud.heat.cooldown", 10, 4800, 10, _trL("HUD_CONFIG_plugin.gatherer_hud.heat.cooldown"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.heat.nevercooldown", _trL("HUD_CONFIG_plugin.gatherer_hud.heat.nevercooldown"))
	gui:AddControl(id, "WideSlider", 0, 3, "plugin.gatherer_hud.heat.size", 0, 300, 10, _trL("HUD_CONFIG_plugin.gatherer_hud.heat.size"))
end

local function onConfigChange(setting, value)
	if ( setting:sub(1, 20) == "plugin.gatherer_hud." ) then
		Gatherer_HUD.UpdateStruture()
	end
end

function Gatherer_HUD.Register()
	Gatherer.Plugins.RegisterPlugin("Gatherer_HUD", getDefault, makeConfigTab, onConfigChange)
end
