-- Redefine often used functions locally.
local UnitGUID = UnitGUID
local strsplit = strsplit
local UnitBuff = UnitBuff
local UnitHealth = UnitHealth
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local C_VignetteInfo = C_VignetteInfo
local GetServerTime = GetServerTime
local LinkedSet = LinkedSet
local CreateFrame = CreateFrame
local GetChannelList = GetChannelList

-- Redefine often used variables locally.
local C_Map = C_Map
local COMBATLOG_OBJECT_TYPE_GUARDIAN = COMBATLOG_OBJECT_TYPE_GUARDIAN
local COMBATLOG_OBJECT_TYPE_PET = COMBATLOG_OBJECT_TYPE_PET
local COMBATLOG_OBJECT_TYPE_OBJECT = COMBATLOG_OBJECT_TYPE_OBJECT
local UIParent = UIParent

-- ####################################################################
-- ##                      Localization Support                      ##
-- ####################################################################

-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTrackerMechagon", true)

-- ####################################################################
-- ##                         Event Handlers                         ##
-- ####################################################################

-- Listen to a given set of events and handle them accordingly.
function RTM:OnEvent(event, ...)
	if event == "PLAYER_TARGET_CHANGED" then
		self:OnTargetChanged()
	elseif event == "UNIT_HEALTH" and RT.chat_frame_loaded then
		self:OnUnitHealth(...)
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" and RT.chat_frame_loaded then
		self:OnCombatLogEvent()
    elseif event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED" then
        self:OnZoneTransition()
	elseif event == "CHAT_MSG_ADDON" then
		self:OnChatMsgAddon(...)
	elseif event == "VIGNETTE_MINIMAP_UPDATED" and RT.chat_frame_loaded then
		self:OnVignetteMinimapUpdated(...)
	elseif event == "CHAT_MSG_MONSTER_EMOTE" and RT.chat_frame_loaded then
		self:OnChatMsgMonsterEmote(...)
	elseif event == "CHAT_MSG_MONSTER_YELL" and RT.chat_frame_loaded then
		self:OnChatMsgMonsterYell(...)
	elseif event == "ADDON_LOADED" then
		self:OnAddonLoaded()
	elseif event == "PLAYER_LOGOUT" then
		self:OnPlayerLogout()
	end
end

-- Called when a monster or entity does a self emote.
function RTM:OnChatMsgMonsterEmote(...)
    local text = select(1, ...)
    
    -- Check if any of the drill rig designations is contained in the broadcast text.
    for designation, npc_id in pairs(self.drill_announcing_rares) do
        if text:find(designation) then
            -- We found a match.
            self.is_alive[npc_id] = GetServerTime()
            self.current_coordinates[npc_id] = self.rare_coordinates[npc_id]
            self:PlaySoundNotification(npc_id, npc_id)
            return
        end
    end
end

-- Register to the events required for the addon to function properly.
function RTM:RegisterEvents()
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterEvent("UNIT_HEALTH")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("CHAT_MSG_ADDON")
    self:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
    self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
    self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
end

-- Unregister from the events, to disable the tracking functionality.
function RTM:UnregisterEvents()
    self:UnregisterEvent("PLAYER_TARGET_CHANGED")
    self:UnregisterEvent("UNIT_HEALTH")
    self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:UnregisterEvent("CHAT_MSG_ADDON")
    self:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
    self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
    self:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
end