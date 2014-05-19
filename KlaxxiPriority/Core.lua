-- ---------------------------------------------------------------------------
local addonName, addon = ...
LibStub("AceAddon-3.0"):NewAddon(addon, addonName,
                                 "AceEvent-3.0", "AceTimer-3.0")
-- ---------------------------------------------------------------------------
-- local funcions
-- ---------------------------------------------------------------------------
local function ReplaceIcons(message)
    local term
    for tag in string.gmatch(message, "%b{}") do
        term = strlower(string.gsub(tag, "[{}]", ""))
        if (ICON_TAG_LIST[term] and ICON_LIST[ICON_TAG_LIST[term]]) then
            message = string.gsub(message, tag,
                                  ICON_LIST[ICON_TAG_LIST[term]] .. "0|t")
        end
    end
    return message
end

local function InCombat()
    return UnitAffectingCombat("player")
end

local function mark_boss(boss_name, rt)
    if not boss_name then return end    
    local unit = false
    for i = 1, 4, 1 do        
        if UnitName("boss" .. tostring(i)) == boss_name then
            unit = "boss" .. tostring(i)
            break
        end
    end
    if unit then
        SetRaidTarget(unit, rt)
        return true
    else
        return false
    end
end
-- ---------------------------------------------------------------------------
-- Addon methods
-- ---------------------------------------------------------------------------
function addon:OnInitialize()
    self:SetupDB()
    self:SetupOptions()
    self:SetEnabledState(self.db.global.enabled)
    self:ResetState()
end

function addon:OnEnable()    
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")    
end

function addon:ResetState()
    self.klaxxi_state = 0
    self.on_klaxxi_combat = false
    self.tries_rt = 0
end

function addon:SetRaidIcons()
    local i = self.klaxxi_state
    local klaxxi_to_kill = self:GetKlaxxi(i)
    if not mark_boss(klaxxi_to_kill, 8) then
        self.tries_rt = self.tries_rt + 1
        if self.tries_rt < 10 then
            self:ScheduleTimer("SetRaidIcons", 1)
        end
    end
    
    if i >= 9 then return end
    
    local next_klaxxi = self:GetKlaxxi(i+1)
    if not mark_boss(next_klaxxi, 7) then
        self.tries_rt = self.tries_rt + 1
        if self.tries_rt < 10 then
            self:ScheduleTimer("SetRaidIcons", 1)
        end
    end    
end

function addon:SayMessage(i)
    self:PrintMessage(self.db.global.messages[tostring(i)])
end

function addon:COMBAT_LOG_EVENT_UNFILTERED(_, _, event, _, _, sourceName, _, _, _, destName, _, _)    
    if not InCombat() then        
        self:ResetState()        
        return
    elseif not self.on_klaxxi_combat then        
        self.on_klaxxi_combat = self:IsKlaxxi(sourceName)
        if not on_klaxxi_combat then
            return
        end
    end
    
    local requires_update = false

    if self.klaxxi_state == 0 then
        -- initial marks
        self.klaxxi_state = 1
        requires_update = true
    elseif event == "UNIT_DIED" and self:IsKlaxxi(destName) then
        -- TODO Check we've killed the one we are suppose to
        -- what should we do if killed the wrong one?
        self.klaxxi_state = self.klaxxi_state + 1
        requires_update = true
    end

    if requires_update then
        self.tries_rt = 0
        self:SetRaidIcons()
        self:SayMessage(self.klaxxi_state)
    end
end

function addon:PrintMessage(message)
    if not message then return end
    local announceSettings = self.db.global.announces
    if announceSettings.yell then
        SendChatMessage(message, "YELL")
    end
    if announceSettings.raid then
        SendChatMessage(message, "RAID")
    end
    if announceSettings.raidWarning then
        if UnitIsRaidOfficer("player") or UnitIsGroupLeader() then
            SendChatMessage(message, "RAID_WARNING")
        end
    end
    if announceSettings.privateRaidWarning then
        RaidNotice_AddMessage(RaidWarningFrame, ReplaceIcons(message),
                              ChatTypeInfo["RAID_WARNING"])
        PlaySoundFile("Sound\\Interface\\RaidWarning.wav")
    end
    if announceSettings.privateChatMessage then
        print(ReplaceIcons(message))
    end
end
