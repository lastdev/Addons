-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local tonumber = _G.tonumber
local type = _G.type

-- Libraries
local table = _G.table

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub

local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

-----------------------------------------------------------------------
-- Methods.
-----------------------------------------------------------------------
function private.SetTextColor(color_code, text)
	return ("|cff%s%s|r"):format(color_code or "ffffff", text)
end

function private.ColorRGBtoHEX(r, g, b)
	return ("%02x%02x%02x"):format(r * 255, g * 255, b * 255)
end

function private.ItemLinkToID(item_link)
	if not item_link then
		return
	end
	return tonumber(item_link:match("item:(%d+)"))
end

-- This wrapper exists primarily because Blizzard keeps changing how NPC ID numbers are extracted from GUIDs, and fixing it in one place is less error-prone.
function private.MobGUIDToIDNum(guid)
	return tonumber(guid:sub(6, 10), 16)
end

--[===[@debug@
do
	local function PrintProfessions()
		addon:Print("Must supply a valid profession name, or \"all\":")

		for index = 1, #private.ORDERED_PROFESSIONS do
			addon:Print(private.ORDERED_PROFESSIONS[index])
		end

		for profession_name in pairs(private.PROFESSION_NAME_MAP) do
		end
	end

	private.DUMP_COMMANDS = {
		bossids = function(input)
			if not input then
				addon:Print("Type the name or partial name of a boss.")
				return
			end
			addon:DumpBossIDs(input)
		end,
		empties = function()
			addon:ShowEmptySources()
		end,
		phrases = function()
			addon:DumpPhrases()
		end,
		profession = function(input)
			if not input then
				PrintProfessions()
				return
			end
			local found
			input = input:lower():trim()

			for index = 1, #private.ORDERED_PROFESSIONS do
				if input == private.ORDERED_PROFESSIONS[index]:lower() then
					found = true
					break
				end
			end

			if not found then
				PrintProfessions()
				return
			end
			addon:DumpProfession(input)
		end,
		zones = function(input)
			if not input then
				addon:Print("Type the name or partial name of a zone.")
				return
			end
			addon:DumpZones(input)
		end
	}

	local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
	local output = private.TextDump

	function addon:DumpPhrases()
		local sorted = {}

		for phrase, translation in pairs(L) do
			sorted[#sorted + 1] = phrase
		end
		table.sort(sorted)
		output:Clear()

		for index = 1, #sorted do
			local phrase = sorted[index]
			local translation = L[phrase]

			if phrase == translation then
				output:AddLine(("L[\"%s\"] = true"):format(phrase:gsub("\"", "\\\"")))
			elseif translation:find("\n") then
				output:AddLine(("L[\"%s\"] = [[%s]]"):format(phrase:gsub("\"", "\\\""), translation))
			else
				output:AddLine(("L[\"%s\"] = \"%s\""):format(phrase:gsub("\"", "\\\""), translation:gsub('\"', '\\"')))
			end
		end
		output:Display()
	end

	function addon:DumpMembers(match)
		output:Clear()
		output:AddLine("Addon Object members.\n")

		local count = 0

		for key, value in pairs(self) do
			local val_type = type(value)

			if not match or val_type == match then
				output:AddLine(("%s (%s)"):format(key, val_type))
				count = count + 1
			end
		end
		output:AddLine(("\n%d found\n"):format(count))
		output:Display()
	end

	local function TableKeyFormat(input)
		if not input then
			return ""
		end

		return input:upper():gsub(" ", "_"):gsub("'", ""):gsub(":", ""):gsub("-", "_"):gsub("%(", ""):gsub("%)", "")
	end

	function addon:DumpZones(input)
		output:Clear()

		if type(input) == "number" then
			local zone_name = _G.GetMapNameByID(input)

			if zone_name then
				output:AddLine(("%s = _G.GetMapNameByID(%d),"):format(TableKeyFormat(zone_name), input))
			end
		else
			for index = 1, 100000 do
				local zone_name = _G.GetMapNameByID(index)

				if zone_name and zone_name:lower():find(input:lower()) then
					output:AddLine(("%s = _G.GetMapNameByID(%d),"):format(TableKeyFormat(zone_name), index))
				end
			end
		end
		output:Display()
	end

	function addon:DumpReps()
		output:Clear()

		for index = 1, 1500 do
			local rep_name = _G.GetFactionInfoByID(index)

			if rep_name and private.FACTION_STRINGS[index] then
				output:AddLine(("[\"%s\"] = _G.GetFactionInfoByID(%d),"):format(TableKeyFormat(rep_name), index))
			end
		end
		output:Display()
	end

--[=[
		private.ZONE_NAME_LIST = {}

		local old_GetMapNameByID = _G.GetMapNameByID
		local function My_GetMapNameByID(id_num)
			if not id_num then
				return
			end
			local Z = private.ZONE_NAME_LIST
			local name = old_GetMapNameByID(id_num)

			if not name then
				return
			end
			Z[name] = id_num
			return name
		end
		_G.GetMapNameByID = My_GetMapNameByID

	function addon:DumpCapturedZones()
		table.wipe(output)
		TextDump:AddLine("private.ZONE_NAMES = {")
		local sorted_zones = {}
		for name, idnum in pairs(private.ZONE_NAME_LIST) do
			sorted_zones[#sorted_zones + 1] = name
		end
		table.sort(sorted_zones, function(a, b)
			return private.ZONE_NAME_LIST[a] < private.ZONE_NAME_LIST[b]
		end)

		for index = 1, #sorted_zones do
			local zone_id = private.ZONE_NAME_LIST[sorted_zones[index]]
			TextDump:AddLine(("%s = _G.GetMapNameByID(%d),"):format(TableKeyFormat(sorted_zones[index]), zone_id))
		end
		TextDump:AddLine("}\n")
		TextDump:Display()
	end
--]=]

	function addon:DumpBossIDs(name)
		output:Clear()

		for index = 1, 10000 do
			local boss_name = _G.EJ_GetEncounterInfo(index)

			if boss_name and boss_name:lower():find(name:lower()) then
				output:AddLine(("%s = _G.EJ_GetEncounterInfo(%d),"):format(TableKeyFormat(boss_name), index))
			end
		end
		output:Display()
	end

	-------------------------------------------------------------------------------
	-- Miscellaneous utilities
	-------------------------------------------------------------------------------
	local function find_empties(acquire_type_id)
		local acquire_type = private.ACQUIRE_TYPES_BY_ID[acquire_type_id]
		local count

		for unit_id, unit in acquire_type:EntityPairs() do
			count = 0

			if unit.item_list then
				for recipe_id in pairs(unit.item_list) do
					count = count + 1
				end
			end

			if count == 0 then
				output:AddLine(("* %s %s (%s) has no recipes."):format(acquire_type:Name(), unit.name or _G.UNKNOWN, unit_id))
			end
		end
	end

	function addon:ShowEmptySources()
		private.LoadAllRecipes()
		output:Clear()

		find_empties(private.ACQUIRE_TYPE_IDS.TRAINER)
		find_empties(private.ACQUIRE_TYPE_IDS.VENDOR)
		find_empties(private.ACQUIRE_TYPE_IDS.MOB_DROP)
		find_empties(private.ACQUIRE_TYPE_IDS.QUEST)
		find_empties(private.ACQUIRE_TYPE_IDS.CUSTOM)
		find_empties(private.ACQUIRE_TYPE_IDS.DISCOVERY)
		find_empties(private.ACQUIRE_TYPE_IDS.WORLD_EVENTS)

		if output:Lines() == 0 then
			output:AddLine("Nothing to display.")
		end

		output:Display()
	end
end -- do
--@end-debug@]===]
