local DelveBuddy = LibStub("AceAddon-3.0"):NewAddon("DelveBuddy", "AceConsole-3.0", "AceEvent-3.0", "AceBucket-3.0")

function DelveBuddy:OnInitialize()
    -- Initialize DB
    DelveBuddyDB = DelveBuddyDB or {}
    DelveBuddyDB.global = DelveBuddyDB.global or {}
    DelveBuddyDB.charData = DelveBuddyDB.charData or {}
    local g = DelveBuddyDB.global
    if g.debugLogging == nil then g.debugLogging = false end
    if g.tooltipScale == nil then g.tooltipScale = 1.0 end
    self.db = DelveBuddyDB

    -- LibDBIcon
    DelveBuddyDB.global.minimap = DelveBuddyDB.global.minimap or {}
    self:InitMinimapIcon()

    -- Waypoints
    DelveBuddyDB.global.waypoints = DelveBuddyDB.global.waypoints or {}
    if DelveBuddyDB.global.waypoints.useBlizzard == nil then DelveBuddyDB.global.waypoints.useBlizzard = true end
    if DelveBuddyDB.global.waypoints.useTomTom == nil then DelveBuddyDB.global.waypoints.useTomTom = false end

    -- Reminders
    DelveBuddyDB.global.reminders = DelveBuddyDB.global.reminders or {}
    if DelveBuddyDB.global.reminders.cofferKey == nil then DelveBuddyDB.global.reminders.cofferKey = true end
    if DelveBuddyDB.global.reminders.delversBounty == nil then DelveBuddyDB.global.reminders.delversBounty = true end

    -- Slash commands
    self:RegisterChatCommand("delvebuddy", "SlashCommand")
    self:RegisterChatCommand("db", "SlashCommand")

    -- Batch-throttle the rapid‐fire data events into one OnDataChanged call every 2 seconds
    self:RegisterBucketEvent({
        "QUEST_LOG_UPDATE",
        "CURRENCY_DISPLAY_UPDATE",
        "WEEKLY_REWARDS_UPDATE",
    }, 2, "OnDataChanged")

    -- Clean up after weekly reset, if appropriate
    self:CleanupStaleCharacters()
end

function DelveBuddy:OnEnable()
    self:RegisterBucketEvent({
        "PLAYER_ENTERING_WORLD",
        "ZONE_CHANGED_NEW_AREA",
        "BAG_UPDATE_DELAYED",
    }, 1, "OnBountyCheck")

    self:CollectDelveData()
end

-- Helper: parse on/off/true/false/1/0
local function StringToBool(v)
    v = tostring(v or ""):lower()
    if v == "on" or v == "true" or v == "1" then return true end
    if v == "off" or v == "false" or v == "0" then return false end
    return nil
end

function DelveBuddy:SlashCommand(input)
    local cmd, arg = input:match("^(%S*)%s*(.*)$")
    cmd = (cmd or ""):lower()

    if cmd == "debuglogging" then
        local onoff = StringToBool(arg)
        if onoff == nil then
            self:Print("Usage: /db debugLogging <on||off>")
        else
            self.db.global.debugLogging = onoff
            self:Print("Debug logging " .. (onoff and "enabled" or "disabled"))
        end
    elseif cmd == "scale" then
        local v = tonumber(arg)
        if v and v >= 0.75 and v <= 2.0 then
            self.db.global.tooltipScale = v
            -- apply immediately if our LibQTip tips are open
            if self.charTip then self.charTip:SetScale(v) end
            if self.delveTip then self.delveTip:SetScale(v) end
            if self.worldTip then self.worldTip:SetScale(v) end
            self:Print(("Tooltip scale set to %d%%"):format(math.floor(v*100+0.5)))
        else
            self:Print("Usage: /db scale <0.75-2.0>")
        end
    elseif cmd == "reminders" then
        local which, val = arg:match("^(%S+)%s*(%S*)$")
        which = (which or ""):lower()
        local onoff = StringToBool(val)
        if which == "coffer" and onoff ~= nil then
            self.db.global.reminders.cofferKey = onoff
            self:Print("Reminders: Coffer Keys " .. (onoff and "ON" or "OFF"))
        elseif which == "bounty" and onoff ~= nil then
            self.db.global.reminders.delversBounty = onoff
            self:Print("Reminders: Delver's Bounty " .. (onoff and "ON" or "OFF"))
        else
            self:Print("Usage: /db reminders <coffer||bounty> <on||off>")
        end
    elseif cmd == "waypoints" then
        local choice = (arg or ""):lower()
        if choice == "blizzard" then
            self.db.global.waypoints.useBlizzard = true
            self.db.global.waypoints.useTomTom = false
            self:Print("Waypoints: Blizzard only")
        elseif choice == "tomtom" then
            self.db.global.waypoints.useBlizzard = false
            self.db.global.waypoints.useTomTom = true
            self:Print("Waypoints: TomTom only")
        elseif choice == "both" then
            self.db.global.waypoints.useBlizzard = true
            self.db.global.waypoints.useTomTom = true
            self:Print("Waypoints: Blizzard + TomTom")
        else
            self:Print("Usage: /db waypoints <blizzard||tomtom||both>")
        end
    elseif cmd == "minimap" or cmd == "mm" then
        local LDBIcon = LibStub("LibDBIcon-1.0", true)
        if not LDBIcon then
            self:Print("LibDBIcon-1.0 not loaded.")
        else
            self.db.global.minimap.hide = not self.db.global.minimap.hide
            if self.db.global.minimap.hide then
                LDBIcon:Hide("DelveBuddy")
                self:Print("Minimap icon hidden.")
            else
                LDBIcon:Show("DelveBuddy")
                self:Print("Minimap icon shown.")
            end
        end
    elseif cmd == "debuginfo" or cmd == "di" then
        self:Print("Debug Info:")
        self:Print("Is in delve: " .. tostring(self:IsDelveInProgress()))
        self:Print("Is in bountiful delve: " .. tostring(self:IsInBountifulDelve()))
        self:Print("Is delve complete: " .. tostring(self:IsDelveComplete()))
        local cur, max = self:GetGildedStashCounts()
        self:Print("Gilded stash count: " .. tostring(cur) .. "/" .. tostring(max))
        self:Print("Is player timerunning: " .. tostring(self:IsPlayerTimerunning()))
    else
        self:Print("Available commands:")
        self:Print("/db debugLogging <on||off> -- Enable/disable debug logging")
        self:Print("/db scale <0.75-2.0> -- Set tooltip scale")
        self:Print("/db reminders <coffer||bounty> <on||off> -- Enable/disable reminders")
        self:Print("/db minimap -- Toggle minimap icon")
        self:Print("/db waypoints <blizzard||tomtom||both> -- Set waypoint providers")
    end
end

function DelveBuddy:GetDelveStoryVariant(zoneID, poiID)
    local info = C_AreaPoiInfo.GetAreaPOIInfo(zoneID, poiID)

    if info and info.tooltipWidgetSet then
        local tooltipWidgets = C_UIWidgetManager.GetAllWidgetsBySetID(info.tooltipWidgetSet)
        if tooltipWidgets then
            for _, widgetInfo in ipairs(tooltipWidgets) do
                if widgetInfo.widgetType == Enum.UIWidgetVisualizationType.TextWithState then
                    local visInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(widgetInfo.widgetID)
                    if visInfo and visInfo.orderIndex == 0 then
                        return visInfo.text
                    end
                end
            end
        end
    end

    return ""
end

function DelveBuddy:ShouldShowKeyWarning()
    local result =
        self.db.global.reminders.cofferKey
        and self:IsInBountifulDelve()
        and not self:IsDelveComplete()
        and self:GetKeyCount() == 0

    self:Log("ShouldShowKeyWarning: %s", tostring(result))
    return result
end

function DelveBuddy:ShouldShowBounty()
    local result =
        self.db.global.reminders.delversBounty
        and self:IsDelveInProgress()
        and not self:IsDelveComplete()
        and self:HasDelversBountyItem()
        and not self:HasDelversBountyBuff()

    self:Log("ShouldShowBounty: %s", tostring(result))
    return result
end

function DelveBuddy:GetCharacterKey()
    local name = UnitName("player")
    local realm = GetRealmName():gsub("%s+", "") -- remove spaces from realm
    return name .. "-" .. realm
end

function DelveBuddy:OnDataChanged()
    self:CollectDelveData()
end

function DelveBuddy:OnBountyCheck()
    self:Log("OnBountyCheck")
    C_Timer.After(1, function()
        if self:ShouldShowKeyWarning() then
            self:ShowKeyWarning()
        elseif self:ShouldShowBounty() then
            self:StartBountyFlashing()
        end
    end)
end

function DelveBuddy:CollectDelveData()
    self:Log("CollectDelveData")

    -- Skip collecting for low-level characters (<80).
    local playerLevel = UnitLevel("player")
    local minLevel = self.IDS.CONST.MIN_BOUNTIFUL_DELVE_LEVEL
    if playerLevel < minLevel then
        self:Log("Player level %d < %d, skipping data collect", playerLevel, minLevel)
        return
    end

    -- Skip collecting for Timerunning characters.
    if self:IsPlayerTimerunning() then
        self:Log("Player is timerunner, skipping data collection")
        return
    end

    local data = {}

    local IDS = DelveBuddy.IDS

    -- Existing data for non-destructive fields
    local charKey = self:GetCharacterKey()
    local prevData = self.db.charData and self.db.charData[charKey] or nil

    -- Class
    data.class = select(2, UnitClass("player"))

    -- Shards earned (this week)
    local shardsEarned = 0
    for _, questID in ipairs(IDS.Quest.ShardsEarned) do
        shardsEarned = shardsEarned + (C_QuestLog.IsQuestFlaggedCompleted(questID) and 1 or 0)
    end
    data.shardsEarned = shardsEarned * 50

    -- Shards owned
    data.shardsOwned = self:GetShardCount()

    -- Keys earned (this week)
    local keysEarned = 0
    for _, questID in ipairs(IDS.Quest.KeyEarned) do
        keysEarned = keysEarned + (C_QuestLog.IsQuestFlaggedCompleted(questID) and 1 or 0)
    end
    data.keysEarned = keysEarned

    -- Keys owned
    data.keysOwned = self:GetKeyCount()

    -- Gilded stashes looted
    -- If current count is unknown, don't overwrite previous known value.
    do
        local cur, _max = self:GetGildedStashCounts()
        local UNKNOWN = self.IDS.CONST.UNKNOWN_GILDED_STASH_COUNT
        local prior = prevData and tonumber(prevData.gildedStashes) or nil
        if cur == UNKNOWN and prior and prior ~= UNKNOWN then
            data.gildedStashes = prior
        else
            data.gildedStashes = cur
        end
    end

    -- Have bounty / looted bounty
    data.hasBounty = C_Item.GetItemCount(IDS.Item.DelversBounty) > 0
    data.bountyLooted = C_QuestLog.IsQuestFlaggedCompleted(IDS.Quest.BountyLooted) or false

    -- Vault rewards
    data.vaultRewards = {}
    for _, a in ipairs(C_WeeklyRewards.GetActivities(IDS.Activity.World)) do
        table.insert(data.vaultRewards, {
            progress = a.progress,
            threshold = a.threshold,
            level = a.level
        })
    end

    -- Last login (used for data reset on reset day)
    data.lastLogin = GetServerTime()

    -- Save to DB under character key
    self.db.charData[charKey] = data

    if self.db.global.debugLogging then
        -- Too spammy
        -- DevTools_Dump(data)
    end
end

function DelveBuddy:GetGildedStashCounts()
    local UNKNOWN  = self.IDS.CONST.UNKNOWN_GILDED_STASH_COUNT
    local fallback = self.IDS.CONST.MAX_WEEKLY_GILDED_STASHES

    local cur, max = UNKNOWN, fallback

    for _, poiList in pairs(self.IDS.DelvePois) do
        for _, poi in ipairs(poiList) do
            local widget = poi.widgetID
               and C_UIWidgetManager.GetSpellDisplayVisualizationInfo(poi.widgetID)
            local tooltip = widget and widget.spellInfo and widget.spellInfo.tooltip
            if tooltip then
                local c, m = tooltip:match("(%d+)%s*/%s*(%d+)")
                if c then
                    cur = tonumber(c) or UNKNOWN
                    max = tonumber(m) or fallback
                    return cur, max -- first match wins
                end
            end
        end
    end

    return cur, max
end

function DelveBuddy:FlashDelversBounty()
    local itemName = C_Item.GetItemInfo(DelveBuddy.IDS.Item.DelversBounty)
    if not itemName then return end

    for i = 1, 12 do
        for _, prefix in ipairs({
            "ActionButton",       -- Main bar
            "MultiBarBottomLeftButton", -- Bar 2
            "MultiBarBottomRightButton", -- Bar 3
            "MultiBarRightButton", -- Bar 4
            "MultiBarLeftButton", -- Bar 5
            "MultiBar5Button",    -- Bar 6 (in newer UIs)
            "MultiBar6Button",    -- Bar 7
            "MultiBar7Button",    -- Bar 8
        }) do
            local btn = _G[prefix .. i]
            if btn and btn.action then
                local actionType, id = GetActionInfo(btn.action)
                if actionType == "item" then
                    local itemLink = GetActionText(btn.action) or C_Item.GetItemInfo(id)
                    if itemLink == itemName then
                        ActionButton_ShowOverlayGlow(btn)
                        C_Timer.After(10, function()
                            ActionButton_HideOverlayGlow(btn)
                        end)
                        return
                    end
                end
            end
        end
    end
end

function DelveBuddy:IsDelveInProgress()
    return C_PartyInfo.IsDelveInProgress()
end

function DelveBuddy:HasDelversBountyItem()
    local result = false

    result = C_Item.GetItemCount(DelveBuddy.IDS.Item.DelversBounty, false) > 0

    self:Log("HasDelversBountyItem: (%s)", tostring(result))
    return result
end

function DelveBuddy:HasShriekingQuartzItem()
    local result = false

    result = C_Item.GetItemCount(DelveBuddy.IDS.Item.ShriekingQuartz, false) > 0

    self:Log("HasShriekingQuartzItem: (%s)", tostring(result))
    return result
end


function DelveBuddy:HasDelversBountyBuff()
    local result = false

    local buffIDs = self.IDS.Spell.DelversBounty
    local i = 1
    while true do
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i)
        if not aura then break end
        for _, id in ipairs(buffIDs) do
            if aura.spellId == id then
                result = true
                break
            end
        end
        i = i + 1
    end

    self:Log("HasDelversBountyBuff: (%s)", tostring(result))
    return result
end

local flashTicker = nil

function DelveBuddy:StartBountyFlashing()
    self:FlashDelversBounty()
    self:ShowBountyNotice()

    if flashTicker then
        flashTicker:Cancel()
    end

    flashTicker = C_Timer.NewTicker(60, function()
        if self:ShouldShowBounty() then
            self:FlashDelversBounty()
            self:ShowBountyNotice()
        else
            flashTicker:Cancel()
            flashTicker = nil
        end
    end)
end

function DelveBuddy:ShowKeyWarning()
    self:DisplayRaidWarning("|cffff4444DelveBuddy: In a bountiful delve, with no Restored Coffer Keys!|r", true)
end

function DelveBuddy:ShowBountyNotice()
    self:DisplayRaidWarning("|cffffd700Delver's Bounty available!|r", false)
end

function DelveBuddy:DisplayRaidWarning(msg, playSound)
    if RaidNotice_AddMessage and RaidWarningFrame and ChatTypeInfo and ChatTypeInfo["RAID_WARNING"] then
        RaidNotice_AddMessage(RaidWarningFrame, msg, ChatTypeInfo["RAID_WARNING"])
    elseif UIErrorsFrame then
        UIErrorsFrame:AddMessage(msg, 1, 0.1, 0.1, 53, 5)
    else
        self:Print(msg)
    end

    if playSound and PlaySound then
        PlaySound(SOUNDKIT.RAID_WARNING, "Master")
    end
end

function DelveBuddy:HasWeeklyResetOccurred(lastLogin)
    if not lastLogin then return true end

    local now = GetServerTime()
    local secondsUntilNextReset = C_DateAndTime.GetSecondsUntilWeeklyReset()
    self:Log("Next weekly reset: %s hours", tostring(secondsUntilNextReset / 60 / 60))
    local nextReset = now + secondsUntilNextReset
    local lastReset = nextReset - 7 * 24 * 60 * 60 -- subtract 1 week

    return lastLogin < lastReset
end

function DelveBuddy:CleanupStaleCharacters()
    self:Log("CleanupStaleCharacters")

    for charKey, data in pairs(self.db.charData) do
        if type(data) == "table" and self:HasWeeklyResetOccurred(data.lastLogin) then
            self:Log("Resetting weekly data for", charKey)
            data.shardsEarned = 0
            data.keysEarned = 0
            data.gildedStashes = 0
            data.bountyLooted = false
            -- data.vaultRewards = {} keep vaultRewards
            -- TODO some indication of when you have a reward in the vault?
            -- keysOwned, shardsOwned, hasBounty are preserved
        end
    end
end

function DelveBuddy:Log(fmt, ...)
    if not self.db.global.debugLogging then return end
    self:Print(fmt:format(...))
end

function DelveBuddy:IsDelveComplete()
    return C_PartyInfo.IsDelveComplete()
end

function DelveBuddy:ClassColoredName(name, class)
    local classColor = RAID_CLASS_COLORS[class] or {["r"] = 1, ["g"] = 1, ["b"] = 0}
    return format("|cff%02x%02x%02x%s|r", classColor["r"] * 255, classColor["g"] * 255, classColor["b"] * 255, name)
end

function DelveBuddy:GetKeyCount()
    local c = C_CurrencyInfo.GetCurrencyInfo(self.IDS.Currency.RestoredCofferKey)
    return c and c.quantity or 0
end

function DelveBuddy:GetShardCount()
    return C_Item.GetItemCount(self.IDS.Item.CofferKeyShard)
end

function DelveBuddy:GetDelves()
    -- Timerunners can't do delves.
    if self:IsPlayerTimerunning() then return {} end

    local delves = {}

    local delvePois = self.IDS.DelvePois
    for zoneID, poiList in pairs(delvePois) do
        for _, poi in ipairs(poiList) do
            local info = C_AreaPoiInfo.GetAreaPOIInfo(zoneID, poi.id)
            if info then
                self:Log("Found poi %s in zone %s", tostring(poi.id), tostring(zoneID))
                self:Log("name= %s", info.atlasName)
            end

            if info and info.atlasName == "delves-bountiful" then
                local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(info.iconWidgetSet)

                delves[poi.id] = {
                    name        = info.name,
                    zoneID      = zoneID,
                    x           = poi.x,
                    y           = poi.y,
                    areaPoiID   = info.areaPoiID,
                }
            end
        end
    end

    -- Spammy
    -- self:Print("Dumping Delves")
    -- DevTools_Dump(Delves)

    return delves
end

function DelveBuddy:GetWorldSoulMemories()
    local memories = {}

    for _, zoneID in pairs(self.Zone) do
        local pois = C_AreaPoiInfo.GetEventsForMap(zoneID) or {}
        for _, poiID in ipairs(pois) do
            local poi = C_AreaPoiInfo.GetAreaPOIInfo(zoneID, poiID)
            if poi and poi.atlasName == "UI-EventPoi-WorldSoulMemory" then
                local name = (poi.name and (poi.name:match(":%s*(.+)") or poi.name)) or "World Soul Memory"
                memories[poiID] = {
                    name      = name,
                    zoneID    = zoneID,
                    x         = poi.position and poi.position.x * 100 or 0,
                    y         = poi.position and poi.position.y * 100 or 0,
                    areaPoiID = poi.areaPoiID,
                }
            end
        end
    end

    return memories
end

-- Only for discovering new delves.
function DelveBuddy:DumpPOIs(mapID)
    if not mapID then
        self:Log("DelveBuddy: No mapID provided.")
        return
    end
    local mapInfo = C_Map.GetMapInfo(mapID)
    self:Log(("DelveBuddy: Dumping POIs for map %d (%s)"):format(mapID, mapInfo and mapInfo.name or "unknown"))

    local poiIDs = C_AreaPoiInfo.GetDelvesForMap(mapID) or {}
    if #poiIDs == 0 then
        self:Log("DelveBuddy: No POIs found on map", mapID)
        return
    end

    for _, poiID in ipairs(poiIDs) do
        local info = C_AreaPoiInfo.GetAreaPOIInfo(mapID, poiID)
        if info then
            self:Log((
                "POI %d: name=%q, atlas=%q, texIdx=%d, x=%.2f, y=%.2f, widgetSet=%s"
            ):format(
                poiID,
                info.name or "",
                info.atlasName or "",
                info.textureIndex or 0,
                (info.x or 0) * 100,
                (info.y or 0) * 100,
                tostring(info.iconWidgetSet)
            ))
        end
    end
end

function DelveBuddy:IsInBountifulDelve()
    if not self:IsDelveInProgress() then return false end
    local mapID = C_Map.GetBestMapForUnit("player")
    local poiID = mapID and self.IDS.DelveMapToPoi[mapID]
    if not poiID then return false end

    -- Ascend to zone map (mapType 3) to query POI
    local zoneMap = mapID
    local info = C_Map.GetMapInfo(zoneMap)
    while info and info.parentMapID and info.mapType ~= 3 do
        zoneMap = info.parentMapID
        info = C_Map.GetMapInfo(zoneMap)
    end

    local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(zoneMap, poiID)
    local bountiful = poiInfo and poiInfo.atlasName == "delves-bountiful" or false

    self:Log("IsInBountifulDelve: map=%s zone=%s poi=%s bountiful=%s",
        tostring(mapID),
        tostring(zoneMap),
        tostring(poiID),
        tostring(bountiful)
    )

    return bountiful
end

function DelveBuddy:IsPlayerTimerunning()
    if C_ChatInfo.IsTimerunningPlayer(UnitGUID("player")) then
        return true
    end

    -- Sometimes the above check erroneously returns false. Fallback to season check.
    local sid = PlayerGetTimerunningSeasonID()
    if sid and sid ~= 0 then
        return true
    end

    return false
end

function DelveBuddy:GetZoneName(uiMapID)
    self._zoneNameCache = self._zoneNameCache or {}
    local name = self._zoneNameCache[uiMapID]
    if not name then
        local info = C_Map.GetMapInfo(uiMapID)
        name = (info and info.name) or ("Map " .. tostring(uiMapID))
        self._zoneNameCache[uiMapID] = name
    end
    return name
end

function DelveBuddy:OpenVaultUI()
    C_AddOns.LoadAddOn("Blizzard_WeeklyRewards")
    WeeklyRewardsFrame:Show()
end

function DelveBuddy:SetWaypoint(poi)
    local usedAny = false

    -- Blizzard waypoint
    if self.db.global.waypoints.useBlizzard then
        if C_Map.CanSetUserWaypointOnMap(poi.zoneID) then
            if poi.areaPoiID then
                C_SuperTrack.SetSuperTrackedMapPin(Enum.SuperTrackingMapPinType.AreaPOI, poi.areaPoiID)
            else
                local point = UiMapPoint.CreateFromCoordinates(poi.zoneID, poi.x / 100, poi.y / 100)
                C_Map.SetUserWaypoint(point)
                C_SuperTrack.SetSuperTrackedUserWaypoint(true)
            end
            self:Print(("Waypoint set to %s"):format(poi.name))
            usedAny = true
        else
            self:Print(("Cannot set waypoint on map %s"):format(poi.zoneID))
        end
    end

    -- TomTom waypoint
    if self.db.global.waypoints.useTomTom then
        local tt = _G.TomTom
        if tt and tt.AddWaypoint then
            tt:AddWaypoint(poi.zoneID, poi.x / 100, poi.y / 100, {
                title = poi.name,
                persistent = false,
                minimap = true,
                world = true,
            })
            self:Print(("TomTom waypoint set to %s"):format(poi.name))
            usedAny = true
        else
            self:Print("TomTom not detected. Enable/install TomTom or disable it in DelveBuddy options.")
        end
    end

    if not usedAny then
        self:Print("No waypoint providers active.")
    end
end
