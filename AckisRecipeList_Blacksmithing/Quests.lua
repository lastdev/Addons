-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-------------------------------------------------------------------------------
-- Module namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local addon = private.addon
if not addon then
	return
end

local constants = addon.constants
local module = addon:GetModule(private.module_name)

local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeQuests()
	local function AddQuest(questID, zoneName, coordX, coordY, faction)
		addon.AcquireTypes.Quest:AddEntity(module, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = questID,
			item_list = {},
			location = zoneName,
			name = nil, -- Handled by memoizing table in the core.
		})
	end

	AddQuest(1578,	Z.IRONFORGE,			48.5,	43.0,	"Alliance")
	AddQuest(1618,	Z.IRONFORGE,			48.5,	43.0,	"Alliance")
	AddQuest(2751,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(2752,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(2753,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(2754,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(2755,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(7604,	Z.BLACKROCK_DEPTHS,		0,	0,	"Neutral")

	self.InitializeQuests = nil
end
