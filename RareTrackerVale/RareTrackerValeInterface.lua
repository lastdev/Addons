-- Width and height variables used to customize the window.
local entity_name_width = 208
local entity_status_width = 50
local frame_padding = 4
local favorite_rares_width = 10
local shard_id_frame_height = 16

-- ####################################################################
-- ##                      Localization Support                      ##
-- ####################################################################

-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTrackerVale", true)

-- ####################################################################
-- ##                              GUI                               ##
-- ####################################################################

function RTV:StartInterface()
    -- Reset the data, since we cannot guarantee its correctness.
    self.is_alive = {}
    self.current_health = {}
    self.last_recorded_death = {}
    self.current_coordinates = {}
    self.reported_spawn_uids = {}
    self.reported_vignettes = {}
    self.waypoints = {}
    self.current_shard_id = nil
    self:UpdateShardNumber(nil)
    self:UpdateAllDailyKillMarks()
    self:RegisterEvents()
    
    -- Attempt to register a prefix for the addon. All modules are given their own code for clarity.
    if C_ChatInfo.RegisterAddonMessagePrefix(self.addon_code) ~= true then
        print(string.format(
            L["<%s> Failed to register AddonPrefix '%s'. %s will not function properly."],
            self.addon_code, self.addon_code, self.addon_code
        ))
    end
    
    -- Do an assault id check.
    self:CheckForAssaultIdChange()
    
    -- Show the window if it is not hidden.
    if not RT.db.global.window.hide then
        self:Show()
    end
end

-- Reorganize the entries within the rare table.
function RTV:ReorganizeRareTableFrame(f)
    -- Filter out the rares that are not part of the current assault.
    local assault_rares = self.rare_ids_set
    if self.assault_id ~= 0 then
        assault_rares = self.assault_rare_ids[self.assault_id]
    end
    
	-- How many ignored rares do we have?
	local n = 0
    for _, npc_id in pairs(self.rare_ids) do
        if self.db.global.ignore_rares[npc_id] or assault_rares[npc_id] == nil then
            n = n + 1
        end
    end
	
	-- Resize all the frames.
	self:SetSize(
		entity_name_width + entity_status_width + 2 * favorite_rares_width + 5 * frame_padding,
		shard_id_frame_height + 3 * frame_padding + (#self.rare_ids - n) * 12 + 8
	)
	f:SetSize(
		entity_name_width + entity_status_width + 2 * favorite_rares_width + 3 * frame_padding,
		(#self.rare_ids - n) * 12 + 8
	)
	f.entity_name_backdrop:SetSize(entity_name_width, f:GetHeight())
	f.entity_status_backdrop:SetSize(entity_status_width, f:GetHeight())
	
	-- Give all of the table entries their new positions.
	local i = 1
	self.db.global.rare_ordering:ForEach(
		function(npc_id, _)
			if self.db.global.ignore_rares[npc_id] or assault_rares[npc_id] == nil then
				f.entities[npc_id]:Hide()
			else
				f.entities[npc_id]:SetPoint("TOPLEFT", f, 0, -(i - 1) * 12 - 5)
				f.entities[npc_id]:Show()
				i = i + 1
			end
		end
	)
end