--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.4.0 (<%codename%>)
	Revision: $Id: GatherConfig.lua 1039 2012-10-06 16:28:36Z Esamynn $

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

	Saved Variables Configuration and management code
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/tags/REL_4.4.0/Gatherer/GatherConfig.lua $", "$Rev: 1039 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

Gatherer.Settings = {}

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.Config, metatable )
setfenv(1, Gatherer.Config)

-- increment this number by 1 to wipe all of the user's current
-- settings when they upgrade
local SETTINGS_VERSION = 2

-- place any variables that the settings table should be
-- initialised with here
Default_Settings = {
}

local function getDefault(setting)
	if (setting == "inspect.enable")    then return false   end
	local a,b,c,d = strsplit(".", setting)
	if (a == "show") then 
		if ( b == "arch" ) then return false end
		if (c == "all" or d == "all") then return false end
		if (d == "onlyiftracked") then return false end
		return true
	end
	if (a == "plugin" and c == "enable") then return false end
	if (b == "enable") then return true end
	if (b == "tooltip" and c == "rate" and d == "num") then return 5 end
	if (b == "tooltip") then return true end
	if (setting == "mainmap.count")     then return 600     end
	if (setting == "mainmap.opacity")   then return 80      end
	if (setting == "mainmap.iconsize")  then return 12      end
	if (setting == "minimap.count")     then return 20      end
	if (setting == "minimap.opacity")   then return 80      end
	if (setting == "minimap.iconsize")  then return 12      end
	if (setting == "minimap.distance")  then return 800     end
	if (setting == "miniicon.angle")    then return 270     end
	if (setting == "miniicon.distance") then return 12      end
	if (setting == "fade.distance")     then return 500     end
	if (setting == "fade.percent")      then return 20      end
	if (setting == "track.circle")      then return true    end
	if (setting == "track.style")       then return "White" end
	if (setting == "track.current")     then return true    end
	if (setting == "track.distance")    then return 110     end
	if (setting == "track.opacity")     then return 80      end
	if (setting == "inspect.tint")      then return true    end
	if (setting == "inspect.distance")  then return 25      end
	if (setting == "inspect.percent")   then return 80      end
	if (setting == "inspect.time")      then return 120     end
	if (setting == "anon.tint")         then return false   end
	if (setting == "anon.opacity")      then return 60      end
	if (setting == "guild.receive")     then return true    end
	if (setting == "guild.print.send")  then return false   end
	if (setting == "guild.print.recv")  then return true    end
	if (setting == "raid.receive")      then return true    end
	if (setting == "raid.print.send")   then return false   end
	if (setting == "raid.print.recv")   then return true    end
	if (setting == "personal.print")    then return false   end
	if (setting == "about.loaded")      then return false   end
	if (setting == "track.colour.HERB") then return "0.250,0.750,0.250" end
	if (setting == "track.colour.MINE") then return "1.000,0.500,0.250" end
	if (setting == "track.colour.FISH") then return "0.100,0.100,1.000" end
	if (setting == "arch.enable")       then return true    end
	if (setting == "arch.minimap.count")then return 20      end
	if (setting == "arch.duration")     then return 60     end

	-- check for a plugin default
	for _, data in pairs(Gatherer.Plugins.Registrations) do
		local func = data.defaults
		if ( func and func(setting) ) then
			return func(setting)
		end
	end
end

--defines keys which are saved in the PerCharacter settings
PerCharacter = {
}

-- Note: This function WILL NOT handle self referencing table
-- structures correctly (ie. it will never terminate)
local function deepCopy( source, dest )
	for k, v in pairs(source) do
		if ( type(v) == "table" ) then
			if not ( type(dest[k]) == "table" ) then
				dest[k] = {}
			end
			deepCopy(v, dest[k])
		else
			dest[k] = v
		end
	end
end

function ConvertOldSettings( conversions )
	local Settings = Gatherer.Settings
	for pat, repl in pairs(conversions) do
		if ( type(repl) == "string" ) then
			for name, profileData in pairs(Settings) do
				if ( name:sub(1, 8) == "profile." ) then
					local newSettings = {}
					for setting, value in pairs(profileData) do
						local new, count = setting:gsub(pat, repl)
						if ( count >= 1 ) then
							newSettings[new] = value
							profileData[setting] = nil
						end
					end
					for setting, value in pairs(newSettings) do
						profileData[setting] = value
					end
				end
			end
		elseif ( repl == false ) then
			for name, profileData in pairs(Settings) do
				if ( name:sub(1, 8) == "profile." ) then
					for setting, value in pairs(profileData) do
						if ( setting:find(pat) ) then
							profileData[setting] = nil
						end
					end
				end
			end
		end
	end
end

local oldSettingsConversions = {
	["^hud%.(.*)$"] = "plugin.gatherer_hud.%1", -- convert old non-plugin HUD settings
	["^track.colour.ARCH$"] = false,
	["^show.+arch"] = false,
	
}

--Load settings from the SavedVariables tables
function Load()
	local Settings = Gatherer.Settings
	deepCopy(Default_Settings, Settings)
	
	if ( Gatherer_SavedSettings_AccountWide and 
	     Gatherer_SavedSettings_AccountWide.SETTINGS_VERSION == SETTINGS_VERSION ) then
		deepCopy(Gatherer_SavedSettings_AccountWide, Settings)
	end

	if ( Gatherer_SavedSettings_PerCharacter and 
	     Gatherer_SavedSettings_PerCharacter.SETTINGS_VERSION == SETTINGS_VERSION ) then
		deepCopy(Gatherer_SavedSettings_PerCharacter, Settings)
	end

	ConvertOldSettings(oldSettingsConversions)

	-- Sharing Blacklist
	SharingBlacklist_Load()
end

--Save settings to the SavedVariables tables
-- Call this when the PLAYER_LOGOUT event fires or saved settings
-- will not be updated
function Save()
	local data = Gatherer.Settings

	local accountSettings = { SETTINGS_VERSION = SETTINGS_VERSION }
	for key in pairs(data) do
		accountSettings[key] = data[key]
	end
	_G.Gatherer_SavedSettings_AccountWide = accountSettings

	local characterSettings = { SETTINGS_VERSION = SETTINGS_VERSION }
	for _, key in pairs(PerCharacter) do
		characterSettings[key] = data[key]
	end
	_G.Gatherer_SavedSettings_PerCharacter = characterSettings

	SharingBlacklist_Save()
end

--*****************************************************************************
-- Settings Manipulation Functions
--*****************************************************************************

local function getUserSig()
	local userSig = string.format("users.%s.%s", GetRealmName(), UnitName("player"))
	return userSig
end

local function getUserProfileName()
	local SETTINGS = Gatherer.Settings
	local userSig = getUserSig()
	return SETTINGS[userSig] or "Default"
end

local itc = 0
local function getUserProfile()
	local SETTINGS = Gatherer.Settings
	local profileName = getUserProfileName()
	if (not SETTINGS["profile."..profileName]) then
		if profileName ~= "Default" then
			profileName = "Default"
			SETTINGS[getUserSig()] = "Default"
		end
		if profileName == "Default" then
			SETTINGS["profile."..profileName] = {}
		end
	end
	return SETTINGS["profile."..profileName]
end

local function cleanse( source )
	for k in pairs(source) do
		source[k] = nil
	end
end

local updateTracker = {}
local function setUpdated()
	for k in pairs(updateTracker) do
		updateTracker[k] = nil
	end
end

function Gatherer.Command.IsUpdated(what)
	if not updateTracker[what] then
		updateTracker[what] = true
		return true
	end
	return false
end

local function setter(setting, value)
	local SETTINGS = Gatherer.Settings
	local a,b,c = strsplit(".", setting)
	if (a == "profile") then
		local gui = Gatherer.Config.Gui
		if (setting == "profile.save") then
			value = gui.elements["profile.name"]:GetText()

			-- Create the new profile
			SETTINGS["profile."..value] = {}

			-- Set the current profile to the new profile
			SETTINGS[getUserSig()] = value
			-- Get the new current profile
			local newProfile = getUserProfile()
			-- Clean it out and then resave all data
			cleanse(newProfile)
			gui:Resave()

			-- Add the new profile to the profiles list
			local profiles = SETTINGS["profiles"]
			if (not profiles) then
				profiles = { "Default" }
				SETTINGS["profiles"] = profiles
			end
			-- Check to see if it already exists
			local found = false
			for pos, name in ipairs(profiles) do
				if (name == value) then found = true end
			end
			-- If not, add it and then sort it
			if (not found) then
				table.insert(profiles, value)
				table.sort(profiles)
			end
			DEFAULT_CHAT_FRAME:AddMessage("Saved profile: "..value)
		elseif (setting == "profile.copy") then
			value = gui.elements["profile.name"]:GetText()

			local curprofile = getUserProfileName()
			-- Create the new profile
			SETTINGS["profile."..value] = SETTINGS["profile."..curprofile]

			-- Set the current profile to the new profile
			SETTINGS[getUserSig()] = value
			-- Get the new current profile
			local newProfile = getUserProfile()
			--[[-- Clean it out and then resave all data
			cleanse(newProfile)
			gui:Resave()
			--]]

			-- Add the new profile to the profiles list
			local profiles = SETTINGS["profiles"]
			if (not profiles) then
				profiles = { "Default" }
				SETTINGS["profiles"] = profiles
			end
			-- Check to see if it already exists
			local found = false
			for pos, name in ipairs(profiles) do
				if (name == value) then found = true end
			end
			-- If not, add it and then sort it
			if (not found) then
				table.insert(profiles, value)
				table.sort(profiles)
			end
			DEFAULT_CHAT_FRAME:AddMessage("Saved profile: "..value)
		elseif (setting == "profile.delete") then
			-- User clicked the Delete button, see what the select box's value is.
			value = gui.elements["profile"].value

			-- If there's a profile name supplied
			if (value) then
				-- Clean it's profile container of values
				cleanse(SETTINGS["profile."..value])
				-- Delete it's profile container
				SETTINGS["profile."..value] = nil
				-- Find it's entry in the profiles list
				local profiles = SETTINGS["profiles"]
				if (profiles) then
					for pos, name in ipairs(profiles) do
						-- If this is it, then extract it
						if (name == value and name ~= "Default") then
							table.remove(profiles, pos)
						end
					end
				end
				-- If the user was using this one, then move them to Default
				if (getUserProfileName() == value) then
					SETTINGS[getUserSig()] = 'Default'
				end
				DEFAULT_CHAT_FRAME:AddMessage("Deleted profile: "..value)
			end
		elseif (setting == "profile") then
			-- User selected a different value in the select box, get it
			value = gui.elements["profile"].value

			-- Change the user's current profile to this new one
			SETTINGS[getUserSig()] = value
			DEFAULT_CHAT_FRAME:AddMessage(_tr("CONFIG_PROFILE_CHANGE_NOTIFICATION", value))
		end

		-- Refresh all values to reflect current data
		gui:Refresh()
	
	else
		-- Set the value for this setting in the current profile
		local db = getUserProfile()
		db[setting] = value
		setUpdated()
		Gatherer.MiniNotes.Show()
		Gatherer.MapNotes.Update()
	end

	if ( a == "plugin" ) then
		if ( (c == "enable") and value ) then
			Gatherer.Plugins.LoadPlugin(b:lower())
		end
		local func = Gatherer.Plugins.ConfigUpdateFunctions[b]
		if ( func ) then
			func(setting, value)
		end
	end

	if (a == "miniicon") then
		Gatherer.MiniIcon.Reposition()
	end
	if (a == "minimap") then
		Gatherer.MiniIcon.Update()
	end
end
function SetSetting(...)
	local gui = Gatherer.Config.Gui
	setter(...)
	if (gui) then
		gui:Refresh()
	end
end
	

local function getter(setting)
	local SETTINGS = Gatherer.Settings
	if not setting then return end

	local a,b,c = strsplit(".", setting)
	if (a == 'profile') then
		if (b == 'profiles') then
			local pList = SETTINGS["profiles"]
			if (not pList) then
				pList = { "Default" }
			end
			return pList
		end
	end
	if (setting == 'profile') then
		return getUserProfileName()
	end
	local db = getUserProfile()
	if ( db[setting] ~= nil ) then
		return db[setting]
	else
		return getDefault(setting)
	end
end
function GetSetting(setting, default)
	local option = getter(setting)
	if ( option ~= nil ) then
		local a,b,c = strsplit(".", setting)
		if ( a == "track" and b == "colour" ) then
			local r, g, b = strsplit(",", tostring(option))
			return r, g, b
		end
		return option
	else
		return default
	end
end

function DisplayFilter_MainMap( nodeId, gType )
	if ( gType and not nodeId ) then
		return getter("show.mainmap."..tostring(gType):lower())
	end
	local nodeType = Gatherer.Nodes.Objects[nodeId]
	if not ( nodeType ) then
		return false
	end
	local skill = Gatherer.Var.Skills[nodeType]
	nodeType = nodeType:lower()
	local showType = "show.mainmap."..nodeType
	local showAll = showType..".all"
	local showObject = "show."..nodeType.."."..nodeId
	local isTracked = Gatherer.Util.IsGatherTracked
	local onlyIfTracked = getter("show.mainmap."..nodeType..".onlyiftracked")
	local onlyIfSkilled = getter("show.mainmap."..nodeType..".onlyifskilled")
	return (
		getter(showType) and
		(getter(showAll) or getter(showObject)) and
		((not onlyIfTracked) or isTracked(nodeId)) and
		((not onlyIfSkilled) or skill)
	)
end

function DisplayFilter_MiniMap( nodeId, gType )
	if ( gType and not nodeId ) then
		return getter("show.minimap."..tostring(gType):lower())
	end
	local nodeType = Gatherer.Nodes.Objects[nodeId]
	if not ( nodeType ) then
		return false
	end
	local skill = Gatherer.Var.Skills[nodeType]
	nodeType = nodeType:lower()
	local showType = "show.minimap."..nodeType
	local showAll = showType..".all"
	local showObject = "show."..nodeType.."."..nodeId
	local isTracked = Gatherer.Util.IsGatherTracked
	local onlyIfTracked = getter("show.minimap."..nodeType..".onlyiftracked")
	local onlyIfSkilled = getter("show.minimap."..nodeType..".onlyifskilled")
	return (
		getter(showType) and
		(getter(showAll) or getter(showObject)) and
		((not onlyIfTracked) or isTracked(nodeId)) and
		((not onlyIfSkilled) or skill)
	)
end

function Show()
	MakeGuiConfig()
	Gui:Show()
end

function ShowOptions()
	Show()
end

function Hide()
	if ( Gui ) then
		Gui:Hide()
	end
end

function HideOptions()
	Hide()
end

function ToggleOptions()
	if ( Gui and Gui:IsShown() ) then
		HideOptions()
	else
		ShowOptions()
	end
end

function MakeGuiConfig()
	if ( Gui ) then return end

	local id, last, cont
	local Configator = LibStub:GetLibrary("Configator")
	local gui = Configator:Create(setter, getter)
	Gui = gui

	gui:AddCat( _trL("CONFIG_SECTION_HEADER_CORE"), nil, false, true)

	----------------------------------------------------------------------
	-- Profiles
	----------------------------------------------------------------------
	
	id = gui:AddTab( _trL("CONFIG_SECTION_PROFILES"))
	gui:AddControl(id, "Header",     0,    _trL("CONFIG_SECTION_TITLE_PROFILES"))
	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_PROFILE_CURRENT_LABEL"))
	gui:AddControl(id, "Selectbox",  0, 1, "profile.profiles", "profile")
	gui:AddControl(id, "Button",     0, 1, "profile.delete", _trL("DELETE"))
	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_PROFILE_NEW"))
	gui:AddControl(id, "Text",       0, 1, "profile.name", _trL("CONFIG_PROFILE_NEW_LABEL"))
	gui:AddControl(id, "Button",     0, 1, "profile.save", _trL("CONFIG_PROFILE_CREATE_NEW"))
	gui:AddControl(id, "Button",     0, 1, "profile.copy", _trL("CONFIG_PROFILE_CREATE_COPY"))
	
	----------------------------------------------------------------------
	-- General
	----------------------------------------------------------------------
	
	id = gui:AddTab(_trL("CONFIG_SECTION_GENERAL"))
	gui:AddControl(id, "Header",     0,    _trL("CONFIG_SECTION_TITLE_GENERAL"))
	last = gui:GetLast(id) -- Get the current position so we can return here for the second column

	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_GENERAL_WORLDMAP_LABEL"))
	gui:AddControl(id, "Checkbox",   0, 1, "mainmap.enable", _trL("CONFIG_WORLDMAP_ENABLE"))
	gui:AddControl(id, "Slider",     0, 2, "mainmap.count", 10, 2500, 10, _trL("CONFIG_WORLDMAP_MAX_NOTES"))
	gui:AddControl(id, "Slider",     0, 2, "mainmap.opacity", 10, 100, 2, _trL("CONFIG_WORLDMAP_NOTE_OPACITY"))
	gui:AddControl(id, "Slider",     0, 2, "mainmap.iconsize", 4, 64, 1, _trL("CONFIG_WORLDMAP_ICON_SIZE"))
	gui:AddControl(id, "Checkbox",   0, 1, "mainmap.tooltip.enable", _trL("CONFIG_TOOLTIP_ENABLE"))
	gui:AddControl(id, "Checkbox",   0, 2, "mainmap.tooltip.count", _trL("CONFIG_TOOLTIP_COUNTS"))
	gui:AddControl(id, "Checkbox",   0, 2, "mainmap.tooltip.source", _trL("CONFIG_TOOLTIP_SOURCE"))
	gui:AddControl(id, "Checkbox",   0, 2, "mainmap.tooltip.seen", _trL("CONFIG_TOOLTIP_LAST_SEEN"))
	gui:AddControl(id, "Checkbox",   0, 2, "mainmap.tooltip.rate", _trL("CONFIG_TOOLTIP_DROP_RATES"))

	gui:AddControl(id, "Subhead",  0,    _trL("LABEL_NOTE"))
	gui:AddControl(id, "Note",     0, 1, 290, 40, _tr("CONFIG_ALL_FILTER_NOTE", _tr("ALL")))

	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_GENERAL_MINIICON_LABEL"))
	gui:AddControl(id, "Checkbox",   0, 1, "miniicon.enable", _trL("CONFIG_MINIICON_ENABLE"))
	gui:AddControl(id, "Slider",     0, 2, "miniicon.angle", 0, 360, 1, _trL("CONFIG_MINIICON_ANGLE"))
	gui:AddControl(id, "Slider",     0, 2, "miniicon.distance", -80, 80, 1, _trL("CONFIG_MINIICON_DISTANCE"))

	gui:SetLast(id, last) -- Return to the saved position
	gui:AddControl(id, "Subhead",  0.5,    _trL("CONFIG_GENERAL_MINIMAP_TRACKING_LABEL"))
	local curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.minimap.mine", _trL("CONFIG_ENABLE_MINE"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.minimap.mine.all", _trL("ALL"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.mine.onlyifskilled", _trL("CONFIG_ENABLE_MINE_MINER_ONLY"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.mine.onlyiftracked", _trL("CONFIG_ENABLE_ONLY_IF_TRACKING"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.minimap.herb", _trL("CONFIG_ENABLE_HERB"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.minimap.herb.all", _trL("ALL"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.herb.onlyifskilled", _trL("CONFIG_ENABLE_HERB_HERBALIST_ONLY"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.herb.onlyiftracked", _trL("CONFIG_ENABLE_ONLY_IF_TRACKING"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.minimap.open", _trL("ENABLE_OPEN"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.minimap.open.all", _trL("ALL"))
	--gui:AddControl(id, "Checkbox", 0.5, 2, "show.minimap.open.onlyiftracked", _trL("CONFIG_ENABLE_ONLY_IF_TRACKING"))

	gui:AddControl(id, "Subhead",  0.5,    _trL("CONFIG_GENERAL_WORLDMAP_TRACKING_LABEL"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.mainmap.mine", _trL("CONFIG_ENABLE_MINE"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.mainmap.mine.all", _trL("ALL"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.mine.onlyifskilled", _trL("CONFIG_ENABLE_MINE_MINER_ONLY"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.mine.onlyiftracked", _trL("CONFIG_ENABLE_ONLY_IF_TRACKING"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.mainmap.herb", _trL("CONFIG_ENABLE_HERB"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.mainmap.herb.all", _trL("ALL"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.herb.onlyifskilled", _trL("CONFIG_ENABLE_HERB_HERBALIST_ONLY"))
	gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.herb.onlyiftracked", _trL("CONFIG_ENABLE_ONLY_IF_TRACKING"))
	curpos = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0.5, 1, "show.mainmap.open", _trL("ENABLE_OPEN"))
	gui:SetLast(id, curpos)
	gui:AddControl(id, "Checkbox", 0.85, 1, "show.mainmap.open.all", _trL("ALL"))
	--gui:AddControl(id, "Checkbox", 0.5, 2, "show.mainmap.open.onlyiftracked", _trL("CONFIG_ENABLE_ONLY_IF_TRACKING"))

	----------------------------------------------------------------------
	-- Minimap
	----------------------------------------------------------------------
	
	id = gui:AddTab(_trL("CONFIG_SECTION_MINIMAP"))
	gui:AddControl(id, "Header",     0,    _trL("CONFIG_SECTION_TITLE_MINIMAP"))
	last = gui:GetLast(id) -- Get the current position so we can return here for the second column
	local headerPosition = gui:GetLast(id):GetBottom()

	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_MINIMAP_LABEL"))
	gui:AddControl(id, "Checkbox",   0, 1, "minimap.enable", _trL("CONFIG_MINIMAP_ENABLE"))
	gui:AddControl(id, "Slider",     0, 2, "minimap.count", 1, 50, 1, _trL("CONFIG_MINIMAP_MAX_NOTES"))
	gui:AddControl(id, "Slider",     0, 2, "minimap.opacity", 0, 100, 1, _trL("CONFIG_MINIMAP_NOTE_OPACITY"))
	gui:AddControl(id, "Slider",     0, 2, "minimap.iconsize", 4, 64, 1, _trL("CONFIG_MINIMAP_ICON_SIZE"))
	gui:AddControl(id, "Slider",     0, 2, "minimap.distance", 100, 5000, 50, _trL("CONFIG_MINIMAP_DISTANCE"))
	gui:AddControl(id, "Checkbox",   0, 1, "minimap.tooltip.enable", _trL("CONFIG_TOOLTIP_ENABLE"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.count", _trL("CONFIG_TOOLTIP_COUNTS"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.source", _trL("CONFIG_TOOLTIP_SOURCE"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.seen", _trL("CONFIG_TOOLTIP_LAST_SEEN"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.distance", _trL("CONFIG_TOOLTIP_DISTANCE"))
	gui:AddControl(id, "Checkbox",   0, 2, "minimap.tooltip.rate", _trL("CONFIG_TOOLTIP_DROP_RATES"))

	gui:SetLast(id, last) -- Return to the saved position
	gui:AddControl(id, "Subhead",   0.49,    _trL("CONFIG_MINIMAP_ADD_LABEL"))
	gui:AddControl(id, "Checkbox",  0.49, 1, "fade.enable", _trL("CONFIG_MINIMAP_FADE_ENABLE"));
	gui:AddControl(id, "Slider",    0.49, 2, "fade.distance", 10, 1000, 10, _trL("CONFIG_MINIMAP_FADE_DIST"))
	gui:AddControl(id, "Slider",    0.49, 2, "fade.percent", 0, 100, 1, _trL("CONFIG_MINIMAP_FADE_PERCENT"))
	gui:AddControl(id, "Checkbox",  0.49, 1, "track.enable", _trL("CONFIG_MINIMAP_TRACKING_ENABLE"));
	gui:AddControl(id, "Checkbox",  0.49, 2, "track.circle", _trL("CONFIG_MINIMAP_TRACKING_CIRCLE_ENABLE"))
	for _, type in pairs(Gatherer.Constants.ProfessionTextures) do
		if ( type ~= "FISH" and type ~= "ARCH" ) then
			local nameKey = { MINE = "TRADE_MINING", HERB = "TRADE_HERBALISM"}
			gui:AddControl(id, "ColorSelect", 0.49, 3, "track.colour."..type, _trC(nameKey[type]) or type);
		end
	end
	gui:AddControl(id, "Checkbox",  0.49, 2, "track.current", _trL("CONFIG_MINIMAP_TRACKING_ACTIVE_ONLY"));
	gui:AddControl(id, "Slider",    0.49, 2, "track.distance", 50, 150, 1, _trL("CONFIG_MINIMAP_TRACKING_DISTANCE"))
	gui:AddControl(id, "Slider",    0.49, 2, "track.opacity", 0, 100, 1, _trL("CONFIG_MINIMAP_TRACKING_OPACITY"))
	gui:AddControl(id, "Checkbox",  0.49, 1, "inspect.enable", _trL("CONFIG_MINIMAP_INSPECT_ENABLE"))
	gui:AddControl(id, "Checkbox",  0.49, 2, "inspect.tint", _trL("CONFIG_MINIMAP_INSPECT_TINT_ENABLE"))
	gui:AddControl(id, "Slider",    0.49, 2, "inspect.distance", 1, 100, 1, _trL("CONFIG_MINIMAP_INSPECT_DIST"))
	gui:AddControl(id, "Slider",    0.49, 2, "inspect.percent", 0, 100, 1, _trL("CONFIG_MINIMAP_INSPECT_FADING"))
	gui:AddControl(id, "Slider",    0.49, 2, "inspect.time", 10, 900, 10, _trL("CONFIG_MINIMAP_INSPECT_TIMEOUT"))
	gui:AddControl(id, "Checkbox",  0.49, 1, "anon.enable", _trL("CONFIG_MINIMAP_ANON_ENABLE"));
	gui:AddControl(id, "Checkbox",  0.49, 2, "anon.tint", _trL("CONFIG_MINIMAP_ANON_TINT"));
	gui:AddControl(id, "Slider",    0.49, 2, "anon.opacity", 0, 100, 1, _trL("CONFIG_MINIMAP_ANON_OPACITY"));
	
	if ( headerPosition - gui:GetLast(id):GetBottom() > 375 ) then
		gui:MakeScrollable(id)
	end
	----------------------------------------------------------------------
	-- Sharing
	----------------------------------------------------------------------
	
	id = gui:AddTab(_trL("CONFIG_SECTION_SHARING"))
	gui:AddControl(id, "Header",     0,    _trL("CONFIG_SECTION_TITLE_SHARING"))
	last = gui:GetLast(id) -- Get the current position so we can return here for the second column

	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_SHARING_GUILD_LABEL"))
	gui:AddControl(id, "Checkbox",   0, 1, "guild.enable", _trL("CONFIG_SHARING_GUILD_ENABLE"), true, 290)
	gui:AddControl(id, "Checkbox",   0, 2, "guild.receive", _trL("CONFIG_SHARING_GUILD_DATABASE"), true, 290)
	gui:AddControl(id, "Checkbox",   0, 2, "guild.print.send", _trL("CONFIG_SHARING_GUILD_MESSAGE_SENT"), true, 290)
	gui:AddControl(id, "Checkbox",   0, 2, "guild.print.recv", _trL("CONFIG_SHARING_GUILD_MESSAGE_RECV"), true, 290)

	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_SHARING_GROUP_LABEL"))
	gui:AddControl(id, "Checkbox",   0, 1, "raid.enable", _trL("CONFIG_SHARING_GROUP_ENABLE"), true, 290)
	gui:AddControl(id, "Checkbox",   0, 2, "raid.receive", _trL("CONFIG_SHARING_GROUP_DATABASE"), true, 290)
	gui:AddControl(id, "Checkbox",   0, 2, "raid.print.send", _trL("CONFIG_SHARING_GROUP_MESSAGE_SENT"), true, 290)
	gui:AddControl(id, "Checkbox",   0, 2, "raid.print.recv", _trL("CONFIG_SHARING_GROUP_MESSAGE_RECV"), true, 290)
	
	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_SHARING_PERSONAL_LABEL"))
	gui:AddControl(id, "Checkbox",   0, 1, "personal.print", _trL("CONFIG_SHARING_PERSONAL_ENABLE"), true, 290)

	gui:SetLast(id, last) -- Return to the saved position
	gui:AddControl(id, "Subhead", 0.55,    _trL("CONFIG_SHARING_BLACKLIST_LABEL"))
	gui:AddControl(id, "Custom",  0.55, 0, Gatherer_SharingBlacklistFrame); Gatherer_SharingBlacklistFrame:SetParent(gui.tabs[id][3])
	Gatherer_SharingBlacklist_IgnorePlayerButton:SetText(_trL("IGNORE_PLAYER"))
	Gatherer_SharingBlacklist_StopIgnoreButton:SetText(_trL("STOP_IGNORE"))

	-- Get all objects and insert them into the appropriate subtable
	local itemLists = {}
	local namesSeen = {}
	for name, objid in pairs(Gatherer.Nodes.Names) do
		name = Gatherer.Util.GetNodeName(objid)
		local gtype = Gatherer.Nodes.Objects[objid]:lower()
		if not ( namesSeen[gtype..name] ) then
			namesSeen[gtype..name] = true
			if (not itemLists[gtype]) then itemLists[gtype] = {} end
			local entry = { objid, name }
			local cat = Gatherer.Categories.ObjectCategories[objid]
			if (cat) then
				local skill = Gatherer.Constants.SkillLevel[cat]
				if (skill) then
					table.insert(entry, skill)
				end
			end
			table.insert(itemLists[gtype], entry)
		end
	end

	function entrySort(a, b)
		if (b == nil) then return nil end

		local aName = a[2]
		local bName = b[2]
		local aLevel = a[3]
		local bLevel = b[3]

		if bLevel then
			if aLevel then
				if aLevel < bLevel then return true end
				if bLevel < aLevel then return false end
			else
				return true
			end
		elseif aLevel then
			return false
		end
		local comp = aName < bName
		return comp
	end

	----------------------------------------------------------------------
	-- Mining
	----------------------------------------------------------------------
	
	-- Print out tabs and checkboxes for the above list
	id = gui:AddTab(_trL("TRADE_MINING"))
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _trL("CONFIG_SECTION_TITLE_MINE"))
	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_MINE_FILTER_LABEL"))
	local options = {}
	local list = itemLists.mine
	table.sort(list, entrySort)
	for pos, mine in pairs(list) do
		table.insert(options, { "show.mine."..mine[1], mine[2] })
	end
	gui:ColumnCheckboxes(id, 1, options)


	----------------------------------------------------------------------
	-- Herbalism
	----------------------------------------------------------------------
	
	id = gui:AddTab(_trL("TRADE_HERBALISM"))
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _trL("CONFIG_SECTION_TITLE_HERB"))
	gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_HERB_FILTER_LABEL"))
	local options = {}
	local list = itemLists.herb
	table.sort(list, entrySort)
	for pos, herb in pairs(list) do
		table.insert(options, { "show.herb."..herb[1], herb[2] })
	end
	gui:ColumnCheckboxes(id, 1, options)

	----------------------------------------------------------------------
	-- Treasure
	----------------------------------------------------------------------
	
	id = gui:AddTab(_trL("CONFIG_SECTION_OPEN"))
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _trL("CONFIG_SECTION_TITLE_OPEN"))
	last = gui:AddControl(id, "Subhead",    0,    _trL("CONFIG_OPEN_FILTER_LABEL"))
	local options = {}
	local list = itemLists.open
	table.sort(list, entrySort)
	for pos, open in pairs(list) do
		table.insert(options, { "show.open."..open[1], open[2] })
	end
	gui:ColumnCheckboxes(id, 1, options)

	----------------------------------------------------------------------
	-- Archaeology
	----------------------------------------------------------------------
	
	id = gui:AddTab(_trL("PROFESSIONS_ARCHAEOLOGY"))
	gui:AddControl(id, "Header",     0,    _trL("CONFIG_SECTION_TITLE_ARCH"))
	gui:AddControl(id, "Checkbox",   0, 1, "arch.enable", _trL("ENABLE"))
	gui:AddControl(id, "Slider",     0, 2, "arch.minimap.count", 1, 50, 1, _trL("CONFIG_ARCH_MAX_NOTES"))

	----------------------------------------------------------------------
	-- About
	----------------------------------------------------------------------
	
	id = gui:AddTab(_trL("CONFIG_SECTION_ABOUT"))
	gui:AddControl(id, "Header",   0,           _trL("CONFIG_SECTION_TITLE_ABOUT"))
	gui:AddControl(id, "Checkbox", 0, 0, "about.loaded", _trL("CONFIG_ABOUT_LOADED_ENABLE"))
	gui:AddControl(id, "Subhead",  0,            _tr("VERSION_MESSAGE", Gatherer.Var.Version))
	gui:AddControl(id, "Note", 0,  1, 590, nil, _trL("DESCRIPTION"))
	gui:AddControl(id, "Note", 0,  1, 590, nil, _trL("DESCRIPTION_LICENSE"))

	-- Create Plugins Section
	gui:AddCat("PLUGINS", _trL("CONFIG_SECTION_HEADER_PLUGINS"), true, true)
	for name, data in pairs(Gatherer.Plugins.Data) do
		local id = gui:AddTab(data.tabName)
		name = name:lower()
		if ( data.type ~= "DATABASE" ) then
			gui:AddControl(id, "Checkbox",   0, 1, "plugin."..name..".enable", _trL("ENABLE"))
		end
		gui:AddControl(id, "Header",     0,    data.title)
		gui:AddControl(id, "Note",       0, 1, 565, nil, data.notes)
		if ( Gatherer.Plugins.Registrations[name] ) then
			Gatherer.Plugins.Registrations[name].makeConfig(gui)
		end
	end

	--Show Node Density search frame
	local NodeSearch = CreateFrame("Button", nil, gui.Backdrop, "OptionsButtonTemplate")
	NodeSearch:SetPoint("RIGHT", gui.Done, "LEFT", -100, 0)
	NodeSearch:SetScript("OnClick", function() gui:Hide() Gatherer.NodeSearch.Show() end)
	NodeSearch:SetText(_tr("LABEL_DENSITY_REPORT"))
	local buttonWidth = NodeSearch:GetFontString():GetWidth() + 15
	if ( buttonWidth > 160 ) then buttonWidth = 160 end
	if ( buttonWidth < 90 ) then buttonWidth = 90 end
	NodeSearch:SetWidth(buttonWidth)
	
	-- Show Gatherables Report
	local GatherablesReport = CreateFrame("Button", "", gui.Backdrop, "OptionsButtonTemplate")
	GatherablesReport:SetPoint("RIGHT", NodeSearch, "LEFT", 0, 0)
	GatherablesReport:SetScript("OnClick", function() gui:Hide() Gatherer.Report.Show() end)
	GatherablesReport:SetText(_tr("LABEL_REPORT"))
	buttonWidth = GatherablesReport:GetFontString():GetWidth() + 15
	if ( buttonWidth > 160 ) then buttonWidth = 160 end
	if ( buttonWidth < 90 ) then buttonWidth = 90 end
	GatherablesReport:SetWidth(buttonWidth)

	-- Any callbacks?
	for name, callback in pairs(GuiHook) do
		callback(gui)
	end
end

GuiHook = {}

function AddCallback(name, callback)
	if (Gui) then 
		callback(Gui)
		return
	end
	
	GuiHook[name] = callback
end

--**************************************
-- Blacklist Frame Functionality
--**************************************

local numIgnoreButtons = 18
SharingBlacklist = {}
SelectedIgnore = 1
LastIgnoredPlayer = nil

function SharingBlacklist_IsPlayerIgnored( name )
	if ( SharingBlacklist[name] ) then
		return true
	else
		return false
	end
end

function SharingBlacklist_Update()
	local numIgnores = #SharingBlacklist
	local nameText;
	local name;
	local ignoreButton;
	if ( numIgnores > 0 ) then
		if ( SelectedIgnore == 0 ) then
			SelectedIgnore = 1
		end
		Gatherer_SharingBlacklist_StopIgnoreButton:Enable();
	else
		Gatherer_SharingBlacklist_StopIgnoreButton:Disable();
	end

	local ignoreOffset = FauxScrollFrame_GetOffset(Gatherer_SharingBlacklist_ScrollFrame);
	local ignoreIndex;
	for i=1, numIgnoreButtons, 1 do
		ignoreIndex = i + ignoreOffset;
		ignoreButton = _G["Gatherer_SharingBlacklist_IgnoreButton"..i];
		ignoreButton:SetText(SharingBlacklist[ignoreIndex] or "");
		ignoreButton:SetID(ignoreIndex);
		-- Update the highlight
		if ( ignoreIndex == SelectedIgnore ) then
			ignoreButton:LockHighlight();
		else
			ignoreButton:UnlockHighlight();
		end
		
		if ( ignoreIndex > numIgnores ) then
			ignoreButton:Hide();
		else
			ignoreButton:Show();
		end
	end
	
	-- ScrollFrame stuff
	FauxScrollFrame_Update(Gatherer_SharingBlacklist_ScrollFrame, numIgnores, numIgnoreButtons, 16);
end

function Blacklist_IgnoreButton_OnClick( button )
	SelectedIgnore = button:GetID()
	SharingBlacklist_Update()
end

function Blacklist_UnignoreButton_OnClick( button )
	local name = SharingBlacklist[SelectedIgnore]
	SharingBlacklist_Remove(name)
end

function SharingBlacklist_Load()
	if ( Gatherer_SharingBlacklist ) then
		SharingBlacklist = Gatherer_SharingBlacklist
	end
	for i, name in ipairs(SharingBlacklist) do
		SharingBlacklist[name] = i
	end
	SharingBlacklist_Update()
end

function SharingBlacklist_Save()
	for key in pairs(SharingBlacklist) do
		if not ( type(key) == "number" ) then
			SharingBlacklist[key] = nil
		end
	end
	_G.Gatherer_SharingBlacklist = SharingBlacklist
end

function SharingBlacklist_Add( name )
	-- name validity checks
	if ( (not name) or name == "" ) then return end
	if ( #name < 2 ) then return end
	name = name:sub(1,1):upper()..name:sub(2)
	local currentSelection = SharingBlacklist[SelectedIgnore]

	if not ( SharingBlacklist[name] ) then
		table.insert(SharingBlacklist, name)
		LastIgnoredPlayer = name
		StaticPopup_Show("GATHERER_REMOVE_BLACKLISTED_NODES")
	end
	table.sort(SharingBlacklist)
	for i, name in ipairs(SharingBlacklist) do
		SharingBlacklist[name] = i
	end
	SelectedIgnore = SharingBlacklist[currentSelection] or 1
	SharingBlacklist_Update()
end

function SharingBlacklist_Remove( name )
	if ( SharingBlacklist[name] ) then
		SharingBlacklist[name] = nil
		for i, ignoreName in ipairs(SharingBlacklist) do
			if ( ignoreName == name ) then
				table.remove(SharingBlacklist, i)
			end
		end
		SelectedIgnore = 1
	end
	table.sort(SharingBlacklist)
	for i, name in ipairs(SharingBlacklist) do
		SharingBlacklist[name] = i
	end
	SharingBlacklist_Update()
end

function SharingBlacklist_RemoveBlacklistedNodes()
	if ( LastIgnoredPlayer ) then
		local numRemoved = 0
		for i, zone in Gatherer.Storage.GetAreaIndices() do
			for _, gatherId, gatherType in Gatherer.Storage.ZoneGatherNames(zone) do
				local result, _, count = Gatherer.Storage.RemoveGather(zone, gatherId, gatherType, LastIgnoredPlayer)
				numRemoved = numRemoved + count
			end
		end
		if ( numRemoved > 0 ) then
			PlaySound("igQuestLogAbandonQuest");
			Gatherer.MiniNotes.ForceUpdate()
			StaticPopup_Show("GATHERER_REMOVED_NODE_COUNT", numRemoved)
		end
	end
	LastIgnoredPlayer = nil
end

function SharingBlacklist_CountBlacklistedNodes()
	local count = 0
	if ( LastIgnoredPlayer ) then
		local storage = Gatherer.Storage
		for i, zone in storage.GetAreaIndices() do
			for _, gatherType in pairs(Gatherer.Constants.SupportedGatherTypes) do
				for nodeIndex in storage.ZoneGatherNodes(zone, gatherType) do
					for _, _, _, _, source in storage.GetNodeGatherNames(zone, gatherType, nodeIndex) do
						if ( source == LastIgnoredPlayer ) then
							count = count + 1
						end
					end
				end
			end
		end
	end
	return count
end

StaticPopupDialogs["GATHERER_ADD_SHARING_IGNORE"] = {
	text = _trL("ADD_IGNORE_LABEL"),
	button1 = _trL("ACCEPT"),
	button2 = _trL("CANCEL"),
	hasEditBox = 1,
	maxLetters = 12,
	OnAccept = function( self )
		local editBox = self.editBox
		SharingBlacklist_Add(editBox:GetText());
	end,
	OnShow = function( self )
		self.editBox:SetFocus();
	end,
	OnHide = function( self )
		self.editBox:SetText("");
	end,
	EditBoxOnEnterPressed = function( self )
		local parent = self:GetParent()
		local name = parent.editBox:GetText();
		self:GetParent():Hide();
		SharingBlacklist_Add(name);
	end,
	EditBoxOnEscapePressed = function( self )
		self:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["GATHERER_REMOVE_BLACKLISTED_NODES"] = {
	text = _trL("CONFIG_IGNORE_PURGE_QUESTION"),
	button1 = _trL("YES"),
	button2 = _trL("NO"),
	OnAccept = function( self )
		StaticPopup_Show("GATHERER_CONFIRM_REMOVE_BLACKLISTED_NODES", SharingBlacklist_CountBlacklistedNodes())
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["GATHERER_CONFIRM_REMOVE_BLACKLISTED_NODES"] = {
	text = _trL("CONFIG_IGNORE_PURGE_CONFIRM"),
	button1 = _trL("YES"),
	button2 = _trL("NO"),
	OnAccept = function( self )
		SharingBlacklist_RemoveBlacklistedNodes()
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["GATHERER_REMOVED_NODE_COUNT"] = {
	text = _trL("CONFIG_IGNORE_PURGE_DONE"),
	button1 = _trL("ACCEPT"),
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};
