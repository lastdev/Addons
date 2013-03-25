--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.2.0 (<%codename%>)
	Revision: $Id: GatherPlugins.lua 1019 2012-09-24 07:15:56Z Esamynn $

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
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Plugin Registration
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherPlugins.lua $", "$Rev: 1019 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.Plugins, metatable )
setfenv(1, Gatherer.Plugins)

Data = {}
Registrations = {}
ConfigUpdateFunctions = {}
Commands = {}

local setting = Gatherer.Config.GetSetting

-- Database plugin make config
local function databaseMakeConfig( name, tabName, dbID )
	name = name:lower()
	return function(gui)
		local _, id = gui:GetTabByName(tabName, "PLUGINS")

		gui:AddControl(id, "Subhead",    0,    _tr("DATABASE_IMPORT_HEADER"))

		local buttonFrame = CreateFrame("Frame", nil, gui.tabs[id][3])
		buttonFrame:SetHeight(24)
		gui:AddControl(id, "Custom", 0, 1, buttonFrame)

		local button = CreateFrame("Button", nil, buttonFrame, "OptionsButtonTemplate")
		button:SetPoint("TOPLEFT", buttonFrame, "TOPLEFT", 0,0)
		button:SetText(_tr("DATABASE_IMPORT_BUTTON_LABEL"))
		button:SetScript("OnClick",
			function()
				LoadPlugin(name)
				if ( Registrations[name] ) then
					local doImport = Registrations[name].doImport
					if ( type(doImport) == "function" ) then
						doImport()
					end
				end
			end
		)

		button.text = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		button.text:SetPoint("LEFT", button, "RIGHT", 5, 0)
		button.text:SetPoint("RIGHT", buttonFrame, "RIGHT", 0, 0)
		button.text:SetJustifyH("LEFT")
		button.text:SetText(dbID)
	end
end

function LoadPluginData()
	for i = 1, GetNumAddOns() do
		local tabName = GetAddOnMetadata(i, "X-Gatherer-Plugin-Name")
		local type = GetAddOnMetadata(i, "X-Gatherer-Plugin-Type")
		if ( tabName ) then
			local cmdName = (GetAddOnMetadata(i, "X-Gatherer-Command-Name") or tabName):lower():gsub("%s+", "")
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
			local type = GetAddOnMetadata(i, "X-Gatherer-Plugin-Type")
			local dbID = GetAddOnMetadata(i, "X-Gatherer-Plugin-DatabaseID")
			name = name:lower()
			Data[name] = {
				tabName = tabName,
				name = name,
				title = title,
				notes = notes,
				type = type,
				dbID = dbID,
			}
			Commands[cmdName] = {
				name = name;
			}
			if ( type == "DATABASE") then
				RegisterPlugin(name, nil, databaseMakeConfig(name, tabName, dbID), nil)
			
			else
				local enabled = setting("plugin."..name..".enable")
				if ( enabled ) then
					LoadAddOn(i)
				end
			end
		end
	end
end

function RegisterPlugin( name, settingDefaults, makeConfig, configUpdate )
	name = name:lower()
	local data = Data[name]
	if ( data ) then
		Registrations[name] = {
			name = name,
			defaults = settingDefaults,
			makeConfig = makeConfig,
		}
		if ( Gatherer.Config.Gui ) then
			makeConfig(Gatherer.Config.Gui)
		end
		if ( type(configUpdate) == "function" ) then
			ConfigUpdateFunctions[name] = configUpdate
		end
	end
end

function RegisterDatabaseImport( name, doImport )
	name = name:lower()
	local data = Data[name]
	local regs = Registrations[name]
	if ( data and regs ) then
		regs.doImport = doImport
	end
end

function LoadPlugin( name )
	name = name:lower()
	if ( Data[name] ) then
		EnableAddOn(name)
		LoadAddOn(name)
	end
end

local Print = Gatherer.Util.ChatPrint
local function PrintUsageLine( plugin, cmd, ... )
	Gatherer.Command.PrintUsageLine("plugin " .. plugin .. " " .. cmd, ...)
end

function ProcessCommands( pluginCmdName, cmd, ... )
	local GetSetting = Gatherer.Config.GetSetting
	local SetSetting = Gatherer.Config.SetSetting
	if ( pluginCmdName == "help" or pluginCmdName == "" or pluginCmdName == nil ) then
		Print("Usage:")
		for cmd, details in pairs(Commands) do
			local pluginStatus = GetSetting("plugin."..details.name..".enable") and "on" or "off"
			PrintUsageLine(cmd, "on||off||toggle", pluginStatus, "turns the " .. Data[details.name].tabName .. " on and off")
		end
	
	elseif ( Commands[pluginCmdName] ) then
		local details = Commands[pluginCmdName]
		local p1, p2 = ...
		local enabled = Gatherer.Command.parseOnOff(cmd)
		if ( enabled ~= nil ) then
			if ( enabled == true ) then
				SetSetting("plugin."..details.name..".enable", true)
				Print("Turned " .. Data[details.name].tabName .. " on")
			
			elseif ( enabled == false ) then
				SetSetting("plugin."..details.name..".enable", false)
				Print("Turned " .. Data[details.name].tabName .. " off")
			
			end
		
		elseif ( cmd == "toggle" ) then
			if ( GetSetting("plugin."..details.name..".enable") ) then
				ProcessCommands(pluginCmdName, "off")
			else
				ProcessCommands(pluginCmdName, "on")
			end
		
		else
			
		
		end
	
	end
end
