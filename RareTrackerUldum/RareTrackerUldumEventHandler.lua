-- Redefine often used functions locally.
local print = print

-- Redefine often used variables locally.
local C_MapExplorationInfo = C_MapExplorationInfo
local string = string

-- ####################################################################
-- ##                      Localization Support                      ##
-- ####################################################################

-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTrackerUldum", true)

-- ####################################################################
-- ##                         Event Handlers                         ##
-- ####################################################################

-- Check if the assault id has changed.
function RTU:CheckForAssaultIdChange()
    local map_texture = C_MapExplorationInfo.GetExploredMapTextures(self.parent_zone)
    if map_texture then
        local new_assault_id = map_texture[1].fileDataIDs[1]
        if self.assault_id ~= new_assault_id then
            self.assault_id = new_assault_id
            self:ReorganizeRareTableFrame(self.entities_frame)
        end
    end
end

-- Check whether the user has changed shards and proceed accordingly.
function RTU:CheckForShardChange(zone_uid)
	local has_changed = false

	if self.current_shard_id ~= zone_uid and zone_uid ~= nil then
		print(string.format(L["<%s> Moving to shard "], self.addon_code)..(zone_uid + 42)..".")
		self:UpdateShardNumber(zone_uid)
		has_changed = true
		
		if self.current_shard_id == nil then
			-- Register your arrival on the given shard.
			self:RegisterArrival(zone_uid)
		else
			-- Move from one shard to another.
			self:ChangeShard(self.current_shard_id, zone_uid)
		end
		self.current_shard_id = zone_uid
	end
        
    -- Take the opportunity to check for assault updates as well.
    self:CheckForAssaultIdChange()
	
	return has_changed
end