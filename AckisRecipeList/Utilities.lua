-----------------------------------------------------------------------
-- Upvalued Lua API. 
-----------------------------------------------------------------------
local _G = getfenv(0)

local tonumber = _G.tonumber

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub

local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local BFAC = LibStub("LibBabble-Faction-3.0"):GetLookupTable()

-----------------------------------------------------------------------
-- Methods.
-----------------------------------------------------------------------
function private.SetTextColor(color_code, text)
	return ("|cff%s%s|r"):format(color_code or "ffffff", text)
end

local NO_LOCATION_LISTS

function private:AddListEntry(lookup_list, identifier, name, location, coord_x, coord_y, faction)
	if lookup_list[identifier] then
		addon:Debug("Duplicate lookup: %s - %s.", identifier, name)
		return
	end

	local entry = {
		name = name,
		location = location,
		faction = faction,
	}
	lookup_list[identifier] = entry

	if coord_x and coord_y then
		lookup_list[identifier].coord_x = coord_x
		lookup_list[identifier].coord_y = coord_y
	end

	--[===[@alpha@
	if not NO_LOCATION_LISTS then
		NO_LOCATION_LISTS = {
			[self.custom_list] = true,
			[self.discovery_list] = true,
			[self.reputation_list] = true,
		}
	end

	if not location and not NO_LOCATION_LISTS[lookup_list] then
		addon:Debug("Lookup ID: %s (%s) has an unknown location.", identifier, lookup_list[identifier].name or _G.UNKNOWN)
	end

	if faction and lookup_list == self.mob_list then
		addon:Debug("Mob %d (%s) has been assigned to faction %s.", identifier, name, lookup_list[identifier].faction)
	end
	--@end-alpha@]===]
	return entry
end

function private.ItemLinkToID(item_link)
	if not item_link then
		return
	end

	local id = item_link:match("item:(%d+)")

	if not id then
		return
	end
	return tonumber(id)
end

-- This wrapper exists primarily because Blizzard keeps changing how NPC ID numbers are extracted from GUIDs, and fixing it in one place is less error-prone.
function private.MobGUIDToIDNum(guid)
	return tonumber(guid:sub(-12,-9), 16)
end
